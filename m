Return-Path: <netdev+bounces-40658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D247C82DA
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 12:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CDECB20973
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 10:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDF711CA9;
	Fri, 13 Oct 2023 10:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IXEq/xtD"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94622882D
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 10:16:32 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2084.outbound.protection.outlook.com [40.107.14.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967DBA9
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 03:16:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lf2fvg6bAn91XIBOs+zOUPtAQB7CwAPQgy+30hzWsNvqZVkfiG69IDLf+B5DCM9PExEymG8oajF0kwKIPnbThA1HYOl14B6AwnYV3TW/OdopCz87lGk0kJsTRc7T6ZiOoXUoaNQcAFdHOJOT1wVrRLeaFu08fGnBtkDqDqh730jvKl+s/g6XVn40DOSqkVoIxWi6K643qGf9tNjXw2HeDLq0eEgn/5oLJftoG79tZ7V0g3uv9BRfmxii5zsyMyIxA0gc1XApZQx09H0TC9AOmPh2r8P58Q0bWZfgToPN06pEi7OAdkxzQH8dtdb1JApwPHyWjgJwG1v3wGNnM8f5xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UENhj269AC1688nRgQSpNUN6wVfX3/OksBUeQWOyzQ=;
 b=TPrK4AEOQpNkXmolLkAsrUmJiW+Nx/QqCUediX+bScB/7LVC9xsoVa1OKtNofyqnFU7ethw0X4DjiBWDthz0tmDnaiXgM+IJs0HqGfR+jNsOTmP0GWV7898DEBZA+fNRgkJpXI7/Koe6bVCUuqaLyXLwsPR7dzgxtXyLDSXAARv0+jtI6IRaXvtnsUIgGS9UeO66Fme3MJIStuU9goOg6RTcHJreseGSihs9YNHrjBs0huYUHYaiF3cR6DgE7do+wyhhmmJG0Rms5Xyz5hXPbbWNq4FYyRSCFDTTWjfAFy1B5Odc0gAXNBzcArdVfeMZv61j2dbqkC9LyMBaI5uOtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UENhj269AC1688nRgQSpNUN6wVfX3/OksBUeQWOyzQ=;
 b=IXEq/xtDGYuxhgk11Eh7g6oH8zasaRjZ1jCvJA83evrPHunRO9QA170tZ3t2+sVwD9S0MV6kYgPXXR1j2DFHMAB5SYYS3p0wEQF2UQeYrAC8yFiS/P4YnwMae9lFJ+IBfJ238AfbOtQj9eWFLciRFBBDaHQdlPWQCm51Np9Bdgs=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by PAXPR04MB9280.eurprd04.prod.outlook.com (2603:10a6:102:2b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 10:16:27 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::9c92:d343:b025:6b07]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::9c92:d343:b025:6b07%4]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 10:16:27 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, "Russell King (Oracle)"
	<linux@armlinux.org.uk>
CC: Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, dl-linux-imx <linux-imx@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, Stephen
 Hemminger <stephen@networkplumber.org>
Subject: RE: Ethernet issue on imx6
Thread-Topic: Ethernet issue on imx6
Thread-Index: AQHZ/TJTC4qZSMoLtkiGvwvK31sWhrBGjSeAgADaLICAABlLcA==
Date: Fri, 13 Oct 2023 10:16:27 +0000
Message-ID:
 <AM5PR04MB3139E09E9005346B206CFC5288D2A@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20231012193410.3d1812cf@xps-13>
	<ZShLX/ghL/b1Gbyz@shell.armlinux.org.uk> <20231013104003.260cc2f1@xps-13>
