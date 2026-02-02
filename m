Return-Path: <netdev+bounces-255869-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eA1+M12rgGkFAQMAu9opvQ
	(envelope-from <netdev+bounces-255869-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 14:49:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C12BCCEE1
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 14:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E48F303CE10
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 13:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C71369235;
	Mon,  2 Feb 2026 13:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxoO561d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E7C27FD49
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 13:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770039816; cv=none; b=TRjPM8chfqreUA3dpt/d5lsMB3RdhM36g6jLBlNbUjuPoM52acew2RG/WqYur9XoSIjzfE4s8n3Y+ptISRXHuMIrNG1u+m88UclljET1tUJ5ZWtkFxAV176RqtPRWI9fXx1H2BdaiQvzJdZJDMnZ1c4FAQN4FnQaSMfk5OjY1AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770039816; c=relaxed/simple;
	bh=jCXFB8g3+e5C1Zr9hEdpI/1Lo+Q0TYtwpGk/hgYVtFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/l5t9YbyYvB36f/XuHeUQyxGQSL2bGHSHJ5bEP+nlJfpv4xVkxbzKxhbN7lPuBASnopR5T4/GnfocZUCwRBXAcRTPlwvYpXMEpNx1aQZ2wUssOXMlEzI5AdMaYgA8XOLxJPemK8VGUyw64ajyXpjn8+kWu1ykW0lgfKdzAxQIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxoO561d; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-432c0b8f114so237280f8f.0
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 05:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770039814; x=1770644614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0j81eM6QfZ7o4aJKQrTqYKKS8lGCGE49fOPRgvQwWhE=;
        b=HxoO561dj++HhTOvAnKZq1f85c6hpij6vmePLc4R4tsefIvRYtjNuo7vW+NJU/VUKE
         QYP+9B//+F2ZTzp45bH6qoh3OO6xZaMaXSxl60OpCsNCmKfbc0zUfOwheoVJ8RlngnEs
         UakAAEGp0b22LIZeYJPEVA4KB44/yEvlKCsikZy7YTWiVbONdUFGSCfSlDHDnPywLAXX
         WBNIlrQ3csY1wKlGibPMU63GzFJ2konK6xq03G6kI6jK1QF97Sdw8vSP9YGks2Uss6TJ
         D/4jqAGl5CGZ+XkLq5k6/soj0DElgQjCPLNwnc8qB7eMxwxmeYLJUz8b5BDbkV2oV5JU
         +Nyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770039814; x=1770644614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0j81eM6QfZ7o4aJKQrTqYKKS8lGCGE49fOPRgvQwWhE=;
        b=uQlfY4VHsCQdvWagfvhmVroovXwVCa6xgInmhmvGQi00Hor4gNPXI7cw2yo84aeJ33
         NgZNmfSxQ/aH67fFC1uIMxliSkc8eXif4wv6+hhoyzeudRMLdPTv22OTT4pn3+voz0x3
         FUhAxdW/0YFV/JNIDhne4xlK5b+8C2W6Y1sWizejrQ/yCt9H25Sxe5Dv7iNZjAQEpWxG
         H7JbsUZ3fBZxRS2eaiUVnh8fyLsr22OcREs1I3RlDr2pIUAe3bLra3+Qasrqvnjn/oUd
         6ODqDmpg6404Xb8JA+tuMEsqY4Lpez4PEHjonL9oV/uQB2V1+pbX2sONw1FX1uqXIWYi
         lWLA==
X-Forwarded-Encrypted: i=1; AJvYcCWqWhclbdxYEIkLtfuAGV7p66XVDNBYYDWul08V39rhxVN3EP+i7Bf1X3HpBeRNU48WbG0NHMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEQKdKMbybQNWnmu5XqKkN/Q65qvSrZkVkGI2E+bEZd2MC6CBZ
	Wi+hpZOZLS0wioKSQ1zJ/ifyiy/cXX2ob4Usq7JTqY1hxblUbKrSaeWq
X-Gm-Gg: AZuq6aKeZEC2Qg0seG3j84PdnF2Hr3KrlGc55Zrd3ogOavbEtX5moOt58spZ8kRkM4D
	STwQ/HZfAvwMmHCIPL2DrmFwQXZWaqauygJj9pn3N15CsTgUMlBnkTvmVJr7g8PhkL4SfzGcltG
	Yk7gq9WvaLys/NZhgGyqpwQbX3bekRlCUFsz4Am79+tEIvul7FdhMBbOm5/BTEiiRiIlmEbCWvD
	mBt5JjG0Uv7rlz498cM4QHfKlyoSzuNCJZ4xfTNVzwRHz7EPYgrBWri3bMDNMChDZsaBfFF1hOC
	Wc14f9IENlI12YeSZiyeE2ftMGdfYg8NhzNXG8p2sdcM/lx0LfZqMdMB415DncKxq0WM1IrouIe
	QhWOOso1l0JvYr0t/2bwpbAJ0BJ25JIrcbLSaXI8KGHRiOpPq5j3XTmx4803gbM8sGNX2UMSEVH
	9W/Yc=
X-Received: by 2002:a05:6000:1a8f:b0:435:db94:1935 with SMTP id ffacd0b85a97d-435f3adfbe2mr9056078f8f.8.1770039813334;
        Mon, 02 Feb 2026 05:43:33 -0800 (PST)
Received: from skbuf ([2a02:2f04:d501:d900:74c4:3a65:f9a9:6c29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10ee040sm43731062f8f.11.2026.02.02.05.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 05:43:32 -0800 (PST)
Date: Mon, 2 Feb 2026 15:43:30 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Pascal Eberhard <pascal.eberhard@se.com>,
	=?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 8/8] net: dsa: microchip: Add two-step PTP
 support for KSZ8463
Message-ID: <20260202134330.xzc2wmcwwqhw4dfc@skbuf>
References: <20260127-ksz8463-ptp-v4-0-652e021aae86@bootlin.com>
 <20260127-ksz8463-ptp-v4-0-652e021aae86@bootlin.com>
 <20260127-ksz8463-ptp-v4-8-652e021aae86@bootlin.com>
 <20260127-ksz8463-ptp-v4-8-652e021aae86@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127-ksz8463-ptp-v4-8-652e021aae86@bootlin.com>
 <20260127-ksz8463-ptp-v4-8-652e021aae86@bootlin.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255869-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,se.com,bootlin.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email]
X-Rspamd-Queue-Id: 5C12BCCEE1
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 10:06:50AM +0100, Bastien Curutchet (Schneider Electric) wrote:
> The KSZ8463 switch supports PTP but it's not supported by driver.
> 
> Add L2 two-step PTP support for the KSZ8463. IPv4 and IPv6 layers aren't
> supported. Neither is one-step PTP.
> 
> The pdelay_req and pdelay_resp timestamps share one interrupt bit status.
> So introduce last_tx_is_pdelayresp to keep track of the last sent event
> type. Use it to retrieve the relevant timestamp when the interrupt is
> caught.
> 
> Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
> ---
> @@ -518,6 +535,8 @@ void ksz_port_txtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb)
>  	if (!hdr)
>  		return;
>  
> +	prt->last_tx_is_pdelayresp = false;
> +
>  	ptp_msg_type = ptp_get_msgtype(hdr, type);
>  
>  	switch (ptp_msg_type) {
> @@ -528,6 +547,7 @@ void ksz_port_txtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb)
>  	case PTP_MSGTYPE_PDELAY_REQ:
>  		break;
>  	case PTP_MSGTYPE_PDELAY_RESP:
> +		prt->last_tx_is_pdelayresp = true;
>  		if (prt->tstamp_config.tx_type == HWTSTAMP_TX_ONESTEP_P2P) {
>  			KSZ_SKB_CB(skb)->ptp_type = type;
>  			KSZ_SKB_CB(skb)->update_correction = true;
> @@ -972,7 +992,17 @@ void ksz_ptp_clock_unregister(struct dsa_switch *ds)
>  
>  static int ksz_read_ts(struct ksz_port *port, u16 reg, u32 *ts)
>  {
> -	return ksz_read32(port->ksz_dev, reg, ts);
> +	u16 ts_reg = reg;
> +
> +	/**
> +	 * On KSZ8463 DREQ and DRESP timestamps share one interrupt line
> +	 * so we have to check the nature of the latest event sent to know
> +	 * where the timestamp is located
> +	 */
> +	if (ksz_is_ksz8463(port->ksz_dev) && port->last_tx_is_pdelayresp)
> +		ts_reg += KSZ8463_DRESP_TS_OFFSET;
> +
> +	return ksz_read32(port->ksz_dev, ts_reg, ts);
>  }

There is a race condition here.

ksz_port_txtstamp() is called "at line rate" - it doesn't wait for the
timestamping of the currently in progress skb to finish.

See the order in
static netdev_tx_t dsa_user_xmit(struct sk_buff *skb, struct net_device *dev)
{
	struct dsa_user_priv *p = netdev_priv(dev);
	struct sk_buff *nskb;

	dev_sw_netstats_tx_add(dev, 1, skb->len);

	memset(skb->cb, 0, sizeof(skb->cb));

	dsa_skb_tx_timestamp(p, skb); // calls ksz_port_txtstamp()

	...

	nskb = p->xmit(skb, dev); // calls ksz9893_xmit() -> ksz_defer_xmit()
	if (!nskb) {
		kfree_skb(skb); // deferred xmit enters this code path
		return NETDEV_TX_OK;
	}

	return dsa_enqueue_skb(nskb, dev);
}

The deferred worker gets scheduled much later, time during which a
second PTP packet may be transmitted from the stack.

If you let the second skb change the port->last_tx_is_pdelayresp which
ksz_ptp_msg_thread_fn() -> ksz_read_ts() thinks is associated with the
first skb, you're in big trouble.

You need to set port->last_tx_is_pdelayresp in the atomic section where
you know for sure that there's a single TX timestampable skb in flight.
There's no explicit lock which creates that atomic section, but the fact
that the worker kthread of the tagger processes work items one by one is
what gives you that guarantee.

