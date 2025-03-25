Return-Path: <netdev+bounces-177613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 608AEA70BE8
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 22:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED3AD18987E8
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 21:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37E7265CD4;
	Tue, 25 Mar 2025 21:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hw3wujoy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F051AB6F1
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 21:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742936887; cv=fail; b=VVj8izlFHh7FvouJIh73CR/Vu3TgJQOx4yvbyuWAYErfuWbE+Qsz9HUESqcgeWxlTcT1fCgZhPZkV+qFGnCCnw2de0QPLXN/jpv9GmwgMYs2Xm9UEtEbaIHmjkF+mle3l/6KD7ThpdWhGBG1Jzrn9cWlhFC3j67Gkkq1pyZ4hzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742936887; c=relaxed/simple;
	bh=Pxgg7qRxVBCjZGmbJxQVZp+Kz9MMLn+bWsZdOF0JB+0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uay8AWGQp7OXhE1DN7MtD56U1oBJppuWwsp9es778ZDJdB6y5wV9QDsufoInr8G5m0dSBWfuqO2Xq49aPFooqzwGBRQCk1tq/gPXoz5CNn7Bp5tuLoH3JSM5O5l0q3cRunNt6WDyudYkB40GcTlOmN7Jas48S/p+MtCNQgqPvYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hw3wujoy; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742936886; x=1774472886;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Pxgg7qRxVBCjZGmbJxQVZp+Kz9MMLn+bWsZdOF0JB+0=;
  b=Hw3wujoy81IebIlTVwgiTylUAhXtYrHzLmUyShhdcU04A0B1BH++C0KC
   5/ieteAL4S7SW0aUVFdBlaQMmDjrhAZvx+5h1hQzTWD0tO/3cy/WAGGAE
   QZJ7ek0bFXnWs6odL6goU55+gaVmeVKnBaOMHR4P0Fhu5EbWgRdK8HPZ/
   tU7bAQYzi7c/emTR/MGRvmPaxj+GX/mBw+KO1g6JwVC8K+qE+AYvPQz3K
   u04xuYRXlqflBhUxZ8UM/Eu9YcZqF6JbNRwELe6lpdqiHZWveEA8VJf/a
   0YZ1baVFSwhkEESB2XYKK8+XaDf6/95KM4xyL5nuh3X7uh1ylkNtMl2wI
   Q==;
X-CSE-ConnectionGUID: cJe614A/Q4mdvSTMEa6MWg==
X-CSE-MsgGUID: hfuPc6JWTNCvu8E7uTUNxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="54869883"
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="54869883"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 14:08:04 -0700
X-CSE-ConnectionGUID: 5lubQWTRRBuaVuFpyzr0cg==
X-CSE-MsgGUID: FiCHIJO0S56vUvJXeFThZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="124215646"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 14:08:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 25 Mar 2025 14:08:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Mar 2025 14:08:03 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Mar 2025 14:08:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fP/kOEBJQ5FWWSA6Eviy8cKnrwrj0YLNCuIKKt4uRwFf/wOzRkDfpr6I5b2u9fxbI19apmvM3OhWFOUV7ZZSjus6YVEMM4jas18diA9f0oUpcNQRayKWtrcwMBDXgn8izMFPX76O/78IF5fo1g8Ks2YJR16qCXOzLr1rBVyHo1xOkfdxQ9Vl9N0RC/KcT4SEIeREaHi4N6OKa3hBeS8zFxOwi742wOg1DRr6heSS/KoDvjJ8l88q8UmNPLtEwjd4ZMT0RG1EVgeO0rUr4JrwX1Uv3LIqW9BMw0UaT4GkTmV+TbEXavWCYp72L8CuJLjOlGNR6Z1ASO1VA5+ihHB0Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wAoG/xJ06yjoW1v9sLBNH7Jh5G0lgFTKrxq8sbaXXfk=;
 b=J+56SpOcXbiyD7QjToqDNx/5FMzlye/QW3aRHeEJwL9BcCABK1bDNflGnLYL9eewjWzMnyoX0acG8uCtGs9o6TtZ4Gzz52rnBPFvwfQvI6ZIYJKDd4F7oiTlcYt9vBE+dvSzfIBM1g95qpQAcn6Jm5ZDUSmtqDI2O6oVEaeFOxBgdBvzMvPfve9z7vUDsHTsxgXVuEcYX8KG3nbjD1NsuyHGTE7nP4zsP0qm74eRiW/xPr/NDUiSfZe6K8WUeP3ru6amUEGkbSkxqCwEpGg977/UfPOwvkAyH7lTg2JCfxjRIwcLsLKoQxmMDSFW1rYrwZch/TXXHRoEq3iMPob7nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA1PR11MB8857.namprd11.prod.outlook.com (2603:10b6:806:46b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 21:07:56 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8534.042; Tue, 25 Mar 2025
 21:07:56 +0000
Message-ID: <6d7512f4-19b7-40b9-aeff-cae39c47423b@intel.com>
Date: Tue, 25 Mar 2025 14:07:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 04/10] idpf: negotiate PTP capabilities and get
 PTP clock
