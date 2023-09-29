Return-Path: <netdev+bounces-36996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 664AB7B2EDA
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 11:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 7E6321C2095A
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 09:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6691171E;
	Fri, 29 Sep 2023 09:06:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8DA441B
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 09:06:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319EA11F
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 02:06:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1FqPq4DzGFp+koCzoJcU3+ySzk9V1wyr6IzMsuH0dk5/HTUtZWVi8T0VJgnvYRkwO5+pj8lf9qHsYHLNLhz8NE7lyr5W+iC8uKnNBEnmpgdHl6DNmOrbkfFWezi/9FVub/g97RP0ltiWyVX5imJVupfjktCqW/oM4lw4V0t6OKx4+GSeXeO7gmopX2MrW9mbmxh9SXh9irkaHMOsv5BYFxjWBlBATf2WuXZWRqb5Kte5InhxPOPLR0OMBmVC5PSgMbq6fof3fpFZ0Tx/8yJLvOuPd2MzF4qaqWzertjUsNQ5/UY5nt43m8LUBaVD0Vm7fSsKrI4glSsx+uCH/c3yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlzHWkmpohwx9vvlQO3VyobdwVGSD1V0PUuCL8qYozk=;
 b=CJD5qwZzILMfCQj6aCBbJqbV3Qw+jtNrNNmDGcKXYpBIz/THz6B5N/NGWFAncPKMaPFk+3N3HFFWkgNUdLFD4NflHnp/q6Q2xH4wwJN7bouWS2UH50laxbcw7YXVDn7nPXZ3Qn2i7qdkWOb82K8rQ3lpDcD9qbLqTMM844Ik6fnJecHukjdFs7QCJ9SuixjoE11ysY5MSeKF8VLZMLPyQBWCQ6d0HwNNbaZMRM2r3f1X8K0ERXtW/50FOE3FiIQA/vUDggxeRyrzXBIMZ5kNfXMqF43o0TtXRoauRFDkdSPAyQdy8EAVB6VmKpJepeGJkGfUIenu4nsUtYbrXVcvww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlzHWkmpohwx9vvlQO3VyobdwVGSD1V0PUuCL8qYozk=;
 b=dhCsWt88FC1jnWv52lX489lCZ+/KUalqgc+KcvIda0LLyWU6l7X/8o4wt7VW/4b4erBW7NdVow/jbxRng5lIdNrV6tdQDH1PTkKLjlIoDvdaTpDaI3Uf7XMb60hudOf77QlUPZrBcrXK2Q4Tbgy5sO+enNIRBVmQidO3iCCoHHj61qOf0fVD+4sbxjTq40//n0pDfFOsJE8GJpk3eej/c8uWytnRb8vJlkNknenLcw4v+NwjPe9FbWu7m0jNVIhj4i9JlmI/ce7UdDimb/flaxVTg2B2AhhXWoRoTon+iEEYaFqGA3a+SzIQrNhn16OUAxEMh0//1yCTC49HgLu+Qg==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by SA1PR12MB8858.namprd12.prod.outlook.com (2603:10b6:806:385::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Fri, 29 Sep
 2023 09:06:13 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::fddf:d4b8:44d9:d378]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::fddf:d4b8:44d9:d378%6]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 09:06:12 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "dw@davidwei.uk" <dw@davidwei.uk>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "clm@fb.com" <clm@fb.com>, Saeed Mahameed
	<saeedm@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>
