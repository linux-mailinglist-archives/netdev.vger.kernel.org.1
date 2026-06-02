Return-Path: <netdev+bounces-294463-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1vw/JVhnH2rIlgAAu9opvQ
	(envelope-from <netdev+bounces-294463-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 01:29:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE52632E90
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 01:29:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294463-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294463-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9CF2E3025AF2
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 23:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918933B894B;
	Tue,  2 Jun 2026 23:29:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1491D3546F7;
	Tue,  2 Jun 2026 23:29:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780442964; cv=none; b=ndh+z30AnjklRhJxMzCEaJFei+FlDp9jfvqykGOs2vYTdSjhyDrCKniydM3wnTP6l+KDHiKdXSSH6VqWywVtcsTTvoMf49E0pITzzxFvLyoyXuLqG8ryLRCPgtSivT+iFehz25+5m+g4vrXgXJfHL++uVJALWkRQJRwPppwF0Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780442964; c=relaxed/simple;
	bh=8lrdi2XPHjenZdt5fi7PLDLnsvNp+MvAb8OfdiNTTXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyS3H7KPTnHr94hQVmvJGOO9KKPTfJtMvAYTlQktd7DxXFkQyw682dIIqRnQi2cwRwz4O7fvGhcTBRVfrom7M4vgs6DN5XzuC9MUkvHvOn5AFXPbsD+mXPK+PZCXxz0XeebEBlAn42Ri++qFvSjBxnLiLhP/7e5Fvgb6iErM9EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wUYHB-000000007TN-2GrH;
	Tue, 02 Jun 2026 23:12:01 +0000
Date: Wed, 3 Jun 2026 00:11:58 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: John Crispin <john@phrozen.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 4/4] net: dsa: mxl862xx: add support for
 SerDes ports
Message-ID: <ah9jPhiHSSqYjScK@makrotopia.org>
References: <cover.1780032869.git.daniel@makrotopia.org>
 <2b57a3d73519a4be8f45252707c335ecd251b2c1.1780032869.git.daniel@makrotopia.org>
 <20260602142209.740b18d7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602142209.740b18d7@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294463-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[makrotopia.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[phrozen.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:john@phrozen.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2DE52632E90

On Tue, Jun 02, 2026 at 02:22:09PM -0700, Jakub Kicinski wrote:
> On Fri, 29 May 2026 06:40:17 +0100 Daniel Golle wrote:
> > +struct mxl862xx_xpcs_pcs_cfg {
> > +#ifdef __LITTLE_ENDIAN_BITFIELD
> > +	u8 port_id:2;
> > +	u8 interface:6; /* enum mxl862xx_xpcs_if_mode */
> > +	u8 neg_mode:2; /* enum mxl862xx_xpcs_neg_mode */
> > +	u8 permit_pause:1;
> > +	u8 usx_lane_mode:2; /* enum mxl862xx_xpcs_usx_lane_mode */
> > +	u8 role:1; /* enum mxl862xx_xpcs_role */
> > +	u8 usx_subport:2;
> > +#elif defined(__BIG_ENDIAN_BITFIELD)
> > +	u8 interface:6; /* enum mxl862xx_xpcs_if_mode */
> > +	u8 port_id:2;
> > +	u8 usx_subport:2;
> > +	u8 role:1; /* enum mxl862xx_xpcs_role */
> > +	u8 usx_lane_mode:2; /* enum mxl862xx_xpcs_usx_lane_mode */
> > +	u8 permit_pause:1;
> > +	u8 neg_mode:2; /* enum mxl862xx_xpcs_neg_mode */
> > +#else
> > +#error "Unknown bitfield endianness"
> > +#endif
> 
> With the bitfields and MACROS for read/write this patch give off vendor
> BSP more than upstream code :( Doesn't look like the driver used
> bitfileds before, please use FIELD_GET / FIELD_PUT

It wasn't necessary before because the older and more mature parts of
the API have a different hand-writing and used only (sometimes quite
arbitrary) 8-bit, 16-bit and 32-bit types. Now this more recently
designed part of the API breaks that rule.
Anyway, a single __le16 it is then in this case, and I'll use
FIELD_PUT/FIELD_GET.


