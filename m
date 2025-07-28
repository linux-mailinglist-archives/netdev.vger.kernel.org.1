Return-Path: <netdev+bounces-210684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15292B14489
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 01:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366C6189B780
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 23:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10007217F53;
	Mon, 28 Jul 2025 23:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLxpIddI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BAA1DF723;
	Mon, 28 Jul 2025 23:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753744009; cv=none; b=N7nXQj9N1cWsD6UunrFTX2Yak1CKvMK7rx/vx2if3G/m2FlsT1qzcRlNZt0j65DSHcoY79kwegjwoJRRWYA2ggl3qIi1bSqyPS98VEKNdfNRXMf/fVObXeyQhXci4BMDTn9yn+TAUhBHF46duX+qVR02y/0HzZ5xUZLC805CaZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753744009; c=relaxed/simple;
	bh=BO/JPDHuahKjh7ilQxJ60rmNG7hK/8ffxPardaRfhCM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=buDnH475nnldXcQ56anMMlllrCGOhe+1rs11ZrfMMZu1wDemaK41TNJd1iaPhPtxF+ktKyAxNKNoo7DUTQZqnyo0FmFe25ffAlHlLNVD+3053UQDIvQ2rxfukftGpEj0mtOFLaPivGBQHJ6twTFTpUcbDXZxBwcnsZl8XveT4e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLxpIddI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7CFC4CEE7;
	Mon, 28 Jul 2025 23:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753744008;
	bh=BO/JPDHuahKjh7ilQxJ60rmNG7hK/8ffxPardaRfhCM=;
	h=Date:From:To:Subject:From;
	b=SLxpIddIj6WbPCcF+UHSvg+/8Tz3e9PBD0DaLclxRjicb0OscLvQ/Y7Bpeb/0NHXf
	 izsR1xAiT7v9TzNqyWXYZl9ADeV7xSlTgy6V7ux5xN//xtTc6J2CqTIIV16UG1kZpA
	 7BIfkHQeLYA2NHvwjQnasvAJUqPLAjmOw7wPkKZ2XhGufjPvpiDpG0f1U7b918dQeC
	 kIw1qxgNIoBzEG3IarVdy6Axobww1aoi3yiYV/7Fm0kvbdcXNHkNEY7f6X8+nxzRwy
	 AVTvIMK+oNgzjBxZrcTDqfAcMY98tfoFR9gARH4peJwsrJNRgPjvT6QtwBBc52faM4
	 Vt9xtKER6AiDQ==
Date: Mon, 28 Jul 2025 16:06:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] netdev development stats for 6.17
Message-ID: <20250728160647.6d0bb258@kernel.org>
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
number of patches reviewed minus number of patches posted. Those who
post more than they review will have a negative score.

Previous 3 reports:
 - for 6.14: https://lore.kernel.org/20250121200710.19126f7d@kernel.org
 - for 6.15: https://lore.kernel.org/20250326140948.18a7da36@kernel.org
 - for 6.16: https://lore.kernel.org/20250529144354.4ca86c77@kernel.org

General stats
-------------

6.17 was similar size to 6.15 for us: -1% messages / day, +3% commits /
day. 6.16 was smaller for some reason, hence using 6.15 for comparison. 
The review coverage slipped slightly (-1.4%), which may be due to
people taking summer vacations. The percentage of commits with
selftests remained the same as in 6.16 at 8%.

Testing
-------

The number of tests is slowly creeping up. Recent test additions
(netconsole and tc flower) helped up catch some longstanding issues.
The main change on the test infra side was the addition of pylint,
yamllint and shellcheck to the checkers we run.

Contributions to selftests:
   1 [ 23] Jakub Kicinski
   2 [  8] Breno Leitao
   3 [  7] Eric Dumazet
   4 [  6] Mohsin Bashir
   5 [  5] Petr Machata
   6 [  4] Hangbin Liu
   7 [  4] Mina Almasry
   8 [  3] Daniel Zahka
   9 [  3] Gal Pressman
  10 [  3] Samiullah Khawaja

