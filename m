Return-Path: <netdev+bounces-297706-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MA1rB6l0KWp9XAMAu9opvQ
	(envelope-from <netdev+bounces-297706-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 16:28:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8513B66A377
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 16:28:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kOFTdRZT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297706-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297706-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5AC4D306EA7D
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 14:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C79312826;
	Wed, 10 Jun 2026 14:18:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FC22BEC45;
	Wed, 10 Jun 2026 14:18:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781101131; cv=none; b=bZH63PxwJXUZRQ407C94a7oIoHZV6I84YdvqcgQ9l3/sw20JFhxjjy9q8MF0DqjE81fP5kAonnNrN57R/yuE7rHh8jltbZS3zEWI3G+fNzCGy/jQ2zcqIWdBWOuXFH8bJfBoXu6WpL4VgT7P1UK4Rmt4VWykUpmn+wDHY/QLmA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781101131; c=relaxed/simple;
	bh=eFnI1rLVk7sB19k/pzrbSYOODsPdB60EK3vw3F3qfWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8s00BgK6bF/Su2pwBGgY+GXDr8Jvh1ULzOzjoBl2kBjyGUFOpTYMgCQuu9UDs74H6ZP2zbTvSNY25QFnzR21UF2HNbPEK5NlFe5EinXKteO0HmQ0g96k1wyoR7FgswdusKtw0v+KRG3qnO9hyLLmawyFuH/gwrW/ASdWjPkcjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOFTdRZT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48761F00893;
	Wed, 10 Jun 2026 14:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781101129;
	bh=y6dsBwISQo9JAF0X/t5G8osG2FHPMSvyOnQMJE/iGQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kOFTdRZTj+uYrwPYgPJmBZeh1/kLb9Cfjkb09ONQ2A7Gfs6/2TgqBHV1Za/9niEu4
	 FCT61sxGBU124zF/+0AHk9yIAJ9kRVtcjQKE3VG/wCGr4zGx8+Dtmb9LSyoiUfZckc
	 IBNN/urCuaDBUdZ9xwfaM6IzioVa8TVn0k7WEyDyrZg/NI9pSwIUawTRhBsnWPK2Kj
	 RjCGmEitr0qYGLAuqhapY8GOSEu04Ef7ZQywf2MYbuAv/SjjWshw0k4phj8x+Y30Rn
	 EmYN0qJn0etW2vddFQNOa0zLZhR0+XdOzk+B5SreJ1enRW/orJq0cGHZeNySTUxj6V
	 NuTTBjhvMYNyw==
Date: Wed, 10 Jun 2026 17:18:43 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jihong Min <hurryman2212@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 0/4] bonding: support LAG IPsec offload with
 replicated SAs
Message-ID: <20260610141843.GI327369@unreal>
References: <20260520081004.2232091-1-hurryman2212@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260520081004.2232091-1-hurryman2212@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:hurryman2212@gmail.com,m:netdev@vger.kernel.org,m:jv@jvosburgh.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[leon@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297706-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8513B66A377

On Wed, May 20, 2026 at 05:10:00PM +0900, Jihong Min wrote:
> This RFC adds a bonding model for IPsec/XFRM hardware offload on
> 802.3ad and balance-xor LAG devices when the transmit hash policy is
> layer3+4. This is an intentional scope limit rather than a hard limit,
> as this is the configuration I can test with my gear.
> 
> The main idea is to leave the existing upstream single-lower-device XFRM
> offload path for active-backup intentionally untouched, while adding a
> replicated state model for LAG.
> 
> For LAG bonds, the bonding driver installs the same XFRM state on every
> eligible running slave and stores the per-slave hardware handles in
> bonding-private state. Lower drivers that support this model can then
> resolve the handle for the concrete lower netdev used by the datapath.
> 
> LAG IPsec features are user controlled. Newly eligible LAG bonds start
> with the ESP/XFRM features disabled, but advertise supported mutable
> features when all running eligible slaves can support them. Users can
> then opt in with ethtool. Feature enable is propagated to the lower
> devices and rolled back if a lower device cannot enable the requested
> features.
> 
> The series also handles LAG membership and eligibility changes by adding
> replicated SAs to newly usable slaves, removing the departing lower
> instance on down/remove, and flushing bond-owned XFRM offload state when
> the bond leaves the supported mode or hash-policy configuration.
> 
> This series does not convert any physical NIC driver. A lower driver
> must explicitly opt in to the replicated-upper-device model before it can
> use these bond-owned states in its datapath.
> 
> For example, a driver such as mlx5 would opt in by marking its
> xfrmdev_ops and by resolving datapath handles through the helper:
> 
>         static const struct xfrmdev_ops mlx5e_ipsec_xfrmdev_ops = {
>                 ...
>                 .xdo_dev_state_lower_handle = NULL,
>                 .flags = XFRMDEV_OPS_F_LOWER_HANDLE,
>         };
> 
>         handle = xfrm_dev_state_lower_handle(x, netdev);
>         if (!handle)
>                 goto drop;
> 
>         sa_entry = (struct mlx5e_ipsec_sa_entry *)handle;

I’m curious how you replicate and maintain the hardware state across these
devices. How are you handling the anti-replay window?

Thanks

> 
> Jihong Min (4):
>   xfrm: add a lower-device offload handle resolver
>   bonding: replicate XFRM offload state across LAG slaves
>   bonding: expose user-controlled IPsec features for LAG
>   bonding: handle replicated IPsec SAs across LAG changes
> 
>  drivers/net/bonding/bond_main.c    | 855 ++++++++++++++++++++++++++++-
>  drivers/net/bonding/bond_options.c |  59 +-
>  include/linux/netdevice.h          |  27 +
>  include/net/bonding.h              |  29 +-
>  include/net/xfrm.h                 |  48 +-
>  net/xfrm/xfrm_state.c              |   1 +
>  6 files changed, 1000 insertions(+), 19 deletions(-)
> 
> 
> base-commit: 27fa82620cbaa89a7fc11ac3057701d598813e87
> -- 
> 2.53.0
> 

