Return-Path: <netdev+bounces-45568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF197DE641
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 20:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31F191C20A72
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 19:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D0518E1A;
	Wed,  1 Nov 2023 19:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934A6101CD
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 19:05:41 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFD7109;
	Wed,  1 Nov 2023 12:05:36 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1qyGX1-0007xH-G1; Wed, 01 Nov 2023 20:05:35 +0100
Message-ID: <78f59b5f-33d7-4b5b-9b7c-ee7a4647b35f@leemhuis.info>
Date: Wed, 1 Nov 2023 20:05:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Userland interface breaks due to hard HFSC_FSC
 requirement
Content-Language: en-US, de-DE
To: stable@vger.kernel.org, netdev@vger.kernel.org
Cc: regressions@lists.linux.dev
References: <297D84E3-736E-4AB4-B825-264279E2043C@flyingcircus.io>
From: "Linux regression tracking #update (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <297D84E3-736E-4AB4-B825-264279E2043C@flyingcircus.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1698865537;eec31a2d;
X-HE-SMSGID: 1qyGX1-0007xH-G1

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 06.10.23 10:37, Christian Theune wrote:
>
> I upgraded from 6.1.38 to 6.1.55 this morning and it broke my traffic shaping script, leaving me with a non-functional uplink on a remote router.
> [...]
> #regzbot introduced: a1e820fc7808e42b990d224f40e9b4895503ac40

#regzbot fix: net/sched: sch_hfsc: upgrade rt to sc when it becomes a
inner curve
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

