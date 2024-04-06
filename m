Return-Path: <netdev+bounces-85420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BA689AB6B
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 16:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5340F1F21B29
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 14:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889E62D051;
	Sat,  6 Apr 2024 14:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2EdFao6X"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E872836D
	for <netdev@vger.kernel.org>; Sat,  6 Apr 2024 14:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712414830; cv=none; b=ctpQcHNANYIBfRyaeHaV3x7iKW4cW1tWkGbDwwbUnvlJdG6vABEg3JX+oCNwVzvuYSClxTgFq46gsGvD3Ii4G8/Sg6s/eeLzWVQkqcs06okmwHHY243ViqRNr7O//4LWTuuPWkd7zbK+ZKsNV9aBf3PpQCpsEK4LiaXobBO/Bl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712414830; c=relaxed/simple;
	bh=6gF3lw525dNquOf1Wlt+lbSqjZjUSKbE+kQ/NWr7Zuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aG9Cav2zuY4TVmtIM63D3EMkkg6JeSt7Yd0L98xDfhV9BJB5+AE4oD7M9wL4a651ObtS/xc0ZL+Qkjjr7Dl1aS923FEFLkfBOxUEQ+vYr+nOZov0LniEniVaCrw0CYxhGHVMsrpZ4xYO7mUsIfNZetLrG+UIdinQWpZU8b0jtv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2EdFao6X; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KkM/eBigkziJwOag+4/N3FMZW3f3bDOG1WUzp0rvHv0=; b=2EdFao6Xcz4vY+jGv5WGf9Owjh
	T/Q1E15EgYASILmmzCDaKUwBuIH0ZHKodhNi/pCxBtGjETCXJ9mJTeEvQ+Me1hlIjoT2Mgt0sg4lo
	NxWBoh+DoKF5Z3ZtlPJOXpvnfYlMkln8/7OKDzO5rJbAnmu2jLf3o68G5wyXKEiMUM5E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rt7Jg-00CNBS-8v; Sat, 06 Apr 2024 16:46:48 +0200
Date: Sat, 6 Apr 2024 16:46:48 +0200
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
Message-ID: <a3975cd6-ae9a-4dc1-b186-5dacf1df5150@lunn.ch>
References: <cover.1712407009.git.siyanteng@loongson.cn>
 <3e9560ea34d507344d38a978a379f13bf6124d1b.1712407009.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e9560ea34d507344d38a978a379f13bf6124d1b.1712407009.git.siyanteng@loongson.cn>

> +static void loongson_gnet_fix_speed(void *priv, unsigned int speed,
> +				    unsigned int mode)
> +{
> +	struct loongson_data *ld = (struct loongson_data *)priv;
> +	struct net_device *ndev = dev_get_drvdata(ld->dev);
> +	struct stmmac_priv *ptr = netdev_priv(ndev);
> +
> +	/* The controller and PHY don't work well together.
> +	 * We need to use the PS bit to check if the controller's status
> +	 * is correct and reset PHY if necessary.
> +	 * MAC_CTRL_REG.15 is defined by the GMAC_CONTROL_PS macro.
> +	 */
> +	if (speed == SPEED_1000) {
> +		if (readl(ptr->ioaddr + MAC_CTRL_REG) & (1 << 15))

It would be good to add a #define using BIT(15) for this PS bit. Also,
what does PS actually mean?

> +	priv->synopsys_id = 0x37;

hwif.c:		if (priv->synopsys_id >= DWMAC_CORE_3_50) {
hwif.c:	priv->synopsys_id = id;
hwif.c:		/* Use synopsys_id var because some setups can override this */
hwif.c:		if (priv->synopsys_id < entry->min_id)
stmmac_ethtool.c:		if (priv->synopsys_id >= DWMAC_CORE_3_50)
stmmac.h:	int synopsys_id;
stmmac_main.c:			if (priv->synopsys_id < DWMAC_CORE_4_10)
stmmac_main.c:	if (priv->synopsys_id >= DWMAC_CORE_4_00 ||
stmmac_main.c:		if (priv->synopsys_id < DWMAC_CORE_4_00)
stmmac_main.c:	if (((priv->synopsys_id >= DWMAC_CORE_3_50) ||
stmmac_main.c:	if (priv->synopsys_id < DWMAC_CORE_5_20)
stmmac_main.c:	else if ((priv->plat->enh_desc) || (priv->synopsys_id >= DWMAC_CORE_4_00))
stmmac_mdio.c:	if (priv->synopsys_id < DWXGMAC_CORE_2_20) {
stmmac_mdio.c:	if (priv->synopsys_id < DWXGMAC_CORE_2_20 &&
stmmac_mdio.c:	if (priv->synopsys_id < DWXGMAC_CORE_2_20 &&
stmmac_mdio.c:		if (priv->synopsys_id < DWXGMAC_CORE_2_20) {

Please add a #define for this 0x37.

Who allocated this value? Synopsys?

/* Synopsys Core versions */
#define DWMAC_CORE_3_40         0x34
#define DWMAC_CORE_3_50         0x35
#define DWMAC_CORE_4_00         0x40
#define DWMAC_CORE_4_10         0x41

0x37 makes it somewhere between a 3.5 and 4.0.

stmmac_ethtool.c:		if (priv->synopsys_id >= DWMAC_CORE_3_50)
stmmac_main.c:	if (((priv->synopsys_id >= DWMAC_CORE_3_50) ||

Does the hardware actually provide what these two bits of code
require? Have you reviewed all similar bits of code to confirm they
are correct for your hardware?

	Andrew

