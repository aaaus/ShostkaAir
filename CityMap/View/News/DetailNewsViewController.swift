//
//  cityNews.swift
//  CityMap
//
//  Created by Aleksandr Andrusenko on 01.03.2019.
//  Copyright © 2019 it-shark. All rights reserved.
//

import UIKit
import WebKit
//import WordPress

class DetailNewsViewController: UIViewController {
    
    //@IBOutlet weak var newsWebViev: UIWebView!

    @IBOutlet weak var newsWebView: WKWebView!
    // @IBOutlet weak var newsWebView: WKWebView!
    // @IBOutlet weak var newsWebView: WKWebView!
    
    var city: City?
    var urlFromCityDiscription: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
          guard let city = city else {
         return
         }
        urlFromCityDiscription = city.description
        print("city.d \(city.description)")
        self.navigationItem.title = city.name
        
        //self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        loadHtmlCode()
    }
    
    func loadHtmlCode() {
        
        
        let url = URL (string: urlFromCityDiscription)
        let requestObj = URLRequest(url: url!)
        newsWebView.load(requestObj)
      /*  let htmlCode = "<h4 class=\"post-item__title\">1 марта в мире отмечают международный день кошек. Традиционно  в преддверии праздника в фойе библиотеки Толстого открылась выставка &#171;Котомания&#187;. Она проводится в городе уже более 10 лет. В этот раз была представлена 141 работа. Количество участников около 100 человек. <img class=\"alignnone size-full wp-image-20201\" src=\"http://www.shostka-news.com/wp-content/uploads/2019/02/VYFDnoOUbQw.jpg\" alt=\"\" width=\"360\" height=\"320\" srcset=\"http://www.shostka-news.com/wp-content/uploads/2019/02/VYFDnoOUbQw.jpg 1280w, http://www.shostka-news.com/wp-content/uploads/2019/02/VYFDnoOUbQw-300x225.jpg 300w, http://www.shostka-news.com/wp-content/uploads/2019/02/VYFDnoOUbQw-768x576.jpg 768w, http://www.shostka-news.com/wp-content/uploads/2019/02/VYFDnoOUbQw-1024x768.jpg 1024w\" sizes=\"(max-width: 1280px) 100vw, 1280px\" /></h4>\n<p>Любители пушистиков представили их во всей красе. Примечательно, что каждый герой выставки в своем неповторимом образе и со своим уникальным характером: нежные и ласковые, игривые и хитрые, мечтательные и смешливые.</p>\n<p><img class=\"alignnone size-full wp-image-20199\" src=\"http://www.shostka-news.com/wp-content/uploads/2019/02/jutEHlwY2Es.jpg\" alt=\"\" width=\"360\" height=\"320\" srcset=\"http://www.shostka-news.com/wp-content/uploads/2019/02/jutEHlwY2Es.jpg 1280w, http://www.shostka-news.com/wp-content/uploads/2019/02/jutEHlwY2Es-300x225.jpg 300w, http://www.shostka-news.com/wp-content/uploads/2019/02/jutEHlwY2Es-768x576.jpg 768w, http://www.shostka-news.com/wp-content/uploads/2019/02/jutEHlwY2Es-1024x768.jpg 1024w\" sizes=\"(max-width: 1280px) 100vw, 1280px\" /></p>\n<p>В выставке приняли участия детские коллективы: кружки декоративно-прикладного направления Центра эстетического воспитания &#171;Мир игрушек и сувениров&#187;, &#171;Ткачество&#187;, &#171;Художественная вышивка&#187; студия изобразительного искусства &#171;Мальва. Взрослые  участники были представлены  двумя  клубами  Центра культуры и досуга &#171;&#187;Элегант&#187; и &#171;Обрій&#187;.</p>\n<p><img class=\"alignnone size-full wp-image-20197\" src=\"http://www.shostka-news.com/wp-content/uploads/2019/02/vO0EtjHc3Hc.jpg\" alt=\"\" width=\"360\" height=\"320\" srcset=\"http://www.shostka-news.com/wp-content/uploads/2019/02/vO0EtjHc3Hc.jpg 1280w, http://www.shostka-news.com/wp-content/uploads/2019/02/vO0EtjHc3Hc-300x225.jpg 300w, http://www.shostka-news.com/wp-content/uploads/2019/02/vO0EtjHc3Hc-768x576.jpg 768w, http://www.shostka-news.com/wp-content/uploads/2019/02/vO0EtjHc3Hc-1024x768.jpg 1024w\" sizes=\"(max-width: 1280px) 100vw, 1280px\" /></p>\n<p>Главными ценителями выставленных работ стали ученики 2-А школы №5. Они с удовольствием разглядывали картины, игрушки, вышивку, фотографировали, понравившиеся работы. В конце презентации для гостей даже устроили мини дискотеку, рябятишки с задором плясали под песню &#171;Черный кот&#187;. Атмосферу праздника создавал для посетителей выставки Владимир Букус, который играл на саксофоне.</p>\n<p><img class=\"alignnone size-full wp-image-20194\" src=\"http://www.shostka-news.com/wp-content/uploads/2019/02/rtmBfzUf0Kc.jpg\" alt=\"\" width=\"810\" height=\"1080\" srcset=\"http://www.shostka-news.com/wp-content/uploads/2019/02/rtmBfzUf0Kc.jpg 810w, http://www.shostka-news.com/wp-content/uploads/2019/02/rtmBfzUf0Kc-225x300.jpg 225w, http://www.shostka-news.com/wp-content/uploads/2019/02/rtmBfzUf0Kc-768x1024.jpg 768w\" sizes=\"(max-width: 810px) 100vw, 810px\" /></p>\n<p>Полюбоваться &#171;усатыми-полосатыми&#187; можно будет в течение марта.</p>\n"*/
        
            /*"<p>У Шостці була створена робоча група по виявленню джерела хімічного запаху, на який час від часу скаржаться містяни. За участі членів робочої групи, та представників  потенційно-небезпечних підприємств, що розташовані у Шостці відбулась робоча нарада. Під час неї присутні намагались з&#8217;ясувати, яке підприємство причетне до розповсюдження їдкого смороду. Крім того, було запропоновано створити лабораторію, завдяки якій можна буде виявити чи є викид певних хімічних елементів у повітря.</p>\n<p><iframe  id=\"_ytid_93379\" width=\"360\" height=\"320\" frameborder=\"0\" scrolling=\"no\" src=\"https://www.youtube.com/embed/vtL3vSC0YnI?enablejsapi=1&#038;autoplay=0&#038;cc_load_policy=0&#038;iv_load_policy=1&#038;loop=0&#038;modestbranding=0&#038;rel=1&#038;showinfo=1&#038;fs=1&#038;playsinline=0&#038;autohide=2&#038;theme=dark&#038;color=red&#038;controls=2&#038;\" class=\"__youtube_prefs__\" title=\"YouTube player\"  allowfullscreen data-no-lazy=\"1\" data-skipgform_ajax_framebjll=\"\"></iframe></p>\n"*/
            
      //  newsWebViev.loadHTMLString(htmlCode, baseURL: nil)
        
        
      /*  self.newsWebViev.allowsInlineMediaPlayback = true
            
        let embededHTML = "<html><body><iframe src=\"URL HERE\"?playsinline=1\" width=\"320\" height=\"315\" frameborder=\"0\" scrolling=\"no\" allowfullscreen webkitallowfullscreen mozallowfullscreen oallowfullscreen msallowfullscreen></iframe></body></html>"
            
        self.newsWebViev.loadHTMLString(htmlCode, baseURL: Bundle.main.bundleURL) */
        
        
        //  https://www.shostka.info/wp-json/wp/v2/posts/
    }
    
    @IBAction func backUrlWebView(_ sender: UIBarButtonItem) {
        if(newsWebView.canGoBack) {
            newsWebView.goBack()
        } else {
            self.navigationController?.popViewController(animated:true)
        }
    }
    

}
