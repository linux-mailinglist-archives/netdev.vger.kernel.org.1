Return-Path: <netdev+bounces-192824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7886AC14FD
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 21:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E52179421
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 19:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF05729AAE5;
	Thu, 22 May 2025 19:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M44WLE3p"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D7E1B0F19;
	Thu, 22 May 2025 19:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747943507; cv=fail; b=RkHDLaB8zmLg4ziwmdE+KmiIghvQvGyWWTAS5JbIiKVrRjDpLHZZVKfDJq9GDp62klqi0QJE6LI2tbzGaimXoSG/AUCDQHBhhTtchQ4FuQvfklFSp6ZCKgetgzUgE6LagjSQJ3W4G+DF0vJrG1ZADDrZyDVB95nI1GNWrsKrDXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747943507; c=relaxed/simple;
	bh=swUDeAhoVq1HKrOPucGINWG71UqVLofosmc1ZGAbco4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f/4Xpdbe67Q5k6XR0+37qKYSh37y2qVH0uhh/3cerRHco6hSqwd/BCmqk70na7O5jnldhGQ0QhpjxKhycgwcoC7cKnUK+MjFRUkOtmJE+l4+nQf0BBTQLRdgq0Pr+FMgFF042E8wd21HoIR2dLv9Zl1oDr5OybJBFn5mxBet9rI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M44WLE3p; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747943506; x=1779479506;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=swUDeAhoVq1HKrOPucGINWG71UqVLofosmc1ZGAbco4=;
  b=M44WLE3pq4rFFCyvuysCc4bfXZCTxPSNxAl9hSqLUNbLET2HNYYPKtkN
   HqWacwoCWN5D7bH6suSIvL8VN0NLfbYQFLkfQN4LyzUEoJI1BfjYHWYvw
   Po+FVlNSS1Ia8us0caC3VvPPcuDiEWBQ1D6nqgzqgQYXKWvJBIvrL4fCZ
   LnA6eOcrk9fBcCdSGyJC+VgxXdIExYI3O1m7muciGQKCRjV8uxiz5T/88
   3z7U53AAv/CUfIt0VlhuMrsSoH5kAnDBZ39Xsa+GKdtzNXKMrQvLWrBZ7
   EYEvnFH1xOq1F1htPOJfxYIQxYDhJTQRFtqrsrSZkbjTfoHFWmIDuRCbZ
   A==;
X-CSE-ConnectionGUID: bN4UR3uOSLGCL/reF9J9Pw==
X-CSE-MsgGUID: KyfY467lTE2+WlP/GsWx7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="60239328"
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="60239328"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 12:51:46 -0700
X-CSE-ConnectionGUID: EznYialnQ++sUh3tKxocCw==
X-CSE-MsgGUID: eH2I8bdpTI+j8uJ1GjkUUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="171730033"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 12:51:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 22 May 2025 12:51:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 22 May 2025 12:51:44 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.45)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 22 May 2025 12:51:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qyMqAjbVLH2YaBrMDGPN7sclK3uwjGpLlWeqxPtLzKVTiRAGKLHghMlLdFk5VE7lLlXKpVqSeAgz/BaubXi8uhfQJAOsCBm0FyEC4MsXPqi9tQ91W0o1LN1+DdqG/cmCsROWM9R8BfhU5/be8Q7a1p2FZAPgq9i9kq5HUgTr9Ji0yZH8XWDHvv5AhWIYdk7DpTgUz1iaPvVvpOyYFoskzdXCeMzlHEvVt/P/S6ClfejgLGd/Xu6dUTZBCZcLOyifnxhBj4NbbGd6Cf5cAVhe+HZZ7t2+EchOaMoB4b3GWKK8lakZyMirV3zf6qcVcmfk9qEvRtzSEym97jaoYE8R5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=POXhOVioLTcWnkUdRA+KPBlJcKVaUbJRTUSe/WcRLVk=;
 b=sN7M+IsroROP5MJPVNw36gC9j/N2CZytGkZ3jK9Hoe0/x3bggM9GKbUgC6u5PvjH50OzoMEAGC9khFIFY7NnT0jVv0EG9YuPmXuzGTPJJGN4FUUWcWbbhjrxGDhDnwFwBlbEdawnoBts1cR77hseHqPIds3SYQIxFEVN/g52BkjwdcOd0fQQj4lsTC9Te/Vgsub1hwxKWUR5mAmqouJHDKkr4gG6hAuM06fgm1bqvHdQE9+4GBZD9RcLuowk/Rvr98mbHPdOy7rGZswvM83PzUwIYxCz1eQT5W8azb+nCLSdF5sP/KCerrfMq6hhDMyC7s70xLKaqvPQjWlrEV8j7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB6688.namprd11.prod.outlook.com (2603:10b6:806:25b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 22 May
 2025 19:51:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 19:51:39 +0000
Date: Thu, 22 May 2025 12:51:36 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <alejandro.lucero-palau@amd.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v16 04/22] cxl: Move register/capability check to driver
Message-ID: <682f8048a40a6_3e701009c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-5-alejandro.lucero-palau@amd.com>
 <682e1a27e285e_1626e100c9@dwillia2-xfh.jf.intel.com.notmuch>
 <0636c174-4633-4018-bf52-f7f53a82f71a@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0636c174-4633-4018-bf52-f7f53a82f71a@amd.com>
