Return-Path: <netdev+bounces-163608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8C3A2AEBA
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 18:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED670188290C
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 17:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AF13DBB6;
	Thu,  6 Feb 2025 17:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XqiXSvSa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C60239585
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 17:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738862362; cv=fail; b=oXXNOnVqMKbENLbaqm9GaanmzDrR8C7D14D8T8CBHiZuNgOYDjnZh5rIubHCyeOzGaR/XxwQndyemNLFYrawd0QxgP+Evs9d9QONZdCvscaeEjwkLa8sKNWthPJKM/irh9+rqxMWlWAYCc/L6aNHB7dn3JcnhkTs9Kmcdxll53k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738862362; c=relaxed/simple;
	bh=TxLveDecfB/ndF0CJVi6bp0Cv+MLVgQiYcZFfgLjx1c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JGLiT7CDSlEZA/Vp5AgOfgV76eIv1EpQsgPRmlGkwlJy4BcCQ/c4fdyXImD75EUvtM5thpEBXT5G8GCdWtxve8cWzHCLta11uFn+jCIjSbTeTysHVLaGyD0anEj+IjW1bg+T1yqfggVLaWV7bqT9wC8E0r1Xj8qOIG4a7Z3ob4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XqiXSvSa; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738862361; x=1770398361;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TxLveDecfB/ndF0CJVi6bp0Cv+MLVgQiYcZFfgLjx1c=;
  b=XqiXSvSa7v8GeEinV+C64rBYi/8Ts40YzIBh/51XY2D4Wpk/Rq2SSkqX
   yjmAC9LGByBhHhcl+hvuzePouEh49nwUGghfaVwGyvjarnP2fCnR8IHXK
   26o9g5aDVABNShygvfq7rSNGBbF5uQtEZbLX+F0D7PLJcjJLVx4H89tFH
   8fLk3F78fV4+WYTr4LTVHBHFzXvf0oi6sHpM4gwNJOIqKzgHtI+gxTF7N
   G0psTr7VIz5y39+Ok1wK78IovBWRZUI5Sy/lkDLAisrGlm2B06Z/Vnb8X
   Pwa4WEqxR4UPJJ/if7vOmT4zlZOSre2Q+v1hwhE0ZVFqz7+6BuyIChXVs
   g==;
