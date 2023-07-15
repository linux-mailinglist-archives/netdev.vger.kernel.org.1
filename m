Return-Path: <netdev+bounces-18071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E69975482A
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 12:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9148E2820CC
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 10:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7759013732;
	Sat, 15 Jul 2023 10:18:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69983184C
	for <netdev@vger.kernel.org>; Sat, 15 Jul 2023 10:18:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2118.outbound.protection.outlook.com [40.107.223.118])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331B930CB
	for <netdev@vger.kernel.org>; Sat, 15 Jul 2023 03:18:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmRjHEySlPUUn74ZKo4zn57L5A7JKQs67C6paw7F0LnNakdBpAL4HW7Mq9oFMR5ZRQMmBACP0r0tElI1tYfAjKZR1HH4mUoDzM+8OLUOgCpEBi9J/xkfcijiC9aLxDupWjfQcvegYNYvmQZQ+pUzqUR2dcWBiwXe4GCZLf9ALczBL8Wl0M5RVerYom2uI3gGCGmIsumKsD3YkdUGGnF62dYvfeV2+9B/yGLdbH9JkOlIf0MKDMhdoarVz77OKAKbZQU7hR/o0p9zYu+1/X6raICsXqavADpsTc+eQ6Sk4Y9JdghA+xT/nRKurD2mFQv6vShtmZHYJWu3XYQZyc+Q6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9NakKpdV53SaiISfQwprc18cKvJ30tmmM90fXEv8+g=;
 b=XFFl4KaDRo+pZslwrhViWHiMPQ/lNIe8Gc1kBPBfsvhz7IEsL8WHHu7XGA9xhHKNia2dahBc28TfS1UXuuo+RO2yHgV0pbcqy0UpnwUja+ktY0azwfH3oJGR+L8IMAvjol0LlzoIxmiq4tkq4zea7N/Lh3n2mVvNdqxzSyFd1jF80m8ba5s9jVn6lSMtCcztq3tWuaiS6WOjnQQaB4M7G6/D+RMuehMdcuNjoTQZsW/J4z26orDpmWTEgslt0eAHC4d74GlIbhrB2EsMhEjlxZE0t1IqhtwDZBOhX8LP5m9D0mVGdrU59zDO1dZJuJdOzrYfPFS61dIbB0SRtr1mLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9NakKpdV53SaiISfQwprc18cKvJ30tmmM90fXEv8+g=;
 b=YI2P7fxL1qB8/WnpxN2Xmhwhrgx1hAUsP/FUYFhj1kpG7gVcu91ue3aNpIiDdCv2KNPiXeurCe2dcOoNVcFk0unKlJ4OoPODNcAl83anxkk++Ejb2kws7eZmhKkDVNCKocUVm/LmQgPYPR4D7w5NMw/beZQL65Itk6OputduOGQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SN7PR13MB6256.namprd13.prod.outlook.com (2603:10b6:806:2ef::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Sat, 15 Jul
 2023 10:18:04 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.028; Sat, 15 Jul 2023
 10:18:04 +0000
Date: Sat, 15 Jul 2023 11:17:55 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
	sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
	chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org,
	aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
	ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
	galshalom@nvidia.com, mgurtovoy@nvidia.com
Subject: Re: [PATCH v12 04/26] Documentation: document netlink
 ULP_DDP_GET/SET messages
Message-ID: <ZLJyU5mSp9g/v/aN@corigine.com>
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-5-aaptel@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712161513.134860-5-aaptel@nvidia.com>
X-ClientProxiedBy: LO0P265CA0012.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::13) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SN7PR13MB6256:EE_
X-MS-Office365-Filtering-Correlation-Id: ed95d2cc-be7d-4f49-b043-08db851cc674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bavzmh0JQJIy+zRlo2cvQoCp2Qw1rIdrk5e8VaL5tSjad4GHT+InJPm0mTA8N6ij44gDrhNOHXe2snakUKP1A0OTyKJtDGBOBjZ1VXNJSo1PgRYwZ8E//NbVCo9JaSUqo+U8CrDJJGoaucwhifzAU1TTBodOsfmi0fqpuDGX/JYh+eTYU6JVZRpyNikQmxv7reYNpFS+MroSqsfopQS1JOyUsaNBZmsTQhazN/0TEPzNWVl5kJh9LC0N4mvcjLA7AKESHP6uMQOtd6XjEdpMPOk1/X3kSMScE7dO8b0pHT3NEWMEFmlYNHuVOfkezbFKoOE2YKAaIJU7hayqlAD5X0Fl4C0TRe7zndW6C6yS8jCHhHq/4YpYSdgXfo+kp0KRFcFNJxHXZzWvDA6HOC9tHOpO107tFx2F9XxipPOGHIf4mdD20TN9SswPwFR9useyuJyFv7HAlFt8+7o5BlLfMcN9k5edhmCBcnJyq4kLVgw7c/vPehJ6JxZWaRqLio/ayhQq4RbsAcLK2Y3HT1fFj0fMpy0fyrzt3Iu1AZMlIXaMns9/XZ3oAhPpScsKtqcCZ3H0705G3CLNblUTphD6/9PE55IvxE18pk9W2sG3x/c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39840400004)(136003)(376002)(396003)(451199021)(38100700002)(86362001)(5660300002)(2906002)(6486002)(66946007)(6666004)(2616005)(36756003)(26005)(186003)(6506007)(6512007)(44832011)(6916009)(478600001)(8936002)(66556008)(4326008)(8676002)(15650500001)(66476007)(83380400001)(316002)(7416002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yy82srR6aj0Ryz5gIiiUiBJWOz0yumTiE9GBvDwwawr8BFPb6IfD9KE3j5qa?=
 =?us-ascii?Q?S+FYExSfbcevrTFkXB+N5VRtlYaY2jUjXohkyrgr2Dm+792mjtlg069kZBUv?=
 =?us-ascii?Q?kNIg1S38N+BdjEw7//VkCoN4VZrT3Kgl+pw9rg1tE2GHfS1UwDP4fviNTEUu?=
 =?us-ascii?Q?T6Pfx1Jti/ASgQ/jsPKSZnS6EOf5iBqyU5Wrc7aiNsRpB8D9r1NdeyOUhB6c?=
 =?us-ascii?Q?ltG+p0snAoSde4QKKYPazJJ8ttlYF4/+J11LybVz6/vr+4Jla32Qxsh6/hNG?=
 =?us-ascii?Q?xRa15s+omB6wdvVg9NX0FgCB5tWuNdi0RnVreo04xykCeNazcaK9hZwM/35M?=
 =?us-ascii?Q?4vnggMPiBNDyi/cbnEdsLW17ujNq2v8u3MpQJdopU+Rl3tnaPxJWaM2Pdw30?=
 =?us-ascii?Q?+vzcloYnNwp8ZBpLcVitsbttJQyXBEdhL1C0QXt6WRuOQWlCcD93uF93+Ktx?=
 =?us-ascii?Q?mS4jRiVRPT58dVKTP2wkX85Bf9wff/80eBQ6nZlL4eUA5pJH4fIB0A/mF7yG?=
 =?us-ascii?Q?yE3hTdPZLkV9UFonaTy8aBEXWHe8OBcOhf1XB2yerUmFzOpOhQWivFDWHrqg?=
 =?us-ascii?Q?W9LuMR+Q7u3jXLQyKiBn9u5hZUkZypUURKCYN+l6DJH4QU9OS+Wzs/oTt03W?=
 =?us-ascii?Q?SycO/EIJLNWndNBKYsnCSwy7LoWNV4cQayLngPCfk2qA53R3MSJ20ok8rC32?=
 =?us-ascii?Q?ENzOmPaa1O6jUXbqJQIi+3FC3w7STbsoTGlpsacqBobpY4J0tD/wCq8eCrX2?=
 =?us-ascii?Q?FqX4Tn8cMqZhHOmOnXP7btBnRk8FoYVzKIEHuIufu+vArlDEuXRuJ3GrN+M6?=
 =?us-ascii?Q?I6DJxuCR2g1hzFWpSHMnMiPsKMTNtPkyPsbH5/IUE+U80neISfbbf//tBL3D?=
 =?us-ascii?Q?cKrt5odT8hDYVcfQruowyfDfcvtVhe9bRnZHEt50RDzHW/UtWPH23/cp1sF5?=
 =?us-ascii?Q?HufBQWxtkym27+ZwlUP1c28FkPeZFZ7JKOS1W/aVkY6qq3muc1SGL0ptU9rv?=
 =?us-ascii?Q?P4eMS1p3v3kc6E209YH1l7k6RC9Y5RhtGhyWZMCITFqArVb8s89JBUW6+4Yo?=
 =?us-ascii?Q?1LG2HOe4v72mCRoj3MwWVAmIuMw42DOpkYv3MVFjN8X3lu9fHnv+AcRs467r?=
 =?us-ascii?Q?IIxffO7WRAsNJ7KlU3+0RSwPhbWHyyKk7PjOW1mY684XaD3E7rozDqkkkRTS?=
 =?us-ascii?Q?+eHJKoFVcKERM2GydEQu3lDwaXEmwOW5+G5sDSrvAVQKTBRchLJvtY4TWHZb?=
 =?us-ascii?Q?yZobz43ez911gIyi+CvO+xAqVABZvgIdqg8fMbz+02zYhqDXk5FEuL8TYMtr?=
 =?us-ascii?Q?eSfFTpERQbNROLIG1MQIhIOG5R9vlitoK68Y/5z7doDCgW0M2l+biqJEhUae?=
 =?us-ascii?Q?iTvuRzjM/WnEiuhJSdiBQEHenI9CzRC7lI9pw/EgS6w3qEOISdZr9nHaC2ho?=
 =?us-ascii?Q?V4mWpaW3/r98DCQS/MmZBHHdoAPxhjPQ6i9QUZSnRal7emNYNscX6uh7qLMA?=
 =?us-ascii?Q?Js9LHBnHIHMnmaZUnscahnMfdJya7TMPtaJFKuksfoDU8drrpJ/e95NFZauS?=
 =?us-ascii?Q?kEyNrRL60qp6Y8gfvRY8Rxs+BVdNBwrefR6y1WJEgpNtP2q6A5w73p8MXTZu?=
 =?us-ascii?Q?BQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed95d2cc-be7d-4f49-b043-08db851cc674
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2023 10:18:03.9475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sEKNpJaxMp7szZQR8nvqukY9L6hHCzAvcbLT7DCbeBE2D7L62bYT8FkKvxqMdFampomRUnCJ42/8wXtYQ+3VpzHsOrL5feoji/3vTAslf+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR13MB6256
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 04:14:51PM +0000, Aurelien Aptel wrote:
> Add detailed documentation about:
> - ETHTOOL_MSG_ULP_DDP_GET and ETHTOOL_MSG_ULP_DDP_SET netlink messages
> - ETH_SS_ULP_DDP_CAPS and ETH_SS_ULP_DDP_STATS stringsets
> 
> ETHTOOL_MSG_ULP_DDP_GET/SET messages are used to configure ULP DDP
> capabilities and retrieve ULP DDP statistics.
> 
> Both statistics and capabilities names can be retrieved dynamically
> from the kernel via string sets (no need to hardcode them and keep
> them in sync in ethtool).
> 
> Signed-off-by: Shai Malin <smalin@nvidia.com>
> Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>

