Return-Path: <netdev-owner@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DC4740E5D
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 12:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjF1KLu (ORCPT <rfc822;lists+netdev@lfdr.de>);
        Wed, 28 Jun 2023 06:11:50 -0400
Received: from mail-co1nam11on2041.outbound.protection.outlook.com ([40.107.220.41]:4302
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230050AbjF1KFo (ORCPT <rfc822;netdev@vger.kernel.org>);
        Wed, 28 Jun 2023 06:05:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqMo2Fh6YLouV5HH8nVVxYWasSO+VS9MArQ48MhH75PMaM+N3Fi7iCf8f/aVU/Y9MIBwM8J3+SLVz48wa3z/rqxoGrXuqrvsJQKLtStBkT73rn59UAozp5FovnHb/C3np8AJdJc2U4E4x02zj8jC/FCV298YGNUaykomS8EAMmMmXArs4nkFQXD8fJztaMk3BryJMV3dng0LKwLAzWmhj1+7CnwyhNGOueq9ST7/Reh3Vi3DjJWnQOBPUDZyMkbTaoxM/PFK/ieAcJJWTh7wuEO+CUH9VheWRgS5HzqsUfwUavXM5/m1oRz943valZXoKteCr7VicWTblD48EQZ0Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yM1/698r0CrKhEH98wZSvEfPpDao+svZlI2AockcepA=;
 b=lQNPig7O7+LhHwo+X1cr5KIDoC24CX8W4ioqUuETmEj7zUoa98C3dvzvxte/bCVI7KyioSEtRlITqbUGt31YURhvTzwzd1ofSskhWX5ePxoKeTOx8jjUmXG7Bv+N2Aj+35dU9NSxcix6yLFS58SyVNuy1tTmoDPcW05g3N2iNrqnM176CTls7sBWIeoJC6pGKiHSIKPUJIMnoIctVspLdjtc8JpX4yBxP8hmnYOFbBhFqT2WTQDaPAUkXW2qCBWrYYz248adHceEdnbnwQKNjAKQGXcSrxG8JtBM4yp3bV6n3mkXlUsfwMvrkUbd4bU/o3d237UvJo02ONt3iWCe6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yM1/698r0CrKhEH98wZSvEfPpDao+svZlI2AockcepA=;
 b=G16jg1XJAiz5ZyW8OuEaexKi4XMyAO38UETvbmPX3EKAL8vIZ9xdJ96MavKfauVHkeKF2YmGXCF1ztGfldeiobDOIjwg3pp/LL7OXc5/uElbXRSqZSM/Cutp/nYEiCIFAl19wAbnkh4uHMXhyBt8c8RDK4E5bT1Ze6mTvxgoWcpZIyo/CFJfSnPUpzJwibkvHvjMOBoiQo74oV+vqROHSO7cV6Hwzx7gwXsB91N7PvRpYNnEk5A3ptzf32JHw4lO8shkHd4uqrsmMMzNJy5gMKgy1W+j/EncZtMaJxamL3NBSFXdRF3vNz3SDdlRSULU1EqwFVq5qyZ7xfJCqd6Yhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by SJ2PR12MB9163.namprd12.prod.outlook.com (2603:10b6:a03:559::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 10:05:41 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::66d8:40d2:14ed:7697]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::66d8:40d2:14ed:7697%5]) with mapi id 15.20.6500.045; Wed, 28 Jun 2023
 10:05:41 +0000
Date:   Wed, 28 Jun 2023 13:05:34 +0300
From:   Ido Schimmel <idosch@nvidia.com>
To:     Zhengchao Shao <shaozhengchao@huawei.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, petrm@nvidia.com,
        jiri@resnulli.us, vadimp@nvidia.com, yuehaibing@huawei.com
Subject: Re: [PATCH net,v2] mlxsw: minimal: fix potential memory leak in
 mlxsw_m_linecards_init
