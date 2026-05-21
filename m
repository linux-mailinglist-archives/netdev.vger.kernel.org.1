Return-Path: <netdev+bounces-290278-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QG4MIuXBDmrXBwYAu9opvQ
	(envelope-from <netdev+bounces-290278-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 10:27:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2C85A104E
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 10:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D6750301A32A
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 08:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C573546EA;
	Thu, 21 May 2026 08:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R0SBYGF3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513CF3016FC;
	Thu, 21 May 2026 08:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779351949; cv=fail; b=irIimjkL/GcJLyOmAPTt2svWYu4MjVXGaYGN7b18Y9D4YlvHkHTGUjZZdzK6G2aTJSdJdDkcrkw3hyytA9e1ICVUsJu+AK9uYrdDxO/5ewZKQXS4nglsRufLm2UmcUh167tZef2CBoNrmRIm0LeGQtfYfWmOHVwDR2L53vHbseQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779351949; c=relaxed/simple;
	bh=Vno1eiQ5KOMKvQNPpr4MqWKChMsbWaHmnQA7AOD3kiE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=imLyMk3VWs9BoPoYYiOTYwrLpT7KGiAzuDJB1nL1xOhlVadJ7S+izWM0iZBSRYYG1iZA3+noiqv/N8MDhicZpaf0BW/KtPScqv5Co3R480vUldJdqdtgJp+49rmbH1YmWNjSKOPcv6yCwzGx1i2DpkBlEAWB6h6i+dQTWlwefiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R0SBYGF3; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779351947; x=1810887947;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Vno1eiQ5KOMKvQNPpr4MqWKChMsbWaHmnQA7AOD3kiE=;
  b=R0SBYGF3wmwrHdLZCihDj8m51SS1HCgBEjaAkWJLF+3ioCXdrO9nqHlT
   egkJQEaKwUHGroPfjaYo9/TN6r5xBLSMj1STbkYkpgXHgGezZnnJveFbf
   ZtrXhiCpWP9T7nR5qSaosn45zz9cGfE6QKZ0J+bjJ6l8gz+feh3xYx5Oy
   TsTT8liz/ICEjnveZ0TN4tc7IL+WdnSrlEwljcAMVp+4q4t0sgWd1m+1P
   O2kaI4fSKZ8iLrgpxtM7VVgCyCOZAotHuQ3Ty6jRRzd6keKOvGF59lcGd
   QPbrkDRWcOmeNqoNAZTxf3ikAUYXCsEobgk3t3wZJJtGg9atHDY6ViKnr
   g==;
X-CSE-ConnectionGUID: FXi04lWpSJOBqEJ34cDsWw==
X-CSE-MsgGUID: pE5KryyJR3KZRXhzYRFXbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="91658476"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="91658476"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 01:25:33 -0700
X-CSE-ConnectionGUID: LE3SWCKAR3CKn/G/F2GkfA==
X-CSE-MsgGUID: bWxTtDN2R6ys7FIK+uvNAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="236044529"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 01:25:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 01:25:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 01:25:32 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.59) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 01:25:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IJ31sLIiBB2CWauNOsOJTlVR0iagBI4sho+IkY8h97rUrScucCUD/S6jtzyf2wiQ+J7qiLBfSzxrgOTFMXFHgjPriz6szdL5/Cdz+QyZkwOowpXdnGA0Mu+AhT94eYB1edjlo+2zwrdvPBi5ZT/14JxA8cmgMsffWZfEsTCfThQB25O0Zwo+KMv/JonCymo7ndHq/mwUB2sDGRmjSkmwoVq8LjP8Ucqb0WN4gn/0DtlCO1wTnVVGnw78fyp2pFDugt5PcNfhn2hqqxtcmdc8TWRnBfImdd+nPpwNlfvrabUIZ5kHUgxwrvzk16M5d8y1/cIpahJBLT5pLK3s3HXtYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TqxnN9EFK772KUToQHFP0eVVtPVjkOxwLCToJ8x1KC4=;
 b=kJ0FHo53e0l/Qa/H70QkEQI0qWqQMzZ8WvCJC8pB3Cb1euWnCnPnin6OCv6xrKdAqkjkwkwgRla1Vb7b+KZcvfCNyZzarJxsFk50TsDdcjGaXNfvhlm00kgXtCd7t/6XI82wX/Z18Gx7B+3hmhqoKSf0ZZUIyMXCj6V8xio3yAM0xXSA3IcpZMs+jiE4SNIbNZxP9JoQeOiqcFISoy7KKmiKmNAHbNKSX6m7W899rp9QltDOYAujAV+sG+0z96j+TSun1vI5ER3rfBw/Y0SlsEuvQlQlOXa/v2M8DmVWtPhE2z0ihueqgHeViuKRkRLyGDH8NXM2Sbje4NxKEZ3qng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by LVUPR11MB9811.namprd11.prod.outlook.com (2603:10b6:408:39c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Thu, 21 May
 2026 08:25:30 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b%6]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 08:25:30 +0000
