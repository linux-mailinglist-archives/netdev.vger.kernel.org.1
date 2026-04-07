Return-Path: <netdev+bounces-275813-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIsfH3lh1GnltQcAu9opvQ
	(envelope-from <netdev+bounces-275813-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 03:44:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 182703A8C79
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 03:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECBA9301BA73
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 01:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650A2204F93;
	Tue,  7 Apr 2026 01:37:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2090.outbound.protection.partner.outlook.cn [139.219.17.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B530A8248B;
	Tue,  7 Apr 2026 01:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775525870; cv=fail; b=CEpTZ8SH3ZHm7B9/GSAlblj9Urm6+/v2/RKcIsIHdUjFbo+wRvOqNrLxnfFxl1h9wmX5dkFm4sANvY6pfIIm0jdUgiSBb20Sbsi3w0kwUiDUZxKioiWphFPT21r5iHVQg+zh0vYkTVO+iH18EY1lCUtlEzuOKm21zit3g1t2hsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775525870; c=relaxed/simple;
	bh=9svDytkhrZ7DQHwJawwXS+yCnJBh0YFeMHC3PXNvR5g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NJu0gWSrTN+YiPBxx6SfflZQI+kNoTRlFMmbLa6gvn8y0/uqBQBMkU4A0KWnvgCkqhNdxxWOQxA2gpYwqlLtFi3S4dl/4YV8gql48duOcEI3sVQbn1c9wf/ycWFkd2S09Dix6qo9whqHelbAKJzSHCgP9/hG+SqU7ZvyQNX+Drc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgQPe7QB8rf/RmdIHIo0eCCGFDYc5YhEnRV1aRLWXfdOe4jouAHT5psEpLzSUDWy2Nnn22cFH/wYhj6JifXg5UenLBJF4RpHPvm6QdLol3l1J5vK/bCoK18RLophcyPP3YpWIdYg8EkM++IBWKYirIPpxGIY7LjKxND9TFWC4xOqDPHh8Mlu/7pkL6NJns9Hy5vuDO5WZe84Libop+9LR+M22EgQ1DaZy6iYCjz9jg7bFsZmQgiNnHWle/d2/P+cIHTxYByRzvUy2hKXK62/qyCSrNh9ac01vVeAhihPoJN+Yu2B42oi+4jJe1CBSH/sBUkg+G03QBAgXmQse54vPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9svDytkhrZ7DQHwJawwXS+yCnJBh0YFeMHC3PXNvR5g=;
 b=bswlf3lHns0CKPu5XhZIZjbXn9/8mpsXHceYz6FFskh1DdT77kltLcwE8i+mRXWIgJgASrISRa1Eu7arW/W6CkmwcjHsAfqxI1jGewQXN/YaAvu54mvONTb8vY9sNfVaujWt63qsVigP9XrRCVOWbf36Jw83QrL6+wESuOpeSQ4a8HpRAq3Wm9TKmOY3O0FanTEsf5KWxEAwIA8V+Wm3i6iEb33WmuJ1NA8RxTie0mBhZSq+cQBaSar7k+4AmIk/8oNAkkHaB5F/WiNzgNQ+FBsxOlijiPfT9PZWeDxURRh1i08hw8JpeAUrQiV9D8KSbBIm2W56WfeRuo2CTEmWMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1300.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:14::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Tue, 7 Apr
 2026 01:37:37 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%5])
 with mapi id 15.20.9769.020; Tue, 7 Apr 2026 01:37:37 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Michael Turquette <mturquette@baylibre.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Paul Walmsley
	<pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Philipp Zabel
	<p.zabel@pengutronix.de>, Emil Renner Berthing <kernel@esmil.dk>, Kees Cook
	<kees@kernel.org>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, Richard
 Cochran <richardcochran@gmail.com>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, JeeHeng Sia <jeeheng.sia@starfivetech.com>, Hal
 Feng <hal.feng@starfivetech.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>
Subject: Re: [PATCH v1 17/22] dt-bindings: clock: Add StarFive JHB100
 Peripheral-2 clock and reset generator
