Return-Path: <netdev+bounces-228319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D24EFBC77CF
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 08:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B37C71887578
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 06:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A07125D53C;
	Thu,  9 Oct 2025 06:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="DGrGgQKR";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="Ynd41jfM"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD274824BD;
	Thu,  9 Oct 2025 06:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759989969; cv=fail; b=tP9WYN0HiOCGdiKX8sAyP1056fUJMlMEto9UXubrkQifL144Rt38KuxnaRZbVNRTSJQNgkj+fU93O1eW8pwtpT8LqU/jy96aAvByH18xF/BKPXTLp+JEJmwl5O57LWf3bkwZ4uJIOwpL6ikDmYEmWWCjgwuICnh5mGE35VL2wnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759989969; c=relaxed/simple;
	bh=EMzNFlVpDp4kt2APGOm2OfRE1jjdcj7SS7Y10Ud1yUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OrQceAo8x8Z7fP+weDBEH3uviGJOzEaeHsmvsEDrEx3iNxoi9wKeRArpL7hm/MnfLBYBiWcgVDxd2IaxnzJBogPtmWuSw8foeXiXpc9L86x8PTV+hrnFfbxeWVBI3CrmRdlS5AUaG+QEd6hxYxQUX9VUEqcQ1ovsA+6+ph6SzEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=DGrGgQKR; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=Ynd41jfM; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5994wpu23218801;
	Thu, 9 Oct 2025 08:05:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=270620241; bh=GgeR73JqKw4XZfNZMDviuFTP
	+ery3u71+Ae9/9rHho0=; b=DGrGgQKRrgqb3WfUdc7Ice9FtTPmhyAxKzH92yba
	W/05jnZloGL6hvP5zGA3fwDIndnTIAhOgniOws/n8/uaaOx/4R3VHrc+Igq4u+x9
	fukue5WEdlpqcyySZUGecyLkA/SJxKw05RA7g8aMVWJjWxWytIQ3ABAFpaI8zLS9
	uywPjazQLhHBNarqqSZEiHuhjEqn9uv4BN+1qT2N/16Z4D/IHT4MkvSh5w+sQ4xP
	lWCaQD2DTuN1VgFiu8MI9GEfkkQ0f+5NRPHCuR8MCzQIR02niWlJkKuet/AZW2sJ
	0AoIkdR7/nhFZRCPY0QtL+mUi5JDeGPXyZ7+oDRM9sSSyg==
Received: from as8pr04cu009.outbound.protection.outlook.com (mail-westeuropeazon11021141.outbound.protection.outlook.com [52.101.70.141])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 49nqefgrrv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 08:05:41 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zFvHKqUehmA+oHcCBtdAVudHOute2v520FJmdOdlCkvvW5sOffyNd5W4mwczwvhuMQrI/khyNmX/5pFBS7e2vtblk73DOGc5614IEsCtw1jY+LCJIcKgzQqgdbcb1YrJRpOODOljiNawp/We6Pqpp3bhngcFVINVauMQ/zG2c8hgvgHa1iYM2Jw7It78BcaZjN0UCJT1hS70Lc7rMF/xSn/8x8WKdsU3PTk+4gIozpLR2MyQnTfBf644mYaVaQGbplPK93xEwMhbDzPk/F7XU6ibURpL9cnlbhlxOXc1HDA7eij6Gjr8iB8QVaV38nlv8sn5pgg0iZHegQ59IRZKGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgeR73JqKw4XZfNZMDviuFTP+ery3u71+Ae9/9rHho0=;
 b=jtvdDQDBbxr7GdvoRO4soXfUioanPI3f7xmTPbHJRIju5gsk7o/vNiUaLfTWS5CpL4KczA36aohlhYCxkTtiEKqq8G5MG9wyafilZCQ9wle5yKqv0SCbuxuk6MeTRMOQlrlBpmn3cOU+80CyXLjwHEj7d2yVxtCvLk/uFOoV/7Ord82vdLPm9dWngfP6Oam0iK2lQWN7gkxaHohoJdogKfKLkPYNdRXeS7Ti7dIW+fBMfzpugMnTTyH5pZbgs156RBRaiRQFocM1IUO4HtqQUTAaNk2r8j8kO8JYbqVkioaduL4xYt1FGzRMOChy3EsyibAKm4mquTz2FmuuKWjS9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgeR73JqKw4XZfNZMDviuFTP+ery3u71+Ae9/9rHho0=;
 b=Ynd41jfMOMAJKkwR8MMLjQ7PEARIlJiAHcbzxZJ2mEg/peQnkZEeAf5DhQvHEYx6t21pePJd2W6A3uWxjIV+oa/VCiRl09OoPsnvA4fsEbWJyRDDiQbLYbrOcgRujHkzm5sISiGqIm9dyWAg8rWV085CBikMbZxkmM2/eFmTrR8=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by GV1P192MB2636.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:264::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.18; Thu, 9 Oct
 2025 06:05:36 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9160.015; Thu, 9 Oct 2025
 06:05:36 +0000
