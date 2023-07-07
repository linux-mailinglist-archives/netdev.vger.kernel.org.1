Return-Path: <netdev+bounces-16005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 139C574AEB2
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 12:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A44F281723
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 10:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26336BE69;
	Fri,  7 Jul 2023 10:25:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B25BE5A
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 10:25:52 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2125.outbound.protection.outlook.com [40.107.14.125])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABC7128
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 03:25:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmpEAeWtljqOig4vc6ym1O/Eo4QE+exU14f2NaN183z0W2QljZz35MiqXiaO3R6cuJKry8v18voDzZPYeEuJpA3q7QezbJsKiMHKqzDduS9apK7RnDOUQAqlDwU03A3Stjd4GkyIYZgRvqGtF8O8n09lO1Plon2VUrJlQjmE9vBYVX55qWhmiegDCEHCZYsCKqxp7KnMCHWI6r2GUA1ocPLb/AZBd7/3QklYXXjNBg8nFVgWjmE7FGLNyU8ZJvu4srcyOpbFucBp+C4MUZx20N/RX595ffuGVmPKe7xjkVJkMABEgOppvMs5frXijsgwIx1l6V6jqNz56HCMChjvsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=teoVn7Olpc+W+IJTjcwIyxS/a44sDoQToQY5JPFg9ic=;
 b=bNSupwwjtCQeEUZjmyfS1Ww0rD1117i0Sga/9TwLg3ax2+2/JtUlqi52b2mj4SdjloFbaJz3E62XY9x7cKPhmmCTKInM7df1heM7+0q6YbAOs5fwC786YGCXNKEJJGuonOivx+77OXemd2cRDVtqNPm90U8MxkmxMEb4toP7ua0P9kJ2C612eb1yWfYq08TPdF9KEQJhxmeZ/K2ld9VdiNGhfb0rsWK1J5qk9FS4TYcjUuliPsZT1O4Mzg0yZI7Md2gT8U2jZEeJIi9jpd9LsG7z57kUysj5yrTjFGH8ldoGXXvRVp+jVv6NduGUwa+0DNNpY/dfwPe9haKaLL/7cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dektech.com.au; dmarc=pass action=none
 header.from=dektech.com.au; dkim=pass header.d=dektech.com.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dektech.com.au;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=teoVn7Olpc+W+IJTjcwIyxS/a44sDoQToQY5JPFg9ic=;
 b=FREfCKF3apa2HeeIP/PtrrpEBdw4h/6wWNz3mgPrHm1mihtu91T+VGkQ9pMPvTtoMIcL9PHc+A0EsdOvWZtQQSXEJL6LMinKOFNVbnmOVYRbHBe/c+06c6ZSaXVAltjDn7pW4tyOh/mXAsGxiIO7/C7HN0BeNI/UGQQrTtCDmPA=
