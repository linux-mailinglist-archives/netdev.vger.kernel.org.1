Return-Path: <netdev+bounces-300349-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uacUKI6nM2rsEgYAu9opvQ
	(envelope-from <netdev+bounces-300349-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:08:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5A069E568
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:08:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=mi4Qpe4L;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300349-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300349-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B801230151D0
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 08:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F353D9040;
	Thu, 18 Jun 2026 08:08:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013048.outbound.protection.outlook.com [52.101.83.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221D23BE644;
	Thu, 18 Jun 2026 08:08:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781770105; cv=fail; b=uQmS+7bzNVSR4N+x8aHOgPNuapPX1kW+OdPEsxSP52aUyDTsJCtkACjDPeP0n2ckXcutqpNRdFnmg+cP8e2nj/sD39PPaQqV3bDbKgvivFsoww15nkO/vxDfJSjhJ5LsRLbejoqHbnfP4XLDZP5FJ10g8ftCJDJZmu2hfvCg0kY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781770105; c=relaxed/simple;
	bh=YdRVtWmnWfisiMAVZaafPXqh9V6qlCcyvCoazocER2Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZNgz7zWf4FjJvRRLeASKsV+saf0EGgijw1nEuA+kkQlHifpzWIfl50jW9Cmckfr4pPvBF7c0Z0vn19b03t5qKlQLhhXJcAdYhgklgZcBexdU/cXx8E1Vz09MezClpGpd3FbyEnuLu0sEYp7DGOa3Fz/XIFspiw/U07bAvMOnC9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mi4Qpe4L; arc=fail smtp.client-ip=52.101.83.48
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BL+0aW+xy2UsSBLhUmzXWHVdfZp+OX8B/YFKf1IlEmZhR8oHJJ9txTndQKPps8muVMGwMttjzZJFJ/BaRWXieCm8vsrBmEaISpf0uByPCpLrYvq0k8aYFjY5Qx5geOjRBMyveiubYDjyHqNbBYkSt/9jkMxylQ1v4+mI7Hj3d30SdQJmgMLe1JtaTDh4PCHWM3Ldv53jcjYpVWBSm/G1Dwx7MRVkQ4JuPRav2FcBfImhZiLtoEZ1hN5ayhnbyzgXDEKtH7ceVKPXdbLQAtNP8JCMQmExxZ+RyEJE/cMnITxz30eqTwlNVRzrE5DzM+Oej60oTYPJ7ZcTx2URPi3JOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4d2bJBn4kL6Moq1yiPVM80lfft1n0+oPvq0DCGqMPo=;
 b=iLcRkNT/hkkZl5q5miZJt3cfcBRVgMjTOyr+fjEfkrYuFTn8cfMp8dFup28jav09ErLroROGIMAuyqpFgYsq5ge36wGV5Jg/kCmTC/PC/0gqPg/hrqmullNbrIXAe/9MNQUd84VAzm3Se5D2RFjf6w54Oot/8LLKkY8z4uDrUabn4mJ2MqhuwN93QtAXVM8PTd9ROW8Lcbj7qMjyY+EP7Rw1+AhVGvAuY3u49dWgimz96YXxb9l2UTB8Z/Ok4JpvCNsCvpst+WAVQdglW7GagWJOK0KcBidX70Zc5G/hDa/B9ZPmphqJxKb1wnkr0wYwjZnizU7oqTRHmKguaC8hzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4d2bJBn4kL6Moq1yiPVM80lfft1n0+oPvq0DCGqMPo=;
 b=mi4Qpe4LDXM8nddQxbb6SiftPXCan15UDxDhaDx2sRD0pEPfAZ5Tjchv2Mq8ItIW9j1O3GmqY8XtPJBgBNFPz2tnXBlOhUXlcjRvVFka4jaKH5tPErLlXotJMLxZOor1IJoDwPdHL8n+IXQpG/3XC8eWbJesux27dj5nWGxSYUghmff8+J+5vlhibTgxiinVWFnQC4Kn5/ORga0dLYx9fcjqND9zIyQUjpQcDp274l/G2Pnbh03u+tZMa6GwQxODGr2nixKz+UgOtUfnzcykJip/rh8C/sxdwLhX5sEJYE7lfnUyfiDgmVacGb+qQpzpqeHLtp44VsfnxRKY3tzoZA==
Received: from AM0PR04MB11914.eurprd04.prod.outlook.com (2603:10a6:20b:6f9::5)
 by GVXPR04MB12014.eurprd04.prod.outlook.com (2603:10a6:150:2be::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 08:08:20 +0000
Received: from AM0PR04MB11914.eurprd04.prod.outlook.com
 ([fe80::cb39:cb44:cf8d:6525]) by AM0PR04MB11914.eurprd04.prod.outlook.com
 ([fe80::cb39:cb44:cf8d:6525%7]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 08:08:20 +0000
From: Madalin Bucur <madalin.bucur@nxp.com>
To: ZhaoJinming <zhaojinming@uniontech.com>
CC: Sean Anderson <sean.anderson@linux.dev>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: fman: fix clock and device node leak in probe error
 paths
Thread-Topic: [PATCH] net: fman: fix clock and device node leak in probe error
 paths
Thread-Index: AQHc/vfcHr//77vwV0Klc4vUi2zPwrZD9Mww
Date: Thu, 18 Jun 2026 08:08:20 +0000
Message-ID:
 <AM0PR04MB11914887F59D2871484BB8691ECE32@AM0PR04MB11914.eurprd04.prod.outlook.com>
References: <20260618075435.1262533-1-zhaojinming@uniontech.com>
In-Reply-To: <20260618075435.1262533-1-zhaojinming@uniontech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB11914:EE_|GVXPR04MB12014:EE_
x-ms-office365-filtering-correlation-id: 250162aa-600d-473b-e3c5-08decd10c2a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|19092799006|376014|366016|38070700021|22082099003|18002099003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 9Id9ZvyCbGEqvqH3vqfBx4HRn/XbSB4xWLG6mJS/46uHpxVzTY4eXqoCX46E7msPBqs65gpMQqdbNhdjjs5zzHKUGvAHxWqMg6QqxhimygyhEddiopkN0e5xl1ooGPcnoYHqVQ6NpMSD0p+pgkEtgZiYGnC958S3XtXeo/iFfaFxXM2IgRZVG8RRYBlxbU63nqKTupaqnEYsGoqEY3NngPggPf5mxcF87yTUZcdYEnRXLw1lpf51lQHTjUZZxUPkkIsorsJ4g8FbhiGoPCy4+XN4qz+ecyzmVSalyCF8oFrgBZxwO6jjSPk1rfnye7BL8snqnmaYNwdrD+pd344aIEMZ8MdV2vjoy8ojUNc+N74eIF1Pu2xbRQnk2A8DD1ZKvspsVSV7nfKPBtxjKKl59uRKpJdkFFwaddgyZ9Hccd04aCT/5FPV6gxGQ6xP1yQ2ve3Ey+uaCyCE6rUPnuaFPRPG1S+rJpQiGM5opn25IXoC/oteOedj0KXJneTjLA1uXUnLziM75tkRlFCdeUtuVrXBk9LvuuMrLGaatf/34dr3eWc6ep4o7BuqXTSbpc4i4l9AdD4fBAnxQ79FO5ZJrZ3Ts1PWxEqNog/GpNoJD3pVkTdVilVxEP0ihHpDrbYd4nLNyTjM7NluvIyd0LdFX2dcyEa40y44+FWWHzy0pyjcAikIy3zsbB44kygzrCrk4r3H3RT+hycHWrMzeGecY6w+2NI8hqCbZ3FF8Pp6kCkW5t8xQ7fQ5dgkFOQX1K2c
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB11914.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(19092799006)(376014)(366016)(38070700021)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kt/1DdhkB5pd720CX60egOVe/wcicK8nEDvro/0C2mZdc2ujfF5rfMBOWkzm?=
 =?us-ascii?Q?2vs0o9XIpVaeXXEJJ57/RIoT4xKvk5Q/Uqgo37eBNQhOg8SOqWwbu9+BMl5K?=
 =?us-ascii?Q?aIrFE3ClOnOF8RGzO9LBHGNhmw5NJXjpGKQ5JDmtva26onW0w7Y0UeHPzmpL?=
 =?us-ascii?Q?gnfoynqikDKgGFoiePmfXFwrcT6C/fLrMFfwdr09XjqysLKQl3cpmUnOxsal?=
 =?us-ascii?Q?I7M87aGzADSnwnOEr45qFbI9gFndqL75Ad1zj8ODfFS4SeX058kUDoLV5IJb?=
 =?us-ascii?Q?liEtHxZiaZvdP8XvsWetnLwjH1wlLnQx4+7tvuT6g+aw446oUMU/7uBNxnyA?=
 =?us-ascii?Q?vGFX4i5kBR2O49JgxqlPaAzu0zAOXqcedx251otWktjzHPnST12MMsiOKi3c?=
 =?us-ascii?Q?4DPd5VmbgAYRREoD+Yqw4d6uLhBU+HGSGBLzgsCXZJVfamRBHUHRsB9U9Qe7?=
 =?us-ascii?Q?Ngmfewo2X74rJRfXl2HiCO10PM6YQnzAb0B7pXFEOJDP3ETPGJiyAzcIH56j?=
 =?us-ascii?Q?czRlBMfGDr48zSpdGJrzXWR8gSikWMvvVjGKnD1yX3AgamRdKVvfgj9S3cb3?=
 =?us-ascii?Q?JmOkBJXIRgP2QmimMlTvQfdMUnVqC5t9nn2qm5Oh3tT/epSuAlrfmiX/jife?=
 =?us-ascii?Q?a+rLRqa/rvVzMfGTydvD45mcW2SKYOBpq7cQU38MzAfGudhZsAAWMJkSzFQU?=
 =?us-ascii?Q?SAzzsls0EMYAhZ+wGT4vmtbWYqJuPORCevj28GdJtrzv2kgDuXQ553arNAVO?=
 =?us-ascii?Q?ut++sFJTTpAGUJokoVfTbLctI0jBznVroHAZ/m1kRd3MrMAFgQJ3ZGyEuFDU?=
 =?us-ascii?Q?DJkfVbn1dNh4p/izjGBSW458cs8nHVbjI8RWxmmkT8l9JwEMU7or1joe4Y0J?=
 =?us-ascii?Q?sCCoLzxpBqx3pOq/Whij+pLys3cDYa/i3urIuFL4oGncWpC5oTM4iepcg8kk?=
 =?us-ascii?Q?4DhhDrnxcvF5SP/hv15bt+SPbaQrNSkxlxfmalMwpmjX3Jjt4IyJsBe+0wY7?=
 =?us-ascii?Q?n4G7UkqOQAcxFBN/pWn5tvmpIzsaXH7ZnUXlh2JFUUc8zuZY63v5w1zXsCRf?=
 =?us-ascii?Q?H+ido6ieF1or4eqS9YRajfvy4xx/wrF4AYa4DlIsUdeyeRo7xh04N0SEp0fa?=
 =?us-ascii?Q?9RPqhNQ9KXA3p2nwIlQBGCx14S+Ob6aFcslQhpo6isTyx6vjOmZNWF0824Ew?=
 =?us-ascii?Q?o4/sMPjyWieRUxq3Qv32EUQtnokZhPaDrme4RDYXrNTn0cHMSjCw0r6PnDkA?=
 =?us-ascii?Q?lYlqntB9ZMTBSppYEW1nbRO7Gy38wfr2w7aStG3IPhsf9YozE4vGpNxgk4qw?=
 =?us-ascii?Q?bWU3jc8T9J+ZqvOr0g7H7Gc93G7jpelAOFBiPLmjEGS5kjRPvQPWFeynXuUc?=
 =?us-ascii?Q?DMG/DC1fPS0peojHQAFEwn5B5MIfY/LjV7qX88JZPMUycfTX/0AoMUWsrkwd?=
 =?us-ascii?Q?NWZzg7fr5RH4Lz9goPvcQ1Wihd4Tpp3UUO9LfJEJaTG9rASkFAYilFnX+2xP?=
 =?us-ascii?Q?/Zgzr/++y6v44UDtnIrywMiYHSaYkif/WC+O/wsiOqRC5UrWAU/AbUgX7qhS?=
 =?us-ascii?Q?ltB6xZ/0mkF4GQgrckTpY9JCX0rukeun3Nl3AXJRQg/hE+Gjwa5E28DKUI2s?=
 =?us-ascii?Q?zt1ONwygoIRCLfJCbGvrImKYM5cVe72OSSy3rqTlU0WBS1q99cn1djqVRLpC?=
 =?us-ascii?Q?mF7EHjztYOF/AepWHCSylb5nV+IZnls9N4jkOSfgMZO10x+DbH5sEau+GlpY?=
 =?us-ascii?Q?E0knUbqaLw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB11914.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 250162aa-600d-473b-e3c5-08decd10c2a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2026 08:08:20.0916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ogO0QstOhgjGoxiOHsw5IpvrGVdGB3r9Dv9QE0z4VXaofETBrJgqJQM4WYnUQttf1GqH3+TIn2mqK9EPhoQFSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12014
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-300349-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhaojinming@uniontech.com,m:sean.anderson@linux.dev,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[madalin.bucur@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[madalin.bucur@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,davemloft.net:email,uniontech.com:email,linux.dev:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nxp.com:dkim,nxp.com:email,nxp.com:from_mime,AM0PR04MB11914.eurprd04.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E5A069E568

> -----Original Message-----
> From: ZhaoJinming <zhaojinming@uniontech.com>
> Sent: Thursday, June 18, 2026 10:55 AM
> To: Madalin Bucur <madalin.bucur@nxp.com>
> Cc: Sean Anderson <sean.anderson@linux.dev>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; ZhaoJinming <zhaojinming@uniontech.com>
> Subject: [PATCH] net: fman: fix clock and device node leak in probe error=
 paths
>=20
> In read_dts_node(), fm_node is acquired via of_node_get() and clk is
> acquired via of_clk_get(). After a successful of_clk_get() call, the
> error paths for clk_get_rate failure and of_property_read_u32_array
> failure correctly goto fman_node_put (releasing fm_node) but miss
> clk_put(clk).
>=20
> Worse, all error paths from the MURAM node lookup onward goto
> fman_free directly, skipping both fman_node_put and clk_put, leaking
> both the fm_node and clk references.
>=20
> of_clk_get() eventually calls __of_clk_get() -> clk_hw_create_clk() ->
> alloc_clk() -> kzalloc_obj() to allocate the clk struct, so clk_put()
> must be called to release this memory. Without it, the allocated clk
> struct is leaked on every probe failure after of_clk_get() succeeds.
>=20
> Introduce a clk_put label between the success return and fman_node_put
> in the unwind chain, and redirect all error paths after of_clk_get()
> to this new label. Since no goto target remains for fman_free, fold
> it into fman_node_put and remove the now-unused label.
>=20
> Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
> ---
>  drivers/net/ethernet/freescale/fman/fman.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/fman/fman.c
> b/drivers/net/ethernet/freescale/fman/fman.c
> index 013273a2de32..734cbe8efd7e 100644
> --- a/drivers/net/ethernet/freescale/fman/fman.c
> +++ b/drivers/net/ethernet/freescale/fman/fman.c
> @@ -2736,7 +2736,7 @@ static struct fman *read_dts_node(struct
> platform_device *of_dev)
>                 err =3D -EINVAL;
>                 dev_err(&of_dev->dev, "%s: Failed to determine FM%d clock=
 rate\n",
>                         __func__, fman->dts_params.id);
> -               goto fman_node_put;
> +               goto clk_put;
>         }
>         /* Rounding to MHz */
>         fman->dts_params.clk_freq =3D DIV_ROUND_UP(clk_rate, 1000000);
> @@ -2746,7 +2746,7 @@ static struct fman *read_dts_node(struct
> platform_device *of_dev)
>         if (err) {
>                 dev_err(&of_dev->dev, "%s: failed to read fsl,qman-channe=
l-range
> for %pOF\n",
>                         __func__, fm_node);
> -               goto fman_node_put;
> +               goto clk_put;
>         }
>         fman->dts_params.qman_channel_base =3D range[0];
>         fman->dts_params.num_of_qman_channels =3D range[1];
> @@ -2757,7 +2757,7 @@ static struct fman *read_dts_node(struct
> platform_device *of_dev)
>                 err =3D -EINVAL;
>                 dev_err(&of_dev->dev, "%s: could not find MURAM node\n",
>                         __func__);
> -               goto fman_free;
> +               goto clk_put;
>         }
>=20
>         err =3D of_address_to_resource(muram_node, 0,
> @@ -2766,7 +2766,7 @@ static struct fman *read_dts_node(struct
> platform_device *of_dev)
>                 of_node_put(muram_node);
>                 dev_err(&of_dev->dev, "%s: of_address_to_resource() =3D %=
d\n",
>                         __func__, err);
> -               goto fman_free;
> +               goto clk_put;
>         }
>=20
>         of_node_put(muram_node);
> @@ -2776,7 +2776,7 @@ static struct fman *read_dts_node(struct
> platform_device *of_dev)
>         if (err < 0) {
>                 dev_err(&of_dev->dev, "%s: irq %d allocation failed (erro=
r =3D %d)\n",
>                         __func__, irq, err);
> -               goto fman_free;
> +               goto clk_put;
>         }
>=20
>         if (fman->dts_params.err_irq !=3D 0) {
> @@ -2786,7 +2786,7 @@ static struct fman *read_dts_node(struct
> platform_device *of_dev)
>                 if (err < 0) {
>                         dev_err(&of_dev->dev, "%s: irq %d allocation fail=
ed (error
> =3D %d)\n",
>                                 __func__, fman->dts_params.err_irq, err);
> -                       goto fman_free;
> +                       goto clk_put;
>                 }
>         }
>=20
> @@ -2794,7 +2794,7 @@ static struct fman *read_dts_node(struct
> platform_device *of_dev)
>         if (IS_ERR(base_addr)) {
>                 err =3D PTR_ERR(base_addr);
>                 dev_err(&of_dev->dev, "%s: devm_ioremap() failed\n", __fu=
nc__);
> -               goto fman_free;
> +               goto clk_put;
>         }
>=20
>         fman->dts_params.base_addr =3D base_addr;
> @@ -2806,7 +2806,7 @@ static struct fman *read_dts_node(struct
> platform_device *of_dev)
>         if (err) {
>                 dev_err(&of_dev->dev, "%s: of_platform_populate() failed\=
n",
>                         __func__);
> -               goto fman_free;
> +               goto clk_put;
>         }
>=20
>  #ifdef CONFIG_DPAA_ERRATUM_A050385
> @@ -2816,9 +2816,10 @@ static struct fman *read_dts_node(struct
> platform_device *of_dev)
>=20
>         return fman;
>=20
> +clk_put:
> +       clk_put(clk);
>  fman_node_put:
>         of_node_put(fm_node);
> -fman_free:
>         kfree(fman);
>         return ERR_PTR(err);
>  }
> --
> 2.20.1

Acked-by: Madalin Bucur <madalin.bucur@nxp.com>

Thanks

