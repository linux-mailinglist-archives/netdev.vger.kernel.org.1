Return-Path: <netdev+bounces-294418-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SYwUGvBJH2qWjgAAu9opvQ
	(envelope-from <netdev+bounces-294418-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 23:24:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F67363210B
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 23:23:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="lKsc25/R";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294418-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294418-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53A28302BBB4
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 21:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C509A339861;
	Tue,  2 Jun 2026 21:22:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30F12236E0;
	Tue,  2 Jun 2026 21:22:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780435331; cv=none; b=RIgs9fLjSOWHiQ+Tk8uyOl3RRWdKqhrxKKHsv2fbulCadq4uGL0IlBIkxe6DifW6s78VXyAxNP11M6eMRog85mkdtHVl8Q2PkmgnGYguJ8653tt/0LVMCDZcOczvZJRFLXyXFVsG6oghz5w7NyGTBOiG5QiLbDFLkdk8xWYU3+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780435331; c=relaxed/simple;
	bh=BEuA5TVsQRkieEOHm2NGDgAgddKRdBaSVcvVa2+zFOA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UZfOarAfpg18G5E5KiswJTPs97g1s+T2gS6krF7xFFPdYAJSqUb1GO4SGb0+NQxrz8EcYs2RnVoeJv0oe7Pf5FqRLOvf90YlKtbPc/zOqtgu1gRM/RZRwEhSYvG7T2g0wpBp0hlNegHtGOD0qnu4noR6n4EADYi+FVtRJm1GowU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKsc25/R; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B971F00893;
	Tue,  2 Jun 2026 21:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780435330;
	bh=aCZsfO7nwHl/odD49ROvTk9nwYY0CHodLfuX/n44+sI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lKsc25/RH0gT0qu1WB2Lc+H53FxQ9/r4budShnhYW/beL4AfPrwqelOGRhPYYfNzH
	 HA2ITRbanp+fTzEB3B46IgY9wZjOyM6sAg6iSbwYlQra1zR/uX73yDFp1NsFS27P9x
	 2u8wkTDfKvgkgXpZYJYoldIO+5XM0tIoYch15Xplddw8HQviTvbS1lyb5iVbGeTRdm
	 SJ0uEAyvLKUx+VXd6BKGKtIBqjn7wp0ktB05Epo7ZQXFt7B8YPSbrsIDlHyfyPhfIE
	 //hhScOHwpNWs+wbTWCHlxb4F6LjUVPR90YgatSGGLwQLY64fDVxZaB3wXCXOG64ED
	 BAg5y/Zd+hiHw==
Date: Tue, 2 Jun 2026 14:22:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: John Crispin <john@phrozen.org>, Andrew Lunn <andrew@lunn.ch>, Vladimir
 Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell
 King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 4/4] net: dsa: mxl862xx: add support for
 SerDes ports
Message-ID: <20260602142209.740b18d7@kernel.org>
In-Reply-To: <2b57a3d73519a4be8f45252707c335ecd251b2c1.1780032869.git.daniel@makrotopia.org>
References: <cover.1780032869.git.daniel@makrotopia.org>
	<2b57a3d73519a4be8f45252707c335ecd251b2c1.1780032869.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[phrozen.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294418-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:daniel@makrotopia.org,m:john@phrozen.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F67363210B

On Fri, 29 May 2026 06:40:17 +0100 Daniel Golle wrote:
> +struct mxl862xx_xpcs_pcs_cfg {
> +#ifdef __LITTLE_ENDIAN_BITFIELD
> +	u8 port_id:2;
> +	u8 interface:6; /* enum mxl862xx_xpcs_if_mode */
> +	u8 neg_mode:2; /* enum mxl862xx_xpcs_neg_mode */
> +	u8 permit_pause:1;
> +	u8 usx_lane_mode:2; /* enum mxl862xx_xpcs_usx_lane_mode */
> +	u8 role:1; /* enum mxl862xx_xpcs_role */
> +	u8 usx_subport:2;
> +#elif defined(__BIG_ENDIAN_BITFIELD)
> +	u8 interface:6; /* enum mxl862xx_xpcs_if_mode */
> +	u8 port_id:2;
> +	u8 usx_subport:2;
> +	u8 role:1; /* enum mxl862xx_xpcs_role */
> +	u8 usx_lane_mode:2; /* enum mxl862xx_xpcs_usx_lane_mode */
> +	u8 permit_pause:1;
> +	u8 neg_mode:2; /* enum mxl862xx_xpcs_neg_mode */
> +#else
> +#error "Unknown bitfield endianness"
> +#endif

With the bitfields and MACROS for read/write this patch give off vendor
BSP more than upstream code :( Doesn't look like the driver used
bitfileds before, please use FIELD_GET / FIELD_PUT

