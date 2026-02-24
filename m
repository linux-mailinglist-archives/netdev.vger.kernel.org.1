Return-Path: <netdev+bounces-260406-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aABYCBdpnWnBPwQAu9opvQ
	(envelope-from <netdev+bounces-260406-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:02:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6641842BA
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36073301C885
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 08:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DB436921F;
	Tue, 24 Feb 2026 08:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B17KjHLL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F25303A07
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 08:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771923441; cv=fail; b=cl6I3hjUpY6F7Bimw+b4ENwomyx1fEqipF5TWPJzrG6eS/QR/fQlFgHI0jBv0kt7RBdaMv/BV/OurGtYKO360N8HSSvyoyboWD3UrkFhRvUF7a8vlRiMhonno15j893gdGCh1ncofoSpdAKwRVjwWoSh67uuy8Sw3ACXg6v5ofE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771923441; c=relaxed/simple;
	bh=8CcOXLmq4/iouvhmrH8pBE9Xajkh/OTP9Cu1Ax/dELk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BOOi4HaxvX42j/DuARVKM7YSJAa7iIVq3Pw3dMAk5Kj/HhxAs96NZRIxYX+Yd9fdaYNMsgd4mwpQ3jDPFbHeYqX9jfYpwLxgkaxrpe9pvcQI96sUPG1cEK0EIYyvzVWu2p84Xwoukz3mIOHr3hUiH3w0BUe1+cj0Y6dCrOVnocQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B17KjHLL; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771923440; x=1803459440;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8CcOXLmq4/iouvhmrH8pBE9Xajkh/OTP9Cu1Ax/dELk=;
  b=B17KjHLLCeaT1IMYvady8XjVknCEb8jYbHH2Q7+HkVoOZCWUkkT2yQYt
   BzwyNun1/4Tyd8LKSdKNf3ea6t6R2K559L2NKuhu7jNIU8slDv9brVFQo
   7fMUB23gehp4N2GAPZVMK/Hq8F1oOATZ/xWCE+74JIDT5xo06YKj2edAD
   LYcsdJNGmMCg6260OsbcqoPerwfvlkuTtfIE/zQqs9I+zTK23ry0w0b4L
   j//2IlTj1bbGFjclN+MS1H6QtZPD3FyfeMFBNujHfNyh2xz9oWDYLNSsn
   UyQqzK3ucnhWgMgr2wLNSD5dqiL6l6JYCn/JPl8nBZbOaVsTc8gmQN/Vv
   g==;
X-CSE-ConnectionGUID: cVKBQ6ZnTSSvzftcEVq7pA==
X-CSE-MsgGUID: e7muhWOLQKKQkWyQw39ooA==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="95547146"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="95547146"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 00:57:19 -0800
X-CSE-ConnectionGUID: VVa2XwwESi6WSMWkpq035A==
X-CSE-MsgGUID: BPF64cU8QXq8rp8VOjGvIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="246420347"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 00:57:20 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 00:57:19 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 24 Feb 2026 00:57:19 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.54)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 00:57:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rW+AK/ohDBN3ZyWp98q6II6LCMiPSZEhvhwSLtIi8kzbSTivpsKIjSMdKqiTqbKc5M8TGHuD0EmURiNadJY3bW1sl/lFFiHjGL5RVyZ4Z6tiHzei0+s081n5eFO/OOc8M7Gz6B8PpDQ/Fs6XEzEpa2g5lpIF+2Q2FKtNuiOlsb0i+1q8ZlOQofVdO6E8AbM9UFjuVTFFXEQ/kGMgOEXy/OHI7XVOQ7WPKoL/BFNsAOrbeNbHefYPhwn8FixhtGZ1RGy3UsyRA0ZEAKNu6xykgEtOvqpbwtstfhQqnHZRxx3509eQg80Tl80x6pXdpkeQmndsFlpX+0RYjuxvsS3Qiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2Qb9IhVktwM5uZy9ZznXLoVjUpkGpDb9qcG9AQ1Tyw=;
 b=J48I/wQvudc1qughk/JrDPN/uQ0SJ+xTQ2D4TT7etNd0m1QVHyyMc/XhiwLELZEiwo1x7eec9/Cu7OXukvusN4FDUIQrppEW5Z4leIMZ87MyhX6TA0uSov8B3we+mTjpRq3agcwpKxp8uH3rcV/jkZW/Xko3zeS2MXpXHVvrmrr+kH8lgjk57DvSTif/c+cb7qIssU4MHwdvJfHKCz+1lEHXMcqc/TTzszzTEOmFXfLML2/87ng8WqzP4R0YwOlzJ4Ss6mB4w9zFvPmwc+S4iqhsg7TJ6qCIgZYmP4hkyKOys23VBSTVMBlJaYoAZTmWUZpuks8v8F9eefzxSPz48A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA1PR11MB6870.namprd11.prod.outlook.com (2603:10b6:806:2b4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Tue, 24 Feb
 2026 08:57:11 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 08:57:11 +0000
Message-ID: <9e9c69b6-643b-40c4-afe5-fdbcb185755d@intel.com>
Date: Tue, 24 Feb 2026 09:57:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] ice: dpll: Fix compilation
 warning
