Return-Path: <netdev+bounces-278872-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHgrIQQD4GltbgAAu9opvQ
	(envelope-from <netdev+bounces-278872-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 23:28:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF18A4082BD
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 23:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92768300EFB2
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 21:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E522438425C;
	Wed, 15 Apr 2026 21:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I5R43tQg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D8D3382C8;
	Wed, 15 Apr 2026 21:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776288141; cv=fail; b=HFGLTiXvykPJceNe/Bmrksxul7siJ4XNhBZw4KpT1hNRX3YIt4zSVGxBV5O7KE1t17bwcwrjCrlL/UCY4NPIh2YYv+40QKTzwQ5icEJ4G5hgeMm4uRm28VJbeoAuBZz2PeYCEq+rnX8qat7Hv8JsnIXO/Vpn+CsotiimSShzSlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776288141; c=relaxed/simple;
	bh=wOGIyK7IiwHlM6WYHbn/I6t6QUpO+YOjlB9YY6+9sB0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yw3ehgfFrjydTtbV8gzdt0tcF4yG6OsPoQJfkGWGjqqa2JoLYQT05jalk/DZMfW0GK9H4GoQ5D8pxxF4wYzNpNVdkLJDu5J2tOLg36KtF4ZboxxBpqEWV54LuQYDXJdsW722vdWXMGA1G/Z+cwN5R9SbYwVr/cfDE61262pQ4SQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I5R43tQg; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776288139; x=1807824139;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wOGIyK7IiwHlM6WYHbn/I6t6QUpO+YOjlB9YY6+9sB0=;
  b=I5R43tQgBMxQKj+p09T/NvtK42XLckLXH0t3dwJyWhgqVgG2ZbOlFAzb
   qja5KmTyRvVLYQRnsMjMKFLDfXdR0txVZrlRUXdaN3QMVHFI3cdkKbM0j
   fol8R/+KfUle/zmzJVmpag1SfGGPYT93Hxd49DMupCaR8HSF+Uq1K77Mc
   9xKYGMXA26QOue39jvMNSbNpkOK4NoLoImVgmo34QhLKbPEYgUawO4eDz
   uN70f7mHCIGERcTmkpuSrXEdC96aJGBX2/ielWi4HH86YNe/xTiUgEa2N
   5Wdb9lJPsh4KIPtsPsnuUaW8uItqwEXvWC658wwUWXmAN3mX6GD/D2JyJ
   g==;
X-CSE-ConnectionGUID: gl4e3Qp1SXuoFxqMXDcJng==
X-CSE-MsgGUID: tiM+EDK0QYewQCN4H7Zf6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="81152267"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="81152267"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 14:22:19 -0700
X-CSE-ConnectionGUID: atfk6SrkSYqRrhkECvLkXw==
X-CSE-MsgGUID: rzvhxu93QHmxrIdwl/Funw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="230776787"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 14:22:18 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 14:22:18 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 15 Apr 2026 14:22:18 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.29) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 14:22:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bUhHNIWfR+rJOYqp61BO9++ddoAz+ylz041Mmtzi829ScGRqtZqh/PAoJC0QWsEJEXwVPI/4QpJLk85SPZcXcTVGV2gugXVQY0DqX8KlJvxyxDR04BVMJsHTCxkrnQjSqOxlAxdv++TVoxMTeZENTuVDxqikZsdSrLDEUYhtSm3unYl7nrlqSMk7nbOXC38OoaAC0hBtFGAV3csXg24VsdHnOXKCHQQa4WZuc1b0poDRaP2nKz81F6luIUcIM+cz6B4g6mg5Ubru83Te4y4MjfBUJIiQ0mHoIGxXfl29qFH6nFZkTGY8th5Nh8IOvHIzsuAWUaeSyLfMdSH6YtUuaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6K2llWY0tTWh5edTDllDCI3R8w761wbame1M1c04yo=;
 b=dUgeyMf8yOmaMQyCOZPWhhYTuSbrlh1bAbkMJxC0Y0eaReLrSDmIBy1L+CB6oPJzLfTW2Wazr940XP+DIxMV0w1VwU1hRmyz5RjosnljRWeMQVH/8tYDg5bV8olpoAbvuEXFzJT12QVLzlPCZNNxUp/ff5ZBmYjnnzxsM77dHPu7xGlC6ziZhYKUO1+s0RSTY/duOWHxMVqUn3VewvKxkfw4OFH0nvFEzGULojYnIbpc+xEuCWJaZDXKN8btR2do8gNhjwhI89c3538E9i/uu4jNZig4dQRVcYw1GcGzUFdwHy5p5Sz7a7xESpakmSmaT6PxbwD0Z9/HbLYky6kTWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.17; Wed, 15 Apr
 2026 21:22:12 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9818.014; Wed, 15 Apr 2026
 21:22:12 +0000
