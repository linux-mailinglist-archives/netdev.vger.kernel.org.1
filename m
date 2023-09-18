Return-Path: <netdev+bounces-34560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE597A4A3A
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 14:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 295DB281E7F
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 12:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C9F1CFAD;
	Mon, 18 Sep 2023 12:56:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521F61CFAC
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 12:56:36 +0000 (UTC)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF8094
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 05:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1695041795;
  x=1726577795;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+FfO3OsaM1XpKlBed0L79/qqVZC9VE7BCY7cM+IxN/0=;
  b=cKu0YxeK/VFakKkRHpAJiSdaaD9Fo2FTTNJwb1cRXJY+LYzP7pPHesgL
   Z7JHZKeS0ient+Ws1SF0EjRwMpmIUsIIx3WYYx2iSKGJzWvZvYU27Pbz1
   QF21JyKow9xzdBwRLgdE0CAEjUzD9f3KdzuPVMmzvD5MtJQW7oYxBfQmL
   jhnc5ly7BB4aAf/m5sWR8DVgwo/oY5VHtrcrP1AufoGGUw+MV+fPYSSS8
   pL7jy77DvE/DpSgrvdPY+bgplDo8hz5C/HiZUVxe8eRjEsc0q18xt76Jq
   4M27lAI6kabvylzU6wZ4Xe4EM3B2JSVlbZ7UydxDzILha2jThIZucHlop
   g==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOGeym8/Z6c0OI2R79sBFq6jCMlggmYN6/+fgkoQQUvn2U7v6l3VZ8ySMkYfJ9lmd832itKzTtjun5+AHEm5szZxHYie3r0dKE+yunFrA1MheAGuUWlcBVBDpWSqLcMVpYlpx5F1DtmXJZGxDCoXBgPKdQtEwk2mzK9sX/eU9v/DpHVooVwNqKe4DQrExx18ucAFYeGg5j7R7fNZGHIk57V6LYA51yQ4FK2/ynG7/e3eQmzuNHJ7JmVKg4h8Hav5DYZoBpeVBGHwnGj00WQQ/MmRunNIkqYOx2ZS1vpNrQseCLLYunig1VaUB66vMOThHlHzs/8JxA2QopiI7KjBag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+FfO3OsaM1XpKlBed0L79/qqVZC9VE7BCY7cM+IxN/0=;
 b=IEhf0In3s9+WdrKhfIYBbw++VO0WIST7/cSv3QEatyDOi6stylMVdeRf6pCcbffsrTPnJbU3WMvbxfWmAy1SKgj+BnCd/FblvQUpmHyrxnHgU7PO7vkqX8SVqlX5fabq8fssaLdrJdo8+WJJIS3T6/abNwy/6jzjG1HsnVVG7FiWEDkfYtS78FamODHAWM3+J8z2rbEKwPZn8EkF4+Im4/wznA7BcmiYaezamfyDbIZH4+gB57GhDtzCy7mMLWk0QC01lJ+DZP0t028pMu8ajYDQ/DlzNKF4KiHUwAv8YVlNL8+JoxaceGTqL+bB7rUBt0Va5W5SoKFZKS3C3ha9WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FfO3OsaM1XpKlBed0L79/qqVZC9VE7BCY7cM+IxN/0=;
 b=giyHtFERlmSUfrJO1DW4Tze6PsDTgs7/rzPbXhJOoeDeo0cf57EYs0L1oiN7r+nynBs++GWLPJREchH0v66Y8XBxcY+3SMzQ4TCkSmsa1PYT273kMcem8FH/SmLJjNjsIH8DcdK4sZvGtTlmzKwX/5GCpeQwmDe4O7nUB3YSh78=
From: Vincent Whitchurch <Vincent.Whitchurch@axis.com>
To: "maxtram95@gmail.com" <maxtram95@gmail.com>, Vincent Whitchurch
	<Vincent.Whitchurch@axis.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "nbd@nbd.name"
	<nbd@nbd.name>, "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
	"joabreu@synopsys.com" <joabreu@synopsys.com>, kernel <kernel@axis.com>,
	"peppe.cavallaro@st.com" <peppe.cavallaro@st.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] net: stmmac: Use hrtimer for TX coalescing
