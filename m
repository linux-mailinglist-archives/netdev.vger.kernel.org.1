Return-Path: <netdev+bounces-159520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E285A15AFE
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 03:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CB35188AD9C
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 02:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C409F15E97;
	Sat, 18 Jan 2025 02:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kP8sorKq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85AE23C9;
	Sat, 18 Jan 2025 02:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737165845; cv=fail; b=ay3Hd1DnEhiZksFzLYNHuDx5Scgu0A0oQssrSYpxe70GJUuqSPw4wLsQ/LM7p5x9SuMw5wC5+JbQBZOve+GAamUo2SuCV76EcRLUes4L+bHXHeeFMlCtQSc0oMxHGNtcHHSnW/Vf+nbK1QRLcAmLdYv2VscAyGhCseYkSUkw9QY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737165845; c=relaxed/simple;
	bh=yUUanv+WCp59MoltxZ/QYVJjAhTFS/8dmf0p1ojBWQc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rnzJtHj2aXi9BKzonWfTSWpcJHvZxYH79EZx8Ks+NQODfY9qDPf3QjOpY/2ilo/S561nYBFPz677eiLtyt6x8UlkGT9vwjBhqfZMh3jAorSSmCaCJzJE9A+Jo50PQVO5J72jXdV3Z5SBCBQ5Nd/bqwxc/3BdZHJ+njEjQ6PxSWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kP8sorKq; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737165844; x=1768701844;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yUUanv+WCp59MoltxZ/QYVJjAhTFS/8dmf0p1ojBWQc=;
  b=kP8sorKqhctyTFjHQA2P/WQ7A7HKNE1nNPqx5unWLVD94igyRJMGwUL9
   IE+ccIz0YhHylBvUsdG/fuw8PHf5n1qM5xxRBLv/EHrxviDWXU/NGuBZQ
   kSSbsIqlm6MsuPVIcZt4/wEsiNtq2E4ZHCkBn7sVzFVM8zYZZ9MqVqZTw
   RmLQZGL6+HbRmQsH+fCcrxMPLWj1B+exir7AlZeuzgBgAnCEXH8hAOTpI
   Oxd3dcdVnFSticXTT+URmrnit0dSzQMAJa14El0bgj+7NrFbHozQY33ZX
   nFsGWSrwp2Rlj7Bl8ucxkuLtSWX6FjxhyC1bEmC/oKDammAWaF2hpzQWX
   g==;
X-CSE-ConnectionGUID: oWYQi6OlQ6Syhxv7xNQ5JQ==
X-CSE-MsgGUID: A62yczSOT/iLBjSgLNO8Ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="37636180"
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="37636180"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 18:04:04 -0800
X-CSE-ConnectionGUID: M2MIie3GS6u0zpwQqE+zdg==
X-CSE-MsgGUID: 5+RrIZIVT6OJKwnOXPlEPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110027407"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2025 18:04:03 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 17 Jan 2025 18:04:02 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 17 Jan 2025 18:04:02 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 17 Jan 2025 18:04:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vPQQ4q6POj2GkRdswO6+fQbzLMjDbNdr9MMQnFazayVgfX8n0+dXQmlGQ7ZcX1hPrmcOYWd4IBHszuoakkrNlBZ4vNY9vwW6tbFvSzHtNrjeq5OFr9xOBFAjvAI4ow1+kTNhh2HVknES/Bi+NxAGXblCU12QNXNEa51UK5MG00rt9GaBpFHftk7Vx9tJkBX0Xr2VtzPznZlr3MdYmcZt8wbcDrhGmWnHT58Voo6B/PxRMYvKX/0jiYtQKn2e5HJpobssP25Odg1TOTLDI9OIMx6Z8A5EtfMZzAB+2SgXhwm7H1QNh8Ja3W/ziFbUC0ou5dfRA9u3eTrSvrOJ5syTTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WP0VsM7TaB28lSksWhiW2OIZ40CpaZjLKTmwzfLsTA=;
 b=JCxKQYdQcL7hymoecdz1UdTAqJspOiyMeflzeKJW+RC3JUwq3i//hyp15tNEDYR3f2l68xpL38GrT4G7GKJ2c9UnzuEAOgVP0d2e6V1z0r2Xnd6iVSB8wY2CR6sYf2AX4tYFwvIb5XXUSkvjADYEgC6U211rEcDA6wZWpxwXxNgE67KhvRufapAuptizKOUACNi0FvtfpG7H9mEAy6/i7RbQ5vZkkNDpvjw4L5bM07yXIaEWC37seqJG09caqH5RszoKopQpj0aCcH1mocJberKbTTTIQKroXrlyApcYsq3qRr0Slv2wQuwBGhMk2AdVITW9S6CI7v7uh46ZSkhz5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6727.namprd11.prod.outlook.com (2603:10b6:806:265::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Sat, 18 Jan
 2025 02:03:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8356.014; Sat, 18 Jan 2025
 02:03:59 +0000
