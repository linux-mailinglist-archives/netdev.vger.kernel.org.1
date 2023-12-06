Return-Path: <netdev+bounces-54433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F3A8070F7
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 14:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5173281C31
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 13:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E3A39FE2;
	Wed,  6 Dec 2023 13:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YbkKdEhm";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="q46Pv1Q3"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81283C7
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 05:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1701869725; x=1733405725;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=OMxtfZHdi0R2a1fpv/bcxPZChPBaoFe/QSW2VPzA+iY=;
  b=YbkKdEhm0cIwgUQiJ3C8FM9zKw6z9TJkX8CmazQcgtHZ84LGoQD7D+Sn
   EZIPRbpqJYOHSN/Zi8ZUyiUjx2vkRX1UbZ/BeIiCFu1q/4Q4QJKRMmw1E
   qOMZ8GjIbQhSx2oGbF/vmjlxz0SXjeJRufWw+Q1L7QSCTnAO5YeYujgrq
   a0kWNIfOuBHev2viQQqmk+2G8r6FXtr/uplEdWXtHFH6SAe5crysuaVUI
   32WMDKIm4k6OvzgZ1DBqrcOYasWbichzZYWQ8U9GeUBpIykCHp8LlBPLV
   zwinLoiRy3KfbYkPWDH5Z0GAkoYu863kRYlm6gmMc1LF9/8RrCWrpxLz8
   Q==;
X-CSE-ConnectionGUID: ZCwm98pmR+qpSXzbAiwBWQ==
X-CSE-MsgGUID: eT/3xW4oSdizypbF5rvDFg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="13708307"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Dec 2023 06:35:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 06:35:24 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Dec 2023 06:35:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xm+TxpKtSllGQpe09e3gETvCmAREQYQdz5K9TUoWFnn7Z7PjqSW6GX2YWJA9ItKbkP6H7R43QGnwfB0KEC//F5Q6t3tIG2v6t1Pans4V27SSAXIVcW5kvssKBHUmR28Tlfkhm3am0xKQVVfOrpV2h1Mh588KELYHe5MONugF+DE0qOMTW3cNv+6JqPhWnC15yqNFa+R1eoNDxwWnLAYTl613A3axKCXt2qDE8wGsxgCJivgmYSbVV5sVQEsFZ6wGMZcBNfj4CQs0E9+8ScZcjXZnU98OaLL678+OeicNlcOYfsf9sPgrXYpxyQOShyV5HURtEV4nQNpSaoPgDyCufg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nAyGuVI+wOmxoKboYRyn1pKCzhnCCd98DnqKS6XwaaU=;
 b=a+GtnWpCW/RyjqbfX9MxDU6ogWM2d59Cn0YXCbPwH5ipGVcTe6MN9FKnnsnXvKUtD79orbE0h4NusvCje0Tqr/cUvQuWHCM21jb6YXjt5c0VhScd9Mkaa6IjG9mVQ0+p6D2MOkYelJHUdwn6JJian9sUNt3b5h10AWQJYUtHIcTYmqNSsJMHbMxi6aUH8xDBg/w90W3NTya+taXoQRt8ZVDqcR9kL45jkDhRuDKYGobjL88qlmM1bKFGtpRx06GYtsY8uNS3mrO30efG/Jk6q5/jMN37QFrCi9l+cPly2MgApmsq6azLwKiBVk/IqpxxYtJyKdTqFHXb3gqosfRe7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAyGuVI+wOmxoKboYRyn1pKCzhnCCd98DnqKS6XwaaU=;
 b=q46Pv1Q3m5XCZmAlLBmMDQ3NNB0iGy7BDee6HW3hxoxiCB9Zr0Tlqj0KbqiPrY5iZSsTldwfQk5fOu70mH0P7C1xQr72z0lTVjeAnEre1hiZ0r0E8LkmE6/NFH7GelmSt4d+xOw/OZcmEu62rgmlcyofCRlUml8nZnHzIyKXvytyTXX49ycjaA1XHPJfL0gyoz7qNt1c183wQcXsewf2G1KXLReCVu5bIrHPb/bg+4DXp3J4wxmaYW+Pf3ps59o7zga8sIIh0FV5E229vCLgxN2axczEq8+V6NF/VNpEdoSqStbwSKu2ytnrCI+gFbailr0qrlJiSWfwG2laKrKBNA==