To: Przemyslaw Korba <przemyslaw.korba@intel.com>
CC: <netdev@vger.kernel.org>, <anthony.l.nguyen@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
References: <20260223143214.241797-1-przemyslaw.korba@intel.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20260223143214.241797-1-przemyslaw.korba@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2PR04CA0043.eurprd04.prod.outlook.com
 (2603:10a6:10:234::18) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA1PR11MB6870:EE_
X-MS-Office365-Filtering-Correlation-Id: a2747d98-5c03-448d-e00b-08de7382b248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Yjh6V2VqT21HeWFjVkZWSmFOOHIxZTgvU1gzazF2eDNWQmI4Q2N1N1A3aGxV?=
 =?utf-8?B?WGV4VTZTNWRPWEJxVlhWc3VBd3hwWklZaVB5dHhsVFVJQmw0TWNxTllTeEVS?=
 =?utf-8?B?SlZCc0o1NG1HRXEyTm9DUzJsTXZ4d3JJekxycHB3V1dyNE9mNDFYU252R014?=
 =?utf-8?B?YlpPaWFFVnhFbEs4OTFjY1FqSGF0cXQ1NHVHbzBILzFrWWFOTi9BREhzcUtB?=
 =?utf-8?B?NXFDTitaSTdLOHZLbWE4T2hBQnkxZ0lkOElEUDJ3U3AxZ1hqR0EyWW1CYXZO?=
 =?utf-8?B?OEFuSnVSK1ZwYWpERlZpQkQ0OEhKNTgrT1Q3SHUzQzFBWGRMeTBsd3JvRkF1?=
 =?utf-8?B?M2dXZFdWMEl4WnY0RXBtYUlnUkpLbTZuKzBOOWdBTzdybWJRUjU3Yk5oZDZu?=
 =?utf-8?B?MUsvQmovSzIzcTF6NFpDUmNaZ3RaVFowQUs3M01aUnlJRTcvSjJSbTdhZnlo?=
 =?utf-8?B?RE5MRDc1enlXZ2IrdmlySUhON0JtS01qWDMrYmNCRDBxUWkvbnpZYzIrTjVy?=
 =?utf-8?B?c3VBSmVLZWNCV0NNU3JKblFjRjN4TUlqOWFyNXpnWDRGYWhWNWppRWdaVkhX?=
 =?utf-8?B?VUtkVExVeWp5VzlwK0xKeXB6bERWUzc3WXJFYnRuMEc0ZFlPb2l3Vi8yMHdY?=
 =?utf-8?B?bGY4TUlmTE5QeGNQcVhFSU9wTXROdWVwWC9lVjF4NEJLSkdrZUhqcXZ6d2Z6?=
 =?utf-8?B?STVURVFWN3NURkMxekZWMFV0MDdMS1VPMVFWVy9uWngwWW1CMWZRUFdKR1Fk?=
 =?utf-8?B?dWZ2RFdTVFJmMXpUT0tvNC9jTjZCbUxqNzlyaythZWRLMHB0cllmczJOUEZR?=
 =?utf-8?B?WUMvTlBSc0RpcHRRQllYYWJQUHBUZGVsR2QvNm04dTNZbFlJMS80SVJ2NWxK?=
 =?utf-8?B?R2dlODJDa3FZQy8xRm45aTlvUnZoMnJWcTRiN1VWWTJ1U3FzMHJXWjl0cm9o?=
 =?utf-8?B?VEtVUDdabkJkcUMrdnZTdFBVd3Y5ME1GREdIaHQ0bHUyYXBRbnpNK1dJeDFu?=
 =?utf-8?B?YjJaNXdDY3N6SHFPcmhFaC8yY3RmbTdSdmxTaDd6dHZnUmtBM3d5dmwxTUVl?=
 =?utf-8?B?OVVxNndHai9xUysrNzlqTVlCaWVVVHFtMFByOW9kc1RleVJRcVIzUjJZYk9G?=
 =?utf-8?B?QSt5WUhDbWdIaXNDUWFxNWZyUThUTXJqUjN0bFVtaW9lcGlxTXYxbjF3Y05w?=
 =?utf-8?B?WXdhMjBZanJMVldTakhwY2RJSTRwWnB1UGFjN3BmbWUrWHpHeDVrcFVHb2tY?=
 =?utf-8?B?WS9xN1pWank1anNVVXlYbGZId2VCaWV3N0tBLzdnT0UzZFhxMFp5R0lwTEFO?=
 =?utf-8?B?ZUNVZGk0T21Fb25wU0VJdUllL0Y2MHpsdDh4UkxkcmRLc3lQS2M1YXJpVm1O?=
 =?utf-8?B?LzUrc1RnNkRLbHNtT1RRS1RuZkhMY1JxSlBtZU9WVVdKbHc3a0ZQZEtBK3V4?=
 =?utf-8?B?V05wdWpqZUpvamxENU1GVVZYeWtRa3dBSXlBZFAydWorajhBSzdjSjdKaEI4?=
 =?utf-8?B?NjhGR0tlSkNkUnQ0MUozTElIOWMyUjYwNytuVmduYUJCcFJjWS91SlVINXpX?=
 =?utf-8?B?aVp5REdoNmg0NjRxcHJ6aEZsVkIzbDVhbFQ4NFN1ei9XVjNQcmpyQVdKbGVD?=
 =?utf-8?B?M2pRMWhjODBzUGRiUTB4WHZnTElMODJVck9yaHB3OEdRT1JJd3JyNndKVkxa?=
 =?utf-8?B?cUt3aUlqRW54ajZLcUhXVjFHMG5TUHRzQzJyb2pVTmNMOWtYRCtHcHNJYUJR?=
 =?utf-8?B?cjFPZkxSN05FREpqWjZ0STlQL2hPRTZ6UEMzNDA2c3M2UGNCSSs3amcvSWNV?=
 =?utf-8?B?NVJqVkM5cmVBTm9ZU1U0N2tvK1FWTXlMYmJrbkN0QS9UaGVncXBJVEpzek9K?=
 =?utf-8?B?eU5Wc2EwSTN0c2pZc2liMXZJRDVHaVEyd0xwOURUVTBqclZnVE54Q2Jycnp4?=
 =?utf-8?B?bThPQ2pab2pqZVVtNUJDdzVSRE1TZVdReDhaZUZJc0J1RkwvL01ESEw1aHBp?=
 =?utf-8?B?NitVNk5WbHdZRE9ocVVCU0d0OElkTDZ1WCs3anN6Q3hERFM0aENUNm5GSlp6?=
 =?utf-8?B?Ri9Rc3NhUitJclpERlp3YWxTcHg1ZjBOTHdMMG5PN2s1eG5ObmNvYjhjRXpj?=
 =?utf-8?Q?k+4s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0U2NUJsNGtNMUoxNkdQb3RqdVdaWjZlRDFlNm5RdkRIZE4ycmpIWEhseEFO?=
 =?utf-8?B?WHhtbm11ZW1pUy8wN0NFaHpWSXlxR0toWWNyamNCVlUxKzNJczU4VWswV1M5?=
 =?utf-8?B?SXVxMm14bGVzMnFRNUhnNkdUcDkvcSswNlRpbHM2R0FsVmdPbkFjYTlqMEZ6?=
 =?utf-8?B?TlVDbzRZUE1PdGdZQUpKdlBtZXVCakFmK20yMTJORXZ4ZTRNTkZnSm5KbjNU?=
 =?utf-8?B?SmNWNHgvQytlWWxkTlJ0MDl2K2VYOWp5QjlDaDZVNmUzMUFuY0dmY1RkbGV4?=
 =?utf-8?B?T1hoQ1AwZUVnWlEyVEp4NjB6WWdXTExRY2Mrd0JmaTAzV1huN2lyQjlWWWt3?=
 =?utf-8?B?RC90c05JN05ZMXFnUmVLa0JHZnJROEVycnVoS3pLZ2Y1Z0pFVUNGR3p5d28y?=
 =?utf-8?B?WnNDNDRCY05ZT2ZkTG9pVVZCbGxlWUFjRE5FRHJNS0U2d3hJakRPa2RXOVhL?=
 =?utf-8?B?RHd2L240cit3SGw5ZnA2NnpHREdST0N2T0dLcW5SMFNTMVBDbStCbVMxV2lZ?=
 =?utf-8?B?UUZpeS9Oamd4QTduZXA0VGhVRlZaSm1FMG5ZU25WWHpYckNuTFhET3lYc1Bt?=
 =?utf-8?B?MmEwbWVtT295SGVucXFsUFJrV1ovVjdKTEJsVkJHb2w3VkV6VUcxN2RIYjhu?=
 =?utf-8?B?V1NVZEVhc3h0ZGZYZkNnRGRNVFA3SlEyM295N2hhZ2Jya0RLT2UvK0ttSDVK?=
 =?utf-8?B?NDNXS3JiTE9iV1FHWUZOdnVKT0RJSGltcjljUmd3bHVRaHp0Q2dvWVhJbUxS?=
 =?utf-8?B?UFJudUZOZ1BWVFhJaUwvMThicnV4OHcvVDkzY21nejF2c0hBWGQwN1JXU3VP?=
 =?utf-8?B?c3ltL2Z2ay9aTkFXNXYzZDBRK0ZRR1ZHQUwvT3krZ2Uxa3Q4UVBFZVNPVjM3?=
 =?utf-8?B?ZzVuVWJncXVLa1IrSkpGOExId1BCSThLVEtaSnFHM2liaEdFb2Z4OGZMbCsw?=
 =?utf-8?B?RTRQamVOeXhrdDRRMi9Jc3U3VlBTWU9oZFdweFFjczlJRHQ0TTRHcVZHV3pW?=
 =?utf-8?B?alpyc05abmphVjJmZ1pHT2owc3l1aDBCK2RQMTF3ZDlJK1FjeWRIU0hlbGJk?=
 =?utf-8?B?a0lKT2hHY3dOUmw2WElyWWZtajRiOEtYZDdtV1dXOFFnU3g1bUJQN3dFSmhG?=
 =?utf-8?B?VVFqSzQ0eUVteDVPT2MxalExRnRwVEtnelJoNHk3V1V1bGZ1RnRQeEV0aUFW?=
 =?utf-8?B?ZnZCL2taUUNwOWRRc0tpU2xnVjFpajMvZ2x6elJQdzVtZjB2cTdIVXEzNUNZ?=
 =?utf-8?B?enRaODRuckZDQjZyWGJ4eHptR0VPR3VnZVloUk9UQjA5bEU5SG56WmY1SkVU?=
 =?utf-8?B?b25VWHQyb3hMQkkzSEdtZnduTVlvdzZwa3BmVVpNak9GQVNHbElqVFBYTkhJ?=
 =?utf-8?B?SzNTQWZwNWpjdlQ3ait5RTV3MUdWL3JGbkJzeVhaSG55ZERPWWw4L3k0MXpY?=
 =?utf-8?B?SEp4UFZEMDRiTEpKdTVBei8vKzdIejdrRnhxZWVEYnVPSmZvZEtTTkgvT1Y0?=
 =?utf-8?B?Ukg4M3J6cTJMNEU1aGtnaXRhU3l0VUVmNlFQWFpIN0E3c0pxRS84dUdJTzF2?=
 =?utf-8?B?ZklhVWc1VXNMYTY3eE55NnR1NzREckx5R3UvbVd2VTM2RXNXRHRESi9GN2J3?=
 =?utf-8?B?eU1SQUpyV1ZGSlV0aWgyQy9tL2dTcGVYblBCeVJkWDM4YlVUdmx5blhkZDUy?=
 =?utf-8?B?VjFzZlIyQUpicUNHQmRVUVFWVFcwRnFFbEg4d1hKa1N5NlRRdmdGd1AxZnFo?=
 =?utf-8?B?eHdnR2ZpdkdxT3EzUGt4RXJVSjNCb1VsTW9qODg2cVhsYTBlUG0rQUtDeUFH?=
 =?utf-8?B?M2NnTk5Tb3ZrejVpK3Ric2F3VGRmakdyTjBNSDNYOWdkaWdoTjQ1UHZTTWxt?=
 =?utf-8?B?OVZCSE82b2NMY3U4dlh6NWE1aXQ3UGtkakNUUExJSXlrRm5HajZka2VaS1Mv?=
 =?utf-8?B?WjZPWjVHVmRXZHNocGRmSXd2d1BNTURRTFhxN0w5UWxEU0tCbTJLL2I5MXVo?=
 =?utf-8?B?Y3pUMUY1cHMvVndPRVRrdm93dkVSQlJDbGNqdXVoWFhXL0Q0Um8vY25vT2lK?=
 =?utf-8?B?Ny9GMG1tU25hU3E2eVkvMkd4dXVhMGM3ZTlrR2c2WjcyODB5WWRLZzJ4ZVBV?=
 =?utf-8?B?RkZ3YmUyQjc5Z28yc0JCTVBmK09JT1JmRXhYN1AvUTJEZE9VOWJuQURCMnlj?=
 =?utf-8?B?S0F1VUJGbmpTVEpCNHVRZU85aEJkbm9HZVgyUUFZcTk0cmJYcElZUldxby9Q?=
 =?utf-8?B?V0p0WHhPYTd3eDlOMi9OcTBBaUJUMHRBSFFUV2k1NWZBUTZ6VWxJR0YvWDI1?=
 =?utf-8?B?WFM3ZnFNNVV1TGpIOVZjb0FLb1dYL0ZoZDNTU3JCY1BkYTBURlpjbXkyWmNC?=
 =?utf-8?Q?ZLy6C6lYRHKN5jmE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2747d98-5c03-448d-e00b-08de7382b248
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 08:57:10.9552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UCI+L2bQZMxMUk+1ZiKmt4BUaBqm5knMTRZRrRtXHRUoig20w9qyiTrVewr+dL4XCGQ8PUrHu3oKYkGbALlspAc4XH5AWnn6gtu3RtWW+dM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6870
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260406-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	RSPAMD_EMAILBL_FAIL(0.00)[przemyslaw.kitszel.intel.com:query timed out,przemyslaw.korba.intel.com:query timed out];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: BC6641842BA
X-Rspamd-Action: no action

