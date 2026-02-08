Return-Path: <netdev+bounces-257873-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFNhLbcciWnB2gQAu9opvQ
	(envelope-from <netdev+bounces-257873-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 00:31:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC2110A990
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 00:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 11D4E30015BD
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 23:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2764B346A05;
	Sun,  8 Feb 2026 23:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="a/R3LPSp"
X-Original-To: netdev@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D5D33D4F0
	for <netdev@vger.kernel.org>; Sun,  8 Feb 2026 23:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770593457; cv=none; b=BorBcwmta6kFoyIBIYGkf/YRSl/JKSdESuT2+zewcrt+BGs7OQhTRkWuUGijmfPOLdpSmGDNr5wjsf+sDVPUtyjlv7vubCuL0bQjvMrwYmB2yg21S2PKqvu7rSrLuhHTmbX2lwIWEodN6yO7qFPmO7Yhm9gC7QR+IkF2B72Bzz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770593457; c=relaxed/simple;
	bh=BqBwXlW1DYlKifkNzuD8EgN86/kfJHvciyDW4WXpDPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWznp4jtlS7nye931k1CXRXSqZPu1r/VwYXufcMQkugsFotTFNwcXzcG4DS55plMmYIIS5EtJTOGKud8MxTWBcafoTMfbCXeD6XnlEd5D2YKlVnByWdxAWtwzZ3PDpuDzB8ZibQhHIvUYEPqZKuN4x3o8tK0bAYq6XYt1l7h0Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=a/R3LPSp; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from killaraus.ideasonboard.com (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 4B5B582A;
	Mon,  9 Feb 2026 00:30:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1770593410;
	bh=BqBwXlW1DYlKifkNzuD8EgN86/kfJHvciyDW4WXpDPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a/R3LPSpkb93wFdSWlOX+/jeCfLOWluI9DhYaiJ+yJSYViQVHcpq2vU/8sQbNM8KW
	 OzgvhCQDj4C29gAhRIz/QUtDJkAZwZ1B0An2C4xXoRtexqrXdGpW4BkrBAeKi/GBLD
	 X7uukJHcWOKAMAPGF88XW8kAiir3KJ3mnbQTR9/M=
Date: Mon, 9 Feb 2026 01:30:54 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Ovidiu Panait <ovidiu.panait.oss@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	"David S. Miller" <davem@davemloft.net>,
	Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, imx@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Stefan Klug <stefan.klug@ideasonboard.com>,
	Wei Fang <wei.fang@nxp.com>
Subject: Re: [PATCH RFC net-next] net: stmmac: provide flag to disable EEE
Message-ID: <20260208233054.GA1987960@killaraus.ideasonboard.com>
References: <E1vNUjC-0000000FhjR-0h6P@rmk-PC.armlinux.org.uk>
 <f95f73b9-d024-4697-bca1-02fb8bc044af@gmail.com>
 <aYEj8VM5AfvcDHrl@shell.armlinux.org.uk>
 <aYE-gvuZdv7ezm7X@shell.armlinux.org.uk>
 <20260203231832.GB133801@killaraus>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260203231832.GB133801@killaraus>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ideasonboard.com,none];
	R_DKIM_ALLOW(-0.20)[ideasonboard.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257873-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,foss.st.com,lunn.ch,nxp.com,ideasonboard.com,davemloft.net,google.com,lists.linux.dev,kernel.org,lists.infradead.org,st-md-mailman.stormreply.com,vger.kernel.org,pengutronix.de,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[laurent.pinchart@ideasonboard.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[ideasonboard.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ideasonboard.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7FC2110A990
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 01:18:33AM +0200, Laurent Pinchart wrote:
> On Tue, Feb 03, 2026 at 12:17:06AM +0000, Russell King (Oracle) wrote:
> > On Mon, Feb 02, 2026 at 10:23:45PM +0000, Russell King (Oracle) wrote:
> > > On Mon, Feb 02, 2026 at 08:54:52PM +0200, Ovidiu Panait wrote:
> > > > If not, maybe this patch could be merged to add the flag that disables
> > > > EEE and I will just send a patch to disable EEE on our platforms as well.
> > > 
> > > We still need the flag to disable EEE for platforms where lpi_intr_o is
> > > logically OR'd with the other interrupts, so there's no way to ignore
> > > its persistent assertion.
> > 
> > I'll also state that we need both patches, but there's no point pushing
> > my original patch (to allow EEE to be disabled) unless Laurent is going
> > to also submit a patch to make use of the flag - the EEE disable and
> > Laurent's patch needs to be part of a series. We don't merge stuff that
> > adds facilities that have no users, because that's been proven time and
> > time again to be a recipe for accumulating cruft.
> 
> Sorry for having dropped the ball on this. Your patch arrived just when
> I travelled to Japan for a month, and then it got burried in my inbox.
> Now that it has resurfaced, and that an issue that prevented i.MX8MP
> from booting with v6.19-rc has been fixed, I'll rebase my kernel and
> finally fix that problem.

Done. https://lore.kernel.org/r/20260208232931.2272237-1-laurent.pinchart@ideasonboard.com

> Once again, thank you for all your help with this issue, you have been
> extremely helpful and I'm very grateful.
> 
> > So, at the moment, "net: stmmac: provide flag to disable EEE" ain't
> > going anywhere until there's a patch that makes use of the new flag.

-- 
Regards,

Laurent Pinchart

