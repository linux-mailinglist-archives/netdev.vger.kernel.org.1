Return-Path: <netdev+bounces-227546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5ADBB2932
	for <lists+netdev@lfdr.de>; Thu, 02 Oct 2025 08:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D552B17A31B
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 06:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A662494ED;
	Thu,  2 Oct 2025 06:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="C+abAudX";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="KNcOhdeL"
X-Original-To: netdev@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64C2134CB;
	Thu,  2 Oct 2025 06:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759384991; cv=fail; b=QQAwsG+68sAShe52vgtjjshym3L/5xyjsvJUtSDdhmelpHQo645PvBbP7voOndDtFtMeIfVQ8lAwQSDzw5ZSxJv4eXs7MZkT8aIJNobdVNKwoK7CAXb/zylp+qerAG3RC2Wjb5tyOT250OscJPztgQnoxzlZxRkLCCEw6pC9iao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759384991; c=relaxed/simple;
	bh=WLXuVH3Wna7Mkwe3FmwN0rX/YFKvAnPLSz+A0JjWF1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pDTFNzq2SGoj1MLxBF6WrriKcjGTTvhFDwpa7VUxkWfQXnrFhgcs6BIHL8xtjyql7LSOFUF2hpzufKez4qO25KYwC2mA6agGkPtVyVDhD1X0g7FTVVKJGzJZEsz4bcGX6xIGREPeX4pMuRGOE132Tt+x1STpx73PHL3l3iRtDgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=C+abAudX; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=KNcOhdeL; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5924xcRr3770376;
	Thu, 2 Oct 2025 07:54:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	jlAvLaV9oA8yTedy++m8hUZf951bPIc1kyCRYavUFYY=; b=C+abAudXPL/HVRhA
	GE5cSM3pg/Oqz6+HqpGGOMVHyVoRLgrYmbAi4okOhY3PSPNHAp7ibFssBckMzDka
	cPrqXLcUrySTi7cUSaQ7LkZQl6riUiRk0qNpaeYKSJuHv+PPymn2i1QTG+HOKegd
	JkNYSTN5/AEKITAzT36pYnp4rDHimsKfpemrg4xkd1xhoFHIDLnA870o8iTmU3LW
	RaD5BsFKLo3UJXuoZfpjBv2yHqYh9stw7DkZyxQ4ICnm7yKR1BmUjJXAwYpnTPLo
	VF1HpFF4dclBrxAvrFkpl9s/2E6ycPkPXieQTVW8j6CMJABOjoREJS6Uqk0Udp1h
	3Qx0XA==
Received: from duzpr83cu001.outbound.protection.outlook.com (mail-northeuropeazon11022132.outbound.protection.outlook.com [52.101.66.132])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 49e3x04nut-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 02 Oct 2025 07:54:56 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hlpt2Zr495yegEeNdvEBxsBpKAcDLW8rdQHAKk4WidGOAssUQe+EKfinEr3cRZo850Pg0wF4Ou52LZO5b82SZz1xtL3tWyn9mJzcicsxCEZSyaZfsHMEhBgVkjehG00Iq4ya+pGJKzKSvq4AwyLgPkISbCekd7cDQZstpV6BJ4j4S/9V4wQl8YIRGHzLUWCpuaq6fc7tncLKGJ18uPKLK/G/oaOcOgGxX2wCUJQFG5QVRBm7vES3F4+XGAmotvrSoNWGWtR+MEuhhhvnw973imT8pQ9cjgcVt5LJoE7Ts6gYGPX7DO/ake+amhMx8ZjMxmT/DeL5+0OX5k/i7Zoh4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlAvLaV9oA8yTedy++m8hUZf951bPIc1kyCRYavUFYY=;
 b=Qh1VcR6l7tuA2jfWl+mHndBz+1vj6qgUS/DrSpLPJJCDvWzOPVrdT+C3f8xMjBlockuqjS47gM1/dkKKaS3DxqrN6dCNjvDeQo4utQGjrmXJFfuFXDqWSIS48xygjStVqmMjhE8P+BUdA6IOr/HlIQBkdFhDV4pcPLcGOJF6ZjCTPFA5SWsu7iRivCSUAXnUhxDObxFkmIMldKrS3toICXP0r/ddGqA02h4tJ4JcRzXWs6wKX70lAr4dIbTKFwsUk0K3z8vzmEOdkg7cdzOKOSr+sc1VdJQm13MnCcmPGnIqFFcGe0/ovXFTruOLt2lCz85VrfQLlB0YXXKTdw8cjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlAvLaV9oA8yTedy++m8hUZf951bPIc1kyCRYavUFYY=;
 b=KNcOhdeLhhXykiLi4qrbYN+NY6fYUuGaSIFShCIGHzU2si/9YGXOxrQz6K0T4uun+R9+k/R85HTQ4TtlBaoPpttQ68yKrRZkIYtorfx25rY6+T+cqGOQVyHUXhnoB0oseU8NKXZn7ajZjancmfdJrwokzxCsmbVQIec7jdP/Bgc=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by AS1P192MB1567.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:4a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 05:54:51 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9160.015; Thu, 2 Oct 2025
 05:54:51 +0000
