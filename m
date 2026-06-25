Return-Path: <netdev+bounces-301910-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xz8ZCpPzPGqfuwgAu9opvQ
	(envelope-from <netdev+bounces-301910-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 11:23:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B30796C42F1
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 11:23:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=est.tech header.s=selector1 header.b=CLzjlDf8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301910-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301910-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C7ED3011E8B
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 09:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB4F37F731;
	Thu, 25 Jun 2026 09:23:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011026.outbound.protection.outlook.com [52.101.70.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF69381B0F;
	Thu, 25 Jun 2026 09:23:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782379409; cv=fail; b=nGQuzdU6vLrV+ojKrBl+9Wne4IjZmQSp8B6bYyICi3598H/arQKjumWXaXj50W9WPitDYBGV3uzYIu2wdNUKyEIZIliBJ0o+cocqDJArLxVFpHhiyeiJUbcdbXbssJ9TjBHjntwgZo8y8vSmNGr8CfZM1/r97yd286l16B8Qt9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782379409; c=relaxed/simple;
	bh=glxu+DbGG+MjOG2+ZtYMFw4a7Cw+M9Rj109T0ojUgpc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qRw7aNdMJUIj/Iv1TZCygc4R9WiMJG5YWG1PdQr6GVgWjWlPhZw3/qWoGKGYve/wqO9lPZ5mncUJYeIrd+uCHyO4gK3Ipij44a9lz9I2ugyDl96x3ThcaC4P6BIyQn0xeWfP8YHv4XkCiLNrtJH1cj1DsWV5NlL+XNElSNDz0FY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=CLzjlDf8; arc=fail smtp.client-ip=52.101.70.26
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LCT4SDxqqgbWayVnH0BpFd5AHvjfS21GbS5CtCVnvWQn+GxCNHEETNnph3TeHxKy7bNpkF84zD3Q6NZ//8tWUmwpDqdHMTpkUemZ2ynM1StD5GuSOvnMG5Nh/ty4SBDVSL49mPIG2kB3ZUfv6fBMXtStxdWXmpSQiVwiB9z8UMV24J4PEkxhEL2gy7dmgoskV7RLpHyu0QC2jN99XW8s5c+BAkrCbBdHlGbSMxrWq+fYtEJUHoawTZV1AEoXNXq3u5S05Lu4o7cdvOGwbn2e2XRcxn4Ienr4OLijqnJCoIArPzxeve1m45iDYyMK0m06gUD4q755WaiB/A8+OGztcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDY1sBwcvaUlLGpkdW08XVJboAxHDGyvJ6SXo6CWNqI=;
 b=qJfll2DEd3t+/OT/MB6uWdUilMDIdcm6FwDtTqWlQZBvemHp9C5r7JgATJxWJMG1J3yioE9LAZy44Eb8Jc3KzCW54Oj4vjjOO4Uu0eygyC9AubSZfsjEw1pnH8DeIkTacHCjJ2s/80LErRtiAZy/BE0Y1j93Gnfera2AYVfyk7aYzwgvPmC/ECs1knyalMd8rCkATgtWA6eTPOS4CEw/O7mnZbs6AtItIjqXu4LWn+W1FUec9JClevRqix82oDVPaemP5Zg0uK8MoHgr7oLEjCWEk0pkGm8T9vBrCyszT8XgyIJiKmRx672yM56cpKqfnKEZExb6t5GKyh2oMqtXrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDY1sBwcvaUlLGpkdW08XVJboAxHDGyvJ6SXo6CWNqI=;
 b=CLzjlDf8DaBXZc+icKOl0QzUgMbIPLaUPK6SCFaG6F0yjWc2lujHxZ4t7eObWOnYBqDBP6hAlbTR/61r66lwUgy9qyUAxyr2aKRlNR4nXwi94EugV39ne05YwEBidmzQAZOuXz4ZlW50eQTWn0ewaI8FhBPOs6UepknyB7cAi+zApnPrA9DFKuH0jeU7R+OWsA4c6xQfn4IIJpGH7Ljip8/xA/1aF1pM5fuXSG+GyH/JbjoWYEgwZepjebhX247SabLMG9M83dfP+hxO9yA7Mo/Hkj0kCw+yWFaZ/Xttv4to6ng5itataH3aJOcZiHUXRRlwTqJstqUJNujIXzqz5Q==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 GV2P189MB2259.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:7e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.16; Thu, 25 Jun 2026 09:23:21 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 09:23:20 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Samuel Page <sam@bynar.io>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>
Subject: RE: [PATCH net v2] tipc: fix out-of-bounds read in broadcast Gap ACK
 blocks
Thread-Topic: [PATCH net v2] tipc: fix out-of-bounds read in broadcast Gap ACK
 blocks
Thread-Index: AQHdA+FTnXdH1WtFjkSL+yo3uXtQ1bZO/vCA
Date: Thu, 25 Jun 2026 09:23:20 +0000
Message-ID:
 <GV1P189MB19881AD711511094760906DCC6EC2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260624135629.727262-1-sam@bynar.io>
In-Reply-To: <20260624135629.727262-1-sam@bynar.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|GV2P189MB2259:EE_
x-ms-office365-filtering-correlation-id: f1bac8ba-fcd9-491a-d7ba-08ded29b65ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|18002099003|22082099003|6133799003|3023799007|38070700021|11063799006|56012099006;
x-microsoft-antispam-message-info:
 mFyXau+XYAtCGYsZdkBy9qUVSlrXhNTjKE4Ie5ozNrO0VJph7PE7fvsVxkNttgPE0XSOOeANmuwYqT8nS2hI+h6pM5xXMEm4PdS0QsFLJ61e+pxymB28aBGgIjHD1U2AUtbDqYtqZReVmIOyJi73WYdvnjmKkfXpex3y87I63TRFep2Lf5+moKSNN93g0/qKmWEX5JLoyJyowqVDt98yMk6o816mB7JEkpvHmgiwM3TfdQLeec6Az/j0iuDG6BG/rpBqnrjAr5gp4eqrtYmSJDGiT+P4NlxygTkpp2zixAY7OcSmbm+Lc0s1GhvksZ7e+gZ/HFusHgN6eLwaPCVJJlMIbzgZV9WSN/iVBu8sAQB7KNAGQpskwXUB06ac7vdBvuhl1QboYcfVzkLx7eOHs4fnZv+eaxnIJWdGW0BDSCIbxr2gKvmUnplcPOxE1CmsmgzlmCAik8Kb7D7TAIJZUZIM+ryLnyQhoh9Snf1fJCrUGYmFpz70xZ1+Ri1w04kp3tSLs/Bso8d5y2Z9oZAQxGOdcwCu/Nlx6x/VnFXCCpVzeg7nSpPYNYxwUUUF8EHeGSn2OSRnmheb/JgnGEYa5xfk/JScVx+5y34aw1Gxk61s351RYGrp2+GFVsT7qxxVC91PGJI35XDlhE3W4rmMLJMT1kQSmRpdOCJC0khUNmzlFC+Nw3AJuA4CncpH1MvDNaIyRLvpk1lXVhn4TnQMQyIEBBMBgP1sgVdqdTpPHT4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(18002099003)(22082099003)(6133799003)(3023799007)(38070700021)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qWwIOgIKW/XnijTpFKr9Bt606sUfcsHEGyjQRCrOq2N9/z7zma/9O6ICv6bk?=
 =?us-ascii?Q?7NpeuXZRhN75PYT9htRWK715BsHyKD7VA/J79o7it22w/1ga8JsCrbsuhdTX?=
 =?us-ascii?Q?zHQ92yEfqWx9Rrygv+O27wg7gVJvbvLSPDjFtTcMsAGQ24bEMUdA+bPXhYMT?=
 =?us-ascii?Q?uUSFAEsXuc9ZcgCW4TcgecxFXkgs/doES27uD85rvabx3ANyoecSws/+Rk9l?=
 =?us-ascii?Q?ic3b4aTPT8ykbqX7AhV+UEkRG1uRDZF20TMwWMvDBs2/k80BXQmoVFzMSpR2?=
 =?us-ascii?Q?hEhR9uA1qwBY415qO7cQLXX4FFmhFF3e7Fu17dfNGlnxtd22kBldYFfpc+Nq?=
 =?us-ascii?Q?j7xCfjmNSH8kq4DhyLnk6+ysRzaPInfrgA6eZL96IFD0qE26F1w8Iw1GLKMh?=
 =?us-ascii?Q?vlkW0+7Fb6QKP+qu74Qye4qQ6M/QK05J4C9O4NObW+DZs2Te3Y5wi4uiHAF3?=
 =?us-ascii?Q?Grxm4QTL37s95NnbpdL6jhSWpDCtv5+fqBE3VB9RkG5OcKz0/X1I83gNoAF2?=
 =?us-ascii?Q?uu4jB+4iuA81B4WUCGwHbGaRPWsh6Jh4iwmE2s56uDCFV1yomFtcd1x5uaSx?=
 =?us-ascii?Q?cekpWBw1SERtDZU7y7tHUVgLdjNrtOuKdXsJAEAOw8ZV4kZfQbXw3SMG0VLK?=
 =?us-ascii?Q?N2dGL3egkluFh6G8HhjNIzUs6uXC8wVe44+9yf2V8JtciHCIHwFqywaqFo3i?=
 =?us-ascii?Q?NLu2mo+FPMwM5oDk9eUlFPph+YPxhfX2brSmp9xo6C8Sd2lqv1huK5UzEV8Z?=
 =?us-ascii?Q?4QRHTWGAXZO8+4Ca1SEeINVvlVac/wKASqK06ueHtO9G/9DpTyJYMYfStwOp?=
 =?us-ascii?Q?VYFIE7fVzGnWWyZhtCxF/5Uld76w+wWJBe1m+hq73l6hBZHF8sGAv+oMHFyZ?=
 =?us-ascii?Q?XFLbI5PluTzUxUh0h23ZLTZ9rCZtqcXhXo5iBgUMIKd+iHUd736QcMYehWLd?=
 =?us-ascii?Q?B6CMkXqaIT0eWIRnCIk6AB0bfCocDUyFlP56JJBJSsvO+KWjw7Z5I+cQ8t4Q?=
 =?us-ascii?Q?dJtN/CUSTBCzSHZ/GUq16iBmvRjHceTFttqEbZ20AZC+MhdsodQi7VabqvDN?=
 =?us-ascii?Q?b8+gorzug1+WOn0LTWlcqUlskg4BUk3bqCsTRz1nphTxr0MwmwvjWLpuvjsI?=
 =?us-ascii?Q?QSh2c3zbqnyq58Vb9NQCrd7XtfQgIWgM/JAYCfHJFigRREr+CqUB68fk5BzQ?=
 =?us-ascii?Q?zLOEUV/eQ5IqvBv/VgpeYsGrKodjdctbLQA9cqIDEVzYZGCisFcoLrxI2f+k?=
 =?us-ascii?Q?3QbLsezXUsuH4eacW/n1A3IpLc+DUYjG1RnQLSUP9nCM7MZ7ILVpFxdt08Ry?=
 =?us-ascii?Q?T/5TfO1j1RcqPjUA2l99AAfbsrQkMx5/XPRmyhLbVNjxB3z+qEhyhK3ZGSQY?=
 =?us-ascii?Q?BFr3TyUmPrm/BK5DNTL/6TZl0LJoBHut5KPO7PRD4OqPRuJlEouOoP3NxUS3?=
 =?us-ascii?Q?o92shFCuanHSP8TiOog2pxzbeXikvQFSgIgSFYw4kp5VbmZDR6sSsy697Sti?=
 =?us-ascii?Q?ux9iY+oxGWgZcGU7zyaHRQISgGdPsN9JlzW9gK27TIsLyjv2gGhf90/4+TGW?=
 =?us-ascii?Q?iw1/UhUaIpsRnTtAJglGFIec0QDM0Dp9VXSN/VNi8v3VBcutLxKwONWDC2tX?=
 =?us-ascii?Q?8OL5gD9YG3aPpCha4F4b9eMBkVZHZLINUFfbfrgkeDz2Iv1yXFUOSN0TCiZK?=
 =?us-ascii?Q?l6Lard7NcBN98PCOH005Gm35VSUqodrpc+oIj1mXBBvTq46DPS0bAWWTyfBT?=
 =?us-ascii?Q?DHM9xNlFyw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f1bac8ba-fcd9-491a-d7ba-08ded29b65ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2026 09:23:20.4759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Tfe4jFSLfjs00KVMhw4cAIe4Kan6AJ0vzhP86tqdsct/RgKHRwJfoBI877EBgO9rgRyK5AEVfy98WJMh5QwB3uYAexvYLaPAIkSKTeREqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2P189MB2259
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:sam@bynar.io,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:jmaloy@redhat.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301910-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[est.tech];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[est.tech:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B30796C42F1

>Subject: [PATCH net v2] tipc: fix out-of-bounds read in broadcast Gap ACK
>blocks
>
>A broadcast PROTOCOL/STATE_MSG can carry a Gap ACK blocks record in its
>data area. tipc_get_gap_ack_blks() only verifies that the record's len fie=
ld is
>self-consistent with its ugack_cnt/bgack_cnt counts (sz =3D=3D struct_size=
(p, gacks,
>ugack_cnt + bgack_cnt)); it does not check that the record actually fits i=
n the
>message data area, msg_data_sz().
>
>The unicast caller tipc_link_proto_rcv() bounds it ("if (glen > dlen) brea=
k;"), but
>the broadcast caller tipc_bcast_sync_rcv() discards the returned size, so
>tipc_link_advance_transmq() copies the record off the receive skb with an
>attacker-controlled count:
>
>	this_ga =3D kmemdup(ga, struct_size(ga, gacks, ga->bgack_cnt),
>			  GFP_ATOMIC);
>
>A TIPC neighbour that negotiated TIPC_GAP_ACK_BLOCK triggers it with one
>ordinary broadcast STATE_MSG (msg_bc_ack_invalid() clear), sized so its da=
ta
>area is short, carrying a Gap ACK record with len =3D 0x400, bgack_cnt =3D=
 0xff and
>ugack_cnt =3D 0. len then equals struct_size(p, gacks, 255), so the consis=
tency
>check passes and ga is non-NULL; kmemdup() reads struct_size(ga, gacks, 25=
5)
>=3D 1024 bytes out of the much smaller skb:
>
>  BUG: KASAN: slab-out-of-bounds in kmemdup_noprof+0x48/0x60
>  Read of size 1024 at addr ffff0000c7030d38 by task poc864/69
>  Call trace:
>   kmemdup_noprof+0x48/0x60
>   tipc_link_advance_transmq+0x86c/0xb80
>   tipc_link_bc_ack_rcv+0x19c/0x1e0
>   tipc_bcast_sync_rcv+0x1c4/0x2c4
>   tipc_rcv+0x85c/0x1340
>   tipc_l2_rcv_msg+0xac/0x104
>  The buggy address belongs to the object at ffff0000c7030d00
>   which belongs to the cache skbuff_small_head of size 704
>  The buggy address is located 56 bytes inside of
>   allocated 704-byte region [ffff0000c7030d00, ffff0000c7030fc0)
>
>The copied-out bytes are subsequently consumed as gap/ack values, but the
>read is already out of bounds at the kmemdup() regardless of how they are
>used.
>
>The unicast STATE path drops such a message: "if (glen > dlen) break;"
>skips the rest of STATE_MSG handling and the skb is freed. Make the broadc=
ast
>path drop it too. tipc_bcast_sync_rcv() now bounds the record against
>msg_data_sz() and, when it does not fit, reports it back through
>tipc_node_bc_sync_rcv() to tipc_rcv() so the skb is discarded rather than
>processed. ga is not cleared on this path: ga =3D=3D NULL already means "l=
egacy
>peer without Selective ACK", a distinct legitimate state.
>
>Fixes: d7626b5acff9 ("tipc: introduce Gap ACK blocks for broadcast link")
>Cc: stable@vger.kernel.org
>Assisted-by: Bynario AI
>Signed-off-by: Samuel Page <sam@bynar.io>
>---
>v2, per review of v1 [1]:
> - v1 cleared 'ga' on an oversized Gap ACK record, which let the malformed
>   STATE message be processed as a legacy (no Selective ACK) one rather th=
an
>   dropped.  v2 drops it instead, matching the unicast STATE path:
>   tipc_bcast_sync_rcv() reports the bad record through a bool output
>   parameter, propagated by tipc_node_bc_sync_rcv() to tipc_rcv(), which
>   discards the skb.
> - v1 touched only net/tipc/bcast.c; v2 also touches net/tipc/{bcast.h,nod=
e.c}.
>
>[1] https://lore.kernel.org/netdev/20260623134137.3641275-1-sam@bynar.io/
>
>For reference, an earlier thread proposed validating inside
>tipc_get_gap_ack_blks():
>
>https://lore.kernel.org/netdev/1316452e465e9a96fce44ec15130a14f3872149f.
>1775809727.git.caoruide123@gmail.com/
>
> net/tipc/bcast.c | 22 ++++++++++++++--------  net/tipc/bcast.h |  2 +-
>net/tipc/node.c  | 13 ++++++++++---
> 3 files changed, 25 insertions(+), 12 deletions(-)
>
>diff --git a/net/tipc/bcast.c b/net/tipc/bcast.c index
>76a1585d3f6b..08637c3c9db0 100644
>--- a/net/tipc/bcast.c
>+++ b/net/tipc/bcast.c
>@@ -497,11 +497,12 @@ void tipc_bcast_ack_rcv(struct net *net, struct
>tipc_link *l,
>  */
> int tipc_bcast_sync_rcv(struct net *net, struct tipc_link *l,
> 			struct tipc_msg *hdr,
>-			struct sk_buff_head *retrq)
>+			struct sk_buff_head *retrq, bool *valid)
> {
> 	struct sk_buff_head *inputq =3D &tipc_bc_base(net)->inputq;
> 	struct tipc_gap_ack_blks *ga;
> 	struct sk_buff_head xmitq;
>+	u16 glen;

Move this variable declaration to the bottom to follow reverse xmas tree st=
yle.

> 	int rc =3D 0;
>
> 	__skb_queue_head_init(&xmitq);
>@@ -510,13 +511,18 @@ int tipc_bcast_sync_rcv(struct net *net, struct
>tipc_link *l,
> 	if (msg_type(hdr) !=3D STATE_MSG) {
> 		tipc_link_bc_init_rcv(l, hdr);
> 	} else if (!msg_bc_ack_invalid(hdr)) {
>-		tipc_get_gap_ack_blks(&ga, l, hdr, false);
>-		if (!sysctl_tipc_bc_retruni)
>-			retrq =3D &xmitq;
>-		rc =3D tipc_link_bc_ack_rcv(l, msg_bcast_ack(hdr),
>-					  msg_bc_gap(hdr), ga, &xmitq,
>-					  retrq);
>-		rc |=3D tipc_link_bc_sync_rcv(l, hdr, &xmitq);
>+		glen =3D tipc_get_gap_ack_blks(&ga, l, hdr, false);
>+		if (glen > msg_data_sz(hdr)) {
>+			/* Malformed Gap ACK blocks; caller drops the msg */
>+			*valid =3D false;
>+		} else {
>+			if (!sysctl_tipc_bc_retruni)
>+				retrq =3D &xmitq;
>+			rc =3D tipc_link_bc_ack_rcv(l, msg_bcast_ack(hdr),
>+						  msg_bc_gap(hdr), ga, &xmitq,
>+						  retrq);
>+			rc |=3D tipc_link_bc_sync_rcv(l, hdr, &xmitq);
>+		}
> 	}
> 	tipc_bcast_unlock(net);
>
>diff --git a/net/tipc/bcast.h b/net/tipc/bcast.h index
>2d9352dc7b0e..55d17b5413e1 100644
>--- a/net/tipc/bcast.h
>+++ b/net/tipc/bcast.h
>@@ -97,7 +97,7 @@ void tipc_bcast_ack_rcv(struct net *net, struct tipc_lin=
k *l,
> 			struct tipc_msg *hdr);
> int tipc_bcast_sync_rcv(struct net *net, struct tipc_link *l,
> 			struct tipc_msg *hdr,
>-			struct sk_buff_head *retrq);
>+			struct sk_buff_head *retrq, bool *valid);
> int tipc_nl_add_bc_link(struct net *net, struct tipc_nl_msg *msg,
> 			struct tipc_link *bcl);
> int tipc_nl_bc_link_set(struct net *net, struct nlattr *attrs[]); diff --=
git
>a/net/tipc/node.c b/net/tipc/node.c index 97aa970a0d83..2887f94ee28f
>100644
>--- a/net/tipc/node.c
>+++ b/net/tipc/node.c
>@@ -1831,12 +1831,13 @@ static void tipc_node_mcast_rcv(struct tipc_node
>*n)  }
>
> static void tipc_node_bc_sync_rcv(struct tipc_node *n, struct tipc_msg *h=
dr,
>-				  int bearer_id, struct sk_buff_head *xmitq)
>+				  int bearer_id, struct sk_buff_head *xmitq,
>+				  bool *valid)
> {
> 	struct tipc_link *ucl;
> 	int rc;
>
>-	rc =3D tipc_bcast_sync_rcv(n->net, n->bc_entry.link, hdr, xmitq);
>+	rc =3D tipc_bcast_sync_rcv(n->net, n->bc_entry.link, hdr, xmitq, valid);

'valid' needs to be checked after this call. Then, return immediately if it=
 is false.

>
> 	if (rc & TIPC_LINK_DOWN_EVT) {
> 		tipc_node_reset_links(n);
>@@ -2140,12 +2141,18 @@ void tipc_rcv(struct net *net, struct sk_buff *skb=
,
>struct tipc_bearer *b)
>
> 	/* Ensure broadcast reception is in synch with peer's send state */
> 	if (unlikely(usr =3D=3D LINK_PROTOCOL)) {
>+		bool valid =3D true;
>+
> 		if (unlikely(skb_linearize(skb))) {
> 			tipc_node_put(n);
> 			goto discard;
> 		}
> 		hdr =3D buf_msg(skb);
>-		tipc_node_bc_sync_rcv(n, hdr, bearer_id, &xmitq);
>+		tipc_node_bc_sync_rcv(n, hdr, bearer_id, &xmitq, &valid);
>+		if (!valid) {
>+			tipc_node_put(n);
>+			goto discard;
>+		}
> 	} else if (unlikely(tipc_link_acked(n->bc_entry.link) !=3D bc_ack)) {
> 		tipc_bcast_ack_rcv(net, n->bc_entry.link, hdr);
> 	}
>
>base-commit: a986fde914d88af47eb78fd29c5d1af7952c3500
>--
>2.54.0


