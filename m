Return-Path: <netdev+bounces-126795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4D6972841
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 06:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F7ED1C21A54
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 04:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73A938DD3;
	Tue, 10 Sep 2024 04:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RT0nMBP7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB9D1448E2;
	Tue, 10 Sep 2024 04:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725942017; cv=fail; b=g++XWGuNC/8fe576Y6Mev/j/Cety9BmEQ+rI/hcb1IiN261Rexx2ycV3K/lFSfVInnsJnPQ6AJtCzVgZaIUUzGWmQVJHB4ZVjA+9vEQOe+x1/6hcr+tzzpr3Dmr9coD9xzO/nTQOxT+DPf3rVEXLxpmZ7yR+mzzB/JzNQXXoinM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725942017; c=relaxed/simple;
	bh=XZAldZhgx3uFqWoLUfHTouUjLCWGraoX5kWiN/zQbXM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nN2xGRxzNFne/nfM0l5qQ+XGyFFvAQYFThXVfUdOnhjhuPAxnFBRPYQexyM3lzmiVpdBjOM0mNun0KeMT0zVZK1zs8YwOI2wGP8clDcuj2yWBgZVaw0tN9Ve/DjUAIJkKNO5H1PEQ+Uu7RYorXVRlxUKR+92A8ysPny3kom11xE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RT0nMBP7; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725942015; x=1757478015;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XZAldZhgx3uFqWoLUfHTouUjLCWGraoX5kWiN/zQbXM=;
  b=RT0nMBP7OlwVjYjqxmAVsAFLFZ//cnPbYnkfAdF/hZG3WfxDK4GoFVeB
   AI1g6egod6XaKHqVmr32XgwNP7y/Wz6n03wq1Ftut/8OYiWW0GWNA1UlC
   I6j/NQBWeaeh27Lz+PCfIAyUGuwxMOrEvYjfkz0YlbjkN9OT5bw8/MoVU
   0OtQ9sGuLFfv4eE7H1dC9a/4VpQ4dxxn7u1VpEqsrG2oBf6VFi0eGSxrR
   +ZdV6WLD+H+dJbAarCWEYl2hg2QnoIW08Y84evCm9lG15IZ9lSFrhSTcZ
   grEzXoNpU3njOR/Zm2BKQ8r3mYtMkPk/Fn6tge3/QEMYwIdsY8VtQwb/Z
   w==;
X-CSE-ConnectionGUID: ggnGjgYPTDKqYzbU7MCkMA==
X-CSE-MsgGUID: hOlo0eilRdGRupJqnopiJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="24213383"
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="24213383"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 21:20:14 -0700
X-CSE-ConnectionGUID: LdisceHKSIeRYkYoi8rQRg==
X-CSE-MsgGUID: pFtY01JZTZal8jWLLzCcAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="71856941"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Sep 2024 21:20:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 21:20:14 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Sep 2024 21:20:14 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Sep 2024 21:20:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QxUQ+lPOZa4GR/zdP+mzf58BrE9ciShL4OeBuxBhZG+wiu3ecaMJkzF8g0WqOaxYhyPrvmKosGeJBLgUMaVirbbXk+WyCrtPytZPwZrTVnD4xyO85ioXYSEW9OgdxchvkzSeRTcvFSD4amM1KY1l9ATTUMJ0bYlAxy0el1SHtCmemGDzYIeFji55Csd+UW7vfEefl75sR5ThtuJWHm5Xj7jj+uM/X2vuAwut2Vdg3y7Yfaf1rWs/DY29XiUk0/Jqqmh8pax9Z4mg7kcvxcpn72a04mKx2qgNRM2Fe94T24w3tF5tBmFttYFonpEMtVHaJ2xwME5A2logCq6cIprKYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3Yw5Pyn83Q7E1tLQYMmWvLhHpXKO7dpd1+YVwwKl4A=;
 b=sY8A511u3P/utnOea+bqrhKRdmr/Q6KsR6qpsgSOR6MeoVjuXvtlBnTYipEPqnoJmcoS0+o2pxsKuoCX2khN6e7g/vrHkgXCNxT15SeXFPerO2YvuXvO0o25ehBVqn12rhLmTjWiBpIgINyYjkOBsOwjM8CA6EanGvh3I7ULgFWM0p6oIiVnubLLSYUWesev/1pos7+Gr68c/O1E03AyCGMJBDiKm96LP9Zn7TRUl3z15PdDPC3kFFe36G1M2KfmAP9tyZ+uDzhSe7oujdokEcM0aswCL2x1QcYnFfVSUTnmFA05Cav0srNBB2C9CoMwjr8eFEdasuqq9O1Ru7JjDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6428.namprd11.prod.outlook.com (2603:10b6:510:1f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Tue, 10 Sep
 2024 04:20:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7918.024; Tue, 10 Sep 2024
 04:20:11 +0000
Date: Mon, 9 Sep 2024 21:20:08 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, quic_zijuhu
	<quic_zijuhu@quicinc.com>, Ira Weiny <ira.weiny@intel.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Zijun Hu <zijun_hu@icloud.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Timur Tabi <timur@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] cxl/region: Find free cxl decoder by
 device_for_each_child()
