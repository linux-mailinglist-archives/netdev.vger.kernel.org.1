Return-Path: <netdev+bounces-194270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABA8AC83A8
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 23:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 811853AECE5
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 21:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D762327A7;
	Thu, 29 May 2025 21:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hsb1pmrT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088831D63D8;
	Thu, 29 May 2025 21:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748555036; cv=none; b=KwFnTXa3xWSR1LOklBV057lLx99axo4ySZ4DdIsLpSMKn/AiuDz06DTeFEGEPO53ynKd+KzOZstR2t726BUbsWnLIOG5oXXA8QG+fhqu6MsQFhktwc0H8yttYbs+oystQVVwo9W3RNJfWrjDuk8/gIfzQwJHePrcaf71sQ4EDio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748555036; c=relaxed/simple;
	bh=RzCq13qVUqhaAnooGFRb1EFnQxfVj6kzQo+aqwWQN2k=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=Mss6Bz3WxB0SPAo294y5ZEKiLMa7fnb525/6llO0hXOVk/Pfuf7tUOWg8Yd3Hd1CQwZ/IUM/vVw3YI1j5g3RXq+3tXlMd3R2V8GfXVdundkgMz69NpDlOs0Ej6qX1S1UDDjlbOPMkRAwNEAf5NT1ltNQNYAKooLOjK4F4e1LOHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hsb1pmrT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E42FC4CEE7;
	Thu, 29 May 2025 21:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748555035;
	bh=RzCq13qVUqhaAnooGFRb1EFnQxfVj6kzQo+aqwWQN2k=;
	h=Date:From:To:Subject:From;
	b=Hsb1pmrT1rnK0vvKPycmQI3m8T3oi2Clnkcd6q6K9vUWMyhz9jdzO0A0Gq+x1REQE
	 cAyyy8XnHiyZkBw+z6su8PmYQ1izLFLmYCExnckd2f0nqZamTjwxFfOSwCLX4hSu/Z
	 Hai8e9IBIzynwslKwv/udcomBveCd/iRK4Cdmt27QNb/06FcUvwOlorFZjUdfctHgT
	 gNsjXCMHzNbfyWv7ZS5JhsaOzPby6jdzXqngVhweHifwv24Y4445OxGjXnDQOH263n
	 M6fn0XnZLE26Hsd+XBK1lM7fYyhkU/pB57VzPjHQ7mxGtEydR7NuCo5UQTGMmhiBRe
	 /yafcfwcMhcNw==
Date: Thu, 29 May 2025 14:43:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] netdev development stats for 6.16
Message-ID: <20250529144354.4ca86c77@kernel.org>
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
 - for 6.13: https://lore.kernel.org/20241119191608.514ea226@kernel.org
 - for 6.14: https://lore.kernel.org/20250121200710.19126f7d@kernel.org
 - for 6.15: https://lore.kernel.org/20250326140948.18a7da36@kernel.org

General stats
-------------

This release was around 10% smaller for us than usual, at 20
patches committed by the maintainers a day. The cross-company
review percentage increased, 64.4% of changes were reviewed 
by someone from a different company. Other metrics are quite stable.

Testing
-------

https://netdev.bots.linux.dev/devices.html now shows the matrix
of which tests pass on which driver. For now it only shows virtio
as we don't have any results for real HW.

Top contributions to selftests:
   1 [ 11] Jakub Kicinski
   2 [ 10] Cong Wang
   3 [  8] David Wei
   4 [  7] Hangbin Liu
   5 [  6] Mina Almasry
   6 [  5] Gang Yan
   7 [  4] Stanislav Fomichev
   8 [  4] Geliang Tang
   9 [  4] Matthieu Baerts
  10 [  4] Vladimir Oltean

Developer rankings
------------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 (   ) [26] Jakub Kicinski          1 (   ) [61] Jakub Kicinski      
   2 (   ) [24] Simon Horman            2 (   ) [46] Simon Horman        
   3 (   ) [14] Andrew Lunn             3 (   ) [41] Andrew Lunn         
   4 (   ) [13] Paolo Abeni             4 ( +2) [25] Paolo Abeni         
   5 ( +8) [ 5] Jacob Keller            5 (+17) [16] Jacob Keller        
   6 ( +1) [ 5] Kuniyuki Iwashima       6 ( +2) [15] Kuniyuki Iwashima   
   7 ( +1) [ 4] Stanislav Fomichev      7 ( +3) [13] Stanislav Fomichev  
   8 ( -2) [ 4] Russell King            8 ( -3) [12] Russell King        
   9 ( +1) [ 4] Willem de Bruijn        9 ( -5) [11] Willem de Bruijn    
  10 (+19) [ 3] Vadim Fedorenko        10 (***) [10] Donald Hunter       
  11 ( -2) [ 3] Michal Swiatkowski     11 (+12) [ 9] Mina Almasry        
  12 ( -7) [ 3] Eric Dumazet           12 ( +5) [ 9] Krzysztof Kozlowski 
  13 ( +2) [ 2] Krzysztof Kozlowski    13 (+12) [ 7] Stefano Garzarella  
  14 (+11) [ 2] Maxime Chevallier      14 ( -3) [ 6] Joe Damato          
  15 ( -3) [ 2] Rob Herring            15 (+30) [ 5] Vadim Fedorenko     

