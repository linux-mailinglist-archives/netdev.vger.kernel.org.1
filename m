Return-Path: <netdev+bounces-218128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFA1B3B32F
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 08:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B19601C8143E
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 06:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7F72309B9;
	Fri, 29 Aug 2025 06:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HambeXvh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577D823A9AE
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 06:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756448248; cv=fail; b=E24u0JIZETzxI2MuKADy90zgrXbB4tneiL6rqn9eNpyHKKJaT0WyWNKQDiltTGHQClR0On8zFUWHrGsERFsyi9c/HG/ny5uefAaMcn051pRoKnWxsba1ctDiEKp68kXX1MLFBKZ2qlcZDJxvD7Ha0Ub6ZpXvnja8hLo0N+y9TDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756448248; c=relaxed/simple;
	bh=vLoMfE6BqIhoTID2LJUTtpSPNN6lxgi0vLybcbw3CyQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZLcckKHwgxEImr2/TZAwHCnrGY7y7HQkdijsnplNOis67y780rdyumug4ZuXZvGr5U+2cofwLp8aMBuLvJgkZ8OjDo2br39BKV2OSzKwmIste+bLXGtSsm67RVzqe7abRG9BBFR2KmF4E6jQ07+27boP+O9bTCOw7x31nBq++OA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HambeXvh; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756448247; x=1787984247;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vLoMfE6BqIhoTID2LJUTtpSPNN6lxgi0vLybcbw3CyQ=;
  b=HambeXvhqyOJouh3fo+czASB7H8ZuXu8vV/HaIf3YaSBpZODhO6MB4ZU
   4NmUHcmyZQM+mSjsKtUDD0CH0l9oCAzo0+Ex6WYHM88fhTUOwb6Cdvnfb
   3a/DFh9EFiZPJxK8OROWT68EX5/F1B84jOrZRu/osxwhOMzA6EdxFWuEU
   ovbucSrOYfu3MST+ooOq5P2p8UYJfjbRvJxtmdGA2p9W1LCanWadL7ej5
   UoHZ4BtcM597nRG+VmHIG/4tM4GYjt+eBbitkk/kv8DEQ3cerXmz5ZNz/
   kcgvr4u+G2VHnmBmGHEm3Q/HIB2RaRIcYst/gh889wU499Fz3gK8HPzBf
   w==;
X-CSE-ConnectionGUID: jBWxmXueQ5OFoTr0N+0ZGg==
X-CSE-MsgGUID: oB8+krwvQFiRWHu1urLmEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="69324817"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="69324817"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 23:17:26 -0700
X-CSE-ConnectionGUID: 1R/nS9mQRRy1X6q2n9i2DA==
X-CSE-MsgGUID: pXGTlcErRMSAbm2bYAIiSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="201247780"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 23:17:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 23:17:24 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 23:17:24 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.79)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 23:17:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arAE+9I9nuXVQJKhMgiN/AqTUCLMb8CGUylSe9+HneqajPYN5cF/Ku7aBUNy6A5ykJaPrkePYtb31Rv58Bn+Z02pNLUnDee4haoxchVLZqVJ2UNqAb6ndOBVWwEcLnSR2uk8J7e0DTcVWV3kkbHLX4XNObu5ojLhZYSRc0dPy4TPGdGLCcdsXu4cxtPw9qEMdWtKDQbwpcNmu+5ZdKsBTcv/jyu0ibARO9tyouZE8rLWR3iFLixir2SYYiAe+Q32vOGa9l3Ojg96hhuBa1hEKssO9iFbRv3cOl0/mtBp4NOTKmXaFTbpU5wgFpthGI9iV07MjzKCvG9v/9FDlQ59hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxnIz+8YB6B3QCy3KUCV0kYvUt9MZeloRRCJcYPuhs4=;
 b=sKsIH0OsRHnW6qeKS2D0LnJyfASQU0lUCbbTVeSVFianbaOyDQQdzVqgVRkx5tjkGwvENVsV4uxHa+Y37AdBSrvaL52peZSCRoTCU3FhBwC48ChcabrrZU5jB2p+VKgYH+IYVdwskj2DLdz8W4+14qdqiTcztRP0vTbuIA47mWoRSbnfvX4ZBMMvRlBtbMJpXLhP5Z4Jki+WW7yru4t0M4AvtxDY6Mj76pFPwwKu7678trvsSiIdJ6/yaANsJLVFQq8FTIFTgVfQgPgsfOCS77us7vw2QVkzLV/XqjpC16hiWLoH2HQ1ARDWls4uzUUxuFPUtJzSaPQ1XOA6+AYQrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by CO1PR11MB4883.namprd11.prod.outlook.com (2603:10b6:303:9b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Fri, 29 Aug
 2025 06:17:22 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 06:17:22 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Kubiak, Michal" <michal.kubiak@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "pmenzel@molgen.mpg.de"
	<pmenzel@molgen.mpg.de>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kubiak, Michal" <michal.kubiak@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 1/3] ice: remove legacy Rx
 and construct SKB
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 1/3] ice: remove legacy Rx
 and construct SKB
