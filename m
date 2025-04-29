Return-Path: <netdev+bounces-186863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6677DAA3A00
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 23:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB1C44C3F41
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 21:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC3A26FA6C;
	Tue, 29 Apr 2025 21:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aB+0498U"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0757725EF80;
	Tue, 29 Apr 2025 21:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745962831; cv=fail; b=MW2muezpV+DlbhTUQCjAIuoRBO3Qoz48DsEOfos93yFRTE6A2z85xSkNBD0g0HZ6tAhbgrjXC57I4ahesSXJlZTlPV6YpLCNnw5AjGVTeoCG8oaFPz8CH6e/MULsx4Kql7ymsQa+rIDIILlFunGkdamyyZ4k98brdDI8i4wblwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745962831; c=relaxed/simple;
	bh=AstjhpCYKWQ5v/Zubt3LuGDdx2/zCW50EAjnS/1Sr2w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UrUJapzuJuiO/yaQtJOLVKjbX7C0s+Dfw0q0DZ1sSn3NujSmVtEp8h2uvrckRe2awTjTd5ZaXJ5KjvHmga3EXVOZZzk5Y2HcHYs582FgNSz+vFL0oqAsRyviJZbg7yTOysrC8kmAQ/x6Gd/JQtaVeDk+z5LQn75qOBrUrrCDS88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aB+0498U; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745962830; x=1777498830;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AstjhpCYKWQ5v/Zubt3LuGDdx2/zCW50EAjnS/1Sr2w=;
  b=aB+0498U8uNDsWxhpEf/LKbA4kgfd6TAsG2LrG5nXApbRp3SbeNjKQdr
   RHcTi/EOiJtjPdILnvrPzRa4f8wKCBpTTO348owq4ctN/iVsvSzSo9hbB
   iXDCAsLv2TKtGvmkcyO5tGrcY8HwKXlNuJ/AchBbufQrEOSnAjE7GoRv4
   mHlljMS3G9QOKTdKv3vEx8CNDlgJ8wcEj+ZCA+Ov7srODwHu8Tg54EnmY
   PfujlcVHvqMnqx8bQNJdLgns2WwQR3p+oqz03LcjkVNxAGZCd+twaZngH
   FhJimLi5vvblaXGxY5cVJwT61LnAWv9O4yf30i6JmxIDCc1xfNQhEPgg2
   w==;
X-CSE-ConnectionGUID: P5QEwWEUSsiQiz9lFydSuw==
X-CSE-MsgGUID: DHtH86cnSy6s1XPp/Fz9eg==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="57803478"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="57803478"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 14:40:29 -0700
X-CSE-ConnectionGUID: 4n/Nj9xxThCTPuCcpclG6w==
X-CSE-MsgGUID: wxE6lWQARymoQzDbtfcO4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="134933651"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 14:40:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 29 Apr 2025 14:40:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 29 Apr 2025 14:40:28 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 29 Apr 2025 14:40:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mlsnhq20+Cz6ldaJpbDVMUCz9R8O68kKKxi1Idexy1B86aWsnz63gISZkw7z0inciuMQtjTECKkS9xr/lTv6pUQR/uw2UHUF6ZDfYQwvZe2GIMyqZJmb35L3zjU/QeY+gKOw5sgdfFBzq/eighI1f+RHO315nglZbFbD2JKhWpm+jGv2EKFiG7P03M8CiGIBjcUggzswlrku4maaqPAtRQ5goOPUGRF4EOAYroFjU9VBvfK20vbul1CJCdhaq8S4r2DM2YvMI2jmswjFiFTKr522Co1qwBUQ1Ck77/wZ2+q1meK3WHHXP8Qghd3A9dYbB0PWgBfHxyyr9aEzD+v2pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+rbmcyUe2qpZuLomY/YvnQZQjqeQGyqf2pRvfQABn8=;
 b=e7DqPK7m14O4MLmSSlMB1ozgtlt5TnJup8IYYVBY8c19myNQBKd46iqHcLs2p2UlfjkzL57uXO1xrDhLVD+v4DPw6kt9Xh9NildHx3rFIPRYtI2MjgBbbJxv22nztWRDfas4MsuFYeD+IDZxnVQ2e8IojmwywS5I24NFxH/3O4eQT5nnqAJiqlr3k5ODXC7gt4M9Vob6Yvzsr4MMR4RriFypzrDNGcQgrmIG3UJaTohBkW4yxDmW0Rg9oOK6vkbTEZ6yMBWxVKRThjo8G7CNUZUQMIol0YpTNXD+SfMOMcEtKkzS6jrM7RjhIrpYbQJWQ38FgbA616N5BLhgdZKx0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA3PR11MB9302.namprd11.prod.outlook.com (2603:10b6:208:579::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 21:40:25 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 21:40:24 +0000
Message-ID: <883ee734-b9bd-42be-b072-23640fd34fdb@intel.com>
Date: Tue, 29 Apr 2025 14:40:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: Is it possible to undo the ixgbe device name change?
To: Andrew Lunn <andrew@lunn.ch>, David Howells <dhowells@redhat.com>
CC: Jedrzej Jagielski <jedrzej.jagielski@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Paulo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <7b468f16-f648-4432-aa59-927d37a411a7@lunn.ch>
 <3452224.1745518016@warthog.procyon.org.uk>
 <3531595.1745571515@warthog.procyon.org.uk>
 <64be8692-ea6a-4f49-9b5c-396761957b81@lunn.ch>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <64be8692-ea6a-4f49-9b5c-396761957b81@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:303:8f::6) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA3PR11MB9302:EE_
