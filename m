Return-Path: <netdev+bounces-235716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 997F9C33FEA
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 06:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F384465682
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 05:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5ED263C8A;
	Wed,  5 Nov 2025 05:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ayYmZzxP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9DD269D17;
	Wed,  5 Nov 2025 05:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762320480; cv=fail; b=isWIF6SS7mYeBSfbh7tJDrkN15FhLfi8Q63+kuorw1kc/b31AqKFITBNzcS9VSIHZzo0HlxqQzkEsFt1O3moLSftHnq/ojCxc4kOton67hUsHhQMjzoR3JvVxxvynd7FOFg652WKCqqRKeqY7vIZGKafBY0V45pFFhAjW2p4Nuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762320480; c=relaxed/simple;
	bh=8RQizqXTq0he+PkoVfrLB7bHQc+imP0EsDy93F23sEk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Mw4NlsQ1GPSZekRxPYVp/Nmczwhl979XJ+3GDg62LrGCIyJyU5wvDwqqFfOphKl+3GMOCdeUNVWujIEcvrGLoKPulIatQ1nupeHz8RGdiqBhh6uuqpduhnYjBqss2zpj5EJ0VHLnQ0lSJxRq3sbqePyZUVEX1a5Ts7nsJ4qzWLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ayYmZzxP; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762320477; x=1793856477;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8RQizqXTq0he+PkoVfrLB7bHQc+imP0EsDy93F23sEk=;
  b=ayYmZzxPeu+pQmqWUNlUnencY68sjRdUjHqnMIrsZXFhLWJgElQHt7Q4
   iRk7+qFLUP9meOKK83o6A6+r/0jFK6iUEDITcUqTxaYaKeozOOy++QWtL
   DUsqS5Pkyw8mnA7ywAnxAXSSYbwOos754w7oXagZ0BeND1crMQaxeEFhV
   yh5lbaMibsd8lO718svspw5mOWGWTojY5VHOiF96MipGkqDpXw4neDeJp
   6BJptm7sjX3PJCUJ6FM6f7+QIlezAHZJmy91guuBpwWKxCCMhkRZSew/P
   7xnfqHhnQpoCoIVXSpmvUpf1tONG53NvbATs4Gb+OwKMyyeAvU5D9TpkS
   Q==;
