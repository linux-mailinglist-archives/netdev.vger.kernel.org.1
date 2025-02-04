Return-Path: <netdev+bounces-162667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB63A27912
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 18:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F4C23A2E81
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 17:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34B92165E5;
	Tue,  4 Feb 2025 17:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="RmYK1/HX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4DD215F5A;
	Tue,  4 Feb 2025 17:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691719; cv=none; b=LlC1jXKUY7lBZnGAu3rWuh4E5EqNgs1QS8OcN+sD2j+JniRSyzUEGyOEmWJstu2uerJW/eBIHNuqZrmiYYlNpomjp0FLvMMzMj9pd6u94VdG/RqcnOaFFHwyMq8qTXoOT+jAm4NAUhQ2PYTn+YolfDSfZuT2Q7MV4Bj0be7LzOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691719; c=relaxed/simple;
	bh=eKkjbpvmMcUWCmAAn0Q+Qi2GwIWAsBjIOjlZJX/J/t0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJ7QOe8+4Nid05CiYT5xwA1t/I3kijOvV2vLC8Z2TpFTUGCTPyJwpDQtTZSZC3DTpKVWR0IWnwbmB6sgAfJ4SalvnXkrfnb5r6ivq4AeUgba/y6Ptbc9EJQ8a+0mXCEx5zEFktqk+PGIbFC/2LTzK02ykVB2YljNFARTTykDkFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=RmYK1/HX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=X+m8Z/jlxHVarmXMBJ9vHq1s4OI5ALJ7QeQ4FYkMmrU=; b=RmYK1/HXwlDsydBS1UzBO8C+Jq
	ENGfvbKHsqrNMGqu6hid4sknnUEOtrhV2cLRNulN9R8gAIlD70mQw7ovqOuB8JWCo2MalML4lF+Fs
	G/j3FBcdBgkwi2/SBe4+j9onM+tiq0pzZH1wy7JWHXE/OODxrK9EWlZwWmX+L/TreAHfu1NkMvQab
	IX4C9SSuyRlrikn1hYTdcoOvVBVYWnhb1zhi52GI8/xbA4iIkLnDh24Iyb72LhxkkON1VCsxn1Gj7
	MXiLxeWpt+l+a3d9nDfut4bHH34kQF8IRsG5pbJIRSYhsWLUEWW6ulVU/O/oMHJQu5yn5VWB7yRfB
	oqd/LDgQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33282)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tfN8U-0004Jt-12;
	Tue, 04 Feb 2025 17:55:00 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tfN8P-0001Zt-2z;
	Tue, 04 Feb 2025 17:54:53 +0000
Date: Tue, 4 Feb 2025 17:54:53 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: dimitri.fedrau@liebherr.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH net-next v3 2/3] net: phy: Add helper for getting tx
 amplitude gain
Message-ID: <Z6JUbW72_CqCY9Zq@shell.armlinux.org.uk>
References: <20250204-dp83822-tx-swing-v3-0-9798e96500d9@liebherr.com>
 <20250204-dp83822-tx-swing-v3-2-9798e96500d9@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204-dp83822-tx-swing-v3-2-9798e96500d9@liebherr.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Feb 04, 2025 at 02:09:16PM +0100, Dimitri Fedrau via B4 Relay wrote:
>  #if IS_ENABLED(CONFIG_OF_MDIO)
> -static int phy_get_int_delay_property(struct device *dev, const char *name)
> +static int phy_get_u32_property(struct device *dev, const char *name)
>  {
>  	s32 int_delay;
>  	int ret;
> @@ -3108,7 +3108,7 @@ static int phy_get_int_delay_property(struct device *dev, const char *name)
>  	return int_delay;

Hmm. You're changing the name of this function from "int" to "u32", yet
it still returns "int".

What range of values are you expecting to be returned by this function?
If it's the full range of u32 values, then that overlaps with the error
range returned by device_property_read_u32().

I'm wondering whether it would be better to follow the example set by
these device_* functions, and pass a pointer for the value to them, and
just have the return value indicating success/failure.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

