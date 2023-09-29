Return-Path: <netdev+bounces-37010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B787B3114
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 13:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 04B4E1C20927
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 11:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3467B1640B;
	Fri, 29 Sep 2023 11:12:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F1615AF9
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 11:12:28 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848ABBF;
	Fri, 29 Sep 2023 04:12:26 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1qmBPz-0006y6-Mo; Fri, 29 Sep 2023 13:12:23 +0200
Message-ID: <a7a2bf25-cfc1-47a8-baf4-487a8574fb5a@leemhuis.info>
Date: Fri, 29 Sep 2023 13:12:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] virtio: features
Content-Language: en-US, de-DE
From: "Linux regression tracking #update (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
To: Linux kernel regressions list <regressions@lists.linux.dev>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <20230903181338-mutt-send-email-mst@kernel.org>
 <20230926130451.axgodaa6tvwqs3ut@amd.com>
 <86d04b92-1b1e-4676-95e3-87e8e0082526@leemhuis.info>
In-Reply-To: <86d04b92-1b1e-4676-95e3-87e8e0082526@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1695985946;2c5a440b;
X-HE-SMSGID: 1qmBPz-0006y6-Mo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 27.09.23 15:18, Linux regression tracking #adding (Thorsten Leemhuis)
wrote:
> On 26.09.23 15:04, Michael Roth wrote:
>> On Sun, Sep 03, 2023 at 06:13:38PM -0400, Michael S. Tsirkin wrote:
>>>       virtio_net: merge dma operations when filling mergeable buffers
>>
>> This ^ patch (upstream commit 295525e29a) seems to cause a
>> network-related regression when using SWIOTLB in the guest. I noticed
>> this initially testing SEV guests, which use SWIOTLB by default, but
>> it can also be seen with normal guests when forcing SWIOTLB via
>> swiotlb=force kernel cmdline option. I see it with both 6.6-rc1 and
>> 6.6-rc2 (haven't tried rc3 yet, but don't see any related changes
>> there), and reverting 714073495f seems to avoid the issue.
>>
>> Steps to reproduce:
>>> [...]
> 
> Thanks for the report. To be sure the issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
> tracking bot:
> 
> #regzbot ^introduced 295525e29a
> #regzbot title virtio: network-related regression when using SWIOTLB in
> the guest
> #regzbot ignore-activity

Regzbot missed the fix due to a fluke:

#regzbot monitor:
https://lore.kernel.org/all/20230927055246.121544-1-xuanzhuo@linux.alibaba.com/
#regzbot fix: virtio_net: fix the missing of the dma cpu sync
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.



