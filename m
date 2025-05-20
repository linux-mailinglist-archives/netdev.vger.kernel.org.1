Return-Path: <netdev+bounces-191740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96615ABD024
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 09:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CD031897BC2
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 07:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF9A155335;
	Tue, 20 May 2025 07:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SlhBvQdy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C8FEEC8;
	Tue, 20 May 2025 07:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747725430; cv=fail; b=XNYj3LHI6eOpYZ8/Us0osnodU2PiE1EkAm5gZWjAMTT8vurfo8FgUTrOnDmN5Hmo7NCrptQmVP2aIbGJ+mB5934oGxl4UlqArWRSAe03Q9qcttS6+DsUWl/kQ+BtI9ay3RgKH2BBUS8w9M+mP7tZRTjbe9YWq1PvsNzkZZfuurg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747725430; c=relaxed/simple;
	bh=YYS/EJo0/VGfnsLDCywM0d1kvT3MCR7Y3knlPf9cZQE=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=tTXYvqhLTB30/Zrejz6kZLBB8SetZ15ycJLYnN1dP/NmeXNFim65KZ+VH3E/AtCJCLP981lf+VeTGyiAw9hHYS5bjryC+R+9XGyxVTM+t1N1NuHZaXZCI6h1obCcvSCczVYOKRtzcMda3/AKfoOUJKnBtcsN6igym0N/tq9ofL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SlhBvQdy; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747725429; x=1779261429;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=YYS/EJo0/VGfnsLDCywM0d1kvT3MCR7Y3knlPf9cZQE=;
  b=SlhBvQdyhcLGQpYu17KIRmOkzIFhs+wU/f8X4sltCvDEgVtRFx/QghlW
   rpZOYtjGwyAcUEjSdK5u39m7LM9a7zzS2OQOflJxhKtZDTbB1m125KxdD
   K86ZR5CSxj7bgVKapF/pm+1KlpueeV1RKvhI9oBkpEhNt0UQg6fE1VPGX
   lRbX/PwmWGjIs7CzZHYc6/h2u8zykj+/3kXodz+eR2dR5Jb2s9/vM7AyU
   6lz1EHzMItrVf1iCcTnd1rbpYaP57Vn2ExTYzAvzbgxek72PCpUkB6Tqp
   ozKH5bRCAI8oZjuF/iwaAhPvdv05QMjCyE6N2TU1ON+W+T4W5cnyu/UvZ
   g==;
