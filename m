Return-Path: <netdev+bounces-17582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EB9752158
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 14:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBA0A281CA6
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 12:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6679883E;
	Thu, 13 Jul 2023 12:37:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89E44C7A
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 12:37:10 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED38B10D4
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 05:37:08 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1qJvZ6-0006Dr-U9; Thu, 13 Jul 2023 14:37:00 +0200
Message-ID: <425eba3b-0138-81d1-f615-97fc24b2d51d@leemhuis.info>
Date: Thu, 13 Jul 2023 14:37:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Performance Regression due to ASPM disable patch
Content-Language: en-US, de-DE
To: Anuj Gupta <anuj20.g@samsung.com>, hkallweit1@gmail.com,
 davem@davemloft.net
Cc: holger@applied-asynchrony.com, kai.heng.feng@canonical.com,
 simon.horman@corigine.com, nic_swsd@realtek.com, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <CGME20230712155834epcas5p1140d90c8a0a181930956622728c4dd89@epcas5p1.samsung.com>
 <20230712155052.GA946@green245>
From: "Linux regression tracking #adding (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20230712155052.GA946@green245>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1689251829;d2920fe0;
X-HE-SMSGID: 1qJvZ6-0006Dr-U9
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 12.07.23 17:55, Anuj Gupta wrote:
> 
> I see a performance regression for read/write workloads on our NVMe over
> fabrics using TCP as transport setup.
> IOPS drop by 23% for 4k-randread [1] and by 18% for 4k-randwrite [2].
> 
> I bisected and found that the commit
> e1ed3e4d91112027b90c7ee61479141b3f948e6a ("r8169: disable ASPM during
> NAPI poll") is the trigger.
> When I revert this commit, the performance drop goes away.
> 
> The target machine uses a realtek ethernet controller
> [...]

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced e1ed3e4d91112027b90c7ee61479141b3f94
#regzbot title net: r8169: performance regression for read/write
workloads on our NVMe over fabrics
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

