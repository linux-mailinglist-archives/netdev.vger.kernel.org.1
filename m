Return-Path: <netdev+bounces-295644-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MgyPNINqImqYWwEAu9opvQ
	(envelope-from <netdev+bounces-295644-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 08:19:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B77645756
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 08:19:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=XCbWxUGd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295644-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295644-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0090A3067091
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 06:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D2C3FE660;
	Fri,  5 Jun 2026 06:14:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28D3218ADD
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 06:14:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780640090; cv=fail; b=ru6GUK5JqbEpNiVmIN5t1Aau4tsBViNrkdms/mAn2KoL2dywS+8EFUrvVPGDtzv3TDzA2dMA/iw2W17RIXxXWFhtyh8VIyPUEBW8ZTSpffw0h2xlJAEe3S/nyicut2J0ITkAnlJiqGmosggEnnrPaQO8U+BZcmcMW+Yb1vLRndI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780640090; c=relaxed/simple;
	bh=M9DxJFCG3YQiCp7VpLgmVR0hkSziZ9NG0u1Po8nHzFA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tk3iOY867/WH+CH8ciB29OLLcKMWopEN4xise46Zf9S9xCEmiokgLDmtnyGPu96b+f8nyt2QHY+ndOwUZZ7QOJBm/YLb4qdklR1r8Z2dbEJXvpOP3wcxlNWsRi3l+YKMzle36LZhcKd8XO8+/06a/23bw13LaJZmfuB8FV+RcPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XCbWxUGd; arc=fail smtp.client-ip=198.175.65.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780640088; x=1812176088;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M9DxJFCG3YQiCp7VpLgmVR0hkSziZ9NG0u1Po8nHzFA=;
  b=XCbWxUGdm9gXtLFvITVZNtqQuURFXmMwByj8+Du4WIWcLRZiNB4R2lhz
   U7ywPmCpUFzwbiC2Qy1xbgi8IAhF2zqvNrU12WObyaMtBNuZipD2dOsXT
   caBAbbwSMBhunY8Mrxc4dF3r02UtdXgvjHiETawhgNU9EaqexP84N1Gui
   egSRvlbncKi+zwYeZRXa7wtHYYhshHrQuEanuw7C52QsoL6z9TYCXrB5I
   NT3Y3iddmVQWuExUrV+tVA1g422Urkvfl1ff6Y/fN/gY4+kLNp3IJWuA6
   Pd1zOM76LJNEtIUeqY23ztc93eB46pU4yi2qwcrT4bt52fun3qTpgDjCn
   Q==;
X-CSE-ConnectionGUID: R0zuDcEiTf+20/LM0ioFRg==
X-CSE-MsgGUID: AfnybmpUQgalZ6CkJ5uFIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81217375"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="81217375"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 23:14:47 -0700
X-CSE-ConnectionGUID: GYnkMMsJROWTVfvF/7FMcw==
X-CSE-MsgGUID: FNqelaK/SHOrcnLE04jbcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="249092047"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 23:14:47 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 23:14:46 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 4 Jun 2026 23:14:46 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.43) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 23:14:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ErDdlo+9CjIpKshk4RhNkPulSXjCH2UKu+V8DoZpdgg7Ktj8QzWz83e6nm6s1ksrOwpYNj6OA5f8FKMTFDmGGVAyM4aSBYFpMcsGmM4ygmsyYiElG1pXPp5ZwZgxHEJAcmXL/2b2FYGVBhH7jczNI36xpM/tMTTKqw4vk7xgiNlKFyYQicXZukjK7V6ZuFRrKGu/y8yYHPLrNmV9n4Dgza9mpv/AQsSyenJ0fCqI9BlMhU7a8oYo/Cm1eptTX8ogC/k4Ps5mtk1f1ZwI6asTzxXZtNDs+BjhwH5N3+iy2r94mj3CQJKg6cp2INO/1dZ925Gv2eoCsO3/YaHv3g79Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1pbqerBAXEpzDt97VraY8M6hOtIaLRWso6wQYQ4BQo=;
 b=rHyi+WOcQM2dC/bA+oJqlxlM+/FQXxoLXyVHHCl3HZO7jG7LsMG0G2yFk7BxIRLtbo3TGOijwAY673kaCk8C8EeQiWwhe5b5O3wiK0zMnakOXvOMVTreLY2vAsUsh0jZ0N8VmEPpN80oEQeayMJC+jY4OADMZcjREtD5ZUhMJbu/1p8CB0ShEU/yJ3idZmdfQWLMYjsThkyv9D8hVtjZSETaysJmkguNLVRLpyO4XHoDr6PZfQfeBHyP5c3BZDf0wmVhhpJ58+jSZVXHzoOWEoIO6UDzo5k/tHExrrMD3B3xU18GHqXpFeZJZZ/plSW3VA4mYak2Mbs7HuVSdF+H7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 IA0PR11MB7743.namprd11.prod.outlook.com (2603:10b6:208:401::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 06:14:42 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 06:14:42 +0000
Message-ID: <85f7a34e-aa97-44f0-af85-c8dedc2ead46@intel.com>
Date: Fri, 5 Jun 2026 11:44:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] drm/xe/drm_ras: Make counter allocation drm
 managed
