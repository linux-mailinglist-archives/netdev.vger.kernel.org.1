Return-Path: <netdev+bounces-293253-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Mi0BVD0GWp/0AgAu9opvQ
	(envelope-from <netdev+bounces-293253-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 22:17:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6875F60860F
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 22:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE60A324ACE0
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 20:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1541944102A;
	Fri, 29 May 2026 20:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="Dc+aUNFC"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13ED43634C
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 20:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780085096; cv=none; b=FZseBB2dTWjO3lyZwPLRr01HG9iAic6UYUTmh8IWM48S/nJ2Rsk7VC8BbT0Lg3q2uKVpO+y5am3dH6DlZDHSX4Yo3cEiobzbAljQRe95esE5KohzHPEZqbmtmvXtPiNysjyaxncIJ2XaFcbNmK7wwA/cDUs6sIR27LvZi1xkaz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780085096; c=relaxed/simple;
	bh=EZomTI6q0rQ4u063QpbNEcA8qv2HA5iQGDoXnxEfmHU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ryqqfIPMVZQFYPKCCslH0abe8FDnAMBf0DY+0ySaJxTBzVOIFyEgqw0fq7LcMBqCuRuQL4w/YlWiJQvNi92KwqAfMCBAAaZbhqkhAQ7frLkW2GK8pjFB0fM3UI71zSAaib3Pi/afKt0FF9TnWydTZz0WgjAFf0lXhUhd6+0i/Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=Dc+aUNFC; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1780085094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=W2EYXIUhU83ErKk4w/DZ2dmf5K0JympZ28I+tjg3eNE=;
	b=Dc+aUNFChtpyML2w1duI2RLtTR/nw+0O1nI+b294dB7xvknZShSpvM2qzm2VTvJA1WG+ft
	h802UlAFlxaOFi8Js0SlmAJtzRBksGLcxuv2pDdqIUy5WmQCZa6uzpYc/gGtClnzMREs/2
	h2thw9h3AlwJ0QwA9GNSu50o10HB4BGTuJ4xBtmoZTrWEFxb/6Q44UtAaiye5FfPCgHF1s
	9nb4xd8l5ix4HzvlPIWgZTshXoK94Ot0h+GEwn5poIYiJXyU8j2x0AvoHkisE3HPdL3YCA
	ONJhhp0cepi851xKT2xRxYF+W26Oc7UnZ8Tgr98LUaggOCGTijOJ9oVpHHCkbg==
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011051.outbound.protection.outlook.com [52.101.52.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-53-ZKJquL6WOBuZWFJ3exzDhA-1; Fri,
 29 May 2026 13:04:51 -0700
X-MC-Unique: ZKJquL6WOBuZWFJ3exzDhA-1
X-Mimecast-MFC-AGG-ID: ZKJquL6WOBuZWFJ3exzDhA_1780085089
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by CO6PR02MB7746.namprd02.prod.outlook.com (2603:10b6:303:a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 20:04:48 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 20:04:47 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: "parthiban.veerasooran@microchip.com"
	<parthiban.veerasooran@microchip.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net v2 1/2] net: ethernet: oa_tc6: Interrupt is active low
 level triggered
Thread-Topic: [PATCH net v2 1/2] net: ethernet: oa_tc6: Interrupt is active
 low level triggered
Thread-Index: Adzvpfk80BzypOEXSWilBbcbc/8jMQ==
Date: Fri, 29 May 2026 20:04:47 +0000
Message-ID: <CY8PR02MB9249CAD6EFA9DFD15D8C9B9D83162@CY8PR02MB9249.namprd02.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|CO6PR02MB7746:EE_
x-ms-office365-filtering-correlation-id: cc0e7b3a-097b-4ec3-7986-08debdbd8913
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|56012099006|6133799003|11063799006|18002099003
x-microsoft-antispam-message-info: ggEbbgCALR1FDUd9ujecdNcTblsJj10loA4UIyFvciey9JMvtSayZkxv/WnG8cX2h33iY5hVh+gH1m2GZrbFYQe4EnQ0CP9b2w38BfNKRhqZOlieoqudBVrZbarosx7FOuviPj7R86QmL+5nOkprYvidRWgoq0831Dn4/D8HaEy64U/OGXbkt7dUAN25IGe9eBoF4eUIKFcUXfMN+08EI8go5PzSain7avLHQbW8vqRYbyOHTpy1JTA7Zsp/8PfsAeUuN20So0qNy9btrCs3O4BTLAo6GwJ2zXIaAi+qvBEiV4wqYnsX5mQZ5Amy5WWIPuSj825ZVsd6E+eImyAK94coRdLP3CCp0zeol9ALz4e4PyqdsAT87Yycxj9FQ8sA/525KBzvCCMdnXejXyLzc7CruiBWU1R+eICRqZAz7s6oPGLgW7zrTbHj0vumg8MbIjNXv9WoGDA0DcVu6WTzQIxVFaiAnwJ1T/Qx91JFQHP6JAwZLtWi642bQaMebQq/1XFiyTiHwDn71eP+j2TVXE/cyZr9WFjeKKMmgCZ6fWJ91IJZc5AWg3Q83+fCoYMnXL53X+/JY9InSAmuIkbzyo9SXVDMEcN5Vm877lkyhR9dz/kVdwAq5+f0Yf2HLlyLlcdMOrQFpWusOgJfJRkYeG2dYD7E+jeSTIDlsSVKdyh2mICLP13BoAqFXGgG6RtOXLrYujB0xCxyxVQNHlPiEriZtQtenBUeokkaAv3iEHaeiY/4olI4TMFU2NaGCZw/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099006)(6133799003)(11063799006)(18002099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+ymEjBBHYpuBT+Fkz0h7PYwo3JOBGTldHfJ1OjgKH2ua3kYEoVy8usAc7Q1t?=
 =?us-ascii?Q?+IhoJ+mrhnl6P2Jb917kWLk7+88B0rrv/0bBTUXu0UQUeKPRySH0/mwDXKbD?=
 =?us-ascii?Q?zeSelJrVkiGogyNiA1LfW0wUTwyDL3AFuWhE8arG+ZfGtFkxADZSBNHaIhQw?=
 =?us-ascii?Q?HyvQfHlNemRwSQeG1Cw1lbhVeinK5TbBCpwvpbO2c49aSjI8VXbcOI7MPDYY?=
 =?us-ascii?Q?fbg42kgB8COJQusQFDrj4qJo+kvQw3NE/d3lBTjNnwGPsHlL5IXPsrZVNXUV?=
 =?us-ascii?Q?HbHnXttLAD97youJJczzG05KCWj9BcT4EaxCTwpCI2qHs1qWz68KzHgaf1pS?=
 =?us-ascii?Q?KHn0CAAjsrvM3d8hfqaVpTT3QaPhTZcK8Bx/0UTV87zQYRgxGh9H4XvB/1Cl?=
 =?us-ascii?Q?yS6M+8RMxVh0j4XNAmOUAIocZVEr4KwVTi/Ml/iTjhns+7hAToZBy6a7oYM7?=
 =?us-ascii?Q?qmu40LqKLHK6JwAcItVM8GOG+2I6RMi0LxHGnePtwgun5WHdb8l0xNLFDKbG?=
 =?us-ascii?Q?xDa5E7rrQcmZKt0mfJC77BES3vzoqXtnzC9Wx5mW1670Ptla49dEWCqwoVyT?=
 =?us-ascii?Q?l9Bo1hFqMaK1k6joIFs7gESN/e5Hjn8dkuUBMceuHfUk0U/sD72qos6aWy3z?=
 =?us-ascii?Q?sqWkZw/0a/vyeOdNFulmWS4tguhrRlpVODedYiRBD9BuDrq/MaOz0cZedfSi?=
 =?us-ascii?Q?+fL9sRJ+ByWTwARezrd8fK2HUkImLkskSjCt0g2DL31y/Mip1qiuPNY6tS3u?=
 =?us-ascii?Q?KbdFuBe2lJMzhJr2wNTralpjD5OXSM2tHeYb75I6D1XT+bUfmpg+kucvVM4s?=
 =?us-ascii?Q?tS6suakCc/SLdYmVbqytqS3N11dFOuxeFP40dWmzXbC+RBRcg1zwo4Yl+sGi?=
 =?us-ascii?Q?5kycuu6MsPoHe3RKmpNlem28QjK5KYe9gG1+7vOzfssQIcX281lBu30vFsrJ?=
 =?us-ascii?Q?f+02+6xOy/p1YbrdZQlZ5xny0nUgQhNs27tOid/vCmOfGEsfSpXFiHIW4sBZ?=
 =?us-ascii?Q?nCKZOUac8baTOWNdwy7SzGUIuZpNZfpCs5C5RETnc2eXpOl8bVfSMBzXiyYn?=
 =?us-ascii?Q?yxsGoE1+bMR+H+tlSf64GtUuvkwMCo4Toz2gF+5vPiGTyrOm7HFML/74tDaP?=
 =?us-ascii?Q?WN80hy4FElgMH8uE9fKaFTO9GgC4RnFPf+aYsoS/iP9t/edwGHiNaM1Jgkhf?=
 =?us-ascii?Q?yyaMVhFpKOZ1sp5MwMIaSZ2pwGBXQ6j9ho8/tKGXQ5JfD7fCDOyElw2XcLFt?=
 =?us-ascii?Q?B03IfhVpgIJfdjPJyIx9JplsOW3rF91UFBnH+eL2FYGJtS19c8cey5aXQWCK?=
 =?us-ascii?Q?3Lxjj+FJgsjossUovHqI23Kir1A7d7iwhsiOFOjKiwMehDruge1Qoe9PO5JW?=
 =?us-ascii?Q?JyKhy1a8C4CaTfFCAT589DO99Ge/jTWfudVG3ACKz3BtcLhpLiWwsbEzvlUV?=
 =?us-ascii?Q?1KKYWvbyxSzte8WziomXEAcPywnSTrxECSlvli4gzG85TfIIlccdxfJq9BHj?=
 =?us-ascii?Q?OtHFtbeduebPDmmFDV5AjZCPRIjh8rWnEYcgKrgb45o/vm13lTxqPdCGjM/Z?=
 =?us-ascii?Q?i0F/WoI4QxIsZ6QyyrpJ25dcKqa0MsXZMPQZ2RiiEJuIbumxB5VnCxqqLCw0?=
 =?us-ascii?Q?RjJOx9MnUEgdjM6rExmver2tSWt8JOOTB5tKXTMgbI8AA+rYBRc9LcsOYN+b?=
 =?us-ascii?Q?Zm8903RJZIgtOZL6zRXHJAgXHSjCA+hpK5rnsFgQe/FUSpOgZSIpHpgbJVFg?=
 =?us-ascii?Q?uYOWUzupkZ3jZUxw2m12uwoirTTvbko=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mkORwvNPKDttnqXO33nN2ugonO8HlVjfPXbfTzl/JwtbKOxitUHRk8CbzBukqDSgPy1UtVFnRPYSQQyusgDWJNnnUZ8S7F+KUSddqV6ejDX59IoOA6T29trffHjWzgd6tqeX3m8Gn35B+oZXZBuYDK1jwD2DNmmVmFdelX63kGyFQluc5gVRWsa4D1lf/eyz+XIUfQa8kG5nWq1WOl2mvoThi5LZxV5Ud+GUDurnk/6BHHsQ2s1YJZe4ffMgCVrPy8FTlt1t10nZOFPvnRnu5Ch+gC18vdzsQFaDQP1qR0vS0tmDCE1tmgic37MZjxNZIJtkhll2fFYMLv7Cjlv+SQ==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc0e7b3a-097b-4ec3-7986-08debdbd8913
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 20:04:47.9054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lZMRXIK3DJIhryqjUzZCiXy6/39173Qr+Wv7GzETYkRTCROnHFIJR0F8iKVTfRfSbhvAQYJvw0elqFSS7uBMaAz11u5e3PSqlPW6VTLr0ag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7746
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5IntcBARGVrCOVNGvACCmfl8g5KsTIaWXQoqnyJcsa8_1780085089
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293253-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[onsemi.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[CY8PR02MB9249.namprd02.prod.outlook.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6875F60860F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

According OPEN Alliance 10BASET1x MAC-PHY Serial Interface
specification, interrupt is active low, level triggered.

Fixes: 2c6ce5354453 ("net: ethernet: oa_tc6: implement mac-phy interrupt")
Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
---
 drivers/net/ethernet/oa_tc6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 91a906a7918a..667faf155405 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -1323,7 +1323,7 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, st=
ruct net_device *netdev)
 =09sched_set_fifo(tc6->spi_thread);
=20
 =09ret =3D devm_request_irq(&tc6->spi->dev, tc6->spi->irq, oa_tc6_macphy_i=
sr,
-=09=09=09       IRQF_TRIGGER_FALLING, dev_name(&tc6->spi->dev),
+=09=09=09       IRQF_TRIGGER_LOW, dev_name(&tc6->spi->dev),
 =09=09=09       tc6);
 =09if (ret) {
 =09=09dev_err(&tc6->spi->dev, "Failed to request macphy isr %d\n",
--=20
2.43.0


