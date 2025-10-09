Return-Path: <netdev+bounces-228341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9FBBC8259
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 10:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B2013A88F7
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 08:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EB92D47E0;
	Thu,  9 Oct 2025 08:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gm4+9qtL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FB22D3A9E;
	Thu,  9 Oct 2025 08:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760000134; cv=fail; b=fvDgRAXbdd0HYk4+EdbKvDKhQscn85yLAdvSeVV0EDzHlNPOcL/dl/YRrRQ4t7Dq8bd4fvGiXL04lO61yX5f4oO1LTbe8CgARmtqD0my5eCn90TebC5eGt7G3Gbn8iwWt4SkuOnYscJ8BvsXil8ghEAO0fLgoD2XaQ6hIc9ynDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760000134; c=relaxed/simple;
	bh=5EKcQF23PErupqmZhCxzsBRi/lhJmVehYecKj6ubU5s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kFjcz6RjcvWyw3GnQ08L7T+YIiSjFp83RiH+VosOOXg7al/9cR/xu0BG3DpuDTYPspFxEg7zYzelWdtzk85A0+4cQH1BYjkt6wLTEwxljmx0n74cdt9rBjt0/hmNPPIpoLOZ+rUyAKR8uhcgSVTDcVWXFOGhon8rBGwbtyfIEQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gm4+9qtL; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760000132; x=1791536132;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5EKcQF23PErupqmZhCxzsBRi/lhJmVehYecKj6ubU5s=;
  b=Gm4+9qtLuRPcFfPuX461IhoPEGlODV99a6PPk6NQQpWsmg5W9EmfoQlz
   7U8870bSeA33nJljLOXyVjsLX2qm1ufddcHzc99CZ96kUcoV7nQBR4caq
   KznNZ0zZx21g2LmkgOTj+L4TDzMr78lr46vrEnIB02bLqDX8izAtQT/Bf
   wzHZPmQV8SLAN0bphkVx8Cb6u/pa0Bt8J+uIgd1UQO++oD1updRNCSEkk
   JWNVQi9pKQfAtJzdvkZtQ3aknogMNBI5qiP0vO7w1BkxPtT86Xp8wQ8u5
   H4aRrdQR2HyiPD5FkfwGqWHUaYfQ56iH/xfUhoDBH0lYS3xn/hrkDk7zN
   w==;
X-CSE-ConnectionGUID: SNidFoebQqq+Say9yMRFYg==
X-CSE-MsgGUID: DIron/GESRmuVqL5+6YSuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="72464832"
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="72464832"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 01:55:29 -0700
X-CSE-ConnectionGUID: SggOZsamQ8K9o8onn64Keg==
X-CSE-MsgGUID: jJ8TLC7eRveYzcuKpV0mIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="211611112"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 01:55:27 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 01:55:26 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 9 Oct 2025 01:55:26 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.69) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 01:55:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xlexz+a33A4EPCvUTbQQqfJJNLE+gIQtbvYJERMiR/QzfhOsczxXs0M/dktp5pfbS+9Urv5nw1UNYEIqlMm4HbTfRKO4pk3qbmSTP2KMKfO7R+DnWKBWPdm/4kLfCHNZ2IyZRVbvCQqbdEhrTFnfGXSccH2up7LROR10iapnA1Urk5WE5/FyzNX4s11pHqz94S0JekRP3SiHJdS+ErAZ9Y5jdrgTcayQahGMwfPoOyxlgQ0oXBFDISTZuiJ9dGYfAnOjz2iGnuBijTA4qQL/+1SY1ths3DXRE21l4w2yws+RL/+we2bIcVKJ4I51oCPgIMHl4DMxLnEU8x3za07oyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5EKcQF23PErupqmZhCxzsBRi/lhJmVehYecKj6ubU5s=;
 b=Gsulm+fTNVbhq77YvkzkqyK59mhPTTG4uBOHGK+JgQHG7MI4v87/vIq2CCbJkoJLD4dPKmFViMf1JVEQzF8IGYd0VH9Md8ddfonkXq0BXXlh+5GeOGPcwKw+D4lYprlJyzmoHzOl3/Z+C2nz/g0YGrlEEoadtdH1n1GqnIVMc5dUnOkyGa+gyZwGQtrHzXsE/zTdYJrdU0Bsy/qVCRFCm7c4viA9DQYnqOjQMLywVw2QmaqOAkGCouBrGC5dg+RAIRZpWnIPphWoZDNzez8/XY3cqQtWU9nmT0TssptW/QgRoLyta/k4GrNZDw41NMa0raJFHTEJiKR4nXmXz/SPug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DS0PR11MB7311.namprd11.prod.outlook.com (2603:10b6:8:11e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 08:55:23 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9137.018; Thu, 9 Oct 2025
 08:55:23 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Brandeburg, Jesse"
	<jbrandeburg@cloudflare.com>, Jakub Kicinski <kuba@kernel.org>, "Hariprasad
 Kelam" <hkelam@marvell.com>, Simon Horman <horms@kernel.org>, Marcin Szycik
	<marcin.szycik@linux.intel.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "Keller, Jacob E" <jacob.e.keller@intel.com>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Brandeburg, Jesse"
	<jbrandeburg@cloudflare.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v4 5/5] ice: refactor to use
 helpers
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v4 5/5] ice: refactor to use
 helpers
