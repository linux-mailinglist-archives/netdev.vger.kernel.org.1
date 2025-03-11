Return-Path: <netdev+bounces-173802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82611A5BBD3
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 10:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DC7E188708C
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 09:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F85E1EBFED;
	Tue, 11 Mar 2025 09:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iNmBYThx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F7D2222D3
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 09:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741684521; cv=fail; b=BjK1EwbdjuQDnOGmgWk/ogIjDZQn2aPhXRKkwwNDFuIso4Czz7cgdzkfgtCYk4JB4iWqHUYEG74j5rmmj0Q2amDmC87QA0f31RP05Qv+aYSll5BLXQ9WgGDt4HMSlU2A5iOL3v4rgA5YC5yn1sy7enUbkvoNYnJmGyniDx11hes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741684521; c=relaxed/simple;
	bh=sgjSdRgjYnGbMKsGyywgfkb0gp1ruCVRYGy2RtxMcIo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oBg46KFNE8RvBDMDqMO5rqNdbEOoidCSIfMJWrmbjx9cyCBYyTfuh0wb4pCR/13FrFqfxPxseXbi8cGGoMQVbyqAtiu1qPCe6bhtylLGnBN3CbHax8JpNwFBASInyJlefYjiBmoq+cR9AHzJNRfYzfh/Ov9bPner9nYiYiyv0rQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iNmBYThx; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741684520; x=1773220520;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sgjSdRgjYnGbMKsGyywgfkb0gp1ruCVRYGy2RtxMcIo=;
  b=iNmBYThxYZnE2c+wS7mvvLn4Vi2Vl3x2J938TJwlgS4IoeqS4SXVr9ID
   4DcOC5aCe71dxewmp6TnvP3cDQwzl2Y1jJBK4dsGL2GSuyftQKhw5tRpb
   ZJWLAUjJyq05iX5obrKAo77PvpLXNhI6gLYvQRWc3rdy/8Ptug4jMcx+b
   Atabj5mzoqONa11CpF6bkxU+pLsDNAX+K09tq7mwuWpkSMwJn9BeyKlfP
   Y9decIE+VtEgYMjKMQAhI3NgljzhFkdtw82+X5wsNsroowx26v3bIFRi+
   u7/mMuur2bDiHivXhhDN00GpbpG8k5ouYtFcMItglfh4cRyoySTs2+wVf
   g==;
X-CSE-ConnectionGUID: dnCc8v8YSrSj/Ulz6dl/vg==
X-CSE-MsgGUID: i6mFZF8WS+CNi7i2ViJ2OQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="42746402"
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="42746402"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 02:15:15 -0700
X-CSE-ConnectionGUID: EzVTPUooS/ObWjzi1B0frQ==
X-CSE-MsgGUID: NTSYGL/URjioQMVbMbSo5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="157477387"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 02:15:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 11 Mar 2025 02:15:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 11 Mar 2025 02:15:14 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Mar 2025 02:15:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wDWsWWCbNdLcUqZTEbdw72M5mhLdNPyWwX9ZTxiJSNvqoNhUv4oX5h32LBAmadIpxNkp6RJAeL1rYRLHLR3EJomJtXrhyVqiL63WUHtST2QWl2tj5wcYUyyPrzXTgJwfO6OkLH5LCdWfBlU5v/n4vxvVbL4dp+IOFLJ8BEDZFyEyjBrNew45d+LhDpyC9KcdqEDpjftaY3cbL0HpLAMtDpXyNhrchaljlqbSFxBNDmZPcvlY43wxTo53yMSbMN6LXJVc2ZUbKNhwlA3LMfLEfAAP+w0Ib0gvZ7tGEkxSb2+gqWCIH20lbrZnT4Eioeb+7wYX6vdSFIqa+JkulboKYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xTiqLUQ12s9EI7JNtN3k5tWukeKuPEqR0nlsUaXKxU=;
 b=YMS/vp0lJ8jWGgUvzQcF6gBsmDMAnNNaJr4AlBifRyp0u9yTDsfp0XqrQ3j18Z9GoVC5oR6sUwv38GjCY/PhV/BF19oq1Fl+lw18anJuCmBdOFpSAEMzgNDfbW4RoC4USGe9/8i2FFnSFVwpxjW8t5MHmEdiz0KYQVzkX1SAlqbOFBSJqZsA32kU/71kg0zRD1jWxE4yHaVFPhM7/leox714oVDLcFqjNrUDiLjjURmUzGqeglIXWbd6t92s2tMSr8bFAWbXp98efoBJeU9o/R2h5s2yHjOZBp3nzSXJaCD4CZAXqprgw9dLrQEc/kUE3DQU3Evs9aW97LAnP7svFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CO1PR11MB4962.namprd11.prod.outlook.com (2603:10b6:303:99::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 09:15:10 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 09:15:10 +0000
Message-ID: <27e57ba8-af5d-4b4c-ae23-da1c1119a9ab@intel.com>
Date: Tue, 11 Mar 2025 10:15:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2] i40e: fix MMIO write access to an invalid
 page in i40e_clear_hw
