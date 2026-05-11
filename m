Return-Path: <netdev+bounces-286824-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNqoDsk9AmrmpAEAu9opvQ
	(envelope-from <netdev+bounces-286824-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 22:36:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 945D6515EF6
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 22:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67A033040AA5
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA373932DE;
	Mon, 11 May 2026 20:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="WSur2FQT"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDA5392C3D
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 20:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.153.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778531530; cv=none; b=LS5W4kni0W5iP5JjvbeBn6vHQZbeMgkYlViFzbGO7jZrP9v4s17Wr/pzR7rlBXEUSMSyvh4a/KY6/qwMADXkY4KQS+Up7MIabQiV3lmMUSXxbBTaaX5ygdVB2iCFs+W1SOHyd3AdHE/gy2GsY47ZpLHwAZ35aFb2MJPUKx0Ij9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778531530; c=relaxed/simple;
	bh=eLo4hdXMYFWXWLPQCF9b7V5SIcFAXTqLOSzATTUl1+U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=nLJLwx28MI9eIC8+24/ZF9qvZlhjUeAFpFHGTn5tNSs8pcEJIhYvaLHjyKOxYzc7eWJHpeMNTlBaiLdHuyg3Ow+QVnB1JIWQh4QzzT3BtgLqB2cNcfcyK1oc4vPPbZyCu2iTPXkChsMkKpMO7PXCp3Q0zwOM9jGiDHmSsmqv+oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=WSur2FQT; arc=none smtp.client-ip=170.10.153.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1778531528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eLo4hdXMYFWXWLPQCF9b7V5SIcFAXTqLOSzATTUl1+U=;
	b=WSur2FQTT7z4c6uFVoRhzMChc6MdIyqZppJNK/Ip3RE0zU5UbqbM6dDq61F7Hgel6BEum6
	Kpg49PjPjkYe/k9a2F4ftaQ3IjiEOv2xV5FKgr8lf99JM9WffkdGa17zkh5/naSUqhT7lN
	So+4FxdugbLffwF9Es2EluidsrSv6XtSsFpFzZWGVPuYkwQKGeOD3+sm+T4t0Z1RafEDeI
	SgjZa6Wz4qIDtx/upowP/+krPT88aLFIdpkw3/KMKvQGfgcEfd6m8Ur6tW0De8tmOcDgmN
	eZX6wF6BXtrRTr2KWhfufc0/Mc2fekBaH9BIwyekpTaa1Q9gfpVG3FmB2/4BLQ==
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013026.outbound.protection.outlook.com
 [40.93.196.26]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-66-IUG6iavbPcWHmp6j9c-itw-1; Mon, 11 May 2026 13:32:06 -0700
X-MC-Unique: IUG6iavbPcWHmp6j9c-itw-1
X-Mimecast-MFC-AGG-ID: IUG6iavbPcWHmp6j9c-itw_1778531524
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by IA1PR02MB9613.namprd02.prod.outlook.com (2603:10b6:208:3f7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 20:31:57 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 20:31:57 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2 8/9] onsemi: s2500: Add driver support for
 TS2500 MAC-PHY
Thread-Topic: [PATCH net-next v2 8/9] onsemi: s2500: Add driver support for
 TS2500 MAC-PHY
Thread-Index: AdzhcbEAp6Owv179R1mImunkqBeYBAAEaaIAAABsE9A=
Date: Mon, 11 May 2026 20:31:57 +0000
Message-ID: <CY8PR02MB92490D40FD197D10654867C583382@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <CY8PR02MB924948C0BB8611D5A2618D3283382@CY8PR02MB9249.namprd02.prod.outlook.com>
 <657612fb-747f-4506-8a7f-e9536d7c4c2b@lunn.ch>
In-Reply-To: <657612fb-747f-4506-8a7f-e9536d7c4c2b@lunn.ch>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|IA1PR02MB9613:EE_
x-ms-office365-filtering-correlation-id: c7eaa8c4-9257-4e3e-b93a-08deaf9c590b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003|11063799003|38070700021
x-microsoft-antispam-message-info: ES8CnM6p/CW8k47yyjd23X8W4Ia4GZ5r+lRl9MprEfOw3fRp0wO3aQZ+5Y1xQ9+9HcjIgiu5HtIOVm6PAox2L9hF/tbdCI78eN3ZdTMOfUCbJAnND7PfCxu2XZImh6suTL0Jd+hgYzUDDd4dzCX9n+rl/6c7VYIr96VuS1+mc5Fq4Th6fe0AHvU5ge8wVq3XYUiNvqnDVJ7HLwpfSTm4mx3Npqi8WsepZv1oEk0XIO78I1FwKGfG9D8hiVGRn91Ss9tIlsYB46kSt1AR20oxngrbaa8qmakDw+NPREgyJbY0l2GPXOVb+h8IQRl/435daSvjf923xEJ8Ao2Aa14DII2x73QoxpCNBDM0Lm/fXAVDLrTpwVcy8wX6mzUcXGvgH9udSIHGWly2ERsaAzXG6nmYFOgw2Q5GLu2+rOICyKrFqeJz122BtIDgW68nTCA+5pDT8m9fMtf8taF+zfMA9kQMkrqLLujcHnM923R7cWo0ntt2OVOBXjqtmvLEPkH6HpXJO2FeMJ44WpW4dM69g2JvWIUM828W+/erca2hLQxTTcgPnolhZYdxtWmgLM4oFdDZ96l9TsoDimmbicyV3iLE+ffyGiO/8vWu3/SZ50nV0/pAk28ZkjlhQqCTERREtDWi52kNeu1W/ElOAiGglaz6+HAuB5ihPJmJXTJ2TVyLtoezMdYKyCBYsLetWt6MCpBqPZ2OqdnHZ7ZyTTJacaMb0AU9ENclAtfIT8HPR8LCITRhRJuPRAvVyTqOa6jJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003)(11063799003)(38070700021);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmFNVlJScW9uRTlxbnZTMzRmVGVDSHBVTE5nR1NJcnZpWlViWDZwNUZVQmUw?=
 =?utf-8?B?aE1RODM0Y2hUcC9YWXVGUWtuNHlOcUhwbmNPMHJhY0RlSzZud0V4MWxUNWRL?=
 =?utf-8?B?SUczMFRPUU1mS2Z5ZTNJVG5xdG1vdW5HY0tDbGFjVGVndktaUS9wTm9rK0ht?=
 =?utf-8?B?MXYweDNoWC9NMGJGclgwSUhSZmIwTmR4THNsRGsyQzZjYzFuWmM4RUFzdU02?=
 =?utf-8?B?K0prV1o5ZGlRMHA1U3dFNlU5QTFhNGRVRmdyMVBETWJPUFZOa0l1ZzMrVUxI?=
 =?utf-8?B?NURPKzdQV2t6VzNzUUN2bU95RStPVytqR3ZEU2ozVThVR25Wb0ZTemlvY2xn?=
 =?utf-8?B?SE5FRUdvOVdkZUdDdjA1bm9LQ3RpZDEyZ296bUJudWdnQ05jSzdxNFBTdzhm?=
 =?utf-8?B?eTRrelNxSXRBR2plK3V6VzAvbTBEMVdYOUlrblh0SzNoZkk3ODVKbTM3ZWJ1?=
 =?utf-8?B?c3lNb1pxWlRmTHdQOWd6Q0F4ZjVxYlB4WVdsWlAzaTJPMHp5Q0JqM1F6bVV1?=
 =?utf-8?B?bHBBbVRWRDlNWmFYUHBNTksxOFJ4ME5xc2xNKzkrNVJQUjF1WVNxMDRuL3FL?=
 =?utf-8?B?VlI5TWJCdE5wNzN0UmdGZjd2cEtlK3lYbytnc3kyYkRtckxXTE81aWk5ZW11?=
 =?utf-8?B?dGpldmtWekZzSWVheG15c3Y3enErb3dtMjlvaytucTdSQ1RCQWV2SytlLzZs?=
 =?utf-8?B?K3FJNDdoV2J4UUwvZWhkVmNtbm12MjkvSVRTd2JtT1ExN1NBeGRmc1M1Ynk5?=
 =?utf-8?B?WFJMQ2dsTzFjS3I1SGVRUkliN2JzSUx6b2E2d0JDRnJNVkRrNWVaaksyTVRr?=
 =?utf-8?B?ejlWWm1FVUhyQnByY3J0cHFSMmlVUXNqOWFyR1NndWx2OWJjMFUzOE5TN3R6?=
 =?utf-8?B?Uk1YNTNJV0NTNXBWalpsdE0rU251QlZ6aEVDQjVBZHlzbHJqMmlnMURpdUtq?=
 =?utf-8?B?VUtoTE1tQThQK1d2S0lkMzdYOThsS2RqVE0ybTFwNjZXbEtCa1pVV0V1NW5w?=
 =?utf-8?B?SnorMEMzV3Y1U1lVdkdaY3drMnpkSlZyaFl2bmsyMUV4NVk1aGhaTlBnRXdq?=
 =?utf-8?B?TlExMmlVdTcwMnZ4KzhJQ2sxUVMxR0xxTkdJS2N1aWN3WGVjWTFHNjBac0Iy?=
 =?utf-8?B?TmFrRTlVNG13T3FVTmUxcXVoNEl2NWZJVzJQUVZ6eW91WnlXY1NWMnpHb2FN?=
 =?utf-8?B?Y2ljQ0N0dnlXQlU0RTNHOGMzQWxrOHR5QUtlYzZDdGVmeHlwRzVGeDFuc0oy?=
 =?utf-8?B?OElZQ2RZd3RQTzZ4eUtoNU5ZbnhxSXV3ZGNnaHNmNlMrQm1vSk9hS2gvcWNY?=
 =?utf-8?B?eE1mQUtLREtRWktQZmFUaGE2SmpDM0ZxQTg1ODdzZllaRWF3WEtzOURSWEVx?=
 =?utf-8?B?Yi8wNjNqZVhZSlBWRHh3U2d6ckJzMk9DMElNTmtrOXFHa3FoNHRIalhqbG5t?=
 =?utf-8?B?dTVPaFBMSEFZNjQyMXE1c1J3YkxjdDFCSjlPWWdSSVdRNVh5SDY3YTkzZldE?=
 =?utf-8?B?b2N6anlUMHBEcXNhT3pJTVdmdE9hOGd5NW5oYnF1cFBibFFTb2JNUjlSZWU1?=
 =?utf-8?B?RFprYjhJMVQ5SGVvay8weXpiSi9RN1FBS3NETGlaVUFPUWhQdjJIZVQycTVP?=
 =?utf-8?B?MnJ5RmFFTEhvQnRKeTNpeXJJeHpBSkpQWFlsWFQxOEZpa0Q2OHpCZ2l3TFZR?=
 =?utf-8?B?NVNTdnhPSVVKV0ZRUzl4aFprOUtzZGYxZXhkWWJFWnVYdDZSTnpwMTdDaUx5?=
 =?utf-8?B?Z3VUbkQyUjBEeXhpeVlwQ1ZIVVh1VzVFNHYzYkVCaUl6VFh4RktPT1RyWlJB?=
 =?utf-8?B?cFRQN0JSUHdzZW5jVUE3SStCeTJGcUhqQjl6QXFkd1Byd09INi94cVhtRFZ1?=
 =?utf-8?B?N3dPREVZazB5ajFINng5R2ZydTA3SlpxMnd6QUhOUVh6NWFtR3FGUVZ4YWV2?=
 =?utf-8?B?b1F6R1UxK1cxMjJvcXVKdldDNmtEOU0ycnp3MDlqZWtnRlVhckk1cHZJS0pn?=
 =?utf-8?B?cGtBQURabUNtOW9OV1J0dDhSempjTnVNTmdwWkJaZDN3RDVGakcyR1Y4RzlN?=
 =?utf-8?B?NHBUZTZWaUYveWRmSytyOVpzU2tFQUQ2N3BQdWRpdEl3dDZBZ0ZvZm9PaDFI?=
 =?utf-8?B?ZG1uSXQwL2VpUU9lUEk5akk1S2xpekJLTkNWMHhYT1AzK1FGRnYwSjV2WGZu?=
 =?utf-8?B?SjhhTHJPYWJkN09sWXlNdUdyS1c5ZktFbzBTSk9KVUIreEJTUGlNTEVENllq?=
 =?utf-8?B?bWxMcG0vUjNiNzBjQ0V1SlJ6TjZVVnB3RFZXdm41U2QrdFY0ZTQ4YThnOXMv?=
 =?utf-8?B?T1hnMlFxMzh0TkZqUEJBRjNyVll3a1dyZWJDaW5WRExmYldIQVBPUU00eURx?=
 =?utf-8?Q?ETRBPP97GauUowsQ=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UCJpwOzBkNKjInfb/vYfGsK+2VzlCXG0X3cntbM1vF0Smh3sqVR/NgFODvA8nAy42DSUsgQ7MgtoyE6FYXXz744bYS8VCmfQrcUoTaeGCdKcIoTJt5HFE+rhmeOa0NYPQ9waSTU2s1alS2dt7b2osxszUP6znUuzg5MpbimzcUbhJ64hnHZ3yNLpLVOSmU8cdPE9hZhGJgnyOnixoREbJlOsjVdrs54+tEUlLicTmGWzsFUytqcLmRqJwCLhvQzDjGHHp06SqnZTfsU6Ds6Voeo7MvY9OBHRVZ56uaxYO8q+/v9xjVDs2hBM8rYl5mbgdjbcE3/CYz8U3+sn/RKZrA==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7eaa8c4-9257-4e3e-b93a-08deaf9c590b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 20:31:57.6863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jkBfAAJ82AWJVVpet3sTP2EVVyr+IivMZWUapZJUCmf1vIoPXs7xIOp0dFFZyKegKERt+KJdzHxaPMjEnK9ccv5mbnHkyWGD11FanTevQ+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9613
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: d7gNvNB6gaii71Tm2uvOnjvMSblP_MX174aL5LbCqHE_1778531524
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Rspamd-Queue-Id: 945D6515EF6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286824-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[onsemi.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,onsemi.com:dkim,CY8PR02MB9249.namprd02.prod.outlook.com:mid]
X-Rspamd-Action: no action

