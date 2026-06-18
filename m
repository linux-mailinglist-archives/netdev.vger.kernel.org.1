Return-Path: <netdev+bounces-300360-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PZoBHPKxM2qnFAYAu9opvQ
	(envelope-from <netdev+bounces-300360-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:53:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEBB69E9DB
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:53:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=est.tech header.s=selector1 header.b=F70vupDP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300360-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300360-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1013130046A8
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 08:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8913B4E94;
	Thu, 18 Jun 2026 08:45:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013050.outbound.protection.outlook.com [40.107.162.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFF93385B2;
	Thu, 18 Jun 2026 08:45:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781772325; cv=fail; b=RB4c8BhEyohTAp8Oa2zjdAmhE3NVQ4vBEHpSE1IRsp6Msx6L8DrFg1mKvMjEQNuqvoFcxugvVStQsdzFVttLDA8NR8bahmmPwa9DkQwmraqDB/BIpkprgIAj2u7Yj+5/VBLrrVAsps1ublljOIa7rsW1WsF1r+ITq9fznJn7k8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781772325; c=relaxed/simple;
	bh=S6y2NFaTcEQBSrYKIrFl+7K09+d+UwdFfM+bYr/84Cc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VKHpkKx3euRRw+KbhoCCEvw7AuwAfGnmd7CK6LNy5pFdMHiGE5VRq07bjksv7jdTSqXUZ7DhjjL15qBRG+rvK9rAEJ3gPCkBmgXYetp8ERihLoDslxvDdD7dWstcP/L/YTknwuqdMK1m/9aLb0RGNVwQLm0byvgDGMrphs5evbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=F70vupDP; arc=fail smtp.client-ip=40.107.162.50
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ic8ZZS/JdMJVKoT3SXIb5Qu2EZk2jMLRSZnWRiQ69/5eVGUiKeWBHCWlisrL9N3fzNWdwbhkeOv8cl2z2WQWei1yQzmSDDfIoix/x14ZYmLcOLtCvdBkmgVQOO8KOFQ/Nr8cuvpaZj2Ih8lMr0UvOAzoCetZKg7KexjQUb01YjN7F6rslsRLy54kiYM+AkaJrmaRP9TzexuDCYNghUSX8yUlntMKVnXhXaxEuH/v/UATaV0HDD3Ftzc1ImqrsltsKPiXa+MXtRLgl6Y65gMTaLJA+s4nEfvdJbZsECQ+376tebHTDovcCqAmV72TPx4lbqpZZbCyjvTPbsxk5/LYQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRU1kjrNc+VDy7bhTKAx0tY1QSD/aN6c59LB4hW9H5k=;
 b=I4+P8bVBXbaw3ygB0ffCk8Wj8aSz0cxSt1AXrwzGWacbDb/vjpJiHI4xaQLx805PaLcs8Zi3XwNCAVibXy/5fTvELEN2dt2mvV5GIkF1eNRALAIbXB2L/Dxd11FiDsi6S1OG9J8SSk4u+RzAs7QIkgugvyODXMWCKnOK5ixx/Jke4j4+9oHN8lSmUCEea9gx77fr7SyJi4F1/8JR2y8W5pSOrJf8HpX0N7UqIUH28oGZmEEmJVk2D53f7TTNpcgBE39QaoALChoKsvL7ItWNafy8kiX7gXj+rD8TExxhDwy7MLlDlZuXtnu5E2J4IGtA2YUdOAHwbQzkiwqTAd3yJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRU1kjrNc+VDy7bhTKAx0tY1QSD/aN6c59LB4hW9H5k=;
 b=F70vupDPGLAUbMsdbUEVUbrur0q1s81lniXJ3kwpjpavCe5ZgLn9HbKKsXZUhOT9M6G/ILbmB86fPLhi9oeUyvS0G8qoX/9HXCZkcITAhEerQe1cGbhxUCHXnK5QrWqnOky314kJs+qWX2b2f1h0L3EcPpopx6KEDzF7gSqk5CEbeLA4rARt1CLKW9aObnx6QW96R1Lwm4dS+GkJl/Zic0IG+K/1Kc/RMZMDhwdRhW/NBXiATfctY+9pcspG0zd35tqFE3VExSrEICHIGcAOg/CCJ05Tr35IpeBmfoTBTeDbe0caNfJDOG9rHXI9T17szCFGqzM8MrLNQIC6EEbzlg==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 DU2PPFBA933CD6B.EURP189.PROD.OUTLOOK.COM (2603:10a6:18:3::aa1) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.11; Thu, 18 Jun 2026 08:45:18 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 08:45:18 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Weiming Shi <bestswngs@gmail.com>
CC: Simon Horman <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Xiang Mei <xmei5@asu.edu>, Jon Maloy
	<jmaloy@redhat.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
Subject: RE: [PATCH net v3] tipc: fix use-after-free of the discoverer in
 tipc_disc_rcv()
Thread-Topic: [PATCH net v3] tipc: fix use-after-free of the discoverer in
 tipc_disc_rcv()
Thread-Index: AQHc/mG778NGJTQ9aEGmBcXEp0hTxLZEAGbQ
Date: Thu, 18 Jun 2026 08:45:18 +0000
Message-ID:
 <GV1P189MB19885A51CB153EBAA966184EC6E32@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260617135744.3383175-3-bestswngs@gmail.com>
In-Reply-To: <20260617135744.3383175-3-bestswngs@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|DU2PPFBA933CD6B:EE_
x-ms-office365-filtering-correlation-id: ada551ef-c13a-4ae8-8706-08decd15ecc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|56012099006|11063799006|5023799004|6133799003|22082099003|18002099003|3023799007|38070700021;
x-microsoft-antispam-message-info:
 YEK+6Dy+UeMLrZSznMiJrzUcc9CMDJgkGGVGajO09Pcxpcq6XonLT/AlQQv0KQ9GeXKuVkFD1xk9IntW4RcEwMYI6x+2HWelVyBaFhA9BqMUhESY5HQJhS6fD8r2BywmQe8W8lZfp1YhQ4+N9mX0NZIhOJlzDERvc99O/lyRAuDZ2JnxISdik96gjFhPywwIShCI2YrDXz1Tjd4VXTpyZ6n9lm9Ro42WOfewNqDEHd67GFzjn7Af+jp5cDdG8ZMOaTdJYUq0dct8u56GExFc+8ZABCC4lNrO5Qm0Y7RjkrFVDLh2DIyMILFONY8AECJcRNY1WFhklG2nAqdl/xIVzZCNE5bVhXb2wxGrRefvNGxaNqvh2iFTnILmJDJpaSFKiMiWwawg7f7su1lV7oG4PxC83yPyt3jbgZ04vUsecHJRZAGUMRnx3wEJv27abyz9mWqfH5KGfKRsIiOy2MhQhSecQzbBhKrXin/vYur8Ta9mUZf4enqFtBOU8uiSg2zcbDsBYDnub3gNLJTvseY+QWrwILWeOVkgZYGzerJjxXewKwNklndBAMKlasNyOtjoCLUuPYL8MIlvk7Ya4fOFotMkPRzfdCwyjYLAJEHvPnF9FywWeCBJVh1CzK+4aJQMKmqnlitaHvwEb3PFfupwhFkjc2/UGxLjW6YReMNcdIyidJRHIqFuKplt82gEDccyZA8FVfQqXIKwd9BfcuUO6jFxYr5qCS7nPDab241MfweoU1wo3K0rF1AP1ZBM9r5S
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(56012099006)(11063799006)(5023799004)(6133799003)(22082099003)(18002099003)(3023799007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?r2eLV9ARW1cESw/4J0oq6bg+HjIblh16qEBI8SJhIS66t65ogNO2hHKKW3oS?=
 =?us-ascii?Q?2NXjnnr1WNsZPCGvYbjZvqQi4xzWo3NSD4hZd+G/LLiNHm5vJA9dVzSzDIL6?=
 =?us-ascii?Q?358IBtpQO3aonXvOFSzlqlh6SbSw1ZGDnbMNGOAyYTKubXKmA6Z20g4de9/q?=
 =?us-ascii?Q?y6IkDS9C3V3kDgtX02EheRMf7DRtZmkee8JsXdAi12yamKORM3+AQNgR0PNN?=
 =?us-ascii?Q?U9TivTzNDYrL3p3uh129QfTgFhmBsh9B88P7zC3LE+5vS+YythfZogHmeZuu?=
 =?us-ascii?Q?Wd/XEHSdFrIEBAf6IyNRDwXZ7qi42WO5EB+DyizC+FjdGL2BUe4x4rO/dML3?=
 =?us-ascii?Q?vrWEhZZw4C/iOWMrbhDG89RSPY4MbNbq6fVBqe6MB5LNkfBPE8+01KnrkUb5?=
 =?us-ascii?Q?vUcQ0i+xzCFE/FlLJBPnwAROPhrQfGo+lcNRifLLEmLOOmtG+NIRkPN8DJ00?=
 =?us-ascii?Q?lpbq6EiVLaI1VD0eSYo34YX/Pi5cp0jdW1rBgmcwJuQ9ks+qjfJfoC9RbMS5?=
 =?us-ascii?Q?s7PGqQrd7Qk6VREv8PUxb+iEDfIXAT/XL17tpun46OFSsTrofVQWL/6YGU4D?=
 =?us-ascii?Q?hC0V/DGKkaE6b4RUZsJg4b5HgM9AJBX3U86ixBsZfhG09w9/6yi2AzJSjHst?=
 =?us-ascii?Q?59nXy9TiaH5F5Xh64cjs1FlsN2OHrJcl+mjatuWTkmorgOy6m3bux78NpH6D?=
 =?us-ascii?Q?vsQq0ZGbR4F6d2XAYy6HiIW7yJbrbYwqdQTCnHHtY49pY3TE7tndHFrQ/5OS?=
 =?us-ascii?Q?snz8hH04TkvpOV/pFaSqD4CtQGIVDAI5tuusfig9oVDVeDTcpGVJMJ0HBxH8?=
 =?us-ascii?Q?2n//C/ExneFidA+RxuWegspiEVb36LalLhoXoTFT+sEPPyBcIlddKubJY+1F?=
 =?us-ascii?Q?VxWkKZHaKlvoLDSIBTZKg2r4IJRV774aXjZoC1NNPKOdVEKnFjfs3DFJStU9?=
 =?us-ascii?Q?Z2hQQ73XZfpEL19W1WvrKHvdJVdkJiqA8gSPsviBDZZ153uhrih0+X0+kz32?=
 =?us-ascii?Q?CNXRp68GNqC4leSE3VT6j/YUC0VdNP67BJxqzTesxaFb0becs6CdGUwv6mFB?=
 =?us-ascii?Q?BGGivRi8cRef4iVwkPWpUItn7VLlwCPDwK68qVeTFDWabfQnaBZF3+f94bW2?=
 =?us-ascii?Q?+I3s3E0EuDJbvMDn4B0U99lwaEsXx1EzKccEcZZLAbYYOeqXEFGyxk3kxzMy?=
 =?us-ascii?Q?8UKzwBjnidoMMtvqjsiOJXqqJhjOs5MV6CVl8JnBqzQms+zOhRBahOUqKhYi?=
 =?us-ascii?Q?4Nv5unOM/vRox2LakKGax49gLeFbUb11lDkm7x+nviso2qmYaDWIg8vazohO?=
 =?us-ascii?Q?vzYjmWcRrKjAF/ClZ4TVSWGVr1JY8iCELzBcctiN0O3eZ/o02YY9Qm1pMomp?=
 =?us-ascii?Q?i7i6Z4ByCCdGaTgH+5wnIoilhsvbM9+DpxwBGkF7ux6t8IZjt0EisDGQ127z?=
 =?us-ascii?Q?4yo1MSmAvqjuc4DZzsBT98fXXdxfYm/TZtaLRVDy5TSKcShA/QY7Cd5Utl4r?=
 =?us-ascii?Q?SfdXHqkT/bG7t0URBFVXNANfzWH7Ta9+poVTVKIxJTjKjR8yzpw+cJoGjgEV?=
 =?us-ascii?Q?0mTJvn4qN/ecqKqz9mD9bXza33I9Daw+IooQ6ZglJryE8cp3xfM9UkfXTQFs?=
 =?us-ascii?Q?FzT0BTYcmpFSZ7YQTyLbd033yFATkpicFOmnPKoW2BB6gX+I2HjHvW6T/Dfm?=
 =?us-ascii?Q?tdDixZvZzrHZppnAJzsjmVvBzBSrYkpAMLac8ag04T6mc8q/GvHY6mn8qSVC?=
 =?us-ascii?Q?0FBhYBbViw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ada551ef-c13a-4ae8-8706-08decd15ecc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2026 08:45:18.3079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NvgNJcYiLN8NPqy8bC4IYk9dD+XSIDp2WhmBhcdFenBvp9he6NwLpR4QeKFR/df/8xuP7YYLfVyPL93rtlwIOES0wjMcuCIsFymfDnaEJ58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PPFBA933CD6B
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:bestswngs@gmail.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:xmei5@asu.edu,m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[est.tech];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-300360-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,asu.edu:email,GV1P189MB1988.EURP189.PROD.OUTLOOK.COM:mid,est.tech:dkim,est.tech:email,est.tech:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6DEBB69E9DB

>Subject: [PATCH net v3] tipc: fix use-after-free of the discoverer in
>tipc_disc_rcv()
>
>bearer_disable() frees b->disc with tipc_disc_delete()'s plain kfree(), bu=
t
>tipc_disc_rcv() still dereferences b->disc in RX softirq under
>rcu_read_lock() (tipc_udp_recv -> tipc_rcv -> tipc_disc_rcv).
>
>L2 bearers are safe thanks to the synchronize_net() in tipc_disable_l2_med=
ia(),
>but the UDP bearer defers that call to the
>cleanup_bearer() workqueue, so the discoverer is freed with no grace
>period:
>
> BUG: KASAN: slab-use-after-free in tipc_disc_rcv (net/tipc/discover.c:149=
)
>Read of size 8 at addr ffff88802348b728 by task poc_tipc/184  <IRQ>
>  tipc_disc_rcv (net/tipc/discover.c:149)
>  tipc_rcv (net/tipc/node.c:2126)
>  tipc_udp_recv (net/tipc/udp_media.c:391)
>  udp_rcv (net/ipv4/udp.c:2643)
>  ip_local_deliver_finish (net/ipv4/ip_input.c:241)  </IRQ>  Freed by task=
 181:
>  kfree (mm/slub.c:6565)
>  bearer_disable (net/tipc/bearer.c:418)
>  tipc_nl_bearer_disable (net/tipc/bearer.c:1001)
>
>The bearer is freed with kfree_rcu(); free the discoverer the same way.
>Add an rcu_head to struct tipc_discoverer and free it and its skb from an =
RCU
>callback.
>
>Because the RCU callback (tipc_disc_free_rcu) lives in module text, a
>call_rcu() that is still pending when the tipc module is unloaded would in=
voke a
>freed function. Add an rcu_barrier() to tipc_exit() after the bearer subsy=
stem
>has been torn down, so all pending discoverer callbacks have run before th=
e
>module text goes away.
>
>Reachable from an unprivileged user namespace: the TIPCv2 genl family is
>netnsok and its bearer commands have no GENL_ADMIN_PERM. Needs
>CONFIG_TIPC and CONFIG_TIPC_MEDIA_UDP.
>
>Fixes: 25b0b9c4e835 ("tipc: handle collisions of 32-bit node address hash
>values")
>Reported-by: Xiang Mei <xmei5@asu.edu>
>Assisted-by: Claude:claude-opus-4-8
>Signed-off-by: Weiming Shi <bestswngs@gmail.com>
>---
>v3:
> - Reword the rcu_barrier() comment as a TODO (Tung Quang Nguyen).
>v2:
> - split the over-80-column container_of() line (Tung Quang Nguyen)
> - add rcu_barrier() to tipc_exit() so a pending call_rcu() cannot fire
>   into freed module text after rmmod (Eric Dumazet)
>
> net/tipc/core.c     |  5 +++++
> net/tipc/discover.c | 14 ++++++++++++--
> 2 files changed, 17 insertions(+), 2 deletions(-)
>
>diff --git a/net/tipc/core.c b/net/tipc/core.c index
>434e70eabe08..1ddecea1df6e 100644
>--- a/net/tipc/core.c
>+++ b/net/tipc/core.c
>@@ -218,6 +218,11 @@ static void __exit tipc_exit(void)
> 	unregister_pernet_device(&tipc_net_ops);
> 	tipc_unregister_sysctl();
>
>+	/* TODO: Wait for all timers that called call_rcu() to finish before
>+	 * calling rcu_barrier().
>+	 */
>+	rcu_barrier();
>+
> 	pr_info("Deactivated\n");
> }
>
>diff --git a/net/tipc/discover.c b/net/tipc/discover.c index
>3e54d2df5683..b9d06595b067 100644
>--- a/net/tipc/discover.c
>+++ b/net/tipc/discover.c
>@@ -58,6 +58,7 @@
>  * @skb: request message to be (repeatedly) sent
>  * @timer: timer governing period between requests
>  * @timer_intv: current interval between requests (in ms)
>+ * @rcu: RCU head for deferred freeing
>  */
> struct tipc_discoverer {
> 	u32 bearer_id;
>@@ -69,6 +70,7 @@ struct tipc_discoverer {
> 	struct sk_buff *skb;
> 	struct timer_list timer;
> 	unsigned long timer_intv;
>+	struct rcu_head rcu;
> };
>
> /**
>@@ -382,6 +384,15 @@ int tipc_disc_create(struct net *net, struct tipc_bea=
rer
>*b,
> 	return 0;
> }
>
>+static void tipc_disc_free_rcu(struct rcu_head *rp) {
>+	struct tipc_discoverer *d =3D container_of(rp, struct tipc_discoverer,
>+						 rcu);
>+
>+	kfree_skb(d->skb);
>+	kfree(d);
>+}
>+
> /**
>  * tipc_disc_delete - destroy object sending periodic link setup requests
>  * @d: ptr to link dest structure
>@@ -389,8 +400,7 @@ int tipc_disc_create(struct net *net, struct tipc_bear=
er
>*b,  void tipc_disc_delete(struct tipc_discoverer *d)  {
> 	timer_shutdown_sync(&d->timer);
>-	kfree_skb(d->skb);
>-	kfree(d);
>+	call_rcu(&d->rcu, tipc_disc_free_rcu);
> }
>
> /**
>--
>2.43.0
>

Reviewed-by: Tung Nguyen <tung.quang.nguyen@est.tech>

