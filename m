Return-Path: <netdev+bounces-108892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4868C9262BB
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 15:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7F3F1F212A7
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 13:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2178179675;
	Wed,  3 Jul 2024 13:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fnoXqYVx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320C5174EFC
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 13:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015180; cv=fail; b=u7SLY8LzDglKtggrwIE4aWIJZA/Ui9SAfkl+A5sWhSvAYO22PRETi9+CT1/8HD5DCtLnfAkNYQDwjBiQrHCmxMCuNsNm9ovl8RMbcdBuib6DuHJkTp2lvD7uP5zV5liYhfhoZBtqyWoMlYnVT1tyYTXB7spxamYw9S7Y/1PEx14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015180; c=relaxed/simple;
	bh=ckbbqTT+hBTC3vDHOTdeLr51q7+K4cSBUsmdaNpdOGc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rpw7YKRqB7VVQB/6RXj7UFj1WqqzTsWrrPJ2VCemAZ36JMLV3IrVsB4wzsA6AEQYmU3ekg6XT4G2rYvAtTS/cTQdkf+HChuXSHoYJ2jNZUisEEjP8fOrvEh6ToBQdtme2oxou+4BDLtr/m5DSa9TnMBOg2lH0C246TM6fp+fOTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fnoXqYVx; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720015179; x=1751551179;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ckbbqTT+hBTC3vDHOTdeLr51q7+K4cSBUsmdaNpdOGc=;
  b=fnoXqYVxhSduF0Byxyb0K4s5LD8Uizp5j8H07EfjSMH8WiD23qpy6wWS
   DRDRh3aVIRUX9jd0GjPvMK84JLhXn+upySr8dd4kfDoc2Erhe0QYRiozU
   X9JP764bDFqKY9H6++acUsQOZNUkGP+bPm+wnBPOjn6LvVSR8hcxsAgno
   cBg1/V3zdoXRTBSUwALuaaALaG1tb/QkEcmGJp7LvLChXbsqBXcANv44B
   t5UPA2EIR4c7SDJowkDzwN2UlYc6iLacYtRjSUlDmIrsV+jSGT579vNCG
   pomqIqOjLcu9vvBx1SHn2jFasUfju3b28kdhfPR2nZgLjoytsuy9biIcu
   Q==;
X-CSE-ConnectionGUID: gVVj+V78RhuXPfOzD5i4/g==
X-CSE-MsgGUID: BEDLPLIWSb6I4mugY4hBbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="28636449"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="28636449"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 06:59:38 -0700
X-CSE-ConnectionGUID: iTIW4DYxTfimoxG/rMJ9bg==
X-CSE-MsgGUID: A9EJM3ZfQUaF/0SEXzMPDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="46183496"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jul 2024 06:59:38 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 06:59:36 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 06:59:36 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 06:59:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEt/Puo+xcWw68ev9z3WO+J8L49I1Q1mxXAjCJfYhHGjFvm/Q6b09dutAwp+dRklZbcv1kt7xMVRHADwH4DBqDmME+8+3CQrUkyRb8f2M4Ekb5WTp5+1i7j1YoUcIc7s1yzD5v5CSnIZ9WwIlawx8j/+EbNxUWS/AW0591la88T0BfcZy6fwqeovTNqVRK8QusTAjNSwmI5BvC8KsR64NW2WZShQcbPwLtNzvSeY/J7pzKIhOC6Hptwt9OgFkpuCNV57ea+9Q34UDogd8LZ1sR1I2eI/wN8RVCnMtQI1LYIViWN7RpR4PXTMRc8QBDLld41xb2UUEzXpN8eSnqKEWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yizLYzk0qkTfrM7w339TpgDI4cZshgJPI0mAI2UOAiY=;
 b=ShK1wK8n4WZ0ExRJOq8TKqtneVNjpOgTbCL7bJtcmMrSI28JvTTtqr6ntlggosrcCiYvys/UW7YS++hjByR+RkL4NeC1g97ZNhz4fUwjSCTrbTzP4YGQy+fZsOR9qyazbX6cDO0y6ijzWzWJSlgfsR0jygOnHSYdYc18Y5KcHQnPcbFjaH10k+pisE8oykI7fKSToOYUMBDhxe8Bbl/8pRZdLrUj1yVap0ofJDRTVY0VlIAI4MAfysbtFW6XfKYLzLbjMS8G/PJtRA6amO/CI2VmAhliyDPUsjnJnhGi0sAH/3eIX6OlH+Bxho8tX8ZEsJsHsKBm1sOKF8lf+Pe2HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DS0PR11MB6471.namprd11.prod.outlook.com (2603:10b6:8:c1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 13:59:34 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 13:59:34 +0000
Message-ID: <ae4c8079-6839-4865-b02e-445607fb2da1@intel.com>
Date: Wed, 3 Jul 2024 15:59:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/4] ice: Fix improper extts handling
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>, Milena Olech
	<milena.olech@intel.com>, <richardcochran@gmail.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Karol Kolacinski <karol.kolacinski@intel.com>,
	Simon Horman <horms@kernel.org>, Pucha Himasekhar Reddy
	<himasekharx.reddy.pucha@intel.com>
