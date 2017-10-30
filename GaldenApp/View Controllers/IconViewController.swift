//
//  ReplyIconViewController.swift
//  GaldenApp
//
//  Created by Kin Wa Lam on 22/10/2017.
//  Copyright © 2017年 1080@galden. All rights reserved.
//

import UIKit
import Kingfisher

class IconViewController: UIViewController {

    var segueIdentifier = ""
    var iconSelected = ""
    
    //MARK: Outlets
    
    //row 1
    @IBOutlet weak var icon369: UIImageView!
    @IBOutlet weak var iconadore: UIImageView!
    @IBOutlet weak var iconagree: UIImageView!
    @IBOutlet weak var iconangel: UIImageView!
    @IBOutlet weak var iconangry: UIImageView!
    @IBOutlet weak var iconass: UIImageView!
    @IBOutlet weak var iconbanghead: UIImageView!
    @IBOutlet weak var iconbiggrin: UIImageView!
    
    //row 2
    @IBOutlet weak var iconbomb: UIImageView!
    @IBOutlet weak var iconbouncer: UIImageView!
    @IBOutlet weak var iconbouncy: UIImageView!
    @IBOutlet weak var iconbye: UIImageView!
    @IBOutlet weak var iconcensored: UIImageView!
    @IBOutlet weak var iconcn: UIImageView!
    @IBOutlet weak var iconplastic: UIImageView!
    @IBOutlet weak var iconcry: UIImageView!
    
    //row 3
    @IBOutlet weak var icondead: UIImageView!
    @IBOutlet weak var icondevil: UIImageView!
    @IBOutlet weak var icondunno: UIImageView!
    @IBOutlet weak var iconfire: UIImageView!
    @IBOutlet weak var iconflowerface: UIImageView!
    @IBOutlet weak var iconfrown: UIImageView!
    @IBOutlet weak var iconfuck: UIImageView!
    @IBOutlet weak var iconat: UIImageView!
    
    //row 4
    @IBOutlet weak var icongood: UIImageView!
    @IBOutlet weak var iconhehe: UIImageView!
    @IBOutlet weak var iconhoho: UIImageView!
    @IBOutlet weak var iconkill2: UIImageView!
    @IBOutlet weak var iconkill: UIImageView!
    @IBOutlet weak var iconkiss: UIImageView!
    @IBOutlet weak var iconlove: UIImageView!
    @IBOutlet weak var iconno: UIImageView!
    
    //row 5
    @IBOutlet weak var iconofftopic: UIImageView!
    @IBOutlet weak var iconoh: UIImageView!
    @IBOutlet weak var iconphoto: UIImageView!
    @IBOutlet weak var iconshock: UIImageView!
    @IBOutlet weak var iconslick: UIImageView!
    @IBOutlet weak var iconsmile: UIImageView!
    @IBOutlet weak var iconsosad: UIImageView!
    @IBOutlet weak var iconsurprice: UIImageView!
    
    //row 6
    @IBOutlet weak var icontongue: UIImageView!
    @IBOutlet weak var iconwink: UIImageView!
    @IBOutlet weak var iconwonder2: UIImageView!
    @IBOutlet weak var iconwonder: UIImageView!
    @IBOutlet weak var iconyipes: UIImageView!
    @IBOutlet weak var iconz: UIImageView!
    @IBOutlet weak var iconlol: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //row 1
        icon369.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/369.gif"))
        iconadore.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/adore.gif"))
        iconagree.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/agree.gif"))
        iconangel.kf.setImage(with: URL(string: "https://hkgalden.com/face/hkg/angel.gif"))
        iconangry.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/angry.gif"))
        iconass.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/ass.gif"))
        iconbanghead.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/banghead.gif"))
        iconbiggrin.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/biggrin.gif"))
        
        //row 2
        iconbomb.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/bomb.gif"))
        iconbouncer.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/bouncer.gif"))
        iconbouncy.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/bouncy.gif"))
        iconbye.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/bye.gif"))
        iconcensored.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/censored.gif"))
        iconcn.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/chicken.gif"))
        iconplastic.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/clown.gif"))
        iconcry.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/cry.gif"))
        
