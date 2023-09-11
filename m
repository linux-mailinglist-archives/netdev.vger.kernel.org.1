Return-Path: <netdev+bounces-32804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 526D779A753
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 12:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 763631C208F7
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 10:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910D8BE6F;
	Mon, 11 Sep 2023 10:39:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F181291E
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 10:39:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91641E69
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 03:39:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgA3PaS2mtcgUkTSWMndoXLqOSpCyFkPL0A0WIJh7u2s3ZDkumlsR7L9aJm5ScBeDyjSi7fJT0K8A4xl8Fn+xxaoaCmODsKyGb69YDxfBO6L1S3O0bXIxQ0G3Jv4Pm6+pPaA8bdwyivVuhqjBYyU+EJCOM9O/N0+T3VORI/fSr2Wj59biTgKZMo5bT/23OucHLZieCpTSaIaPZTfJlBDKdov1Yp441C2BQk5bWXtrG3q9ag1nmTwcD25LM8UtUzyhw09lM1ELiSZgqEx8WorsZIsDmdSnBWErGrZYWhSvjPTbfo1Sgvpfkjf1DcosDAzDJDcs1IQ6pm+ttSUgOG1Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=637qcsIS9XlQ8LGt6E3Yke4VYBx51KXm54EYHXWrKNQ=;
 b=l+QYOvoDpnMOE+DBUeoBnJ9m3F6JIljiIR1KU/VoNfWih8lGRxRvpmJwgXsxCDGah723Qp2hAbgt61PkVAJ7pTizmpJcPpZx9d37VVSbVgpxSFfZEm3//hu/31yBklzJBiTHgkLkCaHvmIsaVr4Nz+PMJ3i0pYVjlrNLZjr1b+VDL2sAUsDGyvWVM7mTjZ6TtwdlutpXie90OUv0NZ2GuaqAoRk2Pq3ILnup5qKKclrQnFHW89g7iXucP12Oc+FIlrrD3XGRFGT2dK7+G2WklTMkl1V0ZQU1mFQr3Sb5dWKqFAcEn/M6+5q70B2JrLmPTgTOgxn466xJH0W1I4oj0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=637qcsIS9XlQ8LGt6E3Yke4VYBx51KXm54EYHXWrKNQ=;
 b=Nv9G8jK/qLXB82/8MSNg6CO5kDSySwk0JukwQsrFF0Fd2XQqHenFFDHjuwXo/DFhe3g00RYB5z55PDs700ljoGrouNBxkvUlKpwXtJLBGIgFjrx+msetsqei7x3nt9BI3VbUwMlAIKApUndRUlTY3PWfPgGMzdwi0YaC6zk/D/s3u2klfUBZYVEuiJtbvkNn4P9/kLzk0L2hzFysYE7XgrA7yXXQ/iCOIW/eV0a8N6SDO7fIVQMJTAogIadM4r2u9O9kG1WoDQHe7itG419Zc+p04FjFefvozUIzvDm2tAhteq7mj9p7v5Rn3Jz9soLWVTOfOPcwda6SP3XNUcnwKA==
Received: from BL1PR13CA0128.namprd13.prod.outlook.com (2603:10b6:208:2bb::13)
 by SA1PR12MB7270.namprd12.prod.outlook.com (2603:10b6:806:2b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Mon, 11 Sep
 2023 10:39:36 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:2bb:cafe::37) by BL1PR13CA0128.outlook.office365.com
 (2603:10b6:208:2bb::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.11 via Frontend
 Transport; Mon, 11 Sep 2023 10:39:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.17 via Frontend Transport; Mon, 11 Sep 2023 10:39:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 11 Sep 2023
 03:39:22 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 11 Sep
 2023 03:39:21 -0700
References: <20230911044440.49366-1-elasticvine@protonmail.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Petr Machata <petrm@nvidia.com>
To: Sam Foxman <elasticvine@protonmail.com>
CC: <netdev@vger.kernel.org>
Subject: Re: [PATCH iproute2-next] Enable automatic color output by default.
Date: Mon, 11 Sep 2023 12:35:36 +0200
In-Reply-To: <20230911044440.49366-1-elasticvine@protonmail.com>
Message-ID: <87o7i93sfc.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|SA1PR12MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: d020477b-6830-46d0-3028-08dbb2b364ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iWwr2Ndu8xZJ7416c0g5Xxu0pRmMFQdg5l+3qyjrVKfkUcu9XUng9d1Osl6U6U0O2Vg5KYe2Ri2yNs2v3cXFwg2hK5USoo2WKoXzkh2+SmC6Ms4t46iqVAvTUMvjZ8rLbkMb9vYS1Q8bFV695+wNznmicmPvo+1jEszw8f17/lJQlfCGUZKxEyB56waSpSwlsd17md6WOoANDePPpCxpydk1jaXmFEwWQx1okGpv8NR8Nc69AUJcExaC3jwzSxjBY3smabETSLklamFulxyOH3COkpRBxB+QqOYtfJ+iic9mjm8NPQJ1b2jdyeqfJGksRiGa8qAa5PkS6jRG5WcxMt8c1y+pn2RvaFCI+jY35L/+iyhh5ZzzsjRVUgyimqxw7Pf1rEuyMtpsbC3RQOwgFFUfludUr6CkoZUWBHg58LMrWrqDDv40xpFrrOVuHN+vYFFY3xVZpMO8mVz1aJXUxpe7rPWO2DKcEgxuirWCgSX4CnhkZdA+EDXAE8EWNo3cswopXBybkKKqW/4W5ueYrxNxagTvnIy1gqI24Oojo3Y3xP0XhPG4f45PbsXmjeYuwnggC9LhaFKPVQmz8EBwjdpMrJPlBmj/RvJAk6d/8gzi2djic+GmjywRtQ6UCWUi/hwraiqi8U90pvmoAXCW3t3uvR4YGkVIu11y3YIokKDaZP2PHLQ6Jt/Q9/DvxSiZxmNU3ohLahhyAJ0cN1JrQhBNSsYReLWoVMQvFYQoRQPReVx8gzQp/s7iMj7VMVjH
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(82310400011)(186009)(1800799009)(451199024)(46966006)(40470700004)(36840700001)(40480700001)(36860700001)(86362001)(40460700003)(36756003)(82740400003)(7636003)(356005)(478600001)(70586007)(4326008)(6666004)(426003)(8936002)(2906002)(41300700001)(316002)(4744005)(5660300002)(70206006)(6916009)(47076005)(8676002)(16526019)(26005)(336012)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 10:39:36.0888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d020477b-6830-46d0-3028-08dbb2b364ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7270
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Sam Foxman <elasticvine@protonmail.com> writes:

> Automatic color should be enabled by default because it makes command
> output much easier to read, especially `ip addr` with many interfaces.
> Color is enabled only in interactive use, scripts are not affected.

And BTW for v2, if any, please ditch the terminating period on the
subject line.

