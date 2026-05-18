Return-Path: <netdev+bounces-288984-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGvBHJflCmqJ9AQAu9opvQ
	(envelope-from <netdev+bounces-288984-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:10:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D2256A6CA
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CC3C930010DA
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 10:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E76A31E841;
	Mon, 18 May 2026 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ArMSvtIY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2ED21D3F5;
	Mon, 18 May 2026 10:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779099027; cv=fail; b=WhWAVLTKQ11MA2RSQTvfOFmK5CdUJTqtXX+R7n9xErZdsAB55qyB/3H72UZCdHIZOnyC9ov9pm2zh1MXhdY9OtHqe4RKdkKePOECvcOqDzckTidfVg1sWEqmCdHDRzqk6ZRQqdXwV/wiTW1W8Sk8z8HNdjm+2papswYzR8qCpe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779099027; c=relaxed/simple;
	bh=3V2kmqGfmNQig8pKJgkixLUs8q6pfz82K7wtc9IMBF0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AGK2R73YY69oNQxAQuXlNgDuawu0rDMhurBhQ4w3w9SYMbA1BjlLcsx/BgLTTDU6PSu3kv6/HuFl7qSQmAmSSziEq5ddZdyoHlSJ6xoKhud2NdJKqTXLc/LAB6u/FNKBrUA8BUbaJcj8dxtOGmkqulc6cY5aACp+oF34Og1fJYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ArMSvtIY; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779099024; x=1810635024;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3V2kmqGfmNQig8pKJgkixLUs8q6pfz82K7wtc9IMBF0=;
  b=ArMSvtIYSeHilvburpD6xt3YFJp+XNuk2IdyvzzZbHWWDKgknh0q+5hV
   VDitKIuyjWP9MpNzY5RdXb8xYhmu8ZluDCS9ulb8JrbgijB0oP1or1ANk
   9cWXjxBfErWCVdYFgb3CXGbcED0RzfPlIlkyHpDJSWF8RTVV0f6HE2Zjj
   RBNDsI6PKM6tOGXgXF3DWzM+Mkk2VsM2yZK+jDEFVVN9WjEQoW5HTZLJl
   u0V/26Q+l4vasGO2RUjctWkJK7wKRq1BlE75nZnvYgAOMxYC+WvT9FSDB
   xRwJe7CoX3LGoiPDsqo51ppoKNxmuXi6NwxG5rDCnuQF8I5WCshct/yaQ
   A==;
X-CSE-ConnectionGUID: 9+TiOsb4SIewPNJIQKT+TQ==
X-CSE-MsgGUID: 41Z+EU/ORbal+pwDnOVmIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="90529326"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="90529326"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 03:10:22 -0700
X-CSE-ConnectionGUID: N8GI7GvtSpeIl2m2kx1hOA==
X-CSE-MsgGUID: lbW8SCYLQAeXIdzvv1a2sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="244366111"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 03:10:21 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 03:10:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 18 May 2026 03:10:21 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.57) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 03:10:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WzNteFepoK/+qN5oqbdDorbvUChOrKm/qCgT3urlV3cC8n1nGiV+egLecPdUpLmDB+ib2qtogEwLWk5dAZXQysFew2srR5RKDdZM0Xp0AeCMXa/0bjb1opL6DKsnDZXS6O6AyaHYm2S91CtZLnt6OkBXHznqSt36zOEA/chrsX0Fir7DVqFSiCrPpPt2VLWgpKu1F0jFp4HytyLhwguHvJKKjGM16xTuRxYXrdq1J4X2TCFnbctch1Ji0SZsKzQv5cmuOmfLR9xBgIH5r2Zgu5sTAvGH8m8DnFc4h8UCR3TfS05gJXNy1ZxMryaBaVfOPmk13T7Uwy7XQJxy3caQug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJA5+zoMWlx0GRmIA/I4LE7unDtZ176KmRj5Mj/rT0Y=;
 b=jMnlE65V5JhKV40qXdXnNBivGQUjA8lefSQOiWrLYLgri5Btra91FNlIRPjGEugfqZFyS0gfBECraiV4j2aqQoFEO9j7HZnKfh+ZHkrdtMotiHGtbXa/7PV1hFeo7IPKVWdQpjCyGxBGMx9Ca0VwXcsoh0ckQPgsg2fjBxQB2MqdFMvELgkRsOOO4LdorHMXiU+L2dVivYwewOrfd4iCRkAQG2Hy0fIbblJDPOnrIwkXBFsteSQRtuucLxy1GiRvPHLMqj8HtKX0omK0MIBt+bi9mAOuls2m+ND01jzL+1f2IIVo0moFTrjAEvChYGs8qk8g0/qDkQJ2RQsKM1cUvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by IA0PR11MB7933.namprd11.prod.outlook.com (2603:10b6:208:407::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 10:10:18 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b%6]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 10:10:18 +0000
