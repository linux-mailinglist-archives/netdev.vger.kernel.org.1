Return-Path: <netdev+bounces-59677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D205A81BB9F
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 17:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 884E528D9A6
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 16:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABD958206;
	Thu, 21 Dec 2023 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="IzE/StJC";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="QJ6v7eyX"
X-Original-To: netdev@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AADD58205
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 16:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BL7029Z022989
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 16:44:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	from:to:cc:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=12052020; bh=gDDm50Pa
	FOgcSPcPJt7awimuQj3XVFDdqsl2w3GMZzU=; b=IzE/StJC1uN29Es9zPojZbu7
	xJ9TnAFZ7pK7scvmxxEz1QGBFDm0qGoS+wqu86w1/mzmaPNg9bQuzsMzfN8cNodj
	KcKHD2BdJuauKwZCjl3cxF1PsDtCv+BEE/ZjheTq7chixvyL82roLf6VA0hY6zjS
	YCeZZr4GC5xsT4eHfr8qqCmk7kkgJXESI2L7fvUqC9oRawfl16Jm/hBw0YQPlTYA
	4g+f2xuTacj600UDiMvws6slBxxAdk6hvu8nGw27QLsJefzAEIRpcZlUsoU6L9Nx
	ruulepi7oEMl4LMUMM0DIECJ59whHIgl7MaTp+6AIx2iKIulZBLLGNAnrOlVPQ==
