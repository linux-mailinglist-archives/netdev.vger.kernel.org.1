Return-Path: <netdev+bounces-27937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A8477DB61
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 09:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE03D1C20F55
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 07:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A51C8F3;
	Wed, 16 Aug 2023 07:52:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3F217F7
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 07:52:31 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2128.outbound.protection.outlook.com [40.107.8.128])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE842121
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 00:52:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGqeHKLx4fMWIaRJ26XhiPRd8l17pHMbE1Ue44iqwVwRdeEgd7Lhockeop8TH+wJFnJJq9v82mJ2LjUV51cJK0K6Kct9Rga0GvVmtFRfqw4/9K04bPlTr4mMfdNLk2YLpqEpaubqdfOrQ/LBRNrrj2820DUgSzSIJ/G69IgZy4au2GuTkYv/RYG/da+tRBo3RsM1k9XeLbLmkuyK9FtMeQjJOalkoER0w0l4wETet3j9nEjhBkZ+xF+WB1OE7ZVrIYh0ppFfbCh6/5aU2f99a1gQciht6KpvYQjewQnN4MycqNNlPM9EPu5wKBLYur9b/ciNYz1h/LIYhc0j9yV9Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OlPDscwityn2MiF7CFlLKQdJqNAXuVqhqQhiWldZrmw=;
 b=FEXLgx0NwNG4JkCoahTB3i4p7EfEkWAJVZVtzhjfJG16QACYAb3piauDa2ovGGAxYQlO7qMRwcEsXXY2dq+vISAJSZzUaPtxmNYXcE/Q8Tffzpo/uOIXMl2G5mre6iY2dAidLsmJvBR+FluBfVN5C0ZDe8OO+gV90bt7W5vvOS6wIeVkTOwXASh6sq8k+GfvoYIFMB0b+pPUfsyB0wX3jNtIFTO4EHNuy9tmKSYHzdQ2NAqZVR1NXVRNzeiFLO9AbyZ7+gCdDTRTMKcsZMxmRMnyf4H9htU0hu5nyyi6PbV0MAhYSRCvzFQV+QRpQrt39d//GxWxmBrClGD4+eTZdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlPDscwityn2MiF7CFlLKQdJqNAXuVqhqQhiWldZrmw=;
 b=fLZi4OBMsryWp+EiCqC/J6+WxyElO7yZ3/KCf/HSFvwf9bN9zgN4bsnGyyvG+nVCaz0deLZJxg6vKdLkni2WfVN0ZOOpUQPyJQ9fRLQ2iuYM7U0inTT6xBCwlzU3zOAaq7IOyET3C6tEV8L/qvEVAyRttSdo2kwQjWZXiETEoCw=
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by DB5P189MB2552.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:4aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 07:52:24 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670%6]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 07:52:24 +0000
From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Question]: TCP resets when using ECMP for load-balancing between
 multiple servers.
Thread-Topic: [Question]: TCP resets when using ECMP for load-balancing
 between multiple servers.
Thread-Index: AQHZz7ZFUs0IEyK82U29eJBQITrblq/r5lOAgACl7gA=
Date: Wed, 16 Aug 2023 07:52:24 +0000
Message-ID:
 <DBBP189MB143319E8587CD8D26F10CDB99515A@DBBP189MB1433.EURP189.PROD.OUTLOOK.COM>
References: <20230815201048.1796-1-sriram.yagnaraman@est.tech>
 <20230815145307.0ed1e154@hermes.local>
