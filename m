Return-Path: <netdev+bounces-296178-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jUUdC0vrJGoZBwIAu9opvQ
	(envelope-from <netdev+bounces-296178-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 05:53:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FF864EC35
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 05:53:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=gGB6BOSC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296178-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296178-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7ED9D3014100
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 03:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74AB35F5E5;
	Sun,  7 Jun 2026 03:53:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013013.outbound.protection.outlook.com [52.101.72.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5266527FD6D
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 03:53:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780804411; cv=fail; b=hUbkhgkVAkiBpeo0DpNdJ0eB4MYGUq3OfaGmFG8ZrXeKKAHWVFlolRJJvxfBRNqSChzPPpl8z5amyJnYwzc7QGYar30d7PrZfeB8GT1GApHAAQkMDAZsL9V0U+1uwDham0FU3NzipfTVY+wgKEVYLS95HZWv8C252VmcaxkFsMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780804411; c=relaxed/simple;
	bh=Y5mJdGYosxtEXF6o3rySBI6pfGAiL3u7bLLuxel+iR8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SYJw/fnHKDSZ2TanB0/58NXSEBE6LTGi0zPft+ZQ6UYgW6Vezz1PKrH9gzRt3IUG54nm/vJ3B0chCosy7iljRPluIxDEyOizyK6g4lvR8Eg03Mrwj85q0jEtSmGjNTdZPN+GcNe9L7KLTkG4ARTuOPJTld5ADTeMhTozyBpSjQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=gGB6BOSC; arc=fail smtp.client-ip=52.101.72.13
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/uIBhnOXKXjGj2Psb6fiEbPFRN8k7bIf5LRyh65kZCOpLT4NxUuo8Nxw4SRElhbBCFWcSwViIDbCm6cWtkNAnRZgNB4Tex76tq63kfF+0L34v7y/5hds9c80bc/LMsxPOWPpdrkxk+dkK7LFFZQHYI7EGrta/BS4yBNd0NDFZuoHV9qPhWVbn2qdyL1nfdQFowfNdRSwXArlqdlkJQCvrCGYPrzYncYb2LAMtCaJnKGyhU/4BNkcTL3g/DT+7FKgu+ZOjVImzJ8h1Cz7luA+qOBxMDlYOInFeBbMKXHjWYwvMaWiMSoHqlC494eihiyho3nF7jDJWrt6RZFKEv6ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5mJdGYosxtEXF6o3rySBI6pfGAiL3u7bLLuxel+iR8=;
 b=lDr03JVZnw00LCxDeOXQLkiZcL9sYSRzNpwhvPfpE0t3oVGEoc6z59a5cjtp7PECDhEkOXQlJBh2stwzPD/iEqvDoXTwz+DgAx7p0vgwfSVmJ2+5KV/9tEEaa/s9wLvpeCymCfhgeJkbysQNn4ZoJ657alK0sJa2JetcBK33ykDw+a7aiykt1vkPpFY1OkC3BB0RS/gdZRAJhlrCiLkuk2s1+PoeFToakx9uHdStXjIQNrZQkvXhbLVtz0kXmct7OqWGjaBiDZvKBEywcRw/6jnN1vECNEINuBUuwvXTLi+ZrHsgvczUBjoJBmBYuDN3nTM2I1H7EJ101eNY3PftFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5mJdGYosxtEXF6o3rySBI6pfGAiL3u7bLLuxel+iR8=;
 b=gGB6BOSCgT0rc/0EF2XIOnMy37fkn7+gbOjmvWa+9i4qulA5WiPgR4yX2c5NQ7WM7kR2cmS0gSPYjCgf790GPtJ9QIMexN6ThLBngS0DeOTV8ZivqHKODOKjoOEtE1gYM3gClYcZfRIBjVq9AWHwRTd9D78VYZm//im51DM/hX/t5d4I2dJGxZlNcLDx12Kz8jUtW+trtkyLe17ccF/6Pe2w79ZBfJULGu+pkiVYhn2RRQJ0hr242BA3E99GepglP9xG0fFe+89cZj9Mtw32NgwNM/6qlwHmbwFa4PYDEiNbMGiy/lqSBTHDj1jMaFGM/+JHX2Y8CNAd7nrrhcWMXQ==
Received: from DU2PR04MB8629.eurprd04.prod.outlook.com (2603:10a6:10:2dc::6)
 by PA1PR04MB11360.eurprd04.prod.outlook.com (2603:10a6:102:4f2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Sun, 7 Jun 2026
 03:53:27 +0000
Received: from DU2PR04MB8629.eurprd04.prod.outlook.com
 ([fe80::9d04:7526:a901:fe47]) by DU2PR04MB8629.eurprd04.prod.outlook.com
 ([fe80::9d04:7526:a901:fe47%6]) with mapi id 15.21.0092.010; Sun, 7 Jun 2026
 03:53:26 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "Frank.Li@kernel.org"
	<Frank.Li@kernel.org>, Networking <netdev@vger.kernel.org>
Subject: RE: [PATCH net-next 12/15] net: enetc: add VF support for i.MX94 and
 i.MX95
Thread-Topic: [PATCH net-next 12/15] net: enetc: add VF support for i.MX94 and
 i.MX95
Thread-Index: AQHc9LxPE0x382m3dEee3bSMAVcKtrYxIZwAgAFXTLA=
Date: Sun, 7 Jun 2026 03:53:26 +0000
Message-ID:
 <DU2PR04MB862957BA4E2046A819F17BA7881F2@DU2PR04MB8629.eurprd04.prod.outlook.com>
References: <20260605065550.3038579-13-wei.fang@oss.nxp.com>
 <20260606072442.AFEED1F00893@smtp.kernel.org>
In-Reply-To: <20260606072442.AFEED1F00893@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8629:EE_|PA1PR04MB11360:EE_
x-ms-office365-filtering-correlation-id: cb5dd36a-68ec-4648-5741-08dec4485498
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|19092799006|11063799006|4143699003|56012099006|18002099003|22082099003|6133799003|38070700021;
x-microsoft-antispam-message-info:
 W/3rcCTbEBL2Kqow7LVFXXPHAAFxnlgRhzjxQywaobrADV5PxXesUlrdHLrNyY5kA32b9PwvLNs2oF16XK/cuR+qJ7U6y2STSqivo0nRtWkWlb4G2KtqIR+xlJ1Dj8ACMB/VWcuMF4t2zAM9GwZdeTaGJ0NlXKHOsI5N9B0/7pfldCTwSKV+yGWw+iUtwr2hwrQOwecGU7Kyug0KtdiNNEmT5LXVgcMZrTpd2ucuj8NMEgbdZOzzRYwqldTgqJLSZyXyFRGmPrgjSyX6rWhW7CLXRpTGcrxpriGdc54+T+6uU5WjG12Re7oCx4VT0t5yhvHJxQ7R0kNRmxLOjfPeNjro/xzen8qBoKwk7+giIunFACn9T8asH27FKpkTBRRgtFDkC1QkoSRy5tI7+ac9S9Sh26SOXDvF44a7gM7ytxcnqYZ3j5+fL1nxd8jEXVCZ0ErygQQ3Fow5r2O2nlI7A63xUclfLBLS5ji+Ljy5uQWwVhYoHuR75A+dAEwAhySkY915i4sq8XWjmtE6aCk7UYX8XLKNr/SjyDwWv0LqHAsGwpBIedTTUVhPhs76jEf24L28rEfU/OJbJimldmQc3zPTTl6KhWxOTY7udOFf4RYage/mzObt9aPnvFtYETSfca1RYzl9vhsiKO1IiXnBPjZPm0g7cHEdlujn/Nyt6UZn6BZunJbTZMf6D6WwvD/ssagpQ9xJMKM95DaWp5BcChXheec9oscJ+TlGSiibJqWU43muu+sfWzU+w8okANWA
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8629.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003)(6133799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MkpLQ2plb1QrUXkwTnpxL0FBVlVOR1NaZGhrNDU5RENhc2pMb05ZY2Q4OFlM?=
 =?utf-8?B?YXFtTVZCWUVsMk5Hdm9FNXZyeVNGTGJQdGltQ2dsTkh5T2ZQN3RSbGdoc1ZR?=
 =?utf-8?B?ZFJxTjV6MXFlcnpaSTZrS0UzREc5bkpiRFNJRnZnRWFHYUlqTFAwNEd2WVJR?=
 =?utf-8?B?UGRnNjA3c3NvSW10aitobHM5T2VFSGlrNlRwQ2NQWHZac3pUM0hnaWZWTFRh?=
 =?utf-8?B?ZStDcU5yano0eFR2UEdMNFY0RjZuT0VzQWZCd242KzZpK0pFT01XK1Vieno3?=
 =?utf-8?B?L0ZlMllJNitXU3h4b2tHcEpTRlQ0SmxIWnBuOHRoU1ZJc2s0cEZVeC9VWHhY?=
 =?utf-8?B?U2VVZmpUajZYWlpBaHN6U3phckk4YmRUclR3c0NMekt4OXBxZFNKd3J0Y09l?=
 =?utf-8?B?ejlDZmlkMjN1Ujd0dzllc05ZNnlYTkhDT2tqU1NLZHI0bEpFSHJoa3RGbGRG?=
 =?utf-8?B?MTRiNUtqNWxySm92OFBuMnVwdHRObThldDBmMG1WWVpER2ZrUlp6Rm5wcDRS?=
 =?utf-8?B?RmVkT2FVQTAwQjBFWStaK3crbG1MRzE5Y2ZGQWk2Q1AyRDh5Z00xYTRFSVFa?=
 =?utf-8?B?OEdhWXBkSkpUaVY3RWhWYzFZQjFNT21FY2EyN1BaRU03M09UTnE4NGdneVdu?=
 =?utf-8?B?Z3lKZVRHU3doSVN1UzNKNXkzQlFVRHI2RzJQS3pRTXdHbGt3U0lnQXNKcnBV?=
 =?utf-8?B?eGxtcDM5Y2FCQVJVRFo1SDBZRm54UnM2YktDL1ZpM3hvZkV2Si9LcVRIaXp3?=
 =?utf-8?B?bTdOdjVCdUJYU3hPMS85VjR4SHNXakRBbm9ncUQvWDVDRDl3Y0hDUWIwVm1j?=
 =?utf-8?B?Tk1yVlJIc0xKSFJFbGFxOVZlWjZzNG9OdndlK05md1dlaWNWVS9zcFV6cGpu?=
 =?utf-8?B?K05Cd0MxdlFialhiYjVDbW96NEFUUzlJQWZUWTI5WTNsZkM5V216MkV0ekFL?=
 =?utf-8?B?SlZnZDY1WmJYVCttZFcyRW5NKzNwbjFYVmxxN1RqYlFTSlhFUWtFYTJrV0l6?=
 =?utf-8?B?Z2xIbUQwL3hvQUxjcDZ1a3NUK21JeDFOSDYxUGVHMmFBNDhOWTl6VUhFakYx?=
 =?utf-8?B?YXYwRUttK08wZ1Z5OElsY2drdzc4eFFTQUQwVisxaWpxaVV1OWp0YlBqbVcx?=
 =?utf-8?B?dGhBV3l6TzdHalV5RW10aEJDZ2hVM053RTRXWmtXYlZnK2J2bTN2MVVaSXpo?=
 =?utf-8?B?cEkyQkNJVURwam9sV1puTmNva0Z6Nm9xM1FJMUM0ZzVIOVI1MzhsY29OSkx1?=
 =?utf-8?B?aE9PVTg3bTgzMGdreHZjMW1NbnY2S0o0WURUWFR2a3M2UkdXaVJLbG1CTC9Y?=
 =?utf-8?B?dlRBYUJMOVo3T1RCbnd0UWxpQWUyd1dWYnlONzlyaDBHb094amtnQ1NPOFdB?=
 =?utf-8?B?ZWFSbDVuL2twNnV4YXp2NzRDRDdheEN0RmRzclJ0Y1ozTHVnZnRla0JXZG0y?=
 =?utf-8?B?VllRNStQTFlNclgxdHYva04yY2ErQnMrLzQxZDZiTXAzOE5SYlJxN0c5TGZp?=
 =?utf-8?B?SVNRT2FEN3ZIVjc5UlF6dXBJQTc1TGM1SzVaMU1uQ3VMQWp1eFIySkNZTTRS?=
 =?utf-8?B?VTcwSXUwSDd3TFY2alp5dHU0aEkrQjk0TEdRZmN0VnlFVzJReDFTYzIzMEFz?=
 =?utf-8?B?UXVDenBlNFgwRkQ1Wk1JbG5yVkx1VnVad2U4OW9TUmpITUpUNkdTaHBueGhT?=
 =?utf-8?B?SjY5VkticEtseDBzeEdwT0RyWnRTUFZjdUlvbGdYb3RCdXN0WU94MHdsOXZ0?=
 =?utf-8?B?Z0Q5MUgvcjNic2xBNGQ0QTBDeE11YWhSanI2b1pkVTZtVGdzUEI2Y3k4Ujlu?=
 =?utf-8?B?UlovSy91aG8wVkE5YXlySUQ5YTBIRlpFTjJpeW9teUdBSGY5QXY0NE9UQWs3?=
 =?utf-8?B?SHl0RWJlR3F2Q1ZYNStndVVGc09GbEdQNytreVlWdmVzU3JOd012RGVLYXJO?=
 =?utf-8?B?SzNveEtBVnlvaWszeDlnL0ZjMXI3c1VGYW1WblA0VitBWVJLOFZiMkErOHUr?=
 =?utf-8?B?VGRsMnA1cUNlWkRvOXdFNXlaQVdnaUhLM1Z5QWFYbjJVYzNGUHlpMzM4U3Rv?=
 =?utf-8?B?ZXZUeHFqSzVtbWtyYnhCU2ZOWVFSL1Z2VW4yWHFQb3A4YXlrcjVrRlJUNlhV?=
 =?utf-8?B?VHdsdit5cVI4NDRlN2VXdFFwdnJCSFc5VnFWbThoeXZ6a0VtVEVDVWY1d0Zs?=
 =?utf-8?B?dUp3a3lOdVNRdW5iZEh4NlE3NHA0K3IwcWZ2ZEVmR1YwalRueVdSOGxJWkdu?=
 =?utf-8?B?Z0haa1krWUIyREsrWnBSOCtBRHY2bWVWelhrWnRpTVpLbFdPN2ZGMjFHNlE2?=
 =?utf-8?Q?/C0Wc8/h/vC4H9yxZt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8629.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5dd36a-68ec-4648-5741-08dec4485498
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2026 03:53:26.9016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PSawa1IPRZ0OYWXHguUAGkgRUMny1ggwNFefDninAvY83uOxxi3D3VsA3MT92rUsAWpbAFAofEgbVU7Rqgdj7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11360
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:imx@lists.linux.dev,m:Frank.Li@kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-296178-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,DU2PR04MB8629.eurprd04.prod.outlook.com:mid,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 71FF864EC35

PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5ldGMvZW5l
dGMuYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0Yy5jDQo+
ID4gaW5kZXggYWE4YTg3MTI0YjEwMy4uZmRjZWFmMzZkYWE3MiAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5ldGMvZW5ldGMuYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0Yy5jDQo+ID4gQEAgLTM3NDUs
NiArMzc0NSwxMyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGVuZXRjX2RydmRhdGEgZW5ldGNfdmZf
ZGF0YQ0KPiA9IHsNCj4gPiAgCS5ldGhfb3BzID0gJmVuZXRjX3ZmX2V0aHRvb2xfb3BzLA0KPiA+
ICB9Ow0KPiA+DQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZW5ldGNfZHJ2ZGF0YSBlbmV0YzRf
dmZfZGF0YSA9IHsNCj4gPiArCS5zeXNjbGtfZnJlcSA9IEVORVRDX0NMS18zMzNNLA0KPiA+ICsJ
LnR4X2NzdW0gPSB0cnVlLA0KPiA+ICsJLm1heF9mcmFncyA9IEVORVRDNF9NQVhfU0tCX0ZSQUdT
LA0KPiA+ICsJLmV0aF9vcHMgPSAmZW5ldGNfdmZfZXRodG9vbF9vcHMsDQo+IA0KPiBbU2V2ZXJp
dHk6IEhpZ2hdDQo+IERvZXMgdGhpcyBzYWZlbHkgc3VwcG9ydCBFTkVUQyB2NCBoYXJkd2FyZT8g
VGhlIGVuZXRjX3ZmX2V0aHRvb2xfb3BzDQo+IGltcGxlbWVudHMgdGhlIGdldF9yZWdzIGNhbGxi
YWNrIHVzaW5nIGVuZXRjX2dldF9yZWdzKCksIHdoaWNoDQo+IHVuY29uZGl0aW9uYWxseSByZWFk
cyByZWdpc3RlcnMgZGVmaW5lZCBpbiB0aGUgZW5ldGNfc2lfcmVncyBhcnJheS4NCj4gDQo+IFRo
aXMgYXJyYXkgaW5jbHVkZXMgRU5FVEMgMS4wIHNwZWNpZmljIENvbnRyb2wgUmluZyAoQ0JEUikg
cmVnaXN0ZXJzIGxpa2UNCj4gRU5FVENfU0lDQkRSTVIuIFNpbmNlIEVORVRDIHY0IGhhcmR3YXJl
IHVzZXMgTlRNUCBpbnN0ZWFkIG9mIENCRFIsDQo+IHRoZXNlDQo+IHJlZ2lzdGVyIG9mZnNldHMg
YXJlIGludmFsaWQgb3IgcmVzZXJ2ZWQgb24gaS5NWDk0L2kuTVg5NS4NCj4gDQo+IFJlYWRpbmcg
cmVzZXJ2ZWQgbWVtb3J5IHJlZ2lvbnMgdmlhIGV0aHRvb2wgLWQgY2FuIHRyaWdnZXIgYSBzeW5j
aHJvbm91cw0KPiBleHRlcm5hbCBhYm9ydCBvciBrZXJuZWwgcGFuaWMgb24gc29tZSBhcmNoaXRl
Y3R1cmVzLiBTaG91bGQgdGhlIGRyaXZlcg0KPiBkZWZpbmUgYW4gRU5FVEM0LXNwZWNpZmljIGV0
aHRvb2xfb3BzIGZvciB0aGUgVkYgb3IgY2hlY2sgaGFyZHdhcmUNCj4gcmV2aXNpb25zIGJlZm9y
ZSByZWFkaW5nIHRoZXNlIHJlZ2lzdGVycz8NCg0KVGhlIFZGIHJlZ2lzdGVycyBvZiB2MSBhbmQg
djQgYXJlIGJhc2ljYWxseSB0aGUgc2FtZSwgc28gdGhlcmUgaXMgbm8gc3VjaA0KaXNzdWUuDQoN
Cj4gDQo+ID4gK307DQo+ID4gKw0KPiANCj4gWyAuLi4gXQ0KPiANCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjL2VuZXRjNF9wZi5jDQo+IGIvZHJp
dmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjL2VuZXRjNF9wZi5jDQo+ID4gaW5kZXgg
MTVjOGI3MDRiMmI3NS4uODY4ZWQ2OTRlMTIwMCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25l
dC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5ldGMvZW5ldGM0X3BmLmMNCj4gPiArKysgYi9kcml2ZXJz
L25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5ldGMvZW5ldGM0X3BmLmMNCj4gPiBAQCAtMzE0LDEx
ICszMTQsMTUgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBlbmV0Y19wZl9vcHMgZW5ldGM0X3BmX29w
cyA9DQo+IHsNCj4gPiAgc3RhdGljIGludCBlbmV0YzRfcGZfc3RydWN0X2luaXQoc3RydWN0IGVu
ZXRjX3NpICpzaSkNCj4gPiAgew0KPiA+ICAJc3RydWN0IGVuZXRjX3BmICpwZiA9IGVuZXRjX3Np
X3ByaXYoc2kpOw0KPiA+ICsJaW50IGVycjsNCj4gPg0KPiA+ICAJcGYtPnNpID0gc2k7DQo+ID4g
LQlwZi0+dG90YWxfdmZzID0gcGNpX3NyaW92X2dldF90b3RhbHZmcyhzaS0+cGRldik7DQo+ID4g
IAlwZi0+b3BzID0gJmVuZXRjNF9wZl9vcHM7DQo+ID4NCj4gPiArCWVyciA9IGVuZXRjX2luaXRf
c3Jpb3ZfcmVzb3VyY2VzKHBmKTsNCj4gDQo+IFtTZXZlcml0eTogSGlnaF0NCj4gQ2FuIHRoaXMg
bGVhZCB0byBhbiB1bmluaXRpYWxpemVkIG11dGV4IGJlaW5nIHVzZWQgb24gc3RhbmRhbG9uZSBF
TkVUQyB2NA0KPiBkZXZpY2VzIHRoYXQgZG8gbm90IHN1cHBvcnQgVkZzPw0KPiANCj4gSW4gZW5l
dGNfaW5pdF9zcmlvdl9yZXNvdXJjZXMoKSwgdGhlcmUgaXMgYW4gZWFybHkgcmV0dXJuIGlmIHBm
LT50b3RhbF92ZnMNCj4gaXMgMDoNCj4gDQo+IGludCBlbmV0Y19pbml0X3NyaW92X3Jlc291cmNl
cyhzdHJ1Y3QgZW5ldGNfcGYgKnBmKQ0KPiB7DQo+IAkuLi4NCj4gCXBmLT50b3RhbF92ZnMgPSBw
Y2lfc3Jpb3ZfZ2V0X3RvdGFsdmZzKHBmLT5zaS0+cGRldik7DQo+IAlpZiAoIXBmLT50b3RhbF92
ZnMpDQo+IAkJcmV0dXJuIDA7DQo+IAkuLi4NCj4gCW11dGV4X2luaXQoJnBmLT5tc2dfbG9jayk7
DQo+IAlyZXR1cm4gMDsNCj4gfQ0KPiANCj4gSWYgdG90YWxfdmZzIGlzIDAgKGFzIGlzIHRoZSBj
YXNlIGZvciBzdGFuZGFsb25lIGkuTVg5NCBFTkVUQyksDQo+IHRoZSBtc2dfbG9jayBpcyBub3Qg
aW5pdGlhbGl6ZWQuIExhdGVyLCB3aGVuIHRoZSBuZXR3b3JrIGludGVyZmFjZSBpcw0KPiBicm91
Z2h0IHVwIG9yIHRoZSBwcm9taXNjdW91cyBtb2RlIGNoYW5nZXMsIGVuZXRjNF9wc2lfZG9fc2V0
X3J4X21vZGUoKQ0KPiB1bmNvbmRpdGlvbmFsbHkgbG9ja3MgdGhpcyB1bmluaXRpYWxpemVkIG11
dGV4Og0KPiANCj4gCW11dGV4X2xvY2soJnBmLT5tc2dfbG9jayk7DQo+IAllbmV0YzRfcGZfc2V0
X3NpX21hY19wcm9taXNjKGh3LCAwLCBVQywgdWNfcHJvbWlzYyk7DQo+IAkuLi4NCj4gCW11dGV4
X3VubG9jaygmcGYtPm1zZ19sb2NrKTsNCj4gDQo+IFdvdWxkIGl0IGJlIGJldHRlciB0byBpbml0
aWFsaXplIHRoZSBtdXRleCB1bmNvbmRpdGlvbmFsbHksIG9yIGNvbmRpdGlvbg0KPiB0aGUgbG9j
a2luZyBvbiB0aGUgZGV2aWNlIGNhcGFiaWxpdGllcz8NCg0KWWVzLCB0aGlzIGlzIGEgYnVnLCB3
aWxsIGZpeCBpdCBpbiB2Mi4NCg0KLS0NCnB3LWJvdDogY3INCg==

