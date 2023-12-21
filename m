Return-Path: <netdev+bounces-59770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6CF81C03A
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 22:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01B1B1F24A1D
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 21:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C61D7763A;
	Thu, 21 Dec 2023 21:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KaznMSz8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957B376DAE
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 21:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eo/bN+d2jQD5h5A5sM3guPZ952MXcLv0wTTTTROW+VlsluJeQQJA3J7eca1A87tjYtR4/kT/vVVzy9dqn6VDenl+zXiiwXX0hzRsx1ZBLrHln4GUEbWePf0J2nii7DHLH3TP/1GT38lURVoJPVNOQGl4o8/WsZKUbiNoEV4/Cqy198sEVakNXw9/dxhrcu9+9ig4JhWigNZYDh1SRS0VHGlOAjz1ykNqyLNU1/FIL7T+xJ4gkBXRmx15gIlEHljyayotdCZ/PjHLKzcy7FyxrN1KyyjDtQ3qK7unoV892RGGRVM2V9moRrc2X2ba3upVa9fr7r20nb+sn1J3XHgFng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2LoW+wyJLGKqox2luchxX6ASlmSkahhXjlWSi1WRzk=;
 b=S0fN2yVDWvJTrzMcxMyQjdHOdXaOOxpNhDVpb7JqDd6hIltjq4D1OPziBQ/K8f2ekCNhVl5sXS1i/4rTBmVmVPtIP3O45/saToVbynmG+5NBBURKv93KJ0Mc5ZMDNYhmnbCc7xiWV7ZhrMskkRGfEER0O5PH6jMT8ZkJ4sUURp9CHuvw4mAiUvkZWswCbbF+WXgxNj1w7YxJf613TB8xQwEqIqoTN1li+Wn3VM2idlHhF1rvUiaYrDtMax8f7z83wtk0BMhJCgagrVVxkNW87uzbwAMbmUyb9PrEwa9DKIgajnAL93cUaSZAK9qeHfWH3AqipP3pDEMdYPi2dAT/oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2LoW+wyJLGKqox2luchxX6ASlmSkahhXjlWSi1WRzk=;
 b=KaznMSz8wrhgIBIRx1WzfR2MrgVHVBlv8xtOVp8QFyy5RrOgBDbLsSCoD3C8Ua6TzIqom9TDRJCg6sxZDakhzbnp/bGw+O4aUMSuSlLhHf4jFPkbdI2aeO61CZIsFyH4Vb7xAtoCJU6MEGLLAhkddFu4i7+I+BxA7+tP0mv5Sjv3/4RYWp/OJnYWdXDU04HXNZSndLWqqB52la7wHvFTji9bjmazpnM7g1d6JFf/gwG1NkXpovv1EAvbySfEh9mzqw4OKPnxsxsigi4R1vEJzy0P4d2EObwIIPtQSmqCYZQg4h1CqTb5v/QtqZuxFg5NeY0s5LDTGxocLg54qEdTYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by MW4PR12MB7481.namprd12.prod.outlook.com (2603:10b6:303:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.19; Thu, 21 Dec
 2023 21:34:44 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 21:34:44 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: Or Gerlitz <ogerlitz@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v22 08/20] nvme-tcp: Deal with netdevice DOWN events
