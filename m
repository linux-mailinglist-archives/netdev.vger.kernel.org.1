Return-Path: <netdev+bounces-13850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4D073D5B3
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 04:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBC431C203BF
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 02:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15C27FA;
	Mon, 26 Jun 2023 02:05:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95EF7F6
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 02:05:45 +0000 (UTC)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2065.outbound.protection.outlook.com [40.107.117.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31EA1A6
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 19:05:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9lsnAiT0ozGaC7lMrYSRXfYm9Ey+QXLXV6TVhNV0T33pPwejpxyncIOcqsvHXf2qOqZTq9/sfhk5CiS8J9a3ULDVe1n5scff7B7v17UrdYLT/5kTyqzYWQ9HTdk5f3+rkswbQe+OanIYg/Bi7tPpJSBJZXqLFmHxHWF5g/KSIcGDUdf1L2vKz9z8KkHFTClKiPKqAQXdCOQbMEBoHZSQvLaQoCFMMYdxJBVwpN9VQBfroOjEONs1g3NuPCIQpnuMoJK9EBs/WZbu2SAfAA8RqywB9rd5HPFbiagIVi4QSFXeBjxjM5ABt+NVBT4m6PsJOapR5Xp5FFkzXGiwakYPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tA1LwLJc5TDd+qLODuqJaMzPW5wo/pPOMcrptOZSMwY=;
 b=VOxlmDUPznoXiB6sJrtraeObMjEG8Bq13AFlRWpuXZ0Go7Ep+Z+KOjAbC1HOaKKQkTOj1i9fUpSqQkTX1hCsMQovoQoS1Otb9G6+3zEAxbUQ40EOgvf/2m5YFjWZiKT0v2UN7KFYIjvhKYC2pD2rrglC52bf47X6yh23t+q/B8qkdkzrgQMTzzJp0l5y3ZWwHA3oECRj4mdEZ0sOyvj+dBX1IX7XEuqAL67S6Zzo9e33wjBICKyGX5CSHf+VRrTE4BOjE+b8tjFXguftmZH+mqNldthwQaPdemXqW4hYTavCHWMr7OhbdQA3dKmx/nwwV+JaBo8qkh5PwDHbMWvGGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tA1LwLJc5TDd+qLODuqJaMzPW5wo/pPOMcrptOZSMwY=;
 b=Sbold55c/RFym1iKYZOPppNkNsN5tDEyU4H8TzLEF7cIdOi8QDo/vspAfklLkhuAciO49IuxASv4Tf8hcy3TFbzJ8QWaVsNgmiZjhgKfEzLtj2/BTbt/SEdAF+8m76zUK848Ee6yhWpAsaUJL1Mbbpf7tXgz+KdOZEHxP1RjOxo=
Received: from SG2PR02MB3606.apcprd02.prod.outlook.com (2603:1096:4:34::20) by
 SI2PR02MB4684.apcprd02.prod.outlook.com (2603:1096:4:10e::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.26; Mon, 26 Jun 2023 02:05:35 +0000
Received: from SG2PR02MB3606.apcprd02.prod.outlook.com
 ([fe80::3ffb:69e8:1ca4:2b0b]) by SG2PR02MB3606.apcprd02.prod.outlook.com
 ([fe80::3ffb:69e8:1ca4:2b0b%5]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 02:05:35 +0000
From: "Jinjian Song(Jack)" <Jinjian.Song@fibocom.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Jose Ignacio Tornos Martinez
	<jtornosm@redhat.com>
CC: "bjorn.helgaas@gmail.com" <bjorn.helgaas@gmail.com>, "Minlin He(Reid)"
	<Reid.he@fibocom.com>, "bjorn@helgaas.com" <bjorn@helgaas.com>,
	"haijun.liu@mediatek.com" <haijun.liu@mediatek.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Chongzhen Wang(Rafael)" <rafael.wang@fibocom.com>,
	"somashekhar.puttagangaiah@intel.com" <somashekhar.puttagangaiah@intel.com>
Subject:
 =?gb2312?B?tPC4tDogW3Y1LG5ldC1uZXh0XW5ldDogd3dhbjogdDd4eCA6IFY1IHB0YWNo?=
 =?gb2312?Q?_upstream_work?=
Thread-Topic: [v5,net-next]net: wwan: t7xx : V5 ptach upstream work
Thread-Index: AdmXp0lc6IJADlWQT5iWSDfvOhIbAgALNRCAA4PgOgAAAPGzAAB6gUfw
Date: Mon, 26 Jun 2023 02:05:35 +0000
Message-ID:
 <SG2PR02MB3606473ED18C4A0F105A25B28C26A@SG2PR02MB3606.apcprd02.prod.outlook.com>
References: <20230623150142.292838-1-jtornosm@redhat.com>
 <20230623152844.GA174017@bhelgaas>
In-Reply-To: <20230623152844.GA174017@bhelgaas>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR02MB3606:EE_|SI2PR02MB4684:EE_
x-ms-office365-filtering-correlation-id: a78ad0bd-2b1e-4031-f1bf-08db75e9d455
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 bCVSaZJS1lkdKIa999cEW579tX6kyEzzPAyEjLtYPQiH2f723b+jTMQKpAQLH4fO2Pyhmm5YkFVYJqWQi2fnUATk0aRRfve/oZKwuYOPKAnF4FSAWR8zBm+j096IZLY33YMb/0u729U+dOqLpwBhjJW24RLYKGeTxov3EdbLJuYGXRCkoLKNHlFH8ZvutMeX+EwKcWmw6VT1Y9jWt9taCGBIr6dXjgninuTkJaSIfgGegkAw+P/LDl9uXeOdnkMAAN+cVxWh5bQlV38m3C77tRoKF+xT5AYErTiGHX6wSAVBp2AZJHvnw8aNrqLlQwLFWE7UzA74jgXbI7th+Wlbs7OszRfBRQUu7xoeAN/Q1QJ91are6P7jasntOZA0R7VnDtUMHe4ir1SWD61E04HZ1YG0VqFS0Xl1sG/uxe5qZDGORyLtc82aFOo33Z9Vh4rZkfh+0lS7BrYsaW7C9Jz3dh851rAFd/HuKouiqsM4gZfhvJ3hAadA+VEu2fgP+xtSG4OSuuLsKXDNMhPpgsfGS7Nu6mwpVS4JGmUkjWPzv67SDsMERvMUzBvLrUungIb2i2+l3lsQdXKCJfEAB334FDalP8ltjIgCQTpbchQyLrA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR02MB3606.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(136003)(376002)(39850400004)(451199021)(5660300002)(52536014)(4326008)(76116006)(66946007)(66556008)(66476007)(66446008)(33656002)(64756008)(478600001)(316002)(224303003)(8936002)(38070700005)(2906002)(55016003)(966005)(110136005)(54906003)(86362001)(41300700001)(7696005)(9686003)(6506007)(26005)(186003)(38100700002)(122000001)(71200400001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?NCtXRGhUZ0RHYlZpR2N6YVNlRnRodWx4Rm5UNUNvQlpWYnpGVmdCam5UUHMr?=
 =?gb2312?B?clNTYnVFQlZOcUxTNlNGWmF6ZGg2a1ZPcFpubGliWU5zRTFqallQQXdUWERy?=
 =?gb2312?B?VEZjamQxam9sZnp1QVlvZ1lqZE00OG1HeGRxR2xvN0FlZ3NzNUxOa01tQjVB?=
 =?gb2312?B?aEVDbm40aEVBalNGR0hiMjBrVHA1N01uOHFqNExWazFxbnVlQXZWc0F1Q2cr?=
 =?gb2312?B?QjFzbnBhOWE1VXhlMmMwekdzcVREc3ZFbllraFZRMzNKMUoxVEdQL04vUCtO?=
 =?gb2312?B?SFpIdzhqRldBS3doRHlma0dkcDFkTVc1S1U0WWZ6VFVZU3FBeng2TU9uTFR1?=
 =?gb2312?B?d1p0NmlHbDREbElud2VkY0NFZXhLaHc2eVVGdlR5VFNqNFliNlowbUxHdTdS?=
 =?gb2312?B?T2RwL0J5VHF5d2wzT2g5ZlgxVVhnK0NhR2lUd21IVGZLdStta2phKzhMSlhl?=
 =?gb2312?B?dGFsRTRCZ1lkWkVIRVF0Q3gxTlUyd2xvdFZ1UTBRM29kMjU1MTFMeGRCaDUw?=
 =?gb2312?B?SGNjWnhHNmZlcFZmZzltSmRRNmFMeCtYaHVsTlF5Nlcwalp3aEVKTTI4WEFK?=
 =?gb2312?B?akorbHhoOGEwTUptY0F4QTFlckhLS0xYMUV1b0NoMnlhV1hzdDdNUmt6eW5U?=
 =?gb2312?B?YjF3L2xvNzc5TStXTGhVVi9NVnlWRzFIMzl5LzZCOVNKcklDY2J5eTNOekFC?=
 =?gb2312?B?WldrODllN3lQZjlGSHo2WG5yR3YxZ1FjMVZrUk5qdVQrZ3J3WkllRGtROVdU?=
 =?gb2312?B?ZUh1NTBwd2dmYm4yQlppSGZLRmJaVGlnbElIZkNzMkoveVRCL1IyRGZZaEty?=
 =?gb2312?B?d3hXNkN0MlBBTjFETjNDMllia044UDZvUk5hbnhPTTB3VlgxeVhid3FsYS8w?=
 =?gb2312?B?eThOTm1NM3FjaFRXR05pMmt4ZERadzFlbiszNVJwdGlhRGVkVVpidit3Z1px?=
 =?gb2312?B?K3pRMXl1TWhwN1BFTE5ZR0dsVzFqdjJyS0ovWjlvNW9PQ0d5ZGx4ZWpYSFRL?=
 =?gb2312?B?Rkh6NEE2YzFnQzI3SGJRb0hUN001WVhHelhybHFWZ3JWdExDaXZCOHhNQ2FS?=
 =?gb2312?B?RHBMQkp6aXJOSWJ5RlU5T241TE12b3ZHL2dBU0hpbkhHa1prc0tRd055WWdV?=
 =?gb2312?B?L0UvL29hVkdza3h6UXEvdGFqSXR4b3FRa0txZmdoejBLTm1yOU1FN0pxMjhG?=
 =?gb2312?B?VHZjNlZwVmlaU1laazNuZW9kS1N3ZFcxSTFkZ1h0YTJCT09xNjJsU2dCVTBK?=
 =?gb2312?B?OERFRGk2aGUxUDRkbGZoSjZ1RmdENm5UUHBEdTFHYlRIb00yNVNyaStpTlJ0?=
 =?gb2312?B?Tkt5NmRpZTdxQkFwUzk4eVY2SmY3YlF0ZHVYM24yWUNDZ1I5dlVCdHBleEZ4?=
 =?gb2312?B?TVFXZEhwYW8vdnRNWWJiZXI5bjNoem9XQzU3Q2YzeGdzbEtnaEh4cWFhcW1r?=
 =?gb2312?B?bXhPZXRFdzZkQldqVFhveEFMZUtPZGw1VXl4NVJQS1ZJUWM2eWpLNkZwOGl5?=
 =?gb2312?B?RGJDcHZtYldwNlJsYkJuNGY5RWlLV2tHZzJSTTRKcVdEb3g3TjJKVGVsUnZj?=
 =?gb2312?B?djJJL214VjBvV3hiWjRkdVVGMnRzaDZEM3ZvM3lWWWJPamtSN3VOREkrUSts?=
 =?gb2312?B?R1pBT1ZqWlg3elY5dDVYdGt2WFJxcVlHdmkveUoyQmUvckFmQzFWWjVPR1Uz?=
 =?gb2312?B?cHVUYWV4N01pckNNNFdPMzYyNXlBaUVoZXhOM0NDbFh6Z0V6aEt3aVR1eGpi?=
 =?gb2312?B?a0ZtUzlOQVdVV3lTV21BK3pMenYvVUNobXhabG01SVJiZjV3Uk1GaldjWUFV?=
 =?gb2312?B?NEQrK3hJOUh0MzNPNEx6aHRFOGthL2Z3UEpyOTBFaDJ3VDRFSnhEV0dUZnFL?=
 =?gb2312?B?ajF5UFNXT1lDWE5FTHVsZFRnNkFpcFlyYVFCV3RqQVRvSHZ0MXQ5SXFUSEhP?=
 =?gb2312?B?cUxSSXE3NjI1bUQrQ284dCs5cnY4VTIyck0wM2QzbFI0R0RVblFxM0FuK2Nu?=
 =?gb2312?B?eUIwYWJOM2xhemxUWnB6VE41eDhxRDU5Um52eUtoYTkvWWJkVmpxV1krYk1D?=
 =?gb2312?B?N0xraVJ4cTVQSm1WSlpRSmJMUVdSRG5LVmRLdEVnL1RmWU1DQVBHMlNDYVRh?=
 =?gb2312?Q?nppVkoyHyN2Z8gMTzC51eZCjh?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB3606.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a78ad0bd-2b1e-4031-f1bf-08db75e9d455
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 02:05:35.3210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: il5w4LmvLJdath6YLyWZK4dAZX7uoIKMzmwOGhKw+g0LJ0DMS8Dutg0SubYp/RQFpFVDa5/uYFw4QRsGTJJKOsCcE5OJUsZpFqKTZfD9YPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR02MB4684
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

SGkgQmpvcm4sIEpvc2UNCg0KTGV0IG1lIHNlbmQgYSBwYXRjaCB0aGF0IGNhbiBiZSBkaXJlY3Rs
eSBhcHBsaWVkLiANCg0KVGhhbmtzLg0KDQotLS0tLdPKvP7Urbz+LS0tLS0NCreivP7IyzogQmpv
cm4gSGVsZ2FhcyA8aGVsZ2Fhc0BrZXJuZWwub3JnPiANCreiy83KsbzkOiAyMDIzxOo21MIyM8jV
IDIzOjI5DQrK1bz+yMs6IEpvc2UgSWduYWNpbyBUb3Jub3MgTWFydGluZXogPGp0b3Jub3NtQHJl
ZGhhdC5jb20+DQqzrcvNOiBiam9ybi5oZWxnYWFzQGdtYWlsLmNvbTsgSmluamlhbiBTb25nKEph
Y2spIDxKaW5qaWFuLlNvbmdAZmlib2NvbS5jb20+OyBNaW5saW4gSGUoUmVpZCkgPFJlaWQuaGVA
Zmlib2NvbS5jb20+OyBiam9ybkBoZWxnYWFzLmNvbTsgaGFpanVuLmxpdUBtZWRpYXRlay5jb207
IGt1YmFAa2VybmVsLm9yZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgQ2hvbmd6aGVuIFdhbmco
UmFmYWVsKSA8cmFmYWVsLndhbmdAZmlib2NvbS5jb20+OyBzb21hc2hla2hhci5wdXR0YWdhbmdh
aWFoQGludGVsLmNvbQ0K1vfM4jogUmU6IFt2NSxuZXQtbmV4dF1uZXQ6IHd3YW46IHQ3eHggOiBW
NSBwdGFjaCB1cHN0cmVhbSB3b3JrDQoNCk9uIEZyaSwgSnVuIDIzLCAyMDIzIGF0IDA1OjAxOjQy
UE0gKzAyMDAsIEpvc2UgSWduYWNpbyBUb3Jub3MgTWFydGluZXogd3JvdGU6DQo+IEkgaGF2ZSBh
IHByb3Bvc2FsIGJlY2F1c2UgYXQgdGhpcyBtb21lbnQgd2l0aCB0aGUgY3VycmVudCBzdGF0dXMs
IHQ3eHggDQo+IGlzIG5vdCBmdW5jdGlvbmFsIGR1ZSB0byBwcm9ibGVtcyBsaWtlIHRoaXMgaWYg
dGhlcmUgaXMgbm8gYWN0aXZpdHk6DQo+IFsgICA1Ny4zNzA1MzRdIG10a190N3h4IDAwMDA6NzI6
MDAuMDogW1BNXSBTQVAgc3VzcGVuZCBlcnJvcjogLTExMA0KPiBbICAgNTcuMzcwNTgxXSBtdGtf
dDd4eCAwMDAwOjcyOjAwLjA6IGNhbid0IHN1c3BlbmQNCj4gICAgICh0N3h4X3BjaV9wbV9ydW50
aW1lX3N1c3BlbmQgW210a190N3h4XSByZXR1cm5lZCAtMTEwKSBhbmQgYWZ0ZXIgDQo+IHRoaXMg
dGhlIHRyYWZmaWMgaXMgbm90IHdvcmtpbmcuDQo+IA0KPiBBcyB5dSBrbm93IHRoZSBzaXR1YXRp
b24gd2FzIHN0YWxsZWQgYW5kIGl0IHNlZW1zIHRoYXQgdGhlIGZpbmFsIA0KPiBzb2x1dGlvbiBm
b3IgdGhlIGNvbXBsZXRlIHNlcmllcyBjYW4gdGFrZSBsb25nZXIsIHNvIGluIG9yZGVyIHRvIGhh
dmUgDQo+IGF0IGxlYXN0IHRoZSBtb2RlbSB3b3JraW5nLCBpdCB3b3VsZCBiZSBlbm91Z2ggaWYg
anVzdCB0aGUgZmlyc3QgDQo+IGNvbW1pdCBvZiB0aGUgc2VyaWVzIGlzIHJlLWFwcGxpZWQgKGQy
MGVmNjU2Zjk5NCBuZXQ6IHd3YW46IHQ3eHg6IEFkZCANCj4gQVAgQ0xETUEpLiBXaXRoIHRoYXQs
IHRoZSBBcHBsaWNhdGlvbiBQcm9jZXNzb3Igd291bGQgYmUgY29udHJvbGxlZCwgDQo+IGNvcnJl
Y3RseSBzdXNwZW5kZWQgYW5kIHRoZSBjb21tZW50ZWQgcHJvYmxlbXMgd291bGQgYmUgZml4ZWQg
KEkgYW0gDQo+IHRlc3RpbmcgaGVyZSBsaWtlIHRoaXMgd2l0aCBubyByZWxhdGVkIGlzc3VlKS4N
Cj4gDQo+IEkgdGhpbmsgdGhlIGZpcnN0IGNvbW1pdCBvZiB0aGUgc2VyaWVzIGlzIGluZGVwZW5k
ZW50IG9mIHRoZSBvdGhlcnMgDQo+IGFuZCBpdCBjYW4gYmUgcmUtYXBwbGllZCBjbGVhbmx5LiBM
YXRlciBvbiwgdGhlIG90aGVyIGNvbW1pdHMgcmVsYXRlZCANCj4gdG8gZncgZmxhc2hpbmcgYW5k
IGNvcmVkdW1wIGNvbGxlY3Rpb24gbmV3IGZlYXR1cmVzIGNvdWxkIGJlIGFkZGVkIA0KPiB0YWtp
bmcgaW50byBhY2NvdW50IEJqb3JuJ3MgY29tbWVudHMgKGFuZCBvZiBjb3Vyc2UgdXBkYXRlZCBk
b2MgaWYgbmVlZGVkKS4NCg0KUGxlYXNlIGp1c3QgcG9zdCB5b3VyIHByb3Bvc2FsIHRoZSB1c3Vh
bCB3YXk6IHNlbmQgYSBwYXRjaCB0aGF0IGNhbiBiZSBkaXJlY3RseSBhcHBsaWVkLCBhbmQgc2Vu
ZCBpdCB0byB0aGUgbWFpbnRhaW5lcnMgb2YgdGhlIGZpbGUgYW5kIHRoZSByZWxldmFudCBtYWls
aW5nIGxpc3RzLg0KDQpTaW5jZSBkMjBlZjY1NmY5OTQgYWZmZWN0cyBkcml2ZXJzL25ldC93d2Fu
LCB0aGlzIHdvdWxkIGJlIGhhbmRsZWQgYnkgdGhlIFdXQU4gZm9sa3MuICBGcm9tIGdldF9tYWlu
dGFpbmVycy5wbDoNCg0KICBMb2ljIFBvdWxhaW4gPGxvaWMucG91bGFpbkBsaW5hcm8ub3JnPiAo
bWFpbnRhaW5lcjpXV0FOIERSSVZFUlMpDQogIFNlcmdleSBSeWF6YW5vdiA8cnlhemFub3Yucy5h
QGdtYWlsLmNvbT4gKG1haW50YWluZXI6V1dBTiBEUklWRVJTKQ0KICBKb2hhbm5lcyBCZXJnIDxq
b2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0PiAocmV2aWV3ZXI6V1dBTiBEUklWRVJTKQ0KICAiRGF2
aWQgUy4gTWlsbGVyIiA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD4gKG1haW50YWluZXI6TkVUV09SS0lO
RyBEUklWRVJTKQ0KICBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+IChtYWludGFp
bmVyOk5FVFdPUktJTkcgRFJJVkVSUykNCiAgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9y
Zz4gKG1haW50YWluZXI6TkVUV09SS0lORyBEUklWRVJTKQ0KICBQYW9sbyBBYmVuaSA8cGFiZW5p
QHJlZGhhdC5jb20+IChtYWludGFpbmVyOk5FVFdPUktJTkcgRFJJVkVSUykNCiAgbmV0ZGV2QHZn
ZXIua2VybmVsLm9yZyAob3BlbiBsaXN0OldXQU4gRFJJVkVSUykNCiAgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZyAob3BlbiBsaXN0KQ0KDQpJJ20gY29uZnVzZWQgYWJvdXQgd2hhdCBoYXBw
ZW5lZCB3aXRoIGQyMGVmNjU2Zjk5NCBbMV0uICBHaXQgY2xhaW1zIGl0IGFwcGVhcmVkIGluIHY2
LjEsIGFuZCBJIGRvbid0IHNlZSBhIHJldmVydCBvZiBpdCwgYnV0IEkgZG9uJ3Qgc2VlIHRoZSBj
b2RlIGNoYW5nZXMgaXQgbWFkZSwgZS5nLiwgdGhlIGNoYW5nZXMgdG8gdDd4eF9od19pbmZvX2lu
aXQoKSBbMl0uDQoNCkJqb3JuDQoNClsxXSBodHRwczovL2dpdC5rZXJuZWwub3JnL2xpbnVzL2Qy
MGVmNjU2Zjk5NA0KWzJdIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJu
ZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL2RyaXZlcnMvbmV0L3d3YW4vdDd4eC90N3h4
X2hpZl9jbGRtYS5jP2lkPXY2LjQtcmM3I24xMDYzDQoNCg==