Thread-Index: AQHcCH0qVImSZcdHSESzUZFGK573JrR5R40A
Date: Fri, 29 Aug 2025 06:17:22 +0000
Message-ID: <IA1PR11MB6241CC833C66A27566F274C88B3AA@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20250808155659.1053560-1-michal.kubiak@intel.com>
 <20250808155659.1053560-2-michal.kubiak@intel.com>
In-Reply-To: <20250808155659.1053560-2-michal.kubiak@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|CO1PR11MB4883:EE_
x-ms-office365-filtering-correlation-id: 2c332a7e-239b-47f2-2bff-08dde6c3b711
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?JEEw4e5IPq0FdUgIH00pHSc16NvVJeRwCC0t1ZJihT8UdyKqDBg1bKHk7JnK?=
 =?us-ascii?Q?Cp6CyhCHgHlW1PyJYNCmylglBzk6yV2P31iHCPZxVoAAqmByKvATiui8lsPJ?=
 =?us-ascii?Q?BNKMutXldsf+aH2wFWr8DZW6NESV9BlnlEFHARnI14lBtzEq3ca850+NHrEM?=
 =?us-ascii?Q?2MCVESrpU+Sw8n5f6QH+FNVUYWBGrG29CezUNkay4wGw6bPoCrSc+6NohfSZ?=
 =?us-ascii?Q?Yi437N06/TLrK74DEWTC5PIUjtOvA4S2zrrGkFjjYO+wb6/qKzkIYBQor/OD?=
 =?us-ascii?Q?jwqZRyEz0cNASe8FGLs/mjL+Me5VWdTohVLiaO2HkngvQiK9/3xotf5Vl8RF?=
 =?us-ascii?Q?kLsdhKyHsph3ZpfP/z6tKrLIcKuq07voA03wIU2feMbRFSTPOOIvkCheSI4/?=
 =?us-ascii?Q?+fPzXgFvAiZBLsECuk33EYMBJvWTcPQitBP9f2wVRoCMbJwkqGZ+DE9dF0Kt?=
 =?us-ascii?Q?sayvaECSpen2SBUTv+9yvK+nBwCXNnQW3uEUwnvxi1PfUyXRlhSPSU+PX8j8?=
 =?us-ascii?Q?39bLJQl2RwGpXgJzlTICnjVW/jvCAa8f/eppNUITALzVg9yxeUMOyTTl8Vk2?=
 =?us-ascii?Q?ukvlfJhqkv3KEtdumpw7tIjSWVjfiZA3N53WGlyY740toLIGq7M1Ixsb7mCb?=
 =?us-ascii?Q?aTppXE4NP2pG2BT0f29bztOdzO6TrO1OmYejbvrzoBbJLOGjoRg4fbswTn1k?=
 =?us-ascii?Q?a2TqKlj9cgnSSWBXSDlGYyOMT/MsP/1HTS24Us19qfu9ByuYZhxdui3PsPRg?=
 =?us-ascii?Q?D9FVqN2VzgbMxv0Jvm1EuEPX5wj05JRVulr33GYmTiYBULqtjGcIy+ge97vM?=
 =?us-ascii?Q?x03gv/WrZOI4zq3kQYxuHYt9URNeX7d8ukp5NiGZBDGuwO+gjvRzRyInhAnW?=
 =?us-ascii?Q?8zUaUNbc8DZrtwLaYt2IDrnjZPwd6Oz80hK99fn6QrUPLCNQbW9j1/RERepe?=
 =?us-ascii?Q?ydo6sj2emJ6CuYBuZLzO+RRJHfsoXrcaqlfg8dLsJLuUlUaIqxMvD2fWlJLD?=
 =?us-ascii?Q?+JF/Ifd71Ws1oaYuMvwditAwK/W21P97MUg1+UZLNfmP2j1NMISAsFjMHIPZ?=
 =?us-ascii?Q?rV1zAGbev0pfw0XAvNSStvC6lGF0cbBfCE2aFd4l4vMzfhLdbX8QVcSNiZ0M?=
 =?us-ascii?Q?DqUQt2iUAbTalnFDO7j93/UEqEn3snlN9cqZlpa3IQ3m3wS9cp3CQhZpGokj?=
 =?us-ascii?Q?qtBQq1+OsdRZ9BZbFBXYAWGYGD/cPjqD2qcw3W06jahwzAQQSFSpDORy2zvA?=
 =?us-ascii?Q?IRITLotAgz77XXGxTDwAJHw/ZAPd3lMbzF0l48VmfkLFU7XzxOKZPVwP+5bv?=
 =?us-ascii?Q?u79X+b6uS0ovq+7cP6w7q1IZxG5bF884GcpM8I8vkMtFv2rL3liaU4+Lk9eI?=
 =?us-ascii?Q?AGlAnxCwxdOj6oMLEPBM6sTPEk7ktVfDRWCNnEReyZ+vRQfG1wkc3ILzqRbs?=
 =?us-ascii?Q?C6vStfVnlapocys6G1sx/c6ceCLlkbhTtq22C0HUFkaSRyvXtKF338E+z0ZZ?=
 =?us-ascii?Q?pynmB5uIAQyAubM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+S9/+dEzbpBpJ9wwqgNRQVTAf4ri9O9htyuMoYTAPb+hiO8a4e5J/FwxpHaG?=
 =?us-ascii?Q?0ZgjEmAhPypTAlHuGlGOGtPJBRbNN4OD1jSCLyagLA333p8LWw0i09+2XzRd?=
 =?us-ascii?Q?hPJLfTdZxF1I6kYp5MBumYAyro6S/qVeY5SN1/sed+a89uosY4NOOxzjMDSI?=
 =?us-ascii?Q?KDJHu32GcZmSslVcUgpaSGbnQXBfEMvz4KrZ4QG8PvDpndYEWClxrDywPEyr?=
 =?us-ascii?Q?hj4JVSE53hD1QaJrIbvCZjWBdq8s2sQRpGPIewT4I+fuFpq064pUAfIHZADH?=
 =?us-ascii?Q?5YEcD3huZeaVRajTdkD2vpRC/R2zM6+mir+bYMz6w3PUSYiGFUezGudP3Nua?=
 =?us-ascii?Q?YfpGpBxgI9ehXTjBzkIsINm3JwTW4EyqeudJ7RwPyXDriGMzXGsRYFJilWjl?=
 =?us-ascii?Q?7v72tM2GE4dN4y/+ELbaqKvnTtQBbIdPQqDtgNB5NhJ080Sxl2K2QK+1IU2G?=
 =?us-ascii?Q?o96id50CjPjNjBXorc7ePfjNkpd4ib+cBDW/51pNvZgCIdKNDw7HYH3Z9dTX?=
 =?us-ascii?Q?K9+F/bDIX4OmgMsn7entyl0ZxgrlSpbau3N5I2Ew1ma94mIwz4XpXPCFvgIr?=
 =?us-ascii?Q?5L2arfdGTKRCxxMCVA6KbPc+X2bhvLiMtBM8CT9AqS26ql57JQpQ3q80oLX0?=
 =?us-ascii?Q?zC6UDZVacHrL7WmTUxApLNG72fuNJBl1ODkYEX5yBf2dDnZvc9tQcdnKR0Zd?=
 =?us-ascii?Q?kaQUFe/VlS8k+ZU5xCWjqhRvo9JqMAWNEBdHJ6amNvNBvb38POaAx8iocanD?=
 =?us-ascii?Q?WM0GpdCsrYNwKRSJdRFXt/qUB9yDqutivPm0fJ11GgBTCkrUzjN/8XaTbbvH?=
 =?us-ascii?Q?Q5NhuFuy0TmayKnjxqiQXEp/apZNdEWAZaOMxgg9f3DACjq76WcsuQJiiIh1?=
 =?us-ascii?Q?ZnfKZt0pFxSHWd3jdcssHVFxd/n/VSp8sVL1ZXbRualpmJAZJ2wQZUdP6msP?=
 =?us-ascii?Q?uS50eRKzOZD6uVWMxSOvJ0yzzXSZdm/9T6tWPlbvS3ZumbOT4qDlDdKho8Hk?=
 =?us-ascii?Q?JF78QvqzPcX394wo1xFnH184qJAmHf3nHpqN8u5+SmUXAyuzIfzPP5onBr28?=
 =?us-ascii?Q?ok8gf2BFO38iEhmif3x3Z000Hfivv1MenFmdkzP4fTmYRN5nOFjgCTzbzX2E?=
 =?us-ascii?Q?4follRoem3NpQfmrAIBLtRdMGENw8qnlr0ZmwslGxK+rQD17//Piilpcpzgw?=
 =?us-ascii?Q?S6xrBBobr2pfoknm2RRZaLq9F5sW9jwrhxuhiVx9a4+LCIpf7F5nnbEcNhz0?=
 =?us-ascii?Q?LwHuCY0c9Bwl8lKKC72mvf6ICLq/OfzIgCyillljgX35iJczb8XE0e1FqNTW?=
 =?us-ascii?Q?Nx3UcoQfwdtB4oxzP1chVRkliuTqEgyTBQM5XZSqSVPbqFf8sCsau6m2eSED?=
 =?us-ascii?Q?j/Zj51RkmiXV3do6iiyBfLbD8gn50hohej+hLzO3UtR+QZHwpHel0CAF1rU3?=
 =?us-ascii?Q?hT3j0OSODoReNmnIwNi1kzDAEZFOJxDvAAGlG34JpSlC3p8PeNXNj2Pi15gW?=
 =?us-ascii?Q?H7Vx78b1t1qxMpRxduQtc67zWnZfuvCN7BSIM6qHP9JmFu0cIOUoE/Z8TJ8i?=
 =?us-ascii?Q?WMQlGC92ZUXCBh9OHfyOzL+61VM+1rYoobBN1uU3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c332a7e-239b-47f2-2bff-08dde6c3b711
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 06:17:22.0334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tX4vzdMxW+DDQmO9O0+cfIzpFbPI7T0AhqkBs5NWkvm1WzR+rak+LMGR62Zy2z6aptDZhyCs4/DYszR7fNShUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4883
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
ichal Kubiak
> Sent: 08 August 2025 21:27
> To: intel-wired-lan@lists.osuosl.org
> Cc: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>; Lobakin, Aleksand=
er <aleksander.lobakin@intel.com>; Keller, Jacob E <jacob.e.keller@intel.co=
m>; Zaremba, Larysa <larysa.zaremba@intel.com>; netdev@vger.kernel.org; Kit=
szel, Przemyslaw <przemyslaw.kitszel@intel.com>; pmenzel@molgen.mpg.de; Ngu=
yen, Anthony L <anthony.l.nguyen@intel.com>; Kubiak, Michal <michal.kubiak@=
intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 1/3] ice: remove legacy Rx =
and construct SKB
>
> The commit 53844673d555 ("iavf: kill 'legacy-rx' for good") removed the l=
egacy Rx path in the iavf driver. This change applies the same rationale to=
 the ice driver.
