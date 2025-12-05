Return-Path: <netdev+bounces-243877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCC8CA9505
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 21:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EA073012DD6
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 20:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACC1280A29;
	Fri,  5 Dec 2025 20:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CXv7o3X9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEBD3B8D75
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 20:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764968204; cv=fail; b=QOQctE3nRS3wwlJjokCZ+06+L7wSPzOoOKHs6OYPtP77M9mcqDQR8laLbggfLExkLuhNvrGlGPhdkjn61UsWxKf3Uoswx0Fhds3oAT3hIoCupAmeEvtnrUV5BByZfxQDNN9Ljg+/JH0EsZg1Wj65fpErwc4SXqP7pz2yAFWkfo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764968204; c=relaxed/simple;
	bh=KB4bTu8VTMRKi4kHrwuE7igXhYUuCXJJ51Z3r0cmOe0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TDPrEr38SvRmSS+p75IZA9nItRg6kcvSP2YF72WuNfsP+GNAwIRnimJUU836TG8JlTHWQYBOQn9JZX0qdb9mFqoeWO+GzSN1524+ggHbbKD1gC8WVhUEQcBqKYelrE2wX+i4LcksbubITTDRAMThlBcBS7Sfbal6d4MHEd1hZ4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CXv7o3X9; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764968203; x=1796504203;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KB4bTu8VTMRKi4kHrwuE7igXhYUuCXJJ51Z3r0cmOe0=;
  b=CXv7o3X99ey8Czsf3p6mVLjm69/uuDItnUIJoqagaytDtFN6Ha9nnQsN
   FEM6cE5JzjHa7/TVn7zmqrjqfWqWeO3cR7UeBhr9Sbs++l9VpJ2dzDfow
   yJ2DGQwOpCAXI7HbbAcFsT+j30lqsBzL+kOGwPXxupGZMu9KjuLtZDW3z
   5gMwMope+8UuvHEnk3n0LMhOhQcvx/sLFRVRrdVL9Q7x20n/K7l1THdTo
   AW5hGZoxsQVB4HAVfXIK8bXhQsQ3yktyk8WstQLBkQa1y0sggHrdScoiS
   cKn94GlwW+C1y5G4kUGTKckNkmfP/Ag5UC3AQ33YT5dvOsf+ioQhTA1UQ
   w==;
X-CSE-ConnectionGUID: jCowU0dMTMyhfRnhPNOpdg==
X-CSE-MsgGUID: cwssY9uvRmOxHV5zp0WgTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11633"; a="70855625"
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; 
   d="scan'208";a="70855625"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 12:56:42 -0800
X-CSE-ConnectionGUID: 9Yabh4g3RkiHeeM9a4m1XQ==
X-CSE-MsgGUID: QOGsyFyzSsyR+4nYyQjMkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; 
   d="scan'208";a="195464946"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 12:56:41 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 12:56:41 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 5 Dec 2025 12:56:41 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.31) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 12:56:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cDo2Bfi7ES3RPoiFogi2sJvwhmc5LAnGP7uBYHRZRHBMEm2bMuJOuNA2sMYdlS5H36lmyRSIUAmLBZ9ZUGJZP1sp+cN+aA8xhPubvC3X9mZGvF9xCbOopoJdsD8sz1mG1gSKcLsptrUPKS60Igo/kDbbC5E/sh/KkHMQQrXinT8b9NexJIWijh6G/TpfwdmIyie5PynkNRbN+/yUa1FtrJ2Ml0hw7GF+aTjg7DQvqCLVAIXvOzYyldFkGtMXqoW7mvb3gmYiodW5gI/zrkDc1srGKQBkITz6nsLr5P7SAivdoDqUezEjflUH6FM4Zqh4X9dQ7hsOoSX++1qSaWNtbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KB4bTu8VTMRKi4kHrwuE7igXhYUuCXJJ51Z3r0cmOe0=;
 b=Q5R3UaXNajhIWbbGmNxiVnnN9Op/Ha671tZI8ic9JVNbN0JZORzfURUNYuqm1BCAYmV07fAIMgd9N+uEul+bDZvIsUkfQSIOjLwQJHNYeuOhEUCaPKobzRNK5ToKHAEfN/mgVNXr0SOCxphYLfg/K/WuA6iecs5ikzxGHt4glgacnad/v//DA4sjYn5M5qunIMNgGcONnW9kCG+0xqDo5E6QMQFqm7LvuFdtM3c2mJdmwUDjRtqrv6Pg0PkLn52D5xkd/iBq/jHP3UQtKt1b04gpfbhpdtrZVh/AMH1Q5zP7NHazVnStOD23B2w9KtOMXiXwR25vlvHqb2v37CRSHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MN2PR11MB4743.namprd11.prod.outlook.com (2603:10b6:208:260::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 20:56:33 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9388.011; Fri, 5 Dec 2025
 20:56:32 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Brandeburg, Jesse" <jbrandeburg@cloudflare.com>, Jesse Brandeburg
	<jbrandeb@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, IWL <intel-wired-lan@lists.osuosl.org>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
