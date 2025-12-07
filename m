Return-Path: <netdev+bounces-243936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F03CAB262
	for <lists+netdev@lfdr.de>; Sun, 07 Dec 2025 08:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA5963008D47
	for <lists+netdev@lfdr.de>; Sun,  7 Dec 2025 07:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EAC2D3A94;
	Sun,  7 Dec 2025 07:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fldTghTd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498081684A4;
	Sun,  7 Dec 2025 07:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765091581; cv=fail; b=PoF4gOlIDEh5FSB9KlFWl+jwODBYbUOPm2HGAbThS1BBetUxRKUD/WMIGvnDScuUR1YXhP7KSe0OK1MjYIt7fp6O0DCpVbvXyrR0L4fTqXPIAT6dEtxNleB5oC2ELKTZWKz+L/emfDCuHTdtqYDKD8QvgmqZnHXVvHLa4Zfjtps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765091581; c=relaxed/simple;
	bh=6IcLZIatjrEkuxjt7AmYmp292YELBvKd9sw5JrKcF4k=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=aNcAVTGrR6UGBKeGQvYhhSGpUscDtp7S3SVRQYrbi7yZX0jmBb71uOKlHCQtckhUi9zTFwCYYELRDiJ6wmRODgF5NGEzzPVnGH979RDixZoHoWokDgGfMUK6C/tRwAhz/yOC9Ko8WQujAglCDXUPS3DajsSHaWMF6JU8p4UPkZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fldTghTd; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765091579; x=1796627579;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=6IcLZIatjrEkuxjt7AmYmp292YELBvKd9sw5JrKcF4k=;
  b=fldTghTdvbbn1CeijizRRXl8szNG8JgM78SFGXMEtQli7nnm2gJfsN6n
   pPZ7hxiRiju+tI/pRzdf1WC3josFmeQmwJ8H0w34vPGBJPmbgAux1k7MU
   9aSF39NmikLI/bzEXMDtV2Sc6xcoP0W3031Y6HJ7p50q+p+9CY0gMsvTB
   xEBMJ2XAN7vOs2nXAYmzvhrkcTnID3IAdOn0FQWC44boOabok0eF/pBek
   q9m/LMG1qH6gDHIhXqi7ucK6VZjKqm/zNLDBtq/IvmjtpXdm3/+sMR/3m
   +F4D1kBgoS/DGgYt4gCAJqR3JUfgVDvQ0xltfM2IjGiJniYvIAFX22TgG
   g==;
