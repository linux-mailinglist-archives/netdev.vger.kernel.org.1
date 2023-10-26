Return-Path: <netdev+bounces-44467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C06A97D8179
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 13:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B4BE281EA3
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 11:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0195B156E4;
	Thu, 26 Oct 2023 11:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Bc/0gUe3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74FE18022
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 11:03:47 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D17919D;
	Thu, 26 Oct 2023 04:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iHjiiSzkh9udigE4nIlVeYQ3C3Kg8K4ddmqM2Tzx13Y=; b=Bc/0gUe3r1WB9WvGs0MACOeio/
	SLQ/xrMpi/iphV7/amzWpASArGPm06mfRMUIudqH2aPusBpXP8j1o0NivSGNw0vcQEDbK4UzffY3+
	4qa+i7EmhS2/oBcW/auxn+0r5xSa1YUYH0qelqBYXMuSHAVgU8ng6MkB6cvm7Yujyp0B+3gvkyYjp
	W/bFrC51kVTSaYzqfyUb582LjNE1g6ykgx/Xy8bbYs2uKHzN3PnuGXrHo2OO+FRraZTs9ip4ZllQr
	Q4AL0TiPtVLegidEaRCXsk954uIssmiP1/vBP0xJQ5ku5j8Vzsy6VN/rtLsGq7NoQNqcbC8zZWMps
	Ou3JigHQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44196)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qvy9L-0006cz-2x;
	Thu, 26 Oct 2023 12:03:39 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qvy9L-00082m-TT; Thu, 26 Oct 2023 12:03:39 +0100
Date: Thu, 26 Oct 2023 12:03:39 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	linux-kernel@vger.kernel.org, andrew@lunn.ch,
	Jose.Abreu@synopsys.com, fancer.lancer@gmail.com,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next V2] net: pcs: xpcs: Add 2500BASE-X case in get
 state for XPCS drivers
Message-ID: <ZTpHi5YYmiQKpy1e@shell.armlinux.org.uk>
References: <20231026101642.3913-1-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026101642.3913-1-Raju.Lakkaraju@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Oct 26, 2023 at 03:46:42PM +0530, Raju Lakkaraju wrote:
> Add DW_2500BASEX case in xpcs_get_state( ) to update speed, duplex and pause
> 
> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>

Sorry for not doing a fuller review with the earlier iteration today.

Also, please note that on netdev, it's customary not to post more than
one version of a patch per day. Please see the netdev FAQ for guidance.

> +static int xpcs_get_state_2500basex(struct dw_xpcs *xpcs,
> +				    struct phylink_link_state *state)
> +{
> +	int sts;
> +
> +	sts = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_MMD_STS);

	if (sts < 0) {
		state->link = 0;
		return sts;
	}

especially as a negative errno value could result in state->link being
true.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

