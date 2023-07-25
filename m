Return-Path: <netdev+bounces-20829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 044C87617F2
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 14:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF78281368
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 12:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FA51F165;
	Tue, 25 Jul 2023 12:05:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45721ED51
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 12:05:32 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EC8A3
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 05:05:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hq0V8CAJy15mxpGchXJ0zpXPotnpFkSG2KwOr1O6Q0kwd+aOXeGV+Xy4PQ44m7K03Z2XdruyZurepiDN6tU21zcdsZMFW55giyJqSJrcUqoZJ9kUpyVDWtWpqmM40cjsJ9GHrUQcbl8BkZ7GGOXlhldDpRGq76f6pFGZhIDz2oP4+qPBwcTBz4GTvVujQNBRjXA7Pg6ilPZ9To142aYJ4ZLnFzlHZ79vB5b0G5671lL42XuaMU3IrFF2FZfkAfGGTXbpbGHP3sUlKMv92hfwMxp4EUpSVP8vgqDf1R1Q7Zi9SRqNV8PK3v+jXHLN9jq6+BjkOQ9tf58ZSnFEcihb8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9ErJ3GjmX/Jf0Pir6yBZn0Sdnbxlg0aTOQKBlDBp+0=;
 b=PinEjElPNnuEIssuldiKpkmBMgI3ibev1doSgFuanEhXmFFhxoUlkm6eaBvKG0/hI9BKMsFZF25ZjrbG6/J+t9vVeeXHmLkItXG1B3NYFCbYWQXAStKI+AdFZVig//4fBZ4KT9xyUVTQp4/LxOV5dXaKk1Fe/jrxGA5SCSRD4Ilf/o/JIh+1iEcU1JJjU5zBRwo9UM4ANmO/xWbX+Rt3cfal6qCqZkOPS3h6kYRv/i7nT8GUPxPpJASHr5ITZ3j9EHIOayWI6PiaLDiRlXbGSEwi93ZU4cenS/m2Q3iBCbM/vBmWdgngodo39rfOxeMuIaiCMJfJ3CD/zL5R6vya9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9ErJ3GjmX/Jf0Pir6yBZn0Sdnbxlg0aTOQKBlDBp+0=;
 b=ab7noGZZZEmb0q2Tdtbdz4bKTkyqNzlUs571zZUj4Iui9je6mHydxC2Dx6oKhRa0iPOYNMd6Nt+fom6JlI5GCNsUQFrYnas6eTsLVp7RI76WpABVD9CgzgFnwchHTyV93l0SZERXdebR+43lxcAsukQPk99PidLx2wkepzlig2qotFoYh+3BJLTl9danETUiYRh38XajjI1/aEgEi31htte5ppKOXGO2cKWDL0DmRqp3h1hariUrhw+/6IHg3Ojd99k9rdRVo+TDtcFXyirlAxnVpzBWmJGQWB3yvdAW9a2xDWslVJl825uyQ5/Lq75bXhpX+3np3pSzvFYok5vRcA==
Received: from SJ0PR03CA0295.namprd03.prod.outlook.com (2603:10b6:a03:39e::30)
 by CY8PR12MB8241.namprd12.prod.outlook.com (2603:10b6:930:76::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30; Tue, 25 Jul
 2023 12:05:28 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:39e:cafe::1a) by SJ0PR03CA0295.outlook.office365.com
 (2603:10b6:a03:39e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Tue, 25 Jul 2023 12:05:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.25 via Frontend Transport; Tue, 25 Jul 2023 12:05:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 25 Jul 2023
 05:05:13 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 25 Jul 2023 05:05:09 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 0/5] mlxsw: Speed up transceiver module EEPROM dump
