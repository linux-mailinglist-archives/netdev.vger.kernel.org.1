Return-Path: <netdev+bounces-158303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D7FA115CA
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 01:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 502E97A1040
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 23:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BCA214205;
	Tue, 14 Jan 2025 23:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VwTQIUy8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA922144BF;
	Tue, 14 Jan 2025 23:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736899197; cv=fail; b=g6lI8h4bWvS4McwaK80NOm8vTk3yzVlfQJDGpiwUDjEH4ZwHa8ammwsru5zaVzWBd+QaI2Ap10XMB4gdlaSoLgK/0DcDUTbqg8LJ42ibVOZb8d5g51eZi3LNRTxg9akEaHXJcKRF7Ays4kAxr7S2qXYGpXBXQ0QfJXtv+FT1Tfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736899197; c=relaxed/simple;
	bh=fAKrzenECiywf8tAMqHBIrcC++f5/TxZeYeUUMi0JeU=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jWl7IxV6N08vAB3anP+dYgUMh+otULYmF/Klu53urwP9od6SuCUffOiQHe8WDIyP6M0vgpGCmA8jmqTUoTWzjR6s52AiRNVodBA4IjTSjCwY2v+c6wGuvZ1yyI5HiBbaU1f10ibOBrn1nnbu2/fcsuKzRZ+AOGwRwwoPAvsta8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VwTQIUy8; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736899195; x=1768435195;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=fAKrzenECiywf8tAMqHBIrcC++f5/TxZeYeUUMi0JeU=;
  b=VwTQIUy8OdFmcGE8xEPDnFk1MNXMLVSICKGhS4TGUMzMJwsomxcrXBVb
   A43FSl8qZHTyPJIoqOa+SyyZrwpg43DpnlgCOc8p1RkGGUhVb9AlIHEL7
   EBvrotibAeF6CTkxK2pxF0EGkNQQmIW+dxjbp4uk01mUF/7GJhZAeAs6j
   huKOad0JVkZYW1bv0nUBgFWkzIDVZNUIH/lq4vNEn/q3VWKk1ouPiK/IE
   rL+vm4/ong7hFIU0MMOZV/WYEB7FYO5edzATrPhOEBhm3iDduNJGLa781
   T8XPsHV3aD3brDkgRQFWm9hYwuV1z9X/D75mhpcEbuMBCywY2Xb05X1rF
   w==;
