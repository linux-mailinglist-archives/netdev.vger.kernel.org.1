Return-Path: <netdev+bounces-15787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DCD749BDE
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 14:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CEE51C20D4E
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 12:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88708BE1;
	Thu,  6 Jul 2023 12:34:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D594833E2
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 12:34:42 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2122.outbound.protection.outlook.com [40.107.255.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30FD171A;
	Thu,  6 Jul 2023 05:34:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWNNStij9pMkm/aaZp+8DzGxDKadqF2T5InKQbIJt+dQLobFt6TRfgWXuNK3tubzGKC2g4HmSEFD4UH3MgEHs3+diEsx4j9nlLwg5MpIDoiY+KYOPywF5lVb8P3js9Z6RCFjGtGr4LKYSZsGAa3pvYjv1Z9Xq5GyPxbRXwcaCMIYy/mvx66CvttMvMlwKb53WwcwccHNONWVIInHvB8PdlEvx+WnThE2DaJttL+V9fmVjcp7qSPIckkaULFBdDoVKcTEFfGMIzL5sVYWNl5oGsTVODZ6c0ZUG2YhG31qBjhk4fsKpFnAqIf8RDj7AmoSswur9Kp3CaL1TzS4Ofn/hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+AQ4KCCzbG0SLnzvf1guATMrLZGEwKRK9nPIP8cKRd8=;
 b=CHPGtYW8h9mGl7GBJfrTkFgF772gHH7fcBI+xdFoYdEZlKrkIGiYxUE+2MWheL3ed3y30l6cHgclGcwLbbEt/ArzsHCZD23141WbdD6yKBeBvdbOnRnFlxOVhpnbMwtZKJ3lD8/M9iWzxWZNMW7GHmk6F7GhL9MyIpYbWaBh3Fa7QQwHbdjxNKfaCBp/MxIE+lZgabGHANYcCL9Aaj+6MRDO4gxL08C7KvGH7Nr+BcLKmV687mEXXTCX9PSkttIHvJAwIz6JgTDPtQpDVw9OKThWg7nXo/6l83XJzQ7H4HvuW8xupZRFOAsFVh3c5G0gEMHqGo1zo83GjCNTP1EPZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AQ4KCCzbG0SLnzvf1guATMrLZGEwKRK9nPIP8cKRd8=;
 b=blVjJUhx9/vG97EFq/O5dcSdofIFpiWm2kW1ycKXjQeCb47Hrddc/jTTs4wzfxNtj6OOoWeEXdePEIX+XhGQWMJTzMe1+qEW85hI5N4rP4VwxR5TF+9mcM9S/wbj+qBwXw7ff2j0cyU4Fx4XPMVLZSevpUl5xm0ULOaKBF2ZpxccncG0noyeT1qcM6BE+TCqARt984Skdo7Nhn6TIGncMIZUZxvxXOO6Z9UiuvuCiCJGvO3skNPCTavMI8DVfHoSq0in3hG+PC/ABxS5+N+VRzAzy5ilpewdNXCO07vKDMjPrxQWNHFw1dLlfd7qrHi6AesLiZPRKqiP6GZokhxvEw==
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 SEZPR06MB5558.apcprd06.prod.outlook.com (2603:1096:101:cc::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.17; Thu, 6 Jul 2023 12:34:34 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 12:34:34 +0000
From: =?gb2312?B?zfXD9y3I7bz+tdey47y8yvWyvw==?= <machel@vivo.com>
To: Leon Romanovsky <leon@kernel.org>
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
Thread-Index: AQHZr03sKVk7ictFTkqaLcdv6ppXfa+rihwAgAEjRYA=
Date: Thu, 6 Jul 2023 12:34:34 +0000
Message-ID:
 <SG2PR06MB374377F784F3D314DCAF1AA6BD2CA@SG2PR06MB3743.apcprd06.prod.outlook.com>
References: <20230705143507.4120-1-machel@vivo.com>
 <20230705191028.GP6455@unreal>
In-Reply-To: <20230705191028.GP6455@unreal>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3743:EE_|SEZPR06MB5558:EE_
x-ms-office365-filtering-correlation-id: b49bbe6e-395f-4c66-be94-08db7e1d5aa8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 9VaeonMPRjpFzUb1Z1dlDyF/ghFZkbBYtQ/0N4QlZrKy2ol/t/qVh9SqemMFX+sdqExEt5cFRNBacWZcqtTsoq+etC05lXoqMMK8HzGvgA2voMAG/XEVWMqXJ1RluT/4gQNmcAxbH0mAk97Sn9QXIdIaSQek78whJlggEZxiLG7ZBnUKGoxoacvPHibb3JJK2AUKAweRPAZxW2qhmEpPN+kEb3SlNg7LWuyXg2uZcQ7SnXjCTULGPfGwLH3HPObflwORrtfIN4LmI02TmLs7dHQu88fTqz5wK38P8kYvafJ0/SauPCsKW6GbeHenVNo3eDa8U29d2Xki1s/MwSwhk9ixcAPsq5OVW3fOC7dUjfX4Jd8UxwSj4K+vIVLGD47blNJj+6uTo6drtwTBGRQlW4kDYq4uQpK4ftZyokeEG4hHSR+c8cpjMpf/5l6W4APgQJfgSkMvWZKHbKwtXgWWCkTWxTMxDJOKJV0q+ZO6PXeqyTQOXEcDrE9tDFI+saBY2sDRumHA2jfPXTAiVzCPoS+ziGP4/8IpPlwIqdOqO+80RGovXUs/7RdTumUjwOAVCxtJ884ywfLS/kqZ2fyz6uldhvlA2mtkHqhOyDK2m174175rd96AQDl2opeIXylX
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(451199021)(316002)(66446008)(5660300002)(8936002)(55016003)(86362001)(83380400001)(122000001)(224303003)(38100700002)(38070700005)(66476007)(41300700001)(66946007)(6916009)(85182001)(4326008)(64756008)(76116006)(66556008)(6506007)(9686003)(186003)(33656002)(966005)(107886003)(26005)(478600001)(7696005)(54906003)(71200400001)(2906002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?cE55VFgyQTRtVHd6SEdDZmplZVlyclVvSzJKbWIrNzhkSlNLN3NjYzlOQXNj?=
 =?gb2312?B?NlRXSjhFdUlic0h3WWxLVlNoSXRiWkRBbldWb3pQejViWm51T0tFQU1GVC8z?=
 =?gb2312?B?bG9lM3Z0NHg2MXBPcGI2cXZ1Ti8rSncxajloSnhMbGhNZFpGSWtnQXM4WjEy?=
 =?gb2312?B?TFR1WmVJemZwWkwyTHFOY0JYYmJEVGJNNE1hVHlKRzZTTlp1Y1BqV1ErNlhW?=
 =?gb2312?B?U21lWkI4YWpmUi9GTGhVRnRyUkRYTFRSMXg0UnkxL2p5ek5yUDhUeWQ2aWRT?=
 =?gb2312?B?aTJQaVZRL0lhMVFBeDNtNXFNTUlCYklpaS9aWTJxMFNHcDdjOHU0b0duenRz?=
 =?gb2312?B?ZkpFV3IxZlhjSEhJNTNvdnJDMThvT3VGZmFSYXBlT09EZjFIeE1meHZybXVL?=
 =?gb2312?B?Mm10LzhmTm54QnIyTTlldGFtTERqbC84UDdmemdGdUtBVkJXRTkvRHh2R1c5?=
 =?gb2312?B?Q2ZXblE1eDdZR1NONkJyUHFXZ1hKU2dXcER4L2s1UjBoMkhNVGxrTlpjbWR3?=
 =?gb2312?B?ZVNjQWVnbGQ5c2w2SmhaRk9xTlJvdGY0T0s0dXp4WllmeDh3dHh5S1gwam9v?=
 =?gb2312?B?VjdnaE9IbXAyeUx6bzZYTkdZNVNqNWdHNjhaL3A3UGZzSlpNS08rMU8zQVBj?=
 =?gb2312?B?V21sbngvd3doTDIyTVFnbExuREQ2S3FrY0FEVVRSWmxLZC9IU1NQUnYwNUtE?=
 =?gb2312?B?QjNXMFZBeTVEbCt5aUZkdE1tQVhNa0Zpam9OdkpOclF3K1IvenF5ZkZCdExw?=
 =?gb2312?B?cDUwb3VsS1dXTkFTTmsvNnlGQUdVYkNEalZ1MGxTMnpzM25CNDR4M0JBQUdm?=
 =?gb2312?B?L1lwc2I1ckZmUG1wb1pJSUpOUHVZZm9Cei9nODhTUUNsSWtRQUt0WVlFVGVa?=
 =?gb2312?B?NVkzQk02WXpnQUVQV0Y0N0dzRzhKQzR1UEtlL3dSQUV3cWs1UGU1Uld3ZW13?=
 =?gb2312?B?SDBUSTFkTUg3MVFSNnFOOHpYSlAxamI1MFJpWCszUXZIS2ZKZS9yd1IyUXQ0?=
 =?gb2312?B?WU9yYUpTbVBkOTJ3YVN5UEJ2SjVxV2V2WWdGRHlmYmRrMTlqQ2NvNnBvbHBU?=
 =?gb2312?B?NWlZM1pDWHErclpLYmlPVE9QMnNLOVdCTXlmR0VLQXh0c0hVUVh4S3Y4M2ZI?=
 =?gb2312?B?NlpRbEdjME5uU2hhMnYxZmplNkQ1WXVKemxUcEhLUjhBZStuUGtzQkY5dzkv?=
 =?gb2312?B?ckx0WnlUdlk3Q1FFanNjRktoZEpBL0NlaFdjQmpwSVBvbEtqNTJZNE5lZExo?=
 =?gb2312?B?MDBvYnczZERKTElCS09Qc2cvTVViSnRKS2tYaWZOTzZMZzNzNDVnR2ovREpS?=
 =?gb2312?B?M3Fvcm5zb3pRNTBGNDFRemJwYXgvUlRFV0hPRHp4cjVEZHJFR3BkUU1pdGxZ?=
 =?gb2312?B?ZVQxdHZHZEJlbVg5U3d0Vk8rMkszNmFPQlBrQTNxc0pLUjRIUzhodmh1czNP?=
 =?gb2312?B?NURFa2xHcW1BQkVlSTFoSDFYSWJ3KzA4bHV6R3p5RVBjRkJ6N0FCT2s5b1dQ?=
 =?gb2312?B?RlJmS2xQM3hxV1l3SkZaLzVPbzVielB3MDdkSHVEN0t6MjVIdGxQVStQTTVH?=
 =?gb2312?B?SWFiOTNOQ0xYSU1PSDhzU2M2Z29XM0c0cEE5aDNCeHpXUjc2c1FRMklmM1F2?=
 =?gb2312?B?TGVzMGRsUjg3NzJaYUo5UTJIQUlmTjhCYlJYSVFjeGlwUFpxeklSb2lvbmJE?=
 =?gb2312?B?WmNvV3F4M0dTVWJlR1ZvSGZxSkpCa0lEMDA1ckJIN1JubmFIaUhnZDI4aEIv?=
 =?gb2312?B?RkFFUVlTRGsxbERJZGhaZkpEM3dqdjZ2RzVoaFVlcGN4YXFsdm9nWmVvVEgv?=
 =?gb2312?B?cUVISGJDUE1jY3htank2MlFuM1hoSWQyejVvd3VWRWptRU8xOG9qVDYzeGNp?=
 =?gb2312?B?dmtQU2p5aWhBVU0rSzA3UXZYdlJjalNlbTVnbWI3NGpUVE1qWnZIZ2RMMkw3?=
 =?gb2312?B?cjQyUUZ2ZXNCcnpsVjRCYmNPSXhZZThucjczSUJZVUl6M20vSitiaFhEY3A0?=
 =?gb2312?B?dlRWVlB0VUhtYW1pci91R2I5YnRtSnFVZ1UrQ3BwMENqOW80UTlUNnd4WVUx?=
 =?gb2312?B?U3dVZUxxRk9GSnRpMmcvUGIzQitzZi8velBmQUlwWXhvcmJGdTdGMzQ1QWNL?=
 =?gb2312?Q?D6pw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b49bbe6e-395f-4c66-be94-08db7e1d5aa8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 12:34:34.2783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QXvo9XkYgtteiIsDud7PInax4Qsx5TKN3nl66GbOa74CzMpPQMQnTBADoZYxciwBzY/JoLNZMhbI39I1MRMr2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5558
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

SGkNClNvcnJ5LCBJIHJlc3VibWl0dGVkLCBidXQgZm9yZ290IGFib3V0IHlvdXIgcG9pbnQuIERv
ZXMgdGhpcyBhZmZlY3QgcGF0Y2g/DQoNCi0tLS0t08q8/tStvP4tLS0tLQ0Kt6K8/sjLOiBMZW9u
IFJvbWFub3Zza3kgPGxlb25Aa2VybmVsLm9yZz4gDQq3osvNyrG85DogMjAyM8TqN9TCNsjVIDM6
MTANCsrVvP7IyzogzfXD9y3I7bz+tdey47y8yvWyvyA8bWFjaGVsQHZpdm8uY29tPg0Ks63LzTog
U3VuaWwgR291dGhhbSA8c2dvdXRoYW1AbWFydmVsbC5jb20+OyBEYXZpZCBTLiBNaWxsZXIgPGRh
dmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+OyBK
YWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRo
YXQuY29tPjsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBuZXRkZXZAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBvcGVuc291cmNlLmtl
cm5lbCA8b3BlbnNvdXJjZS5rZXJuZWxAdml2by5jb20+DQrW98ziOiBSZTogW1BBVENIIG5ldCB2
Ml0gbmV0OnRodW5kZXJ4OkZpeCByZXNvdXJjZSBsZWFrcyBpbiBkZXZpY2VfZm9yX2VhY2hfY2hp
bGRfbm9kZSgpIGxvb3BzDQoNCltTb21lIHBlb3BsZSB3aG8gcmVjZWl2ZWQgdGhpcyBtZXNzYWdl
IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIGxlb25Aa2VybmVsLm9yZy4gTGVhcm4gd2h5IHRo
aXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlm
aWNhdGlvbiBdDQoNCk9uIFdlZCwgSnVsIDA1LCAyMDIzIGF0IDEwOjM0OjU2UE0gKzA4MDAsIFdh
bmcgTWluZyB3cm90ZToNCj4gVGhlIGRldmljZV9mb3JfZWFjaF9jaGlsZF9ub2RlKCkgbG9vcCBp
bg0KPiBiZ3hfaW5pdF9vZl9waHkoKSBmdW5jdGlvbiBzaG91bGQgaGF2ZQ0KPiB3bm9kZV9oYW5k
bGVfcHV0KCkgYmVmb3JlIGJyZWFrDQo+IHdoaWNoIGNvdWxkIGF2b2lkIHJlc291cmNlIGxlYWtz
Lg0KPiBUaGlzIHBhdGNoIGNvdWxkIGZpeCB0aGlzIGJ1Zy4NCg0KSXQgaXMgdmVyeSBzdHJhbmdl
IHR5cG9ncmFwaGljLiBZb3UgaGF2ZSB+ODAgY2hhcnMgcGVyLWxpbmUsIHdoaWxlIHlvdXIgbG9u
Z2VzdCBsaW5lIGlzIDQwIGNoYXJzIG9ubHkuDQoNCj4NCj4gU2lnbmVkLW9mZi1ieTogV2FuZyBN
aW5nIDxtYWNoZWxAdml2by5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvY2F2
aXVtL3RodW5kZXIvdGh1bmRlcl9iZ3guYyB8IDUgKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bmV0L2V0aGVybmV0L2Nhdml1bS90aHVuZGVyL3RodW5kZXJfYmd4LmMgDQo+IGIvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvY2F2aXVtL3RodW5kZXIvdGh1bmRlcl9iZ3guYw0KPiBpbmRleCBhMzE3ZmVi
OGRlY2IuLmRhZDMyZDM2YTAxNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQv
Y2F2aXVtL3RodW5kZXIvdGh1bmRlcl9iZ3guYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5l
dC9jYXZpdW0vdGh1bmRlci90aHVuZGVyX2JneC5jDQo+IEBAIC0xNDc4LDggKzE0NzgsMTAgQEAg
c3RhdGljIGludCBiZ3hfaW5pdF9vZl9waHkoc3RydWN0IGJneCAqYmd4KQ0KPiAgICAgICAgICAg
ICAgICAqIGNhbm5vdCBoYW5kbGUgaXQsIHNvIGV4aXQgdGhlIGxvb3AuDQo+ICAgICAgICAgICAg
ICAgICovDQo+ICAgICAgICAgICAgICAgbm9kZSA9IHRvX29mX25vZGUoZnduKTsNCj4gLSAgICAg
ICAgICAgICBpZiAoIW5vZGUpDQo+ICsgICAgICAgICAgICAgaWYgKCFub2RlKSB7DQo+ICsgICAg
ICAgICAgICAgICAgICAgICBmd25vZGVfaGFuZGxlX3B1dChmd24pOw0KPiAgICAgICAgICAgICAg
ICAgICAgICAgYnJlYWs7DQo+ICsgICAgICAgICAgICAgfQ0KPg0KPiAgICAgICAgICAgICAgIG9m
X2dldF9tYWNfYWRkcmVzcyhub2RlLCBiZ3gtPmxtYWNbbG1hY10ubWFjKTsNCj4NCj4gQEAgLTE1
MDMsNiArMTUwNSw3IEBAIHN0YXRpYyBpbnQgYmd4X2luaXRfb2ZfcGh5KHN0cnVjdCBiZ3ggKmJn
eCkNCj4gICAgICAgICAgICAgICBsbWFjKys7DQo+ICAgICAgICAgICAgICAgaWYgKGxtYWMgPT0g
Ymd4LT5tYXhfbG1hYykgew0KPiAgICAgICAgICAgICAgICAgICAgICAgb2Zfbm9kZV9wdXQobm9k
ZSk7DQo+ICsgICAgICAgICAgICAgICAgICAgICBmd25vZGVfaGFuZGxlX3B1dChmd24pOw0KPiAg
ICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ICAgICAgICAgICAgICAgfQ0KPiAgICAgICB9
DQo+IC0tDQo+IDIuMjUuMQ0KPg0KPg0K