Date: Thu, 21 Dec 2023 21:33:46 +0000
Message-Id: <20231221213358.105704-9-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221213358.105704-1-aaptel@nvidia.com>
References: <20231221213358.105704-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0398.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::7) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|MW4PR12MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c4be56b-543c-4d08-d06b-08dc026ca5a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Z96rIQ0PYQVOLHnTeLhgHB5Jqx5A/igBOCt/QMg/jEyn5Bcp0ySviGyzRnbe9ZR5cPj37FNRMu3YXuixOWeAHypBPlI3Pt52XFjXsqkZIAFwHfyOVCHOua/r5L04OYfMqLg2z9MIpSC99SZeOwrxsFEzDoPKd8E0QcJfAHnPMWtGMl9fo4d1IkgGsmAjWRSRslhsSlP0kW2XBxXopPXaQiMsfepvJyy1HyiAr0w0YvNQXZMXrmGDcpxjkSCPUVvcqrF1nxyw+zEkC2xlH1rzCKRdcQWINfmQLSFBHdlYJhxzF/0qbq1IFiZTUeL11pNRHIgRs5QbkbbkC2M83ATbr8Q+nGrj0cWXNe3UoSNj/c5wUsKBD9WHycaZdTNnoQEh5icUcv7gupZ54TSIY+EPzWAzD4cTchgcx+s/2jLt0OBN6M1r1FC+CkFzt9z6MQRj1A/pFkNnHvxhXEnqoVMXWfg+5a3dEpKdAEa3yd9U7xjZzeHz/NqGwRp9TNj03/plFvi8jNERgV48LMeYbxS0bfdI2u4VZ7I9uvBJ6l1b+CBxpazGd8Wup+OiYmeI7OVUeNTrPrbIleofq49ww2JDoAwV6aA10aJAA9Glu7MMRBE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(366004)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66946007)(8676002)(8936002)(66556008)(478600001)(66476007)(83380400001)(316002)(7416002)(4326008)(6506007)(6512007)(6486002)(2906002)(2616005)(107886003)(26005)(1076003)(41300700001)(36756003)(5660300002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z1MDaWZCLVn+pIDgy4OO4k0CIAxgsjvxSs9yrZhhM2hUXlVMgqOSCR1Vlgxd?=
 =?us-ascii?Q?eEB0t1LfYXvPoyGS0Z+BntZZbJLxsDPW2rvAbDX3hzilFTCf01SJDeyUjadl?=
 =?us-ascii?Q?/Or6IOteDHlCble0eEGdk4th3eFpy8slXM1g7woxWmE8qpCAWFVUsr043zvo?=
 =?us-ascii?Q?FdBN7PkDGdqQOVm7TEl8M1H1kiu7HJHr5azo7KiexdD5Bu391rEWtiiV6ZM4?=
 =?us-ascii?Q?RP5tCT2dZJjQE1vSRggHtqH0n6ViVrBVHgrx5rN9wRXGtz24j74cy9UwBrni?=
 =?us-ascii?Q?DbsfTEDeIGnIX5GHqzNOgfhID/+O5l4BlZihHTeSyZL+QFmzarOqiKd+Qrmt?=
 =?us-ascii?Q?IZAqqZXSSpAoN5ifKMkefKTqc2n6RpMcP67GbCZIPQU3ULr60QO2IjpsuxGS?=
 =?us-ascii?Q?Bygr8j+FvT4ItZxCCydTRDePtvqRYpbIqL7G+ShLTjqqH3aE9Q37d7RKrZ0z?=
 =?us-ascii?Q?JWLGLGEfF2C8BfqEiZBQWk4B8kgLDrd71LBShYSo9GkrNy9njMXpdci5t1nL?=
 =?us-ascii?Q?NZ7MFOUxp5EJWr5sKRexYA6Lyx00332U8X34emTR7mqH0uisdje42NVkHI+D?=
 =?us-ascii?Q?Rwv2BZSwKdPPbCrzKdtGHsFHE4orQ1HOa9l8K8uyeCEEiLwhUY4+iNveMd9t?=
 =?us-ascii?Q?krCZob+eNsS7pCYj0UXVx6/8TOU9V8lTz+X+cnX7R6CONJ7MoADLe3O8Rpop?=
 =?us-ascii?Q?7EhCFuRjphKzNgFqJ5e1aMXkjWweNz/Y0O+uwL7HkMfH8wGic10eMEdrkNrZ?=
 =?us-ascii?Q?e06yVvAwWP70aCkKdgBsa1W68BM9jDqVe7C0OeFrBqv7GAEmgs5g2zwsfzcW?=
 =?us-ascii?Q?SFG2mGiH5C1++wVOsOYLBIDaHzkOu2DHsZVyw1P2gKJUVX+7kn6WjPg/4RU6?=
 =?us-ascii?Q?7d4mvqg6G5UfTqTAfnJdbOKgrKfLn4LydxSob68tQ+xioBKFNN6fSGynqwuA?=
 =?us-ascii?Q?iQ6hB77vDB4z2ffJHvJaCuVpq4F2VspBcoX27pXtJ4khkUmqyaHlRjtP/zMk?=
 =?us-ascii?Q?u5uOT38qjTA18ZH9iQuM7CIceZG3CBswIybgFFaazjsplPDlz7on/1fugnPY?=
 =?us-ascii?Q?q9aTHHnkAxehrVc8HBVPYR5ZgFXfZnhM02SPkPrk0+yw6BKvgjYxzta2V9NH?=
 =?us-ascii?Q?zYll3L8VW+D18aSje1PEsLmorutOZAzr+yGHQDcmQczlhqtp3iEW5RdnHy8F?=
 =?us-ascii?Q?21PyeaC/RuJApKgoDwjkPDg540leD6O5xuP+3O1YNwm6zlkn8jvcPmfnnVN+?=
 =?us-ascii?Q?vdcdseBxVxaXcMTUk98+DLUlYBzBMKkSHgXIgT5y/GoEGia6P1hOZl3YL7RV?=
 =?us-ascii?Q?/S3G/IT3mqTG/5JYjd5T01SCqcGhZuCs8EYEOHj1gjNAkMCbzVaDrPc6kPtE?=
 =?us-ascii?Q?7v8iiDK0SDYNJKAzKP+gOWwlUpfBSewXEPGhKij+Wa9IAOU8PKE3a42bwQzB?=
 =?us-ascii?Q?VQ1tm/ycWdn7FZ3RS2ZOIXMmq1qPusrVbxn2kSmebZzfkq+FAU+A9kcKiVkQ?=
 =?us-ascii?Q?EuNro3oGpugWzBoM0Tz4idpHTDLV3U70RFelrl/CmykPe/g65ECZbQbythiY?=
 =?us-ascii?Q?GZ6SJLezNK/2+YMvfp+tqPcPEXdE1zkfpJZzbl3z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4be56b-543c-4d08-d06b-08dc026ca5a8
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 21:34:44.0023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mqYQEnEHwUgs4jBRqWFVFwlY0e1DS6DDM8JzQlnAqRLSLRn0jzTmAMjeJREw0Rt1qIi5py/VBXrLS23ZGYfBsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7481

From: Or Gerlitz <ogerlitz@nvidia.com>

For ddp setup/teardown and resync, the offloading logic
uses HW resources at the NIC driver such as SQ and CQ.

These resources are destroyed when the netdevice does down
and hence we must stop using them before the NIC driver
destroys them.

Use netdevice notifier for that matter -- offloaded connections
are stopped before the stack continues to call the NIC driver
close ndo.

We use the existing recovery flow which has the advantage
of resuming the offload once the connection is re-set.

This also buys us proper handling for the UNREGISTER event
b/c our offloading starts in the UP state, and down is always
there between up to unregister.

Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 6eed24b5f90c..00cb1c8404c4 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -235,6 +235,7 @@ struct nvme_tcp_ctrl {
 
 static LIST_HEAD(nvme_tcp_ctrl_list);
 static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
+static struct notifier_block nvme_tcp_netdevice_nb;
 static struct workqueue_struct *nvme_tcp_wq;
 static const struct blk_mq_ops nvme_tcp_mq_ops;
 static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
@@ -3193,6 +3194,32 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 	return ERR_PTR(ret);
 }
 
+static int nvme_tcp_netdev_event(struct notifier_block *this,
+				 unsigned long event, void *ptr)
+{
+#ifdef CONFIG_ULP_DDP
+	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
+	struct nvme_tcp_ctrl *ctrl;
+
+	switch (event) {
+	case NETDEV_GOING_DOWN:
+		mutex_lock(&nvme_tcp_ctrl_mutex);
+		list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list) {
+			if (ndev == ctrl->ddp_netdev)
+				nvme_tcp_error_recovery(&ctrl->ctrl);
+		}
+		mutex_unlock(&nvme_tcp_ctrl_mutex);
+		flush_workqueue(nvme_reset_wq);
+		/*
+		 * The associated controllers teardown has completed,
+		 * ddp contexts were also torn down so we should be
+		 * safe to continue...
+		 */
+	}
+#endif
+	return NOTIFY_DONE;
+}
+
 static struct nvmf_transport_ops nvme_tcp_transport = {
 	.name		= "tcp",
 	.module		= THIS_MODULE,
@@ -3208,6 +3235,8 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 
 static int __init nvme_tcp_init_module(void)
 {
+	int ret;
+
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_hdr) != 8);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) != 72);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_data_pdu) != 24);
@@ -3222,8 +3251,19 @@ static int __init nvme_tcp_init_module(void)
 	if (!nvme_tcp_wq)
 		return -ENOMEM;
 
+	nvme_tcp_netdevice_nb.notifier_call = nvme_tcp_netdev_event;
+	ret = register_netdevice_notifier(&nvme_tcp_netdevice_nb);
+	if (ret) {
+		pr_err("failed to register netdev notifier\n");
+		goto out_free_workqueue;
+	}
+
 	nvmf_register_transport(&nvme_tcp_transport);
 	return 0;
+
+out_free_workqueue:
+	destroy_workqueue(nvme_tcp_wq);
+	return ret;
 }
 
 static void __exit nvme_tcp_cleanup_module(void)
@@ -3231,6 +3271,7 @@ static void __exit nvme_tcp_cleanup_module(void)
 	struct nvme_tcp_ctrl *ctrl;
 
 	nvmf_unregister_transport(&nvme_tcp_transport);
+	unregister_netdevice_notifier(&nvme_tcp_netdevice_nb);
 
 	mutex_lock(&nvme_tcp_ctrl_mutex);
 	list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list)
-- 
2.34.1


