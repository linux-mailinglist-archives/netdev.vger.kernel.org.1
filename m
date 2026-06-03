Return-Path: <netdev+bounces-294779-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qY2JODA/IGrHzAAAu9opvQ
	(envelope-from <netdev+bounces-294779-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:50:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D0958638C76
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:50:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=i8Lie75X;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294779-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-294779-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D99D030C17D6
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 14:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006D7399D0D;
	Wed,  3 Jun 2026 14:36:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013051.outbound.protection.outlook.com [52.101.83.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC1038C433;
	Wed,  3 Jun 2026 14:36:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497406; cv=fail; b=bhvVxTNTPPF3zrQA8rMwXPJE/b9jFBnQgkCif8bBnCq4b5qLYhmZJcGTSqL3xnV5ima1bSJebHKtVG9UA6tdleTPB4PXxH6u6pdbTluyGY+WWegPBX2Y2Fxg5QBtPdmVSRUzkWkZUlu5gEtPriqSHZDPXpd/8HDYkCDDTrxhKBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497406; c=relaxed/simple;
	bh=V9sgU+QA0FvwdPT4B/ICd7KB3r747pWYWwDg5ixxsMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dGZtgnjNnqFKHzRBXCoJN3Rh8udiMpMsE4sTy8MCTmZ5elyA9/b0RJW7ovhgvvdwpP4aG3XbqcVkGxZcdlq7uJk8HpjCRrS0AY4RhvYTO3fYuiW+SPbNl4f1rrY9KIAnw4e/0V14sN8PSmMy8fo8nRDqqmkMhhlRe3TZdCDvG00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i8Lie75X; arc=fail smtp.client-ip=52.101.83.51
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HmaBNS7CchxjkKOm3rp+W3GxdOLNO2fdKWZ7JWGyWWxKa2gp9My19dhrG6HesZVhjApdBHVec5OK1C6mwBvIbw+LV8POuayMub3lbfz5e5oDHnEu3X3tvCI2xI5S5qq4VzKb1VvenBEPhA/or3Ij9wpzul+AeYdMkD7tEPs5CGBg5pf6a/Wz3hwIVk9WqhumaNn7EbTzX7zqjBtS5CcZ34ydxIgz6XsgUvwuK2aTOO50Fduabpwv+cJXMwtlP9ywYDv/wjTUBYwryfSwKUFmDifq2r87+f84mGeVNU7GUnc2fZTwxu9b9cQx8jCOoxs3aXUfn+aI4t0IjlFPl3cqdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSxDMkDZtzredfuN+CElDHZURsXXgTz37lh3kaFK+uo=;
 b=cTdjgqUgitAFJjeUdlwQcduXjHnAMGsHXVp++5VgLNXN0cWu3WA6rBb01m+RFBIWwctKtoFnYYP6h82KPfeQsDgnM6YYB59y4V4L/MI/XnYOmDD+NfVBx/K5vvX0vPkAuw1LnEbM1VWAlBci1i0DvPtKOJGBk5nibvG8X+CsHQai7wW7t5O1+nr916byFdG0P0st0I1IAvxV6Q61tqe+jXEFMQGG6IN1cxli8K0hriioFJT7bRpDSPPG3YB7mGNubx9pLc3YT2dehpDjct9X+apdXWTDn4VAqAfc1NFeDghdUW9BQqc2t1N5D9AtPjCwfdOj5Tn3OTkTNnxHju1BjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSxDMkDZtzredfuN+CElDHZURsXXgTz37lh3kaFK+uo=;
 b=i8Lie75XQvceOL8C4tuYqj94404Cmub+57AYE8P9QiH7FRrL9HxK5XOcv1pU0nn2MtKLv8gswb3vvtbfVbsXdSuZIyTy3SnjUDezQs2/otTH1WwHtotcrhuSO3fqeEE3Nx5X8KTSkq/RNZl0u/7nJ2qyqlwygReQ98+PH3tEkgxlRMwHQHEIjsgmLr/CXhKP7NrCnMHummphBQ0DB4NJ1uWOEsQ5ZlNoJI44nSaLL0eU1muB6uwWqmfGe05795GoCKr2XxT0YPFTI97p47UFb+v1gh9KH1//+38F07Z4MvmW4WfGG6pt8n/kIk4jxs21Wn1zIewh9IJHH6MoxBVWYQ==
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by VI0PR04MB10615.eurprd04.prod.outlook.com
 (2603:10a6:800:26a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 14:36:41 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 14:36:41 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 02/12] dpaa2-switch: add support for LAG offload
Date: Wed,  3 Jun 2026 17:36:13 +0300
Message-Id: <20260603143623.3712024-3-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603143623.3712024-1-ioana.ciornei@nxp.com>
References: <20260603143623.3712024-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0443.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::17) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|VI0PR04MB10615:EE_
X-MS-Office365-Filtering-Correlation-Id: 05bcbae7-6e81-4a73-0bf8-08dec17d870d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|22082099003|18002099003|6133799003|3023799007|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	4yAberkxhoVtHbnGU7zS02+gQFurANPJRq93CVpH/OBnBqCO3fWGiRl4OAZHRLflf/cw68BN2wZkG/2auXZYO6D5PecaLVa7tQImb21Nk8C3Fbm+q6f0clbgiC2EQFBHzjqHBUvz+HDtCDzG1LFsM/ykS5hnib/ObuXLpRhaqP3UY3DPlfFS3lka7WTw0eOXUu4+dRr1ARDywdTV2jXyAkGYYcCuLRV/0q7NIAunsJSSBY7dw4Tvefhrs1sRwlViaC351O5oie6RqFTTcEbN2TUMs+sjixq6JSYX+rY5Owu6o/gPPiVVe5CrTG0VOi77uqKttnngtNRcamqaWujFKhpGEXCjweimWSyq7xY/B7PCDqmb6dmneH2cFDVxrNYvw6SsPDaiq207NGEGZd8oKyXTpU3yfnB6ig4EMW8rf40iz/mRCtE3Sy+vP2n+q5pAt+OYP7HHzsq6B3RWj7Xlq7ywP0YTbyf6M81ZPLNgs1f5d9bBZQUXKUtsYZkV0fyukOeiY/fnJeczN/MXsnayBZ8DYt9LYDs+XD7qaGWXQuVyZjEG+8ZSN/SdTP7VN9d0jG1u6e3AVBnuiiiVIGTEdNZxzbkwIRAf5s30hdiu67lG9yF1jRdbZ31i8cnDi9ucAB+3pmPtiPnBmezuajidYDTzhdTpAMF23WqnlH6a7SP6giFfkiiNGdjNiWk4UN+G
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(22082099003)(18002099003)(6133799003)(3023799007)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?edY2rfvnmvk9yi8x63+uzYAGpT1Qo+gr1kr1ks3/suGmWQTGRwLx6vu3BM6E?=
 =?us-ascii?Q?LIO+z6x2Truj80VKUi/cNCr4oE3QJLMi85ASut+hSc2lM8oRBe1qWa9szrYS?=
 =?us-ascii?Q?iXWwTdfVtmXnAd4inFsHBqN05Vtcz7swOSi7GviVXMGw/VbGYCcXnAvAC+22?=
 =?us-ascii?Q?8F5sQNw9dR/eXYfLmpqwWUs6Rt1hdbny2weKLTTjLSMEVGfoPU0aQjVBnYXi?=
 =?us-ascii?Q?DvTxzw8TeJtKkZp/h0GB+sfpw7OZ9mOJ+pXGMiEhO4gx+B+wNC0GpQXrUduZ?=
 =?us-ascii?Q?yUnF7e+6bGcrdKvmL1nRIjD5nl2s56qXNpbeTpNdN+GNkQXXK+KEzvxP9Ziw?=
 =?us-ascii?Q?VuO+M2WjLgPWAexE30Zk9Ls/ADqpvsh/KAs/DkiIRkIbVpVD7qAh8qU1a3dl?=
 =?us-ascii?Q?SeoYc+2eNIql3LPXSD2fRJg/VfNX7J4S/AVf7t4ioIxEka7LpxzLusJjbFdB?=
 =?us-ascii?Q?ADejhnnyGLYeWdshCkQxQKtpApEX3UdxxZDasO4ZOByPT3pGer1WZkRguqHx?=
 =?us-ascii?Q?Xn9El8zzPNXMCvnbFM/WmPafRfqOu5sA/fj1ZERSbcQLy+nhyTVfh1VpylAZ?=
 =?us-ascii?Q?9vrVvIZd4XH/LOFfi4wMSAAb4jHsLTOXYScCrq5GmqCcr08+tLS2dv0YkSFO?=
 =?us-ascii?Q?WOmLxFIUO4HQqB0Z9bvwlVchnhooUzbWUPkst8sCNvV0aJjKd3Kg0plBRfxk?=
 =?us-ascii?Q?Ie8H3AJKlgdTcwXV369attWZuGk/e1Uz1D88Mc0huIf168lrZq670kmGI1E6?=
 =?us-ascii?Q?7t9QG48j0/has9/N6KV6FcC9FmR0M6E3q8DV1iNQee02KytUbqsd328SJnt1?=
 =?us-ascii?Q?TKaQo4jJs9CDidApvKMepAbqczOUSOeeeaBx5M7XUG9RMCjXjjWaBIDgKTGN?=
 =?us-ascii?Q?fPZHYhWEazJ32KQvhRA8c+SQK6+MbI6prULMHnMviBqvA41xJWx1o2STRfAc?=
 =?us-ascii?Q?2QDMWZZmMQAJiXTnXpvbMUjp+dr+nY0nd9IqZ6gmi5DZKmt+dI5NUnAizFtb?=
 =?us-ascii?Q?GQS3zhHFvAnBBSzQA0ieBO9By9BpLErwUefzzTGSCQiMNYEmroOyQH3T6Wwj?=
 =?us-ascii?Q?jLcO+qCngBy8mDsG5NAXZctu13yOVuuqz9PKt8vHMZcu58z4PPGpxZydg+8c?=
 =?us-ascii?Q?7UWW/T9otfIQhTePJ4suVSMl6qVR8pEegz2OW6Iq3y9fCDAQGcsCVkwvj+Ic?=
 =?us-ascii?Q?9B9zknsUzpCf/hPgszwPjIBAR5Zd1/EuTMqGE41UuFQ9y8BodLQaCUoLb9vH?=
 =?us-ascii?Q?ta9EMp4aT/1cpmk9BQ3XpESQkF+iWbEf0DqTbuxgN2zO5ZC/nlXV1pnDykJo?=
 =?us-ascii?Q?i5qjBr3LPgqonnO33Ntwe3pePqn+LqF9RpPofWJOpaXWlF/Xf3irGxDMD4cC?=
 =?us-ascii?Q?oQnp3xRYJ/6/DTRLm08tkk6Q+5bdDyqxpf+XA0frDRQXT+CszRaHVYYWZ5l6?=
 =?us-ascii?Q?CKvctaeMpwaLk0kkr2qujKjoD+GAe+60zCAL1amoqTGupNDrEDWJ8Hh6Cc93?=
 =?us-ascii?Q?PhDOSzoUyJ2CA3HKqzdDBSw8twMpL1hNeQPWZvR2mSe4d/cJVZJwYiLRYW6w?=
 =?us-ascii?Q?/omWEA580lbh2/oLsdPr9u+GcSPRd910HvE4EBQ6ySPd4MW8NZnsl4e/TAGf?=
 =?us-ascii?Q?ZspgYpopJp7WpK5WtkrsZ14iMsqBJM/jj3nwwt++senoiQPUC1b4Y9Oa8ynI?=
 =?us-ascii?Q?xST49N8rKPRw0q4BvN/WvjRrhzEoSbwQgAkIN+R3lGExXjqYhZC8aUNihVl5?=
 =?us-ascii?Q?k4sDL2LwVQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05bcbae7-6e81-4a73-0bf8-08dec17d870d
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 14:36:41.5222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2u13O0qurv7rhhWrOHgVT3L6EC84xjSMjZb+6DmwJn1la6LqF59njgBTSx5jGgHwX0uSCaRRbYw73vsK5end1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10615
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-294779-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:mid,nxp.com:dkim,nxp.com:from_mime,nxp.com:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D0958638C76

This patch adds the bulk of the changes needed in order to support
offloading of an upper bond device.

First of all, handling of the NETDEV_CHANGEUPPER and
NETDEV_PRECHANGEUPPER events is extended so that the driver is capable
to handle joining or leaving an upper bond device.
All the restrictions around the LAG offload support are added in the
newly added dpaa2_switch_pre_lag_join() function.

The same events are extended to also detect if one of our upper bond
devices changes its own upper device. In this case, on each lower device
that is DPAA2 the corresponding dpaa2_switch_port_[pre]changeupper()
function will be called. This will start the process of joining the same
FDB as the one used by the bridge device.

Setting the 'offload_fwd_mark' field on the skbs is also extended to be
setup not only when the port is under a bridge but also under a bond
device that is offloaded.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v3:
- Fix logic in prechangeupper callback in order to not call
dpaa2_switch_prechangeupper_sanity_checks() on !info->linking
- Fixed up the logic in the dpaa2_switch_port_bond_join()'s error path
so that the FDBs are cleaned-up properly and we do not end-up with FDB's
leaked, meaning that they could have been marked as in-use but actually
no port was using it.
- Mark the port_priv->lag field as __rcu and use the proper accesors for
it. This will eventually become useful in a later patch when the lag
field will be accessed concurrently from the NAPI context and the
join/leave paths

Changes in v2:
- Extend dpaa2_switch_prechangeupper_sanity_checks() with
netdev_walk_all_lower_dev() so that checks are done on all lower devices
of a bridge, even for the lowers of a bridged bond.
- Manage better the default VLAN on bond join
- Clean-up the error path in dpaa2_switch_port_bond_join()
- Call dpaa2_switch_port_bridge_leave() in case a port is leaving a bond
which is also a bridged port
- Update dpaa2_switch_port_bond_leave() so that in case of any failure
the driver tries to cleanup the LAG offload configuration.
- Call switchdev_bridge_port_unoffload() in a switch port is leaving a
bridge bond device.
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 497 +++++++++++++++++-
 .../ethernet/freescale/dpaa2/dpaa2-switch.h   |  14 +-
 2 files changed, 504 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index a0bf5b50aae5..d082ecf9b125 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -51,6 +51,17 @@ dpaa2_switch_filter_block_get_unused(struct ethsw_core *ethsw)
 	return NULL;
 }
 
