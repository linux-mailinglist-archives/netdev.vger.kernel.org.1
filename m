Return-Path: <netdev+bounces-195108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A746ACE05F
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 16:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AD7D1886ED0
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 14:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B41E28ECC6;
	Wed,  4 Jun 2025 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EA9vdm4T"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D7728E609
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 14:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749047726; cv=fail; b=eE9kchJ+qaCzAEl4+VMFLUus9IL8RBay0wITpUVvd34/dU6YGyj9UndpqKWQcazJnO8uva1X8aPzoUxMRBZZB7+fdOCtQ/dKS5pIWJzQkHS9syhypkfFkdaPvRyRCAMi54PRnqOEbJA3fCYTZXBnwzvxOE5EzgQKCf+FQHAooT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749047726; c=relaxed/simple;
	bh=TkGsjEorPuATbJRobb7yFdjTOzeXacq4nit7rVdKtPI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DvinNtZlDvnywtcrqFHYMEOUeTgpGqyo2/E5FOMSM2EPPw+5eVuNo+ExhsX0HbelZlfbcj+xp7Q7arWMiHGEhObQZPSjOb20/4865jCq77BFTN5yTSXZvOP3xM8LKmZvsf4RnWkdn1tLvOcWuO90V5Ysa5tXt95Csmbq5uyLYNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EA9vdm4T; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749047725; x=1780583725;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TkGsjEorPuATbJRobb7yFdjTOzeXacq4nit7rVdKtPI=;
  b=EA9vdm4T9kPmhO86iEWqRcMh6EZ/3Q1aSFFVboXdflpZz2KCwuLpisOz
   cTT0q8BgJKPK/arBG9cKLZ3zS7JH4UhL3+bJz/3I99d7c7O12oHYsLcg3
   rugF8jRJ4gytq/NRQr9jpTQdwrSg96y5Ah0rKo44KcgAU2mJ/tcgJ4eyB
   HvNDMzAgBw5KjsInN/NwXf3FCPMMyDjAKz5syBJv6Dj5QIgvTXfH9V31P
   k8L9WDxyMcoLxs5EYOmDWft8rHbZxolHnbaTR1kfd7mdyr0Ql0QoYCpIs
   Z/x2mZ0q7JkwbZX7GwEUBnKrnHX0UFEA0qCCmyHyOh6CnLT7mzrDihEe8
   w==;
X-CSE-ConnectionGUID: BlZsxwbiT/WTCwsJeBeotw==
X-CSE-MsgGUID: 1R878k2TTcewNfhQVyLQjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="38765315"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="38765315"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 07:35:24 -0700
X-CSE-ConnectionGUID: gVsFVaBvRC+5EWkrql0sqg==
X-CSE-MsgGUID: jVm5CO7jQMCNKq9YsmFLnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="150089213"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 07:35:08 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 07:35:07 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 4 Jun 2025 07:35:07 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.62) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 07:35:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nW3FnLJvnJDRLChZXk5NV9GWo/NBJC5AopVJ17pV2qRKokScn2u4o4HIUMmoimqN147hEqkMSD5ddtnCkow4Z+OXccPvkk6TWyvhhVDoAejdU+mg909PsywcYLXGOtB0vSqe52THNaJAaIuwjKRUqRd+kEBXARlPgEFVxfCEku9QufRAx7U+lpHnmByohM9bcmVrJ+tY8HLHT+/DPjkO8LDxnWG1PusWIZludQvd5thlNKFHSv82Sy4tdFeCwwFmic83nRuNCqrZVzBTN0VU59hu4k/KSisrI5SmJQaKJNAl00WUR9CrizS+ndree0GdPXDFS/9aMAfq8SCgD6mmRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVuJhbfSFiEZ6pdFa11HcjhGu4Ta/RbLjBROqb50GkA=;
 b=QRR2V56Q3sZil12bA49l9fKAasP3rIywL5GqqbMBbZh8wc7rqdvPFbIiamT0b6hIz3mgRCocWsTsc/CXZreMgIgo+jH51/aycqEt1cwppwj8C4oFxctS5wKtdLRKYvrUjiAeF046ZVKtiFUgVuCVWQMf/PBReSJoWf4oYzJg+eC7XaZEPLENkSnUEQh7B+KCJnQvy/4SIEEtlJAsuou3cXgEm7/y8sPEwxJBIV0WsVtfYkLAJyIbplcy7+YriemK0rU9mhwXDj79w1Bns6OMjwalcbY/XQ7UGNGl/QsORDUGvTilvGLZiiu8NcqKCCtjlDAIFSBSip8Ih/AL5h55Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by DS0PR11MB7682.namprd11.prod.outlook.com (2603:10b6:8:dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Wed, 4 Jun
 2025 14:35:05 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%6]) with mapi id 15.20.8792.033; Wed, 4 Jun 2025
 14:35:04 +0000
