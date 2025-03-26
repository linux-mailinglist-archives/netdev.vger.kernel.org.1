Return-Path: <netdev+bounces-177839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D3FA72078
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 22:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 317E1189A9DB
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 21:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949FC25E45B;
	Wed, 26 Mar 2025 21:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKHwJh3h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB761A2541;
	Wed, 26 Mar 2025 21:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743023390; cv=none; b=WT+nD1ukN41p79bD53LtqLTh5eSDNSkOWc8gYFO9HyGob9TQn4xRIaZvlHYNrgJUrsYUzpi40febhsOdJn5nxz+p41AvBKymZvXTyoaZNVdglMpeOuMexDBlaq8eSIZAKY1g1+7A0E8B1uRBfQbClDAKxSX1VCs9YPUcHGLv9Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743023390; c=relaxed/simple;
	bh=BQgt5Ltn+t8rHqRB88UxwuNzrH2np5wAnn8t9PPkdVc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=owfSWoULmk+rLXzQhDVsnXuuWrQ8VvbbmxwM4KqluYski4/1upLteRmscQubi6C3w10Mas1KCiJcgHkdq5oMY7I+7RCB1lWrNt3djqqGOHIk1QH6k0La7WkRhQon32SoIiYfr0Axy6/SrMGAT4iwayBSlQMTR3QnclzED4ifU30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKHwJh3h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB73C4CEE2;
	Wed, 26 Mar 2025 21:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743023389;
	bh=BQgt5Ltn+t8rHqRB88UxwuNzrH2np5wAnn8t9PPkdVc=;
	h=Date:From:To:Subject:From;
	b=JKHwJh3hQPRXiZiDUfEhhObVORzoXPf8RVB21E3IVOPQbELTYz3v89tAvkk8xd5DN
	 E2GAzFZg5PuWpw4p3+YLehS81jFt9qpoxdW34oNx2NrJukRFlqLYvW/Euk28ZiMXcE
	 GxvFVT8+QajPpn6s5suO/0/1jF4J4nnvsna8TbwxGwf0Re/Xj7rJNyupcT2Xl3DE3A
	 W06LKnWWKlcRnnyikiJTaJ3GTL7otniEMK9EVvGJzOMF/gJX344X1KNZhmUobiA+6X
	 8/9jnZgva0FR0NclsUnvq3Ltc4cKS81jpCHbI8n8xucTovF1FLZNyBV6wlYd9gyGoi
	 DXgURt9TySdpg==
Date: Wed, 26 Mar 2025 14:09:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] netdev development stats for 6.15
Message-ID: <20250326140948.18a7da36@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Intro
-----

As is tradition here are the development statistics based on mailing
list traffic on netdev@vger.

These stats are somewhat like LWN stats: https://lwn.net/Articles/1004998/
but more focused on mailing list participation. And by participation
we mean reviewing code more than producing patches.

Previous 3 reports:
 - for 6.11: https://lore.kernel.org/20240722142243.26b9457f@kernel.org
 - for 6.12: https://lore.kernel.org/20240922190125.24697d06@kernel.org
 - for 6.13: https://lore.kernel.org/20241119191608.514ea226@kernel.org
 - for 6.14: https://lore.kernel.org/20250121200710.19126f7d@kernel.org

General stats
-------------

The 6.14 cycle included the winter break so for general stats let's
compare to 6.13. 6.15 merge window over all is +7.6% larger (total
linux-next size) than 6.13. We merged 1443 commits, which is +9.4%
compared to 6.13, and +1.7% if we discount the linux-next size growth.

The number of "pure authors" on the list dropped from 392 to 309.
The number of full participants (both submitting and commenting
on other people's patches) remained around 170.

Review coverage increased slightly (+0.4%). The number of revisions
of each patch set decreased slightly.

Testing
-------

Testing infra is stable, we have a regression in TDC due to iproute2
changes but that's hopefully to be addressed soon.

The major time investment in terms of testing this release was 
the addition of the "HW branch stream". A stream of branches
to be tested on HW setups, consisting only of patches which successfully
passed SW testing, and at a lower rate (one every 8 hours).

This has been in the plans for over a year, but the final push came
from Collabora which prepared a runner for NVMe-over-TCP testing.
HW testing is a bit more tricky than SW testing, as we can't expect
all tests to pass on all setups. As such we track test cases, and
only consider those which have passed in the past at least 15 times 
in a row. We are now running all driver tests against virtio.

https://netdev.bots.linux.dev/contest.html?pw-n=0&branch=net-next-hw-2025-03-26--16-00&pw-n=0&ld-cases=1

None of this is impressive but it took a solid week of plumbing :)

Contributions to selftests:
   1 [ 31] Jakub Kicinski
   2 [  7] Dmitry Safonov
   3 [  4] Breno Leitao
   4 [  4] Cong Wang
   5 [  4] Willem de Bruijn
   6 [  4] Ido Schimmel
   7 [  4] Petr Machata
   8 [  3] Gal Pressman
   9 [  3] Hangbin Liu
  10 [  3] Kevin Krakauer

