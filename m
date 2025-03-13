Return-Path: <netdev+bounces-174776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D366EA6049D
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 23:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92CCD19C36F0
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 22:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C3E1F5835;
	Thu, 13 Mar 2025 22:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e9hw7SfN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0711F192E
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 22:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741905974; cv=fail; b=kVrUYbWCR+lI0ykLQZ6XarrMTHJYCn4v/rcUIdSEeVwQXPa+g++av7asEcebyUF7vROJBHx7fntpr/s+icTN7VjwC0Q/og7ZgTnohy8jOE1X0V3aagYj9gHgV4+oS1xplFtKWrfyJD0q5S3Iu+dw/5tLjDcnvsBT1qMYTWDGl68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741905974; c=relaxed/simple;
	bh=3+0q/MWabhTaNqC4RhESUsF6frsMaJdEyR3vodnwdGQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YndWIhrhBDAukZaXtGhK9ZajkLsCRzJOX1bwXiQyYa+4Tc7kb2jJ/QmLmghoZFVOSuw5beF7IeihEpbw5bp4d/0GVuRs9lzZ956LTUnFJgXCu2Lf3ACNxUeenSYBtz9J38+nGfbBN8sjQxweiwluLiznfahJGyTjyn9hj79s34g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e9hw7SfN; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741905972; x=1773441972;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3+0q/MWabhTaNqC4RhESUsF6frsMaJdEyR3vodnwdGQ=;
  b=e9hw7SfNmdGM3W0i0A+nKZWakPV8VgK+J3RQfLj03XoGPMSZK8Q5yTZI
   ejWYFMg8qwjtsRKBYVpprCDp34c5gADTkh9OtjvYlDUf3baKhEkNGsipi
   hivGVslEiCbmkPUOCOOJuNEBsCcRRLNX+hqTd6rFJ9ItpApPysOZe892C
   U1C5JBR/1CEsW1+gGUI1sz4ZugqCQET4IfP710ensRfhJcDbQJ4JiDfSD
   wlqXVKUf2lhkHS/GV4wAB4Y3WTZ6Te0DEiC1KN4gMykKxuXSibtDJ0/zy
   EBRP0qjrzfB+68QkTzGZmUrdKYsnDqJJM5FY5W2NkmSZime67hoOhdtvz
   g==;
X-CSE-ConnectionGUID: 6NDXaftkQ5SDgivEZcQBUw==
X-CSE-MsgGUID: 25BHMs/yQBa4ujAC55za4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="53254257"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="53254257"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 15:46:10 -0700
X-CSE-ConnectionGUID: dICkhWL1QYyNI9Vp+fB+4g==
X-CSE-MsgGUID: dUDGpEphSlKz71GHn4cDWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="121597300"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Mar 2025 15:46:10 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Mar 2025 15:46:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Mar 2025 15:46:09 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 15:46:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LYvQkd5KNNSlJ7Q+qGGLP675dP91poq1IlGBKOdv+trBoxavJR4/qwbOq3omI2iQ9DUjv9rIJQX5MhAc7xSDO2h5XOkWzvCMUyjNbgqXfCl+vx7NHa75+ojSoBDGnlD9LXBJTKyX07TCb1XUjFh7guuazlvVknsMUnEqNhf2icmqrtu8t8tI54y+B5LJQmuy41zd/mQO+5BwrNZgkOARsyXOD97qSevYRy0FACWj5orDJxPL09XWVI7QULiJabJr412rm7rjPoFuPapTdY1Tv8bxXya50J8F4qpBc2DffVh617EhEsXPd6w484wnVJ4Fp9of9YX2dU+6SiaNBA0jQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gF7igV2hpRpAhRAJrIKMI6TxvK0pVol/kVwJTrOt0Q=;
 b=Crmk+enrlNGhtmGUcxLp/Wp0PJ83HsvP815i0zZjWyelioD8ynrB6NAtySmjq3z735uC6kmoJtDKwhAO+RUozmph4HrvxmF02IPyuMhvknQ4Cq8p/HeAR2lkR2LzeHNYnUBXsxM6P/gIHI+XG86BOIc6LqsHLT+4dwF2QEBsu+HQjOjy6YYZDIvaZFT86UL6cY6/B+xTea/XPKuNSw6xII/02V4Cq4iUI13nY4NEtGs4Gi6iGXSvdCfFab9+9s2Sbj84VpCLK5/BDXzRgtTAnZGhpOyNIO0Cc7IYzquUs7B3bAveUiOQKPfa4dj8LGnxAy5Y9pLfxI8ewgWRzwM0EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB6492.namprd11.prod.outlook.com (2603:10b6:208:3a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.33; Thu, 13 Mar
 2025 22:45:50 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 22:45:50 +0000
Message-ID: <ab1e57b6-815c-48ad-8a7a-2979080bff9d@intel.com>
Date: Thu, 13 Mar 2025 15:45:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/7] bnxt_en: Driver update
To: Michael Chan <michael.chan@broadcom.com>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <pavan.chebbi@broadcom.com>,
	<andrew.gospodarek@broadcom.com>
