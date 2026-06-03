Return-Path: <netdev+bounces-294786-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i8RoB45AIGoozQAAu9opvQ
	(envelope-from <netdev+bounces-294786-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:56:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1D7638D7F
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:56:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=h3n45XQB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294786-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294786-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A575C3399B12
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 14:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515973D903E;
	Wed,  3 Jun 2026 14:37:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013036.outbound.protection.outlook.com [40.107.162.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517E93D8915;
	Wed,  3 Jun 2026 14:37:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497425; cv=fail; b=rlwF2NKUZqrMkijy2fWPkzxxzMAHUdVwS1XCC1heNF2m+iM8z289IVLnLxSNW3XC4HVVFU3inpepXfW5wJ+jBDvt5v0A+Yw0eXquGGcpeSyABZYFOwSckBF+XqWUroSr7qbp7F9vjX5Z6hDRzabwft0qmj4rxR6V73MuYGfVbBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497425; c=relaxed/simple;
	bh=rfIcY6DkHQhqXoDS+SBz2ZmSBGXtx7PnmWitKUOvaog=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GhmuzxFtkDRSZQVsfPzj/mh/VfDu1Mlyn1d+XCzbb0kbfXSsths2Ly9BAC/brfo7xHMg++T0YHLazt/ZhZecDO3umma2udNpYOdydwwyXCIabAdmAO71IT/C0qT84nnmBZIijbne7IpZaAATKHizvVFEpka3Z0VrahJH8o3ov+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=h3n45XQB; arc=fail smtp.client-ip=40.107.162.36
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXKn4MlHczAZyUBVb3UvHgq/OMJdEgdfc30dq5vjgvv7SJHhS/pwwM0BK270gG+haqbWy/Ow4Iu8gZaiqKlvK32X+HQxo/HuyXmJwnGeN4yy/Rx8ydherJrFOPmyYSpQ/fU2EbNSRb6ZfQeYn9th9etaGWOIL07T8qzDybfYL/kaS2GGcjSquV0CnLzQ2BpLFjio6Mt28uGFp7vs/+anILFKqWbWoGdcN51SMJZAqNu9eP3kNm/3jELY7pTkY0SlqOHbgchH6WBfma1gRJwdDKdJDKqJnQwu+U5H5C5dw6uvDDyoNKw0oi+UayUWo4Tf6d8XgQfTvMXK8luad+SrLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JbSVVDGkqFaxe3SvUUTWVxUrqDFVnQO+7WR8zPWKyCA=;
 b=UNW5d3KR+InABOAOAc36ChDfoMoGlT8fPB4G8ohjf2Frr5LRH35pODcQMHvxMU+WIqVy3ndPqeaK1Z74LtCCSMy1mspO/2LMu8miq4WulU6sr+47aLukAXJwn1hOASnecMP4NPdRja5Av11dJ2a4Xdl+Uuynb9TwNSVp3eRpa49xC5M3+EDvVJ64OCAF2XTE4PrHeTvXYwmbFRY/F8i7aXohJUxUTl+pOVu9A/0XYzqtWnQBvMiupOR3/N9U0DB5jvMBpvrZ0U9ZJYWpdPxQ9t/F97tPZI63UbysyLUi7LqXGJNxFIHNb9hZLK8OVgLh2ZtdkWLdUc/KbSyeEWWtFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbSVVDGkqFaxe3SvUUTWVxUrqDFVnQO+7WR8zPWKyCA=;
 b=h3n45XQBbJ0yQiyIwbHEHX7zpIg7HBVRLYJ/+3SyDLd0V2H0R57xgPmi+87UblqbmTpsDAKiUoUAmH9OFvjulxPxYteqCtYg1UFJ9jAykdMx3Ilu9kekf+OYWqOCEm2hJ71dZvxL9iuOGTMh6WsWqgqw0brHr6AZ5Oo18fjczS/xNFI11uGXJeCg/3WKKVtGlg4nPZ7J8aJM8UnYNpv/sAVH0LcYKy/l2gboVJTNGNq9ejcxbGxRNIyTGc4Ko1Ixis+cenZ62Lo+lG04tcf+lwwA7xnpxVN3kU9uLb5emBMhXoCIBYRu6AtrRfJCkkeN6jR8QHu3simkozYCmPW+WQ==
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by VI0PR04MB10615.eurprd04.prod.outlook.com
 (2603:10a6:800:26a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 14:37:00 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 14:37:00 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 09/12] dpaa2-switch: offload FDBs added on an upper bond device
Date: Wed,  3 Jun 2026 17:36:20 +0300
Message-Id: <20260603143623.3712024-10-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603143623.3712024-1-ioana.ciornei@nxp.com>
References: <20260603143623.3712024-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0301.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::13) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|VI0PR04MB10615:EE_
X-MS-Office365-Filtering-Correlation-Id: 70f9e7e4-6f02-4a15-f120-08dec17d9244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|22082099003|18002099003|6133799003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	I0jp3Mwarsy5TnJCWqi9wj2wMieXFI+XOT6z6imFiZ93IctFRCI16+eW50WvlEDrxqbEu4zx7pgPBWQqE6bBMp9i9HgZPNJfNunuczC5ose8FWdOjl6pm1Dn2cdFypqJGHwl3sZTHbaRRJm/8Njxn3iddtJUrKy233xK/nxLIkZ6Vn0WPh/omEybMEncLLb/PcCJcMVHvkia/h70P5Y9vZHIX526mB6BkTEsYttqamqkRHjilMIODB8KPu/VtG/bTFLqx80odEyxX2vr7vxvbak82pXHX0oOkMPCeKYppu3vWgxevmX4w7N+aFUqK1iwA8utdXhQ70tTirFTV6TtnnygebWLN27FhF1mkPrSmeVN6mu9IRmtzyqs1JKTgltAhklI9U3HSu0ZHBZP5LWHsqkKN5SNWUmAGfTUtzx4/UBbz1GAQAZ0tPgkwWGNM9XIrh5OYWQMCK6DOzODI3Yv8Zoq2fpNIhyKc5l2xNm89k7aSEiHiktD7r+sKkJnbSH+n3Y3MlsAP5rhiDJXM/mVTMIIZMX2fla3fHp/P1D+0U0Y9jvXHVoZ1YxHZokSJY9z3eMdy2obkNa3sZNXOAc4nqnDEXM7gKJTn9eV7beOI+B5CTqu2tAvH493Hd0sxJseToRiqbacL25GXNfNMiA2dqMFVOgxzYYA7XgDidUKqjLeanhQOZdTTTCvFNj1SoAE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oKQMGEMEqSa8pw4pvdrd+3mDuF2ECZ6eGl2+wdzGsTa1NyRT0VKxnXCPrR0B?=
 =?us-ascii?Q?DvfAcDruYv7cmV/Br77mze5pUEC8zyFFJsS3faW/klWeJ5YzU2JB/cDsHTP7?=
 =?us-ascii?Q?BNRTtVMqKahLCWT0NphgVFIZfUpLwQ6rcwapSBmexJ2mQaFdV8js6dSGw2TG?=
 =?us-ascii?Q?gQbl1/eHNjOQJXO6zx+TFPFTdO9bTms8vYdfyh2jf/2zYTP2VDOIAg98KatD?=
 =?us-ascii?Q?fg2TKHcyd2YnHECoH8nypuAp2ElpFH6V563j7Zx37X5j7Sy4yvj2p0+DdFbE?=
 =?us-ascii?Q?1L4c1mpxmWco6Nh5kDAxsjp7k0WUTGk2c50SEo+ekP2RrIpciv6wcC7pnh9b?=
 =?us-ascii?Q?WuhchAzJCQXTQkUHgTqnKamBPTGtX0zJtl3mp8Ve2rGGKvGGeJPwXLFqMT2J?=
 =?us-ascii?Q?PfufidE3aQx2Sjv6SH/4IpNFWlqb6rCq4AydNZeR3Vi48IFWUr6O8smXCBFh?=
 =?us-ascii?Q?TdvutFQhS4S/se44FQHbniU0KmSi+bQzfqkV0Hl074j0P4QKdQha6ASu2DGf?=
 =?us-ascii?Q?NE7+/Yu1GjaJfOlai7uL+b4qkH25Dq+MWFil1N/jwN0BySoS3xDSmuq76g4B?=
 =?us-ascii?Q?n7UNoQf+xq2d8Yt2PhGOqWPfTAvcuJP2qCZ7QyilxU5AE0Wp1pG6lApEMRCu?=
 =?us-ascii?Q?NUsUFwHN3wIz65z0uaW9Dmup/C6s6qJJ9iwNA45zCZ9NN3VnoEwvUnN6HI8a?=
 =?us-ascii?Q?pLEQT9ma9SXmFl6e5WO0ALgiGxiMZhTveHoagOGD0RjFhTI87q61xhSjH/Bc?=
 =?us-ascii?Q?Ad1cltcB8VTntJQ0Br7g6kuhE522DN2egu7Y2wjZRA/vtnfwILfAqrDUzVY0?=
 =?us-ascii?Q?GlAqG5RS3FQoXNk4PCCg4/21KSX6tdt/LvEOY5oQRHiK5JSI4w4T9XcenokI?=
 =?us-ascii?Q?JYziHoHd6nUa+Z6VK+p7yrZ77YnIzKUEQftIaxF/njh9cm/puATcNqahPqlt?=
 =?us-ascii?Q?seepqD17ydXtiL1uzNGamMooa01TbO+UCIkJLJoG3pmChK07fA1TEcFBaHvx?=
 =?us-ascii?Q?rFy5dLbT2n374iqLbP12UJBoC3GWvg/qX2JYPB3rxMA3kUSRlE3tJ3AgnFyT?=
 =?us-ascii?Q?HVLkBR1j+ISASJXOFY3ner75Gal9VdO+VYtAkZ9x9BRhyHDJ/RxR34IzVPp3?=
 =?us-ascii?Q?t/gwPUAOP58fRWcC1qGq1ll5izIvaTtWxlxSQfyU/USZpuu6rQS11rFU+nOo?=
 =?us-ascii?Q?1P1xxGIRb37kI39MmHEb+yqf1x5kOQtn9MBtdtKTvF84C2UCbV8WVXTY2Daz?=
 =?us-ascii?Q?w/InJNTvJctji/tmST8cxVwcOMer/6BSZMoajIVZpBm7T3tHr/v6fHgiNtCP?=
 =?us-ascii?Q?XtlRWAwAoL+G2M1P6CtbzJCd8TDsttk34af673egD4Vk+McfMc8/vWw/J2BE?=
 =?us-ascii?Q?xPffCqkCvC8C45GbenCD8JE77c6aZavu+/F8as0WO5f2R8no7diY+G37Y3z3?=
 =?us-ascii?Q?Pv6eTu9bEVQ4TaAylwUgHFYeJ49tFe5WeKmQdL8lF/Bd+eot7bLiQ+4jNi0W?=
 =?us-ascii?Q?tEZy1Sj14GQb6wNeqzUHFijeRk8DBrIW/sNi+yNsGpTjMNVQtGkfrlENdwjs?=
 =?us-ascii?Q?b2IodJGckUd9YS7DeJwp4NJtHZxXo//DK3F1J1AQnqdG2jI1+uay2enxdkRf?=
 =?us-ascii?Q?c7kt5AKlcdexxRl7uZEDZuzQhnM/y5cOuaL9iqR2fqvbnS6pr4vocmb7aDtz?=
 =?us-ascii?Q?W7B1PPGbv4NwbX83RB5N7POBdC6hWviKUnsTDVe6NQsKJpaKbtDSvipHFNP3?=
 =?us-ascii?Q?Z3RC74/S7Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f9e7e4-6f02-4a15-f120-08dec17d9244
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 14:37:00.3409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RaweVcDYQfYGeT8hqWpqfpG3mUxdx5v6Kot/iUkqiY9g0bl/w+lN8zJSnZ3GhD7cUtVqywYDtvZQRJaYiiTKlw==
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
	TAGGED_FROM(0.00)[bounces-294786-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 6C1D7638D7F

This patch adds support for offloading FDB entries added on upper bond
devices.

First of all, the call to switchdev_bridge_port_offload() is updated so
that the notifier blocks needed for FDB events replay are available to
the bridge core.

Using switchdev_handle_*() helpers is also necessary because each FDB
event needs to be fanned out to any DPAA2 switch lower device. This
triggers another change in the return type used by the
dpaa2_switch_port_fdb_event() - from notifier types to regular errno
types.

Handling of the SWITCHDEV_FDB_ADD_TO_DEVICE/SWITCHDEV_FDB_DEL_TO_DEVICE
events is updated so that the newly dpaa2_switch_lag_fdb_add() /
dpaa2_switch_lag_fdb_del() functions are called anytime a port is under
a bond device. This will allow us to manage refcounting on FDB entries
which are added on the upper bond devices.

The DPAA2 switch uses shared-VLAN learning which means that the vid
parameter is not used when adding an FDB entry to HW. The current
behavior when dealing with FDB entries with the same MAC address but
different VLANs is to add the entry to HW every time while removal will
get done on the first 'bridge fdb del' command issued by the user.

The same behavior is kept also for FDBs added on bond devices by keeping
the refcount on the {vid, addr} pair while the HW operation disregards
entirely the vid parameter.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v3:
- Update dpaa2_switch_foreign_dev_check() so that we check if there is
any port in the same switch as dev which offloads foreign_dev in case
this is a bridge port.
- Add mutex_destroy on the per LAG fdb_lock
- Make sure that all FDB events were processed on the workqueue on the
.remove() path.
- Delete the refcounted entry in dpaa2_switch_lag_fdb_del() as soon as
possible, even if the HW deletion would fail
- Access the port_priv->lag field only through the proper rcu accessors.

Changes in v2:
- Update dpaa2_switch_foreign_dev_check() so that we check if between
the switch port and the foreign net_device is an offloaded path. Before
this change we also checked if the foreign_dev was offloaded or not by
the switch port.
- Update the switchdev_bridge_port_unoffload() by passing it the proper
context and the notifier blocks.
- Add dev_hold() and dev_put() calls for orig_dev
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 222 ++++++++++++++++--
 .../ethernet/freescale/dpaa2/dpaa2-switch.h   |  24 ++
 2 files changed, 223 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index fb754dae8069..fadebf6a758d 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -25,6 +25,9 @@
 
 #define DEFAULT_VLAN_ID			1
 
+static struct notifier_block dpaa2_switch_port_switchdev_nb;
+static struct notifier_block dpaa2_switch_port_switchdev_blocking_nb;
+
 static u16 dpaa2_switch_port_get_fdb_id(struct ethsw_port_priv *port_priv)
 {
 	return port_priv->fdb->fdb_id;
@@ -62,6 +65,27 @@ dpaa2_switch_lag_get_unused(struct ethsw_core *ethsw)
 	return NULL;
 }
 
+static struct ethsw_port_priv *
+dpaa2_switch_lag_get_primary(struct dpaa2_switch_lag *lag)
+{
+	struct ethsw_core *ethsw = lag->ethsw;
+	struct ethsw_port_priv *port_priv;
+	struct dpaa2_switch_lag *port_lag;
+	int i;
+
+	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
+		port_priv = ethsw->ports[i];
+		if (!port_priv)
+			continue;
+
+		port_lag = rtnl_dereference(port_priv->lag);
+		if (port_lag == lag)
+			return port_priv;
+	}
+
+	return NULL;
+}
+
 static void dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
 				      struct net_device *upper_dev,
 				      bool linking)
