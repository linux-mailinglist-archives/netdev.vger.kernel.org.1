Return-Path: <netdev+bounces-36857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A967B208E
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 17:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 355EDB20BBF
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 15:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405D34C85C;
	Thu, 28 Sep 2023 15:10:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9DC4BDD8
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 15:10:24 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5929119D
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 08:10:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pd85EszZrqIgfQwETiiGkJdV3mBq4wd8bNAcTSr0zbYHdpCTOoqnViHk6BIHG9lE92px4wzW9uN76IsezHzdMbUn8SVo+zl5Arbal/ep+DzcxspMAi01nOVQELio/YZ5bAAbLSSJ1peXplcClzPZ4u4Ml14xct4qvlw/PzmQl5kX+UVZTUkfQ/6kddMDAOR3C8GjF5uUs//YXIh28Ao4Ostk8ezqIPJun8hGpkDP8kIh3Y6IaKaBtuUkgCZ0QEVntHvnAIe4I88DkdVbpKYR7PWKNf8j7VTOPTweutZ3/ER5HESQpkGxgocOv9knsHojoecqmBtYwVR23JaIxDHKyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqzcmgjxRU62Ume557natbjSfWWgXgIAVlI4dkGhZvc=;
 b=GWlcJxkAV2La6okVLy0hySOvK3LlMy+GtbLEJOGKpoUA+0IDln3GT8orN2IFCoiggxkpAe+gwakqbW1Dv3+tFyNZZYzrh/HfYNPQ722btExgsyfKEkmO8IdiqbLujwcAN35Yz5/AEf4M5NkkJ130nQ6i+55eWvfz7ankpu3Snb4gkzalzqwXHqHr4oayuh4m3vOyAnLG/9ky/tgFr4MIqHY3OBfR30sRivO1vdz7IHKc/4JWRpiIkCMn+8lrZg6FXhrORSL+jby606VqTDkG3NppdAdtRkmoy3/No9c4sYWmWgI2XR4g94vHK7ip57kcG9ZPlhV4aL67KHRSquzHuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqzcmgjxRU62Ume557natbjSfWWgXgIAVlI4dkGhZvc=;
 b=IbekDovpHNqeIaUfUBXN6O5hn9SDKJ4HGqLQd32AzozcBBR4CJ+6GuZWtIpnJY3GsZHew3hVllTr04rENi7SWJrIEBQql0GJEp03kXFF2qoQ2ORzpjZSXQIbiSAb6CTsbJ9ckaC8/iDqF/jkJAycXcdXxZaftibM2e2dtFun9YHJl5pAP5VLVcYxeZTUDi0qMOzJm5s3+zoKyakQX/QeRH6r6dbgQ5xYpT6tLkdkv5N4KyL4HEXi/CQ7hSTHieQU3IuVtb/SObqqkaaC4i57Iu3LYrOPDuXOGN0mmuS9Cmqh4jCGg0OnJP1zniZu1tBXsXCzNG+5djZgOWPuZL9dpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DM4PR12MB5359.namprd12.prod.outlook.com (2603:10b6:5:39e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 15:10:18 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1%4]) with mapi id 15.20.6838.016; Thu, 28 Sep 2023
 15:10:18 +0000
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
Cc: Aurelien Aptel <aaptel@nvidia.com>,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	edumazet@google.com,
	pabeni@redhat.com,
	imagedong@tencent.com
