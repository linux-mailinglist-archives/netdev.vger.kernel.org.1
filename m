Return-Path: <netdev+bounces-137687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6699A9523
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 02:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F66F1F23D16
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 00:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEB182D66;
	Tue, 22 Oct 2024 00:47:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2040.outbound.protection.outlook.com [40.92.103.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40707A15A;
	Tue, 22 Oct 2024 00:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729558067; cv=fail; b=ClvMpVklH6yuhyWBnwKzIzKtJ+6Xe5eDyJSADmTbjLeJm0aE+CXFWIg1tJHsXQl4VL6ToNmhq27sMBsf7+hUILxk1B1uqxqHNnvdgVMBBFxX+EPWJnL4iFWJ6Z/W0JNMyqREZsosq3amm/Yd8tYwZqZmNHBXGEH97jfvuiIWJng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729558067; c=relaxed/simple;
	bh=ktMpXPEN3cn0BlwAum8KPYSIBbwWZW99xOS9KEwXHtI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eQXcXmvV9bGrtiLDOGiTv2whhElBr0TzWrOi8n32yhNLXx+VUaAImuScgdvIDSaXgevuIkjz/vJ5vpXs7kMkLA6r2ydLZ/JGZZt/cKNO1toVgvLP9OXpuuU8QnvuYm8mfLVz9pGYJVqflR3yEr1Ao4JjiZKvFnK9k0PevRQwPc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; arc=fail smtp.client-ip=40.92.103.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwNK0QG+9WD7tR59SDlKNlSvRrPI9lTr3QvkVuQ4ZFjbZIdV05f+Z3BnXaURjvnclw+3+ErFl1zWBBjDjUSRY/+nGtKUo410O7BA+GobipJYE2t//gLjQObUy34XK8tUt162GixT5LuoHhKHQy42wOe59uzj3iGbjOfowSR7m/uGjyJDDTJhQPCNucgEs0D47qwVCTmrO4XulCYp41CzB7SaO7ZMPQykxBAKJVggKKwQCnr7SXzRttHfIQs/vNjrDZJO+q+yv/6SQhUOV0oiwh6oUeaXOUH7A1eDLfeRfHU89Dkah0THztdfMQ1kfW/p1gZ2NOZiM61ZZOZvyEmaoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktMpXPEN3cn0BlwAum8KPYSIBbwWZW99xOS9KEwXHtI=;
 b=IFSfTj3GULCYVCDQRRTB2JCjRet1c+4uAnH27908CfLRw+4Z2eCI5l+lH/ZEd8c6ZAlO/2sfEmC/prCda/PyThWeF8JKenC/BYwVLO9liF00RjM0eVIvw0VBSePFl7anRAAkAPmAS1MpPqBhibO/Q//KPo3O0Dh7nGp07OWg/elRA2k0jembz5GrdwS/o8yB1KrKdu2PdyW8NG4B7rlLwOQcXmEnnB84AsDVrRa8Ms+auNANaaCw0+OvQKDBqUcsbMOMMzQeILLxzzkWyDPtYfb1mEJCZi5Gw2oNxZ0mN7RQC4JvDfcAo8f+JyHAoFDsnlpO4UvuJ2zuA/iKWYe5mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN2PPF99355ADDE.INDP287.PROD.OUTLOOK.COM (2603:1096:c04:1::137) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Tue, 22 Oct
 2024 00:47:33 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%3]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 00:47:33 +0000
Message-ID:
 <MA0P287MB2822C943624A02C54E9A62C9FE4C2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Tue, 22 Oct 2024 08:47:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] net: stmmac: Add glue layer for Sophgo SG2044 SoC
To: Inochi Amaoto <inochiama@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Inochi Amaoto <inochiama@outlook.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Yixun Lan <dlan@gentoo.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org
References: <20241021103617.653386-1-inochiama@gmail.com>
 <20241021103617.653386-5-inochiama@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20241021103617.653386-5-inochiama@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <087c1882-3cdb-4518-bf5e-1654bca3def8@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN2PPF99355ADDE:EE_
