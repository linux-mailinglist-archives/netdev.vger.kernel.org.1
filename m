Return-Path: <netdev+bounces-233427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 599B8C1322E
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 07:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEF623AA8F2
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 06:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0011288522;
	Tue, 28 Oct 2025 06:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ytcx/TKz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C13B261581;
	Tue, 28 Oct 2025 06:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761632768; cv=fail; b=jS7eEirjeUEKhmVbdIMk/jrnKIVQr1t0g+f5t+V5Kgmt1qz07DUwQnTzo9V4QjLzd9BpptS6No5oE7DV/1J1y4PhtBqw5u6wLx6ksD8NRBG8nxNE85v9PqNsRFZATztaveI38+f4XHcz0HHAzi9+OoaiVsliLaUAz/fMcCinQhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761632768; c=relaxed/simple;
	bh=DaiJwMj66Tg7jf7L7zynmHLAMOfbasVGvVYvmnvQ1m4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=oCYqu1PR/Ywz/jP4Vjw4a7B17N7SYUqUd7889Eu49NgPhWqPf8GiEByI3s+13NvDE/TMqh3j2tF+xXY2/vAl1qZk11iHUb87qzs5vI5jS+DiEEBgjDHIzGS4TE2HlDm84d+bepldEiYcnY3XQz+zOtMOhnaSE8plWAgkKsVJbYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ytcx/TKz; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761632767; x=1793168767;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=DaiJwMj66Tg7jf7L7zynmHLAMOfbasVGvVYvmnvQ1m4=;
  b=Ytcx/TKzYSgwQGemhqyrFNe0Xff92dPBukjfENqeJoSVR6qR5gnSGbJ8
   cR/kV0caHrxm2PI0SzbpzklSX0rKjZSlltvDzK9pzX388+UQE/akttxee
   Fw65rfeMQtzbqsvAiYI6wMR1i6zCCQKFZMau5f4gIa4c97FUuzMG9pHyP
   dfpFX/L/o4vGx6v2p/ABFgvPNQw7ktUUMr5Gb3pl2/3e/UZnhNim3OuAH
   1XrPHDm/z8mDi5GJ9uWYlxL9izNdmVosQIJEPerLLxFsMYdWB9bCqMsJO
   0dYCzmNqBjfyiIceJ+twQ+hUKAL1jaGyU9zn8iy25XaFKkkhwR2eQTz++
   w==;
X-CSE-ConnectionGUID: mM5s4W/2TWGEx/G+kcwhSQ==
X-CSE-MsgGUID: /Jnc0crSQW2Jkoo0wlLbpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63622879"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63622879"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 23:26:06 -0700
X-CSE-ConnectionGUID: ggTc59E7QJWjerfpX4vnbQ==
X-CSE-MsgGUID: zPezYbl+SK+B4Brg0mumnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="190457444"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 23:26:06 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 23:26:05 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 27 Oct 2025 23:26:05 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.64) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 23:26:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NBAxNZENuIKjDZ4+X+uMtZe6Eg9+s49wMkpNRrNR40A/v/1GAOyAuodUEismfVUbbCiCMednY1C57jdJOoK0/ESIO6TXdIoWBq22Yq+XdQHTkgRo7NIRbyn7led3GogNaett9LQkkuHVHAWs8voCjXggeKjeUVSx04t8+Ib5g7yk7dRH5e87cIP4TcSI2dzY93SrJrA5TmMU7VwB4Go6aL5XYsBNYeUX5h0LYGWmtJmoahKcwSR2NXZ1jxJqROcdztGtWfw078TCj6uuTNj8H5+nhlOlrZcnvETEca9edOS2fJ1SVyMFkyP4DEJ8r4phlO1KdMu4hG5nYUs6iSZEtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/PB2tUPs8UmSFmOngs7NwAFgLQh4Qf7harZRvctMCc=;
 b=TDQt7zHkna2CwaKDwa2yH7bQgoMeBSle06QbZQZ17Uck4pKLJqEQt9VxCwfuCd5X2QqkxXgSBxSeaybCVJLZWx4YBKUMEL9991Kj0RF6+XyFaombipXAYvhADZvugJFLu6t8xKwcdGPZpl2CCRfRSMb2tAnAZnAGaFFwV+22Gf95O5ZJDF+wdzXcJZt2uWjchOx041xXsfEs4KxAf9CVm6vGZUohLV0EewG00jVdgzAebaGCiX0pvyp8Uca1qdNiuZEyeIu7pGYqJFd0ehs+eWaQGU+lOi0yglo/F6KEPtTeNuaOKrMC4ZyQrvuM9TdoejaOWF1xRkkO+bsbv6pFOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21)
 by MW3PR11MB4636.namprd11.prod.outlook.com (2603:10b6:303:5a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 06:26:03 +0000
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125]) by SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125%7]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 06:26:03 +0000
Date: Tue, 28 Oct 2025 14:25:53 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Eric Dumazet <edumazet@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
	<netdev@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [net]  16c610162d:  netperf.Throughput_tps 17.2%
 regression
