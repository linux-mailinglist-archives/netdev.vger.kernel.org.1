Return-Path: <netdev+bounces-284017-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKITD57t+Gmi3AIAu9opvQ
	(envelope-from <netdev+bounces-284017-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 21:03:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CD24C2DC9
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 21:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 328D9301F150
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 19:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93CC3ED5C5;
	Mon,  4 May 2026 19:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="go9j+S8t"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E82B3ED101
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.153.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777921433; cv=none; b=uQjB7OWD+2svnrj+VWPnaACv/dxydvTLye0th+ncIykbwIeNCjodg9Ep69Ti341uXBrtMYAGS2yrWfc4vjmLOPJ7DHhVt6jDCrVJpMGA+5XhUoo4WWPNajXnL6t+xIsv/hT3yxd/Ey+YszqKHWcJPIcJZKNmPfsSYfGS6md6LtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777921433; c=relaxed/simple;
	bh=OV/Klj2XQhUSBHJ5pT2yyvcfVvYxXtAu7yPTMlNBfuM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=ElRdmCuIWzORFic4pecqiyuP6jTiV4nZI/tLDlBGkGuU8EaNmgjkFLv16ixnn7E9aroPHfJYYq4RL7BjMIK0bfOMWhIO6Gj069zTShtahXu/YHeYWvXRcRA4YSdcoqjC93CWauG5/5f+qnX32jF5spoe0R8HVksks8+lg0/THtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=go9j+S8t; arc=none smtp.client-ip=170.10.153.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1777921414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OV/Klj2XQhUSBHJ5pT2yyvcfVvYxXtAu7yPTMlNBfuM=;
	b=go9j+S8tMgco5k03yLsYe189cHt86lxZnaCAXu9jf3V3xFUB4Mm2WJSLjwCfSKLn38/MET
	sh+Q5hKJZY/AIFWDCiBL0IvciDOBBEMVP/MNIYltiXwwDLLPGeYl2SdJXojkiQqwByMHUe
	Z1xakx38iGsy47K4EXmOQUtxrbcqOm9vzXyL8CVaJDHscMAkomHp4xLACuSG1f9eCFUBQ1
	6bMw+9iIeLnmvz3JTUbLahND4LPfMlsLpuAqEHiE/o++HV0SU/fVKgIJ+v1892tpbzoRAw
	GAUrFOou4cXQiZ/JU/eBMKPTre5R6/Wa7JC3OfJZQTiaRTwH6TM+upTNV/RjTw==
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011049.outbound.protection.outlook.com [52.101.62.49])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-44-zlktLMaQOBC8CJZ4cyIyPg-1; Mon,
 04 May 2026 12:03:30 -0700
X-MC-Unique: zlktLMaQOBC8CJZ4cyIyPg-1
X-Mimecast-MFC-AGG-ID: zlktLMaQOBC8CJZ4cyIyPg_1777921408
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by SJ2PR02MB9392.namprd02.prod.outlook.com (2603:10b6:a03:4d3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 19:03:23 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 19:03:23 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 4/5] onsemi: ncn260xx: Add driver support for
 NCN26010 and TS2500 MAC-PHY
Thread-Topic: [PATCH net-next 4/5] onsemi: ncn260xx: Add driver support for
 NCN26010 and TS2500 MAC-PHY
Thread-Index: AdzZld+FrVHyslWiQ5KiIZOby61/UQAElaYAAJPFZ9A=
Date: Mon, 4 May 2026 19:03:23 +0000
Message-ID: <CY8PR02MB92499BF412C31A04BADE609183312@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <CY8PR02MB92494A5A16B7AF4EA3A69F2483322@CY8PR02MB9249.namprd02.prod.outlook.com>
 <12245592-fb85-46d9-9f26-5ed37efacbfc@lunn.ch>
