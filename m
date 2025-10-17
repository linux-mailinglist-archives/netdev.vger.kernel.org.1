Return-Path: <netdev+bounces-230498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C90A1BE9398
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 16:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 843B33A9641
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 14:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4535F2F692B;
	Fri, 17 Oct 2025 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SBTv5iZR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C79243954
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760711732; cv=fail; b=IhjYgGoWue+PEt6yH5DxEEjYyL4cMih1594KPBlb8PKzaIubRxBAF9YTxuf5CxRlY+iHC6G1kBudSCUmOB2F7/dN6KWYuwHlBegtkpgSrWD3OD44v/43tyuGP2UiuNcYKoH13ctUaEGTCKnVUAOTpX0ZCx5ADqQOSASwlGiiJ5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760711732; c=relaxed/simple;
	bh=JzjiDuaLft2Aov8KQibYQRlWZI4UepultoGqY7SbqV0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ONloBJfVqFZaUBH9ss2IbVfCYFk/zVTk4xyMmFlgwhw+E0oF/+/F5erLY4asLizOyQngyoh8ILil/ifs3mRIHBV0woKYFMLwAWl+U97TJVbecy+USJUW+Lg2xWYUT1dJQGlwJaqdaCDIAyTu2ssKjtA3ETPoJ7dPf1xxPEdgZcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SBTv5iZR; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760711730; x=1792247730;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JzjiDuaLft2Aov8KQibYQRlWZI4UepultoGqY7SbqV0=;
  b=SBTv5iZRN/Ld3S8XJPdkQfhN2nK3Fn6k9SZ59/kUFHaeZd/TT5lYQn5z
   wltGCalBi1g6dWy1M+G8FCiW2jyy03M42y0x0xjZ5qqA7Hfa29yCvPQFX
   0J7ayzR8UWCB0eH6XKEZyHVeuZbpAakpj8cfoRG1eV1kgamTbI1PZoe6x
   WZKxvKs7QGye03mZ5p2u0xuBsJDWnIfL+BkaF9a8io22g2EV5BHSRt4h/
   4fNzQkE7Wej1t8UarCZPFkyqmYnoxSbXuSMXuNiPe+1R63mqA4LdSYBn3
   N/60nNlk+AUCyZYpHhmFsEPZCmbok4jOcd6lI5MFINl4iIgQyywXaTqtx
   Q==;
X-CSE-ConnectionGUID: fCJrorpHRYyBQngvAGBC1Q==
X-CSE-MsgGUID: jxFqBfGzQ0W1rHiF7t0HSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="85541409"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="85541409"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 07:35:29 -0700
X-CSE-ConnectionGUID: 8IJLyPFlQIGo4L+kN3yQjw==
X-CSE-MsgGUID: jQInzuncSzOiCwaZGU5NdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="187842851"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 07:35:29 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 17 Oct 2025 07:35:28 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 17 Oct 2025 07:35:28 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.69) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 17 Oct 2025 07:35:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kn3o+akH/t657L4IHboCd/HBaMeSrFTcQNmbDS1UGp5Sp2ogxNznTbVBSJHUJTDfzhfxQ9Kzsy8dOZZBWUfGuC4yVfIIRRVfD7Qtd5v/DTU7lEG713qOafd+pgCNhOyDGtXiTzOgFyXgSNIPByFci7mv1e8KQ2MjcwYrXdRY9IhdzKZCdphSRI5Xrv+hd4Br6y4O80tiF14Nn2cwjYTleOaGIF3CF4qgkIJMsOl2xXC45guf+STewa98xB/0Y1/D7i3pJutci/8pySwZqny5GWQXEHerowSNRvn9jLLgJ4oo1SKQj8VvHZLHUFffjYpE0ljnP7NVzIxnsx5A74SQRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZg6FEzfBoFtGSxYh1BmuLZnSUBrt2IqtYLvMHUZzmQ=;
 b=I/E4GMLc+RW8BHFF295B8pnC5wK7N1h5E3EdtRfMxrVTp+5AkyZV1KrpchRwwmwwjJ/zGLGIjaV7avV+Gg16p15BIPRb9h37FyPtoeQ/9Th5cOaz6E8eEcY2IPTwEwF9DDRZGozM7McDq+Er1g8YDc1kjqj496sSNITbj6c3rMZwlh3lIQyjzwCk+9Z42tEkcU5aDBukuQh5RC7jIl8dRrxMB9Q+abiUKu8dyKlmR3OtvkQ6n9PyP030X7VkzqFRmNGPaNENRY0O5FBGKdGofH6VawHH9KurUHgpw3+Ch9g9E/9Phc3sNfu0YHjvVuHjUcSNe6SCrdbk0h/e2CXeFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CO1PR11MB4961.namprd11.prod.outlook.com (2603:10b6:303:93::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 14:35:21 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 14:35:21 +0000
Message-ID: <b1faad7b-531b-429f-97a4-aa93a160569c@intel.com>
Date: Fri, 17 Oct 2025 16:35:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] ice: lower default
 irq/queue counts on high-core systems
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, Jacob Keller
	<jacob.e.keller@intel.com>