Date: Tue, 25 Jul 2023 14:04:00 +0200
Message-ID: <cover.1690281940.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT006:EE_|CY8PR12MB8241:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f31ced4-df56-4733-ff49-08db8d076f62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nb3l8LK+fWIk93fAMsVHhecfcd7BOdanko8fOpyKprBrKjuP90qzFZEq8IBLL7yxVAeSvKcSQgZ1u4d39GIkd9381w+XoXPB2jXVtFDZI9c8KEzu1i7+DpJAsXd9VnLMWTGDjkDzxfUCxbRCw3RfLGnFO18e+WxuEscQ4YqDiABVumZqMuqoE9qaRSrlEptpITbQgQ4oxHowAZXhy/E3AaXuWOCWm6r+dICyzYzpAemeKN9uwL0PBq6v4tUOFq11LLlgevuZFv8d9wRORRw1lALQEvMoI7DBL5cinF9oEtko5gXXRKQc38mag6xTO96YucPeHqxS3a/7D4vPKHbI9xIAOQki0cPI6lKvrKPNbYLqb4lmBMtUaf78i2EtKwK6knDNwkZMJ8pwjZ9jdLAE5MkFVQ6g19zEi2+tGqTNnRwG934yXhdA6agpkIv+HH3w5Tq/4aXRTT6BMAN+AelOaDH4XxrYXdEVP7+kyiDFQ1Bzhod6eMIlxAZLBIUn02CAr8tmrJt6vHdc90JBzak8j/sXF8SdWbvJgXZSQh9Fe5ZNXk3EPld5EPogORMz55iTgxaFS2ncb1ZCk6tamhZJvklMA7xb4Ars2F6f1S2H59Ogv75je4U5YYeaMkehGR4FlNVQh9Uk9JF17ZL8F73ilvcRBLAodR7ISGJAW2MlFIPfwvyDOL2mKpjynQQ+bGdFMUHs2qxzjs+PpanYY8p9BvfaQ1cCnkIaqXOy3GZF8E3Af/WKIYT3tXi3r0njOUmz
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(36860700001)(47076005)(70206006)(83380400001)(426003)(2616005)(356005)(82740400003)(36756003)(86362001)(40460700003)(41300700001)(8936002)(5660300002)(8676002)(7636003)(6666004)(7696005)(478600001)(54906003)(110136005)(40480700001)(316002)(4326008)(2906002)(70586007)(107886003)(186003)(16526019)(336012)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 12:05:27.5166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f31ced4-df56-4733-ff49-08db8d076f62
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8241
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Ido Schimmel writes:

Old firmware versions could only read up to 48 bytes from a transceiver
module's EEPROM in one go. Newer versions can read up to 128 bytes,
resulting in fewer transactions.

Query support for the new capability during driver initialization and if
supported, read up to 128 bytes in one go.

This is going to be especially useful for upcoming transceiver module
firmware flashing support.

Before:

 # perf stat -e devlink:devlink_hwmsg -- ethtool -m swp11 page 0x1 offset 128 length 128 i2c 0x50
 [...]
  Performance counter stats for 'ethtool -m swp11 page 0x1 offset 128 length 128 i2c 0x50':

                  3      devlink:devlink_hwmsg

After:

 # perf stat -e devlink:devlink_hwmsg -- ethtool -m swp11 page 0x1 offset 128 length 128 i2c 0x50
 [...]
  Performance counter stats for 'ethtool -m swp11 page 0x1 offset 128 length 128 i2c 0x50':

                  1      devlink:devlink_hwmsg

Patches #1-#4 are preparations / cleanups.

Patch #5 adds support for the new read size.

Amit Cohen (2):
  mlxsw: reg: Move 'mpsc' definition in 'mlxsw_reg_infos'
  mlxsw: reg: Add Management Capabilities Mask Register

Ido Schimmel (3):
  mlxsw: reg: Remove unused function argument
  mlxsw: reg: Increase Management Cable Info Access Register length
  mlxsw: core_env: Read transceiver module EEPROM in 128 bytes chunks

 .../net/ethernet/mellanox/mlxsw/core_env.c    | 45 ++++++---
 drivers/net/ethernet/mellanox/mlxsw/reg.h     | 93 ++++++++++++++++---
 2 files changed, 112 insertions(+), 26 deletions(-)

-- 
2.41.0


