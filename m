Return-Path: <netdev+bounces-31312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7540978CF60
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 00:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5EFE1C20A6B
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 22:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304E2182CE;
	Tue, 29 Aug 2023 22:05:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55FE14AAF
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 22:05:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F49C433C8;
	Tue, 29 Aug 2023 22:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693346740;
	bh=ojaStiMswxHngruqtAyEP4JLMV2P2VbdaI9qxzixeKA=;
	h=Date:From:To:Cc:Subject:From;
	b=bp94ihDJaTYMJTUzL1Dnw8s1/Y8v4bVWcLo+Ws4Sq53ix/xkqK8/1J4VzX2o0WBNC
	 npGjYRa28MYtrbKEYL3cYYlY/9sEJB80EQeGVeMJLwuOxbu12ISiJPRVUUgss6/A8b
	 wGpRwRdDJNliBUdToFBtqDGuQzxHPQiSSQ/c23qjPNBsuYBD2dwRlBdQYjPKKgwTNa
	 KSImKWjsNBydiPanayxWS6VdgZzP8YLcetiEDqWU9axnvHUyUth7AQN9e/ISDadk5x
	 CcVEkMpwf+M/Qqt9YOpRCBCvWUJOlcrNXjzrBpf2kf5UlAfkUp8MnSJnWt08VT+SUk
	 9yNiP55KOri5A==
Date: Tue, 29 Aug 2023 15:05:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] netdev development stats for 6.6
Message-ID: <20230829150539.6f998d1f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

General stats
-------------

The cycle started on June 27th and ended on August 28th, it was exactly
the same length as the previous release cycle.

We have seen total of 16834 messages on the list (272 / day) which is
10% higher than last time (but very similar to the 6.4 cycle). The
number of commits directly applied by netdev maintainers increased
by 20% to 22 commits a day breaking the 3 release long streak of 18 / day.
The increases seem a little surprising to me, TBH, after all this
release covered a lot of the vacation season.

The number of participants in the ML discussions continues to oscillate
around 770 individuals. 

The patch review rate (Review/Ack tags) has recovered back to the 6.4
level and is respectively at 66% and 58%. Hopefully the 6.5 dip was
temporary.

Rankings
--------

Top reviewers (thr):                 Top reviewers (msg):                
   1 (   ) [44] Simon Horman            1 (   ) [59] Simon Horman        
   2 (   ) [33] Jakub Kicinski          2 (   ) [56] Jakub Kicinski      
   3 (   ) [13] Andrew Lunn             3 (   ) [30] Andrew Lunn         
   4 ( +9) [11] Leon Romanovsky         4 ( +9) [21] Leon Romanovsky     
   5 ( -1) [ 8] Paolo Abeni             5 (   ) [13] Russell King        
   6 ( -1) [ 6] Eric Dumazet            6 ( +5) [11] David Ahern         
   7 ( +4) [ 6] David Ahern             7 (+33) [10] Jesper Dangaard Brouer
   8 ( +6) [ 6] Ido Schimmel            8 ( +1) [10] Paolo Abeni         
   9 ( -3) [ 6] Russell King            9 ( -5) [ 9] Eric Dumazet        
  10 ( +5) [ 5] Willem de Bruijn       10 ( +9) [ 9] Ido Schimmel        
  11 (+41) [ 5] Jesper Dangaard Brouer 11 ( +5) [ 8] Willem de Bruijn    
  12 (+24) [ 4] Alexander Lobakin      12 ( -2) [ 8] Michael S. Tsirkin  

The top reviewer ranking is stable enough, with Simon topping the list
(as well as the kernel-wide reviewer list, congrats!).
Ido returns to the top 12 by actively reviewing core routing as well as
some "protocol driver" code. Jesper jumps into top 12 registering the
highest move from his work reviewing the page pool code. Leon returns
to #4 after a less active 6.5 cycle.

