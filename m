Return-Path: <netdev+bounces-300134-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c3KgLZaAMmoB1AUAu9opvQ
	(envelope-from <netdev+bounces-300134-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 13:10:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39298698D9A
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 13:10:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=etas.com header.s=selector2 header.b=HnDHaBxj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300134-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300134-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=etas.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 465C8307A39C
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 11:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B253ACA5B;
	Wed, 17 Jun 2026 11:08:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010032.outbound.protection.outlook.com [52.101.69.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A993B42E1
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 11:08:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781694502; cv=fail; b=fhxrXMcL9+29Y0AjBNRFcLmppS9HKaBqEoDnoijLKWNpULqLwdGfNW6EfgPMCzj98InIptv++VQIZJJSyiPxP6oxP5sVvFRv+8N4kTC95koDkAi8K+JNic6lS9ysXHLDp2WSgKnoG5SsVu9ROd4VcK9d07/QBYSzij2xV5QLt1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781694502; c=relaxed/simple;
	bh=a31iT3MgXNiSF5lEXedT5u9SGjWFq7glTl08P6jO1dU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cxyijM+9GnrfeGVsAX03cCliLbPRHaU3DgIMu6IDLbeyTEorRvhhCXTM27P0hYPRfcz3lmcN6E/UwY5tZ8kIebjBOz5ZFoGeelX0g19CRj2SQuECnmMC6g9SMRwRJ4SgnVUipUhTER+tqJNrW0cIBtUNmQcm3pmEfz2gwsNGYH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=etas.com; spf=pass smtp.mailfrom=etas.com; dkim=pass (2048-bit key) header.d=etas.com header.i=@etas.com header.b=HnDHaBxj; arc=fail smtp.client-ip=52.101.69.32
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K5P2TkCRuZfOu3VeHxRNbWTRKkDWNyb83PHF6K1hggiIZ17AdCHd4eh9eliqKfCTpMHDPGBQ9IkWMtE0RB2omcKrLe2EqrCn0tvJO2k+fu795x105VNOTK2u4hJ1jllNPfCnsd7WDpJKmlFZ2FJnu541h0X1Jl6Z1m0wsisYXlYqpZJh2MrQMHAM1MqgVqqBbDdt3meFeUv12u+wHglJtzymJpLVBBc4WJhSRtaEd2NxcZr8aX+f1m9yHvtXWoWv28q3Z4tNvTYwfFL/bsSiajAzwJCSYRgPvT8UBfn3rDDvOp+PHlS5GGm1EylOjpw9JzCOFk1JQWvQe+FRUqf7jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a31iT3MgXNiSF5lEXedT5u9SGjWFq7glTl08P6jO1dU=;
 b=RLMM25lk4BiCu8ahi0toOMb4H7vGrtmE8GEGhlDXeWO3y/HYs8BA8OigghrNHSMd22x24ZVQEGG1rq8AQnXM4TLrVXYX3Kqjnj3BDG4O281rCumqB+dx3OnL7eASbe8S6pjoU6bZHB/hFTrrNyrkyhurzunpHlwUKyfEbIGMfOoBI1WV8zl9/Tox3L43YH7fKgmz++tzKH8Vq2zRBNKq/Wu9yq6APgqaYv4cB9mbQkEBybCDSkL0aZhBlfludr2Sj0uJTVb0fc146spZhrnTwu6fiQVJ8NYsLHmjicdJWcjUuyxocIeK200/ebR4OIeZ3K1c0d+MlWVhVTA8T89cHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=etas.com; dmarc=pass action=none header.from=etas.com;
 dkim=pass header.d=etas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=etas.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a31iT3MgXNiSF5lEXedT5u9SGjWFq7glTl08P6jO1dU=;
 b=HnDHaBxjr8c3GJUrPoU48BMi9Wp2Ubk7iao7CtXNDrRTddKKT7ng5NGsI1tHlkRNr5R90Nka3sa3UJnS4YaV1BDSxbce27ulF8UgWYC0PGw8JZuIwgwQVDR32LJW+rRHCWiu9Tz1ym0uAEUo/oTJDZ9Z/wVTy3xlqFOKpsD8RHyhcBmz3hqQxbmNH3FxG8mg8yU/4zmmecZq3znb+Jn8RHhUQ3zUR+bF1GF+yQgOpBRi70rjurkELgOd2BS/uiSRNf9V9NI3jq0umPDjcsaJYW5dsNr1K07//c1mRx3u+SFwSfcE2em3lEdizmD4N+gPwRzXt00pJZssazmrr0MsLA==
Received: from GVXPR10MB8360.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e9::20)
 by DB8PR10MB3355.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:f8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 11:08:14 +0000
Received: from GVXPR10MB8360.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::142d:3d0d:e935:bf09]) by GVXPR10MB8360.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::142d:3d0d:e935:bf09%4]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 11:08:13 +0000
From: "Koehrer Mathias (ETAS-ICA/XPC-Fe1)" <mathias.koehrer@etas.com>
To: Paolo Valerio <pvalerio@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lorenzo Bianconi
	<lorenzo@kernel.org>, =?iso-8859-1?Q?Th=E9o_Lebrun?=
	<theo.lebrun@bootlin.com>, Nicolai Buchwitz <nb@tipi-net.de>