@@ -616,6 +640,91 @@ static int dpaa2_switch_port_fdb_del(struct ethsw_port_priv *port_priv,
 		return dpaa2_switch_port_fdb_del_mc(port_priv, addr);
 }
 
+static struct dpaa2_mac_addr *
+dpaa2_switch_mac_addr_find(struct list_head *addr_list,
+			   const unsigned char *addr, u16 vid)
+{
+	struct dpaa2_mac_addr *a;
+
+	list_for_each_entry(a, addr_list, list)
+		if (ether_addr_equal(a->addr, addr) && a->vid == vid)
+			return a;
+
+	return NULL;
+}
+
+static int dpaa2_switch_lag_fdb_add(struct dpaa2_switch_lag *lag,
+				    const unsigned char *addr, u16 vid)
+{
+	struct ethsw_port_priv *port_priv;
+	struct dpaa2_mac_addr *a;
+	int err = 0;
+
+	mutex_lock(&lag->fdb_lock);
+
+	a = dpaa2_switch_mac_addr_find(&lag->fdbs, addr, vid);
+	if (a) {
+		refcount_inc(&a->refcount);
+		goto out;
+	}
+
+	port_priv = dpaa2_switch_lag_get_primary(lag);
+	if (!port_priv) {
+		err = -ENOENT;
+		goto out;
+	}
+
+	a = kzalloc(sizeof(*a), GFP_KERNEL);
+	if (!a) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	err = dpaa2_switch_port_fdb_add(port_priv, addr);
+	if (err) {
+		kfree(a);
+		goto out;
+	}
+
+	ether_addr_copy(a->addr, addr);
+	a->vid = vid;
+	refcount_set(&a->refcount, 1);
+	list_add_tail(&a->list, &lag->fdbs);
+
+out:
+	mutex_unlock(&lag->fdb_lock);
+
+	return err;
+}
+
+static void dpaa2_switch_lag_fdb_del(struct dpaa2_switch_lag *lag,
+				     const unsigned char *addr, u16 vid)
+{
+	struct ethsw_port_priv *port_priv;
+	struct dpaa2_mac_addr *a;
+
+	mutex_lock(&lag->fdb_lock);
+
+	a = dpaa2_switch_mac_addr_find(&lag->fdbs, addr, vid);
+	if (!a)
+		goto out;
+
+	if (!refcount_dec_and_test(&a->refcount))
+		goto out;
+
+	list_del(&a->list);
+	kfree(a);
+
+	port_priv = dpaa2_switch_lag_get_primary(lag);
+	if (!port_priv)
+		goto out;
+
+	dpaa2_switch_port_fdb_del(port_priv, addr);
+
+out:
+	mutex_unlock(&lag->fdb_lock);
+}
+
 static void dpaa2_switch_port_get_stats(struct net_device *netdev,
 					struct rtnl_link_stats64 *stats)
 {
@@ -1564,6 +1673,33 @@ bool dpaa2_switch_port_dev_check(const struct net_device *netdev)
 	return netdev->netdev_ops == &dpaa2_switch_port_ops;
 }
 
