Return-Path: <netdev+bounces-297720-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FzMANAKAKWr/XwMAu9opvQ
	(envelope-from <netdev+bounces-297720-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:17:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4693666A9F5
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:17:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=Ja6Mcw9z;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297720-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297720-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 139D7317D0D5
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643D3426698;
	Wed, 10 Jun 2026 15:09:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010071.outbound.protection.outlook.com [52.101.84.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0361A42669A;
	Wed, 10 Jun 2026 15:09:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104189; cv=fail; b=UgEsN5t3wyNmMOVm+U9AJ5r7hv0yaMXv1lxoYqimp9iEz3gjrqrF/3vB7UVVDhqKe6idiCyrUDP0zZ1fKTCKYXBcYOLj1KFyNe+FT+uBe1LByyHiAs8/+CwiBW9Y7oGqim8HkpUp8wnXiVkglp8wkzr7Ua7TC6Ua6WYfsJIczJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104189; c=relaxed/simple;
	bh=sUM/rt8gB7H01HghJQT97WE5ZZ38a1kMEKXizwtOllw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s5G66f4Ch+pPxCgssfwBNnIOe2+tUSnE3fy5AERg2Gako/CPWnN1dpRUF0P/7pMHXlfiVZRmcfe10RFyp3rtAkxhfE5JWSUPYHoBG36qBCfypmbgpBXpeTKm/Xx8zW5q3Xc9O0+Aa6JL0RiF4Fn1R6MwIwKS3aY2IsjYy9vIYwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ja6Mcw9z; arc=fail smtp.client-ip=52.101.84.71
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C+Bb4A+DgwBAChOjRMno9f+8gP6PT0vmlkakiQou4s/8StOxXj7bVr8ZBY5KPLCIBqblQRl8nWlGsHB9h6+dSjzopkBSjP3mRGO/QN6UMYhXxz0NZ6GtwCDTdQLo91ASXAZDepncuCo8x6tu1yzsHZYWhgPUlMNBNvepeM6MVUR/LSkg1N9JxM8CYX4cscWK4RrXHuytudavpnWn8LzHm2JoO+72y+lPjOYlnkj/51VjeH2s8nQH4lgxjg53LNgTywSllTUKdGuJWvJfU6DAdizJBgZZihjsa21BbPckj5ttkL2Zqcc6yL8OqRE8NL9wHZE4FAEf9TWBxN1N0bLo6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSiRb+4Efg45dxTZqKqDk+Fy4eAi77Qvlitwu6czWlM=;
 b=g4s35qAOpuKmLOYZZLbJnRilyNsSaxLF1GJ2ZVrp8ryCQfR7/P/E672/el57Y9yN05f5EDde/UQYHOQDPFyg2DUrIH32S1unUvxTs9gFSmwAeZP7VDvKsRqOM5m4PcXb1A1FluyGxAEd4YeNhHq8DlLT6yH/X49caJt6UyeJKsSwy44t48W8APjYNUOjY7lHnM3MAqpNl9Up2m+UWesUT1Yg8RJ9U2l3c7gWdARR/T/CbIymGHETz1w1NegAtF5Twua5Y6kWCNZiW7+Q5z0IIiThO7B0MthXyq9L9W8bLiHuSL1ByZDIjklhI/ON9V0hriUx1t4GAYmew+aZfVFWEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSiRb+4Efg45dxTZqKqDk+Fy4eAi77Qvlitwu6czWlM=;
 b=Ja6Mcw9zTFHKvpeNhfpgGqdWgk2Ee10gZY2+jqbg8JpUsdj9Lg2T8Bxdb0r+ZCUhGyi2SGjoRjo18es2FQhBidpTFO4CcuirqP6vfoQGmTWlw8/Jq8oBrwS0lc8sMtLhxrOR9YzYnae/FBBEw7mEeguFEbCE5a9eNsfbK0M/0WVOxxP2oiQzjOByxWCCc3FhfDMu0MLRDkxf3aUpxdn8s+KqK/QSUyxOczRNsyYDcD9osK4/AdL5uOg0OwTwYAz2xZCRGzHgyyfZUZAKCGFwNsv9rDwPupQ5CnNCcyuztnswDg6poBtTxo6WCJCFO2kYbW45VEGJ460JAlSfAWJ5zA==
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by VI0PR04MB12113.eurprd04.prod.outlook.com
 (2603:10a6:800:314::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Wed, 10 Jun
 2026 15:09:40 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 15:09:40 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/5] dpaa2-switch: move FDB selection for join path into a helper
Date: Wed, 10 Jun 2026 18:09:10 +0300
Message-Id: <20260610150912.1788482-4-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610150912.1788482-1-ioana.ciornei@nxp.com>
References: <20260610150912.1788482-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::16)
 To GVXPR04MB12290.eurprd04.prod.outlook.com (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|VI0PR04MB12113:EE_
X-MS-Office365-Filtering-Correlation-Id: beb7ee82-bf8c-4949-f97f-08dec7024b61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|23010399003|376014|11063799006|3023799007|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	q+4/oWD4f7A3JRwC9tfmIIk0Kpra+8VRc9qV43KNe2QQ4jHxdaILb3QJaSv91uTlLD1E8+tq1QnRryntoHjsMAYpiRB7rPkiwC+pZC538nArr5Wn+MOsvTZLg8QoWQS7waCjoj+p22v5BG121qOiWCYZBxvFXlgNb2R8vQGRJq3Jdu2beDfh228wj2cB70MXx+Ro9oQZ8VAWXIyULJZCJK6TjLbbqQMLCfP8O/DhHlkqLkxnZnZh6WMwe08EB5IKDuH2ZLp4jrA0nu7elUl9+v4vPaYkbl9FX/8BjnMgY+Tnle5Nit+5/T202JZEFSfEBs5G4LbF4qQSLQcfit8AprbtSR22xU2cApq0CG9lL+XoX1oPXgVqNq0XRXXKUJeq/VNSGbM7dRZLD7dRasGZ9Fp5/j2a4h5XgKTyMuIfAxtjQsHGXxeMDDbFD57G9e0DYlWz03ETinyJnl/TOJK0mkDgqjSJpuJkH8Sbsu0O8YtewM3A8RGGozDCZkUCEn+hVhkiwEk7bCeh/ScGI8WKxLvePQZBLpsMKE9mU6ceE/1CsrWQ/s7MKwa++nGmVKVpDwLcpLcqrMKuGd4c8diyR7tB6bbkX1lIE5som92y5Ric5FdF8LTvwkVr5+EaXJAfUe0dOWPVxhF7xT+ns9xgpqQupAFWGkpayC9PuzJL3oKJLmu0Gv5Ba9Z8Ht/7K7eD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(23010399003)(376014)(11063799006)(3023799007)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3ZnGyPt8LJfrc2JeyCRiBlTWluiKF6QGV/6xUJK+4wt35XnUnZ4XghwT87Kr?=
 =?us-ascii?Q?MVrmt7KfmG/b2H1uL7Gc2ddaSUPOHT1eF2aAK/5H+eOp7Wj1Ch/LJpc/QpDP?=
 =?us-ascii?Q?w0q7EpcCDukU82VuRJN7We74+JtffPDrsG45JTrNWa739rFW5JgD3yRZqA7x?=
 =?us-ascii?Q?EAqBB0JEeDSaX+8+uovP36dxJU4xyK0zrpYI6AbX8FMPUQ7xyoKOvcN3HqlL?=
 =?us-ascii?Q?OEqYOFHx4R090EPEPuhSvktduxO1ww3qASho/vjMptM3r4x+enTU7a4qQOTU?=
 =?us-ascii?Q?tHf0rgoOl++gzxFx0icuERgA9QlGQugejuYOuYzriPiwdKljw3C9N9DAmZvh?=
 =?us-ascii?Q?PS1HzmpL2VBa5NSN/xQVoYfFWMb8UNVHXpR4BG8BpxH99Ue4KxmI0aTZpYO9?=
 =?us-ascii?Q?2/l2HscqLOtj99n7cDNaI8ucACKU4nJWvEkacMGFWuLRT06s1dV7OFefQxzh?=
 =?us-ascii?Q?qry5AWSJKJyCQxfa8Gz9NdWRghrUrsUX9vupMCvFMUyKXrn6j7ayQYgJVHD1?=
 =?us-ascii?Q?mvpO3V8XCJh53l6c+LR2WL4S5gQV8LVUCV4mpxsA8lkElO+nvHk8AxhgVKTb?=
 =?us-ascii?Q?iDb3IJQS8YpEQ7w6PdM30gdbz5XbinwgMeLt1wyMbHfaJd/YYRdd+waB96I5?=
 =?us-ascii?Q?3fnxu+5WSphI9zRc9RWNV0wnOArJbBJ5Lr086OObxH2WeLL6R//5SmTRP57q?=
 =?us-ascii?Q?+zrkz+Tg99rw4LD4HucbNPqLnXPq00k5XL7xWrwlSkdfgRYACRYRSI/HQqHR?=
 =?us-ascii?Q?3yfi3BRv/tHz+N6SWU2ZI2BO3I3e6g3kzdHGEueTibFN+sTkaaJbFyAhxVp2?=
 =?us-ascii?Q?korrNTRge7Jalhfeo1zIewfhqXkhnkzvtK3tQrycMUsg+lkUscv41GGLI4Hk?=
 =?us-ascii?Q?yJ8cobz2QuK1k9yu3rs6fCALyRgnNUbtS7DY8d+uY4sIJyDMQAG2FbyNAiWe?=
 =?us-ascii?Q?IDToKQ4ULSlqleUTbhg507kMfPVB1gzKmOTomU84c5Ca8/I1IXJ9xyhm8zno?=
 =?us-ascii?Q?i0q9rLb0hZNKwJL0Y5xG2SMk1RGuGKxPuNRqAbnjCz2JbYzRF1PDTRtY79XA?=
 =?us-ascii?Q?RKZnakjge8ga/BgffC78u0SWjxdlst3w+sy2D6PJTsJgEt/qc7Kd6MN0SU15?=
 =?us-ascii?Q?uSV60ga5zBjpOh8c8q1MeG0Nm6+e4LLugSdpl+m2ZenzmWkcVvHSzwQRNVTO?=
 =?us-ascii?Q?yRBtHDpHlJl+gZMVNqwDKYe4bTseErCY/X0KlaXyHh0MFnhz5DDSlEvg+Oxj?=
 =?us-ascii?Q?9eZBUC19+CaMIg6snvqSIp7UI/axYwH60sDaJlNEf7XTVN5b957By8RQ/gFE?=
 =?us-ascii?Q?aFQ2gXOsxw/dR3cDSIquvihiLgD0EW2t9G7Q2MfPs7cPYUYfwiuzPcjkD8va?=
 =?us-ascii?Q?DelVOsFMdl9VO/olZsa84//CTVRSUMPJTaIE6iU1I/3W900Cj0a6qGdampOU?=
 =?us-ascii?Q?C50bL/hPbVtUe/tHccJVOV4TctW8WOYq72E1UzPd5we6yCTnxMh3+ecryGEz?=
 =?us-ascii?Q?tI+W/BBx/TdCZRUQQ1eyKZ5Wgop6Zlur0t+yXQ3mljmfLkRGIj6R91Krhjl5?=
 =?us-ascii?Q?NbJBbHqkEyFxyJjJc2D+5e8kdNKpUH0grtr0+BgySezLi/T0HxSJ6aPJtPaT?=
 =?us-ascii?Q?gtXRfJrYY7ClaFubyQetzWWEhoE5elJdVj1p7aHLR1v/UUJnas9Z5SQQ/gUd?=
 =?us-ascii?Q?pomSYLQMQ+DUPfSFlQFjxWoAhkI8CIzaEd5k1rCbV8SXYZ84ycuo77Zety89?=
 =?us-ascii?Q?NNgR9OuZ/Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beb7ee82-bf8c-4949-f97f-08dec7024b61
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 15:09:40.2949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epMM1cZ+alm0Ee795bQ95WQl/0XHjVOIUBxH5Lh3CHawq5oSxMWnSE8mpVbFPGOZ5SDT/eLNEOfClkBFk/PEyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12113
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297720-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,nxp.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4693666A9F5

The dpaa2_switch_port_set_fdb() function handles the setup of the FDB
for both changeupper cases: join and leave. Move the code block which
handles the join path into a new helper - dpaa2_switch_fdb_for_join() -
with the hope that the entire function will become easier to read and
extend with other use cases in the future.

This new helper just determines and returns what FDB should be used for
a specific port, the cleanup of the old FDB and the actual setup in the
per port structure remains in the dpaa2_switch_port_set_fdb() function.

No changes in the actual behavior are intended.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 60 +++++++++++--------
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 3052a1c63c2d..158d0f510eae 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -67,15 +67,43 @@ static bool dpaa2_switch_fdb_in_use_by_others(struct ethsw_core *ethsw,
 	return false;
 }
 
+static struct dpaa2_switch_fdb *
+dpaa2_switch_fdb_for_join(struct ethsw_port_priv *port_priv,
+			  struct net_device *upper_dev)
+{
+	struct ethsw_port_priv *other_port_priv;
+	struct net_device *other_dev;
+	struct list_head *iter;
+
+	/* The below call to netdev_for_each_lower_dev() demands the RTNL lock
+	 * being held. Assert on it so that it's easier to catch new code
+	 * paths that reach this point without the RTNL lock.
+	 */
+	ASSERT_RTNL();
+
+	/* If part of a bridge, use the FDB of the first dpaa2 switch interface
+	 * to be present in that bridge
+	 */
+	netdev_for_each_lower_dev(upper_dev, other_dev, iter) {
+		if (!dpaa2_switch_port_dev_check(other_dev))
+			continue;
+
+		if (other_dev == port_priv->netdev)
+			continue;
+
+		other_port_priv = netdev_priv(other_dev);
+		return other_port_priv->fdb;
+	}
+
+	return port_priv->fdb;
+}
+
 static void dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
 				      struct net_device *upper_dev,
 				      bool linking)
 {
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
-	struct ethsw_port_priv *other_port_priv = NULL;
-	struct dpaa2_switch_fdb *fdb;
-	struct net_device *other_dev;
-	struct list_head *iter;
+	struct dpaa2_switch_fdb *new_fdb, *fdb;
 
 	/* If we leave a bridge, find an unused FDB and use that. */
 	if (!linking) {
@@ -102,30 +130,12 @@ static void dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
 		return;
 	}
 
-	/* The below call to netdev_for_each_lower_dev() demands the RTNL lock
-	 * being held. Assert on it so that it's easier to catch new code
-	 * paths that reach this point without the RTNL lock.
-	 */
-	ASSERT_RTNL();
-
-	/* If part of a bridge, use the FDB of the first dpaa2 switch interface
-	 * to be present in that bridge
-	 */
-	netdev_for_each_lower_dev(upper_dev, other_dev, iter) {
-		if (!dpaa2_switch_port_dev_check(other_dev))
-			continue;
-
-		if (other_dev == port_priv->netdev)
-			continue;
-
-		other_port_priv = netdev_priv(other_dev);
-		break;
-	}
+	new_fdb = dpaa2_switch_fdb_for_join(port_priv, upper_dev);
 
 	/* The current port is about to change its FDB to the one used by the
 	 * first port that joined the bridge.
 	 */
-	if (other_port_priv) {
+	if (port_priv->fdb != new_fdb) {
 		/* The previous FDB is about to become unused, since the
 		 * interface is no longer standalone.
 		 */
@@ -133,7 +143,7 @@ static void dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
 		port_priv->fdb->bridge_dev = NULL;
 
 		/* Get a reference to the new FDB */
-		port_priv->fdb = other_port_priv->fdb;
+		port_priv->fdb = new_fdb;
 	}
 
 	/* Keep track of the new upper bridge device */
-- 
2.25.1


