Return-Path: <netdev+bounces-278610-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGl/IGbp3mmOMQAAu9opvQ
	(envelope-from <netdev+bounces-278610-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 03:27:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 767643FF7FE
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 03:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 59904301D4A0
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 01:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDE7224AF7;
	Wed, 15 Apr 2026 01:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GH2N2O69"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDB54369A
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 01:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776216415; cv=none; b=VSzpBVEO9ybMr9oa8puJRycKisptBRy81LyTM4Dl2TqmEZMY/YcvPKbg685TGMFTMCcS9tNesN2ziHB4Bq7fRjXXmj/1qXCremKlaKTydSz4HAVb3hw7rpp7QF6KiVLvfStLZnyUUNMcwtdG9hm7+ocdUiaEUdvC9/aCoj5Y3as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776216415; c=relaxed/simple;
	bh=oURbeXAYoP4oBWxQmW9sf6+iLtbtOoZr0sP6/QNapH4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=YjJ96EBKGa2yMJxMirDIZSsPZd3huNVWSc5RzERUnmHQ34X4ixWvuoFdZki5NeqGfJX5/k0KNdiCxlRMbCes3hK50qGGJuTHOms2ShlqpZtLTlzlLOD6XSgdKPMMSDFYqXT8QsTku8a5vOxCrya78r/xMmt+P9pgGsR1i+j5myg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GH2N2O69; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0EDDC2BCB3
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 01:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776216414;
	bh=oURbeXAYoP4oBWxQmW9sf6+iLtbtOoZr0sP6/QNapH4=;
	h=Date:From:To:Subject:From;
	b=GH2N2O69GR9Razojry641qA5fEUM151m2GN50xEx33UkuYNDWhvD1yo8MXWHc1gFz
	 74etoH4mSeXq6zkIIuZSNvo8Fif+lqmBn25m06P6Zcri4Y+V5DQ48Bzl4Byoa0N561
	 0mQtVjgcLyFD7E7qHU+OuUU9yasHZ4LoDrBx1bQbdBBcIOs+b+lkCC+iGXjd7kRgS4
	 qTWB6SH+QKxCVVGLDXsIVCjqIVdq+oGxBLtoHM4oAiJykts+JMZyIlQDR3KUfJ65i5
	 ETg6tZVG8pfkjnXtqKmKyCV0EiRYeYfixw+wsbLm2sj7EFmNmNSk9LzEDZfVwu0K0e
	 A6d+60nd8/4Ig==
Date: Tue, 14 Apr 2026 18:26:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Subject: [ANN] netdev development stats for 7.1
Message-ID: <20260414182653.40d84ccc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	TAGGED_FROM(0.00)[bounces-278610-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 767643FF7FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi!

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
 - for 6.18: https://lore.kernel.org/20251002171032.75263b18@kernel.org 
 - for 6.19: https://lore.kernel.org/20251202175548.6b5eb80e@kernel.org
 - for 7.0:  https://lore.kernel.org/20260212124208.187e53ae@kernel.org

General stats
-------------

This has been subjectively a pretty crazy release. Last week especially.
It's bleakly reassuring to see that the numbers confirm how we feel.

Let us use 6.18 as a point of reference, since the last release of year
is usually the biggest one. 7.1 had the same linux-next size as 6.18.
The core networking maintainers committed slightly more changes than 
in the 6.18 cycle (1531 / 24 a day / +1.6%). The number of messages 
on the list was dramatically higher (318 msg a day / +21.0%), and so
was the number of people we've interacted with (874 / +12.0%).
The number of people may be slightly under-counted, we noticed that
some authors of semi-automated fixes share an email address(!?)

The tenure histograms confirm that we are dealing with a lot of
newcomers:

  Time since poster's first commit in 6.18
  no commit |  76 | **************************************************
   0- 3mo   |  33 | *********************
   3- 6mo   |  18 | ***********
  6mo-1yr   |  30 | *******************

  Time since poster's first commit in 7.1
  no commit | 107 | **************************************************
   0- 3mo   |  61 | ****************************
   3- 6mo   |  15 | *******
  6mo-1yr   |  29 | *************

In other words number of authors increased by 81, number of people with
less than 3mo since their first commit increased by 59. This is not
surprising but newcomers require a lot more hand holding. And something
tells me the churn of newcomers will only go up.

The review coverage continues to drop, and is now the lowest recorded
(42.9% of changes being reviewed by someone from a different company
than the author). At the same time patches are reposted more often,
with average number of revisions going up by 10%.

AI reviews
----------

In the previous cycle we have introduced a netdev AI review bot which
was using Chris Mason's review prompts. This cycle saw introduction
of Sashiko, which _seems_ much better at spotting bugs but most of the
bugs it finds are unrelated to the submission. Our bot intentionally
tried to exclude complaining about existing problems. Sashiko also 
"asks questions" about potentially issues which it is unsure are in
fact a problem. This may be fine during review in development, but
upstream it means that maintainers are now spending around 50% of their
time trying to disprove AI reviews. Last but not least because
the reviews are public immediately we have people reacting to them,
spamming the list and often incorporating incorrect feedback.

None of this is meant as a criticism of the tools. We are lucky
to have in the community people willing to invest their time
to build such tools, and companies willing to sponsor the LLM tokens.
That said, combination of extra work AI tools put on maintainers and
ease for newcomers to produce plausible but incorrect code is pushing 
us beyond our limits. Especially when the plausible looking code is
"fixing bugs" in 20 year old code which none of the current maintainers
have any interest in or frankly sense of responsibility for.

One more thing to note before I end this rant. The LLMs are expensive
and/or capacity constrained. While a lot of the issues could be
addressed by LLMs doing more research, the current prompts already
eat our entire budgets. Real engineering work is required to make
the LLMs more efficient by building tools and MCP endpoints around
the LLMs. It is hard to find time to do this work when we average 
150 patches send to the list on any working day.

I'd like us to gather up during the next bi-weekly call slot and
discuss some ideas on how we can survive the changes.

Testing
-------

Percentage of changes to selftests stubbornly remains at around 10% of
all commits. Here are the top contributors:

Contributions to selftests:
   1 [ 34] Jakub Kicinski
   2 [ 10] Ioana Ciornei
   3 [  7] Aleksei Oladko
   4 [  7] Simon Baatz
   5 [  6] Jiayuan Chen
   6 [  6] Dimitri Daskalakis
   7 [  6] Bobby Eshleman
   8 [  5] David Wei
   9 [  5] Allison Henderson
  10 [  4] Maciej Fijalkowski

Good news on the HW testing side, we now have machines with 4 NICs in
our labs (all the 25G+ NICs our supplier offered ;)) Broadcom BCM57508,
nVidia CX7, Intel X710, Intel E830. We have caught a number of issues
with them already.

Matrix of the tests vs NICs: https://netdev.bots.linux.dev/devices.html

Developer rankings
------------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 (   ) [48] Jakub Kicinski          1 (   ) [112] Jakub Kicinski     
   2 (   ) [31] Simon Horman            2 ( +1) [ 50] Simon Horman       
   3 (   ) [13] Andrew Lunn             3 ( -1) [ 34] Andrew Lunn        
   4 (   ) [11] Paolo Abeni             4 (   ) [ 22] Paolo Abeni        
   5 (   ) [10] Eric Dumazet            5 ( +1) [ 21] Eric Dumazet       
   6 (+13) [ 7] Kuniyuki Iwashima       6 ( +1) [ 19] Russell King       
   7 (   ) [ 7] Russell King            7 ( -2) [ 15] Aleksandr Loktionov
   8 ( -2) [ 5] Aleksandr Loktionov     8 ( +7) [ 13] Kuniyuki Iwashima  
   9 ( -1) [ 4] Willem de Bruijn        9 ( -1) [ 11] Willem de Bruijn   
  10 ( +5) [ 3] Krzysztof Kozlowski    10 ( +4) [  9] Krzysztof Kozlowski
  11 (***) [ 3] Joe Damato             11 ( -2) [  9] Vladimir Oltean    
  12 ( +5) [ 3] Florian Westphal       12 (+33) [  8] Sabrina Dubroca    
  13 (***) [ 3] Pablo Neira Ayuso      13 ( +9) [  7] Ido Schimmel       
  14 (   ) [ 3] Paul Menzel            14 (***) [  6] Joe Damato         
  15 ( -3) [ 3] Maxime Chevallier      15 (+21) [  6] Conor Dooley       

Lots of familiar names among top reviewers. Kuniyuki returned after
short absence, reviewing core networking, sockets, UNIX, TCP etc.
Joe reviewed various patches with no easily discernible theme (which
is perfectly fine :)). Sabrina reviews / maintains all things crypto
(ipsec, macsec, tls) which is of huge help. Ido is reliably helping
with IP / routing and bridge reviews. Pablo and Florian focus on
netfilter but there's quite a bit of cross posting. Thank you all!

