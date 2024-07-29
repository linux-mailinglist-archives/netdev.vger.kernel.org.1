Return-Path: <netdev+bounces-113498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F34493ED19
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 08:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0ABA281F06
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 06:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEE582899;
	Mon, 29 Jul 2024 06:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RNcKprth";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AVMsV0RA"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80F37E1;
	Mon, 29 Jul 2024 06:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722233143; cv=fail; b=i8rr6tPxstVLrbzu7VCso6hL9/uRzNXxhOQnAaHO80iEue1uasLhIZVfLoWcsybvlqYpX/PvTX30xtIU60yqR1rRBtWwoN97OQn0ZMen6awXkLJs0RjTyqKIeodxUvR3aFlRp2MC1uZIFEfwBu4ymg29tvvk6vLSHByy7hDKmjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722233143; c=relaxed/simple;
	bh=rNvzgno5WjOthCrX9R6nDTs+uxmN53jnedx8oyGeVQk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C2bGizdjFr5sm9MUbUxC5AcHA3ZGUOtgxNHgOJAIPblPLPgeNr2gxA1cq+FCNGBPhlvBCgll3RzSBtvTSWH90AVO157sci48vC9GCqLzNiR/tPF0ZqdmIQ6UN8/lCAbzHz5FrU8vgmHVjS1OEppuw0PRzbzcZC7+e0suhh/Io1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RNcKprth; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=AVMsV0RA; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722233141; x=1753769141;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rNvzgno5WjOthCrX9R6nDTs+uxmN53jnedx8oyGeVQk=;
  b=RNcKprthT+geB5OItcR9mrjb7VttRInRfbF6rMXzstISygjnUiStCypV
   c6trOIXd6V5ZrCTiTKZZ0OaRlLxnOgq7aXi30qhxmyxx0dJjtCNpwPuPr
   CwH+fs7zijA0O3Pjb4DxtYjkmTzNkn+j1sd9s98umH7xSbcglU/6lU6fn
   U0lNJqwu68uP3LmURSKg8/79mTblHad3M97ofp2r6YZhDoH/2czdBIyMW
   F9DMOCHQMZj2vOa9lmN6BmBEFHrH7o2e38HoIBKRPXh5Wtcph7AzJiEeU
   IL7OGe+vuCMVBa2vq2wdgwbzx1sQd9aGkI0qP06C79JrOup91d/pC3s6X
   g==;
