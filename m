Return-Path: <netdev+bounces-108342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 719E191EF98
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 08:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9726F1C238A2
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 06:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4926912D1E8;
	Tue,  2 Jul 2024 06:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IcZLsSPh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3472A55C1A;
	Tue,  2 Jul 2024 06:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719903521; cv=fail; b=A7boewiHXqjfshtmN6XXjiktWzkFEGsVCkOi+EZvCHcprFaEsRe036Uju+cSMksRDXRwMQiRy3UjFM3OncGWrbPCJWwsE/tDnialX9PR/oXxnQ4PEFcocRop9sQ5AuF6gYSFrWO+uov7GFXG7ZH7T4o9Ou2mkok+CZPMkeIXkrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719903521; c=relaxed/simple;
	bh=/M4KM6N1dPHbP5UB3eCbE5Km2JIFhinkNfzZiPsCGFE=;
	h=Message-ID:Date:Subject:To:References:From:CC:In-Reply-To:
	 Content-Type:MIME-Version; b=h319au2PApUymcQFLPXmQTqI5TrYVqaj3ElV5tSFOi6XfiJnXd+IJLRyezKbT9IRLmEhzew3RCE/GxJKiVXyOXkKpbABsAZjoTHj58URScFFNivbOAVU5xRipNu3fUobYjxxkdE+1twLDtqFZNfIIkldETgrnXVHg6/rAu0eVb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IcZLsSPh; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719903519; x=1751439519;
  h=message-id:date:subject:to:references:from:cc:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/M4KM6N1dPHbP5UB3eCbE5Km2JIFhinkNfzZiPsCGFE=;
  b=IcZLsSPhJBG4wNMEcmwHOiyUQuqahAg6hlJDfp1Fyf0Ne0CL4pXRRIfI
   dJAkgC73e/eL9y7pYNzUcECN0uLZFRRO9nX6cDP3b0EbKgBynWJAbBWNs
   xlFSz5hbK1jv7G/hAbhUO2UrOxlpzFiSF+1c8i4+RGmEmKo+qZagAETE7
   U7hwS9zr4/B4nlsfHL+jT4BhUtsVOGwteCXYNr2KinOL3YesJbr88rOYN
   sX+I3AUHhmoGyMwfsBpWN7volH2EV2jAGtaRLBNLwhl1XOzWOytAPA74k
   3TDjueONTFBa2Ju5RKNcO5GsieYVjLIswWhCxpktH8q3w9C8Y3ITZlpUb
   Q==;
