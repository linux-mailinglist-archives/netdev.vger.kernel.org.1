Return-Path: <netdev+bounces-188775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7C1AAEC16
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 21:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6646F5242D9
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 19:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DDA28DF4F;
	Wed,  7 May 2025 19:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QEwDJvqt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F201F7586
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 19:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746645483; cv=none; b=o0zQERzL8nxvuJ18ZLY9jdSZemhJQWnwmz29soizdtN8nXAbi0I9PQnMLxikC7q7Hfs/PZ3jfjcoDjNnMDF8pPF22/UpD90ogb9eMvCPcuBXQvEe/tbxqKejG/zs4cRiw9VvJ109AeMPnbxF2FFYGuT9TBwIziAHvTZTmcYkZDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746645483; c=relaxed/simple;
	bh=ODCMUvEG0ho/UOqt4GCprPAE5Po/yJ9Ebr/LqODL77M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ddhorxu80XQ762v77DrRAz91U+WEFJGEawuV4dK41gjTtq63RfnNYmDVupEfVIg/0IKFo0CmkeIgXpBxhjcEOwZexBP6EMmTA38Hc0vlDlwWNqCzrlvOwpu1zvqroSP334Bm3ZqBlLJRyZMDKDxCvVV5mYmBAfevwR4fLZK6pcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QEwDJvqt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KRMTkMUgYrVX5hsdHR5SjVWo8FE8tPmtlzpM07WVNbI=; b=QEwDJvqt68+O+gxGWKcCc/NE+Y
	n4v6szGPUQ8U/RqEggrvofCvViwHqk40ve82Vcyj4oD88SWuYLpiaViL755N6a7P8oUHy8+jH+bEo
	LaUnPbwwQKQPrmEisEyyexTpHC44nnc+CupbxMA6JoULw4D5dK9fXn73KfH2cHTLK8to=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uCkHF-00BvP5-BK; Wed, 07 May 2025 21:17:57 +0200
Date: Wed, 7 May 2025 21:17:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Steve Broshar <steve@palmerwirelessmedtech.com>
Cc: Edward J Palmer <ed@palmerwirelessmedtech.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: request for help using mv88e6xxx switch driver
Message-ID: <86c1f4b8-8902-42ea-a3ae-9b0633f516ed@lunn.ch>
References: <20250507065116.353114-1-quic_wasimn@quicinc.com>
 <d87d203c-cd81-43c6-8731-00ff564bbf2f@lunn.ch>
 <IA1PR15MB6008DCCD2E42E0B17ACBC974B588A@IA1PR15MB6008.namprd15.prod.outlook.com>
 <0629bce6-f5eb-4c07-bff0-76003b383568@lunn.ch>
 <IA1PR15MB60080519243E5CCD694FCBD4B588A@IA1PR15MB6008.namprd15.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR15MB60080519243E5CCD694FCBD4B588A@IA1PR15MB6008.namprd15.prod.outlook.com>

