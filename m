Return-Path: <netdev+bounces-17865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 570B67534E0
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 10:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 119EC2821B6
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 08:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6587DC8F1;
	Fri, 14 Jul 2023 08:16:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FFC79F0
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 08:16:57 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B179F12D
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 01:16:43 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1qKDyd-00067h-KK; Fri, 14 Jul 2023 10:16:35 +0200
Message-ID: <ee7172c0-b5f1-c5e2-55d8-2b712ceb6ea6@leemhuis.info>
Date: Fri, 14 Jul 2023 10:16:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net] r8169: fix ASPM-related problem for chip version 42
 and 43
Content-Language: en-US, de-DE
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
To: Heiner Kallweit <hkallweit1@gmail.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 joey.joey586@gmail.com, Greg KH <gregkh@linuxfoundation.org>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <82ea9e63-d8c8-0b86-cd88-913cc249fa9a@gmail.com>
 <d644f048-970c-71fe-a556-a2c80444dae2@leemhuis.info>
 <17c638ca-5343-75e0-7f52-abf86026f75d@gmail.com>
 <fff3067d-5a7f-b328-ef65-fa68138f8b0f@leemhuis.info>
 <a42f129b-d64b-2d86-0758-143e99a534a0@gmail.com>
 <6b2513b0-f57c-73ff-5181-489ba43a01e3@leemhuis.info>
In-Reply-To: <6b2513b0-f57c-73ff-5181-489ba43a01e3@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1689322603;2bd13449;
X-HE-SMSGID: 1qKDyd-00067h-KK
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

[Short version: sorry for the noise, a stale file sent us sideways.]

On 14.07.23 08:58, Linux regression tracking (Thorsten Leemhuis) wrote:
> [ccing greg]
> 
> On 14.07.23 08:34, Heiner Kallweit wrote:
>> On 14.07.2023 08:30, Linux regression tracking (Thorsten Leemhuis) wrote:
>>> On 14.07.23 07:34, Heiner Kallweit wrote:
>>>> On 14.07.2023 05:31, Linux regression tracking (Thorsten Leemhuis) wrote:
>>>>> On 13.07.23 21:46, Heiner Kallweit wrote:
>>>>
>>>>>> Fixes: 5fc3f6c90cca ("r8169: consolidate disabling ASPM before EPHY access")
>>>>>  Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217635 # [0]
>>>>> A "Cc: stable@vger.kernel.org" would be nice, too, to get this fixed in
>>>>> 6.4, where this surfaced (reminder: no, a Fixes: tag is not enough to
>>>>> ensure the backport there).
>>>> That's different in the net subsystem. The net (vs. net-next) annotation
>>>> ensures the backport.
>>>
>>> Huh, how does that work? I thought "net" currently means "for 6.5" while
>>> "net-next" implies 6.6?
>>
>> https://www.kernel.org/doc/Documentation/networking/netdev-FAQ.txt

I just learned on social media that's a stale file that doesn't exist
anymore in mainline (I'll talk to Konstantin, maybe he can remove it to
avoid similar problems in the future). That document was converted to
rst and later...

>> See question:
>> I see a network patch and I think it should be backported to stable.
>> Should I request it via "stable@vger.kernel.org" like the references in
>> the kernel's Documentation/process/stable-kernel-rules.rst file say?

...this section was actually removed in dbbe7c962c3 ("docs: networking:
drop special stable handling") [v5.12-rc3]; later that document moved here:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

To quote:

```

1.5.7. Stable tree

While it used to be the case that netdev submissions were not supposed
to carry explicit CC: stable@vger.kernel.org tags that is no longer the
case today. Please follow the standard stable rules in
Documentation/process/stable-kernel-rules.rst, and make sure you include
appropriate Fixes tags!
```

That clears things up. Ciao, Thorsten

