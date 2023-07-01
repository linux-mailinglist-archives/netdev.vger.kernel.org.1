Return-Path: <netdev+bounces-14951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EEA744873
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 12:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87B3A1C208F0
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 10:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654AF5699;
	Sat,  1 Jul 2023 10:18:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D44D79DC
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 10:18:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E981FCB
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 03:18:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WK0x7U3NQi61X7dfk/zalQ+Kve6NYROa9hWVj6LMH8UXTLrMDOvfelh04jddaoBeTAsyI4pPcmoQ9qIui4V9jRhxf2nvn0ITSxN++WBsiHG6tC+etE1bAkH1Wv66grxI0b96D1HuXuzIwzALHRWhIKsTVN8vRoHIX4c1gLUBFNKL36Y/h9Yw1oTs+hfjyr+/dmb8GysbkfMg0p1xlce9/ADBpIyf4adOPgWYUUaNTaNT92rm13RlH5ZuGfAWPh0wNVGgWNZYrYqI0M93i/kcO8noFk/ygGYfHCM/Lj2fYnwz+310xtPmoh3QOeCtVScOo7Hw3LwkTjaDJByJ8rTvUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGMBCeDyX/rt5cZqh6gpiXPQ6n6tq3CB/Mm9Uv5I9UA=;
 b=PdvO3L4rqRJ4ZHNGDNtrMeapXrwTU8enPazQ2tbAOnTHTtQZUtI+zf7SdkBRG6xlHvB5VfHkY4EPLSDID8ew3UKccXfVcrBrN7WFO69NuEeYO1bsExjQOp9n+f/PfqGUkI+8piefq7URmDiUQhFTMRdCrzMNofN8wpzLCeK5u8oMDxZc37J/fRsyPtL+brrXTnVZY7R0bEOb0LQkUCEAob/b0C9rcYHTgFKcI+C2zrCgWQEBfMOFMADBcJBxqb4anGyj2rTkR87ib0b8UliVQXxzsgjaxUX3UrfliHvz/hcW1iubXC1i00g0ZRXJCNmp0NxzvD6PyA3riAN0h/8C6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGMBCeDyX/rt5cZqh6gpiXPQ6n6tq3CB/Mm9Uv5I9UA=;
 b=UBRdwfFALOhZDAVtTan9b/SPpM3vZK/BQpqNzul6jE8ZUxCVz9rS3CQQ3xL6444QxHKF6XfzFLJEp9qjfOSH0XjQTscCsBRQSigWlWUGkEerwqIRHe7FQdIHVbb7u6ksBsk5c7xnQrsyG++TRVBMTAcPTDB8TOLyP7xzz2RVRX5WDdQ2OOMyk349+3x8+X9bxnhLWJ4CUXq3FfGSmABP6II+4M3qv+VhEDRnQQsB5cK0A8KGVM4QlRmag9/WyPMGFz/Dksp9+k0uT4SivvLrtii7rNRYNVwSLP0BLYRajU7+XKtUH48shfYqelvLs7EFXaM8GFokYKj0Xyt86F88Hw==
Received: from PH0PR10MB4615.namprd10.prod.outlook.com (2603:10b6:510:36::24)
 by SN4PR10MB5592.namprd10.prod.outlook.com (2603:10b6:806:207::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Sat, 1 Jul
 2023 10:18:11 +0000
Received: from PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::f01a:585:8d6:3d3c]) by PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::f01a:585:8d6:3d3c%7]) with mapi id 15.20.6544.024; Sat, 1 Jul 2023
 10:18:10 +0000
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "andrew@lunn.ch" <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: Disable TX path on eth I/F from driver?
Thread-Topic: Disable TX path on eth I/F from driver?
Thread-Index: AQHZq2pIQeoSRMiWDkmOhwIk0qU4jq+jjwoAgAACCYCAAAMogIABH5uA
Date: Sat, 1 Jul 2023 10:18:10 +0000
Message-ID: <0b760c65b672e1fdb6d5137a31e86c97ea3af209.camel@infinera.com>
References: <e267c94aad6f2a7f0427832d13afc60e6bcd5c6e.camel@infinera.com>
	 <abb946fd-3acd-4353-8cda-72773914455d@lunn.ch>
	 <377d93c3816a3c63269b894e3d865baace175966.camel@infinera.com>
	 <56dac46c-37f8-431b-82b2-bfa75e9e63a2@lunn.ch>