To: Raag Jadav <raag.jadav@intel.com>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>
CC: <rodrigo.vivi@intel.com>, <dev@lankhorst.se>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <kuba@kernel.org>
References: <20260602044919.702209-1-raag.jadav@intel.com>
 <20260602044919.702209-3-raag.jadav@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <20260602044919.702209-3-raag.jadav@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0120.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a7::11) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|IA0PR11MB7743:EE_
X-MS-Office365-Filtering-Correlation-Id: 49ccd419-423e-43cc-4fd3-08dec2c9bb49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: EE6ivGCUkZSlBCly6ENcFtUnxZccKXvW5qIfy2tvKP5DQ7nseFFeux03aHiJmcYzJsk1fjkUXKp+8giXty3OEeMunvxP73omg3GpeL/oKWijud8oGlamVTJMTm87PXbgjFr9/voeQ/aZLYvYX3rER89VYEPOOTyci322j4PF9vtEyxtoKvzfEfN8SbaFZbNxHKIBl5URCKmPIEVDxQzlhqtswx8H03e/XCBekqy3/0KJKKD9DmlO+HzgnmMz1MX2rxL+rR2rv2LZPYB41EzYkisLvvTurzR8cTmi+mR10WPKbLAl7QP3LYtKKfhsDuv9Bg0xUWo9ECYNwRc3P2Hof7t4NC6du2soBQVKB/FFN0zWhHRKp+Y1I55KHdXedb1v9IIc1I10jRSD8v/uSsJWtEjUhC6ylBoAqJwFLGt6EgSfthZ5LUZHgJYaouEGCPu/E+13N73qgfTOqINlnSJhJL/VMh3DZORLqyyVDm4zF4Wj9Fum6Kfv8Jlo8Ihpn1oZ+qSJpMwpAyejaWxKWDpp8AtBHnsr574n3jZP4QbicmPyq2aFpzWRyta+3qDXvJyY/Rz4fH5JADJJ/7iPZgw76gff4xRiDlZpWitE6LQsQnSuZ68QgwM72Z3LMhA30VmNgZ1XJYGwW24lOzlCPc2QiJ1Km7T5OlStlPK0RpwxlZ7igyfDpT9ZuBGzwtCISKH3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2grQzcyeGNic09YaXU4bCtQdkpOaGdzTVZYSi9ERlVtblAzLzNNT3RXNEVZ?=
 =?utf-8?B?bDRxc293SDJiUnZ4WTgyVlZlUyt2UHdwREFma2ZZUFRCYVhtSnh0VDhWL2Qw?=
 =?utf-8?B?MHhIYjVaMDVwNDA0QkNtZDJSb1Z6VUpqeXZNcGhrYmVGc3BNWkxsdGhjcWE4?=
 =?utf-8?B?d0h6MlZlMmwzMk9HSlUrRWhVUGhkcERzRi9DQzZoK25VU0F1a2JqOSs3T1lZ?=
 =?utf-8?B?QjdhRE9FUW1MRmljelhWZ2VxSHo5SEtpOVFsVXJ4Q0RSRWtqK2IrMFhEZDUr?=
 =?utf-8?B?aWZmcGtjUXh3TWZXam04a09zV093MExTN05BOVc2dENGOFFuUlczdXBhRU53?=
 =?utf-8?B?bFlkZmlBSUwreGFjeElHQlExMUUwdU5Kcmk0eHRsYlpLTVp4NVBMNVpFU1px?=
 =?utf-8?B?RTBQWGNYbUNrZXpwWDFFeUZSblhDRGE0ei9laEhKTkt5VDdvd3NnQi9SWGVm?=
 =?utf-8?B?L2VURS9HWXovL282NE9JRldNRGZ1WC9aMGxENFIwVm4ydndsQUwyNlg4d0VR?=
 =?utf-8?B?bVFKMEpZQWlpQnBRZHdpUml0K2xMekdyaUhBblRHUUx0VjcrZHd4OHpKbURi?=
 =?utf-8?B?TUtSdkdEWEI4OFlyNHRrckpzWVRYREllYXFRdnUzMFVuNnJZdE1oK28vOENG?=
 =?utf-8?B?WDNVVStuVHowV0EzRVB1YnR6Q0ZIQUQ3TGZiTnU2UVN2VHI2eGQwSjNVeCth?=
 =?utf-8?B?MkFlQ3Q0Ym9UOHJMTytYdWEwalJUWEhhKzU5MlVFTkRLRFowTXVJeHZPUis5?=
 =?utf-8?B?aFRtUUh1bDV4eEhITVVMWE1IVEZXQU5HTkwxL25XelNQbTBNWFJMM0ordTFX?=
 =?utf-8?B?U2s3STNtMUF2NlVRZGFzZEkzZ1RvM0cvK1E2Y0N4Mm9JNmNYNjRuYlFJcito?=
 =?utf-8?B?K2hJdGh5MTNHcDRLajFBczlZeUhIWFpNb085R2RuUDJkMGJhdi91ZmJGZjc3?=
 =?utf-8?B?Q3VJTDFseTlHeHF6by9OaURoRCtYVThwTmtBMkIwa25IR0Z1Rk4zdUhkYjF2?=
 =?utf-8?B?aG1MeHVmakQyWDZlTWRQSVdZUU53b0crb09YZ0ljNFYycitseFZpbzVWUEZh?=
 =?utf-8?B?K0w2Q256NGk4RlVlRlRqY0lNUU9xbE1iL1pHdDJ6Yzh6aHBhMCtLNXc4UHI3?=
 =?utf-8?B?VFQ2VSt5NnZkOUJxZ21idS9zNFpaeTM5KzJuQkZCMHZlQUh4MlBFUVB2dlBO?=
 =?utf-8?B?aWt5c1E2NmQzMEl3VXNjL0tON3VaMElwNGV2OVpYREIrT21iVzhRYy83cURW?=
 =?utf-8?B?cEp4ZUNneU40aVlOTXJONHRmTEp2NkZadFUrQXhhSTF5c00wQWw2cUtOdFd6?=
 =?utf-8?B?cGRqaVFta0I5U05GRElxK2tza25neWx4Q1AxWGl3V1hpZjU1bnMzRnhMNHNk?=
 =?utf-8?B?SnNTbGR1WGtNZnVuZUlBOTVBY3Q0dHNHNnh3c0VQWVVkY2VCM1d6Z2hmTWNR?=
 =?utf-8?B?d2tqVGtDb0tIS0NtL1RxdWx0Q1N6K3poeGxXVzNSeWpheFlDUHAwZUwrY1BJ?=
 =?utf-8?B?SndZQkpwS0F5ZGttTUg1Z1cydWFwUW5aYlJrbFBEMGtGWUdycko5ZmNhd0tN?=
 =?utf-8?B?OU9OdURRVWJTRDJGZXZZNlZmdjRTbDJnTTI0d1VUVVZ5TW81dlljbkNFbUxM?=
 =?utf-8?B?UHFyVVphelpjaHFaU080eHhQMHJsSW9Ud1I5M2pVMGJqYkdTd21DNUFkNm0r?=
 =?utf-8?B?cmtVb0dwYk9tMUFQNlQzR1hWb29RL2QyZUEzQlN5dm5IakkwNEgyQ1E2TldU?=
 =?utf-8?B?YXlsN3F2OGRXUU95RU0xZ0h6S3NhK2VEdUgzSE1oSXhIRWl1K2ROSllVNkRn?=
 =?utf-8?B?cWErTks3NU9ZbVV2akpRMnlOb3NsUE84ci82UWc4V2VGZExla013Q3lPNzFw?=
 =?utf-8?B?QVhGNjZ0akdZK25QMFRXOGFHcjJha0lBWE1KZGRMT1FVN3psdi9JbE92dDZ5?=
 =?utf-8?B?bFNJL09udXc4R3VKeXhtVGtZcytKSkdDM1Y4M0NzNEVydzM3NnRhc1ZSN3VO?=
 =?utf-8?B?eWRpaCtjMWxwSTVRV0g4eE9xMUdlUUNkVTIxTThuZFU4dy9vcnBTbkd0b1lO?=
 =?utf-8?B?REhNcFh5amdOTmhuek9ISjVaYW9heWhvaFFoMVBsM2pFTzRQby92Qk5adnZL?=
 =?utf-8?B?eU10b0l1NlZUQmxnV1doOCs4T1hTbXV2bHZvYjltMXhPd3h1Ym82b0gybXd6?=
 =?utf-8?B?bTU2MHRaWXhSMUpWWHJTSWVNelZEbTdaekZkM29YUFo5WnBSMjg5U1FPK0VU?=
 =?utf-8?B?YndpamM5dm9VLzljS2V1ZFpaalU3ZzhGN2ZQUUN0ZHdUN0R5cGJUWkM1RnZJ?=
 =?utf-8?B?aU5EVWdZOHpnMVVsaGZUejZiVXoyY28yR3RzV3VTSk12UjBydEludz09?=
