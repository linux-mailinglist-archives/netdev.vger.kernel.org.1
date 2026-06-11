Return-Path: <netdev+bounces-298375-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pqekBOIwK2r43wMAu9opvQ
	(envelope-from <netdev+bounces-298375-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 00:04:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56152675892
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 00:04:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onsemi.com header.s=mimecast20250127 header.b=gYzW+rWz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298375-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298375-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=onsemi.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFA4633D9D71
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 21:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAA838A73C;
	Thu, 11 Jun 2026 21:59:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACEF389E05
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 21:59:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781215195; cv=none; b=jOh/RS8677eU0Kp3QCn5rY+fXRHf6SZ4a0Y3bSQEK9EbenpJnHB4Jlp+V4DxAWpMCAV0BYyrm+VdL52NB9Ls9shZe8QBkqso1JHVtgNtdo05TQ/0r8V9uSEaCsL6t+eKWFqaVgkxtXw14ByArL0tIVb6/DnyLtDj2lvV1vAkfLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781215195; c=relaxed/simple;
	bh=gti61QZk/gY458cZr7mD3GeQ5aNwvVOT+BJDap7mnS8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=JwJiQ51Kycq5LuX3xu5GvKxcgfYXYr0mrWC1IUoM8OJC8I42+Sv1wm0JT78j2JBSiYBCSZNaiP9Xg80RJybyclqsWrOBX/czBThIifDo30Od14sXwQ7n4trpTSNBGevd+4W7rzrDpr3ayclPONY5FjhYkuEXSKX+D0DTOoANcCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=gYzW+rWz; arc=none smtp.client-ip=170.10.153.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1781215189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gti61QZk/gY458cZr7mD3GeQ5aNwvVOT+BJDap7mnS8=;
	b=gYzW+rWzsBkjbyqXYsZIUb/6Opwtvlpq70BgLzC2g5cDb7GcDDsOLABsV0yBlzm6UmxM5e
	dnDFpQgxAo3lg43aoipc/AJIj8o1/vDb7KH27+nF/tB/ce4FdNg+2vkiHLLPhF1Gl2taEM
	Z/XawX41f+MZxkQI1S/Pv3KQwZ6J9x04LQL7VHcHVfWYGyRw3MQzNlVgNY4QFH4pZ98R3V
	JE/J5adTwPZPPbmHxss8naOoVrCsa2+/WvgNMG8SCvKF8UjksXc9szzngNYS4DHIHpBVN3
	d/bFWoCh8HDbb711A34ZIH9XdVZGUcGoTqczyt4OkoDzPqOud8YAZedYoMbMFw==
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012014.outbound.protection.outlook.com [52.101.43.14]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-40-na8apAWeM8a9Vshx6ZxeTQ-1; Thu,
 11 Jun 2026 14:59:44 -0700
X-MC-Unique: na8apAWeM8a9Vshx6ZxeTQ-1
X-Mimecast-MFC-AGG-ID: na8apAWeM8a9Vshx6ZxeTQ_1781215181
Received: from CYYPR02MB9828.namprd02.prod.outlook.com (2603:10b6:930:b8::20)
 by DM4PR02MB9238.namprd02.prod.outlook.com (2603:10b6:8:106::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 21:59:33 +0000
Received: from CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca]) by CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca%4]) with mapi id 15.21.0092.016; Thu, 11 Jun 2026
 21:59:33 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: "Parthiban.Veerasooran@microchip.com"
	<Parthiban.Veerasooran@microchip.com>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"conor@kernel.org" <conor@kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Conor.Dooley@microchip.com"
	<Conor.Dooley@microchip.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH net v3 2/2] dt-bindings: net: updated interrupt type to be
 active low, level triggered
Thread-Topic: [PATCH net v3 2/2] dt-bindings: net: updated interrupt type to
 be active low, level triggered
