Return-Path: <netdev+bounces-180432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB70A814DA
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 20:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF37A885843
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 18:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5928123E35D;
	Tue,  8 Apr 2025 18:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A8DWC1Ul"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C8323E346
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 18:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744137726; cv=fail; b=WtIjbHNGjDcrmOU0voXY6htEMYG38ERyaw+xX2DRlDHhLwJkvc+qhqlJL2Em4tHbEXEOARPZyWPBLhlxchxeE0QdQCvRvmq1taFJwtLadE6LlYyY4CT2W5J2jFFiNLV+5lArV0D3c7xSGyK7oYWlkOCZTxfUFJVnQdJYGpE2fMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744137726; c=relaxed/simple;
	bh=i935mpS9m2UDQ85K22cGt91uEusK6mvyPY9SabX1d6g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SDkDSeqc1KlkYjWhr6EkMea8Da70N7R1hsDz8fd9p5YLkPqCRgbsxRsQhesBDnYWVaYoVjp64Q9elewWg+3V/tHvH5ZrLTcyr3CUV78WP24P+6PQGA5m55oq/9U/r2wUBYg/kbajq3dEXnIHj8AA3SCtPoTCSh4rFclpdauMt/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A8DWC1Ul; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744137725; x=1775673725;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=i935mpS9m2UDQ85K22cGt91uEusK6mvyPY9SabX1d6g=;
  b=A8DWC1Ulo0ScnfVWFhpF+rpMcJdmHKMGa54HKHlaliPiYaqdhsfHmeYN
   8Oee22FH+D+hHpfKBN+oLK99E5TidTUvN/vCvBwY/XL2wZRjSol5FnFJ3
   g3JoL5RJX1POTs1skZ0n4Or59pTQSSBi6ZftX+oJFTM+KdgNPHf13EWJu
   L5uBk8XxfQCpm7Jh1gn6rIIEVcSCkE2eHLhf22MCYJMYoXSNjNjDpBlnJ
   Z8/qgZ0EJxW2ZtN4y2ZkKVB8ZXGmb7Y4/o/gQ/liPewF6W/EgCEe4nLRW
   nl4p6G56ZPwUIMPPUxZVi2iK5qs0vxeXsLFLnPVOdTuDeuqfgj12W7lxK
   Q==;
X-CSE-ConnectionGUID: MofWVfkaSP+9f+001MEYqQ==
X-CSE-MsgGUID: xJMd+nJYRpOQz9o3D444tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="44731483"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="44731483"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 11:42:04 -0700
X-CSE-ConnectionGUID: UfV1DaRDS7CGwtkiG564AQ==
X-CSE-MsgGUID: hxOBJvn4TNa3FFNPzzNPjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="128854500"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2025 11:42:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 8 Apr 2025 11:42:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 8 Apr 2025 11:42:03 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 11:42:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQwBdYErEsBt3LglDVRTEaLJH6W7oA1V5p6/ZF7rrmGSyzGqRDpxSw4xhhJ8eUXU1WbjYM4jYKjSC2zuBd//cjQp2nRo1A9+LnfoAk7kd/Fb4wqolPqPX59aaIXs6ShlaOOM1bKd/fSEsZJD5YawcdW1gyK6TziyRliuh/9yQI7vMgHjdWXxdJfxAmWg3zNSDmHrOw97UFsmLMqzWLYGVUHaN9zdmvEt6+Lptk5CEv/ZiQ8iclFN5+RZThM2AlL6xLCEBmM+EOSmKbHdZIXZvAssYwcPW+drxsFxXYdla5zzM+nzPDDWkmYZeqFEEsWDnZr/thPXO9vQyvFh0pCYbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhL2YrjMKxaUnD8X/6aCC8IQGlaTmOpW1KhEPSIW8IU=;
 b=Z/oTGBJhSizXgEP4/4xtBMKMXcsVD2StC/jLKMXGC67Lr1+GIO/dpQ1Wt+zMDF21JzTyd1/O/wQBGI8lEk1+6rq1lacAqvWKPPPhDeHh5+Xne5socQr0aTk/LhX4GBnOfpT3iym1aN5wDxE0YnXUmhawbsPzXDl9QQ7riCJ+U5pV8YS2GSsKiR0y7xJXa4f0i3vildEuA2y/XNA/W//c8HPjeIMnxX5gijv2XkTiSUo+k1DF/wMFzAbdR4TsTYRjY3R/nn4e69Jz1myixdDHls58DHPbTLytvwzBEXMdDST6KLt6j496T6z5k2BwuANnyO//xGgjNWMdT0lmbJMLOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 MW3PR11MB4716.namprd11.prod.outlook.com (2603:10b6:303:53::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.34; Tue, 8 Apr 2025 18:41:57 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%5]) with mapi id 15.20.8632.021; Tue, 8 Apr 2025
 18:41:57 +0000
