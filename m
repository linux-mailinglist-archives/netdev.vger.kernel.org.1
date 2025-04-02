Return-Path: <netdev+bounces-178858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9E8A7938A
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 19:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23E4A16E59D
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 17:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7047318DF89;
	Wed,  2 Apr 2025 17:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7rjdukW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A66615350B
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 17:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743613241; cv=none; b=k1dB7Mhb4F3fbq4JmNfo3sfTus97JzST8bfkVJJUMOcKMtpHHiylMcrqNBTdIdP5mkcjSw+KaNuu9z4yJrn9tjrZXXUEBMtH0O7NJLOX7pm1UUxVWAf3zJuvjVUg+sa9aNGsg9o+RCePf+gvDnnBHug1QFFFvVdI/wNUm6jwn2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743613241; c=relaxed/simple;
	bh=if/TtBR+AlFwGU/YYCmLeS1V9RkcM4V+0zk3I3YaWFU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wb8XtdRQgDI+lHik1YDfry8xjXJq5KSL6U+L4BDWwTEwpcH5WAISMApSwAzCTBBQzlLAqY+Dbc0ZIaR7F7u7RdhZIpxCVaZT1KGwF7bwTEsvfwyHFWNykaNw7FCbSjr6Kjji78vXW54bf1U2dnox8Ty0BAImsJ5qEUYAD2DKju4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7rjdukW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB53BC4CEDD;
	Wed,  2 Apr 2025 17:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743613240;
	bh=if/TtBR+AlFwGU/YYCmLeS1V9RkcM4V+0zk3I3YaWFU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u7rjdukWSzUkakLjWo47ORoQkguMhEh2rF1SVIx1JEOZPrG0LH6u/eDCAZwddWQcB
	 Kpc80b22IjIpBT0FrYEj5ZiY9MguMrFQkvBULKA3m5qRYlLopjx+DVw4yNIlwbq/BP
	 SWoo6M9LPrulYwljujX3FDghxpXz7dfd3mN5cZI8XKGifFMLs9tL0acHuxFS3KT0eQ
	 ff1k9MSYSAd7SjGyfzJteq76uRzk+IyOUb0wScTOSYyGI7a0EpnQ5TcMN9BqPo9UcP
	 /wET+h/MMQbuIdU/orWCc1TM+8k8rW5Ub7payG3Bf3XUH6BB14GeiGlIjUEeqO3HjO
	 T6WRGsvAW0P1g==
Date: Wed, 2 Apr 2025 10:00:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "=?UTF-8?B?w4FsdmFybw==?= \"G. M.\"" <alvaro.gamez@hazent.com>
Cc: netdev@vger.kernel.org, Radhey Shyam Pandey
 <radhey.shyam.pandey@amd.com>
Subject: Re: Issue with AMD Xilinx AXI Ethernet (xilinx_axienet) on
 MicroBlaze: Packets only received after some buffer is full
Message-ID: <20250402100039.4cae8073@kernel.org>
In-Reply-To: <9a6e59fcc08cb1ada36aa01de6987ad9f6aaeaa4.camel@hazent.com>
References: <9a6e59fcc08cb1ada36aa01de6987ad9f6aaeaa4.camel@hazent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

+CC Radhey, maintainer of axienet

On Tue, 01 Apr 2025 12:52:15 +0200 =C3=81lvaro "G. M." wrote:
> Hello,
>=20
> I have a custom PCB board fitting a AMD/Xilinx Artix 7 FPGA with a Microb=
laze design
> inside that uses Xilinx' AXI 1G/2.5G Ethernet Subsystem connected via DMA.
>=20
> This board and HDL design have been tested and in production since 2016 u=
sing
> kernel 4.4.43 without any issue. The hardware part of the ethernet is DP8=
3620
> running in 100base-FX mode, which back in the day required a small patch =
to
> dp83848.c from myself that has been in the kernel since.
>=20
> I am now trying to upgrade to a recent kernel (v6.13) and I'm facing some=
 strange
> behavior of the ethernet system. The most probable cause is a misconfigur=
ation
> on my part of the device tree, since things have changed since then and I=
've found
> the device tree documentation confusing, but I can't discard some kind of=
 bug,
