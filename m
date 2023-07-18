Return-Path: <netdev+bounces-18708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8331375855A
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 21:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53C2E1C20DE0
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 19:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9991168C6;
	Tue, 18 Jul 2023 19:09:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73AC168BC
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 19:09:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E00AF0
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 12:09:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqvBsY/c0Gz4MwXn3MetyT7Y90gc8d8s9SNUF7nqR7GKSzJUVZ6g2doGpGyr3n+SnuY5lcMU7EAiIZ5OteKWBYeJbLUUfbF1ffKFZ4jEPdRBW78sVS2F0iecZyBfH4hvqMiHSUGR5FW6h8X8BMRD82hXkJ/DdsYaO/yxKcbt7mrdO/pbew9Ap0bnDj8SGqonMf3xESmNKa2nzv17fVSrQ6z19pCpLgJnAzBAcS1MvX9VvbkJBCAb0vHm0g1kVwViO60XFYnasKNDhGGRpUOjGFdc4T+23/w3LU3Ikxh8EuyuITXI2XjQ09wdqPG1xHHQnfEK/EIGxHOrbmHZgfM5gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dNZTb3OeiTLZa3ToEnzWZenVBSb6Y9VIKFbHM8m9oM=;
 b=iSAHeopQCJjKdgZiQprETDtCrXB1Oh/ywNIJRNWnOM2isBLvbtg5S6jx3jGYDyi1krJtNtMomTY/3pAR/hgkqXp2XqT2qErao45AQ/tGOhMRfIia34vA5z2fWDPq7zx97ErrdJFqLh3Wd9JbdQmIuqwnYhXX9eTLhe/noe9sSikAS845OpRqvupFSsCJCJD9sI87a/YZZ9iggeXC9cG/bqwhoBd6GuUfwSz1YclkFJ0DxpnkG1zmZ1SGp79OkbAS8WDHa+v89KhRjUeNl1/iYGFF04KspaKRG+KvTzjlBDkJijfCuaAzNZuVo6wtUHyzPpHgEElUcMf3DOematF+pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dNZTb3OeiTLZa3ToEnzWZenVBSb6Y9VIKFbHM8m9oM=;
 b=YYSxPlMh0pZ2uisGiEUI7L3jmfnlcioaK/4a1Q2Q6kwpOVZ/loeHS3k1/OCRb75y8TjbaSvyhz6jupwgKtAi5R+FWqapOh6nlaKJSjV3vEjzEjezxoz8jHCwzP+Xmm/CdeWkQFvJsANi1opVPDgaMvTyxoHKLyF0QVGOofUvD/g=
Received: from MWH0EPF00056D05.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:e) by IA1PR12MB8540.namprd12.prod.outlook.com
 (2603:10b6:208:454::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Tue, 18 Jul
 2023 19:09:39 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::209) by MWH0EPF00056D05.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.8 via Frontend
 Transport; Tue, 18 Jul 2023 19:09:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Tue, 18 Jul 2023 19:09:37 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 18 Jul
 2023 14:09:35 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <shannon.nelson@amd.com>, <davem@davemloft.net>, <netdev@vger.kernel.org>,
	<kuba@kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<virtualization@lists.linux-foundation.org>
