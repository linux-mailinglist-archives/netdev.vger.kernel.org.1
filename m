Return-Path: <netdev+bounces-211600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CE7B1A546
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 16:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67D6E3A568A
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 14:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B901FE45A;
	Mon,  4 Aug 2025 14:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="Rd7b6dwB";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="dZbUAMCj"
X-Original-To: netdev@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823D11F582E;
	Mon,  4 Aug 2025 14:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754319112; cv=fail; b=p67gKKX6DgxmDXBKG82bVMy6bFXXkxGGOZC6q+DFuNHu1LIyKmuch24Z65dGYr/VRwA4V2hs+vumHioNnSlrWg4AiJNowa0QdAIecONfu07nA/RaTWEyaAvGtd9C4bJ0l8OSqgWsIIw3jukFM8LKTOLq15QTHhLd0iUt7znIpkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754319112; c=relaxed/simple;
	bh=RDv6J+SVvJmZA50cy2vybChMqT+BIDOtNZeiDD8pMjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fkeCO6vORuHpsOUCw/ZHqbj6uSeKBJOwifQU1BK60ltyj8SgLpDBqjOXYZu973w1jFHJNf3Kif1eeNRlgxISL+2CK2QFeZsAc8AgLn1XMm8iMXIh0pEeLYFIMK209GVvWKakiExwIueHt9MxuVspcHjfBQMu+1xcrxkfi196E5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=Rd7b6dwB; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=dZbUAMCj; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 574BTAC21716985;
	Mon, 4 Aug 2025 16:51:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	Pf9WaT8B07ugkgHGeUW5D6Ms2z1dRvDw+ySdTU6cobU=; b=Rd7b6dwB/GtNpiee
	EE6vOOw83ECNGdIEUfUP20UOoxKnX1mWDDIy7pDfqrkHz6e3WyEmDyeHx6KWIrk/
	T7IrJHM/gbkjz+9bpQVmXQp6vhitbBX7s+Kwode9eMn/9AXotf2peNagjTKL2rdu
	bZpQL0ViJsfzfobefHMQN08quGH9AdBWhaBPnKnvd/WnIDZrOJQ/CxcksNrdlLgz
	t1fTbWzqoelAgiWnNbdCETU1+TsXhvbQW0nV48NiNzlITWU4h4GcKrlaUSABU1vA
	pSHnJb7Nod8Cdr/1B9UdAYiGmSTr57pDO/BYcB6hPsqA82asxgKB0ZEzqh+IsL1R
	71TovA==
Received: from eur02-db5-obe.outbound.protection.outlook.com (mail-db5eur02on2119.outbound.protection.outlook.com [40.107.249.119])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4896p1sr6x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 16:51:34 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKum6dqloUnWMzQP3yxCNi7syNKkYqG6yOgA02HgMELvIqZeZiWcVsD5EUx9YDDnt0gEpEpyGbWNuX0azYlCYYyQHqh/nKY35yhUhp/dsz92XBwsf/PEUNhDFtQhuiyqn9TIYa2AjjFaHLQlCQKmx9H4wCSSOaIL2GcitvDeh3T9UD4cd0dcrooWiYHW2LNfqQAy2vhRPkN/bKHeB62pFGleBahLuy0yYyLUo9CS4AB97D69BG1L7md3GecVZeRV3pgm4xhoU28kxuhUeyUZWOO54xUckMQT4tTrxIoWWyOv5uYXxMhcl5BAcaWGWP48cz3aCpofJlkYDaJkA9iw7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pf9WaT8B07ugkgHGeUW5D6Ms2z1dRvDw+ySdTU6cobU=;
 b=BZeyqntkyb5xcoDmHNLJRhLVvXCef3nH0GH9RI0lP0ckyQ2u8vTLRjr5JVr9IrcXkZpypvZT3G1XC4RgvG4Mt94X5Zs9ylFZrzlT5oV7pkC+Qj4VTmqpapTrI29SOjGm0PstMK7rr7QhZzTjk3a8TfeINn7tgEcM5AidOmvBKje3Zdv5W1e/6/BAdYXelbh9bZ3xgbxJ+/kEEOxsVQ2vGsKngiM0j6cu3+SdLMz8DhYo0pqRd2UXbhd8RTLpD4YV1BQq5K3vsF95BqUZdHFsARl02TUpMhpuRiyL0s9jI9CgxlNp90ai3SOvim+K0KghXSkDs5htEdi1yzgI6nzv4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pf9WaT8B07ugkgHGeUW5D6Ms2z1dRvDw+ySdTU6cobU=;
 b=dZbUAMCjXjnN21E7QBaFMOqYcxtHH3K0XAUbWvcEdl91sAAjlO2um2zfEe6lqK/w6ShbYoQQq2Ct7U5uxNfHY7ktqBZmOx8wu7X9/a/vUmEeVs+ByJVza6UTIT2n1Tt5gvgvwuMy835mbJ00W4NzvMt5LTZWgYEP7oYz8VJeJr0=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by FRZP192MB2437.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:137::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.12; Mon, 4 Aug
 2025 14:51:32 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9009.011; Mon, 4 Aug 2025
 14:51:32 +0000