To: Kyungwook Boo <bookyungwook@gmail.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, "Loktionov,
 Aleksandr" <aleksandr.loktionov@intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>
References: <e7e4e5d5-931d-4506-9d75-b87783011379@gmail.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <e7e4e5d5-931d-4506-9d75-b87783011379@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0234.eurprd07.prod.outlook.com
 (2603:10a6:802:58::37) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CO1PR11MB4962:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f6029bd-3580-44f2-3e16-08dd607d393b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y3V2aExxMUdxUE4vMVh6eTBDWnZlM1VqU21EZGxiK0t1OERlYkFJblFHMDNn?=
 =?utf-8?B?eXZHZkVKa2NmSFNEelN6eXJQUlVjR3Q2RFlKdGxTSDFRVnhGNGt5K3FzVjZH?=
 =?utf-8?B?bnBGYkMzalJSTVhMS29lQWR0disvSjRoaHF6cWR6MEI5WmhBZHFzeWtEYUpy?=
 =?utf-8?B?YWJKZTZ0dmE5MTZYWjY0b0Z5N1BTMjJydHNLMlVFazhkTGh0NkF4cWg3OXRZ?=
 =?utf-8?B?UThqczVZTkZqcXJBN0dyeTE3YWU5bVNuV3BXdnF3VUpMZWsydmZUNTFyQko1?=
 =?utf-8?B?ODcwd05QbktJRjZhVUF2WlFqNXlDUDZPcjY0aG5oRW05ejVvZXVXcEl1blp3?=
 =?utf-8?B?bmtPMHNFSjZnaE5LcVNjZURGQ0pxR2ZXOGthOWUrMHNSQXI5ekNiNFBZTHZR?=
 =?utf-8?B?Q3llK2tHNWdCVGFOc3pHWDFBZWR6VzZiZkJqb1A2QjdLVS9MeHlYbG5KK292?=
 =?utf-8?B?ZzFzbUgxeUs2YXNhR0dLQ3Q4QmluSUFQTXZuMldZY1UrR2pCUnBSRTFkTVlN?=
 =?utf-8?B?QXRERjZVYTkwWUxwMnRmU2N1WXZrOGl0cTAwL2I2YW1FWHpOSDVxSGpObTRZ?=
 =?utf-8?B?UkQxNTBQWmU1ajJzVjVPdmQvbGZIVm43RXlFU3BocWdWOFRmN1dXRVR3UXJK?=
 =?utf-8?B?a3JndjVRT3RwOVJkZFpJbkh3UW5zbS8zNklNaThpU0xpYVJ4ZTdUaUs4SVF5?=
 =?utf-8?B?K09Edmxlaml5TUkzb2JuMWhNaXl2enRYQUlGVk1samd3cHhRWngrZmFEQ3Vu?=
 =?utf-8?B?Rzl0NlV5Z2NRcHJkWUlBTXNDWXpzb1Z5QTc2aTl2MVA1ejdiRnBEUFBEVUFp?=
 =?utf-8?B?VndEOWtaZjR1R1VLRWExeStuTU5TbHFKcThrSHFkb3dyckpsbWtaSlR4Z2xL?=
 =?utf-8?B?SjYyWCtCOTdybXlsRDhBWEVLb2J3a3JTQUNWQXMrY2MyQ0hrdnBzVE85QWE0?=
 =?utf-8?B?YW5iTlhUNW5MSHN4OVU1WC9VY3hPdUJoaG96d2VZcDMxaEx4MXo0Y0lrdFpC?=
 =?utf-8?B?MXF2THNKcXBadFBOeGZMRjdpUVNmaTkxeXZRelhKNmtqZGFWc3Y1NGF4Ujd3?=
 =?utf-8?B?SEJKRXo4WFlwNzdwZUJxM1Q4a0c5eXU0Znh0LzdCckFJb2lNeCtmcXp2QU5n?=
 =?utf-8?B?aXFvRU9zL0JaMmhXOGhPY3hmd2p3VlpzNjl4eHQvVmcvOVNTcERBOHJoazVL?=
 =?utf-8?B?ODVDMDRGUGNreDZnR2FnWGFqUHFiN2I5cW5uZTF2dVBMYi82NytaTm5mc2Rw?=
 =?utf-8?B?L1JqTVFBWDRPbVVacjMxTVRiUytMKzduMVFGQXFUS1M1Zm9NQnBwREZHWWgr?=
 =?utf-8?B?OHNnRFNWeHJQVTl5NEliN3NZcmdpdm5jNzcvYWg2RVREY3l2VGFhZWQzdnpG?=
 =?utf-8?B?TW96T2xtU3lLNDhLRUg2dTNPUUdZMGc0TWkvL2hWZEQ1TDJGb294aTM2WDFI?=
 =?utf-8?B?Z1ZXYzVkT0I2NFhjZldDblhXdC9SSzRMcmNjZWxyNUdkaVJpbS83Y3FiQitU?=
 =?utf-8?B?dFdZc1hJRjZaaXQxMEYxc1RKeWRENzlVd3diVHpwTWlIclZ4VnlRWFFDZThY?=
 =?utf-8?B?YVdLdk1mUDdiVjJsVytBcElVZXNna0hEMStvVEVhczhGblcwYm1mcUVHRllk?=
 =?utf-8?B?aHlhUGNnbkt4WnZad0RvSnJmeDZ1bCswZG04ZEdNRUI3U1V6ZDgvd2tMQ21o?=
 =?utf-8?B?ZTdkaGxqN3V5eFo1RmNKdlF2WC8zR0xTVEpsZnB3YUNCeUkvcVZqVzgvNkNO?=
 =?utf-8?B?Ris0WFFRMG9SSDVuL293bXlmVHhYV1Y1NGhMb01qd015Z3BhMG5KNUs1bElv?=
 =?utf-8?B?V1R1WlhlSXRxczRXVC9BZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3Axb3Ric29YS1FmWGZCQXJMdjk4T0VxUU9NVjlTTXozWVpabjhOZDgvUlF4?=
 =?utf-8?B?YnV1WERvS2NpZVh3dTNINFBDTis1YUtCU3dNYlBOR1Q3cHNrcXZCdFkycUdI?=
 =?utf-8?B?OFA1SllLcnlteEo0bTF4WW5ESVdqUlBHMERBK25OR2xuVTNlZlFxZXlZWVcr?=
 =?utf-8?B?d1lpbUxWZi8zVW9ic0VPNkV0Sm1lbWhpTXFob0hkS1E1ZUZPajNhbG5KUi93?=
 =?utf-8?B?azlJbXRjZzZGWjNSa2xqK0lhaC8rL2YzekVDQnM0VTAwRDh3djJWOGVmNHFr?=
 =?utf-8?B?VGkwOFQwUEY3TU5KemtmMHZRWC9hT2lFUUkvZVRmS3JQaFZZTkJtOVAxeldD?=
 =?utf-8?B?d1BEYm9JVldJRERJUEVFVllHK3dtUTREYjI3MFJsdmJ2QUlrKzY1My9LSHR1?=
 =?utf-8?B?Z1hjd0J2SzNVTUlPcldqOGFQdEFDS2ZPMDc3S3ZTWkx6bEhaY21ocmgrTlFx?=
 =?utf-8?B?OXpPdkZzYzMvUWVxbWFON0RlM09DUVh6b1hqN3FDbUFka3VYZ3VDbWRTK2o0?=
 =?utf-8?B?ZlVZM3BYeDcxcjBuckRiNkNYeTNITW1UcS9oSE1lcUNZM2lxL0xlWVR3akFi?=
 =?utf-8?B?V1Zaa2R2ZUJhU1g0MWdMM0ZHTlc3bEI2R2JTbVp0ZERMT3IrMUpSbyt6MHR1?=
 =?utf-8?B?WDExbGtLQnNjZGVnd2FSbzBHa1hDT0JoWDNNQm1VWVpMdzI4THJ4eXd4RDFr?=
 =?utf-8?B?c1BwSWFFcnpQVE4za2xDbVhJTlVQZWJmTU15ektDWXl3d0lveXl5U2tIRGJu?=
 =?utf-8?B?dFBMcjBXU0tIWlA1Y24zdkpmYm9wejRjZlVZSHlkUXljVjJPSmVwWW9OQVNF?=
 =?utf-8?B?WTVXdVNxdUczbi9IWDhBUWhmODFKY0xETEJUNURmV0diaDhFbWtNdlJNV2Vq?=
 =?utf-8?B?Sys3WlZLa1gxMnVKVlBDc3lDNTRDekdqdmJzdng4WjVvbDdxaE5GZm9DdGY0?=
 =?utf-8?B?Z2pKVytkNEh4NVVQOTJ2VnBXNUo2RTY1WklwaFh3V0hRTlIveEhGUU9PTmxj?=
 =?utf-8?B?ZklhRXA1MGZyNkhVckRwbVRianpVMUZOV2RBT0gyL05VSU1RMzRJNnh3YS9y?=
 =?utf-8?B?Q0F3VEhBWjRaR3hqMzVNVWZWa0wvU2l2cmNzcmtHcHFsRFZGU1dCbmMzNU5Z?=
 =?utf-8?B?OGVNSlhwNk83YUNmSnZJbXhoTjZpNzF0cnczbExuNFVLcVYxelREQXlFbDJr?=
 =?utf-8?B?M0kvMjRBalJTcnFiV3dhS3hQRjVzWjFGMmRxSlBhTDZpL25tQ1lTdC9SZFYr?=
 =?utf-8?B?WW9VLzJlZjgzb01LQlhDV3BlR2x4UFdTM2JBdEtYU1FqUmJCK2FBdUxIV3dF?=
 =?utf-8?B?SnZvb2wxZDc5MXM1M0JxbUlqcUM1VHA5N2EyYkhCRWRxRDlBanhzQlJESWwy?=
 =?utf-8?B?K20yYnVGSVlKOEp2bys5YVMrQXN6Uk9GbVgreFVPS1FvN1BPb25TQnJGWkFj?=
 =?utf-8?B?eDkrS2dLNWcwckozcDVUaVczR25PdTZnRU1oR2VQaWN6Rmd3V1lwTGtZN0lZ?=
 =?utf-8?B?UWYzeDN2bERET0F1d0d2bkwyUnl1UFhuc2lha0ZJV3A3L3YrZC9rd1dvNFBJ?=
 =?utf-8?B?eHBaWGRheEZtUS83dGNVZkZGTjc0WmtVbVZpTVpPMVBFcGFtc2Y3aVo3dk1O?=
 =?utf-8?B?V0k1eEdoVGhlQnlqaktRb0xLTDJUdkxuWFozWGFtQ1REb2s0aDVFSCszaFV0?=
 =?utf-8?B?WHdSU0hKeFdRQngrL2N1WXl5SXYvT2dBV3ZsaWFTVzR1d0t2WE82TTdwK0Y2?=
 =?utf-8?B?YnRyRW0vN0s4Z3V0c05MY1Y4MG5HL3J6eHY2cXpkQmhqTTZXc2dZTHBWQnBZ?=
 =?utf-8?B?L3JZd2xHRUpQSi9CajlzNHJtVmI3bDJSOFg2SzZ1TTlBOWpGWXFQMWt5MUI4?=
 =?utf-8?B?a3d1aGJmaGthWWRZNWtCTnFXaWFaeXl3dDlLMmlrc0NmSGpBWURqczRITThk?=
 =?utf-8?B?emRzVk11akV5Tys1eUFKcHpWdFN5MTJsUmVEY21maWJ1VFU3REN6S3NDeVV3?=
 =?utf-8?B?ZEZncUxNUXVaT0U5UG1LcXVqRnlsS2FVSEl0Qmx5QTFCOU12Smpia3RiTVV1?=
 =?utf-8?B?cGhGVkkrTjc2SmtHcElQRS9Ca2JIN3RXYUIvK0NXOEIwZTJtN2xodE9XTi93?=
 =?utf-8?B?V1N2REM5Wmh5bnhUcEl4UGdjREJqMVFjTDB3UGwwTjhTcEtBNURLQmtBTkov?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6029bd-3580-44f2-3e16-08dd607d393b
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 09:15:10.6025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qUQNqPW1rf9xzrhAoiU0+7GJDPg9xp2Ou5eTYoacPXzFjs4IQH4HgGDjcDqYvPekK0Au7l/B0Sq+THQ3HeXnNuw2bRcnxhWplV6Naaf1pUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4962
X-OriginatorOrg: intel.com