Received: from DM6PR11MB4124.namprd11.prod.outlook.com (2603:10b6:5:4::13) by
 PH0PR11MB5205.namprd11.prod.outlook.com (2603:10b6:510:3d::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.25; Wed, 6 Dec 2023 13:35:21 +0000
Received: from DM6PR11MB4124.namprd11.prod.outlook.com
 ([fe80::af51:1aed:6d1c:6d64]) by DM6PR11MB4124.namprd11.prod.outlook.com
 ([fe80::af51:1aed:6d1c:6d64%6]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 13:35:20 +0000
From: <Madhuri.Sripada@microchip.com>
To: <sean@geanix.com>, <Woojung.Huh@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>, <ceggers@arri.de>,
	<netdev@vger.kernel.org>
Subject: RE: [PATCH] net: dsa: microchip: fix NULL pointer dereference in
 ksz_connect_tag_protocol()
Thread-Topic: [PATCH] net: dsa: microchip: fix NULL pointer dereference in
 ksz_connect_tag_protocol()
Thread-Index: AQHaJ3kuqyabH1u0rEC7VGIRUPKlq7CcQipA
Date: Wed, 6 Dec 2023 13:35:20 +0000
Message-ID: <DM6PR11MB412432B1ACD79A975202D0F2E184A@DM6PR11MB4124.namprd11.prod.outlook.com>
References: <20231205124636.1345761-1-sean@geanix.com>
In-Reply-To: <20231205124636.1345761-1-sean@geanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4124:EE_|PH0PR11MB5205:EE_
x-ms-office365-filtering-correlation-id: 78398fda-37b5-4491-ba0e-08dbf6603129
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YVOkJJg/VrRFTQu3+EX0p+vzHSzMjLnGwhen/ZhIs2xmBW9I1/2Zj9Iv6GwlapSzeO0001pLSTshZdS6TvI8P5gMsVFrdWzf3lJqHHfBTzSnL3rqGa16PyOCmkucCEx1yFNvd1KhtZGe2bz/lfAqaRhWhZQYgDFzNNo2K+Fu8WmH+DML3LHoAQhS46D4forQ+VQaODFOoY2W04tZojeHYb1AvSawyn06/0pAc7ukEegZNwO0+8n0AB9ZanYtF9GsxDVdyhoMh/CzU+eCUOa+SX14m9AVY8qQhkiORF/3KNxLXVeT5v+G+l9ZjFHKAAtZOofPFMHC976mtrgVPdWVEmG5fT0FX14tjoBUg8Ta/QNc+ZZWL6q4umh2dNM19uYDThpT4SMVana7vPIDHAXe9ABVLjBugsOFV8oIXGXI9C26v+5PHE93D5HvngZrcAeCZRg3XFkaaB78J40agZvqN3ZuQSHCeAbEcJIKsqrM1uEtdgvmm6+H1rdb1NRLJSVP0yc6zftgyWWukj5RpKM8QTI0mSakvUE3DXdENE9upcNfnobz4pMXAwFNERyfj50p9DA1FjCoFMZ12cXCtH4IQkkgPdbdJ5GqbN/BfVRPa6Bwkh52hXOFM22rT4BBiOIlYiAwsegWVYd/gk7FVv07Tm8aulPNcVy4W2j1eyLvywA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4124.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(346002)(136003)(230173577357003)(230273577357003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(33656002)(2906002)(5660300002)(52536014)(41300700001)(122000001)(86362001)(8936002)(8676002)(316002)(110136005)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(55016003)(38070700009)(38100700002)(966005)(478600001)(7696005)(83380400001)(45080400002)(71200400001)(6506007)(53546011)(26005)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+Ebj30SkWDjJcxTxkAPLrwNK5NkmMQHZMECe8QGkBVdbx5bLlfolvxXhMUuY?=
 =?us-ascii?Q?LURkQ4XUWDLdTTc716ykYfLGkfAUaDlLyaSGJ+fn7I25T/k2hteKTRWRVVQn?=
 =?us-ascii?Q?5+ZOPtwHwbeAyn+alL3Bo+46QxXn2eeLKMPj0LalCAHnckCtD4mTKMpslEur?=
 =?us-ascii?Q?akBEwdHSlgDsi7syqokVDSBlyDHEwOWNdlzgXyyswowWq1CRN44BfS2Uu3BS?=
 =?us-ascii?Q?bQUA3v2CaBw2sdohUKf5Iwsz0I4RwssdjlYUf6qEQXRczb6EFudR6nJ/qjvW?=
 =?us-ascii?Q?WsLHzs3zKXg/Ar0wYtbkms73rxuMuZ0XP91RLW2zhWL9D8tEog9Rfqlfyqg9?=
 =?us-ascii?Q?44p0tzwaXg6QJUWK2UKXH4FuqHvGyT0t+pSYMQ99g2rDLFuYik6VaTC/Acsu?=
 =?us-ascii?Q?pb/xBGa22HA0iM9L/C4wlQsQb5DIXc2S/MV3sveuWYlqUM3VN9LppQYd+P/y?=
 =?us-ascii?Q?BPLETN38Ye28SShk+OAFIEceYKl4gzXCM51YCmEwmKw+w73ikN+nCNKZWajP?=
 =?us-ascii?Q?xMi6WqyPhU3Ta5iIkMrsps4m+bYfDO93Dbh0TmwtSVE78qInifgDhsAf3SdN?=
 =?us-ascii?Q?leIslpaNEmuIG3DZbjmI1Vq7DFIIScI+2t92tVntTTibCmvn5sx2U/9JSc/D?=
 =?us-ascii?Q?5qXv16pDoUaT+vNj8RJNFRFo6AQGXcLpA9A0vSSr6c9umfFamW1pNkue5W/B?=
 =?us-ascii?Q?n2sqdIreUQG6AOm2dJo2fGVBbQ0e5Ze5Hn2nuae2qmJJeEh28Tu1LqkYev4b?=
 =?us-ascii?Q?Bf4WWIACW5VmEsSf3r9IeqNRZf2BYQsnYGduEJQm7SS4T1xV/cwjwqE4i59q?=
 =?us-ascii?Q?+CaBBAtsBipJC2nITvGxxnP0ORPdXMSvKcTc/f8ZtTuBMdAHQs/kvRedX6YN?=
 =?us-ascii?Q?HAWKAPpxAnuKhHXFMvzDula+UzfIClhcRqKbu2rs1CZPOKnniffCCMCKMPPy?=
 =?us-ascii?Q?cushR1RAjmMxzeRlyHtIDpkOjXnU0rfdHEFNZYowydC7aSLBqZnLlCT00rK2?=
 =?us-ascii?Q?EGp58UauhrYmsFeWm9zViyQYeM14TRiyu9zzcNBUHOb7utnnGA9Ly4O70fix?=
 =?us-ascii?Q?lgMmYdya5QAZc8hUcZBssYfnvdK/0C5SYGBkwRgZKsRISXMavLZR2pRRLhdN?=
 =?us-ascii?Q?e0BiaxHwRVnaLb3+GtexBqVVxfH2sfjzgvaybnuhiuSRGYUi5PdkS4Iyc5/3?=
 =?us-ascii?Q?6sGv87k5yNkb4mn5sNAJ/8szH2OWNavKNLwevntHi/5b5L1y/BQSa5jlqGN0?=
 =?us-ascii?Q?gRAGQrEKfKGHN9KD/irQhWtJ1JMTd+TvTVVcyA8eg4ua2GnL3JaEv0AOuQWE?=
 =?us-ascii?Q?GfHP6qeH5eVyVaZFPNZFBcd8gpqvNWE5w3bJ6HKtF8pZS0kkBuHbDx6uYquS?=
 =?us-ascii?Q?6cY2Dn67bQTMANjsl0Bcby9iRkntdo1oBK157zUj1AQfslxdHvFdQTWat82K?=
 =?us-ascii?Q?ARygGRmq7LyV5JYK9MGEkjeDTLYn+Jpl/JXvb93dTcV5xW/wDA6HkSC+Wwu1?=
 =?us-ascii?Q?tYfW/YeM8C3PjuuDU1GO4yZEH7Wg6XNGzh4KqTEyWbDCsDPFc6EkfpnR8u5G?=
 =?us-ascii?Q?XVvOwSH8jav+aLCG2xXXyWp7x7coADIiGbNanavJd5UDB8+l3d2QKHNdcJ/7?=
 =?us-ascii?Q?Ww=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4124.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78398fda-37b5-4491-ba0e-08dbf6603129
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2023 13:35:20.4869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IkIzw79XEzSVS/2YRj2KOpYsjaQB98RrWMK7q6fXIE1Faf6f2rIM+sGVQT+1P/QkPye5y5YlGPz702Eytuybigh9VjprSDZ1mucEZzKDurQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5205

Hi Sean

-----Original Message-----
From: Sean Nyekjaer <sean@geanix.com>=20
Sent: Tuesday, December 5, 2023 6:17 PM
To: Woojung Huh - C21699 <Woojung.Huh@microchip.com>; UNGLinuxDriver <UNGLi=
nuxDriver@microchip.com>; andrew@lunn.ch; ceggers@arri.de; netdev@vger.kern=
el.org
Cc: Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH] net: dsa: microchip: fix NULL pointer dereference in ksz_c=
onnect_tag_protocol()

[Some people who received this message don't often get email from sean@gean=
ix.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdent=
ification ]

EXTERNAL EMAIL: Do not click links or open attachments unless you know the =
content is safe

We should check whether the ksz_tagger_data is allocated.
For example when using DSA_TAG_PROTO_KSZ8795 protocol, ksz_connect() is not=
 allocating ksz_tagger_data.

This avoids the following null pointer dereference:
Unable to handle kernel NULL pointer dereference at virtual address 0000000=
0 when write [00000000] *pgd=3D00000000 Internal error: Oops: 817 [#1] PREE=
MPT SMP ARM Modules linked in:
CPU: 1 PID: 26 Comm: kworker/u5:1 Not tainted 6.6.0 Hardware name: STM32 (D=
evice Tree Support)
Workqueue: events_unbound deferred_probe_work_func PC is at ksz_connect_tag=
_protocol+0x40/0x48
LR is at ksz_connect_tag_protocol+0x3c/0x48
[ ... ]
 ksz_connect_tag_protocol from dsa_register_switch+0x9ac/0xee0  dsa_registe=
r_switch from ksz_switch_register+0x65c/0x828  ksz_switch_register from ksz=
_spi_probe+0x11c/0x168  ksz_spi_probe from spi_probe+0x84/0xa8  spi_probe f=
rom really_probe+0xc8/0x2d8

Fixes: ab32f56a4100 ("net: dsa: microchip: ptp: add packet transmission tim=
estamping")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/micro=
chip/ksz_common.c
index 42db7679c360..1b9815418294 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2623,9 +2623,10 @@ static int ksz_connect_tag_protocol(struct dsa_switc=
h *ds,
                                    enum dsa_tag_protocol proto)  {
        struct ksz_tagger_data *tagger_data;
-
-       tagger_data =3D ksz_tagger_data(ds);
-       tagger_data->xmit_work_fn =3D ksz_port_deferred_xmit;
+       if (ksz_tagger_data(ds)) {
+               tagger_data =3D ksz_tagger_data(ds);
+               tagger_data->xmit_work_fn =3D ksz_port_deferred_xmit;
+       }

        return 0;
 }
--
2.42.0


Instead of calling " ksz_tagger_data(ds)" twice, NULL check tagger_data bef=
ore assigning " xmit_work_fn" would help right?
Is there any reason for doing this way?

