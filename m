Return-Path: <netdev+bounces-16192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C63CC74BB89
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 05:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A5B2819AE
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 03:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0C71389;
	Sat,  8 Jul 2023 03:15:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6D67E2
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 03:15:03 +0000 (UTC)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9DF19A5
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 20:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688786101; x=1720322101;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MO9zHqtEJSOy1QnzmMEbn53Kz5WBsnoOv7sSozaWsL0=;
  b=P6CzlSphQexoCEEPGLz2oZQ/MwEnzE7Kll0LGOeH4CMhFOlZJcN0qm9Y
   QD2pmD6Ej7WmQp4qRUwsCh5vYUhB6Zru0byeesGN6pshyWnvO0MR6hsSQ
   Ee6Es3VJYrK8QDw5aK6o06oz0o+NZ0VgGybjDzotBK0tEYYeBZ62ibKAl
   Njhpb0hS50eyP9/EKREhhbvU6SZ9C7X9E2tUj3/aZOwvvDjWQl0kI1/Go
   E9RhkB9wCSXCyMlcCJ2ebT0Mzobyke8fIOa05uFT53LDzCC2GV56RFD+s
   jgAyUp1ErVW0/EYZJwxpPhUJsF2HeDmso8KvTa6ztb4eD+YfMbEov3MA6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="364062783"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="364062783"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 20:15:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="966818969"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="966818969"
Received: from dpdk-jf-ntb-v2.sh.intel.com ([10.67.119.19])
  by fmsmga006.fm.intel.com with ESMTP; 07 Jul 2023 20:14:56 -0700
From: Junfeng Guo <junfeng.guo@intel.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com,
	pkaligineedi@google.com,
	shailend@google.com,
	haiyue.wang@intel.com,
	kuba@kernel.org,
	awogbemila@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	yangchun@google.com,
	edumazet@google.com,
	sagis@google.com,
	willemb@google.com,
	lrizzo@google.com,
	michal.kubiak@intel.com,
	Junfeng Guo <junfeng.guo@intel.com>,
	csully@google.com
Subject: [PATCH net v2] gve: unify driver name usage
Date: Sat,  8 Jul 2023 11:14:51 +0800
Message-Id: <20230708031451.461738-1-junfeng.guo@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230707103710.3946651-1-junfeng.guo@intel.com>
References: <20230707103710.3946651-1-junfeng.guo@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Current codebase contained the usage of two different names for this
driver (i.e., `gvnic` and `gve`), which is quite unfriendly for users
to use, especially when trying to bind or unbind the driver manually.
The corresponding kernel module is registered with the name of `gve`.
It's more reasonable to align the name of the driver with the module.

Fixes: 893ce44df565 ("gve: Add basic driver framework for Compute Engine Virtual NIC")
Cc: csully@google.com
Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
---
v2:
- Remove un-related variable name chang, just keep it as it is.
---
 drivers/net/ethernet/google/gve/gve.h         |  1 +
 drivers/net/ethernet/google/gve/gve_ethtool.c |  2 +-
 drivers/net/ethernet/google/gve/gve_main.c    | 11 ++++++-----
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 98eb78d98e9f..4b425bf71ede 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -964,5 +964,6 @@ void gve_handle_report_stats(struct gve_priv *priv);
 /* exported by ethtool.c */
 extern const struct ethtool_ops gve_ethtool_ops;
 /* needed by ethtool */
+extern char gve_driver_name[];
 extern const char gve_version_str[];
 #endif /* _GVE_H_ */
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index 50162ec9424d..233e5946905e 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -15,7 +15,7 @@ static void gve_get_drvinfo(struct net_device *netdev,
 {
 	struct gve_priv *priv = netdev_priv(netdev);
 
-	strscpy(info->driver, "gve", sizeof(info->driver));
+	strscpy(info->driver, gve_driver_name, sizeof(info->driver));
 	strscpy(info->version, gve_version_str, sizeof(info->version));
 	strscpy(info->bus_info, pci_name(priv->pdev), sizeof(info->bus_info));
 }
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 8fb70db63b8b..e6f1711d9be0 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -33,6 +33,7 @@
 #define MIN_TX_TIMEOUT_GAP (1000 * 10)
 #define DQO_TX_MAX	0x3FFFF
 
+char gve_driver_name[] = "gve";
 const char gve_version_str[] = GVE_VERSION;
 static const char gve_version_prefix[] = GVE_VERSION_PREFIX;
 
@@ -2200,7 +2201,7 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err)
 		return err;
 
-	err = pci_request_regions(pdev, "gvnic-cfg");
+	err = pci_request_regions(pdev, gve_driver_name);
 	if (err)
 		goto abort_with_enabled;
 
@@ -2393,8 +2394,8 @@ static const struct pci_device_id gve_id_table[] = {
 	{ }
 };
 
-static struct pci_driver gvnic_driver = {
-	.name		= "gvnic",
+static struct pci_driver gve_driver = {
+	.name		= gve_driver_name,
 	.id_table	= gve_id_table,
 	.probe		= gve_probe,
 	.remove		= gve_remove,
@@ -2405,10 +2406,10 @@ static struct pci_driver gvnic_driver = {
 #endif
 };
 
-module_pci_driver(gvnic_driver);
+module_pci_driver(gve_driver);
 
 MODULE_DEVICE_TABLE(pci, gve_id_table);
 MODULE_AUTHOR("Google, Inc.");
-MODULE_DESCRIPTION("gVNIC Driver");
+MODULE_DESCRIPTION("Google Virtual NIC Driver");
 MODULE_LICENSE("Dual MIT/GPL");
 MODULE_VERSION(GVE_VERSION);
-- 
2.25.1


