Return-Path: <netdev+bounces-163270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E82A29BE9
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 22:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 475951667C6
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 21:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA28214A96;
	Wed,  5 Feb 2025 21:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AO9O0iFg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F18B14F9FD;
	Wed,  5 Feb 2025 21:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738791340; cv=fail; b=Bj4CPmZfj5+iM/Jbs18t93Hxls32TV/pR1n91OSBp5uNyZjwCzgjMklBfwUlHbPuzotTIF8OMk9nmxdRM7DhtpFFTzdxMZhymImpImM5Pob4qEDqVmsWVb7DuF0lzp7Ky6+mKJlCbNcSDaBQaCFEh391IuLqKiHfDCFn9jLM7UY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738791340; c=relaxed/simple;
	bh=WEdIcjTs+euxiEY7Bzzh1iBU+TBef26+A8Ln0l/Cyno=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dlH39gc9wuBSPMas9BFZyWT8RL4nr/5B8OmC+vv9iST8T31g49svil1mG+1yAHryvH+3l2T5A+lxB3gm/AYAhbHpFrlk8hkpVgcB4evlGDSNK/j5KJtZ1DfGZPEvzCGr5SKRBNiqcN5Yxxqf7/UsT8ZCxpUPca7USez+YU+tTKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AO9O0iFg; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738791339; x=1770327339;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WEdIcjTs+euxiEY7Bzzh1iBU+TBef26+A8Ln0l/Cyno=;
  b=AO9O0iFgkd8hRXn9JRthrQSG9EwYqGpb2ua6f/F7iM/x3n/bvAt7D/Iw
   pXCsmmE5d5cPmu/0GuVbqiesYaYTWcr424JvYagFcREyj1e9tDX0pYnSN
   zWCPF2s/zUOKKKPFfzhzsDSk1lDIBkZmg2Ip93EQRs6gBSasQ9KLEnAre
   uKfqe/gBFcwUdLz1aTvJa/dkqTt/xYm+/rmZ5RgWCCvUR49+tl2IVo+ji
   EkBkB1GL/WEfxTUI0H29eTQKRzUC1fPZBSNA1hilBEujm1EUrS51bhyd7
   QqHXwz/whNhpbysQZA2zo9K8PM7znZJ7NzX0yYgvWjLdqQT7XPsHOlY1l
   A==;
