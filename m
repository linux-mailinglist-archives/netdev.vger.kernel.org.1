Return-Path: <netdev+bounces-257942-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFqTHAPgiWnGCwAAu9opvQ
	(envelope-from <netdev+bounces-257942-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 14:24:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD35210F9F9
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 14:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B26B330036FB
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 13:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D498C3783D6;
	Mon,  9 Feb 2026 13:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ogqu1sL8"
X-Original-To: netdev@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610C32040B6
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 13:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770643302; cv=none; b=ki1tgGEbAFYmAkIP1R1kxw/urTQ31lpkHFcY3i5dDT2SdjYPsxMzEPKY7Txyre3nonWDA/FspaGAzBsNcWI0vv85UOsJ/HXbSjV/vKUa0jIM4e2T9tTfl5VDukyShrDargz4HFkbDX6IkpgGsV2Qee44KhXaQDgtpM+nN4Rb1/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770643302; c=relaxed/simple;
	bh=7ovSodLbOpn2W27nDVgvF+GU2exE6mG03PG81HU6Tok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQNzf8v0rED2pGiYa59lrLpa2KWKmbG+kCw66bmJnD4o5bydaZi1u2Tv26KPFswMUYRLQ+Gspk6ObK/cEVU1NX9QpYrjAgbDRANCPRtGiGyZZdmuF0jlEqBkFWERbCsoTJaGRNpwn18knGEXrkuB6KpozVjkrJLzW7W2VeGNq0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ogqu1sL8; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from killaraus.ideasonboard.com (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id F0DDB454;
	Mon,  9 Feb 2026 14:20:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1770643254;
	bh=7ovSodLbOpn2W27nDVgvF+GU2exE6mG03PG81HU6Tok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ogqu1sL8zkEDDFjyCVDcTsVWUQk2mNJ+aATnmwhyu5XSrwbGmYqwzi/Byk7b6g/qY
	 WbnYgly/qwg8VKu7YgS3AQwulcYhNlyIRgxNR85c44I3bjWOW+aVxEjlgqqxX35z4d
	 +sx/rXQCCwIGjM0wFrZBHnGyM7YNDlE1t4tTV3G0=
Date: Mon, 9 Feb 2026 15:21:38 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, imx@lists.linux.dev,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@denx.de>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Frank Li <Frank.Li@nxp.com>, Heiko Schocher <hs@denx.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Joakim Zhang <qiangqing.zhang@nxp.com>, Joy Zou <joy.zou@nxp.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Marcel Ziswiler <marcel.ziswiler@toradex.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Martyn Welch <martyn.welch@collabora.com>,
	Mathieu Othacehe <othacehe@gnu.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Richard Hu <richard.hu@technexion.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Stefan Klug <stefan.klug@ideasonboard.com>,
	Stefano Radaelli <stefano.radaelli21@gmail.com>,
	Wei Fang <wei.fang@nxp.com>,
	Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] net: stmmac: imx: Disable EEE
Message-ID: <20260209132138.GF2302514@killaraus.ideasonboard.com>
References: <20260208232931.2272237-1-laurent.pinchart@ideasonboard.com>
 <aYndOVkz7AOQK7qr@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aYndOVkz7AOQK7qr@shell.armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ideasonboard.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ideasonboard.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257942-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,lunn.ch,nxp.com,davemloft.net,google.com,denx.de,gmail.com,toradex.com,kernel.org,ideasonboard.com,pengutronix.de,collabora.com,gnu.org,redhat.com,technexion.com,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[laurent.pinchart@ideasonboard.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[ideasonboard.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ideasonboard.com:email,ideasonboard.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CD35210F9F9
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 01:12:25PM +0000, Russell King (Oracle) wrote:
> On Mon, Feb 09, 2026 at 01:29:31AM +0200, Laurent Pinchart wrote:
> ...
> > Fix the issue by disabling EEE completely on i.MX8MP.
> > 
> > [1] https://lore.kernel.org/all/20251026122905.29028-1-laurent.pinchart@ideasonboard.com/
> > [2] https://lore.kernel.org/all/20251123053518.8478-1-laurent.pinchart@ideasonboard.com/
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> > This patch depends on https://lore.kernel.org/r/20251026122905.29028-1-laurent.pinchart@ideasonboard.com
> 
> Are you sure? That's the one adding the DT property, not my patch that
> adds the flag you need for this.

Oops, wrong link. I meant

https://lore.kernel.org/all/E1vNUjC-0000000FhjR-0h6P@rmk-PC.armlinux.org.uk/

> > @@ -355,7 +354,8 @@ static struct imx_dwmac_ops imx8mp_dwmac_data = {
> >  	.addr_width = 34,
> >  	.mac_rgmii_txclk_auto_adj = false,
> >  	.set_intf_mode = imx8mp_set_intf_mode,
> > -	.flags = STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY,
> > +	.flags = STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY
> > +	       | STMMAC_FLAG_EEE_DISABLE,
> 
> I thought we had a coding style comment about wrapping like this
> (operators should be trailing on the previous line, not at the
> beginning of the following line) but I can find nothing in
> Documentation/process/coding-style.rst  Confused. Maybe it's
> somewhere else in the re-organised documentation.

I'll move it at the end of the line, no problem. It's one of those
pieces of coding style where different driver authors and subsystems
have different opinion so I'm never quite sure what to do when
submitting patches for areas of the kernel I don't usually touch. I
should have looked at the rest of the file, sorry about missing it.

-- 
Regards,

Laurent Pinchart

