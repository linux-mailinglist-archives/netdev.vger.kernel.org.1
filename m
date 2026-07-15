Return-Path: <netdev+bounces-307639-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qyK7FBHtVmo1DAEAu9opvQ
	(envelope-from <netdev+bounces-307639-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 04:14:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F53575A056
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 04:14:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=est.tech header.s=selector1 header.b=CEDSRxQP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307639-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307639-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 146DA305F0B4
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 02:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FC63A7F5E;
	Wed, 15 Jul 2026 02:14:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013002.outbound.protection.outlook.com [40.107.162.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DE739D6FA;
	Wed, 15 Jul 2026 02:14:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784081677; cv=fail; b=B+9BglJ9F0cLfMWdzb0W2YxXpUK0lpgGF7zXYZOUjao6si/p+ZX6vSNujJI0/A3iyo3UpeqX36A/E0bXlz49FuU0yAOiCPpTJ3ZrtWr8y3YdqcJZCom9SKY3wDwVi1UTSKnv1lEo5HmPOQ84uzYwt53+FeMqLVwrjrmhydKOVck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784081677; c=relaxed/simple;
	bh=VXqQLyrLwxjlrPgXVDCD+Q+bwc3Kpeu93uotYEK6b0M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fmm/aiCsJ6AGgm9R57XDfQrx9zkmOv28vrIDBP9NFpw37cm4bjgyVM4pDLvV/J/fPJ2d1iw5ltTL8ND4Cw4nl+iPah1DXJKwhG6vDbHpy6OFbu0cXtY1VDp1S7Tr4c3CB4ECkYEpm9V5DaRWESuf6chYZ+4KI85F7kxzF8FkAgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=CEDSRxQP; arc=fail smtp.client-ip=40.107.162.2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OyQ3SwPKcPjfBY/JTEye8M+DnhfhTtbzTJoWUIujIIz/q4TbGPP3xdya/Cs1e/PkkOvUX2Q0fB1WS3bOKeeawttfswfX/CbUiL4FtawpAYmHWr5v2I5gEQDzH3fAWIcrnKQPXRPgtIkxyH9HS8l965NLiD634z79s0b6RrqJfAaFqvvmd/e79DMWeEUroQ8M+od6HaJlwB34oRKEGWkooasqUWKllLl4HfJR/ly6941bPls9JIXnGjv6QeTbwcK1QLpzT/p1XsMnfSjMS85NVPJ+MXfLUmAqJlecLMVt7TNW5VK04VgY8mrBe5dyU06T1M+RikMzKfY2Ll4w69YJEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgGu49Q/qpRYrqwhjMlN2o4mw0837xHnV9o8HnTpHMc=;
 b=t5/5WqTZjwsIXap+1rLD3RPSjFGAyMOJzbJJZ7o3884MjY18JxeRfOlD3i65zTyHKaKml5dHOy592WIQK9xMYUpy6xcOtBBds2XHT4l2Ojfbh9JStN4X0VNA9cwo32E/BPtqepsZ54BgTPXCIPzVkBxKDTzitb63b2Dgggt9TaxVvxqWfG6976IAvlO7GJz0W1MrFKYH7Ug8LO0fQLPtVVNpiUIaarvASdojD3KkBI8pvteLFaWDR5jBj/5jamSTkWGt3DnJujIfRJLxMWy2LQucRVBT7AyRd4JC2Wnc+jtl9vTx+dBkBCLE04u+SKPdmGkFdFEiCmZv0trcsgTQFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgGu49Q/qpRYrqwhjMlN2o4mw0837xHnV9o8HnTpHMc=;
 b=CEDSRxQPCGVhUoHhzOkw/dEwU9w9dJEuh5BWXOU8rPoQltg+7lnnD7R0vvKpw2++pZhaSwip4I7Xs4+CLeFJgyF2Xtbo8Qz5HhTGnlATiYv34daVvBuiCB/3c4Pwm3duwhcqNhhH46lHlNyhtAzb4BZg+ukjZRSsOj/0lCgPuRdFd11FU7zopbrv4LAMIW8z4DEcyaR3IbLbKnC+cioW4xSen5eYayx51cxNgJ+7lItUpfF/PICQ4MAKfAKG36B66pLx/TMnioulWsO8ljPMSjW3MYMF2r7oeBPMpqjUm7Dp684MHhPRxolxavvPMlrXd82YF9E3oKPLA2PDey8wPQ==
Received: from DU0P189MB1994.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:3a6::11)
 by DB8P189MB0886.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:16c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.3; Wed, 15 Jul
 2026 02:14:32 +0000
Received: from DU0P189MB1994.EURP189.PROD.OUTLOOK.COM
 ([fe80::7181:423c:55f1:76d]) by DU0P189MB1994.EURP189.PROD.OUTLOOK.COM
 ([fe80::7181:423c:55f1:76d%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 02:14:32 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Helen Koike <koike@igalia.com>
CC: "jmaloy@redhat.com" <jmaloy@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel-dev@igalia.com"
	<kernel-dev@igalia.com>
Subject: RE: [PATCH net] tipc: fix infinite loop in __tipc_nl_compat_dumpit
Thread-Topic: [PATCH net] tipc: fix infinite loop in __tipc_nl_compat_dumpit
Thread-Index: AQHdEwk3GCZhg7KjeEy6gha5XKvR2bZt1Grg
Date: Wed, 15 Jul 2026 02:14:32 +0000
Message-ID:
 <DU0P189MB19944B721AA24962E0B04196C6F82@DU0P189MB1994.EURP189.PROD.OUTLOOK.COM>
References: <20260713204940.647668-1-koike@igalia.com>
In-Reply-To: <20260713204940.647668-1-koike@igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0P189MB1994:EE_|DB8P189MB0886:EE_
x-ms-office365-filtering-correlation-id: ad339e9c-fd20-43b2-5b47-08dee216ceec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|38070700021|6133799003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 KRc2p53eW9WsplELQUYu7d7MUq0WdSyX7nLsCK8avwrac/lzd305RKfDG4evIAG6KPwEOwYJc+GmmrUvCyqhdy05lqqFVD8QU1MYqnMsHdJmvgRHR/v1BcRuYh6F5QkbHoqHRAOF74vzGYYNFNGFUGUDjiH/5A8vdGHnNik3NKwaOX9E0B24CFVbKYElGVJkMH2kJaizlEIBLSGgKNGFD+W/G/nExwRXjBINTJBC3VTt5B1NA8JZ0wCW1G+AZH2HagimHkMVNU5UH/7xr/DKP2pajH4oop5Zb584mGZy00G9rglw8XUclCKsl1xkdLqfg29TwDZqAV1Xa4Fb8o93lf5f4n+jcLh3Xw0Ex7StbVKBVQAIN4g1OiFC8h8AQ8f/HadK8opUxugeXeir+6Ma0m9aPiSA3B8hGKMUIlDRHGccWyg6weI5lq/fwdATQv/kEmRMzb5t1oaDYFnfRoPkhKii4pF0R8VasbhWNP/0DxjQnb5Xz1cmNeRSSHaE9wcc0fQOvqImlmxX1ynhQ4CC31bhgm/SPQC+NAyLv/Vwz1tgGqv66GnsDw59L84XFuVpHTUcTOFumkoecrt0b+IP3tCXcWbzoWuoy7A6oUv39kqIO/+Lif4TynIMTWgw2R9YcA27TWTk50FKdMngovJ7oXM7jArhWZELNWFuSGhPZEY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0P189MB1994.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+IH7RBBge1FMpjIehiNUzNv8+PgYO563eebX07i+H/9YAUCm3DGsTo5rg+UY?=
 =?us-ascii?Q?tss88jchh+5gbJecZYyssQrHbgjZyGCHXEsb5OS7/C77Z9GZ0vvMuetfBNsD?=
 =?us-ascii?Q?qn7rZTAfDCVjkseEuGMWjZfw+ZGuH2TbG7/nNnw+K9FX/7vALOF6KX/JH17A?=
 =?us-ascii?Q?aj2pbnlLUmCpIOdfVh66ArPMRdhpE970AEe3lGSul23SjXEgoQamvWSnOZ+c?=
 =?us-ascii?Q?Ugj3chbMoqXkhWoVo1pJksF6mbaX3aNlt7s33ISQZyRJy3iHrc2KdTbABs6Q?=
 =?us-ascii?Q?e4YfuYr0Byx3Tc7gjkLVcnCyQbIwkCvpcgqaQ2FdmGRnwJ/htjc36Z+FhFb0?=
 =?us-ascii?Q?2fMRz5tolrl7WbvekPVA94pa49fW5uXWc4p5ogy+D9AhsCzg3pSiPKFyULZT?=
 =?us-ascii?Q?VxHU4pjWy320ZWSCZP+L5k/SrUEpW0eF+iOzmFowTOVaBIWHYv0h1N3WCCuM?=
 =?us-ascii?Q?8HT/fVGKRcDneNY++f4phUTZ4pzoYeCWtYwC1WW866+qy5XxlZEcpSdETRKj?=
 =?us-ascii?Q?pS7iOdtvO77SQd8NiPY5BqBVxSOsowYzwCTTtbwh+YEs/ilbtfXPTV+FwxiC?=
 =?us-ascii?Q?LK1z8Qu0BlevbT4mA+04c/v8sj2Ko45OjLI10oypHtm4iRZ30XzQarbSAARM?=
 =?us-ascii?Q?+cJupl6MaHNGPLuINF103bz+/dJKs86pj7kXEa6tZRuuVw17sERzFFYiGmuS?=
 =?us-ascii?Q?QRAd4iWrb5wp3i6OuZgSdKuIqfYTFynkYTGn6xTVQmLXc6/NG8+s6NiEe7jF?=
 =?us-ascii?Q?24+TsTXJtVPvJnhxhQKIpY7CAFTD8LFPaI5a98TtpC2htyVdXnRUFbwfXr5S?=
 =?us-ascii?Q?lgJ7EaWoRbrJPQxzGmTxQJXeUMM04EFC22pquxDVA1R7aTVqeMAo7ZAqLVmi?=
 =?us-ascii?Q?4ZyXedHxrfEpTvnceZCRw5eFnnLX6amvnxs55mZhkhFwlyCZK+o5FxkpCvD8?=
 =?us-ascii?Q?/sLfJJX2TKhXy/fx2FytkQKr1HXUQse1q1HODzXcX3MRqIYRaUTYbHHaf8AL?=
 =?us-ascii?Q?K++m6VfxioXt59Jm0ZO8PpW6Z/sOl/SpsCJp7l+Aaq8SGf4luLZWT/OzXpbF?=
 =?us-ascii?Q?Ux/56kkQUhtK2TEa2/i78+qXhXKS0yZSdEew+SFdmTjR7c7L23KGHlifRd+z?=
 =?us-ascii?Q?oGWjJ0TDt0+M1Xo4jjqzSok6+b/VZdXk1TSQoGkUVMIoB4iW8hDN+OuMKWj4?=
 =?us-ascii?Q?nH6ZS6rkYLKIqvVux9QZyz3vnXJBJ/L+KkKernBRM3lrX5ZhxiRK4zawzdGT?=
 =?us-ascii?Q?nL5NySWkSfmHj4cuTviSNRf8J3svOx0KTRWIv2ptjASeOjN1EdJ2CmwU2Xvl?=
 =?us-ascii?Q?bsFi7S6u1pAaSKbgVxPvZhPsPpcD0smc4pDqzi20/vcJTRUipvY9nZ15bW3G?=
 =?us-ascii?Q?0vBG5/KdTE5l8w1jdKf4lsJzTmcoGh1nrMpcrTM2cIufdFEu8w2ORQUgBUTK?=
 =?us-ascii?Q?5Lf5zmf0AxonbAXmbTTM5A1BSFcqrwUFbPTuzepyIq5RTe3QnDGFRLjKUCtb?=
 =?us-ascii?Q?wTlkVYop8yRgNI8coBpBoI5FQUDRSujjJmlwGDivl7FWXljQCiQJi41FToPV?=
 =?us-ascii?Q?GG/XWEG76dgEWuAXyQMuL3n6Q0OEUqq+Bro64sUiRqA2hFokIzM8mwxFuHzI?=
 =?us-ascii?Q?wxqVw+YM89KswJq0L3EEZcsb48yISgVrSt4P1lqToHjo9litofQVtPi3SjJe?=
 =?us-ascii?Q?JJNrbBQV78OKUwp380GNYWyzxyXRxBI2ageDpgiezVOUTDtsn2M+IWkavRb/?=
 =?us-ascii?Q?Ed0Dg3m4Bg=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0P189MB1994.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ad339e9c-fd20-43b2-5b47-08dee216ceec
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 02:14:32.0910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R6rAbQ4unm2bwwLm/MUo73das72sD3ohBVcfU8++Z5nohZ1f6JesZpzjTgn7wE0Hz03/zLt51KxiEj7xJ/ylKtxMDqVA/4Bn4HuMDw7LWNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P189MB0886
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:koike@igalia.com,m:jmaloy@redhat.com,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:kernel-dev@igalia.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-307639-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[DU0P189MB1994.EURP189.PROD.OUTLOOK.COM:mid,est.tech:from_mime,est.tech:email,est.tech:dkim,syzkaller.appspot.com:url,igalia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F53575A056

>Subject: [PATCH net] tipc: fix infinite loop in __tipc_nl_compat_dumpit
>
>cmd->dumpit callback can return a negative errno, causing an infinite
>loop due to the while(len) condition. As the loop never terminates,
>genl_mutex is never released, and other tasks waiting on it starve in D st=
ate.
>
>Check dumpit's return value, propagate it and jump to err_out on error.
>
>Reported-by: syzbot+85d0bec020d805014a3a@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=3D85d0bec020d805014a3a
>Fixes: d0796d1ef63d ("tipc: convert legacy nl bearer dump to nl compat")
>Signed-off-by: Helen Koike <koike@igalia.com>
>---
>
>Tested locally using syzbot reproducer.
>---
> net/tipc/netlink_compat.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/net/tipc/netlink_compat.c b/net/tipc/netlink_compat.c index
>2a786c56c8c5..d9a4f94ea2d4 100644
>--- a/net/tipc/netlink_compat.c
>+++ b/net/tipc/netlink_compat.c
>@@ -221,6 +221,10 @@ static int __tipc_nl_compat_dumpit(struct
>tipc_nl_compat_cmd_dump *cmd,
> 		int rem;
>
> 		len =3D (*cmd->dumpit)(buf, &cb);
>+		if (len < 0) {
>+			err =3D len;
>+			goto err_out;
>+		}
>
> 		nlmsg_for_each_msg(nlmsg, nlmsg_hdr(buf), len, rem) {
> 			err =3D nlmsg_parse_deprecated(nlmsg, GENL_HDRLEN,
>--
>2.54.0
>
Reviewed-by: Tung Nguyen <tung.quang.nguyen@est.tech

