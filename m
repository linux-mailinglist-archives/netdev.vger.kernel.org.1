Return-Path: <netdev+bounces-286765-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PFoFKEWAmoVnwEAu9opvQ
	(envelope-from <netdev+bounces-286765-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 19:49:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CE9513C5A
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 19:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7D3CE3003837
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71E226290;
	Mon, 11 May 2026 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HlGzTfhA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EBB4657F1
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 17:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778520625; cv=fail; b=It6T2kJsgO9WrjuwROsyF7jw28t46dZTLCb0AtfZXbC401SSqdNVr1ncifbs2X2NhEYfvN+rRVDq0MQZuNrMZ+UtrEdSRnDNTwT952OjpH/WP9xFScRcPqFb1bsSsRCShtv7/rCL3jrTkzOfr6Q7b513hSscXiDdAY0cSHwyHJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778520625; c=relaxed/simple;
	bh=WdNPEVWsyGMZ4eXaIjKd9xZNyz/ylkiOsqOt5BDzAvc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a6JIXNr1u1lDIsQ27y6JJDGZ7Q6v64wFMx6KFScN2zXaY5Oe6YpzlXPKcqp8n+IIP0B6Dq86xGBSkjgRNVSeiWBUk4aVHfUrbEDhJ2v/0MC4XfVrw3RteadPUppFxlZAH3Yy4TDqHfcL+pdGCGUyyPr7+bW9QJfJwQuKqSGOfDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HlGzTfhA; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778520622; x=1810056622;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WdNPEVWsyGMZ4eXaIjKd9xZNyz/ylkiOsqOt5BDzAvc=;
  b=HlGzTfhAv23Hpm9CXCr52c2FtUM7XBk/stTQSzayoXJ39jd86fOfO9cf
   dsZODLsP0W/l+u4CQsS14tv0B2SPDCgLaUJlK5dcVVyLSoRZpXIKBmi+R
   P3vvdRjz76IWG1ElALb7nIprLww0WcsM0nH2yeQTUURU3R79KrI8vjA67
   xD3iZVcCsYn/d5gqoZ2lWFN8CcZNL2PBBUJYWUAYBtGSvbA9teCmjKGCd
   2HfZgcClS8EXypaMfguYErHku/gZRK5xWW2gCQ+Xd8OoIFC4kGFDYSpdO
   wH07cFOQyxQYVq0YSV5NqiYXQAj7Ujc7RtEauPoLpQu6uMzsmPbrTHM0y
   g==;
X-CSE-ConnectionGUID: bzA63h3bSx+yCBfZLjW+DQ==
X-CSE-MsgGUID: +lBvrgS2Qk2ppvQI+kY7dA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83030987"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="83030987"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:30:21 -0700
X-CSE-ConnectionGUID: vkNBkiuTQ22s3qVCmQRwJg==
X-CSE-MsgGUID: EUcjo/hPTFCuAJ+MVoXbJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="275645587"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:30:21 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 10:30:20 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 11 May 2026 10:30:20 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.28) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 10:30:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HC+X3pFRf3aen4J8kBeyC2qoBafYN/bXg6BAUQQuqpcm3zfuD6cwqONJT49yirlHaQA+v/rivazc8h79wv+HS6upBgEJF8Zr+csELhm6bX0V+ciwF8lozTz4QpOxdoOjsoPtKJGB9qHSq/d7wDRzM4jLLCh9NgmjrBhGTupHa2BCFJCQuCzDZ+QTvbAvDy1tbSEEQz4Cb5qswvXl2kpfFKWDQbz2KKFos7SdUF3YYDZePDG2ULBjJY+basIENEg5zjetT7N0g7dIFdTlMHGsSHccyb/S9iVf8g7f8HLvULVcRIvVbXoMFG6ZvqGSCtoA0gKwMgzd4ROmu22PHl/6wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jj41DSGjIYUBGCejHYNXjPQrR23wz1js0nlLHdIZBpk=;
 b=gEZYL1J38US7cURYW/kqylhZFJMLIx3O4ifwKmSuU0nad2I8JCs70Zmyg0glvBIp4PXRZ0YmWwIyWOmo01PkX/TQLEz43j8TduO3zGmWdJzQnbz5vvivIlgkIzjHkwBtvaXUh9O+6sHZnyYNytpx39ksMbYN0IRhEdQs2EXYdIevr3yTsncWpf5txN67gon+C2Adn2eiKXrb0Qv5ICRbyYEppWhWPRlxkWuYopJCzAHVbMv1/Vbo9Nwtkj7Hz44cN5h0Uq3VSKzQ9MhZsnnZ63c/qHSHXkD80axSFaW4dOkcP27H1RFoTOifNeNzuteFm7Tm3YldgcasCt6ui3X+xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 DSVPR11MB9718.namprd11.prod.outlook.com (2603:10b6:8:34d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.18; Mon, 11 May 2026 17:30:18 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 17:30:18 +0000
Message-ID: <2547bb13-636e-49aa-9e77-e57914dd4936@intel.com>
Date: Mon, 11 May 2026 23:00:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 10/11] drm/xe/drm_ras: Wire up error threshold
 callbacks
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
 <20260417211730.837345-11-raag.jadav@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <20260417211730.837345-11-raag.jadav@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0081.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d8::13) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|DSVPR11MB9718:EE_
