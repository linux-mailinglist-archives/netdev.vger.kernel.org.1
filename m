Return-Path: <netdev+bounces-285624-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7CN2JTBq/WkndwAAu9opvQ
	(envelope-from <netdev+bounces-285624-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 06:44:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 259364F1B44
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 06:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4610E3008C0F
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 04:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C212BDC1C;
	Fri,  8 May 2026 04:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WBQ3di8Q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F957261C
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 04:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778215468; cv=fail; b=s6o8azTVF16S8f8aWYbcc34MIEQqny6MaKab9SDHRXl34Wj6Je18Kf8i2gDjfQqyEvNuJj9O52Wb+RCB0SwCSKJjyYV2JPC0RmIlndz00WohUnex4LNu2l6T5Ws4CMk2/YwWh9lagGjinOnUh3A9p/DjPUB+ya9l7zUr0R9bRYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778215468; c=relaxed/simple;
	bh=e+m9hm53+Yximi2Sdne9yTATmDd0xL6Ms1Pw4gJR2HU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mCa0DeisXti+xtkdLNzuX8JwICKXoXk5hV9gyHNp6wW7POa4GazhPyT76u3Gl8WcbY/BmgPeF4KBYd635ACKzCzxMCvvQjPJ3XTKDSxON4U5FH4Kc71fIFit89aZCmN+9nVju9rpcq+rO3085vtGxP0tGrAcoODhcMd2bgOLl4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WBQ3di8Q; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778215467; x=1809751467;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e+m9hm53+Yximi2Sdne9yTATmDd0xL6Ms1Pw4gJR2HU=;
  b=WBQ3di8QbryZS4d1uWz2mZWcmbttxItS5XQw/8qGKgOu/SpenojtO9Hn
   5MNu1BK+wde2IsSX2xLSx+GnmJxh+gKMwHARSfxSSzwt39gLfbUk3Es8d
   y/aZsc/jM4fUc31l+XmhV8d305Xo6csrytlvWzFCk6RaFcCYO3uja5OOt
   YME5Toq7oHjnC2pLkcDFeC0VUyUE0j8bWsFe8CO+Gd5NnAeU/RgGaCObb
   jy3ax/hp4SaeJQ6miX6xKQXQgg+GhF1WsDbPeGmaSrqFRODj2upPLkKNN
   sdayTgLUmBlZ9DygVFKdeLsoPuEKghcroYEQpxu6O4B2G7JnqvfqE+eRj
   A==;
X-CSE-ConnectionGUID: LtxpTBcERTiVZygAHwpx3A==
X-CSE-MsgGUID: c6vbeVw5STWDoBpEjGyaLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="66706319"
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="66706319"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 21:44:26 -0700
X-CSE-ConnectionGUID: 5tv8DaVaSbeo0QsHbmnCRg==
X-CSE-MsgGUID: B2ZvURomTmaWnjmVXVIHTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="238449639"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 21:44:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 21:44:25 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 7 May 2026 21:44:25 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.13) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 21:44:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fnrSPt9stzUpa0SUH5pl5TQ0Hie0VHyTevCOb/xMFSLoeNdSQp9ywc6wehtdzGik2bVMhICxGzS5dHekpaRBUDqqYtoA0ovp/xbq2ZeCEGSBnU9Qp9mfvyev280RZoGYrCZGwKEL4TWqE0iQA3BXlfbZignTHX3fNK19F0PstkUU4qmY7sVZ0BlcsJ/ngiOBXMuJBR5g2SSyR1uVEAlST8ZBL4OPMZK0VqYYTi6gocBkyTTyOqpsWVicLHxLo1UXp+5MO1qthFPkPgr6F0usa4lkwsHJdTdTmE5uiFcLPOAdc/yntAYaYCaCM7UczYHGgICby2/s0cKlZRjcy+c9uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzwLnUwIzj222R0zsxHm4mdj0D9zyyk7v17xnw+Um6A=;
 b=ncgy9gox0NZHAY/7kUvq3DmFeJsFdhmLPDQJmAD4Gttz10JokToUXot+jCv3ENmW25ELSsw0MFmXyQvDGvfhgjfHMpbBDFqtQ4larHQ4CQ5E1UbxrWhry6nT6XW9E2B0Eq4ijcC6WRnvDYmN6Bfb/0GE9DxmIe3PsNJpf/rS2F9FgEMt+/zNscMUpn0J7HJjA4OR53zfnMJxypAvpOQZ2xhtMauvqsS4uMZ6Mx5No4URqke42cW71bJsozMPLv871GfRO2Xzc88E+Qhkd8j2dEnWUUyXxyIz4kX35LF4JcufKXsQxFb9ZFk3EUB4PqolYKRVTfm3SODXwCEvF1SKbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DS0PR11MB7577.namprd11.prod.outlook.com (2603:10b6:8:142::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 04:44:17 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311%5]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 04:44:17 +0000
