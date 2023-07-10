Return-Path: <netdev+bounces-16443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2882B74D3BD
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 12:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D71B1281099
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 10:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0AD53AC;
	Mon, 10 Jul 2023 10:39:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CC34418
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 10:39:51 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D52CC;
	Mon, 10 Jul 2023 03:39:28 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1qIoIc-0000vr-Cy; Mon, 10 Jul 2023 12:39:22 +0200
Message-ID: <f04feee0-bb2c-b778-0603-2817c5b9bc40@leemhuis.info>
Date: Mon, 10 Jul 2023 12:39:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [Regression][BISECTED] kernel boot hang after 19898ce9cf8a
 ("wifi: iwlwifi: split 22000.c into multiple files")
Content-Language: en-US, de-DE
To: "Zhang, Rui" <rui.zhang@intel.com>,
 "Torvalds, Linus" <torvalds@linux-foundation.org>,
 "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc: "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "kvalo@kernel.org" <kvalo@kernel.org>, "Baruch, Yaara"
 <yaara.baruch@intel.com>, "Greenman, Gregory" <gregory.greenman@intel.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "Ben Ami, Golan" <golan.ben.ami@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "Sisodiya, Mukesh" <mukesh.sisodiya@intel.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, Xi Ruoyao <xry111@xry111.site>
References: <b533071f38804247f06da9e52a04f15cce7a3836.camel@intel.com>
 <a4265090-d6b8-b185-a400-b09b27a347cc@leemhuis.info>
 <CAHk-=wg23SdKRcn2W+BWWEfJ2Efp0sreJx9=iw0AsUPjW3qznw@mail.gmail.com>
 <446c25888d9316d0f15e6bcc6ecb100dda99324e.camel@sipsolutions.net>
 <e7d7945055802e5d3f1b42750716bc6a314ec97b.camel@intel.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <e7d7945055802e5d3f1b42750716bc6a314ec97b.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1688985569;044dc97e;
X-HE-SMSGID: 1qIoIc-0000vr-Cy
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

[CCing one

On 10.07.23 03:54, Zhang, Rui wrote:
> On Sun, 2023-07-09 at 20:07 +0200, Johannes Berg wrote:
>> On Sun, 2023-07-09 at 09:31 -0700, Linus Torvalds wrote:
>>> On Fri, 7 Jul 2023 at 03:55, Linux regression tracking (Thorsten
>>> Leemhuis) <regressions@leemhuis.info> wrote:
>>>>
>>>> [CCing the regression list, netdev, the net maintainers, and
>>>> Linus;
>>>> Johannes and Kalle as well, but just for the record, they afaik
>>>> are
>>>> unavailable]
>>>
>>> So I will release rc1 with this issue, but remind me - if it hasn't
>>> had any traction next week and the radio silence continues, I'll
>>> just
>>> revert it all.
>>
>> Sorry. I got back home a few hours ago (for few days anyway) and I
>> think
>> I already know what the issue is. 

Many many thx for taking a look at this!

FWIW in case anyone wonders where that fix is, find it here:
https://lore.kernel.org/all/20230709181323.12085-2-johannes@sipsolutions.net/

(or here: https://bugzilla.kernel.org/show_bug.cgi?id=217622#c9 )

> I have tested Johannes' patch and it fixes the problem on my side.

Ahh, great.

Ciao, Thorsten

