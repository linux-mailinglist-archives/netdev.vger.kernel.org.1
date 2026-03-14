Return-Path: <netdev+bounces-267866-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKCgIi7JtWlq5AAAu9opvQ
	(envelope-from <netdev+bounces-267866-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 21:46:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DABB528EEB7
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 21:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8018830160E7
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 20:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218B431E83C;
	Sat, 14 Mar 2026 20:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="FfiKpqtK";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="iiE5Rr1G"
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5394319006B
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 20:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773521195; cv=none; b=hFOwVGR1rEsPcgln4F/NBdQ+iMhmlHzgMj/EQoYCo71zheQX4BxCUmk9M1fIri2WYMFzCUqNnC5pJDVkiJwYOzaUT9OjiPfMYCg76vOq3lsaKE5dggTAtIWUoRdtyIOOr2b1mIkxTchcfuVh+req4blN4rYB949VwlJ8mq/IIAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773521195; c=relaxed/simple;
	bh=EteUKDXqbtu6ZVX7cWD06TGOv1tgxBbbbssuzy7gBdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHOP4w2htRAnzGSr7DcCzaRB9TPwLbKWXExDsjsT/icRqa8djTLHhv/mmkALu0p+gs/SWfezhc+zBnyXqXJ6SV94T+O0NyoGJ72pkd7tjLPZimMgG0JLFNpO3tuQz1frp2p3h5A46j1I4io9ZPzT+2zj/TuoZbnu0hmyP289GJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=FfiKpqtK; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=iiE5Rr1G; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
DKIM-Signature: a=rsa-sha256; b=FfiKpqtK1bC/nubWXueYdRDsbpW5WuT9cbqlMwgvCwqOYGYVQfaaCcC7qxHYZbcFWhTB7TF4TPogi3xi21Gkz4Pc9lcB8zBSS8GKgWMMrHBSYBU5JTwDEm/cou6lXi15shBVnxg2qKgdiYiWDWpMGs2y2TaXgNE15nFRKp3EWxSJhzouA86eAdCb8s28AoaMB5qiHb2ENZSxrglJRlDFcVr0pYIR8meHsSEIYFyvyxOgT0MbENXL4SOHccFMCuVsd1epQWxfJHYyHUheTOdvQv8pr7hMExkD8ynwwv+gZKzE0S4MJJHDOnIahBuofxEAC6ZTPtu9RNK+Y60byfHC+A==; s=purelymail2; d=tinyisr.com; v=1; bh=EteUKDXqbtu6ZVX7cWD06TGOv1tgxBbbbssuzy7gBdI=; h=Received:Date:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=iiE5Rr1GJdd5Xv5sraTunJjGOmRWCNSKKQVJBKY5WUWRItQALvjBXwx2boprF6p5o+SpacZtg+KNGcyE5NlOz8ksqyk1lhEUmj0MUvpqZcoXm68wzVs/2Zvr3gdwbUi6D0aLzqNZ7o2UCgdvh6gsDP4j8KqKx2E7e4ZwlfJ/I31CpxFL1qM7to6JZ/YXBND60xHXhPzWnUtcYtkMOOsA5xBTe7qdkMOgJteNuLi9aIXKfKLrJBE5FuddsbkWwu8PeoKzvoa2cu+syprWXnW33zpXM+55Z0NI6xw3CiBeNyU/V4Lfaga2jjCPpiM0OIVO+b727g6fZoGFShUc9NhHtw==; s=purelymail2; d=purelymail.com; v=1; bh=EteUKDXqbtu6ZVX7cWD06TGOv1tgxBbbbssuzy7gBdI=; h=Feedback-ID:Received:Date:From:To:Subject;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1070041237;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 14 Mar 2026 20:46:24 +0000 (UTC)
Date: Sat, 14 Mar 2026 22:46:17 +0200
From: Joris =?utf-8?B?VmFpxaF2aWxh?= <joey@tinyisr.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com, 
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net, olteanv@gmail.com, 
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [RFC v2 2/3] net: dsa: initial MT7628 tagging driver
Message-ID: <abW8H_2Msj8-qrA6@archlinux>
References: <20260314150845.653866-1-joey@tinyisr.com>
 <20260314150845.653866-3-joey@tinyisr.com>
 <abWh_zVCnRiVLuM0@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abWh_zVCnRiVLuM0@makrotopia.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[tinyisr.com,reject];
	R_DKIM_ALLOW(-0.20)[tinyisr.com:s=purelymail2,purelymail.com:s=purelymail2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,google.com,davemloft.net,gmail.com,lunn.ch];
	TAGGED_FROM(0.00)[bounces-267866-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[tinyisr.com:+,purelymail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joey@tinyisr.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,purelymail.com:dkim]
X-Rspamd-Queue-Id: DABB528EEB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Daniel, thanks for the feedback. 

On Sat, Mar 14, 2026 at 05:59:27PM +0000, Daniel Golle wrote:
> On Sat, Mar 14, 2026 at 05:08:44PM +0200, Joris Vaisvila wrote:
> > +	tag[0] = ETH_P_8021Q >> 8;
> > +	tag[1] = FIELD_PREP(MT7628_TAG_TX_PORT_BIT_MASK,
> > +			    dsa_xmit_port_mask(skb, dev));
> > +
> > +	tag[2] = xmit_vlan >> 8;
> > +	tag[3] = xmit_vlan & 0xff;
> 
> So there are basically two 16-bit fields which need endian swapping
> from host-byte order (little endian on MT7628) to network byte-order.
> Imho it would be better expressed by using something along the lines
> of
> 
> 	__be16 *tag;
> ...
> 	tag = dsa_etype_header_pos_tx(skb);
> 	tag[0] = htons(ETH_P_8021Q |
> 		       FIELD_PREP(MT7628_TAG_TX_PORT_BIT_MASK,
> 				  dsa_xmit_port_mask(skb, dev)));
> 	tag[1] = htons(xmit_vlan);

Will use this in later revisions, thanks for the suggestion.

> > +static struct sk_buff *mt7628_tag_rcv(struct sk_buff *skb,
> > +				      struct net_device *dev)
> > +{
> > +	int src_port;
> > +	__be16 *phdr;
> > +	u16 tpid;
> > +
> > +	if (unlikely(!pskb_may_pull(skb, MT7628_TAG_LEN)))
> > +		return NULL;
> > +
> > +	phdr = dsa_etype_header_pos_rx(skb);
> > +	tpid = ntohs(*phdr);
> > +	skb_pull_rcsum(skb, MT7628_TAG_LEN);
> > +	dsa_strip_etype_header(skb, MT7628_TAG_LEN);
> > +
> > +	src_port = tpid & MT7628_TAG_RX_PORT_MASK;
> > +
> > +	skb->dev = dsa_conduit_find_user(dev, 0, src_port);
> > +	if (!skb->dev)
> > +		return NULL;
> > +	dsa_default_offload_fwd_mark(skb);
> > +	return skb;
> 
> This looks like it is semantically identical to the RX path in tag_mtk.c.
> 
> Maybe the TX-side can be added to the existing mtk_tag.c driver, so the
> RX-side can be shared? tag_brcm.c also defines multiple similar protocols
> in the same C source file.

While the core structure is really similar, there are subtle hardware
differences in the MT7628 switch that will make the RX code diverge
from the MTK tag when VLAN offloading is implemented. To account for
that, I'd prefer to keep these drivers separate.

I plan to implement bridge and VLAN offloading after the initial switch
support lands, to keep the initial series smaller and simplify review.

