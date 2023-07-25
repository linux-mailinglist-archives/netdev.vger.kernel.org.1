Return-Path: <netdev+bounces-20830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5A07617F4
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 14:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 534E81C20E16
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 12:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A465E1F16E;
	Tue, 25 Jul 2023 12:05:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989B71F165
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 12:05:36 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855D8A3
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 05:05:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POZ8Vcahk9fTgeCm1HrksqWGx1Qa3FH5ikB70cK285FmxTaASt0k1BX0BE30/D7pJLLIxRSJcm866BZZZVH4XS25nH9fZ1Tf8UKJmpCSlY20Q2RzkDH1OKYVfTlplJAJAUQK/99sw4Ou7pxiaDTsJy2w10py6e2PYz2kefJZMNN5oJsdam9GmWVKHPH5MFa/GSeAkFkHNhKnn5+bdej9tpw7JVIJxwcv+H8t1sqGXqlJylQ/6JMrtNcoNEcqUGTPYNAMvoaGkq8EL7XXvbt9TexWo8iHBUFOBuY/nqIqnWkezXLH0b1zcUgN85j8GmeWEeTgp3yryXPoCtOXZfaYyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjFoT876Oj8EPjGMMb2vrC9vn5WXFsfmlY1eU/ApKbs=;
 b=bekqXaVgMN0vt3MZxMm44zkcdRsnvjSJjE+Pgwby52FuV8+pBupYi6Wn3ypipFGml0uLtLQDxKt0PL+D/GpMu0uZgZLL1Dg/dQDNMWKZYDdATW1n6wUxuNZTlIUJ258ope3/0mpTPeWfCFEaaMmIzy7GqDTMCWBLaoDt7E7XFY8QDCw6MPj9ES2jGZsfm8jG7VuVPBrS020sFTDHaLSUPGN6PBM3VlvTmmqqnQy8Pzs32cjoZvjH0pXcEZTdq8mXAuaFAO+W4103n0RB4U9P8UG81F1wUxDRRlsA6jiWoAVL4zLm3au7Noc9L4OjNTVeEiWCQpuhdKPLw+bjqWaHEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjFoT876Oj8EPjGMMb2vrC9vn5WXFsfmlY1eU/ApKbs=;
 b=KWM6fqkqnjBEaCMJrN+1qZpCo2CzTWRsZzjuFjBeHhFe1gHUDiRrOb6SzbX9lY7JrFJ4xvXDihSAeO4nUP5Zi7c5uFJaflxAHshsDth8QDVNT5l1AnDKVZl9J7P1fTfup/lbGpeWl2kLeUGW7w2A4IzJ5taf3MUGqeLGkICVVkx2CSMOEcCvxmhFtiwKPPU96g+WHwqikieQPAD3UixVdpBxxC+7BBmvxmHB3NTCCoewOYjVqTker11gnASjTtJCxeI19z18fN9e//VhN3ZXuFiW9/u2pV4Ner5FcTGV8pfDimbUmZ54kXjl0pQ1vmjTw5y+c9tY1aGOmSYhVHYmBQ==
Received: from MW4PR02CA0027.namprd02.prod.outlook.com (2603:10b6:303:16d::32)
 by SA3PR12MB7857.namprd12.prod.outlook.com (2603:10b6:806:31e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Tue, 25 Jul
 2023 12:05:32 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::90) by MW4PR02CA0027.outlook.office365.com
 (2603:10b6:303:16d::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Tue, 25 Jul 2023 12:05:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.25 via Frontend Transport; Tue, 25 Jul 2023 12:05:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 25 Jul 2023
 05:05:16 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 25 Jul 2023 05:05:13 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 1/5] mlxsw: reg: Move 'mpsc' definition in 'mlxsw_reg_infos'
Date: Tue, 25 Jul 2023 14:04:01 +0200
Message-ID: <c5e270cd5769f301fe81235622215143506e1b48.1690281940.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690281940.git.petrm@nvidia.com>
References: <cover.1690281940.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT061:EE_|SA3PR12MB7857:EE_
X-MS-Office365-Filtering-Correlation-Id: 269c01a4-c4d3-40ac-701b-08db8d0771d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	56NGajDJC75ocK3yVYIdie62k6+8bhHCPeAvah6hmOGq8EcUynvpIMpBi7UCaBwv2o2WzvzyDyBdtdTf4ydQIpRmY3qesV5Cl/miWaLdVfz3CjWBR6pxCft6IK3tVDh7b+czqh2GNnXrRhGI1+nCGDupK/xrppzhzdnJHbJYUKbyFHyuF1q/rU8CCqzgOeSSu6Ja2LSJoXqpT9eTVgKRAms5SM2ncUc6N2UAPp553hiPzGAvvyYxHkdt0QRMYUztxFUiSuHzorbXCmMD+as2dvaScA46EntG1277dUn1q/PvSrBW1Jjf8SALnzsCKt4O770wh0kHrOHDRYlMogINI8OjNjuosehwMm+h/hlmREzKvJMJ+cl0J4KzRG8jh4zrh41QxnnMcLHNYHY4KI/jdeGyDhFIULCztuWnrWnYB+3EyH1HNyhE6kwdeJ9Bkb0gOV5FMAXQj9t61Fe098L9KeuzHhf14PcebB4ndjVeS32UkZIR9562jYljzRyWYJLbSkvFXdHc4/MJh4mM7ziVbb4xytD8+m0p+5awrAXcMOmjZSbtnj3jwFceNu6LAVBwFPG/9MICtIE5/a+cr90oss0Ni+880qSNV7yuTs3safLlooJor/bQlV3gk/U42ZM5G+5GBKrxVy6UUc5Ymh5TN91IBejQhPOVeD0WPQu6T3jQFUn8pUvL5wQsiLmUnj4p0kP2jAlaN/RmS558QXeDTl43nPmaNtHX804AepfZAlOM26vkr5YEZtH5afq0aC5/
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(40460700003)(40480700001)(356005)(7636003)(4326008)(36860700001)(47076005)(426003)(2616005)(107886003)(36756003)(83380400001)(5660300002)(8676002)(8936002)(16526019)(54906003)(110136005)(478600001)(70206006)(70586007)(41300700001)(336012)(186003)(26005)(316002)(7696005)(6666004)(2906002)(86362001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 12:05:31.6507
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 269c01a4-c4d3-40ac-701b-08db8d0771d7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7857
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Amit Cohen <amcohen@nvidia.com>

The array 'mlxsw_reg_infos' is ordered by registers' IDs. The ID of MPSC
register is 0x9080, so it should be after MCDA (register ID 0x9063) and
not after MTUTC (register ID 0x9055). Note that the register's fields are
defined in the correct place in the file, only the definition in
'mlxsw_reg_infos' is wrong. This issue was found while adding new
register which supposed to be before mpsc.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/reg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/reg.h b/drivers/net/ethernet/mellanox/mlxsw/reg.h
index 0802ef964d78..4d1787c1008d 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/reg.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/reg.h
@@ -12965,10 +12965,10 @@ static const struct mlxsw_reg_info *mlxsw_reg_infos[] = {
 	MLXSW_REG(mcion),
 	MLXSW_REG(mtpps),
 	MLXSW_REG(mtutc),
-	MLXSW_REG(mpsc),
 	MLXSW_REG(mcqi),
 	MLXSW_REG(mcc),
 	MLXSW_REG(mcda),
+	MLXSW_REG(mpsc),
 	MLXSW_REG(mgpc),
 	MLXSW_REG(mprs),
 	MLXSW_REG(mogcr),
-- 
2.41.0


