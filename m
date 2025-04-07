Return-Path: <netdev+bounces-179601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3077A7DC98
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 13:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8E8A165067
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 11:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD6822E40A;
	Mon,  7 Apr 2025 11:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FrwbWkYK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBCF22FE0C
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744026190; cv=fail; b=cvBsT5vecR7pZxqfBWKON7nZYe7UjacupoP2fVxxHqhCj/fRjI70xonsZ1RFID4qpAi39Nh2Loa+8YktdMhjAA9RPt0siPqRibgZHM+QtyyzJQN2giX1v9jAzqkuRlh1CPrKkNSjKRkMEXg/ZAABhPcRSCau6Z+vux3TtgfRHZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744026190; c=relaxed/simple;
	bh=ER83v9h4UVAdvoffX9510RqkSRfD3aR8/9YNoxAkStQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u24pKPZnlrNyc/YayT2mUQUpp39ZA7f6Yj/yyfJ1xasxDIfj2tPcd4dYY5xkpbPT1UpszT+j4cfV66PZEINCIOT/K8g1Uc2650DXaX62RG3yENZVqDj9A13VEkrG1689Qyo93onHmBbvGeTEVrxA07aBIZDPegjHAH1Gm2ejGfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FrwbWkYK; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744026189; x=1775562189;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ER83v9h4UVAdvoffX9510RqkSRfD3aR8/9YNoxAkStQ=;
  b=FrwbWkYKWsCoz4m2LhfxdLcF7XIj3w0yedCpuis4pF0VAJJmhRDr1kFb
   BdAIUEGNZQID577LOGK7nx6IagxDr12STBoqfrsgsZVKNPsKSAc1lRYFd
   Bae/fYG5eMOlUsKfGMIJcZZHQBGjZENJXjqz6dNuLxYlja9ax28zNt3cG
   JesT/RkN6XBpAITB4spbb69MCn5yQ8llfWlf6sIPlX/xCjhn16DFl+qxP
   Cj/I62+Hor/fPh1SipkN4/YEHnlcfzO7CU1MPydIfHhvVUUku3Ja/PW86
   IyAPbrq6ZGFMK1sIGc0Ps4SBZqjpseI2lqNMWvM1lwi2C01xl6tDVhEYG
   g==;
X-CSE-ConnectionGUID: CMGRO3IJTn+WE95KTfeAfw==
X-CSE-MsgGUID: OxRO0PSDSrW6KetjQHrc3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="48121435"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="48121435"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 04:43:08 -0700
X-CSE-ConnectionGUID: a1haX7oxRwSd3L3X3mo8OQ==
X-CSE-MsgGUID: GiCsBSJ+QQasBkC8DcHfKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="151120247"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Apr 2025 04:43:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 7 Apr 2025 04:43:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 7 Apr 2025 04:43:06 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 7 Apr 2025 04:43:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZv8n7u9SBrLxifDItuB7EM8oFfl0uoZhTm2ijIG9AdJvODD28L3IArPMtrRpD/AZjM1xNMIuyxIxB6OlnfRg10d/7s5KbwbfaVKCDzzEiPKz3O21UqIhls9GzTlDNY158QAiVXE3BV4RHmvxCRHGgtzuvbR/NbA/XXMJ46PKMcsvRSzqIz3jNWuUv6kNYVpjvJEER6+OIxyoF8ZJSwCZDZj3sBkYNeldThewjbksLGV0Oj6f93EYErYZoD2QmymdQDFwoFvSApBeenzhmjujbyET7Io30N7WOte4kJBDpsAQ4gx0JAyTI60LkT5HW6tLkimd+SwKFVtJMZoofbwHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69aoh6VvxFHum/na76TpgeiE/o7yxp/pkZfqDb3+5nU=;
 b=QSIcfX9UzXYNzAo0BzRRp6dKS0RiqrVL3PzxhwInFd4Vz87GYPPnq3y/NY0uGODW5jj5ltMpe4+vJw7oj+7BGKk9D7+sodqM7mR8DHAEgVVxtn/iStkfNR6MnycRhFtXh229g5WqcqNJRahgoa0ykyBl9hG3psS0vgqmavpNWCXdl8UllBUR4oPiVbwDGYC72yiRCHnvYUooqOlpER06Rh63eAm9EZ1jCXwMTCNiKsUrX2VpAa5OQ0On0ADRURUWxmgn8r9GeVJwFtqmLMvS96yifehu1KBSd69bEOFqjD6+l8JKJdqAyLa+TUK3naccZcQUFPQDL5Uixc34FqAEcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 DS7PR11MB8853.namprd11.prod.outlook.com (2603:10b6:8:255::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.34; Mon, 7 Apr 2025 11:42:33 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%5]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 11:42:33 +0000
