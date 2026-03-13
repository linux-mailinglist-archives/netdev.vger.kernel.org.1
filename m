Return-Path: <netdev+bounces-267353-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAE6MTjas2mzbgAAu9opvQ
	(envelope-from <netdev+bounces-267353-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:34:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCF4280929
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8904130FEF10
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 09:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDD022A4E9;
	Fri, 13 Mar 2026 09:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YRtgHt/h"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2801B1A3160;
	Fri, 13 Mar 2026 09:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773394259; cv=fail; b=ngw8Y/EZWp5iISPamg6q454x51tWg4u8ec9W2Wi9C8WbxSzNHPbC/PZ9PJdR4Iwap0iTTHwN5kCQQQ1URW5EvDgVQ9MUE2cEmM50g7xL0Wl2PKhPWlWm5Zna5VrXUBXJWH9cf82H6E7nnglAzZG/sWiZPORt8L8M4pdpPDEWyI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773394259; c=relaxed/simple;
	bh=saW5kHdvt5mpvmhnY4kunEJX4QTj8C3OH1g5nHTdI9w=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YexI273JcdnPB49Da2Xivk8TpAh+e5SYw5YhQsiFDJ08/DHdh4jtOeAMURn9CKShuMWbAxCQZANG1sFqMWP8yI6NZ4Hvkslf9o5dbEcFASYtfor3T6b3621lB7d9t9v7CEbG6EU+u650YXZOTKQp/bnifKZiq9AaJYXTBUjfTJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YRtgHt/h; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773394258; x=1804930258;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=saW5kHdvt5mpvmhnY4kunEJX4QTj8C3OH1g5nHTdI9w=;
  b=YRtgHt/hw7sjUyA5tYUr3UXWTzEYJP+DZfgmukmCOMBPMt+VXObyfE61
   Sgoqs47xJCUr/f3VJGAHTO9bDzGQxuT4oXQOPOFoFWRbewi7AqmEr3Lqc
   n0HVtTqvGFGXN0qgG/an5KM3YrJNWcekpL3BbQnY1Kp6pvqMqRp8lsMTX
   mDXJA2mJk8zBYAArirP0z04rOl5X+uHhbwlk2F6QfFN5RB6RaLa6iolOI
   8SP8Fz7qhYZunXX6jDfPMkAEYtxr2/GmDuBnQMMQPiJoFvSwwR//w+vll
   Mxebvpdpi2eh0G7wTSVh21SJwc+GkNe9BBB2yIm8dxQMfmN+/2Dx6uVmF
   A==;
X-CSE-ConnectionGUID: W5VCmPakQbKXpmCfqXWUbQ==
X-CSE-MsgGUID: iy2DlkPTQReSnBB+eBIzbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="92074477"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="92074477"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 02:30:58 -0700
X-CSE-ConnectionGUID: dHY4I4NOTLO0IyT0GCArsw==
X-CSE-MsgGUID: Ak2gSj65TkGkpggTv9aY0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="223480380"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 02:30:57 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 02:30:56 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 13 Mar 2026 02:30:56 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.32) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 02:30:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5l2Izpj3OvG+MkuJiORJXXRgYIxRUIKtGwV0Wgi1FanGvcnKH2kCbg1XOFUsg4+jZdGVjHYk/NP2yZ7N55an2lGO5Z0cFeiRzwgURn6TnPp6cyk9jbgMIuykH+5iz1zcrJNBGMlVcx7+o/boZFtc/z6JOZooBMHvdke+vYyhCaKLSSwEjCXFN6pwX1tFtdxerlFXWE3qxOvOz61vFtkk+eSFlVxOvVd0dNxPNZ80335cD8sb7tOb5VKbAUN21oUhP/uTwo3N4vnzOWI6ju1uqDxQtJXbLROc/xzT7F0K1xvXxH6ZJngdLggfPP+HuqMA8Tn7TqlohB1/5BV/4U4ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uj1GxmM2a3ZP4El7krI2740iLgDUWXQSlQ7/EYi0crI=;
 b=IygtJZfQRh2f04AyoNJ613Mm8vlj8NrE/58iX1BH3S+ytDPFNvliGCIbBdW+2udJbQCS9U8A9o9ZSr56JB2WAtpb8SCn7uK1T7Yv/7eJmm25vpmqHjxBIm61AeCd7KCDKnmV+AFgUqSnN2WOikXD9yGMYUeO75LGpWPyZCZLJw3/i5uI9Wi+QtoXUQUtSps+MXiLPGBqYGcYu4+ZN9Rk7OWSFukQiFrd62oC5Wb5BXtEGFYlA9KSwVwVZvYoV38DEOkm1m7PB497qkmcOGzxKVwTHf1qK92mIkyMDZmnKIf+kydaQwqxSAplOSUrFkncfpa/lmxgY9vufQHGAbq5oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by SA2PR11MB5178.namprd11.prod.outlook.com (2603:10b6:806:fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Fri, 13 Mar
 2026 09:30:44 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722%6]) with mapi id 15.20.9723.004; Fri, 13 Mar 2026
 09:30:44 +0000