In-Reply-To: <56dac46c-37f8-431b-82b2-bfa75e9e63a2@lunn.ch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.3 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=infinera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB4615:EE_|SN4PR10MB5592:EE_
x-ms-office365-filtering-correlation-id: 470ba93d-1f39-49dc-0399-08db7a1c789b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Jva3D4gt3a/JaozJh0mTQ/MAwDOeV3JdodrVZ///9cO9+AaYR87i+Anojsak/z9Z1yozoLGVnyiOiwehIry5G00bmYXVfuVWuQJztkAmRUQ9t/3Qez1FCzHR0PR2Qnl5nrLqBa8Cq2NkzZ8rZVjqyE02suUQZptXVxV8683iR8n+hglmxlk8t6PY2HeAp+OdF0glvLnX/mp55npYZV2Ub9Sx5BHtNP368ET7oqQVEh+yUubBi4TRVHO7m0PrGZ9iDhy2grkjs2UpVE27GrInglspXBtLH6HCR6y4bPayW2B5WLcAxAWb/FcJWacnM3pEq9t86bPjOh5o3TusAkL57gE7zr6YAVCpL0PRXkguNigRos++oG5xIv54OBvrsQfKDLVfUyK9RL5ip9XFMt0s5zSBndQtibGEevTmZjT+CBsPpM0UGEhP6LeIVeymfjgHbLK1T20W1NPDyb7fblxIj57+1TB/ndUIHihp17UxbhSTMHCSuuTdRgohoe2pJoJhgpLbQgY1Plw8oxW6vKSjdntJtnU0u1MubknbZNMrINFQt6VQd27lq7NyZ5U7t45Qx1lqbFB7RXfWG9AHP+/tE3LAjYe5Sr9bQPNGpfJhB9E=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4615.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199021)(316002)(66946007)(38070700005)(76116006)(66446008)(64756008)(66476007)(66556008)(6916009)(4326008)(91956017)(38100700002)(122000001)(6512007)(186003)(6506007)(6486002)(71200400001)(966005)(478600001)(45080400002)(2616005)(83380400001)(8936002)(2906002)(5660300002)(86362001)(36756003)(8676002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VjNMVTQ2eDZpZm03YXV4VlJkUGdNcThqbGcrQmZFdkRjdUF1cVJOV2xBdFBz?=
 =?utf-8?B?aUJONkVUTnlPY1hUK00rRURwRnlrQ1lEeVFJWUhVL2tpN3M5dml0eTUzeDFJ?=
 =?utf-8?B?N1crQ3dVbzJwaTBLWjh2S3pKdG1PbHhUSjRCQVVsSGcxZEhRaGRWaHQ3aUh5?=
 =?utf-8?B?NDVhdjAzcmQ2M2RLYUxCRW5IdTNLcnM3T2k5NHBrL2Z4YW5mWm15d3JRU3Ur?=
 =?utf-8?B?SFFqOVl5Qjdqdnpnb2F1TEhzMW12blJQYTFRK1dTR2VWMWFCc3MyWGE2bkt3?=
 =?utf-8?B?Z2dYVExlWEw3Qmx6MjgvMUZSL1FpR2ZIMmJhcEdMNE5zaGFxaUROTGwvU2JJ?=
 =?utf-8?B?ek52S1dLRU5ySkhGUHhLQUd3ejJTTTFRVEcvbmY2di93ZTgyd3kxSnJ4VlNC?=
 =?utf-8?B?cTZCb1NTdXNXSVI5RmZwcmRNTHdNUmlpeWxNUFZ6RjI0Ym1mSUZMdnhRalpG?=
 =?utf-8?B?YWlzRTloWFRablZxcWdrajFNdFhqbmZEeWJSSlpsTkN2OVgySG80T1N5eWps?=
 =?utf-8?B?MUZQMXB3MG04YTJhODcybWhua0NVbEtTaXFvSzZ4dEpTK28vOVdGb3Vadllm?=
 =?utf-8?B?dkI3QjYwdmdsYTNobzhlL2pjckx6bFgxdVdZT29zNWdhR1l5a3dXZGxma2ky?=
 =?utf-8?B?RGxZRkVFSFR3ZDJxOUdDNFFaZ0NxWlM4Ny9IRWQ4cjgrQll5OExKSHhqenc5?=
 =?utf-8?B?aEc5ellzL1NFck50dmN3UDQvT1lpZHV0b0xGOFBCOXN3OEplVEVlWWVUa1Ja?=
 =?utf-8?B?UGlXakd6K1Y0bmsrWjNhS0RxdVJmYXE1eXRIYmZ3dDI1ejM4VDVPWmh5Nklq?=
 =?utf-8?B?V1VZQXJmVkhkTzVoZEZRS1pLQnY5VEx6YUU4bld6OFNUQzh1dWdLSFZnZ0hB?=
 =?utf-8?B?QlArajlWTE95aDhHMU1qaDkxNzdPU2hiYklvRUhTd1QvZkxkT3NzbWNxMGQw?=
 =?utf-8?B?NXcrZGVDRTJGZlNyOTJDdXEyQ2NwZEJTUjlCdFdFRGpsb2t5WGpseFFwSUpB?=
 =?utf-8?B?SHV1M1pVK01uVDRUSXNHenBKTER4RnZxdDIxUi9VM05yZWJ5bURmUk14cUd5?=
 =?utf-8?B?YkJPMWdQbUx6Mkk1QmxwRUMrUjVYL2FIS1VCSlNzZ1RQZGhMbDJtcWdpVlUx?=
 =?utf-8?B?ajE3dUpjcGxSN0tkSHBBc1hUWjkvUmZaTlJ6K09FZDhPOUYxdW1NODdwb29N?=
 =?utf-8?B?NUE1cnBTYlpsWUU5STl3MVgzd0pDQ2xML0VDbzVzUThCbVg0cU9McTYzcDZS?=
 =?utf-8?B?VURmdDNJd0dVVXVwaUpuK3JIQk52c3NuZG9OUXhjSEpldVN2Nk90OURhVS9i?=
 =?utf-8?B?eGZldXJ3WlRtSzRrOUxFbzFEQjU1YkZRYnJITU5kYlhlWU1IOHloTWNFeEYr?=
 =?utf-8?B?Ym5BSXBmWTlLZlllUi9ya21UZi9BSmlyZlJEaE5WSXh1SzM5bVFpeDlrK2Rv?=
 =?utf-8?B?c01RN05YcTBsMzUrMGh5SldvRy9FRlVqWU4yOURwUEdLOTVFTlFDMldGT1da?=
 =?utf-8?B?K2VCeTJrNUdCREFqQzdwRkc5ZlpiNTlqVTd3TExKQVJkc3NIR1Y0cjNETXNL?=
 =?utf-8?B?OXUyUW1peVhKN05hQUQ2MEordWdsWjRvY01wZ012SFRGdXdVM2ltNnc3cGxy?=
 =?utf-8?B?NllnTm1vQWRpdUk3ME5HZ2tjczllZ0N4d21RcDNBR2praW5Ed0RxcytyOTN3?=
 =?utf-8?B?VDJBT1gvSnk5MG9pTlV3S29JeW9PUHpjRVZHRUJiWnF4OC85S0tORmVkekpQ?=
 =?utf-8?B?L2pYUFhTTTJRZEFUdk1kUVRKZ1BudmZmd1J4ZTR3c2lhTzV5d1h5U1RXdlNL?=
 =?utf-8?B?aWtHQlhCVTlVQUsvWUUyWTlGc3cwOWxXT1VzOHZ6SU5OZ1JCeTFmY1lKUE5m?=
 =?utf-8?B?MGI5ZG5GUGdQcTAvL2YyNGlTN0VQL3kzakplZ3owVkhlZnBnb3J3MTcxcnVx?=
 =?utf-8?B?SDJ6T0ZtQ3Fia3dhV1BodjVTZWpxSnFORWRrNzdvVFBud1A3Q3B0SlVsdXFI?=
 =?utf-8?B?cnFZQXZLclVZTkVEOWwwM3lILzlqekhoNlgzbFQzaE9XVGQycEZjc3VPbzc1?=
 =?utf-8?B?SWZtSGwxNkZobllvbFNLdzhYNmFnMWlwcTdZZVJzTUp4NC9hR3V6azRCOTJi?=
 =?utf-8?B?RHZ5NU1ERG9GeTdUblNMSENEWDVlaUxXWXRDL3hESjh5ODdDaWNzVFVlM0M5?=
 =?utf-8?Q?k8mcxR7rarqLGtBLH+sfOX+hgb+4uNQvu02o4ArcpVmu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <36B8FF98F03E5F4D8FB6060392A8392D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4615.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 470ba93d-1f39-49dc-0399-08db7a1c789b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2023 10:18:10.3854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jiy8qYg8XjDs1Wa2zRbqkR3FDH6m6jjuv3SkfMoBbu8fYiIGbLIv6+c23UQxB1OL6qwYDvVqeKKSJ6JUxAjdbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5592
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

