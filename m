Return-Path: <netdev+bounces-131024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B8798C676
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 22:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 288121F25188
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF291CDFC7;
	Tue,  1 Oct 2024 20:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sPrrp6Oe"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC381CBE98;
	Tue,  1 Oct 2024 20:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727813256; cv=none; b=f7KvBADwjzXNBIfuWmlF/VjDOhOtX4WDY3lVeIWHLzClvYakDcad7qk0uS128hLUP1pKphVvhnsaQPdRg4/6AiYmOVXFBq95YJIzci1ZfA2p0NhQ7ef9RJA9DteXzE6VnHoyOWLO6aWbk6EXNm5HomWWo24mag2DvPBsC/Svhko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727813256; c=relaxed/simple;
	bh=RwlNbHbEggXjoUOJqdOh2JuBuCr/584bhOnSF2T317M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4uBInIRA/FieUxM8iPWrMA/luD5upfq8djkjGt17HYAX1chZvzK0koM2hkjlxp9bngfDUvTOb9mY95PPGXWPqkOyudxpSn/hHyhgUIPMQrJP109Gnlaan4YZyh9hPodMHkLLFL485qzAtdAoCr95zAQ+sHo4a+nE1KzR2zJfYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sPrrp6Oe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aaXdue1ZA7Ch185TFMrVveuH4KfcXYm2oKa4uAKPZV8=; b=sPrrp6OefCaCsCtsBGAyER+oCN
	MZLPVM8LiVivw5EbzY7Dbeeq/mtCncrngNoyVL5tPMxNK+gtziwzvn8QziwgRxkVczo7xHN+8Y4W0
	of1WUoiliHl9FvPJz6lvxYvqcX5TFGEM9RE3hDfQ14le9sZGtwhV/lNGZmEa8+v5kj+A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1svj9U-008lmx-Qm; Tue, 01 Oct 2024 22:07:20 +0200
Date: Tue, 1 Oct 2024 22:07:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: Saravana Kannan <saravanak@google.com>, Rob Herring <robh@kernel.org>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Serge Semin <fancer.lancer@gmail.com>, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFT] of: property: fw_devlink: Add support for the
 "phy-handle" binding
Message-ID: <5bded0f6-a49b-4606-b990-dc5aad360bf8@lunn.ch>
References: <20240930-phy-handle-fw-devlink-v1-1-4ea46acfcc12@redhat.com>
 <CAGETcx-z+Evd95QzhPePOf3=fZ7QUpWC2spA=q_ASyAfVHJD1A@mail.gmail.com>
 <rqn4kaogp2oukghm3hz7sbbvayj6aiflgbtoyk6mhxg4jss7ig@iv24my4iheij>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rqn4kaogp2oukghm3hz7sbbvayj6aiflgbtoyk6mhxg4jss7ig@iv24my4iheij>

> Let me see if I can hack something up on this board (which has a decent
> dependency tree for testing this stuff) to use the generic phy driver
> instead of the marvell one that it needs and see how that goes. It won't
> *actually* work from a phy perspective, but it will at least test out
> the driver core bits here I think.
> 
> > 
> > But like you said, it's been a while and fw_devlink has improved since
> > then (I think). So please go ahead and give this a shot. If you can
> > help fix any issues this highlights, I'd really appreciate it and I'd
> > be happy to guide you through what I think needs to happen. But I
> > don't think I have the time to fix it myself.
> 
> Sure, I tend to agree. Let me check the generic phy driver path for any
> issues and if that test seems to go okay I too am of the opinion that
> without any solid reasoning against this we enable it and battle through
> (revert and fix after the fact if necessary) any newly identified issues
> that prevent phy-handle and fw_devlink have with each other.

Here is one for you to look at:

https://elixir.bootlin.com/linux/v6.11.1/source/drivers/net/ethernet/freescale/fec_main.c#L2481

I don't know if there is a real issue here, but if the order of the
probe gets swapped, i think the usage of mii_cnt will break.

I don't remember what broke last time, and i'm currently too lazy to
go look. But maybe take a look at devices like this:

arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-b.dts

       mdio-mux {
                compatible = "mdio-mux-gpio";
                pinctrl-0 = <&pinctrl_mdio_mux>;
                pinctrl-names = "default";
                gpios = <&gpio0 8  GPIO_ACTIVE_HIGH
                         &gpio0 9  GPIO_ACTIVE_HIGH
                         &gpio0 24 GPIO_ACTIVE_HIGH
                         &gpio0 25 GPIO_ACTIVE_HIGH>;
                mdio-parent-bus = <&mdio1>;
                #address-cells = <1>;
                #size-cells = <0>;

                mdio_mux_1: mdio@1 {
                        reg = <1>;
                        #address-cells = <1>;
                        #size-cells = <0>;

                        switch0: switch@0 {
                                compatible = "marvell,mv88e6085";
                                pinctrl-0 = <&pinctrl_gpio_switch0>;
                                pinctrl-names = "default";
                                reg = <0>;
                                dsa,member = <0 0>;
                                interrupt-parent = <&gpio0>;
                                interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
                                interrupt-controller;
                                #interrupt-cells = <2>;
                                eeprom-length = <512>;

                                ports {
                                        #address-cells = <1>;
                                        #size-cells = <0>;

                                        port@0 {
                                                reg = <0>;
                                                label = "lan0";
                                                phy-handle = <&switch0phy0>;
                                        };

                                        port@1 {
                                                reg = <1>;
                                                label = "lan1";
                                                phy-handle = <&switch0phy1>;
                                        };

                                        port@2 {
                                                reg = <2>;
                                                label = "lan2";
                                                phy-handle = <&switch0phy2>;
                                        };

                                        switch0port5: port@5 {
                                                reg = <5>;
                                                label = "dsa";
                                                phy-mode = "rgmii-txid";
                                                link = <&switch1port6
                                                        &switch2port9>;
                                                fixed-link {
                                                        speed = <1000>;
                                                        full-duplex;
                                                };
                                        };

                                        port@6 {
                                                reg = <6>;
                                                phy-mode = "rmii";
                                                ethernet = <&fec1>;

                                                fixed-link {
                                                        speed = <100>;
                                                        full-duplex;
                                                };
                                        };
                                };
                                mdio {
                                        #address-cells = <1>;
                                        #size-cells = <0>;
                                        switch0phy0: switch0phy0@0 {
                                                reg = <0>;
                                                interrupt-parent = <&switch0>;
                                                interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
                                        };
                                        switch0phy1: switch1phy0@1 {
                                                reg = <1>;
                                                interrupt-parent = <&switch0>;
                                                interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
                                        };
                                        switch0phy2: switch1phy0@2 {
                                                reg = <2>;
                                                interrupt-parent = <&switch0>;
                                                interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
                                        };
                                };
                        };
                };


This would be an example of circular dependencies, with the interrupt
properties closing the loop.

switch -> mdio -> phy
 ^                |
 |----------------+

	Andrew

