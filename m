Return-Path: <netdev+bounces-250256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0A0D26137
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 18:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F087302197E
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 17:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D5D3BF316;
	Thu, 15 Jan 2026 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PyHD9Xc2"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC0F396B7D;
	Thu, 15 Jan 2026 17:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768496755; cv=none; b=XMvLxmhd5IsYsEiJfKvECkAMn9jQjyQsZfJ03a7Fpr65hf0cD3EQIB1y9Ba88CCXn/Ez9GKKrB78P080Kc+tyShySUVhQlPB9cCZJasJbJjRGw3drmGbtCZZgHK1MUf1rW5/xcmNUxElxBqbwR5PKrqN28qg0DLRDmG4cSbASzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768496755; c=relaxed/simple;
	bh=y8qkrc7MAMIJcCKh2tDsF+EBlT0sGzZ7XalQzMxRcdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s7yoVI+o2UYxDIHHTVGLL/yMUAMCENA2hBxLiB+nLeJB7iVtRiBFjfyoxea2Yiz/5rgOBQR/6Q8AdrvzRg9KFKs6WZa5tgFFZtc0qgWPzqXtG5hTtpGm9xUiTQGJX230W1ZFJtIXId2pHcYeA6CmsX6bj46GqSxf6ZMah3NDkKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PyHD9Xc2; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 67C4FC1F1E7;
	Thu, 15 Jan 2026 17:05:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0298A606E0;
	Thu, 15 Jan 2026 17:05:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D0EEB10B686E6;
	Thu, 15 Jan 2026 18:05:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768496749; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=g4zRCSFfE37X0wjE4Eq60ptM+6zY+xi0fpy9SZxByac=;
	b=PyHD9Xc2nFFNUiJ8vCVKW6UoakkqrJe4GfZCmHL47MSiF7lqDVHbIizQ+CqIuDxa3UrF0d
	69x3/HeT4iQ4ZpGF7A9AEaOgJBdiL3ax4kenM4qkK5JB3kysk1/sol6ynCKQzoHU0xpJZb
	knTvfnnGFoaJmmsGLAmeLASOAdhdzoi0VDMYp6tTna0K0TD5xySYQDy2KAe2AN4Ois5ZPi
	wAPiIJqxXwKr+y4EPEO8gsI0nerg7ai0eTSrcc78mUylsPJMkP/IP2C8POMuBrMdH/Inl9
	hCPSRsty4LYYmNv1BHQItLHE4/y5L3HC1rtgEtyUz6gUG/GvBWJNEUcCGeocKg==
Message-ID: <722dcba9-d9ae-43ba-b1bf-1d577a882bef@bootlin.com>
Date: Thu, 15 Jan 2026 18:05:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/8] net: dsa: microchip: Add KSZ8463 tail tag
 handling
To: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>,
 Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>, Simon Horman <horms@kernel.org>
Cc: Pascal Eberhard <pascal.eberhard@se.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260115-ksz8463-ptp-v1-0-bcfe2830cf50@bootlin.com>
 <20260115-ksz8463-ptp-v1-5-bcfe2830cf50@bootlin.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260115-ksz8463-ptp-v1-5-bcfe2830cf50@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Bastien,

On 15/01/2026 16:57, Bastien Curutchet (Schneider Electric) wrote:
> KSZ8463 uses the KSZ9893 DSA TAG driver. However, the KSZ8463 doesn't
> use the tail tag to convey timestamps to the host as KSZ9893 does. It
> uses the reserved fields in the PTP header instead.

[ ... ]

> +static struct sk_buff *ksz8463_rcv(struct sk_buff *skb, struct net_device *dev)
> +{
> +	unsigned int len = KSZ_EGRESS_TAG_LEN;
> +	struct ptp_header *ptp_hdr;
> +	unsigned int ptp_class;
> +	unsigned int port;
> +	ktime_t tstamp;
> +	u8 *tag;
> +
> +	if (skb_linearize(skb))
> +		return NULL;
> +
> +	/* Tag decoding */
> +	tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
> +	port = tag[0] & KSZ8463_TAIL_TAG_EG_PORT_M;
> +
> +	__skb_push(skb, ETH_HLEN);
> +	ptp_class = ptp_classify_raw(skb);
> +	__skb_pull(skb, ETH_HLEN);
> +	if (ptp_class == PTP_CLASS_NONE)
> +		goto common_rcv;
> +
> +	ptp_hdr = ptp_parse_header(skb, ptp_class);
> +	if (ptp_hdr) {
> +		tstamp = ksz_decode_tstamp(get_unaligned_be32(&ptp_hdr->reserved2));
> +		KSZ_SKB_CB(skb)->tstamp = tstamp;

As it is using a reserved field, is it OK to leave this field as-is when forwarding
this skb to userspace, or should it be zeroed first ?

Maxime


