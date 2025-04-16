Return-Path: <netdev+bounces-183492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F95A90D1C
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 22:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAB19188560E
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 20:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B62522A7E1;
	Wed, 16 Apr 2025 20:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QFxaxi3t"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140F922A4E4;
	Wed, 16 Apr 2025 20:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744835211; cv=fail; b=kWXnYUQGnEaTjyGidVHuP7lPHdSrdVSB9d8oH/21Q3LvB9cM6r1miObbmJslj6R+7/vVwX/lIpMzo6gsJFWwi8Us1bLheZxKc752Tgn4lgiHt/LFHE/g6O2MKfUWlrFwtexFhvBhXhS9IHhqvejv7UB3ILzbYoDrtRCW5ni4uDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744835211; c=relaxed/simple;
	bh=JMmJhHvSc6mNAv9CslEu9R50WJWfMhTpF/CF24BJ/Kc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sko5EiBwoYyU5l5E2KeR3SQqUbpJ6izz+5Me7Au1PMlkad2X4doGdmPKeV8rX1sUXmwg5YrJVBacVx20gmvSBR1CDf4QJ9t9IICqjyJtV6ReC7RILF4MvbbE4UG7pMVTShgwZazFNWj3Jo/grSgKHsU4+c0Z45giL4aaasQiBe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QFxaxi3t; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744835209; x=1776371209;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JMmJhHvSc6mNAv9CslEu9R50WJWfMhTpF/CF24BJ/Kc=;
  b=QFxaxi3toHsFXOEPDfeUdJJ4ODKM0Y/B7/z0lN7hmXfeDLuovtLDtvTK
   /zpSebFCkltgeHheAoMyTgjVfS/zEiOaITWuVLtIS/md3XIh39Eff3GRT
   e3xrDi4+Du9bnOW4prL7vErhylZtJpuwfSv2s+tUlbhxZQrEx+z4lI6Mc
   D8jE+rMdh4fikc3gSrp8DJnzXm0prDgQF6U+Xp3XVfnHc4ZdZwMkqxE5s
   31KAshP/gBCaWSEZTLJ6HLm98jQOP+Y1px/zO/yPW0CkbiVKHyIkHK3FF
   f6jvVgbgL4CFmLjst+Ns2YSSDzVjowJShBH1OqYVoEMbwqtfj/ABkRuJx
   w==;
X-CSE-ConnectionGUID: SWoUINphQYSRII+4tPUOgQ==
X-CSE-MsgGUID: 3PYWtEfQR4e/gwIphGdqTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="46416957"
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="46416957"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 13:26:49 -0700
X-CSE-ConnectionGUID: LAjieJFrTZO4jKRKFNV3xw==
X-CSE-MsgGUID: sHNUNu5PSOGfqSg4nPayrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="135761150"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 13:26:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 16 Apr 2025 13:26:48 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 16 Apr 2025 13:26:48 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 16 Apr 2025 13:26:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vpe2KbCUJHq6avXJz1EEyYS1//2JyHSqX0OLlowJ3hWHrO2TwQstR000eyTqgSismVKalMgATuLuP43/ScybR7vJFwy02uEl4ozhQZWYNrIdGc2bWiMHRILKXn1vb6IXXexFsODPgXvtpLTYyHpxOxav7onzG5pN6bWzNqS1xjdRPe2AAvRzyKy2GCqVQtc3dX7wEcrqnq/B94GDZh0SyUdkLt8IXIVfbwkGUkuVycNDqkm+scGa2Rr1o47OHS6dXd7yIvKC6nrTVb5Rtfu2s3QZ8MfrQAo+LWUQWCdWfjdhBIN5OqaKRa9LKil4F0sgL2E0YIL80ddWbejVKkbSbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vtjzXRoRbVheHQFX7eoPrIF0WZSrvbMKEdQ6/GvSz0=;
 b=UkLUzZjDYOA/y4sqrsUZwVsGa8opOQS6gkZEQP7sFdRZLISA9dPGmZtj6FySAhyeN9B+vuaT4nfBE/6YBgdFpt0f5WEgtDKTC0d4uJJjmZbMSX0xzq8yys5nK8ICEZ0M6vW91AMAQQtgMOGJgbrA8FH1jATpZcAzil+uk36Me3ACuZWYsGrErr8/l/nZt2KTyBJ1sWMgsC9fsTk1haqlKyFPglrqQfPVfhqokbhekfCoNPxWeS0eIP9ixEO9XYkiozSdGp1wMvh73r6NfSV7RyLj24Ep6kE8882yYvzIUAWZoF4P4OiWGymsb+V+jUwV8inU6fIZG+ogE3aCoNPNFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Wed, 16 Apr
 2025 20:26:44 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.025; Wed, 16 Apr 2025
 20:26:44 +0000
