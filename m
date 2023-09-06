Return-Path: <netdev+bounces-32241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AB5793B4E
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 13:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 534361C20A06
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 11:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422B56126;
	Wed,  6 Sep 2023 11:31:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE886AB4
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 11:31:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::60b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F133F199B
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 04:31:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBfy/Z11i88gmxu9QRPlh3pKAl3iQiOkg2BjlhjL1rtlFu17f8ufeTIFY/SxaZosnKDiLxjKrgsyAmTruv6UOf+tRZXFz24NFKAA7+qc3vEDpL4X8Jr1+cfv51WCfodE5UeGjP9L7IUOgqYx79mgJ5ZnKecv5i2U2BFcJUWvA3cZxkdX+Y/7AL/5i4maeah2HJKmwkOX6A4XMJGp+1pSiycbJdN04nAT3iSulxsMlyd7ZVNKGep7hvQVEALwSghPEfxufRrFaVQB5QKRfnVUhWBQe6AjlRkvoEU3ep6BnBSxfPfLWkHfuph47F+XTOBajCaJ0rGQEKgMib6xFsH6GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adsfQhiPrj+aTV76rSkZICINOWHfalUb19qZk4h9m1c=;
 b=U0BZk2r7VHOJnXO1Re5HuviJAMNIzeN1LM9wJgUIIW6cyZEqkO41bdIofq+/k9yzUKeogkeo8CNpQaOxMpL9lLBG+88O/WbmNygdihuMYcrJu/CIVq0Nrberq2LAppdyVjPC4KkGp4qeh0Ega+OJxmpiwnWwbvXY3/Jv02pyS1WTOno7XReD8o71dgLcYf13Ac6WZjgWzGVTl2a06YxH+7fFQ/L9qvcyZ2USHjos7AUBOK1kRrcXAwpv2EwrwXtnsOSCyGUmI9BCbClTBR6kC8ar16IlLvfnU2rBHVQtnmdJnognE+Z6Qy70y2hVVoUNKf6q2JV8LwVL+Vi+cN34IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adsfQhiPrj+aTV76rSkZICINOWHfalUb19qZk4h9m1c=;
 b=adWjLtmsgSM0avuDG2r86ta1+FcxIiVaHiTqslMyhPTHdj/6JEY7fy2yRpSlu4vo891aMTfDgUgfH6RAQPPZHv1U6p2CgQAVMVZ4RetT8yzNjNx5l01QmAFtV8qOUGTjC76bia4x8BIwY1f3ilT5Lim1xyKJTTVOYaJe4uXoJvGJfk695plNKL1tqfRgz1fr4khX8M7NI5HARv7etUMPt6rXiSguatpTjt1lE6SKn2ig+xWmgMavMeWIK2rtwVbKi981+K6yO/kkN2WcJ3CLsZcRJWSziAp8C+a4rmfFfXNKWn/6BX2Dwg4lK/Ud1pT8+qrm9TFerlUuyYWEAoAZkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 11:30:45 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 11:30:45 +0000
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
	mgurtovoy@nvidia.com
