Return-Path: <netdev+bounces-135288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EC799D6CA
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 20:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 041B4B20B11
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 18:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EA91CACC1;
	Mon, 14 Oct 2024 18:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SWRdks1l"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6C54683;
	Mon, 14 Oct 2024 18:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728931976; cv=fail; b=A/RCM12lXVBIQt3EVWg692Jt2X2MNGEsuXSd/Nttfi8EsU9EQEUepDLCPYfwXCErUKgpVmnC5Xbin3jP2XDLuTvfvMr/fiUo+r7YqAjlg3GUlQAZpASPnzS/zd4cqHk3y+9158Efn2jTB+ZWWz71OvZBRlY6DeqvOwQ9Z1rxafg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728931976; c=relaxed/simple;
	bh=wPqgtIA/gydKtQKYjag6V9dOxXla4PT/PFwaKKJJogk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KLroG7BvKIEY63HCbcNoZQJ4XYNqiclHRFDrqQen/9YkLXuFH+zqKDc/OvQCFN1v1ov5KvfTmtAuah/ElNOvO8EyiBoYpl98DKmRiK2Y70daXwZkCCul37iDcoAGg8MPmt5/o2pEnq5IfXrNOs/0k2z9Fl3FrOJymfLQAHO25iQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SWRdks1l; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728931974; x=1760467974;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wPqgtIA/gydKtQKYjag6V9dOxXla4PT/PFwaKKJJogk=;
  b=SWRdks1l9vZQDnp6NTmB8vDJtXXUsp15IkbIrU0Kxa0pn+zgZJ2RpNAC
   5tRL0/IZqCQ2Uf75IudxPMJF25r1CmN8kLJ033mORTxjE/FHER6/uRGSD
   wHIg75NalQX8JaNVijuuggilRgBkM+8ToSU+Llr5b+QMkqVTdb6UL1aLN
   9q8WGd0WO7+v+L8CcMhnjxpQOUzq/UOZl85T8V0MtThVktgp6Tqt+AD/Z
   BwfvJB5IxVmLe6DA2fL59ynAS0JjnetPyxTb/kK65mpcxRKkW1Vze3XVu
   qlSnOFJwu073JTmLXVx1j+bGN7Pf/JhjL1Q4hYOqmCXoazwFz5Rc3YOP5
   Q==;
X-CSE-ConnectionGUID: DUvyEoRJRAOYhr8eJtYjgQ==
X-CSE-MsgGUID: PXM0f8LpRRqvHLW5KcuDZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="45805799"
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="45805799"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 11:52:54 -0700
X-CSE-ConnectionGUID: OniQuiV+RhGF9qZ3NDvENw==
X-CSE-MsgGUID: MzFMAN4uT5i7bZkhIt5cWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="82221110"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Oct 2024 11:52:54 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 11:52:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 11:52:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 11:52:52 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Oct 2024 11:52:52 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 11:52:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F2MGC3bJuh7JlGjXHURCy0UaINquAiGclHfxY18k2ncWRxvhPQNcCMM/sUqOIM4Osff9+HBX2prfHTMH9AaDFi7RPi05HYXnl2AvkNihrru0kLqxn37GMwCVB4BgyzVRaKLIE3hTuxCMwMB+SBEktoSH9oeV9D8B2VMy1qAfZ8tsZRm/zsc2VM2E0tHvNWsLMCw6lsXqIttDVas7v9FdUvpKhr67JuMIyvEeUjCVmiGrXO4bPuKY037gGuSxhGEntqQAx/PR0bjOKzbrGk2exd7AAhH4yIeVYF+GGEPNyrJ6Xhg0dLYv95yjL8kXukiyiozaWtXC9Xe1g8oj6IZwPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=De1K3qR7LL7U0QP8JDQwGKeJ/zzQpDjl/bqXmXKpL3A=;
 b=rdfOawoBR21LTKIEkAS/CPIKsVo/vZre7bqN4nNkA0mEDvdSrTI8kuS4gVQ9eeThIBMr+78WDGo0lqkw6ovmv1kECvr5lbZ3L274q0MFpb4DEPsAHXPiJQl4Uv2LTJX62D59lhDAjt/RvTZ5lzoKyNq+RRQPyz1vz1aEhpr97qq8o2TUI/8fn1Zd6FzsxkIhlaySPHWZdMOQq7J6hHLI5Qj/a2otg1bemDyzoVEaax3g4VXsGeHXztSITaRO91WiDkLIOhtfxztKFxrd6fsudZEdKccX/NMEqIP7nwE+ek9AvRIVIvEnYhMDBQI0splXb9aboKxQjLxREPvZ0wvk6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Mon, 14 Oct
 2024 18:52:47 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 18:52:47 +0000
