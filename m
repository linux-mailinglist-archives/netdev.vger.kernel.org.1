Return-Path: <netdev+bounces-17073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 494F87501B1
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 10:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04703281908
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 08:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F6E1116;
	Wed, 12 Jul 2023 08:36:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AA3362
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 08:36:09 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF325EA;
	Wed, 12 Jul 2023 01:36:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vc2KGuOCsdZK2s5Tf5RkhfK7zDlvIy7V/T0qFbF0u7QRHd6UdxF0e/ztsTZl5J1e6Eay0zUbaOm5C/dHFiuhn4/yT9/iKJ4yXk2n1HBgDY8w29sJ2QsxdRrNT9eJcLWBsxNY3DK7v//npxb4y4EltLphgcYpse+aiVXHV3t1B+GHVF8qQfoYoW2tdXeC09vDFtk1+BagYVhBT7Vse/bbIw1wAsAVa41O5ViTIaB3hZ1sZalVvBUG4SFS0qdtz2tdqFB86/IbYDOv156Uj/fxRiU2It/t/8HsrYd03kK2HVLWd7CEmHrfoc3AZlt+8TdgNrddiFGSwjcPn5IFEEqKuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5s3lQKf8pS/4y3BJgNuzGDQPhHafaC8GA0b4/5Y+6c=;
 b=ViMjQ5sHDGhvnVfDs07Qh7V28RNnVRDI6HAvhQTp05l4WEse5sI7JR04yXCbfSN1kN66IlfpCVC1mkgGDHDRwOWYfbLPm18Lyjh6n/SnIv2XBmv6SLS9DZ5YPrZOEynlc2C2aXAMRA342FLVf6vwkKkZ2x3ploOu0gQ/+hXFBSKdZrtvOEfXoV6MTN/eDK2vyXUzNBksZ1RB+TMblFHELElYVQk7S6o1nqE6IrFS2mTy34ebWevOk2R0/OYjQn00mAS97wpGHp90CWllZDwyQEe37233wca9ZmcCLMXYDu/qKVUm3NAOXrNO4D7DcteaWPP9pYwT1LnP4efPJ/wF6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5s3lQKf8pS/4y3BJgNuzGDQPhHafaC8GA0b4/5Y+6c=;
 b=YwxsNXnl5H6xy/0NIl+FJmjPQ3RLCAON3wRvW43IUPnioMqXJ8nOL6FVHFexbsc4BtLioayX695GmbbWhMBRgICcUNptmH1037hGz+iFiUwyRQM/zibhNgIaFmVi1gmNrRIySR8JA9Iary3g0U6iKVY4fsKBEwuo8o8/G50NFCYFQGokVnnkQ4agoqhEZDOOWlhjPSzr1chFeRhRXRs/e71qJILDken65R3VLPqcFBxs+2tMTJvqrNjC4fwciO2Hu/+nK1tKFv3igzZJKZLWD9JWRbkLvUNtTrptwYKLw4zsQw90IW7g8wGO4ZGDbqD2tR+iMqM6ln8cywmhD3D3Gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by PH8PR12MB6745.namprd12.prod.outlook.com (2603:10b6:510:1c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 08:36:06 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::3aad:bfe2:42fb:705f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::3aad:bfe2:42fb:705f%4]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 08:36:06 +0000
Date: Wed, 12 Jul 2023 11:36:00 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@mellanox.com>, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] devlink: uninitialized data in
 nsim_dev_trap_fa_cookie_write()
Message-ID: <ZK5l8HdIbF7qRwyp@shredder>
References: <7c1f950b-3a7d-4252-82a6-876e53078ef7@moroto.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c1f950b-3a7d-4252-82a6-876e53078ef7@moroto.mountain>
X-ClientProxiedBy: VI1PR0202CA0016.eurprd02.prod.outlook.com
 (2603:10a6:803:14::29) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|PH8PR12MB6745:EE_
