Return-Path: <netdev+bounces-100955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5838FCA5C
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 13:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27B941F210C1
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 11:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91179192B93;
	Wed,  5 Jun 2024 11:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LpjgwSbT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909238F6A;
	Wed,  5 Jun 2024 11:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717586704; cv=fail; b=Wz7/FQ0ubNB4Q12+s+fdRnOqVci8ePZ//SUW8r5SwGFnzeALmwqq0YfacDPiYhVXnctUN8q1LM/6zRWG57xxIZNzfSHOFB+HtTXainYs10HJpi23qa4ZlcqYyG1fMc8nwnlJc2kKfj7A3BjH9AzYJfBIr3FrPbI+XcftC3Xm0T4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717586704; c=relaxed/simple;
	bh=g6v2zjLqGR4fD0G/pae1KtEXHz8Rgd8h6sN+eRUkZzc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Kdz89+6701iJ6ZHNvGKuvQvQgnKnupabCeIbXXz8zGJUiFna09fgoEeNCv9zRn5BifrVd8BLiUQfOFRL2kZAF0KgMNYe/6tIGPch+raZ1tFFUQ/rdNcnzdawc2kQUR87GnhYuZ5to4GxkEjCQ35l8kJyziAAKcjHKpFUDCaPtSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LpjgwSbT; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717586702; x=1749122702;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g6v2zjLqGR4fD0G/pae1KtEXHz8Rgd8h6sN+eRUkZzc=;
  b=LpjgwSbT3bUyjDlEQrKWPQTcHUnQ3LpFI+LOJMhjGsoF9TIMNJV0n+uj
   rlnJWHgFqIRmPT4g0hGFlNyeytAqGUEfTY1jupUtitq3TAmGHH1gj3K0j
   pJ8u5NxmVoFSDAMZXAwNs6mMJXV6Bg0/EjaIfFPzYgIkdZiYhMl76j4IS
   gvMZWarJcGTRczbjvpS6racEFRkhG9IqOOlvUcip+iWvfoy+/NjrewCNq
   09xvGPrzIGJt5S7h91+jAs5qejzA/tcs0LlPuyAFlXQmxo17yC9/KXOT/
   TLP08AVsj+6Xy1ypgqRGQXpTXDAzxI1LmLqs44ZJHx3LgBmPKk/7tt8ah
   w==;
X-CSE-ConnectionGUID: /tGX1Qp4T9e/ycUcsGBuOg==
X-CSE-MsgGUID: O2OG9q+QTTWZSSnWb3sE7g==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="13992933"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="13992933"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 04:25:01 -0700
X-CSE-ConnectionGUID: R3+AsGsXRRGy+KUaRjabLw==
X-CSE-MsgGUID: TKl7FYJtRVq8/+m3tDevbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="42673902"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jun 2024 04:25:02 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 04:25:00 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 04:25:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Jun 2024 04:25:00 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 04:25:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0OMp/xcnSntpmbzdMW1RNt/KMYIMJ5sFnzLFAxlpnXHRJ2ZnNvv/x5gDIOS7KaTixRiRs5B6meE/0xIyrM79bbQjbngZz6kcvAipKOGDlP5STuBTFcfCUwZSggdBdJYKax4fg+xvRltCpP+sZGL1ny0QZrDjIctLQ1L09FS13asW720OHkk1qq4VM2Rr78EsKYXVThmR4FbNrgr6yyS39t/wIOwoE/+Nw+JhiaOC09oOaz23vRPvE5E9cHyJv+zRmRPpFKXt1Q19roc6o2bq2jzKL7DPcxO8oz1Hk35p+YmyqYRR/2OKTCxcUAGiKUhNfWN69Uj7Ii3If7w5Nzs/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3M2/GDCANGr5VaaUKgl+A+MltUJrSWsQ2Oc8h1M4s1M=;
 b=Wrv9Hv1oA14IuzakhvGODgsnBBrqVR2FsHEd/Urhr17w0W7sa8UFigMQFCcwR4dEzBXh8hY8cTs6y0EHtt5/EBMut6BSKsvY4xtbCsY0cgH4X41pxHo0TkCFA3Asdkinj0tGEx9ZtIkpdmJ4KSkRMF1nsZnQ6O42gDN1s9k0kKuMyfLO+J5dUnYf2Mk0HV0OBrW+tNjjl99DHjfu/eBCLsZakvC2McCNdXXZvTOglfvTfAP9E7eY0KMEZAzRODhCxjaYGi+7/tZzm93mlItcbjeQT9knTqXbXA2CuCHHkkVTSL2hJHg07LzQgSqlPFMSqAyJUGMIjmnVONRXL9MiHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by SJ2PR11MB7714.namprd11.prod.outlook.com (2603:10b6:a03:4fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 11:24:58 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%5]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 11:24:58 +0000