PiBUaGlzIE1lc3NhZ2UgSXMgRnJvbSBhbiBFeHRlcm5hbCBTZW5kZXINCj4gVGhpcyBtZXNzYWdl
IGNhbWUgZnJvbSBvdXRzaWRlIHlvdXIgb3JnYW5pemF0aW9uLg0KPiANCj4gPiArc3RhdGljIHUz
MiBwaHlfYWRkcl9saXN0W1MyNTAwX05VTV9SRUdTXSA9IHsNCj4gPiArICgweDQgPDwgMTYpIHwg
MHg4MDAwLA0KPiANCj4gPiArICgweEMgPDwgMTYpIHwgMHgxMCwNCj4gDQo+IElzIDQgT0FfVEM2
X1BIWV9DNDVfVlNfUExDQV9NTVM0Pw0KPiANCj4gMHhDIGlzIHlvdXIgdmVuZG9yIDE/DQoNClll
cy4gVkVORDEgaXMgMTIgKDB4QykuIEkgd2lsbCB1c2UgbGFiZWwgaW5zdGVhZCBvZiBudW1iZXJz
DQoNCj4gDQo+IFRoZXNlIHNob3VsZCBwcm9iYWJseSBiZSBtb3ZlZCBzb21ld2hlcmUgcHVibGlj
Og0KDQoNCkluIHYxIHBhdGNoLCBJIGhhZCBtb3ZlZCB0byBpbmNsdWRlL2xpbnV4L29hX3RjNi5o
LCBJIHNob3VsZCBoYXZlIGtlcHQgdGhhdCB3YXkuIFdpbGwgZG8NCg0KPiANCj4gI2RlZmluZSBP
QV9UQzZfUEhZX0M0NV9QQ1NfTU1TMiAyIC8qIE1NRCAzICovDQo+ICNkZWZpbmUgT0FfVEM2X1BI
WV9DNDVfUE1BX1BNRF9NTVMzIDMgLyogTU1EIDEgKi8NCj4gI2RlZmluZSBPQV9UQzZfUEhZX0M0
NV9WU19QTENBX01NUzQgNCAvKiBNTUQgMzEgKi8NCj4gI2RlZmluZSBPQV9UQzZfUEhZX0M0NV9B
VVRPX05FR19NTVM1IDUgLyogTU1EIDcgKi8NCj4gI2RlZmluZSBPQV9UQzZfUEhZX0M0NV9QT1dF
Ul9VTklUX01NUzYgNiAvKiBNTUQgMTMgKi8NCj4gDQo+IGFuZCB0aGluayBhYm91dCBob3cgeW91
IGNhbiByZXByZXNlbnQgMTIgdXNpbmcgYSAjZGVmaW5lLg0KPiANCj4gQW5kcmV3DQoNCg==