> for I have never seem something similar to this.
>=20
> Relevant boot messages:
>=20
> xilinx_axienet 40c00000.ethernet eth0: PHY [axienet-40c00000:01] driver [=
TI DP83620 10/100 Mbps PHY] (irq=3DPOLL)
> xilinx_axienet 40c00000.ethernet eth0: configuring for phy/mii link mode
> xilinx_axienet 40c00000.ethernet eth0: Link is Up - 100Mbps/Half - flow c=
ontrol off
>=20
> Now, transmission from the Microblaze seems to work fine, but reception h=
owever does not.
> I run tcpdump on the Microblaze and I can see that there's some kind of b=
uffering occuring,
> as a single ARP packet sent from my directly connected computer won't rea=
ch tcpdump unless
> I send also a big chunk of data via, for example, multicast, or after eno=
ugh time of ping flooding.
>=20
> It's not however a matter of sending a big chunk of data at the beginning=
, it seems like the
> buffer empties once full and the process starts back again, so a single p=
ing packet won't be
> received after the buffer has emptied.
>=20
> I can see that interrupts increase, but not as fast as they occur when us=
ing old kernel.
> For example, in the ping case, kernel 4.43 will notify that there was an =
interrupt
> for each single ping packet received with ping -c 1 (so no coalescing she=
nanigans can occur),
> but the new kernel won't show any increase in the number of interrupts, s=
o it means
> that the DMA core is either not generating the irq for some reason or isn=
't even
> executing the DMA transfer at all.
>=20
> Output packets, however, do seem to be sent expeditely and received in my=
 working computer
> as soon as I sent them from the Microblaze.
>=20
> I guess I may have made some mistake in upgrading the DTS to the new form=
at, although
> I've tried the two available methods (either setting node "dmas" or using=
 "axistream-connected"
> property) and both methods result in the same boot messages and behavior.
>=20
> By crafting properly sized UDP multicast packets (so I don't have to rely=
 on ARP which isn't
> working due to timeouts), I've been able to determine I need to send 1310=
72 bytes before
> reception can truly occur, although it somehow seems like sending multica=
st UDP
> packets won't trigger receiving IRQ unless I have a specific UDP listener=
 program running on
