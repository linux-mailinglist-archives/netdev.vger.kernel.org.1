Return-Path: <netdev+bounces-12956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B1F73994D
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 10:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D802D1C21061
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 08:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F52215AD2;
	Thu, 22 Jun 2023 08:20:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044A211CBD
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 08:20:55 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0741BFA
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 01:20:38 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qCFYT-0001SS-Ec; Thu, 22 Jun 2023 10:20:37 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1qCFYR-009EKs-6t; Thu, 22 Jun 2023 10:20:35 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1qCFYQ-00CwHO-63; Thu, 22 Jun 2023 10:20:34 +0200
Date: Thu, 22 Jun 2023 10:20:34 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Corinna Vinschen <vinschen@redhat.com>
Cc: netdev@vger.kernel.org, Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	alexandre.torgue@foss.st.com, Jose Abreu <joabreu@synopsys.com>
Subject: Re: [PATCH net-next] net: stmmac: propagate feature flags to vlan
Message-ID: <ZJQEUglereuvBp1E@pengutronix.de>
References: <20230411130028.136250-1-vinschen@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230411130028.136250-1-vinschen@redhat.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Corinna,

this patch breaks netboot on PRTT1C. Reverting this patch make it works again.
Here is a boot log with reverted patch:
root@prtt1c:~ dmesg | grep -e "\(ether\|sja\)"
[    2.523153] sja1105 spi0.0: Probed switch chip: SJA1105Q
[    2.534541] stm32-dwmac 5800a000.ethernet: IRQ eth_wake_irq not found
[    2.539678] stm32-dwmac 5800a000.ethernet: IRQ eth_lpi not found
[    2.564079] stm32-dwmac 5800a000.ethernet: User ID: 0x40, Synopsys ID: 0x42
[    2.569726] stm32-dwmac 5800a000.ethernet:   DWMAC4/5
[    2.582496] stm32-dwmac 5800a000.ethernet: DMA HW capability register supported
[    2.588415] stm32-dwmac 5800a000.ethernet: RX Checksum Offload Engine supported
[    2.612482] stm32-dwmac 5800a000.ethernet: TX Checksum insertion supported
[    2.617992] stm32-dwmac 5800a000.ethernet: Wake-Up On Lan supported
[    2.632481] stm32-dwmac 5800a000.ethernet: TSO supported
[    2.636369] stm32-dwmac 5800a000.ethernet: Enable RX Mitigation via HW Watchdog Timer
[    2.662493] stm32-dwmac 5800a000.ethernet: Enabled L3L4 Flow TC (entries=2)
[    2.668109] stm32-dwmac 5800a000.ethernet: Enabled RFS Flow TC (entries=10)
[    2.682494] stm32-dwmac 5800a000.ethernet: TSO feature enabled
[    2.686993] stm32-dwmac 5800a000.ethernet: Using 32/32 bits DMA host/device width
[    3.513207] sja1105 spi0.0: Probed switch chip: SJA1105Q
[    3.536541] stm32-dwmac 5800a000.ethernet eth0: Only single VLAN ID supported
[    3.544291] stm32-dwmac 5800a000.ethernet eth0: Only single VLAN ID supported
[    3.551823] stm32-dwmac 5800a000.ethernet eth0: Only single VLAN ID supported
[    3.559610] sja1105 spi0.0: configuring for fixed/rmii link mode
[    3.565608] sja1105 spi0.0: Link is Up - 100Mbps/Full - flow control off
[    3.575253] sja1105 spi0.0 t1l0 (uninitialized): PHY [gpio-0:06] driver [TI DP83TD510E] (irq=31)
[    3.594168] sja1105 spi0.0 t1l1 (uninitialized): PHY [gpio-0:07] driver [TI DP83TD510E] (irq=32)
[    3.612244] sja1105 spi0.0 t1l2 (uninitialized): PHY [gpio-0:0a] driver [TI DP83TD510E] (irq=33)
[    3.715610] sja1105 spi0.0 rj45 (uninitialized): PHY [gpio-0:02] driver [Micrel KSZ9031 Gigabit PHY] (irq=34)
[    3.729040] stm32-dwmac 5800a000.ethernet eth0: entered promiscuous mode
[    3.860011] stm32-dwmac 5800a000.ethernet eth0: Register MEM_TYPE_PAGE_POOL RxQ-0
[    3.876544] stm32-dwmac 5800a000.ethernet eth0: No Safety Features support found
[    4.084884] stm32-dwmac 5800a000.ethernet eth0: IEEE 1588-2008 Advanced Timestamp supported
[    4.092530] stm32-dwmac 5800a000.ethernet eth0: registered PTP clock
[    4.099997] stm32-dwmac 5800a000.ethernet eth0: configuring for fixed/rmii link mode
[    4.106645] stm32-dwmac 5800a000.ethernet eth0: Link is Up - 100Mbps/Full - flow control off
[    4.120533] stm32-dwmac 5800a000.ethernet eth0: Adding VLAN ID 0 is not supported
[    4.129557] sja1105 spi0.0 t1l0: configuring for phy/rmii link mode
[    4.143546] sja1105 spi0.0 t1l1: configuring for phy/rmii link mode
[    4.161097] sja1105 spi0.0 t1l2: configuring for phy/rmii link mode
[    4.167342] sja1105 spi0.0 rj45: configuring for phy/rgmii-id link mode
[    9.809396] sja1105 spi0.0 rj45: Link is Up - 1Gbps/Full - flow control off
[   66.587255] sja1105 spi0.0 t1l0: entered allmulticast mode
[   66.605179] stm32-dwmac 5800a000.ethernet eth0: entered allmulticast mode
[   66.624612] sja1105 spi0.0 t1l0: entered promiscuous mode
[   66.676943] sja1105 spi0.0 t1l1: entered allmulticast mode
[   66.700590] sja1105 spi0.0 t1l1: entered promiscuous mode
[   66.762670] sja1105 spi0.0 t1l2: entered allmulticast mode
[   66.782927] sja1105 spi0.0 t1l2: entered promiscuous mode
[   66.921089] sja1105 spi0.0 t1l0: configuring for phy/rmii link mode
[   66.951074] sja1105 spi0.0 t1l1: configuring for phy/rmii link mode
[   67.008160] sja1105 spi0.0 t1l2: configuring for phy/rmii link mode
[   68.557994] sja1105 spi0.0 t1l1: Link is Up - 10Mbps/Full - flow control off
[   93.820549] sja1105 spi0.0 t1l1: Link is Down
[   94.412697] sja1105 spi0.0 t1l1: Link is Up - 10Mbps/Full - flow control off
[   94.445096] stm32-dwmac 5800a000.ethernet eth0: Couldn't decode source port

Please tell me if you'll need help to debug this issue.

Regards,
Oleksij 

