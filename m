Return-Path: <netdev+bounces-238911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C22BC60EEB
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 03:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 867F924513
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 02:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06ED1F09A5;
	Sun, 16 Nov 2025 02:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mivcUT2W"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372E01D5CC9;
	Sun, 16 Nov 2025 02:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763258863; cv=fail; b=N5zjlTeiu3E7ts7E7Mbxz/VLnA4m87V73528l3wppEdWcRcH/4W/mNkj0S/MhQwuYtJNWaQ/VEkNUKysWo18DT6uhQTemtLWfA5v5Ms4VkPHSCrL65FfFB6siBV7YIOlCkzB5A4u6xWlMtB1Jqh824zFh7jC9QoKcwR+4SGpWrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763258863; c=relaxed/simple;
	bh=0G5JZhLgtpQHoomL1+WURPMQ73BlgFE5NjymxKkDvmk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=asrY7d66b/zkDt8f2S838ELh2W38hfgZ25TJAqXeKn7LZGRxCZYXMOjfNZmHZ8vLCfDw+tE9Edj/ycKFY33VO4o6ADM0P9+KMdbWVYgombbefVNlYMgFcesUHP6+qKe3QwvWOsyAtaf3hfXny8whpRsm34SBmLadBwTB3bMIaAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mivcUT2W; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763258862; x=1794794862;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0G5JZhLgtpQHoomL1+WURPMQ73BlgFE5NjymxKkDvmk=;
  b=mivcUT2Wb5KAaMjENIWtzJrIzlOEvCRrA3YRCTnuxGwhOEPkfx9HKiPD
   R9ytzMhTIBprywR3FhsmGDEgs0drq8d4K6VYAWSrAjkP4UC/M0oD1ilmJ
   fGuXcp2rGVRnwcwl1kQxDSoK9u7fx34usOd859oarJJPsz6AZZKLhMMYj
   tcacVzpzHH6AVa8EeBMm3LaLa1Z3x5d56Z8/DkKvgTSt4R3HDIq1iuLOv
   hSr+/IYOGNHWMhpavLcODihTdjRMcOBP2JwfE/qhTPE1NI9TxFIoQF3JQ
   INhO6j9CU3E+TOks0h0LcWGXsMDiBNG7UmtUYJB2M3w+f5BVfPPf44iW3
   w==;
X-CSE-ConnectionGUID: jrLAYDYUSn60IplB206c7w==
X-CSE-MsgGUID: HUvLs6zNRCqSwaiWBv0jbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11614"; a="75625253"
X-IronPort-AV: E=Sophos;i="6.19,308,1754982000"; 
   d="scan'208";a="75625253"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2025 18:07:41 -0800
X-CSE-ConnectionGUID: Ng4DJHbDSLC/ZZz1ZrXUCg==
X-CSE-MsgGUID: A7jqg/MMR2qPIWgLb6jYPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,308,1754982000"; 
   d="scan'208";a="189943918"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2025 18:07:40 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sat, 15 Nov 2025 18:07:39 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sat, 15 Nov 2025 18:07:39 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.55) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sat, 15 Nov 2025 18:07:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZFN3e6TiDdsNJKeIu0sReMWpVqdC7qTCQsbgMJ1h+1GiohSJmDPAJhTgxl7017oUnvA5u2c6QYxBSZ1HHyudBQFylhyRgVEY6bNggkcSxfoqjH1nMYtC4fef2mSkJwy9A1w1mWuzbvtAijiypX7Vx6Rl0hHpBoMrXDJ2kxbAolilzQp6fAv3szC9JEZOUM7FF2UZlss9zpwrpeHMEZaC9fJogeqYc9lM/I70SXB9XGo7FRW7w9LkMXqwiIdaXXLOCxkl+GPoZmgUgvQUyis+fsiFyN4qiOG/5SzLpYw5gIMscdkVnGyunTJ7OOKaIkJqX4TaVN2XuLc1SqD2HxFW0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6e8SEvrana9SM5FmRBy0RSJ5dAfBT+vmBNYBH5V5Avs=;
 b=l7jhWKWIbqamzpPh4VRiWtRTMNucGMpRXeYjd/hVIotG2kHNGM+G/j6t7mZjuOAaDhwVoFK3AWi3RJThgdJC4h60FZmK12EmBCzYhtSpzUfj8/tAUeH/KnnXqihbIztW5Vhi7WQEVH4Aw9Hd1qIxuqOe6PgaLh3nrh91/xCkBz8EnZrfdNBBEAHuajvMmWiEg13WSUFWd2mduuloMUJAOEGmWoYqF6xP9qblXVDhWThtXtpyJvldM52keNzLYIAfJIX/uODzwScyTsZChUJrIqH0JHkGm6GRZVcdIk0HUzEb3vjvll8G2hqD7gBeUnQjN2bKCRbZqxYVJFw5AWjN6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM6PR11MB4531.namprd11.prod.outlook.com (2603:10b6:5:2a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Sun, 16 Nov
 2025 02:07:34 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%6]) with mapi id 15.20.9320.018; Sun, 16 Nov 2025
 02:07:34 +0000