On Wed, May 07, 2025 at 06:29:18PM +0000, Steve Broshar wrote:
> +Ed (hardware expert)
> 
> Ed, Do we have a direct MAC to MAC connection between the FEC and the Switch?
> 
> Following is the DT configuration which has a fixed-length node in the host port node. TBO some of these settings have been verified, but many are mysterious.
> 
> &fec1 {
> 	// [what is this? Does this tell the driver how to use the pins of pinctrl_fec1?]
> 	pinctrl-names = "default";
> 
> 	// ethernet pins
> 	pinctrl-0 = <&pinctrl_fec1>;
> 	
> 	// internal delay (id) required (in switch/phy not SOC MAC) [huh?]
> 	phy-mode = "rgmii-id";

You don't want both the FEC and the Switch MAC to insert the
delays. So one needs to be rgmii-id, and the other rgmii. I would
suggest the FEC does rgmii-id, but it does not really matter.

> 	// tried for for Compton, but didn't help with ethernet setup
> 	//phy-mode = "rgmii";
> 	
> 	// link to "phy" <=> cpu attached port of switch [huh?]
> 	// [is this needed? port 5 is linked to fec1. is this link also needed?]
> 	phy-handle = <&swp5>;

This is wrong, and the cause of your problems.

Copy/paste from the example i gave:

        fixed-link {
                speed = <1000>;
                full-duplex;
        };

The FEC driver expects there to be a PHY there to tell it what speed
to run the MAC at, once autoneg has completed. But since you don't
have a PHY, the simplest option is to emulate it. This creates an
emulated PHY which reports the link is running at 1G.

> 
> 	// try this here; probably not needed as is covered with reset-gpios for switch;
> 	// Seems like the wrong approach since get this msg at startup:
> 	// "Remove /soc@0/bus@30800000/ethernet@30be0000:phy-reset-gpios"
> 	//phy-reset-gpios = <&gpio2 10 GPIO_ACTIVE_LOW>;

No PHY, so you have nothing to reset.

> 	
> 	// enable Wake-on-LAN (WoL); aka/via magic packets
> 	fsl,magic-packet;

WoL probably does not work. The frames from the switch have an extra
header on the beginning, so i doubt the FEC is able decode them to
detect a WoL magic packet. If you need WoL, you need to do it in the
switch.

> 	// node enable
> 	status = "okay";
> 	
> 	// MDIO (aka SMI) bus
> 	mdio1: mdio {
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 
> 		// Marvell switch -- on Compton's base board
> 		// node doc: Documentation/devicetree/bindings/net/dsa/marvell.txt
> 		switch0: switch@0 {
> 			// used to find ID register, 6320 uses same position as 6085 [huh?]
> 			compatible = "marvell,mv88e6085";

Correct, but you know that already, the probe function detected the switch.

> 
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 
> 			// device address (0..31);
> 			// any value addresses the device on the base board since it's configured for single-chip mode;
> 			// and that is achieved by not connecting the ADDR[4:0] lines;
> 			// even though any value should work at the hardware level, the driver seems to want value 0 for single chip mode
> 			reg = <0>;
> 
> 			// reset line: GPIO2_IO10
> 			reset-gpios = <&gpio2 10 GPIO_ACTIVE_LOW>;
> 
> 			// don't specify member since no cluster [huh?]
> 			// from dsa.yaml: "A switch not part of [a] cluster (single device hanging off a CPU port) must not specify this property"
> 			// dsa,member = <0 0>;

This is all about the D in DSA. You can connect a number of switches
together into a cluster, and each needs its own unique ID.

> 
> 			// note: only list the ports that are physically connected; to be used
> 			// note: # for "port@#" and "reg=<#>" must match the physical port #
> 			// node doc: Documentation/devicetree/bindings/net/dsa/dsa.yaml
> 			// node doc: Documentation/devicetree/bindings/net/dsa/dsa-port.yaml
> 			ports {
> 				#address-cells = <1>;
> 				#size-cells = <0>;
> 
> 				// primary external port (PHY)
> 				port@3 {
> 					reg = <3>;
> 					label = "lan3";
> 				};
> 
> 				// secondary external port (PHY)
> 				port@4 {
> 					reg = <4>;
> 					label = "lan4";
> 				};
> 
> 				// connection to the SoC
> 				// note: must be in RGMII mode (which requires pins [what pins?] to be high on switch reset)
> 				swp5: port@5 {
> 					reg = <5>;
> 					
> 					// driver uses label="cpu" to identify the internal/SoC connection;
> 					// note: this label isn't visible in userland;
> 					// note: ifconfig reports a connection "eth0" which is the overall network connection; not this port per se
> 					label = "cpu";
> 					
> 					// link back to parent ethernet driver [why?]
> 					ethernet = <&fec1>;
> 					
> 					// media interface mode;
> 					// internal delay (id) is specified [why?]
> 					// Note: early driver versions didn't set [support?] id
> 					phy-mode = "rgmii-id";
> 					// tried for for Compton, but didn't help with ethernet setup
> 					//phy-mode = "rgmii";
> 
> 					// tried this; no "link is up" msg but otherwise the same result
> 					// managed = "in-band-status";

Managed is used for SGMII, 1000BaseX and other similar links which
have inband signalling. RGMII does not need it.

> 					
> 					// ensure a fixed link to the switch [huh?]
> 					fixed-link {
> 						speed = <1000>; // 1Gbps
> 						full-duplex;
> 					};
> 				};
> 			};
> 		};
> 	};
> };

The rest looks reasonable.

	Andrew

