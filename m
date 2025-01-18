Return-Path: <netdev+bounces-159529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E16A15B25
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 04:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B79951688D9
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 03:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFC025A649;
	Sat, 18 Jan 2025 03:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fUzDT9Z8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2639610F2;
	Sat, 18 Jan 2025 03:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737169366; cv=fail; b=XD0N91SDTw+2paznkHwZbSmaJg9UBEbejICNeEZIcwo6eKWPUWcMd5plO3Na9ZnWlgEffxtfV5f3EomRQ9HkleEKmJibsfyDwqYkz6htrBJ0r7G5BlO35iG77bPod0V7JoW81m1XUaoVmc6X7lfHe0WYo3sUlKRbBA9WyG0hOj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737169366; c=relaxed/simple;
	bh=dw6O5wJWnnbTpg3RjO4p83RW1+nrlW9SmcD260LnPnk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XYEsOWkFZaG+ySMQ1GyoDsaOwGwAM1f7TE7zrUJSPMhlw/G0hwKw+JQ38qqU8GYRElWbQ1VINxSR4MNlWc7XPzJu4HKOnZW6At65cLkecfghMprLk3TvgsbODE0xj57Cq90mMzOEnX0pa+ugXTAzs9m1/ytJjJZOpO6n4fe9UwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fUzDT9Z8; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737169365; x=1768705365;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=dw6O5wJWnnbTpg3RjO4p83RW1+nrlW9SmcD260LnPnk=;
  b=fUzDT9Z8gEk1+zoYn36z/zZ860kBU/QWHe0Pmobwi3cNWrX51ZutzhtY
   p6g1Iy6itVR79fTYKOvy4q1VkKTx2Ei9Ldt770J4K43hCioj5JJ3F98A4
   JYVmgdTZsrSCKOdWUYMY91Oo5uLs8zbJHUzkPte836RYBjCYM14wPtv3I
   FAIog4Nmg85FkHbQqr3x2l/evdkq+x6TD3vuW4meOVGhClaxGhQAtuglT
   xl+ytlQ30FIJzSgd85bTIqqU0Ui99XcSq7o2sjZ7ea+diVK7o0q6INx+U
   rAYVli+6NkpLavtzpZ/pagV4MPK7UJgSroLmHPG0wq4uGRtJTVr372EKy
   Q==;
X-CSE-ConnectionGUID: UXvqFDsLTVaqdzWlMODZkw==
X-CSE-MsgGUID: rGL4GmNhSgCHaJQhG3+jlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="37730436"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="37730436"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 19:02:44 -0800
X-CSE-ConnectionGUID: 2fWOuJ6GQLy5cKQUkhD3Og==
X-CSE-MsgGUID: zeg5KBGEQza8+wI2sQJ6GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,214,1732608000"; 
   d="scan'208";a="110959938"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2025 19:02:42 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 17 Jan 2025 19:02:37 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 17 Jan 2025 19:02:37 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 17 Jan 2025 19:02:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uWecoMgPLMx9jcf+31efuBkeaZ3MHfrfon4ic3vqTTBNMJ939VQwVOAzlyVpFF7iuLHV+pV9JU3rGbh2+7/JPcRPR0ivlZ9/+DmAH2j9LKRGTQbth0WE/7F74qRu5d6LN50Jur6sFF9uI9rV9THij9/ksxM7j44EmNxpgDEMbSFVnSZDSY0Pl9q5SVtDHs1Cx5FfaVR2Kt5H60E8o2xMgIDq8QLQVO93tF6ujVig2yAOVPNSc9Pw0mw79scy0aX3jHHUVBBIefh1cbvTYLScXrA1vRULaTcxBZQnFNlrWt9XFM1z3r8fCu3+WNJvLfmCXUGTNKKPAJ6xkTQjGnX5yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0wlcPynAb/gVUBFScpbtzyBC+uLjrhvJxSp0qJkmac=;
 b=rbnKLaD4r6UvyQAN/GUE27IQ7GwjiGBr4NVxILLYOdXXBMxHK3oTS5hT/hQ5Oinm7vZVt53Lxpbwgums+q8wsvyIDwAFNdzrMzATaKqulIaurVK1NWDvdXn9nXkxeKz8aq/5ilD0lG8j8943pz7UrMLOVqF3ppQV1nJx0mDhOmnjqksXK++V8n07cgTmkl/tZ31T6yEACDstjN9BwNoOEYFGQ2l6HiCQppzaV1m0+UHQH8+Ge7pveyR0USzkkNF8jG9IgJ37VJdn7cHomzPIbFPVrNAWCFVghP+y/ma2Fg+Y9gYb/fmDeil78FTV9jCoOlw1wEff7+efGEHQbgbaLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN0PR11MB6302.namprd11.prod.outlook.com (2603:10b6:208:3c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Sat, 18 Jan
 2025 03:02:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8356.014; Sat, 18 Jan 2025
 03:02:24 +0000
Date: Fri, 17 Jan 2025 19:02:21 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v9 15/27] cxl: define a driver interface for HPA free
 space enumeration