T24gRnJpLCAyMDIzLTA2LTMwIGF0IDE5OjA4ICswMjAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
T24gRnJpLCBKdW4gMzAsIDIwMjMgYXQgMDQ6NTc6MzFQTSArMDAwMCwgSm9ha2ltIFRqZXJubHVu
ZCB3cm90ZToNCj4gPiBPbiBGcmksIDIwMjMtMDYtMzAgYXQgMTg6NTAgKzAyMDAsIEFuZHJldyBM
dW5uIHdyb3RlOg0KPiA+ID4gT24gRnJpLCBKdW4gMzAsIDIwMjMgYXQgMDM6NDg6MTVQTSArMDAw
MCwgSm9ha2ltIFRqZXJubHVuZCB3cm90ZToNCj4gPiA+ID4gV2UgaGF2ZSBhIGZldyBldGggSS9G
IHRoYXQgaXMgZm9yIG1vbml0b3Jpbmcgb25seSwgaWYgYW55IFRYIG9uZSBnZXRzOg0KPiA+ID4g
PiBORVRERVYgV0FUQ0hET0c6IHRyYXAwICh4ci1jY2lwKTogdHJhbnNtaXQgcXVldWUgMCB0aW1l
ZCBvdXQNCj4gPiA+ID4gWyAgIDU1LjkwMzA3NF0gV0FSTklORzogQ1BVOiAwIFBJRDogMCBhdCBu
ZXQvc2NoZWQvc2NoX2dlbmVyaWMuYzo0NzcgZGV2X3dhdGNoZG9nKzB4MTM4LzB4MTYwDQo+ID4g
PiA+IFsgICA1NS45MTEzODBdIENQVTogMCBQSUQ6IDAgQ29tbTogc3dhcHBlci8wIE5vdCB0YWlu
dGVkIDUuMTUuMTA5LTAwMTYxLWcxMjY4YWUyNWMzMDItZGlydHkgIzcNCj4gPiA+ID4gPGxvbmcg
dHJhY2Ugc25pcHBlZD4NCj4gPiA+ID4NCj4gPiA+ID4gSSB3b3VsZCBsaWtlIHRvLCBmcm9tIHdp
dGhpbiB0aGUgZHJpdmVyLCBkaXNhYmxlIHRoZSBUWCBwYXRoIHNvIHRoZSBJUCBzdGFjayBjYW5u
b3QgVFggYW55DQo+ID4gPiA+IHBrZ3MgYnV0IGNhbm5vdCBmaW5kIGEgd2F5IHRvIGRvIHNvLg0K
PiA+ID4gPiBJcyB0aGVyZSBhIHdheSh0byBhdCBsZWFzdCBhdmlkIHRoZSBORVRERVYgV0FUQ0hE
T0cgbXNnKSBkaXNhYmxlIFRYPw0KPiA+ID4gPiBPbiBrZXJuZWwgNS4xNQ0KPiA+ID4NCj4gPiA+
IEhhdmUgeW91IHRyaWVkIHVzaW5nIFRDIG9yIGlwdGFibGVzIHRvIGp1c3QgdW5jb25kaXRpb25h
bGx5IGRyb3AgYWxsDQo+ID4gPiBwYWNrZXRzPw0KPiA+ID4NCj4gPg0KPiA+IE5vLCB0aGlzIGlz
IGFuIGVtYmVkZGVkIHRhcmdldCB3aXRoIG5vIGlwdGFibGVzL1RDDQo+ID4gV291bGQgYmUgbXVj
aCBuaWNlciBpZiBJIGNvdWxkIGRvIHRoaXMgaW4gZHJpdmVyLg0KPg0KPiBJIHdvdWxkIGFyZ3Vl
IGl0IGlzIG11Y2ggdWdsaWVyLiBZb3UgbmVlZCB0byBoYWNrIHRoZSBrZXJuZWwgZHJpdmVyIHRv
DQo+IHRocm93IGF3YXkgcGFja2V0cywgdnMganVzdCBpbnN0YWxsaW5nIGEgY291cGxlIGV4dHJh
IHBhY2thZ2VzIGFuZCB1cw0KPiBhIHN1cHBvcnRlZCBtZWNoYW5pc20gdG8gdGhyb3cgcGFja2V0
cyBhd2F5Lg0KPg0KPiBBbnl3YXksIGlmIHlvdSB3YW50IHRvIGhhY2sgdGhlIGRyaXZlciwgc2lt
cGx5IHJlcGxhY2UgaXRzDQo+IC5uZG9fc3RhcnRfeG1pdCB3aXRoDQo+DQo+IGh0dHBzOi8vZWxp
eGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjQvc291cmNlL2RyaXZlcnMvbmV0L2R1bW15LmMjTDU5
DQo+DQo+IHN0YXRpYyBuZXRkZXZfdHhfdCBkdW1teV94bWl0KHN0cnVjdCBza19idWZmICpza2Is
IHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpDQo+IHsNCj4gICAgICAgZGV2X2xzdGF0c19hZGQoZGV2
LCBza2ItPmxlbik7DQo+DQo+ICAgICAgIHNrYl90eF90aW1lc3RhbXAoc2tiKTsNCj4gICAgICAg
ZGV2X2tmcmVlX3NrYihza2IpOw0KPiAgICAgICByZXR1cm4gTkVUREVWX1RYX09LOw0KPiB9DQo+
DQo+ICAgICAgIEFuZHJldw0KDQpUaGFua3MsIHdpbGwgZG8uDQoNCiBKb2NrZQ0K