X-MS-Office365-Filtering-Correlation-Id: ef976204-107e-4942-b2b2-08dd87667337
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEYyc2M3QUsrMTdoV29WTDVTYnRpcjdvT29xSFJGNlRrUUZPYXVlUnFhM2ts?=
 =?utf-8?B?amFydC8rVGRKdER5UGJ0TzE2bmtmQzF1dzZMdGthM25zTjhKQ3NIWXVRcUlD?=
 =?utf-8?B?NkU5dm42QVJmc0lndnJJeXl2WW9kZ1NEOFY3QkVhWVp4YnVTLzFkd0JTb2hh?=
 =?utf-8?B?QmhOTUxBcVd5bnlPVlZET0k5bkQ3alRzT2JBYlRlWDJsNzhkcldmUjBzbnE4?=
 =?utf-8?B?RjM5WkE2dXpMU0E4cWZQZzhJbS9Vby83dE9oUDBTYnRhMUpxc3htUENxM1U1?=
 =?utf-8?B?bTBUNTg5Wkxpcmlib2JOMHRkRWJKZy9CWEkvVjBZOC9YQzdNb291QjBieHh6?=
 =?utf-8?B?d3VUWDkvc0VQeTFCbXVuYVRUNHg4VjYzV3NiMzBnaFZ5RTlXNURlM3Z5K1lW?=
 =?utf-8?B?aWFkZGVJanNUeVRhaDJGd2xyL1hocEZoRXQ0K3N1bzM1VTMwazVsQW5ndCtC?=
 =?utf-8?B?Uk1TMytBMkR4cXJmb3oxeGFRc3hEOVpza0p0d2JVWUZaOFUvNHM5cmtSU3BG?=
 =?utf-8?B?WVNtcllaNHVWLzFseVNHZXZvTGxycjNscHdrTmFoZmVoeGVHQ1gvQS9wYkxX?=
 =?utf-8?B?NmdWUHBFNE9LdjZnVE9pcnFGNEVuTlNIbDlVTmlBU1dyMnZHMEtGbzlkNVNP?=
 =?utf-8?B?T0IxUy9ROTRRTjJqNGhteFhLdkliU1pNbnU4SVk4ZGRNR3poalN5NkNvaHJj?=
 =?utf-8?B?YjdGMG9HSi85V29kYlplUGtQM0FQdWpOaStVWER3b053WGMrUWREa1lkdEps?=
 =?utf-8?B?QXdERzZ4TUlyL0tOV2h6NCtGbjlBeWxVaHlJL0J3TnE0VTkzWnYzekptZHNJ?=
 =?utf-8?B?MWVwRmQzVjdhMzErd0xWb1Vvb2hVejY5dU85cWs2Yzk5dUlpZWNoazZKMkR5?=
 =?utf-8?B?Q3M2Rk4yMG5RSTR6S0FybEJZc0d3M2ZoRGVacGU2R2NrTTJDTm1FWHczRkxX?=
 =?utf-8?B?bjhIbTl0eS83TW91M2UvMVZrRmN5VENOSzg5LzhOL0VnWkpsN3N0ektGeGVC?=
 =?utf-8?B?M1VISGY1ZjhteHFOUXNXTUVtU1J2eVN1L1cyUVlCZE9naE9Uc3UwRURVN1l6?=
 =?utf-8?B?Ym5hZjZleG5iZ085K1pnSUlmMVlsUlFVa1ZUWGpObXU4dmxFRExJOWhUN1Rp?=
 =?utf-8?B?NFZtNkFFRHhqR3hwSDQycFhFM24yYjR1MVR3QlE3SFF1SlNwM3JqWDdGeFB3?=
 =?utf-8?B?TGh5and6eU8xYUVrb3lQdEVVMlFGRjBCdGhwN2RDUi9nd05vOUJFM2tLY1NW?=
 =?utf-8?B?aDZWb2JEQ3pxelRSekp4emZIU3NiM0dFVVRkZXc5aW4rWjNicVlNMHBhcm5D?=
 =?utf-8?B?NVR0ak13RzFLT3N3MzRLa0JGZTRXTStJVm9XUzFNcGRQakYvYjhmMXpiKzVW?=
 =?utf-8?B?Skl2aEpoV3dzRENudmdKc2NPN05XZHBLOXNjZ0d3MHRtRDBVTTRZUmtDZnYw?=
 =?utf-8?B?MjJlN1c5bmVKQjYxZmlYSFB5U08zOVB0UHhKWjNWWlNVbWxmVURiVndyKytI?=
 =?utf-8?B?VWs5NDZmTHlwNEtON3ZWekJNTFFWaUN0c3liUUFxZmNMUWg3VjlNeTBiYXlj?=
 =?utf-8?B?UXFtdW52dW9VdnNma0c3d29qZXg4cjhLNUwrVjRhS2t6S2JERzZCcTIvMFJz?=
 =?utf-8?B?WVJXeUlqeUFHd0VUc2ZtdUFvZkpCdWJKTXpXUDF5eVVxNkUwaWVhMlA0ak5y?=
 =?utf-8?B?NXFHSE5BeDF1bXRndXB2amZQNGJEaWY3Y0g4MDJNMGJHMytnRTNNR1A5TjM1?=
 =?utf-8?B?NFBBVXhEaFNVeVZsYXcwMTBGWjRTMFZ4RStCN09zVzYxa3pmV0pZZGtES3pT?=
 =?utf-8?B?UnBDckdLRHRUenM0dmUrTzVpK1NmTDF3L1lvSGlsU28rQlpCRnVQK3hIdnpL?=
 =?utf-8?B?UGZLL3VHRmw1Vk96bjE2UlJ5ZWMwOE5vRVhzdzI1UE5seGtSeXpab1ZJVGRy?=
 =?utf-8?Q?I28xJtndT5k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDhCdERYbjQ4K2N4YldSZkNKK3NaUXJQemgyS1REK0dqbGhXUzZHMHUzU01G?=
 =?utf-8?B?b0NYRlJaVGpkNnEwbmJCQXhpRjgwRndvQTZGR1RxdW9GNWNMZ0pRZFFmV09x?=
 =?utf-8?B?REtQbnhRcVdUR2tsVUZaMFhxc3NTYnJJaitUdE90OHNDQzVUUWVhbU5BN2s1?=
 =?utf-8?B?VTlBR2hBeU5vQjk1SS8ySmVndSt5cW15eGFjRFlvOGJNeU5KeWVjNHpCL1Jh?=
 =?utf-8?B?aTQxTU5jOUpiODBjSG4zVitEYmQ1S1BEM2tUNy9yZzdhSXdvaVZpMzRwbWlH?=
 =?utf-8?B?alhsWVlPVHBlQmZVdkowSUVaTlVMZFo3OWorWkFybEEyV0JTVmF2UWx3S01n?=
 =?utf-8?B?cjI5eEVsdHBFRVB6TmRsNlFOYktVdG90MmhlUFZYWEpDWkJGVGhjc0xwcGY5?=
 =?utf-8?B?RDlCdXJ1Rnc5cGxkY2YveWptb0ZEUVVKcFhqcC9mSVVmYlRRZk1rcXRuaHY2?=
 =?utf-8?B?UVNpTWxoQjNWc1ZqS1NhczFzTUl2OUNXMTBpd1JwanJ5UzNtaE5yOTFobGk0?=
 =?utf-8?B?Q0ZjcGZiY2N5UFBOenUyQTRWUWtmU2dNMFNVTkMvM3p6TDRDTWtxS2RtTXl3?=
 =?utf-8?B?TmlTczNjOVdNRWp2WGNodGlaS09vWlhnR2J1MTRnVmNoeEx5YUwrTEhwTEVa?=
 =?utf-8?B?NUJ6YVhDMnpQdnMrMVFMV2oxckV0UzZ6d1lRTXBncGV4Z0dFQjhROXpoUlZx?=
 =?utf-8?B?K0pWNmt4UGVsUVJxY0ZVRnNQODVkc3ZkazE2SFVOYXF3VkN1WnZXbUkvRGFP?=
 =?utf-8?B?QnhMN2JIQ1V6cm5WOGZJNHI2bVRmcTFodlhucU9INzlFc1phSjhCQkxnK1o4?=
 =?utf-8?B?dEVJUmczUEFLWWNVOTROZC9mUGdQN1JwRW96VHFSaGk5cUJ1a2tWV2FubURu?=
 =?utf-8?B?NTJtQTlzWlJ3d2M2UlFzdzJQaWgwYW1Mbmc0dDRGUGROcHgwU0FyN1MwK1JT?=
 =?utf-8?B?UW9sUWdSdXhNWlhBbnN3aHNTVm9YUjdJbFVIN294Qk5XV20vdHl0QzVRNFZK?=
 =?utf-8?B?SUlDRjdkQlNEZTk2L1p6elNFQVR4N0M2cGtwRmtmUGRvUEZ3THU1bkJHQVRj?=
 =?utf-8?B?UzQ4T0U2R3k1N254Z0UyUGZueWNDZlJycW1HQldVNzk0TkkwNlpObkhUd0Nw?=
 =?utf-8?B?Z2ZFUDlqSU41SDZDVERqVkthUzRPTVVzOW52YXZmTldBalBiOTRLQUMyckhh?=
 =?utf-8?B?cDBsU2hMSjNkMnlZZVc5UFlEWmhiZEE5dExtZlZLN0Y3cmJBcHQveDhveGNV?=
 =?utf-8?B?b3EvV0V4M2xWb090T01MV2IxZm9BMlByUk13YTg1ZVdNWG9MQVg0em9zbk9a?=
 =?utf-8?B?bHQ0cCtUK2JNWXpwMDdiSTUwc3U4VGVPUGloOEFnQzVNT0JDVDIvRHA2OGEz?=
 =?utf-8?B?UFlCWXd1WWI0S3I2ckpqZjhYeFY2SFE1Wm50cnhOU0t3RWdXY3BSQmJUS3hr?=
 =?utf-8?B?Z2tqTGdIb2psSWpVNm9XYjYyRUI0VURZUFRIczY4cDZMZ0dpT1IxMUcyKyts?=
 =?utf-8?B?NjlXdUdzWEJtM3g0aTNvRGdBRVlESG5LNHcwYTRYY09ZbVlqV2NZTGRZYWRP?=
 =?utf-8?B?S0NXZWhFTHdOaENjcXRlODJaY3N6WlNoMHRmN2JPUU5jL2lYc2tPQVA4bmor?=
 =?utf-8?B?dUZmdmh1QWRmZHZ1N2RYZ3pEUU1HLzJjLzZsdjJhb2JkbXgrdHpKK2o0b0Zm?=
 =?utf-8?B?c0Jram1uN2JOVmx4WlVhdmU0UjJZT2FmWFdtTDNvQmVmWktwK0V1dnAzREt0?=
 =?utf-8?B?Y1U2cmxpajJydnJXeldpU2RJampsaG51ZW1XcS9uNm1zQi81OW9ZbmZIelc0?=
 =?utf-8?B?Rm5oODl4dmVRNTE4QTd0TmxvUVBOTHdWdUFIQlFwM0NGaG95R3l5NDdHOWQw?=
 =?utf-8?B?NzNla2lXbGhOTGc5R3U0OTBwQS9uY3JCaG0xTXFFcExNNXlqUCtTRkprQmNQ?=
 =?utf-8?B?aEdZSG41dUFvQ3I4ZHF3YVpaaXpXWnI4NDNaUnBSa3ZZcVlCam9nVDd2TjVV?=
 =?utf-8?B?QnpTUHd5b1dMU1AzVXQ4NW15S2ExOXBXbmZScUlWcm0xUTRLQitObm1RRkpn?=
 =?utf-8?B?VVBpYW1UUGczbUl4b0N4TWhONDZWUG9nREEzUS9NL2doWEpuZ1JSWW5vQW1r?=
 =?utf-8?B?ZkdheWtEKzlLRDFYQmt6a0ZDdjQ4RWlTVnhOTi94TkdlaFMzUG9Gem53a0NB?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef976204-107e-4942-b2b2-08dd87667337
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 21:40:24.7212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4dLXYgfWgi+Ho6Ff90dwYzEA7ddekISz9LUgyN5RBazADu6//+Dk8w/euRQKFb+K/TMl9Wj2SHfvwYrcw3mk4Zi694T5T5DuYkbg+kvARMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9302
X-OriginatorOrg: intel.com



