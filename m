Return-Path: <netdev+bounces-112470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5F5939561
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 23:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A8D2B21ED2
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 21:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355AC2C184;
	Mon, 22 Jul 2024 21:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7+qLnGm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A8928385;
	Mon, 22 Jul 2024 21:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721683365; cv=none; b=n/zZchC5Y9BgPfyXTljoFXijVtrmQsWv3YC7NN+WMU8M6wgK+62y6COfndAAp9yflevlGyOOD011vqUhIatCM8jUalzHL2Tq7OTwBJJ2/+tHkvGBuYw/WYzopyTO/Pf6Eexev08dTJKLnPmCEGEZiJFQhk3srIZFZboS2+muS8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721683365; c=relaxed/simple;
	bh=OlIBRBhq/T6z9THEY7d7Z0ukD8Zdfsx3fHWpDGnpnS4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=CEYbkR38MqyTh06QEUxFXHT/OlWK45M2lBUWji9RK2f/Hb5Fc+vkbW2mZO5tfOXRpo7uNLKSIOvfYSHx4A0hNJN2C0GaQsDdSIUyW8uPeq2FAD4JgHhd8fZ42b6vdmmIsDV1mYBLCH8DCLVU6YRmVtz/9FdqoN7ib5sopYFqITo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7+qLnGm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81892C4AF0A;
	Mon, 22 Jul 2024 21:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721683364;
	bh=OlIBRBhq/T6z9THEY7d7Z0ukD8Zdfsx3fHWpDGnpnS4=;
	h=Date:From:To:Subject:From;
	b=b7+qLnGmKROGabOaY4C9NPKArIww1EelgoTcLmsQOBpn8PpYPBaTitxS+m4FTQpeW
	 Q39gfsJ+PUNa14b/t2v7JFSGGY0ZjynecHBXbDguGNaufAPCAlvLJv/978mwJf5nql
	 +liHTKwj/hl7ugorfTf+zqL2AWGqSbHQFC4gmDYiZJHyQeVGMtkhXyK4cZq7o0cNME
	 j346NmPY+5OfdhTxDqtVb1E6T7yHRnh8NDfFX3Mi3w1yi9CZJgIaJHlVqNjhlR61n1
	 2jX07C6j+MdwoNj/rInnE/6UgDURkWzBuVNRpY1odjl4aUD8cQ8X8C6rGSgg3afiYu
	 D3pITCMNuCzCQ==
Date: Mon, 22 Jul 2024 14:22:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] netdev development stats for 6.11
Message-ID: <20240722142243.26b9457f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Public announcements
--------------------

This section is unrelated to the stats ;) I'm guessing that stats
emails may have above-average readership so, shortly:

1. LPC and netconf submissions are open. The new deadline is Aug 4th.
   netconf is more discussion oriented; submitting the same topic to
   both is perfectly fine. We have some speaker passes for LPC so don't
   worry too much that the registration is closed (but maybe make 
   a note in the submission that you need a pass).

   https://lore.kernel.org/all/20240410091255.2fd6a373@kernel.org/
   https://lore.kernel.org/all/20240605143056.4a850c40@kernel.org/

2. The deadline for setting up public CI for drivers is approaching.
   Any new NIC driver merged into net-next will now (already!) require
   a CI to be "Supported" in MAINTAINERS, by the next merge window
   (~October) we will downgrade existing drivers which don't have a CI.

   https://lore.kernel.org/all/20240425114200.3effe773@kernel.org/

Onto the actual stats..

Intro
-----

We have posted our pull requests with networking changes for the 6.11
kernel release last night. As is tradition here are the development
statistics based on mailing list traffic on netdev@vger.

These stats are somewhat like LWN stats: https://lwn.net/Articles/956765/
but more focused on mailing list participation.

Previous stats (for 6.10): https://lore.kernel.org/all/20240515122552.34af8692@kernel.org/

General stats
-------------

