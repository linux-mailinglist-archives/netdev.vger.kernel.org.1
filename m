Return-Path: <netdev+bounces-26848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DEB779372
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 17:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BFD32821AA
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 15:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6C52AB3C;
	Fri, 11 Aug 2023 15:46:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007B55692
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 15:46:36 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDDB18B
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:46:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAU4zX61csf3aZH8qdm92uEj685k+SxKesFAeVEIjse2hJ57O/HVdl4gGe2RDZGKCsEBOK5o+94lejn8KZUmYDt69UEnydg0aHjlKrOvbrTGEs77orQAc2cwYROOK6MDJlF6azDtFJ6ZrW2Y0akyBEflqeVjv1ub1Za2uu5gYuplcVojKCuVrfAQ8ATiqB137cPsmdE4e7yq6SRi1SC86tfJSV9bMVPWRSyhVdFNOoaipNiRsJlB8B13ff+QrIJVN/arRtBbRU03Gpb789KPCOnZxVJvI8Jur+QMqy13Qc/hIE9XWG/CkMx1UUhA9Ziph1UE5m8wFWqwV1Jr4qTOCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfxjnjK+z+cZGg46Qe2ypxuIJhJtvLynBgq8x7M2EVM=;
 b=eRWRG5hYv7v294c6Iv399/Qr9DfHYUDX0Ro5IdMOm0R22aRqgdqQXw7yOO1G1uXHM/wmbw0O2ov1NCC3/8B36SZQ6sFRDKbs3k2gDTCtemkA4f7gboD3U1MHKhK4kmwWUnOprKvJxdmhy5vk0heFiD8BuU7rRCnIofFk7/M1seA3WXzbpYrowW48Sl7Hu+UMu6uFRZrrSZjKQNqxO01nIlIGDjsYZqqoTwXZzv5RdjGUm1iBX/zFo+iRH1sZg3IyDKpgkFKIyf+rP5YguQp7G/NGQiTDACJ16TzDzxVdSi8C7otGsmd/PNQAZQGTY9udZKherZzdDDHX1Y1I5J49PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfxjnjK+z+cZGg46Qe2ypxuIJhJtvLynBgq8x7M2EVM=;
 b=DRDX0orJuZvUla61JL9plcNtk1C1wnaIC6NGzE12kFTqhWzUW+emuqHL0qnL4ZHgIO80jjFyxUWkOQQlK/3b/rU3GDd7BXjYLacF9WbUah3idUkf9DcnBYy1gbz8t++9YlEvZj7MBmefKFQk7vEW8ehvRy5HlbNbzspWgNOc5uCjYbAcoKdVo9P/6QB6UzpU0bjeQUhibpSp2G745GsR9sDnmSDZ+dYUgSgTYL18qYvcTpT71NDBnkM9nkUpkSBkhT+QIBNF/VtD08x1zN0MaE9mUU7onUZOwvMmt6GrnNMfoxbNx0rC4jMJRVI0S0NyPKiTy/tIk0zv5N56zDVqoQ==