Message-ID: <ZJwF7lcZfj1NZgM9@shredder>
References: <20230628100116.2199367-1-shaozhengchao@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628100116.2199367-1-shaozhengchao@huawei.com>
X-ClientProxiedBy: VI1PR08CA0267.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::40) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|SJ2PR12MB9163:EE_
X-MS-Office365-Filtering-Correlation-Id: b961a1dd-eb93-481b-9a2a-08db77bf3abc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wd5vV84JbsoxdV9macE5pu8ZqfwcVB4ZRF+xwFY01wVAz0G/iyAk4ekMBN3KYspRlTd6S9tEP+6Hn20lw6N8v2aXrM/vBpBaVPi/6bvpI8CU8yqrJZaKxScYuHZEafNHYq4pTSiZR/TLpbOwBl5MJgWBSUcY5m/py7EdoqLf8/ZSGnVrLq60N7GrQ/GnzfZSrJTx+Ce+whVragtaJNIiI11a84DJYeFiG69HjIXAcJu6BsTq263gsYlwQTbvd04mYlqBPkTr3CliWrumRwEc2kerv9JNGV1LKVP3VTO+1Bs80NfZUR++MuGtplz+nT6H4+1iSTJ7mkPSJ5mn6NH9fi4sa2ldgERlAmC05GSN5rBZnLfzs+QlL43suGeH3R6ajfZUHMsM+L9KWluAVJFPOPzUGyRm8yq+GN4P0JVZnW//hmyCaoYzpTeyMZyQzdTT2KnHbo3PDGM/v9hVGdoccKdB91jfP8fSaZSKQ/YHAhMWVwNiKzl6FWQSB+VW12b57Kly+1PUThmYJ1mpdp8anhlHr9xaxHsDZcAQpKV/2C7Y8Pk2oAOqqbctOR+n+PWAY+2zEcAAk5SfK5vS6Yoc4AwcdOwxn93+AKIpede4yZU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199021)(8676002)(478600001)(6666004)(66946007)(5660300002)(186003)(4744005)(6506007)(41300700001)(8936002)(66476007)(6916009)(66556008)(4326008)(6512007)(2906002)(26005)(6486002)(9686003)(33716001)(38100700002)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TSSXlbpZxBtTllIX0PPGLWj0b9zao/VlaeObWTa/Logay7UcxL5xdwSHDQ9E?=
 =?us-ascii?Q?FRNOA1s6NCJEkSxefqoMJDCbbBlV3WwpfEEcmHSPgR7eveTQ/+OkVRRRtswL?=
 =?us-ascii?Q?DKcDdLYCIOHSyVYipwjMyI4RWup6L6TugN+hQgEGOTSeupVGD2vdaDUtON+P?=
 =?us-ascii?Q?AFrBJTiOPNtLOtyyIoLwR8FIiVwFtyvsRJs1TFeB6EeF8QpTQJdo24Y2LNS3?=
 =?us-ascii?Q?bndvkiewzvTS3s2qAacyu+hEIHLQH0kiTh5ic/NXHPj7ehNHv3rJLq5w4JpM?=
 =?us-ascii?Q?rknsFPTD9eubta81pCYDc/1snn59BH1rHORRsCtHRxMXL+bCKY7NTWe5NPLK?=
 =?us-ascii?Q?KAHG8xgMvKX0qa+O22M9HeXkZPBNSkGH/W+YBBxCDSugcD33Em+lBEu9vT5z?=
 =?us-ascii?Q?CIz6N9Ccm4K9xwQvvrmpoUrUaMEn+1emm/I1/8gdNJ31FAoROtkb3yVvwTlX?=
 =?us-ascii?Q?bIJADcQTWuwzvkTkCioaPEgWg5PnOB29FoXeqsy8gcRo0VKi9lWmpCJ3YtDn?=
 =?us-ascii?Q?PClLseK42ISZw0QOuimdxbI5iFdE4pGPgLERVNB6701KLJRJHd6OG6MNbB9m?=
 =?us-ascii?Q?7wEHvCAWlSfldrD6t8BGyEvkAYO8oXSgAN107DhG+OoewU29rndr7k+fjWzZ?=
 =?us-ascii?Q?S8mVYohxOfliPZrQWga/J+m0X6Zj+pNIkeqXW5/dFtqXwmZzB9wAxeofg1yu?=
 =?us-ascii?Q?weB0vgYDYHzIQLY4NfnGlaNDU5WSZtvsHpLrDzSULKOG6E3zFVztMa0aCfgD?=
 =?us-ascii?Q?aQXn74HeH02bVBRCojzr+8CZ8Ap0wJcHmlxaRB6k0q7fDPXwaugd1/Sl6ucT?=
 =?us-ascii?Q?Ks4SJvJx2e6ASQAUcQ/PSVC3Ue93kWn9aTBk9hL1mOJCCkeuUK10FvpETRKB?=
 =?us-ascii?Q?72fN8ZN9XG4hE+mZjF1VljZE/8Hug4aW50WiLl/8gn7gsSFWSm9yEwowTIeK?=
 =?us-ascii?Q?xpqDi7kJw4CzByq7+mNqBzFYXHKtfq1cdi+P3/fUIF39IUvJeIV4/xsrldcv?=
 =?us-ascii?Q?GuMRunkHdmTb+rQJz9XQucH9uinrufQRsG8Uyy+1viG/1y+RpXo5OdrOqQxD?=
 =?us-ascii?Q?K9dp6ZPAuaQDNSV8A4l84EsCacHXxWelA/RzIH6Ce8Xe7X/Xf8vQiUDNYHwK?=
 =?us-ascii?Q?y3jLZ5AfPFUddirkQFoF0kAyAiUSyzHJr5PQPaJBCURyGt/zoFq4dt4qGcmv?=
 =?us-ascii?Q?eXdavL1nMmP8/BaaopmbPob60e4/HOFS4eH9D5z4DPZ2ZtiewvKy4oM3Ci/F?=
 =?us-ascii?Q?HqjSW8nCcKvk55RiKn+Te1qqP4ROW4tqIGO6M4Ny3WoiVisw7buYBzturHLh?=
 =?us-ascii?Q?IMeuj5X7OYGvkrHZ31gz4bOZJqmJkxtZLdRR1ZuNTkt+QUPsGlb4yeaB+58E?=
 =?us-ascii?Q?Y4HaJGY0y85uvlpbvF4w2gk6Bd0Iw1u5WGbliT9QLRYEmiBokB/KIholkL5C?=
 =?us-ascii?Q?RldcBMry8FBjy0MhulMaBSeJdLtUVtIQhF5ECLfkCOWxt3vs4KaSx7SlUDmH?=
 =?us-ascii?Q?FcAmRaCJILcfkCur2AwKKERwTPT2H2ot2bxBYil8AuvEPDNopOXp2otdJ3fh?=
 =?us-ascii?Q?XYs/B0japJoZ1gen7OOJ1cXQEkEfRhzLMge/Bp37?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b961a1dd-eb93-481b-9a2a-08db77bf3abc
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 10:05:41.1751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v63sxc8gyg6gu5vQl3Ua1oJ8N4Mb9+osTQ554y3BzIL3/4QoF4LFL0BioznW0cPkXK+09WoM7EM/TIMa2pZm5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9163
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org

On Wed, Jun 28, 2023 at 06:01:16PM +0800, Zhengchao Shao wrote:
> The line cards array is not freed in the error path of
> mlxsw_m_linecards_init(), which can lead to a memory leak. Fix by
> freeing the array in the error path, thereby making the error path
> identical to mlxsw_m_linecards_fini().
> 
> Fixes: 01328e23a476 ("mlxsw: minimal: Extend module to port mapping with slot index")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