Thread-Topic: [PATCH v1 17/22] dt-bindings: clock: Add StarFive JHB100
 Peripheral-2 clock and reset generator
Thread-Index: AQHcwo9TQLfYd6wApEuyD9hxN+QHMrXOyPcAgAQQIeA=
Date: Tue, 7 Apr 2026 01:37:37 +0000
Message-ID:
 <ZQ4PR01MB12020E711CD7E1FAFD01B8A4F25A2@ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn>
References: <20260402105523.447523-1-changhuang.liang@starfivetech.com>
 <20260402105523.447523-18-changhuang.liang@starfivetech.com>
 <20260404-valiant-auburn-raven-c24be6@quoll>
In-Reply-To: <20260404-valiant-auburn-raven-c24be6@quoll>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1300:EE_
x-ms-office365-filtering-correlation-id: f3538206-cb30-402c-f796-08de94463fb7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|22082099003|38070700021|56012099003|18002099003;
x-microsoft-antispam-message-info:
 qmEP3bjgB6m9MPjt13YYbGxaYp04mGE7lmQibnSouKS3DhYzJsXk1bmqYbo2btr7bf4x43dt6M+f0n67dVlT1aFdFSy+1oc2CO2pPeRzsQx0PFUgRtZ17RGIPAVDCNgapObjyPR6qCU1Y9Uaj186KUljwlZvSvGsZj8n9aONL3xaxVDSSDpXbFZx5+Wqs7W33aYr01ff5D72abOpjp19WxRXAefVjYLSAi6sJ0WPIDwEUOGfNxlMN1SB8db3fKCViC3irEi2RRDBtTo8O7DqAwmKG0BFemQGHYR1T/mGMkI6Ht1OJyRI/JdRRgm443lMb/5qO8PdM2DtkWYK5zkA3jM4V3VoZ1kYt5waJwge324PfVXb7tAJDm730cLVgGMOJMkZ8CQXOG3SMTI/9262EsSjFg0jX6qkdeA+CO35ojfE4NC8M7aCU0WFnhL1e7lgJl+W52D5dtLFZ65IRvbe6u46fmlWLg3cgK5HjrZGGzKH8ToFCb52MODicMNbcFU52PinkvEIfd4kb4RUcWkFQgU+ZB/vFO8PB1YYMSnLfoRBanE+fxUAVBDu5/8BEW4FnpB27C/374YiPiIznpJORN05186bnyGp0mF6QYJR0eU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(22082099003)(38070700021)(56012099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OVZsME1oZVBrMkw1eCszd29BbFEvWHA2Rkh3VjdDN3RneGp1R3laRFBjMThX?=
 =?utf-8?B?aFVVSS9zbmxGUGYxNm9PN2VqQ0gwRzlsR2ZVbTByQlUyTzJwZEtyN1R0R0ht?=
 =?utf-8?B?OFlhamc5T3Jva2RZSEFyS3hZU1JMZHZqWlVMT21GNDhoM1hsbzA0dU9OcEVZ?=
 =?utf-8?B?REV6UUhxaW1oSDZwMU1Pem9uVzFtMUxRR09RWC9rZVZPMTg3ejVCbUxPRWZk?=
 =?utf-8?B?bU40TmZvODFxQk1zQVBMR0NwZGNnWmV5bGxQV0dmZ1ZmSWVuTWxld3NEOElv?=
 =?utf-8?B?RE5XZm9aOVdyYmVEdHdBcFROdURsK05tK3NxUm5DaFJEaEdEbXZzTnA1MzIz?=
 =?utf-8?B?WDBIRHhYOVFJOWZCSkxXYUZaQ1JFV2xVNGdqWSs3NHFJMUJDbzYxZDYyQUJV?=
 =?utf-8?B?bURQSmlaNFBucWh4eDF0N2hDRTZNdTJwaC90WklKdXVZdEhwNzhvdlNFU3Bk?=
 =?utf-8?B?WndwMjBXZUgreWx5RDNUK0gxVDhqRmdud0x0anRZejlpOVRUOVNkRnlmRDFP?=
 =?utf-8?B?bUdiVzd1eDdkVkdTTURMR0U3MzgwVDFwTE93d3pyOG56Z3JOUm10Q3ZCMysy?=
 =?utf-8?B?YnRLQUdId2szNkVEVFZkLzd6UzdzQ2NacTdCVjNTMTBNZC9scmFDdlk5dEJh?=
 =?utf-8?B?ZTVMWkZDUEoraUR2VlJYdVl2OXV3b09EeEtXbUZCSk9ZUDNVTUJHUTNyZEht?=
 =?utf-8?B?c0pNSXMrZDBBRGpKNXlveDVIV3ZFNUJwRVZ2SHJZOTdtMkpkbDQvZmViOVNX?=
 =?utf-8?B?YS9EUXVvNmZmUUF2Rk5OZTZ5bkxhdnUrcHJnSFlzL3lFSkNPbk5sczZFR1dt?=
 =?utf-8?B?YTM4RUZiTFIwN0VkaDJuTDdNdERjZk5rc2pUcmJ5V2d1Yzd3TTkvQzlteHg3?=
 =?utf-8?B?VERSMWN5UUNtVDhoeE13WGMrNjgxcytpVFNYelVBaHlFcFlLT2FZM29ZVHlv?=
 =?utf-8?B?ZHBUSnRxMWtLYjdSc3BWc2svSkJpbDRLQVpnZ1k1TDViUjlGY0I1MFNpYlRP?=
 =?utf-8?B?aHZSRGhwWWpUMjkyMTZOUUU1N1dmdGNHWEkvczNHU1daNTV3eXBYY3FnTHlv?=
 =?utf-8?B?NzM3UEU1RFR6N3ZnMkpudDRPQVF3NEtNYmNaUXBpQlg4WThVME1TMWs5cnd5?=
 =?utf-8?B?RTVoSmtvTGNMTXBHYkc4UWpZL3BaekFDeDZPQ2tCWGdrNS9LalJKMjd4Z0NP?=
 =?utf-8?B?dHQ1c0hRL3NOYjMwVHZnbmFSUDVIN0hPVzBQeEgyaTl5MU9JZmhSS0UxWmtk?=
 =?utf-8?B?R0VLTWlJNVkwV04zVms5VkdKQmhqQzJmNUJialFFVmE2eURHcS9NREZCSXQz?=
 =?utf-8?B?NmRXZW81S3VjaXZWYzlEOHNVRnlhWFpvU0lTdGxrSjZpRlhIQWRPY2RoUVdv?=
 =?utf-8?B?akdiNHdvVTBDMUhOOU01cjloQ24wTUQwUmcreUlvazBTZU80Q2RQZzkzRDNV?=
 =?utf-8?B?WGpZb0NGVjBYOEgrZmpMcG9MRUxSNFJuSFVmaDRtY0krdEptNmphQWQ0S0RO?=
 =?utf-8?B?M2JsVkR1d2VWdlF5R05iNDB4dFNqN2hURUFMbDlrZWRLUXpGVmlzL2ViWU1x?=
 =?utf-8?B?bktuTDVnaE9rQTVpUDlFa3lMQlpyMUxoVXNTS3lCb0gxZE8zbTNHRURoWUdt?=
 =?utf-8?B?MlJ4QXhYZWRQV3RNN25HM255T0szMTZaRE42MHBic0o1ajlKNkJyOWYxNlRx?=
 =?utf-8?B?bnFwWFl3VUxNWGdPc1JEajBWMGlZRXFLK3N0MmVjVXdJUjBPcVBYcVVVcVJV?=
 =?utf-8?B?VExVamN1UXIycGx5dlc1R0RTdVhkMVFVSjUvTGVMTGVxYWFacEtET1Z0a2g4?=
 =?utf-8?B?THUrTVFQVU02NGluaDUwb3ZzeDdvQ2FJaDZqTUlPa3U0S0hYSFhteGJFME5O?=
 =?utf-8?B?aXdBSnNUU3g5VVlOeUJwMStQTTBVR0hudEtzVmN2NnVpM1hXWm1KNjI2d1Vy?=
 =?utf-8?B?SnA4aHlWOGZsbEtHdFN1UUt1YTZScFVXK3RvOHVMbVVsQzBEdXBGUW94TUFk?=
 =?utf-8?B?QjNibGRUZnhGVDdJN05GMEFGSlhXYWJ0MjN1eFhhTlp6cXFOOFpaTUcxSnRk?=
 =?utf-8?B?dXVEMVlBQzFZMEx0OWMySmZaZURrQmJwdFNKbzc5elNaR2FEVDZZdldibER6?=
 =?utf-8?B?SUNNRDA0MmJVMExoSWRTL2JodlVmZ1hTaEVFSk4xRjZuNll1cUxvV2t2SVdF?=
 =?utf-8?B?c0pUbFJNa3ZDMm1BR2x2djhWY3RMR0QrN0M3KzRtMk44dnFJZElRODFReWQv?=
 =?utf-8?B?TmhtVFNicVRIUXV3WmhzZ2c5TUIrZlFLYmhvRTZ0aW02TGxveTIybThMdm0y?=
 =?utf-8?B?dzFBaktBaDhwbUxSZ01aTmU4RHdsbDBRc0FmYVFUMUR3R2pEa2hQRE5pSmM5?=
 =?utf-8?Q?CMyUmAh2+xHVXGsQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: f3538206-cb30-402c-f796-08de94463fb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 01:37:37.0592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: poZ2b2XHPUzOJESYh4R4e7yLVh7YXpX3f/RJJlT0iWplisl12Dk38brZz85Mq796BbGO9I9Q5VMWEGTK+pr+MpMZOnMq/s6Yc6C+XIQCALKyvSQd77tJwbaZRtUbfV+g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1300
X-Spamd-Result: default: False [4.64 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-275813-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,body];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,pengutronix.de,esmil.dk,gmail.com,vger.kernel.org,lists.infradead.org,starfivetech.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.594];
	TAGGED_RCPT(0.00)[netdev,dt];
	R_DKIM_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn:mid]
