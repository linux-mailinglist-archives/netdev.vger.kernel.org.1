Return-Path: <netdev+bounces-15772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CF7749B13
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 13:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D309728126D
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 11:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4C58C0F;
	Thu,  6 Jul 2023 11:46:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4388C05
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 11:46:02 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A14DB;
	Thu,  6 Jul 2023 04:46:00 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1qHNQr-0005yC-LV; Thu, 06 Jul 2023 13:45:57 +0200
Message-ID: <e1fdc435-089c-8ce7-d536-ce3780a4ba95@leemhuis.info>
Date: Thu, 6 Jul 2023 13:45:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: 3 more broken Zaurii - SL-5600, A300, C700
Content-Language: en-US, de-DE
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Ross Maynard <bids.7405@bigpond.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Linux Networking <netdev@vger.kernel.org>,
 Linux USB <linux-usb@vger.kernel.org>, Dave Jones <davej@codemonkey.org.uk>,
 Oliver Neukum <oneukum@suse.com>
References: <7ea9abd8-c35d-d329-f0d4-c8bd220cf691@gmail.com>
 <50f4c10d-260c-cb98-e7d2-124f5519fa68@gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <50f4c10d-260c-cb98-e7d2-124f5519fa68@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1688643961;684324a0;
X-HE-SMSGID: 1qHNQr-0005yC-LV
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 06.07.23 05:08, Bagas Sanjaya wrote:
> On 7/5/23 09:09, Bagas Sanjaya wrote:
>>
>> I notice a regression report on Bugzilla [1]. Quoting from it:
>>
>>> The following patch broke support of 3 more Zaurus models: SL-5600, A300 and C700
>>>
>>> [16adf5d07987d93675945f3cecf0e33706566005] usbnet: Remove over-broad module alias from zaurus

Side note: I wonder if the time spend on tracking and fighting
regressions from v3.0 would better be spend elsewhere. But whatever,
let's at least try.

>>> dmesg and lsusb output attached.
>>
>> Because the description above was vague, I asked the clarification.
>> The reporter replied:
>>
>>> The problem is that networking to SL-5600 / A300 / C700 devices does not 
>>> work. I cannot ping the devices.
>>>
>>> The error is occurring in zaurus.c. dmesg is missing the following line:
>>>
>>> zaurus 2-2:1.0 usb0: register 'zaurus' at usb-0000:00:1d.0-2, 
>>> pseudo-MDLM (BLAN) device, 2a:01:39:93:bc:1a
>>>
>>> A patch was created in 2022 to fix the same problem with the SL-6000:
>>>
>>> USB: zaurus: support another broken Zaurus - 
>>> [6605cc67ca18b9d583eb96e18a20f5f4e726103c]
>>>
>>> Could you please create another patch for the 3 devices: SL-5600 / A300 
>>> / C700?
>>
>> See Bugzilla for the full thread and attached dmesg and lsusb.
>>
>> Dave: The reporter asked to write the quirk for affected devices.
>> Would you like to create it?
> 
> Thorsten: Email to the culprit author (Dave) bounced.

He sometimes shows up on Linux kernel lists, but I doubt he cares about
that change after all these years. And I would not blame him at all.
Yes, we have the "no regressions" rule, but contributing a change to the
kernel OTOH should not mean that you are responsible for all regressions
it causes for your whole life. :-)

> What can
> I do in this case? Should I start adding get_maintainer.pl output?

Yeah, that's not much helpful here afaics, as most of those that would
care are CCed already.

I'm CCing Oliver, he sent the fix mentioned above for the SL-6000. Maybe
he cares.

If not I guess this won't be fixed, unless we find somebody else to care
enough to submit a patch.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

