Return-Path: <netdev+bounces-175637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A24EA66FB9
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 10:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02913188937C
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 09:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D1620764C;
	Tue, 18 Mar 2025 09:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LaeV1xNf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4116207675;
	Tue, 18 Mar 2025 09:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742290033; cv=fail; b=OCt13AiKaQkzqRH6XCeIlY6/kZeQsV1iMTBt6U0G1VDHN/AYpX0GhAVisxHeK8+J8YQIjHkQ9sxcPW2dZFJVirQ+c616c9ONi+OBEPxfhyNqj7WLxrfRIlOr6owkEIAFvXYE5A4gZXpv75P9m31IrdsWmsWlHQTl9uHyoMHAHDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742290033; c=relaxed/simple;
	bh=y8GV6c7arKFfr9ztSjXepNUBUZI5sa+TOnsDLBg0tOI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=evUxWsFx1EVYIuY4X7ie6QJKzmk3MTWGw/SDAq6+QZUowWFuopw51vh8dT+ixMyBZeSuP9KhKR/c8kdbfK1IdVkL/NqXbyrdZZfGGOXmT6XDQnxNzlJdHGUs2oWWuCZD7sDSJ/5cXMF/D1UWynG/mckohDu/FwixsMbNZpF4eL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LaeV1xNf; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742290028; x=1773826028;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=y8GV6c7arKFfr9ztSjXepNUBUZI5sa+TOnsDLBg0tOI=;
  b=LaeV1xNfy2MWGCWGmqG0nYpKIRGjJ9O25quzPnCFaaNgfnzYjMFFRWpM
   qHYu9qZtMo2NBJ0LlmdzCpzveixVl3gwCmicXPYnUPXaT2LVczOVX0bzQ
   QgjosTAsBUJln5WgLthZgEVVkk5a/X36JClZ2YNceHCCapvPPROP9SOwM
   ETzDeb+DrIw0qKVAYzT9jX/EbF/ABLl1dsJGWS0VuM8TG6g/qOWkuSLY+
   CQoDnpY+/gm7tlnF8tTRjV4tdhFM50PvwHD1U16opAg9dTPEKtRFvEUHT
   GE27LoY9pyN8V8Yg+8YWxreLMv94M9qEU1AVzxc+zc8a3CWtYkGe9S5wF
   g==;
X-CSE-ConnectionGUID: sZrYyL6WSh+dzGvE4lAxZg==
X-CSE-MsgGUID: oOaIW5H2TnSCgbdcPHYxNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="60950368"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="60950368"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 02:27:06 -0700
X-CSE-ConnectionGUID: h8tvJDIBQH2SsiPiXs1Kew==
X-CSE-MsgGUID: T2u96EJASNG9u7F+uqlL2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="127044888"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Mar 2025 02:27:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 18 Mar 2025 02:27:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 02:27:04 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Mar 2025 02:27:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JqsLTiSYqCCxKZWxbNpOVDS2SsEvLwHrJk9K5JU+X6rQxab6/1YZVug26CMjf78YUCnP47X1wZy4M0Ij6koHCeHeiXhDCTnLoc+9RSJMuDVw94MyD6wsyFX5GXtNh7nLIij8z/jxhOm6jzV8rHMScxKQxoXllPSo8XnUSCWzZyTlhL72Hkv8ZaooSBRaQ5H2Dj9woFH/DdpL013nzDbfWzylOAhy5/BQkYOMhav82GYAWNQJpgZRRwoI1A0M7IEXWssH8V6q4T5HP3A7i7ibjfFonWxvNQb4oAUCiInZxsBB3vJdgiLkq33Mswilwl5W4t0/IZ97pPxD0TOr4YCWgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDVSh2DkE2dAoB92/SlSj+bwGsn0NIiNYDp4tkPQ/Z0=;
 b=rICh/zyLgDD4Oe2cJqWK3jyq8F0+aBM2WwZf0nq569eDIwpZwxVWXlQ1Uzk1HmqV8b/nYapit4+284l/vJpSXWNtM1Oxi1SHwdoQbHIy05vmsjhCvmu9zZ/TvYBJGY3X8Bbejv6KVzu7fuTketaRhUux218cMAeGAXld3DfArj6TzYzEE9mez88WqurS9HDQ5IhPuDQrM6qHr9XegDAO27o3bQe/O390/sPv084b1DKbsSkfQ1ANU5876cFe03PAJry9KFti/nHGjI+XriSccfXILrzvGTtlIqs85LFgnYk51/arJvtlqpzsIwiu6Yk7VChBcoUT0LwzT1sgyxnRbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 PH0PR11MB4776.namprd11.prod.outlook.com (2603:10b6:510:30::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Tue, 18 Mar 2025 09:26:36 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%4]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 09:26:36 +0000
