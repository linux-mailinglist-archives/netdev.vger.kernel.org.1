Return-Path: <netdev+bounces-300959-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VQMIK+XFOGqIhwcAu9opvQ
	(envelope-from <netdev+bounces-300959-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 07:19:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE826ACB74
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 07:19:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=f72L3bcQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300959-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300959-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8606E30075D5
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 05:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90E425E469;
	Mon, 22 Jun 2026 05:19:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4C71096F
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 05:19:28 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782105570; cv=fail; b=dx+3TGYcSpTI6v/R/t5QQW7M+bdCFBrUg+9S9nNFoQiQxz+iEi3dkjYXN/V9r4UzTZjbbKI5I/Kfou87HnRQbMYzq21WMUUYAdkoHqRj3Bjp3WN9w8YUXH7xJFhyw3aukxtq9AYC2sTTGIQP90yie3beouJXwlR54ZvdlO3SbS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782105570; c=relaxed/simple;
	bh=rRI5SwufiPgOsAUo4qXobYdOb4QE3Bv+1FqeMmADkX8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d+eA7wYT9ncZKxTkWudu6AGJZ25j1loPAk9r/fAvE209SnQU8ZIY2oIkfEY7U6N5iCy1EquJ8YOXiVV6//q5TSXBO4QhKsX/hWb1GuuXIDuypW6fW7zvKe1olwy9tl0pAR8E1VkH4e0jrdyts5dMEpnpLb3xwkEkpj2VKEhyzh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f72L3bcQ; arc=fail smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782105569; x=1813641569;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rRI5SwufiPgOsAUo4qXobYdOb4QE3Bv+1FqeMmADkX8=;
  b=f72L3bcQphwPkaB6NP61a5KuAZuEbEb00VGVzhtYNvLjaEFU/kZRTUtv
   ADVrixHA3dNdoZUE1zBAMf0gGqb3x7OfJeKCWvNLeyiO5++ED1dV5VhgU
   o/QOuR79jkBMVjVmgNmcpNUn24ud2E9BP166g2WwfHcEM3pB+jc0Peg9H
   FjM1Li6x1Gz5fceEnWo/FukEZZhQ2W5edAv+TODyHYzzOvqMNTxlOMQS0
   IOHzDIu8uvIBPEqwk87CXzNi0t1lDopB5WKnhSCuzYA8PtzNKhFjtwQW2
   CuLgRWhXXpmhLldswolNsCR6Jhk9Ul7QAGOLNPIhvRmrI+pR8upObaPe5
   A==;
X-CSE-ConnectionGUID: ZklVVXX3QxagCPEJQVNuRQ==
X-CSE-MsgGUID: ZuKW7N1dQLKJqoU3Co1Ncw==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="83020809"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="83020809"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2026 22:19:28 -0700
X-CSE-ConnectionGUID: Bw1mt0VAT8W92RKccT8qjA==
X-CSE-MsgGUID: 3+2I/yaoS+ycaUDBwH2CRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="272829873"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2026 22:19:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 21 Jun 2026 22:19:27 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 21 Jun 2026 22:19:27 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.9) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 21 Jun 2026 22:19:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oIoM6vdvFhsty8wDzQGKNB3CJVdSxH+uUyVt5KTsQ2ffDhidx+KFhm9h8IaUaOXbJhjfMbqlogfRCmcnNInlL9PfJrfk5XuQJRAlwQnU+5obZ2PhAHoJEOjRyi6bPpd/Hmlxa5Gqkz4ZDrwb/Q0NaVhCcBXaZDnjHSEXE1flxOfkzE6Z1UMXhU322L8viLDsGrM2EsrKj1SPuAW4UaVpAYqX6qMU/uscSZB5gvnnTFzK7cZPd2DYRyg//MroVVV4lUtqruMQvA+fTWEqHaGqClE6vau32YVDRwN8HPy2D42ZF3w0m5zZ8XUgseKpVXjMZZKHaCJfnEYhVhezx8lThg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQHNxgblw6HnDVy1P+YxmW19YlNb2aaNrIU1bJNTLQU=;
 b=sorxxeZo3j2DfbVK4KLndo8ZCIKrNBh9pQngkOTFCczk1xaNahf8ydtRv7bUwgVW2IHqlJ39VZvUQ/sfbaby5/r210YCeJARaIa28gT4yW3D9lrdY41EnID26QYA9BsXM25ouMwp+H8BXXBEWExgBwINv4G+Pfb2w4SQag6Ief7kQV2eP+C6LkAQo6He81cgkc5bZSl4w/jKBJPesn0eOy67b0UYFvcFAln02MCdkZprELOLLmBITygkTFaptcOBC1cbhu9CmdtMMuXSeiPymyXeG/+rHZKRfmMjqNzIcjAMTqg7uISa9YoxfJNnlykNy0DmXQvOg4WzvX2RU/vQrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 SA1PR11MB8326.namprd11.prod.outlook.com (2603:10b6:806:379::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 05:19:24 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%4]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 05:19:24 +0000