To: Jakub Kicinski <kuba@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, Milena Olech
	<milena.olech@intel.com>, <przemyslaw.kitszel@intel.com>,
	<karol.kolacinski@intel.com>, <richardcochran@gmail.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Willem de Bruijn <willemb@google.com>, "Mina
 Almasry" <almasrymina@google.com>, Samuel Salin <Samuel.salin@intel.com>
References: <20250318161327.2532891-1-anthony.l.nguyen@intel.com>
 <20250318161327.2532891-5-anthony.l.nguyen@intel.com>
 <20250325054956.3f62eef8@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250325054956.3f62eef8@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:303:8c::15) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA1PR11MB8857:EE_
X-MS-Office365-Filtering-Correlation-Id: 656b1d7a-52fa-4825-451d-08dd6be11d6f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MC9LY0V1TjFrbzhUUzFtakl2VUpYN3JhOC91Z01PbWFYZFovc3VCZ0JtZlZD?=
 =?utf-8?B?bXFYYStFR3RkcVVubGRacURVWjlDTWN2blhFbTRLajVtelNMTlRwWkNiT3M1?=
 =?utf-8?B?aFBmZnpCemV6VG9DejhJNFFyWEhKZXc2WlpDV1BKMmhYYlBzQXAxaFpUQzFM?=
 =?utf-8?B?S25yTzF5dlIwRGh4TmpBQUpVaVE5eXFac2U0K2lPNDNITm1uTG8rMWFMa0pp?=
 =?utf-8?B?WE9vb2g4S3RxMjMya0hjb0hLaG10TmswOWdFL2F3OWp0VkY0bnVtaHNhdytE?=
 =?utf-8?B?L21pREUrV2ZDVnQ4ZUNQZVBnRXI4NDJQamhaTUZiVVFXd2oxL0lGdDNJV0RW?=
 =?utf-8?B?bDhVK24zRkZmbkkxL2w2NFVFdEE3VlZuR2htdForQ3JhaCtHdnp6bEx1aCt3?=
 =?utf-8?B?N3hFdWZaKzFham1VVDJIamVNMXcwVzhXOURsNUNCVmxLZmtHNnVWS1Fta3I1?=
 =?utf-8?B?WldjNWREeG9xTlR5dEtFZEtiUjVDYlQzcG9mRjdpaysvZzZiTWRXK1MxUFpi?=
 =?utf-8?B?WUoySVlLU2RwY2paWXg0aWVrTnZpNEw2UnVYa05DSWFNR2EySTc0Y08vTGhl?=
 =?utf-8?B?aS9nVEg2K3pGK2hXT09zQ0owV3R1Q05LWlpURmF5MFY2WjlNM29Kc3p1aUJX?=
 =?utf-8?B?emc1MjE2MEJOT2lBUk1iSHkvNXdpaEpINUNpNENmVTV3QlpjR2hDYzR0R3JU?=
 =?utf-8?B?eEdibFRSK2t3NVJBUW1sZ3hNcmlEU2xodG1reFR4OTRvUkFveWVhOTVKTldD?=
 =?utf-8?B?SGZFTXl3WHJtdVY5S3FlbW5HVzNXNjMycGVIM3RNejROdEV5STJoUi9YRzNl?=
 =?utf-8?B?QTRWTDFGL3MwMlJXNFJ1S2lyR2hDT1hOdkpEcFBJcTE4QmlIK1ZHdkEwMkNs?=
 =?utf-8?B?dWY0cC8zQUJ5UW1wMjR3VkFJQTMwWmFmMkp4ZUt0VTN0d1k4Z0UvVlhtK1Nm?=
 =?utf-8?B?d2ZCRzhDdVphb29XdGNPbWt1U1RYVWMvSFRtcnpKcnlaU1oyWEV4cUlQd2VF?=
 =?utf-8?B?UnFFaDI1cVRKTzJHVGFtblkxcU9BYVZ4Y3EvWHp6STB6cUVEMUlpY2kzSlNl?=
 =?utf-8?B?cWY3eU1iQk11Zll4ZGdGa3VoWGlyTitMNm9HbCtRV2c1QkNBUzhBUWNmVTJs?=
 =?utf-8?B?UFhCWG9KZlBjL3FBMTlYRkkwYmdqVU5FVGJNci9vMWQwN1NmZjJmNHIyN0p3?=
 =?utf-8?B?VjBqcHUvTlBJdHNMOVJvR0VxNDdKUzNTVUZLY0ovVHJwclEzSkdNM2d1OC9N?=
 =?utf-8?B?c0tUYkNWWjB3d25PRFgyYXVPVWhiRk1XZWtXMnVkTGZJRllLakZMOGwrSWZ0?=
 =?utf-8?B?Vk1pSng4aVV2RGxSRFB2MW9kYWk2TXpiUjllS0I1TVprbCtEVUR1bkRJcjc5?=
 =?utf-8?B?enk5SDhBMktMKzRwQUh5Rm9zU3hwY2FxQkg1T2NVVVZzZEkwRzJ5VFJtRjZW?=
 =?utf-8?B?T1E4Zi9jSytPQWxWcUFKcWd0Wnd3SDg1U0lRYjhUTzBFV2F3QlJ6N3JiNHQv?=
 =?utf-8?B?VTIyTEpiUTBCazJOQ2E5L0xWUjY2MXVuMDlFS1kydG9zT2szZnhZbGc4YTBk?=
 =?utf-8?B?VDAwa0JreW92ck1teEJqMkZwdlExUEFXK3p0RG10cTU0S2x6T05FSWI2MGkx?=
 =?utf-8?B?RzFWclZiNWZnK0E1NUJ3OUlNYWo1QmVuVFR4cnpueW1aMmVjVnY0WXhsa0VT?=
 =?utf-8?B?cGJwWTdiWEg5VzhBeWVVWmJyTFoxNlRRa1FTbkJDM1k2S0JKS1VBdXZjcWkw?=
 =?utf-8?B?cTBFVmlWM1VzaEJNYVppYnNrL2hkWnF5VkxkVDBaZFZyM3ZnT0x2RnhYRXZo?=
 =?utf-8?B?bm4vLy9JVGFWczQybHVtSitaT3hCekhZTklqY1FvcEdVbEpxd3JFcFZrdE1P?=
 =?utf-8?Q?XUk0e3wS6FFJT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEdRS0pianFCVFkwc0NNaVJqTStTTW9naGVCV09rY01HdGNUUHdDdEFzelp0?=
 =?utf-8?B?S2pXU2ZYQy9YRThDN005S2dFZTIvWkFJQ0QrWEoyVmFQZnJISzk4aFEwaVB0?=
 =?utf-8?B?clRuMnJNcWhTLzZrWGtlbDA1VTRMa204ZUh6a3VmN2plWE5KMCtqODhMQXRJ?=
 =?utf-8?B?ZjNCZXB6R3N5UGhBbE1DaHduMFIybS9tSzNkK29sY0VRUm9pbThwZ0d2dEJX?=
 =?utf-8?B?b05kVEg2TEY3eUszb3RNN1ZMWCtBdjVMZDVOY0pTcXB3QWs0MHNrTXlSWksx?=
 =?utf-8?B?Z3FNSWxqcVVtVWdLSmtmY0UxNjk3bE1DQk9ZbS9PR0p6bE5VenI3TGk1Ty9Z?=
 =?utf-8?B?bXorYk5ObW5zVzg1T1FCcnRFL3l1QXNoS3JnZUhwQkZ1QnJCY2tadmFSNHox?=
 =?utf-8?B?U1M2T3Z4QTZDOVh2UG1TYWZ5amZOM25HSEJ5QTN5a3BEcUwzK1JrWEZkVGU0?=
 =?utf-8?B?QTIzaGhDWlZJT0V6UEJOMWFSRFhkTWxnNXUvQnFEUHdMVllxYTZPWEowSGpK?=
 =?utf-8?B?TGJtTi9iYThnZWF5ZTJwYSt4L3FpVWluVGVYUnBmQW9DQzk3RHorWFF5WFgy?=
 =?utf-8?B?djVSQWx6NkhEWjRhQm9uOFZXRUI3UXRobGc3MVAydnQ4VDJZWVVxeUd1cUxn?=
 =?utf-8?B?T2JXUDY2MkNBNDAvYm9LMk1zZUIyYlRudHBwQ0d0ems5S1RYTVlWcmp1R1lj?=
 =?utf-8?B?UUxqdnVjcmQzdXZtQ1ZPSzIxUzFUOVFSTFNpY0IwS3lKODhzSDFpS3RBZk9h?=
 =?utf-8?B?OGMxRHZTYXVlaVhxbWZ1U2hxY2krRGNSRGRYZkZjYVkzYy90VmdsRkJhSkU0?=
 =?utf-8?B?S0xZQXJzSVpYQU5ucy9xZHlBUE92L3ovalhmajc3Nlh2RmoyeXQzLzl1OU5D?=
 =?utf-8?B?aXNHVk9Ka0tZNlRoM0JkRW90ZlFDMkJhMzJLM0tmVHVCNjFwbVpuVEJSYVVi?=
 =?utf-8?B?YllMKzNIT1k3cy9zdk1sU3FycG5MbHFuVGprZGNHcW5NclQ0SmdsemRHNE9Q?=
 =?utf-8?B?TzExajVZMkptTkZQemVIMDl3Tk4vWmRRbnc0NTltdW5ZcVVhemFhOVAyMVE4?=
 =?utf-8?B?UitVWDlTZ1ZFRzI2N1R1OXd5Z0lKMHFVdldGSzVTNzYxcjZDZUM5Q3pMV2ZH?=
 =?utf-8?B?N2o4WXZ3OEhyTk56SFRKM2t0VVBPN1RSODhpUHY5eWo5cUQ2bEdLK3JKbVJw?=
 =?utf-8?B?TnhvRkJ1N3kxdFlXRWllbWtvcFNEM1dONVVMWDlLWEJoaXIzSEhOMlJuMFBy?=
 =?utf-8?B?ckJ1STc4cFhSa1dUN005QzA2K0NwbHF2QUlWZUFBaTMyOXVremxxcWxIR1N0?=
 =?utf-8?B?RTRnVWhuR0xpbUZQb2dlekpYQXdlNjVRRUlreFJvQVcwMXgvcHgxKzBRNWJa?=
 =?utf-8?B?b1NnUnVjSFlPb3p2TkdTNlZLcnpNWEN3RmIwaVpjOVN4Z3JKazBmdlhJSmkw?=
 =?utf-8?B?MCt5YnhVM0l2c2R6bm9sU0hoVFZzeWh1ZlE5YUttQUptQzY3Rmw5N2gwVStj?=
 =?utf-8?B?WC9RZlpiYjJ5TDlUZktVQVNaeGxZL1dpbG00a2RkOUV3TkpDVU1TcDA2ZDRD?=
 =?utf-8?B?M1RkQU81SVJ0Zm8vazRyOUFjT1ljQ0ZQOUhQK290VGtGZzlDUGRpZW9SZTl4?=
 =?utf-8?B?MTBmTFBIcWNqcG54NzliNHZOcW5tZERZRkcwRGx0TkpaMnROdFV0L2FvUEY4?=
 =?utf-8?B?ZXRPSndGUzBuNkJlRGN4RkpYRVFwMHhsVXZIRnlNQ2NwMXMreVNuWHZ6Vksx?=
 =?utf-8?B?K29hRHZzd0FUQ2dRTnB6djl5YW0rWk1HMVJHVU4yRGZ0a3JWN1cyNkh6SzJq?=
 =?utf-8?B?NnJKL0lqdFg2N1VKTnE5WUxmUTRuQnovNlEyT214WWpka256bUdpUnAwLzRp?=
 =?utf-8?B?Tnlhb29SRmN0Mmpkdm5XaEFZS0JibG8wN042UVNidlFyYUI3V1Bhd3Bjbzh3?=
 =?utf-8?B?SDgxNWQ1cURBcXRYM3dxRm0ybjVBNk94SlpnaGk4cll0TExKSGJjQjgyRGhV?=
 =?utf-8?B?b1hQNmMyTVltM1NGR3hrSUo1bkszaGlOZU4yNWJLUHZVZFFJaVYyQUJvdHFS?=
 =?utf-8?B?ZS9IZlkwcVEwSEhRMGZ4SG02cFRYdUQxc3RDK3F1ZlBTVDlZYmRORWVnam9U?=
 =?utf-8?B?YVFmTk5CMkJyRTlEMzVjQjVUSHVzUnZrQlRCWTcxc0s3N09xekdNd0hNcjl1?=
 =?utf-8?B?Smc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 656b1d7a-52fa-4825-451d-08dd6be11d6f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 21:07:56.3373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5kvTv8VJ6SBS3mTHVWTCynqHudiQz6JmOOIh6OwUJlnB6whpZHpeGpdXF36Xs8UW52NjGdQqCpSrYXHlYs3q45LuQ8yiigLsEM0FVeatVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8857
