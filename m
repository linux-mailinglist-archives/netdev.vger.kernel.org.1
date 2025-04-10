Return-Path: <netdev+bounces-181064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EC3A8380A
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 07:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A52A444A40
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 05:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EE81A3150;
	Thu, 10 Apr 2025 05:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ske4Y7OZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1FF29D0B
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 05:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744261297; cv=fail; b=MlzcqqVIVr3QSMvAfAxMnR/LNbZ2QPGK4NNAzz9pDcLQW/wBaKolhPFFBX7k7RUUG5x49QEKRiLVQ/nBr6fat71E5sKlqbQLnZo7+vp+5BW+kf4WvEtsAbDgsc7mzyvCcuhvXBlW56Bi9AmOeWclppuUY1kzc8znpqqTUX2yW7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744261297; c=relaxed/simple;
	bh=wBX/H5rhOG5GqoyHsimUTU/Njtr6dBd1Y4soAhWsxYE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mF8coUw6TAv7zL+QWCP+uyzLZAsa4u7g5YGYU/WKKwXexW1E3V22a7FrcIViLCZ8cnQssib0P8EBAPHgHtdGLJYs7fl21QN70V5MRW+D0iqlftImUEXu7fHSCAIeI2AQ2x1K8/tPkBmJp8s92cPGSnYpUYylPgz0qJ46kYuMDHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ske4Y7OZ; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744261296; x=1775797296;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wBX/H5rhOG5GqoyHsimUTU/Njtr6dBd1Y4soAhWsxYE=;
  b=Ske4Y7OZKGx7f6PkY4ynEDfvDiPB1Heu1Pk6XgS4IXfWfTHXXZ8GGxGD
   pNYIvOxol3FDJ2g3dxv3ho++QOhOC5znAo6hIN604amT9N9T4ca56K43a
   bDDDE4q0sHDjFvmmmtVAW7g42OkYl510+RclUAQvxISk0Cjvaj5j1zBMf
   veegghefIYTK1Oo0Rd3bsYPCPwi4bv4RwDQs3fJ8/dHzDxkozdf2MzmWu
   h/9EQcnFwSC0hHvwl4BsDsdUhj7VFIrtViQQX/5FLwRUj8WX+oAxFlGV+
   nMAmluWN/Mja3tDhIukqeR7G9nH0NWcZkt/MIdPEXg0YwrOXU5aBWw5Lk
   w==;
X-CSE-ConnectionGUID: KM+oFxCYSIOdWD9Ya69VVg==
X-CSE-MsgGUID: fQgzRvhoQjWSLt4Vm4OYhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="68246445"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="68246445"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 22:01:35 -0700
X-CSE-ConnectionGUID: r7iXZGkOQRGiklIwv0a7tg==
X-CSE-MsgGUID: T/o+9nnEQpyPoNUhV+9TFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="159769851"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 22:01:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 22:01:34 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 9 Apr 2025 22:01:34 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 9 Apr 2025 22:01:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fs5z2cDfg7y4ld9TbHA/f7ver6R/V5eddwCjLZFzdHczkCCYjSJohuNDsBEVJo5R4SJDEyFpsLgrtIA6Iz47QukUqquM4yIcwldJTpC8Rx0QoZOKKkTqjI/cVi5TUWXlIFLkxu6chK7NFLG4wfDXLJeKq38Hx7E20yPzLF3bn5nyDeYX9Gxi9j8O6RfAn/MRiOqNyaZTS9j4ESsYR+GT838HK3jYsFTUiZdg5iWW//qVFO3x+mmkJEIOibXwRhvFwmKjojlA9/QcxxsPm5AwDxM0aNgvztHYD4pT27RQpA8AJSutMhRvkyg2KXy/pziLuCydpIksaDNJxhE5uIuSqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMfVHIzyFZzdhYRqtdVkNfBPibwVYYwx2vDPzbNauJQ=;
 b=EYnsHCIIK9k3vMQ4YiSdytqEwRxIGYT7KrLmY7nr/D2WzMO/1ZR8q0aFSbzu+Ix1WFEurqQPdFfO/OoBbEFkTGSIV1WmFSd2WedIyQ+RoW1RoCUdhR1S6zuPtU2zNV9XUg1JBuEEdtCxSxDII2LSri6Q7SL7wgigLE+QKc3EXk68sJ2qvNUIH5O05U0+1gWDQSycOlw3/5ov7gJmEKF5VaJkEz7fYIyqOkMxSBBOho0juqMwAvjn5q87DDJuBvLj0Nk7L6q7QJ/rcMGk2mWIFBtPEGdlBnDZQwJuncUkX6qUFP5MAXb6pIu9iax0DknpSovB8Op7IS42OVX4YibQCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH0PR11MB8085.namprd11.prod.outlook.com (2603:10b6:610:183::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Thu, 10 Apr
 2025 05:00:58 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.017; Thu, 10 Apr 2025
 05:00:58 +0000
Message-ID: <8580a516-0bf0-49f0-9431-cb8f79fc4f83@intel.com>
Date: Wed, 9 Apr 2025 22:00:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH intel-next v1] ice: be consistent around
 PTP de-registration
