Return-Path: <netdev+bounces-24015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C356776E782
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DBD428208A
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9363F1E501;
	Thu,  3 Aug 2023 11:57:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864D01548D
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 11:57:28 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A11330C4
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 04:57:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8+0gA9gT1EYRc5Teafp5nSewEQn68E02Zrfq0OCnj8Dqog9N93/MUKcUOXcp5JP9gSmN13fGZqeE7teU4AEkdP6MwJPzrQPxVTCSP7lyef3G+7u/QC83DXHfqWY2CXYNXD634y65qZTbCkvf9zwNMjaJTWkkiA/Vwu4tWEvV1oNuOpmjvyHKSO7wrGW07NkNo6gF7iuHEPZ+7DNhR2Cf1V7t12sk/MztvVEhJWicYvX5cSk4A+py5FecKYWOpQ11r3Wutyu0UqOdhMcNWWKfRNgrz1EgmfOMF3VtasWNI8Qm5pzGpwRnYTNO/fsCtefiRRtgqIk1W31kqMzZDpgyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJEZBjda/7je8RwNZgj3garNr138305ikfBo4JH6X/U=;
 b=IpoUjYskffuirJDsfJgSyk1XkHmbahj3XkQLsl3nMmmW/hC2yTAzxKJsAqu3kGstfLZSfCaosrwl9rzIkUi6Hoqlh8VHq6v9HxSOkEW+RvRj3xOndDXYdbx90dI1If2nwclNoCPQMc+GFKkhXL9GTE/2s/mQvSjQP/xkiWNcH2Rlu5CBVuq0zkrNinTC61F3JfdiGBgox65vg5rlds1BIrCE3ajYJTnGRlyu+T6oXJ8rvxk74IrTXrphP5ARwSUKsl1PWhumEMVt0U5DchEe9eFVApC3WJ5TUdcOHlnmmkAncTK5es3rQZMGh8AdlKWA8qoo0sTotESNQU8iw/YL0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJEZBjda/7je8RwNZgj3garNr138305ikfBo4JH6X/U=;
 b=qjfXpivTN9fNrqHWMCLuJ5/Xu2F2xKOSy0h7JR72MVyTfWnN6HFMg5Q+JEQDcPcTakkkPY+SJsg7T5K+b5a0O8l0NVn7sIG3273DQf8E/OyjYDpJYpCMY3BnkQGFu2O0iOTBN+NRORv3XpXthhOIG5yXnpHz+fj/vziliKJHn4A=
Received: from CY5PR13CA0055.namprd13.prod.outlook.com (2603:10b6:930:11::7)
 by IA1PR12MB6187.namprd12.prod.outlook.com (2603:10b6:208:3e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 11:57:22 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:930:11:cafe::68) by CY5PR13CA0055.outlook.office365.com
 (2603:10b6:930:11::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Thu, 3 Aug 2023 11:57:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Thu, 3 Aug 2023 11:57:21 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 06:57:20 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 04:57:20 -0700
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Thu, 3 Aug 2023 06:57:19 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>
Subject: [PATCH net-next 0/7] sfc: basic conntrack offload
Date: Thu, 3 Aug 2023 12:56:16 +0100
Message-ID: <cover.1691063675.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|IA1PR12MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: a3368b30-f633-464e-fbec-08db9418cb5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NCEnUzGqX6Bi+hEt0r3Z2xBdQQd1uoaWSfqW5KYFs2TEpCy2DeWSRzZRPw3CGtBIbNDjaD0/gYDo6GUBeQFeugj06uWgtyny9EO6pqbQVafauyxuqD1mgniuXPZc9CkUxKdrAeGkNNQRVH/0f6wJSBpGqH9ZcgRqZb321p81xo/4HRUFPcfwtXcwiFpIgcfCsE5WmCq9vxIXxUZ5FcHJwcIt0smweNCeTfrSqbNeX5qPeF0GZe9Wc/LkczUo+zz/3vx6hyI4qxfJGMbXGrtbWgsGqFv0Hfno2dILZ27RfiA7G/2rJEyVZr2pkxmIarZAqN8XEaCvNkMgeHnb7ruhgSABYiz5ZuH3dkzEX2ipFqpP/vLQHKOPxd5YsaPJczhJUfLaaXUn62uBCokTxZTDki3gHRf2O660YoYIzy504mBWiahXBLZMEXaa0V6i0uWH+v6tl2F/4aGJPyQlL8BpxbfyRWEuy3KevBeV2ArssLXa2BcBxtGvoPex8IQ5wf2NuVy4nrq9MZMZ5X75Om8Md0phjUcOmZ0Y8p55gBKlg3LtMOb1/NDSAdaDBpq2RoJJfqbVo8Y7+skbjvWxLKJEcwIkdYSFIFxTrlnrI44ocqNOIG83WTWhliD9lP9faqgmWykZXlnFS+6zCG/OvPXQF8Z3+gIi2OChrNr8qgkyWEPWurDC8wgWNJX9I6ZINH8EnZRgTRnWd0yTjMgZPEIQGbfqLZEKaFEyuKw+JMxwtutT5/JPtYevouQ0TWg8zMK2F0QmRm1I6c1igKO/msR0lw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(82740400003)(40460700003)(426003)(83380400001)(26005)(186003)(336012)(47076005)(36860700001)(316002)(2906002)(2876002)(70586007)(70206006)(4326008)(5660300002)(41300700001)(8676002)(8936002)(6666004)(9686003)(54906003)(110136005)(478600001)(40480700001)(356005)(81166007)(36756003)(55446002)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 11:57:21.3957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3368b30-f633-464e-fbec-08db9418cb5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6187
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Edward Cree <ecree.xilinx@gmail.com>

Support offloading tracked connections and matching against them in
 TC chains on the PF and on representors.
Later patch serieses will add NAT and conntrack-on-tunnel-netdevs;
 keep it simple for now.

Edward Cree (7):
  sfc: add MAE table machinery for conntrack table
  sfc: functions to register for conntrack zone offload
  sfc: functions to insert/remove conntrack entries to MAE hardware
  sfc: offload conntrack flow entries (match only) from CT zones
  sfc: handle non-zero chain_index on TC rules
  sfc: conntrack state matches in TC rules
  sfc: offload left-hand side rules for conntrack

 drivers/net/ethernet/sfc/Makefile       |   2 +-
 drivers/net/ethernet/sfc/bitfield.h     |   2 +
 drivers/net/ethernet/sfc/mae.c          | 827 +++++++++++++++++++++++-
 drivers/net/ethernet/sfc/mae.h          |  12 +
 drivers/net/ethernet/sfc/mcdi.h         |  14 +
 drivers/net/ethernet/sfc/tc.c           | 532 ++++++++++++++-
 drivers/net/ethernet/sfc/tc.h           |  86 ++-
 drivers/net/ethernet/sfc/tc_conntrack.c | 533 +++++++++++++++
 drivers/net/ethernet/sfc/tc_conntrack.h |  55 ++
 drivers/net/ethernet/sfc/tc_counters.c  |   8 +-
 drivers/net/ethernet/sfc/tc_counters.h  |   4 +
 11 files changed, 2038 insertions(+), 37 deletions(-)
 create mode 100644 drivers/net/ethernet/sfc/tc_conntrack.c
 create mode 100644 drivers/net/ethernet/sfc/tc_conntrack.h


