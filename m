Return-Path: <netdev+bounces-62824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D155C82983E
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 12:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3E0C1C21CD2
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 11:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50D341746;
	Wed, 10 Jan 2024 11:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SjnyBaF7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229BD41205
	for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 11:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeyDHA3FfJxCB3sjFSg3E/y0sEgfGkFgmqEYbcJBeHW6/EbUTp50MfgVTxTnVb0R1dsa+J3QeXpmw6PpqcHLMZsT+PopBq5vbEgrmLoUNIn1F8tGeEfzpqIZ8JAw9c3KpcXmuhLde06+Va61WdSuNZDgQ03zYZMBd4aZZnvZWTovNM8rm+kRFz5afxtnBTcQUZiwWJj22fxTs+kwLNgI2cnDh4KCKB6SZ1SIsKLPz0XhHBndBORv7TzgZs1tS5ulB2+O2aZ5jtmqe8FF46ENPJz08MrFLUEsZVmIs7Tr1/ruXpA5k8YZ88JB5W1WKE7DUnhsvnM2jYyvf10y5JFA5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHa+Hbxp97hkFLpbPomfXZwdYVDBZcF3myEbi/Bp/n0=;
 b=SiuUBulpKMD1FTzZQ4VOgoQxJGMM9LVhSfzP81J+42hxaIaWcSBr0b8t7wHyXTopz+x5Ihi8ih5JiO5SRIrnhcQ4u++M+VQjJV2uFocTDV/aBn6veREvs4AjWZI7RvbkCFwgw9NP2RsbwLu8x8G+48oQbtY18oiAwgeoHY745Lhtdu3d0Vzct6q5FPvDBAZzNQYM41CgWv3TrQboVRgKrvFDbEztF5tJW4hqb6saUp+sutLSD1RHlI/DZBdFcbU2elSJ1cn/SKdR86RJDvW2VgVP9Pl7ARy6dMuLX+1xrFSixNzEq/m+fylp54wlOyVtzUmOTMaO3ah2bZd9BOa3/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHa+Hbxp97hkFLpbPomfXZwdYVDBZcF3myEbi/Bp/n0=;
 b=SjnyBaF7a+dKkRz0/rLEoGd9mK8WzkNCs2BuDLaLJKbaAnyDc8n0D0sPUnEOsQLaJmkIca4gj//TSw0AholhCispJoG6CP8GdzBX5qD6jWJxRTq3xD9bnu+JU6JjkpMkgKcC6AgetraY/qzR8AN3XMnuJErwhEquIP4NvTvhLF9B23OT2NV0lhXfj4EsofzYrhzhqotR6EKyxJIWYaIGR1axR9GlbLo2Ac6LHNadk3ARzag3bOKu6hQmjL8ll352kYuCODTIiuLfzbPQn+bOB7RCUAMR5aGPDjYB8veSSdyHpyW7tQ7wAm6adhy44hZXA4O2z5NnxazBvCAhf+cvJw==
Received: from MW4P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::14)
 by CH3PR12MB7569.namprd12.prod.outlook.com (2603:10b6:610:146::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.25; Wed, 10 Jan
 2024 11:02:49 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:303:114:cafe::65) by MW4P222CA0009.outlook.office365.com
 (2603:10b6:303:114::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18 via Frontend
 Transport; Wed, 10 Jan 2024 11:02:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 11:02:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 10 Jan
 2024 03:02:33 -0800
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 10 Jan
 2024 03:02:31 -0800
References: <cover.1704813773.git.aclaudi@redhat.com>
 <52d94cd79743fcbfdc0767669f012a1ef2e926d8.1704813773.git.aclaudi@redhat.com>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Andrea Claudi <aclaudi@redhat.com>
CC: <netdev@vger.kernel.org>, Jamal Hadi Salim <hadi@cyberus.ca>, "Stephen
 Hemminger" <stephen@networkplumber.org>, David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH iproute2 1/2] iplink_xstats: spelling fix in error message
Date: Wed, 10 Jan 2024 12:02:14 +0100
In-Reply-To: <52d94cd79743fcbfdc0767669f012a1ef2e926d8.1704813773.git.aclaudi@redhat.com>
Message-ID: <87le8xo3i2.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|CH3PR12MB7569:EE_
X-MS-Office365-Filtering-Correlation-Id: e5f17e6a-8d66-4929-76c3-08dc11cbaf4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pwXp95VaFonbEVXl1HpSPA2+PWpgHms9kleEFebTcDPiLwy7w5pSKPqVBnau2T/n/abln3+TNhhJSVPTthQLjRLUVlgkKqKMt5vZ+n6U8iT1rwAQlM8hRXToDhs6l1T+/Cpdj5vWuz/FqJmJmFNIqZzfkFzkNsh6htiyguAx9ZTPXtL1W89i2UfoLc0vCMMRCIluPTTbqUzj+H+1qk102clbTAUClENHtsJ3tnLCBCRuqah2cCNXvYrJpmTWMQCBRlYVWluQ6EuP8nTmza84u2fsZElQvyOHQmI2NZy73ZOkjg6bTSdEBCZIKQl3Dd6S0PH4c6iLPJg/xWKAMUTUykQGAK8u4GBdrazYPiVGQjIdc8UUaGKY3D5YCVLZ99YnIKrMRF5SbNCvnq1Ejj9AAx64mBNO/INzRQJaRl4Q2nr8Xqiop8SIaHzdtHnB9JOwyV0DY03QbjWx1q0Moc/IdN2TmArWv90CX26KRqYKj6Ufjo/5WMVSsj8NPm76gDiA28CfPh0yGyVl6hzOD4h1j02mSo8BMwEP98Uc8jHyHczqgGXWIb+/e6DzgszPAgGkWYxFPxuKN56iK+BFeptZSUxxOuG6IKM2fl4oixd/xpMZfKB/ZcfoN3MOegAHz/gTGaIpHy/HT7hWWQ1e8gDTwGbcD8jLlGHLS7XM+9OSwRHvh6KTOOe7C+9kNiLvQ9DviIO8zwfaEem8HvFBNeEqIzrjkbVPBkJq+sED9hsu7BYyCu6XfQOZcvEHD3DuGvWE
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(82310400011)(64100799003)(186009)(1800799012)(451199024)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(2906002)(36860700001)(558084003)(5660300002)(6666004)(478600001)(7636003)(4326008)(356005)(316002)(70586007)(70206006)(54906003)(36756003)(6916009)(41300700001)(8676002)(2616005)(86362001)(426003)(26005)(336012)(8936002)(16526019)(82740400003)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 11:02:49.6084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f17e6a-8d66-4929-76c3-08dc11cbaf4f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7569


Andrea Claudi <aclaudi@redhat.com> writes:

> Cannont --> Cannot
>
> Fixes: 2b99748a60bf ("add missing iplink_xstats.c")
> Signed-off-by: Andrea Claudi <aclaudi@redhat.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