X-OriginatorOrg: intel.com



On 3/25/2025 5:49 AM, Jakub Kicinski wrote:
> On Tue, 18 Mar 2025 09:13:19 -0700 Tony Nguyen wrote:
>> +/**
>> + * idpf_ptp_read_src_clk_reg_direct - Read directly the main timer value
>> + * @adapter: Driver specific private structure
>> + * @sts: Optional parameter for holding a pair of system timestamps from
>> + *	 the system clock. Will be ignored when NULL is given.
>> + *
>> + * Return: the device clock time on success, -errno otherwise.
> 
> I don't see no -errno in this function.
> The whole kdoc looks like complete boilerplate, but I guess 
> it's required of your internal coding style :(
> 
>> + */
>> +static u64 idpf_ptp_read_src_clk_reg_direct(struct idpf_adapter *adapter,
>> +					    struct ptp_system_timestamp *sts)
>> +{
>> +	struct idpf_ptp *ptp = adapter->ptp;
>> +	u32 hi, lo;
>> +
>> +	/* Read the system timestamp pre PHC read */
>> +	ptp_read_system_prets(sts);
>> +
>> +	idpf_ptp_enable_shtime(adapter);
>> +	lo = readl(ptp->dev_clk_regs.dev_clk_ns_l);
>> +
>> +	/* Read the system timestamp post PHC read */
>> +	ptp_read_system_postts(sts);
>> +
>> +	hi = readl(ptp->dev_clk_regs.dev_clk_ns_h);
> 
> So hi is latched when lo is read? Or the timer may wrap between 
> the reads? Can reads happen in parallel (re-latching hi)?
> 

Yep, without knowledge of the idpf particulars, I would have expected
this to be written like ice where we read multiple times and compare.
Unless something special is done in hardware to latch.. But even on old
hardware which did claim to latch, it usually was broken so we had to do
something like that regardless.

>> +	return ((u64)hi << 32) | lo;
>> +}
> 
>> +#if IS_ENABLED(CONFIG_X86)
>> +	system->cycles = ns_time_sys;
>> +	system->cs_id = CSID_X86_ART;
>> +#endif /* CONFIG_X86 */
>> +
>> +	return 0;
> 
> Please split the cross-stamping into separate patches.
> 

+1. There is space in the series to make that easy and it will make it
much easier to review.