Message-ID: <07549649-3712-47b9-917b-c5001f9761cb@intel.com>
Date: Wed, 16 Apr 2025 13:26:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] octeon_ep_vf: Resolve netdevice usage count issue
To: Sathesh B Edara <sedara@marvell.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <vimleshk@marvell.com>, Veerasenareddy Burru
	<vburru@marvell.com>, Shinas Rasheed <srasheed@marvell.com>, Satananda Burla
	<sburla@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20250416102533.9959-1-sedara@marvell.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250416102533.9959-1-sedara@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0125.namprd04.prod.outlook.com
 (2603:10b6:303:84::10) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MN6PR11MB8102:EE_
X-MS-Office365-Filtering-Correlation-Id: 456a27fc-50f2-4139-3b61-08dd7d250122
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VHRybGduKzhDaVVMZFhzNFVpVWxQR1VXSENLNHU2WEl4NUdiUzZEQTB6QXF5?=
 =?utf-8?B?N1g4U3JnZEpaRGV3S2hSYUlidzcrRHlSOFdraVdVdVdLL0VoK1ArdWVTNWZs?=
 =?utf-8?B?NDVDZHozdXovenVxYmplc1BuYUhFSXhndEY0cTBzekxzVkk0Y0ZaS2lmb0hm?=
 =?utf-8?B?cDBlMFVIL0RPNzduTVlTdFpjblFwS0h2UGlIZllvb3UydGNybksxMDVkZUUv?=
 =?utf-8?B?bmp5MWwveDA3UWM2dmI4cWUxK3dkSlpNMGgzcm11UnNUTU1YMkttNmh3N21u?=
 =?utf-8?B?Qnp3V2cyTU9ubXQwN3lvbmNiQ25mUmtVQUFVWi9qK3BmVGR1SDdGWENVeEpM?=
 =?utf-8?B?TXlqVVFwWUNHdG02ZzRiU1dUWGNmK2l0RnZuWGpqUlBrdW44VTZvT0tOcy9s?=
 =?utf-8?B?OWNDTUJydFErVFNMRWlST0RNNDhmQ2RMREZHQlJTS1RFU0pjaUhqVXFvYU53?=
 =?utf-8?B?aGwwQ3dxV0dIR2dTM3NIU0hDZTlrZlFYU0NIWG9NZndia0dqVGZPK014Qmsr?=
 =?utf-8?B?ajBMN2pMUGxnSGV6SmNPZ3o4b2RkaHMwY1AvRjEvMWthMGFXYkozSXZrbnNJ?=
 =?utf-8?B?aEg3Q0hROFhCNmdKM04zei9vR2w4TkFDNTVEMHN5QlYrcGs2U2VXSWl5akpq?=
 =?utf-8?B?N0I0d1hSQ2pTQU4xbzNreC9HVUdZS1grL3AzbFFRaUlqaGZpWnYxTDkrU01y?=
 =?utf-8?B?d2NvbC91TGZ1aUI4UzNXcjBPK3pZNEplWjVjUDU2ZHBydytMM2YvRmtTN3Qw?=
 =?utf-8?B?c25GbDh2d0lEdXpMblhYS2NqQTIwelZuTDlGa3JTejhQWVFMSGZQaHNzNy9E?=
 =?utf-8?B?dlN6dlBBbXRXZlNpU0dES2JKVXJxUjZMUzBnT2R4TC8ybVZNdlA1Y1BpSS9a?=
 =?utf-8?B?QkJ2WkQ0ajNoQkJXelB0WlJzZHpPYTFhZjQyUS93NUpzeERjdXNpYnArdXNF?=
 =?utf-8?B?ejFva2pyQUlCTmtsTVpnT1gxTzVaVVoyUTgzM0M4eE1ZRXd5bFQ1ZHZCV0d6?=
 =?utf-8?B?dVE4c2E3U0IrS0FwYWhjSVJLQjRyd2cyQnlkc1hObzM5Rml5LzE0Z0pPZlhD?=
 =?utf-8?B?VlU3QmttcjNQdEVubVd2RmhXQWZKVU4yalR1QmdtekxPbnkyM2JaUDNTZnlK?=
 =?utf-8?B?K21jOEZxMlhMUkhxWWRGcXN2RytzZHJ5V3cyZ3VGYmZDRVROS0d6RVhENTlY?=
 =?utf-8?B?OGNGUTIvL2d4cXFiSlFlU0pRY1kvK0dnZ2hxNGp6dlkzWlh6Tm5tM3lYUXVI?=
 =?utf-8?B?ZlgxNkxEc2t2LzkxSnhrcmE3S2RONkxDU3R1VVpPeHl1Z084RVdGN3BpV3pD?=
 =?utf-8?B?L3Fydmp0cTRjaFRJVkFuZW55ejhjVW1wOE15OEN0bERtVXNaTWp0RmdES205?=
 =?utf-8?B?aEd3ZFVVNWE5SUdHN3VqTWFwKzRsNDE3MnRJcVJJV3lET1FCc1JKdFlTa3h5?=
 =?utf-8?B?dmlsR1VHUlRvOVdJZ2w2ZWtTTlRlTG1nd1pJY0poNW1nclBtQ3lqcmpnY2tG?=
 =?utf-8?B?WGlncHkyc0dseUVVM0YzWmREbWIyamZHVlM1bUtCZnN3N3ZTYU1ZTTk4VXVZ?=
 =?utf-8?B?Zjk2SElScXZPemdXSFBMV0tXYkdJVWdHMWM4a3RpeUxGV3YySkxVc1dCOG1E?=
 =?utf-8?B?QThHLy9HMVk5NUxHcUhqamd5S3pEYnlxTnU0ZTRtSTdjYmRuQVBaNWgzdmFh?=
 =?utf-8?B?V0xnYnRQc21NcDUvUE1FaUJudGUzRVE2YndraHFtTHRhOU9KYlRQbllwVkRu?=
 =?utf-8?B?WW9QU3NIVUs3YjY4M2ZHUXVUSFBKZk1uYWNYNnV1SzRoUXJ0bnZ6WjVJUndV?=
 =?utf-8?B?UGxxTk5NNThXb1g1ZE9JTGoyQk9waUNxQWFaSmthQ2w2ZEpuQnFUWHcvdUtI?=
 =?utf-8?B?cFphWEJJajczSThGUU8xZ2hsSzc3SVR3WWhmVW9wbjdmbjlwZnlrNDFjV1c2?=
 =?utf-8?Q?wsV63LG3KtE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGlKQlRkbHJUS3lpOFZqOUhIeVhlb25TeTUzbVRhSFl0Q1pmTFFDS2NVSURK?=
 =?utf-8?B?cjVTelZySnMyVEpLcFNiT2thK0Joamd3VnNGV3lSOFNwZXgzcTZYcXp6VHl3?=
 =?utf-8?B?R3AyKzk0cG1GK09ialVVWHVDRTd5a1I5K0ZDK3lIczhPNVJ5U1MxVndQQ0Zm?=
 =?utf-8?B?clJJTHBkTnV1Ym5yNzIzL0hsd0xTZ3ZDZkNYaUJqZDY4VDhtNTBjeTc0b2sz?=
 =?utf-8?B?TDl0eGlvLzY3MTM4cFJtS0N3UTlweS85UDdzbERxMjROa3hZVGExWnFWcHNI?=
 =?utf-8?B?WUVBbUk2b0dGeGJCNVlKQysvN1Y1ajFiaVo4VU9mamVHL1BycEtVTTNuSWhF?=
 =?utf-8?B?UHZaQU5Nd1ZvMitkWWgrTEszQkVvUFBXaC9OUUdjMEFHMXBXM29RTmxjQUV1?=
 =?utf-8?B?eTBOMzZiNWlsWjhSVXFFKzlmcW1ZL0RFOGYzeExXNFZvR2JEV0J2aHhUM3ZE?=
 =?utf-8?B?T3FqT0J4K3NteGRDOU95LzF4emtPcVJnSm13cHVXY1oyOHF4eDVoY3ljcVNo?=
 =?utf-8?B?MVBEbCtmcGJyd2IwYWdCNUNaS3JuUmJ2dzROcnZTSGRPdHpkd3RvWFVJM2Y0?=
 =?utf-8?B?R3B2MVo1ZWR4dlFwdDNOd0E4YzhocncwQzduSmZ0TzROV21jdTU4S25BVXZH?=
 =?utf-8?B?QnN4WDV0dzhDZmZvTTJWeVZtOTZVbEVwL04yZUc0SEZWSm9nMTNPd0lHdTFX?=
 =?utf-8?B?MVFjRjI5dHJNVExIRWw3WmNuRFZYazR5QmFkN2ZIUDVpc0tJYzRzSk9YYUhD?=
 =?utf-8?B?d2RSc05rS1JwSHpRSys5a3pzSGV1cEtTWFdrSyszajAycmNBSEhOQVZCdUgx?=
 =?utf-8?B?K0c4TGswZHZqaWtsK3o1Y3VTbkpHd2pocEdhQ09ERGpaL1BPc2R2aWgrU0tx?=
 =?utf-8?B?bVdXelVOMGVhSFJlVHhKQ2NJalhTbThlalBjYWtjV040YTY1L1VVZ0g3TG9Y?=
 =?utf-8?B?OSs5QXFYd1FzK05UTkhaYW1qVUppU2x3U3BPclFieWVvMG40TVc0aDFDamtm?=
 =?utf-8?B?aC9Idm52RXhJbU1mSnZ1djludUtHMDhKQU5jbXUrYzBIRzBRYmJtaU42ZHFK?=
 =?utf-8?B?cXNWWklkZjd3TUZ3eVpJOWIrcWtnUUkxdmpLcExKb1FkZ05KeVlHUVRuMjcz?=
 =?utf-8?B?ZWxoOWI0b20xeFprNmFrTnJvcHlONlpialZIL0tWei9oWE5odkJNMXI1YXJI?=
 =?utf-8?B?R1plSnk2UjlRQ3BDRjNBZ2NGTFI4SWpTcVk0bjBkd2ViS2ZBTWFVTFVvQXJs?=
 =?utf-8?B?UHRUS0gwOFhLbkRJaHBCSnpZamVXbFlHL0N5RTlyckNjSXlkWTNwZDR4MGhj?=
 =?utf-8?B?bjRSako0QlJCeTZjd1prS0JPZUdkQThwMlgwZEFIeDlVc3NhTzd4eHIwd29x?=
 =?utf-8?B?MUJ2d2t2Zlo5ZHVRdFJZTzBPSC9nUHd6K1ZjSi9oRVhDOFJEVFE1cDdZSk0z?=
 =?utf-8?B?UzdEY1E3MTFqdHNHL3AxVU12cnlFNWxxTFlTcFI2bVl6SXAvcHM5dldKL2s0?=
 =?utf-8?B?QUhSaXNLTi9aYjd6TndxQ2E1Vk1wSHdwbjNVN0Q4SWJ6RGtLdkFXaUNZaUF2?=
 =?utf-8?B?dGhuVmRpUXRvUnVsWXMvdXFXeHlkeU5TalVralJPZHhnZ05zamNMQzRvUGpi?=
 =?utf-8?B?dkUyTUU2aVU0Y1JkMG1PTUJ1UWl4aytONUtXaUViZEl3R25vTElkSXJ3VThj?=
 =?utf-8?B?SE9TL2h0RlhRN2x3dVpzWnJPYUJ2NURpWVQ0RVlXbzhLN0VqRHJIbElZSW5l?=
 =?utf-8?B?Ym1tNkpJMldha2JQUXkxUU1IT01FS3Q1Tzhzckg0SjhYMDRMTDd0aEMyUUcx?=
 =?utf-8?B?azdtakpLNDFOTG9Ed090MzlHVjlUYlhvdXRLMHdFWUdDMzZQWHlYNlRDOWVh?=
 =?utf-8?B?c2NNS284R2Nkd3RDTHJnVVhJREcxcld5NC9qS0piYWoyNUQxeStiVU5RVGJ2?=
 =?utf-8?B?Y1k2b3hpOEptWThUY1IwRVRmczhJOVZkY0syU2lMNGlxMW1lUUlZTXRoaDdN?=
 =?utf-8?B?T0tHdGhZRzZNWmlqZlhzenZUQ1FDQkd4ZGEzelB4elZKaXU1cHFrVnF4UU05?=
 =?utf-8?B?d1ZGUjlyKzBvZjM4STh5THU2N1o4M3J1SmRycW1YVTF1OWlaYlU4enFVV09T?=
 =?utf-8?B?b0Zib0szS093VU5CU2pNQllOcWMreEV3UWlEUWh1Z05pWlpxZFYrL1kzR3Fu?=
 =?utf-8?B?aWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 456a27fc-50f2-4139-3b61-08dd7d250122
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 20:26:44.4042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vvFOAtVHXEKQtd7CA+r4QX4yPNev2KK0WSNtTz1YTeeMDhUSTYRfRlty7sGcl3nwwrRWNZdY7D7HY0rL5izuzjgBspp4c16FpF5OJnvandc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8102
X-OriginatorOrg: intel.com