X-Exchange-RoutingPolicyChecked: P3MJ7e5Qqwzbef2yOyocEVLadW4JvtojU3Miqa0kRcVZSEEf7ASkYaBqFplllBNXqc7WxxxvcQ7oC9jA5XAK3TaJ+d0lWSl20L//vSW5JYNCZ2gjhXRciwy/3jRHT+rzZ7rvJJcm16n8Sx9Z3W8VcmAc7RTBIM3qziys0aHvEah3G7n7RRyksQsx/OuMskJkwshj35cSCDhS72NyYx5YxGcVHej9U2qjKqu0d8ZMCsg1UqPDUGni7qyk5U4eu/tmJtOZSHVpdGFNANVW/B4AL543OTzmfGW9G9HQ8OgNVh8aYPa6vCk1W1hCTQ0BOTrSX2jAJOFyRMIO0pHCiHcmdg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ccd419-423e-43cc-4fd3-08dec2c9bb49
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 06:14:42.0969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7J5T2LLuRD7d/Q4r2LFGfVE+90WBFSSYYAAcdDSKqumVvtSPgCkcJJEYJGTMJQQOeug159hSlRj0y0riB7rleQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7743
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lankhorst.se,gmail.com,ffwll.ch,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295644-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:from_mime,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:raag.jadav@intel.com,m:intel-xe@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:netdev@vger.kernel.org,m:rodrigo.vivi@intel.com,m:dev@lankhorst.se,m:airlied@gmail.com,m:simona@ffwll.ch,m:kuba@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 90B77645756


