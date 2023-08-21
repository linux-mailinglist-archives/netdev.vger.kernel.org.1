Return-Path: <netdev+bounces-29402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D676B78300E
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 20:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9253C280E92
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 18:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE20F4F7;
	Mon, 21 Aug 2023 18:14:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43436F4F5
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 18:14:14 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD6C10F;
	Mon, 21 Aug 2023 11:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PFfiLCI2R7ATd6hcl7JXyE5Uz7TCFK+2Vv1ns3pt91Q=; b=I5+khQo/td8bEtwQS2sgNHr64q
	LqVFlxc7i9m07+ofNwwnPeIAGnS+U+P+aUHcuSk79D1gmKXJPNTY1Ihmo75J/wbWxD5c8KBtiAowe
	N8AVwNfMVwi0rvhiSnXgxoozq0NiVd13vovvpyWDSTt3pcfIJEEeadRcPiPXWxqyJKXKrc3lyUdQg
	/oI36FyWw+LO3Wr/kg33z1QwwQmXmift2EvYvBz0gUW5AEzz+Mt248wTWkipqIsLDJEUvlW+J0VAT
	bkiaoKeQIb6yXU21LDe/CvBK1enMQwwOboxoLzUJxLlv17ImM/HIKT6ids9lXVWLgC256fpqhhy5d
	Nnusltgw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57594)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qY9Pi-0000NZ-2A;
	Mon, 21 Aug 2023 19:14:06 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qY9Pg-0004zN-Bn; Mon, 21 Aug 2023 19:14:04 +0100
Date: Mon, 21 Aug 2023 19:14:04 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Camelia Groza <camelia.groza@nxp.com>, Li Yang <leoyang.li@nxp.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor@kernel.org>,
	Sean Anderson <sean.anderson@seco.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [RFC PATCH net-next 2/8] phy: introduce the
 PHY_MODE_ETHERNET_PHY mode for phy_set_mode_ext()
Message-ID: <ZOOpbBX7MoZ0s1L/@shell.armlinux.org.uk>
References: <20230817150644.3605105-1-vladimir.oltean@nxp.com>
 <20230817150644.3605105-3-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817150644.3605105-3-vladimir.oltean@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 17, 2023 at 06:06:38PM +0300, Vladimir Oltean wrote:
> As opposed to PHY_MODE_ETHERNET which takes a phy_interface_t as is
> expected to be used by an Ethernet MAC driver, PHY_MODE_ETHERNET takes
> an enum ethtool_link_mode_bit_indices and expects to be used by an
> Ethernet PHY driver.

This doesn't seem to be correct. I think one of your PHY_MODE_ETHERNET
above should be PHY_MODE_ETHERNET_PHY - but maybe instead it should
be PHY_MODE_ETHTOOL so that it's clearly different and doesn't get
confused with PHY_MODE_ETHERNET ?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

