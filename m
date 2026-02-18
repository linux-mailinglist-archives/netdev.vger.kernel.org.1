Return-Path: <netdev+bounces-259242-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGiFAEWIlWnqSAIAu9opvQ
	(envelope-from <netdev+bounces-259242-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 10:37:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1FD154C42
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 10:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34D4930143D0
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 09:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5148033CEB4;
	Wed, 18 Feb 2026 09:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="sQUwkXyv"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C901F33C509;
	Wed, 18 Feb 2026 09:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771407426; cv=none; b=QDPol9xTVn5F/OmIc2F9COWSfoz4/S2zTXmwXPXxGkekp6Xb6+2L7VmBAlcXYn3r3zV+6Bgn3e2b1UjatcHg+aZcvmmP5CAF0l+WOzDl62jbay7PK3C8ZMN/0jQwa8As58VKFD/8W0X9f24kcgzOpgaMttB6liNJFjqYKqDyfXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771407426; c=relaxed/simple;
	bh=LeTgk5sjjw2uwtLBgkbnMzgQke3xyBLh1LISBJPQUi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LNEumCZA8YIa+shbxmT5r+QM38OVQ7DwsjkKsfRctlGaIzINSwYOwRNkuhh8dVLsWPX5lkxLa5Zcn9SJ1YakyXprouu52oMupYi343WQx+NvrFFhSeyJTgTjNtb63DNUl1qX44bZxhS5HDy+0A736My79uFITYVMVXxG393zcTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=sQUwkXyv; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0D9444E40F41;
	Wed, 18 Feb 2026 09:36:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D735460738;
	Wed, 18 Feb 2026 09:36:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 170FF103688BE;
	Wed, 18 Feb 2026 10:36:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771407416; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=6F0vMRvW7cQ6/3aoKb6nwm9dFib3trJFBolmyJ9tv4M=;
	b=sQUwkXyvzbXQKZ+9OG0el51piiUuB2YfzyDDPXgur4s0eUdkULuElxkCrYIjGlLM0tE+89
	g88NNf7CGmP/3OHIa48PCgmEh5YvFKbdjJpw/Pm2xlAqInonTSA8jZ2+JzrdD8bxl19xRF
	pWTCwb/vV/O20XAjLwY1I8Nvs9TC8aEYffiZsBl7jv+EhmNDBQBj5X6k2iurkoJ+P8viZY
	NDVVAUA8v7V2ss2/8ut2G3jL74GuyegWZJzOuwMLUrItfhFxbJzGY6+mbB6xTUa78EuMHx
	ptsYambdDSbgHa3POC6kQ5AlBmQRNgUQXRu1qRIbKgvKlxSfWCHY8oDaPr+OEw==
Message-ID: <a69c8c32-c5df-484a-a1c7-a97a8f196f68@bootlin.com>
Date: Wed, 18 Feb 2026 10:36:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 5/8] net: dsa: microchip: Add KSZ8463 tail tag
 handling
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Simon Horman <horms@kernel.org>, Pascal Eberhard <pascal.eberhard@se.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260127-ksz8463-ptp-v4-0-652e021aae86@bootlin.com>
 <20260127-ksz8463-ptp-v4-5-652e021aae86@bootlin.com>
 <20260202132947.gepuhzdh4bepk4ot@skbuf>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <20260202132947.gepuhzdh4bepk4ot@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259242-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,se.com,bootlin.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Queue-Id: 6D1FD154C42
X-Rspamd-Action: no action

Hi Vladimir,

On 2/2/26 2:29 PM, Vladimir Oltean wrote:
> On Tue, Jan 27, 2026 at 10:06:47AM +0100, Bastien Curutchet (Schneider Electric) wrote:
>> @@ -383,6 +384,74 @@ static const struct dsa_device_ops ksz9893_netdev_ops = {
>>   DSA_TAG_DRIVER(ksz9893_netdev_ops);
>>   MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_KSZ9893, KSZ9893_NAME);
>>   
>> +#define KSZ8463_TAIL_TAG_PRIO		GENMASK(4, 3)
>> +#define KSZ8463_TAIL_TAG_EG_PORT_M	GENMASK(2, 0)
>> +
>> +static struct sk_buff *ksz8463_xmit(struct sk_buff *skb,
>> +				    struct net_device *dev)
>> +{
>> +	u16 queue_mapping = skb_get_queue_mapping(skb);
>> +	u8 prio = netdev_txq_to_tc(dev, queue_mapping);
>> +	struct dsa_port *dp = dsa_user_to_port(dev);
>> +	u8 *tag;
>> +
>> +	if (skb->ip_summed == CHECKSUM_PARTIAL && skb_checksum_help(skb))
>> +		return NULL;
>> +
>> +	tag = skb_put(skb, KSZ_INGRESS_TAG_LEN);
>> +
>> +	*tag = BIT(dp->index);
> 
> You're out of sync with mainline which has transitioned all
> BIT(dp->index) users to dsa_xmit_port_mask(skb, dev).
> 
> To avoid this in the future please do not duplicate the ksz9893 xmit
> implementation, but call a common function and use a "bool do_tstamp"
> variable which is true when called from ksz9893 and false from ksz8463.
> 

Ok, I'll do it, thank you.


Best regards,
Bastien

