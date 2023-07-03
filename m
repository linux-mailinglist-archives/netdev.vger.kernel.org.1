Return-Path: <netdev+bounces-15183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B0A74611E
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 19:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AF1B280DFE
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 17:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EF8100DE;
	Mon,  3 Jul 2023 17:04:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3D4100C3
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 17:04:31 +0000 (UTC)
X-Greylist: delayed 116313 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 03 Jul 2023 10:04:28 PDT
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F69AE58
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 10:04:28 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Qvsj615jpzMpnTk;
	Mon,  3 Jul 2023 17:04:26 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Qvsj50ljrzMq80r;
	Mon,  3 Jul 2023 19:04:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1688403866;
	bh=0mtSpmKOHzeGmtkvXUe/wzhFnWd6YSVXvr0DIvmLL48=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=q1Tny0gB87nt+XNoiacWMJQh6pufX8td/RxFOmFPCyBHdCcotym2MLgI86D3cFpyI
	 x1PbHnbng7OpNJzu2xnoamKbsxbnX8khqvH4MNwTE+OqMaqyDS6Ck5neCs1yxdyr2u
	 sjaHO/OmJksWxPIQJWrx8klDOYaqQW+9K+8oqjb0=
Message-ID: <d75d765b-148a-c562-30b0-61350c04b491@digikod.net>
Date: Mon, 3 Jul 2023 19:04:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent:
Subject: Re: [PATCH v11 12/12] landlock: Document Landlock's network support
Content-Language: en-US
To: "Konstantin Meskhidze (A)" <konstantin.meskhidze@huawei.com>,
 Jeff Xu <jeffxu@chromium.org>
Cc: =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack@google.com>,
 willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com,
 linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, yusongping@huawei.com,
 artem.kuzin@huawei.com