In-Reply-To: <20230815145307.0ed1e154@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBP189MB1433:EE_|DB5P189MB2552:EE_
x-ms-office365-filtering-correlation-id: 39d30b6a-32f7-4e55-760d-08db9e2dbaa1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 x94Azql/YyDngAO8HyAgGWHhucpchqsWZvtgPbDxOMvk53NCmA4d47G2eVpSgtKDfzZq49xsAJjEm3wCTA46z/OkSI/T/APAeUoyD5sLUnTwrqpLP0zrqgP1Jx07WMvxzXO3p2eY6BWodu92yxVs/aczCPWuiD5JLSWNkguRJhnZSmts8sMkTmFgh8lnzMPt+JHdcOu4HMHypvzU2apNCSmNFPVFJ8R849No3D/zgrDPU/vVdqoHBEzq+7Cb+1NBqTY/9mg042pynuAzQKzBvIpPhn3yjq0ehQffLjsUjpUSbkN/ZL98YF3aQStMfg8c/MH6M8imd5HIkSjXNj3goErWg57kOf4P35f9BkeqwJ66qnUP8qZpktw+0KyTrWfp3hYzHHGSYFNyqRp4VLeEuSfOlTPb0HfBtU0iTDc4k/qTTCwmnfNYsgcXiCJ68gV67S7RGUvgHddkiR+08RcfpYiH5IvJ47LDkOXyFdOuWOqvGwO17bZAFm+QFwNzwtHKUA/Mt3ZKLNvJuuzmVcdABL+T5CGSFJB982rvnYEaI6UkAuczDkfGLQeZYa6YU5WHgIRx6e3oI2yvQGW0PV4dUZki6KHnPuYPbGuvt4f2d6jaz1tfCqMVvAh/QdcFtQ+E
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(39830400003)(346002)(136003)(1800799009)(451199024)(186009)(71200400001)(64756008)(66446008)(76116006)(66476007)(66556008)(66946007)(7696005)(6506007)(2906002)(478600001)(9686003)(26005)(6916009)(5660300002)(83380400001)(52536014)(41300700001)(316002)(44832011)(53546011)(8936002)(4326008)(8676002)(122000001)(38100700002)(38070700005)(33656002)(86362001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SkpuNHRrcnFQYzl0Q3dIYzM5WlJsUVdHbXVqdjkrMEVXU29CR3luM08xSlVI?=
 =?utf-8?B?TGxsVUZoMThUcWNZQ0RBOUo0amlDR3ZWRDZ0Ymt3Q25iRFY4YU9TazRJRUxi?=
 =?utf-8?B?enhOSDFqL05FM3VtaGhXWEhJVDZDdmRxbHIwS095dWIvbUJ2SEI0WUNHL1ND?=
 =?utf-8?B?bUk4SGltZm41UDZydnBjWTJNTmFMTjVOZUVEZEZwaDRsd3duRFBOVzB6V1Ix?=
 =?utf-8?B?N3c1NnRUYmVpQWwrS0pITWlzRnBwZzZTVi8wd21LYmpEMXRSK3lqSmphcDUw?=
 =?utf-8?B?TUV6bWdnR1AweEtTeEh3WDB5Zm9KYlBodFZLL0IvTktVY0J3NGxZRG1vV2FE?=
 =?utf-8?B?dzBFdWg2bkxRb013bkdiTThlOWlRSkt0N2FoK2lXTUNpcVkzT0wvTUk4NC92?=
 =?utf-8?B?aGFGeWxHelB3OVJkQ01IRk9yWFFIOGtscndPcUFIQXJFUTRkMjFWT1plL2w3?=
 =?utf-8?B?Q1ZGMDc4WEIwWWFycXc1R2dFRnFGUTg5TEk4UVcySHZKN0lxYWlJdVA0ZmJi?=
 =?utf-8?B?OUxCNUp4UzNVM1ZiQ1R1aGFtbWh5RTlwZE0yU0pqNGxzY1lmckNxRUxQejFP?=
 =?utf-8?B?cHNuTzNHZ3lmOTlncHhXTmJTSEpNUzQ4NHU2TGtXMWJvWmVLaGNLWFlYSW9K?=
 =?utf-8?B?WWthTks2MzZTYVJubTRTeUJLNEhDK0ppVGRJMTBjVHFmeisxQTBHdnllY3Vr?=
 =?utf-8?B?UlJIT0tQVHhUUnR6UFpCNnR2bytFNUluZTgvbjlsT21ZUEFvaXMxa1lkdWQy?=
 =?utf-8?B?a1JXVW9Gd2toK2tPZWk4eWxRZk5VVXoyQzE1MDRtYXpBbmZTS05CYi83OWtP?=
 =?utf-8?B?RE5KbEFnSGRDUWFxY2lKWUtua0tOOUliMUhXaXJWTThaeWNjRHRyTE5QQS83?=
 =?utf-8?B?RnJoblpUazZaNkgySzJhaDdZYXEzczh5K3hOL0NqTDZvYXlNblRwRDIyeHgw?=
 =?utf-8?B?ZWxYWmtEOEpWWmZ6MHJweld0MXpMU1kwZFlnRkl3VHlUdTVlNkdaVVcxU0R6?=
 =?utf-8?B?SUJDdE43dGtPZ0x1SVBjcERuQS8rNWprK0xBMThpcmlVR1dvZ002OXdTeFRt?=
 =?utf-8?B?S3hwWkdMY3BHNVlyM1p6R2dzUUZ2dlB3M1R6MXh5QXMyMEU5WEV1UWxCZzgz?=
 =?utf-8?B?cVBoMUliQlhZK08xTG1DM214b0tQRFNBMG5uSUpOUGtRYVZ0Q201aFRFNStE?=
 =?utf-8?B?SkVxQldFcWxTNWRaNjRnWjFUTFBpODE4dGI4MVBMblBSR3VUQnlOU3diQXQy?=
 =?utf-8?B?RkF2OG0remVuTW1rYWxxLzhBeTJBd1UzWFNCaE14RWZNVW1pMytYTkVlcEtQ?=
 =?utf-8?B?c2R0SlVQdGMyWDhPS1dmSHZ6cG8yY1NaYUdPV3dJclcxWm5TeGxUU0c3a1V5?=
 =?utf-8?B?aEV0d2t5QUE0bkx6NEI2aDVhWVRoZm40eVkvdGlyRWtZUVZRWTlSL1VoOFJS?=
 =?utf-8?B?TFFuZE5wY3ZBZ0M2dFhWbGM0ZHBpc0RPcGF3Q0MvUk9zdHhOU0g1RFJ5aGdn?=
 =?utf-8?B?QTNVRkVQc1ZkWERQejhNQUdENFNuaDZpTjRFaDMraCtkSlRIeGpwTXkvUGxP?=
 =?utf-8?B?VkZ2ZDg1SDVPNXRzSE1tdVRLOWpLQlVGckhVNEkvdW12ZGVnaHlUaVltYnc1?=
 =?utf-8?B?QU0zbS9VbXRMYWtybHNycXl5WEpoR3BXa3hodUFSUU82TzJzdzNHb1libWl4?=
 =?utf-8?B?aGNDOEliMVRpcHBESytEVENoTHBpczZXM01OMXFtTHdHYlh4bUpYajZobE00?=
 =?utf-8?B?WkJyOXAxSUZ4Y1R4YmlRNjVFR2VOenRmVFB3a0E2Y1JKNFdYUWhSTGhaV3J5?=
 =?utf-8?B?QXhXTWpYa3pZcUxaaXRiaHdsaGIxdGFKSktpa241S0hSUGZpNGZ4NTUxTTE2?=
 =?utf-8?B?ZVlLMWQ3NTNyM1RMTHdSQ0I3cXArUENOU2xqd2hFVS9zZVpyVW5xQ0tkNC8w?=
 =?utf-8?B?MmRpeS9QRmlsOC9ZcktnZjBQYWdaRXg5b0dDWWtaVjJlR2VuRXlIa3J6dlIz?=
 =?utf-8?B?N2gwQ0YxMTBmaXZQd2haQllIWExRZXU0UEQvTHc3Vk9nSCszT1NQRjhaYWha?=
 =?utf-8?B?WGhSVjQ0djVwV0twc3ZrUmRkR2NMMHdyNms5OEYrUmozMHVnT01vT1RyN01L?=
 =?utf-8?Q?bQNZopyvO0kDulGb4NlC9KiTW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d30b6a-32f7-4e55-760d-08db9e2dbaa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 07:52:24.4532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FUHFXJ1/6v0qED1GbH6/AMytWIhWwkhEGVogLm12MjsDkIHpm58prgQF7Yy7gEzcG7z/g/PtTxBskziTg9ve9NZ2rmeKNPHQSN1AR+M27pw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5P189MB2552
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlcGhlbiBIZW1taW5n
ZXIgPHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnPg0KPiBTZW50OiBUdWVzZGF5LCAxNSBBdWd1
c3QgMjAyMyAyMzo1Mw0KPiBUbzogU3JpcmFtIFlhZ25hcmFtYW4gPHNyaXJhbS55YWduYXJhbWFu
QGVzdC50ZWNoPg0KPiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTog
W1F1ZXN0aW9uXTogVENQIHJlc2V0cyB3aGVuIHVzaW5nIEVDTVAgZm9yIGxvYWQtYmFsYW5jaW5n
DQo+IGJldHdlZW4gbXVsdGlwbGUgc2VydmVycy4NCj4gDQo+IE9uIFR1ZSwgMTUgQXVnIDIwMjMg
MjI6MTA6NDggKzAyMDANCj4gU3JpcmFtIFlhZ25hcmFtYW4gPHNyaXJhbS55YWduYXJhbWFuQGVz
dC50ZWNoPiB3cm90ZToNCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC9p
bl9yb3V0ZS5oDQo+ID4gYi9pbmNsdWRlL3VhcGkvbGludXgvaW5fcm91dGUuaCBpbmRleCAwY2My
YzIzYjQ3ZjguLjAxYWUwNmM3NzQzYg0KPiA+IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvdWFw
aS9saW51eC9pbl9yb3V0ZS5oDQo+ID4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L2luX3JvdXRl
LmgNCj4gPiBAQCAtMTUsNiArMTUsNyBAQA0KPiA+ICAjZGVmaW5lIFJUQ0ZfUkVESVJFQ1RFRAkw
eDAwMDQwMDAwDQo+ID4gICNkZWZpbmUgUlRDRl9UUFJPWFkJMHgwMDA4MDAwMCAvKiB1bnVzZWQg
Ki8NCj4gPg0KPiA+ICsjZGVmaW5lIFJUQ0ZfTVVMVElQQVRICTB4MDAyMDAwMDANCj4gPiAgI2Rl
ZmluZSBSVENGX0ZBU1QJMHgwMDIwMDAwMCAvKiB1bnVzZWQgKi8NCj4gDQo+IFRoaXMgbG9va3Mg
bGlrZSBhIGJhZCBpZGVhLiBSZXVzaW5nIGJpdHMgdGhhdCB3ZXJlIHVudXNlZCBpbiB0aGUgcGFz
dCBhbmQNCj4gZXhwb3NlZCB0aHJvdWdoIHVhcGkgd2lsbCBsaWtlbHkgY2F1c2UgYW4gQUJJIGJy
ZWFrYWdlLg0KDQpUaGFua3MsIEkgYWdyZWUsIHRoZSBjb2RlIEkgcG9zdGVkIGlzIGp1c3QgYSBo
YWNrIHRvIHRlc3QgdGhlIGh5cG90aGVzaXMgaWYgcm91dGUgaGludHMgYXJlIHRoZSByb290IGNh
dXNlLg0KDQpJdCB3b3VsZCBiZSBuaWNlIHRvIGdldCBzb21lIGd1aWRhbmNlL3N1Z2dlc3Rpb24g
b24NCi0gSXMgdGhpcyByZWFsbHkgYSBwcm9ibGVtLCBhbmQgc2hvdWxkIGJlIGZpeGVkPw0KLSBX
aGF0IGlzIHRoZSBiZXN0IHdheSB0byBzb2x2ZSB0aGlzIGZvciBpcHY0IGFuZCBpcHY2Pw0KDQpJ
IGNhbiBwcm9wb3NlIGEgcHJvcGVyIGZpeCBhZnRlciB0aGF0Lg0K