X-CSE-ConnectionGUID: jQQkdr2qS46vZnjaIw0AMA==
X-CSE-MsgGUID: b4L0/gRnTv+SDWJOy6mMDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="56795875"
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="56795875"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 13:35:38 -0800
X-CSE-ConnectionGUID: xNUDIWVpQPW+HTNYZiuhmA==
X-CSE-MsgGUID: pSL95zULQ8+g+x5bYM7z9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="110862925"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2025 13:35:38 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Feb 2025 13:35:36 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Feb 2025 13:35:36 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Feb 2025 13:35:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TFPsQ/eJVLa4jzTwYSy1i22Ba2RLPXTeIRmp5KrNnHMjzF6f0sYoCWesh4te5Wh+7+N/TeFX4kRJRgqnN54pcOcMjGJjTUNrED/L8IT68cI8XCNAkFSOR8R/VQgKK8AeRZ1U7SZJ1k5U2t/YY0cIOdbaroRdYLeXvZpmbRWGcN+QIX6z3AUxE6kfWIz6y6qE5YxW1xBeZqxhLxGoQO4WRPiMq8aECkMq1ndXJxEph0cuX2itoQgpyiPyShiE/JISXNjdO1o1BtE2CYcMqn+eiN9d8KRnZTxUU0BDeSbq0XYw89olJxo4z6z7ivbmSlLcR7aQheHV4T1ZeSSNWfOSFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDjCP2N0zBEVzHhw/8L4mrc8NcvwbQYRLwAeQF9t+KU=;
 b=uNNddB3XBcKx4AklHN+6S0jBY7QGMG/Cnar9ZlL72adDP3p37w8k/0vT21FJq3KdJGi1g09lCWNne/y6VtFUzYNYleFG8O1bh9515H1I2nark2cr+vXCedQXvCBfUkSIa3OLZ8wIAjvP+fnIUJosNpjNNH4FxuUimLnsQ0c9bTjDliikQ+Y3ndkyqRBq8JSs3HdTkKkyETApxozRgy2/wGTro9spoRgZSn9vOoJjnmidYpPGjuxoZr89XL/dz+TAHce2A7r4rDXYgNJv3kLARPvbFCfKmwuNcKh0X8gDkgsxBMy/uXtExVkMolnAKR5mKm8f2HwdK8GHUSkX/UgbdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA1PR11MB7872.namprd11.prod.outlook.com (2603:10b6:208:3fe::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 21:35:32 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.8398.020; Wed, 5 Feb 2025
 21:35:31 +0000
Date: Wed, 5 Feb 2025 15:35:27 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: <alucerop@amd.com>, <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v10 05/26] cxl: add function for type2 cxl regs setup
Message-ID: <67a3d99f6af20_2ee2752948a@iweiny-mobl.notmuch>
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-6-alucerop@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250205151950.25268-6-alucerop@amd.com>
X-ClientProxiedBy: MW4PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:303:8f::29) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA1PR11MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: 18923418-97cd-4f9b-6066-08dd462d0460
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eDTpsMThMb1icH3RQ9axgNyn1GLz4nrOMuZ+FUVjb0nbScXYHSXt2MYzTgH7?=
 =?us-ascii?Q?VKLq1HPmAn1WVOpdS23IRtOKxTM/M0CIMFtgmcs69hCvqVMdx6paRG2xuSQr?=
 =?us-ascii?Q?q2mb9t/Uh7EvpUdm9hDSuGT0kyVx1c/kHknHb5lO4LXAANS7cYQMtNftOdLe?=
 =?us-ascii?Q?vwbTEK40MlAVxkHs0cZPTVUiNjXfuR5jvdcKRKxiFDSdfcns0FyTY4tO/KBW?=
 =?us-ascii?Q?U09QvBCcCgxS4ZywGGqYRNZ2227ttdNA3OzjGmPAOCWHlfJQZrAFzA5OCfPM?=
 =?us-ascii?Q?jUYl0JJ388mttLnyNmKZ/R7JqR4RBavdEYbwKfnEycZbTQyesLiKKdwo1gig?=
 =?us-ascii?Q?ZTe0V2d96cALNfAKMK0UHL7E28kLLo+zIyRpGdOFmX9HBhnykSutCy0qqNR4?=
 =?us-ascii?Q?eyzGFVmIji1o2UM5Y5Di91qNBAtFLXz6qyKQjL2heFtTGdN3ebkVx+WGJ5dG?=
 =?us-ascii?Q?SjLywOzmGp/sypsMVfmWjI6zll2BoS6sst3w3tvO3LtNeu4kR/bh1RllLy7S?=
 =?us-ascii?Q?PUPY6t53sif11rkY0hPY7kWiH0aee6a5mLxUhvbBIv/LRepVhyh8MPg6tkH/?=
 =?us-ascii?Q?SaqQdjq0wpt+/XTAhTzVjgFE2gfmQ4vrVIHHMh4Hll9Q5m5e64cfLpj1v3U/?=
 =?us-ascii?Q?xL6bI9sRSU3CMkEaX1BFVxU3VAF0bqxAALOM6E6bHqXqPqqBO4n22IilIF9M?=
 =?us-ascii?Q?SlMppFsHKb6lw1r88ZF29JrDF2udZ6i4ZrA3anNHT9S1pjhlSI1SetTbXKTM?=
 =?us-ascii?Q?y8pRgI5DKqRf0tG44hV3SANMT0s9EJm6pFG7bzFIOO310bY5mMihYs5hMX1E?=
 =?us-ascii?Q?lC/C/ugnb+mqFdmw1ZxujGnS+aNpxYmDgphgAzmz2wUE0hujeQ+g3yQ4PHuN?=
 =?us-ascii?Q?3aTjOZgYdJ+ZCoFX0Do8rW0qjAU4eccRVZCZo/njXXAI0WNXhcB4kCEKjq2o?=
 =?us-ascii?Q?nbHBS0fM3Cp0No3Wn9mV0gYanJaNqh/Btf/WSm5vnBVm/r5ZPka2fgAzLHmX?=
 =?us-ascii?Q?gKHX82lty+BdVySqPzDzKhFFeZGWYOIoIXzHNxesp/2fK6cbVpp+cLP7K6bv?=
 =?us-ascii?Q?K/iOLbYV3E0D5Q09dBS0GW2bNXg6VSJs5+ej4E7v3YcIeePqHKCUnufiv9uw?=
 =?us-ascii?Q?A37SKnGj83vaTSEv4ARILLhGuvriSPXdv7ZAq4qSuK0MyHtKz/oHnMqWPvNT?=
 =?us-ascii?Q?pxIDIzfUw+ltzj1bG8XHu4beesod578hfLk8fLwha7BzSu/DFZKEIKAhukd7?=
 =?us-ascii?Q?w06v7UJCcmXVRPqH6GZofyZRm8Z5/kd+NjHspXOhUppb66A0+0nBK6MIE8FY?=
 =?us-ascii?Q?Gbr4o2mXoSn5Ghrggh/9As81teltTunm1D13hP27Qnc8AUHyZ8ZfEYGnXMcJ?=
 =?us-ascii?Q?llA5TLTncOdZf0d+xCXLkNCyvo6MwxgDUP9QW/tlktPwBOqTd2CA+zw4NDwv?=
 =?us-ascii?Q?F902XZy7Nuo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ivgBAPJTIoBaGLcCBO3Il1+8vDLaRdU9bOX2HiZv3QssgxINDQD7ycdx0qmC?=
 =?us-ascii?Q?0vQR6IPk7DyDTtcA3Mg+axMEELyDKzNLjhgwPwnFn9Z9SmXM86hbktYQs4Tv?=
 =?us-ascii?Q?02xtCyhUXUEwmbJ14SUktpXNIQPjSearzImwN6IrH0X8B/K3UD+mac3GkYjX?=
 =?us-ascii?Q?YrklMEYZLBhHgXuXK0KJnHvLnnLWy2LDBmxNPH4ooB+lVOFgyYG2Wrcahyj2?=
 =?us-ascii?Q?w0H4mkkNNoTFocPasCvnNWfE2xurKivKVh0cuTZoJtSxFjISw6lOy4AdnnL7?=
 =?us-ascii?Q?/jur/q8NTjMU4AqHUtJp/DQL8Fzaftxq58JhZklhIkPnqk8Cz+S8T2W5GRdg?=
 =?us-ascii?Q?j6Qx9nMh1kcTEcSN51dPdqX4dyP9D2bWTzDyv90S3yOCMuhcS9G0a8XCKf0p?=
 =?us-ascii?Q?if9S69NhTXEWajEO9tJ1r8c+nkfLuTyFFCiCnX9jZlbk/0XgEJeVLNXaZVJi?=
 =?us-ascii?Q?GsVhwpn1sIhwtAfA9K2CvZd34UnAYm2whpyqjS7R8tvuzL7lAojkH73jOEDq?=
 =?us-ascii?Q?FimZLtM8jf/MPQ7hTtCOycSJZdBWNQplblyvt/h/nMy18gPWegLaRj9qRHr0?=
 =?us-ascii?Q?BHMjPldecAY/PaHCBsQjNIahXnbtYGZAbT54WkfmKUJ4TJ33lx8Q68q2Wvdr?=
 =?us-ascii?Q?DOUc+O99/TsxHHa/fY75haBF8m7EHuMaQAK8sPQe+sRBYWZRmaCOkou4FNjg?=
 =?us-ascii?Q?uHjBe+4Etguk9ERVtyVpkA689H7BeDjwFWU7X8bYkGHb93mSkK7lqxSm6Ho2?=
 =?us-ascii?Q?+kHsmmpUNfyMNbiUpsUH1H7ItmjzRBM5BO2WTTR/1wRFcIuwCuqR3j60yKsd?=
 =?us-ascii?Q?6ttLLULn8ofwQKZFP1NcSS77if2D7CsHVfa8C6ZOtfNrJcWlWnAmoHGMHSyf?=
 =?us-ascii?Q?EBRUuFDNr9ApmInbnTaRfvOzcIA3jhJdZuzNNRlHaUaEHOTfmh4Nbd2ZYmUD?=
 =?us-ascii?Q?1AMJCyaKw6K363KMzPCMM1rEZ3VnDofV2IakIl4CvIRln6ShOX8Y/4EF0aiD?=
 =?us-ascii?Q?d99cVLm/fbsxSBlmbxRfJRN7Rg2ryAR7Tu+OKB8p2XT/+JeJgOw8lAl14WDc?=
 =?us-ascii?Q?fcitiynKlYx+5MNFZUp/wa2GNObc4PeLq4S/2KTr5oAXS7K+3YjLLE97DQ+0?=
 =?us-ascii?Q?B7msfg+Vac2X69zmdgs2oJqtij1SO/GPQWUXF8c5JypQoinn8twhp3AWrrCQ?=
 =?us-ascii?Q?oCpmsOQpEs+3EFH5h00WvIuJX3xgajTiUx0kYXhBYWcHLzHPdfjpYw4kMuev?=
 =?us-ascii?Q?nkaK2odWATIlcVNjb6GAY1P4KiIGOZ5AqCjQ6klIyraKKxceawkXuhO8HWlo?=
 =?us-ascii?Q?n+zd+f4STmc/1Y6AXK45BalcZfeT2tSo1k2HhOOXpa96JD/dKkNU+k5tNbls?=
 =?us-ascii?Q?nqcxaY4xN+e7ZA7O6GC7AAYh8FUZ82BZkixf1ngs4zVxtkLP0F58ykCgfS80?=
 =?us-ascii?Q?NvTNHGaCMn/f6pknc5UptbjuPeUFkjUru9WC4tDNZnZg6/qsPArnDPQgzzGx?=
 =?us-ascii?Q?BsQNIlRwHVoqBwLT5D7P0RjSA+opSumJC1iuPZgtC+zt74eXF6oYMyUIzQ1n?=
 =?us-ascii?Q?8cNQ+AYrnLPOcef6EzuUINI03NVujDadhId47t+9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 18923418-97cd-4f9b-6066-08dd462d0460
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 21:35:31.9238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s8UVrtxMXXqlxrOn6b38zLfvITICqQcXx9/h5Qh56W6hHKNgqbax99dlTpXAk5QVDgESDbNnHT3Eh1Yc7xVKbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7872
X-OriginatorOrg: intel.com

alucerop@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>

[snip]

> +
> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_memdev_state *cxlmds,
> +			      unsigned long *caps)
> +{
> +	struct cxl_dev_state *cxlds = &cxlmds->cxlds;

Isn't it odd that cxl_memdev_state is passed here only to be turned into
what you really need, cxl_dev_state?

Ira


[snip]