CC: Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH RFC] net/mlx5e: avoid page pool frag counter underflow
Thread-Topic: [PATCH RFC] net/mlx5e: avoid page pool frag counter underflow
Thread-Index: AQHZ8mZDZqPLa0LYF0eSNzLSHwhPfrAxg5YA
Date: Fri, 29 Sep 2023 09:06:12 +0000
Message-ID: <a0dacf7c3a869ef94db8e42e22d71edea6cbd8d8.camel@nvidia.com>
References: <20230928234735.3026489-1-clm@fb.com>
In-Reply-To: <20230928234735.3026489-1-clm@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|SA1PR12MB8858:EE_
x-ms-office365-filtering-correlation-id: 393444ea-9529-42db-a3a5-08dbc0cb544e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 A3RCEeqvClnjSbonsnLP0MbnDMpA2LwE06Nf5JAd0qfIajYvmGOATXLL9VV/8Ac6y2Xl7sghJTBhq2YPU0T70ctgkgOtQX5LtAlT7fCH7+iDgO7kt3R5Gm8pV5mf/AK9dzhiwme3OJvfRjyUuFGSqhTWPcbdIa09wNKZGQZFSSDx3gNO7EiA7imVDQAuo9xqkDTV8siC+uNzp0ZxY7iaKq+8114Oua/wj1Q4nNNPVV5LURmSp8Xdnbz/kFaQHWv4WF7UIm5if2DcqrEq+xF8Xi/f3xTi2BA1ykjY8tlMEPiool3msLFZ4ROC00eU1NbYTTDK3x7YMnTximqH59wuSyQThS7OPC96O4K/kh3Diyb3CLqbqVWN+yb4g7s9AMH8rZBCNeckMSwPF32N8VmvUkPt71a5slGV7mjw3DuNXU+u9/We3xn0kU19XKDt1CoXchsAUMZ3ZRNwE5ih+/FCCU2crv25HpuInQNLhWCCOU3vw9zyRv2+4rx1n57d/k9530Q6XkCOmh/J6jEjVCkjzbAtwE7npQUjA01Yp/QJyOOlESqEKPGgPiVIZjb0871QC2LIfwXESQvhTtTqpJELFs7qsRLV4YQLHVhtHn5po3GYckw8YeVa2Xl2cEwwX2h9
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(376002)(346002)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(4326008)(66556008)(8936002)(8676002)(6506007)(76116006)(91956017)(110136005)(316002)(66946007)(66476007)(41300700001)(64756008)(66446008)(5660300002)(71200400001)(86362001)(107886003)(6486002)(38070700005)(38100700002)(36756003)(2616005)(66899024)(478600001)(122000001)(83380400001)(6512007)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OEZCbW9EL3hpYndZenM4N1Vvdk9QTTVTdFNSMFk2ZlRMb05vbzNCZ2hqTndN?=
 =?utf-8?B?OWs1aUdnUWQrcjNONGxOeVhic0syd0NVN01ESFd1MW42QnF4UGY1N1VPM2hx?=
 =?utf-8?B?OXR4ekc5RXlMRE5Fb1NpOXFWOFlMOWRuQS9iOHBDQU51VTNWYXdSY2xWOFhG?=
 =?utf-8?B?TVZiSjBIMWF1V3FHajU0bkkxTy9iWWw2SkZ2MDUxdlZLWnhFamJsN3pkVXhy?=
 =?utf-8?B?ZmVDbytRTUR2eUtjSmFncEZVSUZBaTZ6UE1NZ0dzT09rbncwMk42VnBTMzBQ?=
 =?utf-8?B?YlR4RUVwM3IxdE5LR2M1SjRRdTlzMEhFeWgrQ2dwMUV4eXRiU1I3SVlVc1pW?=
 =?utf-8?B?QUgzczBLSE9ST0pyYmdkcml2eGVUTVBFOUVjRjltaGtRemVXb3NXWHVSTW1s?=
 =?utf-8?B?eE55RWdDRzFLQXM0ODBjT2hoZUlsZmhXeGJaMHZEdXd0bisvK0NUb052Njkr?=
 =?utf-8?B?VjBVeHpsZWFiMFU4WXpldWZacGYxbFM1YmhPNE1oTFc3M1NsRnZIY2JYYm5C?=
 =?utf-8?B?b2JIaGNQcFlHYVFXRmQzb1FFT3JBZUVuYktRc0luTEVaZENtWlBZd1JtUnNK?=
 =?utf-8?B?YW16L0tPaVdLRTNyb0pjcElFSWRJWlVHWGlJT0N4dG1ha21Fc0FEbDhnUkJZ?=
 =?utf-8?B?bDQvMEtaSVhBV3Q0TFJqeFN1aWV2QnpXN254WFRWeFhocWd6TTdma2FZRlZR?=
 =?utf-8?B?M1ZNelJyaFpRd0pZRS9VajlsU2hYQndERmFFcXZXWUowWVNGTnB3Z2Vpcjlp?=
 =?utf-8?B?RnMydDE3bnRpakNlWjhkRStPUE5WNkRXQUNSM2h0S0ZzOUM3aVQ1aCtTUkh5?=
 =?utf-8?B?Rmp6WGd0UStLL0NUVkNWUVVWTjZQc0FENU9TTFk5enNEbXFWdWxjWVRPVGhl?=
 =?utf-8?B?dVBzOHBvb1I0T1Q5akxqdnpYL1RTT1F3UXVDUkpKMUhmZldWNmIxbmVOL25w?=
 =?utf-8?B?V2pvUG1seVlaNXlXanpkNHlUZTV4OVorWTR1ZmUvZEtaZ3NqLzhrOTY2cGIv?=
 =?utf-8?B?S1QyL0lhUmhodE16TW92K2NYM3J4NXpNOFRzbExEeWZHdnlaL1NCY1NzMnpp?=
 =?utf-8?B?aHV3aVREalcyRC9aZ2NRUkJZTStEcDB4TW1QZHhGaXFSeWZnRTQxcFdrK3k2?=
 =?utf-8?B?dlVMT09KRHNlSEc3K21NWGJCbjFXbDZ1QlpQd1RpNHNFY0lPME1xdXMrN003?=
 =?utf-8?B?UHZGU3JXdDBuQngwbkROcjdHMllYYnYwdmpPWEViSUNnYk0yK0wwOElIU2Uy?=
 =?utf-8?B?VTJ6QllGZndDQTA2TGpNMytaVURZZzd4QUV0LzhxTlNtOHVCUUNMVmVqMkFh?=
 =?utf-8?B?SjM1amFLSTJuZHB3cEVML0lncDEvSUVnQW1QMmt6TXR4UVNBMlJqdGY0U094?=
 =?utf-8?B?WFFqdytSYm1pSVpoZWhXY2hFbEU5N1UwTDgrQ2tlQmk4Vk1xZGFhK3J2UGJI?=
 =?utf-8?B?S3pYM2ZsMTdrU0Y2bExVKzgveDN1WkpUZXUxN1pzTmt6b2F2L2luL2plSFZ2?=
 =?utf-8?B?cFBxRnRxYnpwZUJLVk9MT1pDU2RubEp1dmNsS256aUtENWlWeW5vSjNIYVFP?=
 =?utf-8?B?bTJWL3E2OGRwZlRKWERDd0pzem9TZVNLcG02WnZYTFYyaGMxdEhkZG1Db3JX?=
 =?utf-8?B?dVRHR09BeXc2MHU5akpSVDRaVmNLQWk2YUhpek90OVdSbmxJdmFlMG93eUFu?=
 =?utf-8?B?YnJMZktGVHJjVU13S2MwQVZsVzhEVnZ2akhTajZhMkJrUmQrMUlGK0Zxa1NP?=
 =?utf-8?B?VHNmUEJrU2pHeVo0SFVuL1I3Tk4zeWtUMnZBK2sxWmNYL0RSTnN5K0k0L3BB?=
 =?utf-8?B?RHQ3WHZrODJrSDhBV1U5SkxHL0E2ck9DeXR6eTVRZ0xXUVUvYlVnUThuWFBW?=
 =?utf-8?B?aGNoYklzVXhwYkY4SUJoT1J3Kzl5L1ZFN1BSck84S2RETkJHdjlHQ2E3dzUw?=
 =?utf-8?B?S290R2JLbGY4VHd1cUJiUlRtU0FNMFFlOXJQUU5KMHM3TGhOblBlS3dlbTdE?=
 =?utf-8?B?aWg1ZXk5QlJTclRGL0ZsOURmS3F6RytmdkpSY0ZyTk1CUEpySmhjL1NkdUx2?=
 =?utf-8?B?L2g2TVB6ckJ3bCtROHFWTGpqUHJpeTJGNjV3ZURNVjhGZ0lnMW5KeHJCSUcv?=
 =?utf-8?B?TlFGRTkxNXRJYzZzR3Bsc0plcWF0ejVYVmp6bkpHcUlOZi83YytXZTR4RjRx?=
 =?utf-8?Q?IJ4Qgvyc78IYAUrVQrYzjaPHM+8ueYkJsVyc0S6ojCW3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6BEF56EC1B17C43BB4BBF716F292D6F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 393444ea-9529-42db-a3a5-08dbc0cb544e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2023 09:06:12.7844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ceBTup5opTD6B0p6/P6nr2V8tWD23/Q5expK8tF8tW5qkBph5ULTzIUH4HRrz/u0OrlkvxZ5n9S6xZzwNyVZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8858
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

