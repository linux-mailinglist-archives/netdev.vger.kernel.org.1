Return-Path: <netdev+bounces-19514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E2A75B08D
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 15:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E5211C2140C
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 13:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DF0182BF;
	Thu, 20 Jul 2023 13:58:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A122B17729
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 13:58:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A34211F
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 06:58:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSdYzu0xpmRv5PrrwIBOTw0Bfq90x0Rg0rm8ZxM4TEpVWmO12bFTOY+Tm019cSTcWfVTU4hBVY50EbrvuR7yclA7ikmCPTvuqq0/CFBgC4kp4GqXBLblog1RqVcXc6yIJjM7WaUKqnsGBNJ5m08vsor19V/pZvhA5wIxEcEtuAwl06nuduxXtQxIJZ4CMdZ3lHnoXaHIXlrjYihvfH25loSFcfrpilUD9JaI5sqr1AFBDqHpI3h5GCsHk7ZWcN0y7R11vDu0epPMqbGgfx+armTMn5Sxn/IY4Q+EeV0OaW11Zlj5Jpgo3fPtWqMWhbCu/7mXJDORP4vEp9KFx9h+7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qiUovLKQ7u+0U+KzBsI6ahudNikT/Z8zYJtdqoHgWPY=;
 b=cHb1bylruJMM47AxGXcmQu8oy7shqW7WdOx/I0ap7uAg+0withZHMx/lJw+MSUQNcwe6sDV2UrsOQ9ms0jUG7UtmzOtTLYUC3Czt6QUM1/Zc5Dz7g7q6YjBLiBSh84N3dorXb0r2SSXqhyqY+Hy5Gbo41k6bIC24QU/tuG2tCNtyrwmhRs7k14PsIoZAIrqi5QfQRm+09Viu/YHyZ55eiPVG7IjEmIexdv4cXCibG1+ydOqw4VFGAfSloz99nc65eHopzQJeUyeNxaeOIBjF5gLl1k1DWC2X7UbCSYuWUNtyl22jMMu70OJeywL9oHxvfkzYlhuUH96ldI0r6IHa1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qiUovLKQ7u+0U+KzBsI6ahudNikT/Z8zYJtdqoHgWPY=;
 b=V85huEJMgTfNOvjB9OQnphaVoGvhgGxL+8hjoxA3u4/D2538eZVJu20r/is1CEZNPVjWsCi3dCsdqVmPj18xH1hLPRfFAxfJmLa7WTZiduDh0Wkz8/kc3izRyRjLSEGSc2gWLG0tuQnHvIYKRAE/A8V3PrtR8a7miQtsL/5E7ojIEjQNuMjBD1YWDTkBk7RxqGq26W81oVBRkMv8XcPuIa9mgF9YaG8fgAzPLfb4y846APpFfzthh+X7l4GqC094TXuY2LhIjBubfUbT5RWmW9Aw/hvtYmXzDuMMUd4nZfhq9C4ey05wzROiPONbPgQb/Ejsgj1eO5XOBu9IJ5YvpQ==
Received: from BN0PR03CA0026.namprd03.prod.outlook.com (2603:10b6:408:e6::31)
 by PH7PR12MB7379.namprd12.prod.outlook.com (2603:10b6:510:20e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Thu, 20 Jul
 2023 13:58:26 +0000
Received: from BN8NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::6b) by BN0PR03CA0026.outlook.office365.com
 (2603:10b6:408:e6::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Thu, 20 Jul 2023 13:58:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT077.mail.protection.outlook.com (10.13.177.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.28 via Frontend Transport; Thu, 20 Jul 2023 13:58:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 20 Jul 2023
 06:58:13 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 20 Jul
 2023 06:58:10 -0700
References: <20230720121829.566974-1-jiri@resnulli.us>
User-agent: mu4e 1.8.11; emacs 28.2
From: Petr Machata <petrm@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: <netdev@vger.kernel.org>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <moshe@nvidia.com>,
	<saeedm@nvidia.com>, <idosch@nvidia.com>, <petrm@nvidia.com>
Subject: Re: [patch net-next v2 00/11] devlink: introduce dump selector attr
 and use it for per-instance dumps
Date: Thu, 20 Jul 2023 15:55:00 +0200
In-Reply-To: <20230720121829.566974-1-jiri@resnulli.us>
Message-ID: <87r0p27ki7.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT077:EE_|PH7PR12MB7379:EE_
X-MS-Office365-Filtering-Correlation-Id: ffe652a4-5119-43cd-cee9-08db892963c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	r8zbyh5+wjbvRrn70A2V5PZHKhPS157OxA2dwSWuTRxXn6yO61pfr2x5r9o7NYh+S9dpL7YtM8Kd70iq8t+rPNxdB++cmLhrBO2fYiBW3axpaRV7KrJHzlVCMNM+HD7zGRfY0UvtQD732dAdYM2yx0sX5ap7xcEVtlQPDCcVTOiZYgBXNj1/v9pZV/mVfIUan1tK+nCj3dHoTbwnnn8vGhcv2ynFwKHrGteXuleLJf82cl3ne2LuN94kAxgm5WWt5DpuWpU81Y+JPSDdldvhH89oc3A9//Kp0GcWiEBSgzvQkQb3GHeX6HrmpgDeko3k0wBKcQld8FXDTeiSu8vK0NnMDLSQ8Jf+iE1nxkAesN61AMvdevIUXIKNM1i8FF4Pqe/QoeFQSwWHp64hvLTCnoNISNUXEFPWnxMaA6nHTcodNxfaSx9L1OSwnZoTrff9ScZ1acVMYer0eExkE82mA6i3GMfQL4FXhV/2X84hknejlnu69oEXmVqR/Hbylw2188Ued6qrZ5yUVA9tIeFF8ro9jdyqVolofP+8jurDePY0+pX55BhSRoXorQY2jLiZg2HpLFkq+XSbGGlB0Zcy7yrfAs5sF5I0yCRzhc6MowAXvTwTy9CXFaYAa76h2ydrrlM8ABVeMCBYlKBuyqQhzf5LPj+DjXJcCkmm3Uh/a9ExlRuXg9pdkdY5BTck4dSm8ZLxTAYoGLmZ/KqgQ08Qt8TfDSBKHjyB3fa5lJhrALM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(86362001)(82740400003)(356005)(7636003)(36756003)(558084003)(40460700003)(40480700001)(2906002)(54906003)(478600001)(36860700001)(4270600006)(426003)(2616005)(26005)(186003)(336012)(107886003)(16526019)(47076005)(41300700001)(5660300002)(6666004)(8936002)(70586007)(316002)(4326008)(70206006)(6916009)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 13:58:26.0151
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe652a4-5119-43cd-cee9-08db892963c2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7379
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I'll take this through our nightly and will report back tomorrow.