Date: Mon, 4 Aug 2025 16:51:28 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <aJDI8K2+kQQwH/dp@FUE-ALEWI-WINX>
References: <aJBQiyubjwFe1h27@FUE-ALEWI-WINX>
 <20250804100139.7frwykbaue7cckfk@skbuf>
 <aJCvOHDUv8iVNXkb@FUE-ALEWI-WINX>
 <aJDCOoVBLky2eCPS@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aJDCOoVBLky2eCPS@shell.armlinux.org.uk>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-ClientProxiedBy: GVZP280CA0077.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:274::17) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|FRZP192MB2437:EE_
X-MS-Office365-Filtering-Correlation-Id: af99794d-6c5a-4aea-c9e3-08ddd36666d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTREdmxXVFpPaHZKYzNMODlIR095QnBrbnNLeGNjS2M2RkZIR1UySTkxV28y?=
 =?utf-8?B?enNFWEpLM01HcjI3Sm9rOWgwT0Z1VTNjV29vMWltUWM0eTA4VGEyeWJZOHVk?=
 =?utf-8?B?MEZTM3NKNk1nMmpMUnpONit1M29Id29iZWVIU1Y1V3RSVlEwZDVlejFFZ1VS?=
 =?utf-8?B?Zml6UGZiQW5VT2hIUDV0VStkN28veEdGRGg4VWdzQzkrUWc4NG82UUNRSUdm?=
 =?utf-8?B?RkJDZ1hSOU9xVWFVaXN2cnZNWklXblh3eU9kT09zRFhmRzU5MUxJcDIrSWV2?=
 =?utf-8?B?ZkVNbWNKeU1wRkIrUTh0NTM1dUJybERYeWZGNDdUVXlxWm92TDdYWnBjY0E4?=
 =?utf-8?B?TFByRmJYRSt1V0lZOTY1ZGt4QjVUU2J1WHh2dFN2dDFmVUNSbnN5bDJaNXhE?=
 =?utf-8?B?Ym84a0R4bUQybjRKM2FoT2x3TmVRWmZGNEJ5STVPZ3IreFM1czJlUnlHUGs2?=
 =?utf-8?B?Mis5STdnNi9RU2RqSGdwRUJITUZKSG5EemROY2NUandIMU9iaW1XN2l1VWsw?=
 =?utf-8?B?M2xieWVNQ3pGejVJVTFzWnNaWU9CMXptRTlYWjdGZzA4akw3ZlRBRFVmQnBO?=
 =?utf-8?B?em9hUFo2UVdEdTFZZ09UN3pXMUVKZnRBSDVTNnlkWjVBVHRKZTRMWVZpWHVF?=
 =?utf-8?B?dW1mbXFzSGNPalg3VjlpZWZqN0dzVjRHWHJqVWdxNHhmSk1ObFlKOE5tbG8w?=
 =?utf-8?B?bjVFSkdVMlFHa09pYUJQTU5XaTJtREhIZDk0Y2NjUUhQamtlL20yZjQvRFNW?=
 =?utf-8?B?NUhKK3hzaW1ZcDNSNU5JbXZLTHdKOWJiU1VGVnMrVmJabFdXV2lIZkNIUmZZ?=
 =?utf-8?B?aDE4QkFJWnZOc2FsL2VSdlJuZTZxKzdUdzJRM0hsT1NTWkFoa0oxaVpTVzBH?=
 =?utf-8?B?WEtTb1pOVThUaktVaGMwQzlyQnJIa0J2b21JeFpWOEFMMlhBYm9aWXcrdWVG?=
 =?utf-8?B?aTJIdTlzYWxOMENHU1Q0cEE4ZUJZeXBVbVNJdjl4Y3ZaVHFZQ2swYlc0clRu?=
 =?utf-8?B?WlZDbnBIcWxxMmtsS0pKaTRlNGF0TDhBRWNnbmpjVzdOQ24ybVF5eWhrcGM1?=
 =?utf-8?B?L01MSmFxQlpUYTFPZ1o3dXRmZFNXTXlWS250VFhiQUZsRmZCU2kwemlUU2Rs?=
 =?utf-8?B?bkJ3VTAzeDQ5ZDlMc3lSSEEzTkt6MG1TcjlFOEJiRmE4Z2syRGxuNTBmZG14?=
 =?utf-8?B?eVhPWloybTZYQlRqTG5XTUtlSVAxWVlnOVF6OG9JTkNHQ0xjdzFadkZHVElU?=
 =?utf-8?B?Q1B4cnJmUFYvSUVxb3J4YTBBUU5uVmtrNlZKcU5VZlpQR091SDhibkh1S3E5?=
 =?utf-8?B?cGY5bW53YTNianhWZmpZOWtONzRvbE9MeUVwTlJiVkovUDQ2U0ZCd1lqNVZG?=
 =?utf-8?B?ZDZXU0FDWjF4OGpWdGo0d1l2QStFRFpDUjNWdFhvdDRHZ0pMdmpPVzBvSUx5?=
 =?utf-8?B?ZXBPbXZNRGpJQjlrVlhTdGF4a0VReUdrc2EwdFhXOXR4QnZrbVpYbzdxVTEv?=
 =?utf-8?B?N2JrQ3V3ZzNBOC96QWo3VWFDOGdZZlRSNFk5SDl0clJKN0FHNG1DMCs2SEVz?=
 =?utf-8?B?bWhvc05HSklvMTE4MHZqbldyai9hSmJhaGtVd25iSmhlN3E5S3NDZFJNaEpT?=
 =?utf-8?B?KzA0YW9Md0tFM29jcHRicHdqMDB0NkRJN25BMUJ3UlI4TGtqald0L3FERkNW?=
 =?utf-8?B?elMyUm1PR2d5NlBzZ2JXL2dxdmNKcUlFb09UazUwU3liQXhJeTZZWDJ0MzVR?=
 =?utf-8?B?S3h4bmtzU0hjajdmMWhmSnRhbzdTOTBvS3ZZVHQ2Mlc5V2x1a2piVjM5TXBC?=
 =?utf-8?B?ZnRIUkJuTGllWUJpajFkOHorTlk3aXprWnZIdUh5eStvSFpMRmVtTHNyT0xT?=
 =?utf-8?B?ak5wbDAyN1llbHZnMFVJU3lXMEFjRVhEM3FERWFFc1ErSkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RW94V05nbTB2MzRqSFMwVStKa1VlOWlPdFljR29tTHJqOTNzMGlxT0N1clBI?=
 =?utf-8?B?QURLQXg5Y2NtZGgyUmNBUW40WGtQZnpUTVRocjRwSjRjKzF6UDUxN28xUStU?=
 =?utf-8?B?aXloZXAyM3UzZ3Z6Si9zMWFBaEtlOWNlOHhRNnJaLzdHSWFXd2RpL1pDc0Fn?=
 =?utf-8?B?OTdSSmNydHdNMWx3UDVNaitBeGJMZzVYMlpHRzEyNlRMb3JVbW5TdzU2RXZv?=
 =?utf-8?B?VUZXUUVCdHFEZFhkcTNjYnBVRy9FS292cHBZSHZtRFd6V1QxZTd2bjh0aTRD?=
 =?utf-8?B?d0QvRHVPeFdMZk5Rd0QzSUJ3T1pYNERBdlB5K2ZZWXVlU1dWQnVCaG15NEwy?=
 =?utf-8?B?bmpsb0VIUVdEQndsVWNSaGRKZXRUY1NqNTFzQ1o0UjJLc3B5em5Ca2FId0JQ?=
 =?utf-8?B?YzRNT3BWQWhTcC8yTlN3Ynh6VXlGZ2IxSjVVVGRpTVlDN3J2dE0vSFE3cTdD?=
 =?utf-8?B?b1dQQmVUWGE2L0xTdGJDWGk4WXZtMUFlRVlyRElldUtncFd6WnhXR29LYTBQ?=
 =?utf-8?B?Vm5OUTZKWThXdEtRWnF3TExGRG5ES1g1MS9NVDczVlM0bUk5U0lPOHJrc1E2?=
 =?utf-8?B?dU4wTmI3alp2angybThQdHhHRHNUVHdkVG1qZC9mU3ZIYzBNVS9QUUcya0dt?=
 =?utf-8?B?WHpKTWtNblZGR01vU3VsT0NLREtKN0lmK2xMQ1VHcE1OVytvazNUbkdLT0Zm?=
 =?utf-8?B?cW42VUJ5aFZRczFrYVZJTDFtVTVXUVQyQ3I2c2VrbWRFVE03ckZOOVZxNVZZ?=
 =?utf-8?B?UFY2bEhQZHdNSmFtV25tWHEyZEZmNjZMU2lWV2NXZ2Y1UkVCTklHR3dZWnh6?=
 =?utf-8?B?ZWkxY3VMSEE5Y3NBZ0YwLzViNVFHcE5OQksvUk9KdGRRTSs3aEpQUncwUy8w?=
 =?utf-8?B?czI5NWhsdk1uaFJPRXBrQTI4aVV6bFdLYytDSDlqOG1iWTYzTmFBYnczcUFx?=
 =?utf-8?B?eGl5ZjR2cklqOFB2REg2R21PQjJWcnNTazQ4NWI3NnB5NEt4US85OHgzQ0cx?=
 =?utf-8?B?cVBWMm1LWDlZYUJzVFpLQ0JGaVpub3o0aStTc2ZTdHhqWmRqNkY2QW9kN2lJ?=
 =?utf-8?B?Z3VYS1lhZlgxMTZ6Rk45VStnSWw3WVowQjJHT2daVzZDTjd3KzllQ0dvcmQy?=
 =?utf-8?B?NjFNKzVEMjBGWDVJSnpHUEtoRjRVWUVGQkZaaEFLVHdSbGlWL2JpOFpSMlNl?=
 =?utf-8?B?S29PY0dIdktkRTJZWWR5WWRzbVNadWs5TUk5K2tzOGdFYjlnSjlkYWk3WWx0?=
 =?utf-8?B?NW9TWWVBam1LSXZyNHNWeUd6eU56Ym9BQ1IvM0crTk42NERqY1JlTFdDRzV0?=
 =?utf-8?B?L2VncGpmTkxtckp1Wk45bUJkY01BUXRUdnJSWFVQRitTSTNXMmg3S0VrOHp6?=
 =?utf-8?B?c2ZEMURKV2FzbURqc2M4VEpJdXUrVnRYVmZpbFQ3VXF5T3RSTjdQUXNyZ25V?=
 =?utf-8?B?Ny9GSytyOWFwanhHdDJKTkVBRndBNnNOTUlPRVV5SmNOLy8wTVJmUmtJUmZu?=
 =?utf-8?B?WHlDUVhuRXVoZHppblR6M1RHTEUrbzNpeWZkN1Q4SFdvRTU5ZWZpQk5jUE43?=
 =?utf-8?B?ampiVUhjZkNWbjUwQUprWHpRZTBpbUswVExwbHloTzdXeEgydEdrVitadDJY?=
 =?utf-8?B?MXBFM0E4L2NXbFBoQ2pyY1JpSFFkNTVQVWlNeFB0eUVyL0dEZC9UNVRxRDRs?=
 =?utf-8?B?SG9mVDhiMmRobmR4SGYvdE41STJaR1NvVkdmeEZnRHp4VGI3YWNJTHBoc1Vn?=
 =?utf-8?B?OU1jYlFoekY4VXFvNDh6V3FSRzhUeFpQZUJQakZzckZtVmZ1a3JHdzgxMTNt?=
 =?utf-8?B?a3pKUmhKL01BVEpXeDBrU2NyM0loYnFyUG9SSnF3bWlBc2VmY1NURG9GTFRn?=
 =?utf-8?B?UDZJbzNPdlpFV0YzY25JRVhzT3ZBRi9tU3ZYc215MWl5Rzl1S3JNK29lSUx0?=
 =?utf-8?B?NFZvRjVyMFBEZkxRSjhUcS9jTEFwR0pybjNVYzBOUm5GYWdQQ3pROTAvaWtL?=
 =?utf-8?B?OUx3WnIzeUhTcFo2YUpYZmxIeUZUa0tmeE5EZnM0R2VEd2QrditwQlF5V3Zr?=
 =?utf-8?B?cm5hd3M2RHZNQUplWWlaNTdxVGY4R2NMWm5HSmVhV1Fhb3JrSjJ2S2tDSTVs?=
 =?utf-8?Q?cwmfalW7wQOwlS3PV1dRgKdWJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JBMb2qKkx4kOqQLv5CF0y4PXSLksXBOpbDJK7ND3Pho6iO07sFQkDRdX1zc6HqwVEamlc9RdkSVqQGdgH8aiLSaPnyctum8o83GrD3rRGhenckA0ilyaFHWUPyaxpn0ydgQnjvfoeu/u09YIost5RETYq4V29yLXVzM7wHa8w0gaWQNfW5/Ru1MDcpp0a3EM+F4OMJsD0QnDZqHDJxZkioHmw/eZjnWY/LbfJDwUdsZPK/AvnQqoMVvi5lZTNZ+33Mg9qcDbEVoScbTbgEM34h81sPYKlKGTopS2dssYFDNlhwfnpHZ7Xbov2/5BSlK14TsGrWJ/pMzKXg4AhlB95rinmAquRV/NFM7JpOT2KDovTWXN2fTJ/hQkv9NIfpfnNkMfJj/7g9y48oHEXfWMgmVKs39l1BJsB6Bude/SGe6ghyWfsslKmCsc6NrhM8S+ivhQhLCAOdkNUu/RN7HhN6McK8VQ1DLAqw+M2Ew0A8VMJkpnDe7Wqe52wC+wjPs56qgtNKU4pzJr9SGIRoe4Aaia5N3qV1Y0+83J+3VZrMrqEpurXvVvUTOS37JMj2I87ERZQc6odjC2qjoaKQdvM9ZRrYCZPW7VBU0oKJRkmaqZmO12F3eW0xytGXqkvWNz
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af99794d-6c5a-4aea-c9e3-08ddd36666d0
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 14:51:32.1985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +vSwXjlcAuLNTP9J2WnvfuEbX1C2ycoCQcpiuo1g/8KLx7ZTETzCv9vIOUFIvYCHq3XovA0fun1XLW+2vI3kvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZP192MB2437
X-MS-Exchange-CrossPremises-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 14
X-MS-Exchange-CrossPremises-Mapi-Admin-Submission:
X-MS-Exchange-CrossPremises-MessageSource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-OriginalClientIPAddress: 104.151.95.196
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-Antispam-ScanContext:
	DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-Processed-By-Journaling: Journal Agent
