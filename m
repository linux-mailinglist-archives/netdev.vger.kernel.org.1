Return-Path: <netdev+bounces-262150-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Om3HIwCo2kJ8wQAu9opvQ
	(envelope-from <netdev+bounces-262150-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 15:58:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E7A1C3C1D
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 15:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 683BF307C419
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 14:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24DD44CAC4;
	Sat, 28 Feb 2026 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="L3/C6WNh"
X-Original-To: netdev@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020096.outbound.protection.outlook.com [52.101.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E42E44BC94;
	Sat, 28 Feb 2026 14:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772290550; cv=fail; b=Zt+PTKg05PCkL95KgHBF5EjSKOZB8/+kOrGeEZ68CrUYMlML0AC9s58thJKURNGxXhhEC75rUTptUQIF4DiZrEhIETMl3DhswJjDfxFDf27D5aHH35b3yQt6LzSI5zv8NmcSizVTy+yLlBIZJ0N0ItMyTjuL1xvVWxiCuZK4WPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772290550; c=relaxed/simple;
	bh=PxyjFFhRjY+GohSBCAhZsm/8r3NrwoH95rhs1ARpqKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ElFTVKv/MEHmXq2MlA3rUOjkkwzqiSruhzgda1jubjrL7atWfSNa9uqcDDVOudn8HJqIGoac3nQc9n5shnTtiiQq+iz5vX4EHqDnVeFhuNncy4nM2UlF8mIc5nws8FHEi3pvezWb/vzqT+I+y901PWwht/WfnbOkUHHhwwkOr28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=L3/C6WNh; arc=fail smtp.client-ip=52.101.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMpzy9dqCjw2B5tUaxK+F1X8CwyTVr1ShvSUsLku+ZIWrbLWa8ccpLVu6zdmsd4E/N7BDKx1rpNg6Y2rIHCwjHbb37Hm1csvEjgHE7z5v3z8i2bBC4gZNfSWrcb6YeAXpZY5u9rnehDDBAHQyP31Bx5gl6BZaPqU/ATvzAIEJTsK+QFyiNYba5sRt2oINl0FNBxwncPZqtC/SZD76f+ZXcO8om7Bvz1MDqaSepMC3BBJu4PxIrJvHm0bO1Tb8gsGZ2FPB9CR5ik4I1fmcsEu13mdAjOh1/MG1nrlh3T+HmiaZVhYmZ/kTjisiUNKNYBda2AKaEO+4gPy7TgyuGrgwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ZgfNGx+9873c1ELgPerCrX6m8iklUIZvf5Jq+l/oMU=;
 b=ubWM9gyQwqNfzH7jgrihMY2mOCNJUOK5EkoMja+ka36mf2L8cKuf8AvT4meVFF2DNPI5RrTUCLfeETYTigkiCtrQKKE7R70xWVbeWufsYULFmD77casH9MQjI0HiQ1l0cm5qRwrX8q2TBpWR7DwgzzIaaK2AB6bndmXguRkw/EV/w1YijnEw1HQjxDH8qSkGfYV6xJ1pKc4NJfKMgbfDGjtgQQpArI9chVS8S8sz+aCLwIy+q0WLslCHePKk5RvkH/RT+QsRcf7jSqcl+t+P/6dDihppt8TflrhuST5LGsXbwYwyNimMBwdZ9U6iPCWc8dvFZSTAUSdGMXVOTBj9yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZgfNGx+9873c1ELgPerCrX6m8iklUIZvf5Jq+l/oMU=;
 b=L3/C6WNh1IL8ommdN7+1xhdmQoLxi1yZI5h4S5DdIUy39o3ZveEFxQXKOy+X91vD5KPSZ0p7v2Z2/r48zOWCQ0yLb3arO8weYHqhfH885kfHfdegsK5K0HuiQjru46hOWbsfF5lbJ1pDVuwwZ0UAgsiz4yAB4xFAEa2Cxd4ZbXc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB5182.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:164::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Sat, 28 Feb
 2026 14:55:46 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9654.013; Sat, 28 Feb 2026
 14:55:46 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: ntb@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] net: ntb_netdev: Introduce per-queue context
Date: Sat, 28 Feb 2026 23:55:35 +0900
Message-ID: <20260228145538.3955864-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228145538.3955864-1-den@valinux.co.jp>
References: <20260228145538.3955864-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0065.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB5182:EE_
X-MS-Office365-Filtering-Correlation-Id: 169cb54a-98e6-41a0-d692-08de76d97430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	E9sNp4jlZvTZt/pGc0/d6um3Iw3Ku8T/n0J4FmHp1+v+ntsmx5NqDE7aC8xi1FDPtUV9JFxYjmpR5AiRBQMPfBDsF4+vAVDVBPE3ADBWnDewSOibY1xEdq0wd+EIWIwJuHL1lNpS6chzTtOHiCbPxun+ZnwIVpEHxbAC4r4EHHqBvmOAk5INonlq9SWPCqljg6xqY0HOz68hmGxvoT+3ktTEUmN6kaCEfNNxIwqvo/7iW3RmvAqlbq5bv9RSMbd7U0jVQ7slHAVnA43hZi/ld/Ja/HSQCM6oylyGkvjUrpLdAz+t1kJPadt/MGfRVjXJaef6PhIQ5aZE4c//lH2aRCN2qDmIeOG6WVzcnuRK4K07Y4+sFhTvV9EjWOfKAPJjnu9VHtS2E6yIT18t4BUmJH9TRFhTX541X9UhA5KW0+qAyg3SwcG9XL2E0kc4fUUaYM4aGVyQQSj7nLWbrKSaFTvroApck5njumNEKxYaCLTPMujP2Hzeer0HrfR8jGdI8sA4DSBOA3AnbVtXt4jZkWkD3B1gcuhS8V0P5x5LGp5/U9dQk1vQnEtryJwCJLPoYh4sEZBbbXsnd+RHQtM8x9SboqwhXO8/mZcJEz/8hKcUoiw8NBuQeSunw+t5G0dDQASCA2itoX5QL5caLH1ClzPK3F3cE8xw1ouwNthxLym6hqbNv6FWUuiT0vsWbo56kyqh0OvuQlMJQtisaEuMLt2t1ORqLAPBF7fZpnRb7Lc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1UbdMq5dR1cvAbmT+Ew980lQ51zBtXX2PbYBKByrq3MNcGSlPBLj8ejxa94q?=
 =?us-ascii?Q?t8ZWLKlSY4CVY54e107Aqee/NNuEjwEzhD0nD8mA/yTqByUuxLCQTyi1zwKn?=
 =?us-ascii?Q?qKDdo76G195+eoxeyf4li3AAXHUNkMiA9OpUPvYJgoshKnDfJSc4ZEB+xvgy?=
 =?us-ascii?Q?CU3vblTDTaUFnUppPez7JvNz7SG1jh+M7NMo1OM0YRKCsqo4t70Khqjc8jYp?=
 =?us-ascii?Q?7DzVmG2h3iHVZwCcrbOF7H8F1ZpB8rzdoEthmd1Q3upPDbQSiPNiz7MGqgx1?=
 =?us-ascii?Q?2bzX4r/WYRBFTo6gDnEhI/lW8p2UT0SI4L46LaUl14ShxlFqZfnihbZGJ/5w?=
 =?us-ascii?Q?R3nQCgnItXJX09fSJ88N9NFDzlia6bVbG4YgZrqaKzYekp8va9++YWp4xeES?=
 =?us-ascii?Q?ObyCYXdX7//gtPks+jCGIJYleQ/qDykyMBEHYFUT2c+e5LpA+W4jTBXrzMx1?=
 =?us-ascii?Q?0xQDtX515r0uUhjoPbmOUsWHH0/KW43aRRr1WIEaItlzupMUxou1mwhnIWfB?=
 =?us-ascii?Q?ZlTjBCdWe1nqVn9dHAplZzvtKeNEep+n199QX2MJ+3oxeSU+yNHslrA+I3xN?=
 =?us-ascii?Q?3jHtXI3fJf+5ghRyz2x2JNth5m47GkBKKj2UPf6/rpzEyRMTGKpk/TELbWml?=
 =?us-ascii?Q?qMz0jD3i9+qnoTVvhEkfNVYkTsr+rLZDqxW1MryZlQJIploekZfiqP36riN7?=
 =?us-ascii?Q?uV9tajq5BD/MnlDgAdc5/t8T2lciDHgZzvMgKzUztuabpZJ2VDC6gJ7IKubo?=
 =?us-ascii?Q?Vii8IttwLIIyWpa7kHreGBb676lXFQMU6HCIzenJOAeSr5zp+k/r+91QkjVs?=
 =?us-ascii?Q?yv3q4Ft6F0Ka8CFcVUyhVMP7eDm3/Xc+CR5lHKqjYh9SpwB/QidxQJCCKnc+?=
 =?us-ascii?Q?xpNR25QFdyEze6qGuQTTPP6Wom4ZUvjRa/c0jRTvp2agUB349gb01/TSX4j5?=
 =?us-ascii?Q?RQK5Ur0NIZ6l2Jl+2QL5c9+N2Bm/Al/cLtXRYkmBZ8IoOZy6FShpk8L2bmFD?=
 =?us-ascii?Q?ManhAWmJUkevf52cSpgI6RPyK3oJn39AtdrXlGywQmDaNG/vwWGMhuf8N9tk?=
 =?us-ascii?Q?CoygD9MtH+3Z2+/v23XrvrI+I5Rg7iXr9fr7d1kAw2NU535RDp3kPMBy+Slh?=
 =?us-ascii?Q?LT0DEtSl2zFTL7O3MfM+usRQk7ZaRoQVUzV5qCNxl/GQweVa7ZAUVu8gxBXH?=
 =?us-ascii?Q?UtpXFJGAfKXaK1YFqC6Dcw5rEAyOJljhOR9aTXbxTIzolMyiyS1hHQUZRF7t?=
 =?us-ascii?Q?oE4/E7OYmQNjf4nmcyJGv7RTDtcPBxTVyxl/+wLkPVjv9iGWfbTDwZ9fwYWX?=
 =?us-ascii?Q?e/PQTGAmD8c4Df57SOjV9Q/aqSbtlO65lIDNyX8m25OeFc/neidtH1GSKvq/?=
 =?us-ascii?Q?Q57iBlPctpuwUrI248CmCJjWuGbB2ertEur4gGO0RAZsq7tOIt5iHbIuC1/7?=
 =?us-ascii?Q?CF9s4vqGEkLMiwkggz0uSuB4JHhQKDLZLammX6QvnNu3hzmmaEEcFfVfzXXH?=
 =?us-ascii?Q?OKNB5OWDlZW7gSHtxYGgj5KRL6KPVhAv+eiOrgc9d/u4f31MXSopBrjwD3mO?=
 =?us-ascii?Q?I4w5A+w/l5neMgjd3J5MtoYA8cr38R3yGQ9Cwh5WZQhcYDYdtKuPrnZmveE6?=
 =?us-ascii?Q?I6a6DBBYYjUza62cKVxIBOTcJuTKbvH09pRxLG9gWXLVCngd4eVxgxI3n1SC?=
 =?us-ascii?Q?Um1FvT87RzlNoLRMIjBCWCBVE0PsHOf4RbUunz4xM2qCvx1XX+du0D62bw/Z?=
 =?us-ascii?Q?o0XR4ld3bMUtjbLTXiin1DtuU4eQwrfcBUL5M1Pu4uKY569dYJXT?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 169cb54a-98e6-41a0-d692-08de76d97430
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 14:55:46.2998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X8+2SJl6yyBefX7k18jnd6Zd9TPxuNmiNBdxqF5iwXAqSepBhedZkEsSHTWe7p7C7r9lPDe5RECk74/qGd8w7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB5182
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kudzu.us,intel.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-262150-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.992];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,valinux.co.jp:mid,valinux.co.jp:dkim,valinux.co.jp:email]
X-Rspamd-Queue-Id: 01E7A1C3C1D
X-Rspamd-Action: no action

