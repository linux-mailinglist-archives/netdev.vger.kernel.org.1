Return-Path: <netdev+bounces-183737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51461A91C16
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 14:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5263E7A6EE6
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 12:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD988245020;
	Thu, 17 Apr 2025 12:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KScbEZzG"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D21023FC7D;
	Thu, 17 Apr 2025 12:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744892782; cv=none; b=U0/qH3NiWL4mCo9ijKQuxYyl8McYiINGzcgpl/oj2mRvo7L9ZYZ1fojB4VUNlRxzicv5Y8s4QkqfXXHa6d44NeffkMhsV/IFfPN5MRfzYw/JHUEcjmlcE3XEDZdPjKOzs7QNKgFcB5oI0RrRW7crtXi5dk+I6QEYmRuhU14X8t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744892782; c=relaxed/simple;
	bh=XShrIqy/F/rO/KKW612V+Cc9f3IOC6YKFgfbvHrhTVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhxIIa80FuiDCQ4HHD87kkNYmNNXipomV0K+En3E8VjaHzFpLeZ6LLU7bUFaIXQlKtxck3LTrMMsxOCC/CtoUV0L6KHUSSo9vx/f+MJJh5eBwy0CZa2fcq1/yS0DeOHim2gIbxKkPZtQSyE7fyZGUiCcYjosCekbuuEJktlg1GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=KScbEZzG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BVA8Ut43wC0vlwGEv5MT143tTlJwFfx7Nv9rCtN2oCo=; b=KScbEZzGRMQxUhMbyHSWCWNh/o
	8v6F3QwmplCDkcgy0Ast0jELZEdhMvg5mGAymRrtGYyO+W5p2O/e/+VvZoXwSAQk9NDACJ8HIWmEE
	ui3wNRoI6/Z3vuSCpRMhExN/42nau6qdfvUpgPI9ywIRiwuilCBorpRTj0b+SUYd4Yr2h34VcP9Wk
	TN5nIKO5nLMaOCCfWz4aXFAoOc44Hp9FKoDHnw7rle8FoN9OcgOEz81wrTP5JoClxWV1sPG5pqxST
	Q5EzrYAVhniiBMa0Zjj3vLehMaUrlQ7xy/lVmn6WsMGFHAo/iJZyC/V8nhS/1Fes/uqnHESH3ZMIH
	ZLJ5pTtQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56390)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u5OJj-0007Gc-2R;
	Thu, 17 Apr 2025 13:26:07 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u5OJa-0002RV-1O;
	Thu, 17 Apr 2025 13:25:58 +0100
Date: Thu, 17 Apr 2025 13:25:58 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	upstream@airoha.com, Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kory Maincent <kory.maincent@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Claudiu Beznea <claudiu.beznea@microchip.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jonathan Corbet <corbet@lwn.net>, Joyce Ooi <joyce.ooi@intel.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Michal Simek <michal.simek@amd.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Robert Hancock <robert.hancock@calian.com>,
	Saravana Kannan <saravanak@google.com>,
	UNGLinuxDriver@microchip.com,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [net-next PATCH v3 00/11] Add PCS core support
Message-ID: <aADzVrN1yb6UOcLh@shell.armlinux.org.uk>
References: <20250415193323.2794214-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415193323.2794214-1-sean.anderson@linux.dev>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 15, 2025 at 03:33:12PM -0400, Sean Anderson wrote:
> This series adds support for creating PCSs as devices on a bus with a
> driver (patch 3). As initial users,

As per previous, unless I respond (this response not included) then I
haven't had time to look at it - and today is total ratshit so, not
today.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

