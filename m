Return-Path: <netdev+bounces-284565-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCasM6w/+mngLAMAu9opvQ
	(envelope-from <netdev+bounces-284565-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 21:06:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C14C54D3059
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 21:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8AC7330167E5
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 19:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0494B8DEF;
	Tue,  5 May 2026 19:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="iuCR9lBR"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DDF1F5847
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 19:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778007973; cv=none; b=pUzjDxJdDvKi5r1Td7Bke5i6ko8aBcghDmZc4TTukkeI+7sQIcoFvnC66KRlJrHMGiJU0gY9kGMthS7bxwDZtioje5clWhBq6TK+bHF4WlLtLIqwrISSPkNskQOb2s6/2wPq13boCdHqWdzrv10TJJAqOJWhFZEmohxPmO6Mi8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778007973; c=relaxed/simple;
	bh=J4qiND2emoYnOGec3eBlnxoC8BRVOrLHvEFjeVrhQNs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=psSOUMLRAz6bRtD7GTk6tfqiyqjmy/YflKQiMNE+lmCh35eMDXWiHzreHLyzY35j4PQUt6hip4UP4ApgnvtGEK6xOLcjrtVjXnarJocIDqeKgbTW1yPsAGGnhGtKjOk0GqG8R0iGjUjZUwKJop05Xq7GOPBJm+sxfdIrkKV20q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=iuCR9lBR; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1778007971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J4qiND2emoYnOGec3eBlnxoC8BRVOrLHvEFjeVrhQNs=;
	b=iuCR9lBRQ0+sUG86h7yZp9MNLOSAceo/Qc/WhTbd+6g5VfP0bz05NOOyxooDdzJSVnREDK
	69I4A6OCZ/N7cvQw+95e2LXzXrjqP8hQUjYzwGlY+vyVPlAT7GUhhytFl8gE1cS3BKS2px
	BjMra+i8MXacEia7EyAuU8XeuFnQq9X+G0eBq1XHx4RPPjWoHKlynrEHhDR8ItN0Vdf0rR
	BpI+jy2qvesZbzqH5vVnD8916n5M/GH1+JazYqtMioxEY4iiJA+Lm9ryjRujpPAXQFo1G+
	prbQOvjybEzhboTErig6sH1bt+PQNKuvbwxPzPSIZKJG7vxdWIKBghB8NJL1gg==
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011036.outbound.protection.outlook.com [40.107.208.36])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-43-KDQxZdifO02fNVe9hTm7cw-1; Tue,
 05 May 2026 12:06:08 -0700
