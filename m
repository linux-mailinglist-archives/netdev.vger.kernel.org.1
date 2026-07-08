Return-Path: <netdev+bounces-305792-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LcBvEr5DTmqHJwIAu9opvQ
	(envelope-from <netdev+bounces-305792-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 14:34:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B9372655C
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 14:34:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=TNk8WdOc;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305792-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305792-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1EEA30B6DB5
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 12:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD88743E4B0;
	Wed,  8 Jul 2026 12:29:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012037.outbound.protection.outlook.com [52.101.53.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549FB43E492
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 12:29:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783513759; cv=fail; b=R9MOPMFSTYkM8LRritkFHPsAooKbk9c2qSHp1dNfnyF9EHCBWxu0GT2tBhiVqTpDcXKrRSGs9xBK/0QE006W7wkbSWCaqVb+LZD28nzXChrA+F+pYzJ2hjxBFd9GjKDU2yDSWhPvdODLMb94Sgw0DzabYnD6zhLqbxzmzJH7aBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783513759; c=relaxed/simple;
	bh=/pK9qsDSwBFMPnNfR6Nmhwo1ML38JHyYLYH1Ia9FC7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mKG7OReRuBbcpIuZPoEd3aNi/Pn+a//prw4ztJiQeCfkPsCs8V5WH7X5XB9EsRlAwvz1pji9BobTXvllGzs1OlGwXGGzeNgshPZyDsS5p3zQXOQWyE0N1iBf1ltZAyFEGG6xv4HmdXZTa6Ne+qQjC9jmT3+5pUtW8Xy1yUjvR58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TNk8WdOc; arc=fail smtp.client-ip=52.101.53.37
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7o3ShBqT3K7cBP4VyiWKQEAs0hvs2/vGtvwMbByB2dBpfRPHjnz8VIqVop4/TJiKxCWtdRqTkQz4HD4gIvbHJRfGdfZam1YRSqtRSy7EhzTd+6C/XcSbV3gzCrcbtzGqNk0sM4y4aVW8ZI97aUvddO8T8XPFQjN/6Fz7rHIdIgx2rEIJFvOnnnLiwe0jkvU7ZIxNv/2VWv1S4bLBuSjtScVxZKGBcVL3fwAPHkMKbPEHnFHs4KKGZ0C2DxJYQ6AMFs23MjzrbXKmt+VIpfY5GL2lSQid25b8rWIIsjKr7nwb6450XKla4QXeidUKhK7gkVCITFgJGwrvoYzY2WIBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5MuIeljnNlYS+DNIzui0QXTOzXDpGt8qTNPU+vfNnw=;
 b=EbTJNXBHxdDcYBTtPO/hX6f9K8sNIil4VEzsSkv2edJj/RjAvVGo9KWucjcmrvAWrbItF9mecGaawd33H8ssjbrsp194CwyilS8NUxeDMYVPOgDLV+J1OUPElLR7g7dJvX9vmd95QbhWE6g7K66hH/68v2JIhZF7DKYaU54plZwIEEXz9FzjecGMmuKWH5A4Pikg7eiyFZbi8DwnJ7W5nNs0FwifuWSrcvGagq6gCNKmnuIELaW0B/zx/glavCdeam8JP3w8p119HR1Tb4Blk0pslOp6hzKD9eEVDdEFbR3mkBF7OJIttDTMx4+15Ch7GJU95rohNdBxfzwOmZkT1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5MuIeljnNlYS+DNIzui0QXTOzXDpGt8qTNPU+vfNnw=;
 b=TNk8WdOc/KbBWlcM/JHjcG7X23ixgEXLEsKsFAKt2jaXbWNEhxoEOm/inWvejMZVlpjpPJxH3FRzL9nc9l8OKcAjikWXoTxr/SrHLmMKkzy95Lc8EXXdhM1I86fUoJrulowkmV177MFeDogELEBDkunchT16hu5QMv3XwC7F3BGsk3XTscM2hocqBMwa1KphfQTrxNfNjdKWGX7aX+q/PYAJ5uCQR+EjdOERXUh+DXFLU2LEMON/rzkTkTsPEIQm5GiG83jYeWRi1JNy4nEZocvo7x3H55ENbJXn9DoOfz+pFDYfcp2TbJeT2IHkayvjkx4VQBbrfhY3RoNxYvCcHw==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DM4PR12MB6637.namprd12.prod.outlook.com (2603:10b6:8:bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 12:29:13 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0181.010; Wed, 8 Jul 2026
 12:29:11 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org,
	bridge@lists.linux.dev
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	razor@blackwall.org,
	petrm@nvidia.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v3 2/2] bridge: mcast: Remove unnecessary argument from br_multicast_alloc_query()
Date: Wed,  8 Jul 2026 15:28:20 +0300
Message-ID: <20260708122820.1298718-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708122820.1298718-1-idosch@nvidia.com>
References: <20260708122820.1298718-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0361.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::17) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DM4PR12MB6637:EE_
X-MS-Office365-Filtering-Correlation-Id: 278989b4-5e79-4049-f698-08dedcec8388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	NRLK/daV7oNLoTGb+H2Pc7F2KlTbD5QrzJybi4sWDXeBMslUynx83S0iBpV/VvRdbWmSFS/y/xL84gZpGHj51dFx3Yb2UGoq+1oNPWiy6a7oSSTBWtFp2nqofK750fgvMMIWq0skDzK+sS/IwMZ1DVSv0BjGGmLNat8WL5mvHPI0KlWDmi8Xa7Ut7HuOnzspknkr5sRovsa2stDafAinvtdnaWgAj3SU4kZM6vkhA+fW5zt7VgSry3vzxXyRM95YAq/r7wGqj+YAmXFXP21b+hXwchpJkGTojgncK4ptNm3vd6Psev7yTFCR1sTWP3qkY5VHk8HJIqGLCP2YNnQuZGlaWUzUSAbZi1wqxekSdK7w3VAj0p5jaTyeRoKFv5facDu1mcZWxAT6F1tkMN28cR9XIb8lUoiJ6jX+9i0SmiJy15fX5SoUc6RyjQrTA9V6rQ6kY3Wb/E/KkeIjkV50bZCKv6ICGY76OV5UqInURXpbVX+1ERGwLnRzC5a8RU4bR9qeyWcc5TGVHDbjYSIbnc4a/xZgYyanQrG5vF3L8H72JtJDPg3EkKMICf+EHgwkmWDv6A1HvtHnhiBRxgcjHWMlAOG5+A8lFwU10otrVAsuYxLAa2SE99roTIet4I3VWXm2/Xx4Ws+0tSlRHytXb+CdYV+WTq17v2ozxOdd/ig=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NLszTcPNUbY4PZtLxjAg9f0IVahDsOxR/nVuv2HUekysXcu9tHbNvENW9rIB?=
 =?us-ascii?Q?wTss1JywvoIKUbnzrz1x/niKcA2VFVxDoSXLoPkNA2UxmdwGIOzuNkfA+6ms?=
 =?us-ascii?Q?357b8GXTMgCnXWi8Gbim/RabyGL0QxguUHgoOEcMZ0199p6V9L7TjkA5gwl3?=
 =?us-ascii?Q?UgOYqvEkP8cvlkj+8mqlO4d8HT+R0gk7U4oHVMkVqh0kjw/ZAFXJ357hpcNj?=
 =?us-ascii?Q?tbyFoJrQmVKE65xy7Ct+Tlxr5lHyZXvioU51ZRZB3ybuhKgUA1m71jKtJpfZ?=
 =?us-ascii?Q?wTRXvO//Mz3WxRUX7C0+5Z1y4EzudbqrwuIhuJaknO6RLQwTcOtT3h9Zgb9b?=
 =?us-ascii?Q?biODUOZFGlEv+DrC9eidRTcNGMYW5z8wv1V5HvNmGYQ5opNGaDkEXFTsmgYn?=
 =?us-ascii?Q?0ov+6DtGec/IDT6yHAngGTzR2NVo+372boxbRbTkV2H4UPnuitC2xR8VdCv+?=
 =?us-ascii?Q?2789cwopoKAv5tt4y6PWLEx1ZsuXdPne6kIauWtyjc484C5ZZxwXaaXcKlz6?=
 =?us-ascii?Q?QXI8zYWrxMHOR7UhjBkgBFfCv+k2VLQ90dPBMR3hCyZh4HiFBPX1BJ7q2uSz?=
 =?us-ascii?Q?NoRP2rAt0UOD/QPhQPD0nsPbc63AoMhJipZHlv7VNnbIFk/Ji8pbeRmgMIbP?=
 =?us-ascii?Q?TqzzapgyZB5oz1vE4Yu5Fec90blNOjKy7wOg83/LVcDUCFbmqLoUBo4ywDIL?=
 =?us-ascii?Q?e6CkCIvhENwKJUoR4aIj+IgNiVSvA/OPm0uoqbqGjqccKFDFqUbxoKtUGHJh?=
 =?us-ascii?Q?T4JVs2xX7hysLSMfiZBYa4NN5htPSQ0/i7RVOux1fgngRtlLkd1sSWKBkmF1?=
 =?us-ascii?Q?NPVNLvAV302t+lEDWxfxgJyfYGxJUeZAuo4158aN6P9JYlmsc0CEkRcP6FKB?=
 =?us-ascii?Q?cfIw60GQUH89vlZ52g0c/nryP0dWFiaUx2wa0xk5uMPsAo39MBojq0V1h2sz?=
 =?us-ascii?Q?JEUmb8P8mVQN5XCP6V4iy8bHR22RVz1YVnMeiVk2MzgSVZ4JbXq6cBUpC3Bn?=
 =?us-ascii?Q?7ITMTGQ2fTuPXHMszdQY9uroucIoyWVj4M3Pr8d9OrpRsEqftgnSvG+423g8?=
 =?us-ascii?Q?i4HN2eK6nGOzjmj7ammbK7i5bij+tHjRfKuX5s9AQsiWfz78nnbntCQG8gqW?=
 =?us-ascii?Q?lBgArUw4uGHvIs39Wfko30EiL4/HyeYqessSvaBEAQ1mcuaY4o7wkUHabVcA?=
 =?us-ascii?Q?qJrioxHfvnP7DqsAPnW9VV0+CMkk7m6w4lTyFb7GyeEb0UPkPwTZlaEc9VSj?=
 =?us-ascii?Q?cVxQrvSQtSH8JEF0ZZVrX1t8LXTyPe3f9oE0nwqn9ukqoaZrDxfzvd+XhMeU?=
 =?us-ascii?Q?BZHSzOZp2v2BxnEmDVbRNXqwN0ZcGQr6Mc/EivsP8Oh641Udcrb9nHzXapsm?=
 =?us-ascii?Q?dvTQb5+ydcXIU3eK1FoD4rgr+XpGDT2qp1sj1bcco1kiyXVbZyyZqbK2YeQ3?=
 =?us-ascii?Q?aWN0BsKNO9RX3+bBli0LXdVEqs+DK3BlkNXxnJ8tiMuM5WNFn5ui+qRu9s0n?=
 =?us-ascii?Q?nOKs+eAlAEiqs/dA9V1N5q0ExIMeiEDM8XhBx+EmyKaoPukzmRj4esjX0hYk?=
 =?us-ascii?Q?O70n705KmQ1N2DPd2hwKiLnUZvz9TM5Wca7SgIyypLsioVo8lvN4iKzQK2MB?=
 =?us-ascii?Q?jx1lpAjt/hA2byhE7rLAHhLNRaEdF2eC9N61RgVOn4d86/RTSR30Aj/nRNS2?=
 =?us-ascii?Q?WSksTOWJ172ERyZ1QMKZNZvLg/FrnTw8JdM3mvzZiggGHY0j?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 278989b4-5e79-4049-f698-08dedcec8388
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 12:29:11.2462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b8b32MHoaPfoAasNG8aN5giOsJpdMuko0G9HXVgXlreKt3peoaKWjD7z2RUz75zpz3YjI1JUuq7++9j3031dZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6637
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305792-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:bridge@lists.linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:horms@kernel.org,m:razor@blackwall.org,m:petrm@nvidia.com,m:idosch@nvidia.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 62B9372655C

After the previous patch, __br_multicast_send_query() no longer relies
on br_multicast_alloc_query() to determine the IGMP type of the query.
Remove the argument.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_multicast.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index e39494b26ab1..f112fbb374c0 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -926,7 +926,7 @@ static struct sk_buff *br_ip4_multicast_alloc_query(struct net_bridge_mcast *brm
 						    struct net_bridge_port_group *pg,
 						    __be32 ip_dst, __be32 group,
 						    bool with_srcs, bool over_lmqt,
-						    u8 sflag, u8 *igmp_type,
+						    u8 sflag,
 						    bool *need_rexmit)
 {
 	struct net_bridge_port *p = pg ? pg->key.port : NULL;
@@ -1006,7 +1006,6 @@ static struct sk_buff *br_ip4_multicast_alloc_query(struct net_bridge_mcast *brm
 	skb_set_transport_header(skb, skb->len);
 	mrt = group ? brmctx->multicast_last_member_interval :
 		      brmctx->multicast_query_response_interval;
-	*igmp_type = IGMP_HOST_MEMBERSHIP_QUERY;
 
 	switch (brmctx->multicast_igmp_version) {
 	case 2:
@@ -1072,7 +1071,7 @@ static struct sk_buff *br_ip6_multicast_alloc_query(struct net_bridge_mcast *brm
 						    const struct in6_addr *ip6_dst,
 						    const struct in6_addr *group,
 						    bool with_srcs, bool over_llqt,
-						    u8 sflag, u8 *igmp_type,
+						    u8 sflag,
 						    bool *need_rexmit)
 {
 	struct net_bridge_port *p = pg ? pg->key.port : NULL;
@@ -1166,7 +1165,6 @@ static struct sk_buff *br_ip6_multicast_alloc_query(struct net_bridge_mcast *brm
 	interval = ipv6_addr_any(group) ?
 			brmctx->multicast_query_response_interval :
 			brmctx->multicast_last_member_interval;
-	*igmp_type = ICMPV6_MGM_QUERY;
 	switch (brmctx->multicast_mld_version) {
 	case 1:
 		mldq = (struct mld_msg *)icmp6_hdr(skb);
@@ -1237,8 +1235,7 @@ static struct sk_buff *br_multicast_alloc_query(struct net_bridge_mcast *brmctx,
 						struct br_ip *ip_dst,
 						struct br_ip *group,
 						bool with_srcs, bool over_lmqt,
-						u8 sflag, u8 *igmp_type,
-						bool *need_rexmit)
+						u8 sflag, bool *need_rexmit)
 {
 	__be32 ip4_dst;
 
@@ -1248,8 +1245,7 @@ static struct sk_buff *br_multicast_alloc_query(struct net_bridge_mcast *brmctx,
 		return br_ip4_multicast_alloc_query(brmctx, pmctx, pg,
 						    ip4_dst, group->dst.ip4,
 						    with_srcs, over_lmqt,
-						    sflag, igmp_type,
-						    need_rexmit);
+						    sflag, need_rexmit);
 #if IS_ENABLED(CONFIG_IPV6)
 	case htons(ETH_P_IPV6): {
 		struct in6_addr ip6_dst;
@@ -1263,8 +1259,7 @@ static struct sk_buff *br_multicast_alloc_query(struct net_bridge_mcast *brmctx,
 		return br_ip6_multicast_alloc_query(brmctx, pmctx, pg,
 						    &ip6_dst, &group->dst.ip6,
 						    with_srcs, over_lmqt,
-						    sflag, igmp_type,
-						    need_rexmit);
+						    sflag, need_rexmit);
 	}
 #endif
 	}
@@ -1844,7 +1839,6 @@ static void __br_multicast_send_query(struct net_bridge_mcast *brmctx,
 	struct sk_buff_head *queue;
 	bool over_lmqt = !!sflag;
 	struct sk_buff *skb;
-	u8 igmp_type;
 
 	if (!br_multicast_ctx_should_use(brmctx, pmctx) ||
 	    !br_multicast_ctx_matches_vlan_snooping(brmctx))
@@ -1857,7 +1851,7 @@ static void __br_multicast_send_query(struct net_bridge_mcast *brmctx,
 		return;
 
 	skb = br_multicast_alloc_query(brmctx, pmctx, pg, ip_dst, group,
-				       with_srcs, over_lmqt, sflag, &igmp_type,
+				       with_srcs, over_lmqt, sflag,
 				       need_rexmit);
 	if (!skb)
 		return;
-- 
2.54.0


