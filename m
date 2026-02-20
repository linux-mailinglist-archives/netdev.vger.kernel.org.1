Return-Path: <netdev+bounces-259705-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCmcJJtVmGncGQMAu9opvQ
	(envelope-from <netdev+bounces-259705-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 13:37:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC0E16785D
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 13:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 807483004DE3
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 12:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E457342CBA;
	Fri, 20 Feb 2026 12:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dmerGzyD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35A429B79B
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771591065; cv=fail; b=T8dF3MjnDE0PC2opZ3aLLTy2Mx4+lJ3trCwT5FnHMRI2ZzXcABprwdMJIX/QmUocfB6pW6faFrK3XVL24afRCzDKQLZnh6/fjJLJmwXz4mSgVMQDUrwO4TRN2CEJS9mSchyuRwnU1omR31zqWttYcNWiyNi3S5j+GQtihyCKG0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771591065; c=relaxed/simple;
	bh=vUD4cvBy4PihAJsqv2bwJfe7hywhBe0klcKg2DVkj8A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sCHwaUF06CaYnusZIAXIq/QJher4ezAEDOI914V2R6LelbMtmBV2xmRs4K5kq8HLkkirnPR4gNAFLQRMquM+EBlSSnWVP4oQKBAOUhTJsBAC8V2xSMKTXZu3MeCs9N6zMO2JtCpQwZAj+sRjYHzHYF6nQOHWyqIXKY898L3TVtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dmerGzyD; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771591064; x=1803127064;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vUD4cvBy4PihAJsqv2bwJfe7hywhBe0klcKg2DVkj8A=;
  b=dmerGzyDulYY84J3PoC8zzfezs8BiuMNtZmzvyo3woPEGMm2ZuHbcbql
   INJVsWENt0w15zg122oVOkTU9o/tG/T4E/vlSRHIiQI94zo9dD5r65g7d
   GtgqzZ9Cp51Sdfd2XmUwM39Z3fY0uD6qQnMgjzLwzHu6rOnvoycmymNoA
   vs/etYjiiysYw3kdCrbwZLCBjRJdeyVs+EiP6oeaeMMVuWzzqdddWps1g
   tfjsXvm0bugOPoM9UX/YJGePb7+8QSBd3mnLd736iMdGlyhKcrFIdQ8bW
   dIVhEL30wPqh3mZYoM0jGi2TJJdkQnsrCowpS3OnAD23xmjxm/2LDDrbk
   g==;
X-CSE-ConnectionGUID: QDrEnHJCRZitXxyYCQXXlg==
X-CSE-MsgGUID: Pu5k/yonTF69Ivv59cxSyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="83787761"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="83787761"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 04:37:43 -0800
X-CSE-ConnectionGUID: 0kmHARJJRn+/Fyfes6uJfQ==
X-CSE-MsgGUID: Q/M0V4GxTqiNAN04Dw6OJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="213891116"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 04:37:43 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 20 Feb 2026 04:37:42 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 20 Feb 2026 04:37:42 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.54) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 20 Feb 2026 04:37:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WyY1vsDqPwzno2RjASFrnMOTnZ5JxyVaG6RH+GjEajqSHozKIG3xwLRxcldtJkTKE/W8A14h+6uWQpDsXaz1UMx09pGp1VQBjTRF319CYhYdfvGRnCzrwhcE6gN/kngn9/8bxHdWHUVDpfsfBLrzoblPdIYoGVpSol3Qw0b+am2oLit/tdZsIt+KRlNjwlDft+cZNRQGELtrWrIfZATtbmU2pMqp7PADZSq8//MxzLs4ye5Hxw92iquhsNDkXYUyTGj3stRb5ut15HAEtzlX53WF/7AwIetC7GyTFFJFTDQquNIf2f/j0YMjqTK3Q/1ITdMLBp5lTmUs/ftSThHjqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9f27ZdmnGY70lke30fBQcfUEj/wWioibDk+IS/XRVQ=;
 b=c0OF6PXmFtKOSj2y4j/emH42xgBqpU7Qf8cdyAj/7FUR2+117uqbb3yadriaLbnITMTocZnfCvJT67JLnuomSsKzWBO0CcSr+6a8rPnGx1v+1bNXHCLuyl07/EAuYALk5Ex2O584nuiEzXvUn5Ib8wGnv2SXxP3g/uA8ROeoDI/KHtIsijfgmBTWY1ooqZeR+fNnC2kiCR7MqvlOYQ4sLg4zpVhY9/ow7cHaJP6Ormn2TEDMVIxs11iyfgSSAB3az2RI6OaysSxLQS0NNo0HVRDcsUF8JO4aP/E09P2f0I/atgPYraDOVA6OxEyw8cfdxYW28bn1E6VPvezkommc5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA1PR11MB7320.namprd11.prod.outlook.com (2603:10b6:208:424::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Fri, 20 Feb
 2026 12:37:27 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.20.9632.017; Fri, 20 Feb 2026
 12:37:27 +0000
Date: Fri, 20 Feb 2026 13:37:09 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "Nikhil P. Rao" <nikhil.rao@amd.com>, <netdev@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <sdf@fomichev.me>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<kerneljasonxing@gmail.com>
Subject: Re: [PATCH net v4 2/2] xsk: Fix zero-copy AF_XDP fragment drop
Message-ID: <aZhVdcTDceAlhLvV@boxer>
References: <20260217211019.48280-1-nikhil.rao@amd.com>
 <20260217211019.48280-3-nikhil.rao@amd.com>
 <20260219145529.42b177d3@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260219145529.42b177d3@kernel.org>
X-ClientProxiedBy: TLZP290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::9)
 To DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA1PR11MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: 649706c8-71e6-40a8-6fb7-08de707cce0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F+ZtNsdY4JNDC2quAUpHMawHGQno6dbGTafBGxCZP9bI29d0kDsZQORn9NYM?=
 =?us-ascii?Q?pTkTMbK0/7a+1DxuB6M7v8caZvZs0fPWn2DUdcl6YDYx6GY2lUsZi2D5CAye?=
 =?us-ascii?Q?HAWL+NZeIj9snptzm3D6eEHiCWlz92wB1mBZQ4ZMTLwlZcAkxjYciAdRv0p4?=
 =?us-ascii?Q?KTVl5UgzftBneZSy9KlXpGvx4uwr3qxyunNDJEujXgyr118gOcmIXQNGV5MS?=
 =?us-ascii?Q?0L6Ys6C4ns7WGII0fUWYBo2pgOnoJvHlgLAyI7DoUUmKD1NPzkadq8grzxqf?=
 =?us-ascii?Q?vk0d8bHgUVAdQaTF4qqzVvJ0yL+aifzoyiQ4G2vmnFIpzLez9755bkPvFdHi?=
 =?us-ascii?Q?pFsa5MsIwFmIbUFxozR0/DhE/3CycBAhPT1WE6u/czNHgvahO6nLhLD51n3i?=
 =?us-ascii?Q?3VeBWZEB50a15rmhU3N3zmqpuAUc5iKX83y4gGbXbFRXRK0kZcQR669tLRqX?=
 =?us-ascii?Q?pgt8WdbJJGZpxp8tSyVt/UGu0tO/RHeRURoh5urAXBSDp0EHc78gqsgApqUS?=
 =?us-ascii?Q?SoDarbJY+RHQ+U2Fm1JyL0YHvVT+YspXF8B6S/6UIJBfkh6o1WygBKOBPnQV?=
 =?us-ascii?Q?KPpv/ZVmjWsMquN0OwaqYyqQwrObcZTp5DlH6ITlT6/k6NzJaIzeB5dABqvB?=
 =?us-ascii?Q?VUJ3qGnqzf0adgxkN+J/emCc0KBtFRQVeFodJPFBmmo6dvyuynZ97+AS6w63?=
 =?us-ascii?Q?ZDmSwXq4lIvukoiJEqK/CSvQJzsY5R72e5lHCIU+gaTPDiP74siNlY7dsaD0?=
 =?us-ascii?Q?41NtRk+tN8QqVuYDVN6WAoIC1xg1QOj3lThe73/+bvTJpLT14AMdSPBzw18C?=
 =?us-ascii?Q?nnNoJWR1a6zoUR3pQeqJXnaCQtfqOR+/KKuRii9E9JyiQADtGhtVph3cNyKl?=
 =?us-ascii?Q?+dEwR9RG0z72gezdabOYQLIhwUbS5p3JDNx+ano3mzeFEnaz1DpQFmE/W0ty?=
 =?us-ascii?Q?M7N6VJmKg880zR/oZmpvjq+NO6pK/0zMHrIij0rhmaQsgtMwJBobZ7Sif1x/?=
 =?us-ascii?Q?m0WPxfKadVFd0dypx+WyDK4A6EH0KI7vTvQns4xE4+0aa8PbJDSlaEJfhTTC?=
 =?us-ascii?Q?6O8NtSZo/xjRUFfflJxMzeO15ZniWYU8MV5iqpUVOVDybGWe5K1dkscjIXVY?=
 =?us-ascii?Q?cdeH3E1bklQNxZ/gLoJviF3Wnp7PSbUdMZhBoa4oNLqctz4i/Spf1/VgIZIi?=
 =?us-ascii?Q?rsIZxRH8onIxXdNKYOAdy3ca13tHLA1Qtz69/sZZOX9+j3SK0TRaKKWtx8pJ?=
 =?us-ascii?Q?7GvyMV6OiaMEKLAJzyT61N2i3MkVI/8RgxlR9IqaJU7hAZEzbm4pR/ycjx9E?=
 =?us-ascii?Q?QxxdpDqKXMTlr0buS/Osb5Cv6BPMtEo6BL9hzWIyru/OQaS4EQrsQD4AtY1L?=
 =?us-ascii?Q?8aYK+12l7dyqkkcvnOyS9IJoIwLT5+vohN/zTF6v5Vj4ms6nElEeMxCFZEzi?=
 =?us-ascii?Q?4MubTsDksnGcnVB0WO+fpHoXl4zO3veBy5CAliSjYtzrO7j4TOa9guVKP7dp?=
 =?us-ascii?Q?e9UyMGn4pKWauFbxspvQAMqdkspEW4QL2FjQY7bSDtUcTp9pcZ72AlD9Jgmy?=
 =?us-ascii?Q?W4tXGHkV8uzxQleO1rk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JkUVzakzR3kG6wO8CNWEn8r4ari2JXzQsn5Kg7ZsdV9PMd19YvaAKMQ7a+4N?=
 =?us-ascii?Q?u2v1kOWE2Ge4JQHFChoe/xDA9C9GrUP8prtnphaO9zifwBPnxgARgj/HXhJo?=
 =?us-ascii?Q?SxcboWWZwfJS8Y/SCyejWzowxuSju340qg2DN7+V7JkWDFBhnXsVHV1b5psm?=
 =?us-ascii?Q?LpH1XJZzK8l3hsJjEOEzvIoO0v7vYBK3OSo8WrV6V/39aQ3ege8wkkr9BMZE?=
 =?us-ascii?Q?ydionB1ftUqzZEnBA5CGZCLj/jDfxdhLC1q2TI5C1kcZARct/o5wlLV5Fhej?=
 =?us-ascii?Q?7CX37kBNAmAtdjYz8n56gm1urjZRGdHpiyEZHb5cH/PLia2/rWFQidAhZAg8?=
 =?us-ascii?Q?wM4fPiB27U9w5AC6XfWnRt0OSGY7VO7mowsVFsoBJ6czbWKhAae6dFrAwQmu?=
 =?us-ascii?Q?EldZ1QSQpkyx603iREt3s9vWBI8u5ah0qiTqcpHR5OJDBvhE7PZlzX65xAlD?=
 =?us-ascii?Q?1C6QuqnYK1TaCXJT3CJHeCvFY98agW7R8WNoq0crC1uMtK4NHWYS4sDUtwcD?=
 =?us-ascii?Q?imZcWopiEYZvFmXbZK3GBNzQxlzRXqNF2pqgq7rsIkz9itqWmpuGZO5O2XT9?=
 =?us-ascii?Q?qoWRKrYXPkSH2SS5sppkuY3V8XSXBRRE+g3sZDskxi0n11Zo1/3uS/s5JYdm?=
 =?us-ascii?Q?6BL+W6wZlGBe6aKEV7QGg7sGB+01a4booWqTp9Cugk7xUBKZJJfeh8GWNY+2?=
 =?us-ascii?Q?jIZz3npaSpoiMyJkjnWBjhZx3a7T+d7LOXYDYOGaOopspQnac46EirAIM7zD?=
 =?us-ascii?Q?SM7jCLtOVqHOMzuImTtYmXlKbTGMbbxp9FgmI5KGdSrVzUxbJ7Jno/zmIW8e?=
 =?us-ascii?Q?jJzyTkIIdAe+mMHQU5DHwoyPOEkO8YiboK+FSisByTkGSwrzeX8V5OGtR4bE?=
 =?us-ascii?Q?XbLyp8KDUTK30oLJ5ALCQaU1K1phBYuYY+AR7dx69Hagfk/dgMl1Oi+46M2N?=
 =?us-ascii?Q?tkmEdeM/DPJfSiagn+EyvrtyuEpXGng2MM9A1PVmy20psci9JKaAMbU1ISre?=
 =?us-ascii?Q?IGrWiuQttv/otbP1yjWtbyzKR1Jb/dZ3SglWnHFNK9oNWNUO6ohvVwiYcPbi?=
 =?us-ascii?Q?wUCmeBl/BHQXT9Ev8j8BnLRvmhaI2IJUMZLL6SQ7idkknG07PhhovXotZPn0?=
 =?us-ascii?Q?3Km56tsgc7zBHq6CGhfbAJ9B0R4jJynUM3q021WaE/F5kO7mtzTx92usYe8R?=
 =?us-ascii?Q?QDMT8lDgiyfDyhesDq13dWVP4CuWRkbTxEXlnAQloOBFNKUrGtTxGOrQKbPD?=
 =?us-ascii?Q?H5/wbEo3QGnX63hI9wz/I/jDPe6h5rF+9hKt9GxmwnSnF0nrzkP9G+PWDFkp?=
 =?us-ascii?Q?QBmYyyG9mOO3zJ7xmEM6frJ5xFt8iOP6pbD+Q2kTuyS+WdaX4VRrzlYEJlFp?=
 =?us-ascii?Q?RQ+vBucuvODuFpmsC7rCOSlWDKHw+R1UBk/Ev9YpbdtoDS3XLEBUcG7V/aDR?=
 =?us-ascii?Q?uZu2j1A1VEtD6DSEE126mAUIKMPN5Yl8nBspzJu4SuXTTtWmAGHdZOFBzA8E?=
 =?us-ascii?Q?pqo1NaG2Wjh/7yGIi1KYN5rSirj9B6xJ/Z8by9+I2/FTPSsQ15sMhXi1pGd1?=
 =?us-ascii?Q?GumB5k2GqDT7KUoOAIxL9DU//So+AwX7VkYxNhoNueJ90e3ZDsUqV0+JZ88r?=
 =?us-ascii?Q?8hiDBMH5D2ZVHIEfpIxs1q1NGE9/5TBrlgqwp7dg1rx/ScAVIwGAzTBtlkVW?=
 =?us-ascii?Q?6WKBh0lMajSLy1KMg7XOLT9YO2ClXf8r6j1umAiuVHdQMAJsFMwpyB5rVa+Y?=
 =?us-ascii?Q?mbxMs3rQMRLi1YjZxeDRiNVQXIzTp9g=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 649706c8-71e6-40a8-6fb7-08de707cce0b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 12:37:26.9563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pcTW4tmORzUqrc1qW163cc+6PrQXzK+g5kbP4kxyqNKMOqd6KWZubSqC/SUjqL9PUpAwdviBMpory2DAVSUcyomYD4aOKRgb9hSEMWHxeF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7320
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,vger.kernel.org,intel.com,fomichev.me,davemloft.net,google.com,redhat.com,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-259705-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 3CC0E16785D
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 02:55:29PM -0800, Jakub Kicinski wrote:
> On Tue, 17 Feb 2026 21:08:51 +0000 Nikhil P. Rao wrote:
> > AF_XDP should ensure that only a complete packet is sent to application.
> > In the zero-copy case, if the Rx queue gets full as fragments are being
> > enqueued, the remaining fragments are dropped.
> > 
> > For the multi-buffer case, add a check to ensure that the Rx queue has
> > enough space for all fragments of a packet before starting to enqueue
> > them.
> > 
> > Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
> > Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
> > ---
> >  net/xdp/xsk.c | 23 +++++++++++++++--------
> >  1 file changed, 15 insertions(+), 8 deletions(-)
> > 
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index f2ec4f78bbb6..f7f816a5cb80 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -167,25 +167,32 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
> >  	struct xdp_buff_xsk *pos, *tmp;
> >  	struct list_head *xskb_list;
> >  	u32 contd = 0;
> > +	u32 num_desc;
> >  	int err;
> >  
> > -	if (frags)
> > +	if (frags) {
> > +		num_desc = xdp_get_shared_info_from_buff(xdp)->nr_frags + 1;
> >  		contd = XDP_PKT_CONTD;
> 
> [1]
> 
> > +	} else {
> > +		err = __xsk_rcv_zc(xs, xskb, len, contd);
> > +		if (err)
> > +			goto err;
> > +		return 0;
> > +	}
> >  
> > -	err = __xsk_rcv_zc(xs, xskb, len, contd);
> > -	if (err)
> > +	if (xskq_prod_nb_free(xs->rx, num_desc) < num_desc) {
> 
> We can pull this check into the branch at [1]
> It will let us preserve the existing flow.

Hi Jakub,

that would work, yes.

> 
> Either that or handle the non-frag case fully upfront:
> 
> if (likely(!frags)) {
> 	err = __xsk_rcv_zc(xs, xskb, len, 0);
> 	if (err)
> 		goto err;
> 	return 0;
> }
> 
> As is you have a weird mix of the two.
> 
> > +		xs->rx_queue_full++;
> > +		err = -ENOBUFS;
> >  		goto err;
> > -	if (likely(!frags))
> > -		return 0;
> > +	}
> >  
> > +	__xsk_rcv_zc(xs, xskb, len, contd);
> 
> Personal preference perhaps but removing error checking always
> gives me pause. Maybe:
> 
> 	bool frag_fail;
> 
> 	frag_fail = __xsk_rcv_zc(xs, xskb, len, contd);
> 	list_for_each...
> 		...
> 		frag_fail |= __xsk_rcv_zc(xs, xskb, len, contd);
> 	DEBUG_NET_WARN_ON_ONCE(frag_fail);

