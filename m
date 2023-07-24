Return-Path: <netdev+bounces-20434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A2275F8C3
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 15:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E79628147A
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 13:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1598C16;
	Mon, 24 Jul 2023 13:47:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5048C15
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 13:47:08 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2093.outbound.protection.outlook.com [40.107.102.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977C9E73
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 06:46:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJr4jxF2uPUnWUeXW5rLFBCezuKQfoFZ7ji+HgwXrs/6xZph/dZlHHOcf34rjGSyGT4ybKso/P6aTYZsNrN8PpQ+TMWI1G6nj/lnmJ0pKLBrLY+0+1G2sfo6jSv04Ed+JQmGG9xuBT94iRMdz0gFwfbfEntTeE0nZ5pLzENFD+hdMzozNMLvVg8iqpifqU/zJxcXEKtQEiaymihNhJkk6z8Q+HmA/u80ltaaR3kySqpHo5oz5liEu/uO5Pn3wFlaPrts92brh/H4zSnJZ0whpUzMYWSmMZkdkWbVpoW2nrEuM9iMzzCY9Gg7hTcFS8lqj2sHqWRVa1qL7mFWa0CRkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lenl7bGHRqlhX1FY5vmtOMU2fj+Ad6c5O7/pmRES4IU=;
 b=Yp32osPZZgrZLx5w/1r76NcJSZIf/+1LVPvvgeoC5mEe4VJFcdddv9RoBffZ15lWaC3BC1ULPNOsfsVBY4VO9nPy2XN7MnlbpAF7wn6kZbcaSDGoT8VFb53W9jsiplj8QSYQKUzvKw/MUbM6r8KrnuMk28BrOxef8nRXnFVfgeU0rjMNWLqvPEyBQ3VvrCGaWIpMi2+JJoAAv/XS5VZx+B8cZRjEweE9cHnHA1/aAsckDmLzsriVy4HpuH7JH3NQ7OkZBGtU4YuoC/lQJPT8AyBh4POGpcb8yDX1YLRLo0fI63qr0pNuRazMFG7qI4G/P9+TBvnLG4itk8ch6gseUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lenl7bGHRqlhX1FY5vmtOMU2fj+Ad6c5O7/pmRES4IU=;
 b=s0HQ0rSp9XbUYvxZA4hJbhjLSV3IT77GhO15CHBJ9wELIUxZQoFXZwb2t24TQnS7X6lJuR5KnXrZAvBMIz9w+vuTWrmEP0ldHgZtnKYzwMW6jFOAoiTHxQs9sqMHjLWBgLkO2iw0emPE+xEp1OAyGcxeSgaOE7/K+8SCSmab6Ho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MW3PR13MB4156.namprd13.prod.outlook.com (2603:10b6:303:2d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Mon, 24 Jul
 2023 13:46:24 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 13:46:23 +0000
Date: Mon, 24 Jul 2023 15:46:16 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, magnus.karlsson@intel.com,
	davem@davemloft.net, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH net-next] net: add missing net_device::xdp_zc_max_segs
 description
Message-ID: <ZL6AqJP25qKHBNgs@corigine.com>
References: <20230721145808.596298-1-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721145808.596298-1-maciej.fijalkowski@intel.com>
X-ClientProxiedBy: AS4P190CA0021.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::6) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MW3PR13MB4156:EE_
X-MS-Office365-Filtering-Correlation-Id: 373e1b56-eba9-4aaf-22d4-08db8c4c5e45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lE/2kvRxg0Szr0oVKBjh/xVLAkXetc9eu+VdVulaHxLhSr4ljBBDOeFQGNMV4pgtZTcwsyhi1/4ckrsNdM/ZENzcw//Lw3onbl6DzlCzs/lzCBTCugELFpFOP43kHNrNjRZpFw+DTiNaYxdq3Hh99gwvwwvJGGWZJHFAGsRhL9apbSsnlKHNa+w2ThDu76Gc544u68TWudFIW8anj/Soci5qyJCCcLuOAgrQO48W8JiuRBt9ND+EKKuBuDAFRpMNFSvLOpuI1SfHu0uQZ3wuL9JzEPkyTY9Yf2c/8Kwm66gZQ5iPOpaJcN9OJk6Sdc9tnVfrfJrBeidTaL/OedcW+ukCb6D3xPiNKK8mXO3GCbWjDGAAXyjaEgluUKEKT1KQ94MaC7qs1hHlUYtp+HQKNR7wK2zz1GPhi7GMVZrLpoj7E63XGef+YL8jE/HAAPxZXuPi8k5gMgDFejaxSQePYfQ9hm20xLIGBVoIACJlkCeS88SNaKsQZfz8QlR1/jOYSRy/99rnSIRsiOwNs9zoRwSudpfgTUB+bKgnO18KYAEV0srR3DMtIV/8pPEf1pww+j4/RbZfvVbw9nt4SFKF6AtDVzaTZUcZ09/0wm46LZY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39840400004)(366004)(376002)(396003)(346002)(451199021)(966005)(6512007)(6506007)(38100700002)(83380400001)(186003)(2616005)(44832011)(4744005)(8936002)(8676002)(41300700001)(5660300002)(2906002)(36756003)(6486002)(6916009)(66556008)(4326008)(66476007)(478600001)(86362001)(316002)(6666004)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R97fwcei3GWFCcl3i1iXSZw8Fpy8h+YjuagchqglP9UYPphMCLeCQy1E4U/B?=
 =?us-ascii?Q?Td4ozYlsXzKczM2J+KC+nygcYBhK4P+56H68Kwn4ZrCLMtA3I1pAQ2yyehWJ?=
 =?us-ascii?Q?P8c+uvJidP3bvV8i1MtQolxevwVcZKGr3DNyWDwoEw6G7YccM4WJCLKa3XiL?=
 =?us-ascii?Q?mrkevsaM8E4f5T5d3pxJzyoQ3BrtHVjUi/r8aAijQxWdaQ0n8DPyrzwbmhoY?=
 =?us-ascii?Q?5kpspN1Lq360axSUlovfIBv5jlNcl3mMaiJxuLmYZvgjiXa1mMkNcnzbAHez?=
 =?us-ascii?Q?QlOiOCXyXor/BPCqjmVIUgFzIVpP7l7mo7WjJgadsYvGgl+O88l4ZV1sa5Ui?=
 =?us-ascii?Q?i0faNdAr25R3YBsuTNO7tTF4ZD4CtimIBEG9feodmwU36qaBpnPa3fQAfXAn?=
 =?us-ascii?Q?c2u+01AyLtxGCv8j7Oyhatau3wln3b+DTEzkIGj6dI+Mnnf51FlJvnfM6FXK?=
 =?us-ascii?Q?nwWVoXJCXQCkI6qEKFZsQyA8fK+155vkecLvZzaCjKc7g8uiK4F6uM7aUfxp?=
 =?us-ascii?Q?Lig9rMC+151zjTb0QGsPi+UuHo4E89vpuW5Hztzr49XCL8UOnxypUNyLg3+Z?=
 =?us-ascii?Q?jaiWD2wbmwaiP/QHZVnC7zWAooxJIVijvfFbb7DSMXHDVxTaeZLlZ8c4cWFZ?=
 =?us-ascii?Q?FaHhbNHx65u7VFVWCaVauDXiuXfhBm8w+ko0+wh5LlvrpFdKxeBM2Jpy6nyz?=
 =?us-ascii?Q?1JTEfDhEpSmPwr81FKbYZmwuxQgeT7lYwUv+A4S5/uLIJNlWu4xwIPGP6n3+?=
 =?us-ascii?Q?jhBRW4YDl0Lm3/dbJAhXw9Y7Y/CzQXCOX4IxmgsI1H54jCqWX52m9lgIomvd?=
 =?us-ascii?Q?39qzdlycS0NBDl2QoOrHFT0DhiZ6JQPWCZSoKn6eWyleZ7p5AGwvFT2ukV0R?=
 =?us-ascii?Q?vK9eo+YJXQoKksvpy5vUvGN4YTTrSIU13gI/1kXSetHM2i6txkeDUdsHV8Bi?=
 =?us-ascii?Q?id6CE8nHfeQBebB2faUJ9d34QSf2jy83NST3S3tqGEoK5wmj506Jf9h0oaDA?=
 =?us-ascii?Q?Lz9AoqTRIt1mTpCqCwFI8i7/mjky5RY5bORx+3T67UaojlrCi2Jv9bP5symJ?=
 =?us-ascii?Q?djlk3VBMntaxCzlzAhhM3ShrbgPGfM+q6WkQu80uOT9Nz16mgwPTNEWLkMYn?=
 =?us-ascii?Q?gnv1Sn8WE03Pi2Iivi3kHlf2t8t2CfxUGg4VW9k7KEnaZ5lAmgIEIGBIpXud?=
 =?us-ascii?Q?aRjIIdRAW8n3SQaHEFrO2f3UVzkjKSq2kShCO674VIDnk+pSdw7fgKcIHsuT?=
 =?us-ascii?Q?jNSI2RIOFvLT/HVHq9GPjjUevWk8obJrVRfB6T+uA5BMEsU7h286ZAAP2z3G?=
 =?us-ascii?Q?zOd5SpoAf2eX5Jx6aNQgFEVPnyJ9ZxGMToLtatzvTDmm4Y/B58rn0oFILkTc?=
 =?us-ascii?Q?lofeCHrPKSdZrIm5og1FusSRmHzjdx7qoMjQTosnTdhKgmiCDVJ5fn/56Q01?=
 =?us-ascii?Q?84Rzc85pPyMMdIeJbPiF28qg0ONLOm+PvCF647yMWUsnABhyK0yIvO0GUAtp?=
 =?us-ascii?Q?GgIfVZE/I2gCVYxSzt2ViKhuQSOj8iF4/3MWZyrO1YOVG4JGu8d30i1wocfP?=
 =?us-ascii?Q?2czYB0Tlp9oIk8MaK8D8CsOQhrpq2J7TL3s6Bf9dcTxgdZR3aAMZHNgotTOP?=
 =?us-ascii?Q?WqmKJnz4p9cvp44YJAoxDdoTqzlZInSi5Mvv52F+Lj3cGv/8bU3cgukaJEK3?=
 =?us-ascii?Q?uZwXtw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 373e1b56-eba9-4aaf-22d4-08db8c4c5e45
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 13:46:23.3078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t3LAlpO4X5K1L5zQaRCisZ875CWgMwiswRdO50l4p6ual50uKAT7wumo1X3IZzjYT8wn51l57LTm8KgA86K3jmWXPQPR6TfN717QucdiU4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR13MB4156
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 21, 2023 at 04:58:08PM +0200, Maciej Fijalkowski wrote:
> Cited commit under 'Fixes' tag introduced new member to struct
> net_device without providing description of it - fix it.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/all/20230720141613.61488b9e@canb.auug.org.au/
> Fixes: 13ce2daa259a ("xsk: add new netlink attribute dedicated for ZC max frags")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>


Reviewed-by: Simon Horman <simon.horman@corigine.com>
Tested-by: Simon Horman <simon.horman@corigine.com> # build-tested