+static bool dpaa2_switch_foreign_dev_check(const struct net_device *dev,
+					   const struct net_device *foreign_dev)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(dev);
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
+	struct ethsw_port_priv *other_port;
+	int i;
+
+	if (netif_is_bridge_master(foreign_dev))
+		if (port_priv->fdb->bridge_dev == foreign_dev)
+			return false;
+
+	if (netif_is_bridge_port(foreign_dev)) {
+		for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
+			other_port = ethsw->ports[i];
+
+			if (!other_port)
+				continue;
+			if (dpaa2_switch_port_offloads_bridge_port(other_port,
+								   foreign_dev))
+				return false;
+		}
+	}
+
+	return true;
+}
+
 static int dpaa2_switch_port_connect_mac(struct ethsw_port_priv *port_priv)
 {
 	struct fsl_mc_device *dpsw_port_dev, *dpmac_dev;
@@ -2177,8 +2313,10 @@ static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
 		goto err_egress_flood;
 
 	brport_dev = dpaa2_switch_port_to_bridge_port(port_priv);
-	err = switchdev_bridge_port_offload(brport_dev, netdev, NULL,
-					    NULL, NULL, false, extack);
+	err = switchdev_bridge_port_offload(brport_dev, netdev, port_priv,
+					    &dpaa2_switch_port_switchdev_nb,
+					    &dpaa2_switch_port_switchdev_blocking_nb,
+					    false, extack);
 	if (err)
 		goto err_switchdev_offload;
 
@@ -2219,7 +2357,9 @@ static void dpaa2_switch_port_pre_bridge_leave(struct net_device *netdev)
 	if (!brport_dev)
 		return;
 
-	switchdev_bridge_port_unoffload(brport_dev, NULL, NULL, NULL);
+	switchdev_bridge_port_unoffload(brport_dev, port_priv,
+					&dpaa2_switch_port_switchdev_nb,
+					&dpaa2_switch_port_switchdev_blocking_nb);
 }
 
 static int dpaa2_switch_port_bridge_leave(struct net_device *netdev)
