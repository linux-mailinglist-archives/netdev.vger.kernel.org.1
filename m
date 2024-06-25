Return-Path: <netdev+bounces-106348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E34E5915F24
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 08:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 994FE284961
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 06:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181AC14658D;
	Tue, 25 Jun 2024 06:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OlWOX7xy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FD31459E5
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 06:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719298634; cv=fail; b=lL0iAbukM4qLZVLf1Po9i8RjfRogisd+H8WVS7a5Rla09LUgDEBlhqmDOs7R5B1VR4oatJJlXGlzO8Gy9Lte35hD1NkJB99Sw/YHRRIgnRuATQujMG4V049fmEU1W8dxssbLNkrJzz2lJ95rYkOlj3p1lrH4WcLfvEiEFCjF14Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719298634; c=relaxed/simple;
	bh=Y7Z6hpcDJxz2EvL+43TkBhNwy7/lWSR598yI4cL29KM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EqW/ZJt1K+J/JGL075U2IPhZmczcIMkscJPGsuCoTzA23Dq+pIn+Q+oAoPLdKKmkIo9fV0KsZL5U5rEGLsfgMA65PGtgEn+8r9tfRd8pHKv9ROuXFT/7N02X2LDvP6QJXIcgunkc+SwTyqxo6zN+I8xVRToBWs5Di+11Yft7Zz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OlWOX7xy; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719298632; x=1750834632;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y7Z6hpcDJxz2EvL+43TkBhNwy7/lWSR598yI4cL29KM=;
  b=OlWOX7xypvrxD3xrTBG+9wd1AOLyalU9teJhRbPlTnofP92hoCq+zMrS
   iaiRXxQktLvEGOX2764k0v1ADG90qtO0dmTuIHNqcLUJ3DoiJVHqCCClg
   sBPaHEfApEg9RPPwpZsv4PCq1tDwmkF/Osim/IHf5dIHN/sjvezLpjOic
   bGtRo7MA0sBC9kCU92qZ7bJ41dYdWoN7guG7RxxJjE3ChtT/WK9tdzZVl
   /8TFbvl2kXd8C2PQJVd/DBJpL5hTG8J0PtHStxaKDVYGGJQRFj5GK863c
   rHATDRx8t5phyHjJqmLtNs7jU/qsZ6JNbMizKj+3hre2duCuyIQ4uk6Q2
   g==;