In-Reply-To: <12245592-fb85-46d9-9f26-5ed37efacbfc@lunn.ch>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|SJ2PR02MB9392:EE_
x-ms-office365-filtering-correlation-id: c0fda9b4-8dd9-4860-35f8-08deaa0fd0c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003|38070700021
x-microsoft-antispam-message-info: 0dSTU39lTTg3gmSxqfTeUm035B06yhPmbE0w5kYum+sTTNr+O18IAAa21cWsZ6AHgPn1SjAVPBUMPzjix/bkpjrjxMRq2LGRj33xmFhaZnYaauakTfAInYvR2paJcOp5NktzYuR4hIKsl9B5NvSwraszeXyJLBXSsHHn4AMJFxu50BeIaTusgXUcuQoX5kVXK67ZFRPP1OKFpfopG8uAibHXgPoYxTHNzfrRHDjSpiijP+jSV83haGd+qP03YJaBmd3gCzKkmip34518opu3BAId0dflceBzv7e5d2nqACXk0xmiHS/6mao1F01pzW8Op3enCXbO7iInO212iiOP4pa7ujTB32uB9+P4Mkmxn5DzngSe8w5eWnLp3sU4fyR1URqKs+nv8cWWzWTp2LcZ41ZX7IDD82DeoSA2DfxBdRur16XvlKB6m837fe+xEsDD01OGf/NGmp6jlZ+NoyAEc73Xk3BcgHPCfwu5S+Q4YWYV8FoXvl1ut9AepzHqTyrH8VenRJL+jexQ+ny19OgzOvGVJKieKO2rMXiaZKUk/Lwv2/+N05vTO5JwvSQ6X4ju4muiHfc8Uh99QXckCAAzJRtvZTCU6rqv57LZCnO+UCwGCwo3W2kkhABprwtXSBdE6Q0hgxhASJvuxMmczK0lb78/b/gcNviVzcwo3yNd1fElhfugbOTRxMMMDvn4gTHjkKNMSO5zrD000e7aeAsC9xpf+vWM1XdX6Dk1Cdav0yi+S7lTjgsRmkRqqOB5ZWtx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUdiVVRSb2lFSllvb3lSTTNIU3p4ck16YWRBZHZVaXQ0UU1OM2FLTFZHekdm?=
 =?utf-8?B?dUxWajJmcGlZKzMxWmxabVVKcWgwZW13cVJlRm9CTlE3Y1hLWnYrOE1DdzYv?=
 =?utf-8?B?WDBqUXZsN2NRZk9YQlFoZGhER2FuMkQwUjZ4bkQ5K21kZXNNbTViQnF1ZnRQ?=
 =?utf-8?B?cnJuaHdEY1F5aFVNWW5ZUFAvZlk0K2lDcEwzS0U0YnE5REh5S3krRmp0Tzht?=
 =?utf-8?B?OURpdXNnbWZZRTZ3Nk9Uem1KL25DbHhCd01XeGtqV3YrT3VTU0h4NUZNMURF?=
 =?utf-8?B?eHNCT1F1aXFqMHozQkY5NTV2ME1EcUdTZURvbzBSa0pCYlIrSElDYnFtdjB2?=
 =?utf-8?B?L1djVUNZb1pCSHEwOFVZdzg2WWJqbXNFZDFpcW5Vdm9VdkNZRGZmMnhhcFNY?=
 =?utf-8?B?a1RwdkI5bXVrekkrRWxNZ1c4ekJhd1puNG5ydXpObGRDNFI4aTRuVWlVNk1z?=
 =?utf-8?B?aTJMd1AvdlVMeDZBMExaa01BNTlYeVdmNXFGYnBOc3E2YmJ3NisrWG01NzNI?=
 =?utf-8?B?MGQxMVY3NDFKalJkY1BCc2FxdEo5aWZiSERubUI0dnpiWFhQaXErL3dpalJF?=
 =?utf-8?B?R0lGSGJRTkg3NUJxTGRvVjUyYTZPS3I2TFdWaEIzYk1MUjZUMEhuRStHOTdY?=
 =?utf-8?B?VzRMZlhodTlJeDJUaEJQcGQwWTEvYzFHUy8rZW84WnVaTUVmWWZKM3A2anhW?=
 =?utf-8?B?NFUyV2R6RVEvbXZ0S0JMS0xudENoa0FFRkxMRkVUOWM2ZHdmemNLUTdnVDNZ?=
 =?utf-8?B?UXJxcnphd2lJcDJxOGU2SEZiU2NCNjA2RFlpY0xmMG80bjEwNnJlNGJVdnRO?=
 =?utf-8?B?VWxqUUxhakUyWFhaQ0huWDIvWU1lYTJaSENoN2FoUUJ0YUpxR1JpamtUVlpY?=
 =?utf-8?B?emNvQWpSRndHU2c0S2lnSFJRY1ppazhTTWJYcWJ4dVJha2pvajV2Zjh5NTZ1?=
 =?utf-8?B?bFRjd1JzWDdkb2FpQk9vQ2oyaEFpMTcvMXduRWIvN0VrelpxTEtrZGRPVUxL?=
 =?utf-8?B?T3NEcG1EVktsamYxTXNVZHk3Y2FxeHN3K3hlbzlYam55UTNuZTZoUmlBejUx?=
 =?utf-8?B?NFQ4WDhIZFNNNUk0U1Nxdlp1dU85N09QS2M1Ni84QnhHb3VlMGQ4NmpZWEk5?=
 =?utf-8?B?QzBNWkNBeW1DdUlKR0dYbVVyczNzZ0hhQS85c0Z2WGg5YVNvSFFkRlNaMGl5?=
 =?utf-8?B?a2FwQW5KdzF3QXJWcmZaajVjTzg4Wk84WXNtSWhtVkU0VzVDOHc1SkN5WWp1?=
 =?utf-8?B?aWk1MHNvZnJDTFFJWnRyajZ2eUlOS0VvdTNGdzRHWG1ERVlhN2JVa3ZFUlZt?=
 =?utf-8?B?MjFMaVpHZVkwTjgyOXVOM0F4L1ovMVloMjBsY2J0R05id3lGK2FBUkthVDgw?=
 =?utf-8?B?bHZPcEgzMElKTWlOSFNQbDJmTjlFb2VSSUhaVGlqeFpvWi9QQkQ5cE9FODdH?=
 =?utf-8?B?am9BQ3hpL2ZlL1dKSHUrRmVuQ2F0THlkQmhwNk9ySTgyeXJkNmlkR1AxK2Ri?=
 =?utf-8?B?enlrcUk1VFFybFJKSW1ucVJHd1RQb05lY0ZRdGVMbVJqU3d3NDI5Y1F0SWZ6?=
 =?utf-8?B?cm5tRHFJZEc2SDFpNHBDTTFjTmJMSHgwYXNFOHVuZlo5SHFLTVA5bFVsellx?=
 =?utf-8?B?N2h5NnlCOXUxeURsTG1wdUsrZHk4elhHTmVoVml3Z0lmeTJneVU4TkFtSm5q?=
 =?utf-8?B?a25lcnYrNTB2QVluanJEMHE1TEYwSmpNUlhoNEY2YWRVQ2gwVUwxYTJseEw0?=
 =?utf-8?B?WGlTM2I0SlZmMTZVWW1jZEswTDdHQmh6WktGMVJtd3ZvdmNNdmxoNTJBa2Fy?=
 =?utf-8?B?MVdyN3d6a0RrY1pXc3RKTnYwaTE4c2dlV21tenB1SC9Kenk1U0VwejZqZ1pU?=
 =?utf-8?B?VXlSbUFwMG53WEEzWkdtQTNGRkI5eEthR0RuNEowNll6QWNDaVA5aUJYVU1n?=
 =?utf-8?B?NW0ycXlqakw3NEFERlZFME9xeGJXempkbDRKeFJvUWVDL1N0byswU3phSUpI?=
 =?utf-8?B?VGdVOXZadW14YUhUazRsSlloQmxBZkJYUm9vTVdpYVA3V3dTb21kNG8ybjlT?=
 =?utf-8?B?Rko0RCtncGNVNGIyYS81OWRBRUdZNC9NVzh0WjBBK1dKT0hCN1ZORlljYmZo?=
 =?utf-8?B?L0t6V09QUStqOXd4NTM4UlJxZytobmgxbnpTL1N6RUkxbWErUEQ3R0x4VVI4?=
 =?utf-8?B?TWhQcnZqd1A0TVgwbHMzRVV1a0lIWFIvQXFhb1ZERi9OeHJMbHBkM2kvc0dW?=
 =?utf-8?B?ZUNGZXZwSFhIOFhkTFA5K2taeVJYNWxVWjRjY1puMyt6d2c1cnJidDhETXR4?=
 =?utf-8?B?NWpqUmVjRHk1V1RaYTY0VW5qdThvdW9xTGJ0akJjMkc1S21rUUlHUGNha3lN?=
 =?utf-8?Q?94zA1412ofh8yFtY=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pWSjQlmcCeI++459sU5QIrlfax3f2Bh9SI6OCTuFqLceyWZ5ZWT3RXpMTYPXRjtL7Td2ojpzzKu7PCzv41JhSd9DsfKHEoUzsSQexpZciAsweAxRvsG7mgN6avVxdAxtzO3+SM4STF/tDOMm8W0WBJl0pKJREwr3XatGD9NQKRzavFsuXQxwveLMvYA6VoYupNkWaUEm/EU1B2MkO5egqEFunsGRgbYGHQTwhoBajqGLrA6DEkY6wGU7hv+Lf3XIVoAiodPvbypVqLMwrkzciSJhoP/AAle3xLdP+rmYKPXSepN3DywWOvOdwZBwFOraOiNOgczDdARS2r+e8N2OQQ==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0fda9b4-8dd9-4860-35f8-08deaa0fd0c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 19:03:23.6182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o/sfX86ccPDOvr8VtAgIcROmLAT3SN7Axjh48YJS9Bl2jXj006ncSimYK49+ZFi/PM4cujKRvd2J4sHk0GsJ4RGgshvxGcEdZnNVmCbFvWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9392
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AIdXQA1xzv3PamthsCVtC6dwEEg-pTtxd0EmdhprEp8_1777921408
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Rspamd-Queue-Id: A5CD24C2DC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-284017-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[onsemi.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFuZHJldyBMdW5uIDxhbmRy
ZXdAbHVubi5jaD4NCj4gU2VudDogRnJpZGF5LCBNYXkgMSwgMjAyNiAxOjIyIFBNDQo+IFRvOiBT
ZWx2YW1hbmkgUmFqYWdvcGFsIDxTZWx2YW1hbmkuUmFqYWdvcGFsQG9uc2VtaS5jb20+DQo+IENj
OiBQaWVyZ2lvcmdpbyBCZXJ1dG8gPFBpZXIuQmVydXRvQG9uc2VtaS5jb20+OyBhbmRyZXcrbmV0
ZGV2QGx1bm4uY2g7DQo+IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5jb207
IGt1YmFAa2VybmVsLm9yZzsgcGFiZW5pQHJlZGhhdC5jb207DQo+IG5ldGRldkB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRD
SCBuZXQtbmV4dCA0LzVdIG9uc2VtaTogbmNuMjYweHg6IEFkZCBkcml2ZXIgc3VwcG9ydCBmb3Ig
TkNOMjYwMTANCj4gYW5kIFRTMjUwMCBNQUMtUEhZDQo+IA0KPiANCj4gVGhpcyBNZXNzYWdlIElz
IEZyb20gYW4gRXh0ZXJuYWwgU2VuZGVyDQo+IFRoaXMgbWVzc2FnZSBjYW1lIGZyb20gb3V0c2lk
ZSB5b3VyIG9yZ2FuaXphdGlvbi4NCj4gDQo+ID4gK3N0YXRpYyBpbnQgbW1kMm1tcyhpbnQgbW1k
KQ0KPiA+ICt7DQo+ID4gKyBpbnQgcmV0ID0gLUVPUE5PVFNVUFA7DQo+ID4gKw0KPiA+ICsgc3dp
dGNoIChtbWQpIHsNCj4gPiArIGNhc2UgTURJT19NTURfUENTOg0KPiA+ICsgcmV0ID0gT0FfVEM2
X1BIWV9DNDVfUENTX01NUzI7DQo+ID4gKyBicmVhazsNCj4gPiArIGNhc2UgTURJT19NTURfUE1B
UE1EOg0KPiA+ICsgcmV0ID0gT0FfVEM2X1BIWV9DNDVfUE1BX1BNRF9NTVMzOw0KPiA+ICsgYnJl
YWs7DQo+ID4gKyBjYXNlIE1ESU9fTU1EX1ZFTkQyOg0KPiA+ICsgcmV0ID0gT0FfVEM2X1BIWV9D
NDVfVlNfUExDQV9NTVM0Ow0KPiA+ICsgYnJlYWs7DQo+ID4gKyBjYXNlIE1ESU9fTU1EX1ZFTkQx
Og0KPiA+ICsgcmV0ID0gT05NUEhfT0FfVEM2X1ZFTkQxX01NUzEyOw0KPiA+ICsgYnJlYWs7DQo+
ID4gKyBkZWZhdWx0Og0KPiA+ICsgYnJlYWs7DQo+ID4gKyB9DQo+ID4gKyByZXR1cm4gcmV0Ow0K
PiA+ICt9DQo+IA0KPiBTbyB5b3Ugc2VlbSB0byBiZSBjb21wbGlhbnQgd2l0aCB0aGUgc3RhbmRh
cmQuIEkndmUgbm90IHNlZW4gYW55dGhpbmcNCj4gdXNlIE1ESU9fTU1EX1BPV0VSX1VOSVQgc28g
bm90IGhhdmluZyB0aGF0IHNob3VsZCBub3QgYmUgYW4NCj4gaXNzdWUuIE1ESU9fTU1EX0FOIGlz
IHVzZWQgYnkgYSBudW1iZXIgb2YgUEhZcywgYnV0IGkgYXNzdW1lIHlvdXJzDQo+IGRvZXMgbm90
Lg0KPiANCj4gODAyLjMgQzQ1IHNheXMgdGhhdCBpZiBhIHJlZ2lzdGVyIGRvZXMgbm90IGV4aXN0
LCBpdCBzaG91bGQgcmVhZA0KPiAwLiBXaGF0IHdvdWxkIGhhcHBlbiBpZiBhIHJlYWQgd2FzIG1h
ZGUgdG8NCj4gT0FfVEM2X1BIWV9DNDVfQVVUT19ORUdfTU1TNSwgcmF0aGVyIHRoYW4gcmV0dXJu
aW5nIEVPUE5PVFNVUFA/DQo+IA0KPiBUYWJsZSA2IHNheXMgbm90aGluZyBhYm91dCBNTUQgMzAs
IHdoaWNoIHlvdSBtYXAgdG8gMTIuIDEwLTE1IGFyZQ0KPiBkZWZpbmVkIGFzIHZlbmRvciBzcGVj
aWZpYywgc28gdGhhdCBpcyBPLksuDQo+IA0KPiBCdXQgY2FuIHdlIHNpbXBseSB0aGlzLiBBZGQg
c29tZXRoaW5nIGxpa2UNCj4gDQo+IHZvaWQgb2FfdGM2X3NldF92ZW5kMV9tbXMoc3RydWN0IG9h
X3RjNiAqdGM2LCBpbnQgbW1zKQ0KPiB7DQo+IHRjNi0+dmVuZDFfbW1zID0gbW1zOw0KPiB9DQo+
IA0KPiBhbmQgbWFrZSBvYV90YzZfZ2V0X3BoeV9jNDVfbW1zKCkgbG9vayBhdCBpdHMgdmFsdWU/
DQoNClN1cmUuIEkgY2FuIGRvIHRoYXQuIA0KDQpTaW5jZSB3ZSBkb24ndCBzdXBwb3J0IFBDUywg
YW5kIFBPV0VSX1VOSVQsIG1heSBJIHN1Z2dlc3QgYWx0ZXJuYXRpdmUgc29sdXRpb24/DQpXaGF0
IGlmLCBpbnN0ZWFkIG9mIHBhc3NpbmcgbW1zLCB3ZSBwYXNzIGEgZnVuY3Rpb24gcG9pbnRlcj8u
DQoNCkluIG9hX3RjNi5jLCB3ZSB3aWxsIGFkZCBhIGZ1bmN0aW9uLCANCnZvaWQgb2FfdGM2X3Nl
dF9tbWRfbW1zX21hcHBlcihzdHJ1Y3Qgb2FfdGM2ICp0YzYsIGludCAoKm1hcHBlcl9mdW5jdGlv
bikoaW50IGRldm51bSkpDQp7DQogICAgdGM2LT4gbW1kX21tc19tYXBwZXIgPSBtYXBwZXI7DQp9
DQoNCkFuZCBhbGwgdGhlIGNhbGxzIHRvIG9hX3RjNl9nZXRfcGh5X2M0NV9tbXMgaW4gb2FfdGM2
LCBjb3VsZCBiZSByZXBsYWNlZCB3aXRoIHRjNi0+bW1kX21tc19tYXBwZXIoZGVudW0pDQoNClRo
aXMgZ2l2ZXMgZmxleGliaWxpdHkgdG8gdmVuZG9ycyBhcyBtb3N0bHkgbGlrZWx5LCBhbGwgdGhl
IHZlbmRvcnMgbWF5IG5vdCBzaGFyZSB0aGUgc2FtZSBzZXQgb2YgTURJT19NTURfWFhYIHN1cHBv
cnQuDQoNCj4gDQo+IEFuZHJldw0KDQo=