Message-ID: <0ee0334c-c896-4e3a-b8c3-5ec740a88384@intel.com>
Date: Mon, 22 Jun 2026 10:49:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/drm_ras: Add drm_ras netlink error event
To: Raag Jadav <raag.jadav@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<netdev@vger.kernel.org>, <aravind.iddamsetty@linux.intel.com>,
	<anshuman.gupta@intel.com>, <rodrigo.vivi@intel.com>,
	<joonas.lahtinen@linux.intel.com>, <kuba@kernel.org>,
	<simona.vetter@ffwll.ch>, <airlied@gmail.com>, <pratik.bari@intel.com>,
	<joshua.santosh.ranjan@intel.com>, <ashwin.kumar.kulkarni@intel.com>,
	<shubham.kumar@intel.com>, <ravi.kishore.koppuravuri@intel.com>,
	<maarten.lankhorst@linux.intel.com>, <mallesh.koujalagi@intel.com>,
	<soham.purkait@intel.com>, Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
	Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
References: <20260611052144.784969-4-riana.tauro@intel.com>
 <20260611052144.784969-5-riana.tauro@intel.com>
 <ajPDFcp36k1mGcdB@black.igk.intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <ajPDFcp36k1mGcdB@black.igk.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0082.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d8::12) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|SA1PR11MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: 66e6fa53-c938-44d3-897a-08ded01dd28c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|22082099003|18002099003|4143699003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: rZeiC5O3/gmxo9/gJUC8GNX/dBGjUzJbH3qneHwRXkpSTG7MDdwBMBS13Z09tKV/PN+WLfBCb3AcfnYWuaElG4I1Pko6aG/ZiHZ0K4yZraile6pTHWuNxshmLmr00j+DPni4Y/3XZeRiQk4cmSyMo75co0exude/DWwd1Hyg6exEuZZFdAQKYDYsujXgdSkuRCzRMa6Yb4RurxL5add/euW2KujxvPxUPr4zIbPB7DzaHTN6uOkGs3oFoa21mxaAuXsGT/EzLHM4zlnS5YNRiGfneYLybaMJ5bgbhb0HlQVgTm6gzwgkCRYr7I0Ugqb3sXQ4brL4LQH12MXB221gfeCrISqnc+t6t4R6e7ShwzDiBu3Rqua7F8bzksXgsNervkLuhwPnYh1dNojpgfuUwyL3FJ54lFXXQ5ydFMZnUMflY7XK37iqpHmLGwc5tMa7ZbcYjNcYfwtaIAQRBtvdUhVgpD4Of0vCjQX6poC5dZbIJPz6JFhMp0UohbuaFOxGziOwdGoZTeNdmcWsZ9B0mod/3RtYnUZUcuQVohN5VSk1yf+NQKtBbOaG9XV2lz88vi4ht8U5STCWx7lvaSLZrh7iy4KYA25EpX41CrrXoe+GNBQLkc5+7lpJpPRD5Ep7HHrJfAZWYDZJCS9igosBnOxyYVtRidplQ2XlbNIE3Ws=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWFOcTRreGYwSTJkSGEyRnlTTVluTTZ4OVhNUnh6dWdjQTQwYm9IanJTeDNq?=
 =?utf-8?B?dTNjWWZnVTBnelhESnB2QW44bXg5U2pxdzNqeTZoVERZNWYzWFNubG1lMzBo?=
 =?utf-8?B?TFZLZGxzWkNuTEl2bDZweWtqVjF0Qm90RjZONG50Nmd5dHFxL2hNbG5TSkRD?=
 =?utf-8?B?YUg1dGlkSzFZMUpNQkxuTEl1a3pXU29qTHoxWEU5R1lpTE9UN2RldEZqRnhu?=
 =?utf-8?B?akhxd1c1ZnoxbDZjNmZvRURMQ0JEY0NMbXd6bWVPU09XWVZqMTA0VnFheFNC?=
 =?utf-8?B?V0tPMVZnek51RW1ONjJTWm9Odi9uS2hUN3RFbkwvN1J2bk54cGV4bmQyQnlL?=
 =?utf-8?B?dlNWaE1xRHhXb25nd2JzNitIVFlYS2YwdmF6Vk9VWEJBTXZidytrMmdDMGFr?=
 =?utf-8?B?blhIUXkraXNKcTFXNWpYaTFtOXlLbExOM2R3RmlUNnRvZjh4akVncWt6UWoz?=
 =?utf-8?B?V3RNNjd1dGpzR0dHY2liYWtQQkV4OXEzVE4vY3dQR1lISUpmK1grRlhDdWdh?=
 =?utf-8?B?SUNna2pOdDc3R1VvZ3J5SzYvZUt2Z21lVzZ4K3RxaXplZExTU2RsS0NFSENB?=
 =?utf-8?B?TWJUbGRKMTBjYTRQOUJJaG5EcWEwbUVOUlZmNEJmeTd6bVYvWk9iTksyVkdO?=
 =?utf-8?B?aDhycm8wR3JEdHFHb25LMVN2aWtRODZhOW5SellySXNoZGViTUszazg4Q0JK?=
 =?utf-8?B?dG0yLzUxbFBGTkZGNnIwNHY0NFNXRHlLR3RVSG9kVmZSTlRZZWpObXcyeGxP?=
 =?utf-8?B?MFFXdWVMemNNeSt0T1dPa05sUXFKOTZqOW9XYU1sQmV5TEtSSURlWW5KOXBW?=
 =?utf-8?B?dG9jams0ZHFGMmViQjNYaXh3ODR5MXpzcG5EMmRoZzUyVzJSQVU3bitSWkRS?=
 =?utf-8?B?S2E4aGlBeU5RS0dnVytvRnloY0ZscjZXclUxblFFaW5YeEU5dXQyUTYxeHJF?=
 =?utf-8?B?QW9hTjRGLzg1VUFFRW5EamVoaklVRTZyNXAvNjc4dFFzTkhkdUVxOSsvM2Rq?=
 =?utf-8?B?OUt4ZHF2SW0xLzVjY2cyc01XdFRqV1VDaWsvQkNSNEhManZCZittV3JYVlpm?=
 =?utf-8?B?dk1YTllvbkJQdDNRQnByTWVyQmowOUFSTEQ4NTFxQkdkWHFRSFRNZ2hjaENG?=
 =?utf-8?B?S1AwemRTcXk4UklTNlVBNllyR1ZWSHNlalRHZkFkSnoxWms4SHF1NC9vamh6?=
 =?utf-8?B?d0N1Z2kwVGRLQkNnUlhJY2RIc3QwY1I0bGRQdjYxVFFNbzVXM2xlM3N1ajNJ?=
 =?utf-8?B?TVRyUG9KcndVS1dJUlZXaXFlWW1WK3lGVzYxL0s0V2tWb2Q3eTdDOHF0OXVZ?=
 =?utf-8?B?cWNBOUNhY1BTdzk2bkFrb1pzeGkzRnY2N2dUS3JKZUd0RDdXYXBuZ3dRTjR6?=
 =?utf-8?B?TmNiblAvd2FvTCtSMURlMDZqYkhidXA2bm1PbzZpMDh3cTIvamFZeGtKRFVw?=
 =?utf-8?B?RDc4NzRnQ1Q5SlB2a3Nxa1FEblFycnVBVWcrWXJ3OHFKL1N4amJybHp3R2p6?=
 =?utf-8?B?WTFoM3lYV3N5ajVXRm10SlptaVF2Qk43Vy9sY3ltUjhsQkZQdVcySzdOajl4?=
 =?utf-8?B?R0V1NlpVbHhvejhheDVmWjNGbU9qU0tnUU1ZZkZMYnJGaXlHcS9jRUpHcUt6?=
 =?utf-8?B?Y09ncmkxdml4K0J6eVovbDlseW9XR0RtSFZiVVNJSzVZVmJUUkVJeG1pR0pj?=
 =?utf-8?B?RUIyWVZzOVJIcWVzK1RXMWJ4LzJrM083cXlzYUpVQ0ZBRFNOZ3hSVEZNQ1gz?=
 =?utf-8?B?NCtTLzhJWEZMMnZGZitHZEhtVEJCNllObVpNSVU2cUF5aGZ6WTdjWWJZbWZn?=
 =?utf-8?B?M3FEdW5xS3lJYkhpSzErcGlmOWh4VVhlRjQ0NnMwNENhenkxc2twekF3aDNR?=
 =?utf-8?B?S2RxQjN2MVBWbTlmeFFMbk5aTTVMWWFscXZyRWFrUCtrdkdsNjlEbWJ4eXpZ?=
 =?utf-8?B?U2FHbTZhVURWZEkxajJqUlNnQ2l3MzJtcERudFlxY3Ard3FnQm1OYmVncUZV?=
 =?utf-8?B?WUtESHNBSkVWTXVuWWt2YnJydUZ0RHpmUW5Td2lGejhlQWJvOGJOUHVUK3hh?=
 =?utf-8?B?UmtkUVovVFV1SndBQTNISnp1NjduL3IzRnpqb3VHbUp5VjdjU0xvc2pBS1J6?=
 =?utf-8?B?TmlXQ0kyWG5yZUhVaGtXT2ZmdXU3amtvVy9ENlpiTE1BMmhhSHdsMUt6bXh1?=
 =?utf-8?B?N3F4QmFzejlaTjBtakNRTndJYytwWGdkYk1GZVV2L3paMS9ZK1FaeE1FWmxu?=
 =?utf-8?B?cVFsRWJoM3JLZFhFcEJMYUhGNFJMblN5NHF2VVhVQWJGVXdGTzkzY0FZYnZp?=
 =?utf-8?B?TW1Zdi9OU1ZhYW00WXBveW8rMTJNTklDRExqUVlPdjl3dmd3ZXp6dz09?=
