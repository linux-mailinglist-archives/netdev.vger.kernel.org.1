Return-Path: <netdev+bounces-217803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5899B39DD2
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 14:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93D63463A52
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749A630DD25;
	Thu, 28 Aug 2025 12:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KiKsLO7v"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4323A31158F;
	Thu, 28 Aug 2025 12:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756385527; cv=fail; b=uiZ156yILYkq++XcdAQd87yg8SLWp0H+gxIjF4oeKjmggV7jeXwhVlBR+c4YXiD+I8Z1Qu3epmJ1nLy51n7PGRzHtVV1yKd1r/zQ0UccykdrOkeutF7yUeReQd+N6vygnqnyN3eo2Y00e3W29d5YFaIe2o3HiQZWvt7xoxoYKEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756385527; c=relaxed/simple;
	bh=S2MlhtRX2hh5+GOugy58lFuwIAPFwB6wH5i04lE8YJo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=go8l9d1bgmJOcVQ0h2bl+opJ1KxSV/Aje8flaKnlwlLqwJLpj4t2yUrgMGhTEXFPZz8C2spo8WC2fxm5HSYohyYv65+8h7kHYPeaKqnhjif0LegTLdHllyOofwObMXZ0CCuoxKGnI7oC95DYwwYHf817CJmedzhNDROhtr6ID7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KiKsLO7v; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756385525; x=1787921525;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S2MlhtRX2hh5+GOugy58lFuwIAPFwB6wH5i04lE8YJo=;
  b=KiKsLO7v7ImkUJMkswIDV/13LhFRB7DGMVVb+IHYY6OuDQylFfiwoemZ
   b4o/RAszm7mUwKO3VP08F+y1BvHtw9QXh6yNPXNr1B/ANKk7GxLht4/F8
   VnkOJhg0nito0/BnZkoMTh8nSV31P6b2x12DdpVu5pbBu94jTr2XY51N9
   KplFaSIK1yWfmLLYxbqxh1ayauU7z+dTs6Q9MiTY8fjKBGkSz3cq0YlZ2
   ERPD8jX5Nu4FMPSiw10PV+aDSp/fTxk8Dh0+yHj778p8k4zfjT/edT4R2
   b4d5YcCNSbEZ/S9hy7uOqqJHaQbwrcv/ugFbR9du0OqPbEq6cSA+w4zoT
   g==;
X-CSE-ConnectionGUID: fH+XgTauSPO6JSAxx7zjvA==
X-CSE-MsgGUID: 5CdmO7dtQOiIWB3JvKHI0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="58715872"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="58715872"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 05:52:04 -0700
X-CSE-ConnectionGUID: PBsTlvJAS6a2PZLBeZPLXQ==
X-CSE-MsgGUID: 9TySvh2yS5aHdObMiAwxaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170005262"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 05:52:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 05:52:03 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 05:52:03 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.60) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 05:52:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cEW7tf1eLnV9seamm5fHq6L7lQnzAevBYKU01Ck7NGuFzA5/+pthktqHdU7vB4VHdhgrB/00TuuOMQyRbUwf2ui1CjBs8pWPKzvLRM+GLGgUv8PLMahk9FIIIjCmXhZ/66m2YeXd8zbnomuu7/dqdmToAVqh3V+hsZQ0h7VM/plnDInwZ2tF14x+2EedHCa4SiD57IYojD1hI0jS9syBjGZVbb6vyFHlyin+L+DZKig7O+lCyxsd0JSJx7dbpiQuhRVOjce6W0P0443+Zl4Il6c4f3vLaTlon6k2wkUmBlEHZXIDouYBlj50sy3+0n2Uxc1TD5tuL0wIMuFy+yls7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ct7X7B57AQHNFR5Bz/l8vesjYSFKY7CWJIftFXntMdQ=;
 b=b9Yr6NBkW0IwINSwfuc9cthVxRaMQfWMkuGfYu+rRhuf0KnOn4X6+n0mNDfxqYSI5mu9B+IEfF5e6x0kw3d66GhCdV48P3Vqq+7sn/hSSQpGjZswsJddeJhA6AUVK1JZ1WWp8mmy4MT/vrSm538PMeZ8YW/Fz+jyjCRZtf1EIfC0RSoHghs1kI5jWtwOtskBlK58JFY5GHtz+mPGIhx5qgiRT0Ak81iUaSLaCA6wUKLOr3WpuvocLGR5T05mx5QXf/eF/nZgM0fMLyxhr+ddhqPrA4FVL+45spavD/TxEpxcPQ8JW0L4Gly3Dg/Vud/J/KDYmycB+wKoG6ifp02Cgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6443.namprd11.prod.outlook.com (2603:10b6:208:3a8::16)
 by CY8PR11MB6988.namprd11.prod.outlook.com (2603:10b6:930:54::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 28 Aug
 2025 12:51:56 +0000
Received: from IA1PR11MB6443.namprd11.prod.outlook.com
 ([fe80::7e9f:7976:bf62:ec10]) by IA1PR11MB6443.namprd11.prod.outlook.com
 ([fe80::7e9f:7976:bf62:ec10%7]) with mapi id 15.20.9052.014; Thu, 28 Aug 2025
 12:51:56 +0000
Message-ID: <240b5f17-30cd-42f4-9dcd-4d5b60aa7bec@intel.com>
Date: Thu, 28 Aug 2025 14:51:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/7] net: stmmac: fixes and new features
To: Andrew Lunn <andrew@lunn.ch>
CC: Vadim Fedorenko <vadim.fedorenko@linux.dev>, <davem@davemloft.net>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <cezary.rojewski@intel.com>,
	<sebastian.basierski@intel.com>