Subject: [PATCH v16 02/20] netlink: add new family to manage ULP_DDP enablement and stats
Date: Thu, 28 Sep 2023 15:09:36 +0000
Message-Id: <20230928150954.1684-3-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928150954.1684-1-aaptel@nvidia.com>
References: <20230928150954.1684-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0191.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::11) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DM4PR12MB5359:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a1866e4-bc6e-44ed-6a35-08dbc03506e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ASc4cY64AR5l3fmcrquufrMQTiBY7UJATDxUZ9/esSvSrVdll25tKJknlIYJ9e9B+I5X1yihqeDP6h89Oljz5Ch/w18tPL36roobW2JH33V/ZJ54prZHHVaTUIywURE2RMDLRAu18oVFG4lT1ILzKjRGzdsARUlw2jtxE6JwmjXNGKj5eBBk668CB75cl8mmst01/vSK4HHM5sldyXHReF4JZfEahfAuN6R9LeVpT8j00J/ZSHXLNjuba4hrPIlhVoIrjJKotCwo7xlgSuNqYYsaG5jYD3VIFtZEmj66yYPMVnPAcfdxIQODzbi4mzGA+WFVE7p+EjOHXhzBY8yAJfJfhlLYvWtPY2dr4yr0MEMr22/qasrmBfu6X3A8mVQy2IjqLkk4iNi4FZOrz3uWSujb7CPTCF3eqYkWemgenZTHO5H+U1eEKuEUwK75y6MH2u4+8rEAzuxnQeC+WXQrpEqFkdVYYiwIuQwMO+9Ctt+m/05VvRw/p7R6fPgy+anxw9Z9j1FCkVmyZs/185sJS2JMDSLu/T+woP51xeAeybPpyh+baZ2IqFEc7gOch+sLBMdJ2L4XhbqcltxUbJu/Dw6YudVOBe7d+YnVTer/sJ8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(366004)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(2906002)(86362001)(30864003)(6512007)(1076003)(2616005)(36756003)(478600001)(6666004)(6486002)(6506007)(38100700002)(83380400001)(26005)(7416002)(8676002)(8936002)(4326008)(5660300002)(66476007)(41300700001)(66556008)(66946007)(316002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AA2h2C+R2jN0k6SeE7ddDT3XAx+fjp+5QAkZTQQ/NoG5wFkQoxhm4+U7XLe7?=
 =?us-ascii?Q?7IzT4/CqVFaDgMhmrebe2tlBsIEjcr1FPWYeFiTzcl6HWpWgt9FpvLLV1rXl?=
 =?us-ascii?Q?sgXLvqQYx6qhtk8XEVZSA5r3m6pRhDJwpW9ZKO4JLqEowTBD9owTL6S/ZkNt?=
 =?us-ascii?Q?V2wzgBi9gCdxLBsmcsIxl253ZuBffDMOzPEazyO8pjqWhxSi3M3Sz1K5XFvH?=
 =?us-ascii?Q?54SWnp1noIb3PqKNqcZTpmJqcyJp+NFVOLlZOJnh7f/3hTQOQ0Tm2NSdQGK4?=
 =?us-ascii?Q?HFLYLqnulTBdCOtalZlPQC1TvOWOcxy6ncWEVbFiSxpM8jhQ+S/tD0/DuLjq?=
 =?us-ascii?Q?kpVGZBKMswpbfcxefAsCoDG9ip9y/qjRKfErW0AdJz4OMglnPxn9tYG0c7kS?=
 =?us-ascii?Q?WIXvgb+WvaeTj09zTbtBTXtyShwsdcN3zllZEBC1rdi8m1vn9pItA5yaAWti?=
 =?us-ascii?Q?jAnwx0FQDhjAFZh6nZmmEh/flX7k8ClhpEM+QjlWYqs7ED6HOTGa0N22rGAa?=
 =?us-ascii?Q?osP85Ru1arXdjgN8NgKdy+zxwZtYlQEqBPv2GT2WRIYxDDy6Sl94pUBzwBsf?=
 =?us-ascii?Q?rAi4yIdNXFPd+AsJw1gLRnAZk+t2W4vzdYx4+KQNoUZjziM/RIVZrn/Ahr4U?=
 =?us-ascii?Q?EclxhcJUkDxKxW8p+Dl72jOv1YNSPcWYIJiEj6D7fU/yp0saWv9oMPbpc6zT?=
 =?us-ascii?Q?6fGwtbFljQ80+Oqu3ws3MOGkRieZbBy2rRBFu5sOvzGmOOMffUo7KgRq2Mc8?=
 =?us-ascii?Q?NNaU+QTB59D4UvS8DCvLPTsdcVlQGWl/ZufncDkTNIYArvwp54NSJ38q0zQ/?=
 =?us-ascii?Q?7LJQM1R5CYlUL5XTcHJT9Vfd9d4qea+faT0lcK0ZcBTAI23FK1W4R+imILOP?=
 =?us-ascii?Q?Mrf7i9DXXUiOEAPxtLo192LcYurK+8JrOCs68a5AR5tW135FVGRoxA/XWi18?=
 =?us-ascii?Q?KcHHq0TvdrWNY6Xo7n8AXlky8K38/RoopvCKOlPTaiPjZN9Z8Ci26GomuwgR?=
 =?us-ascii?Q?IaI1lOVs9+IngoMQVOmDPwPiDZH19jWIU6+FzhnvxGE88G2yNjNZddQPhjg+?=
 =?us-ascii?Q?qN8zsZV5qZ5j9Oj1l7uHkK3+4eMogdisPQSytFLEfA+VruNBxsI77QEq6uRE?=
 =?us-ascii?Q?Xk2C9wy4LwKZssOpjZXhpSH8qGaB9l0fyfnqqFFuqLGuzlfBA7QHPxRH5iAW?=
 =?us-ascii?Q?8me4L3RIRDi38K7crvlwALYDyY5qL9AG2DFT1w6BBgnGM4UOyw6XuHlEvRH8?=
 =?us-ascii?Q?Hg/yIBkmxu65nRrQ20DCeH4dD07mVjmmf2CLwDFN7CCMHOEfRF7frspxlP36?=
 =?us-ascii?Q?drtnlsf+ZzWY5i09zHGDfk1YJgd7F6LUzKxV4M3eV0mbWRs4RTGIYhKhLJ0G?=
 =?us-ascii?Q?hwgGpQT5mlIePBP/PPr6kL+3j89Ba17wqlsJ28Hf7jp/wZPqKpCjUYA2t+5U?=
 =?us-ascii?Q?binZDzsgAMvLft9QWMnrbO4Z/OH6z3+NyFtbbq8c/QpZO5U5bfRqORltaatO?=
 =?us-ascii?Q?EPZy0cDX7kUqMADkRTuAdF9IQEXHSqFswJ+m7Ye05BrAeo9BljJFuRIi5sLr?=
 =?us-ascii?Q?k0UsoXftzajY12dWz91nJXakCxG9tEVm8Cv6U5tm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1866e4-bc6e-44ed-6a35-08dbc03506e0
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 15:10:18.7734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xh2dmAfDs2qN9PoFSKCjuPahvgv6TxDT3iusJeBgRqRORxBkH1p3JzHq+TGf69WDY9FCT2g/mZ2CUY47lkP7tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5359
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a new netlink family to get/set ULP DDP capabilities on a network
device and to retrieve statistics.

The messages use the genetlink infrastructure and are specified in a
YAML file which was used to generate some of the files in this commit:

./tools/net/ynl/ynl-gen-c.py --mode kernel \
    --spec ./Documentation/netlink/specs/ulp_ddp.yaml --header \
    -o net/core/ulp_ddp_gen_nl.h
./tools/net/ynl/ynl-gen-c.py --mode kernel \
    --spec ./Documentation/netlink/specs/ulp_ddp.yaml --source \
    -o net/core/ulp_ddp_gen_nl.c
./tools/net/ynl/ynl-gen-c.py --mode uapi \
    --spec ./Documentation/netlink/specs/ulp_ddp.yaml --header \
    > include/uapi/linux/ulp_ddp_nl.h

Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
---
 Documentation/netlink/specs/ulp_ddp.yaml | 183 +++++++++++
 include/uapi/linux/ulp_ddp_nl.h          |  59 ++++
 net/core/Makefile                        |   2 +-
 net/core/ulp_ddp_gen_nl.c                |  85 +++++
 net/core/ulp_ddp_gen_nl.h                |  32 ++
 net/core/ulp_ddp_nl.c                    | 388 +++++++++++++++++++++++
 6 files changed, 748 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/netlink/specs/ulp_ddp.yaml
 create mode 100644 include/uapi/linux/ulp_ddp_nl.h
 create mode 100644 net/core/ulp_ddp_gen_nl.c
 create mode 100644 net/core/ulp_ddp_gen_nl.h
 create mode 100644 net/core/ulp_ddp_nl.c

diff --git a/Documentation/netlink/specs/ulp_ddp.yaml b/Documentation/netlink/specs/ulp_ddp.yaml
new file mode 100644
index 000000000000..882aa4e52992
--- /dev/null
+++ b/Documentation/netlink/specs/ulp_ddp.yaml
@@ -0,0 +1,183 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+#
+# Author: Aurelien Aptel <aaptel@nvidia.com>
+#
+# Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
+#
+
+name: ulp_ddp
+
+protocol: genetlink
+
+doc: Netlink protocol to manage ULP DPP on network devices.
+
+definitions:
+  -
+    type: enum
+    name: cap
+    entries:
+      - nvme-tcp
+      - nvme-tcp-ddgst-rx
+
+uapi-header: linux/ulp_ddp_nl.h
+
+attribute-sets:
+  -
+    name: stat
+    attributes:
+      -
+        name: ifindex
+        doc: interface index of the net device.
+        type: u32
+      -
+        name: pad
+        type: pad
+      -
+        name: rx-nvmeotcp-sk-add
+        doc: Sockets successfully configured for NVMeTCP offloading.
+        type: u64
+      -
+        name: rx-nvmeotcp-sk-add-fail
+        doc: Sockets failed to be configured for NVMeTCP offloading.
+        type: u64
+      -
+        name: rx-nvmeotcp-sk-del
+        doc: Sockets with NVMeTCP offloading configuration removed.
+        type: u64
+      -
+        name: rx-nvmeotcp-setup
+        doc: NVMe-TCP IOs successfully configured for Rx Direct Data Placement.
+        type: u64
+      -
+        name: rx-nvmeotcp-setup-fail
+        doc: NVMe-TCP IOs failed to be configured for Rx Direct Data Placement.
+        type: u64
+      -
+        name: rx-nvmeotcp-teardown
+        doc: NVMe-TCP IOs with Rx Direct Data Placement configuration removed.
+        type: u64
+      -
+        name: rx-nvmeotcp-drop
+        doc: Packets failed the NVMeTCP offload validation.
+        type: u64
+      -
+        name: rx-nvmeotcp-resync
+        doc: >
+          NVMe-TCP resync operations were processed due to Rx TCP packets
+          re-ordering.
+        type: u64
+      -
+        name: rx-nvmeotcp-packets
+        doc: TCP packets successfully processed by the NVMeTCP offload.
+        type: u64
+      -
+        name: rx-nvmeotcp-bytes
+        doc: Bytes were successfully processed by the NVMeTCP offload.
+        type: u64
+  -
+    name: dev
+    attributes:
+      -
+        name: ifindex
+        doc: interface index of the net device.
+        type: u32
+      -
+        name: hw
+        doc: bitmask of the capabilities supported by the device.
+        type: u64
+        enum: cap
+        enum-as-flags: true
+      -
+        name: active
+        doc: bitmask of the capabilities currently enabled on the device.
+        type: u64
+        enum: cap
+        enum-as-flags: true
+      -
+        name: wanted
+        doc: >
+          new active bit values of the capabilities we want to set on the
+          device.
+        type: u64
+        enum: cap
+        enum-as-flags: true
+      -
+        name: wanted_mask
+        doc: bitmask of the meaningful bits in the wanted field.
+        type: u64
+        enum: cap
+        enum-as-flags: true
+      -
+        name: pad
+        type: pad
+
+operations:
+  list:
+    -
+      name: get
+      doc: Get ULP DDP capabilities.
+      attribute-set: dev
+      do:
+        request:
+          attributes:
+            - ifindex
+        reply: &dev-all
+          attributes:
+            - ifindex
+            - hw
+            - active
+        pre: ulp_ddp_get_netdev
+        post: ulp_ddp_put_netdev
+      dump:
+        reply: *dev-all
+    -
+      name: stats
+      doc: Get ULP DDP stats.
+      attribute-set: stat
+      do:
+        request:
+          attributes:
+            - ifindex
+        reply: &stats-all
+          attributes:
+            - ifindex
+            - rx-nvmeotcp-sk-add
+            - rx-nvmeotcp-sk-add-fail
+            - rx-nvmeotcp-sk-del
+            - rx-nvmeotcp-setup
+            - rx-nvmeotcp-setup-fail
+            - rx-nvmeotcp-teardown
+            - rx-nvmeotcp-drop
+            - rx-nvmeotcp-resync
+            - rx-nvmeotcp-packets
+            - rx-nvmeotcp-bytes
+        pre: ulp_ddp_get_netdev
+        post: ulp_ddp_put_netdev
+      dump:
+        reply: *stats-all
+    -
+      name: set
+      doc: Set ULP DDP capabilities.
+      attribute-set: dev
+      do:
+        request:
+          attributes:
+            - ifindex
+            - wanted
+            - wanted_mask
+        reply:
+          attributes:
+            - ifindex
+            - hw
+            - active
+        pre: ulp_ddp_get_netdev
+        post: ulp_ddp_put_netdev
+    -
+      name: set-ntf
+      doc: Notification for change in ULP DDP capabilities.
+      notify: get
+
+mcast-groups:
+  list:
+    -
+      name: mgmt
diff --git a/include/uapi/linux/ulp_ddp_nl.h b/include/uapi/linux/ulp_ddp_nl.h
new file mode 100644
index 000000000000..fc63749c9251
--- /dev/null
+++ b/include/uapi/linux/ulp_ddp_nl.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/ulp_ddp.yaml */
+/* YNL-GEN uapi header */
+
+#ifndef _UAPI_LINUX_ULP_DDP_H
+#define _UAPI_LINUX_ULP_DDP_H
+
+#define ULP_DDP_FAMILY_NAME	"ulp_ddp"
+#define ULP_DDP_FAMILY_VERSION	1
+
+enum ulp_ddp_cap {
+	ULP_DDP_CAP_NVME_TCP,
+	ULP_DDP_CAP_NVME_TCP_DDGST_RX,
+};
+
+enum {
+	ULP_DDP_A_STAT_IFINDEX = 1,
+	ULP_DDP_A_STAT_PAD,
+	ULP_DDP_A_STAT_RX_NVMEOTCP_SK_ADD,
+	ULP_DDP_A_STAT_RX_NVMEOTCP_SK_ADD_FAIL,
+	ULP_DDP_A_STAT_RX_NVMEOTCP_SK_DEL,
+	ULP_DDP_A_STAT_RX_NVMEOTCP_SETUP,
+	ULP_DDP_A_STAT_RX_NVMEOTCP_SETUP_FAIL,
+	ULP_DDP_A_STAT_RX_NVMEOTCP_TEARDOWN,
+	ULP_DDP_A_STAT_RX_NVMEOTCP_DROP,
+	ULP_DDP_A_STAT_RX_NVMEOTCP_RESYNC,
+	ULP_DDP_A_STAT_RX_NVMEOTCP_PACKETS,
+	ULP_DDP_A_STAT_RX_NVMEOTCP_BYTES,
+
+	__ULP_DDP_A_STAT_MAX,
+	ULP_DDP_A_STAT_MAX = (__ULP_DDP_A_STAT_MAX - 1)
+};
+
+enum {
+	ULP_DDP_A_DEV_IFINDEX = 1,
+	ULP_DDP_A_DEV_HW,
+	ULP_DDP_A_DEV_ACTIVE,
+	ULP_DDP_A_DEV_WANTED,
+	ULP_DDP_A_DEV_WANTED_MASK,
+	ULP_DDP_A_DEV_PAD,
+
+	__ULP_DDP_A_DEV_MAX,
+	ULP_DDP_A_DEV_MAX = (__ULP_DDP_A_DEV_MAX - 1)
+};
+
+enum {
+	ULP_DDP_CMD_GET = 1,
+	ULP_DDP_CMD_STATS,
+	ULP_DDP_CMD_SET,
+	ULP_DDP_CMD_SET_NTF,
+
+	__ULP_DDP_CMD_MAX,
+	ULP_DDP_CMD_MAX = (__ULP_DDP_CMD_MAX - 1)
+};
+
+#define ULP_DDP_MCGRP_MGMT	"mgmt"
+
+#endif /* _UAPI_LINUX_ULP_DDP_H */
diff --git a/net/core/Makefile b/net/core/Makefile
index 09da9ed3f9ff..35a882e7276d 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -18,7 +18,7 @@ obj-y		     += dev.o dev_addr_lists.o dst.o netevent.o \
 obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) += dev_addr_lists_test.o
 
 obj-y += net-sysfs.o
