Return-Path: <netdev+bounces-16973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE5A74F9F0
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 23:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB1D28157B
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 21:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13AB1ED31;
	Tue, 11 Jul 2023 21:40:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D532B1ED30
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 21:40:12 +0000 (UTC)
Received: from mail1-1.quietfountain.com (mail1-1.quietfountain.com [192.190.136.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF0B1710
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 14:40:09 -0700 (PDT)
Received: from mail1-1.quietfountain.com (localhost [127.0.0.1])
	by mail1-1.quietfountain.com (Postfix) with ESMTP id 4R0vRW3h09z5FLVJ
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 16:40:07 -0500 (CDT)
Authentication-Results: mail1-1.quietfountain.com (amavisd-new);
	dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
	header.d=quietfountain.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	quietfountain.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1689111605; x=1691703606; bh=GD7MPhGCegBJ3Rj09eHVA2QU1i483+xIyJj
	mUe0bhxY=; b=iE+BqnsV9Vpz7t7UYuMd/BpTH2pt2GBMHV310ZKt2dmmmJlKyyw
	IcDlNZJOTw6Jn9U0EpbRA7Nvb8d3gfNX/vXZXowE0YGKoXmYr8h9TKYJ4N5IRToO
	k29+5zXU3xqJjtYGFBvfmxCcrsbNR9CX5WoqRqXEZQ5AxGSGF1Loc3Bt99U/Iqhq
	hsuABFiFdWgjHpqkFmNN58ivQSnJsDPVJaTl1ZOCYV1RKiTs6yHgrNY/Gl2iTAHg
	LEdo7d+THPjSFZ5deRiWhLxnOpInpQnVKFb4CBn+lJk7J8eFfvmiXFoWxDo3Gs2K
	Uvx0YoCJiyr8ZhndkiOcUO+kFsl3ZvxAvVQ2EpKFLWBZYfGPSVZV8r2FjdpjfwQ8
	BlRrYAyZ/79nyIo7OFxisvEJ29wvgHJIUvYhLqDquCzkQET4dVTfUJ7nLZCs1gr0
	vznPKGveTKfV47GZ0ze+Xu504xI5cguLR1oLvehTTc9QfHaE1s42TgZ2Tnd522vK
	+ZVFAaHY0fE0sXILgXvjp+9ryO58ThL4dP8qjTEm52xqfeEDiRNZATM24716G0cc
	SijL/i18KPnoX21W46Gf4Arc2+E9L0/qXyIUOLTkGN2tv28/z/VcAR9QfNuAoIB3
	S5wEnVSEW4BsvG1WOZzx1Wp37RP6gskKmErPliSNq09jCC8duGwIWR3I=
X-Virus-Scanned: Debian amavisd-new at email1.1.quietfountain.com
Received: from mail1-1.quietfountain.com ([127.0.0.1])
	by mail1-1.quietfountain.com (mail1-1.quietfountain.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id itWYUa9YWL-4 for <netdev@vger.kernel.org>;
	Tue, 11 Jul 2023 16:40:05 -0500 (CDT)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from [10.12.114.193] (unknown [10.12.114.193])
	by mail1-1.quietfountain.com (Postfix) with ESMTPSA id 4R0vRS5rh3z5Ddtf;
	Tue, 11 Jul 2023 16:40:04 -0500 (CDT)
Message-ID: <9190b2ac-a3f7-d4f5-211a-ea860f09687a@quietfountain.com>
Date: Tue, 11 Jul 2023 16:40:03 -0500
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
To: Andrew Lunn <andrew@lunn.ch>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org
References: <f01739c8-8f59-97d6-4edc-f2e88885bb73@quietfountain.com>
 <20230711183206.54744-1-kuniyu@amazon.com>
 <3dceb664-0dd5-d46b-2431-b235cbd7752f@quietfountain.com>
 <cacc74f8-5b40-4d89-a411-a6852ea60e7d@lunn.ch>
From: Harry Coin <hcoin@quietfountain.com>
Organization: Quiet Fountain LLC / Rock Stable Systems
In-Reply-To: <cacc74f8-5b40-4d89-a411-a6852ea60e7d@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 7/11/23 15:44, Andrew Lunn wrote:
>>>>>> The current llc_rcv.c around line 166 in net/llc/llc_input.c  has
>>>>>>
>>>>>>            if (!net_eq(dev_net(dev), &init_net))
>>>>>>                    goto drop;
>>>>>>
>> Thank you!=C2=A0 When you offer your patches, and you hear worries abo=
ut being
>> 'invasive', it's worth asking 'compared to what' -- since the 'status =
quo'
>> is every bridge with STP in a non default namespace with a loop in it
>> somewhere will freeze every connected system more solid than ice in
>> Antarctica.
> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
>
> say:
>
> o It must be obviously correct and tested.
> o It cannot be bigger than 100 lines, with context.
> o It must fix only one thing.
> o It must fix a real bug that bothers people (not a, "This could be a p=
roblem..." type thing).
>
> git blame shows:
>
> commit 721499e8931c5732202481ae24f2dfbf9910f129
> Author: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
> Date:   Sat Jul 19 22:34:43 2008 -0700
>
>      netns: Use net_eq() to compare net-namespaces for optimization.
>
> diff --git a/net/llc/llc_input.c b/net/llc/llc_input.c
> index 1c45f172991e..57ad974e4d94 100644
> --- a/net/llc/llc_input.c
> +++ b/net/llc/llc_input.c
> @@ -150,7 +150,7 @@ int llc_rcv(struct sk_buff *skb, struct net_device =
*dev,
>          int (*rcv)(struct sk_buff *, struct net_device *,
>                     struct packet_type *, struct net_device *);
>  =20
> -       if (dev_net(dev) !=3D &init_net)
> +       if (!net_eq(dev_net(dev), &init_net))
>                  goto drop;
>  =20
>          /*
>
> So this is just an optimization.
>
> The test itself was added in
>
> ommit e730c15519d09ea528b4d2f1103681fa5937c0e6
> Author: Eric W. Biederman <ebiederm@xmission.com>
> Date:   Mon Sep 17 11:53:39 2007 -0700
>
>      [NET]: Make packet reception network namespace safe
>     =20
>      This patch modifies every packet receive function
>      registered with dev_add_pack() to drop packets if they
>      are not from the initial network namespace.
>     =20
>      This should ensure that the various network stacks do
>      not receive packets in a anything but the initial network
>      namespace until the code has been converted and is ready
>      for them.
>     =20
>      Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>      Signed-off-by: David S. Miller <davem@davemloft.net>
>
> So that was over 15 years ago.
>
> It appears it has not bothered people for over 15 years.
>
> Lets wait until we get to see the actual fix. We can then decide how
> simple/hard it is to back port to stable, if it fulfils the stable
> rules or not.
>
>        Andrew

Andrew, fair enough.=C2=A0 In the time until it's fixed, the kernel folks=
=20
should publish an advisory and block any attempt to set bridge stp state=20
to other than 0 if in a non-default namespace. The alternative is a=20
packet flood at whatever the top line speed is should there be a loop=20
somewhere in even one connected link.


--=20

