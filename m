Return-Path: <netdev+bounces-192840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EC6AC15B0
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 22:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E10377B601B
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 20:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3380F1D7E52;
	Thu, 22 May 2025 20:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OhFEbCwm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6171B1B95B;
	Thu, 22 May 2025 20:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747947197; cv=fail; b=R3cG0cwrT6KvDADncI5WB+hpniq4sKsmgXDddLPkd+93xMzyZQsd+RQEsUTSSgiSBC9MuE0+wJge1nQ/fVpkacUfqnlpBeKJ9DAo1XRf6359LgbjFIMD6hqh28XT/Sbmz3xvVojjE+zFXw0bMEIOhtnDihC9GVDzsUHHIXhqspE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747947197; c=relaxed/simple;
	bh=XneB4cPJmynYqmW0ream9AGAQOikZwS/zvmUkSFuoQQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=No/uRI8Gna3pMhEIyoDXku5Mi/OghA00DNjJRa4Ods2f2NYQqQmx2A+gTdfYlfovP0upkpHS5fLrdij3mecHuTfiGA/swHmEBTn+MX96syisSNrWSxRLnTK8zR8zKRyfFc3KUnK3yEo67cFZdayKi+tBDug1n6jCVpX64tg+GrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OhFEbCwm; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747947196; x=1779483196;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XneB4cPJmynYqmW0ream9AGAQOikZwS/zvmUkSFuoQQ=;
  b=OhFEbCwmrb3kYjgC2bOII74AjamlhMVf/jHPtvkrc2IcXIV8m1ydufJn
   zBbVXBj4JWggfZzTnv+WVWSJjFNXy9psQ2U3kWJgovTTH5WNjFy1LFx/g
   tTispCKs/GEm2QX89l2BrMI3Vg8O6lfdD4PBLxDc96KxdHHppHnDDnFrO
   BQwJcyn9d8SujHn6I2JncLXa9UDvapK8VyiIYE9GQviT4O4wIei/Yk7Ir
   IDljaCuDWyg6Vb02ZHbQEK7Wn1qEzs4nKg9Ik6OAVKV1/Qh+ZTn5df0uL
   vxBOqJ3Ci1FGCsVn7hodx/7sx77ZV6+6WGXnJe6v4g9HK7dw/Szja5bNO
   w==;
X-CSE-ConnectionGUID: jYlCm2B/Q160WTbOjUfBrw==
X-CSE-MsgGUID: HF04Cx99SC60z71OEFvWYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="60647665"
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="60647665"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 13:53:13 -0700
X-CSE-ConnectionGUID: xu2/60UDTDyjUUWoUmgxQQ==
X-CSE-MsgGUID: HaYJH0+uS5m2dYIWnulggw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="145484159"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 13:53:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 22 May 2025 13:53:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 22 May 2025 13:53:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.40)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 22 May 2025 13:53:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VNM1RHZh8Vz5l2S+3d58hYGDsXSZqi8qcKC0tYyuYBX80ciqt4a+XwCQMtgyfWTI92kcgvlQrOIYXUi1V0dDfNuvbjo741bW10NGf7K9WBs4mBqiqXy+kI0idpsB39sRoPVFNkqZfTNkg6t91RIzIJ2UTxPOKf7qS+CO2yAaO4WiY2jnup6xHd5I1KZz28zS1LXCvcWVeSqllCZOQwGyvDLQsCklOUAiANtbN7fL9hmC53qa8VbvPrnTVZIqpbHYk5A5gud7jmnrnFoOwKfYhXFh88M+j5V1UHh69eOQOPPnDnRjVYXIgufoq6HMI8iq5ckFJnS3l+P+SLk2nl3Afw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtbxS/Lg2uXdvJKDbjlUQoI42/dRG9Jb32UJ3jchXiI=;
 b=lI3tOK/3tO4pUB98IGhFQR6roOwX4tdF8jsa9ZybXuXeWtYH2k8Fcbnh2w75JXujK9NYoysDw+CGBJGCYT5kHNOg7rgNi31j5qZGxadLe4cZzM5w1P/w/LVTmGTgGwIAotxGeLAXKGhkyvn2+lEmaaiJ3QE5XUKxseVxFmtHhII8gtiE2f7ApFzVRKPsnG8hQlWujTsMG6rpDamaheiiRJ0sWGkcmO2rn2CSyjNMkXcQUXlX9DhZndPnZCgsPnuZvTvTeaoSVSieCddVUscbXGlnU6ToIJyqon0bXHMkgmJ5HiFKQDzPfoI7WMpV9E/90GMcod/fxO6LrGZHoXWutA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5969.namprd11.prod.outlook.com (2603:10b6:8:5c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.31; Thu, 22 May 2025 20:53:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 20:53:08 +0000
Date: Thu, 22 May 2025 13:53:05 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Alejandro Lucero Palau
	<alucerop@amd.com>, <alejandro.lucero-palau@amd.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Martin Habets <habetsm.xilinx@gmail.com>, Zhi Wang <zhi@nvidia.com>,
	Edward Cree <ecree.xilinx@gmail.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v16 06/22] sfc: make regs setup with checking and set
 media ready