In-Reply-To: <20231013104003.260cc2f1@xps-13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|PAXPR04MB9280:EE_
x-ms-office365-filtering-correlation-id: f1770150-e844-4e62-a688-08dbcbd575fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 im7Klb/m5+G5hEwOblkQWYYBw81ZAVmy3lC5JWcnm91QxNpXNpLhPYLiMakiq+ok3uWu2u8KPFAG0I3XmI0hxORsgNzeXg8mablNf/UW1+RuIuCHSf7wia3YsIcuwjqRIC/jeyZoQw2weAVu+nUgsN1g3q490kMQNwuq3GyUVroc7T+hhLLngSQh8WcQCRmDk+BOwrnBJJbF6KbVEdcpim1IDF57Xg2CB05aUUdJahXx9O8RzpqmkrFfpD0wqk7mTU8mi1Oyyfz9tNQGkXsctjLMveeFDplGloYMQ0at9IJ5dTkpiHhvbEgHnvcilqiBULieE5uTWSWmZOat53BfzDBkUdZMlQKcyh12XYb0z4RjRPGNSHm4Ulp/SMvaICIQkoBAkktpNQxEqzLA22E6N2/ENBiFxWTLnXOxERIyTv6oLYtGOXV90/ZON/9dCd6RPhQLOFFyZxrhbbunSpliufFkg8P4RfzGf2n/vevTH3Om43Eh4CwKNGEwUALP8BgXpCd4RwhG+cWY200Todq6PORBMGOVdA2Z6PW2WKD9mm2jPyTkUZjjMnR1oOWjgCt6fwqiWj2OZ+IfvgHlHjiID93S/PBG22SPkrKYUaqbDIZUCTKGuYjVq9w8no8XgStm
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(39860400002)(376002)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(86362001)(2906002)(44832011)(41300700001)(4326008)(8676002)(8936002)(52536014)(5660300002)(66946007)(66446008)(54906003)(64756008)(66476007)(76116006)(110136005)(316002)(7416002)(66556008)(33656002)(478600001)(38100700002)(55016003)(6506007)(7696005)(53546011)(71200400001)(83380400001)(26005)(38070700005)(122000001)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WlhvQyt3M3pGalNOby9SUS92Skp1d2JraldmTjVFajZKSDFzeDB1eEVDYnAy?=
 =?utf-8?B?MjQrMWhCemx6M0NLMEdKa1ZTVCtkOUdQZ3dEdFI0TFRWWCtYT2FSby94VSsr?=
 =?utf-8?B?QjhPaUNaemp5b1RaZE5YN3RvY0Vxa2dPZUR0aGtMcEdMTVFRR2JXMjVYMS82?=
 =?utf-8?B?Z3ZIT1VxZkhTL1dUVmpTWDd2RUJUcDFNVFpqdkhic1dQWGRLeXpweENYSHlk?=
 =?utf-8?B?NlY0SytDczF6b0NORlVCZXB5a2JiMGJWRkYzb21vckFzMzRnOHZoekY2UlNi?=
 =?utf-8?B?UTNFVmxSdEVYWXBBdGh1UFQrRXJrdkF1ZUJMVGpGeDY3dXRQT290UllKTi9z?=
 =?utf-8?B?T0xwc3BBZzNQQVIzSkJhWVc2TXUxTUJwczh0RitVNk12TTEyTUF0ZkR6QlBu?=
 =?utf-8?B?RDlNL1hJVmhkb0pldW1HS25id3FVWmx6YmtLZXduZ1V3UmhvRVJOdWIzZElt?=
 =?utf-8?B?bXRGbmcvTlVRWVNpVUFRTUNvb2wvUjJvMkIveEE1S05ybmJyLzNvNkZjakhD?=
 =?utf-8?B?dzRCN1g5ZDMzZFFxRTBlVVhXRXRxUXZCaS9QWHloclRJcHpSRjBMNEVBSk9F?=
 =?utf-8?B?ZjNSNUk2M1lzV3ZpRk5rMTljczFoelE3SE1FMW1YZFV0L0xId2M5QnVPcHlR?=
 =?utf-8?B?Zk5VdzRta2l0NDRyb2ZDOWVybkZPYmF3c3l0T1YrUnAydWpnY2szQWYvSW9r?=
 =?utf-8?B?YzA5WHZ0V0phN29JMy9RenpXVHM3MjNOY3F3NzIyc1ZMcjA5UGt1bGwxeVln?=
 =?utf-8?B?b2NzNXh2Z1ROVWpVbG1DS3B2S2hTQXZQVFMzWGdjUUpWVWZzV1drQ3ZLK1dp?=
 =?utf-8?B?S1p2QVprTVE5V3RWTWhjS1E2RUR3YkYzdEkvc3A5UmlYWlZkYzFXZzVCWElQ?=
 =?utf-8?B?Wm9BbzdZNitoZVprNk84S2Y1VmY2L0dTZW9vaEYyTTF5c25aLyt0SndaekVv?=
 =?utf-8?B?NTJRdUhFWnkrK3pJc3pFYWR1bmpRVjJxVkJhYk5JeE1mSXhiVVVwYVBzSTVw?=
 =?utf-8?B?TmVzTjFiSDloQ0NxSmpnd0RsZnJ2OExrRWkzV1FRVG4vaHVWb3AxZU5EODha?=
 =?utf-8?B?djlQdlkvekZqeHFkRmlZQlBnM3MzTGhHYmxSSXkvK01MSUdYMXo1UkZteElB?=
 =?utf-8?B?VWxUbnRDNGwwTy96UkFpcnlrNmlhMzNrUUU1L0VQZzNubHlCakE2YkpDQnJB?=
 =?utf-8?B?MmMrcHAzMU50TzlQNjVPSmlFK3lvK255RVhla1JMNGFZVDNyQ2VlWEtkckxX?=
 =?utf-8?B?Ymo4ZXluNkUyWXlTS0VVS0NUQTFBSzVnckdaeEc2WTF5ZGhRZmtDUXdYc2Qx?=
 =?utf-8?B?Y0J0T2VHemhtZHd2WWo0K3dtWWtjYStNZEMyRXkwaGJYZXZ6TzZFUHJUVlJo?=
 =?utf-8?B?bGttTjRKWkJuYng0NFhkckpJdHRXYWozY3RMWG85ZTIwYUpuT0FybDNNbVZw?=
 =?utf-8?B?RGtUdXRSZ1IwdjlkeDR3N29BZnRuOFZlOFNwRzkzWlhURzNrOUY3M2ZkWmtE?=
 =?utf-8?B?ZmUyYWpXQnYyNVhFSytXU2pPMWpwUDR0U1VkOFpBalhzd3V3amhodTcxNG1u?=
 =?utf-8?B?ODJRWnRlZ082M1lROG5vUlN1TlBYUGNGSVBvV240bnN2cG9iYnZHM1AzNGtG?=
 =?utf-8?B?RW1OZVZ2TU01TWdwamdyWGdXZnljRXFMWmdvTXBjRFZoMVRqR1djYXJ0d1Ew?=
 =?utf-8?B?T2U0RUJzRCsva1RnOU5BTC9TQjRmcndFaXY1N0dkZEE3S29nbWJVZlJ2ZFMr?=
 =?utf-8?B?cFhLRWthMXdGc2R0eUFoZEFJMkFOR0RHRG5KYVlVQXoxWC94ekRaZ3R3ZXZ6?=
 =?utf-8?B?ZllMUVpQVzNXcGY5aXdMaEhTTnFLS1E0ZWJIN1IyTjhRV0xxOTNxNWwxOXF0?=
 =?utf-8?B?N0VEMTdrcit2MjNhUkQvN2lLZExvZktIRFkremJxRFR1V3NHVGFnUEtCYzYy?=
 =?utf-8?B?Mko4dlhJc0lHd0FlMFJXRTAzUE4xRVJvdUtDVDEvU2cyVjUrMTl5Zlo4enBW?=
 =?utf-8?B?QU04K2VyWFVzejBuMHVnMWorUldTUUkzN1ByQnhmTkg0bGRQRHl0cm9JeXZy?=
 =?utf-8?B?NGQ3WmJHajdHNXJqRXo4U0dpVXlaL0o1MEhKNzFvU3d4TUVKelpsR0hyTjdN?=
 =?utf-8?Q?v8+4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1770150-e844-4e62-a688-08dbcbd575fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 10:16:27.0898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tIzTdbP6kfBKKlbofhB38STtDRqKOLp/bSnVXHGSJkbKQGNeMGcPhaJsVb1Zxd0xNEb5Epefi53ItLqGK/jcOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9280
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaXF1ZWwgUmF5bmFsIDxtaXF1
ZWwucmF5bmFsQGJvb3RsaW4uY29tPg0KPiBTZW50OiAyMDIz5bm0MTDmnIgxM+aXpSAxNjo0MA0K
PiBUbzogUnVzc2VsbCBLaW5nIChPcmFjbGUpIDxsaW51eEBhcm1saW51eC5vcmcudWs+DQo+IENj
OiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT47IFNoZW53ZWkgV2FuZw0KPiA8c2hlbndlaS53
YW5nQG54cC5jb20+OyBDbGFyayBXYW5nIDx4aWFvbmluZy53YW5nQG54cC5jb20+Ow0KPiBkYXZl
bUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29nbGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7DQo+
IHBhYmVuaUByZWRoYXQuY29tOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsNCj4g
bmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgVGhvbWFzIFBldGF6em9uaQ0KPiA8dGhvbWFzLnBldGF6
em9uaUBib290bGluLmNvbT47IEFsZXhhbmRyZSBCZWxsb25pDQo+IDxhbGV4YW5kcmUuYmVsbG9u
aUBib290bGluLmNvbT47IE1heGltZSBDaGV2YWxsaWVyDQo+IDxtYXhpbWUuY2hldmFsbGllckBi
b290bGluLmNvbT47IEFuZHJldyBMdW5uIDxhbmRyZXdAbHVubi5jaD47DQo+IFN0ZXBoZW4gSGVt
bWluZ2VyIDxzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZz4NCj4gU3ViamVjdDogUmU6IEV0aGVy
bmV0IGlzc3VlIG9uIGlteDYNCj4gDQo+IEhpIFJ1c3NlbGwsDQo+IA0KPiBsaW51eEBhcm1saW51
eC5vcmcudWsgd3JvdGUgb24gVGh1LCAxMiBPY3QgMjAyMyAyMDozOToxMSArMDEwMDoNCj4gDQo+
ID4gT24gVGh1LCBPY3QgMTIsIDIwMjMgYXQgMDc6MzQ6MTBQTSArMDIwMCwgTWlxdWVsIFJheW5h
bCB3cm90ZToNCj4gPiA+IEhlbGxvLA0KPiA+ID4NCj4gPiA+IEkndmUgYmVlbiBzY3JhdGNoaW5n
IG15IGZvcmVoZWFkcyBmb3Igd2Vla3Mgb24gYSBzdHJhbmdlIGlteDYNCj4gPiA+IG5ldHdvcmsg
aXNzdWUsIEkgbmVlZCBoZWxwIHRvIGdvIGZ1cnRoZXIsIGFzIEkgZmVlbCBhIGJpdCBjbHVlbGVz
cyBub3cuDQo+ID4gPg0KPiA+ID4gSGVyZSBpcyBteSBzZXR1cCA6DQo+ID4gPiAtIEN1c3RvbSBp
bXg2cSBib2FyZA0KPiA+ID4gLSBCb290bG9hZGVyOiBVLUJvb3QgMjAxNy4xMSAoYWxzbyB0cmll
ZCB3aXRoIGEgMjAxNi4wMykNCj4gPiA+IC0gS2VybmVsIDogNC4xNCguNjksLjE0NiwuMzIyKSwg
djUuMTAgYW5kIHY2LjUgd2l0aCB0aGUgc2FtZSBiZWhhdmlvcg0KPiA+ID4gLSBUaGUgTUFDIChm
ZWMgZHJpdmVyKSBpcyBjb25uZWN0ZWQgdG8gYSBNaWNyZWwgOTAzMSBQSFkNCj4gPiA+IC0gVGhl
IFBIWSBpcyBjb25uZWN0ZWQgdG8gdGhlIGxpbmsgcGFydG5lciB0aHJvdWdoIGFuIGluZHVzdHJp
YWwgY2FibGUNCj4gPg0KPiA+ICJpbmR1c3RyaWFsIGNhYmxlIiA/DQo+IA0KPiBJdCBpcyBhICJ1
bmlxdWUiIGhhcmR3YXJlIGNhYmxlLCB0aGUgZm91ciBFdGhlcm5ldCBwYWlycyBhcmUgZm9pbGVk
DQo+IHR3aXN0ZWQgcGFpciBlYWNoIGFuZCB0aGUgd2hvbGUgY2FibGUgaXMgc2hpZWxkZWQuIEFk
ZGl0aW9uYWxseSB0aGVyZQ0KPiBpcyB0aGUgMjRWIHBvd2VyIHN1cHBseSBjb21pbmcgZnJvbSB0
aGlzIGNhYmxlLiBUaGUgY29ubmVjdG9yIGlzIGZyb20NCj4gT0RVIFMyMkxPQy1QMTZNQ0QwLTky
MFMuIFRoZSBzdHJ1Y3R1cmUgb2YgdGhlIGNhYmxlIHNob3VsZCBiZSBzaW1pbGFyDQo+IHRvIGEg
Q0FUNyBjYWJsZSB3aXRoIHRoZSBhZGRpdGlvbmFsIHBvd2VyIHN1cHBseSBsaW5lLg0KPiANCklz
IGl0IG5lY2Vzc2FyeSB0byB1c2UgdGhpcyAnaW5kdXN0cmlhbCBjYWJsZSc/IENhbiBpdCBiZSBy
ZXBsYWNlZCB3aXRoIENBVDUgb3INCkNBVDYgY2FibGU/DQoNCkkgYWxzbyBjYW5ub3QgcmVwcm9k
dWNlIHRoaXMgaXNzdWUgd2l0aCBteSBpLk1YNlVMIGFuZCBpLk1YOFVMUCBib2FyZHMuDQpyb290
QGlteDZ1bDdkOn4jIGlwZXJmMyAtYyAxMC4xOTMuMTA4LjE3NiAtdSAtYjgwTQ0KQ29ubmVjdGlu
ZyB0byBob3N0IDEwLjE5My4xMDguMTc2LCBwb3J0IDUyMDENClsgIDVdIGxvY2FsIDEwLjE5My4x
MDIuMTI2IHBvcnQgNDYzODIgY29ubmVjdGVkIHRvIDEwLjE5My4xMDguMTc2IHBvcnQgNTIwMQ0K
WyBJRF0gSW50ZXJ2YWwgICAgICAgICAgIFRyYW5zZmVyICAgICBCaXRyYXRlICAgICAgICAgVG90
YWwgRGF0YWdyYW1zDQpbICA1XSAgIDAuMDAtMS4wMCAgIHNlYyAgOS41MyBNQnl0ZXMgIDgwLjAg
TWJpdHMvc2VjICA2OTAzDQpbICA1XSAgIDEuMDAtMi4wMCAgIHNlYyAgOS41NCBNQnl0ZXMgIDgw
LjAgTWJpdHMvc2VjICA2OTA5DQpbICA1XSAgIDIuMDAtMy4wMCAgIHNlYyAgOS41NCBNQnl0ZXMg
IDgwLjAgTWJpdHMvc2VjICA2OTA2DQpbICA1XSAgIDMuMDAtNC4wMCAgIHNlYyAgOS41NCBNQnl0
ZXMgIDgwLjAgTWJpdHMvc2VjICA2OTA2DQpbICA1XSAgIDQuMDAtNS4wMCAgIHNlYyAgOS41NCBN
Qnl0ZXMgIDgwLjAgTWJpdHMvc2VjICA2OTA1DQpbICA1XSAgIDUuMDAtNi4wMCAgIHNlYyAgOS41
NCBNQnl0ZXMgIDgwLjAgTWJpdHMvc2VjICA2OTA3DQpbICA1XSAgIDYuMDAtNy4wMCAgIHNlYyAg
OS41NCBNQnl0ZXMgIDgwLjAgTWJpdHMvc2VjICA2OTA2DQpbICA1XSAgIDcuMDAtOC4wMCAgIHNl
YyAgOS41MyBNQnl0ZXMgIDc5LjkgTWJpdHMvc2VjICA2OTAxDQpbICA1XSAgIDguMDAtOS4wMCAg
IHNlYyAgOS41NCBNQnl0ZXMgIDgwLjEgTWJpdHMvc2VjICA2OTExDQpbICA1XSAgIDkuMDAtMTAu
MDAgIHNlYyAgOS41MyBNQnl0ZXMgIDgwLjAgTWJpdHMvc2VjICA2OTAzDQotIC0gLSAtIC0gLSAt
IC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtDQpbIElEXSBJbnRlcnZhbCAgICAg
ICAgICAgVHJhbnNmZXIgICAgIEJpdHJhdGUgICAgICAgICBKaXR0ZXIgICAgTG9zdC9Ub3RhbCBE
YXRhZ3JhbXMNClsgIDVdICAgMC4wMC0xMC4wMCAgc2VjICA5NS40IE1CeXRlcyAgODAuMCBNYml0
cy9zZWMgIDAuMDAwIG1zICAwLzY5MDU3ICgwJSkgIHNlbmRlcg0KWyAgNV0gICAwLjAwLTEwLjA0
ICBzZWMgIDk1LjQgTUJ5dGVzICA3OS42IE1iaXRzL3NlYyAgMC4wNDYgbXMgIDAvNjkwNTcgKDAl
KSAgcmVjZWl2ZXINCg==

