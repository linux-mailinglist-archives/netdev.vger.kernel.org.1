Return-Path: <netdev+bounces-259320-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QM2nCRvZlWmmVQIAu9opvQ
	(envelope-from <netdev+bounces-259320-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 16:22:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4EB1575C9
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 16:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BEBD300F11B
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 15:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECD533F39E;
	Wed, 18 Feb 2026 15:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xOyfwNJ8"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDF133EAF8
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 15:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771428096; cv=none; b=EvGCRuA11p/adZ/BnN3zBzcGL6yj7WKSb8UI0VJAyKaG75eF6f/JFbsNDSJZt8TXiiBiNl0wWLyAUCoXWGFkU9mCjTwT3O23OVH0lOY0QGMwIA6LfKAyQmcLuaKCNRk7WH0aSjko6slIB5Kaq1L2n0qbh/RvySBhPxfA1CUAfTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771428096; c=relaxed/simple;
	bh=KLrvUTNmh3soDRi2SthinNxffHdvGFr26sJHESqU7xQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n54fdW+LMdIhT89nJgKUnRLNrC6JMd7JbPc1fzNdGuznFIwANlU4pUw+1BIxdYhd5E4mlF9WpK+ymlSzJqofaeKSXV3i7Wm/Vbku8VARHM4mMKuHGB1olFsSlDdzhq+/MYOR/p8kDqEW79IruhS3SQkARIKX0BMBwIccasjE4mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xOyfwNJ8; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 67DBE1A0429;
	Wed, 18 Feb 2026 15:21:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 371905FA23;
	Wed, 18 Feb 2026 15:21:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E379410368B26;
	Wed, 18 Feb 2026 16:21:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771428091; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=FD4TimzDTZHORmT5915jgM3Ngwp7ixLRJF7XS8OvqQw=;
	b=xOyfwNJ8AjY1a1gkh/ZT5tpW3SyAKP8/FFJrmjEdS07O9pzk6xcyskSAUiuRUgjCSF8FK2
	PF8DosL60swUe3uGOBh6IG7UT2gRyknoQG3jBVPHCXpVPaKPx3OQDTLeVMOI99oKWp+q8q
	OV8axRiGgdv3naDtKh6mPRGt+svBNXgJig5dgsbtfPV+KqYUpIRmxyx03qiww2UiFRztFV
	XFYi5AgCxyuK1a93sGe+kiw0WFbiC+QsPuoWV/lE9zxpx63m5hj9D+3bp/SlE3cEvXyIkP
	oQpZzjeq93X/SyoqKyV74uXLjTS3As45v5YWvip0jMhoDd7P6aYZMr5nk+kfJg==
Message-ID: <b4997be6-fe03-4ac1-8568-38e0a78dc602@bootlin.com>
Date: Wed, 18 Feb 2026 16:21:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 8/8] net: dsa: microchip: Add two-step PTP
 support for KSZ8463
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
 <20260127-ksz8463-ptp-v4-0-652e021aae86@bootlin.com>
 <20260127-ksz8463-ptp-v4-8-652e021aae86@bootlin.com>
 <20260127-ksz8463-ptp-v4-8-652e021aae86@bootlin.com>
 <20260202134330.xzc2wmcwwqhw4dfc@skbuf>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260202134330.xzc2wmcwwqhw4dfc@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259320-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,se.com,bootlin.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:dkim,bootlin.com:email]
X-Rspamd-Queue-Id: 7D4EB1575C9
X-Rspamd-Action: no action

Hi Vladimir,

