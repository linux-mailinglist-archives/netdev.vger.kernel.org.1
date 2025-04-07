Return-Path: <netdev+bounces-179588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 926C8A7DBC6
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 13:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19DE73A21E2
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 11:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB057235347;
	Mon,  7 Apr 2025 11:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nb91FLRP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4A2218596
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 11:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744023814; cv=fail; b=oP98BeP0j2hpaeW3XpVUGe1WI8SRshDzcLNLdF9uZh9D/H5ZtmErfLEdQOERyVTfSeDOYg8uk4NNIwDS6ylxbOAvKEH9ai3HWS8rEHUml/aWGSB+cOteZOl1HMWpLbCqZLuSZfnWvEz5ZW0PdNXG5FgROsZwdhg7TDYdsiuw+sQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744023814; c=relaxed/simple;
	bh=cmK4558Sf/CWjmoXHw4udav+0U7hOvch5eyTDT83eNY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SLfgniSxb6Kt5dM0NYRjSswlK/NOal3fGLOU/BrE3rfvNsN99RqAVJ4BwNCLDP1oYSj1GP2NnNQew6hYX/8sdiXAtCoizfHR6+G++a9SNW8orkmshOwyHNteRLD5VLhJiwQdOl/LVo9VTEIHUr9/19bzscrM2CYzENfYKDCQAH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nb91FLRP; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744023813; x=1775559813;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cmK4558Sf/CWjmoXHw4udav+0U7hOvch5eyTDT83eNY=;
  b=Nb91FLRPXeCgYaI1/cdj7UvTBdpZ9eGvKWZXcBTg2pmmA8RaCVSJCtDB
   YGoU299F8Q6Ue6HY3fdZoxXxZGuSXAozi3rL0CcIHHZW3mU0rbuHXgoAo
   cH5mx3ISyGIwTUwoJsLztvQnhnFI77+1mnwe3PljPFsK8dLc39T0jAYuP
   mt18gaUpJoQW6ou+RgKx/jIpp/6SgiCvFi0j+YWWv4oLrSq20haOKKDLq
   N3bX4612zrTLwnjfCUVOpCkTZc1hcGaeNq3WsXLRhMaRG/rhtL1tG2TOS
   5BWaFpIpB8mZmpI4PuGxDBt6chFn4tgGvA7QJecqIjmLFjCuEzuhQ2w65
   w==;
X-CSE-ConnectionGUID: xHsQFnmzQUeXdJm/rxKkaA==
X-CSE-MsgGUID: PIG3CiXIQY+PPGjUVDqx3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="49056992"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="49056992"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 04:03:33 -0700
X-CSE-ConnectionGUID: 9N9mfSc0RKWbdWuCLulOsQ==
X-CSE-MsgGUID: lnYu1KzITQWgA5mcCYnHGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="127930255"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Apr 2025 04:03:32 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 7 Apr 2025 04:03:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 7 Apr 2025 04:03:31 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 7 Apr 2025 04:03:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IqmAR/t53xBZS5OUxN+huC64LwvKb0YTGibTnJm0+xZ/j3G8RewCJZiyoCIOWEpyzJsjqFEHn/rmXYV2DhraNhPycvykodN2isU/nQcZ/QTVk9ZPkdK9neS8Lg5eanL4FLcJyN1sPqO/GYLlq2knwBWOG1HSXWQ7BV0oaMJ30418jXHSohdMOv+AWBPpx7u+1+I2aldqvwtjabRYXUEQfBuBtA6BvL+jdszIlQyMikoAhXaMc71xAAGT6gy0X1qenenLRcYnyawO0VZ4qvNA8tF6g9/uUb3+Lr4Wz6Co2KLmZAMblxR007qK0Bp9cRUSIy6reBCIOsIPr0WCJd6Wag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42m2qlM/oMYm4Thitf0SxvOfWXQRNAT4ZyNfhp7pZm4=;
 b=iqy8/S8vnyV5nCp/r0c8Jk6Pukjkgdqy3XOsXo8Xw95rwdpDWwnXZAy4u5TBkdfm8v/Mvw2H8BWvlOHYNCHt+G/ZxqistazHdXD3O1EB5rEmt0VXi2VTEIRwHNyL55ZSLpiYemlSZlyWAaHoD9+Jkrup65HpUPofXkQ8tbZDPSixQYbjrshDwRLdNRyJ/FO87aHeIIxyARVbD697bUb3j3+tqqX42n6ZjaPsnnMs4UWktsigEXP/1flm1gP4RITrkQdf/uYjJS6gnhAi/Zg2o2cOzkoOHQiWzjmVhssZzTwX8j5IGFRYZYm6BSE9SUlPDH5HFoGGP1m4OitTDvuFLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 DS0PR11MB6398.namprd11.prod.outlook.com (2603:10b6:8:c9::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.34; Mon, 7 Apr 2025 11:03:29 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%5]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 11:03:28 +0000
