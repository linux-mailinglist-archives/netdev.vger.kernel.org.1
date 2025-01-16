Return-Path: <netdev+bounces-158775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E12CA132FF
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 07:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53865188749B
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 06:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BF413B298;
	Thu, 16 Jan 2025 06:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fK4rMjDi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA503A94A;
	Thu, 16 Jan 2025 06:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737008235; cv=fail; b=qznLkOa8fCvQNAogYKuJQtluvL8N8MDTmQMK/7Sxb2s0pAZ21Ugr9I5SgTtfQLuy0k+xdxDqpdyq+cJ/Z4vBoL00ieqxtCyAIziMnQi5XOvK+nr7K+jZasG+WsazrpWHt6P7TxHW49ydK7xrLyvGCkWxQjUXnZf/s4d8Uss0PDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737008235; c=relaxed/simple;
	bh=2SMv3/b2ohoNu5jRU26UwfNDHarRlpqdI0R9v38fG7U=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K47jy/LslcEK+6K19xzhywoHLXSoeG96zdYVupOJIMQ1VRP2RyNfm773hd+g1BLYxbLKEoIYCgv1vHvAxJAsTzBNey2sf2uXzs/eDUIf79zrz5LYkYE6xlpUNa3veKdR4PgWqXMCPrc/8M2bW8Ftl+xfMY6aE/2q4wHqMsYMDPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fK4rMjDi; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737008233; x=1768544233;
  h=date:from:to:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=2SMv3/b2ohoNu5jRU26UwfNDHarRlpqdI0R9v38fG7U=;
  b=fK4rMjDi+eRhy0AgP3yGwEicDfEpex7/75vXp6tm3rVWMOxFgBpeCnw7
   VnPZtFyeFY6QKQ3LkMu8Ne5Bb8DSKifBNo1MRNELlP0sYORuk6vL8F8tN
   STQF814ckHfixNIOoVQNzNREf70+11vVKT+TndQRkx9Y/fdSwMjqrao+G
   8weG29TvpeXCcjv3bl2gkma+f1zh8nDwctY/qYd0gJ0YSVF/uSf7neGeC
   YBKQWHK6nNKif2ptFw20YJ0OKv/0ziYnAj5Cypp1YdkY72RbhhbLnqmaN
   jNiEkdHMa/NTVVwpM3APJuVAya0koDM3AReacB3Qyfo58lB0qpeF8Fkw8
   w==;
X-CSE-ConnectionGUID: ndcW2rxGTYazNxvQMpR5NQ==
X-CSE-MsgGUID: d+CF/aNUREyfY80aA1/ucA==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="37531443"
X-IronPort-AV: E=Sophos;i="6.13,208,1732608000"; 
   d="scan'208";a="37531443"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 22:17:11 -0800