Date: Fri, 17 Jan 2025 18:03:56 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v9 10/27] resource: harden resource_contains
Message-ID: <678b0c0ca40ca_20fa29484@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-11-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241230214445.27602-11-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: MW4P223CA0008.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: 2902084b-9b96-4a1f-f358-08dd37645f63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4ZDCZye+SRRR/oXfY+3Kbp9cvcWA2sI9BH0v6T4uXIYY0/BfMl4S0THRf8QL?=
 =?us-ascii?Q?zxj75uyLeevc2zcV0I0E4Wn0tMPa/8U0s77hoHCOW7EI82Pe8lBSe3LYXo9S?=
 =?us-ascii?Q?NFKtK+oA09LTgYnpQouxNZV5lbAdGd2KmOIt59z3uLD5F0eUb7zWJZfUXXL4?=
 =?us-ascii?Q?VytqLpKIY29+pbHTKvUIoP+EOEI59QkEdQnCG9cu34VE2hDUD05ft/RmX3zG?=
 =?us-ascii?Q?gbWmG4pOGmAGy00nn8zI1ZJQBz3xJPRC9bdC9joiCzf2XDJPZkVThtHfZFsz?=
 =?us-ascii?Q?pv6rBPEA03ueZrjLVv9OT1zjt2Nb3iH8LCfkidZ21sqjraiou17+aCqPN/Ol?=
 =?us-ascii?Q?Ty/9x6I/FGXjVexJERbdL+qzZWq9hqpvQnJGuYWSv2XQL/lsWVvhmqqloeKT?=
 =?us-ascii?Q?3Y9s692aOXRfdu62Mym8ErFQNzqGOI823WT/jjydpMugJeWMZTBxozueXkg5?=
 =?us-ascii?Q?p5YhG+iMkaoW6aQUZ4FsecgFaEGpSnqOrtuVbeUQNKPpj43WpV+XwbFqGb4h?=
 =?us-ascii?Q?Vt4PmzzyUf33RxxJornXsX/TF8eEYAVyk+3dW/0Y3ojyzQxbu40XLvoHo8QF?=
 =?us-ascii?Q?xMsGq2lZj0e55hUo4X/6shTImEi98066rYeZLahTOyyE2WBPoJMBp5OhpDkA?=
 =?us-ascii?Q?lR9Yt+JNIQJBGjHNeEGv/ke8XpRECETNRyhb960Gz+IucPWcdxQXr1+0G4VE?=
 =?us-ascii?Q?vZFxZYeZtZZRqKZaVnD/uiiKryv4sE/O/a27VDp/3xrTEySdLjSzHI0vzW3O?=
 =?us-ascii?Q?n4o7dfqFBDLAPCqdBYDISVSRlLyeH97ENfBKZxUWH4g1VZel+QXj68t9C811?=
 =?us-ascii?Q?ObITz1AplM+F7YZwDcAKjDDVgNOBgDb0ULn5GOXOPOnmZxdHl4kM/UOSzFma?=
 =?us-ascii?Q?nODc8zssyzC0qjDkdY0GUGujahHezZgzSQU9rUBAm/pD2O8yYKkHJfc4boyg?=
 =?us-ascii?Q?4i8tvA72sYAYLlw9TcXrIU0Bj9oCjYZFECSjkg8ZYIYDHBWXsvbIaxkVe0y4?=
 =?us-ascii?Q?LEalsmg5SiwmyZiy7bRUlSkgeXKQAOtDK/JbyzzFUpiPHBeiqm52wcJB1Au4?=
 =?us-ascii?Q?bAD981qK23U3W3VqmhQSpj+Qv6bE4Lt2fWuqJI7OLmsdfsu0ATFrO3j+jn7q?=
 =?us-ascii?Q?QOPhmS1eNTY/xtYwxtoC5YZ1q35TjLAq2ZqbM/6NIMgI1Ely5RrcA6Q0DPNQ?=
 =?us-ascii?Q?n6yYw7C8RtMUU80HnEwHLT3uQ9whFTgDknatIM5TawkPUzK8ylhQoLlhIH04?=
 =?us-ascii?Q?SBTGwyRL2hOCICMt3FxTG6YvElRaP2rNO0w3BmcgdvtYpMhrtvRbf5wFFarN?=
 =?us-ascii?Q?Nb9piAxJnYUxLLXCEY1ZfGt+8Sj/+9qOQTs7XGgCfz0mnUZUV1JVvfD2Q37r?=
 =?us-ascii?Q?mkZqqm/f2mGVc/BDvkiPpdVz/cXuf5pus/7Og5M+iBt7/Ueknbw7keN8YjeM?=
 =?us-ascii?Q?B4hJjr5XPdo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+AOl8WJJB1FRkayhZwer0kalORAFKdqLyiKOK7cw0Kf/3OdnDduMtvTjea5H?=
 =?us-ascii?Q?24Nw1kEVFcRx5O98LmPnrchqA6tGEy65nddnb5PVtE5KHcTQkNL5PVXvc/Qq?=
 =?us-ascii?Q?sMh9zf0KsphQy21aBK+gs4f2h7ubMPWa59CKoLFygabirRENB4aVnHFQTY7t?=
 =?us-ascii?Q?nmADj0prX7Sucgd1Y/n1klAb4GCk/lM2K80LMaqaF9bw3rVD03qJ9fdXi+iN?=
 =?us-ascii?Q?SdhKs4QAelPMBQYkB6RvGT2SYc/Ln5yXrUFYwjZluEHhdZUUwbxq7fGhEpVS?=
 =?us-ascii?Q?R1o4+jxwwDL/aNRoTeUoYYcj4CoqRquIBbm2hpxiMN01T2vEZsh3qWUA7EPo?=
 =?us-ascii?Q?WQlYooOZkaeqhdhDV1gxjHS6DHK1W4A/VNJzBJYOME8fbz/8bjtSH9fSzxHK?=
 =?us-ascii?Q?+XEjj/+Vqko9VRPTw3Y7VTQ7RmQKjl8BL3apzpjSwx4061/By9Xhijtleqaz?=
 =?us-ascii?Q?UTswytZJwYUUy3/OsIraLKry4qXZp4zK6oIVPbQLUQi3zz1en3+beU0b28Jg?=
 =?us-ascii?Q?KKjaDVqJz6zlXu+vrjRQZWDMjQjAylQrqu/CuzfUZvCuxobpexzGk8duH7j1?=
 =?us-ascii?Q?V3RoFmt01aHNcfvrcRmeL+fZEtfO+mHIkPzClthkr6rBa+yjDN5nk8bc4wV4?=
 =?us-ascii?Q?hKKbnQ1O3lZ11Gdu0ZX08L7+EBgl3HrZV4Z60GLCkwu/tZbE9HFFP+Vwdtyr?=
 =?us-ascii?Q?UU+fUTLIJOeCgOP2tbsUra902Pj54uNfIuXjqFM/IYyj1aeuC7doLdlpbU9+?=
 =?us-ascii?Q?nNPeTaZNKMaRYrGZfNISNZnPDac8CYvDhbInMOwOcRCSMOzYOtkZmKLHyX5I?=
 =?us-ascii?Q?DrobGp3T+WHSRvFF9CU0PWbsEos3k8bmp3u6Psn4VXeXdJHaPEd6657119Vo?=
 =?us-ascii?Q?OJN90axI4MkTIzU1bcP8HT1lkSdVTn6/qNzRvIUn2Qy+lWm96fjW5i1scL9C?=
 =?us-ascii?Q?AoAu5RkRuJ+VnbDhBOEYxzrUrxaCCjbH0rP28gosJmHVizCN+WqEqDZ/0PVg?=
 =?us-ascii?Q?zR/h4Fr385IId+BdmxyMhnhS/x9TWkuNXcJu2FzXN+MQ0iJttOD/6u5u0/g1?=
 =?us-ascii?Q?R+XSVuToVY16Yd413Hbngu1hadKNNYupVxTAHsMA16NcYnDK45+9He99f/GA?=
 =?us-ascii?Q?dhb3x6+1OYD63kQdtUYXyYtX/W4TlecDl4kgBD1Jbpl73SKQLwuCn9Hc1z1e?=
 =?us-ascii?Q?hu844XvUZXPn2I+ONTBHQqftrHa5HXEFowKp9GZa40zBWVZF8+3UWPD+6Tp9?=
 =?us-ascii?Q?GcOsiIUhrJowL0hxBlS0MOzUMVPwynLtEuLs1H9fEfkOXePt2q2t1+tEiTPl?=
 =?us-ascii?Q?VAd1335Ph4N4YTmIENDAXZ/zfe+wrcMIf77r7nyWc5yTvUzSQO0mC/a6x+0R?=
 =?us-ascii?Q?yl2q3N8dUk8f2OeceYAUIXiEgZtbdUyBNT2jCG7iLHAZ+V6POp9Ge6n5KdTW?=
 =?us-ascii?Q?QkRMtpkl08T9/BIkTNyVbUvhRoy/jQUVU/qkhW32MgWpMj3Ua2jdC9fwxchV?=
 =?us-ascii?Q?BaLGajJS3vR1NMduPeQFpdsS0U9y9Ix0MTo7YiQIUpnr5cq6CCjKAGrFaNJP?=
 =?us-ascii?Q?p/aMLAux92JRUPpwIGLuvy2tJmtepkKzQ9AlmON3vIZDpQS8RqJrkLY+LlpI?=
 =?us-ascii?Q?iw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2902084b-9b96-4a1f-f358-08dd37645f63
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2025 02:03:59.4826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NyBWUXxDl82jId3PdFJvWHI4cDg7ggP/28a9N3tdFB2sHYjI8nLTO6+I5tHHulDrtwW13itc9fr5PPylJoJBK6+NmTICphyxmktx1bLwB+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6727
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> While resource_contains checks for IORESOURCE_UNSET flag for the
> resources given, if r1 was initialized with 0 size, the function
> returns a false positive. This is so because resource start and
> end fields are unsigned with end initialised to size - 1 by current
> resource macros.
> 
> Make the function to check for the resource size for both resources
> since r2 with size 0 should not be considered as valid for the function
> purpose.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Suggested-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  include/linux/ioport.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 5385349f0b8a..7ba31a222536 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -296,6 +296,8 @@ static inline unsigned long resource_ext_type(const struct resource *res)
>  /* True iff r1 completely contains r2 */
>  static inline bool resource_contains(const struct resource *r1, const struct resource *r2)
>  {
> +	if (!resource_size(r1) || !resource_size(r2))
> +		return false;

I just worry that some code paths expect the opposite, that it is ok to
pass zero size resources and get a true result.

Did you audit existing callers?

