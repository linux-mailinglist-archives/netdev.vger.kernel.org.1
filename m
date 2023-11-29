Return-Path: <netdev+bounces-52163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD8C7FDAC3
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 16:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58BE21C2040B
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 15:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B8637158;
	Wed, 29 Nov 2023 15:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mfT2Ohpo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64B5BE
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 07:07:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5EcjFHMxmi30vH0co1C0p7jkiKskK1q6yNIEzInGl6Z0Bz5C8rVx090rLEsnIvwhfwmzeyTAUNG8CIQEppXGZBvZSCZM1ABkOy28/bHbH6ofrHYIAN0EKB2cGcQI7Q1nfPCs7t+qFdcDbMMfw5Xw/e8/dZjqhD6tPPYRAZMC4mlnrbRc7+8PIDSn4qf0OONMAI/sxyyslMmMLzQEioBtfGOyf4ujZLAWp+SUVUzWQPZ3hddvdPmRZKH9k29E0f3udcv40fuaiaVwj/fLL3TK87Ekm0O65K5vDydZduIb6zNPyd01J7jcjLnhVECukQ+R85+3MAIK7A+TiA7ltYCBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Ml4Cw4fbebVZ3SrMWLXwZiuWNxdVuzotxFCDH8EO3k=;
 b=NZFzfsN70+z5AtqZY1Jkm9fwB2RzChXZLbvWvxymi8XdGxqm4Vdw0j5nePbm3l7k/WNbXY8uNq4ogNG0k1b65yNRe6J7bAJYWJP+g8iANg607Fz0ngEMxc4BHhUL5VxXwOUAiG1jvPhcvY8cTp5oIUnkq8/NVben+6Fd658SULFkjbPF3wkCFIs1GrRvQMZdVQWkHmv5F7yOooqfv7ePHmRpGXvavuS3X2m1GG9jG4SdyrI8xZ7Uwi22Y8orPyTm7hd62rMUjwB8UJXoChlYRAzOw0CUMei6swOIbxtlCVl9eIsXNxh4hVt9sP2ydGDlWwDN/nOqKRTsIp+zU0gJ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Ml4Cw4fbebVZ3SrMWLXwZiuWNxdVuzotxFCDH8EO3k=;
 b=mfT2OhpoqMw+q1n4sqHU+02iLpICoo0OUgJEhaHcf2EWFj9Sa5e7r8drT1a9us/RtW/VSzYAJz+2QeqAwfZKVO4++ovPpmjIqtrxTQGhhncSQiEEJY4zJQ1CuvWMpQdT9Km5KmkLl7tRncmj3iZg3zYorBMmmLPG6RMYJApoMnPuSjvC+9+509q334lRquRcPQqcY8LFpKYwgzvUKOXEDuMWm1dfK6U2YdAELdKj/Eiy+EqUNRt1EOtgWuZdEArig0wwN41latq/lh6DP/KhiprvLrui1geR+3duCZZNwIwYg8Bd5s3iXu0kn7IMjV4qxurLsqI9u2J2SkBUTlOc4w==
Received: from BYAPR01CA0005.prod.exchangelabs.com (2603:10b6:a02:80::18) by
 SA3PR12MB9198.namprd12.prod.outlook.com (2603:10b6:806:39f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 15:07:10 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a02:80:cafe::71) by BYAPR01CA0005.outlook.office365.com
 (2603:10b6:a02:80::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Wed, 29 Nov 2023 15:07:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 15:07:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 29 Nov
 2023 07:06:53 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 29 Nov 2023 07:06:51 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <is@datarespons.no>, <mlxsw@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH ethtool] ethtool: Fix SFF-8472 transceiver module identification