X-CSE-ConnectionGUID: rhOPdOgBSiCQ4RPwc2C3Xw==
X-CSE-MsgGUID: Wn5UaE/AR9qOZfT2zXYwYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="16121169"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="16121169"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 23:57:12 -0700
X-CSE-ConnectionGUID: 2mCaiTtgTLWPHqf5upLA3A==
X-CSE-MsgGUID: 98AgzqN5S1O0P0KELHhLzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="66765794"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jun 2024 23:57:11 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 23:57:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 23:57:10 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 24 Jun 2024 23:57:10 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 23:57:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8slft58PykrQbQOa79WADuW87j4FSF/HnmvYHZ7Rn2ZzGdskFqBZQG0TZMSdkmn/cdl+K72D2nH/dmosiVFjMl9lIC+Nsd0KS4Mb/ed+677yjhdImjPs5gT/zpiNDc/49R+qFkzSZSkNvU8y8DWEfqmKZMUlorzpvHs3AcHZ3MgYX++nedDDyOnG8d1BdJhdbG4ng8S02AybPZ01MOpSWhxDzuYs3fHB2E3oUJdPjxGn0G/OruIhy9Ap8ITAV0h4EphugzPaiyOPFEUXZO3rU+wOSyKEQf36IeycBjKVg177T7JJDG2sl8nwz/woKphHm3W/28RQLQc0t4Ruw6nsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkn9KdcES8S38x8AigdLFOtIWjQh7oCrFa7cJJXVX4U=;
 b=kJmInXmeIR7Y8JhuBkYN8kpIrMj6H1DnrdPJvTcuy7KC4O6Iwm4zj7DzoKhJU7w8OZTvUwTwUU7YhmQWXo5wIe7KQirWP+YN/T8HfdmSuZ71c5HWSPx9lLnACfuf91SmgP3ug54Hb3jq1zOLV9lnDEToDSI6ja78XvE446M+EReD6Vfzk9s6ViTiKqbfFuEdYtO3aN77HnzFQ8kwwjqqKA/GMv5gv7uT+vqxXSn84DUHXlTUQ24n4If1O2VSXwHQVUTixh7t3qaGOkwdIeYJZhl/cIVoCW0Ia/msqXvdtqQLcgj9DKAH7FAePKSVW9fh4+EEzV58FsOV0QAw0JjFqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB8086.namprd11.prod.outlook.com (2603:10b6:610:190::8)
 by DS0PR11MB6422.namprd11.prod.outlook.com (2603:10b6:8:c6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Tue, 25 Jun
 2024 06:57:08 +0000
Received: from CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::984b:141d:2923:8ae3]) by CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::984b:141d:2923:8ae3%6]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 06:57:08 +0000
Message-ID: <b8d5e6c2-02e2-4912-9ff5-e19ce1b75e02@intel.com>
Date: Tue, 25 Jun 2024 08:57:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/4] selftests: drv-net: try to check if port
 is in use
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<willemdebruijn.kernel@gmail.com>, <ecree.xilinx@gmail.com>,
	<dw@davidwei.uk>, <michael.chan@broadcom.com>,
	<andrew.gospodarek@broadcom.com>
