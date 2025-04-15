Return-Path: <netdev+bounces-182663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F5DA898F3
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1238189F0D9
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 09:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8421B289376;
	Tue, 15 Apr 2025 09:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nUR07SN6"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E6E2063D2;
	Tue, 15 Apr 2025 09:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744710985; cv=none; b=M+pzhgMlp7HbrLS34RH8/ze7XthjGq5Gxvd4LedQ2bCILOylgQj9ljLh11B9S12m3uQ6ayFzWC7IwXYcPHs3WXlN/5GbO+TpIdj2uzSWQAb+8uKrG9rh7WXb7QIt6kx0HuQxeyPT/GudGtIsfUVOC7ZrRbrzZvw3rDiblkEij9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744710985; c=relaxed/simple;
	bh=SXeouNsIw4orkoUYHILjA3mkuPoRVA/RbzH4YSM0Omw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9gRoBcwBB67NUxdZBKj3gAgkMPV/cyQveuGkKnSJOBwzrPIEwysK5lO42l/3iGuxuMfmE22hgskSf5zqHUye7zNiHNJcBHBSGskNTmjQOXDPUQVX93URgWb21NkGePx4AaBnfY3b0tYSgo3UwgFwMrKNP+y1bMz9SO9U4N9j9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=nUR07SN6; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fLZUFFVfeIkqc65hMxdnYv2FI9bh1Nh+k7hk46nVFFg=; b=nUR07SN6IlOmG++RioA4KGRcwc
	rlCcZ12Zg9P5SjKD64C9uHaFqnrtQ2aHrPSN3Fbzs81vybT0vJ3CHCCuS818sb7voVQyCQuvvuyVu
	8jtH71h4dOMuz9m1arI2F5mgJph68tYCOYj3OLF1VvQ+nyWVCNlFGD31iwsj/Siyum0zV/5EHhoj9
	S1iHBJzIe2JC3p+TfnOBeuVyYno9/Wm9yykSjMsN/kpKKLaCV+aIVaE3Mz31QitXFTyVAYn9skS0f
	edClkFVjtYNXi/IRhBXUVylQqaw5Yg4nyxQCyEw4UGk1A96SPMRKhe9oVxXn+55vB4ob7VTrFFFW2
	pJ8qb7kA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58270)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u4d1R-0007tE-3D;
	Tue, 15 Apr 2025 10:56:06 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u4d1P-0000GR-08;
	Tue, 15 Apr 2025 10:56:03 +0100
Date: Tue, 15 Apr 2025 10:56:02 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Eric Woudstra <ericwouds@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v7 0/6] net: phy: Add support for new Aeonsemi
 PHYs
Message-ID: <Z_4tMirsQNl3qE0Y@shell.armlinux.org.uk>
References: <20250410095443.30848-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410095443.30848-1-ansuelsmth@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

I'm sure you know, but your email address for linux-kernel is wrong.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

