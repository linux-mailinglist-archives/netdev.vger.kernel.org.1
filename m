Return-Path: <netdev+bounces-210594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63520B1403C
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 18:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73AF5189D5D6
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 16:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747B82749C7;
	Mon, 28 Jul 2025 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QVjF96Yb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BBA2741DA;
	Mon, 28 Jul 2025 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753719653; cv=fail; b=o5Hu5GbLX5W1dPemZCMtmGhM+ZBtHz5WH7n2RHV70Xcn656cgS7IsVU5AP5qamorusucuveMZ/bp0YY4XgcCxjVjXu3am6Wg/bgx9JJsVbWiRl5y6CuivCu/tmzYJWqsKR9mcIV/LVTZHu+481z9jTaXS9eKfQPLh+flk6efPL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753719653; c=relaxed/simple;
	bh=a7US/dv9EWMobwZebkjhe3FG9nCR52YhRxRi5WDHuIw=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=b9S+NaCGFHUp+TxCJmHUpE4sdIfKoApRMFI7CifsdDU9RZ1FA1A7PpSuAVkq7kDD/+XNiJTYzxIfM9kRcuhqVz22LihkgsAu1WgXlbK+AehOQc1dZ7T7g42GwdvBd3d1ZwTqeuTb01hO1rjC+S45MgYv2QAW3BYdBqJjJFflb5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QVjF96Yb; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753719651; x=1785255651;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=a7US/dv9EWMobwZebkjhe3FG9nCR52YhRxRi5WDHuIw=;
  b=QVjF96YbqCoHPsaHJtADhS/aucA36j6dLFohQpSGTIuFz7meg+4xROvF
   9fe+gVrSuRa2cUAfrDWTOkQ9oklKSBZ0Lb1+4DvQowgOl1xXBxrfPetXP
   kmX/31wujgKO0GaOWFW1c7mQcifMD8k2yENGWeVCDIbSBMQPDpZstqWkN
   strS6n+zVuj6rWltkQKcry9NPL2uL85S3wDCXyAS3oBqVfvNXwibc7JXM
   6+BOnQ5XUJwcFFD8orHLUFqFKczTY85WN/PmIGkLrmtMZ7IJNhQwOs7sm
   1ITXGBSTn7Z5HRaY+boAevD2JcMxuAfzGUCHKSAcDskS61qRirRbmAAb4
   Q==;