Date: Mon, 18 May 2026 12:10:07 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<przemyslaw.kitszel@intel.com>, <aleksander.lobakin@intel.com>,
	<sridhar.samudrala@intel.com>, <anjali.singhai@intel.com>,
	<michal.swiatkowski@linux.intel.com>, <maciej.fijalkowski@intel.com>,
	<emil.s.tantilov@intel.com>, <madhu.chittim@intel.com>,
	<joshua.a.hay@intel.com>, <jacob.e.keller@intel.com>,
	<jayaprakash.shanmugam@intel.com>, <jiri@resnulli.us>, <horms@kernel.org>,
	<corbet@lwn.net>, <richardcochran@gmail.com>, <linux-doc@vger.kernel.org>,
	Bharath R <Bharath.r@intel.com>
Subject: Re: [PATCH net-next v3 13/14] ixd: add the core initialization
Message-ID: <agrlfx0rUjf2WqW6@soc-5CG4396X81.clients.intel.com>
References: <20260515224443.2772147-1-anthony.l.nguyen@intel.com>
 <20260515224443.2772147-14-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260515224443.2772147-14-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: BE0P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:a::28) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|IA0PR11MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: af321e26-02cc-4b26-54eb-08deb4c5a9cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|7416014|4143699003|22082099003|56012099003|18002099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info: PGXvoudpJX39nMosqR9gdniuiH/FbGEnzmib5wCHOqsK8jKId+11YLsl4ZinXenpE6EY0ccXa+/CS0vttkeMwWNmdXI+ajiFzqfTSLwPRgg1DZQxV9m4iZZD73j2WPDM2VnqKxmlqMhods6X/zP67yQYVv6JFKhNwhZAZ8Upa85TJag5SKuoCvE6lNHjNI4XLDKdHDuN1ksazxYJPoJGqpJ63QtTcOHDaHBpULityw44GUoNsfbeDIYT/GKwccKxqpjYQ1JqKe+tNeJtS1nKexb0+XYxIyJOVxXnkkKZDLH7tsqDxxQHdEA03oxY5nU7/DoKkIv5EHRLDZHtPUCzk2w0wWo8eo3koJ7bxNZ1y9HjyjKcuVRP+myLsBKC2DVLnG8GjZ9jq6+haQkyWJvtrthTRzM2nmYr75oxJ4DfGamxyxiFYscIJ1s+Vxyx6R7Xy/U8lxrb3SyCG+mVxd2GCqvX/pHZn6/4Ft+vRqKca4LiS7wQ0iSJW286QXw/AQzjmgHTt0VUatYkLG4mpFbA3iPiFzn2oG/cYLnAAG9KjNovbxJHOoDKYGmsip17K/TgNomrQQkbb71R0gSFAYoisi6+Pq6Z7drn4QW8TG5XGsdxnUkwi6eLsyDxBhHlpAjU3lrEchCw/QH93YIkvKY93xE6uvNigyiI9CP7DDMq2NgO2T9Slikce9IvVlopyHOT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(7416014)(4143699003)(22082099003)(56012099003)(18002099003)(3023799003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CGB6aX4Rwap0U+PI/5s2rDeLM955iEIMwSB/48BwhEozu3sdNtvPPaf6JVAE?=
 =?us-ascii?Q?0hG9sLV7B5wQ/7Kbf32A9vSOUkMtOMa/SRKUNQ/rjZFuMJ48pcvj576I9dCh?=
 =?us-ascii?Q?vCaN1T1dLQhSqjTswR+cO+kWod8rq3NSDsIcw75pW/QdxuxCRF93ARzHPITb?=
 =?us-ascii?Q?B81bEjplWXJe0UbbfRf0yIaZajpw2IEQp4l8KrAdbQ1Fpk674C2+CBcLSOl7?=
 =?us-ascii?Q?9sBzBTQVzX5iyJDVIG3P2ZqIsAPhLDNZi8YfLM7MoDXj2FRnchy60Lr3FPRi?=
 =?us-ascii?Q?nbYHIQiWpgEFLyDxSgJKf8iaubM4dNP0VOqGkh/uXdAH5cVI0OM46DTrku9/?=
 =?us-ascii?Q?1x7OLkpu0KGe3UZETreU17F29TqQMsHGfth6qKvVN2+zCOyGk+zEzssM6Ls+?=
 =?us-ascii?Q?3d/KUW5UpShsE/qm/Vc4WeDazAHYTeaX7zeG9Z0FLaN3mPcbuV9AdcOsgrfX?=
 =?us-ascii?Q?Z8uhoUdPnZEt7L57XLPZwE+/E/p+Tel2E3//j3S+tyBx272B763LCQqxKMmb?=
 =?us-ascii?Q?DGsxtiw/iWibZHsD+/Q/eZMFFTui+4LSN2JaTidVw0vtGAmnNSj5KPKygVeZ?=
 =?us-ascii?Q?iEFMi8UlGlbGP4QTsi7W5qr47t/joq+LcuujRLyI/dhPvKAmgrx2hZ0aYOzt?=
 =?us-ascii?Q?XGwrwWJMzzrHoKfTbKPQ6IK6YoLEnbT/9hY7gtk9n41jK1cqWhlkl+BNiVBl?=
 =?us-ascii?Q?NNlMYr/PRgp4fngGNjfEHhS8n94XObn7jvdksc7WTY1thYklHzGZgkOJkqnC?=
 =?us-ascii?Q?YoaYePF80wfjzAEOq1tNkgZZOus758cGOs19D8Ke0wGmURrUIOmt2WDiOnTs?=
 =?us-ascii?Q?UfuACevtmsszpfvbrSCJ4FCOePceUzN38gQIGCSHIgxZtl2js00Ke5EjkBFR?=
 =?us-ascii?Q?8K+h/79rAsZyyoDWOiJNS9jJoSJ7INWXJMfzqRRD+Zhyv6hqfbPda7bukdqq?=
 =?us-ascii?Q?95QhFtAZkl33qAqe+Dhpt+PgSaWrMOtmNuic1vfgZvVT7Y1ky3CNT8AqZMtg?=
 =?us-ascii?Q?Xk9lTTRivIZDIFZ8UWwB3HNRkVVFeD+FWkmZ8NeO7r9d5pFyZg3VKDgTd88H?=
 =?us-ascii?Q?XEjOAVxQ3oLjJIJitZ7W+k/+DrWUeGCJhnUpKcF7QkQtjVYWO5ufb7W7Pqjt?=
 =?us-ascii?Q?7+1UVM5OVnlK3wlLcQ89jlW38+9Sq5BC0oOTH4ZsjE/Agx7+qGPdVyI/JMrw?=
 =?us-ascii?Q?iDOPr7hNL30mDW87kb01G5cIoZECK0Dy8pS5pMFwH/slFnxeHQGzfdv2RsFE?=
 =?us-ascii?Q?TbiirHnz94ItDE5F+FK9+C41wgQxSLd00Xo13Rgnw2lYTZiJ/6GZMKiwaSX6?=
 =?us-ascii?Q?PWojhRI6YzyMu+kP3YsNJl4EFvqVFy5IK+O8pZzWemxWnQBQhAqAC/JbNPyk?=
 =?us-ascii?Q?ydvXQ/Ji5KGHdRNT54K3eTcG3ickCF+HLBI15w+EgxlZrsuW/9iQo5RBYeHw?=
 =?us-ascii?Q?MOriZFM96rdJ/y4fY8EYZqiPpJnTByvvrx+PFpbECBX8+87KRaFROOfHAeBS?=
 =?us-ascii?Q?T0mL2NvT5GRYjyrKE1Y3f9VFLKhULmhHRCBUpcNOF9zT231sEZxYSSnupkZ5?=
 =?us-ascii?Q?prWHlAnrPuNcbhksWcBVnAVsSUSIch+SzdvhRteQkujIpGvLRD8VqHWISTZm?=
 =?us-ascii?Q?5Ze3DOENwE38VevnnbtYldvYPynG0HwEpgMGOmA8isEdDvTi1+S+3L0JXzfe?=
 =?us-ascii?Q?yfGkI8du42mRHq2Y5b2iH3GglDBhjkuTuVl2nwohhD99f67IT7wuq9vCQIcP?=
 =?us-ascii?Q?2FcV5DaV1yJGRbXBStfTQpeHXBJbvySDsucrJsr2DBiBoGEbn+JGAJazkRIw?=
X-MS-Exchange-AntiSpam-MessageData-1: /3/2PcA88kd0IqnSC7vbjfo5Nn0vXSNwa00=
X-Exchange-RoutingPolicyChecked: jfqjOIeOQ8zgwc529eigvacwcuaGclz9osKQr24os9AuqntKVQKBGqxlDCSpxxD99HvMuCzBi7hlBsBq6B64Yq45s9s8cHaaO/yTUXMEqo3HAik//bpMc5NR8obH7vHETr51XqgxLCtMT5oIopvMX8cyrxN/z/ejiyNwdIYtT1rq4TMzDXjGSrEp0mw0ikY1ewCn2FNRPULsvE5UUkEkqySS676tbm1OS9urqxB0GVxAeiFjnPF/L6kRN06BksfaU4CAnMNhyJZAUYOlYsM+yuSblwKM0MZtyFCoTquHQqzSOJwiT6T9YMJENle1O6ilWI+obH8grIiCIeb0OR5AZQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: af321e26-02cc-4b26-54eb-08deb4c5a9cb
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 10:10:18.5126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YWF7nvwHooDPW1oAwTbYUvNlPti/Hv80lnRIiRHJpROoc+so1Npud4K0q2Kea5zgxtw42+UTSuw8SgCCg6W7iuttpUuvWJKZ05+dV8++xQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7933
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 13D2256A6CA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288984-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,lunn.ch,vger.kernel.org,intel.com,linux.intel.com,resnulli.us,lwn.net,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,soc-5CG4396X81.clients.intel.com:mid,intel.com:email,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 03:44:37PM -0700, Tony Nguyen wrote:
> From: Larysa Zaremba <larysa.zaremba@intel.com>
> 
> As the mailbox is setup, initialize the core. This makes use of the send
> and receive mailbox message framework for virtchnl communication between
> the driver and device Control Plane (CP).
> 
> To start with, driver confirms the virtchnl version with the CP. Once that
> is done, it requests and gets the required capabilities and resources
> needed such as max vectors, queues, vports etc.
> 
> Use a unified way of handling the virtchnl messages, where a single
> function handles all related memory management and the caller only provides
> the callbacks to fill the send buffer and to handle the response.
> 
> Place generic control queue message handling separately to facilitate the
> addition of protocols other than virtchannel in the future.

Sashiko's concern about devlink being registered too early is actually valid.
Would say this is not a serious issue at this stage in the development, but here 
is a diff addressing this:

diff --git a/drivers/net/ethernet/intel/ixd/ixd_lib.c b/drivers/net/ethernet/intel/ixd/ixd_lib.c
index 24080cb30c43..abf78966de61 100644
--- a/drivers/net/ethernet/intel/ixd/ixd_lib.c
+++ b/drivers/net/ethernet/intel/ixd/ixd_lib.c
@@ -2,6 +2,7 @@
 /* Copyright (C) 2025 Intel Corporation */

 #include "ixd.h"
+#include "ixd_devlink.h"
 #include "ixd_virtchnl.h"

 #define IXD_DFLT_MBX_Q_LEN 64
@@ -150,6 +151,7 @@ void ixd_init_task(struct work_struct *work)

        if (!ixd_vc_dev_init(adapter)) {
                adapter->init_task.vc_retries = 0;
+               ixd_devlink_register(adapter);
                return;
        }

diff --git a/drivers/net/ethernet/intel/ixd/ixd_main.c b/drivers/net/ethernet/intel/ixd/ixd_main.c
index 7ff51865af68..aa894482ee35 100644
--- a/drivers/net/ethernet/intel/ixd/ixd_main.c
+++ b/drivers/net/ethernet/intel/ixd/ixd_main.c
@@ -125,8 +125,6 @@ static int ixd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
        queue_delayed_work(system_unbound_wq, &adapter->init_task.init_work,
                           msecs_to_jiffies(500));

-       ixd_devlink_register(adapter);
-
        return 0;

 free_adapter:


> 
> Co-developed-by: Amritha Nambiar <amritha.nambiar@intel.com>
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Tested-by: Bharath R <Bharath.r@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ixd/Makefile       |   2 +
>  drivers/net/ethernet/intel/ixd/ixd.h          |  10 +
>  drivers/net/ethernet/intel/ixd/ixd_ctlq.c     | 149 +++++++++++++++
>  drivers/net/ethernet/intel/ixd/ixd_ctlq.h     |  33 ++++
>  drivers/net/ethernet/intel/ixd/ixd_lib.c      |  25 ++-
>  drivers/net/ethernet/intel/ixd/ixd_main.c     |   3 +
>  drivers/net/ethernet/intel/ixd/ixd_virtchnl.c | 178 ++++++++++++++++++
>  drivers/net/ethernet/intel/ixd/ixd_virtchnl.h |  12 ++
>  8 files changed, 411 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/intel/ixd/ixd_ctlq.c
>  create mode 100644 drivers/net/ethernet/intel/ixd/ixd_ctlq.h
>  create mode 100644 drivers/net/ethernet/intel/ixd/ixd_virtchnl.c
>  create mode 100644 drivers/net/ethernet/intel/ixd/ixd_virtchnl.h
> 
> diff --git a/drivers/net/ethernet/intel/ixd/Makefile b/drivers/net/ethernet/intel/ixd/Makefile
> index 164b2c86952f..90abf231fb16 100644
> --- a/drivers/net/ethernet/intel/ixd/Makefile
> +++ b/drivers/net/ethernet/intel/ixd/Makefile
> @@ -6,5 +6,7 @@
>  obj-$(CONFIG_IXD) += ixd.o
>  
>  ixd-y := ixd_main.o
> +ixd-y += ixd_ctlq.o
>  ixd-y += ixd_dev.o
>  ixd-y += ixd_lib.o
> +ixd-y += ixd_virtchnl.o
> diff --git a/drivers/net/ethernet/intel/ixd/ixd.h b/drivers/net/ethernet/intel/ixd/ixd.h
> index 99c44f2aa659..98d1f22534b5 100644
> --- a/drivers/net/ethernet/intel/ixd/ixd.h
> +++ b/drivers/net/ethernet/intel/ixd/ixd.h
> @@ -10,19 +10,29 @@
>   * struct ixd_adapter - Data structure representing a CPF
>   * @cp_ctx: Control plane communication context
>   * @init_task: Delayed initialization after reset
> + * @mbx_task: Control queue Rx handling
>   * @xnm: virtchnl transaction manager
>   * @asq: Send control queue info
>   * @arq: Receive control queue info
> + * @vc_ver: Negotiated virtchnl version
> + * @caps: Negotiated virtchnl capabilities
>   */
>  struct ixd_adapter {
>  	struct libie_ctlq_ctx cp_ctx;
>  	struct {
>  		struct delayed_work init_work;
>  		u8 reset_retries;
> +		u8 vc_retries;
>  	} init_task;
> +	struct delayed_work mbx_task;
>  	struct libie_ctlq_xn_manager *xnm;
>  	struct libie_ctlq_info *asq;
>  	struct libie_ctlq_info *arq;
> +	struct {
> +		u32 major;
> +		u32 minor;
> +	} vc_ver;
> +	struct virtchnl2_get_capabilities caps;
>  };
>  
>  /**
> diff --git a/drivers/net/ethernet/intel/ixd/ixd_ctlq.c b/drivers/net/ethernet/intel/ixd/ixd_ctlq.c
> new file mode 100644
> index 000000000000..216aa5c02122
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/ixd/ixd_ctlq.c
> @@ -0,0 +1,149 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2025 Intel Corporation */
> +
> +#include "ixd.h"
> +#include "ixd_ctlq.h"
> +#include "ixd_virtchnl.h"
> +
> +/**
> + * ixd_ctlq_clean_sq - Clean the send control queue after sending the message
> + * @adapter: The adapter that sent the messages
> + * @num_sent: Number of sent messages to be released
> + *
> + * Free the libie send resources after sending the message and handling
> + * the response.
> + */
> +static void ixd_ctlq_clean_sq(struct ixd_adapter *adapter, u16 num_sent)
> +{
> +	if (!num_sent)
> +		return;
> +
> +	struct libie_ctlq_xn_clean_params params = {
> +		.ctlq = adapter->asq,
> +		.ctx = &adapter->cp_ctx,
> +		.num_msgs = num_sent,
> +		.rel_tx_buf = kfree,
> +	};
> +
> +	libie_ctlq_xn_send_clean(&params);
> +}
> +
> +/**
> + * ixd_ctlq_init_sparams - Initialize control queue send parameters
> + * @adapter: The adapter with initialized mailbox
> + * @sparams: Parameters to initialize
> + * @msg_buf: DMA-mappable pointer to the message being sent
> + * @msg_size: Message size
> + */
> +static void ixd_ctlq_init_sparams(struct ixd_adapter *adapter,
> +				  struct libie_ctlq_xn_send_params *sparams,
> +				  void *msg_buf, size_t msg_size)
> +{
> +	*sparams = (struct libie_ctlq_xn_send_params) {
> +		.rel_tx_buf = kfree,
> +		.xnm = adapter->xnm,
> +		.ctlq = adapter->asq,
> +		.timeout_ms = IXD_CTLQ_TIMEOUT,
> +		.send_buf = (struct kvec) {
> +			.iov_base = msg_buf,
> +			.iov_len = msg_size,
> +		},
> +	};
> +}
> +
> +/**
> + * ixd_ctlq_do_req - Perform a standard virtchnl request
> + * @adapter: The adapter with initialized mailbox
> + * @req: virtchnl request description
> + *
> + * Return: %0 if a message was sent and received a response
> + * that was successfully handled by the custom callback,
> + * negative error otherwise.
> + */
> +int ixd_ctlq_do_req(struct ixd_adapter *adapter, const struct ixd_ctlq_req *req)
> +{
> +	struct libie_ctlq_xn_send_params send_params = {};
> +	u8 onstack_send_buff[LIBIE_CP_TX_COPYBREAK] = {};
> +	struct kvec *recv_mem;
> +	void *send_buff;
> +	int err;
> +
> +	send_buff = libie_cp_can_send_onstack(req->send_size) ?
> +		    &onstack_send_buff : kzalloc(req->send_size, GFP_KERNEL);
> +	if (!send_buff)
> +		return -ENOMEM;
> +
> +	ixd_ctlq_init_sparams(adapter, &send_params, send_buff,
> +			      req->send_size);
> +
> +	send_params.chnl_opcode = req->opcode;
> +
> +	if (req->send_buff_init)
> +		req->send_buff_init(adapter, send_buff, req->ctx);
> +
> +	err = libie_ctlq_xn_send(&send_params);
> +	if (err)
> +		return err;
> +
> +	recv_mem = &send_params.recv_mem;
> +	if (req->recv_process)
> +		err = req->recv_process(adapter, recv_mem->iov_base,
> +					recv_mem->iov_len, req->ctx);
> +
> +	ixd_ctlq_clean_sq(adapter, 1);
> +	libie_ctlq_release_rx_buf(recv_mem);
> +
> +	return err;
> +}
> +
> +/**
> + * ixd_ctlq_handle_msg - Default control queue message handler
> + * @ctx: Control plane communication context
> + * @msg: Message received
> + */
> +static void ixd_ctlq_handle_msg(struct libie_ctlq_ctx *ctx,
> +				struct libie_ctlq_msg *msg)
> +{
> +	struct ixd_adapter *adapter = pci_get_drvdata(ctx->mmio_info.pdev);
> +
> +	if (ixd_vc_can_handle_msg(msg))
> +		ixd_vc_recv_event_msg(adapter, msg);
> +	else
> +		dev_dbg_ratelimited(ixd_to_dev(adapter),
> +				    "Received an unsupported opcode 0x%x from the CP\n",
> +				    msg->chnl_opcode);
> +
> +	libie_ctlq_release_rx_buf(&msg->recv_mem);
> +}
> +
> +/**
> + * ixd_ctlq_recv_mb_msg - Receive a potential message over mailbox periodically
> + * @adapter: The adapter with initialized mailbox
> + */
> +static void ixd_ctlq_recv_mb_msg(struct ixd_adapter *adapter)
> +{
> +	struct libie_ctlq_xn_recv_params xn_params = {
> +		.xnm = adapter->xnm,
> +		.ctlq = adapter->arq,
> +		.ctlq_msg_handler = ixd_ctlq_handle_msg,
> +		.budget = LIBIE_CTLQ_MAX_XN_ENTRIES,
> +	};
> +
> +	libie_ctlq_xn_recv(&xn_params);
> +}
> +
> +/**
> + * ixd_ctlq_rx_task - Periodically check for mailbox responses and events
> + * @work: work handle
> + */
> +void ixd_ctlq_rx_task(struct work_struct *work)
> +{
> +	struct ixd_adapter *adapter;
> +
> +	adapter = container_of(work, struct ixd_adapter, mbx_task.work);
> +
> +	queue_delayed_work(system_unbound_wq, &adapter->mbx_task,
> +			   msecs_to_jiffies(300));
> +
> +	ixd_ctlq_recv_mb_msg(adapter);
> +}
> diff --git a/drivers/net/ethernet/intel/ixd/ixd_ctlq.h b/drivers/net/ethernet/intel/ixd/ixd_ctlq.h
> new file mode 100644
> index 000000000000..e7191d3870b7
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/ixd/ixd_ctlq.h
> @@ -0,0 +1,33 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (C) 2025 Intel Corporation */
> +
> +#ifndef _IXD_CTLQ_H_
> +#define _IXD_CTLQ_H_
> +
> +#include <linux/intel/virtchnl2.h>
> +
> +#define IXD_CTLQ_TIMEOUT 2000
> +
> +/**
> + * struct ixd_ctlq_req - Standard virtchnl request description
> + * @opcode: protocol opcode, only virtchnl2 is needed for now
> + * @send_size: required length of the send buffer
> + * @send_buff_init: function to initialize the allocated send buffer
> + * @recv_process: function to handle the CP response
> + * @ctx: additional context for callbacks
> + */
> +struct ixd_ctlq_req {
> +	enum virtchnl2_op opcode;
> +	size_t send_size;
> +	void (*send_buff_init)(struct ixd_adapter *adapter, void *send_buff,
> +			       void *ctx);
> +	int (*recv_process)(struct ixd_adapter *adapter, void *recv_buff,
> +			    size_t recv_size, void *ctx);
> +	void *ctx;
> +};
> +
> +int ixd_ctlq_do_req(struct ixd_adapter *adapter,
> +		    const struct ixd_ctlq_req *req);
> +void ixd_ctlq_rx_task(struct work_struct *work);
> +
> +#endif /* _IXD_CTLQ_H_ */
> diff --git a/drivers/net/ethernet/intel/ixd/ixd_lib.c b/drivers/net/ethernet/intel/ixd/ixd_lib.c
> index afc413d3650f..24080cb30c43 100644
> --- a/drivers/net/ethernet/intel/ixd/ixd_lib.c
> +++ b/drivers/net/ethernet/intel/ixd/ixd_lib.c
> @@ -2,6 +2,7 @@
>  /* Copyright (C) 2025 Intel Corporation */
>  
>  #include "ixd.h"
> +#include "ixd_virtchnl.h"
>  
>  #define IXD_DFLT_MBX_Q_LEN 64
>  
> @@ -67,6 +68,8 @@ static void ixd_adapter_fill_dflt_ctlqs(struct ixd_adapter *adapter)
>   */
>  void ixd_deinit_dflt_mbx(struct ixd_adapter *adapter)
>  {
> +	cancel_delayed_work_sync(&adapter->mbx_task);
> +
>  	if (adapter->xnm)
>  		libie_ctlq_xn_deinit(adapter->xnm, &adapter->cp_ctx);
>  
> @@ -108,6 +111,8 @@ int ixd_init_dflt_mbx(struct ixd_adapter *adapter)
>  		return -ENOENT;
>  	}
>  
> +	queue_delayed_work(system_unbound_wq, &adapter->mbx_task, 0);
> +
>  	return 0;
>  }
>  
> @@ -136,8 +141,26 @@ void ixd_init_task(struct work_struct *work)
>  
>  	adapter->init_task.reset_retries = 0;
>  	err = ixd_init_dflt_mbx(adapter);
> -	if (err)
> +	if (err) {
>  		dev_err(ixd_to_dev(adapter),
>  			"Failed to initialize the default mailbox: %pe\n",
>  			ERR_PTR(err));
> +		return;
> +	}
> +
> +	if (!ixd_vc_dev_init(adapter)) {
> +		adapter->init_task.vc_retries = 0;
> +		return;
> +	}
> +
> +	ixd_deinit_dflt_mbx(adapter);
> +	if (++adapter->init_task.vc_retries > 5) {
> +		dev_err(ixd_to_dev(adapter),
> +			"Failed to establish mailbox communications with the hardware\n");
> +		return;
> +	}
> +
> +	ixd_trigger_reset(adapter);
> +	queue_delayed_work(system_unbound_wq, &adapter->init_task.init_work,
> +			   msecs_to_jiffies(500));
>  }
> diff --git a/drivers/net/ethernet/intel/ixd/ixd_main.c b/drivers/net/ethernet/intel/ixd/ixd_main.c
> index b4d4000b63ed..6d5e6aca77df 100644
> --- a/drivers/net/ethernet/intel/ixd/ixd_main.c
> +++ b/drivers/net/ethernet/intel/ixd/ixd_main.c
> @@ -2,6 +2,7 @@
>  /* Copyright (C) 2025 Intel Corporation */
>  
>  #include "ixd.h"
> +#include "ixd_ctlq.h"
>  #include "ixd_lan_regs.h"
>  
>  MODULE_DESCRIPTION("Intel(R) Control Plane Function Device Driver");
> @@ -19,6 +20,7 @@ static void ixd_remove(struct pci_dev *pdev)
>  
>  	/* Do not mix removal with (re)initialization */
>  	cancel_delayed_work_sync(&adapter->init_task.init_work);
> +
>  	/* Leave the device clean on exit */
>  	ixd_trigger_reset(adapter);
>  	ixd_deinit_dflt_mbx(adapter);
> @@ -110,6 +112,7 @@ static int ixd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	INIT_DELAYED_WORK(&adapter->init_task.init_work,
>  			  ixd_init_task);
> +	INIT_DELAYED_WORK(&adapter->mbx_task, ixd_ctlq_rx_task);
>  
>  	ixd_trigger_reset(adapter);
>  	queue_delayed_work(system_unbound_wq, &adapter->init_task.init_work,
> diff --git a/drivers/net/ethernet/intel/ixd/ixd_virtchnl.c b/drivers/net/ethernet/intel/ixd/ixd_virtchnl.c
> new file mode 100644
> index 000000000000..66049d1b1d15
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/ixd/ixd_virtchnl.c
> @@ -0,0 +1,178 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2025 Intel Corporation */
> +
> +#include "ixd.h"
> +#include "ixd_ctlq.h"
> +#include "ixd_virtchnl.h"
> +
> +/**
> + * ixd_vc_recv_event_msg - Handle virtchnl event message
> + * @adapter: The adapter handling the message
> + * @ctlq_msg: Message received
> + */
> +void ixd_vc_recv_event_msg(struct ixd_adapter *adapter,
> +			   struct libie_ctlq_msg *ctlq_msg)
> +{
> +	int payload_size = ctlq_msg->data_len;
> +	struct virtchnl2_event *v2e;
> +
> +	if (payload_size < sizeof(*v2e)) {
> +		dev_warn_ratelimited(ixd_to_dev(adapter),
> +				     "Failed to receive valid payload for event msg (op 0x%X len %u)\n",
> +				     ctlq_msg->chnl_opcode,
> +				     payload_size);
> +		return;
> +	}
> +
> +	v2e = (struct virtchnl2_event *)ctlq_msg->recv_mem.iov_base;
> +
> +	dev_dbg(ixd_to_dev(adapter), "Got event 0x%X from the CP\n",
> +		le32_to_cpu(v2e->event));
> +}
> +
> +/**
> + * ixd_vc_can_handle_msg - Decide if an event has to be handled by virtchnl code
> + * @ctlq_msg: Message received
> + *
> + * Return: %true if virtchnl code can handle the event, %false otherwise
> + */
> +bool ixd_vc_can_handle_msg(struct libie_ctlq_msg *ctlq_msg)
> +{
> +	return ctlq_msg->chnl_opcode == VIRTCHNL2_OP_EVENT;
> +}
> +
> +/**
> + * ixd_handle_caps - Handle VIRTCHNL2_OP_GET_CAPS response
> + * @adapter: The adapter for which the capabilities are being updated
> + * @recv_buff: Buffer containing the response
> + * @recv_size: Response buffer size
> + * @ctx: unused
> + *
> + * Return: %0 if the response format is correct and was handled as expected,
> + * negative error otherwise.
> + */
> +static int ixd_handle_caps(struct ixd_adapter *adapter, void *recv_buff,
> +			   size_t recv_size, void *ctx)
> +{
> +	if (recv_size < sizeof(adapter->caps))
> +		return -EBADMSG;
> +
> +	adapter->caps = *(typeof(adapter->caps) *)recv_buff;
> +
> +	return 0;
> +}
> +
> +/**
> + * ixd_req_vc_caps - Request and save device capability
> + * @adapter: The adapter to get the capabilities for
> + *
> + * Return: success or error if sending the get capability message fails
> + */
> +static int ixd_req_vc_caps(struct ixd_adapter *adapter)
> +{
> +	const struct ixd_ctlq_req req = {
> +		.opcode = VIRTCHNL2_OP_GET_CAPS,
> +		.send_size = sizeof(struct virtchnl2_get_capabilities),
> +		.ctx = NULL,
> +		.send_buff_init = NULL,
> +		.recv_process = ixd_handle_caps,
> +	};
> +
> +	return ixd_ctlq_do_req(adapter, &req);
> +}
> +
> +/**
> + * ixd_get_vc_ver - Get version info from adapter
> + *
> + * Return: filled in virtchannel2 version info, ready for sending
> + */
> +static struct virtchnl2_version_info ixd_get_vc_ver(void)
> +{
> +	return (struct virtchnl2_version_info) {
> +		.major = cpu_to_le32(VIRTCHNL2_VERSION_MAJOR_2),
> +		.minor = cpu_to_le32(VIRTCHNL2_VERSION_MINOR_0),
> +	};
> +}
> +
> +static void ixd_fill_vc_ver(struct ixd_adapter *adapter, void *send_buff,
> +			    void *ctx)
> +{
> +	*(struct virtchnl2_version_info *)send_buff = ixd_get_vc_ver();
> +}
> +
> +/**
> + * ixd_handle_vc_ver - Handle VIRTCHNL2_OP_VERSION response
> + * @adapter: The adapter for which the version is being updated
> + * @recv_buff: Buffer containing the response
> + * @recv_size: Response buffer size
> + * @ctx: Unused
> + *
> + * Return: %0 if the response format is correct and was handled as expected,
> + * negative error otherwise.
> + */
> +static int ixd_handle_vc_ver(struct ixd_adapter *adapter, void *recv_buff,
> +			     size_t recv_size, void *ctx)
> +{
> +	struct virtchnl2_version_info need_ver = ixd_get_vc_ver();
> +	struct virtchnl2_version_info *recv_ver;
> +
> +	if (recv_size < sizeof(need_ver))
> +		return -EBADMSG;
> +
> +	recv_ver = recv_buff;
> +	if (le32_to_cpu(need_ver.major) > le32_to_cpu(recv_ver->major))
> +		return -EOPNOTSUPP;
> +
> +	adapter->vc_ver.major = le32_to_cpu(recv_ver->major);
> +	adapter->vc_ver.minor = le32_to_cpu(recv_ver->minor);
> +
> +	return 0;
> +}
> +
> +/**
> + * ixd_req_vc_version - Request and save Virtchannel2 version
> + * @adapter: The adapter to get the version for
> + *
> + * Return: success or error if sending fails or the response was not as expected
> + */
> +static int ixd_req_vc_version(struct ixd_adapter *adapter)
> +{
> +	const struct ixd_ctlq_req req = {
> +		.opcode = VIRTCHNL2_OP_VERSION,
> +		.send_size = sizeof(struct virtchnl2_version_info),
> +		.ctx = NULL,
> +		.send_buff_init = ixd_fill_vc_ver,
> +		.recv_process = ixd_handle_vc_ver,
> +	};
> +
> +	return ixd_ctlq_do_req(adapter, &req);
> +}
> +
> +/**
> + * ixd_vc_dev_init - virtchnl device core initialization
> + * @adapter: device information
> + *
> + * Return: %0 on success or error if any step of the initialization fails
> + */
> +int ixd_vc_dev_init(struct ixd_adapter *adapter)
> +{
> +	int err;
> +
> +	err = ixd_req_vc_version(adapter);
> +	if (err) {
> +		dev_warn(ixd_to_dev(adapter),
> +			 "Getting virtchnl version failed, error=%pe\n",
> +			 ERR_PTR(err));
> +		return err;
> +	}
> +
> +	err = ixd_req_vc_caps(adapter);
> +	if (err) {
> +		dev_warn(ixd_to_dev(adapter),
> +			 "Getting virtchnl capabilities failed, error=%pe\n",
> +			 ERR_PTR(err));
> +		return err;
> +	}
> +
> +	return err;
> +}
> diff --git a/drivers/net/ethernet/intel/ixd/ixd_virtchnl.h b/drivers/net/ethernet/intel/ixd/ixd_virtchnl.h
> new file mode 100644
> index 000000000000..1a53da8b545c
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/ixd/ixd_virtchnl.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (C) 2025 Intel Corporation */
> +
> +#ifndef _IXD_VIRTCHNL_H_
> +#define _IXD_VIRTCHNL_H_
> +
> +int ixd_vc_dev_init(struct ixd_adapter *adapter);
> +bool ixd_vc_can_handle_msg(struct libie_ctlq_msg *ctlq_msg);
> +void ixd_vc_recv_event_msg(struct ixd_adapter *adapter,
> +			   struct libie_ctlq_msg *ctlq_msg);
> +
> +#endif /* _IXD_VIRTCHNL_H_ */
> -- 
> 2.47.1
> 

