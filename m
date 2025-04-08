Return-Path: <netdev+bounces-180345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61802A8104C
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CF1E500FD4
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 15:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18F01CCEE2;
	Tue,  8 Apr 2025 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TsxJD6OX"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEFB1E98ED
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 15:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744126426; cv=none; b=sT+3wm0unCQSYO2mwZuT9a84l61covgEEpT8PVM6vLXyX+bfuM1KjJDtcw7bwP3gu5DPNxzyFN736MXzF6zLGU3m5JLykGfmTs24xYSzaXrgjGJhEmEZR3uEAI/O63t3cObLtSnoqBYyxlaEbsKVuSTqhjwEwN4VFrYn2V7wCbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744126426; c=relaxed/simple;
	bh=IOmWyGqCggsFyUKU5QIW9V+iSwjMnJpXeraYlsyimUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i2gvYfZyzHu00zUHxKsRaTIf5XvNeG88qx8lOaB1wwB50m7vV/ttTHWcfjUGAlB7ymTvQGVO7Tl9rJke1GY1a1fNGSfDlC3yd5SQy+afgUarXlQfHZRWqHVLTE6OtgMDWsVdoXnNXyGGQmwpQjVADULUvv4k3ZvzjxT1vbssVnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TsxJD6OX; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b4626fc1-0e4a-4306-9b89-57bb0cea443d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744126422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UbnR/Yx6+S/ucqw+KvxItEEpP/udNhYI5Mpn+75jpdI=;
	b=TsxJD6OXGsMrUeMKz2rzK5y1cGKbuJ9CkV9KabVEfH0zmf3hFLua2xYw+Xt8QMM4LpiEfI
	pXY8+6qa/6lsECB5Hzz/E4VRhkaYn2GiRnOeeuaHHsUuqGAdeNqfnXWaZLDwYFclTjUb99
	fp2rFxjAxB3rERLDz29xdme4H5tlPMg=
Date: Tue, 8 Apr 2025 11:33:26 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next PATCH v2 11/14] net: axienet: Convert to use PCS
 subsystem
To: "Gupta, Suraj" <Suraj.Gupta2@amd.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
 "upstream@airoha.com" <upstream@airoha.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Simek, Michal" <michal.simek@amd.com>,
 "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
 Robert Hancock <robert.hancock@calian.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20250407231746.2316518-1-sean.anderson@linux.dev>
 <20250407232058.2317056-1-sean.anderson@linux.dev>
 <BL3PR12MB65713BB652BE4E0E3FAAEF7BC9B52@BL3PR12MB6571.namprd12.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <BL3PR12MB65713BB652BE4E0E3FAAEF7BC9B52@BL3PR12MB6571.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/8/25 08:19, Gupta, Suraj wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> -----Original Message-----