X-CSE-ConnectionGUID: DQFX9xy2TqGQO5wmZSnpnA==
X-CSE-MsgGUID: NpB+F38iS/Ow8C5+LCRVXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="67328323"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="67328323"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 09:20:50 -0700
X-CSE-ConnectionGUID: aUlSwVaESTWLGjLcQiS/XA==
X-CSE-MsgGUID: KHu24HegT+OzwUZkC9e+bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="193305128"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 09:20:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 09:20:42 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 28 Jul 2025 09:20:42 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.87) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 09:20:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pyyh7c5xOK1DeHcCu2d1bO5Z7yz33XatpaovVGlo9TtwNHz9arkiw/9OZH83xSSkkquNx/nxZbkiZvYrk6iuwS6NBmx3LLM/aRM5MfgoIT/4yPscmlp9t4jIBMOYZnvGhjz53b7NJ3h76a6vB+PkO/vpn+ztxm6cwCZ0nzc2ohzsSNmVnXV/m5H3OzYYMtrdNNy3SmjtXCW3sovsxrmG/ZCcw83LVFQ6JHPgvBMouQqfnb4cwgUSg2zmymhKGo2ooFp2mO9R3/zPjCdTaPFylaTbSGQ+w8s88ogWUtkJNlhiOkvI8Ahx7TSUP3pU7jWp87tYYvvapNlbHLFSN1xIPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ke41nD08nsMJH5Egb4RmY0S/zlT7O1hlbhTAofQU1pA=;
 b=e9kOXM2o6p/M21Co628gHuU6qqqlVk8riK9qZaV/yuT9RE53dW1505ZeT/rdxkZuLBWf5i0qktoSrl0cL+MCoT9wQBSQm//VZfbKdVm80lkSk2q9i4tUSlXJdBHdnEuzxDzEHNWuB77X53k3GSyz3XWrV5N4Hgc57WMbybPdxzS1vIMZMIPOBFAleJhhbOwk4nzsAM4SNA9A44spSJ9B9iHY9kbXW3N8k8FSmUlDetXulBCGbLPmBAfpStiemZ/ZmkBeNnPZXlQMDUP4OnIbPXgkaDpJcHPDQcA21yzWVo+s9qHrkH5N7iUWb01tN+SOEanOzItscsEJ+Wl3WK9zcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB8123.namprd11.prod.outlook.com (2603:10b6:510:236::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Mon, 28 Jul
 2025 16:20:26 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8964.019; Mon, 28 Jul 2025
 16:20:26 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 28 Jul 2025 09:20:24 -0700
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Message-ID: <6887a3482072a_11968100ac@dwillia2-mobl4.notmuch>
In-Reply-To: <20250624141355.269056-21-alejandro.lucero-palau@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-21-alejandro.lucero-palau@amd.com>
Subject: Re: [PATCH v17 20/22] sfc: create cxl region
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0118.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: e353dfd9-d18a-4ec8-cb6e-08ddcdf2a918
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2d5aGFjb3VBb244RUtiZEJFYlRjTGlUa3hRVGowOEtXNDVOS0M2TFVZSC9F?=
 =?utf-8?B?ZmFnaEdxYkhJcFhxaTExZWNBUFhVQUkvejJ1aE03WXRzZ2NURVE4VTlPODEv?=
 =?utf-8?B?UTRpeFBmZ2xtcm5hRUVFbFFlYkxTOHZPZVZKYzlxbEJ1WVRqVVB1Z3BHMzUr?=
 =?utf-8?B?Tnp3UEZVU0x5Vkl3d0RPYVh0eDl3TmFIa0MzN3IyMjVsS1NydnRoYUxaTldx?=
 =?utf-8?B?MjcwYml5VWNVOUlyNnZVVkZFVHJnWXZkbmZldENpVkVEVCsrRUloYVZJQ3JV?=
 =?utf-8?B?VzdmWkFLQlVXejR6cmY5R0dnQmxhRHIyK3dTUWVBb2tRRVZRcGxWd0ZmMVEw?=
 =?utf-8?B?VFZkWENZS0pMdzJ3Z1hSUlFPaTBYZ0tFVWlObnVUa212b3N0YXhRM2hURWVi?=
 =?utf-8?B?QzJ3T3lPbjBFbmd1K3hUc2ZaSlZXaHRqd2dIVUY0UFZPWmtMemtCaHE3cTQ5?=
 =?utf-8?B?L0UxM0xkNlpaNUZzd1YzK2dQaEpUbDJEcTQzSi9MQ2xHeUc3azJYTjQxYWR3?=
 =?utf-8?B?dnhJeEhPcFFXSnRmWjFoM0Ivc081QmJGa1Q5V2IvQUxtaGF1dlFKcXdYcjZD?=
 =?utf-8?B?ZTBPVjdmOTZlNDlla0tkdHJMQTlodjMwWUpPOExiN2xrSDArRzVaTi9oY3BV?=
 =?utf-8?B?cTkvTTg4ODg3S0hoQWg2SFV2UlQvUUFHWUVlWkxpY3VEak9VVmEyZ2RwOHps?=
 =?utf-8?B?ZXYzbHQwV3VERnV1b2NKWVAvTzNTdDcxRmtwRlBUYzl3dnQxamVwTmplM1VS?=
 =?utf-8?B?QzlGdjlzcVY2UWc3MjZmUDJIdHNiaHQyWVdJTnNqTTBBc0l1L292alhhdDF3?=
 =?utf-8?B?RWtyWnpmRzE1RG1zaW5TbnBJcmZzem9KU3dwSnZyY3BhRUlzK2oweTZHVWhz?=
 =?utf-8?B?Rk5iQW5LdDRBTjZuRVk2aWFzc2JuYjNQNzlOdlVRalVUOHRxTlVGVDVKMUxR?=
 =?utf-8?B?YUoxQ1ZDbzdXM2praEZQdmZTSWJDbTFnNzljSVRDNGxMVFRXakE4OGpOclFN?=
 =?utf-8?B?TW5tNmpnTlliK1JxU0Y3RjFlcWE5M2gyL20rZEhvbG9EQ09rQ3B6OE5pZEgw?=
 =?utf-8?B?b3VyRDdRWkZlZ1J3Mks0eHNhQXEvTlR0K29RcWdDdGh3Y2UzeEpvYURlUHI4?=
 =?utf-8?B?L3ZXRnhuN3A4bWlHQ0tPZHRMeFRZQ3VKQ3Y1VW1hRW96RUFiTUxtcmZFR0Fi?=
 =?utf-8?B?ZHR6NlhXaTBNMlZoeUZyQXZlUjZLbGIzdjFlYUNlMDg5OW5yMHVNZUFCR0Vo?=
 =?utf-8?B?MFRxUFNlNytReWFiRHQ0U3ZPdkFoRldRUS80SFNlRm1MdnFFbUw4dmRIcDRp?=
 =?utf-8?B?TVdCcndQbEVlYVVpWDI1c1hhanQ4VWRPNmVFSmtmMzZjL3Zyck8wd20vNUwx?=
 =?utf-8?B?bExrR2hraGRMTW1NcGUrbXNqMFZQV2ZGbC93T1VqQUNUc2QxMkc0c1lHWTU3?=
 =?utf-8?B?TkhIUWxrTXBxR0lEKzUrZDhvR01xZXhVaHNwd2FZbGkxSnRWL1RTZjhDcUtG?=
 =?utf-8?B?TlRqTjN3S1Jta0pTNVdyU0lWV09FYTVUcGVZMk9UeDc0VnJFRGhSYnJGNDQ3?=
 =?utf-8?B?TERUWXdRSEU2TXlMei9LMXVoSzdNSTczWWJzekxXTmtXOTVKYkhvb3lEMTU4?=
 =?utf-8?B?VEhpSVI3ZmRJNmRHb1Y3c2JWNGdNV0pJL1hMUWtTT3RlbjBnQW1LTnJDSEQy?=
 =?utf-8?B?ZkRDcTArTFcyeHNDUFhWRUdYMThvZE9KUVdMUGt2NmwzOWhkeDVSeFFuMjc1?=
 =?utf-8?B?NURKSjBvekRUaG1Xemx0MDhpRkpOL0hRVEI0NTlGeGVsN0hKdWlqbTRnTUVv?=
 =?utf-8?B?WGhWeXgzRGNGQklxTnl3Mm1ibmdOb0U0VXJxYUhsMFJEbHF1VGhncHM0UHlY?=
 =?utf-8?B?alQyd0xSSWJLQko0akx4SFJIdnJXN2owcUtoMFczTTZaOVNzeVFmL2xHeDlN?=
 =?utf-8?B?cUtJYlRjNzNYRkI5N1dhMnlKeHc2OXFUWnRxZ0RkTDZBK0dOc3Y5bWx1TkNE?=
 =?utf-8?B?NkJDQjAyM0pnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUJkd1ZQNTN5L3FLRGttcU50R0pYSzVnNzN6WTdaSEp5K0RxYUVGQWh6WE5X?=
 =?utf-8?B?UE9UY05yOEllMEMzUlc1akhjSExFRzVlM0k4Y1FPcmpyeTUxcDArcU14SlFl?=
 =?utf-8?B?QnhGY3RxcFUxUnpIZHozSUllTVIwYklpUEJLWk9rQndDa3pJQXdvdnladmRR?=
 =?utf-8?B?amxUMHpSbEU4bE40aDROalNoSjEyY3BKeWFIeDZjRkJIVWV0eW43UWQrdEZY?=
 =?utf-8?B?MXlYRzIyTm8zSSt3Mlo1dmJWMEtGNHhaSmU1dHl0eklBcEVZdjNEUU15bUsz?=
 =?utf-8?B?ODZ4dkhQTWd2eTNiaHZUWFFENWFGOGxMQmhZUHFJTzkwd0VqUDF5QWt2YzVJ?=
 =?utf-8?B?STV3MGQrMlRLTTFzTVpSZFdDMkpMeHdmUk0wUE9VTE9Lb3JqVVVvcU9waU9D?=
 =?utf-8?B?cVI4RjlWQUZmTllhQmdRTEVTVjlkcTVOLysrYXhBTzJrWUVsaUZDSnVHcmhW?=
 =?utf-8?B?K2txZWVPZWFEVXRoS0tvS1dDSHRudTJuUFlhRzlieGJyYWJhZk5MeXJNaHpC?=
 =?utf-8?B?d0VaV0pBWkN0NVFhNThDSm9yckVnMG1JSlRvaGtQMkFweTU2OXF6R2tKbE1S?=
 =?utf-8?B?RUFyeGRSY21jc0JGa2hoazdNbnRZNHM0LzFIS1gxeVJiMHVRMGZXSnZrTmpK?=
 =?utf-8?B?VjBtRWpHRkFueVM4QmQ2WUpzYkQzMzAzZ05kRHRuMFFnbFZIalVGaGJQWmRQ?=
 =?utf-8?B?eHIrSVo5YnE0SnNnVXVSandXdFNCODNJNjQ2RnkvdEZUK2NvL3o4U2ZkcnFo?=
 =?utf-8?B?WVN6cmZqUU8rekxaRmllMVhqelBIMWsrZmpUeDMxSmVQc0dQc2t1T2IxYTh0?=
 =?utf-8?B?OGhLckJqK1pQWWNEc20rU3VvYTRjSDdZUERuM2VFcWo1emxiOURIa2plYThX?=
 =?utf-8?B?VTRYNU5sNWFPZDlmREZKSHF0NWdHSnN6SEJaN1hicXNXZ09oNTJKOE12RmRt?=
 =?utf-8?B?Wm1obHd5d2xhQlRmdFpBeGE5Q3IxSlRXS1ltZ2J2ZWMxNEtiYklmVE50d1R2?=
 =?utf-8?B?RzJVNFJhTGdvT0lZN3dxWHR5dGxOTlcySTNVV0oyeDM3T2NJenl0akFDdURU?=
 =?utf-8?B?SjJoNkN3TjJUTjBOdDI0bVBpRDhBWkJKWE1ua0pKakRZMzArQWxNTzVhUElZ?=
 =?utf-8?B?YnBKeFFYMkxhQUZvaWo4TE55Y1pEd1NDVVl4SE11ZHM1c1R4NWIxVWY4U2wr?=
 =?utf-8?B?WjA0R2paMU95aGFJc29zWm1BQ0tDRnJ5SHFyZGRuYjNRODhsaUJjUFFlWStz?=
 =?utf-8?B?d1ppTE5RSmdpQnRSdWJ4dURoZnFrN1c2ZWJMSWxBVGFYTTdSakhvT25iN3Bj?=
 =?utf-8?B?K0ErQU9Idlg5VXZMWVpQU0FiOVQ4YjdoVG1FOGljSkgvakNCczlYTnFMeFQ5?=
 =?utf-8?B?VVU4RzgrZk5PcStDdWlOcSt2T1NHdW91dlFMRWNBbnB6a3R5UW13ZksvejNB?=
 =?utf-8?B?RGh6ZXZKL0tRU0lRbkFnUlc4QmUwcWtpUlBCOExnMFdJWGRHcUNWNUtlTWVF?=
 =?utf-8?B?T2Y3aWV1eGE4YlE3QThDa1dZNjBEMzFIbkpXUVJ0MHJRYlRSdmV5Q2QySHR2?=
 =?utf-8?B?WnltNTBDcG9tcmhNTEZNYmV2bjZ1a1NmSi8wNnc0SDRZZ09wcHNoc2hXSmd5?=
 =?utf-8?B?RFowYnVScXRlcUgxc2QyRlF1azhiamhkSkVtRTRmWDhDOWhiZUtnc1g0NnNT?=
 =?utf-8?B?SWJWZzBCK3RtUWxmeWc5WmpsZzk1TWFZWGwwaVRIcVZEZEpwc2ViVjcrMXVI?=
 =?utf-8?B?Q3llOWdwTEhmcnRaK1hoTjluZXBzbmZ1Tmw3VElPT0FJQVNvaVp1VDNycWxR?=
 =?utf-8?B?TnQrMGdIcVFyR2M5cXdwdC9ubXhNNU9RSi9CRTBvbmplK1pkZ2hibHhSNVhl?=
 =?utf-8?B?T3BvYXcvM2Q2MDBGdHViTXJtdVVZYzBmRld4cC9XVm8yRFp3dksrV3lOeHov?=
 =?utf-8?B?TFFxN0I3d3dQOGtZaWZzZkVvQUNPSU4wbDBLeGQwR3hkVDZ0aGtHM0FYRmRH?=
 =?utf-8?B?R01OM29Ib2sxMDhmMXdwWnRRY1ZTOHpqZlVETkEyeE9lRFZMNklhQlN1RmxL?=
 =?utf-8?B?UldNb0NiMzk4Q0l0YnFNSXpMZ3dOeTdzT2xNa3RuNHV1cS84S0hFNTQyeGdB?=
 =?utf-8?B?MW4xNW1LWm1yb0JGVGJPRWtUV3ZXYytsT2o3V0lLMGlJZUJDV1RSZjZXWFBZ?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e353dfd9-d18a-4ec8-cb6e-08ddcdf2a918
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 16:20:26.3642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p0OBMVQHY5qw7zfvoOM/nQRvq0q8n3AgUOFP+bcI3iZ3lihXHyiSTXapOP/adacOnUrHJv+JKFJ6vUiHOdWxyhsRvT33mQTr1L4UJUO7eqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8123
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl api for creating a region using the endpoint decoder related to
> a DPA range.
> 
> Add a callback for unwinding sfc cxl initialization when the endpoint port
> is destroyed by potential cxl_acpi or cxl_mem modules removal.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index ffbf0e706330..7365effe974e 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -18,6 +18,16 @@
>  
>  #define EFX_CTPIO_BUFFER_SIZE	SZ_256M
>  
> +static void efx_release_cxl_region(void *priv_cxl)
> +{
> +	struct efx_probe_data *probe_data = priv_cxl;
> +	struct efx_cxl *cxl = probe_data->cxl;
> +
> +	iounmap(cxl->ctpio_cxl);

There is no synchronization here. If someone unbinds the a cxl_port
while the driver is using @ctpio_cxl, it looks it will cause a crash.

The loss of CXL connectivity after the driver has already committed to
it likely means that the whole driver needs to be shutdown, not just
this region cleanup.