Date: Tue, 8 Apr 2025 20:41:51 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 1/3] net: airoha: Add l2_flows rhashtable
Message-ID: <Z/Vt7xTrf8/o8Pv7@localhost.localdomain>
References: <20250407-airoha-flowtable-l2b-v1-0-18777778e568@kernel.org>
 <20250407-airoha-flowtable-l2b-v1-1-18777778e568@kernel.org>
 <Z/VCYwQS5hWqe/y0@localhost.localdomain>
 <Z_VTpBhntxXPncsv@lore-desk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z_VTpBhntxXPncsv@lore-desk>
X-ClientProxiedBy: ZRAP278CA0010.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::20) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|MW3PR11MB4716:EE_
X-MS-Office365-Filtering-Correlation-Id: 20db9ab2-8939-4437-d3c0-08dd76cd0a28
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0ItE2xbBFsP7+keyBNU9UMgPDI4mt/1llFREL96DqzzgNymokbXURzKox6fW?=
 =?us-ascii?Q?F4e+wgdG/YDFvQQptYUz246Gw63aPFkv4pAHrf9p7qzhxBjUnv6J5eyWpMnc?=
 =?us-ascii?Q?FNqExklPpdXindiGcl+D5ydfX/LyLOUKRPWDBM+NGzc1mrLeDB0DuQoZZVNn?=
 =?us-ascii?Q?fWcTTVhs65PN5q18QoVTjFRnvb8A+PFHUcyEXA7sEoBetZDRwU1Hwazp9PJ9?=
 =?us-ascii?Q?kB7PS184av15PdU7X12wce86mP7TWBOwsoMj73jpu95turt+VOgWW9NtdHT3?=
 =?us-ascii?Q?UArxK019EGPBLVz8IAneOrjouIDbWg23ICDsbU97UQsMlhkr6V3dzlThuG8Y?=
 =?us-ascii?Q?4KajwKVRLteYctzcs5rEs09qzonsUJNMvbk67RMug2XpHtN32RacmQwz9Txp?=
 =?us-ascii?Q?SOSwHZTcTpI+hBwIN/J/682z1BqlUg8ED9zAY3FCqslulbV9vUT9vuIwVRLy?=
 =?us-ascii?Q?NasxUl+iIDXHS7OTHYomsJZTv2yMlwgBQcZ83MA9UgxLXmm9x9H9R+TtDekR?=
 =?us-ascii?Q?neVrfHOIyVIu9kdPH1YKbM52inJUuWMQnLnPj2b0icF8Gyb4PkvWopR8tdD0?=
 =?us-ascii?Q?jL5T7yktxZC/L1zqBZpx1mo6CmyVciIa8TD0ukp8yX7fsNLE4vnv4jqxQZ8f?=
 =?us-ascii?Q?RNdiFgUcTtFTZ4ikchoEsdauGSzM9NTv2PTt/M54vKIboXK8EE69O/1CQINj?=
 =?us-ascii?Q?LX1bOYuQbvmM/x64e+WFxZapnBxvJiSveBh/cX1WVBvWJ5fVDWPQKvk3bh4C?=
 =?us-ascii?Q?+XDFSlhVggdJH2ygzN1AcXokjXVkLhXTrd0WFdNNz5Rx1zkNjoaBMZvPTTwx?=
 =?us-ascii?Q?bMuyZjri0JApqdxY08dT0NO0rJ5w7nU68fN0Jqjtc580uPedmym3CWiuGqY4?=
 =?us-ascii?Q?Wl06j6SSEfoSHUnO1Ot4sD1rxr2PnYB/HcCnPEng02DGxob83g2J7Gb7J3fN?=
 =?us-ascii?Q?uyFLoQ/y6Nh5qAs25FRiWOr1+UdNA2jRGvBzUQn7CbFapjt98FOm7lziBtdJ?=
 =?us-ascii?Q?CweiOkVVfioRaa1oCF503jDHJAtwJ+yFEn4K8WOKDaufhSaAaotl3rSSukVQ?=
 =?us-ascii?Q?C1H/rLwaOts887i0f/27qfIozKdEn2uS3pbgRerhx1cmHyo3NRNic/wEsROH?=
 =?us-ascii?Q?Vdm/H5woUH5RuRZoVDJ64kej2j4It4Jg9FHsc1CDIQkpWQYGaqDMff/IZI5H?=
 =?us-ascii?Q?CUVaOqxFar7v5mlXBOS+WyNQpxFKVGBnBlt1OS9QeBsFdBuzlUNHWh8A7R+G?=
 =?us-ascii?Q?G6e45eKMQf3NtNu+5bqceoyJNOAuoA2GJ+15MP8OuEiOF+Bb9Y0lRCdz2Vzw?=
 =?us-ascii?Q?Z+myXiiKAHXKXNqe4ofBRTd98ZMvZnXUVzi0fwD5jupQpt9gFx4waTesVXsD?=
 =?us-ascii?Q?2JXKXwFphRRwnfXvoSgGnlhwZIw2Al9OZP7uBeC0EyFylWOy7qOh2xg1Nla9?=
 =?us-ascii?Q?TnouQWki94w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RBL7EWafmjtq5zAFyBLxkGZhzqAlufjd7VyroCQGhylPZRQ9YflnWK0Udu5H?=
 =?us-ascii?Q?zr5tzTYrqUNRyNzHscQ0w3+edGovlOPT9RJVX/TBhM5e8JRDhLZSYOGKf2Ng?=
 =?us-ascii?Q?xIqMhlRev/FD6qZlJW+LfSEdybFquTtmOQuiz95F3R6QC++QgauxySFTh0GK?=
 =?us-ascii?Q?SDfekdgSwkge8j19aYQiL+AmsteFd/Pe55BOeXl+qMiP6pVTWBLozd2beFB0?=
 =?us-ascii?Q?FbCf6/YGyGraGd0vmHO+BcejJDDJelhaclmjMS4ekxGcWVJRqRQdkDFOv42q?=
 =?us-ascii?Q?V7p/qSxLNttgmpMcojZE0zBk+65tuY/AznwIs1U4YTxO0/QEPHinlIUPRxEP?=
 =?us-ascii?Q?NgoHk+gE1i7mmdiG8Amf/zWjvbJ+sVKyAJ02zy0UaxRycYctY9gvRFLutt4p?=
 =?us-ascii?Q?N3NjG/BZwXBj7SPuX2iwxOSQuCD83kBwFQynPwzOOa3udmJiKioGNjS2hR0b?=
 =?us-ascii?Q?NxC1PntAaEki1s9IBeilrZVslJdgzooVSOuKcBXhuo9bzdvuA1vYmxtZzX/K?=
 =?us-ascii?Q?2k7VIlfOiwUT36xhS+Eru5Qj7g+ypsl1eKOf6Tq41KIZp6uFWJyy5awYYZYM?=
 =?us-ascii?Q?ObW4v32a+rW1fdSbtjVU7AHqNjZRYLq3q3ibp7xc5oeDQqKLhXzyyqK3y46g?=
 =?us-ascii?Q?G+MruMPHo0RysGhS89knv+CkDtEys8xNGAgwiZf3camNZT1u5lUrpqOu/Tsu?=
 =?us-ascii?Q?Uwb0W9KFvuqwvXlf/CSQOtb9ZbkXX595Azi78d+raQEOVR86rDGVVkVRxYAE?=
 =?us-ascii?Q?nFL9MkHZ332iPP/4Fkbxgo9Ek7cX55S6HC5qVmu2Ej/Q/xZsyce08R6V2P5p?=
 =?us-ascii?Q?j1t5/QiSxgwNGCWIVgtdHCeCcxAVnwx9g5U3hK71JXbQnDZ2JLXzBwuC5u4F?=
 =?us-ascii?Q?Zt5Gx+JXKnNIF07QzclMjSt7I88RdkToROvg4iAt70kVoxzNih/3drVhy7RI?=
 =?us-ascii?Q?AjaMOVjLQi2bszx4rfYijS6dtaiHKKkSM9+6vj3AUdP37w70RkH/T6YICy79?=
 =?us-ascii?Q?NVxpMjHxT0SbvHg2/oeIYXFblPajSqLR7KSTbZy7quVNBYeTtMews8s+pPjD?=
 =?us-ascii?Q?AREmI73GTcH6JtfOho2qkpERFQDvGR/2o2RVC9JzfmZzsTykFKg8w5pG+Vw8?=
 =?us-ascii?Q?ISpFFtUJvhMsXv8g7pqyuDkEsHql/rLFX3L/a2RN/BXGaHE24Ifqxt2OeeOz?=
 =?us-ascii?Q?61ArEkAY/FDRHkdCgdeSboO/f37RV3gjPg1k0692sZt1vEaq7m5/t6qjao/3?=
 =?us-ascii?Q?kGfzvMPEoMoiF422h3x4ivPNk1TpKN2fCr/iF+lYNvoCd2ZL92ExnK4FNuZi?=
 =?us-ascii?Q?Tbo4GdQvThZSbk4DDB6EX/B7uEZ6Yv8iHjY3/2I6HLbusZHngsKMHwALcjc2?=
 =?us-ascii?Q?xuTy4TK3Hc9Tf0/39Id6T6E1SqW4ceUYbzPHO4qbLrZTd4dQHc5126YDGU7u?=
 =?us-ascii?Q?IREeZHZ36Rv1LMcw5MGvsg+fFz6KcYwkyS9NZ20WeBWtLe/7uzqGDG6ZWfTo?=
 =?us-ascii?Q?MdKMmYWc3HOdmZEQjq93wSwUQNA6OvGykWgxaNYG2nsyFz4UWGKKmA8E6tb2?=
 =?us-ascii?Q?1GCyUcnbVnYrMPKNQy08Ynj31beQnHYQKNOHzonfRyn8bEwbh4dmMLNIXbBP?=
 =?us-ascii?Q?+g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20db9ab2-8939-4437-d3c0-08dd76cd0a28
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 18:41:56.9481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I2tRniBZDiT9RnaLHn5hBx93Kxa9skLSd4+JpJmeAhBx1+7W8sLMhvAjqE+vdRo0ZZn6HrVCpn6U1ujNR/xTcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4716
X-OriginatorOrg: intel.com