Thread-Index: AQHcJz6OS5uqOepTXECB8nKlwmCshrS5pkXg
Date: Thu, 9 Oct 2025 08:55:23 +0000
Message-ID: <IA3PR11MB89864296CC7CD352961BE8EBE5EEA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20250916-resend-jbrandeb-ice-standard-stats-v4-0-ec198614c738@intel.com>
 <20250916-resend-jbrandeb-ice-standard-stats-v4-5-ec198614c738@intel.com>
In-Reply-To: <20250916-resend-jbrandeb-ice-standard-stats-v4-5-ec198614c738@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DS0PR11MB7311:EE_
x-ms-office365-filtering-correlation-id: d3d8717d-6f47-4761-143c-08de07119565
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|921020|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?TWo5SjdlZlZlRFhXUWcxV2xnTFFMdEIwMERhSTNvYmUvVzhZaCtYZG1KV0p0?=
 =?utf-8?B?aUh5OHJBQkVKT2lkMFhVTFdPMUhwYnkzOFFadExTZU1hb2svU25icXpDSjlq?=
 =?utf-8?B?YkNYZDVRWFBBSG1JanpzL2xjNW80NWRXbm1laW8wMlhJWWpIbWQ1b2xoSkds?=
 =?utf-8?B?dHVXZXMrM1lHMDliNXkxRUh5eG51Z1NETlZ3NG5xUXViWmZpUFJJSXdRYUQ3?=
 =?utf-8?B?UStaenIvQlJXRU95TnZtRTByM0FtTnFFTVhrTDgvRHRlK21tSEpTVElCVUZU?=
 =?utf-8?B?cGhhMTd2Q2xUQzJ1eDUyeWZMV1MxQW1scGI5M1FZdm9Hck12djNEOHJJS2tU?=
 =?utf-8?B?b3lFMmxaY3FEeXRCbUxBbm5JSE1remtQVnBrakxnL0pXMlIzNUdKOHVVZmlO?=
 =?utf-8?B?VEZ3RHlPdVJvbEVIRVhNQlRQNVlGTGRHY0g0VHExaWdRTG8rNUwwdm9MWVB6?=
 =?utf-8?B?Ukl3OEx0elNla2dqRk1ZQURFWTRUY3M1Q3N1Z3JwbWFHUmd3ZUhDbGhoalVj?=
 =?utf-8?B?aHV5ZDFsemhpSkwzM1dXN1dzaWg2K3ZkYXR1cVc1Z2xUSmRMTjJxbmk4YXFn?=
 =?utf-8?B?MTJYakkyU1EyTENNSUN6RENCbW5vdy9EUTJWSURWcTBhVDBnaTI2UDBmUW1Y?=
 =?utf-8?B?dXdiNFhXODV0c2craVNSa3ZmelRYMGtLdnNQMGZsRUxtQ0hRN0l6SEdpalRz?=
 =?utf-8?B?cHAvK1JxY2tqT3UrS1lIcnlVWVpTN291ZW1DSm1XVzJzMlc4RnNHSVU3ckYw?=
 =?utf-8?B?M3d1blFkMFlOL1ZGT1h3MGpVWXhWWTdtaHdPUXozbEw3ajgrUURMNTJSeE1M?=
 =?utf-8?B?YVA3SWFjb0s1TTV2aDZXVlpLTkU5NGdwUTVZQWRibkNkZDZueDFyZTVRanJM?=
 =?utf-8?B?WnF1OGk3V1pkckp5VEQ3REpFVmpOc1UyQUJPU1phSUQ3bFJDcGt1cnBKZ2Nx?=
 =?utf-8?B?bFhQYTF5OTVaVE44T1ZycW0wei9QK2dpeGdvSS84bVBRMEFVU01NK0NqR09K?=
 =?utf-8?B?TFRTSzFFVEpFMUYrQ1ZpT2E0WUVyT2cyUG5veE5hSFJXZ29qODV6cSs5d1Y0?=
 =?utf-8?B?eDZWUXEzSVQyblBOV0J6Z3hHRHlJcENrN3FmM29nN00xNlRFQXlwajZPamFF?=
 =?utf-8?B?RXVPOUZuWDBTZGh2NUVUODB2YVRRa09GU0dIMEJoMGh3VFVGU016c1NIN3lV?=
 =?utf-8?B?WTliMkxKYlV2Uk9YU08yaTdhdTdBbDZkano2SXJOQkJTRXptclRJSmVYUkxV?=
 =?utf-8?B?ejJsMVZ0RU1keHdLVE1YV0dFT2tVYnB6azRaK0NCNGNPUkxOSFhjTlh3b2dL?=
 =?utf-8?B?aWkwM0tKa3BXRTFiT1NLQlZpdEtRanplbzE5VW1UbElPM1RscWRCUHdsTEFP?=
 =?utf-8?B?S1JJYUhuNUdvU2dFcWl6V3FWNnJtaDdBQStnNmFKOENLUFFVWUNzTVNaanAz?=
 =?utf-8?B?c3orajZhcHBqNUM5THpVMkVpT2hiaHlEL014Y3c3SVl6aXpZalRaT0R6YUZL?=
 =?utf-8?B?TjBUNEVQMUEwdXY3cStzbHlkUkhvTitFOFhvQlVBMHdncy80c1JKUFlCcGw5?=
 =?utf-8?B?OWlLZFdXYXdSL1JjQXR0VjJCdUI5Tmo2MGUrN2NJT1Y1OGNiaWp5cUc1bHBE?=
 =?utf-8?B?NGtuV3Z5S3pRU1ZtL1BGcHhwRzBkalpUTjVTa1FBUDdxTk9uc3ZJQXg5UjdJ?=
 =?utf-8?B?N1pBMk1yUlFUb2RkaHVXdWZTUm1lRnFNZDAwZFo1QkprSFk2aEdvMlVkTk11?=
 =?utf-8?B?bWk2L1pWMzJhdzB6TEZlT0J4UFI4QkxQV3FSTGlzMEtvM3JkdEFNcXpMNzlX?=
 =?utf-8?B?R3BvZ1ZKczVremd6MDIrcXYvQ0VxV2tma3RaUmVKVHRpMUh5OEI0Q0xGQzBH?=
 =?utf-8?B?Kys0aDJ6eG1Bd284YUFQUUdqL2E4OWRqeXRacWtXcnRKS2tORFEwdU9xdEN1?=
 =?utf-8?B?aFFITHRaUURkWGwwVCszUTNMaWVMS1VwWE9IVnR1aTNkZGNub2V1bWNWN1FM?=
 =?utf-8?B?dmdBU2lWYlhmUzM4ZUdVMWRKMDdRK3RPWVhxQlM4NTJSSzdYVjI3Q3FtT0Ro?=
 =?utf-8?B?d1oyS2JXY3crSzQ1eXBzcm5zbGkvSkJJbWlBUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MERhNjRrMDBOZkVhWDFvVUNRekRMS0pCUzBSdjc3T3FiZkwvdWllcGFNbC9j?=
 =?utf-8?B?MDZ4d0E2blBvWkU4Mko3dkRORDNSMlZ3bTdVbGZXQStuN09GRG5iTVpnc3Av?=
 =?utf-8?B?MlZRYi9oTVdQSXJoVEFGTStNZXdDQmJOd3pobUtsRjlQbUpHd2lqSm1PNlRm?=
 =?utf-8?B?anA1eHowRFQ4dzYzUDRRbVRrWnpGZ3lpaDljbkFMSTVyMkVTUGxVNVZpUnNu?=
 =?utf-8?B?bFlzUEorS2ZOQ3ZkaytTZUNrMXdWbWtBdGl4dmFsU2IvdjFJcm9VRG84QjV6?=
 =?utf-8?B?aFBVQm1sU283d0s3NWx6ZDFpREV2RllXNkora2lkSmorRC8vcytNQVBDRXY4?=
 =?utf-8?B?QlRFem1ZOGdGbnlxeDJhNFlQYmU4M04wTHo3Q0daYjMwVjJENVdIek5VaEZF?=
 =?utf-8?B?MDZPLy9rMXIyNGY1WWdxMUxuV3VGcllGOWZKVXh3NEVjeHNBbVhrVXhtZnpt?=
 =?utf-8?B?OXUxTHpCK2ROSU9qdGRlTndPMEdhS2kycm5hM0d0d25IbjNTWUpHdWpSNyta?=
 =?utf-8?B?WGFPNjJaTlV2RHljaUlhb0NQcElHdlRqTDZDeUtTdGtFK0R0ZjBnbitjbm1Y?=
 =?utf-8?B?WlRRMlJmZ3hUZ3k5Qi9KajNNSEtnR2FrZTRPU1cwNVlKZXFHbGVoWDFMLzBi?=
 =?utf-8?B?RWhqWStIYU9ERXY1ODJ5NGtUSFdRUUVLUy9mVEcwVnR3ZzZnbVdWa2hYTkJk?=
 =?utf-8?B?aVhjSUFnS2VMOHB1cXZDY2pMSWphcXdyVnJUU3RUbEUxTVZ1THp4YnF4bWVI?=
 =?utf-8?B?aU1MdnZ3bHFUOU92UGRWMTcrVmY0SGRrbkNyNXMvYXVhWnB0VElNSTF3RjZW?=
 =?utf-8?B?WGFJRlJlMGlhdE44ZVA4TFdnUjljYjU0NEVPYy92ZGgvc05XYUVyZy9WdDhx?=
 =?utf-8?B?d0Y3OGtRYWc3Wmthd28xbnRENkZYam9Rc0MxbWswVkJqNkZsWGhFUVhRWnMr?=
 =?utf-8?B?UjNiQk1XWHdlZDRQVWQ2c3JXS0tNMW14SHVpRU9waDBoZW9yTWtOMk1IWTc0?=
 =?utf-8?B?MVpXbCtidklGd1dWNWpyTkxJMGQyWlVENWxGS04vMU4yUmExTDdQU2tIQjB3?=
 =?utf-8?B?RGg0b1VCVmRjVEMxMnNiMHY5aFJlSGlaTTdBckFYUWl4WUUwZUVVTHhBdzVm?=
 =?utf-8?B?TnVtVEJhNk9qMUFteXNRT1Q1aHNRc0tHblRDQjBOR3o1WjBlOTI3VWt5TlRu?=
 =?utf-8?B?NGg4T0FBenJ4UnFRRUJvM2tYU1FnRldISit2RFkrSXo0ME5Namp5ZXVUb1k5?=
 =?utf-8?B?UFZkekIvMzhSSjNSQkhXV3dOV29GK1ZrRERTelR1Qy9MTXdFOURRWUQ5cHFF?=
 =?utf-8?B?UzYyQkFBODMvQTYrZ0Z5bW1lazY5R0h5em1kaFhvbDl5TitqZVhCTEtVYlli?=
 =?utf-8?B?bWpqYi9yVzMzWXl5ZGZkVHNIc0M1U2pBRitLdHJyQ2RMZmpnak9mUTdabVFN?=
 =?utf-8?B?MDZrWjVqZTB3UzNLRmJEZ2ZPSDVvQ2d5ZFBDZ1pwOFNRemhBS05FZ09oZ0Nx?=
 =?utf-8?B?dW9yaVJuQ3dHUHIyOFFidElOWWRuTFVKbThuaXk4M2lEOC9Wajd4dHR5OVVL?=
 =?utf-8?B?bGJNei9XaUk0d1IvLzJzbTBvbU4zd0ZDeERvdThSREtkb2lnTWovcXBPM1JX?=
 =?utf-8?B?bitZV1VQUmpMOTl6Q2NJTGVIcGJLbzhzWnhyNDZWRmVlcHYvQXZYOS82QjNz?=
 =?utf-8?B?OFhKS21RNHJuSXVqZGxNWTF4WHp0UVQxMEYvZWEyVXFoVUdUcHhIaktaeGFj?=
 =?utf-8?B?Qm1KMXdXcmFzTjdQNjJSQktBVUJvZWFqUGtPZkRSMU9xdUNIejU0VUIwT1pX?=
 =?utf-8?B?QWhBQ0tqblBBVUoybXkrVTdlMUVUKzBGSlVHQTlwMDNoMmdRbHg4VDBuVG5Q?=
 =?utf-8?B?T0c1bzY1ZlRmVnkvY1NPTGJrdWJBOGxCaWJNZGRydnpRTkRiL3c5RXhHalQw?=
 =?utf-8?B?SHpXMXdsVVUvdlREMjNBLytJSXJWOEwxdkJ3dDFtaGRKaVh2RTRjQko5Nnlz?=
 =?utf-8?B?d25yV0RpanlPaWdKYlo5d0tkK1A5ZHJUR3c2M1FyZVYxd2IvQnJDS0FJYmFB?=
 =?utf-8?B?T2NtblpBVzgwRE5CQmNMekRsRUI0Q3FrTGozN05sR2U0cGt3NDFoanpIU3lz?=
 =?utf-8?B?S2JVQWdXdnpSSmRMbVZ5KzFGWmtsaEdodGNZdVcwOWY0UTlKUlhiNzVLajdH?=
 =?utf-8?B?NWc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d8717d-6f47-4761-143c-08de07119565
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2025 08:55:23.5252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0S6YY66VChn5hp6quu6SVirpYJrP9re6eeJVAVX7xJ4aI640s9yFcRQC/msXgylcCQjKLWxt0VrPQj18aVu3b9YDm38KyH8ichX+HT2dqqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7311
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgSmFj
b2IgS2VsbGVyDQo+IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAxNiwgMjAyNSA5OjE1IFBNDQo+
IFRvOiBCcmFuZGVidXJnLCBKZXNzZSA8amJyYW5kZWJ1cmdAY2xvdWRmbGFyZS5jb20+OyBKYWt1
YiBLaWNpbnNraQ0KPiA8a3ViYUBrZXJuZWwub3JnPjsgSGFyaXByYXNhZCBLZWxhbSA8aGtlbGFt
QG1hcnZlbGwuY29tPjsgU2ltb24gSG9ybWFuDQo+IDxob3Jtc0BrZXJuZWwub3JnPjsgTWFyY2lu
IFN6eWNpayA8bWFyY2luLnN6eWNpa0BsaW51eC5pbnRlbC5jb20+Ow0KPiBSYWh1bCBSYW1lc2hi
YWJ1IDxycmFtZXNoYmFidUBudmlkaWEuY29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsNCj4g
aW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmc7IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5v
cmc7DQo+IGNvcmJldEBsd24ubmV0OyBLZWxsZXIsIEphY29iIEUgPGphY29iLmUua2VsbGVyQGlu
dGVsLmNvbT4NCj4gQ2M6IEtpdHN6ZWwsIFByemVteXNsYXcgPHByemVteXNsYXcua2l0c3plbEBp
bnRlbC5jb20+OyBCcmFuZGVidXJnLA0KPiBKZXNzZSA8amJyYW5kZWJ1cmdAY2xvdWRmbGFyZS5j
b20+DQo+IFN1YmplY3Q6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRDSCBpd2wtbmV4dCB2NCA1LzVd
IGljZTogcmVmYWN0b3IgdG8NCj4gdXNlIGhlbHBlcnMNCj4gDQo+IEZyb206IEplc3NlIEJyYW5k
ZWJ1cmcgPGplc3NlLmJyYW5kZWJ1cmdAaW50ZWwuY29tPg0KPiANCj4gVXNlIHRoZSBpY2VfbmV0
ZGV2X3RvX3BmKCkgaGVscGVyIGluIG1vcmUgcGxhY2VzIGFuZCByZW1vdmUgYSBidW5jaCBvZg0K
PiBib2lsZXJwbGF0ZSBjb2RlLiBOb3QgZXZlcnkgaW5zdGFuY2UgY291bGQgYmUgcmVwbGFjZWQg
ZHVlIHRvIHVzZSBvZg0KPiB0aGUNCj4gbmV0ZGV2X3ByaXYoKSBvdXRwdXQgb3IgdGhlIHZzaSB2
YXJpYWJsZSB3aXRoaW4gYSBidW5jaCBvZiBmdW5jdGlvbnMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBKZXNzZSBCcmFuZGVidXJnIDxqZXNzZS5icmFuZGVidXJnQGludGVsLmNvbT4NCj4gUmV2aWV3
ZWQtYnk6IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2VybmVsLm9yZz4NCj4gUmV2aWV3ZWQtYnk6IFBy
emVtZWsgS2l0c3plbCA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT4NCj4gU2lnbmVkLW9m
Zi1ieTogSmFjb2IgS2VsbGVyIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IC0tLQ0KDQou
Li4gDQoNCj4gLS0NCj4gMi41MS4wLnJjMS4xOTcuZzZkOTc1ZTk1YzlkNw0KDQpSZXZpZXdlZC1i
eTogQWxla3NhbmRyIExva3Rpb25vdiA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+DQo=

