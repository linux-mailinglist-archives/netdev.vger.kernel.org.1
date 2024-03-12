Return-Path: <netdev+bounces-79526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17331879C5B
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 20:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70A7C2856FD
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 19:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEDC14263A;
	Tue, 12 Mar 2024 19:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="plkEPgd+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55791386A8;
	Tue, 12 Mar 2024 19:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710272628; cv=none; b=EpTyLQN6L+VVkbKRWUlKLjfwFRsizIMtWzHkrVFpsdj+Fuu+XP/7S6JWuZWqWapperj9Z0+3evg7Fe88ZlfdRvFcTOhadHHtqZQDrG+Bd5DqlAahCMqRDyK518njuim9fTkWBi6bJlI9zcH9Cnkss8dZbzisxSQvYGGMG1JuCTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710272628; c=relaxed/simple;
	bh=kiStTp/ySzQ6315CNx7mDnm0kab042TrheunRjBr2vg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=gRsck4EI7zRMsHkg9PiVxwM/7smXPJ1T/tDxc/Q1bqqTNWcFEYKHAdMhGLm2g94Xd/Dfv7C99NkFGd3a3VLmJ72bbeErGwX+220WV2tZdNCK1eXPFQlwW18nmUVqt2MBisygVKC38yhncmoIo5o6mnpzixoaVGZ+ieK9r8/JyGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=plkEPgd+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B28FC433C7;
	Tue, 12 Mar 2024 19:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710272627;
	bh=kiStTp/ySzQ6315CNx7mDnm0kab042TrheunRjBr2vg=;
	h=Date:From:To:Subject:From;
	b=plkEPgd++rcPp8OovlAWaJ9WLkPwhHO4mfQXik/PtRsURkWjRQjKsx8wxGTFELRwM
	 nUpagUJrJ1jxB8FPzmp0PrdgYMPYHGNhQiaM+nmA7myzAC3LY1jYaV8sXnFP0Q/KkS
	 kHvpJEKHL6w9djogrQ0ssZBDTbGtpUsZuv8D8VWF8044KiVP0DhcMujvL29Y4sSdeT
	 NzQAV+8WFO8vOJvTu6pPclbtTnNuLFb7KNowIAl3YzVQ3D+omemRvbjFDVV0/8VR3E
	 mpeJcbdkSJVNToGfSqVkP7S0rcBYFz1AB0D+nogpI7PsE3yjpQpyLMdRG+F+1bgukA
	 rTe+ffQno6hKQ==
Date: Tue, 12 Mar 2024 12:43:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] netdev development stats for 6.9
Message-ID: <20240312124346.5aa3b14a@kernel.org>
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

We have posted our pull requests with networking changes for the 6.9
kernel release last night. As is tradition here are the development
statistics based on mailing list traffic on netdev@vger.

These stats are somewhat like LWN stats: https://lwn.net/Articles/956765/
but more focused on review participation.

Previous stats (for 6.8): https://lore.kernel.org/all/20240109134053.33d317dd@kernel.org/

Testing
-------

The selftest runner went live early during this release.
I don't have any great ideas on how to quantify the progress
but, first, I'd like to thank everyone who contributed to improving
and fixing the tests, and those who contributed to NIPA directly.
We are reporting results from 243 tests to patchwork (not counting
kunit tests), each test on two kernel flavors and with many sub-cases. 