X-Exchange-RoutingPolicyChecked: m+XvyJQySjzLQB1ajJPlH/iROShkxHjDSbzO7cVfg3OgN6nImTY9Iat4OAmfAiwA7RESPsn7bfNhtK0ppmNyAvsIVB7zTwQvGTDRRlx8875NZ7vRE2yALDWNqM/ijxaH7HwHcq52PfY+47aUiawB4+xuVo6hVFrU5nsE1VtQaL9hzfG990XdlkTSrcsSAznHoytgRI7SgtRY5BqEIrQSIl3vUAGyDwkliByI7rv2FYljZWnnBjO2wYRXet6zBGYn2yEOyUQma6LWB80n5b8FFLkAz1prYgrknIrEAjlbGD/4VHoENy7NoYCY9GmlqQ0ZjjnC8OzbAYKXmO1uB6Kwdw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e6fa53-c938-44d3-897a-08ded01dd28c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 05:19:24.2740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6tPJCpqXe9Cfz7uWvhR4aBH+sIrCJpPU+QF4zPsRZMMrPKa2LAVP8mjJcUIlYYnQnah17HkVLs8rLbbpJf2NUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8326
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300959-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:raag.jadav@intel.com,m:intel-xe@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:netdev@vger.kernel.org,m:aravind.iddamsetty@linux.intel.com,m:anshuman.gupta@intel.com,m:rodrigo.vivi@intel.com,m:joonas.lahtinen@linux.intel.com,m:kuba@kernel.org,m:simona.vetter@ffwll.ch,m:airlied@gmail.com,m:pratik.bari@intel.com,m:joshua.santosh.ranjan@intel.com,m:ashwin.kumar.kulkarni@intel.com,m:shubham.kumar@intel.com,m:ravi.kishore.koppuravuri@intel.com,m:maarten.lankhorst@linux.intel.com,m:mallesh.koujalagi@intel.com,m:soham.purkait@intel.com,m:zachary.mckevitt@oss.qualcomm.com,m:lijo.lazar@amd.com,m:Hawking.Zhang@amd.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,linux.intel.com,intel.com,kernel.org,ffwll.ch,gmail.com,oss.qualcomm.com,amd.com,davemloft.net,redhat.com,google.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0BE826ACB74


