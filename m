Return-Path: <netdev+bounces-29442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 089AC7834B1
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 23:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4FFA280DC2
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 21:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C887125AA;
	Mon, 21 Aug 2023 21:10:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919C5F9C1
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 21:10:33 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2275FBC;
	Mon, 21 Aug 2023 14:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6YAGYc+gu+qlxGlxjiPaMjWsQ010TzGyUv0/2pq1FBE=; b=KCLs3HQYE3H9GrtX9omI5lH7Zx
	NJzg2+JhkWxrNj17x6oqDsWSERoB+l4UnR4BOU3hkhg9Yz+pARM7wZqqxO+tsyTNQY8lPSgvc/cp3
	DJErsW3/c3y+V3HrEvs7wUjGyAZEEKqXYEU5lAchOoAt4BdNrZbAp61YifJx8SEtfvv0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qYCAN-004j3g-JL; Mon, 21 Aug 2023 23:10:27 +0200
Date: Mon, 21 Aug 2023 23:10:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Rob Herring <robh@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Camelia Groza <camelia.groza@nxp.com>, Li Yang <leoyang.li@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor@kernel.org>,
	Sean Anderson <sean.anderson@seco.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [RFC PATCH net-next 8/8] dt-bindings: net: fsl,backplane-anlt:
 new binding document
Message-ID: <842f7ff0-d376-4f55-b72d-2db7ea827792@lunn.ch>
References: <20230817150644.3605105-1-vladimir.oltean@nxp.com>
 <20230817150644.3605105-9-vladimir.oltean@nxp.com>
 <20230821195840.GA2181626-robh@kernel.org>
 <20230821201146.hudnk5v2zugz726p@skbuf>
 <e3afb3d5-6efe-46de-81ca-7f0163c4b04d@lunn.ch>
 <20230821203433.ysulh2bixfypbhsk@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821203433.ysulh2bixfypbhsk@skbuf>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> But, there's already something else at those MDIO registers (where the
> standard PHY ID location is), in the MMD that the AN/LT block responds to.
> And that would be:
> 
> /* Auto-Negotiation Control and Status Registers are on page 0: 0x0 */
> static const u16 mtip_lx2160a_an_regs[] = {
> 	[AN_CTRL] = 0,
> 	[AN_STAT] = 1,
> 	[AN_ADV_0] = 2, // overlaps with MII_PHYSID1
> 	[AN_ADV_1] = 3, // overlaps with MII_PHYSID2
> 	[AN_ADV_2] = 4,
> 	[AN_LPA_0] = 5, // overlaps with MDIO_DEVS1
> 	[AN_LPA_1] = 6, // overlaps with MDIO_DEVS2
> 	[AN_LPA_2] = 7,
> 	[AN_MS_CNT] = 8,
> 	[AN_ADV_XNP_0] = 9,
> 	[AN_ADV_XNP_1] = 10,
> 	[AN_ADV_XNP_2] = 11,
> 	[AN_LPA_XNP_0] = 12,
> 	[AN_LPA_XNP_1] = 13,
> 	[AN_LPA_XNP_2] = 14,
> 	[AN_BP_ETH_STAT] = 15,
> };
> 
> The AN advertisement registers are kinda important to the operation of
> the driver, so I wouldn't want to mask them with fake PHY ID values
> reported by the MDIO controller.

O.K, not ideal. For C22, you could just put the ID values in the
compatible, which is enough to get a driver loaded which supports that
ID. But somebody recently commented that that does not work for C45. I
assume NXP has an OUI, and could allocate an ID to this device in
retrospect. So maybe it makes sense to make C45 work with an ID in the
compatible? And get the driver loaded that way?

	Andrew

