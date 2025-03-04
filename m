Return-Path: <netdev+bounces-171544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA147A4D7B6
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 10:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 469731889862
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 09:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11B81F5404;
	Tue,  4 Mar 2025 09:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JYyUrmK3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D2923B0;
	Tue,  4 Mar 2025 09:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741079722; cv=fail; b=ke9DsSU023n/a8KZXYs3jES/tv/jwfFCS3Zhxk2Jd2HkHTzixqyWyMbbxoEHaz55Em9pTUQd2souHha+b9K4o8hmu2/4YzXOeShTnhMLegZO0kqf2xFPeO7txk7tY2UgqafrHUMvom8gttW/R8VLocipMCz3rDNLZ1Ep+7S64pY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741079722; c=relaxed/simple;
	bh=5o5KBDz+U0+Xl9cVuPX8UpicXOjlpptlDopg6NNBROk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Udfa743rCabRomR56I4nTDnoxRQbYYSPu8M7yVj+m3ZFQcmhhUWjy5iQAiIwjEJdibL4cYdfKK6lLSJjYoH3cFlv28We03Fn5mTAnPU837pRiYpkr3dFfbmXjaCNSYIjNsscHRhsLKMHNVbCqglcARaz6LKGMP8AznpqGQOT73Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JYyUrmK3; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741079721; x=1772615721;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5o5KBDz+U0+Xl9cVuPX8UpicXOjlpptlDopg6NNBROk=;
  b=JYyUrmK3ljkvnZR3DGrKPSDeOxeUJn0r18vjxke/pvh63ujJDzc/TnPF
   I/maQ6bG0SN6L9qPzZ6Dw70cmOBTHd5tC1VKyi4xyBtCnIiNJEBmXAm6J
   JSgTy3okYxYXDnOaE5WR56DmOFbTW4tTD2brSrHLdD+gnG4pVyloH+p+7
   KOTi/NCqBHVp6VBFhevWwRP2oxImyE9IUezPP17P4E6RoXGsu17YLWNxQ
   itfLhbrKzG5DgqwJ1ShCmwvaxkXdtGw37cJ6sdH2vMNECf49tOzZC9Us+
   RuWfNLmQPtOtSZTcr2oytIXxXkJpHQBUXBqA9iL4taIDrN7/lu7T+JbCM
   A==;
X-CSE-ConnectionGUID: d1bI6VXDRdevLpMsPawlxw==
X-CSE-MsgGUID: mxIJMEHfT+qlELTkThNZXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="53382817"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="53382817"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 01:15:17 -0800
X-CSE-ConnectionGUID: Q5YRdMfWTFOda8GseqV9sw==
X-CSE-MsgGUID: ihdIUlWJQ8G+jBcq+cH0Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="149248533"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 01:15:15 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Mar 2025 01:15:14 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 01:15:14 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 01:15:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chl9v0A66IYRMFJApYegTHwbmqKGpOvhMpBBEsrorZuLmXFPG1TW6CxNB06yXLYGIYGGVjJfpslSNZsasxiC7KJeyeckpq3lyUwnt3SAccA2hSY/a2TK16cIKW9ca+QW3Ycas/8p6ybNCZFt9X7H1lNH1ltqedncdO8lyEGXCZ6ZcHDDBX+/zJdAhr23NQY6UbMvjXGDzX/zOTaZ9HDdMAHqjV0goI8yHX5/6JImLFmIViySCdxdcsAmEhjChHPg/tZBhw4dZx6dYh0mj/CdaG8i3cJ32o35KzZtks/rgB9ZYSnidr06QqiUV+vfOtcuQd225MuqKV1A1WnFdwnciQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5o5KBDz+U0+Xl9cVuPX8UpicXOjlpptlDopg6NNBROk=;
 b=JmCQw0mC6Gbt/XEcxtcBHUvvOyzSklrx7MHNpdk2e7bHFN2RS0k6JhQPyN9wXCVRLPHzKaOQ+vfyfSp5DefyfHb/H8OsdZkED0gS7qOCFJwCZDHs7nZw4Z2X9FlRhFbHRmAgJnHaw6k9g65IbPnTvQiBqOaleqoU9qqUI6wElrM/2GzTVqu/A/sfiAViD19fcsciMthfF1NQNKV44/q7OXbcpKkWebNvSDABDrJOTTDb91UvfBKyJvR9OUPn3KTcyLL6NVWtaR0Cbet5NWTuh4zGj6BEkznhOoWd9t1+DPaj6DzZ9ppbkxAy9v7/kCQekxO6hGuNH99ywndu4IrcpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by CH3PR11MB8751.namprd11.prod.outlook.com (2603:10b6:610:1c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Tue, 4 Mar
 2025 09:15:12 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 09:15:12 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, joaomboni
	<joaoboni017@gmail.com>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH v2] e1000: The 'const' qualifier has
 been added where applicable to enhance code safety and prevent unintended
 modifications.
