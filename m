Return-Path: <netdev+bounces-146375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D159D3272
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 04:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B6E01F218E7
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 03:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B311494C3;
	Wed, 20 Nov 2024 03:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2uY6vXK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06313A1BA;
	Wed, 20 Nov 2024 03:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732072570; cv=none; b=fPa1JkArLQpIvzYX4YPXkEs1if9sdPu+d3zoJxMqQLDyDcqe3mB8GYoJotI7OwCAU+ixYeQco8bufFu2ruHGv+8sRfvJaJkckqmv7OOwYO0TWL/jLXVSyITozIr4SJR6hBP1XAxYK3lPt3vNlZXYtKboIXJY3ANPYCN4APmGs2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732072570; c=relaxed/simple;
	bh=JpZIrzJKvISSfKh+N8bTmPL7ZH/0iE+RKlt/0jPwIl4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=I6CzmUHOi36Je1mJsy+A6Vc8lYgDdR9Jds2htvZ1ls8qy6bQX2mj77cb7SwL9L3i+sfaE2XlZYRdk7cbWbDxfQ06WmcsJlN9zEK/NE4VhRukQfj+fpqunJB69CrngpnTdNa2uHOTqFF+GGuACFi5+1NJWg1fwaemgvIfleNS230=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2uY6vXK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24944C4CECF;
	Wed, 20 Nov 2024 03:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732072570;
	bh=JpZIrzJKvISSfKh+N8bTmPL7ZH/0iE+RKlt/0jPwIl4=;
	h=Date:From:To:Subject:From;
	b=h2uY6vXK/maO7g8zBrVUoen5pGEvhDQdZdEfy/DPdrpUZ3DgSZiOYC5kD2CLjB29l
	 DWq1wUVPQxVaW+3oYhbetl7KdIpV0TeuBBC9DxZy4aBjhQgIi7IAJEfukNFDk82c9R
	 awevVlDrXEAuJbO6y4X44YS72bYUY3Sc2kaXUvSUEYPNB9eViGeiv0ZlCBp1RsI7ES
	 EfWWo7gipsNQ8cBYMCprpONUQ9Vd+CiwjharxChfNO2gUXlook8yV74JazQb4dOmSj
	 v2yeijC5Td9NAutcIFeqlSpNVqpr76A2DIllkwh5YTfWe9ICswxePh4TXuKm0nsS6Y
	 ATTrYnUNcocpQ==
Date: Tue, 19 Nov 2024 19:16:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] netdev development stats for 6.13
Message-ID: <20241119191608.514ea226@kernel.org>
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

These stats are somewhat like LWN stats: https://lwn.net/Articles/956765/
but more focused on mailing list participation. And by participation
we mean reviewing code more than producing patches.

Previous stats (for 6.12): https://lore.kernel.org/20240922190125.24697d06@kernel.org

General stats
-------------

The cycles was about 10% busier than the previous one, in terms of 
messages on the list (293 msg/day, +9.0% from 6.12) and applied 
commits (21 commits/day, +9.8%). There was also 10% more people
emailing list list.

Fraction of reviewed commits (by counting git tags) went down
by 1% to 70%, while the fraction of commits reviewed by people
with a different email domain moved up 2% to 60%.

The increase in traffic is entirely expected as the previous cycle
overlapped with summer vacations. Next cycle will likely go down again,
due to winter festivities...

Testing
-------

We merged a similar number of changes for selftests as in previous
cycle (102). Since we merged more commits - this is a proportional
decrease. It's not what I hoped for, but subjectively I think there
is a clear increase in the number of reviewers asking for selftests
to be added or extended with new code or fixes. So it _feels_ like
the shift towards more structured testing is happening.

The enabling CONFIG_PROVE_RCU_LIST in our CI caused a regression
in the number of ignored tests. We are ignoring 11 tests up from
8 in 6.12. The fixes are WIP so I'm not too concerned.

The ranking of people who contributed most to selftests:

Contributions to selftests:
   1 [ 20] Petr Machata
   2 [ 12] Stanislav Fomichev
   3 [  8] Jakub Kicinski
   4 [  5] Sabrina Dubroca
   5 [  4] Yunsheng Lin
   6 [  4] Hangbin Liu
   7 [  3] Mohan Prasad J
   8 [  3] Edward Cree
   9 [  3] Breno Leitao
  10 [  3] Paolo Abeni

Notably Petr added a form of "defer" for bash scripts.

Developer rankings
------------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 ( +1) [35] Simon Horman            1 (   ) [58] Jakub Kicinski      
   2 ( -1) [29] Jakub Kicinski          2 (   ) [57] Simon Horman        
   3 (   ) [18] Andrew Lunn             3 (   ) [51] Andrew Lunn         
   4 (   ) [12] Paolo Abeni             4 (   ) [25] Eric Dumazet        
   5 (   ) [ 8] Eric Dumazet            5 ( +1) [19] Paolo Abeni         
   6 ( +6) [ 5] Kuniyuki Iwashima       6 ( -1) [16] Willem de Bruijn    
   7 (+19) [ 4] Russell King            7 ( +8) [16] Vladimir Oltean     
   8 ( -1) [ 4] Willem de Bruijn        8 ( +8) [13] Kuniyuki Iwashima   
   9 (   ) [ 4] Jacob Keller            9 ( -2) [11] Krzysztof Kozlowski 
  10 (+25) [ 3] Vladimir Oltean        10 (***) [ 9] Mina Almasry        
  11 ( -5) [ 3] Krzysztof Kozlowski    11 (+31) [ 9] Russell King        
  12 (+10) [ 3] David Ahern            12 ( -2) [ 8] Jacob Keller        
  13 (***) [ 3] Kalesh Anakkur Purayil 13 (***) [ 7] Vadim Fedorenko     
  14 (+11) [ 3] Ido Schimmel           14 (+46) [ 7] Martin KaFai Lau    
  15 (+23) [ 3] Vadim Fedorenko        15 (***) [ 7] Frank Li            