Date: Wed, 4 Jun 2025 16:34:56 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Antonio Quartulli <antonio@openvpn.net>
CC: <netdev@vger.kernel.org>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Oleksandr
 Natalenko" <oleksandr@natalenko.name>
Subject: Re: [PATCH net 1/5] ovpn: properly deconfigure UDP-tunnel
Message-ID: <aEBZkKpKB0uGIgNj@soc-5CG4396X81.clients.intel.com>
References: <20250603111110.4575-1-antonio@openvpn.net>
 <20250603111110.4575-2-antonio@openvpn.net>
 <aEBHNVFvthKTUWuO@soc-5CG4396X81.clients.intel.com>
 <c05d08c1-ed23-40d3-8950-d00aca49f480@openvpn.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c05d08c1-ed23-40d3-8950-d00aca49f480@openvpn.net>
X-ClientProxiedBy: VI1P190CA0049.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::7) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|DS0PR11MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f88b1e6-5190-49a8-4233-08dda374fecf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Qf8CkOa4aGbOiZBTLq7mHxNxS1q+BmHGQBFQJ4ukBdHtQ6AS3YpaKOm7f4Ex?=
 =?us-ascii?Q?Gz5xcgoaL5mrS4WSNtlqm9p09qLJVG8emJP7h+ZUa7ZSBGI/RGVx1mAglEvG?=
 =?us-ascii?Q?s+Xf4gGbWkDYmlR7YLoiHZUhxHh41e1Fp0dSRctNT6J1VreMlJDOiU9XNtGp?=
 =?us-ascii?Q?K/avjRZO5MJS5SytU074FxuDMtsDxEdtsIH33xWxiBBuLpmqoJzr8PPobLzh?=
 =?us-ascii?Q?nfMoiikCVPuZF3k1fjMHVbM/Y19+bAOPkJ524qmWz5OmglSchcAWgoU9A/Aw?=
 =?us-ascii?Q?wWwj79Pk4ZeOCam7Ickw0cSELflgrSSAfTDsl/0O++Mive0jYYugWOV4mDSF?=
 =?us-ascii?Q?R12UX+HWDQVfYfWBAcFamtgNQJ7/4bvHQ5n9w1lHy/PsdrfFoNOHvu/1Ay5G?=
 =?us-ascii?Q?i2/HmSZuUC6M6h03pjvmmpNj/io4nwMq3QYS/mXXaMPEsXGw16WlAQgyq3Nq?=
 =?us-ascii?Q?EP8pS8IHkYajCnzy2geuySVfctQd1z1AKopF79nXK2Dpky2TyNmdUV/ODNS6?=
 =?us-ascii?Q?rTjQv56B3RYWADtCptj9vxrav3jmf78N40gvURNOLCBO3doTy9ehUe1ikp9c?=
 =?us-ascii?Q?c3HnnSzZVvtXjp4CAN1JWEqLHnzJEN+Ae5AgQ6gOTF+OZ/9MAE9OybjOeoBF?=
 =?us-ascii?Q?nYl8gma1jIfXsjG+ELJEu/UQOMcI2jH7NCJuDwcRWirozYe5AOjPxoqpXW5q?=
 =?us-ascii?Q?HSHhNca3oVhgp4EHf6RLMG2zEOKorbwZidajI3jfeOI4+gdBvBvGBGw6o4br?=
 =?us-ascii?Q?vHYVV5GFRs8hC0Nwun3sdkqJAscCm0SnlCDvfwmzKQTly3Ul99DColiuq4QN?=
 =?us-ascii?Q?yCwTPM9kMfrrkgXJ5kY5JydqgSNzmHdS2VL/tXNdMeEe9yZYPNlq072Vpm1Z?=
 =?us-ascii?Q?55/0lXP3FTO8iKVjlUreqWZ3cd/m9iGYASK4eV97jtDQSPgdSNKp/m9EvSed?=
 =?us-ascii?Q?9QmNBbhvjON421+chbAXJ0/I4P0MJRW+5YcP4JWqO1LecVSjncjjAWW1QFb/?=
 =?us-ascii?Q?dQi6Bv1MmsqIT/Zz1ya+6cuU1WIi7GpWMd5KdjuBXzBieOvwhKIP4khZ80Xh?=
 =?us-ascii?Q?nirOTVfFGV/r2s1D8+RJKLvxqBbqX+GdFuL4CN8k64OROSR02e46HWfVYC9B?=
 =?us-ascii?Q?fXNr3V2XN+d+zo4iH4QuS/qlr2HPq9Ikma/rOkDgAGhlMDnxaowndkSFtpJQ?=
 =?us-ascii?Q?PK2Pk15HW7yxQtK1wDtIFH5QLURALMIcobi7h5eGJ/6mA3oPNpE9YWDoP4yP?=
 =?us-ascii?Q?S2GI/82KMOW0nrRo6JmMVMZdeOL9x4sMpvJissaZtQqD9JbPdIke6kA6b+Hh?=
 =?us-ascii?Q?45ljWug/4ubg5rae2R2UZ/S3WPBbWn66d+MBGAm5jAstk6bj3+B8yQVeh5oM?=
 =?us-ascii?Q?YVEAmowRq985O2kCkj6XtMkcTmcpyJEPfdumaGB3v8e7ABTJiyB4ai4ISXYE?=
 =?us-ascii?Q?DbxF+hxPJYc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DTBmEoLEKGh+0IDC63x6H0dTXe59m3Z/3NH0t3HxRWODUcEPolcQJXS3UEw5?=
 =?us-ascii?Q?rWQwlO2hxXVtrA8QPvOzwQ2NmiBbhn4LeKlPW5Wej5vmaSquUaJWmJvz/r6C?=
 =?us-ascii?Q?k6oBEVw3bxM31RFVjlNIZGM1lHCjlQklJX1FlfRuJS3jcTjfTk0x8c472FVR?=
 =?us-ascii?Q?uFb75xdqx5Sma325xpdNtJEhFUm6XjI6i+wtkwko5BIdpk6I7E9b96wWD0f1?=
 =?us-ascii?Q?ymP9AfNMjYFw986y6K6LdSw3gNhdhMh7mmWE0EEVouVjczT/EXiM81DmVck/?=
 =?us-ascii?Q?fjUxQ46fAoODrwIS31Fv0QKJOSOmW6hByxRj+o/7oI52IyycBHLVOe4oOdo3?=
 =?us-ascii?Q?1Aacvuvi0MwQp45RjgpRT33Ny6MaD+f4ZKpjI88zWleyC2J5Z9RweTCelFHP?=
 =?us-ascii?Q?xIzpb1fJi0E0hGb1ioxj7aSR6l8jBlbapih6m2eXCCUclGf89vNavbK4I8g8?=
 =?us-ascii?Q?KbMjle/t7eRcxw4+6itVXBxPfU0/dkdgZYXcheM+1qH+OUii8zeZmuzKwHLF?=
 =?us-ascii?Q?fM3Q6isvNjBmu1ZhEQnpLUxs7JPvBwz2xZ8JivgIpP/hjP7Y8VsNcETdmrEc?=
 =?us-ascii?Q?BUjJAfIrA3loji+uPI+RPe0JgI+lM9LHdWa8yLmnEkMeZRoyATjyOCvF1AQP?=
 =?us-ascii?Q?2zsienJJxjTlXrkJojV7Kf5p/x/6oGMNJUH/XHSMAFMr4srQBOmneczkvlQl?=
 =?us-ascii?Q?QL7wWZhT78GnINNZNqtlv7IqefzmRfHp3t4MRRq6diGyU7uwAOyt/u+sQEAz?=
 =?us-ascii?Q?woamAlkSaNuCDqRJQJ7VeH3NlqFnZpvM7BMVr6gkRXqQdn9qCog02zTdjdLd?=
 =?us-ascii?Q?Tv2pwAhp/f6tItk0ZUIfwAsgjn8kvwDkkRR35HrdjAaka+2T0L64QKeAzal2?=
 =?us-ascii?Q?XstjId2NCR11eokwVAeLohuJxOeLO+BhJAdv5RYvGKCJ4Gw8JhehN3Jg1P7o?=
 =?us-ascii?Q?nNk6oZ5SDRBHYtymuB+OkFB9HBB5ALzIkeBXHzqmIv/uMYkCmmqglBB3eF8m?=
 =?us-ascii?Q?Puo/MJZSWEAjFRF061ZFYu6EZVsnwtVY0Ux3CQeOMdCUCJyo6ih6jcgUpAMv?=
 =?us-ascii?Q?2YjYKXojZtweMW3j/86BI8Ug92GHwXJR/jBJP4uS1R2MKwAm8mLG29iAYX/I?=
 =?us-ascii?Q?hgzisu4bnjYXln1xTtSJ1rVoaSLSTpNyKfwM+YcIoMW5NUViZaMZmu7vZpYj?=
 =?us-ascii?Q?4kO3ceGk0Mw4no3uLdYR3KIgXLoCgd00SCLDf3BUJtC6acJ3IYhqlFRuIpCR?=
 =?us-ascii?Q?/OLiQc4ho3GU6tmw821u5dTgYTTYxbqjYHP31864obRoM552NWkSlnpAhKjH?=
 =?us-ascii?Q?eUb+eS8z+6QeWfdcQ3jXcXd48EKxS5sdybFTra18eDZs8hn9LpAwQ3z3kjZY?=
 =?us-ascii?Q?iwNFXQwvTO6qhM6Jz6x0lW1kgED+/dlISw2n9heHX4zQaE4n3L9Was1ChFk1?=
 =?us-ascii?Q?O9OS5xN3cE9fxQ+O2hcfZaJJ+gm6siDw9i71If4yLpFm1Nnnvx7NsYVdrh8H?=
 =?us-ascii?Q?StU7YHWWKy5Y3evHWvYTB/cHO0Secl8bqOuTpdJJZfuYb3ytrMWTAfGdQ4om?=
 =?us-ascii?Q?z6v0+yWPMRU/MIT1qSpG61a90F89WPTCIOPzk1VGMgjYSx1qwHj1bSP68SKY?=
 =?us-ascii?Q?8pU/qgqWXw82mfwVyXZugw8X13xjFL6aF666CDi4mCyjXRl4SOfonz5Ya7M+?=
 =?us-ascii?Q?DhK89A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f88b1e6-5190-49a8-4233-08dda374fecf
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 14:35:04.5046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E/ZFOhPuct35da9Cd9tCYoaYM7c3uDlEkHpST6e6J4i2kV/TlgrOH0/VLShB2Z/OSgzxywRafJF2fMqrWI04h8f0sM5lg1hez0q3KG+ei4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7682
X-OriginatorOrg: intel.com

