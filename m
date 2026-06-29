Return-Path: <netdev+bounces-302721-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7gCSCG+mQmrn/AkAu9opvQ
	(envelope-from <netdev+bounces-302721-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 19:07:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF6D6DD994
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 19:07:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onsemi.com header.s=mimecast20250127 header.b=EFguHKN3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302721-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302721-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=onsemi.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC290300442B
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 17:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A2F4611C5;
	Mon, 29 Jun 2026 17:07:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7383E92B4
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 17:07:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782752854; cv=none; b=EvYWqD4QhuP7L6QYaRsa3OS+b8NY0TbW2DYAF6+avk2a961Qx7oc9oe4QK3NFYHvzWVl/+kVOscu1NqMMmXbuxF1kYj6xI8RAJJgEO9yiUEsXnuJ2TEnYY860BGyWjKCzkFPKz4fj45FTP+lC77TJt6/85nsX8LV3FNYe9QQVh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782752854; c=relaxed/simple;
	bh=b4m9ugKTd4P2FLzaPcwmBvTb4oJlDyBJ/58sBPB1jek=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=dnDVFlo0KAKHFbpUGoAfma4uGoQZiFnQ1twCyL8DiOnY9kDLlrskSUmJObB4XkNy1YOfgkX5sgUTNS+/rYzunIWAGXvjgsem5h5VEGsjLGL0uf7houTil9PyFeFOEkKn1OuuNw5rD3UU+za0HHGrhD7/bcRoGmOsNN1sC+J0Tag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=EFguHKN3; arc=none smtp.client-ip=170.10.153.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1782752846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b4m9ugKTd4P2FLzaPcwmBvTb4oJlDyBJ/58sBPB1jek=;
	b=EFguHKN3GQif3CTC6EHEC999PAH0vYQ+dw10Dp8Q7ntVKVkuEjWWOqEa2CGcvve13cBfj6
	Q5PXpzxTkbJL5D57jwrtsx5b8nE1RqRiitQ4EHGqmdgtmCrMDx5xlCI03IifeH0YwCJY/n
	Ro06Wl10qZFah6VAx8JRXzFrisZWH0aST0Qto//S38wkL9Tizo46PVLSk8wg/WcBprj4i5
	ViXIG9G4mb3u6Ge7NIubUffi1yB3CLy6FS+g5K3CIuS0CATbHasAdqP4SGZNbZrGnEEBwO
	LQ8oXNnENBaulUlfq7iHDmnEBpuOqHeZ94kMINPQRBMYva9W2iFTsH7oBaGSxg==
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013005.outbound.protection.outlook.com
 [40.107.201.5]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-30-T3DZkBkHNxCvUwWnVkNcsA-1; Mon, 29 Jun 2026 10:07:20 -0700
X-MC-Unique: T3DZkBkHNxCvUwWnVkNcsA-1
X-Mimecast-MFC-AGG-ID: T3DZkBkHNxCvUwWnVkNcsA_1782752832
Received: from CYYPR02MB9828.namprd02.prod.outlook.com (2603:10b6:930:b8::20)
 by MN2PR02MB6623.namprd02.prod.outlook.com (2603:10b6:208:1dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Mon, 29 Jun
 2026 17:07:10 +0000
Received: from CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca]) by CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca%4]) with mapi id 15.21.0159.012; Mon, 29 Jun 2026
 17:07:09 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Rob Herring <robh@kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Parthiban Veerasooran
	<parthiban.veerasooran@microchip.com>, Richard Cochran
	<richardcochran@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>, Jonathan
 Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Jerry Ray
	<jerry.ray@microchip.com>
Subject: RE: [PATCH net-next v5 14/15] dt-bindings: net: add onsemi's S2500
Thread-Topic: [PATCH net-next v5 14/15] dt-bindings: net: add onsemi's S2500
Thread-Index: AQHc/B9zVG+75VEz+E+ClqG9Xmjc7bY/Aa4AgBbXfAA=
Date: Mon, 29 Jun 2026 17:07:09 +0000
Message-ID: <CYYPR02MB9828308552BBC60427E8EF2283E82@CYYPR02MB9828.namprd02.prod.outlook.com>
References: <20260614-s2500-mac-phy-support-v5-0-89874b72f725@onsemi.com>
 <20260614-s2500-mac-phy-support-v5-14-89874b72f725@onsemi.com>
 <20260615041056.GA1426553-robh@kernel.org>