X-CSE-ConnectionGUID: KwqLfXIwR6iGHMx+6jMzVA==
X-CSE-MsgGUID: tMW3Yp1USEiNQcJ7kj07TQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="64525598"
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="64525598"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 21:27:56 -0800
X-CSE-ConnectionGUID: RVc6YlNzTwmEccripzCulw==
X-CSE-MsgGUID: Z5ADI7RPSIO1eGb67CjvmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="218143538"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 21:27:56 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 21:27:55 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 4 Nov 2025 21:27:55 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.41) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 21:27:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BBIJauk2XPQmWSM98BcRPaINTx8EA+OIPVQ92h+QaCqcmov65HIQhkFN57Jj0RHYDT/X5oaldkib4zKzPqLbTZCCnsKXa1KCGj9XzZTko5/t9eW+JKrIhTV3yompHqBG2TFaVHqT0I9t5m/wzJeI86LYLUyqe0JnTyy+zAvrM65ETT1k+AZFfQaeRMnJYRqnaGmDXiFlCNg6CXvVtD2P/q4CSFb46BaU+b6tzo3yFGbRy17G0xNQko6F/YWEV/uQyPyMx8oWSM6A5tvSrSH8nU7L6q1is6NaC18et+TDN11HGw0s2YoNkArDdiWoMfMJVeQkPVJfJ9Dov/StiGVn/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mr11VZKfEEjgxqK5I9owDkPFgZaJgPoe0pk3ts2ReoI=;
 b=zA6tTK/ryg3gNa8vK3z5pDYW0+4IIhN4Yg5P5qWbgMYiS0cY9TUDLzurJE08cAtC3iw+MJ3XPCVGZZgBPC64N1mEvaP5/f30jTJlH0xRzGxZwSaIw7eEZdwqZKyiFKPobL8JdhXxGn/M6n9nrrsu/vLtQ6oSf3UA3lwZKZnQlmAMsswbZJ8IdYyxqgHCF/71JPcBU6bMq4b5tKhT2qJOXhVZli4CoYvLY8wmp7iwqUdCyxjYHRLKq4j+c9l942Xm1sx+flF4c9krowCwJu1fY/brQN/kLwfg73sAft9PsMngNKuMn6nKxoeN8z70DCsQFrCUxyTbAs8JkeB79fzHgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB8182.namprd11.prod.outlook.com (2603:10b6:8:163::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 05:27:53 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 05:27:52 +0000
Date: Wed, 5 Nov 2025 13:27:44 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Amery Hung <ameryhung@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>, <netdev@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [selftests]  efec2e55bd:
 kernel-selftests.drivers/net.xdp.py.fail
Message-ID: <202511051230.e23ce003-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: TPYP295CA0040.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::12) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB8182:EE_
X-MS-Office365-Filtering-Correlation-Id: 70d7f03b-90b6-4323-1fcb-08de1c2c10e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kh4Usu2Y3JpVv8Jm5QE0av1ANwIQ1fH7kWP/hWX7S7kjgVgtwcx5srd+gkhL?=
 =?us-ascii?Q?tmjh8+chv8GOJIbhkqGBpJE5/WdgzB0/Qq15g8o1tJNVniwgb0tZV+Aj8eP4?=
 =?us-ascii?Q?q4YCWxHrnKbGdvLYWeETUacAacjhdZnABuxcEBk/hxG0ne2JFIq5z4RBz95m?=
 =?us-ascii?Q?8y89E7W17GYm9qxC7X7x4C/vUkxGRRdsDYCXRgvUiUG8T/KsRTvbpPBIKPtg?=
 =?us-ascii?Q?ZmQoGMkn106qysx2pkc9XWRTXWzVxMlUzyThTr6UEBYq1RDW6vzVAUQo15Ax?=
 =?us-ascii?Q?VbAWdHLVQa9++tCp3260gs2t49BIO17YYC9VjUMgjfUUWbPiaqXow1AB3M6Q?=
 =?us-ascii?Q?7R9Kw/uQirK8syi+7hvj42EL3/G9JNRTODf4hIEtcB2AVbznNSwXMoDr0qnl?=
 =?us-ascii?Q?VfehubsLj/FshzAkLc2PhN9vD3Gz0jR1XvwAfbPNApDp4DI5OLxhGCwh905n?=
 =?us-ascii?Q?YUezpzoaxqejM27oKVpLk0vkpyOXrDNsl5OBDO4rXTJk5vNUXvMZY0Y5m7oM?=
 =?us-ascii?Q?+SnVBE+gVzsoxMF1qt2MnQZDS5Z9qSX3Bs/tKjkN/iYoSmq3s2IGvmT6l9y5?=
 =?us-ascii?Q?uuCjDBq60iNuBhnp/BEL60s19Nmw6gjVuVjQNxcVoEC9OAi4bHaSEPF2XvEd?=
 =?us-ascii?Q?I+6PwksqaxWR0UMf6yoK7PhjyXaWlrqs0CyaZU68g7NH+MakPRYOLsVeGIOZ?=
 =?us-ascii?Q?gnLwzxWfR6mhd2TJh+XkxOGMsGbeWo7Pw5qCf7dCwtMrpK0urSQTJmwLhqr2?=
 =?us-ascii?Q?PHFujpATUKWee8B1xNpVZBFkHlAB9a0t82jLExzg3Nha8a+Td2AQ7+LcDWri?=
 =?us-ascii?Q?lgGwbyO3qeshmXc5wjtnxbHxwpXOhJXTtdbLHbxcxr0RcuCGxAGB8yy0+hPD?=
 =?us-ascii?Q?nPxEZeMRoXR86ikQMOdhPRPMUGumg1m80mieHUsgGqStAIGZuS7P0tAojDeS?=
 =?us-ascii?Q?mHHctU6MfQVxOUOaHMKL/6R6AVMCn6xqjJ7dUgVvGQAkS9/uhr7gSv6UPObZ?=
 =?us-ascii?Q?YJ8CHRdUOODJloobKcY5FW8TyS3MZ1rC1xYniwBGbrh4/ih5t2hy5+AZUwZP?=
 =?us-ascii?Q?3bTSD8uFZPxNPpfPJ6ooryw4Xl4kjbjGaITiMlAzWcVWotBcFUkcHP4q85uL?=
 =?us-ascii?Q?22Cgky1j0dKMTbys5/KvZloe9fmUFXRqKpMacfjKd3V5LoaTbilDyHh8gYUx?=
 =?us-ascii?Q?cLCh1Snr7sUPj5hnEgMVfadUOu7pd/JQD26A7ofZwWqQ2etSJhPM0iVPO/mn?=
 =?us-ascii?Q?q/wfPR0fQEdk5LsgmiNRe5GE/Ynu7nRM1h/agMYblcKqCI7+gOh0Wmpdqk5a?=
 =?us-ascii?Q?wmctmqS0OZscnmW/37QciUJido4XD3TT6uEOYfFYRD1RoSbWTHod2ZnaVtLq?=
 =?us-ascii?Q?Ggugu1lXHGGKOuh8pEd2EKg1JsMCzFwTzY7QXOA+9ol4kti+Ww=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VDOHPGLyaXIsvtafZ0DfVYjelS5DdWj/wUih8cyX7psyZwx0aBTlVDpKlVGo?=
 =?us-ascii?Q?XfK7v1toy71xDGEHqrxjqRpBMElnxb279/RCBChoOpK24McsaPuU8JRu0ygr?=
 =?us-ascii?Q?+08OHvthxWe3M2gQu34Zu56wi0RWICZjMEx3F/s1OT1ostRoJrjDzKugdt6+?=
 =?us-ascii?Q?ELgfbxetv1sG4+0/5VnqDPtqlOQq35J+OBIWCfIHS09hGzHZLPxFgXzIsKKy?=
 =?us-ascii?Q?dS3loLrqou2cbHoCLSWk+onmFGSeTT/xJ+V9OqLj25vB2OfPtpxcAOzt52Tb?=
 =?us-ascii?Q?NOVbj5Y7o0bVGE6Kfd//cUcFyS4dyT8D9mzGu3IhrFdaXMPB9ZxuYh6qvZDP?=
 =?us-ascii?Q?PjxiuvDgJ/NdjTD/ccfcz/aYSZELYumYtnebat7YC+1vyAuTNcfZNZQQLccj?=
 =?us-ascii?Q?GJ/tdM6AJ2oSHJxUJUK9MA5fWQv3TXHwj/4QikBLCKG9LKdQVRunwXJAJQL4?=
 =?us-ascii?Q?QZubXytAhVD0EgArJqwJxWjzGtrSQ3dN2yLTzqmba9tGdkAVgkBfV5lmZwP8?=
 =?us-ascii?Q?32+FZnJE57taQWEA7hXF1DNwxA0HxVVjVJu+5XowMTS884gZLorslHy8ABdq?=
 =?us-ascii?Q?kNfa46/vbm0Df3Xpz5zaM56QIfzNKZDRZ7e0So6oyArADmAy1+0mhd1Mxi9N?=
 =?us-ascii?Q?AtInI7YyB67cxZmzdqGaWBsr5D4LOF6z0+TXDqsJxFArj1+MohZM+ZzNSJGG?=
 =?us-ascii?Q?gj1zudtgR6D8W0eKeo0XVjcWeQrwhbxANIlIBayENwJf94UeUFaDoCwASn/M?=
 =?us-ascii?Q?qod86xqPPaKxqzELjI0C8EW/ML+kwRAybLWaSqWmBzFsuWXCMZ0a8KbHctd8?=
 =?us-ascii?Q?vP2lWPy8HTQQejQbrLiP+al7CZ2/2DoF9FxBHEZ5pBOCYqHwKYGY6dDVUZJT?=
 =?us-ascii?Q?C5IlYJNOk2OMPs+tSDtAsIPciYvWeR0/J9KeD0Xv2D5780iBkHDPABHSYq7L?=
 =?us-ascii?Q?iFlo4dSmAgKEu4fTiz+oJ4SAaYhtYc45CzWmONQW0gJ+Iu7rDqnOzmp2wA8Y?=
 =?us-ascii?Q?cQQgYJ/j900Je4daf95ulKcF73fLcnmspvW1ieqUu7+rUO2psZdK0Nl4U+PZ?=
 =?us-ascii?Q?oetujU3lixa1sm0y2snQg3Tx1kmKfWv9N9MKQ+BQS4eOdf49QFGm/qIeQhla?=
 =?us-ascii?Q?jQ4bCOtnW36VhZ+J3XCn/f112Ggsue6Fl49oSfxNSSKjDLv0Ky0UlhWSFNs5?=
 =?us-ascii?Q?uFIHe8xrgG9ge3/K3EVFi0DpKUmO1I2++L3E0Le+7GNKYaJGvnA7HE3sFoS1?=
 =?us-ascii?Q?uHzZK0qpD8Fj/sPktLFt44otR05F7uPPBzEFTHjo+Js9hF1GVkhkg797O7U+?=
 =?us-ascii?Q?jQ7m3JMgOgAbRBqPYVQl8uBiQOMoL3JHwe5yDl53cAVx2x8lKVypaiw0n5Ez?=
 =?us-ascii?Q?Tn6axESdNgJiqXqPKY1ia8iP1AA0CXW0SKWIB73nZ6XeFmjKyb8qPUmXFf9X?=
 =?us-ascii?Q?JbXZ6h+LOXLcFP5GD4Gx+0Sf6mE3T6bEQFyaXkJWchSG0dA8Xrpr4ulW81MB?=
 =?us-ascii?Q?E28LwZ5DPPiCmNVyRlmGM+tIJZ8ZKA/Zq0RWxEwp241NoLEdBaKtaVJiKB9f?=
 =?us-ascii?Q?YCw1uoE0uS0jfuQRVthiVkzZWvHRMPGTOiwcUzCVC4pjXLIMNZjTLn4ygLMC?=
 =?us-ascii?Q?NA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d7f03b-90b6-4323-1fcb-08de1c2c10e5
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 05:27:52.3954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SM5Ksi7KUu7yHJFiS6+TX0maI8Du1x7Dn4KI89rG8cPhhXRqwZg43V+6LYdH7WHJbCIBZ4WDR2LYNkz/AVHruw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8182
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel-selftests.drivers/net.xdp.py.fail" on:

