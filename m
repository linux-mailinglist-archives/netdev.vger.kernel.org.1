Return-Path: <netdev+bounces-282886-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBsEO5pm82ky2QEAu9opvQ
	(envelope-from <netdev+bounces-282886-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 16:26:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E004A40C4
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 16:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5C5A3014135
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0177040B6FB;
	Thu, 30 Apr 2026 14:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iyV2uI5e"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ECF13B58A
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 14:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777559067; cv=fail; b=Wo+s3rsR3Y5v6ejcyI6R+CLAqDp/zKIzhn4fsQHXbojnjs6kUvbWcpLASMzkNOoGlpQWkswdh5bC2FGwBODGfN9Py4pC1nHJBwblvf5xIIk/yZF7WOON4oA1rTNqW8LMBWO0whxOpxON4kXdXdF7z6rRG7Ra9ROXAxtu8c6Ly+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777559067; c=relaxed/simple;
	bh=4Nvd7kLPKd+y3765klxEjZDskGovOYOiBqob9nThSwM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lUT6GkfJBjhWvG5j9o6s0AUge6OGqRR9hK5+vDeL66XK2GMkbyzvcDs8x878KjjEPiUWVOpyIMsdsd8eE0Kpp/AFabnwGn3RZkvfAZ/gKM/1hcI3CKbUG46hMSe7Zj7Z6GMzZ4wkyYUqJNMy04uitnb9ZdoobhulwndBZEdIVGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iyV2uI5e; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777559066; x=1809095066;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4Nvd7kLPKd+y3765klxEjZDskGovOYOiBqob9nThSwM=;
  b=iyV2uI5egnbzQUsOibcGRcIWf8dN6mcBeVm1p+bmtSB1HkBBHNcm90xq
   oVqnjIK42hWgKy5fR1YfdEKyJnnuMGhkIt7EEMLjj9qXhqgsYCk1oMXq+
   Z+G1BJbbeYfRrO3GAzAXAjgV9ehX+ZTySRKrR5+gp5UkgchKVZzikyIAe
   hHRtP+LG92kXLcRWzJA6swz1Q3S+0qPHrzcbq4A/27S4Tgq19PMNVpMbf
   Cu4bNvVNu4Az9TzeOpvfmd0EjbXI537lT9r4mh7CxBRvnn320KaQ6mnlQ
   RPfpDNeAOVs0h4ZvjQ9E8khQI8GZ7G0UotWWj+fLkpEjbX0nEAB5QKXsl
   A==;
X-CSE-ConnectionGUID: kOc4R4gXQGaNti+nE8/gXw==
X-CSE-MsgGUID: LcMqacvNS4OoXpEQS5tOTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="95930407"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="95930407"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 07:24:26 -0700
X-CSE-ConnectionGUID: IbC6nM+LRXyLTbFeg7+GMw==
X-CSE-MsgGUID: uFAFYT7wQTahFCFdGS9HyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="234490427"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 07:24:25 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 07:24:25 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 30 Apr 2026 07:24:25 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.1) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 07:24:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1cuUDRolJ4fhPOEjnAnEdvk2U0Z0U/2SizLJSKAfrK8zZDdGMx+dV9Qcq7YtNco9BNy7avMcIN8VCaWHmgeS+eYcmRHT31GJDfZ+LafPMXdqCO/6vO2Ft+P59KP00xlRLAL6EuamM2FEgLc8YNgx4gqICpONZ2EUyGnY9HgBXhPVzYC4leL+n42MzcI07oPC9xID2BwUKqLmLXTJ+j4gY91f45PtdN/lf7ep7D6BzzyP87AlYvuZFnEXnuLLZcB4uC/fAF+SPg97z1J6NjHxmlgzgsn4guJCIfQINtnnmpoifv16yZayrsQRYiA/npubdmR3F0fG+YkEEvujEcM3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDlTsdqnq4fOkenoCmrMAdhHi1F0RT43yd+c/+bO0sc=;
 b=bbyZrM5+ibsMKLP8uLBknvztV+Hw6JAhwpNpKddXc5pbSxyvSmsbBoW5iV67JLaHvxLwLGsoXquyIWtAHgfAWm6o015uNoLm3EqIwD7Lm9234o/WQH5AQb/SWt2N0dkuPrb+RhuLzRlV2YjtO24BZkRm1YTZs2vd//lKFYUtHZ9OgFf/SZqXc+4w6sKUuKAiJt9Zmf+8n9hyW0cQtbd53JO704o9B2dAD467SSybaKiiwkn3hnYpUcE+ki9ZeNA7h2YIXiq+xSx3dMIBxnkGdCRA3AkEhmvcs0QHN9ebI/mtmp7EtHRFcaK5n3UqXu8kc67BqhciyQIioYR/7lH8ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 DM4PR11MB6263.namprd11.prod.outlook.com (2603:10b6:8:a6::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.18; Thu, 30 Apr 2026 14:24:19 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%6]) with mapi id 15.20.9870.016; Thu, 30 Apr 2026
 14:24:19 +0000