References: <20240702171459.2606611-1-anthony.l.nguyen@intel.com>
 <20240702171459.2606611-2-anthony.l.nguyen@intel.com>
 <ZoU8cSUjkEN5w7Y4@boxer>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <ZoU8cSUjkEN5w7Y4@boxer>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI0P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::14) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DS0PR11MB6471:EE_
X-MS-Office365-Filtering-Correlation-Id: 83d5b08a-ac4d-4708-d078-08dc9b685e59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MWM2RzM2ZDMxakNZTUF1em16Ylh1MzJXSGhLemdkVmtVUy9YRFVzNlJOeWE4?=
 =?utf-8?B?MTV3czRjbzdPTXZLeDBPR1BsWG1aWHhkQlJublN6am9ibno5c3c0QlpWcnRB?=
 =?utf-8?B?NTAxY2JFYVQvc0hXcUNrSXJPeHNsYUlCMCtEZys4cTFzM0E3UE82VlBjMUdi?=
 =?utf-8?B?bWpjTmpHVGM4UHZTVE1YY1d2RGw2cGo5c2tqQXljbzJ4Vm84amlBd2tUMGtH?=
 =?utf-8?B?SlVKcDhLQUFQeFZmNFBxbStWL3dBTXdoNHUrL3JuYllPUVhGbUNpT2YxWjlR?=
 =?utf-8?B?cnNKNnFLNWlPa3dObjdzYlRUTGIzMjJBUGxQc3dTOGJjU1pCK0ttYkF6NDRs?=
 =?utf-8?B?YnVhbmI0UXVKdFppa2VlZThYZ0xQNE5rWmhBS0s2VlNoK2dIV0wvSnZKbGpo?=
 =?utf-8?B?MzZBRUlraFhFUmQxeWpFNVlOVFNvQ3hKQVhQTVlwcEtXNWd4dzFXYndTeTh4?=
 =?utf-8?B?N24xQ3Bhd2hIck9WYXN4UU1Hck45NVlwOVowanhzY3MrWXJGOG5PWDRIVTlI?=
 =?utf-8?B?TWEzRlVIZUYxT2NyN1B2dEs4RGV3YzNtems1bWdRYlZJMmNHZmw1VGYyYkRz?=
 =?utf-8?B?TnNqR1VOZlVJaFhBRndoMWY2MHBZeVZLUzFONXJSdW1yajhMVzF0cU1kT1dY?=
 =?utf-8?B?TmFZeVRlWExiYmpZQ3M1dGtNKzdrT0pvOGtwdkRZOEttQXRNeUpYS1duMkN4?=
 =?utf-8?B?Ylpra0szTS9LTEJUNEJha3lFc1dUQUxzS3M3SkJhSUdjKzAwV1JiK2V2a2U3?=
 =?utf-8?B?N2RzN3RjRzFYNGcwMWlTYmNKNmQzaWdWYWgxRENJbDRFendDb1NGQjRRcmtW?=
 =?utf-8?B?eXU3L0NNWWRIN3NXMDFkckFqMkp0WmZCVlB1bDd5THlOQ01YdWFHVGJxUU9j?=
 =?utf-8?B?eEc5YWRaVEVUdVI1STlHYndYZG9nMjBHYzI0dVBKTW1tSVMzaWU2c2JCN3B4?=
 =?utf-8?B?YlAvS0tJRm0wemV4cTg3cFJWZ1o3cGVPaDEvV1J0SDlHQWRXNS85MUtEYS9F?=
 =?utf-8?B?RksrZVB3Z3d6Y0g1bG0yY1VBWE5oSzhUOTZ5cFAxNTZWcHFlQTRWdFNLeUR0?=
 =?utf-8?B?VE1vd25hN2lvQ2Y4dUVTUk1sS1JYMGVLNTJKc3RQZGI3LzcyRk9sS2FVRkJU?=
 =?utf-8?B?dWxWaXp1cHhlN3UyVFRYbjdxSkVjQnhXemhTazl2YVBrNXJjY2lwSWwrMUhL?=
 =?utf-8?B?ZTdDNDZOeHlsYkUrdEdwRTRyK0hBTjJwaXd4VkZucEJKV1E0SkFwRVpyY3VC?=
 =?utf-8?B?OUlja0tkaVpRYzBpNlJvRGNlNEs5dVVKZmd5OVhUeXF1OE5scG1VdUR5KzVx?=
 =?utf-8?B?eGY5andvTHZXN3dMRkVWMXVzRXcvVkJoZkx6SkV0akY3eVZ6U0lUQ3l5c0sv?=
 =?utf-8?B?dFVJRTNoUllLTUpnNHpzZ1lEdGJ3OENJZGRJRnhkV21zMlUzV1liNmNzeDFO?=
 =?utf-8?B?WTlNYWJid1ZyRnlwK0k5T2R4eDhGUGx1QzZ2RmJ4OExBak4wSHBhNVpkQzN2?=
 =?utf-8?B?K2VVb3RPN1FUY3EzSGl4YUl4Y0E1cjJoZ0kwTVZqNGlBVVBvdWRoN3QvY2ZV?=
 =?utf-8?B?bmw2dlQ0TGlFRENFdWF0L1lVK2loNjNOTFZvc20xKzR2a3h5L1FmR1ZWVHlC?=
 =?utf-8?B?RHVrWm1uNTZMS1gyaklSSFR3SEdrdGNQY0lLQTl2UUpNZ3lOWFRpbEN2d3pO?=
 =?utf-8?B?YklGbDVxSkcxVFdXTVcvWlltRlBoQTRkWGVWdis0UUpidVQwT09LbGlkelI3?=
 =?utf-8?Q?d79tnZvyyHZz/91XLI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHJQZVJtS1ZhbXJKRktwY0RJWldmSVE0VmJHYmIwQmZsUnR4VmhQc1Q4Q0tW?=
 =?utf-8?B?cmxicnd2NGdyMDBVNjRwdnkvR2RqK1E3d3huYk1JWGpPNFUyOFJITCs4SlRz?=
 =?utf-8?B?ZWw5SmZTVVhHZWw1QlBWOTlBSkU2ZzhaeGxSejhlZmF0Y21QQy96em4vVDk4?=
 =?utf-8?B?bnFpKzRVc1d5dzVmci9Ya3NhTzBqa0ZYWWFXWTg3cVAydW9QQzkwakgzRG9z?=
 =?utf-8?B?ekYveU9qYTNRK3lSMVduK0xEYUZseEViWloxak9ndXF1bkNyNDFQMG5YWTI2?=
 =?utf-8?B?YmRDWEp4Zk1OeDVOQm5RbHM4ZzRscDhpbWQ2Zk14TG9pN2RjMVZUZmFNaGs1?=
 =?utf-8?B?UzJONGNNa3UzRHAxTWQxVEZLeFFYYTJuZDVaRFV0Y3FrOHl4R3dLVHZGM1Bj?=
 =?utf-8?B?UG5PZ0VrK2hKRlc4RjdLbUpsaGlvTi82TloyQkZ5RHl1UGowY09Yb3NNVE5k?=
 =?utf-8?B?d0NkekxGNWFONUk5RC9iMUVCY0pUc1hkYVVVTHBnYTRzZ012NXhSeUxlU1B3?=
 =?utf-8?B?b3lGcHNUT2d0MDd4Mkc2WVBsKzhMSWc0UzE5azRMamVPaUlGa1V6aTdzRmw1?=
 =?utf-8?B?OUtDZHdPb0Naa0xrUDVNRWRwR0Q0Q3RkQmVRNTY3RFlVSzk5ZWxZa1gwejVF?=
 =?utf-8?B?YXdxSkx1ZDAya0xtVzlmZXlUYlhTL1VRdllBUXVrdTh0M21senJyMkt1UlR6?=
 =?utf-8?B?MkxhSXVjYXo2alVreks3enBvWjY3VDFWMFIzNUxHYlpJSUZ3TkE5TlE0VjVq?=
 =?utf-8?B?V3FRUGFwcCt3eUJmcndDb3hMeVY5OUVWTVBYUitoTDV2ejFFaXBBdlpkcTVq?=
 =?utf-8?B?VEJ2V0FjN2tmZHdMYmJJdXRydlplMmY3YVYxY3FTY2lLMC85cDFCTmRWelVG?=
 =?utf-8?B?NUFXU1p2Nk5ycGRMV1RwNm5jaWhCYVpSb1ozbWE1WmxhUTkxN1MzMXljK0xX?=
 =?utf-8?B?QVZoVG0yMWhEVm0yZm5ReERKQk55dFhWdHJtTWRJdXNyYVR4TGpEdXJvcmUr?=
 =?utf-8?B?dWQvU3VtNVE0T25ZNnJNYnVhL0xjaitwWmN5dmpNZkF2K2tQQ20xRXVnMkgx?=
 =?utf-8?B?Mlgvb2JRd1ZJdHVWU1VLOWM1YVlMbGM4aUtjNDJoYWtpeGk4TXd1TWV1eDlj?=
 =?utf-8?B?Mzhpb2VDOThjRlY4SnFNZFhZdTJkUjcvN2xrS2dRT01COUVWeC80M0JVWU83?=
 =?utf-8?B?TktXRVEyc01QSHVucFo5WE1McVluV1RoQW1lcHpCd0R6YmhTRmROS2l1L04z?=
 =?utf-8?B?dUtjSzd3NGpXR3lvcEswOFRmeHdBTERvOWpOQTN0bFc1elFCaFUrYVZQT0Zi?=
 =?utf-8?B?aElyR05DU0FWK0dnaHNGMlB6aWJjejlia3MrRFR6VXByNEE4NmdxRWZnaVNk?=
 =?utf-8?B?VkQvM3orcElzUWliclB4NDArbStpMnBVT2NlY2tvSXpwREp6dHVmVTQzWXBj?=
 =?utf-8?B?akxYcGk0OEt2NDBad2pvQnowd0xQUlJxZDkramtNSGVGd2hvc2tnNXJhWmNq?=
 =?utf-8?B?Y05RMWdKaGlsN0JFaDNqTEFmMVI2RmM5N0dCZ25PL2pTYUEvNVRrVXE5VCt4?=
 =?utf-8?B?ODIzVTlIcGdLNThqRGNTTTBzR2orK2k1VWdiNzhmZW5yRmZjQ2VOV0hCRjZH?=
 =?utf-8?B?TEV4R0k0VEIzUW1NQkpucDNSYmgwQjNOazN4endxUjNPTUpiODM2b3laNEtF?=
 =?utf-8?B?YzhuTXJicUY2Nk1sK2lTVFdRU2diOVQvUTlGVEZITTVhSGFHRzhNc2JkdkNZ?=
 =?utf-8?B?djFkdnJKYmhjTmtzTUVPRC9Cd0s1MTVWb24xUzdmY3dJdDNDQkRxK3FCQjQ3?=
 =?utf-8?B?NS92RXl3SEJHUnlNZFJDby80Z1FlRVNiUzFJdHFBM2l4R3BuUkFSNklNWjZ6?=
 =?utf-8?B?TGttNUZyNDE3TEllVjJGYkU0NWhhZDhyK2pxTkZYbm5EVE8wVHluTTE3MzJh?=
 =?utf-8?B?UWl5MGNvR3VTY3FqTnVzK3pibC9BLzgzSk93YUFSaXJrdDFwL1ZrVytDbTc2?=
 =?utf-8?B?bHVuNG5yNDVGVE5XWjdjUEFwN2ZheHdjdjZ5MFpWZi9wMjM1cEYwYlhtYWhQ?=
 =?utf-8?B?VGVBZFA0L2crZmVnT1FEeUhyOFhubStxcFJPU1IvclZkVWpoTTB6OUNGSEN6?=
 =?utf-8?B?SHRaNEpaU1l3V3ViSm1DTXZpaW1OelBzN2tEd0srR3d6VHhMYndoNi9qM2NN?=
 =?utf-8?B?Z2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 83d5b08a-ac4d-4708-d078-08dc9b685e59
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 13:59:34.2651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RhM8dW9OJ7uFooA0rgYC8KEO4dMtFfbUQhTvwkb+L7F629VOQFuyo0HNj2GqczXnNnhBCyymHNU8yr0LFo/iDiD8yTWmWwyZMJcLkIZfEsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6471
X-OriginatorOrg: intel.com

