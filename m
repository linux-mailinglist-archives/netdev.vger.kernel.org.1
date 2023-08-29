Return-Path: <netdev+bounces-31178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 100A278C261
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 12:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3D89280FF2
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 10:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61CC14F73;
	Tue, 29 Aug 2023 10:40:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FBF14F6E
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 10:40:10 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B905219A
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 03:40:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWlpBzGgaDoD3U0jH93pNek1RwjasyPkwlYQHCpGB4FXowgnThpmlvouUs2yp/03yvb4nHiEST43+hxlyk4i9FlDhcY1xqCH72UQ18YXog7TGRkOW/p1oIfAjM8oA12uXolOhMmDjdx7OuZQq6oke5njpnRPUuzjR/rkBeuR1UfBXO7DEdJ4GBifM5NGBmt+ouuQRwJyb4n9x+x0NhSD8SVwvew+xf0jXswQ0WJVMrwngnbzx1nN3c/5PnpAnxfkOWq++XHXi1Hij9yBax685EeJbnc/j4C62zXvwMiP97aQUpXyPMAmGZGeCsUzUgWDSTLTsQL7DsDh2wZwNXpgyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyN9N5JJSVfgbHGWT0dFofVIUrSHJlesDAms79y4R/U=;
 b=jvGkGpJ85f4DA9w8fR660s3Fm6JR4YkMMA4caTnvGgV1YgEuN73mWrWOma/l87szfLPYqf2OwArEIecGv6EqpY2XsmHkU84Juvh4dm3rlY9c+ka1Rf6MfDzw7IGEBxrxbsndp96alQ+0N5ZZbXMrtZ9GEabXsktNbBwgJdhh34/aZg1FcMgndi2KHEnmmGo2+wwC2qV2uCnIZ3OOk6ySn5dFW5O0/ke6rBAo+2UXznoX/LjUYhkcqOBymK77YB422hwF5FyuxO3czHsHtLX78r5ZyfjLkc4Y/MYBwbhsksE9XvYHPl6DuyR6oNORCp+ylWlvHziZOyodHvylgKsQ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyN9N5JJSVfgbHGWT0dFofVIUrSHJlesDAms79y4R/U=;
 b=T+0F95G7esd9iJBfZVfWKNgSLjfMSdDsVbK94gzbwknhPrXe58znxRDPRLVAjXxtLUbOgsvqRzN8ZQ+vxFEoFThWhMwJVrRSP+niCV4w22/PjN5B9TdUIpzOv/DmWr5gpUo4nTL68B+XVL8TYFx3cqDsfjeNNpUGLgrtyLivFkjrks4Dm/XuokN2RpgAzRhjtX3N/UeszoUKJ0qHi7/8KCe/CvA/4ogQLGcwIqGKdRC+l7eh0g+POJnMNYBhOOtBt2poNzQHO2mNaQaMZLC+bvydZo5Q98GvNaGUebRAx3B0uDa6+bk5qvarFQw/UYxDCHv0sL/rDyBPnsNR6XbK2w==