On Wed, Jun 04, 2025 at 03:41:04PM +0200, Antonio Quartulli wrote:
> Hello Larysa and thanks for chiming in,
> 
> On 04/06/2025 15:16, Larysa Zaremba wrote:
> > On Tue, Jun 03, 2025 at 01:11:06PM +0200, Antonio Quartulli wrote:
> > > When deconfiguring a UDP-tunnel from a socket, we cannot
> > > call setup_udp_tunnel_sock() with an empty config, because
> > > this helper is expected to be invoked only during setup.
> > > 
> > > Get rid of the call to setup_udp_tunnel_sock() and just
> > > revert what it did during socket initialization..
> > > 
> > > Note that the global udp_encap_needed_key and the GRO state
> > > are left untouched: udp_destroy_socket() will eventually
> > > take care of them.
> > > 
> > > Cc: Sabrina Dubroca <sd@queasysnail.net>
> > > Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
> > > Fixes: ab66abbc769b ("ovpn: implement basic RX path (UDP)")
> > > Reported-by: Paolo Abeni <pabeni@redhat.com>
> > > Closes: https://lore.kernel.org/netdev/1a47ce02-fd42-4761-8697-f3f315011cc6@redhat.com
> > > Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> > 
> > I do not think MC_LOOP is necessarily set before attaching the socket, but 1 is
> > the default value, so I guess restoring to it should be fine.
> > 
> > Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > 
> > Another less related thing is more concerning to me: ovpn_udp_socket_attach()
> > checks if rcu_dereference_sk_user_data(sock->sk) is NULL to determine if socket
> > is available to configure, but a lot of callers of e.g. setup_udp_tunnel_sock(),
> > including ovpn, set the user data to NULL by not providing it in the config.
> > 
> > In such case, is checking rcu_dereference_sk_user_data() actually enough to say
> > that "socket is currently unused"?
> 
> This is an "interesting" area of the code that required a lot of attention
> during implementation...so having more eyes on it is definitely appreciated.
> 
> In ovpn we have:
> 
> ovpn_socket_new()
>   lock_sock()
>   ovpn_socket_attach()
>     ovpn_udp_socket_attach()
>   rcu_assign_sk_user_data() << sk_user_data is assigned here
>   release_sock()
> 