The release cycle was the same length as the previous one. 
The number of messages sent to the list a day dropped from 266 to 244.
The number of commits applied by netdev maintainers dropped from 20 to 17.
These are within our usual fluctuation bounds and likely seasonal.

The percentage of reviewed patches (by git tags) went back up to 68%,
but when we exclude people working for the same company the number
remained stable around 56%. The fraction of patches merged without 
any review across all versions dropped from 40% to 30%.

Testing
-------

The number of ignored test cases in netdev CI decreased further from 
20 to 14.

The ranking of people who contributed most to selftests:

   1 [ 16] Jakub Kicinski
   2 [ 15] Kuniyuki Iwashima
   3 [ 14] Petr Machata
   4 [ 12] Matthieu Baerts
   5 [ 10] Aaron Conole
   6 [  6] Adrian Moreno
   7 [  4] Geliang Tang
   8 [  4] Hangbin Liu
   9 [  2] Amit Cohen
  10 [  2] Ido Schimmel

A lot of familiar names. The two major efforts to call out were
Kuniyuki's rework of AF_UNIX tests, and Aaron's work to make
Open vSwitch tests run as part of our CI.

Fraction of applied patches which touch selftests dropped from 12.5%
to 10%. We may need to start pushing explicitly for more tests during
review..


Developer rankings
------------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 ( +1) [24] Jakub Kicinski          1 (   ) [54] Jakub Kicinski      
   2 ( -1) [24] Simon Horman            2 (   ) [54] Simon Horman        
   3 ( +2) [14] Andrew Lunn             3 (   ) [39] Andrew Lunn         
   4 ( -1) [10] Paolo Abeni             4 (   ) [17] Eric Dumazet        
   5 ( -1) [ 8] Eric Dumazet            5 ( +1) [14] Paolo Abeni         
   6 ( +8) [ 5] Przemek Kitszel         6 (+10) [12] Vladimir Oltean     
   7 ( +4) [ 4] Krzysztof Kozlowski     7 ( -2) [12] Willem de Bruijn    
   8 ( +4) [ 3] Russell King            8 ( +3) [10] Krzysztof Kozlowski 
   9 ( +9) [ 3] Vladimir Oltean         9 (+18) [ 9] Michael S. Tsirkin  
  10 (   ) [ 3] Jacob Keller           10 (+12) [ 9] Przemek Kitszel     
  11 ( -5) [ 3] Jiri Pirko             11 ( +1) [ 9] Russell King        
  12 ( -4) [ 3] Willem de Bruijn       12 ( +3) [ 7] Jacob Keller        
  13 ( -6) [ 3] David Ahern            13 ( -5) [ 7] Jason Wang          
  14 (+13) [ 3] Michael S. Tsirkin     14 ( +7) [ 6] Rob Herring         
  15 ( +7) [ 3] Rob Herring            15 ( -8) [ 6] Jiri Pirko          

Przemek continues to climb reviewing both Intel and non-Intel driver patches.
Vladimir and Russell return to top 10 after short period of lower activity.
Michael and Jason primarily review virtio patches (of which there is 
an increasing number).

Thank you all very much for your invaluable work!


Top authors (cs):                    Top authors (msg):                  
   1 ( +1) [5] Jakub Kicinski           1 ( +4) [15] Kory Maincent (Dent Project)
   2 ( -1) [3] Eric Dumazet             2 ( -1) [14] Jakub Kicinski      
   3 ( +2) [2] Kuniyuki Iwashima        3 (***) [13] Sebastian Andrzej Siewior
   4 ( +2) [1] Breno Leitao             4 ( +9) [13] Kuniyuki Iwashima   
   5 ( +6) [1] Jason Xing               5 (+23) [12] Yunsheng Lin        
   6 (***) [1] Bartosz Golaszewski      6 (+18) [11] Mina Almasry        
   7 (+32) [1] Oleksij Rempel           7 ( +3) [11] Xuan Zhuo           

