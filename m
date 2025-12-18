Return-Path: <netdev+bounces-245325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF910CCB7CE
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 11:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C70A73005527
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 10:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4A132A3E1;
	Thu, 18 Dec 2025 10:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O4iwRUGT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA142C21DD
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 10:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766055075; cv=fail; b=cwmw3VPxcfceyR0r1QdtEBR0WYC4+El0vxmrnxILcyuwkS8t+l3tvxx7NnAE5mLJtIr0DGUyLKMtk38kGkLTEugUZ4PDjUqY8SL38QecUCCbwuREJlKOyLFRR1RmtZnQrO2OC0PtaA6aAfCxeXZX+OyRz9rgHCrFBEV8gu+MENM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766055075; c=relaxed/simple;
	bh=A9QasLearHYdb9cqFqJYe8UChc3dTG+eqjfooVtqUgU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r9hL6m7RPOz2opOpPOgBAdZHnxHWBCnxTfNze5VqjhJr7ZivSjJ1nG7YremPoj6WudZJAxGVRUb9uAAhZQ9f8kqX15JUedyYgEhfva/cbMa5Xw4pz9iusTu3msDVPYLZoWPGhPgWdbL4IK49Jc/cBKEdOFosbTfxvJ0NJh0VpzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O4iwRUGT; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766055071; x=1797591071;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A9QasLearHYdb9cqFqJYe8UChc3dTG+eqjfooVtqUgU=;
  b=O4iwRUGTwrfK1xWkdRDPWSTHcVPulN9SFkf0VYpX8CVQetZxeiITUIwI
   VV0oMGxKFIXy4IYehkFtOzBMSNe9n6YEF8+FAcSWVAadMOFztKfxCb+Bu
   OgnTg4aJvaqtOuWDVzpuVLT4eBoJ+xFT7dYGuu8a3ZjU5+RAmRL+Cb10s
   NbBA1/4tco9SxkPJ0MxfTszwS56QeIqkMDM0eUo4fic4TdWT7UjnuGcw0
   Tt4Zy8QwUT+y6ENF1UatNzyBxcC48Dp88g1U5LCuuHUSElL4I7PTHscsD
   yISRlT4SHxuMg1i3CwAo3dgy48U/9BSVH5asVtxPX3SRGwDDJ427eGYEQ
   w==;
X-CSE-ConnectionGUID: meuVSwIERyaaTdLD6wgXoQ==
X-CSE-MsgGUID: +NpnQUcKT0W9s7RMXUSUMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="67002219"
X-IronPort-AV: E=Sophos;i="6.21,158,1763452800"; 
   d="scan'208";a="67002219"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 02:51:09 -0800
X-CSE-ConnectionGUID: ZtnhDr0aSU+zPN4IOmu81Q==
X-CSE-MsgGUID: Vf2Jr742Rf6mQ1QBoQKtgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,158,1763452800"; 
   d="scan'208";a="235980899"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 02:51:09 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 18 Dec 2025 02:51:08 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 18 Dec 2025 02:51:08 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.45) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 18 Dec 2025 02:51:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3NcCnqK57Aq0Ab6epStehSWH99JX7LzqPBgF8A1U4+GOj3VkDMt/pvbv8XSXu/L6DZE6h0FBelrb3QgOpoNcQ7I9nYG2XCZ0++cbv3A/e0CFzMYrGKXeu1ajP8JMgEIht9mr5g9cvdGHACol3SmsKkgUsKrR4D6l1GUSCdx9tkK0RtCtF5YSqU7mfzIU1opcfmSe3mBe8RuwqF4R4A3KM2+PUZDIZTifcovx7FsLV3y0DovCGmNXddOwKk5sKfuFmPDAIw/BHx/+sUJbff/a5Q5a9UitnVev+UnL0hOTd7fSdtLjWy6zzSczMFWE4+R3bkf+eATvjcrKM39QkcJLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9QasLearHYdb9cqFqJYe8UChc3dTG+eqjfooVtqUgU=;
 b=mByjpPM81+MJ/UjBtWR2jHSoY1wPqITe12IN4pFOoFL+/eywTQmO5LiXczkmQYM1Di9fOacBK6nMGwZfLwKm40+2dvPKHMrhbCNgMz8X9xKuUC6q9zDIO4M0Lnzc6cVuZJmboWO91MmfaPKpy2FSnoazANryd5/13AK5Urbv2A2woiy5eUBI4zbs0lslvGcD00mupwalO+5R3ojjQr4+yplfGDqIGebINwVwNv23xF5xLSoyl++iSarwKKpfARnMrO4/Xk1xdNpbI4yl4PGAOvxiokduhG8Cm13JUexxNg4rhmt2BPUspd6AE37wzBSJGDz6QmZBofcJYd7AeZz8ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by IA1PR11MB6196.namprd11.prod.outlook.com (2603:10b6:208:3e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Thu, 18 Dec
 2025 10:51:05 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 10:51:05 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: Simon Horman <horms@kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v4 4/6] ice: use u64_stats API
 to access pkts/bytes in dim sample
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v4 4/6] ice: use u64_stats API
 to access pkts/bytes in dim sample