References: <20250310183129.3154117-1-michael.chan@broadcom.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250310183129.3154117-1-michael.chan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0003.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::8) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB6492:EE_
X-MS-Office365-Filtering-Correlation-Id: a9cb484b-15fd-470b-a9a3-08dd6280cdc4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDFJTzN1U2NsTFR4akVVZFFGQnRxdzk2alVHWDE3Y01GVHpwMEtsdUtqMy94?=
 =?utf-8?B?bUUyeGh5ZDhhdXo1SzRDdUxuWEVTN1JWRC82cURNUDFLRjNZTXVFcGlva3pz?=
 =?utf-8?B?ME9iYjJYOHF4OWtwbWgzRXlCcHBQYThKR0VUWWdIUmMyTjVMdU1JaGFEUDY3?=
 =?utf-8?B?bENMODQ5N09qQ2paLzh5eTBZL05WTXYwb1c4TFpUNXJpMld2TUl2bXo5eWRh?=
 =?utf-8?B?RmFjTHpkbGNqTWhBWExXWlUzVFBNTXVSREt6VkI1K0JSMmY0b2dTVThHekhp?=
 =?utf-8?B?UXNrWC8xMjBrem0walRXVVA3ZW85WUpFU09scHdhVGJFUUlsME5IYkREYWRN?=
 =?utf-8?B?bzhxTmhmbGZRL2pZc01jbjdJbTFEcWpHN3ZKTFZjeFIxVkNkZ21mcEJCRXlN?=
 =?utf-8?B?b3loOE1IQUV1Mm0wL2ZQZkRsRzd3ZDNaZ3IzMGcyeW5LcTc4bTRJd3ZWMEZ3?=
 =?utf-8?B?U3JDeFB0TVZQbWlYSDM0aGorWDh6b3YwZU51L094bjF1UzA1OUJ1QVJtWGh3?=
 =?utf-8?B?eUxDQjJ6UDAwQzk3WXU3YnpkKzNPOUljMk51Y0lwOHovczB2TktGNVc0cFBv?=
 =?utf-8?B?R29MbzR2UWJCUU1vc1hMSmd2Nk1jQ05vMXZtUGg2NWdLVU9xdUpLRGNqRjM2?=
 =?utf-8?B?bmVVc1N3ZkQ1dElVNG5pNUszaWpMemxtYmVuMkEyRU9FM2JVZUJDdlRWSDdt?=
 =?utf-8?B?ZEhMRno1ekV5TUYwWmlTRjVFTDFFRTVVNnplekJtTnBZNGoyL1hxVkZCcEV6?=
 =?utf-8?B?YmtWRXJ2SDRSNUpWcjBIQWtrRjh5ZjR4YWtXZnE0UCtJSjVQcEVPQ3hPQjk2?=
 =?utf-8?B?c0xXVEt2bGNqMjBiamdPaE1ZWUE4bnhjaG14UHJGMVI4elF4aTV6TDg4b0Mx?=
 =?utf-8?B?N1JrYTB2K0hWR0RJenFsMTBMSm9Ya2t0QzM0eGhNKy9nVXo2TGxMVkYvbHJE?=
 =?utf-8?B?OHRaOEs0U0NqVFYxYUtwNWlXQTlJWmUzYWZlZW1GdjNFR213bENFSFd4K2FE?=
 =?utf-8?B?c0FQUVZyMTgxWGRKeHFPNHRqMjd5ODdxWnp6K3BDRi9wajcwTVlpTC9OZFYz?=
 =?utf-8?B?dnBBdVViZjBEKy9IeUxRdHBXbWU0TnFZVFNCdUY2ejRqM3FrdWJLa1loOFR5?=
 =?utf-8?B?V05ncWhPWVhoUHhxWEllZjNJTGkvSTV6TUR2OGZhUlQwUkpnS1l2YlFQR1BU?=
 =?utf-8?B?SUhwUGFpUjdtSGxEV0hDV0t4RXNvRHVhYjlPREFTenM0SHdmcC9aalJuZkhO?=
 =?utf-8?B?RFV3bTFYQkJ1THRqdVNRWWpsZitPaEEyK3F4S1FQdXZ2QzlZaFE4ZWFrV214?=
 =?utf-8?B?N2tFTDhHamE0YnliYnNiTEVoc3BqNzJCOGo5a3RSdUtqUkllQzZWcnVhN1BE?=
 =?utf-8?B?eFhaSURrbEw1RXB4bmpTMEZ4eUZidlI3dzI4d2l2bmc3dm9kR1JjTFZZR0pH?=
 =?utf-8?B?RVFXdmViNWg4c1NzUXRyenJkeXIzaTYwOFp0WGJzeFdUV1Z0TmpuUnRUeHlX?=
 =?utf-8?B?elRxU2ZyNXZCNGhDMG12cVhGbVdFRE1oc1pyWjJTaG9YOVpnS3FFcmRuUHVw?=
 =?utf-8?B?MVZUbDZkUDVCYlJhSFZaNG5yckhrS2ZXdUhwTGRwWHBRVUhRZzJURmJmcGhW?=
 =?utf-8?B?NE1GdjFjSnFZaW9zbWUwQXlZUjMrR1ZIOFA2ZFREa2RRWTcyb1RUVnF4QXJW?=
 =?utf-8?B?RENPaXdsV3o3R2hHcncxU1RPUjhwVVdNckZMNFJZTGwzamZ5M3J5R0NLZnBu?=
 =?utf-8?B?NTEwTDFFa3lBM3p3VC9TdDBxNlRnbDIvWTRCRmk1TlcxcXdNWHljcDl3cWln?=
 =?utf-8?B?czk4Y2JLbk51SFdRZ1A5dGJrQ3RWdDhlSFh6Q0dTKzlZNFhFQzhyTnI5Mjlu?=
 =?utf-8?Q?JrfUmqL23j6u6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUhnTjFRY2dXV1NKOCtJbWRGUlRkdWhjalZIVG5sYUlWTVcvdTJjcFhTb0Rm?=
 =?utf-8?B?Q0NLeVRlU3cxRnE1UVRmNmZVcG5yNVpiVTh4cGNVS2lyTllTU3BJc2VtTWpZ?=
 =?utf-8?B?SHBjTUZkMDMvc1NSdFZFZjdVVG5nRlhjNmd5eXdHZ0h0SnJlcXY4QzNUODFW?=
 =?utf-8?B?aFVCM1REZTNqQXNZLzVoSmZzcTdjaFYvWVdxSi9yWXV4V3o1SngwODIvT0Qx?=
 =?utf-8?B?RzFUNVFtN09tMFBpNmRuTzBIZWxvNk9IWjdqZzErWUZ3OXMyTGlkRm5CK0N4?=
 =?utf-8?B?Y0JZazRnNG1wL3FQSElGbEZHTUR3ekNLZlYrK3pjTzRROW1STDNpbVlyajFJ?=
 =?utf-8?B?K1BheGhJV3NBaWd3N3F0U25lcytQOEk3OEtVYlllTHJVbVpzT1VsYWFKUHNn?=
 =?utf-8?B?SzRDQzBLeU9qSHZPbHE5S2lhSXZCZjVKTE14ejFtRHY3bC9XKzBuUWUyT1B5?=
 =?utf-8?B?V296WGgyVVlHVVZNa2x0VWczZWY3aXk5VkxGL3RrMituNkZZbzlVTGd5QUx3?=
 =?utf-8?B?RmRla2xsWEYyMExvN3B4L29ScytaNkRJM2d6Qk11alJseENGUldJa2FRaXlV?=
 =?utf-8?B?d243b1BBaWUzdVFyRVFLQkNRMVJ6ZjI5L3JQUmFmY3k1VzFMY0YyNUVieEg0?=
 =?utf-8?B?M1VwQUJYMjVma3ZMU3JINHkxeDQ5b0hqR2lPVnRlT1hETnA3aTZCT1JndjZj?=
 =?utf-8?B?NFcxTE95aitoL2NBV2p3WlJuTWlScDJpZk1LSHNHTGNTaldYcFFXWjdjQzE5?=
 =?utf-8?B?OHU2TUk0NHI5MDNKLzFwcVMyWHhQY2orSzRCYjV4SHN4c2JDdmJzaEdVd2Zy?=
 =?utf-8?B?dlpUN1pRaFRidlpkekNpRlQzMUxDSFUrTHBxeGZGTFIwcGllTi9oSEEwN3pN?=
 =?utf-8?B?YUxYL3M1emRqd1NrNDVWNkZ4b25mTGpBWW90ajdzb3gxQ2JLanpVbjJVbU9a?=
 =?utf-8?B?c1RxM21rS0I5VW04Q0FuMW1wMzRiUmk4YTRWdHNlcUJOR25vaHFiZ3FUV3FD?=
 =?utf-8?B?d2lkTmVpKzBkWXRhVkpQQVhVZUpzZ0JxV1JyYkFxam4rWFI0TUl6ZTRIUXRx?=
 =?utf-8?B?OUV6TXg0d1Nmemc3b2N2SkFML1N2Q0pXUHhDRFZWR3lqNGFSMG5heDJCSnFz?=
 =?utf-8?B?Mi9VbEFVcHNkYmlsOVRRSitybkZZNXRrM3NFdWlvenBiUHVFOUhXUzNzL1hx?=
 =?utf-8?B?cUJBRnEyUjUyNkVuY2Z2KzlsNXcrQk5JMUtnM2J6SnNIbXkrRUdFWnBZRDVN?=
 =?utf-8?B?UkNobUU4cmljNzVZdE96aXc4dEYyV1FzeXcxQkorQU5lSlcxK1ZlZmoyWlNx?=
 =?utf-8?B?QVNUWTg0SU02QjQ1VEJ4TndWTHd3Wlo0WHl0UEV0VDBUYzRCcS8zOFl5czdr?=
 =?utf-8?B?ZTJ5bllZVnQreUZDSUNLdWhEejhRSm5FUGgwWjJrVTNVVjIwM1g0WFltVEFH?=
 =?utf-8?B?ZnlOYURCZ3NsWEYyWSt0djQ1czhKOUxGKy9QQjF5SE5EUWZoVnFqd0FUeDBu?=
 =?utf-8?B?NGk0RzkwL0FJUG54M0pYeWxyVlNQQkhxMFBmSUhuc2E0QXNEMDlzelV6MGNs?=
 =?utf-8?B?aEtUSzUzT1FKMlNlLzU0bjJ4NzNLV1NDQkpqTDRGNXZ4ODZCMURyWnlLUTdQ?=
 =?utf-8?B?WlQzaEI1aFFEdHJDNUxGNU9CTFNUa3Evd2ZESU5uVjJGWlRtZU5xSEhSNnoz?=
 =?utf-8?B?VUtzVEl3Z0R2ZWxjVUdKNUpGWldqWHQrcWhoM3hkaDRYZDRVSHhkbUoydWNR?=
 =?utf-8?B?QnhhRmFtb3R6WnVFeHNZekZhS25BK1pLa2FiNnhNNlNTQlFqN1IrbHg5bVRt?=
 =?utf-8?B?UnZ1bDFqakJEdjZLZXFvTFh2UHg3MmlkREVuZVA2cm5QRDV0V2FjTGh3T205?=
 =?utf-8?B?ajBKMy9Eem01TTlCY290RG9sejR0OTBsQmR4cW1oSk1jcTVDOEJFSWdSOC9X?=
 =?utf-8?B?ZlphMW5JZ3l3SFVaeGNvZlZNSDZZWXRtR1VSaEdHT1VUWTlSb3ZFbzlDZFBu?=
 =?utf-8?B?b2lTQk1tSDVEdnNIcU1DbXUrL0xXTHg0eGNpcy9mdEhBbElUb1V4dlhtTjM1?=
 =?utf-8?B?YXY2YWNpRHNvZVlCZTJRejN6cVAvdk9tdEt6cmE4N1haY29Gb24wRGxKeU1L?=
 =?utf-8?B?dXB0aTBuVXRQWUl2R0JLRmNoTHh2emNaYTBTc3hjNTdzbUFmRldLcmhlOXhS?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9cb484b-15fd-470b-a9a3-08dd6280cdc4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 22:45:50.5309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: myG26vwvYMydHZYUga+rJRkB1rBnP5WfYEXqcwuhuY/DB4ny2g/YJIk62mUp2J6OOUOu4+C1miGYbRUXIYlMQuV1ZDLXHrYoU2N3guhO3sI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6492
