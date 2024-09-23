Return-Path: <netdev+bounces-129255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FF797E826
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 11:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6709B1C213F6
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 09:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097FB1946C3;
	Mon, 23 Sep 2024 09:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="coTTV0lp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEAD194089;
	Mon, 23 Sep 2024 09:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727082442; cv=fail; b=SayvHw0V+IPbAx1+f5PLMr25Vb410wOqyf9b8AAs//if7wilHkIFKhRFRdddPuIVbzOFevnxeuB+w/CHx3zpXhL1AqCg5Gs8ctxsj/SHlfM2h7n7d6SY+vy6rbvlLUPsEQRGMA2NBkVIuMgb4AdLblLariMjQpWt9VtMahRMBCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727082442; c=relaxed/simple;
	bh=YK5FxYqcwUpA71SiNg0vQ6n0x/lLcH4+HVsLTVTpG4o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eGYlosOKkCuSCdOL+6qvP4XBUCSjyea5PaF8zcHKQ8RoMB4Beaio1Tu3yctM8jy9fvZLAsz3YD3eI2hNR1stYzeSCTrwNOuKbWT9RUJbbCS8Dp98hpuQM/P4OWS5we3nWqy0a6fotFoui+1RmIWOWkdt/eUZlY1S2/R/EvYVYt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=coTTV0lp; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727082441; x=1758618441;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YK5FxYqcwUpA71SiNg0vQ6n0x/lLcH4+HVsLTVTpG4o=;
  b=coTTV0lpEQtoPEZ1yreNE13PItJCgf+16mNwJwD2NeFWxv/PZP6HL7zC
   +l2NycmpQAdYzxcaWqlXNRWKzDDJGx8gdWtm/TVohALgvGhwBvDNNaWMm
   x/YSYFd6KDMucVRhvdoIexxhvTNKG3STQbYlIQ8wruElgaX4XwmxO5Op1
   alL52F7KZxzOi7GjUUlaR10QyJgpsucfAt/aDPU1I9uNxkAXaLisOX+ul
   PUmDwNJKVFl9G8Dh6dcpHFb6JDm6Vp+CNjPrzr9RO8LSh78uMnFyLf+NJ
   7cgAu5Z/qWaX1y8r8Ti8h5AyyULQH+s1MJ+c6GZkeIz8VbYdr1mILl5q9
   g==;
X-CSE-ConnectionGUID: GuPWfLNOTwiuBmWVN6z1uQ==
X-CSE-MsgGUID: tkEsBcebQJianqyv47ohSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="43537664"
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="43537664"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 02:07:20 -0700
X-CSE-ConnectionGUID: 7JdxXnRaQzacgXTWYUmfGA==
X-CSE-MsgGUID: 4ZXQZmRAS8u9ZrzthOgrOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="75770328"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Sep 2024 02:07:20 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 02:07:19 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 23 Sep 2024 02:07:19 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 23 Sep 2024 02:07:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oa5EzaOEcxmCFAU1rdB0wbMDImnyh89/lEHJZdkW8qVri2ArdMte1SPS2zrXVJUZ5v8zc5tdqBzsKbtBf0vCMuf3+3b/me7SC4FkhWea6zUtIFVTP6Amp4OyqV/wHP/VcS8Q/6V11aCCaCDpWsl0f8/mqdTVtFZQvK5x9B1sf/8teOACKRsuuNEbvs4ful72isuaaIhik9XcbSg0gXiSBzQDkyvj+e3agEhflIptu/kPZN+zJc+nx7WmxBXyFSkMEaGaNBYjh3TcWSJGOrDMKeGGj4HUq43Bvz2cdrpA0QwSWm1bqPViPLifaP4Oon6UKOk/5DJzEcpk/MhiBRFtDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ZNAQ1HUHW74nTxVfAl/Abb0xEbUjeQweZWO9MQbUD8=;
 b=gbQja7apjNYocNfWglBjxHVXpbLY6VV0LtlojJyqurW9x98VOUVCv3ZgI7HOXkVrAoC77uiQKww/o/VcP4cKouHIr0MwFB6/mabts0Z3VFfwE6MUmZxfQqfNdrJSisFuNTTud7dIaCCHbc9efByjPMgNsQZFrZMEKCPg6+6kaIxjuPQid4yfh1SBdKGyuXrFkPDnDcZDRhIUhkzkVpldTJ3hyNwHWm7MJkxOzq0z6nvDlGp2GMdUL8aIwRK1R7OD7AHmed45RcWskCsMQ1L6JX8MekLuUdrV+uiMd4zim79adUeiqkZEL50QUEKSux+v6IOtuLWY4Lf4ojKitHEaMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH7PR11MB7498.namprd11.prod.outlook.com (2603:10b6:510:276::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 09:07:16 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 09:07:16 +0000
Message-ID: <1b9cc95d-2dfc-4dec-a394-95aab0d71687@intel.com>
Date: Mon, 23 Sep 2024 11:07:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] igb: Disable threaded IRQ for igb_msix_other
To: Wander Lairson Costa <wander@redhat.com>
CC: Yuying Ma <yuma@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "moderated
 list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>, "open
 list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
