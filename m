Return-Path: <netdev+bounces-299536-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uv7WEWwqMGo/PQUAu9opvQ
	(envelope-from <netdev+bounces-299536-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 18:38:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A02368871D
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 18:38:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=genexis.eu header.s=selector1 header.b=t6fToeDu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299536-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299536-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=genexis.eu;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F58930FCC1F
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 16:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EE340BCC3;
	Mon, 15 Jun 2026 16:31:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023086.outbound.protection.outlook.com [40.107.159.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA6040C5A0;
	Mon, 15 Jun 2026 16:31:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781541090; cv=fail; b=n0GFTQ0b4AYCEdkqrnf3600SlyldTLhjNTy9Frt4S2sO0UNXJ1ZMyIDZevrSB1KWKxPAqlb88uKNFlhYSJIIaOFx/a7RwD4Dx6ndlLldNzk+KYjRJBlvQjdTjZ1Po4dZSpbKQ7/LdKe7Z94mPEaA+RNoin8dhdqbcvmMhmRlLGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781541090; c=relaxed/simple;
	bh=TytdQKYbu2nLdHlG7jOSlL80bv3qC+5mkuUikR4A6Ik=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RKzcBrIL3k3wEUmM5gkHaOavvn9fpDyX6uPyvcCsAOYztrPuPgbMtvOPeDvQxDhlBLN98ZJUgDIBlQn0pas7AL/Sqb3eqIE85sL0hXbtrHSFhjuB7OmWOewZHrgEpsSNbxJzoABQyHfTwFhQ/r+d4KqQf097T/ikF+INToRKoXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=t6fToeDu; arc=fail smtp.client-ip=40.107.159.86
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WG4K+VxYnx2+caLBzs1ZRrPrMA+ThOz4jXJtJyrXA05XIFMv+ydGtX5TLnk4kPOx3ITutFzGYd8nyiREr3HbsfOK3pYYTJsZ7LmOFqL4VkUY84iFco26iXgXPaTsqBAdPnq4q/TwoY51+I6WcReJmT+D0tXfMBceMvnWOq0I+r8GW3hb2qP0uv3ssjWTw8Yqpplgb7EWJQE6le2KCq2PadbkxJ48i2AhfmKnOXXkmG5F7N6glnlD7rc/kYVbTZV8Z+wz1lW+qzrMso2vHbh4H1OSJaMUeuxZtpw2+UvNcXnD4mFdcOMiNVvDEVLB7IAZTqbAWFs+xOEdcFy6KDapCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NasGHcUroOP3Nw6xE26fuJjayUMFOxbgddpKb56cf64=;
 b=tHdQTF+KiNVHaUMA+74guyALS6cl99ChHwuirQ24aW5hUv8U506+QPh3uEjMU7o0tbz0mNolZBidzpgkwumB+gHg++Rzu6kOsd/JqPp1pAnczdWlCwR26pNpWJIGO6xB6AGYG0cyd9kks7JwuwH3gOEneJnYws63loS/W6E0B/yy8tU1gsO49ILpEewpgp98qgvMSphJovoaP9H8fle8znpEevTuXgIiAe+43HxUK/b1JWDMamWEQFP7XgytNAh/r0UgJAToZOPzVIJecqY0f1lu2C8qNB5ZRmCrbj02UiFgO6GJKhObsmtmTzkvKA9jW87vVzEe72f2G221RwTayA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NasGHcUroOP3Nw6xE26fuJjayUMFOxbgddpKb56cf64=;
 b=t6fToeDuqYC7nmMoTkaI0WbfloHnjLaFWx3SRTlhkf3WL2up0CmjzQVmIOEX0PalHSk2nbBTiKMxROyc21krHD+8/utcqE/hlEcwaMOrr+oTdLTYLwDeHFbUGs814L7PYmHR4cJ0Mgm5ylL76hOdCx727v9Sn0gF/tUwws/a29Y5GPuNJ3RUE6/tWj86NiOCgG1mY1xSRm45JPKrM5Zs5JFIIdmBHio19Rc9ZMMqH5wmoO2l6Uz8meuzJqdHvIW30ehPC/Oyv1FKumDoLQrBFxXb21U8RDo2Kibxf6mpfeWSwXRRraruqy1akxvyvgOBcfDddJWAvtCZYrphxMjBHw==
Received: from DB9PR08MB6697.eurprd08.prod.outlook.com (2603:10a6:10:2ad::14)
 by PA6PR08MB11287.eurprd08.prod.outlook.com (2603:10a6:102:514::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 16:31:23 +0000
Received: from DB9PR08MB6697.eurprd08.prod.outlook.com
 ([fe80::bdec:3e95:6614:441f]) by DB9PR08MB6697.eurprd08.prod.outlook.com
 ([fe80::bdec:3e95:6614:441f%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 16:31:23 +0000
Message-ID: <5d030a71-c28e-44fb-aebe-486e8c4ad8ad@genexis.eu>
Date: Mon, 15 Jun 2026 18:31:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 11/12] net: pcs: airoha: add PCS driver for
 Airoha AN7581 SoC
To: Christian Marangi <ansuelsmth@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Saravana Kannan <saravanak@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 llvm@lists.linux.dev
References: <20260615122950.22281-1-ansuelsmth@gmail.com>
 <20260615122950.22281-12-ansuelsmth@gmail.com>
Content-Language: en-US
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
In-Reply-To: <20260615122950.22281-12-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0042.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::34) To DB9PR08MB6697.eurprd08.prod.outlook.com
 (2603:10a6:10:2ad::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR08MB6697:EE_|PA6PR08MB11287:EE_
X-MS-Office365-Filtering-Correlation-Id: 97f068e3-3820-4487-88f4-08decafb89d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|921020|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KeQKE39+ef+RmI0gARN5VTSDHydSaR7vv2BU8RkF8hMos/T0bozTbfyCQXhddl4PPaB11/i2qg0PnwoIRvE0+83XvmliWFA5lIumh8Xn+PCe+Z7cQ0OQ8AX8o8LQ2lEN3zGRc5gtlc6/D2CUUSNQx0574z89doGK0GCPo9ii9XDALy8AiRZyVafQV53WklX/PEVtWXsTIdUsf2QPOt2V2qZQAUzvmslK2Sb9/fcLHSNdwwaw+l+UKEy4OtRSJZfUfpSfAUnj+fMKqpziZI8geV/eEhfOiEA7lgYOFXeCi/u9J3vqGFFaUyrGr+JVbzugsG27N+5cD/mJTYhhwj1nBVFJlWMrGDRlnYKAEcifTqZuBXTzQT2Kj10U5VuodZqNJuTpPlZ2Ewsnch0VXLu8RwoRQu7V+gRWsmAXvACGjHuGfTS+HkMKEXSp3o2yb0L9NbgbCkrOTJL7hJCju4FHS/n2PCeB2CQ65jGDhxzfn6ukc/DcsIVps0xa4ZhoSSqGbodoDOJtm1agO77lVcQ5VJyb7jWGk4q0+F5Dtn1uMaXi3cnjPDNWISpy+CoUCuFReKqk3+90gX5+7ZPgSVGfNla9M2lY/tzIS2nk3WqvcpxpRCNQ3pVlgXk9UB1CCyxBhXemDDD5sz0puqq1F2LOaDPznhccDBppF3+xM62YKhuc1CYjUXQD61aC4XBVndrAJxfnwTck+Sfr4ZPxO8+XTP9wfMnc88sJY9kPbeCEfX8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6697.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(921020)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUV0VEFqWU9QRFQxOUdSeDR1VTBSWkNiTVdZNFFNbWM3L2l4Y3JGRVV0T0t1?=
 =?utf-8?B?Z2plZXJHV1gxeXJXY3llVGNod1l2aHlUU1NGQ3EwaTZWY1JrdlV0bGpqNVd2?=
 =?utf-8?B?UFFFb2ljLzlxOVZVemlKZ1FSUDN6NktrcS82MGRrS2RFWkVKejRkVnUwbm9p?=
 =?utf-8?B?ejlJVkMyclRnUDFiR3MxU09DSlVYbDhRQlZnSDN1ZlJzSWdveDl4ckZrN0R0?=
 =?utf-8?B?NzFET2VNekZ5Wm5YSGdOZm1JQmFDcHg2dlQ1cjlYaVN4dFdWbzNLOEtic05r?=
 =?utf-8?B?dTBUVXdYamlHZEkvQk5lbDR3bzVJZkRKTldWU3dmbmdiMEFIS281Z0I1S2FT?=
 =?utf-8?B?YllWc1pNTDhweDI3LzVYYkhuV3NMeTg1czE1Y0NHSmk1OU5PQnZEc01SU25j?=
 =?utf-8?B?WDVZbTZrS0JZbWlUZGMxbWJYQXFBclVIaVhkK2xYRVExeHpqZExXN2VhMkI3?=
 =?utf-8?B?Y2VqbWJpREVaZloyaXhYMGNoN2Jnei9iR2Z3QlNkWkd1dDk5b0tjejBFZDFO?=
 =?utf-8?B?ZGJvU3RuNHNZZk9RT0ljb3JMNWJnRFY5Wnl0WkNkVU9aZmdvbnJXbDZmRSt6?=
 =?utf-8?B?SXdDYWFmTHN2ZjFDTzc5S0lSMmhPamcrL2NqMmg3TzhKdGRqT2FqUTdkNUhn?=
 =?utf-8?B?SVFLNmIvSzdmN2JscHRObFdYSkxza2VxR3l5QzhpL1liSjYydFpuN3ZQNEtF?=
 =?utf-8?B?QVpJeGl2d3pVakcyMVROQTVNSnNqUVphNko2MEdUWm8yNEJMSXNpdmh3bFhX?=
 =?utf-8?B?QStvUVFaRjY5ODFhNGJMNmNVbkxSdlBnV3o3VWx0SEgzR1BxcGRabGdSWC8v?=
 =?utf-8?B?cnpwdXhKbE00MkxYWmZYQWtMWTkxZUIxbXdIaWhTQXdGWStudG1veFRPdjlz?=
 =?utf-8?B?endxNGV5L1RyWjQ5ZzRudFdhYW4zWWJwS3gvK01hWWcrY0I2RmFtYnVaUkRy?=
 =?utf-8?B?SU5TMG95NFFTOEVMaVJPcVl5bEdRQ1Zidzl0ZWt6YUwvWVZ1WVhremJkSHNP?=
 =?utf-8?B?MXNYcWJtZnNWbjJXMEZka1FwbWprNGZSWEs1eUFzc2dhUXU2RjZpSGY0dDRN?=
 =?utf-8?B?cjFiTnM0djlsdXNxNWE4SG5TSlEyYlUvU3ZUWCtEbGQ2cjJaZkxWR0kvbG5W?=
 =?utf-8?B?T3pHVHN4WG5BOFFrZlFmNncrMnRyWWpOckM3THVZZklud2dxREFNVS9mVFJB?=
 =?utf-8?B?cUt4ak5RbGhhVVhSV3FFbGhUK01kVk5NVnF2SEVTK2hFMVJVVWZZQnBBcEpY?=
 =?utf-8?B?TlJ0UzJUSnZVUVRXZlJxV0t6dFFZNW00RjJBbUpNVU5DQTRKNktQbThVRExD?=
 =?utf-8?B?RlFhYjZrc2JOblA1MWN3STR6OThkTld0eGdHSE9UREduOUJTdThoeHpTYjhH?=
 =?utf-8?B?QU1BQ1Y5K1MvZXBMZFZxSCt2UXQvaUNRZVFxQzlRM3IrcEhVanJ6UzhERzRK?=
 =?utf-8?B?Nm4yMHhOeUZRcmVtY243NG0xL0xycmlPajJKUGRDeENGMmM0TmVieTM1dW1o?=
 =?utf-8?B?dFhGRTU4VlRwSTJjVVNTRHJ0dlN3MWFJT1Y4d1oybyt3WDR6Yzc4R2JsVGFj?=
 =?utf-8?B?OWxxTFNsaXNNalZ6NVh3SzBaZjE5c1ZYaXFoM0FsR25hZ3V5OUgraTJwV29o?=
 =?utf-8?B?clhvNy9ycDB6bDZONzVqMGUvNlBXQkVUM05TNkFvQzhTVGViMnRYSHhNYVUx?=
 =?utf-8?B?N08wMllHblhSM3JMTnZBUlFWZlZob3NTelF0YzVNS1B4cnhlTzZIcnpMM0tW?=
 =?utf-8?B?Zi9oUW5kcmJ3R05VZEdhQ2RNRXFWb1BSNkttUS94SEQwVGtTbk5rOXdXUzdB?=
 =?utf-8?B?UkRCREMybDZFSHliRy9TTlFRVVE3UFJnOTZEMk05T0dKMVFFMVVLWVN1ZXhx?=
 =?utf-8?B?SlhQTFppNWxyeXVZMWE2MGNBUVVZQjlzVm45Z092ZXM5TjJhck0vaVhxR3h5?=
 =?utf-8?B?ZFFUbzFGNjlJaUpzRWpGM0JYNzhyOHlmUVVtdlBheVBDYU5KK25OWnJrTFcx?=
 =?utf-8?B?VjZvMDdOYWh4SStrK21mMkJEZHRRTFZsZGpESElXcnhtODNiQnZEQk5PaEds?=
 =?utf-8?B?ZXNTRWdzSlRZZXJObUhXQmZjOWpReWIxSDQvRXVLc0FzaXpIODI5UTFEeDFP?=
 =?utf-8?B?R0xDWmNHd25jM1UrbU5BemV1VGpvZ0FUamVPWE84YXd0Q3lwSVlCZm1KbFRI?=
 =?utf-8?B?MkQwN3d1Rmh2M2NSdWRwbGF4KzRLbU4yd002WmxtdXdSdVZnTDlIR2RZUHhP?=
 =?utf-8?B?ajVRTUxRc1FJNUJ1WE5RakJuRkkrMTVPQjdheTdNWjc3bXNid0tXbDZMNjdz?=
 =?utf-8?B?cUIwSWZPTWU5dnAraDJMa0RBblBGQ1pYcDRLYVFPMTJBdHlKb08xRzloN3JM?=
 =?utf-8?Q?2Yz3wCoVDf3EY/sg=3D?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f068e3-3820-4487-88f4-08decafb89d2
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6697.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 16:31:23.3573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPDpToeXDeDOXLTTgTgaNQjQsTHULs62jN22riaflzjvv5FqDmTkRA4NoDYUlVNaoXlt88sbYm5LMw+nZrzsBglJ6NEOKTEtywSnwam0cjc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB11287
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[genexis.eu,reject];
	R_DKIM_ALLOW(-0.20)[genexis.eu:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299536-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,armlinux.org.uk,pengutronix.de,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FORGED_RECIPIENTS(0.00)[m:ansuelsmth@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:lorenzo@kernel.org,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:p.zabel@pengutronix.de,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:llvm@lists.linux.dev,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[benjamin.larsson@genexis.eu,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[genexis.eu:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjamin.larsson@genexis.eu,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt,lkml];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,genexis.eu:dkim,genexis.eu:mid,genexis.eu:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A02368871D

Hi.

On 15/06/2026 14:29, Christian Marangi wrote:
> Add PCS driver for Airoha AN7581 SoC for Ethernet/PON/PCIe/USB SERDES
> and permit usage of external PHY or connected SFP cage. Supported modes
> are USXGMII, 10G-BASER, 2500BASE-X, 1000BASE-X and SGMII.
>
> The driver probe and register the various needed registers and register as
> a PCS provider for fwnode usage.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>   drivers/net/pcs/Kconfig                    |    2 +
>   drivers/net/pcs/Makefile                   |    2 +
>   drivers/net/pcs/airoha/Kconfig             |   12 +
>   drivers/net/pcs/airoha/Makefile            |    7 +
>   drivers/net/pcs/airoha/pcs-airoha-common.c | 1318 ++++++++++++
>   drivers/net/pcs/airoha/pcs-airoha.h        | 1309 ++++++++++++
>   drivers/net/pcs/airoha/pcs-an7581.c        | 2093 ++++++++++++++++++++
>   7 files changed, 4743 insertions(+)
>   create mode 100644 drivers/net/pcs/airoha/Kconfig
>   create mode 100644 drivers/net/pcs/airoha/Makefile
>   create mode 100644 drivers/net/pcs/airoha/pcs-airoha-common.c
>   create mode 100644 drivers/net/pcs/airoha/pcs-airoha.h
>   create mode 100644 drivers/net/pcs/airoha/pcs-an7581.c

Most likely there will be pcs drivers for the EN7523 platform also. Can 
the common code for an7581 have an7581 in the name instead of airoha?

MvH

Benjamin Larsson