Message-ID: <66dfc8f83414d_3264629429@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240905-const_dfc_prepare-v4-0-4180e1d5a244@quicinc.com>
 <20240905-const_dfc_prepare-v4-1-4180e1d5a244@quicinc.com>
 <2024090531-mustang-scheming-3066@gregkh>
 <66df52d15129a_2cba232943d@iweiny-mobl.notmuch>
 <66df9692e324d_ae21294ad@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <a6dae308-ff34-4479-a638-8c12ff2e8d32@quicinc.com>
 <66dfc7d4f11a3_32646294f7@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <66dfc7d4f11a3_32646294f7@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4PR03CA0351.namprd03.prod.outlook.com
 (2603:10b6:303:dc::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6428:EE_
X-MS-Office365-Filtering-Correlation-Id: d1660e58-43d5-4845-30f2-08dcd14fdc94
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+ehX1XTAv7ab1xXq8lpuaugyEZlduB1pMr42MTp0+OJkQ39GJBzLlgPAqJ+b?=
 =?us-ascii?Q?zHegj7ln0Xi37evXQ7vrLFujKCLJ39cOYKj4z8CtkobbwP/JjbyGUMhwSl+6?=
 =?us-ascii?Q?r1wHmgbD51AEtCxzxY652jwFzVms+9VIkoCJ9y30few9MC5H5ib4fpjuGPo6?=
 =?us-ascii?Q?zlADJdhqj/lsg3g6tU3tCZ9jQYdCSW+5NbZymaplFWYBXgDF9bw/Jz61gJij?=
 =?us-ascii?Q?pCfltuT53jlO3mKtzH9MSYNcUQr38HJfs60Qf89Bojasz1LLscR5OUqSmTnW?=
 =?us-ascii?Q?PPx/AJhTYIlMja9BwssRsZd01DmHHB4nfU/wmVilwDKU2KiLXZ4zNLHe/LPg?=
 =?us-ascii?Q?QKL5GKn9Y7+2SPz4k6Q0aqRtHcr7n4mOY+kcdwiMjDyO9xcNjfSrCpf63954?=
 =?us-ascii?Q?I8CKe+uFy/B+lD8+SOW8uuOGZ4EPWEcUT5V+7L7/oeq/4CrwhN32Zv4UbhKB?=
 =?us-ascii?Q?MLT+waeerQwGo9hRhQc28HrHnLYv51JpEVzfJwDo1YOK5Cz15hVETiVwc9QC?=
 =?us-ascii?Q?0pT27TXllgS1D6mY2QKFo/+TVvlmrSUwmsN/GivGTnAggbnDpBm+OWK3oiTD?=
 =?us-ascii?Q?vm5Qr100IxFG5V7HkcAm/3vRuycwhu4iIhjKYKqu3RZoYaf0PTRx7Un4u+3W?=
 =?us-ascii?Q?V5oDR6AqAYEogyQCdCPvj6bUt0c4TmUaZbH9TojpAeo3ka4g8E6EG5ApeITc?=
 =?us-ascii?Q?8r86lTkMcGKZzFEXjhw63e5dC9FCGspzc1Tzs3e521EXMhjzaFkcEFCvDvud?=
 =?us-ascii?Q?lnSiYqtFANtRW654rylGJHtJ1ze6ypccqNJbjGsCyd5psnk9HsJRapf6pSdk?=
 =?us-ascii?Q?lk3EATHYGq0biHJIUjBiaDPK8J0cNzBhbcP/j0M1Xl3yXuftPhMVtrDDdDMF?=
 =?us-ascii?Q?8fKdyvJxZ0DhMf7TIoMfdjgJp6OdZVSY/KY+1cGYZkcnJktEQdQxh3XwTspF?=
 =?us-ascii?Q?7rJ4MKUdCjUhXMvZqVEhK3k6ZkhSt2uKYZx/4xTMJgi7vrSPj4adOZu26QEe?=
 =?us-ascii?Q?Z28DC6auSEtL0x087KHpI/tgtOEXQxS5wwEHUuD768xw3w+10lGAexK5i+cw?=
 =?us-ascii?Q?Qb0r9EqCV40PFVV2ae1u3CIC1f94lgbUn7Kd7XhwlvVi4Zz616oFO5kDOYxM?=
 =?us-ascii?Q?XJicC6FSJ3xB22kS1c8MDCe9ynMn4SVudg8DVe4lYSejEwHA8nS2QRnQcPdb?=
 =?us-ascii?Q?4JCTCSZLwQ6bFB5EUG61ZMUAMzg4ES//HFxh6+UcRI7zK8PRX865nd8ONXTY?=
 =?us-ascii?Q?ISyDabhw8+/25Iukbyph3Uy44Sm2qSooHdJr8Kyeyv0f8MnAn/hyRuzG258Z?=
 =?us-ascii?Q?zBGwmi84w9/SKfP9BhP5HJ55BKuOS8OsrQJ3lnQEdZk+9w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o2YCAdGizNF+rWUn1I/ZMd3liZidZQVWoXuQEfifyaGDAds1m/vmRdo6KPz8?=
 =?us-ascii?Q?rjMNfOkw4O7SgvSbpWUuRI/kgAe8RJXg+JVqdlMlM/OtSy4I8KrFWXl8tJWX?=
 =?us-ascii?Q?zDI56tGIFjgOrjeEhyQjKzlJM4qgDeb+OTzPIPHACBwpXwQmX+7aHUupGyB8?=
 =?us-ascii?Q?UbOHjevL7INiMZPn76x7C4kon7hbF0DbcIxAaKCIrT0TYafw/q2Eat91Vq+G?=
 =?us-ascii?Q?YKNpzj+95bSFvIG0SPcN+xziFDbQxvgfHvQWAhxJbIzqyU9qgAIYQitxW1di?=
 =?us-ascii?Q?yGcacEXK/JFS+s+UthLW0Wd0G+XCGJL3lJgrgai6u3FSjATujQboIWNxuZ6q?=
 =?us-ascii?Q?7SeapLxHNc+qQUSRbvKNtBpCgGvHnknI1/NUKiXM/8Z996Ygz1QM9nAMJBm7?=
 =?us-ascii?Q?iPAmQS5vj7jGHR7Mt8dAfI2mWvP5IDHWxHcLWqSlkK9ze6nmVYnnRhFXxOHB?=
 =?us-ascii?Q?FlOiOb70UcStNpdBV85+0N4xiZjfYZ44wggMmSRz5AEwlb/VV3qB8mqBMR7c?=
 =?us-ascii?Q?YDUaZzP0LMKo76wKs2v7LgdQ5ic4Zl03qSANu2EWnMrBl2Ns9nTxJ+xmYro/?=
 =?us-ascii?Q?87uZ4mkoz/g+QLIaFvq2KqOs/dx5/0PEiHrI/dzmii3zwkzH6WcJSQ/Mr1CB?=
 =?us-ascii?Q?9XN9/quZ9MAEndLr5bSSxfA0VQaXbGwEHXZG6qcghDTPAg50M2sZkr6OjzxF?=
 =?us-ascii?Q?oZi3XIkejwGzUYXzFOF0PcLCRmpzyaltdRyE0xmIT20nm5eby/6EWGrNBF8A?=
 =?us-ascii?Q?QYWmfZ6UCsW77KgDx2Hj9Vl3FG85yJRy/lUoW4ZvI9MGw7TvYL+/0dCaxm6I?=
 =?us-ascii?Q?WG5jutbK3nqlVEbJrE3hzg1A8BvgPbXDgSRnB3dYOCTkk+yObjfcXl66AYFl?=
 =?us-ascii?Q?RJcsUXV6/5X88MBNfh9WWwgyp6C5IJD1+0kfUJGZhDrYdP8lmHHRXcOZamf3?=
 =?us-ascii?Q?ViJdZ1ryQuloctvUm3dW21cP4D6zX+yvtF+GSlgR2oSf9TOqhQxM9R1s9qtH?=
 =?us-ascii?Q?L3YZZpATEHzWykJUTjuT5MeQBlKiTlUAvlE17V4iHg+GLYC3ID1YB1GIABVx?=
 =?us-ascii?Q?LJ5/pBIr05PfqmBKRF8HNMnxRJshQ14eDOXhLO/BgsJqH1mzqlXbBuMpcVCk?=
 =?us-ascii?Q?6DPpRv2TcrhfNWUYemIlx9tPsygL1u5a8PRiBsgYtTXpekU74V7GYqk2bpOh?=
 =?us-ascii?Q?E5zvN7RuRmf2YHUuY7zGAfWQCUZr609GjKXC+qxM2HvBukX7cRNWJmo209Zf?=
 =?us-ascii?Q?HJ9pjvij7D0EA1jWgEbbktb/gjFvRqIAcpKIZ2+DJHRcONxZGvWGmLBP9Y4o?=
 =?us-ascii?Q?Xu3xYMyk4+LO42JB2S9jtlwbcTG2qp6IpxmupkVHRw/JFw6aAy7/i5RB4lof?=
 =?us-ascii?Q?cRhCTMO3fhVbKEOXsWWYWDZhFuKoDdgpY1dgzmjgY9y+CFmtrF0OSQUfAnjv?=
 =?us-ascii?Q?ecX3Tl1HOL+3qy1rRtZQkVwHl39qS8lXK9uh9JlaD1CVS3C5LezcRLYXQnpC?=
 =?us-ascii?Q?gFRFnngk0FjVQNpi1qblFOIvVkjoeoloK4UDLoB/9XnG9Z9TNMsdw2sicxzG?=
 =?us-ascii?Q?UcEN49TfAgHZVP8JtNGmp+clBLpNKXhKvPL76p2+73uUNrZFati8wA0mrUba?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d1660e58-43d5-4845-30f2-08dcd14fdc94
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 04:20:11.4349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ybeMY8QARvCGZ98XIoFRLaunPbLTW+mT0CC4TUlsqaY4LgDMlCydkYUOaCFn/3St24DKWuxsDzaHrVsc6scHKr76VAKyqAHahlGy9CmnrH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6428
X-OriginatorOrg: intel.com

Dan Williams wrote:
[..]
> So I wanted to write a comment here to stop the next person from
> tripping over this dependency on decoder 'add' order, but there is a
> problem. For this simple version to work it needs 3 things:
> 
> 1/ decoders are added in hardware id order: done,
> devm_cxl_enumerate_decoders() handles that
> 
> 2/ search for decoders in their added order: done, device_find_child()
> guarantees this, although it is not obvious without reading the internals
> of device_add().
> 
> 3/ regions are de-allocated from decoders in reverse decoder id order.
> This is not enforced, in fact it is impossible to enforce. Consider that
> any memory device can be removed at any time and may not be removed in
> the order in which the device allocated switch decoders in the topology.
> 
> So, that existing comment of needing to enforce ordered allocation is
> still relevant even though the implementation fails to handle the
> out-of-order region deallocation problem.
> 
> I alluded to the need for a "tear down the world" implementation back in
> 2022 [1], but never got around to finishing that.
> 
> Now, the cxl_port.hdm_end attribute tracks the "last" decoder to be
> allocated for endpoint ports. That same tracking needs to be added for
> switch ports, then this routine could check for ordering constraints by:
> 
>     /* enforce hardware ordered allocation */
>     if (!cxld->region && port->hdm_end + 1 == cxld->id)
>         return 1;
>     return 0;
> 
> As it stands now @hdm_end is never updated for switch ports.
> 
> [1]: 176baefb2eb5 cxl/hdm: Commit decoder state to hardware

--- cut the reply here ---

> Yes, that looks simple enough for now, although lets not use a ternary
> condition and lets leave a comment for the next person:
> 
> /* decoders are added in hardware id order
>  * (devm_cxl_enumerate_decoders), allocated to regions in id order
>  * (device_find_child() walks children in 'add' order)
>  */

This is garbage I forgot to delete after realizing there was missing
logic to make this simple proposal work in practice.