Date: Wed, 29 Nov 2023 17:06:12 +0200
Message-ID: <20231129150612.334560-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|SA3PR12MB9198:EE_
X-MS-Office365-Filtering-Correlation-Id: e1332ff4-fa12-4363-0e31-08dbf0ecdc99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VtY7Nkqz41HtrlrQoy95Yx1OZcxyTD9PoWlaY9epuCTQkohluFczFfW0JWull5NHPPAqKsed0Ry5GrK4NeaZSExEgpceJ16nPETHEwiZd//IoFYiObKnKMcTuGKJE+UgvdNR1Io9XHiwdBWYL/2V2061f4ysR8ujJmg3jlovCyjmW2zBSoxF5jLNGhdowvSQDQKlM10oMEvy8cUfhesDJIIDcFfaTJIDhyPbCRpQetFqVrwlBUayVSVpXbY/+Dcx16H0cBKW7gPBZ9AaQoTLGW52rjpUCo2kaDD0ntf+qwVdl+4jmaOHBgcHiHbTttS/C7oKI5VQ/9IMQyOy6jjC3QLT+4cq2b/dnqSfIprGU7O+mHrA5bRTxLXPDW2hOHk9sM+9vAKQoXbNrCwKGfJvawBfaXO+IcpQ/2JkVOo+VstwF5uB+4olUSDdD69OFeHOqJkf5O58kLVwTL3qzJC3mY5xtit3Zhng2+viRqViS9ULx67mghZSJXbE1I7f2TFGFuthjbAcK2K6BQr2fLFESCURRQV4Bazydssvaz8i6G2gkx2zCKVK2m0HTMYrhERyZxT8O4b3nEAJsGX6psQ404F8OkjolkME7sbdlQhtY7R7Jb1AqlR0mAf1nKC+tCUob++1i5gKk2Mp4Z6NAQHnsGmVbaA9eiaBKW+ZHlY4Sus0ZaDH9vf0AayfiHAV/OhcDDAv/+hn4tepuSveHzWfdBvnpEeAyNKmWOWgxn8A4twDXREHqnqf/CHoKSKCOziAZ4hyiYois1/f2KPAn4g/lZbJU7KAMut6FiZjey4stHs=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(64100799003)(186009)(82310400011)(1800799012)(451199024)(40470700004)(36840700001)(46966006)(40460700003)(478600001)(2616005)(426003)(6666004)(107886003)(336012)(1076003)(45080400002)(16526019)(26005)(47076005)(36860700001)(2906002)(83380400001)(41300700001)(70206006)(8676002)(70586007)(966005)(8936002)(6916009)(54906003)(4326008)(316002)(7636003)(356005)(82740400003)(5660300002)(86362001)(36756003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 15:07:10.5460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1332ff4-fa12-4363-0e31-08dbf0ecdc99
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9198

According to table 5-1 in SFF-8472 Rev. 12.4, the Identifier Values for
"GBIC" (01h) and "Module soldered to motherboard (ex: SFF)" (02h) are
supported by the specification in addition to the current one.
Therefore, adjust ethtool to invoke the SFF-8079 parser for them, which
will in turn invoke the SFF-8472 parser if the transceiver module
supports digital diagnostic monitoring.

Without this patch, the EEPROM contents of such transceiver modules will
be hex dumped instead of being parsed and printed in a human readable
format.

Fixes: 25b64c66f58d ("ethtool: Add netlink handler for getmodule (-m)")
Reported-by: Ivar Simensen <is@datarespons.no>
Closes: https://lore.kernel.org/netdev/AM0PR03MB5938EE1722EF2C75112B86F5B9B9A@AM0PR03MB5938.eurprd03.prod.outlook.com/
Tested-by: Ivar Simensen <is@datarespons.no>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 netlink/module-eeprom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/netlink/module-eeprom.c b/netlink/module-eeprom.c
index 09ad58011d2a..fe02c5ab2b65 100644
--- a/netlink/module-eeprom.c
+++ b/netlink/module-eeprom.c
@@ -216,6 +216,8 @@ static int eeprom_parse(struct cmd_context *ctx)
 
 	switch (request.data[0]) {
 #ifdef ETHTOOL_ENABLE_PRETTY_DUMP
+	case SFF8024_ID_GBIC:
+	case SFF8024_ID_SOLDERED_MODULE:
 	case SFF8024_ID_SFP:
 		return sff8079_show_all_nl(ctx);
 	case SFF8024_ID_QSFP:
-- 
2.40.1