Thread-Topic: [PATCH net] net: stmmac: Use hrtimer for TX coalescing
Thread-Index: AQHWv04gJ8ZamJtkVky0JUyVF0YJta/+f16AgAK1/wCAAEHkAIAHrjMAgAA0/YCAHYYIAA==
Date: Mon, 18 Sep 2023 12:56:31 +0000
Message-ID: <1b485fa168f2862adf3f0967a04a7f0e1a99ffe3.camel@axis.com>
References: <20201120150208.6838-1-vincent.whitchurch@axis.com>
	 <732f3c01-a36f-4c9b-8273-a55aba9094d8@nbd.name>
	 <2e1db3c654b4e76c7249e90ecf8fa9d64046cbb8.camel@axis.com>
	 <a4ee2e37-6b2f-4cab-aab8-b9c46a7c1334@nbd.name>
	 <f3c70b8e345a174817e6a7f38725d958f8193bf1.camel@axis.com>
	 <ZO-E2_A-UrC9127S@mail.gmail.com>
In-Reply-To: <ZO-E2_A-UrC9127S@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.38.3-1+deb11u1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR02MB10280:EE_|AS8PR02MB10034:EE_
x-ms-office365-filtering-correlation-id: 5a5b0836-2e55-4256-703a-08dbb846ae4b
x-ld-processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x1s4r2bgLwoIMjWXQtbT3P4TeSwWtM6fqxcmmQffEfySqpzVBma50SGQ3V57pc1EVsMbrdV8A8E5LF4Z0wCNDQaLCjS30VLMR+hJsjqC7ghjmjgrOKVH8B6d2WnvCBC7UgafGsxxWdoxynoSE6aqd1hGklL1QGgf/jccV64ikfYJyux8DLv4edHzd0rYlaDAkTmENK8JtbxoENHcExINfSGi/rpxlcCfwXwSrBe3AHJNgUgyOmx/GE10fXvIADvfivDAM6o9xjzFU8Q8F1BGqUyC+YGHnA7iXrxyjRshAVo9haGILGDcGEBmfmOthou5D+FLtFP0Qe6fvV7uOaSfmScgcaJARnZpJN776yJ6TDCxNju+0vMvUvcQD32KsvKM30mT7nFUWRuhrKRDyf3Cbl9kbeUwkVoJLK8dnbpKIECMik96YleaQPSonadHNT7j45EkJUUOe/g3PJJ5HPxDvwjeXxgXPH98o2rzZlAFWofMf1qgz9oIaYaKxwFBHCuvh2V+MrNwFg0CBPJNqEPvTt0e6OwkcI6bG25S/wobTFpaNdjj+BxX8wLzqVgppG3goPOIeeGAd/5Y50CaQIakUgRQoiJTPLfJpVpLJxE0ITo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR02MB10280.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199024)(1800799009)(186009)(6512007)(6486002)(6506007)(71200400001)(83380400001)(122000001)(38100700002)(86362001)(38070700005)(36756003)(2616005)(26005)(66556008)(110136005)(66946007)(66446008)(54906003)(64756008)(91956017)(66476007)(76116006)(41300700001)(316002)(2906002)(5660300002)(4326008)(8936002)(8676002)(966005)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1pQVmtZelhRbVhBazBWV2xBSStYSm56OGZpOGMyUnF0amZvazNyN25KNVA0?=
 =?utf-8?B?YjFoTkJ4blJEZ2t1NmpRd1NxdUg4L1hGcm9Fb3ljVG9UVktnQTdsR201RWxU?=
 =?utf-8?B?MmVONEdUYklrQmhGU0hOYVRTRjFRdlB4Q0haSlZXNFdIRVlrOW1zS2N6bEtj?=
 =?utf-8?B?V1pnNkF4K1VYT1lmS2lmTnp0UzdnNWdhd1o5VnRQbFZqb3ZsaTBGTm16MG5z?=
 =?utf-8?B?LzhsYVEwRmVGMjBHRkU2Y3Q1UGZBRGZSWXkveEhWMDNUZ2c3WmovSXdlZnhz?=
 =?utf-8?B?SFZrNUdNOFdxV0dYem1SMitsK3EwUEJ2NHFGb2E2VlJBbUMrb0F0NllZVGts?=
 =?utf-8?B?ZkV1Qm9SVytvenJOTVU5V0JJTU5jbjdwankzY2xNVTVvSlY1MDBaOXl3OFl1?=
 =?utf-8?B?dkluVFBxTHNYRjBHM2h5eUorRy9tOW9YeXdPM2pmaENlZk4xZUdpU2EzT0VX?=
 =?utf-8?B?RjJZMitzWUIzaitBSlNCUWY0R1hCZVJtOHRIQWhjTTloVGtZTGJPUXY2Wm5H?=
 =?utf-8?B?WnNVcGg0UWNma0J5OXJHWGFGdGxiQ2JibWxabTc4bnI2SGNRbjdHdHMzcDds?=
 =?utf-8?B?dDB5RDdzOUpUdEJsQkUwYzhiQVpYZG02ZGlGZDVCeXdPY3J2VnBRNHVCSTJJ?=
 =?utf-8?B?KzRlM1IxUG9XaTd6bHRtOFVSMzdsS1JaZHBJR1RLd2d2QmdZVTg0SmhjUVVM?=
 =?utf-8?B?NUdOYkNJdGhwTlZYbDRZNjR5WGJ0K3NHMEhUckkzUWxrcUN3YmY0dTE1S1lU?=
 =?utf-8?B?YXo0c2UwQWo0dUdWY2Y0cHJ1b2hwbVI1MUQwbnBDb0dDbU5Tcm9VNE5iUndN?=
 =?utf-8?B?SlQvWlAwNkJscENnWnpndkxWZ1F4a1YwOHdGRmc3aHNxdjBVd2IzcHhxY0dr?=
 =?utf-8?B?Qmo0R2lvY3pqUVppbFQ4djJwbmRYbU1vaWpwVjMrYXR1V1F6T1RZU3NLK1JH?=
 =?utf-8?B?K1BEeHU5RWo3bjdsdWVLYlUybytNZlIySW16d1pBTlRqSGJjTmZ3Z0NQcm13?=
 =?utf-8?B?dWNWUWFyZnBkUXZpeS80NFc4SmNmVGxIMWliZUgzZXcrMkV4MFB6QkwxUWhF?=
 =?utf-8?B?cWZRVkNoLytySHByVzZsVVU3SnB1UDJXdlJFenpSU094Y3dZYUR2Q3RxdlRj?=
 =?utf-8?B?aHR6WnhwYUFIM29VUnJ6YzNQTlJ2Sk5WMjJHaHJOM1A1aU4veGwxRG42THRD?=
 =?utf-8?B?R2RaVXllOFBZNnJFMUhJRkhoM3lHV2EvVGJUeXBSYzJPa1o1clZGQkR0MVo3?=
 =?utf-8?B?NXc3WTlwOU9lSVB0NkRJcXdFbzZ0czI2Q2JoR2U3VkdDOHk5b29Hc1E3S2pH?=
 =?utf-8?B?U2Fqd1ZmR0l4R1pWY3E5cTZLekdBaDhEaWJURG5QWE84QWQ4QTRQaUpnODBn?=
 =?utf-8?B?MUdBZm9QanJsRCtGb0tXdERsVENpVlMvKzJUdk13Ui9SbmJ3YUxHa3p6VVYw?=
 =?utf-8?B?NjdPOUNvN0VCVmxudGh1ZURzVFc5SHNRYThqMnVGTC9xdkg3dFBvUWFnd0p0?=
 =?utf-8?B?UnlTdXpKbEM1WTNqM0hpdEV0TWhIN09QUFcwRHAvVHp3Y1ZEdU94eVp4UmZZ?=
 =?utf-8?B?MlJtQldPT3dYbTFRQTkzaW9oWjlNUGE0UXQxN1hyTHRpbGZIS0RFUFpveXRE?=
 =?utf-8?B?a1JTK0pNdkdhNVpLU0svSGhQdGN4anQ5QWpXd1cwbVJ2V0kzOFl2WHpUa0da?=
 =?utf-8?B?R243NmRwa25yb3dtR3dEY0FQMi9iZ1crWWdLRUdwcVVKZ3ZFbExLS1IwOVJQ?=
 =?utf-8?B?VHJIS0VMRFFET25FQlU1eEc0dytzdTNpOWl1bVNVUlIvbVZ2WFJxeVZDU0xP?=
 =?utf-8?B?WjR3SHlTMnR6UnEyN3V2c0l0blE3Ujh2RUl5SVE5YmEzNGNCdTBHOVo5SEVV?=
 =?utf-8?B?L0tkL1FNY0pkMVNWUWNrQ2lwWnJaWVladUdmRi9JRFFqcENaUzNKTzNmMitF?=
 =?utf-8?B?ZHRSaXNEYWVPZWxsNUQvMlZwNDFKRUpuNFRlckIyTVRUS085OWZ0WVN5MS9Q?=
 =?utf-8?B?eEpPSWdGQk9jZS9GRzFscEJFQ2dTTU5VNUZWbDhsTmM5WW9pNGF3dXBqZWZl?=
 =?utf-8?B?eVpETzRuOVNJd3BWcXBGdHlqM2pac0gyY1I4NDhpVWFxdHQ5WnIvdGxoV0NQ?=
 =?utf-8?Q?0zDjbDzt5qD+gpGBgHOicqKq6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6ECBE68BB503B345B6B7F7D12728EA74@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR02MB10280.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5b0836-2e55-4256-703a-08dbb846ae4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 12:56:31.4348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aJ4LAhMZR+Ur//1dvUOwZA5zcwhjxE2ttS2d5iS1oI8bqA3USKf9ndqIakgcJ1Hd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB10034
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,TO_EQ_FM_DIRECT_MX autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