commit: efec2e55bdefb889639a6e7fe1f1f2431cdddc6a ("selftests: drv-net: Pull data before parsing headers")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

parent can always pass.

323302f54db92dc1 efec2e55bdefb889639a6e7fe1f
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :10         100%          10:10    kernel-selftests.drivers/net.xdp.py.fail
           :10         100%          10:10    kernel-selftests.drivers/net.xdp.py.xdp.test_xdp_native_adjst_head_grow_data.fail
           :10         100%          10:10    kernel-selftests.drivers/net.xdp.py.xdp.test_xdp_native_adjst_head_shrnk_data.fail
           :10         100%          10:10    kernel-selftests.drivers/net.xdp.py.xdp.test_xdp_native_adjst_tail_grow_data.fail
           :10         100%          10:10    kernel-selftests.drivers/net.xdp.py.xdp.test_xdp_native_adjst_tail_shrnk_data.fail
           :10         100%          10:10    kernel-selftests.drivers/net.xdp.py.xdp.test_xdp_native_drop_mb.fail
           :10         100%          10:10    kernel-selftests.drivers/net.xdp.py.xdp.test_xdp_native_drop_sb.fail
           :10         100%          10:10    kernel-selftests.drivers/net.xdp.py.xdp.test_xdp_native_pass_mb.fail
           :10         100%          10:10    kernel-selftests.drivers/net.xdp.py.xdp.test_xdp_native_pass_sb.fail
           :10         100%          10:10    kernel-selftests.drivers/net.xdp.py.xdp.test_xdp_native_tx_mb.fail


