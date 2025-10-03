Return-Path: <netdev+bounces-227703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C69BB5A7F
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 02:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3423F3B1171
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 00:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BBF23CB;
	Fri,  3 Oct 2025 00:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5oJCaEj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B927117D2;
	Fri,  3 Oct 2025 00:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759450233; cv=none; b=YKzVcA6jfAD1MkJHtUvEAic8lVp5c2W2pymObmETuUhXv6VNYAw36e1bv+vn7WT7O9ScsIsRAuBjbUUz4dNqR6yqgyVOML5XfyMy/z+JXR4+s52k9EsBREi2tH+Dt4WTadY9UL9V0qzQ2ggwjMZCYCkveqGXYf70Swqr59QedOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759450233; c=relaxed/simple;
	bh=WnhTpiRL2IQdATvFoGF6qgy8YJ+52NfcAN3WsMQg+vE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=fSgnN2rc25ywt+lS2w6Wx6wa4AJWDNwJ1s+gNATCcROs3+KB8FG+cRtK+RQlh/hCc4Nkn3l0GT1F4ul5PF/VMyeavY+j4qm5VIIry2Cwqda8JNYsj8zo7T5qGUd8CPANjp/nET4wg9zak0egQubwLeY2TLr71BDdksY0ugbImIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5oJCaEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 280B7C4CEFB;
	Fri,  3 Oct 2025 00:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759450233;
	bh=WnhTpiRL2IQdATvFoGF6qgy8YJ+52NfcAN3WsMQg+vE=;
	h=Date:From:To:Subject:From;
	b=G5oJCaEjNywX5CllbrC1NLPmoM0Z1fRn86KfaS/s9e7HsPCiQcKE3jQOxJIn5rE2K
	 lQIHv6n/1mhVatjj6Ib5KGTDtBUQTBfvNNSf4rPQ9nkpWXDoYZrli5MDK84WfdMaGv
	 JJKA0JwhgfTw/bpUAyguDC8pte4fNyejRy26wP/i63MIHZD74XcCroV7MQYTbkrghe
	 m04sUkE5busvnbR1akjbK/MLb11iaFvm1cjtBu2dXlt7WIr0PsSJ522SJQv01krpSi
	 fdetNKqEm5KL1xMCpeEm+77Of3guH70PP7VQf104Pe2RxSI8w5I5UtfBSuoh4z6q6X
	 6mNT45skgLJJA==
Date: Thu, 2 Oct 2025 17:10:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] netdev development stats for 6.18
Message-ID: <20251002171032.75263b18@kernel.org>
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

In particular "review score" tries to capture the balance between
reviewing other people's code vs posting patches. It's roughly
number of patches reviewed minus number of patches posted. 
Those who post more than they review will have a negative score.

Previous 3 reports:
 - for 6.15: https://lore.kernel.org/20250326140948.18a7da36@kernel.org
 - for 6.16: https://lore.kernel.org/20250529144354.4ca86c77@kernel.org
 - for 6.17: https://lore.kernel.org/20250728160647.6d0bb258@kernel.org

General stats
-------------

The 6.18 release was very similar in size to 6.17 for the overall kernel,
only -0.3% change in the number of patches queued in linux-next when
the merge window opened.

For netdev 6.18 was +4% larger in terms of commits merged by core
maintainers than 6.17 (which in turn was 3% larger than 6.16). 
We have seen -3% fewer messages on the list (previous delta was 
also negative: -1%).

Average number of revisions of a patchset decreased by -2%.

Testing
-------

Proportion of test commits went up by 3% (from 8% to 11% of all commits
touching the selftests directory). This is mostly due to efforts of 
a handful of people, the number of unique contributors to selftest 
unfortunately went down from 44 to 41.

Contributions to selftests:
   1 [ 41] Jakub Kicinski
   2 [ 20] Kuniyuki Iwashima
   3 [ 18] Petr Machata
   4 [ 16] Matthieu Baerts
   5 [ 13] Ido Schimmel
   6 [  7] Hangbin Liu
   7 [  4] Geliang Tang
   8 [  3] Stanislav Fomichev
   9 [  3] Eric Dumazet
  10 [  3] Dimitri Daskalakis

Kuniyuki added a solid chunk of packetdrill tests for TCP Fast Open.
Petr cleaned up bash helpers and their use of defer constructs.
Metthieu worked on MPTCP tests, and Ido on routing tests. 

I should mention that the stats only cover work applied by core
networking maintainers, work done by trees which send us PRs 
(Netfilter for instance) does not show up here.

Developer rankings
------------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 (   ) [33] Jakub Kicinski          1 (   ) [70] Jakub Kicinski      
   2 (   ) [22] Simon Horman            2 ( +1) [46] Andrew Lunn         
   3 (   ) [17] Andrew Lunn             3 ( -1) [44] Simon Horman        
   4 (   ) [ 7] Paolo Abeni             4 (   ) [17] Paolo Abeni         
   5 (   ) [ 6] Eric Dumazet            5 (   ) [16] Eric Dumazet        
   6 ( +7) [ 6] Russell King            6 (   ) [15] Willem de Bruijn    
   7 ( +4) [ 5] Vadim Fedorenko         7 ( +7) [14] Russell King        
   8 ( -2) [ 4] Kuniyuki Iwashima       8 (   ) [12] Kuniyuki Iwashima   
   9 ( +5) [ 4] Aleksandr Loktionov     9 ( +2) [12] Vadim Fedorenko     
  10 (+15) [ 4] Paul Menzel            10 ( -3) [12] Krzysztof Kozlowski 
  11 ( -3) [ 3] Willem de Bruijn       11 (+14) [11] Vladimir Oltean     
  12 (   ) [ 3] Jacob Keller           12 (+23) [ 9] Michael S. Tsirkin  
  13 ( -4) [ 3] Rob Herring            13 ( +7) [ 8] Aleksandr Loktionov 
  14 ( -4) [ 3] Krzysztof Kozlowski    14 ( -1) [ 8] Mina Almasry        
  15 ( +1) [ 3] Vladimir Oltean        15 ( +2) [ 7] Rob Herring         