X-CSE-ConnectionGUID: tgktKgZHTPaEciqR0HxRKA==
X-CSE-MsgGUID: QFSCR+TIRE+FvEInI8EWtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,208,1732608000"; 
   d="scan'208";a="105921339"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jan 2025 22:17:10 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 15 Jan 2025 22:17:08 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 15 Jan 2025 22:17:08 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 15 Jan 2025 22:17:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QyLTiEnBYj96qk8vDkHwwVPpP8rCLrKQq7Y4zMKI7s5obVDkbxih8voZooZH2b3I+xS4NNuHhUnJj8d1RxKoXcAW7IxZBkEjnk4cZ/LiiHK060Jft6xuXLkwMirkPD8Y3adaHeF0jRNo/y3J9clrQFOxGSJ6K9CPDN3k50IvcDoqr+QwPddJdm3xzMGqEhPYDfxAGt2PZbySEhVw5v3roTzaMn77PhpZdQ7Y5vjsWZNQklQRdEWMhEkO209EomDpOeXpSUm8RKay5gzjiYtvFoMsPzs+7a20kql1mNWVKLTy0+bQglvWJi1nKLSX5Cj4GTqncP7DMFmlMM9OSuq4uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uI1KN8l3Zw+fPmntbWeY0Am10dHujMR6j5UF67wnydc=;
 b=VPUaVKtmVLowz4+PDj6KzIZA1g7ZR3a0P63Xl4jf0PfgTU+gzj0XJVV2kBfEzqSwZgQiSc7RQNQys7rr9qekw5w9/M5D1qIABMeySsZGT36/0DgCa/bG8Z78QNKYvhdatXzYy1h1ZjN3Zn3CaHlXNqb8JJUjXnApCmYriyFbnSz3ArBPCZF7HktSoRgdCuq9BoOaWiybhIZBhIGZUeutMT8bQjQDVa24SI1gzkh5YLhxR8NmxoxTKlK5AZiR73otsRj4y3uS+xl0KuZTw7f4WhHgSdR/CvlP2CSqWfaQ2ttYPkmD6VJ5VumIiuO7fwG7F9DP37X/OGspH9/7UZqyAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB6902.namprd11.prod.outlook.com (2603:10b6:510:229::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Thu, 16 Jan
 2025 06:16:52 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 06:16:52 +0000
Date: Wed, 15 Jan 2025 22:16:49 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <alejandro.lucero-palau@amd.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
Subject: Re: [PATCH v8 01/27] cxl: add type2 device basic support
Message-ID: <6788a451b241a_20fa294f9@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-2-alejandro.lucero-palau@amd.com>
 <677dbbd46e630_2aff42944@dwillia2-xfh.jf.intel.com.notmuch>
 <677dd5ea832e6_f58f29444@dwillia2-xfh.jf.intel.com.notmuch>
 <c3812ef0-dd17-a6f5-432a-93d98aff70b7@amd.com>
 <92e3b256-b660-5074-f3aa-c8ab158fcb8b@amd.com>
 <6786eab3a124c_20f3294f4@dwillia2-xfh.jf.intel.com.notmuch>
 <7fc0b153-9eea-af2c-cd42-c66a2d4087bc@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7fc0b153-9eea-af2c-cd42-c66a2d4087bc@amd.com>
X-ClientProxiedBy: MW4PR03CA0358.namprd03.prod.outlook.com
 (2603:10b6:303:dc::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB6902:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b39efd9-3ace-4fbc-14b8-08dd35f55e49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?CzhWHl5VldWfOhtrFfrwiWnrjCYyB7x8mYXD6/sP/8ToNJACtQl2uiyHLx?=
 =?iso-8859-1?Q?94+P725CpqE3HY1Vmt6Ll6FVOQE7qcK9OlJ7DTooRIjleTpqBO1qfr2wFP?=
 =?iso-8859-1?Q?jB/Xy0zfHTngnbDKrZ+CDPpe12Akvl9gsFt7y9sOdTVL2Px+IwUPsLeJSR?=
 =?iso-8859-1?Q?BmdvIBmFfxyEaP2fbUDC+cEvV4uDuFwPltVQusewOmwK+SFrFV0Rbg0gth?=
 =?iso-8859-1?Q?QO9Mu3BeLHbr7nIEpcxlU7w60ZlNLcYT3qT/C0uKi+U3YNW1K68SjVDhZj?=
 =?iso-8859-1?Q?kfd4mnJ+WJjENG1nweCtsOVsfdZqowPqCZXEDR1s1gJXo9nfBc2P4VYVHq?=
 =?iso-8859-1?Q?3Q9dL3CYFMdoGAhvIdy36mOAyOayjUG/eZt4wDqOyODhtuZ16pvXBT8P8n?=
 =?iso-8859-1?Q?mNaNlQZGcBAQCrIi9ruHJC8Xx4sNEmTry7oPEbe7Cibl/3VUmJY0F2Bnmt?=
 =?iso-8859-1?Q?yYnAl5uknnk+CRoZnFleSKWemOsNi02GEyYCDn3jJIKv4pTOUZfKqwWz4n?=
 =?iso-8859-1?Q?yWaEGvKXoHSAw6qMzVAyTnFqkrT+9yVCoA2lTUDvEvdUVE7o9cUsQEajEN?=
 =?iso-8859-1?Q?elMrqrSPSN0XRojoaSCDFGepSL41D3JLCEOWOGHWTo5aDK4qngZV/dLzRq?=
 =?iso-8859-1?Q?PmygOJWfpZwspoCBYFWMaZeRolai2f/3bL4B5XK1XCB0/XSi611xTHuWVm?=
 =?iso-8859-1?Q?9JhFFG2TKmGekiHzVdlCqaqDpxE53fFwIOPp/2/KWAIKfXbbwIfl8ZiD9V?=
 =?iso-8859-1?Q?g3wsquU1UhwvTGJJB+zHizm3tUTU+4w5nfofkzqKkWfvpFRKHxi3wflEb+?=
 =?iso-8859-1?Q?4dXVSm4HrPudHhmStkCI4Q8pIbrNX8HsKfX+SmdtGXSDKJ/DfPeoc9DLto?=
 =?iso-8859-1?Q?2XQvGLinil/kaf4tHvTrg+/jBoKGPK0CzldyGSWTTAVESC+ivdL12mVR75?=
 =?iso-8859-1?Q?2rdbN4xxWbZQ38G44eju1C3LT2HJPocVAjyCBQkW/f3iaOBe5XJVOgaYBM?=
 =?iso-8859-1?Q?j0lDPDOiHqfUZdVsVeylQDuWfuyn6z+HUTfVqAviJQA37HzFYb4UUvr3cN?=
 =?iso-8859-1?Q?AhBo4vj7s9Xog0dJY5rACCoV4ymFjxwvVspoEQWmINq3LZCtCJENZ39bR+?=
 =?iso-8859-1?Q?KzeUyNvi0RwAnlQitL1kW5cAKdARbnMmNu3eCZymuf/uG889fRfXT2zsAS?=
 =?iso-8859-1?Q?DDLUVrnq4xcit+K6/153tIKqh3VQsth0NNchN2/Np8+rU2U906TZmnz0PS?=
 =?iso-8859-1?Q?Miav1Mx304U9o7cc2AQs8ppMdH4sSzrHioPgsqSto40IMXiHalWZn3p2KM?=
 =?iso-8859-1?Q?FMD8+7zk6KVK0N/OJ6R333BlxkcUg49Zsh5cWPwwb6LxromzSk83xCZ8Fa?=
 =?iso-8859-1?Q?aEgoVZIcMM8mi/QcE2WhNZv042QI9YF93CGNhgi5qJux6NprgFFDGMVO24?=
 =?iso-8859-1?Q?zMPc0kOM141yFgyKRGNgZ9LWos/v21IePy0JAIpGpqv1qN+6IRp2va8R1A?=
 =?iso-8859-1?Q?0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?n0u9O3VZYZS/NzDxWd0G2CT/Vu93ADfG5Zfpju3lbLVznpsU47RAXkSZZ8?=
 =?iso-8859-1?Q?7gnI8JzDvAaS2FOVQ7ExBNIGQx8viC6WYgQdL92NS3W2xqsK1VbLnwBOjB?=
 =?iso-8859-1?Q?g8ovBcBULou6Yt7mCZDpX/FUAoRG0w25bScoeUNLIkQ/Eynwm1jzQtfY8U?=
 =?iso-8859-1?Q?8qcquJdKKHuhRvLr3r1Obed7WmHBu+b3z2KMgd1RPVvyd36PFlTng7QA5C?=
 =?iso-8859-1?Q?NowoCBHGuqceWSZCC+ciBhe9I6E+6RHCU3Z9kpzz8vhC2J+rFKPJBa2VV9?=
 =?iso-8859-1?Q?5dPEBhS+UWn5566R0U68wRMqdzjCPPWwdw+qsmOFIohSc63tG0r2XvtHlS?=
 =?iso-8859-1?Q?9WrGEH0c3fDoHgfv8Kv5xushJhERq5/pGK1JiuCs6ac7Z7+IkTR9G6dkOb?=
 =?iso-8859-1?Q?nIzjDVy7yW9Bp3BXUtNXTs4NiWNoIvN3X0t9dNJY52g8dr1iwVMoyPqeOm?=
 =?iso-8859-1?Q?f1V5ji6pvAM2HEwXGkB/FoVQAKpBZaA3bWWvCJFxzVx5PPCNM+dzejNAEf?=
 =?iso-8859-1?Q?WGdBr50fDNHoECxRSHj2UzMfdLK/89mzjsDp6fwFBzCjQchYmc/DAcJuSH?=
 =?iso-8859-1?Q?6wpPrEQyI8Y7KyU2EWxyzKUhZWd89NjSIGMkTPW4ngmi2AdTJem0EHOJeu?=
 =?iso-8859-1?Q?XJEh+CwNXwpWS8il8CSmnta/HWbmv8US4PieyedrshB9vprQGEV+I0skyF?=
 =?iso-8859-1?Q?yIPOVMyuxWYG8e3pvjE8DUr/PV6iJ8wTKM/bNL7rcGpXaMRx882my3d+G4?=
 =?iso-8859-1?Q?eDIE6aNuqbaZTwgYMpLToy0F1bT7GuuzdWWDaTfQGSFv8npQqtnh6oyy+w?=
 =?iso-8859-1?Q?RTyxB/zszYF7zU2UJa4oRG4VosxZZNgArUqjM0sfdjk2wdo4mRF/TUFcef?=
 =?iso-8859-1?Q?BbWujWI/43GgWFMPBtg4Y2IcWXybWEZH46tDIKff7Gx72A2Qn3QvRjWhZR?=
 =?iso-8859-1?Q?l8Me18lZQ70u5fTHeJcEBHHsZnAuJzF+yrBgB1t5ZWFyWmAz/swyEWg1Zr?=
 =?iso-8859-1?Q?nDUmhS8mT1yrUW1Ybad6aRlLunRcec9BF/eChT/bGdCeyNpEFRcH9T9KHh?=
 =?iso-8859-1?Q?2265x/ZRmnjIcdnjP6KiRfY97G5g8om7XjRqRIG+rbd2b77cI2HJmMyXxz?=
 =?iso-8859-1?Q?x7aYw1w7qHqZyKrYVbNZSPfhjrnXib62U72O6f8/FEonxA4KwDp77CYvug?=
 =?iso-8859-1?Q?5X2VwWX5PeIjCnpw2TjfbqezbZbgQoP6uKnv8LZmFq9EmOgP6Pd9CJIYQb?=
 =?iso-8859-1?Q?7y6KHl0xWEBaJYeXkZbxKZauGq4eJwZLZKegciYwkR8x/FsMPHSoZ3fZ3o?=
 =?iso-8859-1?Q?dIbZqdmH/fDxov19jjzM5oJFhhumqnSePpYSJvHK2HTvycDSdnhOianx4x?=
 =?iso-8859-1?Q?4hbaiVV2ds0a3cIcWlliZMuWAZokDEkb2fzpKPG7ZCvOxSkQjxfwsTL7vF?=
 =?iso-8859-1?Q?2CW9Xys0HPMH0HpAg10T1W+CJHGGubxypCsqlp5NFD/iwgLq/rciz7pXg3?=
 =?iso-8859-1?Q?berkgm3nz5gmxzFLedALjAxJtZ5nH/viYOQMZAbhz7xcTgk6HRlHVYD96Q?=
 =?iso-8859-1?Q?P2BLBYMw0SKd38UzVE/TA8WJP1oSTcgxbyGzaK4iDmlBz8VVtL+iXg9uCp?=
 =?iso-8859-1?Q?7KI2TqnN9DY7T9WEEW9WpykJnsOgsrxHWvsSmoI8Mc1WypmcUVise+Iw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b39efd9-3ace-4fbc-14b8-08dd35f55e49
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 06:16:52.3325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ONDtYCx1IJ26U8DN0A1w2AdCcjEpKlSUFRLxuTeCZ16j0/2tX0fVvwAZ2zAUUNn7hKoiElWKSG+in0abS0dW7O2DmvsEY5tNMLWxUKuEAYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6902
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
[..]
> >> I could add a function for accel drivers doing the allocation as with
> >> current v9 code, and then using your changes for having common code.
> > Let me go look at what you have there, but the design principle of the
> > CXL core is a library and enabling (but not requiring) users to have a container_of()
> > relationship between the core context and their local context feels the
> > most maintainable at this point.
> >
> >> Also, I completely agree with merging the serial and dvsec
> >> initializations through arguments to cxl_dev_state_init, but we need the
> >> cxl_set_resource function for accel drivers. The current code for adding
> >> resources with memdev is relying on mbox commands, and although we could
> >> change that code for supporting accel drivers without an mbox, I would
> >> say the function/code added is simple enough for not requiring that
> >> effort. Note my goal is for an accel device without an mbox, but we will
> >> see devices with one in the future, so I bet for leaving any change
> >> there to that moment.
> > ...but the way it was adding those resources was just wrong. This also
> > collides with some of the changes proposed for DCD partition management.
> > I needs a rethink in terms of a data structure and API to describe the
> > DPA address map of a CXL.mem capable device to the core and the core
> > should not be hard-coding a memory-expander-class device definition to
> > that layout.
> 
> I think you say is wrong because you did not look at patch 8 where the 
> resources are requested based on the parent resource (dpa).

Patch 8 does not make things better. It leaves in place the confusion of
cxl_set_resource() which blindly overrides, without locks, the values of
the DPA resource tree. It further perpetuates this "enum
cxl_resource_type" proposal which I think is an API mistake given we
already have "enum cxl_decoder_mode" complication relative to new
partition types being added by DCD. The usage of release_resource() is
problematic because that deletes child resources, and static DPA
resources do not need to be released when ->dpa_res is also being
destroyed.

Much of this stems from the fact that cxl_pci and the cxl_core have been
too cozy to date with assumptions like "cxl_mem_create_range_info() can
be lockless because it is easy to see that the only user does the right
thing".

In fact part of the motivation for the 'EXPORT_SYMBOL_NS_GPL(..., "CXL")'
symbol namespace was to flag potential consumers outside
of cxl_pci to consider that they do not know the cxl_core internal
rules.

For accelerators, which may be spread across many drivers in the kernel,
clearer semantics and API safety are needed. I.e. with accelerator
drivers are entering an era where the cxl_core exported APIs can no
longer assume a known quantity cxl_pci consumer. It needs to be a
responsible library that limits API misuse.

> After seeing Ira's DCD patchset regarding the resources allocation 
> changes, and your comment there, I think I know that you have in mind. 
> But for Type2 the way resources information is obtained changes, at 
> least for the case of one without mailbox. In our case we are hardcoding 
> the resource definitions, although in the future (and likely other 
> drivers) we will use an internal/firmware path for obtaining the 
> information. So we have two cases:
> 
> 
> 1) accel driver with mailbox: an additional API function should allow 
> such accel driver to obtain the info or trigger the resource allocation 
> based on that command.
> 
> 2) accel driver without mailbox: a function for allocating the resources 
> based on hardcoded or driver-dependent dynamically-obtained data.

