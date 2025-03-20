Return-Path: <netdev+bounces-176401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88576A6A102
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 09:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CC40886496
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 08:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92F52101B3;
	Thu, 20 Mar 2025 08:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hUHSghsw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887D9209F4E
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 08:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742458575; cv=fail; b=Bv2ZzWoDAQZDJm0X7wkvTmoNdSg9v1a8WygSEn7LFcL4rFEIn3dZcX2Q0JoCHGjrH7jcSXUOhQKOlFOx/hDc/sqNsxYc4/WU2+OKgNtO2imTEG7w3xI7qOLP5fZ2vNtNxJevN1D/mTAiS4Zqvd2JmqO7TTg9qspml00rGSqOL78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742458575; c=relaxed/simple;
	bh=7jV42wRLeWll9PFKxe9Hi5sQmcqRRoP3SzcbvPVqDGk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ONPPkU7wD+clvKJsChZSBbLSNLS7llahh/VOREfSW+mIHgLQSMi9ujnE2PnVgcXcIxlfKw9a6CcphdxSBamCJVGvIg6aMkaCNi1LMbab4ol3Q3u58wVtM1PXhnkhDQYHBqZv2SchSZiPY7ZJ73Fwu337/sVg36LbIFQckdzhRZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hUHSghsw; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742458574; x=1773994574;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7jV42wRLeWll9PFKxe9Hi5sQmcqRRoP3SzcbvPVqDGk=;
  b=hUHSghswyaWqc5B2cJpQkMeFMIfVjw9bwAomwLPGO0gskh7huokNamTH
   eeS80vnJTqLIHX4kAiyKKIfjgTv0WNZtqvAaYLyE/cFqQcqd2FDePkezW
   +nD4pB6e+WBfiH6ebhdwfAbPSpwkJwu8C9epVfxZSZQeptqfAU9mw1Rok
   JIqjOKxzYD31l3SElu66gOv/OfHk1R2qQ+9sMPtBcwNI8RKs4Ip8/43wp
   O2y44fMqGeul60wCJT10WxD4FacWa3rnpewV5YSuFkKRhpi1zyPcRlnsc
   EoaRSO9Kd/I4oBeO6gjUZKFH3zg8oyTRHuN+Ynqs1OxPAPtTx3evHijCK
   A==;
X-CSE-ConnectionGUID: asrOGPVOQvCtKEU4BOv3dA==
X-CSE-MsgGUID: XVwDLq3+Q56VcD0iSe1RDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="31260964"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="31260964"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 01:16:13 -0700
X-CSE-ConnectionGUID: qAwVQLFrQGGHcowKFGA4/w==
X-CSE-MsgGUID: 3AaPdy0xR9eexeUaQr/nQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="154010392"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 01:16:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Mar 2025 01:16:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Mar 2025 01:16:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 01:16:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNvaleKR3T5FN6XQAkRC3VZ/wFPaMFP/jxW14xlXJLgu6cZfFCO4FGTbB9yQQtHHRsyfBiB+Ik59hoMDxIqIKPsxFUP3bUD5D9YEY7mTpaSilBAaYbGw1qVQ3G3X36Fbj/C2HENu575770cpH6cVzGI4CEZT3Hg9VV/t125fN0OuPl0KzVoELfAcYyEklnacA91zFzI2YbeURmlUv8xzKrSX4FPbKtvSdo2YRVMlUNguQJ4H2ZTe79HXHIYxYhMpRGnAb/1BIg5ZCNhALK8vgeTbcF2EMbQ5DLAbiUOWPIp3CnK3WcAppQaN3BJqxnv01Ohqrq+a4tfGSQVPImj3qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yrn1612szfwqIMjDb/+4PVO/PeStTFsbz++JaEapIKk=;
 b=yFqn72yqKAc013FygCKS53V+bgDelhjYL3RDKUiBiL70Mj3bwIxWaxdbnR+7rSltY+p+CPXlf9GmEqI04tjtXBY9KjuY6U8OhCKMHBlc3oXFV5ANvXgP2gZuEIjgpDBcq5hFHhF6X/eEzlNXosZX5gG7JxhEtoX5xBRKUQ3SDAkurLo9s2s3HqVLb3SlmERXvKs09KAOrxFZNz24HUlHPhWoXyHUPza6/mrgDXhtEaVInNQ2fNM8J/fRWyZVK7cDtWYt5O2p8GPOXFCNWmsjGp0VP91xVP4PKqHbj1v6u5rv3646+0cMaFXyadCrzBOAhe4d7IoDXCYyVh12kK6Zrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DS0PR11MB7336.namprd11.prod.outlook.com (2603:10b6:8:11f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 08:16:09 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%5]) with mapi id 15.20.8534.031; Thu, 20 Mar 2025
 08:16:08 +0000
