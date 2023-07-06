Return-Path: <netdev+bounces-15694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC252749445
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 05:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B33A81C20C94
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 03:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FA8EA2;
	Thu,  6 Jul 2023 03:34:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F12FA5A
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 03:34:36 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2112.outbound.protection.outlook.com [40.107.255.112])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027F61BCA;
	Wed,  5 Jul 2023 20:34:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWT+aTRNUzciXAtpe7T/NsTSa4ConvhVNh7Z2UnsM7Xr/fCbKswPpDadM6NsLxGeeoVOkeUcwiHw/PRdMlL/298+LUMPzjleHQjOBPzA+VnCggR2KFAh1M9nN/Sni/DJ98qDAOLUWgcUgY2N6V9E3ARWstRdQHS5TonaWRVqhlKSWgwXCrnSSwpM/Xh0+sg0IVhvhOgfv7yccJBIdvDrj6Nnx9h6LUinK87YCfOiEUnXHA3AXF4wYKPAJqdR28ree+EmQipaR/2SfQYP0Jy/5Cdxu1fxiGrafFslgIsm/R8TDxxtYUnrhZ2enkdNSw0inVeXIAd+9oc09cy50uv0/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UojcrpuJVAsFl4PxIL2GMEGUiyGyhXEC9G633IhZBoY=;
 b=LZb1+0sl64AX5UNGFzZl3O5IcrUFzPjSgWFqx7b8p1v1QBrdAUP31xv7MaTdGoSxMstdogfDDnODyvcKSHPwtl2iGYhqr6HmpQlcrjoQUnyn1XX23wBFNfmqyfXwpgdwJApvx9HxkijQRumUHJ6yBrbQf/9WgddMcsaB2u6Cf1+KtITJnbs+Vwe1ONkW9OmH7WWarZtl85huDLB17Ojxb3VKx+BYRSA7ptvIbqLq6d1YV4cUVhdIbESU11wo2QZ1eCiu2OY4nMVqbX2Yh363D/8DzC5DrWAawaR6+zlPV39jhKYdirU9LQ8gMtHuLvnVXRbPSwAxalWNZd4/cE7vfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UojcrpuJVAsFl4PxIL2GMEGUiyGyhXEC9G633IhZBoY=;
 b=hnKitoP4FZb3baWNZa0jb30bVJe3O0D/AyZKYwqPji6xYABimyRwZmnGAC1ftF9qaE6GqQLgIQ7UNft1zJAkX4PqVKaQsuDEz/F+qQrE9igRhA/kwg3po3LFuipcgzs+BzsTwZC+MCC9elUpl5MrT2OWwXLRP9buLSxA9gML8vTpIOt5uI9N/MLWUOGoY0sP7KMZOt1Gq875XLWMK3NQT98Peza/UHH5fxoO1j8hj57KLf8ImXwMbdzPJ/krHv3EWSkkEjO6sSC1GmpZCB9oyGXrkLRpOKLlqUfOws5yJdnbRFi9gF1SwXMTyfEfvZrbrb2Bct3hifzH0tLtmRH8Kw==
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 SI2PR06MB5042.apcprd06.prod.outlook.com (2603:1096:4:1a5::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.17; Thu, 6 Jul 2023 03:34:29 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 03:34:29 +0000
From: =?utf-8?B?546L5piOLei9r+S7tuW6leWxguaKgOacr+mDqA==?= <machel@vivo.com>
To: Markus Elfring <Markus.Elfring@web.de>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Sunil Goutham
	<sgoutham@marvell.com>, opensource.kernel <opensource.kernel@vivo.com>, LKML
	<linux-kernel@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggbmV0IHYyXSBuZXQ6IHRodW5kZXJ4OiBGaXggcmVz?=
 =?utf-8?B?b3VyY2UgbGVha3MgaW4gYSBkZXZpY2VfZm9yX2VhY2hfY2hpbGRfbm9kZSgp?=
 =?utf-8?Q?_loop?=
Thread-Topic: [PATCH net v2] net: thunderx: Fix resource leaks in a
 device_for_each_child_node() loop
Thread-Index: AQHZr3eIwC9dtRKByUWOQZR3KpvU3K+sFTJA
Date: Thu, 6 Jul 2023 03:34:29 +0000
Message-ID:
 <SG2PR06MB374317EA994C668A699A9CB0BD2CA@SG2PR06MB3743.apcprd06.prod.outlook.com>
References: <20230705143507.4120-1-machel@vivo.com>
 <5e126b18-1b9a-4224-5e02-9ab349e624d9@web.de>
In-Reply-To: <5e126b18-1b9a-4224-5e02-9ab349e624d9@web.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3743:EE_|SI2PR06MB5042:EE_
x-ms-office365-filtering-correlation-id: aa9ba36d-0b64-4bf3-3a60-08db7dd1e80d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 8554jmyn/gGyLjrgOOVqncvCAIput4q8cLBjwH/VwWh2F1i/gJLutXJ8gX7sTw+d9Oe4Ax1H51JnTY0+7/lk8srj0TU+J9owhgQYgHyjlI5phZlymJ+du0D5K04KXgpN7w1mRofBqupnnfBrWoqTWcT17FBy02eWQjif7I7NyY7+rydTXCxw3rQjChBz388BAXf+ImK4DHwSs5Zv5twwXOi/rAplB0WUrSg6A2qkWpe/1C5jgbdC92DuQjk5NiqsIrhezfjJcGe/dRkAOzPP0QSDqvOjrPayhKk4j/IigPl/JzgS9XzuQt1Q1RvavhmhugX6vDSt3PfRUhHxeMlp3dqBe/xE6iH09wfKVCVzEpt1l7pqRQLPPZrrANGwNLRQQ5hOwsMeUlaaTgvNKGMXWkdBWiBlr5ukXLUWHOHbDX9wD9upTPhaf/Fk4XyvhjKyhnEh1QHFzLZivSBN8/423wry44divjzrfKZzRfniCmKUSPPQZA/0puUghZJ6aRg4ygLHKhXNSMbH+Uc2fjl3dyGRMpDF6ALr8pwI/foisnU18hnK2fbAcjRi0Q2y3U5LpXdq0ZWUVPVYp34kyErFqXGPlyc9fUwt21Q91Nm5fGc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(84040400005)(451199021)(71200400001)(186003)(7696005)(478600001)(6506007)(9686003)(966005)(26005)(33656002)(2906002)(6916009)(85182001)(224303003)(55016003)(64756008)(66476007)(66446008)(76116006)(66946007)(66556008)(4744005)(86362001)(38070700005)(316002)(4326008)(5660300002)(52536014)(7416002)(38100700002)(54906003)(122000001)(41300700001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WVdvWTZqTThEdE1HWFJHT2g3cGdzc0E4OGhaa3RjaEdkY0trVnZEN2JwOHFv?=
 =?utf-8?B?WVMycUNrZTlnNDV6dzU4L0NEVmlZc0tvVTdUallJSlE5QnpJaFEwM2tHMlpR?=
 =?utf-8?B?N2hhOXoweEcyVVhzdlFyOVpNMjB1bnJKTW9EMVE1VTRKR2pxL0pOd0VTeTl1?=
 =?utf-8?B?V1hpcFE4eXh5YU04di9UTDdzc0hiRWFMaWt5dklvWFdVMzhsUitWaGlOZGd3?=
 =?utf-8?B?aVh1dEtvc0V5Z2JjNExkOUNLVTlRS1k3dmhDL3NBcmJJQmxBU1JoRGdCQjRx?=
 =?utf-8?B?bVBaL0I3aXMrcFdNdWNtZXBVWnMyQU9jbmQ1OVF1R2lmdU5DWHl6WURFZUxD?=
 =?utf-8?B?S2hLNU1aei9EU3drZlF4ZjFyYkxWUHQyNmFRdmJHT1RvS3BXUWlubW5ZZ2pN?=
 =?utf-8?B?aGxNVnBPMGpTWUtjOU9oZDhROFpaWWEvVVN4NnB3cElQbmh1QVZEM2lpZnZS?=
 =?utf-8?B?RXVybFRKc1hJcktTcWFGVUZCS05SSU5QNnozUHZQSFVGZEZJcXVhNFV6SEpV?=
 =?utf-8?B?bUo3SGowaUgrdHVjSzFpKzF3a2E3U212MmJ0KzNKSEFhc29JZTA3US9aS0JD?=
 =?utf-8?B?MmNaYnJUZ1p0UVladFExQjQ4UDhsVDZzWGRhVTdSbG9MRjQxNThLVllpR2Jj?=
 =?utf-8?B?ayt6K2Q1eVFRNXI5N2FwNjNVWnoxTzdDbURzUUQ1ODhwRG5MdGR1MmJmY0pO?=
 =?utf-8?B?RGc1MmFrL1I2NXpuNU50MUlDd2JxWjZDQzBIYzM5dzgzVmttd2dhWGt5am1r?=
 =?utf-8?B?bUtyRzg5L2JhSDhaL1cxMkxDbCtVZCtMMTR2MklTZWcwWmtCUllMR296N216?=
 =?utf-8?B?Yk1HUVpkVzZoUEF6Mktkd05BVWJMbHZJVWdlY0NEL21VQlFFZ1JQalVtTjcv?=
 =?utf-8?B?eTVLaGpaMnArSHFDSGJnMVhMS3U5SStHdUFTL3pKSU1SajQrMDkvTFY0Nm90?=
 =?utf-8?B?TnhTT2QxQ2xzZktFeXNQblZwMUJRSEU0K0ZDTzI4bStFc09Nem5qMW5NTTh6?=
 =?utf-8?B?dnA0RWRPMW9VckluWEtsYlBMcjVoVEczbzh2VnlrVWZUVGpkYmVCclQ1Q1V1?=
 =?utf-8?B?dUNrYVJzekU2cVlyTFdtbnNIc3JwRFkvejd2UGNBNXM1TUpuMCt0TnZJL3Rw?=
 =?utf-8?B?b0k4NEZiWUMrczVQM0xFNW1GcTJLaWVUcVd4WVlvNTNtVVE2d1hrL1pxbld0?=
 =?utf-8?B?ZkxmdnZKZGRRSkJoSWJUV1RleTFGUUt3MXU0ZHg5ck5xS0tIRVpObFRpVzd3?=
 =?utf-8?B?eUp5NXkvKzFwWWNQWEJaaDJ0TWtaQytuemk0dHB3MXhWRjJ0d3Bjd2dyTkpk?=
 =?utf-8?B?blBtdnAyRkJYOGpBeThjdUg0WGxneXhKbUhrczk3V3B3Yzg2Z3YzNXZGYytu?=
 =?utf-8?B?WmlBQUlEZXhTTkFXT1FxQ3RQWFdnNnVxaHg1N1prRk8rL0FGZHRXb3BsV0Vi?=
 =?utf-8?B?R21jYnFheDZVVWloK3Rkc2VRS1J2a2prcTA4UkpFNlhZOHl4anNXNk9CV25v?=
 =?utf-8?B?MkxZN0tNbGJKWUk0YUFyK2hpVGp4TUVXOWZQeFhGVW1VazRlYVpVK3VLazdq?=
 =?utf-8?B?ajEyaTdoZlNzV0xnVU92YVk4bWZpeHBLaVdVY1F2bXNiSjlUZndRZTN3NjNu?=
 =?utf-8?B?ZjBCZmRtZDdqZ3p6cGFqMHFhYkxTcVlxemxZNnljaXF4UTFlOTl0cTdrWS9F?=
 =?utf-8?B?TXo4cnFRYldsRUpraXcwcnlTQ3Z5OWlYcW9XWnNueTcrc2N0YmM5T0hLdnlq?=
 =?utf-8?B?K21rNGVMMkdpby9FU0c3YS9ZVStwUDI4T0RlWWg3MmdXV09ndHhtRFBwL3N5?=
 =?utf-8?B?MUQyY3cyKzJidmRMNndHWTRlYkJlWGorZGdjUkZUZlNZV1lNQmNGQTBRL0Z2?=
 =?utf-8?B?U0hLUG82bWRFUkFMbWhDeUYzWGdnYU1oUTdhVFZUaGs0bmp5MmZDQ0dKU0ht?=
 =?utf-8?B?ZlpMNkFTNDFyK3ROZzI3SFIyUXN2NFdaZHhDZkxKTXZHQVJZOWtZUnlpZzQv?=
 =?utf-8?B?bm5wYzVPRmJ3VU9LU3BKeWJpNlB4MkxZNWxOTnduckp4aFNKM2RpMHM5VldV?=
 =?utf-8?B?QXZGRFpMUzYxMUduNlhMTTN0REdveEh6YlBZdm1nQXZKblJSQWJucnd6T3Y5?=
 =?utf-8?Q?JgkE=3D?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aa9ba36d-0b64-4bf3-3a60-08db7dd1e80d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 03:34:29.7797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ggGB6SH9XdoyEbXCA2hHL7zI8Qj5eD+eb/kGpezTezV3P+uvko0St5XtEpBgZ9oAQ6aZX+9V+ZwExbRs2DqnJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5042
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

SGkgTWFya3VzLg0KQ2FuIHlvdSBoZWxwIG1lIG1ha2UgYSB0ZW1wbGF0ZSB0byBpbXByb3ZlIHRo
ZSB3b3JkaW5nPyBJIGhhdmUgbGl0dGxlIGV4cGVyaWVuY2UgaW4gdGhpcyBhcmVhLiBUaGFuayB5
b3Xwn5iKDQpSZWdhcmRzLA0KV2FuZy4NCi0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCuWPkeS7tuS6
ujogTWFya3VzIEVsZnJpbmcgPE1hcmt1cy5FbGZyaW5nQHdlYi5kZT4gDQrlj5HpgIHml7bpl7Q6
IDIwMjPlubQ35pyINuaXpSAzOjMzDQrmlLbku7bkuro6IOeOi+aYji3ova/ku7blupXlsYLmioDm
nK/pg6ggPG1hY2hlbEB2aXZvLmNvbT47IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbC1q
YW5pdG9yc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZzsgRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBEdW1hemV0
IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47
IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47IFN1bmlsIEdvdXRoYW0gPHNnb3V0aGFt
QG1hcnZlbGwuY29tPg0K5oqE6YCBOiBvcGVuc291cmNlLmtlcm5lbCA8b3BlbnNvdXJjZS5rZXJu
ZWxAdml2by5jb20+OyBMS01MIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPg0K5Li76aKY
OiBSZTogW1BBVENIIG5ldCB2Ml0gbmV0OiB0aHVuZGVyeDogRml4IHJlc291cmNlIGxlYWtzIGlu
IGEgZGV2aWNlX2Zvcl9lYWNoX2NoaWxkX25vZGUoKSBsb29wDQoNCj4gVGhlIGRldmljZV9mb3Jf
ZWFjaF9jaGlsZF9ub2RlKCkgbG9vcCBpbg0KPiBiZ3hfaW5pdF9vZl9waHkoKSBmdW5jdGlvbiBz
aG91bGQgaGF2ZQ0KPiB3bm9kZV9oYW5kbGVfcHV0KCkgYmVmb3JlIGJyZWFrDQo+IHdoaWNoIGNv
dWxkIGF2b2lkIHJlc291cmNlIGxlYWtzLg0KPiBUaGlzIHBhdGNoIGNvdWxkIGZpeCB0aGlzIGJ1
Zy4NCg0KUGxlYXNlIGNob29zZSBhIGJldHRlciBpbXBlcmF0aXZlIGNoYW5nZSBzdWdnZXN0aW9u
Lg0KDQpTZWUgYWxzbzoNCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJu
ZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL0RvY3VtZW50YXRpb24vcHJvY2Vzcy9zdWJt
aXR0aW5nLXBhdGNoZXMucnN0P2g9djYuNCNuOTQNCg0KDQpIb3cgZG8geW91IHRoaW5rIGFib3V0
IHRvIGFkZCB0aGUgdGFnIOKAnEZpeGVz4oCdPw0KDQpSZWdhcmRzLA0KTWFya3VzDQo=