X-CSE-ConnectionGUID: /mjUXJMWTcK41qLEm2AlXQ==
X-CSE-MsgGUID: jMT+UjibQtSUra/AewvAAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="37133467"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="37133467"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 15:59:55 -0800
X-CSE-ConnectionGUID: 7Hk7kA7BRAC+75coeltncw==
X-CSE-MsgGUID: GDX+nd/hTVa+ezVAlx86Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="109916295"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jan 2025 15:59:54 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 14 Jan 2025 15:59:54 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 14 Jan 2025 15:59:54 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 14 Jan 2025 15:59:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOX+JF4+2DXHg34nVvosJkKFq4/ye5jmdujrNIFy+if2XjFh01B2NMfgXbr3tsnYCgnNot14XMY5QB4m9YMGLE0bS1N0MR+fP+FjiqJwaGmN2QsTQtQZjNKY4TgSlFIHLWKHW/NE6QQes0ytGhfFfk+AeoFrRkxCF2FBcxFQnCf53cDfi/4DVF0xCe2yp+8X1x2baRHJ/obu4LsJVl1XbjuJNE+OZTCw1RKt5sZBKPtfiWZO0c6JpqykFNt4MqUPbiKLMErhzFr00oZZuIze3XZhQ83Dax8+Lc8G+TL3cXG75QY3/RfTHPEbri6WeaAV4AfRu4SapxNQQTldWAblgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhu5+DC7b0Dqxd8GErcWAelYaLOgxIt5OVgHy41cctQ=;
 b=ZtIryUZtPhBVaD3I2H7O9cRVYrvyz/tNax1bqX6+4wLHLNgd8Z2jAO+9ZnjkmHaPNaWmEe+wH9Me3bLknYstYLq8QfYQLhu0Lfjlof4rXBINUH2DBqM+kACxmjC+9aKk9apcQM8iyNPwwN5a2Lnf1X3kiFAMAfnOoErOYd6acH3p5r7AI7VR7e0JJ3+upWiRcv7kSFpPPHfTrV4EoHvnuwaboMKM7KkXhYZ9aPIDGYfSaGZ8FPASgpC8SF2ISXvV59wj2/Wsnz+foCI6Tls8YShMsn/pF69fmyfqVGohMBrokruh/Mn5r5QpQxXhJsIUkZowdfaY7dZQdBOcj6u/cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB7908.namprd11.prod.outlook.com (2603:10b6:8:ea::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.18; Tue, 14 Jan 2025 23:59:51 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8356.010; Tue, 14 Jan 2025
 23:59:51 +0000
Date: Tue, 14 Jan 2025 15:59:48 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <alejandro.lucero-palau@amd.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
Subject: Re: [PATCH v8 02/27] sfc: add cxl support using new CXL API
Message-ID: <6786fa74bb11d_20f329479@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-3-alejandro.lucero-palau@amd.com>
 <677ddb432dafe_2aff429488@dwillia2-xfh.jf.intel.com.notmuch>
 <61d4932d-7e8e-c8d0-d782-8b15c9d86714@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <61d4932d-7e8e-c8d0-d782-8b15c9d86714@amd.com>
X-ClientProxiedBy: MW4PR04CA0346.namprd04.prod.outlook.com
 (2603:10b6:303:8a::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB7908:EE_
X-MS-Office365-Filtering-Correlation-Id: 73270b7f-f284-4cb0-9c95-08dd34f788c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jKVmZHrSadIOHuHq04XcZlfkDk5YjfiGbUuownXFTguSUa0V1d79CiE5gMNJ?=
 =?us-ascii?Q?3iDJi6nORi7vFyCKlv/9P0gIMA+aaeb+POiYtZOuP3EHwpSwpsQzobGKgbAQ?=
 =?us-ascii?Q?WXP7w96DQ1RIFRE7CqqE8zphbkBml64Oh2RO+dzkhOVabFwBUw1hbYHdKTgj?=
 =?us-ascii?Q?XW7jPMzvXmH6rEmnqz1ysR512jekKvbwGlxES6qtbEzbglyZhKHCI8ah4WTe?=
 =?us-ascii?Q?uqIrPtHn/lvNq84+dquVknmm8+02E31U+NwrkG3diQ2mZ3ZdfOkAapwxBXBr?=
 =?us-ascii?Q?wFjpkqnA9xvwVfPYinVRpuILTcDTYDtXw98tir6uA/fh/fEESBVKgwlK6ndR?=
 =?us-ascii?Q?qQ7ROIOWiO/1gyYVGuOfvn95l5QNWKHVepW/RuMyWyPYVYGpsfMwNmUPyoob?=
 =?us-ascii?Q?ZsygU0cNopMybBuFSQ1KC4/NILPvzPguxzyMcFZyHZSElEFZh8f4NQfORExb?=
 =?us-ascii?Q?Ajnu10LMPD0YCqqbz1rOuAHwY6zrQqMWafYnriZw9boRhL4ee+qm7CTCAsI1?=
 =?us-ascii?Q?SvBfvjrgbnc8De9FYzAvtT41CWLBWsDRKQjby1BXFWSKhC+lAN7P3AB7tM3z?=
 =?us-ascii?Q?O6sE5ccby6k1DeEDKDTYELW1cWJyVnj0B3MmexkMZsPUZQYEyuaiiX+vRuRg?=
 =?us-ascii?Q?WYeV1qqN9HXCr9H2/7logteYO6seNNyB5OrJzE9r8kr4UqIq8+MW4zG2ldet?=
 =?us-ascii?Q?/+qJhghvCFqOgCUn9ZANGdZ4OJLC7AmdNJWc8pjVbDz32zEWSMSs0S/D4xCc?=
 =?us-ascii?Q?HfZ8jgxZPOZKOdKU+FmdTdSfN4Qyy3gk16b8iQblSlh5AkJXOfmUHkRieztT?=
 =?us-ascii?Q?E0RNpOyo8437+bRbdGcfO9DMQH+jM0fX9B5Z1ti2GrhCQBAYqIXHa7HaE+Vw?=
 =?us-ascii?Q?yzDnnTd5Mcaxg3Sgaik03G5wDgIn7/tOMDmvrhVgREIedGH8B8k5DjiEvVA9?=
 =?us-ascii?Q?5WaDV3R0zlwUueKt2t20rT6c5JvxiNdOpSNj4KxPgIj6JXVmANzXpRLydExb?=
 =?us-ascii?Q?i/laAs+rxzWg1pmVmNVWiLLSkfwGhRs/NJ6BGqkBBnjefEEPo5B5n8nlCmgG?=
 =?us-ascii?Q?KTVx7se0Q05G+dwEFh+rm9gQ11Wjpc06FZO1ROIOjy2v+IaAdWoVweancz4G?=
 =?us-ascii?Q?r5QCxmclPcy9/3FzEtDrV0usfWr6zlFzngyRA+J2LrACN85fhu+rBRiJtyLr?=
 =?us-ascii?Q?I6CPskp21qflf0p7tkp9Mivpu/v/JoOb2l+f1rMeKmDUMP2d6Ez5Izj9SZkX?=
 =?us-ascii?Q?azQn6GKIki/9QePmbeUPfdSTxy7DcFpjwa/s/KUVJLjZNXJw/XznCdrP3Nvk?=
 =?us-ascii?Q?6UVEeGOkZl+05NvcSlS3bul5AKpnNzryAdIS9dHVW1nDvkEYTsTfrN8/u6PR?=
 =?us-ascii?Q?MP+ww/AM+UPkuYvE0yK/izPtY3OicpN9I3KMZrJZzRZFB2ZXPyjIgg/sy9TJ?=
 =?us-ascii?Q?UfMmAO+P648=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HX3p1oX7jL7yUFWpmt1RgtZtugXATiJDjK2mb2Gnle/qgeNVXE1LvOhNwWh8?=
 =?us-ascii?Q?vBbC2hgAuMUNdfTBp8erA7cRL9Dr5ahny0aKrxcKXaGly1l4bs4d9u3ghfFS?=
 =?us-ascii?Q?Y208J4x7Go2kPrTKQ5W6sJ7AsKUECCWbM58D71/unIPPqgHrXAq6053ycHv0?=
 =?us-ascii?Q?9AKy/wCn32LPFipO4ONS7JJzdWj3TYfDF0msAyPmH1myez6hY+U52fNxCyIq?=
 =?us-ascii?Q?sJev0B8eUx/q3MS1KIbl2DqmPWAbDWqgv7qLTuIgoNe4aPwep+nWDcQ3jsWI?=
 =?us-ascii?Q?3rBCMrVdE6BNAxyRbfzMCmrgoZmq5h5uH/3LGifQP11lGHw94pYi5XBv28Cd?=
 =?us-ascii?Q?o/BdDysFjQdMLUXCEkhJ8rTSjM644Lo21sZF5xB+7NNDkSBInu5zwxNLFnXr?=
 =?us-ascii?Q?Q0BwI+4yczzC62VUoaQUZku3yYUn+KiNjdQ4DHAbv1N+CHVAPYomVNv1REvy?=
 =?us-ascii?Q?OV87H5w0Nf63iHz0UItb209qRXBZ0N0gDTHUDsg7Fl9GcwVyW28u9OEy8h0T?=
 =?us-ascii?Q?s3YoMfoE9xl8grUMHkYJaiAYvTzOuPy9pEkpLvDKo9FU9082sA58VVOEyaRz?=
 =?us-ascii?Q?Y5AJysMoanHcGi+w4P+haTUF8/mGbKOYC7Z5r+y4ISK3Yk25anCbh5ZSYxVm?=
 =?us-ascii?Q?Gp04jxVNhFXaic7QuAyJZeuxClEsfj6kxaID1hv7O/ESoySMQqaU8xjY7cOY?=
 =?us-ascii?Q?wVg7nKwDK3Rjzc6EWp/6k/nJzUCXQXYu3L6lAYzz49LbqFiebByIQL7qzmsY?=
 =?us-ascii?Q?L+njLNdUHgN5U+vq3CRsQhWLDNrkm2a7tXcKVGzaqhIiNkGYP5iWfQ1/cJLW?=
 =?us-ascii?Q?GG4yH/+itAWLeB8nfh9czQMdsBAf6HabJgd0g6pZes015baDtFTYmG4CJ633?=
 =?us-ascii?Q?YFD2UNKtBRtjmgttfH5nFaIM3UzyzJVBoIBvDHOOucVZ+jDrfbkU+zbcpNXE?=
 =?us-ascii?Q?ek4/g//2Aj73OOA/XjJ/R7xThZOBY3tyonfIxTJzTS5eh5lXqtLNEn5ubqkw?=
 =?us-ascii?Q?NEdoAxG7hd2bEOtWB5rTVSAvRVmJKk7CdV60uchBcHHPfPRxNQDEvC89m3d3?=
 =?us-ascii?Q?aNTvCalILJsB7DpHXNZT+E6wdXfZF6hVFQvZddekz2Vv/c4Tz/CFyJw36D7o?=
 =?us-ascii?Q?ymgHEvAp+M4WQJaCvuZG/x6TkoCxb0mFDZKWnDeE8HZiaZqM+JveBZTE61Sr?=
 =?us-ascii?Q?w14LQ37rMWf8L787G5HKjheGsTk30LCZnjF+irPKVxQGziizhQgjPU4Sy4wk?=
 =?us-ascii?Q?FjqGd+af0yCS0WmkzhQQrnQd6dk9gr/lDJnZn8B1htrIXLV6K/La7ljGmOSN?=
 =?us-ascii?Q?twtnOxtVyDcV5tUAucWfS2T03QlTR6p8rCZdYk6cI/U+19UQ3CxKc96lRiIm?=
 =?us-ascii?Q?N7IbWV1VYLsj+Nwr9Y1PtO3vv9w0WzCFo0Z435ykDuX41Wo7d+LVirNi9P+l?=
 =?us-ascii?Q?3Ffhu6Paqpo9Cyym0o97u1olHqsoxCy3Qz3L0Ocoy5btg7DkjbzLMo0Ea4XS?=
 =?us-ascii?Q?2hPf/KanvjRfAImm9czQpxMpqIk7iwd+mINo0W5sf7wP0HMOHQdINnHYcbPM?=
 =?us-ascii?Q?Za33UokvKiql+FvyEUax4WW0alQvmv468+UaITU2BJZAKhMNdb2tqFSnL2GA?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73270b7f-f284-4cb0-9c95-08dd34f788c3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 23:59:51.3766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G7ALPIHA5o+i4ljrybNbzFnhUY/z2CJ7xRS1AN0Nyh+QSxffwenLmh47slO28fmIfb+M4NLPtTY/E2vP0CaQAnj53hrCZu5jo/0MVMl6W2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7908
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
[..]
> >> +#ifdef CONFIG_SFC_CXL
> >> +MODULE_SOFTDEP("pre: cxl_core cxl_port cxl_acpi cxl-mem");
> > No, endpoint drivers should not need softdep for cxl core modules.
> > Primarily because this does nothing to ensure platform CXL
> > capability-enumeration relative to PCI driver loading, and because half
> > of those softdeps in that statement are redundant or broken.
> >
> > - cxl_core is already a dependency due to link time dependencies
> > - cxl_port merely being loaded does nothing to enforce that port probing
> >    is complete by the time the driver loads. Instead the driver needs to
> >    use EPROBE_DEFER to wait for CXL enumeration, or it needs to use the
> >    scheme that cxl_pci uses which is register a memdev and teach userspace
> >    to wait for that memdev attaching to its driver event as the "CXL memory
> >    is now available" event.
> > - cxl_acpi is a platform specific implementation detail. When / if a
> >    non-ACPI platform ever adds CXL support it would be broken if every
> >    endpoint softdep line needed to then be updated
> > - cxl-mem is misspelled cxl_mem and likely is not having any effect.
> >
> > In short, if you delete this line and something breaks then it needs to
> > be fixed in code and not module dependencies.
> 
> 
> It has been a while since I worked on this part, so I need to put my 
> mind back, but with the right softdeps the driver initialization does 
> not fail due to the CXL modules not being loaded yet.
> 
> With a softdep for cxl_port, which is the problem here, and with 
> cxl_port having a dependency for cxl_core, I would say everything the 
> driver needs should be there at the time the sfc driver is loaded. I 
> agree cxl_acpi could be a problem because it is architecture dependent, 
> and I need to see the cxl_mem dependency which is obviously unclear 
> after you spotting the typo.
> 
> In other words, I need to think about all this again and perform some 
> testing. This was implemented after the problems you solved regarding 
> the loading dependencies and enumeration delays, and from our discussion 
> then, I though EPROBE_DEFER was not needed for solving this.

The loading dependencies were only to fix the fact that cxl_acpi was not
able to assert that the top-level ports that it registered were active
before cxl_acpi_probe() returned.

That is different from the endpoint case which has no idea when or if
the cxl_port hierarchy is going to come online, and should not care.

An endpoint only has 2 choices:

1/ return EPROBE_DEFER until an endpoint-port object has a cxl port
   topology to attach. This is subject to arbitrary probe deferral
   timeouts.

2/ use the intermediate object approach like the cxl_mem driver that
   enjoys the cxl_acpi driver re-triggering cxl_mem_probe() whenever the
   cxl_port topology comes online. This solution can handle indefinite
   initialization waits but it means the CXL functionality of the driver
   needs to be enabled dynamically which is more complicated.

...I'll go check v9 to see what might have changed here.

