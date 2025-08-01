Return-Path: <netdev+bounces-211304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B04EB17CA6
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 07:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0DBA1C22EB5
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 05:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E3A1E9B21;
	Fri,  1 Aug 2025 05:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="pKefqcv1";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="wC9bkT+s"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754FA14A60F;
	Fri,  1 Aug 2025 05:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754027789; cv=fail; b=gy41j2UB9/fahFFLR9EbVrkcpuEKlTKC27FOl7m2eWMMuTWSSXWhzFQKu8hnskeJLzylowOs2/N1mV2eJUmuEbxLCaLj0JBef/JV96REqz8D0KCqQ+oD8bD9LyFy1xXkLjycPeRwIZHbr7V0o4Uq/RvbdFiOuEU374IPyBugTGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754027789; c=relaxed/simple;
	bh=rkIYSnVoo3c/enK8BNFNeRZ3ggr43FMjO0pYQbY9Xs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RmvxPSC7UJc5y0C09UXsavaTbXCfovx+rit/M5ToWiOygxQoeSpfLphIhA5AypQ61xeWc0JDhqUrl0B/K0yI44MM1BlWCBPxtISTjgakLp6r+G3jOh9FaUXGK38LX6SOuXt39AOlPBZ6f7neGda1T3IHE1SX+LA7l3WGttk1sRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=pKefqcv1; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=wC9bkT+s; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 5715V5b82052920;
	Fri, 1 Aug 2025 07:45:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	xeaa4VbwIh3C896kM4qkkm7hPIhloYq+QLquAOAd7Io=; b=pKefqcv14eKHrylz
	6iIl3b8n926XiX0G6IFjSYDaJN7AJEQDMYZ+9do2cozQwKxE/lkFLNchPfAOkN3M
	X8fXAqnOUzkdGdp9G4tOmzdXVk9BZ51TuMNg4SNxSNUeqV/7aBad1emacGjF+V9l
	Qgb8eMAuaqYk9g+LE8aE5YOEN/5uaGifOaSpUhwlrn1/7+Dcmh074ChRqdY4F6yw
	Rq83EuKdyjJC6wScF9Yih9/gzAFxypTljMQPOTr9IknNCUZVg3nZiNZ2JUJwwkPH
	WL+VYmwwa8KjZsaUGB9WBkxv8lesBDnTIvFuSYQyvxLY5HgGh8nBceIBpzhI5WMH
	vSB0CA==
Received: from eur03-vi1-obe.outbound.protection.outlook.com (mail-vi1eur03on2108.outbound.protection.outlook.com [40.107.103.108])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 488c9brf91-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 07:45:04 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THV8+akVdHcMps3eZO8KkauoMf7vCZG1HmSVZq1qoyPhmgplqH8I4nRZvXcKS/S+I+DRM+7as00ZVlkLDixUaqoFy/Ws7qnBCaTp1QZpf/QN1F+3CfFHAcbUqgWMZLzU2Kh3Ou8FFJfeFNzAtfOXc0R2lzUyyW41VCiKSFKJmU1WjF8GpOo7FPsI5pok4B3zwzI7idDaC6FTnFEg3F5zzARW3eEQUjk90RMm/H/6YjOVcNxwWrxDRKbbgqQdTdChQNqkK59V9+LFqMN4D5mvb4ph3EvHFqbKFJSRDe8SO/JLbQcWHLivTwujPlCS6o2Z0aRFN72mxyw0ktyLBqlRgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xeaa4VbwIh3C896kM4qkkm7hPIhloYq+QLquAOAd7Io=;
 b=i+FtFtERHMIRMaZbqy3P6LycmMosu2cPxzoMGte0u/85fjrD/LdVx2mtD4O+YsKeEGeChvpVU3n7JZHaGFUNVT8Iz/743qlfwIG5fGS/mDcsLrheStLHKEsSFjA4FZUaDo+K3Z3fpUguXmkv6Mm6oUxqiazaVL2e+ZIJ4p4D3UKcGCLyQv7D/AykKwYLfxyA9VhY3K17w2hQrh2b0XFsihiSkOF60hd96JGDeC7FD4ZBNH7mCcSAaKbVu+FeOhmEteqTovWBooqfsb6VzJcQFaIymzTK147oIJ6y7l45tT2ZgxjZuu4vyTUOFPvg8g1KIHDCTVOWxYkZpNNeJaER4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeaa4VbwIh3C896kM4qkkm7hPIhloYq+QLquAOAd7Io=;
 b=wC9bkT+sCekgN38qY6OQYBlYBDRnjZaJmdfY4NU5xB13rpnW8Qd7l+PrK3XxQUk5Ge97WjHX3elQahe0H54JrWCyytEl7275U8ZfcgHPxpVndxvYGdf4IWw8CxNmU5F6Wahpm8HxrWpnqwoyhOGgJ65kaEeQaYtay+ZQoxvTQb0=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by PAVP192MB2064.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:32b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.4; Fri, 1 Aug
 2025 05:45:01 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.8989.011; Fri, 1 Aug 2025
 05:45:01 +0000
