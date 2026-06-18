Return-Path: <netdev+bounces-300473-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MMz8B6gNNGrkMQYAu9opvQ
	(envelope-from <netdev+bounces-300473-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 17:24:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 883636A136E
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 17:24:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=schleissheimer.onmicrosoft.com header.s=selector1-schleissheimer-onmicrosoft-com header.b=l6pgqtBO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300473-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300473-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=schleissheimer.de (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65F063068EA3
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 15:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DCD3ECBE4;
	Thu, 18 Jun 2026 15:18:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from FR5P281CU006.outbound.protection.outlook.com (mail-germanywestcentralazon11022130.outbound.protection.outlook.com [40.107.149.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9489719E97B
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 15:18:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795925; cv=fail; b=moUb2aYzD/6DZ3zCzHSND4cH7g6L1oUV/MWRhrGuoV57Z/2EOROYqWTdSZ6qSH/jy5T4yDge9E9kR8tkqjExcVWlWURGtNS5Gi/Vl9NI4/Gq+XryGCfEKCYwSCmgP1aCJb5d7Fo2gZVUnorx2ZclODN1V3Ys2NOkmVL7eaO7FUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795925; c=relaxed/simple;
	bh=VwRVWq81GNdCd/NGiQCUjzuDuryFqpaQmZX1pTFXvZQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fyiAvZBSpY0GoHwJuALcLog3O+qLhuF5LgvEBeffxp7v83nePpBVoQ4I7rnulSN2trLHVGbXZ6XaV8BKjZfnpWOlyzZiMipY7YjPVAriHONnSJPns8VutmP1kxmJxMhXycHGP8SMKJ98EExf312o4dzR0EWCH5XTyTnpTuFgXxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de; spf=pass smtp.mailfrom=schleissheimer.de; dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b=l6pgqtBO; arc=fail smtp.client-ip=40.107.149.130
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3sdvRSARTlwehxJS+AOHzARrO3ObtQO0mHqlsNIoKsRb6OxUuv6D/SdCs9HFql37UwV0BodgXewAwFMB6hS7RPjd7/BpQK9ERYxxHGrF1G+32PBzaQuddkjsLX47uzTBhfEBuhfNubf+YSBKn6b/YymC75r4KzbEetI0tNA+iTuwJIJ9qPUDPoZLW77hiqb2QxgW09z074KAVkkxr77FiweZELR3elZgbqo9zCUMLpOVXhJ7rIR9E56zOqTKsKPtvOyCXbB5SMHaFSwgT0rvvZrCe3NVdsnTWpS3J9wnzi+wDOdpJrRfR090oPOph8kIkBzkr0+72yB8+3tc2uqCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbyB1RoMYVlbBCikex1w4qcczi52FJp3/J+aP2huLoI=;
 b=dlhx1Z7849/97KArCqwBx3vqsAJNvUiuyyvh5/xw3h0KbUp1lajfLIiIjwETw2LIOswYzSx3ps1vNNvW89BZFWcfy7y8zGetNyHQ7Cm77Itw2TZWA+QL5C7FZrRUVTz6B88+DQDcjUobrxsp8IxHUMZSQCFDRWH7GepF3eKOgH+7qFKAbfCCqRSJULjWYXCiHQYfu0KfKL/yes2fOWVqRPVXU5XKfsxWwzDtaxHhamxCK/DJggH7vXik4oNEdTP9WEnbKmFKa2uH95pnGEUG1QVIa4EPQ3WCK5WAwzbWJEr7DS5zSuX6/8Zr8Tjne8TcB9g2H5Zfr/hKnRPbwLotyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=schleissheimer.de; dmarc=pass action=none
 header.from=schleissheimer.de; dkim=pass header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbyB1RoMYVlbBCikex1w4qcczi52FJp3/J+aP2huLoI=;
 b=l6pgqtBOhHt3FkIztO0CJXqVafqe2KoB6npWEgE/rZa++OnODcKx9o1AkTKDl6lsiQh4Ky9r3VZkf3cMtFIpgLGoRJLgMYIvNUJ67yrCDkTKIK2yslyxkRrm7XfJQURg4SjgeAS+nnzNS9BJewq7X7+RE2NW63lrltN8EeTe8aI=
Received: from BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:52::10)
 by FR1PPF80F72F156.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18::f67) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 15:18:40 +0000
Received: from BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
 ([fe80::2bc1:32a6:153:c3e9]) by BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
 ([fe80::2bc1:32a6:153:c3e9%4]) with mapi id 15.21.0139.011; Thu, 18 Jun 2026
 15:18:40 +0000
From: Sven Schuchmann <schuchmann@schleissheimer.de>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: lan7801 looses VLAN Filter Table
Thread-Topic: lan7801 looses VLAN Filter Table
Thread-Index: AQHc/zAoDsScu2AD9UerDhDSUq6BDQ==
Date: Thu, 18 Jun 2026 15:18:40 +0000
Message-ID:
 <BEZP281MB224501E38B30BFDC4BD3D364D9E32@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2245:EE_|FR1PPF80F72F156:EE_
x-ms-office365-filtering-correlation-id: 46d7b6ef-038d-4535-c38f-08decd4ce0be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|56012099006|6133799003|18002099003|3023799007|38070700021;
x-microsoft-antispam-message-info:
 94j2rUuqARUbXoU1tjmjMi4yIVj9ZKJfJ0bYdFqx5/xygqhXWp+NlPlmEt0X9Di7JJLpvxmcTDuJvEQD5dvTnTcfo11bXDA2CR0bnTw0rCtyskNKULfH8PCjCzWIrDqNtQAWAxl4gVfqge1meaLvZDdwhsBLcGzJqQ3Yiezq+cksQmMPCaiDEuR8G+WFeNsz3KW/hUmFiqR5eUixxWoMvWEiaCmK6fXOraIGngXgHi+6YLRyuVlsXy+1hMbdOFiN31ICDaVcGoO9cUmqzVmUpCKuNrh5rcCvav4MxAGiWcP9rhE2edZsQMoKi+UI5G0qooQk3K5DQnKSJd4Yq5/eJJ5waZCt6h64lmNCDvoeDb42cEbDDu/01UjbW6bg4RCRGGCrWvvWA6gV230XKvUcMBrU2vuCFjqV/PMktp0yUcXKxrudMvTGqC5rl3eg8R/7NyiMOfCdrNaHXK03RzUM/S6KVkguEmQqlOS0q0n2COrOdeMY5dqloyafKL2T4zxupd4xgC2JFwV/ZXiRr01WOsQASTMaND43Ell+MA4i8dYW2fHBWVu5RFx7zgghoBYB+/ASnIuB8F955n7zPeJIwtzeyNdxqWZTsXDNKfMFWWjD5OQoEkIL0QWxt/2OLDSKZ7tl5ofptwO0K9yGQ8CF+w933GqvaDHhxA6kQl6m5b9sdWnaTTrB89kSxPqCRZ/UxhJouH8BkNiCJ+wMQhLr8jI5d09F/fA9ucrnbuU4aYNOeCj5ycoxuVi9+j9eAy8c
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(56012099006)(6133799003)(18002099003)(3023799007)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?7Q7FlRakLxibPXu9niYtqPCUdpzlV3Tr1cjXYNVQzH/NlsqobuV+ykWOfG?=
 =?iso-8859-1?Q?NcYoZ7KIcOHxPpD9ADN9pLnNgVxcnZXX0ulVgI6zK/esIveZbBwtZ5tRyp?=
 =?iso-8859-1?Q?rcR5j5kKTbbP31YPK2+e/497nBVw08nWC/FBd8ekn/odODw3Ped79AAmHW?=
 =?iso-8859-1?Q?h4tbsU8htn784pDRLnDEIEUkT2epU0xWz8eV6IhWWYtXU4AofoOtf0+zP9?=
 =?iso-8859-1?Q?odclEEC4+QfMcQRK3PsNm00FGQFSXE+dexftk22Vr0iPU7w7UdsknsA7BH?=
 =?iso-8859-1?Q?fSQsO/NuKxFuUyiN6zhrhWzaKUWFbu1XNd7mAfuK8ZiemgfKFcqgXhRSh4?=
 =?iso-8859-1?Q?czaveF5PjFxKrH4In/3dHpRUcCl/cSwQZ9R2zIL5WqxmT2B9/UusuHbXmn?=
 =?iso-8859-1?Q?EaevLxMRMdeuvnbYKpZtc69tlE2AhOiW8iRJ5M27nMXJkqzEfOASchbKu8?=
 =?iso-8859-1?Q?s3PCiVdhKkyATydOlL99zuFq5t2aPHTBGAg1Tl8MxJh5TfdZDovxVvIiFM?=
 =?iso-8859-1?Q?lS1UlcYoBLY/tl+EcBW6AP7248MpDLxgsHPS0HDGglF2Bf1qXeHfBbTyjO?=
 =?iso-8859-1?Q?qQpSGP4JPu9PuuyFVWarZnMuB3KXjWcE0ObPeN01VlN7FVLnzOAOICPKIe?=
 =?iso-8859-1?Q?f9ESDV/PIuWpoiaulecO4gSY9fAVF9IaIYKE9yStutCQifEldZetiWusSM?=
 =?iso-8859-1?Q?a7RL7NmF79cigECRBgmWqtCYr3XxR+VFjKc+qVCu1Ipiv/QVd3HpHwGMXr?=
 =?iso-8859-1?Q?/YrZsy91tqLSSwKCwucxHW4djuc7GApgXsAbHSzbJGn5pV2/CfZjQYiC+7?=
 =?iso-8859-1?Q?V/kH4Kx4DpujSKV4G3/hxqHtZMCrBBmc5FEcn06yinTHWP3yllXcyqvmnr?=
 =?iso-8859-1?Q?5bl4/ODPmE/6telMYlj8sv6j9/kEX8DRW77saev7c6S7oyDW+tikgRWpmC?=
 =?iso-8859-1?Q?ZUryvRFRmT9k2n6zwBbgkGKlXtbZpDqChiims+mx73WOAqRVNZREcn0sPe?=
 =?iso-8859-1?Q?cVnR59aVuUwsAC4DCf+sDti4mJAWFW/Bq7qOWRlV6DtB7n0pzJm+cB7qZL?=
 =?iso-8859-1?Q?tJIp/N2ZTC3KxLXRwxr6F/hi9DblTrS/DXpDWP5aGGTTFPsmvKmu1kw68Q?=
 =?iso-8859-1?Q?FHlS39QKKyxKuc439N6K7e67N1woVa5rSlLDrcnBAae5D6wjAQPiBvsfGr?=
 =?iso-8859-1?Q?gRoJAd1ShJ0FkLnIvINtZZdNvMFLrDnsPwPr8vQD8tsZ7AB729m9xiv9Lo?=
 =?iso-8859-1?Q?gafk4Xj5R0jPWygV1rx9f5SzSTmJXbEpdAhTWkHRKkSNEhzjt6gOQOxbkw?=
 =?iso-8859-1?Q?r8w8XpgyBxsZnoSB1WqRL+Th7+OiNOOGByHuzgihG+w45kTl7vPFuhxl/c?=
 =?iso-8859-1?Q?4DkBxJbPFejRUUGP40lRk1eaziWH2rtNcBdRhCDrzMb01S1Ob8XwXcE8W7?=
 =?iso-8859-1?Q?wnThOI6XkrQ1zHH0aYFI+Z3BXO9TgKYfgkGRKMq7hW61eQxbTZ0crCbJB+?=
 =?iso-8859-1?Q?W6t8ocsrjm6c3oJyNpUlk/QX8X84raMDDGm7UHYt8OZAvwhILdfp8GbH5u?=
 =?iso-8859-1?Q?Pv97fE5DZX5UjtSjrXfRRlYq5Ms7b/WHRoHyzB9V5ed5EQj/8+KVNgTQWs?=
 =?iso-8859-1?Q?VEM+QZlGnrzT4wWL0+qzv27wACjiPwSOiYvqGLHT6s12KYa4o0AsMtOcRC?=
 =?iso-8859-1?Q?pqQ1qNG8ObWhb62K3scrxWSrIssDreh8L0fv0VelChBakb2gWPoPVXgGKe?=
 =?iso-8859-1?Q?4Pag8kqlK3yrKM4l4G2frxayupfVzzeS1PnVIG/BZ5+BoNcEaLo1q6uJXM?=
 =?iso-8859-1?Q?qD6oMoKz+w=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d7b6ef-038d-4535-c38f-08decd4ce0be
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2026 15:18:40.4808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WxuFUNGG9KeZBq1WEwUwA6PKdLkAivUpnQ5J8NnPPtqhCWHrhREl8Oh5vgtPYG8bNTQBrbBOU3lonlM8FwjfVyI5VQZeienHTczTfMp5qL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR1PPF80F72F156
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[schleissheimer.onmicrosoft.com:s=selector1-schleissheimer-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[schleissheimer.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300473-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[schuchmann@schleissheimer.de,netdev@vger.kernel.org];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schuchmann@schleissheimer.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[schleissheimer.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 883636A136E

Hi,=0A=
I have a problem with a lan7801 chip in Kernel 6.18. I configure VLAN-ID (2=
) and an IP address.=0A=
But if I disconnect and connect the network-cable several times at some poi=
nt no packets are =0A=
received anymore. Without using VLAN this does not happen.=0A=
=0A=
I tracked this down that sometimes the VLAN Filter table seems=0A=
to get cleared. I hooked into the lan78xx.c driver to dump the vlan table:=
=0A=
=0A=
static void lan78xx_get_stats(struct net_device *netdev,=0A=
			      struct ethtool_stats *stats, u64 *data)=0A=
{=0A=
	struct lan78xx_net *dev =3D netdev_priv(netdev);=0A=
	struct lan78xx_priv *pdata =3D (struct lan78xx_priv *)(dev->data[0]);=0A=
=0A=
	lan78xx_update_stats(dev);=0A=
=0A=
	for (int i =3D 0; i < 3; i++) {=0A=
		u32 buf;=0A=
		lan78xx_dataport_read(dev, DP_SEL_RSEL_VLAN_DA_, i, 1, &buf);=0A=
		if (pdata->vlan_table[i] !=3D buf) =0A=
			netdev_err(dev->net, "VLAN TABLE %d: 0x%08x 0x%08x", i, pdata->vlan_tabl=
e[i], buf);=0A=
		else=0A=
			netdev_info(dev->net, "VLAN TABLE %d: 0x%08x 0x%08x", i, pdata->vlan_tab=
le[i], buf);=0A=
	}=0A=
=0A=
So I can "read out" the table if I do "ethtool -S" and see it in the kernel=
 log.=0A=
Normally the output looks like this:=0A=
VLAN TABLE 0: 0x00000005 0x00000005=0A=
So the table looks as expected. The Local Filter table from pdata is the sa=
me as in the chip itself.=0A=
=0A=
But after some cable disconnects and connects I see this:=0A=
VLAN TABLE 0: 0x00000005 0x00000000=0A=
So the table got cleared or deleted and no paketes on VLAN-ID 2 go through.=
=0A=
I even can do this after I read out the table in lan78xx_get_stats():=0A=
=0A=
	lan78xx_dataport_write(dev, DP_SEL_RSEL_VLAN_DA_, 0,=0A=
				DP_SEL_VHF_VLAN_LEN, pdata->vlan_table);=0A=
=0A=
...and with this I can "fix" the table again from the ethtool and it starts=
 working again.=0A=
=0A=
Has someone seen something like this or can point me to a direction where=
=0A=
I could reinit this table (I already tried at the end of lan78xx_mac_link_u=
p() without success...)=0A=
=0A=
Thanks!=0A=
=0A=
Regards, Sven=0A=

