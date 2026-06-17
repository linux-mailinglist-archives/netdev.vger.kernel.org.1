Return-Path: <netdev+bounces-300231-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FaSNB0PuMmo87wUAu9opvQ
	(envelope-from <netdev+bounces-300231-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 20:58:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B31669C0C7
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 20:58:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FnBgHNnm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300231-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300231-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 909F5305832E
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 18:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0031733A9FF;
	Wed, 17 Jun 2026 18:53:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462AA379C3D
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 18:53:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781722402; cv=none; b=VBCMFTdSPLQx3sOohVCrxh+EG2kqpvjMGDohvSwEN3WEV+fycKQW+etV73iuydx6Ble7bWEf+CzDvMCQoYwj4bj7UbwM8NBHiIDe8tkB/Tb+Mg+gszNrP4E45y2tpxrNpSeVfFgdArQfhzlBznaBJwS5N1YcmfV4Ci4Y8MlZeXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781722402; c=relaxed/simple;
	bh=jOzXJ38G62+ejotyN1Zn/QiYLNngaoanJuA6DTjVR2g=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=FSyIel6PZ2xi/G/SYFFaBiNi5TzE0uBohe2UDD/r7r4XEhOg+OZdHZ70IIgImTgvgR2x708wSancCPAYpRwxT54qBjaC6FT3ve/OGWgcBVgx2+ile2TJZ1drRxmj/eZwyDu8nXxl0gVrfIHWPpciwJDHoS5DNYUmUWEBfq8entE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnBgHNnm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2AA31F000E9
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 18:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781722401;
	bh=2jkmPASWSejKP+NLZalrA/3K/g3cgH/gJEwyOOWqgzI=;
	h=Date:From:To:Subject;
	b=FnBgHNnmptBWxegekq4GvRwmE9p1SXsphjhu1IDke3A7YnQfwkIeIgOrxxslgnAfO
	 GJSPlFLAWoBf7Kzk1LKvitoF/OgPY3w+fa5tdszGOWxMGTuMAC+1dHVEPcFeCCi2EM
	 atU1jvGIpbm70aELqh2wnNYOKq0xyn+Q8vnihvOFczAP8r12KeoYXggm6XPpmFCtxI
	 IhHiG8PQpQtnll3bGUgSWkRDQ5Ji/TxLAKrarbPbHnHFvIny7Xgeaf25jwa15JVMjD
	 v2mhnoPvUiP8yXFHFh6G8c1IbKyRMC7AZD+gvWSQpKx6Y/YWA7QVhi06OI883wYqXB
	 hYYMs6leC7wDw==
Date: Wed, 17 Jun 2026 11:53:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Subject: [ANN] netdev development stats for 7.2
Message-ID: <20260617115319.43a5942d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300231-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B31669C0C7

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
 - for 6.19: https://lore.kernel.org/20251202175548.6b5eb80e@kernel.org
 - for 7.0:  https://lore.kernel.org/20260212124208.187e53ae@kernel.org
 - for 7.1:  https://lore.kernel.org/20260414182653.40d84ccc@kernel.org

General stats
-------------

The increase in traffic continues. Reading the stats below keep in mind
that the previous release to which we're comparing was already a record
release in every aspect.

We saw an average of 339 emails a day on netdev, which is +6.5%
compared to the 7.1 cycle. Number of commits merged by netdev
maintainers directly grew even faster to 29 / day (+20.9%) compared
to the previous release. The commit growth is similar to growth of
linux-next as a whole (+22.6%). There were 1011 individuals posting
code or participating in discussions (+15.7%).

Review percentage continues to slip, from 53.36% in previous release 
to 50.84% in the current release.

Average revisions of a patch went down to 1.38 (-4.9%) for single
posting, and down to 2.13 (-2.9%) for multi-patch series.
These are approximate since I'm not sure I trust our series tracking
with folks renaming series across revisions. One more factor to keep
in mind is that we include in the stat only patch sets which were
merged. Last but not least since we try to prioritize patches from
active reviewers we tend to commit more patches from experts who rarely
need revisions (*cough* Eric) than new comes who need a lot of help.

Tenure histograms
-----------------

Tenure histograms are meant to measure how well we're doing at
converting one-off contributors to long term community members.
"no commit" means that someone posted a patch but no commit was
found under their name in git.

    Time since poster's first commit in 6.18
    no commit |  76 | *******************************
     0- 3mo   |  33 | **************
     3- 6mo   |  18 | *******
    6mo-1yr   |  30 | ************

    Time since poster's first commit in 7.1
    no commit | 107 | ********************************************
     0- 3mo   |  61 | *************************
     3- 6mo   |  15 | ******
    6mo-1yr   |  29 | ************

    Time since poster's first commit in 7.2
    no commit | 130 | *****************************************************
     0- 3mo   |  95 | **************************************
     3- 6mo   |  25 | *********
    6mo-1yr   |  34 | ************

The 0-3mo bucket are pretty much people who had the first commit in 7.2.
The 3-6mo bucket can be viewed as people who stuck around for 2 releases.
It seems like the number of one-off contributors is growing by 50% release
to release, with retention dropping. We shall have a more definite
signal after the next release cycle.

AI reviews
----------

I suspect we are more or less accustomed to the reviews now. Sashiko
has been updated to mark the pre-existing issues more explicitly which
is very helpful.

The overall quality of the reviews still leaves a lot to be desired,
especially when it comes to driver code.

I have been waiting to get access to OpenAI GPT models. In local use,
having the models cross review each others work drives down the false
positives noticeably. Unfortunately, the model access is getting restricted.
For those working at large corporations, at least, LLM inference used
to be a matter of adding a service to a cloud account. Since we had a CI 
for netdev adding LLMs was easy. Now, paperwork and policies prevent
us / me from accessing GPT. Anthropic made Fable available with 30 day
prompt retention, which, of course, also got it blocked in most corps.

We used to be ahead of the game with Chris's and Roman's effort. Now it
feels like (some would say subsidized) $20 LLM subscription buys much
more LLM access than we can access in our CIs. Ironically, I think this
is the inverse of the problem some in the community were predicting 
(individual contributors will have hard time because corps will have
access to very powerful models). Of course, things change very fast,
they may be proven right tomorrow.

Testing
-------

I was complaining that the number of patches to selftests remains at
10%, this release shows that things can be worse. The fraction of
patches adding tests dropped to 8% (-2%), from 152 -> 147 patches.

On the other hand it's great to see others take the #1 and #2 slots!
Thanks Allison and Matthieu!

Contributions to selftests:
   1 [ 27] Allison Henderson
   2 [ 13] Matthieu Baerts
   3 [ 13] Jakub Kicinski
   4 [  9] Victor Nogueira
   5 [  8] Bobby Eshleman
   6 [  7] Wei Wang
   7 [  6] Minxi Hou
   8 [  6] Willem de Bruijn
   9 [  4] Daniel Borkmann
  10 [  4] Fernando Fernandez Mancera
  11 [  4] Ido Schimmel
  12 [  4] Tushar Vyavahare
  13 [  4] Qingfang Deng

In the last report I mentioned that we started testing on real HW.
I can think of at least 3 bugs we caught using our HW CI.

Developer rankings
------------------

Top reviewers (cs):                  Top reviewers (msg): 
   1 (   ) [50] Jakub Kicinski          1 (   ) [116] Jakub Kicinski     
   2 (   ) [27] Simon Horman            2 ( +1) [ 53] Andrew Lunn        
   3 (   ) [21] Andrew Lunn             3 ( -1) [ 42] Simon Horman       
   4 (   ) [18] Paolo Abeni             4 (   ) [ 30] Paolo Abeni        
   5 (   ) [11] Eric Dumazet            5 (   ) [ 17] Eric Dumazet       
   6 (+10) [ 7] Ido Schimmel            6 ( +7) [ 12] Ido Schimmel       
   7 (+13) [ 6] Jacob Keller            7 (+31) [ 12] David Laight       
   8 (+20) [ 6] David Laight            8 ( -1) [ 12] Aleksandr Loktionov
   9 ( -3) [ 5] Kuniyuki Iwashima       9 (+27) [ 11] Jacob Keller       
  10 ( -2) [ 5] Aleksandr Loktionov    10 ( -2) [ 10] Kuniyuki Iwashima  
  11 (+32) [ 5] Jiayuan Chen           11 (+22) [ 10] Stanislav Fomichev 
  12 ( -2) [ 4] Krzysztof Kozlowski    12 ( -3) [  9] Willem de Bruijn   
  13 ( +2) [ 4] Maxime Chevallier      13 ( +4) [  8] Maxime Chevallier  
  14 (+44) [ 4] Alexander Lobakin      14 ( -2) [  8] Sabrina Dubroca    
  15 ( -6) [ 3] Willem de Bruijn       15 (+12) [  8] Nikolay Aleksandrov

The number of people stepping up to help with reviews is definitely
a bright spot in the patch avalanche. We have some gaps, of course,
but there's quite a few people I can tell are intentionally helping
out. Thank you all so much!

Individual shout outs this cycle go to.. Ido who recently became a L3
(IPv4/IPv6 etc) co-maintainer, but is also helping in other areas.
Intel folks (Jake, Olek, Aleks) stepped up driver reviews after a brief
absence ;) Since Ido works at nVidia, we are now in a position where
the two biggest vendor-contributors are solidly "in the green" when
it comes to review / authorship balance!