Jacob and Vadim climb up the ranks, reviewing PTP changes but also
other driver patches. Maxime stepped up participation on embedded
system reviews which is very much appreciated. Mina reviews netmem,
devmem and page pool patches. Stefano actively maintains vsock,
and Donald - YNL.

Thank you to all the reviewers for their invaluable work!

Top authors (cs):                    Top authors (msg):                  
   1 (   ) [6] Jakub Kicinski           1 (   ) [28] Jakub Kicinski      
   2 ( +1) [3] Russell King             2 ( +7) [25] Kuniyuki Iwashima   
   3 (***) [3] Vladimir Oltean          3 ( +9) [18] Tony Nguyen         
   4 ( +2) [2] Kuniyuki Iwashima        4 (+19) [17] Chia-Yu Chang       
   5 ( -1) [2] Heiner Kallweit          5 (***) [16] Byungchul Park      
   6 (+17) [2] Wentao Liang             6 (+36) [16] Christian Marangi (Ansuel)
   7 ( +5) [2] Stanislav Fomichev       7 (+26) [13] Alejandro Lucero Palau
   8 ( +9) [2] Lorenzo Bianconi         8 (***) [11] Jeff Layton         
   9 (+12) [1] Jiayuan Chen             9 (***) [11] Pablo Neira Ayuso   
  10 (+29) [1] Kees Cook               10 ( -7) [11] Russell King        

Top scores (positive):               Top scores (negative):              
   1 (   ) [356] Simon Horman           1 (+11) [68] Chia-Yu Chang       
   2 (   ) [347] Jakub Kicinski         2 (***) [64] Byungchul Park      
   3 (   ) [252] Andrew Lunn            3 (+27) [60] Christian Marangi (Ansuel)
   4 (   ) [185] Paolo Abeni            4 ( +5) [55] Tony Nguyen         
   5 ( +6) [ 68] Jacob Keller           5 (+17) [52] Alejandro Lucero Palau
   6 ( -1) [ 61] Willem de Bruijn       6 (***) [44] Ivan Vecera         
   7 (***) [ 57] Stanislav Fomichev     7 (***) [44] Jeff Layton         
   8 ( +1) [ 49] Krzysztof Kozlowski    8 ( -7) [38] Antonio Quartulli   
   9 (+15) [ 44] Vadim Fedorenko        9 (***) [35] Lukasz Majewski     
  10 ( -4) [ 40] Rob Herring           10 (***) [35] Christian Brauner   

Company rankings
----------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 (   ) [40] RedHat                  1 (   ) [104] RedHat             
   2 (   ) [31] Meta                    2 (   ) [ 87] Meta               
   3 (   ) [17] Intel                   3 (   ) [ 52] Intel              
   4 (   ) [14] Andrew Lunn             4 ( +1) [ 41] Andrew Lunn        
   5 (   ) [11] Google                  5 ( -1) [ 37] Google             
   6 (   ) [ 7] nVidia                  6 (   ) [ 16] nVidia             
   7 (   ) [ 6] Oracle                  7 (   ) [ 16] Oracle              

Top authors (cs):                    Top authors (msg):                  
   1 ( +1) [13] Meta                    1 (   ) [72] Intel               
   2 ( -1) [ 9] RedHat                  2 (   ) [58] Meta                
   3 ( +1) [ 8] Intel                   3 (   ) [52] RedHat              
   4 ( -1) [ 6] Google                  4 ( +1) [44] Google              
   5 (   ) [ 5] nVidia                  5 ( +3) [28] Amazon              
   6 (   ) [ 4] Oracle                  6 ( -2) [28] nVidia              
   7 (+29) [ 3] Marvell                 7 ( +6) [25] AMD              

Top scores (positive):               Top scores (negative):              
   1 (   ) [488] RedHat                 1 ( +8) [70] AMD                 
   2 (   ) [356] Meta                   2 ( +8) [68] Nokia               
   3 (   ) [252] Andrew Lunn            3 (***) [64] SK Hynix            
   4 ( +1) [ 64] Linaro                 4 (+18) [60] Christian Marangi (Ansuel)
   5 ( +5) [ 54] Enfabrica              5 (+13) [52] Linutronix          
   6 (   ) [ 45] ARM                    6 (***) [50] Microsoft           
   7 (   ) [ 45] Oracle                 7 ( -5) [38] OpenVPN      
   8 ( -4) [ 42] Google

The companies which support reviewers are quite stable.

Any company on the "negative score" side is a net consumer of code
reviews and should prioritize truly participating in the community.

Google's drop to 8th position is somewhat interesting, I think it's
primarily due to lower activity from Eric, and increase in gve patches.
-- 
Code: https://github.com/kuba-moo/ml-stat
Raw output: https://netdev.bots.linux.dev/static/nipa/stats-6.16/stdout