Message-ID: <05146417-c29b-41f4-89ac-bc9e1af2cee7@intel.com>
Date: Wed, 5 Jun 2024 13:24:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V3 3/3] net: phy: mxl-gpy: Remove interrupt mask
 clearing from config_init
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<bryan.whitehead@microchip.com>, <andrew@lunn.ch>, <linux@armlinux.org.uk>,
	<sbauer@blackbox.su>, <hmehrtens@maxlinear.com>, <lxu@maxlinear.com>,
	<hkallweit1@gmail.com>, <edumazet@google.com>, <pabeni@redhat.com>,
	<UNGLinuxDriver@microchip.com>
References: <20240605101611.18791-1-Raju.Lakkaraju@microchip.com>
 <20240605101611.18791-4-Raju.Lakkaraju@microchip.com>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240605101611.18791-4-Raju.Lakkaraju@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::13) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|SJ2PR11MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: ba0764ee-004d-4ae4-33ae-08dc855221df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEZseGFoWFFMZzc2d1l3REhDeWVQS3BrVGNpODBjYVhHQ3pjWUR3UlliY2ZU?=
 =?utf-8?B?WWJHSWt1d0FOYU5mVHB4OXphdENmeHNPL3ZkL25tUUdkSHNwNW93QXpzUWYx?=
 =?utf-8?B?OUhiaitPY1RUMkkwcllhbUpDMDNLOUJoT1RxUWVLZTRJU2J2OXBndVVyaFVv?=
 =?utf-8?B?SFlIL3RqMXM5cW5GakpqRmlOMlR6a1VUZEJmYldjMTkrQjRTYU1lMk9nQzda?=
 =?utf-8?B?Rm9VSjloczhNZkxSSjJ2WndBSkpENTFqUmV6amltY29mcGJSUWxNQmNDbWFL?=
 =?utf-8?B?dWdJbDhtV0RNSjhqUC93RzBaSnlWalFwNTB0WXkyN1dncmZUYjBlTEF6Q0U5?=
 =?utf-8?B?SFhhZHZsUS9WenRLT3JJTEtENzYzczIreVJCdDNrNm9QOFhJY3VTb0NycUZE?=
 =?utf-8?B?azRyTlh3d0d0MDQ1MEhWYytxbWNtSzUvTjZBRCtFcXU5Yy9RKytXL3cwd0xE?=
 =?utf-8?B?SnY5ejc1dkhJTkpTZXgvY0xyWGQ2UTA3S3pNaHBGK0tWV0wxQWVlak5ZaEdj?=
 =?utf-8?B?QnRnMGRVUUN2VlkycXBpK1ZzSGZkTUhpODRaVFZsYWJLWThJcldHL0crWUx1?=
 =?utf-8?B?blBwZXNudHpOYXNoTW5GUnhLS3oxazRvV21Rc2tOSW1XbGpmR3pKR0pKaEpv?=
 =?utf-8?B?M0M4V3dTeUZoV1N0QWYwNXo1ejZibHNGL20wS0dKaXhzU3ZDNkhJT1J2bnFh?=
 =?utf-8?B?UVBxY3RqNG9MYzZmN1VQSjFQWTRoZ3NLWUNKb0V1eXFOd2tCVHlEaGZqZVRr?=
 =?utf-8?B?RHpuNXdkUUMvZStxTEIzcnVERU4zQzhqakp6S2hSanBqLy9OSk16d3RueDdJ?=
 =?utf-8?B?eFZ6aTZkRXFLZ21DUlh5MmVmcS8vZThRWHFiblZQa1liVzM3V2x0TTRodE5r?=
 =?utf-8?B?dVV1MW8zTUo0WEtTdFBOMXNQajd0OSttQXVQQmkvMHowTnRVYWpjN2NrNnRi?=
 =?utf-8?B?aTdZMkJmN2x3b3lUejBMNlhGdDhGZUVjTVNYOW1YMnpLbDA1cU9pbXpzN3hK?=
 =?utf-8?B?OWFFZFdQMERaUm16TzZSem5qOVdUMXZKcmRWT3l0WlQyMHZ0MjdPcXpQNlI0?=
 =?utf-8?B?ajIrTFZPUUllRmxqWW1MemZHODNQOTNxZlczenVTUDZlaHBPU0Mrck5XZHJH?=
 =?utf-8?B?VFVSRkFCRlZvVXdhQllpdjVDci9UWEdHZ3VhQVpoL25qQ1BMd09ER1diM3dY?=
 =?utf-8?B?a3luRklnRjBKYXRaM3RpMndyVnhEN2FvOFJ1dXVmVnJtbktLMUFCblhxVGcx?=
 =?utf-8?B?bkM0UXpwekdHRkNydm1VV21HVDM2SUtaU21sbW0zM0pySHZ2RG1TeHRSZWF2?=
 =?utf-8?B?aDZxcjJpSGFQZTVjZzFjZEQ0YVZEcktDc0M1UWkxUTVDenNPMHR1c1g1UUgx?=
 =?utf-8?B?cHJEYVNadDArV2VXd3E1Ylp3U2FiOW83c04zZ2N0T0NCV0dWWlVRc3JSeDVt?=
 =?utf-8?B?L1J0bHR2NFU0NjVmQUt0Y280ZlJNdHF3dStsOW84aGpyaEVBMmpyR3k3VEY1?=
 =?utf-8?B?Q1VxSlJFNkRaTTI0UWNQNnp5ZlBkdFFOUURIU3FLcWltbnZERlY3RjA1dDhu?=
 =?utf-8?B?Nk13QlV2ek1Vd1Nhb3FIK2s1VEVXdTJwRFpheGZucEdEc1VFbjg0ZTBoRk8y?=
 =?utf-8?B?amxUdS9CSG5GMkdBNGFxOGdhcFVsd25RSUttSS9yWEFsWUJhOWNqbXRsd2c2?=
 =?utf-8?B?eXRiNU5qMlI2VW9vcWo2YmF4bkZzYmVZcnYwbklJcnp5a2tLRlM4ZjlFdlZt?=
 =?utf-8?Q?ukN40+QTWutOX0tss484fj9DRj7GbXn542HRV1E?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zi9lVGdYamRtaUN4cEJuWWVIdFM5VWgvaGpnaXp6ZjA1eThwRDAvMnBBRVVM?=
 =?utf-8?B?Sm5WdnRQeFRtdDE1elpHUDZCc21jbVNMdHIzbFdIOTVST3M4N3lYcFFVM0Rs?=
 =?utf-8?B?WXhYN1NYOU0vZk03N281eCtXN0NMSTAxUnpZZVJJUXZ4NW8wRWovclpXaVVq?=
 =?utf-8?B?MmFOZUtxZU5zM0p2bVdCaVl5UDY0SjZJWGVtQmwrWHYrUmkrR0ppYzZHMG9G?=
 =?utf-8?B?NStGM1NWbm1Eb3c3QmRRREFTdU5RbWs3WnFoekpYYkdBelF5b1ErVnJIcEZs?=
 =?utf-8?B?a0pwblJ0Zi9OY3pkODhUM2hrSkRjQncrdFR1Rzh4bXpxZExXRFBwemFoQmZt?=
 =?utf-8?B?UDR0QnZiVEFLRWliNDVyTHhZS1BteFJ5Y2hQY2xFSzVDL1A5L0dRUWtjdVE0?=
 =?utf-8?B?N1lUWUphWENUN1R2Q0VnYW9WeTNnQWJWbk1TaFhPbVQwRGJDVnRkZlBXSmhX?=
 =?utf-8?B?WHlYVStxcHpQTHRvWm15S1lvbGpnMkZCc0FjSlNxNEdtK3ZvcTdxOUxXOGNj?=
 =?utf-8?B?UWlueHNENWNEZkJtQnArcDc0WFhpMjNuTEwvUXgyQ2MwSlZsTThSeTJFOUtr?=
 =?utf-8?B?T0wzSHMza3g0Z2ZDa0UzeUtVVmlnditmVzlQZzQ2UmhXQ1BCTUYwTGRUalU5?=
 =?utf-8?B?VkVwUEdyMGJsM1JSMHdxT05JMDZnSFI3Qk10N1NOaDFBeHFQczdHRnExL2dP?=
 =?utf-8?B?RXduWFBpRXNWaFNFU201MXVzSlN2TDNRMzMrRVZzZGtwdDVRUjNGZS9mbUNY?=
 =?utf-8?B?TkJUeDVMb1pxelRhWEtPSXdVVy9NWitSVURsRWxxdlJuK1pVcmNVb1NpOTZC?=
 =?utf-8?B?MFlwNSt2ekZkcWVTb1grSTZrZ0ZHQVZSdFRUNGQ5QmVhNkt4dUsxaGlVd05W?=
 =?utf-8?B?Rk1rUXd5TDBCekpxYVRpVWFFbFZRUU00SGtQcHhtbThKOEFPYWFqakhoa3ZI?=
 =?utf-8?B?bi9TWmxUT3ZCZTllWDhHdGxZeUdVK2dqMlJNME1vVVRGM2xUNnV6N2lFSlIw?=
 =?utf-8?B?dXlOaWNDWTR1UHgrUVpLOHdJOFJsYTZyN2tjTUxzWWF5U0oyUjg1NVp1d1lw?=
 =?utf-8?B?TTBzdXhycWFSRE4yZDh5TFlUeUNHTVZJR05wbGtnZ2lrSjFqRkZKYml2YitC?=
 =?utf-8?B?UmJsSTlBRUVLSXpLK1JVSnJCakFIR0k1S3dWSXkySWtMeHFJcHV3Rk1IdVVp?=
 =?utf-8?B?aTJxSkkyNGhyblYveEtvdXUvVEQyak92aDUvckh6RnZoK2NFd1dxTDFsQjFi?=
 =?utf-8?B?alk5RFpkeCtqOU1VTllSN1hYT2JBR1RhMmZoY05CWXRGME9MMktVNW9Ndjd2?=
 =?utf-8?B?aVVUVnBNL1FocWFYMG5NWXc1NFZRYUdxdWtkdU9EanpIN3E0aXBuWW5kSmZO?=
 =?utf-8?B?ZmhKMklZSk9RWVZlRDQvNnBQTmNTRW8zQnNuM05YeHhHR0JOeVFFN1hibCs1?=
 =?utf-8?B?NlNhdWc2ejUyeksyVTBXUmd1R3E1eWhlQ0p5UUk1THZhWDdOUkZlMWxsZlQv?=
 =?utf-8?B?NGZqNy9BVDM4QmVSZGZWbExydktBZmxtczJxTy9kMjIvNmVvc1ArUHgxMVhy?=
 =?utf-8?B?NDJSQTdZcXJCMEkzTnU5L1QralVXb0hvQTlRM3dnWFhaYm1UdUdpeHJkc0Zq?=
 =?utf-8?B?dlNJOXNvNGl6cjc5b2JaZDBLMDA2VEs4OVNnVXErUXl4ci9rQVhwMTJ1S25K?=
 =?utf-8?B?bVlHWjJDdkNKRXVqMnB2RGdYd0hTTEtGSjVXbGNDY21MUkNXVGlSa0xlbXIy?=
 =?utf-8?B?ZWcwN3ZSVmI0MkpRL1J1dndvMHdsZVBrNGpmUFAvbng1MzVpK3FzYldRWEVM?=
 =?utf-8?B?Yy90ZmI2VjB6OTNnSG1YQld6KzVvU05CZXl5OFhkNmdBNDlITjZNUkRrTFlQ?=
 =?utf-8?B?dmR4UjJKWHRyc3hyNitqbUp0Z1VuOUdhSGhLL2xDMU5XczhDSzlGVlhvK3d0?=
 =?utf-8?B?YS9qemVyZlBzSmFqUndXNTk3UHdrV2dlUTJ2TXgwUmdFcHovYnVwbUNNOVVB?=
 =?utf-8?B?b1NQbkpBaVR5Q01HQmZwbDd1RStUeWExbDJ6OTVLR1VEcjg4Umt1NzN6eEVD?=
 =?utf-8?B?Vk41ZUNlUCtoa016cXUzYklmbUNvWTA3andGOUw0UENudWZwRGhhM1J0WFJG?=
 =?utf-8?B?S1JGM0lYL3IvN1A0bEE3U3VYSjRnSzF0Szd6Ylh0NlhYcDVQREFUd3FxWVU3?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0764ee-004d-4ae4-33ae-08dc855221df
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 11:24:58.4134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KPxbUAsNp+0jO/P2Mk37qo51mjwY7JkzMtvxL8Mi5dA9EvQzqi4piJCrOKoWaAYZZh5oIt/eRT5RbZam8+bnYh1W8/BWADv59XhhzOOTszg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7714
X-OriginatorOrg: intel.com



