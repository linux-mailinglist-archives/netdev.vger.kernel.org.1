Return-Path: <netdev+bounces-31620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BE278F0E3
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 18:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F63B1C20B13
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 16:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F7513FF2;
	Thu, 31 Aug 2023 16:07:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667C5E57F
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 16:07:08 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C3110DA
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 09:06:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+s0tNz3muI0YAYaq9TKdHK8JxXss60AZJNgQapN1m8AoTjLWQT2juxXfkBu/OXVKzyOHV8tDBGxv4O2fnIetXBRhbRaB5ZSZV/lz5UMiFuIGabOlwLP5DquI7/kC0RVDSp2vLs+V+y370pJr2eXBmrn2b4RlhzqGpTs280ca80ILbuDH54zY65Ov07nmO4zdQNyzZggnqztR+YENrVGiATv9/Nnmmt6nYF7B5t/0JcvCAveR3P7LUTUbHvp9BQfmALFAeW4jHmBof+1D5tLP3lSlpAaeWr8bg2B7aiqDcBL0U5qL04805gyHZmjxK1bFyH1lXSprwLPXhwMcpzU3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdqYCCzW3zkZfn/aQeYK9TZvWcFHE3A8dOdYZsuO5/0=;
 b=CbuSKH/BQsyobFJorLjx1aGZ2PoudG6pVkFejRuCL0N2Z9jrGcjPUyYuU0q/YpQMebAa0NTPSd76c63P2UEFy9H/t4pzj89nR6IkCrMFDQg752UhSbwBG8/vc5quceRYuelQ5tIaVvypSaFsFV5T5k8u/QgykpO0uRONhMyRopeb4b7uU9esfLwJ51u2q5BgZonT49OilcmfhRCF5mSUHo3HkbkXG76bfuGBTzo9b54hRZgLXoAuDYCTtESEWYMQXq3C09zJKOSrQbajExGNU8bvREHurqh47pgyqJmn7FZmpwcNnW0k2i09wMuRtVHHxBPuYXrWk1dQ8b36gf1EHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdqYCCzW3zkZfn/aQeYK9TZvWcFHE3A8dOdYZsuO5/0=;
 b=mmfSGhwoINxQiAyI9x4u0KJnChKu2u3UcKN0rxh5UkqD0air8UY4JIH1uj/lcBIAsKYEQ8OhGtASwIuzvSK/UPTNHqlgRxVpMBQzcMvynqlG07OTWhstjlOTkGGpXE7j0nG8lt397liZOQpsoZGeYC7XC+lKJaIqUzr73xMAphCcORGHOJj5fI9LEnOGcjnI/5RhAg47UdDESOLIB/MtGk4+EMfDPTL0oXCH8g2C4UesQvmKmrErntBqqdK8edOsyr/1aJRgBeNFLuKaKd2ugcQeuhIs/amXLUSWqDz3y3faLi6LWCKwsGshBTSlWN8AT03ut3hDWJorZokiNwvufA==
Received: from CYXPR02CA0079.namprd02.prod.outlook.com (2603:10b6:930:ce::27)
 by DM4PR12MB7621.namprd12.prod.outlook.com (2603:10b6:8:10a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 16:06:20 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:930:ce:cafe::d1) by CYXPR02CA0079.outlook.office365.com
 (2603:10b6:930:ce::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22 via Frontend
 Transport; Thu, 31 Aug 2023 16:06:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 16:06:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 31 Aug 2023
 09:06:09 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 31 Aug
 2023 09:06:07 -0700
References: <20230831140135.56528-1-francois.michel@uclouvain.be>
User-agent: mu4e 1.8.11; emacs 28.2
From: Petr Machata <petrm@nvidia.com>
To: <francois.michel@uclouvain.be>
CC: <netdev@vger.kernel.org>, <stephen@networkplumber.org>,
	<petrm@nvidia.com>, <dsahern@kernel.org>, <donald.hunter@gmail.com>
Subject: Re: [PATCH iproute2-next] tc: fix several typos in netem's usage
 string
Date: Thu, 31 Aug 2023 18:05:41 +0200
In-Reply-To: <20230831140135.56528-1-francois.michel@uclouvain.be>
Message-ID: <87h6ofryc2.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|DM4PR12MB7621:EE_
X-MS-Office365-Filtering-Correlation-Id: db221bd5-7151-4013-a196-08dbaa3c36e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c/lTXQRwFHrHm2qNdluzdL1BIO7hcmSNgY5hK/fT4gQIcoZgSMtbtBxzN41wru+OwGO94oZyu4/QJRLVkjUWaFOpDEe7Qr3zJ2VY6Wk6UufvqK/XoOqwAQo+iwPTCJdRTU4apQ1U0vbmK5+NhXnYDg7x3uBOJjS3LpHPoUXg+lXL7cp30Kv/NhSunjghaBxB5MUt8SCCnKTWWXCl496eJg0MEb/q5OuXvXXBGD/bQcwWc4Eq0tAze1ubGWsxOvNtZU+sTzGLR5avjJwqH0FSFrR4iV9cX49Hae5CrpoMS663aZRHrlGVpnHzzlbtSp0vtI1iIvBxLCbDuFRKQ1/7AIXARC/8CvIcwazBWThRqsy6mW2dMFAL5PadPHPStJolM2s3sij0GTywc4RO1QsXz4nm9aCScoZevOGH0mquTQfXc4UaPvz+3UbelDSbW1knHi8VtkZrBTqqg7zu6IdHFeWueC05p38+UWThIYVPhxOV2DG7zt4IRwMfPjN+32SAJ1Oop0z3CYh1YaB93imseyaKxGti9zoK/YS6ni3zpqOTCTrGmekv8L0bCC1Pvcxv1ml1380/9RS0WSQLFaFu0+B+lRv8B7DGR/FDsX625e9pDfAqyqbKwkpQT/OIFLKqGVxEcf2FI3a0RWSBX1B2/5rAR3vjMAsnqYnH9vcND+CQhB+/LBWbH14cJLu64N3D9E/yV724ENgkZs7+cZN5tCyFK41S1MvxcceB2qJCLk6CKi3kRD+Crw1fguK0Df5Z
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(1800799009)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(36756003)(40460700003)(40480700001)(2616005)(8676002)(86362001)(41300700001)(4326008)(5660300002)(8936002)(6666004)(336012)(426003)(16526019)(26005)(36860700001)(47076005)(82740400003)(7636003)(356005)(478600001)(4744005)(6916009)(54906003)(70586007)(70206006)(316002)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 16:06:19.7873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db221bd5-7151-4013-a196-08dbaa3c36e7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7621
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


francois.michel@uclouvain.be writes:

> From: Fran=C3=A7ois Michel <francois.michel@uclouvain.be>
>
> Add missing brackets and surround brackets by single spaces
> in the netem usage string.
> Also state the P14 argument as optional.
>
> Signed-off-by: Fran=C3=A7ois Michel <francois.michel@uclouvain.be>

Many thanks!

Reviewed-by: Petr Machata <petrm@nvidia.com>

