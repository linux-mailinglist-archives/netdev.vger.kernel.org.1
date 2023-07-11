Return-Path: <netdev+bounces-16953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF61874F8F7
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 22:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4103C2817CD
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 20:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6125A1EA90;
	Tue, 11 Jul 2023 20:22:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD9E1DDFB
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 20:22:32 +0000 (UTC)
Received: from mail1-1.quietfountain.com (mail1-1.quietfountain.com [192.190.136.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD55195
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 13:22:30 -0700 (PDT)
Received: from mail1-1.quietfountain.com (localhost [127.0.0.1])
	by mail1-1.quietfountain.com (Postfix) with ESMTP id 4R0sjx0vyCz5Djnw
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 15:22:29 -0500 (CDT)
Authentication-Results: mail1-1.quietfountain.com (amavisd-new);
	dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
	header.d=quietfountain.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	quietfountain.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1689106948; x=1691698949; bh=cp6jjtX/xRVV0JDlTJP9f2T6jCr+eJ7f4my
	cxennIUw=; b=vuj4Sao67vLw9pfDZNIHlLKVssCXi3U9Ts2QUksLXHVP8YtOCUs
	n1YfX0gEXa/odRq8QKdtHB30XgOsHglrfVX+4GSTinsVLaW10OZJSr8gtk42cZYP
	GvGXaW1zf9jOfzpdsZL1rCbVfIwm53V/A0n10JL1+EAGPofb8LfXxu74Xsfxa8Ey
	LRivZaqZrKogx97HXFPNVUsgQKNZrtc0y2Bx2auCBtlEecOYf5e/latFT6m0RwA0
	gX+fwqJDS3n0g2vLSlA6sLSRTCCbUh9eQ/SemKEQZJ4TwQ/wE0yXi48M0n02OcpL
	5TxoSOBWmCvNmUhCwhheUEBwg293VJ3Oj7y3GYlD/0m7BK91YnZgG943QWmBY7yu
	TZpX7R3ybhOQjTOUaCghdbQQbUwrBt+5Gfm2Jg/V+chhfbFG0FkqEMqH0zSWhCOY
	aqoPstHFiVODK/a2o+U+R1UGjTwpSseB6mXVilPpySevpeVCvt7fuHAwc/SlrVtx
	1RiQx+PmFZqNv/VwzZey3IQVMr5xadYdvNtoCMK5LEGo/RWjko2qYnNGIm4W0Bbw
	S43RXczm7NK5RkLbR1kLeO8zUR+oQBMC3SJPfQIBWHy6oTRExIjfRj1dBNCGJLq2
	p24yaoybvow0WtG82XPNvGKlkdJlJZerjVpCOSMReCFDFeNNnvGLwjDQ=
X-Virus-Scanned: Debian amavisd-new at email1.1.quietfountain.com
Received: from mail1-1.quietfountain.com ([127.0.0.1])
	by mail1-1.quietfountain.com (mail1-1.quietfountain.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id G4VJis0WqWIi for <netdev@vger.kernel.org>;
	Tue, 11 Jul 2023 15:22:28 -0500 (CDT)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from [10.12.114.193] (versa.1.quietfountain.com [10.12.114.193])
	by mail1-1.quietfountain.com (Postfix) with ESMTPSA id 4R0sjw0fK2z5Ddtf;
	Tue, 11 Jul 2023 15:22:28 -0500 (CDT)
Message-ID: <3dceb664-0dd5-d46b-2431-b235cbd7752f@quietfountain.com>
Date: Tue, 11 Jul 2023 15:22:26 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: llc needs namespace awareness asap, was Re: Patch fixing STP if
 bridge in non-default namespace.
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: netdev@vger.kernel.org
References: <f01739c8-8f59-97d6-4edc-f2e88885bb73@quietfountain.com>
 <20230711183206.54744-1-kuniyu@amazon.com>
From: Harry Coin <hcoin@quietfountain.com>
Organization: Quiet Fountain LLC / Rock Stable Systems
In-Reply-To: <20230711183206.54744-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 7/11/23 13:32, Kuniyuki Iwashima wrote:
> From: Harry Coin <hcoin@quietfountain.com>
> Date: Tue, 11 Jul 2023 12:08:15 -0500
>> On 7/10/23 22:22, Kuniyuki Iwashima wrote:
>>> From: Harry Coin <hcoin@quietfountain.com>
>>> Date: Mon, 10 Jul 2023 08:35:08 -0500
>>>> Notice without access to link-level multicast address 01:80:C2:00:00=
:00,
>>>> the STP loop-avoidance feature of bridges fails silently, leading to
>>>> packet storms if loops exist in the related L2.  The Linux kernel's
>>>> latest code silently drops BPDU STP packets if the bridge is in a
>>>> non-default namespace.
>>>>
>>>> The current llc_rcv.c around line 166 in net/llc/llc_input.c  has
>>>>
>>>>           if (!net_eq(dev_net(dev), &init_net))
>>>>                   goto drop;
>>>>
>>>> Which, when commented out, fixes this bug.  A search on &init_net ma=
y
>>>> reveal many similar artifacts left over from the early days of names=
pace
>>>> implementation.
>>> I think just removing the part is not sufficient and will introduce a=
 bug
>>> in another place.
>>>
>>> As you found, llc has the same test in another place.  For example, w=
hen
>>> you create an AF_LLC socket, it has to be in the root netns.  But if =
you
>>> remove the test in llc_rcv() only, it seems llc_recv() would put a sk=
b for
>>> a child netns into sk's recv queue that is in the default netns.
>>>
>>>     - llc_rcv
>>>       - if (net_eq(dev_net(dev), &init_net))
>>>         - goto drop
>>>       - sap_handler / llc_sap_handler
>>>         - sk =3D llc_lookup_dgram
>>>         - llc_sap_rcv
>>>           - llc_sap_state_process
>>> 	  - sock_queue_rcv_skb
>>>
>>> So, we need to namespacify the whole llc infra.
>> Agreed.  Probably sooner rather than later since IP4 and IP6 multicast=
,
>> GARP and more as well as STP depends on llc multicast delivery.   I
>> suspect the authors who added the 'drop unless default namespace' code
>> commented out above knew this, and were just buying some time.  Well,
>> the time has come.
>>
>> Now all bridges in a namespace will always -- and silently -- think of
>> itself as the 'root bridge' as it can't get packets informing it
>> otherwise.  This leads to packet storms at line-level speeds bringing
>> whole infrastructures down in a self-inflicted event worse than a DDOS
>> attack.
>>
>> I think whoever does 'advisories' ought to warn the community that ipv=
6
>> ndp (if using multicast), ipv4 arp (if using multicast), bridges with
>> STP, lldp, GARP, ipv6 multicast and ipv4 mulitcast for sockets in the
>> non-default namespace will not get RX traffic as it gets dropped in th=
e
>> kernel before other modules or user code has a chance to see it.
>> Outcomes range from local seeming disconnection to kernel induced
>> site-crippling packet storms.
>>
>> Is there a way to track this llc namespace awareness effort?  I'm new =
to
>> this particular dev community.  It's on a critical path for my project=
.
> AFAIK, there is no ongoing work for this.  I can spend some cycles on
> this, but note that the patches might not be backported to stable as
> it would be invasive.

Thank you!=C2=A0 When you offer your patches, and you hear worries about=20
being 'invasive', it's worth asking 'compared to what' -- since the=20
'status quo'=C2=A0 is every bridge with STP in a non default namespace wi=
th a=20
loop in it somewhere will freeze every connected system more solid than=20
ice in Antarctica.




