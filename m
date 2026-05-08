Return-Path: <netdev+bounces-285984-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JnGHlNb/mkWpgAAu9opvQ
	(envelope-from <netdev+bounces-285984-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 23:53:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 479574FC113
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 23:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38C993019FD9
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 21:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DB4312803;
	Fri,  8 May 2026 21:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HJnQPDC4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB712E762C;
	Fri,  8 May 2026 21:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778277200; cv=fail; b=m4xBOJeoY6KiB6FbMylmZhUR6whhSR6tg1vJqbXE5VzaFs7J4aF0URf9xy44Yn6clgbeRHk2J9D9atNAaWAIxtLsGpA/t+OUQpoeK1+v+q7nBXqQCP9yt3Z8BQRsY2XUTITG0UUenPKY7fHKiWmuWZdQ7KVXUSWOwMALBE4f7Dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778277200; c=relaxed/simple;
	bh=XKiaDlW2H2m6GqstE8xYmtD7MrThJubsb26YQ8KF9VE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=beoqNNGUuAaf4zmnbpgscZ+QDVvz8zTSSevUgI5IdLARXkcZrA6PD8DCehiQcrwKHY+Y4ETHi2sbdHv0F6Rf4XQnhDxOASBphb3dS5SXPdQ3ydozouIgeMlvZgcmNvtWUyYu5Do/z0ZzYqcHr7AOI2F6zxrcFgYPt5yJl17H1EM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HJnQPDC4; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778277198; x=1809813198;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XKiaDlW2H2m6GqstE8xYmtD7MrThJubsb26YQ8KF9VE=;
  b=HJnQPDC4L+QGb09W8SX1uyG+i45S9NcK51JGUUCCu7d0nEc9zhFPkTqA
   25k+5Plt9hFXPWOpmr1IpNh6Ief+o8AHbXma1Ay5sH6N842Op8MngFKme
   kiuvQl1yukDRbnYUtcwDloK+kzvWF8iCii7JrScxlYlnIQ0QKQ/Bt6IcS
   U7Joc994hBgd0WkDant3GXiYN3sl3z4TKKiv/w+bHhLcj6iOGyZdLju8x
   Zyg/OGXVua1kHjU3cGVpZ/r/dYMPFxEamxtf97hshS64CPyqCMhUwz+4S
   ogmpSGJy32EdtiXcgk/dQepaRWzCamhrw/k4t1wh0ErfTVJk0VmQDjJfs
   g==;
X-CSE-ConnectionGUID: ATGtNmPNS5+fishUQ+x05w==
X-CSE-MsgGUID: X6MrzQdTQqScngIE4nV0yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="79112356"
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; 
   d="scan'208";a="79112356"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 14:53:17 -0700
X-CSE-ConnectionGUID: IyiZJ+nOSQePNEc+0PTLLQ==
X-CSE-MsgGUID: eHVsab/TRqmXVb+FdaOLVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; 
   d="scan'208";a="230484124"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 14:53:17 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 14:53:16 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 8 May 2026 14:53:16 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.35) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 14:53:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLZgTn8VtwWAif1knBUzVev+JTrP6bPh1MmneRu0B89RNCMCfOB4cK6Js3V709bDOEK42aJvzMFPi9ZvYQ6HOj5d4oIV13oFIOAiRGWXZqsm2Yelmgu3Ld/B8r0I8CU+mtrMAsuXRAXZ+Fcau1ZCT8piNfMIZevj5ziwqSBYPVOlKURCI69ubOrefpXybbtRM2tbtRJJ2CPiiHVlZWJMrsFcAnaLa2TF6IOT/9X65hy1RtgGkj0QiEPR7Jx/cKHVrcQU5gmXO27JuOhFlYZrPm/3qBv80j2uZ5Sc7mWF/xAUS0cKtom9F2DN21mlu2V7E7p9wcoSvQvaQabvvJloAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOO/kjluV0K+7PNQUPAHiVhxqr9zXc3tFly1ypxDqhc=;
 b=myNENUK79U/3sAT+sSt0mxxZTCi0+3TH2xavMWFyKFJ7InMFEpTllHVDfuCBHScSX8nhSDBVrgFh0AjYoULNXdyXrEN6E1YYSPuAw8Ik3giKR3TfDRBWp5PpremUt8tCSaX5ot+LeagVevApzqW63QZGAS4vujDkZ3PcVX93pupqtYEk++eH2PpXhegkc10TpZDx5/as7ot5/IX4wwtyBAoTobzq453L0MI2oHLQAbc35rRhX/orYoCp4S4IPcQwisucAUQo5BGZREW+Y3slW2nvtNXGYL1m5AG4c0TVrYhHfHM1/sBT+tuBL/EmxMK6ApEZ8DcZr+sr5l8ppiN8/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7592.namprd11.prod.outlook.com (2603:10b6:806:343::16)
 by LV3PR11MB8601.namprd11.prod.outlook.com (2603:10b6:408:1b8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Fri, 8 May
 2026 21:53:12 +0000
Received: from SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6]) by SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6%6]) with mapi id 15.20.9891.008; Fri, 8 May 2026
 21:53:12 +0000
