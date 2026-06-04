Return-Path: <netdev+bounces-295292-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7H+fAReWIWqkJQEAu9opvQ
	(envelope-from <netdev+bounces-295292-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 17:13:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FDA64148D
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 17:13:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onsemi.com header.s=mimecast20250127 header.b=bQ+D3ouh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295292-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295292-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=onsemi.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB21930097CD
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 14:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575A92F9D98;
	Thu,  4 Jun 2026 14:51:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C722624E4C6
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 14:51:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780584692; cv=none; b=HtEzd6qUGK1xUQQVZT0Y5Pn446u2jO+PjmiDK8kkANJImjIH8XYRvLe8M673kDJtNfsYaBt0Zmv0iwQPOOYXpwy0dmfsG9/nzMMy/2ujKAxmbuhfW7IR2YPVJNsc+ss9SicIviD+8x/TJAyTUqO+3IpainoKefHbjwEgvmlbAG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780584692; c=relaxed/simple;
	bh=XQDvGuBCKWLLr6nccJZYBVXdSy0v/+LJTT+/47lKA18=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Rf9TpWetYSRGzJH0+u74B+p/AStWyCAbSpTYowrQD42SSz5aPwOn8IDngR1aomra7Ne7fRQ2jwcBSq9RjIwrcgWj7wItd7SjIAeE/eqSOflg05qhM2qoEgPlgAN2mO6/wJrhVuXj0OixoXa5bICToWOwOaJq40g/WbfjrNt2D64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=bQ+D3ouh; arc=none smtp.client-ip=170.10.153.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1780584684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XQDvGuBCKWLLr6nccJZYBVXdSy0v/+LJTT+/47lKA18=;
	b=bQ+D3ouhm8fhPGrN4+wy+X+w+rNOKyWuRDMRGL+R6sOYV7eCzbg6dxCscwP/eLatP2iiuT
	QJ2V/3uNChTADByZVWBfUJjgWWEpQb7lkTofWOuxT4kOE9rdVFRh+u6sdw5sTGl5YBjksv
	3EC56JlFScfWyNa3gomOyz0MjBC1CENtIMIs/YGP9ofOWhrktNfi2igBG+ZowYbhH5Ijsr
	7aQugZAxUJUtvByyFbSfD0j2oAsZuYmO9CmqToUEvNIXhoeZ/Ww8wW9i2UIxyKVxAcNL2e
	yADiTrNFGn0F39cLGe+Jv8MQgZ20MrT2m3e9aXCVYkL292VLXSRzTrzfVpCN4Q==
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011024.outbound.protection.outlook.com [52.101.62.24])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-28-3QnhUujYPsSPpH5Q8kyTOQ-1; Thu,
 04 Jun 2026 07:51:20 -0700
X-MC-Unique: 3QnhUujYPsSPpH5Q8kyTOQ-1
X-Mimecast-MFC-AGG-ID: 3QnhUujYPsSPpH5Q8kyTOQ_1780584676
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by BY5PR02MB6689.namprd02.prod.outlook.com (2603:10b6:a03:20f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 14:51:09 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 14:51:09 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Paolo Abeni <pabeni@redhat.com>, Parthiban Veerasooran
	<parthiban.veerasooran@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: Piergiorgio Beruto <Pier.Beruto@onsemi.com>, Andrew Lunn <andrew@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Conor Dooley
	<conor.dooley@microchip.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH net v3 0/2] Resubmitting with cover-letter and threaded
 patch series.
Thread-Topic: [PATCH net v3 0/2] Resubmitting with cover-letter and threaded
 patch series.
Thread-Index: AQHc8eDJSLy74ngCnk2lTBbpvAesgLYuZacAgAAZeCA=
Date: Thu, 4 Jun 2026 14:51:09 +0000
Message-ID: <CY8PR02MB92490D1BEFDB7DB856F9843783102@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <20260601-level-trigger-v3-0-da73e7010532@onsemi.com>
 <42052da1-2d33-4023-b383-482006fcb628@redhat.com>
