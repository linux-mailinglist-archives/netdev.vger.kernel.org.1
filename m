Return-Path: <netdev+bounces-33139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 194CB79CCD1
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 12:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C28B8281C87
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 10:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB08A168DA;
	Tue, 12 Sep 2023 10:01:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9468F179AD
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 10:01:06 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CBB10DB;
	Tue, 12 Sep 2023 03:01:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STAZ7bdoShYXXV0JfaTQ0m5Fh9kOiVJJgpdvIfuucizq1knLufc+EqzUpBNl5aTIJoSXcXnIQDbIj1AcbiUnmkjvxtEzoB3zzV9Afm9GZJvz914gIyO7XPoGdIku8i8a2XOCmWLKIgU201WMrZco/QHb8HlV2XblC47hOkkQo2cTxRb0l7tNEEKG4ZYw7mD/3gUyKXOB5strof8sfJ8rcZCQIV2rqHqTZI/3pTrS88uiEBMemSsahqZr8igBFj3faJV31WnAaq9Qs/VSkFNt/m3dh3lGOiikXWnH+a2rqJnuFk+62quTmgSoOV/M8R62kWT1+mKlsqkmDfLPJyS0Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cexzRS9Bqt8mu8zTiFRhhsYliMUU6MgPMY2yy4G25eY=;
 b=Yp7cg4C9r2omPPEcTY+2ZohqmLQUjuEk54wkU5PV3uh0+opVBJ6bf1dYu9ncHiBPkTbKjTaf4QkLowaNYhJBHstbyR2yAII505XksfFjbxEeGIGZYQtrq9GfSd1/4Svt1j2OBfMi5OrOQ182weoPPrSc+I3yWYizQur52kvBt3JHs99W/NZflLeN8UqsGyxjyxq8IvXJrIi5ODtS/7c8F55e1g4loVUHvnsOEFRVN17HT2M6Xs+6eNgfe56SO5Bolc8F5KkegCrKcYsvjXkRKOjuowvOUC566fAjY17Qm4vFyRf0IS00Xil2n4E1ow+LLUYJgU2ImQNHG++Jokd9qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cexzRS9Bqt8mu8zTiFRhhsYliMUU6MgPMY2yy4G25eY=;
 b=GQJzsfWWu9sX7AkF2vcEWm7diLf1MJDbZE4xO1vuZSOIChwCnhXra5kRc0jz89ODCx4X9hfwJy2H1/zi9AETxU34uLMXBTH0H5FmpPRxRPP/u0WSY+OxSIfz9CK3AMQ1lcyqRjyt099afzMIa9NUHbetCkR7WvevsYbCjzTyH6Z988P43OoeQ/rxjZPhFtsB4z0S8nIynOLmes1SMhozrzRc5F9Vx54DlJe2q6wiPn5hd6DkkPpN2X89ndoGjZIIZXPOcZuzz24viro4pVU2dfnvvr5q/9+yAONIsdzy4LCgqf9hJpR1804Bjn1XmRwb77z3fdA9yFloceyY8XBJRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) by
 BN9PR12MB5034.namprd12.prod.outlook.com (2603:10b6:408:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 10:01:03 +0000
Received: from DS7PR12MB6069.namprd12.prod.outlook.com
 ([fe80::8ce3:c3f6:fc3a:addb]) by DS7PR12MB6069.namprd12.prod.outlook.com
 ([fe80::8ce3:c3f6:fc3a:addb%5]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 10:01:03 +0000
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
Subject: [PATCH v15 09/20] Documentation: add ULP DDP offload documentation
Date: Tue, 12 Sep 2023 09:59:38 +0000
Message-Id: <20230912095949.5474-10-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912095949.5474-1-aaptel@nvidia.com>
References: <20230912095949.5474-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::16) To DS7PR12MB6069.namprd12.prod.outlook.com
 (2603:10b6:8:9f::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6069:EE_|BN9PR12MB5034:EE_
X-MS-Office365-Filtering-Correlation-Id: ff201a7c-1fe9-4861-ac59-08dbb3772cae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YJfjlSVy+er2VOwMOlO98Bky4YxjqSEA8/1xsosZMd9dAfstWaCluXToRYp4MeEKvUiG4YOgUuRJ6xC5xt5r/6QtkSviE2w/gRc1tsMOED8uuSYPSjqXb2kMMmQ5OcNECj4trnrLVyB3Ho8zzji9I/e9/oUN6U0EI+dC0/+QEV5MCex9hGX03CqA48EVf4ZWUSKWNnJMPOjhtSG7o4QrvOv8XcvUTjld+Do/q+55kBS2ekWGzNBJCoeID4yJc367XjshN8kvL/pKn6ROe4Z7cxa1UkokPRoE+RE8vD+gCsWodJ/CipuKI+IOM7N1/k7csKqjK+dx2tDS2+elHIp1irytEG0fVyBhxhi66jCA/xjcvqoOeldDNno+08RjpXaLVU9lxYp8zf7l/3N2blZepE3+9wO9tMPiE9QT4moAUTfrWUlGTYa9l0wObJ1v4oUb9ZQdfLTCD/tKTqW/NJIwvPAoHzleiZSuys/LLkaZq+IebiF3puJeIdPqigVMKSZTDRkotD/MKUHu/tDv6K4I9rh0gzGUZo1eraRzIOyaU+LViUA6qBZ9Ho57EoXp2Qu4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6069.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(376002)(136003)(396003)(1800799009)(186009)(451199024)(1076003)(26005)(86362001)(83380400001)(2616005)(6486002)(6506007)(30864003)(2906002)(6666004)(7416002)(6512007)(38100700002)(36756003)(478600001)(4326008)(5660300002)(8676002)(8936002)(66476007)(66556008)(316002)(66946007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EjUrPPpTIpvu5uYajJTLj1shVU7pkOg1//cK+TOdWcUFYetCT4AIHUGTlvZb?=
 =?us-ascii?Q?NnKPMcddWDPfYNg6LN6prLXCMPExlZHlFv3OZaHEqCdvaCOzORR3U+r1rYZe?=
 =?us-ascii?Q?b8v2LlnZoKU+ibRkNDBUu3rnTnBHS0rS0yDgksmFNHGeUXIthvdVGdZjW4So?=
 =?us-ascii?Q?OREW9fXpTyV3irsKD30CpVNqalCjI+2z2B/UyuzTho7dV2jhwfdjtecIjI0e?=
 =?us-ascii?Q?JHwYv5WHvCrFJqGVZF8+26cZ34rVSTpr9BiNYf20sayWYzI5Oo/Ogi2tWSPS?=
 =?us-ascii?Q?uYhBkxdjtrE9EvXUN8g+bjKweXbigQk+tvUGNCcThmkjmcKy0nDTU2zMMwQu?=
 =?us-ascii?Q?hMCWqDXY0mQkRWxdooQRPoRUEeY4rkLzvd5Imj/X7TnJaMsXMVhjmq6SKKMk?=
 =?us-ascii?Q?zUKhffb6IRl7J/A0JTqihFntsP7acDuPewSCnw3kSH6k8zq5jrhnugklWXVO?=
 =?us-ascii?Q?ju74mfzojGJwYaToh8mVJ88JgsYhkLyh4AqTfUoolrS+oqkBJxs/C534+6lF?=
 =?us-ascii?Q?WiGE7/Fk9ctoI6GMY9zcOqlmLFt17JfZoEMmlrvIODyQgINxU5oPoYJWusaW?=
 =?us-ascii?Q?8ESKrjKjUxA7BiEkgS08WF9p/CDTUvby4E+LNuB9Y1TcqSnjuRge/zCiBqak?=
 =?us-ascii?Q?BeHTEPuC5YNX4DpnOxcUY7yYvuL8V6KAVI4O62rrCZSqNHZMICH6MFrGmEBB?=
 =?us-ascii?Q?gPdZEjMzBvaBhA4reUMb7gk+rNZ4D+DNDrRsCFSI02qfhYxBhTAl/Wrkv+Vy?=
 =?us-ascii?Q?32Y4LQ7jYLp8A8OAbpeUEVxYciQp4vGXsygSdTBOn6Zi5liEKiGYlZHC49KH?=
 =?us-ascii?Q?JRVJaip+ZjWd9A3OO7XGjVNBlhvn75Gg95cJtp0zP3cLMupn5MRZn8nvf6kf?=
 =?us-ascii?Q?qyqYpBLj8Q/34OFBIx7qOW/rj0GLeUyq0TpEuJ6v6BKFkBDB1piCvUwA56U+?=
 =?us-ascii?Q?HMzQCI0QRvU6/A+OYGBZCVRglu4hTFtcX1LNVZpTsUqkpJ++/s+uERGLJEVd?=
 =?us-ascii?Q?hSxEq1Gm1Nr0TmDgPr6/AGo79Vn/mZJ5dwTHGOO5/7WyaoYnHTfGKxT9kfPT?=
 =?us-ascii?Q?iqy5B8O25SGPbiWcUU0yXoxV1Tae/Qot/Lm2gur+n63r/7T0DqckCmEO4z/P?=
 =?us-ascii?Q?Dlc6RbWLshPzgDNACLXalQDwUxYUa0pA+DAHsp1o+PKJJjhogghBiFRMNKG+?=
 =?us-ascii?Q?8pa3WvpzQRn+yHy2fVyOFPL8h4uWeNlqlad4uPeQWU+DbF0nayEa0VDn6ak1?=
 =?us-ascii?Q?EGjUiqhiFXRz7si6iYZsLiyKhUF75aaKKY7E+iZND4RdyxVNxaT4MYkCD1Ok?=
 =?us-ascii?Q?y0BjW6LgEIzGjRo7ytjKS0x2wmSX2GSinsgHTE4HPHnyz3NBVXjHGBrI9XfG?=
 =?us-ascii?Q?MUJDyUqN8f/Q9z+JG1+c9XMpqgWoT0s1wYfF5C7i/IcH5kGyV7l3b5kx2Q5A?=
 =?us-ascii?Q?rWR00txxYX6C5N10L9WmHKiqqd8du1Z7IsGR4bs2/YX1DljAwJOdKMnLLw+q?=
 =?us-ascii?Q?5aavGdsB+8csiKjjakRzSjzLN8GhR/kQF7epRKh6xawMQH3iUed2VaoM9vkO?=
 =?us-ascii?Q?CKIvrYSkGngZmfGzNnpEPYeozNxPTPMoWJDUYD8K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff201a7c-1fe9-4861-ac59-08dbb3772cae
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6069.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 10:01:03.6105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RuwImTWLhlgKZbIu5ZLexnMuhM8hG5j642sgO4VoLPkMWMCJhsIWV2QNtVtCoZZVH4cB5zsOocvKEiRXdV+FAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5034

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
 Documentation/networking/index.rst           |   1 +
 Documentation/networking/ulp-ddp-offload.rst | 378 +++++++++++++++++++
 2 files changed, 379 insertions(+)
 create mode 100644 Documentation/networking/ulp-ddp-offload.rst

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 5b75c3f7a137..856e4b837b67 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -108,6 +108,7 @@ Contents:
    tc-actions-env-rules
    tc-queue-filters
    tcp-thin
+   ulp-ddp-offload
    team
    timestamping
    tipc
diff --git a/Documentation/networking/ulp-ddp-offload.rst b/Documentation/networking/ulp-ddp-offload.rst
new file mode 100644
index 000000000000..5d234633f5bb
--- /dev/null
+++ b/Documentation/networking/ulp-ddp-offload.rst
@@ -0,0 +1,378 @@
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
+During driver initialization the driver sets the following
+:c:type:`struct net_device <net_device>` properties:
+
+* The ULP DDP capabilities it supports
+  in :c:type:`struct ulp_ddp_netdev_caps <ulp_ddp_caps>`
+* The ULP DDP operations pointer in :c:type:`struct ulp_ddp_dev_ops <ulp_ddp_dev_ops>`.
+
+The current list of capabilities is represented as a bitset:
+
+.. code-block:: c
+
+  enum {
+	ULP_DDP_C_NVME_TCP_BIT,
+	ULP_DDP_C_NVME_TCP_DDGST_RX_BIT,
+	/* add capabilities above */
+	ULP_DDP_C_COUNT,
+  };
+
+The enablement of capabilities can be controlled from userspace via
+netlink. See Documentation/netlink/specs/ulp_ddp.yaml for more
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
+  * @cpu_io:     cpu core running the IO thread for this queue
+  */
+ struct nvme_tcp_ddp_config {
+	u16			pfv;
+	u8			cpda;
+	u8			dgst;
+	int			queue_size;
+	int			queue_id;
+	int			io_cpu;
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
+`sk`, the L5P calls :c:member:`setup` of :c:type:`struct ulp_ddp_ops
+<ulp_ddp_ops>`:
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
+ulp_ddp_ops <ulp_ddp_ops>`:
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
+ * ``rx_nvmeotcp_sk_add`` - number of NVMe-TCP Rx offload contexts created.
+ * ``rx_nvmeotcp_sk_add_fail`` - number of NVMe-TCP Rx offload context creation
+   failures.
+ * ``rx_nvmeotcp_sk_del`` - number of NVMe-TCP Rx offload contexts destroyed.
+ * ``rx_nvmeotcp_ddp_setup`` - number of DDP buffers mapped.
+ * ``rx_nvmeotcp_ddp_setup_fail`` - number of DDP buffers mapping that failed.
+ * ``rx_nvmeotcp_ddp_teardown`` - number of DDP buffers unmapped.
+ * ``rx_nvmeotcp_drop`` - number of packets dropped in the driver due to fatal
+   errors.
+ * ``rx_nvmeotcp_resync`` - number of packets with resync requests.
+ * ``rx_nvmeotcp_packets`` - number of packets that used offload.
+ * ``rx_nvmeotcp_bytes`` - number of bytes placed in DDP buffers.
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


