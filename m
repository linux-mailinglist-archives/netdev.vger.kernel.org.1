Return-Path: <netdev+bounces-210205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFE6B12610
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 23:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D20D188CE46
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 21:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8770425D20D;
	Fri, 25 Jul 2025 21:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K765W6nt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E696ADDA9;
	Fri, 25 Jul 2025 21:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753477966; cv=fail; b=lB0UfoH1m0rMmrIh6q8b+lFKQ9COgZVqIsGFdSjlC+iHmlWZ/WVxzP07b8Qx7RULX/KXYtn5uKej2NK9r0Muw6ivPrw8cenbA3t1BKOoVz2QVUkGYJ+TOOvP8gb7aTbxBpDBco2RYeJ/gMXyQT9GVEqsM1eLTqEwWgT1NchVkSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753477966; c=relaxed/simple;
	bh=KJAnDdfONTS5FA+aa82YU9NEc36SV1UfPmJUy5psOC8=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=UUUu5rK4zbEirGaw3UdcYY0+lgfih8QGwgYN7jWsRXQ7uwiCfYZ7a8EMnxqawpQd6DHOgWYctV5X0HzR14rp/DPWOc6s0YBBffjX2ai0jf9igY6Y9yWW/L2XPjoxl7YJg03c/hFtUs/Am6a1vDcQ/e/15MhcPynLxWvnN/lK2LA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K765W6nt; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753477965; x=1785013965;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=KJAnDdfONTS5FA+aa82YU9NEc36SV1UfPmJUy5psOC8=;
  b=K765W6ntpUF+XMcxu9YC/OqhEaLU8GAgc1rC2TfbTE5YhSaUOe75TwE7
   KlbNk4tGtyz6AvPDqgHGFTX+g5ZUM4Om374wmcGlzeZEMULcMxMNcZ78l
   IcPHEqfr7+7RD28cpkE2hbO5oCgcfqHz7PL+uL28WFpcACGEiCt2PjAUy
   5mvsjDLTlUp00hDIe4psyIubYwe8gFXpLvsnWlxJNhbvIXcpGTiIfWr4P
   JRmcsaNRtRirXVSG/KHKcsiLwONzkYES+YAwgHHrik7huwmWxl3TIJLBM
   OVe8QVmuAZKmC3ppxdC7ess+75k3GIySzGDQmDGrIsZEZjCb1TxKunixr
   A==;
X-CSE-ConnectionGUID: ncUK58FSQr+v6eSyEyFsSw==
X-CSE-MsgGUID: CRMZtLu0Qy6S+pEH8sDE7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="66388102"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="66388102"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 14:12:41 -0700
X-CSE-ConnectionGUID: mnftb2uYQ2y/EM3ApNrP+Q==
X-CSE-MsgGUID: 9NmLMe7pTsSB0KPgyxdcsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="165216404"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 14:12:35 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 14:12:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 25 Jul 2025 14:12:32 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.44)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 14:12:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2kxu8bzH1E2bJfaCsJU3u8Otwx8Q2AfuiXqNWCJ8gssgHfcRyaFvEW0a/PaOGtUjEjA4duuTYsjBPwSRQiq2yYMx2J/HZtJbR7OhEukTDBWHP7cB0wo6rjTc54HPiuZPa8xfDmLaP+Ijp6tyEO2p3hADtL8xOL/l8aXtgJXvfEsKbr19hQujWKQwzL2LVMMRWavqC8f+gUCqQthELG/rhfoCARudEYQU2YIFhzUcEj2WB149npbqH29iWM9RYn4rapemr09w8yKtn6yqOm9nw5TLoMB2P5DPbt+OHgY1bQxGUMAixDnFsGnhTSpWhX8WaJKBsU05JwIi0+hVPKLfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSrwLNzeFInSOP7yvmZPksxYOv+KCz2tJhQT0A5e3q0=;
 b=TxLGckIZ73Mg6nj1z+bbxVIg/QW6wDvctpslfzNkqCc4KX1FcH8GWZWZezoc/e0I8Zrdk0FcuPyZ30hzOx+47bmZB/SFKSPlvMfArFIl9arJbv9Te6mIa0YvKWOgFmiUPc2d4mkOWAZ6TxBCSIfW/OCJsazHYSc9ad2F32gbpAsOigORfUTEWwBYsSYfEf0BXIjMMo8fHeFVuRuRO1ZuvbwZjyUILnz6GlOawJTo7mgRiQY0yPwmGuLek8WN7L705xxZ5//h6tDruXd49ae0UNxwUbYaNvtYWs83ywXkiIsvqj51q7W+JurcCw8IcPfB43G7rY5n96kz7o29xW6lfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB8445.namprd11.prod.outlook.com (2603:10b6:806:3a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 21:11:48 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8964.019; Fri, 25 Jul 2025
 21:11:48 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 25 Jul 2025 14:11:46 -0700
