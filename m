Return-Path: <netdev+bounces-191717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05893ABCDBE
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 05:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C7924A1275
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 03:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE2D212D97;
	Tue, 20 May 2025 03:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ca6AUZBh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C526210785;
	Tue, 20 May 2025 03:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747711089; cv=fail; b=qGYl4nHRG9j8MkNY+BGLiDLCwvYd1xmkI1A+LWangut+2WRqobQ8mP/+CzuM/GcvkopxfFdlpFfFS6zrGwREMYl1pD/qNPQrnJsiWx2NZZCG3Hux/CrHrj8bNFJhO57pO0295tdSfS2vjNM7eAHhnUaggCH2MLbOfaVxhchM5t8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747711089; c=relaxed/simple;
	bh=a0FQiqDbGHxq1O9VQoEoZ7quxbbW5FFiVmdVNnj1PZQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NcCUokx59uGSXucmqJcFVhfjFrj886/m9b9DS3nN4hOzkbb5t/+vJODHda/YFbzD4Lr4Vn06bwdLFQPj7gpGisGIilYBXMn1KN9u59VLVkgOB3J5YVKnVfraRMBJUNqB4R00GzJumQusbwi6jdKs+wrKetkyonf0GKs/z+SmNMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ca6AUZBh; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747711087; x=1779247087;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=a0FQiqDbGHxq1O9VQoEoZ7quxbbW5FFiVmdVNnj1PZQ=;
  b=ca6AUZBhEaisKCC8LOWEI0W1lC1UcZKT+h9XYnQv4bUApV2Un5MWZDH4
   CzSjq04yhNAQBdiX3m5zwf5Ze1gDV+TSc8AM8J1//Jxbs4b4KzJVBH0nD
   tL4D/Ka8j6F112LqZUqAOpOJeL+VqbBS2s0UtzlnOpmQSq3Eq14eoJiLh
   b+m225t9tuRC1fnlv4FoJR/wanRjX7mecPRzzC3Uutl0EOkCWZ+KDNsNf
   6A0ima7i6R/Lypb2EA+kdTpBe5eCkwu9l2NEYcsNzaO1LQCCs8U5Xufgp
   UZAO6CAP/IpWIxTUJGsPMjGoqnh604AayAgGnAoIf2K/vsj0SUNFCt0wJ
   A==;
X-CSE-ConnectionGUID: XcV7KLmSRC+WodKc/cZZ2Q==
X-CSE-MsgGUID: qPSCFJfnQzK6ofF3yxC18w==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="52260907"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="52260907"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 20:18:06 -0700
X-CSE-ConnectionGUID: w2CYFG6JQyaZsnZNLlIIZA==
X-CSE-MsgGUID: aDXF0bvESU22ewswpNVoFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="170453216"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 20:18:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 May 2025 20:18:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 19 May 2025 20:18:05 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 19 May 2025 20:18:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XnbRaYI7fBWhTGULqMbXJYwh9+oHmkCAIsxJwgiiVVFFfyGXTfh9uFuoLor3DLbWLZun9YLgFzadK0m+rSnkEgNoLC2ioaEeux/zsFvPVVCT42g64XBZlKLUQMIYWnV83UGf2PtmDF1c9ZsvrcFATyb3Ewiq0vKsYdnm9TJ0oqbB0s4rWOZVsdSiOP5NOA3unDCqlPTQF7efvivdfGVODB7shXBs4pBetshit/y6txvTfvI5vdxMZGKb7zcLd8kbP7IFaN16J58JOJ06IeA2UzTPTQQTAmW1HQJDtixUvvXIVfgKP/zxDi48Iv7yxoGZoxiq9zFqqbETt8cKX6iSgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXkCEZGWl6LqLfP1FplOlqfDFxred2TNWTZHpxot/Oc=;
 b=xTRVUvq6WML3xV94SxB1TRo38gw7LkBEyiP8dNskrqrr5QPY5drQ+y4MAqHT4de+hyAvekj5gL6zMaCbcOpEGoZdRaLuIfexh/VQ+oD0lqgW11dmHxBSnJnzi+f6HWo3W1RD17iGZic+gqoJELvd0LvGra1+OKLlE1Q8uaWfraz3sZ4LeRDJVB5lSqfhosnIywSrp6XyR556Z9IrkQN3m/TL/tDdXn6FuT3nAdr54LhV5goyactFsycqZ/7DRDuDiKfEfbLeMkjw/3Q3/N8tm1En1MCzyVLHZJTT8694+xsKO7+VkcJfMrSiGGhQZwcp4jziVlxOstjegngXqQOq4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by DM4PR11MB7207.namprd11.prod.outlook.com (2603:10b6:8:111::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 02:43:30 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 02:43:30 +0000
Date: Mon, 19 May 2025 19:43:26 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v16 01/22] cxl: Add type2 device basic support
Message-ID: <aCvsTqArfcKJQDBD@aschofie-mobl2.lan>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-2-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250514132743.523469-2-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: BYAPR01CA0043.prod.exchangelabs.com (2603:10b6:a03:94::20)
 To SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|DM4PR11MB7207:EE_
