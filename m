Return-Path: <netdev+bounces-251972-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PXDEnMCcWlQbQAAu9opvQ
	(envelope-from <netdev+bounces-251972-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 17:44:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E325A126
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 17:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71F07A8A7C5
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7239D27703C;
	Wed, 21 Jan 2026 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lWzZ4sA5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2F02309B9;
	Wed, 21 Jan 2026 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769011243; cv=fail; b=UJgoNakGdf4muhJqFjtyLmiuMi/mYmo3KDr6XOkibhK1VXRWhdv8uKqwrxluUTugd4gMuy2y94nIYX5+fbbh7GThlikKq1vu/lJGuPFPwP7hxLB+5jUcFFzkD4sfcsAU9YKPVDkn4vLWBDP/neuJcOn+cpHxc0vraUEJu2dRVmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769011243; c=relaxed/simple;
	bh=NFlF483DoWNWDULQKp9D824hnq7dWnhKUjqUaQSlh8I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Skr+oyyCAVFBNh9UADAxGtXubcfodjK1mcqrCNEV02aa6eVaxnV/HNOayGvU48/OQmCr7K9yUp1A0RHWJMIb5BLWtTqRf/UWz/88Gqpi4BQ4Gt3/SrdvpVgHVIAcjCJ6qj5R6qzQ/1IrG20PyFSA5+Ya5gTBGMC4F5Lycilgt9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lWzZ4sA5; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769011241; x=1800547241;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NFlF483DoWNWDULQKp9D824hnq7dWnhKUjqUaQSlh8I=;
  b=lWzZ4sA5qDRaCRr3klphyZVckTIkRyCUxjv7yo19QOj5OhedyQ6Xa7Bi
   wMP5swvCw4cIby2DiqS6WUqqmbjmDyv/u0uBT39ZQfBshxyzesqc9Y27U
   wsMTgFtLBiGienxtdmynK1UjzdBCdJ63MYi6aJ3w23jOzfqR/zfcUHfjs
   z/32W3lKT7VLhmqOT6btEFpo9pU4EK6ddgr6qZspB5GYSNFhle1kM8EW5
   /crufF68xuYbQLF1tPao3MUCZ6PGR8mlOV8SyCXX0vt+c76OYDGPCboWd
   7p2gDlKzFX0RBSdK7QB4be1Hndt+Qy3p8TlcKNdDiIVPPJ+pR9PWl1xdU
   g==;
X-CSE-ConnectionGUID: hiroa9GcQZKYhGIuiaB4fA==
X-CSE-MsgGUID: 1Jv59ZCXSCG+1gjDr+mphQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="92907506"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="92907506"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 08:00:40 -0800
X-CSE-ConnectionGUID: ZusGy3lYTLWLqD01i2AkxA==
X-CSE-MsgGUID: 75xlmu14Sker3II0KvVqHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="206389681"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 08:00:40 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 08:00:39 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 21 Jan 2026 08:00:39 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.19) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 08:00:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xGC9ZDHoAAvd24+vD4+csVDVEl3A96sVSLPaXKx/QDDOsdSTbt5TskdTXbdGUH2FghdSz5XQjOK/5qgt4Jq5iV4awQnpDigftDHWKZ4yXqvUNHeqSyFPJWyEt5cZxKgJZsLtYoSxH/XictP+FO4SiipcvId/+XcyNGCgKkRR2qECZKA1C/XuQbnBdtIy5Mfdlt4pNV+TCWjWtUqyBadKroDOJsuVRQVYtOKjPF85cKIcmoQQgs2+nLERIi08q6hQ+a8E8e2dMvkCLmHDUT+RIpHeNsciParb3/+f2ukiLlcoOXcg3Lk17qufPlrIkdUbQozUpN7JyzCSC38p7XcZAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WrY6EvOkR3u3jLi7LqPLsZAihUZZx+RuwpUOS9ck2pQ=;
 b=FZVLm3JoiUvTAgCI7pXB3oRcBwuEWwNxJXrpGVx3VbatG+UMKsvBdvdh/RUfgOLbUMI5FQmxB/yJWTaYpJ2k3mXe4UEQzXikPvVqZpNW+d7HW+tJXDTjZdpabH3K21frpKYDXYkcefU8TCm642BAHD4yT+nZIgbi3iK2CSnqAryiOlqYk2XdxpmhMLn9wipFYHIWnxoaowcmi1MG4knshcL8eC4/tWFKJN1K0uXIj4zlK9qdFRwp7jaKFxGJ2PE+YDE+WwmcJqDKJVrz+EDX+RWOQCUij3yoay0i+Lqn155EEzgZ/qep1gyoBusad5Fm49+lfHitFKzQ7ZeplMqi2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ5PPF867D7FF5E.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::83d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 16:00:35 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.20.9542.009; Wed, 21 Jan 2026
 16:00:35 +0000
