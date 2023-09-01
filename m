Return-Path: <netdev+bounces-31727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6ECC78FC4E
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 13:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F9E2281A36
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 11:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8150FAD22;
	Fri,  1 Sep 2023 11:32:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A9E2CA6
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 11:32:12 +0000 (UTC)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0106710E4
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 04:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1693567924;
  x=1725103924;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=x33oJWQIr2H47dS6tU7xc+Mtb38yUoslPBw/SYuOtHE=;
  b=P+GPB6d6t/N7anJFKkxPnSK2ET10kAIj4PoaifWl9NNdXdtphzTFPbQs
   q+aVq8hUvElGSeDAFZM7JCRpGxzFoTGU/jFvPdMdaqFC00MHiL9LR0GrU
   rFo7DwVyh64I4bY7v4On/3SU+TybEB07IuKcAObKP5Ljq0430upZOjnG9
   82hFosVVSfeE30ZH2JC0DQiDhlElsUv+upLUjmFclWuF+Eoan4Y2nOUdC
   oTInOrlDpEsHkQhffTVtWifUCvGB8BhDJ8qmcMJVi0saGQc/Sgd6S+8/g
   ARf7bakbYGnzfhyFrP+UkRPHjUv2MXGPlwpt95SsqlDIuPS7HVyIS6dC3
   g==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ws25k8vePBONZB/f2TEV0ZbtJGo9TqIjKNQCgs4TMFJSljICgKWHQmSC6V7YdRx9606yOOULoW8HGW36W5k3595mLg/A2kFwbTCO/AuzkBX/GClWITzlZ/fLmrm9HCSwXxY4uQZT8zzaR0wzUlSY2XdmjFjtD0xsrebwmt42wbS5p/RWkwu1Kq+xXDs1ULEVX1iWnlsSsrCte9/+JRUffdcGQxWoSJU1lBxitrR31JXcnE+rPEATj1ukOgkyU75j745k3bH7YD6xbUUGIROD+jcyA16vkigz4I8kALnZgiNP/VuAEx+95AOiq0K3G51Tozi0lafmjWpef2limX6iHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x33oJWQIr2H47dS6tU7xc+Mtb38yUoslPBw/SYuOtHE=;
 b=kFO59YcgUb1OEbWXJ4RZ/wWPM4QkpFDZA4IFRxHDOOyEkycsqvLNAeFAvrFzrAjbGeACEy/ldtwtlaA1qd34M1nlB550Z8kF/hCcjb1GGv3dKvNl1e9zl+ggzP1FUysDiYHe1TL8rxmSA3JEfT+5pcpbCv9zjj5FOjXs6k7ACPQb/w0/FLHW2pG/ZgVPuM8k6tSdiTVlmOzL3crcfWwa/9TldQjVH/HqRsR/v6yqteuuvbtbDHZiMN/ae56IK89CCgJxJMVagJR/nKKWAOauZ2mszIIrF8xxBEByn+pmH9YEex5Ohj4/TX6BxQMhrUvICEIQgKDR/3M9otZxM6374g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x33oJWQIr2H47dS6tU7xc+Mtb38yUoslPBw/SYuOtHE=;
 b=iM7co3LDrnvqEXeZ4Oj46VQdQ7ylAky9D+ba5kAg7eE2PQM1pfB+uEb35PxvsS1BS4wLaF55u+p/i/5nkKmAbPtB5Mm1JofR6eM833sJE1LWgbYSMeCqRYUTCPxxYzK+hkUQpzBHZyxBCpAFxymU2Cv7XNQ90OXjS+53VwQnIKc=
From: Vincent Whitchurch <Vincent.Whitchurch@axis.com>
To: "nbd@nbd.name" <nbd@nbd.name>, "joabreu@synopsys.com"
	<joabreu@synopsys.com>, Vincent Whitchurch <Vincent.Whitchurch@axis.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
	"peppe.cavallaro@st.com" <peppe.cavallaro@st.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, kernel
	<kernel@axis.com>
