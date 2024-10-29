Return-Path: <netdev+bounces-139965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 461289B4D0F
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 16:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C61601F22A70
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 15:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1993192D6C;
	Tue, 29 Oct 2024 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LbQu1EHX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744B518FC8F;
	Tue, 29 Oct 2024 15:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730214559; cv=fail; b=RVrNQMot9LW6SQrW3w/e3kkk2nbLtvz/UyRnjYAKoZBwgGiovg3Kcq2MoAb14rXm1D/JbyTQfss+YoJOK0jgnLErYiP72JLE05UZEe1unzEi2U/IfF1QBXFCxU0hAmwIxNFT2h3o/hkBZ2alRfmOI59ApdW4ZWiuiiKv64NyrKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730214559; c=relaxed/simple;
	bh=at3PZ+r5Io1hHNdFOTAprnAeypWB3wjWvUvyBBVgaQw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EBWui7r8fg7uV3xzkzNWp7G0SEB2HGxsVHtRsFBo8UR0DM259Qf5O2kk6OykEeZFLSwrw+7v8qTjVj1X3LsMVnqvGdbl3Z18O4nn6NEdvD23PIPJ5tI+5sHElV+jORFhb2IvTzp3Yly2H+HcljJpno2XsLgPECJqD/OWo8iYppI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LbQu1EHX; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730214558; x=1761750558;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=at3PZ+r5Io1hHNdFOTAprnAeypWB3wjWvUvyBBVgaQw=;
  b=LbQu1EHXJ/Z0NF+G07bAxVy36F2dmNbooXUIrwpn+LC8hw15UeQ+ZwU4
   uV1t0kZZzsL49Ud/c4sYIUTrtOXGCiBGkzYUPlo/3kKi9fGoA6BEa8pUi
   bmKGw7BipN50Pl4X4wz0DbJGvuugqFAp1GcA5NZznkyHRbAyA04ZTgd45
   sI2ncloe40/YODUYAE42cKYtvDHWZjAOYPc8nyL0Kgc0FAV5ykFn8xXHm
   uFBQ+UrkNQvuT4D/HRh+vGp0744Ged3rN4sMK8ZIn0KNATSeaYNBjoyZL
   9CoxGAVy3vsvLJQrKg8YWSyTkk3kg3sZST3EkuGkJbqp2VIv7ZrjNZM5u
   w==;