Jiayuan Chen has been helping review and triage a lot of security /
bug reports. We're really glad to see this progress, keep it up!

Also big thanks to Maxime, without Maxime we would be in a pretty
bad place in phylink / embedded reviews now that Russell (hopefully
temporarily?) stepped away from this work.

Top authors (cs):                    Top authors (msg):                  
   1 (   ) [11] Eric Dumazet            1 ( +1) [30] Eric Dumazet        
   2 (   ) [ 6] Jakub Kicinski          2 ( +3) [27] Tariq Toukan        
   3 ( +4) [ 4] Tariq Toukan            3 ( +4) [24] Jakub Kicinski      
   4 ( +2) [ 4] Lorenzo Bianconi        4 (+13) [24] Wei Fang            
   5 (***) [ 4] Selvamani Rajagopal     5 (+41) [19] Pablo Neira Ayuso   
   6 ( +7) [ 3] Weiming Shi             6 (+13) [18] Lorenzo Bianconi    
   7 ( +2) [ 3] Kuniyuki Iwashima       7 ( -3) [18] Kuniyuki Iwashima   
   8 (***) [ 3] Michael Bommarito       8 (+13) [17] Ratheesh Kannoth    
   9 ( +9) [ 3] Rosen Penev             9 (***) [15] Breno Leitao        
  10 (***) [ 3] David Laight           10 (***) [13] javen               
  11 (***) [ 2] Wentao Liang           11 (***) [12] Luiz Angelo Daros de Luca
  12 (+40) [ 2] Breno Leitao           12 (+24) [12] Chuck Lever         
  13 (***) [ 2] Samuel Moelius         13 (***) [11] Matthieu Baerts     
  14 ( -3) [ 2] David Carlier          14 (***) [11] Simon Wunderlich    
  15 (***) [ 2] Ren Wei                15 (***) [10] Jason Xing     

