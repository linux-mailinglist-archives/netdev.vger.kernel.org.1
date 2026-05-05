Return-Path: <netdev+bounces-284530-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKF7CPkp+mn/KQMAu9opvQ
	(envelope-from <netdev+bounces-284530-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 19:33:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0714D2195
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 19:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46E50305A2B8
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 17:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E864A33E5;
	Tue,  5 May 2026 17:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="etd0ja5h"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADCF4A2E36
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 17:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.153.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002390; cv=none; b=tTavsRZxbOmZZft640qouSb9KKo7PQ8SLIkPPMaP4FxG1M1DYOz2JIGEY/inLhDS9wT3W1/8tMPwMGqUf+qCLUiI7m9nneB1rovvwaxBPQr4VfT4aD6e2BTEYhcjIu4cnEG3H1F1jMpqyMF8yME8kMwixrFYJiam4cHrfB/sx1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002390; c=relaxed/simple;
	bh=LHBhAosBJIVYfea41T5PXm3X7VuN8qMgOYMT5AReAGc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=TSNNubXTa9Hh2EwLnYMxd8VRyV+od1n74btC4VqcC79yXjEoI9n8X8mHcd8LbA5ytAV/t0U7ZNnO2FoV7raROMrK9sigcXJjzKldjIzBR25Q8/oU5yRKwbdZUe0NATkfZljpj3eyMbaglDVf9sFuHYusqpnnq03gqnTQ5aIYJdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=etd0ja5h; arc=none smtp.client-ip=170.10.153.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1778002388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LHBhAosBJIVYfea41T5PXm3X7VuN8qMgOYMT5AReAGc=;
	b=etd0ja5hVq0jC/XwEaJRIYU5RWNminw5zcRlQSM6u4Ej3NKuRtNlLq6iQ4FLXuOJnHreB0
	ZiwGy9gmVQG/2iUWrYtZeH/ofU0shhAOxL2h3cWBM76w5aRhf0saeTMttdW8zZoJ/WDLNW
	i/N5tjSI9i00HePAWEax2w/6DnH7cQgdzC/BT2oqD2AeuLNPdROvCymdwrIN21mcudXfSc
	91MqbAYRRYCvSzzY7nns1p51VmxtEZ8qIMO6DDwBD3iImonAOA8p/n2MrRMYCI7ULPnCtO
	1X/xPYut5JYIcR9R7Yt9zlkXl8SmPC33V5bxqvKuKDqs6WtmDqyRO1ALcfGIGg==
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010037.outbound.protection.outlook.com [52.101.61.37])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-64-2MJz_apSMdG8jeCGSr19lA-1; Tue,
 05 May 2026 10:33:05 -0700
X-MC-Unique: 2MJz_apSMdG8jeCGSr19lA-1
X-Mimecast-MFC-AGG-ID: 2MJz_apSMdG8jeCGSr19lA_1778002384
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by CO1PR02MB8601.namprd02.prod.outlook.com (2603:10b6:303:15c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 17:33:02 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 17:33:02 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Rob Herring <robh@kernel.org>, Piergiorgio Beruto
	<Pier.Beruto@onsemi.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 1/5] dt-bindings: net: add onsemi's
 TS2500/NCN26010 10BASE-T1S MACPHY
Thread-Topic: [PATCH net-next 1/5] dt-bindings: net: add onsemi's
 TS2500/NCN26010 10BASE-T1S MACPHY
Thread-Index: AdzZlV5WH2ywWnNEREiWlMiVKhqFigC//AwAAALiIeAABOoIAAAAGYww
Date: Tue, 5 May 2026 17:33:01 +0000
Message-ID: <CY8PR02MB9249B2450E2931FD5533F46E833E2@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <CY8PR02MB9249D083B637477C254F9B0583322@CY8PR02MB9249.namprd02.prod.outlook.com>
 <20260505134434.GA2493310-robh@kernel.org>
 <CY8PR02MB924915930E62AE03DF05C2DC833E2@CY8PR02MB9249.namprd02.prod.outlook.com>
 <7fad56ee-88c8-4e0a-8411-eeb5c0ab4a38@lunn.ch>
