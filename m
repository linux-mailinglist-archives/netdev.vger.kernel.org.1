Return-Path: <netdev+bounces-18807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBBF758B32
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 04:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B04281C20EB0
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 02:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0A217E1;
	Wed, 19 Jul 2023 02:10:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073DE17D8
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 02:10:41 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2119.outbound.protection.outlook.com [40.107.215.119])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBCA1FE1;
	Tue, 18 Jul 2023 19:10:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OgcL5PDZTNaAEmGl3PoWBsw9LPQz53ud4r+bUBF0v2qQk0M6xZXTTnPyHamBHnk8vlZL1wB4yd20BPX0sZe4AtOp1N49UpCJim75hdr811O/NG/SHB/gSNYWxd4BzXrK3MpQRD2gOVdcxqvX3EB2wa/LvFNKWlJaDouqru5W0DRMhvMJ8zJ2plTDH8GChUX51p8T6J77kF1wlwoFvMmwDzLzlR0hiB38dZaceUjUa6/gbK5eqBpz6Csdpuoi/jSF/7ydGBx8yauwmKiUvJJS8YcbbNO2JVikShGebTlYxcurCSmPwVHPi6Vvo/yyJKhcvexZ685piGt3vV7N1Mmizw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekFck0qC/pwiK4+bDKUpzEgFy8PtAYCWu0gLo2NOliE=;
 b=hGfjj3wiBw+GM6bSd4sT7aofA8d5Q+yNBwFWKwdemneJv1/QdRDDvUzUygKsW+E8oDWRD+p3nsQGnM3JsLbqsP1LANqkxYDGiNz4yUKn/QWaMGPyco9gcHsbWYZdvUq8mKAa+9158IGzDa92LQeCqFQ/Wr+IhUbhQqhGhf9JkhjpRFQAoQgBBqg2hx4o5mBcdClS8xmRV5LAxhduuELyKV/hn0n/Sg4ytZbnXlvXxHAp+mgEUL9ZhabDvU3vWdE7G/eFIdGl7/wCd6Rli8xrqC0CphM00edkwJUFDCp9V4EgCZFD1PYs7tQUDvfe0AcBzM+pAx0zep+2Ju4gXNvv1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekFck0qC/pwiK4+bDKUpzEgFy8PtAYCWu0gLo2NOliE=;
 b=n1GJ9MRMhE/odDS5BN25JxNoX1bE+4BKvsjY1zSGgr+aKTm5jXvffrsvAszTBT91xFO+Sxdmb2+tL4FVrjD82qjTs4v6mpYuMffxIpQhZMZykX6KZ6uvvMt63cQsVtcKfLwgkHkqv4wzswMClbxTthzpwvb6mGLmsLPLaF2VkLfFOokKCWWcjr1LWSs+gO84B+ahO3Al+uH//gkF3EPELpuqaQhnNXbHE9/ZMSZuVncCryHql/N7HdicliQYijA/h4DphTJeoqlpG6MVyazvwRHMP8CuligqKZ60qHN9zStYg5J0i7x+DHkMw8SMlp7kndINm9tjtgPyuTETkU8dJQ==
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 PUZPR06MB6265.apcprd06.prod.outlook.com (2603:1096:301:119::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 02:10:17 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::535e:25af:a3bc:d600]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::535e:25af:a3bc:d600%4]) with mapi id 15.20.6609.022; Wed, 19 Jul 2023
 02:10:17 +0000
From: =?gb2312?B?zfXD9y3I7bz+tdey47y8yvWyvw==?= <machel@vivo.com>
To: Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Taku Izumi
	<izumi.taku@jp.fujitsu.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: opensource.kernel <opensource.kernel@vivo.com>, "ttoukan.linux@gmail.com"
	<ttoukan.linux@gmail.com>, "jay.vosburgh@canonical.com"
	<jay.vosburgh@canonical.com>, =?gb2312?B?zfXD9y3I7bz+tdey47y8yvWyvw==?=
	<machel@vivo.com>