-obj-$(CONFIG_ULP_DDP) += ulp_ddp.o
+obj-$(CONFIG_ULP_DDP) += ulp_ddp.o ulp_ddp_nl.o ulp_ddp_gen_nl.o
 obj-$(CONFIG_PAGE_POOL) += page_pool.o
 obj-$(CONFIG_PROC_FS) += net-procfs.o
 obj-$(CONFIG_NET_PKTGEN) += pktgen.o
diff --git a/net/core/ulp_ddp_gen_nl.c b/net/core/ulp_ddp_gen_nl.c
new file mode 100644
index 000000000000..505bdc69b215
--- /dev/null
+++ b/net/core/ulp_ddp_gen_nl.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/ulp_ddp.yaml */
+/* YNL-GEN kernel source */
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include "ulp_ddp_gen_nl.h"
+
+#include <uapi/linux/ulp_ddp_nl.h>
+
+/* ULP_DDP_CMD_GET - do */
+static const struct nla_policy ulp_ddp_get_nl_policy[ULP_DDP_A_DEV_IFINDEX + 1] = {
+	[ULP_DDP_A_DEV_IFINDEX] = { .type = NLA_U32, },
+};
+
+/* ULP_DDP_CMD_STATS - do */
+static const struct nla_policy ulp_ddp_stats_nl_policy[ULP_DDP_A_STAT_IFINDEX + 1] = {
+	[ULP_DDP_A_STAT_IFINDEX] = { .type = NLA_U32, },
+};
+
+/* ULP_DDP_CMD_SET - do */
+static const struct nla_policy ulp_ddp_set_nl_policy[ULP_DDP_A_DEV_WANTED_MASK + 1] = {
+	[ULP_DDP_A_DEV_IFINDEX] = { .type = NLA_U32, },
+	[ULP_DDP_A_DEV_WANTED] = NLA_POLICY_MASK(NLA_U64, 0x3),
+	[ULP_DDP_A_DEV_WANTED_MASK] = NLA_POLICY_MASK(NLA_U64, 0x3),
+};
+
+/* Ops table for ulp_ddp */
+static const struct genl_split_ops ulp_ddp_nl_ops[] = {
+	{
+		.cmd		= ULP_DDP_CMD_GET,
+		.pre_doit	= ulp_ddp_get_netdev,
+		.doit		= ulp_ddp_nl_get_doit,
+		.post_doit	= ulp_ddp_put_netdev,
+		.policy		= ulp_ddp_get_nl_policy,
+		.maxattr	= ULP_DDP_A_DEV_IFINDEX,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd	= ULP_DDP_CMD_GET,
+		.dumpit	= ulp_ddp_nl_get_dumpit,
+		.flags	= GENL_CMD_CAP_DUMP,
+	},
+	{
+		.cmd		= ULP_DDP_CMD_STATS,
+		.pre_doit	= ulp_ddp_get_netdev,
+		.doit		= ulp_ddp_nl_stats_doit,
+		.post_doit	= ulp_ddp_put_netdev,
+		.policy		= ulp_ddp_stats_nl_policy,
+		.maxattr	= ULP_DDP_A_STAT_IFINDEX,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd	= ULP_DDP_CMD_STATS,
+		.dumpit	= ulp_ddp_nl_stats_dumpit,
+		.flags	= GENL_CMD_CAP_DUMP,
+	},
+	{
+		.cmd		= ULP_DDP_CMD_SET,
+		.pre_doit	= ulp_ddp_get_netdev,
+		.doit		= ulp_ddp_nl_set_doit,
+		.post_doit	= ulp_ddp_put_netdev,
+		.policy		= ulp_ddp_set_nl_policy,
+		.maxattr	= ULP_DDP_A_DEV_WANTED_MASK,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+};
+
+static const struct genl_multicast_group ulp_ddp_nl_mcgrps[] = {
+	[ULP_DDP_NLGRP_MGMT] = { "mgmt", },
+};
+
+struct genl_family ulp_ddp_nl_family __ro_after_init = {
+	.name		= ULP_DDP_FAMILY_NAME,
+	.version	= ULP_DDP_FAMILY_VERSION,
+	.netnsok	= true,
+	.parallel_ops	= true,
+	.module		= THIS_MODULE,
+	.split_ops	= ulp_ddp_nl_ops,
+	.n_split_ops	= ARRAY_SIZE(ulp_ddp_nl_ops),
+	.mcgrps		= ulp_ddp_nl_mcgrps,
+	.n_mcgrps	= ARRAY_SIZE(ulp_ddp_nl_mcgrps),
+};
diff --git a/net/core/ulp_ddp_gen_nl.h b/net/core/ulp_ddp_gen_nl.h
new file mode 100644
index 000000000000..277fb9dbfdcd
--- /dev/null
+++ b/net/core/ulp_ddp_gen_nl.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/ulp_ddp.yaml */
+/* YNL-GEN kernel header */
+
+#ifndef _LINUX_ULP_DDP_GEN_H
+#define _LINUX_ULP_DDP_GEN_H
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include <uapi/linux/ulp_ddp_nl.h>
+
+int ulp_ddp_get_netdev(const struct genl_split_ops *ops, struct sk_buff *skb,
+		       struct genl_info *info);
+void
+ulp_ddp_put_netdev(const struct genl_split_ops *ops, struct sk_buff *skb,
+		   struct genl_info *info);
+
+int ulp_ddp_nl_get_doit(struct sk_buff *skb, struct genl_info *info);
+int ulp_ddp_nl_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
+int ulp_ddp_nl_stats_doit(struct sk_buff *skb, struct genl_info *info);
+int ulp_ddp_nl_stats_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
+int ulp_ddp_nl_set_doit(struct sk_buff *skb, struct genl_info *info);
+
+enum {
+	ULP_DDP_NLGRP_MGMT,
+};
+
+extern struct genl_family ulp_ddp_nl_family;
+
+#endif /* _LINUX_ULP_DDP_GEN_H */
diff --git a/net/core/ulp_ddp_nl.c b/net/core/ulp_ddp_nl.c
new file mode 100644
index 000000000000..55e5c51b6d88
--- /dev/null
+++ b/net/core/ulp_ddp_nl.c
@@ -0,0 +1,388 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ulp_ddp.c
+ *    Author: Aurelien Aptel <aaptel@nvidia.com>
+ *    Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
+ */
+#include <net/ulp_ddp.h>
+#include "ulp_ddp_gen_nl.h"
+
+#define ULP_DDP_STATS_CNT (sizeof(struct netlink_ulp_ddp_stats) / sizeof(u64))
+
+struct reply_data {
+	struct net_device *dev;
+	netdevice_tracker tracker;
+	void *hdr;
+	u32 ifindex;
+	DECLARE_BITMAP(hw, ULP_DDP_C_COUNT);
+	DECLARE_BITMAP(active, ULP_DDP_C_COUNT);
+	struct netlink_ulp_ddp_stats stats;
+};
+
+static size_t reply_size(int cmd)
+{
+	size_t len = 0;
+
+	BUILD_BUG_ON(ULP_DDP_C_COUNT > 64);
+
+	/* ifindex */
+	len += nla_total_size(sizeof(u32));
+
+	switch (cmd) {
+	case ULP_DDP_CMD_GET:
+	case ULP_DDP_CMD_SET:
+	case ULP_DDP_CMD_SET_NTF:
+		/* hw */
+		len += nla_total_size_64bit(sizeof(u64));
+
+		/* active */
+		len += nla_total_size_64bit(sizeof(u64));
+		break;
+	case ULP_DDP_CMD_STATS:
+		/* stats */
+		len += nla_total_size_64bit(sizeof(u64)) * ULP_DDP_STATS_CNT;
+		break;
+	}
+
+	return len;
+}
+
+/* pre_doit */
+int ulp_ddp_get_netdev(const struct genl_split_ops *ops,
+		       struct sk_buff *skb, struct genl_info *info)
+{
+	struct reply_data *data;
+
+	if (GENL_REQ_ATTR_CHECK(info, ULP_DDP_A_DEV_IFINDEX))
+		return -EINVAL;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->ifindex = nla_get_u32(info->attrs[ULP_DDP_A_DEV_IFINDEX]);
+	data->dev = netdev_get_by_index(genl_info_net(info),
+					data->ifindex,
+					&data->tracker,
+					GFP_KERNEL);
+	if (!data->dev) {
+		kfree(data);
+		NL_SET_BAD_ATTR(info->extack,
+				info->attrs[ULP_DDP_A_DEV_IFINDEX]);
+		return -ENOENT;
+	}
+
+	info->user_ptr[0] = data;
+	return 0;
+}
+
+/* post_doit */
+void ulp_ddp_put_netdev(const struct genl_split_ops *ops, struct sk_buff *skb,
+			struct genl_info *info)
+{
+	struct reply_data *data = info->user_ptr[0];
+
+	if (data) {
+		if (data->dev)
+			netdev_put(data->dev, &data->tracker);
+		kfree(data);
+	}
+}
+
+static int prepare_data(struct reply_data *data, int cmd)
+{
+	const struct ulp_ddp_dev_ops *ops = data->dev->netdev_ops->ulp_ddp_ops;
+	struct ulp_ddp_netdev_caps *caps = &data->dev->ulp_ddp_caps;
+
+	if (!ops)
+		return -EOPNOTSUPP;
+
+	switch (cmd) {
+	case ULP_DDP_CMD_GET:
+	case ULP_DDP_CMD_SET:
+	case ULP_DDP_CMD_SET_NTF:
+		bitmap_copy(data->hw, caps->hw, ULP_DDP_C_COUNT);
+		bitmap_copy(data->active, caps->active, ULP_DDP_C_COUNT);
+		break;
+	case ULP_DDP_CMD_STATS:
+		ops->get_stats(data->dev, &data->stats);
+		break;
+	}
+
+	return 0;
+}
+
+static int fill_data(struct sk_buff *rsp, struct reply_data *data, int cmd,
+		     const struct genl_info *info)
+{
+	u64 *val = (u64 *)&data->stats;
+	int attr, i;
+
+	data->hdr = genlmsg_iput(rsp, info);
+	if (!data->hdr)
+		return -EMSGSIZE;
+
+	switch (cmd) {
+	case ULP_DDP_CMD_GET:
+	case ULP_DDP_CMD_SET:
+	case ULP_DDP_CMD_SET_NTF:
+		if (nla_put_u32(rsp, ULP_DDP_A_DEV_IFINDEX, data->ifindex) ||
+		    nla_put_u64_64bit(rsp, ULP_DDP_A_DEV_HW,
+				      data->hw[0], ULP_DDP_A_DEV_PAD) ||
+		    nla_put_u64_64bit(rsp, ULP_DDP_A_DEV_ACTIVE,
+				      data->active[0], ULP_DDP_A_DEV_PAD))
+			goto err_cancel_msg;
+		break;
+	case ULP_DDP_CMD_STATS:
+		if (nla_put_u32(rsp, ULP_DDP_A_STAT_IFINDEX, data->ifindex))
+			goto err_cancel_msg;
+
+		attr = ULP_DDP_A_STAT_PAD + 1;
+		for (i = 0; i < ULP_DDP_STATS_CNT; i++, attr++)
+			if (nla_put_u64_64bit(rsp, attr, val[i],
+					      ULP_DDP_A_STAT_PAD))
+				goto err_cancel_msg;
+	}
+	genlmsg_end(rsp, data->hdr);
+
+	return 0;
+
+err_cancel_msg:
+	genlmsg_cancel(rsp, data->hdr);
+
+	return -EMSGSIZE;
+}
+
+int ulp_ddp_nl_get_doit(struct sk_buff *req, struct genl_info *info)
+{
+	struct reply_data *data = info->user_ptr[0];
+	struct sk_buff *rsp;
+	int ret = 0;
+
+	ret = prepare_data(data, ULP_DDP_CMD_GET);
+	if (ret)
+		return ret;
+
+	rsp = genlmsg_new(reply_size(ULP_DDP_CMD_GET), GFP_KERNEL);
+	if (!rsp)
+		return -EMSGSIZE;
+
+	ret = fill_data(rsp, data, ULP_DDP_CMD_GET, info);
+	if (ret < 0)
+		goto err_rsp;
+
+	return genlmsg_reply(rsp, info);
+
+err_rsp:
+	nlmsg_free(rsp);
+	return ret;
+}
+
+static void ulp_ddp_nl_notify_dev(struct reply_data *data)
+{
+	struct genl_info info;
+	struct sk_buff *ntf;
+
+	if (!genl_has_listeners(&ulp_ddp_nl_family, dev_net(data->dev),
+				ULP_DDP_NLGRP_MGMT))
+		return;
+
+	genl_info_init_ntf(&info, &ulp_ddp_nl_family, ULP_DDP_CMD_SET_NTF);
+	ntf = genlmsg_new(reply_size(ULP_DDP_CMD_GET), GFP_KERNEL);
+	if (!ntf)
+		return;
+
+	if (fill_data(ntf, data, ULP_DDP_CMD_SET_NTF, &info)) {
+		nlmsg_free(ntf);
+		return;
+	}
+
+	genlmsg_multicast_netns(&ulp_ddp_nl_family, dev_net(data->dev), ntf,
+				0, ULP_DDP_NLGRP_MGMT, GFP_KERNEL);
+}
+
+static int apply_bits(struct reply_data *data,
+		      unsigned long *req_wanted,
+		      unsigned long *req_mask,
+		      struct netlink_ext_ack *extack)
+{
+	DECLARE_BITMAP(old_active, ULP_DDP_C_COUNT);
+	DECLARE_BITMAP(new_active, ULP_DDP_C_COUNT);
+	DECLARE_BITMAP(all_bits, ULP_DDP_C_COUNT);
+	DECLARE_BITMAP(tmp, ULP_DDP_C_COUNT);
+	const struct ulp_ddp_dev_ops *ops;
+	struct ulp_ddp_netdev_caps *caps;
+	int ret;
+
+	caps = &data->dev->ulp_ddp_caps;
+	ops = data->dev->netdev_ops->ulp_ddp_ops;
+
+	if (!ops)
+		return -EOPNOTSUPP;
+
+	/* if (req_mask & ~all_bits) */
+	bitmap_fill(all_bits, ULP_DDP_C_COUNT);
+	bitmap_andnot(tmp, req_mask, all_bits, ULP_DDP_C_COUNT);
+	if (!bitmap_empty(tmp, ULP_DDP_C_COUNT))
+		return -EINVAL;
+
+	/* new_active = (old_active & ~req_mask) | (wanted & req_mask)
+	 * new_active &= caps_hw
+	 */
+	bitmap_copy(old_active, caps->active, ULP_DDP_C_COUNT);
+	bitmap_and(req_wanted, req_wanted, req_mask, ULP_DDP_C_COUNT);
+	bitmap_andnot(new_active, old_active, req_mask, ULP_DDP_C_COUNT);
+	bitmap_or(new_active, new_active, req_wanted, ULP_DDP_C_COUNT);
+	bitmap_and(new_active, new_active, caps->hw, ULP_DDP_C_COUNT);
+	if (!bitmap_equal(old_active, new_active, ULP_DDP_C_COUNT)) {
+		ret = ops->set_caps(data->dev, new_active, extack);
+		if (ret < 0)
+			return ret;
+		bitmap_copy(new_active, caps->active, ULP_DDP_C_COUNT);
+	}
+
+	/* return 1 to notify */
+	return !bitmap_equal(old_active, new_active, ULP_DDP_C_COUNT);
+}
+
+int ulp_ddp_nl_set_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct reply_data *data = info->user_ptr[0];
+	unsigned long wanted, wanted_mask;
+	struct sk_buff *rsp;
+	bool notify;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, ULP_DDP_A_DEV_WANTED) ||
+	    GENL_REQ_ATTR_CHECK(info, ULP_DDP_A_DEV_WANTED_MASK))
+		return -EINVAL;
+
+	rsp = genlmsg_new(reply_size(ULP_DDP_CMD_STATS), GFP_KERNEL);
+	if (!rsp)
+		return -EMSGSIZE;
+
+	wanted = nla_get_u64(info->attrs[ULP_DDP_A_DEV_WANTED]);
+	wanted_mask = nla_get_u64(info->attrs[ULP_DDP_A_DEV_WANTED_MASK]);
+
+	ret = apply_bits(data, &wanted, &wanted_mask, info->extack);
+	if (ret < 0)
+		goto err_rsp;
+
+	notify = !!ret;
+	ret = prepare_data(data, ULP_DDP_CMD_SET);
+	if (ret)
+		goto err_rsp;
+
+	ret = fill_data(rsp, data, ULP_DDP_CMD_SET, info);
+	if (ret < 0)
+		goto err_rsp;
+
+	ret = genlmsg_reply(rsp, info);
+	if (notify)
+		ulp_ddp_nl_notify_dev(data);
+
+	return ret;
+
+err_rsp:
+	nlmsg_free(rsp);
+
+	return ret;
+}
+
+int ulp_ddp_nl_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	struct net *net = sock_net(skb->sk);
+	struct net_device *netdev;
+	struct reply_data data;
+	int err = 0;
+
+	rtnl_lock();
+	for_each_netdev_dump(net, netdev, cb->args[0]) {
+		memset(&data, 0, sizeof(data));
+		data.dev = netdev;
+		data.ifindex = netdev->ifindex;
+
+		err = prepare_data(&data, ULP_DDP_CMD_GET);
+		if (err)
+			continue;
+
+		err = fill_data(skb, &data, ULP_DDP_CMD_GET,
+				genl_info_dump(cb));
+		if (err < 0)
+			break;
+	}
+	rtnl_unlock();
+
+	if (err != -EMSGSIZE)
+		return err;
+
+	return skb->len;
+}
+
+int ulp_ddp_nl_stats_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct reply_data *data = info->user_ptr[0];
+	struct sk_buff *rsp;
+	int ret = 0;
+
+	ret = prepare_data(data, ULP_DDP_CMD_STATS);
+	if (ret)
+		return ret;
+
+	rsp = genlmsg_new(reply_size(ULP_DDP_CMD_STATS), GFP_KERNEL);
+	if (!rsp)
+		return -EMSGSIZE;
+
+	ret = fill_data(rsp, data, ULP_DDP_CMD_STATS, info);
+	if (ret < 0)
+		goto err_rsp;
+
+	return genlmsg_reply(rsp, info);
+
+err_rsp:
+	nlmsg_free(rsp);
+	return ret;
+}
+
+int ulp_ddp_nl_stats_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	struct net *net = sock_net(skb->sk);
+	struct net_device *netdev;
+	struct reply_data data;
+	int err = 0;
+
+	rtnl_lock();
+	for_each_netdev_dump(net, netdev, cb->args[0]) {
+		memset(&data, 0, sizeof(data));
+		data.dev = netdev;
+		data.ifindex = netdev->ifindex;
+
+		err = prepare_data(&data, ULP_DDP_CMD_STATS);
+		if (err)
+			continue;
+
+		err = fill_data(skb, &data, ULP_DDP_CMD_STATS,
+				genl_info_dump(cb));
+		if (err < 0)
+			break;
+	}
+	rtnl_unlock();
+
+	if (err != -EMSGSIZE)
+		return err;
+
+	return skb->len;
+}
+
+static int __init ulp_ddp_init(void)
+{
+	int err;
+
+	err = genl_register_family(&ulp_ddp_nl_family);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+subsys_initcall(ulp_ddp_init);
-- 
2.34.1


