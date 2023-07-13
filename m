Return-Path: <netdev+bounces-17430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D577518C9
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 08:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CDE9281BFA
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 06:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A9F366;
	Thu, 13 Jul 2023 06:31:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E665694
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 06:31:08 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B6F12E
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 23:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MQfjjMpqp7jEqgrQCjtU6VfkjlrDkn+UAqPM/menHHk=; b=jenrW412yHYlCAv1XIv0vICcPa
	jT8blcKIHfMoN90Xu7ShDFEbrWHtCbPrFvFOqjzxKYnFIXZfEDFmKGuOzoP6WqiseBVjowm8szpcS
	lLAz2Y7Mk8wLhqsGOhdFn1Vo9D9u6bQj8Bmg0+3AQpJziVtQxJNQg/J2C7mlN0745yhS9JjP8qkf1
	HJdDdsJ6+VXBvLY2YlAF8VOw7GuXvfoFC5M2B37e0J5SJU6wlIi4wqEModPonUfbhc0RFgvRsenIV
	2DPeT3cK2oK15OoDNKqHuixk3k+N2wbu1o5sCXDQTM2jnz3Vuz01nzMFOUsvm77t2/0kpl7OY2TeX
	uL4yxxfg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47516)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qJpqw-0005k4-2S;
	Thu, 13 Jul 2023 07:31:02 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qJpqv-0005sp-6Q; Thu, 13 Jul 2023 07:31:01 +0100
Date: Thu, 13 Jul 2023 07:31:01 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, francesco.dolcini@toradex.com
Subject: Re: [PATCH v1 2/2] net: phy: marvell-88q2xxx: add driver for the
 Marvell 88Q2110 PHY
Message-ID: <ZK+aJXDe5tNr4R8m@shell.armlinux.org.uk>
References: <20230703124440.391970-1-eichest@gmail.com>
 <20230703124440.391970-3-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703124440.391970-3-eichest@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 03, 2023 at 02:44:40PM +0200, Stefan Eichenberger wrote:
> +static int check_link(struct phy_device *phydev)
> +{
> +	u16 ret1, ret2;
> +
> +	if (phydev->speed == SPEED_1000) {
> +		ret1 = phy_read_mmd(phydev, 3, 0x0901);
> +		ret1 = phy_read_mmd(phydev, 3, 0x0901);

This looks like some kind of BMSR register, where the link status
latches on failure until the following read. By reading the register
twice, you are discarding the information that the link _had_ failed
since we last read it. You don't want to do that - it could come up with
different parameters and because the link to phylib appears to remain
up, it won't respond to the new link parameters.

Always report the latched link status, not the current status.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

