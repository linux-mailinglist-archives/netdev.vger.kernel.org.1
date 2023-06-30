Return-Path: <netdev+bounces-14874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56497744310
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 22:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B8FA1C20832
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 20:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A02617742;
	Fri, 30 Jun 2023 20:10:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6892A17737
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 20:10:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2139.outbound.protection.outlook.com [40.107.223.139])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C024AB7
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 13:10:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYd5vNOgajeSBBQGf9meJ/HYk0nzOlmt2r9nnYBGLg8/rKBe1/SU3JSi0YNFR3NaO3X2ZYsYxngKdRHwLwgT5kWpCWGFPo1w6SKOIMg1e8vfwR05pscxd/ww4msXJrptKmDuMYJ8qlj2/wk7BKUCBe8ToZdYKT1r9zN6zr03tzs5Bot0ilpMUaxFYSRNOxpJzYu/mjjQgPZ/l0WPh4O/3CmK+xG2IhVnxzrIfOuOzq4ldeOqAC3XQH5ly6BRCrrv8nXXl2At4nSVkF620nMd1bFmH07Inymp4Xs0CpB3faxBffncwMgAMh62ps8jJGX4mX0+UOjOVvvizoID0pnSdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+olwgrOZZRnEshAymYWxbBCCAN7e6xtN4fPKaFMg70=;
 b=HBeenyMI+QNKqxwZBDymcdTTFlnYJzsaBubka6Zb+G/7V9iqbs2tW3q9q4dgj+qm4lmsZ2B4EZJjurOZobNzejOveX/dMuRdxJK/zCLilzng2b+g23Xlbuvk/ihK5dTo46hRQlviMlilc2GxRntvfEWVpJbh9Rh2xf+p5PILJbHE12iOgUlLZOkB/daGvaToPU5ojjsYSJQTY9tYvZrbMGkBpeIwcwMVvJRN1u1ML+z6w9lI3a3JmEXFSZVFHyZxkqXAlPqFDbN3uqKl4YfjLMVizCGw3Yf9p7LDcJQ9sQ3jz1Y5d77f1HpS5BU6SYUdt9WJ5aL1PzzlkcmV+W8sDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+olwgrOZZRnEshAymYWxbBCCAN7e6xtN4fPKaFMg70=;
 b=igjeUJxEJLktUiARX5RlVdQWowv6cKCzG11iz06aJhQnMse1t5tHSqDXfSYJNnR57QOqZF4bFnWBT9FtT0e9iDsKaGfRRR7gkwP3zc9IF2lcvvyg3cdC4y5O6BCILqgXF3p45uZVx9YQvuXJ2eNx09UqW+RpLfGvAt7UsRV6BvA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by DM6PR13MB3804.namprd13.prod.outlook.com (2603:10b6:5:245::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 20:10:23 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 20:10:23 +0000
Date: Fri, 30 Jun 2023 22:10:16 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Sandipan Patra <spatra@nvidia.com>
Subject: Re: [net 5/9] net/mlx5: Register a unique thermal zone per device
Message-ID: <ZJ82qDAL92tQh1dV@corigine.com>
References: <20230630181544.82958-1-saeed@kernel.org>
 <20230630181544.82958-6-saeed@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630181544.82958-6-saeed@kernel.org>
X-ClientProxiedBy: AM0P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::32) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|DM6PR13MB3804:EE_
X-MS-Office365-Filtering-Correlation-Id: aa66ec3b-ecec-4e60-879c-08db79a60925
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HSrQX8lmT/nEwf6qLtHu0ALcazzf6MK6/FFVSAyEeFqJzTJ9akcyO4v8f9OKE4YwNBhaQLbZ4rUStoFbHotwxf9Ctbw2JkmKW1FxbWG0iMOYo4fGf1OHaKYCkGbvNN/mv0c6lxIKUn2WXqMjBqp4vq6gHIefrdLxNfdv1U05MpKma15Ci5tXVLMxI6szGGFdSWn96tTYNTlwECytdUk+ugHaI9WkdcESmftBRIdir5W5lobh43DDJM9N+zYXeSEtIHpSJiTUgUbLeCSGfPMx11rKOUGf4gfSRP60E3I160wpBW6ZS5zBmXmGHv5G1N/At+ELPr685cOEoV3BHrVB0ZQos7wH5t3/HIOpQmz/mTS4f0yt13gDz7HyU3uqe7vbfEomS7oKqyG3eKDshAlVOMr5roRsF2wEm34HN52hUJflSblg8+bEW6wYmGfFxn6iGWOAUQ9wUr+woP16Z+o4ohV9QnGQpd8eo35udu4YcgTB3XJab+0zMBWHgWjQRS3RIwpzElnb0tNJuGCkfZtC5wEZ1Shp9pHksqDSrp5Ej84izf48DpbhOP8/i+JJmeTAspAHyfcFyNbxF5+Pk7YnbnEk/M/HMhgb5T0V669lYmA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39840400004)(346002)(366004)(396003)(451199021)(86362001)(54906003)(8936002)(8676002)(5660300002)(26005)(6506007)(44832011)(6486002)(478600001)(66556008)(66476007)(6916009)(4326008)(66946007)(6512007)(41300700001)(316002)(6666004)(186003)(2616005)(2906002)(83380400001)(36756003)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HGtvRT1GmGUknvpUigmgrxxOKrCv+Sw8c1nGIQsrpss/u9I0+6yb2vO795CU?=
 =?us-ascii?Q?XN+I/AoJSAUvgVETQFf7OlG6HACyKTlkBm2wOS+Ge6iKlg9rTrl8Ik7xI30B?=
 =?us-ascii?Q?wWZXC0moSBqqSIg5L7KfW6GOwbAMdAt6MyeP//OhIF1XxHPxqEyPVIBTxdHX?=
 =?us-ascii?Q?IWaPRJRX1SuRnN12+TXqWx+wyD6WjdozYACSLQmQFQdv253QLs2mLzBVJd8c?=
 =?us-ascii?Q?mAjrMvxlM2lZ7K5eAHw1OKfuq4H/FmZT8dpgexz7lLkT+C2b+FL7o0p57c63?=
 =?us-ascii?Q?BYYWzIoaH8P7ZTSKRI99zYuHUnscPM3vIjLblTCvGo8CDAVQvs0w+z3WNdwG?=
 =?us-ascii?Q?w0OISTIgQk1Uv11SzeK89HVwfcxV1nDNvywO+esll5lGIURIncRW6RvjlmFr?=
 =?us-ascii?Q?1Iq2wFDFBEbIqwZhzwiY16+MIEuHdmItGV0fdHxpRosKaawV8pe/zuMEmwA9?=
 =?us-ascii?Q?QVJfUIJGKie3O5nb61UAhO0zIQn7jfPOYhIxgGu4FMiIZJqsgcr5FbyM3No6?=
 =?us-ascii?Q?PVOLNFJgK0s+PXTV7RNBF5vEYzObm3cLNj6hw3Za+QzuUWRrOx+DIlxWcjnE?=
 =?us-ascii?Q?d6yYaBgCi+n56lyCzHmNUU2Oxeqgdy/wP/nmlgDmSJUc+CNndw5ZJXZVlepk?=
 =?us-ascii?Q?/XuhEqDjOJFEwxGGsUGV1uJNInJiSJHVLcrSjT9/73ODiC8wpytlTWGvIwOa?=
 =?us-ascii?Q?6Cdlu5BhWn2uRFiNNnJZ1btiHQobu/jHexQ9hpOy8YTUhR/UWmxg16wGhCPE?=
 =?us-ascii?Q?Ysk2CeN5pqHHjBKqkt6wQvDSa0V39+1Tz3Ya1KT00nrh5o/0/yk1hmGh8xRD?=
 =?us-ascii?Q?8XP2PNXqK9KUBKFVi6kb1JX5F0vJYCGkJTELi1r6VVV6xbodjBCdZuV+qj0R?=
 =?us-ascii?Q?lQwfomrU7/FgYy65din0PnqaBwMyEjeqyG+iLR3I5/OsIIzgC/bldHJLT65q?=
 =?us-ascii?Q?r+aBcfqUgsdrhQ005k1ddETxijgDNrtsEXxrRu+L2ehSoLsdWz5ngvwoeAcG?=
 =?us-ascii?Q?jKTwD89BlqHKTKLj5zMztBKmNZDXD1R9P64j8/ke3XflLQwLz/0qnUMQIDPv?=
 =?us-ascii?Q?qmgYnJXKKvHLxETmXkq4klXv2LFLNPSRu19Gu6a+rdfZ9x/iolNzOiERmrP9?=
 =?us-ascii?Q?kfsUtGU3gggXsTEQqzG18yM7Ig8PLGVIENKsqQf2uIBHhYmlsFRe73JL6MvZ?=
 =?us-ascii?Q?BxE8h3dltqCKHWUshLOxXrHBf1Y/579Saj2UXy7L0cBJWRXFB7ohbrOqwfA4?=
 =?us-ascii?Q?Qx4jWUCRilHoKwWKHilxTEwc8mvVt7iot0rBDyfyvHkE0Qw5V9c5O3zihii7?=
 =?us-ascii?Q?wc7YGKc5Amk8dxQT7dBiXcSvroJiDG/S0NZIsssAimYZTGFc9oycVFh/C+lY?=
 =?us-ascii?Q?QOrHDYL7A8ca9JIjuaedTM2PzjDmocUkENGO7QndTErcS4ilpln9JyrtptZx?=
 =?us-ascii?Q?j9Ksfg8tLtWdGY2qaHUVuIWAm/z9genXlJrLEQzfCk9qfZuppe6FTCgUldKu?=
 =?us-ascii?Q?Yu4CTTHQgf/alZtecSOWn/iuN2NgEzrehQWQ9rJRK+cpk345j6w5iizLfMbz?=
 =?us-ascii?Q?20RIrdGaziCS2BBvU2Pa3RbjIT806OOmVCLrKNs4aiHRyTeuZJ+IJ85XSB2O?=
 =?us-ascii?Q?OA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa66ec3b-ecec-4e60-879c-08db79a60925
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 20:10:23.0061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mIjrG/FMstP4n88yjGckF0cmBAeYsQUi8XFLtmRBkCIIq1LwMY+WmbvIywp60uG9bLjWKgV5+gHWtoBo2FTcx1mHVkf2Lo1iKWXxkL+JvKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3804
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 30, 2023 at 11:15:40AM -0700, Saeed Mahameed wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> Prior to this patch only one "mlx5" thermal zone could have been
> registered regardless of the number of individual mlx5 devices in the
> system.
> 
> To fix this setup a unique name per device to register its own thermal
> zone.
> 
> In order to not register a thermal zone for a virtual device (VF/SF) add
> a check for PF device type.
> 
> The new name is a concatenation between "mlx5_" and "<PCI_DEV_BDF>", which
> will also help associating a thermal zone with its PCI device.
> 
> $ lspci | grep ConnectX
> 00:04.0 Ethernet controller: Mellanox Technologies MT2892 Family [ConnectX-6 Dx]
> 00:05.0 Ethernet controller: Mellanox Technologies MT2892 Family [ConnectX-6 Dx]
> 
> $ cat /sys/devices/virtual/thermal/thermal_zone0/type
> mlx5_0000:00:04.0
> $ cat /sys/devices/virtual/thermal/thermal_zone1/type
> mlx5_0000:00:05.0
> 
> Fixes: c1fef618d611 ("net/mlx5: Implement thermal zone")
> CC: Sandipan Patra <spatra@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