Date: Sat, 15 Nov 2025 18:07:24 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Fan Ni <fan.ni@samsung.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v20 06/22] cxl: Move pci generic code
Message-ID: <aRkx3OhRHQrCEhow@aschofie-mobl2.lan>
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
 <20251110153657.2706192-7-alejandro.lucero-palau@amd.com>
 <aRZ25zHGGDyhqUlS@aschofie-mobl2.lan>
 <c8efb22b-57c7-4db5-8986-72b1b2cf605b@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c8efb22b-57c7-4db5-8986-72b1b2cf605b@amd.com>
X-ClientProxiedBy: SJ0PR13CA0094.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::9) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM6PR11MB4531:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f2bd07e-4b22-41aa-1fe4-08de24b4e817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e5qYs98bIDJUVV7cSAYtf5CULekoyDYRyLLhc/Ui4maby+xX0zm1Tr+IAOpW?=
 =?us-ascii?Q?oCJUBYjUTNj2t6uJeakMfKFjMK7WLpEKkGs5NUz2PR+bob+uwHOIA24qG4rk?=
 =?us-ascii?Q?No7qXbI68cwZVlRVvOi7pFw9Onb2uhSHXKVbnTJfS/K3SCuoh5PYcS9WIIbw?=
 =?us-ascii?Q?y7823MDYfce7dm95FG7GPK1UGsU4usTMpu4nH3+RCY6K1mvriKyHzomTKQvW?=
 =?us-ascii?Q?d6WqXlNdU8YBasrhTy0nbUgi0f1oQa6UilUTt8QvTPh66zpRyvafQ7pyMw51?=
 =?us-ascii?Q?IIdV8B3PgJjttF/j8cmSRLUZsSPeuSEQTpx/ax/s1e+vIUTEVagTb3ZQjIav?=
 =?us-ascii?Q?1RDStLjqM+EzJtCfK82Mryi6gVdSAZ6f2OkpcLPHx+euRIpE7EUl7IpuJdgS?=
 =?us-ascii?Q?H2qsQoWiXfRE+oD7D1AAvAmOsRePD1cQxgh3fcUwJFryLBL6lei9LS1uUTJc?=
 =?us-ascii?Q?vNp0xKKGYfkuXBZIzetYQofkxxFWLH9pPP4e3QBVi3dsOotFYqSGDyDz2e7s?=
 =?us-ascii?Q?4JzRGiaKaiLsZDyTQ/837jmrui4nPVeQ9Yti7HaXiuSCB79gjDu/rgB5I7pV?=
 =?us-ascii?Q?psETH1B6RLOW/iLqhgdyUlaw33KV9dV+JoNIA6tfDgT997jPHbK0RUyUP4hI?=
 =?us-ascii?Q?e7qfn9laMHbMnz0ZAqWmZ5QvAsvOhzxWAHO/hBRyRRueTdB7bJtV00qKBF5w?=
 =?us-ascii?Q?3vpVJU+Dj8LHX38KXHWbN96Z/C8tq/R1W6vjMXkzI1WUOyIvPs64V6oIH4ja?=
 =?us-ascii?Q?omCW66hkuGPwao1jBzAUqbN0e3n3UryFel4Casa7mXmUVKG1U9+Q9s64temj?=
 =?us-ascii?Q?I3+wVHopQRtdmhCFG5fAYcdAZbr6nkOVjvjYCy0yTHDAhTTguVHZDM2g7ZPg?=
 =?us-ascii?Q?S86VzMJ9UAfWXDVh+IoXECv+KXk4pYb9Pa3Rgu+HPtG79tl80ImGxMtgpksi?=
 =?us-ascii?Q?oFdaaa6nuBIkzby7zlNmw9SDZ1ZBd/EdZW4aOpfNtRuHW2hbWkjpSx3W1SQp?=
 =?us-ascii?Q?rwAcfFFnrmGLLTBHLbsoT54sJ5TrnOWM3/VQNOI1L1X3aRjZY+rNrRoMsc5a?=
 =?us-ascii?Q?znC1t/TQX1X0e4FpdoUOxB+UPuAUknCKTcxJ7dHUXdIAV2mVTUXNOOxMmtlv?=
 =?us-ascii?Q?53FbIcbri8Z3i/nGYYtZw9dwK4SS/B3IhK3P0QDiGR36ArsDqUl8OVv2JjzS?=
 =?us-ascii?Q?OzRdxX0l1X51508dn0dEe+teZndf8AERTiyK7iY6FHZ0iugsWsVAke+bOYpx?=
 =?us-ascii?Q?1FNWk7J0MdNzCKxHYxay1HtcsT59It2we9Z40qhYWE/iwxAMoYapZvf4qzHM?=
 =?us-ascii?Q?5YZLvHOsfsJRPe5lUFDgvCSFSC5nOVQ9dTtzE0+41p+Ox5bE6NO5x85/x5CG?=
 =?us-ascii?Q?3ljjTrW3M7p3vkEBjE3+SFB+x+UibR8C1vFzqhD41qaDRmhNgHnNDCdTchA1?=
 =?us-ascii?Q?+oXizw0ApwEnGM4d//WLSNnN9y/9U5SV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mRWtSAvuQ7eeWfasIICA6qmDx1fRP1gGUMQh4eyp6K15+2sFGpCiEitsL2Dj?=
 =?us-ascii?Q?A/lM4+POR6/hb2D3y4YqwKELFNFVkYZd8WeQHGvwCa99Kstrlg6lRtqqX4Z9?=
 =?us-ascii?Q?XhNiHUhW40vLbtAqHnYSZrq9gRSR883X3GvqsdqPKH0p5E/FKatupVhBHxmd?=
 =?us-ascii?Q?gQ8C0hsX1PmYOxgzwdaHgREoYcHibLgq1u79qeTjHjorcUOE64L4gvGdLu/z?=
 =?us-ascii?Q?nN/20H4yOx1FVC4BgrLUNu1MCMRG4hublSk14jQsfKkhOseMCVmBrqt+Tupu?=
 =?us-ascii?Q?syCl+VP+TJdradCoB1hPqVHwYYOKwjW3cockPjmuxwgqfcSmvFvy2lVpSHCy?=
 =?us-ascii?Q?kOo/1UWZsiD16Z8ENv/XP2RmR6GdOH3fFY5jGZOU05Sl9MRJz5OgmCcgV2yT?=
 =?us-ascii?Q?Ia3LeYbS9/PEjiE9Ivarq+ncTd1XjU0NuWRSW/BWn850oFKm55BEdlo/ajI5?=
 =?us-ascii?Q?I9Z3j65oArX04MJnhGq+aTw+3PdilFlCJlkcHnswO/SbkcMcLqAsh7H/FXaT?=
 =?us-ascii?Q?60BJa76OPw7GMVysL/gOlUR1JVCUtg+xOFsgmSYoO8V20rY/e1pWf81dtr1W?=
 =?us-ascii?Q?HFeELw8xDYmQAvc6BGy184w+DVWF8t7h1WX6foIAhhEzuEZHDiDeum6xFO3j?=
 =?us-ascii?Q?4ZNLDKNC2bj1tY+dSUBXNPOy1G100fjyThkMV/Qg922cy+2AOYuQTlPb/8jW?=
 =?us-ascii?Q?BV05N5BiUnsQF9M/zwIj+USJY4RDhYrTI1IfgOWIzLdZMJTb2gerC3OQN3XL?=
 =?us-ascii?Q?EpV9E2W0EM8b3G/Cvn29fEH8hZW0MDQmKvI+MF8J/u/KgTjc1eqjhs0umgiE?=
 =?us-ascii?Q?lHcsJkmy9SDXlK+K5cBnXXDHnjoGrCa6gw6Ay4vdCJBB1Fro/C4C/85z7XoD?=
 =?us-ascii?Q?oKqgrkViNeebVrZjtqKCmQtaBib79QKz57cQIFjlhMfOOvkDAjTqqeM2+3ME?=
 =?us-ascii?Q?czRTn3PXdpYo0+MomxEncHKSbrqLN1AaLWUnFGjIT50jKjk6l1fjDOh1l1kj?=
 =?us-ascii?Q?dMWKCHmojjMDQ6Ln+sVrQR9ZZRc6ftmv7RFlKgusjf7p58Or4zSGq147wON4?=
 =?us-ascii?Q?Fui6zz6rAXWKjLOgIIfL1O6/ThZNsEGqHUX94gcKV7zKAfa4t4/sdMNtv0bs?=
 =?us-ascii?Q?b0DIJ//hAI+G1PfK4uuqNpsrFUGXCqIgtMQhQnEUwL+6ZkTzknyfY6bsaCUq?=
 =?us-ascii?Q?+WtqGd1uxalb5wLbiZWEsy4cXKEPzMMrr79hbeJGA4noYc4XiB1lWV3WeP24?=
 =?us-ascii?Q?D78AxdWFJBLTWYa7APhdNkfESELsgP9fXdyWxsz742dayV6V3lobRueMSheI?=
 =?us-ascii?Q?rTeexqaaak+P0rAdkKw1VL/MdABvHU0Erlz04RmPsD8pGdG01SJowkLRowRU?=
 =?us-ascii?Q?b0gpAuqqlj9rdzii2JwdHWt6Dpz0zuCaP1i5tVpnrL9CVbVBmZqU8b6tUoBR?=
 =?us-ascii?Q?Yyq91DgmHxO8FaEcaIPz+ksOytC4V63VsouRyeyYn8VWUxir6sn39scyE0z0?=
 =?us-ascii?Q?IGWlbnLDZrDy7rAsxxKgFscIdYMwaI10vuBVS5YQsjAR+eE74NHbTKTJG0nc?=
 =?us-ascii?Q?kCK8XQHhna40n6GNcQ7qE1mEVGbxLxRVtfwvgnpDuN8nu1hWKLy1IoJ7m3n9?=
 =?us-ascii?Q?0w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f2bd07e-4b22-41aa-1fe4-08de24b4e817
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2025 02:07:34.1320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hmccbcGIbm5upFdPDQ71WTg24mZgUY0pIJcEj+I/KMmC04n6e02NtgQWOgP7hpLopCTloESWmpfaxrAhuq8t3tIDD+gH+IRhUWT//RaIGB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4531
X-OriginatorOrg: intel.com

