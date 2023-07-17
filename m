Return-Path: <netdev+bounces-18365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A4A7569C7
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 19:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CBB8281789
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 17:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C871FB9;
	Mon, 17 Jul 2023 17:01:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC1A10E7
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 17:01:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24F2D1
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 10:01:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEKzB0VumWrELvPSAt41+ZkMe++os2NF6I3bTxvWOtyuH1uS5RISa7/BQRCgqlE6mobNFQeRDmMI8//YEpzxkiWFfyRH7JxyW/M+bP1vn84cDqbRCHoLbYAKtKYru7z2WP6JIlLhENhWrlepVlPXAv7ZhW7Qwuu9/EsQcwhKez7w+g0CR26njE1XuSJf9RdsCx61ZiUa238YtAfrIzLdLyElFwfdqYm5IeC8N6MCHxh3A//uHKUVFqnGRsodXjWx/qfLGeO4Zmj3AXstqSPd40zjMsz0hCFoRd+/fUwykSZaK2MP7sE98xP9r1PYI7jjrsbqR26hEcSiVoRll1xg/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1VtZrqVRya3fXTy+0buUfBlLPBhfmFnBknPSyorA10=;
 b=goVam+BcO+QWlDMzPweZ6B9Q7LcKtsyDk7JMVfjX4Q57mdJa4b/v8UCStb6sqO9BnwiZVUslkKVwxpScyL6wKQ6DvBiGtPLeGIjiT0zlWi2KKqQ6I4aktsRSCK545dsDTiXuDGC4UM6ZZ7yjieQS6n8AeN9O4+gwTJ1wVY4RVne3mz84VvnicRbjYnCebTZkcyzOXUnK0N2ZiV6vLZYewPgCNsBdo9cGpyckGIEpl/NIH7CXyr6gnK2LPxnSo12sXCNOZwuotKnOcRZ80tz1OnjEfJJc14svk/GciKmcDUAc5kLeMyS6lCkHW3y3fnDglmYPL6wnq0yqtMMF8lLn6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1VtZrqVRya3fXTy+0buUfBlLPBhfmFnBknPSyorA10=;
 b=EoGAqCMDMIqy5npOrZH5ooGKBvNkc0AHuaviUkWHOg8nq7ZjC1uz/wkuppNkolC3SZKDA9JHbOfRugOO/5/cPgjUYQ4e3Y2aw1Xl/zz7ni05xBZ1WImc9ikjG5Q8LKbr2jJBgjE6kaYrIgmjxTfX+LJjGIbkmRSz+F81RzSxULM=
Received: from MW4PR04CA0317.namprd04.prod.outlook.com (2603:10b6:303:82::22)
 by PH7PR12MB6785.namprd12.prod.outlook.com (2603:10b6:510:1ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Mon, 17 Jul
 2023 17:01:13 +0000
Received: from CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::4f) by MW4PR04CA0317.outlook.office365.com
 (2603:10b6:303:82::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Mon, 17 Jul 2023 17:01:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT082.mail.protection.outlook.com (10.13.175.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.32 via Frontend Transport; Mon, 17 Jul 2023 17:01:13 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 17 Jul
 2023 12:01:11 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<idosch@idosch.org>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v3  net-next 0/4] ionic: add FLR support
Date: Mon, 17 Jul 2023 09:59:57 -0700
Message-ID: <20230717170001.30539-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT082:EE_|PH7PR12MB6785:EE_
X-MS-Office365-Filtering-Correlation-Id: 4506379f-6b06-4073-23b7-08db86e76d74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JIqOot0voA+u+AKzZGWPrFAJBjob9wPov9W2pvL+pQ3oGhYMvtkV/WM9wZIC4cQhjyapA4WCIOGzkYspcD1P+F5tWM8mVf53cTRSQX1/GlaPoZscdTK0Qr4MQmoM6sZyzojRxOSIcWcs1/JSMrNdcMd4efCQDKiuYjnuPHYSReQCzBfwv754fAHl9iB5PyBeYQBuV6OrjzyNg1AZhRFDqjuwSYuin5fJ3glYNJ5gw7nT2FkhdMssab6yJMnGRfPYKXCYefum2lS1Ew9pnE1DVhpi+HlkkiyAtLTK2JE46ivhL5GT4wAN5KT7bdEQ9j1LHSi9v99mdRZf1Bt3gNOKNB3gGur8dOidin4H8a/4OjOsTCMlLpp8N8Utvr4RU7lT6x9kwKdGxqYtFGBQ/2TPMVenX4h+Riu083WF2fpzS0wmV2bPvH2yfSGjZxzHgDZl9p3tTyuYIFq42IlDX6Bots90tOSa+BQ7iRxayGjGku6iNZbgY9Clluo7e99ZlTh2/InGsyuNQAtpmH51VIzKstLS8J9AeA40urLPn5rf5jzcVnoybAlW2my2tKNwZAwUcdDkURAV95nM/ijAQnmyLVqXCHo1peCxhnYSCAHMbNepjAA+csh01fLX9RFPayb7LBjoZAbU0cz0pcUm9Z/PHInrUGILM3zvWXzBUjZFe/wwIo4MwoO0tJKLL3DQuD5C/JQEGF4sgckFrdwg9LKpKL5R2P4rx2+j88cxFJGHgO93LHFTnuUu6c7OrTmpvd8b
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(2906002)(966005)(81166007)(356005)(83380400001)(47076005)(82740400003)(426003)(86362001)(40460700003)(16526019)(336012)(36860700001)(1076003)(40480700001)(2616005)(26005)(5660300002)(186003)(36756003)(8676002)(44832011)(4744005)(8936002)(54906003)(6666004)(70206006)(4326008)(70586007)(316002)(110136005)(41300700001)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 17:01:13.3546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4506379f-6b06-4073-23b7-08db86e76d74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6785
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support for handing and recovering from a PCI FLR event.
This patchset first moves some code around to make it usable
from multiple paths, then adds the PCI error handler callbacks
for reset_prepare and reset_done.

Example test:
    echo 1 > /sys/bus/pci/devices/0000:2a:00.0/reset

v3:
 - removed first patch, it is already merged into net

v2:
Link: https://lore.kernel.org/netdev/20230713192936.45152-1-shannon.nelson@amd.com/
 - removed redundant pci_save/restore_state() calls

Shannon Nelson (4):
  ionic: extract common bits from ionic_remove
  ionic: extract common bits from ionic_probe
  ionic: pull out common bits from fw_up
  ionic: add FLR recovery support

 .../ethernet/pensando/ionic/ionic_bus_pci.c   | 161 +++++++++++++-----
 .../net/ethernet/pensando/ionic/ionic_lif.c   |  72 +++++---
 .../net/ethernet/pensando/ionic/ionic_lif.h   |   5 +
 3 files changed, 165 insertions(+), 73 deletions(-)

-- 
2.17.1