Subject: [PATCH net v4] bonding: Fix error checking for debugfs_create_dir()
Thread-Topic: [PATCH net v4] bonding: Fix error checking for
 debugfs_create_dir()
Thread-Index: Adm55ilWBPPQtKquwkiHp5nOeeSL1w==
Date: Wed, 19 Jul 2023 02:10:17 +0000
Message-ID: <20230719020822.541-1-machel@vivo.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-clientproxiedby: TYAPR01CA0076.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::16) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3743:EE_|PUZPR06MB6265:EE_
x-ms-office365-filtering-correlation-id: 3a712219-d8ff-4e53-bf52-08db87fd4bd6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Ws8feDLCbOhIsJ4huW7wNPR8tPrSvpzSxmztXYQ9dnuxDINovD9S33RvJPW4zFI+xugTEFTRA1AIyYtLSEomZpgay61QiKXZNPMJJSiG3+eMspl/C+yaPRFupUbKNAZ2TJpIxmFOM1nuulFtY4bPH2uhjgwGswhm3hDltoDWE/5r4/3ziiDYmiog6KOcjLhpAiOUCbJz+d/k6lySzm8erNRxEpi27zAgg5AMqF6SPtHkUaj+aQJgLUMUTxXEkVt7EjDzxNGX2ZpJmfmYYzSb65uKIie6bCc2kOjv2i5QYAc+EDXyZwDSDeLunu1cYFkO/1ZvZPy0CoT1tUAVDshdN4XR5EUUoigr/hR3Inm9OyiaR9f0LIji1UMUJKrs5WZH3hQLegbES9GbpKDOg+hZKvCU97B8mWdPIfrgDzvlFgF11YsG2AXFYjw/pKBU7DBq59Iu5ol2QGXeZJlMVxoChXod0vY/Oh6BYv7ozfFrr5ueYVzYtcxBt8aTtuITSZG8UiT81gs0qr48TlqVu61vEYuqCgPJzd4XVCiOkRbCjCG7l5ahiUZBYKuzHFVsjZi05uxjfERKvgHsOLQjqZcsK0b9ZztLb1cQ2/XojMz4TZI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199021)(83380400001)(478600001)(52116002)(4744005)(186003)(2616005)(86362001)(6486002)(6512007)(6506007)(1076003)(107886003)(38350700002)(66946007)(64756008)(71200400001)(7416002)(38100700002)(54906003)(41300700001)(66556008)(85182001)(110136005)(2906002)(26005)(36756003)(66446008)(122000001)(5660300002)(8936002)(4326008)(66476007)(8676002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?QmVBbGZVRGs0UDlQWGt3eGlJOWo2T210T0NUUkxvY2xyb2xKV1JoVng1UHdP?=
 =?gb2312?B?cmFOeThVVGd0c1dld0N4U1ZwMG1JUVlTNG92bEhheXNGZEFVSHdhdXNrRTFR?=
 =?gb2312?B?OFdwODdqZmZqY1JYellrdTVwbnNGWWN5NnZJL2xyVFYyaEFrWmZTNlYyNWxx?=
 =?gb2312?B?anBKUURYZ0dsR3BPS04ydW9nR2RpTmNEY0srWlN3UHo3TzE0dFhFVU1uU3Y5?=
 =?gb2312?B?djVlWWlES3pKY1R6RnZsUGc0TGR1Vi9zd3ZweHlKQXJBeUVtTGRHWjdpOFY0?=
 =?gb2312?B?TjljL0k4NStnVmdCN1lTWTIxbHFBTGt1bnZ4bnNMT1hLbnd4Qk1aUURIaG5i?=
 =?gb2312?B?aXVLTjFPSFlia1QwUkhQaDhLWlpYZEVGbHNrWWcyQXc3Mjc3dkwwTGd3L1FR?=
 =?gb2312?B?NG4wMUZEMExYRHY5NDRvbkQ3MEM5MGhlMnEwd1Y0QWJLYy9qYzhnYjU5dE14?=
 =?gb2312?B?WnErVGYvbXVFTTZ5N09pckM4VkxPeXhSR2N1NGJvQmpzYmhJbmIzSCtJR3lM?=
 =?gb2312?B?NVhMVDFRZDF1bzBpNVJKZ0ttRThOQ1JSeW5JemF0c3dzdDlnalptbDZSaXFP?=
 =?gb2312?B?cytZV3dsdmJkNXdodWEwSXJzSE5nNFFkSEFab0pCbWZGeTZXc3hiUlIzRlBK?=
 =?gb2312?B?Q091SWV4QVVWaVZzOEM2a3FwZ2N5YWZvUVZXdTdxajNxSEVZMnptTlZqVDF6?=
 =?gb2312?B?SW95NWt4QTFNS3VOWFhLSyt0eU1TN0pjK3ZZSEQyalhISmhLTmxCTFUxVW1m?=
 =?gb2312?B?dUUxYjgrWGJlWVE3cFV3cTVGeFdEUE1pQnRiN0xtSXpPYlNBczRJU2FrV2pk?=
 =?gb2312?B?RnVRdWZKVGFwc0NWRElpTmhVS3VyMWxoTmlpZXduTHJlZGxkKzRHR2dSOUJ3?=
 =?gb2312?B?NXpCcEVUZTBQN1lyTjNudUErSDdyLzd1OVppSVpvWUpwdjA5bGpNSVhMaWdj?=
 =?gb2312?B?Uk81NGRtSWhnUWhTcndrL1FISkVibTgvckdEZ21NcUZwMTltY3BhalErQ1ZE?=
 =?gb2312?B?Y1dCVXdpUWZoRnRvNE1pb1ZHVzlSVXkycHVWeWF4aTFIMThFbTdiK0tQT3pq?=
 =?gb2312?B?YXgxUXI0dWtoVEhRRGg2a2lNMVU3ZlZGaHZMWXBDM01KR3BDL3BQenhiT3ZY?=
 =?gb2312?B?TW16TFJSdm14aVQ5TGFGZncxTld0R3ExR011anE4WmtMNG1uZUJBamo2NUFX?=
 =?gb2312?B?eC9YUUdOVXNybUF1QUo1RnlwejVPZDRQaTE1dnFGY01OVUFrZjI5L2lwT3g5?=
 =?gb2312?B?NHNyQVpkT1dCTVI3bEsyVWRtRjZQQzlGeUozaFY4VmtwV0dzcTg5Unkxd2RK?=
 =?gb2312?B?K1RWT2VsSUJyS0ZubXBWeWZrLzlObWREVElYd29iM2F3elc3N1EvWFNkRklV?=
 =?gb2312?B?RzB4bGhvYXhVY05OMmMrcFRCUkRJYlFVTUdZbUt0dERTSGFZM09lcWhLSVpN?=
 =?gb2312?B?ZlVpYk1hWGVjWXc3ak9tdWVuUkxEbm43UGYvcDdUNWc3M251Z0dvenk4NVRt?=
 =?gb2312?B?aE45NWJCZ3Eyd3Y1UldCM3ljVTJOVXc4MWNlS1U2aGcwa3luMFljSlRxUHZp?=
 =?gb2312?B?MkxncldsV0ZLdWF0VWVoWFRnTlhhUGFCbEJPeHBNbkIzSGFQeVljR2NiOEE2?=
 =?gb2312?B?NWVjRnJUMEFnOWNiS3pRQWRCSE9rK2Q0WWxITDh6a2VRZVFVVnZKOTZSbVFo?=
 =?gb2312?B?WnFMS0pzaEpQb0FkclRvVHJ4YmFCa1Zua3dWM3lLSlVQL2I1cTdxc0dBdm1X?=
 =?gb2312?B?cnVSSEZmNWk2ZGt4eU12VE05OUphK2Q3ODlXckhqdm5malpKczFxUkhrMTRz?=
 =?gb2312?B?ZE5mT09OTTBXeVlKS0VaMVUweFloRlh4em5DR05vVnNaM1pFd0w3WUdvek5N?=
 =?gb2312?B?TE1yQXRpK1pQalJKOXllWmFNQ0NhNnpOU3crTVVvVXRnZ3pjVVRIYVdaY0V3?=
 =?gb2312?B?MmJlNjV0ZGFpVWZDSmdET3o4eU5xaGlneDl5VkovajNRSmJjK3FyTUtscGV1?=
 =?gb2312?B?ci9ac1hrendMd2hyNzBWRjljN0Jlb0FLa1lMTEZRaEpTOGN4dmQ0Q2hTS2NW?=
 =?gb2312?B?S1Z5ZUlIbXdkTFlsMXRKQUVLdVNZUmd0TksyaEpxME1iNkRQNThLNWJFMlNs?=
 =?gb2312?Q?EGo0w0JPxiPg21yCoiBHr3vp5?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a712219-d8ff-4e53-bf52-08db87fd4bd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 02:10:17.1478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MNAF9N+QGpvcmu+xOsHUsHOmSld7aWHx8X2O8X5BGlEAWJZ4XtDA83qfq6Jv3f2fq3mCQXLtzhTGI2wi1EkrWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6265
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

VGhlIGRlYnVnZnNfY3JlYXRlX2RpcigpIGZ1bmN0aW9uIHJldHVybnMgZXJyb3IgcG9pbnRlcnMs
DQppdCBuZXZlciByZXR1cm5zIE5VTEwuIE1vc3QgaW5jb3JyZWN0IGVycm9yIGNoZWNrcyB3ZXJl
IGZpeGVkLA0KYnV0IHRoZSBvbmUgaW4gYm9uZF9jcmVhdGVfZGVidWdmcygpIHdhcyBmb3Jnb3R0
ZW4uDQoNCkZpeGVzOiBmMDczYzdjYTI5YTQgKCJib25kaW5nOiBhZGQgdGhlIGRlYnVnZnMgZmFj
aWxpdHkgdG8gdGhlIGJvbmRpbmcgZHJpdmVyIikNClNpZ25lZC1vZmYtYnk6IFdhbmcgTWluZyA8
bWFjaGVsQHZpdm8uY29tPg0KLS0tDQogZHJpdmVycy9uZXQvYm9uZGluZy9ib25kX2RlYnVnZnMu
YyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkN
Cg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2JvbmRpbmcvYm9uZF9kZWJ1Z2ZzLmMgYi9kcml2
ZXJzL25ldC9ib25kaW5nL2JvbmRfZGVidWdmcy5jDQppbmRleCA1OTQwOTQ1MjY2NDguLmQ0YTgy
ZjI3NmU4NyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L2JvbmRpbmcvYm9uZF9kZWJ1Z2ZzLmMN
CisrKyBiL2RyaXZlcnMvbmV0L2JvbmRpbmcvYm9uZF9kZWJ1Z2ZzLmMNCkBAIC04OCw3ICs4OCw3
IEBAIHZvaWQgYm9uZF9jcmVhdGVfZGVidWdmcyh2b2lkKQ0KIHsNCiAJYm9uZGluZ19kZWJ1Z19y
b290ID0gZGVidWdmc19jcmVhdGVfZGlyKCJib25kaW5nIiwgTlVMTCk7DQogDQotCWlmICghYm9u
ZGluZ19kZWJ1Z19yb290KQ0KKwlpZiAoSVNfRVJSKGJvbmRpbmdfZGVidWdfcm9vdCkpDQogCQlw
cl93YXJuKCJXYXJuaW5nOiBDYW5ub3QgY3JlYXRlIGJvbmRpbmcgZGlyZWN0b3J5IGluIGRlYnVn
ZnNcbiIpOw0KIH0NCiANCi0tIA0KMi4yNS4xDQoNCg==