Date: Tue, 18 Mar 2025 10:26:30 +0100
From: Michal Kubiak <michal.kubiak@intel.com>
To: Simon Horman <horms@kernel.org>
CC: Chen Ni <nichen@iscas.ac.cn>, <manishc@marvell.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] qed: remove cast to pointers passed to kfree
Message-ID: <Z9k8RmOkKm2hQSi1@localhost.localdomain>
References: <20250311070624.1037787-1-nichen@iscas.ac.cn>
 <Z9BuCIqxg5CRzD8w@localhost.localdomain>
 <Z9Bv+cjkxlVHsKAd@localhost.localdomain>
 <20250317185622.GK688833@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250317185622.GK688833@kernel.org>
X-ClientProxiedBy: MI2P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::8) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|PH0PR11MB4776:EE_
X-MS-Office365-Filtering-Correlation-Id: 19b5faed-a931-458e-ef90-08dd65fefb06
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4d/muZq8Z8vRbAx60hpeYrmD5Oe0o95hgL6QK3OnQh5DC0Z3T1SjuQojDQJz?=
 =?us-ascii?Q?ttmFqomG4RofoPMxCGYAaX5ENRq2V0DMBPUN9PqiK7raxM9fWEIOcy+tZ7Yj?=
 =?us-ascii?Q?vNu3fFKmxHnlw7jD5nlJkvMzq1uiokPDUsu4npVAmKAD374S1wh0HTWEZGUW?=
 =?us-ascii?Q?3aB9tdrI/TQje5SgEgZ+JdsHzoy2DGR+3YmPTL5oLE9I3mAGRcXrVfdxtZMC?=
 =?us-ascii?Q?2kRjJDNDwg9WJErq/UC+0NdSRw/ujXwoC4gjPUcD+jYZtewWnUl0YlIHPTOA?=
 =?us-ascii?Q?jGEUa3rv8bNvGuMtqCWv5LxLjDBPB88lDH5fMD1gzFtnruaYw1bMpyLlGe4q?=
 =?us-ascii?Q?eqg4K9OK8abdnjGmBi2SM3V5Ivo4OKuLcjvyezGQvwdHpS/GB3Sipz23RZwZ?=
 =?us-ascii?Q?ddzbGbS0o9ApUpos+M/yHV/eap3XJlwEqmGiiopqcx/DdeGi36NFX7Uau3K3?=
 =?us-ascii?Q?kNSFAyFBB+vmiylAmTLdrzdtjhXd7RichckPTWILwk0q37OQGVxsxGmIe13b?=
 =?us-ascii?Q?kpK319HoEaG6MIwJWj1njU2bgHfVZKvMt1AY3WgDG+4KkYrwUqaW6OvB13q7?=
 =?us-ascii?Q?D7hvdQDRJZrvCYHwfxM52BeCcM6CTkbax/ZbfsDAsIODH2QrKTo1GCcplhbI?=
 =?us-ascii?Q?HOaho+xVJKn7qYaG5Tnevm2ghJHg867KLNbU+TqBTRlJ0ViE6Yuv3fFPFf+h?=
 =?us-ascii?Q?pRMSum4fSA5+Uk2PusTStUauImP9KocXP8DGxO37PxkBs9lx5TxTNbkcZysD?=
 =?us-ascii?Q?T7Nh2op5+g0kPlP4uyBPi0h5ySFJ1PjKim49jjzLr9qK3Oi7Nmd8zivqMjbi?=
 =?us-ascii?Q?sR+H9jSDtU4Jx+oKnaT/iczSpbSgbiLCKCndi1qLpZ4RkAy+Fk7ZISwNzNK4?=
 =?us-ascii?Q?BSYbCJGag7a3JU+v+A+FgqXHdfKZFHlcrN8sD44rs0Jn3879ebP7Rm1csbB0?=
 =?us-ascii?Q?2m04KPxxHc6xmtoKh822UQKNN8l081dmUXPWVjUtrJq0gFiZMg/IEH1987Rl?=
 =?us-ascii?Q?3BoHC3n4tznHpKCw1JYBKoZs9O4gt4ceOY4MGM/UKmxp8lT01AKb48M1uRcO?=
 =?us-ascii?Q?y4aF4lqt5heezBPc2zP9xcHKHuQFKY9NQZRwuI+nQRS+Z47opfUjhqlNdPM+?=
 =?us-ascii?Q?2+62EeAwalkpUhw0qhZ5zbWtnk16EOWNB9dg6/Vd+AFnWPud/zIFGturbT0t?=
 =?us-ascii?Q?WI2GgtdNWq62oVBDBFvCGnKqjgfAkIHusBNpqfHDV5Dktc5c/dG5EJa0jWBe?=
 =?us-ascii?Q?0LFBX+feUjXGJsVg6zeVXpTJi8xH7u/5n05isSl2FHuk2+N47TnKTWeO/aYJ?=
 =?us-ascii?Q?i0s2C1YBQRQtHm7ULXZmQbl6oj8pbRveW+NhVFF6d9tJooV4JAQ+p9tnq7aT?=
 =?us-ascii?Q?Y33nDm2E8JdO9bw/xjdPxvv/120N?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k9t4NzxUgoNsBSYSGTksk6WLyzqB3N4T2JZLdNOAFXTMU27VGEXgPgCJ/w/0?=
 =?us-ascii?Q?MckblmDgHVLPdRQ0B6zLSi0bXeIQE9I9TC53r0DTgWABE+5HQHNKcDyzW1Ns?=
 =?us-ascii?Q?2Lkw96EG1ZmkppX0hOvuexsLBuCo7q7Sr3i31V61sLHVjvKVyUXvKTF5jaKf?=
 =?us-ascii?Q?/fVbxBTvfZUv9CEE+Pnr2xFBpITLk/71w7Gt1YFzUVxDRsoXL3Jr0l4OsOaJ?=
 =?us-ascii?Q?1sWgsslgJz7mF46gHASI49K/nquRBRDb2hs9SrXmkMTdsMPayHqfEpcK2ZPG?=
 =?us-ascii?Q?dlUau+2zpCGLXnYbta0udyrPr3YRkoL5zlcHM1xYwRYg0kkEFDwx/ZAEe1Am?=
 =?us-ascii?Q?mTXnd/+K2SDapJ2nLTDMTrXvKfCoNIH3k2UHs5DO812poLeKJq7z8CoXaki8?=
 =?us-ascii?Q?k7SJv53a8j53cba6/yJvVqbnbFublYgOjTMD4u5zmF7xVek4IK1Rdmuq8MgJ?=
 =?us-ascii?Q?e8VWHczc8OvpHxDRBGsUHylpjlUedxYhXR+J7vCZxLQQ0PD1v3MlB7LQNIcR?=
 =?us-ascii?Q?mkv+St4Ka8262gopenpIRjlBGKy4mBwiZANHW2zMrqa0Cf3qb1KfF0bF4BTg?=
 =?us-ascii?Q?dUXST5xRjaaU5HOlvhu9Fv4ImqI0NNQ58i7G0r5eHDMjXdhG2XIhRKyM+UHN?=
 =?us-ascii?Q?rC+MHnjXVJpbLksx+Lu5CxZ7EcEf1XZgfLTsVf031RSMPz1B9CL6NgFnNUKH?=
 =?us-ascii?Q?WRfWVIAEA1O5ZZ3GH6LEmboA7BdNlZi5SmkaKmPcJ0jJ/zakkZYCdIBFqq5H?=
 =?us-ascii?Q?iHy2kkU9nC1gKsAiMQdzFnMZfCvjLb9cl8JSelbvOUoVMx3/ePLif7HUn9BU?=
 =?us-ascii?Q?nx59FI3hDclsyKwyBwAcj4L8y6YpAy3JkVMlp5Kt4VdVhMoqFIumG8Y6o/ec?=
 =?us-ascii?Q?ImiQi5i+BMn/YKJodP5jIA07uHMVDteGIBG+cU9RmqJDFXN2LCfs1OU+r2l9?=
 =?us-ascii?Q?hxW5IUyqZ6OTeGS3Pd89H8CezG37tvqThHmi/FmFcKfzclUpBUaGwBoxBMTb?=
 =?us-ascii?Q?o6Zu+cmgKkW4V/qEzMMKBjZyLHQV0DNkm5rg7BpP5Rc3Mdoc4Vf3LS3DpE7d?=
 =?us-ascii?Q?hDDOYwIKKjjpj5uP/yNuvBsk4n1d/V59bU3IY/d+f04hD2e8pWSBQka8whlM?=
 =?us-ascii?Q?k0NcfsbmeOsUmRIMRPRpVXEs0DDl3kvZssdEHSVeEYOuMKUWQyi4oC3mQUOy?=
 =?us-ascii?Q?Nv3AspuS8aJC8JQzCp8500DuOyTo8SO2TBNUgcda9DaTZPWYO+bKSBWQU9uB?=
 =?us-ascii?Q?/w8h1VMbJvUw9knQi7hdVpfvFEUOjQTm7naJECVVswQobPi92+Rm+2tEsPtd?=
 =?us-ascii?Q?4W3EfqMrwsZIJukOcrdj19hR3TfB+Se0u6Azy2jbr+8JbXIlwcNvrISos8+z?=
 =?us-ascii?Q?v+MKTCMBQTjgWFf60frW2Ueo9MO6mZYPJWrIXQEn6WN/YzAqL5gbPcOkUmVT?=
 =?us-ascii?Q?Th9JX8eiJPIVbusBvibKPMGjEr/76ZDvc+S+m5Aop4iEuuNO8PHyrzrPcIV0?=
 =?us-ascii?Q?WNVm5dVF/P2FOwyptY7q0P0V1b3eAy4me/fm7JF+nUbBnHs/4dpYqOFtXkCp?=
 =?us-ascii?Q?uZVcSKrfPFV24NdtnU3J7k9f/rpu1Yf+R0uQjqW+Vsd1MrbPJJrAWPl56kr5?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b5faed-a931-458e-ef90-08dd65fefb06
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 09:26:36.5381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1NGhFiqWSeDiTTeA+g+kZX4kld2mD5TM+y0CZKKmIKpFEwccx5Kxv4yUKZYWzAlP8F1ANrnv8UxcoDzEzQ2q1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4776
X-OriginatorOrg: intel.com

