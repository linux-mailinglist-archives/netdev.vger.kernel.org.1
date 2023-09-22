Return-Path: <netdev+bounces-35868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F39D7AB71A
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 19:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 421072820C3
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 17:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5AA42BF5;
	Fri, 22 Sep 2023 17:19:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B90E42C0C
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 17:19:14 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B701A3
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 10:19:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqyYQgH2ZpXM1s3cC9Z3iGWoNjkkSulajhfFwhOnXeh8Lmu1osrcVA0oBQKtOOUF6DA1GwVT08JLEkyABAmQHa38CcTOl7AiiZvoP1Dmw35YlWrVkrTSmHBJ+BlFMW5He3IHFm1NzGMU5NdPv6X8tR6Bq19TLEk6wx4pKC/ZchLPvDkOGpWtgSG/dd6mUOp3deC3q9xaBhpORyfpXL1tEQRGS9XfX1fwsE54nmEdL8iGICzl6Ccz2XA3vvn221RmLE9Qr33xqOInzqvD2vyKmN/L3Cmz+NP6IeAlXoTE39E2P+f3OxQ8cb/Imwi4vBUdM1+poYj0jL7GPCbvKGyjgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ApAZF0oWGUDrjjYsFdYswixdc9mEzWwniHNtvu629g=;
 b=AtmUblu/voH3UP4CMNCpGnrqIN03uTuPoU9AQ8eMiNbArooQc3Kd6EZqQEq/ggsbqqnfotBlPsmI4iT8U8dl9lMr6AZx9ikPSY5C/D8hFFG8+hInLxrn0PT5wyb+7pKWnw9icD77++bT11hD9IremD2yPzRPD5WZSBB6sVY8ZAtk87R0HwCAA4rAOMfrt42o4OOawjCne2ra2qqLUhKlQIuLmQHXAKXeIbJAM0yDOzea6OXCjL6uwVnumqCUNd6CDlMw/uyk16hDziSq04aSo4AIsH3/jxcN0jkb1gD+MD+tPFltZq5WX7jLJ0iW0GIW2BgjUdxvCAadv1lzsv3jMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ApAZF0oWGUDrjjYsFdYswixdc9mEzWwniHNtvu629g=;
 b=GS4NPARqDUaHbpFCuoB12EnEYdPb04pSSvNzpti1Qk5Uem1ZWzf112634EqcHyhA+g3uYeDQpYpguVtLLoNQF0+vd0RHmT6LAdDMGHxCv5RfZhL2YLCrjhv5HG6tkAeSjndV4BgQnboxle8JvbSwudOnASwG5XiooUln/93E9TPSRlXxIS2/znSQ5ilI9cL5dtL+MxwZSi7AMm/d9cjxhfzh/3IYtg8/Ry28Rg4Cn4/+gLYWLmFMD5mJtxTkEpW+oTOA2hM0P90Dp/qOVxJ97Tna1iOe+YkmsG4DeXT+63RtLxcv1wpL15nlAs76XgIEQViESduKHiNNt+5y//jbnA==
Received: from SJ0PR03CA0115.namprd03.prod.outlook.com (2603:10b6:a03:333::30)
 by DS0PR12MB7511.namprd12.prod.outlook.com (2603:10b6:8:139::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 17:19:11 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a03:333:cafe::a9) by SJ0PR03CA0115.outlook.office365.com
 (2603:10b6:a03:333::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30 via Frontend
 Transport; Fri, 22 Sep 2023 17:19:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Fri, 22 Sep 2023 17:19:10 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 22 Sep
 2023 10:18:57 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.231.35) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 22 Sep 2023 10:18:55 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Vadim
 Pasternak" <vadimp@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 2/3] mlxsw: core: Extend allowed list of external cooling devices for thermal zone binding
Date: Fri, 22 Sep 2023 19:18:37 +0200
Message-ID: <8fd3ef09c37675d6bdf487a1ce95ab9efbe5b22d.1695396848.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695396848.git.petrm@nvidia.com>
References: <cover.1695396848.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|DS0PR12MB7511:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f57cd90-60f4-4cca-8ca7-08dbbb900955
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sDshQXMqm4PaIlvjyxHisKjvDaa1IZAKOxVb68+Za0f9obJj7jMLNjaxQ8foNPQCFoqLhRRPv2YDck3C5FrRaJMBiTMSCPcVQq78ZfeyxSEPNMgkZafNmai33kM+4RW8pCcl2bZ5HsIfK69iuF72xkqKTbng/95T39kSj0QMEVexrE4zPvZRmsqXHhfu5gRNAoPV3y7X0HZLYUO6eFTb4cX8cCDv14F+ARtTfc7aYi2UDjmZ89LWhDRfWbEftyGhLfFWtrWQRJfAkZFiD2XHxaCFyLsWG36i1N+WAf7I739GrFgetzYcTjSjY3+SV/uZKIruT83LSqabRpIomoz4qI1AvTUGPWqyxJXZ6/Z431WO1b8PTn7V6QQ+UURFZ9jOhg5pKI7Ytv7oA/D4SnJxAK1cdo/kLLfb5e8sp9VgTNsXH68nxml7WK2OkEGJZvdIxeixMsg9Uoin69OfyKdvYQeub2si8v5BT5ZaaiCDOcy7WVBtm41nUWxAEvKrZVzVwFgBqtxCJOTtsgrkscDLz1JgdWy/PUy0ApuMu7DBeo7j7WCBYX2cUx8+vUa3kMZoePuLCR1LNJzkmWXvsL4PsmQ+d3rSnFXBq0TOQ2uyVgvfeohB9Yli3I0DhhZKLJN/+9btjeOej2c20yQQAcpqWusqwvo5ld6Tj2iY0NZ3McfWBH4FfuTU4lQwepp2qx4iIAhwNFZEatRlGAxltdFx+g79q9Te+i2Fv6QO+2Bpi6kofSeJYRvfCWqhRVYuaE27iwYk1c/P3kYb5UJVxNl3wg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199024)(230921699003)(82310400011)(1800799009)(186009)(46966006)(40470700004)(36840700001)(8936002)(8676002)(4326008)(110136005)(5660300002)(41300700001)(40460700003)(316002)(36860700001)(26005)(16526019)(336012)(7696005)(40480700001)(54906003)(70206006)(70586007)(82740400003)(356005)(7636003)(6666004)(2616005)(107886003)(86362001)(426003)(47076005)(36756003)(478600001)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 17:19:10.7624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f57cd90-60f4-4cca-8ca7-08dbbb900955
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7511
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Vadim Pasternak <vadimp@nvidia.com>

Extend the list of allowed external cooling devices for thermal zone
binding to include devices of type "emc2305".

The motivation is to provide support for the system SN2201, which is
equipped with the Spectrum-1 ASIC.
The system's airflow control is managed by the EMC2305 RPM-based PWM
Fan Speed Controller as the cooling device.

Signed-off-by: Vadim Pasternak <vadimp@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
index 70d7fff24fa2..f709e44c76a8 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
@@ -31,6 +31,7 @@
 /* External cooling devices, allowed for binding to mlxsw thermal zones. */
 static char * const mlxsw_thermal_external_allowed_cdev[] = {
 	"mlxreg_fan",
+	"emc2305",
 };
 
 struct mlxsw_cooling_states {
-- 
2.41.0


