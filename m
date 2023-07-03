Return-Path: <netdev+bounces-15069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2FA7457F5
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 11:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E049A280CC3
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 09:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537A720EA;
	Mon,  3 Jul 2023 09:04:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466141FD2
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 09:04:51 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90D4E50;
	Mon,  3 Jul 2023 02:04:36 -0700 (PDT)
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.207])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qvg1S4jFLz6J6kl;
	Mon,  3 Jul 2023 17:02:52 +0800 (CST)
Received: from [10.123.123.126] (10.123.123.126) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 10:04:33 +0100
Message-ID: <bdf88b0d-bcac-413f-cd44-75caee63366d@huawei.com>
Date: Mon, 3 Jul 2023 12:04:32 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v11 12/12] landlock: Document Landlock's network support
Content-Language: ru
To: Jeff Xu <jeffxu@chromium.org>, =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?=
	<mic@digikod.net>
CC: =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack@google.com>,
	<willemdebruijn.kernel@gmail.com>, <gnoack3000@gmail.com>,
	<linux-security-module@vger.kernel.org>, <netdev@vger.kernel.org>,
	<netfilter-devel@vger.kernel.org>, <yusongping@huawei.com>,
	<artem.kuzin@huawei.com>
References: <20230515161339.631577-1-konstantin.meskhidze@huawei.com>
 <20230515161339.631577-13-konstantin.meskhidze@huawei.com>
 <ZH89Pi1QAqNW2QgG@google.com>
 <CABi2SkWqHeLkmqONbmavcp2SCiwe6YeH_3dkBLZwSsk7neyPMw@mail.gmail.com>
 <86108314-de87-5342-e0fb-a07feee457a5@huawei.com>
 <97c15e23-8a89-79f2-4413-580153827ade@digikod.net>
 <00a03f2c-892d-683e-96a0-c0ba8f293831@digikod.net>
 <CABi2SkWJT5xmjBvudEc725uN8iAMCKf5BBOppzgmRJRc2M4nrg@mail.gmail.com>
From: "Konstantin Meskhidze (A)" <konstantin.meskhidze@huawei.com>
In-Reply-To: <CABi2SkWJT5xmjBvudEc725uN8iAMCKf5BBOppzgmRJRc2M4nrg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.123.123.126]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500004.china.huawei.com (7.191.163.9)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



6/23/2023 5:35 PM, Jeff Xu пишет:
> On Thu, Jun 22, 2023 at 9:50 AM Mickaël Salaün <mic@digikod.net> wrote:
>>
>>
>> On 13/06/2023 22:12, Mickaël Salaün wrote:
>> >
>> > On 13/06/2023 12:13, Konstantin Meskhidze (A) wrote:
>> >>
>> >>
>> >> 6/7/2023 8:46 AM, Jeff Xu пишет:
>> >>> On Tue, Jun 6, 2023 at 7:09 AM Günther Noack <gnoack@google.com> wrote:
>> >>>>
>> >>>> On Tue, May 16, 2023 at 12:13:39AM +0800, Konstantin Meskhidze wrote:
>> >>>>> Describe network access rules for TCP sockets. Add network access
>> >>>>> example in the tutorial. Add kernel configuration support for network.
>> >>>>>
>> >>>>> Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
>>
>> [...]
>>
>> >>>>> @@ -28,20 +28,24 @@ appropriately <kernel_support>`.
>> >>>>>    Landlock rules
>> >>>>>    ==============
>> >>>>>
>> >>>>> -A Landlock rule describes an action on an object.  An object is currently a
>> >>>>> -file hierarchy, and the related filesystem actions are defined with `access
>> >>>>> -rights`_.  A set of rules is aggregated in a ruleset, which can then restrict
>> >>>>> -the thread enforcing it, and its future children.
>> >>>>> +A Landlock rule describes an action on a kernel object.  Filesystem
>> >>>>> +objects can be defined with a file hierarchy.  Since the fourth ABI
>> >>>>> +version, TCP ports enable to identify inbound or outbound connections.
>> >>>>> +Actions on these kernel objects are defined according to `access
>> >>>>> +rights`_.  A set of rules is aggregated in a ruleset, which
>> >>>>> +can then restrict the thread enforcing it, and its future children.
>> >>>>
>> >>>> I feel that this paragraph is a bit long-winded to read when the
>> >>>> additional networking aspect is added on top as well.  Maybe it would
>> >>>> be clearer if we spelled it out in a more structured way, splitting up
>> >>>> the filesystem/networking aspects?
>> >>>>
>> >>>> Suggestion:
>> >>>>
>> >>>>     A Landlock rule describes an action on an object which the process
>> >>>>     intends to perform.  A set of rules is aggregated in a ruleset,
>> >>>>     which can then restrict the thread enforcing it, and its future
>> >>>>     children.
>> >>>>
>> >>>>     The two existing types of rules are:
>> >>>>
>> >>>>     Filesystem rules
>> >>>>         For these rules, the object is a file hierarchy,
>> >>>>         and the related filesystem actions are defined with
>> >>>>         `filesystem access rights`.
>> >>>>
>> >>>>     Network rules (since ABI v4)
>> >>>>         For these rules, the object is currently a TCP port,
>> >>> Remote port or local port ?
>> >>>
>> >>      Both ports - remote or local.
>> >
>> > Hmm, at first I didn't think it was worth talking about remote or local,
>> > but I now think it could be less confusing to specify a bit:
>> > "For these rules, the object is the socket identified with a TCP (bind
>> > or connect) port according to the related `network access rights`."
>> >
>> > A port is not a kernel object per see, so I tried to tweak a bit the
>> > sentence. I'm not sure such detail (object vs. data) would not confuse
>> > users. Any thought?
>>
>> Well, here is a more accurate and generic definition (using "scope"):
>>
>> A Landlock rule describes a set of actions intended by a task on a scope
>> of objects.  A set of rules is aggregated in a ruleset, which can then
>> restrict the thread enforcing it, and its future children.
>>
>> The two existing types of rules are:
>>
>> Filesystem rules
>>      For these rules, the scope of objects is a file hierarchy,
>>      and the related filesystem actions are defined with
>>      `filesystem access rights`.
>>
>> Network rules (since ABI v4)
>>      For these rules, the scope of objects is the sockets identified
>>      with a TCP (bind or connect) port according to the related
>>      `network access rights`.
>>
>>
>> What do you think?
>>
> I found this is clearer to me (mention of bind/connect port).
> 
> In networking, "5-tuple" is a well-known term for connection, which is
> src/dest ip, src/dest port, protocol. That is why I asked about
> src/dest port.  It seems that we only support src/dest port at this
> moment, right ?
> 
> Another feature we could consider is restricting a process to "no
> network access, allow out-going , allow incoming", this might overlap
> with seccomp, but I think it is convenient to have it in Landlock.
> 
> Adding protocol restriction is a low hanging fruit also, for example,
> a process might be restricted to UDP only (for RTP packet), and
> another process for TCP (for signaling) , etc.

  Hi,
   By the way, UPD protocol brings more performance challenges here 
beacuse it does not establish a connection so every UDP packet will be 
hooked by Landlock to check apllied rules.
> 
> Thanks!
> -Jeff Xu
> 
>>
>> >>>
>> >>>>         and the related actions are defined with `network access rights`.
> .