References: <20240920185918.616302-1-wander@redhat.com>
 <20240920185918.616302-2-wander@redhat.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20240920185918.616302-2-wander@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0027.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::18) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH7PR11MB7498:EE_
X-MS-Office365-Filtering-Correlation-Id: c89646ee-7369-4d77-e72b-08dcdbaf1ee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZnZmdm9pTG16R1RJM2Fub2NHWkJHSitvNGF0Nm9IK3Bjcjg2YVZIdmhoSkZn?=
 =?utf-8?B?N1dKZGRnbUhEOFNEUHNCZWk0dUlLbnc4NFVncjFYYWpSR0lUN0lQZjJBaGc3?=
 =?utf-8?B?K2tvUjhrMmlxYTBiZkpvVnJZeUNSbnhGdFl1TThGU3BtV25PSmdxUjNuMVhG?=
 =?utf-8?B?NWFZQUtjM0ZoUkpDZG5jUXNBT25XdzRVSktJWnFRUjVHbHlJNXRyRnJYMkhZ?=
 =?utf-8?B?YzBaSm40T2RmK3BOUmpteXBCSjJsY0hGNzYrbDQrQkZvNTRBQjZkNUs2U0Zk?=
 =?utf-8?B?NXJSZjE4TE11S29BYmlkS3VFalNhNzFvZDV0cDNGQkhMWW03THk5MHROMmxZ?=
 =?utf-8?B?WmpnRWk3US9sVXEyWkxuNzBlZEFPNHhKM3BqWFJiV01UQ0J1MzBXUHErb3dY?=
 =?utf-8?B?VktKWVZFZVE3VGx1czZnTFJ3TDcwd3VpZ2dadE50cGRJUDIxT01LTHBYbXd0?=
 =?utf-8?B?NDJ6N1h5L3BRUUFJUnB1cC9kT05SRW5zY2x3bTVHMXFUYU5hQjlxbXgwUjhZ?=
 =?utf-8?B?UjhSOFpGa3lZSXJ0NVZuR2VGZEMyK1gzakJ0ZFlSQjRRRkFEZXpkMWwxWXV3?=
 =?utf-8?B?dy84K2p3L3ZSaStGTFkrKzVUM1d0RlQ3bmhrTUFNU1JNeURwZ2Y4STgyUjBH?=
 =?utf-8?B?UzdUblJEb3BsNWl0M0FXcjRsenZSWFlvV2FJbUM1aEU3SUZlR21TRzZxZDAx?=
 =?utf-8?B?UkhlYzQyV0lWeERSQlhuNmpZMWcya1ZSTHEzN3BJOTJHYUg1YUtkZ3hvaytY?=
 =?utf-8?B?NkJPeDNhcG84QTZVa2c5akUzWUhaeWp2cTVDVlVnUzducUVUNVRrWWFSRVlX?=
 =?utf-8?B?R2owUzNxV2s4b210SGR0R2ZjNDVlTGhYem5Ia2FrWXZ0T2JlWk80clNTUkpJ?=
 =?utf-8?B?WlIzQXJGdTMrbjZYZWp0M2NUSEpZdXZwM0t1cHpNd3pTL1h5Sk9WbVlxM1Vl?=
 =?utf-8?B?TXBjN2RMOU5KVGVhT2pRTHE2d0JjMk5nWUhucVJaT3E0ZldyZkxKZlp6bEZQ?=
 =?utf-8?B?WHYvU1lnSm9mdDkyQzFnZ21vbmFJMU5KcTNkaHlQY0VnQmFjbXl4aTZiakhH?=
 =?utf-8?B?blZSSDRlT3FudHcyajRYRzlaaG9nV1ZSTGw4bVJtTnJDc2dBcDRpUUQrWlkv?=
 =?utf-8?B?RGhuSUh0ektHSERWZGhVRkYwQzBJSXdZR2l2TkFDNjRoNW9oT2xER0hGNnNx?=
 =?utf-8?B?eklMUXkvTXBId0g2ZjlDa3JWU2p2S01NUzdRUVpraWZpRGVSalZ0MmpKbEo5?=
 =?utf-8?B?Ym10N2dZbmJ5NE05cUhDR2RvejF0empsZjduTnQ3R3BQSk8wOTcvKzJNaUc0?=
 =?utf-8?B?SkorVnZ6aWV2Tm9FeEVBNUhtc3ZVN0ltYWRweENQVlQ0aGZhQ1h6dEE5WWo4?=
 =?utf-8?B?TzFJNmdjYjk4UmNsOVVrcmkwYVlGdllYWHN1bXB2WUdOd0lDNjJJZ0hnZ01U?=
 =?utf-8?B?ekZWZWxhK0ROV3VkSXlnTTV1Y1p3Q2lmRHRMTi9KVTlwY0cxak1xMitWUWU5?=
 =?utf-8?B?amhIeDkrQzhtVjNRVWRMMlRiMFg5bExHTENOeXBtRnZqNGlhWmhlWjJiNGxN?=
 =?utf-8?B?Z20rWUNyMFgvbXZSYlF3S0dFbkVETWh5SzBvbVhyb1VPMFhqYkFPeFNoelQx?=
 =?utf-8?B?NVR1K0wvK0NyZ1ZVVHhQNjZlNDd6UTRWUlJ1dHRzTDJhNWRPTlRXSWszMnZa?=
 =?utf-8?B?L3p0UW1qdTZlckxGWlpwS3FOeXZQYVViYzYyWnA1VzNIZnZPdVdJYytBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWVIVGpTZTRxRmVxR0dpS2Z5SjMvYXF4OHhBMWZ2YlNXbllZZ0NUQklldGMw?=
 =?utf-8?B?VUdYWFdVekp6WUZFenRVeVZTa2lFMGVjQ2REUTd4UG5ZZWU3REtSTktnT0pE?=
 =?utf-8?B?R3IrM3lNRzBIdkM5V3RRL2hFeVRjSkRDMkc1bG0vMEs3KzBVaGl3ZHJ2RWNS?=
 =?utf-8?B?bzNKczBoWmRodk5OM01oUEoyMGdXcTg4blBqWU4ySUdrYXVUTDF5T2h4MUdZ?=
 =?utf-8?B?czdtRzJBWC9HQ0JramhXYURXNGdsd1R6T3l1WCtNNmFLNVdYdTc0N1R4NGVO?=
 =?utf-8?B?TDlGUlBWN1hQODE5KzUwd21kanVvanhMNUZXUnNFdmk5QjhGQUtYS05vcG1X?=
 =?utf-8?B?akg0dkJVbG5ZZVZEeHA4SlF3YjZjd2cvQjZsR2hGRGFhZThYUUpiWVBnbXJz?=
 =?utf-8?B?c2pTUHFSWGZjMXlZWVA5dEZDdkFzUG9NSlVuZklJSEEvRDNoOGpQdjU1L0Va?=
 =?utf-8?B?QkFNbG9PelNtMTBNeks2R1ZnWk5jTDVsVjFKcGdFb2VRWXpoQ0VlTmhXeW1x?=
 =?utf-8?B?MnlaeExEdXl0TEpZVEhUUmtWMDd2bDROMkdoS0lkQWYzY0Yxd09EYVg2WWRX?=
 =?utf-8?B?bXpWL2J6K3JlN1hrTzFYT0hwZnljeVl2Z3ZhOGNGeDY5ZWc0UEtJZC90TlVV?=
 =?utf-8?B?K1ROdjVhY0xMUFhPOTBqZ0dyTXl0M29qbEpFcFNqYzBoRmhkMC9RUlFZclN5?=
 =?utf-8?B?NlQzMUN1elVTQjlzTEpEeEwzczYwaEZmSXRTdTRUQ21CMkYrSlVPeHZYb0R3?=
 =?utf-8?B?RG4zeVJmemV0M3k0d1FJdFJXb2xIRXovWTlFdW1Sa2c2U29qZVdQNE94V0VX?=
 =?utf-8?B?SzZUYkdZb1diMFY0dkFiVE0xM2ROQ29vOHg5dENYdU5sM29EOXJpRmprd2Er?=
 =?utf-8?B?M09FeWRITXdzVmk1T3VMYVlTbWs4VEE3Um5rYmFDdHF5VTVjeGFTaGdncXgy?=
 =?utf-8?B?U3ZubVA3bUNIOHA4UnZYbjQ5WDRzRmlhR3QxcFJqR1JZQmFRdGg2cUQwOVp0?=
 =?utf-8?B?Z2Y5b3RHdmUrZFYwdVFFeU9xSExPUno1bmM4N0RzWXlHM3d4c0gvWmlNZElq?=
 =?utf-8?B?RDBhN0swQTZOd0QrbkoxN0xTbHBvUmQ0U0tuK3pxQnZQVnIwbHJtMUpyanRN?=
 =?utf-8?B?cm1TL1lyUTkrY3VJQXF2Y2x0SnJrMjF3Ky9uYTJrNTd4dWx5MFRYWUk4NXhZ?=
 =?utf-8?B?NnBGYndQZ2oydHM0WEI0eWl6TkRDN2w4VVBQZVhXN1lndUxaWHlLNzNhR2FF?=
 =?utf-8?B?bWFlZ1ZETklQc2cwdnlkWnlyckE1Rjc3eE00ZTZKcjAwRlBCYzZIMk9YSUNq?=
 =?utf-8?B?RUxPWkg3OTNXNXZlSnprKzBiMWJWeW1xYUpQdUtXMzZSM0FFVUF2RXlYNXlJ?=
 =?utf-8?B?dHRzbFBRbE05bnRyeGxsdGtyWTdHam8zQXRiREhBcHJXSjczYzUwbVhoRm5n?=
 =?utf-8?B?cUFTZm9QVzYzRll6dWtUdEMydytWblpoMGN4dmNPbFh6NHRMR2J5TFBEdnlu?=
 =?utf-8?B?NlFvNDFWUTRuZFRVc3c5VlFTb3dvaTdRR0FvK2FnV3h6dVZ4TlV0aTUyd2J4?=
 =?utf-8?B?TDBzUU1DQzVhb24zdlRnZWF3MW02Tm1UVUNVVHhDNkl4cmoyOUFmclZCcFJt?=
 =?utf-8?B?dmlaWDZXL05lTVdhdXdaemxZZGlJaEJSUzJLOENQaktlNkQ3UXVEOWpGZHJ2?=
 =?utf-8?B?RGpjRzdBMnE4dkZlNkt6SnhUOGR6RzJYMEdRMGJpbHVoRmYyYTg0UnBXaE52?=
 =?utf-8?B?eDdXL0M2WkgzUEJjWlBTcHd6QUN4bGhlZ2F6WWVoUnlrTDdJSFJDdVhyd1Y0?=
 =?utf-8?B?dU9tME1kenp2NDdLdUVJK2FDMTAveXExdWowbzVGc3hMaWRPUkVlamtyV1g5?=
 =?utf-8?B?TTNkVUllODN0aUNoWHY4N214WFpRUFVHeUpqVXNEYjdOMVdUS2NWMm9ZTm01?=
 =?utf-8?B?azFsRnE3R1lROEZXM1lkeGJxVHllbTVGbUZkUE5RNER1SENaNnJqTFJZenlr?=
 =?utf-8?B?K1RpNVkwMVJoVklwNmc2QU1DNGpqNFpRTDhWRVhGTUVMSVFNMWU3RHVGUk1K?=
 =?utf-8?B?NlZUVjFvMGlYQzdrMGJvenpkUjZmNldkRTZJb0hNWnlrRUo2VlhzUUJ1Tjlt?=
 =?utf-8?B?K2Q5NXRoalppNVd4WmJyUWpQV3Y2QWpCYTJMZnM4Z0VITDByVVA1RkZ5RUh5?=
 =?utf-8?B?WFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c89646ee-7369-4d77-e72b-08dcdbaf1ee9
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 09:07:16.5043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A9Rp0zqzhmrz/4RcZ99DwM2yxELhJteb6XAA/r5zCj+VooqiavtcUq7MulQg8Bodtb5auv+BZieqFsymvSJgokYJx3MxHYEmYj0mVUyEFBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7498
X-OriginatorOrg: intel.com

