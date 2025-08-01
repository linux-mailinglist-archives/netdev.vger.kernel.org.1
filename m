Return-Path: <netdev+bounces-211349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A304BB181E8
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 14:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 028BB16344C
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 12:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A06B247293;
	Fri,  1 Aug 2025 12:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="IL/f9dAZ";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="0Bl+Hej8"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0E523F26B;
	Fri,  1 Aug 2025 12:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754051810; cv=fail; b=Ka+VK/j/AYQGDyOql2eR+3vU5oNKYJRrHBx8iHj79Xo2G5uLRaxiVfjKjGzkcidUW5XwQJU47oW6RdIE5NPE5pCsospkGFZ2HEqmgiNOmLdRFA7Yf3YtY9cMPIw8fOy6NNZ98K6qBKmaWwLniH6yLwocp+i2t6xSvNysSBmRQmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754051810; c=relaxed/simple;
	bh=pI7bWwhyrGhxS32CAtrPtwqz5jwHvb/r9NqF6q64rTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EIoofVcMzauWDpR1fNsBAHwyrgKuxBomUlwMU77ByNKuZzUkHjooghFd0rUrcK7L4Wh7+IJoL+g/nbBbCXPhEeOO0iwr3NNwfJ2TUSlvSWUajFZld2/IzffGxrGadtA9Yy/+KRku2UgWNiEVOT4gxtjI3rekQGahMW5kIrKKZzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=IL/f9dAZ; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=0Bl+Hej8; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 5717Ma552233728;
	Fri, 1 Aug 2025 14:36:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	lxZKdG9cKP29/hlfkxe9EhG8DDZWHteCdhsL5b434a4=; b=IL/f9dAZeZ9bhOu3
	4ONpaPU69nwfyuOZrN5T6SoGbH/YIFURlKKr/NCseOEd/iukAbFq+RgE7PnjTTwN
	rh0ei5xG7f6F5e9iqbEC18+ebZ05eFiG8S+VU+Mj1nV3+mP9wrGS1zy+FnJtN3v3
	UMG00CdM1q9DZn+bh0gXeK8Hir/soC/oVXZ/NepvTZm9e3HUg2Uk/aSfya3W1dDg
	Jm00mq+P5BSdvb8YGbeoZcwRKPwhT5PGAexrDQu/2xqpYZ0Esofq6KMVQW/2/S4A
	FBVX1FMJiP9BPfpfClrYKQ1HendpjQvKpJ4ByFn4FKbh8LQ1tp2nhcMlXgSrttAp
	xdcY/g==
Received: from eur05-am6-obe.outbound.protection.outlook.com (mail-am6eur05on2126.outbound.protection.outlook.com [40.107.22.126])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 488c9brsnp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 14:36:29 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pd4bYAWEJZ8k0JrSjKb8O28g4Oz5NSx/g/NTH2t5IxEir0LGwrPkpUdzKUSJgF/IyXI2uGtklo/PA1kiMqftesk21ztqCCAanBUPdXVk7DLtmp3IwGVFR9Q2UUvasXVdx70CWflWW+caIM02v5TgG8qqb98EyhBwjd7s0q6Tj46Ov5Q+OHAJTesYnPum9OeM1ystdjSoA1MgNJNw+qIhnHU1DeddlRfEw+TtcNWPcmJvwOzuTzRKCB/TJioCgqogzYQqsDgxckaylSE4zc8MWyo1/q7rspLcsKSoL6rnuH1sK52lHzxCZ7w0TUkDJA0hKrHdz/nakN7FD+mwZXp+lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxZKdG9cKP29/hlfkxe9EhG8DDZWHteCdhsL5b434a4=;
 b=yY2KOiowNRqRflXyDUI6cRr4Co0vCEkbceaOiq9gvWqCCgy8/lSc0N83/rztgLgjaGGKnn7VmCW9q7mk0yvYXSVU9l+3NGoJPS8KXr/peRRpRNqQdrfRTR+xOvdYAWXdS1zX2RmaMrgO0SvgDO8SmKu+1TYHkIGuKdHcTh2RNJlYSKgn0KQcIVXE9EwuH1d9shnow3rH783oiugo0NAT1UZM46B2SuUiRRrwnbe8Ua/dHMXRTR+A9s3qVTgpnG62WhQbw7/SIAMfbFtAs3UXcrEdGuJJ1rhKY3EJchPgBM9SpmtxhtMzHMDkQy99s+bH1UDYs/btyWR+Uflf+B1CyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxZKdG9cKP29/hlfkxe9EhG8DDZWHteCdhsL5b434a4=;
 b=0Bl+Hej8DXq4hTccEcn511aoqDi71zCqIhlhAzFseglwsawkKSsAmd4rmmThHtWjveNAzhiyToX7AdnRPm/LCK5GKE7qAbEfF6XRx2DbtQZoLmmkJXRPtLOzkCwC/lABcFG58F8oD2B958joMQNX7PZDyhEPTlHxoOxRf0IGntg=