Message-ID: <905f01c8-6208-4baa-9507-87ba54158779@intel.com>
Date: Wed, 21 Jan 2026 17:00:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next] ice: fix system hang on `ethtool -L`
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, NXNE CNSE OSDT ITP Upstreaming
	<nxne.cnse.osdt.itp.upstreaming@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
References: <20251204155133.2437621-1-aleksander.lobakin@intel.com>
 <20251204155133.2437621-4-aleksander.lobakin@intel.com>
 <c507379f-07a9-44fe-9679-277d618c0e04@intel.com>
 <20260120173405.82147-1-aleksander.lobakin@intel.com>
 <IA3PR11MB89860B4F0CF5B396C86747D2E596A@IA3PR11MB8986.namprd11.prod.outlook.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <IA3PR11MB89860B4F0CF5B396C86747D2E596A@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0046.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::11) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ5PPF867D7FF5E:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c03af59-f054-4dac-d70e-08de590635f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGdFaXBwaWdXTXpwTkVxZURwTkNYaXhTSTI2cGtBcmJZSEN2eFQvaEFLMlU3?=
 =?utf-8?B?WmNybVNxSmQ2dzZ3U2tNVmJnc3hhakV1RVVKUXZoZjVpWklaNEpHaG1BWVQ2?=
 =?utf-8?B?c0dsc3Q1U3YyVGRVT0hyWEFON1Bkbm0xVnlldElUQ2xlR1paeGQvRi9rdGdU?=
 =?utf-8?B?VkhuWEpoR2JlVEZCYUFNcnlSaGVtQnN3MEt6U0hEc01NZkMxbVkvKzlxRlN4?=
 =?utf-8?B?bFZqN0YrdkIvOG14cjJoVnVBd3lMeFhKWjhTS3RNc3VzWFlUeGJvSW9TaExw?=
 =?utf-8?B?UHZlK1k3bTFrSmpFZ2lwbHRzN0pTR2gwRlNKZXFDaCtUdHRuR3RwaG0yK2RU?=
 =?utf-8?B?M1MvSFdMSm5jZ21xemF2aHZqN0lUcG92bGxWRDh5YmdrN2pGYUE2Yk5hdFlr?=
 =?utf-8?B?T2RaLzRVbjJZRmRnNVhmL25zaW03T2tWWEViTDBkNE51TFVKZlVqWC9CSHZ5?=
 =?utf-8?B?Sjk4cUZGbXY1NlNrRTk3b3hJZXVrN3ZjcEUzcU9aeG5aRXY5bnU4QkxXMnNL?=
 =?utf-8?B?KzJjQ1Q4dTAzZDVuSkZHL3VWNXhEUUtEMUx3YmZnSWc1dUU1dm9PbmVPNC9W?=
 =?utf-8?B?eUp3UHNidm8yM012SDVjWURUYzZtK2t2UWwrb1U1NlR3YkhINlNVRXFIQ0hO?=
 =?utf-8?B?c3JWT1k5RDJyNWcybm0wOGpXaW5XMEZZOW1iNFRTM2d0UzV4c3BrQWVNamlq?=
 =?utf-8?B?RFBSQjk2Wi84K3V6cmFSMHdxYzgwNXE4OUhWOFpsbnh3dmlzUk9oT3ZReTlt?=
 =?utf-8?B?QWRsdEZMS1RiZ005Q0s1ZEt2ckFnRWpNSGpPMXA5dTQ1UnlUcHNtTFVwK2hB?=
 =?utf-8?B?WDJaTUVWVHd6ZVMySUNPekpSZkJxR3VvMVBHOGQyYkZ4RVFMeFN3dDA5TUlR?=
 =?utf-8?B?TU5Ma3dEa2pPejJvU0JxWEZKcjRWVlZ4M0RsOG9HblZ0bFZLRTgwU2hDQnU2?=
 =?utf-8?B?WEc0N3pZSVF6bW9Tc0NoYWpwSU9rUUp3RFZIVkx0bTJWS2ZOejc3TWJRemxy?=
 =?utf-8?B?U0ZIdEdJaFVxbW1UU0YyZFhMUGZSUCtwVGlJdHNaNndmSTd2eUVLSGJvcm9G?=
 =?utf-8?B?T2JsUFVldkxKMlVaLzVvb0ZheHZDM2V6RnpiR3hsSy9FUjZYWUhDckZ5UTR2?=
 =?utf-8?B?eExVRzNWMkkzRjlvejhlalRpSERadjFVeFdnMTlMaEgyVzJGcWxOc2NuN1VT?=
 =?utf-8?B?dnRTNEhxSnNzWkRJMW15MFBaSEpJV3dsQjJFejhxcjJ4Y2R0Q3ZDVWFIUDhv?=
 =?utf-8?B?Si9jc2k2Zk53UlFoM09ZK3NOUzlSZTl3QmNQQVdjRVZMMzhHZU9yeklteEJJ?=
 =?utf-8?B?bUd5aXV3Z01DaTF1dmFPUGFYM0dqQ1hoYTBxclNYL2x2MTIvM2xsUjRJRUZo?=
 =?utf-8?B?a09qWHFPSlRFUGx2M1pFTWd4RmNIOU1QU0UxbzdRR1Y4bmQvZmJFc2JmdFRZ?=
 =?utf-8?B?RUFwelJtZDlRUCtHYkVSY05JcmkyQlBYa3gvYzZVbDRjTnBtaXEzM0xlcXUr?=
 =?utf-8?B?MWhaL0pCZUdpN1k2dldZbVJZeUFkUDg0cFpGRTkxdy9YYjZIUUlqZVpYdHly?=
 =?utf-8?B?RGxqTWliaCtBUS9VNzBOcTFOMFVEb1prSndBUmIzOVNNRTFseEdVWEFXeVJK?=
 =?utf-8?B?czRja1lWZnl4dE13THVjRUtrbFVVc08zU3FLNnI3ZFJ2K2NIZnErWFpIWW94?=
 =?utf-8?B?NU1rcms1MGZWbm9HRERVUTV3V01SOUk4bVYwdWtaKzYycVphNW9VdzI1Z1hQ?=
 =?utf-8?B?RXRaazhvZzNEMkZnQVZEQzBqQ1JOQzNtQjNRSWE2THJMcHFyWHkwV24xZEhj?=
 =?utf-8?B?SmdsbmlOT1EyNTJZbXZDTFNGeThjTmhMNWhoczFPMVZjNTdwMVE5Qkdpd2Zw?=
 =?utf-8?B?WDZsK3ZWL0RDR2s0eE5xN0R1bnV4RjdZYzJaQ3NWNk9NMTEzQm9KeEhySHUr?=
 =?utf-8?B?cFhWeGp5cW80eGNCbVI4RXdIRkVQM1R0bEtxREMycHl3TlFCc0lYWWYxczFU?=
 =?utf-8?B?WExDajNkd2w4RFZZOW1YbWIySUQydWZHK1F6OEdCN29NR0FUeWMvWndjSDBo?=
 =?utf-8?B?LytNaVFMbDdmL1R0UmV0cG92ODIyMm9tSVJkQmd6N0pnZ05SMXVDM1B1ZzlF?=
 =?utf-8?Q?HbA0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1VaZUdEOHZBY0l4UHdNQ0NrTUhEVlg1ZkZJaEpMRG4vUUtZNDhsQmd6VjlC?=
 =?utf-8?B?d2RBemhBVTZnNzU1YmhFTm83c2lFZXZheDQwZU1EVCtNbkpNVGRuc2p6UUFi?=
 =?utf-8?B?aHprb2FEUElVam1rRU92cWtDUVo4MHIxaTd3MnQ2Nm5QbldKb2xDTHpBNVBx?=
 =?utf-8?B?QmdyblhqMGk2SVVPMlkrL1RJNXc3MmxTUDg3U01wUURlRTdudVdVaHIyWStB?=
 =?utf-8?B?MSsvWmVsV0xWR1hycnByQ2VBd2QrMXhoQVRVODNITUg0eVlUTWlFY3BnM1lS?=
 =?utf-8?B?bEl5aVRjWGErbm45QmNNMnVyMVY1Wmk3M3RRVDl4R0NDZE9PRUIvN2g3MkhI?=
 =?utf-8?B?cGcrUEVXVE9qdjJuTTRINXVidWNKRVVZMWdneHNuTy9GZm51TWl2c0pNOVQv?=
 =?utf-8?B?VXd3alRSZGlWQ1VlNzNNblFXWXMzUTZaekpBRWlzSExVaStxakJTaTBybkd1?=
 =?utf-8?B?T0tpcWhkUUoyUlVzT200VWsxcUNaQ2hZdTY4NWhiTzc5SmJPVGF1M0I3ZFNT?=
 =?utf-8?B?eUFzR2ZMOEhKTUpzaEdXc2hXcnR3Y2hyNEgzRXdSMkNSSFJIZmFST1dEWFNx?=
 =?utf-8?B?dWY1VWQwUCtxOHFENWRMSVlaYmdHTjB5cmNjdG43RDVXYUdVY2pORFZYeENN?=
 =?utf-8?B?M3RlTXZIWVljMWhwS0FpTGMvTjUyQVY5bmVKSFBKVkl0Y3o3Rk9zcWlCUE5p?=
 =?utf-8?B?OWV5dGM1V1QxR2YvNXh0bHRyV1NhNVduV0dDb3JkTW9qVXVUOTJybC9uUWZT?=
 =?utf-8?B?TTlXVDl2K0lBZmt2K1crQzN1MVp6bDk3MUlQWTN0d09MTDBYdFBNTlhSa1o2?=
 =?utf-8?B?ekRaWUk0SzhrY2cwZXNGK2xwQWo4Tzg4OG5nUUFlZHY0VmFOY09zYWhnaDlF?=
 =?utf-8?B?VFB2eVU5d2ZnYUpMQmlYSEVjNEoyM1NvWU44bFJYazZ1Wm5paGhPbm1CRWhP?=
 =?utf-8?B?dWlGSVBYMHF0VS9jR2lKd01hRVIza1hyZlFlQkUvOTBYdGlvQncyYkRYMXAx?=
 =?utf-8?B?NnM2T0dTczhyYVcvYTBWOUNHZG1kTWRuN01vWHludFhEdVdYUUkvTzdQM1ln?=
 =?utf-8?B?UDI5bUVyTzNOQm9iWVcvQk5oQjEzUnM3aHJvRk1EeGhEMkxRTE1LbHZiOEZB?=
 =?utf-8?B?V0FJTkttV2l3d1hXNHg3RHBWSm4zUmJlVW0zUDFUbmJRN09YUFpEVk9Xc2NG?=
 =?utf-8?B?TjdaOW5BejhPdkJESlRUN0tLNU03dW11alhIMkVsdHBwcVUzUEpQdGdWQmpY?=
 =?utf-8?B?NTRWTEhtaWs0ZEhGOVZBcDR6dFhZcFN2MldFYmRRWHY4V1dmUEhWNDA0T0s5?=
 =?utf-8?B?V2tLTSthZk4xTnVYem01NmNMbHVybnR2ay92R1pzTTNmQXB2dUxSRDhSRkNK?=
 =?utf-8?B?b1YwMjB6ZlhsVklyNTgxNEp2b3RvRm5SQlFLYnUzUC91ZzBMcExEZCt6WFBn?=
 =?utf-8?B?b20rQUpEbFY0ZjhTV1p2SlE5a1h0T1cyMVFpQkdIUXdwcVZROE9Gak9SV053?=
 =?utf-8?B?b0ZGeithcTRFcDkxaHJLeFJwU2JONERaWklWd3VGR045cGpNUnNxcUhUbktl?=
 =?utf-8?B?ZGlHeWVlbUtmSlZQS21lckFDMlp2clptLzlUcnRhaEQ3WTk5RFg2TzdjU1RZ?=
 =?utf-8?B?dzRrQjI0ZWQvb2xJMEtlYThucWlmNERHdGoyODR6VTdQOXk2NjJ5RFhoYXVw?=
 =?utf-8?B?TnpHQ3luUkY5emI3VklXZGE2cCtiYzIyNWFlZStYaHd3S2tyR01lZlVpa0hX?=
 =?utf-8?B?VDArMmVQRzZ3SWRtNDRlQmNJSVJkMk1xNXBFWUN6UDF3UFVKdk1Va1BqNklk?=
 =?utf-8?B?ZTJlUU5jN2RhNWZCdHBFMG53WUpiaU1DZDRGMDk2d0E0Vk93YnhDc2dOZVp6?=
 =?utf-8?B?S2sxc3lhVjVzNFRZYTgxVVFTRVNxUU5mNUozNXFYOTVrSnVhNmRlWWZtaGFL?=
 =?utf-8?B?VWdtRHdSeG5Zc2V4M0NhcUtmYXZYUkhoZGovdUFzbUoxUitvOU1QT0VzUjQ0?=
 =?utf-8?B?TGZlQ09qNnBtY1owUGxzWmplZWlPUlRqSWhEQ0IvSUJpWjN3dzhIbGhCdm1w?=
 =?utf-8?B?aFdnV3c1ZXBPa2I2SjVFREdWNk8rN0I0dzVLT2VKTlZSVkxvU0Z0TGhMME9T?=
 =?utf-8?B?SlNrRFNZQ3QzcjdydTNXRWFobVdrWURrV3FnYmhObTZMTWljdmdWaFNKc2Jx?=
 =?utf-8?B?dHJDc0tlZmRlNTU4RDl4d01MTUlzV3hobFNOZ1pKemY2eTlFdFh1cm9pd1I5?=
 =?utf-8?B?OUxuNXZLRE5TWWhWQUZaaTRTcmVqNS9qMzlWL2hkVEVPaTcvZjBZZi9wdHFW?=
 =?utf-8?B?cXJnbDlUd0pEMmxXRlBXRE90TUJ3R1QxQUxYOHpCU1FyZUl6aThpcnp3L3E3?=
 =?utf-8?Q?j0jILqkwegnMw2MM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c03af59-f054-4dac-d70e-08de590635f2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 16:00:34.6297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZgZFtaQzo32wjnMHxJRffScQ7xMpEH/kfjQR+utoI6UZlCuSXZxvwb95L4nPdaA/r+89AfyrUQ3Lzs3HfCrHnpCsoigbpplpU0CFrnVwRNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF867D7FF5E
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-251972-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: A6E325A126
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
Date: Wed, 21 Jan 2026 08:18:47 +0100