X-Rspamd-Queue-Id: 182703A8C79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SGksIEtyenlzenRvZg0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuDQoNCj4gT24gVGh1LCBBcHIg
MDIsIDIwMjYgYXQgMDM6NTU6MThBTSAtMDcwMCwgQ2hhbmdodWFuZyBMaWFuZyB3cm90ZToNCj4g
PiArICBjbG9ja3M6DQo+ID4gKyAgICBpdGVtczoNCj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjog
UGVyaXBoZXJhbC0yIDYwME1Ieg0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBQZXJpcGhlcmFs
LTIgNDAwTUh6DQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IFBlcmlwaGVyYWwtMiAxMjVNSHoN
Cj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogUGVyaXBoZXJhbC0yIEdNQUMyIFJHTUlJIFJYDQo+
ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IFBlcmlwaGVyYWwtMiBHTUFDMiBSTUlJIFJlZmVyZW5j
ZQ0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBQZXJpcGhlcmFsLTIgR01BQzMgU0dNSUkgVFgN
Cj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogUGVyaXBoZXJhbC0yIEdNQUMzIFNHTUlJIFJYDQo+
ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IE1haW4gT3NjaWxsYXRvciAoMjUgTUh6KQ0KPiA+ICsN
Cj4gPiArICBjbG9jay1uYW1lczoNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGNvbnN0
OiBwZXIyXzYwMA0KPiANCj4gRG9lcyBub3QgaGF2ZSBhbnkgbWVhbmluZ2Z1bCBuYW1lIGluIGRh
dGFzaGVldCAvIGNsb2NrIGhpZXJhcmNoeT8NCg0KWWVzLCBzb21lIGNsb2NrcyBhcmUgbmFtZWQg
ZGlyZWN0bHkgYnkgZnJlcXVlbmN5Lg0KDQpJIHdpbGwgdHJ5IHRvIGZpbmQgaWYgdGhlcmUgYXJl
IG90aGVyIG1lYW5pbmdmdWwgbmFtaW5nIG9wdGlvbnMuDQoNCkJlc3QgUmVnYXJkcywNCkNoYW5n
aHVhbmcNCg0K

