Return-Path: <netdev+bounces-181549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49407A856AE
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 10:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A9BA4C8032
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 08:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD362980B9;
	Fri, 11 Apr 2025 08:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GVoZBH3K"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F26296171;
	Fri, 11 Apr 2025 08:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744360464; cv=fail; b=VymXWvsyOJyXrVrk9RyyCMF10VAR8jdukzIx4Xd9E3V8CIppgUW4ar9+2VU76/MpZOG3QD8bweCHkZvqrUrClgx4oCoheEDEE9Qxs/fQaNt/1G2F1AmxbEsQCuu5UPEV4Q48Kf1mlABIDa/0gQPIq/WCEWNlpv/mZ2QYCEjz0EY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744360464; c=relaxed/simple;
	bh=6ndgf379qSSdo8bdwb2EUURKppEu67/m00reEVLv57c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=vD2ekAoQkx955Gds44F42/NpNg6zwW72CX2gzs/ZJdGGjpF23WxtzAdgzWM63MxFdFnac8kF/nN+n6uSTy86VLUYcpWzlz8YrWhGQVDpBDsS3bzoDJe5CfyPz3GtAwKy1SXk95Wlg/fi/W2HJGfOasntR6bTQWa6MqRf41MVgDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GVoZBH3K; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744360462; x=1775896462;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6ndgf379qSSdo8bdwb2EUURKppEu67/m00reEVLv57c=;
  b=GVoZBH3KBtCnKDvgFeJc+6a/xM6WUy9OHjoi2wt8UUOCIfh7uvMvASv8
   kxNc8uN/uBn9i7y//AdhEbajwN77EzsOTf2wkVHC3fYK3fjujHR1LsuxK
   NQunyHY4m5LyzaGBdqN7UUMqc0XBJuUmb1SsWB/vrDYQQTywN2u3SQr9O
   d8SjeuawBJCu11+L4J8YhnuxijE52a+6/yzLRf8DD0Kuvt4gZaILBQOH4
   9maeCxOB0rtz6wjdjXqQqYeXcGRPydSQv/ErZ5HOMJQ1n5PkOxQZUFhkh
   v/SrYYAiFByfd/qpeIOo9sg4KzhfpuoPaUKWE8VOM9r9Y4ZrvBIDH5olN
   A==;
X-CSE-ConnectionGUID: RWMOkiBESNiRRIfG+6Krdw==
X-CSE-MsgGUID: FpD5JkkSTAmiKd2rJMyX5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="45045940"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="45045940"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 01:34:19 -0700
X-CSE-ConnectionGUID: 5gVCOdmdSCKCsaoYyMrANQ==
X-CSE-MsgGUID: ItNUaRXDTv2USlbLukxEyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="160118858"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 01:34:19 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 11 Apr 2025 01:34:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 11 Apr 2025 01:34:18 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 11 Apr 2025 01:34:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KzkZopgJU7rK7FzMtpwVl+4ML8UbkpEpN/YlLR5Gl1IU7BgFMS+aPsQhlKbv0sz73OwVhcfdWqMTR3u8SO1iQVIWlGoDCYHR/OTexzzDOMqIoyUdKpkBk40136vPaxL22mC0XyF+8Ig9lSclQyrJI/8FhUYfHnVDNKHQOVoOV/d1LGzM9nnTQ4nkVpza1Wrg//im6imsf1UFpw1Nx2YapAgDofugqC7igpcs76uTtXKSLyCx+DxWjD1NPNJgv1MRyjSeUrySRb7YosVEd7Dq1VMkcCKOv72b0RIgo3UvWC+G+xMeHVJvZBNcTFCg6md6w8s+k7Wij16N6g34JR3m+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xOtQzRWYp19CIdY/PubYEcyrHAJNo81LtUZg3G2Wkt8=;
 b=nCFq2qHbFq5CW7pBO5rro4EvBEzTTAPkRovB+5IypVMVkBPmSpPU5uFuoQxCrWojnVHuhj5eRoQ07yyC5EXw217h1uBe2WEsNUvWKdNfglVeJ8Ip2igsw8Z+J4hZKQX7c2IE2x3nwDn2kT9UMUNNfJwK46IxCP9pYCwKv2cp5MkBXZmtqObcodYwILUIgS0XjKjKBZXvg9pDdQysGSAFOKlds9w0/75xGNERUeFcEIAaJtbpnLu57agKqOltVBsUl8qpy3c1Ddz9hFmL+uTaRc7IeuNBOzrHBXSLFh5Wrsxm0SSN9yNy5ok2vaph3FaqD3a5Lq8wZML3vu7/37o1JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by IA1PR11MB7176.namprd11.prod.outlook.com (2603:10b6:208:418::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 08:33:57 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%4]) with mapi id 15.20.8606.029; Fri, 11 Apr 2025
 08:33:57 +0000
