Return-Path: <netdev+bounces-275729-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDxOMs8a1GnHrAcAu9opvQ
	(envelope-from <netdev+bounces-275729-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 22:42:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 324593A7471
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 22:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C22A8304D5E3
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 20:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2013264C7;
	Mon,  6 Apr 2026 20:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="efH7o1+7"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013029.outbound.protection.outlook.com [52.101.72.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EBD311959;
	Mon,  6 Apr 2026 20:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775508100; cv=fail; b=q4EvUb4sgqtiQ4lnONFNg2dMpJX7d+NiyHdb+6LK27gPiHJGPv0nmEE/SLDeh47fyMgjD4ql3BDvaTneOfmNh/ir440QmAxpTVK9Uu6MUF+tJjXCL7fbNLqT8Het5AcErN1tlyhRaZIx4MUkQNXGq6OfIgyw5vlwWj+IVbbiNGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775508100; c=relaxed/simple;
	bh=ZqItfYshzoXsI3KpzU97yVyU8NBl2aEvWbFXHWDbO3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V/9sSimQHCV7mqio+6JXA6t/MnBd+CW9OExw6frzUjgFthmt57F+rJIw17tp/sHpuSgHpwuuiCvuT3MfsQsx+cHV3wsVQ9oqYOZ79iZKDhpgnTfq96pAt3x44DvEv9VGkc+ET+0LN5zOPjF4C6BnwVWBqRfhTjF+1BXQDyWIDrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=efH7o1+7; arc=fail smtp.client-ip=52.101.72.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ffLKEAFlayGFM/5YtpeuE/l+Ry+yoGZfJSQgKxL8dnPNuffoeW3ltB5G4Xzj1GZUtg+PbXtMGqxpgSP0qCKfL/Ng7iJhPxzNqu1VtdZeMz10tdg+j+FOGJQHYt5oikrbYwboje0Ih86K77ewgHEnpj5A8Tn3p15Vmme5nlLepdunCeV+vWCwGO6+eVQWm5PUF61Zek7tZXJTu9V8uyIon79IyIp+f1xJG3GPhaEuC8dpi4jlONAm/dLtWjzNMrOohizAlk4S0rtOEM3eDVGoUqeSqn6M+IYEINysdM7qQ1gLcKwn+EFlBGB8fb1D8Q1esosssv+qzFvTVfs/ie9bNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcetKXWsCDAb1qEc0rSxpxEnf2kRpgizrMOjjgezBrw=;
 b=bsCoddHTAzBepYZkIq2wWv1xjgilQPal7ZE7s93UndYQuc/WvBelYQ9KUWZWLEcgXqH8agEASGoe3RZNDYyLSZtPJzPlPl8z+jdHkDwT41pK5WNMcqk6FkQID6glOEjQGL8EAkEZCBFPxSMkfRmpUR1sVdDwL7xAysIsaDNXWY275A6nolvt7LBYmZ/Dn8XgOIQf4tBIrGUEMntpQOVqwm8+1dkM5S9iGpVB1tEiUnmYRzRwBiv20qQyy4uN1p5MhZnJaxcN566UnWVU6eCa47VOPJdQlnCh8eT8231xD1aD/NiEu0Q5rdAkT2IIf7zt2hko6JK4pwG/tmqHxsR8yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcetKXWsCDAb1qEc0rSxpxEnf2kRpgizrMOjjgezBrw=;
 b=efH7o1+7ORJM9MWcR8mrhvNd/nrVHR/hDlaFBJeeKFWT5ZMMRtjmaO03vaebHWmw4W3rAYVB1+iiIVToS4wKTi4I8bWVrxjuveSgdG7Pg+MnbZIg7sJ9zOcyHuufdWVsTDRFD+5kvNAPOaYuJ1i54p9C1KKxSdu7WqOhEPwtn1xMgJ3otkM4uH6TheGDc8AtLgOYEaEePVi9GeoNZFjoWa3BtauC8g7MoMhRfBpty+bU3cdO1Oq6DwJQBZAfrLizYRSgY87ofXJqLVSQd6erHdG5EQ8mjRbettK1XzBe//ra4YbdkbgnhuM22WO9v1cxqDELJz4CsRVzQmaRwtJ9pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB9PR04MB8347.eurprd04.prod.outlook.com (2603:10a6:10:245::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Mon, 6 Apr
 2026 20:41:35 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 20:41:35 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Zefir Kurtisi <zefir.kurtisi@westermo.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net 2/6] net: enetc: linearize PTP event packets with one-step TX timestamping
Date: Mon,  6 Apr 2026 23:41:18 +0300
Message-ID: <20260406204122.167237-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260406204122.167237-1-vladimir.oltean@nxp.com>
References: <20260406204122.167237-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0042.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::14) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB9PR04MB8347:EE_
X-MS-Office365-Filtering-Correlation-Id: 08fd2c8a-b30f-4d47-ab5d-08de941ce4c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|10070799003|366016|7416014|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	0strcTsBktODMbFz6QbcOq8qQs9q2gup/GvkFEsSbjUJGooGMlnDzh5J3mhS4YkehbJuztap+zqQUZa3Mt1RQie+jsuwwHfEMvVguVQ+2+PAL2Gt55w5RvTbCQ27+7AY8AdsXyAMTOzWzrfaOlQ+8/igs9EkSEeFPFEuN89axU9nkO6PdIEiPdvQd59+7AwqJPTPBJdYzUPotILOYmwynOvEjG17cgb2whf0CTBnB1ROh8D6xze6fblYfbAGGOFVHVIKA6qLUezcUEcsXXvR/rpGZ1EuP+v/AzsyqDBrAV1iAxatpOon8arcFVWPx6Ryotb7WuH1OaBOQu/8nK0IEg+Kp2u6nFYxWTcwrvr/UBofEz/sV66x4zVqCLl6RMT/scI1DTntQHbzFqiBC0i8zpJVNoyj0A7hd5UaBd69qo/mIUfKVAik+3ZVnWjVMosyQkCgpdkLmmyQcBWHyMqToCVbT682UBMKLyZKpjw+YnSxTG0D25URuAU/lLlnxG9bQqVVfgHgO9PQbtBkFoN4cBKa7bYbSVOf98c93ZblAaAZBhW8ukXHBvS4sKFXOY6HJikhSbqKJWBhpvxYSOr5lTr9eDVeXIlUocSFjf4shAkTbvxfjwzCp+QMqh402+Q0E8/PlTFO95nJIFSzSk23ZjrWbWwHxtVXtm5LZJOfzpQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TtI+lojhYxl/qImdD11MgqgTOLN8cbsfdcourKG9Xh1DZj+8V2VMH1p+oAQA?=
 =?us-ascii?Q?AcfEQkdEjmhLVE/MggEHrZVYTc1ivYs68D6n1LFn8R5IIWktF1E97uHTy3ZV?=
 =?us-ascii?Q?2PIhmRGNZrL8if5jL5T5K20Pcu2rnSltKa0MWzpdnMR7FiD5Y0R5RXU1rGB3?=
 =?us-ascii?Q?WROfk1eWTq//+OBXdFW02c69pGkj8Es0DsnGbrylo4ctIzMAmt+elnOTPEyv?=
 =?us-ascii?Q?ZBiwMKv5tRi6haNKyzNzPvv4DMb+CIUvigLWbq/bsGfax5BDJkwC5iITQDXi?=
 =?us-ascii?Q?n0G87dszRBBj1ukRrfL1WAGwXb/x4PHA8ofq0EdtC+YV+ec8G+X+M7Vj/w8a?=
 =?us-ascii?Q?8XqWhyu01ys+SFHw/+22tNva0PedJkOOJV2k3GDzqlcexFoSu2buTZRuivTZ?=
 =?us-ascii?Q?EEMXlTyNUrJFpjH9Yn6JoTv9GS/OXnNULkOqVMXPfe5W4J5rOmyf20ytpqQ6?=
 =?us-ascii?Q?/wDFe16GJlNXgwsaF7ZgeC4Kskxj8tek+WVFcYwFSzAyE46PYOqQFwLhvfbc?=
 =?us-ascii?Q?8VHToncZwMh92bwKOVi1QadogXEQzzMKBb7sgPPRqDem60chZk29YBakxZ+l?=
 =?us-ascii?Q?R66+XSWkAWXc1lzFKk3RUno77j3sLtS+Jql+i9jgKU832VwnOPts/zhhI2dG?=
 =?us-ascii?Q?us45MhE5KIwfol5+uohCbrSvx1gQZ/JjxIMhamUmN2yvg5itO6w3KmgFURtC?=
 =?us-ascii?Q?n5pNwbLZA5VIHZ8UT5L1on7xOJ9u3LRkJQy1qzWS9k1h2Ws1sxEt4ujBlRup?=
 =?us-ascii?Q?n09lvHaRoyLlvi5vW8Y6xXXRIWfB0G/07yIxI2FcJIHaedj9/DqHyXBpio2R?=
 =?us-ascii?Q?6xSZdlU45GYVpxc0C+O4hEe7ZaOqeVvs6NjQWJMn3KVnAE5hkthsspCY8X4s?=
 =?us-ascii?Q?7Aaq0CfHjmmZlNPbGyYNe9jKK8rVZl4VF1jlwra0ZBS42I9VRTrY6o4derBS?=
 =?us-ascii?Q?HDIXA2e2KSPZ2rhMIqT6EZ0GOxx3/lZZDZtAzmTvAjawtB9uFBWkgPQnIaj9?=
 =?us-ascii?Q?AIyTWfPt6dgYkzx/1FV2yCuIXlUZKdzYolKKj6TD0S58emkfiDffv+4Pwx8L?=
 =?us-ascii?Q?4Mp11yroldMSLX3QUnhqKkOTaBxQOJFHmn19f/ewrVW98lURVckrAwKUlmJo?=
 =?us-ascii?Q?fXf0/U3TuKDVN61HRKFQkIUw5ZXGPOI8zgUUmjzElB4SUr9Cj6RF5WqkPkub?=
 =?us-ascii?Q?ZhIFYGYTTwutNWeuG6ORDkbPKsQ8QCrapoNmqH/VEVW7edyuV/y3rRdb2FKQ?=
 =?us-ascii?Q?KIIZVkqV74zli/kGu1b30WDhrNJ1gR9gsMuT3qtmytlqcgBxsQGLkpRTdZUL?=
 =?us-ascii?Q?K5UYLi0xosQVbLPpgMdeG1XTCpKk2F7M0xtEOicyVeN4m47oD9xz0b9rUrZT?=
 =?us-ascii?Q?CSOGNn8uh0vkiMO4oaDx0KDANFETT3GgLSpqZBt6s/ryjZiMrABXlWPyXfK1?=
 =?us-ascii?Q?Hc51h+JLo0MBQkC4FE7RDZ+VatC4NJ3WQIrc+6FnrSdpJnUp6Q+mgMlhB6XW?=
 =?us-ascii?Q?La67H1AsEh39INFPCq8GzNzHZgOZg9zrVjL5fef8+aLbz6JpR8Qr2r9DvKtr?=
 =?us-ascii?Q?T7ppzhOgZUbretxH94AU6o3w6DLfc5xFneJ7z5eV9YxBqmPnuQqXqTAx6MuJ?=
 =?us-ascii?Q?gaQHkDfEf/NlkQ9lIv6qiDpuLERp0nWO0zVpIa418aoUZXGOaQj7wR+yzMy4?=
 =?us-ascii?Q?xYKZLxFVaesbEkIuvejihJH8nDku3kLMYOyVZPMvlaL+zzAMYtdHMhCw3r0v?=
 =?us-ascii?Q?GSwrkGGHYfufrVEZwD9ncJI4T1KNX1R5CM1OGIjU6ToB7gMqRYGAFDeBMMAB?=