Received: from BESP192MB2977.EURP192.PROD.OUTLOOK.COM (2603:10a6:b10:f1::14)
 by AS4P192MB1670.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:505::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.9; Fri, 1 Aug
 2025 12:36:28 +0000
Received: from BESP192MB2977.EURP192.PROD.OUTLOOK.COM
 ([fe80::35d9:9fe3:96b3:88b5]) by BESP192MB2977.EURP192.PROD.OUTLOOK.COM
 ([fe80::35d9:9fe3:96b3:88b5%6]) with mapi id 15.20.9009.003; Fri, 1 Aug 2025
 12:36:28 +0000
Date: Fri, 1 Aug 2025 14:36:25 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <aIy0yWH5+PauhNU5@FUE-ALEWI-WINX>
References: <aIuEvaSCIQdJWcZx@FUE-ALEWI-WINX>
 <20250731171642.2jxmhvrlb554mejz@skbuf>
 <aIvDcxeBPhHADDik@shell.armlinux.org.uk>
 <20250801110106.ig5n2t5wvzqrsoyj@skbuf>
 <aIyq9Vg8Tqr5z0Zs@FUE-ALEWI-WINX>
 <aIyr33e7BUAep2MI@shell.armlinux.org.uk>
 <aIytuIUN+BSy2Xug@FUE-ALEWI-WINX>
 <aIyx0OLWGw5zKarX@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aIyx0OLWGw5zKarX@shell.armlinux.org.uk>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-ClientProxiedBy: GV3P280CA0120.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::26) To BESP192MB2977.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:b10:f1::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP192MB2977:EE_|AS4P192MB1670:EE_
