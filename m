Return-Path: <netdev+bounces-294784-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9JlqKQg/IGq4zAAAu9opvQ
	(envelope-from <netdev+bounces-294784-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:49:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C7C638C5B
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:49:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=HYqsMU9T;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294784-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294784-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 003D030CE439
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 14:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A92B3D5C3A;
	Wed,  3 Jun 2026 14:36:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013066.outbound.protection.outlook.com [52.101.83.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD313D413B;
	Wed,  3 Jun 2026 14:36:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497419; cv=fail; b=V2EllpwiD7nFlS8wS7l1UXICdItc0mU9cJk22gq7AQaSylBE90nJmvUuY1fTkpTZcQlCUpIJ2MStJlzddfBIFLDrpkTcTgXkaIyuzTiOXJFz58VysUCqi7qZ6cEeFo76aZ8KQOc+DMYGeC1iP8EEyNMl4mdKo/XGO5bndYINGYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497419; c=relaxed/simple;
	bh=FPV8xPoZi3f4LO3UPvLDRrUxJlGDuQoFv60IewtT79k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ndNaFm3fgRWSzrYLYnSwrnax38g+ZJkcsylVGAvtyayuo6cOBgBXu/ZbLV6G3ZPui7gcHeZoS6wsd2J8Ib8YBGSrvTIRcCfgLSad0swvL8MgAoI5jBw/z4y1x5fB+jIQZm6b8xQBhhcsZn5/tTrmOR5RS+xBaxaJvDqRlUJi3d8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HYqsMU9T; arc=fail smtp.client-ip=52.101.83.66
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zKmd3vwVh2cLYmfhTlLPi99a9de1Ng52EOPZ1x5hoGdrbLriPCE3sqisO1celMeKn7wlHxBILEScC/NliRsMm+fvLuQB/8WL5gtT0OFos+LSVr4cesUv3fCF3pWMvr/K7OOS5brcICuH2Ga7hsI4p+vUKBdyEHv4UH+qmi/8p4IQb73FyC45xjT+KZakN8JNcQjNG930hyas2X1HdMb2lhF6BZEDsX6xk3TjhHRjyYk4f6e4/i+TY1V5XegFjNd/2OWxCS8sEkdnt3ECxHMMTKJ7fe5pbE4SHJljSg5gNoZ/i6ULlkusDQv7gAUCzOJlVESRqPe1Sj6zEwwcTzfmWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tWkJDwqLyt4R3E8W1fiSTj+FYGrdWFnXmly1mSJ298=;
 b=SZVmem33gomg7Wh/0O3mkA7ICycKOD0KTzBTZ74u7o4Fu9C+HabSvG+jzKnDbPY2pwXriyPGb4mJYOXTq+ZYLLWoh8nCQoo/Ci3VKgG6UdJQTl1yqAd68WYEQjObjHkDoSaii76UQeWBPm4bKbCT9qbKE3gF9LHnljWVjzeMs9yz+LqAkP32QUDtyPWfJ9elUQQdLUQB2x+WM9wxVwsw6eqLGao1FG/ZaeMIPTbgFegnZY0n/d6FHsn0ew9vz7AuArnp6RKJAhs8LLaUV3NgeXRUBooil0+ryAyy1fWZU7oHfEGu7CLpnhNAwgmmKWOv9WSb2P/kgaQJO/cRHmOREg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tWkJDwqLyt4R3E8W1fiSTj+FYGrdWFnXmly1mSJ298=;
 b=HYqsMU9TGfAZq2LEq+esofMvu36jKHMRgBYETQfrXTZmgWlDHiR164MFaCHRxHhnbaESPNtnIryhu/FrKRRwW6HRfjDZTwuzGpBSrT6IodHcIJp2Ehb+fNyapMfUt8vBDY76aXizPDXNFtpHcw9pUZYy2ZbVYYnrssEIPQxpUKd9UrUZwo2Azz6Es+bYG5Q7yLNFBNqRdW8I/7ULjXA8uxJBCd6PJOa/Y8TqxiiqgpmMFJP9B85o++wy+95O/NZFJNRScK2qGaDFzGwTwg75zoHyRkEbiMQT3YarHSFOy4EFdnIOpFTKgKont/pYd8c36TblIbLEh59giqp+i/qXCA==
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by VI0PR04MB10615.eurprd04.prod.outlook.com
 (2603:10a6:800:26a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 14:36:55 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 14:36:55 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 07/12] dpaa2-switch: check early if an FDB entry should be added
Date: Wed,  3 Jun 2026 17:36:18 +0300
Message-Id: <20260603143623.3712024-8-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603143623.3712024-1-ioana.ciornei@nxp.com>
References: <20260603143623.3712024-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0305.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::14) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|VI0PR04MB10615:EE_
X-MS-Office365-Filtering-Correlation-Id: aaa837ff-9122-4bb5-5034-08dec17d8f32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	CfjmNydkLwA3/luPyP8c9CSIwK0jCAICiJTRiLeqYaot+X/UG8fA0m5u6MrQhjzlgYAA+ujQBEFkriIJezeCcdZtOdD9TQ5pIfIixYXcvEzNtAmvERjZXysFFfsTCsEnlN6EEDSlg9jkzraSIijZuki2yPoIOxqjRD+34lAPtYsf0bEnGBrPpfutvLrIKC9FGryyv/ZBPKGjHafUrChsAKcxY/+eAuBoY0NAnHFwEcQHA/brxqIgBBVtaw1hJrsVx8/HYjvJm4HkB4qgVNAcv0+ZMi4ArxjUtvce3/b3EaMKwhDAn0QqRGnPUFvsv4Ng5LYeTndZc8I9eJB1rW97hSHQ5dyNKu46AHLY/sYMXQW/iUiFOSmC4SnOeJy3KWrQT4rDbZsgfpDMwjiifSSleoiJ1LfxJtEm8Ks1B20wT+EGbFThVAY7va2ohZByRQ/aRrZyceZsrLPHJ/JyvePEPEhsA2dSMEKUZAtzFfSBMsE/C3Pr/BcDWrpeNlDxt9/5Z8/QKhJpPARxYkZ9pdfv5aNs1pCP3SoNkrHr/AVDppp4XFXipCmC2ED5dA7jdjt4neCwIDO3U90FV2KgUwQ9nN6/reLjpVrL02Zut7+Kc5DqKqZ00oHinMAuQqxxYY084bzY0Z1zSeQdmRbu1r53PddxHooNRshn+eFnFJNnPKllZhsYWArhhpsyT2l2E0al
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B2ucuvaIVDsfU7fRKagCkwATNDNhiP8RxjjZMuRqOlsS6/r9Wu7z1+kgc307?=
 =?us-ascii?Q?ZTdmI40EvONJ2KFyabVZnchSlUN+Tb01CSXuVR3AL6Eky7gSotrkq6rK0c5U?=
 =?us-ascii?Q?ODqJx2AENzK1WognB+AGpe/B0l5j7B8Ke2TVyjkkNVmSWReNg2IN+oSWMUzr?=
 =?us-ascii?Q?iqyaQ2UKMb7Eiu7Z36tGDehhkn6ZDbUm1k6mVNuWxJD9MqG+RTEtuT4foFdz?=
 =?us-ascii?Q?0UPxhiFJQ9LGzIKIzB41aPTtzVZaH7Oy4dgGxlwl5gx0Z/0GTmVtVw2Md1cu?=
 =?us-ascii?Q?TvNpPANvwHl5mbfbfRUz5PFZ1Asbcq8cL0wm4Vp0rLC5F5u/CNOON+4LHGgI?=
 =?us-ascii?Q?NDwqrUR91+zegCQUfIAzQe9NHnbnk/UmqAyGzFugywK/WBPSXoeOf7WlsPKn?=
 =?us-ascii?Q?nYgQLKrCmWyR8c7tTF2DkZu+/NM9BKkPOzJeOGWpYbIO26NfeoueI/FHGOHe?=
 =?us-ascii?Q?E8jtbIMqrYfNytVp+jgFx/WE8lluN10vzg0MByjwj6X7N7zNEUSVUUXE6VLI?=
 =?us-ascii?Q?R1hZhW2U/W+ygKy4kbsJjvRSWgvp7H2GkkHN83pwCrFS32ex5IucHo9QXxWj?=
 =?us-ascii?Q?P+pqu5WjVpzFwjYrICXm+nKB75M105AEwPA+8OZ2prxsMahThMIDi0JkKYD7?=
 =?us-ascii?Q?M5DXIJe6j12FD8tDQEcbG4hECj9TsfqGF6Dd6iTE2njdtBTUxXInyCQNzq77?=
 =?us-ascii?Q?hnXRkotoTgh2VKb8BILMqUqXsLUo1yPtQh81FNVSCnmLA+W/ayQHlxSW3QKc?=
 =?us-ascii?Q?f90Bc32XLnT43TDcKAXMXnvAz7fXDSZ/7CLG/afYK2sPuWDtbivgT7onvKGN?=
 =?us-ascii?Q?yZYVVvtig3SMWJNk3YLDSJCvZ3C5VzeXesA6NewuQs2nqfWJyrHMEhzHsibg?=
 =?us-ascii?Q?0EDldKQ15fgKwnj8hp9gqDZPsMIg8XyIkYFS794J4or5mzcHxNXpRj/HAbh8?=
 =?us-ascii?Q?LU8BlMc94Ny0vYap0E1MnJR3gBEKFDKHPp46b7zLGOzGboEbFRR1TzJgj7vg?=
 =?us-ascii?Q?I/hxfb3hOd9jNmqMiiJ6Kdk91RKKd8Fsvejdlf+xYF8/sz4UuyehTA3RZgBs?=
 =?us-ascii?Q?wAh5xMYkZYZecoTeRoLZMg5o1gyhYoLfBggWS0j/1kU3ZlKwVNhO249JmrXm?=
 =?us-ascii?Q?uvNW0EGhFnjfNtqc/CjRpYfU2mm6NWtdPLRraQfbKybnKS/gZkWbX7sof/NJ?=
 =?us-ascii?Q?SYtUfkYNnZfnBVcqULz3sf/zw+y0hZ8ZGS73kaeOyi5IWocxo3+0wqR54MfL?=
 =?us-ascii?Q?MhhGcSsZKce0OhQe3T23dY211Y4+efaxu3OUP1kVm05CNa4wgz2ghVljERjN?=
 =?us-ascii?Q?rpExpvJxfoX92asYFrwgxUWZk5Vsy2EJSLpe3+pE3BDsVPQTc2nafe9wgcxP?=
 =?us-ascii?Q?Oz6V7JZbV/87Dgjm6s/DeblTI10irhc5YFhYBuGhLhF+2v+zOy5hRwSTrq0U?=
 =?us-ascii?Q?ixaxtGUFytdnNLDsls+K5w/+UjeDyUUGJnfmM+DUDzkxbmIBQU5Huh4sDpq7?=
 =?us-ascii?Q?g+i+cD9Ew/AsHu1EZI/5SD7BPk8JYpIouyBkKLSe1cGxxr07cDkcf8lCwKNJ?=
 =?us-ascii?Q?rbBB1jGThSXlyTKu/h+nWLFYJcRRbomZXgaZUpygR9fe35ROgFBWp6QmJ1oX?=
 =?us-ascii?Q?Aa1HUyMvbtVRDaUlk6eaFNza9S6UO3kkKfjs2rOs99BtCQekXMU4WJQZC7/O?=
 =?us-ascii?Q?dmjA6y8Wjb70GPDByIjCuQAqTxJaxoHz4nDINcRJLgqDPQi7pmvUNwzx67/L?=
 =?us-ascii?Q?a8Q5xsoidA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa837ff-9122-4bb5-5034-08dec17d8f32
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 14:36:55.1904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ktjAVfc8JomtyWnVya2s9iPYsQTBYM2DqUPF0tJNzD6PzJJFvjDdvyzG7dCqUJGBk56b3cfg0vrq75ZeCEvGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10615
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-294784-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:mid,nxp.com:dkim,nxp.com:from_mime,nxp.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 43C7C638C5B

Instead of waiting until the last moment to check if an FDB entry should
be added to HW, move the check earlier (before even scheduling the work
item) so that we don't just waste time.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v3:
- none

Changes in v2:
- none
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 8e109b54aec5..1b3dc7b4a741 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -2850,8 +2850,6 @@ static void dpaa2_switch_event_work(struct work_struct *work)
 
 	switch (switchdev_work->event) {
 	case SWITCHDEV_FDB_ADD_TO_DEVICE:
-		if (!fdb_info->added_by_user || fdb_info->is_local)
-			break;
 		if (is_unicast_ether_addr(fdb_info->addr))
 			err = dpaa2_switch_port_fdb_add_uc(netdev_priv(dev),
 							   fdb_info->addr);
@@ -2865,8 +2863,6 @@ static void dpaa2_switch_event_work(struct work_struct *work)
 					 &fdb_info->info, NULL);
 		break;
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
-		if (!fdb_info->added_by_user || fdb_info->is_local)
-			break;
 		if (is_unicast_ether_addr(fdb_info->addr))
 			dpaa2_switch_port_fdb_del_uc(netdev_priv(dev), fdb_info->addr);
 		else
@@ -2893,6 +2889,9 @@ static int dpaa2_switch_port_fdb_event(struct notifier_block *nb,
 		return NOTIFY_DONE;
 	ethsw = port_priv->ethsw_data;
 
+	if (!fdb_info->added_by_user || fdb_info->is_local)
+		return NOTIFY_DONE;
+
 	switchdev_work = kzalloc_obj(*switchdev_work, GFP_ATOMIC);
 	if (!switchdev_work)
 		return NOTIFY_BAD;
-- 
2.25.1