Thread-Index: AQHc8eDLvWzkHnbXI0KmrY/VvMfuDrYrecyAgAALlpCAAm25gIAAkU0wgAAYXICAAAajgIAFcz6AgAAGt5CAAd//gIAAaviwgABI9uCAAq+yAIAAFbtQgACAaNA=
Date: Thu, 11 Jun 2026 21:59:33 +0000
Message-ID: <CYYPR02MB98285C570F545729D3ECFB35831B2@CYYPR02MB9828.namprd02.prod.outlook.com>
References: <20260601-level-trigger-v3-0-da73e7010532@onsemi.com>
 <20260601-level-trigger-v3-2-da73e7010532@onsemi.com>
 <20260602-rebel-snide-5036c97e410d@spud>
 <CY8PR02MB92493D2E5491AAE5416C05A283122@CY8PR02MB9249.namprd02.prod.outlook.com>
 <a5abb9b8-6ebf-4f95-a684-fc889b98acea@microchip.com>
 <CY8PR02MB9249E607ACBF3A05AB83ABF683102@CY8PR02MB9249.namprd02.prod.outlook.com>
 <20260604-swimwear-garnet-3eb092e6fda7@spud>
 <4df9882b-3426-4c36-8048-0c76d0f11c74@lunn.ch>
 <7c68173a-ebff-42cc-8519-95e8365805b5@microchip.com>
 <DM4PR02MB926317F64B5A3827009B66A9831C2@DM4PR02MB9263.namprd02.prod.outlook.com>
 <a02cd86e-a5b8-481c-a07e-7243ee537b24@microchip.com>
 <CY8PR02MB9249EC4F3896121911D0FF3C831D2@CY8PR02MB9249.namprd02.prod.outlook.com>
 <CY8PR02MB9249B913E28E285EB46EC59C831D2@CY8PR02MB9249.namprd02.prod.outlook.com>
 <56e6c9ea-2e2a-406d-b7d0-ec484e3170e6@microchip.com>
 <CY8PR02MB92498B8CC2E0A3B50908C510831B2@CY8PR02MB9249.namprd02.prod.outlook.com>
