Return-Path: <netdev+bounces-297903-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LrDvFTwiKmqEjAMAu9opvQ
	(envelope-from <netdev+bounces-297903-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:49:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BB466DE0E
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:49:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=est.tech header.s=selector1 header.b=js5KZnHk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297903-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297903-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 52CA03010932
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 02:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB40723393C;
	Thu, 11 Jun 2026 02:49:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011044.outbound.protection.outlook.com [40.107.130.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0AE1A3164;
	Thu, 11 Jun 2026 02:49:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781146168; cv=fail; b=B+DNW2txRYT1ob2V1xU5yKj+3HkmUwl9FgsHM5DgYXUaMM+aTPlm5hge8pPWz0p4T8fssIQAuPupngUbPxfKDZUHVziZQ0yLiuttcJfWp1xivjYXvWPk9CPBV1Lgsxe3dCDQBKrU+5MMMy7TSPNAFE4RC3uSZ2PWOu+eKsChQrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781146168; c=relaxed/simple;
	bh=xStbnq4CcFswECPY+xSZfGE3SSkoAgEj+qcJ8d7Ig04=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LNfMBvWsU5WVWfGNH8XboUY8DV36SDR+qUvPeJeQseiV6ZZ5328kOuZ/erkTQ+ikTe7R/N41iPeCfEHbaLRE+6Dt3LGZ3RHoQDSA3mqYHmVLT361+HQq8pzpWGW176JOSoboUgOJNraF5k6j8EQSVprg5DoWvHlfAslTAS2ZkSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=js5KZnHk; arc=fail smtp.client-ip=40.107.130.44
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d14FBg0Uku8IppZpSP95YAbu8TLoZssSPIjjdgCqyZXTVvbzCiEMeW8cV3DvHTiYhDtKkIknIO/1cB/UWC6ZTO2EpnJmsOIaLE1B0/TUBboQAEJoS6ekdahAXcIIBQfAHBY/fs3PWP8LJZpKG4D0fMZvZVRbz0xxvfIddIbAMGsvcGnOvDVCDB4mSOQzw0luoRenfi2urQ4q57IFp1KZ/RB8MnsN5kNa9FcS/xL854lAYEHBuymkKrqWoQzpIyR8xJGCpFDhn5bUJRoWPIy1O6pEZyCIwojqCxtwxDZZWMC8N4DV5xb96BxXb6e7APh/Btnzt8GgMCXaHg4FqXZkEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfUQs01MztCdwJZXKdS7/acxyuhU5nseedXkSpTYXb8=;
 b=KRXFc+ev4MHd+4TaoxajTIYVmByVtoNL7MMtnUgaa0t9PDixqdeHYZXTuVdU/so+aguhJ9jOEr//U61IiCOkvgAhPMIJ+yS4jQkz0yOgxKtHvydDxRKepM9WjYNQI9KRqoIruu0AFWSOeL7b2asHUyQDQBf+ImTsIvCjOlcu+ohYh3kDJIXzykVT5F85MzJdDhGzO+336r0D/fsLZuF266ia5tHPK1Rfgkr39ZSu0FMEPbus58bLEbKKyCWsZVYCrNddYH4pOgbWjXQPm5dODkvEMsvsRW66LE51TeOOz2SmY12abb6nevEDSZKxxlObdBATXBkaxusfGAt3DB4lgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfUQs01MztCdwJZXKdS7/acxyuhU5nseedXkSpTYXb8=;
 b=js5KZnHkGAeHzf2OP1m5B6RDgBruKwpOmRxAL4fgh5Yu5SFP7ggJwlV+MITlcQQ4uH6Dx0l4dZkYV3QTw1CGPi/LEG8kVNukoWVWbk3NALuKsE9T7n7o5XMSXJh0bq9KH92r7nJnG3jdWC5p9AvX/fy6mn/OPGjiQ+9RPyubrtYe+x1PNP+iQCT481j8G4b2r2R7iAtqWe+ebKhake9uG5X2JRxctxCtqH5TCTKNB/hEyS5iBdaoVF+3mWaiU4/6HhdAQM+s7V9VaXNMic92ELk4Cm1F/DPDZQgtOM9zScQEq0XXSH/hdLNjbG4FdX5QV5AasWPRzumUeS13rWOnAA==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 MRVP189MB3124.EURP189.PROD.OUTLOOK.COM (2603:10a6:501:5a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.13; Thu, 11 Jun 2026 02:49:23 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 02:49:22 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Michael Bommarito <michael.bommarito@gmail.com>
CC: Simon Horman <horms@kernel.org>, Ying Xue <ying.xue@windriver.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: RE: [PATCH net v4 0/3] tipc: fix netlink gate and receive-path bugs
Thread-Topic: [PATCH net v4 0/3] tipc: fix netlink gate and receive-path bugs
Thread-Index: AQHc+NZGWZLsqtNegU60VA1VJdeFV7Y4p1wQ
Date: Thu, 11 Jun 2026 02:49:22 +0000
Message-ID:
 <GV1P189MB1988B5F6F02AE033CB1F98D4C61B2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260610124003.3831170-1-michael.bommarito@gmail.com>
In-Reply-To: <20260610124003.3831170-1-michael.bommarito@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|MRVP189MB3124:EE_
x-ms-office365-filtering-correlation-id: 9a17212f-61ca-41c1-5404-08dec7640ab4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|38070700021|5023799004|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 cTK+trwM9bVl4MvO1JG+C2E5TVbPWxOG3keqfTE+lSjya7+1VTLFG83ykjvnHvMJ9xgCpbGgI/9c8RrpQbFXz14k8eFdNd1b8cdWdoO2kzOC4/Kn5a2/ZdxxS+k8iBP5/V2zy9JLZ8wNph+vsPbeAQQcxkHOIy5fb1Qu+dOPDkL7sdPkGcvo/FlnstrE8SFjSrdbRBy1E0mfnOnB+dTcpwpB80t8AK2PSEgBArh2SInCnay7M7T1j+unDjio3tiersnk3Uk8fsOk55QKHLEQlZd91BKoEvFS65/RP7pS/EdGQbNGLihVrLBXX7nvkTBasThl0DUijjPsShab17gcbOUsRTp782rlmSvOPbSj0ca3EwgThZkdEQS3rCl8+0tLXmNfbLTEEXmLFmMZ4siXq9VybDCOXTxwPG2WDuqpDE7vskPJ8fdYfwW7k5l8fwi/a+7q/5app/ZWleF0QnSejw6uLtvEMfhNTYhQWTl4PQw+1GzF2gjLXYz4tMZQIJyjuA/6nyd0sgkdnYAkUtRDnzU5i2XKKnSy1yHxyUBdhkIqgYtZsP7FiYKytDa3+dGET3oq7ljgnFKFIHleT6n+Uku4gN+U1ZvhVoLimhM4Bzh33pDy7A6J/f8HVz58zF3svdj9rccYOw5Jy/wtr1tuFmvIezxWsv42YCnTei/EimlJWEs7ovKVTAq8X4ZMR7N1oNBnjI1cb1JRlleLjaK62GYKSQP0U0GnMPNxIQcGxzgvNcYa3e/WYNXPypXGAgfL
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(38070700021)(5023799004)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qHNR5ADN/bXOUpcOXRCOOCVqXEmpRFADnesDj5E4+0vD3uOuozJ5zZuw3Dlw?=
 =?us-ascii?Q?4OlrFmJaq3g18lUXHS2IsR2iIzUVD6yoaO0zAO00C9Qsn3J6Vr5HoEZmvqbN?=
 =?us-ascii?Q?rWy0sqbveHVsrNRNVXef8amaAkzrzbhmL5xxEVtcKpvAeYMm2h6/5WQYKEPQ?=
 =?us-ascii?Q?VeG9CxZuHMRKWC7xp3XsxeC9Cve5agih9sbzRAlA9ClUbJE0p3HekIEX2aZu?=
 =?us-ascii?Q?I2F3xv3NUOVExCZZhb/iqD1mIbHnyohnySYa+UAL6SS2NZqvqD+m74okmqXl?=
 =?us-ascii?Q?1KjkkDIU8SSPLcu2/fakhQ+HDk/6fgwhNFrqkBRtrYb5rYuPdqhJNj+tJ1gq?=
 =?us-ascii?Q?Sr+SoB+nW9g3XdOuFrfI0H1uTj/XREkT2+IBXUQ3XzB/pO4R5X2Q2FZeD7XC?=
 =?us-ascii?Q?O/+hEByU5CAXrO+v0oHdeKrwAOxdM0Fq46qOoiargSH3leG0o00OfqNe/Gl3?=
 =?us-ascii?Q?Z8s6JR7DaDFOguM9okf4Ezx3JSFkT28Zmrl9zbpb2o6HBTQMwEjWI4s4INRT?=
 =?us-ascii?Q?B2lbAtGqMaqjvDYRxVSrnIrBD4OiONiNlC/0cz5YCS+h84iqAzI+dYiDP6t0?=
 =?us-ascii?Q?aCTTDkwMp6Gu7N1E1d+wZHlPohxQB20ofTz3tHRbJroDOa5vH1niHupe3Yf7?=
 =?us-ascii?Q?92IZ6fVyiF6v9GsBtqvDwKQv8FrdgqFaGw4hzV4Vp5YgP/mP4+wp4dPh+aDL?=
 =?us-ascii?Q?MRVQsRLlHoE9CCwn2YpB+3Bg5MSUOPYc+eIxTYZ327y+hv/H+tkY6g1LeCiS?=
 =?us-ascii?Q?jVV/6Ko3c7cFNUuII1arV0oencIiZR3yFuNA/v3S+bcUSyB4FqWrGkDIGczZ?=
 =?us-ascii?Q?AN9wvWjeQYUfHERJMiJKme4evd2Ad0bhyrCcya/RBZGiWf6dhNimA/npH1ir?=
 =?us-ascii?Q?AaF8KrTVwWr6r0oUxS3UX5VnZLB04R6ZTCsIYFBHR+P4h4xytvYETKjqAFtC?=
 =?us-ascii?Q?woGJ3uGB92xQVzAIdXUUvxcEXkMFB+3Fc7pusLsCdt0aE+2C4choYeauD5GX?=
 =?us-ascii?Q?Qt4Dgd5n5vRNqWzJVWUKfpqzzM4Att5FwYSBCb8oLzJQ4D5Q7jXFxmKCogSn?=
 =?us-ascii?Q?xvttK1mI2Jhkj28EHZNviHMCnUpZTwexFrhUePOLhUv+jY/5nIKrBNR3Vtqi?=
 =?us-ascii?Q?WgYU+NRMmYb09f7ZGkkACmV6riN3g6F5a2WIBu1232KXsXEyk8+MPSTNK2fS?=
 =?us-ascii?Q?J5ZGV4SvSTaNl9XEIN3kLZOdtrfcsL28slAB/5bQVcu60Nwz70T8Uh3ZxzhX?=
 =?us-ascii?Q?XCjlhYKRDKmVcCnzTh+z/+iaKcx7u8zdGkZtz+QQMzEzJxNayhncIbacGmkQ?=
 =?us-ascii?Q?6eVh8uVYjb2iWYX/kOhqOnSjinnUajDNFf6b4l8TixV1G0DzsBHrrQ55SyxC?=
 =?us-ascii?Q?Cb08PDRpNUl43gtw6ekViOnHB/Ge1015zu1u1nQ+WIcDda9ggY6GKc9Pmp9P?=
 =?us-ascii?Q?sLSMwD+EeCycV5fqkhlHotigRbqBgF0nE2NkbTdPB2PABPK8NsDXaNf5fpQp?=
 =?us-ascii?Q?JIE3vo9VtRI6Qhmti+eQiC34UacPcGeeJC48MBO7nakDcjd2jzzKYlvdV9xM?=
 =?us-ascii?Q?q8Sz8sfR386gUXgLKPr5ZxK+R6rJRd0+SqrVd5BgmuQfSiNK4tEkB06qgveT?=
 =?us-ascii?Q?buHNvCqRWo+BCVB0AztlOcH8ww8qqtCCBNmIp5jVgXztYGk2zoLxm9jv12A3?=
 =?us-ascii?Q?ST7MsU23EvYcDUIdW3XyzUH1GZI56XYlHtqaSVZrL6tTB75mET+ohoJJZ/VQ?=
 =?us-ascii?Q?ZNmrLoaIuQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a17212f-61ca-41c1-5404-08dec7640ab4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2026 02:49:22.2861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lYeCF75+WGxN5IWkABZnJtwsMcPMJtVZORfsNibdoA/fWaHrNv4GHf2HiBbj4WRH2eDevnvF10ppToNyOW4D79LORAqOufOje1NAVGWI5dY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRVP189MB3124
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297903-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:horms@kernel.org,m:ying.xue@windriver.com,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[est.tech];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[est.tech:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E4BB466DE0E

>Subject: [PATCH net v4 0/3] tipc: fix netlink gate and receive-path bugs
>
>This is v4 of the public TIPC series. The only change from v3 is in patch =
1:
>TIPC_NL_MEDIA_SET now uses GENL_UNS_ADMIN_PERM like the other
>mutators, instead of GENL_ADMIN_PERM, so the whole series uses the
>namespace-aware CAP_NET_ADMIN check that matches the legacy TIPC
>netlink path. Patches 2 and 3 are unchanged.
>
>Patch 1 gives the TIPCv2 mutating generic-netlink operations the admin gat=
e
>the legacy API already has, so a local unprivileged process can no longer
>change TIPC state. Patch 2 drops CONN_ACK messages that acknowledge more
>outstanding sends than exist, preventing the snt_unacked underflow. Patch =
3
>rejects peer bindings with lower > upper, which would otherwise leak bindi=
ng-
>table memory.
>
>Changes in v4:
>
>  - Patch 1: use GENL_UNS_ADMIN_PERM for TIPC_NL_MEDIA_SET as well,
>    rather than GENL_ADMIN_PERM. This keeps the same namespace-aware
>    CAP_NET_ADMIN check that netlink_net_capable() performs on the
>    legacy path, so CAP_NET_ADMIN holders in a non-initial user
>    namespace (containers) keep working (Tung Quang Nguyen).
>
>Changes in v3:
>
>  - Drop the discovery-message length patch; tipc_msg_validate()
>    already rejects the short messages it guarded against (Tung Quang
>    Nguyen).
>  - Patch 2 (snt_unacked): drop the conn_ack local and test
>    tsk->snt_unacked against msg_conn_ack() inline (Tung Quang Nguyen).
>  - Patch 3 (inverted ranges): restructure the declaration block, moving
>    ua below key at the maintainer's request (Tung Quang Nguyen).
>
>Changes in v2:
>
>  - Patch 1 uses GENL_ADMIN_PERM for TIPC_NL_MEDIA_SET and
>    GENL_UNS_ADMIN_PERM for the netns-scoped mutators.
>  - Patch 2 validates msg_conn_ack() at the start of the CONN_ACK block
>    and drops invalid messages instead of capping the value.
>  - Patch 3 reorders the new u32 declarations in reverse-Xmas-tree order.
>
>Michael Bommarito (3):
>  tipc: require net admin for TIPCv2 netlink mutators
>  tipc: prevent snt_unacked underflow on CONN_ACK
>  tipc: reject inverted service ranges from peer bindings
>
> net/tipc/name_distr.c | 13 +++++++++++--
> net/tipc/netlink.c    | 12 ++++++++++++
> net/tipc/socket.c     |  3 +++
> 3 files changed, 26 insertions(+), 2 deletions(-)
>
>--
>2.53.0
For the entire series:

Reviewed-by: Tung Nguyen <tung.quang.nguyen@est.tech>