References: <20230515161339.631577-1-konstantin.meskhidze@huawei.com>
 <20230515161339.631577-13-konstantin.meskhidze@huawei.com>
 <ZH89Pi1QAqNW2QgG@google.com>
 <CABi2SkWqHeLkmqONbmavcp2SCiwe6YeH_3dkBLZwSsk7neyPMw@mail.gmail.com>
 <86108314-de87-5342-e0fb-a07feee457a5@huawei.com>
 <97c15e23-8a89-79f2-4413-580153827ade@digikod.net>
 <00a03f2c-892d-683e-96a0-c0ba8f293831@digikod.net>
 <CABi2SkWJT5xmjBvudEc725uN8iAMCKf5BBOppzgmRJRc2M4nrg@mail.gmail.com>
 <bdf88b0d-bcac-413f-cd44-75caee63366d@huawei.com>
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <bdf88b0d-bcac-413f-cd44-75caee63366d@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 03/07/2023 11:04, Konstantin Meskhidze (A) wrote:
> 
> 
> 6/23/2023 5:35 PM, Jeff Xu пишет:
>> On Thu, Jun 22, 2023 at 9:50 AM Mickaël Salaün <mic@digikod.net> wrote:
>>>
>>>
>>> On 13/06/2023 22:12, Mickaël Salaün wrote:
>>>>
>>>> On 13/06/2023 12:13, Konstantin Meskhidze (A) wrote:
>>>>>
>>>>>
>>>>> 6/7/2023 8:46 AM, Jeff Xu пишет:
>>>>>> On Tue, Jun 6, 2023 at 7:09 AM Günther Noack <gnoack@google.com> wrote:
>>>>>>>
>>>>>>> On Tue, May 16, 2023 at 12:13:39AM +0800, Konstantin Meskhidze wrote:
>>>>>>>> Describe network access rules for TCP sockets. Add network access
>>>>>>>> example in the tutorial. Add kernel configuration support for network.
>>>>>>>>
>>>>>>>> Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
>>>
>>> [...]
>>>
>>>>>>>> @@ -28,20 +28,24 @@ appropriately <kernel_support>`.
>>>>>>>>     Landlock rules
>>>>>>>>     ==============
>>>>>>>>
>>>>>>>> -A Landlock rule describes an action on an object.  An object is currently a
>>>>>>>> -file hierarchy, and the related filesystem actions are defined with `access
>>>>>>>> -rights`_.  A set of rules is aggregated in a ruleset, which can then restrict
>>>>>>>> -the thread enforcing it, and its future children.
>>>>>>>> +A Landlock rule describes an action on a kernel object.  Filesystem
>>>>>>>> +objects can be defined with a file hierarchy.  Since the fourth ABI
>>>>>>>> +version, TCP ports enable to identify inbound or outbound connections.
>>>>>>>> +Actions on these kernel objects are defined according to `access
>>>>>>>> +rights`_.  A set of rules is aggregated in a ruleset, which
>>>>>>>> +can then restrict the thread enforcing it, and its future children.
>>>>>>>
>>>>>>> I feel that this paragraph is a bit long-winded to read when the
>>>>>>> additional networking aspect is added on top as well.  Maybe it would
>>>>>>> be clearer if we spelled it out in a more structured way, splitting up
>>>>>>> the filesystem/networking aspects?
>>>>>>>
>>>>>>> Suggestion:
>>>>>>>
>>>>>>>      A Landlock rule describes an action on an object which the process
>>>>>>>      intends to perform.  A set of rules is aggregated in a ruleset,
>>>>>>>      which can then restrict the thread enforcing it, and its future
>>>>>>>      children.
>>>>>>>
>>>>>>>      The two existing types of rules are:
>>>>>>>
>>>>>>>      Filesystem rules
>>>>>>>          For these rules, the object is a file hierarchy,
>>>>>>>          and the related filesystem actions are defined with
>>>>>>>          `filesystem access rights`.
>>>>>>>
>>>>>>>      Network rules (since ABI v4)
>>>>>>>          For these rules, the object is currently a TCP port,
>>>>>> Remote port or local port ?
>>>>>>
>>>>>       Both ports - remote or local.
>>>>
>>>> Hmm, at first I didn't think it was worth talking about remote or local,
>>>> but I now think it could be less confusing to specify a bit:
>>>> "For these rules, the object is the socket identified with a TCP (bind
>>>> or connect) port according to the related `network access rights`."
>>>>
>>>> A port is not a kernel object per see, so I tried to tweak a bit the
>>>> sentence. I'm not sure such detail (object vs. data) would not confuse
>>>> users. Any thought?
>>>
>>> Well, here is a more accurate and generic definition (using "scope"):
>>>
>>> A Landlock rule describes a set of actions intended by a task on a scope
>>> of objects.  A set of rules is aggregated in a ruleset, which can then
>>> restrict the thread enforcing it, and its future children.
>>>
>>> The two existing types of rules are:
>>>
>>> Filesystem rules
>>>       For these rules, the scope of objects is a file hierarchy,
>>>       and the related filesystem actions are defined with
>>>       `filesystem access rights`.
>>>
>>> Network rules (since ABI v4)
>>>       For these rules, the scope of objects is the sockets identified
>>>       with a TCP (bind or connect) port according to the related
>>>       `network access rights`.
>>>
>>>
>>> What do you think?
>>>
>> I found this is clearer to me (mention of bind/connect port).
>>
>> In networking, "5-tuple" is a well-known term for connection, which is
>> src/dest ip, src/dest port, protocol. That is why I asked about
>> src/dest port.  It seems that we only support src/dest port at this
>> moment, right ?
>>
>> Another feature we could consider is restricting a process to "no
>> network access, allow out-going , allow incoming", this might overlap
>> with seccomp, but I think it is convenient to have it in Landlock.
>>
>> Adding protocol restriction is a low hanging fruit also, for example,
>> a process might be restricted to UDP only (for RTP packet), and
>> another process for TCP (for signaling) , etc.
> 
>    Hi,
>     By the way, UPD protocol brings more performance challenges here
> beacuse it does not establish a connection so every UDP packet will be
> hooked by Landlock to check apllied rules.

Correct, but I think that for performant-sensitive applications, it 
would not be an issue to check sendto and recvfrom for UDP because they 
should use connect/bind and send/recv instead, and we can check 
connect/bind without checking send/recv. Indeed, bind and connect can be 
used to configure an UDP socket, even if it is not a connected protocol 
this enables to limit the number of kernel checks and copies. I'm not 
sure how many applications use sendto and recvfrom though.

For thread dedicated to UDP, see 
https://lore.kernel.org/r/77be3dcf-cae1-f754-ac2a-f9eeab063d76@huawei.com

