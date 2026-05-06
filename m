Return-Path: <netdev+bounces-284789-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEMHM80h+2lvWwMAu9opvQ
	(envelope-from <netdev+bounces-284789-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 13:11:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 239194D99D7
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 13:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9354230115A3
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 11:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C97A3F23C1;
	Wed,  6 May 2026 11:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b="JpgkdhRV"
X-Original-To: netdev@vger.kernel.org
Received: from FR5P281CU006.outbound.protection.outlook.com (mail-germanywestcentralazon11022114.outbound.protection.outlook.com [40.107.149.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0563EB81E
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 11:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778065853; cv=fail; b=ZfEqSLYyTSeDwIKnmuK3zC+4pa2WV9UWRlC8ujeeKCgKcvgiH3Jr+jCulECBhL9RruFE1+MLkwbLLyzOZqyiIfqs+wWhGfaZ6/6uAhCcUzTLv/SVpyogjU43GdvjNEH0Kd6BE2nnsY38G7A8tLxsCotk22LUc6bylghCSJFcw90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778065853; c=relaxed/simple;
	bh=FbzXSZ3+ttaZ5RsR2OnNx85pIp0YGbN9K2fyjMkOgC0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NJ64+wTwSqtEPTBRCDSE7zQbti7mCYZM8nwSoYyXe0GzMGbTtko0rwWXJxGC2PuemfuNxweWQOhO315/p3+tk217qyPsgqtCzVU1ug66QnxSb1t8u/H/T0fYxftqqGObbtgrqozJ5NzYSglgdGOYzCSUVycjSdGuTHLs9K8djq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de; spf=pass smtp.mailfrom=schleissheimer.de; dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b=JpgkdhRV; arc=fail smtp.client-ip=40.107.149.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schleissheimer.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ogL66OUkPFU2AoAgAO9va6a/ukipDdxdg4dlDX8/qHm5pvp0cw6rxHRpiWpkga0shYV+q+yWF12YlYAj0wIjqfsMO7oTnzxUGU65HeAdIo/lYHzXPnNL8P3git4ob1o5izvos2/KAhpY7WuHxgawGRR0ae83FaIrn4k6YSAZ2iqFw/TefM44BSMdS9SZa6CZa//xGBRHNqhEgKmaps7lzbZ87Gcg9VfR5htbkrlBGLDT1QOCTUVPpAgnjP88UKW/H8kgFk4KUVA2nXrvPsS5SqF9/I38+rfGP62lf4iixRdLA7nLAGUNemSyWXXWIzy5efjuTEfrAHlwN04PFIUHoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ssZk54TSkDur5he+kFJI12n0qzRXKxFJ4Bk0aie97M=;
 b=Ixk2Y1Y9GLthlgYXVWGdXgPYO+wYF3GLCu7MXttRxegcXNfc/enm/MD9OUzzIZJEMlSeguKKBEnDsY6FNNp3D5b7u4bt0BvvBWSAAWZSDJofTqlfXU2JeoFbS/i2yxtO3nc6aDK9Dr2bGgruMsqq3OPS1pvt9IDt+GW+eu39ZbnLjFupgWRLgQ0XiQ9dQwUzQkT4VEbHGHJitO4NpQ5X0w2L39Ra4AQY4g36A1qEptItTitPGU5XeZ6QtcUafxK9VPhB2eo2MnG7oerY1k6Dmo/JIQiOHm3pEqZU17FY3bmI/wPZ3PhKwKZ46z+C3wTFVAujcR4xQOOq8Pnl+Z0x+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=schleissheimer.de; dmarc=pass action=none
 header.from=schleissheimer.de; dkim=pass header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ssZk54TSkDur5he+kFJI12n0qzRXKxFJ4Bk0aie97M=;
 b=JpgkdhRVfiyj24B9LlFiHLdJCz33MSuE2vJ93Zu1ufzvIreoiUdF9QbgWb7uywwYr4rYJ1rrv0tdtTqEat1AsWuqqMmzYCQIDeiTNQysyzf0SdhzY3P4H9ps0jgHo9G9aoUYA1GqDtfXlByDar4ouU4Ixcp6wvtsNMY6dKZBFLM=
Received: from BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:52::10)
 by FR6P281MB3504.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:c5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 11:10:43 +0000
Received: from BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
 ([fe80::2bc1:32a6:153:c3e9]) by BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
 ([fe80::2bc1:32a6:153:c3e9%4]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 11:10:43 +0000
From: Sven Schuchmann <schuchmann@schleissheimer.de>
To: Andrew Lunn <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: AW: assert in phylink.c with lan7801 and dp83tc811 since kernel 6.18
Thread-Topic: assert in phylink.c with lan7801 and dp83tc811 since kernel 6.18
Thread-Index: AQHc3HSt2FaNRg+Hc0Clgdk/8rilD7X/aQMAgAEuzo8=
Date: Wed, 6 May 2026 11:10:43 +0000
Message-ID:
 <BEZP281MB22458F571CC8251C141D933CD93F2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
References:
 <BEZP281MB224533D524B27CFC6E47B447D93E2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <57fb63c2-7a05-4bbe-ba2d-fc61ce1e3ba1@lunn.ch>
In-Reply-To: <57fb63c2-7a05-4bbe-ba2d-fc61ce1e3ba1@lunn.ch>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=schleissheimer.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2245:EE_|FR6P281MB3504:EE_
x-ms-office365-filtering-correlation-id: e4c7d0a9-edca-4454-2d0c-08deab601d80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 BiIOscGKZ/ENQ9wRA7c7EakuHDC2mR6w9s+E3gLr0reNlzEivEwmkO8LLUd4imspAfeEl4ZX96H3UtNYfcxDtdnmqukhKML0YVD0m4Zu8u026ybyqwhreORwUKWAYmkWMtBewfYdzbCPFunfP+MhpG9cU38NjO3q5A+xBVE18B+A4/pEFZNV+MF4g40uodLJTu5fcryR8B7Q7FaWrdkNGQaN1IGkSF/RPH/Ju6bemtOSPsZJxuJ0cXRhfmqcjS9Ciozfx6YcTsEUXmtWrq+JS+9kJ3ZC02H/eFtbWdNPUPDIgsuz1XT4JH5j9HfeBOmwhQ0yFETh6xtPIaGV7h52CtMUc2nxB6MGU8iksLK27yf7qN/XYYHVjEHKzx0P7U/N0W6Zi9Fg3cvSvEiyOuJeY8j5Uu60w8z13EDa/mRAi8jxHqGuec6hx8Gm8mHZ4ErjiGRFwZaVYbL0sbG/IHagCtNHrVRcNX5eCnEnQTeZgW1/MFwpbzMzCTwn6UtnJT6FGxqYnqg7CvgSEet+UYQun/ZxptobetFZBOASrFJV8R3d6kiTpPcLPmLStzsIvWGcSHBWuYBGpyBiSmTQ2SWhx1c9ZPEJF4PMXXJhAgSv9GREmqHBGY6O99zPJ9yXj58aFtZdWUJbgCKGjp+fIelP6GoBhUfhVJZlLpw+PBWnNHtT/pm72GR5L/EdOnwy+QDWOdyoiyAG/WvZzUTw60niy0fpZ8P0J5a/FpycXfNj6wtts2tJyWZxybafsmxLgWvn
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Xd65e6oFh1zbu2ZWDg/f0CCh3cuuc1sTYBUHqelJaGBvZ7Sx7QP5NKQJlj?=
 =?iso-8859-1?Q?CfwMFjyI0PEgncjm/yzCVWBHqyYAv6Xgcwx/2X5wwBZYB/c7/2yrGAqkp9?=
 =?iso-8859-1?Q?V+PeBUexLoYBahesFb4F77DsMdVQpmWps578ql0JSO2XHCRIvxYIYVxQD2?=
 =?iso-8859-1?Q?6/dlAVvTVEsKe2gGb4H6G9i7rMxUgPQyZe7B1BijSasnNl6RXPm7LnjqLF?=
 =?iso-8859-1?Q?80DpdFznYBCBLJa+XcpIk1KknoNmJRQhbjsuySNoIEtXVCJ9c9zrVl4cs9?=
 =?iso-8859-1?Q?QnckYf4G3qSzr4gL/cnIemrWDGY+Kpq3SGiiHtI4ikz8btbl6fFL46Za0P?=
 =?iso-8859-1?Q?sMxX2ivRryIciFkU4wSZ+h8/EXaKa1e4mo0lTUMMfd+LjE1JGujQFEqkD5?=
 =?iso-8859-1?Q?M3YQ9w9uEHwSOY16a0I/gTPThD4fZ/j8PJ0lKdpLGs+VZ2aG0V31EkbgFM?=
 =?iso-8859-1?Q?S+uwj5TA0Qe4tYIP+Rd90PWAEbH6Sq2fcPv4NRNZav1b7m0ksPmbe8eCm8?=
 =?iso-8859-1?Q?TosjdEjilKo8x/LCVdjIzYT/Kvkv9KyBvDqZs2AVtB2t4MJZqMvTRLax89?=
 =?iso-8859-1?Q?NuHGPoufN2OtgFcU38+TDLyHNFxAjY5Vylt1zZ9P3Uz9ZF4Y5I4EqEY80h?=
 =?iso-8859-1?Q?hbnzOvAUUSzBw3cCNIxwkKMDcu19A7SZsI7Un818f90grIO43X1pVSNvoD?=
 =?iso-8859-1?Q?NgydBbhtB8cgfiDHGyPOFmQeA2nsgPeXsO/8//sBiqx7K/Y2pdGB4Ws0ji?=
 =?iso-8859-1?Q?2PcER9X/dV78f+lGZG+pg5gMjJvGmLbvH2SOnzacSXojqPtXRplKlsmt3d?=
 =?iso-8859-1?Q?Zm6HDJJQ6CJg5PHH/KriSa8qQQcC2yNBpXCnBZChBqy/zYMjDPn0XiiImu?=
 =?iso-8859-1?Q?RYi18TSwdEfsth8xkcj/UuyM9QOlkeFILVeOlJZTyBdHpzYo8DQVeZe9MM?=
 =?iso-8859-1?Q?SNdt/Qddk/RRvQvpFwx4HkYIpxTjbejDZjzOJ890mvvlxfzlx8sYi7kxa/?=
 =?iso-8859-1?Q?6IlAV02UNmKPCICt24Kl1OnC3gqRzX8JXUi3faL901jJtQ5Ipa7fx48LUP?=
 =?iso-8859-1?Q?EopNxOob4OO1NpGEy+97PZch3ntCst8/qc0bYoBexrkbBcohXlSTcJ7uXW?=
 =?iso-8859-1?Q?HzgcZmSfljnOpdl6/ix2eKm7vqEskbIyQxYkKMbj1Annyf2FMnJMwDNYva?=
 =?iso-8859-1?Q?WD3RT85TcAIM9yvZpBloYjTHOXlQwxanTsXGgEdNfgYfdHYNBhamfDu5Ge?=
 =?iso-8859-1?Q?vxlrOk/bLRpET1dW7b3SQ8NSahhwqyB2CFgHfmeAwC2hwR4uhwfvEmpNKB?=
 =?iso-8859-1?Q?fDGTeYBkGesh4e1x8BOsVPmRunMQ0jblraDgxOKxquIznlO/N4rGpJjgu6?=
 =?iso-8859-1?Q?BwNtGXXKnudcEpnOeY2WeBbTsYi1fu83Jshvq//vnZ483IVKx+ey+w330U?=
 =?iso-8859-1?Q?D5urEHnfdYeZVI9vKJW34ucQ8RHYUagpt8b47fVNqcI3oNPdvMR+ubphtT?=
 =?iso-8859-1?Q?Ucs9X/iGtLW81sobBMW90KGMBQ49hC6ubsZRynm9U4d3lWygQe5eNHl2KE?=
 =?iso-8859-1?Q?vshc5Vk84I/QUvJeBW5/WOAUKVNDt/18Y19ANhwwj1dmmLqsSEMWscYa9Y?=
 =?iso-8859-1?Q?5bw4qSz1Jg+nJ1ubSWbUAO5LusOLbYspd6R089Dc4W31rR5KLjqdRZnKTA?=
 =?iso-8859-1?Q?9PWUaBWaBY3WlbUs9ukx5ekNvANEhr/OHEwXkLDeF1kEwEj7JPmZBHhy2A?=
 =?iso-8859-1?Q?hFyWiT/UJ6AmaroB63FnLUHVaUG1vj+k2HelG/X9FP8st6NS2NaaZW+Bjp?=
 =?iso-8859-1?Q?2OG2Xg7Pmw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c7d0a9-edca-4454-2d0c-08deab601d80
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 11:10:43.3204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AGHsw8xDzjnYWQHANJZYrUrFeHkZ0AB0DEQONXS3UodbRb7I3C5V+eISISmyERXBP8X36Nqz22rXrl/aGRMQSyWCjQleI6rFZJCh4b3/jVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR6P281MB3504
X-Rspamd-Queue-Id: 239194D99D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[schleissheimer.onmicrosoft.com:s=selector1-schleissheimer-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[schleissheimer.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-284789-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schuchmann@schleissheimer.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[schleissheimer.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM:mid,lunn.ch:email,schleissheimer.onmicrosoft.com:dkim]

Hi Andrew=0A=
=0A=
> Von:=A0Andrew Lunn <andrew@lunn.ch>=0A=
>  On Tue, May 05, 2026 at 09:53:06AM +0000, Sven Schuchmann wrote:=0A=
> > Hello,=0A=
> > I have a raspberrypi and switched from kernel 6.12 to 6.18 and now I ha=
ve a crash in phylink.c.=0A=
> Please could you try 7.0.3, or better still, 7.1-rcX. We need to=0A=
> determine if the problem has already been fixed and just needs=0A=
> backporting, or is it a new problem.=0A=
=0A=
Now tried with: Linux rpi 7.1.0-rc2-v8+ #6 SMP PREEMPT Wed May  6 09:07:34 =
CEST 2026 aarch64 GNU/Linux=0A=
=0A=
> Please could you make line 1 of drivers/net/phy/phylink.c.=0A=
Also done=0A=
=0A=
Still crashing -> see below for more details=0A=
[    2.153568] usb 1-1.3: new high-speed USB device number 3 using dwc2=0A=
[    2.266726] usb 1-1.3: New USB device found, idVendor=3D0424, idProduct=
=3D7801, bcdDevice=3D 3.00=0A=
[    2.266762] usb 1-1.3: New USB device strings: Mfr=3D1, Product=3D2, Ser=
ialNumber=3D3=0A=
[    2.266772] usb 1-1.3: Product: LAN7801=0A=
[    2.266781] usb 1-1.3: Manufacturer: Microchip=0A=
[    2.266789] usb 1-1.3: SerialNumber: 00800F780100=0A=
[    2.323106] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): int =
urb period 64=0A=
[    2.334333] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): PHY =
usb-001:003:00 doesn't supply possible interfaces=0A=
[    2.334360] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): vali=
dation of rgmii-id with support 00000000,00000000,00000000,00006280 and adv=
ertisement 00000000,00000000,00000000,00006280 failed: -EINVAL=0A=
[    2.339481] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): can'=
t attach PHY to usb-001:003, error -EINVAL=0A=
[    2.339519] ------------[ cut here ]------------=0A=
[    2.339525] RTNL: assertion failed at drivers/net/phy/phylink.c (2351)=
=0A=
[    2.339613] WARNING: drivers/net/phy/phylink.c:2351 at phylink_disconnec=
t_phy+0xf0/0x100, CPU#0: kworker/0:0/9=0A=
[    2.851713] Modules linked in:=0A=
[    2.854770] CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted 7.1.0-rc2=
-v8+ #6 PREEMPT=0A=
[    2.862861] Hardware name: Raspberry Pi Compute Module 4 Rev 1.0 (DT)=0A=
[    2.869297] Workqueue: usb_hub_wq hub_event=0A=
[    2.873486] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)=0A=
[    2.880444] pc : phylink_disconnect_phy+0xf0/0x100=0A=
[    2.885233] lr : phylink_disconnect_phy+0xf0/0x100=0A=
[    2.890021] sp : ffffffc08006b4d0=0A=
[    2.893328] x29: ffffffc08006b4d0 x28: ffffff810703ea40 x27: ffffff81053=
e0000=0A=
[    2.900467] x26: ffffff810703eae0 x25: ffffff810703ea80 x24: 00000000fff=
fffea=0A=
[    2.907605] x23: ffffff81051ebc50 x22: ffffff81052d80b0 x21: 00000000000=
08000=0A=
[    2.914742] x20: ffffff810629a000 x19: ffffff8105a50600 x18: 00000000000=
00006=0A=
[    2.921879] x17: 74612074276e6163 x16: 203a2964657a696c x15: 07790768077=
0072f=0A=
[    2.929016] x14: 07740765076e072f x13: 077907680770072f x12: 07740765076=
e072f=0A=
[    2.936152] x11: 0720072007200720 x10: 0720072007200729 x9 : ffffffe227d=
591ec=0A=
[    2.943289] x8 : 0000000000000128 x7 : ffffffe22941d100 x6 : ffffffe2294=
1d100=0A=
[    2.950426] x5 : 3fffffffffffefff x4 : bffffffffffff000 x3 : 00000000000=
00000=0A=
[    2.957563] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffffff81003=
3de80=0A=
[    2.964701] Call trace:=0A=
[    2.967141]  phylink_disconnect_phy+0xf0/0x100 (P)=0A=
[    2.971932]  lan78xx_probe+0x9e4/0xda0=0A=
[    2.975679]  usb_probe_interface+0x13c/0x360=0A=
[    2.979946]  really_probe+0xc4/0x2d0=0A=
[    2.983521]  __driver_probe_device+0x88/0x160=0A=
[    2.987876]  driver_probe_device+0x44/0x160=0A=
[    2.992057]  __device_attach_driver+0xc0/0x150=0A=
[    2.996499]  bus_for_each_drv+0x90/0x100=0A=
[    3.000419]  __device_attach+0xa8/0x1a0=0A=
[    3.004252]  device_initial_probe+0x58/0x68=0A=
[    3.008433]  bus_probe_device+0x40/0xb0=0A=
[    3.012266]  device_add+0x5a4/0x7b8=0A=
[    3.015751]  usb_set_configuration+0x548/0xab0=0A=
[    3.020195]  usb_generic_driver_probe+0x5c/0xa0=0A=
[    3.024724]  usb_probe_device+0x44/0x140=0A=
[    3.028645]  really_probe+0xc4/0x2d0=0A=
[    3.032218]  __driver_probe_device+0x88/0x160=0A=
[    3.036573]  driver_probe_device+0x44/0x160=0A=
[    3.040754]  __device_attach_driver+0xc0/0x150=0A=
[    3.045195]  bus_for_each_drv+0x90/0x100=0A=
[    3.049114]  __device_attach+0xa8/0x1a0=0A=
[    3.052947]  device_initial_probe+0x58/0x68=0A=
[    3.057128]  bus_probe_device+0x40/0xb0=0A=
[    3.060961]  device_add+0x5a4/0x7b8=0A=
[    3.064446]  usb_new_device+0x1bc/0x4e8=0A=
[    3.068278]  hub_event+0xde8/0x1560=0A=
[    3.071763]  process_one_work+0x164/0x4e0=0A=
[    3.075774]  worker_thread+0x19c/0x320=0A=
[    3.079519]  kthread+0x138/0x150=0A=
[    3.082742]  ret_from_fork+0x10/0x20=0A=
[    3.086317] ---[ end trace 0000000000000000 ]---=0A=
[    3.113678] lan78xx 1-1.3:1.0: probe with driver lan78xx failed with err=
or -22=0A=
=0A=
due to my limited debugging skills I put my kernel over here:=0A=
https://github.com/Schuchmann/rpi_lan78xx=0A=
=0A=
added some code to maybe get a better idea:=0A=
https://github.com/Schuchmann/rpi_lan78xx/pull/1/changes=0A=
=0A=
[    2.117653] usb 1-1.3: new high-speed USB device number 3 using dwc2=0A=
[    2.214810] usb 1-1.3: New USB device found, idVendor=3D0424, idProduct=
=3D7801, bcdDevice=3D 3.00=0A=
[    2.214840] usb 1-1.3: New USB device strings: Mfr=3D1, Product=3D2, Ser=
ialNumber=3D3=0A=
[    2.214850] usb 1-1.3: Product: LAN7801=0A=
[    2.214857] usb 1-1.3: Manufacturer: Microchip=0A=
[    2.214864] usb 1-1.3: SerialNumber: 00800F780100=0A=
[    2.215258] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): --1-=
-=0A=
[    2.215275] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): --2-=
-=0A=
[    2.215284] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): --3-=
-=0A=
[    2.215310] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): --4-=
-=0A=
[    2.215334] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): --5-=
-=0A=
[    2.215350] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): --6-=
-=0A=
[    2.215358] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): --7-=
-=0A=
[    2.215365] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): --8-=
-=0A=
[    2.215373] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): --9-=
-=0A=
[    2.215380] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): --10=
--=0A=
[    2.215388] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): --11=
--=0A=
[    2.225577] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): defe=
rred multicast write 0x00007ca0=0A=
[    2.272191] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): regi=
stered mdiobus bus usb-001:003=0A=
[    2.272211] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): --12=
--=0A=
[    2.272234] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): --13=
--=0A=
[    2.272243] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): int =
urb period 64=0A=
[    2.272254] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): --14=
--=0A=
[    2.272263] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): --15=
--=0A=
[    2.272270] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): --16=
--=0A=
[    2.272282] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): --17=
--=0A=
[    2.272289] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): --18=
--=0A=
[    2.272300] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): phy:=
 --3.2--=0A=
