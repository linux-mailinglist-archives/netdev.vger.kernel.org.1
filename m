Return-Path: <netdev+bounces-30688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CBE7888D1
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 15:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FD64281845
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 13:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55285DDD3;
	Fri, 25 Aug 2023 13:42:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469AA20E7
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 13:42:35 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8348E6F
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 06:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1692970953;
  x=1724506953;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=J4kDP0Ydengl2QwE8AZZMW5O/5iGZ8V6uvnoJ6jnIH0=;
  b=DaPtDX45N/h7pJfP3mOUqRXIL+sLD0EqM8kd7ibjzpFccvo3q7cRjMyW
   qF2uzdMpK6QOKFAwP0iNEqnNSsJtunr04DW/xaAikrAT8CXFr+s2BFIDV
   d1RTT2wqc/ndZQJH0D6HQy1+7czlsq9or/SjunG3HeNfnBhOkYzjeM41j
   2ohhdOLc27W/DyqatPYNWfOrutFWGyruOVJ2fMsB+ZUNvCd0Qswbnr066
   6en8f5NRKWszZ08L2fNGwqQAzZk3EBOTU6FI7hzkd3VU7nY3FHu7kT9q6
   hx2J0qsHsn1Q9RIqMUimWhhJAZZ1W+7sRw5ajkCDhwvlHw+V1RfIEdoKk
   w==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyUB72BggMOSz5qprLZuYP1TYP9tCRebC5vSjPXnVx8aNeSO0ZRuv7saZjEz6fvX/hGCZfBlGIKnmx8RDII3d7Sc3cG8ez2CTCPAmtL6s6vP1uOu9cRUt4iY5y6jfGGlS0yp+AmGkSxtjqMPYCJL/yXL8F4cMvs1CuuMM9x99/D7GhSsbfNTo90QKSd/mTKzBbNfJD7FP22lzdvTKcctd6fkyeFkNRtnPtJrMgFTaYVUu5oy0FUQjpNIhskUWKiWBWd/Q4THio21+l2QUUQ4FOENDUiw5GMPQ2R1uyYSouNersPXhj+ksg822jd/9h1364hJLPn5xZCFjMnp+tVFyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4kDP0Ydengl2QwE8AZZMW5O/5iGZ8V6uvnoJ6jnIH0=;
 b=UWPMghnyHw6PsZNpF4gPq5/+y70/Wy1pF/GwwnVNc/ohTjpUoaflACaPOVx6pm23S4T8pLYxys/lIGMv7H5ikOdzrXQhCe8J4eSOG4u423UqWum06uakDCva7ZXMGr2vlea4hOWSfdX69drCMNmvvGUjsKzYffDcOOUGz74hYqDNqUJx0VKV0LnO4vnDJIS0uriBGvP+XjQSiYAWGkjuObS2W20P1VPzaDYmPmnbgzV1VkiynjKzz0uYTpgAl9nyoL/JIT3vMx+jEbOzBmpuHJFVF0Y1fZ8owVeotctG8GQqxO9ToBHM+n3kMMhKUydoQeDFjExKl0ZTjfBuUfcong==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4kDP0Ydengl2QwE8AZZMW5O/5iGZ8V6uvnoJ6jnIH0=;
 b=IEoYFzSbQse9ahf8K7haY9NMHRpasiz7JukJqD+89IY3parV+jpAWfhgJUDSI5c+HHBIZEhKCKXagAH2Mj6fLSDWN/4+bYP48uEe5BIqZA7K6y3AuSvY5emlyMfc/rljpsx31jCn4x3F2AeButVsJI2e5hmak6HC0rP+A5C4jBE=
From: Vincent Whitchurch <Vincent.Whitchurch@axis.com>
To: "nbd@nbd.name" <nbd@nbd.name>, "kuba@kernel.org" <kuba@kernel.org>,
	Vincent Whitchurch <Vincent.Whitchurch@axis.com>, "joabreu@synopsys.com"
	<joabreu@synopsys.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"peppe.cavallaro@st.com" <peppe.cavallaro@st.com>, "alexandre.torgue@st.com"
	<alexandre.torgue@st.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, kernel
	<kernel@axis.com>
