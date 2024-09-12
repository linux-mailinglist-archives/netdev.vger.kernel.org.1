Return-Path: <netdev+bounces-127850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C87F4976E07
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 17:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED1A91C21CEC
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 15:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFE11B9832;
	Thu, 12 Sep 2024 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HBP980kI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C453126BE2;
	Thu, 12 Sep 2024 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726155746; cv=fail; b=HLmzK6MFQUDJi2P/6SZ5x6smOj8L0k+MFw7n2q29i+9XUX9LW+RdmAqDip8rY0umpqS+XOTgFync/L9/y0k6HsqAbKDZc+kjafbVqVXilj1i0OEFxy33pkFsfeD5mdobkiMo9FvzS5w83Ufd7XFZSH9T7X1//uwJgGAs+4EBw3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726155746; c=relaxed/simple;
	bh=erO5pc8ErssW1/zt8q6/qI+4LCAAUSgwIa/liPpELAs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=frfce3RI0zh7F8zIgibblc8ljMCQ9eOSxNbcrQgD/AU7VXjSh3xEarD5rnvvrL7LBO18JXB170NveWXBRVVy4Xq63OC5+yj7rTThLtPoubbgNU3ESOcoK7PMNvnDOVjpAfNO1+o3fb9O23Zgg8GMbukxazZqf+NWE5ZY3e7ORDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HBP980kI; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726155744; x=1757691744;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=erO5pc8ErssW1/zt8q6/qI+4LCAAUSgwIa/liPpELAs=;
  b=HBP980kIC3JFZsmyzO7nx5mOSuh9qMROZUutypQNktM5Ie8ohRJG4+Yc
   7fdm1YDk3BDCsPzuamWOWSFGyszhahZyjT5O+IakgypWqdllD9pZwOngt
   Urs5JzXcXAN1mIR+Hd/OocMwYGh972lTslCgwHiyo440YZMQpi1FnxPkG
   tKiHxn12kZKt7eCPIcCs1oiAqB17QD7LxsoE0Ojoq29kAFtccVt+Z6MMh
   vVM+K+NhZ+fM0yZC4tUBlNjRuS3CeVU5dFuxM3q4U4W26wFEaTh7huYAk
   gbYXgE0S3NGmR/HamVz/ey+U25nc6cBCFj+JcxUaIO/N97LEmCZho7F9l
   g==;
X-CSE-ConnectionGUID: l67/mxGeRB22VcWEBX7nHA==
X-CSE-MsgGUID: 5/yaHsRrTZ6mS9lmkSQyww==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24892399"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="24892399"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 08:42:23 -0700
X-CSE-ConnectionGUID: 8uFnBepqQ0ytAROLSnSo+A==
X-CSE-MsgGUID: +gOQYFZwSWK0HB+glHI/wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="68003732"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2024 08:42:18 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 08:42:17 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 08:42:17 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 12 Sep 2024 08:42:14 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Sep 2024 08:42:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OuHth/rypkHIjZLARxC8t+2nMa6j70CJ7WaRL1/oIAsmvNDVyea3zs92LpoDBZKXwd4pWLUKGCw1TZG7gCtF+lVYR5+J1Sp8BDxXyA4prJZznuT993umvKDU5tVfOvsBU8e4V1QROI4qbJMxM64xsnGOJAHI6H0veF3JDeZOmz4a4RHaZ+BQ4aznp5NXieh0g/qHhcnnpwr2NLHXJJ+oWcsFlog6wnjlS3qQJoyhYtm7VgyhCFOpahgRz4oqvMSE2BYgKPGa4a4GaOTgGpUNAQcMjxR9mnDgna1LYBtIPkkOHy5LjLGwNkdIQa/IowXE76LJtLBjdGdjGJ6b049Pxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0o//5X7ImJDvMOS09yzd0byN6sjvJYm9bllb7H0ouQ=;
 b=QTuYCvs6WjUn1AJJJYKgI7wqwYruFcggm1rNTonrCSiFutaDFQzyYiT3nYVrFa+kVY9ob4qaiQMlEsKKTAJCHT6p9P6HkMdoyFsIVl8hjM9cfGOvWl2T7BDWnADB8EPfhjC3NAnJ15pPtlzqWidLaZzF1SofLRZh8E4q51TvIbPzSYzpLuEJWTMtmIccXkpWPWqbUT+JJ7p1HU1gOQjCXNwslOWaBbDCX2GZc5v9h5XQ8QamhbX8LrTWDUNTkcJH2rCiuT7EIRrdRBo+2TIWp74aHxJuq2gnu10Slp/4oSuv6SCUcDarf/3J9msePj8dJsDVXU2gVVBQMiGRDLDzTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4886.namprd11.prod.outlook.com (2603:10b6:510:33::22)
 by CH3PR11MB8707.namprd11.prod.outlook.com (2603:10b6:610:1bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.22; Thu, 12 Sep
 2024 15:42:08 +0000
Received: from PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::9251:427c:2735:9fd3]) by PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::9251:427c:2735:9fd3%6]) with mapi id 15.20.7962.017; Thu, 12 Sep 2024
 15:42:08 +0000