X-MS-Office365-Filtering-Correlation-Id: 3331f530-7ae3-40b0-3643-08ddd0f80948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2xkWWhWclBwajQ3dHNMTEFHdlNsUllCWVovZlYzU0JlV3Q5SWlBd1UwNllq?=
 =?utf-8?B?NzRpRitCK29IRHowZngyT3ROR3VJbVp2R3BHU0laTHc3U2VIcC96STRNMzRm?=
 =?utf-8?B?TDRhWUpVYnc1ZHlpQy82VlhmaXhxZWZFZFNUUUxvSUhVdmMrSTlPSHVneDBF?=
 =?utf-8?B?eWhSSzRKdUpTRDlwc3VEaUZvaEtxL296Ym16MmQwUEtIOEVRMGJyUytQZUZl?=
 =?utf-8?B?MmlzdVZpVnBOSXM2eDlzbWt3dzM4azNpc0VNclhDay9WM1hzOVpLMHpyVlBh?=
 =?utf-8?B?Yk9DYVAxR1VsUXI2TWpnZU9ZK1g4YllWUFA3WDdiblZocVN0bm1YTmtMTDQ5?=
 =?utf-8?B?LzFNVFJWRGlVMmZkdDdZaEh1UTFKMGp4S3hrNktudU5uSzRob0s4ZFY3MHR6?=
 =?utf-8?B?TnNjNk9IcEJ5bU5tUE8zdmZsYWNjMUc0NkJiRVNBcE1zUWZzUUQzbUtWdi9Y?=
 =?utf-8?B?VFFISVdOV09KbGF4N0xsTkdoMmNlc0h0TDVZeW1ZWkNkMFBSY1BWbUwrYm0w?=
 =?utf-8?B?dzZCamFJQzE0cnJ2RXVSL3pLLzBRazVYcytsUVlyalhZVjJKekhHS1ZRMEs1?=
 =?utf-8?B?dGlycEtVSWc2M1pReDZjYjdFeEtBczc5UXhvbGdwOHh0SzVSbG5UVG5NVE0x?=
 =?utf-8?B?UVJKbXhZbDh4OWdSOURVOXB5bUpTZDNPRUlRRzIrUFd1d1hoM1VIVjlKUU1q?=
 =?utf-8?B?M2FKUTdMcFUwc0pXY2RJcUlaTFN4SWRyV29vVTd5M2ZWSjcxdFF3SVNqdDJN?=
 =?utf-8?B?dy9tTEFRTTlQbkt6NFFzUGI0K04yVzlQdWlldnZWb05BMVFlSVBJQ1NwZ2t3?=
 =?utf-8?B?Y0hVdGlvWnE4N1Z0TkF4RkRjZ0grU0Rpb3VUU2xSdlJ4bGtYREJLNzJCckFW?=
 =?utf-8?B?R0o4REdhTUxESWs0MHg5bCsvcXdFK0VaQUNNWFk3ZXJQMXBuSDliaytnNWpG?=
 =?utf-8?B?VW9EZHJ6K2xUQzlsdnVXZ2JyMWNHNkNSZHg3UmFkL0ErWmNUc05PNEVnQTFj?=
 =?utf-8?B?aXpmTWVqOWVQYWk5SHQrRzRuSzh3bE5FWk9oa0VhVVZabVhBZlMzQTlLTDBJ?=
 =?utf-8?B?M2tXUmJMUWU2aTloMVJFUXhUclliZHVyWGN2bVd3MWJBdGJmOTdXdzFIZ3J2?=
 =?utf-8?B?dCtIUDl1UVUvZTArL3htbSt1TjdTTlhJRlNsejdQZTUyV2VUL0U3YjJPVmF4?=
 =?utf-8?B?c29rcHg0cFpBaFByYzQvc1dkQlhKYXVVUzVtM09CaWp4MGk4UkFGNkhxQW9l?=
 =?utf-8?B?K0l6Vzh4K2gweEFLbnF4MkJhUm5LeTdSQ2QwRWhoOEx3d21OcTkvZmVoa1RG?=
 =?utf-8?B?QzJXd2dvbGI5aXFMclVJU0syMWQwUFBNcnRGTTkwUEUrMjBTUHNjU0ZaeTk1?=
 =?utf-8?B?WVZ1NTJmWE5aZ29RSG90QmVmT0RXUVRVT284ZCtpUGFSOEJnOVlkQTJuZWlH?=
 =?utf-8?B?ZWYxR1RLWTZxQkdONmxUOGpnai9YT2VValRDRFlENFVqSzZQWWVyUkRRd2Va?=
 =?utf-8?B?Tm1pWm1QNG9mM2tpeUhUYU9jWjBqMEhKcDI1TDlhNHlUN3JIYXhlaEo2YVdM?=
 =?utf-8?B?Skp5dVRTRVljdVk3ZytoSENwSDBRNkVLLy9keWpKejBhckhoMDNJKzJ6SFhp?=
 =?utf-8?B?NngweVZvTDc1b3hEc1hKQjk0cEhnSUd0U2tGeEltcmczc2FRdTBqTGRCZEw5?=
 =?utf-8?B?M25YdEdBTXg0L3NOWkF0dUwwQ2R5cEcwZGh0VDR1TFBmRDBPUXdNSHI4OHRD?=
 =?utf-8?B?czRFSUJpR0ZKSTFxWkJyWkN0YjNvdkNJbHRtOHdoRnlReFBPS3ZVOHYzVnlS?=
 =?utf-8?B?Z0drRzYrVHVjRmw0SERtTm9qN09CZ3BoT1ZMdmZjWXhwTllWUWlZNFJiUU5B?=
 =?utf-8?B?b3JYaGRUVUc4bko3K0o1YUt3cmMxUEZDY29CS2lYK280UytjYVduc2RHem1q?=
 =?utf-8?Q?trTrgqHqJwg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESP192MB2977.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUgwdERPYkpCaC9FL0h0WXZmTjZLUU01M1BZY0NQM1c2em9zVFRJSUc1a0JD?=
 =?utf-8?B?RWIxQUF4d25zZS93T01zQXpLR0JBdUVQUlVaVjZpNTlKZmdzSW5FYW9RVzFY?=
 =?utf-8?B?YjV4RkNlaHdsc08wWWZSNGs2L3lualVBVnpjZ1NWa09EdTVsdTNFRElIVGUx?=
 =?utf-8?B?VjdvY0QvbHMwT2hJbjFyc2pCQ2RrVDdmVFJsMEtWL3JtMHNqTVRKcHJrWUhS?=
 =?utf-8?B?Wk5OL3YvTjJoTkZkeHgwNkIxUHBKSWNWelFKSVFCc0xiMzFqNTJhM0VOWlpt?=
 =?utf-8?B?TUxSYVUyaUdMQTVUdVFSOTZrbGJ3cnVuaVB1MzF2eUowbUJ5anQxR2pMTFlC?=
 =?utf-8?B?aU0vYzN3RFNwcUpyMmdxVGRvTURsV3Z0dkZ2azVoazJOUmpCUEFMdmlVYUFm?=
 =?utf-8?B?NEQyT0graWI2TzcvclBIQWVIL2J6WldNSDF0Q2Rsdi9DNk5HWWNTTVkwbTJm?=
 =?utf-8?B?VkxFMWg1SjI1UDM0dm53NlVWV0VOUEpyandHRzBpamhpdWhxMU92ajY0dnZV?=
 =?utf-8?B?RWtkZlJib0pVbW9ZbEpFSWtpbjNOMzJ2VTVzTWYzR1hjQ08vRk10U3NLdTV5?=
 =?utf-8?B?ZU15RmVuL2htRWw1L1JjdmhUTGMzZHdoYUpub21Mait2dTFjY1JPSzM1Umhr?=
 =?utf-8?B?dEg4bzJoZjhtNFFJRDZmOVBtUFJLUW5raXdZSUpMQWl0UjM5K1RCM1A2N1hE?=
 =?utf-8?B?RFR6YllQSWN6Uk5ETmN3VVRrQVFjU0YwZVgvUklObko5TzRSbmYyMlcyK3JS?=
 =?utf-8?B?d3FiTWN2c1RENE5XRWZ6QTBzS1h1N1J4WjRjNEFaa2h2TzJpckl4Q3RQK0FW?=
 =?utf-8?B?SnBEd1Rody8rVHpReVVnY1FlVGZtRjFnSHd4SXVEaDV4eDRwUmgyVmR4bGIx?=
 =?utf-8?B?bURvWi9nbHc2QVNLeDZxNDczUGNuU0tDM09aY0xNYWN3cWFSSXBvajY1WG0w?=
 =?utf-8?B?eXdMN3NOM2NoL21iUUphNEdldGF5d2FhM3BibVJFRXgzR280NHhrU3kxOEZX?=
 =?utf-8?B?UjJDU1ZsOVdKVmpuN1JnenI5Ty9FQ3I1dTR2WXlyLy9tcWlmVkw3VjRHb0du?=
 =?utf-8?B?d1VWSnhSZ1RPQmhxSGt4WU8wcnVCRStyaVYzWkhGaHpJMFROL1d1ckZqeUlF?=
 =?utf-8?B?K042Qjd0YVRRL3piRWdqSDByY3pjREVZT1RZOERWMEwrc2dsRGlMbWZnMHVX?=
 =?utf-8?B?WVZhaVFWaXFCcnUzU0Y0dGQ5Q25xb25KL09jSlhYbFMvYWRrWlFNTWVKU3o5?=
 =?utf-8?B?WU1GR1U3MkNjWGJaeHM1V0ZUL2Y0OUU2NXJqcit3dmJnWElxKzdUQlFPcTVv?=
 =?utf-8?B?U3pxTnZRZzlYblRCTm9NVzZDbVBGS0xDVlNnalBnWWZUSUdkLytsNU5MUVE5?=
 =?utf-8?B?ekNOdEM5aFdhL2YwZTM1MCt1TGc0MWZkTDd4YktTNVByZHluTWIrL2JrUnhG?=
 =?utf-8?B?YTgxMERmVWRXQmR6ZXpOMzhkbHh3cGNjT3JDbTZmTTB0RE5RU1Blc2x2RHM1?=
 =?utf-8?B?VGxwZStxMzhPS0M0eDMzVWJPWC81N2pPRkM0MnZGRkJjemNvUDhpWnFMbDh4?=
 =?utf-8?B?TEtSZ1JqQ3N4VFNlSmlJTkJMZUU0eXQ5TURmanY1SGYvWHNLU21NcGcvWlJK?=
 =?utf-8?B?T0IwdzhYZjd5MWZTc3BwcncyR21WQUpXSmlWSlpBcllQcTNHdmF3bmlXajZ5?=
 =?utf-8?B?WUwvVlR0bG1IT3psTk1vczN3bVJoK3hRV254Q1Ezbk9Bb2FQbldJWjRCT2JV?=
 =?utf-8?B?aFNWYUJNMWY4VVBja0JJaUxFMEdjZXdZRi8zSUZjTXFGN2hjZlZneGZkaG5j?=
 =?utf-8?B?THpIZkFma21QaE51cWhmdTkwTDRUUkFTNW9QZTd3N1lNOEduOW1ITkpzcFRC?=
 =?utf-8?B?cksyZ2R6LzBvNlNiaWdLb2ZEOUI2VnVBYWhYWm16eE5ZSWw2OXZvZXhrak1G?=
 =?utf-8?B?QzJ6Q3hNRXRzK3RaVy9UbFI1YVlQTVhWZkEvOUJpZnFNenVQYW9ER0x6c1ZI?=
 =?utf-8?B?Z1V3SEdEcHlybDJYakdTM0xpVFFUSnJvMnE1SzA2WlpkK3NBVTFPQldhOFlO?=
 =?utf-8?B?SHl3UllFUG1vS0RHTEVhejJNZkkxN201dDV0QnRVRlY3OU9OUW51bmRweGRD?=
 =?utf-8?Q?HUXJ3C09acn1MzcIyl8bQ4RMp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XsHvhEvXNplm8sKCEtfw4cAtxTFxj2ab5YWs7Q0Nnjr4ss02neM9Kl6rLU4Z1KapxhVgzcnh2qfYQ8eYidpny9JQj/3q12TVNr8TgpLaZv02SLZv1cIAZA76iw/fvxxSnwiU4z6WvsEskd5HPIUrVoyHcYQGBeqOgAHXJX38sejBKSiRpG/2oysG6Uyi/CQ9avCu6JLZ2YYBSZCzMwGnsCjcAgC3tn8RhB6mUnD0nn4JVOKnes1oIjexS2/GkNDhnlRb1DpsK93RVsk7SpjG/WwWwrrQDkJ0N88JoaNRDINQwT96XvQYBI314qnOdmOJItE4sOU/A0ZimisE4KBAA5XLctJjTrnrjMLfSPorzDtwL308s4R4Nlzp7+lH7sGSKyqwtxcAIEy1XbgGbYyZvJCbJkC8Icv5Qek/UkPesOZhkEbahqyYlxb6PmtjqpREVWnXGgVNyXUmvd3H6zduCsYw2rN6OkkhgQAszX5alkCjKZsJ5NCO0+wmSZVc26xA4fcAz0EnXoaU4mbovFN/gITz6qkrYXg7pTojuueZqI1+B1LiuIMo2d2ZuMQtK2mA5kQ3mIGavCn5WRTzetnKEMkB6TRMIkKg7lVi5PBgIb2Jl2J3crRHkFCndd6Pz5b4
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3331f530-7ae3-40b0-3643-08ddd0f80948
X-MS-Exchange-CrossTenant-AuthSource: BESP192MB2977.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 12:36:28.3282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CClDQDo9wOceLMk/I6lRvAjrlBT7ZRlkoSzAQO7ar1ss+aq7mvOB8gpScX3fTeV9VfGAnQfjP7ymBkdOmOt1dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P192MB1670
X-MS-Exchange-CrossPremises-AuthSource: BESP192MB2977.EURP192.PROD.OUTLOOK.COM
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
X-OrganizationHeadersPreserved: AS4P192MB1670.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-ORIG-GUID: _4OvSkZe_NdyKwjUNV0aG95tvskhGtzs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA5NSBTYWx0ZWRfX4kKjpitvczqb
 8OJVJn0C7gDMPwcpMGzsAzTJYaFiILyfiVxXwb/8d5NKUdtb8FKH9ahs5Oe60rNX//jcwn19ZhW
 4p183Lk58MfHE29jIJ4B/te+makzroMZH69XRdwpxY3Awf8feYPvL5CJjVmhIbC54TAPvCRRALg
 2UdKM9Kv+ob/Hi/C5hdlDi3hoA+M1jGzRwT3q7RAcM5Osu9G36UQBXBmVBjaUYAzcQsKS7lZHM4
 l4udwPcqkWRoiazUM/4jTb2uYklYwey1GyhzGLCVZgyZcWy6kLLvI+Wm2yQydDYWWZ/vx2NDsG7
 lrl+eCgQUBGqHoToFe78qSaXctoD3lmvJJSmkPlioD9t3LHAULTLrmcD0haMcM=
