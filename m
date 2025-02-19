Return-Path: <netdev+bounces-167589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B24A3AF99
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 03:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0C116D490
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 02:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F0B75809;
	Wed, 19 Feb 2025 02:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V3FmE3Dv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF088BE7;
	Wed, 19 Feb 2025 02:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739932199; cv=fail; b=kQEuGJOJ8ji/lUaBod3iUrA416jAHeAh0QFmf2FNh0wpSWyB6H6gSgXIYV2S1GRqGHCQWEYd8Xg7PNxaULQFgnt4sKYcnXpKsnd3yh+S3QweG9NQ09YhpLly5FNwwedtCGm7ZSLlXxTWZ8cQCcPFwLeboq0ZrJMy3FJjvJKK8gE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739932199; c=relaxed/simple;
	bh=8YNZKksrI2i1DkfTy70bSWhXcyzccItWfIIFoinjCtU=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hhjZr5+LKwHdeyB54NfyaCwSBkgNiwSiQ3v0ilFm5vVVW3xEDb+LoG4Wx4AJJzONtcLunWxyBSpej84vre7twdTXxwjFZNqrWkslMiDQ8yqqEzhJXllxneVdnNMRkRvklwdGYc21vUb1k/8Yd7J6Ewg/Kt+3F0gvGnXjy3ejUF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V3FmE3Dv; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739932197; x=1771468197;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=8YNZKksrI2i1DkfTy70bSWhXcyzccItWfIIFoinjCtU=;
  b=V3FmE3DvdS+yiq2C8lY17BfttMRL18BKRDC+jmKmzsOwJpEKVdoixAVX
   duIHpycysqVBYwE865+En7CRY8s2zqp7YssDHLUu1EqmZ2XY0WN1T6+eZ
   DglAMd3+M5M2tEg9GZ5Jg39EqUYf+PGcLemEuSwrCJ28eeo9CQzwZjxNx
   +mfKfogSvaL/GFXaT8TJhCo5Hf/CPf0TK+yE9IpzaqeP3Zg3fM1w80CO0
   h6YhTPbQtxnHs/RppLOBh973vNKTczgyzW7366LZFR1rZZdBmizusBSB0
   IyxfrlzlxLypdSmhhq0APpOqLbNxhyG+6lv8s5vVI3g5/xQhYuG48VJQq
   g==;