>
> The legacy Rx path relied on manual skb allocation and header copying, wh=
ich has become increasingly inefficient and difficult to maintain.
> With the stabilization of build_skb() and the growing adoption of feature=
s like XDP, page_pool, and multi-buffer support, the legacy approach is no =
longer viable.
>
> Key drawbacks of the legacy path included:
> - Higher memory pressure due to direct page allocations and splitting;
> - Redundant memcpy() operations for packet headers;
> - CPU overhead from eth_get_headlen() and Flow Dissector usage;
> - Compatibility issues with XDP, which imposes strict headroom and
>  tailroom requirements.
>
> The ice driver, like iavf, does not benefit from the minimal headroom sav=
ings that legacy Rx once offered, as it already splits pages into fixed hal=
ves. Removing this path simplifies the Rx logic, eliminates unnecessary bra=
nches in the hotpath, and prepares the driver for upcoming enhancements.
>
> In addition to removing the legacy Rx path, this change also eliminates t=
he custom construct_skb() functions from both the standard and zero-copy (Z=
C) Rx paths. These are replaced with the build_skb() and standarized xdp_bu=
ild_skb_from_zc() helpers, aligning the driver with the modern XDP infrastr=
ucture and reducing code duplication.
>
> This cleanup also reduces code complexity and improves maintainability as=
 we move toward a more unified and modern Rx model across drivers.
>
> Co-developed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
> ---
> drivers/net/ethernet/intel/ice/ice.h         |  1 -
> drivers/net/ethernet/intel/ice/ice_base.c    | 23 +-----
> drivers/net/ethernet/intel/ice/ice_ethtool.c |  5 --
> drivers/net/ethernet/intel/ice/ice_main.c    | 11 +--
> drivers/net/ethernet/intel/ice/ice_txrx.c    | 86 +-------------------
> drivers/net/ethernet/intel/ice/ice_xsk.c     | 72 +---------------
> 6 files changed, 6 insertions(+), 192 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