Oh, I did somehow miss that. Thanks for the clarification!

> The lock takes care of preventing concurrent ovpn_socket_new() invocations,
> with the same sk, to mess things up.
> 
> Upon socket detachment, a similar strategy is implemented to make sure
> concurrent attachment/detachment are properly handled.
> 
> I hope this helps.
> 
> Regards,
> 
> > 
> > > ---
> > >   drivers/net/ovpn/udp.c | 14 +++++++++++---
> > >   1 file changed, 11 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
> > > index aef8c0406ec9..f4d3bd070f11 100644
> > > --- a/drivers/net/ovpn/udp.c
> > > +++ b/drivers/net/ovpn/udp.c
> > > @@ -442,8 +442,16 @@ int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock,
> > >    */
> > >   void ovpn_udp_socket_detach(struct ovpn_socket *ovpn_sock)
> > >   {
> > > -	struct udp_tunnel_sock_cfg cfg = { };
> > > +	struct sock *sk = ovpn_sock->sock->sk;
> > > -	setup_udp_tunnel_sock(sock_net(ovpn_sock->sock->sk), ovpn_sock->sock,
> > > -			      &cfg);
> > > +	/* Re-enable multicast loopback */
> > > +	inet_set_bit(MC_LOOP, sk);
> > > +	/* Disable CHECKSUM_UNNECESSARY to CHECKSUM_COMPLETE conversion */
> > > +	inet_dec_convert_csum(sk);
> > > +
> > > +	WRITE_ONCE(udp_sk(sk)->encap_type, 0);
> > > +	WRITE_ONCE(udp_sk(sk)->encap_rcv, NULL);
> > > +	WRITE_ONCE(udp_sk(sk)->encap_destroy, NULL);
> > > +
> > > +	rcu_assign_sk_user_data(sk, NULL);
> > >   }
> > > -- 
> > > 2.49.0
> > > 
> > > 
> 
> -- 
> Antonio Quartulli
> OpenVPN Inc.
> 

