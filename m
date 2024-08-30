Return-Path: <netdev+bounces-123670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB4D966100
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 13:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 246BAB2197A
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 11:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C2719994F;
	Fri, 30 Aug 2024 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vmxq71bK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132C8199942
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 11:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725018605; cv=none; b=oeN7KZJL+rlZS8sHJGi7GnyvQCILa3GdTYlcZIbK7EYBy/bnX896touOA55W4b1Y4/zPuOI2PyMziVmGqTuIw5Z+qQ7dL6jJxWhcL6FBKi1zm+yoJOdTAB/7Qy29VckHRRiYyxWg4EDT9cjGLBLwq6BLPaMpv/HA69+e01PvUQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725018605; c=relaxed/simple;
	bh=Qed3XyZGTldlw48fvJMz5k85Ns+BNjnw4jOmNBeFZrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EgQtbaauhIcbczmtpkdvgwP87U7rRCEUBlneHorYENuFZL093fSWxcMtE/XldtYLFumGWHbCe0pTDLEsVqGE2t56d4tXYWpgcctFOw3uxg8w8VNhC2skofTq3O6n3uw4hMgBZBLhg93Icd5u6Xt5B5JHGkLh9NW9HTGu/V3o21M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vmxq71bK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07610C4CEC2;
	Fri, 30 Aug 2024 11:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725018604;
	bh=Qed3XyZGTldlw48fvJMz5k85Ns+BNjnw4jOmNBeFZrs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vmxq71bKwnmDthLnf/Hu2X9pPTebwJzh+AizB1AjHOwBfIXx9wWTM71WkXEx9h0bZ
	 DIPSy8hL2cDuOAmnADK0Vw9vSrzfkHlNLKoRFCQeA54JAr/h5Ban8pGOi6fqUQmvma
	 YIEGbaSw6+SKHHGvK2JS8UhStBiUmZGsHpBm2+spuSuFAYl+DAVCEOGcC20Ut/1Web
	 y4ClaqIQ9IXvmg9bt5zQuTtxDTWXP9FBieIGeg3SRrbWhmeqCC/H4KcMD+KijiwKvB
	 IP4GnWpzNWRJp4xNYaqPVpryl1SCV5zRCOfhqOJYFgEbmyv8F8ChTiDQF/2Wrw566l
	 cqTjo6JyM+Z5Q==
Message-ID: <c8cad0e0-0ef9-4021-b5e5-742797a6c4ee@kernel.org>
Date: Fri, 30 Aug 2024 14:49:42 +0300
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
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 MD Danish Anwar <danishanwar@ti.com>, Linus Walleij <linusw@kernel.org>,
 Imre Kaloz <kaloz@openwrt.org>, Richard Cochran <richardcochran@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Carolina Jubran <cjubran@nvidia.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>
References: <20240829144253.122215-1-gal@nvidia.com>
 <20240829144253.122215-3-gal@nvidia.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240829144253.122215-3-gal@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29/08/2024 17:42, Gal Pressman wrote:
> The responsibility for reporting of RX software timestamp has moved to
> the core layer (see __ethtool_get_ts_info()), remove usage from the
> device drivers.
> 
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>


for:

drivers/net/ethernet/ti/am65-cpsw-ethtool.c
drivers/net/ethernet/ti/cpsw_ethtool.c
drivers/net/ethernet/ti/icssg/icssg_ethtool.c

Reviewed-by: Roger Quadros <rogerq@kernel.org>