Date: Mon, 7 Apr 2025 13:42:20 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>, Jacob Keller
	<jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>, Jiri Pirko
	<jiri@resnulli.us>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>, Grzegorz Nitka
	<grzegorz.nitka@intel.com>, Michal Schmidt <mschmidt@redhat.com>, "Sergey
 Temerkhanov" <sergey.temerkhanov@intel.com>
Subject: Re: [PATCH iwl-net v2] ice: use DSN instead of PCI BDF for
 ice_adapter index
Message-ID: <Z/O6HAm3GMWe/0aE@localhost.localdomain>
References: <20250407112005.85468-1-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250407112005.85468-1-przemyslaw.kitszel@intel.com>
X-ClientProxiedBy: ZRAP278CA0013.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::23) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|DS7PR11MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: 77f0273b-8aa4-4705-703d-08dd75c9492a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+ZlDyUulyNcAlyCdsWPEICyRxYn6u8NBSOkcUNQ8D++mKUciOhBZJvl5BR1P?=
 =?us-ascii?Q?7PF8eFhgPtd+BmFAAPEzmBtZuAWivu1LQhNuLCNkxtDDCJ8B3YkuR8+mKdJ7?=
 =?us-ascii?Q?gXsIVzENRqWc/AaGOmDvWogHJyfIcmQ3s5l2uNtJ0BC6zmu6LyI++5sQHuqN?=
 =?us-ascii?Q?/8AMlYXV2XPSTqOB0DSlaFupTgd9po2YaopKZ3BAK2VuxXAHm2QIh83E1drd?=
 =?us-ascii?Q?qy7ZbdR1xdKYD5zOC1CAT2LFYMP4gYtUYcuP4FLPocuOF1eOkAt2uqT/yP1/?=
 =?us-ascii?Q?A+fMvLuK+IjKCewWUvkL+CMbpgA+6JQlpVj+UAJpSWHBzbxj+HkgVBkCCjuW?=
 =?us-ascii?Q?mzgwlqkrUH/74gZzJxKfsCeOUnRLQCUHrfNnXBOw26ClHFayrzmLtpTZylMB?=
 =?us-ascii?Q?/z8LTitqovqUBAYF7gUyS7KtsqMGGiSiyOYC898Vh8Z+obsC70J4DcmjSyhD?=
 =?us-ascii?Q?v1c2AA+C+0aXOzWuXNfmyqeYW7aW2G6YtivuGYxIi+0MOw2bxuxTI7MCsAXg?=
 =?us-ascii?Q?3gyJhzW00OK340UD792hAVqX/mKvkwWfozcYf0DhjdWVn6T6xv0+1CXnVmGU?=
 =?us-ascii?Q?CgppSoOWiiWcxeWjSXGDt/QoyOmEgg+rAJVpAdlaWvNyvL9vneOg0c+hCSw7?=
 =?us-ascii?Q?mqcl8vyPWFFMjQSCUtzGr/v9O6cjvYuYsICtridT2QMZFWbCPly1V+sZQfMk?=
 =?us-ascii?Q?4+I8FD7lT/NfpoT9gCU34yry/CynhvbnbqhDEphnc1eRUv2FRJHEWnb70Sc6?=
 =?us-ascii?Q?BnqHAfgLtRGeI+DNGNY3SArCmHLKMYRvMNRx1kmW+Ndc5+3x5er4teJpshzb?=
 =?us-ascii?Q?qoyoE4y3trlkjPcVz6j2cPNpRzpyVAQA0uSOLuyumaoJyfD4JHSjfB/cEky0?=
 =?us-ascii?Q?T1gdWm39ZFfD8xrn2irTizTqlUHBOPnc5ojPM7dgZHVKRB/ykWRhjxLKmasp?=
 =?us-ascii?Q?y6MW0IaDzePGzykCzjpdVPouQnOTO76ij2fS6hTc8n0/7v3N/Etsir/D7O5e?=
 =?us-ascii?Q?6GVzgcyLNal9d390xp1dZHKnf+6AQWRwnmBO9FhsXMy3f7ewyIDWMZaaNIsr?=
 =?us-ascii?Q?AWyG5IcRtAPBC9DG3CRONle6jNSxZieohTnRz7PAPphBCUecAbelFLGqsBi2?=
 =?us-ascii?Q?xv8A4mieB1zKhWaqDbD+dCE9gdJ7uwyGTfr4W154I/MYg/kPWGgu3X2vbZ0l?=
 =?us-ascii?Q?CjQaRXh4L/YQOhsGI0YdKXuzcyu+QC8/Y67DQBTxhvkIsnEdabh9h5kuaQo2?=
 =?us-ascii?Q?cZdRh4m6kdqLhAaE3b6XMyT6U8IL3BvibfH4zxItEBf7LHa6wxTlDRDpDNxm?=
 =?us-ascii?Q?0+ooReDSRFma1UVdim0IVLRnrXvPmV+8AGbA2p/04krXzEyvZ2ojBxfBpM1p?=
 =?us-ascii?Q?8hF54Rh+mNLTxIRIquEG+lKt3Qwx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JHVTfa45GUv4NfrYdVD2hVXRir/P9Ky20+fSn8RfSbbF7946ZmP5wiq0Gtw4?=
 =?us-ascii?Q?SdrQwuzCSTbgLtBCLwtaMrud7SO8KCw+5IxX1f0bH0GmEp84fiQ8r4syW8uS?=
 =?us-ascii?Q?k8k5MRzeuOBPGbPAor3IL4lnJGEzt96RK3Sb9CQoEy+v/1/HP8CqhJTf3wG6?=
 =?us-ascii?Q?aAS1BQVMI7m/bz5FQgn2g/kZbK4mduSBWBmgkapDQUCdj4iAt3yo2EB9iqRg?=
 =?us-ascii?Q?9Fvzc/EeSHA6ljMss8JX+E8AfqZ2AMhPgjV1DUizdeew91uGAigMzH2F6Q19?=
 =?us-ascii?Q?LKafYPmZYtbW1cwwa1kgU+ICm4jkA0C+qgU1TiYwe/OluMmP30RRGartmiW9?=
 =?us-ascii?Q?gtYyMfYDMLDUzkxk+rEiLFF/815tgdLxPMCPZFEA9/tw2YiEE+dmt3QYRHiN?=
 =?us-ascii?Q?eLwbH8s7MYmu8p4B5eZSjtPuivIgatczePJQRrsPwkjgWRThcCAGnztt//Yo?=
 =?us-ascii?Q?8uXhtvnDcjMtJ+vX759vQrOLJidod+Jp0mkzFVulxxFf3HWPxIJonJdMJgNk?=
 =?us-ascii?Q?jAXIDFSLicX791Dl+oN51QjbCGmFs4MHftBDoft7zH81hlNEys/SV5IY+jSP?=
 =?us-ascii?Q?3x7j7ZvsqeWA4AenTzuu4odXWP5rCeCeSMptycJWwuP5Le/RPs0ZbxfH8ZGa?=
 =?us-ascii?Q?DGW+q+ozt+0RviaxF/GfbyRG1ZTl4LZU0fS/PxXbXwXb1bpkTr+G/oCkD1zK?=
 =?us-ascii?Q?6gCC2+2C3KJbeT9cwI6jm1uDa42VsF2VjcVjUksgyI5EQqa83MScIziLtsS9?=
 =?us-ascii?Q?6WDPt3e2Jb831PUrqvluzm8/HMRKSEiDmbqftIT6/1KuJQxSbATTAPcaQKNG?=
 =?us-ascii?Q?hGKkFTTPNa9NT4NDarxnykUNyP9AkwDBvYODr1ptaZPg42lVO0mgwtOC7p7e?=
 =?us-ascii?Q?Uq+Yi+vglDWXJXqCTno/ZrGNAw+9XzkiZG8iM3m1tncogjiMUBD5CCDbUUJy?=
 =?us-ascii?Q?PXa4mH0CNkb5eRDCy8YRaG1Xn49M7HZvY4ezOFQ0Cj2NTZ7mdFm2MO6pcEzy?=
 =?us-ascii?Q?5YkQN3otH3dEkjNxyLNImyxn9/kn7wrhXGt7JIgXiFgXqSpQK3Xg/kQran4w?=
 =?us-ascii?Q?5tOTSahqJFCW463NG7wGfCj3ZcE2V4V3Fd5DosRRd1L+yL+kjo5PfKsTayKm?=
 =?us-ascii?Q?aBpBK/9S3Hw3LqMsbRHry1lg7LPpWQAvSriuhUBW/b+bfngsRyLOsIk5PRdw?=
 =?us-ascii?Q?HDXNs0+3cFWP2cW+19I9HoCMeojptbtISTTcaZQ6MxPR2rkCcHw9PQCpJnau?=
 =?us-ascii?Q?drwuzcRddCML3jxXs42rJZHVCypmrh9oBKt6Y2W2mDU7Eu3uv6j5ew/uSVB8?=
 =?us-ascii?Q?IQIU0cbaRlGWwnXeP7mpHsMIJk3V9GrNs+lBEKEfv+b0YGyxBPIxcCbUdWfI?=
 =?us-ascii?Q?/6ZPnoJocSPdNXxEcAYiwaIqVc9Oho6vk+jo7mOa5baST3Vc9OhthhdK4qBG?=
 =?us-ascii?Q?iEofS3766QPzOWfmV2Muhtn0LcrRJuxsvniHi8tJpwx7jvb89YHH9BmcTJHr?=
 =?us-ascii?Q?287vW/Kj3ClCBUl01T42brJtpkxjS4uu0CXuRwZotCmDbAPbkRb3/0DYZ9Z0?=
 =?us-ascii?Q?ng0MQvJFt1ILjm8Gp55v/LrYVqLlC9f/qdk6IRaM+hbs2m9qBz9Kvk4U6QVW?=
 =?us-ascii?Q?0Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f0273b-8aa4-4705-703d-08dd75c9492a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 11:42:33.4652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e7nczjaO3msFu6e5NkWV+vzU/RzmQ8FCHoPTtFwPg+7NewwQ1ABjUb7OTQheeQRyrAOzHu/G4QFcFFcR4Bnw/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8853
X-OriginatorOrg: intel.com

On Mon, Apr 07, 2025 at 01:20:05PM +0200, Przemek Kitszel wrote:
> Use Device Serial Number instead of PCI bus/device/function for
> index of struct ice_adapter.
> Functions on the same physical device should point to the very same
> ice_adapter instance.
> 
> This is not only simplification, but also fixes things up when PF
> is passed to VM (and thus has a random BDF).
> 
> Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Suggested-by: Jiri Pirko <jiri@resnulli.us>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> CC: Karol Kolacinski <karol.kolacinski@intel.com>
> CC: Grzegorz Nitka <grzegorz.nitka@intel.com>
> CC: Michal Schmidt <mschmidt@redhat.com>
> CC: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> 
> v2:
>  - target to -net (Jiri)

Missing "Fixes" tag? (After retargetting to -net).

Thanks,
Michal