Developer rankings
------------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 (   ) [36] Jakub Kicinski          1 (   ) [73] Jakub Kicinski      
   2 (   ) [34] Simon Horman            2 (   ) [69] Simon Horman        
   3 (   ) [14] Andrew Lunn             3 (   ) [39] Andrew Lunn         
   4 (   ) [11] Paolo Abeni             4 (   ) [21] Paolo Abeni         
   5 ( +7) [ 7] Eric Dumazet            5 (+14) [16] Eric Dumazet        
   6 (   ) [ 5] Kuniyuki Iwashima       6 ( +3) [15] Willem de Bruijn    
   7 (   ) [ 4] Stanislav Fomichev      7 ( +5) [14] Krzysztof Kozlowski 
   8 ( +1) [ 4] Willem de Bruijn        8 ( -2) [12] Kuniyuki Iwashima   
   9 ( +6) [ 4] Rob Herring             9 ( -2) [12] Stanislav Fomichev  
  10 ( +3) [ 4] Krzysztof Kozlowski    10 ( +3) [11] Stefano Garzarella  
  11 ( -1) [ 4] Vadim Fedorenko        11 ( +4) [10] Vadim Fedorenko     
  12 ( -7) [ 4] Jacob Keller           12 ( -2) [10] Donald Hunter       
  13 ( -5) [ 3] Russell King           13 ( -5) [ 8] Russell King        
  14 ( +7) [ 3] Aleksandr Loktionov    14 ( -3) [ 8] Mina Almasry        
  15 (+15) [ 2] Cong Wang              15 ( +8) [ 8] Jason Wang          

The set of "top 15" reviewers was quite stable since 6.16, even tho
there was a bit of a shuffle in the bottom half of positions.

Krzysztof and Rob review device tree bindings, we wait for their
acks for all DT patches, so either there was more active discussions
or simply more DT patches in this release.

Stefano maintains and reviews vsock code, Donal - YNL, and Mina
participates in the zero-copy and page pool related discussions.

Vadim and Jacob continue to focus on PTP and general driver reviews.
Russell reviews mostly phylink, phy, and stmmac code on netdev.