+static struct dpaa2_switch_lag *
+dpaa2_switch_lag_get_unused(struct ethsw_core *ethsw)
+{
+	int i;
+
+	for (i = 0; i < ethsw->sw_attr.num_ifs; i++)
+		if (!ethsw->lags[i].in_use)
+			return &ethsw->lags[i];
+	return NULL;
+}
+
 static u16 dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
 				     struct net_device *bridge_dev)
 {
@@ -2180,15 +2191,30 @@ static int dpaa2_switch_prevent_bridging_with_8021q_upper(struct net_device *net
 	return 0;
 }
 
+static int dpaa2_switch_check_dpsw_instance(struct net_device *dev,
+					    struct netdev_nested_priv *priv)
+{
+	struct ethsw_port_priv *port_priv = (struct ethsw_port_priv *)priv->data;
+	struct ethsw_port_priv *other_priv = netdev_priv(dev);
+
+	if (!dpaa2_switch_port_dev_check(dev))
+		return 0;
+
+	if (other_priv->ethsw_data == port_priv->ethsw_data)
+		return 0;
+
+	return 1;
+}
+
 static int
 dpaa2_switch_prechangeupper_sanity_checks(struct net_device *netdev,
 					  struct net_device *upper_dev,
 					  struct netlink_ext_ack *extack)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
-	struct ethsw_port_priv *other_port_priv;
-	struct net_device *other_dev;
-	struct list_head *iter;
+	struct netdev_nested_priv data = {
+		.data = (void *)port_priv,
+	};
 	int err;
 
 	if (!br_vlan_enabled(upper_dev)) {
@@ -2203,6 +2229,70 @@ dpaa2_switch_prechangeupper_sanity_checks(struct net_device *netdev,
 		return 0;
 	}
 
+	err = netdev_walk_all_lower_dev(upper_dev,
+					dpaa2_switch_check_dpsw_instance,
+					&data);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Interface from a different DPSW is in the bridge already");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int dpaa2_switch_pre_lag_join(struct net_device *netdev,
+				     struct net_device *upper_dev,
+				     struct netdev_lag_upper_info *info,
+				     struct netlink_ext_ack *extack)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
+	struct ethsw_port_priv *other_port_priv;
+	struct dpaa2_switch_lag *lag = NULL;
+	struct dpsw_lag_cfg cfg = {0};
+	struct net_device *other_dev;
+	int i, num_ifs = 0, err;
+	struct list_head *iter;
+
+	if (!(ethsw->features & ETHSW_FEATURE_LAG_OFFLOAD)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "LAG offload is supported only for DPSW >= v8.13");
+		return -EOPNOTSUPP;
+	}
+
+	if (info->tx_type != NETDEV_LAG_TX_TYPE_HASH) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Can only offload LAG using hash TX type");
+		return -EOPNOTSUPP;
+	}
+
+	if (info->hash_type != NETDEV_LAG_HASH_L23) {
+		NL_SET_ERR_MSG_MOD(extack, "Can only offload L2+L3 Tx hash");
+		return -EOPNOTSUPP;
+	}
+
+	if (!dpaa2_switch_port_has_mac(port_priv)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Only switch interfaces connected to MACs can be under a LAG");
+		return -EINVAL;
+	}
+
+	if (vlan_uses_dev(upper_dev)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot join a LAG upper that has a VLAN");
+		return -EOPNOTSUPP;
+	}
+
+	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
+		if (!ethsw->lags[i].in_use)
+			continue;
+		if (ethsw->lags[i].bond_dev != upper_dev)
+			continue;
+		lag = &ethsw->lags[i];
+		break;
+	}
+
 	netdev_for_each_lower_dev(upper_dev, other_dev, iter) {
 		if (!dpaa2_switch_port_dev_check(other_dev))
 			continue;
@@ -2210,19 +2300,275 @@ dpaa2_switch_prechangeupper_sanity_checks(struct net_device *netdev,
 		other_port_priv = netdev_priv(other_dev);
 		if (other_port_priv->ethsw_data != port_priv->ethsw_data) {
 			NL_SET_ERR_MSG_MOD(extack,
-					   "Interface from a different DPSW is in the bridge already");
+					   "Interface from a different DPSW is in the bond already");
+			return -EINVAL;
+		}
+
+		cfg.if_id[num_ifs++] = other_port_priv->idx;
+
+		if (num_ifs >= DPSW_MAX_LAG_IFS) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Cannot add more than 8 DPAA2 switch ports under the same bond");
 			return -EINVAL;
 		}
 	}
 
