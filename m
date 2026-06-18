Return-Path: <netdev+bounces-300301-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V7zyJ4ZXM2qE/gUAu9opvQ
	(envelope-from <netdev+bounces-300301-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 04:27:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB35269D214
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 04:27:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=s+EXdzfL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300301-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300301-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FBE5300DDE8
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 02:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC81230E82E;
	Thu, 18 Jun 2026 02:27:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010007.outbound.protection.outlook.com [40.93.198.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66DA6FC5;
	Thu, 18 Jun 2026 02:27:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781749635; cv=fail; b=uAayGucuw3NBIkrMTo2O6+7mapT4bxrF0390EM4ZCw9MF2yGODIMLtuLZNBDNj4+YAcRERhkC0LZ4VhOnWcbzrQYNHm/qcBPxT294BZX+I+HOIcPNu7Fv3OjYNN3NGD1pzzcdnaaJMBqa0f0F7JXVX/w3MJYfU79XcSgjmCJig8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781749635; c=relaxed/simple;
	bh=Pib6PnOOxZ5D4Eg59dvbOMIN/LveHr2W3zb/FlZU5Ek=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qSmWLmTLtR3oCc0uY8tD26R2oKUIDk4uDoKhzAdjnE8dZG0/dpb8liRLh/oULCLPzgdyMDLytDGnRBbH/UrBrzRNP1XoQQ/SR/lItKrGlfMxThOVREKEf6NZuFZWpbYEOrT01r+ahrOanOACRgELr9qDsUVXtPRt8MO0D3EqGow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=s+EXdzfL; arc=fail smtp.client-ip=40.93.198.7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lKmOAPx/w6IkMjrdKj3Y8iOew4D2iO38Mth2fnp+MeRVv2vcLqy212vXtCOQg0RAHjEIOJD0a4X5ik3o1/XRMvbyYVsY5cYoHVBU/8hVfWVpd82jFXq0fYdjJGWHT8p6w/1+kknGrRHCE5Qkly1sPAzfOGEx9SBBsUTtKRfWK1O3KCcerEQ/wZO1LOb9O/8YVwYMgmp+4lcFsZMoFD0qLFNehgWoXVZBpDAp3drFvG4yzSkZofOKU4YNgkKF2s4xO67lfSm691RS32aVTtf/9umyXvoBcoQ7pvWcewctLKMTVn8SYdhPyihrgBdA2jrlbPBA5ntN4Y0vySuyft5rTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pib6PnOOxZ5D4Eg59dvbOMIN/LveHr2W3zb/FlZU5Ek=;
 b=BT5ux4+gMoGptcQsbMaxCbZ9EMTeMeVAwZqu5ci66L08aUhQm8lsXZrM0Yw+lpzA9UH6FwX47dK9YkJav+d3wRct6pFuGaaz6RmoUtALsvLVMYifed1WNil/L4+WL39xRDAUxe/5PDlOv4bu9KwxqxUyXLVgzdrIE3G7aCT3EcliDqYSf7+y50CCJABDwKgWYgBA1uhxtIGr0z8hL3yn6MZbVTZDcDGK076o8UAFwg1zMjQvGBpR2qy6CDbQArxezlPPPrh8TTHIavGWPgH6flV5UHyJmTZpr1tbmJDfBIEjtARs+GwjmfCGzIlwc32XAAteKWet5KrjRkx+jYPLeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pib6PnOOxZ5D4Eg59dvbOMIN/LveHr2W3zb/FlZU5Ek=;
 b=s+EXdzfLpbQFMXWA1kH5cjajHNkxX8R2oJimgOx8a4lLCaGYCCZ0XdmtYZZIqzhZU0KDkJ23SCcaqP4CK87DoZ2zIiHN22xQ0ONOtAVtVVfoDwazFubyCZKlQzuqz296UdHdL7sRZ/+zo/Cj9TGkDwIaZrPrR7HewuWHI3wXy5vAuWNSeg0IlrIrGyLB6wUyG8j17Yq4KoLV9bCBDVIe0rG2MaMmaF+2gPm7LtGgQeBA85bKwZSKYmmMHBGk3pLOjvMYF74N8sLqJWgtKuh9fuJ3HU/E8yKJZwl8sxTd6F7SF3qp3DuKjuyB1Ky8wxlyUPv5pb7GBcauTLuGdrCqpw==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by CH0PR03MB6132.namprd03.prod.outlook.com (2603:10b6:610:bb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 02:27:10 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0139.011; Thu, 18 Jun 2026
 02:27:10 +0000
From: "Nazle Asmade, Muhammad Nazim Amirul"
	<muhammad.nazim.amirul.nazle.asmade@altera.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, Simon Horman <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "faizal.abdul.rahim@linux.intel.com"
	<faizal.abdul.rahim@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: ethtool: mm: Increase FPE verification retry count
Thread-Topic: [PATCH] net: ethtool: mm: Increase FPE verification retry count
Thread-Index: AQHc/JgGTDbz08AGuUq7WW8N1IihOrZAx7uAgACFWACAAk2wgA==
Date: Thu, 18 Jun 2026 02:27:10 +0000
Message-ID: <52eaf5bb-2bbc-4348-bd77-321e698d326b@altera.com>
References:
 <20260615072436.26128-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260616071925.GA800687@horms.kernel.org>
 <20260616151640.qi4bobvcbeyptvgg@skbuf>
In-Reply-To: <20260616151640.qi4bobvcbeyptvgg@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6964:EE_|CH0PR03MB6132:EE_
x-ms-office365-filtering-correlation-id: 154f6255-93ef-4997-561a-08decce119a0
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|56012099006|11063799006|4143699003|5023799004|18002099003|22082099003|55112099003|38070700021;
x-microsoft-antispam-message-info:
 nxH8X8fLsk1eiq/k0jRoT3vaYuAN01YvXFYorDMgfrrqtoQHqKdPRkN+N6KLqPqBdwTbmx2BSuNDZUPEsM1g8/GhhPxCZ7iCQyRzArr+CsVsregdt9X0zMyMDEzJIEBTykb+WcDGw3oa1o8FTPfdMz1zgzQ9yENO0b3CAuSUgZjZytSj+sNMv1tgzMpVC0/7E2+EuSwZDe20GP8ySqDiIuVOPN5ygqPTC2EoqZow/+V6i/QnlAA8c7uxVCJIQi2vNeTRJFK+opV25RQC/F0lU+zjTYR1n98z2XwFKoHVq/RKpixCwVMR8MXV9cw6MraKdw+acYppNOVnfPQVDEbraeYg+tq5rTlK14hFscLcOYy6VkTl/YxaWgQXjx1gI7dW+fgm+OlumHKOzR3zpF5PZSY4rcHqFG3k6/cLatAHkvU/k3cqt1im0XqpzIO7SGp4YQNM7NxctGsNO3XAu8xWgB45sds9Qg8dxE1rt3PrBssE5E20bAkURTc/7eWixo9XF37ri859HtC90iMRIh/a2rh/DZEXAgZa6mUMrd2dH9qJeT1yggvyzyq15AMt+rJEfxUQzFwhHQNS8sl4Cy75PpCEHYUucOLLTwHhzpOQWaPx1Xoa5kwVd8YH6xaXxGN31J5LF93Bzqay+MG+u5wSEUyedB4iyQu6xPxJIPHNQ7QfVwX0Wlj5TAh+xQqjAjJ7+rFIzWnIXXCz4H1LaMITnzpZx6sfTqomqeI601R/1CUjb+lK0ZamVov49TrKH9DS
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(4143699003)(5023799004)(18002099003)(22082099003)(55112099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UnN1Q1E3TTdXMVB1bW9rblBaYitHdzBoeXJrRTBZSzNkRTJobmJzRXduYnEz?=
 =?utf-8?B?SUtKaUpKdGlsUEdERlNLZWZkSjhRVnVMd000WmlKc3AzcS9KMEg1MEhXOHpX?=
 =?utf-8?B?aVdLZ2VsVGFsOHpicnRpQzF5S3NzTGgwNGprNm81SkIrVU1sZkp0a1h2bGQ0?=
 =?utf-8?B?OEJSTm40S3NMSW1uT0dNbW02RG85Q1JLYzJjRWpTSDFVU2RHQnVuSTFNN3RE?=
 =?utf-8?B?akprVmozNHdXMDlrWjFiTkNwL0JnTUFWSmFKTzlJcmw2SGVsM3BTNXdueENp?=
 =?utf-8?B?cW5qVzgrYTV2Z0l6V0JSSWRsV2RkMXpaczZnenlxa0lVeGU1OExwK3Q4cHVZ?=
 =?utf-8?B?dVhpbUdBd0U5UmxYaFBkSGZibjdpeGFjSkxoY051ZG1IWlJHT2JSZTZleWt6?=
 =?utf-8?B?cmlFcEVUNDB4OCtsMjJzRlY2LzVldzBGSFFoelBqd2VDRFFTWEpVNFVaM2tj?=
 =?utf-8?B?RERrUFVkTjFMTG1nazAwNXE5OUs3UE1ZU1ppeThmVEx2bFZDVjFJRFArWXNr?=
 =?utf-8?B?K05DWlpwSUdxRk1rQXdDSndreVEzUmFUZDJpcHYxa2F5b25kb3FXZnB3R0hn?=
 =?utf-8?B?WVBCcXVrTUVXbHJqaVQ0QmJxSzhCS1Z2TlNxOFhZYmVvV1JxUEY4bno2ZnM4?=
 =?utf-8?B?YklGRWc0cCtON25tSzI4LytyQTBUaXdLVGpuZWdBWW02SHk4ZjFJVmNRNHha?=
 =?utf-8?B?Wi9pUkh6cWFMc2VhT3JmdVZqZzF5YmdmZ1d3UHcxSExiMVhmZXVtaGdwSmdF?=
 =?utf-8?B?VUNEWVVyY1QxeUVJQlFnY2pnR3pjK3ROWUdFRjJVNW5hdnlPRVh3bzY1b0c1?=
 =?utf-8?B?R3poRkJmTkNGNDNlWlJrd0t0VWw3S0YwVHZxWVFiZjQvV0d2c3orRlB4Z1Rn?=
 =?utf-8?B?SWh6WGErbDhqblhodDFFcnJQc1Y5RGlxcWJpSk12TExrSW9PUDVHZk94d2Ux?=
 =?utf-8?B?UVpmRDFNNlNqT1pKNWtKLzZQTi94ZHVMS21uWWhpditaYlpEa1BGaFhySzZX?=
 =?utf-8?B?c0duVEtpa1lJdmVCdlArVHNFSU5YMGhZWnBkQWpHcmdhYTNYVWh0OFh2NkxV?=
 =?utf-8?B?SW9PYThncm1abkpEWmtvYVlaNXVWSVRoWWZkeTM2UXQvRVE2bFcrUGxHbjJj?=
 =?utf-8?B?aUxFTkkvanNidUF5OHFuZXF2bThjdlE4UlZ0Vm5KanNFWlBWeVNPdE5Fd0JI?=
 =?utf-8?B?Z2VKaWxIRXAvNWNqRGtVRFBZWEZ4US9kWEZ0K0JZbzJ4bzZyeStSbmNOZDhD?=
 =?utf-8?B?SU80NkNtVlFnVnQvb1ZQZEIwUFRXczliZG4vWkd0aFdZM1R2d2VoMzBwNUVi?=
 =?utf-8?B?WHIwSTYzbzRzcWRuZHNNN2lmcVlNc1dmZm9ZWWdOVnV5YldQUEJkTkQvbWRY?=
 =?utf-8?B?ZVI5dzh0Nzc1bGVaUGtsZWZoUG9KZzE2WmgwZXEzSnc0UjQ5K2tTNHpzZXBt?=
 =?utf-8?B?ZFRJUVpIanVFczlpenFya2gyeEg0SWNkK3JUNnl3emFHZWJMcDZDZWhzdzlF?=
 =?utf-8?B?ZEVCKzh4TEZKeTdzcm5rY0NSS0pzVTlnc2d4TzVLeWd1S1FkVnJTZGQxVFZ6?=
 =?utf-8?B?R2lMNXdTU3U3bkhVSGxXOHYvbVMyZFIvS2cyVW8zRmdmckRkOE50dHpXRll5?=
 =?utf-8?B?MnNuT1FHWWN3RzdLTjhkWldhdDdMQUxVYkplSzV5U0N4LzVzSEExOTlQY1I3?=
 =?utf-8?B?Yis4OG5DVCtNbmhHSHlKeElhK2RYTmxFRUxQMmN6clJPZ3VEWXF5dGNMdU14?=
 =?utf-8?B?b0RzbXF4ZktJdjRGN2wrbFFXYjFQM2VMQ3QvaGE4c0VGVHgxSnVwcmRZUy9H?=
 =?utf-8?B?b0lOZWxYZnhlZnV4QUZ2TXYzWWRoRzBEbmw1NUhXbGlsU1JyUm5FUHZqSC9B?=
 =?utf-8?B?UHZUY2RodDcwTHE5QWtzcGtWd1grWUFQbDJxNklHeHltMXNvemhZbmZVdTdk?=
 =?utf-8?B?ekNxNmZvdk51N3lpTGR4UDdoa0tOMzJaSE5UTlFVSCtZeWNUU0ZVdU1oZ1Y5?=
 =?utf-8?B?SjAyY1BETncrOXF3R1ZMRlJydnI4RStNM1pMYzZqUmVoVTdSL0RWQ2QwU29K?=
 =?utf-8?B?TFBlc003VHNUZUFGeGhvVjRPalNScUJ6eGtmQVBUeDkzUytKeDF1NHpPeU1r?=
 =?utf-8?B?OWZxVm9QYmFOVnhqZDUzSzQvd3U2dC9xUVo0RWdBTE9QbkU0Wngzdmp3ZXQ1?=
 =?utf-8?B?Sm5WalpjYmg4OG1VV3RNblRLblpSaUdCUWI5dzgrTWR4blozUmtoT2s0L1NB?=
 =?utf-8?B?L3QyVUt2V3B1Y2F0SE1SUkhXTWFOSy9HbWUxZjRrajd5QmxPeHdzWGdUMWtT?=
 =?utf-8?B?ZjA5SUVFbnZFN0tUOFA2cEtWd1M5YXgyWm0zTE1PQ3FrSHVGM252ZlNacGR0?=
 =?utf-8?Q?HgwrfpYZr4tRTzt4dRyMh2VkCJYdP0CrHsulhikNWCA9l?=
x-ms-exchange-antispam-messagedata-1: +8U9tV1rN/xleB/hHxbY4Ot9zaa9a+kQTQA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C1A84911C444A469671369B9260A97B@namprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 154f6255-93ef-4997-561a-08decce119a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2026 02:27:10.2293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5/D7w1FyuEinvlbuv/upnzyBSRbRISwmdZgHpSBdWfNKhMyEKYFmy+parW5edxL36ya2mJnDQO2pI5Vjbpmfgtn3PvS3AnM9DCO6zZHDEQmTJScB4NUFMRVRPLDQtggQYsuFmBb/8kjxTXOkzw+4VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB6132
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-300301-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:vladimir.oltean@nxp.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:faizal.abdul.rahim@linux.intel.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
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
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,altera.com:dkim,altera.com:email,altera.com:mid,altera.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EB35269D214

T24gMTYvNi8yMDI2IDExOjE2IHBtLCBWbGFkaW1pciBPbHRlYW4gd3JvdGU6DQo+IE9uIFR1ZSwg
SnVuIDE2LCAyMDI2IGF0IDA4OjE5OjI1QU0gKzAxMDAsIFNpbW9uIEhvcm1hbiB3cm90ZToNCj4+
ICsgVmxhZGltaXINCj4+DQo+PiBPbiBNb24sIEp1biAxNSwgMjAyNiBhdCAxMjoyNDozNkFNIC0w
NzAwLCBtdWhhbW1hZC5uYXppbS5hbWlydWwubmF6bGUuYXNtYWRlQGFsdGVyYS5jb20gd3JvdGU6
DQo+Pj4gRnJvbTogTmF6aW0gQW1pcnVsIDxtdWhhbW1hZC5uYXppbS5hbWlydWwubmF6bGUuYXNt
YWRlQGFsdGVyYS5jb20+DQo+Pj4NCj4+PiBUaGUgY3VycmVudCBGUEUgdmVyaWZpY2F0aW9uIHJl
dHJ5IGNvdW50IGlzIHNldCB0byAzLiBIb3dldmVyLA0KPj4+IHRoZSBJRUVFIDgwMi4zYnIgc3Rh
bmRhcmQgZG9lcyBub3Qgc3BlY2lmeSBhIGZpeGVkIHZhbHVlIGZvciB0aGlzLg0KPj4+IEEgcmV0
cnkgY291bnQgb2YgMyBtYXkgYmUgaW5zdWZmaWNpZW50IHdoZW4gdGhlIHJlbW90ZSBkZXZpY2Ug
aXMNCj4+PiBzbG93IHRvIHJlc3BvbmQgZHVyaW5nIGxpbmstdXAuIEluY3JlYXNlIHRoZSByZXRy
eSBjb3VudCB0byAyMCB0bw0KPj4+IGltcHJvdmUgcm9idXN0bmVzcy4NCj4+Pg0KPj4+IFNpZ25l
ZC1vZmYtYnk6IFJvaGFuIEcgVGhvbWFzIDxyb2hhbi5nLnRob21hc0BhbHRlcmEuY29tPg0KPj4+
IFNpZ25lZC1vZmYtYnk6IE5hemltIEFtaXJ1bCA8bXVoYW1tYWQubmF6aW0uYW1pcnVsLm5hemxl
LmFzbWFkZUBhbHRlcmEuY29tPg0KPj4NCj4+IFZsYWRpbWlyLCBJJ20gd29uZGVyaW5nIGlmIHlv
dSBjb3VsZCB0YWtlIGEgbG9vayBhdCB0aGlzIG9uZS4NCj4gDQo+IElFRUUgODAyLjNiciBpcyBh
biBvYnNvbGV0ZSBzdGFuZGFyZCwgSSBkb24ndCBldmVuIGhhdmUgYWNjZXNzIHRvIGl0Lg0KPiAN
Cj4gSUVFRSA4MDIuMy0yMDIyIGlzIHRoZSBjdXJyZW50IG9uZSBmb3IgdGhlIE1BQyBNZXJnZSBs
YXllci4gQ2xhdXNlDQo+IDk5LjQuNy4yIENvbnN0YW50cyBzdGF0ZXM6DQo+IA0KPiB2ZXJpZnlM
aW1pdDogdGhlIGludGVnZXIgMywgdGhlIG51bWJlciBvZiB2ZXJpZmljYXRpb24gYXR0ZW1wdHMN
Cj4gDQo+IEkgZG9uJ3QgaGF2ZSBzb21ldGhpbmcgaW4gcHJpbmNpcGxlIGFnYWluc3QgbWFraW5n
IHRoZSB2ZXJpZnlMaW1pdA0KPiBjb25maWd1cmFibGUgcGFzdCBJRUVFIDgwMi4zIGZvciBkZWJ1
Z2dpbmcgcHVycG9zZXMgb3Igbm9uLXN0YW5kYXJkDQo+IGFwcGxpY2F0aW9ucywgYnV0IGtlZXAg
dGhlIGRlZmF1bHQgdG8gMy4NClRoYW5rcyBTaW1vbiBhbmQgVmxhZGltaXIgZm9yIHlvdXIgcmV2
aWV3IQ0KDQpCUiwNCk5hemltDQo=