Message-ID: <bd839678-7202-419a-9626-100e11e92144@intel.com>
Date: Thu, 30 Apr 2026 19:54:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 11/11] drm/xe/ras: Add flag for Xe RAS
To: Raag Jadav <raag.jadav@intel.com>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>
CC: <simona.vetter@ffwll.ch>, <airlied@gmail.com>, <kuba@kernel.org>,
	<lijo.lazar@amd.com>, <Hawking.Zhang@amd.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <maarten@lankhorst.se>,
	<zachary.mckevitt@oss.qualcomm.com>, <rodrigo.vivi@intel.com>,
	<michal.wajdeczko@intel.com>, <matthew.d.roper@intel.com>,
	<umesh.nerlige.ramappa@intel.com>, <mallesh.koujalagi@intel.com>,
	<soham.purkait@intel.com>, <anoop.c.vijay@intel.com>,
	<aravind.iddamsetty@linux.intel.com>
References: <20260417211730.837345-1-raag.jadav@intel.com>
 <20260417211730.837345-12-raag.jadav@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <20260417211730.837345-12-raag.jadav@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0165.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::7) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|DM4PR11MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: 74987652-b837-4869-2001-08dea6c42ac1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|13003099007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: xMYS2uHJh5EqbLJeEEHHFP124BEQylDW7KJNQDUmAITflT+GRUi2nFodBbEmyQrPM3VW8ds7P9smFFxrZnG5mlm4k8VZw4I0KEbv366IkBYqnjpwSVGsy0tVcoofe7gufgt+fG/dK37jWGkwpQb1eVdHSPtxzFWiDjr4yvrjoL4nsM5YBJle5tEupA6zhitcbZOXOUPMd3mbDre5uNqA4UhDI3nFk8WXlQ551CocsHxGnYadF1neAHeSWUoJnhmhluTwL38cl5tzt7z72MmCQVrUBnBggCQj1X/SrhLSy1u8WcxvevSaq/gFNud+lk+7sZYQG3DuQXwYYZnyECQQoaQKirYFkPAmqKzE7uvBDTJ6UV9Y9Cf9ERZ6al+ZTaR9V3kkh3QsaJoS4ZNl4YqIbD1awrzNOog+oCO+S/Hs3o8jKNG1HsBxmzzrL36Ol+Yis5RJEJ0+t6TympHXO7jgHCOSlR8ZTCJ0KpRsJIFk+8s1pbjceMDrbRM3InzrgvNKoyR7e5igdDH9wC7dszgtp9/J/khtiVURMM/a4GbeNl0ooZEPe0vNEjyBkUukxLALPDLxJvS0LA6PwFWdnal4042Qm39vseGa1wZFrkUsUUYbZtaaJqXVGPpJtRHbWQdnmLE3Z7REazNHI94WNVvEx3zWpIBcAyX26w4w7RgOVlJeFUOCukgN5qmxkQl0Ia/g4P9HtZ2y4QvUo4OAV889cXJBzMq6O2rdZw40DN2t/MI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(13003099007)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3pjZWFHTGNPSWtQMEowZ09rZnY2aFd2eFdjb2FDUlMrVCtvbUM0Yno0eXJF?=
 =?utf-8?B?c3p6bXNjME8zN2ZtcXpmMDRLd3dXai8wc3VaVi9MZFJkbU1DZ0ZaOVFZWFRm?=
 =?utf-8?B?NmlsMFZSNVRLNlpKZGRCOVNOdlV5MEJCZThFWmdYaXpMYkJaUEtSVk9zclA1?=
 =?utf-8?B?VFc4UWRPNE1YYURac3IzRy91SDMvckVER3J5YkVBOGswMC9GTU9GNllrcSt2?=
 =?utf-8?B?dlJqRU9KTlR0cDR5MTZxR21Ib2lnU0dDQXJWM0FCVGw0UXVrcXhjVzVWOEhQ?=
 =?utf-8?B?SFBTOUFpc3J3Njc0MEkvSkQ4UmxFeG44SjA2N2s5SGYxOGJmaThKM09SdDBa?=
 =?utf-8?B?bDVPUEE2bGx4THQwa3hxWjVWK2dTWFJrajJkU2xIUEpNM214SzRvS3hjZCtM?=
 =?utf-8?B?WnZDSXFxZ0lMMGluY3VVNzFUMUxqVXJET1NPTDZ4N05udjBHOUxhM1hoS2VD?=
 =?utf-8?B?SlRJbWtXdEhjV3BrUnZIS0prS1hqZVdPN09BUHVkaEh1ZTRDQURudzhzZS90?=
 =?utf-8?B?aStteE9nVFArbzhDaFlva3pSWUhKOXU2ZU9HS1F1QjlvdDFGSXhxNGVJWHpt?=
 =?utf-8?B?dFIwd1JqbVNiNXRRdm11MWFndVVoajlqNjZhdWg2a1RvcXV3UjlOc3lwcTlv?=
 =?utf-8?B?ZDVwS3Y0VVRzWkNZdHZlTVZ6U1ZTQ1JHcnJUVUo3RVRVZzFuWHZBaDgrTGhX?=
 =?utf-8?B?Q0lhMVJLcy9KcGVVdlBZYWE1b2h3ZnpQbC9GQmVjWGlIdHhLaGxPLzJodFIz?=
 =?utf-8?B?ZUN6dDRZUmk5TkpBT241WmE2b1dHd1huc0IrcXN0MGZBc2hLbzIyTmYvVTA1?=
 =?utf-8?B?TWtreGh1Rk1rNENXdWI4dGxuOEE0aE81WkIrUTBvNnJMb2NFRmdPc2o5VlMw?=
 =?utf-8?B?aTMreU1HczZhMEpaNVhmdUhwMHdLaGRJT0JxN09QTnQrN2pzS2plcWFVbzJQ?=
 =?utf-8?B?c1ZKdWIzNGpqbVhUMms3djlxQVlhcms1OUlRckdyVGgyT0x4N1JBWXlFaDIy?=
 =?utf-8?B?TGRKRXBYQ21YMU9lWFpEcnh3UjAxQlZCc2M0YWRVeWNab2E2Z0ZXZlUyWXp5?=
 =?utf-8?B?bXM2eGI0YUxzUzkybnd6N1kyU2ZqOUVDMjRCMTFNa1JsL0pvdFE4WFFqS2Rn?=
 =?utf-8?B?SVVqY2Rndi92L1NMK1BiRWJnbkFuKytNT2xpV2VrdVovQktHUW9UTDBpRzha?=
 =?utf-8?B?NjBOTklaeVZMbGwxR1NIRmxGcXVqNGhBWlBMbVk2WDVBVnZoQ3VrZUxCNnN0?=
 =?utf-8?B?NGlMSXY3MlNwS0t0NWZPNllCd0dFNnNOVXlBSDFzTVUyYmNiUU9YRG1QL1N6?=
 =?utf-8?B?eDJFZXNOUmRuTGJvTHFXOWdKbTVPazN1NUZHbld6endDWVJBa2U4YlJRczJ4?=
 =?utf-8?B?UGZDNTdCdit6RHRuN0Zla1Zwbjh2Nk9CQUJ0MFBpZFRjTTdqOXREN01QQVBs?=
 =?utf-8?B?TUJrTWhvNTMwWFFJOWF3c010SHoxQkNicHJVU3I0V2plRDhNd3QrdlVtSUJu?=
 =?utf-8?B?cDk5eUl4UnBYcVU3WEdYS2NjUEpSdlhDYy82VGNmZFNXK0l4MjA2ZmJwc3ll?=
 =?utf-8?B?S3hKTXR2TFJvNWtuNDdERXFqWW1hQ241dDF0RERJb1l5NjFOSENLWVVqcVpw?=
 =?utf-8?B?Z0w0TUZiNHdNOGNpbTdHMitPZUNDaE1oWSs2SGR0QlBBZmdON0pGTzk0aU5u?=
 =?utf-8?B?b0lWVVJwSVZCdjFqK2pEam82cTFJWkRBSHptbzhJWUxhcjEwS1lYVWZGNkJM?=
 =?utf-8?B?TGJqT3JCZnAxQkZHRk9QeGl4NGNhUU9kSFBGM3JuY3p0cXcxSnQyYmowUGxp?=
 =?utf-8?B?MnhVZG5EOU9OeGZ0UnJzZXJWcERSajhsQWdkbTZqV1hLKzBVdThYUFRmeVlJ?=
 =?utf-8?B?eTlQV3hQQ3M2eDIxaWFNMUg2Z1d3MTZkcTZ1bHc3dm9rUXoxWCtKeEttQ3g4?=
 =?utf-8?B?c1FGaVljVEt6UWFIbEpMb0s5UGVKbmRGc3dYMFEvYk9CSnc2SWl3NUsrbU4w?=
 =?utf-8?B?OURmWk5lclhPM3hoL1RVMUZnQzdlOXhRZHoremJvZktyMndVRUhZUkwwOW9m?=
 =?utf-8?B?N1NGWFZuR1VsV3ZTQmF2cjV1TDVObUlaMjhSamlKNFhSZ0o3MGxucVlPNlhy?=
 =?utf-8?B?TVBsd0NNNEtUZS9sd003T2doVGxUeW44elFXdC9NL0JOd2hvalpCQzkvSkZV?=
 =?utf-8?B?TG95KytZbW95YkhTMXFqWVlTY2JmVlB0ZDExTEJha3I0RjRRK3B6Rk5pMTBv?=
 =?utf-8?B?N2ZUZ3AxWGhKZWVqL1FESWErLzRTM1FxbUFaTDVQN1ZzR0NCUkNCVHAwakhH?=
 =?utf-8?B?bUxmY2hrczFyOTVvVHdLZGtsd0lJYTdDVXhua2FZOXpBUkg2UEk0UT09?=