Date: Thu, 9 Oct 2025 08:05:32 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <aOdQrJMtafhOh3GQ@FUE-ALEWI-WINX>
References: <aK7GNVi8ED0YiWau@shell.armlinux.org.uk>
 <aK7J7kOltB/IiYUd@FUE-ALEWI-WINX>
 <aK7MV2TrkVKwOEpr@shell.armlinux.org.uk>
 <20250828092859.vvejz6xrarisbl2w@skbuf>
 <aN4TqGD-YBx01vlj@FUE-ALEWI-WINX>
 <20251007140819.7s5zfy4zv7w3ffy5@skbuf>
 <aOYXEFf1fVK93QeS@FUE-ALEWI-WINX>
 <20251008111059.wxf3jgialy36qc6m@skbuf>
 <aOZm52L7k2bAEovF@FUE-ALEWI-WINX>
 <20251008145549.6zhlsvphgx62zwgp@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008145549.6zhlsvphgx62zwgp@skbuf>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: GV2PEPF00004537.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::349) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|GV1P192MB2636:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b14b50c-dcd9-406e-282b-08de06f9dd74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A/vg0za3Kek8wJAmfPtZhlUTWb8Ags3wWqSxMMc4DehK0gsQYMJBJQfuwmcj?=
 =?us-ascii?Q?cSAXRftz0fDKN8ttL6o41TuROyOYRmOw4235pMskC0uDBY1JVr9fmikOaORO?=
 =?us-ascii?Q?4pMDvucQWKOYILEvu51o1n/hDJItlSqY2yQb8rp3xZK3PGrDjM/tDVzfMoO6?=
 =?us-ascii?Q?V7/Lkm1fYwzfQXQFFCthjgKzNNdyA8p+F8OfP1vutJDX1WP5skPLS4RLK1Pv?=
 =?us-ascii?Q?fXwUD4nBrfLsyC3oF3X1UD7u8EdNuz2dV9t2La8GQo76DvFfnWkJKCc6jxbI?=
 =?us-ascii?Q?CpqaxAmL7DfDdPwmjydd7cFZP7aoT/bX09V46R0TTaJD3WhTtZBB5RWdwAYU?=
 =?us-ascii?Q?VFxeoZLMlkWnJfWdS6VUeT4efyG66TzHtapqETRh+L7O9R/+Khm1aFMcId4e?=
 =?us-ascii?Q?f1xNXj6XuqDekt9WTIXBK5PQT1Fxbf3PtHz/8A+cNQxbZXgBR10f8Vfqtjfb?=
 =?us-ascii?Q?7rQIf0l9eXveJnuAsyTnI+AS+J1/DfvK/YNsW3t6yOjq8aaQ62qskjdGmOo2?=
 =?us-ascii?Q?AotOqf8Fn2diSsTlKoP955hnvVxYLwc6wIhuocxbweodEWY2YfhjUvRigsEO?=
 =?us-ascii?Q?RAxoEc7dDLZ4G/tbVz3+tj7zf4h/6Z2s00Ef64Fdky2XkQCmAhJcHi/NYHvf?=
 =?us-ascii?Q?MPyaElvwaOeQ7LMJqoQPL1doOPg2fUAJSCKNKk9PY4elzpRYQdZmEcz925rg?=
 =?us-ascii?Q?dSuVn/B8PjvHsJd4OHJMtsXf1IC1h72gGJwNcPfCRrJj5X3ESwUtHBraqDyn?=
 =?us-ascii?Q?GcPoadKNwPlfdv8a9k1DRYVuL5m1dsFq7TMOC7BQKJTXoxlBfjr0Rey5Ek3o?=
 =?us-ascii?Q?YHy80owpHLRch0TfFbd+uCAvwsOreuYs8DAIzcfJA/nCy3ak6e0v06xwADPl?=
 =?us-ascii?Q?B0qGCP3e4R3/R+hA4E09rDXJ3cINYDh1+8y5xgH1mV5QgxaZDeZeDFJIDSVN?=
 =?us-ascii?Q?G2xzCw6twIcDmTpywqtkEc5Cp0Sn+YS2Q+Na4FOjV6HTenKGgXL9+5l8pod1?=
 =?us-ascii?Q?a0ZxhneAK/hCiLl1tQm3TuPsiHvc8vQdB62MjQuxUzbI5arLSMYlPiAhU+Xp?=
 =?us-ascii?Q?7/1Owap2OdeDLz2FBHdCZZwKffEJHWKzhb/Am7m7h+kAcgptiyTtN4xGLZNn?=
 =?us-ascii?Q?MwjEEHMPXmsvYTaMCo7hj3T3vk6o0V1Xp0Jeb/LOQT3LSnOvi0SRaDHwTnwt?=
 =?us-ascii?Q?39SwN3Y5s5OcD3IeHjHQ7jEGNwmZDWdqwMWGawDP2394tWxl3Z8PqLbnky/4?=
 =?us-ascii?Q?1gkOKEjd26to1Ey5aNzTZBxWYw28A3jJkcIBCwXWoB11x915i63Esrsfb7IW?=
 =?us-ascii?Q?xwiu+f05jxT7Tbz2r12ARG0F5HcfgN5SHyJV2NN97ISKvV7Kch/upGqmJbxU?=
 =?us-ascii?Q?nJHQwllLWj39iTp6OP/OUxKcLgUs5Mbk8kEt4qWxDmV9sUazmJOI4LWw+Lz3?=
 =?us-ascii?Q?abEXw71eqkfTlDts75nDApJRUp3hnhlv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rjvh+T2Vk+qvW0ohWLfR9aSJFpaZ1w2HaxhOVSWRmCxoAezpqTkQtHzSLLoI?=
 =?us-ascii?Q?YNaSPJ1ph4PBphtp/JmhXx7Oug1JYSLuc/a9IPKnq3X4EV19+ahG9CIvwll3?=
 =?us-ascii?Q?5KKLeYK7aWw+JXvja/Wd+4V/ECv+Uj8bUXAI0AZTTWyBnItX40A2yXGAApXc?=
 =?us-ascii?Q?5VkgBJ6PEoMN9L7gGqzOkDHIOLW2Fbs1S/7aQtddZG6/F4OcAP/dHJU7H4LP?=
 =?us-ascii?Q?yOOFNfuJZNXHWqLcvkI/FyLjUOGmylGcRPUkUPzEtjNx6FvtAY0+asPB1YWD?=
 =?us-ascii?Q?mf7dJqU9/qW1fsNKrAQQlazxTImOmspBHb2q4kD2qrpIMKqWtMw+MFH+J3TN?=
 =?us-ascii?Q?iA3s7caEUQtv9zsxhaX0uMtITJRQjbIFgGu7JDtyAAR7bbEPnrfubt3rJjL8?=
 =?us-ascii?Q?/pk6w/BSwjVNRN9fsWdkzoZ1bNZbSuqBNZZpWjXAoOgL+JT/r2/1W/vkPLus?=
 =?us-ascii?Q?+cVhF1z2W28I+5Bj11KA4JVEdKfdqiP5YmbLL02+rk4q4SZLmsbSP8O1H3nH?=
 =?us-ascii?Q?hptQ8Jcz1pxRh+EU7DXQzOuCUl2N9d76kehJhY15GWXSK+gUQAuVWSRfuRPr?=
 =?us-ascii?Q?fyWKc+KPeNQeqmh7dQfACrNW9R/SbMHcMPpsqa/v3k/Rt743kuNLyIQITbrs?=
 =?us-ascii?Q?yPR7SXx1M/k8fkhH1qBWGYVS0OqGQpFLr5l+NEgcoolR6qBNcXvxI9ra3TcO?=
 =?us-ascii?Q?s3LtyKt1z2x4pvtU68U54QckXVLN03Q6sRxHsT+82W7aa0LzrJsD8/6U92k6?=
 =?us-ascii?Q?mGyGZ7rkZbmMOFZZrlCa2B00i1TfwC6Ktrnf+Hpg+JU8ek58GPxHR1KaXa/p?=
 =?us-ascii?Q?xNdOQg+UXlLAkd8/3RQPXv32EupCEK5TjZ+1k45J59BuK4vCyBF2Bb4et5fm?=
 =?us-ascii?Q?1gPHybkqwLewvroIrmgX9shTKAv9oLLwyyxrqEDzLdlg/beodnbVEHSmGJVL?=
 =?us-ascii?Q?X3fH3lpVpJ7c+a/A42f8l75WfNG2rKsZKTAsHbIUgPzvehM2h0ge1ziq3/ga?=
 =?us-ascii?Q?6DnbtrpJ7mSANVuEOwgvUoA/cTMhnAzmbmPgnHOYBr/qwlh/niSsNR/42Bqf?=
 =?us-ascii?Q?rp0tKdSM0iaTpDoeVuu3mbNa3TwtR81HEuBgAcIZpcrU966TBbbzmtd/JLVX?=
 =?us-ascii?Q?j0RlkXObhpBzRHKzvN5nd60uTR29SWMrP0cvc54eMv1Is3wV0bvlip2Jnp2P?=
 =?us-ascii?Q?vcW5AiFiDzgi5MWeW9y2zGdGst+toCpuTET0fULvJCdiZXso/E9B8a4vf+m1?=
 =?us-ascii?Q?Q4RtFt5ELJbFTg3J0tHVT18mrxc5nyviSDgOH9/h8GdtcmxiG4T4NcvwhSB5?=
 =?us-ascii?Q?N+1EXk89e83Py+wLMwNhox24lFRvmOWKwt5LV/0T/O3T1otmcVr53xSYblcy?=
 =?us-ascii?Q?DPRw63GkAfm+Oo8szWz2qibkP5ltVpr9uXYR3+7lY8etZb5Hr583oZfExOhq?=
 =?us-ascii?Q?dlP616JO4nlchOexPuQ1++Axhu1rab9KQV/l0hLGlXQX73FDb2cYRLyu/R4r?=
 =?us-ascii?Q?jpuRifCnoqIQZDhFVRg3hYTqBZTEpS8Mq03zRW/WUSDaEfZvH9aakzVv0jB6?=
 =?us-ascii?Q?hINda1hVlovoDWwMTE3OnYa9RTj359DvYpg3u5Dl?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	q20sYYsTqhDK4x1PWm5JuW1ULHkxEO2b9L/9jXE5ymYR6605Ux/Yk2WOObBkV+Sq7+rp9iLXiBP1a/YwAI4wHKEh99K8ndBGMMfJH6quz2fWFghi4uGbNbXqyuCsYgHs8Nrp38ZgAqaqK/TlIQBlEGxV08osBb5zp92uTpjDfWtL+A1ROLh8mEWE8UBGPkyMN0chlA2SV4xHXBG49SnZ9seDQmh4GS8iwCCpzfQwmkco4W4ZCdtNqoawn/QGWpBMc5XhHfO4BlknOTU7aeg8CHCrKJ0E+1Ml2jiuyxGDlOCOY0kSM0pUv3sAGCVTBafno+Mq+dj1g76vs/C2dwvemGqrBDp+G98MJsgwpnWBQi8z+SsoSA7YnGekhRe65c7NlRfmICySBsBY6mxmaqMH1b9myvOUjSpfFXepREWj8+jrOTVntM30qj3xBIJRy2kQJlluBlXK+fOa2RGeYZOOl3HS14eCHC9juorTMJmEeTKhp9VqQYbsvbPhihqvI9qmwgCgyv10PzELmYbfuWVA6AEaFqQpCJFlv451N/0sCROOOjUKSH3+5I/UPZaQHwb77ROINidMrmULgVVH5oQrxRdfG7vQKxQHJH0W8d02XHdI4iIO7wQgekxUUqq7xgSx
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b14b50c-dcd9-406e-282b-08de06f9dd74
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 06:05:36.6030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ux31PxU/ZivF/kXHyH9MW8WFepgBn6S+jm2VymZmsEbaPhqywBjHetmQZxoZS1U9/YO0S8vZwBXMR4uCH0SY1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P192MB2636
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
X-OrganizationHeadersPreserved: GV1P192MB2636.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA5MDAzMCBTYWx0ZWRfX3+Il7G7s3LxL
 lSjOWQfDjXIn8oc4GMUQ4lszG51wncrqK/rjzvlDAzLVE2qE/dvam0CMq6EiSyeW0WpxVTsagQl
 2IijyzhPAR68CYusF8ctgSK54s0FgsOGkr9+dcM9GIrjfNCjMJG9KvX95TRGHrSR8fw0dccXEyD
 mH5BYA+jGmJwA3Shgd6K1PP8Ul+I+VsQBrUGIiXE0k1UqrPVfvqKNRUdBf20vqPuwQ4eczgg3Ng
 zruaK91aqMwmqQqJnolwlTqcrLPA03prdOKc/kZ9SCD+ani2IS3ZybNEVtutTifS3TaxTn8z7aH
 q4KFCeQTI/f436pC8vP/vLNEASSSbDiBHD1sZStQo7J7nst5/fjEO4BsnTfYig39Ey0UMHgsRrR
 SSF5G/BrVEWEHwYbYD7EbbsxMLeorg==
