Return-Path: <netdev+bounces-296361-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2Br9EIRBJmoQUAIAu9opvQ
	(envelope-from <netdev+bounces-296361-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 06:13:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2D56528E2
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 06:13:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microchip.com header.s=selector1 header.b=UeGUqueQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296361-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296361-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microchip.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 474C5300FC5E
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 04:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355C62EBDDE;
	Mon,  8 Jun 2026 04:13:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012070.outbound.protection.outlook.com [40.93.195.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC002771B;
	Mon,  8 Jun 2026 04:13:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780892033; cv=fail; b=LrTRy8pb6T+sQKJRtyxezKy43AVAfFgxjdemMUeQeBNeziEWeOgwzQIAyo4lpHbtXToZKxmenQ6EdnY1ro53TYTzr6eB117uLo8HyeJt/LWplx3nrbwIjtoqmOllo3ylUYFNrQSnjH/bUbMR09UiWhQSxpGeQ1ZnXeNBuU8YImY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780892033; c=relaxed/simple;
	bh=ItsmR78vHFJqmXMnMzyOlY8ZF/hW5Q7n04VTsVcGFzo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xig85aHgIoc02L8iSf/BQ5E7yGjtRY2MxE8+fWjflq44XherAtR1ahZ8t/7x1D7h2RDTtNCm2aZw7ks2jxrqHCPgUPvawt9cR12a1H83c1VHNxywjBoiKS2IWdy1rcpguSzcp6IK+g9/HuzhNwzyI+WTUEA7/amGdzCVDHF4WPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UeGUqueQ; arc=fail smtp.client-ip=40.93.195.70
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VF5IocQmPmv1mL9aD+td5kxdI5qVRToIYgAK9MKXKSSKUcF918YnY9TBb/qyOffVY5uR6XVtDFFxYaC1DfRiTWfJkAvmQ0XUdOLjQuslWLq1VOf/2MAYnNeq1B6hO3wgIeLTiTnAsglLJgR0hgUu+OT5wKSiDtHAgBOGIvI81k1ovyM8MQ9Ufo83UnZcbhCkggPF+fYzZ+/MQv7kS6sCs5jCXmVuioYt5m1VjWVtgFYsy+5dLa+SYtlVQ0TNovL9R8qGqgbOoHt3YF1R0x6RoerFl/+iYxv23vE2vzJCGpJwC246khaAuvbYhq7zoQ/lONB7ShfVrUScVBjIzk34Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItsmR78vHFJqmXMnMzyOlY8ZF/hW5Q7n04VTsVcGFzo=;
 b=BGnIf6UXp83EW6RkvVAdHyKHCJ0nKIq5ibjDnYkuQyp4N8S7PdmvrkDEjrD0qg1u+/Nw4JKKU3u0NaJmdWklDSTNxL77KoKjtKiDB8DOjNt0thSUtVUNiUgXEcrcU1LNFd6OY1NNgtUP7bMzaeXd0a9cLIe3Uez4exod7Xz3/iF38j8MR6ViIrIdkUjicbi0UmKwX7Uac1yQSBY+3IadI3Ye8rjnUBqAtl68TwfKesfaUcsrnZDpRFPnFyRjOz/px7e4eQ1Bbuug1HFCJ2EbrHst2KDSXghiRmgTjyzr31FVEgx5BttVL0R+VtNddD32Lv9Vk5mqxMfTd/ciispH7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItsmR78vHFJqmXMnMzyOlY8ZF/hW5Q7n04VTsVcGFzo=;
 b=UeGUqueQSmhBIL+peHEj6FsJm4sdhHfmUxqI2NaO5vbwiWTK0gowfqHhxDVVo/jPc36M7oINJW8NvtVsUeMsbWj6F1ndHlPwjElmZQHWfV5UmmUVOBijJN2Ou/tndzZzpmOMdc5XHfbtwv3H4Qi6MfldzPCslHKtT9d26YQZ0YBOIEjxqysisYxsXNutYaQTbA2E3+k+HmH2pJrI/HbbuZV3MU7bGPIU132bYtmH88+0n7MSQ4ziSAonxKr5YjZo9JZ3ycNuPgrfRxiL4TVMXIHdWlbcfhiDKYEfLzAN6WwX5IPU2OHfmve6GTm2nJlSD0+/9mdoTDCb/WANmY4Vfw==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by DM4PR11MB7208.namprd11.prod.outlook.com (2603:10b6:8:110::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 04:13:48 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::3a83:d243:3600:8ecf]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::3a83:d243:3600:8ecf%4]) with mapi id 15.21.0092.010; Mon, 8 Jun 2026
 04:13:47 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>, <conor@kernel.org>
CC: <Selvamani.Rajagopal@onsemi.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <Pier.Beruto@onsemi.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Conor.Dooley@microchip.com>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH net v3 2/2] dt-bindings: net: updated interrupt type to be
 active low, level triggered