X-CSE-ConnectionGUID: Df31d5kERDWI6BZNupJwdQ==
X-CSE-MsgGUID: MTzBQa0xSGSM4ZvDjuHaCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11634"; a="78424483"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="78424483"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2025 23:12:58 -0800
X-CSE-ConnectionGUID: 5MV5oQE8TZiHzYY1GtkkEw==
X-CSE-MsgGUID: F3NsisLvR4+Ys42qdVaC5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="226663046"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2025 23:12:58 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sat, 6 Dec 2025 23:12:58 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Sat, 6 Dec 2025 23:12:58 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.15) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sat, 6 Dec 2025 23:12:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPhoj9csn/M1OZODDF+io03oE4Lj0H40tuJeW6B2pHxTAx5nljxjIeztTMy3J0qzyAJ3skA0WOEe/vI8YPMOALQfF1GqBskKUr5bUZVivZdUUgFz+TCK1jYl4Z8Ns3MRphMLTlD4eGrJDI6afVjDmm3+66x/tiOrkQ7BIX63mRuZ/UPVCpGSs4NV4Onp4VWNaDTzcM4aX5eSlSb3cIOAXkcmyFers7fd72v68UZq10qFOUM9C1gCws63d7HEXjpBafd3RQT/ZP8qCKYZp87XtXsGOMbmR9jhEckSEpTVSlsKhzqjZ+jm7qJTtpFWeBt0wIZs61aFclMf0zpeWoU4zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLvsgOvI0TF/rZpa4oGWlz8LYe1PNdiKuYYhXimRnww=;
 b=hFCIloIlaQd+U9/sqw5yV7aGaIMjBe1c/JFKN9a3iUhqud3cWT4pVJm5gBWmNs9zzyhZJflG5GrFAsjJ0ZRtidlADfM78TsD0royPah31cP6jpXaMHD0Ex2vxawGNVy4pO0sbdcem0Dc7qjdz4zlVo3ggoS1uMG6lzoXCtloHkE0CdfssICxZuNt1VsPpypUBO3jszq+j/mmxZvE7SmMerLomLJjEHuMSKZ1N1O5YTMYZOl3oO8eEURrGRWlB5nQD1+N9LOuwJYcSXje5pfga2uvPyIrc923MlzkLE8QAkFyrK09sYcQaQYM+tFTWzgmeKNv1ueSDXj8+n6NjJ4mRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA3PR11MB8988.namprd11.prod.outlook.com (2603:10b6:208:57d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.13; Sun, 7 Dec
 2025 07:12:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9388.012; Sun, 7 Dec 2025
 07:12:50 +0000
From: <dan.j.williams@intel.com>
Date: Sat, 6 Dec 2025 23:12:46 -0800
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Message-ID: <693528eea6f84_1e021009b@dwillia2-mobl4.notmuch>
In-Reply-To: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
References: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
Subject: Re: [PATCH v22 00/25] Type2 device basic support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR07CA0106.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::47) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA3PR11MB8988:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a52f97d-8fd6-4585-4935-08de356007fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OCs0Q3JKY2pNckNFREZVSTZEZ09XZmU0Nk9ISmdkWGkxNjd1MHpCNERES2J0?=
 =?utf-8?B?eFRDNDBzbDd1cE9xNlBsWEdWUWVPb3JZREJOWS9BekNqZ0w2M0NtRE9mdXdy?=
 =?utf-8?B?TXhsd2hQRUx0TWxUYkpKYUo1NjRRS1JVb3VybWxiZ0JqamZQZ3VsK0tPanN2?=
 =?utf-8?B?V1ZGRmdVWjhrcG80ZkN2SEl1N0FoaUJhZkt5d2I4MjFEcnlzVE1MUDlMeUlJ?=
 =?utf-8?B?UlNuZnJNUUdEV3lNK2ZIU2pKVS90ek5lNkcvRS9JcWlqK3JwWkpBSmE0QW1r?=
 =?utf-8?B?RDBXdGlDUlArL2F6OVVxdGRKOHorY3JlcE8yNmlpSzI5TkloN2J3dm1DYVEv?=
 =?utf-8?B?YjFRSXVTcnpwV1IwcmF2cTFsTjFsWlVqMDhPV0k5cWtmZk9jRlZPb2ZNR0Jo?=
 =?utf-8?B?VTVJcEcxY0dXckxya0M1VlFhamFUSXd2OE1qYjU1TEovSUxwVzRZclRwdHoy?=
 =?utf-8?B?MlJydGV2TVc5UGkvZE9wRVdmekVrQmxDalduc0NndktlTjR2QnlXSGZDbjBB?=
 =?utf-8?B?NWhLWlh1TkIxbmk1MFhLZ0dQOWFUSlpGQXFLa1JUZHJYZUhOSXZuR3orTnlK?=
 =?utf-8?B?cmZVeGM1akJqTjlLWHQwKzRNdGNhRktUdkNOVnBhUjdPa3RlWFJYVXlydDJz?=
 =?utf-8?B?MXhWNld4TFUyMC9JeXptZ055WGJtRXhqK0NNL2ZMV04rZ1hPSkZjRjhZSzRN?=
 =?utf-8?B?djdXd2tKQkNieDdaMHdwZXpZTkF0ZTZ4NHZmSnNJdUNNWGY5ZzgyVzhsVmh2?=
 =?utf-8?B?Wlp6V1phK2N4QVRoVXI4TVNpeWNHcFg0TUxqbGRlVEJKNlN1a1MwSWVqRmx3?=
 =?utf-8?B?MlVvU0VDdTZtWVBPL2VVZmtxcDljT3RiTjRBcVVHc0VkUFpLeVdQYzhpTUow?=
 =?utf-8?B?TEhwQktuRmVNUmQ3a1ZNWlM2cWdvcE1VempKZkhhL1pGTUpvNGx6MHFrMDMz?=
 =?utf-8?B?NU1Xdzc3QURnVGM2d1RYZ2MwZ0w3VG5wUVhtbmZ2U3NKYktFSE5lNmhCR09P?=
 =?utf-8?B?UUFzT05YalJZUlkxNW8yUlRmcEF4YlBsNjJ6QW1oc25FamZtUGxvenpVaFFW?=
 =?utf-8?B?dWh3S0xQYVU3QjhqTVpLQXVCNjRsNEtvQUdxcEhiU3dxbmVzbUt6TVc0Ti8x?=
 =?utf-8?B?S2ppT3FxNDZCcG9oUStkQ1JDa2pXZjI4UDAzbUZIbXJ4b0kwemdCeVo0VldY?=
 =?utf-8?B?ZUNuOHdaNDJ5bmU5bWtBZ2lBb3MvR2pzU1pZY1dmaEYzTjVNaFBUVUl2Zkh3?=
 =?utf-8?B?MUFZcGZGK0c2VHpINHZueEY2ZW8vNVBMdS92QnJNTnZoRW9jRWxzbTI2cS9T?=
 =?utf-8?B?UUFBU0NqbEJaNmoreStRcjZEMUhhbkJtRXcrdXZDeS9kRS95c3Iwd002dHNM?=
 =?utf-8?B?dlhsQWh1SHVRc1gyS2pUTnRnbXFNdkRrLzhneDNtSXg0NnE1WUpDT0gvMEFE?=
 =?utf-8?B?Sjh2S29jSVRSTVZGdVFKTmxaaWNTSFc1UkJCcVhnQWt1VmEvNXdrMDNFdTE1?=
 =?utf-8?B?eFdTYzdRdGw5Zm5OTzFRVGZrT0xKWXNEdTA3WmsvTEJWdnV2ZHNRWXBraEhK?=
 =?utf-8?B?aTVuUk5DNG1tOGxwTkordUREK2lDWjF5QnBNNXM5MVlhblhiOW1iNGtkZHlF?=
 =?utf-8?B?OVRXUWRuWHVRcGdsdktjSU9jb1plc2k3TDFIemQ4WEpwWWlWUE9sQzBmWmFR?=
 =?utf-8?B?NHhFMzROVzNLYzk3UElieUU3WE4vOHU5c0x1d1VtT0k5dHdVNzNkU2Y3VS94?=
 =?utf-8?B?akFIcXlFUUd1ZHZkMUIyazZ3UDdHRXl3L1Y5aEhXQWRmNTVOdkwzV01HRDhF?=
 =?utf-8?B?YndKU1VlNkg1OU9zc2QyMWQycGRWQnduV09MaDc4U1pJQkkyblBZVjY1Mjli?=
 =?utf-8?B?QXlDYVIxd2VwQW1CV3F0Z2hEMWx4bTljanJoc2FJMlQ2OXE0bFo5VFh4Ni9l?=
 =?utf-8?B?cDljZENBMzNsdzBzWVh4K3NqVzVYZ1lRc0NmR2V6Q01uRlo1bUgxeUVYamJk?=
 =?utf-8?B?MzJvdVM4eXArY05scTZPazFFU2JLZUFxUTlGb2c4V0JLamxqVVdnelpjVjJO?=
 =?utf-8?Q?OrJEJx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2dZMStqVnJpMDFNRC9EdGtUNnBuTVV6R0dEQ1dFNm5aRmZVNWVMam83c3p4?=
 =?utf-8?B?UVJJaXlBdjBnSXFkVTNobk93VENqYndsNXpkV0RHZVUrV3Y0Z3VROGxNTWhI?=
 =?utf-8?B?eXNqQjI1aEp6dkJUS0ZYNjdFSHNDUUFSZnRsQ0h3R3pVSDJBb2VSTnVUVkY2?=
 =?utf-8?B?T0NNTDduTExobW9Ccyt1WlJlV0RaK1FVUEFEL1VoRUxCU1R5RWppeEtwN3da?=
 =?utf-8?B?eUxkaXhjSG45S3BlcHVDcm43UHU1ZmdQczF2dlRZQzFQeW4vaFJpSE85K2hH?=
 =?utf-8?B?WFJ2TmxEMGVadzB2NXdoczB3cU92MGxxWngrWlNKZmM3am00S0JoVWovb3Zi?=
 =?utf-8?B?Q052eHNJcDV2cHU3bHhSNDVYeVNwOGhBVkxGOGthbmdNQVpIZ1FxVEMybU8y?=
 =?utf-8?B?N2FoUmJCQi9hd1NWeUNuS0xkZ2dUam56OENpUDY2TkZQc3BCSThRSkszRVJP?=
 =?utf-8?B?dS92VjVNTEswK2M4eUloYzRKUWlQMlJXeExWRWpycjNPODk1RW9MVUpkRk5p?=
 =?utf-8?B?cXN1SXlwbkZ3Q0E2OS9vQmsrajUydFJ2MWR1RzY3bzM3Qkh0OFprK0Jub0Jt?=
 =?utf-8?B?d2doTkk2c1luMmFlYlNtdmErb1ZkUDVvaGg5NlFGRUVCc0t2ZmUxTzl2VkMz?=
 =?utf-8?B?ZDZDTVVlRHU3M2cyZHFZd2ppOGpwZWJabnMrd1d4WGsrclEwdnc4ay9xWVpY?=
 =?utf-8?B?bVZuOE9NUHF5K0NFelhsYTVlM0hxUjMvRUFDSjk4c0FMakhPbmxDUytRNXBt?=
 =?utf-8?B?VDVLM0wzNERsZ2pKZXhyMnFwNy90MitPT0lWTDVKN0puVXRSS1hmdW1FNnVl?=
 =?utf-8?B?QUdzUlBjUzZZb3JEdy9BRkErb25zdnIzVnZnT0dkcDA1UjNHNFhzZlZpSnZI?=
 =?utf-8?B?OTdMbWZOdmxPOEJrV0ZsY3JEbXJObFNCMGEvUjMvNWlMV25iS2hvZ3BQTzIx?=
 =?utf-8?B?azk0THg5WXdRN21tcEZXaGtheE9YREtyMTNrQUNsR2ZZYUJwUjdtVTNaRWlw?=
 =?utf-8?B?SzZJVy9XRTJZbG0rQzhDVkFpVnpaV0hVbFE4UEwwRHRmOS9jSTNreDRGc2JN?=
 =?utf-8?B?RGJ4bmJQUFc0T0VvTWIzdTFTZ01xU2hBWkx6dURtS1RaUmxtdmlsKy8xSWpE?=
 =?utf-8?B?RnprbXduNHZYb0JiMXB6b1NPVU9xamt1OUVoSDU0UTBLQ2NFa29paWZkV05Q?=
 =?utf-8?B?TjFEeitZUkZNRklNc2EvU291cHJ6NnNiWkp3czZGU052SVEvSzlYY1M1c2R2?=
 =?utf-8?B?d3k0VlFEVXNjZUZ1aXRaNm5tVDBTY1Mrdyt0YkJUTjVYM3p5L3ZPWHBGSE4y?=
 =?utf-8?B?VVl6bFZhVUVBUXBNTlZSMFdZaDdIQVJlVVZzdzI3UmtYVmsySXlwa3VnWDdo?=
 =?utf-8?B?STZZUlIxdEpxWU1hRWJuY2FFVU1uU25zVElvYjRCM2N1WjhZcUYvOE1Zdk94?=
 =?utf-8?B?WE9sUSttaVRoQTBsVzNCaStqSW9CVlk4anR5Qk9RblB5ZDRLbHU3TkNVbkpO?=
 =?utf-8?B?aFlwRDlmR25JS1pEM1VwMTlObVdxMjdKMXgrSTZmTi83QVdTVFVVbWF3dWY0?=
 =?utf-8?B?cnJTK1hVVEJHT202di9xcVFucmFwRUxBR3Z3WU9sWHd4RkRGdzg5QlljYkpv?=
 =?utf-8?B?SjVVWjBNUlptTE1qdzVZNVRZd0IvNmpzQ3pwTXorTHdXYnNDaGk3UmVybXRx?=
 =?utf-8?B?ajlFM2x6YnV2VmFONElxV0tqY0hIaytnUjlBdHZuRUhXM1ZGMW1BaGJJZ2l1?=
 =?utf-8?B?OFoxZTlkc3RTeGNNTmozcUxJUnVBaTBaRUJpTEdxMDVBK21CK1l4ZWd2YUxr?=
 =?utf-8?B?VzBVWjhQeXVreC9qSEZaTys1OW04VVNyMlJIVjltcThDRzdqRTBIZFpYYnBn?=
 =?utf-8?B?bFZvTHlEN0o2RVVSRGoveEduQm5WVUNHanJqTXNiR0Nyb25mN0RVNVBKWXQ4?=
 =?utf-8?B?SmNheGVJYUt1b0V5a1c4ejRGelB0MHU5LzZ6SFBNcThhc0w3bnZScHBaeU5m?=
 =?utf-8?B?QXdIWlMrbUJ0emkzTk5YWURjSXE5VjR2NVA1M2twbmJZMG1PVzVpRE02OVRq?=
 =?utf-8?B?RzVJMWhvNDErNy80NGJoMHFROU5RZjQrQkxuK0hJai91cklsdE5KOWN3c09r?=
 =?utf-8?B?dE9sSzZrY0wyRzhlNDNNZ0pvUDZlRGtXR1JDV1p4SS9DbzdSV1pyYjMvNnlF?=
 =?utf-8?B?THc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a52f97d-8fd6-4585-4935-08de356007fd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2025 07:12:50.3906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZcMxJ0RA8q5EExnTtkiKbk5pnRXmpiU8bBSqx5FzocmTVXTy1L1SSUeDNWjO0n5ugYVXiKYBpIdMtXXS+XFoyw4fUGez+6WeDXGt0hTxCpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8988
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
>=20
> The patchset should be applied on the described base commit then applying
> Terry's v13 about CXL error handling. The first 3 patches come from Dan's
> for-6.18/cxl-probe-order branch with minor modifications.
>=20
> This last version introduces support for Type2 decoder committed by
> firmware, implying CXL region automatically created during memdev
> initialization. New patches 11, 13 and 14 show this new core support
> with the sfc driver using it.

