Return-Path: <netdev+bounces-264065-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePY9KpSwqGkzwgAAu9opvQ
	(envelope-from <netdev+bounces-264065-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 23:22:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E75208749
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 23:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B6DF30067BD
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 22:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B18324718;
	Wed,  4 Mar 2026 22:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crVyp8U4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4546E2836E
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 22:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772662614; cv=none; b=lhUWgs1+l9YjOsUY5M7qVJBGf1FOxiCOjbFDCmD5akSvzYDkaFZJ6IJxrZ4rJfl0kAcWX/oxn2cgam/UTf7grBc2CD/Hza96Snf5uXTC7/E9OepZwijxrfM7AOrCCc4o9jy9pmpwuUvsFcZt3q81bYJsn/e4/nOSKwsMpi8hkPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772662614; c=relaxed/simple;
	bh=tYxs3e9MxLN2xdWRgefbypp2NkEOOryuf4dt8fiFUKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1Zp1e+mjH77VthSmRREyCFjAa0BpRjAm+NF6WLaeglMWxV7DD1JcAsXwqc0xsnkvrGQLgUR06ReZ7PwRak++EEj02YlY6mMXwbqrSvwZ2PVPDc/wQB8gilLpTLpeJ46sJzNmgar5vxxvkuU1J2mI9G/AmMv3pvl1v28ys9RCwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crVyp8U4; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-483bcff7a3dso8344645e9.1
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 14:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772662612; x=1773267412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tNjslhqQ6BNqdbvY/PjKxu2wNzkM7pRaJ9pARDxL4wo=;
        b=crVyp8U4Sgbe9JDnr+qGH8yRN389fO4inWY5ocZyfOp0uUeZV8A1pMA57VZ2fk10kM
         nUSd8EfaNtjvcUYjRdl8bOl4Uc8kO6Is8Oq6oAI7b5FivPKyNFCWLBqGPq/VtMQWYQV8
         p2MW2aH71Mnuui7HdIXIVpXHhdhWcXmHr1HrwiFX/bTG1+IyuAcYkkPUOSyP1LdN9DmB
         jim6jBFYlFWLwE7fYPE2RR+B55ogvbNagEzRvhVnKPuA6MYuP+lop21ovnxST/4zWwfc
         TQzDSg+aX2frUpRwEZhCHw6cbzkPfx5ARIgryby5b+OHGCIHUtwk+dybXc6C28QS2ejR
         8pXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772662612; x=1773267412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tNjslhqQ6BNqdbvY/PjKxu2wNzkM7pRaJ9pARDxL4wo=;
        b=XerR2HfZgt8XHca4Xvs3xCoNjwOAXSXdz1UHIrAUrfvy6916KEn1O2R3a8c6CjCyDw
         xekSxmO41w8V/mtniBQ396sKIhkQQpuJPjGSKfPZgc+OFzB506IHyBLNjST6MeB42jJs
         qAWkW65u7hSsIgLgngOBf9WLfSFSAPI6K65HkcHjIQvgeT4y7h8uTYu6B6dlj91C+hDb
         a8BifAUJ7rEWxaATOU7k3yBUylT8y4YFY94xWu6IT5r4oYO55poZczWVwD+Yu8QeMWEm
         1SNsZmJEGwEa54Z5dcgdoTTDRsb+2Ho5MvdIo+Mp68u0fPhngBn/NnEMnmo3RJDF4VPY
         nUfg==
X-Gm-Message-State: AOJu0Yyzr+m5HrVBma3LAiGhwU4rn1CuHgc9IHHIZKPiGDtKpCWC0TJU
	UNcAbeczAFzvFfZZTCscR720widyUPt6MmFTJ5KC/Q4ASsH6HMuKKllQ
X-Gm-Gg: ATEYQzypf2Pkxl4PHHam9NkqknA6oh7GYP4DLwRHpCvHtxJ/2Z4vGIMaWg6vCjHwkBc
	2PkCQt5yaeFAlyZ7j02J0OySIwcFjQrRYZKLby4JbyQk2nHbu801ocfHXihShqfL64UKrFiAsd7
	xe8EzY1mxkei1AuCIMN1aMEGtkyOqcn7OImx8BLLyEVBJOYdvT6sOkbObKw54WYanBG2yQf/Tvy
	ViWzcuYTUV7ZJi+nqQN0S7wleTFulupdYAPaqOn/LO4JaoTHPtJocSSszL++vc0kkhqY9qF4e1Q
	M3ED3ELpKPzJLR3KAZsJmyhkTRVXwR/JDSBGs4rB2qRM4Uy++S8grV1NQMnqd4Y4rIC7fZpQYUz
	1aKTmtn5vZa6idUN1/5zeic6QHTYabAOgUOR+Y5nJY1pVnaeRPzDJeX29xwbpdzxFaitX+HLtwG
	WF5OBRez9bM7yaNoRrZldgTdOhYg==
X-Received: by 2002:a05:600c:6099:b0:47d:3ffa:9838 with SMTP id 5b1f17b1804b1-485198484fbmr36257275e9.1.1772662611439;
        Wed, 04 Mar 2026 14:16:51 -0800 (PST)
Received: from skbuf ([2a02:2f04:d00e:3600:16aa:c9ad:4288:9dcc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851ad09476sm26455525e9.8.2026.03.04.14.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 14:16:50 -0800 (PST)
Date: Thu, 5 Mar 2026 00:16:47 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Joris Vaisvila <joey@tinyisr.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [RFC PATCH 1/2 net-next] net: dsa: initial MT7628 special tag
 driver
Message-ID: <20260304221647.ed6tfossgptpjqm2@skbuf>
References: <20260228185242.800836-1-joey@tinyisr.com>
 <20260228185242.800836-3-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228185242.800836-3-joey@tinyisr.com>
X-Rspamd-Queue-Id: 33E75208749
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
	TAGGED_FROM(0.00)[bounces-264065-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 08:52:42PM +0200, Joris Vaisvila wrote:
> +#include <linux/etherdevice.h>
> +#include <linux/dsa/8021q.h>
> +#include <net/dsa.h>
> +
> +#include "tag.h"
> +
> +/* 

You have a trailing whitespace here.

> + * MT7628 uses the ralink special tag. It merges the VLAN TPID with source
> + * port ID on RX and target port bitmap on TX.
> + *
> + * The switch forwarding is controlled with VLANs, so each port is put in a
> + * standalone VLAN using tag_8021q. Double tag is enabled to simulate VLAN
> + * unaware ports.
> + *
> + * A VLAN tag is constructed on egress to target the standalone VLAN and port.
> + * The outer VLAN tag is parsed and removed on ingress.
> + */
> +
> +#define MT7628_TAG_NAME "tag_mt7628"

No other protocol name starts with "tag_". This is exported to user
space (cat /sys/class/net/<conduit>/dsa/tagging), it's good to have some
uniformity.

> +
> +#define SPECIAL_HEADER_RECV_SOURCE_PORT_MASK GENMASK(2, 0)
> +#define SPECIAL_TAG_LEN 4
> +
> +static struct sk_buff *dsa_user_special_xmit(struct sk_buff *skb,
> +					     struct net_device *dev)
> +{
> +	struct dsa_port *dp = dsa_user_to_port(dev);
> +	u16 xmit_vlan = dsa_tag_8021q_standalone_vid(dp);
> +	u8 *special_tag;
> +
> +	skb_push(skb, SPECIAL_TAG_LEN);
> +	dsa_alloc_etype_header(skb, SPECIAL_TAG_LEN);
> +
> +	special_tag = dsa_etype_header_pos_tx(skb);
> +
> +	special_tag[0] = ETH_P_8021Q >> 8;
> +	special_tag[1] = BIT(dp->index);

We don't do BIT(dp->index) anymore. It's wrapped around a
dsa_xmit_port_mask() helper, which also gives you some HSR TX offloading
if you set the offload pointers to dsa_port_simple_hsr_join() and
dsa_port_simple_hsr_leave().

> +
> +	special_tag[2] = xmit_vlan >> 8;
> +	special_tag[3] = xmit_vlan & 0xff;
> +	return skb;
> +}