Lets just make those cases and the memory expander cases all the same.

The DPA resource map is always constructed and passed in explicitly, not
a side effect of other operations. Whether it came from a mailbox, or
was statically known by the driver ahead of time, the cxl_core should
not care.

> The current patchset is supporting the second one, and with the linked 
> use case, the first one should be delayed until some accel driver 
> requires it.
> 
> 
> I can adapt the current API for using the resource array exposed by 
> DCD's patches, and use  add_dpa_res function instead of current patchset 
> code.

The DCD code is also suffering from the explicit ->ram_res ->pmem_res
attributes of cxl_dev_state. That needs to cleaned up for both this
type-2 series and the DCD series to build on top.

> > I am imagining something similar to the way that resource range
> > resources are transmitted to platform device registration.
> 
> 
> I guess you mean to have  static/dynamic resource array with __init flag 
> for freeing the data after initialization, a CXL core function for 
> processing the array and calling add_dpa_res and aware of DCD patch 
> needs, and the resources linked to the device and released automatically 
> when unloading the driver.

The DPA address map is not dynamic. Once it is initialized there is no
need to release them. The DPA child reservations need to be released, but the
initial map is released just by freeing the cxl_dev_state. Notice how
there is no DPA resource release in cxl_pci for the top-level resources.

I am taking a shot at putting code where my mouth is to unblock the
type-2 and DCD series. I.e. just converting ram and pmem to an array,
and splitting cxl_mem_create_range_info() into cxl_mem_dpa_fetch() and
cxl_dpa_setup() where both the accelerator case and expander case will
share cxl_dpa_setup().

Going through tests now...

