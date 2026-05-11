Return-Path: <netdev+bounces-286756-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEPwHKUNAmoSngEAu9opvQ
	(envelope-from <netdev+bounces-286756-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 19:11:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAFF513205
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 19:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC4653010BDD
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DB94418F0;
	Mon, 11 May 2026 17:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y+pAnksa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5363FD131
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 17:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778519452; cv=fail; b=KNaJaLXcRu9/0WzxMrUfjDaYGvg7dcoddUdKuDx6xmgsFLXVhtIROIcY9iOAb/gz4dCnk+8RqhTS8POS/Q5XCEdRnjFF//k9NTBGDdt4TV8H4XRkH4h/1euPrVvF/SnSYzb9uakfoLGVT9c8k+0dpGNhNyYV7Le1iwlBCyanBLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778519452; c=relaxed/simple;
	bh=mbxd35ubebCYQNk8a0Zg+T2EE4DY3U73bcU4p3Zd2p8=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bmf+fJxCFK/F8bPWRj7E3LsXeu2qRrHpkKv68MJmMAoARhIyqV6ZMZVRE808WkCLkBVVUePCObkPRa2K1MWIBUDzd+hY3jN7YCePRQcfNToAdNn6dPpbCjEoPvxpYGy2Awq3cdIdZ5La3gHJm4kZIwTK42Ce2yTH35dNenKt35Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y+pAnksa; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778519449; x=1810055449;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mbxd35ubebCYQNk8a0Zg+T2EE4DY3U73bcU4p3Zd2p8=;
  b=Y+pAnksa+iBHm4UI8MQcjgAyiwSh/gDqKHPIDuEqAVGD5bPV9+IphU2w
   FW85bvH64ITxASVQZCxcCJk9f6uVoTTlZ450bDGOqnOqYemLBd8FjXwUM
   gpcvfmNA7jYJAC0JSnE+BR0zCa3sVZcFh+lOUDtXQjOA+NebEYsgGE8/u
   YQzJ/iVhem4nxpKqbE8vp6SOlKYecNFDbwCuGQ5cq1gUWeem7twnTRZ8H
   wdNgXS7n1yl7q/gt+iycXIHWtvZlwbZKS+ur9CKCq1PDU/aHvz23EBqtN
   9Pr3PuJba3mIcZV8JQQg1asP+YxlOp42uGn1yYYRBqpzrlHZH9eaLaiiN
   Q==;
X-CSE-ConnectionGUID: nVjEEcP9RuGllTWN75s1jw==
X-CSE-MsgGUID: jF7p7uB/Tf2srGB6vFQSOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79311840"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="79311840"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:10:49 -0700
X-CSE-ConnectionGUID: sNWr+XhJQ1Wa5Rqtle08bw==
X-CSE-MsgGUID: 0+r4iHveQBCRxw1zCq1wdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="234847463"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:10:48 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 10:10:48 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 11 May 2026 10:10:48 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.63) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 10:10:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFWocPmtQwhRFA6kPfLaHrEvB+z5G4j0foJi8dn46nKhEvb4gQ05wKGVdV17YCiZQmszD6YA9DS22V94e5/+2hUuZecJJSWJHvE5XD7v2rAyT4/WCKC1jamm3I7eUzgQIAzQIgu1wl0V5DY3rvBYZGzP8k4SkPbE3V0OC+uX3ZikPP27PnNPYBymFvgoi5sGlRbHSyN7DFFVXLjZcQHu6EgaHo4Xsvt3ffxCKTPdm5zO4DNm94Yr+K3foXd6D4EPe1KtIwvcZ3W7QhZUX3YI27oyTKxIMbsahA1NXRDDMMunIL38lDzUQcCPh/MuJFcSWGt/9Y2k2nRYNh2IY8zvGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLGZFiEzmxzev2LB9AVTnszBkNkgfHVyEwAIXiQQMoI=;
 b=oPOaRN72LglU+oH75m+36Dx+8LwS8Y8Q8V7zKqXXqZWyJkbrJLCZuthhb1rdAiBpGorlpAoUAGEO7Lz7QPgKJ47rL58NC8UTzOHAcUhBszdTTZUtQ/jeGQSnA/XqXWYpCdfyqUr0SX5h5L4CecigXvsCV2xGJxeNzS5Q/VKs1V+j3LKBYTq2onmx9b6Otop7zzI3Loo0hvA6NZg7J82AohQ4vZJKPmdg0BDYaQVC3JjHOFVPPvcFl6iM9YMGmRkB12DNbO6Z2x2alaQDU/pLLLIkvlBJGUB6dHsv9e/cuteI0lE7lAusIBJ18eBYTKkm9tULUof5sUXUpcJygSrq/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 CH8PR11MB9458.namprd11.prod.outlook.com (2603:10b6:610:2bc::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.23; Mon, 11 May 2026 17:10:43 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 17:10:43 +0000
Message-ID: <81b9b5f6-6107-467a-879c-c2906e8d1f58@intel.com>
Date: Mon, 11 May 2026 22:40:29 +0530
User-Agent: Mozilla Thunderbird
From: "Tauro, Riana" <riana.tauro@intel.com>
Subject: Re: [PATCH v1 08/11] drm/xe/ras: Get error threshold support
To: Raag Jadav <raag.jadav@intel.com>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>
CC: <simona.vetter@ffwll.ch>, <airlied@gmail.com>, <kuba@kernel.org>,
	<lijo.lazar@amd.com>, <Hawking.Zhang@amd.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <maarten@lankhorst.se>,
	<zachary.mckevitt@oss.qualcomm.com>, <rodrigo.vivi@intel.com>,
	<michal.wajdeczko@intel.com>, <matthew.d.roper@intel.com>,
	<umesh.nerlige.ramappa@intel.com>, <mallesh.koujalagi@intel.com>,
	<soham.purkait@intel.com>, <anoop.c.vijay@intel.com>,
	<aravind.iddamsetty@linux.intel.com>
References: <20260417211730.837345-1-raag.jadav@intel.com>
 <20260417211730.837345-9-raag.jadav@intel.com>
Content-Language: en-US
In-Reply-To: <20260417211730.837345-9-raag.jadav@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:176::8) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|CH8PR11MB9458:EE_
X-MS-Office365-Filtering-Correlation-Id: f5c7161b-dd59-4c4f-3a3e-08deaf803b9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|3023799003|56012099003|18002099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info: 0NQtehxLKDUIkiqBv7J69DUix1cfntF1yI9r/+gpH78ynDZpdPhm6MtMRxq/cYuCGlEivF3HxFobmso6ojY6RagQ+00Q/dJKdRRdz6hot5SU8kbnU4tfDHxre2lkMSrX4y/youvVFYKa3ZuZBNu2Rz3w3l4CBvsNmZLYPo5YNJ31JlmHmM2hGgwl2tiZ1eUhurb4jverbZrCsGIu3/nYCp6IHIiAChsKqmZkkDg0XsDAV6PzV7QsuuoaNicHpkiaFPz3fs/SAkp64PPxn76AcuwQvMzojJsXPzfrntNDEuhFTjollJVOK/6teDie8swl0G2EJM6/NFlnRuc2SaXeNd4CcSl7/OkQZ1pqgK9NKUWRFUGiZ3eYLt9I2grFs9VdwVn8qNW5gaYm7kPBkBKB/LY1HyF6BTXqJ7CHUF+YfamgbRJ2GouZQWuctw0Vq3IE2NLhCoRsBVKStwciRgP3iR2Cuz69iquJ/0IgasWTcaigxf0nOrbHCwuTK/ykG+CFNPPCZ9hnY3vsYz+q3t0jXtd8Af7j3xcz/B3/ItgmtoFzBuv3ZyN/VDRr7pzlzU9LnTEZmBYNZeNKlKs9xOBQ/XrFDoldJpkHLrbI/kjl1A8/q/gMPxiUVP406wKt2audj0zagY4Cw91bjup0hdegfBAvR+Nu4dzDIaHSM2LlUx46Z/gmfwfwWh1ePjCPsKaq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(3023799003)(56012099003)(18002099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFNBQkQyL3M1TUFZVzlvRWZKS3ZETC9YN3VrcEZPUUdWeDlDajJYWXpMMWFk?=
 =?utf-8?B?V3U0amIrN28wczZyWEhSallRU1BoNzBQdGs3UXU0QXZja0k1WXBBbnV5RWNN?=
 =?utf-8?B?bHdXMDNpbURKTEdhWXNYRkU1VUZlY0NKOXdSbDBnbmxaSktndG1NcDhTRmlY?=
 =?utf-8?B?bDFFQXdOYXRNWHU4Yk9ZaEd3WURtdUJjY29vdEN1b0crWEpXMDFlSjN4NFZm?=
 =?utf-8?B?SkxCT1F0WmY0TEVyOVJlRlNZWGkwMC9DQi83RVkrdjdyc0hmTVpLRVhPUFlQ?=
 =?utf-8?B?V2tjalM1ZFN5MHB0OGpldm1nWWs2a0dqcUUra1JRM2tKVm12Zlg0NUs2NFhj?=
 =?utf-8?B?Mm13bjJqV1A5NW5QYkZqVXFlbmdtYTRLNkFhNkpRM296cVQrR3dCOVI1d3gv?=
 =?utf-8?B?RXNmTFBYZDNPYXMvNUpYdjdsSHB0NXorSWFkdENCRUdUUEVXK2FJSGkrbFNh?=
 =?utf-8?B?NUR2N09sRlpXKzQrNSsyU0RsZktqdFFZaDNvRlRnVnBpYld1T1NOR1VUZzFa?=
 =?utf-8?B?bnZLZkpWcXRwdlZhcWVhUmNNUFpFamJ2dzY4RitNRGxGTy93dmhvUUlMZERa?=
 =?utf-8?B?dW92RkcrVG1mdVdrSGUzOHhETkJDdEdLWlo2V0NSaWJPUE9SNW9Mdit1WVNY?=
 =?utf-8?B?bkEra293dm5maG1iWGJBaTRvdm1mY2owbkJ5Z0RIMDI5QnljdFRISTFYdnVO?=
 =?utf-8?B?WDFPQVczay9FNWtiUkxNYVpoWlplbC9JUktnMFdRMkhDRzluOUdzemMybFZP?=
 =?utf-8?B?a3Q5d2hReHVJK201NExoQkYrd0lzQnBHcGVPdTIya0Y2dHhzdllNTGpDV1Nj?=
 =?utf-8?B?TklZYXozcjdnWWo5em5HMm4vcFJkTDNqZ1VaYVpXc2QxRGUxamwvZUZkUjlG?=
 =?utf-8?B?U1I5eVlKQVJyNEVORnhwSjZwS0I5ZFJyRGtYVzJSeFRjYjZVcFM3V0l2RGdv?=
 =?utf-8?B?UUJHd0pEVjEvVWNyaWpNT3I5SEdweExsR1VxR1R1TEZtdEoreDRaTmFta0N5?=
 =?utf-8?B?Z3FCU2Z6eTRjUVNNbzdnRzJxZTVTZ3cxaUR2TG1heXFYS2JRRWc3czc5Rm51?=
 =?utf-8?B?QzZYbW5uOTZIeTh2R3VmMHdFWmFuOU9CZTcyNlJKN3krczR0cnFKcFZEMlo1?=
 =?utf-8?B?MGcyZ1ZyQXJPV0hXSVBmLy9NanVZMWpuM1pvRnN0OFpML05XQmlJOUZHYk5l?=
 =?utf-8?B?NSs0SzBkbEJxSzFjMmVGMndiWEo2WTNqNGcvc1Y1eWo1bWxmWTRmcVJhM3pN?=
 =?utf-8?B?Vk1CNEZCVWdqMUlBV1lKL0VuLys5cHdLTkQ3L201a1g2WG5pNXJFRGhCVGJI?=
 =?utf-8?B?SXA3dXNVMk1kQ0l0WC9XN2hJa2NQa0ZSSm1KbDFlVEIwOXpVWXFWMXVaUnhR?=
 =?utf-8?B?UjBzQkxsZGI1MzRvZWsvaHZQdzZLNThhOU44Rkdsb3ZoNlc4QVk1ejdUbXNk?=
 =?utf-8?B?OEh6NlA4NkNzclVZRklvelBONkptcDBBRzdpRFYrdklsK3c5WGxOelN0dWVH?=
 =?utf-8?B?WGxmT254MXR4NDdjelRLbWNiRWgrSjFkVHcwek1TekVCMFJuY0N5bmdtMkVH?=
 =?utf-8?B?WU9zQy9RQWR1MGplWDNnY0FtZ3dvSmxxam8waGZ3d2twdzgzQ0FLYTN1TGVl?=
 =?utf-8?B?YzJhWDFpVzY1V3U0NzBxWUxta2tTOFZ5MUIwa0phdGVhZE1ETC9Nb3d6eEtn?=
 =?utf-8?B?cklpWmhNc3MxL3Zsa0VsNUh0enNreFZyN3IyemhjeER1U3hoMGRDN1IxSzc5?=
 =?utf-8?B?QVlQMzgxT3Vxazd0bTcwNFRoWEI1c3hvWjhEQ2dUNTV5WkROT0xjOVdGbTdO?=
 =?utf-8?B?cUJPUGQreG4yTFdEczBxQ2wrMndwek85cS9hc3k5WTlGSjhuZVpEZDNhVEd2?=
 =?utf-8?B?akMzRUwxeFRjMVNtVEYrRU5xbWdZdVBYb1dheWdWQjAyM3ltMzVadjR1UXg3?=
 =?utf-8?B?UmZiY2h1c2o2WHhpMGZyVXgzS0hYTTZnMy9acmV5S0FrN3IxTzk0YTJjY0tq?=
 =?utf-8?B?eGRBQ1lQaWNFK0dDR1U1RGNOTmFsNnZ2a3ZWTktZblFGK3owWUx6Y0V2Z2tT?=
 =?utf-8?B?YytIazh5UVpaMWF2M3A0byt4Q2lpTkNZZHMrV1BHRFpoUU1uNnNmNFFwTURP?=
 =?utf-8?B?VzBZOEI1WjlqS0dXUEpDbm80M2ZOcjVjeFJuNkRsZ1ZIaVpMYzJYN2VLdm41?=
 =?utf-8?B?ME9kbUc2SEx4Z0RxSlV4VkJ1YXZRTnZySCtPZnd1RTJtMDRKQVhwYmlxZjc1?=
 =?utf-8?B?d0ZDazNwOHQ2bDlsYUY1aXhqTDhiOHFxd3JkZzA1ejJuR2FjV0JqQkpCdzh1?=
 =?utf-8?B?cVp1ZDBsL3pTNVA5b1ZHNk9QZFBOaVhudlVXMzZHOU9FZEdUQW93dz09?=
X-Exchange-RoutingPolicyChecked: amwYY74hl/UYoSvuL18NOtlDbuVkJP9UxFpDAE8g6tIBe8DB6U3PSXO8xex/6GnrqWcfLWSLag16MNcOVEDqUB+DbeBU6I5AQ/qBfLqD/XqHLPKNPmZ3XUf6YrlX5ukr5+bABk+Dq9q3F4EuR01w7XUAzo+BBztXk3niEdKr3ttGsUHyJET57uAz7/5TlyDXQB4LSWqw5Jp7WqHT2UezTaZTxHjRItFC22uYpmGlVlOvdNsfmvjC+RUAGhMh4np80d2q1v1vPoO/e5ebG5RJOsQfawShVlDoZ7JfaEnxkWSgEV7dNGgn/pwrkIqspo3v3cuBhZb9XyIsfjkAQZvl8Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c7161b-dd59-4c4f-3a3e-08deaf803b9f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 17:10:42.5816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1lKvi0T28HO0j4lIN2E2+3wO7kZMKUuYMBlSy4OI2a/+DmGXJCjdwk7NE6fRcTsfMY/2Vgt0FfwnxUQRvcs/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB9458
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 4EAFF513205
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-286756-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com,lankhorst.se,oss.qualcomm.com,intel.com,linux.intel.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action


On 4/18/2026 2:46 AM, Raag Jadav wrote:
> System controller allows programming per error threshold value, which
> it uses to raise error events to the driver. Get it using mailbox
> command so that it can be exposed to the user.
>
> Signed-off-by: Raag Jadav<raag.jadav@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_ras.c                   | 73 +++++++++++++++++++
>   drivers/gpu/drm/xe/xe_ras.h                   |  3 +
>   drivers/gpu/drm/xe/xe_ras_types.h             | 22 ++++++
>   drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h |  2 +
>   4 files changed, 100 insertions(+)
>
> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
> index 08e91348c459..3e93f838aa4a 100644
> --- a/drivers/gpu/drm/xe/xe_ras.c
> +++ b/drivers/gpu/drm/xe/xe_ras.c
> @@ -3,11 +3,14 @@
>    * Copyright © 2026 Intel Corporation
>    */
>   
> +#include "xe_pm.h"
>   #include "xe_printk.h"
>   #include "xe_ras.h"
>   #include "xe_ras_types.h"
>   #include "xe_sysctrl.h"
>   #include "xe_sysctrl_event_types.h"
> +#include "xe_sysctrl_mailbox.h"
> +#include "xe_sysctrl_mailbox_types.h"
>   
>   /* Severity of detected errors  */
>   enum xe_ras_severity {
> @@ -49,6 +52,23 @@ static const char *const xe_ras_components[] = {
>   };
>   static_assert(ARRAY_SIZE(xe_ras_components) == XE_RAS_COMP_MAX);
>   
> +/* uAPI mapping */
> +static const int drm_to_xe_ras_components[] = {
> +	[DRM_XE_RAS_ERR_COMP_CORE_COMPUTE]	= XE_RAS_COMP_CORE_COMPUTE,
> +	[DRM_XE_RAS_ERR_COMP_SOC_INTERNAL]	= XE_RAS_COMP_SOC_INTERNAL,
> +	[DRM_XE_RAS_ERR_COMP_DEVICE_MEMORY]	= XE_RAS_COMP_DEVICE_MEMORY,
> +	[DRM_XE_RAS_ERR_COMP_PCIE]		= XE_RAS_COMP_PCIE,
> +	[DRM_XE_RAS_ERR_COMP_FABRIC]		= XE_RAS_COMP_FABRIC
> +};
> +static_assert(ARRAY_SIZE(drm_to_xe_ras_components) == DRM_XE_RAS_ERR_COMP_MAX);
> +
> +/* uAPI mapping */
> +static const int drm_to_xe_ras_severities[] = {
> +	[DRM_XE_RAS_ERR_SEV_CORRECTABLE]	= XE_RAS_SEV_CORRECTABLE,
> +	[DRM_XE_RAS_ERR_SEV_UNCORRECTABLE]	= XE_RAS_SEV_UNCORRECTABLE
> +};
> +static_assert(ARRAY_SIZE(drm_to_xe_ras_severities) == DRM_XE_RAS_ERR_SEV_MAX);
> +
>   static inline const char *sev_to_str(u8 sev)
>   {
>   	if (sev >= XE_RAS_SEV_MAX)
> @@ -90,3 +110,56 @@ void xe_ras_counter_threshold_crossed(struct xe_device *xe,
>   			comp_to_str(component), sev_to_str(severity));
>   	}
>   }
> +
> +static void ras_command_prepare(struct xe_sysctrl_mailbox_command *command,
> +				void *request, size_t request_len, void *response,
> +				size_t response_len, u8 hdr_cmd)
> +{
> +	struct xe_sysctrl_app_msg_hdr header = {};
> +
> +	header.data = REG_FIELD_PREP(APP_HDR_GROUP_ID_MASK, XE_SYSCTRL_GROUP_GFSP) |
> +		      REG_FIELD_PREP(APP_HDR_COMMAND_MASK, hdr_cmd);
> +
> +	command->header = header;
> +	command->data_in = request;
> +	command->data_in_len = request_len;
> +	command->data_out = response;
> +	command->data_out_len = response_len;
> +}
> +
> +int xe_ras_get_threshold(struct xe_device *xe, u32 severity, u32 component, u32 *threshold)
> +{
> +	struct xe_ras_get_threshold_response response = {};
> +	struct xe_ras_get_threshold_request request = {};
> +	struct xe_sysctrl_mailbox_command command = {};
> +	struct xe_ras_error_class counter = {};
> +	size_t len;
> +	int ret;
> +
> +	counter.common.severity = drm_to_xe_ras_severities[severity];
> +	counter.common.component = drm_to_xe_ras_components[component];

I see this is only for correctable errors. We do not have correctable 
memory errors
Do we want to return -EOPNOTSUPP for memory errors?

> +	request.counter = counter;
> +
> +	ras_command_prepare(&command, &request, sizeof(request), &response,
> +			    sizeof(response), XE_SYSCTRL_CMD_GET_THRESHOLD);
> +
> +	guard(xe_pm_runtime)(xe);
> +	ret = xe_sysctrl_send_command(&xe->sc, &command, &len);
> +	if (ret) {
> +		xe_err(xe, "sysctrl: failed to get threshold %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (len != sizeof(response)) {
> +		xe_err(xe, "sysctrl: unexpected get threshold response length %zu (expected %zu)\n",
> +		       len, sizeof(response));
> +		return -EIO;
> +	}
> +
> +	counter = response.counter;

Do we expect this to change?

> +	*threshold = response.threshold;
> +
> +	xe_dbg(xe, "[RAS]: Get threshold %u for %s %s\n", response.threshold,
> +	       comp_to_str(counter.common.component), sev_to_str(counter.common.severity));

Do we need this. it should be visible to the user via netlink

> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/xe/xe_ras.h b/drivers/gpu/drm/xe/xe_ras.h
> index ea90593b62dc..982bbe61461e 100644
> --- a/drivers/gpu/drm/xe/xe_ras.h
> +++ b/drivers/gpu/drm/xe/xe_ras.h
> @@ -6,10 +6,13 @@
>   #ifndef _XE_RAS_H_
>   #define _XE_RAS_H_
>   
> +#include <linux/types.h>
> +
>   struct xe_device;
>   struct xe_sysctrl_event_response;
>   
>   void xe_ras_counter_threshold_crossed(struct xe_device *xe,
>   				      struct xe_sysctrl_event_response *response);
> +int xe_ras_get_threshold(struct xe_device *xe, u32 severity, u32 component, u32 *threshold);
>   
>   #endif
> diff --git a/drivers/gpu/drm/xe/xe_ras_types.h b/drivers/gpu/drm/xe/xe_ras_types.h
> index 4e63c67f806a..d5da93d65cf5 100644
> --- a/drivers/gpu/drm/xe/xe_ras_types.h
> +++ b/drivers/gpu/drm/xe/xe_ras_types.h
> @@ -70,4 +70,26 @@ struct xe_ras_threshold_crossed {
>   	struct xe_ras_error_class counters[XE_RAS_NUM_COUNTERS];
>   } __packed;
>   
> +/**
> + * struct xe_ras_get_threshold_request - Request structure for get threshold
> + */
> +struct xe_ras_get_threshold_request {
> +	/** @counter: Counter to get threshold for */
> +	struct xe_ras_error_class counter;
> +	/** @reserved: Reserved for future use */
> +	u32 reserved;
> +} __packed;
> +
> +/**
> + * struct xe_ras_get_threshold_response - Response structure for get threshold
> + */
> +struct xe_ras_get_threshold_response {
> +	/** @counter: Counter id */

Nit: ID

Thanks
Riana

> +	struct xe_ras_error_class counter;
> +	/** @threshold: Threshold value */
> +	u32 threshold;
> +	/** @reserved: Reserved for future use */
> +	u32 reserved[4];
> +} __packed;
> +
>   #endif
> diff --git a/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h b/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
> index 84d7c647e743..a1b71218deca 100644
> --- a/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
> +++ b/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
> @@ -22,9 +22,11 @@ enum xe_sysctrl_group {
>   /**
>    * enum xe_sysctrl_gfsp_cmd - Commands supported by GFSP group
>    *
> + * @XE_SYSCTRL_CMD_GET_THRESHOLD: Retrieve error threshold
>    * @XE_SYSCTRL_CMD_GET_PENDING_EVENT: Retrieve pending event
>    */
>   enum xe_sysctrl_gfsp_cmd {
> +	XE_SYSCTRL_CMD_GET_THRESHOLD		= 0x05,
>   	XE_SYSCTRL_CMD_GET_PENDING_EVENT	= 0x07,
>   };
>   