In-Reply-To: <42052da1-2d33-4023-b383-482006fcb628@redhat.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|BY5PR02MB6689:EE_
x-ms-office365-filtering-correlation-id: be6f5704-0ab7-4f0d-3705-08dec248b6cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014|56012099006|4143699003|11063799006|22082099003|38070700021|18002099003
x-microsoft-antispam-message-info: wohVayzYtjTtAM4U50tNs8wC1Nl335EmiZAzdqD3ZeDmwgzh5gTxkAPD/0q1/xyzWIva3F6CVv3qgbzflrB66+svGe0JYFnv9as/Flsyc0cQjb7bOaulB/hZJruH2gqJASkQ1O8g684EYqIXWSzY/iXi5Ky/M0gxUSb8NUQZq7GQVlrbzHtdB0Jx7JzNkw8ur9qRGy8shRdWxZdr+N8fY+o1jlzlOYWUFXZ+o1xCpDFlThMW7JGx996QldRnSWkJmP4wc49V5RmDkFUrWFaiK/C+MU/A5FxNzciv5G21NhEOOrVbhPHj0WR45Wd34RhipkI/L/v+H1Y4hh6A/0fb6m/3oO7g5ZJQxhh2j+WagcIqModWNIzh4pUeW1DV936l6TJ0bet/DQXW0O1OqHzjO+/lWguLGKu0HeHxO+eFpqlJwOJ5crjh+XwLBRaDhxSqoAKW4lEty2T34MhGdPR1sK92FUy+MwDjr3dOdpzGg4k4i+n6PRcwLkfs/VxLRnGO9Lm5oN6Tc+ILESm6ispiZMTN8v+meKdWmi/erIlznlXofTWwlQRyDH3Sx3SMMEBiMgpcJOqbnPbbb7XwzFSGlE9/m0rx5BjYwofg3iG5UY/uLVwKRB2xWL8PiUboleRJZxe/m5fceZzL5bN6dI9thXFJAPHzOPNqYu7aSbYCk+l4x3qdTVHV7nwrvWHiTpFhaOQA24yjUQMxDFhYtEiHw4cLAoJpsJT2DiwtZ1F4tXtUQ/QEfyqaMz2TBdFmAkeZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(56012099006)(4143699003)(11063799006)(22082099003)(38070700021)(18002099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlhMWVMvbkMyTFl5VHpJSUYwRkFLOVI5QXduV0Z3eE54L0hIQ3dOMlMyMXo1?=
 =?utf-8?B?cmUwYWYvTHFHSGlINWhXRWMySk5OMnhXSlQ0cHdNU3BJUU5sMUFCTmdrRFJo?=
 =?utf-8?B?ZGRQTFh1cU5nUWZTc1NyN3NQRFFhSDdoejF1Szk4cm1HUE9LaEp1Tnd0VUZW?=
 =?utf-8?B?NHJzdWJqN1kwUWNzT3VLTE5yaHRGN2g3bGFMRDBrQzBXaGJIM1M4bGVIUkxU?=
 =?utf-8?B?YlJCak1EY2daa1NjVDN4NHd5V0tSS09RNlJHSjJDMWxUZEtWa0ZmTVFoeSs1?=
 =?utf-8?B?Rk1KTWhKNzZPS0loRmh4Qm9JZm83VXNsM3BqTnl6QnNkSEJyTHpyc0NoQ1ND?=
 =?utf-8?B?ZWNvMVd3YVByVVd1c2lhb3dLcExQTno4TXhIekwrK2cvMCtZT0I2QklUVjZ6?=
 =?utf-8?B?ZFY3MU9uVThqMlg3MnlVQ05lUzNEViswUGlCOWpySzh5UGtTWWJqR1BsMXJ1?=
 =?utf-8?B?NnNacTVGUFVmU3c4M3JBcEVncHhNVTMrSzlGcWd3RFI3Mmw3UjlzeVFhRkdU?=
 =?utf-8?B?b0JhamZBVWVmdEE3M3RMd1F6dWh1dnQ2TS91TkRXOUlSKzhkSGVrQ1kya08x?=
 =?utf-8?B?R2NrVUl6bXUvR3lOWkxjZVFZQzJJMXNnTVNGS1ZNZzE4WWRZTWh5TTQ4WVhR?=
 =?utf-8?B?N1FKNVFnakRtczl3UGpWeC9ueEZHT05wbE1jcFFCZDMyTmlFS3dzczQ5VkJu?=
 =?utf-8?B?YnFyaWVDK21qVC8zMXYxUE4xUVREWGRWcHkzaCtNS3pkaFRiNWJ3OThNOGpP?=
 =?utf-8?B?UnZQYzZtdEh3NVVPdlYwSW05WE14Ly9LaU5DdE5yZExJUlJnTW9jMU9JaDIz?=
 =?utf-8?B?SVFpQUNYWEpnaWFsSFc1bkZGSjg1Q2s5WWNZK1BFWm5pbTZqZTY5MzFxTmJP?=
 =?utf-8?B?OHd3dDVtNFJCQTRiYTJHZTkwbHpDUnE2Nlk2VzJNTlNoYk4zZENiMnlDdnBx?=
 =?utf-8?B?VzVFb3ozY2JDR1RPYVlBdWNqZ3kzeDY0VllxbWlTVlNOakxSbzR4UkFnaHNZ?=
 =?utf-8?B?RzZaeEp6UWVRTUVtY2cvMmh6Ukh6c1NTM2FONFRUaDlXWVhhZEhaVVNnQWlK?=
 =?utf-8?B?NWdOWGlrR1lxUFFuelFVTUlVS1djTXNtMFZhNk82TnFEMm9iaEIxcndQWnFD?=
 =?utf-8?B?L3BSVXI2N3MybWFKazREclJ5NkI4cDZNb1piL0ZxdWpOcHBpbERBYmRUdGV6?=
 =?utf-8?B?N3J6bWs2RTNNNmhVaXpaM3h1MmZhQm1MYnA0VkM2Q1JROThnang3QnRGRS9M?=
 =?utf-8?B?NEhIWWRVNnAzeGZweGl3bnE0ck9LRS9kK2o2YVBTbnRhZnY0b1NJV1AvVFAz?=
 =?utf-8?B?L2xJRmhlM1VaTWVoVW5pT05JdFloM1RJTEwydVQ3L2dLRG05YittRVduRW9J?=
 =?utf-8?B?NEs0WjdreUd2WmcrQzBlbUpRNG5GSUZBS3JoWWVLU3cwRzd1cDJ5ZHpSM0RB?=
 =?utf-8?B?SFREOC9GNUxOaGhac0R5dTNTOE5sdkFub2xZTS9SaVBIZVJwZ2VKemJiaUJn?=
 =?utf-8?B?ckprOHdOT3hURWJOMFYzdXdpWXBRbmJzTU10V2F2TWJHbXIyNmlSYXdNKzcr?=
 =?utf-8?B?cnAvVHRVa2pPT2FXVklJcTFrZXJia0h1MThheXJLY0pFbmQrcXBVMWhIOFFo?=
 =?utf-8?B?TElGN3QzSVdwVlZsOURGVzNqZ0NBMjltUHYybWRVNm9NSVkweC9RYXJ0ZEpB?=
 =?utf-8?B?WU4vb2VJQ25HUzRkZ1lsN0tqaHVVR2ZSaytQODJ6S1lKYXpzbHFnZDM1Rk5J?=
 =?utf-8?B?dG9sSWRtbU5JWm94NWZSVHNTUHlDTnljYlAvWHNzSWF1T1ptL2pzRXFGZWZ0?=
 =?utf-8?B?WU1paWY4UEs5UGdpazlSQUdyQnBvTWExditzZXA4RWVOWGcvWEFNMjd4cDgz?=
 =?utf-8?B?UmpWM1B6WjdQcXBpS3dPSU5sQ2laWkc2anhlY01taDF1UTNlbi95NTEwVWhj?=
 =?utf-8?B?VVpKUjgxOXhxQ1I4cFpENXBSMFJpMGIxbjZ6YjBlWmZiQ3Nldnl4d2hmRUFH?=
 =?utf-8?B?WVJHbW4yaVlsd3BTTm9sWW9hdUFSRDFyaVZhUG9KUXJ3bzJKdUxuOW5EZGUz?=
 =?utf-8?B?bEZINGh5T1R3b2RBc1lhNlYranVrY0V1R0hGWExnaUo2UVhRVmJvUnlhZFox?=
 =?utf-8?B?enNmb1M3bEVwdkxPZ2VENzhJNkI5VzNIbEFHUGZacEZGTG94clpWNEZHeE4r?=
 =?utf-8?B?dU5tQU5WRkhNcklqQVVQUGVJbVlLbjZLS3N0M3pwOVQvQ1JGNHpVZk1PMHRU?=
 =?utf-8?B?ZGRZdXhBZ3B4ekpwcDZRc3VOMDFkZVp6U1l5QnhFYldPamxBc3FMRWlzTitB?=
 =?utf-8?B?YVdxTE1UbVl0SXB4MEJTMFVRdFRXSjdFTTZjQitaZXpTVW53QUNtSXNhVUZX?=
 =?utf-8?Q?iIOXT72/8EGUMumY=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: T0pHZIlYC7QPxuqKGjAYo8ZjF5pqdwagVogppVt8FCv1f3HhX2ProLLB7D1lDn9nm5VJs5fMuVhcrXsJN02gUNe84lVQlrevYRX3nt3c97x/K/4GA8BZltvu60IkW+si9qGxYvx/B668fic7+V8F8Y/eqoYjqAhvgIJQFfhtQb/Ag0pns+aJJX4RpAfxxnMhpEXdaNhd3UMZJW0STzpBe5sfoNSNsauCoJLtMO9b9PCnyvHtXFMBdJTAL3/PzXFaK5Cl6Nxb2kVXrMVXApP7ImmS43tB7GljzzKtWv0qItDNMsg4pVhGjgM1YlxZOWhXB/nZ/AdtCeC5heUYzKVoRA==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be6f5704-0ab7-4f0d-3705-08dec248b6cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 14:51:09.3243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PBpqKMLKo/SoM1UlD+jacWIxEYajLnm4DeX+TFPcZW+WWUG2YqVV0pJhfaLa2sYPx1rPRCL70U0QK2dHGkeEhw29Oll17syy5X7nYVPukRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6689
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7FCd1o56JITgdO1SvQz80KYmQ6ww0xdDJn2LVjnnF1M_1780584676
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
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295292-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:parthiban.veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Pier.Beruto@onsemi.com,m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:conor.dooley@microchip.com,m:devicetree@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,CY8PR02MB9249.namprd02.prod.outlook.com:mid,vger.kernel.org:from_smtp,onsemi.com:dkim,onsemi.com:from_mime,onsemi.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 52FDA64148D

PiA+DQo+ID4gTWFpbnRhaW5lciBmb3IgdGhpcyBkcml2ZXIgaXMgYWxyZWFkeSBpbmZvcm1lZCBh
bmQgYXdhcmUgb2YgdGhlc2UNCj4gPiBjaGFuZ2VzLiBUZXN0aW5nIGZvciB0aGVzZSBjaGFuZ2Vz
IHdhcyBkb25lIGluIG9uc2VtaSdzIHNldHVwIGFuZA0KPiA+IGZvdW5kIHRvIGJlIHdvcmtpbmcu
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTZWx2YW1hbmkgUmFqYWdvcGFsIDxTZWx2YW1hbmku
UmFqYWdvcGFsQG9uc2VtaS5jb20+DQo+IA0KPiBOb3RlIGZvciBmdXR1cmUgc3VibWlzc2lvbnM6
IHRoZSBjb3ZlciBsZXR0ZXIgc3ViaiBtdXN0IHJlZmVyIHRvIHRoZQ0KPiBzZXJpZXMgY29udGVu
dCwgYW5kIG5vdCB0byBjaGFuZ2VzIGZyb20gdGhlIHByZXZpb3VzIHJldmlzaW9uLg0KDQpVbmRl
cnN0b29kLiBUaGFua3MuDQoNCj4gDQo+IC9QDQoNCg==