[    2.272305] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): phy:=
 --3.3--=0A=
[    2.272312] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): phy:=
 --3.4--=0A=
[    2.272316] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): phy:=
 --3.5-- 0=0A=
[    2.272433] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): phyd=
ev->irq =3D 37=0A=
[    2.272440] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): phy:=
 --1--=0A=
[    2.272444] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): phy:=
 --2--=0A=
[    2.283504] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): phy:=
 --3--=0A=
[    2.283520] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): PHY =
usb-001:003:00 doesn't supply possible interfaces=0A=
[    2.283528] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): PHY =
usb-001:003:00 --1.1--=0A=
[    2.283533] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): PHY =
usb-001:003:00 --1.2--=0A=
[    2.283538] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): phy:=
 --3.2--=0A=
[    2.283542] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): phy:=
 --3.3--=0A=
[    2.283549] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): phy:=
 --3.4--=0A=
[    2.283553] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): phy:=
 --3.5-- -22=0A=
[    2.283559] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): vali=
dation of rgmii-id with support 00000000,00000000,00000000,00006280 and adv=
ertisement 00000000,00000000,00000000,00006280 failed: -EINVAL=0A=
[    2.288572] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): can'=
t attach PHY to usb-001:003, error -EINVAL=0A=
[    2.288617] ------------[ cut here ]------------=0A=
[    2.288624] RTNL: assertion failed at drivers/net/phy/phylink.c (2377)=
=0A=
[    2.288730] WARNING: drivers/net/phy/phylink.c:2377 at phylink_disconnec=
t_phy+0xf0/0x100, CPU#0: kworker/0:2/68=0A=
[    2.962641] Modules linked in:=0A=
[    2.965698] CPU: 0 UID: 0 PID: 68 Comm: kworker/0:2 Not tainted 7.1.0-rc=
2-v8+ #12 PREEMPT=0A=
[    2.973963] Hardware name: Raspberry Pi Compute Module 4 Rev 1.0 (DT)=0A=
[    2.980399] Workqueue: usb_hub_wq hub_event=0A=
[    2.984589] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)=0A=
[    2.991547] pc : phylink_disconnect_phy+0xf0/0x100=0A=
[    2.996335] lr : phylink_disconnect_phy+0xf0/0x100=0A=
[    3.001122] sp : ffffffc080d034d0=0A=
[    3.004430] x29: ffffffc080d034d0 x28: ffffff8105f0ea80 x27: ffffff8105f=
0eb28=0A=
[    3.011568] x26: ffffff8105f0eae0 x25: ffffff810622bc50 x24: 00000000fff=
fffea=0A=
[    3.018705] x23: ffffff81058708b0 x22: 0000000000008000 x21: ffffff81058=
77000=0A=
[    3.025842] x20: ffffff8105f0ea40 x19: ffffff810027ce00 x18: 00000000000=
00006=0A=
[    3.032979] x17: 74612074276e6163 x16: 203a2964657a696c x15: 07790768077=
0072f=0A=
[    3.040116] x14: 07740765076e072f x13: 077907680770072f x12: 07740765076=
e072f=0A=
[    3.047253] x11: 0720072007200720 x10: 0720072007200729 x9 : ffffffd85f3=
591ec=0A=
[    3.054390] x8 : 000000000000014a x7 : ffffffd860a1d100 x6 : ffffffd860a=
1d100=0A=
[    3.061527] x5 : 3fffffffffffefff x4 : bffffffffffff000 x3 : 00000000000=
00000=0A=
[    3.068664] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffffff81024=
19f80=0A=
[    3.075801] Call trace:=0A=
[    3.078241]  phylink_disconnect_phy+0xf0/0x100 (P)=0A=
[    3.083031]  lan78xx_probe+0xb00/0x1208=0A=
[    3.086865]  usb_probe_interface+0x13c/0x360=0A=
[    3.091132]  really_probe+0xc4/0x2d0=0A=
[    3.094709]  __driver_probe_device+0x88/0x160=0A=
[    3.099064]  driver_probe_device+0x44/0x160=0A=
[    3.103244]  __device_attach_driver+0xc0/0x150=0A=
[    3.107686]  bus_for_each_drv+0x90/0x100=0A=
[    3.111605]  __device_attach+0xa8/0x1a0=0A=
[    3.115438]  device_initial_probe+0x58/0x68=0A=
[    3.119618]  bus_probe_device+0x40/0xb0=0A=
[    3.123451]  device_add+0x5a4/0x7b8=0A=
[    3.126935]  usb_set_configuration+0x548/0xab0=0A=
[    3.131377]  usb_generic_driver_probe+0x5c/0xa0=0A=
[    3.135907]  usb_probe_device+0x44/0x140=0A=
[    3.139827]  really_probe+0xc4/0x2d0=0A=
[    3.143399]  __driver_probe_device+0x88/0x160=0A=
[    3.147753]  driver_probe_device+0x44/0x160=0A=
[    3.151934]  __device_attach_driver+0xc0/0x150=0A=
[    3.156375]  bus_for_each_drv+0x90/0x100=0A=
[    3.160294]  __device_attach+0xa8/0x1a0=0A=
[    3.164127]  device_initial_probe+0x58/0x68=0A=
[    3.168307]  bus_probe_device+0x40/0xb0=0A=
[    3.172140]  device_add+0x5a4/0x7b8=0A=
[    3.175624]  usb_new_device+0x1bc/0x4e8=0A=
[    3.179456]  hub_event+0xde8/0x1560=0A=
[    3.182940]  process_one_work+0x164/0x4e0=0A=
[    3.186949]  worker_thread+0x19c/0x320=0A=
[    3.190694]  kthread+0x138/0x150=0A=
[    3.193917]  ret_from_fork+0x10/0x20=0A=
[    3.197495] ---[ end trace 0000000000000000 ]---=0A=
[    3.202212] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): --ou=
t: free_urbs--=0A=
[    3.202245] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): --ou=
t: out5--=0A=
[    3.202725] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): --ou=
t: out4--=0A=
[    3.225689] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): --ou=
t: out3--=0A=
[    3.225735] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): --ou=
t: out2--=0A=
=0A=
So for me it somewhere happens in phylink_validate_mac_and_pcs()=0A=
=0A=
Regards,=0A=
=0A=
   Sven=0A=