Message-ID: <678b19bdc3d8d_20fa2944e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-16-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241230214445.27602-16-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: MW4PR03CA0241.namprd03.prod.outlook.com
 (2603:10b6:303:b4::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN0PR11MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: 64344dc8-0053-416b-8b57-08dd376c8866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?eukPc5dLobPyhp7KVnw5AHXen7A3qjuX4JeIHk+xX1x63+hyzPnic6ft2q?=
 =?iso-8859-1?Q?FKbgSCmLbzpYzCN4wsYfjmqzLgpoUK+mq5P1TFlWRgaJ3McbSmd7UWwzPK?=
 =?iso-8859-1?Q?I1L0+g24BhLZ0zwV5tHUZz1Eqj+RX3Gu78MHtDMZijkniQ0iYdCTGzwLiB?=
 =?iso-8859-1?Q?UasBEYNELR2JtSsIIFmJnjWP17NIJ45fxUx1CwXOP+NaXBEJu/qDPGg0kx?=
 =?iso-8859-1?Q?+GyD9frpYOBYSVBIt+OYt5kB5g6JOAp0+4QorsMyIa3nDRX8BoYjFQ2V8R?=
 =?iso-8859-1?Q?eXxgxlcQ84ftT1Mg2TGm8I3/ygTlCzCpYxMTWPNo8JdwVx8qYHz5Kz/8UF?=
 =?iso-8859-1?Q?QyZpwvgiQzMmT2Aviumw889ojZZRVLRUY2orFqEH9CfCGpqSG6ph8zCgx4?=
 =?iso-8859-1?Q?01YQZvnc8NgkVa3BpPqXAamA+Ov+IuMb50tDZHVrAvnfzdGGapNhvxY3Sh?=
 =?iso-8859-1?Q?eOItsFnIIVfORj3zDjRovSVIH5wM2GsqrhkHaBaI/GhHKFG2Zivw3lSrPi?=
 =?iso-8859-1?Q?iFHmuDG2J19k1coOd4DdbVZlB19a0+7g43Jwk96kqXRSFxc/m+BtOboVAX?=
 =?iso-8859-1?Q?+mmOQiSzenvMuRpsV/r8GJCzx4tyZPxyiupIT6qFYVnHib8BoiWndeFJcV?=
 =?iso-8859-1?Q?GZ3RR9WvRJJhZ5cQDX/qV+nerlSVOI9XDHe3hkjTGEIbMzzhPdJC0plZ99?=
 =?iso-8859-1?Q?TcizvyCya4R/7JCKHLvzFdH1JQTy3P0He/zkm/0eL0FkGdNTZ84H/9CzqR?=
 =?iso-8859-1?Q?Vd8nrA/yDAKbBxw7yuM4QLKDYJR51AJxA/V1uB7OTwD3CkmB6K/rHMOQcM?=
 =?iso-8859-1?Q?2h51z6RTrfnzPZ9sb3dKguTKyrW4dv9z1867toO5nJCskgCL6JYrcqA0JS?=
 =?iso-8859-1?Q?BpCGsEd39hkM8iaX2Gd2nMY4B0dWrWehNC8NvVVPOHf301859eUOVrDAAP?=
 =?iso-8859-1?Q?e+YP/t0LuUzIqKuMjsLVZxRMESxTp4uYnue8O2IL90VKQjY3Dx/+5Lr8w/?=
 =?iso-8859-1?Q?qLjAyuxjf8d20a0xAt3Cbt/0cAi6m+E70RTsXpbQVStldw7QZ4Nd0LKz5D?=
 =?iso-8859-1?Q?V7w+W/AbqdRu+xHymvQjX8XZqZTQvwa0C2Zu5PWV02gA98YMHECIZJzPYg?=
 =?iso-8859-1?Q?DFSOnE+pOsCc5/hrwY5tRqpaAxyOi4F2a9KpuzUc+06/bZGjuouixhHR9t?=
 =?iso-8859-1?Q?euFOHQ7zFjjWlgREiAB4ULczmPFRNhunxSliePwRpAkhrLPqSNKfal2ZNG?=
 =?iso-8859-1?Q?S/GaNeJw38XGrV5z5kkdkiCwG6mPZd2ud+p6wZNZ4EDEax/jQu6mKXqd4p?=
 =?iso-8859-1?Q?/LubRfAEg+Wi8Csw+oUYPFrdoIe2QXkW/F2DtdY8QfnLzJ3TgSA+uBbkaP?=
 =?iso-8859-1?Q?Rtys5pWBIRQ+yqU2UafFRDKe1nKAaUEQREX7hPDfhXKIVRUzYp7d2T246H?=
 =?iso-8859-1?Q?qA2k69SuvrhC4+sa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?wEyQXFkXtB+Xmypy46RwyctmagSSuzp9GgH35WCmEdljR6b2ghjFZSOmBq?=
 =?iso-8859-1?Q?wyGRkvdYZ0w90AmNKODuybbZXvYPj+rcxa3I+e/wFJL9QlDK96nIYtIZ0f?=
 =?iso-8859-1?Q?2ZSGdZXcnVN9tLM4CB0RQZczOGrkMLQbxoHn3VICyh9HprabNQg3uUULop?=
 =?iso-8859-1?Q?lywEjqTUK+jEgKKKor7wEf5y93Sl7toM8pUHN0RWQezronxNTodWrq9aat?=
 =?iso-8859-1?Q?2vNfequeB1ZPpUDes526F3mdaiNsOwrfDZee17qMNEXWIwkyBTWbuki7+Q?=
 =?iso-8859-1?Q?h97LP1AAN1b5fMi8rB2zMHLV4Y6Rr9WUigFbMhNcyVIfuZGkcc+AwYbdho?=
 =?iso-8859-1?Q?Z9AfemXOjpvkLjb9jkqRG1kM1rA01Up19VoVtK3uHIKqH9rCg7q3Ky+MIM?=
 =?iso-8859-1?Q?wXIcnz3CSLbqFumcA5ZySZ46E6EXpQn8bcRmMG/lP7o1hHDcKqI4r2pXED?=
 =?iso-8859-1?Q?COF+sbHfskiuVZgW4hFO9SHEVs7BoDEF2G9JEUc17+6mgqwN0Z5uTtw0fM?=
 =?iso-8859-1?Q?v7ookUq/C8esr2s9f4xcSftx9RF6HT1L/Hz7Rhd6Qf23EzC1bj3lVhp14J?=
 =?iso-8859-1?Q?ADDkBCY3THkJx+ZFGiuehH0munL4+iAmkMpyhQkxJCvOiUHl6VEBHhCzLe?=
 =?iso-8859-1?Q?ABRImofnGrOPVL4PBakBa0O5b6WViB9OgAz0zSND5iUCtg5c60le9yxb7e?=
 =?iso-8859-1?Q?98ni9g4EmaMuMPCAia0H1sDoIejeTqhPqNsARDU9bjVW6fMvaUWLJTWjdp?=
 =?iso-8859-1?Q?+DCqKF6uqBhkCIaIkhFMac8bOr13fuwAgv5P7QFO4eToo9u+XczoAb+Oad?=
 =?iso-8859-1?Q?q3DyhypuP1mmcpZUaBLQGLbbVWvbGpu0imQDm0cZaasCvn7oH+ke982FeQ?=
 =?iso-8859-1?Q?RZr1S/FT5FNhq6XVjnl8xBNWhcdrymNPNt3WXHOpi9tFODq9gVo/RWPo/y?=
 =?iso-8859-1?Q?B3W/1y7v9VVLQ/xONVwkwkXHBtlMBeNs+DbtH/9X0QGP6GC00vw3rOpGyP?=
 =?iso-8859-1?Q?oHrfQUuV7RQHjAgtqEBPK8Vn30J7ETa8Bk0vkFroyC0ot09MlwZbt9kFkf?=
 =?iso-8859-1?Q?saYOwY+jOCgA3zVs0sUvScoLJI0eSFxQOfxyjrpWGwcE1h2Cut1gHt2Q28?=
 =?iso-8859-1?Q?LyNfRGEz1gZ30dDc7FH8Wvk4ToVMrg5+GboIy2YGrYyipHt7n0T9tT5/10?=
 =?iso-8859-1?Q?lIlFsuEqvBSs9iKUtN3igmaMFDuYP0BwyxfIrY63AcczLz4iqaPBp+ENeF?=
 =?iso-8859-1?Q?mxZJtJ+l5uUeehX856xhkXdxzq0xD7mZa+o+g8PCg+Ea+RQiUxsppe5O8k?=
 =?iso-8859-1?Q?JbSOoTuHDoDIB2It2fm6GxiqR3r1N8HKEzHVvev0FydeIV0TAR1jD71gR0?=
 =?iso-8859-1?Q?5dvifdr+C9fkXL2zGrnLFF9axFB0j1B9o3o9uozQWOqZ1J9GDkAkk2YKES?=
 =?iso-8859-1?Q?cl1D6mWSoeulk18IsWKpJvWcQMMKou6as3ZK0WQA49LkPrL0g/IdY5gytU?=
 =?iso-8859-1?Q?PfxdWHeaPR8fSWLgZdlgFlJu31PNd815uJsxFsoOVuuZ6d2cK3DBu9TsYb?=
 =?iso-8859-1?Q?koLOILAu4LrZpStK90AB9YMjC2MxvevB0Ad0bHkvNfrsP3eiejGbasShqN?=
 =?iso-8859-1?Q?+byTadXXcotjDOtcuNw67M4U9uozQk3ABJ/emxTf8IliPLMc+1DL3vlA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64344dc8-0053-416b-8b57-08dd376c8866
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2025 03:02:24.2240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a7nVHGf2qROwdkYDQTmU6mPZWgTB8yXnVZRXJPmDIKFtHPCfMo6pKh5nz6sVfr+HbLGXCUvHkRb1JY/YpvYDKK7EBZ7TDWZaOVTcXiBWrYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6302
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> CXL region creation involves allocating capacity from device DPA
> (device-physical-address space) and assigning it to decode a given HPA
> (host-physical-address space). Before determining how much DPA to
> allocate the amount of available HPA must be determined. Also, not all
> HPA is created equal, some specifically targets RAM, some target PMEM,
> some is prepared for device-memory flows like HDM-D and HDM-DB, and some
> is host-only (HDM-H).
> 
> Wrap all of those concerns into an API that retrieves a root decoder
> (platform CXL window) that fits the specified constraints and the
> capacity available for a new region.
> 
> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/

What needed changing such that you could not use the patch verbatim?
Then I can focus on that, although I am also critical of code I wrote
(like the DPA layout mess).

> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>

Include Signed-off-by: whenever including Co-developed-by

> ---
>  drivers/cxl/core/region.c | 155 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |   3 +
>  include/cxl/cxl.h         |   8 ++
>  3 files changed, 166 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 967132b49832..239fe49bf6a6 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -687,6 +687,161 @@ static int free_hpa(struct cxl_region *cxlr)
>  	return 0;
>  }
>  
> +struct cxlrd_max_context {
> +	struct device *host_bridge;
> +	unsigned long flags;
> +	resource_size_t max_hpa;
> +	struct cxl_root_decoder *cxlrd;
> +};
> +
> +static int find_max_hpa(struct device *dev, void *data)
> +{
> +	struct cxlrd_max_context *ctx = data;
> +	struct cxl_switch_decoder *cxlsd;
> +	struct cxl_root_decoder *cxlrd;
> +	struct resource *res, *prev;
> +	struct cxl_decoder *cxld;
> +	resource_size_t max;
> +
> +	if (!is_root_decoder(dev))
> +		return 0;
> +
> +	cxlrd = to_cxl_root_decoder(dev);
> +	cxlsd = &cxlrd->cxlsd;
> +	cxld = &cxlsd->cxld;
> +	if ((cxld->flags & ctx->flags) != ctx->flags) {
> +		dev_dbg(dev, "%s, flags not matching: %08lx vs %08lx\n",
> +			__func__, cxld->flags, ctx->flags);
> +		return 0;
> +	}
> +
> +	/*
> +	 * The CXL specs do not forbid an accelerator being part of an
> +	 * interleaved HPA range, but it is unlikely and because it simplifies
> +	 * the code, don´t allow it.
> +	 */
> +	if (cxld->interleave_ways != 1) {
> +		dev_dbg(dev, "interleave_ways not matching\n");
> +		return 0;
> +	}

Why does the core need to carry this quirk? If an accelerator does not
want to support interleaving then just don't ask for interleaved
capacity?

> +
> +	guard(rwsem_read)(&cxl_region_rwsem);

See below...

> +	if (ctx->host_bridge != cxlsd->target[0]->dport_dev) {
> +		dev_dbg(dev, "host bridge does not match\n");
> +		return 0;
> +	}
> +
> +	/*
> +	 * Walk the root decoder resource range relying on cxl_region_rwsem to
> +	 * preclude sibling arrival/departure and find the largest free space
> +	 * gap.
> +	 */
> +	lockdep_assert_held_read(&cxl_region_rwsem);

The lock was just acquired a few lines up, no need for extra lockdep
assertion paranoia. However, I think the lock belongs outside of this
function otherwise the iterator of region is racing region creation.
However2, cxl_get_hpa_freespace() is already holding the lock!

So, I am not sure this code path has ever been tested as lockdep should
complain about the double acquisition.

> +	max = 0;
> +	res = cxlrd->res->child;
> +
> +	/* With no resource child the whole parent resource is available */
> +	if (!res)
> +		max = resource_size(cxlrd->res);
> +	else
> +		max = 0;
> +
> +	for (prev = NULL; res; prev = res, res = res->sibling) {
> +		struct resource *next = res->sibling;
> +		resource_size_t free = 0;
> +
> +		/*
> +		 * Sanity check for preventing arithmetic problems below as a
> +		 * resource with size 0 could imply using the end field below
> +		 * when set to unsigned zero - 1 or all f in hex.
> +		 */
> +		if (prev && !resource_size(prev))
> +			continue;
> +
> +		if (!prev && res->start > cxlrd->res->start) {
> +			free = res->start - cxlrd->res->start;
> +			max = max(free, max);
> +		}
> +		if (prev && res->start > prev->end + 1) {
> +			free = res->start - prev->end + 1;
> +			max = max(free, max);
> +		}
> +		if (next && res->end + 1 < next->start) {
> +			free = next->start - res->end + 1;
> +			max = max(free, max);
> +		}
> +		if (!next && res->end + 1 < cxlrd->res->end + 1) {
> +			free = cxlrd->res->end + 1 - res->end + 1;
> +			max = max(free, max);
> +		}
> +	}
> +
> +	dev_dbg(CXLRD_DEV(cxlrd), "found %pa bytes of free space\n", &max);
> +	if (max > ctx->max_hpa) {
> +		if (ctx->cxlrd)
> +			put_device(CXLRD_DEV(ctx->cxlrd));

What drove capitalizing "cxlrd_dev"?

> +		get_device(CXLRD_DEV(cxlrd));
> +		ctx->cxlrd = cxlrd;
> +		ctx->max_hpa = max;
> +		dev_dbg(CXLRD_DEV(cxlrd), "found %pa bytes of free space\n",
> +			&max);
> +	}
> +	return 0;
> +}
> +
> +/**
> + * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
> + * @cxlmd: the CXL memory device with an endpoint that is mapped by the returned
> + *	    decoder
> + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and HDM-H vs HDM-D[B]
> + * @max_avail_contig: output parameter of max contiguous bytes available in the
> + *		      returned decoder
> + *
> + * The return tuple of a 'struct cxl_root_decoder' and 'bytes available given
> + * in (@max_avail_contig))' is a point in time snapshot. If by the time the
> + * caller goes to use this root decoder's capacity the capacity is reduced then
> + * caller needs to loop and retry.
> + *
> + * The returned root decoder has an elevated reference count that needs to be
> + * put with put_device(cxlrd_dev(cxlrd)). Locking context is with
> + * cxl_{acquire,release}_endpoint(), that ensures removal of the root decoder
> + * does not race.
> + */
> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
> +					       unsigned long flags,
> +					       resource_size_t *max_avail_contig)