In-Reply-To: <CY8PR02MB92498B8CC2E0A3B50908C510831B2@CY8PR02MB9249.namprd02.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR02MB9828:EE_|DM4PR02MB9238:EE_
x-ms-office365-filtering-correlation-id: 1a6ee0ef-3952-4007-6a83-08dec804b894
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|38070700021|6133799003|4143699003|11063799006|56012099006|18002099003|22082099003
x-microsoft-antispam-message-info: rnm6UCkmymTAECRo28EqfOwkyMCst0vN0wZnjD7gPt+0n3kjQgUvaHxf/6Y5SUhuo86Ox3v5ft9GMxEiuht16AQaJ6kW2vCbG0aFfoIdq2gjwG+Avqbgq6hGwuKkCYjsfeRY5nEcs2T8txphH70ryzLSCZM4p0VlTRLoCuVAzmm4lujVbytWVeKySrIDB29eS7ixPb5zR7WiMF3sOqhzgyV1Kv9ljIa4ocSr4eVvpk6962XrLisWjqMv4NsanHRrNu0duAQu2TmwQyAiXuCbLd6kUgyhy4VzNbhz+/RwHewsRI/R/6yCpdOYEuSCz9q/GYZG5PPoFMBUfEq3r1kK0zOA3LjMGP2pHgzcM2xzVH4i+g/DqcqN/FrI3awHewQJnuXRYUcr2iPFvQoR/7eOHNOYspt4bBahpMspqgbLsDqiC14QI/vaUooS2wqAQUOd+N4FrxZtplsre64spnvhhNmibh6BQ9DXVUkt+S5o+9KGY+ZEntOSHxXKzma/pgDSQu9FDhNkOCfPGJMN3hMJAwkKcTVNhcslu7qoxkQ17y+sLxhcRwT4thZ4tBRj0/hfs/NcU0jOejR+y7fRBQYuYAc9RE42jlV2r68hZkTro049MV3qUeEu38PGrzcKLp2PqATkQmTjI1U97wG3dH8LZs1+guaggdxNbl2hV7BEKB5P9vOqrWGy5y/5wzkXoKkiuJyGc22MieaThzyv4xeh6E5Krheh52uN3utZflj60cubHHSgkNiGz9IBxureyKmn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR02MB9828.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(38070700021)(6133799003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXVBQnZhMnlHRFk4Wm5jbFBtL29tWXdKSENaUWgzYUY0WWtsVDBZYVEyZmdz?=
 =?utf-8?B?d3RFU1lKczJLVTdpR3ZWVWJDQmU3RDcrZi91eko0WlBFZ3oxbHpaWVRYMlhE?=
 =?utf-8?B?aDlLZ1lGeFN2OS9ReXdKdGJNRk1rS243SUtpU0VwZmxQY3FLMjQ5d3RoaWJC?=
 =?utf-8?B?b1YvYkY4blRUU1J5eG0zS0IyWmZ6cTI1UHN3OStISitDWmNHNnIxWkdlcXM0?=
 =?utf-8?B?MkJ5V1JQbnRFMHV3N3dnb2ZGVHJBczlRbTk1eWVWM3QyWU00QXlkcWlTL3VX?=
 =?utf-8?B?TEtyNGZDaXFrT2tuQmdNYk5vYVp3SkdBaU9ndXZXRzZ5Y2tHM0k0K0FETG5l?=
 =?utf-8?B?RmhMeWVNRHcvdkpUeGs4L2FNd2dGZVNxN2I3alNFbytZNHlXbHdPRVdDVmZR?=
 =?utf-8?B?VHAwbE0xNHduRzNoaTNob0FzMEZha2svbHI4U1FsNWRQVExoRFdSVVVlVU9o?=
 =?utf-8?B?MXZtWFo3ZWhGb3JUQmNXRjNadjltNWpESDlGdVp2U0RnREdudXhVMGFLS21i?=
 =?utf-8?B?c1A2a0N5azlhWWtuZnViQnUxTFk2WGZldHF1WEVpRmtLamo3bVhsVXdibWo4?=
 =?utf-8?B?dXBlUVZCNjBWc2prSXl1L1kzcmpPc3lrVWdGQjd1SXlNQTEyZHZTQU12WlRK?=
 =?utf-8?B?d1JKbXg4QkMzbEthczZISnRtSjZPTHJiOVQ1cWt0WjhXaTM1OExLU0ozUXV1?=
 =?utf-8?B?VnhGUmcycTVFSTFRdWNLWm9YYmcyaUl6Q0M2bHZncG81Q1F1ZUxyanAyOWNq?=
 =?utf-8?B?TnhNNnZYYXlFVGdaL3Jaa05JaHdrb3I2M2RPN3c3dElOUHRWQnZCNU52dm9O?=
 =?utf-8?B?aCtHVkZlMUMyaTEyZkgrS28rV1FyMkdsaE41amNQd2c3QzdSUXZDUWNYOGR1?=
 =?utf-8?B?LytzQVpIVGkzajlWMDYveW5FdE1IdUFicVBBY2FyOE5tNWpDeWlLRzNjdlNH?=
 =?utf-8?B?TjYzT1ZGRmdlbnlXbGdrTGhVNnUvUGphdGpzUzQ1WUd1Wjd0YmlXaEVYekc3?=
 =?utf-8?B?YjN6QkFCSkFLdm5YbmF1RFVpU2JuMkhVUklna2FFQXdCRUJNSHZRT2ovMFZS?=
 =?utf-8?B?NXl2MVR1NlJPS05OYmxtakNpZDRrZ1JISHhWRWZ6bnMxelFCWFZtTGtEMHB2?=
 =?utf-8?B?aTdiRkd4c1l0bHB5aXduMDhCekVJR09WYnRJYzJPQ3ZBN3F5VUJDWDQzUHBq?=
 =?utf-8?B?QldTVmNvM0JQcmRxNXZnZnFOd3lvVi9CNEVjTnhXUWp6eklOdDFQUWRaRy9v?=
 =?utf-8?B?RUNtVHAwY1dxc1lzV01ub2VMQmFyNExSV3BYZVpweCtQVldkc3dMMlRoM2Fm?=
 =?utf-8?B?bzhlVGw1R0RIQW54UHJmN0VBVGNoM0JweW1RWGlmTjNoNXhtZFNHa3BoMXdn?=
 =?utf-8?B?Mk1rRlRueExuRUljcTRrNVlkdURaZFJYVnl3cTF6c2JqQXpCNm9GMkNsQWdM?=
 =?utf-8?B?d21rZjJ3ajJmU2UrOFMyQk94NTdFUElPL0Vpd1pXK0gxaUpkQzdML2dRWGUv?=
 =?utf-8?B?M01XNTdyUWtQWGRuRWNYUmhzSHk1bWlZSzY2K2l5Zno5bWM0V21OTmhKRVJ2?=
 =?utf-8?B?NEdZRURIbkxOTXB6U1E3YXVSZEVNVkZOeWF2dUpqUW1EeGxIL0tXRnBqbjI1?=
 =?utf-8?B?aU1HcDQ4elR5RzZnT3FlYWNwVkdkVnI1WEppdGhpNERlUGVXYU5wU2JLTXFr?=
 =?utf-8?B?bEtsazE2LzkvWEl4akhVT1lGVmZ6UngwNlJwZ25zSkR2b3lObjZKNk9iM2N0?=
 =?utf-8?B?TlhiSFRTemNrYk14NEdqMkc4YVBPeDI3WVA0bTZyR0RTbUJESVoyYS81K1JF?=
 =?utf-8?B?L1lxRzA2anBDU1d4M3pWUU1WYVczelBOYW1Xd1UybHE2RlZyREFxc0grRE1y?=
 =?utf-8?B?dTU3MVFaaVJSK3VIb0x5cTdOYXBEanA1cE5RUnFEU3NQMTZJS0hkR3AxU2to?=
 =?utf-8?B?UVlFUE0vTFMzY3VvSW1wL01FdG02YUhYcHJOeEh2Q0RwOVdUUHY4ZXZuTU1v?=
 =?utf-8?B?bmtVaE9BWUZ0c2t0MXY2RzlRV25abWx6dC81R00xK285SDdTUjY4Q1pPWEtF?=
 =?utf-8?B?NEErSXQzMzlmNmZWSERxK204NlRoSlFBNmtuOWgzQ3FGMlBmSTlnZERsbkxK?=
 =?utf-8?B?QjQ2d2tLdmxiRThpVnQ3VldneVhlL1NzZUdzcnlzVkNmUjEwdVVicU5SNFpQ?=
 =?utf-8?B?YjlHWUw4Wml1dks1QlFjc2JGM1phVWNsaDBzeTRBSUR4aldTanFFeHhkSEx2?=
 =?utf-8?B?VXhnTEozWFE2TG05V2htMXNpRFJuVUd6bDdWUWVSQXNoanVQRUMvazIwWEgz?=
 =?utf-8?B?ODM0ZjN5QWZiNWRzaHBDUEZnbC9LVGloVGE4dm5lWFpiWXBEb2R1WkkvOEFv?=
 =?utf-8?Q?fbech8rJy3TfPu40=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Dv23SSL/XAYHTGCHu6OFFoMFJoS/k0dlN5aIceS/C2euWRkcGSQa67i9uV232YaZfh+jcw/Ip3hOI5w3iwbdbwmCNS9XrfFlnXZijQb4mbP/AeNfhLWdcBNPoKKFVrC+ZpzXnZrmGLcPzV76UAoUt5dkSpYtXguwbYOReWQnZvFZcwyOcLKBUJke2P46V9IEMwE7wdhlbmJcZuNYLRISJzjiEPSDvNQxrYPGrmC98PTONtf+jgMvfx3yJ764MFwk9xEYg3GRlJeXQPDB8aWs+aThO7n5zxWW62JvsNQQyQzAP3gEfajHy9bxLuTbXwk8nfVRAlyf1i66fr2ymf9moQ==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR02MB9828.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a6ee0ef-3952-4007-6a83-08dec804b894
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2026 21:59:33.5219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nSUHLU5+uG7/Bzir78vsXzJfk4M50k2Ql9WKaBouK7E4tyGJVygIQzk8yeNpVznNTU4vwU/XRitIP3bIDNJuhSqkMV5zhqZcx4F2JZ6OdPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB9238
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WfW-XBmubmWR1WRc5gyzsoFVLgDae-Smoeh8JyeYdfw_1781215181
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298375-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:Parthiban.Veerasooran@microchip.com,m:andrew@lunn.ch,m:conor@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Pier.Beruto@onsemi.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:Conor.Dooley@microchip.com,m:devicetree@vger.kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[onsemi.com:dkim,onsemi.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,CYYPR02MB9828.namprd02.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 56152675892

PiBTdWJqZWN0OiBSRTogW1BBVENIIG5ldCB2MyAyLzJdIGR0LWJpbmRpbmdzOiBuZXQ6IHVwZGF0
ZWQgaW50ZXJydXB0IHR5cGUgdG8gYmUgYWN0aXZlIGxvdywgbGV2ZWwgdHJpZ2dlcmVkDQo+IA0K
PiA+DQo+ID4gT24gMTAvMDYvMjYgMTozMiBhbSwgU2VsdmFtYW5pIFJhamFnb3BhbCB3cm90ZToN
Cj4gPg0KPiA+IFRoYW5rIHlvdSBmb3IgdGhlIHVwZGF0ZS4gSSB3aWxsIHRlc3QgeW91ciB2NCBz
dWJtaXNzaW9uIGFuZCBzaGFyZSB0aGUNCj4gPiBmZWVkYmFjayBhcyBzb29uIGFzIHBvc3NpYmxl
Lg0KPiANCj4gUGFydGhpYmFuLA0KPiANCj4gSSB0aGluayBpdCBpcyBiZXR0ZXIgdG8gd2FpdCBm
b3IgdjUgdG8gdGVzdC4gdjQgZmFpbGVkIGluIEFJIGNvZGUgcmV2aWV3LiBJdCByYWlzZWQgc29t
ZQ0KPiBpbXBvcnRhbnQgcmFjZSBjb25kaXRpb25zIHJlbGF0ZWQNCj4gcXVlc3Rpb25zLiBJIGhh
dmUgc29tZSBtb3JlIGNoYW5nZXMgdG8gYWRkcmVzcyB0aG9zZS4gV2lsbCBzdWJtaXQgdjUgc29v
bi4gWW91IHdpbGwNCj4gaGF2ZSBpdCBieSBNb25kYXksIGlmIG5vdCB0b2RheS4NCj4gDQoNCg0K
SSBqdXN0IHN1Ym1pdHRlZCB2NS4gUGxlYXNlIHZlcmlmeSB3aGVuIHlvdSBoYXZlIHRpbWUsIHVu
bGVzcyB5b3Ugd2FudCB0byANCndhaXQgZm9yIEFJIGNvZGUgcmV2aWV3IHRvIGJlIGRvbmUsIHdo
aWNoIGlzIGZpbmUgdG9vLg0KDQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3Qv
bmV0ZGV2YnBmL2xpc3QvP3Nlcmllcz0xMTEwMzA5DQoNCg0KPiA+DQo+ID4gQmVzdCByZWdhcmRz
LA0KPiA+IFBhcnRoaWJhbiBWDQo+ID4gPg0KDQo=


