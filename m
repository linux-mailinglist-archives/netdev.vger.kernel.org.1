Return-Path: <netdev+bounces-258501-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBxTGCU7jmmeBAEAu9opvQ
	(envelope-from <netdev+bounces-258501-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 21:42:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0443F130FBE
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 21:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5DF08300E581
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 20:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3074318BBB;
	Thu, 12 Feb 2026 20:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwOzdblx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9070E30E0E5
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 20:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770928929; cv=none; b=FBsJmzHohm5YhSld/F+7O6vqt/K0aR1e3a4C08K1Qez3wLnEUoODvlhATCLlgrOUlg9EJARxWUow/NsyUOT2TEW1qUPk6YvXSXr0sIboSQVBwttehQB8OzPNRuXnJWUtuZq/LvvODSBUYLWRGcHqqfiA1LdfdXXD/r3IqlakX2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770928929; c=relaxed/simple;
	bh=KR94v7A5n1E6MBpMzGLplAcmAMcT7l0vvkDb/8Gw43g=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=MAEuHaGITN5k+TR6wEkoRQTJAMvV/gJCnnOaydiGw0PxMvyrf0Kwi5vjejvMgCmoiYWVi5erN4x9+awODtcM1ih5dEZjAw+7IlmKeska+7/8Jh1YHX31x4Guq4ELX7CvJJ38i6iWVcHpCr6qrIVuLyS5lqcs2YK6nc+Nj9RfIqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwOzdblx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5566AC4CEF7
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 20:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770928929;
	bh=KR94v7A5n1E6MBpMzGLplAcmAMcT7l0vvkDb/8Gw43g=;
	h=Date:From:To:Subject:From;
	b=YwOzdblxyphp5FzIaerd+sv38t3ApxADEnb99bE1MQiF0+5NMGmtevP2A3EZw5yIN
	 3aAfs9JD2qmt6bFXDF0Rr8AEQcuxXbp/pWtNieeZWI1TsUEOmu3W5SguPCakvZ4ANs
	 9/1OZR2SLAB7T7XxSyIwl3d3QGON5sdkwBj7fWI77rPyjFl2HwcgAieoRuYXMqnD8X
	 xLVJP7w97WTs9YyYxzF/CE56ctZXTfOYKbDlHKnqMd4VbIY7V0l9cLQOKSdgQv4qTP
	 m2tv9uYqGFllNtXVhz9lybYZYhX85Zizp2LADL/YG+gKhrOd+3moJAnuLJItsh6aSl
	 1V944nNzDIy4A==
Date: Thu, 12 Feb 2026 12:42:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Subject: [ANN] netdev development stats for 7.0 (and some AI review
 thoughts)
Message-ID: <20260212124208.187e53ae@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258501-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lwn.net:url,vger:email,linux.dev:url]
X-Rspamd-Queue-Id: 0443F130FBE
X-Rspamd-Action: no action

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
 - for 6.17: https://lore.kernel.org/20250728160647.6d0bb258@kernel.org
 - for 6.18: https://lore.kernel.org/20251002171032.75263b18@kernel.org 
 - for 6.19: https://lore.kernel.org/20251202175548.6b5eb80e@kernel.org

General stats
-------------

This was a significantly slower development cycle compared to the
previous one for us, with 14.5% less ML traffic and 20.9% fewer
commits. The ratio of cross-company review has slipped by 2%.
The lower traffic and commit volume can be partially explained
by Christmas / winter break, linux-next as a whole was also 13.2% 
smaller at the beginning of this merge window compared to
the previous one.

AI reviews
----------

Notably this was the first cycle in which we had AI code reviews
integrated fully and executed on every submission. I hope the
slight decline in human reviews isn't associated with AI integration.
Discouraging human participation is my main concern when it comes
to the AI reviews. The data supports the intuition that it is now harder
to get code merged (since AI catches more issues). The average number
of revisions for a series went up from 1.96 to 2.24. That said
(the average number of revisions for a single-patch postings dropped
slightly from 1.37 to 1.32.)