X-MS-Office365-Filtering-Correlation-Id: aabf27e7-a1b8-42f5-219f-08deaf82f865
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: 5P4/i/2R+3PpiSaLlrK3rKJ8Wb/goOoDo5iMg+7vZuh4QYB0hQ8xiLarmaaUpRozU7tNifwkGaYXHE2SMHaL+EQj8oz+9PQqpLnEbfnvxQvsiKGa/DgujI2oNDoU7KWUTdf6cCSyG7euO8N9+lRaw0vPOodetLWNTPMjWyh5fFNepkw/NCl6tnrgOFmVuCcz7ElTwgiO1Jk+xMDNrM7TBeG9wTMoiBR/87vVoRxspIJqcKzLI/k2P1nGcFYT3O4Oc8jL5A/5Ewi/XMyyqCsbHCBWtjQDF8tNpolBULoT2EKWhjVbPSoSRez1q+JRrP3qLQ54R1F4toqFwdyDxS3ZvG8qI9ZsDi0L6GKdxi/OxE8w23um096RNQT9TFb0GsNTeFDfF9PRl89RAEH3lpPCc8eo+E7/Qou6zsihmGxDk/slsT8CwY0+JyIYY0wyekHbWzA1rlIxBQuV6BpwaTuyD7fcckjROTLC9SiLuozLlSxDgiR0q/fRYqKQu+jhCk7s1bAa+x+S444b23N66FbG+tXQnZu4jyxhR7i1PPe2h0VQvAXmQHOrWJkuMaaJ5c/MtTmndYqfGVBqdhvKsFat0XmpJNzfHnQlyyb1Pn6tIVzZz5jKLY28qqAl+DodWzl+L8slZELxxlrzUoFpNKM3Va1BeWMAKKBK66hvO6qHqRPlVXZxbfSdLad1xpTqxsNH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(22082099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0JqMUpZVHpKbDhRbmxnVlVPQW53aFcvdkFKN0FXQlBKdFJnOWJTallUbXRh?=
 =?utf-8?B?ZTUrSm90QmFvVVljdTR1V3F6Q1JaeXBhbk9yRkhQUjRyY1h5d1AyeEtmVkRJ?=
 =?utf-8?B?L2s5UHRqZjNzVUF0NGQvSURYaWdxb3prMVFJbzRDOEFLTlNBUlNNL05KN3Rp?=
 =?utf-8?B?UUQxRnIwVUpQWE9ITXNJWUdBVUJQZHdvK29aNHM1aXk4QlBMMUJoVU1kcjZt?=
 =?utf-8?B?VHViU0c0SzByMDAzc0VLK3BJcmtVdHNkb2VVM1JZU2twZ2RpTVZycmd3Sm9a?=
 =?utf-8?B?RWgxMkRLWkFaM0orZHg5eXpWYUMrdGxzUkxiUm4xc1BaU1JKZitFc0lFZXI4?=
 =?utf-8?B?ZDJzMXJQR21xOUVYdStEdlhzT0dLM0RicW1uK1djb3pZNDNJUVpsNDVmcXg0?=
 =?utf-8?B?SGIxZlBveEl4WTRYZE1pMktkL1l3TGNzMTBzd2F5UUJEZnlOT0cwdldIWGNn?=
 =?utf-8?B?V1NORkNDZ2FhTE9jRm9ZTnFoTVM3c0UwRXlCQnRpVjMxamU0dU5nbjZTTGs1?=
 =?utf-8?B?ZVF0U0hjY01NVTVBRjd3VlU2ODdoL3Y2RVFwb25GN2N4T1B2TEJrRzM4ellZ?=
 =?utf-8?B?S3dWK0FVUHVMTGt2bmJyS1Ewb3hyMjlkUUl5TWdSR3RPUmxOWFJIMHV3Qnlu?=
 =?utf-8?B?TkFMU2FDYVdDdmdrTVlQdmZ3eHVyUGsrV2g0T05xcXU4L094djBLR2I0cmxm?=
 =?utf-8?B?L3JmaE5uek9Xd05VUGVrZGx5QllxazJhc0dnQUdSa0lQemNNSzNmbXBYTHdT?=
 =?utf-8?B?aFJTaFZQd3NydlZVRTdWUHdKVENucW5EcHJwQUp3Y0RUWWZTSHdNVDdlYWVa?=
 =?utf-8?B?RHVzVmkwTGpjYkNRSFhoWVMzczhVdDVRMWJZQW51VjFJQlNjSHVNb0lHVldG?=
 =?utf-8?B?YjVlMUplSk1IN0F4U2hOVVJkN1RWdVJTcndZZVZ5eGk4R0tnZy90VW9LaUta?=
 =?utf-8?B?TVcvd2t4ZEI3UU1TTUxxSWllR1p4a3VnU1NMTHpyWUpjWXg1MmF3blVJZFVM?=
 =?utf-8?B?dlh3YWZNRTNNZklRSzBQUG5nbnZLSnF5U0pMdC80bFFFUnljc3lDcXF2M2lI?=
 =?utf-8?B?YWsxYUxoTkltTXNRUUFvdXR5SFI1QWlQcnd3U3JvTGZKVnhXOG9iQUE3YmE5?=
 =?utf-8?B?aWczOXJKU0JaeXhHdnJLaHdhcUN0R1hxeU5tRzRCeWNaK2szM0wzN3JrenBL?=
 =?utf-8?B?VE5tUytQaFVqWmIxbTdmNFpWbW13YWdnU1hIaklqU2d0WUtoNkpSSFJqZGE3?=
 =?utf-8?B?RkpCRDF5VEdiS2xRSXdwZWhOMG1mdTRZZjdoWi9RMEF2TjZuNU5XS2U2cnp1?=
 =?utf-8?B?VXhobExmRyswa2VUS2FBQkVGYTgzR0NpRCtTSVBxZmI1c2VIYlRtODdsdGUy?=
 =?utf-8?B?MGJKYVk0TjJ6WTVQQVNGM3hoOGdDdjQ2ZzhkN1h5NHBmVUpRdEIrdmwzdlZB?=
 =?utf-8?B?S0xCTmZiY2NNNXNvYU44T1pjNEd0a2NSYzUydG1wNjQ1dFg3V25mQUp0Vno0?=
 =?utf-8?B?c2k3WTlBWWVqWmdWSGcvS0g1c0pPMDdqQko3TU5QeFJ5Q1FxRnRyTjd6Q05i?=
 =?utf-8?B?MnBxNE5qUVJLQWsrRlYyQUVOUHYyVzlhY1NJUU54Zys5c2tBOHRtVG1YQXRR?=
 =?utf-8?B?VW4wYjZRWWo5RjJaK1I2ckkxZjZOcFFONFVDb3dld2cvSVNUSWd3NVFXTTR3?=
 =?utf-8?B?UVdiY0YwY3pQTFdYRWpRZDZsUUxXeUYrbW1lSEFtVXMxRTNZZU5lRG9WUDBC?=
 =?utf-8?B?UGxzaUtXcFlyeUNwcVZZejNFRkZ6clpNYWVpdDV1WmdoZFRrMENyNkdRU2Y1?=
 =?utf-8?B?dmtmZXZjRllPTFR6SzlYaTRwYnRwelhQZ0Zhek5pVnYrUlpRQmluaWpIVDRS?=
 =?utf-8?B?WndxU1VQWGRvM2VrZUtNRkhLL09CekRYeHNmaWl2NDByKzdhSHlFbzdmZVNC?=
 =?utf-8?B?ZHRLM0hXbEJmZm9vTzJkOVNTQkYwbC9YMnNIb0tDUDZGdXFNeER1bEFDWC9p?=
 =?utf-8?B?cGNRTFNMelVoYVJ6NFJacG1QdThVZjRSUzN0WlM4eElsZHdaTnpSTC9kOXFS?=
 =?utf-8?B?UjN1NDhiWXU3bU9QMnB0RVU5NzZ5MkxpeVIwS1RBL2dZTU1WNEtQNnF6OWFj?=
 =?utf-8?B?cTZpS3JiZHh6QzliYzhYU0xiVEhhOEVTeWNuTkNEYlpUeko5eWFoQVlEVzZW?=
 =?utf-8?B?WG01RzF0YlRibHFoOTFZbjBuQ1VuV2I1WENySmVLQXhXeUMxMWt4cTRIMVFD?=
 =?utf-8?B?K21tNlpBR3FLaEdvVU9nVmZEN1ppekZoc0h6S095MXh5Wmg0bVNFWU1NY1RH?=
 =?utf-8?B?eldpeFZsN3V3eVV4YXQza3JvSGdmd3FVNEZqUEM0enJyUnBDUVhndz09?=
X-Exchange-RoutingPolicyChecked: OLtWNIol7xt4xY+P9K7u2+NzQh4zlaV8OsBvCBDqmuEhhXeL4e/qsy7qEn4GBuM4xoD9ud1AM/mLoeZ3bZstJWYSlnLkSD0Ag/sM3rgn90f7DiThx1M4DiCHXeOE6zl7oxpfq09cAPEL3rSKltsN3qhr036LRlmamfjsZ89XQ8Hjo9GOunuNhaYWUlGNmF5yNYG2c/B8A2rRkRguNbfIywk1nsKffCvCMiRxVT1a3IIEZFnK+vyqC9etKiAZA3xgtzAleuHaWW44o6zgTQdYLSl4FaF36fX41X7X3PMttpGfkalxdnTExdNR92ZfpjrRQPSst9RKytBSl5VMX0h9vg==
X-MS-Exchange-CrossTenant-Network-Message-Id: aabf27e7-a1b8-42f5-219f-08deaf82f865
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 17:30:18.3054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /qUQWC9o2rUipk9OasmXqmAAPpf0ncWQZmAm6tz9iorfBhdukSOOQZFyA8yzg5XGrE1OTEMDyMtRDvOE7oOxnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB9718
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 66CE9513C5A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-286765-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com,lankhorst.se,oss.qualcomm.com,intel.com,linux.intel.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action


On 4/18/2026 2:46 AM, Raag Jadav wrote:
> Now that we have get/set error threshold support in xe driver, wire them
> up to drm_ras so that the user can make use of both functionalities.

so that userspace can make use of the functionality.

With that change

Reviewed-by: Riana Tauro <riana.tauro@intel.com>

>
> $ sudo ynl --family drm_ras --do get-error-threshold --json \
>    '{"node-id":0, "error-id":2}'
> {'error-id': 2, 'error-name': 'soc-internal', 'error-threshold': 0}
>
> $ sudo ynl --family drm_ras --do set-error-threshold --json \
>    '{"node-id":0, "error-id":2, "error-threshold":8}'
> None
>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_drm_ras.c | 29 +++++++++++++++++++++++++++--
>   1 file changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
> index e07dc23a155e..824dabd5c29e 100644
> --- a/drivers/gpu/drm/xe/xe_drm_ras.c
> +++ b/drivers/gpu/drm/xe/xe_drm_ras.c
> @@ -11,6 +11,7 @@
>   
>   #include "xe_device_types.h"
>   #include "xe_drm_ras.h"
> +#include "xe_ras.h"
>   
>   static const char * const error_components[] = DRM_XE_RAS_ERROR_COMPONENT_NAMES;
>   static const char * const error_severity[] = DRM_XE_RAS_ERROR_SEVERITY_NAMES;
> @@ -47,6 +48,27 @@ static int query_correctable_error_counter(struct drm_ras_node *ep, u32 error_id
>   	return hw_query_error_counter(info, error_id, name, val);
>   }
>   
> +static int query_correctable_error_threshold(struct drm_ras_node *ep, u32 error_id,
> +					     const char **name, u32 *val)
> +{
> +	struct xe_device *xe = ep->priv;
> +
> +	if (!xe->info.has_sysctrl)
> +		return -EOPNOTSUPP;
> +
> +	return xe_ras_get_threshold(xe, DRM_XE_RAS_ERR_SEV_CORRECTABLE, error_id, val);
> +}
> +
> +static int set_correctable_error_threshold(struct drm_ras_node *ep, u32 error_id, u32 val)
> +{
> +	struct xe_device *xe = ep->priv;
> +
> +	if (!xe->info.has_sysctrl)
> +		return -EOPNOTSUPP;
> +
> +	return xe_ras_set_threshold(xe, DRM_XE_RAS_ERR_SEV_CORRECTABLE, error_id, val);
> +}
> +
>   static struct xe_drm_ras_counter *allocate_and_copy_counters(struct xe_device *xe)
>   {
>   	struct xe_drm_ras_counter *counter;
> @@ -92,10 +114,13 @@ static int assign_node_params(struct xe_device *xe, struct drm_ras_node *node,
>   	if (IS_ERR(ras->info[severity]))
>   		return PTR_ERR(ras->info[severity]);
>   
> -	if (severity == DRM_XE_RAS_ERR_SEV_CORRECTABLE)
> +	if (severity == DRM_XE_RAS_ERR_SEV_CORRECTABLE) {
>   		node->query_error_counter = query_correctable_error_counter;
> -	else
> +		node->query_error_threshold = query_correctable_error_threshold;
> +		node->set_error_threshold = set_correctable_error_threshold;
> +	} else {
>   		node->query_error_counter = query_uncorrectable_error_counter;
> +	}
>   
>   	return 0;
>   }

