Return-Path: <netdev+bounces-289646-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAYIKjvqDGq9pwUAu9opvQ
	(envelope-from <netdev+bounces-289646-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 00:54:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CAB585DB4
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 00:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4C1F73009E1A
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 22:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A30839F18B;
	Tue, 19 May 2026 22:54:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA5526299;
	Tue, 19 May 2026 22:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779231286; cv=none; b=llbtfVBpKd645dfuC/7d+aPkePqYNGgGePYsKDbOHLqXE0j8cZAnXQ0ZSQ4UGbWJwAYYetW/5xD7u5lEy+uwLx9VXU3ZzgHd9r99gxsIuFLJbgkTCjDjmp2vVYAiEhVPqw3pouDQUAJSha3jtQh+U4PwQ7FYZip3wNliooF6+4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779231286; c=relaxed/simple;
	bh=KOxFzDohe83NRSjkzAvQB3NRvl5w20oVjscGSFqnTLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6UPD64krQiOxqXghApGcuxW0c16ysSqE3caRKHL+65obT7csQNEQhJ7JjQQ5LSLlGA28sBBaW9zWVOWAWI1hBDIhltlvbMVm+02gYP66zXhPD/ObfmdyyavETla1E5d5/dxqMIxg3a747V/ONpKbZZkU+4xFdL63ogXJqFIwws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wPTKj-0000000035k-03iR;
	Tue, 19 May 2026 22:54:41 +0000
Date: Tue, 19 May 2026 23:54:38 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 5/5] net: dsa: mxl862xx: add SerDes ethtool
 statistics
Message-ID: <agzqLhlZsSQnWjP-@makrotopia.org>
References: <cover.1779203863.git.daniel@makrotopia.org>
 <5e8391488f4dbf23133d16ceaf1b168b39304c97.1779203863.git.daniel@makrotopia.org>
 <20260519184005.cx32dtj6v6wosb3s@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519184005.cx32dtj6v6wosb3s@skbuf>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289646-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[makrotopia.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,makrotopia.org:mid]
X-Rspamd-Queue-Id: B8CAB585DB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 09:40:05PM +0300, Vladimir Oltean wrote:
> On Tue, May 19, 2026 at 06:39:29PM +0100, Daniel Golle wrote:
> > +/* --- SerDes ethtool statistics --- */
> > +
> > +static const char mxl862xx_serdes_stats[][ETH_GSTRING_LEN] = {
> > +	"serdes_tx_main",
> > +	"serdes_tx_pre",
> > +	"serdes_tx_post",
> > +	"serdes_tx_iboost",
> > +	"serdes_tx_vboost",
> > +	"serdes_tx_vboost_en",
> > +	"serdes_rx_att",
> > +	"serdes_rx_vga1",
> > +	"serdes_rx_vga2",
> > +	"serdes_rx_ctle_boost",
> > +	"serdes_rx_ctle_pole",
> > +	"serdes_rx_dfe_tap1",
> > +	"serdes_rx_dfe_bypass",
> > +	"serdes_rx_adapt_mode",
> > +	"serdes_rx_adapt_sel",
> > +	"serdes_rx_signal",
> > +	"serdes_pma_link",
> > +	"serdes_link_fault",
> > +	"serdes_in_reset",
> > +};
> 
> Which of these are statistics counters, and which of _those_ are
> Ethernet-specific (SerDes may be multiprotocol, also supporting PCIe
> etc, and the info above is all protocol-agnostic)?

The SerDes is basically a DW XPCS but exposed only via the firmware.
So it's Ethernet-only. This is a external switch IC, and while it does
have a very small CPU, that CPU only has low speed peripherals, no
USB3, PCIe, SATA what-so-ever other SerDes you may think of.

But true, the values themselves are not very Ethernet-specific, most
can probably be used to describe any generic LVDS.

> I'm trying to hint at the fact that ethtool is not the right interface
> for presenting such information. Intuitively, I would suggest we need to
> put head to head various SerDes designs and present to Vinod Koul a
> netlink UAPI for monitoring purposes.

I must admit I kinda expected a push-back on that one, which is also
why I put the patch last in the series, so the rest of the series can
be merged without the stats.

The firmware also exposes self-test via PRBS and BERT, which also
doesn't fit the ethtool self-test model very well (which currently
supports only MAC-level and PHY-level loopback tests, with no way to
represent the PCS/SerDes-level)...

