Return-Path: <netdev+bounces-44684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A25F7D9313
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 11:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C8691C20E43
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 09:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DD0156DC;
	Fri, 27 Oct 2023 09:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KSmw3jjL"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2533EBA5E
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 09:08:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D006893
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 02:08:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3Ty9I8qyGN3XPUOL84baVoYQvHvfIp5FGP2G5J/bdBBX6wrHvvqncgbWo4JntliPbhbCCsw3PeZxHB25waiAjJBCoRlYEcqFaH1AJ9ddkOEnFyil5125XNn0R96rDIVQopgiWm9XuI1hLd3OESPBwrbIFB130iB8x7n7bEufD5g8aVsXxxllT8/t6yDZh8YSOoSdXfrtiobTWcBLDJgBS777rPowGjXhrHpI6Ne/AYExF/OUOxBW2ItQ6sy8K2aPkAtJk4ASLVYcgLX0RzzaOvUIyAsDQIKR4xC1kOAD311VhHRI/+pjSoe787PVSiYjvnyESBmGHucSSAUdVYtQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MxOepCToDPHpUEVw66+1yT2Jh7qSvDmaKJBBloTDQ0E=;
 b=QysysIhKuSIdzV6zJpoITwYzGF2WlNUC473l4esO6u0oy/NdcqV1AG4X+GFgQGuE7OSmdRjjZBbOsE1+SkTp6/UDdbHM0BmmWI09NCqJ6eESxK+lk07atiUtTadrwyYA7NA6SLvcnqCHIdwoHtdtAnuyt6IcRm9l9G4myDZ3QQC4kzOTaH1Avty9IrFG9lUCxSULmbHD+pprvNfPo+UG/uBJfyU73nTbRxGF+NUqsxdwDybfXI2jImYAoh9aw/r4ePqZJfFWCnxqB8dOHa4I+FKVVror9rZBu00fWcCX9lCcCNgYCgRaW7LuXZIWJJs0YR+acjwBVMCKgX3xkIJw5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxOepCToDPHpUEVw66+1yT2Jh7qSvDmaKJBBloTDQ0E=;
 b=KSmw3jjLUILb4hBUPKt5u7MghNHM1pYvVviAAnNhOC80VrEokXDnfxdaRY3rAOsAFjQ8GenGgV2HijQMtOrW5PQvGl07DPBOxdOIA+TaPq84EsGEXF+HuiqwVNzH8isvfFETtuZ8Meph1XU/xpDBYD56wQAerVrdPESGZMY2IKJHhRw1H5cnWUolv58RMlRSiLQmwlnaXMW5k2RecFTrJkN/03TQEBzPP453zEP8Dkp+syUirAwkOhgWq8vzqSVGJ5uQ0zkmOeF08vRwkSWsxsXaOsCc7hDGlr7CXRSV1GdcsAX2fUfpBV8A2cU1T2xPRUT8sGes+g82QISVRGlDVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by BN9PR12MB5145.namprd12.prod.outlook.com (2603:10b6:408:136::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Fri, 27 Oct
 2023 09:08:03 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2%7]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 09:08:02 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org, Boris
 Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com, smalin@nvidia.com,
 malin1024@gmail.com, ogerlitz@nvidia.com, yorayz@nvidia.com,
 galshalom@nvidia.com, mgurtovoy@nvidia.com, edumazet@google.com,
 pabeni@redhat.com, dsahern@kernel.org, imagedong@tencent.com,
 ast@kernel.org, jacob.e.keller@intel.com
Subject: Re: [PATCH v17 01/20] net: Introduce direct data placement tcp offload
In-Reply-To: <ZTfSOv0F7licIO6Y@nanopsycho>
References: <20231024125445.2632-1-aaptel@nvidia.com>
 <20231024125445.2632-2-aaptel@nvidia.com> <ZTfSOv0F7licIO6Y@nanopsycho>
