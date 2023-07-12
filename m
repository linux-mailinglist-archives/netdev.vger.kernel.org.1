Return-Path: <netdev+bounces-17233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15925750E2D
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 18:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEDDF2810BE
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 16:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D6314F7E;
	Wed, 12 Jul 2023 16:16:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7201721500
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 16:16:52 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2068.outbound.protection.outlook.com [40.107.95.68])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFB12101
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 09:16:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1pQ74zEDCjO1dVm46I9yjIB62B34CwlVmQs5M5leKJAg5YHlcL5cagsnYRvEOkY+PORUHdL3WrIAKPnHM1BaDBhs9PO5VV2EgVoFufofkhjLlOM8lX+M6GnTt6y5+rE6+RjvOueVadpi0PL9SHVhGc/L6VZ/bWhE3I+HWO5StFWiHB0EvrjE1jdDop1jRtA4ziTdxH9LMtdmAs71bonuC3DUzXDtDpwrFHd2THvCWL1StEf1/DoZor5Lil1nS4UCQFrQhkVwVB1IdVCphi/YnEPT/A9TfgYv2xyKwctpLnolLMM0uDfck6Efv/wqMHXWcbVa5TYk8bDTur8+Lcydw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tY2LHmXVjq6Iqi2cmYI7gvya1ZoMhI31x7920936aA0=;
 b=LYaZ7KPrSN1MgqcTPdI7lrKpr2CUK4xUM8k8rMmxWTggXz3j+caZF7o0ERi6wwkHl56a2UzyZGAK//1bXdToLGjHw9bM73fyLkpE2887e7Ie7UgLT38xts/RvMKGoY89K66ErTp9mc09HufouL9EGleaZzQ33BHJ695J0LIIcpj1NYoe6lbuhmRDSRIKKa/oLW9PwzSzYblTt1D1dBpa6qJDdHMbE2TdmKaMCbbAfwVMWnaaYbPveTErKj9sW0cnCeXNcJNkP5EOmXX2l5OcuCTAY3LXZ0ENe83VFtRzcf3f8zTgJpDMJ9gJQiTYR4F7AhZaZmMF0jSbw/VVbvR8jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tY2LHmXVjq6Iqi2cmYI7gvya1ZoMhI31x7920936aA0=;
 b=VExm5olKt2JjFPpMseh3J3hlagJLS6Fb0thWvzgyeF+d2ahMUNF1pUcT7rbbvBQ0jwc/ibkSIwfKf7c6jzScwrvVPcEG/cZL0JhIGNhvr56NZ7OFdLPDf0BFhyxGwDLDYAW+aGrQUtVemI10tMrkOvWZHKM0VE5KBumq72eDjJYpAVETMTPJxschuc/tY39X5/NIadz/HGG7rHPg93LhaICvwIdkZCKFhdveyLEXJTW7AY/HZWiulaMTLFOIlpNxzrkNLO4+mWTNb6+1fs8IYgVjd89ylJhMcBXNQWL8Z8sCGz/sI5kvJm6cIKQfZ/pvYSA5vkUs0udT+VFhXrmTrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH7PR12MB7212.namprd12.prod.outlook.com (2603:10b6:510:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 16:16:47 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3f6a:7977:dcd4:9ad1]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3f6a:7977:dcd4:9ad1%4]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 16:16:47 +0000
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
Subject: [PATCH v12 04/26] Documentation: document netlink ULP_DDP_GET/SET messages
Date: Wed, 12 Jul 2023 16:14:51 +0000
Message-Id: <20230712161513.134860-5-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712161513.134860-1-aaptel@nvidia.com>
References: <20230712161513.134860-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0090.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::15) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH7PR12MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bbbeb68-3985-475d-ae08-08db82f3642f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Be55JZyE/0qr5NcK1YrY1maItSM2ZAylt8L26mJ2NY9PXyT1tXkywnCsADaNdTYjg6wMU5MbuxB9r2S+aaYBEZ2Woclg78EJbd1NXYFIbf3FxSYuc1UT1OOVmhkKZ6/fgPcNZS3VcLBUaA1DB+j9+sQn6pHYKspR+ZdObtsq81AW081SnKJlWFK6cl8c4SOSu5+dupOMtjC0kZuN0ZZIPywi0kK/x1IEnqYPdxPBw/7flZvgc69xvkLAZchT2Z7FPUF2zBLlGeins0GHI73hLNcBSwOwIJtjCk9SsBnUQRdk3qYdvGV04W971bkN7Ry1LS5EU2UuiyGBm26gAyxMpemd7aaRJ/tb5lu62rZcj2xU24wRMdAgsOGoP4ZHFRB16JgzBwDYGR76eXSjstzGwwqozvXintxUPi1dbFSg3L6PzUqkjAeIzpyqzfgbJjfJjHzsiV4sqGpH6Ypcr7Rvyq1q1wlw2Ac8JbTz31pzmFU/6fgc1UveMdcP/kPDNFkkkifE2tTzmbRUtgYCYWDR2+X29QRm+nuIi5E+upMjl9bNLO3/7YyReQuTo/elV4N3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199021)(186003)(2616005)(86362001)(66476007)(66946007)(66556008)(316002)(83380400001)(107886003)(4326008)(6512007)(1076003)(26005)(6506007)(478600001)(2906002)(6486002)(36756003)(15650500001)(6666004)(38100700002)(41300700001)(7416002)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZBvQ49Ht9AH3LNsFTeIj7QPVofjMsqEv6YoK3wd7MruJCB63lKu7dwJ40P0f?=
 =?us-ascii?Q?8KHL//alDFvw3/C2UBAdg2kLVJ7SReC7ui/N434MJJuHq3k+QXVNgevLnOmn?=
 =?us-ascii?Q?42GJkvKwNyafd3ZhOnOhEiDpWvC7JJDdQUqNZgLjtG59y1M/ygUujlFndNTf?=
 =?us-ascii?Q?y/JmoQGdMajbenfdWLwd4udDLH7/ocdHwlAGUu6bJ+p5aEfGJDB17RMF5bRV?=
 =?us-ascii?Q?14o7sMSk9w7/suP4PyWfpWW5xmexPMTtR5jI+XuzlXEpBdRmeNMpQGwVpL+5?=
 =?us-ascii?Q?PpdiZqnenv2OhH0A00RhOTHPBxry3UoGgXJmFtQeRk/1HXWrPAVY+rtEnaEY?=
 =?us-ascii?Q?5cKvuRu4yjitZfZMvitHGuZOhUYRBrQQT5uQtotFSrLxzCXJvaB8VSqXrHBk?=
 =?us-ascii?Q?csNmvbXXkRxi9oEaZp5+E/2IWyD1teNVKYzN42jIxulpbesnJkNpG7e8LFto?=
 =?us-ascii?Q?bSaAtU+kJazFLNqup0uhKEO5dB7vzgr5pFw63YgIa9HUibel5iapsG5GemT3?=
 =?us-ascii?Q?+VRTO/vh7Hm2riMh2cN3+ILSYSIohN7EyXcdvk9A3+u1ePYO6IJ6FO9nsJHY?=
 =?us-ascii?Q?eU3jn8Ow6nlmLPND5fhRoxM53GYr9vTBhJwmkf4krZc8zVutpDHp702+AGML?=
 =?us-ascii?Q?oaDc9u71D8F6TeKA6rMibEELTMQs7MN6jKmhOumtHTjL9hYg6xcyN5HGgSwj?=
 =?us-ascii?Q?pHfTX+/HUU8Syr2o0tf9tNmFNXTeEZs1h+2rEByWhHXojiNd49q1QIhKuATU?=
 =?us-ascii?Q?MKmY6qDtTYOsQLPzqsSUbvmX6uWpnNGhFCXB+gby5PMkiCelbLdFDC3I8syl?=
 =?us-ascii?Q?rQy6qoiHfWMUNRTt1O/EuWLVMNC6VUHnMhQB17gP280eMl3echY9e6O6/VTL?=
 =?us-ascii?Q?BaDNdZ5tYjoFtEVq1g9hhGrAhJY3iIRV6K1sauKkgAZT4xgB8cRHKkmtlJzL?=
 =?us-ascii?Q?W8EYq7cCv9H3/OBcJYL3YAsxi+rQagYxM3PLZnU+C2Hqnzw7Qy8eVa33htF9?=
 =?us-ascii?Q?TbKp0q4T1+RVl0z3ZykiHYgMagGDoziqEKq9bcxnW28mX6xSrbP5LwEwyGMp?=
 =?us-ascii?Q?n74ggOvFtV27qdXy2SIllJ7Zh4qZtt9wSO8Yan5Vx2mLUqzMGjrZj51yNNy8?=
 =?us-ascii?Q?Ee4yGR8FUx+YZh2N4TsEDHumQ+pDoC6wo/CO8G6KR1eFbvPzGDKIU94te6ei?=
 =?us-ascii?Q?Uj5FKnegYk/O5t8b2VpmfpcgloXqJtnf5FBXAcKz9UdZxq0FyU56vsYzM7ep?=
 =?us-ascii?Q?t6P94hgNRpQSGjkblx+t9rmoRGDZFOZa0Oo9zNP8LrD+HDHfHI+JDGRxCpY5?=
 =?us-ascii?Q?NzWZyWGcLSg6MXYshVYws/PAuYvYA2VHdD1mBan2tIdOj2dV+eDjF6e6k6dC?=
 =?us-ascii?Q?630FxY2YlZ+eTf+dyhj55cD3VWCEbAdxS9nEDsjFxKxdj2NF9M/9FSDhIwJ7?=
 =?us-ascii?Q?LBtzT63qACi4oSKBZDk0AQlHtLLKUoWvXczu7aSJo6Zxl7enU3R1Q2oC5L/4?=
 =?us-ascii?Q?onGPzgNm88/7dp1MV7FYPUehvW870JsG56/JpgjlXUoDiD/UzH2ZAx/O1p20?=
 =?us-ascii?Q?ZgBsnAGC/O4MERoccDsVlpvZsJffccR7QhcxXYPR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bbbeb68-3985-475d-ae08-08db82f3642f
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 16:16:47.7156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0WXIqfCT2OQ+dX2y4BSp0ecz4f1IqFXR1KeleRsoR9MYrQRfXDVCJpIbzZ6rgvNJ2QqzoOMKsBVLSRNP5egj/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7212
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add detailed documentation about:
- ETHTOOL_MSG_ULP_DDP_GET and ETHTOOL_MSG_ULP_DDP_SET netlink messages
- ETH_SS_ULP_DDP_CAPS and ETH_SS_ULP_DDP_STATS stringsets

