Return-Path: <netdev+bounces-295735-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2ppCNvaSImqeaQEAu9opvQ
	(envelope-from <netdev+bounces-295735-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 11:12:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B911646BC3
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 11:12:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=GxYuIVge;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295735-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295735-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1043D3126DFC
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 09:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA6F4BC02F;
	Fri,  5 Jun 2026 09:02:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013032.outbound.protection.outlook.com [40.107.201.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2FA4BCAA7;
	Fri,  5 Jun 2026 09:02:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780650152; cv=fail; b=qQstqRbLL/85TBTOIi835nk4NF06w2/EHTtusVOByO5AHaQXok+gL2NcL2uwPMjwpSfVEDwKheDLqIjqHL0lpWoFdA+JMlgaWfA4rY1yb5IzpqUMig6IGMd/fnxgALvgWBlsgei5rP14qxI6KCAz9GVgA5E4oJ9bP8EYRXbf9Mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780650152; c=relaxed/simple;
	bh=tKQjCeIhtLJRtoPDz8moZaQtgXkyAJvL5MtSbil41tk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jfr5Rl7xMYU3MOEpmrfuzC2V26aJsXtCge8heKsLxyx0m0e+a4FTLT20PJRQ1xzMNk376A2xD6k/lWAlCxEAPZqOnsNsXPmJY5GnLrDO0DlH5LncGLQIbo1NY7vVaiEsqXC3A8gkWkhYMHpw7U3+yJxMJNO0bhGPfFzcjY8b+ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=GxYuIVge; arc=fail smtp.client-ip=40.107.201.32
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPIbsEvuVxfBgsc0TLAwY8VU9PAA+LGcrgxjT08FhmGA9OV9qsrCnG+Zbo2IiMUZmeWjCP6t9BzrSbmBK+Rxx9Y3PAyoEVtX5krrhUYQqY2Kx19Y4hyd5VAQhT9V/DtwDGJ9ZLNgPXoWVG/ZNDnOFElwE01zuEPAn4iUD78aQDlbqmujULrWcNrt/1M5ixlE5tCAgkYMgDQs27Xnn3Uvub/FcD+JQDvF/vasQXYIlMBIjOyROyM0XMRksme48PghU8JL0h2E3GjfMdrQhGjZg5zpidSttv1hEgUJ8sMpBn9vVr63qnh8ks9qe/7UFpdwtoHCkeE9Qc1wQ1SBliyruw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKQjCeIhtLJRtoPDz8moZaQtgXkyAJvL5MtSbil41tk=;
 b=Bh4sE5BAjPbp/O75vXPZAgnrh5kV4+wUiLWFoQvv0YvyrCBWPWkhqX95weGefRN7C0QFVLLKnO3SH0aeoo7bg1mXO2ICW2Oichsx1icScPbjrtb+VoJN9RBqSNac/cNMTH8G9u0lHZ/Kriw0KKF/Di8iRdU19z8wmixYhks7AhNBXXgXKYjFQIIE/dl3tKOk7AcvK6BcYkvJTO/ZNyHVNe7TFrC84D9KkeH4+A4BCV5MeJn3lNnGJS05JXvDwZC5LL0KJSGKyAveQm7rKcCiAKk+qulnNAtgJMZmkL0oVF/SXp/4qh21kSJUjKucjuuNDixZ81cEg+hZu4fmkwKrCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKQjCeIhtLJRtoPDz8moZaQtgXkyAJvL5MtSbil41tk=;
 b=GxYuIVge8jWWGEOhCosWC6rmsQxvuPlc3k3YraGNA05acyu3s9rog/raqAk0byt42d4Z+nLyicK/t+zwTeaJzQfNXWrKNSoQiZlPq5sJ4aB11oCE4WMDfe8bShc710bqwrmwmzK5vPt6WWKRIf3EsnzJcD1JaWLBVDOPzm/Gn9u+JCszyPTpIVNbCENdn1uDwXMl0PRSdnbSoM5fLjZxXnSQUBPUnnx3Z+Lvx8eloIGpFk0g05G15BdZt8bPnhJ4evKadOpBcl9tHorkt8FSrKJ5PNAUzHBWoDBVUaIEg6E/Xg9GVhgWF09jYOO0l3WNw/GlDb8Gd++KsLyna+f7aQ==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by DS4PR03MB8472.namprd03.prod.outlook.com (2603:10b6:8:323::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 09:02:27 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 09:02:27 +0000
From: "Nazle Asmade, Muhammad Nazim Amirul"
	<muhammad.nazim.amirul.nazle.asmade@altera.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "rmk+kernel@armlinux.org.uk"
	<rmk+kernel@armlinux.org.uk>, "maxime.chevallier@bootlin.com"
	<maxime.chevallier@bootlin.com>, "Jose.Abreu@synopsys.com"
	<Jose.Abreu@synopsys.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] net: stmmac: L3/L4 filter bug fixes
Thread-Topic: [PATCH v2 0/3] net: stmmac: L3/L4 filter bug fixes
Thread-Index: AQHc8/zfx7625djlK0GbSLCa01hryrYufa4AgAEuaIA=
Date: Fri, 5 Jun 2026 09:02:26 +0000
Message-ID: <d17a7041-50f6-4bfd-8453-c6e0429c2111@altera.com>
References:
 <20260604083350.1701-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260604083350.1701-2-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260604080006.5a01ce03@kernel.org>
In-Reply-To: <20260604080006.5a01ce03@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6964:EE_|DS4PR03MB8472:EE_
x-ms-office365-filtering-correlation-id: b2c8d77d-5f06-452a-244e-08dec2e12a95
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|22082099003|18002099003|38070700021|55112099003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info:
 GXf+umWV9S9dnfk++fhQNDEAVRrL5rKhvgF8cHI8yl0hUuM7UDkI891VZVfbjCb5Cf32WgLoQZTvQqjXJS+tILbMSREOGTltsJEy8CYo/Evu/j/6S6eVle6/aL9u4hxpjjht+beiCcL8ir7PgMX2sEUuFywb6edblcTg6XCnyg5l6atCrvDTVrNkrRtCmGQ3brvlB35zVEjQ6SzlrGqPzFuwBjH//IawGhYMDz82d1BYrDrNqNsxZrNC2terOkIenyJEG5RVg2qd87EoWc+VS1ciTRhuT/jSBa1RIcQU1aqY+yT2iNlELdlHJ41p7ov/CuvihifSiLyl8r0uq1ih5xty5J+WbrdnUPK1E/0xd4ESBEoqPxRv456GI91c9nPr3V0U6PaXKFwMBHiGpipup05xzzy4hPP7eFsQeIl07NJxpN5Q4b+AnuTTQXxHq0XpIUG97ZqBWs2pPa5IlM5yulLcfg/rZIhsFVgBvn8XEeD0i1Uj4kYNWiEwBDSTDSCIKH0nvlMd8UPgtsyfqI5IFVmfKi4twVzM4sRyWQkY5Jh7QvtjmUNuMRYW6YzebYObMy8OKbutl0+6rNAPT7FV1WnVHoXvSUz4Ohs3UcECzZkA7UhrVA88gq+l/YJVm+VDoHyxx8Md7pPS4bVmGk1ANkktl6duVMyI/NWYw8Dk+WahGg4TGmDb1DJznU/WKyWgwlAQ7VEdop4RY94xMREwf+e9btZux9vVNsgXzytn2BlhFSJFUpKSuM2mc291/YuT
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(38070700021)(55112099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N0hmdUV1dSt5ekpLdWJxSXBDL1dERTBWeDVHTTVlMk92ekE4MEFYNVM2M2h6?=
 =?utf-8?B?SzZRNStDbjZQdXB4MVlldE9rcUdDMVpnbkxadS9rc1lQTS9xeWpVb3JqSkNv?=
 =?utf-8?B?bUlBVEVnRDdpU0Z1T2xiVTh1T2h5ME1JaVdrdlY2NG9KK1lJUmEvTU5ZZXNt?=
 =?utf-8?B?VG5mTlBhT0FUN2VydllnK3ljKzN5MGZXMUVuMjBCb1YxZ08yTVNDR2tKNUUx?=
 =?utf-8?B?VFc0Yi9IcDMvVDdVYTZFejlFYlEzcENmMFo2a1BvR0xIZVRYSDJwOG1oZ1JV?=
 =?utf-8?B?VlNGTTU1Z2llQUVEQ0dPak54NUsrMUFGRzg4S05KOVhnM1paS3cvSjRHVklm?=
 =?utf-8?B?SDF6eUdHSWMrdnBhODRJNmRhRmF2OEo5NTVzcGhFYkJBMUxiTXhjWjE2ZGpi?=
 =?utf-8?B?WHZDMm9mcU1nUHl2WERwZVkxQjhZVkJVREoyYkl4am5remhTcVFxWHM4bUlk?=
 =?utf-8?B?RmtOVzV6emVMWnV6U0VJWjZudWNrcWtXWmlRR09sb3J6UVo2RUFBdkk2aHdF?=
 =?utf-8?B?MHlzbmN2WlRDSTBwK2VnMUs1bDArQ3p3blZzWVBtdXBQR2NZaDZSNVdPYnFG?=
 =?utf-8?B?ZnZ4RmtBOTVTTjZYVDhIbC9LR3ZIcE5jamRmSWJSUVpzUFp0UUFPbDNUZzlW?=
 =?utf-8?B?V25Kb3lKdlZqUUFiWWl5cFVzUXdJWTRpSGI3Wmt5bmJjc2JzUndJTjZJZ280?=
 =?utf-8?B?TnBXb0xhekhXUDZVblc4dTdoWVJsWlJWM0pST3VZUVdPeWlCY0dNUCtqTGxN?=
 =?utf-8?B?b0xaZ0FTQVJJVFZNNFN4cXcyT2hsTnFQcnp0RkpmSEQvaGlSRW1lcGJaTXJs?=
 =?utf-8?B?VVBrRVlvMkhhc3djNmphbGxoRnBHemErTkdMU24vZ2ZxcXM1QVh3WVY1ajlq?=
 =?utf-8?B?RC8vVnV1NzR6R2ZETitJak9EcFRUMFRzejM1RTBGbjRnYjcrdTBOek5FS2Ro?=
 =?utf-8?B?eUpzWEJYOTA5L2ROOEZYdnRuZkdNa3JZVlUwU016NW1QVzU4YTRJVDJxV2NS?=
 =?utf-8?B?S09IRVl6UC95b0FFY0NHMUQrQnRhOVVwS21KaXRxQkczYk1HTnBidlNGNk1i?=
 =?utf-8?B?TlNSczRIODdpaEFtN0M1d2VIQm5qUHhNb2VadXhYYXZMTmVDM0I3Kzc2WWRs?=
 =?utf-8?B?OFBqVnFnTXFMWmpiTjNYRUsyejdsWmhGRm91NmNyMWlKVXNzME94SlNLVWQx?=
 =?utf-8?B?Y1o2QitTYU5NTEhrdDFrUDBMaWJWSDgxWGhuWHR4c2pUQWQyMGwyeUoxdmNC?=
 =?utf-8?B?a0JCOUpaWnQxUURjWW1EamNubGt3Yi9wdUZQZjJEYmczbEZLWHkwczF2SWV0?=
 =?utf-8?B?L1dpVE9xeXFrRmdLVFhjVUlMazFtMW9ybm5Fc0VYSnZNa3owNlVMemVDTEUv?=
 =?utf-8?B?VmZzNkVDVTh5UXpvbmJoaE5jNFNxOXBhbmFYeXNTeVltZUZoTXoyZ2NuZkVy?=
 =?utf-8?B?a3dia1NPdzdOcXZORFJkMVI4ZnNaNUR0eDcxYStWRDRQZnZzMGM1YmJiTlc5?=
 =?utf-8?B?K2xsemNmdUsxUHE1M1RlVXFzZjZOZG1aODV2UzlLV25xOWpUVlpLM1dSY0pY?=
 =?utf-8?B?YjExR2RpcFgzWGI5Z0NhcnF1Sk8rUjI4UklzMjgrd3I3V25hM25sQ3FjNDJV?=
 =?utf-8?B?bENZWGFYdGMwajcydzZtdS9RdG0yV3RVSUhJblJZSHdjMk1KZkdIYWViWW93?=
 =?utf-8?B?SmIwVU5OR2tzZzBkVWRiam1vZ1FQYWg2cGM5TTBid1JzU2U2Y3d5YithWlIy?=
 =?utf-8?B?UXJuWUEzMjZvdU5XUVNFQmFwZ0g4OC9Lc3pNeVV4REJqMkxuQnc1TUEvTzFr?=
 =?utf-8?B?R0t5WEwwcWs4MnFLOU1KVUhNN0VNQXFoRVFzaVFJbDdDcGdsb0FwcG9iMjBj?=
 =?utf-8?B?cjFUeTBHc2ZzM3ozNFJSZlJjSzBRTEEzeXVYZ1JvcTVqaVM3NHMwazBIN2Zk?=
 =?utf-8?B?Sk1zTjNvMGpSYXNWWWRtSlVJZU5WVHNUbFJjYUJrNzdqamZHbnpDV0MraVNG?=
 =?utf-8?B?aG1UTi9XWGdQQXB4QUdySTlDYTJOSWcwUnFjamp0TkR2U1ZYdEFySnBBdEZp?=
 =?utf-8?B?QjlqeVBIbXJMQ25ZbUVtYmFoVFdFYmtqRWxINjVxYmxYRC9seGdFSGJjTUFY?=
 =?utf-8?B?ZWxkUGVoNHhEYnU0RFhxcmx0ZzhvSE5HTm90RGFqa3U1VFhXTnQ5dmVkaUQ3?=
 =?utf-8?B?MnQzNzJHdnhlMFgwZERvUEhYem8yZm1IYkVhamxwczRWWEpsSmQ2dm5vN3Yw?=
 =?utf-8?B?OHhoT0xmV0FvM2c4OEJVYzdiRkRxVVBYM1lnRjhjSEFpeU9FNStlMGErSDBK?=
 =?utf-8?B?eDBHM21CMzl1U2lQVEdIZ0VsS3k4bDgzOE9kL3NqMkt6YytHS3c5UUkrTkZa?=
 =?utf-8?Q?BXPBHiTCr3SRkhnj2yVZEd4JFlshH3M+Mia9X3oGwVIVA?=
x-ms-exchange-antispam-messagedata-1: 2V1BYBUIBJN7AQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2E2A32F3A50174FA5DD5700566EDC04@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c8d77d-5f06-452a-244e-08dec2e12a95
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 09:02:26.9937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tmbj7GuvHVhCMMMwsNV7wUlO7c5FjGHDeU2FEFfomzGQrGig+5Tvp3g3SLDv3/4yfyGTI+r7Ilv7zvtTLK2n8ACHXskKSMkbdWTep7py/7l0Ck8U61CEeNZmOzcro3jB1zLjJBu8SwTr8UsoyMwU9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR03MB8472
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295735-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:Jose.Abreu@synopsys.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[altera.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,altera.com:mid,altera.com:dkim,altera.com:from_mime,altera.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B911646BC3

T24gNC82LzIwMjYgMTE6MDAgcG0sIEpha3ViIEtpY2luc2tpIHdyb3RlOg0KPiBPbiBUaHUsICA0
IEp1biAyMDI2IDAxOjMzOjQ3IC0wNzAwDQo+IG11aGFtbWFkLm5hemltLmFtaXJ1bC5uYXpsZS5h
c21hZGVAYWx0ZXJhLmNvbSB3cm90ZToNCj4+IENoYW5nZXMgaW4gdjI6DQo+PiAtIFNwbGl0IHBh
dGNoIDQvNCAoZXRodG9vbCBzdGF0cykgb3V0IHRvIG5ldC1uZXh0IHBlciBBbmRyZXcgTHVubidz
IHJldmlldw0KPiANCj4gTm93IHRoaXMgcG9zdGluZyBoYXMgMiBjb3ZlciBsZXR0ZXJzLCBwYXRj
aHdvcmsgbGF0Y2hlZCBvbnRvIGZpcnN0IG9uZQ0KPiB3aGljaCBkZXNjcmliZXMgNCBwYXRjaGVz
LCBhbmQgaXQncyBnb2luZyB0byB3YWl0IGZvciBwYXRjaCA0IGJlZm9yZQ0KPiBraWNraW5nIG9m
ZiB0aGUgQ0kuIFBsZWFzZSB3YWl0IGEgZGF5IGFuZCByZXBvc3QgYWdhaW4gd2l0aCB0aGlzIGZp
eGVkDQo+IDovDQpyZXBvc3RlZCA6KQ0K

