Return-Path: <netdev+bounces-210631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 128C3B1415B
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 19:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 891E47A42F6
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 17:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B567DA73;
	Mon, 28 Jul 2025 17:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fYFDhB+T"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBA42E3717;
	Mon, 28 Jul 2025 17:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753724736; cv=fail; b=lwggHLufe8eQD3iLcfxhCbSi5H+TCVmIUJ9YmIR8AcK/CuXQU6BZfa8OjReKzCBrond0JMr4K+0QG+WIijLA/Mp6BVoqPzWz1TKRWznBnRNPY6pFtAQ5vqLDehQGfGNt8uKzgvq4PPnYn4yLcQgVq1+Jn6S/pvDSExfkrU09Mt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753724736; c=relaxed/simple;
	bh=Jps0C3qrN8Z8Iegpv7IFx2toqmcieukluRpopmT/5dc=;
	h=From:Date:To:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=BS1dLaqS2YbjTj/4tsEI9hq+mXZipE2AzWJzs5UCDaNOF/lFNQolnGJqflaBvVkqx+TYJPXmH6VfZFqzo4dYtUNGbdy/4Wids5D00wP0nzxF+mWWDW9vEJY7PcJKgAdXd03G549+KcrRvmbyc0ZyBksAMZztM7zGszsaTfCskFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fYFDhB+T; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753724734; x=1785260734;
  h=from:date:to:message-id:in-reply-to:references:subject:
   content-transfer-encoding:mime-version;
  bh=Jps0C3qrN8Z8Iegpv7IFx2toqmcieukluRpopmT/5dc=;
  b=fYFDhB+TbAJ8e/aF7+bncyh0/Y13QkiNKB+vv/HJ3ZGat6TJtg9LtwFb
   CtysSpxeziJzfftT7EQN1Kd2/dFzgWwgq8QJkLEzxovz6mXrgMtwZzmin
   AqYASzJRMRdLazr7Jb3MWfgEW4s6M0/uTUGFxi85mAIRhN3m0c/ucbivw
   ZEo0opGKCqT43CeJm263uqs4ClqrDIi1muUiwPnHWRVQg7rGJzRcebO3t
   SuimqPF/pfUBFAbrEyh3Wd9s/rSrrkcfr+C2BsRDDPemOuG0eyd13n4FM
   SV+frawygmQLZwLRaFgjBXUvWp8Ypo7V7HqPQEQ2M8dKBODLnjiNelKEO
   g==;
