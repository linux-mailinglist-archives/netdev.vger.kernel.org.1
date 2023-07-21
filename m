Return-Path: <netdev+bounces-19808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B86875C62E
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 13:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91AC2282214
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 11:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0521DDF0;
	Fri, 21 Jul 2023 11:57:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA5E3D75
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 11:57:04 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194EC2130;
	Fri, 21 Jul 2023 04:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DuaxoszqcDy6m6GIyAZxffUkYx6a4MOf8Tdr9C+qdMo=; b=PcDg7xHyCdW+6u3XgD5Oov1oGs
	VxmWWh6LQUoq/9BFjT4AjfSsFguIOoDOIrriM6RmIqeCRfv5aU5zSOlttG4Uddd+fwNxn+XX4pQ13
	TJ/pSp0UMKzAbHnNpG9nbSlQjXBH/ayqFEf5EhEX8/dWB1itFFvmBxWJ/aMV/hFJ3SS5YgWZ+0fxF
	zfK1JD7Py5UafUIAk9YPVXFvkqbdvt8ZzOtV/jMBBwKBgoVmVz5jLYi1oJHxnqCPjoVjfprZ+WPbw
	qhhBsqTC0606IfyTMKgNs1kFVXVhHXnOmYerT9KNIJymIhJJQURePa83r6a46I2KpTm+YeNcILBLv
	S6lKdyCA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48510)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qMokm-0003ry-2D;
	Fri, 21 Jul 2023 12:57:00 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qMokm-00066i-CJ; Fri, 21 Jul 2023 12:57:00 +0100
Date: Fri, 21 Jul 2023 12:57:00 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	linux-kernel@vger.kernel.org, bryan.whitehead@microchip.com,
	andrew@lunn.ch, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next 5/7] net: lan743x: Add support to the Phylink
 framework
Message-ID: <ZLpyjNJsQjOw2hfj@shell.armlinux.org.uk>
References: <20230721060019.2737-1-Raju.Lakkaraju@microchip.com>
 <20230721060019.2737-6-Raju.Lakkaraju@microchip.com>
 <ZLpGgV6FXmvjqeOi@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLpGgV6FXmvjqeOi@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 21, 2023 at 09:49:06AM +0100, Russell King (Oracle) wrote:
> On Fri, Jul 21, 2023 at 11:30:17AM +0530, Raju Lakkaraju wrote:
> > +static void lan743x_phylink_mac_config(struct phylink_config *config,
> > +				       unsigned int link_an_mode,
> > +				       const struct phylink_link_state *state)
> > +{
> > +	struct net_device *netdev = to_net_dev(config->dev);
> > +	struct lan743x_adapter *adapter = netdev_priv(netdev);
> > +	bool status;
> > +	int ret;
> > +
> > +	lan743x_mac_cfg_update(adapter, state->link, state->speed,
> > +			       state->advertising);
> 
> Please, no new state->speed users in mac_config().

I have just submitted a patch series that results in state->speed always
being set to SPEED_UNKNOWN when this function is called to prevent
future uses of this struct member.

> > +	adapter->phylink_config.dev = &netdev->dev;
> > +	adapter->phylink_config.type = PHYLINK_NETDEV;
> > +	adapter->phylink_config.mac_managed_pm = true;
> > +	/* This driver makes use of state->speed in mac_config */
> > +	adapter->phylink_config.legacy_pre_march2020 = true;
> 
> Sorry, but no new users of legacy features.

... and which totally strips out the legacy phylink code, which I've
been wanting to remove for the last three years.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

