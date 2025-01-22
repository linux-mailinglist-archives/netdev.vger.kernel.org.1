Return-Path: <netdev+bounces-160433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 849C3A19B84
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 00:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF1C8168BEE
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 23:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306551C6889;
	Wed, 22 Jan 2025 23:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mAi9fJHf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC681CCEED;
	Wed, 22 Jan 2025 23:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737588900; cv=fail; b=t5+QN/8JHVTUgv3f8l/hZ1N8l3ZPz87d/Uy8TLK6ovY0cSs5mM7neh+ZsbFlvIb8lFOnc/UM98nUktQ2b7pLUljzcazA4EN7uSK1GRza69RHjA4SASmnrN9u7LjuUp5O+7Yfc/h41vbiPt8aKA8qEvCXIwYTaclvd/evIC7rmW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737588900; c=relaxed/simple;
	bh=rUD72P/I+xl/yJF0ihFMTZfzqljyvKqYeiBsur3D1Sg=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oujJqmF9Lqe6tCm1KwTxROlzWsupCpTa9LZqgudjfPfJ5gJBWuobtFJFg5oxURsC/JaPg/ec2pX7NWq5SNBC9YhCXb47RHFT5r+ufJuK/E9RTmn87xLc52/svkVxuibYPX5oSiP1U7+ZZVqvthzsid5c9gPIRgijxJQmuj4x4GE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mAi9fJHf; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737588898; x=1769124898;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=rUD72P/I+xl/yJF0ihFMTZfzqljyvKqYeiBsur3D1Sg=;
  b=mAi9fJHf9Zx9ARi+NP8lk906Vv9yZkSokA2ZhZc18Yo4r7/cZebH8n8a
   FO7hDMtY8ciKB42g80cMajX20/isrh8DyCQkgQKRSU26RGzskByNsKIVD
   r+Ay6vLOv9pzdSTrd18HFYOYuw7WyCI2cLZ4h2+LC/VRZ8YABo6ghQiGx
   BXeMEIPHe+j4oceCFYjh/L192S+kelSY0LK4S/wnbqp5fD4v8H2hJcpz2
   hQz9mcCiYkZQnjxqq00bDyiAyExTzNs4HgfEuPjjVTVYRR3iKUGvWb9m/
   FPmH9DwPL2cNA1NqZXL/WosiJUO7rQiT37dbJN2/Qv+YvkYxJZlm/2XKQ
   A==;
X-CSE-ConnectionGUID: 6ybysi8cQmSdgY+yjFTVbw==
X-CSE-MsgGUID: zMF/0EoWRdmXuZ7Vj38dwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="37955957"
X-IronPort-AV: E=Sophos;i="6.13,226,1732608000"; 
   d="scan'208";a="37955957"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 15:34:58 -0800