Date: Fri, 11 Apr 2025 10:33:44 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH net-next 1/5] amd-xgbe: reorganize the code of XPCS access
Message-ID: <Z_jT6M_GYhMlxZE1@soc-5CG4396X81.clients.intel.com>
References: <20250408182001.4072954-1-Raju.Rangoju@amd.com>
 <20250408182001.4072954-2-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250408182001.4072954-2-Raju.Rangoju@amd.com>
X-ClientProxiedBy: WA2P291CA0047.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::16) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|IA1PR11MB7176:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a8475df-8664-403d-6f97-08dd78d399fc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XMxUmO1tgfAWWmeliU8dJvFO4Zml+koKUGgH25MWejczfgO8tOhkrH9em0OI?=
 =?us-ascii?Q?n7VNK5qnggfyLLyw6b7prtY/elkiBviKPiZnzmwsZC2p4L0Fw8E70hvAMBWs?=
 =?us-ascii?Q?JoTJ3KD2az2bvrMAs7Ouhki5n43nyAwJnACRYVWunVwOxb/qoMQEhcUQ3lus?=
 =?us-ascii?Q?BS/aCe7RT/NjwPxIZVz8d2PyG31piVlEF3/PXwjYjUXNQ/nQYbJTsvuXioOV?=
 =?us-ascii?Q?D562n0mxE07+hOwDpG5iYVj7sthT0oEd/yqMl+veRp1IX5Xlt6BBl+PODAUN?=
 =?us-ascii?Q?pi9g8ezm8pyzFU+YY21CVgDajPATE4hD46s3UAoge3HFgELpkYw/2QO9YDwj?=
 =?us-ascii?Q?sjdxnnybusMz9DjKt5OGelXc3uioleq28cO+WR9rmBQNryhFv3jrA+LMLaJE?=
 =?us-ascii?Q?9a/DXzDMf7j+Ogkb3nZpg52x12aHluQNkz/k4z4OEWqs0KGudQQ8NEO8VqRQ?=
 =?us-ascii?Q?sHqbUiRshT+lWp+miYOmBxR7jRAHmtMZo57gqiVQn7Puj33swlCkg02JmXHE?=
 =?us-ascii?Q?4DXSUN7J0BI0j9sT4O265t3Ex4C2VZesOJFf4O3uqHzxHZSUKa4FLwypaPH4?=
 =?us-ascii?Q?8YyjGAWLY2KrXtdbAVQjgthDZLHo0P0ZsBfpz6G2UsgJ8B2huSuxZD8io94X?=
 =?us-ascii?Q?v6oiLuIDngZhrsFo8LYRX0RBLSQJYVOO7cpKGIvWhlrSz8H5gAj6oTPgb0J/?=
 =?us-ascii?Q?ylHP08/lQhNrC0Hp2nJQs0q4qvYs0mIUWact0LArEVHMS47iN0Rab5htigAa?=
 =?us-ascii?Q?LNcrd61ytugesA2mQbX73Fk87CV+hLdzdIE0Tik3Uze3f/O18LHEF1BWSA36?=
 =?us-ascii?Q?tXpo/L1iU1jE+qHJNrBvQiherPJ0vTK2XDqYUjEqxj7b6XCDR4y3koL7SyHl?=
 =?us-ascii?Q?Q5aUeqdKpqUNRmV76jcxmXI5JDG83PPwQOBtYkgWOsYhRhIDA36Zczb7ey+n?=
 =?us-ascii?Q?Bm+TmyySZ2dCVzl41W+siNiX2RGfU93u4uIXv0L0HRjeaYLjpwfioh6O0qMM?=
 =?us-ascii?Q?FE0roG0/d63FVl6Lab9+7lYZ8GU/FarOp/WS5rxPVDyjFjKGf3ZKdTbpKlxg?=
 =?us-ascii?Q?FUg12AKstBhrutV9pe5AtF9V547MZFp1VK0UMxKk79buQi/a4jWdzaUmb9bw?=
 =?us-ascii?Q?XkKrZRC4SCRE1Ui2yJIiSAUS+0nPE6u4jqKpshiZv0bO2tKWqqAXQyhUC2OX?=
 =?us-ascii?Q?jSnA6zwxn0g8wSQoYJR/ORfet4NC+M1iVS9SOXCbH67LLZwMx8VeYdT37B+8?=
 =?us-ascii?Q?HhXyKBSKU8boNQ+PkK6x/yqRFbECydZo0PjAov9g1gzYECC6lTS37j5qVlAU?=
 =?us-ascii?Q?v1duqDkQucb4lTO73JmB0ZdziLXQWobXJ4VJgpT7319fxbi9ZfGj8UEodfw2?=
 =?us-ascii?Q?i4my885F6+y7zQb0q5DH0iu884iL9KjAJQ0AfEZ5rOrei6FXXRVD/A7YLw4V?=
 =?us-ascii?Q?ByC4Xx9KGqk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ir+xiYqMmbCu5b+EE7LkkLw858DPeOYIGVZINM0yBf68rslLjxRV4tPy/hyq?=
 =?us-ascii?Q?icQIlQxdoK2fMxAB9rdT53R1aRcs/FVz1x1z/lDI8yiF86iC8f3M4wKBj4+w?=
 =?us-ascii?Q?/GZcD4oJdDlOvsBywUVU2luF95W44uLoMe0kw8z2lzskWso5Vz7YYuCeAEER?=
 =?us-ascii?Q?3EiJkYoyY6VQy6u859+bp9lD8j2jBcXKs+KnavqvSFvTwNaylIlTd/tz0gid?=
 =?us-ascii?Q?Bs7g2Rv91uvdX2Lc9+8F1FyejtN1C5h3/7be81843+a60mM+WJKyrVvhxH3U?=
 =?us-ascii?Q?v/Np++yi9kVxQWtzaAhhwu8zQkeJ2yZL9FFAxKSmrUy1UAIPC8Bx9acCGUIN?=
 =?us-ascii?Q?QZwMLOpD4Thwpo4/4xSGnZTn5UhTn8fJ9p/Th47ZX2OviS4X0DnjvEo1tcyF?=
 =?us-ascii?Q?kkl14y34XYEWIVxx4dBBQoy3uyCPurOFbvaScPL1huSox8GZlaXyI/GI2oJA?=
 =?us-ascii?Q?/yVXprJJdyRMpBpwPhbEGXutfzuAK1YLTj01HW81QDpd1VlaPoGmi/JsT8fc?=
 =?us-ascii?Q?HWJK8T9JoMAtZ3cTWpxieq8W6nMRE6aay64SdgDO8EzQvH3fvymnkyxyYk7/?=
 =?us-ascii?Q?+mvdNaX4turCPIhINyUp7Uz1bQNS1DKhYV1urd+3gGszotDgO9E4jQ3OTIjD?=
 =?us-ascii?Q?Dr1TU7ZlytHjGGg6Aukkr3MWWd/oCwJbcqjaQ7Lrm43/Go2nyeDFN+TYho3v?=
 =?us-ascii?Q?8Jhwpo2mx6sSCL0jKqQoJYaumGLc0+3Mse/uVXEYsbPAGjeRdmBXOwF16fgF?=
 =?us-ascii?Q?wCCCc8kXXrYW+kqupeBwc+Yp26gXaBsz17jHw3Gm+IJrs1HpZHRU2fLHZ9Fw?=
 =?us-ascii?Q?1ao8iKf5sc/E+GhcfWHvdr9strwkx9bZRR3a5mOu3DKj5eHDt9kWcjyiW4Kr?=
 =?us-ascii?Q?Jo0ISmQUJbpLTPCR0x86ya5veKvfchv5Av4WDSSWOk6EbAXQYm1I//fnaAuY?=
 =?us-ascii?Q?LG2l6EnROXmull+tcVqcjkwIPGGd9QOlr9ooV3FHlCIUCf27TXnJF9eaz+Jk?=
 =?us-ascii?Q?lUDlTDQkXoStWaupiNclvs26xKP1lUrwudLsSF9MpZIqTdfTj9++IGp1hsuI?=
 =?us-ascii?Q?/Q11f7FS7qodphfeHDpDE7TdpVqmO7/0qi0FMoP4mPteRpZBsBjje6BAkdEF?=
 =?us-ascii?Q?UpgeuYmpS/E6n/owHAxjFXsUE+7SuNYLrLum16jbmnqPPONpi1HkmD6VwOq5?=
 =?us-ascii?Q?xi3XfY5OpbjDMmr37R1u5XI8UTTR37iNTVLEpF+cCtB/zU6hbaSnPb8spAzD?=
 =?us-ascii?Q?uZWLtuipKBOtyKo9yywcjGbPzUtzpIuoiHm85FduolZ3ByBOV3erSWtVx49m?=
 =?us-ascii?Q?Q1ayawS5eNRLtPvIWpifjRGrYZJQ46uc5R9nhqHPiHl+wGHZncAUHnXVHb5M?=
 =?us-ascii?Q?oXfi6H5nSF7LSFVVkO0iX3MNQ60S0BEcH60DdPwY7FnBM+hquec4wqSMZrk2?=
 =?us-ascii?Q?1WRUU0AOwy46CWDkLiNe8NrtamrOkFP66NERafCCA5OJJtVgWv2qCa1+HZJg?=
 =?us-ascii?Q?zcxyMoYs/E4iQQ6ovDUy2uZK5ehIiJRrWBytz5/X8RNKtvcku49YeRipe+B0?=
 =?us-ascii?Q?agq3x/oanwkRmwtIgR6LzpK5hU8HS5VsbTOmYgRTHaDFM5BQl53g8iiyguMn?=
 =?us-ascii?Q?oBkwPZS+6Tf0TNlfG/+jBX5UwGuwDPuhMdM4rmnUH8RGCWTpwjWHsja2pzLV?=
 =?us-ascii?Q?wqBQng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8475df-8664-403d-6f97-08dd78d399fc
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 08:33:57.4889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QlzVc3gwu7FsgE6mC/g7LZnQ2IqZ86hFCAW8Qx9tloPFtYVHPEVyX3nxOOO5Julo+nCQGBALNgehNKuzR4a1qLgpmQFwpYm0IwTdv6XhV0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7176
X-OriginatorOrg: intel.com