In-Reply-To: <7fad56ee-88c8-4e0a-8411-eeb5c0ab4a38@lunn.ch>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|CO1PR02MB8601:EE_
x-ms-office365-filtering-correlation-id: d89b4161-31cc-4b3a-3eb3-08deaacc5b8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|56012099003|18002099003|22082099003|38070700021
x-microsoft-antispam-message-info: G/nVNOAYMOGoD6SbZVA6flTeZNLHDgED4kLiuKn3shEGCtSvanCO5mGn7nqDX9x4jhK9AD3SCt7XMjsrG2MFz7k42F2E/qCsuFSRRE7CAJAx1s5bcJ06ZN34x4eXA4g8MXuUByrZsDOozU7NwSohYH4YWW0897biat3DIe1YYUnKCBigvrK87zu6Cw0OQzNjN8BwIuEA4jiYWDoxBzZ8f8BK9o9lnOmdbjoftHoUzUkbQdp4ubCygdNqTDPmurHlWRr2QejD2LmUHB6c3+iD/TsLiDyjBslhhTbGKK4bVZjW5gR2QzCutEGvWScZwiq/5Qt6rJeBaLV84j/aCOCkOPhFu4Uu7WlsA6n8XcKCuHqlU4gh8XfI8O8UHzHnFYvG5zyjAc7ukMmOR2wAWBwPlWMaNxS9ic6+DodNhAPxOxICO5tCVnkspvzwdfMPO3ajaAhFx2he9isiVUUy/qaoQSgifvFIfcxyokrupJoylF6qSGUf2xTNHzfbW6TFl3XDC3hZPdtOvULulZatNrISC46aWu7M1hKfpR6LL8mNr/FL7CQZp8pkf2xFYpbANvolADL9pJhrSlSPyhNYz0GkdzXvq7qU0S77B5IO8Mkc/YJ3s8mF6NFtdHpd5oMGt88XoKu8gANmY0IfXxrgXhyjCguVVAAvtJMPOKWdWyHb1QbACS+TFpS3ejqIyjtJALEDDtXMB5ksnAnO1LqVf/wl6NJA31/oTDk+8O76OhWQgqJRS7hBUxMNSycfyiS9i0xH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1d6alJrYVRwU2VFYks2ODlzZU5yVWJteTJObG1BalR5RVdGNHhidm5OeXhx?=
 =?utf-8?B?OGRNam9DVk9rRjlmMXhBay94SGp3WHJxWE11bG1NZTZ5NllrUDVwMEU4Vm1H?=
 =?utf-8?B?NWE4NW9ybUdPMCtKOVZrNE96cGIyTTJlZkJRd2Q4UVo5dkdIeHBLdHZsQjR1?=
 =?utf-8?B?Mjg3U01DTDVTRWt0NXp2NnRJa3VFWlNXM1NaR1R4S3RtOEtTRmFXbWlSaXdE?=
 =?utf-8?B?Vnh6SFZtUDVmeWg0aGhYOG1qYUtwNXFxVWd0ZG5LeVpIUmV2QnhoNFBrREpk?=
 =?utf-8?B?K2U3TlkvYitlRXFjT2ZmSTFlY0s5Z3J2Skd1VmNTVUNrelFBR1pyRFFkdW9o?=
 =?utf-8?B?N2RTUVoxVFgvaSthcTFzV3czNWxhcnhVRjY3UFVOR3UzZGppbnBYMWpsVDVy?=
 =?utf-8?B?aGhIWXZrVk1SK0JQSG1lbjdmVTN5UGRoVkJwU01iUzBEWUFCZmZJZTBuVjdC?=
 =?utf-8?B?RGNtOExhNVlhaVA0Mjk0cHErR2xRS0JSb3FBbjF4MG1pdjNYeUpVMW9GZExQ?=
 =?utf-8?B?ZUpLM2xhWktyd2RxL3J6aE9oWEhyelZLOHF5aGhYKzJBbURmLzlrdXZlSkU1?=
 =?utf-8?B?RDNJUVhUcjUwbkVNaUVtVlgrencxeXdQUURqL3VaRUNCUmZ6TU15NVhobHNC?=
 =?utf-8?B?aGtjSSt5U1NMK050eC8ydytMcXVWYnJML0JNU1VmeWNhTGdxZFpRc1pockp0?=
 =?utf-8?B?OGxkTnlzMlNvb0djNDl5UFFwVzNYMkxXTGY4SmUxWENoTko3MHA0c2V0NU1m?=
 =?utf-8?B?OVZZK3c1eGVKZ0NuVWFjRk1pN2hnUWdKcm5McXNZdU5IdUVkZjVwRVBaTTg1?=
 =?utf-8?B?UWdjWk9WMUZ5SWhPVmxIMFNySlpSWU5VdTFRVnE0YkNRRk91c2R0RGNZUnJs?=
 =?utf-8?B?MzJhREZCZ3FjS3h5SHVTV3A1ZkFCWEFiM3ZTeC9jVWxuakg1dTRkQjcvR1VK?=
 =?utf-8?B?dnNVN2ZNR0lVNThIUFM1MEpGc21JWUR4MVNkTXVlS3BLNkliVDYrMHFhYmx3?=
 =?utf-8?B?NURnalhQQnEwQ09kd2RWUW4vQy9UcjEwVldRY1YwMjk1Mlo1cEhhNE1jMUtF?=
 =?utf-8?B?VkJ2OTJQUUFkeTJjSk8rcitrOVd6U1dJellWcWRLUnRRYnVuMGdaSSt2WWwz?=
 =?utf-8?B?TFQvK00yNHJsVHJOK2ZHWXQ5V3RVZGorbnVLWjRObExRUzlabitKM3Fqb2Zt?=
 =?utf-8?B?cGhPMlBJV0tac25oNkZBZ3ZVZTByYmplbHpwU3plSUExOHY1ek9ZYWJ5SFZY?=
 =?utf-8?B?VklxRExncFFLaXU1MHpoVDA4eEhSY1VpUDI4cjFla01NbXlWR3BYNENDajQ5?=
 =?utf-8?B?L0pOQy9WUENsVVZxaHNLS1Y4cWtyK2FWMWI0RGhYVGNkVUN4WXJDSXo3K3Ns?=
 =?utf-8?B?bVNsZUZ3eFg1Qzk5cGZIRzdYajFZREw1QUN4QlhsRnVMcFBSVHkvcFZuZG1k?=
 =?utf-8?B?VTRZb1krVEVrczl6NHAzQm5sd3VORWtObWIzb0NoT05lMldEWEd3alBYM0Jp?=
 =?utf-8?B?d1JFc05PQ3NsaHFUUzJUNFFZTm1zem9zNVYwTUpsOENnQTRBQ2JlcFRLd09a?=
 =?utf-8?B?RW10aTdsQ2VYY1N6TE9sYklQS3VQSmlNdE5pSWloQUxBM3ZJSWFGRkJGaHND?=
 =?utf-8?B?TFR1VGkvRWhFdVE0UmlmZ2N3dHU2SDZaK3NqbU54eUZobnphUTM4d0M3WU14?=
 =?utf-8?B?L21URWdEL0gzZERydFBTb1R2cWxndXBYdHJ5aEtmb0JLVnd2SjNmUjRBc3Rw?=
 =?utf-8?B?cDJoUVdHaW5rSmtGN2g3UlVkSDBFMk9GQlZHWTU4cmhlT2tkZEw0TStoeU1W?=
 =?utf-8?B?Rzd1RU84VEJxSzdXaVA0VFhISFFSeEQ3cUlXclRLUWVTajM4L0Z0U1kwZmVB?=
 =?utf-8?B?eXBwQitkZTl3U29tUTY2V2VBQis0eUpxSGNXTmxIZmRPTUdPRDFaMStwL3Z0?=
 =?utf-8?B?U3hnNjRBN2tqdkN1aUZ1NUViMFYzUkg4T0hqRW9RMldoOG9UT211MmNSczI2?=
 =?utf-8?B?b3o5VCtYanpjUFVZeTBvRlZSb2ZZcUQ1eERmN3Y1ak5WY1FVL3lycndqZHFM?=
 =?utf-8?B?SXVqaGxJRVdBQXl3bkNDQTFaTWF1WEZNQUxTOW1EckRwY1ZUclI2eU81L05R?=
 =?utf-8?B?SEx2bS8yK0dmWmgyekljaEcvUnVORHFLMXhnNTJMbWZwRjFlNnZPdll1ZmdM?=
 =?utf-8?B?eE44MlBmUUQ5UldBdTdnNHVKVzAzbjBlUEc3TUJ0L00zMVBXV3RCWG9PM2g1?=
 =?utf-8?B?dSthMXdVR3BsMTBzQWdBNDV3ZDZMZVEyeTFpS2d0eTFlMjl1UDh0TFhQRHY5?=
 =?utf-8?B?SHBJcWl4RzF4N1M0c0RpOEs2anZHSTFmUjVISlpwblhjaWNqYXE5NlVLU2x1?=
 =?utf-8?Q?+h33gGerPsXDzy/M=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rnMom2onPxWCTofGrJJMPzTHFd2ULSN5qrrlh3bZxrT/V1wVbZO6kNT1WbQQQwpeSuPreyovxpTxgMfKSPnfAEMnSiXA7I06F9KzIJys1LsiWh7fBT7lozF9yqmma1P915Yv3cgbXi/imEsLwTBHEIjP5zBiDy1YpM8oIt3KGZ36om3upraDI0QLWioAVajbQCRYBAckjRQxoH2uZcI1fSPyHyT1quqVkqG9FtZRZVvdWCQ4MSgQ1Dfa9EA9WzPw0k7WD+7Yg/K1+lXXf6/bdl4KQBJXkIH6MciY4jLZBAZ2jGBHwl1z0K3r8f+ngkaEvc6PmFpnc26giJGqEx9+aw==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d89b4161-31cc-4b3a-3eb3-08deaacc5b8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 17:33:01.8927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qrNZUDFTZwLRnRGPKrMHf7ZbBTAd67Zpe9bWcgnUBcqjSVFRT1G95GkCYtz/4Sr4CsZVXKO6wJmHs6dm18xXTIfqMtHjzHEwu+wsGiqr8/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8601
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vkDGDdFAycdz_JSHW6MselscG-a3ylvNLt2eGHhVs84_1778002384
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Rspamd-Queue-Id: 7F0714D2195
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284530-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[onsemi.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmV3IEx1bm4gPGFu
ZHJld0BsdW5uLmNoPg0KPiBTZW50OiBUdWVzZGF5LCBNYXkgNSwgMjAyNiAxMDoyOCBBTQ0KPiBU
bzogU2VsdmFtYW5pIFJhamFnb3BhbCA8U2VsdmFtYW5pLlJhamFnb3BhbEBvbnNlbWkuY29tPg0K
PiBDYzogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47IFBpZXJnaW9yZ2lvIEJlcnV0byA8
UGllci5CZXJ1dG9Ab25zZW1pLmNvbT47DQo+IGFuZHJldytuZXRkZXZAbHVubi5jaDsgZGF2ZW1A
ZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsNCj4ga3ViYUBrZXJuZWwub3JnOyBw
YWJlbmlAcmVkaGF0LmNvbTsga3J6aytkdEBrZXJuZWwub3JnOyBjb25vcitkdEBrZXJuZWwub3Jn
Ow0KPiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldC1u
ZXh0IDEvNV0gZHQtYmluZGluZ3M6IG5ldDogYWRkIG9uc2VtaSdzIFRTMjUwMC9OQ04yNjAxMA0K
PiAxMEJBU0UtVDFTIE1BQ1BIWQ0KPiANCj4gDQo+IFRoaXMgTWVzc2FnZSBJcyBGcm9tIGFuIEV4
dGVybmFsIFNlbmRlcg0KPiBUaGlzIG1lc3NhZ2UgY2FtZSBmcm9tIG91dHNpZGUgeW91ciBvcmdh
bml6YXRpb24uDQo+IA0KPiA+IEhhZCB0aGUgc2FtZSBxdWVzdGlvbiBpbiBpbnRlcm5hbCByZXZp
ZXcuIERhdGFzaGVldCBzYXlzIHRoZSBtaW5pbXVtDQo+ID4gc3BlZWQgMTUgTUh6IGlzIG5lZWRl
ZC4gVGhhdCdzIHdoeSB3ZSBoYWQgcGxhY2VkLg0KPiANCj4gQ291bGQgeW91IHRyeSBpdCBhdCBs
b3dlciBzcGVlZHMuIFdoYXQgaGFwcGVucz8NCj4gDQo+IFNpbmNlIGl0IGlzIGEgMTBNYnBzIG1l
ZGlhLCBpZiB0aGUgU1BJIHNwZWVkIGlzIGxvd2VyIHRoYW4gMTVNSHosDQo+IG1heWJlIGl0IGNh
bm5vdCBrZWVwIHVwIHdpdGggdGhlIG1lZGlhPyBCdXQgdGhpcyBjbG9jayBzcGVlZCBvbiBpdHMN
Cj4gb3duIGlzIG5vdCB0aGUgZGVjaWRpbmcgZmFjdG9yLCB0aGVyZSBjb3VsZCBiZSBvdGhlciB1
c2VycyBvZiB0aGUgU1BJDQo+IGJ1cy4gSSB3b3VsZCBleHBlY3QgdGhlIGRyaXZlciBhbmQgZGV2
aWNlIHRvIGtlZXAgd29ya2luZyBpZiB0aGUgU1BJDQo+IGJ1cyBpcyBzYXR1cmF0ZWQsIGp1c3Qg
bm90IGdpdmUgdGhlIGZ1bGwgMTBNYnBzLiBBbmQgaXQgd291bGQgYWxzbyBiZQ0KPiBhIGdvb2Qg
dGVzdCB0aGUgZGV2aWNlIGFuZCBkcml2ZXIgZG8gd29yayBjb3JyZWN0bHkgd2hlbiB0aGUgYnVz
IGlzDQo+IHNhdHVyYXRlZC4NCg0KDQpJIHNob3VsZCBoYXZlIGdpdmVuIG1vcmUgaW5mb3JtYXRp
b24uIElmIHdlIGNvbmZpZ3VyZSBTUEkgYXQgbG93ZXIgc3BlZWQsIGl0IG1heSBzdGFydCBsb3Np
bmcgZnJhbWVzIGFzIGl0IGNhbid0IHN1c3RhaW4gdGhlIFBIWSdzIHNwZWVkLiBQbGVhc2UgbGV0
IG1lIGtub3cgSWYgSSBzaG91bGQgcmVtb3ZlIGl0LiANCg0KPiANCj4gQW5kcmV3DQoNCg==


