Return-Path: <netdev+bounces-16688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B4B74E5C4
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 06:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30C9E1C20D3E
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 04:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939464426;
	Tue, 11 Jul 2023 04:25:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDD83FE6
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 04:25:05 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6DB1A8
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 21:25:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPvN89fl+gZdr3d3ngBA9d+VYKsKSgmVTkb2Qu6Oi8rSkxi2XsM6gJKUJPbhVpcKJE/CxRx8Mtc5O4YWnJ5TYE7S4pcWgm6bbdm0acy486eScK8x/OXsi2dDaLStmb4jhPDY0DZRdZndrIh9erIKeMOOT6G8lVjoGtS+aRoMC3wYjJryexHNmVs/bV3RkhdFJ8pH9b7AWqNX/Qe1ZVFRpjVzyIp60vErceI+YH0Btxma32Wvn5zeoNOzoDjvquyrTfr+1bcJcB0qKP5fqY6ttCwW7kyB6qQhhCG1azDqIqjHLNy+ybn5jmb8h9rfn13uguKDjbemXCN6+sOwpudBgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TlBp5Qasi41xsigb63ccb1Pkxfm7qdOnN6sxsq5xNW0=;
 b=dWsxjDVZ5gC8v05ImKzPlj5m1mrGOgMUXejg1iIPh2BT+VjVmU++sLtr9MnQY83cuiFFFTPbEE/bOPNDiu/jmSPqW/7avxz/jal015jmB1On/Q6d7RodZpNKs+ZtMh53UmfYcoMch9nI3sERVhH/bBEDF+F0ZAYZk443e65j1/DvuB37K6rNLQRSYrN8zy3QYJ/5ts16/gR/aHVXaajASFz8V0S17Jcq4/PMtS81hYoTxf4Z3k8A7Pp58oLOdKze86lvNgdfi8Bd4lNJJoIKaY7VvBi3BVlOp7lKzAu4qR5d+1zMErIQYXJl//7h3STQzzoAai5MlC38mSNkxNRXUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlBp5Qasi41xsigb63ccb1Pkxfm7qdOnN6sxsq5xNW0=;
 b=ybdg8D2oAcVtd/vfWSlEdIbB3gNUK4s0rHLaBa4mQs1fRjp3Ra/7YG2XP8Kuh33MqS9COZ74Lzn9ZuJphwlYTgch0hI6t0TMbPn+BdaotlhU/VBGmfPC2tWOwNePhitUhUkfT5Gvi8CfOX+yv/sTxphC1yPOOYD7t2HFZF1U9jc=
Received: from BN9PR03CA0363.namprd03.prod.outlook.com (2603:10b6:408:f7::8)
 by CY5PR12MB6057.namprd12.prod.outlook.com (2603:10b6:930:2e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Tue, 11 Jul
 2023 04:25:00 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::c0) by BN9PR03CA0363.outlook.office365.com
 (2603:10b6:408:f7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32 via Frontend
 Transport; Tue, 11 Jul 2023 04:25:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.20 via Frontend Transport; Tue, 11 Jul 2023 04:25:00 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 23:24:59 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jasowang@redhat.com>, <mst@redhat.com>,
	<virtualization@lists.linux-foundation.org>, <shannon.nelson@amd.com>,
	<brett.creeley@amd.com>, <netdev@vger.kernel.org>
CC: <drivers@pensando.io>
Subject: [PATCH v2 virtio 0/5] pds_vdpa: mac, reset, and irq updates
Date: Mon, 10 Jul 2023 21:24:32 -0700
Message-ID: <20230711042437.69381-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT045:EE_|CY5PR12MB6057:EE_
X-MS-Office365-Filtering-Correlation-Id: c1540cdc-fbd5-46d3-5feb-08db81c6ca9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z2INtB/ELjyv9e9f6/Ug1ocIcZeYiCGLJPbvsPijVIVhJyYl1tpGZJvGhkNdE+qkx9K3dC8Pj2jxaADNxb7w91Vu64M2VFYmlw2opLliCNJapAH6q8DcMY/Jo0iYhl4Z8Ilxfi8DS+oRTnSw7BjaQpKGUi7USmQ0ce5R1o8qFVjkRrBt33IS8ImbtYd5NAUt8VNn0zpeB2WxOihno4wDZHilxJE5nt/ZI3qqrIJ6B0z4TjtIehe13aFzLdH9ru3uHU67X17M2255tpXcPnU4+n1ioWl9tmNqdjl+Vc7+Y1SjcPTuFglhwUbqqbeg8DRC6j0LbggWeijHh+OYzxlsJ+ESkJIfPKpeMrSfwKa3a2I0XrzJc2Ti4L9od6R90+wwceYYES9VJnhxfr9Evf9UAjPHND7wwLr6HLMTomL4DHB54usP+0tlAxrP0SoEzoduD1xV9ISOSUCxUywr+z8ilIbLs62EKgSI98YlJlizGgbMQeau3mRo+bhTH5PVjFXu/Ssikt4z6B8Ofb6gDsm2TvBu4ozwLZ3JByj5JDN0bCR6oPUqRhYUF04iKBO57jm4JsN2R1bvsNgZWZscizBC7PRJKTdn7MNeuIzWL0+y8XGPFFF/snLyqOvMl7xjoHJ7k9JCN4xDhNSBVXSTSLuBJClWyDXDctL2PT+P3gHJqHRvRJGAGoJIiTJ5eXxEDcC7sIAFNf5kUGZGdrc1+KkB4bH9zcsdVzCV1LWhHoEU0N5z0wdwpmpUJ/AArG/0Kt00DavoXKFgiI6/t/2psR6C+g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199021)(40470700004)(46966006)(36840700001)(2906002)(4744005)(36860700001)(40460700003)(66899021)(426003)(2616005)(47076005)(82740400003)(82310400005)(86362001)(36756003)(81166007)(356005)(83380400001)(40480700001)(316002)(4326008)(70206006)(70586007)(336012)(26005)(41300700001)(186003)(1076003)(16526019)(110136005)(478600001)(6666004)(44832011)(8936002)(8676002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 04:25:00.5407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1540cdc-fbd5-46d3-5feb-08db81c6ca9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6057
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

These are some fixes for device providing a MAC address, for allocating
irq resources later to support vhost use, and for properly cleaning
vq info on reset.

v2:
 - check driver feature request against supported_features, and strip
   the F_MAC bit if needed just before writing to the HW.
 - report the driver negotiated features in get_driver_features()
 - only map the notify on initial setup, not on every reset.
 - added patch 5 to clear up some driver feature debugfs output

Allen Hubbe (2):
  pds_vdpa: reset to vdpa specified mac
  pds_vdpa: alloc irq vectors on DRIVER_OK

Shannon Nelson (3):
  pds_vdpa: always allow offering VIRTIO_NET_F_MAC
  pds_vdpa: clean and reset vqs entries
  pds_vdpa: fix up debugfs feature bit printing

 drivers/vdpa/pds/debugfs.c  |  15 ++-
 drivers/vdpa/pds/vdpa_dev.c | 176 +++++++++++++++++++++++++-----------
 drivers/vdpa/pds/vdpa_dev.h |   5 +-
 3 files changed, 134 insertions(+), 62 deletions(-)

-- 
2.17.1


