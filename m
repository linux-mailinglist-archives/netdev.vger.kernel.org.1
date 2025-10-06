Return-Path: <netdev+bounces-227976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD57BBE667
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 16:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25944188C44E
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 14:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0722D594F;
	Mon,  6 Oct 2025 14:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dh416J21"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D8A194C86;
	Mon,  6 Oct 2025 14:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759762194; cv=fail; b=GN23SRU7nUk0vSb1c+uuGbc6Wj6NvbWdvejqpIkejasWOQ2M7ebCSt45X+y05ODZq+QkU0TZaqjOp+ZFrBQ5qg7DdeCWX5hzmgVo0WpEkAfXEnT/vSvh+nM3yyAaeL9XVpA8fDYYFM+6AULJ/kbvsWfbwo5SuaH8LKEYiOzPhYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759762194; c=relaxed/simple;
	bh=Yz72uvLcC64Zb7T+2r5bVlJGJpd5ANo8277/GgLYY9s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gVqHJzYYYU/gtc9iAYus9r1HQgOJseaEdA85W+ohadUMrHc9oLJzBmNyDEGvEl/rRKBbZMFkbWwgncKS9I+D6PG/Y7Dl7ZW4z18LVV34LOvRz5UyuKGhO8y2MfXbArXtVVBHpnBeFnV/nZOVa/K4aKY8qMEFt2Nwbqn9Bghlsd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dh416J21; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759762192; x=1791298192;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Yz72uvLcC64Zb7T+2r5bVlJGJpd5ANo8277/GgLYY9s=;
  b=Dh416J21B3meTwnBMvH4GSuzayoYkGfF0thmZNNWwuj/JyhB7RrIurNy
   ou9J3x7oK7u1KBc5YlHuY/2JKuBTzHN70d3fbeKOheVhyw2TLoftIMizH
   RpCsdc9WSipkANnSbl3WBScHNtACkaEjxhN8qxN0NjmRTFUqIl2t78UHr
   gm2LWwCwVHSFWZHBmBHlZ31k5jIibsAYeo9fQQyWAnY+j9+BeT1sBJOmD
   7Da94XL7a02+DLIEBbvQ0rseuMj7J94ABMEswVlELkxDx2ffmtLQcBeVv
   cZ9wjctlSc0OntBXQz2DQZk7i9d9ONnDhtsbYwUGaOnWh7Yl2lIjYTLEV
   w==;
X-CSE-ConnectionGUID: xXLLkBkkTHKCOMtL7OalWA==
X-CSE-MsgGUID: fKXCWa4OSe+d4Rq2IWiYQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="73036975"
X-IronPort-AV: E=Sophos;i="6.18,320,1751266800"; 
   d="scan'208";a="73036975"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 07:49:46 -0700
X-CSE-ConnectionGUID: VlcrEHT0Tx60DLPAjw1L3Q==
X-CSE-MsgGUID: UtC94N5pSZOD9NtAEIOSpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,320,1751266800"; 
   d="scan'208";a="180313951"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 07:49:44 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 07:49:43 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 6 Oct 2025 07:49:43 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.71) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 07:49:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BMCSHBBO7KrUEhXwM0wIw9MqQN86su/MVPnfIKx3/D68Oblw0yCGNz2dfDkZCmLNKs7MwcvwTtSp8bss84VzMU/lEHF5yZXGWpaHLoHuJgEh9U1oIipR3IDHHOCRCxB2PAsxFv2/zh/swKPwD1C2BwtTezuVXjKU5wfvnWlssLFMOhKH9vpgBuEkw16d0Fi+ZFuZmywWOHHoIZCtRxcxnAsp3cEP8BxpS4B7Bff6MCgE+tSQgXCD0w8BjLMiDD6YZrnHsrBWXOA6Rp0GZaXpCxLErQODCV2ZfnYVVHUyDzUI50Mql7HgQY8J4tM7ccMssEAEdVJthStnJg4a11gPNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQ+LcpNi9x3ONkdhGv6aTOgT7cOrWyy2HeQStP0gZ44=;
 b=fNjTOD1Pq68WUTN2HL0nzmtBkzOTRLcKCkIjbTMIpQng0VHEEde+PRFN1CFSKkw7PZx5E6ROA6QLjGe/O+VkTB/+0SqeInKga3pPkKOjI4Bb2FM3anBl5q4i9lGROq8V8daJB8uxfhaS9Q15wh4T6pOl8x2jaeoylbjlQQx7CHErShy0OstTQGp5d0ymPOpGiU5d9HAQqtfw3YX+rq+Jt4h34AUxy5DWSJ6tdXuOKTK2+V8zh/x61eM+tVewcx2Yc5shFLNlOHzt51H7pljT1fl7Yf3qdpxjPOkNJZJPlzkmXgWYjO8w/ZMdzWntqKLFh/iide3wrCngakDytdcFMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4538.namprd11.prod.outlook.com (2603:10b6:303:57::12)
 by DS4PPFA2144AAC3.namprd11.prod.outlook.com (2603:10b6:f:fc02::40) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Mon, 6 Oct
 2025 14:49:37 +0000