"Using" in what aspect? Does your test platform auto-create Type-2
regions? I know that is expected on the platforms PJ is using, but I
want to get a sense of what is the highest priority for Linux to address
first.

My sense, from the trouble PJ has been having, is that regions committed
by firmware is a higher priority than driver created regions.  Yes, the
subsystem will support both in the end, but in terms of staging this set
incrementally, I think we probably want to review one mode at a time.

> This driver has also support for the
> option used until today, where HDM decoders not committed. This is true
> under certain scenarios and also after the driver has been unload. This
> brings up the question if such firmware committer decoder should be
> reset at driver unload, assuming no locked HDM what this patchset does
> not support.

This question is asked and answered in Smita's Soft Reserve Recovery
effort. See this discussion [1]:

[1]:
http://lore.kernel.org/6930dacd6510f_198110020@dwillia2-mobl4.notmuch

The quick summary is that regions and decoders alive before the expander
or accelerator driver loaded should stay alive after the driver is
unloaded. Only explicit userspace driven de-commit can convert firmware
established regions back to driver established regions.

> v22 changes:
>=20
>   patch 1-3 from Dan's branch without any changes.

Note for others following along, I am deleting that RFC branch in favor
of formal patches here [2].

[2]: http://lore.kernel.org/20251204022136.2573521-1-dan.j.williams@intel.c=
om