To: <dan.j.williams@intel.com>, <alejandro.lucero-palau@amd.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Message-ID: <6883f312e6a35_14c356100da@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <6883ee5a34049_134cc710072@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <6883ee5a34049_134cc710072@dwillia2-xfh.jf.intel.com.notmuch>
Subject: Re: [PATCH v17 00/22] Type2 device basic support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0050.namprd11.prod.outlook.com
 (2603:10b6:a03:80::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: 16fbd0fd-07db-4910-c3b3-08ddcbbfde6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ekNqeTVJTnRBaml5VzJxVVZDczNsekFlY1V1d1NrZXI0LzNZd3o1TkY4bDhR?=
 =?utf-8?B?b29RQnk5MnpsNHJFT3RvdXo3SmRhTngxeGttUlU2R2Z0MEJNYUZZSW1Ba0xv?=
 =?utf-8?B?akZhd1EyUzFIWlZDblNQWEZ0ZUU0K3BYcTRJSEdtVDRtb1dobE8ybUVSczBK?=
 =?utf-8?B?OUdDazJqQUwzMVJaWFo3UjJTTllGYXFOVVRYaU1uc3JVbzB5ZjRKS3pTWW9q?=
 =?utf-8?B?NlA0d1BLK2pwRGhHS0pTaW5jbmxETnQraWxHMVhVTkRwSjlyaGRpVC9majcz?=
 =?utf-8?B?WVZtN2xFNXVob3dZN0hCMzY3OExScW9LUURZLzZMdStjZGlaNk5TL3FMVkFm?=
 =?utf-8?B?V1I0MXoyUnhNdlBQQ2pOcTQ2aTVyMnNHZ1Bwenc2Z01oZ2FpMzk0azhNa0JD?=
 =?utf-8?B?NjdtQ3owdnRPU3F0K2JjVUhXRlZ5bU9VWTJaQVZVSHpqdFVxL0FJYldCL0NN?=
 =?utf-8?B?V2wyWTVNdnNidE04SUJXL2NVQzJLRlppRlhabDFkdXZxNXBORDFISWdobTJC?=
 =?utf-8?B?eklLNmp6Z2JuSDhxVCtjcG05cERsRDVNdTNFZWFHQTVxZmRWc1FJb24xUE9N?=
 =?utf-8?B?QlY3YnlXN0lPMkJrVDdoU0NtbUV4Y0xnTkF3RHN0MnRRSVJjWGxYVys5cXdu?=
 =?utf-8?B?VXAzYUNmV0tjclVxanc5Mnc2STJuWmt3M2VpdjN6VFFzQUdEVUcrQnpjOTNt?=
 =?utf-8?B?dGVOcW5RRE03WTFXbENpZ3Rua1pYSU9EL3M3Qi9DME5KWG9WbUwxa2dqZ2lZ?=
 =?utf-8?B?TThvaTBOSXJRa3JSZ3I0NkM3QVloQlhCSDQzZTN6ZnJWL1ZoMGtsODhuMWZi?=
 =?utf-8?B?K2h2bGJqOHpEaFh1Vm9qQm0wTHFzQ3Y2L2o2UWQ0Z3pnRXQydkNHeEVzRnpu?=
 =?utf-8?B?blptbkNKMlI2Ym53aFh6L3ZlL2Znb0xwZk13cjEySW1Dbi83T0paMjh4VWdK?=
 =?utf-8?B?b01nQUNPUzNTNUpBbHR2T3JrK0hWck50T0ZkUHBqNFZHYzBwWElRUExsOXZB?=
 =?utf-8?B?MHNZZkJ6cFdaRDBpRFB1dkNCbTdUSjYyampSQTJ3N3dScXRqN3BVU1lweHEx?=
 =?utf-8?B?b3RleVlXU21Vd1dvdnR5akw0bDFBa3kreHZMUW9GaUVZVUo4TTlwZmk3T0NX?=
 =?utf-8?B?VUFVaXhwd2xRTXFoNnJhMks5Yk5HakVXdUxRNXBERnBYMmZybkxRNE9Dcmww?=
 =?utf-8?B?dkp1YjMxZHRxczdISmRMOU0xTU55aWYyRkhyUW9iRCtvMHE4a1dxWDYxNXJU?=
 =?utf-8?B?LzJwSDFmeUZjVitJcU1vaE1QRlVQa25hRFVRTkF6ZmV4eHBrMm1TNndpZnhU?=
 =?utf-8?B?NUFvYkdReWY5T1FRNktEeGl5b1pHVGVoWmJTL0xoL3VlNThFTjJmdFY5SVRH?=
 =?utf-8?B?dTFDR3gyQTM1TXJLdWdZc2tTVWQwWTA1dTFXanFsc2lmaVpXdE05dVZKMXhE?=
 =?utf-8?B?ODhBbHg2YlRHV0xHSnhzaTN3cUdSOHhBcWFURDdkSUhlL0VDS1lsMktoTlZE?=
 =?utf-8?B?RzNKM1FaZDJoalZYNzVoMVNFOXE3NDY1UzRtN1VkYUgwaVlkR1ZTOGxMT3Yr?=
 =?utf-8?B?RU91YldadUx2MkRueTZKQm5kTGcyRmFITmNLclNFYWdES0RKemtrZlQxa1R6?=
 =?utf-8?B?VkVuMWtEaGJMd3RYNjY5L0EwVFhIVk80c1ZRYjRZTFZMcVErV2k0bXZVc0pJ?=
 =?utf-8?B?bEp2QXV5cnhhaDZPWE56UUxwWnk2VG94UmJTZ1BHa0YwQlVlV1E2ZU94aVYx?=
 =?utf-8?B?MWxtMVRucWRrWmI5WXpTM2dpSGQ1YW5PYkRLdmdhRnVheGdIQ0cyV0Y0R21R?=
 =?utf-8?B?eFJtbU9scUl3UXZOdnFpWjExRE9zZEFLcHJtbGpaZ1ZWendBM2NLMjEySXNh?=
 =?utf-8?B?QXA5bGdmcnZuZm9nRW9BTElycnc0b01lNnZGQjBnaG95NldvOTZjcy9HMzRt?=
 =?utf-8?B?YTRYSE5OT1B2bllxckE1bTdHNVNmdHN3UkFZaS9YSGpTWXFQMW1yZEFiS1Jw?=
 =?utf-8?B?ckhrT0xSd3hRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzZCNlhKa1Q0MTh1M1UyNkZ4U05Wb2lYeEJ2NUI4eFFEUzAwczR0aTlEaStE?=
 =?utf-8?B?NWxINXUxN0h6M3IrOVlNNXR1SXBNR1RmRzNrOGEvemRTQTlaZStBVTQwK2xP?=
 =?utf-8?B?NnFuU0t6bm1QekhraDU5bTYwUXhrSWl0Ym53dUJmejgwOSt3SCtJMnQ0eWRs?=
 =?utf-8?B?SlBoRS9KRDI4Umlnd012cHBDQnhUaVdYSlJNUUpIYWFpWnNlQlYrTWIwdTlu?=
 =?utf-8?B?Tml4dnZEK1RpTHdQbEpVR3FXRU13cjZRSGlCV2wzRExzelR2TllnaDU2ckQ5?=
 =?utf-8?B?RllLRExCbnNjWWU0clZtRm00VVZqOExpalJHVytLSmt5Zy8yM0Y1cGZlVjdN?=
 =?utf-8?B?V25SVmJVcDBjWEx2NTg3MVZQZkw0b2Mxd3FLY2dWQktZc2hiL2ZqMitGRGV0?=
 =?utf-8?B?M2hJNXZ6ZGhYRzNjRDFLMjhMVi9HaHpxczFMMUZoUTlDNURWRkJSVUlOck5u?=
 =?utf-8?B?bVJINlo3cU44czJwSWw2U2QvV0VmL3NkaVVBbG9FblBrR2lZejRpL0VWdnVt?=
 =?utf-8?B?UTVHYjJINzlVSml6dDh0UFVVMFVyVDE3cDh3VjUzTzdNK0w2Vy8zZzlwVnVk?=
 =?utf-8?B?STlxUzAzYitVSGdoWjNuT3ZvZHVJOVJ4cVI1OWMzNnpibS9pMXozTUs1empw?=
 =?utf-8?B?ZzdxWDNSSEVRb25NTlFhSU9kSzRjRDFaU05EbytLUmVXUnNULzZVMzJUM0Fl?=
 =?utf-8?B?YUZ3cXlZdXZYdGVJalowaUZXS3ZDS2dmMFFodkJtOWFQUXlPdmhUd1JnU2Va?=
 =?utf-8?B?eHRyS2dYZHhZR0preFJaTlpvTElYSjUwcUtuRzNSWGxCckdOclc4bFNPbFBL?=
 =?utf-8?B?ZUhqRmRWS3dXWEgxcTVsMUhBSTh6dktPbWxrbTI3MGx4QjV0MUd0UHJSenVl?=
 =?utf-8?B?QkVWWUVnS0d4L0xMOFcwM1pzUXFnaVRJTFZCZkhWMWI0bDZaa1JoNm9razU4?=
 =?utf-8?B?TlZMZGZXVG52U01SRFF4T0VCZEdCa252YnlIOU5KSXJibUxzZlVsUTRLTU5a?=
 =?utf-8?B?N1RsNldQU09qNWh2T3N2VWVwbE8rS2ZCOUsvSzRCWXpXRGsxdVhzUHlJQkFH?=
 =?utf-8?B?Z1hPSlo1UG5XOUVCdkZvRGFnTWlpTm5BZGx6ZVF4bUgxWGh0WmdicjJOWGx1?=
 =?utf-8?B?bjc3Zm1nTVBlRGJqQVJIQjAwd3B2Y01NVllyeWlYaFZvdEoxcEc4cDgzUE1U?=
 =?utf-8?B?R3l2eDBhQVV6eEwyN1NRaE0vK0Ywbk1vaVBqRnVtRUd2STE0UCtWVGdPUHZk?=
 =?utf-8?B?dU0xVldZYnNJbjVVcWYrY09aejNCS2dxaXBIazJNN0dDbC9YL2JaTkpoTVJt?=
 =?utf-8?B?STlUQ2RJdzBjSkxvckVZZVhiZ1g4dStxRm5HRmRKZEJEQjlMOGlVZ2JheXE1?=
 =?utf-8?B?NFFQb2VaNEc4WVRkUS9xREJ5U1VmNnc1ODdraXJvbnNMOWdWQ2lLdVd0ZFFk?=
 =?utf-8?B?eFBsQ3lCemhWVHhQL3prQ09tMzVGOVZabnk4Q2E4eGRnUUZXMTNQV0hRTHZP?=
 =?utf-8?B?Z3VnUHUxUnRLTnZaSituQldNRFB4Z3h3cjRPWjl6OFY0VVo4QXpRaWpKcitt?=
 =?utf-8?B?Y2oyZVlLUGduYjRJTFZ5VU1FN1lLZU51Y2Jpbm8wSGhUOXJTK250U3hycGx3?=
 =?utf-8?B?STlaT2tGeSt2RTdCWU4ydzVOMzB1SlJkamR6dnVycitpQnNPMExCdzhFLytM?=
 =?utf-8?B?VU4zWUJKS2xydFFrR3d6Q0ljUWt0VE9zN1Vad3djaGhtUzR5VGpvM01oMWlE?=
 =?utf-8?B?cFNuUkFOSFlEMWlCUm9RV2tGc2tzNW9wd2d2TGVFTk1JcEZ2UTR1Z3dGdHhk?=
 =?utf-8?B?cjlkWlRKS1lCT09NQXB2VVFxV04zQlBDMlQrZEVyL2c4MkdmdlFNR25kWjgv?=
 =?utf-8?B?bVkrSjkyaGNxd3MyMHkzWkxReVpEc3dMWlVhRzlIcCt3cm1ORldValZSVmpH?=
 =?utf-8?B?TlJ2SEtQcFp5R2FGSkhBTUM1OTU2ZWFDNTRvV2tGZDl3c0o3MmN1dHFOOTEv?=
 =?utf-8?B?VEZmWGNJNTJ4NlZwK2RKZGZKT2k0WUNCaXVDRzFFNkxMdGtlTE04SUhMSWZh?=
 =?utf-8?B?UmtTa1IxTnplNWNMSXhSMEI0OVdndk5CMTJ6bmN0UWY0ZExsWGs5VlVuaXAx?=
 =?utf-8?B?MjBWQ2lTNmpsWXFPeStscER4TGlJNjJ6em55ZDlrVmtMMk1LSEN0aWE1amNB?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 16fbd0fd-07db-4910-c3b3-08ddcbbfde6c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 21:11:48.8344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xNgdLF2Xk2wun1UKoA29w5b0TIaqa/MtjGKUrDUNpDnHTzHMJH7svLLfadmALyHLmWC46nqZAltW6A1vdaCTbBeMLBkOZr85U18DjrQq/mA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8445
X-OriginatorOrg: intel.com

dan.j.williams@ wrote:
> alejandro.lucero-palau@ wrote:
> > From: Alejandro Lucero <alucerop@amd.com>
> > 
> > v17 changes: (Dan Williams review)
> >  - use devm for cxl_dev_state allocation
> >  - using current cxl struct for checking capability registers found by
> >    the driver.
> >  - simplify dpa initialization without a mailbox not supporting pmem
> >  - add cxl_acquire_endpoint for protection during initialization
> >  - add callback/action to cxl_create_region for a driver notified about cxl
> >    core kernel modules removal.
> >  - add sfc function to disable CXL-based PIO buffers if such a callback
> >    is invoked.
> >  - Always manage a Type2 created region as private not allowing DAX.
> [..]
> > base-commit: 0ff41df1cb268fc69e703a08a57ee14ae967d0ca
> 
> That's v6.15. At time of writing v6.16-rc3 was out. At a minimum I would
> expect new functionality targeting the next kernel to be based on -rc2
> of the previous kernel.
> 
> It might be ok if the conflicts are low, but going forward do move your
> baseline to at least -rc2 if not later.
> 
> This highlights that CXL needs a
> Documentation/process/maintainer-handbooks.rst entry to detail
> expectations like this.

...btw:

$ git merge v6.16-rc7
Auto-merging drivers/cxl/core/core.h
Auto-merging drivers/cxl/core/hdm.c
Auto-merging drivers/cxl/core/mbox.c
Auto-merging drivers/cxl/core/memdev.c
Auto-merging drivers/cxl/core/pci.c
Auto-merging drivers/cxl/core/port.c
Auto-merging drivers/cxl/core/region.c
CONFLICT (content): Merge conflict in drivers/cxl/core/region.c
Auto-merging drivers/cxl/cxl.h
CONFLICT (content): Merge conflict in drivers/cxl/cxl.h
Auto-merging drivers/cxl/cxlmem.h
Auto-merging drivers/cxl/mem.c
Auto-merging drivers/cxl/port.c
Auto-merging tools/testing/cxl/Kbuild
Auto-merging tools/testing/cxl/test/mem.c
Auto-merging tools/testing/cxl/test/mock.c

I am ok with conflicts with cxl/next because that is a moving / rebasing
target, but conflicts with mainline are the submitter's problem.

