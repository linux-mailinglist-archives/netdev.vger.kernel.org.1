Return-Path: <netdev+bounces-170676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D940FA498A7
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 12:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C3871895839
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 11:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E414267B8E;
	Fri, 28 Feb 2025 11:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g9XUzlu0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A31266F01
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 11:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740743971; cv=fail; b=pDHIf1m+LtUKSkgMclmHAwHZ4acg01GQfx/bFuHkRB/nRu/7yXwzJ11HWSRMGKVDq+oRXrPtbjlXybLRbsL7kNsunR/B7x5Vo5LpehatLqYFwyUd798GKoaQ+P3QTWJinGO6s5yR8GNPthxroRHN4TcxjRbRFPCiGfMZukVdRA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740743971; c=relaxed/simple;
	bh=vNSmICYcJn27Eelaoakk4NeQxoDWKfwb9OS7ThYbEGY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sveyByK4US44WGGhd0d9jo4vCO5G1Bqt6JBNQr3aZi14rc0pWfkIuHJGqcn3X7e2MEm0cvYCSz9PqtO6Vod5lJk1NY+NEijMFEBhD9CQMnEOGTDDXrYmmi00ScKtVo8b3ikQZRsXFqzvmI8OfJBIvnqyGDy/wPpTbg/fxwhgct0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g9XUzlu0; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740743970; x=1772279970;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vNSmICYcJn27Eelaoakk4NeQxoDWKfwb9OS7ThYbEGY=;
  b=g9XUzlu08zbyYCXJj2nvxktkUb7pI8eH4CUu46FPfVZCrU2vO/eUSIr1
   mDb10xbpy+X+OvHy1gvrXWvhJiDsQ4OJPBR89eQYzL19grk/sX7gxGH/P
   deVau25v9jcHTD/nu6ZKVaWHp+MxXvEUUwTn9TUcfTdtXn1jDP8ITyKHm
   7d97R4d8tP3UBTPNfsUKEVNFU5QlKCkVqhiduDOprlCdKVHlUa2FjXjuz
   iVEMbT8XWAb1qGRTt1SQV0Bdn4ytfScTx9Yl44Nh3P/IotRCcj9RbsJsA
   x1eGI0CkAjSn1p2spbYuRNx5Va8amrz+bRAATUZZwqgZKm2zNQtidIzQA
   A==;
X-CSE-ConnectionGUID: KBOXnIJBTNW5q8b5pjKlwA==
X-CSE-MsgGUID: twl8cTdQRTysGyrhY+rQ8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="40845540"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="40845540"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 03:59:29 -0800
X-CSE-ConnectionGUID: mJVA41IjSK2v1FbQ47I5mw==
X-CSE-MsgGUID: 97S0PohNSgWXf2GF+buNIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="117079312"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 03:59:30 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Fri, 28 Feb 2025 03:59:28 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 28 Feb 2025 03:59:28 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Feb 2025 03:59:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XV4Q7B/KYdjceisaRLB1rfwEe21FwPMYJ8PlCSAsagCP+FAYqZjb4rJkMvnGqBIh84VjZihzaLYz6xpQ0O0iYNePbcfcRi4hVaISLKv1ykAaj8fe14PZL7ZU5H8gDN0uAMb3txj2dbySIKMCLj+oFUoJ5rAYK0q4RKKG3HPUmS2bc3QdTxPZ8pEhhspamKHUX9u01Dre9FO33AUMz7ONGkk8Cacbm6Thp4zjArtFDSIKFbIfWJA0T7ssqvd46pUSboEHIxVv3+msHCs5sPbterrNMSiPva3Gmg5YEkQ7a60cKHG92ObgW/Gm77jzJvoKG0AKWsR70nhHQH2YtH9sqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SShvc+ImMJ++T3HvEuj9goSOZizw7eouoH3q83icVCs=;
 b=uGT/efwBIYM9J23QgcoJcuC1T3313X4dwSFGj/LPRYiJhr5APoozhTdVEXkCCTAYLvM8SCqKf/Met5kcH+W3d07llpIGcp5TdPshSPJBFeMRa6YHPhHCdwcnTTVDsKf1FR5t49HpD2YlmEdY054NaYcd0wjkidgHU+LAfvTHbl5sjbwA+DFla1+tXdrGbAr1ByZJ0/u2UnD2UESX3HFHclV8vSYHCn60ShfAAQ948+ONzo/2OmkeWc4YNGBMp945maeaPkPdnblqAx7vCgrc1cNigabPgSORQ1vsXIl7wrzuKDZQz26WcE1k7pIA88oUVJ3QkJVU0dEqUwnCSKw+AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by MW5PR11MB5858.namprd11.prod.outlook.com (2603:10b6:303:193::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Fri, 28 Feb
 2025 11:58:43 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 11:58:43 +0000
Message-ID: <56581582-770d-4a3e-84cb-ad85bc23c1e7@intel.com>
Date: Fri, 28 Feb 2025 12:58:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 07/14] devlink: Implement port params
 registration