X-MS-Exchange-AntiSpam-MessageData-1: N1PX1+gOCIhLA9jRjtAxFfI4cfDjC+NqRtQ=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08fd2c8a-b30f-4d47-ab5d-08de941ce4c3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 20:41:35.2635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XUPttprYU9zMDbwnD8oBHMX4KaIKzGZXIeSR0sH07ZSH4Or/WZtTdSuQLQeBlpEkkS9HObsmSH5dZv0iNMVlMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8347
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[westermo.com,nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-275729-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: 324593A7471
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sashiko reports that enetc_ptp_parse() uses ptp_parse_header(), which
does not handle fragmented headers, and expects the entire area between
skb_mac_header() and the end of the PTP header to be linear.

When the driver fails to parse a fragmented PTP frame to find the
offsets to the originTimestamp and correctionField, it falls back to
two-step timestamping, which is technically not what user space asked
for, and it may not be prepared to receive the timestamped packet
through the socket error queue.

The problem can be avoided relatively easily by linearizing packets with
one-step timestamping requests prior to calling enetc_ptp_parse(). These
are infrequent enough that this should not be a performance problem.

Fixes: 7294380c5211 ("enetc: support PTP Sync packet one-step timestamping")
Link: https://sashiko.dev/#/patchset/20260401172246.1075883-1-vladimir.oltean%40nxp.com
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: patch is new
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index ece10a58d44e..ac6cad5605e4 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1059,6 +1059,11 @@ netdev_tx_t enetc_xmit(struct sk_buff *skb, struct net_device *ndev)
 
 	/* Fall back to two-step timestamp if not one-step Sync packet */
 	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
+		if (unlikely(skb_linearize(skb))) {
+			dev_kfree_skb_any(skb);
+			return NETDEV_TX_OK;
+		}
+
 		if (enetc_ptp_parse(skb, &udp, &msgtype, &twostep,
 				    &offset1, &offset2) ||
 		    msgtype != PTP_MSGTYPE_SYNC || twostep != 0) {
-- 
2.43.0