        //row 3
        icondead.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/dead.gif"))
        icondevil.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/devil.gif"))
        icondunno.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/donno.gif"))
        iconfire.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/fire.gif"))
        iconflowerface.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/flowerface.gif"))
        iconfrown.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/frown.gif"))
        iconfuck.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/fuck.gif"))
        iconat.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/@.gif"))
        
        //row 4
        icongood.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/good.gif"))
        iconhehe.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/hehe.gif"))
        iconhoho.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/hoho.gif"))
        iconkill2.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/kill2.gif"))
        iconkill.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/kill.gif"))
        iconkiss.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/kiss.gif"))
        iconlove.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/love.gif"))
        iconno.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/no.gif"))
        
        //row 5
        iconofftopic.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/offtopic.gif"))
        iconoh.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/oh.gif"))
        iconphoto.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/photo.gif"))
        iconshock.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/shocking.gif"))
        iconslick.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/slick.gif"))
        iconsmile.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/smile.gif"))
        iconsosad.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/sosad.gif"))
        iconsurprice.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/surprise.gif"))
        
        //row 6
        icontongue.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/tongue.gif"))
        iconwink.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/wink.gif"))
        iconwonder2.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/wonder2.gif"))
        iconwonder.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/wonder.gif"))
        iconyipes.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/yipes.gif"))
        iconz.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/z.gif"))
        iconlol.kf.setImage(with: URL(string: "http://hkgalden.com/face/hkg/lol.gif"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        if (segueIdentifier == "Reply") {
            performSegue(withIdentifier: "unwindToReply", sender: self)
        } else if (segueIdentifier == "NewPost") {
            performSegue(withIdentifier: "unwindToNewPost", sender: self)
        }
    }
    
    @IBAction func iconTapped(_ sender: UITapGestureRecognizer) {
        switch (sender.view?.tag)! {
        case 0:
            iconSelected = "[369] "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 1:
            iconSelected = "#adore# "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 2:
            iconSelected = "#yup# "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 3:
            iconSelected = "O:-) "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 4:
            iconSelected = ":-[ "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 5:
            iconSelected = "#ass# "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 6:
            iconSelected = "[banghead] "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 7:
            iconSelected = ":D "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 8:
            iconSelected = "[bomb] "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 9:
            iconSelected = "[bouncer] "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 10:
            iconSelected = "[bouncy] "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 11:
            iconSelected = "#bye# "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 12:
            iconSelected = "[censored] "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 13:
            iconSelected = "#cn# "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 14:
            iconSelected = ":o) "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 15:
            iconSelected = ":~( "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 16:
            iconSelected = "xx( "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 17:
            iconSelected = ":-] "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 18:
            iconSelected = "#ng# "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 19:
            iconSelected = "#fire# "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 20:
            iconSelected = "[flowerface] "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 21:
            iconSelected = ":-( "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 22:
            iconSelected = "fuck "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 23:
            iconSelected = "@_@ "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 24:
            iconSelected = "#good# "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 25:
            iconSelected = "#hehe# "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 26:
            iconSelected = "#hoho# "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 27:
            iconSelected = "#kill2# "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 28:
            iconSelected = "#kill# "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 29:
            iconSelected = "^3^ "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 30:
            iconSelected = "#love# "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 31:
            iconSelected = "#no# "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 32:
            iconSelected = "[offtopic] "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 33:
            iconSelected = ":O "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 34:
            iconSelected = "[photo] "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 35:
            iconSelected = "[shocking] "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 36:
            iconSelected = "[slick] "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 37:
            iconSelected = ":) "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 38:
            iconSelected = "[sosad] "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 39:
            iconSelected = "#oh# "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 40:
            iconSelected = ":P "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 41:
            iconSelected = ";-) "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 42:
            iconSelected = "??? "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 43:
            iconSelected = "?_? "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 44:
            iconSelected = "[yipes] "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 45:
            iconSelected = "Z_Z "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 46:
            iconSelected = "#lol# "
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        default:
            break
        }
    }
    
}
