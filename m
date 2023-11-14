Return-Path: <netdev+bounces-47779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC337EB62C
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 19:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3FA9B20C0D
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 18:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28AB11C90;
	Tue, 14 Nov 2023 18:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pDHRUxay"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD292C1B0;
	Tue, 14 Nov 2023 18:13:05 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14517FD;
	Tue, 14 Nov 2023 10:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AKGfhx+Br8EDz2nYnIT9XdxIWkjKI5nOarqUFZtoZX8=; b=pDHRUxayx11wLwU5Af8i7njpMa
	5rhkSTi/Vvw/yMb3GDJMaiTI3xHH4i7jYdpR1C7R+QSTXsll9xpCdc43wbkLiTv/SffY7Aya7lLpN
	ogF49sNGuNHRIMf5Ee8zDh1ShrR2XAYEga9VDcTDvM8X5H5A3r1WbXV3qY92cDZb2waY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r2xuA-000BIW-Sh; Tue, 14 Nov 2023 19:12:54 +0100
Date: Tue, 14 Nov 2023 19:12:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: davem@davemloft.net, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Luka Perkov <luka.perkov@sartura.hr>,
	Robert Marko <robert.marko@sartura.hr>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH net-next v3 0/8] net: qualcomm: ipqess: introduce
 Qualcomm IPQESS driver
Message-ID: <4224ec76-cdeb-4c80-8385-e5e24957e63b@lunn.ch>
References: <20231114105600.1012056-1-romain.gantois@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114105600.1012056-1-romain.gantois@bootlin.com>

On Tue, Nov 14, 2023 at 11:55:50AM +0100, Romain Gantois wrote:
> Hello everyone,
> 
> This is the 3rd iteration on the Qualcomm IPQ4019 Ethernet Switch Subsystem
> driver. I made some patch separation mistakes in the v2, sorry about that.
> 
> Notable changes in v3:
>  - Fixed formatting of 3/8.

Please wait at least 24 hours between submitted versions. Otherwise
you get people reviewing the wrong version.

    Andrew

