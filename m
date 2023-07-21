Return-Path: <netdev+bounces-19704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 139FB75BC94
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 04:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0C32820E2
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 02:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA062397;
	Fri, 21 Jul 2023 02:54:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EED7F
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 02:54:48 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2090.outbound.protection.outlook.com [40.107.215.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE00430D0;
	Thu, 20 Jul 2023 19:54:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQbiNhWqP+3Eyu8h2UowvQWLjrj0/ROTwULhRFuRxXYq/N3uHYghxBlvmhLjVJSnPh27wIRNd8v+L0EUX8XALpIeLihqHVZOA0joG0pI5Kg4asA5GipEnIUyeplcCbid8r/h03h7kbSAADVcq+Bv4dfgCLrGAEdnfSMNb2qtgbn2mjeRypetD4qaYm4xiMlzb1AIB3YGPoIy3f9bD9PnrxOZbv/LzuxvzWr8y/z5cOW8slF8k4wUxlQhPAfBwNHBevKzBf1gpZsJm80RfBb4HwZ6PeI8V59ixeZJGJxuTdhv3gjt3nlg5cqv1joV2Wv+91bI5L+lgE3Pe0tuwvAqFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGcEWwttQdBjY8bW8seAcIDSDoeaMJAtIHntHYATASw=;
 b=hXq7+FkZfSZmGuTTvpzj/itKUpD9gYDZyLdRPIz2bFUoxfG0norj2vs3YBwLAyI/oLdJR41cjpMsiMmUJQC3SbWQixdQMyDDg7qIpjUQ4R0bni28RXHHrFrAsXZ68xkL/2TINL+cNevNn4Zi81cV/4VrneLYKH1HRRErJ8qBU81cXDLnO8WmIaD6cq+PoQzZFazjU1EdfDuU0DQkzK0PrS/Z8cqmJHOy6DGrX+bYtDlX1RA3sHT0gEgNtnCJOzrQyfVnVzQ5yqDm0H5SQpqwVHlbm/ozKkQdfg8YEBeNNhh09VY+m92KcD6s1vWZZl2wKiojq5KbvcPN+b8QDa2L/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGcEWwttQdBjY8bW8seAcIDSDoeaMJAtIHntHYATASw=;
 b=clBtvhAhKwslD7Y3BfVxOA3myWFrjsz1lcBFqJAhTnFv62vAgyY26ygqBqViiY1UgAwZ/WlgpTaPmOksubywXnh2rkhp7NHWQ8LQTkRfEPDc7r7ffm66umMlGlsVfsJuUxpFgH9y4NlDY+4wcjKQadespagwbcUpgvALaqhBtjWvbkF7XrgiHCBGs86Pi638jrLryMPHCO1OFAqxTqFMmF8IJ+d0aZYaYcc7gY86JWzO60Kfv1HysNoK2s63DV8gpfeujC85H1WBqdsc97obmBRj+Z41j2qWLRot4t4hsUU1Foo0z0+o4Sku8BfTZDWdlrpZYj6RV46FZk8e4AngtQ==
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 PSAPR06MB4439.apcprd06.prod.outlook.com (2603:1096:301:80::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.28; Fri, 21 Jul 2023 02:54:27 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::75ed:803d:aa0a:703f]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::75ed:803d:aa0a:703f%7]) with mapi id 15.20.6609.022; Fri, 21 Jul 2023
 02:54:26 +0000
From: =?utf-8?B?5p2c5pWP5p2w?= <duminjie@vivo.com>
To: Mark Brown <broonie@kernel.org>
CC: Vladimir Oltean <olteanv@gmail.com>, Richard Cochran
	<richardcochran@gmail.com>, "open list:FREESCALE DSPI DRIVER"
	<linux-spi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open
 list:PTP HARDWARE CLOCK SUPPORT" <netdev@vger.kernel.org>, opensource.kernel
	<opensource.kernel@vivo.com>
Subject:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjFdIHNwaTogZnNsLWRzcGk6IFVzZSBkZXZfZXJy?=
 =?utf-8?B?X3Byb2JlKCkgaW4gZHNwaV9yZXF1ZXN0X2RtYSgp?=
Thread-Topic: [PATCH v1] spi: fsl-dspi: Use dev_err_probe() in
 dspi_request_dma()