Message-ID: <f30ad78e-1eb9-4c9d-9034-c8873966de66@intel.com>
Date: Wed, 15 Apr 2026 14:22:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] ice: fix infinite recursion in ice_cfg_tx_topo
 via ice_init_dev_hw
To: Simon Horman <horms@kernel.org>, Petr Oros <poros@redhat.com>
CC: <netdev@vger.kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Nikolay Aleksandrov <razor@blackwall.org>, Daniel Zahka
	<daniel.zahka@gmail.com>, Paul Greenwalt <paul.greenwalt@intel.com>, "Dave
 Ertman" <david.m.ertman@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<linux-kernel@vger.kernel.org>
References: <20260413191420.3524013-1-poros@redhat.com>
 <20260415163003.GP772670@horms.kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260415163003.GP772670@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0194.namprd04.prod.outlook.com
 (2603:10b6:303:86::19) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|IA1PR11MB6097:EE_
X-MS-Office365-Filtering-Correlation-Id: a36f2c02-89f2-47d4-2140-08de9b350ed7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: hZRx34OqINIDKOE2lrEqITWLY4BnsncLBycGNbrNByANY4W9SZ6KZGSb/2m+kUCwZ2OIEXN1wyZ6cbV4FkkBZbe2JOVY49wp8Z60J7PB3kR3Ppti6zKS62mqF2Lz/iocxPVYkYKyxZsULRfP3PmPO1dDn4uO9KkORJtduKj/06zwaJBTVHN1rbyRETtEVyQgUpCdc9ax37eM74f16mNSxv1yvU0JfjydIdsAVpAvVTIYt/U7ovxXluvNpIhmnnMejqktgmqeppqM1NBS65T2XXjxoMhy8ZkFFrRw7HeRpjE9y1j45nEhnScpB2tnQPb0yXfo+JLBb47F+4BYEZvd3ctvbeqU0RpFf/jZ/vIs00NBlvdij4MWGumJ/YZy+sORbPSBvcr02qElBZw7i4qpVcw6me8wFcmo3ckJsUGnxs8BG5E0jA0RbQt4xiHyUp28LxhGF8B8MI2QuTl7WeweTqPeVQGFQmBROUHHVfGZeng13a9lalugTYHF61nS54bMwzUi2Ux/LTYX1xJnXpNfeSDL93hzwvULlHmAnN5FbfgfWipaMSueMoWRjSt/LCFIj3UxpFLX5duOR023KoJD0Q9QMN2I8o0sHS4a1ed+0LEGXwmQ7+6CUAM00TQeG4N84Ph4ucTB5iiF8NOKtD5M7+LC1/obNrn988yWxmIO80AfS6YS/4u8ORcI8PjC2qNuc0mdf8qoTAHXISSqWcQpOBnQGsReIpm1oqtx05GEtVo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alJiTlI3R1JKL2c5SHVzZWRLZWkvOW5aMUlSY1doKzRFY1Noc0JXK3VURDBD?=
 =?utf-8?B?UVBQUGNYaTdvU3I5M2x4REVrbTZ2cG80S3IvRm1hYjZFL3EvK2QreWVPbGR1?=
 =?utf-8?B?K1BqMVVBU0VGUHBIbDd0cStnQ1hDT09hODVtTi8yMmlTRXljZlIxT1dSSHhT?=
 =?utf-8?B?S1VFSnpMMHBlMkVIU0lzUFFhV09uaXBRZkFQbFVyUWdCUE94ZnVSWDVpTUkw?=
 =?utf-8?B?dHNlMkdzb0owd2V3M0Y5Y1Fnd2xHQlRQZDdJd0tQcmZTK1VJMFlQM2dWWGlV?=
 =?utf-8?B?OWY4akRNZ0ZVM0EvRFNjV2JNQWFGcjc2eDk3RlFrWDlOQmtTY0Y4RGc2Mmhy?=
 =?utf-8?B?RzM0U0p6a285OGlOYms4Q3ZKS2ZjSEZlQ3Y0RjRiOGJuSTIyVnFKQ2tXL3RS?=
 =?utf-8?B?UFRuWENxQ1EyZHZobUo3N29McVdTUUVqenFpMkJhWjV1TWlmNXR2Z0NscDVZ?=
 =?utf-8?B?Q0lyYU8xeWtFWHNQTmZQWXU4S3NkWDlSVldIMStoanVXM09yK3BTYWNxeHJs?=
 =?utf-8?B?N0tsZXRGV3JLME9DSFBOdmRpOEV0bGkzNHZMTVpBaVcvd05IYXl5Wjcvc29a?=
 =?utf-8?B?Sk1TRk9sQ3dFWFNjVUp4eFNQaGxFVjY1eWFJb0g2MWsvd3hBTWh6ZkFVRW9n?=
 =?utf-8?B?KzdndUhXQjMyT01hbVZEelh4N0tEQTV2Zlh0OUpxZGI5SEROMDQyZ2lFaFQ2?=
 =?utf-8?B?MlZoVFFxQzgrbEZTQ3Q0cFVsL2ZkQUFtWnVnOTR0Q1MwSkRWeEJGc0RhVldU?=
 =?utf-8?B?UU84V3NFUmh4S3J5QlZKY3IwTlVGY2lnYWdvcmE3WFlxQVQ3eUhwUzh2a2J0?=
 =?utf-8?B?bzNDWnNrYzVQM0lWSy9oL0I0T2JFdFo2UDBrUE9GU3RIdDdJUEdMRHVENkhz?=
 =?utf-8?B?ak1ZRnFBeEU1SVpYelRoSEFNWUdBQ0ZlajA3OTMwelVLa1dRYmwrK0Z2dmx5?=
 =?utf-8?B?ckdKVWhUN1JlSDV6ZCsvakh2NFRnSkFoVHAyYlllRmo0SnNoZ2prWTFqS0Fs?=
 =?utf-8?B?bmlXZXlFVDRuRWVpYkFCL1pwNWdBVjFWdFdQVXZLbkFpZExtVzdMckRicUVu?=
 =?utf-8?B?U2c1MEdScW5MOHBZZVF4TDZhZ2tzVFl2eVpZandRMXRJMjBDYmY2ZnVtaVQv?=
 =?utf-8?B?SVNKTFZqODFtUW5JRUZtejJ6QlU1UXp2ZUVKQ2lhSm1xWHZOUmJEeVpCdnZj?=
 =?utf-8?B?ZDZJSkM1a0FwYzFwMXVRdlpReGF4cGpGeTFvSHhvM1ZTdUExQ01Mcm9SZjNm?=
 =?utf-8?B?eFNnRFVTZXlheGVaK2ZKR1RqNjhCZ3hxN2dCaVhzNkZZdERzQnhZUENJMGM5?=
 =?utf-8?B?c2RDakcwRklvdEV3dC9TcURva3Y5V1MxZWpPSDBwQm1OWm9kaVNCazA2MmNL?=
 =?utf-8?B?L09lckZGR1RzNG1xcjIvWjhvT1QreVJPWkVXNEkvSFZ1WDkyZU13dzVPSk4w?=
 =?utf-8?B?Mm93MlVjSWpFZlRVSXBIVmxqUGovYWkvaEU4Y0ptdEdOMmRLZ0NIN1NRUzN5?=
 =?utf-8?B?TjdOTkNDNm45emNPQk95M0tqQXVIYm9lVThTU2N6dE01V3c5dXZhL3ljTytl?=
 =?utf-8?B?cDZLczR6RTNUMkJuSmwvZHNNWElhdW1uQVRTUTM3Q3c2cVh0YXk1VFRpVTVK?=
 =?utf-8?B?Nk0zYWtNR0pBR08rak1OcUU0VnpuYmExcTYwQ1hWR3hYWWtZNFBMTXhwMmMy?=
 =?utf-8?B?azViSngrNGtEZ3dRZWg2MGJvakk2aTViVDZIWkZIcHRRcVFSd1FFT3JyUVFu?=
 =?utf-8?B?VHp4RjJrK05QY3hkajkwQTk1SG4zRTJNbTc0QnovbmtzTWZRc1Z2MElvd1Iv?=
 =?utf-8?B?czdKQitCZHVjaWthY0ZCdkIwRUJ1cjc5dE5jVkt0d2hZWHYrRmk3eCtMeWsw?=
 =?utf-8?B?ZEFJTlZIQXh1dlhtV3dTWGQ0aXpjOEEwSk81MURwa2V2THI5TUgzU1BndGl6?=
 =?utf-8?B?WXI2ZkJ0a0RGTXdCL0pHWW8wblhUUkVUK296aWZ0Y3p3WE9wRjltR2ZicEZk?=
 =?utf-8?B?a0lpeWpHTjN0STV1TXVjMHBtMkU5L1FkN0o4dStpZkhmbDR0N1dacEZOUU9C?=
 =?utf-8?B?cDkrN2hiTTFvZGRPS1ZkVC9NSzNQZW9vc2pyVjZvdTZkWnpnNFE0VTVPY21m?=
 =?utf-8?B?Y0pWQXdhdDdJZW91M3BQdGltdFBmSnpGdVpVaFNtbkY3MmVhWGJvem9BNXV1?=
 =?utf-8?B?V2o3ZWdLR1Z0bGFNUHdvZktCVHpHWW1CR1NGdDJZcWhDdXlNUUgreUtrL3Z0?=
 =?utf-8?B?NFhzYlZLc1YzK1NXdGk2bFkvZTEyd0tUZmx3bFlEUmN0UWtHQmJTTHJrOWVh?=
 =?utf-8?B?RU9hbk9xeFNTRE93OEhWNnVPeWF5eGlzRXZaSFAwcTFQT3BURlQ1UlAyK1ov?=
 =?utf-8?Q?5EZheNzuYJq8zjz0=3D?=