On 05.06.2024 12:16, Raju Lakkaraju wrote:
> When the system resumes from sleep, the phy_init_hw() function invokes
> config_init(), which clears all interrupt masks and causes wake events to be
> lost in subsequent wake sequences. Remove interrupt mask clearing from
> config_init() and preserve relevant masks in config_intr()
> 
> Fixes: 7d901a1e878a ("net: phy: add Maxlinear GPY115/21x/24x driver")
> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> ---

One nit, other than that:
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

> Change List:                                                                    
> ------------                                                                    
> V0 -> V3:
>   - Address the https://lore.kernel.org/lkml/4a565d54-f468-4e32-8a2c-102c1203f72c@lunn.ch/T/
>     review comments
>   
>  drivers/net/phy/mxl-gpy.c | 58 +++++++++++++++++++++++++--------------
>  1 file changed, 38 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
> index b2d36a3a96f1..e5f8ac4b4604 100644
> --- a/drivers/net/phy/mxl-gpy.c
> +++ b/drivers/net/phy/mxl-gpy.c
> @@ -107,6 +107,7 @@ struct gpy_priv {
>  
>  	u8 fw_major;
>  	u8 fw_minor;
> +	u32 wolopts;
>  
>  	/* It takes 3 seconds to fully switch out of loopback mode before
>  	 * it can safely re-enter loopback mode. Record the time when
> @@ -221,6 +222,15 @@ static int gpy_hwmon_register(struct phy_device *phydev)
>  }
>  #endif
>  
> +static int gpy_ack_interrupt(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	/* Clear all pending interrupts */
> +	ret = phy_read(phydev, PHY_ISTAT);
> +	return ret < 0 ? ret : 0;

Can we just return phy_read?

> +}
> +
>  static int gpy_mbox_read(struct phy_device *phydev, u32 addr)
>  {
>  	struct gpy_priv *priv = phydev->priv;
> @@ -262,16 +272,8 @@ static int gpy_mbox_read(struct phy_device *phydev, u32 addr)
>  
>  static int gpy_config_init(struct phy_device *phydev)
>  {
> -	int ret;
> -
> -	/* Mask all interrupts */
> -	ret = phy_write(phydev, PHY_IMASK, 0);
> -	if (ret)
> -		return ret;
> -
> -	/* Clear all pending interrupts */
> -	ret = phy_read(phydev, PHY_ISTAT);
> -	return ret < 0 ? ret : 0;
> +	/* Nothing to configure. Configuration Requirement Placeholder */
> +	return 0;
>  }
>  
>  static int gpy21x_config_init(struct phy_device *phydev)
> @@ -627,11 +629,23 @@ static int gpy_read_status(struct phy_device *phydev)
>  
>  static int gpy_config_intr(struct phy_device *phydev)
>  {
> +	struct gpy_priv *priv = phydev->priv;
>  	u16 mask = 0;
> +	int ret;
> +
> +	ret = gpy_ack_interrupt(phydev);
> +	if (ret)
> +		return ret;
>  
>  	if (phydev->interrupts == PHY_INTERRUPT_ENABLED)
>  		mask = PHY_IMASK_MASK;
>  
> +	if (priv->wolopts & WAKE_MAGIC)
> +		mask |= PHY_IMASK_WOL;
> +
> +	if (priv->wolopts & WAKE_PHY)
> +		mask |= PHY_IMASK_LSTC;
> +
>  	return phy_write(phydev, PHY_IMASK, mask);
>  }
>  
> @@ -678,6 +692,7 @@ static int gpy_set_wol(struct phy_device *phydev,
>  		       struct ethtool_wolinfo *wol)
>  {
>  	struct net_device *attach_dev = phydev->attached_dev;
> +	struct gpy_priv *priv = phydev->priv;
>  	int ret;
>  
>  	if (wol->wolopts & WAKE_MAGIC) {
> @@ -725,6 +740,8 @@ static int gpy_set_wol(struct phy_device *phydev,
>  		ret = phy_read(phydev, PHY_ISTAT);
>  		if (ret < 0)
>  			return ret;
> +
> +		priv->wolopts |= WAKE_MAGIC;
>  	} else {
>  		/* Disable magic packet matching */
>  		ret = phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2,
> @@ -732,6 +749,13 @@ static int gpy_set_wol(struct phy_device *phydev,
>  					 WOL_EN);
>  		if (ret < 0)
>  			return ret;
> +
> +		/* Disable the WOL interrupt */
> +		ret = phy_clear_bits(phydev, PHY_IMASK, PHY_IMASK_WOL);
> +		if (ret < 0)
> +			return ret;
> +
> +		priv->wolopts &= ~WAKE_MAGIC;
>  	}
>  
>  	if (wol->wolopts & WAKE_PHY) {
> @@ -748,9 +772,11 @@ static int gpy_set_wol(struct phy_device *phydev,
>  		if (ret & (PHY_IMASK_MASK & ~PHY_IMASK_LSTC))
>  			phy_trigger_machine(phydev);
>  
> +		priv->wolopts |= WAKE_PHY;
>  		return 0;
>  	}
>  
> +	priv->wolopts &= ~WAKE_PHY;
>  	/* Disable the link state change interrupt */
>  	return phy_clear_bits(phydev, PHY_IMASK, PHY_IMASK_LSTC);
>  }
> @@ -758,18 +784,10 @@ static int gpy_set_wol(struct phy_device *phydev,
>  static void gpy_get_wol(struct phy_device *phydev,
>  			struct ethtool_wolinfo *wol)
>  {
> -	int ret;
> +	struct gpy_priv *priv = phydev->priv;
>  
>  	wol->supported = WAKE_MAGIC | WAKE_PHY;
> -	wol->wolopts = 0;
> -
> -	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, VPSPEC2_WOL_CTL);
> -	if (ret & WOL_EN)
> -		wol->wolopts |= WAKE_MAGIC;
> -
> -	ret = phy_read(phydev, PHY_IMASK);
> -	if (ret & PHY_IMASK_LSTC)
> -		wol->wolopts |= WAKE_PHY;
> +	wol->wolopts = priv->wolopts;
>  }
>  
>  static int gpy_loopback(struct phy_device *phydev, bool enable)