+	if (lag) {
+		cfg.group_id = lag->id;
+		cfg.if_id[num_ifs++] = port_priv->idx;
+		cfg.num_ifs = num_ifs;
+		cfg.phase = DPSW_LAG_SET_PHASE_CHECK;
+
+		err = dpsw_lag_set(ethsw->mc_io, 0, ethsw->dpsw_handle, &cfg);
+		if (err) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Cannot offload LAG configuration");
+			return -EOPNOTSUPP;
+		}
+	}
+
 	return 0;
 }
 
+static void dpaa2_switch_port_set_lag_group(struct ethsw_port_priv *port_priv,
+					    struct net_device *bond_dev)
+{
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
+	struct ethsw_port_priv *other_port_priv = NULL;
+	struct dpaa2_switch_lag *lag = NULL;
+	struct dpaa2_switch_lag *other_lag;
+	struct net_device *other_dev;
+	struct list_head *iter;
+
+	netdev_for_each_lower_dev(bond_dev, other_dev, iter) {
+		if (!dpaa2_switch_port_dev_check(other_dev))
+			continue;
+
+		other_port_priv = netdev_priv(other_dev);
+		other_lag = rtnl_dereference(other_port_priv->lag);
+		if (!other_lag)
+			continue;
+
+		if (other_lag->bond_dev == bond_dev) {
+			rcu_assign_pointer(port_priv->lag, other_lag);
+			return;
+		}
+	}
+
+	/* This is the first interface to be added under a bond device. Find an
+	 * unused LAG group. No need to check for NULL since there are the same
+	 * amount of DPSW ports as LAG groups, meaning that each port can have
+	 * its own LAG group.
+	 */
+	lag = dpaa2_switch_lag_get_unused(ethsw);
+	lag->in_use = true;
+	lag->bond_dev = bond_dev;
+	rcu_assign_pointer(port_priv->lag, lag);
+}
+
+static int dpaa2_switch_set_lag_cfg(struct net_device *bond_dev, u8 lag_id,
+				    struct ethsw_core *ethsw)
+{
+	struct dpaa2_switch_lag *lag = &ethsw->lags[lag_id - 1];
+	struct ethsw_port_priv *other_port_priv = NULL;
+	struct dpaa2_switch_lag *other_lag;
+	struct dpsw_lag_cfg cfg = {0};
+	u8 num_ifs = 0;
+	int i;
+
+	cfg.group_id = lag_id;
+	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
+		other_port_priv = ethsw->ports[i];
+
+		if (!other_port_priv)
+			continue;
+		other_lag = rtnl_dereference(other_port_priv->lag);
+		if (!other_lag)
+			continue;
+		if (other_lag->bond_dev != bond_dev)
+			continue;
+
+		/* No need to check against DPSW_MAX_LAG_IFS since this
+		 * was done in the prechangeupper stage. The flow will
+		 * not reach this point in case there are more DPAA2
+		 * switch ports under the same bond than we can accept.
+		 */
+		cfg.if_id[num_ifs++] = other_port_priv->idx;
+	}
+
+	cfg.num_ifs = num_ifs;
+
+	/* No more interfaces under this LAG group, mark it as not in use */
+	if (!num_ifs) {
+		/* We wait here for a grace-period so that we make sure any
+		 * readers of the lag structure finished.
+		 */
+		synchronize_net();
+
+		lag->bond_dev = NULL;
+		lag->in_use = false;
+	}
+
+	return dpsw_lag_set(ethsw->mc_io, 0, ethsw->dpsw_handle, &cfg);
+}
+
+static int dpaa2_switch_port_bond_join(struct net_device *netdev,
+				       struct net_device *bond_dev,
+				       struct netdev_lag_upper_info *info,
+				       struct netlink_ext_ack *extack)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
+	struct dpaa2_switch_fdb *old_fdb = port_priv->fdb;
+	struct dpaa2_switch_fdb *new_fdb;
+	struct net_device *bridge_dev;
+	struct dpaa2_switch_lag *lag;
+	int err = 0;
+	u8 lag_id;
+
+	/* Delete the default VLAN, we might change our FDB in this operation */
+	err = dpaa2_switch_port_del_vlan(port_priv, DEFAULT_VLAN_ID);
+	if (err)
+		return err;
+
+	/* Setup the egress flood policy (broadcast, unknown unicast) */
+	dpaa2_switch_port_set_fdb(port_priv, bond_dev);
+	err = dpaa2_switch_fdb_set_egress_flood(ethsw, port_priv->fdb->fdb_id);
+	if (err)
+		goto err_egress_flood;
+
+	/* Recreate the egress flood domain of the FDB that we just left. */
+	err = dpaa2_switch_fdb_set_egress_flood(ethsw, old_fdb->fdb_id);
+	if (err)
+		goto err_egress_flood;
+
+	/* Setup the port_priv->lag pointer for this switch port */
+	dpaa2_switch_port_set_lag_group(port_priv, bond_dev);
+
+	/* Create the LAG configuration and apply it in MC */
+	lag = rtnl_dereference(port_priv->lag);
+	lag_id = lag->id;
+	err = dpaa2_switch_set_lag_cfg(bond_dev, lag_id, ethsw);
+	if (err)
+		goto err_lag_cfg;
+
+	err = dpaa2_switch_port_add_vlan(port_priv, DEFAULT_VLAN_ID,
+					 BRIDGE_VLAN_INFO_UNTAGGED |
+					 BRIDGE_VLAN_INFO_PVID,
+					 false);
+	if (err)
+		goto err_vlan_add;
+
+	/* If the bond device is a switch port, join the bridge as well */
+	bridge_dev = netdev_master_upper_dev_get(bond_dev);
+	if (!bridge_dev || !netif_is_bridge_master(bridge_dev))
+		return 0;
+
+	err = dpaa2_switch_port_bridge_join(netdev, bridge_dev, extack);
+	if (err)
+		goto err_bridge_join;
+
+	return err;
+
+err_bridge_join:
+	dpaa2_switch_port_del_vlan(port_priv, DEFAULT_VLAN_ID);
+err_vlan_add:
+err_lag_cfg:
+	rcu_assign_pointer(port_priv->lag, NULL);
+	dpaa2_switch_set_lag_cfg(bond_dev, lag_id, ethsw);
+err_egress_flood:
+	if (port_priv->fdb != old_fdb) {
+		new_fdb = port_priv->fdb;
+
+		/* Explicitly move the port back into the old private FDB */
+		old_fdb->in_use = true;
+		old_fdb->bridge_dev = NULL;
+		port_priv->fdb = old_fdb;
+
+		/* Reprogram the bond FDB to no longer include this port */
+		dpaa2_switch_fdb_set_egress_flood(ethsw, new_fdb->fdb_id);
+	} else {
+		/* Same FDB means that this was the first port joining the
+		 * bond. Keep using the same FDB.
+		 */
+		old_fdb->bridge_dev = NULL;
+	}
+	/* Make sure that the egress flood of the FDB that we reverted to is as
+	 * it should be now, for a standalone port.
+	 */
+	dpaa2_switch_fdb_set_egress_flood(ethsw, port_priv->fdb->fdb_id);
+
+	dpaa2_switch_port_add_vlan(port_priv, DEFAULT_VLAN_ID,
+				   BRIDGE_VLAN_INFO_UNTAGGED |
+				   BRIDGE_VLAN_INFO_PVID,
+				   false);
+	return err;
+}
+
+static int dpaa2_switch_port_bond_leave(struct net_device *netdev,
+					struct net_device *bond_dev)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	struct dpaa2_switch_lag *lag = rtnl_dereference(port_priv->lag);
+	struct dpaa2_switch_fdb *old_fdb = port_priv->fdb;
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
+	struct net_device *bridge_dev;
+	int err = 0;
+
+	/* In case the bond is a bridge port, leave the upper bridge as well */
+	bridge_dev = netdev_master_upper_dev_get(bond_dev);
+	if (bridge_dev && netif_is_bridge_master(bridge_dev)) {
+		err = dpaa2_switch_port_bridge_leave(netdev);
+		if (err)
+			goto lag_cleanup;
+	}
+
+	/* Delete the default VLAN, we might change our FDB in this operation */
+	err = dpaa2_switch_port_del_vlan(port_priv, DEFAULT_VLAN_ID);
+	if (err)
+		goto lag_cleanup;
+
+	/* Setup the FDB for this port which is now standalone */
+	dpaa2_switch_port_set_fdb(port_priv, NULL);
+
+	/* Setup the egress flood policy (broadcast, unknown unicast).
+	 * When the port is not under a bond, only the CTRL interface is part
+	 * of the flooding domain besides the actual port.
+	 */
+	err = dpaa2_switch_fdb_set_egress_flood(ethsw, port_priv->fdb->fdb_id);
+	if (err)
+		goto lag_cleanup;
+
+	/* Recreate the egress flood domain of the FDB that we just left. */
+	err = dpaa2_switch_fdb_set_egress_flood(ethsw, old_fdb->fdb_id);
+	if (err)
+		goto lag_cleanup;
+
+	/* Add the VLAN 1 as PVID when not under a bond. We need this since
+	 * the dpaa2 switch interfaces are not capable to be VLAN unaware
+	 */
+	err = dpaa2_switch_port_add_vlan(port_priv, DEFAULT_VLAN_ID,
+					 BRIDGE_VLAN_INFO_UNTAGGED |
+					 BRIDGE_VLAN_INFO_PVID,
+					 false);
+	if (err)
+		goto lag_cleanup;
+
+lag_cleanup:
+	/* Recreate the LAG configuration for the LAG group that we left. In
+	 * case any step failed, at least we free up a LAG resource.
+	 */
+	rcu_assign_pointer(port_priv->lag, NULL);
+	dpaa2_switch_set_lag_cfg(bond_dev, lag->id, ethsw);
+
+	return err;
+}
+
 static int dpaa2_switch_port_prechangeupper(struct net_device *netdev,
 					    struct netdev_notifier_changeupper_info *info)
 {
+	struct net_device *upper_dev, *br;
 	struct netlink_ext_ack *extack;
-	struct net_device *upper_dev;
 	int err;
 
 	if (!dpaa2_switch_port_dev_check(netdev))
@@ -2239,6 +2585,24 @@ static int dpaa2_switch_port_prechangeupper(struct net_device *netdev,
 
 		if (!info->linking)
 			dpaa2_switch_port_pre_bridge_leave(netdev);
+	} else if (netif_is_lag_master(upper_dev)) {
+		if (!info->linking) {
+			if (netif_is_bridge_port(upper_dev))
+				dpaa2_switch_port_pre_bridge_leave(netdev);
+			return 0;
+		}
+
+		if (netif_is_bridge_port(upper_dev)) {
+			br = netdev_master_upper_dev_get(upper_dev);
+			err = dpaa2_switch_prechangeupper_sanity_checks(netdev,
+									br,
+									extack);
+			if (err)
+				return err;
+		}
+
+		return dpaa2_switch_pre_lag_join(netdev, upper_dev,
+						 info->upper_info, extack);
 	}
 
 	return 0;
@@ -2263,6 +2627,80 @@ static int dpaa2_switch_port_changeupper(struct net_device *netdev,
 							     extack);
 		else
 			return dpaa2_switch_port_bridge_leave(netdev);
+	} else if (netif_is_lag_master(upper_dev)) {
+		if (info->linking)
+			return dpaa2_switch_port_bond_join(netdev, upper_dev,
+							   info->upper_info,
+							   extack);
+		else
+			return dpaa2_switch_port_bond_leave(netdev, upper_dev);
+	}
+
+	return 0;
+}
+
+static int
+dpaa2_switch_lag_prechangeupper(struct net_device *netdev,
+				struct netdev_notifier_changeupper_info *info)
+{
+	struct net_device *lower;
+	struct list_head *iter;
+	int err = 0;
+
+	if (!netif_is_lag_master(netdev))
+		return 0;
+
+	netdev_for_each_lower_dev(netdev, lower, iter) {
+		if (!dpaa2_switch_port_dev_check(lower))
+			continue;
+
+		err = dpaa2_switch_port_prechangeupper(lower, info);
+		if (err)
+			return err;
+	}
+
+	return err;
+}
+
+static int
+dpaa2_switch_lag_changeupper(struct net_device *netdev,
+			     struct netdev_notifier_changeupper_info *info)
+{
+	struct net_device *lower;
+	struct list_head *iter;
+	int err = 0;
+
+	if (!netif_is_lag_master(netdev))
+		return 0;
+
+	netdev_for_each_lower_dev(netdev, lower, iter) {
+		if (!dpaa2_switch_port_dev_check(lower))
+			continue;
+
+		err = dpaa2_switch_port_changeupper(lower, info);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int
+dpaa2_switch_port_changelowerstate(struct net_device *netdev,
+				   struct netdev_lag_lower_state_info *linfo)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
+	int err;
+
+	if (!rtnl_dereference(port_priv->lag))
+		return 0;
+
+	err = dpsw_if_set_lag_state(ethsw->mc_io, 0, ethsw->dpsw_handle,
+				    port_priv->idx, linfo->tx_enabled ? 1 : 0);
+	if (err) {
+		netdev_err(netdev, "dpsw_if_set_lag_state() = %d\n", err);
+		return err;
 	}
 
 	return 0;
@@ -2272,6 +2710,7 @@ static int dpaa2_switch_port_netdevice_event(struct notifier_block *nb,
 					     unsigned long event, void *ptr)
 {
 	struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
+	struct netdev_notifier_changelowerstate_info *info;
 	int err = 0;
 
 	switch (event) {
@@ -2280,13 +2719,29 @@ static int dpaa2_switch_port_netdevice_event(struct notifier_block *nb,
 		if (err)
 			return notifier_from_errno(err);
 
+		err = dpaa2_switch_lag_prechangeupper(netdev, ptr);
+		if (err)
+			return notifier_from_errno(err);
+
 		break;
 	case NETDEV_CHANGEUPPER:
 		err = dpaa2_switch_port_changeupper(netdev, ptr);
 		if (err)
 			return notifier_from_errno(err);
 
+		err = dpaa2_switch_lag_changeupper(netdev, ptr);
+		if (err)
+			return notifier_from_errno(err);
+
 		break;
+	case NETDEV_CHANGELOWERSTATE:
+		info = ptr;
+		if (!dpaa2_switch_port_dev_check(netdev))
+			break;
+
+		err = dpaa2_switch_port_changelowerstate(netdev,
+							 info->lower_state_info);
+		return notifier_from_errno(err);
 	}
 
 	return NOTIFY_DONE;
@@ -2470,6 +2925,7 @@ static void dpaa2_switch_rx(struct dpaa2_switch_fq *fq,
 	dma_addr_t addr = dpaa2_fd_get_addr(fd);
 	struct ethsw_core *ethsw = fq->ethsw;
 	struct ethsw_port_priv *port_priv;
+	struct dpaa2_switch_lag *lag;
 	struct net_device *netdev;
 	struct vlan_ethhdr *hdr;
 	struct sk_buff *skb;
@@ -2521,11 +2977,20 @@ static void dpaa2_switch_rx(struct dpaa2_switch_fq *fq,
 		}
 	}
 
+	rcu_read_lock();
+
+	lag = rcu_dereference(port_priv->lag);
+
 	skb->dev = netdev;
 	skb->protocol = eth_type_trans(skb, skb->dev);
 
-	/* Setup the offload_fwd_mark only if the port is under a bridge */
+	/* Setup the offload_fwd_mark only if the port is under a bridge
+	 * or under a bond device that is offloaded.
+	 */
 	skb->offload_fwd_mark = !!(port_priv->fdb->bridge_dev);
+	skb->offload_fwd_mark |= !!(lag);
+
+	rcu_read_unlock();
 
 	netif_receive_skb(skb);
 
@@ -2541,6 +3006,9 @@ static void dpaa2_switch_detect_features(struct ethsw_core *ethsw)
 
 	if (ethsw->major > 8 || (ethsw->major == 8 && ethsw->minor >= 6))
 		ethsw->features |= ETHSW_FEATURE_MAC_ADDR;
+
+	if (ethsw->major > 8 || (ethsw->major == 8 && ethsw->minor >= 13))
+		ethsw->features |= ETHSW_FEATURE_LAG_OFFLOAD;
 }
 
 static int dpaa2_switch_setup_fqs(struct ethsw_core *ethsw)
@@ -3330,6 +3798,7 @@ static void dpaa2_switch_remove(struct fsl_mc_device *sw_dev)
 	kfree(ethsw->fdbs);
 	kfree(ethsw->filter_blocks);
 	kfree(ethsw->ports);
+	kfree(ethsw->lags);
 
 	dpaa2_switch_teardown(sw_dev);
 
@@ -3357,6 +3826,7 @@ static int dpaa2_switch_probe_port(struct ethsw_core *ethsw,
 	port_priv = netdev_priv(port_netdev);
 	port_priv->netdev = port_netdev;
 	port_priv->ethsw_data = ethsw;
+	rcu_assign_pointer(port_priv->lag, NULL);
 
 	mutex_init(&port_priv->mac_lock);
 
@@ -3464,6 +3934,19 @@ static int dpaa2_switch_probe(struct fsl_mc_device *sw_dev)
 		goto err_free_fdbs;
 	}
 
+	ethsw->lags = kcalloc(ethsw->sw_attr.num_ifs, sizeof(*ethsw->lags),
+			      GFP_KERNEL);
+	if (!ethsw->lags) {
+		err = -ENOMEM;
+		goto err_free_filter;
+	}
+	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
+		ethsw->lags[i].bond_dev = NULL;
+		ethsw->lags[i].ethsw = ethsw;
+		ethsw->lags[i].id = i + 1;
+		ethsw->lags[i].in_use = 0;
+	}
+
 	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
 		err = dpaa2_switch_probe_port(ethsw, i);
 		if (err)
@@ -3510,6 +3993,8 @@ static int dpaa2_switch_probe(struct fsl_mc_device *sw_dev)
 err_free_netdev:
 	for (i--; i >= 0; i--)
 		dpaa2_switch_remove_port(ethsw, i);
+	kfree(ethsw->lags);
+err_free_filter:
 	kfree(ethsw->filter_blocks);
 err_free_fdbs:
 	kfree(ethsw->fdbs);
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h
index 42b3ca73f55d..07301885763c 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h
@@ -41,7 +41,8 @@
 #define ETHSW_MAX_FRAME_LENGTH	(DPAA2_MFL - VLAN_ETH_HLEN - ETH_FCS_LEN)
 #define ETHSW_L2_MAX_FRM(mtu)	((mtu) + VLAN_ETH_HLEN + ETH_FCS_LEN)
 
-#define ETHSW_FEATURE_MAC_ADDR	BIT(0)
+#define ETHSW_FEATURE_MAC_ADDR		BIT(0)
+#define ETHSW_FEATURE_LAG_OFFLOAD	BIT(1)
 
 /* Number of receive queues (one RX and one TX_CONF) */
 #define DPAA2_SWITCH_RX_NUM_FQS	2
@@ -105,6 +106,13 @@ struct dpaa2_switch_fdb {
 	bool			in_use;
 };
 
+struct dpaa2_switch_lag {
+	struct ethsw_core	*ethsw;
+	struct net_device	*bond_dev;
+	bool			in_use;
+	u8			id;
+};
+
 struct dpaa2_switch_acl_entry {
 	struct list_head	list;
 	u16			prio;
@@ -163,6 +171,8 @@ struct ethsw_port_priv {
 	struct dpaa2_mac	*mac;
 	/* Protects against changes to port_priv->mac */
 	struct mutex		mac_lock;
+
+	struct dpaa2_switch_lag __rcu *lag;
 };
 
 /* Switch data */
@@ -190,6 +200,8 @@ struct ethsw_core {
 	struct dpaa2_switch_fdb		*fdbs;
 	struct dpaa2_switch_filter_block *filter_blocks;
 	u16				mirror_port;
+
+	struct dpaa2_switch_lag		*lags;
 };
 
 static inline int dpaa2_switch_get_index(struct ethsw_core *ethsw,
-- 
2.25.1