X-Exchange-RoutingPolicyChecked: Ob3UcFLjqZoGyEK/idlYnrumRLDW135w9drnm0169tzO/EQ6awNYQzMhNmCKWjKY6ct58HsAa3ek56omYmnnfOtciVns8L1Tx8csQNslkVPKB7Amd22Xn0W03ffeyFIgUBg5Ogv7YxAtYe+l2/noqAg8T1eIvxm863ruqPq2LnuMSFrJUAfe4ZxVeuhlL/yUZ0OcVSFPfwnD6CL5g4IMy8WV05T6N02TCV5jSeq2mP/olnJI/nYE6L8yRPjnBS2jyytYn/k3WeRAOITIfQUl6pAuA75YmdoodtTP750zskZzMmoe6BnF4vYFc/y5qnpWOgA5DCJM6mul+J2jtYGAkQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: a36f2c02-89f2-47d4-2140-08de9b350ed7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 21:22:12.0931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ySspo5xDq9md/HDrJa0kXsdo6tDc34quqyW8oxm+PBRnvvTz0fx6h4jAGcX8lASyChay3OyQecFOpuiVtTtWQB7d9KWGrJEoCTquevAw2NQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6097
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278872-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,blackwall.org,gmail.com,linux.intel.com,lists.osuosl.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: DF18A4082BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/15/2026 9:30 AM, Simon Horman wrote:
> On Mon, Apr 13, 2026 at 09:14:20PM +0200, Petr Oros wrote:
>> On certain E810 configurations where firmware supports Tx scheduler
>> topology switching (tx_sched_topo_comp_mode_en), ice_cfg_tx_topo()
>> may need to apply a new 5-layer or 9-layer topology from the DDP
>> package. If the AQ command to set the topology fails (e.g. due to
>> invalid DDP data or firmware limitations), the global configuration
>> lock must still be cleared via a CORER reset.
>>
>> Commit 86aae43f21cf ("ice: don't leave device non-functional if Tx
>> scheduler config fails") correctly fixed this by refactoring
>> ice_cfg_tx_topo() to always trigger CORER after acquiring the global
>> lock and re-initialize hardware via ice_init_hw() afterwards.
>>
>> However, commit 8a37f9e2ff40 ("ice: move ice_deinit_dev() to the end
>> of deinit paths") later moved ice_init_dev_hw() into ice_init_hw(),
>> breaking the reinit path introduced by 86aae43f21cf. This creates an
>> infinite recursive call chain:
>>
>>   ice_init_hw()
>>     ice_init_dev_hw()
>>       ice_cfg_tx_topo()         # topology change needed
>>         ice_deinit_hw()
>>         ice_init_hw()           # reinit after CORER
>>           ice_init_dev_hw()     # recurse
>>             ice_cfg_tx_topo()
>>               ...               # stack overflow
>>
>> Fix by moving ice_init_dev_hw() back out of ice_init_hw() and calling
>> it explicitly from ice_probe() and ice_devlink_reinit_up(). The third
>> caller, ice_cfg_tx_topo(), intentionally does not need ice_init_dev_hw()
>> during its reinit, it only needs the core HW reinitialization. This
>> breaks the recursion cleanly without adding flags or guards.
>>
>> The deinit ordering changes from commit 8a37f9e2ff40 ("ice: move
>> ice_deinit_dev() to the end of deinit paths") which fixed slow rmmod
>> are preserved, only the init-side placement of ice_init_dev_hw() is
>> reverted.
>>
>> Fixes: 8a37f9e2ff40 ("ice: move ice_deinit_dev() to the end of deinit paths")
>> Signed-off-by: Petr Oros <poros@redhat.com>
> 
> Hi Petr,
> 
> I don't intended to delay this patch.
> But could you follow-up by looking over the AI generated
> review of this patch on sashiko.dev?
> 
> Thanks!

I'll take a look as well. I recently included this fix in Intel Wired
LAN update last night, so hopefully nothing too problematic...

Sashiko says:

> While this code wasn't introduced by this patch, the restructuring makes it
> more visible: can this cause a use-after-free if the nested hardware
> initialization fails?
> If ice_cfg_tx_topo() triggers a topology change, it performs a CORER reset
> followed by an unroll (ice_deinit_hw) and re-initialization (ice_init_hw). If
> that nested ice_init_hw() fails, its unroll path frees hw->port_info and
> destroys control queues and mutexes.
> Because ice_init_dev_hw() returns void, it swallows the -ENODEV error and
> falls back to safe mode. This allows ice_probe() to proceed with an unrolled
> and freed hardware struct, which would result in a use-after-free when memory
> like hw->port_info is accessed later.
> Should ice_init_dev_hw() be updated to return an error code so the caller can
> abort the probe when base hardware unrolls occur?

I think this suggestion might be good. We fail in probe if ice_init_hw()
fails regardless of "safe" mode, so having init_dev_hw() also fail if
the reinit fails makes some sense to me...

Thanks,
Jake

