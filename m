Return-Path: <netdev+bounces-302003-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id afp9DapHPWrl0ggAu9opvQ
	(envelope-from <netdev+bounces-302003-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:22:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 978326C7053
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:22:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onsemi.com header.s=mimecast20250127 header.b=iKvQpY7x;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302003-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302003-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=onsemi.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A44A53048C22
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 15:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022BE3E8333;
	Thu, 25 Jun 2026 15:22:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCB71F5EA
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 15:22:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782400935; cv=none; b=G1j0+xVlZihDKFDVdzbkJLw4Jb4ISY4dVKxwtBP1kQl51ZKcFLSfE7iFg5F2gdERsAJouSNznkVh08V2rZpP0GKWQK3sO2eTCPBf26nvYSp1vwDW0z7UZMKjNcoTmHNEgavBW8Ka91yexSMMxVF3sXba7Cu9Ft5eF/WHX+FNmmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782400935; c=relaxed/simple;
	bh=zgX8wTyuhRWY/epOy/oDCEMIc2fIwHZr/kiZDdN6w0I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=qOjxpB20m/V81WMVBnQNp/Lnz+M5IrNJ1usssQBkMVzkyfJVB23E4VksWT0DePFc4ms/fJNGbWXbtYUMkEL7JtxKvRGsCSs8zI2dICURhk5fyGsIlBJPmJ5DUpzkPVqGzQ8b4UpfolgLPnl/p4qM+dZKeNFGCu054CpL8rsSzYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=iKvQpY7x; arc=none smtp.client-ip=170.10.153.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1782400928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zgX8wTyuhRWY/epOy/oDCEMIc2fIwHZr/kiZDdN6w0I=;
	b=iKvQpY7xekhiJnJX4ZmGuzzYmADQ5pG6QSwvo3t3HxnfEKQFw/E2ni4qMZ49Z0X8jLwqV2
	kuZpn1s31uLMht0aQlH8MdDSjGAppsdlI5Lf+Z4nWI4viImn/c4jIXvK2AzuM/OJvYXyXY
	BpdZxdYUIGxZtE/56PzC25UUT1eV/ugKWspWq0xid+BojzNGuK5GBDefpv8PVRON8T2v+z
	P2B+IRcy1MEmMpAmJG5BZE7ejkGXa2cwqt4HUvpDWylXXORF0aZOQyOjWxxDUV8VO09tWD
	bN9q7TKgTZkWHwf9r/d3IMe5UyFj0xkPc/dR+3VJEVoW9sqUppICyKWBUx7SyA==
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010008.outbound.protection.outlook.com
 [52.101.193.8]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-60-PKXQPM9MOwi2o9gvL_bgOQ-1; Thu, 25 Jun 2026 08:22:04 -0700
X-MC-Unique: PKXQPM9MOwi2o9gvL_bgOQ-1
X-Mimecast-MFC-AGG-ID: PKXQPM9MOwi2o9gvL_bgOQ_1782400920
Received: from CYYPR02MB9828.namprd02.prod.outlook.com (2603:10b6:930:b8::20)
 by CH3PR02MB9781.namprd02.prod.outlook.com (2603:10b6:610:178::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 15:21:58 +0000
Received: from CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca]) by CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca%4]) with mapi id 15.21.0159.012; Thu, 25 Jun 2026
 15:21:58 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: "Parthiban.Veerasooran@microchip.com"
	<Parthiban.Veerasooran@microchip.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, Piergiorgio Beruto
	<Pier.Beruto@onsemi.com>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Conor.Dooley@microchip.com"
	<Conor.Dooley@microchip.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH net v5 1/4] net: ethernet: oa_tc6: Interrupt is active
 low, level triggered.
Thread-Topic: [PATCH net v5 1/4] net: ethernet: oa_tc6: Interrupt is active
 low, level triggered.
