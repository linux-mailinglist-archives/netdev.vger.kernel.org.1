Return-Path: <netdev+bounces-211302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C23DB17CA1
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 07:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1704C621028
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 05:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3841F1501;
	Fri,  1 Aug 2025 05:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="zCHOnX3+";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="nkdpakRL"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0954C1E98EF;
	Fri,  1 Aug 2025 05:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754027437; cv=fail; b=boLoZ0UEBa5/lFjAsgSPbzxNQNEAOu8H/JaBqB0FT6N8bcdMCvXo9Hvyo4STychFa9N9xQ88Rvmkk+/W/FN+zOD3kJHnaL3vZhxhRy0jOTLF7PBNJ65Lq0NaUNMnaEiu8NHieRHZpDLObZeqwE8uAhFFxSnvHi0yn+EhQ1iZn3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754027437; c=relaxed/simple;
	bh=HoZomktwkJ+femvJw4f/l8t+j0/wbtezp/48/HMozCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B9SUQZXaPFbv02ojEgCnfSllbl7Wo6YJOOZm+cktLBQq06PBCLjWk2VdawDtmZX3PNizGqRiTLNk89/g9YKeSdXSLItu2mJn+vIkWMVyfh2SfPkpa1WMLKKScQ9+xsnIaPqgtMv8cqo9Mtptg23PqQ7EH1EJ6ZLnhtUqsM2HNbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=zCHOnX3+; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=nkdpakRL; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 5715QUql2045401;
	Fri, 1 Aug 2025 07:50:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	axqvxyidDWQOpB/QcIpz9fdq0qaBf6EcoCtpiuQDO5I=; b=zCHOnX3+ao9DfOtX
	Wdf9Qx2xJfTC+r9U+kbaFJGnM9QUHNCFYVSs3BssOkM2EkysdByY0ZmsANwBPCzF
	ac7L8sP3bue3GPfXtKQgIWoFXHh1REnz9qaclDwCDn9scfjrI4dyMrNu1AJwXaT6
	YBKED0Yi1UNvTZNts16kJolEoWYvR44D18EBSbnOT4q4kE6GDB/s7WvzZ2MFNQ1d
	aji+OHrNeDMgkSb15tGXT73LvpwPRmVk9DWlJ87eaxRA6kfZwlx7GnguU/bFYfJm
	ndn5iF2DtKrbSJCr+20oyjqeVT16LDTZyJd9FYe3mesrpD/zTi2jZfAMPWjx1fT9
	LCa0OQ==
Received: from eur03-dba-obe.outbound.protection.outlook.com (mail-dbaeur03on2113.outbound.protection.outlook.com [40.107.104.113])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 488c9brfbh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 07:50:19 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gbc8tmx+TZosUfnRoN7TsoPaOVw2bwvtiAn5aFfBzpCyklXEW8/AobNMu1TN7C1l2ND0Nxo79QowKAdVXlVIfDehE5dPi09gpEt48fwdL3peqQQj2u+CduDanf1rvIZkujJY4pmCdQ1Wu2YT1aYUybDw0S/atOsWelcsYoyRUUGNPh5TALGH001tBm4B35FTpXQDq0ktqBCxREEr0GXszqYjSzyPJg+xZ8U+oWxAMTfdVWzYBlS2Wf6M0pBfdlFYT9UC3D9CFZt/O9iPT0+SMiQTdcGEelX514ZdEVTr8OQOrrXvXd3L+Vd9/mLzGhwAO2MB9oYZFIx68Krf8yo5CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axqvxyidDWQOpB/QcIpz9fdq0qaBf6EcoCtpiuQDO5I=;
 b=gT/e+m28tM7S00RGJjBa1xDb9bq3wKLZpfqx6Dqtt6Pf+k8Dm6c8tocsbmuqIPjHoYAZ4XcSNioNaHBz9/0c64W8gBWt+KqWu88/4f318fe1bI/QvybTOgHoHyxeLmY/y2GPxn5PnDgCPqg50zWEwT4C5T7usPVzOlQvP8B7Cj73Gh3fRc5PFIdZasWXYfCAat/QO4BSFiKQ761xE4IDlMi/9P6cW1HzVaFXJr27/TDZY9HGjqnjlP2b7QJL2eaTCp/xZZgybq9rdBQSIx+T1L/ni5TtIJa8cbWU10AuV2pTlBW+acVnDmGgbyYBLzhKhfTzOZLqTtbjUn6QIGuPlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axqvxyidDWQOpB/QcIpz9fdq0qaBf6EcoCtpiuQDO5I=;
 b=nkdpakRLurFVj3s1Gzl6JG15GuUfQUjymfFQS0hAILgZL/9e/6UTS+6kHayO/f7y9LiMdrWT/qbECpXBjkaZGkWnjyNB6hXxOFy3reQ3eDtV+vq7EiGx3qnDsWhBdUOhFiWsHrnP1UlMiS3cRw8NROX1lLkkHVN0ISEoRD6pb+w=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by PAVP192MB2064.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:32b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.4; Fri, 1 Aug
 2025 05:50:18 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.8989.011; Fri, 1 Aug 2025
 05:50:18 +0000