Date: Fri, 1 Aug 2025 07:44:58 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <aIxUWqTSpwkJEV9Z@FUE-ALEWI-WINX>
References: <aIuEvaSCIQdJWcZx@FUE-ALEWI-WINX>
 <4acdd002-60f5-49b9-9b4b-9c76e8ce3cda@lunn.ch>
 <aIuTqZUWJKCOZYOp@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aIuTqZUWJKCOZYOp@shell.armlinux.org.uk>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-ClientProxiedBy: GVX0EPF0001A054.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::48a) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|PAVP192MB2064:EE_
X-MS-Office365-Filtering-Correlation-Id: e7d86c98-49ec-4305-2d70-08ddd0be8eb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elZkcjhLaGxrOExYUU00NHl3MTRpWk9pUVdFVW9DMkhwM2k4Mk9yLzdhVDN2?=
 =?utf-8?B?bHRvMUZMcm53R1k1T3lMdTRlQUxFRzVhcWNpM0lZbXlCdzkyeUZqWnJsTm1v?=
 =?utf-8?B?MHJXbk9Cc1luTU82N0lvQ1FwbHVFRlNERHpUaHByQStJUXkzemU4TTZiSzF0?=
 =?utf-8?B?Y1JtSEszZmppU2htTU9qbDJuZm1ZRUxVcjhrSGhJSjhJa1cvNmNJSms3Q2o4?=
 =?utf-8?B?a0FML0t5aTlUSmhJUkpJT09UQmFBTnZaK2RCZmMxSTBGaFhBVEFmbm1LZGhY?=
 =?utf-8?B?a2JPOUo1K2czQ1Y3NXg2ck1XajhBbHVMazVOZmc0eDZDcEwyYTV3NTdlWE9O?=
 =?utf-8?B?YXpxeDlDcW5PZzA1RjRGWVB3bEZFaytSRlFPNkY4MmNmZkRQZ1dKQWM3SnIy?=
 =?utf-8?B?cjNaNGxUb0hoek9QZXpJSVZyajJudnlJSjZnU2N2U1dBTm1qa2IzUEFFQndM?=
 =?utf-8?B?ZnVWZ3k3blAzc2gvYjhXLzJNb3VRZlpuR1pVL2h5T01JdUU4dVNnVytzODE2?=
 =?utf-8?B?NHRFWitaQ1l6TDdKWTJIOXdadVM0R3RYU3NuUEs4UVZmSEt2OFl6TjBQbkZp?=
 =?utf-8?B?NnowN0dwMDM1UEpKQTFPNHg3ZXAvZFVpVDRoenpDRWtwZkFTM0JyVVBSQ1hD?=
 =?utf-8?B?bTIzMGNIVFBiOHBsdEo5MTRWL2pIam1jeTlsSjhiVFQ0YXhDRlRFWXRrM1h2?=
 =?utf-8?B?RFlUQmFveW9obnByRGlwbXZoSDJoNGR4bzZnQkI2WjFtdzlXWExUYUt1MzBa?=
 =?utf-8?B?WHJWa0p6ZWhma2owcWZFaEYyTGduc1diSWVBVkZTNlZsdUVYQThUaUV4Wk9C?=
 =?utf-8?B?cW5QSkhjZTNoaVBNa1hYY2VrS1RCWUkvR1RPM04wTU5LNEo3RTM1dlRsN0RN?=
 =?utf-8?B?OU9pK2VMMHUzTVhCb2ZTTm8wYjl0WmhiT2lKSHFPaExVWUxkbUNVQjlSbmJy?=
 =?utf-8?B?SDNIVnd1NlMzTXNwRjkwalhNTGxBOU9xMjk5dFM3UWU0ZWZnSXVLMFJXeGY1?=
 =?utf-8?B?eHNwWVdIbjZzTlorUHFpMUhkTDNBcUQzTEZjU1ZySXJSUWhtNFQ5eFBML3Z3?=
 =?utf-8?B?OUo3QmNBZUN4RUFVcnRhanVkczlHZVFWSVN6QVdvMFBHNzJHOFpHa3VPeENw?=
 =?utf-8?B?RWlZNlZ1TTZIRjFkc3hIZ2pHV0RBcGdaVFZVZGY4aklGM2ZMMkp5Vno4dUsy?=
 =?utf-8?B?dzExb09rUTd4TWFmVG1GdURkWUwvRDE3Z2R1a01BWTMyWngrdC9sdFRZRnFQ?=
 =?utf-8?B?UE5ON25XcndxQlN3UGdDYnFZdHR5bk5vakZkN0kvaDRFNFNkWXJZSVZTbGd5?=
 =?utf-8?B?dU1JZDFEeHFuek9Hdk10ZU12b25yMUowcUdqeGlqazNXN3p4bjl1bkxDN1Qz?=
 =?utf-8?B?NkxIaFk4d052RXJ6cDVVRUFYa2FIVnNxVHo5WFY0ZEtlcGZCNHd2UUxQeHdq?=
 =?utf-8?B?T212Y0JadTIrTFdFb0w2VjAxQUY0SEZWWWRzS1VyeXJUYUJrRGI4WTI1cGJz?=
 =?utf-8?B?T0NXaTJiSi9rR29scWhvdTV4Wkk3Tzd2UDJmZ0k4S2I1VHYxTFFBaE1SNTRq?=
 =?utf-8?B?MytlVW1XbzFnMEFvZGtBZEhDSkMvT3lERWlDUDlmLzFZejNGNlVORVZ0aDlo?=
 =?utf-8?B?S0xPREo1R1AwWlVraGxXWTJVeW9WMGxaRE9KV0lHTHd1cEQ1dElkUVpCQ0ln?=
 =?utf-8?B?R1pxSkJyL0xYNU96a3RpejFTVjdkWE1RREhERlk3UVl5c3FORWhORktHYmtC?=
 =?utf-8?B?NSsxYmgzZXJEUGQ1TUtCVVhoOXdMdThpZTkvT1pKN0ZIODhleWJ0OU50YlBp?=
 =?utf-8?B?QWlIOVlxczlyZ2hHL1N6M0lscU1sRHh6QmhFcDErMzZWMWlyRVhOcUgxWHYy?=
 =?utf-8?B?YlFMZnBVbzFvekpWZVR1NFh4RW80UlhQc2E1cWV2K0YvQjhESmZKbVBkOGUy?=
 =?utf-8?Q?ARUkSjLY8zY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S01BQWViQUFkV1o0b1RIT1M2TXdyYXQ5RC9RR0ZucjhJTmJqT0xmR2h3R1N2?=
 =?utf-8?B?TjRtNWRxNTFwY0NUQS84djEyVUovajNLeXNvWmFxOCt1WnFrUHE0UC9XM3hh?=
 =?utf-8?B?L1lOd1lCRzF3ZXRKOFVVQnU2blIybUhSei8xQWVYbVI5a28rUUJEU0RPVjg3?=
 =?utf-8?B?eWthb0dROXNlbjcySjZtV1EyUEs0d1YzYWJOdFdDY3JjOHdNbk9LUlVlbWo4?=
 =?utf-8?B?UVd6RnM5V1hvZ1FBamhKeittSGtXdE84NlNEbjM1ZmNIREZQMzh0TXg0TjRJ?=
 =?utf-8?B?bHJCemJra2F2cmpVR3l3VmRqbUU4L2pJWi9LRzBHa2lzY3lEMXEyUkxJaXZw?=
 =?utf-8?B?WUJEN0FXUHY4aml3eWtmMDY4Zm1JZXFZcStkL1FlWVBidHc2MmtjSVBrQmVL?=
 =?utf-8?B?M3ZSbDdWNVp2Nkc4RWxlWHFuRDl0WHJhTE5SckgvTzFsTXBwbnVkdkpFVGZh?=
 =?utf-8?B?ZnptNllSRjAvblJlL3R3aDJmdldEamNVZjlKRVdTL3Y1MGtOZDQ3Q1FwdnMx?=
 =?utf-8?B?MDZDUHkwbVd0YVpkMVRjSGljM3BqZC9MTWtwWVo1MXdUWGVONWV6bElaanBV?=
 =?utf-8?B?bVIveGpEMXd5Q05oT00xS2xJUVNZSXFvVlpYTlh3eGJpZXZTMDJSWDVGSFZx?=
 =?utf-8?B?a0orYUlQcDBGMy9VK0p3ZDg1M2hzeGRzSS9xNE90OW5nem5rc0JVVjlCQTUx?=
 =?utf-8?B?dXdpeHJ2a1NZaXdKSjlWK1oxY1EvTnVWbDJka2hJbUQ0MlFWaTkrVXFocW9s?=
 =?utf-8?B?eUZnd1ovaGFiUldla3RjWkJWUHZIN1lmTWlYbWxmR3JjZjZINGdabm5FQjFn?=
 =?utf-8?B?MDl0WnRrNVpuelQvSFZkR05YNE1ISjJRenQxbEdFczhWS1ZYVkxCdU1PVUZh?=
 =?utf-8?B?cndlUEw4cWUzRVhuWlAzVnF6akljcklSbURZQ3lONy9WeEJkQ3krRk9jMlBn?=
 =?utf-8?B?SlhpTXBaY3JXb2xaNTI2VVVhcjd4V0VIaXBCWmRuL2srUUJjTEdFaWJDWnFY?=
 =?utf-8?B?aG5MdjBOYUxNcmpzWDkxbWJBSkR5NnFKS01DNFE5YWRJLzZLUHBObS9aeVdy?=
 =?utf-8?B?eFdDbjBEU2hmeHdSalM3dlNYdldNVXBIUzVMOGVndzZ6c3lTZm1sa0FxcWU4?=
 =?utf-8?B?Ukx0Y2Z1UzVnRmo2VExYZXZMYThpNVBBZERLYlhsSktOVmkvOXZGY2NDU041?=
 =?utf-8?B?NTJXbHgvZ0VTamc5MWMwSnl6a25xMXNaUmhHVFlrcHBEa2MxQ1JRQW1xSUNy?=
 =?utf-8?B?UFVqVVUwTjNPUDFQSlNLb3AzZ1ZpanZGcDFQa3F1N2MydHYxSU4rOFF2Tmpu?=
 =?utf-8?B?OTI5RlZZOWN0OEZpY2FkZHdBVmRvM3llWlo3RS9oLzRGZnQrRkZBQ1UvdGll?=
 =?utf-8?B?ZEx0L1Z2a2hJSVNReG1wZTBrN21KTEUxL1M4Z3dTKzNxNWVVZ1QrZGdtd0hR?=
 =?utf-8?B?MFREKzQ5b2g2SU5OQUFDNVBzNHNDZ3VUdHllYVIrTEdVZGYxSFpIRnYyVXFW?=
 =?utf-8?B?MU5GM28yY0dnaXdPYVVPVGpaWm5SYnArNVlhVzNIRytRQlRFOHpjNUlDc2lh?=
 =?utf-8?B?d0JOb3VleHRSTWRQU0c4ZmhSb1lwdC9vSHNxaDFtTkN4dWdmb3NodXd6Z0lD?=
 =?utf-8?B?Wjl0Ym40dlIzR0hEY0xHaEZaUmRFU2RzOEQwSVRCUVFURjIrM2xYOTk4V1Z3?=
 =?utf-8?B?em5QbE1UNk1Xcks5UGRpaWpEQ0dtNTFLYTFqRVpsZnY1NTVYL3g2c1NGMGE5?=
 =?utf-8?B?YzdiZUU0SGEwWFhsNHhlc1JDbTZoM29nZDRSK1ZHSXR1L0xFbi9oY1lQQVhW?=
 =?utf-8?B?ZlVyRTJ6UVhyZkFXNW1ENHQvRDBOKzhKcDZzL245WERyZkd5cU9ncGRoU1VG?=
 =?utf-8?B?ZWQ5MkhRTEorMU1ia01OS2JYb245b09ESjlJT01aNjU5SG1KL215Q3dBd3Nj?=
 =?utf-8?B?Ym01dnZBZDhsY1NxYXBhUUJFbkoxcWJKQ09yU1NDYUgwVWZYUGNIS2hOTkZK?=
 =?utf-8?B?V091RE5QNFVGVU1YV3E0Ri9FVUpjWm1hc2tjSTRaRVZMU3phaTdiYkdOTXha?=
 =?utf-8?B?akFML2RCay9RSlhrTzErVFdycTliQXNNem1BWHFSWWtocTA2SnBuSHFjTkkv?=
 =?utf-8?Q?eEy0rmdf5Zda59GInH+/Btvai?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	v7VJWZV/cvzXhP+JQHvqHQopvWQuj3wTeAlGCStqQJm4QbIK4P1aDiEnofBLi3LbJnIRM2Dc4pIUWct3ISKlrir6Zn0tuWAAkpIsxqfEXkYcTmgsaunYfHmSga/BjHB9lyDUspYY6ejuBm/9tc+XLSB1xFxMpjA7nEn3rovm/wHWBYf5YyuDCQ0V+mHo2ft1v0A2sS/f7dONOqFuEIQBavDILPOP29BlY+Jt23IISUIeC8QJIigpm9GIDnNqhKDjvvQDX+hTiNXgD4JVrs9CFVOD9N3MQgNKvVLocjxvAkkFFCPxWDG2Qhe8Fl7hrgpeCkhlQdrpDus2tFSdP+9rn9wTY+yrwS+ktSYidqlz59bIDbMq5Pp2lBJmkv4rYo396AnXx6Q68vFy7TJ/xNVYh07dbXBbUx/KAEMRGGCnsyY416hxkeyDY2WjT7SMuCddY/6pmTAwGVuwK4qfwqMyv5uSJo8rcOfMmFyHbtsQRj1LAZC0eQ/gDcBLU2MQDPtM5OExdiU0S61rDv6s9oCjyH760qSg5xxq0JhPZ07DGkvXhriHcFdASi7AU8csqVw4A2r1ic78HXMpplGgl3TyDw1j6HXh/IyXW/AZq795GuXl65CtDiAV44qVG/F0T018
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d86c98-49ec-4305-2d70-08ddd0be8eb1
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 05:45:01.3595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SNXZEvWZVGH2kbFKMH/u6qsaeRn0Cso3ez5uIBmnZH3rPArrRJaelS+1/fYCMcWdLv3cFAV+DuopBwjj9IHw8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVP192MB2064
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
X-OrganizationHeadersPreserved: PAVP192MB2064.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-ORIG-GUID: pOgzY89aZNwungdqnleM7vGPUH7DGBr-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDAzOCBTYWx0ZWRfX23mHJVONN9fp
 hKOLBfNdQqXl/PqaBYfmXPABjdaRCQM06LBmsEbbX2AE/M3oOF8Inyq8WeXGeU9/k8lRLvan9mi
 PD8R+4vI5IqS2X7VT5ezQo03g9kzjdLFlUm6kqPLSBtjmtvtGKKHh85rR0P34ZaqS8tm6Ll1+dr
 g2CuvDI8WW+gADaGMc8xMw66j9PmeUlx4fowTs3rgnfKDXvkG6hPGgENwEZwXtww7MGekwF0SzL
 7kWTlMx1QpgfniBJDxYyVBxZaoG2CNs9TQGVwKSz6FaPZcGms8CzpJTAJRU8aBAbxlT2XZtnYHt
 OX/qnYFQaTltOoTsF/AtT6fY5spuscVFajC2y/BHa3Yq46O80iiLczByy2tLZ4=
