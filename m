Return-Path: <netdev+bounces-17232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FB9750E2A
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 18:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F31561C211EC
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 16:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8C521512;
	Wed, 12 Jul 2023 16:16:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC2221510
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 16:16:49 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2068.outbound.protection.outlook.com [40.107.95.68])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA2B1BFC
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 09:16:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kc3u624bjkg+8EX1myDaZ/7/bUqTBbErYHqji/Tob/OKlX8paoM/6pyn0rzd7MtGJ/2dwq/LhiQQD4KphyQg/o+aIHgg/8yxBE0iLmnBCfZZrwEjL1vXJwU0nXKXAfFoLEAg4tvGaZr2F2AYW2En7S/19V9zdhLgn+XxXBmEFhtMMrqIPm7hyJLHe4g8Ds2IVwTsbI0K4HbD1QYNAiL7iVKi1ZujWNVkYE+8VulVUzY0l0tuMuauaVMPn6Zj/xDbBzu4/aFtDm+NhSNM+SDn7tTh0y9NFG2j8axFi8MAlPsmOjbqvJsnxywXqD1ColfuP2pJNkPnjXrlIwxUTv4DHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ly3lFtXI9NdSZNmIFJb/xY/L5foycorQr3fO0VpWxAE=;
 b=Bph5L81U0vowhrwtlMfomhztHtS7g08Mq2VuXULKzKeViMW1pkUQO52bEwqqZluMOo/1cs2cSi0ocJ6vTcCatsAf3xCRm8EYjMJ2NygOcnjDsLOz7ArcfDC9BGPC4jqwWDtPxx8cYInp25oklPV6sOnNGq/4KK8mEJj5n/RxHrpdY2shMuGdFQ0JQM/AS9odA4dWsFRy7P66p5J16xHm1VkdT+mtNjogySZdLjYzanbqOs7PKUhCvlu3Y1S3wHNiZJr77QgyjV3qrYWcYphDu5CXjp+8a5/w+HXdPS4arSme14O8WyusmqWP/X99R8y6AkLFQalwe5wr0QJ7vDsJ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ly3lFtXI9NdSZNmIFJb/xY/L5foycorQr3fO0VpWxAE=;
 b=Cp4uMwz8JLanKVDdE97k6Wd90bQf2YpbJuaft3SObL+I0NwQ0nSQy3me/pAG2NBge8nBAUB+p8lQF6d7yzfviw4+Hgu5d7cn+dniU2UqmQdhggGnAbq+kAl6ea+eyv/MfQiAZXbSbE4bS5uphpznor4u0Ui+fKDlEJyndqOeepbOzNJlJ+KUhbriM4ViAVPK5pEAwSA4Yv6dQeAqxHNstLYdQ1AxWaw1kF0Vba5I8a3QUO9lzuwslKtnaVpk24yRGmpQpyq8lS5AtzQRm9iovTIH7cjm11+b3vIzpvDBVoroUNwQfbepcT5QoaCDSeStzb9dF1r0mLmj6Di9VexFDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH7PR12MB7212.namprd12.prod.outlook.com (2603:10b6:510:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 16:16:40 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3f6a:7977:dcd4:9ad1]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3f6a:7977:dcd4:9ad1%4]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 16:16:40 +0000
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
Subject: [PATCH v12 03/26] net/ethtool: add ULP_DDP_{GET,SET} operations for caps and stats
Date: Wed, 12 Jul 2023 16:14:50 +0000
Message-Id: <20230712161513.134860-4-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712161513.134860-1-aaptel@nvidia.com>
References: <20230712161513.134860-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::12) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH7PR12MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: e8cbf1c4-9804-4b9b-24c4-08db82f36025
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6jm87B4/CCmkS1jOZVmT0CVq19hScft4sFAXnjVvZBtlTUnA8FPTLIS5FHhALOSMOSOtGJwrd7RMLOQPYLUETcf+oHxm3w/Xr2wnrSiQj/RkLRw45O1ozuyFDxou2ZNO4+iQ8krM4UmVKT6EijMj+hrD4gnLvcl1b4CG4kdqWrP3GTc+FYsg6rxpUIeJ9xsDQ7ZyJDjyz2wdtq2O99DiarvLyHj/6DT/CguZqtNu7zNu1HVzOuDb1+kJMn/ibqspwcWs/JRi+1UwXBUtDm7kw1U+EedbviYYEv7nu86TWUwnZ6SMIrPV+j11juto+xDeCcf7+nNNdX6dKKxSgjEp7mgXOy619HJkCC3DoBr1/4cyBlIYmfeBeJgZwUeO8j6PDWTztUNRZBI3MuEMcKWKz3LKQaUxSRvNasu22+rIMe/tHgpMPtl2MQehgdVzzHtF/KhMkGkUAehwYWxsUUgOcqwb/AGI9iTLSN6B9HXu+SREv6HtVv1dRqJ+VIMHRfc8slzjkSxijuvI+t3GJwknVcv7LXWMQjZjOrug0zKVuOeBT8HQjg4CcyH4XEYqtb0W
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199021)(186003)(2616005)(86362001)(66476007)(66946007)(66556008)(316002)(83380400001)(107886003)(4326008)(6512007)(1076003)(26005)(6506007)(478600001)(2906002)(6486002)(36756003)(30864003)(6666004)(38100700002)(41300700001)(7416002)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VVuTqBVDx2KTdT9wmPJXMn5r0e1oENrhjGrJt5by4NFMbuHDo7E7AHUiEw8M?=
 =?us-ascii?Q?NpEfS5+RYi802G+VokpYaVbTnu3xzUWn+eLp+QZK3Ua6V8gllXZyaS1Cmbkn?=
 =?us-ascii?Q?2lHhZYzyTIioMEosoGKm12g+iTwfDmPyPBE6BjMMwJ2OUwIoOMRcBgbF315/?=
 =?us-ascii?Q?eONcmPZWTtjiBLw25iAmHimh0eNXzCpYdoqPAh5cPDbfHldxZ6+YPJgK7cv5?=
 =?us-ascii?Q?JOEUT7CDhBz3DxdhV7mpaudqP+aKR7Yb6qnoXCKhFC/9qT1CRImvbCa7+/LU?=
 =?us-ascii?Q?mTA0T/1YuFT92cqwd1/g4FFm1VSl7N2wNHEIDDTkOub7cTk/neYhBr+5Evcw?=
 =?us-ascii?Q?sSQcG+0teD1rMUYdGtpsGDVPIo24CMiWwLOszEqYmkla+qwZKt7b6SiXAyq3?=
 =?us-ascii?Q?jrG78h4AfNBiiVNdHp1zxSqOlC+rb6/APJokjKtnpG/0aHoimBpsA8yScM4s?=
 =?us-ascii?Q?dMAaia2UrFntPzeesDrwb6qOFBHqXB9aP1QjKQ118HtAgVj7Y7+wOa2hQciH?=
 =?us-ascii?Q?bEVNn03j0OVpHQRk86bnwRl/93rXx3Pm011KY8j+gemKGqFKXjd8Lk79MMFV?=
 =?us-ascii?Q?koKq+Ccz601ukiKKhEjexYrGvf5H1jnaW56txjHPm9yDRTTg0snaKSd/HHzE?=
 =?us-ascii?Q?C2Q2zFioxW206FStwtQFdLBakVO4Cx+FrttA3agVIOiyM2Nd3qZBW4ia+/3z?=
 =?us-ascii?Q?kRPtxt+bZHCNVsRirD9ngEOUBMgVPWLR3G9YYDT/gKovmKAQlgUiuWRfMYRK?=
 =?us-ascii?Q?Wr0tIH7MfhEfY8B7YVF9rljfsWCgiQIhRdYXZFfau+RlGEECIkNiJdfaekFR?=
 =?us-ascii?Q?2sQmeKp3A+g8Xzh2x/hslP+v9A549crj4t6Hh3S5GPNX830TSVDinTTxemZ/?=
 =?us-ascii?Q?7r4R/h2ze9aRv8r3jMY2PzQKuP4RZtOArhX4pC9BpEPcRAKdO0z5LDIvNKLL?=
 =?us-ascii?Q?78HxNyRNMroLKd8ywIL5Omr1n6nyAC/WQYXokU2LUjRkRwMTf4uKru/Gymqs?=
 =?us-ascii?Q?Ycgq5ZA8Yze/uzejJFeJozGWpBdHICrskjJX/N7ebmUbwTH5+mozEkNs+vA3?=
 =?us-ascii?Q?nGIy8DKpb3Crmb1X9Fw0o2LOp5VYkOKEaFpHlgBDmiZ37cQ5MvEtO3aYKHjO?=
 =?us-ascii?Q?Wsow3T3RNSOHCvmeTMxDbwaDB+hEgYxfZezKHoMcJaWWafCz4iesptCjM5Ln?=
 =?us-ascii?Q?je1+/oeVqXJl2E9PvcnZN0bFmPSEHviCpPXnzAvrEy1yNFeHC6G+tT/ep8EH?=
 =?us-ascii?Q?0TbwzNAX4WrxGk9p35y6SzU12SabJyjaeLh6ewEk+R5WOh1eBxjlQuLiqGBP?=
 =?us-ascii?Q?kB+mUlKkMzwuhgFDdg81knXsdtq4gLLxTU28bmKnn8sNdirR3l/HuPogWwh4?=
 =?us-ascii?Q?2OqA0zdk05/ujKn++BKrJCDeVyCXO2sIoCdE4/tBVEtsY3pDMw52S/cqLnrQ?=
 =?us-ascii?Q?/328aAXOeTHLmXMe8vFbYyczUE/lQaLQZXzwcVtM2BxzPKIiuKsGupO8nJ7i?=
 =?us-ascii?Q?YcnFnmVs80nZ020JUzXvYtz2oQaNjWffbEJsldc9aPWXIe6PtDnbLz2rxp2C?=
 =?us-ascii?Q?OzveGu/P/h5SPml05fhgWd+Ca+7I7SaTvZF7ITxF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8cbf1c4-9804-4b9b-24c4-08db82f36025
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 16:16:40.7635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3gpYUP+A6MDKU+VQam27thNhwfl91zMVfFC9j0NUgs2sQ90o0WN9wHN8mttLEonDQANkVjwPzRSHDUZvj0AMmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7212
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
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
index 39a459b0111b..11c680b4e9f7 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -308,6 +308,8 @@ ethnl_default_requests[__ETHTOOL_MSG_USER_CNT] = {
 	[ETHTOOL_MSG_PLCA_GET_STATUS]	= &ethnl_plca_status_request_ops,
 	[ETHTOOL_MSG_MM_GET]		= &ethnl_mm_request_ops,
 	[ETHTOOL_MSG_MM_SET]		= &ethnl_mm_request_ops,
+	[ETHTOOL_MSG_ULP_DDP_GET]	= &ethnl_ulp_ddp_request_ops,
+	[ETHTOOL_MSG_ULP_DDP_SET]	= &ethnl_ulp_ddp_request_ops,
 };
 
 static struct ethnl_dump_ctx *ethnl_dump_context(struct netlink_callback *cb)