X-CSE-ConnectionGUID: 3XGzrCCaSlaorfA4HWSZQQ==
X-CSE-MsgGUID: QssJ9wzVRFOVPIxF9b/qXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,226,1732608000"; 
   d="scan'208";a="107832561"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2025 15:34:57 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 22 Jan 2025 15:34:57 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 22 Jan 2025 15:34:57 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 22 Jan 2025 15:34:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KygVxZZGYoUybJg5RxvKGw0eFU9dZ6F9dzGTSEIufwQM+55GBga8FfuqcSNoYvfdutT4wdji/M2ziGtZVZ/sSjaMOyM2LEcB7d/2Qt5z/WL/CM1DlWYXlfr8qGqd45kJtlqT732FkI9v640Ew1F9o2YLCMe6/WJLd1AVYMwO0yIZTsG4jUhJ0x/tJ7+gWZrLRLFs4hY+cTe9tXiYJqHFbSqVGyrhavn7vOV9MV8oiD2YB8T2h9L9KMaOqs7t8PPYwYiIz0CcFjXG/higI0pxED30YOuxIemgW6yXzBY2O56yCzcnHmoLFlYAd7NOWQrIcgBeXYSBOgRDzyGw4N6kYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDLKtj+oX0QJNKVG2CXnw9AIUMyV6ZRCUTScrn4QIrs=;
 b=a7VQDby5A4suWZEIQQ6jSD/N1zvsk7YU1hH4oXAdtmdBwCkR6l2cbUGBOlbcH/Hmsynp/iWTl6bDYx5h11XcaOKPKXAtZYssILcBMfioq788LxGeuYXYTU2vnzNfN5nbUb45Ad0U9RO/QpDBZoWOdfk36aI/b+vksjYp49W8ZXM5nXCqZsOQXuEiKFB8nFBA40DSl5DNfusXJQQzTehnSxKbtsy7BYmu0LdbbU+imsHq0+0WyqDtNd8pjxOQUjZWRdtYNxiP0790fKMdT2vp7f8R0+gqCdwODk8IlVL5CAZX8JUKP5Qsu86O8VDKmhTjEwG7rZxpVtb1eLuPnGhWWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB5123.namprd11.prod.outlook.com (2603:10b6:303:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Wed, 22 Jan
 2025 23:34:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 23:34:54 +0000
Date: Wed, 22 Jan 2025 15:34:51 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <alejandro.lucero-palau@amd.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
Subject: Re: [PATCH v9 06/27] cxl: add function for type2 cxl regs setup
Message-ID: <6791809bdbdce_20fa29452@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-7-alejandro.lucero-palau@amd.com>
 <678b092428a86_20fa29462@dwillia2-xfh.jf.intel.com.notmuch>
 <0063f9c6-9263-bc4a-c159-41f9df236a7c@amd.com>
 <679024f84230f_20fa29478@dwillia2-xfh.jf.intel.com.notmuch>
 <314eb564-6366-b94e-ed46-98224d14417e@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <314eb564-6366-b94e-ed46-98224d14417e@amd.com>
X-ClientProxiedBy: MW4P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB5123:EE_
X-MS-Office365-Filtering-Correlation-Id: bb0d0562-b814-47f9-b4d1-08dd3b3d5fbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3dgmiPKE73JzYH9i1F8nZuWEL64fAzEQGexOv+dDoxFUHDwPuaMxwDRPtPHS?=
 =?us-ascii?Q?8aOtdUqtGcv6wONnWtsFQ/sJ9JnQ3RmkKyCKn5msRajyd0/mFnObaX+5uS93?=
 =?us-ascii?Q?UJ2NFYc0luvOBh1T5EJ/27L5Bcn8gnG/eVp0y+8owHFlN+E+kw4eiJdCGBkJ?=
 =?us-ascii?Q?+hmx6EXKrlTTsmWyfNmzJyiqS1R0J3n+NIWASfdX2I7IGe+NLrXUfTRqW6UC?=
 =?us-ascii?Q?4F4irvk3kxKnjGkNfn3isAfBDfIPyzORhOUIZQ7/5q78oopLp1r1HDPl3O6v?=
 =?us-ascii?Q?xCGxQt3pfqyIGMp1XgnmjeYrVB6xSmiRhldY4KmXhX1ven9sRfvZIeixP3iL?=
 =?us-ascii?Q?kdohKcQ6DNY0Hh8FeITL2u7Eg7JU9IpNHqFqdt/6jckeJ9N4AOaKVCs0Zumn?=
 =?us-ascii?Q?asMqjafy9yg4xLDdDfFCBQocwJk3bs1m7moYS/7SmIiqCUMD/l8tHGyDGK54?=
 =?us-ascii?Q?b14VuVl5rMbRo6L0IzDBmmROcjJFMPBnHRf2gcTHH4EHp3z2KUaMFvGVDAMo?=
 =?us-ascii?Q?7ihYdTFfpKt9iOgh+7uWdtQFOHyPe4Ik1Cui/AdwOjkolrXXWXB2OE2xlPNH?=
 =?us-ascii?Q?aymLEf7OJMCiPKsreHOV04/kPhPWUdYT2f+G6nAHlfqSi5RuDxMUL6DLbf4h?=
 =?us-ascii?Q?Iz999LnoxJqN7iDEJo61fyncETXwT47JArqj1Qr8ty/1apM3t3wYt8xNjHTl?=
 =?us-ascii?Q?c+zU3ZRTUq9eV+BMdMAgeOxiUN6u0mNTvQFA3hpe8IYoL4m1S1qAONrLVh/B?=
 =?us-ascii?Q?wGjghQLiCNe4Q0g0voBqfa+aiwaTPVy2IA+PuS7erycXd2J8d9eNeKOIusY1?=
 =?us-ascii?Q?4D468poF7s/yBfG5S36WRobVb2Mfc/t/kXCk5sgMYVpiioNtjm5KK57JYS5F?=
 =?us-ascii?Q?F0eqdSj0Hq0z06ynJ31x1p08Z7ClKj4LC1OUgbTe6f9L6G92iDlNOUhLx5L0?=
 =?us-ascii?Q?zRczkIL4MwZ9j8lNmn3lBzwOC+hwsEYQj8zPQ7xJRD5a8kpoOmNxvzPWYWQe?=
 =?us-ascii?Q?o2TgD9nRZ/XnT5wbmxsZANjx1zCzAtPGPfuHK712HRqpuWPSQoGKLY3mQ2wW?=
 =?us-ascii?Q?ZxriupaAJPvQUUrJo8gJwKQFyyIV8rOzzxY1/oWUPrL1oxI4vSMwVsA+OXeX?=
 =?us-ascii?Q?0O9DHOE+oHgnw9BPnjwIt4p0CX8yj8+FG7TMo56vg42Mj+EqqessYgwElwJY?=
 =?us-ascii?Q?wdJG7PTk73alI9ENOd4TkTSfrNQtpIsKF59aHJlP8mbh+vUqwdKW21HOfl8u?=
 =?us-ascii?Q?dWSNRoXky14NUNdXspYalkW2YZULbksClpoXzWGY85k15fmddb4mvtoMxZrJ?=
 =?us-ascii?Q?r51/M5APJJdy2+KuoqjqTOE18gSuX3Ujso1fGfDwUxQaeZiQ3qkfWP+X2qdl?=
 =?us-ascii?Q?d2CCUZEiHxhhZYZ9frqDhETaVBFCpm0zCUpnaGsinnzJPe2S5hLEhCzuL6vj?=
 =?us-ascii?Q?kPe23LNBoE0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1IlMRAi9sJPzK6qheofjPMGYgmM+MKKcr7azTTBg5EgqcpNhSbkrbMmFqNLE?=
 =?us-ascii?Q?4ENm6FrAgvppOiHbBun3Mc6sc1kx9XNakPOmXUzDlfKNzFJi2fyQXJOLCOuR?=
 =?us-ascii?Q?pO9C7UiDWPMUWbwKly/SSZwylNUv7sM1eg+lgB74dAy3jqDkKsRDA8sl8tcn?=
 =?us-ascii?Q?rs27xNnothv5dRbn1/4oNdtGQn74ZCKrDtPZ4IkowosNLjOfRQfF7xEQ+0y9?=
 =?us-ascii?Q?QrCSXg2jD7t44TVOjzGmie5fX9/G2vLAcIebUJ62Xu5vabdq/G0NJ4usXHPQ?=
 =?us-ascii?Q?EdrgHAoFKTs8gDZH1Ek0XZqegoyUrPLnm6vZCSmhDr1zCO0+2BtUOh/9ik9a?=
 =?us-ascii?Q?y7UTIsAUzZsPkUu7uXNoutbOm9DnUbiARETtS203GQaHNeLvIrEBf6rybdJr?=
 =?us-ascii?Q?UgWKWEURoK7IRoxOF3twMEz6dgUMBmiDSaBJoDs1E6kmC0HOTo4jlVU5EPM1?=
 =?us-ascii?Q?biTuy5qkGycHFBjL5R/TNJUl7cY5uYmg8HZxFS7xXfQEN1Evcipjpgvi8q4a?=
 =?us-ascii?Q?FhecTg+JmyH7dRjsHRb/EE/ecXs8+NZvGvj6mBoXUcGQ7231nrnNaDvSmDcj?=
 =?us-ascii?Q?6quVZbcpACtsByXE/RCCMFSlx8tRP+6LMiTeb/ri8UVMzDBmEXc2V7bYi7SG?=
 =?us-ascii?Q?7i19offKGR1D9x+RgXNiX+TADrpkk8QhSRX512l113AiX4IsCNH0NrTdqIrz?=
 =?us-ascii?Q?JX1YSkSAkIfOj5ZrdUy+8VdEyAHGKYK2k6ddZaw8UUYYyYeUxXpZMqS1VGcp?=
 =?us-ascii?Q?hGbRlG/TVmNr7zoor2yncwhQ8Ud75tClDiLGa3sNB2lvKCpioCtwB7MgPLwT?=
 =?us-ascii?Q?FDcyFTmYcFv1Ae5jAi+pU9Ykf8w+0sqRAtV2uXsckHSlAXPcskCT0iGXp4T9?=
 =?us-ascii?Q?lclT12XWKM7RL8bmSWxYFbyGS9x0X4bh4FpGASKXgBR7XVzqUO4hMCXQEEy5?=
 =?us-ascii?Q?alHVVBIFB+OhJVCKlES1u1n87kW1yv1aCm/U8nQBInkQIlxEluXa2ieYKDuM?=
 =?us-ascii?Q?sjsL+TKPf8hbqZ3q4qYjZiwl8pCFgmYhgSVtG2L7vq/vd/OBJGA7X8sgSG0j?=
 =?us-ascii?Q?291pb7HgzphfcbXUXFkHy/D0tAPXiRM8uNf4YZnW89uFT+2LAJncIUCIhgmQ?=
 =?us-ascii?Q?XIcRUUJY6VA+i8E4hza8v9g8kx9MGr+JmNrXRV3uwxU4Ym1ogNg9UeRHre3V?=
 =?us-ascii?Q?KjYK+8bc6iTKiUkh9KsLfPieKnYIuJk+dTFYlnTT+4cXX22kivDIPYb2AmbS?=
 =?us-ascii?Q?p2Xqi5Z8sQBMdCKMQAiPVmB8pUCiJk0B1ih6A/hcR3omsijQoLevLXMvAPW7?=
 =?us-ascii?Q?6bxu4g9brHqoWkYUBtDPpzSfoIV2MbkUd1nd3IyuAA1h5jXxuoyA7rRxnN2b?=
 =?us-ascii?Q?DiN4c5o/c5btrNhatUP+BKDSo2GJAyHEtZcC5F30U1Rr3JUUge80WeRNofeZ?=
 =?us-ascii?Q?RXuN8z53y3TidhIr0gTrFLZGksmFFNKa6tKC38w9ozgk+zITn0CkCfbw1AGL?=
 =?us-ascii?Q?cO9ReNq/NzHMLRLthIQ9xnPBmSzuhBqtB+uUIKW1s4OJ/H6al7RmPeW8QHeS?=
 =?us-ascii?Q?6/Dase4Pz3RMePLTKGOMCIiVQoYTN9GvRMWLditdnqXxD7+aPZSj84V8Cp6z?=
 =?us-ascii?Q?ow=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0d0562-b814-47f9-b4d1-08dd3b3d5fbc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 23:34:54.3165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6YtFHQcZYKVhCjS1/wMCdIQEgukvtiu2poxRQbENVvaUmVZTgRmzBKBwgdEGr8UOcAt+WhuENCY3OMj/sK+ES1mqtaDHEM13CV92haBifzQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5123
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
[..]
> > Apologies for that, I had not looked at the implications of that general
> > decision until now, but the result is going in the wrong direction from
> > what it is doing to the core.
> 
> After yesterday's meeting listening to Jonathan and you discussing last 
> reviews, what I thought was mainly related to this patchset, I was not 
> sure I had to address this concern, but it is clear now.
> 
> I'm a bit disappointed this requiring new design after so many cycles 
> and about something I thought it was set and consensus existed.

That is valid frustration, and there was indeed long silence on this
patchset from me until recently.

> Anyway, I'll work on that, not sure yet what I should change and what 
> should stay, because the main reason for the current design of an accel 
> driver API does not exist anymore.

Yes, I think this was the main disconnect. The CXL core is a library,
the expander use case is supported by a class code, the accelerator use
case is an a la carte subset plus some disjoint bits. The library should
be use case agnostic.

That means that accelerator specific exports should be avoided
especially when they are just wrapping other existing library exports.
Push the use case specific concerns to the leaf drivers.

Another way to put it is that new exports from drivers/cxl/ and core
data structure touches will receive higher scrutiny, because that is new
maintenance burden on the core.

> I need time for figuring out the work to do, so DCD should take priority 
> now for trying to merge it with 6.14.

This is all a bit too late unfortunately and I do not want to pressure
Dave to explain to Linus why patches are still flowing into the CXL tree
during the merge window.

Lets get this wrapped up and in cxl.next early in the v6.15 cycle.