>> From: Sean Anderson <sean.anderson@linux.dev>
>> Sent: Tuesday, April 8, 2025 4:51 AM
>> To: netdev@vger.kernel.org; Andrew Lunn <andrew+netdev@lunn.ch>; David S .
>> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
>> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Russell King
>> <linux@armlinux.org.uk>
>> Cc: Heiner Kallweit <hkallweit1@gmail.com>; upstream@airoha.com; Kory
>> Maincent <kory.maincent@bootlin.com>; Christian Marangi
>> <ansuelsmth@gmail.com>; linux-kernel@vger.kernel.org; Simek, Michal
>> <michal.simek@amd.com>; Pandey, Radhey Shyam
>> <radhey.shyam.pandey@amd.com>; Robert Hancock
>> <robert.hancock@calian.com>; linux-arm-kernel@lists.infradead.org; Sean
>> Anderson <sean.anderson@linux.dev>
>> Subject: [net-next PATCH v2 11/14] net: axienet: Convert to use PCS subsystem
>>
>> Caution: This message originated from an External Source. Use proper caution
>> when opening attachments, clicking links, or responding.
>>
>>
>> Convert the AXI Ethernet driver to use the PCS subsystem, including the new Xilinx
>> PCA/PMA driver. Unfortunately, we must use a helper to work with bare MDIO
>> nodes without a compatible.
>>
> 
> AXI ethernet changes looks fine to me, except one minor nit mentioned below. Using DT changesets for backward compatibility is impressive :)
> I'll try reviewing pcs/pma patch also and test it with our setups.
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> 
> Reviewed-by: Suraj Gupta <suraj.gupta2@amd.com>
>> ---
>>
>> (no changes since v1)
>>
>>  drivers/net/ethernet/xilinx/Kconfig           |   1 +
>>  drivers/net/ethernet/xilinx/xilinx_axienet.h  |   4 +-
>>  .../net/ethernet/xilinx/xilinx_axienet_main.c | 104 ++++--------------
>>  drivers/net/pcs/Kconfig                       |   1 -
>>  4 files changed, 22 insertions(+), 88 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/xilinx/Kconfig b/drivers/net/ethernet/xilinx/Kconfig
>> index 7502214cc7d5..2eab64cf1646 100644
>> --- a/drivers/net/ethernet/xilinx/Kconfig
>> +++ b/drivers/net/ethernet/xilinx/Kconfig
>> @@ -27,6 +27,7 @@ config XILINX_AXI_EMAC
>>         tristate "Xilinx 10/100/1000 AXI Ethernet support"
>>         depends on HAS_IOMEM
>>         depends on XILINX_DMA
>> +       select OF_DYNAMIC if PCS_XILINX
>>         select PHYLINK
>>         select DIMLIB
>>         help
>> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h
>> b/drivers/net/ethernet/xilinx/xilinx_axienet.h
>> index 5ff742103beb..f46e862245eb 100644
>> --- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
>> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
>> @@ -473,7 +473,6 @@ struct skbuf_dma_descriptor {
>>   * @dev:       Pointer to device structure
>>   * @phylink:   Pointer to phylink instance
>>   * @phylink_config: phylink configuration settings
>> - * @pcs_phy:   Reference to PCS/PMA PHY if used
>>   * @pcs:       phylink pcs structure for PCS PHY
>>   * @switch_x_sgmii: Whether switchable 1000BaseX/SGMII mode is enabled in
>> the core
>>   * @axi_clk:   AXI4-Lite bus clock
>> @@ -553,8 +552,7 @@ struct axienet_local {
>>         struct phylink *phylink;
>>         struct phylink_config phylink_config;
>>
>> -       struct mdio_device *pcs_phy;
>> -       struct phylink_pcs pcs;
>> +       struct phylink_pcs *pcs;
>>
>>         bool switch_x_sgmii;
>>
>> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> index 054abf283ab3..07487c4b2141 100644
>> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> @@ -35,6 +35,8 @@
>>  #include <linux/platform_device.h>
>>  #include <linux/skbuff.h>
>>  #include <linux/math64.h>
>> +#include <linux/pcs.h>
>> +#include <linux/pcs-xilinx.h>
>>  #include <linux/phy.h>
>>  #include <linux/mii.h>
>>  #include <linux/ethtool.h>
>> @@ -2519,63 +2521,6 @@ static const struct ethtool_ops axienet_ethtool_ops = {
>>         .get_rmon_stats = axienet_ethtool_get_rmon_stats,  };
>>
>> -static struct axienet_local *pcs_to_axienet_local(struct phylink_pcs *pcs) -{
>> -       return container_of(pcs, struct axienet_local, pcs);
>> -}
>> -
>> -static void axienet_pcs_get_state(struct phylink_pcs *pcs,
>> -                                 unsigned int neg_mode,
>> -                                 struct phylink_link_state *state)
>> -{
>> -       struct mdio_device *pcs_phy = pcs_to_axienet_local(pcs)->pcs_phy;
>> -
>> -       phylink_mii_c22_pcs_get_state(pcs_phy, neg_mode, state);
>> -}
>> -
>> -static void axienet_pcs_an_restart(struct phylink_pcs *pcs) -{
>> -       struct mdio_device *pcs_phy = pcs_to_axienet_local(pcs)->pcs_phy;
>> -
>> -       phylink_mii_c22_pcs_an_restart(pcs_phy);
>> -}
>> -
>> -static int axienet_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
>> -                             phy_interface_t interface,
>> -                             const unsigned long *advertising,
>> -                             bool permit_pause_to_mac)
>> -{
>> -       struct mdio_device *pcs_phy = pcs_to_axienet_local(pcs)->pcs_phy;
>> -       struct net_device *ndev = pcs_to_axienet_local(pcs)->ndev;
>> -       struct axienet_local *lp = netdev_priv(ndev);
>> -       int ret;
>> -
>> -       if (lp->switch_x_sgmii) {
>> -               ret = mdiodev_write(pcs_phy, XLNX_MII_STD_SELECT_REG,
>> -                                   interface == PHY_INTERFACE_MODE_SGMII ?
>> -                                       XLNX_MII_STD_SELECT_SGMII : 0);
>> -               if (ret < 0) {
>> -                       netdev_warn(ndev,
>> -                                   "Failed to switch PHY interface: %d\n",
>> -                                   ret);
>> -                       return ret;
>> -               }
>> -       }
>> -
>> -       ret = phylink_mii_c22_pcs_config(pcs_phy, interface, advertising,
>> -                                        neg_mode);
>> -       if (ret < 0)
>> -               netdev_warn(ndev, "Failed to configure PCS: %d\n", ret);
>> -
>> -       return ret;
>> -}
>> -
>> -static const struct phylink_pcs_ops axienet_pcs_ops = {
>> -       .pcs_get_state = axienet_pcs_get_state,
>> -       .pcs_config = axienet_pcs_config,
>> -       .pcs_an_restart = axienet_pcs_an_restart,
>> -};
>> -
>>  static struct phylink_pcs *axienet_mac_select_pcs(struct phylink_config *config,
>>                                                   phy_interface_t interface)  { @@ -2583,8 +2528,8
>> @@ static struct phylink_pcs *axienet_mac_select_pcs(struct phylink_config
>> *config,
>>         struct axienet_local *lp = netdev_priv(ndev);
>>
>>         if (interface == PHY_INTERFACE_MODE_1000BASEX ||
>> -           interface ==  PHY_INTERFACE_MODE_SGMII)
>> -               return &lp->pcs;
>> +           interface == PHY_INTERFACE_MODE_SGMII)
> 
> nit: unchanged check.

Just fixing up the spacing while I was "in the area"

--Sean