References: <20251016062250.1461903-1-michal.swiatkowski@linux.intel.com>
 <5d739d1f-faa7-4734-b5e7-8e35b5556ce7@intel.com>
 <34268765-6cc5-4816-9ba7-4f00e8f353a0@intel.com>
 <aPHwpE+YuxfWZjft@mev-dev.igk.intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <aPHwpE+YuxfWZjft@mev-dev.igk.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB7PR05CA0003.eurprd05.prod.outlook.com
 (2603:10a6:10:36::16) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CO1PR11MB4961:EE_
X-MS-Office365-Filtering-Correlation-Id: 93ed7bc7-545a-4230-a16e-08de0d8a66d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZXdSbUZwK3pWYlBoWXpraXl0UmlremlNRlZ6M1pYclc4blFteitOMVFoc1BY?=
 =?utf-8?B?dHdsYlgrZ1lDUitXZFFYc1BQL3JKbWJuUlJnenpUSEFhZWtUTU9DSEdpR0lr?=
 =?utf-8?B?RllIcHo0TFBKbkt5YXh1dHFRV1BhWFRCcjArUHV0cXFyVHFjVzFNM25DN1Zz?=
 =?utf-8?B?YU1QUGlta0JlY1ZxL0hJdGhvTHFkMkU2VG1wQ21sUmtxbSs5MWhrUGJKVEM1?=
 =?utf-8?B?UnlXaHkvcC9PYlBFVkJBMkF1c3dRbUdJR3kzWG91MVFZcEdkSjU5RWtDSnIy?=
 =?utf-8?B?VnJsejdITXFOWXJUNUl5RW9QUUtMZWJwUzBTMnNoN0k5Yk5aaUc0bDAvWkJZ?=
 =?utf-8?B?ajlobi91cDk0YXQ0T0FsSE55cWxyellNcEpYeldaN3A1MFRzc1FMQWZxSkZB?=
 =?utf-8?B?OFh0bDlTY2x3RndyTkV5aVR3L2dPYlNkQmI5VXFFSHFxMHVQZ3BxVU9DQWdD?=
 =?utf-8?B?M0lNK25ZK0w3SGVrZDl4blh5N2dWaHBMbjgraXUveEpMRzRWTnFIeUFTTzlv?=
 =?utf-8?B?a29vZmVqQ2prZjcyeG9BOVNSeEpFZDBmanpudktFbFZHZkVDSnM4N2Rpeklm?=
 =?utf-8?B?NW13N2U0RTAwYjZ6cC9lcWIzNFVzTGE2dXFmdGIydVFKR1pLcEtXN2VDQ2U0?=
 =?utf-8?B?dUlkUEx6anBvQTRDNzRKSy93REg2dDRSYmxWWkZZRjZlR0VjeVVUTmV5Ujhj?=
 =?utf-8?B?ZTI5YXJaV211UXNTMEpCa0VwV0VGMysrSVNNVnFkUlFzc2pVQmVqdGFpYldL?=
 =?utf-8?B?KzFjLzJNZTRXN3Y4bkdqa3dtUStWT1ZTNVQzYWhqUkl1N0MrT21rSzlzOXky?=
 =?utf-8?B?dXJqN3MvQndVeVZHVkw5ajNCbENETFk3Q1M5VTJSOUk2eXhIRGNNK01rZUlq?=
 =?utf-8?B?UGtremN3ZXZoQ3pNSkNGZitCTkRDbVpCcENRNWZTZzNoZ3RxRENxMjRMNDN2?=
 =?utf-8?B?V3JWdkVWZUkyNVdRMHluK0RLR05vTm4wd0g4RVZUL1RKbmtMaE90VzdNalY1?=
 =?utf-8?B?Y0hXR3hjdVY5d2c5cisxQjNVL09meTRiWmlIRFdiZEJKbytNd2JlZjduK2lS?=
 =?utf-8?B?RnFERTFFOS9XbG5CQ050U09SMFc0OVROMVFhQ3NwS3NORG9CQ0lObk0zL01Q?=
 =?utf-8?B?SHc3cDUveS9pc00xSStrTWxQNE13cUFPN0wvZU9keUl1eHRqend1WXl4V1RF?=
 =?utf-8?B?RHpvRlM0Yy9NZERTYWVPMmZpdGlWZTdQM0pXcmgxSWYzQ2lFa1oxZUdWSjM5?=
 =?utf-8?B?MkxlKzNvaGM4OExBcTdOdFF4WnJhNU1XUlAzQ1dtQzZTcW5DeHF2Q3M0bHAz?=
 =?utf-8?B?Rk1sbWE0LzBxWmlMTzh4MmJvMDFOY0wvL0NqcHBXVUF3S0hoYVAydXVId21k?=
 =?utf-8?B?ck9NR3JLemFKc2M5TDBHV1BzLzJZMHU2b2Z2Wm4rV1FtcWp1N3pEWHVxU2or?=
 =?utf-8?B?MU5xdHlDOU1JNFFxRElKNXp3aGN5R2U2NmpoNmdFNUdYdzdnZHlwWldoYkFV?=
 =?utf-8?B?cDA0Q3VsOFAxZGhKWkpSQzRHdlh5MUJLYW54YnM1cWR5U3JMY1g3cExXNlkx?=
 =?utf-8?B?N2ZBWDE0RjZuMlF4TStaWXQ1WDUwd2NHUmJicGdIUGxOREVRSlVNZkhsYUtp?=
 =?utf-8?B?WkZRMXBUYnNINkY4VXhXNTE1UnJHZXdCcjhzSzBJbks1dGZucDU4eGZ6M1Yx?=
 =?utf-8?B?eVdKc3N2Z2RpLzM1bDJReFBwZmRqM2NQcm9ra2diSUgxWFRDSmdOTE5pUlZX?=
 =?utf-8?B?WS9hN1lxTVBrZ0dGMnZwdlppT0pqaEh5cW1wcjZHNmFqbU9mODEvZlU0SnpM?=
 =?utf-8?B?SDJZc2g0aktkVmhMelkzeXREalJaWTBCVmRCaVdndWE0Q1JtRC9ObGdJK0xw?=
 =?utf-8?B?cytsRVh5aVBaV0dFdVlDMk9JazJWYWxLYlV3SUxnZWNveVhrcVhTcXd0NXIz?=
 =?utf-8?Q?Lypn3h8Hy/WsEpXcbvlf4uf3PtVBqGKo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ulh6d0xjcnRHVkhVZ0hNYmFtb251T1VGMmt4YU51NXV2K3pJRXdFZXh1S3hK?=
 =?utf-8?B?cmtucFM2ZzNxTS9ONUFmNVA0SVViQ3pxQW1LREY4Z01XQ0xpUmJKTlZjcXhM?=
 =?utf-8?B?cWZiNml3ZEt5WmFHWHVtNkdUZE1abkZBWmJOemZSd2gyalF4bFlQSUZwTElX?=
 =?utf-8?B?cCtyVDAzTDN4R3pKQU5lUU1HbFBZZVdIakF4Sk1aai9rOCtmZjNVRlVLWm5V?=
 =?utf-8?B?SU1GVytHR3hhQms3blB6NGNlMHFrZktTVjAxV2JITytLaWNBaFdsMUFqT3B4?=
 =?utf-8?B?Rm1ZTVU3cml3a0hXc1h0YS93OVZhSFp5MUt2aFB0ZG1mSXV3STY1MzZyRjJE?=
 =?utf-8?B?TFFvb1lTME8zMlhnbWtpWVdTaEdKTTVPU2g4MUpXZjgyMllJTXZra2tpNjlq?=
 =?utf-8?B?aUovb3FRSTdhR2RDOC9FeXZQa2RSOUhMRWRXdHlTQVgvOVl4ajVwTFlxVm01?=
 =?utf-8?B?UlNHaE4zR09PSm1SWU9UakdxUWVsekxjNnlkclBzbjdpSEpWTFZIdjFrSUQ1?=
 =?utf-8?B?U0RvaDdtR0dlK3ZkY215NGgzMTgwSGh3bGJ2RmpCWVZTNE9rdHBqU0syMVFW?=
 =?utf-8?B?YWp1a0hTZGFMV0E4OWRqRVdVVjAxSjU3Nll0NHdiSTB0eDFqMTR1NWhOVkZT?=
 =?utf-8?B?VXB2SE9DTStDNWQ3ZlhQc2l6MDZUWExFMVNBSGZuMVhRWFN1VU9NVG9DOVVh?=
 =?utf-8?B?aUtlQTJBWERWNU44dHo0cjU4WHozcHA0UkJ2aTBQWE90SEQ5SHlSYWN2djkv?=
 =?utf-8?B?ZlhNZitxR01sL1k0a0h2Sno4S2Y4aFVTT0Y5MUZEcHNoR2JEQXNSNlU3S3FY?=
 =?utf-8?B?NDAydzNld0d4K200VkgrY2hITXJzM0g2TmpkazFRNnd2azJWdnhCMDdQRWxa?=
 =?utf-8?B?ZmtnUU4zc1EwS21mQkpjSWxOWU50bjVOc1JDSjV4b0VVdjd2VWZGZm52dnZL?=
 =?utf-8?B?dDZNTGUxWVRNVDRJemkzR1ZlejNDZGpuZHU1dEFldy9vOWlBMm8zNW5XZkZC?=
 =?utf-8?B?di9NVTZrT0hCems2Y0NaN2V2NHdQaXgyeXZ2Wmh5eHhGNHY5eWZFT0xpUzVX?=
 =?utf-8?B?Unl0bWJ5Rjh6azRFaWJkbmZISmNhQy9IWFIwT044TUNzRmMvM1FzVWtIQ2NI?=
 =?utf-8?B?eFJWc1F1Ni8rTldNcmFkU1pXQ2tWaHVlSWczNXZVUFI5NEJRK1hVdytVVjQ4?=
 =?utf-8?B?TTZzR205anE5UmhjSGFtTFo1b1QrNWpYL1E2bzVSanhBVlQ5RVJkcmtaei9X?=
 =?utf-8?B?M3pudFRHNVlDTzBWbENVdVh0WUsxS0dvbFlFd1VCWm1OMEZYeWd6S1lBTmRY?=
 =?utf-8?B?bE1yTWdGNkJZczlFcFpaQTVIc0wxMm53ZlpvczdhNTJQYVRYOU1TK0RieFlI?=
 =?utf-8?B?dTROMGJMT1pGR2l0R0kwUk1PMzlka0l5WFJvcTBheGtVanp3aFBjNTZKWW5p?=
 =?utf-8?B?TndkL0RTOXhLNUt6Zi9lQTJZdDRGbTd5ckh0Q244YmFjcmptdzRQbVFoRXVD?=
 =?utf-8?B?M0MyRE5taHJmbnNKUzJubGJKT3gzV1IxYklOTnZGaWZGVkx5UTJDa1FkWEJU?=
 =?utf-8?B?M1hBU3cxSmc0WTZTZHZYL3Z3RnFCdzBFYm52eWYxcFJyY2JzNHRyeE5KQlpM?=
 =?utf-8?B?aVk1NDRKd2hMdHFIR1A1L1RUQlpHblZldkhnYjAzTFRQY0FlOW9yQ3IwZXhI?=
 =?utf-8?B?UVlmRzhPdzZMSU9HcVlvMEhTT3Blckt0VWNlSUVsS0NtMnpKeW9jWHdMMnEz?=
 =?utf-8?B?V1ZjRzFYcHh5bENHNzdzS0dOLzRidDFBZjVncmxpeGZ2eWlsY2tsMnVzKzZa?=
 =?utf-8?B?SWlibHY1ZHhtOFo2MjdrQ2c4czFQd1NoZUM2STNRMzRNTjQzWDZmMktIa1hP?=
 =?utf-8?B?bWRlZVVwYzRUUjdUSTlVTUVRaWQyNDJBWWd5bFNJak84dlczS3daL2hDd3NJ?=
 =?utf-8?B?V2E1VDZKYXJOUURYWlcxbUJWUDJrY2dCYmVvZmpoZDBUTUJoRFg5bndwdVll?=
 =?utf-8?B?czdCdVgrMjU0K21jY2tRZ2xNNE5WQ003aEZyS1pzcEg4S3VRTGxSYThSUlVU?=
 =?utf-8?B?WUlJNVd5ZjU1MWliK0phWlppN2poRWNaNXRrVHhjaVFobVZHenlFWjRMUmc5?=
 =?utf-8?B?dUR1dC9zQkgxZCtwNENKY3Y5d3Q0dlRYdkh1YkFjcVlrMmc1UDkwQzVBdmtN?=
 =?utf-8?B?bHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ed7bc7-545a-4230-a16e-08de0d8a66d6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 14:35:21.7280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DVp9gPs8LJhu0gGGkGYDBz056oqyaydFHFY67BxSScAMJIS3JrunSVRQs8Jz+ChyAyBoxPxXUg9Ji+2VHO58I6L85qP4hf01IatO/4aH9so=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4961