X-Exchange-RoutingPolicyChecked: VtY8DZMVUgMbl4PSDIraJ9eQwDiQ2MO54L0y5iESIxuCemU5gRXkd1uehPyWpexNwsER4iqlcqfoMuUJ4VdtKV+uzFVZ9IdibjSZH3o7sQLk7w+4CRIUK403Zz8VesYeGV+3tjBxj46V2b3gPkH73z2hdAaWxftUedeb7PhN6oiQJtliy9mzuDOWYu996WbRKNvQ1jRY8RC6QZXAysaSPTDhKnr9bSheA7sevhy+wIQhJUVGkWhI9mvW/Bsb0LZ1uDyDn+eDkkUhDh2ipZq5HAVJEjv3iv3Nz31EANaYnm0Y0NdeNXKSrTR0OyRWmaiyZ53sPpLQeQu2ybNFEJDk5Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 74987652-b837-4869-2001-08dea6c42ac1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 14:24:19.6579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZqdNw9ZgA5YlPU1lL4ZDzORnWEnfU1VumIFeIXhlWjlzyk57d6q9s47booc85Sb1O3qCTzv1IyyXYO+/uyG6FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6263
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 48E004A40C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-282886-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com,lankhorst.se,oss.qualcomm.com,intel.com,linux.intel.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]