> the Microblaze. I'm quite confused about that too.
>=20
> So please, if anyone could inspect the DTS for me and/or guide me on how =
to debug this, I'd be grateful.
>=20
> These are the relevant parts of the DTS for kernel 6.13, which I've hand =
crafted with help
> from Documentation/devicetree/bindings and peeking at xilinx_axienet_main=
.c:
>=20
>=20
> axi_ethernet_0_dma: dma@41e00000 {
> 	compatible =3D "xlnx,axi-dma-1.00.a";
> 	#dma-cells =3D <1>;
> 	reg =3D <0x41e00000 0x10000>;
> 	interrupt-parent =3D <&microblaze_0_axi_intc>;
> 	interrupts =3D <7 1 8 1>;
> 	xlnx,addrwidth =3D <32>;
> 	xlnx,datawidth =3D <32>;
> 	xlnx,include-sg;
> 	xlnx,sg-length-width =3D <16>;
> 	xlnx,include-dre =3D <1>;
> 	xlnx,axistream-connected =3D <1>;
> 	xlnx,irq-delay =3D <1>;
> 	dma-channels =3D <2>;
> 	clock-names =3D "s_axi_lite_aclk", "m_axi_mm2s_aclk", "m_axi_s2mm_aclk",=
 "m_axi_sg_aclk";
> 	clocks =3D <&clk_bus_0>, <&clk_bus_0>, <&clk_bus_0>, <&clk_bus_0>;
> 	dma-channel@41e00000 {
> 		compatible =3D "xlnx,axi-dma-mm2s-channel";
> 		xlnx,include-dre =3D <1>;
> 		interrupts =3D <7 1>;
> 		xlnx,datawidth =3D <32>;
> 	};
> 	dma-channel@41e00030 {
> 		compatible =3D "xlnx,axi-dma-s2mm-channel";
> 		xlnx,include-dre =3D <1>;
> 		interrupts =3D <8 1>;
> 		xlnx,datawidth =3D <32>;
> 	};
> };
> axi_ethernet_eth: ethernet@40c00000 {
> 	compatible =3D "xlnx,axi-ethernet-1.00.a";
> 	reg =3D <0x40c00000 0x40000>, <0x41e00000 0x10000>;
> 	phy-handle =3D <&phy1>;
> 	xlnx,rxmem =3D <0x1000>;
> 	phy-mode =3D "mii";
> 	xlnx,txcsum =3D <0x2>;
> 	xlnx,rxcsum =3D <0x2>;
> 	clock-names =3D "s_axi_lite_clk", "axis_clk", "ref_clk", "mgt_clk";
> 	clocks =3D <&clk_bus_0>, <&clk_bus_0>, <&clk_bus_0>, <&clk_bus_0>;
> /*	axistream-connected =3D <&axi_ethernet_0_dma>; */
> 	dmas =3D <&axi_ethernet_0_dma 0>, <&axi_ethernet_0_dma 1>;
> 	dma-names =3D "tx_chan0", "rx_chan0";
> 	mdio {
> 		#address-cells =3D <1>;
> 		#size-cells =3D <0>;
> 		phy1: ethernet-phy@1 {
> 			device_type =3D "ethernet-phy";
> 			reg =3D <1>;
> 		};
> 	};
> };
>=20
>=20
> And these are same parts of the DTS for kernel 4.43 which worked fine.
> These were created with help from Xilinx tools.
>=20
> axi_ethernet_0_dma: dma@41e00000 {
> 	#dma-cells =3D <1>;
> 	compatible =3D "xlnx,axi-dma-1.00.a";
> 	interrupt-parent =3D <&microblaze_0_axi_intc>;
> 	interrupts =3D <7 1 8 1>;
> 	reg =3D <0x41e00000 0x10000>;
> 	xlnx,include-sg ;
> 	dma-channel@41e00000 {
> 		compatible =3D "xlnx,axi-dma-mm2s-channel";
> 		dma-channels =3D <0x1>;
> 		interrupts =3D <7 1>;
> 		xlnx,datawidth =3D <0x8>;
> 		xlnx,device-id =3D <0x0>;
> 	};
> 	dma-channel@41e00030 {
> 		compatible =3D "xlnx,axi-dma-s2mm-channel";
> 		dma-channels =3D <0x1>;
> 		interrupts =3D <8 1>;
> 		xlnx,datawidth =3D <0x8>;
> 		xlnx,device-id =3D <0x0>;
> 	};
> };
> axi_ethernet_eth: ethernet@40c00000 {
> 	axistream-connected =3D <&axi_ethernet_0_dma>;
> 	axistream-control-connected =3D <&axi_ethernet_0_dma>;
> 	clock-frequency =3D <83250000>;
> 	clocks =3D <&clk_bus_0>;
> 	compatible =3D "xlnx,axi-ethernet-1.00.a";
> 	device_type =3D "network";
> 	interrupt-parent =3D <&microblaze_0_axi_intc>;
> 	interrupts =3D <3 0>;
> 	phy-mode =3D "mii";
> 	reg =3D <0x40c00000 0x40000>;
> 	xlnx =3D <0x0>;
> 	xlnx,axiliteclkrate =3D <0x0>;
> 	xlnx,axisclkrate =3D <0x0>;
> 	xlnx,gt-type =3D <0x0>;
> 	xlnx,gtinex =3D <0x0>;
> 	xlnx,phy-type =3D <0x0>;
> 	xlnx,phyaddr =3D <0x1>;
> 	xlnx,rable =3D <0x0>;
> 	xlnx,rxcsum =3D <0x2>;
> 	xlnx,rxlane0-placement =3D <0x0>;
> 	xlnx,rxlane1-placement =3D <0x0>;
> 	xlnx,rxmem =3D <0x1000>;
> 	xlnx,rxnibblebitslice0used =3D <0x1>;
> 	xlnx,tx-in-upper-nibble =3D <0x1>;
> 	xlnx,txcsum =3D <0x2>;
> 	xlnx,txlane0-placement =3D <0x0>;
> 	xlnx,txlane1-placement =3D <0x0>;
> 	phy-handle =3D <&phy0>;
> 	axi_ethernetlite_0_mdio: mdio {
> 		#address-cells =3D <1>;
> 		#size-cells =3D <0>;
> 		phy0: phy@1 {
> 			device_type =3D "ethernet-phy";
> 			reg =3D <1>;
> 			ti,rx-internal-delay =3D <7>;
> 			ti,tx-internal-delay =3D <7>;
> 			ti,fifo-depth =3D <1>;
> 		};
> 	};
> };
>=20
>=20
>=20
> Best regards,
>=20


