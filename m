Return-Path: <netdev+bounces-195094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C129CACDF51
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 15:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44BEE189A502
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 13:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83D628F92B;
	Wed,  4 Jun 2025 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G1/jNDNI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ECA2557C
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749044239; cv=fail; b=t7kN9aNsKG+7ttiFlNoyXOg+up5z0I1+eYApTzkLWwxjt7rrgw1yclmnntvBlBfhrX0nPthboEs32Y2pYyTxGYITuxx8MWmjQPDV99oEVWegS2/kQNgftZ6nR5rYpt4RsWhGCM5xeMqzyfHxXwkHRrngplBYjHKRui4opPF4Plw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749044239; c=relaxed/simple;
	bh=FAnciCGZtGl6vo2dPnI+l+Np3KqjiWpOVORM144gu5k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LhCMia7fUai6O/dwbCrxzrwiokgkuIOhXcN3V/U5A+sJ++Yp5Gpj804c3OqAcAe+CgsaNn6BPY5OpjxL8xu7nHE9NrbleLqYWDHSZafniNCV4BE5sr+Edqy7B8R33x0NyV8I8QieNfqENusJ76iqf/5KNKhc1MHl1JVbMnODjJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G1/jNDNI; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749044238; x=1780580238;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FAnciCGZtGl6vo2dPnI+l+Np3KqjiWpOVORM144gu5k=;
  b=G1/jNDNIMzbaHZtxfwTwZ7lWufJ28sY12g2bZywaVEq5N5403+Mq32Nd
   ZF6G7JxQ5D9Phu+NYJVCRS91cr7kJ1EP5g7QoZADtNm6uVyFSR3sX2bA/
   EO/t2QmXvN9S5QmHW8FPKY5CGrjuNJnv02YjHXVYh1WDOLtix2qdO3Rrr
   t7x2/eppPdKQ1WghvkeCIKEFkJyrk5/lNtbgvSnX3hr/K0EKHs6xVHUP6
   Diwvx84x+rO5CySssfwvm3yS997gC33T2moPFd04d5XhB5t4jwDGiCPxS
   t1OaNQI3m+YVT7JjHCesuPJUTrH+LI8dwmps1tzHG8KsfI6hqnxlc/Fzh
   Q==;
X-CSE-ConnectionGUID: vFLdBOqRS0i8li80KuJspg==
X-CSE-MsgGUID: 94KN0OTQRo+oOn1uJKXiSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="50989773"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="50989773"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 06:37:13 -0700
X-CSE-ConnectionGUID: 7Uwu2quFSFeB805SX9IiUw==
X-CSE-MsgGUID: NsvxBlbBSRu/48qakAKugQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="145090140"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 06:37:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 06:37:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 4 Jun 2025 06:37:12 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.73)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 4 Jun 2025 06:37:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZuIyeNHeRd2SiL5cJz9i0HAN6WstSFHMh7YqUpGjtCUNWsyRO52DfKsa0yclL7t0c9KXO/Dfq3uJScWwcxRs1helApZwdGxEvFS+jA14nm2uji/lHEJdc9vaX1vAUvHSb+RrxnGBXjMUY9MHurAAxNU75w/xxiNR4SlKxDQCIdmazjtYF1nV4rLh7KxE7iEfU/E/Ytd5AOnD+GlSSzKEfMfXEUJmQ+kJQeoffPVgPZ0viutTs4aQg1nOKEoAybVKZXVIXUKwXwrwQt/3/qarfEVFn+Jvtyp5OfcwxkW/j8fG+39e24qEIWyHmVgj4/zryqQQoylzHWQHfBzPHXXD0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AN2+UbQFvY1nO1xmllkL94EiMYyCZ3rhwlViRjKQ5C8=;
 b=Zku4QJH82nVmFbTV0bIrmsuA/B/q2DRqsW63+kdZ6Hr6plorW8unruVpSs4U0NX0uvTIIyyUdoPtO9rMtN3Qz5xf+ibAqINiTdzGlOjN66u+GS+ezbYGuFW9jFIRlFj+V00D26RdMy1+aASa3wlnhldXN53ABAOvqoj/AvB+Uv4hbOaecbtHrf63zjqHa1PAkiXoPFImyewyJ9CQDvuw8dPPfMdTLj1QhVC7F67zXUSPXSe3I5fHmNp93W0brw5hxQbR9L9e43k4Ywg6Dr7kUUG3c+bs1ce/+gDqpaQRnyJyDkCqvSOJxBpMrAKAhVdIZ+WvzTvvdKaBu0CW7HJ4xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DM3PPF1FCD3EAF0.namprd11.prod.outlook.com (2603:10b6:f:fc00::f12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Wed, 4 Jun
 2025 13:36:29 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%5]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 13:36:29 +0000