Developer rankings
------------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 (   ) [26] Jakub Kicinski          1 (   ) [59] Jakub Kicinski      
   2 ( +1) [25] Simon Horman            2 ( +1) [55] Simon Horman        
   3 ( -1) [17] Andrew Lunn             3 ( -1) [45] Andrew Lunn         
   4 (   ) [12] Paolo Abeni             4 ( +6) [20] Willem de Bruijn    
   5 (   ) [ 7] Eric Dumazet            5 ( +2) [19] Russell King        
   6 ( +2) [ 6] Russell King            6 ( -1) [18] Paolo Abeni         
   7 ( +8) [ 5] Kuniyuki Iwashima       7 ( -3) [18] Eric Dumazet        
   8 (+11) [ 4] Stanislav Fomichev      8 (+10) [14] Kuniyuki Iwashima   
   9 ( -3) [ 4] Michal Swiatkowski      9 ( -3) [12] Vladimir Oltean     
  10 (   ) [ 4] Willem de Bruijn       10 (+12) [11] Stanislav Fomichev  
  11 ( +2) [ 4] Joe Damato             11 ( +4) [11] Joe Damato          
  12 (+13) [ 3] Rob Herring            12 (+14) [ 8] Rob Herring         
  13 ( +3) [ 3] Jacob Keller           13 (+27) [ 8] Leon Romanovsky     
  14 ( +3) [ 3] Ido Schimmel           14 ( +7) [ 8] Jason Wang          
  15 ( -6) [ 3] Krzysztof Kozlowski    15 (***) [ 7] Nikolay Aleksandrov 

The ranking comparison to 6.13 may also be clearer as much of the movement
here is folks returning to their usual positions. Stanislav and Rob register
the highest jump. Stanislav worked on netdev locking and ZC TCP, but also
helped revive NIPA a few times. Rob is the device tree maintainer.
Joe climbed in 6.13 and moves further up in 6.14.

Thank you all very much for your invaluable work!

Top authors (cs):                    Top authors (msg):                  
   1 ( +1) [6] Jakub Kicinski           1 ( +4) [26] Jakub Kicinski      
   2 ( -1) [5] Eric Dumazet             2 (***) [21] Stanislav Fomichev  
   3 (   ) [4] Russell King             3 ( -2) [20] Russell King        
   4 ( +2) [3] Heiner Kallweit          4 ( +8) [20] Eric Dumazet        
   5 (   ) [3] Tariq Toukan             5 (***) [18] Maxime Chevallier   
   6 ( +1) [2] Kuniyuki Iwashima        6 (***) [18] Lorenzo Bianconi    
   7 (+36) [2] Breno Leitao             7 ( -5) [17] Antonio Quartulli   
   8 ( +5) [2] Paolo Abeni              8 ( -4) [15] Tariq Toukan        
   9 ( +2) [2] Matthieu Baerts          9 ( -6) [15] Kuniyuki Iwashima   
  10 ( -1) [2] Dan Carpenter           10 (+27) [15] Jason Xing          

Top scores (positive):               Top scores (negative):              
   1 ( +2) [389] Simon Horman           1 (   ) [66] Antonio Quartulli   
   2 ( -1) [341] Jakub Kicinski         2 (***) [64] Lorenzo Bianconi    
   3 ( -1) [295] Andrew Lunn            3 (***) [59] Jedrzej Jagielski   
   4 (   ) [146] Paolo Abeni            4 (***) [43] Eric Woudstra       
   5 ( +4) [ 86] Willem de Bruijn       5 (***) [41] Faizal Rahim        
   6 (+12) [ 57] Rob Herring            6 (***) [41] Maxime Chevallier   
   7 ( +1) [ 52] Vladimir Oltean        7 ( +5) [40] Tian Xin            
   8 ( -3) [ 45] Eric Dumazet           8 (***) [39] Peter Seiderer      
   9 ( +1) [ 44] Krzysztof Kozlowski    9 ( -1) [37] Tony Nguyen         
  10 ( -4) [ 43] Michal Swiatkowski    10 (***) [36] Danielle Ratson     

Company rankings
----------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 ( +1) [38] RedHat                  1 ( +1) [98] RedHat              
   2 ( -1) [31] Meta                    2 ( -1) [82] Meta                
   3 (   ) [21] Intel                   3 (   ) [50] Intel               
   4 (   ) [17] Andrew Lunn             4 ( +1) [46] Google              
   5 (   ) [13] Google                  5 ( -1) [45] Andrew Lunn         
   6 ( +2) [ 9] nVidia                  6 ( +2) [31] nVidia              
   7 (   ) [ 8] Oracle                  7 (   ) [23] Oracle              

Top authors (cs):                    Top authors (msg):                  
   1 (   ) [11] RedHat                  1 (   ) [89] Intel               
   2 ( +2) [11] Meta                    2 ( +1) [63] Meta                
   3 ( -1) [10] Google                  3 ( -1) [58] RedHat              
   4 ( -1) [ 9] Intel                   4 ( +1) [56] nVidia              
   5 (   ) [ 8] nVidia                  5 ( +3) [41] Google              
   6 (   ) [ 5] Oracle                  6 (+18) [28] Bootlin             
   7 (   ) [ 3] Linaro                  7 ( -1) [25] Oracle                      

Top scores (positive):               Top scores (negative):              
   1 ( +2) [414] RedHat                 1 (+41) [75] Bootlin             
   2 ( -1) [306] Meta                   2 (   ) [66] OpenVPN             
   3 ( -1) [295] Andrew Lunn            3 (+31) [43] Parachute
   4 ( +1) [108] Google                 4 ( +8) [40] Yunsilicon          
   5 ( +1) [ 76] Linaro                 5 (***) [39] Peter Seiderer      
   6 ( +6) [ 60] ARM                    6 (   ) [39] nVidia              
   7 (***) [ 39] Oracle                 7 ( -4) [37] Pengutronix          
-- 
Code: https://github.com/kuba-moo/ml-stat
Raw output: https://netdev.bots.linux.dev/static/nipa/stats-6.15/stdout

