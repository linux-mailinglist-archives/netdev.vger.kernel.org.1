Return-Path: <netdev+bounces-47728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F3F7EB0E8
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 14:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B6BF1C2082D
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 13:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8103FE5A;
	Tue, 14 Nov 2023 13:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433CE3FE48
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 13:30:43 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3D91AD;
	Tue, 14 Nov 2023 05:30:41 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1r2tV1-0005lF-JY; Tue, 14 Nov 2023 14:30:39 +0100
Message-ID: <0442b8d1-f01c-4ac4-97ca-d69d76eca25f@leemhuis.info>
Date: Tue, 14 Nov 2023 14:30:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL v2] Networking for 6.7
Content-Language: en-US, de-DE
To: Linux kernel regressions list <regressions@lists.linux.dev>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231028011741.2400327-1-kuba@kernel.org>
 <20231031210948.2651866-1-kuba@kernel.org>
 <20231109154934.4saimljtqx625l3v@box.shutemov.name>
From: "Linux regression tracking #adding (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20231109154934.4saimljtqx625l3v@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1699968641;a106b028;
X-HE-SMSGID: 1r2tV1-0005lF-JY

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 09.11.23 16:49, Kirill A. Shutemov wrote:
> On Tue, Oct 31, 2023 at 02:09:48PM -0700, Jakub Kicinski wrote:
>>       bpf: Add support for non-fix-size percpu mem allocation
> 
> Recent changes in BPF increased per-CPU memory consumption a lot.
> 
> On virtual machine with 288 CPUs, per-CPU consumtion increased from 111 MB
> to 969 MB, or 8.7x.
> 
> I've bisected it to the commit 41a5db8d8161 ("bpf: Add support for
> non-fix-size percpu mem allocation"), which part of the pull request.

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 41a5db8d8161
#regzbot title bpf: recent changes in BPF increased per-CPU memory
consumption a lot.
#regzbot monitor:
https://lore.kernel.org/all/20231110172050.2235758-1-yonghong.song@linux.dev/
#regzbot fix: bpf: Do not allocate percpu memory at init stage
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