Message-ID: <c0bc969f-d2d3-4d48-bc6d-00dd299bd7be@intel.com>
Date: Wed, 4 Jun 2025 15:36:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [ANN] pylint and shellcheck
To: Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>
References: <20250603120639.3587f469@kernel.org>
 <20250604072740.GB1675772@horms.kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250604072740.GB1675772@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0006.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::11) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DM3PPF1FCD3EAF0:EE_
X-MS-Office365-Filtering-Correlation-Id: 023ee4cb-b143-4c43-7371-08dda36ccf8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NDF5NllaOTZ5NExqL0Uyb2VQMzRKUlRhTXF6aEJLYXAyb25ycWNrQ0hOcEE2?=
 =?utf-8?B?ZGZVTGRNRUVFTXVFR3pjbWphVWVwem8yR3MvbnpKa1hhOFhoaWpDZWVBUW4x?=
 =?utf-8?B?VmJLRStNd0FITlA2SzMzQ2RObHByR1dnNW9XL2pvWjJ3bzFGdGpOY3NpN1Qw?=
 =?utf-8?B?SWhnbHp5RUhtbTQxLzY3ME5qWTEvOUluNktBQWFwVy9uWC9ibVFTRmxQU3k0?=
 =?utf-8?B?U3IyVDJ2SGdscVFjOGFJVVpTVThXVmMwejFqeHVUMFJ4NU91Ukh2a2JUSUVk?=
 =?utf-8?B?dGYvVGNsSWU3a1NMaHBhREtteEFITEx1KytENlM5Y056ZWhVUnV1emFjOEE0?=
 =?utf-8?B?bmdMUDcvZ1pLNFduanlSdDF1aDJNL1N6TzBEaElCRzRMNm1SQWFKelp2emFz?=
 =?utf-8?B?alJtcDBoSE5JUHpVVUcrVXFrSFIyY3BFd24vVC8xbGZKejNIbTRHdGlmSXlz?=
 =?utf-8?B?WmV1bnVzL3ZIc1Y3VzU4OVErQjhyN0ZRaFVDQWk1V2hzSGoxVnNkeGpMNU9u?=
 =?utf-8?B?ZVllak9QUUFXVXdzQThwd0dRRDdWTzZkSm4xNjRGQzlmM3FlVTFqQkM3N1BL?=
 =?utf-8?B?ZlNlVm5VVjZjY09MUU41Z0lxdTRySmZmdS9DNitDZEJDMkY2Z0hwUjZNcUp0?=
 =?utf-8?B?MUlndUllTFFiY3g3bFgyVFdtMXBNeXg1aWxnTEsrK0ZVLzhaMDVMT24rcDJ0?=
 =?utf-8?B?c1R0VjRpTzVRb1pZVTNpa1hoVHE5TkdpWHBIZFJ4ZjlHekwyeWxOYjBITHBB?=
 =?utf-8?B?N09qVmZGcUNXZGhSNmE2RWN6emhnMzVzaUEyNUlxdy9sRmVhcFJ2aGVoSGp3?=
 =?utf-8?B?N3JsQ2ZSSFkrWlVINjh4THpwMzFSTXc5YThlampVVU85dWxWZTluV1JNQ1lW?=
 =?utf-8?B?ekJyNFlXTzNNa2hvSmUwdzBrUFk0U3JxSFJoUnpVcGplS3ZUU1hmT1NNNHBO?=
 =?utf-8?B?UzQ4YmRvMmJ6UXZUamwxZC9hTXZ6WC94T1NLUFIyTHNQaVdyS0xkNmdsVHR4?=
 =?utf-8?B?V2J3SU9rdWgyZXpvRXpka2l1YkVMVHVjWGlMY1B3ZzlPL2d6dStlT1JpQ1dn?=
 =?utf-8?B?djBzNHpBZnB3clRGckFjaHd0ZzQ1R1Q1TCsrU0E2TlErbHdYNUFJOEJKdCtz?=
 =?utf-8?B?QUtFdE9sY3plcVVkakZvREZlTjhGMWZrV2Nycld0cUUyY3FSMms0VkUzaERI?=
 =?utf-8?B?YmlrK0crMzFBaDVWUEJBVG81TWtnZXBnaWNObGFja2dSdkpOWkNPc3o2VnJ4?=
 =?utf-8?B?bTVJZ0JPRWpyNmdPamI3ZERQeDJNUDVhQjNERUxzOUxZekIyTms3ZXdEZUlD?=
 =?utf-8?B?TU8vemFpNWZBTEFSSEpTeE9EcER2MTR5RHY2TE90cCtuaFBnbitON3YxKzkx?=
 =?utf-8?B?OEZOa0M4OXpRVUVuNHNMUHRaTEFEN1NtM1VoR1ZReVJ3WTVTVUlDOHFXczN2?=
 =?utf-8?B?dFBJcFFOK3l3VEtTTXpVblRhZTNpWUxEbTl3R2gwaUMyOUJFb1lNbEhJcTh5?=
 =?utf-8?B?TG5oejZZdHo5azBSeDF2TTlFWWFldmR4R0hCcDE3UXlaVjArK0lxRnlyM3FD?=
 =?utf-8?B?dE14eU1sWlZSa0pzcTNzbTNpSmFjQlB2VWQzem82WERlQWdyeUVZUGlXQ1dj?=
 =?utf-8?B?elJlWjB3Tk5RazFqYmZhaEZYTWJnb2oxdFlrWHhHc3U2WDJ4WXZQNlJ6VWZU?=
 =?utf-8?B?ZVNtV0dZQ0tJeGgraEdKbFlSRVVDcCtNdU8yV1pNeXUrcnBJWlQwRy9tRy9S?=
 =?utf-8?B?WTcyUDNxOWl6VVJoMmFKNEZPOW1xbUpsTEdKdWxNR2pwd2ttQm1KMVVIZUo2?=
 =?utf-8?B?OXpCcExncTZtMFZCRE8wNkRNVmx6RFZEd0RUNi9JLzIwaEZ1bzFZNWhFQ2RK?=
 =?utf-8?B?aU1JQjArSkF2bGZRVG9tY0t3Mzd0SXlhbUovVVdLRFp5ajkzTVBHbEVvbWF2?=
 =?utf-8?Q?jfVku+7pVAr4SfDtB5+wWvsxR5pteaxi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWRTL1NuVG9BSm9tQUhNSnMwNjhDNHhUN0lzcTU3QlpqQzdNcTJwTlk1dVVB?=
 =?utf-8?B?eFl2ckVPdjBqRitaSGw1MUsrQkdjd2NXNWFHdDJGWFJNcGJraTBHeWY3SXZN?=
 =?utf-8?B?VlE3SGlSUGxiRDJ3WGVxSElGSnR4aDY0MnpJN2xFQ2t5L3lvaXhjSkV0Qjlo?=
 =?utf-8?B?K1cwTGhldUhFSUhTbS9JMXhXamkxQURRalp0QXA4YzF2dDdyT2ZIZkdSbUhH?=
 =?utf-8?B?dzVSaUpLVUtGVVd6dDRnZG9uelBhQm5YNHVqdDhXU1hxT2R2QkxlL3dPU0Jv?=
 =?utf-8?B?VUJRL292ay9oQjRRTFByT3RHZ09QTXJqVklURGtEeGxWNzUrd0R3TzNNZUpy?=
 =?utf-8?B?YnZrdDR1eC9ad0JiV1hMcjNPV1FFWEoxc0NyQWh4MWM0djVDOEwrTE03b1Rx?=
 =?utf-8?B?S3B3VDJGS0VRYUhYQUZVNlNSRnFibGY5MkJ1RkM0c1RNcTRtSnBVWGlBVnF6?=
 =?utf-8?B?RC8rQytOVXRwbWJwZmNPUHNIREF0UkdvS0ZYQmhOTVVDU0REVUZQOWtJZnMx?=
 =?utf-8?B?MExJQ2tTcjFvemZuYUg5T0pwNVJPNHdpcVlYUmE5bTIxQm5HRWhBVFYyYWZP?=
 =?utf-8?B?Nm5URDNaQWxaTU9ReU11UEw1RmN2VFdzZXZJdVRXOHEyZmV6ZTVwT0FmNHNP?=
 =?utf-8?B?M01VTHZDYjBjL3N6NVZWSkNDSXhPT0hBQklrVkppN1U1aFNQZm5tcXNKSjNN?=
 =?utf-8?B?SUl3Und1ZEFzRldkZzBMSkFtdDlwYUMxRDFqeVFQNzlaMHBHNWpEMUl4R0RN?=
 =?utf-8?B?cmdjWUlpR2ErQXhSNW9wa0xkTDNYQ3ZraGZENC9BdmJ1N0xONUhMaGkyZFNw?=
 =?utf-8?B?WUY1Zkx6NnRiZitSbDQ3azAxR1BhOHJ2bElsRmlWV0swUWllYnduUUVYUGNp?=
 =?utf-8?B?cWppeGpLY2FaRm45RSs0V29LT2VXRFFMNzRUYTZIKzUxMVNxajNPdjJpdCs5?=
 =?utf-8?B?eWs0SEw2WkZJS0h1N2FWN2hMWm1iMnNPaVdwUjQ2OHJ4QjJaWUFRbXZVL1JN?=
 =?utf-8?B?eGV6cGNFWWJjK3FLbjExdjVIQVNOTXgrNGpTUHA3SXZ1S3kwdVJLb05NWGR5?=
 =?utf-8?B?U2dXU0toazRPcU1jZ3cvQ2wzZENid3EzTDJEQlpRSlhCbDZaSUpLeGcvaElL?=
 =?utf-8?B?WUpsamgxanBmOEJOa0lIaWl5eUJlaU1mbGkvOUFjc3RhWUxhOGV0YktoMGlF?=
 =?utf-8?B?bStXVnpmTFlUOWZQSHhIaHlwNVFHV25sbVc1UWs5cFo5TkVrTUk3VVhUOGdZ?=
 =?utf-8?B?MXJha0FOMGFXNjFPRkQ3a3dXQjZuWkkwYkNCVnUrc2pGSTlaNW1PcFlFTlRj?=
 =?utf-8?B?M2JTV09KZlptOVdRaXhOQm5zM0U2OVc3bmM5OGl2YjQ1U3lUR04vcU9TWFpp?=
 =?utf-8?B?OVVidi9mcC8yK3g0a0RPaGhnUnV1bkxDM3N3bGhJb055TFFHMkUyWTRVK3l2?=
 =?utf-8?B?UHM0WktuTUw5cVUyTGViZ2E4a05Ydit5S002N0M2WUx5NlRjczcycHRxNWpE?=
 =?utf-8?B?dmwrbWZBcTFvU0o0YjZ5ZEU4UU9XM2g2anNyWjJ3MmhqWlJTZ0hQOFNIUFdh?=
 =?utf-8?B?ZCtyc3FqQkJKMW5YMzRwU1ByMm82R2J0UlZCb1lkMVV0Qk5qYXV5V1hrQXho?=
 =?utf-8?B?SC8vRzJmZTQvWE5od1BVTTM5ZU1LTDVQWEloN1JWNEJYcHNaMnY1NWowMDNQ?=
 =?utf-8?B?aU8yVGhqQmY5YlBseVU3c1F2ZHRBZTF6VTdqcFFaM0dPWGdOKzhzbmtTYXdI?=
 =?utf-8?B?bzFHS3NvKzM1T0V0VWhOcFp2WG83K1d5OFM3Y1dEMmhYY0J5VUx3U1NraE9E?=
 =?utf-8?B?alc5d0tXVmhxQVN5R1AvVFp1ODE0cFFVNlZlSE1NRUtyRjd2WXNnZHNyZFYz?=
 =?utf-8?B?VHJUbEFUcW9VSXFxRVZUZUc4TG1pbEE2ZzkvWDNjYWNWOFJ5emJNTWhIK0tT?=
 =?utf-8?B?QSt1TzBRYXEra2FNdDdyQ1kvUTRKMWZwNXhaL2xWK1huWHdrR29GdjViQ1hp?=
 =?utf-8?B?Ukk3V0M1N1B1dVdyaWJGVlBBM0srWkRPQ0haTE9EbG54bGI5QmpWWG5MOG5n?=
 =?utf-8?B?UUVZdmNrSkFQNVN3d1pyckNyVTlDSjlpTVdWLzBZZTdZSW5rR3Y0M3FLTXV3?=
 =?utf-8?B?ZkxIanU3OC9RQXRiZGdlc3lpTTBtNEl4WXVnUmhIRVNDSGtiVEsrQ2s3Q0xN?=
 =?utf-8?B?Z1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 023ee4cb-b143-4c43-7371-08dda36ccf8a
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 13:36:29.2190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MRDw7n4TyDqGw7cScBFNF4gSGSetNuatufhtp5h5X25DQkbxdTagEp3e6JqULbtlI84f2iZqBd3V+LCt2N43glV8VzYF5l0+pxj69lh4jao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF1FCD3EAF0
X-OriginatorOrg: intel.com