ETHTOOL_MSG_ULP_DDP_GET/SET messages are used to configure ULP DDP
capabilities and retrieve ULP DDP statistics.

Both statistics and capabilities names can be retrieved dynamically
from the kernel via string sets (no need to hardcode them and keep
them in sync in ethtool).

Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
---
 Documentation/netlink/specs/ethtool.yaml     | 102 +++++++++++++++++++
 Documentation/networking/ethtool-netlink.rst |  92 +++++++++++++++++
 Documentation/networking/statistics.rst      |   1 +
 3 files changed, 195 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 837b565577ca..65114e28a4ad 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -377,6 +377,67 @@ attribute-sets:
         name: nochange
         type: nest
         nested-attributes: bitset
+  -
+    name: ulp-ddp-stat
+    attributes:
+      -
+        name: pad
+        value: 1
+        type: pad
+      -
+        name: rx-nvmeotcp-sk-add
+        type: u64
+      -
+        name: rx-nvmeotcp-sk-add-fail
+        type: u64
+      -
+        name: rx-nvmeotcp-sk-del
+        type: u64
+      -
+        name: rx-nvmeotcp-ddp-setup
+        type: u64
+      -
+        name: rx-nvmeotcp-ddp-setup-fail
+        type: u64
+      -
+        name: rx-nvmeotcp-ddp-teardown
+        type: u64
+      -
+        name: rx-nvmeotcp-ddp-drop
+        type: u64
+      -
+        name: rx-nvmeotcp-ddp-resync
+        type: u64
+      -
+        name: rx-nvmeotcp-ddp-packets
+        type: u64
+      -
+        name: rx-nvmeotcp-ddp-bytes
+        type: u64
+  -
+    name: ulp-ddp
+    attributes:
+      -
+        name: header
+        value: 1
+        type: nest
+        nested-attributes: header
+      -
+        name: hw
+        type: nest
+        nested-attributes: bitset
+      -
+        name: active
+        type: nest
+        nested-attributes: bitset
+      -
+        name: wanted
+        type: nest
+        nested-attributes: bitset
+      -
+        name: stats
+        type: nest
+        nested-attributes: ulp-ddp-stat
   -
     name: channels
     attributes:
