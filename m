Return-Path: <netdev+bounces-15710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B23C274946C
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 05:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF9A280F03
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 03:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F4FEA4;
	Thu,  6 Jul 2023 03:40:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D54BA5A
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 03:40:51 +0000 (UTC)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2133.outbound.protection.outlook.com [40.107.117.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B490D1737;
	Wed,  5 Jul 2023 20:40:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O71DCaiFidEiN4yotJdYgC3ikprGZB/KRQ9RYQrmhD+c+Y8RAGCCSbY3KpDzivPkPF+MNIeI7MaVoajePPutmmLcYLNrwRT7UEPwzpFIXquA1FGH11emilwkOTwlTZ1hkOoJ43a61gi3Q2uF4QgvgLZ+ExA0Bawgl52L5A7WTnHg05m+045bq28/jXEba/IJByePfXtoDTq/FdbcNUdOuHZ8nVIPI6hHP336CiSou0UtRc3XjTPb+lj+xAVd9aOEUeaQT6nn2Dte3+tnlKhIqfAgA56cL0ChwZgqaPOO6iqcYbbWgEU26y3fzpx7HOhj8hZEe4pNUN0lGS7CtX4r5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NX/2y0V9gQ3RCSYZ/LOjdw+UFKFgfIp8MN8/lfpItaE=;
 b=aNVTFeCJtmAqcfIPF35CPT1a36lowBRqF8FWRRIyb2anZMMrEKWmwbOAcJGlCjyR+6UymT3XfAl3hRc0ZTZDDCrnVaZKADkUHYDlujGSinp5nnEBk43FneKLJr3UcJqBGTS97S8K+GqgGXecC6kvwBJO7uUh83W8iAdsOoR1A5FVQSJqWyRMFK3oP55LUjwlLsRUzeBi3GrvNzd9TMNE1se6hvJc/pRZjKyvwYrogc2/RsJRMaXW3kVqYOouBDeVotfvq94cX44byjf80wnv6FhIYvLSxx9iIHyJ+fpplL6IGIJujMus6cD0mfHCzNFStXGWW0Z57yV9UuFJWzw46Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NX/2y0V9gQ3RCSYZ/LOjdw+UFKFgfIp8MN8/lfpItaE=;
 b=ZFtbayRIOGicPCwbma2hQHGoJvoIc49PoiXI10U1w8eUJsb6IKKZYkM2iCvpo3bt4shAUP+RPLRRqoaiAW5jZftAgHxbaxaQ2SSP3FFixHk+gHl3RE4wHKF7KadnwJKKwD/aScbPyykHUvcjqBWWTJtaQn8KtJq4WbzDCB6udBPRfAOrgOKirp7zUpyd+QTe+D1Xc8UQiymYsnxJUg/geZdN2A9iyYltXK4xLFWjJXdmwL1YO7zlDnfPjKsfD9NDi5bjppewGbrMHiMuFsj1ZxA59zaJs2Uy1hL8wXsdPjONq8irhNiqHDecP7F0FOFffeAvp68RARpNXMihXq+llg==
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 SEYPR06MB6105.apcprd06.prod.outlook.com (2603:1096:101:de::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.17; Thu, 6 Jul 2023 03:40:43 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 03:40:43 +0000
From: =?gb2312?B?zfXD9y3I7bz+tdey47y8yvWyvw==?= <machel@vivo.com>
To: Benjamin Poirier <benjamin.poirier@gmail.com>
CC: Sunil Goutham <sgoutham@marvell.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>
Subject:
 =?gb2312?B?u9i4tDogW1BBVENIIG5ldCB2Ml0gbmV0OnRodW5kZXJ4OkZpeCByZXNvdXJj?=
 =?gb2312?B?ZSBsZWFrcyBpbiBkZXZpY2VfZm9yX2VhY2hfY2hpbGRfbm9kZSgpIGxvb3Bz?=
Thread-Topic: [PATCH net v2] net:thunderx:Fix resource leaks in
 device_for_each_child_node() loops
Thread-Index: AQHZr03sKVk7ictFTkqaLcdv6ppXfa+rj2CAgACIwcA=
Date: Thu, 6 Jul 2023 03:40:43 +0000
Message-ID:
 <SG2PR06MB37430F343101FB1B9FEEC884BD2CA@SG2PR06MB3743.apcprd06.prod.outlook.com>
References: <20230705143507.4120-1-machel@vivo.com> <ZKXEj6p/xkA+1yM4@d3>
In-Reply-To: <ZKXEj6p/xkA+1yM4@d3>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3743:EE_|SEYPR06MB6105:EE_
x-ms-office365-filtering-correlation-id: e6a4ab6f-7469-4ec1-4743-08db7dd2c6be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Sueabr9zOeYBOeFP7ut9YNWP1V8E7J5WambL8Wbcl8e36uAKDlEKmDeibJcvGctAaffLs6fZsXrhXQhVwLdmWq/iF05g3SqcmsmUKJP0t/DExtBA7/1RDffdjtbSuLt08gxyDcduNO1aFTWFZ8X7c7z/MYCVaHHHxENoXsV9XZLA4aU1nKvUMvDe5NdZy5S+QqWsS0dOGfkPf3+X4USAkHM7bl6fEU8rl5i4Kzm78+JLr+GruXBGw8NB4veH5N6flLmegprkfSz15OY6EjkecL5GFPA4hHpv0HOop/Pno5shY01oXGKufPeHYnL3ogcCBMaCVVd/6A+TVqTnodPIqlpzf84gCEe0MRy5kYtgFvtyL3mr9xzoysGZ5PRrwGGcl/fh5r02Bs+11g+ZjJLvteyFpI/swBwFwy4VuZn4lqLwPxIHKJbSfENMPn/fSwNeidjt29bOOwtrbafnVLzIwzSmMO/kocrXcw4XVtZmpqBkPhTkNNmd4PvPq9WMfLQfoH9wMGcyj9kkghenmtizXt5dVDJluOJyDkTP7ZMGyU+rIIrq558Z6Bix32Y0pfDCSin5AtEKK4TInYO43EbMyZMet+Wlpu8Tq/4fF3DOq8KVODsIp94c/5oeKyVzy/O4
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199021)(66476007)(2906002)(8936002)(26005)(76116006)(5660300002)(52536014)(186003)(53546011)(6506007)(55016003)(66946007)(41300700001)(107886003)(71200400001)(122000001)(66446008)(224303003)(4326008)(83380400001)(316002)(6916009)(33656002)(85182001)(38100700002)(54906003)(66556008)(38070700005)(478600001)(966005)(9686003)(7696005)(64756008)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?QlJuSDd1dGxucFIrWWxRL2p4NGZ3RG1UNTZBZkNCUlhVaTEvZlpiY3Qwd0tv?=
 =?gb2312?B?QlJveXBQTnhNa0RMcmludC9VMHBOT3RCZmI4RW9yTDdxVHBMRTgzZzBpbi9G?=
 =?gb2312?B?d0pUTExlTlA1bGxESXJKKzVNeUo4Zmx0YWZuYTNCcXA2bWQzL2RER1RkT0du?=
 =?gb2312?B?RHlMVGdqc1NyQ2N1SzZ1MEVCVkRlZWE5UWtPZ1lTUVlMdGVjejJyRFlxakJx?=
 =?gb2312?B?dDE3YTZQL0tEdmxiWDFhVDZZdjVFM0tvOU5SdzNsaFUzYjJ3WW9MK1RBa01S?=
 =?gb2312?B?b09IMEZoallHcUFrWGk4V1l1OEJockdOTFNydTQ4SUd5QzVhM3B6c0w3NThR?=
 =?gb2312?B?TXBlK0JlMzlJOTg1cHJ4TWZTaE9OYUsvTFV4VXVJTVpZWFArRVVrZno4NzNF?=
 =?gb2312?B?NWZBOE5EczF5QXlxM1VYZUZSTnJRUGRrbWNVTkRRQzYvOW15bVp5TGE2Y1du?=
 =?gb2312?B?TGpwdVVVdC9EMXJUTk1mNWJhYndBSURCVkk5QlFXWVJRdmVxWjkwblpFdTlN?=
 =?gb2312?B?SG96cHpaYWRQdHBPbk9CMkdpTjRuaTFwWTNRbTk3M2lSQ0dTa1hzQXVTcmJK?=
 =?gb2312?B?OWlieG5nbU54aktwZjN2MDQ0dHNsQk1udG1yRnRZMDhkWVVFRktHQkZCNWEr?=
 =?gb2312?B?c0U2czFtRi9NR1lDc2hOdkRleXFVd0UvQTZROUt6VmVzclIyR0hkTkpFcUxq?=
 =?gb2312?B?RjE4eUZqQTRORmpBMWVNb0U2alBrVjArdDJqNThXdUUrQmdUK3pvMDJrdk9a?=
 =?gb2312?B?Nk9mekcvY3hyQlpOcy8wL0FYbUpldlE3UjM0d3RsempUQWxXY0YyQUk1SUg2?=
 =?gb2312?B?OG5uS1RwRnhURG5wT0ozKzVBRDRJK3c1Vi9EQ0pLb0ZXaGQyejJmd3VtU0Fv?=
 =?gb2312?B?T2RoU1N3WUc2UTBOZG9SSWpOL2ZJeHFkQ0JEaTd5TkQxMUF6Ymw5UzBpVFVt?=
 =?gb2312?B?MUFBSjdvYW1ZQVd2MmN0SFYyV25jR2pxMFZhQkQrUXZEclhveWhaeHB6OG1Z?=
 =?gb2312?B?QVZSRkFoK3J1eEFxUE9WY3AxbEl1R0FRRjhjNEhtZWs4eTVGN05WMVBodnho?=
 =?gb2312?B?eHUzcDZMR0k1SFBaOHM0d2RITjNuRE9XUUc2eEgwTlZkcDh3TlAxaEFLbDVw?=
 =?gb2312?B?S0VhN1RWQzdIa0kzUUJhcVFsR1pkQ0V1Z2pTeFFxVEtQVnRwUVY2bE1ndHNI?=
 =?gb2312?B?N2kzbDVIQWc4N2xxQ3F2VzRuWGpEVGNZMUQ3MnhBUUlTbWxiK3lLRjFvR1Jt?=
 =?gb2312?B?QzJBbFVjc3hGZDFVMDlSaVZwLzNxRkZKYlYrV0tjQTlqMVh2RzRtRnNIcVhO?=
 =?gb2312?B?aDNKN3Y4aGNmUi9lVnpIRmNxRVREeGRnYm5ENHdsMWcwMENSZ2ZqNGhjbnNm?=
 =?gb2312?B?QmlHRU1yRnE1Ry9pN1d2WDV4TWNDVVI1dGowYUh2MXVKSFhSUmVJamczUkFL?=
 =?gb2312?B?Qzh6ck5MSDlrYU9DL3VvVjZBYmd5TXFmRWluZHFDV1lEUHluMTUyenRiR01E?=
 =?gb2312?B?VUVDZm9jMEt1WkRpQVhiU0RYVU9abXZEUE1IbSt4TzhhMWdTWDNpWnBsNm9W?=
 =?gb2312?B?QlZlTHo5aDczRHlIQjVteXR5VWR2bHgzcGxJSitkb0NNbEZEWG1YSXhDT0Jp?=
 =?gb2312?B?T3dXeHNUd29oNHErM3FtNzhDaEJDK0pzc04vemNpYmtvdGJVc08yR2dRdXdr?=
 =?gb2312?B?SURPYTY3QW1nUkU0eTdwOE9DU29ab3hMR0xBRE9GeTJDZTRGRVFoN1pmdXQ4?=
 =?gb2312?B?Wkxiek5PQzJnZURXQis1ZDNNVmp0QTlUcHptNG56Zy91RGtSWTFoTnRkUXli?=
 =?gb2312?B?QXdPQnlsMVN4OFoyWnNKV0daOENvb0c2Q2xlN043WE1FWFpGb3JKeXhlQm5l?=
 =?gb2312?B?NjlHOHp0TjBZKzMyeVZZR2xGMU1qZEU2OWNlU2hQSnlQOTRYRDFpZ1JtcDFD?=
 =?gb2312?B?b0dtY3FDU1BhV29iS2dBdDlNTDQvdmVjcFJwcEVxb1lkT0cwV21EeUFwTURw?=
 =?gb2312?B?TXZpQ1BpVFlCc1lMTS8zZGIzNXVvZk01d0NQMTZDSGNEVHRZMmxRd3B4UU9x?=
 =?gb2312?B?TlBvKzdwTnY1dTh1VG1VUEVqNFU2dnNCKzI0SjhLN3RoMzJpUHUrNndQTVJa?=
 =?gb2312?Q?Q39k=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a4ab6f-7469-4ec1-4743-08db7dd2c6be
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 03:40:43.3443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3x+XrOFO1dPShW7y3erG3t4kpolwuLgPx4yFKu9uDrdWGAvg1mXjPHS78g/F9nKgVJSdLQEnfK8UiOUsBYZoKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6105
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

SGkNClRoZXkgYWxsIGNvbWUgZnJvbSBkZXZpY2UgZm9yIGVhY2ggY2hpbGQgbm9kZSgpLg0KDQot
LS0tLdPKvP7Urbz+LS0tLS0NCreivP7IyzogQmVuamFtaW4gUG9pcmllciA8YmVuamFtaW4ucG9p
cmllckBnbWFpbC5jb20+IA0Kt6LLzcqxvOQ6IDIwMjPE6jfUwjbI1SAzOjI5DQrK1bz+yMs6IM31
w/ctyO28/rXXsuO8vMr1sr8gPG1hY2hlbEB2aXZvLmNvbT4NCrOty806IFN1bmlsIEdvdXRoYW0g
PHNnb3V0aGFtQG1hcnZlbGwuY29tPjsgRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQu
bmV0PjsgRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIgS2ljaW5za2kg
PGt1YmFAa2VybmVsLm9yZz47IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47IGxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgb3BlbnNvdXJjZS5rZXJuZWwgPG9wZW5zb3Vy
Y2Uua2VybmVsQHZpdm8uY29tPg0K1vfM4jogUmU6IFtQQVRDSCBuZXQgdjJdIG5ldDp0aHVuZGVy
eDpGaXggcmVzb3VyY2UgbGVha3MgaW4gZGV2aWNlX2Zvcl9lYWNoX2NoaWxkX25vZGUoKSBsb29w
cw0KDQpbU29tZSBwZW9wbGUgd2hvIHJlY2VpdmVkIHRoaXMgbWVzc2FnZSBkb24ndCBvZnRlbiBn
ZXQgZW1haWwgZnJvbSBiZW5qYW1pbi5wb2lyaWVyQGdtYWlsLmNvbS4gTGVhcm4gd2h5IHRoaXMg
aXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNh
dGlvbiBdDQoNCk9uIDIwMjMtMDctMDUgMjI6MzQgKzA4MDAsIFdhbmcgTWluZyB3cm90ZToNCj4g
VGhlIGRldmljZV9mb3JfZWFjaF9jaGlsZF9ub2RlKCkgbG9vcCBpbg0KPiBiZ3hfaW5pdF9vZl9w
aHkoKSBmdW5jdGlvbiBzaG91bGQgaGF2ZQ0KPiB3bm9kZV9oYW5kbGVfcHV0KCkgYmVmb3JlIGJy
ZWFrDQogXg0KIGZ3bm9kZV9oYW5kbGVfcHV0KCkNCg0KPiB3aGljaCBjb3VsZCBhdm9pZCByZXNv
dXJjZSBsZWFrcy4NCj4gVGhpcyBwYXRjaCBjb3VsZCBmaXggdGhpcyBidWcuDQo+DQo+IFNpZ25l
ZC1vZmYtYnk6IFdhbmcgTWluZyA8bWFjaGVsQHZpdm8uY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMv
bmV0L2V0aGVybmV0L2Nhdml1bS90aHVuZGVyL3RodW5kZXJfYmd4LmMgfCA1ICsrKystDQo+ICAx
IGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9jYXZpdW0vdGh1bmRlci90aHVuZGVyX2JneC5j
IA0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2Nhdml1bS90aHVuZGVyL3RodW5kZXJfYmd4LmMN
Cj4gaW5kZXggYTMxN2ZlYjhkZWNiLi5kYWQzMmQzNmEwMTUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvbmV0L2V0aGVybmV0L2Nhdml1bS90aHVuZGVyL3RodW5kZXJfYmd4LmMNCj4gKysrIGIvZHJp
dmVycy9uZXQvZXRoZXJuZXQvY2F2aXVtL3RodW5kZXIvdGh1bmRlcl9iZ3guYw0KPiBAQCAtMTQ3
OCw4ICsxNDc4LDEwIEBAIHN0YXRpYyBpbnQgYmd4X2luaXRfb2ZfcGh5KHN0cnVjdCBiZ3ggKmJn
eCkNCj4gICAgICAgICAgICAgICAgKiBjYW5ub3QgaGFuZGxlIGl0LCBzbyBleGl0IHRoZSBsb29w
Lg0KPiAgICAgICAgICAgICAgICAqLw0KPiAgICAgICAgICAgICAgIG5vZGUgPSB0b19vZl9ub2Rl
KGZ3bik7DQo+IC0gICAgICAgICAgICAgaWYgKCFub2RlKQ0KPiArICAgICAgICAgICAgIGlmICgh
bm9kZSkgew0KPiArICAgICAgICAgICAgICAgICAgICAgZndub2RlX2hhbmRsZV9wdXQoZnduKTsN
Cj4gICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiArICAgICAgICAgICAgIH0NCg0KRml4
ZXM6IGVlZTMyNmZkODMzNCAoIm5ldDogdGh1bmRlcng6IGJneDogVXNlIHN0YW5kYXJkIGZpcm13
YXJlIG5vZGUgaW5mcmFzdHJ1Y3R1cmUuIikgPw0KDQo+DQo+ICAgICAgICAgICAgICAgb2ZfZ2V0
X21hY19hZGRyZXNzKG5vZGUsIGJneC0+bG1hY1tsbWFjXS5tYWMpOw0KPg0KPiBAQCAtMTUwMyw2
ICsxNTA1LDcgQEAgc3RhdGljIGludCBiZ3hfaW5pdF9vZl9waHkoc3RydWN0IGJneCAqYmd4KQ0K
PiAgICAgICAgICAgICAgIGxtYWMrKzsNCj4gICAgICAgICAgICAgICBpZiAobG1hYyA9PSBiZ3gt
Pm1heF9sbWFjKSB7DQo+ICAgICAgICAgICAgICAgICAgICAgICBvZl9ub2RlX3B1dChub2RlKTsN
Cj4gKyAgICAgICAgICAgICAgICAgICAgIGZ3bm9kZV9oYW5kbGVfcHV0KGZ3bik7DQoNClwgZndu
b2RlX2hhbmRsZV9wdXQNCiAgICAgICAgXCBvZl9md25vZGVfcHV0DQogICAgICAgICAgICAgICAg
b2Zfbm9kZV9wdXQodG9fb2Zfbm9kZShmd25vZGUpKTsNCg0KV2l0aCB5b3VyIHBhdGNoLCB0aGVy
ZSBhcmUgbm93IHR3byByZWZlcmVuY2VzIHJlbGVhc2VkIG9uICdub2RlJyAodHdvDQpvZl9ub2Rl
X3B1dChub2RlKSBjYWxscykuDQpPbmUgcmVmZXJlbmNlIGlzIGZyb20gZGV2aWNlX2Zvcl9lYWNo
X2NoaWxkX25vZGUoKSwgd2hlcmUgd2FzIHRoZSBvdGhlciByZWZlcmVuY2UgdGFrZW4/DQo=

