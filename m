Return-Path: <netdev+bounces-32250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA014793B6A
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 13:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A1CC2812C9
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 11:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CD91078B;
	Wed,  6 Sep 2023 11:33:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E847510787
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 11:33:04 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0D419B2
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 04:32:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwbUTRzmD6yVHCn0Q7WgoKFqTMR4JnWh54fm57uvGZTVpDUDUlHR/H1LhDdEdt/mJxhPKJ6BbTnZs2EevY1s78c4YnHmsGrB7VKbpST0eC6weX/wKrLSYKkg2loL7i156Iu+o70YhfM+EPCER4ymLcvCdUcIrSwNm3Jz9kjpbFi7ZjnLRS52XecMl1aSj0AS61yqctTluyKkfBLUKJKrBNhzFu9fzK+6yIjzbfM/LifIw2mPeP67Ix2hzYjhTS+v7U/qhjQo+BLnC0mD/3LABm0PcVItaJsdIbNoS6xXSDQ1CmhLfUEew51TMJJMpPmMUDWjjLjTFA+xExfOrJs4JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SeRurJDyKfEy7JoaTW7sxb2/1v75sWjYNEQ6Kye2qs=;
 b=e0BCEzTkGD7TDqvWdNr0N5dzkB+ECoJtmsMzhfE039lCw8yfhn6tNdIijyQ3F0m9uMAlo3aEWaXfWs+wX4eTXHHGEA1WRYMJnxiXF9mqz3cApHsKzFdYXgrq5BJviC7YWR2wK7bJ5O7hYPY5OeHsczXDBdtJppbYhJHZw+f/s1D5fMu9BoHMK1WNJZxY20AB7ayy8GM3hyWwLhjXrY7MC288TGLUQRNJiN0pktLNJ+WOhzJuwrj7cAxWGX9dE66Foh+yyV/eUtrOWa0LVgOdldrgDd+/wBBMccU+bajIyR4PFSYTQ0rSgezdw2XVDWTBTObK7XBvcguXgAHs/ghBoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SeRurJDyKfEy7JoaTW7sxb2/1v75sWjYNEQ6Kye2qs=;
 b=sp21pXRicAvnYq5h70m8gM6iKk6QX9m55wOB6d8UZHLTHrr90X0fXRcbP5K8w2VrQfFuRX+kzekT7kI+4isrcJQkpAff2pKwO0e6B/L9d6ReBjKGef3v+59ty3p/eTqMfb1XWJSwXubctfIWJC61+pyCx4isXYRnPDUn+vvnzsrj+BbH22E/YUCj8+lpwIvuVjboNOsoN5Pj7EqRK8qb+G57nGNngPIzb/AkqbWpngyhTHGmnBmeEKemVjRyjr8X6RSKgwv8TAMzA2sCAfVr09opW44KAvN86NLcuJxUuTgt/z4891KmTTQ/AVZdBuKPzTgRm9TYzmUwT2FJ87yV7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DM4PR12MB6325.namprd12.prod.outlook.com (2603:10b6:8:a4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 11:31:25 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 11:31:25 +0000
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
Subject: [PATCH v14 08/20] nvme-tcp: Deal with netdevice DOWN events
Date: Wed,  6 Sep 2023 11:30:06 +0000
Message-Id: <20230906113018.2856-9-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906113018.2856-1-aaptel@nvidia.com>
References: <20230906113018.2856-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::19) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DM4PR12MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: c65813c5-dc38-4443-21cc-08dbaecccdbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tgwUttzv7dZCcfN55HBRsQ6A4OUz9JCoDLTMahxGgC8N45Y/mUdlOpd+F0uVcK+kRaOC/pu9drqZ/dQnHrfF9283iBYZG6aoEO6xDIWuWnmyuvQNX6oTO9CkqXoKFwnb99K8PllzESz/PQ0Y6A40mag6G7AKn9WwMn0fhC7tLjNwJomTxK2x1MC56a9RxdW/adKmZL4GylPj/fQ3ijau8n7Bu0C0cf6HIfFLnu5UI+z5pQjghnoezyYPWWQ6M6IwgIdkTPIAQfYKjGgIALITAvxJYvCWuhLBuF+Rf9BYTVbfq5mpOxzzN3XH8SfZr4aPBYTUrPWLtbH0E3PyNUhQUZRXOurexwTMGKzVoFc/2apexQWQWoYOGEobgi3VdUBsLrjToBwMRQyrNwf3sJt/1zr9m1/w5geSIZGVqzgM9ijqFh3nxIFyFtT/VFNz1q+O2WPhUikKJ2KUemR1V59aonzIrTPiQwaHpNNWxnLVaR6I38mTiQmFKQvs2BSRgYncHXcxhECdozoLrkSlLMrB0shxByPXyGAgOUcH9aD8DP1x1ftWMvjR0qxDTJSvkAgc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(376002)(396003)(1800799009)(186009)(451199024)(6486002)(6666004)(6506007)(36756003)(86362001)(38100700002)(107886003)(1076003)(2616005)(2906002)(26005)(6512007)(83380400001)(478600001)(41300700001)(8936002)(8676002)(4326008)(5660300002)(7416002)(316002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mZv53ZedYHV2kBrjBSK2w7yq4yfuXICoUvjjNPkKJuBF+SMO4iolN2L7qO6m?=
 =?us-ascii?Q?JXlptwJey5ZZAsGmL+8EzsNiUw7Sfrjixi9X1pVIw7jsYBmATxitqA8Lwxf6?=
 =?us-ascii?Q?OQdKlR8l19UOpzU82aD1qHfQjs++SRmiVoiJRZ65WXmYqN4PxlXKBxrkLu6q?=
 =?us-ascii?Q?u8NwI6tEzYyXSYNNK0Cuk77qEdxAwsZRR9RVeiOkjPqkR5bNsAXJErU/Oev5?=
 =?us-ascii?Q?XEWZC0BQyCToDVmYZrUNtRCkUl+j+jCSFw7r33ufvI8H8Uv38hsMLMTHKEOF?=
 =?us-ascii?Q?PcFbE1e7S3DzYeuBJUZ/0eFLvoPXgig7Hnmj1s/i9973h5DWJlhvvB27PNlo?=
 =?us-ascii?Q?+2YOInhutQlA4neW7Li83u6EnB0MXOqpVDW7kWH7PujQGk7H6G7pKXmL4pUF?=
 =?us-ascii?Q?qIKBfv8kRctws+XD4mTt9A+tjxklSL9M/PAPyaIVzWBhVQmI7/XlXfSWGWoR?=
 =?us-ascii?Q?BLXRp4K7jIkdDoOGw/m/a+wLJLqtql80hd5gGugqa+semdg4WmFOSzwGz7K5?=
 =?us-ascii?Q?sRCAhXTlCpJAJTEQ4RYLfeIqMLQEGVjhPMLplyBotWu6PSKGV8oRilTK16gF?=
 =?us-ascii?Q?XyvEDKi9W9tYSRxcnK6kAHikLg88thDB3xYpTFbKrwocKVnbLKuXvhUD7sgl?=
 =?us-ascii?Q?m3nhqCA77+fGnAulzIInCLokTtKMlnP8yiqLRJy7pvHtnDeZCd3yxSQ9NvOh?=
 =?us-ascii?Q?JOr7iGDoFbIaZc55WID4hdFF1kfZHDqOWVe+UyXuSlCZnYqaA9lflSGas1hp?=
 =?us-ascii?Q?wIn+DISx4p4QUUNKdM7S1L9hu+G/osXqVTRg/jiB9ghUUkg+ZXU4jOvyaShb?=
 =?us-ascii?Q?kJrHLW/HGTr9Xvwra8OxmtigB/Rl1oCDfRkmjyZryagrLGw8XytoSfZvVFju?=
 =?us-ascii?Q?vxkkyKrHq8j+dVGCtgt4kfJ2JnV/bx2jrTdACInv6PJ1iVKTJMnKLu9mfdiR?=
 =?us-ascii?Q?LV2MF5QVo+5u20rFlKd7DZQLTzwzU42I11p99H2aHD7wSedM7gpa56I8d4iH?=
 =?us-ascii?Q?BLIqUrPgGrIPSA4i732UkdsQra9vVYZ5+aVWVwnLQRfxEGwBxJKXUsUKD05a?=
 =?us-ascii?Q?tfv2g0lI/AVOZBOh52MCmeRHnjJX6Jx1bHt2+qx+Z36ZNb+qUTAlb2PUraNL?=
 =?us-ascii?Q?WnydhrxPt2nY0z8RggRhTs1Am7TiMdG5XKGZWX/W/uZt9CqZdTSJbvZPWc1H?=
 =?us-ascii?Q?+5aKra8GSJBF3n0i25DzHJSTfTVGGOAFfDAwt/L0IFbVytgYKQsx31f8ge/J?=
 =?us-ascii?Q?r8TtK8abn6aII9X4LCzN5YI1qYwuL3QaNjhin+hR9DrKnlMBM+8DlDgcP1Yc?=
 =?us-ascii?Q?q1q34TX9Qu27wRiAFSJ3wow9E960j0SmNwrrF+DAjP0tK75929U4jpJRMHb1?=
 =?us-ascii?Q?eT+fIgOn0yBMo/LqKpJusSaZYl5Jd81n2gEMrI1SOThiebT48Qf/CSdIVX8j?=
 =?us-ascii?Q?vNS+zi3HaSlM/2VDN1dbxlYUHIzI1v1DQ1IUddV4BS1yUxAWNJdfCSO/WRQJ?=
 =?us-ascii?Q?gxLdGGJ49rRyw/nO71vonbm8Fh7Iu2nDzbs81zkOhLyigvBoUADldy/F8jFt?=
 =?us-ascii?Q?wdQLmKq13QaT4dXpn8+MTGu3cx9x6kzAYIeAGvEj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c65813c5-dc38-4443-21cc-08dbaecccdbf
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 11:31:25.2844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B86qcdRzbqZJM+pB9YJ1CKQmmgMKeq5fItxHAOWYvc8ewTyavXkOk2d1omZcKPpCjOChzZ4OTiLFsNT+WcWMAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6325
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
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
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 6c7edbb78354..7f2e92d07fa3 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -216,6 +216,7 @@ struct nvme_tcp_ctrl {
 
 static LIST_HEAD(nvme_tcp_ctrl_list);
 static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
+static struct notifier_block nvme_tcp_netdevice_nb;
 static struct workqueue_struct *nvme_tcp_wq;
 static const struct blk_mq_ops nvme_tcp_mq_ops;
 static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
@@ -2996,6 +2997,32 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
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
@@ -3010,6 +3037,8 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 
 static int __init nvme_tcp_init_module(void)
 {
+	int ret;
+
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_hdr) != 8);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) != 72);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_data_pdu) != 24);
@@ -3024,8 +3053,19 @@ static int __init nvme_tcp_init_module(void)
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
@@ -3033,6 +3073,7 @@ static void __exit nvme_tcp_cleanup_module(void)
 	struct nvme_tcp_ctrl *ctrl;
 
 	nvmf_unregister_transport(&nvme_tcp_transport);
+	unregister_netdevice_notifier(&nvme_tcp_netdevice_nb);
 
 	mutex_lock(&nvme_tcp_ctrl_mutex);
 	list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list)
-- 
2.34.1