X-Authority-Analysis: v=2.4 cv=baJrUPPB c=1 sm=1 tr=0 ts=688c5460 cx=c_pps
 a=i8czR+/Bc+Jv4CuzqOHClQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=8gLI3H-aZtYA:10
 a=IH0maxRQ3Zg76He6RvsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: pOgzY89aZNwungdqnleM7vGPUH7DGBr-

Am Thu, Jul 31, 2025 at 05:02:49PM +0100 schrieb Russell King (Oracle):
> On Thu, Jul 31, 2025 at 05:14:28PM +0200, Andrew Lunn wrote:
> > On Thu, Jul 31, 2025 at 04:59:09PM +0200, Alexander Wilhelm wrote:
> > > Hello devs,
> > > 
> > > I'm fairly new to Ethernet PHY drivers and would appreciate your help. I'm
> > > working with the Aquantia AQR115 PHY. The existing driver already supports the
> > > AQR115C, so I reused that code for the AQR115, assuming minimal differences. My
> > > goal is to enable 2.5G link speed. The PHY supports OCSGMII mode, which seems to
> > > be non-standard.
> > > 
> > > * Is it possible to use this mode with the current driver?
> > > * If yes, what would be the correct DTS entry?
> > > * If not, I’d be willing to implement support. Could you suggest a good starting point?
> > 
> > If the media is using 2500BaseT, the host side generally needs to be
> > using 2500BaseX. There is code which mangles OCSGMII into
> > 2500BaseX. You will need that for AQC115.
> > 
> > You also need a MAC driver which says it supports 2500BaseX.  There is
> > signalling between the PHY and the MAC about how the host interface
> > should be configured, either SGMII for <= 1G and 2500BaseX for
> > 2.5G.
> 
> Not necessarily - if the PHY is configured for rate adaption, then it
> will stay at 2500Base-X and issue pause frames to the MAC driver to
> pace it appropriately.

