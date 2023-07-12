Return-Path: <netdev+bounces-17243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D04ED750E3D
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 18:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B4801C211D9
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 16:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50D714F63;
	Wed, 12 Jul 2023 16:19:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26AD20F92
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 16:19:23 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2060c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e83::60c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FBD3AB7
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 09:18:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6Mr+KF6zr8i6DNkoh/tNxSk2AnMkP2bVrgv+HVFfkqaMZh5txownl+PJKHORRnRPjCAL2RepMXe5JkG2TkKSqfZ15ny05Y5Mq09avShMYodX2C/HGYrNg+Zekg3CUmYKRYnU6jK8m/lf37gqMkjX2W5WoA2MuAckU6mpZZXOaTNkFvWJO7UJ/l2CPtNhhQBYfrTwAKVyP3mFEwSOPdIYAYNzYsatI1Z0s/9N2IfT6BaZmtzpwxFiZY7PBPuOyZihs96KtYPbOe7jGTdMu4Rr8MDGyqTcP3V/x9YZ7hX+cTYq9Rh4Kb4N7bDVVpe9E84NGfybSaFZkjMt8J2RCGx3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRTpf4/70ADevzT+wNVGlY+MHuQFzzXYaiezpYEqrqE=;
 b=Ab1MZg9RQWAjasyR84PLL5dZ7APkj/bkcf0ioXAh0MV2ljaaSkCR13BFhNt+tzTG8PnpynXtLgEkZOtR40vrUPkbQ32An5xAp6svdmUrrFRJS0P96XNV4OXqaqtSrDdSWBoKFbdZ+iqi1hAe914FjXZp3L1S/pD+hVGEHBK90sVPn38PZCSHMijYmlZ1hrPrUmTuv2GUX7+YDrRnI8MrTsYn3XZxuhVadnyfmkXurjOi7MtKQWdyh5H7WKr+PhJwHdlaVUFyCmE0Iar6XRwERQIzm5sA2HWiyLaApjFqtoA8pd2NAio5OuVt1Au/1pXChBuwo1Cme7tDUCu7KfcM1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRTpf4/70ADevzT+wNVGlY+MHuQFzzXYaiezpYEqrqE=;
 b=WBJ4lFipA/WoSk3iYp2iOZJvRHBKkie026IGN2fvyAdx2SLgm1sIOcFCl1QpbIRf9PIbfRjy1zLSsAb7XzQt1pZTRYTN7A/0+4tlvp/PnCVdm4BDnws8jlRaYAD3FgmQd8Xes0G4hmyZgfBcv3C4Wv2esrr8BF3/9SexoL4N7gS/F3HM5S4ECWt9IwhF8grOMyshJCJrWKtLzeLYpBebjYezipnsugDCcHK0W8ssZffKwC+RUF/4Ilgr+dwhN/ZkaOM24vccoQ601YHmOq2UMFDwDDY0SJeU+rl6o8gIF90OMdk/GfIgn8yGiMSGFyi8KR8nO1yJB1SkdBEumoFBOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH7PR12MB7212.namprd12.prod.outlook.com (2603:10b6:510:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 16:17:24 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3f6a:7977:dcd4:9ad1]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3f6a:7977:dcd4:9ad1%4]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 16:17:24 +0000
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
Subject: [PATCH v12 10/26] nvme-tcp: Deal with netdevice DOWN events
Date: Wed, 12 Jul 2023 16:14:57 +0000
Message-Id: <20230712161513.134860-11-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712161513.134860-1-aaptel@nvidia.com>
References: <20230712161513.134860-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0072.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::25) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH7PR12MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: ef8b7a81-2ae7-49c5-61d9-08db82f37a1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BmX2jHowyrtpkeLGg3tkq0Zgk48SxeNI+tlxtpSYTpKxrq30L3s/IOwvUaCPpezutBH7RJ0Ci//bqxHQgAt7M5H1smczbFEhAFWRp11SXsVvcr1IMnACKELZsCDOR80T5Pi/EK15QATAVBUDUQkCkEpUVoVYcS8tC4wglaKlg5vA8OPUh8OJQ20+qD8xYMULhJYNMJmIMdHiIKlxrr4DutAub/kM0JXgKXcUUGWzUFjXqwO2x10875kZJrLhVwUJq4T/Tp4k+r3vQ1rXNkHpVTv8Ef0xCbIiGzhHUIB+DP5t668M0TMZ13PcdgbizWv9w25nA9yIx+ri4XCs3LtCCpVyRcDcn1vpgJpAN2YeZxhIECWSafR0ETYFSANJmc7YtrXo90MxsX7A6dJSYkVUyDrkeUJv8Li52dZWfmxWjVaI7Uiaohq8rdkEKK03TllAqlWoza3QjP9iCT0Oc2alu3R1pTvc7hcysib8NiTzFuZRyWIxMvXYW+kglqOl2mi9gud6uUtqcTWICp9jPAGiKunLK2zjVsMWB5r54925vPX7T3K6z6zMcynjdWILwcRZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199021)(186003)(2616005)(86362001)(66476007)(66946007)(66556008)(316002)(83380400001)(107886003)(4326008)(6512007)(1076003)(26005)(6506007)(478600001)(2906002)(6486002)(36756003)(6666004)(38100700002)(41300700001)(7416002)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tqHbt2l2zfkDhyQ6H2JYIijbBC01R66BadseCl//Mx/GfUq/cFxW6J7/gCj5?=
 =?us-ascii?Q?n9f9IAnk4MTGxPnOmM1NG/2PaJcZQTtcbSktcb2qQzZu8eJZBYWnP4LVMeZo?=
 =?us-ascii?Q?Stmj35Ijr8w5GUVMWNBCgoz9aBFrLAhwGNVga6pYn04bug/+yT5t+7tHIbmk?=
 =?us-ascii?Q?+YULwzalKPAJquAevidHU3F15durAZI3yb5uk7yq/nIynZqKYpSYlDt4Tt82?=
 =?us-ascii?Q?z0OE4I8bz6FZmMb0tILWL3dRDh+tjqr0VzoLTF1e6nUfpAkrEx0f4QQpU4hm?=
 =?us-ascii?Q?8srmmwUbj+ko/LbiC3+LCU4mPbrRVzHhLD4dl0dQ2vdcvb5C8T2Z8oCBnmbz?=
 =?us-ascii?Q?HZ8vhcnWkzBhYy6XwTIzqnjwh9VJWOv1RxaF77/YIDndpANpRbNyz2QUplT0?=
 =?us-ascii?Q?ySUVKIsYYNl03yDq+FHMUiFwCgsSe7ItqCSFKq3vdMEiKDR7q0NHQWG+AGuA?=
 =?us-ascii?Q?M5dzYR1X1qVElhaul1Zg+6nIx+AxaMirhuk2vub71wtAp0OkOVfP/XTxWzQc?=
 =?us-ascii?Q?H6imnISzEeDYWcp76U7TyomGNtZdPipGUZdk2WV5syU+ML4d7HSQEzGjcIdD?=
 =?us-ascii?Q?o48+haTKiceDosbT7Szd7YAhg8uwxA59JKDnsD6uaZ5AssFrbaiLCsT+LYux?=
 =?us-ascii?Q?mFfN0PZuIZkWQE8+ufKWbnZLVpQ7XgoNxdnbT8GwbR/1IUtclCkc4RpcZ136?=
 =?us-ascii?Q?k6mL5Gul/2P2eZl3LRaVMKGwo/kdulJlbaLJF7Ah5Wm1BeIDIBBobnVZZh0P?=
 =?us-ascii?Q?7xJpTMxGJCg9Wa9uWmLNx1lSAAyjFksOqFF4RQ7TtT0NDJ0nDnnBRrfwFz1W?=
 =?us-ascii?Q?FZ+zVd2p+YENQDDE/SJ4VZw4t7/nPMctSYnDS3iyNOkFYHgFoRrzDAt6OSOx?=
 =?us-ascii?Q?PiZNmxl55Xrm25HvOYYfE9kGtUTvk/zfHD5YJAsxIutSGHTSQHKbjqSEIlJp?=
 =?us-ascii?Q?eycEbT5X1dHmh6JZ35+l1R56rKIEZutkmA1Ov95x4cNTCuA9SA3VebBo+Okn?=
 =?us-ascii?Q?heRZjFhHdcHrQIufF3lJQKop9BjGYLp9m+UhD1RqX2tRzAQlm+sWxkK+Rtqm?=
 =?us-ascii?Q?446LsOtIqt3qMnNXhrOT0E61+JkuQGhZ13mTauOi+A5+dUsHpZtaGtJiusbm?=
 =?us-ascii?Q?d37rFxI05n0UyxUS3YlQ5ZeNILj4ExfiZXlPX0IaX1+NOfdbX95eKBgRnKT+?=
 =?us-ascii?Q?PF8vI40aQ7CQeoLfvajso5X2s+waceSSkOOskxpIZA3mW4TCLmzAAnhj2n0M?=
 =?us-ascii?Q?N4Iyku2Fvg5NT5ZVBxvuYsbz0kIjqRJNiSgVijrmnNIuGz1Ur6TWHT8n9UHY?=
 =?us-ascii?Q?bT0PyQs6qnwYHmGIkS+6iut950w07lmuMI/Y3Xit+mbEZjGyyk7PbV5AeVf6?=
 =?us-ascii?Q?rxDZIjkIXcraOEiT/tj4JUR8iQF8OFialTui67FSGytTqrgYt7Y1aZcUBPEv?=
 =?us-ascii?Q?/+nFKoXVrJJAThRPQnamM5I9YbIrTbrkFlOEgkcD6CiGmPKKRfLNBuOn26w9?=
 =?us-ascii?Q?+PXmRxaHtCFXufiiunqolk3kXUps9X60ZEIUIsE8GT4iNd5VdPIsIyWgYYWg?=
 =?us-ascii?Q?MkUcEpsewN2ftwrTGcfIcLafj7H8djn7i/sYJHdv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8b7a81-2ae7-49c5-61d9-08db82f37a1d
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 16:17:24.1975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zg3fIKP3yhvUTesCIDH5ebgTnGorIMFs+dRMXiCNEs93dpirwC9o1SuRLM60zU2tyTc11BSeJJ9uwCm/F3VFQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7212
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
---
 drivers/nvme/host/tcp.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index df58668cbad6..e68e5da3df76 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -221,6 +221,7 @@ struct nvme_tcp_ctrl {
 
 static LIST_HEAD(nvme_tcp_ctrl_list);
 static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
+static struct notifier_block nvme_tcp_netdevice_nb;
 static struct workqueue_struct *nvme_tcp_wq;
 static const struct blk_mq_ops nvme_tcp_mq_ops;
 static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
@@ -3234,6 +3235,30 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 	return ERR_PTR(ret);
 }
 
