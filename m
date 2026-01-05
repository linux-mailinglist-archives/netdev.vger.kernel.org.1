Return-Path: <netdev+bounces-246910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F55CF255A
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 09:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6EAC33005331
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 08:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D8130F55F;
	Mon,  5 Jan 2026 08:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RGknguFf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C603A30F53B;
	Mon,  5 Jan 2026 08:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767600378; cv=fail; b=mHvpCcda+6pLg+2CJ0xadKac98O0SWH5lxLQoCOHQZNq6/JgyGzp2gLOchq7QxiXsmolG9vJchlNsCuv7UZ0wIzJ3cu5ZJEZgrs73uez1e5c6fGLyDYAXARpNDdJrk1PPNpUAETjzBR3ZUSs2HnJ8gDQvkLjvom9n4OmEngs3vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767600378; c=relaxed/simple;
	bh=YaW1BQea7qsaYombxFxzN0n8acgLIva65dLy3S/CXNM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=In8rIVm3SIWurwHUjzHXUldokI9irnbYk+uTCwKS2QNikLMz9zMQaKETYziIMWsZ/RKAnysGLnEUUPsqjoe7KHh70ln1HGf79xzar1dLlCfiEE2/Cwk7lVK03kc89BycHxykoQWwkUDmP0hEDNtbPpVDBVko4401yddZgLVFjZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RGknguFf; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767600377; x=1799136377;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YaW1BQea7qsaYombxFxzN0n8acgLIva65dLy3S/CXNM=;
  b=RGknguFfZDhQrcjURFpKnUgyKD/oi22w9gTOCQKE+OnVf56UYlisJJvX
   WMiUEDKZIvzAiStgtRaWH36o+daxHyodEJ5RLBBXetVMlH0bBqdayj6CD
   iLH+OE6oUb4QRkKQ+4qmC7XGoR8DnIcjI2C7sPS5KYtIW5LEh4HH6XQOJ
   1AbZNO+pyxdXfyklt32ECJ/NeLFe35ND3krgIzCVUuVvpRuSy2NCr3za0
   HV1F5AXGtjj04uVjHmLecgHzkNUXqCtrX23e+xcft/KJ6do6X2cNwWUy1
   rM4fpwQvkRABpvddYxdiC20JaE0i0kSeSvqIVluHHaX8SYk0ObLLQc1vO
   A==;
X-CSE-ConnectionGUID: NN5LOGLuTZK7DkBig2/W9w==
X-CSE-MsgGUID: aSaZrpU/QUOqzkWPAO5vxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="68896228"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="68896228"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 00:06:17 -0800
X-CSE-ConnectionGUID: wD/H7yuDQgK8saCN04A9Dg==
X-CSE-MsgGUID: j6t83qewScqShXkgG9aO3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; 
   d="scan'208";a="202804245"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 00:06:16 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 5 Jan 2026 00:06:15 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 5 Jan 2026 00:06:15 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.60) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 5 Jan 2026 00:06:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEiokN08MJYa7rkITraW1Bj6UPmnd61WzrFvgefiHq0nErijEu7C/5tieuAIQn0dH7qjKYAs0FAKpSZYXJUnMvK5fSfKB1uARgW0psIqAxNkcYZOP50c0M4ZKCt2RMueqiCMKdcBUUR14mcVuloVGHsk0w2lpLH2tAx83fKgljZaEhjFsX9C+MA7cn74+oJEva+QGwC5u3hPqvizfFpNXZwhQGPFyFPLSJOSRvlwJ/ZdztwH/aE7S8uFvTHTn6PpEaoI745xIJ/M0VciPZaY9gt0CD8H7bp90+xqlSn7hA1O6QV727K8JQypHHQqUiqapvQ0S3D4s8eM+/89yrTvsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YaW1BQea7qsaYombxFxzN0n8acgLIva65dLy3S/CXNM=;
 b=JcnKtbizN0aqZ00V3EvQvfYzd1fANhuH3TfwHAzAGqv02JwO5SbXGKD88jaMJR9UJqSU9HRfHPudIfFLa2n1hHGqImpBgDtqZdmS9E9i1qV2aFzNyQafVAAD3pQ8oWNporF8AshgI8d4yleETcsn+Z/c/WV6hgYC3CbTTLTgJ3pDdV1EVr9IX80s52TJQW98RwvGNBPMOSkcoiCONJNJ6/rGGVsZAPxD4DD7XG+Iu+V37AFd+4WQQO1SohXr9W9woPkoodt6Zj3gYJVW8UMm75jDQqPyZ1pBEc1OALwDtzZ1ZvWxlsEAsCHsFBSitqmkGrJ56ttVcvCZqxXvWmLg4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by LV8PR11MB8510.namprd11.prod.outlook.com (2603:10b6:408:1e8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 08:06:13 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 08:06:13 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Li Li <boolli@google.com>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "David
 Decotigny" <decot@google.com>, "Singhai, Anjali" <anjali.singhai@intel.com>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Brian Vazquez
	<brianvv@google.com>, "Tantilov, Emil S" <emil.s.tantilov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v2] idpf: increment completion queue
 next_to_clean in sw marker wait routine