Top authors (thr):                   Top authors (msg):                  
   1 (***) [8] Yue Haibing              1 ( +2) [24] Tony Nguyen         
   2 ( -1) [7] Jakub Kicinski           2 (   ) [19] Saeed Mahameed      
   3 ( -1) [5] Eric Dumazet             3 ( +2) [17] Jakub Kicinski      
   4 ( -1) [5] Tony Nguyen              4 (+21) [17] Eric Dumazet        
   5 (***) [4] Jinjie Ruan              5 (***) [16] Qi Zheng            
   6 (***) [3] Suman Ghosh              6 (+25) [14] Jiri Pirko          
   7 ( -1) [3] Kuniyuki Iwashima        7 (***) [13] Hannes Reinecke     
   8 ( +2) [3] Daniel Golle             8 (+18) [11] Vladimir Oltean     
   9 ( +6) [3] Lin Ma                   9 (+15) [11] Dmitry Safonov      
  10 (***) [3] Hangbin Liu             10 (+31) [10] Larysa Zaremba      

Yue Haibing tops the raking of most threads started with the work 
of removing unused declarations from the kernel. 
Jinjie Ruan authored patches removing of_match_ptr() annotations
and "fixing" minor issues with error handling.

Qi Zheng posted the huge "refcount+RCU method to implement lockless
slab shrink" series a few times, not really related to netdev.
Hannes Reinecke worked on TLS and TLS + NVMe integration.

Company rankings
----------------

Top reviewers (thr):                 Top reviewers (msg):                
   1 (   ) [44] Corigine                1 ( +1) [66] Meta                
   2 (   ) [37] Meta                    2 ( -1) [59] Corigine            
   3 (   ) [23] RedHat                  3 (   ) [51] RedHat              
   4 ( +3) [23] nVidia                  4 ( +2) [46] nVidia              
   5 ( -1) [17] Intel                   5 ( -1) [32] Intel               
   6 (   ) [14] Google                  6 ( -1) [30] Andrew Lunn         
   7 ( -2) [13] Andrew Lunn             7 (   ) [29] Google              

The company ranking is pretty stable, with only notable movement being
nVidia's return to #4.

Top authors (thr):                   Top authors (msg):                  
   1 ( +5) [25] Huawei                  1 (   ) [86] Intel               
   2 ( -1) [19] Intel                   2 ( +1) [70] nVidia              
   3 ( -1) [17] RedHat                  3 ( -1) [52] RedHat              
   4 (   ) [12] Meta                    4 ( +6) [44] Huawei              
   5 ( -2) [11] nVidia                  5 (   ) [38] Meta                
   6 ( -1) [10] Google                  6 ( +7) [32] Google              
   7 ( +5) [ 9] Marvell                 7 ( +1) [25] AMD                 

Development vs reviewing scores
-------------------------------

Top scores (positive):               Bottom scores (negative):              
   1 (   ) [542] Corigine               1 (+31) [136] Huawei             
   2 (   ) [346] Meta                   2 (   ) [106] Intel              
   3 (   ) [188] Andrew Lunn            3 ( +7) [ 82] Bytedance          
   4 ( +1) [124] RedHat                 4 ( +4) [ 76] AMD                
   5 ( +1) [ 87] Linaro                 5 (***) [ 70] SUSE               
   6 ( +1) [ 82] Enfabrica              6 ( +7) [ 57] Marvell            
   7 ( -3) [ 67] Google          
   8 ( +2) [ 58] Linux Foundation  
   9 (+12) [ 56] Broadcom             
  10 ( +4) [ 52] ARM            
  11 (***) [ 45] Microchip      
  12 ( +3) [ 41] nVidia          

The semi-automated changes from Huawei have returned after a few
releases of relative calm, putting the company firmly as #1 negative
contributor from the reviewing perspective. This saves Intel from going
to #1, but note that in absolute terms the "negative" side of the
ranking got a lot worse. Previously first three positions had scores
of 55, 42 and 40, so they would *not even make the top 6* now!
SUSE is likely a temporary blip due to work from Hannes, but the other
companies on the list should take a hard look at themselves.

Not much movement on the "good" side. With the exception of nVidia,
the changes there seem to be mostly by posting volume not increase 
in reviews.

Thanks to everyone who contributed code to networking trees in this
release cycle, and huge thanks to everyone reviewing!

--

No major changes to the stats generation process in this release, 
I focused on minor improvements to parsing and matching people 
to companies.

Code: https://github.com/kuba-moo/ml-stat

