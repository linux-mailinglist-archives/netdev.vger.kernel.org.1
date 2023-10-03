Return-Path: <netdev+bounces-37652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA637B67BF
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 13:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B254A2816F6
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 11:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1404B21357;
	Tue,  3 Oct 2023 11:19:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D230421111;
	Tue,  3 Oct 2023 11:19:55 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7955DA7;
	Tue,  3 Oct 2023 04:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3WQtsnIMGU3EZC75/U7lh4It7npmOBkHEQvs4xM/XDs=; b=aavn7HoNfrpw9SVa81FqPKDf4a
	rkJiu/tRdgeUXh/cuL2QtIkZcKvjWiTqq6en38DvV2HNkpAykI5bBM0o2MrVZg2wlYpofS28FmgFO
	MxVyVfaulb+pQ/XkcZwVzIBHI7sWOr+S885g77Cxh/MOzpB+lEDpPqmX/YiUyh8FcMJddBxgR83cB
	jFKMebHrdXPTpyhZT7C+36PB3yMyeM9zL424iBQNgW2PtEkfOdGL42Q3WlHXKSMZWauNr/EQtqkd0
	p27nqbQEV3fORj6PVCRrtAlbayUFDamfgr9F2RtFvthe1dzG6Sxq5DmxuxShJQrCvW3kQs3G2bUfa
	TAdgqKSg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47706)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qndRO-0001ak-2X;
	Tue, 03 Oct 2023 12:19:50 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qndRP-0007px-9b; Tue, 03 Oct 2023 12:19:51 +0100
Date: Tue, 3 Oct 2023 12:19:51 +0100
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
Subject: Re: [RFC PATCH v2 net-next 05/15] net: add 25GBase-KR-S and
 25GBase-CR-S to ethtool link mode UAPI
Message-ID: <ZRv4162uJ9pUVpR6@shell.armlinux.org.uk>
References: <20230923134904.3627402-1-vladimir.oltean@nxp.com>
 <20230923134904.3627402-6-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230923134904.3627402-6-vladimir.oltean@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Sep 23, 2023 at 04:48:54PM +0300, Vladimir Oltean wrote:
> diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
> index f7fba0dc87e5..421eb57fb6e9 100644
> --- a/include/uapi/linux/ethtool.h
> +++ b/include/uapi/linux/ethtool.h
> @@ -1787,6 +1787,8 @@ enum ethtool_link_mode_bit_indices {
>  	ETHTOOL_LINK_MODE_10baseT1S_Full_BIT		 = 99,
>  	ETHTOOL_LINK_MODE_10baseT1S_Half_BIT		 = 100,
>  	ETHTOOL_LINK_MODE_10baseT1S_P2MP_Half_BIT	 = 101,
> +	ETHTOOL_LINK_MODE_25000baseCR_S_Full_BIT	 = 102,
> +	ETHTOOL_LINK_MODE_25000baseKR_S_Full_BIT	 = 103,

Should these also be add to phylink_caps_to_linkmodes()'s MAC_25000FD
conditional block?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