@@ -1692,3 +1753,44 @@ operations:
       name: mm-ntf
       doc: Notification for change in MAC Merge configuration.
       notify: mm-get
+    -
+      name: ulp-ddp-get
+      doc: Get ULP DDP capabilities and stats.
+
+      attribute-set: ulp-ddp
+
+      do: &ulp-ddp-get-op
+        request:
+          value: 44
+          attributes:
+            - header
+        reply:
+          value: 44
+          attributes:
+            - header
+            - hw
+            - active
+            - stats
+      dump: *ulp-ddp-get-op
+    -
+      name: ulp-ddp-set
+      doc: Set ULP DDP capabilities.
+
+      attribute-set: ulp-ddp
+
+      do:
+        request:
+          value: 45
+          attributes:
+            - header
+            - wanted
+        reply:
+          value: 45
+          attributes:
+            - header
+            - hw
+            - active
+    -
+      name: ulp-ddp-ntf
+      doc: Notification for change in ULP DDP capabilities.
+      notify: ulp-ddp-get
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 2540c70952ff..8ffca8ae9bbd 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -225,6 +225,8 @@ Userspace to kernel:
   ``ETHTOOL_MSG_RSS_GET``               get RSS settings
   ``ETHTOOL_MSG_MM_GET``                get MAC merge layer state
   ``ETHTOOL_MSG_MM_SET``                set MAC merge layer parameters