X-OrganizationHeadersPreserved: FRZP192MB2437.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-GUID: fLec6h8DT6OYhlQ1j66pNlDGoSLFH2A_
X-Authority-Analysis: v=2.4 cv=O+I5vA9W c=1 sm=1 tr=0 ts=6890c8f6 cx=c_pps
 a=R+ZUZsJ5dPBp/xppKBZrrw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=8gLI3H-aZtYA:10
 a=aP3ZvlwEk41Fna-4CkEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA4MSBTYWx0ZWRfX1BqgZdAgIwOS
 xSVCS0O7HBy3V9w+5sECnQiavbUSTOxlvKtQC3XQcTOrte/11iR5nGgYrVtI+0Twd5pckDhEfiN
 Si7kg0uKyXeNwJaoVyjnGzULh/HBO6E8Net11AireI/0OXrZUrnEEj3suVIgOZ9ota6NHia6VIM
 qTftkCOJ0UO8LoiaTKkSklGNHOynKJJTQ3S8Yr4NKqTsyKtb7kDdvEIs2/lrhhGzMG8IM9aVP0c
 xqwrbQJCpEmCJznzZHQpJ9Q8sPYroMR01X1AgKFFqwYWi9qIxZPEJSjlEY1ZVWGdFCtGnMAbHO7
 ibjgNqBEUFYvBGmcMwfDKfAS7I2EKgsIdq7L6R7QAQpXlkBqiRpkg1x7dkLFN4=
