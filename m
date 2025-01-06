Return-Path: <netdev+bounces-155597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9536CA03212
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 22:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81DD216263D
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 21:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85381DFE38;
	Mon,  6 Jan 2025 21:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AoWU90jF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B701DF27D
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 21:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736199341; cv=fail; b=KtcRkNbDwWX2rv1KP+U0qSoenes5r2nbapiXg7gvaMCUXRTVaV4gCWbmBu/o83y4BuvnfEF6V/TUTb6RUeA0tGXRnlXczC27JZkbqw18O9BGS04Ro5JJ+eLJAGzFiUh387xXNzzdpXIRZnxR5j5ekPDncLISdFMg8mxLyxkOnWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736199341; c=relaxed/simple;
	bh=BKnRLyk7akcXxizdsYv6jc2RaXpF0cdBAqm7DvQoolQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TdR/GcHNgMyWPhmRuXllT1P+go/MkgKGNh2JOyfrnD+LVWUO0wM/cZOYCdfHMPjTEcbnQArBnF9ouJjDn4r/Yq3r5RaEV1YHccKT88bZPgLWtv+y0pXtYT9sa7ARBu9n5ZrsA++iDOedyDwujjp4XAYzzS12OnPa+U9Oue66qW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AoWU90jF; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736199340; x=1767735340;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BKnRLyk7akcXxizdsYv6jc2RaXpF0cdBAqm7DvQoolQ=;
  b=AoWU90jFbUFK5u68OZ58cI+SBYzd4+5GOwjLRGeu/QOAPsMECs3s79FS
   JqIJGOvFpFX8awWEpMW9glTj7kK+i3QJ7fhgQJ/XfAbdp7pIudIyzIRcB
   ReyzlLRapWMyv5umddX/4kkpmG/HNLh1QWqhvFswlG40MWraf+46aywxo
   5uxSDK8BwcVTPB0gtIgaytbCYLa/slsOTmNMaLaGl0b0A3vUSntWv127r
   p353g+WI+aim7XTHyNvn5ZPkWQ4WSx7/hxXOcKb68Ts3TWCENbnkW70iU
   +a3pGTt+YPXh/65epPvR71BYeJfHuaq0+3VxN6HEgo2e0Q8iKuoVk9zPr
   A==;
X-CSE-ConnectionGUID: kxx2OE5WSAK6DO8RYN/N2Q==
X-CSE-MsgGUID: KKLZ8NoMQ5C189V89jey/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="46941817"
X-IronPort-AV: E=Sophos;i="6.12,293,1728975600"; 
   d="scan'208";a="46941817"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 13:35:34 -0800