A lot of familiar names in the top 15 reviewers. Quite a few names
reappearing after a period of lower activity, the returns are greatly
appreciated. Kalesh and Vadim may be appearing here for the first time,
focusing on general driver reviews. Frank Li has been reviewing mostly
NXP ENETC patches, which were so numerous they were enough to earn 
the 15th position :)

Big thanks to all the reviewers for their invaluable work!

Top authors (cs):                    Top authors (msg):                  
   1 ( +2) [5] Rosen Penev              1 ( +8) [30] Rosen Penev         
   2 ( +3) [4] Eric Dumazet             2 (+44) [22] Kuniyuki Iwashima   
   3 (***) [3] Heiner Kallweit          3 (+30) [17] Joe Damato          
   4 ( -3) [3] Jakub Kicinski           4 (***) [17] Wei Fang            
   5 (+41) [2] Hangbin Liu              5 (+13) [16] Tariq Toukan        

No surprises for top authors. Rosen Penev has been posting driver "updates"
to convert them to newer APIs. Kuniyuki is pushing forward with rtnl lock
breakup. Joe added NAPI netlink support to a lot of drivers.

Top scores (positive):               Top scores (negative):              
   1 ( +1) [485] Simon Horman           1 ( +6) [119] Rosen Penev        
   2 ( -1) [445] Jakub Kicinski         2 (+26) [ 59] David Howells      
   3 (   ) [328] Andrew Lunn            3 (+44) [ 55] Antonio Quartulli  
   4 ( +1) [149] Paolo Abeni            4 (***) [ 55] Wei Fang           
   5 ( -1) [118] Eric Dumazet           5 (+29) [ 53] Menglong Dong      
   6 ( +1) [ 79] Willem de Bruijn       6 (***) [ 51] Chia-Yu Chang      
   7 (+17) [ 69] Vladimir Oltean        7 ( +7) [ 49] Tariq Toukan       
   8 ( -2) [ 68] Krzysztof Kozlowski    8 ( -5) [ 44] Jijie Shao         
   9 (***) [ 47] Kalesh Anakkur Purayil 9 ( -4) [ 38] Yunsheng Lin       
  10 (***) [ 46] Ido Schimmel          10 (***) [ 31] Joe Damato         

As a reminder - the "scores" are a measure of patches posted vs reviewed.
The positive side is self-explanatory, on the right side we have some
folks who are revising big patch sets and performing conversions.
While slightly negative scores are likely okay, I hope that those with
negative scores will reflect on their contributions.


Company rankings
----------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 (   ) [47] RedHat                  1 (   ) [100] RedHat             
   2 (   ) [33] Meta                    2 (   ) [ 83] Meta               
   3 ( +1) [18] Andrew Lunn             3 (   ) [ 64] Google             
   4 ( -1) [18] Intel                   4 (   ) [ 51] Andrew Lunn        
   5 (   ) [16] Google                  5 (   ) [ 50] Intel              
   6 ( +1) [ 8] nVidia                  6 ( +1) [ 20] Linaro             
   7 ( +2) [ 7] Broadcom                7 ( -1) [ 18] nVidia             

Top authors (cs):                    Top authors (msg):                  
   1 (   ) [14] RedHat                  1 (   ) [69] Intel               
   2 ( +3) [ 8] Intel                   2 ( +1) [58] RedHat              
   3 ( +1) [ 7] Meta                    3 ( -1) [39] Huawei              
   4 ( -1) [ 7] Google                  4 ( +1) [35] Meta                
   5 ( -3) [ 6] Huawei                  5 ( -1) [33] nVidia              
   6 ( +6) [ 5] Minerva Networks        6 ( +5) [30] Minerva Networks    
   7 ( -1) [ 4] nVidia                  7 (+10) [27] NXP                       

Top scores (positive):               Top scores (negative):              
   1 (   ) [532] RedHat                 1 (   ) [140] Huawei             
   2 (   ) [448] Meta                   2 ( +2) [119] Minerva Networks   
   3 (   ) [328] Andrew Lunn            3 (***) [ 55] OpenVPN            
   4 (   ) [258] Google                 4 (+20) [ 54] ZTE                
   5 (   ) [118] Linaro                 5 (***) [ 51] Nokia              
   6 ( +2) [ 97] Broadcom               6 (+13) [ 36] Marvell            
   7 (+15) [ 52] Intel                  7 (+21) [ 32] MediaTek           
-- 
Code: https://github.com/kuba-moo/ml-stat
Raw output: https://netdev.bots.linux.dev/static/nipa/stats-6.13/stdout

