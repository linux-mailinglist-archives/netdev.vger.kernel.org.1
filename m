Return-Path: <netdev+bounces-36533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D75BE7B051F
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 15:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 92F09281998
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 13:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A05430F86;
	Wed, 27 Sep 2023 13:18:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87111CAB6
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 13:18:35 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BA411D;
	Wed, 27 Sep 2023 06:18:34 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1qlUQv-0005W0-Vx; Wed, 27 Sep 2023 15:18:30 +0200
Message-ID: <86d04b92-1b1e-4676-95e3-87e8e0082526@leemhuis.info>
Date: Wed, 27 Sep 2023 15:18:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] virtio: features
Content-Language: en-US, de-DE
To: Michael Roth <michael.roth@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, eperezma@redhat.com, jasowang@redhat.com,
 shannon.nelson@amd.com, xuanzhuo@linux.alibaba.com,
 yuanyaogoog@chromium.org, yuehaibing@huawei.com,
 Thomas Lendacky <thomas.lendacky@amd.com>
References: <20230903181338-mutt-send-email-mst@kernel.org>
 <20230926130451.axgodaa6tvwqs3ut@amd.com>
From: "Linux regression tracking #adding (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20230926130451.axgodaa6tvwqs3ut@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1695820714;72be5b6d;
X-HE-SMSGID: 1qlUQv-0005W0-Vx
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 26.09.23 15:04, Michael Roth wrote:
> On Sun, Sep 03, 2023 at 06:13:38PM -0400, Michael S. Tsirkin wrote:
>>       virtio_net: merge dma operations when filling mergeable buffers
> 
> This ^ patch (upstream commit 295525e29a) seems to cause a
> network-related regression when using SWIOTLB in the guest. I noticed
> this initially testing SEV guests, which use SWIOTLB by default, but
> it can also be seen with normal guests when forcing SWIOTLB via
> swiotlb=force kernel cmdline option. I see it with both 6.6-rc1 and
> 6.6-rc2 (haven't tried rc3 yet, but don't see any related changes
> there), and reverting 714073495f seems to avoid the issue.
> 
> Steps to reproduce:
> > [...]

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 295525e29a
#regzbot title virtio: network-related regression when using SWIOTLB in
the guest
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

