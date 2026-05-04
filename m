Return-Path: <netdev+bounces-284022-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLBHMrvx+GnJ3QIAu9opvQ
	(envelope-from <netdev+bounces-284022-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 21:21:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 443124C3274
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 21:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7EDF30219A0
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 19:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACD13F9F3B;
	Mon,  4 May 2026 19:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="NU7QV8GG"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA1E3F1649
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 19:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777922293; cv=none; b=ULYHSfNi3qDL8Y5Frvvt84GSiMl4CKhJ+dNDE74/1P1o6MKN1+bVVcH4T4JLsjms8oWlYxYrkq05dPePRnvZbbItA2Y87WaJDoD2unzuxQJ/Q67VEfxq9vN7DshMNlLM24Xaf8A4SlSfVrpCFFfYDeyJ1cIWvjNHqUhqKg6NOPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777922293; c=relaxed/simple;
	bh=6YFHqN0hmLP52gYE+Ec/n+oa5nlsxTNpnGEHuANFSLs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=RcIzImpz3J1DqARjZqig2pMrjb7z2O0N0cRxmb00JqEiKvrKHdDZl4yR+dryPc4Zlgoi4yWektAwWdJzOGvNodKc5Pap9KO2DMMhW2z1cRGrV7xxhiL8hM+TtM3geb9WCeqg2+T7qBvvfLl38b5YchuqFhZzmrIzCsf1jkmNd5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=NU7QV8GG; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1777922286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6YFHqN0hmLP52gYE+Ec/n+oa5nlsxTNpnGEHuANFSLs=;
	b=NU7QV8GGWjK3FFE7kWxjpscNT/3I5ElPpMsiEXc8bZlQjWtuHlup2oHQCD55Cs6buxVRVJ
	h16Bpd9uRrVEqU6fMih8UlibdTNxNY+WgkMBWTYHW16NWPFOaQJR4dQ1DmLDdT6fHPamcC
	3t2PzIVXnKSnuFuZ/TUDljbPf9tQoUDHec/2+skXN2boiXFkwJHclph6nVMawi2gcHWj9x
	tA6x14q6i0egOtpwS9jGnJIgbWueMRDYh7Ddf8aU2Ab9xjuyDc1hmEB9Zln4fT0QsepEhY
	AHc+8fu6gZgnsQCu2lRXbRrKKeg/tv6qz3KSMPMaN0O68dYDwF6KhYLQDpaIvQ==
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010040.outbound.protection.outlook.com [52.101.56.40])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-29-IW3g3aCeNxSdhqAGR6Ikww-1; Mon,
 04 May 2026 12:18:03 -0700
