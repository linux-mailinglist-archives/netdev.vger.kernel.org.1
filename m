Return-Path: <netdev+bounces-296305-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +KpSOq/FJWqyLgIAu9opvQ
	(envelope-from <netdev+bounces-296305-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 21:25:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F4F6515A8
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 21:25:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onsemi.com header.s=mimecast20250127 header.b=IxGLliBJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296305-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296305-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=onsemi.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3EA133007970
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 19:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B6B32861F;
	Sun,  7 Jun 2026 19:25:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6871631F981
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 19:25:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780860329; cv=none; b=PhGJjJprYVQgp2Z59NLzSPTzU9i8eN4fbC1BrJpQkSN2mshud3zKpaNW0+Qeh++Rsmp3K/N96Xp+9uN/CpP6Z1FXHjQ1XwgEIto4KbsANw/d/tGEuNkaTXG8W2yv5Vu8toCpPJyJKYmw65mJ//yXWRBcfSdKDnUgZrGAZrk1NL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780860329; c=relaxed/simple;
	bh=fk/2zasvFxHfI6QPVrYH25t/RG6QU83oAjl0mh2nSLI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=m52pJrfL2TfL1/fdfT3MPhKIC72fcRFvY93AT1aP+UG+vg0afwSy2mYy1lW/A0YaPSkJvMLKakZ0Xudaee2sRHP3sM49crseaQb+ZS7cU0frONd/xbNTX36WUpxUdZcf7ucHHn1gikLD1O2ruzVcfZm0jmo8W+6+NISKT13NXaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=IxGLliBJ; arc=none smtp.client-ip=170.10.153.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1780860321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fk/2zasvFxHfI6QPVrYH25t/RG6QU83oAjl0mh2nSLI=;
	b=IxGLliBJYhbow9YRnK/Y4uwjjE+AHsXsogehqsOcp2MM3YjP5ZGICcUJWSs7tQ8V1CjFdU
	Xbm66Gv9wqcs3nERfpCeHRPcdzvXHOAmzEP9FqDtsDL6BeGGY1gR+kSjvLuEPoLThDE2gI
	QBSfCWn8QMfUVaDQnI7SyaNlkLbNfqvDnj7J8+dWtvZcZGoft3BjgT64l8PsDklbAj+mJM
	4xUrT2PKHyBj7vcGWZ5xtVfPC+vHyUYsfzCguqaSn6XhR946Wdc1RgJi7SR9euCbDhmEF8
	rKFT4aQLv7bfRk6W+ZLHTVD0MBDcDtaLFMPguMbZq+bkimZwQq9GjQhF1ymRmw==
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010070.outbound.protection.outlook.com [52.101.56.70])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-56-IKby01FGPjuM4z3wWvVDLg-1; Sun,
 07 Jun 2026 12:25:15 -0700