The AI integration has gone relatively smoothly from my perspective.
Of course there are some false positives and cases where AI sends
submitters down the wrong path. On balance, however, AI catches a lot
of valid issues (especially in dreaded error paths). This is in no small
part due to work Chris Mason continues to invest into improving the AI
prompts and workflow, and to netdev maintainers who try to pre-screen
the reviews. Eyeballing the internal graphs we have in NIPA the AI
reviews are completely wrong or not worth reporting about 13% of the
time. 

The main point of frustration with the AI reviews so far has been that
they are nondeterministic. AI may find new or different issues on each
posting. My understanding is that this is largely a question of
efficiency. AI can invent infinite potential issues to investigate,
and it explores them in somewhat random order. So each time we run 
the review a different set of problems gets explored. While we can't
change the "order of exploration", optimizing the efficiency of 
the agent lets us broaden the set of problems for every single review.
Chris has reworked the agent over the last month significantly,
to use sub-agents and to prepare the context of review a priori,
without the agent having to go back and forth fetching information.
This helps a lot for large code submissions.

Looking into the future I'd particularly like the AI reviews
to focus on validation of how interfaces are used or implemented,
on top of catching coding mistakes (and typos) which it does today.
Until now the agents seem to rarely consult Documentation/ or even
kdoc of invoked functions. I'm hoping that the evolution of these
systems will let us invest more time in improving Documentation/
now that something (even if not someone) will finally read it.
The future of writing instructions for bots ("CLAUDE.md") _in addition_
to documentation for humans is not particularly appealing.
Chris has already started working on pushing the AI workflow
more towards consulting Documentation/. We hope to see results soon.

Testing
-------

The percentage of commits adding selftest has crept up slightly
but still remains under 10%.

Top contributors of selftests:
   1 [ 15] Jakub Kicinski
   2 [ 13] Matthieu Baerts
   3 [  9] Bobby Eshleman
   4 [  7] Xu Du
   5 [  5] Felix Maurer
   6 [  5] David Wei
   7 [  5] Ido Schimmel
   8 [  4] Gal Pressman
   9 [  4] Victor Nogueira
  10 [  3] Daniel Zahka

One more note on testing, we have completed the migration of NIPA
to netdev foundation machines. Due to DRAM shortage, however, 
the shipment of additional machines is delayed.

Developer rankings
------------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 (   ) [27] Jakub Kicinski          1 (   ) [69] Jakub Kicinski      
   2 (   ) [15] Simon Horman            2 (   ) [28] Andrew Lunn         
   3 (   ) [14] Andrew Lunn             3 (   ) [24] Simon Horman        
   4 (   ) [11] Paolo Abeni             4 (   ) [17] Paolo Abeni         
   5 ( +1) [ 6] Eric Dumazet            5 ( +2) [13] Aleksandr Loktionov 
   6 ( +2) [ 4] Aleksandr Loktionov     6 ( +2) [12] Eric Dumazet        
   7 (   ) [ 4] Russell King            7 ( -1) [12] Russell King        
   8 ( +9) [ 4] Willem de Bruijn        8 (+11) [10] Willem de Bruijn    
   9 ( +7) [ 3] Rob Herring             9 ( +7) [ 9] Vladimir Oltean     
  10 ( +2) [ 3] Vadim Fedorenko        10 ( -1) [ 9] Michael S. Tsirkin  
  11 ( +3) [ 3] Vladimir Oltean        11 ( -6) [ 6] Maxime Chevallier   
  12 ( -7) [ 3] Maxime Chevallier      12 ( +8) [ 6] Rob Herring         
  13 ( -4) [ 3] Jacob Keller           13 ( -3) [ 6] Stefano Garzarella  
  14 ( +1) [ 3] Paul Menzel            14 (+18) [ 5] Krzysztof Kozlowski 
  15 (+13) [ 2] Krzysztof Kozlowski    15 ( -2) [ 5] Kuniyuki Iwashima   

Slight fluctuation within the top reviewer rankings. Most of the names
should be familiar. In addition to the maintainers, we have Aleksandr
and Jake from Intel reviewing Ethernet drivers. Russell, Maxime and
Vladimir focusing on embedded networking. Willem and Kuniyuki reviewing
core code. Rob and Krzysztof reviewing device tree changes. And Stefano
reviewing vsock patches. Paul Menzel reviews Intel driver patches.
Huge thanks to those who help with patch reviews!