Russell King returns to top 10 maintainers after a short period of
lower activity. Reviewing various PHY / phylink and embedded networking
patches, when he's not busy untangling stmmac :)

Vadim continues to review PTP but increasingly also other driver patches.

Aleksandr focuses on driver reviews, similarly to Paul Menzel who specifically
reviews Intel driver patches.

The list doesn't cover the less frequent reviews, but all review work
is appreciated! Thank you all!

Top authors (cs):                    Top authors (msg):                  
   1 (   ) [6] Jakub Kicinski           1 (   ) [25] Jakub Kicinski      
   2 (   ) [5] Eric Dumazet             2 (+49) [24] Russell King        
   3 ( +8) [4] Russell King             3 (   ) [22] Kuniyuki Iwashima   
   4 (***) [3] Daniel Golle             4 ( +9) [18] Daniel Zahka        
   5 (   ) [3] Alok Tiwari              5 ( -1) [16] Tony Nguyen         
   6 (   ) [3] Tariq Toukan             6 ( +5) [15] Eric Dumazet        
   7 ( +3) [2] Heiner Kallweit          7 ( +7) [15] Marc Kleine-Budde   
   8 ( -5) [2] Kuniyuki Iwashima        8 (+11) [14] Tariq Toukan        
   9 (+13) [2] Hangbin Liu              9 (+11) [13] Fan Gong            
  10 (***) [2] Matthieu Baerts         10 (+20) [12] Laura Nao           

Daniel Zahka worked on adding PSP support. Fan Gong hinic3 driver.
Alok sends a lot of fixes and improvements to random code.
One could speculate what technology lays behind those patches
but the patches are generally solid :)

Laura Nao resends a 27 patch series for MediaTek clock drivers,
which is of moderate relevance to netdev, but stats are stats.

The remaining names should be familiar.

Top scores (positive):               Top scores (negative):              
   1 ( +1) [436] Jakub Kicinski         1 ( +7) [68] Daniel Zahka        
   2 ( -1) [338] Simon Horman           2 (+11) [52] Fan Gong            
   3 (   ) [304] Andrew Lunn            3 (+12) [51] Marc Kleine-Budde   
   4 (   ) [104] Paolo Abeni            4 ( +1) [50] Tony Nguyen         
   5 (   ) [ 96] Willem de Bruijn       5 (+17) [50] Laura Nao           
   6 ( +1) [ 67] Vadim Fedorenko        6 ( -5) [45] Chia-Yu Chang       
   7 ( -1) [ 62] Krzysztof Kozlowski    7 (+18) [42] Tariq Toukan        
   8 (   ) [ 55] Rob Herring            8 (***) [42] David Hildenbrand   
   9 (   ) [ 49] Eric Dumazet           9 (***) [42] Christian Brauner   
  10 (+19) [ 48] Paul Menzel           10 (***) [40] Amery Hung          


Company rankings
----------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 ( +1) [39] Meta                    1 ( +1) [98] Meta                
   2 ( -1) [33] RedHat                  2 ( -1) [86] RedHat              
   3 (   ) [17] Intel                   3 (   ) [47] Google              
   4 ( +1) [17] Andrew Lunn             4 ( +1) [46] Andrew Lunn         
   5 ( -1) [13] Google                  5 ( -1) [37] Intel               
   6 ( +2) [ 8] Oracle                  6 ( +2) [25] Oracle              
   7 (   ) [ 6] nVidia                  7 ( -1) [17] nVidia       

Top authors (cs):                    Top authors (msg):                  
   1 (   ) [12] Meta                    1 (   ) [86] Meta                
   2 ( +1) [10] RedHat                  2 ( +1) [57] RedHat              
   3 ( -1) [10] Google                  3 ( -1) [54] Google              
   4 ( +1) [ 8] Intel                   4 ( +2) [50] Intel               
   5 ( -1) [ 7] nVidia                  5 ( -1) [43] nVidia              
   6 ( +1) [ 7] Oracle                  6 (+13) [29] Oracle              
   7 (***) [ 3] Daniel Golle            7 ( +1) [23] Pengutronix          

Top scores (positive):               Top scores (negative):              
   1 ( +1) [340] Meta                   1 ( +8) [70] Collabora           
   2 ( -1) [337] RedHat                 2 ( +8) [68] Qualcomm            
   3 (   ) [304] Andrew Lunn            3 ( +2) [66] Pengutronix         
   4 (   ) [ 80] Intel                  4 ( -1) [60] nVidia              
   5 (   ) [ 76] Linaro                 5 ( -4) [54] Huawei              
   6 (   ) [ 73] Google                 6 (***) [51] Broadcom            
   7 (   ) [ 65] ARM                    7 ( -5) [45] Nokia            

The aforementioned cross-poster Laura Nao works at Collabora.
Broadcom ranking gets pretty negative due to multiple revisions
the patches for their new driver are going.

Meta (very narrowly) interrupts Red Hat's period of domination across
the rankings.
-- 
Code: https://github.com/kuba-moo/ml-stat
Raw output: https://netdev.bots.linux.dev/static/nipa/stats-6.18/stdout

