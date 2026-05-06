Return-Path: <netdev+bounces-285006-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBwkGayU+2nccwMAu9opvQ
	(envelope-from <netdev+bounces-285006-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 21:21:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B50734DFAC6
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 21:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A39CA3003EB3
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 19:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B13314D35;
	Wed,  6 May 2026 19:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="V4oINLCn"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54543313E2B
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 19:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778095272; cv=none; b=BCC4ZCoj7zNU2cF7mD56x99amJAXky84fJz3zlI0LWrkWZnCBFhg3pvEF5C0+RQDe2W2VwCuO6DUdF6gHoULQmmIk5u0YhL4CeOplJ8TL929TERSsm72dbNPQ5nI0U1pUltxTjA3l+TpZ86xd1FKa4g2w7ELyJFYj/caqYvs7Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778095272; c=relaxed/simple;
	bh=PMHvsWY6H/zYnA9NLcZo57XUtmRMPPEcd1z0pHesQZw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=KWX90IEIEtmFlqcyLgcR+bjOMEfTA1XzAKEkI21AuCyK5+J//ow9JHQX9BOuhRjQl/xNG0PsITJ+ALIdnRQN7WhbWunfjH40+qXSB82gyOIykrazWrQTYT3x/M45/iP82Qoj98bst/REFMUCkQGtlxXjXv07XVUJoOR/ypNRKLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=V4oINLCn; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1778095265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PMHvsWY6H/zYnA9NLcZo57XUtmRMPPEcd1z0pHesQZw=;
	b=V4oINLCnfvWH86TpF2tgTDX1RSdN8uzgcXjDpAtn1bSLZnVUMaqCoTCBvqrVJmtJGsBRP5
	21LI/CTys2xXWKNzhJuhDN5nSbINAPXsCqhVx8UMG8qfs5ZJx8o6CsUd40fJ6sC4FKBw4h
	74theGAu4sDSmfY/crZUvVybDvrrYjumULFNAOIfI+2PTKU6SpGMmcgaKQhp2fG/4GEnht
	hvKhAS24fZSJEvdi/T8pJj1iqynu8nOudNEvotflM/nezvWnA9Miyf/dYZS09uaY05uf0u
	eUcj0SINNcOsaOpciqOpahqfA9RyKSwF8Aai6wCWS6OFwR1N9TfXHbQCsuF8UA==
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-63-oLrBm4PUOK-pTq23x0Pylg-1; Wed,
 06 May 2026 12:21:01 -0700
X-MC-Unique: oLrBm4PUOK-pTq23x0Pylg-1
X-Mimecast-MFC-AGG-ID: oLrBm4PUOK-pTq23x0Pylg_1778095257
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by DS7PR02MB10913.namprd02.prod.outlook.com (2603:10b6:8:269::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 19:20:55 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 19:20:55 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>, Piergiorgio Beruto <Pier.Beruto@onsemi.com>
CC: Rob Herring <robh@kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 1/5] dt-bindings: net: add onsemi's
 TS2500/NCN26010 10BASE-T1S MACPHY
Thread-Topic: [PATCH net-next 1/5] dt-bindings: net: add onsemi's
 TS2500/NCN26010 10BASE-T1S MACPHY
Thread-Index: AdzZlV5WH2ywWnNEREiWlMiVKhqFigC//AwAAALiIeAABOoIAAAH6OVAAABm14AALdyfEA==
Date: Wed, 6 May 2026 19:20:55 +0000
Message-ID: <CY8PR02MB92498D49AF79E5A21C235D71833F2@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <CY8PR02MB9249D083B637477C254F9B0583322@CY8PR02MB9249.namprd02.prod.outlook.com>
 <20260505134434.GA2493310-robh@kernel.org>
 <CY8PR02MB924915930E62AE03DF05C2DC833E2@CY8PR02MB9249.namprd02.prod.outlook.com>
 <7fad56ee-88c8-4e0a-8411-eeb5c0ab4a38@lunn.ch>
 <DM8PR02MB8021DB41F30E52D3DED9E7329D3E2@DM8PR02MB8021.namprd02.prod.outlook.com>
 <8fb3a66e-28cf-4db7-a0eb-308f477d3945@lunn.ch>
In-Reply-To: <8fb3a66e-28cf-4db7-a0eb-308f477d3945@lunn.ch>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|DS7PR02MB10913:EE_
x-ms-office365-filtering-correlation-id: f93f0311-6d4c-4d5a-56c4-08deaba49884
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|18002099003|22082099003|56012099003
x-microsoft-antispam-message-info: p19ArPUGULZXj2Znn4hb7jmxuwLbWOr4DK6jSJySOF6pdTbqDRvWuhxv270v3pf6enR1LgpNqkcvnELayqNzug80I/ub6KxZGwwdgLxQVcZSjY9MvbrwCWxF40wXD5GCh/rRHEQGmh0rBw1Sl+9Z2ddRohcC0ynvdVyZVW+Zx2Te8PgWiS6n9aKJ+X35pw39d10l+t0R3w1pxuqWc1GFdL3coqYQE9EwBDPkSCAkilRQ5JbEZXKFfWHK8eT07C6AM1ZWtf0Ilpvvk62BvW8mzSTa5vTFwbn2HOD7gzZWXDWyOGkV173We0PN7BXu40luqACYToLJaTFqTeZtlKYNdmnDLI+ifWYSZz3qwaqBBlzSSJmKmN/WmaEsOQ+kn4qGAsWshpSBndPMEkjt4oeyu6Bjo8RJ+w5YNaPJP5evV/jeZcrdi6yf6M4+SByjLNBRam6/9fMY07Up4lKMKc8ta30+iym5ysIYW3LpB1f+Uxzx2o/kJn0q/eVq02Te1qrH6JtGgrbLSQdtPDn8eh1tBH0ViYYFOH+rfpgF3uhtuae1jtfGrrgg1pw2Yv/jDx3viv41fo9euxLMDxavwINhxujZSk/Iun3vFLfd/J6DFsN8Uu8vr/L/w/lfb/IQanQgXWcoJGWuaWX6lozzxV9kXjIhzy/agzXSAxb+fN7dzjSMQ3S+hGuCeZy4NAutehlIkP3o577sPLpLiHGkAhxuNE/4ejqieEN5ZOK9iI2qdj54ISb8qOM3giI/CyTvFx+q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aENaM203QjZXY000ZXVtZkNnRnQxMXM3d2pROHJ6cEtaSHZFdTl6ejRaK1RZ?=
 =?utf-8?B?RjJZemg1S2JoL0VqcFdNaURTWWlka2Erd3FzWDBaN21POW5VbVFPdHcyZEph?=
 =?utf-8?B?bkdGRktBVllZNzhrRC9aamFSZHE3OUI5ZXNqYUZQVjZ2ajFCdjA4WkJsOEo3?=
 =?utf-8?B?ZTY4ZVJ5L0RqbVB6ZWRJcmtRQU9uZFV0b1hQWDhlNWloTXZlc1NUbkFLQ2xs?=
 =?utf-8?B?SFNZMTBtYjBoendSeVNXeHhIaE1kQm5CZmRXSFZZVHgxUGo4UkNadjhaazA3?=
 =?utf-8?B?MkwwK3FBek9mYWNGaE1TVlpoMjlaZnVXVGJhbG9KemZwUldSVWZ1eEQyN25u?=
 =?utf-8?B?ekpXOW81WG9XSnBldzlnTENzWWtlZTQyNFRVYzJrb2JwNjV2dlZra0QyZXFV?=
 =?utf-8?B?TlRLdEg5SEVjY01aMXVVdGhvejI0eVdMY281dit6MnRDYm05NjNxUVhtVHpi?=
 =?utf-8?B?eFFpaTZyZHJXaUpKQ2VHVS80WDUwR3JiejVvUGxxby9zVC9vNWJjNnRNRlVm?=
 =?utf-8?B?M0hLRWhXd2w1NnNoNVJlZU43MDkwbWhReXVnQlppczR1N0pobHhiYVJhaVM3?=
 =?utf-8?B?MUpCZy9Tb3F6LzdvUFZZeUVtWUVyc0FTWkVJNGsyTkhlTzliSnpaTGRldmFi?=
 =?utf-8?B?K01RclprM3J0c1A1dmJHN2k3M3ZzVVJLNVVxNlFrV0hGQTRqeG9pWXRISmJW?=
 =?utf-8?B?czBZdG4vMC9DYU1pcCtiUWxXaG5ydXZlSEJIQlN4SHlpUVJiaWh3d2NWcG5P?=
 =?utf-8?B?RUREaG9vNmdqWDJHdFBPZ2Y3Z2tLb1l2UGVaSWxURFdsT0xQVEp6OUFzSEx2?=
 =?utf-8?B?WE5uTmlNU2NYbGFicWk2WlZ1QjROM2g4TXZqakkyNlNTc3g3ejhPWXlMU05O?=
 =?utf-8?B?Rk1YaGRaVmlrUmZPVmhUS2tTOHhicWt6aHFYdFM1UU5VNlNpY2I1d2hxdHli?=
 =?utf-8?B?cEkzMXhiTDZJYyt6ZjlnNlEzSFl0U2dKa0d3SnZ5V1B0ZnJDaHBlZW5BeFZo?=
 =?utf-8?B?c0Y5bkVlVS8xYVRLVmVIbTB2YVdQQlN4ak05ejY4bFYwWTZpVjdaVjlRSEVv?=
 =?utf-8?B?Y2p4SlFlRkwrNmpYOSt0dDVCVmJzWURWeEF0eWhtNForNURMZi9aTUd5ZkN6?=
 =?utf-8?B?Mktya0l5QVBQa3FnYjJTMzA1cE16cjJCTkhKWittN1UwNFJCVmMrdGF6dm81?=
 =?utf-8?B?YXdGNk5udzZVM2t6L2VTanc3clVoZ0ZlWDFyU2xhcmsxek1JQ0NKVnp0Uy9I?=
 =?utf-8?B?aFFuQmFILzV6Nmo5aW43MDFCVDI0bnk1WVlmdjQvVFB3VVlmUVBid3I4b1JE?=
 =?utf-8?B?a3BjMStha05sQTVVWGl5QmdNQ0xwKzZOVGRIeHFteTJXSVpETGQ5L2lLMS8v?=
 =?utf-8?B?RHovcGxyYU5LYjQvVGZYTUN6Qng5SjM5TEs4VG54OHphMTVoamczUWc0aTRn?=
 =?utf-8?B?TCt3NDJ5bURhS2ZhSjdibFZ3dUZlTCtxYUVKR3BpaWxLaTJMMWFrNVVGUW1q?=
 =?utf-8?B?Y0lVTi9RcWswdHBWQUtMd0NCcGxkQ0t5dHF4alJZMnlwSno3OU9MKzhsT3li?=
 =?utf-8?B?RVVtVXBLZFJqOHRiMmJMTjZoenNxRzJaVjFZdFBkZUxoOENGNlAwMWJVbzc2?=
 =?utf-8?B?VkxiSyt1MllDemE4aEZXZ3ZVWE02Yjg4N0J3ZEs3WkVJOUx4M25qbFVPdnFq?=
 =?utf-8?B?citDTXJnUUxRd3BuZlkzREx1RnVxQjRDdUQyeWRLU21TNVMxTHZ3cjRqa1lI?=
 =?utf-8?B?MEhBcSs0ZlVBd0FXejVqeWJrUzQ2Yk9LL2dONWpxV3RRMzRvWDVGdkt2VGVJ?=
 =?utf-8?B?bTVXTFVqb3d3QjhqUzFBenBzc2IwMGlqdllQTS9udWhpUCtPc3Y2NVFMcXR1?=
 =?utf-8?B?ZkxIZ2NrN1hZZTQzN0d4aEszWHp1NDIxQUtLNUxCVCtoc3lveFFCVGJFQ0I4?=
 =?utf-8?B?NXZjc21VVFlnSUlvWWR6OTFDWEs0a2N6U0lKY3l6Qy91Q2kzZTNDMVkrMVhq?=
 =?utf-8?B?MEJoM0pCeVh1WE0vemZzbERESFJQSU1xeCtLWXQ1NVUzNy93cHNQbmlqZ3Bv?=
 =?utf-8?B?NzBVWG9jNVkrbjFIcHI2cU01TlpvemdrcmNEaE1nVUxKNFNTUnZHYk94bGVz?=
 =?utf-8?B?ZHlxalplaHQ3VU9LUis5REhDNG1NRzgySk1VTngrclF5UnljQTliS05RVFlo?=
 =?utf-8?B?V2RrNEVraHJYRnNlN09YMGxhY0pYdy9WL2hDQTBzUWlpZHpScjhVcHg4SEJj?=
 =?utf-8?B?N3RNcEM1VklQazlJazQwZFhqN29Kc0RZWnc2K2wxTi9RMHR0and2RkE5ZkFo?=
 =?utf-8?B?UEZVQ3FVVUU1aUlHaGxmUVZ4Q094eUVJTUYvMEZwSmdXZGdxcnVPRHduWHR0?=
 =?utf-8?Q?hzTSc89fsWilJ7Ns=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DLd3OZBq/66zI9KeNGomW6cLZejQomUjwhuTIEPMmpcXQ9W72/0GUKgI6BXjSvNKoAUZ8tjl8x1OHsUYI/gNKg5w1UZQSrsGNPM6dKf4x1ItvnN1+QuLm+TzM8ZNkkxZJZ0PXYrz0KzyeeXMJEB5eL3ZPJM7bQ0j5P8+PIQLTFGru4WYOd5uTENrbBCsTo3K5mnT7pWjWNTPjoGAcKMQ5gGdOjU9IA+DOV7xM3NAiEY+YiNZdctA/d+BL/JFNcgvrf235SCr8ZuiKqthyL+0Zsx4a+wxKFLIIgjB2TOdSlYqvtdFNnLtq6QijAMHjjvvz+Mn+WJc3YIArRQx4RA+Sg==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f93f0311-6d4c-4d5a-56c4-08deaba49884
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 19:20:55.4632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3gjlRhC9jlmqa8N+J83TC+pf7k1DSa5erEi8fSVMoohi2yzDGqauxye6RpBQWEzbhhl08Z98WbvLQ21AIendO9cB4RszlEN35uzWmhYR7zk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR02MB10913
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Cnh67KqIS6CwRqSikvC8VtqWu5CpInKLBCnfgMn9sEM_1778095257
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Rspamd-Queue-Id: B50734DFAC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.56 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285006-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[onsemi.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,onsemi.com:dkim,onsemi.com:email,lunn.ch:email]

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmV3IEx1bm4gPGFu
ZHJld0BsdW5uLmNoPg0KPiBTZW50OiBUdWVzZGF5LCBNYXkgNSwgMjAyNiAyOjI2IFBNDQo+IFRv
OiBQaWVyZ2lvcmdpbyBCZXJ1dG8gPFBpZXIuQmVydXRvQG9uc2VtaS5jb20+DQo+IENjOiBTZWx2
YW1hbmkgUmFqYWdvcGFsIDxTZWx2YW1hbmkuUmFqYWdvcGFsQG9uc2VtaS5jb20+OyBSb2IgSGVy
cmluZw0KPiA8cm9iaEBrZXJuZWwub3JnPjsgYW5kcmV3K25ldGRldkBsdW5uLmNoOyBkYXZlbUBk
YXZlbWxvZnQubmV0Ow0KPiBlZHVtYXpldEBnb29nbGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7IHBh
YmVuaUByZWRoYXQuY29tOyBrcnprK2R0QGtlcm5lbC5vcmc7DQo+IGNvbm9yK2R0QGtlcm5lbC5v
cmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBs
aW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIG5l
dC1uZXh0IDEvNV0gZHQtYmluZGluZ3M6IG5ldDogYWRkIG9uc2VtaSdzIFRTMjUwMC9OQ04yNjAx
MA0KPiAxMEJBU0UtVDFTIE1BQ1BIWQ0KPiANCj4gDQo+IFRoaXMgTWVzc2FnZSBJcyBGcm9tIGFu
IEV4dGVybmFsIFNlbmRlcg0KPiBUaGlzIG1lc3NhZ2UgY2FtZSBmcm9tIG91dHNpZGUgeW91ciBv
cmdhbml6YXRpb24uDQo+IA0KPiA+IEFzIGZhciBhcyBJ4oCZbSBjb25jZXJuZWQsIHdlIGNhbiBy
ZW1vdmUgdGhlIDE1IE1IeiBsb3dlciBsaW1pdCwgYnV0IEkgd291bGQNCj4gPiBsZWF2ZSBzb21l
IG5vdGUgc29tZXdoZXJlIGlmIHBvc3NpYmxlLg0KPiANCj4gQSBjb21tZW50IGluIHRoZSBkZXZp
Y2UgdHJlZSBiaW5kaW5nIG5leHQgdG8gdGhlIG1heGltdW0gc3BlZWQNCj4gcmVxdWlyZW1lbnQg
d291bGQgbWFrZSBzZW5zZS4NCg0KRnJvbSB0aGUgY29tbWVudCBmcm9tIFJvYiwgSSB1bmRlcnN0
YW5kIHRoYXQgbWF4aW11bSBzcGVlZCBpcyBub3QgcGFydCBvZiAicmVxdWlyZWQiIGVudHJpZXMu
IFNvLCBJIGFtIHBsYW5uaW5nIHRvIHJlbW92ZSBtYXhpbXVtIHNwZWVkLCBhbG9uZyB3aXRoIG1p
bmltdW0gc3BlZWQgZW50cnkuIFNvLCB0aGVyZSBpcyBubyBuZWVkIGZvciBhZGRpbmcgYW55IGNv
bW1lbnQuIEhvcGUgdGhhdCBpcyBvay4NCg0KPiANCj4gQW5kcmV3DQoNCg==