Top authors (cs):                    Top authors (msg):                  
   1 (   ) [10] Eric Dumazet            1 (   ) [37] Russell King        
   2 ( +1) [ 5] Jakub Kicinski          2 ( +3) [23] Eric Dumazet        
   3 (***) [ 4] Jiayuan Chen            3 (***) [22] Jeff Layton         
   4 (***) [ 4] Aleksandr Loktionov     4 (***) [22] Kuniyuki Iwashima   
   5 ( -1) [ 4] Russell King            5 ( +2) [21] Tariq Toukan        
   6 ( +3) [ 3] Lorenzo Bianconi        6 (+21) [20] Vladimir Oltean     
   7 ( -1) [ 3] Tariq Toukan            7 ( +6) [17] Jakub Kicinski      
   8 (***) [ 2] Qingfang Deng           8 (+15) [16] Xuan Zhuo           
   9 ( +3) [ 2] Kuniyuki Iwashima       9 (+11) [15] Florian Westphal    
  10 (***) [ 2] Fernando Fernandez M.  10 ( +8) [15] Tony Nguyen         

Jiayuan Chen provided quite a few (quality) fixes across the stack.
Aleksandr cross posts Intel driver submissions quite a bit.
Russell continued to clean up stammac, AKA the Augean stables.
Lorenzo works on airoha, Qingfang on PPP and Fernando removed
the support for IPv6=m among other things.