> 
> 
>> -----Original Message-----
>> From: Lobakin, Aleksander <aleksander.lobakin@intel.com>
>> Sent: Tuesday, January 20, 2026 6:34 PM
>> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; intel-wired-
>> lan@lists.osuosl.org
>> Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Kitszel,
>> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
>> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
>> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
>> Abeni <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Keller,
>> Jacob E <jacob.e.keller@intel.com>; Loktionov, Aleksandr
>> <aleksandr.loktionov@intel.com>; NXNE CNSE OSDT ITP Upstreaming
>> <nxne.cnse.osdt.itp.upstreaming@intel.com>; netdev@vger.kernel.org;
>> linux-kernel@vger.kernel.org
>> Subject: [PATCH iwl-next] ice: fix system hang on `ethtool -L`
>>
>> ice_set_channels() calls ice_vsi_rebuild() under the netdev lock
>> taken, but ice_vsi_rebuild() calls netif_napi_{add,del}() which take
>> the same lock.
>> Add ice_vsi_rebuild_locked() which uses the _locked counterparts of
>> these functions and use it in ice_set_channels().
>>
>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>> ---
>> Hey Tony, please amend to the patch I replied to.
>> ---
>>  drivers/net/ethernet/intel/ice/ice_base.h |  2 +
>> drivers/net/ethernet/intel/ice/ice_lib.h  |  1 +
>> drivers/net/ethernet/intel/ice/ice_base.c | 63 ++++++++++++---
>> drivers/net/ethernet/intel/ice/ice_lib.c  | 94 ++++++++++++++++++++---
>> drivers/net/ethernet/intel/ice/ice_main.c |  5 +-
>>  5 files changed, 143 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_base.h
>> b/drivers/net/ethernet/intel/ice/ice_base.h
>> index d28294247599..99b2c7232829 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_base.h
>> +++ b/drivers/net/ethernet/intel/ice/ice_base.h
>> @@ -12,8 +12,10 @@ int __ice_vsi_get_qs(struct ice_qs_cfg *qs_cfg);
>> int  ice_vsi_ctrl_one_rx_ring(struct ice_vsi *vsi, bool ena, u16
>> rxq_idx, bool wait);  int ice_vsi_wait_one_rx_ring(struct ice_vsi
>> *vsi, bool ena, u16 rxq_idx);
>> +int ice_vsi_alloc_q_vectors_locked(struct ice_vsi *vsi);
>>  int ice_vsi_alloc_q_vectors(struct ice_vsi *vsi);  void
>> ice_vsi_map_rings_to_vectors(struct ice_vsi *vsi);
>> +void ice_vsi_free_q_vectors_locked(struct ice_vsi *vsi);
>>  void ice_vsi_free_q_vectors(struct ice_vsi *vsi);  int
>> ice_vsi_cfg_single_txq(struct ice_vsi *vsi, struct ice_tx_ring
>> **tx_rings,
>>  			   u16 q_idx);
>> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h
>> b/drivers/net/ethernet/intel/ice/ice_lib.h
>> index 347b63e497e7..e55b72db72c4 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_lib.h
>> +++ b/drivers/net/ethernet/intel/ice/ice_lib.h
>> @@ -68,6 +68,7 @@ int ice_ena_vsi(struct ice_vsi *vsi, bool locked);
>> void ice_vsi_decfg(struct ice_vsi *vsi);  void ice_dis_vsi(struct
>> ice_vsi *vsi, bool locked);
>>
>> +int ice_vsi_rebuild_locked(struct ice_vsi *vsi, u32 vsi_flags);
>>  int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags);  int
>> ice_vsi_cfg(struct ice_vsi *vsi);  struct ice_vsi
>> *ice_vsi_alloc(struct ice_pf *pf); diff --git
>> a/drivers/net/ethernet/intel/ice/ice_base.c
>> b/drivers/net/ethernet/intel/ice/ice_base.c
>> index 7097324c38f3..65e19815bec5 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_base.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_base.c
>> @@ -153,8 +153,8 @@ static int ice_vsi_alloc_q_vector(struct ice_vsi
>> *vsi, u16 v_idx)
>>  	 * handler here (i.e. resume, reset/rebuild, etc.)
>>  	 */
>>  	if (vsi->netdev)
>> -		netif_napi_add_config(vsi->netdev, &q_vector->napi,
>> -				      ice_napi_poll, v_idx);
>> +		netif_napi_add_config_locked(vsi->netdev, &q_vector-
>>> napi,
>> +					     ice_napi_poll, v_idx);
> If you converted ice_vsi_alloc_q_vector() into _locked, should it be lockdep_assert_held(&vsi->netdev->lock); then?

IIRC the core kernel functions check for this and warn already.

> 
> Everything else looks fine.
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Thanks,
Olek