X-CSE-ConnectionGUID: 2VV3dvzQTGSYjRa7IMLFOA==
X-CSE-MsgGUID: 6SiSfHa2S5uON24wRy7+hA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="58055495"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="58055495"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 18:29:57 -0800
X-CSE-ConnectionGUID: eaEO4/HISmWUsB+2tg2JzA==
X-CSE-MsgGUID: 4pkvtqkMTCKxDRAF4XRM3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="119558593"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Feb 2025 18:29:56 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 18 Feb 2025 18:29:55 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 18:29:55 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 18:29:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XK4+eaCvzgdt9JIIWJtKNZQoyzi+3vlbWGMpCqhrWQEsU0ZltiSjOsbHxKz7FE/LwPpKcLJSsMusOWbHyGkqcfxid3UlD5SZyYM2t6kF3WqskLhTxRRew+OfV96Mpo6G0bXv09d9RHVeJko4bmWjXRrhFNvwB64nUtZmcE/Ro0AUtFmzOnuaa5/4+zHNlsd2qcGmDpyUc/GvHBCRaErC/gOxxV6oDwkiFwX4z8+wNrtAal8JKvbyXAn7mRHjKGFS/gNq6jqsVCkwv5JwQmbGYcsZ9Tyw+RY2cNIq0+eQw0DpuQ3EwAPjUlcqA8fyKzHCI/DvFx7aR3Ixn3TXM61wLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TEydFl74UazO/iPfEfmCrqUKaPx26ECVcxMSks20j94=;
 b=FWu/CY0NEM4l8vM85vWokfKbkNa8sf+SYFPbgL6vymebeZRejRC9Q/lf0qXFk8LxWonrc39w4ChMsT+DHh0o0lXT3fOG/dCvsMzMQ0q1bEn8oaglbw+E/Q4UR7gQPQY8N8hiyB06kPyQxrJta8FExo0THyyDLFvZK1jjk12jGZqJYvkRVSDcV256RkbotviwbkrFeT5Wy7YA4uJ8O2vr33+2AP9UEHgsO25kDmj0UsdRB6gGak2AYgLT5U9cMH0whh/yCbTuFgxJZENCP3NMD7Q1/SHdvhYUNL8M8HPvJI8Cl6y8hf5jzAVnQIZIHw3+G7WXzaKiKBuTRIkQ5qBFqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6555.namprd11.prod.outlook.com (2603:10b6:510:1a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 02:29:53 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 02:29:53 +0000
Date: Tue, 18 Feb 2025 18:29:48 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
Subject: Re: [PATCH v10 01/26] cxl: make memdev creation type agnostic
Message-ID: <67b5421cd91d2_2d2c294ad@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-2-alucerop@amd.com>
 <67a50f7fbdfb_2d2c29447@dwillia2-xfh.jf.intel.com.notmuch>
 <33aceef3-9e01-4b28-bc3e-7dc11b59a1f6@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <33aceef3-9e01-4b28-bc3e-7dc11b59a1f6@amd.com>
X-ClientProxiedBy: MW3PR06CA0009.namprd06.prod.outlook.com
 (2603:10b6:303:2a::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6555:EE_
X-MS-Office365-Filtering-Correlation-Id: 3953c94e-31b9-4b86-4293-08dd508d4aa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P2HEn1Q5toDJM3MJ/b4msenerFlCbLOJ7AVElOY478LRGPExPc2JKzvexpQi?=
 =?us-ascii?Q?3p7ppF/Rsii+xJxDk/2haKHQTbFR2QvFNMQTCOmRhN6llFN7cYNqHXd5diJn?=
 =?us-ascii?Q?raClzMcc0MV0wKZYHpeNrO/tieICMvFxua1U3uUOuzuoQRxm7pvOQx+3dDX3?=
 =?us-ascii?Q?glW+2jnxTlLU/FNTdBF7ECZLgk0TxkMOQ0/lIhq43hTSzaYtx+UcGBcVWbkz?=
 =?us-ascii?Q?lX6PpT1WZDal2PnNizdVNHj4w3vHWSSN7JLZknQSr4PrjwqgebJi1vR6Qm1R?=
 =?us-ascii?Q?hYmRvFslXhoZwnZCDPWdLhzWmoejttsPAS5G5PsJCNa4SALLsq5O73GBc8Rl?=
 =?us-ascii?Q?BcXZlPLwx6Md+ytrR42xCYyYGIyQb+FBbPEekGTWv4ek5wWeGMuTAoPZNkk0?=
 =?us-ascii?Q?anMDysjdeTwKDJSjsoAeYC2eAHutxH/4rh6yISqO1jpwUwAGo8QzjrQZD5ur?=
 =?us-ascii?Q?Y0ZymPImF1a24gqtvFBkrHnR5RSvNYZWwtwj0n59MZgnd0+QzfJQ0Aw1vbRg?=
 =?us-ascii?Q?dMiWUnQtQZzpSMePemCjkKt/t+QFwdAEsgKYaYppY5ywr0Zq/zWNRVJ27J08?=
 =?us-ascii?Q?vf49YcfWgHAWupFqTsjjGc4hut+bz3LngtM3d2nfFMUj9f4h6/mwq6Hyu7AM?=
 =?us-ascii?Q?jvRuNchgfvXaNs9nIPGCQtVeoTdCJvfFw0B4TuXJGvvQ/PG/0swscvPSCUdH?=
 =?us-ascii?Q?j1AcUxZPdhclONA9O7u5eRPQJj4WARW4lSYyrXpNfj5QsjZAsvJub2FUjz1L?=
 =?us-ascii?Q?+nXl2dc5VeXaOpwbzvPKB+FBdhbUxJlZGZsJOXW0qYWmczdY/PB5O/pFDTtf?=
 =?us-ascii?Q?PnbsqKDOSt82T65Hc9z8uXCrX6DFLglHgudVA85UuIkOzTy0cN2cizzh6Nk6?=
 =?us-ascii?Q?nkw55bLLVCYXZD1Dkc9Id9c+TxhtM9RiAOBbqEEmQEBmd2MkFv8mUJK5c5fH?=
 =?us-ascii?Q?ooAMIZYyGz7Gua0pKFlV2UNkqRunQj7qI0e3JliaxxQohG01PNfipfHgU68O?=
 =?us-ascii?Q?Ytv0gH+An2ckRZxg4Dgr9UZiB7BKb2r/zjhiEntBkGTNu0bDayVJORfsvYg0?=
 =?us-ascii?Q?VdAgLN3LV4zMU8+Gva9r6jdZAm3n4DqvftkIc+IBJNK6f8SAFgqaHHsWxatv?=
 =?us-ascii?Q?RKpT5sfLsNNWvZRr0+Au5AzYxlh/JdmzRlmD4GjIBmNw9OWPvY7DT1Jq3+NG?=
 =?us-ascii?Q?7ynXAlbYuJxJDcbW9DAcHd/l/g2Qd8JAPS/nubuRbmnN007Ee6JeYUyyXRbs?=
 =?us-ascii?Q?MNAhJrrx2pEY9PG/Uh7Mbcj/aJoOQIAOiy+2iRO7I4iAHeaPhcrwKPLqymkn?=
 =?us-ascii?Q?DMphWC4Xdjb0sEacJ/i/Wroprngr1XsJRv5Wm7FFly/pvUoRKdE4DaMBPgDj?=
 =?us-ascii?Q?7rS2KSojdHBIgGCLonp3TnaBb6u+ghMkGa9pIK+mDJ/0RviDvQjOYFp1lwKW?=
 =?us-ascii?Q?CdwQmGRxTa0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SafhJtY3V7h01UpHUm5u4m1SslcHkugzDG0j1QVPTrDIUiBUKgzYHL2BAA8U?=
 =?us-ascii?Q?w35PvKuWRjHTjyWmJ/1gOHxplXoT7ezA61bVJmagbx26YooWvj6bcgpEINEM?=
 =?us-ascii?Q?QDn7zxC9jOttBcBYteKop+w/z8gzmyCg0Uyneq+cYEU15sJu/J+5Xou0L7UR?=
 =?us-ascii?Q?zS9Bj+wOdW1iPCaqCNb5Yb6yi3Tyi4domCi7gNa8dmvUDIczEB3mjo7XyeOW?=
 =?us-ascii?Q?8NWMFIm+4bTdOUfLcANsGbo5Qap97y1KrnoYpsjCevtKcTKadk+WjLJO6mk/?=
 =?us-ascii?Q?cKG5+RW0We4o24i0H6HY3Zf6ptSOrru7+uBLt2/SF4P3n25ZMME898scVpwu?=
 =?us-ascii?Q?HBP6MlxrmLEQWHa+1OzBCj0BUGX//NSLvAF5dDDf+GvkJoLdQJxuKai1mBDT?=
 =?us-ascii?Q?zjky6eyymtyT4eNnlamTLanU3xGgaj99cgvnBtCxjjahJhr6xt5inKnu+++G?=
 =?us-ascii?Q?xvJJwmpz/NqAf9SnfuzyuLtfZv+03gobCnBwwBmG19v2ZgBOYMUW3fh2vnHy?=
 =?us-ascii?Q?KSbAGgHXh6czesr9IAUh5j8n8desCxc0KQnwGy7Xgo8wF9CvvTkPGYafUhyp?=
 =?us-ascii?Q?Yw5xyqgqb/8ZxUAjqXK2Kb8EDkqbJnGYMmsHMDATak/yliFLzuL1bJ795lQV?=
 =?us-ascii?Q?NNPRMhsBGq3jgHA1Bz28TACmGzz7zCkEC9GEx8ow6mKY6d7E7omTh3PDaDRc?=
 =?us-ascii?Q?UXPb5QjITCEr2pVwR7qejqW2Of0Bhht3W9T+K+vj2bJY2yQcKSAszQ/xpoVr?=
 =?us-ascii?Q?EnhM/nUNLqBP6xNho41wIpBJmjfQ5ls3msbi/JeJXyxmt2ro3nFcTx9xtdQU?=
 =?us-ascii?Q?CORz5YrUAZ7gFQKus4yAF5aZah5zlin516+9ESKx3QWYQ+/9jHzMOj4bYxnJ?=
 =?us-ascii?Q?+AsgspjpMoD6y6+CDthZ1L9pRJf2R/UiiDlcO+jdau7r45pBsuvrewwJOMzm?=
 =?us-ascii?Q?uDcX6tFAKuDuJnDUU6tb7z+oz1jnWPkEE2lPcicqmPEu9KFw3HoxpcS4cHYv?=
 =?us-ascii?Q?gsljCkdbbhgRe72gNZPbFpVISnwt7wn0hZ8fG23tmjH2S4ni8IrDhsXALZG8?=
 =?us-ascii?Q?QXz0VFqZp+D+yjfNlEeEZVqg4YAziOwYmXe9Ack5GFh2jjpoINjFlembvU8b?=
 =?us-ascii?Q?dn+i7ZUcDlCLtIhQLhxy90pVKLFegoUICYqnSnoCiZp/zArRK1bxtOTdk2kD?=
 =?us-ascii?Q?zgctIupeF3zqDeOTlkbeoebZsz6XL0tC6f+ApMaaQ/HxpouKemnIoBm5Gt6i?=
 =?us-ascii?Q?JuHuZwySuY7dyM29o8xkwZlecKaVKdOGKqMDlTK3GUswCYh1b/L5GwFccvbE?=
 =?us-ascii?Q?2Q0qiJJgeJrwFPvlOtUi3qKBjPX9p+kRp6BvXGRBQFpypuom9+E6oKWrH8rY?=
 =?us-ascii?Q?t3ccv7lXOJendVIcz5w/pwLbh1vIqvnBqErRlFWTag7R21+3u4SXJDcw+Gbh?=
 =?us-ascii?Q?5B+Xt81k7dlSeUqtr+MVh7Ls5Y1GRazD21/IxJDEqz4I2rmKve3YL3LLfCUd?=
 =?us-ascii?Q?s4VOuwbdzYDgpiosbFtwKvo2IoPyPeRZgUVuR4j7BrZB+5G6IxRMSR+QLzzL?=
 =?us-ascii?Q?HrndR/owY536FRFMFwtzW8Uw82SIz5Upj5G6VtotWemtUnoQVoemmhkBptjz?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3953c94e-31b9-4b86-4293-08dd508d4aa1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 02:29:53.1898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1iChpgUubLYbQKU+qZJxYFuzne/6woOBmp/L5lF1iiqdO1jUbjYGOEqw8TIJNWV7CkrrJlfW0p3IlRKTLKGVaqZ6oUj1NaUrP/lo7p/sD6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6555
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
> 
> On 2/6/25 19:37, Dan Williams wrote:
> > alucerop@ wrote:
> >> From: Alejandro Lucero <alucerop@amd.com>
> >>
> >> In preparation for Type2 support, change memdev creation making
> >> type based on argument.
> >>
> >> Integrate initialization of dvsec and serial fields in the related
> >> cxl_dev_state within same function creating the memdev.
> >>
> >> Move the code from mbox file to memdev file.
> >>
> >> Add new header files with type2 required definitions for memdev
> >> state creation.
> >>
> >> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> >> ---
> >>   drivers/cxl/core/mbox.c   | 20 --------------------
> >>   drivers/cxl/core/memdev.c | 23 +++++++++++++++++++++++
> >>   drivers/cxl/cxlmem.h      | 18 +++---------------
> >>   drivers/cxl/cxlpci.h      | 17 +----------------
> >>   drivers/cxl/pci.c         | 16 +++++++++-------
> >>   include/cxl/cxl.h         | 26 ++++++++++++++++++++++++++
> >>   include/cxl/pci.h         | 23 +++++++++++++++++++++++
> >>   7 files changed, 85 insertions(+), 58 deletions(-)
> >>   create mode 100644 include/cxl/cxl.h
> >>   create mode 100644 include/cxl/pci.h
> >>
> >> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> >> index 4d22bb731177..96155b8af535 100644
> >> --- a/drivers/cxl/core/mbox.c
> >> +++ b/drivers/cxl/core/mbox.c
> >> @@ -1435,26 +1435,6 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
> >>   }
> >>   EXPORT_SYMBOL_NS_GPL(cxl_mailbox_init, "CXL");
> >>   
> >> -struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
> >> -{
> >> -	struct cxl_memdev_state *mds;
> >> -
> >> -	mds = devm_kzalloc(dev, sizeof(*mds), GFP_KERNEL);
> >> -	if (!mds) {
> >> -		dev_err(dev, "No memory available\n");
> >> -		return ERR_PTR(-ENOMEM);
> >> -	}
> >> -
> >> -	mutex_init(&mds->event.log_lock);
> >> -	mds->cxlds.dev = dev;
> >> -	mds->cxlds.reg_map.host = dev;
> >> -	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
> >> -	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
> >> -
> >> -	return mds;
> >> -}
> >> -EXPORT_SYMBOL_NS_GPL(cxl_memdev_state_create, "CXL");
> >> -
> >>   void __init cxl_mbox_init(void)
> >>   {
> >>   	struct dentry *mbox_debugfs;
> >> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> >> index 63c6c681125d..456d505f1bc8 100644
> >> --- a/drivers/cxl/core/memdev.c
> >> +++ b/drivers/cxl/core/memdev.c
> >> @@ -632,6 +632,29 @@ static void detach_memdev(struct work_struct *work)
> >>   
> >>   static struct lock_class_key cxl_memdev_key;
> >>   
> >> +struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
> >> +						 u16 dvsec, enum cxl_devtype type)
> >> +{
> >> +	struct cxl_memdev_state *mds;
> >> +
> >> +	mds = devm_kzalloc(dev, sizeof(*mds), GFP_KERNEL);
> >> +	if (!mds) {
> >> +		dev_err(dev, "No memory available\n");
> >> +		return ERR_PTR(-ENOMEM);
> >> +	}
> >> +
> >> +	mutex_init(&mds->event.log_lock);
> >> +	mds->cxlds.dev = dev;
> >> +	mds->cxlds.reg_map.host = dev;
> >> +	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
> >> +	mds->cxlds.cxl_dvsec = dvsec;
> >> +	mds->cxlds.serial = serial;
> >> +	mds->cxlds.type = type;
> >> +
> >> +	return mds;
> >> +}
> >> +EXPORT_SYMBOL_NS_GPL(cxl_memdev_state_create, "CXL");
> > I was envisioning that accelerators only consider 'struct cxl_dev_state'
> > and that 'struct cxl_memdev_state' is exclusively for
> > CXL_DEVTYPE_CLASSMEM memory expander use case.
> 
> 
> That was the original idea and what I have followed since the RFC, but 
> since the patchset has gone through some assumptions which turned wrong, 
> I seized the "revolution" for changing this as well.
> 
> 
> A type2 is a memdev, and what makes it different is the exposure, so I 
> can not see why an accel driver, at least a Type2, should not use a 
> cxl_memdev_state struct. This simplifies the type2 support and after 
> all, a Type2 could require the exact same things like a type3, like 
> mbox, perf, poison, ... .

I disagree, I think it avoids the discipline of maintaining Accelerator
CXL.mem infrastructure alongside the sometimes super-set sometimes
disjoint-set of generic CXL memory expander support.

Specifically, the reason I think the implementation is worse off reusing
cxl_memdev_state for accelerators is because accelerators are not
subject to the same requirements as "memory device" expanders that emit
the class code from CXL 3.1 8.1.12.1 "PCI Header - Class Code Register
(Offset 09h)".

The whole point of the CXL_DEVTYPE_CLASSMEM vs CXL_DEVTYPE_DEVMEM
distinction was for cases where accelerators are not mandated to support
the same functionality as a generic expander.

It is not until patch12 that this set notices that to_cxl_memdev_state()
has been returning NULL for accelerator created 'cxl_memdev_state'
instances. However, patch12 is confused because to_cxl_memdev_state()
has no reason to exist if it can be assumed that 'struct
cxl_memdev_state' always wraps 'struct cxl_dev_state'.

The fact that it requires thought and care to decide how accelerators
can share code paths with the generic memory class device case is a
*feature*.

So either 'enum cxl_devtype' needs to be removed altogether (would need
a strong argument that is currently absent from this set), or we need to
carefully think about the optional functionality that an accelerator may
want to reuse from expanders. As it stands, most of cxl_memdev_state
makes little sense for an accelerator:

> struct cxl_memdev_state {
>         struct cxl_dev_state cxlds;
>         size_t lsa_size; 

Why would an accelerator ever worry about PMEM?

>         char firmware_version[0x10];

Certainly accelerators have their own firmware versioning and update
flows independent of the CXL standard?

>         DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
>         DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);

Mailbox is not mandatory and Memory device mandatory commands are not
mandatory for accelerators?

>         u64 total_bytes;
>         u64 volatile_only_bytes;
>         u64 persistent_only_bytes;
>         u64 partition_align_bytes;
>         u64 active_volatile_bytes;
>         u64 active_persistent_bytes;
>         u64 next_volatile_bytes;
>         u64 next_persistent_bytes;

Already had a long discussion about accelerator DPA space enumeration.

>         struct cxl_event_state event;
>         struct cxl_poison_state poison;

These might be candidates for accelerator reuse, but I would suggest
promoting them out of 'struct cxl_memdev_state' to an optional
capability of 'struct cxl_dev_state'.

>         struct cxl_security_state security;

PMEM Security is 2-degrees of optionality away from what an accelerator
would ever need to consider.

>         struct cxl_fw_state fw;

Not even sure that cxl_memdev_state needs the ops passed to
firmware_upload_register() make little use of 'struct cxl_memdev_state'
outside of using it to look up the 'struct cxl_mailbox'.

> };