@@ -671,6 +673,7 @@ ethnl_default_notify_ops[ETHTOOL_MSG_KERNEL_MAX + 1] = {
 	[ETHTOOL_MSG_MODULE_NTF]	= &ethnl_module_request_ops,
 	[ETHTOOL_MSG_PLCA_NTF]		= &ethnl_plca_cfg_request_ops,
 	[ETHTOOL_MSG_MM_NTF]		= &ethnl_mm_request_ops,
+	[ETHTOOL_MSG_ULP_DDP_NTF]	= &ethnl_ulp_ddp_request_ops,
 };
 
 /* default notification handler */
@@ -766,6 +769,7 @@ static const ethnl_notify_handler_t ethnl_notify_handlers[] = {
 	[ETHTOOL_MSG_MODULE_NTF]	= ethnl_default_notify,
 	[ETHTOOL_MSG_PLCA_NTF]		= ethnl_default_notify,
 	[ETHTOOL_MSG_MM_NTF]		= ethnl_default_notify,
+	[ETHTOOL_MSG_ULP_DDP_NTF]	= ethnl_default_notify,
 };
 
 void ethtool_notify(struct net_device *dev, unsigned int cmd, const void *data)
@@ -1158,6 +1162,22 @@ static const struct genl_ops ethtool_genl_ops[] = {
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
index 79424b34b553..2e8c4090d91b 100644
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
index 000000000000..e5451689fef9
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
+	struct nlattr *nest;
+	unsigned int i, attr;
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
+				struct genl_info *info)
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


