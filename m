Return-Path: <netdev+bounces-152351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E8F9F38D8
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 19:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A5E27A05DE
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 18:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079742063E0;
	Mon, 16 Dec 2024 18:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="j20FXlYH"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E53D203D4C;
	Mon, 16 Dec 2024 18:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734373520; cv=fail; b=DtHOmB0f+VLWpHRDNDeI5PwbboZmJNcqX68lxSoDVrOd0WjqaBwlywxwC4WadcjuG65t7ifayvTNp+RjEA+XysGFCFX9Cna63UqptyPfE7hlp4E2k//RrXMpZZtv4eRBAqbmuzjJT0QGFcOVdYCjRYpLnssXhUssYMt6pA0NaSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734373520; c=relaxed/simple;
	bh=ZZuHqWOe7LpTR4FJAlOb3EOviWGJgy08/silTrvmnow=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VJGDZlnOQG38HACuPs59LeFmb2cMi0lzeIhSTRzkcDsVt3YOiWuqcTYI2Z+S/xt+jSZWewKGBARdgHatQAB3iuh6RfG2k5zuMs98k+quwT0jvfBE+pZP1b2VMxRZvz3gIhuIFOuUxtKmDadfuSQjAPaGJ9TA6g2w+GB/tkGbPqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=j20FXlYH; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGGpmUa023750;
	Mon, 16 Dec 2024 10:25:01 -0800
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 43jr3k862t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 10:25:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=syDLeSgbHFACIKox0kBo7SRgxCnz5EwomkGLOBWznqu0MRt2eH+r0/A985UqfBysvBegZlD0AZj32M+XJK0YdK6UZerri6XRx9JdNsH1CkHexw9uBeIDPdOSJY4mGvEJw+hLQ2nfAxo/pY5Uf/wn8UVHw7k4eJO5Ic0f6SUsKJ/F1aDFQO2TgLU0ez92hWnLUHsSPelG1HBPeslywwaeAiFUKH9R1xk4G29jGylQJkOLJgyX6+QWqOQMTqfY6M1dV8RiZVYLT3Jfyro9JAGF8g297Nihlcenv4Ly2f7/e+l40mbMndUnEf8QgAI3K1gWusKVY4JYy4RBmWdzNRUYqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZuHqWOe7LpTR4FJAlOb3EOviWGJgy08/silTrvmnow=;
 b=Bu7Gp2lneAVGZf5XF0z0M71JpyO6B4uW6nGLyqLVJzN/Zu03aCfFBN/hvbDSCof2rzJdmmb1jxTCSFvR0M8FoNME5dN3RbKfz3a8UcYE+7EcVGHGmR8KkJmytAPDdbwzR8S8geNOIl9Zrwc6LoNAsts9Z1lOsQ+DEFcAau8YbILg4u4SzvGDFfW5HRQqYsv/odomoWTnijJoZSwvCXmDVcKQ0Sox069D+8SxieWPT2atM6qnewWalN7/FM8NB5GJw2PaeI6623IvR6qfMUYkXZHKtxY2+bNHFCHiffxvaxeRRw7SGHHFVMmnatuxQaiB2P+fOLciBuad2Cukjj7YhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZuHqWOe7LpTR4FJAlOb3EOviWGJgy08/silTrvmnow=;
 b=j20FXlYHoJtZ+Yi/jLB/LBinPg6HyibLrYnNeqbjLg2J9dgKNrMXGGCXNxoIIFnAogK9j8HeIQ4386iXYzgNrOlHFUCsX7rixiyN0Akurb+C9M11q1whG3Ifs4WZdMIfP0KqtBsqu056/U6yNRivsydn04ULSI3MY3UtNXm38gk=