Received: from mail.beijerelectronics.com ([195.67.87.131])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 3v10s3x8sf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 16:44:47 +0100 (CET)
Received: from EX01GLOBAL.beijerelectronics.com (10.101.10.25) by
 EX01GLOBAL.beijerelectronics.com (10.101.10.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.2375.17; Thu, 21 Dec 2023 16:44:46 +0100
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (104.47.0.50) by
 EX01GLOBAL.beijerelectronics.com (10.101.10.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.2375.17 via Frontend Transport; Thu, 21 Dec 2023 16:44:46 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpxH0oqUUsUgkb0JK4zlIFBJWeWVQM4DAAdRyqHTCE1cJy+ZjdBZoclNBimJ2Y+IgeVwbZFCm4zIydD8ERo36SZbu5Z57IUckzqdQ8h1oIVAbVhI24JjsDhK6iUWoOgs4bkbSDP4wGBi2h6Tl1G+EzlQSBcHAQMe1wfQ9uaDSmjxMETJdn7c+xFz8v6/GNm5ksu4s09PoeJ4B1gKdnPSirOhq7t89Xo/uafPalg4YKjANCqHGQJRfMt2PH81Pe9nEEj0/0xxOJzLpgjHERuoJFkFJonjADuB/PYxbNMhyIqZfFNJTQGSreP4rqDlmeP/dMziVbPpsxrlHtddLvIAWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDDm50PaFOgcSPcPJt7awimuQj3XVFDdqsl2w3GMZzU=;
 b=VSXDCIRZA/LPPprOoHuPAzupmCcczchztKQ3WMY0yjAUw3xmLW/xnhb08HLatfacwgY4f25zAbKrsLHM7TVFPDnJa1XWeozxudTtG/NT77OXNFQWj8+6EDE4UKa1wlLf/mUCnQwHtd4X5lFfBFLCqQqGWZbh7Yw+PTtPcL60IZShF4/hy90LMEVZ6cKkriIKQzXNYHTVU9BBs6u8Pwucv+E8xKTW/v7+zLygwu5+YQpv8a8c2XdEBNubF5XqhdMx1AZzBaqjwWf05T3D6/ParuMpdGo2sABHZsPDotnmmsldQ/oi6Ldx/Mn+KF6TF1oUYajuwEO1u7PZOqsws6Z4iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDDm50PaFOgcSPcPJt7awimuQj3XVFDdqsl2w3GMZzU=;
 b=QJ6v7eyXHdDBNQ0pP6M9te8c68p+1xV18l4LVSs1fAn9S128P66EYE8MgIN1bGsKNFE1iMPh0LkYafsctzexTImzbGk//eKdyV3s96ElwPuF2sQD6yOCUM30HoLZdJghdQdJ641WWZS8hgQ3KMfDYV7k14fJPD/Oik7hkpAPDBM=
Received: from DB9P192MB1388.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:296::18)
 by PAXP192MB1150.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:1a8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 15:44:44 +0000
Received: from DB9P192MB1388.EURP192.PROD.OUTLOOK.COM
 ([fe80::634:bcfc:47a9:2139]) by DB9P192MB1388.EURP192.PROD.OUTLOOK.COM
 ([fe80::634:bcfc:47a9:2139%6]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 15:44:44 +0000
From: Matthias May <Matthias.May@westermo.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Matthias May <Matthias.May@westermo.com>,
        Zefir Kurtisi
	<Zefir.Kurtisi@westermo.com>
Subject: [PATCH] iw: strip NLA_FLAGS from printed bands
Thread-Topic: [PATCH] iw: strip NLA_FLAGS from printed bands
Thread-Index: AQHaNCSeNy5I5EZMJEq5rWAPYvB2fw==
Date: Thu, 21 Dec 2023 15:44:44 +0000
Message-ID: <20231221154432.36353-1-matthias.may@westermo.com>
Accept-Language: de-CH, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.39.2
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9P192MB1388:EE_|PAXP192MB1150:EE_
x-ms-office365-filtering-correlation-id: 94bb69ad-f3ef-4bd0-f958-08dc023bc10a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z/VIyLJrDfWh+Zu6sH9ZFUk/3b8WMEoDXkN0x/eIdrjT6NoNMrxhOfkId8cMaO8bt0DNwZJlqYyLwBqruJpyHAuywLp/gKCDhujZC1Zcaz4G6lJF0bzGWgep+pE0iRIMFoV8C2Z/vYJ0VN24OUvl+lGdjoCta0CW8ZkYr6hGH11ONDKc5rsKDBnqxqGYr3/LbGBZTzNZ9+AMZxUGbUhA42Z6Yja1TcI8xbL2pU812yHszCO1lGjLfBxu86JvKAeSCQMRafITvX8oX+5UgJRjG81Z5sMFAB4S49PNU/8JG9GV4vOI9abO+dAHcknyPx/gy7Sews6FlJ3E4jUvrL984gTqS1LFy0oFloDj7XHmI/9zDNtcxaxMiZR5w/GlopJc1Kf1GW4GFG9Se6JGxyTtq4/H9tfCojQ20aJUgFZe8VFQ/lbIHupAlddO4bOKyB50wbszHtjQncBwv3b2lQZhjTb+PR7CRTJF7yi6wLi+hD4IeBd6LtLrRNHaRR0Te0cMnWME4PJCeTrSV5kgfky0NmpZbXGcElwstgj7c/uAQeiNfcJxj+zmnhoTQHX07g1oXqx+4b8S54LaIP8taai1Gj0j9YW1QNIckH25Yg/TK28Kgm44xcyPtZaU6mGkR6Xl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P192MB1388.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(376002)(136003)(346002)(396003)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(2616005)(6512007)(1076003)(86362001)(6506007)(26005)(478600001)(107886003)(64756008)(6916009)(71200400001)(66476007)(66946007)(76116006)(66556008)(66446008)(54906003)(91956017)(6486002)(122000001)(83380400001)(316002)(38100700002)(8936002)(8676002)(36756003)(2906002)(5660300002)(4326008)(38070700009)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5SculKSTg5fAeEwnokO9t4bPoo/b6ddhnBFuFLnrOyc+uM7AJeoVmF03Rn?=
 =?iso-8859-1?Q?syS5DXwkeHTM022NFCZ08qN8iurXgfpRkUHZ94fTlqGglV1yWrfYV0NnQE?=
 =?iso-8859-1?Q?rJ3RVxsNg66YQBSX1YiOC9DGP1CTcRj/5Vv348a++434Kl3q+dTBrRlU+T?=
 =?iso-8859-1?Q?GJG+T1VFKOgPaIYtKfaz7HoglKfW5ZvcBYRCwtRjdRpuTwOWYZyGt+Ph2l?=
 =?iso-8859-1?Q?sdSObsjihLILKBQceWg6FdNKqW7hkaOAhPfbtCbtPmSXX7i+hQB0Go4inG?=
 =?iso-8859-1?Q?cjkIDLBRiV966eW5Po8MNP9wa8r4JRp4GT8CTdW9YFS2cftPV/14XIIK4R?=
 =?iso-8859-1?Q?gK1dMGbFwf6XmPtL6dXvjb918N0DxA9vZepsmawqPlTFYsl1pEkOYTRnFN?=
 =?iso-8859-1?Q?gvRSNv25DyuArYKJFes0h/Rs5M3Yd5ZIAxrJP0eHhV01S6RUdPjK1oDpsF?=
 =?iso-8859-1?Q?3W5vaPu4MREVKq+aNe8goDekEZgOAFACLAX31hVu9/58iwDA5fStaKkna0?=
 =?iso-8859-1?Q?9L/bMPhZKck9Bb9cRvpULQvQU4beeLWaVK4jFZpKzVehAB500mvfPAitVL?=
 =?iso-8859-1?Q?aQi/Bc/SbP5emGWN5Vm6yuNEt1IvFQ3YVGPYoCdvtazPXSxb8qVVckCan7?=
 =?iso-8859-1?Q?2vASsLJAMS42I6u+SA08UJNHXQvgym7V9e7xalBZbupF7SqOSn+l+HeZ8X?=
 =?iso-8859-1?Q?Ofghqj80yqssGligglihgkJGZLrQn1dxCYIvaPuTqaekaFF9cc6Hd+eDO6?=
 =?iso-8859-1?Q?X1ME3znh9MnkMS8r6xhuja+J3Yt1iIXCymAPtkVNt2fRDvnyaUMuAtfCAq?=
 =?iso-8859-1?Q?F4lpZdifaSNyys90cXJu71HNpAcGebl1Sd0NfTPpliM6oqnD/hhF0rRNUf?=
 =?iso-8859-1?Q?87VX/ofoI0kSAKizD7vUEJ+wlmU9ipI2DSu38E6P744oqPv1xWcaCsqGSJ?=
 =?iso-8859-1?Q?LG712L075Sd+PJfvOp5dtbgkfQJw9snpiENZGmDr0DEAT49x1FfdPOB37W?=
 =?iso-8859-1?Q?ErVFNxqLJQBI8glFGS4rHqmC0JerYe2yEs/4tlAoYQpdyt/cOuqlkCC9xs?=
 =?iso-8859-1?Q?/vdk2nHV2QaHbR/EjkJdDebVvx/nUZ2uTWbCU2tJWuMn1LDbcaUfhfuDks?=
 =?iso-8859-1?Q?KH3tc7UgZh3+Hjm3rgbYB9XLFjepa79XJ3CzAsLKFLy64ReypOWr2qaLfA?=
 =?iso-8859-1?Q?/6KCAo0SGyZJVEmKgdJ8kRJ9HR6xZVqW2OrfXHR5cpOITAG0p5wAZDUPuu?=
 =?iso-8859-1?Q?cb+0jRKMtnti8IKtgFnFr6BPA8Ppwlb4WX6Sh3P/hkbXDZ9CU1x5zlwJsd?=
 =?iso-8859-1?Q?j/qfJ5A63jSWX/kDxQ/KM0Agzybt2DsosJX/wZuN74EDba+KyJdRQr2vHB?=
 =?iso-8859-1?Q?VUVRRHyQQv7zIJFEjRHUQS3GDzw+TsyiPNhNp3bgflbw0O4mc9CdbAVMaF?=
 =?iso-8859-1?Q?oNeBFiYzToxduurIYPlCAmppfUd1qJLx65AcuaNFiTxNUC72sNzkLsW/55?=
 =?iso-8859-1?Q?xOP/I+LBgYdD9b/6Oox/jIPagW14c/8W+V0aIrXeXI1Lwa7iYaf9FrjMWY?=
 =?iso-8859-1?Q?jimrYTWryKjoY47u7iBUeqAD9wcKeGpCkhxIkLpy3/+91w+D3pjfU/qOpm?=
 =?iso-8859-1?Q?A1KqK2Tk+zM/+6RL5uTztaSdq/Vw4O+caK?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9P192MB1388.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 94bb69ad-f3ef-4bd0-f958-08dc023bc10a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2023 15:44:44.4268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: manaFr/NTS6xFMPJ5Hl9atwmSGEvoWtLaOlZBPFIrJcG5lqli1zGaBv02Ar/Vk95RK42MKsIuY7MtcXZ8geMEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP192MB1150
X-OrganizationHeadersPreserved: PAXP192MB1150.EURP192.PROD.OUTLOOK.COM
X-CrossPremisesHeadersPromoted: EX01GLOBAL.beijerelectronics.com
X-CrossPremisesHeadersFiltered: EX01GLOBAL.beijerelectronics.com
X-OriginatorOrg: westermo.com
X-Proofpoint-GUID: pYVKdZ6rSm1WbFUushwOtlVaAxgVySPH
X-Proofpoint-ORIG-GUID: pYVKdZ6rSm1WbFUushwOtlVaAxgVySPH

nl_band->nla_type might have NLA_F_NESTED (0x8000) set,
causing 'Bands' to be displayed with an according offset
when used directly.

Use the nla_type() macro instead to strip flags for
printing.

Signed-off-by: Zefir Kurtisi <zefir.kurtisi@westermo.com>
Signed-off-by: Matthias May <matthias.may@westermo.com>
---
 info.c | 2 +-
 phy.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/info.c b/info.c
index 317e7a3..5334436 100644
--- a/info.c
+++ b/info.c
@@ -354,7 +354,7 @@ static int print_phy_handler(struct nl_msg *msg, void *=
arg)
 	if (tb_msg[NL80211_ATTR_WIPHY_BANDS]) {
 		nla_for_each_nested(nl_band, tb_msg[NL80211_ATTR_WIPHY_BANDS], rem_band)=
 {
 			if (last_band !=3D nl_band->nla_type) {
-				printf("\tBand %d:\n", nl_band->nla_type + 1);
+				printf("\tBand %d:\n", nla_type(nl_band) + 1);
 				band_had_freq =3D false;
 			}
 			last_band =3D nl_band->nla_type;
diff --git a/phy.c b/phy.c
index 4722125..ebd7289 100644
--- a/phy.c
+++ b/phy.c
@@ -52,7 +52,7 @@ static int print_channels_handler(struct nl_msg *msg, voi=
d *arg)
 	if (tb_msg[NL80211_ATTR_WIPHY_BANDS]) {
 		nla_for_each_nested(nl_band, tb_msg[NL80211_ATTR_WIPHY_BANDS], rem_band)=
 {
 			if (ctx->last_band !=3D nl_band->nla_type) {
-				printf("Band %d:\n", nl_band->nla_type + 1);
+				printf("Band %d:\n", nla_type(nl_band) + 1);
 				ctx->width_40 =3D false;
 				ctx->width_80 =3D false;
 				ctx->width_160 =3D false;
--=20
2.39.2