References: <20240625010210.2002310-1-kuba@kernel.org>
 <20240625010210.2002310-2-kuba@kernel.org>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240625010210.2002310-2-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0037.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::26) To CH0PR11MB8086.namprd11.prod.outlook.com
 (2603:10b6:610:190::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8086:EE_|DS0PR11MB6422:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b9d1d93-6090-4549-85ef-08dc94e407c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|7416011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmdPQ2NSSExuYlBjSzhVN1p3cVNSZmx0ZHBFUGY4THc1NmluemtRSE9meldW?=
 =?utf-8?B?K3BZeUNSOUt4UEY4YVc1NTc1dEh0cHFFZjNHWG4xaG5GQWZsY2NlRHJUYXBP?=
 =?utf-8?B?M2xIM3RUWEd1S01mT25RTURVdVYyb252MmhVMmRnQzBnWkxQVGl4bGFYcWJ0?=
 =?utf-8?B?VVpza1VnMjlOLzc1L3NSQlMxS3l2OGwwRTI2eGZ1cVFENWNHZlRsRzM4RG8x?=
 =?utf-8?B?U2FNUEVyYlZLYnBROXBQcXF1TWZsbTFuZ1R5Ky91T0pNSWhPWk81YjZWZnF1?=
 =?utf-8?B?UE0rTTRGWEI5cUozMTBTR1J4TXpwb3ZCekxBdFlJSE9IZDIweTk0MEMxM205?=
 =?utf-8?B?K0lHSnBxWnFVTStCK1NrcnNRTzIzZlJ5Z3N2M01sT3lRR3VzWGdkaWNXRUh3?=
 =?utf-8?B?WHk4WXF0ck43Ni8rNjI3K1hSMjJnMVFEbWZ3cHVINXNTWkdiMjJqY0VIUXRk?=
 =?utf-8?B?VCtpQVNnbmlNaFZXR2N5cXprMDZGcHJtQzBVenhjd09vdUVFSGxReFc2N05z?=
 =?utf-8?B?TGExMll2RjNXKzdmN0RDRjcvSzhmck14bGcwSEVEakRXM280YksrMDFabGg1?=
 =?utf-8?B?a0x2Y256eGVxT3BDT00vNFBCdkhBRjBtMDVKSUhONk16QS9qYytIdVhhSW5T?=
 =?utf-8?B?RHgyWDR5OSszanVrNkQ2SXBxeWxFUzI4OVlKUm9BcHE2VDF0S1VrTHZ5K0ZP?=
 =?utf-8?B?MGhJVGlGWlo2STNNUDRCVzZrNjZvS0VYczE2eFErTzY2Z0liQ1BqOVVPLzhV?=
 =?utf-8?B?VTBPNTIrZXhnRkxVSThnaVpxaVFVSU1yQ3d3UXZGM3FTa2wyanpVZkU1bVc0?=
 =?utf-8?B?ZjNCdzZFcHRmd0I2bkliRVUzV0xzc2pCV0hEY3pSVWxCb3Z6Y0E2OTFhcnMr?=
 =?utf-8?B?QmFIWEE2YkNqRzBNdlhnaDZzTm5hdEZuTHkxUDRoN3d6OVliVFF1OGRWMDM1?=
 =?utf-8?B?U2FJYXdIclZYQXlFQkFUcnh2eXpkaUJ3S2dTMDFnVDFyZHNEUVJYUDV2SmJF?=
 =?utf-8?B?L3h0UzRsSUc0aTZMRlFDSVRsVzNjWHd5M3EzRTRXZjRHcGd2TWV1bkZNdzlN?=
 =?utf-8?B?K09RWmZBT3pYZi9RTFZia3VyaGhJcy9Eb1J1UHNNNy93aG5CajViTDJPNTVW?=
 =?utf-8?B?VkVmYS9aRkRHR0VETDEvMzdVb3kyOEYyeGZZQkxyNFo5d1ZOaHNXZUxHSjBw?=
 =?utf-8?B?SHdOdDNZVEZZd093d25RaE14d3hHbEVkUU1hb21QYzg4M2xQcmV6OVF4Ymh1?=
 =?utf-8?B?ZHNtcmpQUmhCd1dBdkFHc2M2dURaTHNXUjJOYk9TZTNFblp1bitzdUw5Rmhi?=
 =?utf-8?B?RWE3c1BFeHVPaEs3ZFNDa3M0WE1JN09TVWRXSkx5TGwzMkdNY3l6RzR4djM3?=
 =?utf-8?B?WVdmWWNwWHJHOGxoZzI3S3h0Qm44MGVnUk1mNWNkNGtKblNTVjU4V2E5TzhQ?=
 =?utf-8?B?cElCMW9MaTNLRU45ZmgxbmN1VnhUdHFKNFJvek5WUnZrZXpuZ3RadzBkZzB5?=
 =?utf-8?B?bUVMTGdiLy8zSnFOMlZ3SnlBZElEeHFVNVRXVkF2a242MU1OVlJBbWlsZGVS?=
 =?utf-8?B?cEwwa1JlNUZObHZsclVWajhCeHArYW9XTE4wczlxbVdoUVZvbzBKUmFKTmNz?=
 =?utf-8?B?a05tZitrOFdXYmJmTGd6Rys5a201SXdTc1p4cEdzek85TGx0bWk2d29rd3B3?=
 =?utf-8?B?Y0Q2YWp4eDE5R0NMTDhEOWd3aTdTMkp0Q2liSW52aWhOZ3JRSGFkbGhBVnhZ?=
 =?utf-8?Q?O86D8RfrEWbHKohoucoOTMdf1Hh7kFOu5w7RD4i?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8086.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmZtVDFlSEt4THZUK0I2Y2VwVmVpZ3duNUNZUCtqMEhCVEZKaG1Gem9TSFlW?=
 =?utf-8?B?V2ZZd0ZqNTlrcDFrZk9hVmxzcS9uTms2WG8rdEcwMVMxQ2RqODBrdzYwZ0Vp?=
 =?utf-8?B?am5MNmpza1Y5R2kwTUNWeTJrRUxKaDRGcVVHWXhNZHVCL3ZUNkhXVHdkNEJV?=
 =?utf-8?B?N0ZzTHFjdHllS1VqZU1yY1RxOStyZEhBUitpd0NZc2Y5N3FLdHBKVzV0OXR4?=
 =?utf-8?B?bjZTemRYbGNJNDlucnV2TTQvTDJjZEJ3azFhcWdtMGdoUXFVclpRWDBsNU5E?=
 =?utf-8?B?L3dTQ3lQZDNZRUxDbTRDYm1TcVpkZFFuSnlrWTVDQ0wwNldvRzNIWXNnQW8v?=
 =?utf-8?B?ZHF2SXJvdjNEMWN2UElkUW1MbmUxWXBveU1qenNkdW1GTTcvWTFmRlZHaGpu?=
 =?utf-8?B?elJXdGFEY0EwWDArZ2o5MXl6RTRMbTRpaTEvVWdPVFl1VmROUXNQTmZ4K2tP?=
 =?utf-8?B?aXh2MUFIVElXL1hxbXFEUHAySzBjNUk0NTRNYzJNUXZ6S0xESXlUd2pHdFpB?=
 =?utf-8?B?c0JrK1NzRjNoOSszeE0rVkxZQzA3ZXBnbkwrVDQ0MDdGM3YxTTA5RjQveGl6?=
 =?utf-8?B?bnl2djYrZ2pxdE1xQ1JiVWRpdFZ6T2RhMjNoVUx2QjVNMHFvSitqb3NPVDZO?=
 =?utf-8?B?VVkzUGpqcis5OVFhQkl2L3FTOTFMN1JQMjMrNTVPS28vWFBRTlNFMkZuNllC?=
 =?utf-8?B?QkpHM3RtUjV4R1VGamkwcDBIMWN4c3VlanhpOWZoU1A4ZWNGUGxKcUtnLzQw?=
 =?utf-8?B?KzFzMnFRYlk2M3dpaUs1MHJFbWRhWk5Wc2Fyc09Id3NFSG5nbDMreVJjUVAv?=
 =?utf-8?B?TnJCMGkyZ3BiUFhrV3dMTk52Nm5EVHdnUW1XdG5rbEExQmR4Y2YxZUcvTVpk?=
 =?utf-8?B?R1RwaTNTaEFWWnJhSXJaUmQwUGpwanMrM051SDFGQkdEUXV2MnhJZGIzbWly?=
 =?utf-8?B?R0xBY0dUNElMZGttZkJOU1ppWTh3OUNVRnhFdnJBU3cySlJ6YStqVU9DcUVQ?=
 =?utf-8?B?bUY1d2xhOW1OU0U5RU1MZWxLN3RVL3VKbzlYR2k5a2tldXNvWXFPc3B1MTFH?=
 =?utf-8?B?WWoyMkllRkdlV0ZuVDcwbTg2MU1waG1wVkRjdFhJTzFBeUlRMHVnWU9PVGZn?=
 =?utf-8?B?OGplVURmQTczcC9Eb0RFN0VUREdRVSs5K2JRVWJ2ZWlYSkk3V1ZEcnRaa3B6?=
 =?utf-8?B?SDNpZ3B6andXbW4zQ3JDcXoxRUpZWnN5NkN6VE1oSmc3K1hzaEdRaGo3Mkpq?=
 =?utf-8?B?UnBuSHhUUjVKRDVXdGJyeEs2ZHdCOGY4YnF4ZkRzdTF1QTlZbmpZZk4xUEgx?=
 =?utf-8?B?aFJKVkxqVys4enFvQ2wvNWFKU25QdHFaMkhsZWVtYVArQjFyZElHbmNVS3Zw?=
 =?utf-8?B?c2ZvSXYwNU5DZ1F2ZmYxVTJDOHZ4K0JpYWVjem43Wkhlc1ZpaWhUTFJhWGJG?=
 =?utf-8?B?elk1UWhrYXNrQ1pmZFZEL2ZYY0JFTkhBVWx3d2hyWnFJOTVtNWFkUHEvNFZl?=
 =?utf-8?B?ZndMRjBncDFzaDgvSXc2M2lwRWpsbFlBeWdDOGR1a3ovNmFiUGt5WU9wVm8z?=
 =?utf-8?B?NlYxK3FuRlE4M3FqaWkzYnVPV0pkM3VPWVA0ZElQWDZyRU0wbFJSaEhXc0Yr?=
 =?utf-8?B?dCt3eTZiZVFUSW56a01wV3UraUk5Y2hZTXk3Mkt6eFJNb1VxTFlTQ2V5NkpQ?=
 =?utf-8?B?OGw2c1d6cVBvWjE1TG03eFZKSzJScy9weVN1KzBBTTRvY0FzeXIrVGRzSVRa?=
 =?utf-8?B?d3k5MFJCMTJVM3IrYjJ4VWlGaG01ZUUxdndIYVBCY0lhLzhLK3lNY0dkOWdT?=
 =?utf-8?B?d1dicTA1a2lxRmN6TVRnMzJqajhMaUg5T3VlRnhrMHFQVXRXRjI1ZkpSZWhr?=
 =?utf-8?B?TFFWaC9HeXByUGVYVVhBbDM0c0h4Tm9iMHlYNWREazU0MHVMUVdzUlZVc2JC?=
 =?utf-8?B?S3JaWXVEb0pyQldQdkFpWUttdGFwRWNHbDBhVTFqMXhxcCtJRTg1S0V4VnZY?=
 =?utf-8?B?UmZFUS9tWHN4NG9HSEJ5dXpSWEhENFRsUDZZclpweUFEQmp1Ry9JOG1mTElz?=
 =?utf-8?B?NTZsTS9oSjE1ZEhzY1NjWEJUSFpNWHFZVVZvbzdBdmJnaTh3MHZyb2QzQzNi?=
 =?utf-8?B?ODhsajk3V0ZnQjUxdUt3bVFMdHlPMGNYYnhXQ0tlMy9OK2tPemdhck02ejFl?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9d1d93-6090-4549-85ef-08dc94e407c7
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB8086.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 06:57:08.4662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7IarBDhsilKWsl01k6bVsmutTKvH9raNGG6Dh4M/GYprkhK4UGR8Gaqz/aOffhcdfzw7VDxhaE7jReQH/hFEIhFtQMDXPB3D6h1InsyRNvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6422
X-OriginatorOrg: intel.com

On 6/25/24 03:02, Jakub Kicinski wrote:
> We use random ports for communication. As Willem predicted
> this leads to occasional failures. Try to check if port is
> already in use by opening a socket and binding to that port.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>   - remove v4 check (Willem)
>   - update comment (David, Przemek)
>   - cap the iterations (Przemek)
> ---
>   tools/testing/selftests/net/lib/py/utils.py | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
> index 0540ea24921d..16907b51e034 100644
> --- a/tools/testing/selftests/net/lib/py/utils.py
> +++ b/tools/testing/selftests/net/lib/py/utils.py
> @@ -3,6 +3,7 @@
>   import json as _json
>   import random
>   import re
> +import socket
>   import subprocess
>   import time
>   
> @@ -79,9 +80,18 @@ import time
>   
>   def rand_port():
>       """
> -    Get unprivileged port, for now just random, one day we may decide to check if used.
> +    Get a random unprivileged port, try to make sure it's not already used.
>       """
> -    return random.randint(10000, 65535)
> +    for _ in range(1000):
> +        port = random.randint(10000, 65535)
> +        try:
> +            with socket.socket(socket.AF_INET6, socket.SOCK_STREAM) as s:
> +                s.bind(("", port))
> +            return port
> +        except OSError as e:
> +            if e.errno != 98:  # already in use
> +                raise
> +    raise Exception("Can't find any free unprivileged port")
>   
>   
>   def wait_port_listen(port, proto="tcp", ns=None, host=None, sleep=0.005, deadline=5):

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

