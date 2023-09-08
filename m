Return-Path: <netdev+bounces-32554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F202798602
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 12:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 575B62819E8
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 10:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9F31C11;
	Fri,  8 Sep 2023 10:42:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058601863
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 10:42:28 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A721BC6
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 03:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1694169746;
  x=1725705746;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=C6SpArpm33X2jMFnOSuu7vXG0aDpubq91OhfOIlWDtA=;
  b=Uhbp2IB9OndKD8pDAXuL7YdHfXod7GnWatft7yQqyvjtI4gi9Res9A8i
   jE7KjpF3nF5nTdZQcuaevbJKp7mWyU5OLsbLinAdzbhrStMti2hxMx70k
   LKSrML/I9wHrOeL4sWCxs0a4assZ9xTehuFqhGupFXOjxBXs0LgYFjB0/
   PkNOj6aKrBqYsEp0gdY/h5VO979g90ysq9ocfD9ZyCIV1vI+/rtnPkhI5
   3EokrS8Q2kzRbAm9FHU30b++5z6tgmatgFPrM0+x1N59Fml44ogc9GXt1
   qxChIyeqIdSfF3Mklh0Ycb7MKsVPU4wospn+L2El4lilOaOxcRv+RxyDH
   w==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKhBlXkKjR0lZF2b6xGwqvCHsH6RRfH6+7yKPNchaB8Ud/3OY+j8/4OntEmGG5u2fFikdhY/UDGK3YZEQ3v0SU8YwHxA/OxfMuWDUCMKZ+s888e3N4IFQTeSlnIn36L3IA4OVyw2F42L1EIfj7MAa4WIoaOfzwu4wVvq6ubt/SwYO8Ewzt471O7cP+N87dcqGYCT0jPpiN3IpQcDS2PURGD3CWp4gOHGwU2rDs1FOY7ehqWsqV25W601wqO+BQFJzZU5Ys8ER/548uvAehwJ2BI8k0pYJ+8uqfmNCEb0Y1Oli2WBZE96kltNyWy0+YMuIkRY1pKXPsRPq4tWjZcqXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6SpArpm33X2jMFnOSuu7vXG0aDpubq91OhfOIlWDtA=;
 b=DOllbZ5wwu9ufqW6e4tGLbx5fwid/TjMhySOdmCO55IcI6vANM3tdDO8ewydpDDinN6B1pHoDg46wic3QUNp8Uq7QuDIQyYMzdn//SjU/nyKDgp/KX8hIqppa/CoWzHokbPJHqoBVivr2zid87UJmZLkfuufpun70xAj4DyW/EvmZAz9fxx2cz4ysnSSgn714uw9BIx5XJpJQAM9Irl7Ibhw+1/Kkola9NROQf90O8TPKLx6oJo5rESmn+s3k9Cyofu5bywWCpGWEfYhN60sZ3oIMNZebwHPKc+CYKbJ6cw2k3m94sz5mXQa+bOPmV8Nx3e8FMa6S+MemMsrMQgvKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6SpArpm33X2jMFnOSuu7vXG0aDpubq91OhfOIlWDtA=;
 b=QLyqd7CpDynNOTKrkod3xL/4RV9k5VUuEpi8urgPNcGIGxSIocpTYqdqPYE6Wz+FaNC+kmBvtBPhGT6bjCfI3iEc+zU8BkdQaAV4F5YH+EoBEoifpbIjzrPswYgdnwG9Y2xrd0KLCWN+qJ6iUfqdg+ieP1f6XdYw20y1j9myUjg=
From: Vincent Whitchurch <Vincent.Whitchurch@axis.com>
To: "peppe.cavallaro@st.com" <peppe.cavallaro@st.com>, "nbd@nbd.name"
	<nbd@nbd.name>, Vincent Whitchurch <Vincent.Whitchurch@axis.com>,
	"joabreu@synopsys.com" <joabreu@synopsys.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
	"davem@davemloft.net" <davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, kernel
	<kernel@axis.com>