Message-ID: <63ecbac2-1d1b-451e-bfa2-3d59555310ab@intel.com>
Date: Thu, 20 Mar 2025 09:16:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 07/14] devlink: Implement port params
 registration
To: Jiri Pirko <jiri@resnulli.us>
CC: Saeed Mahameed <saeed@kernel.org>, Jiri Pirko <jiri@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	"Jakub Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric
 Dumazet <edumazet@google.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>
References: <20250228021227.871993-1-saeed@kernel.org>
 <20250228021227.871993-8-saeed@kernel.org>
 <56581582-770d-4a3e-84cb-ad85bc23c1e7@intel.com>
 <oqeog7ztpavz657mxmhwvyzbay5e5znc6uezu2doqocftzngn6@kht552qiryha>
 <d2fc9e7b-e580-4989-880f-9b47fb5b5b4e@intel.com>
 <aw3z3xgjlp3thulc5i3qcfqsr7lamm2u67yqdq6myomlvtkd5x@6vecjicqvib4>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <aw3z3xgjlp3thulc5i3qcfqsr7lamm2u67yqdq6myomlvtkd5x@6vecjicqvib4>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0027.eurprd03.prod.outlook.com
 (2603:10a6:803:118::16) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DS0PR11MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a9baf2e-b93a-4db8-039f-08dd678777c2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T2JlSmpIbEgwTEMrMVRXbVNhTnd4OWE5LzFvalBNQThtdGMyemZ3MzRHMzY2?=
 =?utf-8?B?d3BTSC9Pb0NCeEYrM0tha2tqMmcvT2xOMGpTOXprN2pOUVhMaFVJanpOazRH?=
 =?utf-8?B?dkNUc2ZSanhtcDZ0dEtPc1YrUlRqaHloQm9wakowdnlBRGVZenRNNVBxK0pZ?=
 =?utf-8?B?WWVPckltcC9OamoyZVZzaDR6RkpBK0VUaUI0dDRoZUtzT1V2enQvODA1ZmFV?=
 =?utf-8?B?dEh0Wmkyc0xjenA2djVJU3hQNmIzVVBPQzJvOWNzc3pzQnlPWFlRZ1VUSW0z?=
 =?utf-8?B?dDFEU3YvYk1VMStlK3Nhb05idStwYlN4VCtlbzVrZGloZDBqMUhSZ2ZaK1d5?=
 =?utf-8?B?U1BwMnBMblFyTldFWVJ5d2xOV2JFVzIzazVhZkpRSXQwQzFPVVF0TEwyaXZn?=
 =?utf-8?B?aEQvMDFzS0gyM0VSbEhURFdZV0FqQndpUUQremE1QzMrU3h3YlR3bVhVUHRY?=
 =?utf-8?B?RDFhYXRDaXpHQmNHa0gyQ3dkeHNiTWY4dTRUdEV3MnlnMDdTY1dRcEM0Mkhl?=
 =?utf-8?B?RDJscUlWb0cyYkxKWWZiOWl1azNrdGdOT1I5a2xxL2x3ZGFPRzhMenRRejg5?=
 =?utf-8?B?blExWFlDeVl4MU52K3d5R0hZRHhNSGhFWDFuSjN3Y2EwRXQ0d3doNERJMW9F?=
 =?utf-8?B?dDNVSERZb2FkMXdYa24xU0VYekd5eG5zTDRqb2xnVU8rVkE4OGx0bkZJRHBm?=
 =?utf-8?B?TVNzTjArckltTG02cEgxUHNWeVVhc1gxNnJMUnIwZThGYUZPcHdBdDhub2lF?=
 =?utf-8?B?TnkxSUhLd3VhdWEwUmNvY2sxUjdBTEdyVU9OZTN2RzZic3hla0FjVmVWdUJS?=
 =?utf-8?B?NXRzWEorVGVubUpIR3kyY3VRNk94Z2FyV0hRTHlkcjQvUkdqanZPOUVoSk50?=
 =?utf-8?B?OWxjWDdrL0RUc1A5SDNDZGxuSldkWHordzY3TzN1TUl3Wkh1QnNhclc1Uk9U?=
 =?utf-8?B?NTFlLzdmUEVONlRQMFNEL3pmcUdoZUNrdUNwNUFwOXBlNzJTZTc1YmkzVkhw?=
 =?utf-8?B?T1kxbWxRQU04QWR4TE9LMnkxbW5qZU1wVmd1UzNKeUhnYXRoQjFLSnFIZnBo?=
 =?utf-8?B?Y1dPc0xUbXVIQk1Pang5TXlsRjRGTmQ2ekYrRUxCbEJydXkvMnh3VDcrSTRY?=
 =?utf-8?B?eXNyclVzYmpmUXlKUnZDUE5oL0VaQXJ5WFZIdW9HRm0yeElZTk1QMGlYVDUx?=
 =?utf-8?B?ZlpnbjhKd3U2YkF6d2c0Ti80aEVmeWd1bUE4M2tjZlVBdjN2NC9EcXJuaEl2?=
 =?utf-8?B?eHVJcWpGcmdPcWtmMDlYdEhaWEdYei9GWEpnZnZrZnorK0UzajlBbVpvTGJ0?=
 =?utf-8?B?UmIwNEJCVjhKWmhMUUlWZHBQdmNSanpHWGVQVnFONHBZYk05eU9ya2RnaE1L?=
 =?utf-8?B?NGljcXRaZ2VFNUxnUnpYTFplOHBaZXdNZ1pNVFpoTzBjM1ZJaXoraDE0UXZL?=
 =?utf-8?B?U29VOXljRU15V0xGVldUUXdlejFsZDQwaTlxN2FSYVczN3QrUnFJQmlBaEJT?=
 =?utf-8?B?YVFXU1BuMStqNjhPTFRqdWJSaUF1ZGFuWGVqemlJR2hKRmxWKytEeHhIN2s3?=
 =?utf-8?B?TEpFQlVUdHphS3JvMGxaeDJWcHNQV1liNXNhcEVTVFY4aGNkWlpOWnJlVlVj?=
 =?utf-8?B?aWIvM2RNbnQ5SS9TQ2xlWGoxc1BsNy8vazZXbmFwMmNUUjdBc29ibEJEZ2lD?=
 =?utf-8?B?NXByU1lSay9oSldZTURGem5LZGd5b2N0SEhDOCt4WjZzRVlDWWlkWFhrZnBh?=
 =?utf-8?B?dnc1TTYxSnZmdEZING9jUXY5VDBVS0Jqa0hxWE5HeFJJekh0QXhRa0xFMUpO?=
 =?utf-8?B?RzF2RUtFd2dzcTRLWEFRSEFUcTRCWVZkOGNWRUV1QmJqVXA0eEJibGhyNk1y?=
 =?utf-8?Q?gZzTlWi2HNAyL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDZTYlhmVjdiamRDeFcxclZ6eWk0RWlBb0pFdEwxemRZMUEvcDhSR09UbXZJ?=
 =?utf-8?B?MnlFWmk4Sktvc0V1bm9hUnp6TjN5dVRRVXo3TlR1YWdXQmVHR3NDZVdjSmlu?=
 =?utf-8?B?bGR0Z2FMK2NIMFhWMHhQZ0ZmUFJGZEIrL0NaenNVRlFQeUVMcnBRWjEzZkpo?=
 =?utf-8?B?M1JyTi9UUUhZdmNmS2ZTNmt2MlBCRFVCUFcwa0N2S3FFS3NpWGxDbnh4RHFw?=
 =?utf-8?B?YS92alFsUHk4RlpMamVZM1hwdENWcTZNL09qM056M0g4SXQ1Q2JFcksxNld4?=
 =?utf-8?B?MWtmTFJocnNIR1daRU43UzQvOXAzamFaZEtDUXlmOXVQSks2SlV6T0IraW84?=
 =?utf-8?B?aVVWdDc5a1g2QzNkVTB0ZklhckZ3UmQySHJyWTdNZjhaZVhTMHdvV2Rjclky?=
 =?utf-8?B?V1M3ck1wTXVVVzJyTU9vb01oNkNVanNON1NLeGhHWDE4ZXpOQUE0d1FWNkFH?=
 =?utf-8?B?OEM4aG5XWDh3ZnJSNWM0dEtlUHVNK0xpYitQeHBVY0xCY0c3ODBYV1FJaUVB?=
 =?utf-8?B?akUxanA4L1lORFNCRytqR2F0a1FDMWVqdDBqdU1FaEtqdGE0QW91VkI5cm1N?=
 =?utf-8?B?M2xqeStrYUZvQVNkQkw2QmExRnRHbzlhYUhCZXE3WmsraXJXanl5blE4Ujgz?=
 =?utf-8?B?cjVITU5DRU5vekRJL0lvcjFuTjlGdVBSTXliQmlrQjZBdEludUt5WFN0UmRN?=
 =?utf-8?B?SlNGUVduNGdvYURxM2VSYXI4YVRpOW1adjVUWlZxRk9tZzdFSmpyMXJVUXhO?=
 =?utf-8?B?VERIeS83aUhmOU1yelpQb1JqcWNiRmZMN054ek12ZG5aRS9nUndoVWtFcVg4?=
 =?utf-8?B?TUtEZFU5ekU2TzNQK3k2MmJpWlVmL3o2V2JkbGgydHFZRHRXVVNQWkJxL2xW?=
 =?utf-8?B?YjZYcVZrNzAyMlhxVEVjR1JkbFk1VW1qZXlUODNIOHU4Tm5ZZWdoc210L3NN?=
 =?utf-8?B?ZitKRUlxT05PcW1oUjZRMFRzdkRzTlhBNERDeHd3ODBjZGZPRXZ0RUo2MDdK?=
 =?utf-8?B?RThBcHZJNVNQcDBFNU5YUGtNaDZxKzhheFppMjhQR1dZcVV0K1dVOWtCQmV0?=
 =?utf-8?B?eVdiSGI0Y21XcDFuK3ZrTlRzUUFONGRkcmlwSUNlNlV4SlFBZnlxOEVQdEtJ?=
 =?utf-8?B?U2ExSTdYeVlFN0NxTytUOVJ5M291RS9MQ00rOERBQ1Q4RFpWVEFVWmFnVmVD?=
 =?utf-8?B?ZWNPVFpqMncyL2I3QXlGZDdCd1g0bEdtckgvWnhTL2pLTTZrblY2bjRtTTdU?=
 =?utf-8?B?dXUzbjRFZ0l5T1F5YXZ2T1VCRklHTVduNWlnY3JmR3UwL3U1Rk52a2dzYWll?=
 =?utf-8?B?R09GeEZLeU5FR05HTElkcjhhSmJLTlg2RTNTQkpDVXNhYVRRdk9pNWF1MVoy?=
 =?utf-8?B?ZXZpQXcrYlRmbUkzUmpQUmlINjF1c1ExSHFXdCszU1J5V205L0RTbTBZK2hu?=
 =?utf-8?B?NTNQbDdyYjEwN2Uyazdwc1ZlNU9xNXhQdWw4REJuaG9aSTBHNDdyakVRNVh1?=
 =?utf-8?B?dHpUblRlSDVYbURPVUR2VzU4K2xqS1BFSWt3U0RnYmU1OWtWM2wwbWM3TEVm?=
 =?utf-8?B?azg3aUFPQkF5TXFFTENHNmJxWXhVVXFyUmsydzZsN0VyNHlBV0pyK1dwaTV4?=
 =?utf-8?B?MFhlb1Z6a0doOFFZS3Zrc1JmUGJGbVIrQmVGLzU4TlVWbkNzcVZaV2xWYWZ6?=
 =?utf-8?B?MkJjeUdaRU8yV1FnV2Vad2NIU21FczNWQnIvMndGZXRMSllYd1p2TDdEaE9I?=
 =?utf-8?B?NU9pWkhEa29BOWJEY1YrUEVxSGdjVXBjRXk0eEtCbUFxWUdMU2Q5aGt1Nmtn?=
 =?utf-8?B?aThVSkdxeW9TK1FJOGs1V1dTa1gyQnBGQ2NmRlVUSUxEbEpsTXREVUtzNDJF?=
 =?utf-8?B?T3N6bWVVRG1ra1Y0U0w1SGo2bEZkUTZzTWlicXhvQUkzYWovS0J3ZzMwY0E4?=
 =?utf-8?B?Q1FPNThERThRNk9nUEFhY09XbXlRaldzOHNKakgwTy9MeE8zMStEMjJlM2Vm?=
 =?utf-8?B?TkhSaWF5N2g1WnNIU1QrK2s0RGhwYmZ3ZXpZYWo4MzhHSG43a2U4WXRpbitj?=
 =?utf-8?B?U0RDRWIyWFlobUl2OGxndUcrYVpKRXR6cktIaXJ1REMrT0cwYWNoSGc4UU9I?=
 =?utf-8?B?TEJORG5YS1poSkgwbXBkSFBRbHV0UUxIVHVCSkVjZG9aNkVEUXFsSkt4ZUE4?=
 =?utf-8?B?Vmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9baf2e-b93a-4db8-039f-08dd678777c2
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 08:16:08.6073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bkTcvCRaPsfeO+B/Q4wHg5ZBu2aka1waqCfFMqCffUAGcl6nlaox4u8vGcF461aYFDzU0XpsuelygvUGw+GlA0BT9gKtetu3K3pnt138baY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7336
X-OriginatorOrg: intel.com

