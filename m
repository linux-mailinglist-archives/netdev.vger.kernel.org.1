Return-Path: <netdev+bounces-160181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45295A18AE8
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 05:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 856ED163B67
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 04:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC50A156C62;
	Wed, 22 Jan 2025 04:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpQb/6XQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A901B95B;
	Wed, 22 Jan 2025 04:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737518831; cv=none; b=NGsBdRdx6bj2o2pagfTMVjdT6VnNwQ5PxgSDHW2sJgwkzs2wR0wawdlxEyupkZPH5uy95cMSzKsc0Al1TLsELar7K6CXS33QD3ZvNJ2mKGJ/9dKCJg+orGdLmLGQG5RK5y6fL9PEZv2UNm8Jcwj2PvQlnHx1Z0eYtd95E6MI+5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737518831; c=relaxed/simple;
	bh=VKnne71ohDfJwaUdVyHTcVTkNw8GJ5RdMygDgUAYcAM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=Gk2ydBB2AJ0lz9J1yzBKGodYvZ5O19/jDMpxzCOOIJK5urqhcZ02sLGwiU/FYHDUbBWh/Iurk+maTKYJ4bqPeZ+AbMYMSe0a2vQRJgFmlWuSJ+fvtahgaVXeBFj6yhnLOWNYv8CxS8+lNuxRCVe0JBe3rdGfDI59WnR3dp0b7WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpQb/6XQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF55C4CED6;
	Wed, 22 Jan 2025 04:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737518831;
	bh=VKnne71ohDfJwaUdVyHTcVTkNw8GJ5RdMygDgUAYcAM=;
	h=Date:From:To:Subject:From;
	b=OpQb/6XQCF6ctzMjU3LzCDG6Se9n2G8WCTLyQGMoVPKtwM3U4p7WsB964O+5rjqW0
	 B2RV01dst2A8xXCPh5sKx/RiiPULk1/h4fKZobodcLtoXwZDBYo7wTuk1tD2lmdeoY
	 GzdYFueMy6v0Ar4naW1hMXagbomCFO5EpOzBC3nrM842N9UAQewUU7U1c6f3tvg+/O
	 MncVu1erGnBxR0EUczmXaFi8X6PU4WHS5rdVDS9ApSEydnmhpIF9ni/goYzzi+HhMb
	 kUbAyqOiePm2qnCMcOJIlnqznEE9QaLVwlwKJBNhjpNE1CF4OgJLLzDuG8XfzBChiC
	 kIqtzAov0tqaw==
Date: Tue, 21 Jan 2025 20:07:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] netdev development stats for 6.14
Message-ID: <20250121200710.19126f7d@kernel.org>
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

General stats
-------------

The stats for 6.14 are heavily skewed by the winter break.
Jon Corbet very usefully highlighted this in the LWN stats
(linked above). By my math linux-next material queued at the time of
the start of the merge window is around 21% lighter for 6.14
than it was for 6.13. Given that the release cycle is 9 weeks long,
a 21% drop translates to roughly 2 weeks of vacation time.
A disturbingly sane amount of vacation time to take at the end
of the year :)

If we correct our data by the overall linux-next size - the number
of messages on the list dropped by 5.4% while the number of commits
rose by 14.2% (-25.6% and -11.3% if not corrected). Perhaps people who
take vacations at the end of the year are more likely to be reviewers
than authors. This theory is also supported by a 5% drop in the review
rate (8% drop in cross-company reviews).

One new metric I extracted this time was the number of authors
we have not heard from on the mailing list. They are authors in
the git tree, but someone else submitted their patches, and they
participated in zero mailing list threads. They make up 5.1% 
of all names collected on the list, and 7.4% of authors according 
to git logs. Glancing at the list of names, these are mostly vendor
employees, here are the domains with more than one email address on 
the "ghost author" list:

   10  nvidia.com
    5  huawei.com
    3  broadcom.com
    3  intel.com

Normally any domain list is heavily dominated by gmail.com, so the fact
that gmail did not make this list indicates strong non-randomness..
Goes without saying that it's not great that there are people
who write code for the Linux kernel who never interact with the list.

Testing
-------

The number of ignored test cases in netdev CI decreased further from 
14 to just 5. We have 2 performance tests which are flaky in our CI
(*not* on debug kernel). One test for TCP Auth Option regressed, and
then we have a big mystery of the TCP "loopback" test causing a spurious
IRQ on QEMU (!?).

Overall contributions to the selftest decreased significantly, which
is very sad. Only 4.8% of all commits were touching selftests.

Contributions to selftests:
   1 [ 11] Jakub Kicinski
   2 [  5] Matthieu Baerts
   3 [  5] Petr Machata
   4 [  4] Soham Chakradeo
   5 [  3] Breno Leitao
   6 [  3] Danielle Ratson
   7 [  2] Vladimir Oltean
   8 [  2] Sabrina Dubroca
   9 [  2] Hangbin Liu