Received: from MW3PR11MB4538.namprd11.prod.outlook.com
 ([fe80::e117:2595:337:e067]) by MW3PR11MB4538.namprd11.prod.outlook.com
 ([fe80::e117:2595:337:e067%6]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 14:49:35 +0000
Message-ID: <4a128348-48f9-40d7-b5bf-c3f1af27679c@intel.com>
Date: Mon, 6 Oct 2025 07:49:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/8] idpf: fix possible race in idpf_vport_stop()
To: Jakub Kicinski <kuba@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>
CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Pavan Kumar
 Linga" <pavan.kumar.linga@intel.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Willem de Bruijn <willemb@google.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Phani Burra
	<phani.r.burra@intel.com>, Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Simon Horman <horms@kernel.org>, Radoslaw Tyl <radoslawx.tyl@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>, Mateusz Polchlopek
	<mateusz.polchlopek@intel.com>, Anton Nadezhdin <anton.nadezhdin@intel.com>,
	Konstantin Ilichev <konstantin.ilichev@intel.com>, Milena Olech
	<milena.olech@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Joshua Hay <joshua.a.hay@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Chittim Madhu
	<madhu.chittim@intel.com>, Samuel Salin <Samuel.salin@intel.com>
References: <20251001-jk-iwl-net-2025-10-01-v1-0-49fa99e86600@intel.com>
 <20251001-jk-iwl-net-2025-10-01-v1-3-49fa99e86600@intel.com>
 <20251003104332.40581946@kernel.org>