X-CSE-ConnectionGUID: Kame2YZbS1+CZDUquy3QJw==
X-CSE-MsgGUID: PHRk87DrRvWva+wloPkEVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="29313649"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="29313649"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 08:09:15 -0700
X-CSE-ConnectionGUID: +FhV8CyvRna5ySIc1w3/uA==
X-CSE-MsgGUID: 35AGZT4sSee/sa3IUUelBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="112795893"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 08:09:16 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 08:09:14 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 08:09:14 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 08:09:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2JyykPdpbMv6bHdCQoeY/MUAGq9aS2scO3e2Fd1HiFPypdRpSA9PwYXtmk7J2pdxCd2BPTJ9DUGIHMSLZAJzWuG++WWUhgeYu2lJmRo8yiQP117qNfM28/6aCUI+bNS0fPgtLgMsRNkLe9uCWrGvZcelVpnuB0qg0Apo8AnKmayj+bjFmY09Db/Q+pwTuw5YqUxVroBHdgRAHiMC5gov9bfb1UwGhXC/PwOtgD8E8KYw8D5HRGjz54i/tzKpK/O0JKdRMURtb5to/eozhVNkNvFaakHXw6aw7kPVrQb1HwAYMaLCjFsAvsDP09zy6wAV+WZyTcQ7OAZfMz2U1A5sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0lHwB12ltM3znmgWo2Tqujwwl0OdufkRgbgpnLtNAk=;
 b=xkgRviP4fa//b26LfYNWijgCFE5XSJVyOKs1XSe9+tKLhzk4L5ZD5wevtXNr++F6Cea6+FedfqETvcgQafwLSvatQBWpL3UPTlsDf3517mArDlflyLp/x8qQ7m5BYnj/Gbf/jdfTUz6NUf31WIZQHDSX8Kfce+aBIpOjTpIyAPeAekRVK4Y9QVSqhxv9D1jDIUczhX2zzTJJm4G4AHV/h8KyO6P9tFHQLU2xN0PyOaSgWQ5E76SOZMnwwbQxiHQnb1T9HZ/V7rmElQmOC/mPUGoDcKy3d2nc/Y/XW1gmCN9bmAi9GtCU4yoK1EIg+nQDIh0eFDuT4h5K+alH1Y90EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8722.namprd11.prod.outlook.com (2603:10b6:408:207::12)
 by CH3PR11MB7345.namprd11.prod.outlook.com (2603:10b6:610:14a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 15:09:00 +0000
Received: from LV8PR11MB8722.namprd11.prod.outlook.com
 ([fe80::314a:7f31:dfd4:694c]) by LV8PR11MB8722.namprd11.prod.outlook.com
 ([fe80::314a:7f31:dfd4:694c%6]) with mapi id 15.20.8093.023; Tue, 29 Oct 2024
 15:09:00 +0000
Message-ID: <d04a5dc3-ea0c-499a-b01f-86d0f1ad0e13@intel.com>
Date: Tue, 29 Oct 2024 16:08:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: ipv6: ioam6_iptunnel: mitigate
 2-realloc issue
To: Justin Iurman <justin.iurman@uliege.be>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241025133727.27742-1-justin.iurman@uliege.be>
 <20241025133727.27742-2-justin.iurman@uliege.be>
 <59a875a9-2072-467d-8989-f01525ecd08c@intel.com>
 <d3bce110-4b1b-44ed-8c1d-a9736a02f1dd@uliege.be>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <d3bce110-4b1b-44ed-8c1d-a9736a02f1dd@uliege.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0001.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::20) To LV8PR11MB8722.namprd11.prod.outlook.com
 (2603:10b6:408:207::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8722:EE_|CH3PR11MB7345:EE_
X-MS-Office365-Filtering-Correlation-Id: 9273cb9c-3518-48c4-ebf5-08dcf82b9e24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?STlCMEZOdEkrY0JQZTRWL0lmWWxGMS9GMWJDQnI4THdmZGU4c3ltNU5MS0Nl?=
 =?utf-8?B?V2xFcWYvaTlmTFprWUhvRklHZmpjYndUa3BlSlFXbUJmZlVsdkowMnRqazg5?=
 =?utf-8?B?V1ZSWWM4d28wS2YxZnIvV1JPaUFKNjBJZlNEY1h4Q0hHOGJHYmd1eFlDbTN6?=
 =?utf-8?B?aTJiVk1DelE1K2JmRE1lTUY4UlN1RTVxY284eThFeUhnN0U3TXNKVllzcmwr?=
 =?utf-8?B?ZjlBZWR3VXEydFJXZjBPU2owTVdCQXpPb2ZkbnlpUFU4blFrS21KQ1NQSnp1?=
 =?utf-8?B?WnNVdzgyTGxDcHVKMW5UZmNDVzNEeUJXYWVhdTZDMVA4akx6VnBNUzNFM0pV?=
 =?utf-8?B?b2FQcmFMMHNOTG1qM1ZtNENJR1VQK21mODJjc0R0eUxuN2VpcFkwNURIRU1t?=
 =?utf-8?B?Y25QYms0NFdJbkNwRzlaZCtESGlhMjZPWXh0Q0lnWFkxRXRPZWtadFhvejlE?=
 =?utf-8?B?dTRjRlFleWZtclJ2dUlBUWdCR3BsYmpKcjF6UmlnSkR0UzdwcVUzTldhaHho?=
 =?utf-8?B?U0ZkVkF4bFBETDhzdmdFN3lPU1Btc2N5d2w1eitNVW9RQXRTQ00za3JVeEVE?=
 =?utf-8?B?NHAwKzExWXRkTnJxUmhFQno5aXpmV0wxR3pERGF2aVBtOFR5YVo5aHFOd1R4?=
 =?utf-8?B?Yzl3cFVoZEU4dDA2WDRFVDh4UnNjSlhIcWlOWExueTBvQ28rTTJQNHd4NzVT?=
 =?utf-8?B?OHYzd3NSWHFVVlF0WEEwTDZRK1h5MzlIZUs3eGY4YWJ1TzBydlVTMW45cXdB?=
 =?utf-8?B?UVZVa012WlRMaGxQZktxaFNXNlRzUHRJZ0VYZWdDZlVCd0FFcWdURjl0a1gy?=
 =?utf-8?B?TnFCUHFEaGExWHI1a0t1WjBJaVUvTWtpeGFPSGRmWUcwSFA3elh0R3dSMVVh?=
 =?utf-8?B?enlDbWVFbHZmTy9hTk1hSHZYajJwSUFMc0laS1BCeG4wQVhrYm1jdHE1L0lF?=
 =?utf-8?B?d0hrR21IR1pIbWtFSXJNQ3lvczQrL0ZxWHNHem4xQUk3QmdXdjRsSzIrMWkv?=
 =?utf-8?B?UE9qRGxRTkFYbnlVZ0VnaEpaYzUyQ1kyOElrS0Q4ZVNNSTBQc0lZcHpCQmRu?=
 =?utf-8?B?WXJBaVQyVHY1RnRBREQzdUg5bmhzUDNTUGx5TVk2YkJlUnliMjM0Ynp6UXNw?=
 =?utf-8?B?clNjOVYzb3ZPZjMxM1FvWHN0RVZYV2ZPS1U1clBSaW85MXVwQVRJcDhOOGtv?=
 =?utf-8?B?N3JTelhTenVaK081alB2YzJIaExWWlhWRFJLd3E0d2FLV3ErZFFDWDEyNis4?=
 =?utf-8?B?K3kyZXJHTGNNcnRWRk1aWVMxc2lQaTZPSVFiZjUybTJpZStSVkhHaW10QnN4?=
 =?utf-8?B?K2tPZlc4Qy8yL3lxcVcrNjRPSXBqelNBOUNoY09BOW04N0hLUGduV3kzZUpw?=
 =?utf-8?B?VXJ0SHYzMFplOXBMS3RHbFNhMDRuUzVCSzVpRk1xaTV3WDB3Zmp0eUlMMTJC?=
 =?utf-8?B?MGczZzBwdXVmMElDdTJHaUk4U0RyeldzRjl0N3BZQTNXYXA0dzcyeE81Wjg1?=
 =?utf-8?B?VFRGRFFXVy95YXVpWXY0NW02cElNaThBTXN6RHZHeFYxWjRHN09YaFplRS82?=
 =?utf-8?B?Qk0rcGhsUEF1MFpIMXQ3SkExRFg3Z2MxM3EzYTAvV1QxWWlNMVliYktJeTFi?=
 =?utf-8?B?Y2ZuNHl2SGdqYlliTWwvOVFBbCtyTjIvbnVwcmg2WDd0OTNZMjRMOENYMnpi?=
 =?utf-8?B?M3Z6aEx3alFQczZUSDJOTTZ3OW9naDdlZ1UzZVQ3WXZNSFUvU3Y3SzBienVR?=
 =?utf-8?Q?OW/xOR2AKLsMuIIMG/KVuor8+GDUFKgrjKL2Eau?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8722.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emtuVlBJQ3VQN1hJOGs5aGJoMk01UW9GRkVWRXdvZEpqMWYxMzVwZlFyRk5O?=
 =?utf-8?B?V1I0THZvMi9USXhmK04yenN5enlJbUN4TnlGR29vWGlsOEt1dDYxZXZMdUtB?=
 =?utf-8?B?SVpxT1NGQ2tnTFVBK2JkbWpQS3owYmgzOVJ6QVRLaXZjR0ZhVThuR2hsS3VX?=
 =?utf-8?B?VHVMQW14RThlajlDOHFRVXd5V1VFc0I5amM5VFNNV29HaEpSQitjTXdOVWFI?=
 =?utf-8?B?V3I2eGJ3YkVtM0JtUGtCUUI1K0ZPZmFzT2hFTlRHUFpDZlNIczNEeUdFWitC?=
 =?utf-8?B?a2JELzQrNmdmN1FoeHZOa2xUcUFJYm1CQmNXcjhUbE4yNDdsM3FyQ3B5SkVW?=
 =?utf-8?B?aWpGenBsbXRORE9qbTI4QURoU05mbUtTTkZSMmFNZms2Y2FDeE0renZLclVF?=
 =?utf-8?B?a0Z1RW5yMlN6QlhxUUk3MC9Ba0oxejVkam13WUdadnczTTdiSzNuNUI0eDFM?=
 =?utf-8?B?LzVxMUF2eFpBc2RyMm9wUTJTeXFsYXR6YUZqdlF6TGdyL2crWEU1b1hqZ2cv?=
 =?utf-8?B?L0NYdDQ0QTNCM1E1WnFDY04xL3E1TEZHcThFaG1CNXFpWGJWR2dFN1hkMEVz?=
 =?utf-8?B?TjFkZVhQTDB6UmwyZy9MeHZaVzZQM3VLc1RtTXcyYkVvem54MlFCQWtKU09V?=
 =?utf-8?B?cEdDSlMxTE1pbkVnOTZvaWdrVHhFV0lLSTl3bVgzZDYwdmhJcm5VTDlkL2x5?=
 =?utf-8?B?MEFTUG5XRUVMY1I2cDVVY0JRMUl1U3FXcGdzNnd4aE0xUTJIYzFWaUYyL01N?=
 =?utf-8?B?R1F1R2lsdXhUZFl4czZsTmtoWlRtbXhtYmhQa1NXUjU0bHlHRHh4Nld5TEVG?=
 =?utf-8?B?L25sWm1GWHZwNEZQV1B5OVFxTE91RGZQdm04dE1aSXRDUnJoc1g2QU80OTZw?=
 =?utf-8?B?VXZrSG0zREYwaVA0UkYvWE9RN3FKM1djd2NaZkppeUZZVXVMVU1zTHUwZmRB?=
 =?utf-8?B?b1FnL2grbkdUWnZJRXc1YnFsZUFLUk51SVJ5R2g0UWpTTlVlZExhUkM3T0R5?=
 =?utf-8?B?czVJaFBLNVpoUThSb3dINnFCV0RxaEZuODRKVXdGNFZZNFIrT09pYlRyTkph?=
 =?utf-8?B?UVRZUmk0dDY2N3poNURUaytOdWNRd1N1UVNUMGZCcjNVUmFybllmakV4S0d1?=
 =?utf-8?B?WmlTTmxuWjNWQVIyVFNPbTBmd09ONCtIdnZ3Q2IxQ3A3MzZ2eDhLWExteGsv?=
 =?utf-8?B?SEFPaGp4RFd3OCtNbHUrYW1pOTdkajgxV3Z5M2VhcnQwV2F4WU1kSzdjdW5U?=
 =?utf-8?B?cGtvYnZXSGpyR2JFVHVpT1J3bzlyYWNHLzJLYXR2aFl2ZDFoUHVsbXdGRzJH?=
 =?utf-8?B?NWV3b2hpeisvNU1lMjZOM0Q0ZjJqaTJyTDhwUjhTTzUzemp5dUlXTVhzKzU5?=
 =?utf-8?B?MDNIMjdGbkFYQi9XNjJWclFDaUN0Z3lVMTdxOGo0K2ZQc1pWbVp1VmI5TXZi?=
 =?utf-8?B?M2hpQU1Hd25MOC9tY3JKdDNwNXdUQ2lLTlBmZEZmWGY5WldVWjB0ZGlxNE91?=
 =?utf-8?B?akdGM3lIOGN3aTdOZHFkNlU5UCtMVjZQRFFkWTVoZE12VjllS2hhS0hQRStr?=
 =?utf-8?B?dHlXSmpOOWpHR3RrNFdhWnBrOEVRWml0cldxb3UreDE5U2NjdldUQ3cwc2VY?=
 =?utf-8?B?TWZHRm9BUGt6WitJeDN4L1Fhc3ZsdTRPejhITjFtODJyUTErbnhyUjJIZTZk?=
 =?utf-8?B?QkRCK21iQ3FiSXQrSzVrWEZLMXJxQkVGVFFJaHpHKy81dTRMamF3N1NudVJQ?=
 =?utf-8?B?eXZLMktPNWUyUnVhQXZqbUplL3AzcmdxR05yYTdnUWlHRGZlR2hSNlhMMWZk?=
 =?utf-8?B?SnNOSWtuNUp5anBSS3RZUEx4am13RitRSjBRYkZFNDNEV1FNckZDZHNKVnJW?=
 =?utf-8?B?cVZmU25BK2l6K0pjOWtVNy9uUkNnK1NJR3pTd2VYN3hHWFdNcVVBOUZGNXZN?=
 =?utf-8?B?dFFHbGdJKzIwUHpCQkV4TDdtb28zRE1PUENja2VjVmhSMFJrUjN0SXhDU1Nv?=
 =?utf-8?B?NG9JdUZiLzEzNDQ3RGlTamhLMFV5bWt5MkJMRC9RQ1Jha0h0Q083V0Y1NG91?=
 =?utf-8?B?SzRnTDlkbzFHWU50K2NqQXF1eG4xeFhSVjVUcXI1OXZVeGVUOEJvblNOc3Zl?=
 =?utf-8?B?WEwzTWlQM1phZHpZSFZxY2o2TWg0ckV1TjNuVFZQKzVlY2lFZ0FhZjRYd0Z4?=
 =?utf-8?B?TVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9273cb9c-3518-48c4-ebf5-08dcf82b9e24
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 15:09:00.2139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 95lzpYv4EBC+LbJdFqtoGKyNttWoCvzju4SB9ZA3VZjUZW4u9V7IOlcNxYVbYmQn6YAJ1xerVc79D8PswpLZqwgcNVdKdAsgUtR4PSbCU50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7345
X-OriginatorOrg: intel.com

From: Justin Iurman <justin.iurman@uliege.be>
Date: Fri, 25 Oct 2024 23:06:36 +0200

> On 10/25/24 17:12, Alexander Lobakin wrote:
>> From: Justin Iurman <justin.iurman@uliege.be>
>> Date: Fri, 25 Oct 2024 15:37:25 +0200
>>
>>> This patch mitigates the two-reallocations issue with ioam6_iptunnel by
>>> providing the dst_entry (in the cache) to the first call to
>>> skb_cow_head(). As a result, the very first iteration would still
>>> trigger two reallocations (i.e., empty cache), while next iterations
>>> would only trigger a single reallocation.
>>
>> [...]
>>
>>>   static int ioam6_do_inline(struct net *net, struct sk_buff *skb,
>>> -               struct ioam6_lwt_encap *tuninfo)
>>> +               struct ioam6_lwt_encap *tuninfo,
>>> +               struct dst_entry *dst)
>>>   {
>>>       struct ipv6hdr *oldhdr, *hdr;
>>>       int hdrlen, err;
>>>         hdrlen = (tuninfo->eh.hdrlen + 1) << 3;
>>>   -    err = skb_cow_head(skb, hdrlen + skb->mac_len);
>>> +    err = skb_cow_head(skb, hdrlen + (!dst ? skb->mac_len
>>> +                           : LL_RESERVED_SPACE(dst->dev)));
>>
>> You use this pattern a lot throughout the series. I believe you should
>> make a static inline or a macro from it.
>>
>> static inline u32 some_name(const *dst, const *skb)
>> {
>>     return dst ? LL_RESERVED_SPACE(dst->dev) : skb->mac_len;
>> }
>>
>> BTW why do you check for `!dst`, not `dst`? Does changing this affects
>> performance?
> 
> Not at all, you're right... even the opposite actually. Regarding the
> static inline suggestion, it could be a good idea and may even look like
> this as an optimization:
> 
> static inline u32 dev_overhead(struct dst_entry *dst, struct sk_buff *skb)
> {
>     if (likely(dst))
>         return LL_RESERVED_SPACE(dst->dev);
> 
>     return skb->mac_len;
> }

Oh, nice!

> 
> The question is... where should it go then? A static inline function per
> file (i.e., ioam6_iptunnel.c, seg6_iptunnel.c, and rpl_iptunnel.c)? In
> that case, it would still be repeated 3 times. Or in a header file
> somewhere, to have it defined only once? If so, what location do you
> think would be best?

100% should be in a header file. Can't suggest any since I don't usually
work with tunnels and ain't deep into its header structure.

Thanks,
Olek

