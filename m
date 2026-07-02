Return-Path: <netdev+bounces-304275-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FXD+GHDYRmolegsAu9opvQ
	(envelope-from <netdev+bounces-304275-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 23:30:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF2B6FCF81
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 23:30:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onsemi.com header.s=mimecast20250127 header.b=U96LO76x;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304275-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304275-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=onsemi.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94FF5302E41E
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 21:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2343638E8A4;
	Thu,  2 Jul 2026 21:24:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DDD3845AE
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 21:24:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783027443; cv=none; b=hMVN2Ynwre+OzVIhV2KE3uBTyD48U3cDInc1492X9bnpjlIXXNbgxnBlJb0bkuKuI/l3De8WwkebGJW9Q5U2tDQurf2xh7G4GxySOnDGGagTypa3F5V9Ohw1obOKmAXtolaNgOsW+Ep/tl9F9YIl9VTj2lhrs/azqF7c2XzjwwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783027443; c=relaxed/simple;
	bh=7jXDJM1QUEP/DWJdvvppnZaO2IP9MOm/HKIejCGQDeM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=tCaiVg/Ab215QkbfYuo/M5WiBti22F8C6AXsHk97A5PTf0QIsEVWXL2zE0vzKi2fmLZhyb41QrgR3mk1cV9ivTBA6wvOhcpHb8WVANjbk/NuoGKNs2ULAa7QCr2s0PTZ0h3qa7PyfrmDNttuoKClMsKrCp3DPqQ2GCP32Bb0D+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=U96LO76x; arc=none smtp.client-ip=170.10.153.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1783027435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7jXDJM1QUEP/DWJdvvppnZaO2IP9MOm/HKIejCGQDeM=;
	b=U96LO76xEz9VKII9fdFX9Z2hCWmurCyPuDz2XcbIerN+XfoFzcOfPcDLcrzOg5uD6rkvpt
	qSRLhCinUvo3V8rSumoAqlgO+pogtacgGy2zYCjVJQjVcRrq1SZvN7Z9fVrihrKLAb5H3v
	nNEOgVDGSHhEdIpbfoKDvG0yPp+RpNawlfHE8hAhaRD5m0b4iymH7JHmRZaPdTUETYaaxX
	XAEWwKCkA7FK72nY8i6BQMaSXFZvd4KkxY3IMw+Kj/mXvyVAYibHuQUoUTdGAjcbv6CpbF
	sTvQTbBXr+v/6jWmS2pB/i2DtDtiwM9VrcP2AJpI0jX0Gk74xNJYgK4J+5SgHQ==
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012003.outbound.protection.outlook.com [40.107.209.3])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-50-e97GZKnkOtiz9hllbi6IaQ-1; Thu,
 02 Jul 2026 14:23:49 -0700
X-MC-Unique: e97GZKnkOtiz9hllbi6IaQ-1
X-Mimecast-MFC-AGG-ID: e97GZKnkOtiz9hllbi6IaQ_1783027424
Received: from CYYPR02MB9828.namprd02.prod.outlook.com (2603:10b6:930:b8::20)
 by DS0PR02MB9500.namprd02.prod.outlook.com (2603:10b6:8:f1::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.8; Thu, 2 Jul 2026 21:23:39 +0000
Received: from CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca]) by CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca%4]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 21:23:39 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Julian Braha <julianbraha@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Piergiorgio Beruto <Pier.Beruto@onsemi.com>, Heiner Kallweit
	<hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Parthiban Veerasooran
	<parthiban.veerasooran@microchip.com>, Richard Cochran
	<richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Jerry Ray
	<jerry.ray@microchip.com>
Subject: RE: [PATCH net-next v6 12/15] onsemi: s2500: Add driver support for
 TS2500 MAC-PHY
Thread-Topic: [PATCH net-next v6 12/15] onsemi: s2500: Add driver support for
 TS2500 MAC-PHY
Thread-Index: AQHdB+wZw4OihCeBzE+Ub6CPdp8aWLZaol4AgAAfP2A=
Date: Thu, 2 Jul 2026 21:23:39 +0000
Message-ID: <CYYPR02MB9828BFBEE2BC55DF7D4F675183F52@CYYPR02MB9828.namprd02.prod.outlook.com>
References: <20260629-s2500-mac-phy-support-v6-0-18ce79500371@onsemi.com>
 <20260629-s2500-mac-phy-support-v6-12-18ce79500371@onsemi.com>
 <d6a56d05-0c6f-49a5-9281-1194b62ab86e@gmail.com>
