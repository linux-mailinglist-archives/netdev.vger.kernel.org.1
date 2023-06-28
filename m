Return-Path: <netdev+bounces-14427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6DF741268
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 15:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B7401C203DB
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 13:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF02C13D;
	Wed, 28 Jun 2023 13:30:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD675C12E
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 13:30:54 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA4D210E;
	Wed, 28 Jun 2023 06:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sKh6zDOKfcXILtdwj1/RN9k2PEHDDi7d4S8zYhsSan4=; b=NnDelXQrssBUgeRU8U85pRC1RL
	pz0RquRgb3fby7Sk9eOhOAUOCfaOAfIHzVsxYHh95RbHpdkE5ERQOdVJGYwnOQiTLwEqWQX4U2G8m
	GJiyKzvpG0UbimPwDcX4vnrQVbMoJ/BX56DTsIdYMxXzB5Ya+WDQTb7Hnxtkwq36iXT0zsfFtbtWU
	4E1SySEItkD+pmdFYPse1+QWR717BfKEKYJfIzbItFhBLdubAe7HEBLfEkpKjOOsJjPokNZcpGiwO
	dyvuAEJfH6lay/XBhfLw3c9Sehpdy/RoEg4M+Svaaw233fO1hwvUKWdobfT3qQ1FPLntNF6BoDrbw
	mCIe4bww==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33896)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qEVFx-0007WO-2L;
	Wed, 28 Jun 2023 14:30:49 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qEVFw-0006nc-Ia; Wed, 28 Jun 2023 14:30:48 +0100
Date: Wed, 28 Jun 2023 14:30:48 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Revanth Kumar Uppala <ruppala@nvidia.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, netdev@vger.kernel.org,
	linux-tegra@vger.kernel.org, Narayan Reddy <narayanr@nvidia.com>
Subject: Re: [PATCH 1/4] net: phy: aquantia: Enable Tx/Rx pause frame support
 in aquantia PHY
Message-ID: <ZJw2CKtgqbRU/3Z6@shell.armlinux.org.uk>
References: <20230628124326.55732-1-ruppala@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628124326.55732-1-ruppala@nvidia.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 28, 2023 at 06:13:23PM +0530, Revanth Kumar Uppala wrote:
> From: Narayan Reddy <narayanr@nvidia.com>
> 
> Enable flow control support using pause frames in aquantia phy driver.
> 
> Signed-off-by: Narayan Reddy <narayanr@nvidia.com>
> Signed-off-by: Revanth Kumar Uppala <ruppala@nvidia.com>

I think this is over-complex.

>  #define MDIO_PHYXS_VEND_IF_STATUS		0xe812
>  #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_MASK	GENMASK(7, 3)
>  #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_KR	0
> @@ -583,6 +585,17 @@ static int aqr107_config_init(struct phy_device *phydev)
>  	if (!ret)
>  		aqr107_chip_info(phydev);
>  
> +	/* Advertize flow control */
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, phydev->supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, phydev->supported);
> +	linkmode_copy(phydev->advertising, phydev->supported);

This is the wrong place to be doing this, since pause support depends
not only on the PHY but also on the MAC. There are phylib interfaces
that MACs should call so that phylib knows that the MAC supports pause
frames.

Secondly, the PHY driver needs to tell phylib that the PHY supports
pause frames, and that's done through either setting the .features
member in the PHY driver, or by providing a .get_features
implementation.

Configuration of the pause advertisement should already be happening
through the core phylib code.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

