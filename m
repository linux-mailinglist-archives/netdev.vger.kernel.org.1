Return-Path: <netdev+bounces-175855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C93A2A67B74
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 18:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25DDB421508
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 17:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127D220E33A;
	Tue, 18 Mar 2025 17:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cBQDdNta"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D647128816
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 17:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742320656; cv=fail; b=tvMjvB6rGPtgDAnIE6EKzpfiDJM0fNc9vMeY8CK9OgOw9HKWoJSVB0Z3Vw6oHPGgfloGSWY//RkJS87/GtBQ7YcvEFaUW5md8rZ4S6XBIlimX8rOfFO6UjmZU1aY1NMSrIaMqJTxTZ4bAVuLClfFGPKx11529uOxtVpIKHbvMA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742320656; c=relaxed/simple;
	bh=TYzxl3ivqkfzGB22DJ5rDBY/davNyxFF/becGs3isDI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XrO5+RXGbNltx+idY2/c2ml8aOUM7zTJJerjlYzfIzIU3JglsJIa3xu1MHsUrcolFim/QKh1/9U8TzXiMEXwbv7FHu1LpQe2QY0PNMAPf3P39SO+npgYBt8GLdwaY5zI6pL0LeLnbaXZ+64rCu4vihQughv7VZf6ZpggpDq1/Zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cBQDdNta; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742320655; x=1773856655;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TYzxl3ivqkfzGB22DJ5rDBY/davNyxFF/becGs3isDI=;
  b=cBQDdNtakq3NCXta5IgEAQUl3MTRs1cEM4XAfuEagrnEZbvDUKGJecM2
   CjPWjwJ9taRxEfTzzw5TAz3KmrJXPJ3ps8SwSEuOiopGmU7qK4FDlubza
   TwsbTNeq4DpTFRqtejKnpQiWtVP1Kv3TZPGrSG9hJ5I7MIagvkY+S3kpT
   /SJb0wD8Tz65lqbJrS+4a+z0wLVZPrZELxwko3cPghx+/i23q+HDa9AC9
   ZrtpK74S8wsRyb5+3UXY+CwM/NK/etdoMv0Ly6InRxirnj/4m7L3fN9ev
   TNp6+hwPNm8J3MqZzk3gXT+DFM3pNLP9LAynrNWtmjywJEtmJIswnMvtO
   g==;
X-CSE-ConnectionGUID: 9ZzGSODqQraoYFwA4TfnBg==
X-CSE-MsgGUID: sanwVrffRkCMOX4gxroUog==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="47258506"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="47258506"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 10:57:35 -0700
X-CSE-ConnectionGUID: w+rdawImTBO9of5U4Nmaow==
X-CSE-MsgGUID: XZqK9hIOQpmEFuUQ9pO3tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="126998904"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 10:57:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Mar 2025 10:57:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 10:57:33 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Mar 2025 10:56:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GnlWzn+gqgDxSH2RdHfmT6bQH7OJa35H/K1ZAKb/A91xT6cYTqXarFMTwwCpGj9ajSHM5ob6cunCMLRQ0W7MrEP94O1DNjuVuG3QAeUdKZ/FrpPaLJkV0mX7ie41N4FW+jOhm+OxqdZtLUC2AQruBnsCe6JmqMUnhsVg8RXXuGAzbfu2EliGxTad20zMKO6ucm1FAE/TMlt3owVsbjfWvDEDi9EAm57Td3YfycHMXMqgQC0jmPtEnEFI+t+1pcybPbRvxEUyquezpNIzzIRnp+lJrlQcrWaUWgb8ZpVTINM/3SYmlYEpPi+BovkIroji86rOZ9Y8X3hJ3fc1Y8yhgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qN7EU0gplvdhmEou5cBg/FAS1qHR3sPXh4f9wxEqX8U=;
 b=DnuExhTX6z3eI9CzPo/wxj4RB48NH2LLzC+EpH2b9JtLWLamfW3gZ+FhkWuhMY8TcRW6LP/oEcQ6SvtuhXYS4lN56HAwSIbzOZGw/r4QEASXB+V70n4IWz7YuGAUu0FGy2sU2E4SevemrhLEdIHnlqEYgQ5JB4mWHpTks7yjzYASP7jrUU80dtlerGR8KGnX0EwRjkem44Xe1XuGTHVQXy+nwfFC0YCEzS78ucE3FRcnZZOs3h9knyXYegan93j3BS9VyRmua+V4GJpkBvT+oH9K1klltTCsJCLKM3ZOFXZva2VnL94VbxNSOw9in9YXN5Wr1FXVgemDoNwTSIrH8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by MW4PR11MB7031.namprd11.prod.outlook.com (2603:10b6:303:22c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Tue, 18 Mar
 2025 17:56:37 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%5]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 17:56:36 +0000