Received: from CY5PR22CA0076.namprd22.prod.outlook.com (2603:10b6:930:80::23)
 by SJ1PR12MB6050.namprd12.prod.outlook.com (2603:10b6:a03:48b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 15:46:31 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:80:cafe::51) by CY5PR22CA0076.outlook.office365.com
 (2603:10b6:930:80::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 15:46:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Fri, 11 Aug 2023 15:46:30 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 11 Aug 2023
 08:46:18 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 11 Aug
 2023 08:46:17 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Fri, 11 Aug
 2023 08:46:14 -0700
From: Vlad Buslov <vladbu@nvidia.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <amir.hanania@intel.com>,
	<jeffrey.t.kirsher@intel.com>, <john.fastabend@gmail.com>,
	<idosch@idosch.org>, <horms@kernel.org>, Vlad Buslov <vladbu@nvidia.com>,
	<syzbot+662f783a5cdf3add2719@syzkaller.appspotmail.com>,
	<syzbot+4b4f06495414e92701d5@syzkaller.appspotmail.com>,
	<syzbot+d810d3cd45ed1848c3f7@syzkaller.appspotmail.com>
Subject: [PATCH net] Revert "vlan: Fix VLAN 0 memory leak"
Date: Fri, 11 Aug 2023 17:45:23 +0200
Message-ID: <20230811154523.1877590-1-vladbu@nvidia.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|SJ1PR12MB6050:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fff7526-ef9a-47fb-3e40-08db9a8221cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NLTu0TKlDwB8/c3sFDKeTQEid6lLeuN29Axsygihg+cJFFITFZjmzVGnol+WEXBBAgl+UdKeIvpklAZDCXvbrTwcd2f2goQdvmxbMVPHYHEH/u56TOKO+yuYR8U6UQ7seDfJToxJEWIxwP0NRt8Jirr/jzM8na6YZm7aW+FQz/dhtqHGDgM1+xf75Rp9o5M4uRCJUjceJKHyaNCVZoU6+Pg5ZyNKVLSKgiiTKuT/JqQZ2BmZB7ZbGeH0PCvp5+uJ92GGQRPR62GmmrJWWW++tahJknHmhNeTY6ZGM00j2yWXH11DB5UkucMuX+QHUilODBRUS+NvuEFNbLRXoWRLJYWmgngpMQnl5vgHxJl5Bvvj4WtrWmtipNSRP+0x1wrTfgxZ3LBLmfDrGsvLmUJO/UCzeecTolxU6oCw/qnHUFCz0UHYiKDmuf1a0/qcTcz4Xi5A46TuNuxrQFtx9Zf+p9Kk4c+aCpWy6WyUs1WdMgtQoQivL7vv1B+VbE+wyayyFEFdlG01QkSPpy6cLKeJx8fQijuprAo8Y4gpGdqtS0wrCBANB+Ed9/gzS3YS/RxgxOI2b9Jp50z7UEH/1g4STsAsmJmPd5ZfP0238N6jtN0gwRphzJ4nb3JPifGtd11g5aYXEG3CnFkJbIeanHGTn4W2VE/jQ7WF+UJEeZJD+g2iHbXrGzAuCDovaHjXB8ZECU3L3kiEEr49RNnVyJYDS/mzsihSh9oE9mHyFvWXuNWOKB2lXxDeQTE6K45LehPxgXuwhbnB9JHbad9ZC4Tr/Oo4Fjmf44SbSZAPM5Ki92Q2JaTF4s+OKy5VJBAICxNp
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199021)(82310400008)(1800799006)(186006)(36840700001)(40470700004)(46966006)(426003)(40460700003)(7636003)(83380400001)(336012)(2906002)(2616005)(110136005)(40480700001)(54906003)(478600001)(86362001)(82740400003)(36756003)(316002)(41300700001)(7696005)(26005)(1076003)(6666004)(5660300002)(8936002)(36860700001)(8676002)(356005)(7416002)(966005)(70586007)(47076005)(70206006)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 15:46:30.5044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fff7526-ef9a-47fb-3e40-08db9a8221cb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6050
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This reverts commit 718cb09aaa6fa78cc8124e9517efbc6c92665384.

The commit triggers multiple syzbot issues, probably due to possibility of
manually creating VLAN 0 on netdevice which will cause the code to delete
it since it can't distinguish such VLAN from implicit VLAN 0 automatically
created for devices with NETIF_F_HW_VLAN_CTAG_FILTER feature.

Reported-by: syzbot+662f783a5cdf3add2719@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/00000000000090196d0602a6167d@google.com/
Reported-by: syzbot+4b4f06495414e92701d5@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/00000000000096ae870602a61602@google.com/
Reported-by: syzbot+d810d3cd45ed1848c3f7@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/0000000000009f0f9c0602a616ce@google.com/
Fixes: 718cb09aaa6f ("vlan: Fix VLAN 0 memory leak")
Signed-off-by: Vlad Buslov <vladbu@nvidia.com>
---
 net/8021q/vlan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index b3662119ddbc..e40aa3e3641c 100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -384,7 +384,8 @@ static int vlan_device_event(struct notifier_block *unused, unsigned long event,
 			dev->name);
 		vlan_vid_add(dev, htons(ETH_P_8021Q), 0);
 	}
-	if (event == NETDEV_DOWN)
+	if (event == NETDEV_DOWN &&
+	    (dev->features & NETIF_F_HW_VLAN_CTAG_FILTER))
 		vlan_vid_del(dev, htons(ETH_P_8021Q), 0);
 
 	vlan_info = rtnl_dereference(dev->vlan_info);
-- 
2.39.2