Subject: RE: [Intel-wired-lan] [PATCH net v1] ice: stop counting UDP csum
 mismatch as rx_errors
Thread-Topic: [Intel-wired-lan] [PATCH net v1] ice: stop counting UDP csum
 mismatch as rx_errors
Thread-Index: AQHcYxu8BMnAWu0KtUmfnkpkfCM/cLUSuvdggACy9gCAAB31YA==
Date: Fri, 5 Dec 2025 20:56:32 +0000
Message-ID: <IA3PR11MB898654344D883B1CC06A7636E5A7A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251201233853.15579-1-jbrandeb@kernel.org>
 <IA3PR11MB8986697A94FB36E893C7E87FE5A7A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <d6dcd835-7564-481a-a854-25b187893e6c@cloudflare.com>
In-Reply-To: <d6dcd835-7564-481a-a854-25b187893e6c@cloudflare.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MN2PR11MB4743:EE_
x-ms-office365-filtering-correlation-id: 38f22491-1d68-4639-7119-08de3440c566
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?cjVlRDZvTS9vbGJMVlJpNjlEcTMya3ExUi9ZdFRRd05ubGdabnVKOTRIZmpa?=
 =?utf-8?B?cTFucnRSdUdkalUrWlJzNVVJWnRrNUg5WTdncmhQYXowK0VNNlEvRGp2Tk9J?=
 =?utf-8?B?akRUUmVLeEc1NHBxZGVXRVV6NFBRY2Vqd0V6TjkxbmRFOVFrQ1FQcDdzRGg4?=
 =?utf-8?B?SGFTMHV2VXdwTzRYQWZPN1lNOFNvN0lxUWtaQUNTOWNFOUx3MThFdW9ZWEM2?=
 =?utf-8?B?RXM2M2tUQlh4Mk1JRXRrQmFWUWlSWS9SSXRIbTlhUHhHMk1ld05IMjB0bFJ6?=
 =?utf-8?B?VkZEUWlTU2xpcGFwT3RMdTdWY3RNbnlnU2tLL3JvNkdUeENXTjlxbDIyazVI?=
 =?utf-8?B?TEh2bzlvbDNBRlJZcGtQeENuellrK0xMbWcrRWtyS1RIN1pQdzVsckY0NmJV?=
 =?utf-8?B?Q2V5aXNrT2NLMFRicUJaNytDRXkxaHFCTmduZHJsWnZqaTNWbFJYdFd1NGZq?=
 =?utf-8?B?ZUthYUJXdWl5Z0RoMmRHNFBiU1E4eERTcXpzMUZuR2JkanNhRnpNLzdwZlp6?=
 =?utf-8?B?RG1kWVRDbXZzSnRJbnFNT0YxWVBZTmtIZ3hIUTVpWTJOZFMxOWN0Q1VXMzJl?=
 =?utf-8?B?ZG5TWHFra25uUUdnVnA5NXRsNGxZRVBrcVNXeEljMDY0VnV5MXhXR0oxenV0?=
 =?utf-8?B?N2RmRUJ6S1l3S1dvQjVIVllvV05GOGg4RnZjclMzK0pQM2I5TXJuVTI3WTZR?=
 =?utf-8?B?NTE1ZmRkL0ZUV1FpWktHOUJsb2dYWXh0bUpwK0M5ZjV1L2RTSW5TNUd4VGRB?=
 =?utf-8?B?S0tzN2Fsb3JFUzNiT0hKZS91NCtWSS9CSWduYmthbm15Z2xHeDlZblErMVpk?=
 =?utf-8?B?M0lDZk5OMjk3bkJpVzcrSVI5TjM3cTJsNXR1SkhqVi93alRsRlZXQ2pyVFhr?=
 =?utf-8?B?dkI1YXowSUFSckpTNkQxNE9GNGZ2T3JJajh2VmNWcW1kMVVIQkRjUGJMem5o?=
 =?utf-8?B?VzdxQ05PaTNVZHlVTmdCaW5DTkF2RGxHMUtwUHNlajY2Ni9OM0YzUXBqQllx?=
 =?utf-8?B?alkwejVNSmNGZFh3Q294L1pvWVBOV005R2M4aktUcWlVb2lLRXV1R1RwZnlx?=
 =?utf-8?B?RFRkTm1WVTNoSUJIdkNkdzNIOW0xSTlCM2pycXZVYmpYS3ZDNHM0Zzl0cEQ3?=
 =?utf-8?B?MTZIVERpV3dnOTZld2V4OVA0SjhST1JGS0xTcXhiSDhMUVBuK1VQUTJSVCs4?=
 =?utf-8?B?Y0tlOVpmcmZSSEJITDduT0h0VTdCd3JWcGlyMkU5Y3d5VmY5aXdRdHhPblUw?=
 =?utf-8?B?NXB5a3hodTJkaUNOMmJHMUJuTGozTXo1OEdFK2xaSUp1RzloaDBYdGhRbS9L?=
 =?utf-8?B?SnJlUmZDOCtIQk1vQ2pleGNtWWxYTjdJbWN4aTJ4NXhHZEg2dlRIbU9hd2FW?=
 =?utf-8?B?K0hsMEZKY3E4YzJKWlB5djdFQldrLzlFUkhkMDd0TjlYWnB3Wmtnc2xoQUo4?=
 =?utf-8?B?UmpzY2VTMzJBNXd6VXdaOEdhNE9qcTVyMUd2MzdrSW5VdndVejNhbEgxcGZL?=
 =?utf-8?B?dzl1cUZNNTNFN2FDQlY0RTR3WlU0TmVreFhtNkZ4cllKL3dpMStUYmkwSjlB?=
 =?utf-8?B?dmx1MlBMY3p4bW5OSUVxaEd2OGJiQ3hHWldobU1nNDFNZlRUaWZ4RythTmZC?=
 =?utf-8?B?NlNub3dtcVJRODNsa3BXRjlDNlI1L3F4L2VUZE9xNkp3OHVJai9MSTlWUjdh?=
 =?utf-8?B?cjREdFZic0dSVk5MemltSG9KcTllRkkyZ2lyRjVGVUlzM0pnZktoRm1xOVdX?=
 =?utf-8?B?NXZHKzJiTkt3NXlNRGhHdUp6NG9iSUxYK1JDeURlVlZwY2lqZ0N3NFZNSEtK?=
 =?utf-8?B?TFZ4SVJLQ1VadXRGQUZ3c2FqRkVMc0dqWGZzcS9mZ3A2Q1Y5dFhDb1dTM3I2?=
 =?utf-8?B?RTJEWG9VNEFuSXFkSGNuZWVWYTlOVnh0amRiNlNtZi9UeStSa29LZnhZQ1RZ?=
 =?utf-8?B?K0x6UGNZTHJNOUF6MDFDNGkzc1BpRnc0RDgrdzNjRk02UVFmVi9telhMZnFB?=
 =?utf-8?B?c3phbnZPb1poU2dGcVpVSXZHWmtlampaRmhXK05DcCs3ZWkxUzZYT05ud1ZI?=
 =?utf-8?Q?1+n/UI?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTdreTBHcUw4dGhPTVFYdVJuWGJqNjA1OVQycFdBQ3U0L25QRStGdElnY2lJ?=
 =?utf-8?B?eE1TSWNHczE0RE1LTGxNNkhjMitTRjVDTHVkSkUwZ2x0SDl4dlNvTzR6WTVa?=
 =?utf-8?B?SnU1Zkxwd3B4ZlAwdGVLV05YUVlKa0ZUdGJNcVF5Y0dCcTQxSm4xZHhEWEJQ?=
 =?utf-8?B?c0xuSFR3UmNVdnJwYllIZ0J0ODVjMHNaTDZya0hFbHNQNFhDNk1BaEYzdU9Q?=
 =?utf-8?B?MFI3SWdqcDdzcHhRTmFDT3VSQm1LL2N6anB4SGlQT21ieW1RVFlkeC9wWmFT?=
 =?utf-8?B?OGR4NzFPN2VBSldCYW93SlNoMDg4Z2F6R0IwSW9hV0ZBc2RYWjNpUm5vVEJx?=
 =?utf-8?B?S0Z6L01ZM1dIaDlZbjdqL1NseUZvOG5HMVBESU8rSkIwMHQ2emJMR1ZScVM4?=
 =?utf-8?B?OEV6TmZUMGJFSUhTK3lMM3dpU1hhbitFQ3ROaXJTNzFRdG02QmVjdVdzcWRh?=
 =?utf-8?B?MlJ6aDhRSmQ4T1RsSzlvRDA2ZU1IWUFWbTlBYkZhNXA5L0N2NVZTQmFyTVBs?=
 =?utf-8?B?UG94VkZsalBibUROb3R1MlcxeURCR0xsYkJNRmxUQWsxTEZxcHc2S2VvY3hX?=
 =?utf-8?B?YkQzYTNZYk9GU1BGcGJCODFROVRWVWxMT1NmbGxCN0hNbjByUFR0RGxRWDdM?=
 =?utf-8?B?UHJBb0tyZ1JuanlTbVYzQWNzU3lBTjFkelByM2puUXd6bi9JREpvN1RGLzlV?=
 =?utf-8?B?eEhFVlFoMTFlUDRJWHhBNDJNNy8yYTR2aDAxTGF1cW5iVVRZNld4czQ4K2ti?=
 =?utf-8?B?bzhucVAyeW5FTWJxZ213eWl4QWJDWGtLUWFkVUhlbXc1NHRzK0dhU2lSbDRm?=
 =?utf-8?B?ZURGV3k3eENXR2VleElBaUtyamdDNThSQzc1d1VLd2xyQno4UTFRVkN4SUY0?=
 =?utf-8?B?UjIzSUR0ZlZOMjZwb0s1NFU5TmNhUGJDWTh5RHJUUDVvcFRNeE13N0h2THRX?=
 =?utf-8?B?WXMrT29kbFZSK0ZwMGQ5MEhlY1Bic3FrdndxaHZnK0ZkN281OWZkRnJ2cjNv?=
 =?utf-8?B?NzBaWkx0bzM4QjRTYnZRYmcremtUSklvNU1yS1pSVk1pUkhsUGhrNTlDZUlO?=
 =?utf-8?B?QkFyV295RGhYZ1Z0MVBnM3d0Z0IwY0crdWR5TUVyTWVtdUlqOEovVDhNNTNG?=
 =?utf-8?B?RzVWRlQvK2pCRlI3SlRxNWZ5Q0Q2QlYyNUE2N2VsZEdlY1VTdW94b3BkdkVJ?=
 =?utf-8?B?TUJPTm9ueldKeEZqOWNmTnIzZ1lDeWVWYWdNN2JnZWRsUTVnRVpWTjJIVlFY?=
 =?utf-8?B?aDNVT2lOMkVpcEU3ZjVzSVFjb3lzejNDeUErc1hjNEU5RThqaWpWVWtveVdw?=
 =?utf-8?B?VUwxc1djSDJIZGJqY24yMXFQeUorTFlabTVJUW9WcXJpN3N1bUlTT2xNdXdr?=
 =?utf-8?B?WDBFTkZpZ0xiU3dUQlllcWFZWWNXTVpSUDdyZFpyQkNVei9zdDdSVDl0VTFE?=
 =?utf-8?B?ZzY0d05zNHBDTFdRa2hFdGVQMHlrd0czdG5BeVIwNCtSbnhPVUVOSHRBNGl2?=
 =?utf-8?B?enI4NS96M1pYUm5RSlBYaXpSMlE4cnB2RVg1dzB1N0lOMXlEeUlpYkQ2MFkz?=
 =?utf-8?B?ZlF4UGp0b1lXY1NWczJEaklzZExXRWNYS2NoWW9CUUoxdW5HNDZTd3B6SE8z?=
 =?utf-8?B?N1NWYXlOckhmbW5wME8vc29nR3liWHFYeXFGbVFWWjQ0MlNLb25DYXNDM0lF?=
 =?utf-8?B?SlMzeEhWU0VHa0FiWWZlSFNkNUZUMm9QY094WGpUc0x6UitOQWRRNmJOcDR2?=
 =?utf-8?B?SFFpZ29KRThBMHlCN0tDNGpSaElZT2prK1V0NTRTYmRkTzZQaTJzTUtjUFRZ?=
 =?utf-8?B?czhIWmRiRC81eld4dlFWbXNVNTZZSkYyUzF1clkvZG9hWVRCUVUzSWVVRVlC?=
 =?utf-8?B?NHVtYnYrKzlBSUtVNFFrY010WjAxaTJSNWlQMllMNHlJbnpwRHNZOGxvWndB?=
 =?utf-8?B?YXFFRTVob09VZzVHbTB2MzZ5YTJKL25oVnhyL0RIR0thdjZjSmd3YXptTmxq?=
 =?utf-8?B?cFJiWFhJZnprWXk3Q1ovdmVtZnVDcm44ZzJOOWtKc0tSdkhEWlpldVBveFQy?=
 =?utf-8?B?eWhNbnR2VlVMaExMeDRyaEo4QmY1dEFWeUV5THErSHZncmhWNVVzQjJqQlJa?=
 =?utf-8?B?aUN4cXpDWHp5Z1FSVWRuREdDNGx3NDBtVFZJWjlzdTQzSE5zVFY5RVFIZUMw?=
 =?utf-8?B?bEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f22491-1d68-4639-7119-08de3440c566
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2025 20:56:32.7512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PsdzXB1a5B7/EI3DO4JxBj2hihYUpc3nWpDi0peAmc8VbrLc70L+7jPa5M6XNkpmD9DnL8GAh1HwQfL4EWtVQcDa1WrIsUwmrqrehNWPJgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4743
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmVzc2UgQnJhbmRlYnVy
ZyA8amJyYW5kZWJ1cmdAY2xvdWRmbGFyZS5jb20+DQo+IFNlbnQ6IEZyaWRheSwgRGVjZW1iZXIg
NSwgMjAyNSA4OjA1IFBNDQo+IFRvOiBMb2t0aW9ub3YsIEFsZWtzYW5kciA8YWxla3NhbmRyLmxv
a3Rpb25vdkBpbnRlbC5jb20+OyBKZXNzZQ0KPiBCcmFuZGVidXJnIDxqYnJhbmRlYkBrZXJuZWwu
b3JnPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZw0KPiBDYzogTmd1eWVuLCBBbnRob255IEwgPGFu
dGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgS2VsbGVyLCBKYWNvYiBFDQo+IDxqYWNvYi5lLmtl
bGxlckBpbnRlbC5jb20+OyBJV0wgPGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnPjsN
Cj4gS2l0c3plbCwgUHJ6ZW15c2xhdyA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT47IEFu
ZHJldyBMdW5uDQo+IDxhbmRyZXcrbmV0ZGV2QGx1bm4uY2g+OyBEYXZpZCBTLiBNaWxsZXIgPGRh
dmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmljDQo+IER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+
OyBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsNCj4gUGFvbG8gQWJlbmkgPHBhYmVu
aUByZWRoYXQuY29tPg0KPiBTdWJqZWN0OiBSZTogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIG5l
dCB2MV0gaWNlOiBzdG9wIGNvdW50aW5nIFVEUA0KPiBjc3VtIG1pc21hdGNoIGFzIHJ4X2Vycm9y
cw0KPiANCj4gT24gMTIvNS8yNSAxMjoyNiBBTSwgTG9rdGlvbm92LCBBbGVrc2FuZHIgd3JvdGU6
DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX21h
aW4uYw0KPiA+PiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfbWFpbi5jDQo+
ID4+IGluZGV4IDg2ZjU4NTllODhlZi4uZDAwNGFjZmEwZjM2IDEwMDY0NA0KPiA+PiAtLS0gYS9k
cml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX21haW4uYw0KPiA+PiArKysgYi9kcml2
ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX21haW4uYw0KPiA+PiBAQCAtNjk5NSw3ICs2
OTk1LDYgQEAgdm9pZCBpY2VfdXBkYXRlX3ZzaV9zdGF0cyhzdHJ1Y3QgaWNlX3ZzaQ0KPiAqdnNp
KQ0KPiA+PiAgIAkJY3VyX25zLT5yeF9lcnJvcnMgPSBwZi0+c3RhdHMuY3JjX2Vycm9ycyArDQo+
ID4+ICAgCQkJCSAgICBwZi0+c3RhdHMuaWxsZWdhbF9ieXRlcyArDQo+ID4+ICAgCQkJCSAgICBw
Zi0+c3RhdHMucnhfdW5kZXJzaXplICsNCj4gPj4gLQkJCQkgICAgcGYtPmh3X2NzdW1fcnhfZXJy
b3IgKw0KPiA+DQo+ID4gR29vZCBkYXkgLCBKZXNzZQ0KPiA+IEl0IGxvb2tzIGxpa2UgeW91IHJl
bW92ZSB0aGUgc2luZ2xlIHBsYWNlIHdoZXJlIHRoZSAnDQo+IGh3X2NzdW1fcnhfZXJyb3InIHZh
ciBpcyBiZWluZyByZWFsbHkgdXNlZC4NCj4gPiBXaGF0IGFib3V0IHJlbW92aW5nIGl0J3MgZGVj
bGFyYXRpb24gYW5kIGNhbGN1bGF0aW9uIHRoZW4/DQo+IA0KPiBIaSBBbGVrcyEgVGhhdCdzIG5v
dCB0cnVlLCBob3dldmVyLCBhcyB0aGUgc3RhdCBpcyBpbmNyZW1lbnRlZCBpbg0KPiByZWNlaXZl
IHBhdGggYW5kIHNob3duIGluIGV0aHRvb2wgLVMuIEkgdGhpbmsgaXQgaXMgaW5jcmVkaWJseQ0K
PiB2YWx1YWJsZSB0byBoYXZlIGluIHRoZSBldGh0b29sIHN0YXRzIHRoYXQgdGhlIGhhcmR3YXJl
IGlzICJub3QNCj4gb2ZmbG9hZGluZyIgYSBjaGVja3N1bS4gQXMgd2VsbCwgYWxsIHRoZSBvdGhl
ciBkcml2ZXJzIGluIHRoZSBoaWdoLQ0KPiBzcGVlZCBFdGhlcm5ldCBjYXRlZ29yeSBoYXZlIGEg
c2ltaWxhciBjb3VudGVyLg0KPiANCj4gSSBob3BlIHlvdSdsbCBhZ3JlZSBpdCdzIHN0aWxsIHVz
ZWZ1bD8NCg0KU28sIHRoZSBod19jc3VtX3J4X2Vycm9yIHN0aWxsIHdpbGwgYmUgdmlzaWJsZSBp
biByeF9jc3VtX2JhZC5uaWMgYXMgJ3ByaXZhdGUnIGV0aHRvb2wgc3RhdGlzdGljcy4NCkJ1dCBJ
IG1lYW4gaXQgd2lsbCBiZSBub3QgcmVmbGVjdGVkIGluIHRoZSBzdGFuZGFyZCAiL3N5cy9jbGFz
cy9uZXQvPGlmPi9zdGF0aXN0aWNzIi4NCldoYXQgZG8geW91IHRoaW5rIGFib3V0IGl0PyANCg0K

