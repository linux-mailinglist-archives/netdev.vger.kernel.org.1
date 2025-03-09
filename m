Return-Path: <netdev+bounces-173351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C49A58658
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 18:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 194E2188D41B
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 17:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CD81E5200;
	Sun,  9 Mar 2025 17:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ngAuCyQx"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CEA13EFF3;
	Sun,  9 Mar 2025 17:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741541893; cv=none; b=q542iTetCEUCWqai4UBJVWCPmdOBK5FmwZqRQzwn/4UEHOwhkiBULBfrxmVqVt5XDyiE1KwVvtBCVqkyWLTYaPXWQEabzokhZTnGMGjbaSf0ZkwjN2qMAyzU2AZRXGGXeNu/Pi6Bt+dqUXQy7Hyiqr5JHnJOJQsP59QMaFYlV3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741541893; c=relaxed/simple;
	bh=Y2EVF7WAzNYoIYbiCDMhFF6uqdXtJZzA5xfpRNWdxR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rcKp3VpiI0L/9XTXCQ/F9UHErWG3f07vXrSPkhBQnx02qtKq77/SR9ovvOtpFeCSisr89IxnsfeHVbu4IlGxNyO4L0ogZ+9rsXlemu1qARZba3NloEsdRGYnroJONEvb7weI/rCv7jH9V0CCt0A1iKVwaZ24qfFgwTtyaxk4M4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ngAuCyQx; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Xr9jiNYViesUrh4gxT7ubexXKj2qyZPJvBCE9EhQwo0=; b=ngAuCyQxlsuKc+xtJ9lbNDvm0D
	MWbn8PePEQzuZLqMjetoty7hX4GbapHjnCHn+7LqR8r0fTRcgvIdUXTtJIsK4pY//Sh2Tfhb43i53
	/EPCrd79Rrloj6EuZA4PFuYgb7QvKGY9zs8dJt9vIDlrdJUQ6/tEbALOF0MUWosuzqxI5mPDfCw7e
	Qz1UgrUdG7489UMANDALfjshiSqB8HHTEoS7dCnQ9G1oV5jr/TqlNkdtHDVPF0m98RV+v4VA5tveH
	EQbV8vlWewMeSQRA+kQTN13OsO4vlWCqWznNrECElbHfXkCt24xELakFKkTALYOsoWI0KPilGEMpz
	NU6B5KJg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57424)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1trKbA-0001Yq-2t;
	Sun, 09 Mar 2025 17:38:00 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1trKb8-0001ch-0h;
	Sun, 09 Mar 2025 17:37:58 +0000
Date: Sun, 9 Mar 2025 17:37:58 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v12 08/13] net: mdio: regmap: add OF support
Message-ID: <Z83R9qVfGbSc8bJs@shell.armlinux.org.uk>
References: <20250309172717.9067-1-ansuelsmth@gmail.com>
 <20250309172717.9067-9-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309172717.9067-9-ansuelsmth@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Mar 09, 2025 at 06:26:53PM +0100, Christian Marangi wrote:
> Permit to pass the device node pointer to mdio regmap config and permit
> mdio registration with an OF node to support DT PHY probe.
> 
> With the device node pointer NULL, the normal mdio registration is used.

Should this be using a device node, or a fwnode?

It depends _why_ you're adding this, and you omit to state that in the
commit description (hint - it should say why!)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