To: Saeed Mahameed <saeed@kernel.org>, Jiri Pirko <jiri@nvidia.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	<netdev@vger.kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
References: <20250228021227.871993-1-saeed@kernel.org>
 <20250228021227.871993-8-saeed@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250228021227.871993-8-saeed@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI0P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::9) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|MW5PR11MB5858:EE_
X-MS-Office365-Filtering-Correlation-Id: 1572d8d6-4fe6-4287-6542-08dd57ef3f9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eFJ0TUxUdEttT3ZrQ0s0ZmZJejBIaGdKUlNVQzVTb2lNTDNlOXd5UDZET3JH?=
 =?utf-8?B?NlZtdzM5OVhKVlQ4RHA1ZGlISUFWTjJadmI2T0szYkpqbTU0VzdiSjFCV0pr?=
 =?utf-8?B?bGNzU3FYQlJTRENMWTd6VzZvZW1WYjRBNnVESjZLUFRnTkg1MHV1WENMSUFV?=
 =?utf-8?B?cEJmaE9BWi90MCt2d0FVZUExMTh2R3ZTZDRXUUtGYnVNMnVkd1ZMSHVKM1Vx?=
 =?utf-8?B?WmJFY25nY2hOZm1URzNaT245cWFqT05ZeHhxQW4wVFBuYndnS2UzaEdBT21k?=
 =?utf-8?B?dTJRV1Radm9VR0dHK0xMdkY0VExVcUtuY0hmeGlBYW5mR3UzUWdBMVhMV1lk?=
 =?utf-8?B?akdZZXRmdFcyWEhEc3NHcWY5YjBDT3ZBWXNndithZzhPcVJTcHNBcEs1OHJF?=
 =?utf-8?B?OEk5ODU4Mnc1Nkh1MFpjNzhlWmw3RlpkQ3RPV3A2MmZUeHNFaHlERENSeDI0?=
 =?utf-8?B?WHd5cm1iWWRDUExwY3BrbXVRL1h6Sk0rQkJYa1pwcWtkazdqZjFGNlJXaExM?=
 =?utf-8?B?QXZkZWh3dk1wN0tiQUNEVUhxRTRMckdWdzNwMHU4NElXaHVUMy96aFNQNXBm?=
 =?utf-8?B?cjRvU1lYQlc4cTZhQkdUbWlPTkRycjQvbUF2R2pFT2dtNUZubktGTnV1T2pD?=
 =?utf-8?B?bEdCZ09kWlNWMUZheXZQbVN2UTVlNVcxUm1zeG9JNGdhMnh1dFNkaHFxWXBN?=
 =?utf-8?B?aStRREl4Z09JWTc2dGM3UkQ0SWJxNURLNzlmR0FBQUlsWWVIZmFYbzZNMTFK?=
 =?utf-8?B?TE9hUkNyVFh4dm1CK3dONFBiUFBETkZ0aytTVjhjZUlhSzhNRUNkajlKT2NS?=
 =?utf-8?B?Tm1HUGdYeVFJajF1N08wNVNGcVRUeUFCQnRpMVA5RGpIS2pWTThqQ1NIUGt4?=
 =?utf-8?B?RE8xQ0x2OXVRMktyVjcxVEZvNnBWNHF1ODhvNHUvU0tLRk82QTZVK3lRRmNo?=
 =?utf-8?B?ak9aRVE4enI2ejdxOWNtMThpTm0xRFZpcE1nNVQyTGpNSS8ycmZOWGw4eDQ0?=
 =?utf-8?B?ZE85ZU1aZmxSbEYwWWhSUW1lU0tWVkhOc3RmNStPZy9jNnVscEt3ZVNTUmRG?=
 =?utf-8?B?Ky9pdjg3UCtMM24vUHVENE5VSVVHSy9FYytieGdZRGZHMkZZemJxSXNpdGRU?=
 =?utf-8?B?Y0M0VnNOL2s3RjlyRzNUQTh5UXVvSXpEbVRwS0xGTzJoQkM3dUFha1c1UlVt?=
 =?utf-8?B?aklYcVQwMStOUE9WOE5heXZ1UGhrb1A3T3Q4ZjAwdVUyNDZ6OW1ocW11REFq?=
 =?utf-8?B?ZlIrVFhVVm5JcTc5NEFISmhHc1FZL2F4UzNwdUo4NUZodE1NWVkwYnBiL2hm?=
 =?utf-8?B?Uzhmb3NWZ3BaeWNzMkFaUXB5bTR2RkthVmY0M3Z0ZFYvRmJZcHpMdWZQQjBF?=
 =?utf-8?B?dTdVNEhKWC9KOCs5S1p5b0Vpc1czT292Vm52bFBJWW9Sb3pBVTI2ZkVYaWR4?=
 =?utf-8?B?TDFSQlFNaGpsZEhmT1BIM1J4djVycFdXd0JUbVBxYTNrMGxneC9GT1hyRTUv?=
 =?utf-8?B?Q1M3bnFscC84TFFxODJVV3dKQndqbUNBbjFFUVBUbXUxWTZPSWR0WWZsNlNH?=
 =?utf-8?B?d3ZhZjRrUHVTRXhhYkxhUVpsQXEzWEw1eUc2Vzd6UUFWT1N6MVVuU0ZCbHVl?=
 =?utf-8?B?emJFeklkY1lPd0ZCaFp3cWUrQzl5RHBzMkphQkhKdmFhWXJ0ODJWaWIySkMw?=
 =?utf-8?B?MDd3Z1JWeTZMNGdKVmlXTFYyMm9GYzRicWpMZm5kd29rdG1rV0dhNkxsWFJt?=
 =?utf-8?B?K2VWa0Fnc1A4U0xDQ1g3RXhIYXlYNktIVXZBK3BDbVlGM1kzUG0wL0pXcHVk?=
 =?utf-8?B?ZmhocEdQZ0NCbm5mSEF4U1lrMnRKVm5SMURrbDA1TG9VcDlYeXJOVnN3SXE3?=
 =?utf-8?Q?KF6pii2doG/LF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDNURXJnN1NUa1JOWkR4SFJEbTRMSmNSNGFxUWFYa3R1eVp6OWhTUEVDVU5M?=
 =?utf-8?B?VTBFdUNMM3cxTFhveG92QjJzVHJ5cjRKNHpFR0JjWCsyVDYva1grTXl3ZjFM?=
 =?utf-8?B?MzNBOGJiZGwwUnNvZFIxczREZ0huY2RKR3ZBellSZklGTnlMOFhkV0FWRm0v?=
 =?utf-8?B?TXVxTjVmK0NxNEZEd0VQRU9xRFJmY01xY2F0a3JQRlQyQlNpU3pGV0pTdUNq?=
 =?utf-8?B?WXM3eTNqcFoxOUhVRFpaazdsN1lLZGwyUWl3aTB6RkRBY3daZ1VISTh5TFhy?=
 =?utf-8?B?bDZ6VlBsNHJXclNmNTNWMVRjVU0xandNUURZUnJHU3NhRnVnUHZyUlc0Y2d4?=
 =?utf-8?B?dVVnZmwzNXorVWxidGxTem1CTGhEb2FibHQvejBsUWFLZ1pYNmtTdzAyWVR0?=
 =?utf-8?B?Y255SXRZb1NwcFVldGVTR0VMTXBKOUErMXhvaURUYWVaaC9rNnBKMmJVeFB1?=
 =?utf-8?B?NUJ4TU1zYnNnb1ZMYVhCbElVOW9EY3NJLzFDSFhtZXlFM0lZQkU0T0lyS1BX?=
 =?utf-8?B?Z1RQc2QwSVovZVBxUG1nZnRQc0RxUmE1ZkIzZW4yMmluUkRBQktEdWVLbzY1?=
 =?utf-8?B?WDg0cStPQjhjeWNBRjFpazBuMTQ2d0VscUFPdU9rTjNoOWNraWEyZEgwS3dx?=
 =?utf-8?B?eTkvQ0N6cTNPZXkwWGdZYlByYW9zV0pyVDdBVEJSVjNuZ2VRc2ZpZ3M5cWRK?=
 =?utf-8?B?MW9MR2RlaXJGT3U4KzZvWEZGNWtuMzJSbjdUSWlySjBhcmVOVnB1a2Qrditl?=
 =?utf-8?B?Yk9sa1B2OXg5bkVXb0hBdlFlc2xWbGgxWXRmNlVwR0srTUxTWHE3cWNaaXM0?=
 =?utf-8?B?VXlLa3NiVmlzVi9OU0diUm5ETzhiWEVYaGhaUFR6OE9PZC9iOEhILy9rZWVi?=
 =?utf-8?B?ZzZRN3Y1UTJjWjNqTzlleFByblFGdU1qeEVoYVdEMXZNSFJOZTBJSndpZW9H?=
 =?utf-8?B?Q3M0VjI2YjhLbGU5VUpwT3dOelZjc1lTbTNXdjdBU0JJOGVwVEQvWkw0QVF2?=
 =?utf-8?B?UUZZMDE2NjJ5YnJLRzAxckdubUpwaU4ydzhjcjU5QmRYeW1GUFNTYmc2Y3dp?=
 =?utf-8?B?UHpuK2ZhVnI3cWlJeWliQTQ1aVIySXd6OHVHdFFJdEh6NTN6emVJZHNKczNJ?=
 =?utf-8?B?bXJTVFI3dVVGdWxvbTQ4dFlscHgyT3cxY2JDcW5IT0xIMHg0MUl0NTJmNjMz?=
 =?utf-8?B?N0t4OFp5allpUDB2UDF4YWJTSms2aEN6Rk9LL1cxbSt6YXV5bkYyVGpwOVRo?=
 =?utf-8?B?L0VWRmErUUROOXpDbUFpbmloQkRhektlckRlR0JHYUFxWE5QaWJGYzNUZldF?=
 =?utf-8?B?eEdOVWJuSDFnVlhpaTlWWDhQaS92VG5adzNSL1BOYW01RDU2emxZOCtKRDdU?=
 =?utf-8?B?QlBrcHFxZ21QMlRoUGdJL3UzbjFSRUtaV3FyMlQ0RkxlMHlieHAydVo4bUw3?=
 =?utf-8?B?N01UMzJuMTNyRk5zaC82R0FpTmF4aWRteVg3YXBxa3hBejgvMUw1YTdjbUxX?=
 =?utf-8?B?Uk9wU09EMkFBWjZoNFhxa2d1TXNpZHRBSEhhVDhmNmtjK0NxcW5KVWVyM3hB?=
 =?utf-8?B?MTFvdFRvbHR2TjZEYUZYTk15WFkwSEt2RmgxYTJaenFvQWhIb1RvMWZSQzRU?=
 =?utf-8?B?NWNmbmVPT0NrK2h6TnJSVTc1ZGx2T1gyUTcxamNqNCtIRy9OOWpQOUZnRG9Q?=
 =?utf-8?B?RmdhV21mWWh0djNTSVlubUg1U2djYkg5emtZNkRNODFZY0tPSnl5bm1zUnNB?=
 =?utf-8?B?V0hEL3haaVNYOTJtVGtUWWZzbUxmc2xwb3NiUzNZZnRNYlNPVFN2N0hvS3V4?=
 =?utf-8?B?ajNpa2dwd3JXRVhpU0o2NGYxOHB0Lzh3NENHRHNBb3laNGNTODkxRXF2QXJh?=
 =?utf-8?B?c1FibVdpMEE1Rmc5R0ViM0xCOVlZSDlRN0crTndFRTM5UGgvR2kxZlJoWWxw?=
 =?utf-8?B?V0hOa08yOUU2MTlzVmZSTGdKMVBFRkd3elJ0SDhLNHFhRlE2bWlaNGl2c2dy?=
 =?utf-8?B?TWY2Rngxc1VQNEFZSWNtS1J4WVpMWDJXWHA5OUtNZ25JbGRQWkhPV3k1YnBp?=
 =?utf-8?B?N3pvcy9SNHVZVmhtcUgrYnZ6VlIvbkRNQlovVXpxdUtvekQwTzZrNDlsdEkr?=
 =?utf-8?B?ZSswdEFWZ2tUTmFkVnF0Z3dOUkZVbGl2VXpEdDhJZkJNZTZNay9NNzVyanB6?=
 =?utf-8?B?Tmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1572d8d6-4fe6-4287-6542-08dd57ef3f9b
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 11:58:43.4258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OUrpHIW65WIEcRAd0h1Ui+DiwxV8jw78C85xRPrPx82Fu5E3p2apg/Z2oZGi2tmH4O1jl1hRn586LgFTgWuZlzVw9BNbeL3+knPdEfgxtIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5858
X-OriginatorOrg: intel.com

On 2/28/25 03:12, Saeed Mahameed wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> Port params infrastructure is incomplete and needs a bit of plumbing to
> support port params commands from netlink.
> 
> Introduce port params registration API, very similar to current devlink
> params API, add the params xarray to devlink_port structure and
> decouple devlink params registration routines from the devlink
> structure.
> 
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> ---
>   include/net/devlink.h |  14 ++++
>   net/devlink/param.c   | 150 ++++++++++++++++++++++++++++++++++--------
>   net/devlink/port.c    |   3 +
>   3 files changed, 140 insertions(+), 27 deletions(-)
For me devlink and devlink-port should be really the same, to the point
that the only difference is `bool is_port` flag inside of the
struct devlink. Then you could put special logic if really desired (to
exclude something for port).
Then for ease of driver programming you could have also a flag
"for_port" in the struct devlink_param, so developers will fill that
out statically and call it on all their devlinks (incl port).

Multiplying the APIs instead of rethinking a problem is not a good long
term solution.

