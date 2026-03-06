Return-Path: <netdev+bounces-264753-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBM0CrbBqmlXWQEAu9opvQ
	(envelope-from <netdev+bounces-264753-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 12:59:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6B021FFDD
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 12:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C8BF301C152
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 11:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4B7368276;
	Fri,  6 Mar 2026 11:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="At/vQn6G"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BA6367F37;
	Fri,  6 Mar 2026 11:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772798377; cv=fail; b=NgZqEN/WKlkv6ESNQBTJd+19rd6KS2FtkKGh24UJQFbq8mgJoFMNvXFzUllwALjZ02rdZnEbAuwByqh3MfLcJnyljumIvqWJp0S69T8f3BsMn67zlkBPDZXzPKazEu9ZxtZ0h/GUxHWsxBhTafwnFU83qMBXYDntrPIGP7OUeXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772798377; c=relaxed/simple;
	bh=ez0sFH+fHP6SkEQg3lkG0OQL+JP4GdD63C9rPOtolWw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PeaIdjQEG2t244UGo2wPlr/ne13EXDjOXHVTgy6AELZ7eOFm+4soBeTIMNvV2HFZpGnxG2BHtZEVi7mdZx3Xw+iDMoF1IJcXKEySjbc6qVFv3TZQER8JOz2C8/lM1CQgxMLzfTbK78D3swY5LEmgPIHcccme0QXuZBhN0HFJa2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=At/vQn6G; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772798375; x=1804334375;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ez0sFH+fHP6SkEQg3lkG0OQL+JP4GdD63C9rPOtolWw=;
  b=At/vQn6GK+t4KS/8yIlKYWwjjYud4rowbe00BmpPrXGI2WVHZj+cMspv
   5wVVJqUe+psXpMBLACmy7c16b+Bu8/pmvhDxlTg1a9OpAc/EFZCi+bmq3
   2jC7RfopRfiejB8QRIeq18+xezhySQ2+oCra13mbckiFotzcqxK4zcGEl
   V3dmGOwAgpib1JvuuVtOqifTmRJvUmPv8PogCno1kpRR8PPEWsVXIL/3J
   QMKHpnQFWexZNkJcwZkvVgkwDaL+7qsd+M0ydpKiEeSx1fzI0wMmCdSrP
   gk0oHDl8SZVGDzbzRHJrNkcFH9lNUd0wTXgj4HM9alm3jBxo6JIzWlCOQ
   Q==;
X-CSE-ConnectionGUID: S1Nd8C7xT1ejFBDx9EH1ag==
X-CSE-MsgGUID: RQAFALLkTz+yiBcrBg+HXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="99375089"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="99375089"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 03:59:33 -0800
X-CSE-ConnectionGUID: C2XCljhYQsG6hGz73nb8cA==
X-CSE-MsgGUID: V/GdV/TWT4SfF46vQxbzzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="218982808"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 03:59:33 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 6 Mar 2026 03:59:32 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 6 Mar 2026 03:59:32 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.3) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 6 Mar 2026 03:59:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JRo7T5vAy4XceEdxx4C0TBlRXycQ0nysXLre7sUteOuWScA3aQco7WzpFBp15UUSChG8gSBt2x8ryIUQRRhZLFNopKxban4cikNf+jgNQx0hj7GQdUzKXMvhCB0NlHJ0c+ILiaZTGoqX1TFwR5uZ8SlE4zRM/qqEFB/NR9mojpsVF1tCvmnX5LWwrUQGqpKmUe07Fi60zb8RSkzQUomUn6AGYdX8npkPtHczEydoYT3Ki1A2G8scCQPhJPjj3KJ7Xv6z0s7cHOeln5K0AbmfMD6Uf4Nw0RiksR1LXwJL7zEtUzzAaJ1KIWJFHWZPnjbrD9jgcjlD93WOjyTTT+t/PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqswgUwgBqG+FThcUHfSE3hJk1zUeOKzCxIc2qdgz8w=;
 b=o3M6h7cF8ywl1aoyCNJEs0X7JIroBi+qRur6AbbkZ5IkKUEO1Mh8jGmopf8LAKLB67zDiH4lR9YyYHxh8EsJB3ZFd+NTB3xMxooOHhbK7IK+IoclI914he4LDMYk0GNLMX+nfcDA1ZA5hjegMQdyXm4blc90SPf4R9YkmWRBH/VQ021xhSPx/M8I0hjIuki6KMyyR9hTqBGXbG3zfzE2weigoU0hyF3r6hzq9BUCuzRVGeMsAh+WRRicMISsnmMVBAUyqZfwAqrY/dsxFMXKp2xPvMn8umKLnie6PfIh6BwaCrcieI5q2YaRf24OtuTEmOPIyjicwExPInv3C3Jwpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA1PR11MB7920.namprd11.prod.outlook.com (2603:10b6:208:3fc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 11:59:24 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.20.9700.003; Fri, 6 Mar 2026
 11:59:24 +0000
Message-ID: <45e3ed53-bd42-4c29-abac-1d9fe74ad539@intel.com>
Date: Fri, 6 Mar 2026 12:57:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3 2/5] libeth: handle creating
 pools with unreadable buffers