X-CSE-ConnectionGUID: B0xoGIFpTBihmtJe0tNvyA==
X-CSE-MsgGUID: fiBa8zFqTZSvfNFLuH8MgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="107612797"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Jan 2025 13:35:34 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 6 Jan 2025 13:35:33 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 6 Jan 2025 13:35:33 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 6 Jan 2025 13:35:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CKOvrK7HQfFaUaEq1dbI6/acxdKblnZPI4LwcWT/ozA4D05ypwN9Ci+h03vm8DHG+t4+pRXNL+4XpMyy6fI95nxkyDO5oB7pLsh9831Yw3BCstXdbLZBwr1cL8NdPMeociTlUeR26BuXqIYecVCqdK1GUpgpwrkLmz1V1mV/5Bs6e/MW3B1Nsy1zMRAnK1OXZP122ExFSViUvCtg3cXp6+dpA4cIdxcY8WwNyi+A8deFki9OEU6r0UjFDkN9yBkkLM5zozgwiczCQ2njc/uKndMH8rg3s+Lgw3Mbktl+PovFEmiumnAioZDVJyMdiQKxkgcu+XZ7LRqj/rzVFCtDag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABOWKiJHgX5aQw7A0fge6QdlHm3wMv1Gw9UHljz42io=;
 b=esjizABZJlPluyz6J/MA9VzgCxPdvCAUHn0QpTAK5izlrG01GF7vUpIMeYLecFyoRHzDhpbp0ME1fK4FEgYqeZFcEe+Y5fm3CXdH+umXm+umFbsIo9FXwJ/x/Dnefci3gXgK/s+cPjXOCtphcIb5ne4UO2kDMtjFcK3ivReM5t7u4G3LmydGuj5A84XXuWnDkIPR/1L9a3ifZcTbpPpivYF1hw3gCL4hgENXEgkcVFPvirXiMB+L6hKUd41whczMPmy8gHgkQ/aEo0qrKyS2FISSammD4vJnk3TTd0Q2dDVJ58Al7V7Maim2UT483YfaAAky317RtXxiaqzqR7PYNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH3PR11MB7391.namprd11.prod.outlook.com (2603:10b6:610:151::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 21:35:13 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8314.018; Mon, 6 Jan 2025
 21:35:13 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Richard Cochran <richardcochran@gmail.com>, Jiawen Wu
	<jiawenwu@trustnetic.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "horms@kernel.org"
	<horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
Subject: RE: [PATCH net-next v2 3/4] net: wangxun: Implement do_aux_work of
 ptp_clock_info
Thread-Topic: [PATCH net-next v2 3/4] net: wangxun: Implement do_aux_work of
 ptp_clock_info
Thread-Index: AQHbYBScY5vYzjLaEE6Lwoq9cluMmLMJ27UAgABpgDA=
Date: Mon, 6 Jan 2025 21:35:13 +0000
Message-ID: <CO1PR11MB5089788E11ECC1F9F704CEA7D6102@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20250106084506.2042912-1-jiawenwu@trustnetic.com>
 <20250106084506.2042912-4-jiawenwu@trustnetic.com>
 <Z3vzwiMzYDvmKisj@hoboy.vegasvil.org>
In-Reply-To: <Z3vzwiMzYDvmKisj@hoboy.vegasvil.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|CH3PR11MB7391:EE_
x-ms-office365-filtering-correlation-id: b9615d8d-cf2c-4ad7-a7cf-08dd2e9a0119
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?+uJF4uMgPhhGDffTQEdhr3JhjmzADzuKR6gVTWerXRYjLR+eZT/a4c3FTjB3?=
 =?us-ascii?Q?ekecoPAW0qZVWNTSHZpHdRt27qlPqt8E3LxGZ+Rs/RvFkgSO8nc8KRg2J3TO?=
 =?us-ascii?Q?2WJaKRupmXFv5IohhQKHZQqi7W2ds8qN529WVZLjDbmOov2ZAHll4g0KoNkb?=
 =?us-ascii?Q?7CaFif8ZG7m9Pv5EEI/alLdaNeOY3lhriqHaZHg41K/QYC+Ik49Td7Kj6OZ3?=
 =?us-ascii?Q?0anlYgNA9SfcS0vm8Pc0X8YTuTcnu0vM1CZZ1kXpJQEvrJEjB+F4QsJf+2SA?=
 =?us-ascii?Q?46fABtAhtB8F2MGgqhTuS1XLxmCIGH9htdcUDhgZ95VKvcI2mWVGG3MeGsYY?=
 =?us-ascii?Q?Ihy3KP5bsbCoLpNGEl6FYasc2mO8EoQ3KgPpy6b/nONig8CIaCd02AFcSMEv?=
 =?us-ascii?Q?1/2QYn9uYhQZnQOs8fcManJpF8VYLYNKk437Ld2y9HqLgphFQXgJvMS/5Nxj?=
 =?us-ascii?Q?W7RnNnsi8ZbHHjh51KMkzYi+y0apQGSo6psdBxKclAOsc9l7yMBSO7m/A3oa?=
 =?us-ascii?Q?4Ugh2wciczYjPXwzjfnJ+n8Bul9m0XjI8p7Ps4haI2A4TebC2ct9H95ElAx/?=
 =?us-ascii?Q?F6KoPrEsA4AcC/3yspLApukOSlGUxCkk4o23AYQv9aFm5K0LCSn2/ocm1oJY?=
 =?us-ascii?Q?yC1Cpe29ctvk8eOocV037RkyD2THbYU2SKhifTJujnQ7NC8uiGbJcNYsotQT?=
 =?us-ascii?Q?+LNwErUr4Tej9/I2h3eQMRr0z8z4e3YTR8MeekCMH+JH8NabE+u5x46dvNva?=
 =?us-ascii?Q?g71hQpfdeiDtxXXnVvOBOG16Gvrv4Sy2j6SnXMFQdPbcAR3R7u2KOEFyRWKZ?=
 =?us-ascii?Q?cHxo1NOZOllZW8oDGI+637fO2DvN7c335tCdjLEHh4P2146dGVa5BCzu4z8+?=
 =?us-ascii?Q?l0l7B967APX/eIUy3/A1KV83gM+PT8CEHGOHK2+2Cy5wOw0FX4o9zAzmMvx5?=
 =?us-ascii?Q?cxeaKG8IxPtXmOzHbAsIDe8z0b60N2yLytjVvbDwB3Wq+7lX7ouLcBNy/Kqw?=
 =?us-ascii?Q?EBnO/RW8EKpTXuSMo8lxSuIuRtPO0qKmTzkoenvu6/iwFr6CJwlSqAsU5uMD?=
 =?us-ascii?Q?gZoz0x1eSiw8WScaCFYcMrnoNLyi4s/AhgVUjkdGaoUmSgiV7Oj1waLESdbO?=
 =?us-ascii?Q?Pgh3O+BQL2GYS0PjAOnn4jnpDlgfrvesaoJVZIblrUWz+XDp+7O0nniBmAl9?=
 =?us-ascii?Q?MSih4x7Vd5RPhyF+F/yolMiIjKfsn61sXPhBqtFA5lnJJY8ymHs4xgFgsTC6?=
 =?us-ascii?Q?tV8sicnpavFcOms2xnD6e0cdYRoA2IxpcuUgDqBQr5wBLfo+hgjP+4oPCIeJ?=
 =?us-ascii?Q?a4bWNyvUSmqHnEm57sLyIkC3UIjScIDfIM+sbF40oASHpx74YbG2mNxAvL9v?=
 =?us-ascii?Q?ThuR1YeSL+wc66xgDVKBVUDojFVat9ueJGXu1Zm69qWQuRByTU8DHBItVMTe?=
 =?us-ascii?Q?5du+GGObIOmMOEruYF1S8hBAOmtl3tow?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+PFGQCwCHNqClaYS9eFAAapM5DdlEeRYwwI3YIJrqF8Ha7I9xWrCjlSxdWac?=
 =?us-ascii?Q?bxW7VHnucbIx/L5zXCjKCdqEcXI80M7r+Hin3zbjQ/Xq4T7HevT0X9GbXw3M?=
 =?us-ascii?Q?6OWpWmW9uL/O4Pmk9i3TGD+3BGTk+QtF2aQlU+oiIxifwbiKi/safy4j6RTB?=
 =?us-ascii?Q?7lMQ0WWKUKgU5Tz2icP8m+VCYkIvludyhVQO4OXN2pFkUYG/6r8jEYHVkPRU?=
 =?us-ascii?Q?ppK7Ec2NysHpGmRwPWsjECfpoFVoSo9LYg4KNmEEWG+JEviHEWsjX4MihqJG?=
 =?us-ascii?Q?XN6VjIUNceNVw+XHgZxjpqUbppUgI1dHXK08ZEZE5Cv3bt18S/jYl4JTZYB/?=
 =?us-ascii?Q?cP4KcygUDJR/s33fD9bdZeuj7Rut8ymMWT1bUpn7mddUGjKy+kwL0CZqmxk+?=
 =?us-ascii?Q?JKXcnIFivL74vYNXZi4T46YIM7YqQvQmLsRJMQdDqkPRkFm4h5ANVQpZSLkl?=
 =?us-ascii?Q?AdbYDsAGoXVExaNozwurWGWNM6nmkQ0ThfGku6KGdVy89kSHM9MarRE+Tr1d?=
 =?us-ascii?Q?kBERIO/uIIsURjFC3Z0gMqOORMElxHawEjZC1tLdEROu/ezYvX6+RYx32iCM?=
 =?us-ascii?Q?/ZIZaGc07KHNOVfkKj4Io50wNealH+2K1bFEtuoS1//CsJbNyRFUWUctxzLL?=
 =?us-ascii?Q?gLXYRTE0A6pfwMlnqHoE69bxazmI8kMmgDygA2SNDsivDWeTFM/hAuLngc7E?=
 =?us-ascii?Q?MFTeS4KRnOGIUIFqZjA9VhGDIyi2NcYJZhZWrqGeUcp8vkPlCj8y0ziTT3eE?=
 =?us-ascii?Q?XEHju347WipotS0Dcbs6/os4Bn9/aBRGuzJ3HpVSYJxUHzY1F56KpqwQY2tg?=
 =?us-ascii?Q?9Mhzj7IaF6JbP4blpxKtbASqRUJ1jvJkSfMJMEwNkK9aVmB0ZqfHrdSGYtCN?=
 =?us-ascii?Q?J7OAB06hlK8YFH99yVV70m75t25uR5KPrQ5zUerClCQgXNsQh0xHUm9HvUrr?=
 =?us-ascii?Q?XPuqB+SLWdJnlOOHNeVR76VoRssYqjKPQERZkUxqsrXwl0fI2jVBNQDHaEmV?=
 =?us-ascii?Q?cXRht09j9K3WfzfFJbenQdudb1sxQxw+6wMYsNDDf11Q0rEQF0tHXXrtARM7?=
 =?us-ascii?Q?NKY7F59TAHbqQBUa8qCms6ePtbJuyvItin/k4nDdVHz9Glof5YmTBHmm9gLS?=
 =?us-ascii?Q?zKo7RfctJV0WA6aI6MsPadlcnYZfKZ+W4/3HURnqkwcSMuNkBY5QtHbYCUpZ?=
 =?us-ascii?Q?Q90YehFTjtXpNSEhEDySZT0PkGprFg/xZjlaJe1ldvHKH0EMt1lbKGdj4W4T?=
 =?us-ascii?Q?lCTUY9qcbQInh9cs4dGy6797bYgCcZ7601sckE6f59lon8TEEpj12z57cQ7e?=
 =?us-ascii?Q?xZX6MWXgBaw1Zw6MMBUEvhf6AvCwQl276LfbzG4YVTQSMdMaLhsaPnmDazuu?=
 =?us-ascii?Q?bvsidGPP8vOZgMJ86G2En6gGV6AyuioqNsiVvX59hAzG7e93drehmSJDsPf0?=
 =?us-ascii?Q?KkZ2bLQLZcLzbqB4RyB4BlretYCPlPKEohTmzaWBfAZDtSzss5/5t8zEQaPU?=
 =?us-ascii?Q?SqqcR6ss3CwlOpPGcFJt5pzatCZVhst+moI67VrbXKvS5YkA4tLpCEATtQ/D?=
 =?us-ascii?Q?evzRvkO+1UVrAmp/46iqrcGFPLqFKRHMuPD8UYy0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9615d8d-cf2c-4ad7-a7cf-08dd2e9a0119
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2025 21:35:13.4176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NlvTCPmDaWqPqFF8UxXCZZgWWy0erI7UW6Gf4nySuKuSom3vo5k6qcLOnbFavpDVRvPXcXOm+6lr3SJdFxy0JZOAUz7232pVIkW7iVSO02Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7391
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Richard Cochran <richardcochran@gmail.com>
> Sent: Monday, January 6, 2025 7:16 AM
> To: Jiawen Wu <jiawenwu@trustnetic.com>
> Cc: andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; linux@armlinux.org.uk;
> horms@kernel.org; Keller, Jacob E <jacob.e.keller@intel.com>;
> netdev@vger.kernel.org; vadim.fedorenko@linux.dev; mengyuanlou@net-
> swift.com
> Subject: Re: [PATCH net-next v2 3/4] net: wangxun: Implement do_aux_work =
of
> ptp_clock_info
>=20
> On Mon, Jan 06, 2025 at 04:45:05PM +0800, Jiawen Wu wrote:
>=20
> > +static int wx_ptp_feature_enable(struct ptp_clock_info *ptp,
> > +				 struct ptp_clock_request *rq, int on)
> > +{
> > +	struct wx *wx =3D container_of(ptp, struct wx, ptp_caps);
> > +
> > +	/**
> > +	 * When PPS is enabled, unmask the interrupt for the ClockOut
> > +	 * feature, so that the interrupt handler can send the PPS
> > +	 * event when the clock SDP triggers. Clear mask when PPS is
> > +	 * disabled
> > +	 */
> > +	if (rq->type !=3D PTP_CLK_REQ_PPS || !wx->ptp_setup_sdp)
> > +		return -EOPNOTSUPP;
>=20
> NAK.
>=20
> The logic that you added in patch #4 is a periodic output signal, so
> your driver will support PTP_CLK_REQ_PEROUT and not PTP_CLK_REQ_PPS.
>=20
> Please change the driver to use that instead.
>=20
> Thanks,
> Richard

This is a common misconception because the industry lingo uses PPS to mean =
periodic output. I wonder if there's a place we can put an obvious warning =
about checking if you meant PEROUT... I've had this issue pop up with colle=
agues many times.

Thanks,
Jake