Content-Language: en-US
From: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
In-Reply-To: <20251003104332.40581946@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0286.namprd03.prod.outlook.com
 (2603:10b6:303:b5::21) To MW3PR11MB4538.namprd11.prod.outlook.com
 (2603:10b6:303:57::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4538:EE_|DS4PPFA2144AAC3:EE_
X-MS-Office365-Filtering-Correlation-Id: 4491c7e1-7298-439f-4395-08de04e79136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WEl3NVF5c2Y1RVZBL1k1L3JqRDNRendKa2RLZ05jYk1Xa3VNVVhieWp2RmF0?=
 =?utf-8?B?TXpxSW1QNmhjd2ZRQi80Wk54THhoVDIrdU1LcURPcy9vUXgvME9UcEY5Z1dB?=
 =?utf-8?B?K0hxSEpRNnJ3emRSbnc0ZVVTRjdvSitENGVrM0Q3UHhkOFZwOWZwS2RhQllZ?=
 =?utf-8?B?S2ZyaFBxQkNNU3BqNXZEOSs2ZU5MaDFZeWxrajNkMFRRSFJvTytpZThGNFdx?=
 =?utf-8?B?MENvYWp6UjllVFlzZ1MvazNyRFg4dFJTbmNVdGFpZVFudGUzbzBHVUVtdlJI?=
 =?utf-8?B?THhHTURjeWtjMmFhS0p2elh2K3EyUlkrS3o5bXEyUDRYblJVMUtjalZKbGpQ?=
 =?utf-8?B?YVR3K1VNbXNJY0NJQ0toenlmM2RvMnhKQXNOVXhlSDJtRlRyc3owSFMwZHRU?=
 =?utf-8?B?VVZjYUQvSXptaWpOdElrUDYyKzhKQ1NxOVpVMC96alRJbmtYV2JUdFRhcnhz?=
 =?utf-8?B?dTF1SzBXMFhlVnB4NVo3WnNjaGlpTWxRMnA4cEN0emRvaHdJRVBWb3lLN2Q3?=
 =?utf-8?B?MnNtTTJKMEU1NUhjcWRxRkZDMGUyS21uOFpMWnNUWlRldkxCcExlWjlnQkpC?=
 =?utf-8?B?MURnT0FnWlVWWENuRzA5VWE3aEtmQjlrRm5RTldSdERDZjlMMUlhQmhqdVl0?=
 =?utf-8?B?K01BT1Jab0ZhaHpXalVMbEtUaEFORkkrckJBY0NXUlB4VVgwejd2Y0plRUkw?=
 =?utf-8?B?V2xlU1lKYmVwUys4TTNUNklqbTFtejdNRW5PeEZGeWZDNkpMYmpRaVV0c3E2?=
 =?utf-8?B?ODZQMmhjNEdnaDI3TE1nM1ZiV2lXS1pWY09IRHJ5aUs3aGdUbDUrTEh2Z2M2?=
 =?utf-8?B?VDd2UmtQTCt6RFV0MDhiT1dXc2gvUzRNdHVYZlUwTXNncFhxZ2RRYlRabkpi?=
 =?utf-8?B?ZmNnNUppMktHWkNkNEUzdWVETU5RYXMwakdsU1VWZElHbXFQTU5ubGZWRno2?=
 =?utf-8?B?WUxJdG9oSmx0RVpYazRBa2JxOVN1a1BSMGpoZzI5Q2tqR2ZtdnBseVBZYmZN?=
 =?utf-8?B?ZlN5WkE2ZkNNanNVSTIzUXNrQzZpVXE3TFJ2RDhrRXpCaWMrT29mQmE3Y05V?=
 =?utf-8?B?TVU5T3JZWGhHQjhjTElxRE9XWE1mbGUyb0dDQXgzdDBaYy9pckxnTGxuc3NY?=
 =?utf-8?B?dFZlTTRvT3NYa0dHUk9PT29Lc2RWdUFCRGFMMGM4RUpxcGJxbFdsTDlpcXpt?=
 =?utf-8?B?OEN5cFBNYndjcUFyQ1d0TnVBUGJhd3BxL2dpKzJqY1hLMFFZQWx5UGo2dHNu?=
 =?utf-8?B?VnJMMDhCT1NMYWV1bmo3MStWSW9XZkp6YktEbVJ5S3J5U1FJSFRuVTVqNkZY?=
 =?utf-8?B?NjNwV01GYWdoeXlHUFVsK2FaNUFWT2RyYWFVLzhMV3o3VjVYc3diVXN5TEpX?=
 =?utf-8?B?M0tNazdQSS83L2dvNElhVDVOazJyNVhhdjRkRDVCNlhKNXhUcGVmelFabVVV?=
 =?utf-8?B?QWd5ZVBkRVNZTXFkY2hGNTgzajZkNnVhblJIWmNpa1hwdzNTcmFIVDBNaXdl?=
 =?utf-8?B?OW1xQ0dvd1FIODJBWkU4eDh0NGdPN215NmhJMk9mQ1Nlano3azFBL2pRcUda?=
 =?utf-8?B?RzFkcWpFUzdkSWlTWHFuaUdBN1pwcGhIZE52aTRZcmZhcEpKMmNFSHF5R04r?=
 =?utf-8?B?czQyejVlYWlaMXgvSTRvaml1TlRCbEFvWHlMcGZPcFNTaE5CNGhYcXQ3S3ow?=
 =?utf-8?B?U2ZzVStkaGNNd2g5WUxseVFNZ1QzWGpaWDJCRWVxMm41cmVYY2FQMTJiT0RS?=
 =?utf-8?B?SG9ZMkliQmlneFo3VGZacW5Bc2lDazNMU0hzd1U4UzFKQys2L1BNYnFiWHdu?=
 =?utf-8?B?V1NNc3hRT0xKbkgzUTM0Q0JUSEZybGhoakpLUFM1cGsxRnhMaU54U2crNmc1?=
 =?utf-8?B?TjZBcm5mZ0FSUGNmaWxpZHl1b1k4K2RXY2FuWkgrUDA0SDZ5VjFZZkdzWHFp?=
 =?utf-8?Q?VCcAHvXbu8178ADR3lmtiT7plDlBpufm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4538.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmtzMHZwUWlMeGFJSjhPWXJZWVhCY1JocDYrQXV2TUcrV1BEOGVmeGZEUmVv?=
 =?utf-8?B?bEhYaTlNeExoeW85Z3Ezcy9UUGN4ZjNrbm5VTEJmRkpiYm83VzQ0VEJzWE96?=
 =?utf-8?B?OGREcVJSVW9RMmd3UUNjcmVVNThlcHFYUnB5NVFjNTdGUFZ0THN3YkRUV3Jl?=
 =?utf-8?B?MzZJTFJlTmh5aDZSYjhZaVpMT2NQK2tMWkpYR1NUaXBhcTdwbEdnejBMMnFY?=
 =?utf-8?B?SW11V3lrZzBXWityWVdwbXZ2MG1tWkJvL2s1b3VHeVJvcjhlRmNBSkM0bkJF?=
 =?utf-8?B?YWVQYzN2ZjdFYklxVGtuN2NKQ1UzcVZUYW44SVZWQ0YxTnExNkZuWlo2SWg3?=
 =?utf-8?B?emZEcU5VVVdxb2tlcHltRlVzWG5odXE5NEpQVXlyV0lDbjdSelMvMHNJdHd5?=
 =?utf-8?B?Ym8wUmJzRlQ0MHdEZnA3YXpxc0p5N0xBOGJPYU5WeThaeXhYQVF0ZHFXTjBp?=
 =?utf-8?B?aEY1MGw4TXZPNFBKNXVYcFVZWk9Eb0V5TG9SLzdQV0NFV1UyQ0VPbGdteUY4?=
 =?utf-8?B?Mk4zZWRQUlBEL3I3L3ZIaUdrNE1QSi9veUQreGVrdkhzaDdJZUtRSml0N1My?=
 =?utf-8?B?Nm5OZTlBRDd0MGdMMWJSZFo2ZEs3TDlRUit5bTY0WFRNeSt4RWdJMDF2cGxv?=
 =?utf-8?B?TXJFeUsvSk9DWXk2TXBYY3ZrYnFKbEo3Q0QxdXc5b2hSUGdzSTF2dWplSE9q?=
 =?utf-8?B?aldtVWw1SFJ3L2pKNk12S3JhbTNwOXN5MGN5NC9ONTRTUldXYkR1R1FIRkJz?=
 =?utf-8?B?QzZYK1RuWDFFTXluMWozVml6d2VQRFVTL050aHRFVWlWRVBpR2FSZHZLT3BQ?=
 =?utf-8?B?MGYyM0M5dWU3ZXlGV3ZCOTJQUjdYZDI0TVp4SjhtQ2RobzJWT2EwWjBQeC9l?=
 =?utf-8?B?YnFPbEw2QUdxdk9ObHAzaXZzOVpUamh2YVVOc1BSRlZpRzZnZ0thQlljZEg0?=
 =?utf-8?B?VlVkcklnM1ZCRHJxUmtJbk9zWUZ3Y3FWR2t3NWNXemJ5RUdvZ3Z3V3RFMzEx?=
 =?utf-8?B?aFM3OGZWM1Fwai9YN3h2aFUxRjVrUG9rTlVIWmNRM1lqdGdRcXE4ZFEvcDUv?=
 =?utf-8?B?TTFiZFpRUUV5aHo1emthTEVVUmlnUlhPMC9mN2RUbDNSTlEyWC9QaVVhWHlh?=
 =?utf-8?B?cFZ0ODdkVUdOUlNPUWpTcmwzb0pZNENvUFpSY2E1d3p3SXJnczZidVVnNzFC?=
 =?utf-8?B?RFpaejVzK0ZvbTM4ZklQZGRLNnFGbnF6WWVRZTVqdlhYNmZzblNHZjczNSt2?=
 =?utf-8?B?akpKMGZDbmIzUE5nMmtRdGxEbExtYWcyTFdyUzRESzJXRjZhbk13QmNZMitV?=
 =?utf-8?B?RFN1d1VjajZoeTJNRmxrV2FtbU1RdjhxcXRMK3Z3ajdhczZreVBDdk00VzZ4?=
 =?utf-8?B?ZDFaU3F2VlNiQ1RPQjltTXdUK0wvMDhVZnZqVXNFbWZQaHdOTWU2R1Y3eXhl?=
 =?utf-8?B?bDR0bzRLSllFUVpwdDlKSU5jVWhNQzZVMEdMczFtZ1UwZXJBemFsRitrbzQ3?=
 =?utf-8?B?K2VCa2JjczQ2RTlsb3VFR2pJY2kvNlljdm84V2Z0Z0dHYTByRmU4eDBLTk9J?=
 =?utf-8?B?OWxaaWJ1SU44Y2pHNWZUVjI2Nmk4S3JmaGp0R3ErWUZVRDBPVjVvR01Rcmhq?=
 =?utf-8?B?MnBibnV6ekIvZHNTZTBXc1hTbm10OWM1ekd5M0Q1RFVWZ0xWY1k5NTVpVUlM?=
 =?utf-8?B?TXY4ZFVLdGtscFAzeU9ieFZJKzM3a3NYNFA3MWhRYkNyK0lGR3VyQndQR2pT?=
 =?utf-8?B?S3RhMzhoK2lqK2lIRzc4TldySG5WRHg5MUlIY3lWWERweFo4NGJobWoxZWMz?=
 =?utf-8?B?K29CdzVqeCtlbnlWTkJpeXd1WG0xNkV5c05ua3doaXRrSWFTdXA5MW5EY1pH?=
 =?utf-8?B?MFk4bUdmZVgxaFNlQ2dSM2ovVkh3MjRMdmpYRGs1b0RUeTRCQ0Roa0lyS0VX?=
 =?utf-8?B?cmhsSXEwanRQSFJhMk1zTHU5bmtDTnl1UFpDMlNOK0dlSWI1UDZLNmRVeFU5?=
 =?utf-8?B?SmNFaHdtNDRxYThYYTR0YVdZTDFydnJsNVpJakpkZjNFY05ZRVVSNlZQdWZp?=
 =?utf-8?B?VmV0KzRFOUFRL0l5dzhOR1AvTFZ6bXgybUFQNFNvdGt0TzhQNWdobDFLYURm?=
 =?utf-8?B?UnpydGM5dGhEU1RDbDZYUWY2S1hxMWJ1ZXVJVW93azByRW02ZjI4alFLVERy?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4491c7e1-7298-439f-4395-08de04e79136
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4538.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 14:49:35.5436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yeEVW+fvq21cas+KJcEvjuhQkaiy5GJofvo5ZhlPphWyZe0H89NQ+5DtOImHfZbqmmbdTXLb6+4h1QMHhrNWu9adcIHAmlC9deyFoF3xhm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFA2144AAC3
X-OriginatorOrg: intel.com



On 10/3/2025 10:43 AM, Jakub Kicinski wrote:
> On Wed, 01 Oct 2025 17:14:13 -0700 Jacob Keller wrote:
>> From: Emil Tantilov <emil.s.tantilov@intel.com>
>>
>> Make sure to clear the IDPF_VPORT_UP bit on entry. The idpf_vport_stop()
>> function is void and once called, the vport teardown is guaranteed to
>> happen. Previously the bit was cleared at the end of the function, which
>> opened it up to possible races with all instances in the driver where
>> operations were conditional on this bit being set. For example, on rmmod
>> callbacks in the middle of idpf_vport_stop() end up attempting to remove
>> MAC address filter already removed by the function:
>> idpf 0000:83:00.0: Received invalid MAC filter payload (op 536) (len 0)
> 
> Argh, please stop using the flag based state machines. They CANNOT
> replace locking. If there was proper locking in place it wouldn't
> have mattered when we clear the flag.

This patch is resolving a bug in the current logic of how the flag is 
used (not being atomic and not being cleared properly). I don't think
there is an existing lock in place to address this issue, though we are
looking to refactor the code over time to remove and/or limit how these
flags are used.
> 
> I'm guessing false negatives are okay in how you use the UP flag?
> The commit message doesn't really explain why.

I am not sure I understand the question completely, if you mean that the
flag is cleared before the vport is actually brought down, I did touch
on it at the beginning of the description, once we enter
idpf_vport_stop() we know for sure that the vport will be brought down 
and that is how the present checks in the driver for the UP flag are
being used. Specifically in the scenario that exposed this issue, the 
driver will send a message in the middle of idpf_vport_down() after
checking the flag.

Thanks,
Emil


