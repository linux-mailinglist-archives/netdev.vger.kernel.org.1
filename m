Return-Path: <netdev+bounces-20958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0FE76200C
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 19:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98ABC281953
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 17:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27D525905;
	Tue, 25 Jul 2023 17:25:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04571F932
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 17:25:55 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2095.outbound.protection.outlook.com [40.107.220.95])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239061BD5
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 10:25:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvi6fYYV+sCAZZoZ50PGm9Vsz68CGePQalENgkv2QH/TkaoQzfsvPQMKv8KQCDO6u0x9435KDdM9IUml7HaIN/FyiUfwSeRrFP8kzSYApTGVmGgMFk70S2orZno6rewm33H9+P4PyiR9tMBrTdFPzspy1drvb1/NYvfLB8nN3TlL5JI+R61YsU2qXoPaN7M7GU+9aW45TNCRSPUhBTiNG1YIJojOCzG3sqUvHH9DdVVrSO5D7QXeQ0GrXkRnuN0qnPHSqP04s+SKr1wvKzZIOrULgPTaA2IrKCrLc8sTx3AQsVwSPheAnxZxG8THHsrJ+CnorSzcPyG19HLWcrnMgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4yVqwy3aagbr7OpGgg2XUvmrV/o1lHwA7bc1IJrKU8=;
 b=UrCPngjjEI65Ik6zhVuiA+qu6yfRd0FKym5W2mBxdtwweyI0RpilWYSAswJO1FUh1M3AaSGiBBGXbjSYxOWXlLcvml4oslpgFpCUnQC4syL0e4C854siuME1+gLxrM92HS/n/joyK7pgotn2/caLcSX3aa01umay+8MS7ztMVlh03Vz+OC/kU1aqRnw3PKF8YNJZ1R/FZqjSNkfT2SV6s3BNjgjCWoG62cRxyiwjmZMdEQbw5V/wiszXMeiw9C/IyZDnq2pIEJg2ijReg6ck9Xq4UgZN+601h6UEiMPsQEaa9gxGsuToUf+PV7S9vV1CxbLVZyyIGbslXTAyQyGUHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4yVqwy3aagbr7OpGgg2XUvmrV/o1lHwA7bc1IJrKU8=;
 b=GQ7FByV/ruahrOhVVb3zat0tnWzWKrQyorDiXSDoUQkb4YKgecM1mHcbuQkJuvZrrEduSDddJBPNGnTYZHeEPkasbsxT9iCuGAj+xYLjuX8cn8pYp02/LdrLes5LkH7cw1dhPe36GlqQBLDM9f8NyvGtCHXDbSkVGZeOUW0Mv3E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BL3PR13MB5162.namprd13.prod.outlook.com (2603:10b6:208:339::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 17:25:50 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 17:25:50 +0000
Date: Tue, 25 Jul 2023 19:25:43 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v3 net 0/2] net: Fix error/warning by
 -fstrict-flex-arrays=3.