X-MS-Office365-Filtering-Correlation-Id: 77efaa7d-f7b4-4b5a-d410-08db82b308a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8hCionob1SWvNC+CAxf8AlJ5dxi0zVrpAfYbtb2Qa3e5min2U/j9KBhI+lBUopKVfxd+JWwY3mbssv6ymGpKTCRhhvwd4gJAXO3S9mo8Mv/HpEYlB0qIwq8sQmXe9kh3p3EnCsZ9LVwdURI5X48j/H3CUgOL2TPcYuGFELVjNJiPR/UdJJyAoBikC3bhEQNTrgya7tMiPN2j6agvtC3nb6YOVG4aG7JIhAmHJnoO5SAWYy2Ut5PidltA8hNLRA18ie9jphVwmuCKvACOb0w4356sK116RR5BiEQLB9Rk/QJlJdCa452Wchj7+zmJAePk378Q28JvX0dYOavqwEAbD9x9WGwHJA1e2zSZWoiGszE5wIgu1NDqN8x/+FqgEeH0IEmJ5B2dI7JgOB8rkjRBH3ZKaqzx174O6geiPpPSJreyM2Kjp4C0BBvE0U1YxKbOsNZJZgc9EQUt4HLC/1zjOM39oWmTmPbOzjYcG+VboUT/K3Eq4qU4XDyvxeYT6fdEfVNVbmX1w4Urn0SzV2w666W/V74jr7Mu86Fiq36JVCwQhXu8s8NmFLtT2oyetG0A
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199021)(86362001)(8936002)(8676002)(186003)(2906002)(4744005)(5660300002)(26005)(9686003)(6506007)(6666004)(33716001)(54906003)(38100700002)(66946007)(66556008)(6486002)(6916009)(4326008)(66476007)(478600001)(41300700001)(316002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/Zz4l06VlHkzzg0ei1HPioo8w8YHNo3mWzLy/rf+aTqpH9nJH7/xEhUe/dPd?=
 =?us-ascii?Q?od/NTBT/i2u3/qs5ow5kAuGuz0onh7TjoHub+QAxn1uQvumzZBUxL+fSLjOG?=
 =?us-ascii?Q?VnB5+8vtxwMNmmav1cJINrJ/BOeGxmC5j8HcKtlm3ZnbE/LTFiEtz6Hdkff0?=
 =?us-ascii?Q?4C4CejXpwHktpRQ/rg6NYVfMC4/6LiSDJxMwT/uZyhgItrJ+iokBW+skZE2d?=
 =?us-ascii?Q?sGaneMwV2UIvirmEMm6DlMuZ2AR1WXJA3hBXKf7nlaplik6LTBQPaSZWYzVY?=
 =?us-ascii?Q?5O0ojxPyui+RD4gxyy3G96OMdo+owl3GaEbsRvYC+vHSCAV8gHRwCcdLKcas?=
 =?us-ascii?Q?eW2jwXpazPl4j/RMY24ndTFIYOo1pqejhplSPNAblqpcxOAfJ5utgLoppZry?=
 =?us-ascii?Q?MvLpDe6bhFm7en2G1EYIkBMjPix/CRnYgCBywWxKvLkwMZaDn5yfspvocNwX?=
 =?us-ascii?Q?Zqo8g4xcPyivQDvpiYQBrpjIVplWkNDZG/PrazKSoIg9E2DjFLpmvPWfbhUF?=
 =?us-ascii?Q?1lg6Nb1gcxV28ynK+xCQGjSzJOxflPByZHtLUvcHToYhuVD6OyA4IMuNXtGq?=
 =?us-ascii?Q?ok9/9Xz/2hMiYLhswlOZ60jrwIAjpuVHXmZDRqixsJdGHA9HhjqScvLw2ozB?=
 =?us-ascii?Q?6hWKutOOKBZvtyRJeE6IIQjFVwBHpHAirg0BeSyDon4VUWBR/1UAPvEJ+WnG?=
 =?us-ascii?Q?hT/6PAW9S0YCwClmCBkV4O7frpcyFKmkIJDMSBsa2yZKIYMLIB7oir99RMM9?=
 =?us-ascii?Q?gIPZbcIeF2lQIUeuAN+uVd/xCds2QksirtaBwRkkHyMO+o9l/zpwm3G3YZnz?=
 =?us-ascii?Q?JNxdyX0uhggnKgqM+R8BiNHLIo2dZxqVjVLOycHtS/TTqgUw8ghacKJzaQDI?=
 =?us-ascii?Q?IOXj4rr94ui3XdP8Qlo5ZStoDoQTyPIqZq8I7TluYg7zB5mezlG/HTC7X3sP?=
 =?us-ascii?Q?AvWPqz9FWmK8CQhcp2GCYX62MYm++cjLsX04rb17S6/Vb2PfVBvCTCWR9DtY?=
 =?us-ascii?Q?2ydCTZzeCK7gw81FwGzxXbp1Ji3BGo6d6u0/5pr8OoK8+CfVdg5C6juRHX0o?=
 =?us-ascii?Q?c2Gwlm6X02aK4weNaPfG1YYjOP/P6XRfVDwIH42KQ7NfTPUA9FMDKrT0exEy?=
 =?us-ascii?Q?Lb3nRxE3mQTPUXpghVF0tbc693h9YCXLzGVXxWQy0WgEy4JclU2dgteLmp52?=
 =?us-ascii?Q?OoIkR60LDkVZ0xlHgY1IzWgl01XY0VydAQZfOw7cMUtbF4njLiGrEcAGJBLQ?=
 =?us-ascii?Q?UyY+dxSpK3E3f8qbq6pnf1tSela+Q6M03KJb7/VViQyLpT5Im5pTHR7hB4f9?=
 =?us-ascii?Q?Lmr8M5KX/BAGDUFEKoBdQKg33s4cMzLxy8Pdo42ed5wE6tcdkfCg5kGm6/ul?=
 =?us-ascii?Q?OJ3mzdHYAOhbHE2GfAGvsRfO8FShefDZ4Uv8ar9omceOXcn7yPqcJyUljTLN?=
 =?us-ascii?Q?sSxiCAdX2L9em8aiGa0svWz1diJC9ERTVB8WObss6CtQOyCVbnsFJ/9Z07sH?=
 =?us-ascii?Q?F9APvVW0v+mR4JEDJFHQ/fopOHFWhGid3+24sYpGCpktOndhUQ46I9kl0wgK?=
 =?us-ascii?Q?0rC/LghAmf4f2fIuPCyKBvxRg3dW9+F5aw0xgads?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77efaa7d-f7b4-4b5a-d410-08db82b308a9
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 08:36:06.0701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YKuaArOixuNbOSiOhKeKSsyamWd0MUvPg9pDljLBIF32FSYBDbuigDazT/6xTuJPRBe/47YA59orGK7eRGbw9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6745
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 11:52:26AM +0300, Dan Carpenter wrote:
> The simple_write_to_buffer() function is designed to handle partial
> writes.  It returns negatives on error, otherwise it returns the number
> of bytes that were able to be copied.  This code doesn't check the
> return properly.  We only know that the first byte is written, the rest
> of the buffer might be uninitialized.
> 
> There is no need to use the simple_write_to_buffer() function.
> Partial writes are prohibited by the "if (*ppos != 0)" check at the
> start of the function.  Just use memdup_user() and copy the whole
> buffer.
> 
> Fixes: d3cbb907ae57 ("netdevsim: add ACL trap reporting cookie as a metadata")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