There's still work to be done fixing some of the tests but we made
more progress than I anticipated! There are 66 test + kernel config
combinations which we currently ignore, either because they permanently
skip / fail or are too flaky. I should mention that those tests do matter,
recently the ignored pmtu test would have caught a last minute xfrm
regression :(

Speaking of catching regressions, I do not have an objective count but
subjectively our tests do in fact catch bugs. In fact the signal to noise
ratio is higher than I initially expected. I wish it was easier to write
driver tests and use YNL in the tests, but we'll get there..

General stats
-------------

Cycle started on Tue, 09 Jan, ended Mon, 11 Mar. That's 63 days,
one week shorter than the previous cycle.

We have seen 264 msg/day on the list, and 24 commits/day.
The number of messages is back to the level we have seen in 6.6,
and has recovered after couple of slower releases (last one being
particularly slow due to the winter break). The number of commits
applied directly by netdev maintainers is 9% higher than in 6.6 
and highest on the record.

The total number of review tags in git history have dipped again,
61% of commits contain a review tag (down from 69%). The number
of commits with a review tag from an email domain different than
the author, however, dropped only by 1% to 53%. Similarly our statistic
of series which received at least one ack / review tag on the list did
not change much, increasing by 1% to 67%.

Rankings
--------

As promised last time, the left side of the stats is now in "change
sets" (cs) rather than threads, IOW trying to track multiple revisions 
of the same series as one.

Top reviewers (cs):                  Top reviewers (msg):                
   1 ( +1) [30] Jakub Kicinski          1 (   ) [66] Jakub Kicinski      
   2 ( -1) [26] Simon Horman            2 (   ) [45] Simon Horman        
   3 (   ) [14] Andrew Lunn             3 (   ) [44] Andrew Lunn         
   4 ( +1) [12] Paolo Abeni             4 ( +3) [25] Jiri Pirko          
   5 ( +4) [11] Jiri Pirko              5 (   ) [23] Eric Dumazet        
   6 ( -2) [10] Eric Dumazet            6 ( +3) [20] Paolo Abeni         
   7 (   ) [ 5] David Ahern             7 ( +1) [15] Krzysztof Kozlowski 
   8 ( +6) [ 4] Stephen Hemminger       8 ( +2) [11] David Ahern         
   9 ( +2) [ 4] Willem de Bruijn        9 ( +4) [10] Florian Fainelli    
  10 (   ) [ 4] Krzysztof Kozlowski    10 ( -6) [10] Vladimir Oltean     
  11 ( +1) [ 4] Florian Fainelli       11 ( -5) [ 9] Russell King        
  12 ( -6) [ 4] Russell King           12 (   ) [ 9] Willem de Bruijn    
  13 ( +3) [ 2] Jacob Keller           13 ( -2) [ 8] Sergey Shtylyov     
  14 ( +1) [ 2] Rob Herring            14 ( +6) [ 7] Jacob Keller        
  15 ( +2) [ 2] Jamal Hadi Salim       15 (+16) [ 7] Jason Wang          

Jiri jumps into top 5, reviewing various driver and netlink changes.
Stephen largely works on iproute2 reviews. Russell and Vladimir have
indicated that they are occupied outside of netdev, and slip by a few
positions.

Thank you all for your work!

Top authors (cs):                    Top authors (msg):                  
   1 ( +1) [7] Eric Dumazet             1 (+35) [40] Eric Dumazet        
   2 ( -1) [7] Jakub Kicinski           2 ( +5) [26] Jakub Kicinski      
   3 (+46) [4] Breno Leitao             3 ( +1) [20] Saeed Mahameed      
   4 (   ) [3] Heiner Kallweit          4 (+18) [17] Xuan Zhuo           
   5 ( +8) [2] Stephen Hemminger        5 (***) [15] Jason Xing          
   6 (+24) [2] Paolo Abeni              6 (***) [15] Matthieu Baerts     
   7 (+11) [2] Kuniyuki Iwashima        7 (***) [14] Breno Leitao        
   8 (***) [2] Maks Mishin              8 ( -3) [14] Tony Nguyen         
   9 ( +6) [2] Kunwu Chan               9 ( -3) [13] Kuniyuki Iwashima   
  10 (***) [2] Matthieu Baerts         10 ( -8) [11] Christian Marangi   

Thanks to switching from threads to changes sets we see Eric rightfully
claim the #1 spot, previously occupied by yours truly. Breno added
missing MODULE_DESCRIPTION()s and refactored drivers using per-cpu
stats. Paolo contributed a number of MPTCP changes and many selftest
improvements. Maks Mishin sent a lot of individual iproute2 patches.
Xuan Zhuo is working on vhost / virtio changes for AF_XDP.

Top scores (positive):               Top scores (negative):              
   1 ( +1) [398] Jakub Kicinski         1 ( +2) [80] Saeed Mahameed      
   2 ( -1) [371] Simon Horman           2 (+17) [60] Xuan Zhuo           
   3 (   ) [243] Andrew Lunn            3 (***) [46] Jason Xing          
   4 ( +8) [160] Jiri Pirko             4 (***) [43] Yang Xiwen via B4 Relay
   5 ( +2) [152] Paolo Abeni            5 (***) [42] Matthieu Baerts     
   6 ( +2) [ 78] Krzysztof Kozlowski    6 ( -2) [40] Tony Nguyen         
   7 ( +2) [ 76] David Ahern            7 ( -6) [38] David Howells       
   8 ( +2) [ 68] Willem de Bruijn       8 ( -6) [37] Christian Marangi   
   9 ( +2) [ 60] Florian Fainelli       9 (+30) [37] Kory Maincent       
  10 ( -5) [ 54] Russell King          10 (***) [36] Breno Leitao        

Corporate stats
---------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 (   ) [42] RedHat                  1 (   ) [98] RedHat              
   2 (   ) [32] Meta                    2 (   ) [74] Meta                
   3 ( +2) [16] Google                  3 (   ) [44] Andrew Lunn         
   4 (   ) [14] Andrew Lunn             4 ( +1) [43] Google              
   5 ( -2) [13] Intel                   5 ( -1) [36] Intel               
   6 ( +1) [13] nVidia                  6 ( +2) [31] Linaro              
   7 ( +1) [ 8] Linaro                  7 (   ) [31] nVidia      

Top authors (cs):                    Top authors (msg):                  
   1 ( +1) [12] RedHat                  1 (   ) [69] Intel               
   2 ( +2) [12] Meta                    2 ( +2) [60] Meta                
   3 ( -2) [10] Intel                   3 ( +2) [55] Google              
   4 ( -1) [10] Google                  4 ( -1) [50] nVidia              
   5 (   ) [ 7] nVidia                  5 ( -3) [47] RedHat              
   6 ( +2) [ 3] Huawei                  6 ( +4) [32] Bootlin             
   7 ( +7) [ 3] Wirecard                7 ( -1) [23] Alibaba    

Top scores (positive):               Top scores (negative):              
   1 (   ) [496] RedHat                 1 ( +7) [89] Bootlin             
   2 (   ) [303] Meta                   2 (   ) [79] Alibaba             
   3 (   ) [243] Andrew Lunn            3 (***) [46] Tencent             
   4 ( +2) [138] Linaro                 4 (***) [43] Yang Xiwen
   5 (   ) [ 79] Google                 5 (***) [42] Tessares            
   6 ( +2) [ 76] Enfabrica              6 ( +6) [38] AMD                 
   7 ( -3) [ 60] Oracle                 7 ( -6) [37] Christian Marangi   

RedHat remains unbeatable with the combined powers of Simon and Paolo,
as well as high participation of the less active authors.
Alibaba maintains its strongly net-negative review score.
Tencent (Jason Xing) joins them (Tencent doesn't use their email
domain so it's likely under-counted). Yang Xiwen makes the negative
list as well, cost of reposting large series too often...
-- 
Code: https://github.com/kuba-moo/ml-stat
Raw output: https://netdev.bots.linux.dev/static/nipa/stats-6.9/stdout