Message-ID: <785a6cbe-da9c-4d76-807a-54d0007745a9@intel.com>
Date: Thu, 12 Sep 2024 10:42:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/4] ethtool: Add support for configuring
 tcp-data-split-thresh
To: Jakub Kicinski <kuba@kernel.org>
CC: Taehee Yoo <ap420073@gmail.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <corbet@lwn.net>,
	<michael.chan@broadcom.com>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <ecree.xilinx@gmail.com>,
	<przemyslaw.kitszel@intel.com>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
	<kory.maincent@bootlin.com>, <ahmed.zaki@intel.com>,
	<paul.greenwalt@intel.com>, <rrameshbabu@nvidia.com>, <idosch@nvidia.com>,
	<maxime.chevallier@bootlin.com>, <danieller@nvidia.com>,
	<aleksander.lobakin@intel.com>
References: <20240911145555.318605-1-ap420073@gmail.com>
 <20240911145555.318605-4-ap420073@gmail.com>
 <c970e22e-9fcc-499a-8c83-32b41439cbb9@intel.com>
 <20240911173150.571bf93b@kernel.org>
Content-Language: en-US
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
In-Reply-To: <20240911173150.571bf93b@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:a03:255::20) To PH0PR11MB4886.namprd11.prod.outlook.com
 (2603:10b6:510:33::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4886:EE_|CH3PR11MB8707:EE_
X-MS-Office365-Filtering-Correlation-Id: 68e318e6-cf92-4062-6757-08dcd34175ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDUxYnVVU09GVjFTTGRucHhQdjNTeFRCdkxIWFRRcmVFamwrdGx5YnJIN0Q4?=
 =?utf-8?B?OWFwcFVnajlSUVlIczVYZWQrV1RNVmVIcit5K0lqSjhZc2xrWldHU3NLOVBn?=
 =?utf-8?B?S0pkV0F5RmliNVo0cXBwSkxGVkVpZEM0T0c4c2cwK1BpT0kvZzFXZ0lIOUYv?=
 =?utf-8?B?ZkdpRXJITGhPNnU5dGdiUitRUWJCa3psUWlyejZCRkcxWTMwY1pUaUd1SEdl?=
 =?utf-8?B?TEtxZE5MV3AvRkt5VjNRZ29kcVB0RmtCbWFHd01KWWh3OHRhY0xSWWpOL2lK?=
 =?utf-8?B?cWdhVm5EQ1pZZUNNY3ZXMjdQMmt5K3NJWWRSUE5NdnpqaVZiV2FCbVF3ZTdw?=
 =?utf-8?B?azJhMVc2NXU4d0dTMkEwWmtpU2NhaUY1cDVsZkNqNXY1OFFIVExqQUx4V0RG?=
 =?utf-8?B?dWJjUXVadVkyUDd4cnVzZjFpbEs0Vk10M0ticG1FYlZpT1hVRVo3ZG1OcVJF?=
 =?utf-8?B?MEJSbHk2WmdTS3h2WnFKb2pXV2VDQnZSUytNMkN6SmtyODVNVnppaUw3M0VW?=
 =?utf-8?B?YWtzbFRxRktneGRNVmxXRTB1bVNOaTBkZUduOVpreUNXc1dWREdmOWFlelBt?=
 =?utf-8?B?M0RkeHUvbVhrNEgvMDNaOUNJMXRQbXZUWTluQU1lb3Nsb0Y0bkJZOWFuVkVr?=
 =?utf-8?B?Vi9EdHpTQk9Ccm9xZW1lcGd3d1R0Q2VDbTQ4dWQvZTBXbGZvMjRKaGhZaGlQ?=
 =?utf-8?B?azhscWJMdWRTM3U0T21lK0NwKzhLSHVKdTVIM0hPZ0xDeFY5N3FMUWdwMHcw?=
 =?utf-8?B?TTBVcVFDaU9lRE4vaFZzOXpMNTUzOFlSN3JRQUtFM0VYdVpEUVZ6YzdXb0VB?=
 =?utf-8?B?elF1VGFpUm1GcERHZnkrUi9ZVDRUekdlSHg4b0pJekxJSmkzcnZocVNMM0Vp?=
 =?utf-8?B?YWtwN3JieXVsaWgzSFpVcWgvTXRQSFBxdzJFem9UMTZJZ0sveCtZa3JMaFZL?=
 =?utf-8?B?d1hiV2wvZE51MkhZVElSdGRyV2huZVZYV3FtaTFKY2NrWjdMb2JtOEY0OEx5?=
 =?utf-8?B?OXljRjhtcWpFZVhISytmRzh2QWpPQ2JhdFZyNWJkRXM5UkJlUUI1L0NMVzdG?=
 =?utf-8?B?NlVZdHFueEVua0NaUlhQTVhFNW9XdGRsMnJycnorRU9Hck5sQllKUTJMcjBC?=
 =?utf-8?B?QUpXSU0rWnYralRyMS9Qc0lLOUxZVXQ5Z1EwbzZQWXYwdExvSjhRRW5ZbkZ3?=
 =?utf-8?B?OWpRb0htSFI4YnR2VmFXMmpTQ3VBUk45K2hNc1BCdUJTTGNQbmEwVitpcVlP?=
 =?utf-8?B?K2ZRS2MrcVFtdjhIMVB6Y2lFRHI3Vnhmc3Yzd0d0SEk5NWxieFY1OVJMUEN4?=
 =?utf-8?B?dC93azNJdnJQbEtTaUp5TDhudFJackVweFJKenVPLzRvNWZGZUwwYTVSa0hX?=
 =?utf-8?B?WjFQMDZoYTUyQzFOYlpRMUFpemppOHhlT29MQmlCeWtwclJ3ckFwUVdDNWZx?=
 =?utf-8?B?Z2hLRXhvaGoxOU9XZzVQbUdxeElicDdPajZvOURHc2NJdkREMzdZRXhUU0VW?=
 =?utf-8?B?UzVkMHQxTXdBbU9xQXlpQm5DMHdZQXNxSUxhZnYydkF6ZTBhQi9jZm5NaFlj?=
 =?utf-8?B?azJjc2FaLzl4V2gvRmlKY0s2SjI5Y0x2RDBTYXdCSmtiT2xDUDcweUdtZGkz?=
 =?utf-8?B?aXU1dkR1eUVBaU9aOTVTNjNLNTNXZ2JDV3FVNll4REl2MDhrU2Yxb2JkK3Z4?=
 =?utf-8?B?Y1QzWU5acWtWZXppWWFwbklSdndFR2ozMmlTdGZvNEVzM3ptMTlNU1Y3bDNr?=
 =?utf-8?B?MGgyUmk3ZFdyQVlHWEl4S2d2YUlOSjVhR0Jnbk1NK1ROOFRoKzNVMWM5TlMv?=
 =?utf-8?B?OG1WdGt1T25OdlJBRVA4QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTROTWRwQnEySmpUOFRjUDNNTEMrWFR3SEt0bzQyeVlZcEdnOUpsUE5Pdk1w?=
 =?utf-8?B?Y052YzVXQlIxK1RJOGptQ2c4QjhOT1dLcFAwTkJWNFRtaXpldkVNa244OUZ3?=
 =?utf-8?B?VDB1a29HVi9XVXZrZ29VMG5FVVFQdytwd0FTZ1l0TUR6bG1KSWZkZWZIOW9P?=
 =?utf-8?B?NWE5VVF2d2dua3l6UE02V25nQmkxTFlBT1h0S0gxYVF5dGF4MkJ4KzUrdnVm?=
 =?utf-8?B?VUFjTmhNVlA5blRvRnppN0hqZnhoVEFDVnI1VTlEMFArNmtRSlBHNVRVSzZK?=
 =?utf-8?B?ZE04UWVxUHZtT0Njc2QyRy9MazNGS2xsWEtpQWJoSWhueEVGdWdmMzIwK1hE?=
 =?utf-8?B?dlVKRFhwZEh5TmVQRy9CSDR6UGNyeGMyMUVCRnM2MmpSblZqQW5kWFJFSEJF?=
 =?utf-8?B?K1prUFBGOTd1anJWLytxc3k3V1RFaXdYczFUOVlLWXpsNU5QZUlxNmZZbFU1?=
 =?utf-8?B?bmxBQ2xxQmVPOFVRVjQ0SXJRWERkL0hiNkF3THBPR3Flb1RCcnR4endyckJ3?=
 =?utf-8?B?LzJPNUVndHpiNm9qbUpHS2dNS1BEZW1IQXg0MHhKZmpOVUJoZkc3SlN5TlE1?=
 =?utf-8?B?UU1iOGphMUo5ZUtycUFrRVlzQ2FkMDVBTnhRdU1oUU9POVdlT1NqdG9QblFa?=
 =?utf-8?B?NEVJWkhzYytNLzNQdVROa2hCQ0VkQnhJUDNNZjQ5VlJoNE45SVpxWGYvenpI?=
 =?utf-8?B?eFlBTTV5WWExSnFBTVIwR2g3R3BOZ2dMZS9WeEtxWDNXeDVhUVoyU1kyR0N2?=
 =?utf-8?B?N3F0Wk5wM2JaVnhScmNxNW4zSnBBMFQweEVGWmVkS3RMcjg1azk5U3B2dGpx?=
 =?utf-8?B?d3l2UXJqWkpocjgzMTJvbTRiZ1BZYVd3VlNZRE95SVhGcnAyOFVnVWtSRlJY?=
 =?utf-8?B?anJyUWN4U2ZZUlpTT0pPbVd4NVp6K0drYlRPK1VtcEZ1RkEwaXdHZzk3eitV?=
 =?utf-8?B?a3BUODRRRjAvQlY4WmJmSVBLUmgxaTVZbk5yQ2FnSzVFeGZkNWJNOGl2NVdS?=
 =?utf-8?B?eWRDNDhvRVZYSUtTZW5VbVNMckMzbXV3RzZldHRENEpURHpCSTRMNTZDWVNN?=
 =?utf-8?B?dHI0aE5NZzlNOVRxN0NCTTBCWFlMbkp4Y0psS0pSZ0w5UThRejFKQnJZNnYr?=
 =?utf-8?B?b0U3NzducmhjZ0pnajkwZEFuR2xUZnJ3VXhSUk1IbFJFUUJocU5nc29PUUZa?=
 =?utf-8?B?Y2IxbThTcWpKcDMvUUFpNzNiNnlNdTNBRDl0RDVldTBoY2lPWHEvTmNIbi94?=
 =?utf-8?B?K0JUNVV0OGl0T2JMOWZrVy85TFlId1ZlSmQ3WEZVMXg3UUltcVJhU1lacSt0?=
 =?utf-8?B?Vm5nenNONVN5SEFQV1hld3BhcXVucXF3TmZ2bG53cVVScDlLN1psM2VOMWpm?=
 =?utf-8?B?RC9acE14bVRWcXErYUlPcStBZGtpeDhmaE9GNGF5a2h3M0V1TDVJb0s1YXJo?=
 =?utf-8?B?S2RJanhld0p5SDhvWFNxancxMzFHY0ZIWjRKdGlYVHNGSVZWbVV4clhNSXp2?=
 =?utf-8?B?U0JNamN5UGFYUDRMT25xSjVsTFAwWVpUU2V1NytndWlqS1J1ZlZJMzJ3dFIr?=
 =?utf-8?B?QVN0YWQwajE4K0ZKQ1l6eWFweVNObUx4d3hkeUdUYUxHL3JkTDFNVVRibUNI?=
 =?utf-8?B?YzBycDMyRTFjdXkrYUFoYjNMem44bVJhYzhsY1M1MTZDaU1DbzJkYmRqZG5C?=
 =?utf-8?B?ekNSZUJNU1VBelNCSkEvTjJmUGxYa0UvTmxyQjk2R2RHaGVRbmR0SW1sYXlu?=
 =?utf-8?B?bjF1L3k3dUtTLzY2TUNzQTI3VXZwZEJwUmV5SnlGa1FJeUUyUU5PVmRWZHBC?=
 =?utf-8?B?NkM0cjYvMUdqN0EwcE53WFZKRUlsZzRibjBsMS95cEhpaFlnRlhZZHJ3aExw?=
 =?utf-8?B?TmtEV2FtYVA3M0I2enZqdjJEZExjRHJEKzg1Y01NellPZ0gxcnZDRXZtSkI0?=
 =?utf-8?B?dSs4WlF3YlVkcXIwNThOc0Mva20wVkNmUDVGZUgzcE1oSVpPbkg2bzJJaVZS?=
 =?utf-8?B?VXZ6NjRtbDFBS002VFB0TGlMelU1N2RFL1hRUjVEdlBqMXZNMHFpT3lNZ3Rw?=
 =?utf-8?B?bTY0bUJ4azZsQi9RWHZHUEl1Yldha05KZFdWN2xkcEJYeXpPWkcrZGpEZTV3?=
 =?utf-8?B?ZGxjb1RNMUNHY2JPRlRQWm44b3FnU25TUmd6Tm5RQ0V5RXFtSTJNQk0rWU9j?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e318e6-cf92-4062-6757-08dcd34175ba
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 15:42:08.2666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NvQF62VNeKEHEMqqcRlIkzYoWVSiiZbCcM4WljUUjXw9JAThLhNUwwJil17I5Y4ThkpTXr/engKWd94dVka7XDT/thMn2fqzUbhmzoW8JDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8707
X-OriginatorOrg: intel.com



On 9/11/2024 7:31 PM, Jakub Kicinski wrote:
> On Wed, 11 Sep 2024 11:51:42 -0500 Samudrala, Sridhar wrote:
>> On 9/11/2024 9:55 AM, Taehee Yoo wrote:
>>> The tcp-data-split-thresh option configures the threshold value of
>>> the tcp-data-split.
>>> If a received packet size is larger than this threshold value, a packet
>>> will be split into header and payload.
>>> The header indicates TCP header, but it depends on driver spec.
>>> The bnxt_en driver supports HDS(Header-Data-Split) configuration at
>>> FW level, affecting TCP and UDP too.
>>> So, like the tcp-data-split option, If tcp-data-split-thresh is set,
>>> it affects UDP and TCP packets.
>>
>> What about non-tcp/udp packets? Are they are not split?
>> It is possible that they may be split at L3 payload for IP/IPV6 packets
>> and L2 payload for non-ip packets.
>> So instead of calling this option as tcp-data-split-thresh, can we call
>> it header-data-split-thresh?
> 
> This makes sense.
> 
>>> The tcp-data-split-thresh has a dependency, that is tcp-data-split
>>> option. This threshold value can be get/set only when tcp-data-split
>>> option is enabled.
>>
>> Even the existing 'tcp-data-split' name is misleading. Not sure if it
>> will be possible to change this now.
> 
> It's not misleading, unless you think that it is something else than
> it is.
> 
>    ``ETHTOOL_A_RINGS_TCP_DATA_SPLIT`` indicates whether the device
>    is usable with page-flipping TCP zero-copy receive
>    (``getsockopt(TCP_ZEROCOPY_RECEIVE)``). If enabled the device is
>    configured to place frame headers and data into separate buffers.
>    The device configuration must make it possible to receive full memory
>    pages of data, for example because MTU is high enough or through
>    HW-GRO.
> 
> If you use this for more than what's stated in the documentation
> that's on you. More granular "what gets split and what doesn't"
> control should probably go into an API akin to how we configure
> RSS hashing fields. But I'm not sure anyone actually cares about
> other protocols at this stage, so...

OK, as the the main use case for header split is tcp zero copy receive 
at this time and the documentation is also explicitly calling out TCP, 
this should be fine and we can introduce API to configure header split 
behavior for non-tcp protocols in future if required.