Thread-Index: AQHcWltJ0k002+7OEUyfkChJZDnebrUnJr8Q
Date: Thu, 18 Dec 2025 10:51:05 +0000
Message-ID: <IA1PR11MB6241560C2DE20ABC2E2981628BA8A@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20251120-jk-refactor-queue-stats-v4-0-6e8b0cea75cc@intel.com>
 <20251120-jk-refactor-queue-stats-v4-4-6e8b0cea75cc@intel.com>
In-Reply-To: <20251120-jk-refactor-queue-stats-v4-4-6e8b0cea75cc@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|IA1PR11MB6196:EE_
x-ms-office365-filtering-correlation-id: b590b5a2-96e8-4f4e-5084-08de3e2357ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Y1Z6bU5ZcnE5bEppNy9hQXpabDNmOFFOVEE2OW93c0daRGdIdmRLZEhlUVJL?=
 =?utf-8?B?eVZ5OHlnTTA0cTlOMzRicU8vWTEvUTgrUk93V1BMZnk4RjI5V0pxcTNwMndp?=
 =?utf-8?B?S253STJTempwK3h6blBXT05NbTJocFdWWUxHUmF0TnZQSTI2UnpwRWhmYW1Q?=
 =?utf-8?B?alVNNklpR3ZONVNYNXQ4bXVMS3VZYktFakxoRnFUZ09tc20yK081NDlzbGU2?=
 =?utf-8?B?eDdiUTFGc3BUYkJVY0lRMlBBbysxbGRraXBFZ3RrRG9iREJtRkdLVmprNU1B?=
 =?utf-8?B?MzdtZnJYUFBkd1ZMc2Zud3g3K1JQbFd6TUJVNno5VGdzYmNJd0I1MjdVRWFi?=
 =?utf-8?B?MUk5UTFZQUF0VDBSNFlsY0lkdU1jMjhPSm5UeEZhdXkvSzlmRE9Nc1c2QU9h?=
 =?utf-8?B?eVRHM0tpQWoyWU5yeGhlV01qMGxITFVnYTFYVUluRjhHeFVEY0NIUUg2cS9E?=
 =?utf-8?B?YlptQWJVTDVlQ21DRXZGTG9QbE5RYVlvSGdmSGgybUVrWTNGQ3EwUFd5THZr?=
 =?utf-8?B?WlpkZUtrVUp0eU9KaGhsTDdYUFNsMm1ZaTdyeHUzSjRQWlRaOW9hNDRlTXpR?=
 =?utf-8?B?elFKR2hLU1BSR3ZWOC9MKzArRExKa0ZGejQzcjVJVzBsY3FqaUd4bG1GZlls?=
 =?utf-8?B?RzJXd2VzczROMEc4aHRkTEV5cm1oUmdiUWJpdEZiMms4cE5mdGUwVFk5WDJM?=
 =?utf-8?B?M25uZ1d2UXVXdzIxZkloOFlYUzNyU29KelFOZU0zZWJQeHNIWE5Iam1Ybm9m?=
 =?utf-8?B?ckc4YlNKK2VxK1VKNmVvVXlrOXc2ZU1TL2JqMUxWL3UzTVp5VHNIN21XT29t?=
 =?utf-8?B?NklEMmlsNDhzU0pYRmhPelp4RW41NnA5Qm5IZExGeWVMUHA2azVtZVJJYTVz?=
 =?utf-8?B?bGw2WHV6cmVqUUZKOTVYQU1pNFlKNHV1QkxybENYdURpY0JDb2VQenlLaHpZ?=
 =?utf-8?B?dlVUVU9ZQ1NJMmNaaytFNnRtZVk5dWN6dkRUNDZnYjlCNzR0YUdQcGU5MnhX?=
 =?utf-8?B?WFEvMmliYlBDT0laOE5Ca0tMSXV3T3RjZjhzQk9MZkNhT2hCZG85MnVkdHpD?=
 =?utf-8?B?TmlPcjE3aG8zekxGZ2laU2tNWDBVV0FhdFFab0wwVFZnWUlkMVYvRFN6WFNF?=
 =?utf-8?B?cUlGaUlJeTErcDJLN2hCN3lzaW9RZ3FlSzN4K1dRYzBxZVZkWEpJdkFDSlFU?=
 =?utf-8?B?RSt1Z0tzOUhUbUY0cEJjWHpIZjM1dFl3amF0b3Jsd2VWc21tY0NtdnN1SU1P?=
 =?utf-8?B?NzZuRWE5M0NIaFliQjNCS29wME5aWGpTa0JRY2JxRFg0QUhZM3J2OUZ0RVNJ?=
 =?utf-8?B?YndpYlhFbHpGcTVmS05FdEdJSjYxQk9GdThZZDFBTmZGR3QxN21QRFVyMVNC?=
 =?utf-8?B?NW15TWJEY3drd1gzd1pOempYaENTSTBKODV3TWhYVFg5aWJ6Sy9sTkw1Y2Yv?=
 =?utf-8?B?UlpCR2l3QjEzS3NnMERzNHpHalczUkw0SFdDenE0M2JSQjZGS1V3WXNOSXow?=
 =?utf-8?B?S1F4QkltM0FDNUl6MU9kWFpUR2l0aFZCT1JZTVdIUGF3Y3dNSDVYOFJaNVlt?=
 =?utf-8?B?V3VXRHVvMWh6Nnp4ck1lZ1lOTURPdEVEMlQ2WUcyODAwM3l5VEluRW1rZXJE?=
 =?utf-8?B?UXJIQ2dPSW9BMysyV0Y4K056Vm45THVTTlI5cDJXV0RjcEhrNDdtSU5kUWJO?=
 =?utf-8?B?OUNFY2M1enNpeHZvZUVGa1RHR0NWejN2RkE3SEs3U0kydGxOQ3dHMDJlSjN1?=
 =?utf-8?B?UWs4d002V09JYXNRV0YvZDRCZ3ROK2pPK05KZTZiZys2bkZsaVU4UDJEUWRm?=
 =?utf-8?B?Y2R4clpYd1MzZ1pOa2pvU0Q1aEc2S21GZWFpTFM4RG1tVFN6WlZId3ErL0VT?=
 =?utf-8?B?UmRWQVRKRUpodElsRXJYN1dRRVY3NzBaclJ5dFVwY3pXdzVBbW01TUYvWEFw?=
 =?utf-8?B?TmtIb0VxOHEvNjRkdURwOUk5WGJWR3V5MVl3S3hMVko4OHQ3RlFLanYzemVI?=
 =?utf-8?B?QlJZclU4TEJCZWR3K29MV3YvN0gvNHE3ZmwydkhSalMrMWJwUUV1WnhZeFh6?=
 =?utf-8?B?MFlONzVFdzhCTGgwa25lWTVPTUJsaG9heEIwQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGlnYklSWjF6QkczUXBETFVMZ0x5WlhpV2x3VXVyOTR2RmF5TUc2MmM5a2Nl?=
 =?utf-8?B?VHV2L1padFhkWVhiWVNhV3hMYTJCTWxDb2pnUmdlTUxIM0hFVFhBWkpSRU5Y?=
 =?utf-8?B?QWNQbTIwejY2cS9GMGdua21qekxZUStZWEgvcjA3YUQzbk02b1BHZjlPN0Fi?=
 =?utf-8?B?K0Yydm85SVJjNzBucUg5ZkZRdWJ0YWtqSlFFVG43YXRHYkpwZFZueGUzWTJs?=
 =?utf-8?B?bXBxMC9vSTE2ZmpuVm9GZHB3dFA5NDk1eTVsejdETytsZlJtdkF1T04vd21K?=
 =?utf-8?B?cjdYL3hsUkNmY1VQUkErbmhwajVMSjBxUU13amFnQkZBZFV1Mk52Y1QrZ2Zx?=
 =?utf-8?B?SXZSNFllUXRTQ1YrOEdHckZ5d04wdXVueEdsU0RhU3lTRnJyRlUrU2g2V0N1?=
 =?utf-8?B?MUc2OU5PSkZMWFNha2VjQTQ3NzZmRUkzQmlvQXgrNzgrTHFwOGsrUjcwdkNm?=
 =?utf-8?B?elhvM3hGSGFabHo3Unh1M3FsY2tMcDI3RGZDYy9rRzZpM0d5MnliaFFTT0Z0?=
 =?utf-8?B?UllybDBZaytnN0h6cHFxV05sUUtCRzhkMlBmUTlCSWhVN3kxeUw0MEtVbWhO?=
 =?utf-8?B?ZTJZT0tDYy84RUM1SnlzQVNFZVZYc0VEYWZzNzNuRnRwK0JZMitvY243Zkg3?=
 =?utf-8?B?akxIbkIrTlYwT2lrOEN1dzcxbUhDbDNDdlFxRythTkhSc1g2SzVNKytHdWYy?=
 =?utf-8?B?aCtXR1NObElRdUNobHdnUGpyRmRkb3l1bngvbjJvWE9UMFAzK0pwSDBiQ2U2?=
 =?utf-8?B?c0tENTdVVEVzUk5ITkZKdnRVSmFpRnRDNWthZXo5a2ZxbS9ENW95TlAxTHUw?=
 =?utf-8?B?cDE2akl1RHgzcFRNbzF0TkRCMldkR1BidzNkbkFRMjlzSzBVZ2VQN3RjR3RR?=
 =?utf-8?B?MlFQRXVZUEQ1S2hHUlJkV2p1dXJSTytrQ0dUL3BNQXZMNG1CT0wwa0lZaU5S?=
 =?utf-8?B?QnpzajZ5UTM4anJvcGVndDArM25QdmdnSk1zVEVoNjR4dGZaSnlkR1BkL00z?=
 =?utf-8?B?d3U5VTAvNEc5cXZPQ3Y2ckFtYk90dWo2ekJMRzg0Y3hBbnlmdWVQeWt4VUlB?=
 =?utf-8?B?cnFmS21oWFRTSFNFZmN2MG0vSzNXN2luMXFOZlExeHk1SWh4ajVOSDZsRTUr?=
 =?utf-8?B?KytrcTVBUElKNDgrMkJDcFpMT0lyaDVqTUs5c01jd3ZST2l6STBqSUYvbGVw?=
 =?utf-8?B?VGxpZkRydkJyeU1YSVpjUElaZER4aC9DVzBibmdpK0xOdmxmY3Z3dFVNRjNq?=
 =?utf-8?B?THNXRXkvYzZwY0s3bjFMcFBRVDFwWlRoWVBuenU0OGpsSVNrQVo5ZENOeFNw?=
 =?utf-8?B?bTkvSlk2SEllQ05KRzFkZnY3UVZzU3c5N1pORVd3K25YL3huazRTdkRSWnd3?=
 =?utf-8?B?MXBXajloWFVUaWg3ZFdkK1BRd2lxNmFXQnViZFIvY2N4QmU3ZFUzTVhlYVB3?=
 =?utf-8?B?MVFscW1ibzlmeU1BdXpCSC81Q3NQSWNIbndBc2hMRERXK2ZFdCtiM1kyeDNh?=
 =?utf-8?B?MVN3bUR5M0RmSzQyR3RkendqelhpRUJlNVVBeGRHSWozM1N2SW9rMVB4b3R2?=
 =?utf-8?B?VWtway9IQ2FrMFc5Rzg5S2hqVUV1TWdDaGw3QjlQd3JZQWRseFkzc0tOcnR1?=
 =?utf-8?B?Z1oyd2xzajZ2ZkZXTVdZb3A2bzJ3VUE3NGdWVHpJWGNPTzAyYllFdTZsMGdj?=
 =?utf-8?B?SmlrT3dLUzduNVJZOS9zRHczYU5GVmhGWmR3ZTBZdGRFKzJCMVpTT1FJdDEw?=
 =?utf-8?B?cjlCSVphNnllUmQ2bUY5VE56WFFEd0xWQXVNZTAyNWIvaWNwQ3ZzdzBMdjk1?=
 =?utf-8?B?Sm8vQmNEcTYzS0lxWHA5b1VIWVB1aFZGS1JkZDBSWEE3elNETi9ULzR2U3hh?=
 =?utf-8?B?dXR6aXJUSXVXK1pPMUVKVVp3TnB3dUFtdzBFVm1FNW9VWDhIcVpNajN1U1l4?=
 =?utf-8?B?c3BMMldGc0JQajg5VTJEQ3NCMkZtcDRKbmZTc3Naa3gxNXplTDlmbDNTcy8x?=
 =?utf-8?B?WEZBNzlQSGk1cWg0TkxGNzhVR0EzczJheXNJNlNUM3UwODJVbFQrZTQ0UTNn?=
 =?utf-8?B?MkYrb0JxUVhmellQVUVZT0F3aWZFWkVOS3Y2SUJZakFvREdFbHFJVjdzbHk3?=
 =?utf-8?Q?r8CpRfzTKYuAhOvzevNwZVu6t?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b590b5a2-96e8-4f4e-5084-08de3e2357ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2025 10:51:05.2725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ugzNzPPnrkX/uea21aRopv93AL5CrbIpco4pOPB5DITszbYX0yE/48v3PYGGLBBaWhYw26JAsIJi+hNZUljLxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6196
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZiBKYWNvYiBLZWxs
ZXINCj4gU2VudDogMjEgTm92ZW1iZXIgMjAyNSAwMTo1MQ0KPiBUbzogTG9rdGlvbm92LCBBbGVr
c2FuZHIgPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPjsgTG9iYWtpbiwgQWxla3NhbmRl
ciA8YWxla3NhbmRlci5sb2Jha2luQGludGVsLmNvbT47IE5ndXllbiwgQW50aG9ueSBMIDxhbnRo
b255Lmwubmd1eWVuQGludGVsLmNvbT47IEtpdHN6ZWwsIFByemVteXNsYXcgPHByemVteXNsYXcu
a2l0c3plbEBpbnRlbC5jb20+DQo+IENjOiBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+
OyBpbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9y
ZzsgS2VsbGVyLCBKYWNvYiBFIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+OyBMb2t0aW9ub3Ys
IEFsZWtzYW5kciA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFtJ
bnRlbC13aXJlZC1sYW5dIFtQQVRDSCBpd2wtbmV4dCB2NCA0LzZdIGljZTogdXNlIHU2NF9zdGF0
cyBBUEkgdG8gYWNjZXNzIHBrdHMvYnl0ZXMgaW4gZGltIHNhbXBsZQ0KPg0KPiBUaGUgX19pY2Vf
dXBkYXRlX3NhbXBsZSBhbmQgX19pY2VfZ2V0X2V0aHRvb2xfc3RhdHMgZnVuY3Rpb25zIGRpcmVj
dGx5IGFjY2Vzc2VzIHRoZSBwa3RzIGFuZCBieXRlcyBjb3VudGVycyBmcm9tIHRoZSByaW5nIHN0
YXRzLiBBIGZvbGxvd2luZyBjaGFuZ2UgaXMgZ29pbmcgdG8gdXBkYXRlIHRoZSBmaWVsZHMgdG8g
YmUgdTY0X3N0YXRzX3QgdHlwZSwgYW5kIHdpbGwgbmVlZCB0byBiZSBhY2Nlc3NlZCBhcHByb3By
aWF0ZWx5LiBUaGlzIHdpbGwgZW5zdXJlIHRoYXQgdGhlIGFjY2Vzc2VzIGRvIG5vdCBjYXVzZSBs
b2FkL3N0b3JlIHRlYXJpbmcuDQo+DQo+IEFkZCBoZWxwZXIgZnVuY3Rpb25zIHNpbWlsYXIgdG8g
dGhlIG9uZXMgdXNlZCBmb3IgdXBkYXRpbmcgdGhlIHN0YXRzIHZhbHVlcywgYW5kIHVzZSB0aGVt
LiBUaGlzIGVuc3VyZXMgdXNlIG9mIHRoZSBzeW5jcCBwb2ludGVyIG9uIDMyLWJpdCBhcmNoaXRl
Y3R1cmVzLiBPbmNlIHRoZSBmaWVsZHMgYXJlIHVwZGF0ZWQgdG8gdTY0X3N0YXRzX3QsIGl0IHdp
bGwgdGhlbiBwcm9wZXJseSBhdm9pZCB0ZWFycyBvbiBhbGwgYXJjaGl0ZWN0dXJlcy4NCj4NCj4g
UmV2aWV3ZWQtYnk6IEFsZWtzYW5kciBMb2t0aW9ub3YgPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50
ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKYWNvYiBLZWxsZXIgPGphY29iLmUua2VsbGVyQGlu
dGVsLmNvbT4NCj4gLS0tDQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfbGli
LmggICAgIHwgIDYgKysrKysNCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9l
dGh0b29sLmMgfCAyNiArKysrKysrKysrKysrLS0tLS0tLQ0KPiBkcml2ZXJzL25ldC9ldGhlcm5l
dC9pbnRlbC9pY2UvaWNlX2xpYi5jICAgICB8IDM2ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysNCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV90eHJ4LmMgICAgfCAyOSAr
KysrKysrKysrKy0tLS0tLS0tLS0tDQo+IDQgZmlsZXMgY2hhbmdlZCwgNzUgaW5zZXJ0aW9ucygr
KSwgMjIgZGVsZXRpb25zKC0pDQo+DQoNClRlc3RlZC1ieTogUmluaXRoYSBTIDxzeC5yaW5pdGhh
QGludGVsLmNvbT4gKEEgQ29udGluZ2VudCB3b3JrZXIgYXQgSW50ZWwpDQo=