On 4/25/2025 5:11 AM, Andrew Lunn wrote:
> On Fri, Apr 25, 2025 at 09:58:35AM +0100, David Howells wrote:
>> Andrew Lunn <andrew@lunn.ch> wrote:
>>
>>> Are you sure this patch is directly responsible? Looking at the patch
>>
>> I bisected it to that commit.  Userspace didn't change.
> 
> As Jakub pointed out, the kernel is now providing additional
> information to user space, via devlink. That causes systemd's 'stable'
> names to change. The naming rules are documented somewhere.
> 
>>> Notice the context, not the change. The interface is being called
>>> eth%d, which is normal. The kernel will replace the %d with a unique
>>> number. So the kernel will call it eth42 or something. You should see
>>> this in dmesg.
>>
>> Something like this?
>>
>> ... systemd-udevd[2215]: link_config: autonegotiation is unset or enabled, the speed and duplex are not writable.
>> ... kernel: ixgbe 0000:01:00.0 enp1s0: renamed from eth0
>>
>> or:
>>
>> ... systemd-udevd[2568]: link_config: autonegotiation is unset or enabled, the speed and duplex are not writable.
>> ... kernel: ixgbe 0000:01:00.0 enp1s0np0: renamed from eth0
>>
>> I presume the kernel message saying that the renaming happened is triggered by
>> systemd-udevd?
> 
> systemd-udevd is not really triggering it. It is providing the new
> name and asking the kernel to change the name. To some extent, you can
> think of this as policy. The kernel tries to avoid policy, it leaves
> it up to user space. The kernel provides a default name for the
> interface, but it is policy in user space which gives it its final
> name.
> 
> 	Andrew
> 