Thread-Index: Adm6EHR22uF5gOmzXUOAvwE9PHYqrgALhKMAAE/a/ZA=
Date: Fri, 21 Jul 2023 02:54:26 +0000
Message-ID:
 <SG2PR06MB5288FB4E5CB1FD5E0FB6D18BAE3FA@SG2PR06MB5288.apcprd06.prod.outlook.com>
References: <20230719071239.4736-1-duminjie@vivo.com>
 <dd60d083-6ffe-4d74-8c5b-588a62303b34@sirena.org.uk>
In-Reply-To: <dd60d083-6ffe-4d74-8c5b-588a62303b34@sirena.org.uk>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB5288:EE_|PSAPR06MB4439:EE_
x-ms-office365-filtering-correlation-id: bd37cd30-37d4-4369-b2f7-08db8995cbea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 4f3/UwDi/YlucnKUKTw4ofxFqDtMk5SMEHNlGlYgNdYKe2L4+2s/+Qjq1AXBtOQagCt+t+gXoVMCnrL1XqwZJHnXY0vC9OONthU0sfqK1gr6EqWhm4ZdYjMETKVdTa+GbQng/y1TtPq6Tbckc2SfnC152mkV+X1dlWyeplL8s6i5rcLo5zd2q3iHsX8rmz2MmrRJO5gs2Yu940UUCMhoz6XHl382LZH0dilsnrzvzQ5y723ryT+Or92gQPjc6g3xaeaToP3+wcHKTYAnWIqWi79g81xkA33X9OUlNHiiwa3GJcjvO4wj6lJq6wqi/MhOeRl9mGHsgCVE4FE5f+lRLDJ9a3KIv4I5a1EEN00VMip8U3vkEY7kWGtcovlW65CvnZ3oclOG7SUExfrBvyJdf+6+2GlbGrRBPdK7NrLEi7eR5igWwJhWg0bj6CeY1l8XA0HlvNTTJN38lMYP5r/pRCFY6Z40MxdRXVeNTThkp7Xwe8czcpYYi/q4PYVoMrLjJqp7zTxaE+IlO1VqUfEkIDkNuEVNlRGSOWA/PUoPw+tqR9Wy+gpyTCHegZtv1hAx9HwrgCPkVk+iP7PB0PuE3cd3iXPpqVAtKSeGZTGHdFA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39850400004)(136003)(376002)(346002)(451199021)(55016003)(9686003)(71200400001)(38070700005)(64756008)(66446008)(66476007)(66556008)(4326008)(66946007)(6916009)(85182001)(7696005)(2906002)(224303003)(76116006)(54906003)(316002)(478600001)(86362001)(6506007)(83380400001)(186003)(38100700002)(122000001)(33656002)(52536014)(5660300002)(4744005)(8936002)(41300700001)(26005)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c3Z4UVk3SEFDRy9HdHVraGNwMXYxaEtiZlVBVFByZXkwTjBHM1VnTDRBSGJL?=
 =?utf-8?B?U2hiZlZscG1ydjUvVFZRYlgybFoyZXJjNnpFbFdMS21vb2RYUzhRNVE3YzBm?=
 =?utf-8?B?RmwyVUlBTldJQWRvWENlTUVDek5MYm9WajdFSVR4cDBHckgvZlBUYVZTTHY1?=
 =?utf-8?B?YmFWNzljNFhGeDIydDJxcHNVTXl5djFIdnkrUW9ndEc3SkJBNE9zTER5SDJP?=
 =?utf-8?B?NDA1M2E4NDlUeEpPMUlDYi9UWUN3WTk3Kzl5Yk5iY2lOckhrUGJJejhUSTR6?=
 =?utf-8?B?ZitZNEdURVFUdlZKbWsxTTZhREZ5ckFsNlJTd3RhR1owRWJFR1pERi9henRP?=
 =?utf-8?B?TUVsbm53emM1V2IwaTRBM2Qxcjdha0s5Q2d2dmFJeFVrdm9SMTQxVldUVC9i?=
 =?utf-8?B?QVdNVnhSSjlnK045S0EzYmkzK3pMTWpTRno3ZHFZNEhXNHY0eUVJZnY3TFZ4?=
 =?utf-8?B?RmpEZkx1QVR5WjVNUmFmdDFNdU9NTHFjRmZPS1Q4ajFiZzE5d25uNUQyQkx1?=
 =?utf-8?B?NThiZ3p2OGdLc2tNWDdlWGF2K0NuazlZS2MxZ2ZSbXVrMDgxa2QxS20vM0kv?=
 =?utf-8?B?RHRpQm96ZUVySzd2MnUraFNUSzVLUzdoaFg4QzJMc1BQaXdkL3RnZ01UaEJD?=
 =?utf-8?B?QmxtbzRlSnNVY25vTHhMcUNMUSsxS2pZbVFodVEwWEFiVmhSMGxMRno2RU9Z?=
 =?utf-8?B?WGhsZTJKTjZWL3ZQWVVFNDJSemFDUkxSVExsMFJuSTlPVTk4V0xIbHVlUG5Y?=
 =?utf-8?B?dFZ5UVdIR0tjUmhzcWZlQkdZSVR3U01VTnE4RGlIS3c1OWlzaW1aSXY2SGpZ?=
 =?utf-8?B?T05Td1J0R0VuSWZTNC80cDZkSzVFNHZjb1NiMUI3MTF4UUtLSEZyTFhLeWhp?=
 =?utf-8?B?VEd4U1huelVJWGNUMXNZMVRObElneTF2ZG9GaVpYbitoSjdmYVhrMjNBaU8z?=
 =?utf-8?B?MmhpUm5TcHJyMEk0bXQrejlFSmZHMWRyNG1pY0lCTHJlSTdRdEJuTFNsS2Zm?=
 =?utf-8?B?bkNTaHNheHF0ZE0vMkVjRUVrYmRKY29udzgyTGhCaENYQ3RjdVg3T2JwSGUw?=
 =?utf-8?B?NjJJazZKRDNSR0lEOXR0M1F6Qm9rN3dHOEJFcFZxRHhuUndMakdtWlFQSTNr?=
 =?utf-8?B?cC9JaTA3bDhpa3pnN2l0WXJzcWlLN0lxRzZGRUZiUXpFeWoxMXEySHBCMXhC?=
 =?utf-8?B?Uno0TStKSWpEbEYwUkJVUEdVcXpIMCtNc0JMaXhTalpDVjhLNnd1RENhZHh3?=
 =?utf-8?B?bWt4UVpJaHZsVVEwVjJpU0xUTC9iV2xSd3BKZHJNSThzSlVMZGgzOTRhN2RF?=
 =?utf-8?B?bHBydC9UQlFRL29uWjdwY09Fa1BoOXJwdUQ5bmM4R09vaEVubU5CQ3VRQ2RZ?=
 =?utf-8?B?TWZieWlMd2p4eHhCZEdrWVA4RHkwV2hpNlhpcFgyUEpPSmcyTlRDTTZZQm9J?=
 =?utf-8?B?QmROa3RTK2trMU0wMGhEZ1p2UktDVjJOdWZnOGlxYlZmS0FPZHJOcDl2ZkND?=
 =?utf-8?B?UTFqYklmVVhoQUMwNUkyWWtMbk1OL1czdzZXNGdLU0M2Sm1IQ3JIREVkTjEw?=
 =?utf-8?B?TjZwTWNaSzNNTXdmNDNTSW9BWG5OZ3QzR2I1ZkJaM29DSHN4RUJPNklJZlpq?=
 =?utf-8?B?eEUwOUNyZ0psNUMvVXpGZWsrdnR6MnlJWDFMN1RBWlk5NlVadkNSRVp5ck9s?=
 =?utf-8?B?RmNSM1dFOHJKbnhWYVg5dTlzeVViQWg3dzZEbm1EQVBYbkZSQVJNNnBxRGJS?=
 =?utf-8?B?VWd5a3BTa2V6a280TzYyeHNKWEIrMEVaWHN3WUtLbmptQlNoSVQ4QVRwdTB0?=
 =?utf-8?B?bUI4TVU1ZjV6b08zbjJGdTQxcHlOd00rMUZhYms2L3NkaUIxK1ErTG5sYnNh?=
 =?utf-8?B?QTRqZXBUU2FkeXhJN29ib3NUQXlKZjN6cWNqSlpTNURFRzVQV0I0NkJ5a0NC?=
 =?utf-8?B?alNVdDBIWTdmbGNkeFk1N3VjSUxIWkdVaE50VHNZdStONXBqeTRsRnhpSHVO?=
 =?utf-8?B?eTEyTTZLRGdIRlVrQWFNSGZiSDFCNytWaktKYWpwZUU2VVgxT0NaR0lsRGh0?=
 =?utf-8?B?cWdWaStWMHFEMElrM1R3ZzIyMU45WUczcXkrRHFWWm1HSW1Rc01BazdVb3JY?=
 =?utf-8?Q?fiP4=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd37cd30-37d4-4369-b2f7-08db8995cbea
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 02:54:26.7234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O4AKfkzkhd/T5tDSA4FwB/WZuUlMbW1ZFybh/gHilFpUl+Oxn0bwiQRSdqyBgfHpzix/rh9uAvxqEnkYf3MdUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4439
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