Date: Fri, 13 Mar 2026 10:30:39 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: Stanislav Fomichev <stfomichev@gmail.com>, <netdev@vger.kernel.org>,
	<bpf@vger.kernel.org>, <magnus.karlsson@intel.com>, <kuba@kernel.org>,
	<horms@kernel.org>
Subject: Re: [PATCH net-next] xsk: remove doubled defines
Message-ID: <abPZP0q1w8ArEMOd@boxer>
References: <20260310134327.422540-1-maciej.fijalkowski@intel.com>
 <abCOYwySxuQnkq_k@mini-arch>
 <a544e971-a22e-47f0-b085-70ea743a4dc9@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a544e971-a22e-47f0-b085-70ea743a4dc9@redhat.com>
X-ClientProxiedBy: BE1P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8d::17) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|SA2PR11MB5178:EE_
X-MS-Office365-Filtering-Correlation-Id: 0113f72d-cf2e-4323-22f5-08de80e3338b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7czXnhJuW7xtl6jQ3twwQ5rfb7cwhRHWOcHuAiK+4Og2+nw8Zg51bDgh9x7s6WGL7xgM4ZXx+GL0viGV4vTinbkfwff4/AgkfFOIPoFqadc96cB/LPbermjsQTjEE7+/JXxo+CJhVU7kRHL1eqblmxgRkJU808hZocola62BiZNO9aGsU4Nl95HlKCiwqFI4l1EuluHAerFxGJLj6gr6He8NT7H9f46pkODfyuvemfPuAYdowZkRjq6WnaQISCu6HDx0p+GJE7HLdtuUVGNxlUztgVq0Nr6NQbTiyTd1pCNKEVBtREQmoEWMZ8+MnOT84E9iGK8KOEPRlZ3kccHp/Y6+YfqKQClOiZvJKQ1X2Lu5s2+8Z4B3DGM3Qoeu7zGsmUC79RIZgKQ3TfpboGxLffEJmC6AMgfH4JPLe/MdnQcnvtzseyFmoVFgsnCSJDtrNwGbaxZsPVRCg078abUzHUr3JfbXa3eZ+h1AIc8ZOq59RC1oJ5aq/k+6S/an53hLDoZZN4c3/RXKJbSDP9g+/NZcbo3bVK+841XIJHcjNnocK9cfk99l46eRRwiILWvSqqUU3eMR8grShrw/erHPn4IO4e0LcYtIqKW+dVTn4KBrAF3++zPE0+2+rj2+GDyzkj/eA5WEJC1K0c15VTi4Pi4nKdYR/ycFHpWvoEbxvHUNqsQTJF6YcvhAyz8RAaGntprxVrDcHhTDRDJFlJDa+9iE93A+hQu0M+HLTwe5Xe0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nHZvlaCWIMqOAKCSwAPvzgBvFqRMecDaXvZS/Agac5keixOyanc61PTPoGgJ?=
 =?us-ascii?Q?sv3SdFDBFg1Q+0MJnLbGaLwmdcb+iihootmnPhrhQqEXlhgGNTv+wEFB95Yw?=
 =?us-ascii?Q?cNlhHX2DZFj6jJLk+4QJaOJ43p8nKXZA0MHikRPmUxjz7y3hR+8EYOaTAQ5R?=
 =?us-ascii?Q?ICionMLC8jeNmnHjEaKMN3eOWaFVzel8uzZNnHiVzfe8yaWkTIYNNhRvd7DR?=
 =?us-ascii?Q?elFhGgiR9ucVnU6c7QyOje7Xo71y6t/uXDsgKt+04T7e020V+9S6Y0PmNBy8?=
 =?us-ascii?Q?cokgjqDNKB97MB81P5dRf1F+rdSxNfI6vgAp5bvSoUFMzuE48iqVJ2T2nv2F?=
 =?us-ascii?Q?8NnWyPf/L2G7tbNIkhttkgNcqHoeebYmK3qSgMix2/QefCEBex78InB0+XJp?=
 =?us-ascii?Q?7HvyM/piBekqHx9BxpcuXSss6DKRVzhyH2CPdPKlpLTKuN8qzwx+i0QimWBi?=
 =?us-ascii?Q?Y70J6eXEVSsy/nmmkPTPgs0HrHsRh3tNPA9gcSU02XvM/B46wilFoQlbyIgp?=
 =?us-ascii?Q?/DWXxeYxzqSNATNXThRAIY4gSYOqov4VDLV/+dXXp8pi28yeaTqtrWFBMxdC?=
 =?us-ascii?Q?D2O9jxom87UTzzKxp4B7BrYI3kVQTs7KRWlL9xFyFr0YB1TUljR66LxLuwgW?=
 =?us-ascii?Q?AndKvpAIreZRxKhY96BxetjSyptZ4F6iQ+S/LqN0BgYS3I553plDfz1UH8Bb?=
 =?us-ascii?Q?Aes+YDmsx7LmW3cpKkJPqoHup/ejhgEYwNtSNe0VNNhNJ1vs7xUuVJlH8CYQ?=
 =?us-ascii?Q?KYEsnNHsH31zPqbyiKmi5rFNpD//yYcnUilShmHSamQyMuiBVB95MjH0vDkd?=
 =?us-ascii?Q?NFc5PgfB1Q7wq810r1/7DMBImsA3PpMee+/YioiZIgLjIvfNUEm4QhrupUAc?=
 =?us-ascii?Q?2LM8dFIsgRDyPiWBVH0TVBJwlsXAI+hQmQrdcJ70WaV8L3FbHXzEwK5DWwsj?=
 =?us-ascii?Q?Ri/U83L5tw95cv9UP2fy3LoKyIgqSor7BSvFnDd6wg1b3OqUZ6QgShoExMaU?=
 =?us-ascii?Q?c6edUrUVzCC5slQu5iuEcgF7mIgqCLUeKn/shScRIZ5xcgXi3jTBwn7PituD?=
 =?us-ascii?Q?qjwN9rSk4sV2w2U3cJJOnx8qwlfu+kzGQnwLbkYSdhtzqvLYm9prM7A9ymME?=
 =?us-ascii?Q?YEJO9O8yV47aXX3tl/VciezQvags63DzMYyo2R/EeWPCOjZxSEh1/m+Btr/Y?=
 =?us-ascii?Q?YZqT8HZmV3Ly7oEp3T/T4/TFnW+/AtDIPV4YZbT2u228ixDOwoSK95PrNyJT?=
 =?us-ascii?Q?xAtajZ12ZzDHrv/NSCZcRh650eb6zFrxzsLgyOPb2H/mJ9QeU0xYv8kyHFkG?=
 =?us-ascii?Q?+JNtNAbUINi23vdcc8ETSncq9Q3xdEskP9yTk4cXlR5O7yKorYW5gbTXWeP+?=
 =?us-ascii?Q?463ocy3cbNWHYw+jf5pYAPCgqL9ZPcPBmr7hGfI7UFhMZsP5WJ6ZPtemTaT2?=
 =?us-ascii?Q?e/W2mGOp4d9WdfX7Aagl8rBnn/GFxVmUfpzH5+k1XOvyv570B/5m3kjgsSjJ?=
 =?us-ascii?Q?1HhG+p3QBsMCq7TJf77zH71ejS8XzfgItG5ILf+bK2wOD2MJOlBbHU/D8rfr?=
 =?us-ascii?Q?PhagZrmxKyL8gKXZhsR4dMCO2KYrzFyuG/d2sWKH+ZD0es8sEMTH4fVZ8lW4?=
 =?us-ascii?Q?mrrBW1RQdFqioQN7sB4jA8E4zOmPBCz79LzATedFuuMsLIy9U7AdnHpHHewt?=
 =?us-ascii?Q?qgVFdZvyIbTQg/EMZSLkWmmrosYRuQmtrf6/lSEdtTr4GrVZikzjn/XhopdL?=
 =?us-ascii?Q?722CjnItZliMJxv74AehsjnT3GlGgcQ=3D?=
