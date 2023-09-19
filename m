Return-Path: <netdev+bounces-34935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDA57A60C1
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 13:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E77F01C20AEA
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 11:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0357E358AA;
	Tue, 19 Sep 2023 11:11:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42152E639
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 11:10:57 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2040.outbound.protection.outlook.com [40.107.96.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCA6A9
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 04:10:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NE2Crbdw1n8pJKCP9RJ8LZEQ7J6vsj6c0v1zs4LeVdkSFZaHqjRLUYDRgRf7RTkoQ2rvoerjaoI6e4H1SK/O61BtXTkdQomImxKJ5GsdhahcUQnKpdw+aVSCb9VQ5Az7AqnIqWpwrTb4h5oaxSvMSTQsEoo7egz+zE3ZbWO8a7uSve0TJqDaxRfFLUYOSL7iRIuXHYEBXGTah1/nRaHs2U3y7gfRGaSzD6dAKESKr10wHkU1vLUtmdXqk5LyjSylKIPrrIRw4ANY8PMykUDtc2VjNcn2nQei39b3IBHmSEtVSCEfjTzSqT53r6jRyuSaixYkV+d2xPaOOl80kULwtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DfgZEXymShqsAuZZFB5ywdTSithYFXeUmY6c4IOZX4=;
 b=duiddsqyfedNLVvALJs5JDoj41JYgfmt+JJfwnZBqudD0VOPnoPUws9AftO1iT9TeJIEye2X9JH6TIbkiOt73U2rXYerA4pe0dr7p2E+ou2Tu4TelAFhpd7bCigvfNgzXoawBVTV6rFlqODtrtAf44GcFm3Wl7xbvL00wb67YwkDW8b4ZBsPx8493Dw2Ck9PEAmbCTH6ZtU1HR5AFkVFvBdnFvK3//S6xIgk/tJ4u3SavpRq1f5rWeglcxX/pjdyU3UjRvGang0te3JyIFiMIX2xIPeR/lIIk8x4z/2byXqTxBK75Xw41kLvDddkwle14TPXTomZgJP2lK1Ve4AI7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DfgZEXymShqsAuZZFB5ywdTSithYFXeUmY6c4IOZX4=;
 b=y+Um2+D2pQVN05dYNHx2GYZWomcmbqUPHXOEKCliOMN2b6RzK9SVwoP14UiIsATiMk/Kl+8OBjyATxJ3itOqRUNQGl3REv45RQN3Wi/0sUJ887XitW2XFTWjTXEHLciafb3kPmwkRFK2yLdHjhmTwbX2wkKkiumB/KzzTG8Enl4=
Received: from BL1P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::34)
 by PH0PR12MB7907.namprd12.prod.outlook.com (2603:10b6:510:28d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 11:10:45 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::31) by BL1P223CA0029.outlook.office365.com
 (2603:10b6:208:2c4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Tue, 19 Sep 2023 11:10:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Tue, 19 Sep 2023 11:10:45 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 06:10:44 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Tue, 19 Sep 2023 06:10:44 -0500
Date: Tue, 19 Sep 2023 12:10:38 +0100
From: Martin Habets <martin.habets@amd.com>
To: <edward.cree@amd.com>
CC: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, Edward Cree
	<ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <andrew@lunn.ch>, <mw@semihalf.com>,
	<linux@armlinux.org.uk>, <sgoutham@marvell.com>, <gakula@marvell.com>,
	<sbhatta@marvell.com>, <hkelam@marvell.com>, <saeedm@nvidia.com>,
	<leon@kernel.org>
Subject: Re: [RFC PATCH v3 net-next 4/7] net: ethtool: let the core choose
 RSS context IDs
Message-ID: <20230919111038.GA25721@xcbmartinh41x.xilinx.com>
Mail-Followup-To: edward.cree@amd.com, linux-net-drivers@amd.com,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, Edward Cree <ecree.xilinx@gmail.com>,
	netdev@vger.kernel.org, habetsm.xilinx@gmail.com,
	sudheer.mogilappagari@intel.com, jdamato@fastly.com, andrew@lunn.ch,
	mw@semihalf.com, linux@armlinux.org.uk, sgoutham@marvell.com,
	gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
	saeedm@nvidia.com, leon@kernel.org
References: <cover.1694443665.git.ecree.xilinx@gmail.com>
 <b0de802241f4484d44379f9a990e69d67782948e.1694443665.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b0de802241f4484d44379f9a990e69d67782948e.1694443665.git.ecree.xilinx@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|PH0PR12MB7907:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c691212-15bc-43be-b5b4-08dbb901121f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LQFnQMB72mSM8512MtMA0LMlFW3nqea8CGfsIbFnK/++VjB+T8M5e/HU5hhRvUg3oCgvDlSfxQh3ckx3O986TO16rGw9p4dKJI9Nja1iqZbyvE4jRxvt4g61cBPLBkqGjeByFSmxm4inLlTzMjxxsRt/Y5RlhVrA7trNnptZzYMaZ7DbdrmM9sfZumVMoMWVcS7ZuFLweDTFjVIrG9wYXp5PqbHonXqGaLzgQZrx9TBA45visECAp8KbchPLsrqLU1NuKIDFPdzSR/TyysK2PFLEYqxanin08DBIIL9yUbdAlEEmyxcdMAwgJ506gZzt11unVJL3C+W6vyJsWBGm9ZmlDdVkZKTFJj1FfvEXGPof1YwM966Q0Zv22Oa9IZimn9dXfad3HugBz/oA6UJnmwXbXyU0qA78a5/xiAy4AakqCa1kP+ra1d50eTleJlVlv2xhTeW2UHPzflCMpVaWjn7S/p7zUAWgyKFedxZ2GZfD3Ssxo8SnAEO7LqsLDxwu1bP1VHnTsH/1CdRnvj25TPNyN8KXC98VJrRlhPasqabmmWV9l/Ghbj62hOONLnXFZTLDS09DQT53Tssiz7Di5G4+CgON+kANoZwWIrM7MlinRpigR3CVlScdzYgA/sPmCwCmeG39Mc9ybBsTZY2mroOgMYCROMfMp/thSdz4duCd+Kk3V9Dy9dt4hgVZi0mEvCbn5yHAqc0+JD2OD+oXA8KekX1AUlqzPu5ZBPXcrB0ph9pvS7eSPufa16UV3mEd8t55fKMggkXG59YJqiOUGw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(1800799009)(451199024)(186009)(82310400011)(46966006)(40470700004)(36840700001)(40480700001)(66899024)(40460700003)(336012)(426003)(83380400001)(9686003)(26005)(1076003)(47076005)(36860700001)(6636002)(316002)(41300700001)(7416002)(54906003)(70586007)(44832011)(70206006)(5660300002)(4326008)(8676002)(8936002)(6862004)(478600001)(6666004)(2906002)(86362001)(33656002)(82740400003)(356005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 11:10:45.2918
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c691212-15bc-43be-b5b4-08dbb901121f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7907
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 12, 2023 at 03:21:39PM +0100, edward.cree@amd.com wrote:
> 
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Add a new API to create/modify/remove RSS contexts, that passes in the
>  newly-chosen context ID (not as a pointer) rather than leaving the
>  driver to choose it on create.  Also pass in the ctx, allowing drivers
>  to easily use its private data area to store their hardware-specific
>  state.
> Keep the existing .set_rxfh_context API for now as a fallback, but
>  deprecate it.
> 
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
> ---
>  include/linux/ethtool.h | 40 ++++++++++++++++++++++++--
>  net/core/dev.c          | 11 +++++--
>  net/ethtool/ioctl.c     | 64 +++++++++++++++++++++++++++++++----------
>  3 files changed, 94 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index f7317b53ab61..4fa2a7f6ed4c 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -747,10 +747,33 @@ struct ethtool_mm_stats {
>   * @get_rxfh_context: Get the contents of the RX flow hash indirection table,
>   *	hash key, and/or hash function assiciated to the given rss context.
>   *	Returns a negative error code or zero.
> - * @set_rxfh_context: Create, remove and configure RSS contexts. Allows setting
> + * @create_rxfh_context: Create a new RSS context with the specified RX flow
> + *	hash indirection table, hash key, and hash function.
> + *	Arguments which are set to %NULL or zero will be populated to
> + *	appropriate defaults by the driver.
> + *	The &struct ethtool_rxfh_context for this context is passed in @ctx;
> + *	note that the indir table, hkey and hfunc are not yet populated as
> + *	of this call.  The driver does not need to update these; the core
> + *	will do so if this op succeeds.
> + *	If the driver provides this method, it must also provide
> + *	@modify_rxfh_context and @remove_rxfh_context.
> + *	Returns a negative error code or zero.
> + * @modify_rxfh_context: Reconfigure the specified RSS context.  Allows setting
>   *	the contents of the RX flow hash indirection table, hash key, and/or
> - *	hash function associated to the given context. Arguments which are set
> - *	to %NULL or zero will remain unchanged.
> + *	hash function associated with the given context.
> + *	Arguments which are set to %NULL or zero will remain unchanged.
> + *	The &struct ethtool_rxfh_context for this context is passed in @ctx;
> + *	note that it will still contain the *old* settings.  The driver does
> + *	not need to update these; the core will do so if this op succeeds.
> + *	Returns a negative error code or zero. An error code must be returned
> + *	if at least one unsupported change was requested.
> + * @remove_rxfh_context: Remove the specified RSS context.
> + *	The &struct ethtool_rxfh_context for this context is passed in @ctx.
> + *	Returns a negative error code or zero.
> + * @set_rxfh_context: Deprecated API to create, remove and configure RSS
> + *	contexts. Allows setting the contents of the RX flow hash indirection
> + *	table, hash key, and/or hash function associated to the given context.
> + *	Arguments which are set to %NULL or zero will remain unchanged.
>   *	Returns a negative error code or zero. An error code must be returned
>   *	if at least one unsupported change was requested.
>   * @get_channels: Get number of channels.
> @@ -901,6 +924,17 @@ struct ethtool_ops {
>  			    const u8 *key, const u8 hfunc);
>  	int	(*get_rxfh_context)(struct net_device *, u32 *indir, u8 *key,
>  				    u8 *hfunc, u32 rss_context);
> +	int	(*create_rxfh_context)(struct net_device *,
> +				       struct ethtool_rxfh_context *ctx,
> +				       const u32 *indir, const u8 *key,
> +				       const u8 hfunc, u32 rss_context);

To return the rss_context this creates shouldn't it use a pointer to
rss_context here?

Matin

> +	int	(*modify_rxfh_context)(struct net_device *,
> +				       struct ethtool_rxfh_context *ctx,
> +				       const u32 *indir, const u8 *key,
> +				       const u8 hfunc, u32 rss_context);
> +	int	(*remove_rxfh_context)(struct net_device *,
> +				       struct ethtool_rxfh_context *ctx,
> +				       u32 rss_context);
>  	int	(*set_rxfh_context)(struct net_device *, const u32 *indir,
>  				    const u8 *key, const u8 hfunc,
>  				    u32 *rss_context, bool delete);
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 4bbb6bda7b7e..6b8e5fd8691b 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -10860,15 +10860,20 @@ static void netdev_rss_contexts_free(struct net_device *dev)
>  	struct ethtool_rxfh_context *ctx;
>  	u32 context;
>  
> -	if (!dev->ethtool_ops->set_rxfh_context)
> +	if (!dev->ethtool_ops->create_rxfh_context &&
> +	    !dev->ethtool_ops->set_rxfh_context)
>  		return;
>  	idr_for_each_entry(&dev->ethtool->rss_ctx, ctx, context) {
>  		u32 *indir = ethtool_rxfh_context_indir(ctx);
>  		u8 *key = ethtool_rxfh_context_key(ctx);
>  
>  		idr_remove(&dev->ethtool->rss_ctx, context);
> -		dev->ethtool_ops->set_rxfh_context(dev, indir, key, ctx->hfunc,
> -						   &context, true);
> +		if (dev->ethtool_ops->create_rxfh_context)
> +			dev->ethtool_ops->remove_rxfh_context(dev, ctx, context);
> +		else
> +			dev->ethtool_ops->set_rxfh_context(dev, indir, key,
> +							   ctx->hfunc,
> +							   &context, true);
>  		kfree(ctx);
>  	}
>  }
> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index db596b61c6ab..4ce960a5ad4c 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -1274,7 +1274,8 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>  	if (rxfh.rsvd8[0] || rxfh.rsvd8[1] || rxfh.rsvd8[2] || rxfh.rsvd32)
>  		return -EINVAL;
>  	/* Most drivers don't handle rss_context, check it's 0 as well */
> -	if (rxfh.rss_context && !ops->set_rxfh_context)
> +	if (rxfh.rss_context && !(ops->create_rxfh_context ||
> +				  ops->set_rxfh_context))
>  		return -EOPNOTSUPP;
>  	create = rxfh.rss_context == ETH_RXFH_CONTEXT_ALLOC;
>  
> @@ -1349,8 +1350,28 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>  		}
>  		ctx->indir_size = dev_indir_size;
>  		ctx->key_size = dev_key_size;
> -		ctx->hfunc = rxfh.hfunc;
>  		ctx->priv_size = ops->rxfh_priv_size;
> +		/* Initialise to an empty context */
> +		ctx->indir_no_change = ctx->key_no_change = 1;
> +		ctx->hfunc = ETH_RSS_HASH_NO_CHANGE;
> +		if (ops->create_rxfh_context) {
> +			int ctx_id;
> +
> +			/* driver uses new API, core allocates ID */
> +			/* if rss_ctx_max_id is not specified (left as 0), it is
> +			 * treated as INT_MAX + 1 by idr_alloc
> +			 */
> +			ctx_id = idr_alloc(&dev->ethtool->rss_ctx, ctx, 1,
> +					   dev->ethtool->rss_ctx_max_id,
> +					   GFP_KERNEL_ACCOUNT);
> +			/* 0 is not allowed, so treat it like an error here */
> +			if (ctx_id <= 0) {
> +				kfree(ctx);
> +				ret = -ENOMEM;
> +				goto out;
> +			}
> +			rxfh.rss_context = ctx_id;
> +		}
>  	} else if (rxfh.rss_context) {
>  		ctx = idr_find(&dev->ethtool->rss_ctx, rxfh.rss_context);
>  		if (!ctx) {
> @@ -1359,15 +1380,34 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>  		}
>  	}
>  
> -	if (rxfh.rss_context)
> -		ret = ops->set_rxfh_context(dev, indir, hkey, rxfh.hfunc,
> -					    &rxfh.rss_context, delete);
> -	else
> +	if (rxfh.rss_context) {
> +		if (ops->create_rxfh_context) {
> +			if (create)
> +				ret = ops->create_rxfh_context(dev, ctx, indir,
> +							       hkey, rxfh.hfunc,
> +							       rxfh.rss_context);
> +			else if (delete)
> +				ret = ops->remove_rxfh_context(dev, ctx,
> +							       rxfh.rss_context);
> +			else
> +				ret = ops->modify_rxfh_context(dev, ctx, indir,
> +							       hkey, rxfh.hfunc,
> +							       rxfh.rss_context);
> +		} else {
> +			ret = ops->set_rxfh_context(dev, indir, hkey,
> +						    rxfh.hfunc,
> +						    &rxfh.rss_context, delete);
> +		}
> +	} else {
>  		ret = ops->set_rxfh(dev, indir, hkey, rxfh.hfunc);
> +	}
>  	if (ret) {
> -		if (create)
> +		if (create) {
>  			/* failed to create, free our new tracking entry */
> +			if (ops->create_rxfh_context)
> +				idr_remove(&dev->ethtool->rss_ctx, rxfh.rss_context);
>  			kfree(ctx);
> +		}
>  		goto out;
>  	}
>  
> @@ -1383,12 +1423,8 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>  			dev->priv_flags |= IFF_RXFH_CONFIGURED;
>  	}
>  	/* Update rss_ctx tracking */
> -	if (create) {
> -		/* Ideally this should happen before calling the driver,
> -		 * so that we can fail more cleanly; but we don't have the
> -		 * context ID until the driver picks it, so we have to
> -		 * wait until after.
> -		 */
> +	if (create && !ops->create_rxfh_context) {
> +		/* driver uses old API, it chose context ID */
>  		if (WARN_ON(idr_find(&dev->ethtool->rss_ctx, rxfh.rss_context))) {
>  			/* context ID reused, our tracking is screwed */
>  			kfree(ctx);
> @@ -1398,8 +1434,6 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>  		WARN_ON(idr_alloc(&dev->ethtool->rss_ctx, ctx, rxfh.rss_context,
>  				  rxfh.rss_context + 1, GFP_KERNEL) !=
>  			rxfh.rss_context);
> -		ctx->indir_no_change = rxfh.indir_size == ETH_RXFH_INDIR_NO_CHANGE;
> -		ctx->key_no_change = !rxfh.key_size;
>  	}
>  	if (delete) {
>  		WARN_ON(idr_remove(&dev->ethtool->rss_ctx, rxfh.rss_context) != ctx);

