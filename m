Return-Path: <netdev+bounces-23303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E151A76B838
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 17:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B4B61C20F56
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 15:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949CA4DC83;
	Tue,  1 Aug 2023 15:07:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7A14DC6F
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 15:07:43 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2084.outbound.protection.outlook.com [40.107.105.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4915E65
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 08:07:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kolIt6A4g38AjO4MR1cCselJJfxwH2PwAKLp62SdeX8yS0CviSZfhZHGF02zDHO8zi4lonxIA6JzxS+jgCBXLFkE9oKuIXlB5gjScTHQ3fcA2zWfycGekwf8UltzMKfiANL0otrY9+1tuzoXTwqjM+7SWsXZEPP5dEE4ewLr24gP8w3JsX8MIcFsACV9qFU7arbcmnY4W2C7Xjukf5N7qgxFqh0WA46822DUU/exWXtlTEnX9xEnPyZZxs+0XY+kXskeIZy5ASr0NzwUo+GxmF5LddZcrTtrZG/JlCcjocO0/9Mfe1ats/b0X5RgDdp9NG5VS1LeakrYSF8UHjVYXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqPvmdkFEojunxJanalQSe9SnWH4iPD1al7tUzc5ELM=;
 b=iiIMt4ve9uFUCULPW8XteqdSyC39VUv51uuB2DQw0GXqetlbiyk40S7LSfVCdt5zSipwoa0+pDYpndu8/BdDAKIosEOxqEnLg/2H05Kp+VpWrwRB8mjjhONeJimctk6lkgWQQ9eRxXBgLYYpji3idi1rR7kELy14rGeusLqnkCfaXGLZvwpcCeMLk7Cou27IBJ74acD6xirRGuCrYisyeHBOY8jlc/wZoMCWe6W0ggZzHLtRIMWkqpZEnQnt4GRHtvJVBOwUIsC0b2y0+tUGgx1/5+lKnKR78R1bV19aKgnTTdmg4mKbtiSuvT6UjQbqChCZZ9LPF7XL/aKyIovRzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqPvmdkFEojunxJanalQSe9SnWH4iPD1al7tUzc5ELM=;
 b=h5IG3JAL/rbBTzH15Iw6dhQ67WBRY0AGUkS52+qaTgVRvXQxeDh/lOpHr7lXuCxh8rxNOgHhcox3fmqNiCVfUAY+vyYbeBgNgHjJGPEro0JBSFNvYTiDIxHfkSnaA1eMWUTfHLpuolmtnqHTLYqdnce1xJOZSiX6kOkkA48bCmw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DU2PR04MB8520.eurprd04.prod.outlook.com (2603:10a6:10:2d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Tue, 1 Aug
 2023 15:07:39 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 15:07:38 +0000
Date: Tue, 1 Aug 2023 18:07:35 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Sergei Antonov <saproj@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net] net: ftmac100: add multicast filtering possibility
Message-ID: <20230801150735.455ik2u3x353c6lj@skbuf>
References: <20230704154053.3475336-1-saproj@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704154053.3475336-1-saproj@gmail.com>
X-ClientProxiedBy: AM0PR05CA0076.eurprd05.prod.outlook.com
 (2603:10a6:208:136::16) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DU2PR04MB8520:EE_
X-MS-Office365-Filtering-Correlation-Id: 0453908e-990f-413c-bb1d-08db92a10bad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QceHYEfE4lCJwfSVwDmN+GIsqFxaMqKsJkCPgT0hNtg+vo/JoLanJyAvgqCGCkJB/kXj+MDo22/9tzto5c12J6/JIGZcs8EIF0+NP6PbkckSg/jNiDaLBDEB80Mlu8WgeUiHbd++Tv7dlcpwMHwg5sj7ZRYdyoSZ9XuanKsdP/spUsRRvSnfvSajcdcuS0yEWx78Uc20wvq0UxsGVIE0I8vIcvaYPnyoEUzeR3rUZHSRYPct89ldOxEju02WfQk2GB9m5F+ovFqLp1IZKBTiYIs9VxqH9i9jkAdD+7GiWIon2WuaCpS1b4q6nSa8H2LEnlT/M7FgUVyclzeWXcBlQvZYVsG9P4vAV6UCQ8gzKsloUGUpFzh2fZlolqB4vGi9Fpk74M3G1JgJgMVBmHdibFRzxOZSwIgVZVEswNmnY0Vr1kZ+yrNIw4uTDVMMfqlhNfVTENjNxDwmVtpw1ndcc0HxBwBU1pFgBDXDu+bw3GD9+3qLg+BpNBVNVji0rVWodKZTz8DzyeyiSUZKAWmY9n4uUdb6xfSyXdNRwmHm33ygAdOekzdFgSpnHpSqcW12
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(346002)(136003)(366004)(396003)(376002)(39860400002)(451199021)(38100700002)(33716001)(86362001)(6512007)(9686003)(478600001)(6666004)(44832011)(6486002)(186003)(26005)(1076003)(6506007)(8676002)(8936002)(5660300002)(6916009)(4326008)(66946007)(66476007)(2906002)(66556008)(41300700001)(316002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ss3K5s76wHFnz7gsKheuTx3IsmmTehXfKPS7+WpvkuVeqYAeExlaeIhlK16H?=
 =?us-ascii?Q?D5W6KdC7SXAt+IyzWYlGJJOACBx/hZ7ESBLLyH5Y52vDVrJx/PLmg+Ny8DYr?=
 =?us-ascii?Q?8AkSikIxioXumi30wW7RBdOQVhcZb4C2l3d5Fq376GLQiuiKgLTDH70MouJT?=
 =?us-ascii?Q?7HVK51qwuFIONS8FTRfy3mZrNc0sFYRDRK+DjOvcFvi0b/VZyu48GGYMTUH9?=
 =?us-ascii?Q?7OmuL8vDTocSWGIFuR4tXCng5CSmchmsOzpt74RiwRdikmKPpzHjgJx6PCe7?=
 =?us-ascii?Q?nBCGcJ4rnoednNmnU4P+BVivjkIdDQRAhc+nLsxNHgIrjc6jA0/Bfri7ehO+?=
 =?us-ascii?Q?9j+IGV7oMotFtxepQdvAzdG+Xus6KBrZ7oUsbXNvR11PKlyeGd00z9K24N2U?=
 =?us-ascii?Q?OmGXVdJ5JZBsEeqIIcMU3rxbVifGo9gHZ1laIcC0ZHKBnQZzd2rn3s6RT+Dh?=
 =?us-ascii?Q?rrbYCjHLaNDSaSAvgNx35MX6QWQdYqCFT4wZEiFqBDCdpQVwvPlBG26xkZkC?=
 =?us-ascii?Q?iePoZisgTysGFTIpwLq+i2ruSdKXNPa5HVlBAa4Vfz48lSDEHK8oL04ZDWny?=
 =?us-ascii?Q?EhXLl7b/VDXEbbg3eEtrnesJifb+I84HFMcvgSEQihXyaoNhTOXBvTCqnt3k?=
 =?us-ascii?Q?wxk1BGCBucmgj4ls3TkRktq200vUk84fMYMFsl25wHlPQjWkFSWEo0pjjxG9?=
 =?us-ascii?Q?IYTGetSTuiupQkjDC24w6wjTwk13DbHnXbwezYCjZTldZn8oFwujqfWymxct?=
 =?us-ascii?Q?Xzq7tpsR7p3IJGLTAXw4agrAr8PoRhhPZvcZ4mnfTCZuKYda/WRbjlKPg3z7?=
 =?us-ascii?Q?LSnjJqZxo1yMle7AgXNKBBSPaxsE3hnNWaxnMeOv6awJ45KxKkdIGu0sMRAb?=
 =?us-ascii?Q?sNnnyQ0HAN+BTL0uvYSnPMlOhhNlJD3uuE6lgSS/jnCOjKF3YRf8obKQ8DUa?=
 =?us-ascii?Q?cpyzCg58nxN4zkgU3C+a7I6eB2HPNrogfoRO6YY+M5oWNKRNe0zn6u+87e0o?=
 =?us-ascii?Q?9Gl6J/mDZxry8MUaQ6Lx7FrQjKA7IFT10Ovk8UVptG4Fpys7Wsga18H4I7sq?=
 =?us-ascii?Q?GbRDPKqLQEsEQODh8aExNxZ73NzRZUuLlaLd9WKDC2AR54xGiHNOC/NKAZcM?=
 =?us-ascii?Q?NMXQ8sF61/37Vxo0Vk5GBmbG2V4NghjTTks1GIGXHqcw3HpWft0Cr/cgDhEX?=
 =?us-ascii?Q?YyWzXhQZuOoLSEPhiqzSmXb5AAh43gs2b3Ya4xG3UbgoXMqyxG6QdjODUBod?=
 =?us-ascii?Q?dJJ/VbiNrfM984F0toFI7aUv9XixCk4GJ1P79Fs4YTygwxIIGOWiw29FsCDK?=
 =?us-ascii?Q?Vt+rb8MqVybkCYnC2kYDHJSXNONEJaIe0L2Nob1jQiEtFPaW5OFOaJ4/h5h4?=
 =?us-ascii?Q?eh0/OaE5UR8CV27aE/PcsvlIChsKgmQLBt7Joss7bFrQeRxmDgVCeXLxhtiU?=
 =?us-ascii?Q?6YM7Hsgi8kaNuqkCfN3T9SYTtmJIIMWVwYXYFrd1N2lZY0oixCyogZ6n1BNE?=
 =?us-ascii?Q?P5Mux302vhOW9EDAO2PspoXLmA4IaHtq0JAQQrLrUJwiqMvngFNzIrqm3IEf?=
 =?us-ascii?Q?kA1Gwdrj8HlEYVCH6bTkda7faWIMqK7i1g7JeWIDiC7/usE/jFn9LBcrtG9g?=
 =?us-ascii?Q?ig=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0453908e-990f-413c-bb1d-08db92a10bad
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 15:07:38.8908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23FbIkCB00IXOHT+a1twN5xz7AgfZJiXzbwRCItg0ngVfymnsddKEyYtygjtj1UQjfkX0/v/y/jnvlMIb3zWzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8520
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Sergei,

On Tue, Jul 04, 2023 at 06:40:53PM +0300, Sergei Antonov wrote:
> If netdev_mc_count() is not zero and not IFF_ALLMULTI, filter
> incoming multicast packets. The chip has a Multicast Address Hash Table
> for allowed multicast addresses, so we fill it.
> 
> This change is based on the analogous code from the ftgmac100 driver.
> Although the hashing algorithm is different.
> 
> Signed-off-by: Sergei Antonov <saproj@gmail.com>
> ---
>  drivers/net/ethernet/faraday/ftmac100.c | 39 +++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/net/ethernet/faraday/ftmac100.c b/drivers/net/ethernet/faraday/ftmac100.c
> index 139fe66f8bcd..0ecc0a319520 100644
> --- a/drivers/net/ethernet/faraday/ftmac100.c
> +++ b/drivers/net/ethernet/faraday/ftmac100.c
> @@ -149,6 +149,25 @@ static void ftmac100_set_mac(struct ftmac100 *priv, const unsigned char *mac)
>  	iowrite32(laddr, priv->base + FTMAC100_OFFSET_MAC_LADR);
>  }
>  
> +static void ftmac100_setup_mc_ht(struct ftmac100 *priv)
> +{
> +	u32 maht0 = 0; /* Multicast Address Hash Table bits 31:0 */
> +	u32 maht1 = 0; /* ... bits 63:32 */
> +	struct netdev_hw_addr *ha;
> +
> +	netdev_for_each_mc_addr(ha, priv->netdev) {
> +		u32 hash = ~ether_crc_le(ETH_ALEN, ha->addr) >> 26;
> +
> +		if (hash >= 32)
> +			maht1 |= 1 << (hash - 32);
> +		else
> +			maht0 |= 1 << hash;
> +	}
> +
> +	iowrite32(maht0, priv->base + FTMAC100_OFFSET_MAHT0);
> +	iowrite32(maht1, priv->base + FTMAC100_OFFSET_MAHT1);
> +}

Maybe it would look a bit better to remove the if/else like this?

static void ftmac100_setup_mc_ht(struct ftmac100 *priv)
{
	struct netdev_hw_addr *ha;
	u64 maht = 0;

	netdev_for_each_mc_addr(ha, priv->netdev) {
		u32 hash = ~ether_crc_le(ETH_ALEN, ha->addr) >> 26;

		maht |= BIT_ULL(hash);
	}

	iowrite32(lower_32_bits(maht), priv->base + FTMAC100_OFFSET_MAHT0);
	iowrite32(upper_32_bits(maht), priv->base + FTMAC100_OFFSET_MAHT1);
}

Not a huge difference.

You need to repost the patch to net-next anyway.

> +
>  #define MACCR_ENABLE_ALL	(FTMAC100_MACCR_XMT_EN	| \
>  				 FTMAC100_MACCR_RCV_EN	| \
>  				 FTMAC100_MACCR_XDMA_EN	| \
> @@ -187,6 +206,10 @@ static int ftmac100_start_hw(struct ftmac100 *priv)
>  		maccr |= FTMAC100_MACCR_RCV_ALL;
>  	if (netdev->flags & IFF_ALLMULTI)
>  		maccr |= FTMAC100_MACCR_RX_MULTIPKT;
> +	else if (netdev_mc_count(netdev)) {
> +		maccr |= FTMAC100_MACCR_HT_MULTI_EN;
> +		ftmac100_setup_mc_ht(priv);
> +	}
>  
>  	iowrite32(maccr, priv->base + FTMAC100_OFFSET_MACCR);
>  	return 0;
> @@ -1067,6 +1090,21 @@ static int ftmac100_change_mtu(struct net_device *netdev, int mtu)
>  	return 0;
>  }
>  
> +static void ftmac100_set_rx_mode(struct net_device *netdev)
> +{
> +	struct ftmac100 *priv = netdev_priv(netdev);
> +
> +	ftmac100_setup_mc_ht(priv);
> +
> +	if (netdev_mc_count(priv->netdev)) {
> +		unsigned int maccr = ioread32(priv->base + FTMAC100_OFFSET_MACCR);
> +
> +		/* Make sure multicast filtering is enabled */
> +		maccr |= FTMAC100_MACCR_HT_MULTI_EN;
> +		iowrite32(maccr, priv->base + FTMAC100_OFFSET_MACCR);
> +	}
> +}
> +
>  static const struct net_device_ops ftmac100_netdev_ops = {
>  	.ndo_open		= ftmac100_open,
>  	.ndo_stop		= ftmac100_stop,
> @@ -1075,6 +1113,7 @@ static const struct net_device_ops ftmac100_netdev_ops = {
>  	.ndo_validate_addr	= eth_validate_addr,
>  	.ndo_eth_ioctl		= ftmac100_do_ioctl,
>  	.ndo_change_mtu		= ftmac100_change_mtu,
> +	.ndo_set_rx_mode	= ftmac100_set_rx_mode,
>  };
>  
>  /******************************************************************************
> -- 
> 2.37.2
>