...

> @@ -89,10 +94,10 @@ int mlx5_thermal_init(struct mlx5_core_dev *mdev)
>  								 &mlx5_thermal_ops,
>  								 NULL, 0, MLX5_THERMAL_POLL_INT_MSEC);
>  	if (IS_ERR(thermal->tzdev)) {
> -		dev_err(mdev->device, "Failed to register thermal zone device (%s) %ld\n",
> -			data, PTR_ERR(thermal->tzdev));
> +		err = PTR_ERR(thermal->tzdev);
> +		mlx5_core_err(mdev, "Failed to register thermal zone device (%s) %ld\n", data, err);

Hi Saeed,

unfortunately it seems that this breaks allmodconfig.

 drivers/net/ethernet/mellanox/mlx5/core/thermal.c:98:82: warning: format specifies type 'long' but the argument has type 'int' [-Wformat]
                 mlx5_core_err(mdev, "Failed to register thermal zone device (%s) %ld\n", data, err);
                                                                                  ~~~           ^~~
                                                                                  %d
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h:67:11: note: expanded from macro 'mlx5_core_err'
                ##__VA_ARGS__)
                  ^~~~~~~~~~~
 ./include/linux/dev_printk.h:144:65: note: expanded from macro 'dev_err'
         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                ~~~     ^~~~~~~~~~~
 ./include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
                              ~~~    ^~~~~~~~~~~
 1 warning generated.

>  		kfree(thermal);
> -		return -EINVAL;
> +		return err;
>  	}
>  
>  	mdev->thermal = thermal;
> -- 
> 2.41.0
> 
> 

