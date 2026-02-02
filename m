Return-Path: <netdev+bounces-255866-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HLOCrCngGlNAAMAu9opvQ
	(envelope-from <netdev+bounces-255866-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 14:33:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E22FCCC48
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 14:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B2CC30107FF
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 13:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3362367F3A;
	Mon,  2 Feb 2026 13:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+TwLkTA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D28A366833
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 13:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770038993; cv=none; b=ZzWkY7gUOoRHHZ+toTQzJTJXd2A4ls6u/zrNVshxjrwJYBxxoz9xlWRA5RUee+mV56xxGpGqnNXgK1++CrY48XNNR0X6wCZjTveyF/mfHk9fLzw0z+CQvjbEWqQx59I/L4OMM9E7OeH4QhLqWc8E5YGRcxzpapnC3c9M686218I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770038993; c=relaxed/simple;
	bh=WaHKZ/McEXzUzbe8XhWNI/3c2hNKFJZt7wOD2NDguBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYJ967TFb/Uri4m3+4v6kFmDRjcy9JE1AN6ZH90zs0NfiU5ltDfRqT4rQF1K7v2e3UA/0Vh3PcSF4xENLsdldHw3rDKnHRNBSTbWfXnak/YU/4j1itkzqaFcadpftZUXU+3ckoxuug2iiAWaZ0j8G7It4mKQDDqNu3FuC7JCzOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+TwLkTA; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4806ca496feso2655585e9.0
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 05:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770038991; x=1770643791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SgTWxHTq6zBlc2AIUdyfY21mpRfZc8LW47kfkCH8qhg=;
        b=i+TwLkTAuSWAx2cq1nDH+R4qjEPkMakDvejMuiQ92jOwG0KD5EUOsxF6OziGlgWLRk
         0GLxTJ38orhozZATg7HzJiGl9Ttf2WN5Bt6D2F3CGDew2widkmPjncATaLDFMOTu/YpZ
         t5aYCCkFsJ+BnpdIeBorhgCjzewmWyvxgnW1xaEKWL/XfTuhsbrF+Pyo9E0lPGWT5MIV
         qVjkhc0VoooXu8ecHzJRVTDV1uo2cstISjWSH4dQs3pGBqrAkNo8iXExdtTqMz/1Rclu
         ITR/AbdIE9qy1fo34C78P5kPcptRv25rvytr0P1zSKfj9hcTILCE/oEmtzUG2Yu+b61M
         HLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770038991; x=1770643791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SgTWxHTq6zBlc2AIUdyfY21mpRfZc8LW47kfkCH8qhg=;
        b=aSuXPn2SNINigNLAJ3eRtruFPDJ6edN9TzydQItXgMrzmLYzsuk97dvMRwVPTBfiDJ
         AaK6h/AitDGX+FXfGW2z23NFXSW/nADe1Uo0wkzTEztQGqJKbQKzgCKChMDtvutSz+Rs
         +/if0QKFE6GiKYmd/y1WWMuQHR2pZhtXXLoBe/rURIs3sVmgc92LbHcQbyWF532o+pdf
         b91sYDYGsWAZky6qutK/EDP/RI5Hv+r2iw945r82a3zJPouSrUQEkcwi6KCSBn9QoTJm
         n39lb/hrkk80S/JiAnrgd10eohULSmmBHzMFDwa4pGpwRmn+4D8RnRxlxR6jAU5u1ZRH
         y5Nw==
X-Forwarded-Encrypted: i=1; AJvYcCULB7xuOS0/vkNz+UUj0JozGYpL3nlpcgyHGPDGO6IfyW32z9YN8Y1uBVUr1Ul6dQmfu8EHbOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQLMBDvJVjWQGxT79xtpQRvOGL4iwdhh4kL37tvVR3Ve59eGwR
	c54hmosKS78NApLUyqkU/6mstOIRGAXWOuAaPgCIG/UWA0Byy0dkp689
X-Gm-Gg: AZuq6aIOrls3ePsKGtkjiwVES3xXOsAJHJJ4O+UN/Dl0LAOi9d9b8DcQXlKilBEWS8j
	g3FGk8KTUf8bC9ByRn7FpUigtZwqJrC4Qrn+hGjojzo3kKnfJMa7DVK7lqRWZn8vE1R3LsC6J1s
	LcDkE3OjFeCcJi2SdAH1CLbpV9FAx+zJdyzMbEtDqY68uWVDc2Oe8Z7m++rKjEsA5cFo8dHVxf8
	asW877R50G+dlIXNbndcrC9c3Wk7IXKqp3D719ynd2E/o7g0b0OjCAhw76/CF0enB/Z4D5+2yox
	Rwdh0TPRQyWm6b67kzt2lieUCk2xyc7lmLPBMNuEK6mICqYKDpoQVK3GRO0IlnOvtXoeXVo9Ll0
	sEKP51sAAa59lOHVCpT/b/g4mxvt09YtB6/uPjdhNz5E3XTReLJvpBPalGRnsDi/hld9m1hqWXZ
	Mxmgg=
X-Received: by 2002:a05:600c:8b61:b0:47b:d992:601e with SMTP id 5b1f17b1804b1-482db4568b0mr95233925e9.2.1770038990732;
        Mon, 02 Feb 2026 05:29:50 -0800 (PST)
Received: from skbuf ([2a02:2f04:d501:d900:74c4:3a65:f9a9:6c29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482da903a30sm117174295e9.1.2026.02.02.05.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 05:29:50 -0800 (PST)
Date: Mon, 2 Feb 2026 15:29:47 +0200
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
Subject: Re: [PATCH net-next v4 5/8] net: dsa: microchip: Add KSZ8463 tail
 tag handling
Message-ID: <20260202132947.gepuhzdh4bepk4ot@skbuf>
References: <20260127-ksz8463-ptp-v4-0-652e021aae86@bootlin.com>
 <20260127-ksz8463-ptp-v4-5-652e021aae86@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127-ksz8463-ptp-v4-5-652e021aae86@bootlin.com>
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
	TAGGED_FROM(0.00)[bounces-255866-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7E22FCCC48
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 10:06:47AM +0100, Bastien Curutchet (Schneider Electric) wrote:
> @@ -383,6 +384,74 @@ static const struct dsa_device_ops ksz9893_netdev_ops = {
>  DSA_TAG_DRIVER(ksz9893_netdev_ops);
>  MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_KSZ9893, KSZ9893_NAME);
>  
> +#define KSZ8463_TAIL_TAG_PRIO		GENMASK(4, 3)
> +#define KSZ8463_TAIL_TAG_EG_PORT_M	GENMASK(2, 0)
> +
> +static struct sk_buff *ksz8463_xmit(struct sk_buff *skb,
> +				    struct net_device *dev)
> +{
> +	u16 queue_mapping = skb_get_queue_mapping(skb);
> +	u8 prio = netdev_txq_to_tc(dev, queue_mapping);
> +	struct dsa_port *dp = dsa_user_to_port(dev);
> +	u8 *tag;
> +
> +	if (skb->ip_summed == CHECKSUM_PARTIAL && skb_checksum_help(skb))
> +		return NULL;
> +
> +	tag = skb_put(skb, KSZ_INGRESS_TAG_LEN);
> +
> +	*tag = BIT(dp->index);

You're out of sync with mainline which has transitioned all
BIT(dp->index) users to dsa_xmit_port_mask(skb, dev).

To avoid this in the future please do not duplicate the ksz9893 xmit
implementation, but call a common function and use a "bool do_tstamp"
variable which is true when called from ksz9893 and false from ksz8463.

> +	*tag |= FIELD_PREP(KSZ8463_TAIL_TAG_PRIO, prio);
> +
> +	return ksz_defer_xmit(dp, skb);
> +}

