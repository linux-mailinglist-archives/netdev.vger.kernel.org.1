Return-Path: <netdev+bounces-192416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A015EABFCE5
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 20:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E526D9E6DE2
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 18:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA66289820;
	Wed, 21 May 2025 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IjhV8EbI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B340A22D4C8;
	Wed, 21 May 2025 18:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747852503; cv=fail; b=uG6GSLUsbYc84aF/voYWvxx+xTkZ60VRZXEGtOeNllnDrrQ8M5vHq6Lye1Z/8bWe9BrZBHFXc8/fq9Udd5Io2WqjC0kSMO1QQA8Y3uWirBDnqzGFeaR8Ge+5WnzI+rzft6hhU1gxzG0QZ1+HRvkbMu8Jy8uJgfBW9/+HH2o7F6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747852503; c=relaxed/simple;
	bh=EOwluo44ZfQZiAPGvsiOPjgfu+HT6lOSP7d2NfLGFhs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OYBdiWwo0pAcMmK4XiUelhXWec2Fjc9Cf3qqa0HRtHzzkWWMeVQPCsl94k3beh0ie76zLPSiAOREWB9tVJJXlJTF2tbf0JWsPX2hPbGkThjwv70fxxu0zkzMM2Nj9yocNhm45UT5yVR0vHfa7FxmOaH7mAB31BKvigqCoS7CK+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IjhV8EbI; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747852501; x=1779388501;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EOwluo44ZfQZiAPGvsiOPjgfu+HT6lOSP7d2NfLGFhs=;
  b=IjhV8EbIlYIEcA7rGeG+uj1p8q2riJF0NN4CKdbKW7A/PO26IyqJqTu9
   5c/HTAH19eo6a7J6Venl7zqCeDywhNNiHCk69QpizWO5YJUooonl1gZkl
   0vv+uhC1htBl/EZQBAZJoi2GlYEnuOFIYayPDUdfriaRldsRsBMDCETgJ
   qQni5iCvAeSM+xlghBdzADRwRcZdG3sm1EGoMrUYlv7lggCWpre9CsFee
   UytoefNYlOg7SRCt+uLj5vFA4w7df3x5Zx7w2ZFeuq7HOQ3s/dQF8OhjC
   I7jzVXn0GrPe1gSK8vPTf2wIoOtJi70F6q2LafdTn7IXEishxUTmfAamM
   Q==;
X-CSE-ConnectionGUID: mrvjfinUSJmSczGbi80gBQ==
X-CSE-MsgGUID: 2wHvWO6ST0myPEIy4KycDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="75246572"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="75246572"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 11:35:00 -0700
X-CSE-ConnectionGUID: gOUB4/5OQG28T6wFKaQaoA==
X-CSE-MsgGUID: d4j07a1zR++ajl6I9cjZwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="171199807"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 11:35:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 11:35:00 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 11:35:00 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 11:34:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/TrVSr/C2GeO3FFcWP8orRXr/EWOugtSoOPd1SHZBsLF1mQ+FKhMQbcAEEPJ8D/Fh+pWFltMyhfyeua/i0SEwsBUCnaKBhL4fWRgZLda445YqQYli8QlPeTziYMskuFYPnBn5Oq8+GPHoMKZWeIxXWQua1ASDIB3l5xB228AOUbAsbdZl79tbaYyC/ihf0tIItosv+ISPRZqW5izdzGzwfEKjfNN4jYZn5Hb18E4dye8XVOZHYaOMXmbyMJddV380MBTXhr7Y0X21mGM8NMGwysbfTzVfw0yYSyGI3rG4k+oxrvsgmPXodmh8d0XXdBayZv3d+msrT6x32JfibOjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYsXxLlqRwfWbk93jZwlqijKTQFr7FsNRlsjYHTgocI=;
 b=q2UH15HVswL58iJiJzA5ih/1A4ip7mbjL1eeWassl/WjWDLtkpZXWzd78HDfFPI8yKLAFt+vSuCnK7xve+QcRSi8v3qQcZ37OCT8z4DjmlgynHd4uUz8kQ6YvENpFz7R1UM+ZDShifwOL1CwYFng4Ud3KR+LJmsrHETlwCm0D9X0a8lYwtb0vQUGHjm7jRBBPHmX8PcNBNuG1kxCRCbUJHTFHLQnnQSPZPJUfKSjTO5DV0k4pOu+dlZNf1xS9yI2ABKhoPetEmffJVR10UplcEoyt8Uoge1+is+KeXGrxFmshYYlNgCotBvXjtqEeVStqqATbi70M/ahgIcQWXDNWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN6PR11MB8193.namprd11.prod.outlook.com (2603:10b6:208:47a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 18:34:58 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 18:34:58 +0000
Date: Wed, 21 May 2025 11:34:54 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Zhi Wang <zhi@nvidia.com>, Edward Cree
	<ecree.xilinx@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"Ben Cheatham" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v16 06/22] sfc: make regs setup with checking and set
 media ready