X-CSE-ConnectionGUID: TyQqmLYUSsuRuXUSUSvmQA==
X-CSE-MsgGUID: Gpttox1oT4mTrx+90Hjbhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="60280648"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="60280648"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 00:17:08 -0700
X-CSE-ConnectionGUID: YqHaqu/iSLq/tOHrrwv/rA==
X-CSE-MsgGUID: djpnSVNDStqSvcPi/fIIYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="144860137"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 00:17:07 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 20 May 2025 00:17:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 20 May 2025 00:17:07 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 20 May 2025 00:17:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eUaGaf5UKS3R9WBNCqj+bogEj1RF54bFx4DVuzIlZTB+4y7KVBZ/HKHelIPu53gL1W9C6xlJEOv7lA1QQnZyZEK0GoC+PasTbyrCiGWvv/OnJStwYmBeewauC1DFhaUrkYbrrMqktT9BYcX6gGY+B+prAAhNQ4rHXigC2PYJuKAVQz93jnxncfmsOh7oxcWka6+pLxQASjiI5L7LTlBFLZVuMCONyre8XcD0v5CXRO74HURYOA3JpaBjCebrk9+HIqf9aDEls8hKT5Pl1H80Yjm8h8oIJjhKBihruMcmlMToSKgTb+47tn5LweKsmMhuL9wBqf5zCVMquaMW09gteg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/aoujLWEIU9Lwu4NeXcih2iWVx5fUXPLRn8QqXIRis=;
 b=EDvDz8wI7/uxVIBmHEZ8peL5r2lOp65GoP+uMMojEwZQatlkSolAq/pWbHOx35EK88sCzUAfm1Wd029K4YMH5VU9PjQVUIAik9OIMAedW/GerxPLQh/qfV6oum3Flvjt98f0EaDX1OpD3DH9ntLYzTGG2Vr+FYNfaLpn1dMZ3IPxzd8PAuky9fgDfJCcylQQX8g9JzZO6ER898JQr0qB0OyxgwsccKF+cjdGHcXqLydirpMLFj1OG0h69RqKApie45IypPqGEyBZPkEZDpQuSm9tKbWxkgnOz6ohBNewPa2ETFxvXItFDQjYRY3hl36qrHRJK/8LoVpfOHDfs6VmQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA3PR11MB9088.namprd11.prod.outlook.com (2603:10b6:208:57a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 07:17:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 07:17:05 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 20 May 2025 00:17:03 -0700
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Message-ID: <682c2c6f8398_2b1610050@dwillia2-mobl4.notmuch>
In-Reply-To: <20250514132743.523469-2-alejandro.lucero-palau@amd.com>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-2-alejandro.lucero-palau@amd.com>
Subject: Re: [PATCH v16 01/22] cxl: Add type2 device basic support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0189.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA3PR11MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c78933d-0810-4ed7-6789-08dd976e52b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dkJhQmJ5MHRORDBCUG5uU2NlUHRBSm5MUHpUVXpFRUpZTHVEbjFzMXpiNnln?=
 =?utf-8?B?UGV3K0k1eHh5dGgzTVM0dFpXWlpKdkRUay9MaU9xVWNtZm90KzZybkRLc0Ez?=
 =?utf-8?B?SEpON2tYUzd0UDUxQnlYTmU4bEszYVVacEdtbnhRaGZpMFdEbklCcWZaMWpj?=
 =?utf-8?B?REVRZkM4SXdwWDhKV3M3YVZEbk1ER1FVNS9MbG1WTHA2UzdDZXBaaG1KMlhQ?=
 =?utf-8?B?dERTdjJzQ1VSMFdyTS9nTmJMcEZGbGJ3T2l0Nkw4dk1HV3FndWY2SlNndW1l?=
 =?utf-8?B?OGZqczk5c29OT28wa3VtUHA0RHRTUG53Z0dwMWFjcjdhSi9ndEcySWUydzZU?=
 =?utf-8?B?eENFRDVscmwyVmJhVGQ0ejlLZ1QxT3Nrb0doaDlqVHo1ZXRtb29uRk5jRVV2?=
 =?utf-8?B?ZzRCTW5KWDRJd1ZOQzlNZDVxNFovVzhiMDYxaXNKcStaMm81QlM1MzJuWUhY?=
 =?utf-8?B?ZFN3QlFpVGhSQUNBZG9uN3NkRDU5WDAwQjlnUlFrQ0ZpZFVYK29RMVRJVlJB?=
 =?utf-8?B?NFVEOFo5dlBrSndQK2tNYnN1cytwVXlJc0hWSmFpb1QrUi9OUkFWd0ZQTytv?=
 =?utf-8?B?Qk1TdUFTcDRXTGNFdm53OWxtVWRTcFc5ZGhqSzVldVBQNXI2YklOUkZDMVdS?=
 =?utf-8?B?Sk05cDF1NU1NajVua2JPeXlUbldKNERPRGpQd2ttUU1OaFN2Tnk2TG9qbDlU?=
 =?utf-8?B?bS9KeEg1Uk9EM3pINTdkbHNSNFNmVUkvWXNuZTdZTDBzRGM0UXhZeEtNRHBE?=
 =?utf-8?B?VjB3U2Y2eXpEZkZHdzNwSXpQVU1LdEt3eitWNkdEMDlEbHlEdzdGYytnNlQv?=
 =?utf-8?B?T29zRURsNEtqeVpMMHM5MGpHaGNMb0JkcUxZOE5xeHdvZGpLRlRJaDhnQkhm?=
 =?utf-8?B?bkNIZ2Eybnh2bjhycVhNZXJtdWFTbmNwa2RlQTUvVlovOWFHdmNHbWU4UHlt?=
 =?utf-8?B?MlNoSS9IaXdxQlJQb29xZHpVS1VuNm1Od1k2cjhnQVMvUU9HZWpqaVIvUGdz?=
 =?utf-8?B?TnBDUUpNR1FsNFp4bGJ5TUtvaktwR3RaZUNKVkZGNzlNOGQ3ZkV5SUo0ZEhr?=
 =?utf-8?B?WTVpL3BLWkxkRWFtSGlPb2RGaVB3cnNjeEZIcXhid0Z2Z1lSemZjYm9oREF6?=
 =?utf-8?B?UnBWZ2JXY2hBbTFlMG51Z0ZBclkwVHZ6aFlaQ2Vkb3JBWGlBMERyVGRRTER1?=
 =?utf-8?B?a3NhbExIdkFyN3R2Tk9sdjQ5dFNTdFBYZ012a2VrZUtKU3FBV0hlRTBkSDlH?=
 =?utf-8?B?UzBmeFQ2K0lPbVNzNUxWdlorQThiREJSeVVvZElSNFdiZkVRWFJxNjJHUEdG?=
 =?utf-8?B?YlRyTStRL0JpaWRNeDFJSkhyWDBBMTNzNU5sN0RiMzF1SWY5NHVYSG1qbnBs?=
 =?utf-8?B?Q204S3V0d2ozVWFDT2JicjZaQ2NVbC9pb3RuS1JDSkJ5d1pZRDZzTDRmeGxt?=
 =?utf-8?B?VE12amVNb1dqOFdVV3lUSXhCQkNXN2xsTWd3K1U5dWhqOXA3ai9CWXRXQ2Rz?=
 =?utf-8?B?V2ZaZ2hSNWVHT1pGYXpiTVhOQnBYWlA0dHI5UE1TUy9jWFZDNWliRHY0Z1ZO?=
 =?utf-8?B?TnJmN3pJaU1sZldiUkQzSkhHZmdQSHFETktsNVJmMWZGbUtYTndzRlFKdkFQ?=
 =?utf-8?B?REdQdHhobnhnUkZGWmM0MGhjL1NaUU5qWDIyS2JZRUdiRWh3RkVaK1JjRWpO?=
 =?utf-8?B?TzR5Si9NbjBvRWI3OE1FMWg0R2VlZ3lONGRYUUdHTW9OR2JDby9rREwrckpD?=
 =?utf-8?B?VVV4bFYrWmN5NE5xVnhRRldieWI4OExnUWZjcXFoZHFTSGFtWkFvLy9ncGx4?=
 =?utf-8?B?WnMrK3IrVXJiYWZiS0xtVFUxQ1U1MkVYNVZEbGxhaFExeFhxMU5ZV2NvblpR?=
 =?utf-8?B?ZVJQM1FwM2ZESHJFUjZ0L1g2T1dhS2wrV3ZmSEtQUFdqR1dyZlR6em1DcXN3?=
 =?utf-8?B?Y0l5WXpFalJmd21aVlAyUVExa3VUMmZUWTVIUkNQZVNtRkgwSjJpN3lNcExW?=
 =?utf-8?B?cHhVdTEwTUJnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnVTRzdWRFFPd1orYUlDY3JZNjlmVG5XQStFRGl2MmdWZnlNeTdaT2x2SFVU?=
 =?utf-8?B?S0xtSTlIQU9oV1dxbytvUHdLbUkwSkcvaHVzYkU4N01HaWFTRkFIdGx3aCtI?=
 =?utf-8?B?YlhyUmJwem16bW5CMElNZWZMWkg1ZFVzemVraEIzYlg0K3B0SEFQZkVzQTZD?=
 =?utf-8?B?TEFobGJqVzIyckw0TE42cjRsVjErZHVhcUpMSDBKMU53UHRCOGtXQXBFa0FJ?=
 =?utf-8?B?amYzWGVzUHA4NW9LNzJVak94c2t4US9nQWx4N0VIamxLQWUxZHdrRFd2VkNY?=
 =?utf-8?B?Q3JpZ0c2SHhNMk55ZUFkSFQ4UmdOQXppS0hvZHpRQW5mTG9UTHZsSGREVjVv?=
 =?utf-8?B?NS9STlVWSWZOUUZDY2FlM1FHaTFMR1lxVVU5Mkl0L0tHdTRoMS94SW5lY2dH?=
 =?utf-8?B?RzZOcUVRSzg4VDZyUWZpNEM4Y0g0TDN5YVZSU3Znc041MjlXT0NRaE5Kd2Fl?=
 =?utf-8?B?ZUVlVHBFZHlBSmh1bXZOTUNLT2lUWmhlejBpSmY0ZXRDSjl3N1p1SGg0RmRh?=
 =?utf-8?B?SWRUV2lLYUJ1RENPVVN1bTZSQlZFNzhKczFRZTV2UDFoeDQySFMvSDNWTEVW?=
 =?utf-8?B?TmJiU3E3eW9mUEdUUlFpMm53dFhpd1lFeXFoNUVLKzZUbEpORnFHNWZ0Y0ZX?=
 =?utf-8?B?di81UEpMeGg4WU9UblVpMTVlS28xZ1FWZGlVRm1iaVMxWEJieFYxaUxLd2s0?=
 =?utf-8?B?WWt1bkhMT2E0ZHNkcXlzNXpsNnZhcFo4SzZJQ2hncTlWdjdxYUg4QXowc0I1?=
 =?utf-8?B?emw1V000QTBhamFWYUNYVEVoeDU2Zzg5NWswdTI5Wi9iWHdZYTd5SVd3M1Jr?=
 =?utf-8?B?b0Q4dUVKOXAwRklDVGNRWnVHN3hvblhtdUE2QkQyMmxMV05LaHhEQitTaTZW?=
 =?utf-8?B?YUJ6YkdUSHNhRERkMTluempxL2kxb3VpU1dqa2RwaTZGdVNPcnRITlBMTVk1?=
 =?utf-8?B?RFcrSTdSQWtWdmMvWGlLTlA4RmpGNWRXZkppcVlJVzBXOU1HckI3d2xPVGhz?=
 =?utf-8?B?aEptbzg0QlpzeThZSlRDL3gxVlAva2o0c1J4WmtyMHZvZEJXd3ZRQ1BPVm4r?=
 =?utf-8?B?ajI2OTJNNThxbFhrMzFxVnRIRmhCRGticUQrR1pydzFPaTVmSlZVRE1oMWZZ?=
 =?utf-8?B?NDhCdk1sVE1XN2s0WVFXK0dsdHZISlBEUGRFdDZhVmcrWHRZeHM2cC9oM3lB?=
 =?utf-8?B?NUphUk90WWp2NktrVDh5Zm5ZdXJ0bUxGQklodXkwVUZiaU1LNDBKR2ZtSUs3?=
 =?utf-8?B?V2YzN2ZBSnVnZng3dWI0YXRzV3V6K1F2bGdIVDdxbEZkVXRFQVFRMk9yRDZ6?=
 =?utf-8?B?MFFNdnpObk8zMVB4b2pUWWZ0QTJnbDMwWlFXdEltei9iSk4xTFdHZytIZVFh?=
 =?utf-8?B?bjFjUU4wYi96MXRNTTBmeHJ4OWhtbDRjMG9uakdFc04vdHo2ZzRZOXhsZFhl?=
 =?utf-8?B?SmZZM1ptZHZjZFM4RkJndnpIOXlpNFEzUVF1SnVCNGFnVWxud0dsVnVBMllS?=
 =?utf-8?B?LzVIcGRncGJwL1BWR0RxenhJUVZkY01jVjdwT1dvUGptSWRiNmxMWm5KNWtN?=
 =?utf-8?B?eUZCM1pRMUlBVnlCYnVFeUd2OVdUSUx3MWhNSkZQRHNDcVhhcmxQYml0Wk5z?=
 =?utf-8?B?eDNoZWVub0k4a2ZsbVVvaFI0YzFiNVU5VFBFUVh1dWxZYlE3Uyt6RU9WSytL?=
 =?utf-8?B?K2UraHJYTTZybjBneHE4NTB2WjI0MThXcTJUWjRveFk1SUFsVnp6K1h2N1A5?=
 =?utf-8?B?Y1RhSGt4WHlKT0t6ZkFuTzF3bS9naUF4QXpuR1UvRmxHV1Zjalo3QTRtNCtF?=
 =?utf-8?B?RGxGTjVNZENtRXV3L0cxaXZQWWQwTDdLSGhaOW9uREhFUHBvMGdKSFdvT1Nk?=
 =?utf-8?B?SytPRmdyM0lGWWZ5Rko4TUQxTndnQ0p3WW0xTDQ1dUhadGdxUjdtUTRnb3A2?=
 =?utf-8?B?VEt0YVVnRlhSWVNjcm42ZFlEZ1FJRFdhR3VoWjIzMEp2YUUzeStSZlQySHVi?=
 =?utf-8?B?UDJiZ3NQYXVMK3Jsci9yTktuUi8yQ09GbVkzcU83SWI1bm02WVVIeWhYMEsr?=
 =?utf-8?B?R3ptSHhWZk5mM08zcVF2MFJINWhpVXcyMjdMVC9mQ2dMbGxIbmd1WUpIQjY3?=
 =?utf-8?B?eklvenQ5RVNVU0RYeVl0NjZPbUg4ZFRlM0pUVEUvMHVDdXUwQWxxL3ZXU0J1?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c78933d-0810-4ed7-6789-08dd976e52b6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 07:17:04.9855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fNpIsbweMb1rHphkXrE4iyzJlNFr2tJ5+s4aDrG4gkW9lKsN03NzkXEVQqHT5i4LfMET6zfI02g2vFVlDnZFPt+lNmeLVIevfclqRUk+QXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9088
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Differentiate CXL memory expanders (type 3) from CXL device accelerators
> (type 2) with a new function for initializing cxl_dev_state and a macro
> for helping accel drivers to embed cxl_dev_state inside a private
> struct.
> 
> Move structs to include/cxl as the size of the accel driver private
> struct embedding cxl_dev_state needs to know the size of this struct.
> 
> Use same new initialization with the type3 pci driver.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/mbox.c      |  11 +-
>  drivers/cxl/core/memdev.c    |  32 +++++
>  drivers/cxl/core/pci.c       |   1 +
>  drivers/cxl/core/regs.c      |   1 +
>  drivers/cxl/cxl.h            |  97 +--------------
>  drivers/cxl/cxlmem.h         |  88 +-------------
>  drivers/cxl/cxlpci.h         |  21 ----
>  drivers/cxl/pci.c            |  17 +--
>  include/cxl/cxl.h            | 226 +++++++++++++++++++++++++++++++++++
>  include/cxl/pci.h            |  23 ++++
>  tools/testing/cxl/test/mem.c |   3 +-
>  11 files changed, 305 insertions(+), 215 deletions(-)
>  create mode 100644 include/cxl/cxl.h
>  create mode 100644 include/cxl/pci.h
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index d72764056ce6..ab994d459f46 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1484,23 +1484,20 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mailbox_init, "CXL");
>  
> -struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
> +struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
> +						 u16 dvsec)
>  {
>  	struct cxl_memdev_state *mds;
>  	int rc;
>  
> -	mds = devm_kzalloc(dev, sizeof(*mds), GFP_KERNEL);
> +	mds = cxl_dev_state_create(dev, CXL_DEVTYPE_CLASSMEM, serial, dvsec,
> +				   struct cxl_memdev_state, cxlds, true);

Existing cxl_memdev_state_create() callers expect that any state
allocation is managed by devres.

It is ok to make cxl_memdev_state_create() manually allocate, but then
you still need to take care of existing caller expectations.

>  	if (!mds) {
>  		dev_err(dev, "No memory available\n");
>  		return ERR_PTR(-ENOMEM);
>  	}
>  
>  	mutex_init(&mds->event.log_lock);
> -	mds->cxlds.dev = dev;
> -	mds->cxlds.reg_map.host = dev;
> -	mds->cxlds.cxl_mbox.host = dev;
> -	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
> -	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
>  
>  	rc = devm_cxl_register_mce_notifier(dev, &mds->mce_notifier);

Ugh, but this function is now confused as some resources are devm, and
some are manual alloc. this is a bit of a mess. Like why does this need
to dev_warn() every boot on MCE-less archs like ARM64?

I was trying to keep the incremental fixup small, but this makes it
bigger, and likely means we need to clean this up before this patch.

Ugh2, looks like this current arrangment will cause a NULL pointer
de-reference if an MCE fires between cxl_memdev_state_create() and
devm_cxl_add_memdev().

Ugh3, looks like the MCE is registered once per memdev, but triggers
memory_failure() once per spa match. That really wants to be registered
once per-region.

That whole situation needs a rethink, but for now make the other
cleanups a TODO.

>  	if (rc == -EOPNOTSUPP)
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index a16a5886d40a..6cc732aeb9de 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -633,6 +633,38 @@ static void detach_memdev(struct work_struct *work)
>  
>  static struct lock_class_key cxl_memdev_key;
>  
> +void cxl_dev_state_init(struct cxl_dev_state *cxlds, struct device *dev,
> +			enum cxl_devtype type, u64 serial, u16 dvsec,
> +			bool has_mbox)

As far as I can see this can be static as _cxl_dev_state_create() is the
only caller in this whole series. Fixup included below:

> +{
> +	*cxlds = (struct cxl_dev_state) {
> +		.dev = dev,
> +		.type = type,
> +		.serial = serial,
> +		.cxl_dvsec = dvsec,
> +		.reg_map.host = dev,
> +		.reg_map.resource = CXL_RESOURCE_NONE,
> +	};
> +
> +	if (has_mbox)
> +		cxlds->cxl_mbox.host = dev;
> +}
> +
> +struct cxl_dev_state *_cxl_dev_state_create(struct device *dev,
> +					    enum cxl_devtype type, u64 serial,
> +					    u16 dvsec, size_t size,
> +					    bool has_mbox)
> +{
> +	struct cxl_dev_state *cxlds __free(kfree) = kzalloc(size, GFP_KERNEL);
> +
> +	if (!cxlds)
> +		return NULL;
> +
> +	cxl_dev_state_init(cxlds, dev, type, serial, dvsec, has_mbox);
> +	return_ptr(cxlds);

This function is so simple, there is no need to use scope-based cleanup.

-- 8< --
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index ab994d459f46..5664514dfb83 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1488,27 +1488,48 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
 						 u16 dvsec)
 {
 	struct cxl_memdev_state *mds;
-	int rc;
 
 	mds = cxl_dev_state_create(dev, CXL_DEVTYPE_CLASSMEM, serial, dvsec,
 				   struct cxl_memdev_state, cxlds, true);
-	if (!mds) {
-		dev_err(dev, "No memory available\n");
+	if (!mds)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	mutex_init(&mds->event.log_lock);
 
-	rc = devm_cxl_register_mce_notifier(dev, &mds->mce_notifier);
-	if (rc == -EOPNOTSUPP)
-		dev_warn(dev, "CXL MCE unsupported\n");
-	else if (rc)
-		return ERR_PTR(rc);
+	/* TODO: move this registration to cxl_region_probe() */
+	cxl_register_mce_notifier(mds);
 
 	return mds;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_memdev_state_create, "CXL");
 
+void cxl_memdev_state_destroy(struct cxl_memdev_state *mds)
+{
+	cxl_unregister_mce_notifier(mds);
+	kfree(mds);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_memdev_state_destroy, "CXL");
+
+static void mds_destroy(void *mds)
+{
+	cxl_memdev_state_destroy(mds);
+}
+
+struct cxl_memdev_state *devm_cxl_memdev_state_create(struct device *dev,
+						      u64 serial, u16 dvsec)
+{
+	struct cxl_memdev_state *mds = cxl_memdev_state_create(dev, serial, dvsec);
+	int rc;
+
+	if (IS_ERR(mds))
+		return mds;
+	rc = devm_add_action_or_reset(dev, mds_destroy, mds);
+	if (rc)
+		return ERR_PTR(rc);
+	return mds;
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_memdev_state_create, "CXL");
+
 void __init cxl_mbox_init(void)
 {
 	struct dentry *mbox_debugfs;
diff --git a/drivers/cxl/core/mce.c b/drivers/cxl/core/mce.c
index ff8d078c6ca1..71cc650f54ae 100644
--- a/drivers/cxl/core/mce.c
+++ b/drivers/cxl/core/mce.c
@@ -48,18 +48,16 @@ static int cxl_handle_mce(struct notifier_block *nb, unsigned long val,
 	return NOTIFY_OK;
 }
 
-static void cxl_unregister_mce_notifier(void *mce_notifier)
+void cxl_unregister_mce_notifier(struct cxl_memdev_state *mds)
 {
-	mce_unregister_decode_chain(mce_notifier);
+	mce_unregister_decode_chain(&mds->mce_notifier);
 }
 
-int devm_cxl_register_mce_notifier(struct device *dev,
-				   struct notifier_block *mce_notifier)
+void cxl_register_mce_notifier(struct cxl_memdev_state *mds)
 {
+	struct notifier_block *mce_notifier = &mds->mce_notifier;
+
 	mce_notifier->notifier_call = cxl_handle_mce;
 	mce_notifier->priority = MCE_PRIO_UC;
-	mce_register_decode_chain(mce_notifier);
-
-	return devm_add_action_or_reset(dev, cxl_unregister_mce_notifier,
-					mce_notifier);
+	mce_register_decode_chain(&mds->mce_notifier);
 }
diff --git a/drivers/cxl/core/mce.h b/drivers/cxl/core/mce.h
index ace73424eeb6..b7930761b0d6 100644
--- a/drivers/cxl/core/mce.h
+++ b/drivers/cxl/core/mce.h
@@ -4,16 +4,17 @@
 #define _CXL_CORE_MCE_H_
 
 #include <linux/notifier.h>
+#include <asm/mce.h>
 
 #ifdef CONFIG_CXL_MCE
-int devm_cxl_register_mce_notifier(struct device *dev,
-				   struct notifier_block *mce_notifer);
+void cxl_unregister_mce_notifier(struct cxl_memdev_state *mds);
+void cxl_register_mce_notifier(struct cxl_memdev_state *mds);
 #else
-static inline int
-devm_cxl_register_mce_notifier(struct device *dev,
-			       struct notifier_block *mce_notifier)
+static inline void cxl_unregister_mce_notifier(struct cxl_memdev_state *mds)
+{
+}
+void cxl_register_mce_notifier(struct cxl_memdev_state *mds)
 {
-	return -EOPNOTSUPP;
 }
 #endif
 
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 6cc732aeb9de..3baf5b4502d0 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -633,7 +633,7 @@ static void detach_memdev(struct work_struct *work)
 
 static struct lock_class_key cxl_memdev_key;
 
-void cxl_dev_state_init(struct cxl_dev_state *cxlds, struct device *dev,
+static void cxl_dev_state_init(struct cxl_dev_state *cxlds, struct device *dev,
 			enum cxl_devtype type, u64 serial, u16 dvsec,
 			bool has_mbox)
 {
@@ -655,13 +655,13 @@ struct cxl_dev_state *_cxl_dev_state_create(struct device *dev,
 					    u16 dvsec, size_t size,
 					    bool has_mbox)
 {
-	struct cxl_dev_state *cxlds __free(kfree) = kzalloc(size, GFP_KERNEL);
+	struct cxl_dev_state *cxlds = kzalloc(size, GFP_KERNEL);
 
 	if (!cxlds)
 		return NULL;
 
 	cxl_dev_state_init(cxlds, dev, type, serial, dvsec, has_mbox);
-	return_ptr(cxlds);
+	return cxlds;
 }
 EXPORT_SYMBOL_NS_GPL(_cxl_dev_state_create, "CXL");
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index e7cd31b9f107..897589a6c6ca 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -416,7 +416,9 @@ struct cxl_memdev_state {
 	struct cxl_poison_state poison;
 	struct cxl_security_state security;
 	struct cxl_fw_state fw;
+#ifdef CONFIG_CXL_MCE
 	struct notifier_block mce_notifier;
+#endif
 };
 
 static inline struct cxl_memdev_state *
@@ -755,9 +757,11 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
 int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info);
 struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
 						 u16 dvsec);
-void cxl_dev_state_init(struct cxl_dev_state *cxlds, struct device *dev,
-			enum cxl_devtype type, u64 serial, u16 dvsec,
-			bool has_mbox);
+void cxl_memdev_state_destroy(struct cxl_memdev_state *mds);
+
+struct cxl_memdev_state *devm_cxl_memdev_state_create(struct device *dev,
+						      u64 serial, u16 dvsec);
+
 void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 				unsigned long *cmds);
 void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 0d3c67867965..d5447c7d540f 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -933,7 +933,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		dev_warn(&pdev->dev,
 			 "Device DVSEC not present, skip CXL.mem init\n");
 
-	mds = cxl_memdev_state_create(&pdev->dev, pci_get_dsn(pdev), dvsec);
+	mds = devm_cxl_memdev_state_create(&pdev->dev, pci_get_dsn(pdev), dvsec);
 	if (IS_ERR(mds))
 		return PTR_ERR(mds);
 	cxlds = &mds->cxlds;
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index e62cb5049cf5..c40afc743451 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -1717,7 +1717,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
-	mds = cxl_memdev_state_create(dev, pdev->id + 1, 0);
+	mds = devm_cxl_memdev_state_create(dev, pdev->id + 1, 0);
 	if (IS_ERR(mds))
 		return PTR_ERR(mds);
 