Received: from BY5PR04CA0020.namprd04.prod.outlook.com (2603:10b6:a03:1d0::30)
 by SJ1PR12MB6217.namprd12.prod.outlook.com (2603:10b6:a03:458::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 10:40:07 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::2a) by BY5PR04CA0020.outlook.office365.com
 (2603:10b6:a03:1d0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Tue, 29 Aug 2023 10:40:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.17 via Frontend Transport; Tue, 29 Aug 2023 10:40:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 29 Aug 2023
 03:39:56 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 29 Aug
 2023 03:39:54 -0700
References: <20230823100128.54451-1-francois.michel@uclouvain.be>
 <20230823100128.54451-2-francois.michel@uclouvain.be>
User-agent: mu4e 1.8.11; emacs 28.2
From: Petr Machata <petrm@nvidia.com>
To: <francois.michel@uclouvain.be>
CC: <netdev@vger.kernel.org>, <stephen@networkplumber.org>
Subject: Re: [PATCH v2 iproute2-next 1/2] tc: support the netem seed
 parameter for loss and corruption events
Date: Tue, 29 Aug 2023 12:07:25 +0200
In-Reply-To: <20230823100128.54451-2-francois.michel@uclouvain.be>
Message-ID: <87y1hurv2f.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|SJ1PR12MB6217:EE_
X-MS-Office365-Filtering-Correlation-Id: db2ff018-586e-4320-0ae1-08dba87c4fb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eAuRWK7N9fKnMLV4Kv/5qhMqVLlofnxtUiobyaXQp+HM5+5yAsjSsNNfQYB5PEXS35o4idStvcxfiu2/WsP0Hc2/wFeunpUioVQaJcLPOAck4KhXxGxu/xO6fKlsXanzCGAvizV3DctPuhIC8gQuwO1cdDwAoeQ6gKWW+JEvnaidaLNk1uuk3s4ejiigEp8NDQObK+zNUs/9LSQnie7WGSSYDNPPROxdpD1BbiRA0z8lTtcSfFeK+J1ZcMRlEVKjHqqc3wUd/MgLjaPo0SecGuOrDGxiX28t/MvtFcsl/FrLExV2bUWn+jovrKPq8d1E6m2gJzlb0UVG1mJyknnr/qEdySL/XJhKYrOvanRfjkLp3AgzGJnxuPzpS9hn3NeGyT4FUwoVQcn3kvQ7P8kScANZZQEycHVfQRAolxaCqC71sMo33o+6xTcyo6eRIXEU1ACAnO4PiwP0s8Lj0yrhMSt5q1bwJBEmB3/M012/ebNMtXfpkyToO8wfZGWWR+LtrAfEIQ3tu6Hinh6ft5Y28B54zWrgRIVPD23UQFJNsAUIfXKAIKaoumpHOjz7nW6VMyQZb2vil76IFkmUaQewgVaEPFBkKEQ3Pw87w+rAzcJ4Rbpdt5ZdIPibq7CoRtnye3YLzxQ+hRYOJcs/8EGa+bFhWwTEbiH0JuTWYevV0Lcy3qKa++gXWsK+VHEL7gIcdA+LIqMBYwhM5opXuw9XPArg9f0yC7xseBI2pTyjhFcIdSuEF0WQ4nWjZf/bxapP
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(186009)(451199024)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(6666004)(2616005)(86362001)(40480700001)(36756003)(82740400003)(40460700003)(7636003)(47076005)(356005)(36860700001)(70206006)(83380400001)(4744005)(426003)(16526019)(26005)(2906002)(478600001)(70586007)(8936002)(8676002)(4326008)(316002)(5660300002)(6916009)(336012)(54906003)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 10:40:06.8795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db2ff018-586e-4320-0ae1-08dba87c4fb5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6217
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Took me a while to fight my way through all the unreads to this, and
it's already merged, but...

francois.michel@uclouvain.be writes:

> diff --git a/tc/q_netem.c b/tc/q_netem.c
> index 8ace2b61..febddd49 100644
> --- a/tc/q_netem.c
> +++ b/tc/q_netem.c
> @@ -31,6 +31,7 @@ static void explain(void)
>  		"                 [ loss random PERCENT [CORRELATION]]\n"
>  		"                 [ loss state P13 [P31 [P32 [P23 P14]]]\n"
>  		"                 [ loss gemodel PERCENT [R [1-H [1-K]]]\n"
> +		"                 [ seed SEED \n]"

The newline seems misplaced.

>  		"                 [ ecn ]\n"
>  		"                 [ reorder PERCENT [CORRELATION] [ gap DISTANCE ]]\n"
>  		"                 [ rate RATE [PACKETOVERHEAD] [CELLSIZE] [CELLOVERHEAD]]\n"