On 4/16/2025 3:25 AM, Sathesh B Edara wrote:
> The netdevice usage count increases during transmit queue timeouts
> because netdev_hold is called in ndo_tx_timeout, scheduling a task
> to reinitialize the card. Although netdev_put is called at the end
> of the scheduled work, rtnl_unlock checks the reference count during
> cleanup. This could cause issues if transmit timeout is called on
> multiple queues. Therefore, netdev_hold and netdev_put have been removed.
> 
> Fixes: cb7dd712189f ("octeon_ep_vf: Add driver framework and device initialization")
> Signed-off-by: Sathesh B Edara <sedara@marvell.com>
> ---
> Changes:
> V3:
>   - Added more description to commit message
> V2:
>   - Removed redundant call
> 
>  drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
> index 18c922dd5fc6..5d033bc66bdf 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
> @@ -819,7 +819,6 @@ static void octep_vf_tx_timeout_task(struct work_struct *work)
>  		octep_vf_open(netdev);
>  	}
>  	rtnl_unlock();
> -	netdev_put(netdev, NULL);
>  }
>  
>  /**
> @@ -834,7 +833,6 @@ static void octep_vf_tx_timeout(struct net_device *netdev, unsigned int txqueue)
>  {
>  	struct octep_vf_device *oct = netdev_priv(netdev);
>  
> -	netdev_hold(netdev, NULL, GFP_ATOMIC);
>  	schedule_work(&oct->tx_timeout_task);
>  }
I guess the thought was that we need to hold because we scheduled a work
item?

Presumably the driver would simply cancel_work_sync() on this timeout
task before it attempts to release its own reference on the netdev, so
this really doesn't protect anything.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  