Subject: Re: [PATCH net] net: stmmac: Use hrtimer for TX coalescing
Thread-Topic: [PATCH net] net: stmmac: Use hrtimer for TX coalescing
Thread-Index: AQHWv04gJ8ZamJtkVky0JUyVF0YJta/+f16AgAK1/wA=
Date: Fri, 25 Aug 2023 13:42:29 +0000
Message-ID: <2e1db3c654b4e76c7249e90ecf8fa9d64046cbb8.camel@axis.com>
References: <20201120150208.6838-1-vincent.whitchurch@axis.com>
	 <732f3c01-a36f-4c9b-8273-a55aba9094d8@nbd.name>
In-Reply-To: <732f3c01-a36f-4c9b-8273-a55aba9094d8@nbd.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.38.3-1+deb11u1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR02MB10280:EE_|AM7PR02MB6289:EE_
x-ms-office365-filtering-correlation-id: c6e0c763-b64e-46f0-1bb4-08dba5712048
x-ld-processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EGRwIEPqyOjo6SBWIx0at6GVYztQvQt6PFNz8IBFvbIywdCUjXc8J/LuBafZiIz8Qyf7sCFAl9cOOTBRvMRui6Ds9T+wjUHMMhIKFEbboMR6WYgbH6VNMX2ACI1cWas9Lfm14YJTjr0hOs9dIDR4tke3iymg0blV2ThlMUDBeYXJwhOfBybi4UW8ZYWbunm3xXmak6NaTsy+PWonufia1f7bky1LoaMjApW7zIWbTFvAifxdb93a7OowyPkItA6Rx518HCSjPs0hhAl2/zl/+rAGRCJH/1Umv1v75C1tl5X71xpyWh/dyGEBAooDEtZeJDQKIPVaXgpshAcji3tiBkpYXWbwW5d47Vgvt+jZB1EvaZtZmO8TTNmBHiHNqnJj6OLbfZa1smGUmx1cQgSxEdEKlegjNMUFN9eldXWMPLMyhuwyGqCv8OOE/SZk8Jlz3Ia+i+xa4cqYlCKaYmncYb9fAc1+Ni3x7j0EY/EyiUrpOGiYU62dNo7HdrVy6YOMjbG8vavu1l2fwrQuqu4UFm37bkShCcqWzk+ZRifUY/UaQv0y50R7g9CDgtFw1QocJajHuVdz2fRof2iqB6LoCRvcf9lKm9jZi1FjdbDJHuw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR02MB10280.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39850400004)(366004)(136003)(376002)(451199024)(186009)(1800799009)(86362001)(110136005)(54906003)(71200400001)(66446008)(66946007)(64756008)(4326008)(76116006)(91956017)(66476007)(66556008)(107886003)(478600001)(6506007)(26005)(38100700002)(316002)(122000001)(36756003)(6512007)(966005)(2616005)(38070700005)(83380400001)(8936002)(8676002)(6486002)(41300700001)(2906002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWJPTStYY0Eza09UZVM4ZUNHU01TQW0vY2FwVzFrMFk0SFR3NDJzc1A1NmMv?=
 =?utf-8?B?Q3dTSlp2MzhQdlhGYk1FU2VscEZHVG1TV2YwbzdDbjlUeGFkWGdCQnZIQkti?=
 =?utf-8?B?R0QxenpXUUJyWGlKTkdBcklrdlhnQUZTL0NLbmlad3pXNlZsQjdtZFNuZ3or?=
 =?utf-8?B?M3JORk5NODQ0UzRoQSs0MHl0bDdMNjhheitTa2p0RXFKTDdBSmZZa0dQNUdM?=
 =?utf-8?B?YXRUcklLNmpaVytSc2N4UUhscGdGYTVzOHZJUG00VFhjQnk0RzlINUZ3Y2s2?=
 =?utf-8?B?NWxmcTVjRnN2OVpMVGljOExoSmprbmYzMDFYSHp1T2dBaGZ3UkVFeDYxQVU0?=
 =?utf-8?B?SXB3ODA3NVFzbTFlK3dmTEdpcmt0ZWY0OEc2QzBpOENxNmdWcUs1bGhTMnRH?=
 =?utf-8?B?cUdTTnAxUnI2WVdIRnVOa2V0dkEyMWIwOU9qeWhBZmRlSExiZVZteWpYZ0xE?=
 =?utf-8?B?OSszZHIxdFFBdGluOTR3RVBCS2JmckFzZzhJSmRySEtzRStEQmhZQ1Jwajhm?=
 =?utf-8?B?bU1OdXBMQzlqSWl5ZWNpUkdkZXFMM2ZZdExsRXpMWGRkQk9ydUVrdU4zRFpL?=
 =?utf-8?B?emtKM0RsUTh4VmNyUmI5eDAvdXdzYUNDMEswc0lST0xVc3NtT2pRZFB2aFFy?=
 =?utf-8?B?MTV1VUpWZUpzOUpwR3pvYkNQZWdlVWgxbWMrdEE2RmErN2owdGZUYlpZQWYz?=
 =?utf-8?B?dW1qTUp6R0lpTnllZ2d0M0lDTUpJTmlRT0FzRHVJSFRzUkM1dEtMR3h1Zmcz?=
 =?utf-8?B?WG5YTkJ4d2dOQlZlS3QzL3ZTblc0M1YvWDlEdHBsa2s5UFJ2VEtTaUMxT2Fn?=
 =?utf-8?B?V1lVcVZiMXJOQVM0U0RMblE5NE5RTTVMdEcxNXJJVUx5Q3d5d1UxWStqYTlw?=
 =?utf-8?B?d3RRNWpVTWpRb0N0VEtWOFUzSDlVazk4b1pteWV4cHNZanVoRnJEQUFDVExK?=
 =?utf-8?B?MnRVc3hTQjVSZDN0VFhDZG44TzRTNWlLRk1jejZyRGpLWHJ0OW10MXRvVnZj?=
 =?utf-8?B?MjJ1ZTFSQ0NxallpbTNXM2xhSDU0cnJFWi9UU3JxQlQ5di9EV1VKMHQ0dEEw?=
 =?utf-8?B?b0hKM0V5RFlFdXUxK0IwdXMvWUhlb3lQMS9ocDZBZFRzVUMrK3Z3WnBHQ1NF?=
 =?utf-8?B?c1FDTGVMUUJlWFV5Rll4UkE5Q0J3YUdtUVhjZkNtbFl0MDRJQk8xbDNOSmp3?=
 =?utf-8?B?UEdJSG9mNm9sRzloaTM1OWZCUDNYZmUwVVY0M0JCa2FuMVZ3UEU1c3c0OExP?=
 =?utf-8?B?c0NkV2pldC9UVmVsd0dOeHdLeGFodCs3V1NIRDFZRTErbkhzZWMvZUJab1hI?=
 =?utf-8?B?NXdnNFVSSlhUSEU0ZzJBZ2ZEbHBvUkI2cHdYSk14TGk1cC90VnUxa3M3OWY2?=
 =?utf-8?B?NDNmM29lRFV1cjJKT0Q3NDc0eDEzdElPZ1Jra3FHYjBjc3FFa1NuVXd6NTcy?=
 =?utf-8?B?dFh0dWY5RERTamFnd21uMWE1U0tpVFNqMHhtS3Yzak96dk5YTDdabUJORWZE?=
 =?utf-8?B?SjBjd3VhRkx3RnB1Z3BieXFWeUkvTWtaUFlua0M2OW5OM0JFSG4yVm5SMTFY?=
 =?utf-8?B?R0JicE9YMXdPRG1rcWhLRm13RlJNSUYwU210OWxxR1UxbVJxekxkSjRUR1No?=
 =?utf-8?B?bkZhdDdhNGhKd2lMY2Y3L2twVWlRSmRqTGgvSUpFSkN0aTd4V1ZYL3JyNVln?=
 =?utf-8?B?bkhmYVRNdFptK2xFRkZ3MC9ObDVKRzRHN3U3R3d6ekJVQitKWDY1amptSHoy?=
 =?utf-8?B?L1Nod1BabFNnS01reGduODFtaWw4aU9nMUUxUThJcTlkTmpsOFphZEJ1RWJ4?=
 =?utf-8?B?Y0JXZ3BwVUMyVHRpeUdva2o3Ky95b2t6SHM1SFlqekhrMFJieWthMkp2NWZS?=
 =?utf-8?B?bUlua0NLVzdibjFaYkZ6aGdkNGRTbE95b1pGWXBldHZEcTljVjFqNTRZNktO?=
 =?utf-8?B?eWcwVFcrVkhhSzgwRDRDTzgxUll5YVE3bWRmRmFoNWgxQWRJa2tDWlA3cTJZ?=
 =?utf-8?B?bDdlWlUzTlhFVFNSOWJVYThRR0g3SjY5dDJrS1Z6SEhUNFVvM1NZbU9jOWxM?=
 =?utf-8?B?d1RZOVJKam94WUN2YVUzTDV3cUZYRDkyV2FXSmJtclpZY1ZiRWt1NHI0K29O?=
 =?utf-8?Q?/4eTYZhYLngYSmBE9ccU7boab?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <355B25808F90E24E9E9ADD311808E927@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR02MB10280.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e0c763-b64e-46f0-1bb4-08dba5712048
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2023 13:42:29.4320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IwnmSG6RbVWHGfcgiKDdpugmTl4+YpGrNB45zfSWkoTrJ/9/ojp6Ykt/MBisEGZg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6289
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

T24gV2VkLCAyMDIzLTA4LTIzIGF0IDIyOjE4ICswMjAwLCBGZWxpeCBGaWV0a2F1IHdyb3RlOg0K
PiBCYXNlZCBvbiB0ZXN0cyBieSBPcGVuV3J0IHVzZXJzLCBpdCBzZWVtcyB0aGF0IHRoaXMgb25l
IGlzIGNhdXNpbmcgYSANCj4gc2lnbmlmaWNhbnQgcGVyZm9ybWFuY2UgcmVncmVzc2lvbiBjYXVz
ZWQgYnkgd2FzdGluZyBsb3RzIG9mIENQVSBjeWNsZXMgDQo+IHJlLWFybWluZyB0aGUgaHJ0aW1l
ciBvbiBldmVyeSBzaW5nbGUgcGFja2V0LiBNb3JlIGluZm86DQo+IGh0dHBzOi8vZ2l0aHViLmNv
bS9vcGVud3J0L29wZW53cnQvaXNzdWVzLzExNjc2I2lzc3VlY29tbWVudC0xNjkwNDkyNjY2DQoN
Ckl0IGxvb2tzIGxpa2UgdGhlcmUgd2FzIGFuIGF0dGVtcHQgdG8gYXZvaWQgdGhlIHJlLWFybWlu
ZyBvZiB0aGUgdGltZXINCmluIC0+eG1pdCgpIGEgd2hpbGUgYWdvIChwcmUtZGF0aW5nIHRoZSBo
cnRpbWVyIHVzYWdlKSBpbiBjb21taXQNCjRhZTAxNjlmZDFiM2M3OTJiNjZiZTU4OTk1YjdlNmI2
Mjk5MTllY2YgKCJuZXQ6IHN0bW1hYzogRG8gbm90IGtlZXANCnJlYXJtaW5nIHRoZSBjb2FsZXNj
ZSB0aW1lciBpbiBzdG1tYWNfeG1pdCIpLCBidXQgdGhhdCBnb3QgcmV2ZXJ0ZWQNCmxhdGVyIGR1
ZSB0byByZWdyZXNzaW9ucy4gIFRoZSBjb2FsZXNjaW5nIGNvZGUgaGFzIGJlZW4gcmV3b3JrZWQg
c2luY2UNCnRoZW4gYnV0IHRoZSByZW1vdmFsIG9mIHRoZSByZS1hcm1pbmcgd2FzIG5ldmVyIGF0
dGVtcHRlZCBhZ2Fpbi4NCg0KPiBNeSBzdWdnZXN0aW9uIGZvciBmaXhpbmcgdGhpcyBwcm9wZXJs
eSB3b3VsZCBiZToNCj4gLSBrZWVwIGEgc2VwYXJhdGUgdGltZXN0YW1wIGZvciBsYXN0IHR4IHBh
Y2tldA0KPiAtIGRvIG5vdCBtb2RpZnkgdGhlIHRpbWVyIGlmIGl0J3Mgc2NoZWR1bGVkIGFscmVh
ZHkNCj4gLSBpbiB0aGUgdGltZXIgZnVuY3Rpb24sIGNoZWNrIHRoZSBsYXN0IHR4IHRpbWVzdGFt
cCBhbmQgcmUtYXJtIHRoZSANCj4gdGltZXIgaWYgbmVjZXNzYXJ5Lg0KDQpXb3VsZCB5b3UgbWlu
ZCBleHBsYWluIHRoZSByZWFzb25zIGZvciBtYWludGFpbmluZyBhIHRpbWVzdGFtcCBhbmQNCmNo
ZWNraW5nIGl0IGluIHRoZSBleHBpcnkgZnVuY3Rpb24/ICBJcyB0aGF0IHRvIG9idGFpbiB0aGUg
c2FtZSBlZmZlY3QNCmFzIHRoZSBkcml2ZXIncyBjdXJyZW50IGJlaGF2aW91ciBvZiBwb3N0cG9u
aW5nIHRoZSBleHBpcnkgb2YgdGhlIHRpbWVyDQpmb3IgZWFjaCBwYWNrZXQ/ICBJcyB0aGF0IHJl
YWxseSBkZXNpcmVkPyAgQWNjb3JkaW5nIHRvIHRoZSBjb21taXQNCm1lc3NhZ2UgaW4gNGFlMDE2
OWZkMWIzYzc5MmI2NmJlNTg5OTViN2U2YjYyOTkxOWVjZiwgIk9uY2UgdGhlIHRpbWVyIGlzDQph
cm1lZCBpdCBzaG91bGQgcnVuIGFmdGVyIHRoZSB0aW1lIGV4cGlyZXMgZm9yIHRoZSBmaXJzdCBw
YWNrZXQgc2VudCBhbmQNCm5vdCB0aGUgbGFzdCBvbmUuIg0KDQpTaW5jZSB0aGUgdGltZXIgZXhw
aXJ5IGZ1bmN0aW9uIHNjaGVkdWxlcyBuYXBpLCBhbmQgdGhlIG5hcGkgcG9sbA0KZnVuY3Rpb24g
c3RtbWFjX3R4X2NsZWFuKCkgcmUtYXJtcyB0aGUgdGltZXIgaWYgaXQgc2VlcyB0aGF0IHRoZXJl
IGFyZQ0KcGVuZGluZyB0eCBwYWNrZXRzLCBzaG91bGRuJ3QgYW4gaW1wbGVtZW50YXRpb24gc2lt
aWxhciB0byBoaXAwNF9ldGguYw0KKHdoaWNoIGRvZXNuJ3Qgc2F2ZS9jaGVjayB0aGUgbGFzdCB0
eCB0aW1lc3RhbXApIGJlIHN1ZmZpY2llbnQ/DQo=