On 7/3/24 13:56, Maciej Fijalkowski wrote:
> On Tue, Jul 02, 2024 at 10:14:54AM -0700, Tony Nguyen wrote:
>> From: Milena Olech <milena.olech@intel.com>
>>
>> Extts events are disabled and enabled by the application ts2phc.
>> However, in case where the driver is removed when the application is
>> running, a specific extts event remains enabled and can cause a kernel
>> crash.
>> As a side effect, when the driver is reloaded and application is started
>> again, remaining extts event for the channel from a previous run will
>> keep firing and the message "extts on unexpected channel" might be
>> printed to the user.
>>
>> To avoid that, extts events shall be disabled when PTP is released.
>>
>> Fixes: 172db5f91d5f ("ice: add support for auxiliary input/output pins")
>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
>> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>> Signed-off-by: Milena Olech <milena.olech@intel.com>
>> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
>> Reviewed-by: Simon Horman <horms@kernel.org>
>> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
>> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>> ---

>> +static void ice_ptp_enable_all_extts(struct ice_pf *pf)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < pf->ptp.info.n_ext_ts; i++) {
>> +		if (pf->ptp.extts_channels[i].ena)
>> +			ice_ptp_cfg_extts(pf, i, &pf->ptp.extts_channels[i],
>> +					  false);
>> +	}
> 
> Still one redundant pair of braces. Just do:

"Also, use braces when a loop contains more than a single simple statement"
https://docs.kernel.org/process/coding-style.html

I even suggested adding that pair only to prevent such request later :D

> 
> 	for (i = 0; i < pf->ptp.info.n_ext_ts; i++)
> 		if (pf->ptp.extts_channels[i].ena)
> 			ice_ptp_cfg_extts(pf, i, &pf->ptp.extts_channels[i],
> 					  false);
> 
>>   }
>>   