Developer rankings
------------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 ( +1) [24] Jakub Kicinski          1 (   ) [56] Jakub Kicinski      
   2 ( +1) [15] Andrew Lunn             2 ( +1) [43] Andrew Lunn         
   3 ( -2) [15] Simon Horman            3 ( -1) [24] Simon Horman        
   4 (   ) [ 8] Paolo Abeni             4 (   ) [17] Eric Dumazet        
   5 (   ) [ 8] Eric Dumazet            5 (   ) [13] Paolo Abeni         
   6 (***) [ 4] Michal Swiatkowski      6 ( +1) [12] Vladimir Oltean     
   7 ( +9) [ 3] Przemek Kitszel         7 ( +4) [11] Russell King        
   8 ( -1) [ 3] Russell King            8 (***) [ 8] Michal Swiatkowski  
   9 ( +2) [ 3] Krzysztof Kozlowski     9 ( +5) [ 8] Martin KaFai Lau    
  10 ( -2) [ 3] Willem de Bruijn       10 ( -4) [ 7] Willem de Bruijn    
  11 ( -1) [ 3] Vladimir Oltean        11 (+24) [ 7] Przemek Kitszel     
  12 (+19) [ 3] Alexander Lobakin      12 (   ) [ 6] Jacob Keller        
  13 (+10) [ 2] Joe Damato             13 (***) [ 6] Jonathan Cameron    
  14 ( -1) [ 2] Kalesh Anakkur Purayil 14 ( -5) [ 6] Krzysztof Kozlowski 
  15 ( -9) [ 2] Kuniyuki Iwashima      15 ( +5) [ 6] Joe Damato          

Simon slips a little bit, he took a longer break than Andrew and I.
There are 4 names from Intel in top 15, which is really great to see.
Michal jumps into top 10 with Przemek not far behind him.
The rest is mostly minor movement of the familiar names.

Thank you all very much for your invaluable work!


Top authors (cs):                    Top authors (msg):                  
   1 ( +1) [5] Eric Dumazet             1 (+20) [26] Russell King        
   2 ( +2) [5] Jakub Kicinski           2 ( +6) [19] Antonio Quartulli   
   3 (+17) [2] Russell King             3 ( -1) [19] Kuniyuki Iwashima   
   4 (***) [2] Tian Xin                 4 ( +1) [19] Tariq Toukan        
   5 (+13) [2] Tariq Toukan             5 (+32) [17] Jakub Kicinski      
   6 ( -3) [2] Heiner Kallweit          6 (   ) [17] David Howells       
   7 ( -1) [2] Kuniyuki Iwashima        7 (+34) [15] Oleksij Rempel      
   8 (   ) [1] David Alan Gilbert       8 (+12) [13] Kory Maincent (Dent Project)
   9 (+26) [1] Dan Carpenter            9 (+19) [13] Alejandro Lucero Palau
  10 (***) [1] Furong Xu               10 (+26) [11] David Wei           

No surprises on the author list, with Russell sending a lot of phylink-
and EEE-related patches. Antonio continues revising ovpn patches.
Tian Xin submitted the Yunsilicon driver. Furong Xu works on stmmac.


Top scores (positive):               Top scores (negative):              
   1 ( +1) [346] Jakub Kicinski         1 ( +2) [76] Antonio Quartulli   
   2 ( +1) [265] Andrew Lunn            2 ( +5) [65] Tariq Toukan        
   3 ( -2) [201] Simon Horman           3 ( -1) [64] David Howells       
   4 (   ) [103] Paolo Abeni            4 (+14) [52] Alejandro Lucero Palau
   5 (   ) [ 90] Eric Dumazet           5 ( +6) [50] Kory Maincent (Dent Project)
   6 (***) [ 53] Michal Swiatkowski     6 (***) [46] Russell King        
   7 (+24) [ 51] Przemek Kitszel        7 (+26) [46] David Wei           
   8 ( -1) [ 46] Vladimir Oltean        8 ( +9) [40] Tony Nguyen         
   9 ( -3) [ 43] Willem de Bruijn       9 (***) [40] Oleksij Rempel      
  10 ( -2) [ 39] Krzysztof Kozlowski   10 (***) [39] Kuniyuki Iwashima   


Company rankings
----------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 ( +1) [27] Meta                    1 ( +1) [68] Meta                
   2 ( -1) [25] RedHat                  2 ( -1) [57] RedHat              
   3 ( +1) [19] Intel                   3 ( +2) [49] Intel               
   4 ( -1) [15] Andrew Lunn             4 (   ) [43] Andrew Lunn         
   5 (   ) [12] Google                  5 ( -2) [32] Google              
   6 ( +2) [ 5] Linaro                  6 ( +3) [13] NXP                 
   7 ( +3) [ 4] Oracle                  7 ( +5) [13] Oracle              

Top authors (cs):                    Top authors (msg):                  
   1 (   ) [9] RedHat                   1 (   ) [48] Intel               
   2 ( +2) [8] Google                   2 (   ) [42] RedHat              
   3 ( -1) [7] Intel                    3 ( +1) [39] Meta                
   4 ( -1) [7] Meta                     4 ( -1) [31] Huawei              
   5 ( +2) [5] nVidia                   5 (   ) [31] nVidia              
   6 ( +7) [3] Oracle                   6 (+11) [28] Oracle              
   7 ( +9) [2] Linaro                   7 (+15) [23] Pengutronix         
        
Top scores (positive):               Top scores (negative):              
   1 ( +1) [329] Meta                   1 (   ) [92] Huawei              
   2 ( +1) [265] Andrew Lunn            2 ( +1) [76] OpenVPN             
   3 ( -2) [238] RedHat                 3 (***) [54] Pengutronix         
   4 ( +3) [125] Intel                  4 ( +2) [53] Marvell             
   5 ( -1) [116] Google                 5 ( +5) [50] Dent                
   6 ( -1) [ 70] Linaro                 6 (***) [45] nVidia              
   7 ( -1) [ 39] Broadcom               7 (+12) [43] AMD                 

The usual mix of vendors and contractors populate the list of companies
with a negative review balance.
-- 
Code: https://github.com/kuba-moo/ml-stat
Raw output: https://netdev.bots.linux.dev/static/nipa/stats-6.14/stdout

