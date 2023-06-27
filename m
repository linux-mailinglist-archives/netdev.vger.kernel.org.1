Return-Path: <netdev+bounces-14128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B90A373F0C2
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 04:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 869431C20A1B
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 02:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29666A44;
	Tue, 27 Jun 2023 02:15:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB72A23
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 02:15:36 +0000 (UTC)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A8F19AA
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 19:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687832135; x=1719368135;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lGx1/YCX0aG5k4vGJQc61oON8DtlfWXt3v8Ha/Fh6jM=;
  b=JVdDP6F4iQP8CKdRaNJoffjCkMdjp+pYWg2iE88sz4NeJpY4ZSikjMOj
   ZZDUczdqgqb5RMbPBbcFznQMVtH9L3WIt8f6NzzKJySezPHjSeZs0NBl2
   Sn6+XuU6S94emggK0fljTiA3fKPit2bbZC33sMFh0tUdACpicAm7DcFqj
   8QACIrwJTd5/5EaJCNnZjT3/gwhxydMx84/U9DBYDLQOioWHVf3QhhfSy
   0R1qfc3Aw3Js8YcWCDP+k7kQIZzi0HLpensngOQwRbGECQkwKge4mO2z0
   MU5yVtCXmRPl/lZ3SytPgr3TxrfmjkV0gz9OF03ScKCeJVMr2RvkwFdxS
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="220661763"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jun 2023 19:15:34 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 26 Jun 2023 19:15:30 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 26 Jun 2023 19:15:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCw0FroITcbOfyX/JekG8eNLg/kGeDkh3eilFsY03Hz0EOJa0ERZYvjcIrjVqHci/+jqAt5uupSvm21EYYkNst/NxjGT+RBFHAv+C5QIsUwG3gysHV/KtU9wMGmCR745UGZ83UuMXwITtR9ix593AX6aokEZ+FI6mxdNenM6BY3IpQnobNAdnCoklIoV7HyvWEIqSsfB0jGMCBfjoIUGLeF4lWVA+8tldi39SXy6qA8JkOfI2mRzbLAFAK9u/ubOs3joFAr2D/KwMxg/WCSWc1zChXzTn+ZNWK1iJ177uNa1c68vqXrEhAkRqiJ0thrtzcUi1q26rG2eLFhRQXwkog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGx1/YCX0aG5k4vGJQc61oON8DtlfWXt3v8Ha/Fh6jM=;
 b=EhjhtFginFZW/qrlIIRAU+OaP53eUcs0viqmuR3lAhl9nmImW1YaItuwI2f8MHp00KnxcwVC4bIlqRUDx7smv5U///ETlBuMAi8ffAufvyrwrVu+F0HMsyRam2ru7n/FF0aaaPJKLZlNLjORkCGwE+KoxmLDvHehrTti2mwSPOMQ/IjLECkhN5mSTfklJwCto8A/gCTVxOmOZ3LymdH1mUYJRZnVqopqeAvFb/YETMTu/gad3gXLs2fHLgQLwfePfLSo5TfyV1Krv/5cj4rP8WjerncYD2c/CIkANxz0ZBvaW6qJXCTBIWJyKbTGYBSYZ5vQ++OG/d4yFzDkA2Nq7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGx1/YCX0aG5k4vGJQc61oON8DtlfWXt3v8Ha/Fh6jM=;
 b=MYx2vcNE9eD7hA/+V9olx3/MQKp3PIzLHERgTcH7MSOistEQpylc4NJ7qiKQj9QjwfXHkHgFfEfqzWQzD7Ty2wTgM4j58oxpcGIBnuptHMKbqbmVTDiXOasYIheL0sNEsNvEsD1o+vbo4J7r1+BLoY4m1GqJMHSS+mVoaCNqPkA=
Received: from BYAPR11MB3558.namprd11.prod.outlook.com (2603:10b6:a03:b3::11)
 by SA1PR11MB6565.namprd11.prod.outlook.com (2603:10b6:806:250::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Tue, 27 Jun
 2023 02:15:28 +0000
Received: from BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::9617:4881:ecb2:7ce]) by BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::9617:4881:ecb2:7ce%4]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 02:15:28 +0000
From: <Tristram.Ha@microchip.com>
To: <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
	<andrew@lunn.ch>, <f.fainelli@gmail.com>, <davem@davemloft.net>
Subject: RE: [PATCH v3 net-next] net: phy: smsc: add WoL support to
 LAN8740/LAN8742 PHYs