On 2/28/25 16:21, Jiri Pirko wrote:
> Fri, Feb 28, 2025 at 02:23:00PM +0100, przemyslaw.kitszel@intel.com wrote:
>> On 2/28/25 13:28, Jiri Pirko wrote:
>>> Fri, Feb 28, 2025 at 12:58:38PM +0100, przemyslaw.kitszel@intel.com wrote:
>>>> On 2/28/25 03:12, Saeed Mahameed wrote:
>>>>> From: Saeed Mahameed <saeedm@nvidia.com>
>>>>>
>>>>> Port params infrastructure is incomplete and needs a bit of plumbing to
>>>>> support port params commands from netlink.
>>>>>
>>>>> Introduce port params registration API, very similar to current devlink
>>>>> params API, add the params xarray to devlink_port structure and
>>>>> decouple devlink params registration routines from the devlink
>>>>> structure.
>>>>>
>>>>> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
>>>>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>>>>> ---
>>>>>     include/net/devlink.h |  14 ++++
>>>>>     net/devlink/param.c   | 150 ++++++++++++++++++++++++++++++++++--------
>>>>>     net/devlink/port.c    |   3 +
>>>>>     3 files changed, 140 insertions(+), 27 deletions(-)
>>>> For me devlink and devlink-port should be really the same, to the point
>>>> that the only difference is `bool is_port` flag inside of the
>>>> struct devlink. Then you could put special logic if really desired (to
>>>> exclude something for port).
>>>
>>> Why? Why other devlink objects shouldn't be the same as well. Then we
>>> can have one union. Does not make sense to me. The only think dev and
>>> port is sharing would be params. What else? Totally different beast.
>>
>> Instead of focusing on differences try to find similarities.
>>
>> health reporters per port and "toplevel",
>> just by grepping:
>> devlink_nl_sb_pool_fill()
>> devlink_nl_sb_port_pool_fill(),
> 
> Sharedbuffer is separate story.
> 
>>
>> devlink_region_create()
>> devlink_port_region_create()
> 
> Okay, regions I missed.
> 
>>
>> and there is no reason to assume that someone will not want to
>> extend ports to have devlink resources or other thing
> 
> But looks at differences. They are huge.
> 
> But perhaps I'm missing the point. What you want to achieve? Just to
> reduce API? That is always a tradeoff. I don't think the pros top the
> cons here.

not necessarily "reduce API", rather reuse the impl
but it is not a request for this series, just a comment

by itself this series is an improvement, and I didn't found anything
wrong in the code


