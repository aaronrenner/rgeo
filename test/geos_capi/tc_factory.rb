# -----------------------------------------------------------------------------
#
# Tests for the GEOS factory
#
# -----------------------------------------------------------------------------
# Copyright 2010-2012 Daniel Azuma
#
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice,
#   this list of conditions and the following disclaimer.
# * Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
# * Neither the name of the copyright holder, nor the names of any other
#   contributors to this software, may be used to endorse or promote products
#   derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
# -----------------------------------------------------------------------------
;


require 'test/unit'
require 'rgeo'


module RGeo
  module Tests  # :nodoc:
    module GeosCAPI  # :nodoc:

      class TestFactory < ::Test::Unit::TestCase  # :nodoc:


        def setup
          @factory = ::RGeo::Geos.factory(:srid => 4326)
        end


        def test_srid_preserved_through_factory
          geom_ = @factory.point(-10, 20)
          assert_equal(4326, geom_.srid)
          factory_ = geom_.factory
          assert_equal(4326, factory_.srid)
          geom2_ = factory_.point(-20, 25)
          assert_equal(4326, geom2_.srid)
        end


        def test_srid_preserved_through_geom_operations
          geom1_ = @factory.point(-10, 20)
          geom2_ = @factory.point(-20, 25)
          geom3_ = geom1_.union(geom2_)
          assert_equal(4326, geom3_.srid)
          assert_equal(4326, geom3_.geometry_n(0).srid)
          assert_equal(4326, geom3_.geometry_n(1).srid)
        end


        def test_srid_preserved_through_geom_functions
          geom1_ = @factory.point(-10, 20)
          geom2_ = geom1_.boundary
          assert_equal(4326, geom2_.srid)
        end


        def test_srid_preserved_through_dup
          geom1_ = @factory.point(-10, 20)
          geom2_ = geom1_.clone
          assert_equal(4326, geom2_.srid)
        end


      end

    end
  end
end if ::RGeo::Geos.capi_supported?