X-Proofpoint-ORIG-GUID: fLec6h8DT6OYhlQ1j66pNlDGoSLFH2A_

Am Mon, Aug 04, 2025 at 03:22:50PM +0100 schrieb Russell King (Oracle):
> On Mon, Aug 04, 2025 at 03:01:44PM +0200, Alexander Wilhelm wrote:
> > Am Mon, Aug 04, 2025 at 01:01:39PM +0300 schrieb Vladimir Oltean:
> > > On Mon, Aug 04, 2025 at 08:17:47AM +0200, Alexander Wilhelm wrote:
> > > > Am Fri, Aug 01, 2025 at 04:04:20PM +0300 schrieb Vladimir Oltean:
> > > > > On Fri, Aug 01, 2025 at 01:23:44PM +0100, Russell King (Oracle) wrote:
> > > > > > It looks like memac_select_pcs() and memac_prepare() fail to
> > > > > > handle 2500BASEX despite memac_initialization() suggesting the
> > > > > > SGMII PCS supports 2500BASEX.
> > > > > 
> > > > > Thanks for pointing this out, it seems to be a regression introduced by
> > > > > commit 5d93cfcf7360 ("net: dpaa: Convert to phylink").
> > > > > 
> > > > > If there are no other volunteers, I can offer to submit a patch if
> > > > > Alexander confirms this fixes his setup.
> > > > 
> > > > I'd be happy to help by applying the patch on my system and running some tests.
> > > > Please let me know if there are any specific steps or scenarios you'd like me to
> > > > focus on.
> > > > 
> > > > Best regards
> > > > Alexander Wilhelm
> > > 
> > > Please find the attached patch.
> > [...]
> > 
> > Hi Vladimir,
> > 
> > I’ve applied the patch you provided, but it doesn’t seem to fully resolve the
> > issue -- or perhaps I’ve misconfigured something. I’m encountering the following
> > error during initialization:
> > 
> >     mdio_bus 0x0000000ffe4e7000:00: AN not supported on 3.125GHz SerDes lane
> >     fsl_dpaa_mac ffe4e6000.ethernet eth0: pcs_config failed: -EOPNOTSUPP
> 
> We're falling foul of the historic crap that 2500base-X is (802.3 were
> very very late to the party in "standardising" it, but after there were
> many different implementations with varying capabilities already on the
> market.)
> 
> aquantia_main.c needs to implement the .inband_caps() method, and
> report what its actual capabilities are for the supplied interface
> mode according to how it has been provisioned.

Good to know, thank you. I found some implementation on marvell drivers that I
could use as a reference.


Best regards
Alexander Wilhelm

