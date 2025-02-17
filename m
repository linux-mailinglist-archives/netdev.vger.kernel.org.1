Return-Path: <netdev+bounces-166898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B90BA37D55
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 09:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2090E16FF94
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 08:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858BC1A23AC;
	Mon, 17 Feb 2025 08:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="gpQLRSHU"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44AE19DF40;
	Mon, 17 Feb 2025 08:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739781658; cv=none; b=bm9wd4VDtTrmRjFV9N8rPeVlcasGIOSyNKOOqmCBMydq1Xi/Yc1Cil0ZhWqHH7/HG6ekSCoJRYNT8zafMDvidEdL1ww9mQK6HWky+XlgDcRSRa5ab9+TPo+87nWh5JrV0Av6tRrhtpbYKbemoJLNRMIaCGj+KDM9JhoLvmChnVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739781658; c=relaxed/simple;
	bh=GGw1C7ybr/plidwxzlXTjv5bFmLLxfVlGGxElJ4BETE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LtzRVZdGbUcL9g8D+nB7LTOPpgw+asLRKz40/3EwhEsOd14dszXgNBYR8PxakgoRm3irMYlR4knEm5BGzB2tICsG8AZhlEmjb0KRv03Wr9+yIRksBYV2Gjmv7QCLHXIi7snvxwHfFpq/H3H8tqN/qe5WTlYZzWVgxlK+bPndgYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=gpQLRSHU; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1739781651;
	bh=GGw1C7ybr/plidwxzlXTjv5bFmLLxfVlGGxElJ4BETE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gpQLRSHU+g6GyH7PbsKKBqcOjK6Dcu8NWKSCWJ+W6HwL95zt5bB8b2OLVSAQPX41Z
	 4gK8doPy+npSKuxSksna/Z+8c5Ucpxomjqjq+Z2QAtw9248FKvgh+AuW3GYUxhiVQM
	 G32+SReKjyhb3FU0w+icW/igbA5VdX9RZI0FMhbkOe9SPDz33CvDQgBlcVkcwfACDz
	 H6uwNIGKgq/FoDx6tkiR1mIkX+p1p29T5vMcjdjAtSpO6ET7Kaw8FHTZRwZDTUd/A9
	 HIqAW9SwrmOvg1BSjE1C+vSygblgX+RI6bWiB2W4XIMDWBSVWL5U19wMxjdJ1Bj3F3
	 h3kiwHVscxtDQ==
Received: from [192.168.72.171] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id EB556759DD;
	Mon, 17 Feb 2025 16:40:49 +0800 (AWST)
Message-ID: <0fddf411bfb13c46703286381b81bd64fda4ac45.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next v2 2/2] net: mctp: Add MCTP USB transport driver
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Matt Johnston <matt@codeconstruct.com.au>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>,  netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, Santosh Puranik <spuranik@nvidia.com>
Date: Mon, 17 Feb 2025 16:40:49 +0800
In-Reply-To: <20250214194531.5ddded19@kernel.org>
References: <20250212-dev-mctp-usb-v2-0-76e67025d764@codeconstruct.com.au>
	 <20250212-dev-mctp-usb-v2-2-76e67025d764@codeconstruct.com.au>
	 <20250214194531.5ddded19@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jakub,

Thanks for the review. Comments inline.

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__u8 ep_in;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__u8 ep_out;
>=20
> same nit about u8 as on the header

Ack, have changed, as well as on the header.

> Letter for letter dev_dstats_tx_dropped() ?
[...]
> And this dev_dstats_tx_add() ?
[...]
> dev_dstats_rx_add()

Neat, thanks!

> > +static netdev_tx_t mctp_usb_start_xmit(struct sk_buff *skb,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 struct net_device *dev)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct mctp_usb *mctp_usb =
=3D netdev_priv(dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct mctp_usb_hdr *hdr;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int plen;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct urb *urb;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int rc;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0plen =3D skb->len;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (plen + sizeof(*hdr) > MC=
TP_USB_XFER_SIZE)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0goto err_drop;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hdr =3D skb_push(skb, sizeof=
(*hdr));
>=20
> Hm, I guess MCTP may have its own rules but technically you should
> call skb_cow_head() before you start writing to the header buffer.

We currently have ensured that we have headroom when the skb had been
allocated. However, things will get a bit more complex when we introduce
proper forwarding, so I will add the skb_cow_head() for v3 (and
introduce it on the other drivers as we go...)

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (skb)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0kfree_skb(skb);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mctp_usb_rx_queue(mctp_usb, =
GFP_ATOMIC);
>=20
> What if we fail to allocate an skb ?
> Admittedly the buffers are relatively small but if the allocation
> fails we'd get stuck, no more packets will ever be received, right?
> May be safer to allocate the skb first, and if it fails reuse the
> skb that just completed (effectively discarding the incoming packets
> until a replacement buffer can be allocated).

I think we can do a little better, and defer retries to a non-atomic
context instead. This means we have a chance of flow control over the
IN transfers from the device too, rather than dropping everything.

I'll implement that for v3.

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev->hard_header_len =3D siz=
eof(struct mctp_usb_hdr);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev->tx_queue_len =3D DEFAUL=
T_TX_QUEUE_LEN;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev->addr_len =3D 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev->flags =3D IFF_NOARP;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev->netdev_ops =3D &mctp_us=
b_netdev_ops;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev->needs_free_netdev =3D f=
alse;
>=20
> Is there a reason to set this to false?
> dev memory is guaranteed to be zero'ed out.

.. only because I had previously had it as true before the usb
disconnect was implemented. With that change, I had decided to not
remove it with the justification that it's a little more clear that we
need to do our own free after unregister.

Happy to make this more conventional though, so will remove (as well
as the addr_len assignment) in v3.

Cheers,


Jeremy

