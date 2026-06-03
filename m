Return-Path: <netdev+bounces-294783-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bKddGlZAIGobzQAAu9opvQ
	(envelope-from <netdev+bounces-294783-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:55:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBDD638D4F
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:55:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=eYirgfBN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294783-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294783-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16A17323A736
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 14:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33113D3481;
	Wed,  3 Jun 2026 14:36:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013066.outbound.protection.outlook.com [52.101.83.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B963D1709;
	Wed,  3 Jun 2026 14:36:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497416; cv=fail; b=hEY2HVIlmWwZLhffMCZ1OIKcxn21dERy7Jjyra6SRb9Qx/detoRF3tzBPxSce1IazkvrRRIDLqhVCufVHo1qsrq4dK+8ycjAEyy15DozGdUbtTGXVQDIwZgfD4vrKjtwtK8wsl4GIQnB83vcDOs1o41u2McdfdU21SfHh+ESARA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497416; c=relaxed/simple;
	bh=QTUpsWQL06hLGUzvmWhfjzEcD1V+I/2ob9r0XwXWCLI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JLrPetaKyIHY0CaM0ZXbC+LaBOeaSQRAhnZKUZ32XYq7PoF1iYxWAc42bsiA9MpFQS/ukLzjDI/Sm7jwmEsFpPPruEIdWrWzcBnlkTFD7s0blny0TN3nUPt0WyMZwPZt21iyIZXi+u0hEk5ZlR8ZRLUjOTBlxmjQat2PtfUtl9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eYirgfBN; arc=fail smtp.client-ip=52.101.83.66
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zGZqO6tNM56MLZUz1NPwuq6FpQtmx55AD1dZkDEc4/XPAh2YboaUtMiakmDUnWUyYmM92MdvI2EURjR07MzCN3uIwaCGvUJcjgvko09oVYihRL+l0+BJ7zqQmKdxXe85a37C826m9qi/wyReyjCcAJTdXUv7xQH3RNuP2jw05bfCzk6TqQIqsEEe/JH2j/LsbjrLfa6tG+9ecpAh9U1m6YEJQmCVm/sG7IU0oAbMjzubet40sliAgTbV1ANd5srDydKjiiAjCNutj6tHZxduQ5qNhGT0VYQj2VpuqZDI0cIgR3tmAqy8IVNFFTJD4JLqt+Eqh4q7nJ37Wu9fnB3CdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7p6JDA5pWJxLEAhLzD9aKd6OI28YWei4SjgwdJkPJQ=;
 b=k3ggUcaFeHWN8Dv7y36TzthCDzXetS2j2NWuVCcgjMoNC9zXIX21HhaEC8mcertAQg02Cf6yNIq1HBXa0kkNhRGGD8q5UnRUQoQAIjwsj8NcX38mKnoksmwL9gjT7NdsYvdRt7C/RUASh4KuAoYAP3mlOqBBCEbzFzlHXd6c88h7osHF3Yw4OLO9LthaPrG5wsqJXaV1hdQihyBGHDvHQRVT1eM4DUek7+yqxGOumxSOaJ7p2Nh3qLB/czLoq2/DAIPyaFvaIwvIh1IQGglGObcaKTh4pUwUohxqaWsu9lMTdbxoHK0KQ48sf91GWZuVxPLN+WZGja9FKFt/eyBG8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7p6JDA5pWJxLEAhLzD9aKd6OI28YWei4SjgwdJkPJQ=;
 b=eYirgfBNDAqP0LGJ+gi8/pCq13koag+YYXzVcH7mjmGfHXQHV6gE3+Eq8ixrSyTyxYjAAqxpvDiUUGEHEN9eTCqmJ2Ro9Z72bCwMp0D3NUSdE/LhAfmgqYDAiLJpas33Bzj46VzHo5esTlklgdPd4LaZFD8x9uMxP9T5Y1LeprelzwiidPG2VN0lng4Oxtw8gNL409WoFphBOrIAoh2X6ThHb9ju1rg2nfjCslx6F1rQKHGgASqb3uzc18usMnyRRy+YC9JhEJmbAvgshZdsT+RV6PnOn9v/H6eIoh4V58KtVxc4B4tsyTrzFtZWeIaAvgcOf7VErLymKrIWIHLTlA==
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by VI0PR04MB10615.eurprd04.prod.outlook.com
 (2603:10a6:800:26a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 14:36:52 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 14:36:52 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 06/12] dpaa2-switch: create a separate dpaa2_switch_port_fdb_event() function
Date: Wed,  3 Jun 2026 17:36:17 +0300
Message-Id: <20260603143623.3712024-7-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603143623.3712024-1-ioana.ciornei@nxp.com>
References: <20260603143623.3712024-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0314.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::10) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|VI0PR04MB10615:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d16ed62-a841-45db-664d-08dec17d8db7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	fLbtLkTr/2Q9VoZE9cdmB6AnugWw8865ANavagsPI8f47Q8LCF6b5T+xCT3bL/XvPJtfFLiusVFdtQtTIpa4MQQBgwNGRkJaD9tUhTk6fv3nxvt6z8XfJkDOTCtXU5Q6Sasu2zCbIeL2KAvIr6bt73zAnagapIWm2VuHUP7mS9kLn3ow/mbiupUFAYewOi20QtG4ZLjbpKdnV+VUSbgsMiZsLVlfFj1rOPfbs8sQj5nXn6UP8eWvVmpK5wcAUIanSpEPTgtw4ufTNa18F4PHDAMy/bOBQkvUciQ9nB1oUg4seeWFoDBy9xfVXhNMaq8z+09p2qXCHgzZCwpXV1CKIqJRYVshYURoth0TZ/idp5WHdYTU2SyaOgAuX5Yf+pHkirsi+yFhpIDbERAxgFn0/Z0uvzivMsBNIM3cu4oSigvWnFUp1zVN1nUHhZ/N04Og0dS1nXc478mx6q7TL9tPjuyxLk6GyefRzTAP+IBzOwPhI434T2n9+fdpY6Vm/UOR7iFGgVHnNP94ZZCA16vaND0Vyka+0Ale6La0sfUkGZZhPRvWhvzbNsPa9HnnTLPsgSVJHBtBaO3+45Jxc9NtLIZGtrZbxPSK/BT4pXDLSFCAe0JzUzrTpQ4qTESsOWPUWeJ75tl+6TXgm3ib8v6YDzcQRnJK38TfhoW/wjDxHYwa/D12zyEk23QM0gErPkCX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RM/tnnw/vEhU/1yF5Ac0Gie1bE7DyMHSpHm3BBm5Tw/YnlUYGnsv5OyEBggE?=
 =?us-ascii?Q?FLBjV4mrne5A9eHjEJpWYXqVvM1R40gL4ES4xwQydZ5kCWoHqXywkcurEGYf?=
 =?us-ascii?Q?geI6i/7T3fj8Iv0c0cy9z2/RQqljUzkBXnNe7gLDAfgQ1p2Lri73j/5Pe/wE?=
 =?us-ascii?Q?JegzFqt9DW2xNDPbPYU59QCjVipoAtcJbb29iXOs7d8b15JqyG/tBhYjrBwT?=
 =?us-ascii?Q?ht3XwmPwk9eNtUdiTogCITs9i9uWVAqQSuGHeZWn3q6xLpL1YfHwTTCBgJOS?=
 =?us-ascii?Q?vuCSB3C9y537U0zdoeTuSXeZpgq576U+GLRRWnYRiBBa34J+TORx33MVThmH?=
 =?us-ascii?Q?J4o9tF6nZeZyZ7grMJEJtm99K0Zs6AzVQxrdcu6fbqEwrDdyXOadcWiDABsS?=
 =?us-ascii?Q?D+NQRM8OxA+W2uuW0T8e1u7ka0xT9NOUPpAGNNNn9Y5i7n1Y4Wd09Wxt8gx5?=
 =?us-ascii?Q?UOEv3XeDmVlLnqM9WA/rTv6T4jDED1QBkycgDlnavWdkR/Diz/aCw2aQsAdh?=
 =?us-ascii?Q?SB1ZIYpz4BC23fnPDbC/x7NPMcH8REgZG1qxC82V5I0rbok/3letIvVJ57Eq?=
 =?us-ascii?Q?d5gs5IbObyM/hrpS3EkpTQxga/cA1cbOK4tzUh6dzg4CkucahKtiooMEt79Q?=
 =?us-ascii?Q?1mI/ernRYirjel6Q69ji20ar+PKQO02Vrbvmd5sOKodD9W+YTH0MXOogZ9dc?=
 =?us-ascii?Q?4MnRoJJk0c77Vqp49ldwYYIiY6Ds5glFhsdC7cGvlWdlbD0apBATONGg7lcs?=
 =?us-ascii?Q?TH2YfLc2whL3u90GZ7sZVJ69SbAuCe5NeyoXjhp1dP7fLcfZmgPeZEQUhhZP?=
 =?us-ascii?Q?PoqmCX1iq5tjjbUZQ5aQsqyI9Hs+92jHeTakuk5p8djGpAa/iN1qj3gqoDdO?=
 =?us-ascii?Q?3F8b5/jUhJAN5rHY5iD/8OjelW46J+5Lj+s7Mfmk4RBybHqq5iKmjx3PHvNP?=
 =?us-ascii?Q?iNAKj8iDNUsFfuwkTdKN0I5gRnHn5aN9YxbU1ZRr7HDUKwNJmee8JrF2OhG8?=
 =?us-ascii?Q?27OBEYiDrxUBTTXI/iQla2aghoXMt4v9YeQm5UW7tUGz6yHCBfWvZ7T3CTwe?=
 =?us-ascii?Q?A/pPqceuyPNNX/2oXYPTj55BH8IA37DqTp84IvBJWvrZ3a3XednKUwPgN9c2?=
 =?us-ascii?Q?Axe/MCKRkHaIMq0oL1xqYC0INt0qPw9HmHM2/rKpad2QbbWSNRRsUz+Ps49C?=
 =?us-ascii?Q?8W97QPmFXcu9etHiAwlSPKy5jlu/0QrguOz5CWuhgdihXdqmcSz40wCwdadt?=
 =?us-ascii?Q?SUutnO0vsp0Uvp4eGBRJeyyJRM56nRbhUqrDls/IRDsooWZW/xp1HUGfMqF9?=
 =?us-ascii?Q?o9xapQRK5EhDj8gVvaLRPznHgoXKdZQRwbnbuWbyqiGrEwuIqsOHsyVdQFol?=
 =?us-ascii?Q?U+VVY5YNXGuxjQHWzXMk9q2k/tNUcQlnsT9jMpBqXOBUa85vOXr3gkF13XZE?=
 =?us-ascii?Q?fyMDy7dgFdvcJzm6WviZ+h4usK5GFDE12ZT1l1qYFP6EQse7cOC6ELqENtcw?=
 =?us-ascii?Q?odKj58lJTy3t+sRX+JJIDKwGlEWE5Q8Wps6b+G1VQ9m9B94ZjH99064ZuWqm?=
 =?us-ascii?Q?yi/JLqncvOI3bE+uZ+uzxgPjDOlKFNoJz/sFRYVYXFEz1sYOVvFDB61Pwqsi?=
 =?us-ascii?Q?Q5aUT8nKpV7QA3UNQE2KuFKanUWk44uY7cE91bgdEHVRmHPZd3QU3zvC/9Jk?=
 =?us-ascii?Q?Qrc64df6hFertdBbEfMiVvg7kKRCVdDvScg1lzwHyHm4N286VvK0MARWPFXa?=
 =?us-ascii?Q?h1ZKik0Ihg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d16ed62-a841-45db-664d-08dec17d8db7
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 14:36:52.6955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O+XNlpIbJMv8z2tEmOKJV4j7INzwGzK+JZyP0rTZE6yXdeIiaT6tPWAmskN6MHdN6CJY2oj4sZBCm8lWcUiqAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10615
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-294783-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:mid,nxp.com:dkim,nxp.com:from_mime,nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BDBDD638D4F

Create a separate dpaa2_switch_port_fdb_event() function that will only
handle the FDB related events. With this change, the
dpaa2_switch_port_event() notifier handler can be written in a way that
it's easier to follow.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v3:
- Get hold on port_priv->ethsw_data only after we know the device is a
dpaa2-switch one

Changes in v2:
- none
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 28 ++++++++++++++-----
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 87cb8270f30e..8e109b54aec5 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -2880,21 +2880,18 @@ static void dpaa2_switch_event_work(struct work_struct *work)
 	dev_put(dev);
 }
 