@@ -2856,32 +2996,46 @@ struct ethsw_switchdev_event_work {
 	struct work_struct work;
 	struct switchdev_notifier_fdb_info fdb_info;
 	struct net_device *dev;
+	struct net_device *orig_dev;
 	unsigned long event;
+	u16 vid;
 };
 
 static void dpaa2_switch_event_work(struct work_struct *work)
 {
 	struct ethsw_switchdev_event_work *switchdev_work =
 		container_of(work, struct ethsw_switchdev_event_work, work);
+	struct net_device *orig_dev = switchdev_work->orig_dev;
 	struct net_device *dev = switchdev_work->dev;
+	struct ethsw_port_priv *port_priv = netdev_priv(dev);
 	struct switchdev_notifier_fdb_info *fdb_info;
+	struct dpaa2_switch_lag *lag;
 	int err;
 
 	rtnl_lock();
 	fdb_info = &switchdev_work->fdb_info;
+	lag = rtnl_dereference(port_priv->lag);
 
 	switch (switchdev_work->event) {
 	case SWITCHDEV_FDB_ADD_TO_DEVICE:
-		err = dpaa2_switch_port_fdb_add(netdev_priv(dev),
-						fdb_info->addr);
+		if (lag)
+			err = dpaa2_switch_lag_fdb_add(lag, fdb_info->addr,
+						       switchdev_work->vid);
+		else
+			err = dpaa2_switch_port_fdb_add(netdev_priv(dev),
+							fdb_info->addr);
 		if (err)
 			break;
 		fdb_info->offloaded = true;
-		call_switchdev_notifiers(SWITCHDEV_FDB_OFFLOADED, dev,
+		call_switchdev_notifiers(SWITCHDEV_FDB_OFFLOADED, orig_dev,
 					 &fdb_info->info, NULL);
 		break;
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
-		dpaa2_switch_port_fdb_del(netdev_priv(dev), fdb_info->addr);
+		if (lag)
+			dpaa2_switch_lag_fdb_del(lag, fdb_info->addr,
+						 switchdev_work->vid);
+		else
+			dpaa2_switch_port_fdb_del(port_priv, fdb_info->addr);
 		break;
 	}
 
@@ -2889,36 +3043,43 @@ static void dpaa2_switch_event_work(struct work_struct *work)
 	kfree(switchdev_work->fdb_info.addr);
 	kfree(switchdev_work);
 	dev_put(dev);
+	dev_put(orig_dev);
 }
 
-static int dpaa2_switch_port_fdb_event(struct notifier_block *nb,
-				       unsigned long event, void *ptr)
+static int
+dpaa2_switch_port_fdb_event(struct net_device *dev,
+			    struct net_device *orig_dev,
+			    unsigned long event, const void *ctx,
+			    const struct switchdev_notifier_fdb_info *fdb_info)
 {
-	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
 	struct ethsw_port_priv *port_priv = netdev_priv(dev);
 	struct ethsw_switchdev_event_work *switchdev_work;
-	struct switchdev_notifier_fdb_info *fdb_info = ptr;
-	struct ethsw_core *ethsw;
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
 
-	if (!dpaa2_switch_port_dev_check(dev))
-		return NOTIFY_DONE;
-	ethsw = port_priv->ethsw_data;
+	if (ctx && ctx != port_priv)
+		return 0;
+
+	/* For the moment, do nothing with entries towards foreign devices */
+	if (dpaa2_switch_foreign_dev_check(dev, orig_dev))
+		return 0;
 
 	if (!fdb_info->added_by_user || fdb_info->is_local)
-		return NOTIFY_DONE;
+		return 0;
 
 	switchdev_work = kzalloc_obj(*switchdev_work, GFP_ATOMIC);
 	if (!switchdev_work)
-		return NOTIFY_BAD;
+		return -ENOMEM;
 
 	INIT_WORK(&switchdev_work->work, dpaa2_switch_event_work);
 	switchdev_work->dev = dev;
 	switchdev_work->event = event;
+	switchdev_work->orig_dev = orig_dev;
+	switchdev_work->vid = fdb_info->vid;
 
 	switch (event) {
 	case SWITCHDEV_FDB_ADD_TO_DEVICE:
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
-		memcpy(&switchdev_work->fdb_info, ptr,
+		memcpy(&switchdev_work->fdb_info, fdb_info,
 		       sizeof(switchdev_work->fdb_info));
 		switchdev_work->fdb_info.addr = kzalloc(ETH_ALEN, GFP_ATOMIC);
 		if (!switchdev_work->fdb_info.addr)
@@ -2929,19 +3090,20 @@ static int dpaa2_switch_port_fdb_event(struct notifier_block *nb,
 
 		/* Take a reference on the device to avoid being freed. */
 		dev_hold(dev);
+		dev_hold(orig_dev);
 		break;
 	default:
 		kfree(switchdev_work);
-		return NOTIFY_DONE;
+		return 0;
 	}
 
 	queue_work(ethsw->workqueue, &switchdev_work->work);
 
-	return NOTIFY_DONE;
+	return 0;
 
 err_addr_alloc:
 	kfree(switchdev_work);
-	return NOTIFY_BAD;
+	return -ENOMEM;
 }
 
 /* Called under rcu_read_lock() */
@@ -2949,13 +3111,18 @@ static int dpaa2_switch_port_event(struct notifier_block *nb,
 				   unsigned long event, void *ptr)
 {
 	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
+	int err;
 
 	switch (event) {
 	case SWITCHDEV_PORT_ATTR_SET:
 		return dpaa2_switch_port_attr_set_event(dev, ptr);
 	case SWITCHDEV_FDB_ADD_TO_DEVICE:
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
-		return dpaa2_switch_port_fdb_event(nb, event, ptr);
+		err = switchdev_handle_fdb_event_to_device(dev, event, ptr,
+							   dpaa2_switch_port_dev_check,
+							   dpaa2_switch_foreign_dev_check,
+							   dpaa2_switch_port_fdb_event);
+		return notifier_from_errno(err);
 	default:
 		return NOTIFY_DONE;
 	}
@@ -3890,6 +4057,9 @@ static void dpaa2_switch_remove(struct fsl_mc_device *sw_dev)
 	dev = &sw_dev->dev;
 	ethsw = dev_get_drvdata(dev);
 
+	/* Make sure that all events were handled before we kfree anything */
+	flush_workqueue(ethsw->workqueue);
+
 	dpaa2_switch_teardown_irqs(sw_dev);
 
 	dpsw_disable(ethsw->mc_io, 0, ethsw->dpsw_handle);
@@ -3903,8 +4073,10 @@ static void dpaa2_switch_remove(struct fsl_mc_device *sw_dev)
 	for (i = 0; i < DPAA2_SWITCH_RX_NUM_FQS; i++)
 		netif_napi_del(&ethsw->fq[i].napi);
 
-	for (i = 0; i < ethsw->sw_attr.num_ifs; i++)
+	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
 		dpaa2_switch_remove_port(ethsw, i);
+		mutex_destroy(&ethsw->lags[i].fdb_lock);
+	}
 
 	kfree(ethsw->fdbs);
 	kfree(ethsw->filter_blocks);
@@ -4056,6 +4228,8 @@ static int dpaa2_switch_probe(struct fsl_mc_device *sw_dev)
 		ethsw->lags[i].ethsw = ethsw;
 		ethsw->lags[i].id = i + 1;
 		ethsw->lags[i].in_use = 0;
+		mutex_init(&ethsw->lags[i].fdb_lock);
+		INIT_LIST_HEAD(&ethsw->lags[i].fdbs);
 	}
 
 	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
@@ -4104,6 +4278,8 @@ static int dpaa2_switch_probe(struct fsl_mc_device *sw_dev)
 err_free_netdev:
 	for (i--; i >= 0; i--)
 		dpaa2_switch_remove_port(ethsw, i);
+	for (i = 0; i < ethsw->sw_attr.num_ifs; i++)
+		mutex_destroy(&ethsw->lags[i].fdb_lock);
 	kfree(ethsw->lags);
 err_free_filter:
 	kfree(ethsw->filter_blocks);
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h
index 07301885763c..106cc9d7f0ec 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h
@@ -100,6 +100,13 @@ struct dpaa2_switch_fq {
 	u32 fqid;
 };
 
+struct dpaa2_mac_addr {
+	unsigned char addr[ETH_ALEN];
+	u16 vid;
+	refcount_t refcount;
+	struct list_head list;
+};
+
 struct dpaa2_switch_fdb {
 	struct net_device	*bridge_dev;
 	u16			fdb_id;
@@ -111,6 +118,9 @@ struct dpaa2_switch_lag {
 	struct net_device	*bond_dev;
 	bool			in_use;
 	u8			id;
+	/* Protects the list of fdbs installed on this LAG */
+	struct mutex		fdb_lock;
+	struct list_head	fdbs;
 };
 
 struct dpaa2_switch_acl_entry {
@@ -286,4 +296,18 @@ int dpaa2_switch_block_offload_mirror(struct dpaa2_switch_filter_block *block,
 
 int dpaa2_switch_block_unoffload_mirror(struct dpaa2_switch_filter_block *block,
 					struct ethsw_port_priv *port_priv);
+
+static inline bool
+dpaa2_switch_port_offloads_bridge_port(struct ethsw_port_priv *port_priv,
+				       const struct net_device *dev)
+{
+	struct dpaa2_switch_lag *lag = rcu_dereference_rtnl(port_priv->lag);
+
+	if (lag && lag->bond_dev == dev)
+		return true;
+	if (port_priv->netdev == dev)
+		return true;
+	return false;
+}
+
 #endif	/* __ETHSW_H */
-- 
2.25.1