systemd has the systemd.net-naming-scheme file and it has this to say:

> LIMITING THE USE OF SPECIFIC SYSFS ATTRIBUTES
> When creating names for network cards, some naming schemes use data from
> sysfs populated by the kernel. This means that although a specific naming
> scheme in udev is picked, the network card's name can still change when a
> new kernel version adds a new sysfs attribute. For example if kernel starts
> setting the phys_port_name, udev will append the "nphys_port_name" suffix to
> the device name.
> 
> ID_NET_NAME_ALLOW=BOOL
> This udev property sets a fallback policy for reading a sysfs attribute. If
> set to 0 udev will not read any sysfs attribute by default, unless it is
> explicitly allowlisted, see below. If set to 1 udev can use any sysfs
> attribute unless it is explicitly forbidden. The default value is 1.
> 
> Added in version 256.
> 
> ID_NET_NAME_ALLOW_sysfsattr=BOOL
> This udev property explicitly states if udev shall use the specified
> sysfsattr, when composing the device name.
> 
> Added in version 256.
> 
> With these options, users can set an allowlist or denylist for sysfs
> attributes. To create an allowlist, the user needs to set
> ID_NET_NAME_ALLOW=0 for the device and then list the allowed attributes with
> the ID_NET_NAME_ALLOW_sysfsattr=1 options. In case of a denylist, the user
> needs to provide the list of denied attributes with the
> ID_NET_NAME_ALLOW_sysfsattr=0 options.
> 

If you want to stop including the "np<N>" to the device names, I believe
you can set the ID_NET_NAME_ALLOW_PHYS_PORT_NAME=0 via udev properties.

From what I can tell searching online, this can be done by setting an
appropriate entry in /etc/udev/hwdb.d/ .. i.e. adding this file:

/etc/udev/hwdb.d/50-net-naming-disable-phys-port-name.hwdb
net:naming:*
  ID_NET_NAME_ALLOW_PHYS_PORT_NAME=0

after adding this file, you also need to update the hardware database with

$ systemd-hwdb update

From here, you should be able to reboot and the physical port name would
be removed from all devices which have it.

It appears to work on my test system running Fedora with systemd v256.

At any rate, this is fully an artifact of how systemd renames things and
I do not believe we should be working around that by modifying our drivers.

You're unlikely to convince systemd folks to change defaults, but you
might be able to convince some distributions to change their defaults.
Either way, you are best to work around this on your system in whichever
ways you see fit.

Thanks,
Jake