Date: Fri, 1 Aug 2025 07:50:14 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <aIxVlpg9Je3I+NeA@FUE-ALEWI-WINX>
References: <aIuEvaSCIQdJWcZx@FUE-ALEWI-WINX>
 <20250731171642.2jxmhvrlb554mejz@skbuf>
 <aIvDcxeBPhHADDik@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aIvDcxeBPhHADDik@shell.armlinux.org.uk>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-ClientProxiedBy: HE1PR05CA0128.eurprd05.prod.outlook.com
 (2603:10a6:7:28::15) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|PAVP192MB2064:EE_
X-MS-Office365-Filtering-Correlation-Id: ff5f2b4d-0c8c-4980-d209-08ddd0bf4b72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1RoZ1VXT2s5WjhTaW9abUxtRjFTeExXWW84dVFlaTZZS1NqSFZBZG5yOU9z?=
 =?utf-8?B?ZGZXUVJtR3FXbGk5OFRHNzFzZm9wLzhzTUkxMW1WR3NIQWU2VXBUMUQ5cWlK?=
 =?utf-8?B?MWtVSVRMS1BiZ2lEVXVwbEltaUllVjNnN2xhbFcwSitMNVpNUERpYWVQQlhz?=
 =?utf-8?B?N3h6Q1pITEpyQ0RrQlU5SHNORjZiMTdGZllRQjdpYnhCU0ZHSFVYNjZadEVZ?=
 =?utf-8?B?LzV1YkNxTUZ5b1pUc2NDUXBvODNmbllsQ1FZZDl6MWpreElYaDJoOGMxYlFr?=
 =?utf-8?B?blpKL2xZTE12RXVSVjViVFFQTTBOM24waGxMZFdVOTBudFI5OW0vdkNNbklN?=
 =?utf-8?B?K3JUMnJHMU1KZ3d5eURFNnkvYUZKYlJXUWhkOStxZDBQM3FSaUFETDYwb0t4?=
 =?utf-8?B?RlJINW1Jb0xJMjVsN3d3K0FncVpJUGZ6Vm1MMzhndklYWlV2R0RWWVByTTVp?=
 =?utf-8?B?OHFyZ0lCTmt2LzNNQ3VHQ3o4TDZoMGhOUFJneEluMVo3OXJxV2hsdVAvMm5P?=
 =?utf-8?B?QXpRdmlxb3AxSDFWN1NXNDRmL3ZUamFyT2ZZNVA0UCs3bjMvcmdNRWxlZnRF?=
 =?utf-8?B?azMrMlBxSHplRWZlc2IzaFpwdGtBSHdoT09NTjlQbzNmM0h4dnVTQlVwM1BB?=
 =?utf-8?B?dS9HMTB3eWYyUnlaaG0xWlJ3Y3dHQWpUaWkzRExEdXFwd1JUbk1TNTBORytU?=
 =?utf-8?B?bDVrSnBDMmhlMnBWbFM0djRjMTZaRDV0S1VrWWRPbEYra3ppWDcyUjFWNm1W?=
 =?utf-8?B?dmlZcG5sUnVsSW5uQktJZnZTeVFJdmNwUjVMUzR3R2RZaDFrYnZZamRoV0Q5?=
 =?utf-8?B?Ky80VTltVnVreHJNTGRLRFM1R3M5WlBQa3hySGxZc0hNNjJ0YW1NKy9ZSU5t?=
 =?utf-8?B?WHF0VW1CUlprUkg4VEZKNWZ0Mmp1NjlBQlVDSW9tVE1ING1waGZEQklhM0h5?=
 =?utf-8?B?SE9ZV3ErdkJtNTIxTldtOHhWaTVlQXhOSkg3cVY5b3lhL0ZUcXVua0xWREx4?=
 =?utf-8?B?eXZJdnRuZ3kySFUwNWdxeFFLRGM1VHk4Rk8vbXRiYUNMTDNRM0xqb1g5dmdE?=
 =?utf-8?B?bDU5WjZVaS8rYTgxZHpKa2Z3SGU4amRDeExjT05qKzM2UHNITUtoSzdhOHZu?=
 =?utf-8?B?d2h2NUJ2cUFLYmNiNkE0K2E3RGtRUW93NU50TE5rWmN1bTVwT3lIeXFmd3hH?=
 =?utf-8?B?dWZMbXF2dXByTWp1Y0RWK1o1L2ZIcVJkU01vQjh2VFQxSEpZMmtlazYwYmNa?=
 =?utf-8?B?S1Fud2ZLSWN4SFNOM2VscDN3NDFZdXhxMjhQRnhrZmE5ZjhzSlN3cktUWW9j?=
 =?utf-8?B?QVNSRHMxVVdmRjRSamFzMVEva2pNbTJ0cjY5N0J4aWNFR0hLK0w3dkh3ZTM1?=
 =?utf-8?B?bVQ5ekVabCtlc28vZzJhSVdVSzdobVlBbCtEV0VRUTF5dTUwcmtTR3VxTjFY?=
 =?utf-8?B?WjVsT2JLSjJ0c05Wbk1SdjRXTCtTK0VZa3pPczFmNVNKbHZYc0lsOTJROHcz?=
 =?utf-8?B?TGZFdVdPSlFZcFltSGZJcmRlNDI1SzJTeDVoU2tjc0p6aFRlZXk2V3kvYzlQ?=
 =?utf-8?B?c09hRlJKU092dXVib0wvdEdERTFIVHA5NnFqU3FxYzA1ayt3UFdyS1h1YjhI?=
 =?utf-8?B?NUVTNzZlMGRCRzZqU2hmcGJtTHI0Zk5kdkpGV1dkdXFUSDZIaEJtcTNncTJy?=
 =?utf-8?B?aGtDYTBERDlsdGp2dE4weElFbS9ZU3hEYUx3Uzd6TGp2UmdXMkpMdWdYaVRZ?=
 =?utf-8?B?Y21xbkd0eVdqSHlTdThRZWlyVndwZFMyaDdTazY4USt0aXEwN2crTGZwcUJo?=
 =?utf-8?B?Znh0czdSZzM1WWZGdXRpNkt6Z0U3Z1ZVSXZGQlUzaFluVE8zQTZOL1F6aHhT?=
 =?utf-8?B?bTJYN0FXK3RsanJKaW1VcGZLaVpISjlFT1NtQWlRRW5XaVF3RlFWN3pZYm9l?=
 =?utf-8?Q?vclMAjcMU0E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WllmQTRqUElqN2x2M3NZN3ROZVZBODdQV3JnQUlaUXFKK0JNNjNscFNSSVMy?=
 =?utf-8?B?RDNRRkVEV2FrVEtROHoycWVzZUxEQTJQSm9OZnJmQzIwYnpMRThSWGRoNng2?=
 =?utf-8?B?Q1VrTlVZL1liK0o2QTd5RDNLMEpTUWllcjhGQVJXWTlOamR3MDVyMWhDNVhP?=
 =?utf-8?B?MjFlRVk3di9sdEFaY2tXbjA1SzRYam1tbE1kSXhlVDg5NXBkK1RhS3BPaDJJ?=
 =?utf-8?B?MXFNV21NRlpycVpsaHRYQ1hTSmptTXFLblBoWWhNSFJUY2pYOGdmVWZJUlZ1?=
 =?utf-8?B?UE1JY1NjUWh2ME5YNm53MS9NcnBHM0djMjFUNGRNMm9vUjcxSThCejNSb3k3?=
 =?utf-8?B?ekVTZ1RsTFVWM0VkRVZwVlQ1UU9qdVJ0ZXRsSXpmQ1FYZndQb2pJSDZRa3NX?=
 =?utf-8?B?ZXJxNkdGNTRrTnUvU04rLzB1dzVxUEs1UTkwcW41WG9kS1E0cjk5T3hJc3dK?=
 =?utf-8?B?TERxZEdpNHF0ZjFFWTh1NGg1MDBKRnlydVlQZXVtalhDQnFsbXl1SnA3MjFl?=
 =?utf-8?B?emhwNDRabGF1ZDRDazJHQnRGK3J3Z21GZ2lmYkV5TEwwZGloUXRXQjJ0b2dt?=
 =?utf-8?B?YzdraXVTY3ZJSlF4UCtMb2hBc1Z6dEdodGM3M2pVeVU5R1c1RHUxd0JwV2tB?=
 =?utf-8?B?Wnpla01mSkc1SjJWR0U5ZjYxZHN4UDNNUG1ocitpcjBrOGRvZlIzcmxtNjV1?=
 =?utf-8?B?UkNJV1RWVHRRR01maVNITG55anBpOGllQ2FPZUNJRHRVZ0U3a1FxUVRGSUlt?=
 =?utf-8?B?UGR5NmVNZnVEV3RNdElkZm81UDFnaTQxdEdkY2dTeitweE1nYTRDU3JLSlQx?=
 =?utf-8?B?cm01UXJlcnJDVmpPUEdRMjFTMVFpeklBN3p2YklQMHdyUGpwUTZvS3VVWXhH?=
 =?utf-8?B?a0JrZSt3cWpZSk9GN1p5TGdEbnVJRUF5dzhuL1pCVHd5dm9keUQ5Tlg0TTRp?=
 =?utf-8?B?QTJYOER5ZzRMUGJZTjlDdFl6c1NtVC9TSFZsRldtWWZzL0ZGdlpGRGM5ZDJQ?=
 =?utf-8?B?T051RkNaekhNM21ldWoyTWI0Ym12ZVNqQVFrUDViUUg0V1Jpb0ZuUzA3ek8x?=
 =?utf-8?B?cmF3NWJxUG1YVVIrMXVWLzNhcW9UNVRmUkd3OUljNFBvV20zZzBKOW1IOEdK?=
 =?utf-8?B?TGQ5STJmWUtXdGVHVWo2cjNydk5mSFpoR20ydkRxVHYvWFM3WC9lam4rMjky?=
 =?utf-8?B?cTd2eDJ1TndNbGI3VkdNblY5ZEtiT2RETG50dHltMDNQRENJM3RFbDV0M1NL?=
 =?utf-8?B?TjlnM1RWTU5KL3ltNHlaR0o2MVhUVVRweHNiRUZPTjVjOXZOVnZaQUYwbTFX?=
 =?utf-8?B?QVQ3M1dVTy9uV09BN20wVWFpK1BFeFJZZEI4QWlXbm81TGZYSWZZTmVXNkN1?=
 =?utf-8?B?ZDk4TFlIRHJFb0EycU82TTRTbXBrZG14akFUNTNCNC80bE9TaXVtWXpJa2FQ?=
 =?utf-8?B?L2xiclR2RlcyQnRIdU9FbVNLTjBZWExnbEFTUkp3THM1aU1BcUJ2bGdRNzBC?=
 =?utf-8?B?Z3dqU29PUmJhQ25FRWZEdU8zTVhDU01wMXBxR1JHOUFuMFU0NjFneGQ5dmlN?=
 =?utf-8?B?K2tEeExZZjFoOUszZmJmRURIdFZzdmxHK0NTOEJ4SWZPOG40aGhBR2VKMVpC?=
 =?utf-8?B?MlNFd3Z0MThCanUyemN0K3J4eUpzcVZMbU5CSmlsbkZsbE9vMWRGTDBZbkl6?=
 =?utf-8?B?ZHZBSVJLaDFuNUh1RjRXSFZvayt6cVJPVXNUUnFHSDZVbjhOditqL2pyc1V6?=
 =?utf-8?B?czBlRzd2WWZQcnE2eFVxSVR4VE5pdFoySlZNTFdIeWxBc2F2b3VTTGFHUENC?=
 =?utf-8?B?MFZEd2w4OVRTVm55bmVDRnhhM1VOYU9GMDBrcDk1VUl4WS9zY1l3UXFiamVl?=
 =?utf-8?B?Q0wwRE5EUHAzQUhGeVFFREZ2VGo1YWFMS04wYm5PbWJ6VDhkVHl1Q1d1eGhK?=
 =?utf-8?B?aG1iT0w5TXptSDd6d1g0OHdXMzBrOTFjSG8zdDRidTAybHpYWFBRenlVaFJM?=
 =?utf-8?B?c2R5Y1ErZGZZTFVUSk1ORDA5RkNzbnQ3UnVKUW1Rcit6ZEh5NnBUSmR2ZHBE?=
 =?utf-8?B?TjREZUQzVU9xQzBrdXdyaUNhOHJOOGZmeTEveVhUbjB3OGwxeEtNWGJYdkVl?=
 =?utf-8?Q?wT8LuuCBsiDLre8FcIBVNBK1p?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MmjzcM0Z+FrcU13KEdfN4hjW3PI5vDqilQu3Mrbeql2Ez2MJ+KJO4YFi87IOBNRLhZe0WF79jHP6yqaENtMYFNVmdGHdHHMyUuWO7DLtI6zmcoqScWod0QGf8vb1bPU4NXCfJjrj7eO9BCnf/krNEwOG5ILEtG1axfIR1LcX3tI2NhykRJk+jIBdPhadL892BSYV0ncCqAbkRHuVo3hRO4NckH8an4pln6SQg22jESNrqQW8pkxykIhzsIxd6/m67AMsCe0VReU+uKIc+2H5Hw0C5OaP266RnaAgRv8C+9fbnzQjHoOsd3ibxQu3u0EToF7rJxzvQrmcYfq7EJLMtw5QhIHCk3ZbtsizGP+AMlHCt84IFAmjNslVHCSbc+A6ymLrzIHw0yzqBgmr4kMxUPNaUncoLmIm/g3oL+Z+QZopR46nBBUPRqRXgFxl4LfxzlzuFUI8MWkqRrfGN9Vkjgyurcm1PlMoPSdiG2idSU7HiaAFb2ArQK2aZ235Sm5AVMyqR8gxSiVzi/G8YNBXIngDGihKdmk2PjXZ9pqr3GLwveC2FxED+4oFOPiZGfna03hgDSy58NhQuW0q2T6PLXHPqWtdIwglRRTiuQRJk5/Aqfls8itoZdHlUFV0EoNf
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff5f2b4d-0c8c-4980-d209-08ddd0bf4b72
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 05:50:18.0339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bru4FYk9wbu6D/kHYMkRzvaRfP5mYP+0TrVi/2AsXamT1D6389yb7wRy7SMCe5IgzJs1DPT/pveIV3/z9F+PcA==
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
X-Proofpoint-ORIG-GUID: XdkwGBNC9RIAXGkGd61XHVbh0OHhXoyU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDAzOCBTYWx0ZWRfX36jyqAfJ3Ihu
 NXkC1WBi9i9nPkEelkg46PYtlAmpAiJpbzMvbDlwc2jY36sUyzfXku5dRt5bOdjeqCErtlwTGPa
 pcGAKePBYUy17okH65aWcKda4Rxkl1/sFmxvbQarya/Bduj18sCoRautZ5BHX/DJx76iKYi9XFk
 nhJn+0QzpTbr3/C4CGqKvuFDmMfVdxXeLFop64Pycz3i0N9d+llS2OxMq/l5EYe0hiaDU8tI2HB
 wubdhmho/JT91CdgfPG+0tA8SPY5kDe5lqIHKd04N0wOVXpbDo7pszdjlknc/lasYVbIi9K87nk
 Toj/K2hiXkm8fZ/m3Fqxv3UQ+Ly+8Ii1GXRwkwzIDsVr13WP5dqHDS9+OcuyWI=
