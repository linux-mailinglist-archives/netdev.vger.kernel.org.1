Return-Path: <netdev+bounces-307369-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pa0lL9PbVWrBuQAAu9opvQ
	(envelope-from <netdev+bounces-307369-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 08:48:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A9F7519FE
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 08:48:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=outlook.com header.s=selector1 header.b=MTwHmXHi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307369-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307369-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=outlook.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C39D3044C08
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 06:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BD23E274C;
	Tue, 14 Jul 2026 06:46:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010002.outbound.protection.outlook.com [52.103.13.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D810D3DD523;
	Tue, 14 Jul 2026 06:46:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784011605; cv=fail; b=VE/NUP/0pEEobOIZQ/xoxok4SiMAR7zmRYa89wZXorRXa87j6wmcHcxv3J2P3CjBwpWrLQ09rh1yn0hBLt53WicoyE+Ma1f6pl+GGrYVv4YszoHIW7y0PCl8SSNQeR/0K98uRhp9PEUQMj4TgB7AL6pkp8X6m7dtQj7uFjZ0MOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784011605; c=relaxed/simple;
	bh=S9guCEJP4rj4EJQPcow0TfvVnQt0pJmmYo4Jae3ouQs=;
	h=From:Date:Message-ID:In-Reply-To:References:To:Cc:Subject:
	 Content-Type:MIME-Version; b=JpgjG4m5tT8oj7tpZ2xpdmYxqo2fqs9algysay8Cerpfex981XmrUCHWIgziOdv5i9ZDTf0O1ketXbxtBF/TlWsYzq2+MKrz292XKDGj7kfu6PvGIlvuYEelXvKIPy7b0toenZYYY7LqdcaI9ioePqr9mBBkBA2mrC9etM0Clko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MTwHmXHi; arc=fail smtp.client-ip=52.103.13.2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NnCrx0C3KytB2eIxoR4snKNODHQfVYFmNke4oP2NQsF8sgr4CY0K9EyAD1OfiX2pz9o32jBel2MDXzleuZESWRovgv3LWXVUBjEQLzSyzwplmlCdPuTGZJ0cKx/rI1cA+QHPk6JIo6w62Wu0kMGt1VnLPvEfgRaxJvdE9drf4B9XjfpywzHOFNklTS7V3E1JHWD+aKbRfDvr6gzKXhseozDRhZbZDPa14+cPs4c4OooEbdS2jQPzjA05Go/s2DDx3yT8pyggnJ6Hbjh8BedfskM2qKEKU7JRRWsvaaxFdC2bOKIFqyT71e+faJeEwLj7QYbrScHfveNhRcZuD4IjYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lo+yZECybGA4wp69HFQrP5ue7i3DFKI0mnQhcfyJV9w=;
 b=os/SxLZZ1PH6mGzEbqLYuRtDnTFtxTMttQ6bTX0BebvQaSONrRVoiI8gNd7LEvyZmESpJWGclzqCj7YBtpf6WzmwpcrSDt220AnTaS4tpHJBfdAwwQf6yHrDAbrrCKlVjVhj0YsPRU2LBmzHs0wN+PQZ+kiEKhEZagM/W9DKQq514PJVdkrv/hGL3W3N3siWphiv/QUaUAbcz6TQSRNtogYzZHjhme56HD1vXvMD8h8jXuzhK3xKhebyLGTZuFChaHah6i5XiHFuCumErlJHNwgk7PhXeNhujnL4K6h7sEGAOLLq+FxRX2bPex4W14WvFAIH5Nraqwyvm22uiImyeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lo+yZECybGA4wp69HFQrP5ue7i3DFKI0mnQhcfyJV9w=;
 b=MTwHmXHiRkAqod3PO1bJVRQIGxaZJqAuRMhseBO/sd5sUaxAcE2GZyIL3dg8we77SyQj6NppRBUqGw3f1/lIv9t0GaJiSwv7QqlWEsQs7VBsJHQ9y8cxoB2b39bUiR8YpoysMoV4siVmQ9HWzvk9JqHC8VyhBaN6JoKWXX34T5JtssgSmPep67jJtUDBn3pGt42GwtxmuGmBjRz6qWNiqAloR7rsEamWSW+MwiBX5XAWyKeUh0QSFSY10WfKRaWcYF9zJYuhh30rboJkw3dudxexFdzrp84z5GGsmUa47yM7ks8FrG+QA5++IBZytSSiXqSFR1ZZdGPT9WmGMy8IGw==
Received: from MN0PR19MB6091.namprd19.prod.outlook.com (2603:10b6:208:382::21)
 by CO1PR19MB4901.namprd19.prod.outlook.com (2603:10b6:303:f9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 06:46:41 +0000
Received: from MN0PR19MB6091.namprd19.prod.outlook.com
 ([fe80::af9a:4cc3:facf:9374]) by MN0PR19MB6091.namprd19.prod.outlook.com
 ([fe80::af9a:4cc3:facf:9374%5]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 06:46:40 +0000
From: Liu Changjie <liucj1228@outlook.com>
Date: Tue, 14 Jul 2026 14:46:20 +0800
Message-ID:
 <MN0PR19MB6091262B034DA5D02AD7B66FACF92@MN0PR19MB6091.namprd19.prod.outlook.com>
In-Reply-To: <03b781d223194234bcf6e53df12880b4.1784011580644350.tspi3m-maxio-v1-cover@outlook.com>
References: <03b781d223194234bcf6e53df12880b4.1784011580644350.tspi3m-maxio-v1-cover@outlook.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] net: phy: Add support for the Maxio MAE0621A
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0008.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:9::9)
 To MN0PR19MB6091.namprd19.prod.outlook.com (2603:10b6:208:382::21)
X-Microsoft-Original-Message-ID:
 <446df90e05064bc6b2149e78f58fc925.1784011580644366.tspi3m-maxio-v1-2@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR19MB6091:EE_|CO1PR19MB4901:EE_
X-MS-Office365-Filtering-Correlation-Id: f519bd08-ee42-4b65-4ab5-08dee173a8f1
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|5072599009|15080799012|5040399003|37011999003|24021099003|23021999003|41001999006|19110799012|8060799015|26104999009|440099028|3412199025|40105399003|3430499035;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sxhzXCDNILsqZG39FXrFOZYig15cgPxxRmmmCFAh3DnSsvbZcry9KRnza/eJ?=
 =?us-ascii?Q?lnKP1dEAFkMlj9d9vdks0BZ1/1lynbfigL2ifP/vwXa1vxQUBBLEtbp3DjCp?=
 =?us-ascii?Q?JClss0IHrQZ/HsvVXCEnXZRExZyybtlZXWt1B59JJpjA6KUJP7Kjq2NLKrRV?=
 =?us-ascii?Q?4ioObEfXHFmgZYfOUagKHRTyhoDBlp3kC8PVMQ9P2H69w9U3Ih9fOWjFPDz2?=
 =?us-ascii?Q?y53GVnCrICL/DfhMzTK1d1bRSa094nbAOZmFBHgbhgpM1jFe0uvnfuQS232E?=
 =?us-ascii?Q?BKWgQq93uanJveiQiEa7MPeBPiw3umALrHTubtDhRRm7KgPFWwXJvHe8mgWc?=
 =?us-ascii?Q?+c9GpGNTG8lWM4/6dXGxll2zJ2KQGGpJDRxI3SA+pZV24WKybrdSYsCy0D8k?=
 =?us-ascii?Q?IkXLYftqiJRqj12s7arrxi9viA1HzAJ0WqPOhsoDKZjERmanJF5hNPUiV9OP?=
 =?us-ascii?Q?BXnlxgq7h9Ck/aQ8yBGF3QypCz8GpfeJAfEtPJm9K8pwg1mmwx6frxXkqaAb?=
 =?us-ascii?Q?5HM1G1bShLehq6pADd0mbDF5ganroMNDerLaEdOu7fRu8T5gMEa9vaa7zFEp?=
 =?us-ascii?Q?ROTZozGJYO/qTxWPVhlVHNAbOoMiVrXhRS/52t/nbjjQWJ+Bu42UZaA+XyZW?=
 =?us-ascii?Q?dsSR9FHVWVQo5X7Eo1ZbfL7O8gly2CNHyL9Qu4yoUkWpkeNB7aie8Hl8J0qV?=
 =?us-ascii?Q?R18GTrK/1w2dh6hl/SoucChfnjqtxDgRyaI4OP4CdTky1QQYpu78BdCwCu1o?=
 =?us-ascii?Q?yup0oC6OxWaZ2b91xjuWxaavfh6ovrUdVz7s/f+xeAQA/BJGJs/Zdt7xHOPR?=
 =?us-ascii?Q?XwN8igL5SkGZe0HCTehaI76RgZ9Dmin7OE1V+8H9iAD8kk0L1DVO5mUXAJpP?=
 =?us-ascii?Q?fXnrIbH+F0eZkjQ2KDRqfkzSWY+G6hxsydiSr+qxPNGLMnjQ/JY3T0BnordF?=
 =?us-ascii?Q?kHRGfmTpZGP001TdKe26Rf3VM6dpBeBT4SeeXWXrJPlgdK53vv4eKKyAXEYT?=
 =?us-ascii?Q?KCYp?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HVqiDwCSgzagtb6ZCF9bPY0QM6tA6uoFxdJgE8e5lk+pdW/V2FEoL1yVZRDQ?=
 =?us-ascii?Q?mWyQNFvazZzHVfynk9290HTP5Ma9CqrYSTLxYYE5zUx+g/PPw/CHDP2at08l?=
 =?us-ascii?Q?pQdlgjQpUj/OKAvbGXcx68TXxYFw3lT2A31BnxMC9VMev4AedUha1qS+kmzp?=
 =?us-ascii?Q?KUPAHEMq/uxBBwol/RGwLD6vJno6e1hwylFIHT+yT9sLATsc8prhmDRRi2o7?=
 =?us-ascii?Q?oOPGxqu3AKspn/x+Tnp0ptvG3KGhQhQ6Z0c3nAX0ljkzGmSSWOZPXJBet/em?=
 =?us-ascii?Q?+G5WHf+t6tBnHRE6MQrKz/cXP2dkNh9LltMZnkHReipdMky9DA+rV2znuwz9?=
 =?us-ascii?Q?p/YOw9onG6NpBjQWzb3NsB71hur7L4mpx4ivIBHNXGo2qdCnAiqnsdXGhkOZ?=
 =?us-ascii?Q?ACEeG1mVLwXQceRmkZiPhtHBVsgd/1WhCzQzo4nzwq7w7IsBQ4k77puVUXQE?=
 =?us-ascii?Q?xB21JgwbWFLer7ythoR7e1ESUGwNgV7dwXIvq7NMvUu+Y/STQBT6IHeDSEul?=
 =?us-ascii?Q?DieC1gZrrO2qA9WlGGRsgaEt6Ag4fPPmnpePJ6y4dZ9QQD8oV+2w8ZKJk12g?=
 =?us-ascii?Q?RxhmdR0mnySLsLC/PCvBEWBYFcRlvxfj6v4QzcRrwlA9yZyBKkhY4O+G7sW/?=
 =?us-ascii?Q?6k8jZUNkamgvClK4ZCGta9dEQddIooUL4GvA5o7uwtFUvJzSwDH/EhmXLHaa?=
 =?us-ascii?Q?1yuziV4nygeg2/jfQZfvsn/HDELd7ylqhMhOdu7N5tcEt7sVgF+xjDJ7dKtO?=
 =?us-ascii?Q?PFmINlA7t1EQVC4Pfzu/Das/LXjXqQuscB192OEKzTgdB42fauQASkPKnWrQ?=
 =?us-ascii?Q?HVrWozXDg6Z+eeYYmO2fseMQ1J9F5kCnAS2NnzgBs68b2HINkw9fPtUwHavx?=
 =?us-ascii?Q?QPiREdOzgsNQtpRPaJVESo9CSb0znPNMXIr7c+06kmL0HTrp8shMIPNVG0Du?=
 =?us-ascii?Q?AqRijCj6rmdCqoA12Q+svCTEek0pPnhjbug8xqII1GvHJIeqtxhG3cWbClFP?=
 =?us-ascii?Q?VmcVNF1A54xQeWvTks4xvQAYItVr9tCtETxwgBPfkVlhVnP3+lsKtK9WDOJ8?=
 =?us-ascii?Q?hUIF9itRZ9+PMb+SSkQi7xInkYwXRrqp4velt19LhOdsCihW6IXtg0ep4/2C?=
 =?us-ascii?Q?BIlfr41ZI+j21lVYoQ6AF5xHanrBQeDYMA0LIvswuo7n32KLHTyCvOG+MMvV?=
 =?us-ascii?Q?PvOYAxLQVskJ7vQbjJi1xDoxb45MXuAXNHddLCFNo0m/69ODNGaEbBG6mQAO?=
 =?us-ascii?Q?213M8I0GYR1b65N2JKHcc4c4cHPUF3UGP/LuGX6/4Ltf1oxVHqIBj/xJlsqt?=
 =?us-ascii?Q?W/7dD9RsokN7n+ko4SreQkP+2ZrVpBYTRvr521a6vz8Yy6fWpznIWtd86I/k?=
 =?us-ascii?Q?XDtYTGgZx7A9gEA9ezy3cPlopK3+wF70A2XUm/5V6ft8DABFlA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f519bd08-ee42-4b65-4ab5-08dee173a8f1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR19MB6091.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 06:46:40.6612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR19MB4901
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307369-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[outlook.com];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux@armlinux.org.uk,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[liucj1228@outlook.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liucj1228@outlook.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[MN0PR19MB6091.namprd19.prod.outlook.com:mid,outlook.com:from_mime,outlook.com:email,outlook.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 23A9F7519FE

Add exact PHY ID matching and optional 125 MHz CLKOUT configuration
for the Maxio MAE0621A Gigabit Ethernet PHY. Preserve the existing
hardware configuration when the firmware property is absent.

Signed-off-by: Liu Changjie <liucj1228@outlook.com>
---
 drivers/net/phy/Kconfig  |   8 +++
 drivers/net/phy/Makefile |   1 +
 drivers/net/phy/maxio.c  | 103 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+)
 create mode 100644 drivers/net/phy/maxio.c

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 099f25dce..32e1a035b 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -283,6 +283,14 @@ config MARVELL_88X2222_PHY
 	  Support for the Marvell 88X2222 Dual-port Multi-speed Ethernet
 	  Transceiver.
 
+config MAXIO_PHY
+	tristate "Maxio Ethernet PHYs"
+	help
+	  Support for Maxio Ethernet PHYs. Currently this driver supports the
+	  MAE0621A Gigabit Ethernet PHY. The driver optionally selects a 125 MHz
+	  clock on the CLKOUT pin while preserving the hardware configuration on
+	  boards which do not request it.
+
 config MAXLINEAR_GPHY
 	tristate "Maxlinear Ethernet PHYs"
 	select POLYNOMIAL if HWMON
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index de660ae94..7fb3626f0 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_MARVELL_10G_PHY)	+= marvell10g.o
 obj-$(CONFIG_MARVELL_PHY)	+= marvell.o
 obj-$(CONFIG_MARVELL_88Q2XXX_PHY)	+= marvell-88q2xxx.o
 obj-$(CONFIG_MARVELL_88X2222_PHY)	+= marvell-88x2222.o
+obj-$(CONFIG_MAXIO_PHY)		+= maxio.o
 obj-$(CONFIG_MAXLINEAR_GPHY)	+= mxl-gpy.o
 obj-$(CONFIG_MAXLINEAR_86110_PHY)	+= mxl-86110.o
 obj-y				+= mediatek/
diff --git a/drivers/net/phy/maxio.c b/drivers/net/phy/maxio.c
new file mode 100644
index 000000000..d2cb23895
--- /dev/null
+++ b/drivers/net/phy/maxio.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Driver for Maxio Ethernet PHYs. */
+
+#include <linux/bitops.h>
+#include <linux/module.h>
+#include <linux/phy.h>
+#include <linux/property.h>
+
+#define MAXIO_MAE0621A_PHY_ID		0x7b744412
+
+#define MAXIO_PAGE_SELECT		0x1f
+#define MAXIO_MAE0621A_PHYCR2_PAGE	0xa43
+#define MAXIO_MAE0621A_PHYCR2		0x19
+#define MAXIO_MAE0621A_CLKOUT_125M	BIT(11)
+#define MAXIO_MAE0621A_CLKOUT_ENABLE	BIT(0)
+
+struct maxio_priv {
+	bool clk_out_125m;
+};
+
+static int maxio_read_page(struct phy_device *phydev)
+{
+	return __phy_read(phydev, MAXIO_PAGE_SELECT);
+}
+
+static int maxio_write_page(struct phy_device *phydev, int page)
+{
+	return __phy_write(phydev, MAXIO_PAGE_SELECT, page);
+}
+
+static int maxio_mae0621a_probe(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	struct maxio_priv *priv;
+	u32 frequency;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	phydev->priv = priv;
+
+	ret = device_property_read_u32(dev, "maxio,clk-out-frequency-hz",
+				       &frequency);
+	if (ret == -EINVAL)
+		return 0;
+	if (ret)
+		return ret;
+
+	if (frequency != 125000000) {
+		phydev_err(phydev, "invalid CLKOUT frequency %u\n", frequency);
+		return -EINVAL;
+	}
+
+	priv->clk_out_125m = true;
+
+	return 0;
+}
+
+static int maxio_mae0621a_config_init(struct phy_device *phydev)
+{
+	struct maxio_priv *priv = phydev->priv;
+	int ret;
+
+	if (!priv->clk_out_125m)
+		return 0;
+
+	ret = phy_modify_paged_changed(phydev, MAXIO_MAE0621A_PHYCR2_PAGE,
+				       MAXIO_MAE0621A_PHYCR2,
+				       MAXIO_MAE0621A_CLKOUT_ENABLE |
+				       MAXIO_MAE0621A_CLKOUT_125M,
+				       MAXIO_MAE0621A_CLKOUT_ENABLE |
+				       MAXIO_MAE0621A_CLKOUT_125M);
+	if (ret <= 0)
+		return ret;
+
+	return genphy_soft_reset(phydev);
+}
+
+static struct phy_driver maxio_drivers[] = {
+	{
+		PHY_ID_MATCH_EXACT(MAXIO_MAE0621A_PHY_ID),
+		.name		= "Maxio MAE0621A",
+		.probe		= maxio_mae0621a_probe,
+		.config_init	= maxio_mae0621a_config_init,
+		.suspend	= genphy_suspend,
+		.resume		= genphy_resume,
+		.read_page	= maxio_read_page,
+		.write_page	= maxio_write_page,
+	},
+};
+module_phy_driver(maxio_drivers);
+
+static const struct mdio_device_id __maybe_unused maxio_tbl[] = {
+	{ PHY_ID_MATCH_EXACT(MAXIO_MAE0621A_PHY_ID) },
+	{ }
+};
+MODULE_DEVICE_TABLE(mdio, maxio_tbl);
+
+MODULE_AUTHOR("Liu Changjie <liucj1228@outlook.com>");
+MODULE_DESCRIPTION("Maxio Ethernet PHY driver");
+MODULE_LICENSE("GPL");