X-CSE-ConnectionGUID: gmQLu6lsQPe+UW4fQuXozA==
X-CSE-MsgGUID: NX4SpQlqQfCXaXO5VpLDtg==
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="29794923"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jul 2024 23:05:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 28 Jul 2024 23:05:26 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 28 Jul 2024 23:05:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQAdEQOXQF3AhxQMaJUspJeCwZNDVvmZ39U+cCBUs7f3AgxTgX1szUQxtSoM37aubacZNLqCsQj+m57MvqngWDxDiELEinXmctDK+dGXn3DhSrMjzbYTfxYF7KVP3tOml6OwV1YVaBHJcnMfzUcGwgARp0nzRAXSiIMfstwu+9c+9c6VA3KsfZSgBpXRpV5Pgi7aJzenicMrSERO7iTUDb4BHUkNvmtKyNCwqbC8APuQgAAesx0UPX4HN4Q1umEtIO5uwC6mJtcd6gKQ9WtTiLzvOMc2ih9CoKJOFDbOMJVeNWZr07QGi5rokeCIHvcHNqKR2J+Z3TwMxdfenSnoJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNvzgno5WjOthCrX9R6nDTs+uxmN53jnedx8oyGeVQk=;
 b=h5guKo76PUrwz7XAArtZVRqTKi0ShMio+KRMMEcwMFmhmIEO4iaYOIt8Gz73RAY7qboRqqILOIQA0vV8HmFJsriq0L4jYV/zMZVvRoQr+ySwOEO10oNm27ZcgAObAhFa4fB0y5EzDlKa7z+khXygBnhkoUbYNf8Lqihv1FNWjR350xalAjBl9K1vm3avDDjdOf9St+d4G1gJV1qY6PnJ6oArD76PuPXiatiqcTDzoCBuwjcK28nCokg7CxdLstCtKJWFY97ggptap/BwalTQIeO09Meowjp5AdBSGMLsB8heYknl8Vg45ZvcWOxmsMCNO8pH/BdLcgbp6tx2v1wWiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNvzgno5WjOthCrX9R6nDTs+uxmN53jnedx8oyGeVQk=;
 b=AVMsV0RAXuqwwdUvT2irxJf7pW/TQxkv9WO+ns4iK6B31f358oqY+QaVYxi/OOnNCkCXq1NG4VjYa53TeW9/Fkax0JcjtsGLrphCfCl1JAFnARz7rsEattQxQZMF1BbTMn0diA6QDQusfaioquASPo1QTUuM9hjpPJpzB1TTnGSG4tVf/2O2AJk14YXg3MXk0JYdx9Nn+Q+JfaJjpsov54apsgD5LKK7u8FbTmU+koZyGADg7+0B8vqgHjO0rTY9tFmca1Vxvop2vWNN6nzCEKbTcfeFkHqhgAnqcKd4BFGWeaMhzye2KNVryQi4djDNeFhvAmauIPRBn614M4y5gw==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by CO1PR11MB5170.namprd11.prod.outlook.com (2603:10b6:303:91::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 06:05:21 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%5]) with mapi id 15.20.7784.017; Mon, 29 Jul 2024
 06:05:21 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <horms@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <saeedm@nvidia.com>, <anthony.l.nguyen@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <andrew@lunn.ch>,
	<corbet@lwn.net>, <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <Steen.Hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, <Pier.Beruto@onsemi.com>,
	<Selvamani.Rajagopal@onsemi.com>, <Nicolas.Ferre@microchip.com>,
	<benjamin.bigler@bernformulastudent.ch>, <linux@bigler.io>
Subject: Re: [PATCH net-next v5 00/14] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Thread-Topic: [PATCH net-next v5 00/14] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Thread-Index: AQHa31jFXlKWMWGDGUa0Oj8yXMC/k7IJMfyAgAQKH4A=
Date: Mon, 29 Jul 2024 06:05:21 +0000
Message-ID: <46be13d2-5859-4053-8b70-c3e8785a5e61@microchip.com>
References: <20240726123907.566348-1-Parthiban.Veerasooran@microchip.com>
 <20240726162451.GR97837@kernel.org>