Thread-Topic: [Intel-wired-lan] [PATCH v2] e1000: The 'const' qualifier has
 been added where applicable to enhance code safety and prevent unintended
 modifications.
Thread-Index: AQHbjH2rW6Xv8BP5E0WE7U+tqIVqQbNipZaAgAAM85A=
Date: Tue, 4 Mar 2025 09:15:12 +0000
Message-ID: <SJ0PR11MB5866D85D97DD51AAA1E79E20E5C82@SJ0PR11MB5866.namprd11.prod.outlook.com>
References: <20250303204751.145171-1-joaoboni017@gmail.com>
 <a17f8193-10cc-4e23-b2d1-125a336c9ce0@intel.com>
In-Reply-To: <a17f8193-10cc-4e23-b2d1-125a336c9ce0@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5866:EE_|CH3PR11MB8751:EE_
x-ms-office365-filtering-correlation-id: a2e1b2bd-1054-4e4f-4cb4-08dd5afd116e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ckRNWGxCMlFET1B3clBNOTZWaXBjQWplM24ySEFlbURMYXpzWVBFUlRYbE5n?=
 =?utf-8?B?TjZHUWYrKzhDOXdmSngxbjQxemNDelc5Z0p3NnBMbnUrNURlRVl2bnFBc0do?=
 =?utf-8?B?ZHZVeHZiWDV4WnhuZVlJWU5RV3NoUkE3eTFEamNUWFJuVHFiUDBDbnhFSEhR?=
 =?utf-8?B?NGhlUS8rY2wyL0ZGUkl4UXloa2ZxZUZReFhPYzUwemczSmNOSWVlL0Z0d3Vi?=
 =?utf-8?B?RWhGUXpkVVA2dlFjYmgyUHdiZmN0ZXpuckR1amtOQk9hN3dJMzZDVThsWUxo?=
 =?utf-8?B?dzE4Y01aRGJGeDhlc3JqQTd1L1VUaDFZMGVkUXl6ZUREbTRsVmpIUGFWYzd5?=
 =?utf-8?B?YllxRjRBbXhCckJCa1NMUjczRmRnYXU0STBhdUtGU0IyMFArdnF6cGkxVExk?=
 =?utf-8?B?V0NqVUt1VzdwbXZXc2RvOExIT3VhcGxtODdwTnYyemlxZVA1NjFwcjRVeWtC?=
 =?utf-8?B?b1RnVTdJbjlaUkN0a1IyVkhtVG5vQ2VzWUZUWGRFOGdFeUtkRDhoWmxsNFBu?=
 =?utf-8?B?WkNjaUZpMDA1QmtmczJRYkVRWmhlOFJxRFU0VlZIMFlSbXRkYjdCcWRnZXE0?=
 =?utf-8?B?R1dhdU9BdW9GSmQyeHJZVnoyY05qMEtVS0d4Y002M1lTT1lsMEpKbDdqdHUw?=
 =?utf-8?B?dkp0L2lCU0xaRy90Yk5JRHQ2OHZFMHF4VWlJVHNlYkhQQXFVdUIvQ0ZIeTJs?=
 =?utf-8?B?TTdHOGV2TlI3MFA0aEh4dUtKVVAwNlhDUXZLWGJLRks0UCtrWThzMTRHUFpl?=
 =?utf-8?B?Ymx3TGhSVzM0OVZ1MUViRGc2M3RvYWI4ZmFlZmQ1d1RZdjZrWnBicm5LZzRu?=
 =?utf-8?B?YzZmOHRQdW85d1ZsYzNlWFhHSC9PR0pYc1F2U3dyVDBnWTBKWTdQQTFFT01u?=
 =?utf-8?B?NFpwQ25KRHN0STJpL083OW5BeW9MeFhOV3pUdUo4UHBLd0RIaWNoazMzMGZx?=
 =?utf-8?B?QjlaSlZDU3M4T1NDU2YzSjR1N1l5T2JRSlNERUpvaFZzWGJJZmFxRGp5ZVhh?=
 =?utf-8?B?UGVWZ3BwSENMQzFOZ3k0TVJ5VGtuZk8rVHZnV05ycm9mdlhra1V2RVk1UTBZ?=
 =?utf-8?B?Y25SaDJURm1PWXJZQUdjTnI2YXArQmhhZ2tmUHJlMmdralpIU0lVZ1Zmcmdj?=
 =?utf-8?B?dDFyNjhiSGU4aDlnSmV4UUJhbEo1RFhRZWdVOGkzRHA4MXdHdXh2RGFtRXJi?=
 =?utf-8?B?NnM3Wlc4d0wwN0ZkZit4UklPUXlYQ2RDYThvK0l1cFlmMDZFczJZNkVaNWNI?=
 =?utf-8?B?dWQ4QjcwcXNJMW5teGJZNTVteHZUd1RMcFI0YVpqaHNBaTdPMWoreVIrL08z?=
 =?utf-8?B?QU9YOFdXd3p4Z1prT2lNRzY1Q1pXaW9uMm0zUmhBUWVXUEh2czhjdDRYbWVX?=
 =?utf-8?B?bDRwOW8xK1cyQzE4TEcxWDJiT2srRE5jNHdUUEVJM2V6ci93UStVaGlsWDVy?=
 =?utf-8?B?SkFobWNFZDZTc1piWjQvc0x5WjZGVUVCVm04UDltMEUvem1Ib25BOTFKWi92?=
 =?utf-8?B?eVBVeElBbk02L3NJb2Uvdlp1Uk5GRno3SEkwUHgycmhvaGFiendEY2FUaXp6?=
 =?utf-8?B?b1oybEtUY3ZPVEVIYUpYUlZoQXJKemV2cTRIZ0VOZVQzS3Y0K3B0ZTJacm9J?=
 =?utf-8?B?VXdsWmhra3RrcVBidFFaRHZSU3AzZXQxSlhnUTBrYk1UL3pJNkJwdnR2NWEx?=
 =?utf-8?B?VUFOVmFKL1VpV0xacktlNHBacWNkQm1IdTdlanY2TkloUzREL3F4Q3A3ckFp?=
 =?utf-8?B?a3dTaS9tSGpWdDJJZjEvcDM4aGxkQ1pBYTJWRmFZRmk1QTZqQXRKT0lrVlds?=
 =?utf-8?B?a3d4enZsNDNGaUFZSlBKbmN4WkJMQ3JidTF5VGNyWWIzQlEvbWRpcWlncjd1?=
 =?utf-8?B?Vlh0ajg0M0M0WU9LMkF4VGVYeFFCUXllME1CYncxWGx6VGpIeUFERmhwTXdh?=
 =?utf-8?Q?+n6jRKPPyCBScYFNOcBn5xXb59Y65Os9?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFUrZmNydFpKUU9FZWo2OXk0NkdRM1k4ZTdXR21UaUMwdnJBNHNudm9yWlph?=
 =?utf-8?B?UXA4SU1FTHFUSFlIaHIxMTdNbU1wQlZRZGQ4NUluSk1SSllRZ0lVSXc1eWJI?=
 =?utf-8?B?bFZyWUtYd3hpNlBlYnJ1VXRFR1RyM1AzZzIrcUJZNXVQT2E0ZjJDYTVhUEJz?=
 =?utf-8?B?YjBTKytMS2hlMmJ3V254dzlqWVd6UXRyak1mN2phbzN3WWJ4VzBxOE00U25N?=
 =?utf-8?B?M3RMT3hXRzJ6d2xFbDlpRzIxdDY0ZmhzRlY0U0JaSmd1amxRRXBNQmxLcG5M?=
 =?utf-8?B?L29nMWhQRFNpRitDZUFpSlExNVUyUFlmY2VHQUVuaGdhM295MFNGTE53YkQ0?=
 =?utf-8?B?cUV4bG9MYXd6UGgzTFc0eTlMOTFGdkRFMVNOa1VacnhNK1hMRDREK014UGY3?=
 =?utf-8?B?SGtDQXUxbitGMWJSRzBRc3BCU1ZPN1FPZm5XK1U1R1k4M3JPMXBOM1p6ZDFE?=
 =?utf-8?B?TlBGMXpZanJSc0ZMd05RRmpLdlhTT1lmcUc0QzMwc1ZyK2lpSWF4cG4vQzJY?=
 =?utf-8?B?YmovdnFRaExrWkVERHF6bExjSGFBZzZMaEUwWW5tdlBqL2xkSlNZangvQ2Rn?=
 =?utf-8?B?SFh5RjlXL3k1Y1JZMXRocG9Hb0R6R1BocXdEM0hpY2s3VGt5VHZLWUFWdlpF?=
 =?utf-8?B?N2RTQjRxZ0lrdEVHOHNGczV0cXpQd0xjQXdhMEtnTTZ6Z1RTNjZsdlorRFFq?=
 =?utf-8?B?SG9UOFhLQjdaTk5ha1gvYlgyd3JzSVg3bHpud1ZaUTByUDg2elFkR3l5bG5N?=
 =?utf-8?B?dW5aMG5KMmswejdjS21UWVpCOHFYbzJnbEcvSUtNakRyZ1ZYRTJaR0FoL0Ex?=
 =?utf-8?B?SFBKRERRdU9TdU9JN3d3Rkc4ZzFFc3NiRXIrNm9XMXcwRWlMaW9BSUQwa3dp?=
 =?utf-8?B?UGxuQUpNOC8yWkRkaTJHT1pBaVZrdXNHdlNYMUhrVTdoZUJBVFRXT0EwU0pn?=
 =?utf-8?B?VzZQME9vOFhQWVlZcXptVU5kWTlEUnB1TDJnbHR2TWV2WmJhNUFQaGo0cVpJ?=
 =?utf-8?B?WG0xMWF1Q1hGQUg3eEFoMTM3aEptTXY0ZVQyellZS1JrNUpzL3dQNVdXSWh4?=
 =?utf-8?B?L090bGZZbHlHVmtIRE8xZEdSMjRSSkNQUWFsbnovNklVRkpsanNEUzRlQVA3?=
 =?utf-8?B?RkRCWGUrME9iVUF6RlYxMVhqSmlueHpPS04zWUpLa3hBa2YySE8rTVVZMDE4?=
 =?utf-8?B?Rm9Ua1Q4MEdBdWdhL3pvNVFURWVOMENWeVNTeCtPZ1MyUk02a05xa3FvbEZF?=
 =?utf-8?B?K1VSS2ZGK2Z2QWwybVExWkx5eWx1TW5HRlVhZUFiWHp2MjFQMFk0Vmcyb0VV?=
 =?utf-8?B?ZTlpQU56ajF0eWtqd3VoK1htT2hjS1BMd0U5bUYwREVFYlRNSWpnZVBsaHdr?=
 =?utf-8?B?aGdvSmYzQTYweTZLT2U0VjVkcXZKOVljR0RENTBaaURIaDB2OGUvOGcwYWgr?=
 =?utf-8?B?RDJLL2RXME1JaCtsQkMwSUhVbkVpeEhEVXN2eEhmZ0d0S2tSL3JKTCszaXpV?=
 =?utf-8?B?Q0hTQUZyUmVFQUU3bkdXemRwLzlqN0p1c2VCN2FVdVFhcnZPSmdCUTBnTVdG?=
 =?utf-8?B?SkhjckREMmo4N2lnMGVFNGdSVXFwRkZiK2pkWmdPcmhadktrQ1lxa045blg0?=
 =?utf-8?B?YUcySW9kYXpUL1duM1V0Uko0U2ZDbDZaRm5yUEFhQkRLM05BeHlIbVVJb1M4?=
 =?utf-8?B?T2s2Z3I5UFdmMkwyWGZVZTIyeUI5d1N5Skw1a1MwbXNIMVJxcmFMZThkNzAx?=
 =?utf-8?B?R1NRSHV2YkZOVW5DYTYrcytia0Fqc2FoVXBuVnlWWVZtZGppMWcyNTVtd3Aw?=
 =?utf-8?B?Z1YxcjFsbkpoOFJSVzVFU01Jdkpqbmord0NUSEF2YzB0a0M5cjZ0Q1VzeHNr?=
 =?utf-8?B?cGY4d1VsQU90RWdwcFNUdTdtU25DUkxBNlZhSWFNaUQyRjdFSW1RZzZleXpw?=
 =?utf-8?B?MWVTYWxUcnZObHlhU2Q0b1YweTU1V3QyOVZrZFVIaUdoREpiWTRJVVdqK3Bm?=
 =?utf-8?B?UHZMOHAzU3NHUkFDQXdCSmwvWVJtbEVOdEU1MnQyVDdOVEpBdlZiRE9sNzE5?=
 =?utf-8?B?WGQrenFhTWQrN0NEVFR6ZWhxT2YwWXpiQ3huQmFBaTFQc2tXM1U2V2s0L3Zx?=
 =?utf-8?B?dGpncHlaTFp5Ky8yUkEvSUxsWEVYbmxwMlcvS2dGVDlXYmhsRFJPL2FPd3pH?=
 =?utf-8?B?SWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e1b2bd-1054-4e4f-4cb4-08dd5afd116e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 09:15:12.1939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zCSuJBhSHNhX45rs4zcnr3Bw/8ewlcJNHgOlH7CS7LHLWYJNKsUJRgyXlQtltcIucYm1Q2dr8lKsDvzldxytaTpq/WmZdh4ACxrN16kz+5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8751
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYgT2YNCj4gUHJ6
ZW1layBLaXRzemVsDQo+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDQsIDIwMjUgOToyOCBBTQ0KPiBU
bzogam9hb21ib25pIDxqb2FvYm9uaTAxN0BnbWFpbC5jb20+DQo+IENjOiBOZ3V5ZW4sIEFudGhv
bnkgTCA8YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+Ow0KPiBhbmRyZXcrbmV0ZGV2QGx1bm4u
Y2g7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5jb207DQo+IGt1YmFAa2Vy
bmVsLm9yZzsgcGFiZW5pQHJlZGhhdC5jb207IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wu
b3JnOw0KPiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnDQo+IFN1YmplY3Q6IFJlOiBbSW50ZWwtd2lyZWQtbGFuXSBbUEFUQ0ggdjJdIGUxMDAwOiBU
aGUgJ2NvbnN0JyBxdWFsaWZpZXIgaGFzIGJlZW4NCj4gYWRkZWQgd2hlcmUgYXBwbGljYWJsZSB0
byBlbmhhbmNlIGNvZGUgc2FmZXR5IGFuZCBwcmV2ZW50IHVuaW50ZW5kZWQNCj4gbW9kaWZpY2F0
aW9ucy4NCj4gDQo+IE9uIDMvMy8yNSAyMTo0Nywgam9hb21ib25pIHdyb3RlOg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEpvYW8gQm9uaWZhY2lvIDxqb2FvYm9uaTAxN0BnbWFpbC5jb20+DQo+IA0KPiBp
dCB3aWxsIGJlIGdvb2QgdG8gdXNlIGltcGVyYXRpdmUgbW9vZCBpbiB0aGUgU3ViamVjdCwgYW5k
IGFkZCBvbmUgbW9yZQ0KPiBwYXJhZ3JhcGgsIGxpa2U6DQo+IA0KPiBTdWJqZWN0OiBlMTAwMDog
bWFyayBnbG9iYWwgdmFyaWFibGVzIGNvbnN0IHdoZXJlIHBvc3NpYmxlDQo+IA0KSSdkIHN1Z2dl
c3QgJ2ZpeCcgDQplMTAwMDogZml4IGdsb2JhbCB2YXJpYWJsZXMgY29uc3Qgd2hlcmUgcG9zc2li
bGUNCkJ1dCBhbnl3YXkgdGhlIGNoYW5nZSBpcyB1c2VmdWwgYW5kIHNvIHNtYWxsIGFuZCB3ZWxs
LXVuZGVyc3RhbmRhYmxlLg0KDQo+IE5leHQgcGFyYWdyYXBoOg0KPiBNYXJrIGdsb2JhbCB2YXJp
YWJsZXMgY29uc3QsIHNvIHVuaW50ZW5kZWQgbW9kaWZpY2F0aW9uIHdvdWxkIG5vdCBiZQ0KPiBw
b3NzaWJsZS4NCj4gDQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9l
MTAwMC9lMTAwMF9tYWluLmMgfCAyICstDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9l
dGhlcm5ldC9pbnRlbC9lMTAwMC9lMTAwMF9tYWluLmMNCj4gPiBiL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L2ludGVsL2UxMDAwL2UxMDAwX21haW4uYw0KPiA+IGluZGV4IDNmMDg5YzNkNDdiMi4uOTZi
Yzg1ZjA5YWFmIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2Ux
MDAwL2UxMDAwX21haW4uYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2Ux
MDAwL2UxMDAwX21haW4uYw0KPiA+IEBAIC05LDcgKzksNyBAQA0KPiA+ICAgI2luY2x1ZGUgPGxp
bnV4L2lmX3ZsYW4uaD4NCj4gPg0KPiA+ICAgY2hhciBlMTAwMF9kcml2ZXJfbmFtZVtdID0gImUx
MDAwIjsNCj4gDQo+IHlvdXIgY29tbWl0IG1lc3NhZ2Ugc3VnZ2VzdHMgdGhhdCB5b3UgYWRkIGNv
bnN0ICJldmVyeXdoZXJlIiwgYnV0IGl0IHNlZW1zDQo+IHRoYXQgdGhlcmUgYXJlIG90aGVyIGNh
bmRpZGF0ZXMsIGxpa2UgdGhlIG9uZSBhYm92ZQ0KPiANCj4gUFMuIFlvdSBoYXZlIHRvIHdhaXQg
MjRoIGJlZm9yZSBwb3N0aW5nIG5leHQgcmV2aXNpb24uDQo+IA0KPiA+IC1zdGF0aWMgY2hhciBl
MTAwMF9kcml2ZXJfc3RyaW5nW10gPSAiSW50ZWwoUikgUFJPLzEwMDAgTmV0d29yaw0KPiA+IERy
aXZlciI7DQo+ID4gK3N0YXRpYyBjb25zdCBjaGFyIGUxMDAwX2RyaXZlcl9zdHJpbmdbXSA9ICJJ
bnRlbChSKSBQUk8vMTAwMCBOZXR3b3JrDQo+ID4gK0RyaXZlciI7DQo+ID4gICBzdGF0aWMgY29u
c3QgY2hhciBlMTAwMF9jb3B5cmlnaHRbXSA9ICJDb3B5cmlnaHQgKGMpIDE5OTktMjAwNiBJbnRl
bA0KPiA+IENvcnBvcmF0aW9uLiI7DQo+ID4NCj4gPiAgIC8qIGUxMDAwX3BjaV90YmwgLSBQQ0kg
RGV2aWNlIElEIFRhYmxlDQoNCg==