X-Authority-Analysis: v=2.4 cv=baJrUPPB c=1 sm=1 tr=0 ts=688c559b cx=c_pps
 a=aW4vknxyaucVHP+kLABQHQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=8gLI3H-aZtYA:10
 a=zWnBB0OroquXeovzAQoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: XdkwGBNC9RIAXGkGd61XHVbh0OHhXoyU

Am Thu, Jul 31, 2025 at 08:26:43PM +0100 schrieb Russell King (Oracle):
> On Thu, Jul 31, 2025 at 08:16:42PM +0300, Vladimir Oltean wrote:
> > Hi Alexander,
> > 
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
> > > 
> > > Any hints or guidance would be greatly appreciated.
> > > 
> > > 
> > > Best regards
> > > Alexander Wilhelm
> > > 
> > 
> > In addition to what Andrew and Russell said:
> > 
> > The Aquantia PHY driver is a bit unlike other PHY drivers, in that it
> > prefers not to change the hardware configuration, and work with the
> > provisioning of the firmware.
> 
> I'll state here that this is a design decision of the PHY driver.
> It is possible to reconfigure the PHY (I have code in the PHY
> driver to do it, so I can test the module on the Armada 388 based
> Clearfog patform.
> 
> Essentially, in aqr107_fill_interface_modes() I do this:
> 
> +       phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, MDIO_CTRL1, MDIO_CTRL1_LPOWER);
> +       mdelay(10);
> +       phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x31a, 2);
> +       phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_CFG_10M,
> +                     VEND1_GLOBAL_CFG_SGMII_AN |
> +                     VEND1_GLOBAL_CFG_SERDES_MODE_SGMII);
> +       phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_CFG_100M,
> +                     VEND1_GLOBAL_CFG_SGMII_AN |
> +                     VEND1_GLOBAL_CFG_SERDES_MODE_SGMII);
> +       phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_CFG_1G,
> +                     VEND1_GLOBAL_CFG_SGMII_AN |
> +                     VEND1_GLOBAL_CFG_SERDES_MODE_SGMII);
> +       phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_CFG_2_5G,
> +                     VEND1_GLOBAL_CFG_SGMII_AN |
> +                     VEND1_GLOBAL_CFG_SERDES_MODE_OCSGMII);
> +       phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1, MDIO_CTRL1,
> +                          MDIO_CTRL1_LPOWER);
> 
> with:
> 
>  #define VEND1_GLOBAL_CFG_SERDES_MODE_XFI       0
>  #define VEND1_GLOBAL_CFG_SERDES_MODE_SGMII     3
>  #define VEND1_GLOBAL_CFG_SERDES_MODE_OCSGMII   4
> +#define VEND1_GLOBAL_CFG_SERDES_MODE_LOW_POWER 5
>  #define VEND1_GLOBAL_CFG_SERDES_MODE_XFI5G     6
> +#define VEND1_GLOBAL_CFG_SERDES_MODE_XFI20G    7
> +#define VEND1_GLOBAL_CFG_SGMII_AN              BIT(3)
> +#define VEND1_GLOBAL_CFG_SERDES_SILENT         BIT(6)
> 
> and this works. So... we could actually reconfigure the PHY independent
> of what was programmed into the firmware.

Thanks, a good idea. I'll check how the firmware is configured and override the
PHY configuration to my needs.


Best regards
Alexander Wilhelm