Message-ID: <202510281337.398a9aa9-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU2P306CA0025.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3b::16) To SJ2PR11MB8587.namprd11.prod.outlook.com
 (2603:10b6:a03:568::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8587:EE_|MW3PR11MB4636:EE_
X-MS-Office365-Filtering-Correlation-Id: 660c68fb-d9a5-4dfa-8ee5-08de15eade46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?Jfuc/wFllwZ7kckIEB3LiAGLfe0JYdbm3CEcTW2XIVZ3jfktRkxx4bvd1B?=
 =?iso-8859-1?Q?erZp+HwtyyUtH0BsLqnTt5SI1unWIuZtoNMkhxPkEmCaKkfb/o3lLmuyc9?=
 =?iso-8859-1?Q?MkuUu2kTP0WHwxssy16XXNmWvtP1uxWcpUAqKTrWy9aQ/M9lUr1jRirR+v?=
 =?iso-8859-1?Q?wouWs/7iSe4TRBDYtg1j2zjyj+OHUJOWd/GzFJQV4kMbI6nAiaL3pk1f22?=
 =?iso-8859-1?Q?aQjiRr3WAc1WrZIbw/2+qDTWIGH9hRcyUKZlJ+1wnhDkcNAVlHBS2LkGmG?=
 =?iso-8859-1?Q?9WIpUBxTtFyY0ojZ+hJkI7D3t4p4C/RJAmuU5ZS4emrKIFH+2wpPgD8KsW?=
 =?iso-8859-1?Q?+SVlcZe8R4dYwloR7gIr9I3Oyh8wvP3vScZY8a6lPHhu3YIx/jdBssGGTo?=
 =?iso-8859-1?Q?P4axfZ8zgUK1+0SBVMWOOu5/MeSDAXgOnB9NAPDFUYxS8XTvad6mWg3SJw?=
 =?iso-8859-1?Q?obB6zTjMZQevtelHx9ZZS8NNKbt6BGkCW31wMMJf8EBa2BPt6a7JOmA0Uc?=
 =?iso-8859-1?Q?lSNdCTifNjwAZbjyqh378tRBAGq2CzzL0/NiChueiNowGMoN3rHDojb8si?=
 =?iso-8859-1?Q?rhoow8/R3rrqkjPpKBf/gkwaNQmt27JYcdlrpHDsfNkFTv6oimx0sWYJA5?=
 =?iso-8859-1?Q?J9RmBt7GYvsl3JHcze/3adzWxKbnGRG3qfdbdNHVblMhJTOMzjPTCzfT1i?=
 =?iso-8859-1?Q?/J47Cy2sam2uLOpjNMqP3LMwybM4j34miX5NMtLiG/eW0t2c1fWV8IlogZ?=
 =?iso-8859-1?Q?Vbbs+g26UBuoY2OmIep5sruPv1WS7yHbwaGDGEu9KbAr/dUREEyiQ7oEw+?=
 =?iso-8859-1?Q?M4h5jrw3QjF80uV8AZDQ4aQELWrSyhzheHT1fi87dvJtWyOVMdu6QKfvvk?=
 =?iso-8859-1?Q?xbXDVXJfFoOy2UyEfkLbJXsObLdu1PdwGjokpYtxdaiM9AWPIJ4Q3fiKl0?=
 =?iso-8859-1?Q?MUi+iEIlY8+sITIkZelr+0OhQWbxqivBvKe+CXTiC+X3Lwx0A48HKfPJLB?=
 =?iso-8859-1?Q?b3DRlux0fpew/snRxV/MbcIX9MIYt9ovonLQ7Y2Lq/guiSQc6dkAKGGHEG?=
 =?iso-8859-1?Q?+aru7fbFQ64a0z16Ai0i4357JhQN79EQjgp/Uf3CXESy7al6e1ZROaWHXK?=
 =?iso-8859-1?Q?xjF+5u31EeUYmFMjbxevrdrZizlvW5XNREHKZgXe13LzQVZ0vpgDFBqlBd?=
 =?iso-8859-1?Q?B3kYwSCxJAJDe1qrbPDHX9jH/JZO4mUedtsI0Vsl1Q/e7FphXxlv0ClWN0?=
 =?iso-8859-1?Q?qZSfMMDWXUW/nJhm9WVYx9pEnsen9kM0yOyQr7UEC25bJstwcjE36u5iF+?=
 =?iso-8859-1?Q?Wn1rufdJkSSLs4+mKJCya2623RctA8Q+pSzDHYiUYRJKW5UUknd3yT3SFT?=
 =?iso-8859-1?Q?VbpwbsbpGtuQACR8hKTJw1mIIvsCjqTSC2/E57Zr39cxpwcA1eLz9yA0Tz?=
 =?iso-8859-1?Q?QDmkNQKADRKhI/7meZ2fmOkyxubYcDCpDNRxcWN/Ol1BvE8sKletBRwCso?=
 =?iso-8859-1?Q?nXDsdJDS3+ntKvc1Y3L43q2j0byuHydaQf9S1fsZH/Kw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?wIgpABSyTLC/2qq8HteL8XevuIkmV3SpLnn8VZB8kpWjieKw3q4Qj9/o/0?=
 =?iso-8859-1?Q?+07FOlPG6q1VvH+ZECut/m/bW8zLVMKh6cIBFKQDpLabewIS1+1V4oZd8r?=
 =?iso-8859-1?Q?vgpA7AJRLPoPVPfl7rlU/slKlV5xLntM1Hb6HX4zLYPOqUIAJXBy1g0aSr?=
 =?iso-8859-1?Q?bJeqb9qnlNAXXoz3bWHvjhtaY+brPw5q4M78QLeZqwRB8LQVQnBj6Hm0vy?=
 =?iso-8859-1?Q?BAvjuAKBxcDC5opZm/1lCD3N1EInj95l/NT8QS27/hTLF/KRV9bf4mA1Ro?=
 =?iso-8859-1?Q?nR4mafQ8LsJfyjuA03sHCfQRt741pT3hb0zkz51co1qK3h1SO84AsB60ek?=
 =?iso-8859-1?Q?jO+40brPhzS2/mdgchOMmABAadXjDz6h4dU3M/JhPR39ijsYoVgAw3N3cP?=
 =?iso-8859-1?Q?zFxkC61gAg75+l3GcOgoDCqAmAbZzh+2mz+0Wau/mvIUdgeS22MDhkJ9YA?=
 =?iso-8859-1?Q?0xaDaSBHygKLcsKKc3szo+ky0F1dXJuw5ccnl55FcaCXPflQQmqVFNzcn6?=
 =?iso-8859-1?Q?a7A1waOd83UAdqFzszgHZXVdadjKtM59BS1PrfVoS+fDGz52dgy4+Cua4i?=
 =?iso-8859-1?Q?iCVBvPSa+GP3BqZ6BcJoXhPAd1y1NDji0t8qHuoF87ENMnXQ9EARsb+o1A?=
 =?iso-8859-1?Q?nSDMVwV9Fy0ia07sKMEW6Nd6qjbVqwB51YL0FlakBxJrsyb6XwKt/9xI2s?=
 =?iso-8859-1?Q?csryLaDo70MkDFbICzH+oJDU/1H6/jMw3X37Y2P3kHthc6s5FV65REvTwC?=
 =?iso-8859-1?Q?szcNMgalmGcTXBcaVoE9LhHxgwVePvGDJe5ztHn7SkS2F0+3q1pzTn+LvI?=
 =?iso-8859-1?Q?zu4X1AMO1mHh/sF8wjrHhOqysnjURGFMEpgnvehe4rpFllSDsTurGeECEA?=
 =?iso-8859-1?Q?+PTn6ENrW+wUaHf6AQHMZTatPC9daxVcusW5Gx2CANc6GGWVSJFFUZLXIx?=
 =?iso-8859-1?Q?586j+oFW3a0EzT1iBSFFDiXLv6jOOvUKHhJuoV/lBXLoKVptua7LviT0oQ?=
 =?iso-8859-1?Q?JRttYnqhF45LJfrP3TKpClngR/zO96t9SBj/IAWQXD2RUjaJ97G75t8bYa?=
 =?iso-8859-1?Q?/pmsdbJIW50dkHKQNmTeQwMZ8Lbh6gj4iztPDJPgseT/mamnZ+MFceox1T?=
 =?iso-8859-1?Q?ScEG1gPhWPTFEue9sgIS6xjt6//N//ks0ciouz0WM3Rat4EetEJxYRvoPF?=
 =?iso-8859-1?Q?3zNH6IRaGz9EVf0XNVLtas0idgfEyd8gtcE3WmdpNvdIS69cWueGBx6bOA?=
 =?iso-8859-1?Q?DomXRCJUi7l5t7v+PBEMbQbGRTP7y83KdxMb4bge8ReFpkR1c14TjC4ig1?=
 =?iso-8859-1?Q?3+b/uoIQcvE4/T/sZ82Ro0M3fM6s6v4QVIZPrNw6kCvX3/7+E9YAD4R4EU?=
 =?iso-8859-1?Q?vywL/ML6STF15pti8G0K69E65K54sN62tEsDCY6b0GfunLVRbU13GYpl45?=
 =?iso-8859-1?Q?Y9uKYMxMGiVaNp9Gg/jV1XY7TvuT3dFkavSDdjFuT7SmOdtYVzDckIPOnD?=
 =?iso-8859-1?Q?uIYPRQ09TvuTTjvOEMEdCV06Rt/OVVkePfOm1mID4RdjZRVf5+iCIIbRTt?=
 =?iso-8859-1?Q?YJeLW75ZrpC9kGBTPwkZwQNzN57qhyPGQ/oLDs3blBj2KJe6M4QkamqRiF?=
 =?iso-8859-1?Q?lGv7lykxP4H29xcGYxM4LY91ZC5zARAJG5HyItU4jSBSGJlxOT6R25GQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 660c68fb-d9a5-4dfa-8ee5-08de15eade46
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 06:26:03.0177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VxyrdD3XdDAoZBdacFdT0lnMyYBt+oyGzMpD+bViVQ11ciIidF5SUqlQkbRZ4IJhKiWLMks6ZyVEth4mKbuDmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4636
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 17.2% regression of netperf.Throughput_tps on:


commit: 16c610162d1f1c332209de1c91ffb09b659bb65d ("net: call cond_resched() less often in __release_sock()")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[still regression on      linus/master dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa]
[still regression on linux-next/master 8fec172c82c2b5f6f8e47ab837c1dc91ee3d1b87]

testcase: netperf
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 192 threads 2 sockets Intel(R) Xeon(R) 6740E  CPU @ 2.4GHz (Sierra Forest) with 256G memory
parameters:

	ip: ipv4
	runtime: 300s
	nr_threads: 200%
	cluster: cs-localhost
	test: TCP_CRR
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202510281337.398a9aa9-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251028/202510281337.398a9aa9-lkp@intel.com

=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase:
  cs-localhost/gcc-14/performance/ipv4/x86_64-rhel-9.4/200%/debian-13-x86_64-20250902.cgz/300s/lkp-srf-2sp3/TCP_CRR/netperf

commit: 
  abfa70b380 ("Merge branch 'tcp-__tcp_close-changes'")
  16c610162d ("net: call cond_resched() less often in __release_sock()")

abfa70b380348cf4 16c610162d1f1c332209de1c91f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      2.80            -0.4        2.43 ±  3%  mpstat.cpu.all.usr%
    199581 ± 96%     -75.4%      49072 ± 64%  numa-meminfo.node0.Mapped
   6583442 ±  6%     -30.2%    4594175 ±  5%  numa-numastat.node0.local_node
   6709344 ±  6%     -30.4%    4672973 ±  5%  numa-numastat.node0.numa_hit
     50277 ± 96%     -75.4%      12383 ± 63%  numa-vmstat.node0.nr_mapped
   6708267 ±  6%     -30.3%    4672365 ±  5%  numa-vmstat.node0.numa_hit
   6582364 ±  6%     -30.2%    4593568 ±  5%  numa-vmstat.node0.numa_local
    224.83 ±100%    +224.8%     730.17 ± 36%  perf-c2c.DRAM.local
      1438 ±100%    +132.4%       3343 ± 11%  perf-c2c.DRAM.remote
      1569 ±100%    +115.5%       3383 ± 10%  perf-c2c.HITM.local
      1089 ±100%    +121.1%       2408 ± 10%  perf-c2c.HITM.remote
  14776381 ±  9%     -21.6%   11587148 ±  8%  proc-vmstat.numa_hit
  14576750 ±  9%     -21.9%   11387471 ±  8%  proc-vmstat.numa_local
  51492399 ±  6%     -26.1%   38054262 ±  5%  proc-vmstat.pgalloc_normal
  48277971 ±  5%     -26.9%   35310227 ±  5%  proc-vmstat.pgfree
   2874230           -17.2%    2379822        netperf.ThroughputBoth_total_tps
      7484           -17.2%       6197        netperf.ThroughputBoth_tps
   2874230           -17.2%    2379822        netperf.Throughput_total_tps
      7484           -17.2%       6197        netperf.Throughput_tps
 1.351e+09           -13.7%  1.165e+09        netperf.time.involuntary_context_switches
      9145            +7.8%       9855        netperf.time.percent_of_cpu_this_job_got
     27055            +8.4%      29322        netperf.time.system_time
    927.87           -11.1%     824.49        netperf.time.user_time
 1.975e+08 ±  5%     -28.2%  1.418e+08 ±  6%  netperf.time.voluntary_context_switches
 8.623e+08           -17.2%  7.139e+08        netperf.workload
   7908218 ±  8%     +33.3%   10540980 ±  7%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      2.27           -10.2%       2.04        sched_debug.cfs_rq:/.h_nr_queued.avg
     11.92 ±  7%     -18.9%       9.67 ±  8%  sched_debug.cfs_rq:/.h_nr_queued.max
      2.33 ±  5%     -13.6%       2.02 ±  4%  sched_debug.cfs_rq:/.h_nr_queued.stddev
      5.14 ± 27%     -50.8%       2.53 ± 51%  sched_debug.cfs_rq:/.load_avg.min
   7908224 ±  8%     +33.3%   10540996 ±  7%  sched_debug.cfs_rq:/.min_vruntime.stddev
    245718 ±  4%     -10.4%     220184 ±  8%  sched_debug.cpu.max_idle_balance_cost.stddev
      2.26           -10.2%       2.03        sched_debug.cpu.nr_running.avg
      2.33 ±  5%     -13.8%       2.01 ±  4%  sched_debug.cpu.nr_running.stddev
   8021905           -16.0%    6738879        sched_debug.cpu.nr_switches.avg
  10163286           -20.5%    8082726 ±  2%  sched_debug.cpu.nr_switches.max
   1494738 ± 14%     -50.1%     745542 ±  9%  sched_debug.cpu.nr_switches.stddev
 6.417e+10           -16.1%  5.383e+10        perf-stat.i.branch-instructions
      0.52            -0.0        0.49        perf-stat.i.branch-miss-rate%
 3.329e+08           -21.1%  2.628e+08        perf-stat.i.branch-misses
  49601635 ±  8%     -15.1%   42090142 ±  6%  perf-stat.i.cache-misses
 2.238e+08           -11.6%  1.979e+08 ±  2%  perf-stat.i.cache-references
  10160912           -15.7%    8567209        perf-stat.i.context-switches
      1.74           +20.0%       2.09        perf-stat.i.cpi
      2679 ±  7%     -22.9%       2067 ±  3%  perf-stat.i.cpu-migrations
     12544 ±  7%     +17.2%      14707 ±  5%  perf-stat.i.cycles-between-cache-misses
 3.464e+11           -16.3%  2.898e+11        perf-stat.i.instructions
      0.58           -16.4%       0.49        perf-stat.i.ipc
     52.92           -15.7%      44.62        perf-stat.i.metric.K/sec
      0.52            -0.0        0.49        perf-stat.overall.branch-miss-rate%
      1.74           +19.4%       2.07        perf-stat.overall.cpi
     12209 ±  8%     +17.3%      14320 ±  6%  perf-stat.overall.cycles-between-cache-misses
      0.58           -16.3%       0.48        perf-stat.overall.ipc
    122980            +1.1%     124361        perf-stat.overall.path-length
 6.398e+10           -16.1%  5.367e+10        perf-stat.ps.branch-instructions
 3.319e+08           -21.1%   2.62e+08        perf-stat.ps.branch-misses
  49465671 ±  8%     -15.1%   41971976 ±  6%  perf-stat.ps.cache-misses
 2.231e+08           -11.6%  1.973e+08 ±  2%  perf-stat.ps.cache-references
  10129507           -15.7%    8540638        perf-stat.ps.context-switches
      2669 ±  7%     -22.8%       2061 ±  3%  perf-stat.ps.cpu-migrations
 3.454e+11           -16.3%   2.89e+11        perf-stat.ps.instructions
  1.06e+14           -16.3%  8.879e+13        perf-stat.total.instructions




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


