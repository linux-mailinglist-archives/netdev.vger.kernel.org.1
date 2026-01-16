Return-Path: <netdev+bounces-250537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4A0D32339
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 14:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C2FED300874B
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 13:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4A9281368;
	Fri, 16 Jan 2026 13:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pWgS1Xlr"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82AF284B4F;
	Fri, 16 Jan 2026 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768571831; cv=none; b=RN9cbFfhWOA/GaDhe+H8QEejPSTMx5PZULTVOdDoJectsQNehGQGZhvxFURjGdNakWgUC8eBEO/rgEbEDyE1RCB6s9/xQOAEU48/few887mlCsxdKT5OBX3t945gT+CFj7wSX3xVsG2G2V8nNIQEV5pEmu+BD8BJoTpxCJ0ibpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768571831; c=relaxed/simple;
	bh=BOXkKGBmSM6KPlIEzpTpRHi9u26C38ZZt6Q013KAvXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqbzEAsbbt3n6IFL99CKaKspPH/KLq4hv2WePdz98aNZ0uSticVL8BzqxamGYqJUHroEYsbGiCSct9GSjXGTOn+wxG9hl6wDv2cI36zTpoZauzL2uYEUjKscDzUmdwYLu83VmHAOdxshhkqg01kSzqelDqtoh899DfJJUxGvDEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=pWgS1Xlr; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3PCDRCP7/pLiE3Ykl6OrscgyxM5mEhILFsILD4bPkQ4=; b=pWgS1XlrWhdbt+YTdeOMUiHALS
	hXTrisq67pvYSCk8o84Me8dFUxqkH0vPT2p0VM9gfNOsP8qaygedkqFmsftrJQq7QlSgWKrKUDJL5
	hS3IHaTR9uzVBFGnGNvwAQR6h6WE5u//78+x05AIdRX2h6vL47gSywPZYbymSOmtadVRuzV278NnU
	733pXMGRdPUPxP7u0HlFgtEcbUX8oIhheOHHOGbsviwXvxrmghWKlMw22Q5W5X8kom4xC9qjoTuIn
	GVe5e6MCAga08Kb6hAZszMLgaVy7rtgh014zYfAQFbLZKJVqWC6rOnS/rcWMFYUGzILsoBd+uM0ci
	Beff5biA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41880)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vgkJz-000000002KY-2TMo;
	Fri, 16 Jan 2026 13:57:03 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vgkJx-000000003f5-1kmt;
	Fri, 16 Jan 2026 13:57:01 +0000
Date: Fri, 16 Jan 2026 13:57:01 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Subject: Re: [PATCH net-next v5] net: sfp: extend SMBus support
Message-ID: <aWpDrdocUvuBt-gS@shell.armlinux.org.uk>
References: <20260116113105.244592-1-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116113105.244592-1-jelonek.jonas@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jan 16, 2026 at 11:31:05AM +0000, Jonas Jelonek wrote:
> +		max_block_size = SFP_EEPROM_BLOCK_SIZE;
> +	} else if (functionality & I2C_FUNC_SMBUS_BYTE_DATA) {

If we want to be fully flexible, then:

	} else if (functionality & (I2C_FUNC_SMBUS_BYTE_DATA |
				    I2C_FUNC_SMBUS_I2C_BLOCK)) {

since if we only have SMBus I2C block, then everything is fine.

However, I suggest asking I2C people whether it's possible to have a
SMBUS that supports I2C block and/or word access but not byte access.
Is there a heirarchy to the SMBus capabilities.

Also, is it possible for SMBus to support different read and write
capabilities (since there are separate bits for read and write of
each size.)

So, maybe it needs to be:

	} else if ((functionality & I2C_FUNC_SMBUS_BYTE_DATA) == I2C_FUNC_SMBUS_BYTE_DATA ||
		   (functionality & I2C_FUNC_SMBUS_I2C_BLOCK) == I2C_FUNC_SMBUS_I2C_BLOCK) {

to check that both read and write capabilities for each are set.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

