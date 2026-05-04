Return-Path: <netdev+bounces-284069-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7QF7Ci8g+Wmz5wIAu9opvQ
	(envelope-from <netdev+bounces-284069-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 00:39:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A950B4C476A
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 00:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7E05F3009CE1
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 22:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E80386567;
	Mon,  4 May 2026 22:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gHM9HBRt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE3D242D62;
	Mon,  4 May 2026 22:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777934380; cv=fail; b=qga8tnBx1v861RdTvMWR9GZtgByOoXU7/qj32HJtahkeoJTRfxCV8G6BzUYQucgN81QKl7/NyRko9EyXsLBSxlxL0XmOIk3YE0dtaRDHzxbaFzWEFTb5SIu2lUOqSYkWkcnVwV77uFxOx2iy0sUVY5s/DwHUF2ov9cygM3D2TdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777934380; c=relaxed/simple;
	bh=2wV95bKLqX9GHpwUo4TqTmZ1AqyPM/nwmw+s3nQXE9A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J+YWwqdGl+gLt4c37e70sH55ZcSDw3+fzYC2jen7pnnViPj2TpA/IIoI23qsmgzcnyyGG+c3xBL3PhmT/2L519FhXvOpyducX3R/lkMOM/1pfShT+O9BVZLQVgJIysh6SlHimGLhnh89RCq3PzkWrnn/UsEqIlV4RkOS9RPoICQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gHM9HBRt; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777934379; x=1809470379;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2wV95bKLqX9GHpwUo4TqTmZ1AqyPM/nwmw+s3nQXE9A=;
  b=gHM9HBRtDaQacrSCJrxYgxgS0vgqn3tHVZuAN/359llfT/IsTCWHRhTp
   FNzuZbotC10GHbn0J0OGo6IJH9yj/YI2BuQ5DmcRKWywk7PrBSUDMCGPa
   o4tb1CmL1gtmSYgj/SDQD6bPBSFYfJ5iZNMh+f+9nLkNfyDEM/WdiS5GA
   M+aKb+H2NLFmCyZIpmGWlACP2dms0RVNEZycQAPahNJdQM/QVrWtHB7CC
   O/kt83giQAJ7/oDoIo/m75leE41TACYHbm1rqDKwINV0qxPsX4WsKk7Dn
   VJPJlT8vIKGO3brmOEIO3tZmF0xzIhKkvY5NaoyyY8VrO5+7TjvLNfkC3
   w==;
X-CSE-ConnectionGUID: FOSci8fiTRW/wzu8Tu9Tpw==
X-CSE-MsgGUID: umWhyLStQbGutpuu7wB8BA==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="96226215"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="96226215"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 15:39:39 -0700
X-CSE-ConnectionGUID: We4HgRE+Sx6Fs5cmQtIETA==
X-CSE-MsgGUID: 4LESfzHXTA2hTHpoyNBIfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="231041460"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 15:39:38 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 4 May 2026 15:39:38 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 4 May 2026 15:39:38 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.7) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 4 May 2026 15:39:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lRMUCkrvM+Qd1coY1wZAniM3MGLsHztY1GO8DGQL2vydhdGrrJH4/xYUHUrF73ns6XVkr8xADsR6BvOyp2gxxrwbI7B/mJu3FPlDjjIPDxKbFRWOyct9ZqFC1fetWK6HfO9CNWBCyc4VgJoVqqUirJWJVbxjxoMgMEOFJIxWXdQLzNEmThUQZIjwRjhklBfx/JP4rT8bjCoMF35lTyROQ3kx8WF2E0QB87xPBqA/6JD2LIYQsbeiEiXobnax0NQR9gC2As+tiKWs/QUmf0b5V7UIrgDSBu1E8OE2TkNBAUn+KaHLrMpfTJlZav2AuZ2J70thqFcXE1s6hdYFJpIeQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/E0UH8f8uEeVHHaHfXeOcuhbarhd7HVunhsS4Yy79w=;
 b=ZVqaXDKzBRy9dJ7iExpfEwR46cP3Am+mKFPQkw8CMa2KIGSB8rCYAyAHy6ZDeUKz3G0y0ix6r63xIc/6dJ0j/c6K+e7CNd4zTh9gFwUDnNH8scs8iImda31DsJ6JSo3eDMPbkq7kIodoFEkESC0cJG+hjAOiT8e6lSvLMU3gerkiXWgmPDmFdCoMfp8dptkhWdE4uDS5x4zCxE9rgjJTvfCPEaAYti43xNzXUsyACWu7wASAuT7CBQTfTEXds8kMMC0laOcskFQpEudE+e+IIgnYu/L2BkzNtpr3H77fxxigydvbTfYamyWexRaDneMR4jLpRaza2PiubAb8xtfOdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7592.namprd11.prod.outlook.com (2603:10b6:806:343::16)
 by IA4PR11MB9105.namprd11.prod.outlook.com (2603:10b6:208:564::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 22:39:28 +0000
Received: from SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6]) by SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6%6]) with mapi id 15.20.9870.022; Mon, 4 May 2026
 22:39:24 +0000