SGkgTWFyayENCg0KVGhhbmsgeW91IGZvciB5b3VyIHJlcGx5IQ0KWW91IHNhaWQ6DQoNCj4gVGhl
IGluZGVudGF0aW9uIG9uIHRoZSBzZWNvbmQgbGluZSBpcyBtZXNzZWQgdXAgaGVyZSwgaXQncyBm
YXIgdG9vIGluZGVudGVkLg0KDQpDb3VsZCB5b3UgdGVsbCBtZSB3aGF0IGlzIHRoZSBzcGVjaWZp
Y2F0aW9uIGZvciBpbmRlbnRhdGlvbj8NCg0KcmVnYXJkcywNCk1pbmppZQ0KDQotLS0tLS0tLS0t
LS0tLS0tLS0tLQ0K5Y+R5Lu25Lq6OiBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+IA0K
5Y+R6YCB5pe26Ze0OiAyMDIz5bm0N+aciDE55pelIDIwOjQzDQrmlLbku7bkuro6IOadnOaVj+ad
sCA8ZHVtaW5qaWVAdml2by5jb20+DQrmioTpgIE6IFZsYWRpbWlyIE9sdGVhbiA8b2x0ZWFudkBn
bWFpbC5jb20+OyBSaWNoYXJkIENvY2hyYW4gPHJpY2hhcmRjb2NocmFuQGdtYWlsLmNvbT47IG9w
ZW4gbGlzdDpGUkVFU0NBTEUgRFNQSSBEUklWRVIgPGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmc+
OyBvcGVuIGxpc3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBvcGVuIGxpc3Q6UFRQ
IEhBUkRXQVJFIENMT0NLIFNVUFBPUlQgPG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+OyBvcGVuc291
cmNlLmtlcm5lbCA8b3BlbnNvdXJjZS5rZXJuZWxAdml2by5jb20+DQrkuLvpopg6IFJlOiBbUEFU
Q0ggdjFdIHNwaTogZnNsLWRzcGk6IFVzZSBkZXZfZXJyX3Byb2JlKCkgaW4gZHNwaV9yZXF1ZXN0
X2RtYSgpDQoNCk9uIFdlZCwgSnVsIDE5LCAyMDIzIGF0IDA3OjEzOjAyQU0gKzAwMDAsIOadnOaV
j+adsCB3cm90ZToNCg0KPiAtCQlkZXZfZXJyKGRldiwgInJ4IGRtYSBjaGFubmVsIG5vdCBhdmFp
bGFibGVcbiIpOw0KPiAtCQlyZXQgPSBQVFJfRVJSKGRtYS0+Y2hhbl9yeCk7DQo+IC0JCXJldHVy
biByZXQ7DQo+ICsJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgUFRSX0VSUihkbWEtPmNoYW5f
cngpLA0KPiArCQkJCQkJCSJyeCBkbWEgY2hhbm5lbCBub3QgYXZhaWxhYmxlXG4iKTsNCg0KVGhl
IGluZGVudGF0aW9uIG9uIHRoZSBzZWNvbmQgbGluZSBpcyBtZXNzZWQgdXAgaGVyZSwgaXQncyBm
YXIgdG9vIGluZGVudGVkLg0K