With some exceptions the "top authors by message" is populated with
folks who needed a lot of revisions of large series.

On the change set side we have a mix of core work (Eric, Jakub, Kuniyuki),
vendor submissions (Tariq, Selvamani), refactoring (Breno), "cleanups"
(David L, Rosen), presumably AI-driven fixes (Weiming, Wentao, Michael B,
Samuel M, Ren Wei, David C).

Top scores (positive):               Top scores (negative):              
   1 (   ) [768] Jakub Kicinski         1 ( +1) [91] Tariq Toukan        
   2 (   ) [376] Simon Horman           2 ( +8) [86] Wei Fang            
   3 (   ) [346] Andrew Lunn            3 ( +4) [67] Ratheesh Kannoth    
   4 (   ) [265] Paolo Abeni            4 (***) [54] javen               
   5 ( +4) [ 91] Ido Schimmel           5 ( +6) [49] Lorenzo Bianconi    
   6 (+14) [ 74] David Laight           6 (***) [48] Luiz Angelo Daros de Luca
   7 (   ) [ 62] Krzysztof Kozlowski    7 (***) [43] Simon Wunderlich    
   8 ( +2) [ 57] Aleksandr Loktionov    8 (***) [38] Chuck Lever         
   9 (+12) [ 50] Nikolay Aleksandrov    9 (+18) [38] Grzegorz Nitka      
  10 ( -4) [ 49] Willem de Bruijn      10 (***) [35] Pablo Neira Ayuso   
  11 ( +3) [ 49] Sabrina Dubroca       11 (***) [35] Markus Stockhausen  
  12 (+41) [ 47] Alexander Lobakin     12 (***) [34] Selvamani Rajagopal 
  13 (+24) [ 47] Maxime Chevallier     13 (***) [34] Jason Xing          
  14 ( -6) [ 46] David Ahern           14 ( -8) [33] Illusion Wang       
  15 (***) [ 43] Jiayuan Chen          15 (***) [30] Minxi Hou       
 