On 6/4/25 09:27, Simon Horman wrote:
> On Tue, Jun 03, 2025 at 12:06:39PM -0700, Jakub Kicinski wrote:
>> Hi!
>>
>> It's merge window time so I have a bit of time to catch up on random
>> things. I added shellcheck, yamllint and pylint:
>> https://github.com/linux-netdev/nipa/commit/c0fe53ae533d19c19d2e00955403fb57c3679084
>> https://github.com/linux-netdev/nipa/commit/255ee0295a096ee7096bebd9d640388acc590da0
>> https://github.com/linux-netdev/nipa/commit/54e060c9094e33bffe356b5d3e25853e22235d49
>> to the netdev patchwork checks.
>>
>> They will likely be pretty noisy so please take them with a grain of
>> salt (pretty much like checkpatch). Using the NIPA scripts from the
>> commits above could be useful to find the delta of new warnings, since
>> there will be quite a few existing ones.
>>
>> I suspect as we get more experience we will find the warning types to
>> disable, and we will drive the number of existing errors down to make
>> checking for new ones less of a pain. As I said, for now please don't
>> take these checks failing at face value.
> 
> Thanks Jakub,
> 
> I agree this is a good step.
> 
> Anecdotally, my feeling from running shellcheck over patches for a little
> while now is that the feedback it gives mainly relates to stricter coding
> practices which aren't generally followed. And yet the scripts seem to run
> reliably in the environments they are intended to run in.
> 
> So I'll be interested to see if we end up go for some mix of disabling
> warnings and updating (creating!) our preferred coding style for shell
> scripts.
> 
> </2c>
> 

other than quoting rules (shellcheck knows/assumes less than a human
could) I find all other shellcheck warnings to be a good thing to avoid
in all codebases (mixed level of bash familiarity of participants)

