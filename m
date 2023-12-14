Return-Path: <netdev+bounces-57440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D278B81318C
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88D47283391
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC9E5645F;
	Thu, 14 Dec 2023 13:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WXsYo1Tq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5867B114;
	Thu, 14 Dec 2023 05:27:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQI33TCtPoeor0QiuHPL+cWxPtDnygRP0zVBOvjsFkNxdjknCLqpmtk6R/vf1SIduNJlAJA7YJMLQazoWGQ2nq/DkVrY7dXx8C1G3NwB5z14pCwFIsysE2/Vh9Vq2V5YLibayzNpCs1Og9RNEFezaEVE6WBp9b5t87u4bpUPV8zOPoPGTUJJqhr4mxodktE9K5EaaysU3kpIoVx5Qiyuf+xsgO9QMQuhmqbLHvFNqUiMmdlzByMZfT4Cqo9i/R1d88yNrds4E0/hVVXbq18IE122mGxvYYV0pgLV1bLyaMgdXCWUgewjjzd/hZkteKccloaYZZ59O46OUpDza61+xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qew/daOmlwygAr7NIsvtRVh0DAAynsd3qFyosp6weXM=;
 b=m02kA23LGGKf0WGhXLTEUi93DGJ7//7ecO/m3a2imxR0W+27ZYnY3MgN5157eD5SLc2XK3gGxWoR1eD2CnQJksF00ZMw0bObZUr/gppjspiGohXDtrfTfkNhr6bjdn43czSQvMi22dWhJEa28cugplGKGeiVUi9q9G8M9NYluaS5E0/lUHi8JoWEP4SIuFTmNPN9Y32rmONgLXxQ73KLw0FnA0MDg5cdZngFWJIXvz4BiWuEf/cjISn82yyPfsiNY3UyrFx9IEHfhGdzAl0eeY7jWKENE7unRsLvL1di9mYM9x1ipomcSxXLLyTlXId9fGMt/W093yxzo3bnzen4Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qew/daOmlwygAr7NIsvtRVh0DAAynsd3qFyosp6weXM=;
 b=WXsYo1TqsXaJR0VJAyMSRKd5lkwpFOJkf1LiaENI0o9oGy4UFuQ0vXynO8Kn60AUIS/UpUv1EmnIn6TX02JKW7y7U/AoDsuwIHMAin8ZDs7w2ZsEor+24Cf4ZEMSIk4Bby6msxRN7NXKXZzuyx3cWk2lgvPaqkPKLdlsHp9iAkyk3YIrKBFG4wtOF0LTgEdnmVD2px6MTwLc+eyb4NSY/6kQgNt9EX4YS4XV9J7NjHuaNIFdf+tlAfuIc5JpXlaOiBnzcsWwrajAEqmYys9ymntpaNvGTSuYQ9EEN7kTTFMEiXJ1QYnyxtQjhH0RJPqErhG70ZzFYGntuLEz3Lu5YA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by CY5PR12MB6348.namprd12.prod.outlook.com (2603:10b6:930:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 13:27:21 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 13:27:21 +0000
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
Subject: [PATCH v21 09/20] Documentation: add ULP DDP offload documentation
Date: Thu, 14 Dec 2023 13:26:12 +0000
Message-Id: <20231214132623.119227-10-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214132623.119227-1-aaptel@nvidia.com>
References: <20231214132623.119227-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0414.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::7) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|CY5PR12MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: bc435021-ebf8-4709-6b68-08dbfca866a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	l7AVY8Eag46+hiziK/K+XzLAIzcEnpL9BNMfKDall+QgpScpZRzdduCQ51H6TPq/2EZmujTawtas/hWdbCjuVueNkTtQlr8G3tw59wVujXuHvWiwyvC2lE3zviMzTLgo6zgsZjobS1lyd0ndSTSLfopzoa6yg7ujMUl0VkQxExMxTnurBY+1OG3w6PhcWRPgFcJJFhkH4u/oPGXpBVQQv0gG6neNDUSw1ry6brrVSRsE6cnTYV8uWDBAUl6S7MXnhp2adwQaWQpeAUf1oX4x2dmPbnDFVozLyOtME9dgDw525KicD8ob/I2W2CTkdWfzMikaCGPA1ih5TErVCW9qQ9WBtMZ3WpyJ2LcHajNfs/tXvbJKX8BfhWDshrV2thftEmhkmYa9qjAsmDTiVL3+AB8SM2MCVnj+5rqwo/4nTDz6XIH1YHmXwLARxfjuIXvrDrLktvONGmDwdh2XusgDOo9W/4IvL/SVbTMkvAbWpkQO9n3OQmHJgUVdW+hT7M5KPq4UA0OY/Kd479G4m1bDx1Q5JNjXf9iRgp4lUCQRr6kMUuW9Pjk3rRi1d/m7k6WL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(36756003)(41300700001)(83380400001)(38100700002)(316002)(7416002)(5660300002)(26005)(1076003)(86362001)(8936002)(4326008)(2616005)(6512007)(478600001)(6486002)(2906002)(8676002)(6666004)(6506007)(66556008)(66476007)(66946007)(30864003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MGaBxLQs8hiEATIVI/nRkF9Fv0w66q3ABeV5H1uzrFepLGnoKyTZZSuO1vcy?=
 =?us-ascii?Q?jOHpbDo3XiqM/pgLbixuvquaTVgg4hxxQtTV2Qjk2tf3sxHyimcMa8ULdNOH?=
 =?us-ascii?Q?YfyPwCYhTwEgHglYCg4m/0OgSDgrKvaMi47dOUnR5Pyveuf+c2Nmx4l0yooJ?=
 =?us-ascii?Q?GOVQELiErLiPdd0ZdfVWQkffbEbmzOynaAPPvlwB40SveqMKU/TIO/Sp7HF1?=
 =?us-ascii?Q?dT1m8d+OCLETts9LzdApQeM74t5FbvMQ9tC2QqpMroT2rmKlb3W+w28BBz1i?=
 =?us-ascii?Q?o3aKHXQmmh9cSr7Lkg8u2eWi3zeSKsiN6aYhsOUlUfwogYj+7PNRMXVQ7C9R?=
 =?us-ascii?Q?b7stwHmxNZt+lQrvQ3cH/7olEfMTG+e3zorUL/97YeKY/NP4YGEFtSQXOSVK?=
 =?us-ascii?Q?9RvnZSKBrESvgyy3VRCUetnT6oEbjAmm0RyzhSQ5NW8wsSJgDKbeyuhtDOnq?=
 =?us-ascii?Q?9DVKfIlIEffWsYd4JS9RAlTu4fQlzCtjt3qzHBLwyuvfYuHz9AxCqHHxpZc+?=
 =?us-ascii?Q?k0U558ppjzPSwY+eLG/vvCF4ugU4i4BHIA3IDzfcUUUksJN5gWlWxElOq9pl?=
 =?us-ascii?Q?I3RM1ORE3AfgMLeEL59dGT5wnAx7GKaZidMdjULAUc+M7/PybOhgbjT3QUgt?=
 =?us-ascii?Q?DEF3nvXyLrpdxVfTrVqEwJMBn6MQorWJyKigJff9vjSQC6cgNuTLXb/qy9v/?=
 =?us-ascii?Q?aJWH5qhxHR8sZmfkvLGGI/qNv3Li6b3s14r7Z5ISweXlJVZNrTA1Dv+GmQmg?=
 =?us-ascii?Q?sx0e2bFZK5k6FuiIOBi8yiBZWKOmmPgOq9bqi5UwYHrbB96Sr0okbCTnFQsP?=
 =?us-ascii?Q?4Cv+GCwxPpubANA5qJhISRF2Aw1NFmqoaiffrneBS4+doxdPDiddPippxlhk?=
 =?us-ascii?Q?gxXjsQBgpkxDkXs3Inenxl0ieQnAW6MD1Ei1OVQHweFi1IgNjrXzHGZgzkYD?=
 =?us-ascii?Q?DA5B5xEE1uIz4xPbFLu143ThvG5S5vurhe5PvB1tKgMQEI1s8RlaWrwqIrew?=
 =?us-ascii?Q?2qRYmOojoiJMrG2Lcvx919sS03g/K4oPDzWI/K1KnsTlV6Ey7YQKPlR2Jrmp?=
 =?us-ascii?Q?qCSPOYA1lObexa7M5+QQThNL9zXc3rDMhUAUrcgW6TRGmsqItMHFy/v8pdM1?=
 =?us-ascii?Q?2FjfK24OjD68CA3mxaH/tQ6qx5/7HepM0Jxtgh35lmtx+WSZt4xrxr7tGmA6?=
 =?us-ascii?Q?Rg7vWz5sdzbn5Pq45XxjfulV3LRcW8wwKgSz8Lx2W2TwE4T9Jr9hz6e9M6Gj?=
 =?us-ascii?Q?qhelSfNEgbBlBBOrUJL2/TeyMVCW7+UKj+KqVWJKD1rrr+hwYeRoencr9tL/?=
 =?us-ascii?Q?k3bURbxge5BhU54DKCjNJuk0KpBbwuq9WIFk3cmJv3rXJyR7mkrgpz3wDPXd?=
 =?us-ascii?Q?8hEMXNF4f6ywxkqdGw69AVFZ/6ANMbzteM5nVjg52Lj5Jwvk0Jl1ixT7jim6?=
 =?us-ascii?Q?rUB8uhBql9DF/RxX9gYDoBBIPSeDXsv9bPcFkLQpTo6xlTL8VZ+gx879a8Au?=
 =?us-ascii?Q?LQyTLZiB76fk3+V6fGU9FwWVsYNmRka8nU1YVhCgpDM3UTNkbhU/TfIkVNHw?=
 =?us-ascii?Q?3Z+TzFt+eJwvicXFQ4px6mwzJVEkZKJPmY0c6xl8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc435021-ebf8-4709-6b68-08dbfca866a3
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 13:27:21.1239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kT9hiT0Aig4alyd66i6IhLrCowQo8YJivJs75AecKGMAFrFr5AJvdBURVPxrCgMMV+DBhK17yVpq6Xx5nzxWGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6348

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