On Tue, Apr 08, 2025 at 06:49:40PM +0200, Lorenzo Bianconi wrote:
> > On Mon, Apr 07, 2025 at 04:18:30PM +0200, Lorenzo Bianconi wrote:
> > > Introduce l2_flows rhashtable in airoha_ppe struct in order to
> > > store L2 flows committed by upper layers of the kernel. This is a
> > > preliminary patch in order to offload L2 traffic rules.
> > > 
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > 
> > The patch logic and coding style looks OK to me.
> > Just one question inline.
> > 
> > Thanks,
> > Michal
> > 
> > > ---
> > >  drivers/net/ethernet/airoha/airoha_eth.h | 15 ++++++-
> > >  drivers/net/ethernet/airoha/airoha_ppe.c | 67 +++++++++++++++++++++++++++-----
> > >  2 files changed, 72 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
> > > index ec8908f904c61988c3dc973e187596c49af139fb..57925648155b104021c10821096ba267c9c7cef6 100644
> > > --- a/drivers/net/ethernet/airoha/airoha_eth.h
> > > +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> > > @@ -422,12 +422,23 @@ struct airoha_flow_data {
> > >  	} pppoe;
> > >  };
> > >  
> > > +enum airoha_flow_entry_type {
> > > +	FLOW_TYPE_L4,
> > 
> > I didn't find any usage of L4 flow type in the series.
> > Is that reserved for future series? Shouldn't it be added together with
> > its usage then?
> 
> Hi Michal,
> 
> FLOW_TYPE_L4 is equal to 0 so it is the default value for
> airoha_flow_table_entry type when not set explicitly.
> It is done this way to reduce code changes.
> 
> Regards,
> Lorenzo
>

Thanks, Lorenzo! I'm OK with that.

Regards,
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>


