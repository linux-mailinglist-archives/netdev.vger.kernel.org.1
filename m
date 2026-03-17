Return-Path: <netdev+bounces-268706-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Le+BSWbuWn5KwIAu9opvQ
	(envelope-from <netdev+bounces-268706-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 19:19:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 830662B0D21
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 19:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6EE22301CC47
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 18:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1C337FF4C;
	Tue, 17 Mar 2026 18:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TmXsRtFG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6A537F8D3;
	Tue, 17 Mar 2026 18:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773771552; cv=none; b=oW8YCO6VsMNrb05102DO8iw9NPZjCcRbO3czhA168FgoJEApSmGiuQ4dGS+gNKvbIRHAkycJ5phjIhvq2r4dDkIKFKP8QMeIqbMCWYlx6/sGDOCq9ypvGEgKSO7aV4ccZRKXgyJtXHi7rLKWgh6/GmsJtqrHF3nvxK6OOaRc1pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773771552; c=relaxed/simple;
	bh=KOnV6etOQfNpnIecF+8DY29/yHDPKOW3rIXUEs2k6+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E71Y6XYGcei19u9IpC04f+sOVWWRu+aXKl13Ey/dotFFw21A5r6gbtOoVeRIFA+ykx06A2E4LoNIbJi2vx5eUqFB4qwjljDJme7p/dIdi54AfrKRHRgdTzAOFat1/y9QfvtX521Pm5uMKC/9l9PlX7RadkPhGSRaR46J8xQst64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TmXsRtFG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PgdFu04NLioPY9YFleATtLyUhwzlJEE0l5iZhjJGhUk=; b=TmXsRtFGH+75/+Ey+VMydsImYo
	UbGvoDjxXZTTDQHDrcNu2MkpY2sP1N2qF1Xhm5vBnYvkSL1+r2alIeG30k7yEmm46+Y3XZTWT7J1a
	zyVaS3Fyge00boQVPdyKzTstujqRplU0JgcC2CsMJaks4HIjvHuUsrFIx0XkD5Qz3LdU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w2Z0M-00C48c-6t; Tue, 17 Mar 2026 19:18:58 +0100
Date: Tue, 17 Mar 2026 19:18:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Lucien.Jheng" <lucienzx159@gmail.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	ericwouds@gmail.com, frank-w@public-files.de, daniel@makrotopia.org,
	lucien.jheng@airoha.com
Subject: Re: [PATCH v1] net: phy: airoha: add AN8811HB MCU assert/deassert
 support
Message-ID: <96563ae4-f5fc-437c-b90e-92e7981490fe@lunn.ch>
References: <20260315134155.142750-1-lucienzx159@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260315134155.142750-1-lucienzx159@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268706-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,public-files.de,makrotopia.org,airoha.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: 830662B0D21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 15, 2026 at 09:41:55PM +0800, Lucien.Jheng wrote:
> AN8811HB requires the MCU to be held in reset before firmware
> loading and released afterwards via a dedicated PBUS register
> pair (0x5cf9f8 / 0x5cf9fc), accessed through the PHY-addr+8
> MDIO bus node rather than the BUCKPBUS indirect path.
> 
> Add __air_pbus_reg_write() as a low-level helper for this
> access, then implement an8811hb_mcu_assert() / _deassert()
> on top of it.  Wire both into an8811hb_load_firmware() and
> en8811h_restart_mcu() so every firmware load or MCU restart
> on AN8811HB correctly sequences the reset control registers.

What happens if the MCU is not held in reset? Should this be
considered a fix?

What are the valid PHY addresses for this device? Do we need to worry
about the PHY is at address 31, is the dedicated PBUS register is at
7?

> +static int an8811hb_mcu_assert(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	phy_lock_mdio_bus(phydev);
> +
> +	ret = __air_pbus_reg_write(phydev, AN8811HB_MCU_SW_RST,
> +				   AN8811HB_MCU_SW_RST_HOLD);
> +	if (ret < 0)
> +		goto unlock;
> +
> +	ret = __air_pbus_reg_write(phydev, AN8811HB_MCU_SW_START, 0);
> +	if (ret < 0)
> +		goto unlock;
> +
> +	msleep(50);
> +	phydev_info(phydev, "MCU asserted\n");

Please don't spam the log. phydev_dbg() or not at all.

>  static int an8811hb_load_firmware(struct phy_device *phydev)
>  {
>  	int ret;
>  
> +	ret = an8811hb_mcu_assert(phydev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = an8811hb_mcu_deassert(phydev);
> +	if (ret < 0)
> +		return ret;
> +

Assert and then deassert, but no firmware download between? That is
not what the commit message says.

	Andrew