X-OriginatorOrg: intel.com

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Date: Fri, 17 Oct 2025 09:30:44 +0200

> On Fri, Oct 17, 2025 at 07:03:31AM +0200, Przemek Kitszel wrote:
>> On 10/16/25 17:36, Alexander Lobakin wrote:
>>> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>>> Date: Thu, 16 Oct 2025 08:22:50 +0200
>>>
>>>> On some high-core systems loading ice driver with default values can
>>>> lead to queue/irq exhaustion. It will result in no additional resources
>>>> for SR-IOV.
>>>>
>>>> In most cases there is no performance reason for more than 64 queues.
>>>> Limit the default value to 64. Still, using ethtool the number of
>>>> queues can be changed up to num_online_cpus().
>>>>
>>>> This change affects only the default queue amount on systems with more
>>>> than 64 cores.
>>>>
>>>> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>>>> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>>>> ---
>>>>   drivers/net/ethernet/intel/ice/ice.h     | 20 ++++++++++++++++++++
>>>>   drivers/net/ethernet/intel/ice/ice_irq.c |  6 ++++--
>>>>   drivers/net/ethernet/intel/ice/ice_lib.c |  8 ++++----
>>>>   3 files changed, 28 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
>>>> index 3d4d8b88631b..354ec2950ff3 100644
>>>> --- a/drivers/net/ethernet/intel/ice/ice.h
>>>> +++ b/drivers/net/ethernet/intel/ice/ice.h
>>>> @@ -1133,4 +1133,24 @@ static inline struct ice_hw *ice_get_primary_hw(struct ice_pf *pf)
>>>>   	else
>>>>   		return &pf->adapter->ctrl_pf->hw;
>>>>   }
>>>> +
>>>> +/**
>>>> + * ice_capped_num_cpus - normalize the number of CPUs to a reasonable limit
>>>> + *
>>>> + * This function returns the number of online CPUs, but caps it at suitable
>>>> + * default to prevent excessive resource allocation on systems with very high
>>>> + * CPU counts.
>>>> + *
>>>> + * Note: suitable default is currently at 64, which is reflected in default_cpus
>>>> + * constant. In most cases there is no much benefit for more than 64 and it is a
>>>> + * power of 2 number.
>>>> + *
>>>> + * Return: number of online CPUs, capped at suitable default.
>>>> + */
>>>> +static inline u16 ice_capped_num_cpus(void)
>>>> +{
>>>> +	const int default_cpus = 64;
>>>
>>> Maybe we should just use netif_get_num_default_rss_queues() like I did
>>> in idpf?
>>>
>>> Or it still can be too high e.g. on clusters with > 256 CPUs?
>>
>> good point,
>> perhaps we should both use it and change the (kernel) func to cap at 64
>>
> 
> Sounds good, thanks for pointing the function.
> 
> Do you think it is ok to cap the generic function? Maybe other vendors
> want more default queues.

Nah I don't think it's a good idea to hardcode any numbers in the
generic function.

> 
> What about capping netif_get_num_default_rss_queues() at 64 just for
> ice?

netif_get_num_default_rss_queues() returns *half* of the number of
*physical* cores. I.e. it will return something bigger than 64 only in
case of > 256 threads in the system (considering SMT).

Do we need to still cap this to 64 in ice at all?

Thanks,
Olek