On 3/11/25 06:16, Kyungwook Boo wrote:
> When the device sends a specific input, an integer underflow can occur, leading
> to MMIO write access to an invalid page.
> 
> Prevent the integer underflow by changing the type of related variables.
> 
> Signed-off-by: Kyungwook Boo <bookyungwook@gmail.com>
> Link: https://lore.kernel.org/lkml/ffc91764-1142-4ba2-91b6-8c773f6f7095@gmail.com/T/
> ---
> Changes in v2:
> - Formatting properly
> - Fix variable shadowing
> - Link to v1: https://lore.kernel.org/netdev/55acc5dc-8d5a-45bc-a59c-9304071e4579@gmail.com/
> ---
>   drivers/net/ethernet/intel/i40e/i40e_common.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
> index 370b4bddee44..b11c35e307ca 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_common.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
> @@ -817,10 +817,11 @@ int i40e_pf_reset(struct i40e_hw *hw)
>   void i40e_clear_hw(struct i40e_hw *hw)
>   {
>   	u32 num_queues, base_queue;
> -	u32 num_pf_int;
> -	u32 num_vf_int;
> +	s32 num_pf_int;
> +	s32 num_vf_int;
>   	u32 num_vfs;
> -	u32 i, j;
> +	s32 i;
> +	u32 j;
>   	u32 val;
>   	u32 eol = 0x7ff;

thank you for localizing the improvement, now the code is more robust,
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

>   
> ---
> base-commit: 4d872d51bc9d7b899c1f61534e3dbde72613f627
> 
> Best regards,
> Kyungwook Boo
> 