Subject: [PATCH v14 02/20] netlink: add new family to manage ULP_DDP enablement and stats
Date: Wed,  6 Sep 2023 11:30:00 +0000
Message-Id: <20230906113018.2856-3-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906113018.2856-1-aaptel@nvidia.com>
References: <20230906113018.2856-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::13) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|MN0PR12MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: 03e6af81-9813-4895-815e-08dbaeccb62b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7vZ9QcgO8XYoQunY3/F6NffbY19VkNDlsjfulx9JrIqcZWkPNFl5Sob+pTKscDReYnJlWosH/mYN2adeAKarJ2g/nT59UlQuS64WKiZ5shGoT0kI8dRL/BL2z2NUAwhGnbOClmBD9ls1M+nbmt9FpEXq0Obm5DURBPaXkGMakUfGqw2qhU+OgaSjgyzZ2/c+4ABRkf+wnKbOGec8BeZuBmVR7kRlKQIfqnM8RtrqTpzGgJ5BQT/8iYkp33TOUhkULT9xrRT7MOT4UgiTFtlo6rTct14qvzlFQ/GZLzZxm9SRKQzmiXZbMe0hfh6fjl4m1vdkB4uXZ7Z5kEs8ypbxut0qYwr4OAUx8DXIu8qOTSg8QyTwy02+u31B8MnLLfWsgTJ1H7tgqOOCHD+nzEntwidk3miifVJoKjXt0gLbo4T9Deuyn+KOeadg5eD8Ptq8Phho6f5ukT3eoF3UGbG6k0bDI6PC4y/fuMvX9LorTlYD0UAXrEhX4crUNjq78Vs/Bxx9anLWrnxcuT5iN5oeZmlPHZO9JLLLbZ2W2VI6/yMyugLpoxQbNJvRrK/5xJU1R25Ctwg3BoBfwdKeZMrvVuTVg50VKvxG6V6Ert0bVU/9u5G9I2LtaQcshdFwxdaf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199024)(1800799009)(186009)(2616005)(1076003)(8936002)(66556008)(316002)(8676002)(66946007)(107886003)(66476007)(4326008)(6486002)(6506007)(6512007)(41300700001)(478600001)(7416002)(26005)(83380400001)(5660300002)(6666004)(30864003)(2906002)(86362001)(36756003)(38100700002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zQmpox1P3ratajzulUykXDhEz9ecDo9BR9TqNHiS/7LD6w6M4PYlCe9mxO3W?=
 =?us-ascii?Q?+FbMi7kDlesd6fZxi6RNaqL9A/91tQ+ZDGJQ56OnrbCbFV3De7tRMWY2NvCA?=
 =?us-ascii?Q?GGfOtkr4JdUPEio0hu8dvXuYbpghk3a5nDGVnaCjMaXJakrgx8ftr7394BVv?=
 =?us-ascii?Q?VJHqgsmx+cMD5x4BO5qY/BpoE6VMIx2auWBCi3jUDwglcRN/ii39P+2bgCZn?=
 =?us-ascii?Q?YwsB0HALv8W4E4dXaSOrK3IdwZKN+c7PCP4j+hQJJhKHBDOfqVF5pTQURbuG?=
 =?us-ascii?Q?k0SvtoV/EeML68DQyGSu7CcugSgIEW8v8GpdhjTPzSeP3ezssw8HaLc5Lnbr?=
 =?us-ascii?Q?9NlgjytD8BTH4kp2cakfmE5/+xGXk6FTkb2f7ga4OBfZfCUWxXPtr3Et8zcL?=
 =?us-ascii?Q?vsxCPrzV5yjJqvVzQEBdErrpm1rIBvNJifSDOQZikHdSV/HYXC8xFPkF2l5+?=
 =?us-ascii?Q?KLxz8w4xeYuicTSd3UZ2+UB6gEiTP9tNnuW+oFPSQD4nQmtNz2vT8xC0ECFI?=
 =?us-ascii?Q?PBg4REdHTW61ihYoNc4tMMSwJWrxmGOPOATxX35EpBdvtepdusKhPd1A9ceN?=
 =?us-ascii?Q?opKX7ixuZvnCMlcPQOSbXdAQO8i8X/BHDO4cYymNJJ3mVf/g6a6dH6ZhOxiU?=
 =?us-ascii?Q?y8C/5rgUHBWiO2vhThuQRzwX2emjyTwJU9TdiaILntJROTZ6+wkIsxXd2qc7?=
 =?us-ascii?Q?kH6clKI1BHIl4UFtzzTX9iyvff9LJyzJ3ANwYrMGDu8MDB+UawT85ijfhzl7?=
 =?us-ascii?Q?/90YsN3QMNB0MLXClBTWBj0NQfPrpvdghfEDhQNsXGrSLK18hjbyNa6LGYRd?=
 =?us-ascii?Q?g5bzYoe37BC9eMyTDaPmYO3h6AT7vAdUZW0xJrh4aDLqe85iw4xesxjECGSB?=
 =?us-ascii?Q?olaGgJbFmFo4WwwT8RQfh2DtK5RZ9NQr5JSEKl5+FnmjbjnffhZZiQINoX+U?=
 =?us-ascii?Q?ECxnZIHXk9LrxsTRKRniAqz0pN0ZhwbJOK9rtqEnAtjGmMXIMtSbNsH8M7j9?=
 =?us-ascii?Q?EDsA1hsnLN8Ips6WTvCVvyP+sXPCoiUGFFYSMd4UUHZDtLhK8haj0M2I6MX4?=
 =?us-ascii?Q?nHbF/fjzLxhMCNSPioUvb32LwxikvPRArciQXD2LNABZNaec88kqnhInq0Z0?=
 =?us-ascii?Q?Qz7zT+9NrbtWe7xpclOft/MunqyYXsoiK/sQzlBvqnvpEzN35vNskGiYYJu1?=
 =?us-ascii?Q?KpG2duRQSp6O2tsNf3/mSaCFSv3LwhnF5vfrdJIWbxoju331ljsvKmu9sX4U?=
 =?us-ascii?Q?64OdJ+7VLhUtgI36oL0t/CfFJIvzlJnoZtCyWpXgJLelevx0kmYp9BskK574?=
 =?us-ascii?Q?obw1OiFf9OSU4J3RuJ1g6ZUi7MZALI8CKOTkI4D+hmRXx18fjYLqFCMbyAgG?=
 =?us-ascii?Q?8aUv74wWgaKG2t9Ovk9QvwXkLV0EyikKkJjtaMw3L8AVN3yYngsq7eCGqAc7?=
 =?us-ascii?Q?Q3hW21pbtlPCqX8P8VqqkoiU5kIHJlI58ftFL9fMAazDeW2pyWYGWzov3VYO?=
 =?us-ascii?Q?H7d6WTOzkN6zI/MBXs0yo61F+hXIIfaxnRAe2BKRxfYlYNMeLTInnLk7DXw7?=
 =?us-ascii?Q?4IVe2VPOgg4DqjFYGdwCW50BaO9yo6VrC8uAdvOu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e6af81-9813-4895-815e-08dbaeccb62b
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 11:30:45.7945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pJsIqnR72fpgIMI2UxkW97nXBMfK6S8tQvDxbJKNN8OOhufqAzxFy1Uy7c+hGGgs6mzf5dusiJ10I6hizqyuhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6222
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
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
 Documentation/netlink/specs/ulp_ddp.yaml | 175 ++++++++++++
 include/uapi/linux/ulp_ddp_nl.h          |  59 ++++
 net/core/Makefile                        |   2 +-
 net/core/ulp_ddp_gen_nl.c                |  75 +++++
 net/core/ulp_ddp_gen_nl.h                |  30 ++
 net/core/ulp_ddp_nl.c                    | 343 +++++++++++++++++++++++
 6 files changed, 683 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/netlink/specs/ulp_ddp.yaml
 create mode 100644 include/uapi/linux/ulp_ddp_nl.h
 create mode 100644 net/core/ulp_ddp_gen_nl.c
 create mode 100644 net/core/ulp_ddp_gen_nl.h
 create mode 100644 net/core/ulp_ddp_nl.c

diff --git a/Documentation/netlink/specs/ulp_ddp.yaml b/Documentation/netlink/specs/ulp_ddp.yaml
new file mode 100644
index 000000000000..89df10e25295
--- /dev/null
+++ b/Documentation/netlink/specs/ulp_ddp.yaml
@@ -0,0 +1,175 @@
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
+        name: rx-nvmeotcp-ddp-setup
+        doc: NVMe-TCP IOs successfully configured for Rx Direct Data Placement.
+        type: u64
+      -
+        name: rx-nvmeotcp-ddp-setup-fail
+        doc: NVMe-TCP IOs failed to be configured for Rx Direct Data Placement.
+        type: u64
+      -
+        name: rx-nvmeotcp-ddp-teardown
+        doc: NVMe-TCP IOs with Rx Direct Data Placement configuration removed.
+        type: u64
+      -
+        name: rx-nvmeotcp-ddp-drop
+        doc: Packets failed the NVMeTCP offload validation.
+        type: u64
+      -
+        name: rx-nvmeotcp-ddp-resync
+        doc: NVMe-TCP resync operations were processed due to Rx TCP packets re-ordering.
+        type: u64
+      -
+        name: rx-nvmeotcp-ddp-packets
+        doc: TCP packets successfully processed by the NVMeTCP offload.
+        type: u64
+      -
+        name: rx-nvmeotcp-ddp-bytes
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
+        doc: new active bit values of the capabilities we want to set on the device.
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
+        reply:
+          attributes:
+            - ifindex
+            - hw
+            - active
+        pre: ulp_ddp_get_netdev
+        post: ulp_ddp_put_netdev
+    -
+      name: stats
+      doc: Get ULP DDP stats.
+      attribute-set: stat
+      do:
+        request:
+          attributes:
+            - ifindex
+        reply:
+          attributes:
+            - ifindex
+            - rx-nvmeotcp-sk-add
+            - rx-nvmeotcp-sk-add-fail
+            - rx-nvmeotcp-sk-del
+            - rx-nvmeotcp-ddp-setup
+            - rx-nvmeotcp-ddp-setup-fail
+            - rx-nvmeotcp-ddp-teardown
+            - rx-nvmeotcp-ddp-drop
+            - rx-nvmeotcp-ddp-resync
+            - rx-nvmeotcp-ddp-packets
+            - rx-nvmeotcp-ddp-bytes
+        pre: ulp_ddp_get_netdev
+        post: ulp_ddp_put_netdev
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
index 000000000000..4e09cb571c6a
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
+	ULP_DDP_A_STAT_RX_NVMEOTCP_DDP_SETUP,
+	ULP_DDP_A_STAT_RX_NVMEOTCP_DDP_SETUP_FAIL,
+	ULP_DDP_A_STAT_RX_NVMEOTCP_DDP_TEARDOWN,
+	ULP_DDP_A_STAT_RX_NVMEOTCP_DDP_DROP,
+	ULP_DDP_A_STAT_RX_NVMEOTCP_DDP_RESYNC,
+	ULP_DDP_A_STAT_RX_NVMEOTCP_DDP_PACKETS,
+	ULP_DDP_A_STAT_RX_NVMEOTCP_DDP_BYTES,
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
index 000000000000..e56b12d0ca24
--- /dev/null
+++ b/net/core/ulp_ddp_gen_nl.c
@@ -0,0 +1,75 @@
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
+		.cmd		= ULP_DDP_CMD_STATS,
+		.pre_doit	= ulp_ddp_get_netdev,
+		.doit		= ulp_ddp_nl_stats_doit,
+		.post_doit	= ulp_ddp_put_netdev,
+		.policy		= ulp_ddp_stats_nl_policy,
+		.maxattr	= ULP_DDP_A_STAT_IFINDEX,
+		.flags		= GENL_CMD_CAP_DO,
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
index 000000000000..fc3be4d155ba
--- /dev/null
+++ b/net/core/ulp_ddp_gen_nl.h
@@ -0,0 +1,30 @@
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
+int ulp_ddp_nl_stats_doit(struct sk_buff *skb, struct genl_info *info);
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
index 000000000000..d6f17d738203
--- /dev/null
+++ b/net/core/ulp_ddp_nl.c
@@ -0,0 +1,343 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ulp_ddp.c
+ *     Author: Aurelien Aptel <aaptel@nvidia.com>
+ *     Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
+ */
+#include <net/ulp_ddp.h>
+#include "ulp_ddp_gen_nl.h"
+
+#define ULP_DDP_STATS_CNT (sizeof(struct netlink_ulp_ddp_stats) / sizeof(u64))
+
+static struct ulp_ddp_netdev_caps *netdev_ulp_ddp_caps(struct net_device *dev)
+{
+#ifdef CONFIG_ULP_DDP
+	return &dev->ulp_ddp_caps;
+#else
+	return NULL;
+#endif
+}
+
+static const struct ulp_ddp_dev_ops *netdev_ulp_ddp_ops(struct net_device *dev)
+{
+#ifdef CONFIG_ULP_DDP
+	return dev->netdev_ops->ulp_ddp_ops;
+#else
+	return NULL;
+#endif
+}
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
+
+	if (!data->dev) {
+		kfree(data);
+		return -EINVAL;
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
+static int prepare_data(struct genl_info *info, struct reply_data *data, int cmd)
+{
+	const struct ulp_ddp_dev_ops *ops = netdev_ulp_ddp_ops(data->dev);
+	struct ulp_ddp_netdev_caps *caps = netdev_ulp_ddp_caps(data->dev);
+
+	if (!caps || !ops)
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
+		     u32 portid, u32 seq, int flags)
+{
+	u64 *val = (u64 *)&data->stats;
+	int attr, i;
+
+	data->hdr = genlmsg_put(rsp, portid, seq, &ulp_ddp_nl_family, flags, cmd);
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
+	ret = prepare_data(info, data, ULP_DDP_CMD_GET);
+	if (ret)
+		return ret;
+
+	rsp = genlmsg_new(reply_size(ULP_DDP_CMD_GET), GFP_KERNEL);
+	if (!rsp)
+		return -EMSGSIZE;
+
+	ret = fill_data(rsp, data, ULP_DDP_CMD_GET, info->snd_portid, info->snd_seq, 0);
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
+void ulp_ddp_nl_notify_dev(struct reply_data *data)
+{
+	struct sk_buff *ntf;
+
+	if (!genl_has_listeners(&ulp_ddp_nl_family, dev_net(data->dev),
+				ULP_DDP_NLGRP_MGMT))
+		return;
+
+	ntf = genlmsg_new(reply_size(ULP_DDP_CMD_GET), GFP_KERNEL);
+	if (!ntf)
+		return;
+
+	if (fill_data(ntf, data, ULP_DDP_CMD_SET_NTF, 0, 0, 0)) {
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
+	caps = netdev_ulp_ddp_caps(data->dev);
+	ops = netdev_ulp_ddp_ops(data->dev);
+
+	if (!ops || !caps)
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
+		return ret;
+
+	notify = !!ret;
+	ret = prepare_data(info, data, ULP_DDP_CMD_SET);
+	if (ret)
+		return ret;
+
+	ret = fill_data(rsp, data, ULP_DDP_CMD_SET, info->snd_portid, info->snd_seq, 0);
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
+int ulp_ddp_nl_stats_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct reply_data *data = info->user_ptr[0];
+	struct sk_buff *rsp;
+	int ret = 0;
+
+	ret = prepare_data(info, data, ULP_DDP_CMD_STATS);
+	if (ret)
+		return ret;
+
+	rsp = genlmsg_new(reply_size(ULP_DDP_CMD_STATS), GFP_KERNEL);
+	if (!rsp)
+		return -EMSGSIZE;
+
+	ret = fill_data(rsp, data, ULP_DDP_CMD_STATS, info->snd_portid, info->snd_seq, 0);
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