The expectation is use that set to finish Smita's series [3]. Then
finalize the port and error handling rework's in Terry's (which will end
up removing mapped CXL component registers from 'struct cxl_dev_state),
and then queue this series on top.

[3]: http://lore.kernel.org/20251120031925.87762-1-Smita.KoralahalliChannab=
asappa@amd.com

>   patch 11: new
>  =20
>   patch 12: moved here from v21 patch 22
>=20
>   patch 13-14: new
>=20
>   patch 23: move check ahead of type3 only checks
>=20
>   All patches with sfc changes adapted to support both options.

Going forward the log of old changes can be replaced with a link to the
N-1 posting.

Given the backlog of the Soft Reserve Recovery, CXL Protocol Error
Handling, and this Accelerator series I want to see some of these
precursor patches land on a topic branch before moving on to dealing
with the full accelerator set. I.e. I think we are at the point where
this can stop posting on moving baselines and focus on getting the the
dependencies into a topic branch in cxl.git.

[..]

How much of the changelog below is still relevant. It still talks about
the original RFC. Might it need a refresh given current learnings and
the passage of time? For example, no need to talk about CXL.cache, first
things first, just get non-cxl_pci based CXL.mem going.

> v2 changes:
>=20
> I have removed the introduction about the concerns with BIOS/UEFI after t=
he
> discussion leading to confirm the need of the functionality implemented, =
at
> least is some scenarios.
>=20
> There are two main changes from the RFC:
>=20
> 1) Following concerns about drivers using CXL core without restrictions, =
the CXL
> struct to work with is opaque to those drivers, therefore functions are
> implemented for modifying or reading those structs indirectly.
>=20
> 2) The driver for using the added functionality is not a test driver but =
a real
> one: the SFC ethernet network driver. It uses the CXL region mapped for P=
IO
> buffers instead of regions inside PCIe BARs.
>=20
> RFC:
>=20
> Current CXL kernel code is focused on supporting Type3 CXL devices, aka m=
emory
> expanders. Type2 CXL devices, aka device accelerators, share some functio=
nalities
> but require some special handling.
>=20
> First of all, Type2 are by definition specific to drivers doing something=
 and not just
> a memory expander, so it is expected to work with the CXL specifics. This=
 implies the CXL
> setup needs to be done by such a driver instead of by a generic CXL PCI d=
river
> as for memory expanders. Most of such setup needs to use current CXL core=
 code
> and therefore needs to be accessible to those vendor drivers. This is acc=
omplished
> exporting opaque CXL structs and adding and exporting functions for worki=
ng with
> those structs indirectly.
>=20
> Some of the patches are based on a patchset sent by Dan Williams [1] whic=
h was just
> partially integrated, most related to making things ready for Type2 but n=
one
> related to specific Type2 support. Those patches based on Dan=C2=B4s work=
 have Dan=C2=B4s
> signing as co-developer, and a link to the original patch.
>=20
> A final note about CXL.cache is needed. This patchset does not cover it a=
t all,
> although the emulated Type2 device advertises it. From the kernel point o=
f view
> supporting CXL.cache will imply to be sure the CXL path supports what the=
 Type2
> device needs. A device accelerator will likely be connected to a Root Swi=
tch,
> but other configurations can not be discarded. Therefore the kernel will =
need to
> check not just HPA, DPA, interleave and granularity, but also the availab=
le
> CXL.cache support and resources in each switch in the CXL path to the Typ=
e2
> device. I expect to contribute to this support in the following months, a=
nd
> it would be good to discuss about it when possible.
>=20
> [1] https://lore.kernel.org/linux-cxl/98b1f61a-e6c2-71d4-c368-50d958501b0=
c@intel.com/T/
>=20
[..]=