To: "Tantilov, Emil S" <emil.s.tantilov@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Kohei Enju <kohei@enjuk.jp>, Jacob Keller
	<jacob.e.keller@intel.com>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, <nxne.cnse.osdt.itp.upstreaming@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260224174618.2780516-1-aleksander.lobakin@intel.com>
 <20260224174618.2780516-3-aleksander.lobakin@intel.com>
 <b21bbcdc-ec87-4f83-8449-e627b6353281@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <b21bbcdc-ec87-4f83-8449-e627b6353281@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DBBPR09CA0039.eurprd09.prod.outlook.com
 (2603:10a6:10:d4::27) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA1PR11MB7920:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e60eff4-25bf-47de-4005-08de7b77cf36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: qkdlnijIe3O0XlnOr/1Tboy015z/IMW5Eou/FpRCu3/pJgPWrd2fu3kUUl5W1s5EEMI/gBkOuorRE7lpUta3qzKmzCf6XWyDGNfNNAcFBvdn+vcY8SW42mCKg1KQt+xyKmfJUMLLWdLXOPBaeRAK5wXLJGIzsgrAwu9r7Q4pDjo9kViFwHCG3dJY/ng/6l2QcwMNRpwyI6Fgh14a2oOUBslcZfiAvHBbupsEdXF3R5xtQBf55Wyt00/Du+L9+AwqR4M7Xu/LZ5iH9jnWxA2aYvDPMVNxG4CGgQRvE8wO8WbbcwqujW8ci4EqCIQK5UKFgJLwbhEsQXkNHafjc5ikSZanwu7Hq7YkcEiJW14nPOhlHNyonHXPmix7xakUYPW8cfIMBUwYPcmkWk11kMuyqKUHSENSXGVwOf7mxOvrgBi2b+vAYuOezHhIwLhHTVO6CshWc9n2sbsR3UY3hbLSCEjbf6CtW9tpzSWFIR1zN6Mx4ytPMM16THlDSc+yJMhV8BlBMJQ3/m6TSKTfQFJKDb8hYGwpZnE33e16G8Z44ATOUJR8E6a7js1NKAYpCovILCdcFsNk3lt9fZ9M+8wTbETNa6dujSpCcP+v95kZDmB+hBqsHJPkyO6t377A0F2DOg44Yt5YzEwX/emoIzYbwluGoXR9OgbjUxvj40jS0hvvIugMFC6aMoUaS0vJgLT6HpCA6q7/kuQr5MDxpviHmXGgo5fFixGaIK7cKI+dr5I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGg0VXp5OTYvVC92RzNYZVpzMEVWWEpTS2RndTNkQUs1R3cvcnRRQThNQ0gz?=
 =?utf-8?B?TU9QZ3p3NUFKMkRtL1IrKzRKcXFGSWthVkYzd3ZQTUtaeWpSb3NQMUZlc2xn?=
 =?utf-8?B?N0VQWDg3UHA2WXdITHlQYXljaGg1L1J2ZHBUV01heGRGNU5FbnhkT3NiUVZG?=
 =?utf-8?B?c3dYTDUwSzBkQkpCdU9NSmZjcnIrejBwaC9tcEd5OVRadVZUZXJLRlZkbEQw?=
 =?utf-8?B?KzVjT1cyVitYeEJQSUpjWVdxRGZubzR3SE9KM0FRa2NiMmg3OGk5bk5aOVZJ?=
 =?utf-8?B?S1NLSmhVdWgrZDhERnZHNGFDRlRrS3lVcTRqL3NzRjkxNUpONjB2dU9xa1Zk?=
 =?utf-8?B?WXpMQXZWYzIxYkMxMnRXY1NyYWZqZ3o1eWgyM0xIOHQ0aCtYVUh6czlXQm00?=
 =?utf-8?B?a0JwbExXY1VmYklURm9Zc3NYc0FjeU4weUNzUEorZ1VQenIySXpGaTQ5andT?=
 =?utf-8?B?SzZ5aEJJb1VRUUYxOUJ4UFBCN0JUcGI4ei9wZG8vY1RsZmdOMXU3NkIzeGlE?=
 =?utf-8?B?bW02UkR3bG5rOU1ISUI5eXAwcGNJRWpsdTU4OFZDaGlBUS9QWDFwU3E3Y1dN?=
 =?utf-8?B?T1lKV2xQaU9UbW05UEI0N0xJR1NPOXE5UUlJTXFQREFoL09XUDBFd3IxVEhk?=
 =?utf-8?B?YnIyN01WQTRKMFBXRURpV3hCVkpSQjJWd21qREJpdDV2akpYWEVFT0ZUUmNW?=
 =?utf-8?B?UDg1TlhURkwwYXRINnRrMUNicmhuYTR3ckJjSkJLSCtpdHc3RUY4NnRNZStC?=
 =?utf-8?B?d1FLTjdDQ3hnMWJCOFZzQ2ZzL2ZzSFcyVXd3N25UMmRFdWh5OGRJSFZwL0hK?=
 =?utf-8?B?dmE1YUhDcGJzT25XZ0tFMkFCcjR2cEt5bGk3eE9pNFp1clpFQTdZa1NQdm5J?=
 =?utf-8?B?ZnJHbW01ODUwN1Y0NU94VG1QNDJjZHl3cGpIV0VJZlZyOWNtdmx4dmlWbTh0?=
 =?utf-8?B?dDViSmo4QVN3TWQxQ3NyTjQ2N0YzS1NhK0JsdWQ2dmN6VlZweGo4bzJwZi9n?=
 =?utf-8?B?YzI0N3EvaDAwVzBXMzRhQ0ZxZWtHRjdyckRGMEhaNDd1S0FqRHFJVENpS2FM?=
 =?utf-8?B?MFAxUkRiQzRFYjNJWHE2VkZmaktXcXozUDlGS1V0YkJqUWZ1ZEVPdHFFMWxi?=
 =?utf-8?B?UEp2WGFKdTVBdVhpRGxuYnQ5K3BHaWtNWjZhY1lFaGhJRVBGVDA5NFpZVGEx?=
 =?utf-8?B?TVpGaUhSWTRIYThSVXdLZmpGU1ZLY0NYREVKWVJSV3J6bGo2dnE1cnBHbW93?=
 =?utf-8?B?bUdZMEhwZFY2d240WmNtSTdDV0NKSzNDZWtDclJKM3o4M2FSS2RSdjlOempo?=
 =?utf-8?B?UCtZb3dSZmtYN0FUNk5MZWxIa0FiMlAwT25pTm1SRmlUanRvT1FDSDBxWDE4?=
 =?utf-8?B?ckx1MVhnSjBYNXZwZW1WMUNkcEk5SnVWbEVOTVppNXh2VmVNaG9XUHg0SXdK?=
 =?utf-8?B?MTVsZVJwTi8yVXRaLzhHV3lRVEJwcWN6eG5IVjJSVE1teldIRnFhV0tYcHlV?=
 =?utf-8?B?cTcrcU5wRHhaMzRtWmpQbkZVamVvZnRBczJOdTJDU1dYbk5BZTNJSEJ2TlYv?=
 =?utf-8?B?RTRyQnEySW4weXRraFU3cmxQeU9qKzJQNXNwMUJaY2ZUaU8yZHFiMzJkWEc4?=
 =?utf-8?B?bEVNYjVYTUdwNHlIYU1IMmo0eHRHM3g2anE5SmlILzFJMjFmYTlta2h0YVJZ?=
 =?utf-8?B?aFZQZi94Nk44MkRKK0k4RWgvcVcvTXI2ZVU4eG04aHUxK09YWUQwSWJKVzhh?=
 =?utf-8?B?WTdkY2VGd3FVT2ppbCt6RGpRUEc0SHpmS3NMQUpiOUFYQVZOOXZFSGkxVjNS?=
 =?utf-8?B?ZWcyYjByR2RVNk1laE1oVUQ4akNYdTY2Q2lNbkxZbE5uWG9YRFEvOVZ3d1g5?=
 =?utf-8?B?RkJXU2pLaUhib3JPcWR2RlZaTEphVXZPUnpRMDFPdlg4WXptcHlROXVzY05P?=
 =?utf-8?B?L3VmQUh6eC9veXpjakN0a2F3V3cxOS9vL1dseEZJU1dMWFl5djlBZFlIQy9r?=
 =?utf-8?B?eThteDlYUUJuSnFROHdoNjJzOUE2T01hdm1hS1JiK3ZZQVFYLzk1eElIdk90?=
 =?utf-8?B?NXc0UXBaUU1OcTNrZ0VPcW5xZ1FKUmRqNzA4NmRGN1ZGQWw3VzNOc1ZDME11?=
 =?utf-8?B?ZDRobU84R1lpUWQ5YnlUemJaWm53OVE0ZmN0Z09jQm5mWWI0aldMOXNWZVAr?=
 =?utf-8?B?NWw1V05qcVZJd05BUGNOblpYT0JsNldXSVNHQ0N2SWhuQ1piYVZkMUQyL3Fw?=
 =?utf-8?B?TXF1RHNzTkpuMEE1ZVVQU2NuVEdOTmd3OXk3QTB1OS9zTlJ5Ym9aTXJ2cC96?=
 =?utf-8?B?WUxqZldRalhRR3d2ejZiWHNOR1dWVWxrcWhpVU5wbnhhTllTOU5mRE5LdDZJ?=
 =?utf-8?Q?1nu3Jzn27bBgW/Wg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e60eff4-25bf-47de-4005-08de7b77cf36
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 11:59:24.3669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHc001Ry1eJjKa3kjDt/GyzTz6MAkAMTt1PYOtCmS+3xD8TKi1vyk+oaeSTPbZBjgZpM2QW6htMK9y69VmJt2OHiUYc2+zBrry1n0HiY2N0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7920
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 0C6B021FFDD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	HFILTER_HELO_IP_A(1.00)[sto.lore.kernel.org];
	HFILTER_FROMHOST_NORESOLVE_MX(0.50)[smtp.subspace.kernel.org];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[sto.lore.kernel.org];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-264753-lists,netdev=lfdr.de];
	SURBL_MULTI_FAIL(0.00)[sto.lore.kernel.org:query timed out,intel.com:query timed out];
	URIBL_MULTI_FAIL(0.00)[intel.com:query timed out,sto.lore.kernel.org:query timed out];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RSPAMD_URIBL_FAIL(0.00)[intel.com:query timed out];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[aleksander.lobakin.intel.com:query timed out,aleksandr.loktionov.intel.com:query timed out,jacob.e.keller.intel.com:query timed out,emil.s.tantilov.intel.com:query timed out];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[intel.com:query timed out];
	TO_DN_SOME(0.00)[];
	MSBL_EBL_FAIL(0.00)[jacob.e.keller@intel.com:query timed out,aleksander.lobakin@intel.com:query timed out,aleksandr.loktionov@intel.com:query timed out,emil.s.tantilov@intel.com:query timed out];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[intel.com:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RBL_VIRUSFREE_UNKNOWN_FAIL(0.00)[2600:3c09:e001:a7::12fc:5321:query timed out];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DMARC_DNSFAIL(0.00)[intel.com : query timed out];
	BLOCKLISTDE_FAIL(0.00)[10.18.126.92:query timed out,2603:10b6:8:1b9::20:query timed out,2600:3c09:e001:a7::12fc:5321:query timed out,10.1.192.143:query timed out,10.18.126.90:query timed out,52.101.61.3:query timed out,100.90.174.1:query timed out,192.198.163.7:query timed out,10.64.159.148:query timed out];
	NEURAL_HAM(-0.00)[-1.000];
	RBL_SEM_IPV6_FAIL(0.00)[2600:3c09:e001:a7::12fc:5321:query timed out];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

From: Tantilov, Emil S <emil.s.tantilov@intel.com>
Date: Thu, 5 Mar 2026 14:04:52 -0800

> 
> 
> On 2/24/2026 9:46 AM, Alexander Lobakin wrote:
>> libeth uses netmems for quite some time already, so in order to
>> support unreadable frags / memory providers, it only needs to set
>> PP_FLAG_ALLOW_UNREADABLE_NETMEM when needed.
>> Also add a couple sanity checks to make sure the driver didn't mess
>> up the configuration options and, in case when an MP is installed,
>> return the truesize always equal to PAGE_SIZE, so that
>> libeth_rx_alloc() will never try to allocate frags. Memory providers
>> manage buffers on their own and expect 1:1 buffer / HW Rx descriptor
>> association.
>>
>> Bonus: mention in the libeth_sqe_type description that
>> LIBETH_SQE_EMPTY should also be used for netmem Tx SQEs -- they
>> don't need DMA unmapping.
>>
>> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>> ---
>>   include/net/libeth/tx.h                |  2 +-
>>   drivers/net/ethernet/intel/libeth/rx.c | 42 ++++++++++++++++++++++++++
>>   2 files changed, 43 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/net/libeth/tx.h b/include/net/libeth/tx.h
>> index c3db5c6f1641..a66fc2b3a114 100644
>> --- a/include/net/libeth/tx.h
>> +++ b/include/net/libeth/tx.h
>> @@ -12,7 +12,7 @@
>>     /**
>>    * enum libeth_sqe_type - type of &libeth_sqe to act on Tx completion
>> - * @LIBETH_SQE_EMPTY: unused/empty OR XDP_TX/XSk frame, no action
>> required
>> + * @LIBETH_SQE_EMPTY: empty OR netmem/XDP_TX/XSk frame, no action
>> required
>>    * @LIBETH_SQE_CTX: context descriptor with empty SQE, no action
>> required
>>    * @LIBETH_SQE_SLAB: kmalloc-allocated buffer, unmap and kfree()
>>    * @LIBETH_SQE_FRAG: mapped skb frag, only unmap DMA
>> diff --git a/drivers/net/ethernet/intel/libeth/rx.c b/drivers/net/
>> ethernet/intel/libeth/rx.c
>> index 8874b714cdcc..11e6e8f353ef 100644
>> --- a/drivers/net/ethernet/intel/libeth/rx.c
>> +++ b/drivers/net/ethernet/intel/libeth/rx.c
>> @@ -6,6 +6,7 @@
>>   #include <linux/export.h>
>>     #include <net/libeth/rx.h>
>> +#include <net/netdev_queues.h>
>>     /* Rx buffer management */
>>   @@ -139,9 +140,47 @@ static bool
>> libeth_rx_page_pool_params_zc(struct libeth_fq *fq,
>>       fq->buf_len = clamp(mtu, LIBETH_RX_BUF_STRIDE, max);
>>       fq->truesize = fq->buf_len;
>>   +    /*
>> +     * Allow frags only for kernel pages. `fq->truesize == pp->max_len`
>> +     * will always fall back to regular page_pool_alloc_netmems()
>> +     * regardless of the MTU / FQ buffer size.
>> +     */
>> +    if (pp->flags & PP_FLAG_ALLOW_UNREADABLE_NETMEM)
>> +        fq->truesize = pp->max_len;
>> +
>>       return true;
>>   }
>>   +/**
>> + * libeth_rx_page_pool_check_unread - check input params for
>> unreadable MPs
>> + * @fq: buffer queue to check
>> + * @pp: &page_pool_params for the queue
>> + *
>> + * Make sure we don't create an invalid pool with full-frame unreadable
>> + * buffers, bidirectional unreadable buffers or so, and configure the
>> + * ZC payload pool accordingly.
>> + *
>> + * Return: true on success, false on invalid input params.
>> + */
>> +static bool libeth_rx_page_pool_check_unread(const struct libeth_fq *fq,
>> +                         struct page_pool_params *pp)
>> +{
>> +    if (!netif_rxq_has_unreadable_mp(pp->netdev, pp->queue_idx))
>> +        return true;
> 
> This is causing a crash on IDPF:
> 
> [  420.570632] BUG: kernel NULL pointer dereference, address:
> 00000000000000e8
> [  420.570684] #PF: supervisor read access in kernel mode
> [  420.570712] #PF: error_code(0x0000) - not-present page
> [  420.570739] PGD 0
> [  420.570757] Oops: Oops: 0000 [#1] SMP NOPTI
> [  420.570784] CPU: 35 UID: 0 PID: 1058 Comm: kworker/u258:8 Kdump:
> loaded Tainted: G S         OE       7.0.0-rc1-next-devq-030526+ #34
> PREEMPT(full)
> [  420.570844] Tainted: [S]=CPU_OUT_OF_SPEC, [O]=OOT_MODULE,
> [E]=UNSIGNED_MODULE
> [  420.570872] Hardware name: Intel Corporation M50CYP2SBSTD/
> M50CYP2SBSTD, BIOS SE5C6200.86B.0027.P10.2201070222 01/07/2022
> [  420.570912] Workqueue: idpf-0000:83:00.0-vc_event idpf_vc_event_task
> [idpf]
> [  420.570967] RIP: 0010:netif_rxq_has_unreadable_mp+0xf/0x30
> [  420.571004] Code: 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90 90
> 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 89 f6 48 c1 e6
> 08 <48> 03 b7 e8 00 00 00 48 83 be c8 00 00 00 00 0f 95 c0 e9 8a 25 2b
> [  420.571078] RSP: 0018:ff6bf03aa83e7bd8 EFLAGS: 00010246
> [  420.571109] RAX: ff3579f9888ed0d0 RBX: ff6bf03aa83e7c78 RCX:
> 0000000000000000
> [  420.571145] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> 0000000000000000
> [  420.571178] RBP: ff6bf03aa83e7be0 R08: 0000000000000040 R09:
> 000000004b1a4093
> [  420.571213] R10: 0000000000000003 R11: ff3579f9bed90ee0 R12:
> ff3579f9d58c6060
> [  420.571247] R13: ff6bf03aa83e7d88 R14: 0000000000000001 R15:
> ff3579f9d58c6050
> [  420.571281] FS:  0000000000000000(0000) GS:ff357a195e9db000(0000)
> knlGS:0000000000000000
> [  420.571320] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  420.571350] CR2: 00000000000000e8 CR3: 00000023b2e2a006 CR4:
> 0000000000773ef0
> [  420.571384] PKRU: 55555554
> [  420.571402] Call Trace:
> [  420.571419]  <TASK>
> [  420.571436]  libeth_rx_fq_create+0x7c/0x380 [libeth]
> [  420.571479]  libie_ctlq_init+0x304/0x460 [libie_cp]
> [  420.571516]  libie_ctlq_xn_init+0x29/0x230 [libie_cp]
> [  420.571550]  idpf_init_dflt_mbx+0xa7/0x170 [idpf]
> [  420.571611]  idpf_vc_event_task+0x15d/0x2f0 [idpf]
> [  420.571655]  process_one_work+0x226/0x730
> [  420.571699]  worker_thread+0x19e/0x340
> [  420.571729]  ? __pfx_worker_thread+0x10/0x10
> [  420.571760]  kthread+0xf4/0x130
> [  420.571785]  ? __pfx_kthread+0x10/0x10
> [  420.571813]  ret_from_fork+0x32c/0x410
> [  420.571844]  ? __pfx_kthread+0x10/0x10
> [  420.571871]  ret_from_fork_asm+0x1a/0x30
> [  420.571909]  </TASK>
> 
> The driver will call idpf_init_dflt_mbx() before the netdevs are created.
> 
> Thanks,
> Emil

This series is based on top of the latest net-next as the PR will be
sent soon. net-next doesn't have libie_ctql.

For the tree which contains ixd this will look different as it
introduces ability to pass a device instead of napi_struct. Once this PR
is accepted, we'll rebase the next-queue to handle this.

Thanks,
Olek