Date: Thu, 21 May 2026 10:25:16 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>, Phani R Burra <phani.r.burra@intel.com>,
	<przemyslaw.kitszel@intel.com>, <aleksander.lobakin@intel.com>,
	<sridhar.samudrala@intel.com>, <anjali.singhai@intel.com>,
	<michal.swiatkowski@linux.intel.com>, <maciej.fijalkowski@intel.com>,
	<emil.s.tantilov@intel.com>, <madhu.chittim@intel.com>,
	<joshua.a.hay@intel.com>, <jacob.e.keller@intel.com>,
	<jayaprakash.shanmugam@intel.com>, <jiri@resnulli.us>, <horms@kernel.org>,
	<corbet@lwn.net>, <richardcochran@gmail.com>, <linux-doc@vger.kernel.org>,
	Bharath R <bharath.r@intel.com>, Samuel Salin <Samuel.salin@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net-next v3 05/14] libie: add bookkeeping support for
 control queue messages
Message-ID: <ag7BbB7EsMokmH7e@soc-5CG4396X81.clients.intel.com>
References: <20260515224443.2772147-1-anthony.l.nguyen@intel.com>
 <20260515224443.2772147-6-anthony.l.nguyen@intel.com>
 <20260520185121.6f380ad0@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260520185121.6f380ad0@kernel.org>