X-MS-Office365-Filtering-Correlation-Id: be916e96-0d4d-42db-5ed9-08dd97481ac7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eXkIlteZQs7Ks07vdVVTvQUbseFd9lBPgEKJWsxNxgZroGMg2C7xRkIs5CnS?=
 =?us-ascii?Q?YyU2QenAnRe8evgUwfQYqbTpa3ghIK/EPWB3+TRm6WswpFZy119d6e8U9XHu?=
 =?us-ascii?Q?w+9fF8Jq6lJHFHRID3aXupsPHcXw4vHgHi1zbtwLYJEI4MNzlr6dGgMCJJcG?=
 =?us-ascii?Q?7eoQQ8qqJyup+VLrP2OWfi1/MI514EbN7u5rZxtwhWqUgS+UGQVrLpOH81qA?=
 =?us-ascii?Q?mtzlWLWYNPBXkAykk5D4g14+2DIUrQUU1kOYQH5/izdkFke5jP82yGSZbIud?=
 =?us-ascii?Q?dWYGKohP18HwH3X3fBNlqjpelAFCxIsKFBmL4nmydE0DP2wRwI7kjjb+7cgx?=
 =?us-ascii?Q?U3rlnRoprPvywoWQ2CXN40OPmimcLIf7WZ3rgx7z9y887IpnRs4LD2z6WtGh?=
 =?us-ascii?Q?ARhBHx+TcHB2OehUnPII5wuMEsxQZ0AhozopevyCV6wi2zAr9zvCdvSPnfSU?=
 =?us-ascii?Q?sYrE76FbW0YrZPsj5jlnU5Ge/RWIql8uPeDKBpUROUusX9JFnvQV2rncWJiP?=
 =?us-ascii?Q?NYTC21m3gii2E9BJePivnoh6luG50PDOCpDXnO371ZYnAsSzlpwm4gtoUtBq?=
 =?us-ascii?Q?uXwTZWJR5Da/8jW0I6WoN7E8d063Y6ihZUThZYXR1Qu5M4UL2wBLkfLu4ahU?=
 =?us-ascii?Q?E2R2ztR1+y9oHZU+mpPY9NDVCaeLjCw5PZANH4lARXUtVtRUGpaJcH68+pte?=
 =?us-ascii?Q?0GyIUAAzMVDcUnfSAM2BPjOs/GNyFZ4odwvYbMZmobaD0o03f2sYWtOkCmSH?=
 =?us-ascii?Q?HpFjF2oPkM+IWb/NtbC0g56gs2R9FrNdzQN0k4G+WH8LTgDXDUuHS0UYtju9?=
 =?us-ascii?Q?8bNNdoMlpCjXKaP9OsRUPCyYe4MFJZgdMI2GZT+kztcCfTYD7cyd2nnfrhZ9?=
 =?us-ascii?Q?FD6eKQwLDbrOQ7keaWWddoH/ufZR20+PUo6UUWBRt8nCw+r+PWszWm+4mrB6?=
 =?us-ascii?Q?dsnAmqppq9zNHGkUWYpKO5d2/gzSJDy2xwIGGU+VkZWcIRGTNG7AvNV6efR7?=
 =?us-ascii?Q?M5Y4RQy7Q6o2hEibiN5o15ucd8fxNw6C53RyO7wlw1CUo+xg9/j45ZmIdBmM?=
 =?us-ascii?Q?mET8oFdmIL/Aixa0DE2tqcY8iIPYnlH8NZUg4/kRZGxNN+oaKe6YlaaSxF0A?=
 =?us-ascii?Q?tzX39mwXkItQcMd/HpAuBML4E1j/jHTzdeiQkOageGK/HrODyWRXLU+pRDHF?=
 =?us-ascii?Q?c9uPlaRmhCAF0BN+8mie1bMybdbI+bgAHG+sBA++Q57+DA8XQPYX8ehloA4s?=
 =?us-ascii?Q?UFg5Os70P993jMR3PEnfyqdJe+G3gnTbRXr5PHAwO6L9q4oEwvfa+rQBdlSN?=
 =?us-ascii?Q?o0A8eH+uD1zfTK/i1DtNU1beaIsv+DflXGTf8qDGCw76RlR7qRmPwu2jKsJ4?=
 =?us-ascii?Q?hVbazaJMt6/ZXWd6KgM4kxoaCpfEIBs63JX38mJIQ9VUV4/MKcQHp1ZWbHvO?=
 =?us-ascii?Q?/lLhtrAAdKY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VjjtrZ1U8jFfyHuVZ2+JtvcKeMOoyZKRFgABiMEoCTgMtHLvMWhxZH2so5rH?=
 =?us-ascii?Q?yYfS0s6E5natgeTmJuabKf5tbg79C6NamtY9Q1OPZmLEjVQysXfo4u0T0K45?=
 =?us-ascii?Q?5FNrRXJNTK5X71HtM3izTj9Y5jcqStJbfiPn5PqJWGfeY/rmaHNhE9i2EYQy?=
 =?us-ascii?Q?ALxzGvQkIH8doYcPLuRlngok+MF3YUXAlRo/UvnYamw/+RbZLL0QUue4kkLk?=
 =?us-ascii?Q?76PSQe11D8HOmeFawjvTCZyPDYIfT1GdtHbtNxh4Itz9zJvQl1rMy1YeiWtD?=
 =?us-ascii?Q?k4jo2ZQ5A5vVPPntDEkiYWmNewXnn6UD5EU5HQOmEkwKrOIfg5ZVvpoWcxFC?=
 =?us-ascii?Q?W05kVy6HVEUTXhGL/oZDcFkJ9zgw0Eaq0hkjJXn8LXpvSnixLMbMe6spj5jn?=
 =?us-ascii?Q?o0FdBW5+YXOLkNyvrMBpTN3jTEgBhYgJSFeqeFa58Wb3e/diACAb97Hz67Vg?=
 =?us-ascii?Q?PFnEXie+F+/EpZhJxM425/wIQKbXXlwSCFGdd3qM8frLKhbLzhsdmyA07V2y?=
 =?us-ascii?Q?fVIRpvpkZSc4T3eSeMq4HINOuvaac9Q6G8CRa6s0bF6go4TmBI9mTISBsTm8?=
 =?us-ascii?Q?5Yr1KEzrMTiYSRD6Bq1ZGv82QwnhZtE2Y7WB9tccfJOTpoTdVbG0ADhmbSMP?=
 =?us-ascii?Q?/cEKLFwUWdV92PbA7xqcGXx3JT9okX+VC8UuwiUGg8nme9UZTn+6u4luTrLM?=
 =?us-ascii?Q?1iMn40hEzIBLXl9DQTO8pYs7Yb57/TZO6Tewvnkr9OF/cOdwd508rxeV7Xy2?=
 =?us-ascii?Q?EQD1V2NxChioqrO/y7FOa3HCxHm8O6fjNwx1rbKQ6KV+A4DyDanI9akFC+8L?=
 =?us-ascii?Q?Jd18zUVRYm/9Pb0aHLuu9mnx/FOrOQnkck/qmJC62i1FZmyZwIyCj3A5h8pT?=
 =?us-ascii?Q?UVfyTf9Si0Bi7JPuV7ZTsXmMKIrraQ1MU6rs70yWU/4CpzSyozNJPXQ4H4G1?=
 =?us-ascii?Q?6UjExRI8k0Qh8gUS1U+SW65Ovjxu7CRkVs5MDxvp47WgaAQwXjeetlp9GRCv?=
 =?us-ascii?Q?4fj+DKclFZlEwgAuPGlbbH53ZNLYtoSRrUGr+EMe6ta35IN53g5WU7TZAstn?=
 =?us-ascii?Q?rTM0i4K6UnEBHWf9B/3S5GZLOepklLDNsgiopAzFQACH+HKjQ7TcQv3asNF2?=
 =?us-ascii?Q?L+KR6KFWnwsEMznSemFGQZt1DudiYszS+FtO7y+wfmVI8Mmw9FxqJx30bpEE?=
 =?us-ascii?Q?Qc/P0ZsgxJzvqNr76O+VdLKZCr8pm6dhKQhwXKt5uDLHvSEtLm/WLmCvnsU3?=
 =?us-ascii?Q?NPJdrL7OoUxTyTMq9fyWS9ICok/kw0CqWyofvHeG6N6/hEELwKDlHSk4rRjA?=
 =?us-ascii?Q?MYeJhluC4z8V3GHJNgKa3rks7RaTxRhbgpWdyYy8D0fonVN1ZJ6E2039JtMR?=
 =?us-ascii?Q?zriXI69Il7CB4vsEPmOkmMNA3/S7y1XdzUXSVIt7rax5qbwRgw9jRML5MSZX?=
 =?us-ascii?Q?Sl6n5xMbcYLwTQM8Ty8ZPsN/cmDEaHqzmVWyuHcbWi5Zc7o4mhDx0foTGSb9?=
 =?us-ascii?Q?RlcUW/r1URDdW0AD71F7iuoZf9aPKJ4uBT0IioweyLEE5QjczKb+woy2oMQ+?=
 =?us-ascii?Q?57XB/utkaKXbURcrbJy+zRoGtsmdu4cAMKfVdbYoNUpfShnOq1j6p87fly+b?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be916e96-0d4d-42db-5ed9-08dd97481ac7
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 02:43:30.1067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kMrP2/KjGf1CqxtrNGYOwuGtSINlBDUiGyh2A2QDT9fgFhVjXO4P0As8JQopeoGluoRLHQAP2Hf1spMy864rFiHxCd/y1+pjQZUf8AVIPjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7207
X-OriginatorOrg: intel.com

On Wed, May 14, 2025 at 02:27:22PM +0100, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Differentiate CXL memory expanders (type 3) from CXL device accelerators
> (type 2) with a new function for initializing cxl_dev_state and a macro
> for helping accel drivers to embed cxl_dev_state inside a private
> struct.
> 
> Move structs to include/cxl as the size of the accel driver private
> struct embedding cxl_dev_state needs to know the size of this struct.
> 
> Use same new initialization with the type3 pci driver.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

snip