X-CSE-ConnectionGUID: JrEEfqVTR4S6VUBgfkxHJA==
X-CSE-MsgGUID: FGU7CVpRRW6TnpYTKmcMfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50116298"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="50116298"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 09:19:20 -0800
X-CSE-ConnectionGUID: ZSOsV5QDSnWA6oxjUkIp/w==
X-CSE-MsgGUID: aAWOKho2SzWtrINhg/Rbig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="111806716"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Feb 2025 09:19:19 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 6 Feb 2025 09:19:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 6 Feb 2025 09:19:18 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Feb 2025 09:19:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TuY8+fgA3EhdcFWmzpZLJSHPaeH2SQHp5C86ub+V1Gtlo0lgoBt2YUXC8tx+stLNpCScBnInG/FNEph/pnLeEPxrkEkYAbMiG7sqCET6ltWJXZYDXfoqR6CdXdYAoJATeCm86/W0pxnNP9PNlJK37OPT14OnFNo/ztMg85PKCpFh5rzVuEIdetYf2eegjtYj5opgVjWfUzZFmmZn6KciNawvYB3y1829sfjhvt8nzgzcl5cT1WG1ItLSI+P604s4K+QfnjLj3RyVCTajTUJhvIgar48dmJlqLDo6PmwLZDP/IvkQd+Xcy5brUXkBhiWiAUZs09QRbJYr1jfJLpIUAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EeLb4oNb61LNNpzHZH1dSD3/cEy91DXx5Ib+9HHMi9Y=;
 b=aEuLHSo4+L/nqkUebw5uJGBdzmSmqcK2Ur0lxeF4W/2aWaW3iVaLCnnEMs3H3BiIu+lfX31P3xRyRVg7NqTetn1klv1L5Oz1ZFBTbsy1ox467cEWAbeOrM7drLllzKx8ADm0he1/XjbXnoPItId/XAN0ahAZi7f25L4RI1Qdvl3kdd0XpX+Yk8xrYYNqrf1IXqnAjbYXuGxMXZUaEW8BMeRVo/5KQG37Uu38Qvot/f+HkF24ANqZlRgHsK3bZQ4jffLnQ+953DszNdaS5owKBDtN2IGI84/bIoDzAshkyZzYe+IzjpHqZNzN/mlTe0anqPY6UjA4WCoEvMyZ6fE2ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB7994.namprd11.prod.outlook.com (2603:10b6:806:2e6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Thu, 6 Feb
 2025 17:18:59 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8398.021; Thu, 6 Feb 2025
 17:18:58 +0000
Message-ID: <e87f2ab2-d8c3-403a-a35e-46ebf063b626@intel.com>
Date: Thu, 6 Feb 2025 09:18:57 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: iAVF circular lock dependency due to netdev_lock
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <81562543-5ea1-4994-9503-90b5ff19b094@intel.com>
 <20250205172325.5f7c8969@kernel.org>
 <a376e87b-fbd8-4f07-9ab2-80a479782699@intel.com>
 <20250205203258.1767c337@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250205203258.1767c337@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0144.namprd04.prod.outlook.com
 (2603:10b6:303:84::29) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB7994:EE_
X-MS-Office365-Filtering-Correlation-Id: 3624a12b-2fb1-432c-3b83-08dd46d2578d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZENRelNjRTdtWlEyOHBtRk5MZWwrWThnclI5VG8wUlAwNkc4NG9Md0lYZ2dk?=
 =?utf-8?B?OGkrSTh2OFlUcWkwdzNwZnRobnFFaXMwam9XT1R0UmVSTGlPNHFxUHVSNU94?=
 =?utf-8?B?Y25NNnVjRXVrOHRIVEpRcVlVUHM0QjZzcFIwaGdwcWM2OUhWYXJ3d3VRTUN3?=
 =?utf-8?B?WHpnQjBpQzBxNCtjajV2clJ1MFBycnNCMkk1SFBUM0JtdnVhR1RYUmZwR1VP?=
 =?utf-8?B?TGR1STc0emsvMERPMTRleE9oaGFHazJtbFE5STRnbnlaSEJHWlhvTUZTSGUw?=
 =?utf-8?B?YWtpL2pmVXc4cjlwNDRVU01CM3orSmEzeUk5TC92V2hja2NMVDcwWFNHRDNS?=
 =?utf-8?B?ZkVWdDRwQVJLamZVeFEvNWRMRnd6bGJQdWFFQnpUWWE0bDUycTRxZkc5M1Zq?=
 =?utf-8?B?eTE4SUZ6NmFzTXNycHRoTlBBbERQR3NqY1M3NEdFNGJ5Z1I5QlF1YmhUVTZL?=
 =?utf-8?B?eCt5eElwTGtSWjRTd3F5eVh1SnliYzkrREFXU09LYWM0Rk0xS0NPMGEra3Ew?=
 =?utf-8?B?TXJUaGNxMUMvYndKL0JQVld2RFB3YUtnRGxQcGh2S2pzOW53WjR4S2ZUdnA0?=
 =?utf-8?B?Y2NBM2dJaGtyVjdDZjMwS05FYWhzYms5eWh6N2ZjcEVqbHBiQ1dHZmtVZ1BB?=
 =?utf-8?B?L2Z3UERBK1BIQXRoQjRFbmRGN094UDcvNnRmWEFxTzFoa2hIU3hLVC92RVRD?=
 =?utf-8?B?eTNRT3U4QjFTMnMrdDF5UC9BVzNZb2orQ1IzQmVlVm83bGUzTkR5bWFHbGdn?=
 =?utf-8?B?QURuaU13dUY3dVdGRWdsKzB0alJYS0RGL3RqOUxOWFVBdGl1Ymp4OHhhRVgy?=
 =?utf-8?B?YUZuVEs1eGZhQnVUcmlBVkdySkI5dzcvUzhMRStEVW9rN2dhbnp0MW9zVjdN?=
 =?utf-8?B?VHNFQS9iZUhWbDBXZEdFNjcyRlU1VlJ2YXNyTWdDY0lmd1NtelZBUFFrOWhT?=
 =?utf-8?B?YWtiM3MwRndlUVNHQ1lEVHc2aElOcUJLRmMzNGxzaDd1L0lyVUxuN0N2YUpQ?=
 =?utf-8?B?VWdtYmR2bHQ4YU1kQVFlNkRRZ1lOVVRrY0lRc3h1UlU4OVcrWFFoYnV5QjAz?=
 =?utf-8?B?dVlIbW9VaTRiN1ZvUDc4SEtmL2JNQjVOZGk3UmJabjZVUjlCaFNQUUh5WFZw?=
 =?utf-8?B?LytvRHJmdlJDazg1WEN3VHVONjlCTXlPNFpNd0hQMU5ENjA0U2ltNmQwa2pq?=
 =?utf-8?B?NTZiR1EraU9lS1I5WEVRbjFoNDFwK0l4QUdlZ0xyL3Y3dWxEOGJVQmxkdVZk?=
 =?utf-8?B?eGxBbkJ2VUVYRS9nRldTTW11RnJtNU52eGtwdEs2M3RiS09hZ3R1T3hlL3A3?=
 =?utf-8?B?Y1BlaE9oZENjZER4c1hYWGViQlZHcHpJcGRTYzJhZjRyak9zNGNxV2VsdFNv?=
 =?utf-8?B?YjNUek13ZFpYY3hscEg5UTJid3BNUXlvQTJzeTN5ODVHeVE3OFlqRkFTZDZz?=
 =?utf-8?B?bytXQ1NzdXpNSkZuMUlHWEJJaENHMXVqZ3RRbG0weXVWK3MvUXgvZ0ozT3Iw?=
 =?utf-8?B?dGE3UWcveTFHTzkxT0NZeTFsditiby9hd2ZMM3ZBakVCb2IwRmxzUnV0L1pD?=
 =?utf-8?B?S2ZYMWZFTkQxOXhaMlVheUl5TW1yd1RPY05PQUhhc0hSTFloZTFSMEszb1Uw?=
 =?utf-8?B?a0RDVWh0Z1lEZk80UU5TUXlsQlEwY29MVlBZUFZkSUJOeXI0WWtwUjI1QXE5?=
 =?utf-8?B?cU1HYzJXS1lEb2tOZFVYM24vUmJxZENsNG1tcUVMM1NoWGljbUtNTXg0TkJV?=
 =?utf-8?B?TTQ3Z2EvWEE1dzRMUHlMUmhxY1JPd0dpVEgzOWJZR2RCbitYTERRdVhMQXBW?=
 =?utf-8?B?L3hBUUxuZWFTOHlYZThyUThrdHNScXhZcWJvbTI1VmkzQkdUQVM4aHZwclRw?=
 =?utf-8?Q?wQ0qYdOYh/Mee?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmIyemlpbFUrUi80citEcUZaRFlQeDV5Z0RHMEFFRE1ESFVndTVDVSt6VnlO?=
 =?utf-8?B?WjRaQjFLRUtYVXptUmNlQVdRSjc3R2pFdU5ob2xMMnBYb0pTVU5qRjRhaTZU?=
 =?utf-8?B?VkpxRFMyY2Ficko3bkFnNnVMMzNmYVZ5OGhpR2xGMXZqcG1KWXJRNUhDdUs5?=
 =?utf-8?B?em1YS3VtVkx1WkdtcUZJWk43c1lTaHN3U1JFc01tQk1nUzhtZU1jZDVyUU9J?=
 =?utf-8?B?NGk3cVgwazQyYS9Ra1B3Y2hoOS8vT2VJUjQwQitLRlpaR2RJTkJpYThodHIv?=
 =?utf-8?B?TXNmam50eWE5aFMxbUlDc2ZUK0Q5dHBvWnZ2UTFtZnhpeFZTY2hLaTlUQmdK?=
 =?utf-8?B?b0NCNzdualFJR1ZwWWhlQzM0dWpFcnVBRFVYT3plaTJKdHhTU1RjM04wMGMz?=
 =?utf-8?B?SFEzZ0p2VVQxUzNtNXl6Y3drOTR6aXEyT2VBQ0dIeDkxQ3ZGZFdGNHZZNmNu?=
 =?utf-8?B?TTRLaTVSQkRBWWR0dTMrNUQyWlY2Y04xaUdtc3g5WHlsY0haODh1SHdNcHdl?=
 =?utf-8?B?a21kTDBFTGwyelpVWVh6dTNVdlhMYjkzR1RvOUwvUUdENXVNSDV3M0ZNVE0r?=
 =?utf-8?B?dTVGTVFYVnVCTU9CNDJJSnBKOW5FQmNya0QraVEwbzUyaEJEVUJwWW1KVlRT?=
 =?utf-8?B?MjZGNnozb1JFbTYrTUlBMTVEWnZjd2tUVExkS3pQa3hJVWJweU80RUJZMGpl?=
 =?utf-8?B?bjFlV3Fsa0M5ZWppSUdSWXZjYm84N25rRVBZcE5nWWlHZjJvMFgzZWZzZ1BY?=
 =?utf-8?B?dENBcmk3T1E3akd3T2hMMEhqVFJPd3VEbUZCdjdWbi9aVzZGcXlqM2JZY2Y5?=
 =?utf-8?B?UWFuNHRmenFyRmErRUdNWndLc3diZzViU05TblBVYm04b3RybUFaL2Q4aVlq?=
 =?utf-8?B?Nk1Ed3ZTWWNLckw4bjZKdGVONHlyWVdkUWZuYXBMcVIzSFV4K3ZPWW5mbEVV?=
 =?utf-8?B?S0NtemIxU25ib1VmcURWZks5UjlHSEc1L3BKemIwVEZveFk3aHRRQ0xpNzBz?=
 =?utf-8?B?Z0ZSZVg2RGYyb2xRZVQ5Zm0rcCtiMkUyT3ZzY2ZhcmxsZVVNZlpRblU5ekdQ?=
 =?utf-8?B?OWhoRWN4UlFMRXZpME5LTS9SK3BUZkNaYUxWN1JueGZoVlMxSm5Ed1VlRm5B?=
 =?utf-8?B?R2tRMDdLak9QKzZFV2lJL29GeFFBV1h6Q0JtNllmejBOcys5OFJJcUd4TkRF?=
 =?utf-8?B?Tk8xR011a2ZhTzJjclp3QUpsUVhhRnZFUk9ZYytRYkZzVDhjenU4TWlGQlF4?=
 =?utf-8?B?RjJmNHBDelZuYVlxbzR4dWRPaitVZGFQSWdOUEdQcXBZSlpaVEhXYWM4TXpS?=
 =?utf-8?B?R0ZrMWFRNzVUVFp1ZVpLdEJ2Tmw2cXlUK2xaMURubzF4R3N2VCtCSkRNWUZX?=
 =?utf-8?B?SnNORmRzOEZoaU9QaDVxekdNNFFESXZuMGpjNmhXT21pOE9ZNUNiMUlGdUNn?=
 =?utf-8?B?clRCM2VZK21uWFRwSGIvUTlPTm5Ud3ZFaFkySGk0SEY0MHA0QnBDYVNVczQx?=
 =?utf-8?B?UmNJL3hCc0dhcXZEY0UzQjZGMHRlSlR1aDh4dlhnSDdvL3hseWg5MVowblh5?=
 =?utf-8?B?eU0xMkd6V2h4U1JveFhLVkdWSFpldDVnc2dxTThiMktGbUZUT1Q2RnpOVGMz?=
 =?utf-8?B?NmY5YTgwNFd4MTVJbDhwZ3dadUtHZGNDMzI4bWFtc3d6L2hGM0VmT0dEY0lU?=
 =?utf-8?B?U1JNZzhrSDk1WVZGQld3UzZwck1TdGNhejJuOXZnTkEvMDJpdktRdXJOREhU?=
 =?utf-8?B?QjI2THVnaTdvWHEwM1F0NjZORzM1dmdWN1dNby90Z2VXeGgzUkJqRTZsRmZG?=
 =?utf-8?B?N0VuQnkyWCt5eVFoSlN2ZnVQUHBFbnNJbU9zOTZHYVRCT1RFczV0NURlMGRW?=
 =?utf-8?B?dzN2MlJsT0dLNFJpTVdxUWU4L3dmNWNvQ1ZZNnpNdVJ3eDdLbWswYVhHMklI?=
 =?utf-8?B?RUtxWkJmaGpFc0ZsLzJPS1NyRklZZ2E0NGYrNjJrTUJ0YXVvZEJybExBR2Qw?=
 =?utf-8?B?anhVbGc5UFErSkZ5Y3oxN2J6OWhZOTNYRHlMbXcyOTIzaFNxUklWOW5scWNa?=
 =?utf-8?B?aU9oS3BnQWJ0dXBvdTE5cVZQVVVzYVpwNGhtbVp1bmlza0EyckJ1OEI1dGFR?=
 =?utf-8?B?SCttVlJkLzJoSFcrTThqMVJmMnVlNlRib0Nyc0RVSzJHUEd1eHk0YXp5NmxV?=
 =?utf-8?B?cFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3624a12b-2fb1-432c-3b83-08dd46d2578d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 17:18:58.3488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9fwGg/aaxfmjgWAp/5ilyZ2yQA5W6oFkDekF60BdL9lVlYLVLMSyG0NpJ3rbcJuyVbwDXf10sVvlwy5nWS+ByzLyWgZLnytouE6rCz1Hts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7994
X-OriginatorOrg: intel.com



On 2/5/2025 8:32 PM, Jakub Kicinski wrote:
> On Wed, 5 Feb 2025 18:27:40 -0800 Jacob Keller wrote:
>>> Not sure either, the locking in this driver is quite odd. Do you know
>>> why it's registering the netdev from a workqueue, and what the entry
>>> points to the driver are?
>>
>> Yes, the locking in iAVF has been problematic for years :(
>>
>> We register the netdevice from a work queue because we are waiting on
>> messages from the PF over virtchnl. I don't fully understand the
>> motivation behind the way the initialization was moved into a work
>> queue, but this appears to be the historical reasoning from examining
>> commit logs.
>>
>>> Normally before the netdev is registered it can't get called, so all 
>>> the locking is moot. But IDK if we need to protect from some FW
>>> interactions, maybe?  
>>
>> We had a lot of issues with locking and pain getting to the state we are
>> in today. I think part of the challenge is that the VF is communicating
>> asynchronously over virtchnl queue messages to the PF for setup.
>>
>> Its a mess :( I could re-order the locks so we go "RTNL -> crit_lock ->
>> netdev_lock" but that will only work as long as no flow from the kernel
>> does something like "RTNL -> netdev_lock -> <driver callback that takes
>> crit lock>" which seems unlikely :(
>>
>> Its a mess and I don't quite know how to dig out of it.
> 
> Stanislav suggested off list that we could add a _locked() version of
> register_netdevice(). I'm worried that it's just digging a deeper hole.
> We'd cover with the lock parts of core which weren't covered before.
> 

Right. We could add one, but I think that gets pretty tricky as well.

> Maybe the saving grace is that the driver appears to never transition
> out of the registered state. And netdev lock only protects the core.
> So we could elide taking the netdev lock if device is not registered
> yet? We'd still need to convince lockdep that its okay to take the
> netdev lock under crit lock once.
> 
> Code below is incomplete but hopefully it will illustrate. 
> Key unanswered question is how to explain this to lockdep..
> 

This might work but it seems also quite ugly, especially if we have to
make lockdep happy with it somehow.

One other option would be to simply release the crit_lock the same way
we are already releasing the dev lock just before calling register. That
leaves a possible gap where other code could lock and then do something
in the window where things are unlocked.

I'm investigating whether thats even possible given the work queue
design and flow during initialization of the driver. Hopefully I'll have
an answer soon.