Subject: Re: [PATCH net] net: stmmac: Use hrtimer for TX coalescing
Thread-Topic: [PATCH net] net: stmmac: Use hrtimer for TX coalescing
Thread-Index: AQHWv04gJ8ZamJtkVky0JUyVF0YJta/+f16AgAK1/wCAAEHkAIAHrjMAgABnkwCAAoQyAIAABfyAgArseYA=
Date: Fri, 8 Sep 2023 10:42:22 +0000
Message-ID: <7c35a48ea40d7d7aeed81e29eb13af5562a481ab.camel@axis.com>
References: <20201120150208.6838-1-vincent.whitchurch@axis.com>
	 <732f3c01-a36f-4c9b-8273-a55aba9094d8@nbd.name>
	 <2e1db3c654b4e76c7249e90ecf8fa9d64046cbb8.camel@axis.com>
	 <a4ee2e37-6b2f-4cab-aab8-b9c46a7c1334@nbd.name>
	 <f3c70b8e345a174817e6a7f38725d958f8193bf1.camel@axis.com>
	 <8a2d04f5-7cd8-4b49-b538-c85e3c1caec9@nbd.name>
	 <a583c9fae69a4b2db8ddd70ed2c086c11456871a.camel@axis.com>
	 <44ebe3fd-5898-4e48-a642-ee7457c0c032@nbd.name>