Top authors (cs):                    Top authors (msg):                  
   1 (   ) [8] Eric Dumazet             1 ( +1) [20] Russell King        
   2 (***) [4] Ethan Nelson-Moore       2 ( +5) [16] Daniel Golle        
   3 (   ) [3] Jakub Kicinski           3 (***) [15] Ratheesh Kannoth    
   4 ( -2) [3] Russell King             4 (+21) [15] Chia-Yu Chang       
   5 (+30) [3] David Yang               5 ( +3) [15] Eric Dumazet        
   6 ( -2) [2] Tariq Toukan             6 (***) [13] Menglong Dong       
   7 (+27) [2] Daniel Golle             7 ( -4) [12] Tariq Toukan        
   8 ( -3) [1] Heiner Kallweit          8 (+15) [12] Wei Fang            
   9 ( +3) [1] Lorenzo Bianconi         9 (***) [10] Ivan Vecera         
  10 (+26) [1] Raju Rangoju            10 (+21) [10] Frederic Weisbecker 

Top scores (positive):               Top scores (negative):              
   1 (   ) [462] Jakub Kicinski         1 (***) [60] Ratheesh Kannoth    
   2 ( +1) [212] Andrew Lunn            2 (+12) [59] Chia-Yu Chang       
   3 ( -1) [205] Simon Horman           3 ( +2) [54] Daniel Golle        
   4 (   ) [133] Paolo Abeni            4 (***) [51] Menglong Dong       
   5 (   ) [ 78] Aleksandr Loktionov    5 (+18) [43] Wei Fang            
   6 ( +3) [ 64] Willem de Bruijn       6 (+12) [41] Frederic Weisbecker 
   7 ( +1) [ 53] Rob Herring            7 (+45) [41] Jacky Chou          

Frequent re-posters of large series dominate the negative review score
axis. Ratheesh reposting a new (copy of an) Octeon driver.
Chia-Yu Chang submitted AccECN patches which were successfully merged.
Daniel Golle contributes a lot of small embedded series (OpenWRT?).

Company rankings
----------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 ( +1) [31] Meta                    1 ( +1) [88] Meta                
   2 ( -1) [29] RedHat                  2 ( -1) [71] RedHat              
   3 (   ) [14] Intel                   3 (   ) [42] Intel               
   4 (   ) [14] Andrew Lunn             4 ( +1) [29] Google              
   5 (   ) [10] Google                  5 ( -1) [28] Andrew Lunn         
   6 (   ) [ 8] nVidia                  6 (   ) [20] nVidia              
   7 (   ) [ 6] Oracle                  7 (   ) [15] Oracle              

Top authors (cs):                    Top authors (msg):                  
   1 ( +2) [12] Google                  1 ( +1) [69] RedHat              
   2 (   ) [ 9] RedHat                  2 ( -1) [40] Meta                
   3 ( -2) [ 8] Meta                    3 (   ) [35] nVidia              
   4 ( +2) [ 5] nVidia                  4 ( +2) [28] Google              
   5 ( -1) [ 4] Intel                   5 ( +2) [28] Oracle              
   6 (***) [ 4] Ethan Nelson-Moore      6 ( +3) [23] NXP                 
   7 ( -2) [ 4] Oracle                  7 ( +3) [23] Huawei              

Top scores (positive):               Top scores (negative):              
   1 ( +2) [433] Meta                   1 ( +3) [71] Huawei              
   2 ( -1) [218] RedHat                 2 ( +8) [59] Nokia               
   3 ( -1) [212] Andrew Lunn            3 (+22) [56] Marvell             
   4 (   ) [162] Intel                  4 ( -2) [54] Daniel Golle        
   5 ( +2) [ 79] Google                 5 (***) [52] Tencent             
   6 ( -1) [ 55] ARM                    6 (+14) [45] Isovalent           
   7 ( +4) [ 34] Max-Planck             7 (***) [45] Kylin Software      

Huawei, Nokia and Marvell are in top 3 biggest net-consumers of reviews.
Nokia was contributing the AccECN support so perhaps it's a temporary
spike. The other two are constant on the negative side.
-- 
Code: https://github.com/kuba-moo/ml-stat
Raw output: https://netdev.bots.linux.dev/ml-stats/stats-7.0

