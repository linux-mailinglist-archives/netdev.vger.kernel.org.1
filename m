Return-Path: <netdev+bounces-14824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 256D5744038
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 18:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFC2228100B
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 16:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E2F168BA;
	Fri, 30 Jun 2023 16:57:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F13107A4
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 16:57:35 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::600])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DE64205
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 09:57:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOq4vEYMyyL7fQ3hpYaNMiBfzjWqeMKZ/rVe+DoUy2GaUYtviTjSV4Bmdx5ijPRPKua3fzjh+c3IJNCnhE52fVDGRxrS0BDuco2v06IIqhlY0kqMlB0rdBFKV5oBdnV3BrbQAbWInZk8yuKuRNsuB5cHcl7rDTvP0kwGfPTTcK7IxTgigc+zz/SzCE96lQ60HMOMdjqwal/WZ4PSqpIFqb2WKG5M1xWyN6c7wpqPIZkZoB5TXE6L54iM/Papsb6m0NqLe03nxgtgWfIxlE46ekF1ZrJFXoC+07H207uRKuWYE5+iqhy459Y++80wN0StuzPP4a+ljjHSGcJ1v92Y4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucOqHyjyfnsbgbux2MZo6CUVV5TLG8Jr22kAts5dzq4=;
 b=MW344kYgeoWnk3voM4z/K1dsub8Ss4jZGAOqUPjPNkfz4kAYs3YWeANkf3RwR926se7RIaX8zQVHK7Uv3f/3kotLU8UtF4KcDZQO9T2jTYXPlRiT+l2cxQghuEYq5c6i//ON6ZR7Rgl20GvjXn7xvVCy3pKv38jk9Fu3yv/QI7SEoPqbf6WGGEHNAp81Hr6Cdg0G4v2g0wdUf+11QOyjXV9JfvoKBRTN65x8tnI42DTO0i57py4BP9HRQ3Mc0Yp9tsdEUR1M0FFSIJVfW/6/Vce+eUF/LKrFDq84zTjHuHgkq4nbLP9wwFlyv+JfkJHZ4M9chG+zSHNBnMuWybk5wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucOqHyjyfnsbgbux2MZo6CUVV5TLG8Jr22kAts5dzq4=;
 b=Tx6lEbUXzntKuOobH6reEMcWqmBhhiesx4q6wyUk8lCeWhTyV25VTVJq/EEJgPPIKWrt+pV1kxxKvd3jvTnXw0CgR0I7RnVI5skY81J7rHB1NRkXHRKbCW2VKUIxke1be75wQF87IJ7Ook1NzNut/ewpElTdS70IHJRdeSxz/yjxkRR/Cb+Wi/i3lP5cQ9BqhW+wlbjxXHym7NhZLntH8asmJJzxx+QK6jseGONMjpbFRyeV+Q4X1GS2lzFhJTz5ubF2emRjKfqJjckQ14pG6JLVN3q2I462PktpftWqmEK4hGkLRl924OMulQrZBDsXs9+I4X7a7m1n6/pejPZVPQ==
