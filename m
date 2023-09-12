Return-Path: <netdev+bounces-33132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8383A79CCBA
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 12:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3EF21C20E09
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 10:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E8417725;
	Tue, 12 Sep 2023 10:00:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC23D1640C
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 10:00:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DC61995
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 03:00:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnFwmST6KdyJQmxV7LgHA6ILhfEsgEH2hMplZYFpAOBmk4oCTYPXpFBC+wBKgEZSIHaF0Mjyv3F6x/zdTIIhLJZo3mKcZsXN/JIIlPXJRV8xXsBqysWYiU7OEYtzj8DDzJ1B51zZe+QLjN3hJi6FKm+YU/nNgmRkuY8bn6NiqR3WiLolE7T2mePQX4dfGVDAgDHm2bNZ8EWggveem3JyIpsvRl7WQSve1VpSRtmW9KxUItIFuVamyqk5i7rwY3LqozlxqvSxxADs8E9/Bl9absQJog+GCTPqu3KbnNZJv7HjxuGeaAqjKpj7kHq9NBnXkbMArlbHO6hUnhj6UcaaPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqzcmgjxRU62Ume557natbjSfWWgXgIAVlI4dkGhZvc=;
 b=WsgAO99DkHkcaNG7MveEFjySInCp3N06YNAg9XVr4HRCF9WV76JzKaW71hv2d/65AFHVeddPzuBVcOkSGXNMe6dtwvQJHMBim+kjy8u1POssDK9KyaV8qKlOeHzx9xIaek2hNp2a+iZdM3i8sIOPm/CFzZd2FFq19tU+vmpSKxPQdh1WBvwVfk+PM9wiT2zdHxSbtx34o8IF4twG4LzG/2VdTrAqV+5my9E61XkSRrR017GFe9p1IGyZQzLX+qSEtI+57mw7l5gthPEZnWchLIbqyViuKKTNAGP3VpC4Kh1Uq2Ko7jcyou7AkC9lqoGRo32IS5LxaIW7F1I249nT9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqzcmgjxRU62Ume557natbjSfWWgXgIAVlI4dkGhZvc=;
 b=gdyfs0fYVDixcf2RKd905XScrJWnwav09FUdWLAVbaUJRaayxSbfaUnSzw1OPx9qLVUJGIldQP3V3HD7qVrxzuVwfNcF4rfsGbILwqt1s9uQ0mzH2UMrbJ+ZXFt/fx9zlPcTY0qLcWowGk/F+avy1qo3yLOxjZ385K0pHhv5TFwuS46s/3rThngiDSSCkPg3BU2PYe0RM5plpce7NpnQhGCdK/vhX7iTyO70aXglBWe1Es0MgrVDIH5a8m/T2a75jYJ5L0sHmJh9Rz8NmwjSrc11CB0bmo0sLUNCQGjnM6pCd5OranbKLBHid9VNdMP1xvJ5ZqxDrnP45/mdgo/Gtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) by
 BN9PR12MB5034.namprd12.prod.outlook.com (2603:10b6:408:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 10:00:24 +0000
Received: from DS7PR12MB6069.namprd12.prod.outlook.com
 ([fe80::8ce3:c3f6:fc3a:addb]) by DS7PR12MB6069.namprd12.prod.outlook.com
 ([fe80::8ce3:c3f6:fc3a:addb%5]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 10:00:24 +0000
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
Subject: [PATCH v15 02/20] netlink: add new family to manage ULP_DDP enablement and stats
Date: Tue, 12 Sep 2023 09:59:31 +0000
Message-Id: <20230912095949.5474-3-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912095949.5474-1-aaptel@nvidia.com>
References: <20230912095949.5474-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::14) To DS7PR12MB6069.namprd12.prod.outlook.com
 (2603:10b6:8:9f::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6069:EE_|BN9PR12MB5034:EE_
X-MS-Office365-Filtering-Correlation-Id: db60b09f-5d07-477f-a67f-08dbb3771569
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xXRK3HYUeIO1GmFejKsvSjDXQfhx8RErS+koY/4rtpWNG1xGfaljTFUk+ealsh2j5yrzmvPtN2TQkv2mr77NJupofj+a+KG6bF7OOqtIw7rKEGgBVQexcyEBNEEEHeMshALdv7XeoAqfjdB7RlQUDnsePPDvBKFZ7ft7C62qGVRge5AgPRS/02Ti1A0veJdXck1hjrIShoiJCqYngZhcGURG87ndqgf3at6NgRhg4Jg26Bj8O1QBSFvohUmWySWOCeC739RMa1qWujcaSVkvCIk/5k66LMx50/W6CqsbfpxCVoJGdYcx9AVQE9nS3UR6pnkOAqc773kw5oakI5cC5xj4Ytoptj85vxYpK3vZ6k8fJS9CqMy+zCapyIWLoNsrl8Qpny0B6R3pPtJr3RQw8EPHe79RjVqmgb2Vh2eWTyjpVSJKaztebjnbZ9PAHmEfRYjpGUjwd2qfVLrY0RMQ/7/IqyIZFRHShK6XbFfbmRTslb/jVjv+2Xr4vm9PzFujjBEUk83KosOcliGCJsWjlNgCel/jb020uXeueFoixAAJfeQJBugXU9i7tBHS5q8qWmlhVuOJZMwpqI3MNf3s9z/x7Q+ZKCOhVG2m3wS9tao=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6069.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(376002)(136003)(396003)(1800799009)(186009)(451199024)(1076003)(26005)(86362001)(83380400001)(2616005)(6486002)(6506007)(30864003)(2906002)(6666004)(7416002)(6512007)(38100700002)(36756003)(478600001)(4326008)(5660300002)(8676002)(8936002)(66476007)(66556008)(316002)(66946007)(41300700001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iN4FTg15QxiE/PPuRE+yvqhKXwzuVntTyncHpV4tQV3f6oitKXfgMTrtASp0?=
 =?us-ascii?Q?f1Y9OO6PqMUAS6ptCPVLce9I928bq+PByLIFK7oGn9K0tIlcKVazW9vaYpDt?=
 =?us-ascii?Q?6jLZLEw3vT2kkwgLMg7pvr9aE014Aq+oeGo543OclTUCTg+hn9l0MB8VP6QM?=
 =?us-ascii?Q?iPVF+a8Uxf9WPFp4M/YaEmSH9820yCwFykbRrbI7rycvSo4sPeAFIMcNm1Th?=
 =?us-ascii?Q?mbM9nOUs5rkQIQlvOe1ejEqYxMHc6suQWwBawyL8sWpIIUvrUzIPMFNLtHu+?=
 =?us-ascii?Q?6bfAWj9fyBfDzMuoYBS5DM7DZJGg9FZV3yCMraqUzc43luOCjv4KXx8nz/MY?=
 =?us-ascii?Q?nFS7trWnZPBsDr+MNO3LAnD4aVfYYxM+VTR0x6KEJyM2p7OZ+ExQ4SkogKGa?=
 =?us-ascii?Q?AI3T84Ez19WcLaT3emrw7ZjYplU/9I4B2N4eVm2UpdbZ/4PxlwT2Ql738MbX?=
 =?us-ascii?Q?ZBgD4m+0R8y2NnF1BvQvIaUflC4RESVrIk/3PojZmpU7O9tVzSmDXximh4Q4?=
 =?us-ascii?Q?jeXAtALejvWdiHUNBn0ssYmMtozwLoxAC8B2hemtOAWSbNzC/IKL4TbHl6Zw?=
 =?us-ascii?Q?e0HEzbmey9A0zaDIlmVMmc7pcNSxQIWTKQihFRhRa5GR87F8t497ECXb6mA5?=
 =?us-ascii?Q?kQTr78EewaQEeQulLRq4basAvFXcnkEsocke1ZokqGAYYEv/xKn8N0Dh6DkK?=
 =?us-ascii?Q?hNkgtLgO7Hrigp9nTF6R7kMbOLuTEWNFRd0BfJgIikilP5iUnX/yOkoLO1VM?=
 =?us-ascii?Q?RQFrKS5oqUs60jyhbQTIHgj8Y/qeRBxkhlmk5nPAeH3AECuerUfF55HNRBU5?=
 =?us-ascii?Q?vEnDpSoL6lqQdvfWu2oCj+y6YnS/UYvwXsA0hW3iJlz6xZLFyeHAdiVXd+ef?=
 =?us-ascii?Q?lMe1rdqr06EePmOYwCtJci5mppMY0UlXjZyG5eKGuq8B73J8Ded4zCBe4GFL?=
 =?us-ascii?Q?ZsrnrcNm1lEygV6NisCmYSKE7rt+LYxgEysaBcD0JydD5CDBA1BjZclzgzp0?=
 =?us-ascii?Q?xSjN8JYQBhl7sG4l7NjDWQnW8VLOugNLEZJ92cgoPhQ6jGP633Bj7hsUQrVA?=
 =?us-ascii?Q?uEcKyqYXWMzArxhMtwEISk09cMvwD0HKPOqSZYP4BTKsG9gFgzi4qQlHhTLk?=
 =?us-ascii?Q?khGpWjAWsyE0XzEZpeYLBzSXJyDeTCeARYKNSjBjUnSeegHtfzgfvrldZb0j?=
 =?us-ascii?Q?XY5qOwnfWocSe6x3B6XIX5PYJ4u9CkvsTCqPyen3tzR6115CXTZHO4vR/g7D?=
 =?us-ascii?Q?Kr0/tfQg1WqWwANm3AuNIfmyzz4JIsOiW4xfzSoYkk9QSh9uKzh6offnLAMm?=
 =?us-ascii?Q?1NOGhFSZXqDKQb9y51dBMDxl8syk9FC0rMQdcfPuDl7mcqQ+UL/SZ63aB7eS?=
 =?us-ascii?Q?uWthLpc8CHtjlFaR/jS7SJTzps3NFz2JxsCo295II2B1dJXqKYtrEt1fJOAG?=
 =?us-ascii?Q?MfAo3TA+sHy0eMWvIU3oFm/SfWgmA6EL35lVu/niITG0ecKVs9DKLkC8ohhW?=
 =?us-ascii?Q?K10I3CeTOSimlHYQh2mp1JTrQoTQ88tNQ/ioq3NROJdtPRhgbEeIzSfu5B0D?=
 =?us-ascii?Q?6HOxSPEC+G854N4rQDTqXKh4/qxjcTecIVXicWLf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db60b09f-5d07-477f-a67f-08dbb3771569
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6069.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 10:00:24.7176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HL7jOVlxJb8Rkq7K8osW3NOpuBRZwR0itjTtbzHN83aRpkuoxgENLPBeBfOrvuP6LpAQlCHYGgQ96xt1bSL9kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5034

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


