Return-Path: <netdev+bounces-272281-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ED3MDsHBxWnfBQUAu9opvQ
	(envelope-from <netdev+bounces-272281-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 00:31:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A7A33D107
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 00:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DE4830A167F
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 23:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAAC39A815;
	Thu, 26 Mar 2026 23:24:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB8438E5EE;
	Thu, 26 Mar 2026 23:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774567465; cv=none; b=U0Er4IGE62TsSsk+WT1jJ0/tqDVUyez0U4hEGkQFnnedFtFoHn5mrSacsKbaOUIbN3NBvbijcfFVHfarit5BqGPDeps2jLf/6Gfn98S9I7kbK5m+b32v8TLN9CPO9OBJurx+6YsRbtvsVHIMh4lN0JRlnfnsz/BNgdZxZm4hcvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774567465; c=relaxed/simple;
	bh=Nm5mJOrvgolhbvNLixBkfApWAt5Jml5hiekSjiSsGWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G65Qlbe4KmVK3Aw6xXbKIEHqqVkHi8JddHUJ6RovW5hKrxFX9f5plpU7vuKH1wZQRQWDW2C+9oBC+KMNruyDQYnGL+X1pAkD812JKEeony3SwuSnsPd75Me7maQsVxaFZWjqdG8RGT4RPPm24OVuTN9Qcl9QBzAYGVXVGbv5Tas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1w5u3p-000000006iF-31Pi;
	Thu, 26 Mar 2026 23:24:21 +0000
Date: Thu, 26 Mar 2026 23:24:19 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Joris Vaisvila <joey@tinyisr.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	olteanv@gmail.com, Andrew Lunn <andrew@lunn.ch>,
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH net-next 3/4] net: dsa: initial MT7628 tagging driver
Message-ID: <acXAIxG3kwuEmuOp@makrotopia.org>
References: <20260326204413.3317584-1-joey@tinyisr.com>
 <20260326204413.3317584-4-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326204413.3317584-4-joey@tinyisr.com>
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272281-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,google.com,davemloft.net,gmail.com,lunn.ch];
	RCPT_COUNT_TWELVE(0.00)[13];
	DMARC_NA(0.00)[makrotopia.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[makrotopia.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 99A7A33D107
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 10:44:12PM +0200, Joris Vaisvila wrote:
> Add support for the MT7628 embedded switch's tag.
> [...]

> +++ b/net/dsa/tag_mt7628.c
> [...]
> +
> +#define MT7628_TAG_NAME "mt7628"
> +
> +#define MT7628_TAG_TX_PORT_BIT_MASK GENMASK(5, 0)
> +#define MT7628_TAG_RX_PORT_MASK GENMASK(2, 0)

'MASK' vs. 'BIT_MASK'... Maybe just

#define MT7628_TAG_TX_PORT	GENMASK(5, 0)
#define MT7628_TAG_RX_PORT	GENMASK(2, 0)


> +#define MT7628_TAG_LEN 4
> +
> +static struct sk_buff *mt7628_tag_xmit(struct sk_buff *skb,
> +				       struct net_device *dev)
> +{
> +	struct dsa_port *dp;
> +	u16 xmit_vlan;
> +	__be16 *tag;
> +
> +	dp = dsa_user_to_port(dev);
> +	xmit_vlan = dsa_tag_8021q_standalone_vid(dp);
> +
> +	skb_push(skb, MT7628_TAG_LEN);
> +	dsa_alloc_etype_header(skb, MT7628_TAG_LEN);
> +
> +	tag = dsa_etype_header_pos_tx(skb);
> +
> +	tag[0] = htons(ETH_P_8021Q |
> +		       FIELD_PREP(MT7628_TAG_TX_PORT_BIT_MASK,
> +				  dsa_xmit_port_mask(skb, dev)));
> +	tag[1] = htons(xmit_vlan);
> +
> +	return skb;
> +}
> +
> +static struct sk_buff *mt7628_tag_rcv(struct sk_buff *skb,
> +				      struct net_device *dev)
> +{
> +	int src_port;
> +	__be16 *phdr;
> +	u16 tpid;
> +
> +	if (unlikely(!pskb_may_pull(skb, MT7628_TAG_LEN)))
> +		return NULL;
> +
> +	phdr = dsa_etype_header_pos_rx(skb);
> +	tpid = ntohs(*phdr);

Why not directly

	src_port = FIELD_GET(MT7628_TAG_RX_PORT, ntohs(*phdr));

tpid isn't used for anything else (at this point).

Or even getting rid of both stack variables:

	skb->dev = dsa_conduit_find_user(dev, 0, FIELD_GET(MT7628_TAG_RX_PORT,
							   ntohs(*phdr)));

(though the compiler probably treats both forms equally or
almost equally)

> +	skb_pull_rcsum(skb, MT7628_TAG_LEN);
> +	dsa_strip_etype_header(skb, MT7628_TAG_LEN);
> +
> +	src_port = tpid & MT7628_TAG_RX_PORT_MASK;

As you are using FIELD_PREP above for something which also could as well
just be an & operation, I would say you should then also use FIELD_GET here,
just to maintain an consistent style. And potentially move up to get rid
of the stack variables, see above.

> +
> +	skb->dev = dsa_conduit_find_user(dev, 0, src_port);
> +	if (!skb->dev)
> +		return NULL;
> +	dsa_default_offload_fwd_mark(skb);
> +	return skb;
> +}

