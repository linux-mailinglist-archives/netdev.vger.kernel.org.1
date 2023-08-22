Return-Path: <netdev+bounces-29662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9F77844FB
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 17:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96452280EE8
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 15:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346E91D2ED;
	Tue, 22 Aug 2023 15:05:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8751FD0
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 15:05:10 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20618.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::618])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76BF126
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 08:05:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8Qcx3S+dHDrqGbkVSJN6w48FmWYnRacnFxVozpO9Qxf5vrTnHIHkLDr+PrRAvJGjVzXwtLhXFsIn555fg/LSSrmJac8CDXCoBhxZCvbdsSc1CAxTvSvb259SP90SeI5Tns5Ftshwej6vgn3lzX0szIe9Qopy3qBFetosQIRyn1ltaBT7UdSeYRjTqT5icHdmy1v34jWHVaLQNbzMfiSVXgWTlW51xqqdoxmWZqY3A/fYpLzkLLDZ5vhYITG5KrpGFitXcm9I5tR4mW5l3lITLWo3mL4uBM1uHl+zr9q2zRMT4hS/kU44CI1yZ0u4T3Rms8G0p4lBzxyoXk9mW783g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvexkaUZHUR7wpF3V1R1w59/7V4KSV4u9u/5ZePODX4=;
 b=ICLbV/YfwzlK/CG0u7jjihgzRHAUQZwVEtsHCtcOfyMPHqT/b10awSU9NPD+rNlPSlmuBHBH4bTXArJGAxB3o6wvFWYlwwebHX/f1I3GVwTYVTqAHbGFsnK9omWHzQeOs8fvbY9foCyxWnzVNAfwUPbGwsTS+W7pggVVXtY9pZVpIvaa5luNUQ9Qi7d6AlpvAd9AvYE1L8waN3ssEsEBowbgCHOVXgpYDHOF43NCxvbL+W2fVXU8NcF1LI4xZNMJCPpZeh5ur3fL9P+jdHmTg8iT5m+JhIrMIznEDpaaRbJEJX5atFgzJrthmHvtZMDvGa31QFWO0xTpPIfVjGCxsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvexkaUZHUR7wpF3V1R1w59/7V4KSV4u9u/5ZePODX4=;
 b=s17ikRZ4PamXh5vsHrpVGQlGMus5BIdplrg2ApDdkfBpBpxFupz8bZ7/XJSWFymrPLAfqUeQD4wolxmEcK9a/mjQqdto6++kIezy4TJ23UxHmh5Lykvcp97HZjQ/2pUKFwiFCuinaJtqhtIfopKNUzKIl2cELGm7rXEkaVmMlu6uv+NwOrP1EbiqhOzpT38JJGOBALwR7itPO8ex1kONgoMWVZws+L6RgPzVkomX/5rYlRqDGUTr8+ocpf4ZETm29swm4UZLaWrJSeGsI36++Lh5Fe7wsxQwHUW3VC5r7k/RYNSwLqjVedNAVEpWlABEWsmbVwVAj2I1jLtJW7S/CQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH7PR12MB7378.namprd12.prod.outlook.com (2603:10b6:510:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 15:05:04 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 15:05:04 +0000
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
Subject: [PATCH v13 03/24] net/ethtool: add ULP_DDP_{GET,SET} operations for caps and stats
Date: Tue, 22 Aug 2023 15:04:04 +0000
Message-Id: <20230822150425.3390-4-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822150425.3390-1-aaptel@nvidia.com>
References: <20230822150425.3390-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::11) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH7PR12MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d012aa5-0965-42d8-fb7f-08dba3212a23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ntfWiWfaxLGbItjm1toMMuXVqPuAygEtnuzFg6C9qnXr5Qpdh+Lt5Evoqm0k+wo8q5hrLfkAoFiehTUJ3McwKdlSMjnSdY/Z+iovYfo9felaq2QnKI+phJIDzSo+JN7jXxgyPdEKSRQuVxJsGnUEtn1JTSjR2I4n6lCIC4azMhaZMn6UtNn0KcBKbm0+SKAqG/KfUo9pV7bLgIruX7bTmEnenoH2R3FEdB/QM1W10sKOASTVkE4s19kWbIF8OHALV6CnndFbFl3ANNlBseaA7NIXDbPR6joVFJoixkNQTKV/ONA1A0Fi3imGAxSbOwecV/nuu+6n6UI5i7Fn/1lTGK3ZF4E6w3FdhmCw5nTJ7h0gQgRkrIuhj7WxmM3ZIYhq7G/L/Rp7wfkconpoREyMxSzsapLGbPg2R4EUNXvg03Rca51gF560r7E0CQykPkyxDaG+vY/w7vg5EJuhsSS2wQRNo1FMr27ATdK1Yw8s3fHOwsDMwTdEenVplfptjMV9d+xsMdWdNvxE5kxJTb8zD/bTk6qV4I7x+CGLTRTdM1ofsUNYrfgDorUlpK4iNlGK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(2906002)(30864003)(83380400001)(7416002)(6506007)(6486002)(38100700002)(5660300002)(26005)(86362001)(8676002)(8936002)(2616005)(4326008)(107886003)(316002)(6512007)(66556008)(66476007)(478600001)(66946007)(41300700001)(36756003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/bYDEdYA3cOkkj6tfcy6HYQDGwKV5+K+U3T6PSRFeAzgdkltg+QMqivg1ypS?=
 =?us-ascii?Q?dW1LsBt6bKTbXpGKc+gqbTULs+YRrsHJvCe92UOoek3OpFztqLIrGF/fEmot?=
 =?us-ascii?Q?OE+WTr+bzqEy3VHM1LskR6NXk4IyB2LNjYfDKC3x6Cu/jns60iQNefbK7LUm?=
 =?us-ascii?Q?NJQI6AnhQyRHr9ToTLkg83vcwfaC+xRKNrhhIjP/Qo0BkBIRTB0idsbmeqlX?=
 =?us-ascii?Q?6AE3/MApVm58Mt+kUgomQ4TozD4WYOCplKipnU1JdLjjQ33n8WHLz/RuoiAu?=
 =?us-ascii?Q?z6NK/KeMJp6czdrZa4JELK7VnywfrKJtqLZ6J7VnJFQUnZj8xz11FwqKlQz9?=
 =?us-ascii?Q?/kxPdFbFFh1KCYyX56G25jvrIePqJqLlh38ZyjSCP/u9c3bgbiEDnmxCv9rj?=
 =?us-ascii?Q?wwHrJ1e2BpdPPDhMHAs3k8Cd3JDem7M8gQzRjyaQu2jcGeXX3sb4yUvsXpnp?=
 =?us-ascii?Q?/hDNlgoGkBtiyQ8/qmYIGs1vTgnrngNXlwjFJX7DH7jZtBdumG+/c/sBwYO4?=
 =?us-ascii?Q?HkInCk/QQUdQ/tAcuHglXY1FqtNkTIgBRr4RzrL53cg+HqJ3gEAW5f41lfOI?=
 =?us-ascii?Q?LHCJ1oz8IksvYYVaeKcjKnU66Atfysrr33KZOZxkdW21ya0DbgW8Sa63sJqN?=
 =?us-ascii?Q?SgPKMRFN+qlilXskzLJGmxXKhCfxggxsZ/tLVfhNIzFKmkpXuGYvHHIFD8iL?=
 =?us-ascii?Q?LwjO75rHOA7eHUK0OOo7Wqz6+3qITpinXGcRHzdriM8fCPNab8qPyRjyblhT?=
 =?us-ascii?Q?uyzqNA5l3TMKVCGeGoXTfuNlxyLDgbKmLc4ZFpcIMxtgTQmE0UAB6eaSevTx?=
 =?us-ascii?Q?M7+9qzpMIRsVvY8BKKWduq2XHsQT59GvuDkBlJXIuUu/tG0dMgF7/VOiEXhz?=
 =?us-ascii?Q?9w+u8TttV0kXfIDCcnJmcBz45r06p//ioeukHHPtBP2175F7c40HuPeuujte?=
 =?us-ascii?Q?RpMRInX8cHslSMbuJ+D/IQuujdbI8sI4ICz6kNn+PSkajG5rWwTLqE74f0zn?=
 =?us-ascii?Q?McGZeL8bfSpyYzEnWqNk1swbx+bg4Jc5ZlDsg2OXtMTUBvoAg+59VpLFTJVG?=
 =?us-ascii?Q?nVQvi9Tp5XgXugM45mquiZ+fd/TOz/ZPAYPIt102KyO5pRQPC1wvZW1/6y04?=
 =?us-ascii?Q?bIHzF004f4JWe1mVyPCxlXVq3rkXX4GsRTNCZqVgmtXjqqcRyMEJJyCYsUDC?=
 =?us-ascii?Q?G/e1CiI4wge5na3fUIHzG/KqN2T+4Di0UxaqsrEMwsJ03tE+lZL9mddYE6kD?=
 =?us-ascii?Q?25sdJy5kthKUHf+/6DZbpyWfHm58XGoLlPINxJ0QBX12rI5ODY/oSvh6+Shi?=
 =?us-ascii?Q?3Pa6KK7Pb1QBbd+SySnRLeRdZs7Ej8pukxOYBWQc/pV7SWRhHO8EAnJysztp?=
 =?us-ascii?Q?ZfAp5Eq4GV3wlKPPKoB8DJ+eqAQt96/gLAdtrHTTj1kaWFembfHb8iaR7Qv1?=
 =?us-ascii?Q?Oz96QzfU2S1fxFZW8uXtgQLFf02fUgHrYRCrBLZRxAaOuJi9+26iLd6fKnp1?=
 =?us-ascii?Q?cNBtDJXg1rMCvaJuNmViCkv9e2oGgstE0+KqCfs0LV8x2X/xAdT3o0cxyzOk?=
 =?us-ascii?Q?kRI2mlPBF5HwtlCTT59fdtgv4AlLdTQQtkUocpsq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d012aa5-0965-42d8-fb7f-08dba3212a23
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 15:05:04.1789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w7YrDfNmK18PVegeAwYwHnJypd6wOjVU2XV3n8TrY6y7b73fN0NJRA05tH+f8KIwDiOl8qkRGT1BD4jvhNoyyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7378
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This commit adds:

- 3 new netlink messages:
  * ULP_DDP_GET: returns a bitset of supported and active capabilities
  * ULP_DDP_SET: tries to activate requested bitset and returns results
  * ULP_DDP_NTF: notification for capabilities change

Rename and export bitset_policy for use in ulp_ddp.c.

ULP DDP capabilities handling is similar to netdev features
handling.

If a ULP_DDP_GET message has requested statistics via the
ETHTOOL_FLAG_STATS header flag, then statistics are returned to
userspace.

  ULP_DDP_GET request: (header only)
  ULP_DDP_GET reply:

      HW             (bitset)
      ACTIVE         (bitset)
      STATS          (nest, optional)
          STATS_xxxx (u64)
          ....

  ULP_DDP_SET request:
      WANTED         (bitset)
  ULP_DDP_SET reply:
      WANTED         (bitset)
      ACTIVE         (bitset)

Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
---
 include/uapi/linux/ethtool_netlink.h |  18 ++
 net/ethtool/Makefile                 |   2 +-
 net/ethtool/bitset.c                 |  20 +-
 net/ethtool/netlink.c                |  20 ++
 net/ethtool/netlink.h                |   4 +
 net/ethtool/ulp_ddp.c                | 316 +++++++++++++++++++++++++++
 6 files changed, 369 insertions(+), 11 deletions(-)
 create mode 100644 net/ethtool/ulp_ddp.c

diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index a9aebbe420c8..93bd5ca9bac3 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -57,6 +57,8 @@ enum {
 	ETHTOOL_MSG_PLCA_GET_STATUS,
 	ETHTOOL_MSG_MM_GET,
 	ETHTOOL_MSG_MM_SET,
+	ETHTOOL_MSG_ULP_DDP_GET,
+	ETHTOOL_MSG_ULP_DDP_SET,
 
 	/* add new constants above here */
 	__ETHTOOL_MSG_USER_CNT,
@@ -109,6 +111,9 @@ enum {
 	ETHTOOL_MSG_PLCA_NTF,
 	ETHTOOL_MSG_MM_GET_REPLY,
 	ETHTOOL_MSG_MM_NTF,
+	ETHTOOL_MSG_ULP_DDP_GET_REPLY,
+	ETHTOOL_MSG_ULP_DDP_SET_REPLY,
+	ETHTOOL_MSG_ULP_DDP_NTF,
 
 	/* add new constants above here */
 	__ETHTOOL_MSG_KERNEL_CNT,
@@ -977,6 +982,19 @@ enum {
 
 /* ULP DDP */
 
+enum {
+	ETHTOOL_A_ULP_DDP_UNSPEC,
+	ETHTOOL_A_ULP_DDP_HEADER,			/* nest - _A_HEADER_* */
+	ETHTOOL_A_ULP_DDP_HW,				/* bitset */
+	ETHTOOL_A_ULP_DDP_ACTIVE,			/* bitset */
+	ETHTOOL_A_ULP_DDP_WANTED,			/* bitset */
+	ETHTOOL_A_ULP_DDP_STATS,			/* nest - _A_ULP_DDP_STATS_* */
+
+	/* add new constants above here */
+	__ETHTOOL_A_ULP_DDP_CNT,
+	ETHTOOL_A_ULP_DDP_MAX = __ETHTOOL_A_ULP_DDP_CNT - 1
+};
+
 enum {
 	ETHTOOL_A_ULP_DDP_STATS_UNSPEC,
 	ETHTOOL_A_ULP_DDP_STATS_PAD,
diff --git a/net/ethtool/Makefile b/net/ethtool/Makefile
index 504f954a1b28..a2fdc5ed7655 100644
--- a/net/ethtool/Makefile
+++ b/net/ethtool/Makefile
@@ -8,4 +8,4 @@ ethtool_nl-y	:= netlink.o bitset.o strset.o linkinfo.o linkmodes.o rss.o \
 		   linkstate.o debug.o wol.o features.o privflags.o rings.o \
 		   channels.o coalesce.o pause.o eee.o tsinfo.o cabletest.o \
 		   tunnels.o fec.o eeprom.o stats.o phc_vclocks.o mm.o \
-		   module.o pse-pd.o plca.o mm.o
+		   module.o pse-pd.o plca.o ulp_ddp.o
diff --git a/net/ethtool/bitset.c b/net/ethtool/bitset.c
index 0515d6604b3b..1bef91fcce4b 100644
--- a/net/ethtool/bitset.c
+++ b/net/ethtool/bitset.c
@@ -302,7 +302,7 @@ int ethnl_put_bitset32(struct sk_buff *skb, int attrtype, const u32 *val,
 	return -EMSGSIZE;
 }
 
-static const struct nla_policy bitset_policy[] = {
+const struct nla_policy ethnl_bitset_policy[] = {
 	[ETHTOOL_A_BITSET_NOMASK]	= { .type = NLA_FLAG },
 	[ETHTOOL_A_BITSET_SIZE]		= NLA_POLICY_MAX(NLA_U32,
 							 ETHNL_MAX_BITSET_SIZE),
@@ -327,11 +327,11 @@ static const struct nla_policy bit_policy[] = {
  */
 int ethnl_bitset_is_compact(const struct nlattr *bitset, bool *compact)
 {
-	struct nlattr *tb[ARRAY_SIZE(bitset_policy)];
+	struct nlattr *tb[ARRAY_SIZE(ethnl_bitset_policy)];
 	int ret;
 
-	ret = nla_parse_nested(tb, ARRAY_SIZE(bitset_policy) - 1, bitset,
-			       bitset_policy, NULL);
+	ret = nla_parse_nested(tb, ARRAY_SIZE(ethnl_bitset_policy) - 1, bitset,
+			       ethnl_bitset_policy, NULL);
 	if (ret < 0)
 		return ret;
 
@@ -553,15 +553,15 @@ int ethnl_update_bitset32(u32 *bitmap, unsigned int nbits,
 			  const struct nlattr *attr, ethnl_string_array_t names,
 			  struct netlink_ext_ack *extack, bool *mod)
 {
-	struct nlattr *tb[ARRAY_SIZE(bitset_policy)];
+	struct nlattr *tb[ARRAY_SIZE(ethnl_bitset_policy)];
 	unsigned int change_bits;
 	bool no_mask;
 	int ret;
 
 	if (!attr)
 		return 0;
-	ret = nla_parse_nested(tb, ARRAY_SIZE(bitset_policy) - 1, attr,
-			       bitset_policy, extack);
+	ret = nla_parse_nested(tb, ARRAY_SIZE(ethnl_bitset_policy) - 1, attr,
+			       ethnl_bitset_policy, extack);
 	if (ret < 0)
 		return ret;
 
@@ -606,7 +606,7 @@ int ethnl_parse_bitset(unsigned long *val, unsigned long *mask,
 		       ethnl_string_array_t names,
 		       struct netlink_ext_ack *extack)
 {
-	struct nlattr *tb[ARRAY_SIZE(bitset_policy)];
+	struct nlattr *tb[ARRAY_SIZE(ethnl_bitset_policy)];
 	const struct nlattr *bit_attr;
 	bool no_mask;
 	int rem;
@@ -614,8 +614,8 @@ int ethnl_parse_bitset(unsigned long *val, unsigned long *mask,
 
 	if (!attr)
 		return 0;
-	ret = nla_parse_nested(tb, ARRAY_SIZE(bitset_policy) - 1, attr,
-			       bitset_policy, extack);
+	ret = nla_parse_nested(tb, ARRAY_SIZE(ethnl_bitset_policy) - 1, attr,
+			       ethnl_bitset_policy, extack);
 	if (ret < 0)
 		return ret;
 	no_mask = tb[ETHTOOL_A_BITSET_NOMASK];
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 3bbd5afb7b31..bc94c54027f2 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -306,6 +306,8 @@ ethnl_default_requests[__ETHTOOL_MSG_USER_CNT] = {
 	[ETHTOOL_MSG_PLCA_GET_STATUS]	= &ethnl_plca_status_request_ops,
 	[ETHTOOL_MSG_MM_GET]		= &ethnl_mm_request_ops,
 	[ETHTOOL_MSG_MM_SET]		= &ethnl_mm_request_ops,
+	[ETHTOOL_MSG_ULP_DDP_GET]	= &ethnl_ulp_ddp_request_ops,
+	[ETHTOOL_MSG_ULP_DDP_SET]	= &ethnl_ulp_ddp_request_ops,
 };
 
 static struct ethnl_dump_ctx *ethnl_dump_context(struct netlink_callback *cb)
@@ -638,6 +640,7 @@ ethnl_default_notify_ops[ETHTOOL_MSG_KERNEL_MAX + 1] = {
 	[ETHTOOL_MSG_MODULE_NTF]	= &ethnl_module_request_ops,
 	[ETHTOOL_MSG_PLCA_NTF]		= &ethnl_plca_cfg_request_ops,
 	[ETHTOOL_MSG_MM_NTF]		= &ethnl_mm_request_ops,
+	[ETHTOOL_MSG_ULP_DDP_NTF]	= &ethnl_ulp_ddp_request_ops,
 };
 
 /* default notification handler */
@@ -736,6 +739,7 @@ static const ethnl_notify_handler_t ethnl_notify_handlers[] = {
 	[ETHTOOL_MSG_MODULE_NTF]	= ethnl_default_notify,
 	[ETHTOOL_MSG_PLCA_NTF]		= ethnl_default_notify,
 	[ETHTOOL_MSG_MM_NTF]		= ethnl_default_notify,
+	[ETHTOOL_MSG_ULP_DDP_NTF]	= ethnl_default_notify,
 };
 
 void ethtool_notify(struct net_device *dev, unsigned int cmd, const void *data)
@@ -1128,6 +1132,22 @@ static const struct genl_ops ethtool_genl_ops[] = {
 		.policy = ethnl_mm_set_policy,
 		.maxattr = ARRAY_SIZE(ethnl_mm_set_policy) - 1,
 	},
+	{
+		.cmd    = ETHTOOL_MSG_ULP_DDP_GET,
+		.doit   = ethnl_default_doit,
+		.start  = ethnl_default_start,
+		.dumpit = ethnl_default_dumpit,
+		.done   = ethnl_default_done,
+		.policy = ethnl_ulp_ddp_get_policy,
+		.maxattr = ARRAY_SIZE(ethnl_ulp_ddp_get_policy) - 1,
+	},
+	{
+		.cmd	= ETHTOOL_MSG_ULP_DDP_SET,
+		.flags	= GENL_UNS_ADMIN_PERM,
+		.doit	= ethnl_default_set_doit,
+		.policy = ethnl_ulp_ddp_set_policy,
+		.maxattr = ARRAY_SIZE(ethnl_ulp_ddp_set_policy) - 1,
+	},
 };
 
 static const struct genl_multicast_group ethtool_nl_mcgrps[] = {
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 9a333a8d04c1..4e083f2ec55d 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -395,10 +395,12 @@ extern const struct ethnl_request_ops ethnl_rss_request_ops;
 extern const struct ethnl_request_ops ethnl_plca_cfg_request_ops;
 extern const struct ethnl_request_ops ethnl_plca_status_request_ops;
 extern const struct ethnl_request_ops ethnl_mm_request_ops;
+extern const struct ethnl_request_ops ethnl_ulp_ddp_request_ops;
 
 extern const struct nla_policy ethnl_header_policy[ETHTOOL_A_HEADER_FLAGS + 1];
 extern const struct nla_policy ethnl_header_policy_stats[ETHTOOL_A_HEADER_FLAGS + 1];
 extern const struct nla_policy ethnl_strset_get_policy[ETHTOOL_A_STRSET_COUNTS_ONLY + 1];
+extern const struct nla_policy ethnl_bitset_policy[ETHTOOL_A_BITSET_MASK + 1];
 extern const struct nla_policy ethnl_linkinfo_get_policy[ETHTOOL_A_LINKINFO_HEADER + 1];
 extern const struct nla_policy ethnl_linkinfo_set_policy[ETHTOOL_A_LINKINFO_TP_MDIX_CTRL + 1];
 extern const struct nla_policy ethnl_linkmodes_get_policy[ETHTOOL_A_LINKMODES_HEADER + 1];
@@ -441,6 +443,8 @@ extern const struct nla_policy ethnl_plca_set_cfg_policy[ETHTOOL_A_PLCA_MAX + 1]
 extern const struct nla_policy ethnl_plca_get_status_policy[ETHTOOL_A_PLCA_HEADER + 1];
 extern const struct nla_policy ethnl_mm_get_policy[ETHTOOL_A_MM_HEADER + 1];
 extern const struct nla_policy ethnl_mm_set_policy[ETHTOOL_A_MM_MAX + 1];
+extern const struct nla_policy ethnl_ulp_ddp_get_policy[ETHTOOL_A_ULP_DDP_HEADER + 1];
+extern const struct nla_policy ethnl_ulp_ddp_set_policy[ETHTOOL_A_ULP_DDP_WANTED + 1];
 
 int ethnl_set_features(struct sk_buff *skb, struct genl_info *info);
 int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info);
diff --git a/net/ethtool/ulp_ddp.c b/net/ethtool/ulp_ddp.c
new file mode 100644
index 000000000000..9d67af5cac5d
--- /dev/null
+++ b/net/ethtool/ulp_ddp.c
@@ -0,0 +1,316 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *
+ * ulp_ddp.c
+ *     Author: Aurelien Aptel <aaptel@nvidia.com>
+ *     Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
+ */
+
+#include "netlink.h"
+#include "common.h"
+#include "bitset.h"
+#include <net/ulp_ddp.h>
+
+#define ETHTOOL_ULP_DDP_STATS_CNT \
+	(__ETHTOOL_A_ULP_DDP_STATS_CNT - (ETHTOOL_A_ULP_DDP_STATS_PAD + 1))
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
+/* ULP_DDP_GET */
+
+struct ulp_ddp_req_info {
+	struct ethnl_req_info	base;
+};
+
+struct ulp_ddp_reply_data {
+	struct ethnl_reply_data	base;
+	DECLARE_BITMAP(hw, ULP_DDP_C_COUNT);
+	DECLARE_BITMAP(active, ULP_DDP_C_COUNT);
+	struct ethtool_ulp_ddp_stats stats;
+};
+
+#define ULP_DDP_REPDATA(__reply_base) \
+	container_of(__reply_base, struct ulp_ddp_reply_data, base)
+
+const struct nla_policy ethnl_ulp_ddp_get_policy[] = {
+	[ETHTOOL_A_ULP_DDP_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy_stats),
+};
+
+static int ulp_ddp_put_stats64(struct sk_buff *skb, int attrtype, const u64 *val,
+			       unsigned int count)
+{
+	unsigned int i, attr;
+	struct nlattr *nest;
+
+	nest = nla_nest_start(skb, attrtype);
+	if (!nest)
+		return -EMSGSIZE;
+
+	/* skip attributes unspec & pad */
+	attr = ETHTOOL_A_ULP_DDP_STATS_PAD + 1;
+	for (i = 0 ; i < count; i++, attr++)
+		if (nla_put_u64_64bit(skb, attr, val[i], ETHTOOL_A_ULP_DDP_STATS_PAD))
+			goto nla_put_failure;
+
+	nla_nest_end(skb, nest);
+	return 0;
+
+nla_put_failure:
+	nla_nest_cancel(skb, nest);
+	return -EMSGSIZE;
+}
+
+static int ulp_ddp_prepare_data(const struct ethnl_req_info *req_base,
+				struct ethnl_reply_data *reply_base,
+				const struct genl_info *info)
+{
+	const struct ulp_ddp_dev_ops *ops = netdev_ulp_ddp_ops(reply_base->dev);
+	struct ulp_ddp_netdev_caps *caps = netdev_ulp_ddp_caps(reply_base->dev);
+	struct ulp_ddp_reply_data *data = ULP_DDP_REPDATA(reply_base);
+
+	if (!caps || !ops)
+		return -EOPNOTSUPP;
+
+	bitmap_copy(data->hw, caps->hw, ULP_DDP_C_COUNT);
+	bitmap_copy(data->active, caps->active, ULP_DDP_C_COUNT);
+
+	if (req_base->flags & ETHTOOL_FLAG_STATS) {
+		if (!ops->get_stats)
+			return -EOPNOTSUPP;
+		ops->get_stats(reply_base->dev, &data->stats);
+	}
+	return 0;
+}
+
+static int ulp_ddp_reply_size(const struct ethnl_req_info *req_base,
+			      const struct ethnl_reply_data *reply_base)
+{
+	const struct ulp_ddp_reply_data *data = ULP_DDP_REPDATA(reply_base);
+	bool compact = req_base->flags & ETHTOOL_FLAG_COMPACT_BITSETS;
+	unsigned int len = 0;
+	int ret;
+
+	ret = ethnl_bitset_size(data->hw, NULL, ULP_DDP_C_COUNT,
+				ulp_ddp_caps_names, compact);
+	if (ret < 0)
+		return ret;
+	len += ret;
+	ret = ethnl_bitset_size(data->active, NULL, ULP_DDP_C_COUNT,
+				ulp_ddp_caps_names, compact);
+	if (ret < 0)
+		return ret;
+	len += ret;
+
+	if (req_base->flags & ETHTOOL_FLAG_STATS) {
+		len += nla_total_size_64bit(sizeof(u64)) * ETHTOOL_ULP_DDP_STATS_CNT;
+		len += nla_total_size(0); /* nest */
+	}
+	return len;
+}
+
+static int ulp_ddp_fill_reply(struct sk_buff *skb,
+			      const struct ethnl_req_info *req_base,
+			      const struct ethnl_reply_data *reply_base)
+{
+	const struct ulp_ddp_reply_data *data = ULP_DDP_REPDATA(reply_base);
+	bool compact = req_base->flags & ETHTOOL_FLAG_COMPACT_BITSETS;
+	int ret;
+
+	ret = ethnl_put_bitset(skb, ETHTOOL_A_ULP_DDP_HW, data->hw,
+			       NULL, ULP_DDP_C_COUNT,
+			       ulp_ddp_caps_names, compact);
+	if (ret < 0)
+		return ret;
+
+	ret = ethnl_put_bitset(skb, ETHTOOL_A_ULP_DDP_ACTIVE, data->active,
+			       NULL, ULP_DDP_C_COUNT,
+			       ulp_ddp_caps_names, compact);
+	if (ret < 0)
+		return ret;
+
+	if (req_base->flags & ETHTOOL_FLAG_STATS) {
+		ret = ulp_ddp_put_stats64(skb, ETHTOOL_A_ULP_DDP_STATS,
+					  (u64 *)&data->stats,
+					  ETHTOOL_ULP_DDP_STATS_CNT);
+		if (ret < 0)
+			return ret;
+	}
+	return ret;
+}
+
+/* ULP_DDP_SET */
+
+const struct nla_policy ethnl_ulp_ddp_set_policy[] = {
+	[ETHTOOL_A_ULP_DDP_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy),
+	[ETHTOOL_A_ULP_DDP_WANTED] = NLA_POLICY_NESTED(ethnl_bitset_policy),
+};
+
+static int ulp_ddp_send_reply(struct net_device *dev, struct genl_info *info,
+			      const unsigned long *wanted,
+			      const unsigned long *wanted_mask,
+			      const unsigned long *active,
+			      const unsigned long *active_mask, bool compact)
+{
+	struct sk_buff *rskb;
+	void *reply_payload;
+	int reply_len = 0;
+	int ret;
+
+	reply_len = ethnl_reply_header_size();
+	ret = ethnl_bitset_size(wanted, wanted_mask, ULP_DDP_C_COUNT,
+				ulp_ddp_caps_names, compact);
+	if (ret < 0)
+		goto err;
+	reply_len += ret;
+	ret = ethnl_bitset_size(active, active_mask, ULP_DDP_C_COUNT,
+				ulp_ddp_caps_names, compact);
+	if (ret < 0)
+		goto err;
+	reply_len += ret;
+
+	rskb = ethnl_reply_init(reply_len, dev, ETHTOOL_MSG_ULP_DDP_SET_REPLY,
+				ETHTOOL_A_ULP_DDP_HEADER, info,
+				&reply_payload);
+	if (!rskb) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	ret = ethnl_put_bitset(rskb, ETHTOOL_A_ULP_DDP_WANTED, wanted,
+			       wanted_mask, ULP_DDP_C_COUNT,
+			       ulp_ddp_caps_names, compact);
+	if (ret < 0)
+		goto nla_put_failure;
+	ret = ethnl_put_bitset(rskb, ETHTOOL_A_ULP_DDP_ACTIVE, active,
+			       active_mask, ULP_DDP_C_COUNT,
+			       ulp_ddp_caps_names, compact);
+	if (ret < 0)
+		goto nla_put_failure;
+
+	genlmsg_end(rskb, reply_payload);
+	ret = genlmsg_reply(rskb, info);
+	return ret;
+
+nla_put_failure:
+	nlmsg_free(rskb);
+	WARN_ONCE(1, "calculated message payload length (%d) not sufficient\n",
+		  reply_len);
+err:
+	GENL_SET_ERR_MSG(info, "failed to send reply message");
+	return ret;
+}
+
+static int ulp_ddp_set_validate(struct ethnl_req_info *req_info, struct genl_info *info)
+{
+	const struct ulp_ddp_dev_ops *ops;
+
+	if (GENL_REQ_ATTR_CHECK(info, ETHTOOL_A_ULP_DDP_WANTED))
+		return -EINVAL;
+
+	ops = netdev_ulp_ddp_ops(req_info->dev);
+	if (!ops || !ops->set_caps || !netdev_ulp_ddp_caps(req_info->dev))
+		return -EOPNOTSUPP;
+
+	return 1;
+}
+
+static int ulp_ddp_set(struct ethnl_req_info *req_info, struct genl_info *info)
+{
+	DECLARE_BITMAP(old_active, ULP_DDP_C_COUNT);
+	DECLARE_BITMAP(new_active, ULP_DDP_C_COUNT);
+	DECLARE_BITMAP(req_wanted, ULP_DDP_C_COUNT);
+	DECLARE_BITMAP(req_mask, ULP_DDP_C_COUNT);
+	DECLARE_BITMAP(all_bits, ULP_DDP_C_COUNT);
+	DECLARE_BITMAP(tmp, ULP_DDP_C_COUNT);
+	const struct ulp_ddp_dev_ops *ops;
+	struct ulp_ddp_netdev_caps *caps;
+	int ret;
+
+	caps = netdev_ulp_ddp_caps(req_info->dev);
+	ops = netdev_ulp_ddp_ops(req_info->dev);
+	ret = ethnl_parse_bitset(req_wanted, req_mask, ULP_DDP_C_COUNT,
+				 info->attrs[ETHTOOL_A_ULP_DDP_WANTED],
+				 ulp_ddp_caps_names, info->extack);
+	if (ret < 0)
+		return ret;
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
+		ret = ops->set_caps(req_info->dev, new_active, info->extack);
+		if (ret < 0)
+			return ret;
+		bitmap_copy(new_active, caps->active, ULP_DDP_C_COUNT);
+	}
+
+	if (!(req_info->flags & ETHTOOL_FLAG_OMIT_REPLY)) {
+		bool compact = req_info->flags & ETHTOOL_FLAG_COMPACT_BITSETS;
+		DECLARE_BITMAP(wanted_diff_mask, ULP_DDP_C_COUNT);
+		DECLARE_BITMAP(active_diff_mask, ULP_DDP_C_COUNT);
+
+		/* wanted_diff_mask = req_wanted ^ new_active
+		 * active_diff_mask = old_active ^ new_active -> mask of bits that have changed
+		 * wanted_diff_mask &= req_mask    -> mask of bits that have diff value than wanted
+		 * req_wanted &= wanted_diff_mask  -> bits that have diff value than wanted
+		 * new_active &= active_diff_mask  -> bits that have changed
+		 */
+		bitmap_xor(wanted_diff_mask, req_wanted, new_active, ULP_DDP_C_COUNT);
+		bitmap_xor(active_diff_mask, old_active, new_active, ULP_DDP_C_COUNT);
+		bitmap_and(wanted_diff_mask, wanted_diff_mask, req_mask, ULP_DDP_C_COUNT);
+		bitmap_and(req_wanted, req_wanted, wanted_diff_mask,  ULP_DDP_C_COUNT);
+		bitmap_and(new_active, new_active, active_diff_mask,  ULP_DDP_C_COUNT);
+		ret = ulp_ddp_send_reply(req_info->dev, info,
+					 req_wanted, wanted_diff_mask,
+					 new_active, active_diff_mask,
+					 compact);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* return 1 to notify */
+	return bitmap_equal(old_active, new_active, ULP_DDP_C_COUNT);
+}
+
+const struct ethnl_request_ops ethnl_ulp_ddp_request_ops = {
+	.request_cmd		= ETHTOOL_MSG_ULP_DDP_GET,
+	.reply_cmd		= ETHTOOL_MSG_ULP_DDP_GET_REPLY,
+	.hdr_attr		= ETHTOOL_A_ULP_DDP_HEADER,
+	.req_info_size		= sizeof(struct ulp_ddp_req_info),
+	.reply_data_size	= sizeof(struct ulp_ddp_reply_data),
+
+	.prepare_data		= ulp_ddp_prepare_data,
+	.reply_size		= ulp_ddp_reply_size,
+	.fill_reply		= ulp_ddp_fill_reply,
+
+	.set_validate		= ulp_ddp_set_validate,
+	.set			= ulp_ddp_set,
+	.set_ntf_cmd		= ETHTOOL_MSG_ULP_DDP_NTF,
+};
-- 
2.34.1