Message-ID: <4ccd0692-3c74-4631-8ce3-523bb55ef9cf@intel.com>
Date: Tue, 18 Mar 2025 10:56:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [iwl-next v1 0/8] libie: commonize adminq structure
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <aleksander.lobakin@intel.com>,
	<przemyslaw.kitszel@intel.com>, <piotr.kwapulinski@intel.com>,
	<aleksandr.loktionov@intel.com>, <jedrzej.jagielski@intel.com>,
	<larysa.zaremba@intel.com>
References: <20250312062426.2544608-1-michal.swiatkowski@linux.intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20250312062426.2544608-1-michal.swiatkowski@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0207.namprd04.prod.outlook.com
 (2603:10b6:303:86::32) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|MW4PR11MB7031:EE_
X-MS-Office365-Filtering-Correlation-Id: 2370a00d-c7d4-446f-a81b-08dd66463a2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d2pMU3NKbUZZUnpFU1NQU2thVXQyOW10akRPWXF1bUhqMVZaNnRXcnJEY0dn?=
 =?utf-8?B?Y2FnM1dLOWxxb1dOR1B0K21Nb3dGcS9BckZmSXhhNmxTc3FYbUJkbnE1b3g2?=
 =?utf-8?B?dkc5N2pScCtEVzRLZ3VpNEVHNFpYdktFS1lUT3QwUEpYL3MzeVl4ZDVIcmN4?=
 =?utf-8?B?T29CQ3p1OENHeU90Q29wbElvUGcvWnRBUjR5NlFXeTBJcUs5Y2JoNmtETkNR?=
 =?utf-8?B?dnNaRTZ4b1RlOHZQNmhPdlhHRkZBZEg5SS9acEx4OFEvQmhMc1MxbTdnK2I0?=
 =?utf-8?B?T1BFZzMwYjlldTUrU0xXR1hrYk5pQ2hCL2dNWEg2SnRFWnlVaW02NnlxV3Yw?=
 =?utf-8?B?OFRVaHRIVVdBdnY4dnAvNUk3d205ampDNDA3NVB0WVZUYkJkanZKa2hWWXlw?=
 =?utf-8?B?ZXUxYTQ3QjJZWmppNUsxUU9KZUhvbW04dDdmdG5HUFhzQWl6amUxVnh2dkRI?=
 =?utf-8?B?enZtQ21oU1NVV2xHd0pESklnMWlWTjNRZDloWDUxWmFCK3IvOUxoTnFOVVBJ?=
 =?utf-8?B?YnNxd200Y0t2Zjc3NTkrK1MzRjhVZ2tRbG1USUdmeVFBM21SWTdzZ05YVDdP?=
 =?utf-8?B?a0Z3K2xmSUVHOXNWNTA2YUlhN3hGelVCWVJsUERBYkVyRDQ4azhVaEJwYlNF?=
 =?utf-8?B?YloxTnozYVgzYkE2UUc4aGltVEpLSHhxeGljenBUMTR5VjQzV0RvQXd3NkZm?=
 =?utf-8?B?bllGZm9SN3B6UW5hbGtnamY0OStpR3RLWWxwdm54WVdJZUkyV1Fqc2JDZVJy?=
 =?utf-8?B?d3RyekZFNWZJcUozUnFDVVFaclRzMGZLcFE1RlhRUEZvbi90MjR6MGUySEZ3?=
 =?utf-8?B?eUJnK3ZKcGcyZGM5bGg4TVR2YWNlME82S3NpVVZocEk5MW9hVU0rN01Pck0w?=
 =?utf-8?B?bTRQdjdGT25OTE9hemdhdXIwQ3BobXQ0cjhCdW1ydkNFVitLTmQrSkFaUG1v?=
 =?utf-8?B?SG85bzlMZFFzc0luTEJ1dW5YMnZHOVI5UlE0TXlWZ1ZuWmVYTmp2cVR0NHI5?=
 =?utf-8?B?ZzJoL0pYQ05DL1VHTzFmMC9YTHdxUC9xT0dPSFFZVVVHMUg1N2UwNkpKS2ZN?=
 =?utf-8?B?aDl4VVJublFSZ01BaXl2YnVTV0hwMGJ6NjNoaXRKSjlHb1QxS0lHQi95R0pX?=
 =?utf-8?B?UmFMZWVmV2dmL1ptQjRYckI2dnZPazdkQnBCeVVVTTl5SEw3cDAvSTcxN0xN?=
 =?utf-8?B?K1FTbUo4cXJvU2dxUTNHcy9aYXBMeWNnZGxORmNFRGlRclhrK1U4RmIzTngz?=
 =?utf-8?B?WU9DZWUrSVBjQWFzUi9UeVYzWEcwUmx2NUxZVkF1ZUYvTWg3bFkyZ2lWTUIr?=
 =?utf-8?B?UXNVL1ByRXBRMkVVYU8yOG9uS0tuRHE1cGkvWDVmN0ZpZDFEejVFekFVM2Np?=
 =?utf-8?B?YUNEaU9wU1JaL3Z0WkNRL1pPNUlZYytLa0x3K2VIVkFWcWVuQmZ6ZEh1QVdN?=
 =?utf-8?B?T0tyWVUyMWJzbTJXS0wzRUhPTTVmQWVVNGxnNEVpOFlabVMvZXY3NmREL3Yz?=
 =?utf-8?B?RkVOMTUwZ0huU3hlSGlBbm1NaDhYcjFNa2pIS1NxUlM4Zzg0cTJzK2F1Vzc5?=
 =?utf-8?B?bTNkMFR6NXNWUjh1d0U3elBDR3kzeU1NTnI0ZW5nYnRhdUxSOUR4M0dZN0tw?=
 =?utf-8?B?QUswb0pFOW9DYUxITXZIcEpnYVh1dENGNTZoS3JBc0tKeEM4ZmFuVGl1aXFS?=
 =?utf-8?B?MWh1WnRDTVlXaGZ0NVVaMHptYTlPNEl3cExncWpPbkhEamNFTGVQWW1HSG9P?=
 =?utf-8?B?VTRCaE1Oa2xTYXJYMDVoaDhmaTJzQjVKYXpndnlHVWVWa0VaWEJ6b2lrUG1S?=
 =?utf-8?B?ZEx1b0x2eTMzYjdOTGpSMVdHTXpVM0VrYnY0eGRBMU0vTnhaK3pLL0oyZStX?=
 =?utf-8?Q?IKmK7v/4J+MOC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnpOaHlsaFVqNjRuZVEyYURMdFpSUmJXYis1MW9UMndVUlNybFYxbEh0ajk2?=
 =?utf-8?B?dkpNUmM2bXJpc3ZSWVFPYzkwemJTb3doZ2pXOExsRXgxV2lxbHRJN1Y1dXEz?=
 =?utf-8?B?aG44YmhYWEgwdWZ5WTNpaXFFczAyTCtJQWNlR0UvcUlEWFF3aklpNVIySFF6?=
 =?utf-8?B?NTNxaHZ0YWxDalVrZFk2dDVpMkpRU2lhNWNBUElQcGlaeG5Eb0tMZVM5Vzlj?=
 =?utf-8?B?d0oxZDQwMWFGSTYrVzA2djhmeW42bEVjU3ZjUDUxL3JtYTY3cHEvYS9LeXdE?=
 =?utf-8?B?ZndKaVVISWRQdElGS0NqSFJXRlIwb1cyR21mMEYyKzJmU2tVRjdYRlhhR0NT?=
 =?utf-8?B?ajBkK0p5VTd6SGg3eWtHZFcxTEw4aW8wazJidzZYaE1Yb3V4TWltUlViSmFZ?=
 =?utf-8?B?TkxkNHZhcjU3YWF0SVpMSWtDa05ZZmZsWURKTS90V2NYOTZYR3lsaGhjajVq?=
 =?utf-8?B?UU9CdHBCaHZIcGNQR1ZIMWd5NVU2TWxCTUkvSFdtNk44SThBMVY3NXFlRXFP?=
 =?utf-8?B?VWpIbGtveU52YVd2YkVZdXdOSEpEUzRtdlVWcld1QzVwU3hQVFBTcWh3dVkr?=
 =?utf-8?B?ZGpwa243OVc0dUh0akw1UGFHNEJrVUxQNUQvRzgyZDJMVE1lZ2ZkTWdSbDYr?=
 =?utf-8?B?UVVMRHdyek5kTzFZZVFaRVl6cHdWTkw4d0ZVTURJekZ3Y1lqYWNFM2J0QzlB?=
 =?utf-8?B?QU9KYUlEakxENlJnbEd2ZG04TjNlU3ZoNlRuZHJQRVVuTEpBcmdwRDlhSVB4?=
 =?utf-8?B?R2IwN3BjM0JsdWdwVC9DeFFSekp6aUZJck9VOWYrOXJBdG53K01qWUNNaUhW?=
 =?utf-8?B?NWVyTHNSUHpqMEw0dGlWRWhuWTJrbHcxL3laS1FMZkw0R3ordDIrejdZL1R6?=
 =?utf-8?B?RFBZanBWVHBkMUlNTUk3dVlMeVpMK1kyS2t2bXl2RnEvK0M4SXFnVi9sbnIx?=
 =?utf-8?B?UDNRbnNBSnBMblR5Y2NVVEZuc0p4MWxMNkZQeTBNREtzVG9JK01TSzZCS2xQ?=
 =?utf-8?B?NU5nemgzT2cyV011UTBQb1Rkd0VFeHR3ZGdrN2kxaDBjTDJnWU03cCtILytM?=
 =?utf-8?B?ZVI3L3Jrb3FvMnFFZ3k5Q0ZFUWh0S0JiVzY3VkJoNWVPWHFwOStHRjlJOXg2?=
 =?utf-8?B?WitqN0pJSEc5TkErS0FVUG44K0lCeTJSTDRjWXhQWDBhZXhrM2g2UFhWSkFm?=
 =?utf-8?B?QUdmZUxJakxvUWdVTzM0VnpMRUlxZ1JXZllydGxZQVU5V1RVTmJVazJ3emV0?=
 =?utf-8?B?WGVveU50NDZ3QjVuYTMwSGdpb1ZYNDc1M2hYRldnUnlqTitxLzFSNXJFN2pz?=
 =?utf-8?B?S2sxQ0lRWXZsLzRFNXk5VzRqU0MvTFdvbVF4bGhjU01rSnpBbjQ2cm9UQVEw?=
 =?utf-8?B?aEZqclAyaW42UUF3S3JyTFRSbXliSlBvYkNBZXQ0UitzMURGNi9aaTVZK0Jy?=
 =?utf-8?B?dmhONDhTREhSRVFiazlScDVkME4remN5Z2dYQ0hNMXRYZm0zR1hjRE9jQnlr?=
 =?utf-8?B?bkVvaGFkUGZTalpsUEtEcE9YNEd3dGp5bGd2T0tva2pyWWV0S2llVXBRRzB6?=
 =?utf-8?B?QkhxR1MvN255My8rQU1pLzJZZWc3RmpTeEE2dkVvT2tuQlAxS3BjdmV6MnR2?=
 =?utf-8?B?dExDVDhJQkxlSGNTdmZsVWVzWmZZYVBnOTRXeDFtS2Z4dWlnNXJrbGJyVjJs?=
 =?utf-8?B?YkkxSWMrWGd1L3NoeG9NcmNSb3owOGZjUmFieU43bjlDYjlVbTZRV2FSSUx2?=
 =?utf-8?B?eHJINUdxRHdMMlN1RmxDa3lRNG9Ya202MEJGWTN0MDRnUHAwVzlvNjduQTY0?=
 =?utf-8?B?cEkrMy9tSGFQbEN1dno2d3Zma2dnUHIrYnZCZ0UvRHYvK1ZYdFJKWWJTVFM5?=
 =?utf-8?B?dlV4aFdyUzFnZ2ZWM040YXBPbDNqaVhiV0kra0NyeVJWclFxTUpUT3Y0Q0da?=
 =?utf-8?B?WFY4TFNFbjcrL0FmS0xtblczU2tjbnM4eFZwZFhtQmZtcHZsWGxTUXhzdVRX?=
 =?utf-8?B?b21RcDBRVXZvRm9KVTR2RmM0QmhwSWI1b21lOXF0NjloUnM2a0FWNHE4ZjY3?=
 =?utf-8?B?UXZZSGo1Q0lraThPeTlndW1MK1pRZENRRXJUZjdNcDBENWp6RVBYb1JtYzJ0?=
 =?utf-8?B?TDB5UkhpVjViR3dJZWdmM29jY3p3b01VRVRKNnNidTJlWTJoY3NOVm5oMDg5?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2370a00d-c7d4-446f-a81b-08dd66463a2e
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 17:56:36.8200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGpZ45jHchidCV54Z+1QU4oonIsgyfrV81a5Cw7NmRUJqSm/wESgdG2rXTZM84AMHr0kxohD6zFQA/AnDv8aq0wXHqzzZHIG+Ga4zt019o0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7031
X-OriginatorOrg: intel.com