X-Exchange-RoutingPolicyChecked: mluJAoJLKH7qaf3vuVPIq5Egray4UrFiZDXxF8p/Mk6ivmgMl2VQj04u/j9u5oCdIJMXlQIcH+PyjtMKK3T5NRKILIgmr3s0e+SzN8l0ZR0fgPQv24d+9KSK1nK2sfbwt0LsI9jGIw7BhwSC3j96yluviyU7iYQ5CddPZncomz4hmqRK7+5R9YSXzhQr9jcCZoVAjayU8OtRxS+gAm29Ga9R5A8uBX1tmFayEMQWXTkUydjlWIF3kcVRmqSt7grmQwFx7JQiLYm3EV9bLoWhzJJ8T9nzMvuGyMvfsr2tBrIYuaSRlhWHXL1bsuaGNk5V2R78cxsIhRoe1Ca1niWjWw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0113f72d-cf2e-4323-22f5-08de80e3338b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 09:30:44.4741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: krQTYsZknG9W1sOUIalxogXfdKgOCK6Txq6Tw4k6126JX+OCBkgT1791srvhCEpPYjjSJX6QMKPK2fkta8CrTvL21vjJ92/vCUAsgFCVW9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5178
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,intel.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-267353-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 4BCF4280929
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 01:39:47PM +0100, Paolo Abeni wrote:
> On 3/10/26 10:34 PM, Stanislav Fomichev wrote:
> > On 03/10, Maciej Fijalkowski wrote:
> >> Seems we have been carrying around doubled defines for unaligned mode
> >> logic. Remove one of them.
> >>
> >> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> >> ---
> >>  include/net/xsk_buff_pool.h | 7 -------
> >>  1 file changed, 7 deletions(-)
> >>
> >> diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
> >> index 0b1abdb99c9e..ccb3b350001f 100644
> >> --- a/include/net/xsk_buff_pool.h
> >> +++ b/include/net/xsk_buff_pool.h
> >> @@ -174,13 +174,6 @@ static inline void xp_dma_sync_for_device(struct xsk_buff_pool *pool,
> >>  	dma_sync_single_for_device(pool->dev, dma, size, DMA_BIDIRECTIONAL);
> >>  }
> >>  
> >> -/* Masks for xdp_umem_page flags.
> >> - * The low 12-bits of the addr will be 0 since this is the page address, so we
> >> - * can use them for flags.
> >> - */
> >> -#define XSK_NEXT_PG_CONTIG_SHIFT 0
> >> -#define XSK_NEXT_PG_CONTIG_MASK BIT_ULL(XSK_NEXT_PG_CONTIG_SHIFT)
> >> -
> >>  static inline bool xp_desc_crosses_non_contig_pg(struct xsk_buff_pool *pool,
> >>  						 u64 addr, u32 len)
> >>  {
> >> -- 
> >> 2.43.0
> >>
> > 
> > All consumers seem to be in net/xdp/xsk_buff_pool.c, 
> 
> AFAICS there are users in xsk_buff_pool.h, too:
> 
> $ git grep XSK_NEXT_PG_CONTIG_MASK include/
> include/net/xsk_buff_pool.h:#define XSK_NEXT_PG_CONTIG_MASK
> BIT_ULL(XSK_NEXT_PG_CONTIG_SHIFT)
> include/net/xsk_buff_pool.h:    xskb->frame_dma = (dma_pages[addr >>
> PAGE_SHIFT] & ~XSK_NEXT_PG_CONTIG_MASK) +
> include/net/xsk_buff_pool.h:#define XSK_NEXT_PG_CONTIG_MASK
> BIT_ULL(XSK_NEXT_PG_CONTIG_SHIFT)
> include/net/xsk_buff_pool.h:           !(pool->dma_pages[addr >>
> PAGE_SHIFT] & XSK_NEXT_PG_CONTIG_MASK);
> 
> > so why not remove the defines from xsk.h instead?
> 
> Indeed it looks like the macro definition is duplicated multiple times.
> @Maciej: could you please drop all the unneeded dups?

Thanks, let me send a v2 with a better cleanup:)

> 
> Thanks,
> 
> Paolo
> 
> 