X-Authority-Analysis: v=2.4 cv=N7Ik1m9B c=1 sm=1 tr=0 ts=68e750b5 cx=c_pps
 a=krwu8lLrx8eMRI39iZUgHw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=8gLI3H-aZtYA:10
 a=3mT4Kf_Qs1tPe5ub694A:9 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 65hOlY_ty3QN4-CpilbqU_kTNuZCHpDB
X-Proofpoint-GUID: 65hOlY_ty3QN4-CpilbqU_kTNuZCHpDB

On Wed, Oct 08, 2025 at 05:55:49PM +0300, Vladimir Oltean wrote:
> On Wed, Oct 08, 2025 at 03:28:07PM +0200, Alexander Wilhelm wrote:
> > I have the broken 100M link state again (IF_MODE=3). Below are the debug
> > details I was able to observe:
> > 
> > * With 2.5G link:
> > 
> >     mdio_bus 0x0000000ffe4e5000:00: BMSR 0x2d, BMCR 0x1140, ADV 0x41a0, LPA 0xdc01, IF_MODE 0x3
> > 
> > * With 1G link:
> > 
> >     mdio_bus 0x0000000ffe4e5000:00: BMSR 0x2d, BMCR 0x1140, ADV 0x41a0, LPA 0xd801, IF_MODE 0x3
> > 
> > * With 100M link:
> > 
> >     mdio_bus 0x0000000ffe4e5000:00: BMSR 0x2d, BMCR 0x1140, ADV 0x41a0, LPA 0xd401, IF_MODE 0x3
> 
> Ok, this is why I didn't trust the print from lynx_pcs_config(). BMSR was 0x29
> in your previous log (no link) and is 0x2d now. Also, the LPA for 100M is
> different (I trust this one).
> 
> We have:
> 2.5G link: LPA_SGMII_SPD_MASK bits = 0b11 => undefined behaviour, reserved value
> 1G link: LPA_SGMII_SPD_MASK bits = 0b10 => 1G, the only proper value (by coincidence, of course)
> 100M link: LPA_SGMII_SPD_MASK bits = 0b01 => 100M, PHY practically requests 10x symbol replication, and the Lynx PCS obliges
> 
> So the AQR115 PHY uses the SGMII base page format, and with the IF_MODE=0 fix,
> the Lynx PCS uses the Clause 37 base page format.
> 
> We know that in-band autoneg is enabled in the AQR115 PHY and we don't
> know how to disable it, and we know that for traffic to pass, one of two
> things must happen:
> 
> 1. In-band autoneg must complete (as required by LINK_INBAND_ENABLE).
>    This happens when we have managed = "in-band-status" in the device tree.
>    - From the AQR115 perspective, SGMII AN completes if it receives a base page
>      with the ACK bit set. Since SGMII and Clause 37 are compatible in this
>      regard (the ACK bit is in the same position, bit 14), the Lynx PCS
>      fulfills what the AQR115 expects.
>    - From the Lynx PCS perspective, clause 37 AN also completes if it
>      receives a base page with the ACK bit set. Which again it does, but
>      the SGMII code word overlaps in strange ways (Next Page and Remote
>      Fault 1 end up being set, neither Half Duplex nor Full Duplex bits
>      are set), so the Lynx PCS may behave in unpredictable ways.
> 2. In-band autoneg fails, but the AQR115 PHY falls back to full data
>    rate anyway (as permitted by LINK_INBAND_BYPASS). This happens when
>    we do _not_ have managed = "in-band-status" in the device tree.
>    The Lynx PCS does not respond with code words having the ACK bit set,
>    and does not generate clause 37 code words of its own, instead goes
>    to data mode directly. AQR115 eventually goes to data mode too.
> 
> I expect that your setup works through #2 right now.
> 
> The symbol replication aspect is now clarified, there is a new question mark caused by
> the 0b11 speed bits also empirically passing traffic despite being a reserved value,
> and in order to gain a bit more control over things and make them more robust, we need
> to see how the PHY driver can implement aqr_gen2_inband_caps() and aqr_gen2_config_inband()
> for PHY_INTERFACE_MODE_2500BASEX, and fix up the base pages the PHY is sending
> (the current format is broken per all known standards).
> 
> Thanks a lot for testing.

It was my pleasure to help. Thank you for your patch suggestions and especially
for the detailed explanations. I now have a much better understanding of how the
PHY and MAC interact.


Best regards
Alexander Wilhelm

