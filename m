Return-Path: <netdev+bounces-31430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6A978D718
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 17:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 716721C203E0
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 15:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025C26FD5;
	Wed, 30 Aug 2023 15:36:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66B853AB
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 15:36:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF26113
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 08:36:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtPHvRyIq8Tsi6LujLIQ+wOzqKStdIOYGd41iIEHF/hlmEHBFcNzzAqEps1ZgtvUf0pGHtJn+A+KkHpLzXxtgvRrofB5VO84QLree0AkrcY2rn20wapz2XveZ+964MSSZW9HtEkyXkrNsVPZUrinHUZHzaX5XtNGCLymKmoNT4x/aLN6tsQwLkOr9tVUmO1WJM51pUvIGfHYL7+6+T1hk2o9n+bigOwc6rmI51czM5+2j4Wq/HY8gjALebxCh1O5VEB0VBLkja3aAoEg6WRfWQ5tAxWCCW6t323eI/9HET+eXA5YYiT/2Kxfdqv2QU3RkghDJyUc413bwNra+u+O0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rE8x8CF3qflK/TCtyJ3mSrmGOZbtdXynrkA6hcrUjwQ=;
 b=iY1/XbYAmang6L3f1UWq3y2cOpty6Bg+qq1VaLmLI6/Oveq6iXvPqTdNHsrQk2IVfbQU6BGPP7/6HFCDSajVelSsQqaOsUwXU8242MBc7B+9Hsm/QcY9uRtxS8LnKo0xn/+QWew0IaZjBAm1Qk6dfC6A0FaO0DAW3fzd+Z/MdjgGSKVP0vJpYXFBzyHQczyzrhm2XW3/JiKGhprJY9rMw5migZX+O3EA5JencdVgXTOmcRTjaVftX3Ke75LuhIZ+mhPeXV5H03ivuXmi3ZWhB1NEb6Zhq/CYc15bCyPsRhE/2CuNhvwu9SKfYvQ0o6A0edLTYsy/iZrHH1ksP5+LLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rE8x8CF3qflK/TCtyJ3mSrmGOZbtdXynrkA6hcrUjwQ=;
 b=kHDixRkTWBYWrUjjAkVzvc8gEPnp+tSz7gLbWDV2jLNPpfLYD42LSIeJjJ3E56/jT+7k+579OG9qyoXOSay10QQkBJUwsMCu9m6AmC5QosvHeQbtwQMyZoCnMoy2sQrnvH6LX6MZRe7RnCf66ExhQBPYqRF656e70rDyiehtHFbiaFqLMI8aEzkJxtqNkqzy92rJXD4YTBiEkbTk+SrpB64FOLkFnQey2UdthecDkkB3D888TxI3wlPrEfs3DVaQ7D2KWzxlY41EeT02kDtNlO3l8H6UMtTPbSCWrfvcf/Lwa25B6QD/fGV8xI83zPa1p4lCAKG+eAyCI8S3CMhHaQ==
Received: from SA0PR13CA0015.namprd13.prod.outlook.com (2603:10b6:806:130::20)
 by SA1PR12MB6970.namprd12.prod.outlook.com (2603:10b6:806:24d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Wed, 30 Aug
 2023 15:36:24 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:130:cafe::78) by SA0PR13CA0015.outlook.office365.com
 (2603:10b6:806:130::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20 via Frontend
 Transport; Wed, 30 Aug 2023 15:36:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.16 via Frontend Transport; Wed, 30 Aug 2023 15:36:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 30 Aug 2023
 08:36:08 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 30 Aug
 2023 08:36:06 -0700
References: <20230830150531.44641-1-francois.michel@uclouvain.be>
 <20230830150531.44641-2-francois.michel@uclouvain.be>
User-agent: mu4e 1.8.11; emacs 28.2
From: Petr Machata <petrm@nvidia.com>
To: <francois.michel@uclouvain.be>
CC: <netdev@vger.kernel.org>, <stephen@networkplumber.org>,
	<petrm@nvidia.com>, <dsahern@kernel.org>
Subject: Re: [PATCH iproute2-next 1/1] tc: fix typo in netem's usage string
Date: Wed, 30 Aug 2023 17:32:01 +0200
In-Reply-To: <20230830150531.44641-2-francois.michel@uclouvain.be>
Message-ID: <87ledssftn.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|SA1PR12MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fcca471-6f7f-4174-d1ad-08dba96edd5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Vd0ba7S6BV5lMJK0L4lDncdjL2W/E+tgeJSt+/GzCfk80qEMNATDrrDF27yaAT0CMsQcJWomH8Id3jdHQbppg+7O47auGtHsH0k5biCMccdMufmVXvm+OqnY97WsqPxkgX0KKCPxnpRxtvaKrdo+Q7x/pRJTviHfHdJHzt2xxfK7FjTWJDSnJ4RzZU/oYea/zKaxI/U0hlwgfZ3iDBu3LfRfJpDUX7a8p9GnvOuqhRoIQCNM1QYNRR7vbOq4WEuSkQos9Y9sAfI0COsDtQBcC2kPPzJ5ckOPlESxHko+JniEx/I+U9cZKLk4PjwHRYjvINy+gCZmrrWI2b5elulNuWOaTVkNBR9fbCvFdOSTnIEHRejio3BajJXLIUsdOwQAVFVvrfFC2qsgFFXsMe5IslMBSmVSmQ0ZW5WwZoLyeYKbZRVy7v7nANdYhFUiZ7z9pIVAY/7a0h4wfp+eeuFp5WAKalBHc0s5CqL3VMtAxybBvwqa4AxgWWeW4vV+kRd1S39OLuu0BthndSG/SB0IvsZZyWTtXLJa5m4u/u7I3ByuP8uao3+/2zdW8GvBrQrPbkQiR2ajvUjy/zh+GOnhUNq2XtuHUCqO8JhzWrU/LLDIyu6YL+Bla0KDRHu4EFw1JZ2x+nfdtVDhbcjJLTFOPJ3+EhdmvwrJZbBXoqGdp1upeQBq35sSZnpVD+Ab3J6WW07EQPAuuUpsAXWU/fb/Kvrk4SyjR0lMLQ2YE5CPiaE=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(1800799009)(186009)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(356005)(82740400003)(7636003)(8936002)(6666004)(70206006)(478600001)(70586007)(54906003)(6916009)(316002)(41300700001)(40460700003)(16526019)(8676002)(5660300002)(36756003)(2906002)(2616005)(4744005)(47076005)(86362001)(36860700001)(40480700001)(26005)(336012)(426003)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 15:36:22.7191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fcca471-6f7f-4174-d1ad-08dba96edd5f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6970
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


francois.michel@uclouvain.be writes:

> From: Fran=C3=A7ois Michel <francois.michel@uclouvain.be>
>
> Signed-off-by: Fran=C3=A7ois Michel <francois.michel@uclouvain.be>

Reviewed-by: Petr Machata <petrm@nvidia.com>

That said...

>  		"                 [ loss state P13 [P31 [P32 [P23 P14]]]\n"
>  		"                 [ loss gemodel PERCENT [R [1-H [1-K]]]\n"

... and sorry for piling on like this, but since we are in the domain of
fixing netem typos, if you would also fix the missing brackets on these
two lines, that would be awesome.