Subject: Re: [PATCH net-next v6 7/7] net: macb: introduce ndo_xdp_xmit support
Thread-Topic: [PATCH net-next v6 7/7] net: macb: introduce ndo_xdp_xmit
 support
Thread-Index: AQHc+ZG/hL4YmyignEqKKbVs2X18wLY5MgHPgAltdL0=
Date: Wed, 17 Jun 2026 11:08:13 +0000
Message-ID:
 <GVXPR10MB8360BB01B3BBCFF982EA127E9FE42@GVXPR10MB8360.EURPRD10.PROD.OUTLOOK.COM>
References: <20260323221047.2749577-1-pvalerio@redhat.com>
 <20260323221047.2749577-8-pvalerio@redhat.com>
 <GVXPR10MB8360DB5D2F374574CE33C5779F1B2@GVXPR10MB8360.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To:
 <GVXPR10MB8360DB5D2F374574CE33C5779F1B2@GVXPR10MB8360.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GVXPR10MB8360:EE_|DB8PR10MB3355:EE_
x-ms-office365-filtering-correlation-id: 0e2bd0c1-7a2b-4014-47d0-08decc60b9b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|56012099006|4143699003|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 Qc7H89eZyb0XaKKQS4a4LB3QVaEyByFvLWPXjJMneIWE12vEOqRRck56fmS9wKvB/B6IiUc9RlkMpIk3Q3GmdfgOmqTSivkz+c07ENG8j/+7VOGs2RWgTOQLGGf6ppSBMCOH0yWjXa+4qMGaXvi2Fodz/ptBl5FU42OE353rOvcyBFNri1WLziDT6pUpDhiMjwaln5/MkzmfFUxeMXqiuH1rva+89DgnONhJ685e8sAcxKl0e7pBieu7pHfHMgzGh3e0Q+bekUKBjHR45qO5Pvle3v/8kvfBXHWBb0rBPpNWRnSRCDMV8jH0eG62rcorM8KzqLy7z8b9WdKf7fkrLXVOcGN190fUPkowlR6kgq9pJutxUtYm6NZPBdbvRs8yoMlD2QYBYR/1Wi7aPLlzhTtEopg+t26ul2SDUJydVHZnsYDeY4CWaxNsGVls2g6D8zkEaOeENgfk1fAhpknFCVe0Rmrq5laaxsk7go6/Zc1TxsDsgdnyU21mq3ZG6QtpY4wCpHTkiiTVawfvI/Zy0IshpCWKx0yYxzaRJuakjb1jhugw3B6Bnp+BSGc1hQW/xakIZYoKBWLkLDCg8GTDX4RCcNOIy3Vd7fi9p9/BuZXJJgJTZQCzBj6NbOcUKAEE72oNxqZsPfzwu7uv0jrnW6aczUaHIRfVXMQ5YnemEc7+AdI8rKMssKqQSgrOu1L7cy6jjUiJjaLjWqM0bTvC2m5vWH9KzR9eTWMnItoO8MfH3IeuXck0d8RFpP6IhgT2
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR10MB8360.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?1wQLkcB7Qy/lYpBQ50XgHykLpfQfpEM1m30tcdMgCFm9FCYDI+re0JZrWK?=
 =?iso-8859-1?Q?kTqaGnqW0qKsvh3GqVLIl8OEwiZWgo4Afs5vAEvVUMlfoSKNq0N9jkNfxY?=
 =?iso-8859-1?Q?KvzvpfXn2DMpKVDPQI9CHCiELsvL3kJkwyEgRG+X6nLlsxGRLt0X6kde/c?=
 =?iso-8859-1?Q?Z4a0ei9QtiQNYlddUXxxAeU1sezxYVSsryoN54+GR8/Yg/AT18vVuZ9NZG?=
 =?iso-8859-1?Q?oy9Nle/S+kOxHtj/GKmTRjrVLf+GQKAj11/Ikn++sySixchVB1e2RlK8lB?=
 =?iso-8859-1?Q?4TEVBr5+ywm2i439qZriy7HRtBDdB5MC8pZ8k7yPuDzujhe9e+7+5iAChm?=
 =?iso-8859-1?Q?FpaWQhzEqbQ1hAdwp+z5ZvGJ7EDkXHZZ/TZoXjZ3gF9ExittDeB18fOnf5?=
 =?iso-8859-1?Q?Sl5O/2MCMbbKQCGsSuPUQmY0NUYrXrTd4M4e2GmyVJoHTbYMrtniqDRvhw?=
 =?iso-8859-1?Q?jwV18jvmHM9C4HfpA5WrVPPhTTCF7wejkUnKQ4jgVK2pyVEjEtahip38YV?=
 =?iso-8859-1?Q?QxNgMNQfid5vjAH1kh33WSonbjlJ6RqdrI8cxlra87xOQeNjh7DRqNTWLh?=
 =?iso-8859-1?Q?l8v7n6P3ePAl83NCIXzE3FJVa96PB4UtadbbwwLp+S/S9RQZ0UPDmUPgKx?=
 =?iso-8859-1?Q?79W4uctJk+XZX98RstoDlnEVtq6GDyTkxhhbgBsdQrF8bn/lvbtm18Zpaa?=
 =?iso-8859-1?Q?RPCvDBt4QdiF7W5gQAe7gT+NT6A3lV4VxDeDoywnxq++NgNrypaWdTDjHg?=
 =?iso-8859-1?Q?0HmuDv+8eerSwLVUcU9UHi7nFtmHplziG3cqqqHLaOoFoxBPLX8ovRPcPg?=
 =?iso-8859-1?Q?g5vGNYnozFgXK7AKNXu5huHTcRL2A/Sm1qXrsnVoDRofh578adpwCdASxV?=
 =?iso-8859-1?Q?bl7HWMiNswvhnYI9CCJCa4isjsw9ASLOG1764wMC/mQe8pTR+bzG73gcl2?=
 =?iso-8859-1?Q?rbdc607pGvJIR8tQ9YthI+cxI4yopZqFmAiYqoGuX5WA+HYOK1k0XGUu4S?=
 =?iso-8859-1?Q?ar4yu1f1LfVyTIA2DGSiAD8UUNW4fbEfs4HRazu1hosAfv41OA9ELs9XDm?=
 =?iso-8859-1?Q?eJlkkDvm3HHCgD6c9QQfI8WQ+JVbYxhpg7rCpI/Ksx0PsYgroA4CtkiHUe?=
 =?iso-8859-1?Q?3IlEK8hd91dAxhJCTZrNpEyTc+ySFvDnp6HPp6aCSF3hNRmkHfp2GDzEbu?=
 =?iso-8859-1?Q?XmsIU27pg0RrBqFmjf0UraLq69Xx44J8RNelK+C7zQoK3WI0u1MQ1eZB8n?=
 =?iso-8859-1?Q?Ajsgrc4J+cIuZoRY23bTxUYTKOxbCjbtcoD9YNravWOGMAuOOUhMp+qkOo?=
 =?iso-8859-1?Q?xZXEPeWpT3aMpQJrbfbrHNQtXAcSCNn4mgIL926/Vnoh7saa7lHRaZb9tq?=
 =?iso-8859-1?Q?U23j6ALJP89rwS+iuvKDArLOSwrOJGi2QV4P7lYZVdUVbTqp3Cl6w49KA9?=
 =?iso-8859-1?Q?HPbC34XVz72LhBjrYfdya3IIqLdlxSVrRjD9jEayzn8po4GHrmGwNDE9lW?=
 =?iso-8859-1?Q?aENWiWPKpvYX47agOtDOywmW4QhaZkeyX7GMe6AVgHNqrn3o8gTVzI6UAn?=
 =?iso-8859-1?Q?86BhOVKw63cBRtDH7K5mv52kqOGt1y6n0hDd4QfDVtHWeAb2j7ABHFpnsD?=
 =?iso-8859-1?Q?tdrPj5XO4NATtBQlO0MD6MhWYYq1KJTDbdK/qoSi21dI+XWUWm790Zw4uA?=
 =?iso-8859-1?Q?v6rI77boFZqQRFyKRG1tsMtaPABiNwf75rBNHSwNr0G9FRP5yoyr4zLNpL?=
 =?iso-8859-1?Q?lXBLF8Dch74ceXVGdxaEKhcm4f9a0oPDrTzRAM6uNNZ2xk?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: etas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GVXPR10MB8360.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e2bd0c1-7a2b-4014-47d0-08decc60b9b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 11:08:13.7281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EHK4PvKc3rgAFaijpPjN/Sb0VzbhCD40tGw2w3E6/No/MZ61thaENc9TLAjSPz2wVk7v+s4is/lfvBcSMR21vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3355
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[etas.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[etas.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300134-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pvalerio@redhat.com,m:netdev@vger.kernel.org,m:nicolas.ferre@microchip.com,m:claudiu.beznea@tuxon.dev,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:lorenzo@kernel.org,m:theo.lebrun@bootlin.com,m:nb@tipi-net.de,m:andrew@lunn.ch,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[mathias.koehrer@etas.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mathias.koehrer@etas.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[etas.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,etas.com:dkim,etas.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 39298698D9A

Hi,=0A=
> within the function gem_xdp_xmit, there should be a call to "xdp_return_f=
rame" for each successful processing in=0A=
> "macb_xdp_submit_frame".=0A=
> Otherwise, this driver does not work properly with Ethernet drivers that =
XDP_REDIRECT to this driver and use =0A=
> page_pools. In this case, the pages from the pools are not returned to th=
e pool.=0A=
Please ignore the complain.=0A=
I think the existing code is fine, I found a bug on my side. Sorry for the =
confusion.=0A=
=0A=
Best regards=0A=
=0A=
Mathias=