Received: from DB9PR05MB9078.eurprd05.prod.outlook.com (2603:10a6:10:36a::7)
 by PAWPR05MB10735.eurprd05.prod.outlook.com (2603:10a6:102:366::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 10:25:44 +0000
Received: from DB9PR05MB9078.eurprd05.prod.outlook.com
 ([fe80::e2bd:186:9dfe:1fc3]) by DB9PR05MB9078.eurprd05.prod.outlook.com
 ([fe80::e2bd:186:9dfe:1fc3%7]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 10:25:44 +0000
From: Tung Quang Nguyen <tung.q.nguyen@dektech.com.au>
To: =?utf-8?B?546L5piOLei9r+S7tuW6leWxguaKgOacr+mDqA==?= <machel@vivo.com>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@linaro.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Jon Maloy <jmaloy@redhat.com>, Paolo Abeni
	<pabeni@redhat.com>, Ying Xue <ying.xue@windriver.com>, Markus Elfring
	<Markus.Elfring@web.de>, Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
	"opensource.kernel@vivo.com" <opensource.kernel@vivo.com>
Subject:
 =?utf-8?B?UkU6IG5ldDogdGlwYzogUmVtb3ZlIHJlcGVhdGVkIOKAnGluaXRpYWxpemF0?=
 =?utf-8?B?aW9u4oCdIGluIHRpcGNfZ3JvdXBfYWRkX3RvX3RyZWUoKQ==?=
Thread-Topic:
 =?utf-8?B?bmV0OiB0aXBjOiBSZW1vdmUgcmVwZWF0ZWQg4oCcaW5pdGlhbGl6YXRpb24=?=
 =?utf-8?B?4oCdIGluIHRpcGNfZ3JvdXBfYWRkX3RvX3RyZWUoKQ==?=
Thread-Index: AQHZsJ5ohQVoT0JekUGd1UBvwf3Q76+uGGNg
Date: Fri, 7 Jul 2023 10:25:44 +0000
Message-ID:
 <DB9PR05MB9078EB4E9C1DA0C69182D80E882DA@DB9PR05MB9078.eurprd05.prod.outlook.com>
References: <0d8a89fb-b1ef-9a15-8731-4160b1287e14@wanadoo.fr>
 <4aed7411-a567-c6dd-3ff1-3622b7eb7369@web.de>
In-Reply-To: <4aed7411-a567-c6dd-3ff1-3622b7eb7369@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dektech.com.au;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR05MB9078:EE_|PAWPR05MB10735:EE_
x-ms-office365-filtering-correlation-id: 31ef6d1e-5a19-43cb-5e37-08db7ed485cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 2s2SiOhEA29f0W3OkcLUgKpyCdfQEDjVJD6Ocrdlb5Vx3JZM2Rf588T578Mcj9V2VAHYD/Bmt8lGgoYCY3Ng9+m78P55spk9JO5wrjk23Xz90gJoZwNsEuI0IQf7E8qmtDGHWxVoqeWum6lJsmZMMdpExihJk2Wx4WYvn63dttnEe4QiHXvxfvb/x6FtGbO/U7GXUoUyd/lum1ee7nGcscb8NE6MN/VMzmYBEzjvvaEh2k5sOTiRo6lcRRUj921MT3TgSXTv5q/E5uukOthPUMuW9/h7vZCQc2TPs/mEijBvB3IghuiO+QNNYHWo+6w0Vocx/JyAv87LGaFVvW/hN57lOyr2FFs7N9DyzFJEEe8xAx+KUTBIODgOk3vyE+ZzBDAXto91Xa8ReKuOS66lkyoVClrMciMNYC4Dj4BroGdLj3iABTgNZxlaaV7bL2KVFUOOisA8hCNk5V/ZQUBWh7mC/SxgdtfzlEnRibnr4R4/bBmeWpcDWGhJqh6NOhQWnu0M6YfXlrvQ7m8O4/9NQE39FFxEj8Rtbplm9xbgu39oFN8u3kvZhKAaXwrS+w8dPq2sOB6yphKjn8qzSOcVgrUvWinjRZHo8D+G3V4/HjFd9ZS1eCsdlObcrYP2a7sU
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR05MB9078.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(39840400004)(396003)(376002)(451199021)(122000001)(38100700002)(86362001)(38070700005)(33656002)(55016003)(8936002)(41300700001)(9686003)(52536014)(26005)(5660300002)(71200400001)(7416002)(6506007)(186003)(4744005)(2906002)(316002)(66946007)(76116006)(478600001)(7696005)(110136005)(54906003)(66446008)(66556008)(4326008)(66476007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VXdvSWFDMXJScHRCMmc5NWpMTFB0SXp6eTEwUmZKVHRvM29kKy9LTzFabGdo?=
 =?utf-8?B?YnpZWVFVVTlVcSt0MGFZaHlObVhCSExWRFFLUytuSG1HR1ZWaGJWWHliOU9o?=
 =?utf-8?B?RnRpTm93cUJtNTFqMzFqK0RGd0hxVkJsdkJRVGZIbkI3MHE0dE5QOExydUIz?=
 =?utf-8?B?MG1DRFJBcXRlWmMwVU9paWY3MTFYU0d6Q2l6L3FOLzFCRFNBelZNNzF0dVZ5?=
 =?utf-8?B?UDVKNzBza1FwYlI1ZVJpNXEwU1dIdVZ3RVFFWkFCdjd4alQrdmYzQUhTRHhD?=
 =?utf-8?B?SG1ITFZCSWFINXp0WG01TmRxWXpNK1BuMDJnK3FVM2dleDZuQTNKenJEeTRn?=
 =?utf-8?B?VjJqOU9PbU9JelJ3TlFqRmVia1VhV09nYjYyZ1BSS1I3SHlDRCtPeUM4Mm5J?=
 =?utf-8?B?S0N3dUtBemFzMGR5STJQTU9yK3VmclJ0L0trei94UEVvZ050RTlXVXk1a0lv?=
 =?utf-8?B?aVBzRmNtRDgvREk0eS9UWEpybHJIR0dYVDY2N1VraFVlZytlaTQ2ZXE4dy9I?=
 =?utf-8?B?R0RGV0tOMGxyZEVSOFNVOVJuZ1BvMStMWG9pL1V2Ni9tTXJET3pEaVl0QWFr?=
 =?utf-8?B?WXJqYkJnWTRDSVlKOWVuWC9CQ2pIL0VpZzdLZVVlRFhyUHp3V1lYd2ZiVVBZ?=
 =?utf-8?B?dTgxRkxsckliRzh1M3h3eFg5aGJLRzVvVmtHK1BmOEM2TWZETkxmeC9KOTlC?=
 =?utf-8?B?SDJHbUZId0ZPOFV0eSsycW5rRUlCRjlLMjNzeFlkVEwxRlY1WnhQektBVVBj?=
 =?utf-8?B?RkdtOUJKeTBGL0tLMDI0VnQ2OHhwbDNydzU4dkVQMkJsNFZ6VUNWTktCV0RL?=
 =?utf-8?B?NzF3ZklUZG4rVllNd2hzbUl2U3RMQzE0dUw4QTFnUTZEVTJQRWtDZEpqUkVv?=
 =?utf-8?B?TmVvZXd2WE1wVWZsTHpMd2tqM3ppVjRBeXU3Zmk0eVdFMGZ0aVpEdEpZUllX?=
 =?utf-8?B?Z0RNTTMvWmtvbGxxMmd6emQ4Mis0emJ2SmVKR0VRdk5ydGh0MGhVUUFkR1Yv?=
 =?utf-8?B?MGd3NTdMRnRyUE9mQ1VPZFlFR3JkWXQ1azlKV1NtT3lRdVB2L2xRcWE5RFY2?=
 =?utf-8?B?SU1JUEFPOU9zeDF6WVdVN3RDRHFyMmVvWGQ4ZkZ2dkFkUU9BdGtsUitZRFd0?=
 =?utf-8?B?eHlqSU5TU2U2NmhaYWZiT0U2WUJEWHpRWmVqM25VWmlGZGhKZm1OeHl3RWRC?=
 =?utf-8?B?SE1RdHhQaWVNaXc3QVErbisxU09OVTRBNEhZWjJpV0JCdEplWGc3RmM1dU4w?=
 =?utf-8?B?VWoxYjNZN3RRZTM4VjVMMm1tdlMreCtUc2o1allyUkNJWTM0V3RQQzh2ZHpO?=
 =?utf-8?B?RHFxSitwckZpMjVQcURzTHRBY1prUlM1QU51dTlmS01qdmpQUUZxd3B0SHZR?=
 =?utf-8?B?ZXp5N0sxVjEzc2tkVlIxQVdCZlVPT202b1QvRkZ1c2ZCeUVJWEJPSmpVRGZs?=
 =?utf-8?B?cU5LQnZVTlBZUjZNMWRkNUJRb29OQXhSWlVnSk9FcG1PbFpSU2hFVEtEQUkv?=
 =?utf-8?B?Sk5KLzdmUUl4MnMwZmhKU2ovZExRRnFmYjRJaEYzeU9lYzBpRytmNVZ2YzM5?=
 =?utf-8?B?Sjg2ZkVqUzFUckY4WmZxLzZsemVwNC9Ib29Gak1CMHdGanF4dzFHVE4rWm1n?=
 =?utf-8?B?QldLOEtiWkFFYjR0d0RZenpCbjRITVlPY3RXbVpicnQ0R3JpaTRrTXBqTlVZ?=
 =?utf-8?B?dE1UdzQwM2pjY0daSjNsYmRRQTIvNWNHZHQydnovWURLUXFHeDVHL1hIaThk?=
 =?utf-8?B?RmNaMDVDbjhwSFhlNTlTWEl4OUN0N2VMeDRCaEZGclFjc2xJTTFTMjFGcTM5?=
 =?utf-8?B?eTh1QjhVTjArSDlGMUdqbkRjRDhybFBaUVNLdWNod3dLaytiUjZmUW84K2dq?=
 =?utf-8?B?aUFhNHBZR3F0RS83QXZ2b2lVTWJRdzRzQ0Q4dW1zTDV0ZGtnRE5yY3JsOEJ0?=
 =?utf-8?B?RnpmcG1tTEJhUFBmTnVzYUNpZEJ1OXpsWHl4WW4rZjlCeDVqcTVBUkVVdWo5?=
 =?utf-8?B?R0o2N1hmb29ZVVBqaURmamxpcWJkWTZXaUlWem9jdWtoN3NSVkoxZTk4bjZv?=
 =?utf-8?B?S1h2MVN6VDdYUWs1NXhKMlVxN0dZSWRRQ1Vwc3Jtb1BlOGZRUDZNS0RvdzRT?=
 =?utf-8?B?bjlMZHZsNEZLVVJyK0JNbzFiMDdaWWoxRHhLMDJ3Zk9ZQ3kzaHYrUmU2QnBk?=
 =?utf-8?B?Q0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: dektech.com.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR05MB9078.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ef6d1e-5a19-43cb-5e37-08db7ed485cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 10:25:44.5833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1957ea50-0dd8-4360-8db0-c9530df996b2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lLn/3RI3Z2McjWeIQXNK9HV40NunN5S/TRXHu6XgFkQpI8oCtXgv/l9CEIpTW+85iN98uu1EoOdPxNvzWGzt0SKE3UoYccet+rKn4RpMK/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR05MB10735
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PiAtICAgICAgICAgICAgICAgcGFyZW50ID0gKm47DQo+IC0gICAgICAgICAgICAgICB0bXAgPSBj
b250YWluZXJfb2YocGFyZW50LCBzdHJ1Y3QgdGlwY19tZW1iZXIsIHRyZWVfbm9kZSk7DQo+ICAg
ICAgICAgICAgICAgICBua2V5ID0gKHU2NCl0bXAtPm5vZGUgPDwgMzIgfCB0bXAtPnBvcnQ7DQo+
ICAgICAgICAgICAgICAgICBpZiAoa2V5IDwgbmtleSkNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgbiA9ICYoKm4pLT5yYl9sZWZ0Ow0KW1JFU0VORF0NCllvdXIgcGF0Y2ggYnJlYWtzIG15IHRl
c3Qgc3VpdGUuIFlvdSBpbnRyb2R1Y2VkIGEgbmV3IGJ1ZyB3aGljaCB3YXMgcG9pbnRlZCBvdXQg
YnkgQ2hyaXN0b3BoZS4NCkl0IGlzIGEgcmVkdW5kYW50IGFzc2lnbm1lbnQgdG8gdmFyaWFibGUg
dG1wIGFzIHlvdSBwb2ludGVkIG91dC4NCkkgc3VnZ2VzdCB0aGF0IHlvdSByZXBvc3QgdGhpcyBj
bGVhbnVwIHRvZ2V0aGVyIHdpdGggb3RoZXIgcGF0Y2hlcyB0aGF0IHlvdSBzZWUgbmVlZCB0byBi
ZSByZWZhY3RvcmVkIChJIGJlbGlldmUgdGhlcmUgYXJlIHN0aWxsIG1hbnkgdGhpbmdzIGxpa2Ug
dGhpcyBpbiBUSVBDKSBpbiB0aGUgZnV0dXJlLCBvciBJIGNhbiBkbyB3aGF0IHlvdSBzdWdnZXN0
ZWQgaW4gbXkgZnV0dXJlIGNsZWFudXAuDQo=