To: Tony Nguyen <anthony.l.nguyen@intel.com>, Jesse Brandeburg
	<jbrandeb@kernel.org>, <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
	"Jesse Brandeburg" <jbrandeburg@cloudflare.com>
References: <20250407232017.46180-1-jbrandeb@kernel.org>
 <afcafd64-d7d8-41cd-8979-c76aaf4c1b04@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <afcafd64-d7d8-41cd-8979-c76aaf4c1b04@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0270.namprd04.prod.outlook.com
 (2603:10b6:303:88::35) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH0PR11MB8085:EE_
X-MS-Office365-Filtering-Correlation-Id: 06157c10-47cd-43cc-4dba-08dd77ecae61
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVZKMDRrRnl0Ymx3WE5iNi9Ib3NuWHlKenEwa0RmOVQ1UGdBek10eUJMQ1pR?=
 =?utf-8?B?TlZibXBBVW5zYTZHd3B0eDIwcG40K3JYY3Z0QlBBS2gwbHVwckpQeXdzM0Np?=
 =?utf-8?B?QTM2MENsWWZWQm5seGhVU0p2Y3ZUQm5hdWxNcDdKQzNRSFZmZmJLMU56U1ht?=
 =?utf-8?B?ZWxTM0d1ZG9abmFIbmlEcEEzblBLQWgzYjJrV2FsQXJDdUtQYXZwMjhyS1ht?=
 =?utf-8?B?NERpM1hidVJLYjFYNjg0UWFoalREbTFXOFc2bXk1R21BUWFWcXg4Q21UWFRh?=
 =?utf-8?B?bWRGdUloT2dYWEpWbnp3MTNpNUlVWFRZYVIxM2xKUTd0K1dDREdseFU2dXF1?=
 =?utf-8?B?VEZEZTBLUTJSdk5aSjFhNVJkOW9zWGxKRHdiUnhhaTN4WUw1WkZqUS9RQnVu?=
 =?utf-8?B?bkYvV2xrK2haMTl3Qk9BbmtGd0tiK3BrcnJESlI1SzZ4N3hkVHYxcXRyVDkx?=
 =?utf-8?B?ZXdISmZsRHkzbnVKNWJrQlZrdEI5SmtlZnpqYjZSTEtUSFhuV3lxN0k1b0NT?=
 =?utf-8?B?SlBnd0NQbFZJTHdXUDNyV2NVYmJXdGVLZEY3eU5DS0Q2V3Z1ZEovcEhoVkpS?=
 =?utf-8?B?ckJoT0JTd0pzeEhjWEdkM2JYOEVxelRaQjg0M25COE9iTlVuN2p5WFB4S0pD?=
 =?utf-8?B?Ym9ZbVkzMWlVNWlUQnVsLy9BV2lNaVFDRitSdHRhWURNK1p2bzdkRVZtMlRE?=
 =?utf-8?B?SjczUzc1eUs0b3l0UjBmZS8xZ3orYnIzbldVVWd2ZzlnYlZjb0o4bjZPdkNx?=
 =?utf-8?B?RzNMOXR0cHE3Wmg4SnpTN0NGV1NiejQ5SE9tcmd0aVJwTysvOS9SbE43SHpC?=
 =?utf-8?B?VmJham5lZ0hHZ2NtV1BPR2lZTC84MFNlbFJMaWl6akxVanJFQnNob1lITWF5?=
 =?utf-8?B?amw2cktwZXcxQ2FVWi82ZVVBNGdpSkNJalphZ1krQjY5b3dzZnVJTjhuRHFR?=
 =?utf-8?B?UVJCWDhySDhaa0NoTVhvQTBRRXFnOUlWMHh2OTh3MUxxTGpZeHpyTS9WYlI4?=
 =?utf-8?B?aEh5STlJdHpHcy9IejV3MWxsRGc2VnNFSUhKb2dNaVlXMUVZZEtETU5wM01u?=
 =?utf-8?B?UEhSRDFQNndQUnNVRWw4OHlvcUNBa21taVhEbkN0Mlg4b1gyaVVUellDR3F2?=
 =?utf-8?B?dXpNc3VKMTRNLzJiTTBtVzhOYjNBYnQ5bEZwL01VcjhUQWowaExjd0ZKT2RB?=
 =?utf-8?B?aktWU3hxV3dpaXNKRVc5RnFMVzRuZlh6Qy9nMERMUTJWZEU4MmhRVUJ4bEpH?=
 =?utf-8?B?NUVvM2lnQ1NVY0ZvMzRXU1p5ZmRxSCs5bDVTL0ZnVG8vTkluTlRVT0NLYnZZ?=
 =?utf-8?B?cG5hQ29hYkRvMzlubTZoSHo1MkZ2bzJ5Z1ZydXlVS1RYbENHbGtjNCtwQldQ?=
 =?utf-8?B?NWUyM0YrS3l4V04raXQvelJ6WCtYbFhqeFNUMTFudVJJNHorL1ZadmFOVW1P?=
 =?utf-8?B?TkMwTjF1WmpDYTNTVUZZU2RmblNlb2JSMWltb1hjbnR2cy9RTmdnZFJjZ2tn?=
 =?utf-8?B?dmRFeDdtL3pycUtkb1VST25rUGtEeG1uNWZVZTc2YWdMVzdJSXBTQloreVhi?=
 =?utf-8?B?MUd4ZW80YytJMXVIbXBGaURSWlgrZzlSeVdGQ0pWYk1uZ0tZMkFzWkdMOUpI?=
 =?utf-8?B?TjhLM0N4eXhPNWVHT2k5RXFxS1JxNlhaYVdtbDhzelRhL1krbSttYjBhd1h1?=
 =?utf-8?B?eWlnK29hM0ZlanREU25MdUNieE4zdSs3Vk52TXBFTlFqTGNlYTVyS3FqUFdK?=
 =?utf-8?B?WS9pL1V5Y2VKc1Z0bVZHU3VMd2RwT1E4cURNbVBRQUo4UGZjOUxJbzgzYWpD?=
 =?utf-8?B?a0xVMHJNS0pIaTRoN1VCVEtpWmllL2pvTVg0UmZNZ0FtOTNvSy9rSFlEZFR4?=
 =?utf-8?B?eisxZGlQWVdMRkhHRmJiYlVvQUFoYU9iUXN1U0gvTWEya0E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0JYZXBTSkZFN1R1N1hXb2FWT0ErcWtxUkF4QzRlLzZCdVd2Y0hEZDh5UGox?=
 =?utf-8?B?Y1M3b3FieGJiSmFtYmRSM2hacFVMZ29vYW5qWjNiZ1kxcVBHb21aeXBINXY2?=
 =?utf-8?B?MXJJZjBwWUgzTDRSR2VCU3JOUi9qNE1LQXFYMGVXdUdpbHVuRytjUGE1cVdZ?=
 =?utf-8?B?MEtEaXhhYlVqbElmMkNpUVlPdlFFQkdsUmF4OXNLM1pKL0xqZ2xsamhXUG01?=
 =?utf-8?B?MGFTNnNpVEw2Q00xYWpCN05Qc0FoQkJtSHVla25uL3ltVitRbFd3OVdaM21v?=
 =?utf-8?B?Zm9rRkJ4RG5nVzVuNHNrdml1bGxER0Y0WTZpS0VpR2hUWnk2cEdGazZCUGg1?=
 =?utf-8?B?eGd1aTUyWjc2NUtYVVRWN2tUdXRwNFRkT3hoYmNFeVU1eVpHVzNnb0RKNFp3?=
 =?utf-8?B?QVA5akkrUFBTME5MaE9kM3pHMmV4aFpGTTcramRZem8zcFhlUUo3YzM3dGlu?=
 =?utf-8?B?R1huYkZhaXlnOVVFZEtaSEpzNDhHUHNkSXdneUU4SW9IQU1kd1hIcHBwbTFy?=
 =?utf-8?B?U01TMU9RUEt2aFNZVkswVjRJL3EwWDdlQVcwZmgzblhuUjMzWFFOY1FSM3cy?=
 =?utf-8?B?VEZ1cmQ4YVVwVitZL3cxczRsSm8rNFNDK2crQStZTkU4OUhMaGtSUDIzYXRw?=
 =?utf-8?B?NFZ5Sk9NRlFORjdwMzdJOUd3QzIwc0hqanZOdDJOYjEzQVFHQVg5MWNoOU5r?=
 =?utf-8?B?dCtSSEZZRHNYSUExZVJsTkd3VGF2djU2YXFEWDc4anZ1VnlQR0UyMHZYVDgz?=
 =?utf-8?B?eGVPR1VuNVVTMm9qbWZOb09GdFNDVW93Y2JHSXVhY2ZBUXA2ZmZuRFl1cHZ0?=
 =?utf-8?B?UXVMOTJwSEdIQ2R4QS9zaTdFSSt0c1ZrRnZSY0swRVpUSUlWR3luclVndHpl?=
 =?utf-8?B?VmpaUEpWSXQ2dGdxN0FKb1Zld2Z3RTZNS0pYaU00K1huK3NxblVqLzZnY2JX?=
 =?utf-8?B?MEVWUU1hQjYwRHUveHJpMEQ1SXBWcDB3aGhEZ1lCcVVJMmNXajJqampLSmNS?=
 =?utf-8?B?NytqWFhCdDRLUXl3QUVYSFdsVjA4eUdUS0VnYjhOYkpRMnMvNkJJVGNyQk5i?=
 =?utf-8?B?RXBUYUFTNVhxNks3QXRMREo2ZWtJZVJ0OWlrNUxXdmZQVThIeGp6U0p0K0h1?=
 =?utf-8?B?a3Z2Vk1UMmRiYm5NRFVoRGtGL2ZvaWpRRC9LaGlJS3B0bm0wdW9TUFV6b3M5?=
 =?utf-8?B?OXp4U1pnbk9reWlTbjA5NzJERXJBQkxnUS9hN3BNMWxqT0wra2UydE52c2h5?=
 =?utf-8?B?Nno1aUNwT296blBRdDVNS0MzWXBQSEllUUswZWpwTkJzSHdhU0RhemlLUnVm?=
 =?utf-8?B?cU9aQ1N4Wkp6VEtXVWdva3AzSjF4VUs1cmRnMnFqZDgxMWtmSU5aOTA3eWxr?=
 =?utf-8?B?aEZRWUdmS1NBZkFqYUlwQjNaZXRTUXNINzA5STJsRnc1dXh4Y202anFpY280?=
 =?utf-8?B?QnZveG9OSlc5N0xmc0pNQXVEQXIxL3BxWHdFWVVVUG5WMm9iWXAwajdFa211?=
 =?utf-8?B?Uy9OZjRvekd6UjIzQnF3SU14NXhPRldWZTZaV0puTFlzanpDM2g0dUl6RWIx?=
 =?utf-8?B?YXltc2d4T2pOY3AvejByci9tTDYrN1d2VTY2YVh0VStISVZSZmpmbmUrQ1RR?=
 =?utf-8?B?Q2V4bUs2bDBhbEUwWjRDUHBqRUNHWmhYLzhnUjJrYWVsN3AxQm9ObWtwRVhY?=
 =?utf-8?B?a2MwM3A4b2kyYzl0OVBTMWt3dG1Ec09vRHovY09laTIvS2FFa1YwUW1EY0dV?=
 =?utf-8?B?WGlNRjM2ejNVSmhFd2xDZGxIYzUxcFBOakpPZkgyaDVxdUFiQWFnYWlINVZy?=
 =?utf-8?B?U2pndGF3WTRjelBNTmY1bmlZQm5JbkdjKzF6TTlsbUF5bEtTL2tUeW1xcEZU?=
 =?utf-8?B?ZW8wampzUExUdFFNenhXNDV6YXQvUGx3MHUzT2pCZTZQdjNFU2Z5Z0pVWlhO?=
 =?utf-8?B?c1V5ZldDSFFNYkxjcW9QUU5jMFI5eDV1YzBacUIwbjJBT3lqTi92eW5wZisv?=
 =?utf-8?B?MGtvMVVGOVNHZHpMaDhDdklPeU8xcmRXK0xzNTB1M3V1NWRFQkRtZi9XdWFH?=
 =?utf-8?B?ZWxHMXZ2V09LZHFkRWYvM00rVThuZjFPYUJVeUNOR2cwR3dmUkF0alBzT3Zu?=
 =?utf-8?B?WTdmZHFQSTJLMDBzc2lIR3QvNzc4U0FMejZEV1UzMHozeGgyT1Mya3d5d3JU?=
 =?utf-8?B?SGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06157c10-47cd-43cc-4dba-08dd77ecae61
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 05:00:58.0178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r2ziYpqa3+IqJqkmATKqlv+4UePh+9HxnSSk3BpGUAZy1Tq7mF+VEOUaYR0fzuqbadoSHihHh9xq4jJvUkiCqL6gMFLLYd389SbC9RPnb7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8085
X-OriginatorOrg: intel.com



