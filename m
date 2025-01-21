Return-Path: <netdev+bounces-160145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 309EEA18819
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 00:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7B87188502D
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 23:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826301EEA3C;
	Tue, 21 Jan 2025 23:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QCpWRko7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377701B6CF9;
	Tue, 21 Jan 2025 23:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737500564; cv=fail; b=VA8YCN2QMMOEDa61hQnofN/aMFSKlXdIwG1VdwGiY++o/wdvEEOa9b8QdhCy9AKU4Fn41CYF7yfjHxStfT8DxC14ru5iY8c52IuWFtEQZX6pH6fFxfXHTx6IzpLEnHY8Wf7CJj4D+eBoC6+J/6sflf8rTuIEU+8NC7MGTTgek30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737500564; c=relaxed/simple;
	bh=7iGysornuE6whB2nBl2su1gPVM3NxOd4WRisgFKyJ3c=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E8NmCeJT8LjRK5Ozwoi/gklKrcU/hUk2Hb65S5ghI0rIL8SaUcskRvuRZA0u0phlZ1MsPM3be1kfdebVgYQ0iuhhiJJ6QH/IAXLj4LBJnx+wWi36Hi7UvKpoZuA7g96kH481gPHKTKHEQWPb+aDCqxTt5H35S01zncFdlG4Xsxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QCpWRko7; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737500563; x=1769036563;
  h=date:from:to:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=7iGysornuE6whB2nBl2su1gPVM3NxOd4WRisgFKyJ3c=;
  b=QCpWRko7JS5nTsPgO4SAdRlMRaAo01OdVh5SoITo2u1EHGnX7ANiEDFK
   HGOj8dAnFGFx5afYbflhcYwQtnrXfG1qBFRhTkGMHcJnzl1YT0LH1lm+w
   2ykAR7qrjEpgFOR+MTqW1rU0RajUKW0OLQ5Z4zGajlnq7sapw1yFmd3v1
   pOawORIcfaWrvoZvcvQsvaiWM1875zZhSj+lTtksaEm7roQy3a3WcDfHH
   5XqOyeW/sT/EQ0JeXjOzuzwVvbu8c/ZkZKS7MIe7eYVmsJwiTbG3jJJmr
   QNOzQix6C111dNA5gC0qYTgOaKH8JR+GG4q1baaAMxc30FO0vp7tll0eu
   g==;
X-CSE-ConnectionGUID: q0ruO2QgRAGnKf2EVLzD6A==
X-CSE-MsgGUID: vj2Vn46cT6iYHB3uUOvXBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="37964677"
X-IronPort-AV: E=Sophos;i="6.13,223,1732608000"; 
   d="scan'208";a="37964677"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 15:02:42 -0800
X-CSE-ConnectionGUID: V3ddm+oZSwuC35/kUvHCZg==
X-CSE-MsgGUID: q6ChsLq8QL+oYBeWi6U8VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="106784958"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jan 2025 15:02:42 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 21 Jan 2025 15:02:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 21 Jan 2025 15:02:39 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 21 Jan 2025 15:02:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJJTGxxSqOoJetfXGGxH6Yzc5iiQBLCxpQ2myqQxCLqDdtNHESdoDVixllVxUvFQRqaTFgvmqIpNFP5cGxpLfJ63YMpwIX4wTGXH0RbDfWMqpi1Maf2PB9Dtb73D7SqzulY2SSb4lb2//L6COrIBL0q3PVMUoMvJDfN8wTRuXVtQreuh6sFlYSTe2QrJR9EhRSgyFhAX2B1dAJI7X/PoU/KeHAU79Iz0QXmRFTabz8dM+RhKND/QnQ9KBe06GCJMwMT7Bn/PtkXNl9eYandC9wiprNMT89NipVlBiEypsBKJFKgym+3LCX/DHN/L4Gaj4bL3ngdex//n6R1KAHcZww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ti6jtC44N7h1BTw8mNd0xZmaMtYHy/FvK0Ex9T1K6fc=;
 b=Izj9XnZB5NNI//nWjMYqJkVGVe7M9LIt3kjrfqO6n1ppn+NqXK40XOrU7mQziEHTN591hNpmBEGScP4Xd/szI69HHnghhwg4g7QI4IlJkAmqlS6nvjhCK8hTNAvrfJZrgd0HW+lvA6U1a1SjOXR/l3m+cqWVPRqQax5DTAZ7XpHcPIrZ4wLm2wDspFYtrqL9LEWBfThXE29fI8HhPVWcdwocTMmSOq1rGeSFlCukCaCKZJ2qbKv5SIcjf9aeBLbUaofylmRETzr9QUXCn1TP+A5fsh74QmiaIuzBKCzCiYDpt8l29s4YY2KjCs+/OgjvYydF0eRbG+FSyhhb9LTg/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB6865.namprd11.prod.outlook.com (2603:10b6:930:5f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.17; Tue, 21 Jan
 2025 23:01:56 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 23:01:56 +0000