In-Reply-To: <44ebe3fd-5898-4e48-a642-ee7457c0c032@nbd.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.38.3-1+deb11u1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR02MB10280:EE_|AS8PR02MB9505:EE_
x-ms-office365-filtering-correlation-id: 14a26d01-e658-4692-dffa-08dbb0584876
x-ld-processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i20nqKDBcCAG+JQEluM0jb+n6nC+WTYjWgOS/l1HpT9BlkK2DseZgWfxxTDQPEnqf3i1YK2v16PBhmwmiyD2oraV8CKYNvLdARBHVsXxWx9kmvt25cCe4U7Ldc+BpOwZIR243Cdt4T0DQlFJ1CtrfuQGFRArtSoHNuI8dsm7PhrOfdpCqDBMpBj6lUEB5g9d9QvewP6afRTScaoSvlAE8Nb7oUFW5rMKyG7u7UHwMgAAzrhZm9p50KbSfyzzffTA3Xqt6on12ypM+szjausIUyOjioMsuT0nxitJ94WDUh+7Rgg+d2ipZSBbpu/JI/JKIA1QT3bYk3ya4/e9K0oSQFzSU0DDmYFmE9tbbNwzIapA6kaZiphhOOIYZAf1TSP9IpBSi+W4eqS0BOYx3uPM8mDUu7znT0Wak0bQcpPV/nALOsSF5LLsq+Oe4HMKiYM12v+TW+ChbT0gkHGmSgUDs+YD+0p5VOLBRgtgOiQcf17widvFS6DjP2aSeGcAxFzEdSRuI1m8geAtnc/wdIdkUjzy1Ovf3/15DwYvbhYfZ8KujeNvD3ZTZCRItWXQgTrZXsKKavWMxl/va28gqs51jBt7hyxeGSvDCLeN3Hyu5XU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR02MB10280.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(39860400002)(136003)(346002)(451199024)(186009)(1800799009)(38070700005)(36756003)(38100700002)(86362001)(26005)(478600001)(966005)(5660300002)(6506007)(91956017)(6486002)(66476007)(64756008)(66946007)(66556008)(54906003)(76116006)(110136005)(316002)(66446008)(6512007)(41300700001)(8676002)(8936002)(107886003)(4326008)(2616005)(122000001)(2906002)(71200400001)(83380400001)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SG95YlJUUDAzZUVRelk1MGhBUFR4TnMrb1BFU0I0M01QMTlIeE5XNGJ5dUxN?=
 =?utf-8?B?YzcycTlpaDArd01SVTNodFhGNHFxOUVST2ZaZlZnNE9aZUFrYTF2d1MzZG43?=
 =?utf-8?B?M3hSdnZsd09hcjRCd0dmOWJMVlk4cmlNcmFPMExJbER3a3Y3NVpjbk5JeU9r?=
 =?utf-8?B?aW45ekpNS3Uvb1JWdWhiWnhjUXhHK0ZxYmk0dmdQbU1wcnhEOUpqNXdDOGMy?=
 =?utf-8?B?UVR0RE1CSWhWRFFqQTUzR05SdmU3aDdXQlFCbmY1WUhNRjhheXJoZFVucXJx?=
 =?utf-8?B?UVFBdk5DT1J4aC9aMlBlTzZOeXpDWUM2SkNZVndyVktRTW80clNjZm5vcUsv?=
 =?utf-8?B?S0lPUWxQVTRKVVhWS1lZbWdkWk5LWk15aEFjMzV6dHUvRVJmWThIZWRMRUsy?=
 =?utf-8?B?S0FkUUtXVVA5ZDBTRmlnQmRhU0NnUXJmcDQ0bWNYNTFva00yT0RZMm54OTl5?=
 =?utf-8?B?eUowSWkvYTZwQTNLeSsrOVpSeXFIa2NMeEZPeDJKOU1wRzg2K0FXS3lxUWR3?=
 =?utf-8?B?dkk3Rm9NWXJCZWZJOTloVnJ1Z0pzUm9LY1ZZZHZzQmlxbWY5a0hJY2N2QlNs?=
 =?utf-8?B?am4wUldRVVk1N3R3a1k5aUxyT3J1eFpIeEhiYUk5MEN6a2cxdFVUK1lRdWxl?=
 =?utf-8?B?Z2NncUoyZWtkWEJPaTFCTjk4akN2OE55RXo2SG1OdHhPanJ0UGpjLzM5Z0lR?=
 =?utf-8?B?aEp0K0FUUEdqVmcxUEhYN1hmc1NEZHBVanRhdFFOSGlHM0V3TFVVRUs1aUQ0?=
 =?utf-8?B?Snl3MGlkWFZLN1BXQzkvVThFUTZyajNPY0xEYW5iWnR5TlQxVGxxN2JYTzM3?=
 =?utf-8?B?Zml5b0IvVE1lK0dFWU9KTTF3R1ppTFI3QXVFVHpWY3pST2krUUFaeWFmSW5u?=
 =?utf-8?B?YURVUUoydzlFRWNyK3pMRm5TSDFEbWlxMldZNWJqV2xLMVlNMkh6Rm53N1A0?=
 =?utf-8?B?SENmUnV4d21xckk4TlJRZEVVcXVaNkRnTHExUzlaMDlnejNTNWRRVC9PbkNa?=
 =?utf-8?B?N3luUkd5NHVrQnFjdzhiZEZpdDMyTzlFMDdVOTdHeHAvZWJ3aG9qWldaM243?=
 =?utf-8?B?MFBDRHdMZmJMQXRxNWloQ1ZIQWlLR2paVDRkdmhWOHhqQkpuUWhLbTdWK0hN?=
 =?utf-8?B?VHQ5bnVtNWFhSHNJanpNbXVDMUNTM2w1YmlGSjc2enQ4VDZxRTNQT2tjcWtJ?=
 =?utf-8?B?S1RLR29IaUh6M1htZmpZMzdVZyszWjRhTXkvR1UxOHVtSDZrUG9jZ3Q2VGQy?=
 =?utf-8?B?MGJaYmFlQU41M3FESG0vU25NaTdDUVpJZG0yMWxuVmdBUFlKbDlxQzRqSXI2?=
 =?utf-8?B?KzNDNkVUQ2g3eUZFREdVRlRCVnNiV082RFBnNEJUYllPODNXRXNqcUJlZ0h0?=
 =?utf-8?B?clBrVXlmWnVnd1JrQ3dtTGU5UEdRYWdtZlFhRVhoZ2pFcWNEL29FbDlHRitn?=
 =?utf-8?B?OTNzQ09KSVg5SUp5TzFRWFZDVEhmamZZbTQzUjdScDc1VmZaSFhpM0tvZTNa?=
 =?utf-8?B?MitaZWxkZmlvWVFiODh6YmRUZzdZTXM3SVRSQXZpNlgzVTRnTmJ2ZFZzQThR?=
 =?utf-8?B?RFVLZ211Wlg3cWZaK3FpZTlNM0lxNVd6aFlTRkpJRE1tR3JpUUgySVdwTGlr?=
 =?utf-8?B?eVFEbzlyYklOWnZ1aVRGa3Y2YkY4SG9YYXM5L1V4UU9HeWxjSUJkYXhva1I3?=
 =?utf-8?B?a0NsMzE2UktVME9rZkxqQ2EyakdUMUEvR0o0M2JLaTNWK3FvWXViK0sraFBM?=
 =?utf-8?B?UXppNExJc0YrU2N4Q3pMRDgvTHlhN1dRb1puQ1J6WlkyaUxZVE56VGROenEw?=
 =?utf-8?B?R0pWTks5NFdUS1JIY2NqQmRadG1BNGk4S0U4U3IvZnJ0REtIQzk5c3AwT1FD?=
 =?utf-8?B?bmIyMnhCNUM2Y2kvWGRVcGl2UUgwb0RpQkJNK2JYZmFrNDBRNmZ6MTRnRG45?=
 =?utf-8?B?bGJFWFZVOENzaG5vZXBJT0ZOdFErb1VTVForVHQzZHNCUGxBYXZOdGx4RWIz?=
 =?utf-8?B?RHJycnVZYlMyT3NJOFpqQXpWYVRTUDEvMVl5N29sdjlMODFzTzJhZ0pNeWpp?=
 =?utf-8?B?d2tLNVc4U2lYVTd2NnhKNHlYV2JSUFZWVXl0NEkya0kzdXRZQVBKS1Joc2Jk?=
 =?utf-8?Q?DQaoq07LJYjn7fnMpxumN7WTp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBA2231D4571E2448635ADD7C4F450CE@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR02MB10280.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a26d01-e658-4692-dffa-08dbb0584876
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2023 10:42:22.2084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4URLXroVU7MWmjM5sUoE7xNQeieF6Tw5nkJpwdxUFHJcyLD8YFsFINNnOeesFjUN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB9505
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

T24gRnJpLCAyMDIzLTA5LTAxIGF0IDEzOjUzICswMjAwLCBGZWxpeCBGaWV0a2F1IHdyb3RlOg0K
PiBDb3VsZCB5b3UgcGxlYXNlIHBvc3QgeW91ciBmaXg/IEkgdGhpbmsgaW4gb3JkZXIgdG8gYXZv
aWQgYWNjaWRlbnRhbCANCj4gYnJlYWthZ2UsIHdlIHNob3VsZCBtYWtlIHR4LXVzZWNzPTAgaW1w
bHkgdHgtZnJhbWVzPTEuDQoNCkkndmUgcG9zdGVkIGEgZml4IHRvIG1ha2UgdHgtdXNlY3M9MCBu
b3QgdXNlIHRoZSB0aW1lci4gIFRoZSBkcml2ZXINCmFscmVhZHkgcmVqZWN0cyB0aGUgaW52YWxp
ZCBzZXR0aW5nIG9mIHR4LWZyYW1lcz0wIHR4LXVzZWNzPTAuDQoNCiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9uZXRkZXYvMjAyMzA5MDctc3RtbWFjLWNvYWxvZmYtdjItMS0zOGNjZmFjNTQ4YjlA
YXhpcy5jb20vDQo=