On 3/11/2025 11:24 PM, Michal Swiatkowski wrote:
> Hi,
> 
> It is a prework to allow reusing some specific Intel code (eq. fwlog).
> 
> Move common *_aq_desc structure to libie header and changing
> it in ice, ixgbe, i40e and iavf.
> 
> Only generic adminq commands can be easily moved to common header, as
> rest is slightly different. Format remains the same. It will be better
> to correctly move it when it will be needed to commonize other part of
> the code.
> 
> Move *_aq_str() to new libie module (libie_adminq) and use it across
> drivers. The functions are exactly the same in each driver. Some more
> adminq helpers/functions can be moved to libie_adminq when needed.

There are kdoc issues on patches 1 and 5; mainly that the structs need a 
short description. Also, patch 3 does not build cleanly.

Thanks,
Tony

> Michal Swiatkowski (8):
>    ice, libie: move generic adminq descriptors to lib
>    ixgbe: use libie adminq descriptors
>    i40e: use libie adminq descriptors
>    iavf: use libie adminq descriptors
>    libie: add adminq helper for converting err to str
>    ice: use libie_aq_str
>    iavf: use libie_aq_str
>    i40e: use libie_aq_str
> 
>   drivers/net/ethernet/intel/Kconfig            |   3 +
>   drivers/net/ethernet/intel/libie/Kconfig      |   6 +
>   drivers/net/ethernet/intel/libie/Makefile     |   4 +
>   drivers/net/ethernet/intel/i40e/i40e_adminq.h |  12 +-
>   .../net/ethernet/intel/i40e/i40e_adminq_cmd.h | 155 +---
>   .../net/ethernet/intel/i40e/i40e_prototype.h  |  15 +-
>   drivers/net/ethernet/intel/i40e/i40e_type.h   |   6 +-
>   drivers/net/ethernet/intel/iavf/iavf_adminq.h |  12 +-
>   .../net/ethernet/intel/iavf/iavf_adminq_cmd.h |  83 +-
>   .../net/ethernet/intel/iavf/iavf_prototype.h  |   3 +-
>   drivers/net/ethernet/intel/iavf/iavf_type.h   |   2 +-
>   drivers/net/ethernet/intel/ice/ice.h          |   1 -
>   .../net/ethernet/intel/ice/ice_adminq_cmd.h   | 267 +------
>   drivers/net/ethernet/intel/ice/ice_common.h   |   6 +-
>   drivers/net/ethernet/intel/ice/ice_controlq.h |   8 +-
>   drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |  12 +-
>   .../ethernet/intel/ixgbe/ixgbe_type_e610.h    | 226 +-----
>   include/linux/net/intel/libie/adminq.h        | 309 ++++++++
>   drivers/net/ethernet/intel/i40e/i40e_adminq.c |  68 +-
>   drivers/net/ethernet/intel/i40e/i40e_client.c |   7 +-
>   drivers/net/ethernet/intel/i40e/i40e_common.c | 730 ++++++++----------
>   drivers/net/ethernet/intel/i40e/i40e_dcb.c    |  10 +-
>   drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c |   8 +-
>   .../net/ethernet/intel/i40e/i40e_debugfs.c    |  46 +-
>   .../net/ethernet/intel/i40e/i40e_ethtool.c    |  36 +-
>   drivers/net/ethernet/intel/i40e/i40e_main.c   | 240 +++---
>   drivers/net/ethernet/intel/i40e/i40e_nvm.c    |  18 +-
>   .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  27 +-
>   drivers/net/ethernet/intel/iavf/iavf_adminq.c |  62 +-
>   drivers/net/ethernet/intel/iavf/iavf_common.c | 110 +--
>   drivers/net/ethernet/intel/iavf/iavf_main.c   |   5 +-
>   .../net/ethernet/intel/iavf/iavf_virtchnl.c   |   2 +-
>   .../net/ethernet/intel/ice/devlink/devlink.c  |  10 +-
>   .../net/ethernet/intel/ice/devlink/health.c   |   6 +-
>   drivers/net/ethernet/intel/ice/ice_common.c   | 376 ++++-----
>   drivers/net/ethernet/intel/ice/ice_controlq.c |  53 +-
>   drivers/net/ethernet/intel/ice/ice_dcb.c      |  36 +-
>   drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   2 +-
>   drivers/net/ethernet/intel/ice/ice_ddp.c      |  47 +-
>   drivers/net/ethernet/intel/ice/ice_dpll.c     |  20 +-
>   drivers/net/ethernet/intel/ice/ice_ethtool.c  |  12 +-
>   .../net/ethernet/intel/ice/ice_fw_update.c    |  38 +-
>   drivers/net/ethernet/intel/ice/ice_fwlog.c    |  16 +-
>   drivers/net/ethernet/intel/ice/ice_lag.c      |   4 +-
>   drivers/net/ethernet/intel/ice/ice_lib.c      |  10 +-
>   drivers/net/ethernet/intel/ice/ice_main.c     |  63 +-
>   drivers/net/ethernet/intel/ice/ice_nvm.c      |  38 +-
>   drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  20 +-
>   drivers/net/ethernet/intel/ice/ice_sched.c    |  18 +-
>   drivers/net/ethernet/intel/ice/ice_sriov.c    |   4 +-
>   drivers/net/ethernet/intel/ice/ice_switch.c   |  55 +-
>   drivers/net/ethernet/intel/ice/ice_vf_mbx.c   |   6 +-
>   drivers/net/ethernet/intel/ice/ice_virtchnl.c |   6 +-
>   .../net/ethernet/intel/ice/ice_vlan_mode.c    |   6 +-
>   .../net/ethernet/intel/ice/ice_vsi_vlan_lib.c |  24 +-
>   drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 272 +++----
>   .../ethernet/intel/ixgbe/ixgbe_fw_update.c    |   4 +-
>   drivers/net/ethernet/intel/libie/adminq.c     |  50 ++
>   58 files changed, 1567 insertions(+), 2128 deletions(-)
>   create mode 100644 include/linux/net/intel/libie/adminq.h
>   create mode 100644 drivers/net/ethernet/intel/libie/adminq.c
> 


