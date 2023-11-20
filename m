Return-Path: <netdev+bounces-49340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E29B7F1C5C
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 19:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 713261C21457
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 18:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A817D31A9E;
	Mon, 20 Nov 2023 18:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OsFXSJgf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65A7C4
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 10:28:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhtHQKC4uYEJILGsdqHtVgkqfntI0Vy8tXutaHwWxkbspBr3Yioo6YhGhv+Xo58rjw9fQ2widehsGBMT4V0za3Nhw2+SueJwQQQhLl8ANDC8pb+aOlAzeWDyOfDfv47ATKjLYhRSiX4iJpxo+kD9oHyw1f3WegrJeuUVASvXUN5q4P2p1JvN6H7JkSzQnOgzgf8C1IGYe24cvFheB3IuhOZb+n45+zaUgeAPMu60kuXU+SJC7lHlgUxB6yqcMIsUT7DCdWS3t2gzUdiO0xntppT3OTu0xkk+8iZTeVOK6HPkudvC2nWiqIPtQVa0xuanKAqJerOEw7ddcJo2arp51A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GiBPsVO/CpMy6EeTmX7yYWxGfrKQ8KvinwxO3tQ1a2k=;
 b=GMfa4lh/v8MklpyNlsVINbKVlceZfThbat8iTcGk2d0u08BICLDfGTne059C74wkLwAAO5sSyHo2K8ZyV9JZjnfdnxUNrtskgkgZsJChBR0H+4ENC6qrE4P/Nz8ZdPgp2jEES0L6Ovg1x05nplnD0LFwxYX4859qJFKq4NaK9CQif37MDh0rrXty+clGFiImPV1mFp6/ndMweAII8HCFqZS3ZpvJLn2nAXEq5kq2UL2JYA2tzNdj8IhBP5SWuqzAWnwY0XzwK/fg5e+3AeDnDisjYOWer9W+R1H3jRs6mnRL4EUZ1fQuWLxuh+vtxDhQPkQ5bPgWNSwttlwao0Z6uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiBPsVO/CpMy6EeTmX7yYWxGfrKQ8KvinwxO3tQ1a2k=;
 b=OsFXSJgf86hFWKy8xryr7h9e6qYFDfutmhCn1Of1b1j4LqbgCyUKvoSsrWnYBrydjiGXMqN3CpuNbZw+0P4vC1V/KJTHYNCWKK5KpuNJrNESVwA+mplrz6w5/rjXTyW7iVhgiyid62NGPsLo/nk8P5RJqImu3xi1BcCIK2KALvFoxew1G+IgWjBia5nnNO3rF8Uc1xqfaw04BXaCPuJWjrjTP6ypSkfVOOxgUUuPb91sPHe40rNhn9WF2gm0J0fZUyqTBj++3OV2qEFRQpE8cOooa/1ZhR+odadYmbWjl5nWEPPsPF0c63YCpwfeObzIO8/kNwx9G7tUuHj5BIPW7g==
Received: from CH0PR04CA0032.namprd04.prod.outlook.com (2603:10b6:610:77::7)
 by SA3PR12MB8437.namprd12.prod.outlook.com (2603:10b6:806:2f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 18:27:59 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:610:77:cafe::fe) by CH0PR04CA0032.outlook.office365.com
 (2603:10b6:610:77::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26 via Frontend
 Transport; Mon, 20 Nov 2023 18:27:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.13 via Frontend Transport; Mon, 20 Nov 2023 18:27:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Nov
 2023 10:27:43 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Nov
 2023 10:27:40 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 05/14] mlxsw: reg: Mark SFGC & some SFMR fields as reserved in CFF mode