+static int nvme_tcp_netdev_event(struct notifier_block *this,
+				 unsigned long event, void *ptr)
+{
+	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
+	struct nvme_tcp_ctrl *ctrl;
+
+	switch (event) {
+	case NETDEV_GOING_DOWN:
+		mutex_lock(&nvme_tcp_ctrl_mutex);
+		list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list) {
+			if (ndev == ctrl->offloading_netdev)
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
+	return NOTIFY_DONE;
+}
+
 static struct nvmf_transport_ops nvme_tcp_transport = {
 	.name		= "tcp",
 	.module		= THIS_MODULE,
@@ -3248,6 +3273,8 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 
 static int __init nvme_tcp_init_module(void)
 {
+	int ret;
+
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_hdr) != 8);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) != 72);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_data_pdu) != 24);
@@ -3262,8 +3289,19 @@ static int __init nvme_tcp_init_module(void)
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
@@ -3271,6 +3309,7 @@ static void __exit nvme_tcp_cleanup_module(void)
 	struct nvme_tcp_ctrl *ctrl;
 
 	nvmf_unregister_transport(&nvme_tcp_transport);
+	unregister_netdevice_notifier(&nvme_tcp_netdevice_nb);
 
 	mutex_lock(&nvme_tcp_ctrl_mutex);
 	list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list)
-- 
2.34.1