On 4/18/2026 2:46 AM, Raag Jadav wrote:
> From: Riana Tauro <riana.tauro@intel.com>
>
> Add a flag for RAS. If enabled, XE driver registers with
> drm_ras and exposes supported counters.
>
> Currently this is enabled for PVC and CRI.

Can you please replace this with the latest
  patch in the next rev [PATCH v4 6/6] drm/xe/xe_ras: Control xe drm_ras 
registration with a flag - Riana Tauro 
<https://lore.kernel.org/intel-xe/20260429055147.1579576-14-riana.tauro@intel.com/> 


Thanks
Riana


<https://lore.kernel.org/intel-xe/20260429055147.1579576-14-riana.tauro@intel.com/> 

>
> Signed-off-by: Riana Tauro <riana.tauro@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_device_types.h | 2 ++
>   drivers/gpu/drm/xe/xe_hw_error.c     | 2 +-
>   drivers/gpu/drm/xe/xe_pci.c          | 3 +++
>   drivers/gpu/drm/xe/xe_pci_types.h    | 1 +
>   4 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
> index 31df9debcbb0..7a8afd06e6b8 100644
> --- a/drivers/gpu/drm/xe/xe_device_types.h
> +++ b/drivers/gpu/drm/xe/xe_device_types.h
> @@ -191,6 +191,8 @@ struct xe_device {
>   		u8 has_ctx_tlb_inval:1;
>   		/** @info.has_range_tlb_inval: Has range based TLB invalidations */
>   		u8 has_range_tlb_inval:1;
> +		/** @info.has_ras: Device supports RAS (Reliability, Availability, Serviceability) */
> +		u8 has_ras:1;
>   		/** @info.has_soc_remapper_sysctrl: Has SoC remapper system controller */
>   		u8 has_soc_remapper_sysctrl:1;
>   		/** @info.has_soc_remapper_telem: Has SoC remapper telemetry support */
> diff --git a/drivers/gpu/drm/xe/xe_hw_error.c b/drivers/gpu/drm/xe/xe_hw_error.c
> index 2a31b430570e..3ab0fceb151f 100644
> --- a/drivers/gpu/drm/xe/xe_hw_error.c
> +++ b/drivers/gpu/drm/xe/xe_hw_error.c
> @@ -520,7 +520,7 @@ void xe_hw_error_irq_handler(struct xe_tile *tile, const u32 master_ctl)
>   
>   static int hw_error_info_init(struct xe_device *xe)
>   {
> -	if (xe->info.platform != XE_PVC)
> +	if (!xe->info.has_ras)
>   		return 0;
>   
>   	return xe_drm_ras_init(xe);
> diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
> index 278c2860a4f6..10ff207affa9 100644
> --- a/drivers/gpu/drm/xe/xe_pci.c
> +++ b/drivers/gpu/drm/xe/xe_pci.c
> @@ -365,6 +365,7 @@ static const __maybe_unused struct xe_device_desc pvc_desc = {
>   	.vm_max_level = 4,
>   	.vram_flags = XE_VRAM_FLAGS_NEED64K,
>   	.has_mbx_power_limits = false,
> +	.has_ras = true,
>   };
>   
>   static const struct xe_device_desc mtl_desc = {
> @@ -472,6 +473,7 @@ static const struct xe_device_desc cri_desc = {
>   	.require_force_probe = true,
>   	.va_bits = 57,
>   	.vm_max_level = 4,
> +	.has_ras = true,
>   };
>   
>   static const struct xe_device_desc nvlp_desc = {
> @@ -761,6 +763,7 @@ static int xe_info_init_early(struct xe_device *xe,
>   	xe->info.has_page_reclaim_hw_assist = desc->has_page_reclaim_hw_assist;
>   	xe->info.has_pre_prod_wa = desc->has_pre_prod_wa;
>   	xe->info.has_pxp = desc->has_pxp;
> +	xe->info.has_ras = desc->has_ras;
>   	xe->info.has_soc_remapper_sysctrl = desc->has_soc_remapper_sysctrl;
>   	xe->info.has_soc_remapper_telem = desc->has_soc_remapper_telem;
>   	xe->info.has_sriov = xe_configfs_primary_gt_allowed(to_pci_dev(xe->drm.dev)) &&
> diff --git a/drivers/gpu/drm/xe/xe_pci_types.h b/drivers/gpu/drm/xe/xe_pci_types.h
> index 5b85e2c24b7b..70a9d4995cbd 100644
> --- a/drivers/gpu/drm/xe/xe_pci_types.h
> +++ b/drivers/gpu/drm/xe/xe_pci_types.h
> @@ -54,6 +54,7 @@ struct xe_device_desc {
>   	u8 has_pre_prod_wa:1;
>   	u8 has_page_reclaim_hw_assist:1;
>   	u8 has_pxp:1;
> +	u8 has_ras:1;
>   	u8 has_soc_remapper_sysctrl:1;
>   	u8 has_soc_remapper_telem:1;
>   	u8 has_sriov:1;