X-MC-Unique: KDQxZdifO02fNVe9hTm7cw-1
X-Mimecast-MFC-AGG-ID: KDQxZdifO02fNVe9hTm7cw_1778007963
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by BY5PR02MB6866.namprd02.prod.outlook.com (2603:10b6:a03:237::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 19:06:00 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 19:05:58 +0000
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
Thread-Index: AdzZlV5WH2ywWnNEREiWlMiVKhqFigC//AwAAALiIeAABOoIAAAAGYwwAAMtFwAAABz9IA==
Date: Tue, 5 May 2026 19:05:58 +0000
Message-ID: <CY8PR02MB924979CE3C3415D769DD5943833E2@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <CY8PR02MB9249D083B637477C254F9B0583322@CY8PR02MB9249.namprd02.prod.outlook.com>
 <20260505134434.GA2493310-robh@kernel.org>
 <CY8PR02MB924915930E62AE03DF05C2DC833E2@CY8PR02MB9249.namprd02.prod.outlook.com>
 <7fad56ee-88c8-4e0a-8411-eeb5c0ab4a38@lunn.ch>
 <CY8PR02MB9249B2450E2931FD5533F46E833E2@CY8PR02MB9249.namprd02.prod.outlook.com>
 <69cfb4a7-93b8-4ea7-b4c8-422f19419fe5@lunn.ch>
In-Reply-To: <69cfb4a7-93b8-4ea7-b4c8-422f19419fe5@lunn.ch>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|BY5PR02MB6866:EE_
x-ms-office365-filtering-correlation-id: f9e5494f-3b95-4f97-bac5-08deaad95756
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|38070700021|56012099003|22082099003
x-microsoft-antispam-message-info: 5AaJNGN9MmoXf4Ch/y97+Qj+vt13wph6MceIyehDvsTM9caVyoVElqYm1S9RTFdxOREgIzrv5yXzrSUHu6lamlknxumH1JTIxawy/hakRcX2CHEQNJ7wruRvZtFHKfkp/R0O4xrtUxy8sASXaGVlOkq05+uYVQMc1ZbakOaceubaOXbhvWRn3QnM3HgW07TGuEquwJeB4MTWWFno1IGTMa8i5WETje5hsWvmLPwDenLWGmS+5WGZ0M8VMAYEBYan//yHEw8n73dTajYnyHLtVSWnpcf0NzP1wZ2SBR0sKGZtYYxE92Qu0z5V/dwN6Jw6V5i6JPDaBo2veWvt2j1218m/ObYovwgVUocAxJqPuc0/km2qpPV4oA/sNiG/bYB97qsm4LNk+M/AwjaNIzvnhId7UXZ8B4mJYbow1kycKwWLa1ycEhNYzRp6pzpD7WE7GEFBULMxxkhTLOwDDZHh1vkehspqMn8SWT8jLXncvI2tKbxDHuX0KGxg+s1XemXZwyk+cJTSXXJm0XWWD+mF2OdS+vwlSLDL7dTm9xp4dkDOC9IOEaOpWNoaJOv5cnuCXdzEC9/GLBUbjeXc789Q14/X9PqXy+xZRAPffA3S1dS4kHvW+awX04TObz9Nz8FjukzJSPbeNsdxYJCQOu7ZTfGMBdnYP6n4nQHSVnSIIl05nR2ZAXo5Gk8yqDVi6plH3levZCKeZzbfem0YldReySl76u+xTlap0EZK+kVqgsBnSzJesNKa4ifucmjvBtId
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(38070700021)(56012099003)(22082099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkQxcjEyUk5KZ1E1Wlg5UStpZWNQK3ptc3VTYk5td2FZbXZBd2FsclVjbERE?=
 =?utf-8?B?dGROZTVzMGxnbDBBdi9wZFpUbm5aMDlmY1JDVnEwMCtXUVE1VjQyMGtXdnRs?=
 =?utf-8?B?NVQyV0ZKSUhoLzVwMGgveFVPcjVIeVJkSVJHWWJ1WUpFZEdTbUNjWk8vY2gw?=
 =?utf-8?B?OUZWeGV0OG1BVmtXQWtndHVtaW1aRVFpYnplZlFncXdoV2VKMGJzMmJzbnhJ?=
 =?utf-8?B?UDJlMjMzNVBaQmZnZUozWnd3TG5wTkJ1SVkvYTJsVW5xcWNCaUxzTXJZeCtM?=
 =?utf-8?B?aGh6S0hlaHVrL3lHMm9jdmh0czdRU2FEZzlIYnJkS1Z1VmtPNVdXd0taY3Fj?=
 =?utf-8?B?bm9sNzB6d3lqL3BDZHFVb1NmYXVScG96MXA4MmI2dHhMSURmWVZSSmVwMUVX?=
 =?utf-8?B?cUNUNXZucjlSNEF3aG5Wbzh2b0pnYVhXQTY1b2RSNWhOd1RyUFptSHo5TU9H?=
 =?utf-8?B?aUlVU2tPK1J4dWZVYkl2VGFzcm5FYWMrdGhCaE52Q0R0cDlPcWdiWUdqOHdr?=
 =?utf-8?B?YXR1czlxcnJmc1dXOXFxSUdRbWFNOWk5NkRoaEFXaUNoQXdlcHd0SnJTa3Fj?=
 =?utf-8?B?WkFEcXRwS21ocEVobzNwLzZHZUduaDlQUk56TG8vTHoyRkVxRUtxM3Y3VWNF?=
 =?utf-8?B?eGxoMmNUNG4rWHZsYkliczF5ejFDZVBlakhQbE1SYmpYVmpCaFlyYUNReEM5?=
 =?utf-8?B?TGMzaFBNZ0xaZ2ZRSHNIcWdWZ1R6WDAwNVdtcTZqL3pUaFdQbXlNcmhGQldV?=
 =?utf-8?B?U2FBUlVzR0tyaDdzNXU2YWE2OHpjaWtPVjFhUXo0b0NWV3B3cDJHaVZCRXNM?=
 =?utf-8?B?dkljMCtCNXBRT2tPUGMvVHQ3c0RxbW9YRFg0bzhsbjFYc2VzOUhUdElBODND?=
 =?utf-8?B?Kyt5dldONTEwaisrQmlVOFQvQlJoTGVabjVCL0VydERzWmE2RWFMSjlHVDZL?=
 =?utf-8?B?UzZKUkhYQzZ5SWs5MG1oaFlUZ1RPZlZXL1QyTDRXa1JNeVFORHZ2aldEQVUw?=
 =?utf-8?B?MTJuVHJEK3dHVDZxdG5RckVIZ2RlSjFWbVMzWDJjVVNLOFpyVWowWHJzQlVw?=
 =?utf-8?B?ZGNpMGp4L1ZZbnF4d0lTa1N0bHR4dzlPM1kveGpUeTNOaXBHZHlnZE1Mc21m?=
 =?utf-8?B?VXZKUnZReFRsSGtUaDNuc003Wmc2R3RvMk5ZZ01wZk1OQ3E3TWRKaitMNmd2?=
 =?utf-8?B?dDhMTUIyZk85K2lBdWlSTG5EaTVYY2RmN1JmQ1huWmdTakJTeXJpZm1RY1lv?=
 =?utf-8?B?ZFpmTStMYVhQUWVrd3ZIUkQ4ckM4VWsrYlppU2JjUFhMU0l4UFFIaXlCS0tK?=
 =?utf-8?B?SnNURUJmQzVsamd0cVh2NWRESHFiMUdaRnBOUmlFRS9oUjhXYnJRenhBUkcz?=
 =?utf-8?B?ZG5XWE51Sm1pLzRXMlhVQ1ByMldvWTZieDFBTFZzMzRJQnVReTNQYW9QUjhU?=
 =?utf-8?B?WDFIM2hNZnVBdzVpaWx0cHNxS3pPdit1OVNpL3J0anJKd3UraklCNjZ3WHNQ?=
 =?utf-8?B?anVhL1ljcFRYbU8rQ0JYMjRoMUw5RjhzaVkxdGVDM2dUNXZrM1l2VHBnZnMw?=
 =?utf-8?B?azJoOWw5SGcrdEtBeFVsUVM5NG8wZ1dwNTJkdWpKUmduUVR2SkdXSXg0WmNy?=
 =?utf-8?B?UDZMckoxSWZ3d3drNEMzK3RDRzVoZE9tQ3lpNithUysrMEhBNTZLYlMwdFN6?=
 =?utf-8?B?NERkYTFld0cwKzZVVGpKSUdab2JwUDV4NnNLM2xXMXJraTJ5WlRXalJMTERk?=
 =?utf-8?B?NkVxejJTQ0V0dmhKakZNU3NvZ2dYVVRaQ1o0eEt3djUvNXZvWVJPblV1YVly?=
 =?utf-8?B?U00yK1VxUGc4WXNhNWJRR2ZybGY4SjlKOWNuTFlMdW9wN0ljUHhXTjU4L2tM?=
 =?utf-8?B?dmRycllSK05pR0JsaC9BdE9pczhBZ0IzSngyODBnK0dzbmxkQ3hRRVZUNURI?=
 =?utf-8?B?MDlSbzZhQkpEdVRESlZNeGZCaGY0dk41WlpnWWxZL0FrWUhVRjlCbFI0RGpB?=
 =?utf-8?B?V3N5c3RvQnJlUFpVMUU0MDluL0hYOEdyWGE2cVF3ditwNGV0V0lNRENYV2RN?=
 =?utf-8?B?d05jbWFmMWFpM3NObzJkQWMxUXRSQzdtUnpJamxBeXhMTSticlJlWmc4dmZs?=
 =?utf-8?B?ZTRBR0JyTmU3UnRDZVlFUnFtdFR3YmRyb1Rqb284eGZuaFVYRVozUWZWVDl0?=
 =?utf-8?B?S0tleHhkZk8ydXdiSElmRzNweE5uenIyYmIzVUxpbVAySTk0YW9MQ08zQUc4?=
 =?utf-8?B?TEd5UnZVeXRySzkyTmJjc1ZyTHRTbURyWE11S1ZXRVp3bncxUmlJUE1jbGhJ?=
 =?utf-8?B?aWE1SFJKbURyalUyZEdURjRrUFJVMmJuUXZaUXlyeUI5WXhpNHgwbDFsSDYr?=
 =?utf-8?Q?1dXHOk4fzPX+FeaA=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aFFAsLtXZCX6oTmN8RInvr7NqaNEx5m0hx6G6dT1k8MiH5YpzTBIycoeN8Zj8Ma3Z9zqyTeSwcUzPrExJ7AbcNngU9vWmH9DvGJeJfaCnXQLLeZAlVaun7iDCyYuk0E+Kes3pmv85XSsBWnw9oiGSU81ZWI9z9Vm1FNQ4t7MIuE4OHiFhtISv+lr0lMLvsDC6zEXKz+MPOABRmFJitJpQnHSd/9x8C8iibesn0pvAwkdhRQM8elKbNSlLzEy5O4wVkRxKuId/uEMu5Y046p60YEaL+n4fBXP8oMryAholDe2Vu1k7JbanN3D/gEmUb+CT4g8i9XkHIpvyD/+8TYtTQ==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e5494f-3b95-4f97-bac5-08deaad95756
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 19:05:58.2702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o+v+3Ddal/g9a8m7Lh2IEZ57WQPxbmlHIMtbxEvvm1P4hi8IWb5dlVyLpzZiunyQh93Y+z6pzxEgoLOw8OCg61lQf66bFI76S3mTCatA5O0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6866
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MwojLi-bBrolA7TofyA68MIVDYZDPsCJXj-dKEs-E5s_1778007963
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Rspamd-Queue-Id: C14C54D3059
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284565-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
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
	RCPT_COUNT_TWELVE(0.00)[13];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[]

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmV3IEx1bm4gPGFu
ZHJld0BsdW5uLmNoPg0KPiBTZW50OiBUdWVzZGF5LCBNYXkgNSwgMjAyNiAxMjowMiBQTQ0KPiBU
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
bml6YXRpb24uDQo+IA0KPiA+ID4gU2luY2UgaXQgaXMgYSAxME1icHMgbWVkaWEsIGlmIHRoZSBT
UEkgc3BlZWQgaXMgbG93ZXIgdGhhbiAxNU1IeiwNCj4gPiA+IG1heWJlIGl0IGNhbm5vdCBrZWVw
IHVwIHdpdGggdGhlIG1lZGlhPyBCdXQgdGhpcyBjbG9jayBzcGVlZCBvbiBpdHMNCj4gPiA+IG93
biBpcyBub3QgdGhlIGRlY2lkaW5nIGZhY3RvciwgdGhlcmUgY291bGQgYmUgb3RoZXIgdXNlcnMg
b2YgdGhlIFNQSQ0KPiA+ID4gYnVzLiBJIHdvdWxkIGV4cGVjdCB0aGUgZHJpdmVyIGFuZCBkZXZp
Y2UgdG8ga2VlcCB3b3JraW5nIGlmIHRoZSBTUEkNCj4gPiA+IGJ1cyBpcyBzYXR1cmF0ZWQsIGp1
c3Qgbm90IGdpdmUgdGhlIGZ1bGwgMTBNYnBzLiBBbmQgaXQgd291bGQgYWxzbyBiZQ0KPiA+ID4g
YSBnb29kIHRlc3QgdGhlIGRldmljZSBhbmQgZHJpdmVyIGRvIHdvcmsgY29ycmVjdGx5IHdoZW4g
dGhlIGJ1cyBpcw0KPiA+ID4gc2F0dXJhdGVkLg0KPiA+DQo+ID4NCj4gDQo+ID4gSSBzaG91bGQg
aGF2ZSBnaXZlbiBtb3JlIGluZm9ybWF0aW9uLiBJZiB3ZSBjb25maWd1cmUgU1BJIGF0IGxvd2Vy
DQo+ID4gc3BlZWQsIGl0IG1heSBzdGFydCBsb3NpbmcgZnJhbWVzIGFzIGl0IGNhbid0IHN1c3Rh
aW4gdGhlIFBIWSdzDQo+ID4gc3BlZWQuIFBsZWFzZSBsZXQgbWUga25vdyBJZiBJIHNob3VsZCBy
ZW1vdmUgaXQuDQo+IA0KPiBTbyBpdCBpcyBub3QgcmVhbGx5IGEgcmVxdWlyZW1lbnQuIFBsZWFz
ZSBhZGQgYSBjb21tZW50IHRoYXQgYXQgc3BlZWQNCj4gb2YgYXQgbGVhc3QgMTVNSHogaXMgcmVj
b21tZW5kZWQgaW4gb3JkZXIgdG8gb2J0YWluIGxpbmUgcmF0ZQ0KPiBwZXJmb3JtYW5jZS4NCg0K
V2lsbDsgZG8sIGFsb25nIHdpdGggY2hhbmdlcyB0byB0YWtlIGNhcmUgb2Ygb3RoZXIgY29tbWVu
dHMgZm9yIHRoZSBzYW1lIGZpbGUuDQpUaGFua3MNCg0KPiANCj4gQW5kcmV3DQoNCg==