error checking can be actually skipped as xskq_prod_nb_free() peeked into
xsk rx queue and told us there is enough space for descriptor production.

I have sent a patch that adds a variant of __xsk_rcv_zc() that skips
xskq_prod_reserve_desc():

https://lore.kernel.org/bpf/20260218150000.301176-1-maciej.fijalkowski@intel.com/

Logistics of these patches (this set & patch linked above) are a bit of a
question to me though since what Nikhil sent are clearly a fixes that need
backports whereas mine was sent as an improvement towards -next tree.
However, path that Nikhil touched here should be adjusted to what my patch
introduces. I might do this as a follow-up once bpf is merged to bpf-next.

Nikhil, I also see you routed the set to 'net' tree, previously xsk core
was handled via bpf/bpf-next.

> 
> ?
> 
> >  	xskb_list = &xskb->pool->xskb_list;
> >  	list_for_each_entry_safe(pos, tmp, xskb_list, list_node) {
> >  		if (list_is_singular(xskb_list))
> >  			contd = 0;
> >  		len = pos->xdp.data_end - pos->xdp.data;
> > -		err = __xsk_rcv_zc(xs, pos, len, contd);
> > -		if (err)
> > -			goto err;
> > +		__xsk_rcv_zc(xs, pos, len, contd);
> >  		list_del_init(&pos->list_node);
> >  	}
> >  
> -- 
> pw-bot: cr

