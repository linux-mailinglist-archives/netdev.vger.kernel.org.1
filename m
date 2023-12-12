Return-Path: <netdev+bounces-56539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4893080F4B7
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 18:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5AA71F20F1B
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 17:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC0B60ED1;
	Tue, 12 Dec 2023 17:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qURSqUl3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3439891
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 09:36:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvSGU2ssBvvjxg05orXg6c2R9tpVHZy+Q6wSZvnUmUspBfGUyx1hggWcNISoxee7heMaq+hj2OV8XxTA8vSYIrwNEGtW+VZ1eCMhVhZm45mdirXg4Mwzq8T9AZ1kZjpuwfCuLNEMddA+kap1vHr/2OHTRlt+wPW0W4H1GzGgR2tpn6uV2FiuXeG1D5qJP2TalkPutJmC/uTqinbCkM7likt8OOjBsHdLzwxf8qMEjPXYcAPR5lzv6OIOg2ubAAMpShgCW+piBlA4ntKutjIxz05Rm8vFioSAlFf6dZIJTS6vyQc8SafR/5DnCQesFSb4K7aHzSsW0+uNyPr39Kv13A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYQjF6TkZFVwSmCfPGWyDUaS2tE68vAmYO/hZXocrPg=;
 b=AP9vii7wmMkLmEkGjFeTHhWtXte1bDWgnEIda6SRwdwbFsAgcvVoNwctow5qCLunmHGYAaE1UpDg5/gxNlUya0E18BcFEtkVprdy/BHPYaT40yqkNvnnYgVLR/LU4Q8LuN8wrC+RoZxkArpOwT99m1pCuAs7HHl5Wk1Z3AjsmFVIArQxu2jqaCpdZoK0hJcXwDbBDiebl90o4h5zC2rYpYGfJlzEfdRaYjTgEk7Qd5PJt0ydFXVbBh/ALwul9vzEotZof4+AOnwWqcWjKIcs2U6wLF2VVRJb1tHpcYtourXEQ2YSHl5aOVWahKYETfd2eEOwwHCu102JxcPS1Mcvtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYQjF6TkZFVwSmCfPGWyDUaS2tE68vAmYO/hZXocrPg=;
 b=qURSqUl33UOvqRVrkVIVPLDoukWhPWZyNXr7N9W1NP4Fxe8TdMyTJcnTr1o6VfStoosRp5M/gjFwnfvp2jMs+EYkAQDNHKpb5sB/FWB+Cp+VdyCUfG3GBv95FmMsKJPnM8TrJRYNI9pgvQXlJjGuC+thdZ1bTITN6jmtueKOBSRJVgeQVjWSdvjZ3wms0en+bQ6IkhghXvsocGuuRFj0qfT+1ZmRFX3HT9yxPYbdIhpLfa3EFi+nZmn+Kd/xOTltT2/pI3RVKKWec5k5lon6bUMupJwN7yAyR4hAqhZ3FiFPsXGDSkS45CW4E1nEO7JY5UoiZvGIkVPJzf4AD7hMYA==
Received: from CY8PR19CA0006.namprd19.prod.outlook.com (2603:10b6:930:44::27)
 by CY8PR12MB7683.namprd12.prod.outlook.com (2603:10b6:930:86::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 17:36:34 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:44:cafe::3e) by CY8PR19CA0006.outlook.office365.com
 (2603:10b6:930:44::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Tue, 12 Dec 2023 17:36:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26 via Frontend Transport; Tue, 12 Dec 2023 17:36:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 12 Dec
 2023 09:36:06 -0800
Received: from fedora.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 12 Dec
 2023 09:36:03 -0800
References: <20231211181807.96028-1-pctammela@mojatatu.com>
User-agent: mu4e 1.10.5; emacs 29.1.90
From: Vlad Buslov <vladbu@nvidia.com>
To: Pedro Tammela <pctammela@mojatatu.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <jhs@mojatatu.com>,
	<xiyou.wangcong@gmail.com>, <jiri@resnulli.us>, <marcelo.leitner@gmail.com>
Subject: Re: [PATCH net-next v2 0/2] net/sched: optimizations around action
 binding and init
Date: Tue, 12 Dec 2023 19:34:44 +0200
In-Reply-To: <20231211181807.96028-1-pctammela@mojatatu.com>
Message-ID: <874jgn727z.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|CY8PR12MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: ff75e76a-78ac-4c08-b102-08dbfb38e2e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xwJsDgy1kXKFGfHbWYCGkHocK4N363zocf5+SG6Hv4uDCecyMXrhjSogwRr86M3WxYxdBmoRFliiMf/sFshIV1Zt85sFoUqdBETENRR4/hD4/PZNKLbw89at9GMrdbuUnDadMq2oQRiwP86uvvu0Gf5ATgeQ8jWOhkYp7c34al5K5kyfi9y+3qjATThrJ6yPBh5fmfaINcz/pwtsuyWp7s9a0XbET+jhsMxjHD8cz/Br1guJBcGE8PG+HTRWhNLT07QRNkV+Fy5wfCNGouPJKJbho2lcUK/QqIPmBFL0im/xLOVJo/JA+18YeZd97ah9ahCIt7sCmiLNDZKY54S2kZ6s0Kp3EqjKi62yL2s4sFPxGs75hILf6ET6vBgBIhrfS/AztSvgOcYtTbNha/NQrdzJVjg4EH9lwkditMOGhp4A/18oMM0WJqQrqvoW7U32T2tCRCY2/QolfH7sf616SH9MJulgkz5cztDytnIDz8hi0PkSLGSt7Fx9Y3tXAsTIlzfIYoRxu9lrcLNwW34zWWbj131rD+9UGRSybBQwtO+FtQMJ0rsMrkPQ+u2vnjqEn61tlhcdLi+PtUA6A1VNEOOwDtEmmc0c6Jvx5yKpigozeS10wo2U7v8DeWJrxq15Cf3xLtxVmXoIP0ms5nS0/a1MaQDkNjo8bTR2BfZdqDx8h54kTTv4FVE+DV9i2Wiwiq8rmv3vA/qbKphp99drXuGaq+aZTcZOagPGIWsd+NKzqnZTT7T575Uk9UylEM9E
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(82310400011)(451199024)(186009)(64100799003)(1800799012)(40470700004)(46966006)(36840700001)(336012)(40460700003)(16526019)(426003)(83380400001)(7696005)(2616005)(47076005)(36860700001)(5660300002)(4326008)(41300700001)(8936002)(7416002)(4744005)(2906002)(8676002)(478600001)(26005)(316002)(6666004)(6916009)(54906003)(70586007)(82740400003)(70206006)(86362001)(36756003)(7636003)(356005)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 17:36:34.5160
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff75e76a-78ac-4c08-b102-08dbfb38e2e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7683

On Mon 11 Dec 2023 at 15:18, Pedro Tammela <pctammela@mojatatu.com> wrote:
> Scaling optimizations for action binding in rtnl-less filters.
> We saw a noticeable lock contention around idrinfo->lock when
> testing in a 56 core system, which disappeared after the patches.
>
> v1->v2:
> - Address comments from Vlad
>
> Pedro Tammela (2):
>   net/sched: act_api: rely on rcu in tcf_idr_check_alloc
>   net/sched: act_api: skip idr replace on bound actions

Reviewed-by: Vlad Buslov <vladbu@nvidia.com>

[...]



