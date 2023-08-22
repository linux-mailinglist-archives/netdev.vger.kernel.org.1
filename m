Return-Path: <netdev+bounces-29670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F9E784507
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 17:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B4C41C208C2
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 15:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272161DA57;
	Tue, 22 Aug 2023 15:05:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFF01D2F9
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 15:05:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9128126
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 08:05:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhSSoq9p/Se87RjdDusCeAe7vzxzgKRVMIwJ0vEw7D4ciKQpLucqKtxyI/5Pt81F6LFu+k0lJb2qP3I3iypUQx4FfiBgjb3JAbc1ynwobeVRPSTIOg9g6c1F7+UPfUhHMMre+4z2NWCBwSjTE5t1fQtaeSUPGp6PMqyNUN5rM2wJ3gowzxhxfE8TSbQ/Yd9A7u2hrmO77ywr8TfDP+CIm5UBIFwzShjP0kvjnXbP1G3eM1p8odowETC7OmYXF9XAo4zch01uOEUG5wbtCT1+cP6yy3USBk33nbHvEce0UvXWvDUbBD5feobo77rXmINXxL19gsIYcujswAV7nDznag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LIk4/kSU3AdgLdh8dvZL/ASo4e0lhtJA7/xrF3ip2Jw=;
 b=Wk3QQ1wwnmn3wCxiBbw9DWUr5RAGvtDFPTeBV0LupmFDuNZqbzFVbaoqeoCJrqlLG1JTfyfRlcrQuisWUa8DfxmLbozbFf9Kxs2Y9ZsbDua+4HUphSqxxBKTwTBeET5/AALXaHmfMUlb/wUoOnOd3zpSZHKwiRKx+O6Mg3xgMmMt+Az5vKE6x1L6wQrtgZLZ6YrS08Sduc3gqt7Zoi2b3FDaVxX3WEtmgOQsJ69IvJv8Higf4EJQ5S+W4mXpP/id/blevH7anhjQM4rcASgypP+rSqYyfxWxM+aw5SrNk5zir1sjROufiDKvQLp+tTg/CqnKRv3qxOfDF6iyC1lNLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LIk4/kSU3AdgLdh8dvZL/ASo4e0lhtJA7/xrF3ip2Jw=;
 b=uja6EBddHYlvbLReXKJLjN959Aw9YdvLslTbl+uKlZ2+vxpN7StjsZAHyzwKeLvyzM9hOBw+Fe7WNNUQzpuRYLK+mV4r2ILCuwNOdC0lJc3DsJoZhpUm+NgtqMB0M5m+otbRR7Yg54ylgTUUi9PHRnlk1YcqLobbOiZOu8rL0O83XWJYjTfobx6cbv4JCypH/+9wGnCw2YCqbRHl+FpGTUovn+SNR6bCq+lPCBvWVeZmo9unf4FHTgvfxdACPKdrXbiSA481jW/JRmzeXy54LXMolDQ9M7Mpx4hVY9YPx3Q8xCe24qSu1TeBME20jJ5fiVVWCOIWCYOjGiiNM7ndtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH7PR12MB7378.namprd12.prod.outlook.com (2603:10b6:510:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 15:05:50 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 15:05:50 +0000
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
	mgurtovoy@nvidia.com
Subject: [PATCH v13 11/24] Documentation: add ULP DDP offload documentation
Date: Tue, 22 Aug 2023 15:04:12 +0000
Message-Id: <20230822150425.3390-12-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822150425.3390-1-aaptel@nvidia.com>
References: <20230822150425.3390-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::8) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH7PR12MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: 04d46e20-248b-40a5-a082-08dba321457a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qT8GPIPeFW2H/zsTogVT9hrHMMDs1YRF6oaXeedrYg2qrRQbPfnQhfL2FMTaJRCAj3NV4cLW6R77Ev5fqJpiQLhINOQNPkMJn7GuvKs4pqTsODa6HldezYLdrv0Uiuxr79DDgJxjj//WzCB4TchtEtoMDULEzuiUkix+GPohq1yk7WqMzGCFSaGhfR6tTH++RgxeQyQ+RR4x3QSpKFYiyOg15yBd5g9DUtXbVJyCKvttUDEe3nX/qRTQGatwU/CzIyA1DYRENzQTom2XjP3XqBHPGvi3CnD/66uCFxVz4QYNtbCwnsBjXBLJI+WDwew2CwylxR217rtJi8Ua4i3pLJ+LP/QIaXrouMjw5wSADMtEqItRTk1SGUjxoO3iLctz0zRrng0soOSxOjY7cRAA/mZPL00sWT1gfGK5A5rRTnKBFxAWL0saeLwUex96DOqXpBE7sjTJatk6gDib86FE31AkIdS5JHFleK4pLQ5AgvXMIwv/XaO5zldZA/fC9zXq5PagJQAOxDR5By2SmsOeaOFA12MqhNd+CFAXFFB+3kd3muIlnkk1W8arx3lbmgpe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(2906002)(30864003)(83380400001)(7416002)(6506007)(6486002)(38100700002)(5660300002)(26005)(86362001)(8676002)(8936002)(2616005)(4326008)(107886003)(316002)(6512007)(66556008)(66476007)(478600001)(66946007)(6666004)(41300700001)(36756003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jgTiIhX9dnMcvIjpJ6JHYmrFKOvrlKskrRYBQK6doKCts+8h7yV0SknOQ42X?=
 =?us-ascii?Q?GEvG2MzQpyNsPV3wVsQIlcSq0j5fEiDGU99hU4wfZE6xwkt+vgAraYB4rWWH?=
 =?us-ascii?Q?Rey9Dq6Dq6hbR8MIfTNHS0+p1SANccQE9ZFFMOpBl3Eg2BgRMundxgEYgk0I?=
 =?us-ascii?Q?BrXKfeg6zovRKL32sEJK6vGaanlMx7SN3Bh1FZl0+HkE6Y336OPRQTId4Blq?=
 =?us-ascii?Q?GWGSm6SfC7Dwei48PrMxE7b0hxpnlfzcLBfp5TEHCPtwyBn/hlpuxHi2qj7m?=
 =?us-ascii?Q?f5H5a0vc8rrnf5DG2Ofl8CZMcWe5mcqDNoRsZN50rDKdoYQe9CIlFnOQgbZL?=
 =?us-ascii?Q?sAeQf1eKCR42RUA/zkM157uEJNsot95dwT9ow50ikX9FLlnlAARjt6agxLjf?=
 =?us-ascii?Q?7Tz2wAO1KrL8F3mKnSMMHw49SHkUZIz2UcuI5T9bqdytca2eh59ldkJykkxx?=
 =?us-ascii?Q?+++tsOt/wLPOqV+6QJrCuzftoh2qCEGtwtSr33ZQBs+/h/E+tYGZFq0tDbqK?=
 =?us-ascii?Q?4li79kIprCsuD4y4RymkW1zfMOVF+rFzmfFrGBVqZ+ksJFz4ECQesUGtu7Uk?=
 =?us-ascii?Q?69Vqfx08HyPP+oDF0CezgsEY2ODaW4AHtlQesZi23qpHfAfMNJWRpLEZ/gP/?=
 =?us-ascii?Q?X9bsg7GMHlisaEik5xB233qg/PuMLFzIgeH4vLrW4dQDeXvNtaODgc1AmUuz?=
 =?us-ascii?Q?q+sjBBKMZB56swrkgNmcaBUp1ET7xzSfwQfBNbh9NabJG3Fu9xzAvY1kKH34?=
 =?us-ascii?Q?ZDNmFInRVz05/PatQ+RWBv01Q/Oyl7P+8t4WHZ3gUGZt34etcE3kCARi8t9c?=
 =?us-ascii?Q?O61fWoGXO4PBS+a6ap+0JDPJBDe019dt+/hhI0IOdBrWWenB7P02AtGyBxg8?=
 =?us-ascii?Q?i+asl9uxd3XQjoaO81GI3GVrpPTv29xQBGQadpdL22ORCh0kcb8Ceuapiu43?=
 =?us-ascii?Q?Uj5E2h1BufmR7C7bv9ghpSW4wh5THeNTAB33IFlRK8fJAIhsvXlIkdhyRPWL?=
 =?us-ascii?Q?sE/topRwu+MslHUBx3QrafTu3DgE24Cna231f3ud0A8twjLcXmHITTG84/Ox?=
 =?us-ascii?Q?XAS01/H0DSqGzjI6A4a+wrbm89q7olFq5tHivhGRnjsGNwauTyw5Bq25KZEw?=
 =?us-ascii?Q?VhkC7wj+CaBbtWxEa4wp9lksYS+TZrK9nEL+Svp3ti1PXmJTbDvabHMoITAO?=
 =?us-ascii?Q?7fcNeZVLGeaVbHykJtA3TJCXqUMDMCVl/ME0uzhgexyrWlo94trH2a0sPWF+?=
 =?us-ascii?Q?NumyVp5iGtGrEdaB6nF2QonNkCAQc/z7KaYQlcCCRAUBU1w5sOxsRN+kTG77?=
 =?us-ascii?Q?ezwfCSiu5RlDWIAB8phaSKzisyFa2ZE2N0/xmNqGsbFlp+BPAOqms/WA0KAH?=
 =?us-ascii?Q?yKWs0rCT3vWsPRzaJrT1s8RAO/MayjkVIaPWUAJwt1n1iqnHh0n6o2eFNzAz?=
 =?us-ascii?Q?rYcR6rpq5UMOKQvcplGqFwC/6jM3xvRwQ8dIhXe2VITOBwc9+zyE5/ZhiRue?=
 =?us-ascii?Q?GSb2DaA30R7hQnLt2ATWEOGaEn78g7KdHx3TGQ4TtQh6aOIV+stufwsrk2ob?=
 =?us-ascii?Q?ytJqgBq6ndMlP/FsjDCqMo7W2m5lG7S6w+BJ6tiQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d46e20-248b-40a5-a082-08dba321457a
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 15:05:49.9480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5y/zYMvXVNU4dhvY97C4ZntCWrgWmjur8G00L54bT/P7THK+iIwpbt4FaLy5cpMouZ7vwJdyc3mSl7zGZ7vjFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7378
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
index 000000000000..c996e9f48af5
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
+netlink. See Documentation/networking/ethtool-netlink.rst for more
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
+via netlink (see Documentation/networking/ethtool-netlink.rst).
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


