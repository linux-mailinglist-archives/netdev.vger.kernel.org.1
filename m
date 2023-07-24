Return-Path: <netdev+bounces-20379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD9B75F3AB
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 12:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C96B1C2093D
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 10:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAA64C95;
	Mon, 24 Jul 2023 10:43:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEE21871
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 10:43:25 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7528F5
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 03:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4tUdLVREmL6LoOiggGr4jH9ahPWIFp0vqZV4+UiIga0=; b=1dx94oXaEqon7iRS0gviFEi/Mg
	1JSwAyZdeKaPEIzMo1u2CHjK8jD50WPyc4E6hjUNFjTBkSSzfvwq8XF0RmIqGfN6wqEzKGzIdurhz
	FmNLI3hUBfKR8QcmdAubSfHgjB/hkZvIWzUMMXcM20ecNU7ddFCxLUEWivXyd/SVypdkP0NylsHMM
	LT9Rscjma/XOkjgejknstlRw8helpwxS/xnXYoCTBaaSUSjmycw9vAvqFkse2PdxgV9IOM5mZmkAA
	fFcY8xibTZbmrSJMzeOB/YwmspyKmZqXuC3emm/9sWfN7oXLpF2rSGbGZO/sdfUB2GXv+mgCVU59j
	l5ZUk4WA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58636)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qNt29-0008LK-0x;
	Mon, 24 Jul 2023 11:43:21 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qNt28-0000jO-VX; Mon, 24 Jul 2023 11:43:20 +0100
Date: Mon, 24 Jul 2023 11:43:20 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	Jose.Abreu@synopsys.com, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 6/7] net: txgbe: support copper NIC with
 external PHY
Message-ID: <ZL5VyBb9cUTq/y3Y@shell.armlinux.org.uk>
References: <20230724102341.10401-1-jiawenwu@trustnetic.com>
 <20230724102341.10401-7-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724102341.10401-7-jiawenwu@trustnetic.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 06:23:40PM +0800, Jiawen Wu wrote:
> @@ -22,6 +25,9 @@ static int txgbe_get_link_ksettings(struct net_device *netdev,
>  {
>  	struct txgbe *txgbe = netdev_to_txgbe(netdev);
>  
> +	if (txgbe->wx->media_type == sp_media_copper)
> +		return phy_ethtool_get_link_ksettings(netdev, cmd);

Why? If a PHY is attached via phylink, then phylink will automatically
forward the call below to phylib.
> +
>  	return phylink_ethtool_ksettings_get(txgbe->phylink, cmd);

If you implement it correctly, you also don't need two entirely
separate paths to configure the MAC/PCS for the results of the PHY's
negotiation, because phylink gives you a _generic_ set of interfaces
between whatever is downstream from the MAC and the MAC.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