On 18-06-2026 15:36, Raag Jadav wrote:
> On Thu, Jun 11, 2026 at 10:51:46AM +0530, Riana Tauro wrote:
>> Define a new netlink event 'error-event' and a new multicast group
>> 'error-notify' in drm_ras. Each event contains device name, node and
>> error information to identify the error triggering the event.
>>
>> Add drm_ras_nl_error_event() to trigger an event from the driver.
>> Userspace must subscribe to 'error-notify' to receive 'error-event'
>> notifications.
>>
>> Usage:
>>
>> $ sudo ynl --family drm_ras --subscribe error-notify
> ...
>
>>   operations:
>>     list:
>> @@ -124,3 +151,24 @@ operations:
>>         do:
>>           request:
>>             attributes: *id-attrs
>> +    -
>> +      name: error-event
>> +      doc: >-
>> +           Notify userspace of an error event.
>> +           The event includes the device, node and error information
>> +           of the error that triggered the event.
>> +      attribute-set: error-event-attrs
>> +      mcgrp: error-notify
> This looks much closer to "notify:" property, which IIUC it's not. Looking
> at some of the existing examples, a better name could be something like
> 'error-monitor' or 'error-report' to make it a bit distinguishable.

Yeah makes sense.  Will change the group name
Thank you for the review :)

Thanks
Riana

>
> Or perhaps it could be just me without the coffee :(
> so I'll leave it to you.
>
> Reviewed-by: Raag Jadav <raag.jadav@intel.com>
>
>> +      event:
>> +        attributes:
>> +          - device-name
>> +          - node-id
>> +          - node-name
>> +          - error-id
>> +          - error-name
>> +          - error-value
>> +
>> +mcast-groups:
>> +  list:
>> +    -
>> +      name: error-notify

