Return-Path: <netdev+bounces-16923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BA774F6E4
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 19:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34A56281902
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 17:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDB61E53A;
	Tue, 11 Jul 2023 17:18:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85921E537
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 17:18:12 +0000 (UTC)
X-Greylist: delayed 581 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Jul 2023 10:18:09 PDT
Received: from mail2-1.quietfountain.com (mail2-1.quietfountain.com [64.111.48.224])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFAA10FA
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 10:18:09 -0700 (PDT)
Received: from mail2-1.quietfountain.com (localhost [127.0.0.1])
	by mail2-1.quietfountain.com (Postfix) with ESMTP id 4R0nQ22x7QzshQh
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 12:08:26 -0500 (CDT)
Authentication-Results: mail2-1.quietfountain.com (amavisd-new);
	dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
	header.d=quietfountain.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	quietfountain.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1689095302; x=1691687303; bh=YOHK+3Z9WUmSyS/AMeV6mx+DZSqDvcg7lKl
	2gIg+zks=; b=D0E0N6W2IEqZhR4t3KlHQTgMhEs4CahbQlEziLawfLItcmFl/uu
	N/Zs6aSVExI1eEEXjoGYqIn0/E6djIbG3aQxoV6VLa284N5rI9aH0fvpA0j7eSt1
	9X/dZcSP3TbXHKPnPprfTncThPu+bZ79tzRAirtIBjnP7X/iTdf20k1zYEDOCfAg
	mGQiYgygJHh6fciXnpweASbZppG0WVNnwMYwHM2G54tHQiKsAyandcKcOTHq6Pqm
	QenSFnCgbDy3Pa4YpNg6U6vler270lUTeBHKMT55GSRHE4C828Up8cJozOzVUqvT
	cOrpR3AJNDcE/fxMij8ixhDReFqRI4qmQz6WQy4Fpwg5bj4+p8jkBWDBjQdyBIOc
	LIdTyTqubdmnuskR+LXfBTpp7X8EXZp8us6yCGqVfawpoIEGiy02PU3FQ4W9sXh1
	aDPTI5mH+iUKAhxd6jGTOYnRj1DxPPRfod2sVB+Z++YPRRTjmMQU+T4JYJGZ5C+v
	bWGSyd/DygZQevgCJS2JnA5Hb2N+088N183/o/B87fJRot40nWcYCjMkq3zx2eQ1
	bSFgCrJ645se1Gmrl1LJo2npxcvhf19YMyrQdwIbrqQA4IrUg6CunZfLBbipQ55G
	blqQ+d3Q0haaDvsMINfylUaQSG6TucmT22QCPbRd1CWffaKgEt0JYSRM=
X-Virus-Scanned: Debian amavisd-new at email2.1.quietfountain.com
Received: from mail2-1.quietfountain.com ([127.0.0.1])
	by mail2-1.quietfountain.com (mail2-1.quietfountain.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8vwEfCZ-CIdK for <netdev@vger.kernel.org>;
	Tue, 11 Jul 2023 12:08:22 -0500 (CDT)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from [10.12.114.193] (versa.1.quietfountain.com [10.12.114.193])
	by mail2-1.quietfountain.com (Postfix) with ESMTPSA id 4R0nPx6pZWzsfvj;
	Tue, 11 Jul 2023 12:08:21 -0500 (CDT)
Message-ID: <f01739c8-8f59-97d6-4edc-f2e88885bb73@quietfountain.com>
Date: Tue, 11 Jul 2023 12:08:15 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: llc needs namespace awareness asap, was Re: Patch fixing STP if
 bridge in non-default namespace.
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: netdev@vger.kernel.org
References: <608c37f9-34b1-85e6-2b4b-2a0389dd3d47@quietfountain.com>
 <20230711032217.46485-1-kuniyu@amazon.com>
From: Harry Coin <hcoin@quietfountain.com>
Organization: Quiet Fountain LLC / Rock Stable Systems
In-Reply-To: <20230711032217.46485-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/10/23 22:22, Kuniyuki Iwashima wrote:
> From: Harry Coin <hcoin@quietfountain.com>
> Date: Mon, 10 Jul 2023 08:35:08 -0500
>> Notice without access to link-level multicast address 01:80:C2:00:00:0=
0,
>> the STP loop-avoidance feature of bridges fails silently, leading to
>> packet storms if loops exist in the related L2.  The Linux kernel's
>> latest code silently drops BPDU STP packets if the bridge is in a
>> non-default namespace.
>>
>> The current llc_rcv.c around line 166 in net/llc/llc_input.c  has
>>
>>          if (!net_eq(dev_net(dev), &init_net))
>>                  goto drop;
>>
>> Which, when commented out, fixes this bug.  A search on &init_net may
>> reveal many similar artifacts left over from the early days of namespa=
ce
>> implementation.
> I think just removing the part is not sufficient and will introduce a b=
ug
> in another place.
>
> As you found, llc has the same test in another place.  For example, whe=
n
> you create an AF_LLC socket, it has to be in the root netns.  But if yo=
u
> remove the test in llc_rcv() only, it seems llc_recv() would put a skb =
for
> a child netns into sk's recv queue that is in the default netns.
>
>    - llc_rcv
>      - if (net_eq(dev_net(dev), &init_net))
>        - goto drop
>      - sap_handler / llc_sap_handler
>        - sk =3D llc_lookup_dgram
>        - llc_sap_rcv
>          - llc_sap_state_process
> 	  - sock_queue_rcv_skb
>
> So, we need to namespacify the whole llc infra.

Agreed.=C2=A0 Probably sooner rather than later since IP4 and IP6 multica=
st,=20
GARP and more as well as STP depends on llc multicast delivery.=C2=A0=C2=A0=
 I=20
suspect the authors who added the 'drop unless default namespace' code=20
commented out above knew this, and were just buying some time.=C2=A0 Well=
,=20
the time has come.

Now all bridges in a namespace will always -- and silently -- think of=20
itself as the 'root bridge' as it can't get packets informing it=20
otherwise.=C2=A0 This leads to packet storms at line-level speeds bringin=
g=20
whole infrastructures down in a self-inflicted event worse than a DDOS=20
attack.

I think whoever does 'advisories' ought to warn the community that ipv6=20
ndp (if using multicast), ipv4 arp (if using multicast), bridges with=20
STP, lldp, GARP, ipv6 multicast and ipv4 mulitcast for sockets in the=20
non-default namespace will not get RX traffic as it gets dropped in the=20
kernel before other modules or user code has a chance to see it.=C2=A0=20
Outcomes range from local seeming disconnection to kernel induced=20
site-crippling packet storms.

Is there a way to track this llc namespace awareness effort?=C2=A0 I'm ne=
w to=20
this particular dev community.=C2=A0 It's on a critical path for my proje=
ct.


--=20