References: <20250826113247.3481273-1-konrad.leszczynski@intel.com>
 <e4cb25cb-2016-4bab-9cc2-333ea9ae9d3a@linux.dev>
 <9e86a642-629d-42e9-9b70-33ea5e04343a@intel.com>
 <f77cb80c-d4b2-4742-96cb-db01fbd96e0e@lunn.ch>
Content-Language: en-US
From: Konrad Leszczynski <konrad.leszczynski@intel.com>
In-Reply-To: <f77cb80c-d4b2-4742-96cb-db01fbd96e0e@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P194CA0027.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::16) To IA1PR11MB6443.namprd11.prod.outlook.com
 (2603:10b6:208:3a8::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6443:EE_|CY8PR11MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: 246fe472-b516-43c3-3522-08dde631aba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|42112799006|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1h6Ui80ZlVzU2pmYkdxaUQ2RlJYNzhLMkFYdmEzQVdWZ3pHbVhobGM2VFhV?=
 =?utf-8?B?WHNxbjMwZDVpSmxOa3FScUQ1bmk0am14alYvZWtIdTZKblBjZ1pIbmdlZnZJ?=
 =?utf-8?B?VjBzcFhYaWRHZEg0OVlUcTkwNFlNR0ZOWEM2RkxBdWo2ZGVCYUVINjBhNllZ?=
 =?utf-8?B?bWU0WWVCWXcrSTRjS2pkMDAyaVh6RjB2VnJnTFhVZmlNdmwza2IyQkpvcklV?=
 =?utf-8?B?Z0ltY1gyNFlHRTIwdHd5NklSdFdDb0duQWcvODc0aEU5dUhoMlRkNjdLMUhT?=
 =?utf-8?B?MUxVa1JPdE9NK1NpYzF2K3dLUWZ6ZXJjaDhwQkdhWndxRXhNTjdNb3M0dlZP?=
 =?utf-8?B?dFBTY0NnNEkxa2k3SUZDNzI1ZytKYXpSS09WOGRkeHB0UURJV3k5MGhBRjBp?=
 =?utf-8?B?Y3dya01RVE93c0tUTjNOTXRuNVg3MUY1bUUzbHRRNThnYUdaeDh6aUtscmJl?=
 =?utf-8?B?VkJWN3laTzNUV1d6d0x2K3ZtcGpZcW5QUURrbUZDY0c3R3RHTm9MM0JnOW4v?=
 =?utf-8?B?Z2xKd3NOTkFxeVM5NmZTaitYVTVhZEdNWmNRbmxwYzMxbUhMSElwS01jOUk0?=
 =?utf-8?B?TkJZMFBFcGRJY004c0NzQWdIb3NSUmtBLytmLzViVUpkUDQxQnR2S09oYTRH?=
 =?utf-8?B?NUhmZHdMZUNGSStKRW9KaDFuUHBBS0F2RVpaVllmMkhxT0FSKzBpWUhjTmww?=
 =?utf-8?B?RDQ4UjVvSHROQTZGOGR6aldEeklIR0Iva3hDNlNlNHZjZTkwTU9MV0FXWVFq?=
 =?utf-8?B?elZrTjlHTGlEcUlHcGpUYnpxZHBjakxkYVZGRWVZeVRCRGJpcm9hNTc1RVA0?=
 =?utf-8?B?UWZXMERCc0w1aWY1OXM5OE5jL0NZdlZrZzFQUlIwakVDbXhWOTZwMlNIL2JY?=
 =?utf-8?B?YWlBU0VHbjltVS9LWGZFNWVmbEpvUXFSWlZkbGEvT2hNTW5TckQrS3Vxb20y?=
 =?utf-8?B?NklsNGZnQzEydmJHUkthQ2xLRGozblZ3SkJjdXZTQ1p0c2RHRVhUbGF5QkVs?=
 =?utf-8?B?Z2s5SWZaOUNIcnlMZzltSnF3azNKTEdoZlc1cTQyalJGeVJtMTVGdWFRbVJ2?=
 =?utf-8?B?dWVGY0pUS0svKzNNZG8yTlR3NlAyaDZCWUFyMHpIZ3RRdThPU3RiSy82Qkox?=
 =?utf-8?B?OXZiTkltOFJ0ZWpnSWpqTURrL09KMXNGNW9sTUhoQTRzV0U5RUgzYTh6NFV6?=
 =?utf-8?B?S0ZESE9oRFk2UzQ2M0w2c0k2VXJkSklJdXRnRUVnNVhMYyswMTJFcjNubEFX?=
 =?utf-8?B?TXBmWWFFWlR5L3lCRGo3ODFXQW1tYXAvUTR5MklCaUx3bDk4Y0xCeFhwZkdT?=
 =?utf-8?B?dTgvT0E1UVY0aHV4d3VSK3hSaGd1MkNVL1EwRDdPVzZCcDlnNWRKMzgvcVBo?=
 =?utf-8?B?K3h4djlIcHBCVU9sT3lhZWRoVDRweFFoYVI1L1ZtUkRFV3Qxb3J2NXI0R1JE?=
 =?utf-8?B?bkJ2UmRENktVZFNDaTdJMWo1SGVQbStmTkM0aEt4THNLVHEzcnhER1g1Q2RC?=
 =?utf-8?B?eTl2SmtoektJaFhKVFQwM2F2Rko0UVB2MDhqSUxoVHBVZVY0OUMwaUpnZ20z?=
 =?utf-8?B?TWNYcVJSMkV5eWRMZmN6WkNXeGFMS3loaWI0b3dEZmkzYUxxYUJmWjFSTUZM?=
 =?utf-8?B?VjJadFJYR21lSXNEeDR2OFhXR1RFaVpJV2NqMDBlQkU3dENRejJWVGNxVXZo?=
 =?utf-8?B?VktWcnZ4b1F0bjkvb2dwa0YwOGFTL21TaVZyd1VJR3NTT25jdDl3RnlUVjVK?=
 =?utf-8?B?Q3BZdk5vUy9tdFFLenhQQXpxeVBFclRqNDA3RTNyUFF3eFM0clpIMU1OcVJ2?=
 =?utf-8?B?Sll6K2pwSDVidVNNMS9qeDV5SHJxcGM1a1gra3ozeE1LMDQxdTNvRVBJdVVB?=
 =?utf-8?B?eGFpV3BTQlNvUHdtcHlzdkpzVldOdW9nTldtdnpqcTNwYVVZKy9OTTlmSFdW?=
 =?utf-8?Q?VHoDJXvrb2E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6443.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(42112799006)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDV5TWU0VFdJQUhCUTIyVVQzNXlzd2ttS0ZTeE5Pbkp1WitVTm5KdkRHTEJR?=
 =?utf-8?B?bk1iUmlBdHB0dVpwbkhTYWhXRUVTT08ySmxEZTZnY0RtRlNxbnJKd1hUcGkw?=
 =?utf-8?B?US9oRWEza3ZtQ3lBZExkamU2Vk02NThhVU9EOE1aZ3hZeE4zMlF4c00weHVj?=
 =?utf-8?B?NHc2eGdOUlFFdWorTzBKR2lxREdFaE51b25WY285L1FyMU1odHR5eWV1UExy?=
 =?utf-8?B?L00rTmJZdE0wYW1IT1NmdTZnL3J2TDJFanBwR0dnMlQ2MEh4N05KVjFrTUhv?=
 =?utf-8?B?UDVQRVkxTWV3ZFFmaWlpWjFkTEdGRDRJSUMvLzQ1clUwUWJxYkl0R1VoUThL?=
 =?utf-8?B?cnFTWElnTEp1ZSs5OHlnOTJaUUxtMWs4d1pDTGM1NURKbzhwSkFvdklSMDdY?=
 =?utf-8?B?dXdJVVkyTE9UbmNxMi9vVWErR1Qzd2M0QXlpK21lWGtQdzlwUDFWek9BbGt0?=
 =?utf-8?B?OENqaFg4SGd4VjB6UEsxTU5XWkR3U2hyRzNyRUNRejJnVzhuTGpFYWdPK2NC?=
 =?utf-8?B?LzRTQmdKeDM5SnBidVBqS3UxUTFDSG52Y0g4QXF4bW9nMTNGK3QvaFBRNTVs?=
 =?utf-8?B?TjQzb0FnRWNNNWIzWGRqTmhCb0NHWEZ2RUEvRXZxZVczNDMxSGkwblg0MVVx?=
 =?utf-8?B?U1ZJNlNkc0dVVG43QVM2TzAvQmNIMDhTaVpmTWU0TnM3RXpnVTRvZHo1bW9u?=
 =?utf-8?B?VWVkNWVxSm5zREN0cjRJYThUdmVFdkhXZkZMWSt1WHhhRlB4dFZsQnliUlcr?=
 =?utf-8?B?S2QxSjFTMWNHRkhzemJ1RUV1YnVNZldwYTZuTXB1NmVlTmR5QmpLUGNQVnhr?=
 =?utf-8?B?bzNqYVZBVmpOVE5KZ0d1T012T1hUeE13Tld3MzVZU1VOWEt1TVlReHhMdUd0?=
 =?utf-8?B?YlNBUVhETm10eWhFcGYreGlIRUxsSlFhU0VsZ3d0T1RGK3NjZlVzUnRrSEJH?=
 =?utf-8?B?T3UxZFFUQTZWenN0ZHVxdlpYMDhYb3poamVpSUUyeEdSZmpOQjRwMzVUQlpl?=
 =?utf-8?B?ZFZCVnBRZ3RwTUZ5cjRIM2tGZS9MNmhEd0Q0MTNEVWxLS1htOGFMakthTFQ2?=
 =?utf-8?B?RHYvUGRPMVYxUmg1RnlQVjJKNXpmTnBpUTROZ1hFNUcwRDlveHhuVkFHNHZp?=
 =?utf-8?B?OGV5UUcveWZtYUU4QVkxcGFUb2lZQTBKSjk2eG84dFRWRElONFdyZWZibVE4?=
 =?utf-8?B?SGhDMWdWWkV2eTZWUEJMNVRBRUpDRjdVbjRjWFhueHh5RVprRUErOXNqVVk1?=
 =?utf-8?B?MGlZZC9lazB2T2FOTWR4aUR6K0dPODVKOUtyR1NycHpNZXdKN0dCb2ROeWo1?=
 =?utf-8?B?SFJQUE5namdJV2NUajJvMXdTNC9MNmFabi9aeThXK1ZZWjN2b3Rla1h4YklM?=
 =?utf-8?B?R2ZFQzRjVWF5cEs0MHlFNFY0NG9tOEEzM2pwSVRSbk54VFpuMmNYcE9mQUJV?=
 =?utf-8?B?blk4M1hMYUxUMWpNU1UwcnhreGs4NFlSYlJ3SktGbmQ3TUNhL1NhcGtvODFW?=
 =?utf-8?B?OTF6eHB3NHJkcWFkRElLV2szc1YrWGVOa3hBYlBPYkErRHNGVHl3ZHVSS3NU?=
 =?utf-8?B?UWsxSjJBN3VsNG9iUkZSOFNtTXJ2a3FZYTdzQ0F0RS9mazBtVnJzNnRaNDQv?=
 =?utf-8?B?VG1DWkdqa3lNUFAwTFNDb2JuMXVuVmtVb2VQUE4xWmQvQzBPUUk3dnFqNkh1?=
 =?utf-8?B?aHBMU21Qd0xiMjJjK1lpNzlaNlZSMFBNT0E3bzhtNFIxVnMyS3VyZW81cW5a?=
 =?utf-8?B?RThDQk9ETUUrVjRaZEJtNFIwSGxtQm52bnZlMVFMRXlQaldSMzZHcytKVFo5?=
 =?utf-8?B?M3B2WXB4VzcwT09LUW5aVlFMN0toWlRNdjJyZEFEYzFqMVF1OGg3dkdYQmpG?=
 =?utf-8?B?ZmxJcm1sQjJadjJGdGxZT0ZzbkJDY1FiK2Z6b2N3U29lVTJhL2tQZ3p4VE1s?=
 =?utf-8?B?ZUpMREYwZFVURm9mYTd4SkdVU3FvR2ZzYm05MGFXU3lsWUhxS0U3QTNRRzg3?=
 =?utf-8?B?bDFhY1MyY2hGL3JMMU1aMW9iYXQwTlB1MkwyU2lZRE0vaUlvV1BWUE1raE1y?=
 =?utf-8?B?MElYTTdqZ3A5VjlWN0dSUXh2MlV2OGwyS0M5MzY4bjJLZm52RE8xSWRqd1pu?=
 =?utf-8?B?SHRGbXB5dXRtSE1mZmJvMU9jWExFaS9lN3JYdi9yS2hIYTBsVVdBQzdadWlz?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 246fe472-b516-43c3-3522-08dde631aba7
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6443.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 12:51:56.6691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rgm9Q7b12TT9AQKWztmkEJhvU8Zx//xIer3muARv/PpD1O/IH1aakVLscXvu28cN+kERTEOf0JSqfJlSLGhevnKy0aG0hBWm5znZbyeBZt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6988
X-OriginatorOrg: intel.com


On 28-Aug-25 14:25, Andrew Lunn wrote:
> On Thu, Aug 28, 2025 at 08:47:02AM +0200, Konrad Leszczynski wrote:
>> On 26-Aug-25 19:29, Vadim Fedorenko wrote:
>>> On 26/08/2025 12:32, Konrad Leszczynski wrote:
>>>> This series starts with three fixes addressing KASAN panic on ethtool
>>>> usage, Enhanced Descriptor printing and flow stop on TC block setup when
>>>> interface down.
>>>> Everything that follows adds new features such as ARP Offload support,
>>>> VLAN protocol detection and TC flower filter support.
>>> Well, mixing fixes and features in one patchset is not a great idea.
>>> Fixes patches should have Fixes: tags and go to -net tree while features
>>> should go to net-next. It's better to split series into 2 and provide
>>> proper tags for the "fixes" part
>> Hi Vadim,
>>
>> Thanks for the review. I've specifically placed the fixes first and the
>> features afterwards to not intertwine the patches. I can split them into two
>> patchsets if you think that's the best way to go.
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
>
> You probably need to wait a week between the fixes and new features in
> order that net and net-next are synced.
>
>      Andrew
>
> ---
> pw-bot: cr
> 	

Hi Andrew. Thanks for the heads-up. Fixes are new features are 
independent from each other. Should I still wait a week to send out the 
patchset containing the new features?

Konrad