On 2/23/26 15:31, Przemyslaw Korba wrote:
> ice_dpll.c: In function ‘ice_dpll_init’:
> ice_dpll.c:3588:59: error: ‘%u’ directive output may be truncated
> writing between 1 and 10 bytes into a region of size 4
> [-Werror=format-truncation=] snprintf(pin_name, sizeof(pin_name),
> "rclk%u", i);
> 
> Fixes: ad1df4f2d591 ("ice: dpll: Support E825-C SyncE and dynamic pin discovery")

thank you for the fix
this is a correct tag, and a correct target

> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_dpll.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index 73a4e28ed75f..f101fdb3e9cf 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> @@ -3532,7 +3532,7 @@ static int
>   ice_dpll_init_fwnode_pins(struct ice_pf *pf, struct ice_dpll_pin *pins,
>   			  int start_idx)
>   {
> -	char pin_name[8];
> +	char pin_name[16];
>   	int i, ret;
>   
>   	pf->dplls.wq = create_singlethread_workqueue("ice_dpll_wq");

3537│         for (i = 0; i < pf->dplls.rclk.num_parents; i++) {

upper bound of the loop is u8 (ok), but we assign it as an int (good)

3538│                 pins[start_idx + i].pf = pf;
3539│                 snprintf(pin_name, sizeof(pin_name), "rclk%u", i);

compiler tries to be too smart here


anyway, it's better to have that warning gone instead of waiting for
a fix in the compiler

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