T24gV2VkLCAyMDIzLTA4LTMwIGF0IDIxOjA1ICswMzAwLCBNYXhpbSBNaWtpdHlhbnNraXkgd3Jv
dGU6DQo+IE9uIFdlZCwgMzAgQXVnIDIwMjMgYXQgMTQ6NTU6MzcgKzAwMDAsIFZpbmNlbnQgV2hp
dGNodXJjaCB3cm90ZToNCj4gPiBBbnkgdGVzdCByZXN1bHRzIHdpdGggdGhpcyBwYXRjaCBvbiB0
aGUgaGFyZHdhcmUgd2l0aCB0aGUgcGVyZm9ybWFuY2UNCj4gPiBwcm9ibGVtcyB3b3VsZCBiZSBh
cHByZWNpYXRlZC4NCj4gDQo+IFRML0RSOiBpdCdzIGRlZmluaXRlbHkgYmV0dGVyIHRoYW4gd2l0
aG91dCB0aGUgcGF0Y2gsIGJ1dCBzdGlsbCB3b3JzZQ0KPiB0aGFuIGZ1bGx5IHJldmVydGluZyBo
cnRpbWVyIFsxXS4NCg0KVGhhbmsgeW91IGZvciB0ZXN0aW5nIHRoaXMuDQoNCkhhdmUgeW91IGFs
c28gaGFkIHRoZSBjaGFuY2UgdG8gdHJ5IG91dCBGZWxpeCdzIHN1Z2dlc3Rpb24gb2YgY29tcGxl
dGVseQ0KZGlzYWJsaW5nIGNvYWxlc2NpbmcgaW4gdGhlIGRyaXZlcj8gIEZvciB0aGF0IHlvdSB3
aWxsIG5lZWQgdG8gYXBwbHkgdGhlDQpwYXRjaCBhdCBbMF0gKHRoZSBjb21tYW5kIGJlbG93IG1h
eSBhcHBlYXIgdG8gd29yayB3aXRob3V0IHRoZSBwYXRjaCBidXQNCnRoZSB0aW1lciB3aWxsIGNv
bnRpbnVlIHRvIGJlIHByb2dyYW1tZWQgYW5kIGV4cGlyZSBpbW1lZGlhdGVseSBpZiB0aGUNCnBh
dGNoIGlzIG5vdCBhcHBsaWVkKSBhbmQgdGhlbiBydW4gc29tZXRoaW5nIGxpa2U6DQoNCiAgZXRo
dG9vbCAtQyBldGgwIHR4LWZyYW1lIDEgdHgtdXNlY3MgMA0KDQpbMF0gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvYWxsLzIwMjMwOTA3LXN0bW1hYy1jb2Fsb2ZmLXYyLTEtMzhjY2ZhYzU0OGI5QGF4
aXMuY29tLw0KDQpXaXRoIGNvYWxlc2NpbmcgZGlzYWJsZWQgaW4gdGhlIGRyaXZlciwgdGhlcmUg
aXMgYWxzbyB0aGUgb3B0aW9uIG9mDQpwbGF5aW5nIHdpdGggdGhlIGdlbmVyaWMgc29mdHdhcmUg
SVJRIGNvYWxlc2Npbmcgb3B0aW9ucyBhdmFpbGFibGUgaW4NCk5BUEkgaW4gbmV3ZXIga2VybmVs
cyAoZWcuIGdyb19mbHVzaF90aW1lb3V0KSwgd2hpY2ggbWF5IHdvcmsgYmV0dGVyIGZvcg0KeW91
IHRoYW4gdGhlIG9uZSBpbiB0aGUgZHJpdmVyLg0K