Thread-Index: AQHc+e0nFxx0u09WdkC+bo9XNPrS8rZAt0OAgAMGobCABlg+EIABlccAgAAFtTCAA5jlAIAAJzFw
Date: Thu, 25 Jun 2026 15:21:57 +0000
Message-ID: <CYYPR02MB982836BC273D09FD3BDE623583EC2@CYYPR02MB9828.namprd02.prod.outlook.com>
References: <20260611-level-trigger-v5-0-4533a9e85ce2@onsemi.com>
 <20260611-level-trigger-v5-1-4533a9e85ce2@onsemi.com>
 <7c89df6b-32ac-46c8-8400-945879037f2e@microchip.com>
 <CYYPR02MB9828CD98EEEB9B218A940E4483E32@CYYPR02MB9828.namprd02.prod.outlook.com>
 <CYYPR02MB9828A1434E6339A6CFCCA74283EF2@CYYPR02MB9828.namprd02.prod.outlook.com>
 <64f4f30e-a987-4289-b36a-1acc977a6764@microchip.com>
 <CYYPR02MB9828E1167750AEA090EC60CD83EE2@CYYPR02MB9828.namprd02.prod.outlook.com>
 <f127837f-e08f-48e0-a3a9-906e1d61d6bb@microchip.com>
In-Reply-To: <f127837f-e08f-48e0-a3a9-906e1d61d6bb@microchip.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR02MB9828:EE_|CH3PR02MB9781:EE_
x-ms-office365-filtering-correlation-id: e55d7eb3-8a3b-410b-0a18-08ded2cd7f5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|921020|38070700021|18002099003|22082099003|4143699003|6133799003|11063799006|56012099006
x-microsoft-antispam-message-info: bAB4Wl8ITfCyclh8N+0qsjVEcMRjmnsz+qc78SouUBt5/FpQwQ9aDD18gcQuzJXCWAUvFOSW6DBva073k6P/xO7XMGH6QWN35G4xNJlkLe74YMDA3OUN261ZoRTqsGSz8nxAaOv6gMXkwa/m2W3H647W/vmuU7AZa86raYEB/a9jc7ecopaX1cd7EWOlXAxfQQV2BkHmjeBZ65Dj4GF3DSwYRfyml7lhtE28JLuORT+FwaBi3hQGxYWrhD4U8GHSC/O3DjcIzQw3le0JeluEbqhRJhTuLougm3E+FE1EGtoakTK0oZ+uqW2rOR7AtYNjFKBp+8Nvp96UDg6AXwSrTPBGX8esjnuGH32CNsHMBxSE09LGXhQFTc+cTpytFkIbH8+f6CT8EcnTO75YK235ZrFmN1qYwNSJ69Mr1bXR5O4/FvEU9OZh4/SqINMn6nM/Muly2MD/aAanZUELSf7YHuUATW2BMjOEfvATWGV3r6IufWszfMzIR0k3Njxw2Jor4WPAaX+04zD+Ops63HUhnKXQ+v/xtlBXrK4dFP2OWzjeEEt98yNmLgKWrf49srKEK2dm5hWFYRaLT9Zw3riZ+G2GtP4wHolWZCQoYlVEd9WA2QtLBeFdH6UQzg1L4bmCAgkUKv/3t6SUqGrNcnd9gx7NRYdY5wg21eSOWO6OKQ8ifR5o68QOKKlHGVod2DzDLwEnZ+qttaBZIZ4jN5PSxJS9r/D2NHu73Rwgur9YGFSKB0PmJJJ8k1DTJ1qZTu54
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR02MB9828.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(921020)(38070700021)(18002099003)(22082099003)(4143699003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWhOWTN0Qkp1YjFpRkxzV0xaTFhoZmQydzVRZklob3o1R1J6Zmp2L0Y2UDBu?=
 =?utf-8?B?T1J6UHFCUUM4M1VjQ083QnN3Rjd6YXJyeTZvRmtVSmFoSTc2b0orRlE3alFT?=
 =?utf-8?B?a2prcmVqZW1Fa2lEVWN5SGpEZzFRbVMrRTVpUHhKeWNwSmlHa1JEMTF0TGZw?=
 =?utf-8?B?S2lDM0x2VFJQb0pjbzc0V3NLVmtoNXdVbjd5ZFFmaTJKN0s5OEI5SzVrbndY?=
 =?utf-8?B?VmhBc0hYVFIwenhGUndMWjE4cmVCR0JJT3BGTXVaVmkxcERuSE14V0tSVHFR?=
 =?utf-8?B?VkZrQ2VTcW1URjlERkJmQmtxcDROMzZoTW1kcXArNGZtRGVHK1ZvSWFsMFMx?=
 =?utf-8?B?TUMxcEt3YTNvVStnU2x4M2xGS0w2SENYQjRPMnk3MFc4SHBkTDJReENsL3BD?=
 =?utf-8?B?V1VCWUpTYmppSkxoNVIzQm1YU0YrV2lnQ2hJSm9rM2drUWhIM0IwM3RsaVV5?=
 =?utf-8?B?eUlmMUlXTTd4M3I0MWNyZit1VEFudGtmSzRGOEVqcUROZUk5bzYxM1k4eFpj?=
 =?utf-8?B?bllFRzVBQkk5RGFVU2tTQ1o2TkgvVmRtRWpJNTJMZDloUU5GZnc5bnU0T1cz?=
 =?utf-8?B?SjZLUGdNOHUxU3h2RVBKWVUzcnVtemlWWlJpbVpsck8welc1OUoxd1YvTXFt?=
 =?utf-8?B?NlBkWXBEcFQ1blo1SStqRTJKOGRPSUxMakZxMkhsNnRXOWczemkxbldCays3?=
 =?utf-8?B?K2g3azFsOHZXbGtOek0rZjJuTFI4MWsxaTZ1NFR0cE5RSXZhNDZrUjgxaXhw?=
 =?utf-8?B?REMrYXdBYTM1WnRENXd0dUFBM1NtUkVzMTRmZC81TUllZ3YwT3lNaktVcFYx?=
 =?utf-8?B?SUkzZEdlMTljekF2aDNZbTJFRnhoQlRqRktsU3JrcEdSeExEYjhPRnJWT0Ns?=
 =?utf-8?B?c2dtb05BakdWdEE3QUVEQ2JVbVcwdHh5dTcwWWI1Ym55Szd1eFZrd01qWDJp?=
 =?utf-8?B?cnV2VWpmTks3akNoOHlRbGdjd2V2SU9DYzZscTQzU1dvanJ2azFXMTJkWkYr?=
 =?utf-8?B?MmZHNWp0QjFRUXVLd2lTeEpYN0JhOTF3UTNJOU1iem90NndERlhabGRKMW03?=
 =?utf-8?B?RWNGWGQySjhoS1lmYXlmWndaQUZYVmYyZlk4emJlOFlkVW00V2ZycDFQd0cz?=
 =?utf-8?B?WDlKZ05Ua2pKSGU5Y2dOcnQ3TXFhUU95ZDdsRVp4anQxeHFhUDBhSi9DVzBT?=
 =?utf-8?B?bWRLZlZGSDZZcGczWWI2YUdtNU14SUswVGNLMjlhU002ZEZweUpWT3poaG9F?=
 =?utf-8?B?Zlk1TjNxaUtTRTlHOHhqeW9GU1AxQyswSk9tSCtpQXRtT1JBc2o0cUFmM2o5?=
 =?utf-8?B?Unp3bzdTMnJDa1dlVEFuVWYvdDBGSTlQL0ZBZ2I2R2ExdW5ZSEduVVNOTys2?=
 =?utf-8?B?MWd3QnVveEdKNUZpa2tUSG9oRlRBajZTUjRPZUEzYXlkczhPdlpBaUl4aDlP?=
 =?utf-8?B?c0ZMYk5xTFlaL1gzR3RvcDZkdUFnYVdlKzVXNlljdUZoenMrT1hDdk83SWtS?=
 =?utf-8?B?eDhqNk5hK0RNQ3BtRzhWUVNPY3ZoZWNxNUFUcXZZYkp6KzNwM1NoTk1mMGRC?=
 =?utf-8?B?Y0lxSkw2SFRTcG5ROFcwTmY4Q0lCWEtLN2pGVWc0dFdKL2lCMCtMK1VJOS92?=
 =?utf-8?B?TmlIdHN0RzRJTEtHOUxVNlpNR29hQ2hTSkd5RUdWd1J3R3J0UlNmQjF2Lzkx?=
 =?utf-8?B?bG1HUUkyRlcxY3ZOL3VMbldVRXltVVVRYUhvcTRnMnFLNnMzQ1ZpYTY4STBz?=
 =?utf-8?B?VjY2L2EwbW4xbjkyczJaRXBheFc1ZlBGSEh6bVQ1MTl0ajBtSnJIRVFWQWRJ?=
 =?utf-8?B?WXRjRUgraCtjWlFDRFl5akZUc3pmakREVXlDc29TczhJRjloUitZcEk2YXlo?=
 =?utf-8?B?cUxCYXI0NGpwTEluOXpiY2ptb2RsdWVxeVdQRjFpOVV4aVpoZE9qYXRtTU1T?=
 =?utf-8?B?cFUvZlF4L2ovU0c5dUxkWTFOU242dFpNbXdvRzBteDArdmlHeTlkQnQwdmFZ?=
 =?utf-8?B?TDFsbUJPZXNlQTdYaGJhY21QY1dHRFV4dXA0ditaczIzMCtzcFNYR2p2MFY4?=
 =?utf-8?B?dzJNdXBQS3VzVVhrNkp0OUMxOU5IMHovZXM2VVU3a2RtYTh2RnRZZFVKam1l?=
 =?utf-8?B?SnBYWXpIeVdIZEMyNHdRb1U4MldpemU1bXg5L2dqdkNQTGJqZXlCU2VhdGFo?=
 =?utf-8?B?UTVYclFpZmhPODBDWXNZL2ZETWh0OVhOenZEYjhOVmxzV0NDYWg2TTBkMFVa?=
 =?utf-8?B?UEJCODNScFZ0ZDkvZ0xXQndOeFg5OHFCTnV1MGwweTlQeVJ5TytlcEZkU2VH?=
 =?utf-8?B?azMybTR6a25hOUttS0hDNkNZUDFobmZNeWo2T3lBQTVZSEltTWk0Ym1xMk43?=
 =?utf-8?Q?+cCk9gCuWMvN+2ug=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WVAflkfV5VknQQHOVWp3bPBol9zkd6xu8vg3dj//sfa2GUe0sGNvXqpOQY7D/SbgmQsGcuSgIqh1OgFg6CFx7njz0BJXbcwwqUgO7nlDXDRiuZ7Yn9bU/30G5RKYIh4p8sfKbVMyW11yL0pUZh7Jhf3E1hhXUjJscZTUlaqOM4ZnDXWw2BagWfPsWoG5vvJq4YWXmMuVAdMgnV85N5nAFlGWKHGXGrCIV2ZkQjdoXA8aVlz4RjNDrC5Uq0MuVeFvbVqqkT469pBBCQ0aHG3mb69KTAh7MJ8y1r+F5RS+bx//0A4M82fQS6ioycprD/NIhCuO3l7Q9P10p2Lj5NFYWQ==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR02MB9828.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e55d7eb3-8a3b-410b-0a18-08ded2cd7f5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2026 15:21:57.9620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UbUgJ3SKcKPxPNct6Alsvgh/yCW2KcYVa0WcLV62w6hRjx6cGDTEJV5oeEsfwGCHO0zE5xK5GLRWJifXnmxu0oMu//5ZYHHCMCK5s5vyFQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9781
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: t69P3VpatNQL_7d6K5Ldxsrj9rhsudo5iiz4Xzz24ks_1782400920
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302003-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Parthiban.Veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Pier.Beruto@onsemi.com,m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:Conor.Dooley@microchip.com,m:devicetree@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,onsemi.com:dkim,onsemi.com:from_mime,microchip.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 978326C7053

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYXJ0aGliYW4uVmVlcmFzb29y
YW5AbWljcm9jaGlwLmNvbSA8UGFydGhpYmFuLlZlZXJhc29vcmFuQG1pY3JvY2hpcC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0IHY1IDEvNF0gbmV0OiBldGhlcm5ldDogb2FfdGM2OiBJ
bnRlcnJ1cHQgaXMgYWN0aXZlIGxvdywgbGV2ZWwgdHJpZ2dlcmVkLg0KPiANCj4gDQo+IFdpdGgg
eW91ciBhYm92ZSBwYXRjaGVzLCBJIGRpZCBhIHF1aWNrIHRlc3QgKFRlc3QgY2FzZSAyKSB3aXRo
IHR3bw0KPiBNaWNyb2NoaXAgTUFDLVBIWXMgYW5kIGZhY2VkIGEgc2ltaWxhciBpc3N1ZSByZXBv
cnRlZCBiZWZvcmUuIFNoYXJpbmcNCj4gdGhlIGRtZXNnIGNyYXNoIGxvZyBmb3IgeW91ciByZWZl
cmVuY2UuDQoNClJvb3QgY2F1c2Ugc2VlbXMgdG8gYmUgc2FtZS4gV2hlbiBvYV90YzZfdXBkYXRl
X3J4X3NrYiBmdW5jdGlvbiBpcyBjYWxsZWQsIHRjNi0+cnhfc2tiIA0Kc2VlbXMgdG8gYmUgTlVM
TCwgd2hpY2ggbWF5IG1lYW4sIGNvbnRyb2xsZXIgc2VlbXMgdG8gYmUgbm90IGdldHRpbmcgc3Rh
cnQNCg0KSSBoYXZlIGEgdGhlb3J5LiBMb29rIGF0IGxpbmUgIzkzMy4gV2UgaGF2ZSB0aGUgZm9s
bG93aW5nIGNvbW1lbnQuIEkgYW0gc3VyZSB0aGlzIGNvdWxkIGJlIHRydWUNCmZvciB0aGUgY2Fs
bCB0byBvYV90YzZfcHJjc19yeF9mcmFtZV9lbmQgYXQgbGluZSAjOTI2IG9yIG9hX3RjNl9wcmNz
X29uZ29pbmdfcnhfZnJhbWUgYXQgbGluZSAjOTUwLg0KICAgICAgICAgICAgICAgLyogQWZ0ZXIg
cnggYnVmZmVyIG92ZXJmbG93IGVycm9yIHJlY2VpdmVkLCB0aGVyZSBtaWdodCBiZSBhDQogICAg
ICAgICAgICAgICAgICogcG9zc2liaWxpdHkgb2YgZ2V0dGluZyBhbiBlbmQgdmFsaWQgb2YgYSBw
cmV2aW91c2x5DQogICAgICAgICAgICAgICAgICogaW5jb21wbGV0ZSByeCBmcmFtZSBhbG9uZyB3
aXRoIHRoZSBuZXcgcnggZnJhbWUgc3RhcnQgdmFsaWQuDQogICAgICAgICAgICAgICAgICovDQoN
CkVpdGhlciB3ZSBjaGFuZ2UgdGhlIGZvbGxvd2luZyBsaW5lIGluIHRoZSBmdW5jdGlvbiBvYV90
YzZfdXBkYXRlX3J4X3NrYg0KICAgIGlmICgodGM2LT5yeF9za2ItPnRhaWwgKyBsZW5ndGgpID4g
dGM2LT5yeF9za2ItPmVuZCkgew0KdG8NCiAgICAgICAgaWYgKHRjNi0+cnhfc2tiID09IE5VTEwg
fHwgKHRjNi0+cnhfc2tiLT50YWlsICsgbGVuZ3RoKSA+IHRjNi0+cnhfc2tiLT5lbmQpIHsNCg0K
T3IgYWRkIGEgY2hlY2sgDQogICBJZiAodGM2LT5yeF9za2IpIGJlZm9yZSBjYWxsaW5nIGFib3Zl
IG1lbnRpb25lZCB0d28gZnVuY3Rpb25zIGZyb20gdGhlIGNhbGxlZSBmdW5jdGlvbi4NCg0KSSBj
b3VsZCBkby4gQnV0IEkgaGF2ZSBubyB3YXkgb2YgdmVyaWZ5aW5nIHRoaXMuIEkgYW0gc3VyZSBp
dCB3aWxsIGZpeCB0aGUgY3Jhc2guIEkgd291bGQgbGlrZSB0byBjb25maXJtDQp3aGV0aGVyIHRy
YWZmaWMgcmVjb3ZlcnMuDQoNCj4gDQo+IFsgMjg2My4xODIxMDVdIGV0aDE6IFJlY2VpdmUgYnVm
ZmVyIG92ZXJmbG93IGVycm9yDQo+IFsgMjg2My4xOTk5MDVdIGV0aDE6IFJlY2VpdmUgYnVmZmVy
IG92ZXJmbG93IGVycm9yDQo+IFsgMjg2Ny42NjkzMTJdIFVuYWJsZSB0byBoYW5kbGUga2VybmVs
IE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBhdA0KPiB2aXJ0dWFsIGFkZHJlc3MgMDAwMDAwMDAw
MDAwMDBiOA0KDQo=


