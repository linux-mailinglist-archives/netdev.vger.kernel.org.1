Return-Path: <netdev+bounces-18232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5D0755EBE
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 10:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EF9F28143E
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 08:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F249946F;
	Mon, 17 Jul 2023 08:49:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F755687
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 08:49:58 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2101.outbound.protection.outlook.com [40.107.255.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1079D1B3;
	Mon, 17 Jul 2023 01:49:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QrCxPPionMQwjjI166IQzOBfat69YdB5CoWek9Xpx876VQHwF3FJue7610X0EqV+qsl+J8NS6G+vf1PZpqyl7zw0VRUspCYVuvw9y/KywiYn0kzoDg4OM5ySrZ8/rBkiJgRZHaqjeeD+GON57y4LvoN49lyn1H3vlKcEeF4voAv7BAgmGv08SRq1/xp8jMjckE1VZVmJq6ZqSDYUTwZfkFVaSgtXeCligEvwnVFtE18l5p+gUThN/UvAdETHS1AB+qQQqllRvesqJSAVsCuWwtq8zOcyjDbSFXAVQv5xx1vfWnOQNerM9EORF7TrgV1iUwPSm/F/KMPihWES5lsxZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAg0EwJZDXjSbb4/LLS2qvjRazhMQ9XrttmEYElfmmI=;
 b=JhuamDsbpoxTVo/0O4Uovt+YE8+fk1faOS7KUaKSC5V7/0LiGJVJa0gjyb05yK8Zd/73eUledtd6jKYxAHiV/aoRHSrZtndlHD61+rML3kIv2ca6iqfUIZx4btLvAtLxJaAvZrEJbZ+4FdXR7iD3tGY3g9Gqenr1kXUBCDoe6yADC53BfUuO3L3k3h3cxQEPEWeeBW95+BU7FCsgiAOr/Ca4G02RW8H756132Cd9olsY/9DyX1KfaK2QK2d3wdtdHCx405BJ8gPNYFL4yjw4iIFDiENjRrUaOp5stFgjLuWaf2OL+IHFqZ91nrgdbCAOgVVx41VpGXzU4+HOSIqcoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAg0EwJZDXjSbb4/LLS2qvjRazhMQ9XrttmEYElfmmI=;
 b=M7rFlWWqtEOvp3lezkGFRJ59AzUIza5Jkq+cXwQJ4Oycj5sizJv/nQ2/uvIS7xAMj/8u9RQm5I7v+Z4QJW0ChfhjrXDBGTf3tQt4E9v0KOX5xr4RSGwU4OG42GxLlzbr7qVz8P7Wpbcq9PUi4k9eWF/nxvbHt9oLj+782mK8xRa8PF4Hjjq603u9vzAB1Qy+tc+57V2cZJFvR/CsSiBWw8GEUTDZzvamaC50HKZf7X/aekkOnaOQ0o8iyxozfwRYx8MKYX1+l0i3bHVdGrCj3MQMMt0tRm0+T07q45a9rJjvRy3yNA2vwbDzrjUw4TQ+nvKbxtjmvdLV1K8sfskaIg==
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 TYUPR06MB6099.apcprd06.prod.outlook.com (2603:1096:400:356::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31; Mon, 17 Jul 2023 08:49:52 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 08:49:52 +0000
From: =?gb2312?B?zfXD9y3I7bz+tdey47y8yvWyvw==?= <machel@vivo.com>
To: Jay Vosburgh <jay.vosburgh@canonical.com>
CC: Andy Gospodarek <andy@greyhouse.net>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>
Subject:
 =?gb2312?B?u9i4tDogW1BBVENIIG5ldCB2Ml0gbmV0OiBib25kaW5nOiBSZW1vdmUgZXJy?=
 =?gb2312?B?b3IgY2hlY2tpbmcgZm9yIGRlYnVnZnNfY3JlYXRlX2Rpcigp?=
Thread-Topic: [PATCH net v2] net: bonding: Remove error checking for
 debugfs_create_dir()
Thread-Index: AQHZtjLrg2vyc3SUl0qp77egjivvd6+5b4sAgAQ57pA=
Date: Mon, 17 Jul 2023 08:49:51 +0000
Message-ID:
 <SG2PR06MB3743A5D8634634AD0C858DDCBD3BA@SG2PR06MB3743.apcprd06.prod.outlook.com>
References: <20230714090856.11571-1-machel@vivo.com> <3370.1689351142@famine>
In-Reply-To: <3370.1689351142@famine>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3743:EE_|TYUPR06MB6099:EE_
x-ms-office365-filtering-correlation-id: e4fb6a58-95fd-4c13-1426-08db86a2c910
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 i+m56NugKYphMSEfl1Yk1jw7xu3Oot2h9KS3jIuTHaNWO/yF7FeC/EqOFAvmW6zd5ybiSGfIfrY4UZvqSJQ1PfdUkMVXg5Qq4HT/GIiLzlIqUGmC//uv5bY84WrrC81E/ZnNclnQAsM411WBuf2HAADd0f1JvfjtbQRo6vJU0N/IEFnQrfnhy6WyfV0zV+X9VxAEX/G0f2jI62M6qOa08Y5G8U0FkgGZ6Mfh7cbpUXLC8s1wm7mN/rzzRspRTp6tkL40VqQdD40jXO3SSX+fGfmGdygI/eV1Y8dK0wJzyNtRJHEfnIEwYGex2xlkEAl1Cf0ucVp2DgqkQME60dFHGIhrZvd7RCKwiR7moAEZ31i4m7kCs4pO1ZeIR/9bh7acOrFgaxrMrmzgAgWKyfXv7T6sAS3+w9SAlAspWsFU4MEhteyda1XHvAJOFMZrT89kFkIhIVYB6NOn9ly9BAgRo8LqRwmFUuYgAx3dO482T5g85SZqrVuLuCNB1Xw5Y4I9ecDLFyOb2KRZHmX5fMS/XLSNDavTVuQaUSKWeWsH1xomzh7sbhXJFsRMEjTm4O+j8ES82LCRx3pKkqmYB//w9YzUOVzqVxK/8CsbxG2/oGWf2i6a7pRh9lzWDQUZ8Coi
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(451199021)(71200400001)(33656002)(107886003)(6506007)(83380400001)(38100700002)(186003)(26005)(55016003)(478600001)(38070700005)(7696005)(9686003)(224303003)(54906003)(966005)(41300700001)(66476007)(66446008)(2906002)(8936002)(66556008)(6916009)(66946007)(316002)(4326008)(5660300002)(52536014)(64756008)(85182001)(86362001)(76116006)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?WEIxWWl2WkFmRFhZaXM5alg0SDNtVmJwTGlxWEtqOHNZb0gvelNhRXN6SEVl?=
 =?gb2312?B?eHUvNmMxRFdBVXUwYjFCcGc4ejROblYwTmRUQWNnQ2dERHpkZGNiS1Y1Tndj?=
 =?gb2312?B?RkJFNmZMWEZlQUI4ZzJRU0ZlTnhKZUw4MmpIeThQRExET01aTG4ydEhleWRB?=
 =?gb2312?B?VUVaQzJjMndZbzVBdFZyQUNUemFkNm1TT2dRZHY0MU5uSjZTZ29OaDZLZmIw?=
 =?gb2312?B?K0pacTRxRU0zZWt3cWlHZkRJM2xzcjZMK0t3SEVKSkNNYnhCNTNBM21VVmZW?=
 =?gb2312?B?R2ZNdllnUEtwYlBMakFUeWNwTHBMZmRVUmVYWWVYa0dXUHMzOE9WRnRqZVMv?=
 =?gb2312?B?ckZ2eURFa2tLZW41QlFKNjVUMjFDbStYb00rWFhscTdqRHZIMDNyMkZsaStB?=
 =?gb2312?B?eTNrZWZGQ2thZDIyZE0xUzZBOEdzNkFYZTcxazNTcklCYzRaN2NFWWZxbUly?=
 =?gb2312?B?UkUyejJNQkMrcUdzbXhjc01NcGJoSVpjSmtOS2NjL3pkc0xBSlZvV084b1Fx?=
 =?gb2312?B?QzM2aVBXY0lBZXpCUFRsaGJRaE0xcE52bDU4QWlmZmVJbmV0MENuTHlNcGFY?=
 =?gb2312?B?cnUwd1AwTllvTWs3Tm05NnhTTWJXTjVlWFVXQ0V2cXQ0eGdYOGdJeGhTejli?=
 =?gb2312?B?RWhtRmRENHV2MGRPQmtNNUY4UThzUmtWSUJUeWtFcEVKVzdUemZLU3VBQm52?=
 =?gb2312?B?SkU0N25iYTNZT0VpcHI0Wm5CWHluK0FWMTh6bmtaOG5XWXVGemgzSDdIL3hR?=
 =?gb2312?B?TlE3ODlYWTd0bGNQTGpueEpoL0VQVk9XNW1jVUcvNTQvOHRRelpabk9xY28v?=
 =?gb2312?B?aXdhbTZyR0tYKzFOWEJYNDBCdHpEZFRsNXZuaUFyb3V2LytVSzdkclNIekUv?=
 =?gb2312?B?Y0haV1dCRXBMdDZlZEExRzh5WnVTRGRwZHhaZGZEaElrSUxTSzJ5QkZ2N0dm?=
 =?gb2312?B?L2VjRUJ1YWR5U0Vzd2NZdmV0ZWFBMWs0ZjJQUnY4cHBwMjQvT3BkdTJLUkdI?=
 =?gb2312?B?VWVkdGdTOS9oZkJ4U2lVTjJtRFdmcmJ3L1JVRFFOTkp4b1hsNDN6Y25oM2d2?=
 =?gb2312?B?N1JKZEZRTURuV25rclRzUGJWM1FTQzFuNFRsbW1JQTBGOTlVaGpIc2xUeGlu?=
 =?gb2312?B?clc1QXR4UVdRY2RzTXJESzUyTFhMN0ZQYjV4cXpHc1V1b0tiM25lVW1kTU52?=
 =?gb2312?B?aDFybEo1MEdNQ2hubXJMY1RUSzJKNXFNbXVGRWRGalpRbmZyOFBZT3lyMGlK?=
 =?gb2312?B?djMrR1ZxVG5tQ2ZPVjhsYU5OOXpkYVNkSVZ2SFY4U1JTNEVpUjlqOHp3Q1B4?=
 =?gb2312?B?blFadUpoTkJzVjRiTG14YVNyL3JtTVNVUldOUVRKWXVFNngxNEQ1SlZMNFZW?=
 =?gb2312?B?dnFQVGhOVlo3dE5PelB5TWJxZW45R1FqeGdDbk9Jc2RJMXpqMXcyQThoVGZC?=
 =?gb2312?B?Ui93NzBZRTM1WmN3d2wvSFFRMHBHWUJzeHp4WXlWc2ZpN1FpSXlzYnpyNG5V?=
 =?gb2312?B?Y2QrM3lFN0xnZHo5aUIvYm1XYVliam8xdkNqMG9sQnMzdXp4T2ZDcUw5RjlS?=
 =?gb2312?B?MFpEa2VITUpIK0ozcjk3bkFid0xnblVpb2psNEVvMERsVGt2eFkrYlFYcUlq?=
 =?gb2312?B?TVVFZ2kyNHdDVWk3RkVKSzlDSFJ0dnBEZWFtNUNPSnRPOVpaNFJGQmFyaE5M?=
 =?gb2312?B?bEVUK0JNQ21RWUJiUjVCaVJ6aE10a3BXdGFveE1ycUdsc1dWbVVCdVBzUGV3?=
 =?gb2312?B?d3NlT3dDdEoycEQzbmJReWduUFpqU2ZvVmZ6eWc4RkcvUjlLdnRSRFQvSU9C?=
 =?gb2312?B?SEhldzBzNkUxUkxMbDM3b1VzY1VyT3BPSEFJZXBhdDFmOUpFS2orblZpNVIz?=
 =?gb2312?B?a0J6V0lQRlJGOHlBTTE3aE4vNzR4SmJ2MlNIT2o3Vk1vYmx4TTJwWjlDeHVK?=
 =?gb2312?B?NDl4TkpKNmh1am1tNE9jWUU3Zit5dTErK0o5ZFpUSFhCWG9NS1VzVzFVbURp?=
 =?gb2312?B?b1ZFSTcrdFVXMW9BcmxrWnRtTnlWYm05alcrTXZ0VXVlUHFLaEJLeXhZZmRI?=
 =?gb2312?B?OFlvZmFINGtxL2dwdUtBdUlic3E3OUhoWVJvcFdTdXFyWlV3c2xwNnM5ckdj?=
 =?gb2312?Q?eEj4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e4fb6a58-95fd-4c13-1426-08db86a2c910
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2023 08:49:51.8787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kRcUbJcufiuJxFRzWlKc66RHHuLsLa8E0eLnkfOx52o5pBWi4DbNVmPW5vmTjBaVv8m7V5+PUVsc/SIDdXnf0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6099
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

T2ssIEkgd2lsbCBhbWVuZCB2MSBhbmQgcmVzdWJtaXQgdjMuDQpSZWdhcmRzDQpXYW5nIE1pbmcN
Cg0KLS0tLS3Tyrz+1K28/i0tLS0tDQq3orz+yMs6IEpheSBWb3NidXJnaCA8amF5LnZvc2J1cmdo
QGNhbm9uaWNhbC5jb20+IA0Kt6LLzcqxvOQ6IDIwMjPE6jfUwjE1yNUgMDoxMg0KytW8/sjLOiDN
9cP3LcjtvP6117LjvLzK9bK/IDxtYWNoZWxAdml2by5jb20+DQqzrcvNOiBBbmR5IEdvc3BvZGFy
ZWsgPGFuZHlAZ3JleWhvdXNlLm5ldD47IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0
Lm5ldD47IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IEpha3ViIEtpY2luc2tp
IDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+OyBuZXRk
ZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBvcGVuc291
cmNlLmtlcm5lbCA8b3BlbnNvdXJjZS5rZXJuZWxAdml2by5jb20+DQrW98ziOiBSZTogW1BBVENI
IG5ldCB2Ml0gbmV0OiBib25kaW5nOiBSZW1vdmUgZXJyb3IgY2hlY2tpbmcgZm9yIGRlYnVnZnNf
Y3JlYXRlX2RpcigpDQoNCls/Pz8/Pz8/Pz8gamF5LnZvc2J1cmdoQGNhbm9uaWNhbC5jb20gPz8/
Pz8/Pz8/IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbj8/Pz8/
Pz8/Pz8/Pz9dDQoNCldhbmcgTWluZyA8bWFjaGVsQHZpdm8uY29tPiB3cm90ZToNCg0KPkl0IGlz
IGV4cGVjdGVkIHRoYXQgbW9zdCBjYWxsZXJzIHNob3VsZCBfaWdub3JlXyB0aGUgZXJyb3JzIHJl
dHVybiBieSANCj5kZWJ1Z2ZzX2NyZWF0ZV9kaXIoKSBpbiBib25kX2RlYnVnX3JlcmVnaXN0ZXIo
KS4NCg0KICAgICAgICBXaHkgc2hvdWxkIHRoZSBlcnJvciBiZSBpZ25vcmVkPyAgSXQncyBub3Qg
YSBmYXRhbCBlcnJvciwgaW4gdGhlIHNlbnNlIHRoYXQgdGhlIGJvbmQgaXRzZWxmIHNob3VsZCBi
ZSB1bnJlZ2lzdGVyZWQsIGJ1dCBJJ20gbm90IHN1cmUgd2h5IGFuIGVycm9yIG1lc3NhZ2UgdGhh
dCB0aGUgZGVidWdmcyByZWdpc3RyYXRpb24gZmFpbGVkIGlzIHVuZGVzaXJhYmxlLg0KDQogICAg
ICAgIEFsc28sIHRoZSBjb2RlIGluIHF1ZXN0aW9uIGlzIGluIGJvbmRfY3JlYXRlX2RlYnVnZnMo
KSwgbm90IGJvbmRfZGVidWdfcmVyZWdpc3RlcigpLiAgVGhlIGRpZmYgYmVsb3cgbG9va3MgYSBi
aXQgb2RkIGluIHRoYXQgdGhlIGNvbnRleHQgbGluZSBsaXN0cyBfcmVyZWdpc3RlciwgYnV0IHRo
YXQncyBub3QgdGhlIGZ1bmN0aW9uIGJlaW5nIGNoYW5nZWQuDQoNCiAgICAgICAgSSB0aG91Z2h0
IHRoZSB2MSBwYXRjaCB3YXMgZmluZS4NCg0KICAgICAgICAtSg0KDQo+U2lnbmVkLW9mZi1ieTog
V2FuZyBNaW5nIDxtYWNoZWxAdml2by5jb20+DQo+LS0tDQo+IGRyaXZlcnMvbmV0L2JvbmRpbmcv
Ym9uZF9kZWJ1Z2ZzLmMgfCAzIC0tLQ0KPiAxIGZpbGUgY2hhbmdlZCwgMyBkZWxldGlvbnMoLSkN
Cj4NCj5kaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvYm9uZGluZy9ib25kX2RlYnVnZnMuYyANCj5i
L2RyaXZlcnMvbmV0L2JvbmRpbmcvYm9uZF9kZWJ1Z2ZzLmMNCj5pbmRleCA1OTQwOTQ1MjY2NDgu
LmE0MWY3NjU0MjBkYyAxMDA2NDQNCj4tLS0gYS9kcml2ZXJzL25ldC9ib25kaW5nL2JvbmRfZGVi
dWdmcy5jDQo+KysrIGIvZHJpdmVycy9uZXQvYm9uZGluZy9ib25kX2RlYnVnZnMuYw0KPkBAIC04
Nyw5ICs4Nyw2IEBAIHZvaWQgYm9uZF9kZWJ1Z19yZXJlZ2lzdGVyKHN0cnVjdCBib25kaW5nICpi
b25kKSAgDQo+dm9pZCBib25kX2NyZWF0ZV9kZWJ1Z2ZzKHZvaWQpICB7DQo+ICAgICAgIGJvbmRp
bmdfZGVidWdfcm9vdCA9IGRlYnVnZnNfY3JlYXRlX2RpcigiYm9uZGluZyIsIE5VTEwpOw0KPi0N
Cj4tICAgICAgaWYgKCFib25kaW5nX2RlYnVnX3Jvb3QpDQo+LSAgICAgICAgICAgICAgcHJfd2Fy
bigiV2FybmluZzogQ2Fubm90IGNyZWF0ZSBib25kaW5nIGRpcmVjdG9yeSBpbiBkZWJ1Z2ZzXG4i
KTsNCj4gfQ0KPg0KPiB2b2lkIGJvbmRfZGVzdHJveV9kZWJ1Z2ZzKHZvaWQpDQo+LS0NCj4yLjI1
LjENCj4NCg0KLS0tDQogICAgICAgIC1KYXkgVm9zYnVyZ2gsIGpheS52b3NidXJnaEBjYW5vbmlj
YWwuY29tDQo=