X-ClientProxiedBy: BY3PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB6688:EE_
X-MS-Office365-Filtering-Correlation-Id: 12838c14-fe3a-4728-0622-08dd996a1149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EXXI+BNlit17C8Q0FRoCXaU6mCESEeBJvOj7mDSOFhWWAHGk/B/iSeerO1el?=
 =?us-ascii?Q?bOoX+XstPNUPs1v9g0pd0cKC5HJ19kZJtapGUcZ/Acw4J/9nIAsI+S9JEqCS?=
 =?us-ascii?Q?5w3bcnoYSn22EbpvyWDNLaDb1lmf+Rdqadyl+KcA35A5fIwoRZZPwoSZfqJS?=
 =?us-ascii?Q?/SDtDGruvANGCbK52oO/hhoJGTanxrHYXbnqzOlJ0Ez2s659hjI7mblK3bp1?=
 =?us-ascii?Q?xnmrj2Rns9BmiWkwySMA/0KZWluAUo+7FGM4RmA0rSU+qo0q8+sTq2+Sggqc?=
 =?us-ascii?Q?qp8qOkNOFC7gRE6W4qjPhe010+0kKIa73jyAdmn4o3bDgNJIaJ47+6W+n3pc?=
 =?us-ascii?Q?GgKcsqlrrwxDFegpVslLI1AD8X1RSpk+EnXRAculmkcmoXFThhotFwFG15yG?=
 =?us-ascii?Q?Wcq9DCtHRnYY9FpZlznyhCvASy+T2o7+BgMFucy+xMIk/+3k53zbmQ72/+Q8?=
 =?us-ascii?Q?yE6pflSF87Wd+6Rc9NvYIQ8OctOsKQmEplberT5qBfZ2LZMXtRFvhYxRXfvm?=
 =?us-ascii?Q?XvxStM53c/dKyWoL5Kfn4FnPQAhwSs8LID3wM5ysYGOWFwzjYswyQkNIVBDB?=
 =?us-ascii?Q?DCPnN4ICy4q9PSq0+fGPbdqI0S9W0KBHN7oKvxLH9ixnwOhjZp/3o8jc4/wB?=
 =?us-ascii?Q?OnBt5BW1AHcCKN49pVTOAJ0MG32rHazD/OGHiynBWYZ24UiV50Vl2RIRMgY/?=
 =?us-ascii?Q?RMmWVY7TlTwvilm2zA24+GHPXI1r5Ja07GqB741G1Vtf0KDT+1JhSAdARTZO?=
 =?us-ascii?Q?EbCa6mFYYTwISTrfz+lJbzCCuWzBdNZB5B7XkMLKYG/RmrNxPutySGMBrqE9?=
 =?us-ascii?Q?XmGppnvNsbLVQ+Qo0fXzkoH8NwND7pKHxFC2vu+5G0c7F5aPyq4WO8otdbFw?=
 =?us-ascii?Q?wKxuzCV6gO0Ouf0mTRz6p4aMf/fjHDrv8lyE9bJnb5UN6IJET8+6CkWO+rKm?=
 =?us-ascii?Q?/Jjd4r+Yev+DEf/sQ0wTP9aYsMYhIS2IaSLjHjVuQXMchMkMbuq7DlUnQxNT?=
 =?us-ascii?Q?5qt+zFpvh0G8BxzmDDQHCBpVBSlx7bbyM6ReC8byajRNxViP4i+dwUJGEDzg?=
 =?us-ascii?Q?8spPxc9ixVQ+JTaplwKWoLhzKtchV3yLlGne7lSxdR84pFzB2f3gjRw/u+1I?=
 =?us-ascii?Q?PJHf5Zm5JZLrTjCrZyrVf7ec0rQhOdkNa8UIsKUy8jtM9/49MTxsV0CTJjc3?=
 =?us-ascii?Q?jtGQCLtVlXFk41tND0p9eldgWBvFO4YEydaBxAKDavcYfj4cMCq+gIKBu/BP?=
 =?us-ascii?Q?/lf291VUxUF1WKxVNBkGqEdlf5wfZHOHvNG9fOC4pexjOrxqvRRL0BlJhQxW?=
 =?us-ascii?Q?86B14LPiBUUPpp08Gyg9WHSF0qLCvxKCia5DTB5ujL58QQmtPyPmOGLhVGoo?=
 =?us-ascii?Q?Iz7xoDOOdt2hwLWOpwJHIEYcN4s2S2UNAIKIC+TV/DY/Nps2vYS6esaMeIV7?=
 =?us-ascii?Q?YdrtSIB6rY83I/lrRtujE8tsG1C3JBWCRm2lXIfNfMrRZvNV7KMZ5g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6YVUwbhjynrw2To8EqvOqNNYe3oTP5xMbSk8O48geljXjbJqAZE4RjPZ5Atp?=
 =?us-ascii?Q?h+qaH51y25usBta30f7LFO/mf1vTctHZte6dLdQHklRrdEZq7IWhvSWc+EGA?=
 =?us-ascii?Q?beJgfLoDemfie2yHDlNH8m9pyPX6/k5/LTRBCpky4jmLUtyugy6oR58kicZJ?=
 =?us-ascii?Q?sDvdeGuAm+4qYPfFaLjFE2bXH8JjtNvp2jSgC+QJA/3oaZvW4mN/MqDPkxRL?=
 =?us-ascii?Q?RLdOF4DvuPZ64NTLzkYrJCIVjkIu9tQa57rgNfWZGng6gkaJR/PrmXTwRXo6?=
 =?us-ascii?Q?3Nq1DWZUkuUFOOIguJfwgOUywmcBZYtnk2Bn4suaFlNqxJb8YFEP+sEgRAHv?=
 =?us-ascii?Q?S3atdqUB2GjF9MNnm/DxExZG0+x/Ce8BR9KCW2IVZB0l3HXfDaC/3d0gn7w3?=
 =?us-ascii?Q?AQPSR7+p7fwfcbLuK/UiTNkUjEhO869+wIoTML14XoiNZ1vuY7zKp2WJ/APb?=
 =?us-ascii?Q?dwY1FzRxBmS2v+CBMcXcR7JUoQPakkWlWQxvrcwBmeXOA320j5bO3Hk4/2BC?=
 =?us-ascii?Q?yHb8dS34yE2X1rSKt+tUS63LJX46EvI0fr3AG4vQtFvO+LsX3xai0FKsjhvg?=
 =?us-ascii?Q?WbYWC1h/mF5Ip3sv0gJWl4knGRIisvgwZ0xI7QkTv/bk28RJM2/s6/otbhVG?=
 =?us-ascii?Q?ti4xNFXpj/W4tiLsBA/gk2Ep7mfRU8R/iaiTKlAuEn2JXmtKXKSmLAQa3kCR?=
 =?us-ascii?Q?dcP88lCWsp99dYYqpFjq/vUWnMsrw5KicHHGnCLCmpqsvVPYwx1IT36Lj9Cq?=
 =?us-ascii?Q?Z+v9NTHxmn/iEXyWBA2ThrqgJwkplnCcS0EP/vNBuMu3p64zRMeigka3oat4?=
 =?us-ascii?Q?EVxT+aZ+vrwYNtBxZyC1mapOKR+flUFDfu2ET7/82IQ55ODbT/ifZpvVZcE8?=
 =?us-ascii?Q?MfqbxqLvXbiXH3d0LIyWufr/1jm4ZwLcAS3i4144S7/eW2y8iUxwIYBv9cGz?=
 =?us-ascii?Q?nH+QBq1NDXp8sqlIDTuZfOwQZPCJw9SN+IrmXHiFwhilwPFu3tCT7SfxAVgd?=
 =?us-ascii?Q?ElFyV7l5pj991uSxcU5g276xJ/y3U5xM2yYNmlNWz+z2SgIJ6jSh0gBHcAxU?=
 =?us-ascii?Q?LhwzAmYnlfXjkEXWgmek79ZMaWR4vegnTiZi4H9ypIXvjwBPeDcRERtAc8EO?=
 =?us-ascii?Q?HpKF/wYHjPxe13Hot8u1YJ60ITb3ZhbZa4g4jSx6TnntYd7YZnpcYmc11hjT?=
 =?us-ascii?Q?soK4Od645phD5vOd+OUUgvC9CxKTaPQk7Vjhfi3paL4wloLHSizqfcBsyKq1?=
 =?us-ascii?Q?RGLxM+RvHovq1/bL9UImkfwNwMa6g6OVIhBhgqiCpfJr6r7SNPIPUQHBcxXr?=
 =?us-ascii?Q?Q0LEsAmxcnkU0dpSfbGxlYC9w06U7LhkPje0HfRdAGSuNkoXHQw4fMzhWhWA?=
 =?us-ascii?Q?9B7bE2F9CgcvEosKETcN8MFUU4lNeKRR5CMqIoJbifKhlRkIwimAn2rJsOp2?=
 =?us-ascii?Q?Hd36FdXE3W4daNsKRzi4C8+agg10nZYxd2kd6ZJYikLLbXWzgdMNLzKoqiUW?=
 =?us-ascii?Q?XabPnB8jgyHB8mPjDAZCIZBZQF5mRDJg0c0Hr6VprFnZivEcCynHHyWm/pNt?=
 =?us-ascii?Q?AFwIlRPaPdlQThKZTJ3r9SI5yxq2hzUVdk65sV/lslRQYTnPzjHF3bb7w2pr?=
 =?us-ascii?Q?Qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 12838c14-fe3a-4728-0622-08dd996a1149
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 19:51:39.3747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L4YL63kSQ9hZgK5mHwR3zhaZxlH0c38txsNuvCo2k8AspG23gWZPg6fjrAYIVZqDrjnqkldi7XNuILEQ0RMuxp6v5+nOb8YOtdyDzexRsks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6688
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
[..]
> You did not like to add a new capability field to current structs 
> because the information needed was already there in the map. I think it 
> was a fair comment, so the caps, a variable the caller gives, is set 
> during the discovery without any internal struct added.

The objection was not limited to data structure changes, it also
includes sprinkling an @caps argument throughout the stack for an
as yet to be determined benefit.

> Regarding what you suggest below, I have to disagree. This change was 
> introduced for dealing with a driver using CXL, that is a Type2 or 
> future Type1 driver. IMO, most of the innerworkings should be hidden to 
> those clients and therefore working with the map struct is far from 
> ideal, and it is not currently accessible from those drivers.

Checking a couple validity flags in a now public (in include/cxl/pci.h)
data-structure is far from ideal?

> With these new drivers the core does not know what should be there, so
> the check is delayed and left to the driver.

Correct, left to the driver to read from an existing mechanism.

> IMO, from a Type2/Type1 driver perspective, it is better to deal with
> caps expected/found than being aware of those internal CXL register
> discovery and maps.

Not if a maintainer of the CXL register discovery and maps remains
unconvinced to merge a parallel redundant mechanism to achieve the exact
same goal.