Date: Thu, 2 Oct 2025 07:54:48 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <aN4TqGD-YBx01vlj@FUE-ALEWI-WINX>
References: <20250805102056.qg3rbgr7gxjsl3jd@skbuf>
 <aJH8n0zheqB8tWzb@FUE-ALEWI-WINX>
 <20250806145856.kyxognjnm4fnh4m6@skbuf>
 <aK6eSEOGhKAcPzBq@FUE-ALEWI-WINX>
 <20250827073120.6i4wbuimecdplpha@skbuf>
 <aK7Ep7Khdw58hyA0@FUE-ALEWI-WINX>
 <aK7GNVi8ED0YiWau@shell.armlinux.org.uk>
 <aK7J7kOltB/IiYUd@FUE-ALEWI-WINX>
 <aK7MV2TrkVKwOEpr@shell.armlinux.org.uk>
 <20250828092859.vvejz6xrarisbl2w@skbuf>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250828092859.vvejz6xrarisbl2w@skbuf>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: GV3PEPF00002BB0.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:6:0:1e) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|AS1P192MB1567:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a97e758-7d13-4474-730c-08de01783447
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFYvTVo0UHkyWDdMQ0J5VmEwMGxuSjBjazdUbEtOelNzQ1VkR3IrdXNzbzMy?=
 =?utf-8?B?dU1TMi9YL3JELy9SNmZwUktHOWZBMkUxblR0RXJ1aUhhbUtjaitWRjZBdWtX?=
 =?utf-8?B?TnlQblNEWWhVRklmUktCWU5RUmFXb1BwUitnSWJQclAyUnJ0SFo2L0ZNRkRV?=
 =?utf-8?B?eUVQazBlN2xUc2YzWkRZdXR3YmZuQlhjdnJ4VmRIMmhad0VWSEVQV2dIQ3Rr?=
 =?utf-8?B?TzZweGwzRE1tc1JPZ2hHNDY1NXVua0FJWm96VHI3YU9IUDFvN01XRHlMS2lE?=
 =?utf-8?B?UHRJUld1T1lMTWJ6cUcwbTRpelVrTWIxT1lpK04ra1hGNWoyS0VGS1RBVm04?=
 =?utf-8?B?NE5jZ2JXcUNFZjNzT1FoZWwzSlNENGFFVkZkc0JobnhXRXZ0YU9YTnVrYUV1?=
 =?utf-8?B?ckxKWGwrcXdCVmpQUmRCZFdVMk5WeTBQc2E2ZmJ2UjgwZ1lRL0UwV1B3aVZI?=
 =?utf-8?B?OHdvYU9HeW1nTGUvUEFmNStjOWlqcVQzYU15dmtEYzRSRXp5WlVHUWlEdG9W?=
 =?utf-8?B?RDkvTTMwL3NuUTJKMFJPZnVVTVJhYWptbmNiWUdjUWVqQlYvZ1JheSt3VjR0?=
 =?utf-8?B?aUNsY2dlQkN3NTBVRnZVWUs1SUNjQUtCb05rWWlKZHN2bUVPRGo5Z0E4SUtx?=
 =?utf-8?B?YXJlcEhJeVl1OUpPN0gxWElXbTlkZ3hobnRMVnBDWDFDTDhnb1hJRzNRK1I5?=
 =?utf-8?B?MjkxdElkY1YrelVHYW41MjdnUTFRREQvWitldFd6cG55L3hpNjRTZ2JvUWpT?=
 =?utf-8?B?cU8zY2JYMURMVnhGWThUVHY4UklPUDhQOHB3ZFk2NXA3VDJnck82TnZ2WVE4?=
 =?utf-8?B?ZGZiZmk1MW44Ti83YVVxbkhVYUpkUkhieEwvN3R0eE52OGY0cnRjWTdlelRz?=
 =?utf-8?B?SVI3VmdpUk81aGF5TUN1Q3lldURrd280MEcxTGVFK0k3eml1bWFFMTF2U2JD?=
 =?utf-8?B?TFBrRTVjdmhvOXNUVFVHZlNwWHpIU3BZNWdTQWVVakFXZVZhZGdmOTl3Znk4?=
 =?utf-8?B?aVgrOVlUK0liQzEyemx0RnJocFUwNDl6dGVsczJjOS9xNURISHJYM21uS0ZB?=
 =?utf-8?B?VTR5TW4xTWZPK09wOVZ5WUY1dXFBREVpOHA2Ykw5dGsrbFAyTDhwSUlGVGlm?=
 =?utf-8?B?WnQrb0xsQlAwU2Z1VFhOcXBBK3RNYk9wblRRY1JrczRLVXMxcDB3M2Z1WThk?=
 =?utf-8?B?VVE3Um9INXpiNlI0QjJXTFgramZWdktSUUo0eks4dm10SHRnQ0NjYWY4cnM4?=
 =?utf-8?B?RllnZUJHRTRyT2p5VVd4TlhCaUZSZE5tcDlwQW81em0zcnVDYVcwRWRReWI4?=
 =?utf-8?B?RUI1TzN6NGYrRWZxS3dVTHpMOERRVHljMG90VUgxZ0lqaVJHMjlZa0JmSG9L?=
 =?utf-8?B?bGZIQU5id214WXJyLzZnZHJUNkREdmdCN0svM3BCaEpqSDNHcVNlQkg3MUpj?=
 =?utf-8?B?ZUtSZVRIYnVGTi9MRHFVRmNjWVpraXJiQlVNOEJHcHFtRk5ZQkhTRFUveXdC?=
 =?utf-8?B?SXlwaFZ2WmdSV2VpZlF4emYxV00wb0lQUTZ5NGFieG1pUXlMOVhtN1B5d2ZZ?=
 =?utf-8?B?WnQvcXFGYW14ZXF3aG9SOEdmZEt1Z21USjN3UVZ4bllvdk5zcGNjRkxIWTlE?=
 =?utf-8?B?YXJsVE1wZ0hrSUsrTUpqYllXUXZzY2xJWExTbHJ2VjFlQjJBbFl6R1ZNRmxR?=
 =?utf-8?B?RHB6M1FYMVFUbkNuZjhKZFBYQ3pOT3BmYlBTejJTcEpPeHNHMkpndjhidXc1?=
 =?utf-8?B?VlpsUVBJVStDdU91czJFL09WMVVmSmFMaDdWNm55MU81NmtHcGtJR3RiSHdR?=
 =?utf-8?B?UUJWZlpxemtkUnQ0S0FpU1hMdGIyclNVUCtRK1FjOUN4TFFWWTR1OHNjdkFw?=
 =?utf-8?B?NDFkeUI4TUlid2lRTXlLLzBLR0lwQ0lwMnZOS3BDRUNIWFdSc0kvcTZRc1Bi?=
 =?utf-8?B?WDBUQkxFNmRGSGdHcWh2aHRhS0xJTmxoUUNyZWUvL09xS0pITmlZVXY5cWZN?=
 =?utf-8?B?TnhKNzVUdVN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REpCMFhzQ3prZWUrVGlpVnF5VWdGeTlGdXo3K0oyVWFzZXdxVW9CMHpTcUZ0?=
 =?utf-8?B?MGVCcUpkVTNqcDMwZHRxNHBIb29ScCttK1VZZWlOVVJMd3c3WmplNC93S3RG?=
 =?utf-8?B?Q0NYTGdqSlJHRUVMYzRweDFteStackMyVHA3K0FNalkyc1BHN0R3Mk1BaUoz?=
 =?utf-8?B?ZmExS1pBMUtQMEFHNzljYWNDWmpadFljbndIVkU1UnBRb1dNYm02NDFWdFpj?=
 =?utf-8?B?ODlTV1RqaW1PWHU3NDU4cFhBTElUSmZKVnpTWEtKdVgxSDdmZC9aQWlXUHlR?=
 =?utf-8?B?cmUxejNVT0RGTk9BQkQxN1Qvd1VhTDRuK05PR1BxeWhmb2VtUjh5UjB5QTQ5?=
 =?utf-8?B?dnVHeWxlK3lpVVM2NTFhSWo5VlhWeG93OWJJZm80cGZvSjlCTGtpRm03aWFa?=
 =?utf-8?B?UDlsRVU1eVdaKzVGTXIxTytEdDdGcFNYYTF5R1NTRTJXeTluTFJzZmozMWVE?=
 =?utf-8?B?dmhJeG0yVnZWZGg2TXNZckpVeE9pb2tmdkw5WXRIaDNDVGZhdXJIdnJMejh3?=
 =?utf-8?B?OTBLWWFSbndIR0J1WmFRYTFTNnBvMVZ1U0tUcndWT1hsdWI2Tm5mQ0ZlTXZO?=
 =?utf-8?B?VjhTN3VDaHRZdVNyZ0pZN1N5TXQ2azc3ZWVGblpFVkxmRlRrVWVVRS96R2NW?=
 =?utf-8?B?UXo3TFB6dHJmR3ZDdDlXWXo3RzNvWExBODVUaWdXbDdGaEVjRzZrTWk1eFR4?=
 =?utf-8?B?UG9IcVpLYldWMHBvZUJ0OUxrRUZ5akNpa0NFbTFYdy84WGcxamVrYkNiTDhS?=
 =?utf-8?B?NHE5TWVTQnArckFLTlM3MVBVT0NJNGpDMUorVzdydlRNUll3NThKcTRGeFJk?=
 =?utf-8?B?L2YyOWxJWGJQMEU5QW51Y3R6blR1ZjZrMjVBbHl3SGF4alplTzl2cE4ybjZN?=
 =?utf-8?B?S1BiUWU2dXk4WDVmdDByVnJyaXJ5MmZwTks2MTNoSlZqeWVWWW80WXhPQW5K?=
 =?utf-8?B?SWFLakxVVzZVemUweU9xTTR6VUN5M0ZuZ2lkSUh2dmlsV0d5THVpZm9LSFd1?=
 =?utf-8?B?OWgxaHQ3MXZyUHd0ZEtBQkhJV1oyaVlKNEJpYkJzU1lKR1FSV1lMaVRNSVpL?=
 =?utf-8?B?Uk5IZHhvSk1ZZDRma2dvTVNXOTBSQzE0TUNUbC9iOXQrZ1dBQXBXTGVVSS9o?=
 =?utf-8?B?Y1RHYm1lU3VkVkV3VWQrV2xmUFExdjFnOHZvR2h0K1FqOVNSdDlXb0JPaHNM?=
 =?utf-8?B?LzgwVG9iQ0JIRnFyQUlqcWg2eTFBZ2hHcUlXcjlBUllJRlFiREdzRmlMMzUr?=
 =?utf-8?B?U1daY2tJbkpNOVdKd3ZxRUprclY0OHZwaThsVXBJV1NwbEdWRTdZYzNDaldk?=
 =?utf-8?B?TUF1K2FtSzFXdUtpcTZLQS9VR1BRVHdmemtQWEdMeG5ZaWpOVG9wam5ZMzBV?=
 =?utf-8?B?VisvL24vMGFzTEFzam9GRHRWRVZLRVpKTnRvTHIvWTJSMWpIVm11bklha1ZE?=
 =?utf-8?B?bkFUTFdEcEM1RlVJa3Z5THhOdFRqdHFXQjc1R0NVVlg5WGVnMEdWVUNFaFdF?=
 =?utf-8?B?YWwrUEZRVEdDMGZlTlI3b2d0V1JNNnVwQ1hoV1VTOVUxeWxGNFpHZk1scUhj?=
 =?utf-8?B?Tlp4N2lmRzhaSlRON3QrdWt3Q0ZSaGNQUzEzQjVTRHVyUHRUbFd3SjF0c25m?=
 =?utf-8?B?YWVSbm1xV3BreDdqTVlSN2RyS3pMcjArSUlzdDU4Y1B6RHZ2WG9JdFpzaURm?=
 =?utf-8?B?aXR6dzAwcnhVWjM3a2xlTVpXZEx1a2JBR2hhK3dNOElIbXZkN2hPdENhS0lU?=
 =?utf-8?B?OHFVTFZNelNZV0x3TjQvVFlUTXV5enArUkp6amlaUXJ3N2NPMTZvNUYvNFhH?=
 =?utf-8?B?TEdsZ21VZ3BGYUFhbnB4ZkZ3QjhwUEVPOFJ1bDlCdDYrdFRhRWR6ZEN0aGxq?=
 =?utf-8?B?YzM4c0NLaEgxa0hzOFZtcklJZ0ZDRVBRTnlVT0xVMXR3MlVTVlk2U3JXVnJ3?=
 =?utf-8?B?Q1Rzc1dsZjN2cUQyK0FXaGd6ZnBFc3JMVTRkYStrOERUVmR2emdKRDNZSEhk?=
 =?utf-8?B?cUx1OGhNMUR0QjFUd2pMZHFhbThvb3h1K216K05ZQ29QNWV0SWtEcUViSmtM?=
 =?utf-8?B?TzdFNVVpWXBaY0lNL0d5ODZsY0k1bjM3UEYrOGpvNVJrVWZPUTBuYmV2NlAx?=
 =?utf-8?Q?py13j3GjHyxpMkX6TIea295YQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	K5RE6NM62bOxlloo5+4qIq+mT6JXognBHntvik0NtYoAw3uN0Acp0UiriP5IbmYIYw3RAtt1swXC0/I7+5RJEtGWNmUfI2shYodTP+UQjt/avGKJNSQmy9yfeXxcbbPhAj14FIcdAuYEVo/gVLPMVV1X6210I3+vmbewpxb2u3R4L58i+x/HnSX8bv7YcEep8ISomqzOmQUqJkGV/y65T+/XkSXD9eqWEN6D/F8a+Y+d4aaqPTOmkTCiEiBxbvaNu1P27VnQKhb49kyzSN+8iZ19r7637TA66m5AgHCg2b1lnjzVtVWOdUVIjk+00Kqgv+++ScScRTQiUyHgagaMxrs9HwfLnxAIcsCYIL005Op9/ohTusfPGR4UJhrR9GdHb0ZG4GctSXAcnIwN/rMi3ZDdgd5nG6+/hrWptIChvII5s15Z6IzIJ2PmQH6Yn24RUYlGdBMK6XGELGxridM8KvahvYMwig4GKCXCuO6Mtj0Pn20f8EX72BbnF3zPJUS+7ySIqp1p+jlRczok6cfSQuvXQkUc9+ikM7rVgmUXCmVZgewrTnwDLb6aOG7ou2PESVrPOrwW1H7Rw58RqddhvxsxFBCW3KYrj+fAFyCCIgitjT/Ro+FyIxu8zohmbybG
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a97e758-7d13-4474-730c-08de01783447
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 05:54:51.8762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d43NBOVz1FTQwUdIInvsaF6FxWsJHWzkm6Fz4RHFqygfl4OlDtL4GumGPjIeNPUSwIBhont3Wk+oFYo6mo0QOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1P192MB1567
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
X-OrganizationHeadersPreserved: AS1P192MB1567.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-GUID: 8p-wc9_CcO7npfA25oItrdA1VkTgtu6D
X-Proofpoint-ORIG-GUID: 8p-wc9_CcO7npfA25oItrdA1VkTgtu6D
X-Authority-Analysis: v=2.4 cv=aapsXBot c=1 sm=1 tr=0 ts=68de13b0 cx=c_pps
 a=ce19dCTNWBvJqlnRNCU0Ew==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=8gLI3H-aZtYA:10
 a=1XWaLZrsAAAA:8 a=zi3XbbriuI5IE2Z0JCMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAyMDA0OCBTYWx0ZWRfX8S5BnfOzy52N
 2UVBFbOGKSvlr3TxCgGUVsDEBJlZiLmqFx2G2PTFK1XPF8ZXTam46gFvRBOcfWAtRItmoYWlfPS
 UPpJSk5JMxXKHQrcJc2QLKC2hYma+vxzryAj/YEceFokyqSPqgR5h72iLNsLvsG+G4y3xs3SMBr
 t0As/hnVLs4TC+MEHfs20z70pFeTu+AKVfXNa6iOTHRx0djbSc/PMA1ZXzA4v2pFNNapHscNB7E
 D0rk+0Eu2zA/iYkTGcjgIQZzR5PDq1Ipcjy/ptmAIT5oTKQ/HKLbsA6QtUXcNdmtst/Db6rPwSQ
 NElCeSR0ajn3Koga9vIxRs2vBbH1skjnFpaJJbbnXUfrchmy9G8XW//VMv+mnykeIPILQO2XF5N
 pbp6awWv7OWrGScvB0vKJ0IVv+8i9Q==

