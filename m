Return-Path: <netdev+bounces-302585-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ySGdGHhXQmpq5AkAu9opvQ
	(envelope-from <netdev+bounces-302585-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:31:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A94EF6D9734
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:31:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b="ATjD/KAz";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302585-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302585-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 866FD306DAA9
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 11:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C19402BB1;
	Mon, 29 Jun 2026 11:23:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010005.outbound.protection.outlook.com [52.101.69.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9C0402B8A;
	Mon, 29 Jun 2026 11:23:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782732234; cv=fail; b=GziAVkNFWfTpEGD6DeaDsXhpZyJ8QC+94AW9F6QrbMpWNMciqF7vUMUg8i2XUkEHNizlFxh+2kAZiOjK75Bg3luVu+csc9O/UzhQCCSUXaE/iQ4F2N10GFxO3EoG91no+HdueiCXJWw5OUvHgebRmGp8pF0GZcgqK4TgId+RiZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782732234; c=relaxed/simple;
	bh=CC2TlyD3WAB7qDmVa0YXGDGDr6kXf05HVioi0PvPaT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pQAwRZc4a8moDK/co4GvW6GuZp2Mutdg/Mc7f6vfbkhzaPxLaFbG4N8Z2fUj2pcTFEN8gv9uUC4q2x6zT6505fd8FdwwZ/YGvvvHZqcvm2ujlClV2e6ytXdXOWT+FVGFOL1UjnwrriIMdDcKQEaGfgYw07CQxu7oCSombb/VY6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ATjD/KAz; arc=fail smtp.client-ip=52.101.69.5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x1qpq1CgL5LsuJ3v8GKNfD+ekkDNk8z/gqFVkOzRMq9ohH95YPYpf+Ja0c/BsYDallNe017ob/pnvqqUYk3K9pz1YKpV97BhDTfCQy6tixVgschr53Pks43TJezzVv75InlLIr8slsqMOyN/7N4mfSr+5aCFC9vOOsu7X3JalF6VmZN5yW7slW7bVYfIiZDVKlAcKQ56/8RyyWdrKMML1uDzTYBfGjeUKyUB9cjPi7AVk3DDkRwax7FAVC19t4b9faCfrwt/mu8XY7kildI2/9kay4TwzqxAz+neBT362XhYZ/pqwqSLeChLrhVn3XfDP9RX7XAH/Oc9UqMLxJCN3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKKZJz9RIwulKnQi+3mj62rt4XyF9gx3Al/dGMZm+VI=;
 b=VaGwjLUX7N75cxkL4L+C3B32V0V1yet+uuj7lUArpLw8FxzFJ8HpzeUAstXkRZOJY8Vb38vTVrfh7O4HvlDNViLU8QJgpOfqvkFZI3VJjd0u0NRdUKOnyOKa2Gt615x5LpoaLCU+kjq2+o+jF+2qAluAzeHtiEpx74h8+I85OBuXEGP4Vbk5kM1XTFdt8wVbKZY9nwv9soYQtf/SfrLtSYMdcnCGSrb1f5Kt2PaInQyRsF640P+VPxdGe3eON7PLxRMML0aC5ztuxp/xVn7uUoQHuj6CIUZug1ayDhgEkffNEuXoYDdSvPoVjC4r8+ApJlj6kKdjaVbo256vBIfX1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKKZJz9RIwulKnQi+3mj62rt4XyF9gx3Al/dGMZm+VI=;
 b=ATjD/KAzRf/lx9Lju6HsYuS225+FXp9tcSERK95R8MzElNxFV9fnDOi8u6Qow2zWi94sQUjwlBMbnSk6pv8ZcVbdAjeZLXO6gENQBOJ7grNGS3WTj1pe4qFrfa0dgv7Hm35CtixTGpqtQvRG26sRwXeA8XtdqTg5tj/bypjh2LYU97XhPGoLhj6Y1YQq3fp61VLozpL+fIzMRYEOsDPG5PGWsZ2lK/996HtjQZXqTa/h7AJF9yEeKIvr9lwDR1l6vkMhQf2qgYrXAPkhaa0xp6aVwiTerXLlkad1bdFK4DAFxZvXkOO61WqUh+eB4Zdb3Be8nuEu3CNKvFpPAYimqw==
Received: from VI0PR04MB12302.eurprd04.prod.outlook.com (2603:10a6:800:31c::9)
 by AS8PR04MB8563.eurprd04.prod.outlook.com (2603:10a6:20b:422::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 11:23:48 +0000
Received: from VI0PR04MB12302.eurprd04.prod.outlook.com
 ([fe80::d68d:e9b6:88fa:9b5b]) by VI0PR04MB12302.eurprd04.prod.outlook.com
 ([fe80::d68d:e9b6:88fa:9b5b%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 11:23:48 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 11/13] dpaa2-switch: offload port objects on an upper bond device
Date: Mon, 29 Jun 2026 14:23:07 +0300
Message-Id: <20260629112309.154328-12-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629112309.154328-1-ioana.ciornei@nxp.com>
References: <20260629112309.154328-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0066.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::9) To VI0PR04MB12302.eurprd04.prod.outlook.com
 (2603:10a6:800:31c::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12302:EE_|AS8PR04MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: a9b29753-8e48-4e34-104b-08ded5d0e3a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|19092799006|1800799024|18002099003|22082099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	hcYAh5jhxYSpUE4JkaDBhXFz5+bKWxq0bXv8ySy0cVzNv4nKmTuuAV5xP8RmlQkgsJ5u3s4kdPaiNpb8XOtkVBc6lsXc+U45FSDKrcxRNcvS3qX8TjSU3zmfzGyoIHSlib0zXdMwvJT8ljjlVZYFemS6otsztXMWwFX3w9uItmPWp/kuYu5bp3lcWQykUNMS1MBZXkL7Cs5FFdYjVlzX6KQSwfQ/9HUaVK+kAiw8pZB8cx6bITPzabMmqSUqH6dbv3hvIJhsJWYyKLYRjAhoMURRxGihbi1VkY5O4m1EIkLIwyBD8GVlVPy9r0SjfBsGAAlDyCJ1TFt9dAfyimjg5WmbTWvIcEPU04zVRBPkyhrMIVt2vKAK76ktj44JSYE0H5LZYtzU2sq9zn1MniEx2sIF1MwnN86iaKfC/ndTo1E5gMAA1frbQh4My9XNX82r2BS0JWYGB/iO0dh3257gIzWBToipHwgkdrihpOt0d9Vp0GZMutzD97WO2vTY9ELi25BfuJwqznHKxb4gJM5BJKSPWq5RW8WGMZyYkQpGBNqyqFp/dV1GTE0dsC0aX3/Xn2P53C3FxpQZLK3EgqhJ2fARG/K8TGYyq88Ov6AA7iea/F8pNDX1f77QcTrE5NlALCK8FJVrSUVltncrYfRLaHIb8EpNEH1NSaY9JZvOV/k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12302.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(19092799006)(1800799024)(18002099003)(22082099003)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1oaLLGRc1t2T5nfFW3pTbFi3efKyRIRFXc27+R0IMt/hUZddMkUTTD/xSMxD?=
 =?us-ascii?Q?ku4Oo73Lr+yt88I/usBvcEMZgR72CY2ynziRDFaJbNpiBJP+zWSLL2J1q8Or?=
 =?us-ascii?Q?uZZpfSot8gz0x9g+oBsHeWJLfTbupg5r7YgDDzh/58wGdVzPK5DvN+87QETh?=
 =?us-ascii?Q?plwLoX4ITb14SIYg5jkiRYR5HmovHZsavS+D0EfNePsBz56VW/N31FRetAqv?=
 =?us-ascii?Q?jsFUZT9lb/lNzjxiyAZHGnlWrlimI9STIntURIATjtsZnzXYJIPDXWlq1pzl?=
 =?us-ascii?Q?AYJTX81t9+Fnr9PkI1nz0mnzAAb4z8PuEenf7oFwPoOw+bsV3tF57bEh0CuG?=
 =?us-ascii?Q?dPKjWh7aXK24gw6HFHvyGwTov+3+DIeASnT9BQgobMXDibXzOaHOnHjt0dQc?=
 =?us-ascii?Q?5QbJTfu4pDEduPsUaGgWSZ14jELgQT2AqDyFoLuWrM5EOx0XSytKDWAHD7lI?=
 =?us-ascii?Q?16l4JCV+6abN2akB6J6f9wJO/hcz1VA2X5YuS2ca5hOLpFvQloMm+czvqM/s?=
 =?us-ascii?Q?8glrDrAKACiIe5e8xoh8np9urF8XJPLwN9AgErfjINSg8KwMk78RUqQ9Jp0S?=
 =?us-ascii?Q?+qfQzh1i4xp5ZDVHQ4XdtbGnjMIIoOftOu13Yn6lZV3amHWb6VHF13FDFO3I?=
 =?us-ascii?Q?mkCwAzWOnnxjrhVdh7W560g43z0fW0f61g5UvCWR8uAzPRBHONo+kqn1BW5E?=
 =?us-ascii?Q?lsjg5UqZ9zVhMtcBcY9bZ/XNZr5xB1mheon8He4L4n7l8+cNeknBulCsiqzX?=
 =?us-ascii?Q?s3GCgKGeMpXUBfcFx4Et68ztF/EW4xPsWmuffewqh0aM+AgYdFNHbeV4me3A?=
 =?us-ascii?Q?BoNqGsh8+ZHcokMX6K/KQafiNbVjZdid7w8Lw6UjXVkylKl4TpyBZKHdX45l?=
 =?us-ascii?Q?kuA9jK/aDUxSbOu4d6dsrcuxjsa0jWoZhhsgYEKl1+aWQUEa3gSb6EIlbQ4n?=
 =?us-ascii?Q?uwrwD6ATs3oPnhZ9XP95JTAsK5SYRihuXhDQ1QAi1YqdnzQZ7bQc3U21nEWQ?=
 =?us-ascii?Q?rANqZQUT2L//6OpS+QxWxUBD7zA8Ou8QFCleQIYwkr23yHIF/nLrxx4ssk7E?=
 =?us-ascii?Q?JIAQNH8P/8STKayrHkcsD5lXouMwZoeopIwEUu5yyZQbzfQ7XjtBJkjAnBYi?=
 =?us-ascii?Q?SNm4cA/DvjWPLgHNqOUG3cLhQjyAqL1Ul257gjVdB2OsREN2v4X1Fx1S8KYg?=
 =?us-ascii?Q?AWCnTtjDpwHFlzGJHaW5RXMee3qGe/Z2r01Msm70vG23FAmSRixPRjtAHz5M?=
 =?us-ascii?Q?VTOnYBt7Co2ukbqEMPX3t8mmC9Op5sKEJ6rwiwS6c175uOfKjMlvp8kEIRzd?=
 =?us-ascii?Q?wx9iZ8EbO1hk3wGHrL+VFGtoOS+91MgN23Rpk/yl1sZpBAv8gYH/4BU05B8U?=
 =?us-ascii?Q?N1wQAc6FEB1MlcZuJ0OgQdvnfdq1U6mNIYXV17IEWySDYymM9G/oaiNRr86Z?=
 =?us-ascii?Q?6RSTAXdTW5bZcPYlkWREHb3MHbxgu/0R7Zl3jYBuvOn4vWh6HWQrFoiA9T/a?=
 =?us-ascii?Q?DxPuxSVmkzxvA//1obgfjNqgISTkPeTYOoKLIQM038DfmDV9J3CPqtL9MDvt?=
 =?us-ascii?Q?wIzBRMxJWeUg4lwkbeMwO24gXgJebC4eDH6mfNf1NLNbkEUkYK3RvbdGPJEq?=
 =?us-ascii?Q?faFdcM1w7raeiW7tutWHDoEO2hT12hXGL14wjLuZStVgLkW6926YhTMeQcVj?=
 =?us-ascii?Q?x0FvV19BDTbAuPXoTYZ2zhrw7q7vRPpuxOcz9c6eLplnOBfxKsqf7gYHEKjl?=
 =?us-ascii?Q?PMExn16Y8w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b29753-8e48-4e34-104b-08ded5d0e3a9
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12302.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 11:23:48.3374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HmpC+ooT3mX9rIoyB28vdYcktfI7OrfjDyW0VoDzurf3r3iy0TTrNv7/lWDMuINnRldvBxMuHOk9ZLfSyIykPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8563
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
	TAGGED_FROM(0.00)[bounces-302585-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nxp.com:dkim,nxp.com:email,nxp.com:mid,nxp.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A94EF6D9734

This patch adds support for offloading port objects, VLANs and MDBs,
added on upper bond devices.

First of all, the use of the switchdev_handle_*() replication helpers
is introduced for the SWITCHDEV_PORT_OBJ_ADD/SWITCHDEV_PORT_OBJ_DEL
events. With this change, setting up the 'port_obj_info->handled = true'
is not needed anymore since it's now handled by the new helpers.

In the DPAA2 architecture, there is no difference in adding a FDB or MDB
which points towards a LAG port. Unlike other architectures, we do not
need to populate all the possible destinations which are under the LAG,
we only have to specify a single queueing destination (QDID) which
represents the LAG. This all means that handling of MDBs in bond devices
needs to have refcount mechanism as with the FDBs.
This mechanism is triggered by calling the dpaa2_switch_lag_fdb_add() /
dpaa2_switch_lag_fdb_del() functions which were added in the previous
patch.

Also change how dpaa2_switch_port_mdb_del() behaves in case the
underlying HW operation failed. Since the delete operations cannot be
stopped from a switchdev standpoint, go ahead and ignore the return code
from the dpaa2_switch_*_fdb_del() calls.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v4:
- Updates necessary for the dev_mc_add/dev_mc_del removal

Changes in v3:
- Access the port_priv->lag field only through the proper rcu accessors.

Changes in v2:
- In case dev_mc_add() fails, remove the MDB address from HW with the
proper function, dpaa2_switch_lag_fdb_del() or
dpaa2_switch_port_fdb_del(), depending on the LAG offload state.
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 69 +++++++++++--------
 1 file changed, 41 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 307b3b7a1bfb..1f7875ecefe2 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -2017,15 +2017,28 @@ static int dpaa2_switch_port_mdb_add(struct net_device *netdev,
 				     const struct switchdev_obj_port_mdb *mdb)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	struct dpaa2_switch_lag *lag;
 
-	return dpaa2_switch_port_fdb_add(port_priv, mdb->addr);
+	lag = rtnl_dereference(port_priv->lag);
+	if (lag)
+		return dpaa2_switch_lag_fdb_add(lag, mdb->addr, mdb->vid);
+	else
+		return dpaa2_switch_port_fdb_add(port_priv, mdb->addr);
 }
 
-static int dpaa2_switch_port_obj_add(struct net_device *netdev,
-				     const struct switchdev_obj *obj)
+static int dpaa2_switch_port_obj_add(struct net_device *netdev, const void *ctx,
+				     const struct switchdev_obj *obj,
+				     struct netlink_ext_ack *extack)
 {
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 	int err;
 
+	if (ctx && ctx != port_priv)
+		return 0;
+
+	if (!dpaa2_switch_port_offloads_bridge_port(port_priv, obj->orig_dev))
+		return -EOPNOTSUPP;
+
 	switch (obj->id) {
 	case SWITCHDEV_OBJ_ID_PORT_VLAN:
 		err = dpaa2_switch_port_vlans_add(netdev,
@@ -2121,15 +2134,29 @@ static int dpaa2_switch_port_mdb_del(struct net_device *netdev,
 				     const struct switchdev_obj_port_mdb *mdb)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	struct dpaa2_switch_lag *lag;
+
+	lag = rtnl_dereference(port_priv->lag);
+	if (lag)
+		dpaa2_switch_lag_fdb_del(lag, mdb->addr, mdb->vid);
+	else
+		dpaa2_switch_port_fdb_del(port_priv, mdb->addr);
 
-	return dpaa2_switch_port_fdb_del(port_priv, mdb->addr);
+	return 0;
 }
 
-static int dpaa2_switch_port_obj_del(struct net_device *netdev,
+static int dpaa2_switch_port_obj_del(struct net_device *netdev, const void *ctx,
 				     const struct switchdev_obj *obj)
 {
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 	int err;
 
+	if (ctx && ctx != port_priv)
+		return 0;
+
+	if (!dpaa2_switch_port_offloads_bridge_port(port_priv, obj->orig_dev))
+		return -EOPNOTSUPP;
+
 	switch (obj->id) {
 	case SWITCHDEV_OBJ_ID_PORT_VLAN:
 		err = dpaa2_switch_port_vlans_del(netdev, SWITCHDEV_OBJ_PORT_VLAN(obj));
@@ -3032,37 +3059,23 @@ static int dpaa2_switch_port_event(struct notifier_block *nb,
 	}
 }
 
-static int dpaa2_switch_port_obj_event(unsigned long event,
-				       struct net_device *netdev,
-				       struct switchdev_notifier_port_obj_info *port_obj_info)
-{
-	int err = -EOPNOTSUPP;
-
-	if (!dpaa2_switch_port_dev_check(netdev))
-		return NOTIFY_DONE;
-
-	switch (event) {
-	case SWITCHDEV_PORT_OBJ_ADD:
-		err = dpaa2_switch_port_obj_add(netdev, port_obj_info->obj);
-		break;
-	case SWITCHDEV_PORT_OBJ_DEL:
-		err = dpaa2_switch_port_obj_del(netdev, port_obj_info->obj);
-		break;
-	}
-
-	port_obj_info->handled = true;
-	return notifier_from_errno(err);
-}
-
 static int dpaa2_switch_port_blocking_event(struct notifier_block *nb,
 					    unsigned long event, void *ptr)
 {
 	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
+	int err;
 
 	switch (event) {
 	case SWITCHDEV_PORT_OBJ_ADD:
+		err = switchdev_handle_port_obj_add(dev, ptr,
+						    dpaa2_switch_port_dev_check,
+						    dpaa2_switch_port_obj_add);
+		return notifier_from_errno(err);
 	case SWITCHDEV_PORT_OBJ_DEL:
-		return dpaa2_switch_port_obj_event(event, dev, ptr);
+		err = switchdev_handle_port_obj_del(dev, ptr,
+						    dpaa2_switch_port_dev_check,
+						    dpaa2_switch_port_obj_del);
+		return notifier_from_errno(err);
 	case SWITCHDEV_PORT_ATTR_SET:
 		return dpaa2_switch_port_attr_set_event(dev, ptr);
 	}
-- 
2.25.1


