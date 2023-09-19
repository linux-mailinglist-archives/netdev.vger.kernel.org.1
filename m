Return-Path: <netdev+bounces-34894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA717A5BE1
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 10:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A09F1C20B7F
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 08:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31DF38DC6;
	Tue, 19 Sep 2023 08:04:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1521FA9
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 08:04:23 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2122.outbound.protection.outlook.com [40.107.104.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF6012A
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 01:04:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cd5ZL0yDP5cpRdU65Buy9hA6JunJ0x13rnUDBGIz/x3MNQX1aB+t3SsZ4dj76UOm7NiHaM5Pswt8Dyy6SZalIY+PE0de6vlN9SPvaLQQOGYGM1J4V+Vvw7Cl8NTdcnmLe2ek/NUIlbIxk/wX52WlGCDljrTKdDeH5KayYCKNnmvZkMtRx0NXyGKrJbgOm+pXu5c7Nf/dLNfE1f4JlQaVldQgfRJA3Go0fuhL6sXQEyJ1B3uyQ1YydwRj57EQWXQHtkPKOrVYDWjV5fY8dUs1/usOsXtB5YK390f+CSWjIAyfBodrUOP4vuY6AYo4SZduTHtEfYMksrCQQYN5VwDngQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcFbqCUl92daJebUnQlTPlE1l5tLyyX9c8me4XB3HYw=;
 b=fR6IvYaJO+pWiL7cqouhdytwbsmQQEFAfoRz5BJEw/YjnMcCz7wr6dKAT96vpnqdSjAZQkacofQZ0jwzS3FS5ZlS1hVtgBJWQnSmfjsqyM8j35buN5wlODAxNJbSRx6wPpb3oxcc5h7wrIuZnL7giKwRdKorVcZiF7luj69bzCGB2P5HY/Lj7CdukKcbetiwgir6vPlBnQDPhQqY+Esli15j2W78hZz3iycaDohfZBbk2idA8JRPFGtfLXMdOEyuK0uH2LLS6ju7doYdlWlLvwon/wi23ThPoF6Q6VupLtWcrVMqJ1hcgplUROEqn0HpRk4TSdd2oZ3faX6ECNzfyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcFbqCUl92daJebUnQlTPlE1l5tLyyX9c8me4XB3HYw=;
 b=a8H0BF5xrKI7L56zElT29ZvgwyQJTgYu6TiZ/W3ugRn0kZmP74Zls0goD96HzADUENcgbGYc5GTs3tXBwMxtpjPaNSjeu7/jGaVi0x/Pa0NlPURJWAAL+1tau2+ltg/oCWvMKyuMXefN52WHBZiSpC/PNwb+q6nO9Q9PX9CVLNA=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by DB8PR03MB6250.eurprd03.prod.outlook.com (2603:10a6:10:136::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 08:04:19 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::620a:c21c:f077:8069]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::620a:c21c:f077:8069%5]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 08:04:19 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
CC: Linus Walleij <linus.walleij@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>
Subject: Re: [PATCH net-next 7/9] net: dsa: realtek: Convert to platform
 remove callback returning void
Thread-Topic: [PATCH net-next 7/9] net: dsa: realtek: Convert to platform
 remove callback returning void
Thread-Index: AQHZ6mULkE+jwU1pM0GYpJj+6Apmw7AhyvuA
Date: Tue, 19 Sep 2023 08:04:18 +0000
Message-ID: <qnaqcauq3n6364hhet2dwrenb6s2jstwjxv7hlv5u6muvn3vf4@pu4pa5g4vrmw>
References: <20230918191916.1299418-1-u.kleine-koenig@pengutronix.de>
 <20230918191916.1299418-8-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230918191916.1299418-8-u.kleine-koenig@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|DB8PR03MB6250:EE_