Thread-Topic: [PATCH v3 net-next] net: phy: smsc: add WoL support to
 LAN8740/LAN8742 PHYs
Thread-Index: AQHZpJQzaYXafNPVq0yA1KkEaVytQa+YNu8AgAW57oA=
Date: Tue, 27 Jun 2023 02:15:27 +0000
Message-ID: <BYAPR11MB3558A16BDAC76DDE3453B437EC27A@BYAPR11MB3558.namprd11.prod.outlook.com>
References: <1687388443-3069-1-git-send-email-Tristram.Ha@microchip.com>
 <5d71f0f5dfb2c12b6658e4804af3c364c182dbd5.camel@redhat.com>
In-Reply-To: <5d71f0f5dfb2c12b6658e4804af3c364c182dbd5.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3558:EE_|SA1PR11MB6565:EE_
x-ms-office365-filtering-correlation-id: 429f6da5-8cdc-463a-3371-08db76b46001
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V/1BIo3H7Gk/uwc47hWSshI0uK6+2XgVcBPnewrtoqz7wyiOSaL4P3bvLrJlhdfafZ0scxNAwybC+iAQ77kYLCV7RHFMIEVMtBq50UYwoOyyTnP1ICvmCZThvZ3vTZTWPwMuO4xHTb5KdyFB7idwTxd5Rwg3D72P3J4sjE+J/72B3bHSOlAtZovp1MngVFhKeyx7ENVPSU2q3I4vg48SujqraDlE9nV2vW0cmxVczq49j2f2M2OqLKCu5SW3miaJHfd1wbnO94v4ic8fGYWaWkQbPNoKFFZU/AR0NGVwMlRRlEEg7RVG/bylRzRk/rMpj6BCBRKAebDf1o1kaIz7kxvyRZtqnXixa219Y4QoWwjrcRkTTLGjh+L4dD2ODIcc1itzRSMXci+A017L10nY0Ru31K7U58Ut9AbrBvkS5yihW4dIZk7SVfQUfZOweMMbq4dqdkxx6uFRGIpdvEMM/nbYpszHG38sq4wNy7RuTGNMVbkfQwCIzP3A5kTMD8I7bf+ynCuNsJAWoP45GmW3pe4xa2q3ZbNDQjJ+jOr08dKxJgphp0kyyjUa7DMUnl04pYVmFSHC1IjQk3EtMTTSitT2GacvILLW08hUme9g8mtL9/TI0WwmySKln3S0ErfF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3558.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(346002)(396003)(376002)(451199021)(9686003)(2906002)(7696005)(38100700002)(71200400001)(122000001)(38070700005)(26005)(186003)(55016003)(54906003)(41300700001)(86362001)(478600001)(66476007)(64756008)(66556008)(4326008)(76116006)(6916009)(66446008)(33656002)(66946007)(316002)(6506007)(5660300002)(52536014)(8676002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjJ0cUZueXJTekFpRFVUY3NzOFRUOHRhZFljSm9xYk50cWlNL3dWUXBlS1B1?=
 =?utf-8?B?UHFEcWFCT0lCYmhxYjEvVzVnK2FKUWNzME16SDRxallZWmZzZ3YwdjBzM3Vh?=
 =?utf-8?B?c1pWd0E2S2ZoRXBSZlkxN3U3VEN6aWNyRTdhcHVYVForOHNOTWdvVEdiYXVy?=
 =?utf-8?B?aTFxSjhTOXBqMThkcDFlSXlqVWRmMkpmQVBOZ0NzZFo2RzVwT1A2TWdjZ2p1?=
 =?utf-8?B?S1pJa3IrZVZjQjZ0UUdtWUlpK2xJZGoxUWZEMDQ4QlZ0b0ZMcksvaUYzWU5a?=
 =?utf-8?B?YmhSZnMySzgwaytaNEVNY3JxMXZoSHl6Y0NwLzNXZXhTMEZ5aERQUWhySmJI?=
 =?utf-8?B?aUpZNDJsVlN5TkI1R1FsY3U5YVJGaE1WbUlULzJObnVvVHcrSDhxc09ab0J4?=
 =?utf-8?B?N2dFN21NYlpxZkRjbWhNa1FtQzUrcW51dENzSHVNeUVQSFAxTzlLREhUQysy?=
 =?utf-8?B?bEI2MFA0MGtIU1FjUXJFcUpHa2RBcDEzNWwxMzNxWStIMG5xRWdEODBOeWhM?=
 =?utf-8?B?eDdDOHBLRmFiampvNTV6UmE2NHRQSEQ2Zng4dTc1VXRLYSs0bEx5QVhDTUxH?=
 =?utf-8?B?ZTAyQW41cUE2cm9PbmtSM2J5a2kzUG1BcWEveEZ5MG56anZ1M1BBa0ROU3lk?=
 =?utf-8?B?d1ZWV1d6ODh0MjBqMUpiSVRqcmlFNUsxV3J4UTc4c0Yvejd4bE4zY1RkZmxo?=
 =?utf-8?B?OE9SVTRFR0hkS0grY3FxOWJJM3dmb1NZTlFKakFqay91QzdoMFltTGNSNFZI?=
 =?utf-8?B?aEZ0V0NRaTNSWWdnNVJkdnltSXl6Qklqd3hlYVVCVCtOSkRNL05tbTRrb3Zy?=
 =?utf-8?B?UTQycS9CRHp2c2QzdmhxUkQ2Mm50NVlqcCtUcVBQSStSZnl2MnBHOTNqYmRn?=
 =?utf-8?B?Qjd4dmpIcVZVK3M5T2VyU2Q3eE1Lb1NTVHFhNGRrdXFXT05DbWtLc21YbjRG?=
 =?utf-8?B?L3hENnpjbTdVMDVwbmQzYWszcVNqY0tGK3RNTU5JOFZhOTdRVFY0M2h1Nm1T?=
 =?utf-8?B?NlBsNU9PaWNZbFFWU1RpRmJvVGpuS0xDNnRFVndSVVAxRWtVbzF0Z3FZWEhN?=
 =?utf-8?B?MVVpN2tLamtKaXh0L3BoMGZOUSs4WG1Way9FTjFMWFZVa0FkakRnU2lOK0Z3?=
 =?utf-8?B?OFdTYUozb2RXd0VTdGVqelZDbmhoa2xuMmVwOHJnWXQrWkx3Zm83STBwa3d5?=
 =?utf-8?B?R01vRysxbE1TOWV2VGdTV1h4YjAzcVpEWmpCSlFGZVRJZ2p2ckgzVGJMY0pQ?=
 =?utf-8?B?Ti9zY2c4Qjh1WGFuRFEvdkYyVmFYeTRydVFtWUtCa2kvMDQ4dUJHeHpOUkN4?=
 =?utf-8?B?YjJhRStwdGo5M0dwbmJJUGlNNXlrWXBRRnhqT3Fwc2NhUGptM1hqUmU2SWFK?=
 =?utf-8?B?cVJhNE42eHljSHVQaGM0S1JDc1ZqeVFnOWd4RncvOWVxSVpPQ2Q1VVdOT3p1?=
 =?utf-8?B?b0Z3M1dBL1d0SXVHWFhLSk9qY0h3OXhqUFZoU08yTk5HZTJOcHF3d252dDZo?=
 =?utf-8?B?TGplV05nd2tIMXFrUlV1WlR3ODBEaWJvWTJLUkNsL2VYUUdaY0VwbTFwOEpR?=
 =?utf-8?B?YkkvWG1lczJzUyt0N3FEdHVQMDkyZUtWWjlBcnl2V1dadG84S25JeXYyT21r?=
 =?utf-8?B?elBmUGx0MCs3WEVBVXA1cEFMRFB0QVdXSFdTVzJTdzZUNHZWMURaTVY4ZzNG?=
 =?utf-8?B?dnRPNEdUSDVyUEdYUS8vNEcxc3NJc2xLLzl1QnZoVzhWVlV0UHN2bDJxa0xB?=
 =?utf-8?B?cUxKZ2VFRHdwSHZ4bnlGWXYvcy9SRnFiSjZST1pkQlVBL2VOam9sWTBHYmVJ?=
 =?utf-8?B?cUdQUWNlL0NJdzlvZ3M5K2ZQbVFidkU4aWd0VXZQdkZlV0I4elFrR29XMkty?=
 =?utf-8?B?QVY0SFppUnlwcVpCZEMzNi8yN05STlVIVnRydFpSR2ZzMDA3clBaL1B3VU1V?=
 =?utf-8?B?U0NlS1BHd0F2K0gwRjFPa0JteHpuUHhuWG5DNkh1MEo5YlUyWEtTaVplYWRp?=
 =?utf-8?B?QkMzZk9xOUxLbnZpVkVvd1hBaGRDZ1BDYnQwK1JONHc3SmhjWHBtUVMxdHJS?=
 =?utf-8?B?L1h4ZVFWUkN3Qk9Pd0F3TUJFN29ac2Z5LzN1cXBhc3VDc0N3RnJpdGxnNXNV?=
 =?utf-8?Q?1gt25Zv9yS3hTnZupw+B73CCr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3558.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 429f6da5-8cdc-463a-3371-08db76b46001
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 02:15:27.9857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PLjjoAvFn0pLPLiPY9D1abKeqMARdHgn+6PoBU2uIvTnefu4/7j6OTrcdCyvXjB9cXzO0dsIQpeS0ipHU/HPMlGZofs1vYBEoovMIBfKlLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6565
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PiA+IEBAIC0yNTgsNiArMjY1LDI0OSBAQCBpbnQgbGFuODd4eF9yZWFkX3N0YXR1cyhzdHJ1Y3Qg
cGh5X2RldmljZSAqcGh5ZGV2KQ0KPiBbLi4uXQ0KPiA+ICtzdGF0aWMgaW50IGxhbjg3NHhfY2hr
X3dvbF9wYXR0ZXJuKGNvbnN0IHU4IHBhdHRlcm5bXSwgY29uc3QgdTE2ICptYXNrLA0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHU4IGxlbiwgdTggKmRhdGEsIHU4ICpkYXRh
bGVuKQ0KPiANCj4gSSB0aGluayBpdCB3b3VsZCBiZSBuaWNlIGFkZGluZyBzb21lIGNvbW1lbnRz
IGhlcmUgZGVzY3JpYmluZyB0aGUNCj4gaW1wbGVtZW50ZWQgbG9naWMsIGZvciBmdXR1cmUgbWVt
b3J5Lg0KPiANCj4gDQo+ID4gK3sNCj4gPiArICAgICBzaXplX3QgaSwgaiwgazsNCj4gPiArICAg
ICBpbnQgcmV0ID0gMDsNCj4gPiArICAgICB1MTYgYml0czsNCj4gPiArDQo+ID4gKyAgICAgaSA9
IDA7DQo+ID4gKyAgICAgayA9IDA7DQo+ID4gKyAgICAgd2hpbGUgKGxlbiA+IDApIHsNCj4gPiAr
ICAgICAgICAgICAgIGJpdHMgPSAqbWFzazsNCj4gPiArICAgICAgICAgICAgIGZvciAoaiA9IDA7
IGogPCAxNjsgaisrLCBpKyssIGxlbi0tKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIC8q
IE5vIG1vcmUgcGF0dGVybi4gKi8NCj4gPiArICAgICAgICAgICAgICAgICAgICAgaWYgKCFsZW4p
IHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvKiBUaGUgcmVzdCBvZiBiaXRt
YXAgaXMgbm90IGVtcHR5LiAqLw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlm
IChiaXRzKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0g
aSArIDE7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgIH0NCj4gPiArICAgICAgICAgICAgICAgICAgICAgaWYgKGJpdHMg
JiAxKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRhdGFbaysrXSA9IHBhdHRl
cm5baV07DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGJpdHMgPj49IDE7DQo+ID4gKyAgICAg
ICAgICAgICB9DQo+ID4gKyAgICAgICAgICAgICBtYXNrKys7DQo+ID4gKyAgICAgfQ0KPiA+ICsg
ICAgICpkYXRhbGVuID0gazsNCj4gPiArICAgICByZXR1cm4gcmV0Ow0KPiA+ICt9DQo+IA0KPiBb
Li4uXQ0KPiANCj4gPiArc3RhdGljIGludCBsYW44NzR4X3NldF93b2woc3RydWN0IHBoeV9kZXZp
Y2UgKnBoeWRldiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGV0aHRvb2xf
d29saW5mbyAqd29sKQ0KPiA+ICt7DQo+ID4gKyAgICAgc3RydWN0IG5ldF9kZXZpY2UgKm5kZXYg
PSBwaHlkZXYtPmF0dGFjaGVkX2RldjsNCj4gPiArICAgICBzdHJ1Y3Qgc21zY19waHlfcHJpdiAq
cHJpdiA9IHBoeWRldi0+cHJpdjsNCj4gPiArICAgICB1MTYgdmFsLCB2YWxfd3Vjc3I7DQo+ID4g
KyAgICAgdTggZGF0YVsxMjhdOw0KPiA+ICsgICAgIHU4IGRhdGFsZW47DQo+ID4gKyAgICAgaW50
IHJjOw0KPiA+ICsNCj4gPiArICAgICBpZiAod29sLT53b2xvcHRzICYgV0FLRV9QSFkpDQo+ID4g
KyAgICAgICAgICAgICByZXR1cm4gLUVPUE5PVFNVUFA7DQo+ID4gKw0KPiA+ICsgICAgIC8qIGxh
bjg3NHggaGFzIG9ubHkgb25lIFdvTCBmaWx0ZXIgcGF0dGVybiAqLw0KPiA+ICsgICAgIGlmICgo
d29sLT53b2xvcHRzICYgKFdBS0VfQVJQIHwgV0FLRV9NQ0FTVCkpID09DQo+ID4gKyAgICAgICAg
IChXQUtFX0FSUCB8IFdBS0VfTUNBU1QpKSB7DQo+ID4gKyAgICAgICAgICAgICBwaHlkZXZfaW5m
byhwaHlkZXYsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAibGFuODc0eCBXb0wgc3Vw
cG9ydHMgb25lIG9mIEFSUHxNQ0FTVCBhdCBhIHRpbWVcbiIpOw0KPiA+ICsgICAgICAgICAgICAg
cmV0dXJuIC1FT1BOT1RTVVBQOw0KPiA+ICsgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgcmMgPSBw
aHlfcmVhZF9tbWQocGh5ZGV2LCBNRElPX01NRF9QQ1MsDQo+IE1JSV9MQU44NzRYX1BIWV9NTURf
V09MX1dVQ1NSKTsNCj4gPiArICAgICBpZiAocmMgPCAwKQ0KPiA+ICsgICAgICAgICAgICAgcmV0
dXJuIHJjOw0KPiA+ICsNCj4gPiArICAgICB2YWxfd3Vjc3IgPSByYzsNCj4gPiArDQo+ID4gKyAg
ICAgaWYgKHdvbC0+d29sb3B0cyAmIFdBS0VfVUNBU1QpDQo+ID4gKyAgICAgICAgICAgICB2YWxf
d3Vjc3IgfD0gTUlJX0xBTjg3NFhfUEhZX1dPTF9QRkRBRU47DQo+ID4gKyAgICAgZWxzZQ0KPiA+
ICsgICAgICAgICAgICAgdmFsX3d1Y3NyICY9IH5NSUlfTEFOODc0WF9QSFlfV09MX1BGREFFTjsN
Cj4gPiArDQo+ID4gKyAgICAgaWYgKHdvbC0+d29sb3B0cyAmIFdBS0VfQkNBU1QpDQo+ID4gKyAg
ICAgICAgICAgICB2YWxfd3Vjc3IgfD0gTUlJX0xBTjg3NFhfUEhZX1dPTF9CQ1NURU47DQo+ID4g
KyAgICAgZWxzZQ0KPiA+ICsgICAgICAgICAgICAgdmFsX3d1Y3NyICY9IH5NSUlfTEFOODc0WF9Q
SFlfV09MX0JDU1RFTjsNCj4gPiArDQo+ID4gKyAgICAgaWYgKHdvbC0+d29sb3B0cyAmIFdBS0Vf
TUFHSUMpDQo+ID4gKyAgICAgICAgICAgICB2YWxfd3Vjc3IgfD0gTUlJX0xBTjg3NFhfUEhZX1dP
TF9NUEVOOw0KPiA+ICsgICAgIGVsc2UNCj4gPiArICAgICAgICAgICAgIHZhbF93dWNzciAmPSB+
TUlJX0xBTjg3NFhfUEhZX1dPTF9NUEVOOw0KPiA+ICsNCj4gPiArICAgICAvKiBOZWVkIHRvIHVz
ZSBwYXR0ZXJuIG1hdGNoaW5nICovDQo+ID4gKyAgICAgaWYgKHdvbC0+d29sb3B0cyAmIChXQUtF
X0FSUCB8IFdBS0VfTUNBU1QpKQ0KPiA+ICsgICAgICAgICAgICAgdmFsX3d1Y3NyIHw9IE1JSV9M
QU44NzRYX1BIWV9XT0xfV1VFTjsNCj4gPiArICAgICBlbHNlDQo+ID4gKyAgICAgICAgICAgICB2
YWxfd3Vjc3IgJj0gfk1JSV9MQU44NzRYX1BIWV9XT0xfV1VFTjsNCj4gPiArDQo+ID4gKyAgICAg
aWYgKHdvbC0+d29sb3B0cyAmIFdBS0VfQVJQKSB7DQo+ID4gKyAgICAgICAgICAgICB1OCBwYXR0
ZXJuWzE0XSA9IHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgMHhGRiwgMHhGRiwgMHhGRiwg
MHhGRiwgMHhGRiwgMHhGRiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgMHgwMCwgMHgwMCwg
MHgwMCwgMHgwMCwgMHgwMCwgMHgwMCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgMHgwOCwg
MHgwNiB9Ow0KPiA+ICsgICAgICAgICAgICAgdTE2IG1hc2tbMV0gPSB7IDB4MzAzRiB9Ow0KPiA+
ICsgICAgICAgICAgICAgdTggbGVuID0gMTQ7DQo+IA0KPiAnbGVuJyBpcyBuZXZlciBjaGFuZ2Vk
LCB5b3UgY291bGQgdXNlIGluc3RlYWQgc29tZSBtYWNybyB3aXRoIGENCj4gbWVhbmluZ2Z1bCBu
YW1lLg0KPiANCj4gPiArDQo+ID4gKyAgICAgICAgICAgICByYyA9IGxhbjg3NHhfY2hrX3dvbF9w
YXR0ZXJuKHBhdHRlcm4sIG1hc2ssIGxlbiwgZGF0YSwNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgJmRhdGFsZW4pOw0KPiA+ICsgICAgICAgICAgICAgaWYg
KHJjKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBwaHlkZXZfZGJnKHBoeWRldiwgInBhdHRl
cm4gbm90IHZhbGlkIGF0ICVkXG4iLCByYyk7DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgLyog
TmVlZCB0byBtYXRjaCBicm9hZGNhc3QgZGVzdGluYXRpb24gYWRkcmVzcy4gKi8NCj4gPiArICAg
ICAgICAgICAgIHZhbCA9IE1JSV9MQU44NzRYX1BIWV9XT0xfRklMVEVSX0JDU1RFTjsNCj4gPiAr
ICAgICAgICAgICAgIHJjID0gbGFuODc0eF9zZXRfd29sX3BhdHRlcm4ocGh5ZGV2LCB2YWwsIGRh
dGEsIGRhdGFsZW4sIG1hc2ssDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGxlbik7DQo+ID4gKyAgICAgICAgICAgICBpZiAocmMgPCAwKQ0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICByZXR1cm4gcmM7DQo+ID4gKyAgICAgICAgICAgICBwcml2LT53b2xf
YXJwID0gdHJ1ZTsNCj4gPiArICAgICB9DQo+ID4gKw0KPiA+ICsgICAgIGlmICh3b2wtPndvbG9w
dHMgJiBXQUtFX01DQVNUKSB7DQo+ID4gKyAgICAgICAgICAgICB1OCBwYXR0ZXJuWzZdID0geyAw
eDMzLCAweDMzLCAweEZGLCAweDAwLCAweDAwLCAweDAwIH07DQo+ID4gKyAgICAgICAgICAgICB1
MTYgbWFza1sxXSA9IHsgMHgwMDA3IH07DQo+ID4gKyAgICAgICAgICAgICB1OCBsZW4gPSAwOw0K
PiANCj4gU2FtZSBoZXJlLCBidXQgbm93ICdsZW4nIGlzIDAsIHdoaWNoIG1ha2VzIHRoZSBmb2xs
b3dpbmcNCj4gbGFuODc0eF9jaGtfd29sX3BhdHRlcm4oKSBhIG5vLW9wLiBXYXMgJzMnIGluIHRo
ZSBpbml0aWFsIHJldmlzaW9uLCBpcw0KPiB0aGUgYWJvdmUgYW4gdW5pbnRlbnRpb25hbCBjaGFu
Z2U/IT8gT3RoZXJ3aXNlIGl0IHdvdWxkIGJlIGNsZWFyZXINCj4gYXZvaWQgdGhlIGxhbjg3NHhf
c2V0X3dvbF9wYXR0ZXJuKCkgY2FsbC4NCg0KQW5vdGhlciBwYXRjaCB3aWxsIGJlIHN1Ym1pdHRl
ZCB0byBhZGRyZXNzIHlvdXIgaXNzdWVzLg0KDQo=

