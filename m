Return-Path: <netdev+bounces-20727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C140760C95
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 10:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A66BE28162B
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 08:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC8E134AA;
	Tue, 25 Jul 2023 08:02:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBF3125A5
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 08:02:55 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBDA128
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 01:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=j40/N9rkEiikPmoWmeVXUUwGa7PjZ9By9zurzN8T7c8=; b=ksUWv8dvEKeLX9vLbPRPuwGpAu
	UW1rr/yWw22C74C39pM20gdbB6VxqBNq/GYY+JZyZpwhv5jgJwP/UDvCMwq+ee/Lzwh9xeZXUipSn
	mf1IhIXNduKw/I0w2YvJ3Y0DtLvRAMw8tzA34IfXKopumjcpOqxa5nOQxBDcvulLWHe9RXAGSF7Ha
	L6r6H5YGUssyA7qA2mQ43rp4ISCFEMm0GW7x9eltvLRaznuDBiYTtImjYB2dplO1kFAQ0qvemgEZK
	EFfX3A8Yx8C2nmQ06RO72C3GAxS4QvVC1osNuHtVPwbSLQVJGPk+FapjPmsX+AJLnI1B9Nx0eia9g
	Mjbko8AA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54156)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qOD0L-0001gk-0J;
	Tue, 25 Jul 2023 09:02:49 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qOD0J-0001e8-B8; Tue, 25 Jul 2023 09:02:47 +0100
Date: Tue, 25 Jul 2023 09:02:47 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	Jose.Abreu@synopsys.com, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 6/7] net: txgbe: support copper NIC with
 external PHY
Message-ID: <ZL+Bpxn8O3PRMv0p@shell.armlinux.org.uk>
References: <20230724102341.10401-1-jiawenwu@trustnetic.com>
 <20230724102341.10401-7-jiawenwu@trustnetic.com>
 <ZL5VyBb9cUTq/y3Y@shell.armlinux.org.uk>
 <03d201d9bea1$8dc4d740$a94e85c0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03d201d9bea1$8dc4d740$a94e85c0$@trustnetic.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 10:41:46AM +0800, Jiawen Wu wrote:
> On Monday, July 24, 2023 6:43 PM, Russell King (Oracle) wrote:
> > On Mon, Jul 24, 2023 at 06:23:40PM +0800, Jiawen Wu wrote:
> > > @@ -22,6 +25,9 @@ static int txgbe_get_link_ksettings(struct net_device *netdev,
> > >  {
> > >  	struct txgbe *txgbe = netdev_to_txgbe(netdev);
> > >
> > > +	if (txgbe->wx->media_type == sp_media_copper)
> > > +		return phy_ethtool_get_link_ksettings(netdev, cmd);
> > 
> > Why? If a PHY is attached via phylink, then phylink will automatically
> > forward the call below to phylib.
> 
> No, there is no phylink implemented for sp_media_copper.
> 
> > > +
> > >  	return phylink_ethtool_ksettings_get(txgbe->phylink, cmd);
> > 
> > If you implement it correctly, you also don't need two entirely
> > separate paths to configure the MAC/PCS for the results of the PHY's
> > negotiation, because phylink gives you a _generic_ set of interfaces
> > between whatever is downstream from the MAC and the MAC.
> 
> For sp_media_copper, only mii bus is registered for attaching PHY.
> Most MAC/PCS configuration is done in firmware, so it is not necessary
> to implement phylink as sp_media_fiber.

If you do implement phylink for copper, then you don't need all these
conditionals and the additional adjust_link implementation. In other
words, you can re-use a lot of the code you've already added.

You don't have to provide a PCS to phylink provided you don't tell
phylink that it's "in-band".

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