Jeff cross posts NFS patches, bringing Meta's reviewer score down,
much to my chagrin. Don't tell him I said this :)

Top scores (positive):               Top scores (negative):              
   1 (   ) [769] Jakub Kicinski         1 (***) [84] Jeff Layton         
   2 ( +1) [440] Simon Horman           2 (+11) [67] Tariq Toukan        
   3 ( -1) [227] Andrew Lunn            3 (+22) [57] Xuan Zhuo           
   4 (   ) [170] Paolo Abeni            4 (+42) [41] Bhargava Chenna Marreddy
   5 ( +4) [ 73] Eric Dumazet           5 (***) [38] Larysa Zaremba      
   6 (   ) [ 65] Willem de Bruijn       6 (+15) [38] Illusion Wang       
   7 ( +1) [ 58] Krzysztof Kozlowski    7 ( -6) [37] Ratheesh Kannoth    
   8 ( +7) [ 39] David Ahern            8 ( +8) [37] Tony Nguyen         
   9 (+10) [ 38] Ido Schimmel           9 (***) [36] Satish Kharat       
  10 ( -5) [ 37] Aleksandr Loktionov   10 ( -5) [36] Wei Fang            

Number of people on the "negative review score" side are there because
they are struggling to get new drivers in because of the depth of the
AI reviews.

Company rankings
----------------

Note on company rankings - because of the volume of patches I now
completely depend on a UI which ranks submissions on various
"readiness" metrics. One of them is the company review score.
This is to say that having a negative review score will now
impact review latency by up to 2 days.

Top reviewers (cs):                  Top reviewers (msg):                
   1 (   ) [55] Meta                    1 (   ) [135] Meta               
   2 (   ) [47] RedHat                  2 (   ) [104] RedHat             
   3 ( +2) [16] Google                  3 ( +1) [ 45] Google             
   4 ( -1) [16] Intel                   4 ( -1) [ 45] Intel              
   5 ( -1) [13] Andrew Lunn             5 (   ) [ 34] Andrew Lunn        
   6 (   ) [11] nVidia                  6 (   ) [ 30] nVidia             
   7 (   ) [ 9] Oracle                  7 (   ) [ 26] Oracle          

Top authors (cs):                    Top authors (msg):                  
   1 (   ) [16] Google                  1 ( +1) [102] Meta               
   2 (   ) [14] RedHat                  2 ( -1) [ 73] RedHat             
   3 (   ) [12] Meta                    3 ( +1) [ 68] Google             
   4 ( +1) [11] Intel                   4 ( +4) [ 67] Intel              
   5 ( +2) [ 7] Oracle                  5 (   ) [ 50] Oracle             
   6 ( -2) [ 6] nVidia                  6 ( -3) [ 47] nVidia             
   7 (+12) [ 5] Microsoft               7 ( -1) [ 43] NXP                 

Top scores (positive):               Top scores (negative):              
   1 (   ) [556] Meta                   1 (+16) [112] NXP                
   2 (   ) [496] RedHat                 2 (***) [ 68] Microsoft          
   3 (   ) [227] Andrew Lunn            3 (+15) [ 59] Alibaba            
   4 ( +5) [ 88] Linaro                 4 (***) [ 45] Microchip          
   5 ( +3) [ 35] Linux Foundation       5 (+46) [ 45] Shopee             
   6 ( -1) [ 32] Google                 6 (***) [ 41] Qualcomm           
   7 (   ) [ 32] Max-Planck             7 ( -6) [ 38] Huawei            
-- 
Code: https://github.com/kuba-moo/ml-stat
Raw output: https://netdev.bots.linux.dev/ml-stats/stats-7.1