Thread-Topic: [Intel-wired-lan] [PATCH v2] idpf: increment completion queue
 next_to_clean in sw marker wait routine
Thread-Index: AQHcfg87lHKQI9fmUkicduzLEQbNH7VDKbRggAAG+oCAAADGAIAAAdIAgAAEzSA=
Date: Mon, 5 Jan 2026 08:06:13 +0000
Message-ID: <IA3PR11MB8986E00F2F77A95EFB2A8C88E586A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260105064729.800308-1-boolli@google.com>
 <IA3PR11MB898683A1383A409E8C4B02F6E586A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <CAODvEq5MxAYzDiqNSnxJKNCFR9=LZYt5BD3SMXnNRXJehkYfBg@mail.gmail.com>
 <IA3PR11MB898663460FABC5C8AE6EC85FE586A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <CAODvEq4Fma_N+oRMuuW2X-BbnkSNUxbHiwh6dDA_3Q0YKR_mdw@mail.gmail.com>
In-Reply-To: <CAODvEq4Fma_N+oRMuuW2X-BbnkSNUxbHiwh6dDA_3Q0YKR_mdw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|LV8PR11MB8510:EE_
x-ms-office365-filtering-correlation-id: a16fed81-2708-4498-f24a-08de4c314b59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Zi9qdHAzb2pCb1ZJN0ZnZDVpQW9CeHdqYURzSmF2TE05Q0U3Myt6U3NXV3dR?=
 =?utf-8?B?SUZBaFp2QWQ2OGNPS0VzUDVvVDB5eFlMTnZUcXNKUzJldXJBNVhMM1pFejlo?=
 =?utf-8?B?TzJyQmY3TkwrMmM5L1JaYk8vZzNvbmVKK3F0Z3VqaG81aWl0bHVjNFBLdlNL?=
 =?utf-8?B?NkNVZEd4bFhGTklicHN1ZzFLTU1PUTFNOEhYcy8vWFprRVh0VHNLRHIvNU5H?=
 =?utf-8?B?TGJ2ZXlaR3lsMWlLN2RVdE03Q0pnYXR6cHdVTVl1QTJYdDE5VjJ0aHlnZG9T?=
 =?utf-8?B?MzRrNjJtTWlOdGQ2cTVocWZ5RGcvaFJiR0Q5YUVmOGNVNDdvby9NWjVReFlv?=
 =?utf-8?B?K0RLL3I0by8vMWY0M2VKSnlkRUNwamZOOTJSZ0RCbUx4dE8yNk1SZHZZS3Za?=
 =?utf-8?B?QTFjTGtRb3NWT21YN1hQWExQVmRGa2xWTjRpaDd3aUdGbGNrVTJ2RXVBYTNB?=
 =?utf-8?B?U29EbThnUVdja2drSWR2ckp1djhldHJlcTc1NkRIcHZQekQxZzJlUUNrNktK?=
 =?utf-8?B?amt0RzczcmF1dGJvN08veGg1UG5Yam91KzNwdG9vRUZQWHpyTE5ERVNTVzlF?=
 =?utf-8?B?aC9PcXVNMCtyTzBMTnppTWpRNWFqZ1I0Y3pLT25rMk1mU1NTYzRkQy9wUHNo?=
 =?utf-8?B?blBtdWFsKzd5ci9xd3BUZkJsZnhvRmdHRVQzb1A0bHhZd0dTRjBpZUNsd3U1?=
 =?utf-8?B?WTNXQkFvY25ZVks3Z2xBQ0xBdW9YdVZxOFBDNWNRcDR2UThsMGo0VndEeVA3?=
 =?utf-8?B?a1pCOEMxSzNJQUs1S2xpcEJxYTJobE1oMWs2M0Y1bHVhcWQwWVdQN1pUTE9a?=
 =?utf-8?B?MDJoTmQ0MmN2aHNuRzF4d2RDeUowZ2NMaElpa0RkWGlobzdkZTB2M2Z3Vzdu?=
 =?utf-8?B?amxnSEdzbFJMUUdyekt5M2xia2RCeTFnV2VqSzlkWW5paFlNNjlSMXpuSWE5?=
 =?utf-8?B?ai9RNXM1clpBdkx5WTZKbXBrLzNBS1FwK3puZWs1Y0lENFVNRi9wRSt3QjVJ?=
 =?utf-8?B?d0VCV1VlSkZxcWRac1crN0VFREs2VUd3bmJaNVpNRHl4OHNCZDVKdlpMOEdX?=
 =?utf-8?B?eTFwcmZFdXkrL1FnNGhTZjVOQTlTVXlENExWVWpKZDVaUE9RWEkrV0p0OXRs?=
 =?utf-8?B?NFdPL2RrYXZWc3YrcXB4M0hQMElKWFlBMDRMbHF6NTBpUnV6UzNmUHVoTS9T?=
 =?utf-8?B?Ykc4bUxLQjYxcnRyVC9Ca053M0lpbVZyYmdYdUlnTzRLYnFEckhibjVZWmJq?=
 =?utf-8?B?cXA1cGFwZDdBVFlVckM0cWlEQWpDNUtEZnNTR3dHVytNVFN3ZXc4Y1dZeEZN?=
 =?utf-8?B?RmJhdCtuL2NFbCtBMS9obGZGU2dWM2lDdXgwdjNpSkdlUDBleUlTa0I5ZVE2?=
 =?utf-8?B?RFhPTk1MVTJRTWQxakVUdExYRWxGTWVWOWNRSkU4MllkaE50NG50ekdvTHdr?=
 =?utf-8?B?cStocjl6QzA1QmpNZk9jU2tPeVFHTktyZDFqL25NRGZYZUpPMGJrUDRLSXRY?=
 =?utf-8?B?bUVudHlJcFNnTVJWRFNWbSs3WktZc1NzeVZjL0JHWU5VUkxma1hzV2xXZzk1?=
 =?utf-8?B?MGs4QTRJT3VEOWZudWN1dUVZUGNjWnFPSFJ1UnlLMSt4RE1IaUh1V25XSGRz?=
 =?utf-8?B?RVNIaEhPUkFxR2NEYTFYbENPNlJrenNYRXZCS0RwUTNGQnhXc3VnOGEvN1h6?=
 =?utf-8?B?eTVNM3ZGRGNiY1NnYmdOYndITnJtTTBxSWNScTdqYUlhK0UyVlRLV29vaGZm?=
 =?utf-8?B?NFA2L0E5TlgrZFozNVEyWnpXT0hsRCtZN3NZeVQ3NXYyWk45aGlhRHVKM2Rh?=
 =?utf-8?B?VVhaemV4UkpleVB0ZE5leC9iSTVlYmUxUHYvMkJuN2NHV0pITXNFMFQ0cXpz?=
 =?utf-8?B?Tk1mQ2tVdG9TOUdDRjEydnBiQWg2WlY1Q0E0TXlZM1l5UmNPNGtOUXFETXhp?=
 =?utf-8?B?S0MwTVYvUDJmbWN2VkJYdVEvUCtROVBrRWl0aGU4ZVoyVWVPRzRPS0dyekdL?=
 =?utf-8?B?blFLTmhEZzFzV0dqRFJEWE01YUhyakR0U2JTekRTckdubklaNGM3R3dqdzM2?=
 =?utf-8?Q?fdw755?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDluQldFbjVKaUsxaExvaWRMelVOeTFMQVRyUzNrL24wa2xQOWRiOTNHcW5s?=
 =?utf-8?B?V3UwS0xjaTRKM1NLa1Q1b2JuRElpOGZlZFlYc2srVEZ4cnBkK0wvaXUyckEx?=
 =?utf-8?B?Z3RETTRYQmF6MlA0M2ZhalZWSWM4bVZ6dVNrQ3hNUEl4UWFGYlZlekRpOWQy?=
 =?utf-8?B?KzZWVWZnczR2Rit6WUpEb3RYMW8yNjZMMlovbm9jNzV1S1JtaWFrSE5kVy9N?=
 =?utf-8?B?VEpTZ0VJbkNMaG9Nd0FoZ2gvUnA2Q2hvNGNERXl3N2xodk9jRUZTd0hkWVFD?=
 =?utf-8?B?TkowKzJHQTBDajVUQ0IwRXdvSzdRd1RJTnl6UjVOVTEvUmJiVk5MMGFCYkFk?=
 =?utf-8?B?Q0VvbzZCeVZLNXhSNVpsa2JoUFpWRTM2THpDUUVIcXZyWEIwUU81MXNIVjUr?=
 =?utf-8?B?WWJKa3hTU0Q1Qjl3ZjY3UEFSK3FhNTVJM0hud3lmbU1DQXVYaUxHYzV3dDhz?=
 =?utf-8?B?c1poNWZEcHVsbDJWMjBuR2xBODA0ZDN3aVdwVndrYlp0Z3IzRGFQSHN6T0JR?=
 =?utf-8?B?eUlNY2p5RUxPQm53ZWxTZUZZSTNvUnpkdUxXNC9RMXQ5RVZxaVBibXltTy9J?=
 =?utf-8?B?SFVPbms5S2UzSzZHSDlhWmdJRHNDSE5CSzJOUVlTOWVFS2phbHk4Y0FiblNv?=
 =?utf-8?B?S1RhU0VWT2NJcUNUQzFHdDd2OU1URStqTjAzNUN5MFlneXRIdzBmc1paelVw?=
 =?utf-8?B?aEkxSnVOTkJCRjcrOVNzRlI4aW1WSjFxZVRHSGpEcGVKRzl1ZE9nbENlOEtm?=
 =?utf-8?B?ZW9XYjRYOHN2aVcxQU1lSm1maG1ITXNGVUFFSnF6N1hFNHdyZ3pQZGp1MU11?=
 =?utf-8?B?NTlOVS9HUFBkc2VGYjYxbllhZlBBd0ZENDRQeS9MdytMUzRrZ29GYlhPZ216?=
 =?utf-8?B?aUx5OE5KT0VxU1NUb25pMUF1MCtKWXBwVUt4U00xODFCdXowZHJuRm82ZlNP?=
 =?utf-8?B?eDF3QlFCVEQ4OHNCQUtUYWRHSXdJcnhwYTkzSjZFL2VGVmtpRTMwaVpTL3dY?=
 =?utf-8?B?cUZCdC9EWVlnbHZpckpTcExxV1Zkd09iUmxUTmYzNktuZi9TKzhSUE8zWmcz?=
 =?utf-8?B?VWJTQkRpa3k5OVJrWUZtWGlFaG5aWnpTaWg1ZFI3d1R4Z0p1ZitwU2VneE5D?=
 =?utf-8?B?cFI3K3hMK2FYb1YyWVpnSmpObVBhUE5SeGo4MHdBUnJ0QnRNV050Ulh2SG80?=
 =?utf-8?B?N29iN3hwZG0xLzRhK2tqM0ZEK0NOR0Jxc25qYXcxOEE3SmhTV2hHSmJ3WTFZ?=
 =?utf-8?B?QmVGeDZvNThMSk9wQUNsUXFFMlMvR0RYUlROS0ZNcFkyTWtiamtSckRxOU9z?=
 =?utf-8?B?dzgzVkMwd2ZkMmV6aFQyLzZ5Q2N4MTJJL0NnV0E0WnRrazNpdG84TDZrcTNn?=
 =?utf-8?B?Zm9YRHd1dk41d2x0SDF2U1NiUFkxeHBJTDEzQ1NJeU05TGdweEh6TWhVaVFW?=
 =?utf-8?B?aldKWVd2eUZFWVV0VXFwU3dhZUM3WHRJczVHWWRKRVNodUNzajBqZVpIcW1a?=
 =?utf-8?B?b2hULzEvTS9Pd1hma0ROTFEzNnRnY3dlUHZWYTZwUGsyVlpCQU5LWkVKbGNI?=
 =?utf-8?B?eVFWaUVHbmdoZGxrMXFiNzIxUnlHTUtjaHRDN1k2bFM3eHZSQ3V6QkRkUTc5?=
 =?utf-8?B?WXNwQitqNEUyVElOdWhJbWo5QXhFNW4xTk01aVhWWUF6ZVlZRVlPT3pGU3Rz?=
 =?utf-8?B?MmRIaVlSeEpFZGU2YWs0bXdQRGNOemlQZXh4YXZiY3pZeVp6RWVVdTZWUTVE?=
 =?utf-8?B?UWFPMmdscnhTYVZwOGtrRFdRZUZBZHlHanYwNjhuaEFhblVHdFFyZVRXbFRH?=
 =?utf-8?B?YUJTMVdyYW8vLzY4TVE1THRUcm5XUEdiMktOV29PZVB6cVVsOWRDQVBsVFk4?=
 =?utf-8?B?a2dHc0xKUGh2Yk9oZFRjZkhWR1BZWnd5dVJGVlhUZDQ2R0JZVjB0N3JTTW1p?=
 =?utf-8?B?bWJxOVJmU1UwNy8vUXJZbmxHZE16MkR6OWFOTHV2WDQzRFpSZmxUdTBWU203?=
 =?utf-8?B?c2pLNEIxSExlbXMvbmlncEtlNE05WldrWUFlR3loZGc5QkgxMml3cmdrRW1q?=
 =?utf-8?B?Y091NG83MlE5Ym1uSURlSG5FUzh3KzNSTkVtN1AyS1RqbTFncEZ0bHpCQlpk?=
 =?utf-8?B?NzYwWkhNeXJtNk4zRUNCVmlPbXUwcTd5NzVyN29vWk95OStNRzRBRGNTR1VX?=
 =?utf-8?B?NmxSN3R0WE9nZHRyRTVJSEZ2Q3ZwRHZ4ajR2NWJiZVEzOHovc1h3aVdFWEp1?=
 =?utf-8?B?YmQ0UTI3K2tmcTRUQVlWa0psOEp3RHRyeHFNOFA0RUY1NnZzbExLZUhlemMr?=
 =?utf-8?B?SWFvdmwyTld2ZjhWUkttdEc1T1V1SFgybHRJNFNweWpMQWsrU05VUT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a16fed81-2708-4498-f24a-08de4c314b59
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2026 08:06:13.4272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XXtQuE0D6vp4y/z/qoa8pBnpMiKrflFrCmn5K+OEam/3jbzUuL6U4lNBS//AAY7xhJzaJoTIz+AZIyZ1dGqOYY44TbeEs6l4BvUY5it69/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8510
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGkgTGkgPGJvb2xsaUBn
b29nbGUuY29tPg0KPiBTZW50OiBNb25kYXksIEphbnVhcnkgNSwgMjAyNiA4OjQ5IEFNDQo+IFRv
OiBMb2t0aW9ub3YsIEFsZWtzYW5kciA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+DQo+
IENjOiBOZ3V5ZW4sIEFudGhvbnkgTCA8YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+OyBLaXRz
emVsLA0KPiBQcnplbXlzbGF3IDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPjsgRGF2aWQg
Uy4gTWlsbGVyDQo+IDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgSmFrdWIgS2ljaW5za2kgPGt1YmFA
a2VybmVsLm9yZz47IEVyaWMgRHVtYXpldA0KPiA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IGludGVs
LXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnOw0KPiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBEYXZpZCBEZWNvdGlnbnkNCj4gPGRlY290QGdv
b2dsZS5jb20+OyBTaW5naGFpLCBBbmphbGkgPGFuamFsaS5zaW5naGFpQGludGVsLmNvbT47DQo+
IFNhbXVkcmFsYSwgU3JpZGhhciA8c3JpZGhhci5zYW11ZHJhbGFAaW50ZWwuY29tPjsgQnJpYW4g
VmF6cXVleg0KPiA8YnJpYW52dkBnb29nbGUuY29tPjsgVGFudGlsb3YsIEVtaWwgUyA8ZW1pbC5z
LnRhbnRpbG92QGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtJbnRlbC13aXJlZC1sYW5dIFtQ
QVRDSCB2Ml0gaWRwZjogaW5jcmVtZW50IGNvbXBsZXRpb24NCj4gcXVldWUgbmV4dF90b19jbGVh
biBpbiBzdyBtYXJrZXIgd2FpdCByb3V0aW5lDQo+IA0KPiBPbiBTdW4sIEphbiA0LCAyMDI2IGF0
IDExOjQz4oCvUE0gTG9rdGlvbm92LCBBbGVrc2FuZHINCj4gPGFsZWtzYW5kci5sb2t0aW9ub3ZA
aW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+DQo+ID4NCj4gPg0KPiA+DQo+ID4gRnJvbTogTGkg
TGkgPGJvb2xsaUBnb29nbGUuY29tPg0KPiA+IFNlbnQ6IE1vbmRheSwgSmFudWFyeSA1LCAyMDI2
IDg6MzkgQU0NCj4gPiBUbzogTG9rdGlvbm92LCBBbGVrc2FuZHIgPGFsZWtzYW5kci5sb2t0aW9u
b3ZAaW50ZWwuY29tPg0KPiA+IENjOiBOZ3V5ZW4sIEFudGhvbnkgTCA8YW50aG9ueS5sLm5ndXll
bkBpbnRlbC5jb20+OyBLaXRzemVsLA0KPiA+IFByemVteXNsYXcgPHByemVteXNsYXcua2l0c3pl
bEBpbnRlbC5jb20+OyBEYXZpZCBTLiBNaWxsZXINCj4gPiA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47
IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBFcmljDQo+IER1bWF6ZXQNCj4gPiA8
ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnOw0K
PiA+IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IERhdmlkDQo+IERlY290aWdueQ0KPiA+IDxkZWNvdEBnb29nbGUuY29tPjsgU2luZ2hhaSwgQW5q
YWxpIDxhbmphbGkuc2luZ2hhaUBpbnRlbC5jb20+Ow0KPiA+IFNhbXVkcmFsYSwgU3JpZGhhciA8
c3JpZGhhci5zYW11ZHJhbGFAaW50ZWwuY29tPjsgQnJpYW4gVmF6cXVleg0KPiA+IDxicmlhbnZ2
QGdvb2dsZS5jb20+OyBUYW50aWxvdiwgRW1pbCBTIDxlbWlsLnMudGFudGlsb3ZAaW50ZWwuY29t
Pg0KPiA+IFN1YmplY3Q6IFJlOiBbSW50ZWwtd2lyZWQtbGFuXSBbUEFUQ0ggdjJdIGlkcGY6IGlu
Y3JlbWVudCBjb21wbGV0aW9uDQo+ID4gcXVldWUgbmV4dF90b19jbGVhbiBpbiBzdyBtYXJrZXIg
d2FpdCByb3V0aW5lDQo+ID4NCj4gPg0KPiA+DQo+ID4NCj4gPg0KPiA+DQo+ID4NCj4gPiBPbiBT
dW4sIEphbiA0LCAyMDI2IGF0IDExOjE54oCvUE0gTG9rdGlvbm92LCBBbGVrc2FuZHINCj4gPGFs
ZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+DQo+ID4NCj4gPiA+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4g
PGludGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uDQo+IEJlaGFsZg0KPiA+ID4g
T2YgTGkgTGkgdmlhIEludGVsLXdpcmVkLWxhbg0KPiA+ID4gU2VudDogTW9uZGF5LCBKYW51YXJ5
IDUsIDIwMjYgNzo0NyBBTQ0KPiA+ID4gVG86IE5ndXllbiwgQW50aG9ueSBMIDxhbnRob255Lmwu
bmd1eWVuQGludGVsLmNvbT47IEtpdHN6ZWwsDQo+ID4gPiBQcnplbXlzbGF3IDxwcnplbXlzbGF3
LmtpdHN6ZWxAaW50ZWwuY29tPjsgRGF2aWQgUy4gTWlsbGVyDQo+ID4gPiA8ZGF2ZW1AZGF2ZW1s
b2Z0Lm5ldD47IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBFcmljDQo+ID4gPiBE
dW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPjsgaW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9z
bC5vcmcNCj4gPiA+IENjOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBEYXZpZA0KPiA+ID4gRGVjb3RpZ255IDxkZWNvdEBnb29nbGUuY29tPjsg
U2luZ2hhaSwgQW5qYWxpDQo+ID4gPiA8YW5qYWxpLnNpbmdoYWlAaW50ZWwuY29tPjsgU2FtdWRy
YWxhLCBTcmlkaGFyDQo+ID4gPiA8c3JpZGhhci5zYW11ZHJhbGFAaW50ZWwuY29tPjsgQnJpYW4g
VmF6cXVleiA8YnJpYW52dkBnb29nbGUuY29tPjsNCj4gPiA+IFRhbnRpbG92LCBFbWlsIFMgPGVt
aWwucy50YW50aWxvdkBpbnRlbC5jb20+OyBMaSBMaQ0KPiA+ID4gPGJvb2xsaUBnb29nbGUuY29t
Pg0KPiA+ID4gU3ViamVjdDogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIHYyXSBpZHBmOiBpbmNy
ZW1lbnQgY29tcGxldGlvbg0KPiA+ID4gcXVldWUgbmV4dF90b19jbGVhbiBpbiBzdyBtYXJrZXIg
d2FpdCByb3V0aW5lDQo+ID4gPg0KPiA+ID4gQ3VycmVudGx5LCBpbiBpZHBmX3dhaXRfZm9yX3N3
X21hcmtlcl9jb21wbGV0aW9uKCksIHdoZW4gYW4NCj4gPiA+IElEUEZfVFhEX0NPTVBMVF9TV19N
QVJLRVIgcGFja2V0IGlzIGZvdW5kLCB0aGUgcm91dGluZSBicmVha3Mgb3V0DQo+IG9mDQo+ID4g
PiB0aGUgZm9yIGxvb3AgYW5kIGRvZXMgbm90IGluY3JlbWVudCB0aGUgbmV4dF90b19jbGVhbiBj
b3VudGVyLg0KPiBUaGlzDQo+ID4gPiBjYXVzZXMgdGhlIHN1YnNlcXVlbnQgTkFQSSBwb2xscyB0
byBydW4gaW50byB0aGUgc2FtZQ0KPiA+ID4gSURQRl9UWERfQ09NUExUX1NXX01BUktFUiBwYWNr
ZXQgYWdhaW4gYW5kIHByaW50IG91dCB0aGUNCj4gZm9sbG93aW5nOg0KPiA+ID4NCj4gPiA+ICAg
ICBbICAgMjMuMjYxMzQxXSBpZHBmIDAwMDA6MDU6MDAuMCBldGgxOiBVbmtub3duIFRYIGNvbXBs
ZXRpb24NCj4gdHlwZToNCj4gPiA+IDUNCj4gPiA+DQo+ID4gPiBJbnN0ZWFkLCB3ZSBzaG91bGQg
aW5jcmVtZW50IG5leHRfdG9fY2xlYW4gcmVnYXJkbGVzcyB3aGVuIGFuDQo+ID4gPiBJRFBGX1RY
RF9DT01QTFRfU1dfTUFSS0VSIHBhY2tldCBpcyBmb3VuZC4NCj4gPiA+DQo+ID4gPiBUZXN0ZWQ6
IHdpdGggdGhlIHBhdGNoIGFwcGxpZWQsIHdlIGRvIG5vdCBzZWUgdGhlIGVycm9ycyBhYm92ZQ0K
PiBmcm9tDQo+ID4gPiBOQVBJIHBvbGxzIGFueW1vcmUuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9m
Zi1ieTogTGkgTGkgPGJvb2xsaUBnb29nbGUuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiBDaGFuZ2Vz
IGluIHYyOg0KPiA+ID4gIC0gSW5pdGlhbGl6ZSBpZHBmX3R4X3F1ZXVlICp0YXJnZXQgdG8gTlVM
TCB0byBzdXBwcmVzcyB0aGUNCj4gIid0YXJnZXQnDQo+ID4gPiAgICB1bmluaXRpYWxpemVkIHdo
ZW4gJ2lmJyBzdGF0ZW1lbnQgaXMgdHJ1ZSB3YXJuaW5nIi4NCj4gPiA+DQo+ID4gPiAgZHJpdmVy
cy9uZXQvZXRoZXJuZXQvaW50ZWwvaWRwZi9pZHBmX3R4cnguYyB8IDYgKysrLS0tDQo+ID4gPiAg
MSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPiA+DQo+
ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWRwZi9pZHBmX3R4
cnguYw0KPiA+ID4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZHBmL2lkcGZfdHhyeC5j
DQo+ID4gPiBpbmRleCA2OWJhYjcxODdlNTQxLi40NTJkMGE5ZTgzYTRmIDEwMDY0NA0KPiA+ID4g
LS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWRwZi9pZHBmX3R4cnguYw0KPiA+ID4g
KysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWRwZi9pZHBmX3R4cnguYw0KPiA+ID4g
QEAgLTIzMjYsNyArMjMyNiw3IEBAIHZvaWQNCj4gaWRwZl93YWl0X2Zvcl9zd19tYXJrZXJfY29t
cGxldGlvbihjb25zdA0KPiA+ID4gc3RydWN0IGlkcGZfdHhfcXVldWUgKnR4cSkNCj4gPiA+DQo+
ID4gPiAgICAgICBkbyB7DQo+ID4gPiAgICAgICAgICAgICAgIHN0cnVjdCBpZHBmX3NwbGl0cV80
Yl90eF9jb21wbF9kZXNjICp0eF9kZXNjOw0KPiA+ID4gLSAgICAgICAgICAgICBzdHJ1Y3QgaWRw
Zl90eF9xdWV1ZSAqdGFyZ2V0Ow0KPiA+ID4gKyAgICAgICAgICAgICBzdHJ1Y3QgaWRwZl90eF9x
dWV1ZSAqdGFyZ2V0ID0gTlVMTDsNCj4gPiBMaW51eCBrZXJuZWwgaXMgYWdhaW5zdCBwcmVtYXR1
cmUgaW5pdGlhbGl6YXRpb24ganVzdCB0byBzaWxlbmNlIGENCj4gY29tcGlsZXIuDQo+ID4gVGhl
IHRhcmdldCB2YXJpYWJsZSBpcyBkZXJlZmVyZW5jZWQgYXQgaWRwZl9xdWV1ZV9jbGVhcihTV19N
QVJLRVIsDQo+ID4gdGFyZ2V0KSkgYnV0IGNhbiByZW1haW4gdW5pbml0aWFsaXplZCBpZiBleGVj
dXRpb24ganVtcHMgdG8gdGhlDQo+IG5leHQ6DQo+ID4gbGFiZWwgdmlhIGEgZ290byBiZWZvcmUg
dGFyZ2V0IGlzIGFzc2lnbmVkLg0KPiA+IElzbid0IGl0Pw0KPiA+DQo+ID4gVGhhdCBpcyBjb3Jy
ZWN0LiBXaGVuIHRoZSBmb2xsb3dpbmcgaWYgc3RhdGVtZW50IChsaW5lIDIzNDEtMjM0MykNCj4g
ZXZhbHVhdGVzIHRvIHRydWU6DQo+ID4NCj4gPg0KPiA+DQo+ID4gICBpZiAoRklFTERfR0VUKElE
UEZfVFhEX0NPTVBMUV9DT01QTF9UWVBFX00sIGN0eXBlX2dlbikgIT0NCj4gPiAgICBJRFBGX1RY
RF9DT01QTFRfU1dfTUFSS0VSKQ0KPiA+ICAgICBnb3RvIG5leHQ7DQo+ID4NCj4gPg0KPiA+DQo+
ID4gVGhlbiB0aGUgaW5pdGlhbGl6YXRpb24gYXQgbGluZSAyMzQ2Og0KPiA+DQo+ID4NCj4gPg0K
PiA+ICAgdGFyZ2V0ID0gY29tcGxxLT50eHFfZ3JwLT50eHFzW2lkXTsNCj4gPg0KPiA+DQo+ID4N
Cj4gPiB3b3VsZCBiZSBza2lwcGVkLCBtYWtpbmcgInRhcmdldCIgdW5pbml0aWFsaXplZC4NCj4g
Pg0KPiA+DQo+ID4NCj4gPiBUaGVyZWZvcmUsIGluIHRoaXMgcGF0Y2gsIEkgbmVlZCB0byBpbml0
aWFsaXplICJ0YXJnZXQiIHRvIE5VTEwuDQo+ID4NCj4gPg0KPiA+DQo+ID4gVGhlIOKAmE5VTEzi
gJkgdGFyZ2V0IHZhcmlhYmxlIGNhbiBiZSBkZXJlZmVyZW5jZWQgYXQNCj4gaWRwZl9xdWV1ZV9j
bGVhcihTV19NQVJLRVIsIHRhcmdldCkpLCBpc27igJl0IGl0Pw0KPiANCj4gVGhhdCB3b3VsZCBu
b3QgYmUgcG9zc2libGUsIGJlY2F1c2UgcmlnaHQgYmVmb3JlDQo+ICJpZHBmX3F1ZXVlX2NsZWFy
KFNXX01BUktFUiwgdGFyZ2V0KSkiLCAidGFyZ2V0Ig0KPiBpcyBpbml0aWFsaXplZCB0byAiY29t
cGxxLT50eHFfZ3JwLT50eHFzW2lkXSI6DQo+IA0KPiAgIGlmIChGSUVMRF9HRVQoSURQRl9UWERf
Q09NUExRX0NPTVBMX1RZUEVfTSwgY3R5cGVfZ2VuKSAhPQ0KPiAgICAgSURQRl9UWERfQ09NUExU
X1NXX01BUktFUikNCj4gICAgIGdvdG8gbmV4dDsNCj4gDQo+ICAgaWQgPSBGSUVMRF9HRVQoSURQ
Rl9UWERfQ09NUExRX1FJRF9NLCBjdHlwZV9nZW4pOw0KPiAgIHRhcmdldCA9IGNvbXBscS0+dHhx
X2dycC0+dHhxc1tpZF07DQo+IA0KPiAgIGlkcGZfcXVldWVfY2xlYXIoU1dfTUFSS0VSLCB0YXJn
ZXQpOw0KPiANCj4gInRhcmdldCIgb25seSByZW1haW5zIHVuaW5pdGlhbGl6ZWQgaWYgdGhlIGlm
IHN0YXRlbWVudCBhYm92ZQ0KPiBldmFsdWF0ZXMgdG8gdHJ1ZSBhbmQgc2tpcHMgdGhlIGluaXRp
YWxpemF0aW9uLg0KPiANCj4gPg0KPiA+DQo+ID4NCj4gPg0KPiA+DQo+ID4NCj4gPiA+ICAgICAg
ICAgICAgICAgdTMyIGN0eXBlX2dlbiwgaWQ7DQo+ID4gPg0KPiA+ID4gICAgICAgICAgICAgICB0
eF9kZXNjID0gZmxvdyA/ICZjb21wbHEtPmNvbXBbbnRjXS5jb21tb24gOg0KPiA+ID4gQEAgLTIz
NDYsMTQgKzIzNDYsMTQgQEAgdm9pZA0KPiA+ID4gaWRwZl93YWl0X2Zvcl9zd19tYXJrZXJfY29t
cGxldGlvbihjb25zdA0KPiA+ID4gc3RydWN0IGlkcGZfdHhfcXVldWUgKnR4cSkNCj4gPiA+ICAg
ICAgICAgICAgICAgdGFyZ2V0ID0gY29tcGxxLT50eHFfZ3JwLT50eHFzW2lkXTsNCj4gPiA+DQo+
ID4gPiAgICAgICAgICAgICAgIGlkcGZfcXVldWVfY2xlYXIoU1dfTUFSS0VSLCB0YXJnZXQpOw0K
PiA+ID4gLSAgICAgICAgICAgICBpZiAodGFyZ2V0ID09IHR4cSkNCj4gPiA+IC0gICAgICAgICAg
ICAgICAgICAgICBicmVhazsNCj4gPiA+DQo+ID4gPiAgbmV4dDoNCj4gPiA+ICAgICAgICAgICAg
ICAgaWYgKHVubGlrZWx5KCsrbnRjID09IGNvbXBscS0+ZGVzY19jb3VudCkpIHsNCj4gPiA+ICAg
ICAgICAgICAgICAgICAgICAgICBudGMgPSAwOw0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAg
IGdlbl9mbGFnID0gIWdlbl9mbGFnOw0KPiA+ID4gICAgICAgICAgICAgICB9DQo+ID4gPiArICAg
ICAgICAgICAgIGlmICh0YXJnZXQgPT0gdHhxKQ0KPiA+IEFyZSB0b3Ugc3VyZSB0aGF0IGluY3Jl
bWVudGVkIG50YyB2YWx1ZSBpcyBldmVyIHdyaXR0ZW4gYmFjayB0bw0KPiBjb21wbHEtPm5leHRf
dG9fY2xlYW4/DQo+ID4NCj4gPg0KPiA+DQo+ID4gWWVzLCB0aGUgdmFsdWUgb2YgIm50YyIgaXMg
d3JpdHRlbiBiYWNrIHRvICJjb21wbHEtPm5leHRfdG9fY2xlYW4iDQo+IGF0DQo+ID4gdGhlIGVu
ZCBvZiB0aGUgZnVuY3Rpb24NCj4gPg0KPiA+ICAoYXQgbGluZSAyMzYwKToNCj4gPg0KPiA+DQo+
ID4NCj4gPiAgIGNvbXBscS0+bmV4dF90b19jbGVhbiA9IG50YzsNCj4gPg0KPiA+IFRoYW5rIHlv
dSwgSSBkb27igJl0IHNlZSBpdCBmcm9tIHRoZSBwYXRjaC4NCj4gPg0KPiA+DQo+ID4NCj4gPg0K
PiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ID4gICAgICAgfSB3aGlsZSAo
dGltZV9iZWZvcmUoamlmZmllcywgdGltZW91dCkpOw0KPiA+ID4NCj4gPiA+ICAgICAgIGlkcGZf
cXVldWVfYXNzaWduKEdFTl9DSEssIGNvbXBscSwgZ2VuX2ZsYWcpOw0KPiA+ID4gLS0NCj4gPiA+
IDIuNTIuMC4zNTEuZ2JlODRlZWQ3OWUtZ29vZw0KDQpUaGFuayB5b3UgZm9yIHRoZSBjbGFyaWZp
Y2F0aW9ucw0KUmV2aWV3ZWQtYnk6IEFsZWtzYW5kciBMb2t0aW9ub3YgPGFsZWtzYW5kci5sb2t0
aW9ub3ZAaW50ZWwuY29tPg0K