X-ClientProxiedBy: VI6PEPF0000022F.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8e9) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|LVUPR11MB9811:EE_
X-MS-Office365-Filtering-Correlation-Id: 91476fcb-7f47-46c4-c5b2-08deb7128504
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|10070799003|366016|1800799024|22082099003|56012099003|18002099003|5023799004|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: beUd9OpwC2afCcRiiDwrGs/BMaHZ3GHnfKLgvk+L7dT+PH8xdJ9klQGI7o6jqDdEK8odxXrdCSu8SJqThlDLUaO6Bi3j38rWQ1pqNLIY2wp//fBbP/yOhxjsA2gIzAOYtwlRhCRn/6qTX3aA7etW2hTquJC/jNtfQumpbIiJBdVEKUr0iBQsfJfGDkHx/vkMPh9PFgfp8+dwPHRrey/1pP2pLTaiTCOg9yMyMAvqI9eiFvPnjVhdP9TozbPkMLp0D9QYOvUnbYuNJMBg1ytYYNTOeg6rtXsY2c79vUyMx2FOSc0eSIs7SsIGUe/IJt9p5Sy43s0oOF7B/KUznSsYCgzXPC8IKFjC1Ie3CGHBKqb4bHrSA5BEh/F4MsjCE4OQvcDEIEiBmONBMulINsxuyOyaKDc+qSGcN41ckwDWKoi4hB4CVrzc6BJhvvNNynDj46XAotqTZvKrlauzxewfJbDqfgNUGntEx7Bd4vO6l6VR6cDZIBOIGr0jgzAkyHrAL+PQDA6CIPTXZreasuzNOSbYt7ek9A8ineRoe7jvWZ7d6P1TRMGwQdABovFSTfLSv8tlwQspYaXvsjSkL2RrzQRS8IRVl8UkLTpbfcTlVDGpJQy7FKsdCCP3jFzU0LRhuRIE0i6I3sQf4EJL2RkWmu9E1qQAYy7o3TMo9pWyLXdpA3R5DaQ7WaD79AQNT4U2LVS9j6epzAP7HrZ2zP5GRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024)(22082099003)(56012099003)(18002099003)(5023799004)(11063799006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+93helK4e8cVjWkgj19h62GBYl3H6/MB+gug5H7XGVYtNsQxAEPmz7XO525y?=
 =?us-ascii?Q?5ns3rQ13H8uZ/HiTF+D3Apb8RhZ3dykvJVAiTMEIeGeXNpcNPvvStNI49MC8?=
 =?us-ascii?Q?QDZI4ah0isl31Z8PVCxTvBVWLf2u22U6PlnQ6wvZG68/IjilIhwxxgD+f+oq?=
 =?us-ascii?Q?kYl21HEJOXYwsSh1lyhhmsiq7A8f4wG139nUTiDxQGi08VN6RnU4IvpfNarV?=
 =?us-ascii?Q?DT6HFEXoyfMzv3FjaukFJpWJe9u2tqfAh9CM4+2Y7T5iAGQJ65cVX5jwXj/c?=
 =?us-ascii?Q?9UWz2I9L+MfjSD1ibe9QFyHwlhKWllZBFVKdYLDGSCLOBLrZuPI58q8hndir?=
 =?us-ascii?Q?ZcAsnk1XFp9zTNXVPindNig+YuUWXXm5KRGqow5Z4SMHJxrEe0m+8lY0/seD?=
 =?us-ascii?Q?F6RVKiL8VySPQceItAqjnoUztTZLnLV3rI0Fv6WrJeUtzjfuKZYjZCGIBC4b?=
 =?us-ascii?Q?JiMYwuvQI7M2TQpJ4jEEwoEZUBhQNSCH9i1KI78B42PWaGpb2JzVL7e7yEPj?=
 =?us-ascii?Q?8ihcRhDat/MrzGt9/44nxELJWk28vNgbJi8xmqNZ++bSuIoZNR+neKgMmN2S?=
 =?us-ascii?Q?bYSlXjiKA8dJpejXpnJ+RLXeJimMl67KbX0YXkWRaMQvH07HuYp/gxa3ZiKd?=
 =?us-ascii?Q?mbz7zY6R+HvaFRRnGLTBpphfVIrIsveyhpaeulFpTUycvEjllqU+fo2dqlc9?=
 =?us-ascii?Q?0/WglBcPADq4DP5xxrkII+wvg01ud2GhsdmUXqwy0SIqKL+gmMVe30uuxXpn?=
 =?us-ascii?Q?J52ra0l8VsL3uw3/NZdCE0GKDBItBspVwVBF6wC+37zgExoUzjW1zwPIftNL?=
 =?us-ascii?Q?E2L99Luo8fV6H3Z+MM2LaD947UjRi6zPB2QVzjF81TikqZXmv6VASaDas/Bj?=
 =?us-ascii?Q?+4zCpubozVZNYghPmNcgY97c+FqrjzpQG15uBKIxmAaFyHIGgsQRXt+8o9+3?=
 =?us-ascii?Q?Zexn7H0PSsl4cnml95p5BdB10kQvM/mws3+Be2/s3KnS3frMYiHiavMi+nwb?=
 =?us-ascii?Q?dtWGJZzH8v9Fda1Klo7G/z8609DYAT0UypeUDI73xT8x1wiXsT0uHFD9P3Ox?=
 =?us-ascii?Q?l0IsL2qruFHuCIMvkYj4+hFGXzqCTqWKNN0p/2zSN/hh9fn7mdDlQXxBnjxZ?=
 =?us-ascii?Q?ICd+6ol4+ClGx6eVGLXtdG0tVBAzgKN3XK6EFNaQayw5DZ4v+KY0sshZ6FZC?=
 =?us-ascii?Q?oxCUA1+6+/qEVoaHzolyLJsy1v6vADnwcA13mKjPCSJ6F8bHU31h4DSm211p?=
 =?us-ascii?Q?7e2abkc/jXQpBHQhrhgXIYMJUY9tbVS/ebPLsIpf7lEizlN4k8SZMoylzt9t?=
 =?us-ascii?Q?QnYU7Df+1kecB4dc1jR3HMwf+auSfTz/QsvKcN+j3brpaPbkSXWVihA8LJLR?=
 =?us-ascii?Q?cePYJMgtdLLEhJEHq+x4utyLlEK2AqFqv619KQzjkySHzgC15sFaFuiBP8Dk?=
 =?us-ascii?Q?S0ls9nuQwMcm17LaabxtJ2NWSJus0yafHrlC94ODMxPi/+XswNNcEP2sliMQ?=
 =?us-ascii?Q?SS22U6NeHfpm93ux+qlJWlf/DaiUGhZ1GTSv26XFZeBlMowVFQbmhEUqCBzw?=
 =?us-ascii?Q?QCZeExU4twoxR5M/lQujKV/qUPYpA1VZWrNVleWEetcQOcovOcbspvbUFBEj?=
 =?us-ascii?Q?u/9QdvKzV2xDtcffOMduWaSNMvUFJ5SsnxANuKKhBUQmQH86gdS09Qncjd3l?=
 =?us-ascii?Q?5/VUTDONuVWaYlnTg7e7KWsqc9G2zYbTudqMx4hkcJIB/MLn3Fi2L8SiwCp/?=
 =?us-ascii?Q?8hMUYAe93H7+cTMVorSulj53NuWISqNdWkWcVSTZ6H2FT7S6GtuRg2z51u/j?=