X-CSE-ConnectionGUID: C7GMV/gtT6O0r6HZyY+sYg==
X-CSE-MsgGUID: 1lBEE6SISiSGkEYannXmLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="16722663"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="16722663"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 23:58:39 -0700
X-CSE-ConnectionGUID: r4xYNhuhSZuPdvoW4NS/6g==
X-CSE-MsgGUID: faNODZMfSR+dUztMS7nb7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="46527325"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Jul 2024 23:58:38 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 1 Jul 2024 23:58:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 1 Jul 2024 23:58:37 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 1 Jul 2024 23:58:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKcTzpdYwMNWH/8Jxb8xtyAjE8HRQmP+E+dVOPqT0cNaaJ8AT72CiJQ+Z1OP/Fy5dELJrQ76E+LNCrDgAtrHGyWYPbW8ZPmBB+9muGfVBjBXlP2/cn47rrvi05dUWvckkPasJ23dRmVOmZFWGbiPa67JJVkSg8wf/TFD3JxnPVGn/c6VwQQd6B0+Ud1ncAqNZGTzJ8mzLwGYJnlH2vyA48PoXL+YP+rDmUQxwDy6sNJIoW8fodXTqpI8RSXNRd13DMdRlsR4Gaylm6VoTtcgfLnAUg/yjQ40TIRYB8o83RTrc8KlYRyMOgVSJ91pzkW5kagw/eRrpTcB1CntdxC1LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxsxF4hmMRPgjo5DqP+jLCwlv+1v6S+jACzuIUPGNoc=;
 b=MC1aWx45T8agMaubVe79Athmq6QICMuw1HDuFZhfAK3l2erdFIgxQ+1Lz8Moj5yRVl1U25OOfpxsufJlz8LTAvUZO235mpAXkBMj9FCQ9VCzGJilRom74BEyOOIBqT373GQxdOgm4voPKfyiPbxGTtFOC1d4nRXVSJdOae/m++ye5EFulSUP7LKiO9r+0jSsrncqQ8IxOsQpRddH0W5dWNmEAyoRrRHM1FbGLxBwk9gxaFu/l7PghwUUkpa+R15AGEbOZildnHURiyE6rN7vfX42Z/AaDZd4mPfaE8UYQXQGV9j4+5r5wsRRNJu8mP2o8HasP3FlRO/NcAbMR/AaEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SJ2PR11MB8537.namprd11.prod.outlook.com (2603:10b6:a03:56f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Tue, 2 Jul
 2024 06:58:30 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7719.028; Tue, 2 Jul 2024
 06:58:30 +0000
Message-ID: <3bda121b-f11d-44d1-a761-15195f8a418c@intel.com>
Date: Tue, 2 Jul 2024 08:58:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ethernet: mediatek: Allow gaps in MAC
 allocation
To: Daniel Golle <daniel@makrotopia.org>, Elad Yifee <eladwf@gmail.com>
References: <379ae584cea112db60f4ada79c7e5ba4f3364a64.1719862038.git.daniel@makrotopia.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
CC: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, Mark Lee
	<Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
In-Reply-To: <379ae584cea112db60f4ada79c7e5ba4f3364a64.1719862038.git.daniel@makrotopia.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0074.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::15) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SJ2PR11MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: 0975748d-934a-4b20-91d0-08dc9a6461a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RjVQZ2ZzTkVibXR5ejhPNStReEU1NWphcXhyeWM2MTZnVlltYmJWUmY1NTRi?=
 =?utf-8?B?bk5rMSt3aHlRV1M2OUFDRWJhbFpjNVJlaXkxWlBiNFlFbkVPZmpMT0pTNVND?=
 =?utf-8?B?QUpzWG95WXZabkZUNnBIRUJiUWIxVUlKVVc4TklwQ2Nod3Y2MGtMUnQreitZ?=
 =?utf-8?B?TUZOUTExQ0Z6K3Vjc21rL3drdWFCOVE0VXhoQzE5aWRnOFZqY1RTa2hKM1dZ?=
 =?utf-8?B?eXQ3dnZvV3prNng4YWZYTktVSkdPczN6STZFd1V6NEJrVnpjR09KOEk3OHk3?=
 =?utf-8?B?WWJrSFkzSTFzNjhyQ3Y1aVB5d2N5WGZJV2tPQWFFOVNpQ2RSamE2Sm5SQzlS?=
 =?utf-8?B?S1FUeGx5RjFnMDRKV1dDbEE3NGVncE5OY0dBWnJueHZqUUtFS1NzZU0vaWVx?=
 =?utf-8?B?QU9QcHpFS3h5d2hkRVpIeFJnalVUemlKRVZiQjIrZE10RTVhalRnQnJ2THl5?=
 =?utf-8?B?ak9yL1pNcE50T0toU1ZBV2NEa3BlRXNGVjNQOTF3c002eTFPSzluV0xYWVp1?=
 =?utf-8?B?SkoyR0Jpa2pKd2NTRWhtZ0Q0NFBydHFKaDB6RWREYnY5cENyS0FXT2dWenVD?=
 =?utf-8?B?NjJWRUhRTlR0NUFzOGw3Nkl0NjBxTUZwcmk0R2tjMEtVdHBONFkyUlRFMGlz?=
 =?utf-8?B?b2RHV2toSGdsbVpqUXN6RUZsQkFFcmpoZ3k4OG8xblN3bGh2UUVrcG0xejF2?=
 =?utf-8?B?TDltaC94eHpHa1VsWDN5WnM4d1VxRVVBQ1VkL1lLNi95eHplclBmN3RuMElu?=
 =?utf-8?B?M2lCR1NGU1pNKzdXL3JzVW03QjE0Vk1FOEUzSjVqUVlVZzAzR0taQm9iOElj?=
 =?utf-8?B?aVlzUXlhbVNHeVY4dFhIbnBDdi9jL2JlL05nR05SYS91SkN1YXRzT01FcDZU?=
 =?utf-8?B?bnhpQkgzTjNtcTFwVDE3cit3YjFMZFAzQWcrVE5vR1VXYWdhcEdHdmtjU1pI?=
 =?utf-8?B?bVo2cDUwM040RVpBaE9uVHk1Mkx5czk1Y1RhS1FyM2xiSzVicjFXRHpqcU1J?=
 =?utf-8?B?aWU5S2pRZ0tUeEZScGJ1dWE0TWNqbWwrRmtTNmtDM3dBczlFQ2I4VGZDNmNl?=
 =?utf-8?B?SXBsOVRFTUlmWGl1UzE3dmtyaW1iWjY3VG54SmIzSVVCOSsrZTliRS9mVk1Q?=
 =?utf-8?B?RU9jMm0zVENzT1BISFZKa3ZGSlZqeGN1a0dmeFcwOVEyQ2dHeXdNZWRrYWVs?=
 =?utf-8?B?MkV5WiszRFoxT3dPWER1aUtWczE5SlFmSnJrcG1KVW9rbmp6MUE2cHBYVHlE?=
 =?utf-8?B?cmFva0ZMY2I3S3M0REtBZzY2ODIxWTNHbHF4dS9jS2EwbFNPVHFlOW4xQm1N?=
 =?utf-8?B?NWNUeXJtTVlHZ1JLRDM5MllreFRoS28rZ3dlNktOTTFMK29DRzlWc2xwTWs2?=
 =?utf-8?B?U0pGemZWeTJUY3pUTzhQeXFvQldzdEtRdlZ5ZzZIaThwdDZHeVdwWnNxTjNl?=
 =?utf-8?B?bzBiL3NtRm83cDQvdWhDWEtyc0RWMThhSGhpbVRaQ1h2UVJpV3VlNnFwMXZv?=
 =?utf-8?B?azJVQUdVM21yVTF2K0pMVmNyUU02ZnBIU01PU1lQNDFtRVpmajV0WXZvNWZB?=
 =?utf-8?B?Q0pjaGxTM0hhTXJ0aTdvczdqQmtsellmWkZwcHFPOThuVEs2S2dxek5pMCtW?=
 =?utf-8?B?eVJwVm9CUUl4NXhEVVNjekxQL3hVZkJRNDRGVXBSUUZReEE0UGhDdTUwc0VX?=
 =?utf-8?B?NGloZExPZGQwWERJK2daWlptM1lWTU9xRERITUdHMmFMaHc5Vk1BOGxoVVRE?=
 =?utf-8?B?S2l6Zk5DMVlGckVQTWp6OGlibWNhTU9pNnpvU0h4K1RMYThUSTRRMUMvLzZq?=
 =?utf-8?B?YWxaeHFUbHJSdHZVWkJrZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHArYll3cWFTQU45bXBVOXAwOHZ0d2NiTTlWbFhmZGpmRXZvbjNPMDBmUkIx?=
 =?utf-8?B?WDR0RDdWaU04aXNWTVVZdVVJZHJkaEVhYldPTytlc3A0SUNhK2VuTEFhckNx?=
 =?utf-8?B?Mk9laGpnM05YK1dSRG52Y2lZblVNQWhmYWJUa0QxN0pjdGV0cjM3cnBuVmtB?=
 =?utf-8?B?cVliWmV1aXh2M3QxcWVnVzBMWGhEZy9BQ3B6emVBSDJPS0RTdUdkaW13cG5p?=
 =?utf-8?B?cW5QeW9hT1dOeEJxL0wvbnBZRkdNbGR1eEd2eGdOZWFVNWhEbTFuckE3M2k5?=
 =?utf-8?B?OXpFRWpad1ZwVERlL2pFYzliRDI0Y1RpNk1QeGJrYnhlZ0VFMVc0K00yQjZF?=
 =?utf-8?B?UEpON3ovMmJFL2tkSjZoeENzaG9DNkp1d1hvR3U3TEVmbzVMOEowOEhoRUpJ?=
 =?utf-8?B?M3IvakxhWjVneWU3Yy9jWlBQTENJQ25pVEthbEYzSVdGZ0pseTdOZ0pzNWUw?=
 =?utf-8?B?YVpKSTJBOGJ6V0tIYnhsS2FKajhrKzQvQml6cjRTZmh4eFFhNlNwdVB5Lzg3?=
 =?utf-8?B?QUdYWTJKQURLS3dLVG9vbXNxMUhQSUMxWHNmSXFVUlVjWFpla1hHcytRVzhz?=
 =?utf-8?B?V0F2ZlY4NC9rSnBvOE53TEJTV2llcWJweEJTU0ZVd0QrNFhHbFhOdnZnSXhz?=
 =?utf-8?B?YUtnSXRtcHh5RGhoRS84MXpwWlNHdUV1SXcyRTNuYmoyVVcxd2FIRHRYVWd4?=
 =?utf-8?B?RWQyaUZWKzVhR1FpS1Ara3loZnRTdlV3eUdpNG9ybHNzNDl3dlk3NEYvald0?=
 =?utf-8?B?STZKSVJwWUZvSUlJQ3VDWE1keE5yZVBKTGdxSG5yL1ByMitPSUpHd3RhbUYr?=
 =?utf-8?B?VHVHS1dpeno4MVhkZzZOUkgySjBXcWpSV1h3dWF1cmRqNkZnQ21MdHFjbUhB?=
 =?utf-8?B?TWRQbm91UzZhb2g2OFo3WWNNbExvUCtKZzI3djFybnMxd29JUHBMY0kzdkdK?=
 =?utf-8?B?S1ZtaThneG1FekRSOFVhcE92UXAxbS80b0NsOWM0NWtFT2E3dTMzZ2RMdk5D?=
 =?utf-8?B?cTZ5WWFlMHlHNTdYazFreXVxQnQvL3pUb0hzQUphRXhtL0VYVnBSZUd1R0V4?=
 =?utf-8?B?NFpFenY2Qy82bVJQN2NjSHZ4VTVXVTNzRTVZNkhUb1k5eXdlT282dEprTHJY?=
 =?utf-8?B?aklDRktkZnZxQVdkVkZnQ1EwdG5wbmsvVlN0QVVtbk9JZDFiOWVIUC9RYUpa?=
 =?utf-8?B?Q2ZiYXk1bCtoUFlNVHpOdFRub2l1c3JVeTRMeGh3S3BXMTFaRThucTFvOVYy?=
 =?utf-8?B?WEZkZXdNWTE5QmFFWUg4RXQwbGs2c21udWJyTWFEMy9DTElRdHlTQmhKaHFs?=
 =?utf-8?B?anJhY09SVVBUT0JtaWpjNUF5TUZZaW85L2hKWEduMlNVT292TUFKVU1zQ3hE?=
 =?utf-8?B?djZRSWJ3UEdvT1lnMG1MdXRFMy8zTmN3cUVyNDQ4cFFDY2c0eXR0QUF0azcz?=
 =?utf-8?B?U2FkdkFJS3VZT0ZENEQrdGlUeVRJU0RxbmdwV011RkpMV3ByV2R4WG9CNVpJ?=
 =?utf-8?B?MkhUNW8ybUh5K2x3VlFOQktGYjFtU1VYd1htaWJSUVkxeFBMbkhGcXZQbXc5?=
 =?utf-8?B?cy9RU0lGdWs0VFhjMWt0QXN2Y1hseS9wdUJ1NmZ0bXE4WUd4M3RqVHMwVzln?=
 =?utf-8?B?eGFMOXcwUm9DMHFic0RFd1EyU1V4bmc4SWdOSExveVF1bStFZmt2TlRaZ3Az?=
 =?utf-8?B?Qm5vbGpYb2h0S2o1WlBUUnhUYkRKbW5UR0hxREJhVXZoQzM4eGpJbS9aOGJC?=
 =?utf-8?B?czhxR2o4Wk16ZDJiZnpHdWt4a0tEMXBUSGxaYU1CK2JyTHpZTDdUQmw3cUxr?=
 =?utf-8?B?d2pDNTNRUXJnTm1Xci9JNXRFdFZKSk41WWFCcGdGMDJRa1dNVkk4aHdsQmh0?=
 =?utf-8?B?K29mVW44b1dtNTFRbkxtSXh3T1dOVXFCMnhMbUM3V3dHbFN3dWNoYWlvcXpM?=
 =?utf-8?B?cDZiaHJlRnZuRlRjc09SV05ERW92cGRVeE53ZEJ2YXFkZUZUYVdWOEJMM1N0?=
 =?utf-8?B?K2lkUUN0ZWE2Y1JLQk8rOWtHbk5XczI4TExzS2FJRjkvWHl2dUROeXJwVzAy?=
 =?utf-8?B?TzI1Uk5GcXRVa3pzZ21XOGNscEN4STVUOFV6YTJkSDRNdmtSSVdDZEtoYmlq?=
 =?utf-8?B?VEpyUkx3SHZRNHY0MEEybC9UZ2tGMS9KM2VMV1lta3p1YVVwQUFucGduOHFT?=
 =?utf-8?B?VFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0975748d-934a-4b20-91d0-08dc9a6461a3
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 06:58:30.6001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G284rblWwB5BU+UyFT6rdWSYtvbYXj1Bjx79uWN2EClyyzC4bRLtyqxrv6ORrvIVBEA2G4/pnGxQHbq4Jj5FsDBMEHQjZ8USJxwDd5XD7Ds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8537
X-OriginatorOrg: intel.com