X-CSE-ConnectionGUID: 0U5GFtugTsqcvqfZIwic4w==
X-CSE-MsgGUID: +JGAUWhxR8y86mZ7B+nr3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="81423997"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="81423997"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 10:45:33 -0700
X-CSE-ConnectionGUID: LEH5AogVT2+AfUQTFtSzTQ==
X-CSE-MsgGUID: UCJocTGoTcGkQwT+yWCxOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="163253393"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 10:45:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 10:45:30 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 28 Jul 2025 10:45:30 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.89)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 10:45:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kyM1GGoKm1SkeHqOQExYvinQeK3XMAI46vzRBbmf2HQM75ejuq5GpB5X0IcfViZDcjhdfxmroYL8GBltwjT7l7b29HkDh710QoFCGg8cy2Qrv8RQE6LaeSPl0Np9KNBCmHtjDo9mqTuqkTaQ73suj9Di1yUlDCwcUDw0hDuEqfiCxob1MyuoXCL5c542f1WaIo/NsZ9O46Tw1kvYliWiDY9QJ8NcJ/1wDXsznUlvUazQP0VLpUM3EI4U2pFfMbzN3M4Ml0bc+8Fqsl5BqxyfXWlgxHIIaqzh5M3op6ALv/YzcaZafoX4D99NuLh9gGGU+Xu/KLgcnv+X4QGM2ZTHQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inBeELU+y50dETFZAWnbBE5TJACZV6vmjN2dx85vwzI=;
 b=wtcJtar1t44DRyi3CrF0mH5OLhrlMedWzzxFQeusFj9KEht2NeYLQZrTPLrORjQkIzILyMR8lg66Zt/PbQ15VxUJnU4aPRJ8evSV/9vY86niIycKW6y9XIBbpUkyyj9lIxqr6NTI/ooJZbv/F2sD0c2Ihgri5rytpNJYtdfixgUIivvpw6SYsw8+TjY15iKxHWKMD5jpg1a07jItj1CfiDR2QYU2zbQBe9+RP+0O4KO4DvWvTqzBrgR8+ov7ixZAyj/UCq4MrPjOQBpW/h7/tp660ThvLfY8m1pgi6cwhxMK+/wGbOEORgezn1/cuer5JSC3pmV+V622FXXv+W20mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN2PR11MB4581.namprd11.prod.outlook.com (2603:10b6:208:26c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Mon, 28 Jul
 2025 17:45:13 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8964.019; Mon, 28 Jul 2025
 17:45:13 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 28 Jul 2025 10:45:11 -0700
To: Alejandro Lucero Palau <alucerop@amd.com>, Dave Jiang
	<dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>
Message-ID: <6887b72724173_11968100cb@dwillia2-mobl4.notmuch>
In-Reply-To: <a548d317-887f-4b95-a911-4178eee92f0f@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-11-alejandro.lucero-palau@amd.com>
 <30d7f613-4089-4e64-893a-83ebf2e319c1@intel.com>
 <a548d317-887f-4b95-a911-4178eee92f0f@amd.com>
Subject: Re: [PATCH v17 10/22] cx/memdev: Indicate probe deferral
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0032.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::45) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN2PR11MB4581:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d9f36c6-1cbe-4dbb-d08a-08ddcdfe812a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WkdnQTBwRFVQOC92ZTBpMG5pV1lyTmVZQjhIVHozMTNJTHVLOVM3K09wdlpT?=
 =?utf-8?B?NnZKTWZjN0FRNGxZdExzWEZWZU8rZ3ZtUCszYndsd2FQT1FmZmFPbVZmQVVF?=
 =?utf-8?B?c0VCMHNlZ0NXSXkwVUtKQzh2d0ZuTnhyUHVHTlU0V05jODY4WFpCcWdyVSs2?=
 =?utf-8?B?Qm1aQTNHd3ZZL2pQSFIxMGxOdDFackJDeXBadTJibWNrL254YXRCWktaS3lS?=
 =?utf-8?B?eVFTQXZTR09YaGNnQndPTUExNTFmenBhQnRpSlg4Zm1rb09rcGgxQnpBekFa?=
 =?utf-8?B?YjNoUngzMmUvMHh5N1AreENVSU5NSUxESUtHaXFtVnZDSXJzeTJEWnN4TWNM?=
 =?utf-8?B?OTQ1RTFZcXdxaVdiTkZ4VDEwcHdJV2JYbEErMmpnY2JLbHNmc0NhZUdsMVl5?=
 =?utf-8?B?NWRzVnEyeWpxYzFXSzlVWDhRMU0yRHBIakNZQ0FKYlBkK0liOHFVUFQ3RVN4?=
 =?utf-8?B?ZWF1T2YyV0owMGJEaTJtcEJJUkRpcC8vRlpSY2cxenJQNlF2R28wYjhtTXFE?=
 =?utf-8?B?SWFicW1uTGFBTEZrQTdsNEJDdnlJRmR0NzdnMTZ6M3lwMUxaTEhnQ0o2M0lB?=
 =?utf-8?B?cVE1c0pTSDEzWFNSb2lIalhpSW9NbVI1QVo0eXJmSU5KVXNlL0NJUkRWK3ly?=
 =?utf-8?B?VDJ2VUZqWFN6NThLalZPbzBLWHlaTkFybTBNZHJsN0VoQXNOTUZVM1k2eWxL?=
 =?utf-8?B?QkRyUzV2dHBhYmJ0QjVWUTJpRmRIelRDanYwY01xZTRCcGpQcDZsdHR4dnZU?=
 =?utf-8?B?SVBiUkR1cm5wMGxydzZhWEVNa2NsY1JiUjNBN0huZ0x3ZzZjZWx2RmxDTWFs?=
 =?utf-8?B?NGNkNVAvUVhSQkpTSzVEMWI2djFReE5qNmw0clkzeWlxUU83UDlyZWJ3V2Ey?=
 =?utf-8?B?cjltbDh2RHIzbXYzS0lJdTVydW9HVEdGdFRZTWJwenJJc2MzaEVuZmVFZ0FM?=
 =?utf-8?B?Yjh2aXZoSVlVeXh2bWJ1TVFrdUpNQnhGMGhURUVZQ0FtTnpxcFhMTTd6UHVY?=
 =?utf-8?B?MTZ2enUwYXJ0Mlh3eDBma3ZHdUNoclBFUndBTlQxNlZ5OHdZT2Nvd2g5N3E4?=
 =?utf-8?B?SzR2bk5ZUFcrK29jR2ZjbTlXMUVoRlBIVXpCdnlndURSSC8rdC84c3lTa0Vy?=
 =?utf-8?B?cThRNHlWYTM1QlhEWFpoQTdORmQ5aVFHcUpzWFdyQndjOC9lbXRGRzhpTTR2?=
 =?utf-8?B?eHlNMGkrR3RXNjJTaFQ3eW40d2U1N2xZQVJwcTlRaWwySytHTXUycG5maG1X?=
 =?utf-8?B?NGhISHh0QzNCSWR5UHFzUWxRenIzb3F6ckxYMSttY09kTmtiRnMyM2xLdmR3?=
 =?utf-8?B?VXdtLzNoUDhFcko2TFljeTUwRDZjb0FhMzRnb25XbGpXYWhwamxqdlV1NEMx?=
 =?utf-8?B?TFhZRWVQOE1rSjIxekhuT1VDVjRJYUVDL3p0dEtVN3J0emp1dHNqTXNwajM0?=
 =?utf-8?B?cmFpYys3R1QwQks4NFJDVlJhL1dVRDc1WlN3aTEwSUl3dzQwZjVGTzN0R2o3?=
 =?utf-8?B?SGVmTGYzd0pzUWVxY2k0dzNQbEYwQm9NVWxrVTkzam1Dc0lWN0lDSyszSjJt?=
 =?utf-8?B?Q0VITVJuOGEvc1hZemxvRGlOUjU4ejh6RjV4QlNtOXBVN1o1MHdqdmZlazJD?=
 =?utf-8?B?aHNnSGlURDFnWlkweXFJdGE0dk9GYTVJcGdRR2lkbTBSVldEaDdmSlhnYzFL?=
 =?utf-8?B?OUgzMFhlWDJtQ0J0N2t5M1dmWW85QVppSzk4TS90QWpqd25zOGM5Z29NaGps?=
 =?utf-8?B?SU9wUkpzOS9rVmptTHhWNGI5Y1BOdGFwZVdUUHFTZGtkaVRocTlhcVZFZ2Vk?=
 =?utf-8?B?U2xoclpHUytLSEhZNWhPdjBOSmg0V1FxRTB4cDV2QVV6djZ4TzlVb25XS25H?=
 =?utf-8?B?ZEY3c1FMME5leG0zelh6ZEFDWlhrWXpJZjhNY0hUMXU2U3JHTXljZzlOanRH?=
 =?utf-8?B?cjdOQnJCZE9USGNkSG91RFNUQTdQWjJYdVMxVEIxOUpzblExcnRaS045V21X?=
 =?utf-8?B?Q2JYTmN3UHVnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTA1SVIrb1dJaE5wUlJpUVE1djNPZmhxalRhVVplZmoxV2cyRUJiWFRlZTR4?=
 =?utf-8?B?VUV2QTlUVFk4NTJnSzF0VjIxOTJ3cjZUbUVPQkZIM1NKZUprVlJPeGhJbzVW?=
 =?utf-8?B?UmZIendoTjlXRFJYSjVRYUlzZmsxcm1ia0RjVUNpYktaTW5VbWIvS2xiZ1o3?=
 =?utf-8?B?K1VuY1JMTFZKNVNheHZ4RkRxQzlmTk5TTXBXSzZiQnlNQkFDd1phNWlzUWdO?=
 =?utf-8?B?ZWR0VGlFcjZmUEo1bDlHOUxlWmVJWTBDK2EzS0pVS3N4cGhQd2NESHkrR0JP?=
 =?utf-8?B?bE4zdzhuQVg0WmtiVkxLOWZlZTRxMHNsNnV0QmYwM3BYb2xxbHZnYnZiaUxZ?=
 =?utf-8?B?eGdjVGUrR3k3bEdtdEk3Tk5QbmVBWi8zWjdKQnBsR2xtTXBBL09MWkdVU2Uy?=
 =?utf-8?B?cnhEL0k1VHQ3ZzRPTzhnb2xCdlNoVDZPNEN6aHJucGJXOHVGRXBBbHR1QlRQ?=
 =?utf-8?B?VG40VFI4anorajdoc2pSWENTNnNZV0hhaXVWVVhrM1p3ei9nSGZZY0Rob0Zv?=
 =?utf-8?B?bXJIZHZFQ041akdBRUJyY1MweGo5clR1R0Q3TEtFbEd2VHZxcnV2SzhDSC8z?=
 =?utf-8?B?YmFDUWx3Z2g1N1VRRkY5UDQ2QjNULytZQzFVNjJDWk52Z2VuKzJXWGdZdnJU?=
 =?utf-8?B?N1RtdjBReHU1aHlSaEVxYkQyY0Z6R3I5U3pQcXQyN0pnazZNMVd6MVBzdXMv?=
 =?utf-8?B?RGF0eHZKOEhSakJ4UlFlR1NSVVZrVFNqL1ZPRmZUZjBwR2pObWJtb2dYOCs3?=
 =?utf-8?B?clVHU2d4UGxEOEtvVHZzRll6ZWFYY0tIaUYvT3B2RzlhcThyY3dQN3Q1azRy?=
 =?utf-8?B?UERuSFNIcUgyWGpIN3dKNEFqSW5XRkIzRFlXY1k4K0lYcElkT1hKVEIzbHpq?=
 =?utf-8?B?U2xmR3EyVjFGbjY3TnRQWVFSUk1oUk9vN09CQklrVm90cFVVU2NCVGdvRmw1?=
 =?utf-8?B?Z001Tmc2VUl2ZzA3RnR0SksrQmR0dzBteDlIVkVPaTBIcksyUFp0eUVNbEJB?=
 =?utf-8?B?QkVuTVZEZG9qQ0Y4b0ZwS00xVG9yN3dQdk1uTUJiL1BSamFLMTlmUThkV3F4?=
 =?utf-8?B?cEQ0RFQvZ0ZFQVZLT1c4NlNEcmYxclJsZFMvN3N1U0NUOUduTVJuMWZ6N0ZG?=
 =?utf-8?B?QmR6d2VPdFJ4bDdHQjUyRWxRYnVMTXM4ZHZsenFPZndub3ZJRnRtYzU4QUN0?=
 =?utf-8?B?V1pJMFA4V1QyLyswc3lEQnkvYmlkNHZBWUFhTTUvY2JkTWgwMkNUY09Kc0tq?=
 =?utf-8?B?ZkRZQUhYWnZzeEVjZmd1N3BZNVRCcEdROW53V3JuN3dYOHpzMWhTSUd2eVc4?=
 =?utf-8?B?TVhhSDlBa0dIbXZITDZZaXQrSllwVlVsVHJrNTJySDFNeFVZeU1QNVJUQk9P?=
 =?utf-8?B?K0oxZmRmWk1oa2taaWJkc1FUbG5PMm91Y2dGeWpMV1RvbXJNRm1Ia0tySlFj?=
 =?utf-8?B?WWpuMlF2d3plcnZhQTl3Ny9kMjM4aGExOGFrV0YrOXIzRGFDa2dOaGNjL1BT?=
 =?utf-8?B?UXdrUzBzb1lnbHgzdXVWQ28ydlhQcXY3R2JzaWMyM1pLc1FOdVJUbjdJU3Fw?=
 =?utf-8?B?SlExVThIUXlUN0lBWFVvL2RMbUdrYllyN2dIaFlCSlNQNGI4c1VucjJ3OTQx?=
 =?utf-8?B?bWVvbDJUbVNZZkFtSHFnZGtIelBUNjNCczVad0l2M3A5anFtN1dJeERHZW0w?=
 =?utf-8?B?Wjd2MkdvVTlTZnUwTEdjazdPTFdLRmQrQ01uNzJpUjFYeU55SkhsdnBGWkFL?=
 =?utf-8?B?UWpFSnVwUkZUVExJaDRjcWJGcC9FanFkQS85WERiNTQ5MDBGaUZ4NFpzRDc3?=
 =?utf-8?B?dVNXUW8xRFBzYS9oUjJ3ODlNL1MxMk55OWRzYmZERXJudmdSU00xWldHRWJj?=
 =?utf-8?B?eC9JZitmYzlRUjlwckNRM0p6MHlzTC9TNTN6THpMazQzMmwyTnorMVp0SFgv?=
 =?utf-8?B?TjRsckVkN3RWbDFwREo3RDJTRjUrTTNSTWd1ZW5qNmYxRktlWkI4endpc21E?=
 =?utf-8?B?M0U4ZTRhdUo1QXNGeDczRm5zMU1OTFJZQjVnaXdNRU1RRFpwOW03N3V6eXI1?=
 =?utf-8?B?Vmg5c1h6U0tNbm9nbVJzYjM1T3pmbEpiNmQ4N1RNYlgySFMxWE1hM3p0L2Fp?=
 =?utf-8?B?UncxZnE4K28rdXEzL1Q4dVJSaWptN0N1c1gxb3BpY3NPZ0s5andaSFJTZ1ZJ?=
 =?utf-8?B?a3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d9f36c6-1cbe-4dbb-d08a-08ddcdfe812a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 17:45:13.1568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: smm3Le0PdE1bpeCWoBoKKedmbrukfiTqZTJxuXpJft4GPEnH1JApEoxFmQyajVh7e/PMcO0lCN6LF4c6DyRW1PYUYV1UF94AN5MLDD1kHo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4581
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
[..]
> > Can you please explain how the accelerator driver init path is
> > different in this instance that it requires cxl_mem driver to defer
> > probing? Currently with a type3, the cxl_acpi driver will setup the
> > CXL root, hostbridges and PCI root ports. At that point the memdev
> > driver will enumerate the rest of the ports and attempt to establish
> > the hierarchy. However if cxl_acpi is not done, the mem probe will
> > fail. But, the cxl_acpi probe will trigger a re-probe sequence at
> > the end when it is done. At that point, the mem probe should
> > discover all the necessary ports if things are correct. If the
> > accelerator init path is different, can we introduce some
> > documentation to explain the difference?