-/* Called under rcu_read_lock() */
-static int dpaa2_switch_port_event(struct notifier_block *nb,
-				   unsigned long event, void *ptr)
+static int dpaa2_switch_port_fdb_event(struct notifier_block *nb,
+				       unsigned long event, void *ptr)
 {
 	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
 	struct ethsw_port_priv *port_priv = netdev_priv(dev);
 	struct ethsw_switchdev_event_work *switchdev_work;
 	struct switchdev_notifier_fdb_info *fdb_info = ptr;
-	struct ethsw_core *ethsw = port_priv->ethsw_data;
-
-	if (event == SWITCHDEV_PORT_ATTR_SET)
-		return dpaa2_switch_port_attr_set_event(dev, ptr);
+	struct ethsw_core *ethsw;
 
 	if (!dpaa2_switch_port_dev_check(dev))
 		return NOTIFY_DONE;
+	ethsw = port_priv->ethsw_data;
 
 	switchdev_work = kzalloc_obj(*switchdev_work, GFP_ATOMIC);
 	if (!switchdev_work)
@@ -2933,6 +2930,23 @@ static int dpaa2_switch_port_event(struct notifier_block *nb,
 	return NOTIFY_BAD;
 }
 
+/* Called under rcu_read_lock() */
+static int dpaa2_switch_port_event(struct notifier_block *nb,
+				   unsigned long event, void *ptr)
+{
+	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
+
+	switch (event) {
+	case SWITCHDEV_PORT_ATTR_SET:
+		return dpaa2_switch_port_attr_set_event(dev, ptr);
+	case SWITCHDEV_FDB_ADD_TO_DEVICE:
+	case SWITCHDEV_FDB_DEL_TO_DEVICE:
+		return dpaa2_switch_port_fdb_event(nb, event, ptr);
+	default:
+		return NOTIFY_DONE;
+	}
+}
+
 static int dpaa2_switch_port_obj_event(unsigned long event,
 				       struct net_device *netdev,
 				       struct switchdev_notifier_port_obj_info *port_obj_info)
-- 
2.25.1