Prepare ntb_netdev for multi-queue operation by moving queue-pair state
out of struct ntb_netdev.

Introduce struct ntb_netdev_queue to carry the ntb_transport_qp pointer,
the per-QP TX timer and queue id. Pass this object as the callback
context and convert the RX/TX handlers and link event path accordingly.

The probe path allocates a fixed upper bound for netdev queues while
instantiating only a single ntb_transport queue pair, preserving the
previous behavior. Also store client_dev for future queue pair
creation/removal via the ntb_transport API.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v1:
  - Allocate a fixed upper bound for netdev queues (alloc_etherdev_mq),
    while creating only a single ntb_transport queue pair by default.
    Users can later add/remove queues dynamically starting from 1.
  - Drop unrelated changes from this patch, for example:
      * remove "any_up" from ntb_netdev_event_handler()
      * restore the original __ntb_netdev_maybe_stop_tx(),
  - Store client_dev at probe time so that queue pair creation and
    removal can later be done via the standard ntb_transport API.

 drivers/net/ntb_netdev.c | 279 ++++++++++++++++++++++++++-------------
 1 file changed, 190 insertions(+), 89 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index fbeae05817e9..7437b4580dff 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -53,6 +53,7 @@
 #include <linux/pci.h>
 #include <linux/ntb.h>
 #include <linux/ntb_transport.h>
