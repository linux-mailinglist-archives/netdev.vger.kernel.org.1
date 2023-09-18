Return-Path: <netdev+bounces-34544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDAF7A48FD
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 13:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3292281F5B
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 11:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195181CA97;
	Mon, 18 Sep 2023 11:59:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECDD1CA8E
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 11:59:14 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAB2CD4
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 04:57:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEZhBI+i7A4ESISrSQRi6DztY5LmFwzJaJ4azkMWUBwihOM6gK3M2Mqe9RPj5NdzLvUNDosRHA/Xpcq1DfdaD+vgu0HOwMxgXo+VTBiGc36H15ZiUn7Wf6MV9z4Y407Up0X/is62glPt4npL88SZMnJF489m8cletJC51FwCH013DlrUiylKvkvh65QNKxUOIFYDOqj0z/chwmeDSRTezHZ/fObrCkftSLGlkQf6KCyfh2p1yVkc9qwZRk1rhf/0zCU51LTDfvF/3SHJFKV7+k6ZPWHf2qp37zJ/X+dChB2E8k11qPofXBS7QQyQHhNSUQXcKtLj1ImjqyLdMGt0zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbD3ENZAPsDHQ/I5Un+lBmk2b8BHdW4Xb+16OgcRlMU=;
 b=nYTRJPR4hR9GdXHNtkS9aSQpb32jhvIUCg9hPd2sb8Dq5H669NHmK0856n5B94cJlzcJtxciH80iDSdNpVcgh1d1olMpai1TOg3kV1iPf13UCmU+fqogmOeXbm3ptUmx8k2kDeMXuuiWp+ZGz7WBExPSgmMteF8T621lnynI5Vf8Zj0APBgWBCi3lwrtJSKynSFvx1DTToJmDleJUl5Rhx/0Jj18l69zqOp4FoC9QdcdOPqsSC5RCiW1xaCQw9YFioi/5KxxepJ5+GGNh8ktB1ximUQRmJNtzZeR+i0zl1SrLgFpd+lEiIPmjaAyk9uEE2wIwGOwqs2QbB1w3lBpaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbD3ENZAPsDHQ/I5Un+lBmk2b8BHdW4Xb+16OgcRlMU=;
 b=jaNXv7zkAdomkJ8j7d3ge+deu+qSwg2ZGl6nMU+CXwRALCO/aXkLNx7+9MBMs+A1SEy0Zh4de36xAI0ZruRrkIrgCxan27Lns8EAwKD4e88MuUcqFRzQijRfgLtEXwocJKnG4T/vLakVlygTcOu2a+8yHzA58Qrw6AgdLMG/nr7+3xLdOY4t9aoxX1RRkPMETgxZ537OLIhgddgC5IwcRQNb7SYbEXf6fOuH59hDSYBxh6D6tfAnOCrjAd86QRDfqlQlpmFcT+ulECWF6vPC59wEUYTnvXMCj/bdPAbV08rinqh7XS6Fw0swoS3UITlwDrCSfW08fWRRHHFTUeY3Ow==
Received: from SN6PR2101CA0012.namprd21.prod.outlook.com
 (2603:10b6:805:106::22) by SA1PR12MB8988.namprd12.prod.outlook.com
 (2603:10b6:806:38e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 11:57:47 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:805:106:cafe::b8) by SN6PR2101CA0012.outlook.office365.com
 (2603:10b6:805:106::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.15 via Frontend
 Transport; Mon, 18 Sep 2023 11:57:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.19 via Frontend Transport; Mon, 18 Sep 2023 11:57:47 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 18 Sep
 2023 04:57:36 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 18 Sep
 2023 04:57:34 -0700
References: <cover.1694621836.git.petrm@nvidia.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Petr Machata <petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>, Amit Cohen <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 0/3] mlxsw: Improve blocks selection for IPv6
 multicast forwarding
Date: Mon, 18 Sep 2023 13:10:32 +0200
In-Reply-To: <cover.1694621836.git.petrm@nvidia.com>
Message-ID: <8734zbzob7.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|SA1PR12MB8988:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b29bbde-cc0e-4e48-21c5-08dbb83e7a17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ABHw4F7TXdqA3ELDheh8LwpWNaDMCCeYvH9lvA21YJ1qDNA84MPaBpfOZDQl/Y1UD/V3yRQ6aW8OEPwkliuMsFxAOddaW6JZ2lBIuSqKiEXM7MlhTHdtjrr44PUkA8v8HvHELBKqsjBiT4jJ9pkZqFhfpkRb0ON/VvVkNhGADSpdorLRfb1VZKfFuL73FCNbMze7YxMD3V8V7aKXlVVSb0LncLFhrHPpKR2EYseQjnHaQGt10wBaUTzCqAOcjbvZ0OcYn6ljgS+MWsOXJNHIUtCDvvx1Rx7hA61wYvAhybpb7VBT8cBKfBc42jTGQQ54aNUVjqTEf8h1Y3z9wNvAIRT/vdiqHeoE24tx95LKGb75TQU3DCuD86JcvAvi6n2Oy2MWJl/KQkzlBWv5t22nSjvy4/JqCzUlbGgfvBhfT5iFh6awVdFRS2NYMcxo42D/79eiI/jTHnsfCNZbInxotLXCwDhq4vsxETFQrLj5faZt14+i2iagELkRwPEfb/9LavYr7WcbHalmwcosws1boYzEmqSvcX6mxHvTEV495LdncsS/KcKzisrzzDuxI4BkhB6GRzsxpDPmAeKPx31pq9Xc9OThBelUQl+Xpeh755jCeQ/ZhssmyL7QFvpWukPjzHLdn2LtdqSo6P89/x0p/86M3kl4SSkhzNehgPRq7RX9Cx4lbq7Xz06rulAmxbfH43ra/BYh8KAeTai4AuH+ls8tWYz41HeSMkX5YODcmF0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(82310400011)(186009)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(40460700003)(336012)(426003)(16526019)(2616005)(26005)(107886003)(47076005)(36860700001)(316002)(41300700001)(70206006)(70586007)(37006003)(54906003)(5660300002)(6862004)(8676002)(8936002)(4326008)(2906002)(6200100001)(478600001)(86362001)(558084003)(356005)(82740400003)(7636003)(36756003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 11:57:47.7470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b29bbde-cc0e-4e48-21c5-08dbb83e7a17
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8988
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This got punted as "Not Applicable" in patchwork. I wonder why. It was
physically applicable (in that git am could apply the patches) when I
sent it, and still is now. The tree is noted as net-next. Build passes.
S-o-b's and R-b's are in place. What am I missing? Should I just resend?