[test failed on      linus/master e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6]
[test failed on linux-next/master 131f3d9446a6075192cdd91f197989d98302faa6]
[test failed on        fix commit 11ae737efea10a8cc1c48b6288bde93180946b8c]

in testcase: kernel-selftests
version: kernel-selftests-x86_64-8bb886cb8f3a-1_20251104
with following parameters:

	group: drivers



config: x86_64-rhel-9.4-kselftests
compiler: gcc-14
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202511051230.e23ce003-lkp@intel.com


# timeout set to 300
# selftests: drivers/net: xdp.py
# TAP version 13
# 1..9
# # Exception| Traceback (most recent call last):
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/py/ksft.py", line 244, in ksft_run
# # Exception|     case(*args)
# # Exception|     ~~~~^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/drivers/net/./xdp.py", line 231, in test_xdp_native_pass_sb
# # Exception|     _test_pass(cfg, bpf_info, 256)
# # Exception|     ~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/drivers/net/./xdp.py", line 209, in _test_pass
# # Exception|     prog_info = _load_xdp_prog(cfg, bpf_info)
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/drivers/net/./xdp.py", line 114, in _load_xdp_prog
# # Exception|     cmd(
# # Exception|     ~~~^
# # Exception|     f"ip link set dev {cfg.ifname} mtu {bpf_info.mtu} xdp obj {abs_path} sec {bpf_info.xdp_sec}",
# # Exception|     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|     shell=True
# # Exception|     ^^^^^^^^^^
# # Exception|     )
# # Exception|     ^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/py/utils.py", line 71, in __init__
# # Exception|     self.process(terminate=False, fail=fail, timeout=timeout)
# # Exception|     ~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/py/utils.py", line 91, in process
# # Exception|     raise CmdExitFailure("Command failed: %s\nSTDOUT: %s\nSTDERR: %s" %
# # Exception|                          (self.proc.args, stdout, stderr), self)
# # Exception| net.lib.py.utils.CmdExitFailure: Command failed: ip link set dev eth1 mtu 1500 xdp obj /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/xdp_native.bpf.o sec xdp
# # Exception| STDOUT: b''
# # Exception| STDERR: b"libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was CONFIG_DEBUG_INFO_BTF enabled?\nlibbpf: failed to find valid kernel BTF\nlibbpf: Error loading vmlinux BTF: -3\nlibbpf: failed to load object '/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/xdp_native.bpf.o'\n"
# not ok 1 xdp.test_xdp_native_pass_sb
# # Exception| Traceback (most recent call last):
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/py/ksft.py", line 244, in ksft_run
# # Exception|     case(*args)
# # Exception|     ~~~~^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/drivers/net/./xdp.py", line 243, in test_xdp_native_pass_mb
# # Exception|     _test_pass(cfg, bpf_info, 8000)
# # Exception|     ~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/drivers/net/./xdp.py", line 209, in _test_pass
# # Exception|     prog_info = _load_xdp_prog(cfg, bpf_info)
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/drivers/net/./xdp.py", line 114, in _load_xdp_prog
# # Exception|     cmd(
# # Exception|     ~~~^
# # Exception|     f"ip link set dev {cfg.ifname} mtu {bpf_info.mtu} xdp obj {abs_path} sec {bpf_info.xdp_sec}",
# # Exception|     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|     shell=True
# # Exception|     ^^^^^^^^^^
# # Exception|     )
# # Exception|     ^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/py/utils.py", line 71, in __init__
# # Exception|     self.process(terminate=False, fail=fail, timeout=timeout)
# # Exception|     ~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/py/utils.py", line 91, in process
# # Exception|     raise CmdExitFailure("Command failed: %s\nSTDOUT: %s\nSTDERR: %s" %
# # Exception|                          (self.proc.args, stdout, stderr), self)
# # Exception| net.lib.py.utils.CmdExitFailure: Command failed: ip link set dev eth1 mtu 9000 xdp obj /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/xdp_native.bpf.o sec xdp.frags
# # Exception| STDOUT: b''
# # Exception| STDERR: b"libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was CONFIG_DEBUG_INFO_BTF enabled?\nlibbpf: failed to find valid kernel BTF\nlibbpf: Error loading vmlinux BTF: -3\nlibbpf: failed to load object '/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/xdp_native.bpf.o'\n"
# not ok 2 xdp.test_xdp_native_pass_mb
# # Exception| Traceback (most recent call last):
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/py/ksft.py", line 244, in ksft_run
# # Exception|     case(*args)
# # Exception|     ~~~~^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/drivers/net/./xdp.py", line 278, in test_xdp_native_drop_sb
# # Exception|     _test_drop(cfg, bpf_info, 256)
# # Exception|     ~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/drivers/net/./xdp.py", line 256, in _test_drop
# # Exception|     prog_info = _load_xdp_prog(cfg, bpf_info)
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/drivers/net/./xdp.py", line 114, in _load_xdp_prog
# # Exception|     cmd(
# # Exception|     ~~~^
# # Exception|     f"ip link set dev {cfg.ifname} mtu {bpf_info.mtu} xdp obj {abs_path} sec {bpf_info.xdp_sec}",
# # Exception|     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|     shell=True
# # Exception|     ^^^^^^^^^^
# # Exception|     )
# # Exception|     ^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/py/utils.py", line 71, in __init__
# # Exception|     self.process(terminate=False, fail=fail, timeout=timeout)
# # Exception|     ~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/py/utils.py", line 91, in process
# # Exception|     raise CmdExitFailure("Command failed: %s\nSTDOUT: %s\nSTDERR: %s" %
# # Exception|                          (self.proc.args, stdout, stderr), self)
# # Exception| net.lib.py.utils.CmdExitFailure: Command failed: ip link set dev eth1 mtu 1500 xdp obj /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/xdp_native.bpf.o sec xdp
# # Exception| STDOUT: b''
# # Exception| STDERR: b"libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was CONFIG_DEBUG_INFO_BTF enabled?\nlibbpf: failed to find valid kernel BTF\nlibbpf: Error loading vmlinux BTF: -3\nlibbpf: failed to load object '/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/xdp_native.bpf.o'\n"
# not ok 3 xdp.test_xdp_native_drop_sb
# # Exception| Traceback (most recent call last):
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/py/ksft.py", line 244, in ksft_run
# # Exception|     case(*args)
# # Exception|     ~~~~^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/drivers/net/./xdp.py", line 290, in test_xdp_native_drop_mb
# # Exception|     _test_drop(cfg, bpf_info, 8000)
# # Exception|     ~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/drivers/net/./xdp.py", line 256, in _test_drop
# # Exception|     prog_info = _load_xdp_prog(cfg, bpf_info)
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/drivers/net/./xdp.py", line 114, in _load_xdp_prog
# # Exception|     cmd(
# # Exception|     ~~~^
# # Exception|     f"ip link set dev {cfg.ifname} mtu {bpf_info.mtu} xdp obj {abs_path} sec {bpf_info.xdp_sec}",
# # Exception|     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|     shell=True
# # Exception|     ^^^^^^^^^^
# # Exception|     )
# # Exception|     ^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/py/utils.py", line 71, in __init__
# # Exception|     self.process(terminate=False, fail=fail, timeout=timeout)
# # Exception|     ~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/py/utils.py", line 91, in process
# # Exception|     raise CmdExitFailure("Command failed: %s\nSTDOUT: %s\nSTDERR: %s" %
# # Exception|                          (self.proc.args, stdout, stderr), self)
# # Exception| net.lib.py.utils.CmdExitFailure: Command failed: ip link set dev eth1 mtu 9000 xdp obj /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/xdp_native.bpf.o sec xdp.frags
# # Exception| STDOUT: b''
# # Exception| STDERR: b"libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was CONFIG_DEBUG_INFO_BTF enabled?\nlibbpf: failed to find valid kernel BTF\nlibbpf: Error loading vmlinux BTF: -3\nlibbpf: failed to load object '/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/xdp_native.bpf.o'\n"
# not ok 4 xdp.test_xdp_native_drop_mb
# # Exception| Traceback (most recent call last):
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/py/ksft.py", line 244, in ksft_run
# # Exception|     case(*args)
# # Exception|     ~~~~^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/drivers/net/./xdp.py", line 303, in test_xdp_native_tx_mb
# # Exception|     prog_info = _load_xdp_prog(cfg, bpf_info)
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/drivers/net/./xdp.py", line 114, in _load_xdp_prog
# # Exception|     cmd(
# # Exception|     ~~~^
# # Exception|     f"ip link set dev {cfg.ifname} mtu {bpf_info.mtu} xdp obj {abs_path} sec {bpf_info.xdp_sec}",
# # Exception|     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|     shell=True
# # Exception|     ^^^^^^^^^^
# # Exception|     )
# # Exception|     ^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/py/utils.py", line 71, in __init__
# # Exception|     self.process(terminate=False, fail=fail, timeout=timeout)
# # Exception|     ~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/py/utils.py", line 91, in process
# # Exception|     raise CmdExitFailure("Command failed: %s\nSTDOUT: %s\nSTDERR: %s" %
# # Exception|                          (self.proc.args, stdout, stderr), self)
# # Exception| net.lib.py.utils.CmdExitFailure: Command failed: ip link set dev eth1 mtu 9000 xdp obj /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/xdp_native.bpf.o sec xdp.frags
# # Exception| STDOUT: b''
# # Exception| STDERR: b"libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was CONFIG_DEBUG_INFO_BTF enabled?\nlibbpf: failed to find valid kernel BTF\nlibbpf: Error loading vmlinux BTF: -3\nlibbpf: failed to load object '/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/xdp_native.bpf.o'\n"
# not ok 5 xdp.test_xdp_native_tx_mb
# # Exception| Traceback (most recent call last):
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/py/ksft.py", line 244, in ksft_run
# # Exception|     case(*args)
# # Exception|     ~~~~^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/drivers/net/./xdp.py", line 462, in test_xdp_native_adjst_tail_grow_data
# # Exception|     res = _test_xdp_native_tail_adjst(
# # Exception|         cfg,
# # Exception|         pkt_sz_lst,
# # Exception|         offset_lst,
# # Exception|     )
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/drivers/net/./xdp.py", line 408, in _test_xdp_native_tail_adjst
# # Exception|     prog_info = _load_xdp_prog(cfg, bpf_info)
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/drivers/net/./xdp.py", line 114, in _load_xdp_prog
# # Exception|     cmd(
# # Exception|     ~~~^
# # Exception|     f"ip link set dev {cfg.ifname} mtu {bpf_info.mtu} xdp obj {abs_path} sec {bpf_info.xdp_sec}",
# # Exception|     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|     shell=True
# # Exception|     ^^^^^^^^^^
# # Exception|     )
# # Exception|     ^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/py/utils.py", line 71, in __init__
# # Exception|     self.process(terminate=False, fail=fail, timeout=timeout)
# # Exception|     ~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/py/utils.py", line 91, in process
# # Exception|     raise CmdExitFailure("Command failed: %s\nSTDOUT: %s\nSTDERR: %s" %
# # Exception|                          (self.proc.args, stdout, stderr), self)
# # Exception| net.lib.py.utils.CmdExitFailure: Command failed: ip link set dev eth1 mtu 9000 xdp obj /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/xdp_native.bpf.o sec xdp.frags
# # Exception| STDOUT: b''
# # Exception| STDERR: b"libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was CONFIG_DEBUG_INFO_BTF enabled?\nlibbpf: failed to find valid kernel BTF\nlibbpf: Error loading vmlinux BTF: -3\nlibbpf: failed to load object '/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/xdp_native.bpf.o'\n"
# not ok 6 xdp.test_xdp_native_adjst_tail_grow_data
# # Exception| Traceback (most recent call last):
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/py/ksft.py", line 244, in ksft_run
# # Exception|     case(*args)
# # Exception|     ~~~~^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/drivers/net/./xdp.py", line 480, in test_xdp_native_adjst_tail_shrnk_data
# # Exception|     res = _test_xdp_native_tail_adjst(
# # Exception|         cfg,
# # Exception|         pkt_sz_lst,
# # Exception|         offset_lst,
# # Exception|     )
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/drivers/net/./xdp.py", line 408, in _test_xdp_native_tail_adjst
# # Exception|     prog_info = _load_xdp_prog(cfg, bpf_info)
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/drivers/net/./xdp.py", line 114, in _load_xdp_prog
# # Exception|     cmd(
# # Exception|     ~~~^
# # Exception|     f"ip link set dev {cfg.ifname} mtu {bpf_info.mtu} xdp obj {abs_path} sec {bpf_info.xdp_sec}",
# # Exception|     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|     shell=True
# # Exception|     ^^^^^^^^^^
# # Exception|     )
# # Exception|     ^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/py/utils.py", line 71, in __init__
# # Exception|     self.process(terminate=False, fail=fail, timeout=timeout)
# # Exception|     ~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/py/utils.py", line 91, in process
# # Exception|     raise CmdExitFailure("Command failed: %s\nSTDOUT: %s\nSTDERR: %s" %
# # Exception|                          (self.proc.args, stdout, stderr), self)
# # Exception| net.lib.py.utils.CmdExitFailure: Command failed: ip link set dev eth1 mtu 9000 xdp obj /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/xdp_native.bpf.o sec xdp.frags
# # Exception| STDOUT: b''
# # Exception| STDERR: b"libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was CONFIG_DEBUG_INFO_BTF enabled?\nlibbpf: failed to find valid kernel BTF\nlibbpf: Error loading vmlinux BTF: -3\nlibbpf: failed to load object '/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/xdp_native.bpf.o'\n"
# not ok 7 xdp.test_xdp_native_adjst_tail_shrnk_data
# # Exception| Traceback (most recent call last):
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/py/ksft.py", line 244, in ksft_run
# # Exception|     case(*args)
# # Exception|     ~~~~^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/drivers/net/./xdp.py", line 604, in test_xdp_native_adjst_head_grow_data
# # Exception|     res = _test_xdp_native_head_adjst(cfg, "xdp_prog_frags", pkt_sz_lst, offset_lst)
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/drivers/net/./xdp.py", line 528, in _test_xdp_native_head_adjst
# # Exception|     prog_info = _load_xdp_prog(cfg, BPFProgInfo(prog, "xdp_native.bpf.o", "xdp.frags", 9000))
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/drivers/net/./xdp.py", line 114, in _load_xdp_prog
# # Exception|     cmd(
# # Exception|     ~~~^
# # Exception|     f"ip link set dev {cfg.ifname} mtu {bpf_info.mtu} xdp obj {abs_path} sec {bpf_info.xdp_sec}",
# # Exception|     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|     shell=True
# # Exception|     ^^^^^^^^^^
# # Exception|     )
# # Exception|     ^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/py/utils.py", line 71, in __init__
# # Exception|     self.process(terminate=False, fail=fail, timeout=timeout)
# # Exception|     ~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/py/utils.py", line 91, in process
# # Exception|     raise CmdExitFailure("Command failed: %s\nSTDOUT: %s\nSTDERR: %s" %
# # Exception|                          (self.proc.args, stdout, stderr), self)
# # Exception| net.lib.py.utils.CmdExitFailure: Command failed: ip link set dev eth1 mtu 9000 xdp obj /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/xdp_native.bpf.o sec xdp.frags
# # Exception| STDOUT: b''
# # Exception| STDERR: b"libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was CONFIG_DEBUG_INFO_BTF enabled?\nlibbpf: failed to find valid kernel BTF\nlibbpf: Error loading vmlinux BTF: -3\nlibbpf: failed to load object '/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/xdp_native.bpf.o'\n"
# not ok 8 xdp.test_xdp_native_adjst_head_grow_data
# # Exception| Traceback (most recent call last):
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/py/ksft.py", line 244, in ksft_run
# # Exception|     case(*args)
# # Exception|     ~~~~^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/drivers/net/./xdp.py", line 625, in test_xdp_native_adjst_head_shrnk_data
# # Exception|     res = _test_xdp_native_head_adjst(cfg, "xdp_prog_frags", pkt_sz_lst, offset_lst)
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/drivers/net/./xdp.py", line 528, in _test_xdp_native_head_adjst
# # Exception|     prog_info = _load_xdp_prog(cfg, BPFProgInfo(prog, "xdp_native.bpf.o", "xdp.frags", 9000))
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/drivers/net/./xdp.py", line 114, in _load_xdp_prog
# # Exception|     cmd(
# # Exception|     ~~~^
# # Exception|     f"ip link set dev {cfg.ifname} mtu {bpf_info.mtu} xdp obj {abs_path} sec {bpf_info.xdp_sec}",
# # Exception|     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|     shell=True
# # Exception|     ^^^^^^^^^^
# # Exception|     )
# # Exception|     ^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/py/utils.py", line 71, in __init__
# # Exception|     self.process(terminate=False, fail=fail, timeout=timeout)
# # Exception|     ~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/py/utils.py", line 91, in process
# # Exception|     raise CmdExitFailure("Command failed: %s\nSTDOUT: %s\nSTDERR: %s" %
# # Exception|                          (self.proc.args, stdout, stderr), self)
# # Exception| net.lib.py.utils.CmdExitFailure: Command failed: ip link set dev eth1 mtu 9000 xdp obj /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/xdp_native.bpf.o sec xdp.frags
# # Exception| STDOUT: b''
# # Exception| STDERR: b"libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was CONFIG_DEBUG_INFO_BTF enabled?\nlibbpf: failed to find valid kernel BTF\nlibbpf: Error loading vmlinux BTF: -3\nlibbpf: failed to load object '/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-efec2e55bdefb889639a6e7fe1f1f2431cdddc6a/tools/testing/selftests/net/lib/xdp_native.bpf.o'\n"
# not ok 9 xdp.test_xdp_native_adjst_head_shrnk_data
# # Totals: pass:0 fail:9 xfail:0 xpass:0 skip:0 error:0
not ok 14 selftests: drivers/net: xdp.py # exit=1



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251105/202511051230.e23ce003-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