Message-ID: <4b60174a-2a4d-4bbf-a48d-f7d86b657ccc@intel.com>
Date: Mon, 14 Oct 2024 11:52:44 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/8] lib: packing: create __pack() and __unpack()
 variants without error checking
To: Vladimir Oltean <olteanv@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
References: <20241011-packing-pack-fields-and-ice-implementation-v1-0-d9b1f7500740@intel.com>
 <20241011-packing-pack-fields-and-ice-implementation-v1-1-d9b1f7500740@intel.com>
 <20241014142713.yst257gxlijdxdw2@skbuf>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241014142713.yst257gxlijdxdw2@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::10) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM4PR11MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: 31351a70-b116-450c-d306-08dcec816564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a3pQOW5oN0FhTzd5YkFNSEd2d3JreFdDSUY0SG5TeFlIWTJSUEErM3RqZkF6?=
 =?utf-8?B?UkoyTXIyZ3ZIVXBRV2MyaWJoQ0I3Ukw5emk5NkF6Q3JubEtpZWZuQjFidVc4?=
 =?utf-8?B?bWNqcGtEMWQ5b3ZZN1p4STYydENWZ2pFWE16VnFZRW1yWExUTGJpYitTbkZL?=
 =?utf-8?B?eTZLeGp4SnFqUUlQSTZnaFBKTWJ5WEVEbW9Dcm5aZ28zV1hWOVhXYkFZZkhX?=
 =?utf-8?B?dSs1T3JRaUVCZkREVnM0K2M2d1pkOW9oa0FVSG80WWgrWSsyU3YyQmt4NHda?=
 =?utf-8?B?Szl5ZERSbklDdjVONWx5eElBUEtaaVVNVGI5WHRralJlUVdYckY1SW5wMzB1?=
 =?utf-8?B?SGxyUFNKUnNmN1A4SVRJWTJOSnc2TVkwaUU1R2gyY1k4Ry9nVGdmZXU4MkNS?=
 =?utf-8?B?VVQvQXlKZm5rRjhlckhyV1lXZXNGUmZRbU5JeGc3bVRlb2Y3eWk4NVlJb1Q4?=
 =?utf-8?B?c0FVbHdva1RiVWhURW9uYm1xbHJFOU9ybFlid0ZKajlna2tTSXorWi9aNEFa?=
 =?utf-8?B?QTFXTm9WNjdwd01qejRWK2lNNnJZMDhNekY5eDNiZW0wT24ydG8zTDlmcDFo?=
 =?utf-8?B?K1pSTGc5VDBmUVNMTmNwZm5BL2tqTVYvaUYvRzRGdUgwZXE4aXB4d044TE1p?=
 =?utf-8?B?S3pKU1JVVm9PV0tLaytQbmRXdFJBYms2UHdmUzRSeCs0anVQbitya3NEaW9G?=
 =?utf-8?B?RllrWjdMaVk0OGc3ZjVBdHVZdHhibEZHTDc0a0cvaFgyZ1pTa2pHK3d1bFBS?=
 =?utf-8?B?YjZuZUk4WVFzTkdMMU04N2dTS25NdXVaczN0Z0ZZaFp4UzIvdmp5TGRGcHkw?=
 =?utf-8?B?RnFrYzBJR1JRKzdGYU5rWC91dGhGUjFMNlQyKzV6aGc5V1N4Q3R3T0RXR1dH?=
 =?utf-8?B?M2pReVhrMVQ0UTFWVnIzWlBPb1QwUVpiU0dWL3JsaUh0bTJNVVlOM0RibEl0?=
 =?utf-8?B?Z09tTXpCc0dZV0lCcGFoTktQTklRWmQxVWxTR2FFWGpRTlNndHRNM3hpT25U?=
 =?utf-8?B?QlkyYWpDS0xOR3Z3UGZDb0s1Vmtyc3pVeGdzL0Zsa1VKd200SVJDSUtVeC9o?=
 =?utf-8?B?T2dKelR3ZmpOdEFObnBCdDBqdWRSRklkSzlBWU1DWjg1K0hVQ2VxNEZSOFJY?=
 =?utf-8?B?ZEJhVjRGNG5CL0xwT3RIOTJqUXBvNnVQbXN5ZVk1QUthQXdEK3VQcnJUb0g3?=
 =?utf-8?B?bit4WGJGR2xHZ0ltczBnUm02MVh1bGtiaFI0UjdZSFBZVDFzcTZ4ZEtDSUZP?=
 =?utf-8?B?L1djdnp0RUErQmV3RXA4cHRHRkt6UzA3NENjeDdDWmxsaWpMVFd5MHM2ZzBj?=
 =?utf-8?B?YWhjUnp6L1IrNk9ZejV6eS80RnoxQ1B4dUxMRzhHeU91L3hCRUVKMzFNMDFw?=
 =?utf-8?B?bzhqQWxOQkN4UURxM0t4eTJsWXoraUw1NkJmb1NDRGdaekJCK1dNeENqYyt0?=
 =?utf-8?B?TXpWek9FWkpISHZIdS9iV0plSHk1NE5PaTFmTTN6S1dmMGdtZWtQQVhSUEdm?=
 =?utf-8?B?eVRrSURNekY4REg2VGFPUVc1V00rVm42dzlmU0J2N2YvbUxZUDJZMUNPL0ZX?=
 =?utf-8?B?WUs1eHVJbVNNY1d5UGJxOXNRT2JyNllWK3cwZ0ovZDBDWlBSTC94TUlpOFpk?=
 =?utf-8?B?NnFPZzhTcUxWTlRQWnhxeGx3TnVPZEZScVloMnV5UCtPYkkvU2FrMEpnY1RI?=
 =?utf-8?B?M2IrM1JURnJwL1FuSjFPVDU4OFhtVVkrNkNKOG1WVVROTy9ycUdXenhRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFZXb1pWRjdwRHZUdTZOZGljUEhTN2gwb2lzQTliYnU5d28rZHdQYWkydzB4?=
 =?utf-8?B?UHkwei9yWU9ZOCtYOXhGbWpVN3dPTFBraDZQOEFPMDJrQW5Cbnk0b1Vob3Zp?=
 =?utf-8?B?SlF3NXd5c2pVZXhtRUdVczdOVENpUFBWdnlhYUFmaTV0QXh2cnRDMFhDYWRx?=
 =?utf-8?B?d0tSTmRnTlhmWlh0T3pBZkVidHBQbVpGeHB4RU95eFhidS81NjVSL0ZiYWE4?=
 =?utf-8?B?clhISkVlSWJYbmhNbTdPOFV0VWRnb2hHelZsNzg3WDEyQkxTV0dTcjRWNnNh?=
 =?utf-8?B?OHQ2OWRZUkR5VGFmMDFuMkE4bllwYzV3UXFWS0liTHEyUWxydU1LT2ovN2E0?=
 =?utf-8?B?QXE5VTFUZkxOcDJpUkRZenBxblNhK0hHTGtzaGprRm1lN00vMWVVbmJleDUv?=
 =?utf-8?B?dFBicUVzV0puUTljQWpjSVRUcS9uMVZwQXBjY2xlOVVEbVJaWkxJVGJhbE1F?=
 =?utf-8?B?RTAyZ1BGc1pLTFN2S0xxeXNhVXU5ZCs2Q3hGWU5DSmZNaEwyamFQWlNwTjJz?=
 =?utf-8?B?cFVtWWg5Q3RHejlnOTNKMi9PZzd5TGM3dGlCS3FDZXhhc0FIeldNRFhHNFlO?=
 =?utf-8?B?TndWdDh6SWZuR0tYUjJsVEVramZsQTVzYVdZRDJxM0hlTzBqUmgzQ25sV2Z5?=
 =?utf-8?B?T1orbjNiaU95T3dNVVJ6OGxyRXhSNEhTMWpZcTZvZkJhOFB0NVNMRzVqRkJx?=
 =?utf-8?B?L2NFcDZDa291b2NBMjFqeUhKb05EVGFUd1B2eGtWTG5LVTMrSE9FNzdDcity?=
 =?utf-8?B?TjFoSHJWQlVydXpkMkQwVk9McUVwNDZmNXhqSUFOWUVhYkEvR0dNdytXRFJH?=
 =?utf-8?B?cTBYWkU3eDY4UzJJQklxSTZndXpZK2doU1FsME9uZG84QUFaei9IYVNUY3Ix?=
 =?utf-8?B?bG42QWZ0MW16ZlczNld6bXdQL01aQklWSVJ5dVEvNnpwWXNvcGV4NGZGZnRK?=
 =?utf-8?B?aENEYS9zQUxMdUJpeXJjUVJDM1liODVVRXlxWHNiRFVhSUZQNGZySWxUUHhp?=
 =?utf-8?B?VUE5akFqRE51MmUxWmFEa3FGTWlqalpZZmJLby9FR01qZDU3aXk4ZzNUNHRx?=
 =?utf-8?B?akVWRHJCVXJXVzJSd3hQYXdoOEJleDYxaStNeGY4R2h3NnFBK0EycWp4Lzh6?=
 =?utf-8?B?Z2FPMHNSUTdneWJWSkJKNmlJZTB0dExuNVNCZHVRS24rYU4zUjhJSzgxeGJv?=
 =?utf-8?B?YXBiOGN3alRzb055WGlIWHRNcER6Q1c1eVZTQWN2emo4amIvclovS2lndW0v?=
 =?utf-8?B?UjBPWjVsWFN1ZDhTcGg0MUFyb1ZTemhmZERRTVM0MVFiMnp4TUwrNVIwUVRC?=
 =?utf-8?B?Wk1WejRsSmluZ1ZCcm5GQ20wSGpWQWR4NWZEMFBTYTk3MmdScTVKYkM4YUtU?=
 =?utf-8?B?dC9kUG9GbGJ1NEJlejNpRFJzcFozSFdKeFhkdzY0WG5ETEhVbWx0dlZJSDda?=
 =?utf-8?B?YmowU1h5YW1VM21WNjlCRUdaMHFTRDNEbmRYNHQwV2dHMzhJK2kwWkhZMG0z?=
 =?utf-8?B?UTRxVUQ3ZmJpYmtPTmUxRDZYVlVHR0lSZFBCMXV6WHpRQXFvcHlneUlxTnN3?=
 =?utf-8?B?blRkcVN6b3hueWVhMkxSQkROcmZRVWtrMHdjTmttYks2c3pxZ3c3SUhMSHE1?=
 =?utf-8?B?UEg5Nmk1NlNuVGs4dFJ2aytpZVZySXBnTWFySytYOHd4VGhvcVJCUm5MNE90?=
 =?utf-8?B?Nm4vZTBNV1d3MGVuK29ROHBHYkwvaVlBSnNHTEw4bWJsdjE4NW1HZGtnMXo5?=
 =?utf-8?B?TTg2NFNvY2E2bVk5Z2JDR1pUbDFFUldBVU1FZnFHUUVrMmhmNzlzMjM1QW1J?=
 =?utf-8?B?NHlwcXNuMVQvcjBhT2kxSFV1M3ZYWEFnN095TlhjUVM2Z1BGOHhRTHlCVW1M?=
 =?utf-8?B?eWd1OE1zaG1NeXRVeDUzR0xnSEVhUTJwdVU5bWgyNTczRXJ0b0F2Wk13SFp4?=
 =?utf-8?B?NUZIMmVoUjBQTjVRYUN5UndPN1RvMlo1bWhBMHJBYmZ1SUQwSVV2MTRRRSts?=
 =?utf-8?B?bTZXcW0xNnVta0N1SzVGZjhnUXFqRHQ5dHdwNEk0ZHk0UnB5M3R6UGVtU0xV?=
 =?utf-8?B?OHB3QkRMWnNaUUlLZndCeWxVQWJCT3J4UkRIcjdxS2dkd0NUR29sVldaNTRP?=
 =?utf-8?B?MU9EUDRXbkRKU1BOUFhNdnlpTTR2QUdTN200SFV1OVJ1MDlsMUx6TWRjeUFQ?=
 =?utf-8?B?cXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 31351a70-b116-450c-d306-08dcec816564
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 18:52:47.6870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gViFqmK4pv1prfhKKxpEgdeLi9orZlBnSEGrPH1+3eHwm2UF2oFDG4lh247McD9jEm89TZeoMg6uPJeyionNG3C+9/9dOcV5yiU6EGNL9yY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6117
X-OriginatorOrg: intel.com



On 10/14/2024 7:27 AM, Vladimir Oltean wrote:
> On Fri, Oct 11, 2024 at 11:48:29AM -0700, Jacob Keller wrote:
>> From: Vladimir Oltean <vladimir.oltean@nxp.com>
>>
>> A future variant of the API, which works on arrays of packed_field
>> structures, will make most of these checks redundant. The idea will be
>> that we want to perform sanity checks only once at boot time, not once
>> for every function call. So we need faster variants of pack() and
>> unpack(), which assume that the input was pre-sanitized.
>>
>> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
>> ---
> 
> All patches with an author different than the submitter must have the
> submitter sign off on them as well.
> 

Yep, just forgot to add it to this one :)

> Please do not resend without some reviewer activity first on the code
> generation portion from patch 3/8, though.

Agreed, no reason to move the discussion to a new version yet.