Date: Mon, 20 Nov 2023 19:25:22 +0100
Message-ID: <e1d5977a8cb778227e4ea2fd1515529957ce5de7.1700503643.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1700503643.git.petrm@nvidia.com>
References: <cover.1700503643.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|SA3PR12MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: 6246c0dd-e5a6-4828-daf3-08dbe9f66bcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e5br08e0AfC43EOFolF1gBeSpGq0LUKwEtFP+EsByynF6VCAJ/JtHu0XU1uPrbElVmgHq3fT/m+NXHllQP2TJlxPj4WU7KZNSM0vjknYgg8/q94i45ygLtJIvE0t9wM971IokkK1+c8Bhkgo2y4jxJEgqqOOAq9whDMWIXodiNvVqMksOtL/lWLk+W4ai/QMXGpLxrDAUbZod551a0as0634CqYirhImU1kP/2le7ShA2pfyOGeIhRohnUTuotwfG1kCxFwLT7HYvQgQrJFDgLAtWQjRaCT1jxEXvOryJpFjNdb7fNcB+11AOijNkd67CJkRKH2SYB/pLqT/+UvsnOsKTalmdnst5ph4DGGzKuWrNY/Wm2SDKkITlVRRk8zYLa3X+93dREDKrj50uGRRZEjXBxjNSlY9lE2l0pMjfCeI/qHgk26r+rFMozalsqdlc9GBhwDK0t5qtYlw3iDX4SMZEAU4ke+5aNHuAuAuC0wzJsjg0RaEJtYHxBe4NLxDstOyyj2pn15h8ZjIQUJFEI2JNI/JQDb81jtAKcROFTfXjmLRaRmNbSyeEj6UgxnyQwoHPbN+OvWTS0K1ZDuOC8Dw25XYBVv0iJpY4F+G61d2JrqG766+UixzU11E/Rs9wfM5tdGMVnF4zXT8TiPTTdSUgLt9MF0aDCm/h2gb6ZgKeEBWqDbFMrbvzT6p3RolibYmx3E7WtOxc88ZhN+ib9Kx1jK/vQSja7JOmFmnJLQ=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(451199024)(82310400011)(186009)(64100799003)(1800799012)(40470700004)(46966006)(36840700001)(356005)(7636003)(86362001)(82740400003)(36756003)(40460700003)(110136005)(316002)(70586007)(54906003)(70206006)(26005)(16526019)(2616005)(107886003)(36860700001)(426003)(478600001)(336012)(6666004)(5660300002)(2906002)(4326008)(41300700001)(8676002)(8936002)(47076005)(40480700001)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 18:27:58.1306
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6246c0dd-e5a6-4828-daf3-08dbe9f66bcc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8437

Some existing fields and the whole register of SFGC are reserved in CFF
mode. Backport the reservation note to these fields.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/reg.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/reg.h b/drivers/net/ethernet/mellanox/mlxsw/reg.h
index 3472f70b2482..ec0adddd4598 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/reg.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/reg.h
@@ -1024,6 +1024,8 @@ static inline void mlxsw_reg_spaft_pack(char *payload, u16 local_port,
  * ------------------------------------------
  * The following register controls the association of flooding tables and MIDs
  * to packet types used for flooding.
+ *
+ * Reserved when CONFIG_PROFILE.flood_mode = CFF.
  */
 #define MLXSW_REG_SFGC_ID 0x2011
 #define MLXSW_REG_SFGC_LEN 0x14
@@ -1862,6 +1864,7 @@ MLXSW_ITEM32(reg, sfmr, fid, 0x00, 0, 16);
  * Access: RW
  *
  * Note: Reserved when legacy bridge model is used.
+ * Reserved when CONFIG_PROFILE.flood_mode = CFF.
  */
 MLXSW_ITEM32(reg, sfmr, flood_rsp, 0x08, 31, 1);
 
@@ -1872,6 +1875,7 @@ MLXSW_ITEM32(reg, sfmr, flood_rsp, 0x08, 31, 1);
  * Access: RW
  *
  * Note: Reserved when legacy bridge model is used and when flood_rsp=1.
+ * Reserved when CONFIG_PROFILE.flood_mode = CFF
  */
 MLXSW_ITEM32(reg, sfmr, flood_bridge_type, 0x08, 28, 1);
 
@@ -1880,6 +1884,8 @@ MLXSW_ITEM32(reg, sfmr, flood_bridge_type, 0x08, 28, 1);
  * Used to point into the flooding table selected by SFGC register if
  * the table is of type FID-Offset. Otherwise, this field is reserved.
  * Access: RW
+ *
+ * Note: Reserved when CONFIG_PROFILE.flood_mode = CFF
  */
 MLXSW_ITEM32(reg, sfmr, fid_offset, 0x08, 0, 16);
 
-- 
2.41.0


