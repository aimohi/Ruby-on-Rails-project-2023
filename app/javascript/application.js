//=require jquery3
//=require popper
//=require bootstrap-sprockets


import "@hotwired/turbo-rails"
import "controllers"

import { beers } from "custom/utils";

beers();

import { breweries } from "./custom/utils";

breweries();