In-Reply-To: <20240726162451.GR97837@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|CO1PR11MB5170:EE_
x-ms-office365-filtering-correlation-id: eeea2ea1-957f-4d79-2c72-08dcaf946dbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?emJyUmNJc1l3a1VWdVVlK2NocG5HZnJDVVBmUXJCWjFyY2prcE14QktIZWU5?=
 =?utf-8?B?VnlvYi9MeTVRRnlBZlNzY3RtNHBCNDN4VTZwcVNYQmF6VDZ6RU5vNDZDTmJJ?=
 =?utf-8?B?ekd4VXEwd0Z4YnN6aGRBQ0NjVDdpSEdqdzFtNXhnR2huQ0l6RU9aUEYwbkk3?=
 =?utf-8?B?TmRwZ1NkeHM3UmNHYzZHYVNwaXp2UE1zaGRwbnU3d0RVVWx3MW5zM2JRalNn?=
 =?utf-8?B?Y3pPaFhISjNEajdlTXJvK2pQbTdCUXZYajA4eWUxcFJyNkFIekl5ak15M0pP?=
 =?utf-8?B?bG50YjQxeThlNU1YOFNoelFlcHh3bmk1ZkI4aGtRUGl1U09RNGhvNmlza1FS?=
 =?utf-8?B?bzFtWnpPNGdWd0Y4R3RMVlF5N2hEYzIvUzVnV08rbWFkMW1QT0JXdlVCUjFn?=
 =?utf-8?B?NWlkb0M3MUpsZ004cFhUVk4zNkFrOHloVnRSc2p4YTdVSUE1YXdsejlvWE5m?=
 =?utf-8?B?UEVlcncrNFBmY0h1UHJ5QzV2WmRuWXZPRU9hRCsxdDNuQndlWFVkSXE2L3dl?=
 =?utf-8?B?eTYweTZ3ME5pU3Aybm1qaFB2YUJjcWkwWWRzWUVrYm90ZGZKbUxDaitkb2dO?=
 =?utf-8?B?WUhVRUpvL1YxOFhROUxBTERnQ2JML21tNDg3VllYYkYxMWQ5aS85QWJnYTJh?=
 =?utf-8?B?TzZqR3FOelpseUxXZ0JOQU9sN1k4bzhReXpBU2tvTFZUTG9Fb3Y5dWRaYXVo?=
 =?utf-8?B?d2dZZmM2M2szVDRYaEtDdUJKcWVzSk9BYU9ySnR0RHB3ZTJuQlJidWRuc0xW?=
 =?utf-8?B?amhaSUg0eGdLWUNOZUR0OGxZNjQ3TVFBY21lbUVlZ3YrVzJyNDhnQ0xzSzl4?=
 =?utf-8?B?MnAyVTN5WTBZa3dnQ1JJZFIvdE5IdDBjc3NiVlllNDdRZkp6eW9IdGtHelpa?=
 =?utf-8?B?SHZ6aDg2ZDBnTnZVS0dLSGQyc2FLYXBLclQ1WXBObkNPRU90WmhBTmU5R0gw?=
 =?utf-8?B?YkdLbGVFVXAzVGpCL0llNnpmTkdtSFZ3ZjNHTXdORmlwWjhIWlBGMkl6YTFo?=
 =?utf-8?B?WW1VNnFacktTaSs1a0MyLzBCSTYvdEdYaTZEbWN1cFJnek4yTFpBYm5GZE5T?=
 =?utf-8?B?dCtTWHA0S2lzWTlLM1RncS9mYi9SU0UxTFhqazBzTFFQQ1NEaDNnV1piRWpr?=
 =?utf-8?B?QTgrWkhEdEdlVHFwVlFkN0JyNXhVd0VXYVk3cDdydVhpdk5VdzNJRjVaUTFM?=
 =?utf-8?B?VUZkb2x6VVBwMGUwRXZQRW83cWxqeWZrbTVWUGVkOG02SzZGV1lHeVhONlIr?=
 =?utf-8?B?bXJzVjBhMC96NDNwNVhZb2xkNGcyQmQyTGkrOFAwTlNqZTUyQmdCVWZQTm5r?=
 =?utf-8?B?d2t6b3RqdTNDbDZSUVNIclJ5Y083aGNIRFZWa2lDWEhUbmJHdTJpc0oyajZh?=
 =?utf-8?B?NTU1Z1BNZGFWRkFRTEhiSFRUdW9YbXVNcE1VSjdTZDhhd2xIQ0JDOTM3eUFQ?=
 =?utf-8?B?ZndhOWJXc0I3MkRZeHRUMk5LRnVTSFpEeHlWUTFHdmR6OHhJUFdURWk2aFhx?=
 =?utf-8?B?MjlhZThuQTNjZnRLdzlwRjd6ZmxkaFVybWk5YUpMVE5ZTWJ6a1dPdjBtTHdp?=
 =?utf-8?B?Z0VWbkJ6QlZ5NnVLbDQzY0J5ajhNQnBPejVyTXFlcHI3T2JzbW9SNm9RUmNn?=
 =?utf-8?B?WXc1dHQzMms4QTlRaTc0YlZ3UXJocmJLVVdxb2hhYWQrRjlGYy80Nko4eVFG?=
 =?utf-8?B?cnVhZjdXQWg2Rk8xWUlvSldqTUFodEhSYmNkMDZLbHNXdEx0TXFaVlYrSnpX?=
 =?utf-8?B?RGpDbitKL3VOa3g3UzJRODlmemR6NjJiN2VpUzY0YzF2S2pBUUFPY2xWcmx4?=
 =?utf-8?Q?JyCnoWditIT2LUssnV0u/Sse3TEVR3SOS0C0Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGtaTWZJVTFyY3NVTm1xalpkUCtjaFB0U2lPazJlaUN5R1FONmcyS20vbi9H?=
 =?utf-8?B?dExhbmhXV0dOWjhURktUa2pPdTZYdnpXY3NVMHNlNVZhNEg1cVlIVWRiRkRB?=
 =?utf-8?B?TWxiNkhvZXUySVRNRXJXZzIwWXBrUm11TkFrZ0dFSFE0bnV2eW1yQ3R6Um5C?=
 =?utf-8?B?Mk95NGtFc0FPM2NjRVlhRlRvNzFxU2I0VFgrMzdSNGFZdDU0azRETy9YTUdV?=
 =?utf-8?B?Y0tTZ29HQUNBeXZBUnM4bTlaQWQxS042cFE3dUQ5Y0ZiT2pZWU04ZU9mYUg0?=
 =?utf-8?B?VU5BOTh1NVZ4L1YzK0FYZXpBbnV6dVdPRzVnVk5HMUhNZEY2RVZnQ1VQVTNw?=
 =?utf-8?B?aGJjSkphNHlFd0hWZG9jeFJiN0V4Mm8vVGgvWlhDaGVYZlloYmoyUWdCWDlt?=
 =?utf-8?B?SXpYOXFoeUFCU0tsbi9EQkh1WGtQZ3kvWENUWGpSQ3hYOUR6ZjRNNVJsdDVh?=
 =?utf-8?B?WmQ5NmE5UmRVY05QT25sSWVxTkNPK3F1OU1MK0xlYWF3aEhHbWZuQUZud1Bl?=
 =?utf-8?B?TFpVSGY5eHM1SkxNRzRqQ05SU0JobUppT3o2azVJSG5uS0FqSzNUT1A3eisw?=
 =?utf-8?B?b3JOZEEzSmIzbGF1N2RkNWJFcitIaWI0U1lrc3BoSmFReFprMTBvK3VhbGhw?=
 =?utf-8?B?d0ZGUTFENXJTZnNZWmJkKzVMSHdjSGhOVjB0MksrQ1ErY25CcVlzeW1hakZp?=
 =?utf-8?B?dGRaWUdETGhhbVNKQUFVSkV2U2NWQzc0eUNjSTg2SmE5bXR3Sjl6QWEzbkF0?=
 =?utf-8?B?YTlWWkk2T0FvVS80MWhaamxZckwyT3lpS3Q4SW5vaDh5ZzZHMnAxRHdRM0Ju?=
 =?utf-8?B?NVMvSytTV0gwbHVaL2twWnl1d29TUnZKZzdMV1cyNlQ2Tm5EeGRTckVzZ21K?=
 =?utf-8?B?ZTQwUmFiUkJjN2VYbHJtYmhSRVUyblVkUWFJOEI1KzIyL3FURm5rY0xCSGgv?=
 =?utf-8?B?L0YvZHhGR1ROVTZQV3F5RzdoYkRLSVpySkJXMm5USFgwWGRMVkVyUHprc05p?=
 =?utf-8?B?OE95Zm5sTTlKMkQ3UVFOc2Q1NDh0REVyK3NBL2c2ODlqaS9hY3EwYlZyQ0hP?=
 =?utf-8?B?Y3dEeHhnTlc5anRZNDROTUVEV3BXU0FSQk5RQTRvME1CNmFZMGhBQjh5Zis0?=
 =?utf-8?B?a2U5NzhBS3A1cXRTc3Y5Ky91eHV4WXY3azkzVnk2MVJ4R21WN2ZaTVNKMDFC?=
 =?utf-8?B?MHcrcGdVd01ESlVGaThkTExXMnE1STltQlJzS2RCUjdlS3lMT2RvL3ZMSVFa?=
 =?utf-8?B?c3IrRTBpeHhQdzVMS1VpbXA3ejFhS21rejh6Z0hBNE1JY0h1OGhGejdXbDJC?=
 =?utf-8?B?THhUMUV1c25pcE93b3lucVIzajgzV000SmpNZVo4ckRkMUZGVDFvR0dsbG9B?=
 =?utf-8?B?ekZpSjdoTjgzaDFFZUMzMUgxSjl5d0s4K3lwSUJsWlRGbWNmTjB1S2d0SWNw?=
 =?utf-8?B?MHcwMlIvNlNZVk15bHRmd1o2d3BVV3dkVUxRRkt6a0ViYkRtMW9JQm9oWTha?=
 =?utf-8?B?VloxczdIbW9abVYwQkFyczNvMGRXTDBVeW1MdGFHSG9IZHB4bmp0aVQ0VEhx?=
 =?utf-8?B?Vk9sYWNkYmlESkVybDg2ZVQwcnd4MDZJTkExSjJVSDdRZHBhU1YvL012bWFk?=
 =?utf-8?B?Y256US83dzhuZDVCN3c2bDNhNVpta2liSUUvVFdJZDlURWhLd29XT3RpUnJZ?=
 =?utf-8?B?Qm9uU0R6R1R2RWJ5SzVuV0liWGxCbGt2UTdGVExVNG5xUDN6MTVibzZycUtU?=
 =?utf-8?B?UVM4YWV1OGJFa1d5YTd1SU9ONVV0YjBmVExrbTRCUTd5OVljSnpFa093dFNx?=
 =?utf-8?B?SWc2L0ZSZFI3dExLVWxUcEhBQVB4bnFrdkdybzR3WjVNR2MrcDNWbVVSUlp5?=
 =?utf-8?B?SzhMeks0QWgvblZsK2hWcU9VdnVqWVNnTWZtY2wvTkw0UFNrWDNaYWdxQ015?=
 =?utf-8?B?RXBKNC9WallBb1VkMDQwNWZQMW5NRnJidFFEbGhRaDRyeldINStaUWdxbStl?=
 =?utf-8?B?WTZFTzdPK3BhNVRMSGQvL1RwQ2lHWU9RTG5BSTRkSHlFSE5tTE9XcWhwTXdI?=
 =?utf-8?B?RHdDamxVTi9JT01CYTR3VjRhMkRJQWRSVlB0ZTNicENtckExdm8xdTBHQXdr?=
 =?utf-8?B?K09lU1pxaUZIb2w4amUxZHJ2RmRCUU9seHVteWVNbVBRZ1BpQTlDOEZURWlx?=
 =?utf-8?B?VGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F253FFBF17069F438610B54862D203BC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeea2ea1-957f-4d79-2c72-08dcaf946dbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2024 06:05:21.0931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6RTiofMxQaa/Xbd4OaDW3kWT9wgxIs/g+Gi1wO81cnbjgIyoKZoohQr18V3jPDWmpLwjF3m+6COopK+AeulUJjOi2wFK4x/wPTVwe+DcQYVnfigXkykOEtrm9PgoIKB3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5170