On Mon, Mar 17, 2025 at 06:56:22PM +0000, Simon Horman wrote:
> On Tue, Mar 11, 2025 at 06:16:41PM +0100, Michal Kubiak wrote:
> > On Tue, Mar 11, 2025 at 06:08:24PM +0100, Michal Kubiak wrote:
> > > On Tue, Mar 11, 2025 at 03:06:24PM +0800, Chen Ni wrote:
> > > > Remove unnecessary casts to pointer types passed to kfree.
> > > > Issue detected by coccinelle:
> > > > @@
> > > > type t1;
> > > > expression *e;
> > > > @@
> > > > 
> > > > -kfree((t1 *)e);
> > > > +kfree(e);
> > > > 
> > > > Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> > > > ---
> > > >  drivers/net/ethernet/qlogic/qed/qed_main.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/net/ethernet/qlogic/qed/qed_main.c b/drivers/net/ethernet/qlogic/qed/qed_main.c
> > > > index f915c423fe70..886061d7351a 100644
> > > > --- a/drivers/net/ethernet/qlogic/qed/qed_main.c
> > > > +++ b/drivers/net/ethernet/qlogic/qed/qed_main.c
> > > > @@ -454,7 +454,7 @@ int qed_fill_dev_info(struct qed_dev *cdev,
> > > >  
> > > >  static void qed_free_cdev(struct qed_dev *cdev)
> > > >  {
> > > > -	kfree((void *)cdev);
> > > > +	kfree(cdev);
> > > >  }
> > > >  
> > > >  static struct qed_dev *qed_alloc_cdev(struct pci_dev *pdev)
> > > > -- 
> > > > 2.25.1
> > > > 
> > > > 
> > > 
> > > 
> > > LGTM.
> > > 
> > > Thanks,
> > > Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
> > > 
> > 
> > I'm sorry I missed that the patch is addressed to "net-next".
> > It rather looks like as a candidate for the "net" tree.
> > 
> > Please resend it to the "net" tree with an appropriate "Fixes" tag.
> > 
> > My apologies for the noise.
> 
> Hi Michal,
> 
> I'm unclear what bug this fixes.
> 
> It seems to me that this is a clean-up.
> That as such it should only be considered in the context
> of more material changes to this driver.

Hi Simon,

I may have gone too far in stating from the commit message that "the issue
was detected by coccinelle", so I considered it as a fix for the issue.
I agree that it can be also considered as a clean-up, so if you don't
see any problem I have no objection to sending it to "net-next".

Thanks,
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>


