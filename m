Return-Path: <netdev+bounces-62825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D944D82983F
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 12:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0AA31C21CF1
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 11:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599E141770;
	Wed, 10 Jan 2024 11:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YWaPK1Fr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90CF41205
	for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 11:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1roHUg++EnS8oGBPQoa19U17/twaUp2gQL1EZ1gjatrxB3wEpN68LZUSFQ/ZlNvQ6KGPBE/4fsNofKFuuIx/XYkXicywNPdXTd5f2HjaTwIOhl7OZk0eVsdeYO7cOMJVekEjrQmLEPcGm9jhEL7mpInT05gsi9ktozBRsm0M3iL9sQKoohGB/z3wyrMrSy0VP+X51bORhx4czPXhKl+jRLptAmnrUyCplRpv+uJWIbiF3dxrwPRCa0x2fPIMZAySgpkIHWw8ATJwouPX80D7/HAFtGSmKRDe98J2AD/yFY2PxWbyJg+S9rQBqgWou+rL+O9XkExjHHF4ESgY0WUUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0ACYTquFCUJrV5suT5GdeNq/2geAjqu+3car7Wg0/w=;
 b=J2qMRyDSjce43FJjD5OiQI65pcH+OrQOyrtOsDMDnVT976gq5ySWt285tVYEIyjVs3wuvLPWsoAPp8G9AUY9zTZmXyvIsdK1gv4eelBCR04QVEzXWqC9M0xCgQgXlZ5QXd0bIMlUPMkyqHdG4udS8TEtACw2rt2NCCtoOvqi5oI+uOp9NT2GcQu7BvZOC/sBbGduK1CZdO6xZ5X6wQtZo/tCxrqqpyxqkLNu32Nyxv/xVmJpoceQ+GhBdL3JbGZEspfn+FLCYGumAcj9baeWPJ7DBrqR86m48KPPae/0Bofo+DRrplwM5azm9CQu+X0dGxPfwNOitOJuNHiq7XtHKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0ACYTquFCUJrV5suT5GdeNq/2geAjqu+3car7Wg0/w=;
 b=YWaPK1FrXoY9S0XZtUTeBevihsh7rC9eJ0kzjs/qcXB0bJbJ/75lVC+q8aCX3dI920vKnuUQ1zzdo/RMXfVSHk5aSuuXL1gJuhC0AGIu//cA2UPeEsf+2gaxY6gV8TFMZlTchPZJQkLs3iKvjUP1eQhWaBSO+kNzUd453U+S/EuN57Dv9bBDO9i5RcWnraJTbcO665T+v0aeNIKGoc5+bx45h4Vl+NTVg9FU8mRm/eYzw0Amxevmtip803TyKd+WbnhPAJO28b45JnLAkQac+hnRq4WOwbwgwYOIYYU2sYbUyooH7QNexn3hxqbRVUDCqjaqoFHDebLnzHgOXCQamw==
Received: from MW4PR04CA0109.namprd04.prod.outlook.com (2603:10b6:303:83::24)
 by DS7PR12MB8324.namprd12.prod.outlook.com (2603:10b6:8:ec::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.17; Wed, 10 Jan 2024 11:03:05 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::59) by MW4PR04CA0109.outlook.office365.com
 (2603:10b6:303:83::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18 via Frontend
 Transport; Wed, 10 Jan 2024 11:03:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.13 via Frontend Transport; Wed, 10 Jan 2024 11:03:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 10 Jan
 2024 03:02:49 -0800
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 10 Jan
 2024 03:02:47 -0800
References: <cover.1704813773.git.aclaudi@redhat.com>
 <d7b588ec35b3e5a7b4dfb2fdacb54fdbbe903585.1704813773.git.aclaudi@redhat.com>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Andrea Claudi <aclaudi@redhat.com>
CC: <netdev@vger.kernel.org>, Jamal Hadi Salim <hadi@cyberus.ca>, "Stephen
 Hemminger" <stephen@networkplumber.org>, David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH iproute2 2/2] genl: ctrl.c: spelling fix in error message
Date: Wed, 10 Jan 2024 12:02:36 +0100
In-Reply-To: <d7b588ec35b3e5a7b4dfb2fdacb54fdbbe903585.1704813773.git.aclaudi@redhat.com>
Message-ID: <87h6jlo3hm.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|DS7PR12MB8324:EE_
X-MS-Office365-Filtering-Correlation-Id: a72dfba6-b108-4cd3-4fb4-08dc11cbb853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q3huKX4gxD23hZMuDWHXIjUgBvq8dM6lupinJZurLtG8P7mEoCuvvBCbI+c6wOsS+1AQRMoKermWUjZuRJzk1L1qMpIT/oixDGdzS6ey2dIujqwtKLPxitjFiN0xEiIoOyuHYmB7kjL4V8WJppWD89i5JKpyQHxmYPWTM0GHOC/UKS7E7x1GwMOULxYqnKKbB+RmetbFOJ3aETi5UsILY1/TOxQcs0XxK47RxsMky98F9rD7JlMJDKsDvgu/iDQxbEVo7d66M9fyp82LXzxIZnG0YvXzoXdR0rwGEYjnbxRggnnxdqfhiJjm087O1epP8O/pueVy6twqiuJ8fsw6soisP6N/D/3Vz2zo8Z3Qo60SEuCjh4c0BP1o2lybCKnoUnjshG/rEfKZHrJFvRlPK0Q4MZdR2UdW35JDpsDam78WKcWEqmuRdlUa5Hnkoy3EnNU9C+JSbI1OrHZeheHzKPKm/qrvFnlnuRyP6glhy8JzNtQJc89esxAr08sYjKYoG+ljuxeUrfk4RFzoWA/PGGz8ktR1dEic5N31sUucWlx3vguZOnjO2po8DttXzwohj573NHQT8Ls/iDEFwxmaq3zE3vP1TURTaKRQFD4rLkZib24lR/jQXKAZc/Ce0H58H4B46MMyfYlS4iDBm0Lttj9/8xLgQ+Spv0CC+F44s7lzp3VU4xZai/9OIJjJqDlDuWUE690kq0tsIgiumqiI4MM76PUwjcJ/W7/a0wbGh+Kn/0PS3J2SlU2ri2OpzATP
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(64100799003)(82310400011)(186009)(1800799012)(451199024)(40470700004)(36840700001)(46966006)(36756003)(40460700003)(40480700001)(478600001)(86362001)(558084003)(16526019)(356005)(36860700001)(7636003)(82740400003)(47076005)(2616005)(426003)(336012)(26005)(70586007)(5660300002)(2906002)(316002)(6916009)(70206006)(6666004)(8936002)(8676002)(4326008)(41300700001)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 11:03:04.7487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a72dfba6-b108-4cd3-4fb4-08dc11cbb853
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8324


Andrea Claudi <aclaudi@redhat.com> writes:

> Canot --> Cannot
>
> Fixes: 65018ae43b14 ("This patch adds a generic netlink controller...")
> Signed-off-by: Andrea Claudi <aclaudi@redhat.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