SGkgQ2hyaXMsDQoNCk9uIFRodSwgMjAyMy0wOS0yOCBhdCAxNjo0NyAtMDcwMCwgQ2hyaXMgTWFz
b24gd3JvdGU6DQo+IFsgVGhpcyBpcyBqdXN0IGFuIFJGQyBiZWNhdXNlIEkndmUgd2FuZGVyZWQg
cHJldHR5IGZhciBmcm9tIGhvbWUgYW5kDQo+IHJlYWxseSBkb24ndCBrbm93IHRoZSBjb2RlIGF0
IGhhbmQuwqAgVGhlIGVycm9ycyBhcmUgcmVhbCB0aG91Z2gsIEVOT01FTSBkdXJpbmcNCj4gbWx4
NWVfcmVmaWxsX3J4X3dxZXMoKSBsZWFkcyB0byB1bmRlcmZsb3dzIGFuZCBzeXN0ZW0gaW5zdGFi
aWxpdHkgXQ0KPiANCj4gbWx4NWVfcmVmaWxsX3J4X3dxZXMoKSBoYXMgcm91Z2hseSB0aGUgZm9s
bG93aW5nIGZsb3c6DQo+IA0KPiAxKSBtbHg1ZV9mcmVlX3J4X3dxZXMoKQ0KPiAyKSBtbHg1ZV9h
bGxvY19yeF93cWVzKCkNCj4gDQo+IFdlJ3JlIGRvaW5nIGJ1bGsgZnJlZXMgYmVmb3JlIHJlZmls
bGluZyB0aGUgZnJhZ3MgaW4gYnVsaywgYW5kIHVuZGVyDQo+IG5vcm1hbCBjb25kaXRpb25zIHRo
aXMgaXMgYWxsIHdlbGwgYmFsYW5jZWQuwqAgRXZlcnkgdGltZSB3ZSB0cnkNCj4gdG8gcmVmaWxs
X3J4X3dxZXMsIHRoZSBmaXJzdCB0aGluZyB3ZSBkbyBpcyBmcmVlIHRoZSBleGlzdGluZyBvbmVz
Lg0KPiANCj4gQnV0LCBpZiB3ZSBnZXQgYW4gRU5PTUVNIGZyb20gbWx4NWVfZ2V0X3J4X2ZyYWco
KSwgd2Ugd2lsbCBoYXZlIGNhbGxlZA0KPiBtbHg1ZV9mcmVlX3J4X3dxZXMoKSBvbiBhIGJ1bmNo
IG9mIGZyYWdzIHdpdGhvdXQgcmVmaWxsaW5nIHRoZSBwYWdlcyBmb3INCj4gdGhlbS4NCj4gDQo+
IG1seDVlX3BhZ2VfcmVsZWFzZV9mcmFnbWVudGVkKCkgZG9lc24ndCB0YWtlIGFueSBzdGVwcyB0
byByZW1lbWJlciB0aGF0DQo+IGEgZ2l2ZW4gZnJhZyBoYXMgYmVlbiBwdXQgdGhyb3VnaCBwYWdl
X3Bvb2xfZGVmcmFnX3BhZ2UoKSwgYW5kIHNvIGluIHRoZQ0KPiBFTk9NRU0gY2FzZSwgcmVwZWF0
ZWQgY2FsbHMgdG8gZnJlZV9yeF93cWVzIHdpdGhvdXQgY29ycmVzcG9uZGluZw0KPiBhbGxvY2F0
aW9ucyBlbmQgdXAgdW5kZXJmbG93aW5nIGluIHBhZ2VfcG9vbF9kZWZyYWdfcGFnZSgpDQo+IA0K
PiDCoMKgwqDCoMKgwqDCoCByZXQgPSBhdG9taWNfbG9uZ19zdWJfcmV0dXJuKG5yLCAmcGFnZS0+
cHBfZnJhZ19jb3VudCk7DQo+IMKgwqDCoMKgwqDCoMKgwqBXQVJOX09OKHJldCA8IDApOw0KPiAN
Cj4gUmVwcm9kdWNpbmcgdGhpcyBqdXN0IG5lZWRzIGEgbWVtb3J5IGhvZyBkcml2aW5nIHRoZSBz
eXN0ZW0gaW50byBPT00gYW5kDQo+IGEgaGVhdnkgbmV0d29yayByeCBsb2FkLg0KPiANClllYXAs
IHRoaXMgaXMgYSBwcm9ibGVtLiBUaGFua3MgZm9yIGZpbmRpbmcgdGhpcyENCg0KPiBNeSBndWVz
cyBhdCBhIGZpeCBpcyB0byB1cGRhdGUgb3VyIGZyYWcgdG8gbWFrZSBzdXJlIHdlIGRvbid0IHNl
bmQgaXQNCj4gdGhyb3VnaCBkZWZyYWcgbW9yZSB0aGFuIG9uY2UuwqAgSSd2ZSBvbmx5IGxpZ2h0
bHkgdGVzdGVkIHRoaXMsIGJ1dCBpdCBkb2Vzbid0DQo+IGltbWVkaWF0ZWx5IGNyYXNoIG9uIE9P
TSBhbnltb3JlIGFuZCBkb2Vzbid0IHNlZW0gdG8gbGVhay4NCj4gDQo+IEZpeGVzOiA2ZjU3NDI4
NDYwNTNjNyAoIm5ldC9tbHg1ZTogUlgsIEVuYWJsZSBza2IgcGFnZSByZWN5Y2xpbmcgdGhyb3Vn
aCB0aGUNCj4gcGFnZV9wb29sIikNCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXMgTWFzb24gPGNsbUBm
Yi5jb20+DQo+IC0tLQ0KPiDCoGRyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29y
ZS9lbl9yeC5jIHwgMTAgKysrKysrKysrKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRp
b25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gv
bWx4NS9jb3JlL2VuX3J4LmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1
L2NvcmUvZW5fcnguYw0KPiBpbmRleCAzZmQxMWIwNzYxZTAuLjlhN2IxMGYwYmJhOSAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuX3J4LmMN
Cj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuX3J4LmMN
Cj4gQEAgLTI5OCw2ICsyOTgsMTYgQEAgc3RhdGljIHZvaWQgbWx4NWVfcGFnZV9yZWxlYXNlX2Zy
YWdtZW50ZWQoc3RydWN0IG1seDVlX3JxDQo+ICpycSwNCj4gwqDCoMKgwqDCoMKgwqDCoHUxNiBk
cmFpbl9jb3VudCA9IE1MWDVFX1BBR0VDTlRfQklBU19NQVggLSBmcmFnX3BhZ2UtPmZyYWdzOw0K
PiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IHBhZ2UgKnBhZ2UgPSBmcmFnX3BhZ2UtPnBhZ2U7DQo+
IMKgDQo+ICvCoMKgwqDCoMKgwqDCoGlmICghcGFnZSkNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHJldHVybjsNCj4gKw0KSWRlYWxseSB3ZSdkIGxpa2UgdG8gYXZvaWQgdGhpcyBr
aW5kIG9mIGJyb2FkIGNoZWNrIGFzIGl0IGNhbiBoaWRlIG90aGVyIGlzc3Vlcy4NCg0KPiArwqDC
oMKgwqDCoMKgwqAvKg0KPiArwqDCoMKgwqDCoMKgwqAgKiB3ZSdyZSBkcm9wcGluZyBhbGwgb2Yg
b3VyIGNvdW50cyBvbiB0aGlzIHBhZ2UsIG1ha2Ugc3VyZSB3ZQ0KPiArwqDCoMKgwqDCoMKgwqAg
KiBkb24ndCBkbyBpdCBhZ2FpbiB0aGUgbmV4dCB0aW1lIHdlIHByb2Nlc3MgdGhpcyBmcmFnDQo+
ICvCoMKgwqDCoMKgwqDCoCAqLw0KPiArwqDCoMKgwqDCoMKgwqBmcmFnX3BhZ2UtPmZyYWdzID0g
MDsNCj4gK8KgwqDCoMKgwqDCoMKgZnJhZ19wYWdlLT5wYWdlID0gTlVMTDsNCj4gKw0KPiDCoMKg
wqDCoMKgwqDCoMKgaWYgKHBhZ2VfcG9vbF9kZWZyYWdfcGFnZShwYWdlLCBkcmFpbl9jb3VudCkg
PT0gMCkNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwYWdlX3Bvb2xfcHV0X2Rl
ZnJhZ2dlZF9wYWdlKHJxLT5wYWdlX3Bvb2wsIHBhZ2UsIC0xLCB0cnVlKTsNCj4gwqB9DQoNCldl
IGFscmVhZHkgaGF2ZSBhIG1lY2hhbmlzbSB0byBhdm9pZCBkb3VibGUgcmVsZWFzZXM6IHNldHRp
bmcgdGhlDQpNTFg1RV9XUUVfRlJBR19TS0lQX1JFTEVBU0UgYml0IG9uIHRoZSBtbHg1ZV93cWVf
ZnJhZ19pbmZvIGZsYWdzIHBhcmFtZXRlci4gV2hlbg0KbWx4NWVfYWxsb2Nfcnhfd3FlcyBmYWls
cyB3ZSBzaG91bGQgc2V0IHRoYXQgYml0IG9uIHRoZSByZW1haW5pbmcgZnJhZ19wYWdlcy4NClRo
aXMgaXMgZm9yIGxlZ2FjeSBycSBtb2RlLCBtdWx0aS1wYWNrZXQgd3FlIHJxIG1vZGUgaGFzIHRv
IGJlIGhhbmRsZWQgYXMgd2VsbA0KaW4gYSBzaW1pbGFyIHdheS4NCg0KSWYgSSBzZW5kIGEgcGF0
Y2ggbGF0ZXIsIHdvdWxkIHlvdSBiZSBhYmxlIHRvIHRlc3QgaXQ/DQoNClRoYW5rcywNCkRyYWdv
cw0KDQoNCg==