CC: <drivers@pensando.io>, <brett.creeley@amd.com>
Subject: [PATCH RFC net] virtio-net: add timeout for virtnet_send_command()
Date: Tue, 18 Jul 2023 12:09:20 -0700
Message-ID: <20230718190920.53544-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT015:EE_|IA1PR12MB8540:EE_
X-MS-Office365-Filtering-Correlation-Id: 632b315b-671b-40ed-8757-08db87c28834
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LKsp7iSF/U/L3AToxHwqruHRRHfhgOXG4l14E0+3EVLvJd6yOCIxSplFgtteTvUFeRpUdDdQNH2CLbfCvc94pgUtVG9oFpdaseNvrQcHirm4L8FV19XGgFVCf0ixFZyNLUr0e1T9n6ztSacHiAjAL9PVrZz1RpY7x/sbVLVgPu4/x+oI1xPHOhCNsnXac6Vl16fK31AGb5eW2BpUJnim4YzlLkYD7DXfk8Adcpiw4/jUyRT+2p7hyU05by+UWKTU7Xo2Ty3I8Ai1n4R64CRYyJyzfz4QOxY2jz4MXHVldSU8PgPy3Nben+oaKTUnDO6bx2nUk9oh1Md9dIUbaMM5gK7kEXULF84REm7GGSVOpn8H2is91DfBHxxNmpF577qDaGbf26G9fuLFYMf1J7PCfuswHqSJK96fSap/EZ0GrNQ0xc8aaxiS+nQlfvYxZeBmEFuLI0srTuGnTJHE7l/c7tX3UdbyKAJAf8THfo0Hs9si5qZvz6GvaGefJ9uIlGqgCW+dtbLqRXgNQBE9d+ILhGCdoKjTIxw+yzmOLbKcn8In5gb8zUvL/Og9WLDhn+3wTIQJo8+VfCZNJBmDk9JnLaazd4EbA2fr/RTh1F7LFN8579MuwaGj5ZEOBf7yRp76Kgthx3eetpajt5yyVFX6gWhd92Y9gXr4BtGlHQT0z79sf272IDDsxFDeHrBVAAUKplPKFGtBWcAYQD1l4jc/Xhi/e98MLh9ictgLhC0V6BiYT+tcflnMPn06gxy8I+JcJ+GaA+/4MvCSJ9CUSNjP1A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(2906002)(44832011)(8936002)(8676002)(4326008)(316002)(41300700001)(5660300002)(966005)(26005)(336012)(1076003)(36756003)(186003)(70586007)(70206006)(478600001)(6666004)(110136005)(16526019)(40460700003)(54906003)(83380400001)(47076005)(2616005)(426003)(36860700001)(82740400003)(81166007)(356005)(40480700001)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 19:09:37.9887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 632b315b-671b-40ed-8757-08db87c28834
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8540
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When trying to talk to a device that has gone out to lunch, the
virtnet_send_command() will sit and spin forever, causing a soft
lockup and eventually crashing the kernel.  Add a limit to the
spin and return false if we hit the timeout.  The 2 second time
limit seems a bit arbitrary, but a reasonable place to start.

This is a little more brute force than Jason's suggestions in [1],
but at least prevents the soft lockups and eventual kernel crash
that we were seeing in testing.

[1]: https://lore.kernel.org/netdev/20230524081842.3060-1-jasowang@redhat.com/

Fixes: 2a41f71d3bd9 ("virtio_net: Add a virtqueue for outbound control commands")
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/virtio_net.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0db14f6b87d3..c3bf1c9f3244 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2264,6 +2264,8 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 {
 	struct scatterlist *sgs[4], hdr, stat;
 	unsigned out_num = 0, tmp;
+	unsigned long deadline;
+	bool timeout;
 	int ret;
 
 	/* Caller should know better */
@@ -2297,11 +2299,16 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 	/* Spin for a response, the kick causes an ioport write, trapping
 	 * into the hypervisor, so the request should be handled immediately.
 	 */
+	deadline = jiffies + 2 * HZ;
+	timeout = false;
 	while (!virtqueue_get_buf(vi->cvq, &tmp) &&
-	       !virtqueue_is_broken(vi->cvq))
+	       !virtqueue_is_broken(vi->cvq) &&
+	       !timeout) {
 		cpu_relax();
+		timeout = time_after(jiffies, deadline);
+	}
 
-	return vi->ctrl->status == VIRTIO_NET_OK;
+	return vi->ctrl->status == VIRTIO_NET_OK && !timeout;
 }
 
 static int virtnet_set_mac_address(struct net_device *dev, void *p)
-- 
2.17.1