On Sat, Nov 15, 2025 at 08:16:29AM +0000, Alejandro Lucero Palau wrote:
> 
> On 11/14/25 00:25, Alison Schofield wrote:
> > On Mon, Nov 10, 2025 at 03:36:41PM +0000, alejandro.lucero-palau@amd.com wrote:
> > > From: Alejandro Lucero <alucerop@amd.com>
> > > 
> > > Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
> > > meanwhile cxl/pci.c implements the functionality for a Type3 device
> > > initialization.
> > Hi Alejandro,
> > 
> > I'v been looking at Terry's set and the cxl-test build circular
> > dependencies. I think this patch may be 'stale', at least in
> > the comments, maybe in the wrapped function it removes.
> 
> 
> Hi Allison,
> 
> 
> I think you are right regarding the comments. I did not update them after
> Terry's changes.
> 

Here's how it looks to me, and looks odd :

Terry moves the entirety of cxl/pci.c into a new file
cxl/core/pci_drv.c

Then you move some of the things from that new cxl/core/pci_drv.c
into the existing cxl/core/pci.c.

My question is, for these pieces that belong in cxl/core/pci.c might
it be better for Terry just to move them there in the first place?

> 
> > > Move helper functions from cxl/pci.c to cxl/core/pci.c in order to be
> > > exported and shared with CXL Type2 device initialization.
> > Terry moves the whole file cxl/pci.c to cxl/core/pci_drv.c.
> > That is reflected in what you actually do below, but not in this
> > comment.
> > 
> > > Fix cxl mock tests affected by the code move, deleting a function which
> > > indeed was not being used since commit 733b57f262b0("cxl/pci: Early
> > > setup RCH dport component registers from RCRB").
> > This I'm having trouble figuring out. I see __wrap_cxl_rcd_component_reg_phys()
> > deleted below. Why is that OK? The func it wraps is still in use below, ie it's
> > one you move from core/pci_drv.c to core/pci.c.
> 
> 
> I think the comment refers to usage inside the tests. Are you having
> problems or seeing any problem with this removal?

You may have seen, Terry's set had build problems around that function.
If you see it is no longer needed, can you spin that off and let's do
that clean up separately. Correct me if it is indeed tied to this
patch or patchset. I don't set it.

Thanks!

> 
> 
> Thank you.
> 
> 
> 
> 
> > 
> > For my benefit, what is the intended difference between what will be
> > in core/pci.c and core/pci_drv.c ?
> > 
> > --Alison
> > 
> > > Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> > > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > > Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> > > Reviewed-by: Fan Ni <fan.ni@samsung.com>
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > > ---
> > >   drivers/cxl/core/core.h       |  3 ++
> > >   drivers/cxl/core/pci.c        | 62 +++++++++++++++++++++++++++++++
> > >   drivers/cxl/core/pci_drv.c    | 70 -----------------------------------
> > >   drivers/cxl/core/regs.c       |  1 -
> > >   drivers/cxl/cxl.h             |  2 -
> > >   drivers/cxl/cxlpci.h          | 13 +++++++
> > >   tools/testing/cxl/Kbuild      |  1 -
> > >   tools/testing/cxl/test/mock.c | 17 ---------
> > >   8 files changed, 78 insertions(+), 91 deletions(-)
> > > 
> > > diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> > > index a7a0838c8f23..2b2d3af0b5ec 100644
> > > --- a/drivers/cxl/core/core.h
> > > +++ b/drivers/cxl/core/core.h
> > > @@ -232,4 +232,7 @@ static inline bool cxl_pci_drv_bound(struct pci_dev *pdev) { return false; };
> > >   static inline int cxl_pci_driver_init(void) { return 0; }
> > >   static inline void cxl_pci_driver_exit(void) { }
> > >   #endif
> > > +
> > > +resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
> > > +					   struct cxl_dport *dport);
> > >   #endif /* __CXL_CORE_H__ */
> > > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > > index a66f7a84b5c8..566d57ba0579 100644
> > > --- a/drivers/cxl/core/pci.c
> > > +++ b/drivers/cxl/core/pci.c
> > > @@ -775,6 +775,68 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
> > >   }
> > >   EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, "CXL");
> > > +static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
> > > +				  struct cxl_register_map *map,
> > > +				  struct cxl_dport *dport)
> > > +{
> > > +	resource_size_t component_reg_phys;
> > > +
> > > +	*map = (struct cxl_register_map) {
> > > +		.host = &pdev->dev,
> > > +		.resource = CXL_RESOURCE_NONE,
> > > +	};
> > > +
> > > +	struct cxl_port *port __free(put_cxl_port) =
> > > +		cxl_pci_find_port(pdev, &dport);
> > > +	if (!port)
> > > +		return -EPROBE_DEFER;
> > > +
> > > +	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
> > > +	if (component_reg_phys == CXL_RESOURCE_NONE)
> > > +		return -ENXIO;
> > > +
> > > +	map->resource = component_reg_phys;
> > > +	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
> > > +	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> > > +			      struct cxl_register_map *map)
> > > +{
> > > +	int rc;
> > > +
> > > +	rc = cxl_find_regblock(pdev, type, map);
> > > +
> > > +	/*
> > > +	 * If the Register Locator DVSEC does not exist, check if it
> > > +	 * is an RCH and try to extract the Component Registers from
> > > +	 * an RCRB.
> > > +	 */
> > > +	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
> > > +		struct cxl_dport *dport;
> > > +		struct cxl_port *port __free(put_cxl_port) =
> > > +			cxl_pci_find_port(pdev, &dport);
> > > +		if (!port)
> > > +			return -EPROBE_DEFER;
> > > +
> > > +		rc = cxl_rcrb_get_comp_regs(pdev, map, dport);
> > > +		if (rc)
> > > +			return rc;
> > > +
> > > +		rc = cxl_dport_map_rcd_linkcap(pdev, dport);
> > > +		if (rc)
> > > +			return rc;
> > > +
> > > +	} else if (rc) {
> > > +		return rc;
> > > +	}
> > > +
> > > +	return cxl_setup_regs(map);
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
> > > +
> > >   int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
> > >   {
> > >   	int speed, bw;
> > > diff --git a/drivers/cxl/core/pci_drv.c b/drivers/cxl/core/pci_drv.c
> > > index 18ed819d847d..a35e746e6303 100644
> > > --- a/drivers/cxl/core/pci_drv.c
> > > +++ b/drivers/cxl/core/pci_drv.c
> > > @@ -467,76 +467,6 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
> > >   	return 0;
> > >   }
> > > -/*
> > > - * Assume that any RCIEP that emits the CXL memory expander class code
> > > - * is an RCD
> > > - */
> > > -static bool is_cxl_restricted(struct pci_dev *pdev)
> > > -{
> > > -	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
> > > -}
> > > -
> > > -static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
> > > -				  struct cxl_register_map *map,
> > > -				  struct cxl_dport *dport)
> > > -{
> > > -	resource_size_t component_reg_phys;
> > > -
> > > -	*map = (struct cxl_register_map) {
> > > -		.host = &pdev->dev,
> > > -		.resource = CXL_RESOURCE_NONE,
> > > -	};
> > > -
> > > -	struct cxl_port *port __free(put_cxl_port) =
> > > -		cxl_pci_find_port(pdev, &dport);
> > > -	if (!port)
> > > -		return -EPROBE_DEFER;
> > > -
> > > -	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
> > > -	if (component_reg_phys == CXL_RESOURCE_NONE)
> > > -		return -ENXIO;
> > > -
> > > -	map->resource = component_reg_phys;
> > > -	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
> > > -	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
> > > -
> > > -	return 0;
> > > -}
> > > -
> > > -static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> > > -			      struct cxl_register_map *map)
> > > -{
> > > -	int rc;
> > > -
> > > -	rc = cxl_find_regblock(pdev, type, map);
> > > -
> > > -	/*
> > > -	 * If the Register Locator DVSEC does not exist, check if it
> > > -	 * is an RCH and try to extract the Component Registers from
> > > -	 * an RCRB.
> > > -	 */
> > > -	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
> > > -		struct cxl_dport *dport;
> > > -		struct cxl_port *port __free(put_cxl_port) =
> > > -			cxl_pci_find_port(pdev, &dport);
> > > -		if (!port)
> > > -			return -EPROBE_DEFER;
> > > -
> > > -		rc = cxl_rcrb_get_comp_regs(pdev, map, dport);
> > > -		if (rc)
> > > -			return rc;
> > > -
> > > -		rc = cxl_dport_map_rcd_linkcap(pdev, dport);
> > > -		if (rc)
> > > -			return rc;
> > > -
> > > -	} else if (rc) {
> > > -		return rc;
> > > -	}
> > > -
> > > -	return cxl_setup_regs(map);
> > > -}
> > > -
> > >   static int cxl_pci_ras_unmask(struct pci_dev *pdev)
> > >   {
> > >   	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> > > diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> > > index fb70ffbba72d..fc7fbd4f39d2 100644
> > > --- a/drivers/cxl/core/regs.c
> > > +++ b/drivers/cxl/core/regs.c
> > > @@ -641,4 +641,3 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
> > >   		return CXL_RESOURCE_NONE;
> > >   	return __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
> > >   }
> > > -EXPORT_SYMBOL_NS_GPL(cxl_rcd_component_reg_phys, "CXL");
> > > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > > index 1517250b0ec2..536c9d99e0e6 100644
> > > --- a/drivers/cxl/cxl.h
> > > +++ b/drivers/cxl/cxl.h
> > > @@ -222,8 +222,6 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> > >   		      struct cxl_register_map *map);
> > >   int cxl_setup_regs(struct cxl_register_map *map);
> > >   struct cxl_dport;
> > > -resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
> > > -					   struct cxl_dport *dport);
> > >   int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
> > >   #define CXL_RESOURCE_NONE ((resource_size_t) -1)
> > > diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> > > index 3526e6d75f79..24aba9ff6d2e 100644
> > > --- a/drivers/cxl/cxlpci.h
> > > +++ b/drivers/cxl/cxlpci.h
> > > @@ -74,6 +74,17 @@ static inline bool cxl_pci_flit_256(struct pci_dev *pdev)
> > >   	return lnksta2 & PCI_EXP_LNKSTA2_FLIT;
> > >   }
> > > +/*
> > > + * Assume that the caller has already validated that @pdev has CXL
> > > + * capabilities, any RCiEP with CXL capabilities is treated as a
> > > + * Restricted CXL Device (RCD) and finds upstream port and endpoint
> > > + * registers in a Root Complex Register Block (RCRB).
> > > + */
> > > +static inline bool is_cxl_restricted(struct pci_dev *pdev)
> > > +{
> > > +	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
> > > +}
> > > +
> > >   int devm_cxl_port_enumerate_dports(struct cxl_port *port);
> > >   struct cxl_dev_state;
> > >   void read_cdat_data(struct cxl_port *port);
> > > @@ -89,4 +100,6 @@ static inline void cxl_uport_init_ras_reporting(struct cxl_port *port,
> > >   						struct device *host) { }
> > >   #endif
> > > +int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> > > +		       struct cxl_register_map *map);
> > >   #endif /* __CXL_PCI_H__ */
> > > diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> > > index d8b8272ef87b..d422c81cefa3 100644
> > > --- a/tools/testing/cxl/Kbuild
> > > +++ b/tools/testing/cxl/Kbuild
> > > @@ -7,7 +7,6 @@ ldflags-y += --wrap=nvdimm_bus_register
> > >   ldflags-y += --wrap=devm_cxl_port_enumerate_dports
> > >   ldflags-y += --wrap=cxl_await_media_ready
> > >   ldflags-y += --wrap=devm_cxl_add_rch_dport
> > > -ldflags-y += --wrap=cxl_rcd_component_reg_phys
> > >   ldflags-y += --wrap=cxl_endpoint_parse_cdat
> > >   ldflags-y += --wrap=cxl_dport_init_ras_reporting
> > >   ldflags-y += --wrap=devm_cxl_endpoint_decoders_setup
> > > diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
> > > index 995269a75cbd..92fd5c69bef3 100644
> > > --- a/tools/testing/cxl/test/mock.c
> > > +++ b/tools/testing/cxl/test/mock.c
> > > @@ -226,23 +226,6 @@ struct cxl_dport *__wrap_devm_cxl_add_rch_dport(struct cxl_port *port,
> > >   }
> > >   EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_add_rch_dport, "CXL");
> > > -resource_size_t __wrap_cxl_rcd_component_reg_phys(struct device *dev,
> > > -						  struct cxl_dport *dport)
> > > -{
> > > -	int index;
> > > -	resource_size_t component_reg_phys;
> > > -	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
> > > -
> > > -	if (ops && ops->is_mock_port(dev))
> > > -		component_reg_phys = CXL_RESOURCE_NONE;
> > > -	else
> > > -		component_reg_phys = cxl_rcd_component_reg_phys(dev, dport);
> > > -	put_cxl_mock_ops(index);
> > > -
> > > -	return component_reg_phys;
> > > -}
> > > -EXPORT_SYMBOL_NS_GPL(__wrap_cxl_rcd_component_reg_phys, "CXL");
> > > -
> > >   void __wrap_cxl_endpoint_parse_cdat(struct cxl_port *port)
> > >   {
> > >   	int index;
> > > -- 
> > > 2.34.1
> > > 

