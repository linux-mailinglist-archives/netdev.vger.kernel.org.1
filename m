Return-Path: <netdev+bounces-250457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91302D2CF25
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 08:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49C273027E08
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 07:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3326346799;
	Fri, 16 Jan 2026 07:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eRCQvuAf"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0319344035
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 07:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768547340; cv=none; b=rKQvaHeDH3gYyEag/+7a7yIO8U2zTF5BJVyds/edXbszsSrv7IYArPUCCsD3QzFcr+4r57/9uXMNVznZgWPGMI8/I1y4Oj/KlP6QGnSEmvtvrxOAPdLW+ZA3t9tECOZz3OOgn3W1s5cxa6olL5dCZXRdFGZ807z05r40TpjS6YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768547340; c=relaxed/simple;
	bh=GUgRfny8ILBolkzrIObt84Gwn9WtU+PYmdPIsybZBPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d3P8a5db16oiq6+6hHoBn2hUgeDa0+jmk8/6zA3N2wSPcFtpb8QF9hgTA5qHIkuRcYuiv1TBBjE5M2jdItsdMv5+h5csxEYl7knJtdiMC0OnSazEI2CuV7RSBE7Da/Vt4owyY7OKJp0z9zBjHIcYW5BEc7Jaq6cOGYY01DDRH1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eRCQvuAf; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 407EFC1F1F4;
	Fri, 16 Jan 2026 07:08:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CE63960732;
	Fri, 16 Jan 2026 07:08:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7B91610B68919;
	Fri, 16 Jan 2026 08:08:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768547334; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=7X4iGHOpoO4GX15j7st3JUnO9pqAPsNSvmrMO+kwytg=;
	b=eRCQvuAfVs4WgEaFm98M6B6lq46VFaDSSJV93xTdctTsEeTEKzvxP2UinsUVkZKDKWs+wH
	fjIe/w+h6WEA8T7Yg2tREEIN03yJ7sXapAmCVfo27raDDNUgbAQxnV/b+GViSo5o+k2Vy/
	fwCHOEFlg6y70bDYVx1TgDx3jeIO7VFa+bpzJVNxa/0rQ3gxFAAThYaxiKPv8FlacIJgnp
	TILGIDsqzC4Kgo2UahLjpFZ+7Nc8Fq0C49A1lwR17zPhezrSz97KjCpZ4eY3AZ1UwEHehl
	QhwgEWviJ14cOMTdtW2F5AWCUusiTroT/iNGz1nBx5R303qDbkKRVdjPYErTPQ==
Message-ID: <b6779c36-c969-42dd-9395-6c34de55a5d9@bootlin.com>
Date: Fri, 16 Jan 2026 08:08:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/8] net: dsa: microchip: Add KSZ8463 tail tag
 handling
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
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
 <722dcba9-d9ae-43ba-b1bf-1d577a882bef@bootlin.com>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <722dcba9-d9ae-43ba-b1bf-1d577a882bef@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Maxime,

On 1/15/26 6:05 PM, Maxime Chevallier wrote:
> Hi Bastien,
> 
> On 15/01/2026 16:57, Bastien Curutchet (Schneider Electric) wrote:
>> KSZ8463 uses the KSZ9893 DSA TAG driver. However, the KSZ8463 doesn't
>> use the tail tag to convey timestamps to the host as KSZ9893 does. It
>> uses the reserved fields in the PTP header instead.
> 
> [ ... ]
> 
>> +static struct sk_buff *ksz8463_rcv(struct sk_buff *skb, struct net_device *dev)
>> +{
>> +	unsigned int len = KSZ_EGRESS_TAG_LEN;
>> +	struct ptp_header *ptp_hdr;
>> +	unsigned int ptp_class;
>> +	unsigned int port;
>> +	ktime_t tstamp;
>> +	u8 *tag;
>> +
>> +	if (skb_linearize(skb))
>> +		return NULL;
>> +
>> +	/* Tag decoding */
>> +	tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
>> +	port = tag[0] & KSZ8463_TAIL_TAG_EG_PORT_M;
>> +
>> +	__skb_push(skb, ETH_HLEN);
>> +	ptp_class = ptp_classify_raw(skb);
>> +	__skb_pull(skb, ETH_HLEN);
>> +	if (ptp_class == PTP_CLASS_NONE)
>> +		goto common_rcv;
>> +
>> +	ptp_hdr = ptp_parse_header(skb, ptp_class);
>> +	if (ptp_hdr) {
>> +		tstamp = ksz_decode_tstamp(get_unaligned_be32(&ptp_hdr->reserved2));
>> +		KSZ_SKB_CB(skb)->tstamp = tstamp;
> 
> As it is using a reserved field, is it OK to leave this field as-is when forwarding
> this skb to userspace, or should it be zeroed first ?
> 

It doesn't seem to hurt, at least on my test setup (I'm using ptp4l in 
userspace btw), but I agree with you: it feels safer to zero it first. 
I'll do it in next iteration.


Best regards,
Bastien