Message-ID: <682e1ccec6ebf_1626e1009a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-7-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250514132743.523469-7-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: BY3PR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN6PR11MB8193:EE_
X-MS-Office365-Filtering-Correlation-Id: aa5191b9-ed33-43ae-db34-08dd98963034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vWZyCKxn/iUKHUBiRY0wFkOyzDBE8ynyFO43DqjJizV+MLmZqsXOBtmSztza?=
 =?us-ascii?Q?quJi/FMfbqvocxag3H//K1Wn5LR/xQWKGUzmeOHqHU0n3OiO31dqbaIl/lGK?=
 =?us-ascii?Q?za65zXZ2lze8dpwLhYA/4xcj87IKuLgB+dOG5uPIBXXB4gziNKDWtX+9ywSx?=
 =?us-ascii?Q?mJhE1VE71sFK8Ffl4w6XVx5N8WqmEAbd95HwxWU/PW+QxyxGu+GKEvb/p/IZ?=
 =?us-ascii?Q?VgqAA+GCDuPXlH7cV0Z2pIT20B6wxpOyVfLZU/rUrsemXbcQ8eRqgTP6YyL3?=
 =?us-ascii?Q?9tFtVva9HFNBrpcL7fktOYYTkcVW911LfkNAbXkapJnMFJDVYp93ZYudKwoi?=
 =?us-ascii?Q?d4PbtOZ2Gm1fqpMCMXsGYGMo7Zz8rR8DFpKQhkfdjSobIMRBGQxhlwzvvIfm?=
 =?us-ascii?Q?Z1/0gNWtut/NwR6yRb7RJvytKb+G1eYAoPJNOSywKYjTkcwdNLF96RyleUlK?=
 =?us-ascii?Q?3ZOCJF5LjtcGza8MuE6yAYJhYAfVLdLZ/Bvlm7OWzf3GO5K6CQbAoIrhJj8Z?=
 =?us-ascii?Q?KNBxgMW25mq5Mk4d7r/mizLtrwi9+/xcLfrTnAUduBju/KQJzya5jCsCCm22?=
 =?us-ascii?Q?OjMmP9CAFpaUjlaFXBl0QPO4dDvZBswGOJvUsIZqin54X9Olyx2VUQzLAZ75?=
 =?us-ascii?Q?v/MtOaUisCFOklOW8ZkrPnv35I+dYspfmj6N9gwgPDAZBha8od2sHQ2RJmZg?=
 =?us-ascii?Q?kzX/m5aGWRJ8IVvoNgexzyMMEnLEFPqWXiIb8qKKHCDrHeaAn1BanMlQiThI?=
 =?us-ascii?Q?L8zEDihGcOrAbvxbCMmZstgOiBNK2VkW3E+Ici6Q6QrdErSG3ot/kMaainyr?=
 =?us-ascii?Q?UokJnCD3FjDigUvuhZA3gzC9Py3ErlfCC0OahsDoX+am73O2Nl3u9sNlROfK?=
 =?us-ascii?Q?aoGtVHyuF4T7lUDsHp1qJNKkLOKoEhhWi1NiCq5UtKRuKga9MWDTeyxJQ8uA?=
 =?us-ascii?Q?xYjiP+bmgsTfjrPandXRVa+LFFowZaYF+SlY5CUtVhPIfSi+Mm9aQtfFODnI?=
 =?us-ascii?Q?C1wRLzo9sWff51LDeDrjAHyiR3c0DMRZJ+ZF0+JmDtkxTvE9LnPVUyTwaH5o?=
 =?us-ascii?Q?WOmJF3HJe3vo2krWdauNQdTKJNJZzZvXjRHQm8zfZUnMjWZNUE61yU8ruDiA?=
 =?us-ascii?Q?EGs3iinmWqcJJWggaugxZG60IwfDb6ajdGKapnEq6m7Kj+PT7VLLOiaGAAVp?=
 =?us-ascii?Q?LyFRCamXKxpr2m3CYD+1U/bxSJcHCLBuCT5XXozkgg/k9cFAOAioT3BEIlle?=
 =?us-ascii?Q?RwGk0LHtoOUtoiJ5dDYjtg/XZahSZk651LZZtetnTM7CU4k/ZqkByipSWLM/?=
 =?us-ascii?Q?LAMQV+ny9YA+VOoGk7TU/BsmiROjddIjZjO7sH0T3zYIAtpj8Y5EmCrguJ5Q?=
 =?us-ascii?Q?5wOB3VEY0F60VZcE9cKBS9UWoSeewXfq3XFEM9uAfNSH6/jIbi/F7OZuChrf?=
 =?us-ascii?Q?eLnInJcXOBRYfkM9V+xAczKRNwi1iZPBac+SqO54FIyz/PtHQP5tZQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YkITrrjKNNBijZPUpgvXKOuYUrmWva7dwll8OUtXyvecrrH40/oL2VgNtF5P?=
 =?us-ascii?Q?j/jN6zvP0A+sgaouX7C3e1dazPfYx1tlfL/5eHi0OPq7p2FHJhHVcpsNqPFE?=
 =?us-ascii?Q?REpqAk7ELdyPS2gWlCz7nCVmlerniVaEZDPZ3WRgK8LVDrBTiJOIrBcRu1dU?=
 =?us-ascii?Q?JbgpZCwmhCjmzw5JlgvNQK3eZaHb/iryPFXc2AojXBTDXRCi3YPjcQeWOMEP?=
 =?us-ascii?Q?VJekpigyYnnu4NY1j2dVi0lvk4u56xZ9RZguTxkevGj9XhRNHgmKjC7S8k96?=
 =?us-ascii?Q?KMSd/5Ztw0+0G3K9Nco04HxwqpR3nGx90jzn/z3weiuKc9d6n4RyPWFI73II?=
 =?us-ascii?Q?Q0BGI9hxUvDlfOCEYdp/czTfXKXim577pFMCf7slGGfTwwjN2VH9DxIJF3kt?=
 =?us-ascii?Q?nzxQiSPtSr/WRzOefG+L4xAYdF1XRWp//ilHTQfv5ICuS2HZFWfT66uTQe3r?=
 =?us-ascii?Q?YKTcpjE0s/hTS7iZMpX+5Mers6j5zOlczFZsp1sI4WpvT9MdFtEKYfJiSz9o?=
 =?us-ascii?Q?i5U95P+S6emiHnYMgtvH21dEaNj2APJPZDySk7OiklgsrvRQ19yptUe/lrZS?=
 =?us-ascii?Q?z50jlnXB9Yz3SUl39Bjhvy5FJ1lwyB0F2Knpl8AEyimc90e3W7zMgPiyBKtg?=
 =?us-ascii?Q?nSllcUg5RU/DC/jLMnsKbhgTuCIhtFTbFaty4UqF4q/NiO6EbVxcTGK+E1hv?=
 =?us-ascii?Q?7xDw5/X4QY91p9eWBqAQrWpJpmlyBnmk5gA9WC5qtqlS9DwQTWX8Eg1h81SF?=
 =?us-ascii?Q?WAohun5hL9jfsJ3JD+yrOEBZ9b6vC2bpCuEfYAf+uzPwTno3dFCQvcnEFzb4?=
 =?us-ascii?Q?qWNLK0feFvsDHEr2UykLPrCBIEgcVLIRL8TNnL9m1B4zNcIqqUZ62RjGCTI4?=
 =?us-ascii?Q?AnjLPgPsKgGR8tOSJVi+ViLppdG7F0rFS/3QxuIbtqtMVZtFULp3w0FrzkqJ?=
 =?us-ascii?Q?kC6Ii4NMeNMlIOLUKLBVsyUqZQrg5qwlafQmHfSEij6eyO8dgPjhJhECtJtI?=
 =?us-ascii?Q?j6av7uXEz2w3eE6kKLv+PhkpkD2Exz+wOf2cS1VUT72XeV5egOIGrdeJ9JOu?=
 =?us-ascii?Q?6QGVq8K+BZqIiPVEWUELV9qa5OTcWmEEDCfjqyt/t5jMCVWfC+8JV/GmeqMT?=
 =?us-ascii?Q?zeEMOWq/wKlgBXa4nm6JcBqUdUeGkDj10/mXWzjDdaSKkGXO7dPZdgiHNWFw?=
 =?us-ascii?Q?lyAGLzhIop3RSM7s3/wcwHMLaybnzp/yuBS+v26B93OFZyxVq5FbrWRkA07U?=
 =?us-ascii?Q?ZXuYZiE3eGp4snzbQcMYBqU7OotcMfbife+9Ra8Rk2hbUtA0GzkJSynltAv0?=
 =?us-ascii?Q?VndLkCI/IWbjPs4T8Ltf94gUx2pVtTaM7+iR5vGRlkPZmSKYBQWnnY0uvfqK?=
 =?us-ascii?Q?pMZnLWteqTroU50NGGBT/tRziY8DQIo2Yv1exNB7NLw2OqfFTDp10kXUdDsn?=
 =?us-ascii?Q?lecIGCy7nPGNoDyrjSD56XhQZXTjBxGOFr9V/TdDmu8OAUkxyXsf+N5bgWGq?=
 =?us-ascii?Q?Hy9ErGGlerP3YborRPLvECdC8Vk5sgWv1QLWiOh7F4tMUt8qj0mBbjY7+Urj?=
 =?us-ascii?Q?ISqtnosWp9ZBpyaHPvpwjEL7dBMnxVpurvo8ot2mWspGBaH29j8E5LhRzII1?=
 =?us-ascii?Q?9w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5191b9-ed33-43ae-db34-08dd98963034
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 18:34:57.9423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MnFpETB0MkmLgBu8YwcEQGvRYdY6y3l3LTO7C65+wgnG2DLKo2xHCCxCZu18VhMsE01ANKW/Ih6RdBbXrQYYh5huuJiCDINmI07GCoh7AXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8193
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl code for registers discovery and mapping.
> 
> Validate capabilities found based on those registers against expected
> capabilities.
> 
> Set media ready explicitly as there is no means for doing so without
> a mailbox and without the related cxl register, not mandatory for type2.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> Reviewed-by: Zhi Wang <zhi@nvidia.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 753d5b7d49b6..e94af8bf3a79 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -19,10 +19,13 @@
>  
>  int efx_cxl_init(struct efx_probe_data *probe_data)
>  {
> +	DECLARE_BITMAP(expected, CXL_MAX_CAPS) = {};
> +	DECLARE_BITMAP(found, CXL_MAX_CAPS) = {};
>  	struct efx_nic *efx = &probe_data->efx;
>  	struct pci_dev *pci_dev = efx->pci_dev;
>  	struct efx_cxl *cxl;
>  	u16 dvsec;
> +	int rc;
>  
>  	probe_data->cxl_pio_initialised = false;
>  
> @@ -43,6 +46,29 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  	if (!cxl)
>  		return -ENOMEM;
>  
> +	set_bit(CXL_DEV_CAP_HDM, expected);
> +	set_bit(CXL_DEV_CAP_RAS, expected);
> +
> +	rc = cxl_pci_accel_setup_regs(pci_dev, &cxl->cxlds, found);
> +	if (rc) {
> +		pci_err(pci_dev, "CXL accel setup regs failed");
> +		return rc;
> +	}
> +
> +	/*
> +	 * Checking mandatory caps are there as, at least, a subset of those
> +	 * found.
> +	 */
> +	if (cxl_check_caps(pci_dev, expected, found))
> +		return -ENXIO;

This all looks like an obfuscated way of writing:

    cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
    if (!map.component_map.ras.valid || !map.component_map.hdm_decoder.valid)
         /* sfc cxl expectations not met */