In-Reply-To: <20260615041056.GA1426553-robh@kernel.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR02MB9828:EE_|MN2PR02MB6623:EE_
x-ms-office365-filtering-correlation-id: fa98b7d8-8cb7-4f92-fec8-08ded600db33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|38070700021|22082099003|18002099003|11063799006|56012099006|4143699003
x-microsoft-antispam-message-info: Y68FVuxUprv+ldfFpy2CqPt8vssOsXvBzHFuYg/B+ECNuou+Yxj2aK2xx7IPj0geNXEfgX85KYsd/wDAMtFGXU0y1TsZOonKHXpWMg0fda1yz//Uw6Fn7TE11CzzERUVfx9gsleQW2p0bjHkiZLZFt+CsXZDZzKOOOAJLsViUqJ//sTUmNCPclesEaSeW57RJpNXoafdSGVGK1tmisUvvvuL+c8TpMT6UpwcD8Ii3xrmssaMp1hFMX+q74uM6Ays+LYtwUQ70KYsASFpNzAtHSxZn2GL/JabeU6kZUajuNxk6F4n2o5W6HyAMUuutJkksOmaTjDwHXg1JL7l51wF06nRUUiUUPn2NqfF3otLi78dqRNdQ1xyw4esDEZkoRyqjpQRMiXEQzRXR0Pvsk2Yc8njLIXvsJq47NkCOigkBD091o8C4rZasLLsNvhmJujOzLnHacJzOYuTrDlL2C06WXNSfkkswz0wH/hxE20jEExjt1tM805Fce6zLU1+yAqgmKnAwIfwEHpPyWf6kmcSRsq1/pd5HxVC7h71fkFocp4iQwFSfwlUSpDgN3qIT0v1qdMHFsF5XzMlqfFoL4ESNb/FXUUMiMj7hp9oUYVgOEaET8AzJ8MCrMT0jQBk4tx40o+PMlIr89WwvmThc9FKlySUdzHrsaldjICoVvf85afb+PD7Axn322o/PcrreKlkrdviYRo59g0Epxv6jAr4+ayAA99TSq+CfemWw6bywyw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR02MB9828.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3ZkQ3N3TGNTVW5EK3Ixb3ZoUkZETWJsNVJXQmNjKzI2L3JzN3pJclg5Y3RH?=
 =?utf-8?B?dUhOWENrL04wNGpkci9FOC9BdlY2ZlVGMHZWaWxZNndQclBKRUtWN1F0NlFj?=
 =?utf-8?B?VDRwNzUwM1QxaERIZ0FHTnBzTHNHOVhPa3hlNW9JQ0tqb2Q0S1ArTkdYTGE3?=
 =?utf-8?B?YmovdTFEaEVjQldBQ3gwZzZTWnVaMkJ3MkFiMkZFZ3lSdmJ1Wlhqb2RvbTQw?=
 =?utf-8?B?NGUxSzJtUnNoR0xueENoWjRUcktna1VyZFlIUjFCT0pudHBnc3ZLU29meE9v?=
 =?utf-8?B?cEQ2RGtBVllrUytScVFrR2ZHVEZ0UGhlTit6U1JiNmQzRzdYN2FhaFhVTCta?=
 =?utf-8?B?SXhmakFQaDY5YUVMTEltNFI4NGV3VTRZeWd0WndkbTNXQWtNbmp6ZEZSRk1a?=
 =?utf-8?B?WGVkR2Rva1Y3QjltQ0lpRU4ybGtQQy9VQjRtSjZJdXBKTW1TZ2l0NlZ6SGpr?=
 =?utf-8?B?YlVjdDl2ZjlMTVpveDQvK0FDQzJwMk9WbmFtWWlmN1MwUmxld0E1R0ROMmox?=
 =?utf-8?B?UHBpTk0xQzZURi8zVEpQR0VWQVpJOTc4RXltNzJPZ1dVQzFUQzVrRWRhRUlP?=
 =?utf-8?B?QmZtaHZ5SkxCMko2Z1B0anNtdlNkWXZ6NGRNN2FGZkdEbFZoZ2ZTWlBpWWNH?=
 =?utf-8?B?ZVRDNm5EMGIyREthWXhYUXhMcmQ4OUNnMW16MHZObjJtbnd3UmJmL1NxVVR3?=
 =?utf-8?B?c3JUR0dLUjlzUnI1bXlIazJmRmV6S0FVT2E3VTdNQk94OVVUNjFNbHlHd0xz?=
 =?utf-8?B?cGo1WmlBQ2pjbFpNWFNQd0tKL004YjFkbjZpZzFJRHZqSDNBcEJ6L21uZFcv?=
 =?utf-8?B?M3FHUnI2U0tMblN3ZHRMN21UYzFvR1lwQ2lWS0tlTFFTZitKNmNRR21GVjNk?=
 =?utf-8?B?VnhUVUhBeE4xOFZJTHNTbDMrRllydm1nOUxwNTRNQVZaRG1SMHduMnRRYXh3?=
 =?utf-8?B?RmZqdGw1bWNWV0l1SlYyYTlhR0FucGo2NDlNZU4wV3NHT3pLWnlVdFJXRmQx?=
 =?utf-8?B?KzdXcVVwZTRSUWhmcU9MZUh4NmQrZjhqVVA5ejlvR2hUL1FBZXFGS0lONmN5?=
 =?utf-8?B?QmRDWjFxUURpMnFjaWh3ZU9RMVgzZ3IyUWRsZlk3RDFiUWJ5Y3NEbnI5a055?=
 =?utf-8?B?d21SV2FjSkV5MlpNUkY0dGp1QkxZZmhLdXdrck9EdHBJZmpueWFzRUJzRWsx?=
 =?utf-8?B?K05TWDAwZlRZWFNNZ1VybXBWbU1ET0ZzWllBRldrK0JFOG1KZnZ4Q2xYRW9X?=
 =?utf-8?B?dmdMZ0hqSURUWU8wM3VaV0cyS0ZjcVQwUTViam9IRjhQanZTT0JLK3BTV0FO?=
 =?utf-8?B?Q1VVdVIyTW9lRXZmbWF5bGNRRnB5N0tPakhtOWk5d3lja0toQlNIeFBlV1lI?=
 =?utf-8?B?SFVZaVFuOFhJaVVOd2puN2w4RlhhSnNQcnQ4UC8rQSswdUVONFBtdW9OK1E3?=
 =?utf-8?B?YytIU2x0azdGQWdVb1J0OXNBVHZsemE3RkNxNmhmUWZyZy9QK2RsaDB0UTlZ?=
 =?utf-8?B?NVNEdFNpQVJDTHVLSDZramhrZXE1OFNXZ1JQNjQ1OTUxbU51cWVaWlN3c0tH?=
 =?utf-8?B?cWZjcXJhZXpRdG1ORTNNV2xCamdpR21RK2JOWmR1dG05WEZlQXkvVDhDaG45?=
 =?utf-8?B?RURoWUZkZWw0QzZjakkrT0lWayt5bEc3TEpUUEh0RGRTQjd2Sk5RbldJa05X?=
 =?utf-8?B?SXVyWkhiWU9lcGN6RUdJTXp1ckY4SGNyUjRQWDJjV1FwQW5SVmx3alh5M28v?=
 =?utf-8?B?UUNKbGZ3SjVVVGlZYUpmalBmYWVXdXlObUVaUVFlL3FQQXc4dC81N3JTMmsw?=
 =?utf-8?B?QmhzNUw3ZHUzNDRBUTBvMjgxTnBhNW1IWWYzdjlsaFNTYkd1NG1BS3o0K2Nj?=
 =?utf-8?B?TlpSWlJYNFFwVGw3UTFvVFgrSkxSMEV2SUc4c0s5dUxzcGlRV0c4V0hSemFI?=
 =?utf-8?B?KzhldGhmM0wxbXlhTFVxOUpRNTBvL1psMVBrb0pyZW5OU3UzejB4WXR1Nmox?=
 =?utf-8?B?dXBwMlpuTThaQkFrWjRjUHdJczNGaDk3SWc0eldpUnNuemt3dURLQzhYQnB0?=
 =?utf-8?B?aTNFUDdtTzYzKzBxVTZlM2ZkaWQ4ZzJ5M0tEVVZsNzhlNGFGdUJpeFdMTGRF?=
 =?utf-8?B?Mk0vZDl5YmltQzRjcUxFY2tvT3hQZ0dWbEdaNGpKc08rQ1VYL2xwUlZPcWtM?=
 =?utf-8?B?NWNnU3pJdXg1Z1FPTXN0eDA2QzR6eUlIQTVKYVlPSXBMWk5TL01ObG90RWJl?=
 =?utf-8?B?WnU3M0RieEVVNXgwRVd4T3ZFbk12dFZVT2tXa210SWdVSVhqWC9hVTVUWDJn?=
 =?utf-8?B?VzdsZGpaaFFqQVpXaXBBR05KYXZHNUVoOEs2aERNaVEweXJBcTZhb3RaNTdY?=
 =?utf-8?Q?LfX0m9AkewxwuFgY=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: od8VgRKhRsd8h29O65oZT24+CPWosfImA7Hxv7gVVTbuopifc0l0S8vQ7qMhucFp69IJbfMo0nsNXDIQihj2LCn9dggDLb3FmRhLXyslw8eurB4XZLWU3ahvwOVU6riE8/E877VJAh1kSFSsGgY+ba+xV5xdZMv/Iyu2BtF7Q6krN9gmPKizW4FY4RUgmMJJUTOVfAntZ8n64Oq0eDC9ar8MW+uSFkDcJ58PT8D7Z5MxHs611fJ7DWSIncwpn3BlKc+ieoKrYBQCgPpPlUK6HvaGoSBhkQJcLNam3dCDD63a+5LL23MZeYPM3pECXS4iDe2GkN62RHeWXTJ5Qkd4ag==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR02MB9828.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa98b7d8-8cb7-4f92-fec8-08ded600db33
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 17:07:09.8861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I9XIjRyjPPNBiJP98aTcLEcAMbr+K1HNguqOw63dOZerQgC4PmkyYEnRAcig7ki2kJHd6MlryVCqg0conz4SVOL8tA4MRUHhxDRkwy/H0rE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6623
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TrBJrsR8c8LW0HjLIImxox-1MFkGEWB7Ni0bDtzsLjg_1782752832
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302721-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:robh@kernel.org,m:andrew@lunn.ch,m:Pier.Beruto@onsemi.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:parthiban.veerasooran@microchip.com,m:richardcochran@gmail.com,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jerry.ray@microchip.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,onsemi.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,lwn.net,linuxfoundation.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[onsemi.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0DF6D6DD994

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSb2IgSGVycmluZyA8cm9iaEBr
ZXJuZWwub3JnPg0KPiBTZW50OiBTdW5kYXksIEp1bmUgMTQsIDIwMjYgOToxMSBQTQ0KPiBUbzog
U2VsdmFtYW5pIFJhamFnb3BhbCA8U2VsdmFtYW5pLlJhamFnb3BhbEBvbnNlbWkuY29tPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIG5ldC1uZXh0IHY1IDE0LzE1XSBkdC1iaW5kaW5nczogbmV0OiBh
ZGQgb25zZW1pJ3MgUzI1MDANCj4gDQo+IA0KPiANCj4gQW5kIHlvdSBhcmUgbWlzc2luZyB0YWdz
IGZyb20gcHJpb3IgdmVyc2lvbnMuIEl0IGlzIHlvdXIgcmVzcG9uc2liaWxpdHkNCj4gdG8gYWRk
IHRoZW0uDQoNCkkgYWRkZWQgdGhlIHByaW9yIHZlcnNpb24ncyBsaW5rIHVuZGVyIGVhY2ggdmVy
c2lvbi4gU29tZWhvdyAiYjQgcHJlcCAtLXNob3ctcmV2aXNpb24iIGNvbW1hbmQgZG9lc24ndCBw
aWNrdXAgdGhlIG9sZGVyDQp2ZXJzaW9ucy4gSXQgc2hvd3MgdjQgYW5kIHY1IGNvcnJlY3RseSBh
cyB0aGUgZW1haWxzIGNvbnRhaW5pbmcgcGF0Y2hlcyB3ZXJlIHNlbnQgaW4gYSB0aHJlYWRlZCBt
YW5uZXIuDQoNCkJ1dCB3aXRoIHYxLHYyLHYzLCBhcyBlYWNoIHBhdGNoIHdhcyBzZW50IHRocm91
Z2ggaW5kaXZpZHVhbCBlbWFpbCAod2l0aCBwcm9wZXIgc3ViamVjdCBsaW5lLCBvZiBjb3Vyc2Up
IHVzaW5nIG91dGxvb2suIA0KSSBkb24ndCBrbm93IGlmIHRoZXJlIGlzIGEgd2F5IHRvIGZpeCB0
aGlzLiANCg0KPiANCj4gPiBjaGFuZ2VzIGluIHY1DQo+ID4gLSBubyBjaGFuZ2VzDQo+ID4gY2hh
bmdlcyBpbiB2NDoNCj4gPiAtIGFkZGVkIHNwaS1tYXgtZnJlcXVlbmN5IGFzIHN1Z2dlc3RlZCBi
eSBBSSByZXZpZXcNCj4gPiAtIGNoYW5nZWQgaW50ZXJydXB0IHRvIElSUV9UWVBFX0VER0VfRkFM
TElORyBhcyBpdCBpcw0KPiA+IGJlaW5nIHRha2VuIGNhcmUgaW4gbmV0IChzdGFibGUpIGJyYW5j
aA0KPiA+IGNoYW5nZXMgaW4gdjMNCj4gPiAtIFJlbW92ZWQgVVJMIGxpbmsgdGhhdCBmYWlsZWQg
dmVyaWZpY2F0aW9uDQo+ID4gY2hhbmdlcyBpbiB2Mg0KPiA+IC0gcmVtb3ZlZCBzcGktbWF4LWZy
ZXF1ZW5jeSBlbnRyeQ0KPiA+IC0gY2hhbmdlZCB0aGUgY29tcGF0aWJsZSBzdHJpbmcgdG8gczI1
MDANCj4gPiBjaGFuZ2VzIGluIHYxDQo+ID4gLSBBZGRlZCB0aGUgZmlyc3QgdmVyc2lvbiBvZiBZ
QU1MIGZpbGUgZm9yIG9uc2VtaSBNQUMtUEhZDQo+ID4NCg0K


