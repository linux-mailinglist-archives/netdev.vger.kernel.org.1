Return-Path: <netdev+bounces-59771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD9D81C03D
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 22:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D07DF1C24A3C
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 21:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6674C77644;
	Thu, 21 Dec 2023 21:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WA9LDtPo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBEA76DAE;
	Thu, 21 Dec 2023 21:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2k30LC907QX75Cj54LQ/ZJNRAy1xJO4W/VHLzgKcVxLVQdjCEiBXy8wOqeg+xEto0IQkpTXFGqYKvx22hwv0uSfLxvQivMRqvJHyTn2pJY1nHIXtMXP5VgXywjTfgLO+lsTEE9Znr0b7JRynyOWU/ScXvKXUpUjDMN5MCO9613r6hJ6ATFjPKK9/kXp2TCai4GyXqz6Ph2QFZz9lfelrTouLPueh1IQ/6F92psnYgMQhfYcuCnkF9Rjbx3u/x9CG3DfbUnxs6iDQQo1GA1dFFGAjKJMiDo/wXf6qrU2QMzhDve8ht2KUdsaiIOab1YPXLC5gr/JVY491BDLsj67fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qew/daOmlwygAr7NIsvtRVh0DAAynsd3qFyosp6weXM=;
 b=k8gFgDBeJMxDrT2Q6EW2lD9Mn6lKGydPljYCzxjJJGvKEN1E9N8Sp408dekGODHfETmHkPbp8iprYCaF8UNO8P1QB8wt6kbpSqqf7brvS9nZTTNg/ocPAHmi6Gh+eAaXiM7qwN8P8xPkOCOf7kwkmcmvEIx7Duvh9/z6S0z6YocBQnyzomVjarkszbRaCNWw2mIsEjKdSOxsYEK/5Q7xQLSqW8iK7uozq+g4my1hL0I0+nhqg2y7QbK29elXr6ZWxwJPFuyl30tOfWMqI8vJ+o8LVuoobuwD2rv+2WYJqQvErfqGOQi+lGvTeiwguz4QV/elJyXQat5xKpnDqNi9EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qew/daOmlwygAr7NIsvtRVh0DAAynsd3qFyosp6weXM=;
 b=WA9LDtPoxyiZtwIGc9xiZwN5EiA001LGuEjqZC5OnqX9mQB4f8SkLMB99GlCoy1KtFjCacvvNsIE0pvWLAshqtd5NPa9VLmb6qvBBI0keIPUz1SwTQOgXzLZYctNbs7LxFAfCWADi5ceF5niPmLFMCDHabSGcUooU1W9sZvqT0fpE/D8rpOpvNlrVkrsXKBse4WdrT40KFE1ufNWLztXm72ox4ciaGRpeg87Cl113eAMEH6J584Rci1B8lm7X2yySWcr5B7emlLotA+PXiRXh0/bqNENeIIw9JwuofygkArgYu2Yw7Gulx5wPsL5UCDIbvLG+a+Ur9CzVwP21g9bWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by MW4PR12MB7481.namprd12.prod.outlook.com (2603:10b6:303:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.19; Thu, 21 Dec
 2023 21:34:49 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 21:34:49 +0000
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
Cc: Yoray Zack <yorayz@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	linux-doc@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	corbet@lwn.net
Subject: [PATCH v22 09/20] Documentation: add ULP DDP offload documentation
Date: Thu, 21 Dec 2023 21:33:47 +0000
Message-Id: <20231221213358.105704-10-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221213358.105704-1-aaptel@nvidia.com>
References: <20231221213358.105704-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0031.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::20) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|MW4PR12MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: f72dc3d0-0f6c-4470-6000-08dc026ca8a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GssayZsPrut6TCH6ZoYICkuwR7SPiHgDpZgvRGDWAkCiPFp/GfaplD6H7+uZtsQY7eKxG/tKjgRhgxC2dQAg4zYgXnk7BHnosRe2nu0/4S5F+pSPtdC10DyxVJLMdzC6DSNje3AtkOzt6b0ygcGoTuWkRX+jYFwA5dqLKaLMPFNTEq+iMHmOX8vlQHm+8eIIkmwAyKwIMMzz+V5ZhEakGa/W+CL/rNV6lRlHq36ghPtCuZHvpMwNjG1h/CjcOYKO1EpCyuUFkx6pullTS0vT4Uvy1UHeOdmMcQKEuhl+fV5/PgIBFCaJzveKhjaVELfObopt5xZR1652iVr2FUm0ZcFYg6VZqW5hWO0DUtKd7JN7cgP3WsYV+ZdNx6KSVdTCwPg9dPCy+ESqraL+07efWCRzny9FRCLwqaak/qa7M2RD8gdt+U9YY7wJ6rfFvvQ6KZlSciwieoAJUIMKjuDSjfRgXF4ljaD5mVquA1Py10DgSbt3wz+/SreoVpRdrUuRyt5EwBtOBJaZIwq5BqZ3FDa3I/bLLr6F3TphPIoB9jPFhSykQw3/PtSeYe95HNyS1xPlKXD5NEjCCASh/cCfV8y/pKiYhuwEw9IHTsURoKw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(366004)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66946007)(8676002)(8936002)(66556008)(478600001)(66476007)(83380400001)(316002)(30864003)(7416002)(4326008)(6506007)(6512007)(6486002)(2906002)(2616005)(26005)(1076003)(41300700001)(36756003)(5660300002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xSZtJNm+FzUWU8juSULLw71HDLZwxrdxfEXj6uAcgEDjluS29dyUbXSmUjaU?=
 =?us-ascii?Q?GqgCiSf8eKKL8L1V/5mz7A5oeYw5YYMD67n9ZSp17L2VqLDOfJpP6t2+CA64?=
 =?us-ascii?Q?kD3SdvnvTFiblprCSk92E/BO9dvgMK/fUmvoJUv92P5zz7xS/X3puZt/EQwT?=
 =?us-ascii?Q?XZYfZAk5zabqmDFMFff7msDK3FZcdJGvh1Xx91g+qmALxhLH3uOakbrxoDNG?=
 =?us-ascii?Q?5saa9DixVqpGf/qgpcAmdOzvQLwclraqJUQ51WjYnqIftT2YuAW3SDLBr5O5?=
 =?us-ascii?Q?E13uBnviPjKB6A5RfOFFp92IRlgjmjVWqlaHInZeIRGA+0zIRE5huk3+MyJ6?=
 =?us-ascii?Q?Yb1mH6o7dDKiXuFPRbvqj2jcTqV2M4aqswSWhptDEZyC+6ZhQAPOT6jEelLU?=
 =?us-ascii?Q?WecJBwCdplMdndOCbDHzHagj7sEOn+FxAkCL5v4FBiicJuFZdpS6L6UnLHQK?=
 =?us-ascii?Q?04QQ6Rx/p2ACw81YJp/qJDSS1GVeTjqK/ZaluS+9bdGvyU633NcTXh7L/jTR?=
 =?us-ascii?Q?Ib3qe8Y0w/MhfOHYFHSiAX9AEzwKX3YKMTJ+jQXvrbhxI4bpn5+UjqxSNJHB?=
 =?us-ascii?Q?1uqSUOCp5hRTENk53oQOpH2RKh6ZnAVejJHaOpWNVD+Jv8VjYb8RgYtUOi9f?=
 =?us-ascii?Q?tlJYSywPXsooIk4qrZIDNa6A6x/Gid0rRqm91onumS6qXFe/gV/nK1vHjujR?=
 =?us-ascii?Q?WnQR9mKyviUz0ogILIdATzvls/kp7U3mXCJ2YeP9yYqBicX1XAIe/JSQM9MG?=
 =?us-ascii?Q?Oh8l3rfR8pM7M7EeRKKpAxZoIL0zkohFG+qO0IuOkPK3fEIk50/fzM1jsdzs?=
 =?us-ascii?Q?a2Uw4gtrPWj+DfePKflKUFBpaLQelu+n4C0YCND/SDZ0Sh39//Xh6+8NnFX8?=
 =?us-ascii?Q?4Ep9KbjnqWmg/z4uWM/YtI4eF6wOLWB7BQPcE//VMT5oTAy2ON3rJj0TWd7X?=
 =?us-ascii?Q?j9kxR1rGCl7bVuzEtOTZyG4EVhPNe91FAiD3rj+kiCmfQoRHp4BxBCmUyxMo?=
 =?us-ascii?Q?LkntyEQjY15iDiumcZ0eB192JvOPMaOfK3jR1Z+tjFC3wn2l1ginqUiY0uAi?=
 =?us-ascii?Q?WAZIHvON8y3DW3gjFvQV65jAzwXVqOhHnUvodUyYZY5dlF8iClDeVqd0YXjO?=
 =?us-ascii?Q?bXGGzXXoq1YJdk1Jlx9AooyrQ2NLvXDbqWzQf2xprf+dim/KrALQlEfa/SuP?=
 =?us-ascii?Q?GZldY5UEYRbMng11bUdTwyXw1NgEwBi4h8zonPHnC32GRo4s+mAUJr0mKwlw?=
 =?us-ascii?Q?qwYQXO+hSo2/JMpE50L0Re+hpPjkVGfp0KJQFYhR6AgffCLhHTLpPkadA4Uq?=
 =?us-ascii?Q?LROPJRkRE2nFvPib6aYkwIxYwx9DtuFYeb1tUnJEKeUI4lh0tXDixD7FnN6P?=
 =?us-ascii?Q?/rldY8o+n2vvZ1QnFml9PzgZRfVY3XA0KfOmhk+gADaeCVY1kQlqPG1jZEiC?=
 =?us-ascii?Q?Vh2kCkNIGa/OTMeyCWk8TZQiJ42oknyBJzptCuCr80+CvKqkJObXgtlTXEVM?=
 =?us-ascii?Q?9gYP5WMT+Me49oM35tyjioLa6RqYPXiRH94Fy9FSA87eRvQ3oh9FRi7AjtOp?=
 =?us-ascii?Q?KT4fx+XpalFPCl7u8srHBpiK0W5Xed6xAq/PdF53?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f72dc3d0-0f6c-4470-6000-08dc026ca8a1
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 21:34:48.9829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BmUFwqKvJik2LitKjwNTzvX+Dvt7WVa4LCCBLAweOd7PCB/9ZxXJxlSeqwimUkJhD+KVu1xrKr6Iip66GcSkmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7481

From: Yoray Zack <yorayz@nvidia.com>

Document the new ULP DDP API and add it under "networking".
Use NVMe-TCP implementation as an example.

Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
---
 Documentation/netlink/specs/ulp_ddp.yaml     |  12 +-
 Documentation/networking/index.rst           |   1 +
 Documentation/networking/ulp-ddp-offload.rst | 374 +++++++++++++++++++
 3 files changed, 381 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/networking/ulp-ddp-offload.rst

diff --git a/Documentation/netlink/specs/ulp_ddp.yaml b/Documentation/netlink/specs/ulp_ddp.yaml
index 7822aa60ae29..27a0b905ec28 100644
--- a/Documentation/netlink/specs/ulp_ddp.yaml
+++ b/Documentation/netlink/specs/ulp_ddp.yaml
@@ -26,7 +26,7 @@ attribute-sets:
     attributes:
       -
         name: ifindex
-        doc: interface index of the net device.
+        doc: Interface index of the net device.
         type: u32
       -
         name: rx-nvme-tcp-sk-add
@@ -75,31 +75,31 @@ attribute-sets:
     attributes:
       -
         name: ifindex
-        doc: interface index of the net device.
+        doc: Interface index of the net device.
         type: u32
       -
         name: hw
-        doc: bitmask of the capabilities supported by the device.
+        doc: Bitmask of the capabilities supported by the device.
         type: uint
         enum: cap
         enum-as-flags: true
       -
         name: active
-        doc: bitmask of the capabilities currently enabled on the device.
+        doc: Bitmask of the capabilities currently enabled on the device.
         type: uint
         enum: cap
         enum-as-flags: true
       -
         name: wanted
         doc: >
-          new active bit values of the capabilities we want to set on the
+          New active bit values of the capabilities we want to set on the
           device.
         type: uint
         enum: cap
         enum-as-flags: true
       -
         name: wanted_mask
-        doc: bitmask of the meaningful bits in the wanted field.
+        doc: Bitmask of the meaningful bits in the wanted field.
         type: uint
         enum: cap
         enum-as-flags: true
diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 69f3d6dcd9fd..2b96da09269f 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -110,6 +110,7 @@ Contents:
    tc-queue-filters
    tcp_ao
    tcp-thin
+   ulp-ddp-offload
    team
    timestamping
    tipc
diff --git a/Documentation/networking/ulp-ddp-offload.rst b/Documentation/networking/ulp-ddp-offload.rst
new file mode 100644
index 000000000000..438f060e9af4
--- /dev/null
+++ b/Documentation/networking/ulp-ddp-offload.rst
@@ -0,0 +1,374 @@
+.. SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+=================================
+ULP direct data placement offload
+=================================
+
+Overview
+========
+
+The Linux kernel ULP direct data placement (DDP) offload infrastructure
+provides tagged request-response protocols, such as NVMe-TCP, the ability to
+place response data directly in pre-registered buffers according to header
+tags. DDP is particularly useful for data-intensive pipelined protocols whose
+responses may be reordered.
+
+For example, in NVMe-TCP numerous read requests are sent together and each
+request is tagged using the PDU header CID field. Receiving servers process
+requests as fast as possible and sometimes responses for smaller requests
+bypasses responses to larger requests, e.g., 4KB reads bypass 1GB reads.
+Thereafter, clients correlate responses to requests using PDU header CID tags.
+The processing of each response requires copying data from SKBs to read
+request destination buffers; The offload avoids this copy. The offload is
+oblivious to destination buffers which can reside either in userspace
+(O_DIRECT) or in kernel pagecache.
+
+Request TCP byte-stream:
+
+.. parsed-literal::
+
+ +---------------+-------+---------------+-------+---------------+-------+
+ | PDU hdr CID=1 | Req 1 | PDU hdr CID=2 | Req 2 | PDU hdr CID=3 | Req 3 |
+ +---------------+-------+---------------+-------+---------------+-------+
+
+Response TCP byte-stream:
+
+.. parsed-literal::
+
+ +---------------+--------+---------------+--------+---------------+--------+
+ | PDU hdr CID=2 | Resp 2 | PDU hdr CID=3 | Resp 3 | PDU hdr CID=1 | Resp 1 |
+ +---------------+--------+---------------+--------+---------------+--------+
+
+The driver builds SKB page fragments that point to destination buffers.
+Consequently, SKBs represent the original data on the wire, which enables
+*transparent* inter-operation with the network stack. To avoid copies between
+SKBs and destination buffers, the layer-5 protocol (L5P) will check
+``if (src == dst)`` for SKB page fragments, success indicates that data is
+already placed there by NIC hardware and copy should be skipped.
+
+In addition, L5P might have DDGST which ensures data integrity over
+the network.  If not offloaded, ULP DDP might not be efficient as L5P
+will need to go over the data and calculate it by itself, cancelling
+out the benefits of the DDP copy skip.  ULP DDP has support for Rx/Tx
+DDGST offload. On the received side the NIC will verify DDGST for
+received PDUs and update SKB->ulp_ddp and SKB->ulp_crc bits.  If all the SKBs
+making up a L5P PDU have crc on, L5P will skip on calculating and
+verifying the DDGST for the corresponding PDU. On the Tx side, the NIC
+will be responsible for calculating and filling the DDGST fields in
+the sent PDUs.
+
+Offloading does require NIC hardware to track L5P protocol framing, similarly
+to RX TLS offload (see Documentation/networking/tls-offload.rst).  NIC hardware
+will parse PDU headers, extract fields such as operation type, length, tag
+identifier, etc. and only offload segments that correspond to tags registered
+with the NIC, see the :ref:`buf_reg` section.
+
+Device configuration
+====================
+
+During driver initialization the driver sets the ULP DDP operations
+for the :c:type:`struct net_device <net_device>` via
+`netdev->netdev_ops->ulp_ddp_ops`.
+
+The :c:member:`get_caps` operation returns the ULP DDP capabilities
+enabled and/or supported by the device to the caller. The current list
+of capabilities is represented as a bitset:
+
+.. code-block:: c
+
+  enum ulp_ddp_cap {
+	ULP_DDP_CAP_NVME_TCP,
+	ULP_DDP_CAP_NVME_TCP_DDGST,
+  };
+
+The enablement of capabilities can be controlled via the
+:c:member:`set_caps` operation. This operation is exposed to userspace
+via netlink. See Documentation/netlink/specs/ulp_ddp.yaml for more
+details.
+
+Later, after the L5P completes its handshake, the L5P queries the
+driver for its runtime limitations via the :c:member:`limits` operation:
+
+.. code-block:: c
+
+ int (*limits)(struct net_device *netdev,
+	       struct ulp_ddp_limits *lim);
+
+
+All L5P share a common set of limits and parameters (:c:type:`struct ulp_ddp_limits <ulp_ddp_limits>`):
+
+.. code-block:: c
+
+ /**
+  * struct ulp_ddp_limits - Generic ulp ddp limits: tcp ddp
+  * protocol limits.
+  * Add new instances of ulp_ddp_limits in the union below (nvme-tcp, etc.).
+  *
+  * @type:		type of this limits struct
+  * @max_ddp_sgl_len:	maximum sgl size supported (zero means no limit)
+  * @io_threshold:	minimum payload size required to offload
+  * @tls:		support for ULP over TLS
+  * @nvmeotcp:		NVMe-TCP specific limits
+  */
+ struct ulp_ddp_limits {
+	enum ulp_ddp_type	type;
+	int			max_ddp_sgl_len;
+	int			io_threshold;
+	bool			tls:1;
+	union {
+		/* ... protocol-specific limits ... */
+		struct nvme_tcp_ddp_limits nvmeotcp;
+	};
+ };
+
+But each L5P can also add protocol-specific limits e.g.:
+
+.. code-block:: c
+
+ /**
+  * struct nvme_tcp_ddp_limits - nvme tcp driver limitations
+  *
+  * @full_ccid_range:	true if the driver supports the full CID range
+  */
+ struct nvme_tcp_ddp_limits {
+	bool			full_ccid_range;
+ };
+
+Once the L5P has made sure the device is supported the offload
+operations are installed on the socket.
+
+If offload installation fails, then the connection is handled by software as if
+offload was not attempted.
+
+To request offload for a socket `sk`, the L5P calls :c:member:`sk_add`:
+
+.. code-block:: c
+
+ int (*sk_add)(struct net_device *netdev,
+	       struct sock *sk,
+	       struct ulp_ddp_config *config);
+
+The function return 0 for success. In case of failure, L5P software should
+fallback to normal non-offloaded operations.  The `config` parameter indicates
+the L5P type and any metadata relevant for that protocol. For example, in
+NVMe-TCP the following config is used:
+
+.. code-block:: c
+
+ /**
+  * struct nvme_tcp_ddp_config - nvme tcp ddp configuration for an IO queue
+  *
+  * @pfv:        pdu version (e.g., NVME_TCP_PFV_1_0)
+  * @cpda:       controller pdu data alignment (dwords, 0's based)
+  * @dgst:       digest types enabled.
+  *              The netdev will offload crc if L5P data digest is supported.
+  * @queue_size: number of nvme-tcp IO queue elements
+  * @queue_id:   queue identifier
+  */
+ struct nvme_tcp_ddp_config {
+	u16			pfv;
+	u8			cpda;
+	u8			dgst;
+	int			queue_size;
+	int			queue_id;
+ };
+
+When offload is not needed anymore, e.g. when the socket is being released, the L5P
+calls :c:member:`sk_del` to release device contexts:
+
+.. code-block:: c
+
+ void (*sk_del)(struct net_device *netdev,
+	        struct sock *sk);
+
+Normal operation
+================
+
+At the very least, the device maintains the following state for each connection:
+
+ * 5-tuple
+ * expected TCP sequence number
+ * mapping between tags and corresponding buffers
+ * current offset within PDU, PDU length, current PDU tag
+
+NICs should not assume any correlation between PDUs and TCP packets.
+If TCP packets arrive in-order, offload will place PDU payloads
+directly inside corresponding registered buffers. NIC offload should
+not delay packets. If offload is not possible, than the packet is
+passed as-is to software. To perform offload on incoming packets
+without buffering packets in the NIC, the NIC stores some inter-packet
+state, such as partial PDU headers.
+
+RX data-path
+------------
+
+After the device validates TCP checksums, it can perform DDP offload.  The
+packet is steered to the DDP offload context according to the 5-tuple.
+Thereafter, the expected TCP sequence number is checked against the packet
+TCP sequence number. If there is a match, offload is performed: the PDU payload
+is DMA written to the corresponding destination buffer according to the PDU header
+tag.  The data should be DMAed only once, and the NIC receive ring will only
+store the remaining TCP and PDU headers.
+
+We remark that a single TCP packet may have numerous PDUs embedded inside. NICs
+can choose to offload one or more of these PDUs according to various
+trade-offs. Possibly, offloading such small PDUs is of little value, and it is
+better to leave it to software.
+
+Upon receiving a DDP offloaded packet, the driver reconstructs the original SKB
+using page frags, while pointing to the destination buffers whenever possible.
+This method enables seamless integration with the network stack, which can
+inspect and modify packet fields transparently to the offload.
+
+.. _buf_reg:
+
+Destination buffer registration
+-------------------------------
+
+To register the mapping between tags and destination buffers for a socket
+`sk`, the L5P calls :c:member:`setup` of :c:type:`struct ulp_ddp_dev_ops
+<ulp_ddp_dev_ops>`:
+
+.. code-block:: c
+
+ int (*setup)(struct net_device *netdev,
+	      struct sock *sk,
+	      struct ulp_ddp_io *io);
+
+
+The `io` provides the buffer via scatter-gather list (`sg_table`) and
+corresponding tag (`command_id`):
+
+.. code-block:: c
+
+ /**
+  * struct ulp_ddp_io - tcp ddp configuration for an IO request.
+  *
+  * @command_id:  identifier on the wire associated with these buffers
+  * @nents:       number of entries in the sg_table
+  * @sg_table:    describing the buffers for this IO request
+  * @first_sgl:   first SGL in sg_table
+  */
+ struct ulp_ddp_io {
+	u32			command_id;
+	int			nents;
+	struct sg_table		sg_table;
+	struct scatterlist	first_sgl[SG_CHUNK_SIZE];
+ };
+
+After the buffers have been consumed by the L5P, to release the NIC mapping of
+buffers the L5P calls :c:member:`teardown` of :c:type:`struct
+ulp_ddp_dev_ops <ulp_ddp_dev_ops>`:
+
+.. code-block:: c
+
+ void (*teardown)(struct net_device *netdev,
+		  struct sock *sk,
+		  struct ulp_ddp_io *io,
+		  void *ddp_ctx);
+
+`teardown` receives the same `io` context and an additional opaque
+`ddp_ctx` that is used for asynchronous teardown, see the :ref:`async_release`
+section.
+
+.. _async_release:
+
+Asynchronous teardown
+---------------------
+
+To teardown the association between tags and buffers and allow tag reuse NIC HW
+is called by the NIC driver during `teardown`. This operation may be
+performed either synchronously or asynchronously. In asynchronous teardown,
+`teardown` returns immediately without unmapping NIC HW buffers. Later,
+when the unmapping completes by NIC HW, the NIC driver will call up to L5P
+using :c:member:`ddp_teardown_done` of :c:type:`struct ulp_ddp_ulp_ops <ulp_ddp_ulp_ops>`:
+
+.. code-block:: c
+
+ void (*ddp_teardown_done)(void *ddp_ctx);
+
+The `ddp_ctx` parameter passed in `ddp_teardown_done` is the same on provided
+in `teardown` and it is used to carry some context about the buffers
+and tags that are released.
+
+Resync handling
+===============
+
+RX
+--
+In presence of packet drops or network packet reordering, the device may lose
+synchronization between the TCP stream and the L5P framing, and require a
+resync with the kernel's TCP stack. When the device is out of sync, no offload
+takes place, and packets are passed as-is to software. Resync is very similar
+to TLS offload (see documentation at Documentation/networking/tls-offload.rst)
+
+If only packets with L5P data are lost or reordered, then resynchronization may
+be avoided by NIC HW that keeps tracking PDU headers. If, however, PDU headers
+are reordered, then resynchronization is necessary.
+
+To resynchronize hardware during traffic, we use a handshake between hardware
+and software. The NIC HW searches for a sequence of bytes that identifies L5P
+headers (i.e., magic pattern).  For example, in NVMe-TCP, the PDU operation
+type can be used for this purpose.  Using the PDU header length field, the NIC
+HW will continue to find and match magic patterns in subsequent PDU headers. If
+the pattern is missing in an expected position, then searching for the pattern
+starts anew.
+
+The NIC will not resume offload when the magic pattern is first identified.
+Instead, it will request L5P software to confirm that indeed this is a PDU
+header. To request confirmation the NIC driver calls up to L5P using
+:c:member:`resync_request` of :c:type:`struct ulp_ddp_ulp_ops <ulp_ddp_ulp_ops>`:
+
+.. code-block:: c
+
+  bool (*resync_request)(struct sock *sk, u32 seq, u32 flags);
+
+The `seq` parameter contains the TCP sequence of the last byte in the PDU header.
+The `flags` parameter contains a flag (`ULP_DDP_RESYNC_PENDING`) indicating whether
+a request is pending or not.
+L5P software will respond to this request after observing the packet containing
+TCP sequence `seq` in-order. If the PDU header is indeed there, then L5P
+software calls the NIC driver using the :c:member:`resync` function of
+the :c:type:`struct ulp_ddp_dev_ops <ulp_ddp_ops>` inside the :c:type:`struct
+net_device <net_device>` while passing the same `seq` to confirm it is a PDU
+header.
+
+.. code-block:: c
+
+ void (*resync)(struct net_device *netdev,
+		struct sock *sk, u32 seq);
+
+Statistics
+==========
+
+Per L5P protocol, the NIC driver must report statistics for the above
+netdevice operations and packets processed by offload.
+These statistics are per-device and can be retrieved from userspace
+via netlink (see Documentation/netlink/specs/ulp_ddp.yaml).
+
+For example, NVMe-TCP offload reports:
+
+ * ``rx_nvme_tcp_sk_add`` - number of NVMe-TCP Rx offload contexts created.
+ * ``rx_nvme_tcp_sk_add_fail`` - number of NVMe-TCP Rx offload context creation
+   failures.
+ * ``rx_nvme_tcp_sk_del`` - number of NVMe-TCP Rx offload contexts destroyed.
+ * ``rx_nvme_tcp_setup`` - number of DDP buffers mapped.
+ * ``rx_nvme_tcp_setup_fail`` - number of DDP buffers mapping that failed.
+ * ``rx_nvme_tcp_teardown`` - number of DDP buffers unmapped.
+ * ``rx_nvme_tcp_drop`` - number of packets dropped in the driver due to fatal
+   errors.
+ * ``rx_nvme_tcp_resync`` - number of packets with resync requests.
+ * ``rx_nvme_tcp_packets`` - number of packets that used offload.
+ * ``rx_nvme_tcp_bytes`` - number of bytes placed in DDP buffers.
+
+NIC requirements
+================
+
+NIC hardware should meet the following requirements to provide this offload:
+
+ * Offload must never buffer TCP packets.
+ * Offload must never modify TCP packet headers.
+ * Offload must never reorder TCP packets within a flow.
+ * Offload must never drop TCP packets.
+ * Offload must not depend on any TCP fields beyond the
+   5-tuple and TCP sequence number.
-- 
2.34.1