X-MS-Exchange-AntiSpam-MessageData-1: fdTWiKaOBOJpjiMoTwCR6MgaHx27eOHp1aY=
X-Exchange-RoutingPolicyChecked: qQwPse/52y6TgIjYBFPDawOdghNGeJPj7sOXiTEqOubHJ1B+GeDisH9F0RCq1hIaMpCuQZxeMczkPLDfAYXrhF2r/CMFIbMAdQE/JT1kp3cW6vAa0M7ydrEUnOfr8JBANKDEiwRaZLoJkrM68EiwuNnEwzyFc6vOOb8Ku5vWv5PLJnM7U1LUF5D/riyeeVhF3cOzeOrJkcgAckgWjeWvYn+RSqhDkFWFzdckNsq6jYx2JRYO+mxbu21MYOcA/TjTR+5nXhOVdZ0Bm0mGqwm2lQb6aMBilIOIl52Q9c9ng2CW1Lt+Gmgyd7Z0NvzR4kP5jk4+zRYm5kfqFxSGrUURbw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 91476fcb-7f47-46c4-c5b2-08deb7128504
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 08:25:30.5346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BdaWEHDwyxsCyXlPMK69fyBEaO1DIWokg7Q46SNd45SLGtDdOs1I0PJv6F5yFffShyFeMr5B5FkGUx9PjhBvCwnunWF4X010xV2C9uab4J4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9811
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290278-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,redhat.com,google.com,lunn.ch,vger.kernel.org,linux.intel.com,resnulli.us,kernel.org,lwn.net,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 2B2C85A104E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 06:51:21PM -0700, Jakub Kicinski wrote:
> On Fri, 15 May 2026 15:44:29 -0700 Tony Nguyen wrote:
> > +	guard(spinlock)(&xnm->free_xns_bm_lock);
> 
> Quoting documentation:
> 
>   Using device-managed and cleanup.h constructs
>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   
>   Netdev remains skeptical about promises of all "auto-cleanup" APIs,
>   including even ``devm_`` helpers, historically. They are not the preferred
>   style of implementation, merely an acceptable one.
>   
>   Use of ``guard()`` is discouraged within any function longer than 20 lines,
>   ``scoped_guard()`` is considered more readable. Using normal lock/unlock is
>   still (weakly) preferred.
>

I agree that using guard in long functions is confusing, but the longest 
function in this patchset that uses guard() is libie_ctlq_xn_pop_free(), which 
has 18 lines between curly braces and represents a concrete atomic operation.

There is also scoped_guard() in libie_ctlq_xn_process_send(), which protects a 
block of 22 lines, but I would consider it acceptable under the guidelines you 
shared too.
   
>   Low level cleanup constructs (such as ``__free()``) can be used when building
>   APIs and helpers, especially scoped iterators. However, direct use of
>   ``__free()`` within networking core and drivers is discouraged.
>   Similar guidance applies to declaring variables mid-function.
>   
> See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs

