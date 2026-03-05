Return-Path: <netdev+bounces-264472-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HkEAxioqWmbBwEAu9opvQ
	(envelope-from <netdev+bounces-264472-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 16:58:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 822E2215006
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 16:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30EC3305ACA1
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 15:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8323C6A56;
	Thu,  5 Mar 2026 15:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="eDbhtOTD"
X-Original-To: netdev@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021081.outbound.protection.outlook.com [40.107.74.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45383CD8AB;
	Thu,  5 Mar 2026 15:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772726215; cv=fail; b=THsSpXq+khi4ZMxosNuYfhglsYvMpD54OQVEGbspWgaKV3sl7+6ldPjP0zaVoNsv/EhREkpQ3dXLjz5QC7l4ymz3Tjvr8/ZcfA8ujVVAj93I6+fNmWN6hCXydOd2CcweGpM5ZzJMzdSKpzMXnceZjE4xnQ9l7EH0DP2dLVI8/k8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772726215; c=relaxed/simple;
	bh=SzGLouDnynt7GQYgGra97hkbKoh1+Z3tgMqKLm6KNfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NBTO3s5lrjDStgHn4QPAUAk8FMbfzodmWhqyfUJWVz34nn9tvEfGse9YmjtWBt2u5bBtTkdOV2VBsIVeS9ZK268MDmHfmSgKxrM0EPPPYpzKf7Qk6AB9EztQAYSpJwzJSKVOUmbne0Bsffm8jSih4TCGioGpMqTbpFXBequbk3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=eDbhtOTD; arc=fail smtp.client-ip=40.107.74.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cckTvWJhq1ZgqrCW8YsmLYumSIF94knTK3xyXetetHtxMJjhNJu782v2DCoQLo2MCpPgyZ68cAZdHLmdOtSc+vF3PK/+vrUjslJEkitjxSgK4NeOMdqtIdFWkXUWg5m9Agne/kqKHeSRwWpplIKd88R3hD5oauP6vQ0+Hk9oyHjWQe0aG7BedP93WFNeb/ozAmm902txFgYS0m3mMX5JVW8tzgDDXvXYyw/W+iLEJXa035S4oiwoJrzTgKBEudgdm2bGL97O2n0mE4H1HoZ4kGRMW3/sn6UhlzbQr3djYPl9use0YcKnfQowdtL7ucJhJ6v33r3xWsPBIQtv4GNJrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7vfPwUFrIPhhveeO6qXJKoySSUaTrEedhg6Gtj4evo=;
 b=Nb+x0x5qusDTQkhlaN+qt4CBXJlRP2RLTzE/kzEki/MBeAXc/FAA3oZJyaBsWnRu1n5IUVj65lhl+orgXM2by1DgjE8I0Rt9wkibMO840YDv66r9BvaERUQ2qrNNxxADWl8gpkz2B3hH7LSeEDhAfhJY6HdfcXAMaTe8Yg+VfsCfs4nxhy6plFA1N9xPDFuCRa8FJIDdcBhkwx8Q8490w5sgjgyE14Ar77iIC1GZ1j3v52slGTyTbD9bMS5OZgfcUyJFEt8hWTmWEpzTp93LehY0UX9Zzfyd7V91vMnN75ZeDj93aVuOy1DPg/7hga4tU8dezktilzZOW1u2k4hdWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7vfPwUFrIPhhveeO6qXJKoySSUaTrEedhg6Gtj4evo=;
 b=eDbhtOTDg5MnGcReRpCsnPEaJL50UJlrQMuHXU4uOWXYJTrqNKOkEV49GSkxmho7AjaJu5nQkKC6In6V2pb4ISvUvIrn45ufPyq3ewR7T6IZ2HQ7JtKpEw3gcY3Md2zgzd+KSjsR/G7IuH6XeidQQiITjYq0k5zvizDqKNJPW08=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:468::22)
 by TY3P286MB2756.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 15:56:46 +0000
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71]) by OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71%3]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 15:56:46 +0000
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
Subject: [PATCH v3 3/4] net: ntb_netdev: Factor out multi-queue helpers
Date: Fri,  6 Mar 2026 00:56:38 +0900
Message-ID: <20260305155639.1885517-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260305155639.1885517-1-den@valinux.co.jp>
References: <20260305155639.1885517-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0082.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::14) To OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:468::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOP286MB7730:EE_|TY3P286MB2756:EE_
X-MS-Office365-Filtering-Correlation-Id: 4efc5edb-a68b-4954-b651-08de7acfcdf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	J5VljWpiePYi3HA0U4le0Gl4+/6mlsu8okSoN/U/lSr/y8IoqciWrfIcIhopB9CBpM9zA6+CCdEDLfgoc5yM9xhfI+MSiINW7YcrO0LHD7vhyYXSNVHIVoERJ4Kc7vAtTnwfju9Ep/Frw6MTJLRQ3/jN3fjML7YrKlSbQPoMfMT13zr5GWQeIYcixb8z+6ZM/H1j1clj+DjmqNtQyl96tUQ2srDamAi2bE08hjnxIKgb7HVHSsYQb+fCD9Fuzveu8KkEn6yI2QXgYWALqupMAtVkLqm28y59m2Mv7kfpDwlnNP5lEuNVh1smyJ2Uh8YRaKxyC8AfgUg6kSLyRXGAxPXwZ7da/V7NwOtnk+9ro2xx/WInFHahe2Xk7xfVxoTd4vpyBosUdqqPMD8ZoDymGOToqPHCUUS/rEGIcLxWKEMoTNkUoOUBvMO+d7fo1X4tCd1OQS6AmjJO6wTOwDIvgCoiV/Jds/zJ6PZwebElOzwuWbInpcHOJOcaRRSERaG9FCl0xZzISAyQ4NUdty2TwnOg33QdMk5sIHIpBxxOgOftSnKd9Rs+9uYUomEPsmUr/ewKxIU2tLQW37aloopNy+WzSvI5MXaJh5OEZOQA9gEWT6YBMfC0HbendttRvL2EfrUg68OCuTB94UReuInR8RZ6D3lwAOHVpPjfPnj8v3rIFNp0kkSOkSHduuYFyF5LPqv5JzxtOkWgyNekZylk5zina/PAT5tdSTEWNoAKHu0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1F06TuW1CwXOh7pZsehThKknRi+GLMdm6kDdmgWKk324v+uy1mEvbYwZ6UIB?=
 =?us-ascii?Q?I3hhct5ULqfAad8lVrsmHolFXBF/E4lBseSjMQzOlUszfwymfkY9DBFITVlV?=
 =?us-ascii?Q?PdP/o8P+s8UHXaOCfcmW2OAM9IKQGHPHNhU5I1/uZ1tU9oeimV3lYf8h2eCU?=
 =?us-ascii?Q?uMzxc6EFnMZCBwhX3sIDlK4GkY7pLujXZZJTQdSq7ItK1oiRN6TUslFzG07E?=
 =?us-ascii?Q?7STHvNtWOLHbKtCPzztdSUgeC6JBVvLFmKRA8vNLbhDiw/61+2uie7faTsib?=
 =?us-ascii?Q?/fwZ0JvYfCkYK+iKz/AquHy++Lhx0+Tzt+sYkzo7/++xW6Dym3BISjAdHhSE?=
 =?us-ascii?Q?3495itr9AIYOmT8CdX265iP9Ogp5m7TIjA16iOAGwzlluAhpVHAvvAWLMqC+?=
 =?us-ascii?Q?jdd7m82nOSbBrGFXS+m4sDQjNNw+eIK+rx9cC/+meufbEPtOEaDTJRtjXbEx?=
 =?us-ascii?Q?yDduleQrgkiPNH8XZ3q/r8OFEn+D2OVK020seQWuJj1LP6RANf+CaOW7LJW8?=
 =?us-ascii?Q?l9mEXPBD0DCYABNBQEKCkgGQSB/EfgjYZYS5ANFr18bV0gPz9ovCNWp0v+V6?=
 =?us-ascii?Q?tgtN0wvkJLPjzemhoIXh2AOV5ydeoIxZuIm4Ddc953Y3EtMYQWJVrNZAdZLS?=
 =?us-ascii?Q?6s6it7qxJde1m23nyx1rj5dk+fKlkQnE8VWnu+jWQEZo3KOX5yvyNhovX3Oa?=
 =?us-ascii?Q?SNLqZnL4iAiiZby79iStaEoS0ov4XXq/CgfYKIDjRv17nqcysNtjNxxi6pcu?=
 =?us-ascii?Q?OvJ36uvvBX+BCYhKeY7ZomocUB4Sx1d9aHXp8hgY0WtPneMO+PAGFvze8c3x?=
 =?us-ascii?Q?tyNBMTChpj3goRLWFtacZhV4TfrzGTyjcaRXdaIH57Fp2xfSXv6wUeLkS/zg?=
 =?us-ascii?Q?aMHQjiBnWka+I9r5EwPWQGmByAArIg7F01bDWEEpS4lj5UaaCzq3v7xUgrUZ?=
 =?us-ascii?Q?aVIM+DK3Yemvedr+1Dr9IQbyxvuJqP8UymddkO9wIiuogJHYnxGGV0wRNq14?=
 =?us-ascii?Q?uOyppOLS9FyFjgw9VBQ4c4f7rqSIIMMUiFPsmPgG+emuGjLjIKnXIFsKMMwH?=
 =?us-ascii?Q?HafHjk19JEpXeAXg/Exy1tQr47uhWvbLVd3tm+iCI+k8hHjDHuGo/nrcP5pA?=
 =?us-ascii?Q?tCfiIe7UmlKD0Z+Bvyi7ni1xftVaTdWb0JoIqG78JO8Kgu+yo28IyHtBW6ES?=
 =?us-ascii?Q?vv2w3UKK/IBtaaZbfVs2WvRxGeQ5lgMkL99c92/5g9Hn0DDO6/VARHHdsqEH?=
 =?us-ascii?Q?VdiRSUQO8AmxN0NTPjcC1t4AD2wIw4XzS2EAL1pDivVg/3PWTf8ZXLp8err4?=
 =?us-ascii?Q?nbcFhr0bbZOk5ZeGn+/1RVu7YGJg9NU3rWktuefo6VUKYzofZbtD2NOYQWlX?=
 =?us-ascii?Q?lSlfG5X7uyaHuuy9Qyt8EvyR0nSmoS65Vlq6SZKnyL1Sx1MaSSj9b5u4Bpdg?=
 =?us-ascii?Q?WMPiZQOFm49PgRMN+LfCF3dP7nwx2+2sDZnyXKWcX8iYSlQvjMk0p/sfmiXN?=
 =?us-ascii?Q?aNtnpd93p2f8EnKh9d+aNtm4bUqlUP4Iz/38Q7W5/9e0QwB9748sgyz6+xPI?=
 =?us-ascii?Q?utdcyp5jWglD/JazuHLE6LsSCYOGDRWXeOmv5XTrio0BzIlOuanOB3ylTOwS?=
 =?us-ascii?Q?9QHBrcnJOEYXAQrnMKxrpfK3TlFR1AIc8rlxdywKBfLMTJl58g8VYnw5tbl9?=
 =?us-ascii?Q?1IgzwTZ/Fgf38mcXPz94Yi8cZEj9OIThrMKl+782YH3k1Q0jtk5PKQqm3QHp?=
 =?us-ascii?Q?KPfn4sMYeHv9nP7Hd2LPhEDL1wEJkK3idkcqTUZ/f4vyARyqj2rb?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4efc5edb-a68b-4954-b651-08de7acfcdf1
X-MS-Exchange-CrossTenant-AuthSource: OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 15:56:46.5680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZ0gRR9d2LPRrZZ9WjiQW/vham2+uaZkxAEyaEp149u2JI5DdQt3GitigdUlhOsvGWOl5QyEDE9Ko0zDujQ8zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2756
X-Rspamd-Queue-Id: 822E2215006
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
	TAGGED_FROM(0.00)[bounces-264472-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Implementing .set_channels will otherwise duplicate the same multi-queue
operations at multiple call sites. Factor out the following helpers:

  - ntb_netdev_update_carrier(): carrier is switched on when at least
                                 one QP link is up
  - ntb_netdev_queue_rx_drain(): drain and free all queued RX packets
                                 for one QP
  - ntb_netdev_queue_rx_fill():  prefill RX ring for one QP

No functional change.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Adjusted context due to changes on Patch 1.
  - No functional change intended.

 drivers/net/ntb_netdev.c | 101 +++++++++++++++++++++++----------------
 1 file changed, 61 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index e4c1422d1d7a..ac39652b0488 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -94,26 +94,14 @@ struct ntb_netdev {
 #define	NTB_TX_TIMEOUT_MS	1000
 #define	NTB_RXQ_SIZE		100
 
-static void ntb_netdev_event_handler(void *data, int link_is_up)
+static void ntb_netdev_update_carrier(struct ntb_netdev *dev)
 {
-	struct ntb_netdev_queue *q = data;
-	struct ntb_netdev *dev = q->ntdev;
 	struct net_device *ndev;
 	bool any_up = false;
 	unsigned int i;
 
 	ndev = dev->ndev;
 
-	netdev_dbg(ndev, "Event %x, Link %x, qp %u\n", link_is_up,
-		   ntb_transport_link_query(q->qp), q->qid);
-
-	if (netif_running(ndev)) {
-		if (link_is_up)
-			netif_wake_subqueue(ndev, q->qid);
-		else
-			netif_stop_subqueue(ndev, q->qid);
-	}
-
 	for (i = 0; i < dev->num_queues; i++) {
 		if (ntb_transport_link_query(dev->queues[i].qp)) {
 			any_up = true;
@@ -127,6 +115,58 @@ static void ntb_netdev_event_handler(void *data, int link_is_up)
 		netif_carrier_off(ndev);
 }
 
+static void ntb_netdev_queue_rx_drain(struct ntb_netdev_queue *queue)
+{
+	struct sk_buff *skb;
+	int len;
+
+	while ((skb = ntb_transport_rx_remove(queue->qp, &len)))
+		dev_kfree_skb(skb);
+}
+
+static int ntb_netdev_queue_rx_fill(struct net_device *ndev,
+				    struct ntb_netdev_queue *queue)
+{
+	struct sk_buff *skb;
+	int rc, i;
+
+	for (i = 0; i < NTB_RXQ_SIZE; i++) {
+		skb = netdev_alloc_skb(ndev, ndev->mtu + ETH_HLEN);
+		if (!skb)
+			return -ENOMEM;
+
+		rc = ntb_transport_rx_enqueue(queue->qp, skb, skb->data,
+					      ndev->mtu + ETH_HLEN);
+		if (rc) {
+			dev_kfree_skb(skb);
+			return rc;
+		}
+	}
+
+	return 0;
+}
+
+static void ntb_netdev_event_handler(void *data, int link_is_up)
+{
+	struct ntb_netdev_queue *q = data;
+	struct ntb_netdev *dev = q->ntdev;
+	struct net_device *ndev;
+
+	ndev = dev->ndev;
+
+	netdev_dbg(ndev, "Event %x, Link %x, qp %u\n", link_is_up,
+		   ntb_transport_link_query(q->qp), q->qid);
+
+	if (netif_running(ndev)) {
+		if (link_is_up)
+			netif_wake_subqueue(ndev, q->qid);
+		else
+			netif_stop_subqueue(ndev, q->qid);
+	}
+
+	ntb_netdev_update_carrier(dev);
+}
+
 static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 				  void *data, int len)
 {
@@ -298,28 +338,16 @@ static int ntb_netdev_open(struct net_device *ndev)
 {
 	struct ntb_netdev *dev = netdev_priv(ndev);
 	struct ntb_netdev_queue *queue;
-	struct sk_buff *skb;
-	int rc = 0, i, len;
 	unsigned int q;
+	int rc = 0;
 
 	/* Add some empty rx bufs for each queue */
 	for (q = 0; q < dev->num_queues; q++) {
 		queue = &dev->queues[q];
 
-		for (i = 0; i < NTB_RXQ_SIZE; i++) {
-			skb = netdev_alloc_skb(ndev, ndev->mtu + ETH_HLEN);
-			if (!skb) {
-				rc = -ENOMEM;
-				goto err;
-			}
-
-			rc = ntb_transport_rx_enqueue(queue->qp, skb, skb->data,
-						      ndev->mtu + ETH_HLEN);
-			if (rc) {
-				dev_kfree_skb(skb);
-				goto err;
-			}
-		}
+		rc = ntb_netdev_queue_rx_fill(ndev, queue);
+		if (rc)
+			goto err;
 
 		timer_setup(&queue->tx_timer, ntb_netdev_tx_timer, 0);
 	}
@@ -335,9 +363,7 @@ static int ntb_netdev_open(struct net_device *ndev)
 err:
 	for (q = 0; q < dev->num_queues; q++) {
 		queue = &dev->queues[q];
-
-		while ((skb = ntb_transport_rx_remove(queue->qp, &len)))
-			dev_kfree_skb(skb);
+		ntb_netdev_queue_rx_drain(queue);
 	}
 	return rc;
 }
@@ -346,9 +372,7 @@ static int ntb_netdev_close(struct net_device *ndev)
 {
 	struct ntb_netdev *dev = netdev_priv(ndev);
 	struct ntb_netdev_queue *queue;
-	struct sk_buff *skb;
 	unsigned int q;
-	int len;
 
 	netif_tx_stop_all_queues(ndev);
 	netif_carrier_off(ndev);
@@ -357,12 +381,10 @@ static int ntb_netdev_close(struct net_device *ndev)
 		queue = &dev->queues[q];
 
 		ntb_transport_link_down(queue->qp);
-
-		while ((skb = ntb_transport_rx_remove(queue->qp, &len)))
-			dev_kfree_skb(skb);
-
+		ntb_netdev_queue_rx_drain(queue);
 		timer_delete_sync(&queue->tx_timer);
 	}
+
 	return 0;
 }
 
@@ -428,8 +450,7 @@ static int ntb_netdev_change_mtu(struct net_device *ndev, int new_mtu)
 
 		ntb_transport_link_down(queue->qp);
 
-		while ((skb = ntb_transport_rx_remove(queue->qp, &len)))
-			dev_kfree_skb(skb);
+		ntb_netdev_queue_rx_drain(queue);
 	}
 
 	netdev_err(ndev, "Error changing MTU, device inoperable\n");
-- 
2.51.0