Date: Fri, 27 Oct 2023 12:07:58 +0300
Message-ID: <253jzr8juvl.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: LNXP123CA0001.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::13) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|BN9PR12MB5145:EE_
X-MS-Office365-Filtering-Correlation-Id: a62b28a9-06b9-48e1-4e28-08dbd6cc394e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	slf24eMZ8+0UCl6y9UKlHSYk5zX23cQ4AIxbjiJpulwt4DaV+KXDP+EqbpPPnyfSx+NOyD6rYKC85uSVhn0HqGXt/XsJeIwHZnsFtIMrXLjGx0xrJ+DLR8SD3gICt5/T9q0CgkAjapKqKvL1ca3YaX68wvQGvQUALDJ425EYYEoDeh2gXG28LoWE4tpp95XnWTOAiZOhMeY9dU8/S5un9aubPGM198PD4ypkNzv+OLwsRrcH0AAG8ioC5F/nEXltf1FHEnpqrTCrtZmQB3kMqkrDy7SNk0FpQM2Dc/jLj6jk2xYUj0qIcNQ0Em7jKm4QdFWz9Ns/1p2QuvloTscH/FcGcFRNIaoc05ZyObKgG/Sc6FIu4lPMcGl9U3pjgpcuP6gRLVbqJVmOrRT9vBTnd27gEAPs3G4SUailaa6YfTe5NtiwcE/XJuDYT3TPFIzz+v0klJ9YnEL/5xH0FmPAnVXsF4jFdUHIKgVOHt1Da0GYlLvVL+D/I0zudIzS958RpWzQH2Kgagkl7lMVh4dIoEBMdIjxI4WiA+lIjEUhyw15fq5VummlFBKojyezopW9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(136003)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(4326008)(6916009)(83380400001)(8936002)(66476007)(8676002)(66946007)(66556008)(7416002)(6666004)(2906002)(6486002)(478600001)(5660300002)(316002)(41300700001)(6506007)(2616005)(26005)(86362001)(38100700002)(36756003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FFChL8mrrrETK2lt7r6vVaP3xZgoUpLzXE4a/7tQaQrHOKUJzGhf6ivlhIK5?=
 =?us-ascii?Q?kxyoBFscNLYcZpnrHD0dwtFVNGNnc3uauXI6WlL1U88JRq6yBcsrE9W1mfYD?=
 =?us-ascii?Q?TxmpCEaec736YQ17wQC/7Y8rH/P4sYdDgkQ4px1Ty23O1Kqf2naqoaT1cEWt?=
 =?us-ascii?Q?AFMD+LdHciPWTQbsNOy0PO5tFFcC32VJ/TeqaOUY97VpPxw+9J+lHafPdxMR?=
 =?us-ascii?Q?KjVarEvLLvgVbjWKfZFn+2+cPMSVVS847p0pb7OifuNXZ1lnIW+nflsKQxXf?=
 =?us-ascii?Q?8jbkNwvd3MtAKlsBY/g4WUGrs2nZrLgkBtUYK/gM2vVa3NLCWI/tvnjAn5kb?=
 =?us-ascii?Q?1NGzNLE+dATSfWmybgkrxRSIiUTU/KH8n/wRxVFR8sBfAbiNAMn52Jrdg3Zf?=
 =?us-ascii?Q?ezOr811GRlwnTbSx9pLURoQYupt8w149W/z6CLKFEFiTVkxprkLjW+GpzoI9?=
 =?us-ascii?Q?wqP+v9kCxDXuzL0YOxDaoE7EC/ADFXEZo7dvrbffV2ylX1u2EKa2bf/wGxyg?=
 =?us-ascii?Q?ZnAtzHiaw88LEji89x1+w4+/4J1h3tV3Mh/SiGBfnnMdG73dqG0eYRSYV/RC?=
 =?us-ascii?Q?xgXoJcmWJRXCkt80i1JsE1NVuWftPjKzZXPBNj1TqlFa1zEKDRhBrRX+hPwy?=
 =?us-ascii?Q?P8NkdPNTjoc2unhlwMoankmw+Z9U4XX+ngvsKwtHfRC4YGRGcYFrx0CqEgvZ?=
 =?us-ascii?Q?23YOGRHAo8OsvCrl88ugY+VrhE4r/UHA9opaTblMqBaxRA+FyvtV5wYnUksX?=
 =?us-ascii?Q?hxpLL8TnrKAoKgOG4bWzAWqmgc1s5XnLWxM/G5KSLfAGQ8j0F2kTqUj7yj6a?=
 =?us-ascii?Q?dn5rGdU9zDq8LSF1JcuIDRblh3jeqs3XuqclsTslOes2KetYRjQ6CDsVeHEn?=
 =?us-ascii?Q?N0zT1zqskNsxclx1haliDfibuUZeLBe+j/3TYmqVzXi4rPmQOOaCvn+aR5PM?=
 =?us-ascii?Q?69S6T6RUQi4kp2UuP6WKQJ2p6iFlUV8HmwvilA/WDMj7a5Ti8n05pNG8rwyG?=
 =?us-ascii?Q?KEQzgkOQjOZT2/DLeyOro3iqqqB5fPxbPDQbGC10t/C21V6M2li8iQ4imHjJ?=
 =?us-ascii?Q?nRACIEXrUvIFiDK4B3gEHSVSkYPMQidL+hZAVF4imDdwVUC90oc82U56yvgQ?=
 =?us-ascii?Q?mNpZ+ZpjXrNUmfAIKI+PZz5Y6G/nBl4ri11/hfdD7TQ66gJxniBueqEvkgWO?=
 =?us-ascii?Q?Ic7OR8cuA17UDN0cKHpDNwF+NV4R/NyVWHOHj7i+CJZ4/uhli68tpvyVlxa5?=
 =?us-ascii?Q?uDApZau1ioKt4evqzhPjzltJwSUX9q32WU2XMIqu4s6w1GLy6Gd4D/PQ8myB?=
 =?us-ascii?Q?9MCxAb0FkGA4U2fXseHE8XIa7yCH7KTAp/sGKkIy9BCmFogHUij4pb7NtbUp?=
 =?us-ascii?Q?Zt7BgQq3g2o4nz0UASxKNLwI8Xsm6q30Nslw0xU6gCbZrX/7avgqYwqhVUj6?=
 =?us-ascii?Q?lFJP5rYx4K1zswLs+BKbAOZEyeYOuCWdUeQqRlbQcwfohetiM+5HwbyRH/Kz?=
 =?us-ascii?Q?Ly/aFsImdFO/XXta5fp9N3TcFX+yALhZQpw93DV+oPvzLGJZrfBK/F33NkL2?=
 =?us-ascii?Q?67G/kgahlKf17wj9frvlZDrmRDomTaIPFS0KnyBw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a62b28a9-06b9-48e1-4e28-08dbd6cc394e
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 09:08:02.8126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LPe/DxaBnjEt8Ix2L2xPzGV19egNla1QQ4oFI0GDafllQIjsqKRdqDA0qu3LovAj3Cd3EVWeVQqNXVKhaWgk5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5145

Jiri Pirko <jiri@resnulli.us> writes:
>>@@ -2134,6 +2146,9 @@ struct net_device {
>>       netdev_features_t       mpls_features;
>>       netdev_features_t       gso_partial_features;
>>
>>+#ifdef CONFIG_ULP_DDP
>>+      struct ulp_ddp_netdev_caps ulp_ddp_caps;
>
> Why can't you have this inside the driver? You have set_caps/get_stats
> ops. Try to avoid netdev struct pollution.

Ok, we will move ulp_ddp_caps to the driver and add a get_caps() operation.

>>+struct netlink_ulp_ddp_stats {
> There is nothing "netlink" about this. Just stats. Exposed over netlink,
> yes, but that does not need the prefix.

Ok, we will remove the netlink prefix.

>>+enum {
>>+      ULP_DDP_C_NVME_TCP_BIT,
>>+      ULP_DDP_C_NVME_TCP_DDGST_RX_BIT,
>>+
>>+      /*
>>+       * add capabilities above and keep in sync with
>>+       * Documentation/netlink/specs/ulp_ddp.yaml
>
> Wait what? Why do you need this at all? Just use the uapi enum.

The generated enum does not define a "count" (ULP_DDP_C_COUNT) which we
need to know how big the bitfield should be. Maybe the code generator
can be patched to add a #define with the number of values in the enum?

