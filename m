Return-Path: <netdev+bounces-23551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F2776C78E
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 09:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D93A1281CF9
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 07:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6582B5396;
	Wed,  2 Aug 2023 07:53:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510705692
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 07:53:07 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273C73593
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 00:52:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvO7UMWJGlLnnUquEbogqfgGY8qmKnXnXkji28IxEHGtNrFzDyBA9KzQVgrf6WibaQjPCinwh6y8gdetXN8TYcj6G0/FZyKCW1Qia2aiHn9yKD0/oOv09WA5L35vguHKSakj5Qsi83Ybt92SLlxtcLOVE6RppHit29Fyua2rXWPfMp/Cg+o8d/1i2zgRRhuvFTWceVKiizc/N+X1xtCfcw8EP4qM21hwSqjWrIO0k5U4JZag2NaqQVE4qa/QpISDKPRlCf1HlLBOA9d8RjdUa+9ZhgreohyDZ8DoMhZCbLz9JSWiJQ37mtgHnmb7hqSdoTr+ryaBjevKJhqcnm0YPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2T14pdwEM56X5jmGyMKQ9/XX8CofFLtbZuZEKCIilrs=;
 b=ORW8VJDf4hUMavgAsVq0u7oD1fesgAmJCybj3/uOwxEyrSFswRtYp8UpzukdSDMqZIvw7zwlR2gZOIKoJX3/fwCpssVrg3NnFKl3gtg6jwqrkWgnZWW2feQZj1jSOC+2IUuPtPV2PhkpukxR6aTehNGb8jztsa1C40HIDnhGBbNmVUi6YlB1T9YulBo9hewmGql/YvlZMoYmBF2Ej1ZtRHQJkETxlh5EyXi1UWUXRjTG738DomHCfBD/AUbO730D1gHb3Lw5+sGn3rmkrnSMzJL+3gTz5YNQ7j/NvBueKoWMurbfoVpyl6K9sF4IfvMWdSXraVYRest9MwTMuhahYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2T14pdwEM56X5jmGyMKQ9/XX8CofFLtbZuZEKCIilrs=;
 b=jJljX2GrPouWvQQ2SIShN7vJzo4WOJh3NpD7joTStITXOgJWAL7cSJTnw/zQys1dhhwyhiHj5rfYQmHvpCV7xP+VijEbo+bX8L68wOkIt+fpTDZhPBMfEQrQNtBfxeUSjNpNe0l10w3ZyM1L900qANWy4skKqdTBxjn6M1ZdG+d/Ld7zH3cOS8pmyXs7s8LhuvwUFZP9RPYGiOpsWSc5oMLjMHavmpB7wSUvZkAbbCD5feIeOCkmdvcN4AKTnzFXh3DixQZkKQewPZ/OMav2qzJ3fYmcIwAJCCXJ6S5zqPS2SqJy+S7mABchQp3YtTY372TNveej4SCd44J8j+g2GQ==
Received: from MW4P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::8) by
 SN7PR12MB6792.namprd12.prod.outlook.com (2603:10b6:806:267::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 07:52:52 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:303:8b:cafe::69) by MW4P221CA0003.outlook.office365.com
 (2603:10b6:303:8b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Wed, 2 Aug 2023 07:52:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 07:52:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 00:52:41 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 2 Aug 2023 00:52:38 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <razor@blackwall.org>,
	<mirsad.todorovac@alu.unizg.hr>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 08/17] selftests: forwarding: ethtool_extended_state: Skip when using veth pairs
Date: Wed, 2 Aug 2023 10:51:09 +0300
Message-ID: <20230802075118.409395-9-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230802075118.409395-1-idosch@nvidia.com>
References: <20230802075118.409395-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|SN7PR12MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a473b60-4f9a-427d-ef4c-08db932d79b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vagZYYhDBcYK4lgKr7mRI2LR8W49RWl1FVz64Gt72iZijZkJ/e4t7KCk6r6mlYtaQmvxXchMILPXsxSkSuaslGcWMAEvjhplFcL7Es6yaWxi1rZ2MTp3S0/XXLGC5oT5A44yqmnSL8s+w0hE3LAw+QBaL1StiFwTtW1jmWVtBPvnIRt9Y6E9/vK4au+81ULuNLFNOPDIk36zzm26m2b9hOsXJiIxuGUw1D7g2rJwyAfvS+2pHVUn7cQOvc6G7u3buhLMJ2jL6yM0KWTZJT1vmipM3BadPfDho3LPey2MLXU5b4uDpNb03PCzkdtvjwpL2HiwwJGyhU4TGOKcRQQXSMGiAy5O0VIwvziHLGdME9/1zd36ASHe1o5AftMspEUy3areH6CTJiW9+XF1FVo/twmXEU9wvEy6EUcQfVSYf80QSmjFdKuEW384QoE/MuDcOyXyUTOIBiIBq+ZBX1JqH74So3QQA1lOA9JCv5LJLj2Pfu83soP90vuWPcygOwISlWxScj2wNPg8ZJnvsmMaI32XsuRavM7TKq4QvySOduOl7Rqwy5JV5zqCUsfw4bH/eu+WTKrqMiaZyqc+TuwSYVr/h+8suRnLFFdUmTYymRxSJMzjWQcgg69dAp0LRMijosn8+PEGBl64d1nh5ZyqNoKEeUfI0PO31Gfbjbuoa5Yhk5HgkOhDLKnT9WO2CSXxclwiLhk2uXrgHU3lj5TfKmNDltoRoct3eIa54s3srkYP/pTfCr2/UJeVvm+5LKeJgNAsRSy1Ltb4r2/ndxlNo3wZblfuW5BM8hx9WobTDsU=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(396003)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(7636003)(26005)(1076003)(356005)(82740400003)(336012)(186003)(107886003)(16526019)(2616005)(426003)(36860700001)(47076005)(83380400001)(2906002)(36756003)(5660300002)(8676002)(8936002)(40460700003)(54906003)(478600001)(86362001)(6666004)(966005)(40480700001)(41300700001)(316002)(70586007)(4326008)(6916009)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 07:52:52.6897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a473b60-4f9a-427d-ef4c-08db932d79b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6792
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Ethtool extended state cannot be tested with veth pairs, resulting in
failures:

 # ./ethtool_extended_state.sh
 TEST: Autoneg, No partner detected                                  [FAIL]
         Expected "Autoneg", got "Link detected: no"
 [...]

Fix by skipping the test when used with veth pairs.

Fixes: 7d10bcce98cd ("selftests: forwarding: Add tests for ethtool extended state")
Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Closes: https://lore.kernel.org/netdev/adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
---
 .../testing/selftests/net/forwarding/ethtool_extended_state.sh  | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/ethtool_extended_state.sh b/tools/testing/selftests/net/forwarding/ethtool_extended_state.sh
index 072faa77f53b..17f89c3b7c02 100755
--- a/tools/testing/selftests/net/forwarding/ethtool_extended_state.sh
+++ b/tools/testing/selftests/net/forwarding/ethtool_extended_state.sh
@@ -108,6 +108,8 @@ no_cable()
 	ip link set dev $swp3 down
 }
 
+skip_on_veth
+
 setup_prepare
 
 tests_run
-- 
2.40.1