I don't understand the rationale throwing away the ability to search
root decoders by additional constraints.

> +{
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct cxlrd_max_context ctx = {
> +		.host_bridge = endpoint->host_bridge,
> +		.flags = flags,
> +	};
> +	struct cxl_port *root_port;
> +	struct cxl_root *root __free(put_cxl_root) = find_cxl_root(endpoint);
> +
> +	if (!is_cxl_endpoint(endpoint)) {
> +		dev_dbg(&endpoint->dev, "hpa requestor is not an endpoint\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (!root) {
> +		dev_dbg(&endpoint->dev, "endpoint can not be related to a root port\n");
> +		return ERR_PTR(-ENXIO);
> +	}
> +
> +	root_port = &root->port;
> +	down_read(&cxl_region_rwsem);
> +	device_for_each_child(&root_port->dev, &ctx, find_max_hpa);
> +	up_read(&cxl_region_rwsem);
> +
> +	if (!ctx.cxlrd)
> +		return ERR_PTR(-ENOMEM);
> +
> +	*max_avail_contig = ctx.max_hpa;
> +	return ctx.cxlrd;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_hpa_freespace, "CXL");

Lets just do EXPORT_SYMBOL_GPL() for any API that an accelerator would
use. The symbol namespace was more for warning about potential semantic
shortcuts and liberties taken by drivers/cxl/ modules talking to each
other. Anything that is exported for outside of drivers/cxl/ usage
should not take those liberties.

> +
>  static ssize_t size_store(struct device *dev, struct device_attribute *attr,
>  			  const char *buf, size_t len)
>  {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index a662b1b88408..efdd4627b774 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -785,6 +785,9 @@ static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
>  struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
>  struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
> +
> +#define CXLRD_DEV(cxlrd) (&(cxlrd)->cxlsd.cxld.dev)

...oh, it's a macro now for some reason.

> +
>  struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
>  bool is_root_decoder(struct device *dev);
>  bool is_switch_decoder(struct device *dev);
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index f7ce683465f0..4a8434a2b5da 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -6,6 +6,10 @@
>  
>  #include <linux/ioport.h>
>  
> +#define CXL_DECODER_F_RAM   BIT(0)
> +#define CXL_DECODER_F_PMEM  BIT(1)
> +#define CXL_DECODER_F_TYPE2 BIT(2)
> +
>  enum cxl_resource {
>  	CXL_RES_DPA,
>  	CXL_RES_RAM,
> @@ -50,4 +54,8 @@ int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>  void cxl_set_media_ready(struct cxl_dev_state *cxlds);
>  struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>  				       struct cxl_dev_state *cxlds);
> +struct cxl_port;
> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
> +					       unsigned long flags,
> +					       resource_size_t *max);

The name does not track for me, because nothing is acquired in this
function. It just surveys for a root decoder that meets the constraints.
It is possible that by the time the caller turns around to use that
freespace something else already grabbed it.