Message-ID: <01f89483-596e-441b-b48a-f79fb6d5067c@intel.com>
Date: Fri, 8 May 2026 14:53:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 3/3] gve: implement PTP gettimex64
To: Jordan Rhee <jordanrhee@google.com>
CC: Harshitha Ramamurthy <hramamurthy@google.com>, <netdev@vger.kernel.org>,
	<joshwash@google.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <jstultz@google.com>, <tglx@kernel.org>,
	<sboyd@kernel.org>, <willemb@google.com>, <nktgrg@google.com>,
	<jfraker@google.com>, <ziweixiao@google.com>, <maolson@google.com>,
	<thostet@google.com>, <alok.a.tiwari@oracle.com>, <pkaligineedi@google.com>,
	<horms@kernel.org>, <dwmw2@infradead.org>, <yyd@google.com>,
	<jefrogers@google.com>, <linux-kernel@vger.kernel.org>, Naman Gulati
	<namangulati@google.com>
References: <20260507211304.3046526-1-hramamurthy@google.com>
 <20260507211304.3046526-4-hramamurthy@google.com>
 <4fb57921-33a6-4ab3-a0a8-9b8c3a48fd24@intel.com>
 <CA+mzVtu9OVgK3XEsoRsZ3BamQGjBnsdu2cAtesamiDQQi_69sA@mail.gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <CA+mzVtu9OVgK3XEsoRsZ3BamQGjBnsdu2cAtesamiDQQi_69sA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:303:b6::14) To SN7PR11MB7592.namprd11.prod.outlook.com
 (2603:10b6:806:343::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7592:EE_|LV3PR11MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: 49ab7970-5d8a-4b4f-84e8-08dead4c3352
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|56012099003|3023799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qkbjfI3Ke5DMwkBwt92KejCXAFs7b6OG7l6NxN3knElHwtH+6JqC9ZsNTZk52HJ7xKM/KJ2vJpgdGtJfqqTIz8Nc0UHg2NfvifhNtRccNXPdmPfmst1zyU6PHOt3TnJAr4rXItUtxCjb+ZDa0ziCEfZYWYKyP4tA7XEGnyLyL9RmyLbduH524iHoZaq6Vt+s8xSKEgFjHWwU9S5aPt225UYHq4Zf1NDFb1ObhpeqraJQbFdHieKvvqvWVleYtdSvFEcn2Jjfc5qi+17GFaBllwyAb74knuAbQHLqr8KqVSpm1h2a0Pme75J+8fTEZXEE15iVLqyFvs2WyBDk71xddIYlpNvPnL98Dw25/JEpkWMAz8kNjgWako7U+seGa8Y0pILWckiUtGVVS1hnA2YvCZmFgVBKalOo40XCfRKXAEKJjbsVTA6CmyZUBUG47JDT51UllpU4U1r7NgWT6Gk/CLOBgtpPcZyuhI1b9/XjDD3vkKLqCtZLZ2IESxV9eTwezFTFDxJxrqMxo4SDLhglR6hdqe/2f5+7o64awQ3cyik25f6n2Yq2KaCfPas2SHEx1w6bSBbb3+9hzuK+b4pMPWQ4Ij8AwyEaN7caTCobzj9Gb0j0QiuwegAGkNSAqXn+7aMyYAPq+l75g0iHQM9hc4LLrtPPsLbNOvWoUIRLh2BaumRzvTixM7bd3xd5O15I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(3023799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWF6MWhPMGtueGVWNlBIc2ZOaGNvVmtXWGU3VHhDeXJtYWpwNUNEQlhNTS8x?=
 =?utf-8?B?MXQxdk1XcUI3RDR0Q0VYN1pQQUlLN2ZueDZqRkVHUlFqUHY5ZC9CSGp1RS9j?=
 =?utf-8?B?cDVjbGFNcS9XV1dlMjFpd1VzTml0TmNHMzNJVkxlRHlBOVpaQ0FsL0JzekpV?=
 =?utf-8?B?NUc4WGJJTzVNejB3cTZ0V0ZlRktmOU9uZXFSMXJLSUtKSjVOa29iaTNoWEpp?=
 =?utf-8?B?TVp5WVA4MUVQb3BhSDQ5VjlGM2NSMlRISDdITlhLeEFITVdZM3dJNVUvWDJI?=
 =?utf-8?B?REgzUlNnZUxCZTM4WW03L2hSdkZBZEprcFdCdEpQNmo4dDhlUVBOY2hUYzFZ?=
 =?utf-8?B?YXp3YkdFb1NxSGE4ekxNSm5WNWx1RnA5QzJzZWZBcjg2azZmSGdSV29COWZK?=
 =?utf-8?B?ZEJISkJwZ0V0dFZhbjN3NTE1a0lta2dTWGlMRlNPRXNFRFJCSHduWXhTTmY1?=
 =?utf-8?B?RGRTNHoxcXN0UUowMnBlSVNNNVZoK0VLTTdNY3B2bDVaeVFqQks3a0FQQU82?=
 =?utf-8?B?aUNGbW12U1lNanBReWpCSFBBdlRueVhWVmVjK0hKU2hqdWN3M3dBbkV1eWx4?=
 =?utf-8?B?R01saUIrNzRpTzlPWm9EbFk4Y2xmMlhRS2piZXJ3MXhQeGUzMGhSWUlaREF1?=
 =?utf-8?B?bHZFS2oxU1dnUHV4cmRHeUdKSTB1UVBpQThLZ0JHNjhsVEsrSnFVR1cvV2hJ?=
 =?utf-8?B?TWlkcDh0R0tFeTRZcGN3ci91VVlrVXU1aExNbzh2ZkRFcm5QV2l2K3ZqYWUz?=
 =?utf-8?B?aTQ1aGQ4YmFEL1FZMU54UTNuWW9TSjZUTUJKMlpWaGJHcVVZOTU1dFdKbXpO?=
 =?utf-8?B?a0YzYzNXV2EweTlMZ09panAvWDJ4OXZKM2lnQWVlVDZtMk4yNlA3Ri9MbEhm?=
 =?utf-8?B?cE9iNVNiUGkvVGZ3MzZNallFaVJySkdJNFh3ejZERG1SUlYzMjN1Y1JFUXJN?=
 =?utf-8?B?K1F2TDdpRnUvVkE0cmhJbzBJTGhhQkFEaWJHMjd1NmJ4ODVBOHIvcVI4eUg3?=
 =?utf-8?B?S1ErUlhVK1lOa3kwbUd2S3FIVUxtVW1rUGFRWDZqT3JiZ1hQeUxTTjhGRE9M?=
 =?utf-8?B?QVdBdC9VSXlwMUF1RWN1NVVzZUZ6bE5SL1BhUXB4OGVyOHcxbFlvUERZeEJC?=
 =?utf-8?B?KzRRa2JZdU45ZlZGZ0RhZEZiSkVBMkx4U2NuR2VtNUxmdEtQTTgycVZaOUtU?=
 =?utf-8?B?MWg5dy9QTUc3QXdOWkthdmZ3blR0cTcwMk1Jdkw3VExNTDQveDcyY2VXVUlZ?=
 =?utf-8?B?R251c2J3SngxaHpUWVJweHE1cUlzaXhsTjZRR1pJQXFvS0VaVXNZU2w5ZkJK?=
 =?utf-8?B?emNYa0o4WXJmMHlLY0N1UHRYVDAwTUxtRXY3NEoycFRPY1lYdmtPUzIzUW9U?=
 =?utf-8?B?d2N4eStwaTVvVE4xckVIdUR5OXcrcEVIMEhLRVd2SFA3b3A4cU4yUGRIaWRX?=
 =?utf-8?B?Sm9LQ3JBYVZmK3laUHl4K0trcUQ3MVNzbS9yYWVLOFZieFFBc0xKcS8xbDN3?=
 =?utf-8?B?WHdvS0t2UURqN3VlQ0JGdDJ1b2NtY3ZnYWJyT0VoblhYcTkzWCsyL3ZFY3No?=
 =?utf-8?B?b3FkTXJqQkFxVlBTOWlkNjJFVCtPRWl6MTIxOHBuRjNIK2ZOd084RmRMVzBK?=
 =?utf-8?B?bVUyeHF1N21mMWRMWkxjNHp0Rzc0VGVTbTN2R2lNUFVIVEVIZ21oMkxoMUx0?=
 =?utf-8?B?REZIdTRyRjF0T2ViMk81TS8xckdDQzIrU252VVBBd0lzcFBjS2dETlhzeGtP?=
 =?utf-8?B?aFVNRDlJMkVCTk5ZK2FUMzkzODdOb3FrTFlwS3hpeDdhMjZsb3pQTlRIc01V?=
 =?utf-8?B?UUZTazRLaW1jYmVTN0o0bmEvV1ZlK29uL0dVdHVhL25CNFFBaDlhb0lCYnRs?=
 =?utf-8?B?V1RSclNsenQ4VXBHYkVKTE9LcGFrUVVyTTAzSW03OWtuSFhQM3huSXlvRUh1?=
 =?utf-8?B?UTJ1RjB1N1pISE51bnd0d3dKUnk2aE9mbCswdEZSZExTLzlsQ25lNjlrdm0v?=
 =?utf-8?B?NHlyNDBldU5mRityRW9ndVdOeGFZZ3VtQlVZVkh2YXNYb3d1d1E5enl0SC9k?=
 =?utf-8?B?OFZWUmhOV3VTazE0Zmc1dlhwTHVpazk3Q1RmM3VEZjhndmErczJoa0hlc3p3?=
 =?utf-8?B?dEZuUXI5R21oQmVGbzNabTdJRXhhazh6RDA5MFNQS05rS3V5RTFGc0ZvRHFo?=
 =?utf-8?B?UStaZ1lzRG5ZdVF5RUppSlJxbGRoc244YUQ0TDFwNXN3SHRCVE92bjBKY001?=
 =?utf-8?B?UVhYNVh4RTkvS3VWUGl1VzRzUDI4YVNPcHNuSDFMUVI5eGVnSUg2RksrZ1g0?=
 =?utf-8?B?MnptRUpnZDVVdTBvNFdUbzhwcDVINjRydWVRSlNKUU5Mb1psdDhzZz09?=
X-Exchange-RoutingPolicyChecked: rxQrLdrYlu74244xkGR1/Ff8Hwos4vA9acPO/lk+GjQaQDjABTql8CtDma/7Z+ZLwhWXu83BkCbkiZS97C+KHlze+JclM5otg8NfX/YxcuKTxt8CDXYM/9Zj+OyQ6lq89d96H4MFrNCD6jIG00/uqn43Hrzr8/hjgSVyQrvm3E1KKpXnGNjD/Gf9BsdtEe2lPtIonLodoEFYSbLhY8499jH6tXkp9sLX5uGYbYguTbOikC92PkLxFsoZCEBxyxFe49MbLEHPHJM5WVKzn0QOEbHac2DM7o7egMxlpKKvjOSCk3ZxIJLNlFjxtI/bRC/B7JCaBG7wVZRg7f/lRJzggA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ab7970-5d8a-4b4f-84e8-08dead4c3352
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 21:53:12.5167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o+e/z404PPXhj7SaNS5s/5pnBlwnnV+NuRMSg1jc9DOX7TPd1SImEOkdhPqrh6HP/ZH/7bM3Ld3NavHykjbeNeWj30wQJgy5cKy2BIzbEoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8601
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 479574FC113
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285984-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,infradead.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On 5/8/2026 10:43 AM, Jordan Rhee wrote:
> On Thu, May 7, 2026 at 2:23 PM Jacob Keller <jacob.e.keller@intel.com> wrote:
>> On 5/7/2026 2:13 PM, Harshitha Ramamurthy wrote:
>>
>> I'm a bit worried about this part, but if I understand, it would only
>> affect the fallback variant anyways since the clock samples are taken in
>> the host in the precise/fast path.
> 
> Good point, the snapshot *is* used in the precise path to interpolate
> system timestamps that occur before the current timekeeping interval.
> This is my understanding of how historical timestamp interpolation
> works (adjust_historical_crosststamp()).
> 
>         <--      total_history_cycles                      -->
>                                <-- partial_history_cycles -->
> -------|------------------+------------------------------------|----------------+---------->
>  cycles (input)
>   snapshot         sample                               cur_interval        now
> -------|------------------+------------------------------------|----------------+---------->
>  ktime (output)
>         <--                      corr_raw                        -->
> 
> At the start of each timekeeping interval, both the current cycle
> count and ktime are recorded. Each interval boundary consists of a
> (cycle count, ktime) pair.
> 
> It computes the ktime corresponding to sampled cycle count as corr_raw
> * partial_history_cycles / total_history_cycles. In other words, it
> scales the distance between the interval boundaries in ktime units by
> the relative position of the sample in the interval computed using the
> cycle counts. It adds or subtracts this value to whichever interval
> boundary is closer to get the absolute ktime.
> 
> How would this be affected by a very old snapshot? The interpolation
> would still work, but it may be less accurate if the clock is not
> stable. To get a sense of the timescales,
>  - the timekeeping interval is typically 4ms (CONFIG_HZ=250).
>  - the AQ command typically takes 60-80us.
>  - there are 2 sources of contention on the mutex (aux task and gettimex64)
>  - worst case retry loop is 100ms (but this should not happen due to
> how the firmware rate limiter has been tuned)
>  - typical clock stability for the relevant cloud server platforms is
> about 10ppm
> 
> The vast majority of the time, the sample should fall in the current
> or previous timekeeping interval, resulting in the most accurate
> interpolation possible.
> 
> In the worst case for retries and contention, the snapshot could be up
> to 200ms before the current timekeeping interval. Assuming clock
> stability of 10ppm, this translates to 10us of drift per 1s, or 2us
> per 200ms. This is still considerably better than the root dispersion
> in the fallback path (81us), so I think it's OK.
> 
Excellent analysis, and yes I agree that its acceptable.

Thanks,
Jake