...

> diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
> index 2540c70952ff..8ffca8ae9bbd 100644
> --- a/Documentation/networking/ethtool-netlink.rst
> +++ b/Documentation/networking/ethtool-netlink.rst

...

> +ULP DDP statistics content:
> +
> +  =====================================================  ===  ===============
> +  ``ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_SK_ADD``         u64  sockets successfully prepared for offloading
> +  ``ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_SK_ADD_FAIL``    u64  sockets that failed to be prepared for offloading
> +  ``ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_SK_DEL``         u64  sockets where offloading has been removed
> +  ``ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_DDP_SETUP``      u64  PDUs successfully prepared for Direct Data Placement
> +  ``ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_DDP_SETUP_FAIL`` u64  PDUs that failed DDP preparation
> +  ``ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_DDP_TEARDOWN``   u64  PDUs done with DDP
> +  ``ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_DROP``           u64  PDUs dropped
> +  ``ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_RESYNC``         u64  resync
> +  ``ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_PACKETS``        u64  offloaded PDUs
> +  ``ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_BYTES``          u64  offloaded bytes
> +  =====================================================  ===  ===============
> +
> +The names of each statistics are global. They can be retrieved via the
> +``ETH_SS_ULP_DDP_STATS`` string set.

'make htmldocs' seems a bit unhappy about the table above.

  .../ethtool-netlink.rst:2038: WARNING: Malformed table.
  Text in column margin in table line 6.