On 6/2/2026 10:18 AM, Raag Jadav wrote:
> cleanup_node_param() is not registered for previous node in case of counter
> allocation failure, which results in stale memory of previous node that
> isn't cleaned up on unwind. Fix this using drm managed allocation, which is
> guaranteed to be cleaned up on unwind.
>
> Fixes: b40db12b542f ("drm/xe/xe_drm_ras: Add support for XE DRM RAS")
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>

LGTM

Reviewed-by: Riana Tauro <riana.tauro@intel.com>


> ---
> v2: Retain info as NULL on failure (Riana)
> ---
>   drivers/gpu/drm/xe/xe_drm_ras.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
> index c21c8b428de6..c1d5ac198a7c 100644
> --- a/drivers/gpu/drm/xe/xe_drm_ras.c
> +++ b/drivers/gpu/drm/xe/xe_drm_ras.c
> @@ -80,7 +80,7 @@ static struct xe_drm_ras_counter *allocate_and_copy_counters(struct xe_device *x
>   	struct xe_drm_ras_counter *counter;
>   	int i;
>   
> -	counter = kcalloc(DRM_XE_RAS_ERR_COMP_MAX, sizeof(*counter), GFP_KERNEL);
> +	counter = drmm_kcalloc(&xe->drm, DRM_XE_RAS_ERR_COMP_MAX, sizeof(*counter), GFP_KERNEL);
>   	if (!counter)
>   		return ERR_PTR(-ENOMEM);
>   
> @@ -135,7 +135,6 @@ static void cleanup_node_param(struct xe_drm_ras *ras, const enum drm_xe_ras_err
>   {
>   	struct drm_ras_node *node = &ras->node[severity];
>   
> -	kfree(ras->info[severity]);
>   	ras->info[severity] = NULL;
>   
>   	kfree(node->device_name);

