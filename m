Return-Path: <netdev+bounces-25821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B722A775E8A
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 14:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7E2B1C21227
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 12:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07051800E;
	Wed,  9 Aug 2023 12:11:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C542F1775C
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 12:11:09 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C16DF
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 05:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BHfAfYDvl52gBluTEu0fefAp0orhe6Z5cHGzDaZsl9U=; b=h9I41x5zMk4UleygEVCXcb/1BD
	Pu+fy3QvMe5Pwvfk4JsY+BgDYuKdgv2vOyeYKQlzg/4eJdRSILukNwl5Fn6R1eLxu/ZMzsWVc2sqf
	3brZUonHBJ64+hRu/GpYCdSyWkMmGG0v6ZQg8BG+k8f8IPZPC2Qi/oHHR4YkOcWiNsoBdJDhNl1LS
	eA3A/gN3DBR1hTlJT1gWSoUqJ/xYGfv3YiGzUPveZnDYP28wfTs/2C/2pYuh1ozDiozr9QP34R0ox
	w9oyDWmPDilI1GbZnmcDiN0PuVqOicSisdK/UMG14SLPVQDE6j9HJKVclNIH6aCn+BO+BHfwdcQZ4
	2kP935XA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46016)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qTi1o-0002T5-1Y;
	Wed, 09 Aug 2023 13:11:04 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qTi1o-0000iv-Bc; Wed, 09 Aug 2023 13:11:04 +0100
Date: Wed, 9 Aug 2023 13:11:04 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sergei Antonov <saproj@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org
Subject: Re: Regression: supported_interfaces filling enforcement
Message-ID: <ZNOCWDEyZUAIiA6R@shell.armlinux.org.uk>
References: <CABikg9wM0f5cjYY0EV_i3cMT2JcUT1bSe_kkiYk0wFwMrTo8=w@mail.gmail.com>
 <20230710123556.gufuowtkre652fdp@skbuf>
 <CABikg9zfGVEJsWf7eq=K5oKQozt86LLn-rzMaVmycekXkQEa8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABikg9zfGVEJsWf7eq=K5oKQozt86LLn-rzMaVmycekXkQEa8Q@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 05:35:35PM +0300, Sergei Antonov wrote:
> &mdio1 {
>         status = "okay";
> 
>         #address-cells = <1>;
>         #size-cells = <0>;
> 
>         switch@10 {
>                 compatible = "marvell,mv88e6060";
>                 reg = <0x10>;
> 
>                 ports {
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> 
>                         port@0 {
>                                 reg = <0>;
>                                 label = "lan2";
>                         };
> 
>                         port@1 {
>                                 reg = <1>;
>                                 label = "lan3";
>                         };
> 
>                         port@2 {
>                                 reg = <2>;
>                                 label = "lan1";
>                         };
> 
>                         port@5 {
>                                 reg = <5>;
>                                 label = "cpu";
>                                 ethernet = <&mac1>;
>                                 phy-mode = "mii";

While looking at the datasheet for this switch, it supports SNI,
MII MAC (mii), MII PHY (revmii), and RMII PHY (revrmii) modes.

Is your port 5 actually configured for "revmii" rather than "mii"?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