X-OriginatorOrg: intel.com



On 3/10/2025 11:31 AM, Michael Chan wrote:
> This patchset contains these updates to the driver:
> 
> 1. New ethtool coredump type for FW to include cached context for live dump.
> 2. Support ENABLE_ROCE devlink generic parameter.
> 3. Support capability change flag from FW.
> 4. FW interface update.
> 5. Support .set_module_eeprom_by_page().
> 
> Damodharam Ammepalli (1):
>   bnxt_en: add .set_module_eeprom_by_page() support
> 
> Michael Chan (3):
>   bnxt_en: Refactor bnxt_hwrm_nvm_req()
>   bnxt_en: Update firmware interface to 1.10.3.97
>   bnxt_en: Refactor bnxt_get_module_eeprom_by_page()
> 
> Pavan Chebbi (1):
>   bnxt_en: Add devlink support for ENABLE_ROCE nvm parameter
> 
> Vasuthevan Maheswaran (1):
>   bnxt_en: Add support for a new ethtool dump flag 3
> 
> shantiprasad shettar (1):
>   bnxt_en: Query FW parameters when the CAPS_CHANGE bit is set
> 

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  Documentation/networking/devlink/bnxt.rst     |   2 +
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   8 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   1 +
>  .../ethernet/broadcom/bnxt/bnxt_coredump.c    |   9 +-
>  .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |  95 ++++++++----
>  .../net/ethernet/broadcom/bnxt/bnxt_devlink.h |   2 +
>  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  85 ++++++++++-
>  drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h | 143 +++++++++++++++---
>  8 files changed, 279 insertions(+), 66 deletions(-)
> 


