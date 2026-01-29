Return-Path: <netdev+bounces-254767-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIuACABCe2n6CwIAu9opvQ
	(envelope-from <netdev+bounces-254767-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:18:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAFEAF891
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65E4E300DE0D
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D563806AA;
	Thu, 29 Jan 2026 11:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wQX7OV28"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FEF2EAB61;
	Thu, 29 Jan 2026 11:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769685472; cv=none; b=chsJLfSC5HS/+8hSHJmGi/wnkks4rdM6C+3kPH9NEs1Dgbj/C5A5fNxCHauL74CgNksGAu9zLztyU9LCBwHMgEXWHzeow/fwzWrOs79K/Ac17YWJkdFAUIDrlwFEyAzpx+DuK0/kjvSZ6AdpXikcrCDTbXcwRM3uBNU3WPvEOTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769685472; c=relaxed/simple;
	bh=hWoB8NJnZzKT+p4uTPHE7XVADyAG8YytwVhjFS3wcGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ex6erJgxX2S/rOnNhIocJ09fStPOAjSyunJ6B6DFGijzEDs8Bmzz1HCjCRpKg/1LoQXSYlkTxjCp4KNCuyzQd/EWIn62KBgFklJTiUudRl6q6re44+2acFKWbgf/hZ4BLae1RJ/VGBPQZGc6FodnRO66P8mZVCeZ5orgT5eMMt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wQX7OV28; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xRbGhk3MppX3QDh9iQp/r9WXjYsRk1w3/DNqD5xKN6Y=; b=wQX7OV28trnhd/CmJjo5OstW0W
	VacPFX0Hr4C4H6AbOwz1lgX2ZqOb0qMQVpvLLDABSpoFhqUNZuAjs3dGP0OY4Sw2nkRfZrHdsf6tz
	Byj2tuwWQ3clIjdIAOi1F0fYLpc6Cw1NZ3ejgQJewEBjjmLuuepHETy5Kh5NH+qJ15rkPEx1Tu1/2
	xE/vVczNvP+OKQnO5K2qJfwsR4dGPLdV/a6pNs6k0WN5nGF0Ehp69lQlS6mfqr4lMDzUMlm8ED1KW
	zE3yJeokfswi0AyQTr0+bfHTh7xiIYTNjiOalKMazWFmGNAEeOVsCN8+fRdBFwN3kFAuOnKkgoCRo
	FRD67AYw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57138)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vlQ1s-000000008S8-0a6Z;
	Thu, 29 Jan 2026 11:17:40 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vlQ1p-000000007v4-3EdQ;
	Thu, 29 Jan 2026 11:17:37 +0000
Date: Thu, 29 Jan 2026 11:17:37 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: vkoul@kernel.org, neil.armstrong@linaro.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ciprianmarian.costea@oss.nxp.com, s32@nxp.com,
	p.zabel@pengutronix.de, ghennadi.procopciuc@nxp.com,
	bogdan-gabriel.roman@nxp.com, Ionut.Vicovan@nxp.com,
	alexandru-catalin.ionita@nxp.com, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	Frank.li@nxp.com
Subject: Re: [PATCH 2/4] phy: s32g: Add serdes subsystem phy
Message-ID: <aXtB0QcVOkE_hhny@shell.armlinux.org.uk>
References: <20260126092159.815968-1-vincent.guittot@linaro.org>
 <20260126092159.815968-3-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126092159.815968-3-vincent.guittot@linaro.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254767-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:url,shell.armlinux.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8EAFEAF891
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 10:21:57AM +0100, Vincent Guittot wrote:
> +/*
> + * Until now, there is no generic way to describe and set PCIe clock mode.
> + * PCIe controller uses the default CRNS = 0 mode.
> + */
> +enum pcie_phy_mode {
> +	CRNS = 0, /* Common Reference Clock, No Spread Spectrum */
> +	CRSS = 1, /* Common Reference Clock, Spread Spectrum */
> +	SRNS = 2, /* Separate Reference Clock, No Spread Spectrum */
> +	SRIS = 3  /* Separate Reference Clock, Spread Spectrum */
> +};

So this is a PCIe thing. If it's part of the driver's API, then it
should be common and not driver-private.

> +static inline bool is_pcie_phy_mode_valid(int mode)
> +{
> +	switch (mode) {
> +	case CRNS:
> +	case CRSS:
> +	case SRNS:
> +	case SRIS:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}

This checks that the submode is one of the PCIe private modes that this
driver wants to see.

> +
> +static int s32g_serdes_phy_set_mode_ext(struct phy *p,
> +					enum phy_mode mode, int submode)
> +{
> +	struct s32g_serdes *serdes = phy_get_drvdata(p);
> +
> +	if (mode == PHY_MODE_PCIE)
> +		return -EINVAL;
> +
> +	if (!is_pcie_phy_mode_valid(submode))
> +		return -EINVAL;

This checks for the PCIe submode, but notice the test immediately
above. PCIE mode is being rejected. So, this driver supports
everything else but PCIe.

That doesn't seem right.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

