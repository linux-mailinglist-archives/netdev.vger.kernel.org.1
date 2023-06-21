Return-Path: <netdev+bounces-12686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B4D7387CB
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 16:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 891A01C20BC9
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 14:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BFA18C20;
	Wed, 21 Jun 2023 14:50:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB87F9DE
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 14:50:49 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on20710.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e83::710])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14D83A86
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 07:50:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1zgLBPLLKF54lscdzBfaZ9zm0NEQEby8w9oJzM3kOB/5A8aVEypmSj55FsbBh927JEtFyVo/CMIjRj/ABMGsXNzCFa7FqFdiS37s5Zq3aRREgUz2lGxc1O5DTipUfv7fAyWfvJ3XQKyKf7M2dGubLgMckpbWXbWc4Z7YR2M68p9Waucxz+8m8VJz5sQOYEBaz+Eg3gUyRKej1saxMGYA7dK7YIO2qk51qz5RajmsJst7CPb/De60CFmccBkh+LRHpQcACr9xy5N42bJ4DMMne8bpz6fINYYmNhiINqFTflDFRALr0eQEkAJFawMjUJwt5rsg8kIT3uORqEOJXMAXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zreYfMivtUXWSih5ksvIcHj00z0kgZgpXkl/u+uTE8E=;
 b=aSjaaQkwEmb3PYDbl6SPleP4c9IZzqfa5Sxuzvghsf5AnRbKEjYpO6QFuZ7H07k6oMWl8GsBUEv4SbAoJnndTNxYssLZA0x0dswFhdDc0+MWBSSGO7W/qC8MFD8f/hgdf71TmWp5cc08jOwzSv8vJCG5Q1CpZcik09mwY9q1QKtVGE8Ja/zDWTCYJ/CYqh23DpLcZAuhW3Q4i8wC5x2lRSDfWTbsaTdM8JMVp/ENR9wAcu55JH/xaRAi8kxLVLtsnFY5242xA/LXB0duhKwS7TXZ/8BxedQnNucSyRpkEO3lxHppwM7/a80vo4GUG38Rj5fFu8U7ptwSPu21S6jgvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zreYfMivtUXWSih5ksvIcHj00z0kgZgpXkl/u+uTE8E=;
 b=v0f4WSQB1PKJfjK/qx61vzJxcX4/y9sI3E3Awi0yU5Fo+kJWMqe1atwGbgW2qpkZ8qJhtLuvxyHu0o3RWCdDbkxMKzf5jFKgjN+KLzp0pls2JYDwZpvM3h1j0GELK+dMsHao/znc1kSzrI+F4aee0PG4io3xv2c2BtknlLFXi1Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MW4PR13MB5888.namprd13.prod.outlook.com (2603:10b6:303:1b7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 14:49:34 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 14:49:33 +0000
Date: Wed, 21 Jun 2023 16:49:26 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Ying Hsu <yinghsu@chromium.org>, aleksandr.loktionov@intel.com,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net-next] igb: Fix igb_down hung on surprise removal
Message-ID: <ZJMN9vk2e5uPOY7o@corigine.com>
References: <20230620174732.4145155-1-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620174732.4145155-1-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: AS4P191CA0034.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::27) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MW4PR13MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: d8624821-197e-4cdd-d72a-08db7266b915
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BLE68k6RmUwrQIBPB+iqXmBW0+iaTVhT5iMZuJWQXOsO7fNEZIjgWKNlX809NlvsBG1HTbI0dpWCESlM/fZMToAvqbRRfKKmNY58LrKmVXb5o3E069IZSuTxHDknl9Gva7S1fxLv+EErAdeVo6QWsnpq1H5dXmUUg8ZVncn1S5cTFG7dZ1BWS8O+t5VT9KAmNauPrW8cAQN/NV1ATQMXjTvxHPGcvkMDvALaRORB2tkFqKedR36OXXtv68UvU0DMU0QmG06nVYK/CkA6ygpYmudyJZcO+WAN1BHVUh5hy8EOplDprjw3F6UY3TlfNKtTdC6C6nefAG3UOTANaPJ7EowDAB+ZxpewIYFI4iliDK65rxmHRMHWi2DKnwafYs4oJyN9P/TGZshhjByFJ3iUKkbJWAQctctOQg3l3RRmy7IwyKyOJ044X5IJisnPTk9ebBvDQQ9y/VJ3Y1YmxyYZi0lkWz1RZFc0kQxEFjcw/jh1bqCcpksfivQQrAmayz3jXjIDTO4fB9Ru4AezMH47TdMsv+1QHc1d+qRwMbpEkqZUlxdOgyJJrU1s/skVr5rfk53rhdYa1SiN+9u/Tl1P3VEERF7+gniobIS7ftV6NCg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(376002)(396003)(346002)(366004)(136003)(451199021)(4326008)(2906002)(478600001)(54906003)(86362001)(6486002)(38100700002)(6666004)(41300700001)(83380400001)(316002)(36756003)(6916009)(66946007)(66556008)(66476007)(2616005)(6512007)(6506007)(8676002)(8936002)(44832011)(186003)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fP/0CdPLFNW+ZJpXOVbFMQVndC1oRrtek6jXjDhCqC0z2zBJCUArucil49is?=
 =?us-ascii?Q?PuH5afeBAXY7NlOy1DR5hHtfvgxeTJI32cuYzzAw/IIoWsL2opNWCIBNCdJS?=
 =?us-ascii?Q?coByH8zyEmN176xf8Uupi+3ogdZGBi5F0sAOvL75k3oBikkLLqKaCsxTc2Up?=
 =?us-ascii?Q?W7vnUx0q5XbYaWBpx7dIXvKPhQrXVXYJouATadqyfPhnm05BsIPdM55K6ZW7?=
 =?us-ascii?Q?oKaH+oYIhPraq9DHIMmbxrq3MDXVaq7eG6zcbZH+hcL+ca5sO479baFnb0YQ?=
 =?us-ascii?Q?xF641h7czhJx0M4tFJEpDCfqnOGCB6i97c/L7UjsSalLxZtIvOHOCAM6Qed3?=
 =?us-ascii?Q?Hg/fYPhP8VgHsEk+qgwLKh1ZKuPT9q9RVYjvlKnq98gRm5HnbiPDKV9B2LZy?=
 =?us-ascii?Q?8Ys1wC5/uF/p1BF3OsWgTPnLPBru10/HofbE2A5GAK2RLsjnREVFmdbauDtW?=
 =?us-ascii?Q?lbXlj1LpevJP4MlWTkM4YZ0uZmF9J5tV1nAL2jaUihtH5+7E/rraqcjB3XPo?=
 =?us-ascii?Q?fx+ZN9oYY4M+tR28pX6/06OhAN9/jZ7T5IAci/KOS31cMfB++VaHgyq5XaAr?=
 =?us-ascii?Q?fIDL+spCeBlxumhPs3CQK5W9n3XSZM4vHBNC83i6JfmC1KGEO3IfYrMKQC2c?=
 =?us-ascii?Q?QThDJQoU7YZlD2ymzg+kyQ3f+9xsRqqu2SXglXr8ZG8xn/9QBVvG3zmVmcHy?=
 =?us-ascii?Q?YC/C+71vAxOIjJqXcgMqqLeUTxiaJhlE3ruqVxKpYVmxzB/DKe5R1shQbdvX?=
 =?us-ascii?Q?pY3SixdRG+amqmShmCheYrX20X8Ge1Oyh192rnKbV3OSG9bwM91+zxL+2mIr?=
 =?us-ascii?Q?I3QfsKBMiwpWI1pX+R3eu1TY77ksUGbPW0canm3OQgMybeC/bTcZ/cRT85ZT?=
 =?us-ascii?Q?i4gePFeFe7w7FoQ+U7v7huz9GSHEKeNILLBytQas99EyNfym9K2+4GdWcPLW?=
 =?us-ascii?Q?Fo5Jxs+K2hsOrbh2PdEIxaNnrwiS4RmQFci991d/VwIRKU4HKu4AFKTZb+Uq?=
 =?us-ascii?Q?KZbTFS9jqnIHsn8c8fYKtkkRFl2vmfiwbGsI89A+a42uhUS3n+E/Lam2Jqtd?=
 =?us-ascii?Q?juB3VdFY+EcvkyUa6xS3Q3WcwvazxenD4JwypbFEYmeIiJsV4sjNZXjk8xaP?=
 =?us-ascii?Q?t6DEWwOjJ1PJ8iePoVG4+EpbbJ3cwEHGKAGsspiKZ6cT+Rpb0a6lgyXWI1Wj?=
 =?us-ascii?Q?fuZtC3EvSoLwPKOuyCh6KfzjbnHsGtPp5fnfOfsDSmOvGRxfR1T7RJd1xb3F?=
 =?us-ascii?Q?VmkShr/4u4WaAp5xPLzRyiST5o8u69X/tkUx+aHoQRZg1Cudp8AkVfcOH2B6?=
 =?us-ascii?Q?nnpi97kqZ5+eb5LuqwVSy4Ogs9a2br8fO9uzMUu9+bzJa00Deo1oH/OU5ZUT?=
 =?us-ascii?Q?XRbe+k0XLLbdDD35RV3tDHFnnuvvgSRp+6fUxElHHVD1Dj3ketqnGXzpHaZg?=
 =?us-ascii?Q?wo3tSngy9PaugBNtmyxcg6jJbaDhe1uoyG6Yz9sK6fMEcvkIUgOMGg+1lbor?=
 =?us-ascii?Q?woJm5+3vSlL6lvhfyFywRlcU2UZryCsiv41IYrBWa92n8T/mATPACMHSCVWn?=
 =?us-ascii?Q?NaVXCQBWQM4rKwo/lE9/J7s59FvvwUdtB192NdaIeBDo5I5XGe4CNArySxKB?=
 =?us-ascii?Q?fsFbWHLfFIczvBGAS2Of5T0wMQx9DlMra4xPbxwMiqkHEOvJ+8z4NpFV2Clw?=
 =?us-ascii?Q?+F1+sg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8624821-197e-4cdd-d72a-08db7266b915
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 14:49:33.9208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +4NPEw5rv82fzn8RPBn9zt0eJe4Q3za0tpbrWQQa1DgNMiI866JJT8v5p/Q1zhWawFiLKBRig8eDqUjhaBHzsSnrzi1POfMW1BJWqM51Yuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR13MB5888
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 20, 2023 at 10:47:32AM -0700, Tony Nguyen wrote:
> From: Ying Hsu <yinghsu@chromium.org>
> 
> In a setup where a Thunderbolt hub connects to Ethernet and a display
> through USB Type-C, users may experience a hung task timeout when they
> remove the cable between the PC and the Thunderbolt hub.
> This is because the igb_down function is called multiple times when
> the Thunderbolt hub is unplugged. For example, the igb_io_error_detected
> triggers the first call, and the igb_remove triggers the second call.
> The second call to igb_down will block at napi_synchronize.
> Here's the call trace:
>     __schedule+0x3b0/0xddb
>     ? __mod_timer+0x164/0x5d3
>     schedule+0x44/0xa8
>     schedule_timeout+0xb2/0x2a4
>     ? run_local_timers+0x4e/0x4e
>     msleep+0x31/0x38
>     igb_down+0x12c/0x22a [igb 6615058754948bfde0bf01429257eb59f13030d4]
>     __igb_close+0x6f/0x9c [igb 6615058754948bfde0bf01429257eb59f13030d4]
>     igb_close+0x23/0x2b [igb 6615058754948bfde0bf01429257eb59f13030d4]
>     __dev_close_many+0x95/0xec
>     dev_close_many+0x6e/0x103
>     unregister_netdevice_many+0x105/0x5b1
>     unregister_netdevice_queue+0xc2/0x10d
>     unregister_netdev+0x1c/0x23
>     igb_remove+0xa7/0x11c [igb 6615058754948bfde0bf01429257eb59f13030d4]
>     pci_device_remove+0x3f/0x9c
>     device_release_driver_internal+0xfe/0x1b4
>     pci_stop_bus_device+0x5b/0x7f
>     pci_stop_bus_device+0x30/0x7f
>     pci_stop_bus_device+0x30/0x7f
>     pci_stop_and_remove_bus_device+0x12/0x19
>     pciehp_unconfigure_device+0x76/0xe9
>     pciehp_disable_slot+0x6e/0x131
>     pciehp_handle_presence_or_link_change+0x7a/0x3f7
>     pciehp_ist+0xbe/0x194
>     irq_thread_fn+0x22/0x4d
>     ? irq_thread+0x1fd/0x1fd
>     irq_thread+0x17b/0x1fd
>     ? irq_forced_thread_fn+0x5f/0x5f
>     kthread+0x142/0x153
>     ? __irq_get_irqchip_state+0x46/0x46
>     ? kthread_associate_blkcg+0x71/0x71
>     ret_from_fork+0x1f/0x30
> 
> In this case, igb_io_error_detected detaches the network interface
> and requests a PCIE slot reset, however, the PCIE reset callback is
> not being invoked and thus the Ethernet connection breaks down.
> As the PCIE error in this case is a non-fatal one, requesting a
> slot reset can be avoided.
> This patch fixes the task hung issue and preserves Ethernet
> connection by ignoring non-fatal PCIE errors.
> 
> Signed-off-by: Ying Hsu <yinghsu@chromium.org>
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Simon Horman <simon.horman@corigine.com>