Date: Mon, 7 Apr 2025 13:03:16 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<netdev@vger.kernel.org>, <mengyuanlou@net-swift.com>,
	<duanqiangwen@net-swift.com>
Subject: Re: [PATCH net] net: libwx: Fix the wrong Rx descriptor field
Message-ID: <Z/Ow9ERn/GRYz8wO@localhost.localdomain>
References: <20250407103322.273241-1-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250407103322.273241-1-jiawenwu@trustnetic.com>
X-ClientProxiedBy: MI0P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::15) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|DS0PR11MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cf2a9c9-2e8f-4d3d-1005-08dd75c3d3a4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UMIMguZMpSBuwGVvGTTuQCQBsCaW36zjmDREofdLu1qmQBy/qXxVjYxYpWP8?=
 =?us-ascii?Q?uOzVumDWdjTkzPqR/G6CqIFSLy2M58txfsyduoh7/HiCkTsBwsWWhUTeti1n?=
 =?us-ascii?Q?eyI6u5jghjyrocF75sM6Tx4wkx7N/yLSvYjG9rIqEM5mgPRewtCLqo8n9VxM?=
 =?us-ascii?Q?2DAlKc+0P1pj7IZ38zmqfvzrjg9VEtQAcC9JVx/MAC5Ek6c+aoTvjrSM70em?=
 =?us-ascii?Q?19xmVMrGusdd2SSPm0a1zuVEQ5wueObFHfPli+wUidBXcjB4EH21+2OZMmfH?=
 =?us-ascii?Q?kocWR7FCeb69RtyZ41hFoeVeE6VRe6Aka3m61RYcPysTBK0CMPRJ85qJP3LL?=
 =?us-ascii?Q?Zpp6ChPkhzj6aNQhT6fWoLaUEpKIQQnCJuKIRBImdceVhOWqqDMhph9TS9y9?=
 =?us-ascii?Q?9AvjtblLLOWtjstOltlH8V/QPxxd48jMGLSGK50yHQYtoqRpIlxii6gnJgM1?=
 =?us-ascii?Q?aXNqXbxOuqMAKltrAYjlDSdJPagmhHJiaPOYS8UnNrHYxxTG3Nli/LUVNFXP?=
 =?us-ascii?Q?/oNYEosSJodjpJ6okuo1cJ+Ep9HKsqGexFQa75OeI4C6/J6OMD7cfHwt05e6?=
 =?us-ascii?Q?F8urScr2PDGOd4IZtB1y2h1K7WF8OHd627Az0+Ev3wxx7V1ZJ9QsP27qQOw8?=
 =?us-ascii?Q?DvDK3167IgxJyi0SP9fFwPPbi0N9GXX0iEQfXPIcRwxrWb2hMw/kjUKULMtA?=
 =?us-ascii?Q?BgR2C3kx9Zp1LBvRtdFNZLLROVaaBkNsij+5tZ5nz/VgZXu2ff4UK3x4LVti?=
 =?us-ascii?Q?Nr/3wJORF9dBir+HR46FdWNVAA358ErI24Xpnzawj3yDbkrhPpJstkW1VYQZ?=
 =?us-ascii?Q?fPsmNiT0QsT5WoBOJXr72LcXuYrCv7aR+oOIXb74H5QpGcHrUch8YyyfB/WK?=
 =?us-ascii?Q?y3/5M3O1GGGlR72YKVDX2bW+nWElEG7REUuzH6sTqqUUuKgJIoCXLCxaEjmI?=
 =?us-ascii?Q?DxMLrovFHsa1Yh+wNI2H2HQSigpqx9PsnnOnoeTgCDLDW5Z9FLZPAlJUNcEw?=
 =?us-ascii?Q?FVTJRNsOI6xBbsLAhELlxH8FmEXg+Jtqk1aQqHsD1raf6xn6TlD3i4yVC1ji?=
 =?us-ascii?Q?DEIjRpqs43PTnCK+GfUoSiKCzRsPtQW1jihyCnyaLfKnVGclSBqnKqsCb4gn?=
 =?us-ascii?Q?ouw3OUZJlDzJWCCwYV3P7Ak7nyb6CFaRl/jxFbmVgu4p8SccW6vtjPU6jgWo?=
 =?us-ascii?Q?8FKVWEi5Lrh1f3FJsG534upSiE6MK+SHdWOvjSKquw+E3+Gey0XymehZc6R4?=
 =?us-ascii?Q?fJ7l9RHDH+zYJPaj694Tio73mis6umKklfOL570nW9tFGW+2rZPc6hLXlI8r?=
 =?us-ascii?Q?1CuNq01FMcEnw+3hUV6c96DUQkLe57qGuRqBtHT1wfsCOK91RPHYejnvT0gB?=
 =?us-ascii?Q?FVb43xssvuvhTJMchCBtHyiK6ets?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lD9c7DdTlvQVvFiYAAH9XSdsiinathG+jjEYboUKt+xnqa6ukkyHW4/mMUc6?=
 =?us-ascii?Q?ozuCqVoXVbIu5bcB/OwrhqKbOuzd4I89DVjidrZWG8KlEGfX7GYFb0zMIlRx?=
 =?us-ascii?Q?zoIYmhEU/sZURUVGuIix/9+1OKk5gAS5ncOQjEyjSDg9HwL7lsg32MbwRj+n?=
 =?us-ascii?Q?m65YsQAITaTRksTKT0Y0rjhuAai5mZ4qtVb0WXDVFynQLXKNgyCWvrHAv+S9?=
 =?us-ascii?Q?7nSP90/BQ9RiYzHuRJvZr1HLRV+gwVdUrneOlo2BQPjFx8cyafTIsLgfeCFI?=
 =?us-ascii?Q?DVuLLhgeqmFhb4p8TY/rdAlw/Apql+J28YUUAt9a0mPfCcWa5nLpsog2b6UB?=
 =?us-ascii?Q?uN1EiI1DNltFwSZTKKWqpMx3OdRJpxyK+PnkA7UerMlVvd0ERNV0ZeEknpIz?=
 =?us-ascii?Q?jm+UjFRMHJ3lJFVbOOU3AjK284pfSTjpoHJrpBF4z/DEqxgOCQnqQ8xMvJ8U?=
 =?us-ascii?Q?cqf+azlu0qKOOZGRjIubw1/+vm563OhwSj/rOIwyVIfWeZbJo0LZokW2ykiv?=
 =?us-ascii?Q?502v4f6sCylTZX3Gvk28q6mU4JTGCahUXxuG3ZFx9InekVkuni1WLukvEUSz?=
 =?us-ascii?Q?l+kRWjTDpYPwnwJDSaZv2/NAOigVOBpLtVHmJ1C6VgVT6mXXRmX3qGOH/8VV?=
 =?us-ascii?Q?W08JR4nJtNGTTDZarnvx8dW+5ITfcWRIwEsTHF2dQq2rnuwx//0szm4Gq63t?=
 =?us-ascii?Q?xBicolucSSS3N5oGtvvCx4UGEkQKxLJawYp0AQg5epCj7Iphm5Id3gOpKDq7?=
 =?us-ascii?Q?JgoIfPOfSW91BXfZkg3k0QndB3+74lgMY9G7baFDmpfpDCpk6t6fWGwGad1i?=
 =?us-ascii?Q?1Jn4hQb55mS9iGjZPgJlxEl8i3L6AYwetCZ/TQ+xtW1OL5z5FCfAf+Xs/x+Y?=
 =?us-ascii?Q?1nrhtPaCuM8DeSTCa6Mx/3G0O5LofOte51a/jpOXoqp8kUml6Q3ayLGiXa2O?=
 =?us-ascii?Q?zjHJJg2Ns+ffTAbwZRWlr0xH82Wa96pzTk8UrL0Pk+H46hkXNBnxscLojatB?=
 =?us-ascii?Q?Hi5pATFXGwCMDCRVBAmwZO43KRTbxvt0baHBmbldn+H2MeXttkDk/t/QRd6g?=
 =?us-ascii?Q?4lQqLkz/LrENRu/bzLMRLTBqFcjhvm697FO3bd/s/fkqgSHqPRvX72OMVLZd?=
 =?us-ascii?Q?396LFZWqSGWiAUsSc5t75Ol0O5Gj4xsCFGmhjNBjm2Zj5oyTpk9S1jGUg6qR?=
 =?us-ascii?Q?TG8w6TuLjtu8n6U/CtH8XNikzmsLFwwn9bpUUIANWqJucBha0CtUWeGbxzyo?=
 =?us-ascii?Q?I7HuUk1UqBrZIbv9GGiBOkI4cAi8AL3OFRJsaXlZS/+UBfhT89qwlIDtXBOj?=
 =?us-ascii?Q?3qVK/rQ+lssejkJWXOyYoMNv4fkvOAUgpD39P2I3nuRgUaHg9QGXJBOP1V4d?=
 =?us-ascii?Q?f+g3IsMl5t+sgMONnxgJXvqoQZ6MpeDrpV0lqOFVX8wwKsD/8RbYGaAy2eC1?=
 =?us-ascii?Q?g6quezHIFGyvL4y/t73wydSYAhmZ7Yu18NEQMoo8l1dME6FNajOfYVp+gZm9?=
 =?us-ascii?Q?+4iCyYTb/F1qzMQuOy2/JySGLechX3TiT8PshJk2kBhCAR/p2PmDhtTCsxjL?=
 =?us-ascii?Q?PmSMmVn8dAmdJ8iD9XPPmOF5BCFuEvV/ujPXgyq5y6SNTjQhO82LhmNYCYiO?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf2a9c9-2e8f-4d3d-1005-08dd75c3d3a4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 11:03:28.8711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ia0ecnxEL5jdh+KUaDWVJebA4uI3vYTtVrUw2b3yn5EbvHHF8kKpkZhzLYf1UTVM83d9I4nPr4eck8eM9jvM9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6398
