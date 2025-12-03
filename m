Return-Path: <netdev+bounces-243413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 97333C9F4A7
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 15:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7A32E341B23
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 14:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658572FB963;
	Wed,  3 Dec 2025 14:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xV4+xgFT"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBC9231A30
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 14:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764772122; cv=none; b=bB/n4A7x9xrurWUQCFyzVcUvMRHaCeltHqAncujyJEJDFecAwkCfDD0aayjPeipmFBcVCkk03Hw4+oNjc6YNAXMh/eL9APq409S4e0L+F4VpyjvH4DyKZrAea1OxxnSEsgq+Ykz3p6Z9bJTDMOovTqzxije3tDlQdJ7pYqkcw0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764772122; c=relaxed/simple;
	bh=/IIIhC3G0wmnqcFAOxUgpRLzrQ09P8j0VrdpuQJno8k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=UhDpVFsin8pDQ2bs334aRMzOq3choz9SdQgnhTIsQvd39Yj0prQjoVfaIFsocxMojcMjMoWYrpSfMlArS+oHalVWl0Di2wiS9HTSubhlSiFDz15z0+b0k9tSH5sfFyesKd27vDq/lkJcn/a0muG1cViBrGgpPcPc88hGMx+oXjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xV4+xgFT; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1C05E1A1EFE;
	Wed,  3 Dec 2025 14:28:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E422760706;
	Wed,  3 Dec 2025 14:28:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B1DBB1192074C;
	Wed,  3 Dec 2025 15:28:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764772116; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=y6IkvdyHdcymonhQHyK4vkqTjzz7IoaoO/gd0kpSJFQ=;
	b=xV4+xgFT//6uFGEDsMjxApXvqY4HLzllK7e7Tkv7QopuWYvk+/1Hq1KWb6m3e0XZF3gVTA
	A+Y1YbNOTx7kueeHfDlchFFlLIzzn6K2lnhtJMsMk6Wq5SEFc7VqIQOs89W8Ejwz4tTouA
	xxp89kSyX0Lpkp3ZBnK6/f7W4hGXX/aqAqtlQuENzPTNuo+YDR73m5GSzlgSRSqyM1yqXc
	xNqbLKI02sNLCCD5vvb0Ay+KbctPdAne317H1SNH9JsbH6z6GqicBRif3TCqg04a06paeG
	DpovbHIZSRFZWYALqEXdCSMJyIZGNuRnSdZwdy7TP5JJgR8A2PTh/rOQaJU01g==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Dec 2025 15:28:32 +0100
Message-Id: <DEONI4HOMXZZ.ATPIJ2O56QW0@bootlin.com>
Subject: Re: [PATCH RFC net-next 0/6] net: macb: Add XDP support and page
 pool integration
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Lorenzo Bianconi" <lorenzo@kernel.org>
To: "Paolo Valerio" <pvalerio@redhat.com>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>, <netdev@vger.kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251119135330.551835-1-pvalerio@redhat.com>
 <DEITSIO441QL.X81MVLL3EIV4@bootlin.com> <87fr9szti5.fsf@redhat.com>
In-Reply-To: <87fr9szti5.fsf@redhat.com>
X-Last-TLS-Session-Version: TLSv1.3

On Tue Dec 2, 2025 at 6:24 PM CET, Paolo Valerio wrote:
> On 26 Nov 2025 at 07:08:14 PM, Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>=
 wrote:
>> ### Rx buffer size computation

[...]

>>  - NET_IP_ALIGN is accounted for in the headroom even though it isn't
>>    present if !RSC.
>
> that's something I noticed and I was a unsure about the reason.

Mistake because I forgot, nothing more than that.

>>  - If the size clamping to PAGE_SIZE comes into play, we are probably
>>    doomed. It means we cannot deal with the MTU and we'll probably get
>>    corruption. If we do put a check in place, it should loudly fail
>>    rather than silently clamp.
>
> That should not happen, unless I'm missing something.
> E.g., 9000B mtu on a 4K PAGE_SIZE kernel should be handled with multiple
> descriptors. The clamping is there because according with how the series
> creates the pool, the maximum buffer size is page order 0.
>
> Hardware-wise bp->rx_buffer_size should also be taken into account for
> the receive buffer size.

Yes I agree. We can drop the check, I was not implying we *had* to keep
the check.

[...]

>> ### Buffer variable names
>>
>> Related: so many variables, fields or constants have ambiguous names,
>> can we do something about it?
>>
>>  - bp->rx_offset is named oddly to my ears. Offset to what?
>>    Maybe bp->rx_head or bp->rx_headroom?
>
> bp->rx_headroom sounds a good choice to me, but if you have a stronger
> preference for bp->rx_head just let me know.

No strong preference, ack for bp->rx_headroom.

[...]

>> ### XDP_SETUP_PROG if netif_running()
>>
>> I'd like to start a discussion on the expected behavior on XDP program
>> change if netif_running(). Summarised:
>>
>> static int gem_xdp_setup(struct net_device *dev, struct bpf_prog *prog,
>>              struct netlink_ext_ack *extack)
>> {
>>     bool running =3D netif_running(dev);
>>     bool need_update =3D !!bp->prog !=3D !!prog;
>>
>>     if (running && need_update)
>>         macb_close(dev);
>>     old_prog =3D rcu_replace_pointer(bp->prog, prog, lockdep_rtnl_is_hel=
d());
>>     if (running && need_update)
>>         return macb_open(dev);
>> }
>>
>> Have you experimented with that? I don't see anything graceful in our
>> close operation, it looks like we'll get corruption or dropped packets
>> or both. We shouldn't impose that on the user who just wanted to swap
>> the program.
>>
>> I cannot find any good reason that implies we wouldn't be able to swap
>> our XDP program on the fly. If we think it is unsafe, I'd vote for
>> starting with a -EBUSY return code and iterating on that.
>>
>
> I didn't experiment much with this, other than simply adding and
> removing programs as needed during my tests. Didn't experience
> particular issues.
>
> The reason a close/open sequence was added here was mostly because I was
> considering to account XDP_PACKET_HEADROOM only when a program was
> present. I later decided to not proceed with that (mostly to avoid
> changing too many things at once).
>
> Given the geometry of the buffer remains untouched in either case, I
> see no particular reasons we can't swap on the fly as you suggest.
>
> I'll try this and change it, thanks!

Yes! I had guessed that you thought about changing the headroom based on
XDP or !XDP by reading the code. :-)

I agree we should aim for on-the-fly swapping available in all cases,
it sounds reasonable to achieve and a nice-to-have feature.

Regards,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


