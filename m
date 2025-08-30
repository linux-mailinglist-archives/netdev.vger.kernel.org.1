Return-Path: <netdev+bounces-218520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B7AB3CF87
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 23:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFC2D20586E
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 21:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B73275B1A;
	Sat, 30 Aug 2025 21:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="e+CtcqMH"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9B7205E25;
	Sat, 30 Aug 2025 21:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756589258; cv=none; b=Z+XRIX1R3kFbPoXqc9maUijUrXJh5Lq8FtBpo7n6Qr99ArANGGTSZmVxf3wNSjCeNWExUDebmoBcwp4gM9knLL20ysI6UX3xSC9H3ezYtGHxWpl51naoADg69VlwTk3qWMqKr4HeDN2GscHFP0pkhNljoIPkkAtF5k78iwEFoNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756589258; c=relaxed/simple;
	bh=gOgiF7X0ZGiw78EqDu1KHpEzwtvNyU+rjXBNKACNj6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adEE34LdrudjNIkKF+1gayD291cQ+tzSIMRmzRtJprvtyM4wVKqTVNJ8atjIDoX1xMyjuvn2VxgdfQ98PAOhM57FhMhdC8UmB4ulTxAhDGg9pEwU8TaP3YuEPE6tY/4gqqeO5yXtwQ/WVeQGwMwBKpsBntSWX1plP+gEchSfC7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=e+CtcqMH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VLdSQW7+O0R1hhE3XjC/Wy7ssjU7PWHhYOnONnoYdgU=; b=e+CtcqMH5Dkqg+YMIEoQ+WwPOa
	2FUxf10H6EbrNyJZgT3G1kwTA0R8GqFIQP4DLIU/ihIKnspRpa96TGG6U0ZcL+xgtdCPIgomfwBtd
	i61RVfTXXxMzg006FakL++46JHX5D8Kxnh8+99gTOHamgwqm9Mr5EHhLlA1Y4ZP9SXd0fw8X8ICEa
	WkdN9B3Ow7yhXn6YNoq8hBxtLGQ3mFqotIC1YEkiewqKH3j9oepeaiV3DnwhgtVHKleGVxZynBKKL
	f+ZviAtD1mbJb8IfAsF+rhuoSOh/sOH/FeIOgH4fT4WQoO9yBBipj5s8Am259n4lYLEZkmCksCLWA
	fjknDKYQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42508)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1usT6Y-000000004Sw-2Maq;
	Sat, 30 Aug 2025 22:27:22 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1usT6V-000000005PN-1BOn;
	Sat, 30 Aug 2025 22:27:19 +0100
Date: Sat, 30 Aug 2025 22:27:19 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 1/5] arm64: dts: ls1043a-qds: switch to new
 fixed-link binding
Message-ID: <aLNst1V_OSlvpC3t@shell.armlinux.org.uk>
References: <a3c2f8d3-36e6-4411-9526-78abbc60e1da@gmail.com>
 <fe4c021d-c188-4fc2-8b2f-9c3c269056eb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe4c021d-c188-4fc2-8b2f-9c3c269056eb@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Aug 30, 2025 at 12:27:23PM +0200, Heiner Kallweit wrote:
> The old array-type fixed-link binding has been deprecated
> for more than 10 yrs. Switch to the new binding.

... and the fact we have device trees that use it today means that we
can't remove support for it from the kernel.

I think it would make sense to update the dts files, and add a noisy
warning when we detect that it's being used to prevent future usage.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