Aleksandr Loktionov reviews Intel patches on intel-wired (with netdev
CCed, FWIW since these are Intel-to-Intel reviews they do not count 
to Intel's company score).

Thanks to all the reviewers for your invaluable work!

Top authors (cs):                    Top authors (msg):                  
   1 (   ) [7] Jakub Kicinski           1 (   ) [33] Jakub Kicinski      
   2 (+18) [4] Eric Dumazet             2 ( +2) [25] Chia-Yu Chang       
   3 (***) [3] Kuniyuki Iwashima        3 (***) [20] Kuniyuki Iwashima   
   4 (***) [3] Yue Haibing              4 ( -1) [19] Tony Nguyen         
   5 (+37) [2] Alok Tiwari              5 (***) [16] Mauro Carvalho Chehab
   6 ( +5) [2] Tariq Toukan             6 (+43) [16] Frank Wunderlich    
   7 (***) [2] Jason Xing               7 (+29) [16] Stephen Smalley     
   8 ( +6) [2] Oleksij Rempel           8 (+33) [16] Breno Leitao        
   9 (***) [2] Thomas Fourier           9 ( -4) [15] Byungchul Park      
  10 ( -5) [2] Heiner Kallweit         10 (***) [14] Mark Bloch          
  11 (+27) [2] Breno Leitao            11 (***) [14] Eric Dumazet        
  12 (-10) [2] Russell King            12 (+27) [14] Jijie Shao          
  13 (***) [1] Luka                    13 (***) [13] Daniel Zahka        
  14 (+19) [1] Johannes Berg           14 (+19) [12] Marc Kleine-Budde   
  15 (***) [1] Arnd Bergmann           15 ( -4) [12] Ivan Vecera         

The person called "Luka" sent a bunch of syzbot reports for 6.12,
which weren't particularly useful. Our methodology counts starting
a thread as a "posting". I think that's fairly reasonable, whether
it's a patch or a not-so-great report - someone has to spend time
investigating it; so counting it as a net consumer of upstream
attention seems fair. We do not know where that person works.

Top scores (positive):               Top scores (negative):              
   1 (   ) [529] Simon Horman           1 (   ) [99] Chia-Yu Chang       
   2 (   ) [461] Jakub Kicinski         2 (***) [66] Mauro Carvalho Chehab
   3 (   ) [245] Andrew Lunn            3 (+18) [65] Stephen Smalley     
   4 (   ) [139] Paolo Abeni            4 (+28) [64] Frank Wunderlich    
   5 ( +1) [ 81] Willem de Bruijn       5 ( -1) [64] Tony Nguyen         
   6 ( +2) [ 76] Krzysztof Kozlowski    6 ( -4) [61] Byungchul Park      
   7 ( +2) [ 63] Vadim Fedorenko        7 (***) [54] Mark Bloch          
   8 ( +2) [ 62] Rob Herring            8 (***) [51] Daniel Zahka        
   9 ( +3) [ 54] Eric Dumazet           9 (+20) [50] Jijie Shao          
  10 ( +4) [ 45] Stefano Garzarella    10 ( -4) [48] Ivan Vecera     

Company rankings
----------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 (   ) [48] RedHat                  1 (   ) [130] RedHat             
   2 (   ) [39] Meta                    2 (   ) [101] Meta               
   3 (   ) [22] Intel                   3 ( +2) [ 53] Google             
   4 ( +1) [17] Google                  4 ( -1) [ 48] Intel              
   5 ( -1) [14] Andrew Lunn             5 ( -1) [ 39] Andrew Lunn        
   6 ( +3) [ 7] Linaro                  6 (   ) [ 20] nVidia             
   7 ( -1) [ 7] nVidia                  7 ( +2) [ 18] Linaro          

Top authors (cs):                    Top authors (msg):                  
   1 (   ) [13] Meta                    1 ( +1) [98] Meta                
   2 ( +2) [12] Google                  2 ( +2) [66] Google              
   3 ( -1) [10] RedHat                  3 (   ) [56] RedHat              
   4 ( -1) [ 9] Intel                   4 ( +2) [55] nVidia              
   5 (   ) [ 8] nVidia                  5 (+14) [47] Huawei              
   6 ( +8) [ 6] Huawei                  6 ( -5) [47] Intel               
   7 ( -1) [ 4] Oracle                  7 ( +1) [25] Nokia                  

Top scores (positive):               Top scores (negative):              
   1 (   ) [648] RedHat                 1 (+25) [165] Huawei             
   2 (   ) [312] Meta                   2 (   ) [ 99] Nokia              
   3 (   ) [245] Andrew Lunn            3 (***) [ 94] nVidia             
   4 (+10) [166] Intel                  4 (***) [ 65] NSA                
   5 ( -1) [ 97] Linaro                 5 ( +3) [ 64] Pengutronix        
   6 (   ) [ 67] ARM                    6 (***) [ 64] OMNINET            
   7 ( +1) [ 63] Google                 7 ( -4) [ 61] SK Hynix  

Red Hat wins #1 as the net-reviewer, 3rd time in the row.
Intel jumps to #4 with (slightly) higher review rate and (much)
lower posting rate. I really need to come up with a systematic
way of benefiting companies who contribute to upstream reviews..

On the negative side we have Huawei (largely due to the many
re-postings for YNL-doc reformatting from Mauro). Chia-Yu Chang
secures the negative #2 position for Nokia with AccECN.
nVidia returns to negative #3, after going barely-positive in
the previous cycle (due to lower posting rate).
The NSA entry is from someone cross-posting a huge SELinux patch
set to netdev. SK Hynix, I believe, is due to Byungchul Park's
postings.
--
Code: https://github.com/kuba-moo/ml-stat
Raw output: https://netdev.bots.linux.dev/static/nipa/stats-6.17/stdout

