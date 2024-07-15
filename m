Return-Path: <netdev+bounces-111625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FCF931D9D
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 01:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF75282797
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 23:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C03E13F42D;
	Mon, 15 Jul 2024 23:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H6dwI/nO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6909C433CB;
	Mon, 15 Jul 2024 23:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721086184; cv=fail; b=MStNLuceAXSYmIB5dS0mUxDYFK5nOW0Wcam1VJ4yXGD8wofMNOFJBy5vpxtMgOhvQ3r8VzUH590VmvUyP6040VFMiYX+QyPDWhmr2WKvvt+i7Rq6Skp6epRSUWIvSyV8tARW0qe2r4B6xOd3JaeGFQllgi0DzE22mJaa9CcqP3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721086184; c=relaxed/simple;
	bh=pT1ACfhmDJmq4ZP5qTM1xmQ1l+Og+Ei7WCy6FZ+gf20=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E8jYKU4z5dqYONyNpBoTprWpWQf17AnAVKUx//wzxPRcxd0T7cQV1ZB7Ms8ZaYuxzbjH9nqlm2vxY4m2U7yJFnDqWxr1ckJfDH8F2EwMUwKmvZP5mL08yNbEO8TrC33u/dmTFzwmyenyKsD8ToWoS5AVM92lJn90pYVXEA06JNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H6dwI/nO; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721086183; x=1752622183;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pT1ACfhmDJmq4ZP5qTM1xmQ1l+Og+Ei7WCy6FZ+gf20=;
  b=H6dwI/nOC3uPP/O7c7eKIGFkSgvgbyOeUDFHVAvE39aQ90K5Ot30/E1n
   O/1tXWvueG+OKMjAIY3nG5qJ0uGSbxR1pt/V3z5clUIegoBfPJfRxs6s1
   Wwf5eWbO6bG+5mvcAyDKPDSJE27HlNrexbpjmv/jo+8vLxhdEwcv7vIaK
   Ryck+q/40itqxIjOqb1X6cOfICqAmowcpHY/9AhtoeXiE9zeQWcElwDGZ
   /5h32b7WHO2zLdr2fHMgGdbDncC6Zsczmn+mG9dAD2wbK79pjuewI3Kyn
   UQfl8Jjnjj+SPkgOIIJCz5GdpI/MDmd/c9DuDcQ887y/MtOobxHyPJV7K
   w==;
X-CSE-ConnectionGUID: yz/nImYLTa6tVcCS5lbJMg==
X-CSE-MsgGUID: H025mieFTt2w624OUFTuBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="22306680"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="22306680"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 16:29:42 -0700
X-CSE-ConnectionGUID: 7DS+9pyUSXSapGB5TSdshg==
X-CSE-MsgGUID: KZRrxw7aSjWVQGWww1Xr8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="49746173"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jul 2024 16:29:31 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 16:29:31 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 16:29:31 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 15 Jul 2024 16:29:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yLs+gEWwJ8LFjGG/wAwl9v1mFc6DNMtCyVs8oyC2jJyZTkhfLeSzAFeyoKFxAYBllQrBADKut7NWL+uZtIT/2MKjPseKSvTJbEOOCoS4xsQ61SWPaxcow9oNa8wmL6jTp3WfFzqYsJJ6inOpLI7ss8cy/1akLpegA6Y5MfgsVhca2nnLDYxgNEwVFfxtRCVxYmkFcmj9jhojI8tJNWPfPevqzNbWhhOh7GPtDchjc/aKF1rYp0MWkI0F0P4C0Q9sXFqnKofi2OSCyuWcAqLyfqj9OlMzrsCxsOt9H3/L3eAOIf8mkU99g8BFkjf+9XeAr9p9ezs3aI9v+gHe8Ak+vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Av+cmRf5/7l0D74mc9rnKwWdNaW4lvrBSShlECqKCY=;
 b=uut53IJJLIESb2P5/o8FTGBrEH2ZOnpzfafYZFEIdmzVt6VP38rw8W8ZbR1bqxpV7wYOoNusYbTtlrWDNOINdbVue2h+WaIW04uSPgR4PcehQC/PEMDclq2N+3B+gZd2SisUDrOSUQNMWo+54sVfZQ5sssLpQzRPLK5LKx06WTumv0ElTSA3aUxHXhxtNU7VHiEVcKFGpndEW8a+Lu1heCH7CGMyxS0a3o0ujSAhcel283ta+8g6QCZ6dAD/KRbqY7l4j37c7T80kgnU7nBMRXAiwtr83gNQjyoDR6lfYGorfD9Wa/amVZIYEreMam9QhvUydJ6nl2Nv1jDtJMaRHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CO1PR11MB4978.namprd11.prod.outlook.com (2603:10b6:303:91::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 15 Jul
 2024 23:29:29 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 23:29:29 +0000
Message-ID: <fef27c7c-4799-45c1-8cfa-d0b3c1e72bd1@intel.com>
Date: Mon, 15 Jul 2024 16:29:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 02/14] net: Make dev_get_hwtstamp_phylib
 accessible
