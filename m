Return-Path: <netdev+bounces-306070-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vVoHEHpET2q3dAIAu9opvQ
	(envelope-from <netdev+bounces-306070-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 08:49:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B62572D56C
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 08:49:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=est.tech header.s=selector1 header.b=XMBF6ESc;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306070-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306070-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDA7C300B849
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 06:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA4E3D9688;
	Thu,  9 Jul 2026 06:42:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012070.outbound.protection.outlook.com [52.101.66.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABDF3DD526;
	Thu,  9 Jul 2026 06:42:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783579377; cv=fail; b=Y/tG6Hfi/MiXA2g3q5CHF+qkBzct6++2Yg4290nbzNxncBdRncXdA82HO572mX+E2cugTApMyvD1FrpRn/evhCrMKZQ9sQQ1wVK2qyBOsxuHZk8kc9MB7ngz9LFFoZ22F/9r/dh6SJtxV+DukwsoBhcofvg8h8264l2fOlYzmEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783579377; c=relaxed/simple;
	bh=DKh1nzaTpNt/dd9Xbv6fVBX1Sb0BlJpxRCn4/x3vDH4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pn/4T36Uu9UW+VsrJ9aGzLvwGwbVaxH5CgXUVanyZcnsIp/P8+qBQm75nWkAabBKQm6zdHPw8++F29VkmQEMsU8nxZeE8WYuuRW1XVLIj0WlnKEjoggrKAZuhnXQY4xJnQGEPTkjbjTRdilq6dF0nX38xzmVVSGynfGTlkJ4z3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=XMBF6ESc; arc=fail smtp.client-ip=52.101.66.70
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QDGZj50h420GbZAgXDpQoG2a/GkKBEjo9E3FayyQpcDaGLkIcIa35ey3RxhjygENLGpFkgTND1d9xpEApzA5roFVOkYx/OPc+j1W28Kynpc9whEExG1FIvT78SSoCyqQxeOxLJzzVmeqJbbrAA8xAMlomiS6KmYaXL3A4IUDDczrtnAIbW/c1reD+XHnJX9B2rR6sujGFabqm2uGCERdfwxl0ZIK3gGb5L3zr5y/Z2BQ8XU5Ts1UVD48abfw87YGLvYEkJb6jmX8CtMCky3ao+67wc4gZDT80UydLi2ajVQ69PtvCVxtabRD94uTdx5ddaLFmwT2UaY0LCMDHie13Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a91IXcHHIZ+2YJLH7csU0+/5i9PSVJBcuyTO9fT+IfI=;
 b=iv/TB/2in60fJonDb14vRm53n9a+KcAnOINvLN3OBCv3Yt0RcHqEOQlinzZ4M71m+r2mJOtCxe+3nbyZwemCCpIcaGrNqTT1YY61HU7MaPSo3Aq4GPgyDg1mMyZUx2wYIT5pUcKWAAJZXNhA0tbq2vXiLHwWhkzhwHdC2OoGGJMNenpEqWklbiuqAf8Tf4caRoA98l7lXpmO9ruaGmblE1rLApMaMDO6JjAHPSAFOKJrSSIsTrYM2SFLbB8odrDhyk0Rfu/cKwjTsaIMZnyCbEbngsUcLxYbrSsPm/S0YWHrUEAL2Qqafrytz4fbvLKzcTHC6ggfJkHFxb9qz4W6SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a91IXcHHIZ+2YJLH7csU0+/5i9PSVJBcuyTO9fT+IfI=;
 b=XMBF6EScYqBExUTvoVhfsuVE7bU4WznxddXGWZrLE8m7Jy8cA+nLwJECZEBv3ZG8KIaRhmEzhx+IxDvh8q/i0N6JnQGU6HPCO9LiWvNQxekQQqGT120lDzV1tBy9ZYXAHGhuBJmqudWB73ML7OPCsyueIy2/cDLQPxRFnF77PMVRzfmIZKBdBjJ8iZWoZHXc11FsClbrL55FSamix/Xkw4X6OIbvrPGKvf3vMDJSXt5HTPYVsi4sipdCHeNbog1dvTb8nc1neemVFvRa2WPGfjm9ghT1AuRhGOmRtMUv2tc4XgDhdAeUL3+pTpVZJAiAnvv/FDPbPFKB51NguKaqqg==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 DU4P189MB2755.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:570::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.11; Thu, 9 Jul 2026 06:42:46 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0181.010; Thu, 9 Jul 2026
 06:42:46 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Weiming Shi <bestswngs@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Xiang Mei <xmei5@asu.edu>, Jon Maloy
	<jmaloy@redhat.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: RE: [PATCH net v2] tipc: serialize udp bearer replicast list updates
Thread-Topic: [PATCH net v2] tipc: serialize udp bearer replicast list updates
Thread-Index: AQHdDi/D4YmkcIZsF02+N8D+qqpgrLZkvlsw
Date: Thu, 9 Jul 2026 06:42:46 +0000
Message-ID:
 <GV1P189MB1988185B47AFAA9202408186C6FE2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260707164248.821265-2-bestswngs@gmail.com>
In-Reply-To: <20260707164248.821265-2-bestswngs@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|DU4P189MB2755:EE_
x-ms-office365-filtering-correlation-id: f7fe4857-a610-4f62-9a83-08dedd85497a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|38070700021|22082099003|18002099003|5023799004|56012099006|11063799006|6133799003;
x-microsoft-antispam-message-info:
 Z5Z6pTl3yyC2JsmmcmOGG75RtW/UBiPqZrjwIPiHjxzsRFKCLf5DqZ5ucTkG+TR8vmhlVuyZ/Z0sgmz1qxdEC24VSG4uwsUlcc/Y0Hp3Pjc+uSpe1PASnpcusSRTNHd15frKQu5jWSU/W41PNGr7VTmbs3vnS/9BlD3Pb2Bl8e1n/ad5uhDgHCXqUgMgCi7oIP3RQWfwkwHZhHG/B42EJaEXn7e8w4qJZeiHMTt4S4yzjbD7A9Z+QahEucXd5kh2gLEdP1ZjnoJMfHlSpbvUsTXU7gw6vS0KGsyrEVml6TvGyM/Xh5GNshOhrTY0Rh2GzG0fyZEIplUWKynGHg9othU54enor1MS4IcPBwapAmE/YaQPDP52hK65QBjqfs938Af42HPtf3Zr/oeSJERdaay/QtM8Xkl8cOHswOieXIiagbkcdnXy1Hgxi/gKGqVTm00+55lI+Wt6nB+QmsKy9lg/Qd83+CA4GUKPpJHao4TH/CZYJg3X7eo7CZntpD8NP+H6VXvJ+eOAa7rYmm083P0+QYm9pCB1xud0eNZnUzXE3UOMiwu0AZ21TImWO57lYydiQ1KQdwhFxJ6wEH2oMsK+TLV+JjYGsnyzGKxOJ0Zsjg7FSK2mPqa/wQd8Dfeys9nOGLC6CqCqaQCd2tmjNc4E61r5z4a2ZtcXmX353OaGgX83+j9sgHHAjCw1ieFWGOJ0awxTLArSmqNx0MvPhUKKsw5CCOmWaRdGn+IgGd0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(38070700021)(22082099003)(18002099003)(5023799004)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?n9V3LsD8wEHUuSN5H5fo+vQS191a5yXJjpKfWMupjwVaQnI11T3iOHY1F6Ab?=
 =?us-ascii?Q?77ErwCWlJf5dVCyBH+KuyzdM03chHgT5YO3CZXeQjiFSjZCQP+wJSjfvUV53?=
 =?us-ascii?Q?Rg7VVLqLjau9MgfuhjjvlGWIeWeGPj++gbBP2XB4Lu5qzNNuKOrOYNRpFrKx?=
 =?us-ascii?Q?0XIJcZQu+wS4Vjx9XpiT4rik5pCd99UVHruTz6LdIoYusHKAk6qM9UqQWimR?=
 =?us-ascii?Q?Wp5q/dtK2RqO1/9CWxA8YmPCKnRLDuCx28ABto0JYisumOgAVmYYpSIqSaOl?=
 =?us-ascii?Q?l3rIXrRgxH3FpA7WCPonGCHeW2Wj9dCRga+PtVg/SnDHZVsgXnIGgDF8WLim?=
 =?us-ascii?Q?qPvucTncy9wjDCT7zgr5st5aJxQDhJu8nh+9N8jGDznY9uwhu0i2Ob8FlDhZ?=
 =?us-ascii?Q?inM/GG3tOJ2rNKbqlpH39SfSXgReMAdOkvMnzU6BzE/NEqQ2oDEdk6SZLqxI?=
 =?us-ascii?Q?35jqVHS1nv7ajlHgBV9Gnaqf44fnwGcb+zQUrsrOv/rdlLzaVFzrLiMM44gb?=
 =?us-ascii?Q?4FzQ6T2qo0Nhe1uKX3pkBAV/LIQeqDrrcAZAVXAxAY+AhcWFCs6axCpDffTG?=
 =?us-ascii?Q?z0FYXXqscqWI8OxLMmi0LI1XkS9rTEkRF+hczIce9ssTbzF/Yla8J92G8Lon?=
 =?us-ascii?Q?M1RcUER2UvohjnfyALYhXwy0RjHRtHRcOm2/ndR4c9tUyEgVio9RXLMGo/5t?=
 =?us-ascii?Q?DkKlk5biQoJURErY9ecpA0hV7wSDInx1pdUqIKkh6gcgBi7pMyIpl+xcxajF?=
 =?us-ascii?Q?H3BxdM9hXLisp1xse41n5lC8bhpGk5YJhr1/G9SC4/WLdN3mmdXeMxeMrEx0?=
 =?us-ascii?Q?mHPXpVEL21aHc/5BDeAvyfO489XxoslQceiYCFJjUl60jbChj2+TsvGDRNpb?=
 =?us-ascii?Q?bLbbzzrbtsIiyy0lMpHezBsmasyx488I0e5zsKlnNB4p5fgwB9K3jkgzSTtr?=
 =?us-ascii?Q?yiOqdtR6+xeuPiVAo7gXvpygfrgUJMJ834aC7d1HaFYeOznk0SdFHMVIfXsZ?=
 =?us-ascii?Q?FRi12y4nKoLOMvwVxPsXD8m1SM10Xo6DtlmQRsQ3Q6+cL08xB559k8hR8AEa?=
 =?us-ascii?Q?+6K3abeTG6Ekbu/FKdu7aH9CZWZEGru5kjgfb1xtectEeKQLPxvAcsO7QFeN?=
 =?us-ascii?Q?u56cnLvnyVmdUF3UQDM9RXNWHiz9bumsbYemiUv4Lg4khn3sww8xE/A3mz7T?=
 =?us-ascii?Q?H/JG0F8iS6bIrjF1EJz31S7mikTIxPuNDXed/Qtwjw8+r2vvXqnPRxEc8yOQ?=
 =?us-ascii?Q?VapZ6Q6WsjFCvAM2sXucxKi3/fgbkxyEStraH148mh4xVBdXKG4Gzzt3Isaj?=
 =?us-ascii?Q?yAIsCXJtal4MtFm1/pGU+h+asFCy/6jKM0zWd8JP2E191y8L8zmrUcsUIue2?=
 =?us-ascii?Q?5qtuipEjCkAMrc02QKXi+Jn8RVVNKf0rzsXWgRHy+Q7vdRua9lN2icg3B4Wb?=
 =?us-ascii?Q?ckJ0tfbtDmTOJO+eGGYWNiFxPW9v9S2tTyZQl47TEfi0hiNN142pD0InNShX?=
 =?us-ascii?Q?bKYyu2gc+5tXMorjJ+cd9hlP/yc5KCgX4XRhEOHQWVfqZLpMHZWOiomczYEs?=
 =?us-ascii?Q?CprRZ/26Wbv60jwP9RYC8IMyYARAoWRuwUfqfs7eIhVNo8twg00z5Jp8HR/Y?=
 =?us-ascii?Q?JQJTOaBDWHjW3vZMSLvNcYlX6QLf8a24OCB50PQ4DQoOC3gAEHCmeMb/sr1G?=
 =?us-ascii?Q?OndrCMBSYQrNq/Fw5Wy9bDR2iTIXW5zSHh02K3KQWeUPUV8zXE2kLSTbGHWh?=
 =?us-ascii?Q?b7Nf3ydxMg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f7fe4857-a610-4f62-9a83-08dedd85497a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 06:42:46.6040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7kuZ52ppDFVD/0XtU9RCO7kebgPLn6qE8B80+sTHUVJjWw1+wN2RFw1Dv4W8siYysXn8vI1N0R4vbmTNb/xj40D00ePSihs9pIy+1cbh8Lg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4P189MB2755
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:bestswngs@gmail.com,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:xmei5@asu.edu,m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[est.tech];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-306070-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[est.tech:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,GV1P189MB1988.EURP189.PROD.OUTLOOK.COM:mid,est.tech:from_mime,est.tech:email,est.tech:dkim,asu.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B62572D56C

>Subject: [PATCH net v2] tipc: serialize udp bearer replicast list updates
>
>tipc_udp_rcast_add() and cleanup_bearer() both update ub->rcast.list with
>list_add_rcu() / list_del_rcu(), but nothing serializes them. The add runs=
 from
>the encap receive softirq (via tipc_udp_rcast_disc()) without rtnl_lock(),=
 so it
>can race the cleanup delete and corrupt the
>list:
>
> list_del corruption. prev->next should be ffff8880298d7ab8,
>   but was ffff88802449ad38. (prev=3Dffff888027e3ec98)  kernel BUG at
>lib/list_debug.c:62!
> RIP: __list_del_entry_valid_or_report+0x17a/0x200
> Workqueue: events cleanup_bearer
> Call Trace:
>  cleanup_bearer (net/tipc/udp_media.c:811)
>  process_one_work (kernel/workqueue.c:3302)
>  worker_thread (kernel/workqueue.c:3466)
>
>The bearer can be enabled from an unprivileged user namespace, as the
>TIPCv2 generic-netlink ops carry no GENL_ADMIN_PERM.
>
>Add a spinlock to struct udp_bearer and take it around the
>list_add_rcu() in tipc_udp_rcast_add() and the list_del_rcu() loop in
>cleanup_bearer() so the two writers can no longer corrupt the list.
>
>While here, switch the read-only walk in tipc_udp_is_known_peer() to
>list_for_each_entry_rcu(); it never deletes, so list_for_each_entry_safe()=
 was
>misleading.
>
>Fixes: ef20cd4dd163 ("tipc: introduce UDP replicast")
>Reported-by: Xiang Mei <xmei5@asu.edu>
>Suggested-by: Tung Nguyen <tung.quang.nguyen@est.tech>
>Assisted-by: Claude:claude-opus-4-8
>Signed-off-by: Weiming Shi <bestswngs@gmail.com>
>---
>v2: (per Tung's review)
> - Narrow the lock to just list_add_rcu().
> - Drop the under-lock dup re-check; serializing the writers is enough.
> - Use list_for_each_entry_rcu() in tipc_udp_is_known_peer().
>
> net/tipc/udp_media.c | 11 +++++++++--
> 1 file changed, 9 insertions(+), 2 deletions(-)
>
>diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c index
>62ae7f5b5840..c6aa8c3c54ce 100644
>--- a/net/tipc/udp_media.c
>+++ b/net/tipc/udp_media.c
>@@ -94,6 +94,7 @@ struct udp_replicast {
>  * @ifindex:	local address scope
>  * @work:	used to schedule deferred work on a bearer
>  * @rcast:	associated udp_replicast container
>+ * @rcast_lock:	serializes updates to @rcast.list
>  */
> struct udp_bearer {
> 	struct tipc_bearer __rcu *bearer;
>@@ -101,6 +102,7 @@ struct udp_bearer {
> 	u32 ifindex;
> 	struct work_struct work;
> 	struct udp_replicast rcast;
>+	spinlock_t rcast_lock; /* protects rcast.list */
> };
>
> static int tipc_udp_is_mcast_addr(struct udp_media_addr *addr) @@ -281,7
>+283,7 @@ static int tipc_udp_send_msg(struct net *net, struct sk_buff *sk=
b,
>static bool tipc_udp_is_known_peer(struct tipc_bearer *b,
> 				   struct udp_media_addr *addr)
> {
>-	struct udp_replicast *rcast, *tmp;
>+	struct udp_replicast *rcast;
> 	struct udp_bearer *ub;
>
> 	ub =3D rcu_dereference_rtnl(b->media_ptr);
>@@ -290,7 +292,7 @@ static bool tipc_udp_is_known_peer(struct tipc_bearer
>*b,
> 		return false;
> 	}
>
>-	list_for_each_entry_safe(rcast, tmp, &ub->rcast.list, list) {
>+	list_for_each_entry_rcu(rcast, &ub->rcast.list, list) {
> 		if (!memcmp(&rcast->addr, addr, sizeof(struct
>udp_media_addr)))
> 			return true;
> 	}

sashiko reports:

...
Is there a possibility of triggering a lockdep warning here?
Since this function is called from tipc_udp_nl_bearer_add() during Netlink
configuration, rtnl_lock() is held but rcu_read_lock() is not.
Without an explicit lockdep condition like lockdep_rtnl_is_held() passed to
the list traversal macro, lockdep will complain about the RCU list being
traversed outside a reader section.
>                 if (!memcmp(&rcast->addr, addr, sizeof(struct udp_media_a=
ddr)))
>                         return true;
>         }
> @@ -326,7 +328,9 @@ static int tipc_udp_rcast_add(struct tipc_bearer *b,
>                 pr_info("New replicast peer: %pI6\n", &rcast->addr.ipv6);
>  #endif
>         b->bcast_addr.broadcast =3D TIPC_REPLICAST_SUPPORT;
> +       spin_lock_bh(&ub->rcast_lock);
>         list_add_rcu(&rcast->list, &ub->rcast.list);
> +       spin_unlock_bh(&ub->rcast_lock);
>         return 0;
>  }
Could this allow duplicate peers to be added to the list?
The under-lock duplicate check was removed in this patch iteration. Since
tipc_udp_is_known_peer() is checked locklessly earlier in
tipc_udp_rcast_disc(), two concurrent packets from the same unknown peer
could both see the peer as missing.
They would then both acquire rcast_lock sequentially and add duplicate
entries, leading to memory leaks and traffic amplification when broadcastin=
g.
[ ... ]
...

I think we have to check duplicate address in tipc_udp_rcast_add() before a=
dding and remove tipc_udp_is_known_peer().

>@@ -326,7 +328,9 @@ static int tipc_udp_rcast_add(struct tipc_bearer *b,
> 		pr_info("New replicast peer: %pI6\n", &rcast->addr.ipv6);
>#endif
> 	b->bcast_addr.broadcast =3D TIPC_REPLICAST_SUPPORT;
>+	spin_lock_bh(&ub->rcast_lock);
> 	list_add_rcu(&rcast->list, &ub->rcast.list);
>+	spin_unlock_bh(&ub->rcast_lock);
> 	return 0;
> }
>
>@@ -679,6 +683,7 @@ static int tipc_udp_enable(struct net *net, struct
>tipc_bearer *b,
> 		return -ENOMEM;
>
> 	INIT_LIST_HEAD(&ub->rcast.list);
>+	spin_lock_init(&ub->rcast_lock);
>
> 	if (!attrs[TIPC_NLA_BEARER_UDP_OPTS])
> 		goto err;
>@@ -819,10 +824,12 @@ static void cleanup_bearer(struct work_struct
>*work)
> 	struct udp_replicast *rcast, *tmp;
> 	struct tipc_net *tn;
>
>+	spin_lock_bh(&ub->rcast_lock);
> 	list_for_each_entry_safe(rcast, tmp, &ub->rcast.list, list) {
> 		list_del_rcu(&rcast->list);
> 		call_rcu_hurry(&rcast->rcu, rcast_free_rcu);
> 	}
>+	spin_unlock_bh(&ub->rcast_lock);
>
> 	tn =3D tipc_net(sock_net(ub->sk));
>
>--
>2.43.0


