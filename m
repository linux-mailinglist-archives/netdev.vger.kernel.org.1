Return-Path: <netdev+bounces-256839-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCnAB6LHg2k/uQMAu9opvQ
	(envelope-from <netdev+bounces-256839-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:26:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A53CECFB5
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32C24300EFA2
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 22:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBE8318ED3;
	Wed,  4 Feb 2026 22:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jOu0LD/B"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357E627F163
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 22:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770243999; cv=none; b=pAESHf5NWNj8jpXScrHlm0VeKDjgHAVYPheLrLSZr/d4WdWJiWPFrM93Sp6EhNVEb9dC8ntK9CLf3pX1/Ki8fcGML6msZ7QFdo5UEOM2m8V+4hPTZd6FcGIGv3ZwmEsdAj9QD5yiE24LV0wAg+P9dLXz+KtiEkQrqI9gr5tgg4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770243999; c=relaxed/simple;
	bh=3YsRs7pmH0OKV5SVBmZ3QMvXXaZdZ5j8pzZikqy0B8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkVEaOp/MulE0ObEhXScn4zgEMmiaE5a5U+8Jo7txhIBwirf1o1XKBqtRhT1FvOuMGf/uP8GTkeDjs09jzC2RmGsuEAvrwRRcmc2WAwxPTMtmqwP4u+Y13NHGiTnG6+NuyoJMX2fGdKs1F9AXg+E3zdFu2hhS7Si+4Y4OGYmhuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jOu0LD/B; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YBb76XbTs10K5UGRcrXyjymL5gOXGKQMYpuyBZHPFXk=; b=jOu0LD/BkldhAJq+u9wKjguWef
	ZFm0IBCkNyDdOBVt1B85H0vb/6JVrJokFjjKGrVtPS/tf0atzMvL338oM4gQxhlDjOYN4k5YSa9it
	qxkGwKlGFdcYmCQob7xbVtFvLgf+peJ7cXRsXHKfNckjQJ4PJcyCFhfeiHsaM9HXVPdWMXwLEoldk
	E7wl/EHPCIf274H7XC+Iz6Po0crHg96G/2YPm0m8wIsEfidXx2p/ewWAFyEKxZmbmzySZ/fizE2eC
	/7jxc8HtUx2VLYG0C/wBm8mJKrGoNVUl1mcZDBVYXwGFtNrrmdqzGAkR2pFUxEJEpaUVoee6VHk2J
	ZlsAPnUA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56420)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vnlKN-000000006kE-07W2;
	Wed, 04 Feb 2026 22:26:27 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vnlKI-000000005kv-0AB7;
	Wed, 04 Feb 2026 22:26:22 +0000
Date: Wed, 4 Feb 2026 22:26:21 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 5/6] net: stmmac: rk: use rk_encode_wm16() for
 clock selection
Message-ID: <aYPHjS0wrtXlRb1a@shell.armlinux.org.uk>
References: <aYMN2gZMfLPKuukG@shell.armlinux.org.uk>
 <E1vnYy6-00000007hp9-1AJM@rmk-PC.armlinux.org.uk>
 <20297648.sWSEgdgrri@diego>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20297648.sWSEgdgrri@diego>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256839-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sntech.de:email,armlinux.org.uk:url,armlinux.org.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7A53CECFB5
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 11:03:51PM +0100, Heiko Stübner wrote:
> Am Mittwoch, 4. Februar 2026, 10:14:38 Mitteleuropäische Normalzeit schrieb Russell King (Oracle):
> > Use rk_encode_wm16() for RMII clock gating control, and also for the
> > io_clksel bit used to select the transmit clock between CRU-derived
> > and IO-derived clock sources.
> > 
> > Both of these were configured via the "set_clock_selection" method in
> > the SoC specific operations, but there is no requirement to change the
> > io_clksel except when enabling clocks.
> > 
> > It is also possible that we don't need to ungate the RMII clock if we
> > are operating in RGMII mode, but this commit makes no change there.
> > 
> > Split up the configuration of these as separate functions, and remove
> > the set_clock_selection() method. Since these clocking bits are in the
> > same register that we call the "speed" register, move the logic for
> > writing that register into rk_write_speed_grf_reg().
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> >  .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 174 ++++++++----------
> >  1 file changed, 75 insertions(+), 99 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > index 4099cbc5d0de..ed9adac70f0a 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > @@ -27,8 +27,17 @@
> >  struct rk_priv_data;
> >  
> >  struct rk_clock_fields {
> > +	/* io_clksel_cru_mask - io_clksel bit in clock GRF register which,
> > +	 * when set, selects the tx clock from CRU.
> > +	 */
> > +	u16 io_clksel_cru_mask;
> > +	/* io_clksel_io_mask - io_clksel bit in clock GRF register which,
> > +	 * when set, selects the tx clock from IO.
> > +	 */
> 
> nit: comment stile does not seem to follow the kernel coding style
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst#n622

netdev has historically had this style which is separate from the rest
of the kernel. The file already uses this comment style, so it is
entirely correct to keep to the style which already exists in this
file, rather than mixing styles and turning it into a mess.

> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Heiko Stuebner <heiko@sntech.de> #px30,rk3328,rk3568,rk3588

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