On 9/20/24 20:59, Wander Lairson Costa wrote:
> During testing of SR-IOV, Red Hat QE encountered an issue where the
> ip link up command intermittently fails for the igbvf interfaces when
> using the PREEMPT_RT variant. Investigation revealed that
> e1000_write_posted_mbx returns an error due to the lack of an ACK
> from e1000_poll_for_ack.
> 
> The underlying issue arises from the fact that IRQs are threaded by
> default under PREEMPT_RT. While the exact hardware details are not
> available, it appears that the IRQ handled by igb_msix_other must
> be processed before e1000_poll_for_ack times out. However,
> e1000_write_posted_mbx is called with preemption disabled, leading
> to a scenario where the IRQ is serviced only after the failure of
> e1000_write_posted_mbx.
> 
> To resolve this, we set IRQF_NO_THREAD for the affected interrupt,
> ensuring that the kernel handles it immediately, thereby preventing
> the aforementioned error.
> 
> Reproducer:
> 
>      #!/bin/bash
> 
>      # echo 2 > /sys/class/net/ens14f0/device/sriov_numvfs
>      ipaddr_vlan=3
>      nic_test=ens14f0
>      vf=${nic_test}v0
> 
>      while true; do
> 	    ip link set ${nic_test} mtu 1500
> 	    ip link set ${vf} mtu 1500
> 	    ip link set $vf up
> 	    ip link set ${nic_test} vf 0 vlan ${ipaddr_vlan}
> 	    ip addr add 172.30.${ipaddr_vlan}.1/24 dev ${vf}
> 	    ip addr add 2021:db8:${ipaddr_vlan}::1/64 dev ${vf}
> 	    if ! ip link show $vf | grep 'state UP'; then
> 		    echo 'Error found'
> 		    break
> 	    fi
> 	    ip link set $vf down
>      done
> 
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> Reported-by: Yuying Ma <yuma@redhat.com>
> ---
>   drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 1ef4cb871452..8a1696d7289f 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -907,7 +907,7 @@ static int igb_request_msix(struct igb_adapter *adapter)
>   	int i, err = 0, vector = 0, free_vector = 0;
>   
>   	err = request_irq(adapter->msix_entries[vector].vector,
> -			  igb_msix_other, 0, netdev->name, adapter);
> +			  igb_msix_other, IRQF_NO_THREAD, netdev->name, adapter);
>   	if (err)
>   		goto err_out;
>   

Thank you for small, localized fix with a good description.
Our VAL will check it also on non-RT OS.
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

PS: for future intel ethernet submissions please split out fixes and
refactors, and tag each commit with the [iwl-net] or [iwl-next] tags

