Return-Path: <netdev+bounces-42575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AE37CF615
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 13:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3769281E85
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 11:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765AE18B10;
	Thu, 19 Oct 2023 11:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BhzRE6qs"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E778618AF4;
	Thu, 19 Oct 2023 11:04:58 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78175FA;
	Thu, 19 Oct 2023 04:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dSpnoWoyzHFpOJL9PnetAQWeHzMWff297XoDSrg60Zc=; b=BhzRE6qsmqaX8pszyropkuq61m
	7Y5n0pzIhJ/emvomv/AaaOf5lApDlZuV3+PjzeZn0eyWnZmkjvZbVNyGlov1v2OKxcFpWdl1oj+xZ
	nXqpUKBFnd94saAoLwyMJqah7HIBvorZnG42J6TuZtCPcAapm1RN8RaXc3CAGzYki40UGnGz78X8H
	OXBLjVUiNGg+1IV0gipULCwYlx3nXgbQiWKZWwyan8JgtPgKN90eqYRmn2t2yQ0buNRXY+LgdhE9M
	n+L6o/IrkhHqoLwZVAYKP6PTNRY0OdTdqnDsp12McXbCFI7X1Qc6M5pDAvB71k3Y78tUIkUOVgVH4
	L6VlDlfQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39610)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qtQpZ-0006qY-1r;
	Thu, 19 Oct 2023 12:04:45 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qtQpa-0000Nl-Fm; Thu, 19 Oct 2023 12:04:46 +0100
Date: Thu, 19 Oct 2023 12:04:46 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 3/7] ARM: dts: marvell: Fix some common
 switch mistakes
Message-ID: <ZTENTqAMf/6ZWX2i@shell.armlinux.org.uk>
References: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-3-3ee0c67383be@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018-marvell-88e6152-wan-led-v4-3-3ee0c67383be@linaro.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Oct 18, 2023 at 11:03:42AM +0200, Linus Walleij wrote:
> Fix some errors in the Marvell MV88E6xxx switch descriptions:
> - The top node had no address size or cells.
> - switch0@0 is not OK, should be switch@0.
> - The ports node should have port@0 etc children, no
>   plural "ports".
> 
> This serves as an example of fixes needed for introducing a
> schema for the bindings, but the patch can simply be applied.

In patch 2, you mention that things should be named ethernet-switch and
ethernet-port. As you're renaming the nodes in this patch, wouldn't it
make sense to use those names instead now, rather than at some point in
the future a patch that converts to these names?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