x-ms-office365-filtering-correlation-id: 8bb43aff-f10e-4071-281f-08dbb8e706a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rZV5urY358R3Br0qwB0WKMPe5le3WbikwhP9ew6XSTzW1gock7MiDz9D7gYTZk6dSw26hWw6tvG7NvD/oLvy1HRmNx9ITsOfcjf8FGLjOa5asUdXDowkYTs888Ryg1NCGxecACWMmDGEivZ5PPVBwW8q/TYKkQOpJmSES1owUAVwJqxuaa2U+N0VGyj1jZ/oFhK7wX74x8iTGbGQIJ3USjRoXks9jpwV0ROiirzXvrD/peYzCu4rRWgb3jBots2K4puorF3Os5dqcyEirsHFoikvZAGogK339VyZFGDjaKq0BdEhrlyCzumUGR4h8hsZ1yzrbBiOqnuhuULJmGg4af0OB1H/vbTqayG3vcjEllXzUAYfqE32m+1qfJbu4/A02XoeHmbMHO0J9uI3atiCa/MofM522EF2/KubV+yu3KCfPK7bYW31rHGR57ZTW5p3emrl8rJStwsHdp6w7lruzabYQmXc8+LIvgAFgZkEj6PY5+FzP8KieMXGIBm5vp7zSQImy6EaLRNzCA+FlGYsdiZ+urlWuNrWpguscx3cuhajIccVGA5ZZO391xckPaVHlDCHyts3UX1P7UwmRjP8rbmGGk0UtiwaAEFCFTtbPQF6dRJppylubLBcn3B9bfaJ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39850400004)(366004)(136003)(376002)(346002)(451199024)(1800799009)(186009)(2906002)(7416002)(5660300002)(26005)(66946007)(41300700001)(66556008)(64756008)(66446008)(316002)(6916009)(66476007)(54906003)(76116006)(91956017)(4744005)(478600001)(8936002)(4326008)(8676002)(71200400001)(6506007)(6486002)(6512007)(9686003)(85182001)(85202003)(122000001)(66574015)(33716001)(38100700002)(38070700005)(86362001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q25yNnhVRGZKMzhvRThRL2VKN0xFeWZLSDdQSUhuMktaTnd2cjg5NzV1WjBZ?=
 =?utf-8?B?Q3RtWnNFSTJqV01meXBmZndtVzR1TGErbW1FeHhzK2xQWDhmcGxzSDBvQXZO?=
 =?utf-8?B?a1h1OS9SNTJrZGdBRHloRzlTNGJ4VmQwZHY2RlBha2phNmpCQXMxS1d5MllU?=
 =?utf-8?B?ZFlHYTdKaG1vakZrVXJPVFhiMitPQW9razJHUkJKamZVYXg2TWIwK3R4bmh6?=
 =?utf-8?B?dVZ4bXhQbytVdEttSERFVVd3dWRNdTVhcnRqaW13UCt5OHpDdlh1TGRXUldT?=
 =?utf-8?B?RUVTUG1CWm1xdEthTmtVem5EeXZNQVhLR3kzMW5hUmNmUmxpbWtUWkZvSVNX?=
 =?utf-8?B?TTdqWlJvUSs0b1lwSC9Cd2ZhK1lRdGNrRisxRGRyblowUjdNNXA1WFp3Rysv?=
 =?utf-8?B?ZWtPOVB0KzdhaWxmaFRLYUxjQTF1aFFyeGQyWWxQd2J6Y25vNWxzYitoSGxR?=
 =?utf-8?B?RmpkYXZTZXNPY2FGdThPNjFhVnljR0ltMmVoQnJmQlBEV0JzbFdLOWZTdXcy?=
 =?utf-8?B?a2Y4aFZsdEZMc21xUGJLZ00yTnhZOEROcnhWMnhPS3RlbDFlRWJQcG43Q3o0?=
 =?utf-8?B?N1ZxcjdIZUF2WStWSEVMNUdaT1BNK0F3K0NZQXdReWF0OU9nVGJkQmhMTHAx?=
 =?utf-8?B?bzdsQ3RJNFQyeEJBbmR5WmdWTFZ0VW1JK2lacm1FeU9rMDFud29UT25QYU9y?=
 =?utf-8?B?bXJwbEpxTUxWMm9yNXVkb1Y4UDJLNkx5ZkVZYXoxNHRrN2cyOGtVNkF6N2la?=
 =?utf-8?B?YnZKdkRBTmI5Skg1OUlyN05ZaFVOR3huREUrVHduUHBoMVZZT01pTUhYM2p4?=
 =?utf-8?B?RDNjV0N6dXA3bmhQb0tMd1NXRlFOQnUzVkRSRG9vb2xQYWFtMjdHU1A5dFNq?=
 =?utf-8?B?UG4zQWs2MmxtK3A5bEppYU54RHNhUG5BTEpWL3psTzdydXhIcjFRaXJMOC9k?=
 =?utf-8?B?UDU5V0drQjJRNGlGU295UTg1TyswQmpSd3hxaUlxaXhJWHV0clZnWWVpMWdY?=
 =?utf-8?B?Rno2ZzdzbUVlUXkwZ3FPNThNQUM3UzEzTmNGejZqajFTNkpPY0ZuNTdCZU10?=
 =?utf-8?B?a1RDMDB6TlRpVmZPMll6UHdlUU9wZkh6dHIwaDg4SFk5UTlkWVlUMi9POHVK?=
 =?utf-8?B?eVZ2YzBtTGN2dm5kK2E1b0JVRFIxeTZqRVJTd1QrV0xIZUFIQjViK1NBbEcz?=
 =?utf-8?B?Qko1dlpKZi9DU09YWjlmckJKbmxYRmQwT05iMXE3bjAwYVlDWWhhdFlQM0xn?=
 =?utf-8?B?ZWN1Wkh2aVlMUEN1b2crbVgrRythWWRJODN3K1h6Z3dBaHBWNm9tWEZqOEtF?=
 =?utf-8?B?MndtUGwydnU0MHZIaUtLSVlCRXo3U253dnJHTlB4clRPOVRPbGJvSHcxMkpi?=
 =?utf-8?B?YUdnVXZKa21WUTVlcXNSTU56Y0NrUGxVbGJRWDJTUmZVSlBHbFd2enVWdGM0?=
 =?utf-8?B?SDQ2a2lPOGwvMCtuQTJmdFcrQ09GYjBkY25rU1M1dXhOQnY3L1JYZlZNYUw1?=
 =?utf-8?B?N2k2cTJZRVFHUHo3NUJCV3RQa1ZjTG92cTJMTTIrTGtETkZDVHJHcEZpNDFu?=
 =?utf-8?B?UHlhL0puT3RoRUZ1dmdkTGR0Tk1RR1IraW1uUGF6MkxUN1dIaVlXSnh2NE9F?=
 =?utf-8?B?bVA4Y0VqemIxQVhBa09lOHRGcXEwRGlxaDBTRDJvdmRsT0xQSm9TVUtwTHNM?=
 =?utf-8?B?dmVSOHZGVW5EMk5ZUHhvR2pYNkU2UmZOR2NEalhHazR4bDhOUW4vdEtzNGkx?=
 =?utf-8?B?UG5NYWtZcTRQU09yMC9FM0U0WTBXT28wVFZ4V3JmeUtDaVJtYmZnbU8zTVpq?=
 =?utf-8?B?V2R6VHVzOW9yTDh5TC9XcmVtOWFGcS83dExhQ2Z0dHRoU29JK3ZJdzUxb2ty?=
 =?utf-8?B?MmlVU2x6UFI0M25VL2o5TVM5bXlMZG5tV21RV2Q1LzNqV1FxbEFqNjZzZUlm?=
 =?utf-8?B?d2gxR0FML1B3VmR0V093dkJkZXpISDZHTDZNdWRBT1pmOHA0aDNrY05maVdL?=
 =?utf-8?B?VHU5QTZOTDhtYjhwcE50K2tYalU2NzdkL2RFcUZ0LzRQeG9mdStudXRJYWZh?=
 =?utf-8?B?USt5dWxNMmlMV21iKzk0RGNmV3RyNXZCS0xXcUVnQjJaYWQzcjJKNFNYdGhR?=
 =?utf-8?B?V0Jtc1hmdktuVzFTVGRmQ1A1NXJRNVRhY09qVXJtN0drTm94Z2xmTFQ3a28x?=
 =?utf-8?B?bUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8AD998684DE634FA8E3EAA6E70900BC@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB3943.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb43aff-f10e-4071-281f-08dbb8e706a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 08:04:19.0823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bTYWImX0OL1DJNEr6V0Sb8C082PEsknpkAApwZT1isEo69bLA+YX6sd29h+ZcAlJG5eLVsIaFIvl9ZJEREYf+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB6250
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

T24gTW9uLCBTZXAgMTgsIDIwMjMgYXQgMDk6MTk6MTRQTSArMDIwMCwgVXdlIEtsZWluZS1Lw7Zu
aWcgd3JvdGU6DQo+IFRoZSAucmVtb3ZlKCkgY2FsbGJhY2sgZm9yIGEgcGxhdGZvcm0gZHJpdmVy
IHJldHVybnMgYW4gaW50IHdoaWNoIG1ha2VzDQo+IG1hbnkgZHJpdmVyIGF1dGhvcnMgd3Jvbmds
eSBhc3N1bWUgaXQncyBwb3NzaWJsZSB0byBkbyBlcnJvciBoYW5kbGluZyBieQ0KPiByZXR1cm5p
bmcgYW4gZXJyb3IgY29kZS4gSG93ZXZlciB0aGUgdmFsdWUgcmV0dXJuZWQgaXMgaWdub3JlZCAo
YXBhcnQNCj4gZnJvbSBlbWl0dGluZyBhIHdhcm5pbmcpIGFuZCB0aGlzIHR5cGljYWxseSByZXN1
bHRzIGluIHJlc291cmNlIGxlYWtzLg0KPiBUbyBpbXByb3ZlIGhlcmUgdGhlcmUgaXMgYSBxdWVz
dCB0byBtYWtlIHRoZSByZW1vdmUgY2FsbGJhY2sgcmV0dXJuDQo+IHZvaWQuIEluIHRoZSBmaXJz
dCBzdGVwIG9mIHRoaXMgcXVlc3QgYWxsIGRyaXZlcnMgYXJlIGNvbnZlcnRlZCB0bw0KPiAucmVt
b3ZlX25ldygpIHdoaWNoIGFscmVhZHkgcmV0dXJucyB2b2lkLiBFdmVudHVhbGx5IGFmdGVyIGFs
bCBkcml2ZXJzDQo+IGFyZSBjb252ZXJ0ZWQsIC5yZW1vdmVfbmV3KCkgaXMgcmVuYW1lZCB0byAu
cmVtb3ZlKCkuDQo+IA0KPiBUcml2aWFsbHkgY29udmVydCB0aGlzIGRyaXZlciBmcm9tIGFsd2F5
cyByZXR1cm5pbmcgemVybyBpbiB0aGUgcmVtb3ZlDQo+IGNhbGxiYWNrIHRvIHRoZSB2b2lkIHJl
dHVybmluZyB2YXJpYW50Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcg
PHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4NCj4gLS0tDQoNClJldmlld2VkLWJ5OiBB
bHZpbiDFoGlwcmFnYSA8YWxzaUBiYW5nLW9sdWZzZW4uZGs+