X-MC-Unique: IKby01FGPjuM4z3wWvVDLg-1
X-Mimecast-MFC-AGG-ID: IKby01FGPjuM4z3wWvVDLg_1780860310
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by IA3PR02MB10698.namprd02.prod.outlook.com (2603:10b6:208:50c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Sun, 7 Jun 2026
 19:25:07 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.21.0092.011; Sun, 7 Jun 2026
 19:25:07 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Randy Dunlap <rdunlap@infradead.org>, Andrew Lunn <andrew@lunn.ch>,
	Piergiorgio Beruto <Pier.Beruto@onsemi.com>, Heiner Kallweit
	<hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Parthiban Veerasooran
	<parthiban.veerasooran@microchip.com>, Richard Cochran
	<richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Jerry Ray
	<jerry.ray@microchip.com>
Subject: RE: [PATCH net-next v4 13/16] onsemi: s2500: Add driver support for
 TS2500 MAC-PHY
Thread-Topic: [PATCH net-next v4 13/16] onsemi: s2500: Add driver support for
 TS2500 MAC-PHY
Thread-Index: AQHc9XdYGYcKsDzw8Ea3BGxNoVFNILYymcMAgADhaQA=
Date: Sun, 7 Jun 2026 19:25:07 +0000
Message-ID: <CY8PR02MB924965A7F4990D6684920CBA831F2@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <20260605-s2500-mac-phy-support-v4-0-de0fbc13c6d8@onsemi.com>
 <20260605-s2500-mac-phy-support-v4-13-de0fbc13c6d8@onsemi.com>
 <7b100b6a-40c5-407d-8de0-7b1edb82a16c@infradead.org>
In-Reply-To: <7b100b6a-40c5-407d-8de0-7b1edb82a16c@infradead.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|IA3PR02MB10698:EE_
x-ms-office365-filtering-correlation-id: 6664fd3a-6e1f-4f8f-8ab9-08dec4ca7bc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|921020|38070700021|56012099006|11063799006|4143699003|22082099003|18002099003
x-microsoft-antispam-message-info: beBSUQ+rTFRjRYGFQ4aYIlvPofApWcuZgX6B/CFcUUl0I3eOWJlZQMdNp+oNvPwdym9U/STtMwoUS6mMc8EkWC9ripTAzvpx17Tc+lrsLvbA77CIwq2DfGCravWF6zcPh9ShdZs0AwIGHq3hOcnMQNGa0SaGe5sjPzjxg6yFvycCQmuT+TIbJSbckUe0AsXmayNpjyYT1cgA+Zgf7dNwez+0rn/oK5KgjlD+nbmHaks0pMiMyntijscjb+O236NhRDF5toF8qkrqRsmfUKYjPGe+we41UT+Z5oeRZ7R5Az0DaPHDGYLCVIVrhVzpWB8ArSCKW/87JosiSZ/IPPvd+fnHIHs0VGlTqP6mQ3qTlcVHRuweMIcFU0bF8Mg8Cpux7BvgwuPf3gHYtw6eHI6pp0P5vIEpuvqcE/4+x1zATUl9u4ODEG1dAG92BVHOsYOnyK1PNhcTMM4/4pYWgtQHDPES/ja7TGTAaViJYhFh7OxlIPR25IV0LUsB6HWI+7H/N5N00pjb+uIhjG3MVkkuy0kzmDYpcrETkbQUy1dUc5o8GVKyCKMUXIblI5VAc5kdfNwtXTtafsDJIV/Y0O8HECGN1OX3XnAhQyq5OtrgiyA5RCL4ipPRbKU3DDfFsG8RPcJL8jVxisXD8pS+DBqhEr3E6QTm6AkCA/QH/pKSbOdu9hMqx9xSxBhuzSP339GfHsVfMR7h+pETPdo8j2iXM5Oxc0pZtXWB19bJd74y1Q0gsCYlIsJ2JjBOMtM4OUpiJQlKNMgMuvwoxVehH3uJTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(921020)(38070700021)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGlXN3VzWlBaZjcxelhLNERaWWRWVkhRTjF3SXltd1p0NC80V0FzY2swVWpF?=
 =?utf-8?B?Tzh0VzljTElkNlpvaENaM3RFQ0JTM2tjU3J0dHV6aS9GMVpyckVJVW4yVjUv?=
 =?utf-8?B?Z2RINUNlUUZyOG93a2F3QmtQekwrMUVBZUExLzJEMW9aUnNNZ1NNclQwL1NL?=
 =?utf-8?B?ZTFMaXh4dzA1c0I0MkF6WTY1TDlncEtNdDk3anRJV05Wak5YMEUyOXZ5VkNT?=
 =?utf-8?B?ZnNoS0EwOEM4T1pwK2oxY1BYcVRrMEpMQVBIcHFqTGFsRGt6dDY4dUtBbHhs?=
 =?utf-8?B?dUp3bXZuUmZNZXoxUVBYOCtGOEJjcXZXZHlHU05nS1hsS21jNDkyeEptdjh5?=
 =?utf-8?B?bThwZXRTd3lCcUZFYzZVbkZYZVVkQVdYcHFrWWxCczJFODV0K1F1ZFlDRURI?=
 =?utf-8?B?b0dDNlBuT0djTnlXOWRxc2VnQVp1Qnh1RnVUbEZ5WkNpaGlPWVhvWEpZNWFw?=
 =?utf-8?B?YlVCTTJNN3E0ZlJLZm5tZ2VEckRvSGhYSWxUcUY1SmJQK3lWL3NoMXZsUU56?=
 =?utf-8?B?K1R2TENkNEVoNVFRMkxoZjJKUmcxZk9RVHFKbXhwamlrV2JLekR4TG4zVSto?=
 =?utf-8?B?bW81cjQzcXpOVDBTeU1BaEFuOHNPMXZQU3dSSTdEcHBPdHZHeWtBOW9KUU5z?=
 =?utf-8?B?MnIrSStaelpORXdkTjNWTDdJYXhJWXBkZEc3SHdCWG9rWGR5Y2hnT1BsMVBO?=
 =?utf-8?B?SzlCUUhOeGh1cE1KRDhwWHgzKzlwTFRvdExLa3dLNUFleVN6eEwycXlGbmhu?=
 =?utf-8?B?RVoyOFU5NVN4eUlMZisxdFIxQ1pzV0R2YTZCcGpnblA1WW9EaTdESm10RmFZ?=
 =?utf-8?B?UHpzblN2Q1NGZEt3R3I2ajFRUUlKaW1DOU03RXdvZldWY3VaNEh2d0YrMlA0?=
 =?utf-8?B?Yy92ck0yeTZUVHBiYUpmdkxuUklkd0EvVUtiSytlWEZ6SnhHYzNhV1pNSkNn?=
 =?utf-8?B?aHpzTTd3cGJLSDdldnp4N2VVbkFYSDhNandhRmFlcW5uWW9CQUxsYm5oWmpy?=
 =?utf-8?B?cVBuemVWcjNwQTkxdEk4R0k2OUczN1d0UGk4SVlvUllWUCtCMW9hVFprdDBo?=
 =?utf-8?B?d2N2TzErZ1ptWVBObHNhcjlCcE84UCs0WkJKbEFBSkx0YlBSSUNIWFJUbGNQ?=
 =?utf-8?B?c2w1Qnp5MzdCdkJGRE1PbU1wdHBucTh4M1lPYldoaDgveEdzd2dEWCtHdDNM?=
 =?utf-8?B?S0NQR2tPTWVueFI2SzRiblF2WDZURnk5NkJyYTFuNGdKakN1dTNTRFJGREds?=
 =?utf-8?B?WllGajdXOW8yazA1VnVVVVNPMHVkeWNjZytXTCt5SHYzbWU5N3FjUDAzWWtY?=
 =?utf-8?B?L0NnZFB4WFdFMFpnWWhiTjlBY2xhTUZsNG0wRS9tekRkM1d1K2FXWC9MYnd6?=
 =?utf-8?B?MHZVUVVXRVBSTURsWE9YQ0U0dHJrMWFvREJDa3p1bWZoSlNvWGF4aEFacmRM?=
 =?utf-8?B?S3g5dWQyRngrc0Q1bnV6RnNBREUxaktHOFl3UXl2YVk5dzRlTEV3TE8yS1dq?=
 =?utf-8?B?SlZPZjlqVEI2OTRiZW9yTGJHNzkyTENTUDVtLy94M2pqQ2toTXRaNndIbll5?=
 =?utf-8?B?SFRaaXpZL09ZcmZwMWRUSk9Cb3JTUEtSRUh2MEFGSnRINjVzZWFQcFAvWGpv?=
 =?utf-8?B?Z29hblNqMzJyR1F5UjJnY1hjQWNHc3hOcFh2R1VYU013T0JLdUVCR0k4dHht?=
 =?utf-8?B?RTgxQzF1RElILzZWeXByU0ZIb3JXZDBuTUM2REREOUVJM2F0ZUlhSEpLWTJK?=
 =?utf-8?B?Z1I5bUIxSkVPUHZFVDgvcENLWlVXazBnZTF2WjBaVi9MQ2F5WFdiRGZHODdq?=
 =?utf-8?B?ZGNrTVVhN0FIS2RYSXM4bzJvNHE3MUk2WFg4elBDNGlmWWdvSjhEL0hPcE9G?=
 =?utf-8?B?cjBvVVVsNVpLYklpNlVBRVFpcm40NS9Ra05DRExJSVd6SjNGZ3ZzS3NubEJ2?=
 =?utf-8?B?dERhTm9OR3BxdmlLRUd5UDk0NWJLaTdlR0ZhaTZRajJ5SmRKazVBaXZaeDdI?=
 =?utf-8?B?WjFFVU1VTU11WU1FWDVuQjArMUFKRDUvczhhSmUzVTNHaERTL3NHMzhBOUNt?=
 =?utf-8?B?RnZQL09vQ2QrTWIwdVptSDUzalJoRzdHSnVxeU1IZEdQS0E2cWRDQlVmUTBv?=
 =?utf-8?B?VkhxMFBTVVd1OVlJR1d2NDY0N1pyWGxqb2ZZKzJoSzhQcU5HOFBabGVmbk9v?=
 =?utf-8?B?TWVWQXlmellpZ3BvUWRoN1p0akRPRmhVTWEyU0laZlNkU3ZibnpwR3R5YUdi?=
 =?utf-8?B?TWo0NTdZMWFGY1BuQTUwL2lxbTFLU0dncW5SU2V1SXNXdnZFa2g0SHhDY21l?=
 =?utf-8?B?T2VES1MxTGZGTkU2MG5KUitMMTl2V3p2bkNkQWNwcXg0YmJ0MmRpOXVTQmNW?=
 =?utf-8?Q?MqebfZ0FwUFTKdbo=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Y5qV7o6MisGWh1ZPWCFNYNEP29uaCMCB6Ek4BXpWNG1xS9KkdfN6l0PICaLuYDrkmugZ5kUZsqMnvrSLA+ayI+xR5wYgKkK7UBwNxheYbfo2XKPxqEsuOP0zGAE3XYylr1pLGwAilCq7F7TG9uNoJr93eL76PCgoKORO1kCwbxyy7ty6LrDjSmzhSeDM+NYhDtEDoIiVxjykzCE1zEp43oQFVvxjH+V+FKRI5gjQhnmfHye5uEMgi36ZWVQ21J6Gw/A6lgREs8UAmDFije050+LRP/xCg3/rnfisirBq5xhshnBIFrYSRdhSIg3C5eG/lVMmvbSCr8rBNMwqOkpZWw==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6664fd3a-6e1f-4f8f-8ab9-08dec4ca7bc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2026 19:25:07.2275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aHmnVP/4qpLW/3d8JtSmpVmLTeVOlkuLoPzaZPk/K1fylwpKPYKQMlP+PJovSwhgBwu2p7iNR0dhBeT+FtKySttfRCgIkcFLDqtF7/ZJeqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR02MB10698
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ccphK9k79ha-L775eKolRbFP7048uDFuzxSgywafW8s_1780860310
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296305-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rdunlap@infradead.org,m:andrew@lunn.ch,m:Pier.Beruto@onsemi.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:parthiban.veerasooran@microchip.com,m:richardcochran@gmail.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jerry.ray@microchip.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[infradead.org,lunn.ch,onsemi.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,lwn.net,linuxfoundation.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 60F4F6515A8

PiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldC1uZXh0IHY0IDEzLzE2XSBvbnNlbWk6IHMyNTAwOiBB
ZGQgZHJpdmVyIHN1cHBvcnQgZm9yIFRTMjUwMA0KPiBNQUMtUEhZDQo+IA0KPiA+ICsgdGhlIHF1
ZXN0aW9ucyBhYm91dCBvbnNlbWkgZXRoZXJuZXQgZGV2aWNlcy4gSWYgeW91IHNheSBZLCB5b3UN
Cj4gPiArIHdpbGwgYmUgYXNrZWQgZm9yIHlvdXIgc3BlY2lmaWMgY2FyZCBpbiB0aGUgZm9sbG93
aW5nIHF1ZXN0aW9ucy4NCj4gDQo+IEFib3ZlIGxpbmUgc2hvdWxkIGJlIGluZGVudGVkIHdpdGgg
b25lIHRhYiArIHNwYWNlcy4NCg0KDQpTb3JyeSBhYm91dCB0aGF0LiBXaWxsIGZpeCB0aGUgZm9y
bWF0dGluZyBpc3N1ZSBpbiBib3RoIEtjb25maWcgZmlsZXMsDQpvbmUgdW5kZXIgb25zZW1pIGFu
ZCBvbmUgdW5kZXIgb25zZW1pL3MyNTAwLg0KDQoNCj4gPiArIC8qKg0KPiANCj4gVXNlIC8qDQo+
IHNpbmNlIHRoaXMgaXMgbm90IGEga2VybmVsLWRvYyBjb21tZW50Lg0KPiANCg0KWWVzLiB3aWxs
IGZpeCBpdC4NCg0KDQo+ID4gKyAqIENvbnZlcnQgdW5zaWduZWQgc2NhbGVkX3BwbSB0byBhdHRv
LXNlY29uZHMgcGVyIGNsb2NrIGN5Y2xlcy4NCj4gPiArICogVGhlIHNjYWxlZF9wcG0gZm9ybWF0
IGlzIFF4LjE2IC0tPiAxIGxzYiA9IDEvNjU1MzYgcHBtLg0KPiA+ICsgKiBUaGUgY2xvY2sgcGVy
aW9kIG9mIHRoZSBTMjUwMCBpcyA4bnMgKDEyNSBNSHopLCBzbyAxIGxzYiBvZg0KDQo=