X-Authority-Analysis: v=2.4 cv=baJrUPPB c=1 sm=1 tr=0 ts=688cb4ce cx=c_pps
 a=U7Sucx+WudjIq52nHRMuHw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=8gLI3H-aZtYA:10
 a=4YRNWz-pTgYby56LO4IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _4OvSkZe_NdyKwjUNV0aG95tvskhGtzs

Am Fri, Aug 01, 2025 at 01:23:44PM +0100 schrieb Russell King (Oracle):
> On Fri, Aug 01, 2025 at 02:06:16PM +0200, Alexander Wilhelm wrote:
> > Am Fri, Aug 01, 2025 at 12:58:23PM +0100 schrieb Russell King (Oracle):
> > > On Fri, Aug 01, 2025 at 01:54:29PM +0200, Alexander Wilhelm wrote:
> > > > Am Fri, Aug 01, 2025 at 02:01:06PM +0300 schrieb Vladimir Oltean:
> > > > > On Thu, Jul 31, 2025 at 08:26:43PM +0100, Russell King (Oracle) wrote:
> > > > > > and this works. So... we could actually reconfigure the PHY independent
> > > > > > of what was programmed into the firmware.
> > > > > 
> > > > > It does work indeed, the trouble will be adding this code to the common
> > > > > mainline kernel driver and then watching various boards break after their
> > > > > known-good firmware provisioning was overwritten, from a source of unknown
> > > > > applicability to their system.
> > > > 
> > > > You're right. I've now selected a firmware that uses a different provisioning
> > > > table, which already configures the PHY for 2500BASE-X with Flow Control.
> > > > According to the documentation, it should support all modes: 10M, 100M, 1G, and
> > > > 2.5G.
> > > > 
> > > > It seems the issue lies with the MAC, as it doesn't appear to handle the
> > > > configured PHY_INTERFACE_MODE_2500BASEX correctly. I'm currently investigating
> > > > this further.
> > > 
> > > Which MAC driver, and is it using phylink?
> > 
> > If I understand it correclty, then yes. It is an Freescale FMAN driver that is
> > called through phylink callbacks like the following:
> > 
> >     static const struct phylink_mac_ops memac_mac_ops = {
> >             .validate = memac_validate,
> >             .mac_select_pcs = memac_select_pcs,
> >             .mac_prepare = memac_prepare,
> >             .mac_config = memac_mac_config,
> >             .mac_link_up = memac_link_up,
> >             .mac_link_down = memac_link_down,
> >     };
> 
> Thanks.
> 
> It looks like memac_select_pcs() and memac_prepare() fail to
> handle 2500BASEX despite memac_initialization() suggesting the
> SGMII PCS supports 2500BASEX.
> 
> It would also be good if the driver can also use
> pcs->supported_interfaces which states which modes the PCS layer
> supports as well.

Thank you for your detailed support, Russell. I believe I now have a good
understanding of the next steps. I'll respond later once I’ve made some progress
and have results to share.


Best regards
Alexander Wilhelm