On Thu, Aug 28, 2025 at 12:28:59PM +0300, Vladimir Oltean wrote:
> On Wed, Aug 27, 2025 at 10:13:59AM +0100, Russell King (Oracle) wrote:
> > On Wed, Aug 27, 2025 at 11:03:42AM +0200, Alexander Wilhelm wrote:
> > > I asked the hardware engineer again. The point is that the MAC does not set
> > > SGMII for 100M. It still uses 2500base-x but with 10x paket repetition.
> > 
> > No one uses symbol repetition when in 2500base-x mode. Nothing supports
> > it. Every device datasheet I've read states clearly that symbol
> > repetition is unsupported when operating at 2.5Gbps.
> > 
> > Also think about what this means. If the link is operating at 2.5Gbps
> > with a 10x symbol repetition, that means the link would be passing
> > 250Mbps. That's not compatible with _anything_.
> 
> FWIW, claim 5 of this active Cisco patent suggests dividing frames into
> 2 segments, replicating symbols from the first segment twice and symbols
> from the second segment three times.
> https://urldefense.com/v3/__https://patents.google.com/patent/US7356047B1/en__;!!I9LPvj3b!Fx2G5geAtgbXRIF2G5-FXZ1uR8K3DzHG9gwbOA0N3YRTEz4_c9Mx58Ejphl6RPuN5KXYHzAKyvPHyYnKNl1oJiY2aFmSNbRZ$ 
> 
> I'm completely unaware of any implementations of this either, though.
> 
> To remain on topic, I don't see how the hardware engineer's claim can be
> true. The PCS symbol replication is done through the IF_MODE_SPEED
> field, which lynx_pcs_link_up_2500basex() sets to SGMII_SPEED_2500 (same
> as SGMII_SPEED_1000, i.e. no replication). You can confirm that the
> IF_MODE register has the expected value by putting a print.

