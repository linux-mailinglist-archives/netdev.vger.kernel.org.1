Return-Path: <netdev+bounces-43857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 748527D5067
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 14:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4FCCB2106D
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 12:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F3E2745C;
	Tue, 24 Oct 2023 12:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z+czTcpZ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B9E26E3A;
	Tue, 24 Oct 2023 12:55:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DB910C9;
	Tue, 24 Oct 2023 05:55:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSEcwHrdm67ilO5GrM8/DRkgl1KcmtZtL5itgoutCPJCQdMursxO0bhD1beUlUpcl/27Sj6iqqDl4LJrNJcTdBKwrL8lPl1ShygDNr8+64/xSA8bem1jECngUSrUp8WEAJwe/8r9zfpBiNze0BymrvcWm/d1aXRDU40fs1SKjAMFO4FvID1K59+TofzTJqbzYRJWcLd65PJNskl4Kt323T0Idd/ejejwVcXE7gdLOgJFIFPyS5JB9aS5Ny4uTm0O/qjCsFpmktyiHrtKPZcI6biY7pSQw9XVuVzIfQRezSnV8Uu0oGiWoD9p+CgDJMwTB0yrpC2yjptEiBt9ZH+7QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrYaDw7v28rtt0wsojt9EF4YvX5UhSCeBEOpxmGYWUU=;
 b=PJOg9gpgsgIkC9ZRT7qg5A/JlbWcvMzf0b5oJZBNAW7A0gqMaC6iGmDJdbclEDJxLDpN3eZdAR5mnBW6zBu6EO5IpEpkCwY+II2USJ8BlgjWdyDNsBMYuVvhoZyWrGSn+Tz7WBMGXsz/be8dRAS+IVWaO9QQI77/QdgJvrqeVvDyftBCPMUvWS5OIcfgfgKxQLXUFecb+Zty70IRXCYvAC7ZtrKDhOND8zSgfeB0t6M9yIsSn6VE/vDU7gy7Umylce1sbDx8H4kE5mvTffU5xDqVffhfuhzamzot61k3LvZqvlzZvpc9MpDTHM5EH7bfNsqb3s6u5SzYYzL+rm9N0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrYaDw7v28rtt0wsojt9EF4YvX5UhSCeBEOpxmGYWUU=;
 b=Z+czTcpZ7tjavM5tIovhpJLIG7B6LwhIFGYUZwHJPp6h/6XrmdybYQfOjhA2Y8yBSAc84OJ7ETemJekmtjlCkBIXzjkSGGwxpLX6uyD2jTAQpIFdLHdfgFCDXdY07KXMvC+cxzPCZdV09EQeK49I7OLKp6t1NZ6hOe0M83812u+LYsdlZttC5/Sfov+sp2C3Akx7fLcdivR3IxR/p0be/j4KvKxAwIAne1l8eVwU6MUiN+nSE0a/DF2QzwV3ijhJ6r5fhrwjhHPskm0ZW/g/qaiQ/yVmCLR5L9qX51iiGjrk/eujujyVu6s2vjmRhx1yEft8s7CKqgAmDjztrsbaQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH8PR12MB7256.namprd12.prod.outlook.com (2603:10b6:510:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 12:55:45 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2%6]) with mapi id 15.20.6907.030; Tue, 24 Oct 2023
 12:55:45 +0000
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
Subject: [PATCH v17 09/20] Documentation: add ULP DDP offload documentation
Date: Tue, 24 Oct 2023 12:54:34 +0000
Message-Id: <20231024125445.2632-10-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024125445.2632-1-aaptel@nvidia.com>
References: <20231024125445.2632-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0473.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::29) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH8PR12MB7256:EE_
X-MS-Office365-Filtering-Correlation-Id: 038c1916-e506-4609-c46b-08dbd4908953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MYn/SRLiTXjUZhjdkZDpdEFf0VsdCIAwfc60keiLVFvktwR9b/+F9c9AZLVqQ4g3cGdNrBy2h67b5sQ8tIaVUaXvT2FW9LOaAT7AooLhtMVnge6yAoUB/cALWsgW/36mM+1H2W8X2b9JhwYmg3kLBcgDPdqv3Ii4aVXZULXzUbIBaqeXN+8UF5fh+9W/vd9Dl4BX1kjQ+NHwdLiJaPoB+zt9kQRq8PMAAnskaXh8e446kCJmdm/xNeCslw5eoUDuy3WlktQGwp8lhQzzEqo16rpxkxmhLkGdJUe5N5mkWxVEAF5sML5O16md2INbIYqJ4TekMMVaq7LIT3r87+NI1zCILcw+Ln6H/EKjUJztVGzRCG5CTCR19Gg8BDPGldH6zxY2RcHkt7gimD4NB+HO/itNGjXSY0T2o38TidMV8clNwkPj2iqUTfTAMoyU9xgKsfrQoBsQR391SJQgpNP7LSluQFiBGtpD6uE5IRXMjRgOn97Kk4dBCysjhYKTG4oljktXg6do8rZsvz81h2HIEhg1ileTTp7bC6xI1Cjsn/ixu9E8RdXyTbvEws2HoH62
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(39860400002)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(26005)(36756003)(66946007)(316002)(66556008)(66476007)(86362001)(38100700002)(83380400001)(1076003)(6506007)(2616005)(30864003)(6512007)(6666004)(8936002)(2906002)(478600001)(6486002)(8676002)(41300700001)(7416002)(5660300002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H+1BGxOaYrAdAvwVtO7/jMX5FqPwvQecLS2yI0T0y5uVXwTz+hRvguMsC7t9?=
 =?us-ascii?Q?NJXmFrQcm2McErVKfvI2nnw54DXy7IxK/awIcYL/woCeTMWHdCWKHqU0X8to?=
 =?us-ascii?Q?Im9zkKcp+QkLPO879ePAdkNIgQSbLx5Djyi1g1fcw/WaAuVuXlNVi9AT8isr?=
 =?us-ascii?Q?mTXdT+f7e+wdyuo3FxX2CyDsFK/FGJyel60Oew3/B7HabzEnIVWKUSABX9In?=
 =?us-ascii?Q?tKc6PR3bRnRdaY2hYyUNLbFZynqFjeFTS6mfNqThDFZYp7JMmQeJeg4vQBEd?=
 =?us-ascii?Q?vRc99A60mOHptMoocqgRmBUHVZgywQeOob+JqN8RhyytmpJ2n1+DZGHYhXHt?=
 =?us-ascii?Q?S8MwBzQD7YU1uO5M7jERtz0u8uswlJzqURvHSDAWwND7VOwwj/YQnj0KG9Ie?=
 =?us-ascii?Q?4hwLX1sB6zZoWYjtpcoYkLfK8K9F3tM/l7L+ILyHQQN0p+bQJHhbrGvdix33?=
 =?us-ascii?Q?tJRVZFT/p50xiQKwFhXhgkW9kRccBJ6IFeGaZekUkAn1sdrLynTiWfyZqoer?=
 =?us-ascii?Q?HT4q9B6EQdaOuaGXZmUPdDoxmds41cz6/J2mM98KXDLz0lxVlTAOtAqP+hh2?=
 =?us-ascii?Q?75J56XYfiY6cS69yHh6bc3RoLlECyt94TStm+ioD2qBXosLunKGO484k3GCm?=
 =?us-ascii?Q?GSapm5qILq+/9PYBynVm62nATbI/62Pvqki/EoYftlVVj/7UndZx/aegUw6D?=
 =?us-ascii?Q?+sN+WyJ23jDrngLLxz5Df9Nx4xPpcFfxdR9Mq/G/hAIuF+QerhYc7RMbTcJF?=
 =?us-ascii?Q?raMIvp+xheK5fH4VhoIKWjXfdm+6Kl5pBIA4CaF4C3Ybyc9GW4pZHpbr7pG5?=
 =?us-ascii?Q?wOJMa11K317S0nXJWjM1A38zzBz9ti6g/XQGZ8UeMvv0/Q7x0rCJ5tp1lQqG?=
 =?us-ascii?Q?n3Xx5Pw5hu8TyVTkg1yuc4zngOmKMqcjT79dqRpXcfeVx5h+5ywmDiwa/soS?=
 =?us-ascii?Q?8H5FU0RKaWHd/Kz8TAzxftZ4W3parVLANYw8qFjE+jmadqg9YF5Z0usqzrnw?=
 =?us-ascii?Q?rV9jQhBEK+HtKLtjkb1eqeGLbQCwCGCfYjPRUi1TiWBH8NzdGmVGjuf/h5H6?=
 =?us-ascii?Q?2fwPg5WmgmEJlXtM71W/NCcoXYEtDyVuGZzV/cLFqSBdr08VFxZKwJG68RCG?=
 =?us-ascii?Q?+ysuCa2zO4zIwZo26ocKFEPLxiTvp2fA2v6+h9CkJyc2sTo60JnQRwgy9WQJ?=
 =?us-ascii?Q?lcrCF9G91ftqRIRIQzSmg4mH6EnwIFFzSwg20NYuCewae/gg7J/nghWqVCRl?=
 =?us-ascii?Q?I2mI+jeqkhYl3bz6Cf+ZOCkzpkyLYSmxiqdWXMqfjZddNjA8B2cyyQzI+rnM?=
 =?us-ascii?Q?GDx8+LT1djErW7E/t22R6dwgtpOjzGlmTUw1MfeVj3xQJEFKJejQBacFSEia?=
 =?us-ascii?Q?qeXKbwvAheWJjELFVVRfB/nY0GfNI3kaLyn39Cc/Sb2Ps8SNPydoo0dRSJlS?=
 =?us-ascii?Q?JfmwUu4QtrdP339AeURDsPi/xsd3JcAOzhkEKW3ZOFegE6l72qB0th7QhNP1?=
 =?us-ascii?Q?WqM/46Je0S73XiG5aXm+bWBxnVgvKuzdL5si0XmKSXlDSf9rQ41PiPf0HUZZ?=
 =?us-ascii?Q?Q1bwAumCK7Yx3t2Psso9KJqKwIoyt2Xq3T2eVVvy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 038c1916-e506-4609-c46b-08dbd4908953
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 12:55:44.9760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sb493DdU7qM/Tqw270lnz2KgOPcjoPlDa9WgidfwdsUU2cQflIO7w/fqg9qRxdAAOjN15nePJ96vnebbYS/SDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7256

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
 Documentation/networking/ulp-ddp-offload.rst | 376 +++++++++++++++++++
 2 files changed, 377 insertions(+)
 create mode 100644 Documentation/networking/ulp-ddp-offload.rst

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 2ffc5ad10295..0d2cec4bf158 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -107,6 +107,7 @@ Contents:
    tc-actions-env-rules
    tc-queue-filters
    tcp-thin
+   ulp-ddp-offload
    team
    timestamping
    tipc
diff --git a/Documentation/networking/ulp-ddp-offload.rst b/Documentation/networking/ulp-ddp-offload.rst
new file mode 100644
index 000000000000..31b7edf38647
--- /dev/null
+++ b/Documentation/networking/ulp-ddp-offload.rst
@@ -0,0 +1,376 @@
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


