Return-Path: <netdev+bounces-44750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F58C7D9829
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 14:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F2FDB2131E
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 12:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA1C1EB35;
	Fri, 27 Oct 2023 12:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L9chiyb9"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B731EB2C
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 12:28:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F955121
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 05:28:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TepEZKclc4PTIEPOWnzYQ5jVAUh/jEZ0l7H/QW647ex/mXbs1Wg2FRKhTrYETKcEBMPZCfczrCpqLjUyLxX08WCOaaVw8frTXsA1ogi1+6e3Kb5+DsCBybJxs+8N5vh2ERtCo/VjkJuMBw7XhXAquwpxyajwOz9uniP/lFcoEF/EqaCp0OmSX7Cuyk8pOsvIg3lNZxQnk2EbR7Sq1i9Pvy1gIXfx0C0vPtsO/3JBdGnwMMFf0bF1tbv5xyZiPPhwKz+EhKlk3FG3/kR9wPiCnPq80ATFQ5C8O5oO0sAUSwEBH+WWGgVUbCR9+/ZFxLkhIuBGxaxCpL+fdPTNe4Shkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKIV6ojmN2p/pFbc7gLczkRHR609o1oCHQCYzZhBJfY=;
 b=m4apC1WvDgkNsCBqppXV4bT/fz1jNaO34h8tzVHaxS7CPwMRic27i0HRhctaN15yIKbSTYc+wOsNosF2EHz4pPmc85cGQ6+b2CxnySbtyklAimizWipG6EaQAVPFdUl6d1gq0ptU7CeAgKZOtrCFtn8R932HEGeMQqbiLbJ0DnqghQYt/QxbpVBSN6xlCK6JPNmCxURqOHbrTbBpGTNTQt9Ca/YGvRWuPa70A2gwUadpScUg+rLbqr2ybzBib1MtMaU665d6nuJOfja2jGfT3v46Xg8kU1QjOsfAtrjwsaTBQgb9h4kKytje5wkq6Vgp+WcLZ1IT/dcHlIUMDuTJHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKIV6ojmN2p/pFbc7gLczkRHR609o1oCHQCYzZhBJfY=;
 b=L9chiyb9fJ2wnDgBcDo1plzvYTQr+NNblsmtY1XkOKk4WsuAn/Sq5GCL+UYjWuJMTzVPGlkb2S2qU7biJS66hyNMZHJCibL6dOpU9DIbOBBaN44cC3UXszxYq46UzpgalFuMPNmdwy/uam8fQORXIm6qymdiHIVRrVxV0yn4kv3dN/QU6jyhiKDvHDEM7/IhULE/eDl467cwdq7KS+0nsaKDiqaq4Rbs4X+UP6xYIyWEWJZJjxQav2YMWwqC528OMmPFBfjqZ394YlnoIIZCFASFyNFMO9Y2ulphvuDbCGr8didpDpQ2+6YU/WOkYe3w9QhGM5Aj/6vddJllZ4PyNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SN7PR12MB7131.namprd12.prod.outlook.com (2603:10b6:806:2a3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 27 Oct
 2023 12:28:38 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2%7]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 12:28:38 +0000
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
Subject: [PATCH v18 08/20] nvme-tcp: Deal with netdevice DOWN events
Date: Fri, 27 Oct 2023 12:27:43 +0000
Message-Id: <20231027122755.205334-9-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027122755.205334-1-aaptel@nvidia.com>
References: <20231027122755.205334-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0147.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::8) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SN7PR12MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: fb2305f7-7fe8-44d8-49f8-08dbd6e83f53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NeXFoJ/ig5x0tzxYOxDJbWUao0j6/rx1x/gGz8DxKvrvlCoMyjSpNpafurUS5h9FkSVkg/MinDvd8a8m0hreatENd2JLDQjs5h2UhNl3SdFZJYYdIZojcd2gowCbohLDn9s7O0VNJevUK3a5WGQl9vspCSrjYCqsbsAl9dkl65AGtYZK5FRi72vCNepM8owIW7CZUE56lYVP4lfJb/C8plJvY6VCY6avPhuR5U1vaa9W9gr9HSD8GtbhtZ8imtGKNATec0QDEo+G7+9Vy/4dsLodNqlYz7l8K9/9TKVMMkZj0vfmPd8smZYdUnm+eROFuXhThS0XmkDF3Rn57M6ONg2Tf5ARtLSAjkNOXxhYOWPTZw4bFqystQ0HKNQNhhqU+bxSgyAne6SIE/gsgPSKsOodF9gAbB/L72SW/UVenV1uSJesDKe1X5r98MS9HQWQI+vioVhr64nHBBh9X8vyCzpWCEQIA8ImoqqJW4uqJQNOZTaQsVnh05nOpbdEUEtGjzgpjMEZyhGk1U3BQY28fI/u7+N6tDMPxvjRir7TlQDKeuzivh6Nthw3vCup2api
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(366004)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(7416002)(8676002)(66946007)(66476007)(316002)(6486002)(66556008)(6666004)(107886003)(8936002)(2906002)(478600001)(6506007)(5660300002)(83380400001)(1076003)(38100700002)(2616005)(6512007)(86362001)(36756003)(41300700001)(4326008)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sUbjWoDsyGrLOixLbd6xw6sKCszxLmi8MxfwFM3odrZ0a8zJ/+vGeOSP91A/?=
 =?us-ascii?Q?gsiIAKTtylMfXGt3WMonB/bu0vJQBn9ivPrxXgN/4U44zALPyOdNf3n24WDA?=
 =?us-ascii?Q?YIaDrt5txTthz6InuMO1eiB1NlpsNRAGddJQAT9QOcyAkgCoJOOVT207feN6?=
 =?us-ascii?Q?haTQlZct1z1Tj9S7c1eYvmu8KGew2RHripI7hnl0MPZJVd61IeHua9m9gmkC?=
 =?us-ascii?Q?1ur9BYRb3Vdo0O2kyaQxvC868Y87t08ZWX8VuJmKr8viOcBFlZTsby6pTqxt?=
 =?us-ascii?Q?87sGYqp4Ta7VCD+l0dP4ChtP3FDTY6kmJbRtnqUpsqWOMWFMoPaeafo+n/6l?=
 =?us-ascii?Q?ZJIW09zq2kY84A+D9kiEU9lKlBbNwB5Rt6RXRs//bVqT7l7HoMzf0nILbVZN?=
 =?us-ascii?Q?BlFpWcggyLtjTHiwvl9lglml5Hatjer4I/A35UHiqgrhDGzZ/YF5NFwz3oIP?=
 =?us-ascii?Q?BzFA1MOCV7N++OUXVZqVUaX2nhVn9pg828TYicPEz2M0CDKAXD2jI82S5p96?=
 =?us-ascii?Q?qnnZ3bTeLH3jynT+yWWFXcRZYl9cQETJ2BEsBdQgPNIJr1NYvF+pUtik4nZA?=
 =?us-ascii?Q?gbS4ZZ3x8MmmUdjZXhFFF1eWiSt5dLvTVMCulj/8mNF9lsgro/IchTLhsicO?=
 =?us-ascii?Q?/tuAI5+5P8qbNj5QSq3ukK980SjXvhNoLT1XLmjirxNE/yr2Nn5iDaAzmNaR?=
 =?us-ascii?Q?R1lmSr6/unZRniJkhvxLyQ8ofYpGy7VLTs9+EhXhP2i6NEWET17axwzytKOW?=
 =?us-ascii?Q?fvNi2pIbM3C0pgmJ6yvy++Qrjg4+s7YqPy76zDu0GswY0e5/Z5Y4sNuKN1kc?=
 =?us-ascii?Q?UciULpFVH739Yu2TDP4VLaLK5QtvdLOl96It7FlKJZJAvMZ+NY9tyrk3vWIB?=
 =?us-ascii?Q?i786AJC4tX5LfpUXy3tpnSJNzSOZ651LsiaXYYFba5U8yhSP8SeRK9cQmZLu?=
 =?us-ascii?Q?lSngmK5YWwt++HnmynDdiueSrVxq8DUyGtttAeuCcEiK01ElVeScBPmb+yrj?=
 =?us-ascii?Q?g/mA88T8s+BW1O4A8z1YAyLea1ZQkh1NUbHGQ2ti9vgJH8arVkgdkbtOKejU?=
 =?us-ascii?Q?KLbKG9Bn20CHUk/jHiZDL9aj/iKPpaOldwLm7/8PzQj9r34edSSsRsHMefSI?=
 =?us-ascii?Q?6DuUknC+aDq2eIbl4Jv8Z6UcZ2sF3bWdCpUNfA/Bl9mOQxpvztHoi4ayPjai?=
 =?us-ascii?Q?z7kbGpvkYAVfee0BKP0igdqdQfpVWcyXgeQbxAkI6hEBno24CHMQcG/z5Ncz?=
 =?us-ascii?Q?4p6Et4qwM0XMqAGwwwQZwmC7xJAKKD19j/d1vYAncItlXNQbQU5e0F+UQOOX?=
 =?us-ascii?Q?U2asD7PjFDxwWZlfA7KaLHdlmzklVLRVVIe9KbUBeU+ztWj+JA2XJDroNsxz?=
 =?us-ascii?Q?YhqevY6AtmL9QAxpqgxhtFHZz3d+lr22yCA6vb6c6qPlWDXx2yd6ONK9zDNJ?=
 =?us-ascii?Q?qTLRxtt4Ognez49X1PUv+gYRXJunviUODbITwx865QZ89zD9OoWG5EDAoiHH?=
 =?us-ascii?Q?2W2f5oa7+pTy9UeDgcnngBN9YwpoVyUySjgMAeKqSh5CAzkOIdEppAE2oLfK?=
 =?us-ascii?Q?+TAHWVrC+F9le7+MWI6RdkhE3iFtgBAv3BeaMIuO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb2305f7-7fe8-44d8-49f8-08dbd6e83f53
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 12:28:38.8517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6SSgGsfCkotlrw8dB5Y7SM2gilTz6wx/z2bBRC166uX0Mm9PGuRMP/tCclV1eeoNP8gNJUksLI2YSrBEN4M4Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7131

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
index 5c20f53b8002..ef99065e59b6 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -216,6 +216,7 @@ struct nvme_tcp_ctrl {
 
 static LIST_HEAD(nvme_tcp_ctrl_list);
 static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
+static struct notifier_block nvme_tcp_netdevice_nb;
 static struct workqueue_struct *nvme_tcp_wq;
 static const struct blk_mq_ops nvme_tcp_mq_ops;
 static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
@@ -3021,6 +3022,32 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
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
@@ -3035,6 +3062,8 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 
 static int __init nvme_tcp_init_module(void)
 {
+	int ret;
+
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_hdr) != 8);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) != 72);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_data_pdu) != 24);
@@ -3049,8 +3078,19 @@ static int __init nvme_tcp_init_module(void)
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
@@ -3058,6 +3098,7 @@ static void __exit nvme_tcp_cleanup_module(void)
 	struct nvme_tcp_ctrl *ctrl;
 
 	nvmf_unregister_transport(&nvme_tcp_transport);
+	unregister_netdevice_notifier(&nvme_tcp_netdevice_nb);
 
 	mutex_lock(&nvme_tcp_ctrl_mutex);
 	list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list)
-- 
2.34.1


