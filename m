Return-Path: <netdev+bounces-307729-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y+oiLu5gV2r1KgEAu9opvQ
	(envelope-from <netdev+bounces-307729-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 12:29:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 494B675CFFD
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 12:29:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=est.tech header.s=selector1 header.b=LCKNLgYc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307729-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307729-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B31333011358
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 10:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4584F44163E;
	Wed, 15 Jul 2026 10:29:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013015.outbound.protection.outlook.com [52.101.83.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B38441636;
	Wed, 15 Jul 2026 10:28:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784111340; cv=fail; b=AUx1lmfiRcA83RcyB2mjKJUPKw/dIVLjE/9YaoqFCup8tvKBODq2if4squKGFoTsp5546UtoQndBaR69FpbMZAQbaztV9lCVlr5EQx1q1V0QLxJc8sLRZSsBzqzfxMNoFAZkduwbx+jjuAqwfDlqqxl8/zd7bNnCeeS/DWnK5eY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784111340; c=relaxed/simple;
	bh=aP631H1H1qeAsZyLcbdvNCHnlcEVt13q6yaV9xCkLxI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RQ00YADeO3oIh/OwgMeDQBBK+g3T8YqyOBA6L//1rJa9ugTgvO2Dba/kXjmYNyAwUuxgQBpeKOaO+/o7QmWzI9EuV1iA1/Y8RYivNrdnhn1lCN9i8FnRFAHbLPC5NdN6m7NnJheSJ3s3MpB2FjnGDshsbzuoV7p342KWLdFQ7S4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=LCKNLgYc; arc=fail smtp.client-ip=52.101.83.15
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=slL8eXvJIeDeHjzCfCOwxgwQtYi5bJs7kJpo/o8sLh9b7E4yQUihC/yJwc5bf2vkYWwQwF601AkZ3CXAvZgWDl7sCRZFoYGNRp/i1qxfxDqrWDoOC65nCrI9eFu0NpYl5eH+0WGXzioS1F/A2rKVXWg4yghJQIB5Gym7t2/TrABOdbKWmYCxlCcH6NoReCHpKPsBTwgHrquHLl3JJ2cahT48nr9Q870x5P9T30zMc7oxn/gU9DjgdOkCXdQc/Noej6/dFco0c3l63MdY2OAnWFQkAOcgSzpz9KYNIg+TujsTjLWryWjV0YPuVf6ebbhoWobq0SBRgC7odqtVhzpfXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0c3/3i5SoWEwl3C2VSK7cUh3wN0X5XwgXItwHY5iHzI=;
 b=t4rl9IlYGrBeJ9pPXNQkQ0w7kZ6y3Jc6DbziUQLCkeh9Z/+ozJRrZ6VuBdJ9/lc0pPN/sHw7a1q71Sk0UcTsZiUVEYzd3uv8WNWq/OT5hThLDMUAHkOJ03upDE5n/TwDFuyj6lsnLXjbloP6o3CX5vs6rp9HONZWP1X+HeraUVsgY0hjFS1sr73rpBvRlX+YLHuBBAB0R9hT/WJgnVZDME2vfmyJeRdent8I2pPs0x9bVE96k+4Gg3Y4GkR3cry+JuYGRvfNcvgUysq/hw94BWCDXeVKWEUC14k6m3JvtwEd2QG+ojYNSSfor1bwJI8G04Wn7y5Ox0gFp9JYUAU8eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0c3/3i5SoWEwl3C2VSK7cUh3wN0X5XwgXItwHY5iHzI=;
 b=LCKNLgYcdgrJQMOfOzn/kn4W1AzO3V7nMBhTeNqeJxd6x6Jy5qoL0QlQ/qQ4LKWdR5lPdF7yKhReP/Mno0jDrXq8U1ixtfWrvGh9e9boo1PWXgozSoBhM/2YlLjO7ZOJqZPLMMM6C9bE2L5ki+v6OH4mvAlb/RiyNT8mOl3aFRT3JhnQNjfL6AsRdO2+mx17G/CQFyrZ3CpDxSxEGxkrQQc5kWuYlTM3n8GR/yrQN3sp2gjzVCZKdVnhq+72ENF7u6Zn+WtbdVy830nYksyx5Fp5UOsg8ymyW0Mk6feonZNzmZErL1Jm/1h7NQNYTICgmOT5RjbSMG4tCBMfspmb6Q==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 VI0P189MB2799.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:258::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.11; Wed, 15 Jul 2026 10:28:53 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0245.002; Wed, 15 Jul 2026
 10:28:52 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: David Lee <david.lee@trailofbits.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Richard Alpe
	<richard.alpe@ericsson.com>, Jon Maloy <jmaloy@redhat.com>, Dominik
 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] tipc: prevent node timer rearm after peer removal
Thread-Topic: [PATCH net] tipc: prevent node timer rearm after peer removal
Thread-Index: AQHdE19LgAL2DGfLhkun7Hsd+49mpbZuYhUQ
Date: Wed, 15 Jul 2026 10:28:52 +0000
Message-ID:
 <GV1P189MB198888979057CD9C64118B1BC6F82@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260714070611.1700456-1-david.lee@trailofbits.com>
In-Reply-To: <20260714070611.1700456-1-david.lee@trailofbits.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|VI0P189MB2799:EE_
x-ms-office365-filtering-correlation-id: 7a140ad7-1993-4c30-71d2-08dee25bddea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|56012099006|22082099003|18002099003|10063799003|11063799006|6133799003|10067099003|38070700021;
x-microsoft-antispam-message-info:
 I4aY1BFQI8khAs9EMUIRRroJOvHN17dGYYg4A0C/z9Y5mK0Fd86Dee8ykHPyC0OyJZKkFZvab+U00iVlA48+53Ksk/8QOUjvOAf+qU8tf0320GroELg4kO2CKBGTyTFd1mlA20+oClFCVQmrhaVXuJM0apdLwSCVDnG+EXvKNhwBLgKFNA8SNyTqV/j2NYWPL5MKOHAAOQnxGzkd0NeIOj/jxZgEzdN2xX7WR0QM65fY+llnkLRRl3mffwLg8RKOXGJqD1xf2UkzIJncZQDnWkg5aBSYTY+zUZRGkElDPRsp2epo6ANLC+L3/htlUsPwpu7IQ3VQRwBm6fKQwqzbr5FwS0YtH9WYezIzqGGIrPNAKMlJ6+Kp15tDBsjZn0cXJEEM+5LqKYf8SRUAYoCBARY4fFB/YR9+RhkgjEBP6A3gui7Qbr2aDA2ucTKt+N12e/FcMveVX/soYOncp5YE6ruoGQ93qtVynSX+jqbvjczllNyy4MvDM/LU/WBR9J5IjAw6DlYPBi5ZjA1xDbQeKDQ5AFFdKfXRFDtNXf1xPGz1arAhn05jkIQc0Wu+NH6hk7Lz3V699IpcBXZGz4gQIwg6UOME4WeZExXC+Mufu9WfcAH/ty1kC6LjBZ4HgJqB5xQ6PJIo4ravLaw3PRM473iVkq9O/4mnwVUMPKmOFUXwkFhSjO1D5rDBBQiUBmacdqN6hbic7aM0WVHY3ZiTIB4UNRcSs04KL0TsGXNaN6s=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(56012099006)(22082099003)(18002099003)(10063799003)(11063799006)(6133799003)(10067099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?z8gkmgXsZRNZFAb9wJKlS4xgnhkhBDPrulTuXF2AlTKZFGgSxWs1flKKcXQC?=
 =?us-ascii?Q?h0a8rz70tMdwhlz4txmluE51J3ej0620VAzaxkPqxVEPVUJc2ndT6xMxKFBT?=
 =?us-ascii?Q?+/KqczvGRDHKxZTnXwheRUX35oXehvSDzk2Zw1LAADbwCgEjawNBKSXjYfV8?=
 =?us-ascii?Q?hCPwNtr0/S36OLqDmluNU/MHwKgZddlNT1xhOJV/ksFxB8irkdbrhVO+LhSU?=
 =?us-ascii?Q?B1fP5zl5/wUVBHehFO66ReFD2FhYNoO9XwCsulVBDEFwQZPCIMCLUlQYeDQU?=
 =?us-ascii?Q?qN92AJrVxuAj38X9tzn2CDfjk31h7/6aO2Oy+yGnXwxzKsckOEDzV1UdzJJ+?=
 =?us-ascii?Q?H0DikNyPHN16qhbGlGysSuKH6ccnropfse0ljEJjhhIvtFOOTlsXq4eTU6qW?=
 =?us-ascii?Q?ksp5qQ8Qh9i4m49GPyrFKrY/aG1AE/s2GLlfYUn8ui6/KLoPo3rXdkYcagzn?=
 =?us-ascii?Q?rbC/28cqcArzhEPsgpay2mAnGwYZAYeLIRFeIa6r3PueWvJbZ32jmiry4ghE?=
 =?us-ascii?Q?sn/UXWHDywInfSL/m8tZgh6Rg/XO2D+wij0tsTlTfJ0+bnLDSU1ocmPpd76c?=
 =?us-ascii?Q?87Gx4eoaAVCxL7B1RJQWGmAPrlwwsj1oQ8mKdQoMjLkHTDr6I8uv4O1luGNZ?=
 =?us-ascii?Q?NwoRDdUwkK1iZIgNJmqjE1gm+rv5xbPVLIOSwRllGaesQj/kXMD6ZfxnufHN?=
 =?us-ascii?Q?gbF1qY9sLOGcLPFRaYIl/t4qHcaw45i2u9ejJkUVvy2MfRD6QvyaVGisO3gm?=
 =?us-ascii?Q?51gLwjLGHFTRnOJ+wUz0uDA3vV6I9UMrq8/1/Y4s2zP5oRaQ2Wf5TiVW74W9?=
 =?us-ascii?Q?wO7ImLd4K02A5ltPO8EkFJxWjIVrg9ZAlZfoVCNKDDx6EwbAO134vHIZ5svt?=
 =?us-ascii?Q?l6Od5c0vrL0VGYkP2mHF67RiDHleYp2ewZz2hWCZtnlCMhPeNZ76ToHNENIK?=
 =?us-ascii?Q?voUbh/hitLeCeQU7l5LG61E0rQcxhNrJuigQsmv1/XVlmoRO7/8+BNnVRU3D?=
 =?us-ascii?Q?E6C9iK84O4Kxwjmjqd8qk73wQcLX2unYk86NrW/Uu5zT/YP/bps9no893y7j?=
 =?us-ascii?Q?OiSX+OSo3r9hUsEweueFA8Vas0xzF/kWCCyJ+TFowDDEjVNIp0CHEgZ0knp3?=
 =?us-ascii?Q?zzCSgpUH1rW5aY1S4WjDbkAvVeB99itrCJjckMVoUp77tQ5xoYOejI0lmxMR?=
 =?us-ascii?Q?MKaRwMKWek6jGUW5cvo9pgHk+bC97aydKd3zn1ma1T8FPYHulwoeRPAZPOOL?=
 =?us-ascii?Q?D6Vv+S19nuXTG6pRl4SZQNYDO4hWXjJ2UnkNtSH0eywfVoSYEN3ngyMel2sX?=
 =?us-ascii?Q?Gvw6GsuCsK2YBj2nFOmhUSe2YZ91TIxiiPdb1CI5JhDayUOvWPzJp7KWeorc?=
 =?us-ascii?Q?sDuOHYTYb2ZBMI3IjXRklOqeLnaaVW6pYj6KvdJEpHs2B6y1Xi3jjzSfGHKh?=
 =?us-ascii?Q?BEFpdUAXwNmYp/ACpgduN92xBwt0iDUB60+l2w2vZd5VMiISPhhD9QFypYIH?=
 =?us-ascii?Q?ICSAwaFZbQ39H9W2JvH7i/2KyAMQ/fh5ZLmK4+902Id/rsTnF4SNiC7s6TOt?=
 =?us-ascii?Q?iomvgDSYDoeBuPaLaU2QHYYjEKzJGD5w0nbJ4oTaPkPiKPfw6e7TK/v9dAoU?=
 =?us-ascii?Q?7ixsjcdA1PfEJQbk9GOPbpRe7zkOQbH4Cr0nA2HPcu8a4gIjlQJxcd7f5sys?=
 =?us-ascii?Q?2X1PEFaaIarVKU+jVLGYupyWN+NivenwGkUuvmmg5DbEC9m3JUfV+kK4vbhk?=
 =?us-ascii?Q?WNtaiMr78Q=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a140ad7-1993-4c30-71d2-08dee25bddea
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 10:28:52.5777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zTSqFZYMkdaHC9f2ee5a6EHbGW+deAx2L2x4U7CWSZFprUMXIS1XfsBtfhycagOoNWuQDEj1GnfDKESouVXb2lTmrF6L9o0qcTVPg79+lSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P189MB2799
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307729-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[est.tech];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:david.lee@trailofbits.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:richard.alpe@ericsson.com,m:jmaloy@redhat.com,m:dominik.czarnota@trailofbits.com,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[est.tech:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,trailofbits.com:email,est.tech:from_mime,est.tech:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 494B675CFFD

>Subject: [PATCH net] tipc: prevent node timer rearm after peer removal
>
>TIPC node deletion removes the node from lookup tables, calls
>timer_delete_sync(), and drops the timer reference.  This stops an already
>running timer callback, but it does not prevent another racing path from
>rearming the same timer after deletion has started.
>
>Synthetic UDP discovery can race TIPC_NL_PEER_REMOVE and link property
>updates.  When discovery recreates the first link, tipc_node_check_dest() =
calls
>mod_timer() and retakes the timer reference.  If that happens after
>tipc_node_delete() has deleted the timer, the orphaned timer can later run
>after network namespace teardown has freed the per-net TIPC state and
>broadcast link.
>
>Use timer_shutdown_sync() when deleting a node.  Shutdown has the same
>synchronization effect as timer_delete_sync(), and also prevents future
>rearming through mod_timer().
>
>Fixes: b34040227be7 ("tipc: add peer removal functionality")
>Signed-off-by: David Lee <david.lee@trailofbits.com>
>Assisted-by: Codex:gpt-5.5
>---
>Trail of Bits has a reproducer for this bug demonstrating Kernel Panic whi=
ch can
>be shared further if needed.
>
> net/tipc/node.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/tipc/node.c b/net/tipc/node.c index
>262b39ecf5f8..5b3ee44347be 100644
>--- a/net/tipc/node.c
>+++ b/net/tipc/node.c
>@@ -638,7 +638,7 @@ static void tipc_node_delete(struct tipc_node *node)
> 	trace_tipc_node_delete(node, true, " ");
> 	tipc_node_delete_from_list(node);
>
>-	timer_delete_sync(&node->timer);
>+	timer_shutdown_sync(&node->timer);
=20
sashiko reports:

Could this regression introduce a permanent memory leak of the tipc_node=20
structure if it races with tipc_node_check_dest()?
If thread A deletes a node and shuts down the timer, and thread B=20
concurrently processes a UDP discovery packet and calls=20
tipc_node_check_dest(), thread B might execute this sequence:
    if (!mod_timer(&n->timer, intv))
        tipc_node_get(n);
Since the timer is shut down, mod_timer() silently discards the operation,
does not enqueue the timer, and returns 0. Thread B then calls=20
tipc_node_get() expecting the timer callback to eventually execute and drop
the reference.
Because the timer is shut down and will never fire, tipc_node_timeout()=20
will never execute to drop this reference, leaking the unlinked node=20
permanently.

> 	tipc_node_put(node);
> }
>
>--
>2.43.0
>