Message-ID: <682f8eb15905c_3e70100b5@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-7-alejandro.lucero-palau@amd.com>
 <682e1ccec6ebf_1626e1009a@dwillia2-xfh.jf.intel.com.notmuch>
 <5b20031c-ed46-4470-b65c-016410adf5c0@amd.com>
 <682f8797ac1b_3e7010017@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <682f8797ac1b_3e7010017@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BY3PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:217::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5969:EE_
X-MS-Office365-Filtering-Correlation-Id: 91a1c18f-1575-4b97-1b86-08dd9972a823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?doqb4yuOMtUd6K80rirLOKcu94gDC/Ppp/FXhqR5nfPeB42jNw1QxNzB4w6a?=
 =?us-ascii?Q?Wp4ji4rJ38uTkIkyr8WNaUO1EOMeg/vB3UO1ORRV65hwCqsu+J4Gl8Kev2lO?=
 =?us-ascii?Q?k6FPlXzQqCjiTKncDHu7xR+UWAu7Sq6gniqK6JVLECcM2Wa5NnATBd2U1jj7?=
 =?us-ascii?Q?9XF+EN01Vv3kl+u6WSR+dpMHpyHBdwF/ISnF5NTOTtpJs2bZw3oKuo6oFcHT?=
 =?us-ascii?Q?r9tBACXKsffWIrYMze8S+0RLR6jxHhenNCdvT5Snlfr5GLPLAz2XMpn3mmhw?=
 =?us-ascii?Q?eEb4oU3OLRMDSlVmMc6y+R6evRsqYuefpy0jzmSzZL3R7bDxnuPLn4BWWE3A?=
 =?us-ascii?Q?hbvS0DqXIHiSkPnkaSSacJN12p6P6kUKo2Lw+lIxs9JVRXOBl+OC4HPQnTfq?=
 =?us-ascii?Q?xwpjhTSacM0kWewBz07Cr/Xe7OHUin31OuFhWhl7S1FlUkyI2jsepwWiMxjU?=
 =?us-ascii?Q?94dNI9mGo4fnvC4eFCWFRtouR65Wt03rcqLvvKZ9kkIntyQOF9pX7hkOKiy0?=
 =?us-ascii?Q?Ur9nCJzfpF0ekEtICKWTeh+/rFyle8kqu8tZ0auHAE4rFC5hO9TuWVh9LubW?=
 =?us-ascii?Q?myRXhzMG0JUAFfZAB/3Sr3GOvl+Sz6yi4k8H5oRanpJwjuLTbCwSQnhhdyjs?=
 =?us-ascii?Q?2CicCH6rVebbWPrPnkkpwqprH/qF0DF4Tb+czmg4zvE67qow8l2wPKp9hCO0?=
 =?us-ascii?Q?YlCFWzc5VGtGcpBm9ys0fPN1uTZzSyZ2/h/YVtSWD6jUBDpuqoEB8J2NKjhR?=
 =?us-ascii?Q?75SO67rxa62eMVRE+EhVrGUuZlzLCBzpQMDUiR2UGGpUo1xYrzsZH8Uf83Ug?=
 =?us-ascii?Q?4hrPQLTpbTtpPdw4v3lCqGIZxt64cIN2VVEEr5fXyzi+xZMOCbdwhzss7nlo?=
 =?us-ascii?Q?4xHL7TFDPnEGxFJwUWZJ+b+ho7BqNv1uJLTfxYiWeSJzzotVJZ7vVdDTtSz9?=
 =?us-ascii?Q?k1uTpnHeWWZMl5B8aa5Hpqqh2WcAzHD3ogicuCIsT1xkCGEkfd5SYAWTV+4N?=
 =?us-ascii?Q?EzX+G4sZfLr6QCf8yA79X6fD7NOOiwnC145Pl/paqlKbNVSZ/AkUs4F9AIjw?=
 =?us-ascii?Q?DpAb7OzB6R8Xy3/N+61I5mZKsFqyegGtiRWmDE5h9q00NQsctYTl4roCaMTt?=
 =?us-ascii?Q?1iXz8QMjXJ1w1jSR6vPl2RtSglnYMLoKHZWTlcFc2rHXCawDJ0Jis7MItnvn?=
 =?us-ascii?Q?tVgybR2LBPvdw6E/Tj35eerm6IMZmrpDLYdXkCmDKaVgCED2fcP9Ks6ow7CW?=
 =?us-ascii?Q?xZyXsoF4WbGUiyI0bAh64ZeIOSXQhORNwc/9CY9oQyNXmLCcSNLrqWpjqtJ4?=
 =?us-ascii?Q?Pc6qO3zdRXrJvMMr/azkk/c9Iang04ASIYmK+yKRZttEGeOvw1NGwmy417fd?=
 =?us-ascii?Q?d6eAsPetQQlV17Et9k3PdYEMmJAp2Htocp+ddWrz0gYd9vuCNXY9NXptip4m?=
 =?us-ascii?Q?Z9/lV4x/KCvUIzoJf0icJQkcVHme69c1n3+aJlDOwaIRwUDSV42obg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gw5w/WTzjWidx2A36sW5YJvqMstj0VDMSCbm/E2MT/YISVJ0UFybXdYZPCek?=
 =?us-ascii?Q?oyFSweFS7cV/p1PIGdpEAKwVemOWl+yWT0bL+swd5LcR1pOdnxnLxS9NbYyZ?=
 =?us-ascii?Q?QKen46cNz90McuG93PZ+S139ALjPwwN+11Iopdk99R6gGY+LdtZm4xYiHeC1?=
 =?us-ascii?Q?4Y8rB1g2/Mf0Vbomlu2RmjfUvvKt7ZpZHangQ1dEGG210uXdHTL47vecmkY6?=
 =?us-ascii?Q?S9wYUtS5HZPq/5F3LE5o4zSrTJLL0QLvFqwgAXz5XvVUGTWJkpQiFA46Md3W?=
 =?us-ascii?Q?hmJLrYPaNhvfbupftQPvC7IuWk3x+F32yM1l31kudqKFFr4hXIvknabbmovq?=
 =?us-ascii?Q?0Kk0tRSblEWrwrnj4YLk4o3m6bFmZbK9FQr0NMZ/E91yMZASzUWAUu52qefK?=
 =?us-ascii?Q?neHAYjyyUESVLwUFviWyPQzbHCsyu8gCqBbzOPf+Pm78kj9KPq8A750ukEe7?=
 =?us-ascii?Q?CieCvRPxI/Ui5XjoG5rW4GydBJj3p+atCLB59wHvT2sWtOUwSjaejqzI5Sm8?=
 =?us-ascii?Q?VDX9dKebjf4+6wKGESk3FBTjbmjtB2e9ki4Vxbe9vV4vDzSGL2W5J+ifnqLt?=
 =?us-ascii?Q?jhMeAeJeHltccYVVBduo51hNFDS2VjG7hxVMeWq2sCshvdVSavlw6xiGE1Pw?=
 =?us-ascii?Q?/Oa7hUDzW8fVP9SzRXvLJjf2ZXah3AlwMAJlI7TqI0RsBR1i/xchrZ/ITwyj?=
 =?us-ascii?Q?WMLiPciCDVZNP/akeuWmQHBK7gd+j+ZnBtrjm55Ed7C+PX564/DRpUVGUlPy?=
 =?us-ascii?Q?fGlk8OTb6/q/3IMyiaUhQyN9KTHlF1bUFrexHfBFoUQdO7OAxjClw2Ffw5rX?=
 =?us-ascii?Q?Zs+Y8gzuVKyIQygGNQSQQzTbj31R77cfaa5W+pGJVDHzClzV2cpwt7iuMjSO?=
 =?us-ascii?Q?QsGPu3yu9JUlCMgOQK64oLGAZHG827tTKFYhciRUoytYFYZ/t76T/Bgyxalc?=
 =?us-ascii?Q?AyoKU2fa+fxA2QJyLWLe+U3MFqCNMk9i0QCM5daX2Sj8p8IAXqYNS7qUg6uJ?=
 =?us-ascii?Q?VDqFUAPve8paUHw/fMloX+e3LVue89H6aIXIjZa7/fAkYhhbPYQPM3MUNZcb?=
 =?us-ascii?Q?O82BtTJKs3xV0ZsSSYQb54/M6rc3mkQlUlXN266zTHg5wwz2eeGg1wtWvTJ/?=
 =?us-ascii?Q?jbq6hHdawBdgLNXw4FNne+Ecllo5SLXTNQVl8UoyHI6FBfrX1fY6aqZo1i7S?=
 =?us-ascii?Q?dR0Hx/wLTW8bmiqzMauT11G4i2fQdZtQY8JW2gsQbNKyZOM1qyL63dWClwdC?=
 =?us-ascii?Q?KrUWdQEQSeVFhWoqXWYtSQfs3ma8w7vYVMnS3CtZ/yqd+fWLMAdoASLXO2qf?=
 =?us-ascii?Q?7BAQ40FY3m8AgkFQO4NWCF6wN0QxgtRSz1Hm7s5Efk/oMtMk9GiwXoyau1lv?=
 =?us-ascii?Q?pItRgWt5Wiul8U+3PtfTY/QYN2/seO1lD6C1D9cuRbt/gYsrqEag+0tKqJfV?=
 =?us-ascii?Q?G39HLsTrOUEJxUbfNjoJ4zJLxWFpxb35mqYSFpf+Zrz+acT2+IshmesjdfvO?=
 =?us-ascii?Q?O1NUoWp2ccqWddYlPw7I6tHIYfg9ZJ1ruMY8gWEE2mQed7tE9jnpJrTESllS?=
 =?us-ascii?Q?jpJKLuxjAmZl3iUGFidKR2wM+8h+yl4sIAks1U6ERTVR1NMIOT7m6haX8WXf?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a1c18f-1575-4b97-1b86-08dd9972a823
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 20:53:08.3947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSSiqV5b9nqINeIexixfBxHpc7bnzC/Nr+kqTUb8BRyyrP56An65VX3kx+3ZPGyg9NggD6beTEThbzptvJjBgBEq2dxIlPt6ipU+u9vb520=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5969
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Alejandro Lucero Palau wrote:
> > 
> > On 5/21/25 19:34, Dan Williams wrote:
> > > alejandro.lucero-palau@ wrote:
> > >> From: Alejandro Lucero <alucerop@amd.com>
> > >>
> > >> Use cxl code for registers discovery and mapping.
> > >>
> > >> Validate capabilities found based on those registers against expected
> > >> capabilities.
> > >>
> > >> Set media ready explicitly as there is no means for doing so without
> > >> a mailbox and without the related cxl register, not mandatory for type2.
> > >>
> > >> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> > >> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> > >> Reviewed-by: Zhi Wang <zhi@nvidia.com>
> > >> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> > >> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> > >> ---
> > >>   drivers/net/ethernet/sfc/efx_cxl.c | 26 ++++++++++++++++++++++++++
> > >>   1 file changed, 26 insertions(+)
> > >>
> > >> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> > >> index 753d5b7d49b6..e94af8bf3a79 100644
> > >> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> > >> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> > >> @@ -19,10 +19,13 @@
> > >>   
> > >>   int efx_cxl_init(struct efx_probe_data *probe_data)
> > >>   {
> > >> +	DECLARE_BITMAP(expected, CXL_MAX_CAPS) = {};
> > >> +	DECLARE_BITMAP(found, CXL_MAX_CAPS) = {};
> > >>   	struct efx_nic *efx = &probe_data->efx;
> > >>   	struct pci_dev *pci_dev = efx->pci_dev;
> > >>   	struct efx_cxl *cxl;
> > >>   	u16 dvsec;
> > >> +	int rc;
> > >>   
> > >>   	probe_data->cxl_pio_initialised = false;
> > >>   
> > >> @@ -43,6 +46,29 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
> > >>   	if (!cxl)
> > >>   		return -ENOMEM;
> > >>   
> > >> +	set_bit(CXL_DEV_CAP_HDM, expected);
> > >> +	set_bit(CXL_DEV_CAP_RAS, expected);
> > >> +
> > >> +	rc = cxl_pci_accel_setup_regs(pci_dev, &cxl->cxlds, found);
> > >> +	if (rc) {
> > >> +		pci_err(pci_dev, "CXL accel setup regs failed");
> > >> +		return rc;
> > >> +	}
> > >> +
> > >> +	/*
> > >> +	 * Checking mandatory caps are there as, at least, a subset of those
> > >> +	 * found.
> > >> +	 */
> > >> +	if (cxl_check_caps(pci_dev, expected, found))
> > >> +		return -ENXIO;
> > > This all looks like an obfuscated way of writing:
> > >
> > >      cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
> > >      if (!map.component_map.ras.valid || !map.component_map.hdm_decoder.valid)
> > >           /* sfc cxl expectations not met */

Now, I do notice that the proposal above got the registers blocks wrong.
I.e. that should be:

      cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
      if (!map.component_map.ras.valid || !map.component_map.hdm_decoder.valid)
           /* sfc cxl expectations not met */

I also apologize for the negative connotation of "obfuscated". I should
have said:

"This simply boils down to the following..." which is yes, a bit of a
mouthful to type out, but it has the benefit of no new changes to the
core which is my preference until it becomes exceedingly clear that new
APIs are needed.

So,

map.component_map.hdm_decoder.valid
map.component_map.ras.valid

...instead of:

set_bit(CXL_DEV_CAP_HDM, expected);
set_bit(CXL_DEV_CAP_RAS, expected);

...please.