Message-ID: <97261b38-3251-4b13-a106-67e4b4ecc8c8@intel.com>
Date: Mon, 4 May 2026 15:39:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 14/15] ice: dpll: fix rclk pin state get and
 misplaced header macros
To: "Vecera, Ivan" <ivecera@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260430-jk-iwl-net-next-2026-04-30-v1-0-6f27ae1cd073@intel.com>
 <20260430-jk-iwl-net-next-2026-04-30-v1-14-6f27ae1cd073@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260430-jk-iwl-net-next-2026-04-30-v1-14-6f27ae1cd073@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0015.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::20) To SN7PR11MB7592.namprd11.prod.outlook.com
 (2603:10b6:806:343::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7592:EE_|IA4PR11MB9105:EE_
X-MS-Office365-Filtering-Correlation-Id: c1bcbb2f-3fe0-4e3c-25eb-08deaa2dfde4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: xSyGJixTyAOtx9TULE+Yd+jqPJ5HKmB7A5e0wZ+oLr524/mgitMhaHvowPgGisW135QLYcuxSGQ/2RyfCPjfJmSsdTn6UtZOnt0N1SvwOK+oV4JXLvsdgOKi62f6KLMshL6Ylh4qjQ3KTNf91hl2lqTJj5K8qR7jgjGcx9T6tipO4kP2Hqbhqur+tOb6nAanzWbCVrgsUEKejv5LnctJh55o0CezKfVxo8q0seYVB20l+UQGNEEt3yVDDilaUcFOsWoojhZ7vfmk7Q/TUHJz3IctTBTxZaMJ1lVKxZ7pVOAmCEcc23rCYUPyp6p5fiP5UBo1gg2kxa4llhe1NhGGLVFI4/cZvb6/69i0c/w3ig925zRTbhSLzaXQ++3MrD+CS1zwjq9tFCcBDoi3ejXAlAAWtrXIj1c89rDVmfy0e4tDDJQVlNDA3cjJsKC0aaKl9bfuFSpBhWvl64J8VkmJbKz5bzFh4dcAwG1OfgaDARJm3zWVQUymhMtUXDp43G3DSajoN+iad4m3L5+pc8I2avX5otGNBk+ufQs6cu0vd+12tWu05Bs6ntwqC89HlaxmJP3+qxe0fk245iQVQmIqdLuhmZOXsQs84q5DCsx5jXR4RwPH+CfmlQyXIuAJbZ0wIzMLOLYjcDoB/t6l/QPn/MnjLCHOb2IPrcnCwV6+sS2lp8cA1CgHHwCsDOEVjXHf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVhQLzdQOUp6MGdEQzAya2FwbVlsamI1bVN1cEJINVRCT3dkVFJqa2Vlc2xm?=
 =?utf-8?B?VUgrN2ZCM0Vlak5ITXhNUGptWFIxaDRrOStOV1lzeTV0NWRBUEpWTWJrazhE?=
 =?utf-8?B?MEZaSWFBQS9mMkt4a0ZtUFNQVEdJK3pVdW5xTVJlOG9OcGI2OCt6NWI1d0ZM?=
 =?utf-8?B?Z0pIKzFBak1qTjRqSCtmZUd1Vm1ScHBjN0RIVVUvQ2tuc0h2b05YR1pzaU5l?=
 =?utf-8?B?QVpSbUxodEFKcnNRbGZ1eTltY3RCdUJ4RkN5SnVaQmZ3ZFJadGM2OFN5eXNH?=
 =?utf-8?B?WHNYT3lZV2VaRElUZkRNRGJ3dUZ1VGRpcFZ3c3UxQmxibVh3NDU4L042YTdW?=
 =?utf-8?B?eFZQMjBCRGZCeENuK2hxcWE1ZXRTbitIVlZDRDVoOEVvcjhqZUE1MHhYMkNh?=
 =?utf-8?B?WGZBNVFiZ1d6M2FBM29YcEtZOU5pb3hkU29xMm5wZmt4UGQxRzBEMklFb1VR?=
 =?utf-8?B?RU5aeGF5MEplY29QYk9rY3F1NTBYM0dycmxWZWZMdUc4NEQrYStCdWpzS1do?=
 =?utf-8?B?cHlCRVFraFNiRWFwWmYxMHpWMmhocTBqT1ZoMHQ0RmRSY0RTSU0wZDIyL216?=
 =?utf-8?B?djBNUENuc24wS0xzT1gzV01ZYjNIQVhTV3dOTjI4Qm1sN3B4ak94d2dzMTRT?=
 =?utf-8?B?cFZvVXFTczBGbTNiSVBHd0ZUeDhzd1czdmVzM25rSlZYa2U3SW1QQW8ra0Uy?=
 =?utf-8?B?SkZSZjdvazY2bW9NS3dmZGJFRi9zSUpvOWpwdnVWQThSUGE5b2Q1TXdmd3JU?=
 =?utf-8?B?cVRvdWJobzZBeFpwemJMWDNLZW5kM3JRZjB6cWtvMDhmZ0pvQk91VEEvaVV0?=
 =?utf-8?B?Umg0NW9yeHVzRUNsWG1JY1o2UkNab1FBSW9OMVF5c093MjBZTEovTTBpbGVF?=
 =?utf-8?B?QmVyTDVFNWt3djJHd3pBRHFxTUxCM0hEUGpIcG1HeTk4QXpnWjFjMCtDSnhW?=
 =?utf-8?B?d21TSEdycTBnWjdUMWxYcjhlbWMwSTJUVzVYVFZNV2xlRkIrYTJXV3ZCaFgy?=
 =?utf-8?B?bXFvZ2oyaUtZbEVRcE5JeTlISkswQXRsUTdXQ2RQWWpRR1cwNkN3a082U2kx?=
 =?utf-8?B?MXVKRXBlanlaSUxWMCtNeEYvdWxUZkt0cjA5R3NlTjJDL3dmdTBTbXNLM3lK?=
 =?utf-8?B?Vll6ajczSnI4Q2E3ZmRKS2FJSVRVeS81dzQ0RlUwZ2JGcHdUNys0ZjYzTlhW?=
 =?utf-8?B?UlN6U3I3S1M2eE9YUkFQQmVLTytCZFA0anVVNzlDVkRVZnQ0U1Z2Q1RjRita?=
 =?utf-8?B?SDFxODltTTV4ZmxuWGp2T29qS0xMOFFmQURwckQ4N202OVRWZjcrY1drZW5i?=
 =?utf-8?B?ck1HcW9hYWg1dCt1eFNkcGZERGdWREloMlcyWDN3QWZkL3FUUGMvbUc0ZEpS?=
 =?utf-8?B?M2FvZ2xHeEQvbFZ0ckpVbGUzZTQweDc5djUxTUxYcnVYSUZzRGpObXc2R2Vl?=
 =?utf-8?B?QXR2Nm55aFBzV2s4N2ozZzJ0MWM0L1VGYXh5ZzdmYi9UcTl1dUtKb2dvZWxO?=
 =?utf-8?B?VTJZUlNkN0MwaWUrckNYejZGZVAwOXFvOEFrYWlqTWZPWk96T09tS2tUTSs1?=
 =?utf-8?B?bWZ4ZGVzRyttVlMvUklPT29idHZMQ1h5OG9lSENyK1dOaEk4eDZDSzJyQkUv?=
 =?utf-8?B?aFcvT1BBZk5EUXZFQXJ4U1BWTTUrNENFbjJGdnFRUnFwZHNQK0oyMnhaVzBn?=
 =?utf-8?B?ejBYQjRCRStNUUdxQmd3VjNyYkpxRkhyQkIvVmhxbTc5OVNURi9ZenJZNVlr?=
 =?utf-8?B?N3BHT0NHOGVSMnZoeGt5RVNkTmJ4YStEQWY5dGpncUgyYk1nOTU1VjZIT0lR?=
 =?utf-8?B?aTk4QUR1bnR6aXVYY2JodHhsOVRxL2kzOFlxWXdnaEszaUJUOTc2UXh6UjR3?=
 =?utf-8?B?MW50TTJ3S3RVUE5kdURqNDFtbnFjbEdYOW1qN2FEcWJJeFlSQzFHc0FjYmgv?=
 =?utf-8?B?am93cnZIRWlvT1FCRUtrRjdLSWNDaGwzKzhEcUQvRFNnc3p6WkNadE56NEpk?=
 =?utf-8?B?L3ZiSG9HQW1XTHBwWEg1QmRCdFc3TW1DK0RyNjZ1MWhQSmdSMEFPZFk5STdW?=
 =?utf-8?B?RExDYzYwUExSdXlTU0dQRFlnQjhubjFWQjlSa3pKMFA0dXJEaVcvbkkvM2ZE?=
 =?utf-8?B?WEpJeDFqR3c2T3BIUEZ3RENxOGtCNFFCY3B1ZEZoRHB1YjQ2YXdUVGQ0djQ5?=
 =?utf-8?B?RUFqRk82WkV0TkpIdExJdkd5NVJRVUpxZERmWVRDOGVMbG5FQndsUzl5SkJK?=
 =?utf-8?B?enFGUlBSalI3Qkcxa25OUGtHUnB5aFdHZkNBSlEraG1NL2N4NlBOdG1JMEZy?=
 =?utf-8?B?eXdGVmJFWnZoK1B3UEttbk5BTC9vaXZBcHg5Rk5nazA1eUU5NmllZz09?=
X-Exchange-RoutingPolicyChecked: J1tykNWGVWnxZHpj8MytaSvhA2yZD5Y2hcu4X2G/ZoqDVvVedJOYR7Z+k40G826ttqYQzjKaNq4HASSJL/+mwMgzlBw5DViMQq4/2tGjNbyoZOAM9qYLhXu8wNRu52oayecETymrvz+zughcwp0pgSQZf08AA0UfXSyKMS672V/uHMw+3RJGQZ6AXRUv2CKELzSPuUilgVQhncZX3HM8wV16zDMjfrKGZFfRqX2yW2IWGwxxld7+3u9nAZrSufAFqJcin1PgsjobEaSTJmeqm1k0DC4WlFg8vltOdc0tCJSslKq+ownP241rasUYDCBZX1x25mXFa6Bg8KDpBCcmqA==
X-MS-Exchange-CrossTenant-Network-Message-Id: c1bcbb2f-3fe0-4e3c-25eb-08deaa2dfde4
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 22:39:24.4532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qFRo7tHK61b4+w0n4bPvqUG+QZe+bzVJd1aWcmjGti5ZFluexeKb38OArbLkolsvJWM9yQxSj/LV8VbYDBC2gPfw7W2w+hWmhSAGo0FIJkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9105
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: A950B4C476A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284069-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

On 4/30/2026 11:37 PM, Jacob Keller wrote:
> From: Ivan Vecera <ivecera@redhat.com>
> 
> Fix two issues introduced in commit ad1df4f2d591 ("ice: dpll: Support
> E825-C SyncE and dynamic pin discovery"):
> 
> * The refactoring of ice_dpll_rclk_state_on_pin_get() to use
>   ice_dpll_pin_get_parent_idx() omitted the base_rclk_idx adjustment
>   that was correctly added in the ice_dpll_rclk_state_on_pin_set() path.
>   This breaks E810 devices where base_rclk_idx is non-zero, causing
>   the wrong hardware index to be used for pin state lookup and incorrect
>   recovered clock state to be reported via the DPLL subsystem. E825C is
>   unaffected as its base_rclk_idx is 0.
> 
> * Add bounds check against ICE_DPLL_RCLK_NUM_MAX on hw_idx after the
>   base_rclk_idx subtraction in both ice_dpll_rclk_state_on_pin_{get,set}()
>   to prevent out-of-bounds access on the pin state array.
> 
> * The CGU register definitions (ICE_CGU_R10, ICE_CGU_R11 and related field
>   masks) were placed after the #endif of the _ICE_DPLL_H_ include guard,
>   leaving them unprotected. Move them inside the guard.
> 
> Fixes: ad1df4f2d591 ("ice: dpll: Support E825-C SyncE and dynamic pin discovery")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
Ivan,

Unless you have any objections I will go ahead and rebase this ontop of
net and submit it in my next round of fixes. I might split the changes
to have the CGU register definitions change in a separate patch since it
conceptually isn't the same issue as the other two.

Thanks,
Jake

