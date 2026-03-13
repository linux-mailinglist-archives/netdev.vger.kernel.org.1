Return-Path: <netdev+bounces-267340-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CH6lBk7Vs2l5bQAAu9opvQ
	(envelope-from <netdev+bounces-267340-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:13:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EEC28049A
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77F67300E240
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 09:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1E5389107;
	Fri, 13 Mar 2026 09:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SK6aQ1HR"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010054.outbound.protection.outlook.com [52.101.84.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D20331A65;
	Fri, 13 Mar 2026 09:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773393225; cv=fail; b=AWDYLczmwpq/5sm30IrfuLZh9wbPXLUe6rF7dDcP30gcOe00LtsdqnyZwnLbHhcgDKCYdqn1JuelIqhJ/k/C1Co12cnkcV7IPp3CdUD2++mBBxQww5etXbYUZpKN7+lhQFzKYS7BkEAGHls1TX7eSrrAil+5pLIbtUL1hWUxNTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773393225; c=relaxed/simple;
	bh=DPP1QrLGDCTjTJfBRSJcFHgA9IomkUXS+kALyGNB/TM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ts2InS3DJWCuZD+hQdgysEWYFtuxpzyEr6jnF/Omqn5xRFhgp40DP6QSHUlQsQ/IQlDX6aOq4p2SEJQEpiAT6b7jrdPauUEt2dvj3mywpMubvpCP1dCG6jc7vYfJ90rY8Hu6yphTlAIcjzZp7ME18m3D/Sl4vYVBzKLhMXcbZKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SK6aQ1HR; arc=fail smtp.client-ip=52.101.84.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ap0adxVqvm3zWvuSgwWU8Z0XKVfqmrapUth5KiyvSzLUHrIz6kNDFV6kDRGwUWulZZtqJUj6O/1vNtuQwGMU2GliwEtHrlSRTjkSKWb79B8DNmnKcPmPQEkScGNAFuycZdYZIFyJFKB4s7BPMmrjWKrTN3dtUmT3WVOkrsbZmKFCkidzZXW7AcUHAefEV7mKjmammQ5Hn0h279olx6CmiBnHHlUPczYVnLqVawyQFg38fqufNwNRn4pWpmw2zzz0AGRkGfVqA/EZ+RwR58MzuQTf+PbDxR7G8O80eIQYRxSwPcLegDI9P+bKNKy2+c5l3FJqElFo7fszX8yhDxeD8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qH8P/0D6nMTSu3VXWuXvcX59r3WgoOz5b0pPjkQt6A=;
 b=jaMoqmV1STZ/ZPNbyKHZzvLYPgwavEkMgro4Oz3wR1Kklr8T8e4hsRrdxTar2i8MSMNhdZPfmLdJjynWN7kxPSsNBUJ1zVFvNBRx7YShQL3/TZ4sOLgNU0D3NWzqZkoj0XJyEmgrTMRUDYQajvJHV8+3Wz5cdg0GNm6Z0H1TC6MnQASPbFLpd5rcmXjxml3OnGMLHaTXSlPT5Ur/PnOZnGqy/MLllwfHTn2i29ZAeh5x3RofTCj5/xKQ2XlJ/1qmiKcxMtyCkVuTsej7GsYAnZGAAY4RrC1GpTFU3jh0PYi2pyEMM9xDBBMuhiP96nENSiqPX2K+yL87dkLS/Z+46A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qH8P/0D6nMTSu3VXWuXvcX59r3WgoOz5b0pPjkQt6A=;
 b=SK6aQ1HRusCkoDoIOJNvY0bY6k3XXMTQcGcf19t6SeCqOkXsVAPyundX/unpAUbKzDRxhruQuTcafK0gY7j8ee3QW1cpBvw9784d31+vS/5V9zPbe66rBJo+8aIDajD+YFQzy+Z1O8KpW9EQsavQQHOhVqqnPTxu/w4gyAoKVMPBPKLYnU7B0WN1Uudw0DQHOzBmH4Vq/ZCfSCzxaB1P0AfHKqvvCS6upPGiyS0HLVwCGtw6GYY6FiiGhp2f8t3oTyOGZA/GlD4AwJX2AJhbGq0KqaUL7A1/J2fNfxzTfeHR5IioDXcCmrmYstFp/N790euw2nPTqZYald/pJ5xDKQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU0PR04MB9297.eurprd04.prod.outlook.com (2603:10a6:10:354::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.16; Fri, 13 Mar
 2026 09:13:37 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9700.013; Fri, 13 Mar 2026
 09:13:40 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, Frank Li <frank.li@nxp.com>,
	"horms@kernel.org" <horms@kernel.org>, "saikrishnag@marvell.com"
	<saikrishnag@marvell.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v4 net 0/2] net: enetc: safely reinitialize TX BD ring
 when it has unsent frames
Thread-Topic: [PATCH v4 net 0/2] net: enetc: safely reinitialize TX BD ring
 when it has unsent frames
Thread-Index: AQHcsgXxRYYgAgAH30KDTOe/pvgWRbWsK9Cw
Date: Fri, 13 Mar 2026 09:13:40 +0000
Message-ID:
 <PAXPR04MB85100C55BE23D80ED6C5D5028845A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260312095415.669128-1-wei.fang@nxp.com>
In-Reply-To: <20260312095415.669128-1-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DU0PR04MB9297:EE_
x-ms-office365-filtering-correlation-id: b588fa65-adef-4a79-aad0-08de80e0d11f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|376014|7416014|366016|921020|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 T29swRVvFKTDGEMM8HA6Hubp3MZbFnoAS5KSZDEDa9qC0wz31iy+6XymY+BBWqGg31nGE/1qRM4mgTnk1Yq0zIZvlzCBZUKaPMHAc1QBBFWChTOkb3eZKPlxhl0a/G6e+e+c6/AsP8Gn9bFbL1sYwH9lW+8hculPwyARTFFPJZkbb4N2RggcRpAG5iA0wlMxxaZH9/V0+SB6HIeoX9bzkCaP1f8N1mcu3OBxTOYazoqveGWcTjJ/B3An3uI5LDfAZ7jzy+kU7cvYyO0Tn7XH1GNPbFzD5nHeXxs405gXzr+syEzDh3g8iOzuZZhrpMunvmFSXHAj99iDqEF/qravcOzGCIA8Ps6ozxunD9vUWQVtAiM/4rQXyD8HlhMtDVYFC9wfI56ixvmijqLQNanBnZiuQimO4bWhwWqyLLzcUMW/pVy7dm0BWjJS860eOZa6hi2cd/+/hHKIJemWeOGY+yJkQMnZJJbtXzHbX1xJ5X37JDnGHUk4OSlWGWJ7EjuOEj9PrakXJkQ3ix4xxjDdvggLPo5qGSLHuGAnpMm3eu5Ab7eHQb7xhGWIAggpzIWwCLfAfJrwbQGLBeUU4s0TGZhLwNZANR3Hlj+TPNpDISu5ih6ZBTMcYdciZ4Ub3C5tftllQJBv61yxU1MEwQoglRVaTZAudx/vRfeOSoiAoL0Upl0ChM1SozFi0GGl9LR4/dJV6p19+w5xj4g6reaD8xZ7sE55MmtIfI+RExUmq/aiB8Yt1+4ssjZIa1GedTLEdJBq+e2DCnFMK3mTNVdvmrQeKovuOqkNQnuGQeoDoyeaDm7GRtFSuir3m+Z+msFa
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(366016)(921020)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Xc9f5Yd01W2LoIZdhEbtO2c6rXmKG4N2hze/HntIGdLpGCxvZwKfGjkJ+GiC?=
 =?us-ascii?Q?N5O3NGjUtPpLRd/zw1hOlGH2KNivv0w1zxZQGdnolubdGyX/mfIcGvjNloHM?=
 =?us-ascii?Q?52cI+lbSqT9rQGLg1en6hPWZaVkqxWtltgEJZYCDZurfs75XBRQ9ZwsbF33z?=
 =?us-ascii?Q?Hph8jQ9JYDTrKGRzP1vSp5wzeh9eo+ot+KllcLtHAqIkE3KQeRmFSLpZS3t1?=
 =?us-ascii?Q?KlJoU93FffCKpxqR3q2T5gMF2vIs0QuniVW/TJz2p+OeW28TW33dw9q/4g82?=
 =?us-ascii?Q?izReJLc2vdBCyNrhdXtUSHQeiOOPYqWlhqzW2S0zMjyUGRaZPGyAm2G26CPB?=
 =?us-ascii?Q?ae5tm0Y7GiPbiF66RHGHryMOM54G0PEaAaHRk4YBacWD3zjm5VHUNSXUIddQ?=
 =?us-ascii?Q?2Il/b9JkRUolZFdWLPVBjffzD7/Y2NGySkW5jW6yahmc1ty1oxAlSuyOP9G4?=
 =?us-ascii?Q?/3QX+WVZEGiOnwI8wm+qQOkSRPv8XGZqyyNvCQsPrMAdEdb1lS/Zjaye2XRC?=
 =?us-ascii?Q?KtLIMIXkSXe61NI0/9J4aa7GGx4PoSx4RmoKYwYH0FaSyzhTi9ykytAmCPw3?=
 =?us-ascii?Q?M9gG/uGtgPzWaHf3qLy+p2ac1GNvF6SOIfclOnOqiHKwnomDmvagY8T5u62p?=
 =?us-ascii?Q?5GXzV7wGVabqN3EAqR3ILM/5SL+f2exyG7OnZb3R4RdE962ZVk1ZYYK8vGW/?=
 =?us-ascii?Q?7UlbSvW3Xp3v8VPJprLmp33LxGfzhC/2BzNN09M/xxDIg+mYeep6ux6a0zYM?=
 =?us-ascii?Q?u6mL+hK9vdSQ5IasmUjmiXGgJygQ/mhTY8JAtU2GdruBCG6vOyRk0kGk7xaY?=
 =?us-ascii?Q?ux/ln64r1Whq8NRfY6ufIW4poSEbEPI1C4DQ8k2ADnpJflBD/zLbJK5QUs2x?=
 =?us-ascii?Q?Qvu20Ao7IB15RepAGODRgEljY+DAzki10uuTCP0Ocghb6J5P5G81uLC75hgH?=
 =?us-ascii?Q?V2wk8Ff4pJYVkYzegIEpD0zPJQ1s3YHPBOZWyVVFMqiiMcW55N4Ff2uAVySz?=
 =?us-ascii?Q?F7hmTdtOd7LMKLL8yFk8QLccgaYghBNNZioNShrZ88SmemyJPcyvlaPHIGS3?=
 =?us-ascii?Q?wllFvQJVm9Eps70ye2imtw+14pSvIGX92vA6rVWf7QY9ScAc59v7NL5uD88b?=
 =?us-ascii?Q?e3oQYJtCZctZT6ohRi2MJnm9JfZ0e/aAuYb8pTsVRa3otFjyEf6T76Maw9LG?=
 =?us-ascii?Q?YN6XCPiw1sdHAU839T5e4ZsCSqzexXwfbA7/Nawk0F3kLHrqFC4oqOd5Gi0X?=
 =?us-ascii?Q?9jMmAz1/h/M6Fru1QFsoee7JZWKKdIEWHmTlkdOuhzn+RSgB5YmhDr9uoxiB?=
 =?us-ascii?Q?Oy9+IYtodXFav3/pymITF0PbBSpPEvJYSyjtO/iednRykZkhzXdEY7E3Rc/P?=
 =?us-ascii?Q?eA3ID5JM1D36vB8qWPJxvSpDxXomPhQdSYQrDe/FMDnVOPRjpd6Ed/2nW1V9?=
 =?us-ascii?Q?AEvfpufRrwgpkbtr6lH0ybxXo8/WQbUhKWmmoIOx14Xum1cZ8M9OiVDAqMIU?=
 =?us-ascii?Q?/ppOTxgQiK9dgvH0iKjkYhUyFE20LZih2WrgdVY8/0/gyTUhV7rmSBMlxIZ9?=
 =?us-ascii?Q?N0JWAVdDlu3v4m6q8CJWkdrxJDtpOHztrU8xtuNUgyh5bSRBbEpplbHUmNyu?=
 =?us-ascii?Q?cVuujIqjrlTp2q/OF+ChEpCRfPpTOhcCgGNbhTx5OrTbqzAVTYZNo1HXZglu?=
 =?us-ascii?Q?J7I0TxvmbncPK+4BR3m8qFGEE1+WUXgoa+yRJguI/GtBh+HR?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b588fa65-adef-4a79-aad0-08de80e0d11f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 09:13:40.2025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bxeGqkf3O5th1hnwxBkY+KFJACIUwrxkP8kukqDO35RS2axl58WEv8pxquTRvTv5sLv2h2qqJTfQC2e6P1fyDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9297
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267340-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 85EEC28049A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Currently the driver does not reset the producer index register (PIR) and
> consumer index register (CIR) when initializing a TX BD ring. The driver
> only reads the PIR and CIR and initializes the software indexes. If the
> TX BD ring is reinitialized when it still contains unsent frames, its PIR
> and CIR will not be equal after the reinitialization. However, the BDs
> between CIR and PIR have been freed and become invalid and this can lead
> to a hardware malfunction, causing the TX BD ring will not work perperly.
>=20
> Since the PIR and CIR are sofeware-configurable on ENETC v4. Therefore,
> the driver must reset them if they are not equal when reinitializing
> the TX BD ring.
>=20
> However, resetting the PIR and CIR alone is insufficient, it cannot
> completely solve the problem. When a link-down event occurs while the TX
> BD ring is transmitting frames, subsequent reinitialization of the TX BD
> ring may cause it to malfunction. Because enetc4_pl_mac_link_down() only
> clears PMa_COMMAND_CONFIG[TX_EN] to disable MAC transmit data path. It
> doesn't set PORT[TXDIS] to 1 to flush the TX BD ring. Therefore, it is
> not safe to reinitialize the TX BD ring at this point.
>=20
> To safely reinitialize the TX BD ring after a link-down event, we checked
> with the NETC IP team, a proper Ethernet MAC graceful stop is necessary.
> Therefore, add the Ethernet MAC graceful stop to the link-down event
> handler enetc4_pl_mac_link_down(). Note that this patch set is not
> applicable to ENETC v1 (LS1028A).
>=20
> ---
> v4:
> Correct the offset of ENETC4_PSR
> v3 link:
> https://lore.kernel.org/imx/20260311084105.3982037-1-wei.fang@nxp.com/
> v3:
> 1. Split the v2 patch into two parts
> 2. Update the comments regarding PIR and CIR in enetc_setup_txbdr()
> 3. Use read_poll_timeout() instead of the while loop
> v2 link:
> https://lore.kernel.org/imx/20260309030412.2716984-1-wei.fang@nxp.com/
> v2:
> 1. Remove unused register macros (ENETC_SISR and SISR_TX_BUSY)
> 2. Remove spurious semicolon from enetc4_mac_wait_rx_empty()
> ---
>=20
> Wei Fang (2):
>   net: enetc: reset PIR and CIR if they are not equal when initializing
>     TX ring
>   net: enetc: add graceful stop to safely reinitialize the TX Ring
>=20
>  drivers/net/ethernet/freescale/enetc/enetc.c  |  13 +-
>  .../net/ethernet/freescale/enetc/enetc4_hw.h  |  11 ++
>  .../net/ethernet/freescale/enetc/enetc4_pf.c  | 111 +++++++++++++++---
>  3 files changed, 120 insertions(+), 15 deletions(-)
>=20
> --
> 2.34.1

After communicating with Claudiu, the patch still has a minor flaw: some re=
gisters
do not exist on pseudo MAC, and the driver does not prevent access, althoug=
h it
does not cause any problems.

I will add a new patch to this patch set to fix the issue.

--=20
pw-bot: cr