One process note on the reviewer score. Tariq tops the negative list. 
I've been returning to the question of whether it's fair since 
he has to handle submissions of most of nVidia's patches.
Still, I don't understand why reading thru the list and reviewing
one patchset from another company a day is too much to ask.

Company rankings
----------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 (   ) [54] Meta                    1 (   ) [135] Meta               
   2 (   ) [53] RedHat                  2 (   ) [109] RedHat             
   3 ( +2) [21] Andrew Lunn             3 ( +2) [ 53] Andrew Lunn        
   4 (   ) [19] Intel                   4 (   ) [ 46] Intel              
   5 ( -2) [18] Google                  5 ( -2) [ 42] Google             
   6 (   ) [17] nVidia                  6 (   ) [ 37] nVidia             
   7 (+12) [ 6] David Laight            7 (+15) [ 12] David Laight       
   8 ( +2) [ 5] Bootlin                 8 ( +1) [ 11] SUSE               
   9 ( -1) [ 5] Linaro                  9 ( -1) [ 11] Linaro       

Top authors (cs):                    Top authors (msg):                  
   1 (   ) [19] Google                  1 (   ) [88] Meta                
   2 ( +1) [14] Meta                    2 ( +1) [70] Google              
   3 ( -1) [12] RedHat                  3 ( +1) [69] Intel               
   4 (   ) [12] Intel                   4 ( -2) [56] RedHat              
   5 ( +1) [ 9] nVidia                  5 ( +1) [54] nVidia              
   6 ( +1) [ 4] Microsoft               6 ( +1) [38] NXP                 
   7 (***) [ 4] Onsemi                  7 (+10) [26] Marvell             
   8 (+10) [ 3] Weiming Shi             8 ( +2) [23] Qualcomm            
   9 (***) [ 3] Michael Bommarito       9 ( -1) [21] Microsoft               

Top scores (positive):               Top scores (negative):              
   1 ( +1) [616] RedHat                 1 (   ) [133] NXP                
   2 ( -1) [608] Meta                   2 ( +7) [ 95] Marvell            
   3 (   ) [346] Andrew Lunn            3 ( +3) [ 63] Qualcomm           
   4 ( +4) [ 74] David Laight           4 (***) [ 54] Realsil            
   5 (+28) [ 58] nVidia                 5 (***) [ 48] Luiz Angelo Daros de Luca
   6 ( -1) [ 46] Linux Foundation       6 (***) [ 43] Simon Wunderlich & co.
   7 ( -3) [ 42] Linaro                 7 ( +7) [ 41] AMD                
   8 (***) [ 37] Shopee                 8 ( -6) [ 35] Microsoft          
   9 ( +1) [ 36] ARM                    9 ( +3) [ 35] Oracle                 

As already mentioned nVidia moves to the green zone.
Shopee is Jiayuan Chen. ARM and Linaro are device tree reviewers.

The negative side is primarily HW vendors dumping code. Without
Vladimir's participation NXP takes the smelly cake. Marvell is
not much better (less bad?).

A reminder that we rank patches for maintainer review based
on the "review standing" of the submitter and their company.
This used to matter much less, because historically I'd try to keep
the number of patches in patchwork around 100 at the end of each day.
These days it feels impossible to get it to 200, because we receive
over 150 patches every working day. If you think maintainers take
forever to look at your code - it's probably your review standing.
-- 
Code: https://github.com/kuba-moo/ml-stat
Raw output: https://netdev.bots.linux.dev/ml-stats/stats-7.2

