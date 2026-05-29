Return-Path: <netdev+bounces-293289-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNsJJdIlGmqJ1wgAu9opvQ
	(envelope-from <netdev+bounces-293289-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 01:48:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1080E609F32
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 01:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F6D030523FA
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 23:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806B4339861;
	Fri, 29 May 2026 23:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="POTvC6hg"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D34314A8E
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 23:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.153.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780098509; cv=none; b=Tp6X47zrk9T+ddbqrVeG41DM52aWe1A4lmdjxlET+a5PiZ2hvupgLzV56uZPQv8Xlq1gIZxB5hvN7OkFK/E17wOs85uKQjpDbezM5coXb9qlX7WN3/OQM1UfA9zaYcTZiKe739IG+MNHeV3SQFonqt42fnS1fwOJlmgpe+TQpcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780098509; c=relaxed/simple;
	bh=WHA+RCqKsva5ilk5U6SXdDMPrbs43P4S7RmiEzqi7HM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=UuctMJ3MmA8Bzuc0QxYXlKFmCGIEOIi+ZSG15ByEd72GUB6mn0ODBZ5hCz1BJTaaATmuxVzvBe5C+4SBT/C9DdHQPiuE2V5kQxafDVt+rCciM3kHmc4LxEIKo/wnTXeGsVNvRzI7NHpHZ0kjYvDW+dKFlKXZ5h4FduBkIwHskoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=POTvC6hg; arc=none smtp.client-ip=170.10.153.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1780098507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WHA+RCqKsva5ilk5U6SXdDMPrbs43P4S7RmiEzqi7HM=;
	b=POTvC6hgnBxtDOe3eLPYHul8G/1BAEAMfBSBmZT1D4qf7OYH8IZ1b4l0gf4eeh82jqc63p
	X+zMT+BkafTuSgyUvKFAw5fFqBeROyOXPgBXTvgxmtONr6DqwayR21cRZiW+XpoHObtha8
	QE1tlpevA7eWH+N32bzQO6Rvt8toOvsTxH4LSkz1S3cHLd5o/zLeKQTJ3jcb6Gdnspvve+
	tscGN/SW4RVIXSiWUBfA4Fu/aU8PlcmyIX3HPjp1XpELZyuPO3/uZO4oI7L41U/Qi5v8sB
	Icu1xr2hazfmyaMw8PmDd5fr6FFCEp0gIGrZrcBrF9vP5RkdSy9mE3RvdD2hZA==
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010064.outbound.protection.outlook.com
 [40.93.198.64]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-44-byfwG-3bO-yiuxGxEQnmhw-1; Fri, 29 May 2026 16:48:23 -0700
X-MC-Unique: byfwG-3bO-yiuxGxEQnmhw-1
X-Mimecast-MFC-AGG-ID: byfwG-3bO-yiuxGxEQnmhw_1780098501
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by EAYPR02MB11601.namprd02.prod.outlook.com (2603:10b6:303:2d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Fri, 29 May
 2026 23:48:19 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 23:48:19 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"parthiban.veerasooran@microchip.com" <parthiban.veerasooran@microchip.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v3 05/14] net: ethernet: oa_tc6: Move OA TC6 MMS
 definitions to header file
Thread-Topic: [PATCH net-next v3 05/14] net: ethernet: oa_tc6: Move OA TC6 MMS
 definitions to header file
Thread-Index: AdzvmMOODRZu/gHzR9WWpu6hXTz+IwAITOqAAAK0LSA=
Date: Fri, 29 May 2026 23:48:19 +0000
Message-ID: <CY8PR02MB92495560BB953C0CC0411E0B83162@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <CY8PR02MB9249C29E61887561D50B243D83162@CY8PR02MB9249.namprd02.prod.outlook.com>
 <d7619281-7957-4110-bcb2-e6bc9e77b451@lunn.ch>
In-Reply-To: <d7619281-7957-4110-bcb2-e6bc9e77b451@lunn.ch>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|EAYPR02MB11601:EE_
x-ms-office365-filtering-correlation-id: 70b13fa9-3600-4dbb-1e47-08debddcc2ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|4143699003|5023799004|18002099003|22082099003|11063799006|56012099006|38070700021
x-microsoft-antispam-message-info: udTb6LfPNA0eZbeCBrPqQOzz+IlKL/j7nVXaN7bqmzKL17xTRMx3QNo50OJ4BJRxAj7QbeRK+nH3fJygYyTdZOym6kXyYe5n4f1WmSurDd0WWNJ9SLQ6yF+DNfLC8D6J0tI5Q0beI3XZRJrhUZL5bPmbF+q6SapmH4HGmVf4kMNZ4sgOm4mNHKPe4qomup7y64juhoE1CZOLcvm3XCDs1fw7HuVjMiD5LubOcg/Q3nYdMI2gRbMNLq3uWjrI92mYp02J/AiCHq9G5PJd9oXbxk9wJVCO5bqtQrQxqoDL78Li2b7DMO7CWz0dEmEmwDnl6r87xRPbx8hHSx8nWNr3dGjRqi1mGCC2MuJCzutJkbSvPCI6tzWAtnWb1u/uTCCrMSzADzOnHTJCHYT5TE7gsCiEO4c0koFKLjY+JF6QYjOPQoueARvy5QTMRnHhCD+4vksQvqAsG3mZ01ELkh5R6juIJN0Y3o1TqHutTCiEVRYJvFzNPJBltWPzsPMHTuWAFuwH/Sy8jbd2sG0HkurTBXphd+OGEPbOGyHvAO+uCMzny6iTOjxbcG8QRIPdoKDnj20z8WrXGiWDNIzSyysHKf2PObv6lS6ytUPnqcjvo8lsU9n/e5PNYAjzOK38NPDISSCTQzvQ7alOq18IPHxC2+yrzwshvl5Yu2onvu9qZr0rFO8HzawnPla4jv62csTZJMgjDzRB1geMd0t9o9VTHRBeGsgzp25Aa6C9NPLl6aCv8vEUPctmCILojapQCl9Q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(4143699003)(5023799004)(18002099003)(22082099003)(11063799006)(56012099006)(38070700021);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUxKTXpoS0lYaTNaUkp2SDVOcE5XM2Zib2lBYmJsc05wQmdUdmdqWU5SUFJa?=
 =?utf-8?B?eklXei8vUHhucUM3TG8wZXZnNjQwaWMyZC80eURoYlorRXRBVEZvVW1zcG9B?=
 =?utf-8?B?UjhTeHhaSFNZYjhPVngvYnYzOUt5K0xoM0lHOVJFbUhWRWNINkxpb2JrYjBX?=
 =?utf-8?B?U1FrTTRGY3dzemZhRVVkN25sdFcwYXYxVmxjRGdmUGx1dFJaSlVUUGlBLy8w?=
 =?utf-8?B?YStLVDFrUzRuNlFqT1ZYaXg4YmhONXNBKzJTTlp5emIrdTVKTEoxeHBXZEpS?=
 =?utf-8?B?K0NyME9oUHJMS0l1a3dNRjVPdmMzOEpTRzh4a1BKL3RhMlVsVEFiV013cjNa?=
 =?utf-8?B?cFJoMGlqQWhpMUVVUytCMmU5U3R2K3U0S29GcXEra0lzTDMwU2tNcUwvaWVM?=
 =?utf-8?B?M1ViMm1FZHR4QzVCSENaOW9hbXFmRTc0ZURmTklGK0RZRkdIeFFQRHFLQ2c0?=
 =?utf-8?B?ZFVvWkRyMDRYYzcxQmNNMEd3V2h3SEhMVEJ5UzJpcjh3RVNLcnR0MVN2QWVZ?=
 =?utf-8?B?NVVKQ2VsTERuU09aMTNKMnJEZ2E0TVoxWHRNVU5RYWZZcmpWckJmWVJmTmFk?=
 =?utf-8?B?UUlHR2FhZzV0QWg4UGxRamF6THNLV0pSekpQWjJOSFRvOEtza0V5eVdyc3hs?=
 =?utf-8?B?bXMwdE1zZk1uSjlLdXEyYWtYR3JsYThxY0oyNVRETWgxUFJyOXY2R0JkdE1E?=
 =?utf-8?B?VHFBUlRRbmNCeUsyemQ1WWs1NVdvRlpDOEZPYVk4d29nVEk2RnY1d3gxUUJz?=
 =?utf-8?B?TnFJRHBENndsa2xJRENlQTF4ckR5VjU4NHlhY0ZLMmlxUGVzTEI4eCtrS0pC?=
 =?utf-8?B?RGVJSFRyQ0hWbWQwSHROOWhLRVBUUEh5YTBCYWFhODNBWjR1bExHK2ExVG93?=
 =?utf-8?B?ampTM3FFTjI4ZzdqNFNNM2piZVNudmJRQWVuV05hUnVmYW44bzZmQmhHSE1i?=
 =?utf-8?B?VDFiQTFkV1h5ZkNFUGl3RExhbVpEdWp0ckk3dHRTeFhqRkUyTm5ud0RyMXJy?=
 =?utf-8?B?enRHUHY4UmxydHV6R3NBQ1VMQUEyWjhqYnpSSkgxVEJ6MzI5R1JTdEs2cWVy?=
 =?utf-8?B?OHRZdlFCckdjcHNIRjI3R2RyOTFBVzN1WkFyL1RwMUNOYkdvWXVkMVdxM3ky?=
 =?utf-8?B?a0Fta1FxQzhLTzllTER3QkhhZzBKYnYrTi9EbjNPVnBMZHgvdVljTEowT0Fs?=
 =?utf-8?B?a283V1VjUkg0K3NMdUNoQ1pZTUVOdll6eDdBTWdIbXVocTBvaHRDL3JIVVJL?=
 =?utf-8?B?U1dPalpaQjEySmlWVTFvay9QVzJIL3FlaUZvcEpFSVh1aGZ0RjlGMlVTOUtW?=
 =?utf-8?B?anZ6UmNpODRaRENjVzJ4MVorZ2FZb3NRNHBSZmZmN2J0cjJ5Q0h5a1haWmNU?=
 =?utf-8?B?YldhbTFFZWoxUDhvTEdJd24xaHFNbXB4MzBRMzhwMEZjRWJxVlBha1lIVjJ6?=
 =?utf-8?B?bGxXRFNVTURUci9KMTJkQWNoU1V4NU5oSjJVMlZUb1BvYUxscmFqL3Z0UGpM?=
 =?utf-8?B?ZzV2c0wyV0k5cVdHTi9Fa2d4QThaWmdYQzZzMTF4a0FKeFRwWTRmNUpDTXVs?=
 =?utf-8?B?U0tzQjZIZm82ZmphZ0JZcUI0dHRRQVJ2N3AwWU1odzFqdFRQdG44a3pORmUv?=
 =?utf-8?B?NTZqNUpkZ1BUaVN1d3BVY0FJSnNVSkpsRUxMOVpMRjc5a3JJZFlFeGQyYTZw?=
 =?utf-8?B?dEtudWF4WDB2QkExcDhWN3dTdnpKRW5STi9PbXErQWFscE5hTktldjVtUTNu?=
 =?utf-8?B?a1FCZnpldlJXSzRhN2FYQ2V5a1JBSm1VZ0NUeXNkN0pKQmpWeTJLZmY1ZVBa?=
 =?utf-8?B?d0RlSXpvOWVtWDJrMU85RjBiS2tRVWhGQ3IyMGI4ZzdLM1Vibm1ZWU9GL0ky?=
 =?utf-8?B?M0t6UUM5d3lYZkFVM2ZZRzBld20xVDlvQW9Bdis1RmJPN01hQkF3dXl1T3Ur?=
 =?utf-8?B?THRjK3NMMEM2NzZ2a3ZBMURaMjJ5b2FZeE0zUzlEaCsva1RDRkxtUWcyUTh4?=
 =?utf-8?B?L2U0NFRFbWZXaCtHNjUyd1UwTzRDYW5LU0Y3Y0lhVkF2bkU1a0ZIeTE0U0RO?=
 =?utf-8?B?bTIrT04yNGlUOFlYT3pQaEV2Zm9EZTEvRVRHbmZDS3JiLzNCOE1LWU5Uc1cx?=
 =?utf-8?B?b3VDbk5NZGl1cmtSY3lKVTZZWXV3RFdsZ1dwclByVDZsL1g2M0JKMjBJTzQr?=
 =?utf-8?B?NE9KTG9tL3FnN1VRb2ZVbzMwcDYvb2NIT1BEcWVpWkhhcFBaY0gvRGVUN3RS?=
 =?utf-8?B?SCt1Z1Vta2F2WWxLWU1iMHhiQzQxZTkwZjNIb0xJZDdKbUV1VVRSU09DdE90?=
 =?utf-8?B?SEY2aHhQd0sxWlMyMFFlZk0vQUxQcHZoRnZ4cjJJYmtvOFQzdGdvYnRuc0Jx?=
 =?utf-8?Q?aCjkZoYqJehHNcHE=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EHSC5YmeYtFvh3eC3BUoXkjBtCeWOO6Bkfk6O/v0+QRQ+xsV7iQwzvw1y0Zc6M27iZGWuTRIuHkKBtauM+aPyEpODOtWMzlallyBYrHp0+n9yQN4htvMb1Kkuk8P8ulXueTMJyrgel/t2CjOrdpnkFeVeoCeRCUz9+yn1Z6wtTpvPCTdNKmf/VH8Un3cTiuWY23v0k0mF38S99o6bMT6eEVjUmk+zM4GcWLXun95p6XouJTyCJn1Gq/ViXbK2GyO648xLia3MQ84N/L2srn2XLa1YQHW+ACOOWsVO0jEm5LM2dPNqi6iLX78sZ++PyrfzQnvRtwnil+H+xQouVHnuA==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b13fa9-3600-4dbb-1e47-08debddcc2ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 23:48:19.1236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9xZrdy9KhfQbaiZ/kqxDBSmtCkInEIMZR8DLSMMs7M53FjgWb2S0d/LJgsvnnjQMCY4RqNqfjrYFGQoANXtFfTVCLY8e3gwtgXfuOuBoJVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR02MB11601
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vim-3fg6o_spQtYVkZzLDICLdTUQ2JelNQw766S4ygM_1780098501
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
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
	TAGGED_FROM(0.00)[bounces-293289-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1080E609F32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXQtbmV4dCB2MyAwNS8xNF0gbmV0OiBldGhlcm5l
dDogb2FfdGM2OiBNb3ZlIE9BIFRDNiBNTVMNCj4gZGVmaW5pdGlvbnMgdG8gaGVhZGVyIGZpbGUN
Cj4gDQo+IA0KPiBUaGlzIE1lc3NhZ2UgSXMgRnJvbSBhbiBFeHRlcm5hbCBTZW5kZXINCj4gVGhp
cyBtZXNzYWdlIGNhbWUgZnJvbSBvdXRzaWRlIHlvdXIgb3JnYW5pemF0aW9uLg0KPiANCj4gT24g
RnJpLCBNYXkgMjksIDIwMjYgYXQgMDY6Mzk6NTJQTSArMDAwMCwgU2VsdmFtYW5pIFJhamFnb3Bh
bCB3cm90ZToNCj4gPiBUbyBwcmVwYXJlIGZvciBvdGhlciBmaWxlcyB0byBzaGFyZSB0aGUgY29u
c3RhbnQgZGVmaW5pdGlvbnMgZm9yDQo+ID4gY2xhdXNlIDQ1IHJlZ2lzdGVycyBtZW1vcnkgbWFw
IHNlbGVjdG9ycywgbW92aW5nIHRvIGhlYWRlciBmaWxlLg0KPiA+IFRoZSB2YWx1ZXMgYXJlIGZy
b20gdGFibGUgNiBpbiBPUEVOIEFsbGlhbmNlIHNwZWNpZmljYXRpb24uDQo+IA0KPiBQbGVhc2Ug
ZG9uJ3QgbW92ZSB0aGVtIGluIG9uZSBwYXRjaCwgYW5kIHRoZW4gbW92ZSB0aGVtIGFnYWluIGlu
IHRoZQ0KPiBuZXh0Lg0KDQpBbmRyZXcsDQoNCkkgdGhvdWdodCBpdCB3b3VsZCBiZSBjbGVhcmVy
LiANCg0KNC8xNCBwYXRjaCB3b3VsZCBqdXN0IG1vdmUgdGhlIGNvbnRlbnRzIGFzIGl0IGlzLCB3
aXRob3V0IGFueSBjaGFuZ2UgdG8gb2FfdGM2X3N0ZF9kZWYuaCBmaXJzdC4NClRoZW4gNS8xNSB3
b3VsZCBtb3ZlIE1NUyBkZWZpbml0aW9uIHRvIGFub3RoZXIgaGVhZGVyIGZpbGUuDQoNCkFzIG9w
cG9zZWQsIGEgbWV0aG9kIHdoZXJlIHBhcnQgb2YgZGVmaW5pdGlvbnMgKE1NUykgd291bGQgbW92
ZSB0byBvYV90YzYuaCBhbmQgcmVzdCB3b3VsZCANCmdvIHRvIG9hX3RjNl9zdGRfZGVmLmggaW4g
YSBzaW5nbGUgcGF0Y2guIA0KDQpJIHVuZGVyc3RhbmQgd2hhdCB5b3UgYXJlIHNheWluZy4gSSBj
YW4gbW92ZSB0aGUgI2RlZmluZXMgdG8gdHdvIGRpZmZlcmVudCBmaWxlcyBpbiBhIHNpbmdsZSBw
YXRjaC4NCg0KPiANCj4gQW5kcmV3DQoNCg==


