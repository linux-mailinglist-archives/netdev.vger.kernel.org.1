Return-Path: <netdev+bounces-85536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D136C89B2B2
	for <lists+netdev@lfdr.de>; Sun,  7 Apr 2024 17:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CF0A1C2093E
	for <lists+netdev@lfdr.de>; Sun,  7 Apr 2024 15:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8C138DD3;
	Sun,  7 Apr 2024 15:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MUxzNh6U"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2FE39AE7
	for <netdev@vger.kernel.org>; Sun,  7 Apr 2024 15:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712503681; cv=none; b=eEltmOMT1jwkRCbCL7XEHtBCDqcEKOKafv8betMSNr5kZ1ad7YDCrYA1LrXdvLyDvCVvuMuOrh+lLP50jsVuBJYX6dfKiwPvfnni6BrmXCgieu5rX/+EOrgXDdW0AvWdd8I7e42Q3kgeoxmVtxSwBBCASO4foGpuHWI9i/HSePo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712503681; c=relaxed/simple;
	bh=0IKs6mHLM3P1EqkP3pcU4Ln0MmCNBpJkS0sFYgfIoLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQJMBtvkIsGta1yCA9viRsETsB6cnHz8BMocvYs5Y+Of5A+llVbYrW1LK7n5fGXOcB8FANiwp5vB5PDxS6VSrpFbepxMyr48hJzEBZDB8xZDpfv+jhOtWof63wt7tMCpTaVsi26LSByDN41n1HgPC2xoa8NCIVYobPXCTbUfr1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MUxzNh6U; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=hl+KRhAkS8hsPyOcEJV7vKllcMCOECwtzWDV/gv5BOQ=; b=MU
	xzNh6UdJgk+VqLyDKHirwJitofnfjpsfh7vzZ7ZSt+cJJtObURca+aZGbMjFRYX2H/cQyME7xyzQA
	JnfPfaZnaWTSqqqrOBkSfu3lUBDoWDEQgUJbbMOR14Zu7/8NGr2/s1cRS4ELQFJz10xLN6VSafV9d
	aiZJ4X4Zh3W83jw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rtUQk-00CQgd-5m; Sun, 07 Apr 2024 17:27:38 +0200
Date: Sun, 7 Apr 2024 17:27:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	fancer.lancer@gmail.com, Jose.Abreu@synopsys.com,
	chenhuacai@loongson.cn, linux@armlinux.org.uk,
	guyinggang@loongson.cn, netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
Subject: Re: [PATCH net-next v9 6/6] net: stmmac: dwmac-loongson: Add GNET
 support
Message-ID: <33bda648-31b6-4da7-bf25-b0d2d41ad139@lunn.ch>
References: <cover.1712407009.git.siyanteng@loongson.cn>
 <3e9560ea34d507344d38a978a379f13bf6124d1b.1712407009.git.siyanteng@loongson.cn>
 <a3975cd6-ae9a-4dc1-b186-5dacf1df5150@lunn.ch>
 <60b7a9c3-ad98-4493-b1c7-3ee221a3101a@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60b7a9c3-ad98-4493-b1c7-3ee221a3101a@loongson.cn>

On Sun, Apr 07, 2024 at 05:06:34PM +0800, Yanteng Si wrote:
> 
> 在 2024/4/6 22:46, Andrew Lunn 写道:
> > > +	 */
> > > +	if (speed == SPEED_1000) {
> > > +		if (readl(ptr->ioaddr + MAC_CTRL_REG) & (1 << 15))
> > It would be good to add a #define using BIT(15) for this PS bit. Also,
> OK.
> > what does PS actually mean?
> 
> In DW GMAC v3.73a:
> 
> It is the bit 15 of MAC Configuration Register
> 
> 
> Port Select

Since this is a standard bit in a register, please add a #define for
it. Something like

#define MAC_CTRL_PORT_SELECT_10_100 BIT(15)

maybe in commom.h? I don't know this driver too well, so it might have
a different naming convention. 

	if (speed == SPEED_1000) {
		if (readl(ptr->ioaddr + MAC_CTRL_REG) & MAC_CTRL_PORT_SELECT_10_100)
		/* Word around hardware bug, restart autoneg */

is more obvious what is going on.

> > > +	priv->synopsys_id = 0x37;
> > hwif.c:		if (priv->synopsys_id >= DWMAC_CORE_3_50) {
> > hwif.c:	priv->synopsys_id = id;
> > hwif.c:		/* Use synopsys_id var because some setups can override this */
> > hwif.c:		if (priv->synopsys_id < entry->min_id)
> > stmmac_ethtool.c:		if (priv->synopsys_id >= DWMAC_CORE_3_50)
> > stmmac.h:	int synopsys_id;
> > stmmac_main.c:			if (priv->synopsys_id < DWMAC_CORE_4_10)
> > stmmac_main.c:	if (priv->synopsys_id >= DWMAC_CORE_4_00 ||
> > stmmac_main.c:		if (priv->synopsys_id < DWMAC_CORE_4_00)
> > stmmac_main.c:	if (((priv->synopsys_id >= DWMAC_CORE_3_50) ||
> > stmmac_main.c:	if (priv->synopsys_id < DWMAC_CORE_5_20)
> > stmmac_main.c:	else if ((priv->plat->enh_desc) || (priv->synopsys_id >= DWMAC_CORE_4_00))
> > stmmac_mdio.c:	if (priv->synopsys_id < DWXGMAC_CORE_2_20) {
> > stmmac_mdio.c:	if (priv->synopsys_id < DWXGMAC_CORE_2_20 &&
> > stmmac_mdio.c:	if (priv->synopsys_id < DWXGMAC_CORE_2_20 &&
> > stmmac_mdio.c:		if (priv->synopsys_id < DWXGMAC_CORE_2_20) {
> > 
> > Please add a #define for this 0x37.
> > 
> > Who allocated this value? Synopsys?
> It look like this.

That did not answer my question. Did Synopsys allocate this value?  If
not, what happens when Synopsys does produce a version which makes use
of this value?

> > 
> > /* Synopsys Core versions */
> > #define DWMAC_CORE_3_40         0x34
> > #define DWMAC_CORE_3_50         0x35
> > #define DWMAC_CORE_4_00         0x40
> > #define DWMAC_CORE_4_10         0x41
> > 
> > 0x37 makes it somewhere between a 3.5 and 4.0.
> 
> Yeah,
> 
> How about defining it in
> drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c?

No, because of the version comparisons within the code, developers
need to know what versions actually exist. So you should include it
along side all the other values.

      Andrew