In-Reply-To: <d6a56d05-0c6f-49a5-9281-1194b62ab86e@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR02MB9828:EE_|DS0PR02MB9500:EE_
x-ms-office365-filtering-correlation-id: 9aa45b97-0d8c-4733-36c7-08ded8802f62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|22082099003|18002099003|921020|38070700021|11063799006|56012099006|4143699003
x-microsoft-antispam-message-info: HgqipnCuebMURcAUxQtHqPB6MqR86HkA7wjIJS0IGQRjLkLW10HgO5ITajtnVaZOY7o6JgE4e/LuHrJT0feUl85FtTJjC69iLS9TxwJlb6Pd6V0/F6OxJ89Eqvx9UBu/x/2vq7UJE9UvOV3uULuQUEigqn25tJ5WZ1qb1E8ifQiC2dNT5+wK/TxAwAW5N8UpNVirma9GA0v7KEGvQJC+m4agVRrv9FE38Aa0YOUxSOTIPSE57EKDyxs8StmTFY9SMRF0eAQ+cB8WrzKKiB847qdxz/HU29J4dVsKzgH97R5YRW+uBClHNx+WVoSFRLurciRXoUluj3dKcVBvmDRduQhoC22vwuqj8MyaNDLIOX84t8ISzONBHMSLzt5byVPgLJbm2W1oYV0kVYcgj4HqalZ4OGT0j5JmXkVuG2zr25fBal87bGirbcl9QUpmcmwjHyeHxhGCS4orModPhMZRT4DR0CbCNSerHfInLXr4ZvCP47Xk1S3sZfejFOgjZPN8FZldzI+O73sxYHpTG29X1WKQSHzV9ywsIO9XS9vje0F2Si6xmogErm4bXhy2lKhZNUVSM7vvx7baZ8KQyd6yW4XpfkN4IWHU1DLH8hZ5hxwpzj+cvxqGolSwG0UpX7oMCs+O4kieP7WJ/zHULpazhkMX72GTwybrpliBuVPOVCVpSQpuBL0AFjogVzgfW9jHI0QZ5CNlM3h5yDGyLLOE4whafJIWkiYJUqBiFGHlTUE3VDbHUZ+1fh4DT9s78vA/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR02MB9828.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(22082099003)(18002099003)(921020)(38070700021)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWJ4NDNhR0VGU1o1UEx0eVdwdlVNNmVQak5tNmhnTVZFTWZKVi9RL1o4TTJm?=
 =?utf-8?B?aGFoR2Ixb2Nxd3FBZW45MEY4alZqL1k5VG14QmxEa0ZpVVk1OUhnK09ka2Fi?=
 =?utf-8?B?UjY4dkJIMTBnVjY1TjVQRVVPdTZwNEpjQ1p2TDUwblQxR2tpT0xrSk80em1V?=
 =?utf-8?B?a2QwZVN5MDgrcXVlWHJKMHlSUWQzRzNYbmNyQ0xDVlZuSEY3RGNBTW9COFhs?=
 =?utf-8?B?VmM5dlpsOVhKNFNpejZnZkt2blVQcXU4K05TMTNEc3A4OGFoSVlFWC93VTZH?=
 =?utf-8?B?Vm10L3FzMERWMGNEdVBranhGb2FUUTNQZldSSXhIZHZKelQwNG4ydnduRFEy?=
 =?utf-8?B?QkpiNVJEeXRhaExXQ000T2tZWWVUb1VINnl4ck5hVzhOeloybkpyZEgrSlQ1?=
 =?utf-8?B?ZnRHaW1OMVdxNU1LV0xUSzdwdkRFYXpyTGc4WjlWdm1WOFNpRFBDRlRnb0RZ?=
 =?utf-8?B?Wmx2OWFuQkRnMllibXFzaUFtTmdWc3FiZC9TeUtGYTF6MWRrZ0NVbHJkOHl0?=
 =?utf-8?B?dWJzZ3Q4OEEraDJzT09kU2hDcFdpb0doQmdraWc4cDFxcGZ4cktXNjZoSU5X?=
 =?utf-8?B?eC9aR0dGOXUzMnYrSlEyRU0xa0NVUnA0RnlJbkF3aDFheEc1dDFaQ2JROVJ6?=
 =?utf-8?B?U3lxSi9nN2VUcjc2MEEzL0NtRzA5dlVYU2lSSnY1N3JKVks5VTIrMVhoVWp4?=
 =?utf-8?B?eE1DTEtzblh1N3ptczJ0YzFrdGRibU5wemZoWUlMdlVhN2xJZ2wwSUV2SWU0?=
 =?utf-8?B?S0dhN2J3b2F1M0Fwd3ZsaGpMdERyY3J0L0Q3cHlqQUU1ZkVDb0hFbDBnbUNv?=
 =?utf-8?B?cys3MUc1eHpLa3FQSmN6Sm5CdlpmMFZSY1lURlZCalV3WnZyOTJUQW1KU2xE?=
 =?utf-8?B?NjY3elVvREJKS2dieW9kNnNDamU3T1ZEdHpHNGVBQ3hHU2dHNlgyVjJOSTZt?=
 =?utf-8?B?dG95U2xCYkMyWjFPMlkzYmp2Kyt3RVRBT3BUeWZ0dTVaN1RhOWl3NFRjMHYv?=
 =?utf-8?B?bytQZ1JmcmJLWVRXQkpad1crczdKcnZjT2VkYnFhbDFBdFplVzhQTGFJM1VP?=
 =?utf-8?B?dXhBMHRpRUZQdVBYQ2kyTkt0bXQ1WHhSOWQ5YmhzTFhoV1ZrM0JjOUhWeDNW?=
 =?utf-8?B?WGc0b1lRTXpNRE9hYjBDNWpWR2dyMG1SUDh0emNlVU9OcGkrNnlpdU5ZYURp?=
 =?utf-8?B?Ky9sRFVaRGZqRFBFckdHdXZFMTZWZmx1Mkk0S0MzSTdkeWI5QWdTR2JGdnpz?=
 =?utf-8?B?R2t1aFNzWjgvUzFSb3JaSGJWVWpRZnZkMGU2Q3VUYXlBaXRrM0pxMGhUb0Zn?=
 =?utf-8?B?RmE1ZWptU2gzS2EvQXQ3clh1cEpjUEY2U3FXZGZkbWg5Z3c0WGRzTnkwdzVu?=
 =?utf-8?B?aWhSRDlrWFg1SHZieURWb1NRZ3Z0NmlNN2pHYUxjSDFRelB1Q2oydEdJUzA2?=
 =?utf-8?B?Zi9iZ0kzckVPenBQZVhRRDArYVEwMm1yME4xUnpGcHl6K0NackVnUzQ2L1Rk?=
 =?utf-8?B?ZjVIMUtHbVlITDRyTDJWU0tHTUhNN2YwMWp3NDVGSlp3dVQ0bzg4Uk9Scm9p?=
 =?utf-8?B?N1RsWFBuU0tiM0VSOUhSd1VSaFErTWtYbXkzenlEMWJRQmxHK2NZdElVZGI5?=
 =?utf-8?B?U2lPd1lnWndwRDRXcDdNL3RkYkhXUlBNdmxWblpwdmR6MnovM3F3b1hlVnhJ?=
 =?utf-8?B?MjZoRGNBUks4NHNVN1V5ZEEvVWJNeDV5ZDRRUGdCS0dnUWovMUZoQ1FtQVZ1?=
 =?utf-8?B?S25GSHNUZVd2eVIya0tnczFJdU9aejdENFd6enpUbmprcnh1Z3VqcTFYd3RG?=
 =?utf-8?B?ZTBudFlXVDJnb09LcTk4YjF4aW9Sa0tWU3VMVitxVEhVUVVWTzRaeGJPTVZo?=
 =?utf-8?B?REtybzQxd2l1S3dlR2JwR3FwR0JQemI1L29tNzRaRVZ1RFFpNDlIanVUNzhk?=
 =?utf-8?B?bUN1S3BIQ0IwSENielB2d0YrMFZBWVM3UVVOdzRCRDdqZ3lweDNNa3JnV2t4?=
 =?utf-8?B?RUpRb2djbW9rUWJNUC9malpLc29DOGlIYVNzTVFRYnlFYklnK050SUNmQVpm?=
 =?utf-8?B?MVIzTTBCeDVTSWJNTkxiSUcwUTdqOHZjSEU5Q0pUaGQ5TDJybXd3aWgzbEVz?=
 =?utf-8?B?WU9PWWg0WXBxM3BOMkZ1d1pIQUI0VDZPK2tOTnlNVVhsSFVtYkVIbkpxdzZh?=
 =?utf-8?B?TzdHNktlRnFZN1RGS2RJQkxoQ3Jsd1dGVVdzd1JGS0tubEdHbHp1N3BlTUoz?=
 =?utf-8?B?eGFCTkQ5dWRwa0lHYk1hR3J1QWdWcEhRcVp4UC8zTmhxc3NZNC9Fb2pybkVs?=
 =?utf-8?B?SHFJbHZ6aDhsbVdZVERHNlYwbk44R3A5UDcxZDViOHVoYTBPdDZTbitqTDlR?=
 =?utf-8?Q?Qr853f+1r/BmKqWI=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Yu3DV94oVd/fUl3hsnukDP3q9kPVgnjouXKmbCGi5W7KvR8GY8AFz+T7u7TwL6abfXtY94YEe21eelXZa7VMa4eMz0hBSbUdo5mEiCRZ27M4vXeHhTQexmJ4aDA6/H52PCNFHOd0OFt6gJyPdVeOg9GxCjzU34wiY9J8m2yZXNnn9x0sY2nsqTaSMz1lwayKON8Bc+L573ItB9XmvIevUz6Rc5NmUB99n92UYtaSybceTzTBeWxYbzCcjLKNKpnbAhnYmEccEgABIgL5lqtl4V/+hi0vpfnslenq3bnCVE7+/pUYGY1OVnHGpgRKC+0PKcSkTwpBtiPtBePRyEPXcg==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR02MB9828.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa45b97-0d8c-4733-36c7-08ded8802f62
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2026 21:23:39.3867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tq56GtHJUlRYQENPNpTIzX+u+8CyPKcYXC4H91d+8cvH9O748Rvy2gapPKamDgJ3rQEsKL04ToO9BlC9VhxgwojFd70NMqsS7wNmprmeSdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9500
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yhz4xTXRYNJfAB5EN_Sa3qMsS9sozZ4oMjLEZSgOgnA_1783027424
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304275-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:julianbraha@gmail.com,m:andrew@lunn.ch,m:Pier.Beruto@onsemi.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:parthiban.veerasooran@microchip.com,m:richardcochran@gmail.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jerry.ray@microchip.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,onsemi.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,lwn.net,linuxfoundation.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9EF2B6FCF81

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEp1bGlhbiBCcmFoYSA8anVs
aWFuLmJyYWhhQGdtYWlsLmNvbT4gT24gQmVoYWxmIE9mIEp1bGlhbiBCcmFoYQ0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIG5ldC1uZXh0IHY2IDEyLzE1XSBvbnNlbWk6IHMyNTAwOiBBZGQgZHJpdmVy
IHN1cHBvcnQgZm9yIFRTMjUwMCBNQUMtUEhZDQo+IA0KPiA+ICtlbmRpZiAjIE5FVF9WRU5ET1Jf
T05TRU1JDQo+IA0KPiBTMjUwMF9NQUNQSFkgc3RpbGwgaGFzIHRoYXQgZHVwbGljYXRlIGRlcGVu
ZGVuY3kgZnJvbSBiZWluZyBpbnNpZGUgdHdvDQo+IG9mIHRoZXNlOg0KPiAnaWYgTkVUX1ZFTkRP
Ul9PTlNFTUkuLmVuZGlmJw0KPiANCj4gQW5kIEkgYWxyZWFkeSBwb2ludGVkIGl0IG91dCBvbiB2
NToNCg0KU29tZWhvdywgSSBtaXNzZWQgeW91ciBmZWVkYmFjay4gU29ycnkgYWJvdXQgdGhhdC4g
V2lsbCByZW1vdmUgdGhlIGR1cGxpY2F0aW9uLg0KKEFsc28gd2lsbCBnbyBvdmVyIGFsbCB0aGUg
cmVzcG9uc2VzIHRvIHNlZSBpZiBJIG1pc3NlZCBhbnl0aGluZyBlbHNlKQ0KDQoNCj4gOigNCj4g
DQo+IC0gSnVsaWFuIEJyYWhhDQoNCg==