Kory worked on PoE/PoDL interfaces as well as timestamp selection API
(which sadly didn't make 6.11). Breno refactored netdev allocation and
stats in SW drivers. Jason worked on tracing and various TCP-adjacent
bits. Bartosz contributed power sequencing subsystem and various
platform enablement bits. Yunsheng Lin continues attempts at refactoring
page frag API.


Top scores (positive):               Top scores (negative):              
   1 (   ) [377] Simon Horman           1 ( +2) [54] Kory Maincent (Dent Project)
   2 (   ) [363] Jakub Kicinski         2 (***) [47] Sebastian Andrzej Siewior
   3 (   ) [257] Andrew Lunn            3 (+17) [46] Yunsheng Lin        
   4 (   ) [129] Paolo Abeni            4 (+37) [42] Mina Almasry        
   5 ( +2) [102] Eric Dumazet           5 (***) [41] Bartosz Golaszewski 
   6 ( +6) [ 75] Przemek Kitszel        6 (***) [40] Adrian Moreno       
   7 (+40) [ 70] Krzysztof Kozlowski    7 (+32) [40] Christophe Roullier
   8 ( -2) [ 68] Willem de Bruijn       8 ( -7) [38] Edward Liaw         
   9 ( +6) [ 54] Vladimir Oltean        9 (+49) [38] Maxime Chevallier   
  10 (+12) [ 53] Michael S. Tsirkin    10 (+39) [38] Justin Lai          

The list of top "scores" (i.e. folks contributing more reviews than code)
speaks for itself.


Company rankings
----------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 (   ) [37] RedHat                  1 (   ) [97] RedHat              
   2 (   ) [25] Meta                    2 (   ) [66] Meta                
   3 ( +1) [19] Intel                   3 ( +1) [43] Intel               
   4 ( +2) [14] Andrew Lunn             4 ( +1) [39] Andrew Lunn         
   5 ( -2) [12] Google                  5 ( -2) [36] Google              
   6 ( -1) [ 7] nVidia                  6 (   ) [21] nVidia              
   7 (   ) [ 7] Linaro                  7 (   ) [15] Linaro              

Top authors (cs):                    Top authors (msg):                  
   1 ( +1) [10] RedHat                  1 (   ) [69] Intel               
   2 ( -1) [10] Intel                   2 ( +1) [43] RedHat              
   3 ( +1) [ 8] Meta                    3 ( +1) [42] nVidia              
   4 ( -1) [ 6] Google                  4 ( -2) [38] Google              
   5 (   ) [ 5] nVidia                  5 (   ) [31] Meta                
   6 ( +4) [ 3] Linaro                  6 (   ) [21] Alibaba             
   7 (+14) [ 3] Qualcomm                7 ( +1) [18] Huawei              

Top scores (positive):               Top scores (negative):              
   1 (   ) [473] RedHat                 1 (   ) [64] Alibaba             
   2 (   ) [335] Meta                   2 (   ) [59] Huawei              
   3 (   ) [257] Andrew Lunn            3 ( +3) [56] Bootlin             
   4 (   ) [ 78] Google                 4 (   ) [54] Dent                
   5 ( +2) [ 59] Linaro                 5 (***) [49] Linutronix          
   6 ( +2) [ 54] ARM                    6 (+26) [43] MediaTek            
   7 ( +2) [ 52] Linux Foundation       7 (***) [43] Qualcomm            

Only minor movements in company rankings. Alibaba and Huawei continue
to occupy the top "net-taker" spots in terms of reviews, followed by
number of embedded contractors, MediaTek and Qualcomm.

Looking at scores of those companies (~50) vs Andrew's individual score 
(250) -- it appears that 1/5th of "an Andrew" would be enough for those
companies to disappear from the list of shame. Apparently 1/5th of 
a single engineer's time is too much to ask.
-- 
Code: https://github.com/kuba-moo/ml-stat
Raw output: https://netdev.bots.linux.dev/static/nipa/stats-6.11/stdout