+  ``ETHTOOL_MSG_ULP_DDP_GET``           get ULP DDP capabilities and stats
+  ``ETHTOOL_MSG_ULP_DDP_SET``           set ULP DDP capabilities
   ===================================== =================================
 
 Kernel to userspace:
@@ -268,6 +270,9 @@ Kernel to userspace:
   ``ETHTOOL_MSG_PSE_GET_REPLY``            PSE parameters
   ``ETHTOOL_MSG_RSS_GET_REPLY``            RSS settings
   ``ETHTOOL_MSG_MM_GET_REPLY``             MAC merge layer status
+  ``ETHTOOL_MSG_ULP_DDP_GET_REPLY``        ULP DDP capabilities and stats
+  ``ETHTOOL_MSG_ULP_DDP_SET_REPLY``        optional reply to ULP_DDP_SET
+  ``ETHTOOL_MSG_ULP_DDP_NTF``              ULP DDP capabilities notification
   ======================================== =================================
 
 ``GET`` requests are sent by userspace applications to retrieve device
@@ -1994,6 +1999,93 @@ The attributes are propagated to the driver through the following structure:
 .. kernel-doc:: include/linux/ethtool.h
     :identifiers: ethtool_mm_cfg
 
+ULP_DDP_GET
+===========
+
+Get ULP DDP capabilities for the interface and optional driver-defined stats.
+
+Request contents:
+
+  ====================================  ======  ==========================
+  ``ETHTOOL_A_ULP_DDP_HEADER``          nested  request header
+  ====================================  ======  ==========================
+
+Kernel response contents:
+
+  ====================================  ======  ==========================
+  ``ETHTOOL_A_ULP_DDP_HEADER``          nested  reply header
+  ``ETHTOOL_A_ULP_DDP_HW``              bitset  dev->ulp_ddp_caps.hw
+  ``ETHTOOL_A_ULP_DDP_ACTIVE``          bitset  dev->ulp_ddp_caps.active
+  ``ETHTOOL_A_ULP_DDP_STATS``           nested  ULP DDP statistics
+  ====================================  ======  ==========================
+
+
+* If ``ETHTOOL_FLAG_COMPACT_BITSETS`` was set in
+  ``ETHTOOL_A_HEADER_FLAG``, the bitsets of the reply are in compact
+  form. In that form, the names for the individual bits can be retrieved
+  via the ``ETH_SS_ULP_DDP_CAPS`` string set.
+* ``ETHTOOL_A_ULP_DDP_STATS`` contains statistics which
+  are only reported if ``ETHTOOL_FLAG_STATS`` was set in
+  ``ETHTOOL_A_HEADER_FLAGS``.
+
+ULP DDP statistics content:
+
+  =====================================================  ===  ===============
+  ``ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_SK_ADD``         u64  sockets successfully prepared for offloading
+  ``ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_SK_ADD_FAIL``    u64  sockets that failed to be prepared for offloading
+  ``ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_SK_DEL``         u64  sockets where offloading has been removed
+  ``ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_DDP_SETUP``      u64  PDUs successfully prepared for Direct Data Placement
+  ``ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_DDP_SETUP_FAIL`` u64  PDUs that failed DDP preparation
+  ``ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_DDP_TEARDOWN``   u64  PDUs done with DDP
+  ``ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_DROP``           u64  PDUs dropped
+  ``ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_RESYNC``         u64  resync
+  ``ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_PACKETS``        u64  offloaded PDUs
+  ``ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_BYTES``          u64  offloaded bytes
+  =====================================================  ===  ===============
+
+The names of each statistics are global. They can be retrieved via the
+``ETH_SS_ULP_DDP_STATS`` string set.
+
+ULP_DDP_SET
+===========
+
+Request to set ULP DDP capabilities for the interface.
+
+Request contents:
+
+  ====================================  ======  ==========================
+  ``ETHTOOL_A_ULP_DDP_HEADER``          nested  request header
+  ``ETHTOOL_A_ULP_DDP_WANTED``          bitset  requested capabilities
+  ====================================  ======  ==========================
+
+Kernel response contents:
+
+  ====================================  ======  ==========================
+  ``ETHTOOL_A_ULP_DDP_HEADER``          nested  reply header
+  ``ETHTOOL_A_ULP_DDP_WANTED``          bitset  diff wanted vs. results
+  ``ETHTOOL_A_ULP_DDP_ACTIVE``          bitset  diff old vs. new active
+  ====================================  ======  ==========================
+
+Request contains only one bitset which can be either value/mask pair
+(request to change specific capabilities and leave the rest) or only a
+value (request to set the complete capabilities provided literally).
+
+Requests are subject to sanity checks by drivers so an optional kernel
+reply (can be suppressed by ``ETHTOOL_FLAG_OMIT_REPLY`` flag in
+request header) informs client about the actual
+results.
+
+* ``ETHTOOL_A_ULP_DDP_WANTED`` reports the difference between client
+  request and actual result: mask consists of bits which differ between
+  requested capability and result (dev->ulp_ddp_caps.active after the
+  operation), value consists of values of these bits in the request
+  (i.e. negated values from resulting capabilities).
+* ``ETHTOOL_A_ULP_DDP_ACTIVE`` reports the difference between old and
+  new dev->ulp_ddp_caps.active: mask consists of bits which have
+  changed, values are their values in new dev->ulp_ddp_caps.active
+  (after the operation).
+
+
 Request translation
 ===================
 
diff --git a/Documentation/networking/statistics.rst b/Documentation/networking/statistics.rst
index 551b3cc29a41..9997c5e8d34e 100644
--- a/Documentation/networking/statistics.rst
+++ b/Documentation/networking/statistics.rst
@@ -172,6 +172,7 @@ statistics are supported in the following commands:
   - `ETHTOOL_MSG_PAUSE_GET`
   - `ETHTOOL_MSG_FEC_GET`
   - `ETHTOOL_MSG_MM_GET`
+  - `ETHTOOL_MSG_ULP_DDP_GET`
 
 debugfs
 -------
-- 
2.34.1