The biggest difference is that devm_cxl_add_memdev() is "hopeful" in the
cxl_pci case. I.e. cxl_pci_probe() does not fail is the memory device it
registered does not ever pass cxl_mem_probe().

Accelerators are different. They want to know that the CXL side of the
house is up and running before enabling driver features that depend on
it. They also want to safely teardown driver functionality if CXL
capabilities disappear.

cxl_pci does not know or care if or when cxl_mem::probe() succeeds and
cxl_mem::remove() is invoked.

> > Also, it seems as long as port topology is not found, it will always
> > go to deferred probing. At what point do we conclude that things may
> > be missing/broken and we need to fail?

Right, at some point the driver needs to give up on CXL ever arriving.

 
> Hi Dave,
> 
> 
> The patch commit comes from Dan's original one, so I'm afraid I can not 
> explain it better myself.
> 
> 
> I added this patch again after Dan suggesting with cxl_acquire_endpoint 
> the initialization by a Type2 can obtain some protection against cxl_mem 
> or cxl_acpi being removed. I added later protection or handling against 
> this by the sfc driver after initialization. So this is the main reason 
> for this patch at least to me.
> 
> 
> Regarding the goal from the original patch, being honest, I can not see 
> the cxl_acpi problem, although I'm not saying it does not exist. But it 
> is quite confusing to me and as I said in another patch regarding probe 
> deferral, supporting that option would add complexity to the current sfc 
> driver probing. If there exists another workaround for avoiding it, that 
> would be the way I prefer to follow.

The problem is how to handle the "CXL device in PCIe-only mode" problem.
Even with a CXL endpoint directly attached to a CXL host there is no
guarantee that the device trains the link in CXL mode. So in addition to
the software-dynamic problems of module loading and asynchronous driver
bind/unbind, there is this hardware-dynamic problem.

I am losing my nerve with the cxl_acquire_endpoint() approach. Now that
I see how this driver tried to use it and the questions it generated, it
pushes too much complexity to leaf drivers. In the end, I want to
(inspired by faux_device) get to the point where the caller can assume
that successful devm_cxl_add_memdev() means that CXL is operational and
any non-interleaved CXL regions have finished auto-assembly/creation.

To get there this needs Terry's patches that set pdev->is_cxl on all
ancestor devices in order to make a determination that the hardware-CXL
link is up before going to flush software CXL-link establishment.

> Adding documentation about all this would definitely help, even without 
> the Type2 case.

I would ask that you help Terry get the protocol error handling series
in shape as part of the dependency here is to make sure that there is a
capable error model for CXL link events.

Meanwhile, I am going to rework devm_cxl_add_memdev() to make it report
when CXL port arrival is deferred, permanently failed, or successful.