Thread-Topic: [PATCH net v3 2/2] dt-bindings: net: updated interrupt type to
 be active low, level triggered
Thread-Index:
 AQHc8eDGO4Y2rMyEmEeRgmYw3vsZ4LYrecyAgAAPEwCAAmo7AIAAlNuAgAAUz4CAAAajgIAFcz6A
Date: Mon, 8 Jun 2026 04:13:47 +0000
Message-ID: <7c68173a-ebff-42cc-8519-95e8365805b5@microchip.com>
References: <20260601-level-trigger-v3-0-da73e7010532@onsemi.com>
 <20260601-level-trigger-v3-2-da73e7010532@onsemi.com>
 <20260602-rebel-snide-5036c97e410d@spud>
 <CY8PR02MB92493D2E5491AAE5416C05A283122@CY8PR02MB9249.namprd02.prod.outlook.com>
 <a5abb9b8-6ebf-4f95-a684-fc889b98acea@microchip.com>
 <CY8PR02MB9249E607ACBF3A05AB83ABF683102@CY8PR02MB9249.namprd02.prod.outlook.com>
 <20260604-swimwear-garnet-3eb092e6fda7@spud>
 <4df9882b-3426-4c36-8048-0c76d0f11c74@lunn.ch>
In-Reply-To: <4df9882b-3426-4c36-8048-0c76d0f11c74@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|DM4PR11MB7208:EE_
x-ms-office365-filtering-correlation-id: c856a8c0-8cfd-49ff-957c-08dec51456b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|11063799006|56012099006|4143699003|38070700021|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info:
 IwW0qnufaJq4DgOyGZq61LnFlKQHIQPMJQPo7wtligz3E5OzXzDoEiwwQeJzxtGaICQjJO+wegektBitXhomFXRELmMHm+YzaJM07rdJnGPfKwEMeWk0uErwWNgiGkxdF2PRHYdj0pOuWYTo0N/m20o1PgUoqA0vLqvShPyu5pr5nwmtHFMMAdeoF89IfpzuOJOcpfYZUAlL7M4GzFU8Nnoc+/2A6HPFYnVMRmmHiPo4qlYt+TiND6k6RUfSHq1T1BlnryXyn9L4xwG3nGZy6cv8+dyr/BkE1pLbBr7scHmFHKNnsjBhIjvVxKTjERdiss3L36CPDjnG6+9LkRiY6+B/awsycfFVwvYDjNjVQ8QxLv9H/KlsqUE9DurO1JeST4gfmeLwZXNd0wulrYyClH64HbmP0NnJfUjMxLNEQRrmKxjaogldLbzLr0oEZsqVKwpIo5Wy+GHgKtZDI8uZtpl7Wo5lbV+gokUzyNDmUNDVpag4mi3z7eqjPUipf3/8AGESoa/TeyCJ69DMGwmPB8itIC5i3NM3UKUEzW7GWyeBV8gOwHdmAYjK8onTmEtVyAe0XWPqnaUw2KJe4TRDSy/qnuLayvC+ytaPWdiolhOTEw+dUZ+a/9fAA8w1xCCl4vJRrOXPVLj3+xB5/vn4J0Fs8qxnU0ROdlp3KGc8ehBuY0PtRpwWxlSKMnb1ILKChLXCH7m1u7hE8lEHo1gs0Gh/ZoE6Ar1WwHrpQLOmMxZC543WtHoRPH3M2nXeD/0W
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(11063799006)(56012099006)(4143699003)(38070700021)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M1p3b0lnUGFYVEg4OWVVSEZ2emRsNC85aS9ibmhxbXh4T3pDUW5zMFpRWnBt?=
 =?utf-8?B?aGlhSXViUWxrTzdvak5zV3ZQV3BHOG1RdXEvMXRwbVpyaUJSd0JDUVZCczEv?=
 =?utf-8?B?TEt0ZTNZUys1dGZuL1pTRkg4RlVYSGlkWk9veGZzMDhSOWpRbk9TMFRxeTVt?=
 =?utf-8?B?SVp3R0RPa0d1TnhWbDNRUUQyT1QvNHhJVTJvZkN5aC9XRzhzZVgzRFJ2TUhK?=
 =?utf-8?B?ZERCTFlmY2ZxYjB0R0tIQWFhQ0xpTjZJUWtVT1NlNEZTS2EyUDZST2Rhci81?=
 =?utf-8?B?Z0pMMWdYY3haeXJnT3VnL2RpcXoxNmtMeU4vRXJZeHJnckVDQWsvWVNCQ0lV?=
 =?utf-8?B?OHE0YUsxNXd0TFYyVzJ1aVhJWGxuSU9DTGFacGVVTWpHUWIzYnVpOEJDbmhq?=
 =?utf-8?B?eE42NGFwVXlDM2xIdWZ1cDF5ZENLSkVSMktKRmpoMzZsbFZyeVhEZ0FRVUhX?=
 =?utf-8?B?RlRRNEczQXo3UGJpYVFJSnVrZHM1L3cva0RkZUhkSWZId3FUTG8xeFU3Z3NZ?=
 =?utf-8?B?RnZZL1BKSlFQbHlxOWZDY2xHTEJiaXgxWVVOZjZPeU95bkRvblZiZkQrc0dj?=
 =?utf-8?B?d1hCQVlpdzA5QTd4MElnTW9uWW5OVzVGUXRUcDkyWFUrc3R3ZVRabjQ5cjRG?=
 =?utf-8?B?U2w0c29LS1JVS3h6dzd1RVdpZnZsOWRjVWZiaW9CYmlhR1c3RytPcHdpTE5D?=
 =?utf-8?B?RWlmdEdsbVhKUzZ3Qng0V2tOMmFqaXMrZkhtOXdRRlloNEZHdVB0MmtnS2xJ?=
 =?utf-8?B?WXV5THZDZWFMRWtIWmg0ckkyY3lzYkxidkUxdDZvRnRQcGY2eDFvWG5UQ3FZ?=
 =?utf-8?B?cm5ETEh0K2w2cGlsTU1FQlVMWGlEZG5zempVY0tQd0hqekxFc2toYVBpa1h0?=
 =?utf-8?B?cnNsQVFJbXVTL0hEK0JNK3N3Zyt5VjZUL0xLVkdhVDhvSjA0d0RwZTkwbmZx?=
 =?utf-8?B?QjY5SnZTZXZQbXVXeDQzUlB0NUs5VXV2Si9Ua1FCZllhcDE4c3FpL0hrMm5T?=
 =?utf-8?B?RmdQRjcrQmZwZlo2TWxRcnN4VEJvYUtWMU5QVHhyY3YwZXpLbWVZenVObTNJ?=
 =?utf-8?B?bnAvWHptZXRsNXFsbnRqeDFGL2xyQUdPR2Vka1F6bTdPQWN3RkJXZG9VZEIy?=
 =?utf-8?B?bmZ2aWZ3VW44VHh5dEsxaTJMOUsyUGdnaDlOK2pGYURrcEx4c09qZDV1dXd0?=
 =?utf-8?B?cXd6a0hHbndjei9KV0syRmw3SGhTY1NCdWZLSitXUVNUdkt3V3FHRW5zb3Zy?=
 =?utf-8?B?VGJ5Ymt1RCtubWVzTmV2K3p2R0JZYlE4YUZTNWl2WVBPQnNiWmRCbXR1anFu?=
 =?utf-8?B?dTVzakxCSDMxcGRTVDg2Wjl3dVZjNTlUT2YyOWdtTkF5L25Db1lvb1krSjRm?=
 =?utf-8?B?dmVQM3gveURsQlZUZDFaTkJLdlpBbVVURUFUSmJHSEFxMXBPOGQzZDBTVmJU?=
 =?utf-8?B?anZsdGhaNXJMVG9xYlQyOEJNODdqRGMxRUV3ck1Vb2dOZ3RBT1BQQkxFYlpz?=
 =?utf-8?B?bFlnTlJJd2JwZzhsZVY5NGNnbDFicU52aW9GT0I5TXZiNkRvVzlMeExiTURQ?=
 =?utf-8?B?ZDg3VjArVG5rRENNR0ZML0NkM2xsdkJOL3lxVmdYWEI3MkxIc1g5YTdNZHl4?=
 =?utf-8?B?eExCc05SYk40bDFvZXpKeWFTSVFML0JHbEdEUTRPdGY4dmt4N2ZaZW5MeXJ4?=
 =?utf-8?B?WEVuYS9NZGR4YmorbFhxNi9VUkpIN0ZsY3poUEFMS2VIdGwxYkZXQ0xwcThG?=
 =?utf-8?B?WVBJSVdMdTVjY2FuSVRoNnpUUTVyZjVWbHFUbk9nZ1phSXBZbS9YVzNqQjUz?=
 =?utf-8?B?VXhaNlVKWm85SUY4d09CazdQclF5NUhLYnU4WWpTYTBUbEpkcUJzVWZGeFVS?=
 =?utf-8?B?M0xHaGlLdWxVZlN4NVd4elA5Y1cvRFBSdThyWGFpYU9DbzcwMUMyek5rdHhY?=
 =?utf-8?B?VVJwczBMU1Z1WWZxaStCbmx2UmZLSmYrc2hYeDZzcXluejBjdTBQRVcwNEpO?=
 =?utf-8?B?cUdrU2g4UVprRW9wV1NTRmN4Z2ZTd3BVUkJrVW1idmxDTStzWnFTbmJVYnlj?=
 =?utf-8?B?U3Y5Sm9iZmhSUk9GMkRRcTNGeVl4Z3V1T2E0RGhQWWhxTGpTVE1VeXJqM0lM?=
 =?utf-8?B?RlNod1AxTHMwYnE2RDFUVGV2WlRZK3pjQ3RJNHRWeXk0OW5MVS9nMlJUNVNt?=
 =?utf-8?B?d3BOcmxCMjJKTnQ2WDJQNGhWZmM2Szd1eHRueGtIUHZnV29oUUhTWFVMZ2xZ?=
 =?utf-8?B?Ri9lYi9JMlZna2cvRDZjakJ3bm1tc0lQQmxnS3F5K1N0S3g1ZllCQzZwOXBy?=
 =?utf-8?B?dEM1bytCSzdyT2t1bTNicFNFb3ZiL3EwYlE3ZVpTSGlzbWdIWmxxVnV1WW9I?=
 =?utf-8?Q?WoHkAQjsqtPNtreo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4DCF40A6CF735E49BA3B85263EC072AA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c856a8c0-8cfd-49ff-957c-08dec51456b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 04:13:47.7649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GbTUn0lY27cX2SyQEPRhcfVdgTFVp2znZ0MBI9jUuWEwccSpdd9qEiRq+jvfZjyPhRVNrrBwEXdhVRGrGjgogbBIhbKSlPfQnOc8dCHeEQGim3EVYG1TAA+bKrcJGfKC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7208
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296361-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:conor@kernel.org,m:Selvamani.Rajagopal@onsemi.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Pier.Beruto@onsemi.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:Conor.Dooley@microchip.com,m:devicetree@vger.kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[Parthiban.Veerasooran@microchip.com,netdev@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[Parthiban.Veerasooran@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E2D56528E2

T24gMDQvMDYvMjYgMTA6MzAgcG0sIEFuZHJldyBMdW5uIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+PiBJIGp1c3QgbWFkZSB0aGUgYXNzdW1wdGlvbiB0
aGF0IHdoYXQgd2FzIGluIHRoZSBleGFtcGxlIHdvcmtlZCwgYW5kDQo+PiB3YW50ZWQgY2xhcmlm
aWNhdGlvbiB0aGF0IHdoYXQgdGhlIGV4YW1wbGUgd2FzIGNoYW5nZWQgdG8gYWN0dWFsbHkNCj4+
IHJlZmxlY3RlZCBzb21ldGhpbmcgZWxzZSB0aGF0IHdvcmtlZCBvbiB0aGUgaGFyZHdhcmUgaW4g
cXVlc3Rpb24gYmVmb3JlDQo+PiBJIGdhdmUgYW4gYWNrLg0KPiANCj4gVGhhdCBpcyB0aGUgcHJv
YmxlbSB3aXRoIGVkZ2UgaW50ZXJydXB0cyB3aGVuIGxldmVsIHNob3VsZCBiZQ0KPiB1c2VkLiBU
aGV5IHdvcmsgJTk5Ljkgb2YgdGhlIHRpbWUsIHNvIG1hbnkgZGV2ZWxvcGVycyBkb24ndCBub3Rp
Y2UNCj4gdGhleSBoYXZlIGl0IHdyb25nLiBBbmQgdGhlbiBvbmUgZGF5IGl0IGFsbCBzdG9wcyBi
ZWNhdXNlIGFuIGludGVycnVwdA0KPiBnb3QgbG9zdC4NCkkgYWdyZWUgd2l0aCB0aGlzIHBvaW50
LiBCdXQgc2ltcGx5IGNoYW5naW5nIHRoZSBpbnRlcnJ1cHQgdHlwZSBpbiB0aGUgDQpleGlzdGlu
ZyBsb2dpYyBpcyBub3Qgc3VmZmljaWVudC4gTGV2ZWzigJF0cmlnZ2VyZWQgaW50ZXJydXB0cyBy
ZXF1aXJlIA0KY2FyZWZ1bCBoYW5kbGluZyBpbiB0aGUgZHJpdmVyLCBhbmQgd2l0aCB0aGUgY3Vy
cmVudCBpbXBsZW1lbnRhdGlvbiBJIGFtIA0Kb2JzZXJ2aW5nIGlzc3VlcyB1bmRlciBzeXN0ZW0g
bG9hZCB3aGVuIHVzaW5nIGxldmVs4oCRdHJpZ2dlcmVkIElSUXMsIGFzIA0KYWxzbyBkaXNjdXNz
ZWQgaW4gYW5vdGhlciB0aHJlYWQuDQoNCkJlc3QgcmVnYXJkcywNClBhcnRoaWJhbiBWDQo+IA0K
PiAgICAgIEFuZHJldw0KDQo=

