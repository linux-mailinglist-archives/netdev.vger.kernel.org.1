Return-Path: <netdev+bounces-29663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5327844FC
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 17:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF9CA1C208C2
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 15:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331691D313;
	Tue, 22 Aug 2023 15:05:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDAC1FD0
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 15:05:14 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B36126
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 08:05:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbZwkQ9fCBw9nlbmFThviQwlL8n+g89FOCGIoLVjGWgXUf0hT4ONwJ5unDDaiIfE4QEQmVjFsDhrcDgKyyfHlgSC+N2E4ZmccTQKnpyxFCjZm/r3iiFOIfkU+L7q8m+IyhxAKWpWUtWx21b59TrfMxzSQBrutTXAP9yIPnZkQ++MugcMcq+uPjXNaFspp3W92ZiiwtFdmyUwj2raFmfZO81MgKqxlWizR4e++vhizA64u97+etOv+JSNYpR1qJkPJKTJtte2mUgfe/JG2QeYD6azJZqiZTbJvVB3SUNEfFwSLQ3zrCOixvd5RZwKM1hn0zJgVfhtc80LSx5E3QVY1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRN3/4tDgMEgH2VK6Q2WmLGh3+mdpvWo9FKtGYdFLj8=;
 b=RNSp5IC66Xuu5JrugETRiDfCMY97WOsP6d+N+mhbAZWZUOMnglIje1ZzMlXsog/Gwf2x8aKPkLLmuxFTk+BsoFscietqT4lXpJDrm+zliYRM012UvHk5rDZ6lwLEM5IDnQfiDmT8+kB80w5EHD1Ov6kpFe425cP8Ar4l8UdZfmWmrxODtyUodT9uWjHqFvsaJ8n/8AXRyjaR6fb8qHWJXoGjbnOA8wEDKnqjk9aL2svMJo5Z8uWfqM0a/qXv+pzwQnJ9ZeAOwHnhY4M8/Xtz+mEfmD9XYMcgWPd4vojDwoDvxV6j7jILSPmY0cqB5ff75wp6GPWTOfc32LNQN1ipFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRN3/4tDgMEgH2VK6Q2WmLGh3+mdpvWo9FKtGYdFLj8=;
 b=T9e99oVxl2bDwXyhLNsDa1ADTKwo8qUXkJvzJfknhXiFEuKUFOeewipIXSK/SkRwj48tLDmFN22Z0XqymjngSjI3Rk9dcmw+vXj/AJpC33aFa4+ixz64XH2+5BebDNhV5oqxwHV+LtL3otv6in7trHao/TkGIwpsJYmysHpQHtV7bxcqlCShWJCDsOUFUqM4izW0zdwcw1msj93kOS+y5L/4IZcVJv8pJL3OFTSOAXO14+ktnwWyUGGCIWwYosfDgjIswZYOg1jg+crHsg7iQlbmAZIHlGmKBfq5T+LlJfxxj312OasRsCXlfk5LVwSXpj0loN8l+6ZzerXnTHauSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH7PR12MB7378.namprd12.prod.outlook.com (2603:10b6:510:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 15:05:10 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 15:05:10 +0000
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
Subject: [PATCH v13 04/24] Documentation: document netlink ULP_DDP_GET/SET messages
Date: Tue, 22 Aug 2023 15:04:05 +0000
Message-Id: <20230822150425.3390-5-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822150425.3390-1-aaptel@nvidia.com>
References: <20230822150425.3390-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0208.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::18) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH7PR12MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: 3430b642-37f9-46fa-3e58-08dba3212de2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MPuua4hut9izAguGJJsnjAwYmAqUBjpUK6ghQ+Apc+Oezhw2CGYRJI9sHKkB4XmFD1g5C46lO461dPi5Z0myefaCQFeI2Yj9OM7lqxI9tiwarBB67DsMWMmIaIQYQMC/Zq2OXP0l2/kEYtqIJpj3Eq21UvUnYISfTId0bW3kn3LP7sJsIiZ0ZWF5NNjw4qWGdVgzzeByaYIWMP/WB05+H4rUu+cuHKllR4eKozzWWs5TKEx+AIjrR/Tc/GDdlw29XTPR9gYGovpxvODiNBMM3Jw3gqSPshLUlyhiogBl9qrRHAI2UJctffGEoLhiMGwaMQu6zq7itdmAyQKffpiUa4lpCZTKLgw1AjAh94xbwgz9LaPLd5qnWdZwYCe83Q/xXoTW3lUxcRY9lXI2gk204Dm1xiR72noy+JS8kPGeAvkCd7/hqb01VpfJARJVx+Rk37lRrDKfGsj07+6QzMVPUVHKy7ruVaxAfI5PJ25qWYYYGoy6uNbKeGwrbdT0MYDqd6FxvIRL8NtBbX1xFrkqMiWiyeyfQYjIYs8L+nt6GiaVjXagu/gYlXVzJ0AC8rsY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(2906002)(83380400001)(7416002)(6506007)(6486002)(38100700002)(15650500001)(5660300002)(26005)(86362001)(8676002)(8936002)(2616005)(4326008)(107886003)(316002)(6512007)(66556008)(66476007)(478600001)(66946007)(6666004)(41300700001)(36756003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xcyejfop9GYS6JpgwADtbBQUxmGW0aZ7iMOQAmLR9YHAY3EZV4VUZysZubbF?=
 =?us-ascii?Q?hkUveSn5fC+T6dJZUFXFgAe5nMGzF/g0kJbJz1SD7dUj+PaoRv8ilnm9+UFQ?=
 =?us-ascii?Q?fDYP493ryt3s3IS5aC7cDjNaNMap7S5tsQImxLm4Hp0acmPaawg4Kg9jq560?=
 =?us-ascii?Q?oKPgjE2Ag61Up4N1hUVR3oKY7efU8N8reTzZxvpCjwVBNs1P2p2cRsodEQEk?=
 =?us-ascii?Q?AOPu7SDAl/LYk3KYoE9swFZUIlE1kS1LGjSfZMOj73GoGs1XAduNUT2t1FKX?=
 =?us-ascii?Q?d/b8UCqcl6PXpUl6c7gZyF2Ozc+rJ+zrU06/nPn1Dt2NQ22OlCr8kAMfhIe7?=
 =?us-ascii?Q?pX6S7169DHpq9FNPvIfKK/nOrSulzK/udZR0xhXTeqAxebpT3khEPpaVdcjv?=
 =?us-ascii?Q?yDejScaMTINPZATRye3VdQgBT6F3fCrWU81dH7l0CdP7zUIfhmkmb6k8Saen?=
 =?us-ascii?Q?jtLxN13kvcUt/KQZb55tGo+sdfnX6YXaDJrxISLjiS579Z2Kp46MVF0xo/78?=
 =?us-ascii?Q?pC8TIbCGB5V4MWvhFnx0JHCBe9iV8UssirKDNvs0gV7nCU896yz7zIqBuabU?=
 =?us-ascii?Q?OPX5qIGDqBGUX4l0lcNJwRxhtAE5tGpQkTOOvKV9z4UQ6vvM9ObjGI+9RciK?=
 =?us-ascii?Q?qDPh2yZV76yRQ8b62iaDWeFFzOPxKp6VpIi7wW1vXIujW/cVKBoKte9ishfI?=
 =?us-ascii?Q?RqP8K1zZett3Mu4sYB6kmZFZ84LtgPWkvWXEQIweZBN209Y6629XFi5a4JuO?=
 =?us-ascii?Q?S5oyGvyqQEnKl0LXwUtIAsc89E5fcHDG/BdC26PiiXYAoF7jbtk202fC3T1/?=
 =?us-ascii?Q?nwk2Fl2teukZxihC0qvE3NHLGAsxlXPbs2iaRaycs2Nmk3GA9LhWSeeO1Niq?=
 =?us-ascii?Q?zWyAAyE780U8HFvJ5SrzVoCSTlqX6jhr2n+yYtlkfPn7CJkpvqrgzkgpmS/9?=
 =?us-ascii?Q?RL+mkpnAvUEZWp6FDnSTTPCT4USNFMRGpY2FE5iW8c7r43Nu5Io4e1SBKa9z?=
 =?us-ascii?Q?VeEHNlzF4rgAvP/Q+2TckUGRjF4Qpj7j0duH5W3mV/V/opUHZ/621vIQ5tYu?=
 =?us-ascii?Q?QogN9xQdlPvGlQPLbD8MI2/AcmYV37jvxtLhcQgb1VkzGvU1dYDcFcw7g2aW?=
 =?us-ascii?Q?eIf84qzL3WoN5p8WH5Rxm0bxZXwD7lGrSeNUZ0K9U8KuzrgsxABC+5DgARjk?=
 =?us-ascii?Q?hMjZul/5r3d+IuETbf9mqc33uIrXFMyHGxqbQDWAvlHSdV0poNTPBSmq58Yh?=
 =?us-ascii?Q?Nsu3alALVA03agxX3o/sn3aT16WPt6tSHEpYy4RMyoMAjmX2TuFTzfR2Ji31?=
 =?us-ascii?Q?i3eHrmdsDuu1fEL2OPfz+G6dudDTdeL557F4HYpm1YsK1MbXiZx7BsYngUhR?=
 =?us-ascii?Q?xd1WY32eDdQsJgetMLBUaKcfrYjTGEMK1jAhsoX0cTCL0QWUiPFzu5F2yJG3?=
 =?us-ascii?Q?56LAxxndPqpVseXNbG9B8eDjRWRyDL+GJGNOGHFOcJwaoyCbkxMGfQTFqksc?=
 =?us-ascii?Q?N2E8lzAdReWM91XF9JL5lq6eWq2NBu/pmlKwRiKbgHvGnUxevgEMG+WncQCG?=
 =?us-ascii?Q?SAIHbN8eK/d1Hs3COGRlk4Q50yBwZ4opg4brHHmI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3430b642-37f9-46fa-3e58-08dba3212de2
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 15:05:10.3284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dRVDtL35u2kwyAo9XAWPoVPXzQuAQo+g6w5iStHYuFLGA8p4kEbvjKLL4MWy9z418ri746VgptvletbfMJm13Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7378
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
Acked-by: Jakub Kicinski <kuba@kernel.org>
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
index 2540c70952ff..1706634658e4 100644
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
+  ======================================================  ===  ===============
+  ``ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_SK_ADD``          u64  sockets successfully prepared for offloading
+  ``ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_SK_ADD_FAIL``     u64  sockets that failed to be prepared for offloading
+  ``ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_SK_DEL``          u64  sockets where offloading has been removed
+  ``ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_DDP_SETUP``       u64  PDUs successfully prepared for Direct Data Placement
+  ``ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_DDP_SETUP_FAIL``  u64  PDUs that failed DDP preparation
+  ``ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_DDP_TEARDOWN``    u64  PDUs done with DDP
+  ``ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_DROP``            u64  PDUs dropped
+  ``ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_RESYNC``          u64  resync
+  ``ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_PACKETS``         u64  offloaded PDUs
+  ``ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_BYTES``           u64  offloaded bytes
+  ======================================================  ===  ===============
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