To: Kory Maincent <kory.maincent@bootlin.com>, Florian Fainelli
	<florian.fainelli@broadcom.com>, Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
	"Heiner Kallweit" <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Radu
 Pirea <radu-nicolae.pirea@oss.nxp.com>, "Jay Vosburgh"
	<j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
	<corbet@lwn.net>, "Horatiu Vultur" <horatiu.vultur@microchip.com>,
	<UNGLinuxDriver@microchip.com>, "Simon Horman" <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, <donald.hunter@gmail.com>,
	<danieller@nvidia.com>, <ecree.xilinx@gmail.com>
CC: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Willem de Bruijn <willemb@google.com>, Shannon Nelson
	<shannon.nelson@amd.com>, Alexandra Winter <wintera@linux.ibm.com>
References: <20240709-feature_ptp_netnext-v17-0-b5317f50df2a@bootlin.com>
 <20240709-feature_ptp_netnext-v17-2-b5317f50df2a@bootlin.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240709-feature_ptp_netnext-v17-2-b5317f50df2a@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::28) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CO1PR11MB4978:EE_
X-MS-Office365-Filtering-Correlation-Id: 79f8b615-c98a-496b-aaee-08dca525f8f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZVkxcnFpQjR5RFRFYmxXS05BNFUzRXpqdnhaczdYQWJSQW9JNWdTejZyVFpN?=
 =?utf-8?B?eHN6cEl0R2xwOVhwdzY1TnYxU2wxaEUrdWN1VUphaEtVbEdBblNuVmJ5NFZM?=
 =?utf-8?B?bzd6T29OUVA2THVwUGV2VzlMMDFJam92a04wUHJMeU9abUI5OC9Ea3pDS3FF?=
 =?utf-8?B?Wi9iVVBLT2ZoTFplYzU5cTBnbXZDckZkWXVQWEMyTGl4Wm91SU5NWUdycE1i?=
 =?utf-8?B?amZrMUxyMjVwQWs3WUhUY1RCTWdDcmZ6NDJiREVEdTkwRlVzdC9EK0x2UUVh?=
 =?utf-8?B?TmxPNjMreE1HSkZzNFc4NzdTMGNBQXB5SnBjZGJtbEZuOHhtWEVPeFJjY0NG?=
 =?utf-8?B?RE5yMHJaVmJ4cEhBN1RNa2owbDVNcFl4b25tc1kvYit4Si9HVVpWRVBtMnlC?=
 =?utf-8?B?cjVRWWhtOVdJY3lMNlF4Z1lSOHRrdkE5SkxZYmYySTMwQ1lmQUtPS2tCMGtG?=
 =?utf-8?B?ZE5RUmVlclE0SUptdi9mNUFKOGxCVCt1MWtpRnU0VGdhbnVRQlMwcFFkdDMw?=
 =?utf-8?B?R0hQNnlTdXpPNFNTMm1tN093ejBlRHNDck1iRkxzL214K3NHaVYyZzZaMnlE?=
 =?utf-8?B?Njd0aUx6OXNFNTZFaXI3U0ZzRHdkb1prc3FUa3hzaHJZYnQ2NXFuaWVJSmh0?=
 =?utf-8?B?Mm1TZjAyZ2N4YytLeHE1TkFUTjZGOTJhSDY0VG5pQUF5RVRKQ1Z5cVZxVXdC?=
 =?utf-8?B?Z1pFaGU4ZmdyYjNHQXJaVyszTXNrbHlHRVlJcFhPNXpxZmVESkxrRlgyU3Fm?=
 =?utf-8?B?cFpvNEVjaFhvcnFuVHVBT0FnU1RSb0J3VlJNeUs1RkNRMFZ5eHk0Q1dIa2Zz?=
 =?utf-8?B?Wis2VmM4Y3RxRmlBT1oyTSt3TG1FRS8vOGhaOEhIZ0VFd1ZBZHZWRnpSaEJs?=
 =?utf-8?B?MlhqYzF3SGNheCtXdDZSalpscDZVZForVFZ2V1hKNFYzcUcvU0dQRXpQbEhT?=
 =?utf-8?B?cTdMRS9HNHZ0QnUxUGs1N0VmV0dQMkM4M29Tcno5N1hYQ1l1ZnpacTlhbUE1?=
 =?utf-8?B?RmVPZHBBNkh0YkVkWFVXZHdvc0ZmZXdsV2pKOTBQcER1aE1tZC9XWnplbkFX?=
 =?utf-8?B?SE9ydFJrWnAxNUxQMjk5R2pjczY0WUpXT0FGTnc3dG9wenptTkJzWitodHlH?=
 =?utf-8?B?MW9rZWhYMm02cGJ0dk85eTJsZUxIQ09JSWM0K29ZNERQSUZNc0lqMGUwM2Jy?=
 =?utf-8?B?Zkx5clVDblVPQjBITWk4QU1CWVZQby9iQk1rNUZkUnFQWFF3endtOWFRQSty?=
 =?utf-8?B?OHg0SUk2TTF6cmp0SlRTVGpSM2k3SUZ0YllGSmtwWlJ1akdJQkkvM2x3V2cr?=
 =?utf-8?B?ZmlnNHJmRW5oWWM2aDlFeGZhTytoTDBWb3RDbXpyNjliSUtwWDFRRXF3ZTlS?=
 =?utf-8?B?bjB2c3J1RVdPS2RTQ2VZTkVzL21vV1U3a1I1VlI3UWloUTVIYXdEMzZOem9N?=
 =?utf-8?B?azFvZVFWdEswMXg4QjlQc0pRekUzVEdQSVl5c244azZFUWI0MFJkdExlUTRv?=
 =?utf-8?B?ak1hVHdEeXFDQ2NxbUtUYUp6cG1XR0ozUWxDaE5SR3h2TUU1T2pPSTBXYlJL?=
 =?utf-8?B?M211YVhDSnRZVGRBWk5Rb1YvRGVTVUFjdjNvM3plc2xKQU5aVmFEK0orMjQ3?=
 =?utf-8?B?UkxYRFdzRlJVL2d3djBsajdkOFVGaHNZRTJvS1A1Rkw0bURROGR4UXJLTU1D?=
 =?utf-8?B?TlFSaDloZEhuWFZ1dWxFNXR5STkzSFpaK2I1d25wd001dzdHbW0vbTFqZFBM?=
 =?utf-8?B?aks3SHR5MzdJR1puOStXL1NlbTd1eDRPdDVLNmNwQURlKzc1TVdXVTFNYzU4?=
 =?utf-8?B?YzBwZVN2Mmx5dVFOdXBucW41WnZyTE0xRkFFV0pnQ0l5QlAwL0NDeGxQTWhY?=
 =?utf-8?Q?B2Rg+C6Y63A9g?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmFIWk9kZ1BEMFpKMXE5MEcyZ2l4K3hOTERTNzA3WVZSSXo4QXhmVVZDYnQ4?=
 =?utf-8?B?WnZ3NjB1ejVVRVNyVitVdFp2S09xeFlWNmNuV3pYaGYvZFRYZE45Mi9VMGNK?=
 =?utf-8?B?eElCcVRPejRRdUZ3c1dFNVZrK3N1c1RwRktiM2Z5eFBPMXdmN3RFY1dkRm5r?=
 =?utf-8?B?MXlBMGFoN2FpaTlNNzVVUlV2YVgxdnNIamg1a25oa20wdnBVQ2VHcDZ3YXM2?=
 =?utf-8?B?K01WQStiTVpiQ05rVDl1a2VQWTBvOE5RQXFzd21Sb3pZcnMrdDVRTDlZaVN4?=
 =?utf-8?B?OVlQUjA4TUhkY3NmekZYVllxaGdDdUQ3elVxaUxGWmlwaGFraTJvWkZ6REhs?=
 =?utf-8?B?UndIcm9zY3JwWWpNM1V3cGQvZXdnTmF0OExHOXB0bjNyUXlLR1oxU3hBM0RL?=
 =?utf-8?B?WDk1bGovLytrQlFpcy9pd3ZIQlZjQzJJdUE1ejI3aWE2anM0ckdGR1hHV1Va?=
 =?utf-8?B?Y0FReHoxbmdUckNGczNzZ2tzNllVUlFkeEhZV29jUUM1anBZKy9wa1VhQ0Ju?=
 =?utf-8?B?cGtOSk8rZkhhakdId2s0alphSzFFMm85S2c5K21FY0UrY3lvT1pCY1VqRUdB?=
 =?utf-8?B?aG5jVHI0citpcFM4YjdyelBSemFKUGR0WVhSSTRPWEhJZFJNeERSYisxalho?=
 =?utf-8?B?T2ZmcmRTOTAvbFRaR2xDYlNJU3VoRWhoalFUMElybWxnQnA0b1Y4QVNhS1cz?=
 =?utf-8?B?Zlc3RjNGZ0kzMkI4WFI0dGJ0ZFNxY3EvNGhCcU1ROHBmVXdubHZ2enVIaWtS?=
 =?utf-8?B?OWpoTFlTY203eUtmYWw5YzlYQU1vdEZVN28wYTdxK2ZMOXZOV0REYVRMUU5v?=
 =?utf-8?B?cmJTc2pFdnJjWi8vZ0d2R3lYQnVYZytZcVhXeDFvZEFPQW5HdTJERmZqTkR6?=
 =?utf-8?B?TmwrQTMwSGRCc2Y4bXJBWmRwa2FDWHR2Q2RSbzlVVWZsd3RVZjQ4NkppVS8r?=
 =?utf-8?B?Q1g0Rlp6U0hXLy94VU9DZWFxSGpIam1YTjAveWIvaGNKSU54UU5sOTRXVUVV?=
 =?utf-8?B?ODRBak1JanNaNXdxSyt6RSt3YmNqNS8vaW0vb3JNWGFFZ1ZaUkdGMEtQTUla?=
 =?utf-8?B?M3VPL2Ewa2p5UzVCU25JUVhkdy9RaVpOYzZuYmF0VHhvakRJdVFuM2FQRDgv?=
 =?utf-8?B?YWkzSDIzaXViYWJWZFlUZnJ3SDBXMzhzUmZLMHl4cHcyT25uRER5UWh2VVRR?=
 =?utf-8?B?Vm1YNjFLTUJ0RGdod2pyWjdCZzloVEVRRFY4Qi9xalZmcUJlbXZCM0Q1WkJF?=
 =?utf-8?B?TUthUndwRUYzM0ptcXJsMjVyb3B3VDlCNXdGT3Q5d3lzQUZxUVgyVEdHaTJr?=
 =?utf-8?B?aDM0bEkvYXJNeEh3YVYrT1p3aFhJQkFJSXg5VVpvZzJvaEtha0ZxNVNWOE91?=
 =?utf-8?B?eEd6TnVXRzZWbHg4bjFtYXBEdXJKQmMzaXFpSjdGbnhNVUhoMVkxai9SMFFC?=
 =?utf-8?B?QTY4M0NRclRIUWV0eW95RmFGY1pIMGNZTC9xOHdXZDF1bzNocVNrdlNIOEI3?=
 =?utf-8?B?REdvMG1BRjBXTW52MDdDbzhzbTFBSDhYUUMxYjRrZUpUcnh5ZXNlODc5WjFM?=
 =?utf-8?B?UUxpejZCSnVicUdmV1JyQTRBajFCZ0orRU1HZW41Yk5UNlI3bUY5SnFpaUt3?=
 =?utf-8?B?NWZYekdDb1ZqVzFZSGczSnVOckhPTEMza1R0MCtQSk5hUUpkd2trbVl0L1Z4?=
 =?utf-8?B?OU8zeUFrMTJhOW9pNTBtTCsyM1hWN2ZDemw1RmlOWXFYL1d3WkoyYVBzaERm?=
 =?utf-8?B?ajNpdGdUT2x2NWpldnhFUFlyeHpRQy9pN2p4NE13VHhITERuRU5MS2ZEbU1J?=
 =?utf-8?B?bncxcXRSQUtQRldKVGdVSXhDRzF4WUE5T0pkaW0vUk9lSjRBNEF6REY3NWY1?=
 =?utf-8?B?L3lJcU1DSHVUajdDNWJ6Rkd5cUVWb3BQSlY5WFozbnA3SnJrKzV5Y09Odkx5?=
 =?utf-8?B?TnNDOEpUbDV1UFhsdDhpMUNwWWFHa3NYT0swWXp4RkNXdXJtM3BQZi9kVERZ?=
 =?utf-8?B?RDkyWER3SVd3alRkdmhJTjZyN20zeGcxNVlFMFJwVU9ZTGpsWU9DMGgvR3Jv?=
 =?utf-8?B?a0lxbEdkbU1qWGxkYjRYamtkVU1JWFpTSFlqMHphb3dORFZGdVlmTmRPYlRP?=
 =?utf-8?B?YktTaU0vMlZrVk1qcitQQ3dzNTM0VWMzWjdjUWVnVW5CTm9DRUlXbDVTeDhs?=
 =?utf-8?B?MFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f8b615-c98a-496b-aaee-08dca525f8f8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 23:29:29.0235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MvrLSO4tbKjS6ccaKrDoOUpkI9ykinRoqpSG82qugGhKgpWytZzJy6gM3sk4PuQso/NQ3iLGu1gIpVGcvhAnx33zjwqczkYjA+n6yo9nipk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4978
