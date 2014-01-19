require 'helper'

class BaseTest < Test::Unit::TestCase
  class ExampleObject < TheWalters::Base
    def self.find(id)
      get_by_id(id)
    end
    def self.api_path; "foo" end
  end

  def test_all_returns_objects
    TheWalters.apikey = 'abc'
    test_faraday = Faraday.new do |builder|
      builder.adapter :test, Faraday::Adapter::Test::Stubs.new do |stub|
        stub.get('/v1/foo') {[ 200, {"content-type" => "application/json"}, '{"Items": [{"id": 1},{"id": 2},{"id": 3}]}' ]}
      end
    end
    ExampleObject.expects(:faraday).returns(test_faraday)
    rows = ExampleObject.all["Items"]
    assert_equal 3, rows.size
    assert_equal ExampleObject, rows.first.class
    assert_equal 1, rows.first.id
    assert_equal 3, rows.last.id
  end

  def test_all_with_params_returns_objects
    TheWalters.apikey = 'abc'
    test_faraday = Faraday.new do |builder|
      builder.adapter :test, Faraday::Adapter::Test::Stubs.new do |stub|
        stub.get('/v1/foo') {[ 200, {"content-type" => "application/json"}, '{"Items": [{"id": 1},{"id": 2}]}' ]}
      end
    end
    ExampleObject.expects(:faraday).returns(test_faraday)
    rows = ExampleObject.all(:pageSize => 2)["Items"]
    assert_equal 2, rows.size
    assert_equal ExampleObject, rows.first.class
    assert_equal 1, rows.first.id
    assert_equal 2, rows.last.id
  end

  def test_find_returns_object
    TheWalters.apikey = 'abc'
    test_faraday = Faraday.new do |builder|
      builder.adapter :test, Faraday::Adapter::Test::Stubs.new do |stub|
        stub.get('/v1/foo/1') {[ 200, {"content-type" => "application/json"}, '{"Data": {"id": 1}}' ]}
      end
    end
    ExampleObject.expects(:faraday).returns(test_faraday)
    row = ExampleObject.find(1)
    assert_equal ExampleObject, row.class
    assert_equal 1, row.id
  end
end


# Live error response
# {"Data":null,"ReturnStatus":false,"ReturnCode":200,"ReturnMessage":["An error occurred while executing the command definition. See the inner exception for details."]