+#include <linux/slab.h>
 
 #define NTB_NETDEV_VER	"0.7"
 
@@ -70,11 +71,24 @@ static unsigned int tx_start = 10;
 /* Number of descriptors still available before stop upper layer tx */
 static unsigned int tx_stop = 5;
 
-struct ntb_netdev {
-	struct pci_dev *pdev;
-	struct net_device *ndev;
+#define NTB_NETDEV_MAX_QUEUES		64
+#define NTB_NETDEV_DEFAULT_QUEUES	1
+
+struct ntb_netdev;
+
+struct ntb_netdev_queue {
+	struct ntb_netdev *ntdev;
 	struct ntb_transport_qp *qp;
 	struct timer_list tx_timer;
+	u16 qid;
+};
+
+struct ntb_netdev {
+	struct pci_dev *pdev;
+	struct device *client_dev;
+	struct net_device *ndev;
+	unsigned int num_queues;
+	struct ntb_netdev_queue *queues;
 };
 
 #define	NTB_TX_TIMEOUT_MS	1000
@@ -82,14 +96,15 @@ struct ntb_netdev {
 
 static void ntb_netdev_event_handler(void *data, int link_is_up)
 {
-	struct net_device *ndev = data;
-	struct ntb_netdev *dev = netdev_priv(ndev);
+	struct ntb_netdev_queue *q = data;
+	struct ntb_netdev *dev = q->ntdev;
+	struct net_device *ndev = dev->ndev;
 
-	netdev_dbg(ndev, "Event %x, Link %x\n", link_is_up,
-		   ntb_transport_link_query(dev->qp));
+	netdev_dbg(ndev, "Event %x, Link %x, qp %u\n", link_is_up,
+		   ntb_transport_link_query(q->qp), q->qid);
 
 	if (link_is_up) {
-		if (ntb_transport_link_query(dev->qp))
+		if (ntb_transport_link_query(q->qp))
 			netif_carrier_on(ndev);
 	} else {
 		netif_carrier_off(ndev);
@@ -99,7 +114,9 @@ static void ntb_netdev_event_handler(void *data, int link_is_up)
 static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 				  void *data, int len)
 {
-	struct net_device *ndev = qp_data;
+	struct ntb_netdev_queue *q = qp_data;
+	struct ntb_netdev *dev = q->ntdev;
+	struct net_device *ndev = dev->ndev;
 	struct sk_buff *skb;
 	int rc;
 
@@ -118,6 +135,7 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 	skb_put(skb, len);
 	skb->protocol = eth_type_trans(skb, ndev);
 	skb->ip_summed = CHECKSUM_NONE;
+	skb_record_rx_queue(skb, q->qid);
 
 	if (netif_rx(skb) == NET_RX_DROP) {
 		ndev->stats.rx_errors++;
@@ -135,7 +153,8 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 	}
 
 enqueue_again:
-	rc = ntb_transport_rx_enqueue(qp, skb, skb->data, ndev->mtu + ETH_HLEN);
+	rc = ntb_transport_rx_enqueue(q->qp, skb, skb->data,
+				      ndev->mtu + ETH_HLEN);
 	if (rc) {
 		dev_kfree_skb_any(skb);
 		ndev->stats.rx_errors++;
@@ -144,41 +163,41 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 }
 
 static int __ntb_netdev_maybe_stop_tx(struct net_device *netdev,
-				      struct ntb_transport_qp *qp, int size)
+				      struct ntb_netdev_queue *q, int size)
 {
-	struct ntb_netdev *dev = netdev_priv(netdev);
+	netif_stop_subqueue(netdev, q->qid);
 
-	netif_stop_queue(netdev);
 	/* Make sure to see the latest value of ntb_transport_tx_free_entry()
 	 * since the queue was last started.
 	 */
 	smp_mb();
 
-	if (likely(ntb_transport_tx_free_entry(qp) < size)) {
-		mod_timer(&dev->tx_timer, jiffies + usecs_to_jiffies(tx_time));
+	if (likely(ntb_transport_tx_free_entry(q->qp) < size)) {
+		mod_timer(&q->tx_timer, jiffies + usecs_to_jiffies(tx_time));
 		return -EBUSY;
 	}
 
-	netif_start_queue(netdev);
+	netif_start_subqueue(netdev, q->qid);
 	return 0;
 }
 
 static int ntb_netdev_maybe_stop_tx(struct net_device *ndev,
-				    struct ntb_transport_qp *qp, int size)
+				    struct ntb_netdev_queue *q, int size)
 {
-	if (netif_queue_stopped(ndev) ||
-	    (ntb_transport_tx_free_entry(qp) >= size))
+	if (__netif_subqueue_stopped(ndev, q->qid) ||
+	    (ntb_transport_tx_free_entry(q->qp) >= size))
 		return 0;
 
-	return __ntb_netdev_maybe_stop_tx(ndev, qp, size);
+	return __ntb_netdev_maybe_stop_tx(ndev, q, size);
 }
 
 static void ntb_netdev_tx_handler(struct ntb_transport_qp *qp, void *qp_data,
 				  void *data, int len)
 {
-	struct net_device *ndev = qp_data;
+	struct ntb_netdev_queue *q = qp_data;
+	struct ntb_netdev *dev = q->ntdev;
+	struct net_device *ndev = dev->ndev;
 	struct sk_buff *skb;
-	struct ntb_netdev *dev = netdev_priv(ndev);
 
 	skb = data;
 	if (!skb || !ndev)
@@ -194,13 +213,13 @@ static void ntb_netdev_tx_handler(struct ntb_transport_qp *qp, void *qp_data,
 
 	dev_kfree_skb_any(skb);
 
-	if (ntb_transport_tx_free_entry(dev->qp) >= tx_start) {
+	if (ntb_transport_tx_free_entry(qp) >= tx_start) {
 		/* Make sure anybody stopping the queue after this sees the new
 		 * value of ntb_transport_tx_free_entry()
 		 */
 		smp_mb();
-		if (netif_queue_stopped(ndev))
-			netif_wake_queue(ndev);
+		if (__netif_subqueue_stopped(ndev, q->qid))
+			netif_wake_subqueue(ndev, q->qid);
 	}
 }
 
@@ -208,16 +227,26 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
 					 struct net_device *ndev)
 {
 	struct ntb_netdev *dev = netdev_priv(ndev);
+	u16 qid = skb_get_queue_mapping(skb);
+	struct ntb_netdev_queue *q;
 	int rc;
 
-	ntb_netdev_maybe_stop_tx(ndev, dev->qp, tx_stop);
+	if (unlikely(!dev->num_queues))
+		goto err;
 
-	rc = ntb_transport_tx_enqueue(dev->qp, skb, skb->data, skb->len);
+	if (unlikely(qid >= dev->num_queues))
+		qid = 0;
+
+	q = &dev->queues[qid];
+
+	ntb_netdev_maybe_stop_tx(ndev, q, tx_stop);
+
+	rc = ntb_transport_tx_enqueue(q->qp, skb, skb->data, skb->len);
 	if (rc)
 		goto err;
 
 	/* check for next submit */
-	ntb_netdev_maybe_stop_tx(ndev, dev->qp, tx_stop);
+	ntb_netdev_maybe_stop_tx(ndev, q, tx_stop);
 
 	return NETDEV_TX_OK;
 
@@ -229,80 +258,102 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
 
 static void ntb_netdev_tx_timer(struct timer_list *t)
 {
-	struct ntb_netdev *dev = timer_container_of(dev, t, tx_timer);
+	struct ntb_netdev_queue *q = timer_container_of(q, t, tx_timer);
+	struct ntb_netdev *dev = q->ntdev;
 	struct net_device *ndev = dev->ndev;
 
-	if (ntb_transport_tx_free_entry(dev->qp) < tx_stop) {
-		mod_timer(&dev->tx_timer, jiffies + usecs_to_jiffies(tx_time));
+	if (ntb_transport_tx_free_entry(q->qp) < tx_stop) {
+		mod_timer(&q->tx_timer, jiffies + usecs_to_jiffies(tx_time));
 	} else {
 		/* Make sure anybody stopping the queue after this sees the new
 		 * value of ntb_transport_tx_free_entry()
 		 */
 		smp_mb();
-		if (netif_queue_stopped(ndev))
-			netif_wake_queue(ndev);
+		if (__netif_subqueue_stopped(ndev, q->qid))
+			netif_wake_subqueue(ndev, q->qid);
 	}
 }
 
 static int ntb_netdev_open(struct net_device *ndev)
 {
 	struct ntb_netdev *dev = netdev_priv(ndev);
+	struct ntb_netdev_queue *queue;
 	struct sk_buff *skb;
-	int rc, i, len;
+	unsigned int q;
+	int rc = 0, i, len;
 
-	/* Add some empty rx bufs */
-	for (i = 0; i < NTB_RXQ_SIZE; i++) {
-		skb = netdev_alloc_skb(ndev, ndev->mtu + ETH_HLEN);
-		if (!skb) {
-			rc = -ENOMEM;
-			goto err;
-		}
+	/* Add some empty rx bufs for each queue */
+	for (q = 0; q < dev->num_queues; q++) {
+		queue = &dev->queues[q];
+
+		for (i = 0; i < NTB_RXQ_SIZE; i++) {
+			skb = netdev_alloc_skb(ndev, ndev->mtu + ETH_HLEN);
+			if (!skb) {
+				rc = -ENOMEM;
+				goto err;
+			}
 
-		rc = ntb_transport_rx_enqueue(dev->qp, skb, skb->data,
-					      ndev->mtu + ETH_HLEN);
-		if (rc) {
-			dev_kfree_skb(skb);
-			goto err;
+			rc = ntb_transport_rx_enqueue(queue->qp, skb, skb->data,
+						      ndev->mtu + ETH_HLEN);
+			if (rc) {
+				dev_kfree_skb(skb);
+				goto err;
+			}
 		}
+
+		timer_setup(&queue->tx_timer, ntb_netdev_tx_timer, 0);
 	}
 
-	timer_setup(&dev->tx_timer, ntb_netdev_tx_timer, 0);
-
 	netif_carrier_off(ndev);
-	ntb_transport_link_up(dev->qp);
+
+	for (q = 0; q < dev->num_queues; q++)
+		ntb_transport_link_up(dev->queues[q].qp);
+
 	netif_start_queue(ndev);
 
 	return 0;
 
 err:
-	while ((skb = ntb_transport_rx_remove(dev->qp, &len)))
-		dev_kfree_skb(skb);
+	for (q = 0; q < dev->num_queues; q++) {
+		queue = &dev->queues[q];
+
+		while ((skb = ntb_transport_rx_remove(queue->qp, &len)))
+			dev_kfree_skb(skb);
+	}
 	return rc;
 }
 
 static int ntb_netdev_close(struct net_device *ndev)
 {
 	struct ntb_netdev *dev = netdev_priv(ndev);
+	struct ntb_netdev_queue *queue;
 	struct sk_buff *skb;
+	unsigned int q;
 	int len;
 
-	ntb_transport_link_down(dev->qp);
 
-	while ((skb = ntb_transport_rx_remove(dev->qp, &len)))
-		dev_kfree_skb(skb);
+	for (q = 0; q < dev->num_queues; q++) {
+		queue = &dev->queues[q];
 
-	timer_delete_sync(&dev->tx_timer);
+		ntb_transport_link_down(queue->qp);
 
+		while ((skb = ntb_transport_rx_remove(queue->qp, &len)))
+			dev_kfree_skb(skb);
+
+		timer_delete_sync(&queue->tx_timer);
+	}
 	return 0;
 }
 
 static int ntb_netdev_change_mtu(struct net_device *ndev, int new_mtu)
 {
 	struct ntb_netdev *dev = netdev_priv(ndev);
+	struct ntb_netdev_queue *queue;
 	struct sk_buff *skb;
-	int len, rc;
+	unsigned int q, i;
+	int len, rc = 0;
 
-	if (new_mtu > ntb_transport_max_size(dev->qp) - ETH_HLEN)
+	if (new_mtu > ntb_transport_max_size(dev->queues[0].qp) - ETH_HLEN)
 		return -EINVAL;
 
 	if (!netif_running(ndev)) {
@@ -311,41 +362,54 @@ static int ntb_netdev_change_mtu(struct net_device *ndev, int new_mtu)
 	}
 
 	/* Bring down the link and dispose of posted rx entries */
-	ntb_transport_link_down(dev->qp);
+	for (q = 0; q < dev->num_queues; q++)
+		ntb_transport_link_down(dev->queues[q].qp);
 
 	if (ndev->mtu < new_mtu) {
-		int i;
+		for (q = 0; q < dev->num_queues; q++) {
+			queue = &dev->queues[q];
 
-		for (i = 0; (skb = ntb_transport_rx_remove(dev->qp, &len)); i++)
-			dev_kfree_skb(skb);
-
-		for (; i; i--) {
-			skb = netdev_alloc_skb(ndev, new_mtu + ETH_HLEN);
-			if (!skb) {
-				rc = -ENOMEM;
-				goto err;
-			}
-
-			rc = ntb_transport_rx_enqueue(dev->qp, skb, skb->data,
-						      new_mtu + ETH_HLEN);
-			if (rc) {
+			for (i = 0;
+			     (skb = ntb_transport_rx_remove(queue->qp, &len));
+			     i++)
 				dev_kfree_skb(skb);
-				goto err;
+
+			for (; i; i--) {
+				skb = netdev_alloc_skb(ndev,
+						       new_mtu + ETH_HLEN);
+				if (!skb) {
+					rc = -ENOMEM;
+					goto err;
+				}
+
+				rc = ntb_transport_rx_enqueue(queue->qp, skb,
+							      skb->data,
+							      new_mtu +
+							      ETH_HLEN);
+				if (rc) {
+					dev_kfree_skb(skb);
+					goto err;
+				}
 			}
 		}
 	}
 
 	WRITE_ONCE(ndev->mtu, new_mtu);
 
-	ntb_transport_link_up(dev->qp);
+	for (q = 0; q < dev->num_queues; q++)
+		ntb_transport_link_up(dev->queues[q].qp);
 
 	return 0;
 
 err:
-	ntb_transport_link_down(dev->qp);
+	for (q = 0; q < dev->num_queues; q++) {
+		struct ntb_netdev_queue *queue = &dev->queues[q];
 
-	while ((skb = ntb_transport_rx_remove(dev->qp, &len)))
-		dev_kfree_skb(skb);
+		ntb_transport_link_down(queue->qp);
+
+		while ((skb = ntb_transport_rx_remove(queue->qp, &len)))
+			dev_kfree_skb(skb);
+	}
 
 	netdev_err(ndev, "Error changing MTU, device inoperable\n");
 	return rc;
@@ -404,6 +468,7 @@ static int ntb_netdev_probe(struct device *client_dev)
 	struct net_device *ndev;
 	struct pci_dev *pdev;
 	struct ntb_netdev *dev;
+	unsigned int q;
 	int rc;
 
 	ntb = dev_ntb(client_dev->parent);
@@ -411,7 +476,7 @@ static int ntb_netdev_probe(struct device *client_dev)
 	if (!pdev)
 		return -ENODEV;
 
-	ndev = alloc_etherdev(sizeof(*dev));
+	ndev = alloc_etherdev_mq(sizeof(*dev), NTB_NETDEV_MAX_QUEUES);
 	if (!ndev)
 		return -ENOMEM;
 
@@ -420,6 +485,16 @@ static int ntb_netdev_probe(struct device *client_dev)
 	dev = netdev_priv(ndev);
 	dev->ndev = ndev;
 	dev->pdev = pdev;
+	dev->client_dev = client_dev;
+	dev->num_queues = 0;
+
+	dev->queues = kcalloc(NTB_NETDEV_MAX_QUEUES, sizeof(*dev->queues),
+			      GFP_KERNEL);
+	if (!dev->queues) {
+		rc = -ENOMEM;
+		goto err_free_netdev;
+	}
+
 	ndev->features = NETIF_F_HIGHDMA;
 
 	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
@@ -436,26 +511,47 @@ static int ntb_netdev_probe(struct device *client_dev)
 	ndev->min_mtu = 0;
 	ndev->max_mtu = ETH_MAX_MTU;
 
-	dev->qp = ntb_transport_create_queue(ndev, client_dev,
-					     &ntb_netdev_handlers);
-	if (!dev->qp) {
+	for (q = 0; q < NTB_NETDEV_DEFAULT_QUEUES; q++) {
+		struct ntb_netdev_queue *queue = &dev->queues[q];
+
+		queue->ntdev = dev;
+		queue->qid = q;
+		queue->qp = ntb_transport_create_queue(queue, client_dev,
+						       &ntb_netdev_handlers);
+		if (!queue->qp)
+			break;
+
+		dev->num_queues++;
+	}
+
+	if (!dev->num_queues) {
 		rc = -EIO;
-		goto err;
+		goto err_free_queues;
 	}
 
-	ndev->mtu = ntb_transport_max_size(dev->qp) - ETH_HLEN;
+	rc = netif_set_real_num_queues(ndev, dev->num_queues, dev->num_queues);
+	if (rc)
+		goto err_free_qps;
+
+	ndev->mtu = ntb_transport_max_size(dev->queues[0].qp) - ETH_HLEN;
 
 	rc = register_netdev(ndev);
 	if (rc)
-		goto err1;
+		goto err_free_qps;
 
 	dev_set_drvdata(client_dev, ndev);
-	dev_info(&pdev->dev, "%s created\n", ndev->name);
+	dev_info(&pdev->dev, "%s created with %u queue pairs\n",
+		 ndev->name, dev->num_queues);
 	return 0;
 
-err1:
-	ntb_transport_free_queue(dev->qp);
-err:
+err_free_qps:
+	for (q = 0; q < dev->num_queues; q++)
+		ntb_transport_free_queue(dev->queues[q].qp);
+
+err_free_queues:
+	kfree(dev->queues);
+
+err_free_netdev:
 	free_netdev(ndev);
 	return rc;
 }
@@ -464,9 +560,14 @@ static void ntb_netdev_remove(struct device *client_dev)
 {
 	struct net_device *ndev = dev_get_drvdata(client_dev);
 	struct ntb_netdev *dev = netdev_priv(ndev);
+	unsigned int q;
+
 
 	unregister_netdev(ndev);
-	ntb_transport_free_queue(dev->qp);
+	for (q = 0; q < dev->num_queues; q++)
+		ntb_transport_free_queue(dev->queues[q].qp);
+
+	kfree(dev->queues);
 	free_netdev(ndev);
 }
 
-- 
2.51.0