> >   Something roughly like
> > the below. Note, this borrows from the fwctl_alloc_device() example
> > which captures the spirit of registering a c4ore object wrapped by an end
> > driver provided structure).
> >
> > #define cxl_dev_state_create(parent, serial, dvsec, type, drv_struct, member)  \
> >          ({                                                                     \
> >                  static_assert(__same_type(struct cxl_dev_state,                \
> >                                            ((drv_struct *)NULL)->member));      \
> >                  static_assert(offsetof(drv_struct, member) == 0);              \
> >                  (drv_struct *)_cxl_dev_state_create(parent, serial, dvsec,     \
> >                                                      type, sizeof(drv_struct)); \
> >          })
> 
> 
> If you prefer the accel driver keeping a struct embedding the core cxl 
> object, that is fine. I can not see a reason for not doing it, although 
> I can not see a reason either for imposing this.

The cxl_pci driver would use it to align on a single way to wrap its class device
driver context around 'struct cxl_dev_state'. So it is more about
setting common expectations across cxl_pci and accelerator drivers for
how they wrap 'struct cxl_dev_state'.

[..]
> > struct cxl_memdev_state *cxl_memdev_state_create(parent, serial, dvsec)
> > {
> >          struct cxl_memdev_state *mds = cxl_dev_state_create(
> >                  parent, serial, dvsec, CXL_DEVTYPE_CLASSMEM,
> >                  struct cxl_memdev_state, cxlds);
> >
> >          if (IS_ERR(mds))
> >                  return mds;
> >          
> >          mutex_init(&mds->event.log_lock);
> >          mds->cxlds.dev = dev;
> >          mds->cxlds.reg_map.host = dev;
> >          mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
> >          mds->cxlds.cxl_dvsec = dvsec;
> >          mds->cxlds.serial = serial;
> >          mds->cxlds.type = type;
> >
> >          return mds;
> > }
> >
> > If an accelerator wants to share infrastructure that is currently housed
> > in 'struct cxl_memdev_state', then that functionality should first move
> > to 'struct cxl_dev_state'.
> 
> If you see the full patchset, you will realize the accel driver does not 
> use the cxl objects except for doing further initialization with them. 
> In other words, we keep the idea of avoiding the accel driver 
> manipulating those structs freely, and having an API for accel drivers. 
> Using cxl_memdev_struct now implies to change some core functions for 
> using that struct as the argument what should not be a problem.

To date, 'struct cxl_memdev_state' has been a dumping ground for random
context that the class driver needs. The consequences of that dumping
have been low as the only potential burden would be self-contained to
the only user of 'struct cxl_memdev_state', cxl_pci. The creation of
'struct cxl_dev_state' was motivated by the observation that the arrival
of accelerators ends that honeymoon period. The implementation needs to
be conscientious about not spreading cruft amongst multiple disparate
accelerator drivers and their use cases.

The cxl_pci class device should be able to change the cxl_memdev_state
structure at will without worry or care for understanding accelerator
use cases.

> We will need to think about this when type2 cache support comes, which 
> will mean type1 support as well. But it is hard to think about what will 
> be required then, because it is not clear yet how we should implement 
> that support. So for the impending need of having Type2 support for 
> CXL.mem, I really think this is all what we need by now.

I want to avoid the liability of accelerator drivers silently growing
attachment to functionality in 'struct cxl_memdev_state', and architect
a shared data structure / library interface for those pieces to reuse.