SGkgU2ltb24sDQoNCk9uIDI2LzA3LzI0IDk6NTQgcG0sIFNpbW9uIEhvcm1hbiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBGcmksIEp1bCAyNiwg
MjAyNCBhdCAwNjowODo1M1BNICswNTMwLCBQYXJ0aGliYW4gVmVlcmFzb29yYW4gd3JvdGU6DQo+
PiBUaGlzIHBhdGNoIHNlcmllcyBjb250YWluIHRoZSBiZWxvdyB1cGRhdGVzLA0KPj4gLSBBZGRz
IHN1cHBvcnQgZm9yIE9QRU4gQWxsaWFuY2UgMTBCQVNFLVQxeCBNQUNQSFkgU2VyaWFsIEludGVy
ZmFjZSBpbiB0aGUNCj4+ICAgIG5ldC9ldGhlcm5ldC9vYV90YzYuYy4NCj4+ICAgIExpbmsgdG8g
dGhlIHNwZWM6DQo+PiAgICAtLS0tLS0tLS0tLS0tLS0tLQ0KPj4gICAgaHR0cHM6Ly9vcGVuc2ln
Lm9yZy9kb3dubG9hZC9kb2N1bWVudC9PUEVOX0FsbGlhbmNlXzEwQkFTRVQxeF9NQUMtUEhZX1Nl
cmlhbF9JbnRlcmZhY2VfVjEuMS5wZGYNCj4+DQo+PiAtIEFkZHMgZHJpdmVyIHN1cHBvcnQgZm9y
IE1pY3JvY2hpcCBMQU44NjUwLzEgUmV2LkIxIDEwQkFTRS1UMVMgTUFDUEhZDQo+PiAgICBFdGhl
cm5ldCBkcml2ZXIgaW4gdGhlIG5ldC9ldGhlcm5ldC9taWNyb2NoaXAvbGFuODY1eC9sYW44NjV4
LmMuDQo+PiAgICBMaW5rIHRvIHRoZSBwcm9kdWN0Og0KPj4gICAgLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCj4+ICAgIGh0dHBzOi8vd3d3Lm1pY3JvY2hpcC5jb20vZW4tdXMvcHJvZHVjdC9sYW44NjUw
DQo+IA0KPiAuLi4NCj4gDQo+IFRoaXMgaXMgbm90IGEgcmV2aWV3IG9mIHRoaXMgcGF0Y2hzZXQs
IGJ1dCB0byBzZXQgZXhwZWN0YXRpb25zOg0KPiANCj4gIyMgRm9ybSBsZXR0ZXIgLSBuZXQtbmV4
dC1jbG9zZWQNCj4gDQo+IChBZGFwdGVkIGZyb20gdGV4dCBieSBKYWt1YikNCj4gDQo+IFRoZSBt
ZXJnZSB3aW5kb3cgZm9yIHY2LjExIGhhcyBiZWd1biBhbmQgdGhlcmVmb3JlIG5ldC1uZXh0IGlz
IGNsb3NlZA0KPiBmb3IgbmV3IGRyaXZlcnMsIGZlYXR1cmVzLCBjb2RlIHJlZmFjdG9yaW5nIGFu
ZCBvcHRpbWl6YXRpb25zLg0KPiBXZSBhcmUgY3VycmVudGx5IGFjY2VwdGluZyBidWcgZml4ZXMg
b25seS4NCj4gDQo+IFBsZWFzZSByZXBvc3Qgd2hlbiBuZXQtbmV4dCByZW9wZW5zIGFmdGVyIDE1
dGggSnVseS4NClNvcnJ5LCBzb21laG93IEkgZm9yZ290IHRvIGNoZWNrIGl0IGJlZm9yZSBwb3N0
aW5nLiBUaGFua3MgZm9yIGxldHRpbmcgDQptZSBrbm93LiBTdXJlIEkgd2lsbCByZXBvc3QgdGhl
IHBhdGNoIHNlcmllcyBvbmNlIHRoZSBuZXQtbmV4dCB3aW5kb3cgDQpyZW9wZW5zIGFnYWluLg0K
DQpCZXN0IHJlZ2FyZHMsDQpQYXJ0aGliYW4gVg0KPiANCj4gUkZDIHBhdGNoZXMgc2VudCBmb3Ig
cmV2aWV3IG9ubHkgYXJlIHdlbGNvbWUgYXQgYW55IHRpbWUuDQo+IA0KPiBTZWU6IGh0dHBzOi8v
d3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwvbmV4dC9wcm9jZXNzL21haW50YWluZXItbmV0ZGV2Lmh0
bWwjZGV2ZWxvcG1lbnQtY3ljbGUNCj4gLS0NCj4gcHctYm90OiBkZWZlcg0KPiANCg0K