Message-ID: <dd912f90-9087-4a85-8676-852679845f21@intel.com>
Date: Fri, 8 May 2026 06:44:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 3/8] ixgbe: prevent adding duplicate FDIR perfect
 filter rules
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
CC: <netdev@vger.kernel.org>, Piotr Skajewski <piotrx.skajewski@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <anthony.l.nguyen@intel.com>
References: <20260508031226.3601800-1-aleksandr.loktionov@intel.com>
 <20260508031226.3601800-4-aleksandr.loktionov@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260508031226.3601800-4-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P191CA0024.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::16) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DS0PR11MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: 358c849e-45b0-4ec0-9fff-08deacbc764b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: fF2P7F3J0Se+iRKMNAMbezeUgkbl1MPXSbjzG+em2qG3bO3j5980WT8MFm2EkJqXWxQTMg/yHca/yCMAfMPe0vyvl1qbVIJvjjnbfCbNf6T015heL6gCNBxrRxTf1iRBJ+2gsY8dORU2jWerDU+VEH93V9F828xPxT3+P7Iwjlb5jejMA4x0cQdAIND2X6bXlA0IVmZePCwsyOj3oo6fWURYYvjQhDd96UGl6McNjw4kIAhyJXoY4NfnDWR0qzh784WYXebaPa5UJcT19cDWHYHK+A1XeZ3mLsMYbMoH72cYrLCITiyxmwQ24vwPOTAmW4wpb8TrzdkBgq3iCVp/h38qOvDILgT4B3sPI2+uDBwmrMSne2UWSErO2ilnCY3FtwSI1MoZ8j0D+KshkCrEMKm8TcS93h2QGT4B3kXEr1fAUCNIBkeoa3qrd7gT8qhB61fyFvmXGv4K5jd7tJAm6JqFrIECf7G0wOKPf24r/kJKY16AQ6g8LltkpMpwiuwFgkWRVbTD32tEhSHIAHVviEYvP/zoooi23azgdDKrRfzRBepOOxf7ICJW/9kAxWT0rKkyT7tPhHarymHp+Ur4JurjTY4no9sUa0pQIetru+DrUZYkcTO/Hw/F+suGV9MmKwoYhE2BEpchUt9z2Q1Pf82qsq1/ITZPjr10qW2kZrF1V/ZtaSRirGOn7dK9loM0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aml4QStLYURiaTl5blliNGNoWFp3cHRRSEhUa1VRRmNuOTdsTUFZbTRFVFl0?=
 =?utf-8?B?bC9uSWFjaTcxb3NnLy9rVkYyTWluVTdpVVlIZjFmWlk2dzRkaENiM1ppQnpI?=
 =?utf-8?B?OG9rMnR4eFJBOEF1aUtwUWhpMU9BejRTRnJCWmx2eEVybE9pMjd4akMwNEdr?=
 =?utf-8?B?cjRNMlBlZ1dpNkdmNy8rY2F0RXBZV0RBcnc3cW9HTzdSemlSeS9qYjNtMFhL?=
 =?utf-8?B?WUw5N1k3dW1GeFU3T1FZQnh4dExCT1d3OUtnR041VVp2d2FEckE0aUFwN1d6?=
 =?utf-8?B?byt4QVNHc0tiNThtOXZ6QVpxU0JyK21lV1dyR25uZ0FBWHJFdDE0dEJpRnln?=
 =?utf-8?B?U1BvSVdSMXMwL1l3SUpabFNDQ1B1blJTOWtGWXNES2FWYkxqR3d6cWh6TzV2?=
 =?utf-8?B?YUhPRFRVUzNBSGpoYlY0a2xnTkwyM2pNdW5PbS9MUEpZUnFsY29OdTZqUmVF?=
 =?utf-8?B?ZE96Y3N1Mnc4U2M3eW43WC9vZkVrMWMyM1JLMTg5M28vRWZMenJBR085QXow?=
 =?utf-8?B?S1FvYnM0dEppd2dhZEtwZWw2dTBWYlFlRzIwYjNXaS9oSnFRMkM0ckcvSDk2?=
 =?utf-8?B?b2NIc2R4L2YwSkdjb051clY0WGkwc0pJY0NLK3FpRWJxd2tGVXgwZlhaSUhC?=
 =?utf-8?B?UUpsN21SaTBydVhobHNoR2VXRzR3UHQ5bVlYTjBRWENoaUx6dFNucDh1cjZV?=
 =?utf-8?B?TmJ1Y3hkaThiOXp0N0F5dlVqdzV4ZXRkN3pvOVlYZnlyK0E5WEpEdUY0N0lJ?=
 =?utf-8?B?S3BXdll6SU9HYkpoWm5QZjcydjUycmFWYzdZZnlDbjdua3Z6RWFFNnZlN1Z1?=
 =?utf-8?B?NU4vWERlYnRuT3YySFcyNGdqTFU3NHJGVXo0QmF4NFFXdStOVDJVc29tZExh?=
 =?utf-8?B?ZzczR3cyU05QOVZPNEpJY2ZyMWY5MU5PZ1dyOEVKUUlMMjFKSFlqTkU0bm93?=
 =?utf-8?B?ZU9ad0Z3NWQvWkQwSWpWaFJ5ZFcrYmcyVFI1ZC9TYTU4YlZHRHNZTktmbWpP?=
 =?utf-8?B?bTltU1FCL3NpRjlkMUxyWWJ6a2lzd3R5d0NkU05rNHRSTDJGVDJ5RUx6ZmhY?=
 =?utf-8?B?QXY2aEpNVGZRUE9vKzJpUzd3eHh0T29WdzdnRVhvandhMmlFMkRWMWFkY1Fz?=
 =?utf-8?B?S0ZBSmMwOXhITWpFbGxHSm0vRklvVlBTdWRkREhIeEZFVTM3QWRERlVCaWVZ?=
 =?utf-8?B?RFRqT2JFNUlsbUlSUDYxRFpSa2lqL1lNWHFKUWpGSUdOdytWWXhWWFFHcnlK?=
 =?utf-8?B?djFqSzIzZFhlUnFOQ1p0WGF5TU1mbk1vRVJ2cjlPWU5VWStOR3FZSEI4M3ZU?=
 =?utf-8?B?dmVnQUF3M2dSS0hySGU0U3Q1ZnNkNUViZTg2V0Fia0NwejFHeWpKaVhLZ3pz?=
 =?utf-8?B?VXBBV3liNXdoT2htNXJKM1A5TThrSU85Z1RuTVVJbGFZRi84RENTWjBQUC9v?=
 =?utf-8?B?OVJIYjlKMjREK05xOG5OUFlNYUtORFozd2NGWkRtbHFaMTg3Y2NGVDBTWTNv?=
 =?utf-8?B?T2MxRXJPcW5vWE9BTFBOSEtmMyt4YUpVRy9BMVh2Ritpa29oak5wWXY5YU1H?=
 =?utf-8?B?aXMrVFN5SmdjN3FseXkxcytYQ2tneGx3bjdCcS90NjNnVUdjYzB1M05mTkpx?=
 =?utf-8?B?OFljd0xZek1Dc3BBcUhGMDhlc0w5bzJuVXJVUUQ3TUJhYjlKbDlpRGhmc3NM?=
 =?utf-8?B?VUVPRVJUYWJiUjBEK21MRGFrSlkzeDRrL2JTZ2FHODdOVXNrbU95YWF3dVZZ?=
 =?utf-8?B?UTl3QkZCYlU0a2ZnSkF5azR4MU1vU0xveElEWStrdzN1SEJqQWllSldRTG1T?=
 =?utf-8?B?WVl5UWoxUVR3YWJDb2F0WXVtM3NUckx1RzN5Q0RUZHgvSDRDRW96aEpLRFc1?=
 =?utf-8?B?cWtLS2NWWUZXR3A5bCtHUmNpTnU2cHBMRm1VSGtPNWg0eXZlNzlSd3A3Y2Yy?=
 =?utf-8?B?K3NQVHNhUWVMOE1lbWRkZEVldXJWTFBucFdvaE5HTzYvTmtpVmpiL2tWVDdL?=
 =?utf-8?B?Um5CdndBYnJlYS9NTU5mcURpYjdEcWtSZUxTUFZkVUNIViswWmRydEVneWJG?=
 =?utf-8?B?bDJ3T0JVMWcxbGowK0lTeE5ISEhKMkZOWGRVOWdnWjhvT1Z4aHJHZnE1cDdt?=
 =?utf-8?B?ejJLeXF6RmJiSU1xN2p6bWxBNGdWZ1JTUHlKdkEvK1pnWThXTFViYVM5VGkx?=
 =?utf-8?B?b252SVRrVVZjNmN6RDJteVdxM1dHNFNSaGV5SWQyZ1JCV1lOTUNjdlc1aGZD?=
 =?utf-8?B?TlpWcEpYSHZKZWd5SHZRL3h1aEpxNmI4SFVtdXVoc3Z6OWVNTUVIRnhFVXox?=
 =?utf-8?B?TkNiRnlnSlBpcjBMc2p6VmZaUjBkUlJTQnBvRUNaeFNBL1pwZHI3dVN2dnor?=
 =?utf-8?Q?Wa6I3RccbvOnwp04=3D?=