X-OriginatorOrg: intel.com



On 7/9/2024 6:53 AM, Kory Maincent wrote:
> Make the dev_get_hwtstamp_phylib function accessible in prevision to use
> it from ethtool to read the hwtstamp current configuration.
> 
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> Change in v8:
> - New patch
> 
> Change in v10:
> - Remove export symbol as ethtool can't be built as a module.
> - Move the declaration to net/core/dev.h instead of netdevice.h
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  net/core/dev.h       | 2 ++
>  net/core/dev_ioctl.c | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/dev.h b/net/core/dev.h
> index 5654325c5b71..9d4ceaf9bdc0 100644
> --- a/net/core/dev.h
> +++ b/net/core/dev.h
> @@ -187,5 +187,7 @@ static inline void dev_xmit_recursion_dec(void)
>  int dev_set_hwtstamp_phylib(struct net_device *dev,
>  			    struct kernel_hwtstamp_config *cfg,
>  			    struct netlink_ext_ack *extack);
> +int dev_get_hwtstamp_phylib(struct net_device *dev,
> +			    struct kernel_hwtstamp_config *cfg);
>  
>  #endif
> diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
> index b9719ed3c3fd..b8cf8c55fa2d 100644
> --- a/net/core/dev_ioctl.c
> +++ b/net/core/dev_ioctl.c
> @@ -268,8 +268,8 @@ static int dev_eth_ioctl(struct net_device *dev,
>   * -EOPNOTSUPP for phylib for now, which is still more accurate than letting
>   * the netdev handle the GET request.
>   */
> -static int dev_get_hwtstamp_phylib(struct net_device *dev,
> -				   struct kernel_hwtstamp_config *cfg)
> +int dev_get_hwtstamp_phylib(struct net_device *dev,
> +			    struct kernel_hwtstamp_config *cfg)
>  {
>  	if (phy_has_hwtstamp(dev->phydev))
>  		return phy_hwtstamp_get(dev->phydev, cfg);
> 