Received: from CO1PR10MB4612.namprd10.prod.outlook.com (2603:10b6:303:9b::22)
 by PH0PR10MB5847.namprd10.prod.outlook.com (2603:10b6:510:146::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 16:57:31 +0000
Received: from CO1PR10MB4612.namprd10.prod.outlook.com
 ([fe80::d9e:97af:8334:3a9d]) by CO1PR10MB4612.namprd10.prod.outlook.com
 ([fe80::d9e:97af:8334:3a9d%6]) with mapi id 15.20.6544.012; Fri, 30 Jun 2023
 16:57:31 +0000
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "andrew@lunn.ch" <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: Disable TX path on eth I/F from driver?
Thread-Topic: Disable TX path on eth I/F from driver?
Thread-Index: AQHZq2pIQeoSRMiWDkmOhwIk0qU4jq+jjwoAgAACCYA=
Date: Fri, 30 Jun 2023 16:57:31 +0000
Message-ID: <377d93c3816a3c63269b894e3d865baace175966.camel@infinera.com>
References: <e267c94aad6f2a7f0427832d13afc60e6bcd5c6e.camel@infinera.com>
	 <abb946fd-3acd-4353-8cda-72773914455d@lunn.ch>
In-Reply-To: <abb946fd-3acd-4353-8cda-72773914455d@lunn.ch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.3 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=infinera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR10MB4612:EE_|PH0PR10MB5847:EE_
x-ms-office365-filtering-correlation-id: b8f52d89-f6cf-40c0-24ff-08db798b17fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 eu2lUT9ntSou4F2i/y1nGAs3OPbovGi/wkUuoVe3f7jYIfC5gvJcZckW9t05mM9xyX9LGsuVjL167ham/jp21sMCZ3Ah7xlqD8Se1L4VxuM34il7RzfE20l3CLjDWcDTnrv6eXRtqw/WVtqD4ANtHBLQ28rBnmIKulFnWJt5Jrn7qTuZ6rCHxbKhJbuT+PzNRuHAR2it4HGFMZ1YS5svJncFPAKwhR4/DR1MB7jPmxKron0gbY+QmOP61/h8mHBrDBU1KC7tjLeeFW6NBb1/Yh7/MNV5/OsSsY0Hx7BEXKXxd4wyT+EKvZrFpSlMhs9rHD3qvsI/+nMpDruu1aELtR0zDc2HaghGgxIaTXqgHc/RS0B4UB1C1stFUbrZSihhXo6LaUq0O2qOHMjOpRogbtdEnSg6NiiQaegBB+c5oPIXQixfjmSvWwxJNYgnEmubiKmCg1AIylqilXu+hh7qCnkQ7FAhuH6fFqh+HTNo/Vd0HJeettYctX7XHwTmyF2pJORK2o2HYQsbESRD9nOld4JEjyEaoZj7l7iBKn4eg+ogAqRdrYexCRQTHhdOe2fXLDDu1zs6JVdqIG0BMC/kEmfR1zLdxcySqNx9U7FvkzYLtgmfuB/ej0NS8NS9dfV/
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4612.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199021)(83380400001)(38070700005)(2616005)(2906002)(4744005)(122000001)(38100700002)(36756003)(8936002)(8676002)(5660300002)(86362001)(71200400001)(6512007)(41300700001)(66946007)(66556008)(66476007)(66446008)(64756008)(6916009)(4326008)(76116006)(91956017)(316002)(6486002)(478600001)(186003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aXV2aHRxMTM5akd1YjNadnZQMlNyTnpwQWQ0bWkwTzJsK0tIZVoxMGdlUEF2?=
 =?utf-8?B?eHZEcVBtRGZuNXdSM2N5VCsvKzNWZ2dQbjVMUUcyRkEwbDBKRzQyRkpsVS9m?=
 =?utf-8?B?QlF4N2ZFRSt1TTFzRTNibU5NaXRqbURXeUlZU0hkMEhHcFN2TnZ3QWxpQkVZ?=
 =?utf-8?B?cGhOSitSdS9FYkgydU1SL3REcXovOW56VE1QQVdDS2RlUityTWhZN0hYdTVx?=
 =?utf-8?B?Z3N6djdjVFdtUFBGTGlXRkZvTlZIKy9Dc2JITDdiem43NnhMNkk5OTQ3bURQ?=
 =?utf-8?B?T05SdHBPYmM5UTk2b3lMZGpJMU02SkgyaTd4SEwvaGlFeU52dnU5cVk1L3ZM?=
 =?utf-8?B?dCsxSGFVUlZEaEpzS0w0bTc2RXB0Mnd0VEdmZVRhelo5V0dZcE1Td2tNdmxF?=
 =?utf-8?B?cDB6UjdqcW9OK2ZsdFNEN2ZRRGpxVGxRRStJdlV3VzRBMmo4L01lc0gvOThP?=
 =?utf-8?B?aU1mMzRCZHN4MldhNUl3SStKbGRyZmVxN0lGY21KMEN2UHlpSnA4SUliVGo2?=
 =?utf-8?B?aFFBaFkvaytSeUJadWtkSXdWMTV2UEJJS1lwZDdVYXV0Y2UvVlZNMi9odXNF?=
 =?utf-8?B?c01rMnV6bXVRQi84UTRXRXdPZ3pLVWV4UExKM2RJVE5UeU9lNHlTOUxLSyt4?=
 =?utf-8?B?MmJzK3h4c0hYSDVFdTl5aVloRUx1MmFSTUFyMVBlRWl0anMrc2JmTE5YUUll?=
 =?utf-8?B?S3RRRlhWU3hWbmtJWXlkZTFJRGtwVkUyUmMwd054bC9YMlNTajczQTdWZldC?=
 =?utf-8?B?dDJuL0dIN3pYSmVJT1NxRWhSa0hxYWczRTVobDFERGFQMVI0eEtrMVM5ZS9O?=
 =?utf-8?B?aWQ0YTlyNGh2UGVzOFNGMmM1WEpnR2x1b3BEUUJYeWFKbWhsN1JCM2JaWERh?=
 =?utf-8?B?aHpuM0VIR09qUUJQM0FDbzF4VCtsQk1xMEkvbG1aZEt1MkI0NUpzMWJ2N1Iz?=
 =?utf-8?B?WlRaR2E4cHZvUm9lcTBPeFdnVWpFNFowQzhFRG44dE9rWjhhM3BuUUxnM2Q0?=
 =?utf-8?B?Z0kzektQc1B6Z1VKT21hQXI5VTVZTHpFVzFwSU05L1Z4N3dOdnVYZHJlcGdr?=
 =?utf-8?B?MmFuclBsK2dHRFdLcHhod0g4aURIV0VLYXlIODRLVExyK2Ftd3liVFJ3OStq?=
 =?utf-8?B?bUhVTFp3aTJiNVA4Y0ZIQ1czd25UVTA5SVd1R29qRnI5aHpHZUNQQ2J6WWJZ?=
 =?utf-8?B?T2ZxYnVveERsOXpIWmE3Z2RLQ2hSUnBiWkZURnB2RVRlamplaTFOTGt5NUxy?=
 =?utf-8?B?NVNzalBLQXJYMDhRRzAzWEE4NWplQW95Sm9EdUdTUCs3NWF2YXdIeEFaeXV1?=
 =?utf-8?B?cGcxU1ZVeDRSYzBTa1p1OXA4c1NDb3FKcTBrRm05aTdaM2lNb3dpWjQvQ1d6?=
 =?utf-8?B?bWhlejhLejhjRzVOMWE0WVVOMFczOXdTQ1BZNktYbnNtR2RSUGsrQ1pRalgx?=
 =?utf-8?B?ak0zaVE1eEZVTXRMblZZajJKWjM0M3B6Z1dtNEJSSisvbmVoREZ4RndDeDRv?=
 =?utf-8?B?QU5XVVkrZUZDTTNNOUt5V1ArclFOYlUzZEJqclQvcUtWQlE3a3J1UkJ2SEg4?=
 =?utf-8?B?QUpWTWNuTWhqWEduTUk0TlZ5SGNGVGdOUHp1ZmJHZ3EyTlRJRHB0MDM4UHVC?=
 =?utf-8?B?S2RTNVRsMWZLdDBlaVlNelZrUW9Ha2RWWmR2Qk03eWhYbklqUlZHaWltckgw?=
 =?utf-8?B?aDBETTBVZkYxaVdScUNSUVYrMTZ0RkU1OXlCeDlSK2N6YkE0bk9ickNySTFF?=
 =?utf-8?B?ckFJWWxSZWVpajJEUXNNZDljSFZtMVp1YnoweWFjZnNxOUZVMDRoY09qV0Z1?=
 =?utf-8?B?VEVXVEJVVkJKa0RwZHFEbkp0cGNRR0tsck14SjVkNUZmSTlGLzlkSDJwdG8y?=
 =?utf-8?B?cmVZNWZ4MVNwd09qbGxmMUwxOWF6WjNuUGFlekRVS1VTT3pxR3hyaU4ra24z?=
 =?utf-8?B?bWpjb3NwanFCQWQ2VjUzTjZaNjVpU2ZsSStEWTcvVGtFZ3ZNdUVaem5vNjBv?=
 =?utf-8?B?OXV5Nk9PMFV3NkduSzdyOHFQdUJUNVloUzJvRk9CUHgyRTRXczhscUkyZ3U3?=
 =?utf-8?B?UjhYa3pSaUgxTmdocHcxZU1WOE55WHA5VDRMRmQ4MzU1My80dVRQWTREUWVZ?=
 =?utf-8?B?WkFGa1RvbGtsWmdIbnN0eTZwcnVJZEVaZWZDbU96WFMxTXhabXFrR0pjNlRo?=
 =?utf-8?Q?gRoPXo3ZHGs6NG61Y3xqCjOB1YJvFQtBHm7CwEteTJ3Y?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B903F1EBBF55894F817CB69AC51663D0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4612.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f52d89-f6cf-40c0-24ff-08db798b17fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 16:57:31.2576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KynszpDMG0B+1ct9u4Lga4zfn4GvoSUClAkFjLlcioPbcWYD3A89GgeMzJBgj7Yg02NX3dS9uZAEd8Z/ogA0vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5847
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

T24gRnJpLCAyMDIzLTA2LTMwIGF0IDE4OjUwICswMjAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
T24gRnJpLCBKdW4gMzAsIDIwMjMgYXQgMDM6NDg6MTVQTSArMDAwMCwgSm9ha2ltIFRqZXJubHVu
ZCB3cm90ZToNCj4gPiBXZSBoYXZlIGEgZmV3IGV0aCBJL0YgdGhhdCBpcyBmb3IgbW9uaXRvcmlu
ZyBvbmx5LCBpZiBhbnkgVFggb25lIGdldHM6DQo+ID4gTkVUREVWIFdBVENIRE9HOiB0cmFwMCAo
eHItY2NpcCk6IHRyYW5zbWl0IHF1ZXVlIDAgdGltZWQgb3V0DQo+ID4gWyAgIDU1LjkwMzA3NF0g
V0FSTklORzogQ1BVOiAwIFBJRDogMCBhdCBuZXQvc2NoZWQvc2NoX2dlbmVyaWMuYzo0NzcgZGV2
X3dhdGNoZG9nKzB4MTM4LzB4MTYwDQo+ID4gWyAgIDU1LjkxMTM4MF0gQ1BVOiAwIFBJRDogMCBD
b21tOiBzd2FwcGVyLzAgTm90IHRhaW50ZWQgNS4xNS4xMDktMDAxNjEtZzEyNjhhZTI1YzMwMi1k
aXJ0eSAjNw0KPiA+IDxsb25nIHRyYWNlIHNuaXBwZWQ+DQo+ID4gDQo+ID4gSSB3b3VsZCBsaWtl
IHRvLCBmcm9tIHdpdGhpbiB0aGUgZHJpdmVyLCBkaXNhYmxlIHRoZSBUWCBwYXRoIHNvIHRoZSBJ
UCBzdGFjayBjYW5ub3QgVFggYW55DQo+ID4gcGtncyBidXQgY2Fubm90IGZpbmQgYSB3YXkgdG8g
ZG8gc28uDQo+ID4gSXMgdGhlcmUgYSB3YXkodG8gYXQgbGVhc3QgYXZpZCB0aGUgTkVUREVWIFdB
VENIRE9HIG1zZykgZGlzYWJsZSBUWD8NCj4gPiBPbiBrZXJuZWwgNS4xNQ0KPiANCj4gSGF2ZSB5
b3UgdHJpZWQgdXNpbmcgVEMgb3IgaXB0YWJsZXMgdG8ganVzdCB1bmNvbmRpdGlvbmFsbHkgZHJv
cCBhbGwNCj4gcGFja2V0cz8NCj4gDQoNCk5vLCB0aGlzIGlzIGFuIGVtYmVkZGVkIHRhcmdldCB3
aXRoIG5vIGlwdGFibGVzL1RDDQpXb3VsZCBiZSBtdWNoIG5pY2VyIGlmIEkgY291bGQgZG8gdGhp
cyBpbiBkcml2ZXIuDQoNCiBKb2NrZQ0K