On 4/9/2025 2:54 PM, Tony Nguyen wrote:
> 
> 
> On 4/7/2025 4:20 PM, Jesse Brandeburg wrote:
> 
> iwl-next, not intel-next :)
> 
>> From: Jesse Brandeburg <jbrandeburg@cloudflare.com>
>>
>> The driver was being inconsistent when de-registering its PTP clock. Make
>> sure to NULL out the pointer once it is freed in all cases. The driver was
>> mostly already doing so, but a couple spots were missed.
>>
>> Signed-off-by: Jesse Brandeburg <jbrandeburg@cloudflare.com>
>> ---
>> NOTE: we saw some odd behavior on one or two machines where the ports
>> completed init, PTP completed init, then port 0 was "hot removed" via
>> sysfs, and later panics on ptp->index being 1 while being called by
>> ethtool. This caused me to look over this area and see this inconsistency.
>> I wasn't able to confirm any for-sure bug.
>> ---
>>   drivers/net/ethernet/intel/ice/ice_main.c | 5 ++++-
>>   drivers/net/ethernet/intel/ice/ice_ptp.c  | 4 ++--
>>   2 files changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>> index 049edeb60104..8c1b496e84ef 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>> @@ -3968,8 +3968,11 @@ static void ice_deinit_pf(struct ice_pf *pf)
>>   		pf->avail_rxqs = NULL;
>>   	}
>>   
>> -	if (pf->ptp.clock)
>> +	if (pf->ptp.clock) {
>>   		ptp_clock_unregister(pf->ptp.clock);
>> +		pf->ptp.clock = NULL;
>> +	}
>> +	pf->ptp.state = ICE_PTP_UNINIT;
> 
> Hi Jesse,
> 
> It looks like we get a proper removal/unregister in ice_ptp_release() 
> which is called from ice_deinit_features(). From what I'm seeing, I 
> don't think the unregister should be done here at all.
> 
> Thanks,
> Tony
> 

+1, I think a v2 should just remove the entire call to
ptp_clock_unregister here. It's the wrong place to do it. It causing
problems is further evidence of this.

>>   
>>   	xa_destroy(&pf->dyn_ports);
>>   	xa_destroy(&pf->sf_nums);