On Tue, Apr 08, 2025 at 11:49:57PM +0530, Raju Rangoju wrote:
> The xgbe_{read/write}_mmd_regs_v* functions have common code which can
> be moved to helper functions. Add new helper functions to calculate the
> mmd_address for v1/v2 of xpcs access.
>

Overall seems reasonable, but the new functions are missing the xgbe_ prefix, 
contrary to other in this file.

> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> ---
>  drivers/net/ethernet/amd/xgbe/xgbe-dev.c | 63 ++++++++++--------------
>  1 file changed, 27 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> index b51a3666dddb..ae82dc3ac460 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> @@ -1041,18 +1041,17 @@ static int xgbe_set_gpio(struct xgbe_prv_data *pdata, unsigned int gpio)
>  	return 0;
>  }
>  
> -static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
> -				 int mmd_reg)
> +static unsigned int get_mmd_address(struct xgbe_prv_data *pdata, int mmd_reg)
>  {
> -	unsigned long flags;
> -	unsigned int mmd_address, index, offset;
> -	int mmd_data;
> -
> -	if (mmd_reg & XGBE_ADDR_C45)
> -		mmd_address = mmd_reg & ~XGBE_ADDR_C45;
> -	else
> -		mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
> +	return (mmd_reg & XGBE_ADDR_C45) ?
> +		mmd_reg & ~XGBE_ADDR_C45 :
> +		(pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
> +}
>  
> +static void get_pcs_index_and_offset(struct xgbe_prv_data *pdata,
> +				     unsigned int mmd_address,
> +				     unsigned int *index, unsigned int *offset)
> +{
>  	/* The PCS registers are accessed using mmio. The underlying
>  	 * management interface uses indirect addressing to access the MMD
>  	 * register sets. This requires accessing of the PCS register in two
> @@ -1063,8 +1062,20 @@ static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
>  	 * offset 1 bit and reading 16 bits of data.
>  	 */
>  	mmd_address <<= 1;
> -	index = mmd_address & ~pdata->xpcs_window_mask;
> -	offset = pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
> +	*index = mmd_address & ~pdata->xpcs_window_mask;
> +	*offset = pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
> +}
> +
> +static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
> +				 int mmd_reg)
> +{
> +	unsigned long flags;
> +	unsigned int mmd_address, index, offset;
> +	int mmd_data;
> +
> +	mmd_address = get_mmd_address(pdata, mmd_reg);
> +
> +	get_pcs_index_and_offset(pdata, mmd_address, &index, &offset);
>  
>  	spin_lock_irqsave(&pdata->xpcs_lock, flags);
>  	XPCS32_IOWRITE(pdata, pdata->xpcs_window_sel_reg, index);
> @@ -1080,23 +1091,9 @@ static void xgbe_write_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
>  	unsigned long flags;
>  	unsigned int mmd_address, index, offset;
>  
> -	if (mmd_reg & XGBE_ADDR_C45)
> -		mmd_address = mmd_reg & ~XGBE_ADDR_C45;
> -	else
> -		mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
> +	mmd_address = get_mmd_address(pdata, mmd_reg);
>  
> -	/* The PCS registers are accessed using mmio. The underlying
> -	 * management interface uses indirect addressing to access the MMD
> -	 * register sets. This requires accessing of the PCS register in two
> -	 * phases, an address phase and a data phase.
> -	 *
> -	 * The mmio interface is based on 16-bit offsets and values. All
> -	 * register offsets must therefore be adjusted by left shifting the
> -	 * offset 1 bit and writing 16 bits of data.
> -	 */
> -	mmd_address <<= 1;
> -	index = mmd_address & ~pdata->xpcs_window_mask;
> -	offset = pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
> +	get_pcs_index_and_offset(pdata, mmd_address, &index, &offset);
>  
>  	spin_lock_irqsave(&pdata->xpcs_lock, flags);
>  	XPCS32_IOWRITE(pdata, pdata->xpcs_window_sel_reg, index);
> @@ -1111,10 +1108,7 @@ static int xgbe_read_mmd_regs_v1(struct xgbe_prv_data *pdata, int prtad,
>  	unsigned int mmd_address;
>  	int mmd_data;
>  
> -	if (mmd_reg & XGBE_ADDR_C45)
> -		mmd_address = mmd_reg & ~XGBE_ADDR_C45;
> -	else
> -		mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
> +	mmd_address = get_mmd_address(pdata, mmd_reg);
>  
>  	/* The PCS registers are accessed using mmio. The underlying APB3
>  	 * management interface uses indirect addressing to access the MMD
> @@ -1139,10 +1133,7 @@ static void xgbe_write_mmd_regs_v1(struct xgbe_prv_data *pdata, int prtad,
>  	unsigned int mmd_address;
>  	unsigned long flags;
>  
> -	if (mmd_reg & XGBE_ADDR_C45)
> -		mmd_address = mmd_reg & ~XGBE_ADDR_C45;
> -	else
> -		mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
> +	mmd_address = get_mmd_address(pdata, mmd_reg);
>  
>  	/* The PCS registers are accessed using mmio. The underlying APB3
>  	 * management interface uses indirect addressing to access the MMD
> -- 
> 2.34.1
> 
> 

