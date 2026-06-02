Return-Path: <netdev+bounces-294276-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jBCqKVb7HmpxbgAAu9opvQ
	(envelope-from <netdev+bounces-294276-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 17:48:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1F062FF14
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 17:48:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onsemi.com header.s=mimecast20250127 header.b=F1AjLGyE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294276-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294276-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=onsemi.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85DA03048DC9
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 15:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C72D3EB809;
	Tue,  2 Jun 2026 15:37:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908913ED3A9
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 15:37:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780414643; cv=none; b=Ju6PA8I74JkQM/ULQe2MfFnDFqd98jRO2FopD1cGDnt93IR3M8RCUh3kyVN6BJrh9N45UudbAWauS8o3qcT/flrTglKK3LAKPonWWc6kT4XVM1tjpbXYkX08rCerKLhksvW0Mc5UENlKr4qis1KeYH4kZblsJIwCjNLzqfYqDsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780414643; c=relaxed/simple;
	bh=bqp/VJqKBP+rNJ6vz9b+Z9ceC38uEichhnHSGJqe+n4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=VBGfH/6OqmzZ4aTZ42YExVLTbB8GYz1H8AgpuZMxEv06Zb2JKKXWyzND2d0s2MtU1wLRDJQSRDluLszQwKi1C78UGsKpnqWGnVNO6EEA6FEhwtdGqma8tbqDCxo1YRT7GymcPsi80Wkf6vYG3YGqkf7DOt8Pi32tf33r4kDptQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=F1AjLGyE; arc=none smtp.client-ip=170.10.153.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1780414641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bqp/VJqKBP+rNJ6vz9b+Z9ceC38uEichhnHSGJqe+n4=;
	b=F1AjLGyEtknVtKp8H7B/qztpTVwBBA6h/9Oi2aneOssmiNaoVYVQZv+dybtD2YZ+QdFp0T
	CVY2ZASSiuvyICqM9yC5NXmH0wAI+jE2izHTEaBdRBmj655uPmXxp6Y84HcpXpYeEzwMNj
	kSAFAFRpZlPgBnCIMnnHk3PLxw4w20gjiN/xVJjOvBcPA93PgkAGEdQeq3it57Es83fvIR
	Vfoj4mMsEtAaRnWwUcApZZ9qf6N/xpgVgUfcALiRhDQ8YUJ03dpw1XvoJI8e4LlA7l5kBx
	KuliOBidUCBq7pIL1Z61tRvIBLxSUxidG3sSZU6hBy6ptKzb1uLYNa7NADDUkw==
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013031.outbound.protection.outlook.com
 [40.93.196.31]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-72-bJ7VUFLTOuO1Lg_OudT8HQ-1; Tue, 02 Jun 2026 08:37:17 -0700
X-MC-Unique: bJ7VUFLTOuO1Lg_OudT8HQ-1
X-Mimecast-MFC-AGG-ID: bJ7VUFLTOuO1Lg_OudT8HQ_1780414630
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by DSVPR02MB11961.namprd02.prod.outlook.com (2603:10b6:8:41e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 15:37:06 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 15:37:06 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: David Laight <david.laight.linux@gmail.com>, Andrew Lunn <andrew@lunn.ch>
CC: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"parthiban.veerasooran@microchip.com" <parthiban.veerasooran@microchip.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v3 08/14] net: ethernet: oa_tc6: Remove FCS size
 in RX frame
Thread-Topic: [PATCH net-next v3 08/14] net: ethernet: oa_tc6: Remove FCS size
 in RX frame
Thread-Index: AdzvmRIV9Yc6XZqaQq2ja4j42ca11ABc8QiAAGMRVAAAArOLIA==
Date: Tue, 2 Jun 2026 15:37:06 +0000
Message-ID: <CY8PR02MB9249B26D4B4344064A582A3C83122@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <CY8PR02MB9249644F900471DB8417134683162@CY8PR02MB9249.namprd02.prod.outlook.com>
	<cf87ad90-6ba4-4132-a1eb-beedd796c168@lunn.ch>
 <20260602150712.5b28d58b@pumpkin>
In-Reply-To: <20260602150712.5b28d58b@pumpkin>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|DSVPR02MB11961:EE_
x-ms-office365-filtering-correlation-id: 4cd6f72e-3ff5-481b-a84d-08dec0bccd7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|5023799004|3023799007|4143699003|11063799006|56012099006|22082099003|18002099003|38070700021
x-microsoft-antispam-message-info: fY7e0cDuERw5jOz8BbHf2ZKb/E/+bSeSCyOPZ9jqdpgRtummecbjhx25lyPFtuwXztTV+QMTW9ftrlknTs6KuB34n4UPOpbZotTNnCSEfiR82Fej97aw2J7DVt0NM7bg3WyIdS1B+nGDxyk0O3HDn90SruNWvZ+gtfLj3ymXwIJS69PRLhewYah7PGsZsr9l3Yq5MmAVCXC7vjTi3zm68xPAr/RQSmxfw1LVNl74C0urFfYVOvKpmh+iDGwyfceMsca4h6g4wItoe35UlrW1v2xlf6Pdn1J0dXJqTQqXlp0JhUcWkMeHP/Tbgq7MYeH+2n4aOfw2EDgPty/Zj0eNJyxy8gX6bf/sojfPqr1aVFr5ge7g79Jw0tKbkxqbE780nNYyk4EqklHfzi6DMLCKEmvO3XObLvtEzTsTRQpmreBpKhzAa+qw3O80vyw+5yG0CBMDtGKoMpCkblJYufgVFdgxNQsfefRlGhvHuDk95a9nBQcrO1GZ9RBPfvddg96y7wPM8qC2k7km7wi8Pgta8Vu+XmIPQnwerQneseAT/XyVnfpjmVb7gPUGsxiRDtMlfFlSO908+Chs8nQzSkZXYojAO8EGLad5soSr+HXyugVIe3RzOhHknilc8o/8xeHbOtCpff27k3kI9oxRbIyZ3KKvEqGf436PRe0j0sksmpPN12doKdc0wR83G0da219z5Vul8mCJn1d8kFaUK8NntPGcB5Yfigt2pgp2Gsy//04wnN8LXgZo+oOX8nColRw2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(5023799004)(3023799007)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nk5vRHo5c1c4bk9wcFNxOEREMXBjbk1CZlBvWmFHMEZydWlPRjNSSGo4NVJF?=
 =?utf-8?B?V1NQVlc0dUNPNTM5ZDA1blp5ZmhhNUJrMG1WUWVSdWkvZmwvNnJ3Y0NzNHFI?=
 =?utf-8?B?TndHN1ZCTS9LR0xndEpXVzY1c3NCQ3huaUtDVVFoWnpQejVVNHd1R2VwSDBZ?=
 =?utf-8?B?eHVaVTg2UXQ0cmtncVFKeVluRUhGNTZjaTlxVnliRU9CMmtNRWdaMTB5aWox?=
 =?utf-8?B?em9DK3hqdDJwUWFVWHVmUm10SU1qNm4vNTdLRDhyNEtmMVNENzlPWXMyRGZU?=
 =?utf-8?B?c3d4b1luNFgwaVdoR0FwT3prMWNlZjV5dWZ4M09oa3hHUzY3ZEhuMXQxdWd4?=
 =?utf-8?B?WDVKMHlOcFVXemlTNmhXTWFyYmhPNEtNWEpCOWZ5RzhaY2hqbTE1SE00cFUy?=
 =?utf-8?B?cjZ6dTl0N2lLSnNlSWNSSUVrbzVGNlFwSFN1cTBGYU03RXN5Y0U2b0EydFRG?=
 =?utf-8?B?Qjcwdnd1OUxUTCtLWFdWT2JrYUdkM0I3ZGNWNm1TUm1vZ3MyOURYOE5jQ2RO?=
 =?utf-8?B?V0NydDZ4Rzk5Qk1RUmNRamRwTmRZZWdjSm9OcE1RMmM0SGRseXc1NVh5clJZ?=
 =?utf-8?B?elJPVW1aVExDNllmbC9nWnBtMjAxem5qb2hvWUdtVlllV3BjY2VUcXZIQ05P?=
 =?utf-8?B?dklHMHFiZjdWU0o0NFArckxjWE1OYjhseWhSWm5BN0w3d3BBeXdhUXI2anM3?=
 =?utf-8?B?cGxKeWdaQ0RmNHhRS2EvR3RVK3h5a1RUNWk4T2JPdGc1MUdxZlA4S3dnTzI3?=
 =?utf-8?B?N2VzR0FvRFBTRjhGcmpiSWV4cVQ5MFR4ZlpTYnNrcWY3T3dsZDg2WFIvLytx?=
 =?utf-8?B?SENJRTU2OVp6VzNiOUgwRGkwR3pPNkxqcnFIaWgvYlBhVzdPSTlqaGhQOUk4?=
 =?utf-8?B?bXVMWTJNajVFOFliZTlBTHVGZ2hyRjE3U3EzWkxyRWpyQUhVNXdXdjhkaFVM?=
 =?utf-8?B?YVdvWmZNbFpwTFo5M3ZZL01jUGRQZzFPYzF5ZGlTZDh2RlpiWUViZVhoMGRX?=
 =?utf-8?B?UnRqVXV1WjNTWlp6Vi9hay9KblBhUm1kSFFtWm51aTVHa2RwcEVUMXA2VzFI?=
 =?utf-8?B?b1NvR0RiQjNXSWRrMkRncnNhN3ZGMHRlNjFBQk1SY2xCeFJpbDVDekRUY3Ew?=
 =?utf-8?B?STZnL1RtMW1KN3UwN2Yya01GMDJlQUE1VE40NXNRN2owWXpsbkpwYkc0N3px?=
 =?utf-8?B?UldJU1dqUm9RZVFkcFo1WEYycTQ0R25WZDlZWkQvaSt0dStueSs1a0pKQTky?=
 =?utf-8?B?a1ViZDdSbVdmM2lIaWRxM281UUloblJNdTFvWkNMNGFMMWthTFdZaXJqaTNG?=
 =?utf-8?B?RjBROUcrRE5XWWJndlcvWnlEUXE1dzB1WVVXTGsvRi9Qb1JMbXk1K1MvaVMv?=
 =?utf-8?B?VG9ueDB4MU9jSGpYSWxuZmlSVUJvNE1GNVVqbG8rd2ZIdVZVMldKSG1QdWlm?=
 =?utf-8?B?ZkpIZHpEZndMS1IvTnB1K1NOTlZLS0d5eWNrSEw2eHhCUWRkdzRwcFd2QlVP?=
 =?utf-8?B?em5YNFlQQlNnSDRqZUtGZzJTOStXQlNQanpLV3NYdkxtYUNRQVJoMGovSkk3?=
 =?utf-8?B?Y24rRWRaenRvc2VZRFhRSG0zU0l4Yk1OSVlsZlRYb3lyT1ptcjJoZE1hbWRs?=
 =?utf-8?B?blp5ekVnUmZuTkFDMFdiaGFGR3lqa1ZkMHQ5dytQNVBOeERnbmxiWEN3Q05k?=
 =?utf-8?B?RDBXVm5xdkp3Wit2aEZLMWRvR1B2b0YrUFRWK3BybE9vMFI3V2hDc0tMb3JH?=
 =?utf-8?B?M0I0b3NuOU4zV3RKRVliUDlOdDlSa090aUhFZk9lZ05rdG9lU0JGZEQxa29H?=
 =?utf-8?B?VHhxbHk3bm5kNTNsTkNlbWpCaXVaT3pjQnNjNjdNZllmVVRGMWwyTVE5TnlT?=
 =?utf-8?B?NVdRSUMvNWZrVTR3M3RaUnpZaW9PSHJVVnpUS1dlQXlvMTJ0QnBtWlZsSE1S?=
 =?utf-8?B?SkhzR3dMdHRxT3ZSNUdJSWo5YUZNc0haSjQ5UVRYYldjVEEwVkZUT1JXUWxU?=
 =?utf-8?B?UE1wQU1tUGhwSFpicXpsZlI5SEs2MmRRSkU3cjByMThpSkZ5OU5vSnBjZzZp?=
 =?utf-8?B?YVp3dCttR3dLZXdNSE9jN0lpVUpVakU0R1J1cUQ1QkgzNDFrMkhQbVNMWnlr?=
 =?utf-8?B?cTlGY1FURVIxMHRHbVFtU3QvQzRCN0hoY1A5VUY5TTQxQUwzSXdYZTlDWWJh?=
 =?utf-8?B?U2NLNS9JMkg0M0xwckEwQ3ZHK0xKeFhUTHRVa1JVcForNFRvS2QzOEdHMzlz?=
 =?utf-8?B?WFM4elhCTi9IYkNhSDFVdDZXZ2pjSXFOYVI3S3dVejFtYVZ6WVljTWtsVW5F?=
 =?utf-8?B?UkxRM0hTTE5DbFZVTXdYMWtGK2hka1FKM0U1MFlCaUw5VUxWTE8rS1psL1lJ?=
 =?utf-8?Q?EaaQv7cTgv+zySDI=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YqWt873+iICxQfyuRVL8OIZf/GNqZTsQoWTVZCQC/S7Snufsver9JWCpi/IFMTDNAPkZkWKntgz+QzICM80MuSz4TCkC83r5ErmY6W3RruoRC3xsLA34QDOitodHXhyKtU+rs1kvh7co27YNqn9QnbcHIx+HHloFxPNtpQJrB2C7MkiPe+c1E+vqho9+rUkT14vIPUmD17APO1V3LSwc6WyP6uo/M3ivFy2Tlb1Z788KLWqqTIN/MRmC3TqdkM++WdS/NRZVkVL4haBAUEIGQWKR1RbMcnlvtIql7quAeT71E1dMZKzLZNZWPATyE9EPSqyiE33cnixMABNJ5+5lLA==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd6f72e-3ff5-481b-a84d-08dec0bccd7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 15:37:06.6560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vdmVTyd6EwEnnJPM4xIvgXqakD8Z5Ms/IKZsU1cF1ceNlhE9dnJelrLGtuHXPwd1xh8KbOx457CQuqgwHgDA7bjm5GclHoE+hAvKfrUR9Ts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR02MB11961
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: i4Sh1zLl9355li3Hgp1MQrDJeO_oKHTrfi9bzmudEGE_1780414630
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294276-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:andrew@lunn.ch,m:Pier.Beruto@onsemi.com,m:parthiban.veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[onsemi.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[CY8PR02MB9249.namprd02.prod.outlook.com:mid,vger.kernel.org:from_smtp,onsemi.com:from_mime,onsemi.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ED1F062FF14

PiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldC1uZXh0IHYzIDA4LzE0XSBuZXQ6IGV0aGVybmV0OiBv
YV90YzY6IFJlbW92ZSBGQ1Mgc2l6ZSBpbiBSWA0KPiBmcmFtZQ0KPiANCj4gDQpbLi5dDQoNCiAN
Cj4gDQo+IE1vcmUgb2YgYSBxdWVzdGlvbiBpcyB3aHkgcmVxdWVzdCB0aGUgTUFDIGFwcGVuZCB0
aGUgRkNTIGF0IGFsbC4NCj4gWW91IGNhbiB1c2UgaXQgZm9yIGVycm9yIGNvcnJlY3Rpb24gLSBi
dXQgbm8gb25lIGV2ZXJ5IGRvZXMuDQo+IChBIDJrIGZyYW1lIGhhcyAzMi0xND0xOCBjcmMgYml0
cyBmb3IgZWFjaCBiaXQgb2Zmc2V0IHdoaWNoIG1lYW5zDQo+IHlvdSBoYXZlIGFuICdhdmVyYWdl
IGNoYW5jZScgb2YgZmluZGluZyBhbiAxOGJpdCBlcnJvciBidXJzdCB0aGF0DQo+IHdpbGwgZml4
IGV2ZXJ5IGNyYyBlcnJvci4gSWYgeW91IGZpbmQgYW4gOGJpdCBidXJzdCBlcnJvciB0aGF0IG1h
dGNoZXMNCj4gdGhlIGNyYyBlcnJvciB0aGVyZSBpcyBhIHJlYXNvbmFibGUgY2hhbmNlIGl0IGlz
IHdoYXQgY2F1c2VkIHRoZSBlcnJvci4NCj4gU2luZ2xlIGVycm9yIGJ1cnN0cyBhcmUgdGhlIG1v
c3QgbGlrZWx5IGVycm9ycyBhbmQgZWFzeSB0byBsb2NhdGUuKQ0KDQpNeSB1bmRlcnN0YW5kaW5n
IGlzIHRoYXQgaW4gVFggc2lkZSwgTUFDIHdpbGwgcGFkIEZDUyBhdXRvbWF0aWNhbGx5LiBSWCBz
aWRlLCBNQUMgbWF5IG9yIG1heSBub3Qgc3RyaXAgRkNTDQpiZWZvcmUgcGFzc2luZyB0byB0aGUg
aG9zdC4gSSBiZWxpZXZlIG91ciBNQUMgZG9lc24ndCBzdHJpcCBGQ1MgaW4gUlggc2lkZS4NCg0K
SGVyZSBpcyB3aGF0IE9QRU4gQWxsaWFuY2UgMTBCQVNFLVQxeCBNQUMtUEhZIFNlcmlhbCBJbnRl
cmZhY2Ugc3BlY2lmaWNhdGlvbiBzYXlzDQoNCjcuMyBEYXRhIFRyYW5zYWN0aW9uIFByb3RvY29s
IGZvciBFdGhlcm5ldCBGcmFtZXMgDQpbLi5dDQpFdGhlcm5ldCBmcmFtZXMgYXJlIHR5cGljYWxs
eSB0cmFuc2ZlcnJlZCBmcm9tIHRoZSBTUEkgaG9zdCB0byB0aGUgTUFDLVBIWSB3aXRob3V0IGFu
eSBwYWRkaW5nIG9yIGZyYW1lIA0KY2hlY2sgc2VxdWVuY2UgKEZDUykuIFRoZSBNQUMgd2lsbCBh
dXRvbWF0aWNhbGx5IHBhZCB0aGUgRXRoZXJuZXQgZnJhbWUgdG8gdGhlIG1pbmltdW0gZnJhbWUg
c2l6ZSBvZiA2NCANCmJ5dGVzIGFuZCBhcHBlbmQgYSBjb21wdXRlZCBGQ1MNClsuLl0NClNpbWls
YXJseSwgdGhlIE1BQy1QSFkgd2lsbCB0eXBpY2FsbHkgc3RyaXAgdGhlIEZDUyBmcm9tIHJlY2Vp
dmVkIEV0aGVybmV0IGZyYW1lcyBwcmlvciB0byB0cmFuc2ZlciB0byB0aGUgU1BJIA0KaG9zdC4g
SG93ZXZlciwgdGhlIEV0aGVybmV0IHNwZWNpZmljYXRpb24gYWxsb3dzIHRoZSBvcHRpb24gZm9y
IHRoZSBFdGhlcm5ldCBmcmFtZSB0byBiZSB0cmFuc2ZlcnJlZCB0byB0aGUgDQpNQUMgY2xpZW50
IHdpdGggdGhlIEZDUy4NCg0KDQo+IA0KPiAtLSBEYXZpZA0KPiANCj4gPg0KPiA+IEFuZHJldw0K
PiA+DQoNCg==