X-Exchange-RoutingPolicyChecked: KXPhvsa5xKyuyzPOygb+h6y9d1bY8bvTvwZYXdy54zZYV7lCUFNVXpSMji0qdbqdDkYN41h8oDSwz4As3hlK7eTdx0Ccp1dANRmL4GgACTTeon6zWLQDuPgcc7m/dhfB5CSjomR8ct6GJvoe65GxD1ThwJ2Y6wBjSqjXofyQvfV15wuLEvuNvU+yv5Gbr8hIEiVHb+uoy3NqLvXfC/BSC1IZKi8+HnQoHZ/3264A/j7ycsSG94n2Tym6lkHIGGooydFKT4hHr9pBIX/3cgo1oaXmaR5aKFE7Hs55JqFnN5JDxGFYNlucP/9noLeOnfb354/DxxzWAXZkCbocvriGFQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 358c849e-45b0-4ec0-9fff-08deacbc764b
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 04:44:17.4243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V6/eEOOw2GIYKoHgK6smvFIq3sdNdUnMLQhZW5DtlNSmZnCufuOyvin0hW+wBUs5A1YhmGmOLYFD1WKmA/dPyZLq8GT42Uj1RiVIGpHaGjE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7577
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 259364F1B44
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285624-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On 5/8/26 05:12, Aleksandr Loktionov wrote:
> From: Piotr Skajewski <piotrx.skajewski@intel.com>
> 
> When the same flow specification is added twice (same 5-tuple with
> different sw_idx values), ixgbe_add_ethtool_fdir_entry() silently
> programs the duplicate into hardware using a second FDIR table slot.
> This wastes a scarce FDIR entry and can cause confusing behaviour
> when deleting rules.
> 
> Add a helper ixgbe_match_ethtool_fdir_entry() that walks the in-kernel
> filter list before programming hardware.  If an entry with an
> identical filter (excluding the sw_idx) already exists, the new add
> request is rejected with -EEXIST.
> 
> Signed-off-by: Piotr Skajewski <piotrx.skajewski@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>   .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 27 +++++++++++++++++--
>   1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> index ba049b3..a2009df 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> @@ -2938,6 +2938,23 @@ static int ixgbe_flowspec_to_flow_type(struct ethtool_rx_flow_spec *fsp,
>   	return 1;
>   }
>   
> +static bool ixgbe_match_ethtool_fdir_entry(struct ixgbe_adapter *adapter,
> +					   struct ixgbe_fdir_filter *input)
> +{
> +	struct ixgbe_fdir_filter *rule = NULL;
> +
> +	hlist_for_each_entry(rule, &adapter->fdir_filter_list, fdir_node) {
> +		if (rule->sw_idx == input->sw_idx)
> +			continue;

this if makes it possible to add rule with the same filter AND the same
sw_idx

> +		if (!memcmp(&rule->filter, &input->filter,
> +			    sizeof(rule->filter))) {
> +			e_warn(drv, "FDIR filter already exists\n");

return code of -EEXIST returned to the user is enough,
no need for a warning here

if you really want a dmesg entry, then make it info and of not alarming
wording

> +			return true;
> +		}
> +	}
> +	return false;
> +}
> +
>   static int ixgbe_add_ethtool_fdir_entry(struct ixgbe_adapter *adapter,
>   					struct ethtool_rxnfc *cmd)
>   {
> @@ -2947,7 +2964,7 @@ static int ixgbe_add_ethtool_fdir_entry(struct ixgbe_adapter *adapter,
>   	struct ixgbe_fdir_filter *input;
>   	union ixgbe_atr_input mask;
>   	u8 queue;
> -	int err;
> +	int err = -EINVAL;

RCT

>   
>   	if (!(adapter->flags & IXGBE_FLAG_FDIR_PERFECT_CAPABLE))
>   		return -EOPNOTSUPP;
> @@ -3050,6 +3067,12 @@ static int ixgbe_add_ethtool_fdir_entry(struct ixgbe_adapter *adapter,
>   	/* apply mask and compute/store hash */
>   	ixgbe_atr_compute_perfect_hash_82599(&input->filter, &mask);
>   
> +	/* check for a duplicate filter */
> +	if (ixgbe_match_ethtool_fdir_entry(adapter, input)) {
> +		err = -EEXIST;
> +		goto err_out_w_lock;
> +	}
> +
>   	/* program filters to filter memory */
>   	err = ixgbe_fdir_write_perfect_filter_82599(hw,
>   				&input->filter, input->sw_idx, queue);
> @@ -3065,7 +3088,7 @@ static int ixgbe_add_ethtool_fdir_entry(struct ixgbe_adapter *adapter,
>   	spin_unlock(&adapter->fdir_perfect_lock);
>   err_out:
>   	kfree(input);
> -	return -EINVAL;
> +	return err;
>   }
>   
>   static int ixgbe_del_ethtool_fdir_entry(struct ixgbe_adapter *adapter,