Date: Tue, 21 Jan 2025 15:01:53 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <alejandro.lucero-palau@amd.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
Subject: Re: [PATCH v9 10/27] resource: harden resource_contains
Message-ID: <67902761a4869_20fa294c6@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-11-alejandro.lucero-palau@amd.com>
 <678b0c0ca40ca_20fa29484@dwillia2-xfh.jf.intel.com.notmuch>
 <fe48e2e9-5a13-78fe-d8f6-6c3faeecebcc@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe48e2e9-5a13-78fe-d8f6-6c3faeecebcc@amd.com>
X-ClientProxiedBy: MW4P223CA0028.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b591ce8-ed52-4c79-c08d-08dd3a6f9a91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?ckqXTh2oEJuHqj1F+X6kNkm69VDFiMXkA/NC5Ic2HHYDaZ6mTlCU8WW3cy?=
 =?iso-8859-1?Q?+Abkoi03ApSjKJLn/0WZNdq7IQQjYE4FbOlQzDZRhjgEN2j0mOsyDFPs4Q?=
 =?iso-8859-1?Q?aJZrpEhSPYIcFSlXPbjkb6xnBhAI95zNPJ+2u5WCEHOGpcqGDkL8vYefrc?=
 =?iso-8859-1?Q?dloJyS1zA7uZsM725+qLLSD2xwGRtjgS/CGY2NwF5sZi692ZPykvBTVyM0?=
 =?iso-8859-1?Q?POdJkmqhnadtc7GMjnXt7GjFDGEXEZUJfdCWO/UumUAMZu0wQc85IsV4TJ?=
 =?iso-8859-1?Q?lJSE0WQEtPnAQ2zG/tfx5tBOaJMfLV2xP0BcGTNAQ3qRCvtn5DcGBVCBFx?=
 =?iso-8859-1?Q?obyzi5ZTPHOvvJCSf93IrOOs5vNjHkdiY6583TBsB7NU5cagA8VjtbUvzc?=
 =?iso-8859-1?Q?1v09dLm5n2AoXF2gkagPlTscLSjhu2RmwdxKIZhoQMH05VhNVty901erjZ?=
 =?iso-8859-1?Q?pkAIs1GS9IGf/eK1wqs1VnMkhxzP9FuY9lc2sZV2PAe45hJyNfjWRxtJB4?=
 =?iso-8859-1?Q?Zar+teA7rN004u8tiPW+LjFA/YIgd4+b7oahr0HH7grRbXxmD7Uas6bbtJ?=
 =?iso-8859-1?Q?zCLmGVHfN4OridjZtD+Jm35IzN32p3M0OWPXc554LMb4jWgSzEF5LhOKbi?=
 =?iso-8859-1?Q?NXtnMS1YoY9XnD4Wib91qLi8BntuIXceF+hYJO4aG4CO4tyajQrCb2cYUA?=
 =?iso-8859-1?Q?lpS/Fv4BRYNUb1no6Qan0eCa3pthEZrmLeo43m9SWirBSBCe7Ddz6eU5Fc?=
 =?iso-8859-1?Q?FtpPnAABVzefjHriX0G0+6LH+o9VEg4EgUE4A5PSHs1jxnxZFskQ7vt+BY?=
 =?iso-8859-1?Q?/0ZH7widg45UINdYMWkQA0+AYL6dNEN90YCm+tyZBeyTYaHiDc04jgna4/?=
 =?iso-8859-1?Q?PNO6VUbkUhwvhQXjRgpy4B3UkJItHrEu27abjrxvhtNsicJYsfBnO1sIQ1?=
 =?iso-8859-1?Q?rxtZ3Mb6JZq3bA3xkGgjbry15PcNdGN8RvwZ1RrpqQNemwUu+79pgmmucR?=
 =?iso-8859-1?Q?9ZjDHKwyGy67oecvvVU/X1XhzoqklwCJ3+7VGUpnz0veLGqzSIygvinPbT?=
 =?iso-8859-1?Q?yPwpzdIXnxqZEfidMEUYiynQonw6dbouyz115hMCP0qrhwGVH8CA53ZQ6l?=
 =?iso-8859-1?Q?/Z3CakBaHkNBpnhvxrPkJYPaj6VR7NycvFYyw97B5A5T2tpHZrydvYW+gm?=
 =?iso-8859-1?Q?BkX+QBYdUAzljJEwNheiyGG+UOrCuqzlZewIKsqja2Zc1I2BYg3NabFtE7?=
 =?iso-8859-1?Q?sNinCoz6FpNGZ2UGaVg+1dlNv98fKI47GI3qcVpD2ern5Pr/+n4FRiMuHW?=
 =?iso-8859-1?Q?NCQXTH4eMryNYpRYYfa7O6MrM8QLlYVrJVGWTJZY7qyuHTdc0aBy5jfNGD?=
 =?iso-8859-1?Q?co7RTe+I4quVCYn3b/Kvkf6VhwzUdRLWCPwtwua7Ki7/kGreaS0wpENaoI?=
 =?iso-8859-1?Q?xZrgGwee15T9NS7J46SbITru+IlAqpqadofQ2ho9f/ov0/NHVaw4dP/BwH?=
 =?iso-8859-1?Q?A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?OPAC42jExKSMee+MnBQhiSIKx9KObvhzjpPa+cjd70dqokZGngGcIU5N29?=
 =?iso-8859-1?Q?HlcqKcKHOdcUyWI/XbhcwCxtuYa6A/2U3shcKGOIduDxCXeLRrTeI8bleo?=
 =?iso-8859-1?Q?pFrLTQ1qh8CkUoH8kwaUKAlYAZQc2eYB+kDfmzy97Cm5/X1O8LTRDhAsbA?=
 =?iso-8859-1?Q?JmkJk4zNnLgikt2lpj1Cw8HH56d4gNpWQjdSOehhyuinlDBwr+7XOCWFl6?=
 =?iso-8859-1?Q?YbdBNhKrvNco+KG7kwgkZ/fYDBiYpt3SiJKIQhDhelblafRIco5TsTd6r1?=
 =?iso-8859-1?Q?WZ2RCI5E+2Jijvu12KS7/hOLB3brxvlgr+vHl3wRznxG4ii7nsbX5g4ck3?=
 =?iso-8859-1?Q?Z3xSrreKhyrQKQZclCh8pgomPqBrkD9tFdknqfzXwY1Cxv0D/5GE69X/6p?=
 =?iso-8859-1?Q?E37lmsbpI6FG8MnAcSCxzqN+kDRurusFT5zqGtV48rJjMW7w/wsh28PS6j?=
 =?iso-8859-1?Q?9+WMYH9IuQbKL3gKm690LV5wtIbotYOBDzyT8WM53X5l1/rEh2YO5eBBtX?=
 =?iso-8859-1?Q?91Bfp0h1LJGgyybhRuFnupIKJ+cxz98PmMms96kvS1fVljMl4ZlwZZb7IK?=
 =?iso-8859-1?Q?O9BISdmfIJGpQ9oU2tLMBHbnPutnYXrZO7sz4808GBDVUpHNvz7FCv6v/U?=
 =?iso-8859-1?Q?vzWSyTG5Qk0GvblGUzy8ino9Pj0ucY7le6cfyHacFzZ4EfI9DBskoZhP12?=
 =?iso-8859-1?Q?69ArBGOOeySyBSLjuE+L1yr5nkQfk0I3M0dkGuGzU8JFRjqtSAYKvm5hRk?=
 =?iso-8859-1?Q?d+HzQzFJVoXnCRt5CC1soo5nGjQjyj+6TemSdo667ADrbc5CMSkG3whlv4?=
 =?iso-8859-1?Q?SseEsSeyorX0ymzumy8mfppCNJe0I/JyJKaDQPVJHOxPdQzSWnImwsK+LY?=
 =?iso-8859-1?Q?gvemHWPqOXne8w2XNsWfjcIquMvpZ8wVGcI8e1Gx0/mJ9CtpEPDCQ97KpD?=
 =?iso-8859-1?Q?3EQRPgPdON/sfKFTlCbFsip8zLxO/9rcjV1RHONbnHGSPFJsdZDXYIyzc5?=
 =?iso-8859-1?Q?AWrs+FfWltyeQoTAykBRYDhe+FJHfk1SujqZy+vmhctD1LXwuzEjyAzTJx?=
 =?iso-8859-1?Q?RzWXflwkCu/EJ4eJyJPrgaAxUYTwJ7p9ambT7WXQyu5XpiQ/NutkPS+IYF?=
 =?iso-8859-1?Q?qXfQWcNmJF0fOQGHHo9eJCM9ZxEMl2HdM3LpfHF2tJos/OukTyiJt5RxJN?=
 =?iso-8859-1?Q?KP3GPPYcjo+p24WvZkKnjrt5dMk0CTqk5K4tkRjpzxYm+IMVae6tX5mFBU?=
 =?iso-8859-1?Q?RfD0J3yo6i59HYkJauUDqBc2LjWXnXcNJzZXxWMrgCB4CBBM4gHvra1VPN?=
 =?iso-8859-1?Q?emPSuK+dTWqfWUfpGLc28Gi6/YBljaFZ6/bmhqVC20r4LtP+XTdvu7U6xS?=
 =?iso-8859-1?Q?Xg4wHxEw3Fe8qakIIIrn5Bjb6xuv7zbiP11JDdyk839iZOcyAs/iGy6PZ+?=
 =?iso-8859-1?Q?00EhLqJrYhRgwCXBCZI2Vtu0hbYFNtxFZkj/b+vhCV22aPpKvi0Fpbcu2m?=
 =?iso-8859-1?Q?7QUBLxriuAYlbvIKo5GjU0359kDOBnrptjfXUhDMqGxGkp3LzeqZL6PGl9?=
 =?iso-8859-1?Q?BQ/hxN26kLpQC+Cr2GbWi2lMPjTI61+vXUL3ZUCPytUzDDgpyi5wPnYXvQ?=
 =?iso-8859-1?Q?FE2jlJG/34rt44kbnYkRM4dq/tcBAUZIH1u50wfOEL4eykKJmfoTsYIg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b591ce8-ed52-4c79-c08d-08dd3a6f9a91
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 23:01:56.6836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +OmdbrFDRznm2uvbibhgLlehMSok8LSY8Yaoy/U6CfMaikl1xI7n7YZ6wrPGJHxsr3uxdsUUts5iIFpB/aTuyRNfx+aOEX1PiRUZeFuv7X0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6865
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
> 
> On 1/18/25 02:03, Dan Williams wrote:
> > alejandro.lucero-palau@ wrote:
> >> From: Alejandro Lucero <alucerop@amd.com>
> >>
> >> While resource_contains checks for IORESOURCE_UNSET flag for the
> >> resources given, if r1 was initialized with 0 size, the function
> >> returns a false positive. This is so because resource start and
> >> end fields are unsigned with end initialised to size - 1 by current
> >> resource macros.
> >>
> >> Make the function to check for the resource size for both resources
> >> since r2 with size 0 should not be considered as valid for the function
> >> purpose.
> >>
> >> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> >> Suggested-by: Alison Schofield <alison.schofield@intel.com>
> >> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> >> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> >> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >> ---
> >>   include/linux/ioport.h | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> >> index 5385349f0b8a..7ba31a222536 100644
> >> --- a/include/linux/ioport.h
> >> +++ b/include/linux/ioport.h
> >> @@ -296,6 +296,8 @@ static inline unsigned long resource_ext_type(const struct resource *res)
> >>   /* True iff r1 completely contains r2 */
> >>   static inline bool resource_contains(const struct resource *r1, const struct resource *r2)
> >>   {
> >> +	if (!resource_size(r1) || !resource_size(r2))
> >> +		return false;
> > I just worry that some code paths expect the opposite, that it is ok to
> > pass zero size resources and get a true result.
> 
> 
> That is an interesting point, I would say close to philosophic 
> arguments. I guess you mean the zero size resource being the one that is 
> contained inside the non-zero one, because the other option is making my 
> vision blurry. In fact, even that one makes me feel trapped in a 
> window-less room, in summer, with a bunch of economists, I mean 
> philosophers, and my phone without signal for emergency calls.

The regression risk is not philosophic relative to how long this
function has returned 'true' for the size == 0 case.

> But maybe it is just  my lack of understanding and there exists a good 
> reason for this possibility.

Questions like the following are good to answer when changing long
standing behavior:

Did you look at any other resource_contains() user to get a sense of
that regression risk?

Is the benefit to changing this higher than that risk?

Would it be better to just document the expectation that the caller
should only pass non-zero sized resources to this function?