Received: from BY3PR18MB4721.namprd18.prod.outlook.com (2603:10b6:a03:3c8::14)
 by DS0PR18MB5338.namprd18.prod.outlook.com (2603:10b6:8:12f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 18:24:58 +0000
Received: from BY3PR18MB4721.namprd18.prod.outlook.com
 ([fe80::dfc:5b62:8f30:84db]) by BY3PR18MB4721.namprd18.prod.outlook.com
 ([fe80::dfc:5b62:8f30:84db%5]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 18:24:58 +0000
From: Shinas Rasheed <srasheed@marvell.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Haseeb Gani
	<hgani@marvell.com>, Sathesh B Edara <sedara@marvell.com>,
        Vimlesh Kumar
	<vimleshk@marvell.com>,
        "thaller@redhat.com" <thaller@redhat.com>,
        "wizhao@redhat.com" <wizhao@redhat.com>,
        "kheib@redhat.com"
	<kheib@redhat.com>,
        "konguyen@redhat.com" <konguyen@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "einstein.xue@synaxg.com"
	<einstein.xue@synaxg.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Andrew
 Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>,
        Abhijit Ayarekar <aayarekar@marvell.com>,
        Satananda
 Burla <sburla@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH net v2 1/4] octeon_ep: fix race conditions
 in ndo_get_stats64
Thread-Topic: [EXTERNAL] Re: [PATCH net v2 1/4] octeon_ep: fix race conditions
 in ndo_get_stats64
Thread-Index: AQHbT5BaYIqjRH+Vi0yNdgQ+YpYURrLo7ucAgAA+BHA=
Date: Mon, 16 Dec 2024 18:24:58 +0000
Message-ID:
 <BY3PR18MB4721ADC9261427273EE8ACF6C73B2@BY3PR18MB4721.namprd18.prod.outlook.com>
References: <20241216075842.2394606-1-srasheed@marvell.com>
 <20241216075842.2394606-2-srasheed@marvell.com>
 <Z2A5dHOGhwCQ1KBI@lzaremba-mobl.ger.corp.intel.com>
In-Reply-To: <Z2A5dHOGhwCQ1KBI@lzaremba-mobl.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4721:EE_|DS0PR18MB5338:EE_
x-ms-office365-filtering-correlation-id: ce9efa03-2306-4f21-d83f-08dd1dfef27b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Qi9WN0NaVDFYL1p0dkJpZUcvdWZyUGx3eTFZV1ZuWUZRTnErRm05ZC9qaXNz?=
 =?utf-8?B?RUJrWW54QkRaajJpUDJjNlBpUWxDQkU1NDByMzl6a2ZyRTgwcm1CSDNBQStT?=
 =?utf-8?B?eUdBKzdSSmxPZ0lXZmRldUc3bE4vOStrUGpvdXpUSzRuQ2JDRFUwY0ovaEx6?=
 =?utf-8?B?K1RkMEVMengveHFXa3ZrTFlWM1BJQy96TWxFWXhpUDkrVms1T0NzbENKL3Vp?=
 =?utf-8?B?eS9SNTZ6VWZSVFpjOUg5aTFpUjZKb0ZjSHhzMkxOUVpWR2tlbjJkbTFsOUk2?=
 =?utf-8?B?VW5UUEdrZWl0Yng4K25uMER4RjlDM0JtMzQxTzJLbnVrR0FVZHVYOWZqSU1E?=
 =?utf-8?B?NFlHOEtKT0tZQmNXeEUwY1JmblRmckFFRVpxK1JOcm84MjZFQTFsVHBQQ1l0?=
 =?utf-8?B?Y0dObDA2SGUrNkQ5U2oyKzc4MStUMk8wRXJZbGNlN2RiNlpxUXk3RlJvd2xX?=
 =?utf-8?B?bWNaNWw3VmpkcWlJTW5iRUdpaU9GQlVodnB0bXE5eWoxQmNaRHpWUE95a3lI?=
 =?utf-8?B?U0QwUXhhQUU3UHlsMGxKcVpyR2dGcXNKNy9kRU5saHYrZUdmWndENm9JK2Vr?=
 =?utf-8?B?YU1PaTlUV0o1UWZZOGZISTNFOVl4YlpveXdHeWl6a3J0NjRMQmM4RWliM2M2?=
 =?utf-8?B?Qml2L3A4Z0luZVNqbnBDNE45czVKZytKenFvcWFDaWxMcllqOVhRSWtHblpq?=
 =?utf-8?B?c2JkbXdWMytuODhPS1FsVGpiUjVNNWUwZGtvVXpGdDhJOGVrY1preW4rQW1a?=
 =?utf-8?B?cnpjMHFDaE1QVzFuWmlnUVZHc3NnL0NsOXZqVGpvRFByS3ZCVGlXeDA5eEZh?=
 =?utf-8?B?cGdiWUhVb1BHNERPWllGSjJXOGl2b2xZenQyNXUvYlZENHpYNC9yZ0NGWEFt?=
 =?utf-8?B?Mkt1NHFQWi9zaXFqbUlBOGlNbnE4dHVKM1oxQ0ppZU1xQVFkdUZRWVhEOXds?=
 =?utf-8?B?NFZ5V0s4NURGdkp6MElnK1pnRU9lSGhhVXdsNHhoUXQ4Z1NTSWZVZ25Ma0FS?=
 =?utf-8?B?ZTRhZjF1c1F0aVpPZTZTd3YrYmVGbVNkclRRcGliSWNjZlFyYmpkN0ZYNVBF?=
 =?utf-8?B?YzUxUFI4QnhSZU1YdFFaYmg0a01EdXppUTlxenV2QUpQMXdFRUtNQ2xiZnZG?=
 =?utf-8?B?WUdnZEx6UDBIRE40d2laVTZad2xjeHZ4Ukc0MjZiQjh2SVROcWR2NFplNk1s?=
 =?utf-8?B?bGdOYWpuT05TVGJhYTJEb0ltTU44Q2JoaWEvZmQ4b2dablZvU256d3dCWlpX?=
 =?utf-8?B?dEtFZEVyTWx5Y24rOFpsVUk4c3pHV05lSW1Eam1EOU5FTjJMVDcwWDB3WjV6?=
 =?utf-8?B?QTh2NVlERG94b1hnYytFbkV5STUyOTZ1eEVIYzhBcEJTa3FnSjlySTh1TENP?=
 =?utf-8?B?Z0JXQy85L0k2RHkxKzBsalZhc1VwWkR5VWo3OC83Wjd4eFB6ZjJhMklib2Jl?=
 =?utf-8?B?NDZ1Wm9aVGZVT0xRL3ZoNHptNjZYN1AxS3RxSnBJQ1FveDBacGE3L3BIZVdC?=
 =?utf-8?B?OWg4ZkdBS0dxK0oyNG82aTB0VjFFbGdHUW43U0R6TFpYb1V3bCtveW5mOUxL?=
 =?utf-8?B?UDdjU2cxeCt2TmdYY1lpNVQrcDZvUE9ibEVFWEVCay9pUVowWThqc2FWS3d6?=
 =?utf-8?B?TWtFdjRHODVySVVpcDZzU3BNOVNYTmQvSjhTZFg4R3JkbkVRZDBCSTM5VDFC?=
 =?utf-8?B?OUFwL1Z4cWN0NDV0UGVGQXI3UVZHUW9ReWpKK09hbVhTVzF4ZmNadCtHQzhw?=
 =?utf-8?B?bGlvdlZQdE9PZEhsVnlhVDN0ejhnWU1QbTZuT3RaRUMxVlMzOE92RU5sbHV4?=
 =?utf-8?B?WmVld0ZQL1JodXhRTlhyU0Z1QnhnSEltVjgwUTZ3ZEJsc3ZraDNERlpDSzFo?=
 =?utf-8?B?b2RHYWVxNHJBL3JvdENybDlCU3dCMDNXVzlqWUROMlBQa1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4721.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZVZOK1RoYys3ZGlJWm85c0ZYeEFBSjFhRGJRRGJha0tvd0ZPUU9McHV4cWla?=
 =?utf-8?B?ak5kZ2lYRmhBYTVMeDNocGJETm1peGtjeGhxeVd2ZmZHR0ZINWpVL2J0VCsz?=
 =?utf-8?B?VFNZb09qSVA3aERPV0djeDkvTVVRRUhIcFUxa3lJUkNTMnNvZ2ovb2hLWGY1?=
 =?utf-8?B?bkdyTk5nVTlKVFRYNEdDYmxLYnI4Z1pZbENqUTdIV2I2RzI4YlFWeEdEMGxv?=
 =?utf-8?B?a3FpWkdrazFTRFNxbUNOQTJYYVpYekNuMmVpSUthbUV3cE9rNFlnUjFJdC9D?=
 =?utf-8?B?TVFWSzBjaEJpd3dlQWdxTTZSd3VMK2xwU1RnSDFaSnl1T1lEU0k5MGpXWXMv?=
 =?utf-8?B?SU13Q29XQzg5d2o5bm5xQlRHYmw5M0FpalROL1I4UDZQUGpCaHBGYzF6NEp6?=
 =?utf-8?B?YVJselBYR0o3aUFYa1FQUEtxa3JpYkRxRW5YWHNtQ3h6NkYrNGFYalgyZjFs?=
 =?utf-8?B?bW9Lbk1YMDFHYklkVHo2cW56VklHUnlUTi9zUjF3WnVRWjhYbXFFUDRZS3hr?=
 =?utf-8?B?WXd5cmthN0l5RFlVa1dZVUdsa0dvZzY1aC9tRXJEL2ZYbmhpMlE5U2NFdWRO?=
 =?utf-8?B?eWZhRVUwejk3M0s0amNCc1duWjhiV1Y3dnNxU240UDlUam53WkRqSmNtSTRT?=
 =?utf-8?B?YVhKbXMrc3k1dXRUN0J2ODRWSXlHcVVkb0VZQUNRZmJETDhPTncxWTBlQTBZ?=
 =?utf-8?B?NnVxdjlMRTlJbEJ6ZEgxeXhJbXRVVllBdmJncWFPa053VUFPeWs1bGlPRzFN?=
 =?utf-8?B?Zld1Y0ZTODd0dDhqSXJ5VDliOEZZRkt2UTdLL3VHUnNaMmhlU3ZpU0c4dW5K?=
 =?utf-8?B?aGJNVXFJQkozcjQ3REZxYVhPTXNvYzFWbFVCd3UwVnZ3NzFPeHE3V0ZpQzM4?=
 =?utf-8?B?NjROU2tidEVsUU9iMW9ONkhBV1dsek56NGtkRWU2Vm1VYlllWi9PTTNnTHAv?=
 =?utf-8?B?ejdTeDZub2hHYk9MYWpHM0pIWG8vd2w5ZEdKM3ZYZ3pYdThXWldyc3RJVTFP?=
 =?utf-8?B?YzVudmxlOU9ZTGp6WEYvTTV6WTNtSDk5TTNLOWFTdmtpRlJtbHVKUVl0Y2hF?=
 =?utf-8?B?UDVSb2JiU3VMMFhzNEx1MEdZZ3FHNW5Da1BULzk3TVNrVFlsVFNLZklObEF2?=
 =?utf-8?B?S1BMbjZ2cExTU2s0NSszcWVvbXU0Vms4VThIZmplQktuTkM4QlQza0pDWVpW?=
 =?utf-8?B?bi9JbVFQY0l2aVBCVDlna1h5eTZpVlM5MjdVV3lYcC85R0wyTkF0Wmpwdm1F?=
 =?utf-8?B?RzNUb2pHWmhwb3hEWkFQYmhXRVl3Qmp2a3FFUHBiNkpsdmIwdnl1RUtBdit0?=
 =?utf-8?B?VXc5V2xOcVVxOEd5R0htZ3RkUUpZa3VXaXBWNTZwMEtDMFRveW84VndJTThG?=
 =?utf-8?B?eisxY01UVEZrS0d4VXFDTWgrNDZkZjFsaitnQlk0bXBxTjhhL0xUN2x2cy8w?=
 =?utf-8?B?R0UxaHdlVjRQcWpGUVVidFh4WnN5RlF5b3ZLSkoyR1hSZktwZlY1UTIvRGRy?=
 =?utf-8?B?aUszUXhteVdJZlVWNEJxeG5ETS9oMDk5UnpSUUNLSkd0TFZxS1Vpa2dtSTlD?=
 =?utf-8?B?RHg0RHFXL1NWNk5MbWx0WEVPMTAzNGJKSGw5WW96N1dBSFFPWjAwL1drN3d1?=
 =?utf-8?B?NWdja2lDV0dHM1FSV2Z5MHk3akZQNXIwUWoyNzJtTkE5R1VXTWZVZTlGc1l5?=
 =?utf-8?B?b212TG1FQmUvT053Y3NtbWJqRjhOc0dpMTA4ZGZDbjdZZlpUUWRFci9wdTdj?=
 =?utf-8?B?aVRoNVNnUnhsb3JOdWx5TlZJWHNVbFRFSUVoZVBoWjRjcDhJOEJtVFlvSllI?=
 =?utf-8?B?NFVvL3dxN2RPL0dkemFlNE9oR0xZQ21lN3FmanE4VXpSclM0VU1lRFNoL0M1?=
 =?utf-8?B?Q1dCa3Zld09pT0I3cEQ1NU42NFBzSjc2dWdCblB6Z294Wmg5Z01zNDRtUmRo?=
 =?utf-8?B?bHN4VjlDQkZjaGRUejZxKzVLTzRrZWNwTC9BaERpY3VYd2JxNGdrdnVDTnRi?=
 =?utf-8?B?VHZBalBYSEFEQjhZbFJ4OHFFYndiWmVYOVhiR1B4TGFhSzBQT2t4U2prZjlB?=
 =?utf-8?B?UGpVbVg2NTlRSnlhZXVkMDlkbjFNMWVhTUs3bVMrbEdnQlJaUUNHaXloUDZK?=
 =?utf-8?Q?nXisaK7Qs2HjP18g5jjXCCDLc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4721.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9efa03-2306-4f21-d83f-08dd1dfef27b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2024 18:24:58.3163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CxMHbbWdFAcZaGrbvZSZ+vYd0RrtIYcLEtyv01HmjZjoaSnjLPNSqpN5YIjbRcVFCukRht/qWyiAKcfnQOHUpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR18MB5338
X-Proofpoint-GUID: HZiDsdGscGtS_KUJOtHE9m94m7FBPduD
X-Proofpoint-ORIG-GUID: HZiDsdGscGtS_KUJOtHE9m94m7FBPduD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

SGkgTGFyeXNhLA0KDQo+IE9uIFN1biwgRGVjIDE1LCAyMDI0IGF0IDExOjU4OjM5UE0gLTA4MDAs
IFNoaW5hcyBSYXNoZWVkIHdyb3RlOg0KPiA+IG5kb19nZXRfc3RhdHM2NCgpIGNhbiByYWNlIHdp
dGggbmRvX3N0b3AoKSwgd2hpY2ggZnJlZXMgaW5wdXQgYW5kDQo+ID4gb3V0cHV0IHF1ZXVlIHJl
c291cmNlcy4gQ2FsbCBzeW5jaHJvbml6ZV9uZXQoKSB0byBhdm9pZCBzdWNoIHJhY2VzLg0KPiA+
DQo+ID4gRml4ZXM6IDZhNjEwYTQ2YmFkMSAoIm9jdGVvbl9lcDogYWRkIHN1cHBvcnQgZm9yIG5k
byBvcHMiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoaW5hcyBSYXNoZWVkIDxzcmFzaGVlZEBtYXJ2
ZWxsLmNvbT4NCj4gPiAtLS0NCj4gPiBWMjoNCj4gPiAgIC0gQ2hhbmdlZCBzeW5jIG1lY2hhbmlz
bSB0byBmaXggcmFjZSBjb25kaXRpb25zIGZyb20gdXNpbmcgYW4gYXRvbWljDQo+ID4gICAgIHNl
dF9iaXQgb3BzIHRvIGEgbXVjaCBzaW1wbGVyIHN5bmNocm9uaXplX25ldCgpDQo+ID4NCj4gPiBW
MTogaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLQ0KPiAz
QV9fbG9yZS5rZXJuZWwub3JnX2FsbF8yMDI0MTIwMzA3MjEzMC4yMzE2OTEzLTJEMi0yRHNyYXNo
ZWVkLQ0KPiA0MG1hcnZlbGwuY29tXyZkPUR3SUJBZyZjPW5LaldlYzJiNlIwbU95UGF6N3h0ZlEm
cj0xT3hMRDR5LQ0KPiBveHJsZ1ExcmpYZ1d0bUx6MXBuYURqRDk2c0RxLQ0KPiBjS1V3SzQmbT1T
ZmRIeHNsYW5sUG1oVnNENG0zcVN1VUkyZW91dDBUcWk5by0NCj4gRG5QYmZqVnp2NU50ZTExSG5P
dzItYUllRU4zaSZzPTBpdjN2d2k1Vy0NCj4gbGU4ZHhJNkV0YXpVN3E0UmxudkVsY1ZrNU1zeU1t
XzBrJmU9DQo+ID4NCj4gPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb25fZXAv
b2N0ZXBfbWFpbi5jIHwgMSArDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9u
X2VwL29jdGVwX21haW4uYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9u
X2VwL29jdGVwX21haW4uYw0KPiA+IGluZGV4IDU0OTQzNmVmYzIwNC4uOTQxYmJhYWE2N2I1IDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9uX2VwL29j
dGVwX21haW4uYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9u
X2VwL29jdGVwX21haW4uYw0KPiA+IEBAIC03NTcsNiArNzU3LDcgQEAgc3RhdGljIGludCBvY3Rl
cF9zdG9wKHN0cnVjdCBuZXRfZGV2aWNlICpuZXRkZXYpDQo+ID4gIHsNCj4gPiAgCXN0cnVjdCBv
Y3RlcF9kZXZpY2UgKm9jdCA9IG5ldGRldl9wcml2KG5ldGRldik7DQo+ID4NCj4gPiArCXN5bmNo
cm9uaXplX25ldCgpOw0KPiANCj4gWW91IHNob3VsZCBoYXZlIGVsYWJvcmF0ZWQgb24gdGhlIGZh
Y3QgdGhhdCB0aGlzIHN5bmNocm9uaXplX25ldCgpIGlzIGZvcg0KPiBfX0xJTktfU1RBVEVfU1RB
UlQgZmxhZyBpbiB0aGUgY29tbWl0IG1lc3NhZ2UsIHRoaXMgaXMgbm90IG9idmlvdXMuIEFsc28s
IGlzDQo+IG9jdGVwX2dldF9zdGF0czY0KCkgY2FsbGVkIGZyb20gUkNVLXNhZmUgY29udGV4dD8N
Cg0KVGhlIG9jdGVwX2dldF9zdGF0czY0KCkgaXMgYW4gaW5zdGFuY2Ugb2YgdGhlIG5kb19nZXRf
c3RhdHM2NCgpIG5ldGRldiBvcC4gQXMgSSB1bmRlcnN0YW5kLCB0aGUgbmV0ZGV2IG9wIGlzIHN1
cHBvc2VkIHRvIGJlDQpjYWxsZWQgZnJvbSBSQ1Utc2FmZSBjb250ZXh0cy4gUGxlYXNlIGRvIGNv
cnJlY3QgbWUgaWYgSSdtIHdyb25nLg0K