X-OriginatorOrg: intel.com

On Mon, Apr 07, 2025 at 06:33:22PM +0800, Jiawen Wu wrote:
> WX_RXD_IPV6EX was incorrectly defined in Rx ring descriptor. In fact, this
> field stores the 802.1ad ID from which the packet was received. The wrong
> definition caused the statistics rx_csum_offload_errors to fail to grow
> when receiving the 802.1ad packet with incorrect checksum.
> 
> Fixes: ef4f3c19f912 ("net: wangxun: libwx add rx offload functions")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_lib.c  | 3 ++-
>  drivers/net/ethernet/wangxun/libwx/wx_type.h | 3 +--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index 00b0b318df27..6ebefa31ece1 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> @@ -546,7 +546,8 @@ static void wx_rx_checksum(struct wx_ring *ring,
>  		return;
>  
>  	/* Hardware can't guarantee csum if IPv6 Dest Header found */
> -	if (dptype.prot != WX_DEC_PTYPE_PROT_SCTP && WX_RXD_IPV6EX(rx_desc))
> +	if (dptype.prot != WX_DEC_PTYPE_PROT_SCTP &&
> +	    wx_test_staterr(rx_desc, WX_RXD_STAT_IPV6EX))
>  		return;
>  
>  	/* if L4 checksum error */
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> index 5b230ecbbabb..4c545b2aa997 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> @@ -513,6 +513,7 @@ enum WX_MSCA_CMD_value {
>  #define WX_RXD_STAT_L4CS             BIT(7) /* L4 xsum calculated */
>  #define WX_RXD_STAT_IPCS             BIT(8) /* IP xsum calculated */
>  #define WX_RXD_STAT_OUTERIPCS        BIT(10) /* Cloud IP xsum calculated*/
> +#define WX_RXD_STAT_IPV6EX           BIT(12) /* IPv6 Dest Header */
>  #define WX_RXD_STAT_TS               BIT(14) /* IEEE1588 Time Stamp */
>  
>  #define WX_RXD_ERR_OUTERIPER         BIT(26) /* CRC IP Header error */
> @@ -589,8 +590,6 @@ enum wx_l2_ptypes {
>  
>  #define WX_RXD_PKTTYPE(_rxd) \
>  	((le32_to_cpu((_rxd)->wb.lower.lo_dword.data) >> 9) & 0xFF)
> -#define WX_RXD_IPV6EX(_rxd) \
> -	((le32_to_cpu((_rxd)->wb.lower.lo_dword.data) >> 6) & 0x1)
>  /*********************** Transmit Descriptor Config Masks ****************/
>  #define WX_TXD_STAT_DD               BIT(0)  /* Descriptor Done */
>  #define WX_TXD_DTYP_DATA             0       /* Adv Data Descriptor */
> -- 
> 2.27.0
> 
> 

I don't know the HW design details of the Rx descriptor in this driver,
but the logic change and its description look OK.

Thanks,
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>