X-MS-Office365-Filtering-Correlation-Id: 30ce1516-4972-47f0-de33-08dcf2331dad
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|461199028|5072599009|6090799003|8060799006|7092599003|15080799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	mcP6pv9DMARQwpZIQu3wK55uU1NCVHvTdANbLRu0vr6g3Q8gXA/TMLdYiT87tj5tne2VmIbTa6cxkMF9mbbGmfgyqO1KXGwJfGpa1p8lMpAUwycaW4CpGks9WXUWzqGjRk81cwfXRSd17l2UjV6lO9IKEg+uQKrKq4h0HiwCMUj94+ZnTGg0Xuo+eJAozdbHqV3883/2uWwlzOFPNMW7p40ZTf/g1j7jTDmbJeiG0T93cMCXJVDalYuAgZPWHdqV+mOKC7siB9qWfVZDzo4Pwxt8Uum3FgAogjxvZpub5uV7IZYglCs4lxKlKLAu8/eCI8IB5ER71gOf38Icti+pSqM2rmjnRDxucJuw5mTsFTIGrB5bcBzsIXVtMpEEubVpDVzbcvfxsJRm1gNaYnYdV1agqU8LQzJYV2NpvOvqMEHG0HR1OTsNR0MoLGXx+6wa05SaBCGSMcCXe8Kjone9MHbKRPHgWvr70IVj6J46ucFxMaA/UkoF6lyH0x+wQiAX8utFOtCpAurIKgRndJzpS3WLEk9T5oy4LK6b7BkrRMTwjyqhkcr5u9bSlesTsGO3TgHbzcRm0qqRhOTI1bHaWUW/VDxBkmf4LU7VxeYpgDC0xXNk30yrzjWB07sppXnAdMwOtaTRigytKKgqC3gdscJGJ9r7il/ZSJREqRvVVfzD0dtDP1a7HjiESt+NItTXs/PJ5Ed/OonqCWisb8GRNpfESDlR1pnFgV1cWRVRhdsgDQEkBy8Xe8KKKsW1hMjxwW3cRXCojZwIQFFXaONe9Q==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDk2WjVnRXZSdVRpUnhGMlY1UE14TGxiQ1ZqS01WVFR4dks3MWdCS2RNY3Zj?=
 =?utf-8?B?dGZGMzlybmZBLy9iUjlXcVBWdTRtY0lkUjJQRmhlY04rU0xYMG9zMnFzZjlj?=
 =?utf-8?B?VGlOU0xrN3hDM2FNWXRHcEpaeVhBSG9zQ2pEWGJoK1QvQlpVNndGcmhkTUdZ?=
 =?utf-8?B?WGdQY3NuSjZRdXc5bkFENUhxSUZ3VG05VEx3T1ZVa1BlSGZZRUV2MDZUWURT?=
 =?utf-8?B?VjMzYnE3TC96eVZOWjBkZ1phcVNyUWVDMVk3M3E5SWgva3NwZ1ZVSGppbXU0?=
 =?utf-8?B?WnJ5MnpSSU9OVmpMQURUNlFvTnFtNnUyMkRaYitNSEt2UzhHc1FsYWNuOUpy?=
 =?utf-8?B?SUlFa2NsRkNjbVlrQ0QxNnlUZlAxTmY0MEdCbWplSVp2NTlqeUtSaThMK0c3?=
 =?utf-8?B?NEV5RjlQNlNKbWtRYXJhYVVUUVZNbDY4VjJVajNXdDBScDNaR3dhTWd4Vktq?=
 =?utf-8?B?T1pBR2FXZEtoeWNpYnVzRjBsclM2K3hZZ2RveHl6MXc2czhyUVMrcVAwQXRj?=
 =?utf-8?B?VHdDM2R0bWNjdzdMVDZaTEkxRlN6clBubnU5WEpCRE94czVaRWFsT2w5UjB0?=
 =?utf-8?B?RVVSYUZpb2lKOGZvQWF5dHBCelJQN25ORm1DMVpoTGZLUytQVkVtSmMxZk1Y?=
 =?utf-8?B?SHd0YzM1bEk4SVVsNWQ1OVJ1K2JhbnptbFAxazJWMkNIb0VYYVd1UklzUHVl?=
 =?utf-8?B?bGk2TFowZ1hYWHAzWncycHFReWtRcTVBWExaRGhtb2RBbFJGK0ZvdmdmV3FT?=
 =?utf-8?B?TTJvVCtGSnZiZG9vVERkcTlhZCs2b3d0WVBVQVBQNCtDOHROclM4SE00UnhR?=
 =?utf-8?B?VFhBUkVqeHhCbkxMb3d0R3NReGd0WmlLbXpSejVvRFh1aXhzeVA0aU84dzIz?=
 =?utf-8?B?ZkdzSkNmZFpZR0JXN3ZqUEttMnVjTnRHTzhhd2FlMU1qZjFYQWNJa3hoOGo0?=
 =?utf-8?B?eXR0N2lGUFpwV2xiUCsxZFNGNG1KbXVjdTlBUzZQQ0FUdTFOUlVzT0txRGpk?=
 =?utf-8?B?NWhxRklMTXVHS3diT2ZPTGN4RnNscU56aXZ4WU9zOVp3NWgzWVAzay9QbFRk?=
 =?utf-8?B?TDhVb1FzQnY4NkE5V2ZtdlBSVmp2QWFsN0xiTE1vWUZsUmtNMXNabXNNN2hN?=
 =?utf-8?B?aU1ZWTZhN1ZacUJCUkQyd2IvTytCTHZvTXFpMEZXQmxsNTVGbUVMMGFYR3hh?=
 =?utf-8?B?WDZUaEt1ejdNQnFBbXZzWVp4ekNlZzZUUENOaFVQczVYdFNRNGRIWHNUTUhE?=
 =?utf-8?B?KzhROVVkakU0R3JqQjQ5RERpMjAxWVlNdmhYYzZ0cTdNNTJFTzMyWk9XVmJr?=
 =?utf-8?B?WS9NTEdxYkduUCtTTXJiUTR6ZXhyeWFCZXc4LzlPMWZVbk91ak54RyswdXV5?=
 =?utf-8?B?eVljK3Jxbi9Jb0hjNlJVOUhuUjFxN3VoVkFVR3UyTmVQNk9EaFBraTBCK05o?=
 =?utf-8?B?d2lhRDE4RGlOeCtxcU1XSTRjQWJsSlk4MjRLOVp5Y1hmQW9PZ2VOZVR4K3h6?=
 =?utf-8?B?bExBSElVdFQveFhxa25FcldXd09WYldMMVBTTE1CN0M2aWJ5OSt1a1dWRk1Z?=
 =?utf-8?B?OTBMZUtvRjh5MVJhUmZ2Q3B2UFh6aHBzMzNSc1UxOGVScVIvNlZLRitUa01E?=
 =?utf-8?B?N3lYdzZtYXFLeGNoVHhXTVQrRERzTW04bUxqV0ZIRVdvdk9BL3d5V0YwcXlR?=
 =?utf-8?Q?97vk2OP717J+MuF7Al+K?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ce1516-4972-47f0-de33-08dcf2331dad
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 00:47:33.6697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PPF99355ADDE


On 2024/10/21 18:36, Inochi Amaoto wrote:
[......]
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
> new file mode 100644
> index 000000000000..83c67c061182
> --- /dev/null
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
> @@ -0,0 +1,132 @@
[......]
> +module_platform_driver(sophgo_dwmac_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Sophgo DWMAC platform driver");

Missing MODULE_AUTHOR ......