Thanks a lot for supporting me. The rate adaption, so called AQrate, is exactly
what I want to use. It runs in overclocked SGMII mode and limits somehow the
pace to communicate with MAC.

> 
> Given that it _may_ use rate adaption, I would recommend that the MAC
> driver uses phylink to get all the implementation correct for that
> (one then just needs the MAC driver to do exactly what phylink tells
> it to do, no playing any silly games).
> 
> > Just watch out for the hardware being broken, e.g:
> > 
> > static int aqr105_get_features(struct phy_device *phydev)
> > {
> >         int ret;
> > 
> >         /* Normal feature discovery */
> >         ret = genphy_c45_pma_read_abilities(phydev);
> >         if (ret)
> >                 return ret;
> > 
> >         /* The AQR105 PHY misses to indicate the 2.5G and 5G modes, so add them
> >          * here
> >          */
> >         linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
> >                          phydev->supported);
> >         linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> >                          phydev->supported);
> > 
> > The AQR115 might support 2.5G, but does it actually announce it
> > supports 2.5G?
> 
> I believe it is capable of advertising 2500BASE-T (otherwise it would
> be pretty silly to set the bit in the supported mask.) However, given
> that this is a firmware driven PHY, it likely depends on the firmware
> build.

I don see any firmware problems. I have one of the latest builds, and from what
I understand, the firmware consists of base image and additionally a
provisioning table. But this table is a kind of pre-configuration. That means I
can override the entire PHY configuration to my needs.

By the way I already have a 2.5G link in U-Boot, but did not get to set lower
speeds. Now I am trying to do at least the same under linux.


Best regards
Alexander Wilhelm

