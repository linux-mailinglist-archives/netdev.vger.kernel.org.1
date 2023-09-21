Return-Path: <netdev+bounces-35424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3E27A9737
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAF0E1F2101F
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 17:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EA51642A;
	Thu, 21 Sep 2023 17:05:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DAA1173D
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:05:25 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2085.outbound.protection.outlook.com [40.107.96.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1276A58
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:05:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehfMIo75MDWPYLY32Tv7cUbnyR7dI0Kc1LmtJqutWi2bXG9SlTZvMzc9a61bsrFO1+CjbiLmWbIngrzADBBobkSO+SU7qbdkqV2iHH3qpaF4FRlPRRooDZ8GPgFxgcja2Zgu0ByfPv6+1UvrEsNcG/fSKo33IBVw2j79/DNnBoF/Or3ceR2UaSRQGD8PR33UvujTOO32+hW4XgqrDR6CjewdCSuJjjtYlZU40Jg1bqmZBDvAExfrUu0SzfahLv8zht06oDiYTRodZXSXC58QOtjx5Y8RF5bXnE2TEWQtodXc0pmZiO3pyGoshqI0t8gPhamuqYxKSySpkyB/IF9lRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/vhhjkwLd5z69O2Tmw5GpSRBLSGYPNjedcl5GGGYzI=;
 b=m+ZxJNPoreoKO6bFUFwHe5HXIIP4F9PTcBINYGH5hseD+lde5t9sDDVfmhjOz6n1Vtr0/mmV5l1f5yUUWNOzLTkejvYgOsSLRD8QMiwsb9VF6UcJTqQR09Fx6NFWSaxFBdwiM07fKVLL0yUq7n1xQRYlfLPQbSmuxk3VDcyhNYK5gIcCN91bHbbaQSZIMUlor0WQoRoWOvvDW7hcqcbMhxHjMMKTmCS84YiXKygkheLz8B1dExM7ABqXW/RQgJMURRowCUafLOs64hN/WuzDK2R3iUe4yrhbkYRHYKV7rsxmkbZo2rVKTt4yDXnwwsMSaeec72i1p1xdQrxiQV5+ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/vhhjkwLd5z69O2Tmw5GpSRBLSGYPNjedcl5GGGYzI=;
 b=dGwY92iU2YHqLicTheCE0GDGf69EOApuLCWQVZQOGvarPaG4jIAcKFpRXL8NXlmYoQIKwPZm0kTNpwkpVppdhn/3VtznmfuVSZkEWdcqX+tr/8b76/01k4gD9UpgF1GOWqtl/xup//SuPmZ6ETZIu49WwYv+aCrDOKyjyd2gdf6ovqaFhc/PCKlrDXNzbTA6mHbruYWjm3sZPnM2opMihet3iQ/A6edhCE++QrBBTWVliNXEUczSlDimEfSLImpsmKKvFJsRiwenTR/RhfONnJmQcbis3ohlxb4rlQDAD8wootshQ7y5LHu/guis3ptIF3Qvm7LGi3LvDhP3JMbViw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DS0PR12MB8072.namprd12.prod.outlook.com (2603:10b6:8:dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 07:43:41 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1%4]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 07:43:40 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: David Ahern <dsahern@kernel.org>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
 axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, imagedong@tencent.com
Subject: Re: [PATCH v15 01/20] net: Introduce direct data placement tcp offload
In-Reply-To: <4ae938a0-6331-f5d6-baa5-62eb8b07e63f@kernel.org>
References: <20230912095949.5474-1-aaptel@nvidia.com>
 <20230912095949.5474-2-aaptel@nvidia.com>
 <4ae938a0-6331-f5d6-baa5-62eb8b07e63f@kernel.org>
Date: Thu, 21 Sep 2023 10:43:25 +0300
Message-ID: <253y1h0j7j6.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0044.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::24) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DS0PR12MB8072:EE_
X-MS-Office365-Filtering-Correlation-Id: 860f3be8-ae5a-42e5-fad9-08dbba76792a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZlipMmBMZ6tDB27wpPhQSuE4vcFTiqChRZzwzSQqLr7WSOPqLGxHeKvk2Gf0Bi2pSn+dmYlVu/q/zIPRLiABSQOo2HWj4+OQnlWNdhBbjonDm0AWY77FJ3T0iI3oJvtVbOOF+d8LKGpaDOVC4uzXIzgApuYGTECPbwS+LBZXGfAto9BiCXNEZbduWZCXpTYwLyzQSiA2elB9wGDRb/BE8X0UG0VPtrf0m90db2VoTRbWsHXPilPr98A17B8pNTBsve06cB8i4CGnrlHu4YzTQ2Az+TIowcS9m7N66w00keMpNfm8LY5V4En/J+DnvSRxbh11DUYFfNG/q3YYXxIIP07CHhbQE+uE/6i3Cmog/UwBZDKMBcmo4/5wZxmZWj4WW6bsIr96NRbxMvgM1MV3IVnQAGQnjclFe60H/+ovHosD2JBpuQdbG8Mc4+j2q0psLWOe6zDBtIzlUMtRnv+xUg2dMeWe9O8GqJ1Da8KBIKJ2/1oF0kqu1rVAO/UOJjWZYdwdUfd2XpFna2S3dddymqkzpaDIEi1KxDh66yncIOdzp4ypJbPKV9ME1ORoYE0KPDsvQPuC71rEjlY9W1pbruxj7syXxqJomYPiCzRrDYY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(366004)(346002)(136003)(186009)(451199024)(1800799009)(86362001)(6512007)(9686003)(6486002)(6506007)(26005)(921005)(38100700002)(6666004)(478600001)(4326008)(5660300002)(66556008)(2906002)(316002)(66476007)(66946007)(8676002)(7416002)(41300700001)(8936002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?86dRL4nMGyivh+0or1iYGTdBN1nmiyTSXYJFUCSohgU6XV4a9kpLYshUnp+U?=
 =?us-ascii?Q?gnPFOElazcA8af/BJlkTWB0J4ft9T0DTzjB3qlFA0cq9sdjk73a27ipIkkZB?=
 =?us-ascii?Q?Yt/oquEoNf/KJxs3u5TldRXX3/lKaZvZTUfbH1hEW43CgPlkp2YX0KIdiA5Z?=
 =?us-ascii?Q?3bTrnPAVDNyIZuwyacSkykyTTuBZypnIFfw4D2uuXLEtwT8OC7A/9KOYhARM?=
 =?us-ascii?Q?Xho9ToITJKW7h6R/XQCrSguDw8WTFJ9McCIo5bDHRaRKbfwYZrIyddGUD1i4?=
 =?us-ascii?Q?3nVdxT8YVeTNHJ6M+/CI4s0kcYNAJvz2E24AvJ2au1Qdnp0BdUNsJXJnU0GD?=
 =?us-ascii?Q?L3ffnJicJ3g34ATw+xGVJK8YqhxSOMh9j0XwO+otJw0zviw4738KE/kPT8jY?=
 =?us-ascii?Q?LEo4Kmt/nlliNMnTD8ndzZNJYP0yGzyyPtL0m/GJrfhO0xTyEg+foFm5l5ZK?=
 =?us-ascii?Q?1EU02Ju0lJVv9Yk1uSoivcWDyZ1ugbMfZcezQETSGCh8jH95hCel3LLEyC2H?=
 =?us-ascii?Q?aSR0fI3VJq/V6sRO67V7pRLLS3hvzQk40WDA+/+kmWjwHw89v/0HYruXlCI5?=
 =?us-ascii?Q?Pa77jwiHhcKbQl6xyIUWejcgSAgB9X8D1wTB7wZPtsEFjfz8Z7KXxCRC0Yce?=
 =?us-ascii?Q?tTpCTOW/+CVuZBJvihi/1PUd+u/JiBKq83WF+EiqNMZLqh8lMWZ9e5cBzx/q?=
 =?us-ascii?Q?A677/y/+xRgcYDzQ+8o4s2sqXMOLda4dLEJQZsR6YJf7/r7bLog4kp9AeqBi?=
 =?us-ascii?Q?xi/w1Ic+BLpjlG2+pdmPFcOLjotDFwpy7UtsAWci5QWJ748WSdmkMnuiESb+?=
 =?us-ascii?Q?tGBVVfHTur8xMypKtJZM8dTV2K9p4qgYvPDH3XpJE5HzItC1SNEm36eZSB8k?=
 =?us-ascii?Q?saUjY4Cpx/pVDjBPvUNtWVuI7CU81otjVIv3RJjeBBDRgjfMQTSePK3/KwVK?=
 =?us-ascii?Q?28z7wIxpghTNth5UdXwJrDMYSoLA9yZT4dw0HHjwLRacbQdaWaGHeiyDtBCC?=
 =?us-ascii?Q?92VwEu85rbONlWB3yU/vaxkA4mCW2G+GfLDjgEk7L29rItxqIVOahwyutQms?=
 =?us-ascii?Q?mw8s2FvdUQOxPiCmc7ZUUKbnfHFA7LU8JnS0nuZFY2kbMIHeNp630ZVBRuEt?=
 =?us-ascii?Q?bBhI3Jvc1UJq5b8IqBF+l7Grd5c5qCdT7kFnO65dpPE5wyCLqNA0x0+A6tZh?=
 =?us-ascii?Q?bOAGO6e2bCjaIzSUvwkcwlCyRkUlThzFJA89Z6A+rHPgWw5r5lD/JHTjvDMq?=
 =?us-ascii?Q?fWeJkFDNK5NVoKE96LyFgUuWMnWhveLbf0CeWwmPpprihiSksNKkMkWf2IGF?=
 =?us-ascii?Q?3p/lLg1KJFvUAjyCYPuZJv8j5p6/XrWO4tvSmrRvvUgpeXTPW10Ql78yGWRL?=
 =?us-ascii?Q?xlrBLkp4j0/YLEYSe55d2gnBJXcur2OYg522YTdjmsZvDuqkkhysElieVAM0?=
 =?us-ascii?Q?yOsQtcy39okE4qCtqxkOq5KaC2YE6gUtaFfbyGtjOsqzKW/JCdmxktkZwW0U?=
 =?us-ascii?Q?5HMRhlqc8VXWwP0c5WLO2iAnHkbhiAlElIrJ1y/8kkWXtyXHFnyBHptC/CaM?=
 =?us-ascii?Q?oLz6UvxB0WPKiJTk8tGBMVeIzNwNJtPkQ5vK0ubL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 860f3be8-ae5a-42e5-fad9-08dbba76792a
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 07:43:40.7240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RZSGu/x9bUWdGlQz8se5xc/9PTvxSrIXZzMo0UL8+YUOsFFu2sTL/gOo1erW1BAeg86L7opOQRhQxv/P9YsGNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8072

David Ahern <dsahern@kernel.org> writes:
> Not consolidating frags into linear is a requirement for any Rx ZC
> solution (e.g., the gpu devmem RFC set and accompanying io_uring set for
> userspace memory). Meaning, the bit can be more generic and less tied to
> ulp_ddp.

In our view the ULP Direct Data Placement has a very specific design and
avoiding skb coalescing is just one aspect of it.
It would be hard to make it generic for any type of zero copy design. We
can rename the bit to "ddp" or "zerocopy" if you prefer but it might end
up being more misleading.

