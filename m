Return-Path: <netdev+bounces-123486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BE29650B2
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 22:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C16141F22C51
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 20:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8101B78F6;
	Thu, 29 Aug 2024 20:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="gCFniR7/"
X-Original-To: netdev@vger.kernel.org
Received: from mx23lb.world4you.com (mx23lb.world4you.com [81.19.149.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BC9335C0
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 20:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724962996; cv=none; b=uxSZM497wufPGHTJWl6x3LCP8yhrzRj647HMKXUKORwRBzMAjB5hq9QhIU0Lx6ncnAHjXi9AEuTHls+I+eshdu73kfARo7jiwo+lgkktMvw+kNbxZXf1f2DukdCiLp8QN57Hm8p5XwKdE08i4okxtH/uH4gXX53jzZffCL7fWG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724962996; c=relaxed/simple;
	bh=a3vlx9TRyhHepjsX6RoGRJ/jeje7h1ocoKy+EYiiELw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dL1jd6CzDHiz2HzodKxh4QtOzaWZoAScrYqkREwJPfduwEi4jh4eRenKEM/UJRvCEkKBhaAOIO+OsxfRLAIUUd6OiI1RA6Y3cImnxTyjyn24b8lJn/ZRb9PuMdYwzkR5Cx4azZ5INslNM7QWpOkSMPpIhLtTttZ9HiPJ6o2jbYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=gCFniR7/; arc=none smtp.client-ip=81.19.149.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LT0BIIlDnb+3dvng+7tLkI+8CF4K0clugWJMO7uQ8cI=; b=gCFniR7/qX7MBpoSc7XW9Cg5Vr
	QEimjmRPSvBnxFHCLlNamZMLqHVB4vTlGxxQNY7VlDUCDJXEX0WC3fK2eIg0cnt6BNLgcfCMtqhkQ
	bg5fx9b+SN8fWDyv6gM6AYuOF3poOBDzpBRizU4osgidW3aO9MACcrmWnbjSIMOj6mII=;
Received: from [88.117.52.244] (helo=[10.0.0.160])
	by mx23lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1sjkhM-0001n3-0j;
	Thu, 29 Aug 2024 21:20:48 +0200
Message-ID: <b242917f-39d9-41df-9e65-ae648ea9c731@engleder-embedded.com>
Date: Thu, 29 Aug 2024 21:20:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: Remove setting of RX software timestamp
 from drivers
To: Gal Pressman <gal@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
 Andy Gospodarek <andy@greyhouse.net>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Sudarsana Kalluru <skalluru@marvell.com>, Manish Chopra
 <manishc@marvell.com>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Sunil Goutham <sgoutham@marvell.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>,
 Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>,
 Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 Dimitris Michailidis <dmichail@fungible.com>,
 Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta
 <salil.mehta@huawei.com>, Jijie Shao <shaojijie@huawei.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Geetha sowjanya <gakula@marvell.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Bryan Whitehead <bryan.whitehead@microchip.com>,
 UNGLinuxDriver@microchip.com, Horatiu Vultur <horatiu.vultur@microchip.com>,
 Lars Povlsen <lars.povlsen@microchip.com>,
 Steen Hegelund <Steen.Hegelund@microchip.com>,
 Daniel Machon <daniel.machon@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Shannon Nelson <shannon.nelson@amd.com>,
 Brett Creeley <brett.creeley@amd.com>, Sergey Shtylyov <s.shtylyov@omp.ru>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Edward Cree <ecree.xilinx@gmail.com>,
 Martin Habets <habetsm.xilinx@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
 MD Danish Anwar <danishanwar@ti.com>, Linus Walleij <linusw@kernel.org>,
 Imre Kaloz <kaloz@openwrt.org>, Richard Cochran <richardcochran@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Carolina Jubran <cjubran@nvidia.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>
References: <20240829144253.122215-1-gal@nvidia.com>
 <20240829144253.122215-3-gal@nvidia.com>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20240829144253.122215-3-gal@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 29.08.24 16:42, Gal Pressman wrote:
> The responsibility for reporting of RX software timestamp has moved to
> the core layer (see __ethtool_get_ts_info()), remove usage from the
> device drivers.
> 
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> ---
>   drivers/net/bonding/bond_main.c               |  3 ---
>   drivers/net/can/dev/dev.c                     |  3 ---
>   drivers/net/can/peak_canfd/peak_canfd.c       |  3 ---
>   drivers/net/can/usb/peak_usb/pcan_usb_core.c  |  3 ---
>   drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c  |  4 ----
>   .../ethernet/broadcom/bnx2x/bnx2x_ethtool.c   |  4 ----
>   .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  5 +----
>   drivers/net/ethernet/broadcom/tg3.c           |  6 +-----
>   drivers/net/ethernet/cadence/macb_main.c      |  5 ++---
>   .../ethernet/cavium/liquidio/lio_ethtool.c    | 16 +++++++--------
>   .../ethernet/cavium/thunder/nicvf_ethtool.c   |  2 --
>   .../ethernet/chelsio/cxgb4/cxgb4_ethtool.c    | 11 +++-------
>   .../net/ethernet/cisco/enic/enic_ethtool.c    |  4 +---
>   drivers/net/ethernet/engleder/tsnep_ethtool.c |  4 ----
>   .../ethernet/freescale/enetc/enetc_ethtool.c  | 10 ++--------
>   drivers/net/ethernet/freescale/fec_main.c     |  4 ----
>   .../net/ethernet/freescale/gianfar_ethtool.c  | 10 ++--------
>   .../ethernet/fungible/funeth/funeth_ethtool.c |  5 +----
>   .../hisilicon/hns3/hns3pf/hclge_ptp.c         |  4 ----
>   .../net/ethernet/intel/i40e/i40e_ethtool.c    |  4 ----
>   drivers/net/ethernet/intel/ice/ice_ethtool.c  |  2 --
>   drivers/net/ethernet/intel/igb/igb_ethtool.c  |  8 +-------
>   drivers/net/ethernet/intel/igc/igc_ethtool.c  |  4 ----
>   .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  4 ----
>   .../net/ethernet/marvell/mvpp2/mvpp2_main.c   |  2 --
>   .../marvell/octeontx2/nic/otx2_ethtool.c      |  2 --
>   .../net/ethernet/mellanox/mlxsw/spectrum.c    |  6 ++++++
>   .../ethernet/mellanox/mlxsw/spectrum_ptp.h    | 20 -------------------
>   .../net/ethernet/microchip/lan743x_ethtool.c  |  4 ----
>   .../microchip/lan966x/lan966x_ethtool.c       | 11 ++++------
>   .../microchip/sparx5/sparx5_ethtool.c         | 11 ++++------
>   drivers/net/ethernet/mscc/ocelot_ptp.c        | 12 ++++-------
>   .../ethernet/pensando/ionic/ionic_ethtool.c   |  2 --
>   drivers/net/ethernet/qlogic/qede/qede_ptp.c   |  9 +--------
>   drivers/net/ethernet/renesas/ravb_main.c      |  4 ++--
>   drivers/net/ethernet/renesas/rswitch.c        |  2 --
>   drivers/net/ethernet/renesas/rtsn.c           |  2 --
>   drivers/net/ethernet/sfc/ethtool.c            |  5 -----
>   drivers/net/ethernet/sfc/siena/ethtool.c      |  5 -----
>   .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  4 ++--
>   drivers/net/ethernet/ti/am65-cpsw-ethtool.c   |  2 --
>   drivers/net/ethernet/ti/cpsw_ethtool.c        |  7 +------
>   drivers/net/ethernet/ti/icssg/icssg_ethtool.c |  2 --
>   drivers/net/ethernet/ti/netcp_ethss.c         |  7 +------
>   drivers/net/ethernet/xscale/ixp4xx_eth.c      |  4 +---
>   drivers/ptp/ptp_ines.c                        |  4 ----
>   46 files changed, 47 insertions(+), 208 deletions(-)

Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com> # for 
drivers/net/ethernet/engleder

Thanks,
Gerhard