On 7/1/24 21:28, Daniel Golle wrote:
> Some devices with MediaTek SoCs don't use the first but only the second
> MAC in the chip. Especially with MT7981 which got a built-in 1GE PHY
> connected to the second MAC this is quite common.
> Make sure to reset and enable PSE also in those cases by skipping gaps
> using 'continue' instead of aborting the loop using 'break'.
> 
> Fixes: dee4dd10c79a ("net: ethernet: mtk_eth_soc: ppe: add support for multiple PPEs")
> Suggested-by: Elad Yifee <eladwf@gmail.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> Note that this should go to 'net-next' because the commit being fixed
> isn't yet part of the 'net' tree.

makes sense, and the fix is correct, so:
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> 
>   drivers/net/ethernet/mediatek/mtk_eth_soc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index 13d78d9b3197..2529b5b607c8 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -3396,7 +3396,7 @@ static int mtk_open(struct net_device *dev)
>   
>   		for (i = 0; i < MTK_MAX_DEVS; i++) {
>   			if (!eth->netdev[i])
> -				break;
> +				continue;
>   
>   			target_mac = netdev_priv(eth->netdev[i]);
>   			if (!soc->offload_version) {


what about:
4733│ static int mtk_sgmii_init(struct mtk_eth *eth)
4734│ {
4735│         struct device_node *np;
4736│         struct regmap *regmap;
4737│         u32 flags;
4738│         int i;
4739│
4740│         for (i = 0; i < MTK_MAX_DEVS; i++) {
4741│                 np = of_parse_phandle(eth->dev->of_node, 
"mediatek,sgmiisys", i);
4742│                 if (!np)
4743│                         break;

should we also continue here?

4744│
4745│                 regmap = syscon_node_to_regmap(np);
4746│                 flags = 0;
4747│                 if (of_property_read_bool(np, "mediatek,pnswap"))
4748│                         flags |= MTK_SGMII_FLAG_PN_SWAP;
4749│
4750│                 of_node_put(np);
4751│
4752│                 if (IS_ERR(regmap))
4753│                         return PTR_ERR(regmap);
4754│
4755│                 eth->sgmii_pcs[i] = mtk_pcs_lynxi_create(eth->dev, 
regmap,
4756│ 
eth->soc->ana_rgc3,
4757│                                                          flags);
4758│         }
4759│
4760│         return 0;
4761│ }


