Return-Path: <netdev+bounces-267815-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFvBGBOitWk02wAAu9opvQ
	(envelope-from <netdev+bounces-267815-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:59:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 872BD28E58D
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D4EAA3006B44
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED10324718;
	Sat, 14 Mar 2026 17:59:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4362E3043DE
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 17:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773511184; cv=none; b=PDeDr8Zv2WfsdDGLk96RGNKPJZnbtQP+U0xQD+Ztwa/nZXchO4n3GrC7m4vMHuaNeJ4Nncsq8e46dNRtk3uc8vko2Yf0HXcbksKv0KJry4yMrtGmwjmAudm7gA51Awz1/kPN7zeEtfoU48m+faNHrrNHdJ6iRfixyp5bzPySd7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773511184; c=relaxed/simple;
	bh=CZDJzmMzDw8LYQAfaxHUeVb/Yma7Z9s7v12CBDnXetg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1gkQhd8+V3xwQNZ/4Xofr0lC5oCMosn7zUQZI730Y1IvTBMmYFqJ8GR4emGYxN77zxDCnOSGVIQPTCXm4L4YULdlqMaZeysDjQq4sgYHZP9DyP+4uvu1v2eXYUCqEnZI0b/T9BalQk6MYYOZgVhPWcaZJSh8tTwO40uxVyIA5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1w1TGt-0000000035O-1ESO;
	Sat, 14 Mar 2026 17:59:31 +0000
Date: Sat, 14 Mar 2026 17:59:27 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Joris Vaisvila <joey@tinyisr.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	olteanv@gmail.com, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [RFC v2 2/3] net: dsa: initial MT7628 tagging driver
Message-ID: <abWh_zVCnRiVLuM0@makrotopia.org>
References: <20260314150845.653866-1-joey@tinyisr.com>
 <20260314150845.653866-3-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314150845.653866-3-joey@tinyisr.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,google.com,davemloft.net,gmail.com,lunn.ch];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267815-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[makrotopia.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,makrotopia.org:mid,tinyisr.com:email]
X-Rspamd-Queue-Id: 872BD28E58D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 05:08:44PM +0200, Joris Vaisvila wrote:
> Add support for the MT7628 embedded switch's tag.
> 
> The MT7628 tag is merged with the VLAN TPID field when a VLAN is
> appended by the switch hardware. It is not installed if the VLAN tag is
> already there on ingress. Due to this hardware quirk the tag cannot be
> trusted for port 0 if we don't know that the VLAN was added by the
> hardware. As a workaround for this the switch is configured to always
> append the port PVID tag even if the incoming packet is already tagged.
> The tagging driver can then trust that the tag is always accurate and
> the whole VLAN tag can be removed on ingress as it's only metadata for
> the tagger.
> 
> On egress the MT7628 tag allows precise TX, but the correct VLAN tag
> from tag_8021q is still appended or the switch will not forward the
> packet.
> 
> Signed-off-by: Joris Vaisvila <joey@tinyisr.com>
> ---
>  include/net/dsa.h    |  2 +
>  net/dsa/Kconfig      |  6 +++
>  net/dsa/Makefile     |  1 +
>  net/dsa/tag_mt7628.c | 93 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 102 insertions(+)
>  create mode 100644 net/dsa/tag_mt7628.c
> 
> [...]
> +#define MT7628_TAG_TX_PORT_BIT_MASK GENMASK(5, 0)
> +#define MT7628_TAG_RX_PORT_MASK GENMASK(2, 0)
> +#define MT7628_TAG_LEN 4
> +
> +static struct sk_buff *mt7628_tag_xmit(struct sk_buff *skb,
> +				       struct net_device *dev)
> +{
> +	struct dsa_port *dp;
> +	u16 xmit_vlan;
> +	u8 *tag;
> +
> +	dp = dsa_user_to_port(dev);
> +	xmit_vlan = dsa_tag_8021q_standalone_vid(dp);
> +
> +	skb_push(skb, MT7628_TAG_LEN);
> +	dsa_alloc_etype_header(skb, MT7628_TAG_LEN);
> +
> +	tag = dsa_etype_header_pos_tx(skb);
> +
> +	tag[0] = ETH_P_8021Q >> 8;
> +	tag[1] = FIELD_PREP(MT7628_TAG_TX_PORT_BIT_MASK,
> +			    dsa_xmit_port_mask(skb, dev));
> +
> +	tag[2] = xmit_vlan >> 8;
> +	tag[3] = xmit_vlan & 0xff;

So there are basically two 16-bit fields which need endian swapping
from host-byte order (little endian on MT7628) to network byte-order.
Imho it would be better expressed by using something along the lines
of

	__be16 *tag;
...
	tag = dsa_etype_header_pos_tx(skb);
	tag[0] = htons(ETH_P_8021Q |
		       FIELD_PREP(MT7628_TAG_TX_PORT_BIT_MASK,
				  dsa_xmit_port_mask(skb, dev)));
	tag[1] = htons(xmit_vlan);


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
> +	skb_pull_rcsum(skb, MT7628_TAG_LEN);
> +	dsa_strip_etype_header(skb, MT7628_TAG_LEN);
> +
> +	src_port = tpid & MT7628_TAG_RX_PORT_MASK;
> +
> +	skb->dev = dsa_conduit_find_user(dev, 0, src_port);
> +	if (!skb->dev)
> +		return NULL;
> +	dsa_default_offload_fwd_mark(skb);
> +	return skb;

This looks like it is semantically identical to the RX path in tag_mtk.c.

Maybe the TX-side can be added to the existing mtk_tag.c driver, so the
RX-side can be shared? tag_brcm.c also defines multiple similar protocols
in the same C source file.

