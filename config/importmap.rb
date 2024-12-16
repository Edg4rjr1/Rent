# config/importmap.rb
pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.js"
pin "controllers", preload: true
pin "bootstrap", to: "bootstrap.bundle.min.js"
pin "rails-ujs", to: "rails-ujs.js", preload: true


