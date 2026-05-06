Return-Path: <netdev+bounces-284934-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNIaBqFn+2llawMAu9opvQ
	(envelope-from <netdev+bounces-284934-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 18:09:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 178C24DDE1C
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 18:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 71BC33002908
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 16:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E104963B5;
	Wed,  6 May 2026 16:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b="MfxWccBf"
X-Original-To: netdev@vger.kernel.org
Received: from BEUP281CU002.outbound.protection.outlook.com (mail-germanynorthazon11020140.outbound.protection.outlook.com [52.101.169.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B50328C2BF
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.169.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778083262; cv=fail; b=gCAJa0MACYGLFBcu3+ZsfdEMBaweKt49bTixldqsxrJEfvbk7+yVpeCbYpiy4RrwnyBIrG+Dm+7VDNhhGtklevYCyMvECJ5vxfQDC/dFxI3OWpayTAsXkwFfYk2T/9toDcLIN2cqF9HaLloRPOx2K6jfSuBDctulZ6Jm7BUxXxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778083262; c=relaxed/simple;
	bh=yS163YX2syupouvSZ+Dus8rL9OKH1oR2K5kxKCK2uGw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OBXL+R05xp5YqCkcXRk/NVSR+zypScYbDnD11Ue1iRRVo3a4M4979MC+7J0XUbzvMDFgxvPVvLeZgFwoXXreG/e/IFomANNypn+4pL7xAE3iIGfX3E3DWthqJlGm0U4y/jGc+DNcFacSB0kbcSs73LVnDFXdHmVBGg9luKmmcIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de; spf=pass smtp.mailfrom=schleissheimer.de; dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b=MfxWccBf; arc=fail smtp.client-ip=52.101.169.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schleissheimer.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDDXLdMgELBOAT98DfUXUbQ4ZLv8maEoSvlUiOX7VOcuEnCR1BEEL6YafNw4+BUGE0QvUYt3dV2YBR4K+ZT+RJJiKOmTn0eVGL/t6g6xkcHNxvEQ1NXRreV/kgGW4500bTNqaJoNJS7WVRb/Z/EgVUcj+cP9bkFOgNXswLNQcGboFzgEZWncQEQC2qIG/up9xoMsaPoP0uiLnlvkFKqCgAbsBQKdC7RF+EHP2zRYi9ztQscNZyGrL+iMOVhWoLSSr3ENYqWcUt8ZksHoShZwlEDOlpOWCCP/zi8106EqA2fWq91TxGLekV/P8mEx1GaQaUlUyh/PO3QlhIDFlZS/KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Muq5Uw54jCQqAEhxSdGgOQylBNpDzea+2mrlK2wMzY=;
 b=iK7JcpbLrIpquBCfTc6ZMtWloMoFY1gs5ll6pvr2K12PRjcj+j3QB5zUvE1cKOoKLPRTC+3UelPzo5S/rMTzKQrqc2rVu8IY7K0du/r/XsE431xutPezta+/Km5CbRdkBgxM6wN8KGPpTEdX4ksuo6R7aqkcon0epBIzZrXIIajH/Lx4tFt6n/hDFKWsiBuU8p7y3E6pTplWQaNsXajTB+nLcEbm+Hg/BZ4W1Lm61vuPXji3ZCs+7W8g1QT3+ZEfgADanIuvf4L7OYqtXX7jRhyVJa5TCNJOC4tG8EWf24AQv0LMU0d5bAzGYushWJmDOUPZlokLX3wR/LC9uw3Mng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=schleissheimer.de; dmarc=pass action=none
 header.from=schleissheimer.de; dkim=pass header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Muq5Uw54jCQqAEhxSdGgOQylBNpDzea+2mrlK2wMzY=;
 b=MfxWccBfndvQiA46jwI3mAk41qdMhqYKvqm+L9+IBaOppB+1bbVQC2KbQPLAzfYYp6cOTZy47NyhLZiO607dYj0UA/n+3kaB0Fx96i7CJZPjQbmHv1mfAkSjHRjNbKeZzmuXSstamAwWmwbPNoEzuJXrhSTmM5jzoJlSacOLliw=
Received: from BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:52::10)
 by FR4P281MB4481.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:128::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 16:00:51 +0000
Received: from BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
 ([fe80::2bc1:32a6:153:c3e9]) by BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
 ([fe80::2bc1:32a6:153:c3e9%4]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 16:00:51 +0000
From: Sven Schuchmann <schuchmann@schleissheimer.de>
To: Andrew Lunn <andrew@lunn.ch>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: AW: assert in phylink.c with lan7801 and dp83tc811 since kernel 6.18
Thread-Topic: assert in phylink.c with lan7801 and dp83tc811 since kernel 6.18
Thread-Index:
 AQHc3HSt2FaNRg+Hc0Clgdk/8rilD7X/aQMAgAEuzo+AAFoaAIAABvoAgAAD+ICAACpjCQ==
Date: Wed, 6 May 2026 16:00:51 +0000
Message-ID:
 <BEZP281MB22457317618130F28E84E3B4D93F2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
References:
 <BEZP281MB224533D524B27CFC6E47B447D93E2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <57fb63c2-7a05-4bbe-ba2d-fc61ce1e3ba1@lunn.ch>
 <BEZP281MB22458F571CC8251C141D933CD93F2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <7778cd41-cf36-4524-a347-408a8fb0bde0@lunn.ch>
 <f9b8840d-94ba-4bde-9ace-fb81eb733ff9@bootlin.com>
 <eba96f21-78e6-42bf-938a-6d4037d0a305@lunn.ch>
In-Reply-To: <eba96f21-78e6-42bf-938a-6d4037d0a305@lunn.ch>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=schleissheimer.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2245:EE_|FR4P281MB4481:EE_
x-ms-office365-filtering-correlation-id: 37ab51ba-daa2-461d-45c1-08deab88a593
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 uAFz6YnSLsjU/Ig2P5oxed59Qm5N3bopjuCUWhU9UpPNp1UoqHePWhS392tg1/Gt0vwl9u6J9aVXtnSWAWZm8NF9CVQxoiwY0TnO9L4wLQ5nZrOsY03UYYBlOrCdr/912Gi+lB7jOO88bOIa/aydYo9b50LN+ogc0p5GkKb7KoiH2/hvkJNFBvt73maOewbv/svVsVYLi2Y8SVlMfSaG8xzA/eIszCiAWHhWVSPykgfcSc1ulOL5eNHGpV5g9zcQ4xDAdYJy7SjDdBjzYmB9OQ8bEsdFj6AtBz8kWAE9032QqIb+0YFDgVikjrMcmTxNtJSrt5UC6qRn7ZSDmI+46AKxXPVXALsP0ewkMKvN35bF3eCx0OUoIQFuJ9CUkbwoSEP8BBOz9ZAINqMZVEJPLNvxwFFunWpfAlJSB4TRuby4RYHDJUK7vpahNcFIF/T7JW79ZXDqkvr1mWYBHqW+u7BZyahEd7CQtpIHgvL5ABYr/rKjyBQKekpdI6E0cJJwfMlZa67P1YGXJYeP1NrsmyPBWQGKJd6PnxQIqULiRwPjjGCmhD9x+F5pJ2zJkvkiip83VkYJuKsnyiXb5rlUGHjh2fSs7Rr3ZzVfIgJzF+BPBckaPDGVf1Tj3R2EUEw8EcZbMBaVa1l4iOPqzoPhzFMD1RVhE1rrUX2AXQ13TVQUcrhuFASxuJYh5N3mM41KOH0MW2ibVJzQCTyH2zI9qQKmPg9pd6tfHpQCKn4QzU7ddBvEI2ziKVRSLH5hwAPR
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?JN0Kye8UzkDs8kK8h6qymIBmb9XdkFI//9DZOfgISW+cPgADixNSVEhxSH?=
 =?iso-8859-1?Q?ln4BKJ2M97NjLAZlICs1zhVrvdu4xHojzsnr4D2O0MPH2K21ZA2K1mPbGx?=
 =?iso-8859-1?Q?n81QsCtNtw2M/ZHeIvtAqiVBy1vRIxdZktCioIxabPtsmv1XKHEZ9Eu7v7?=
 =?iso-8859-1?Q?NgPC2gmwiYDHiBk8w0ODr1zp+md5Dozu/AlDK5BFUZGPphI2f1PtJ53vvn?=
 =?iso-8859-1?Q?fBOH02sRAWRcGV2Hgi/RTanZG8bPwfqbykpIvDqM5oNc1OSsA0EU+sgRO5?=
 =?iso-8859-1?Q?+ITBCpvbVrrD9yDCSUZSnrhDtXGIKWfEbBIJaSqTIxNyQc5O5KPU7Jbl1y?=
 =?iso-8859-1?Q?xAzFtu1qEDJmZw627F9sYY3ib14U8YLnP4zwgBh1QronFpb5kL17qjKk39?=
 =?iso-8859-1?Q?0ZMHY0X0pjlblDtZ0/edheTnjlsyVOO/qbUfO6gQN2WoBLl732iwRubHoX?=
 =?iso-8859-1?Q?1fP11naLHifjHeYW9P2lzAVLoblwE8kvL9FAzMEj5LtbbRChd9fD/61Oc1?=
 =?iso-8859-1?Q?kayJtUucZc4dwbbmYQvR3TnghCQ0X2Hj5co5NWaCHyQsYVBn189P2rZanf?=
 =?iso-8859-1?Q?AehnQaU9BaIeiO814G6kbQ0NRvu1xbLkU2ET47eH0IG3aNFqwgKtJgL+kD?=
 =?iso-8859-1?Q?6RovT9mEFGStMzHV6/sJ3TICc6XyP9kPuR6u7yebim+Z8DuqrYpNg/To7q?=
 =?iso-8859-1?Q?R/WZxZ1fBBGAII0cSCDZNwNF7KS09bGS2umIxu417ZM3EkwHFDbvIIh2ci?=
 =?iso-8859-1?Q?f4UCg5Du/E1tHK7egHkwe/xMqGOrxroyqIO70zbz/1/Ck6vApUbwIQqeoi?=
 =?iso-8859-1?Q?/0py4EW/UvxctA21dpPvZDZHAsFqO38F8pytsEmZ9LBtQynlSnkFsyzoMI?=
 =?iso-8859-1?Q?DL9y6wDwZcwUXhDuHoFTxP04EH5DU3s5eJENxwbMjjdKsSwe1HDKkDdHJE?=
 =?iso-8859-1?Q?BqfV5TbAFn6K/0KkTB2Jlpeb7GyBXXXn/E/h0qh2mSw5N6eWNbo3OQWRK6?=
 =?iso-8859-1?Q?nkL3O2r89Gv+eHXHTh4+Zwdh+NtVkKLJjmPhvUI2Nv5UKmgyJZUKrXGwDg?=
 =?iso-8859-1?Q?DwClOMxBbpCBzhnutsLJOxniQmsYGI1dFlZVN8Y5JnpVhPNro9xO5s6RJv?=
 =?iso-8859-1?Q?ygXqjygZO1vYsa4hjR/ETRkwZyxtEBl8uKDjIFQ+TC8lfzvW+l/D8/MRc/?=
 =?iso-8859-1?Q?m2TfuC6BvGRFKqfXpf7KI5rqVB9lS0BWexGJl1IivqBMepnilSJdO4GpDY?=
 =?iso-8859-1?Q?6D1umqiZWdSlAXLWDYYvDwRAut4P+kqvSg+tlq+8u7SZ2gKtlQZBhf5mr8?=
 =?iso-8859-1?Q?Q5JoDN/1ceB1KEvhC7x7ayWHALhSbnLtr/ta4/2VJHCl7nf03uUbXZAwMa?=
 =?iso-8859-1?Q?CXE1RanUGqhqhFh80n6+Yks4ObJkZiefIKx1Rxg3bZtnz6mO7AQWRHLX3B?=
 =?iso-8859-1?Q?cOKBa5Z/Y1DRPxZC06aV4Q3LJ6TTm/lhZGQqjhYQR6SxxBWVDBK/6z37HR?=
 =?iso-8859-1?Q?l5cSILiQynDrAevJi0UDmUn7IO8EmDG13Z1clbKMf6ULTReJDqX1fWU6U8?=
 =?iso-8859-1?Q?j4wtB+8bZRn9+GNjJge7WFfjFIW0UqqRkw5vJoHoVZLKYrsy4z9mAbJZSh?=
 =?iso-8859-1?Q?bQuqzV5o9qRi9uEXQcdeyOLgOUTlOLcX5Vi1rpPPEUxkx+QBpt5hJ9E7R1?=
 =?iso-8859-1?Q?Lx9GLslq3rcEmzGu1z8FNyd2UUcKzkSFb8hpCQZvQd9eoMeEbcDUhE/Rli?=
 =?iso-8859-1?Q?fWDVcWuvyeqCz7K63UKX+v4k+5cADwA40eQnEzox6BGjJ+lj/SK8SPVa/R?=
 =?iso-8859-1?Q?34bSV+LSgQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: schleissheimer.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ab51ba-daa2-461d-45c1-08deab88a593
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 16:00:51.4382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5rJCIFCdlsz4TfChiXHgwc5MZolYccnfhQhUGJjaECIMqP4p7pp+kbFpYeLZxG8/Y4XDDvgI1k/lwZMHya3HQyxjbcDWkrOulNUQucOkkT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB4481
X-Rspamd-Queue-Id: 178C24DDE1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[schleissheimer.onmicrosoft.com:s=selector1-schleissheimer-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[schleissheimer.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284934-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[schleissheimer.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schuchmann@schleissheimer.de,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,schleissheimer.de:email,lunn.ch:email,schleissheimer.onmicrosoft.com:dkim]

Hi,=0A=
=0A=
> > Von:=A0Andrew Lunn <andrew@lunn.ch>=0A=
> > Gesendet:=A0Mittwoch, 06. Mai 2026 15:18=0A=
> > An:=A0Maxime Chevallier <maxime.chevallier@bootlin.com>=0A=
> > Cc:=A0Sven Schuchmann <schuchmann@schleissheimer.de>; netdev@vger.kerne=
l.org <netdev@vger.kernel.org>=0A=
> > Betreff:=A0Re: assert in phylink.c with lan7801 and dp83tc811 since ker=
nel 6.18=0A=
> =0A=
> On Wed, May 06, 2026 at 03:04:42PM +0200, Maxime Chevallier wrote:=0A=
> > On 06/05/2026 14:39, Andrew Lunn wrote:=0A=
> > >> So for me it somewhere happens in phylink_validate_mac_and_pcs()=0A=
> > > I was expecting to see more debug output, but reading the code, i was=
=0A=
> > > also thinking we need to look at phylink_validate_mac_and_pcs().=0A=
> > > You are going in the correct direction putting lots of printk() in th=
e=0A=
> > > code. We need to find where it returns EINVAL:=0A=
> > [...]=0A=
> > > In the end, we are probably going to find that what the MAC says its=
=0A=
> =0A=
> > > capabilities are don't match what the PCS says it can do.=0A=
> > > Thinking about that, it says phy mode RGMII. You generally don't use =
a=0A=
> > > PCS with RGMII, so that is suspicious.=0A=
=0A=
> > Another thing to consider is that in this case, we're attaching to a=0A=
> > dp83tc811, so a 100BaseT1 PHY. Does the PHY driver correctly populates=
=0A=
> > the supported features ?=0A=
=0A=
> Using RGMII to connect to a 100BaseT is also odd. It does happen, but=0A=
> it is a bit of a corner case, and something could be going wrong here.=0A=
=0A=
What I can at least say that it was working with kernel 6.12 on =0A=
the same hardware. But I do not know about the supported features populatio=
n.=0A=
=0A=
I added some debug code to the end of phylink_validate_mac_and_pcs():=0A=
=0A=
	/* Then validate the link parameters with the MAC */=0A=
	if (pl->mac_ops->mac_get_caps)=0A=
		capabilities =3D pl->mac_ops->mac_get_caps(pl->config,=0A=
							 state->interface);=0A=
	else=0A=
		capabilities =3D pl->config->mac_capabilities;=0A=
=0A=
	phylink_validate_mask_caps(supported, state, capabilities);=0A=
=0A=
	phylink_dbg(pl, "phy: --3.4 supported    0x%x\n", supported);=0A=
	phylink_dbg(pl, "phy: --3.4 capabilities 0x%x\n", capabilities);=0A=
=0A=
	int retval =3D phylink_is_empty_linkmode(supported) ? -EINVAL : 0;=0A=
	phylink_dbg(pl, "phy: --3.5-- %d\n", retval);=0A=
	return retval;=0A=
}=0A=
=0A=
and the output I get is:=0A=
[    2.771602] lan78xx 1-1.4:1.0 (unnamed net_device) (uninitialized): phy:=
 --3.4 supported    0x80cf3430=0A=
[    2.771607] lan78xx 1-1.4:1.0 (unnamed net_device) (uninitialized): phy:=
 --3.4 capabilities 0xbf=0A=
[    2.771611] lan78xx 1-1.4:1.0 (unnamed net_device) (uninitialized): phy:=
 --3.5-- -22=0A=
[    2.771616] lan78xx 1-1.4:1.0 (unnamed net_device) (uninitialized): vali=
dation of rgmii-id with support 00000000,00000000,00000000,00006280 and adv=
ertisement 00000000,00000000,00000000,00006280 failed: -EINVAL=0A=
=0A=
But I do not get what phylink_is_empty_linkmode() is doing...=0A=
=0A=
Regards,=0A=
=0A=
   Sven=0A=