Subject: Re: [PATCH net] net: stmmac: Use hrtimer for TX coalescing
Thread-Topic: [PATCH net] net: stmmac: Use hrtimer for TX coalescing
Thread-Index: AQHWv04gJ8ZamJtkVky0JUyVF0YJta/+f16AgAK1/wCAAEHkAIAHrjMAgABnkwCAAoQyAA==
Date: Fri, 1 Sep 2023 11:31:59 +0000
Message-ID: <a583c9fae69a4b2db8ddd70ed2c086c11456871a.camel@axis.com>
References: <20201120150208.6838-1-vincent.whitchurch@axis.com>
	 <732f3c01-a36f-4c9b-8273-a55aba9094d8@nbd.name>
	 <2e1db3c654b4e76c7249e90ecf8fa9d64046cbb8.camel@axis.com>
	 <a4ee2e37-6b2f-4cab-aab8-b9c46a7c1334@nbd.name>
	 <f3c70b8e345a174817e6a7f38725d958f8193bf1.camel@axis.com>
	 <8a2d04f5-7cd8-4b49-b538-c85e3c1caec9@nbd.name>
In-Reply-To: <8a2d04f5-7cd8-4b49-b538-c85e3c1caec9@nbd.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.38.3-1+deb11u1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR02MB10280:EE_|VI1PR02MB6141:EE_
x-ms-office365-filtering-correlation-id: 35c03e3e-ac26-44fe-d671-08dbaadf0df9
x-ld-processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4mW3Bg4GckFUWAkoHqXHRz00AVY58iU6Lgan0BJNNcnN3lx4nsyzqVKVjwVhfklocDtSWaCWJl0LIInb2qz4VN5NrRpyoY9OXAZN6NWg89+GL1DvKAVMJhOSxP6R9AMRGzECYDZKFnRsUiM8Jr/aLtmNBY3R3Txj+n0nERjBT5TlQ25IEa3KB28lA7N86J9NPKKVjimOnawmm0dUH+/DxC8cDGYuA/ejxhWlCbMjwT/nXTYbQrihEC46mXQ8aCRqR9ZjcmLZP6FVlWoh5dfXJUfb8/07JgkbwWXfy7Wz84/10MUlZ3Fed/WxTr7ix1Xq2PpkrGKadheReiC4xK/JeaV07ebmI8ttl+5lwdloH6lMZ8c6DCYwRIIqdnO+8j58ekHcm6Uizoc8GUrVgBc+WJnMGmAzXTvb+L8pYfsae1+6sCdtep5IgplBElYLaZW1HaU4FB1ElJWtgNcYPGY2U2lvgus1jhH2GuQJqozDodIz/gQtD5ms2m6mm17RkS4ZeXVt/g6mFBo55oAYA4KVw3iUTBNwp3JJajolRgggiM6qbsEsx0Ei+/rjnz/qQpYJnZZtv2LJ1H1maTc2aKrx7Yz67/zWzrB7mAUO1U4uDKAMJszJBCi71EUCqbl0yiiR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR02MB10280.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39850400004)(366004)(376002)(136003)(396003)(1800799009)(186009)(451199024)(6506007)(6486002)(53546011)(6512007)(66899024)(71200400001)(83380400001)(122000001)(86362001)(38070700005)(38100700002)(36756003)(26005)(2616005)(107886003)(41300700001)(2906002)(91956017)(110136005)(76116006)(66446008)(66476007)(66556008)(66946007)(64756008)(54906003)(8676002)(8936002)(4326008)(316002)(478600001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWkraGlOSld0ZmxwU29MVGdjQ1pyblFza3B2RkRXSGo0eS9nYm44ZkFSYmZ6?=
 =?utf-8?B?MlhUdDRFSFhWdnlrdEx5aU5KZXB5dG5lMXNPVmsybWZLTDNDK1p3ZFMvZnVV?=
 =?utf-8?B?ZFM3TnVVOTNMcTFTcFpabmtHN0FVcnl0RjVGb2dEWTNlU21WeW52Q3pyUDk4?=
 =?utf-8?B?SWlOdzJ4UFhnem5hcVF1M1ZpdjNEVGlFeVV1SGNCUVRSaGQ2dGZmV0lWZDhQ?=
 =?utf-8?B?Z2FrOHA2ZVRNMjgrdUZUMVdQZEhjOFhBeEhPdXhGTmkrQkVUWm1LaUwrNjhT?=
 =?utf-8?B?UUJ3WVhsditWZHBsU1hkTVJjWGhNQ1ViWGJaZ3psdUF0b1Z6Sk5UQ0tIVnM2?=
 =?utf-8?B?YmlVVGVkY0NmYUU3VHNtd0NlMVhGd2o5RGRDR0dON01JZUd2YVRscHlUbWJ0?=
 =?utf-8?B?ZnRlb1lMQWJCTzBrL2QyNnlGc05Rdk1FamNZYnRUTGNtYkMwZHV3MlE0RmJa?=
 =?utf-8?B?SkJScjNFZWxXN1hQaG5WYzFYZUNOK3ZOOHNBVG9jRzJieFp6RDNJTk1KZWZP?=
 =?utf-8?B?K2U1R25FZzVTdVZHUk5ITDR2SnNaQ0V4by80dnA1OTYvREl3L0s1bG5ZQ3Q5?=
 =?utf-8?B?ZVA1ZUdCUVdZZXNPekgvdk5zN2g5WmVmMGV2V0ZhSXV0VnY3emtMbERQS1Bv?=
 =?utf-8?B?aFVmSUJFeW85ODNGQzNwajF0K2VEMnd5SGk5R0J6S0Z6SEx2SzBMQ0FYeW1j?=
 =?utf-8?B?K0dteUJEcG0yWlRhMjMwU0NjRUUzaFdsRVRMcVpEeTg0bnFPSWdlbXB0ejF6?=
 =?utf-8?B?bkg5R1JDajlQNmIybUZkcmVMclMyck8wRFpjYnJLM3hKa3pUMUJyRWU4NER1?=
 =?utf-8?B?cnZRaFZjQmZKZ1RaemV6ek5ZTGkwa29xMThBWjJBRURiaGtwWTZvWXNONm5q?=
 =?utf-8?B?ZzdLNWVudFB2K00xMCs5V0IwVk81K1JPNFo5NlJJbVV1Z05QR3Q0VDQyWTYw?=
 =?utf-8?B?S3NnVmFxQ0NrVi9ZZzhrRWhqR1k3UHU1U0F6MCtjc3JmWm9VMzhFSU5QSmhD?=
 =?utf-8?B?N2ZjZDBNcDlEdHdza05ETytjc1AzdWVxKzA4Nm9XckZ2Qm8zTVR4Unl0Rnds?=
 =?utf-8?B?ckQ3UmRlZ3BlMi9mYjZDMlN0Nk1McWhoSEsyYTRuTk54eEJ2d212TDI0SDJK?=
 =?utf-8?B?WkRsWTdwdmxFQnpiUzIrM2FOZ1p5aVpzeFdTU2x2WXRXQXF5dFdQbTZQWUlM?=
 =?utf-8?B?SWNVdlNEaFlOTEdidkFpUXU1WlR3OWJ1Q3pmQ2tZRzk3TGNxclE2S1dBcXRy?=
 =?utf-8?B?dVB4SktCb0Z6OUpWUEtoT3JsS2hKTm9YYTBVSDRTTmtySUkrWEgzalNtekk2?=
 =?utf-8?B?SEYrVXRGSWVnQk5kVHpDQUp3d2c3V1lPcTMxdTBQSG8xQnJ3UFdML3d4K0lS?=
 =?utf-8?B?TG12NG50OFBQTzh2NlFRcm5KNHUrUWQ4K00rWWpzRjIyZklZblAvdnlJWmdE?=
 =?utf-8?B?dXA2WFlGS3Z0eG1xYTRWQmtNS2w4SjZoSXhHRTFXeUxHdEY1aTZXUkZhenNZ?=
 =?utf-8?B?aVZvWTYxZ2I2K3p4TmNFazF4ZjVQdW5JZDdha0FGYVRkbGs2RVY5cWNraDBZ?=
 =?utf-8?B?Q252NEc0c0tVTllsN0o2MzFWQVJJRDUvell4SmI0SjUxMThFekhRblFRZFQr?=
 =?utf-8?B?NlZPRTEvbDdBWnRxaG5uRVlXZ1N5U0d2R3ZraHhvcXkxOUlZN2VzYlVKSnFM?=
 =?utf-8?B?S2ZQai9oNElmYmJrQ1pBZFVrWktWQW5TenhSbFNWbjBTOVIyN1RhdGR5enFz?=
 =?utf-8?B?SlA1d0k0Y0ltMVR4WEczZEJYM0hzY0NJeW1sN1RGbE1nNis4T1d2NHphOXNX?=
 =?utf-8?B?elpyZldraTZxb05mRmt3aTFsYjFadkhXd0MrRWVpcmhBMGVETmVOZkNsUTZD?=
 =?utf-8?B?bGNGeVlzWjRNWk9EQW9NNUs3MlJFMXlBWU5XVDAwN1lpakNITFN0QjgxZ21F?=
 =?utf-8?B?SXAvQ2FEaEt0TU9vS3ZvdCs5SUQ5QWllYUZGTjhqS296bHkzS2daOUN5UkFG?=
 =?utf-8?B?ZDJsM1RPSlN2OXZ4ZmhkbXR4ck9WUS9kZy82V3Y2TkpQMnRRZmRvc0FwZXhK?=
 =?utf-8?B?RUxaaEtpcW9MWEJtQjVVOXV6Wi85S2ozdFVqblpwNmJOY0lHd0lya09ZTVpH?=
 =?utf-8?Q?cf7ySk8b780tVE7A6ljocWePF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3489DA066BA5246AEB1919F9B835204@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR02MB10280.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c03e3e-ac26-44fe-d671-08dbaadf0df9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2023 11:31:59.1700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VkCManKgV0E/1WHoGSw5uucCdmFmyj93HWmajEmo/WNZalkYDNLNgbchCaS6lRcC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6141
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

T24gV2VkLCAyMDIzLTA4LTMwIGF0IDIzOjA2ICswMjAwLCBGZWxpeCBGaWV0a2F1IHdyb3RlOg0K
PiBPbiAzMC4wOC4yMyAxNjo1NSwgVmluY2VudCBXaGl0Y2h1cmNoIHdyb3RlOg0KPiA+IEkgbG9v
a2VkIGF0IGl0IHNvbWUgbW9yZSBhbmQgdGhlIGNvbnRpbnVvdXMgcG9zdHBvbmluZyBiZWhhdmlv
dXIgc3RyaWtlcw0KPiA+IG1lIGFzIHF1aXRlIG9kZC4gIEZvciBleGFtcGxlLCBpZiB5b3Ugc2V0
IHR4LWZyYW1lcyBjb2FsZXNjaW5nIHRvIDAgdGhlbg0KPiA+IGNsZWFudXBzIGNvdWxkIGhhcHBl
biBtdWNoIGxhdGVyIHRoYW4gdGhlIHNwZWNpZmllZCB0eC11c2VjcyBwZXJpb2QsIGluDQo+ID4g
dGhlIGFic2VuY2Ugb2YgUlggdHJhZmZpYy4gIEFsc28sIGlmIHdlJ2QgaGF2ZSB0byBoYXZlIGEg
c2hhcmVkDQo+ID4gdGltZXN0YW1wIGJldHdlZW4gdGhlIGNhbGxlcnMgb2Ygc3RtbWFjX3R4X3Rp
bWVyX2FybSgpIGFuZCB0aGUgaHJ0aW1lcg0KPiA+IHRvIHByZXNlcnZlIHRoaXMgY29udGludW91
cyBwb3N0cG9uaW5nIGJlaGF2aW91ciwgdGhlbiB3ZSdkIG5lZWQgdG8NCj4gPiBpbnRyb2R1Y2Ug
c29tZSBsb2NraW5nIGJldHdlZW4gdGhlIHRpbWVyIGV4cGlyeSBhbmQgdGhvc2UgZnVuY3Rpb25z
LCB0bw0KPiA+IGF2b2lkIHJhY2UgY29uZGl0aW9ucy4NCj4gDQo+IEkganVzdCBzcGVudCBzb21l
IHRpbWUgZGlnZ2luZyB0aHJvdWdoIHRoZSBoaXN0b3J5IG9mIHRoZSB0aW1lciBjb2RlLCANCj4g
ZmlndXJpbmcgb3V0IHRoZSBpbnRlbnRpb24gYmVoaW5kIHRoZSBjb250aW51b3VzIHBvc3Rwb25p
bmcgYmVoYXZpb3IuDQo+IA0KPiBJdCdzIGFuIGludGVycnVwdCBtaXRpZ2F0aW9uIHNjaGVtZSB3
aGVyZSBETUEgZGVzY3JpcHRvcnMgYXJlIGNvbmZpZ3VyZWQgDQo+IHRvIG9ubHkgZ2VuZXJhdGUg
YSBjb21wbGV0aW9uIGV2ZW50IGV2ZXJ5IDI1IHBhY2tldHMsIGFuZCB0aGUgb25seSANCj4gcHVy
cG9zZSBvZiB0aGUgdGltZXIgaXMgdG8gYXZvaWQga2VlcGluZyBwYWNrZXRzIGluIHRoZSBxdWV1
ZSBmb3IgdG9vIA0KPiBsb25nIGFmdGVyIHR4IGFjdGl2aXR5IGhhcyBzdG9wcGVkLg0KPiBCYXNl
ZCBvbiB0aGF0IGRlc2lnbiwgSSBiZWxpZXZlIHRoYXQgdGhlIGNvbnRpbnVvdXMgcG9zdHBvbmlu
ZyBhY3R1YWxseSANCj4gbWFrZXMgc2Vuc2UgYW5kIHRoZSBwYXRjaGVzIHRoYXQgZWxpbWluYXRl
IGl0IGFyZSBtaXNndWlkZWQuIFdoZW4gdGhlcmUgDQo+IGlzIGNvbnN0YW50IGFjdGl2aXR5LCB0
aGVyZSB3aWxsIGJlIHR4IGNvbXBsZXRpb24gaW50ZXJydXB0cyB0aGF0IA0KPiB0cmlnZ2VyIGNs
ZWFudXAuDQoNClRoZSB0eC1mcmFtZXMgdmFsdWUgKDI1KSBjYW4gYmUgY29udHJvbGxlZCBmcm9t
IHVzZXIgc3BhY2UuICBJZiBpdCBpcw0Kc2V0IHRvIHplcm8gdGhlbiB0aGUgZHJpdmVyIHNob3Vs
ZCBzdGlsbCBjb2FsZXNjZSBpbnRlcnJ1cHRzIGJhc2VkIG9uDQp0aGUgaW50ZXJ2YWwgc3BlY2lm
aWVkIGluIHRoZSB0eC11c2VjcyBzZXR0aW5nLCBidXQgdGhlIGRyaXZlciBmYWlscyB0bw0KZG8g
c28gYmVjYXVzZSBpdCBrZWVwcyBwb3N0cG9uaW5nIHRoZSBjbGVhbnVwIGFuZCBpbmNyZWFzaW5n
IHRoZSBsYXRlbmN5DQpvZiB0aGUgY2xlYW51cHMgZmFyIGJleW9uZCB0aGUgcHJvZ3JhbW1lZCBw
ZXJpb2QuDQoNCj4gVGhhdCBzYWlkLCBJIGRpZCBldmVuIG1vcmUgZGlnZ2luZyBhbmQgSSBmb3Vu
ZCBvdXQgdGhhdCB0aGUgdGltZXIgY29kZSANCj4gd2FzIGFkZGVkIGF0IGEgdGltZSB3aGVuIHRo
ZSBkcml2ZXIgZGlkbid0IGV2ZW4gZGlzYWJsZSB0eCBhbmQgcnggDQo+IGludGVycnVwdHMgaW5k
aXZpZHVhbGx5LCB3aGljaCBtZWFucyB0aGF0IGl0IGNvdWxkIG5vdCB0YWtlIGFkdmFudGFnZSBv
ZiANCj4gaW50ZXJydXB0IG1pdGlnYXRpb24gdmlhIE5BUEkgc2NoZWR1bGluZyArIElSUSBkaXNh
YmxlL2VuYWJsZS4NCj4gDQo+IEkgaGF2ZSBhIGh1bmNoIHRoYXQgZ2l2ZW4gdGhlIGNoYW5nZXMg
bWFkZSB0byB0aGUgZHJpdmVyIG92ZXIgdGltZSwgdGhlIA0KPiB0aW1lciBiYXNlZCBpbnRlcnJ1
cHQgbWl0aWdhdGlvbiBzdHJhdGVneSBtaWdodCBqdXN0IGJlIGNvbXBsZXRlbHkgDQo+IHVzZWxl
c3MgYW5kIGFjdGl2ZWx5IGhhcm1mdWwgbm93LiBJdCBjZXJ0YWlubHkgbWVzc2VzIHdpdGggdGhp
bmdzIGxpa2UgDQo+IFRTUSBhbmQgQlFMIGluIGEgbmFzdHkgd2F5Lg0KPiANCj4gSSBzdXNwZWN0
IHRoYXQgdGhlIGJlc3QgYW5kIGVhc2llc3Qgd2F5IHRvIGRlYWwgd2l0aCB0aGlzIGlzc3VlIGlz
IHRvIA0KPiBzaW1wbHkgcmlwIG91dCBhbGwgdGhhdCB0aW1lciBub25zZW5zZSwgcmVseSBvbiB0
eCBJUlFzIGVudGlyZWx5IGFuZCANCj4ganVzdCBsZXQgTkFQSSBkbyBpdHMgdGhpbmcuDQoNCklm
IHlvdSB3YW50IGFuIGludGVycnVwdCBmb3IgZXZlcnkgcGFja2V0LCB5b3UgY2FuIHR1cm4gb2Zm
IGNvYWxlc2NpbmcNCmJ5IHNldHRpbmcgdHgtZnJhbWVzIHRvIDEgYW5kIHR4LXVzZWNzIDAuICBD
dXJyZW50bHksIHRoZSBkcml2ZXIgZG9lcw0Kbm90IHR1cm4gb2ZmIHRoZSB0aW1lciBldmVuIGlm
IHR4LXVzZWNzIGlzIHNldCB0byB6ZXJvLCBidXQgdGhhdCBpcw0KdHJpdmlhbGx5IGZpeGVkLiAg
V2l0aCBzdWNoIGEgZml4IGFuZCB0aGF0IHNldHRpbmcsIHRoZSByZXN1bHQgaXMgYSAzMHgNCmlu
Y3JlYXNlIGluIHRoZSBudW1iZXIgb2YgaW50ZXJydXB0cyBpbiBhIHR4LW9ubHkgdGVzdC4NCg0K
QW5kIHR4LWZyYW1lcyAyNSB0eC11c2VjcyAwIGlzIG9mIGNvdXJzZSBhbHNvIGJhZCBmb3IgdGhy
b3VnaHB1dCBzaW5jZQ0KY2xlYW51cHMgd2lsbCBub3QgaGFwcGVuIHdoZW4gZmV3ZXIgdGhhbiAy
NSBmcmFtZXMgYXJlIHRyYW5zbWl0dGVkLg0K