On 2/2/26 2:43 PM, Vladimir Oltean wrote:
> On Tue, Jan 27, 2026 at 10:06:50AM +0100, Bastien Curutchet (Schneider Electric) wrote:
>> The KSZ8463 switch supports PTP but it's not supported by driver.
>>
>> Add L2 two-step PTP support for the KSZ8463. IPv4 and IPv6 layers aren't
>> supported. Neither is one-step PTP.
>>
>> The pdelay_req and pdelay_resp timestamps share one interrupt bit status.
>> So introduce last_tx_is_pdelayresp to keep track of the last sent event
>> type. Use it to retrieve the relevant timestamp when the interrupt is
>> caught.
>>
>> Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
>> ---
>> @@ -518,6 +535,8 @@ void ksz_port_txtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb)
>>   	if (!hdr)
>>   		return;
>>   
>> +	prt->last_tx_is_pdelayresp = false;
>> +
>>   	ptp_msg_type = ptp_get_msgtype(hdr, type);
>>   
>>   	switch (ptp_msg_type) {
>> @@ -528,6 +547,7 @@ void ksz_port_txtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb)
>>   	case PTP_MSGTYPE_PDELAY_REQ:
>>   		break;
>>   	case PTP_MSGTYPE_PDELAY_RESP:
>> +		prt->last_tx_is_pdelayresp = true;
>>   		if (prt->tstamp_config.tx_type == HWTSTAMP_TX_ONESTEP_P2P) {
>>   			KSZ_SKB_CB(skb)->ptp_type = type;
>>   			KSZ_SKB_CB(skb)->update_correction = true;
>> @@ -972,7 +992,17 @@ void ksz_ptp_clock_unregister(struct dsa_switch *ds)
>>   
>>   static int ksz_read_ts(struct ksz_port *port, u16 reg, u32 *ts)
>>   {
>> -	return ksz_read32(port->ksz_dev, reg, ts);
>> +	u16 ts_reg = reg;
>> +
>> +	/**
>> +	 * On KSZ8463 DREQ and DRESP timestamps share one interrupt line
>> +	 * so we have to check the nature of the latest event sent to know
>> +	 * where the timestamp is located
>> +	 */
>> +	if (ksz_is_ksz8463(port->ksz_dev) && port->last_tx_is_pdelayresp)
>> +		ts_reg += KSZ8463_DRESP_TS_OFFSET;
>> +
>> +	return ksz_read32(port->ksz_dev, ts_reg, ts);
>>   }
> 
> There is a race condition here.
> 
> ksz_port_txtstamp() is called "at line rate" - it doesn't wait for the
> timestamping of the currently in progress skb to finish.
> 
> See the order in
> static netdev_tx_t dsa_user_xmit(struct sk_buff *skb, struct net_device *dev)
> {
> 	struct dsa_user_priv *p = netdev_priv(dev);
> 	struct sk_buff *nskb;
> 
> 	dev_sw_netstats_tx_add(dev, 1, skb->len);
> 
> 	memset(skb->cb, 0, sizeof(skb->cb));
> 
> 	dsa_skb_tx_timestamp(p, skb); // calls ksz_port_txtstamp()
> 
> 	...
> 
> 	nskb = p->xmit(skb, dev); // calls ksz9893_xmit() -> ksz_defer_xmit()
> 	if (!nskb) {
> 		kfree_skb(skb); // deferred xmit enters this code path
> 		return NETDEV_TX_OK;
> 	}
> 
> 	return dsa_enqueue_skb(nskb, dev);
> }
> 
> The deferred worker gets scheduled much later, time during which a
> second PTP packet may be transmitted from the stack.
> 
> If you let the second skb change the port->last_tx_is_pdelayresp which
> ksz_ptp_msg_thread_fn() -> ksz_read_ts() thinks is associated with the
> first skb, you're in big trouble.
> 
> You need to set port->last_tx_is_pdelayresp in the atomic section where
> you know for sure that there's a single TX timestampable skb in flight.
> There's no explicit lock which creates that atomic section, but the fact
> that the worker kthread of the tagger processes work items one by one is
> what gives you that guarantee.

Thank you for the explanations. I suspected a race condition here but I 
didn't know how to mitigate it. I tested a new version on my side with 
port->last_tx_is_pdelayresp set in the ksz_port_deferred_xmit() worker 
and it works fine.

I'll wait for net-next to open back to send this new version.


Best regards,
Bastien