Hi Vladimir,

Thanks your for the hint with the IF_MODE register, I finally found the
root cause of my issue. Unfortunately, my U-Boot implementation was setting
the `IF_MODE_SGMII_EN` and `IF_MODE_USE_SGMII_AN` bits. This caused a 10x
symbol replication when operating at 100M speed. At the same time, the
`pcs-lynx` driver never modified these bits when 2500Base-X was configured.

I was able to fix this in U-Boot. Additionally, I explicitly cleared these
bits in the Lynx driver whenever 2500Base-X is configured (see patch
below). I’d like to hear your expertise on this: do you think this patch is
necessary, or could there be scenarios where these flags should remain set
for 2500Base-X?


Best regards
Alexander Wilhelm
---
 drivers/net/pcs/pcs-lynx.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
index 23b40e9eacbb..2774c62fb0db 100644
--- a/drivers/net/pcs/pcs-lynx.c
+++ b/drivers/net/pcs/pcs-lynx.c
@@ -169,6 +169,25 @@ static int lynx_pcs_config_giga(struct mdio_device *pcs,
 					  neg_mode);
 }
 
+static int lynx_pcs_config_2500basex(struct mdio_device *pcs,
+				     unsigned int neg_mode)
+{
+	int err;
+
+	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED) {
+		dev_err(&pcs->dev,
+			"AN not supported on 3.125GHz SerDes lane\n");
+		return -EOPNOTSUPP;
+	}
+
+	err = mdiodev_modify(pcs, IF_MODE,
+			     IF_MODE_SGMII_EN | IF_MODE_USE_SGMII_AN, 0);
+	if (err)
+		return err;
+
+	return 0;
+}
+
 static int lynx_pcs_config_usxgmii(struct mdio_device *pcs,
 				   const unsigned long *advertising,
 				   unsigned int neg_mode)
@@ -201,12 +220,7 @@ static int lynx_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 		return lynx_pcs_config_giga(lynx->mdio, ifmode, advertising,
 					    neg_mode);
 	case PHY_INTERFACE_MODE_2500BASEX:
-		if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED) {
-			dev_err(&lynx->mdio->dev,
-				"AN not supported on 3.125GHz SerDes lane\n");
-			return -EOPNOTSUPP;
-		}
-		break;
+		return lynx_pcs_config_2500basex(lynx->mdio, neg_mode);
 	case PHY_INTERFACE_MODE_USXGMII:
 		return lynx_pcs_config_usxgmii(lynx->mdio, advertising,
 					       neg_mode);

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.43.0