Message-ID: <ZMAFl/R1Yfyv4aIC@corigine.com>
References: <20230724213425.22920-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724213425.22920-1-kuniyu@amazon.com>
X-ClientProxiedBy: AM4PR07CA0004.eurprd07.prod.outlook.com
 (2603:10a6:205:1::17) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BL3PR13MB5162:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d211a1e-201c-46b6-2213-08db8d3430c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bcNQAFUoeRMc172YngB7AE0kWyANof6F3qog6ZIVanQrirtnru2nPMFDCooctv4gAzH6VDm5p0nXMV6YXbJiaZO5/OJb46pO7Q0lPqFm+rPqCH/sjDHdf+RhH/Gg6LbwG+K1nEjArGKTdbXtyTCEql1Tcsyw6Vvp/2tSxoQNyzxE9AICBF24xqW12m9kWikTpQX15DQDHn5D0Y7GPu4HxlANEK+ZVI4Qu68F04JlEtafBomjYHjwbP4C6d2B2Ws6U0OgwySp2s81lLIbq8vApeS/4wZdHXc5TdAg1CYetHrxw9jo4Az3jECqQGGY22MipK85bOsXfuE9vPcZAVfOJveRkW5VJA5me1j2MSPJjB4LYn4ELSo6A1ULIcY+pDzo8cAg7OPZLJsQn0joe5jL/MgXvfgYoJDqjD+4SIDsKB5xfjmILX7FS+XC0U7absBa1NMcmpzUuRxB/9/d4p/paM7GWOhfb4XGv6QhoUgNZt5zqe0eAyH04jk8xd+FgoRT3LvU/6P0MHiSZTMHJaSYsEOG+r0pL5bP9+rzvTc+QkxHlFin1VBvLY9pgtYUDUNGTnqRmkJ/2drFZz8SN8MTMDU21lwcaxqU8MeY1l79DVY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39840400004)(136003)(376002)(366004)(451199021)(36756003)(86362001)(7416002)(2906002)(4744005)(44832011)(186003)(6506007)(6666004)(6512007)(6486002)(54906003)(38100700002)(478600001)(4326008)(66476007)(66946007)(6916009)(66556008)(8676002)(2616005)(8936002)(316002)(5660300002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BxgVZBY5ABjHDaCgtpzchWRKwYsRjt9S++B1anjbejKJQDSzyheFL9n1xMhc?=
 =?us-ascii?Q?5cVkYTouxx1J/JYACVyFjRHUGRNjLbrxj52QGY6CNvZpysqwF27/uANAegxv?=
 =?us-ascii?Q?1Sc5dt25y7TfSly5c19e7VVysGu3pz22Dd3Su/Rj7FIJnUqdRizCvMeIh1IT?=
 =?us-ascii?Q?B7XQYa+uGArzlVjimmPLZRMYZLfik4x7pQ6Ft+99X+FJwOtlwt2ej8isBgNa?=
 =?us-ascii?Q?UYMWgJ4NWC46VvyTNPxske6lF5NRGk5/vDp4odeLbjVJtUt2l290GBghizyl?=
 =?us-ascii?Q?ORLtkNAeV3ga6WddpsqOr3xh7HM2juJHglm8H7pA8SI9NQ9+zKFHWsEom8XR?=
 =?us-ascii?Q?41g1QHt91ui8+1kBizisv/lmisU16R3EEzPLIytz+3As5lgpvDMeMFn+Fdks?=
 =?us-ascii?Q?MZMtDuykn6h9hjMjmwvBIQoaWTF5bM0PabKRzIjGGC+31G8J98Oxx7Ftfdpc?=
 =?us-ascii?Q?OSN7YJuaxnxQh2NSDrkYPO3ZHjnRSyjw84f4/cjvgvZGvXmH+GTJNwxtk1SS?=
 =?us-ascii?Q?4qkAUgF1WkkUyHvZO7E6D+GNFGLO16syavVkI/Al0ZTHm8yDu0lAOiXLeu98?=
 =?us-ascii?Q?+NkFNW0bgJxgFWHZQOUU84nRBnBeejbzvY/Y+816fKkKMbtHP4ZInSNORfLq?=
 =?us-ascii?Q?bLsnIqgms2wbC3EGji/cfYLb2+wMuC6dcAyEsEsaaldxyHZkT7AAsj9v5tQI?=
 =?us-ascii?Q?T5simcvOdLyK4IuaCiVNRQoFsZ9eeTVw9RGUFc4W2bHYRLhnCOSiIyhs+RGg?=
 =?us-ascii?Q?jRxnxzmftrVOmTNXdPNqJVptUK83Zf3yOsHJBMOERhS395Og6xIPAlMMlvUX?=
 =?us-ascii?Q?cnUUznHcusKvg0zNUUahinPZ0wicj59REEGwjCjzWxpoh0OlJs75j2o6kO5j?=
 =?us-ascii?Q?EhLL+1hJu81H8b8sjAxpSPRcMA2ouSx1ZKq/ToSigjizW3MyX7QrCisFJWG8?=
 =?us-ascii?Q?kKwMGx5HqRO96LAM5okN8cT48boHgBh/WJ1s7kpSKWNoHObO12e2AdgZ3UcE?=
 =?us-ascii?Q?DpFtwQfcLNUChMt+aqvGOpLHg2Z4LDg/3ZS17Fyx9e69/RdnpdvZLz8ZDdOr?=
 =?us-ascii?Q?omIUwvQMfeFfLX/Xv5lqaTm7Cz1gN7g/2d4CQ4QMBPqQ7sBjrEv3g1G/Lt6j?=
 =?us-ascii?Q?8XhwRbX5Td3xBX+2BKbh+itgubFZ8gxSNdToL2dbHrIY6eQbews+5eTjllZY?=
 =?us-ascii?Q?RnxKDHNwN0938oatP1KpTmblK+l4MRqyubN83DtzcmVjqr+0ytw0hcc/+ZMh?=
 =?us-ascii?Q?uXYImCVHbU3jiSnJi/E8tu5ZajacVq+b2HvadHvPj1cM9xjMLRerEewiG7AK?=
 =?us-ascii?Q?vrL83jMp37YbVyBZFG089ohkuXz4GfH6C+/DeFcn0a9ew/LyzsjTpng5tNpJ?=
 =?us-ascii?Q?0o3ggi9tpMIGmwMQBOZpTFGHw0U6aCPRKgkmG4rWmwoX/LDJc448zaaJkgsO?=
 =?us-ascii?Q?fbVKa7FwPJjHQ5wcSWY3luE3axdg5RTJleYeYgEkJ2l584lkCOpy/XGNhi5v?=
 =?us-ascii?Q?y3w17c+9Gah901Zg8l/6gmBiQJta4bOO76grSVdWAqJANUUwAGy5RF+kYXkf?=
 =?us-ascii?Q?u35a/6pILO3f9DCSUyUN3vp4qnK5J8PWKLJ8XieOWun4VZ2sWctQgVkW5HQ3?=
 =?us-ascii?Q?3b3Wr48Jq41wCSbdiY3AyDrOHzicr1pXCt4xAtCajxuOdSNnnaPybuZ18UYV?=
 =?us-ascii?Q?npOgng=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d211a1e-201c-46b6-2213-08db8d3430c8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 17:25:50.0645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hNMRV6X9CjeE3PURcxxQWKAP+ym7BBeuyjW5BlXSw9YwK0lQJP04d1m2uFvtwrQhOZ5UUzEUjcSROGjLMqDZJjFsr1fvKreNRW4yyu1s3EA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR13MB5162
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 02:34:23PM -0700, Kuniyuki Iwashima wrote:
> df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3") started applying
> strict rules for standard string functions (strlen(), memcpy(), etc.) if
> CONFIG_FORTIFY_SOURCE=y.
> 
> This series fixes two false positives caught by syzkaller.

Reviewed-by: Simon Horman <simon.horman@corigine.com>