X-MC-Unique: IW3g3aCeNxSdhqAGR6Ikww-1
X-Mimecast-MFC-AGG-ID: IW3g3aCeNxSdhqAGR6Ikww_1777922280
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by SA1PR02MB11291.namprd02.prod.outlook.com (2603:10b6:806:49e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 19:17:58 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 19:17:58 +0000
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
Thread-Index: AdzZld+FrVHyslWiQ5KiIZOby61/UQAElaYAAJPFZ9AAAMRGAAAAD6yQ
Date: Mon, 4 May 2026 19:17:58 +0000
Message-ID: <CY8PR02MB9249082A82E8E2C503D6773683312@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <CY8PR02MB92494A5A16B7AF4EA3A69F2483322@CY8PR02MB9249.namprd02.prod.outlook.com>
 <12245592-fb85-46d9-9f26-5ed37efacbfc@lunn.ch>
 <CY8PR02MB92499BF412C31A04BADE609183312@CY8PR02MB9249.namprd02.prod.outlook.com>
 <5f07822d-6ea9-4beb-a222-58a94e4801d6@lunn.ch>
In-Reply-To: <5f07822d-6ea9-4beb-a222-58a94e4801d6@lunn.ch>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|SA1PR02MB11291:EE_
x-ms-office365-filtering-correlation-id: 8f9e63b4-d2e1-467d-c20f-08deaa11da4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003|38070700021
x-microsoft-antispam-message-info: vQmQdzgbTdy1rSA8XWxCQY7c7CMl5MNuWRkZwxOQEZlP3yXAFIF0VZLKKJrcIVsG60/pvUXZDFHTQ1NHLmx72faxjUcP1o5FpE61c87cfgRZp58peKdLKm1oQQc0ijqTru87+yu+/6td4CHPYpSCJET17DCyQTOZnb6d8OjpSO+EuUoIe3nLKkwv3FRsv0V2K9EWzC2Mf0yZB8aPjz/zHxB07tyoLCU85WNh+9WM7MnVtjy96kqfUjrbvggl3FYkmmayyIZfqv+BieGxeP22JTVFjekb6byChBy9bVfweS1W2wr89g9LbbPINkeMJMafT1TmX9ZG7Fp4HY3Jx6BR3czp7p6dWt2jJCg6Zl2cZIdwdjIU327k+5QGdkYxZkVBCkLaq7ImkJASnUGoEqiMQhiRAZ4Tvlf8SYtTMQCdhKZyWnTYnWzfYdH5IIVPk8X1BVZMMviRxprc6SbRtBl1GRAZHymmFH2/BaAyikbAYyF/2L/dg1J2hPNCsMSV+Y/ggFIWJQvDdcwlWn1xtzy26rMe3vtCMPxjARy5gY80dpP3bCsrin387V0qSZxCdi7MLMO1cNejqbcecZiy9Lj+oM+Qcxmzw4vs2+5nVUJI7Fn0GDmLiIp8LNCeLp1duxgQGX+M5rYq3rUtzuZ90u7hGnd30Oim6joNu5J4EnszrJ5FGj0mATay3wMrVYi3FS9hE42j+2qKv4O2MrHjoG9BEF902v6Zs0sT0B5qzsQEhYHRDGdY/H3HX2P6v1MkvdVM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anMreGUwazg1eTNCcFhYYWRTdzBKYzkwU3IzcWt0S2VjM1BzK0NjS01DeGZr?=
 =?utf-8?B?OFZNaHM2N1lpU2hRdkhqai9QYW13TzFTNmZHQ01jR2FXT1RnT1NjcENVUkti?=
 =?utf-8?B?eG54T0xKd3pzZnVBRFowNTl6bzZnbWlGbTViRThpaFpjcGEzaGd5ckRYUkpG?=
 =?utf-8?B?V21OMksxZ1JnTHRpclIrMzNCOFExZXRFSVZQQzJ0RUptR2pRZUdQRThjWEJW?=
 =?utf-8?B?STJWN2lDeERTZ3ZiZ2NYQkU4UVRjMGw1SlI2SjV6U0VpSytQQTM4ZUU0WUtX?=
 =?utf-8?B?bnVLanRSUkJSNkErd1pXTlBQLzhMYXNHR21Bb3h1U3NVMk9NUUtRYXpHeUNJ?=
 =?utf-8?B?blllTkxVNENERVQxMmF0T0NSZ3FGb1JpMFZnak5rQUdBQ0svbzY3N0hjcXlF?=
 =?utf-8?B?U3pIQzhGSWNmSWdxWUZ2QWFaSkhNL0VnQXoxMnJPaU5YWkFkdUh3SGVIMTJI?=
 =?utf-8?B?RXl1QytzYzM3aTJBelV0MGkzbGdhalYrUEFvSkNrR0VITUJTMVZKMGRKdEJZ?=
 =?utf-8?B?emx3c1BkM3dDVmwxbWtyNk9QREFzR2RRQnhxakdwNW5QbEZpeFllSUt3MEdQ?=
 =?utf-8?B?YVR1dVBsSjEvanpHZlNneWN6ZEpCc2RmOEV1WmYwNEh4M0poSytIL2tSaFVW?=
 =?utf-8?B?NDNYdWtTS09zUEJmekNWY0RkMFJIZ3lEcXhwNmdNSnVxbzlyZWlMZFVvU3pz?=
 =?utf-8?B?NEdmTkx0c2hDUXJaSGxKZ0N4R2dlS2R4ckQyZGZQVW84V0xWUVM2dk5zSDkz?=
 =?utf-8?B?d3Y2eFZOZEhFTi9xMlhZaEQwcDl4MjZqWENvZk4zUXVGQlQ3Zk1sam9kTVRN?=
 =?utf-8?B?Tm45QW9nTHhGM1dHbnhmT1RMVUsveVZmUGFIZlZyYlZHUVZ3U2prS0t1a1Bq?=
 =?utf-8?B?alBzQS9rRFlVSVFveWRiRWJFRk9yaWk4WkE1bGduWXV4V0NxbGgxVW9wU0lv?=
 =?utf-8?B?Q0htaTc4TWpCb1ZWdGlhelpYWE9qdDYwSkZoSWZIYm9kYUNZYTE0eW1RcXhl?=
 =?utf-8?B?cHBobm9tQ3NxWDNhR1REVWpJVTAwazU2WVJoMnpRNXU0ZnZkQlN3eXd6VXFC?=
 =?utf-8?B?Y1lUNWRWcjV6UTQ0ZHVDSkxYaURKUkJqYk5nRXhnQmFOUEIyOG5OeUI3VFNG?=
 =?utf-8?B?T0RQeDNqenBOQ3hwNUZwNHFjdWxpTHArcDFaRjRneGJDVVRlMTdGMlAvdytK?=
 =?utf-8?B?cmo4VDIxRnU4M1B5c1YwYVRqYkxlaWNQY1dpOEtSOW9RTS9qY3YrRVhoWTJF?=
 =?utf-8?B?N1REQXlRYytkR2pMbDVhM3F2MlVkeXJYejZCMWZ2ZlhBUzJ1L3cwbU1CMjBn?=
 =?utf-8?B?SkU5UTVkNmhhTmJGNUcwZFJ1WHZ6Z0IzRXQzZ0dUeXBDeWltcTRZcnBtbS9R?=
 =?utf-8?B?RWxuUWZURGNBUmJuUU5abFFITHlqS2wxWUVsRUU5ekxGVGFBcSthWC9DdGxr?=
 =?utf-8?B?emFxSVRrQ3l1NDQxazlaR1hMalNoSmc5OFRXbSs1MzVkRkwxSXJtMk5zZldz?=
 =?utf-8?B?WlFsK21tM3hzNmc3b0RkWDl0SnZpNitOMU4yS1JmakhsK0M4SmQ4VlIxcWlp?=
 =?utf-8?B?cjNLWGwzWVZUbE1vbnMrUlZid2p3REY1VHFOWExQOHFLeWQ0d1BuK1BDZmRl?=
 =?utf-8?B?U0xXMyttUWZhSTFrc054TEVKY0hpTmp6ZWVlWHgzMXpQOU1SOUxvTXA5MDgv?=
 =?utf-8?B?NG1UOUplOWRLUnN0SUJIR3J5YThDR0gzVGs3eG1ocm5vcWdROEs0QlJEQmFx?=
 =?utf-8?B?VmhzdW4vckQ5MUtKcTBKQS9xb09iL1I2SGVaL0JGVGRMSjE0aEc3QWZZcjhu?=
 =?utf-8?B?VzRJSzE4R0ZUbkRtRmxPbnFHMWNkZEZSK2dlUDI5czlwYll6R3lYZU9FYzU3?=
 =?utf-8?B?M3UzMzJObzgyL2IvczZ6aVViVGRoVERpNXQyYm8yY3EvTkY0RWVTTzI2NEoz?=
 =?utf-8?B?WlRIZWRoMU9PTHArZUNQNVV1OEFOTEhaS0gzY1hsUXJueHJTa3dHczVFMVc1?=
 =?utf-8?B?RkMwT3pEem5pTjJ6QWNIVW00WEdRSGV3c2syYitzd3B0ZmZRYmtNWGpMOTBP?=
 =?utf-8?B?NEZQelM5MkpSSmpHakRYSXR2VDJNS1hVb0pSa3RiZ09rb09sK2g4QkdlSnIv?=
 =?utf-8?B?Yml0cU80RmI5K1ppVjdKZ1Z2WjhvYTA2eFdLSTBqWEp5eldpYVBjVzNtWjEw?=
 =?utf-8?B?SlVEWm9kQnVkSUN2V0d3a2NMUldET1N2RXA0RjcwREpiT3VsUEo4c1huUG55?=
 =?utf-8?B?anZVTmFVLzBVc1RJc2Eya0ZiSUxsc3p4UU1RaEZqVm5Mb2EwTjVqeFhHd3lv?=
 =?utf-8?B?ZFVFNm5nUHRUZVhqWnF1bWdwcWVRdHBadzJUUndJYnlkVHN4U29BQXBrZVNT?=
 =?utf-8?Q?gh93HBLQx7ou9rFo=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Ru5ftrRI8RKb0CGNRC0J9TAbei+2McYPIdBHYUzpRTo2vvfMNcmapxOWwI9wZdURIUXtA5bLzCs9DdHkEm+Uv5cjeEO0t2WAkmgBsLFy1aKhFGNVmChrUBFVLUxoHtkD5ABPijqxcpryE0kkmj4bvPRLe/baJ3WVNKoL8evt4d+gNsjLl8muLs4go3usYtIdSr82bRZq7z6tBtTvJltxvG6rdX/eKQuggBRIie3n2JoHTUEK14I5kHKBsCEzBcBohVg+zvPh7WyUuHD5cjxC1y/jRS/xLk6Y7HRD9Fp6NDfAL81qJ52n5qfi1UiH3wUBxrv/e1bsX44xxNIHpi/MHA==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f9e63b4-d2e1-467d-c20f-08deaa11da4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 19:17:58.6502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qvFZNrYAiC341p+sETSBFNuCMr36k0CMSjJeOlED/fMR95SW33qxtXlLdlSO3utXYrU4DS2modQDEgJus7fyMTEFyp8PBI51M7aBH9qZVNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB11291
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UUy65i6kWgfIM4wFkSwTAgoTh1cd2iZ34pdi03m0vBU_1777922280
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Rspamd-Queue-Id: 443124C3274
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-284022-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[onsemi.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,CY8PR02MB9249.namprd02.prod.outlook.com:mid,lunn.ch:email,onsemi.com:dkim,onsemi.com:email]

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmV3IEx1bm4gPGFu
ZHJld0BsdW5uLmNoPg0KPiBTZW50OiBNb25kYXksIE1heSA0LCAyMDI2IDEyOjE1IFBNDQo+IFRv
OiBTZWx2YW1hbmkgUmFqYWdvcGFsIDxTZWx2YW1hbmkuUmFqYWdvcGFsQG9uc2VtaS5jb20+DQo+
IENjOiBQaWVyZ2lvcmdpbyBCZXJ1dG8gPFBpZXIuQmVydXRvQG9uc2VtaS5jb20+OyBhbmRyZXcr
bmV0ZGV2QGx1bm4uY2g7DQo+IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5j
b207IGt1YmFAa2VybmVsLm9yZzsgcGFiZW5pQHJlZGhhdC5jb207DQo+IG5ldGRldkB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCBuZXQtbmV4dCA0LzVdIG9uc2VtaTogbmNuMjYweHg6IEFkZCBkcml2ZXIgc3VwcG9ydCBm
b3IgTkNOMjYwMTANCj4gYW5kIFRTMjUwMCBNQUMtUEhZDQo+IA0KPiANCj4gVGhpcyBNZXNzYWdl
IElzIEZyb20gYW4gRXh0ZXJuYWwgU2VuZGVyDQo+IFRoaXMgbWVzc2FnZSBjYW1lIGZyb20gb3V0
c2lkZSB5b3VyIG9yZ2FuaXphdGlvbi4NCj4gDQo+ID4gPiBTbyB5b3Ugc2VlbSB0byBiZSBjb21w
bGlhbnQgd2l0aCB0aGUgc3RhbmRhcmQuIEkndmUgbm90IHNlZW4gYW55dGhpbmcNCj4gPiA+IHVz
ZSBNRElPX01NRF9QT1dFUl9VTklUIHNvIG5vdCBoYXZpbmcgdGhhdCBzaG91bGQgbm90IGJlIGFu
DQo+ID4gPiBpc3N1ZS4gTURJT19NTURfQU4gaXMgdXNlZCBieSBhIG51bWJlciBvZiBQSFlzLCBi
dXQgaSBhc3N1bWUgeW91cnMNCj4gPiA+IGRvZXMgbm90Lg0KPiA+ID4NCj4gPiA+IDgwMi4zIEM0
NSBzYXlzIHRoYXQgaWYgYSByZWdpc3RlciBkb2VzIG5vdCBleGlzdCwgaXQgc2hvdWxkIHJlYWQN
Cj4gPiA+IDAuIFdoYXQgd291bGQgaGFwcGVuIGlmIGEgcmVhZCB3YXMgbWFkZSB0bw0KPiA+ID4g
T0FfVEM2X1BIWV9DNDVfQVVUT19ORUdfTU1TNSwgcmF0aGVyIHRoYW4gcmV0dXJuaW5nIEVPUE5P
VFNVUFA/DQo+ID4gPg0KPiA+ID4gVGFibGUgNiBzYXlzIG5vdGhpbmcgYWJvdXQgTU1EIDMwLCB3
aGljaCB5b3UgbWFwIHRvIDEyLiAxMC0xNSBhcmUNCj4gPiA+IGRlZmluZWQgYXMgdmVuZG9yIHNw
ZWNpZmljLCBzbyB0aGF0IGlzIE8uSy4NCj4gPiA+DQo+ID4gPiBCdXQgY2FuIHdlIHNpbXBseSB0
aGlzLiBBZGQgc29tZXRoaW5nIGxpa2UNCj4gPiA+DQo+ID4gPiB2b2lkIG9hX3RjNl9zZXRfdmVu
ZDFfbW1zKHN0cnVjdCBvYV90YzYgKnRjNiwgaW50IG1tcykNCj4gPiA+IHsNCj4gPiA+IHRjNi0+
dmVuZDFfbW1zID0gbW1zOw0KPiA+ID4gfQ0KPiA+ID4NCj4gPiA+IGFuZCBtYWtlIG9hX3RjNl9n
ZXRfcGh5X2M0NV9tbXMoKSBsb29rIGF0IGl0cyB2YWx1ZT8NCj4gPg0KPiA+IFN1cmUuIEkgY2Fu
IGRvIHRoYXQuDQo+ID4NCj4gPiBTaW5jZSB3ZSBkb24ndCBzdXBwb3J0IFBDUywgYW5kIFBPV0VS
X1VOSVQsIG1heSBJIHN1Z2dlc3QgYWx0ZXJuYXRpdmUgc29sdXRpb24/DQo+IA0KPiBJIHdvdWxk
IHByZWZlciB0byByZWx5IG9uIDgwMi4zIGRlZmluZWQgQzQ1IGJlaGF2aW91ci4gQSByZWFkIHRv
IGENCj4gcmVnaXN0ZXIgd2hpY2ggZG9lcyBub3QgZXhpc3RzIGdpdmVzIDAuIFRoYXQgaXMgd2hh
dCBQSFlzIGFuZCBwaHlsaWINCj4gZXhwZWN0Lg0KPiANCj4gWW91IGZhaWxlZCB0byBhbnN3ZXIg
bXkgcXVlc3Rpb24gYWJvdXQgdGhpcy4gV2hhdCBoYXBwZW5zIHdpdGggeW91cg0KPiBkZXZpY2Ug
aWYgeW91IGFjY2VzcyBDNDUgcmVnaXN0ZXJzIHdoaWNoIGRvbid0IGV4aXN0Pw0KDQpTb3JyeS4g
V2FpdGluZyBmb3IgYW4gYW5zd2VyIGZyb20gaGFyZHdhcmUgZGVzaWduZXIuDQoNCj4gDQo+ID4g
VGhpcyBnaXZlcyBmbGV4aWJpbGl0eSB0byB2ZW5kb3JzIGFzIG1vc3RseSBsaWtlbHksIGFsbCB0
aGUgdmVuZG9ycw0KPiA+IG1heSBub3Qgc2hhcmUgdGhlIHNhbWUgc2V0IG9mIE1ESU9fTU1EX1hY
WCBzdXBwb3J0Lg0KPiANCj4gV2VsbCwgYWxsIHZlbmRvcnMgc2hvdWxkIHN1cHBvcnQgd2hhdCBp
cyBkZWZpbmVkIGluIHRoZSBzdGFuZGFyZC4gSXQNCj4gaXMgb25seSBNRElPX01NRF9WRU5EMSB3
aGljaCBpcyBsZWZ0IHVuZGVmaW5lZCwgYW5kIGRpZmZlcmVudCB2ZW5kb3JzDQo+IGNvdWxkIHB1
dCB0aGF0IGF0IGRpZmZlcmVudCBNTVMgaW4gdGhlIDEwLTE1IHJhbmdlLCBidXQgaSB0aGluayB0
aGUNCj4gcmVzdCBpcyB3ZWxsIGRlZmluZWQuDQo+IA0KPiBBbmRyZXcNCg0K


