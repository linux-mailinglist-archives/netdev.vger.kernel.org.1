Return-Path: <netdev+bounces-288951-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDgqF8rZCmoA8wQAu9opvQ
	(envelope-from <netdev+bounces-288951-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 11:20:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A83505698C8
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 11:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3EB5C307616A
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 09:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6D43E4C6B;
	Mon, 18 May 2026 09:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U/i3nGZ0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8644A3E5A2E;
	Mon, 18 May 2026 09:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095597; cv=fail; b=jkFfUZW7frDJLtI3GQC/id0GQ4iV9vVKUby1ZF7G6VGVDVJb/lVmynj0btxVQBsq/8tA6/i0ZbTO7Ej/t7NYV76SyvvSQMTLq7APvxL393IqEP+RBNKay3O/liK5PpeY6gIcU4uk5PEdZ3hmwIGG5VmU2pFe1SDGGV3N/bS/BAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095597; c=relaxed/simple;
	bh=zP0mACIY8ZrmI7lyCe2w2ajMkqi3m4L8sUM1wU4jkS4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fDYvpEIOYtJR/Xfo5Dri8bavbB8EQILqAn7QkAQuhg6lzzKUCtzf25F2kxsYMvpfN6souZUUJOaYG+inDpUq4bxg6UeCeS8kJ3+d0F7lWM2WT9Zeqi7nvt3K8k1OZWXt2k4iAqln+oCJHSWS4Fkd9sJmImnDqh+RNWb5AEgtMFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U/i3nGZ0; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779095595; x=1810631595;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zP0mACIY8ZrmI7lyCe2w2ajMkqi3m4L8sUM1wU4jkS4=;
  b=U/i3nGZ0CoWR3u5S2TeDzq84BPy8svDrXWIh66mVphzc8qLlP70F7hZB
   JCJL/MXL3poU+NLaTYchjd8USIT5ZAmXTrYgWrPzqryCesZ42eNmZ9B0v
   uLvWViFwKsadNg0m8jsMY4Sw5sxT8iSlkl7Qzx8TsNheH9xXjWzHEaPX0
   2pJWMUzRaidmwDA8Q2ZIapp6sL3/C9nMUPywcUexxTX5cjeQCgirZe5ZI
   DPIxmakQOOc6AoGJYOD5fI8sZRpRQ2tW7DmsQmBy+Cq1O/KwUBQY/6K9d
   q1dOhx5xQQdnC5FX2qGaJ9mWINuJbjNhz+cSYc87dOntG36Y+h1o6YTqR
   w==;
X-CSE-ConnectionGUID: fpDCeDXLSYmA/7la6MA47A==
X-CSE-MsgGUID: SUACiUC+SOeRLIE2PhY2qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="83796651"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="83796651"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 02:13:14 -0700
X-CSE-ConnectionGUID: xjdec7YpSAGQx7tdsfXhSg==
X-CSE-MsgGUID: szY8eT8dSPGjt/f0cKrCsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="263154036"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 02:13:14 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 02:13:13 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 18 May 2026 02:13:13 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.3) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 02:13:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ltvlbV1+b1A4+6ndVa1Onk+pzJMexRgrzBTjQ9ofPp5PPIDnXUVFuhoYREdWDInpdIrEz27iW/VGbpoDR4f86wRjPdm4rC43+wfWQSOnOASZsb9QmWqbMqB1N7cJDvm72VEWuuVl1UmfQTgNFkvsTI2nwxrePBAOi3iHqTvcikciD6pJ3aW8UJWGSLnkK6ejnOwclJc8iIf/4SdO48GaA/oU9I9PE89B6JXp/zBexuf2Y4+YaYw/PV+f9+OmXuyEoh7LnPzYqY4zfYkY6bCYlAiAalv6wCZsDimZuJdjBzyfz1nxB0EJkEiM4YH6Zz01HGKkpSfCN5ulDsavht604Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSoXB6VHSItdHu2a91SilF5isVmx+/qLIteTnxZ/HXY=;
 b=Rg1Ju/NaaNu1mA7H/L9R27vh5dzEnPayLxCouxgmUn3i1aokDmcSVevEriPaqWwX2hF4dlraThTL9sH930Xa9HFcsrZOVtbAQDEVj7gRcJzZKYsOfR7eZd8cQYbvxgD+V/YJJur1jTylc+PYHC2EHdFUkBeIcmrCGWo2OBzjblTUaE7MDQyvzpu/AK9pwkYqtQ8xenXg5yumOiJtEy65bCqQKLFW8P6k4MSBcfEXIJI9rrjHDdjcp6NCQWK+Zoin43vY9Z8W9U9M6QOMWmOsnonhWvwcbAGdKO9rM7ffuxjLYpsIil3rm+NLsJfL1neiJ+ROseBRo9gDO5yWCuAiJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by CH8PR11MB9481.namprd11.prod.outlook.com (2603:10b6:610:2bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Mon, 18 May
 2026 09:13:11 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b%6]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 09:13:11 +0000
Date: Mon, 18 May 2026 11:12:58 +0200
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
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Bharath R
	<Bharath.r@intel.com>
Subject: Re: [PATCH net-next v3 12/14] ixd: add reset checks and initialize
 the mailbox
Message-ID: <agrYGjTmafeGxODv@soc-5CG4396X81.clients.intel.com>
References: <20260515224443.2772147-1-anthony.l.nguyen@intel.com>
 <20260515224443.2772147-13-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260515224443.2772147-13-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: VI1P189CA0013.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::26) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|CH8PR11MB9481:EE_
X-MS-Office365-Filtering-Correlation-Id: d0b96a95-277f-431c-e7a2-08deb4bdaef4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016|22082099003|3023799003|18002099003|11063799003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info: ZbTfolsMdVvwf1A0fSexdKFo8PnqrbyaZ/Jbgt8suEEgN9Mw7dqd1zkOkJQvKZLuVdEKksjDZU5G/RFM1WY6PUkVvqFHQvA+UAx6v9sfkM4Tkk++wjkLLWG2RqVwxAZeFI7kOoolBBUZZI3jKrNzvS9CxNA26LckZIt/IbEh2O+/Lrlf6dDgW254hyf6BlP6MHeYsp6Z2D0QJtkjuLFgFdNFrVxXNTtz47fs/ixoCuhZav/xTS6La07v3QsXFxrHeUbQ6IZRmTXkriBTIaJtjX0EnQLqq6LY13Vwu80eapoky8N4ARlBXDtM0tVnvAge9NQwniFBdkLggnyEn2Yys+BL9dqFIsnj5yU9uMb4cmjOXMOkoOZXFvQC3lESuwCme1aTP+sMnI7vmFgcAIeIB8vL4qpvY0Km5XqVSikjb7SBcMpHAcd2v3iqXkDC20Ae6jARZvMsepiqrAnIaQ9r7fCw+DmP9bF2tFr6tsawXmuTJyQDe2nPGCVoUPAGPvpEnFDsS1exMWFJb72PBUiUK0lh+LlxdCaPbnJIiJcUwFhE/v0WdfcWDhHo66mgo7ZycnlKaepl2o3bxEzexq9lkdHn6dzmq9ME8BmZ9+WJ2zC+dfIVu5aado+JZyTu2gjBES/1Ada3F0L1HAHpYfkzyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(22082099003)(3023799003)(18002099003)(11063799003)(56012099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?25ErZaYmlI1PPWb6+fC1nXKx+Ps5RzyrIG/lqtB7kkW0K8vnlMC/3snM4MM4?=
 =?us-ascii?Q?7IJsY8wUIDjzPRQcH7aaHjgImJPOHuF+9QDe7gN40SnDSF72oXmH7LZeJDxT?=
 =?us-ascii?Q?QSublXQh6evNj+6H26JCGfpZ/XHG1lyo1C75PqQhzFWMqpcUODE5Uzqi4emy?=
 =?us-ascii?Q?aHPb6idKj9Gi4UfIjMuMKTF+DCjfOFuoZMov+YvcTaby1uqqIABFYyvpDgMF?=
 =?us-ascii?Q?+SrMZIjN30ZA94hmmc6hJIXO8u3rhXCuH2suObkOvsmn/Vf7dgw53uQwUkWE?=
 =?us-ascii?Q?YeASVhkadMII7jXDULzBKBfFLT9WmGzEJDwRGt3EMoYo+8GzXEJRFzHRT5mS?=
 =?us-ascii?Q?ecaKah8GDZ/kZV5xw0hCLUV7TeZo7sGU+dCPjohuLgP9mMwBJHX/eNmvWBTk?=
 =?us-ascii?Q?frYCPaED5jYO5DONKYJnwEND43jxDrD/pHZXvwuYcJnrNpc/u+rmg2rrY8Uf?=
 =?us-ascii?Q?330k5qlnGF8c1M6rFGiNg3gI3T1FxqXuWzd1XXTBDk9J8P8S+sPyydA3vB+a?=
 =?us-ascii?Q?5uvpxlX7fSbGC9yC6IgyDpYmeITL8wYemYxu2VPWGPj5vT9q/q+/SAm4Z4GG?=
 =?us-ascii?Q?pNfqtiBeqXItkXJ/lhbqMChHotaAzBvMq0vQz5YM8oNlgcba1VNjGapuiovJ?=
 =?us-ascii?Q?taBAiWPAq+OphkphV1UflnkytPnayDrt4AcLvmRer6nSvhTyDiIlnEA7Ozhr?=
 =?us-ascii?Q?Jik+PI9OW79/DyIpHeaYd54uTM9UhvJOeIanx6v3QEz0XeE2zpvXbFoUK9k2?=
 =?us-ascii?Q?ZqkeM1lAbnQdCVXabHgPt6xorkW+Vjq7d6dxRhLTHmqYZ6Y6TUBJTMvKwsLE?=
 =?us-ascii?Q?gUEDMGkYbiJrO3hz5ZrtLycwC8ei+8Qg0J6EGgwnKzQXiK4C/BJDTCJzkg0v?=
 =?us-ascii?Q?nti/d7y4wZcmzhUpg/lacAcIiO9zITMAuGsMcTKAkWqe4URziqpNOGZadBzr?=
 =?us-ascii?Q?K6d4oJjdcrV294XkCEV6MDF64B79GG8N+VFPnWjJYNM4mxVa4N/FCtw8h8gE?=
 =?us-ascii?Q?LJJHua5TbT9FzgLa8AReX/SQudLf+OcWFndVMy7afCC7Al4w0Egx5BGq5kXT?=
 =?us-ascii?Q?fhn/zvWy3Oh63tTiCWM/PjlPaMeKnb9cJikeN172B1dj5IR/AFGrA25BB/hP?=
 =?us-ascii?Q?yen4pvm7tEfpQVFqieaMCO+0kCoiH6Z3dp2P+hLiDltyalEU04Iw5s25ORxc?=
 =?us-ascii?Q?LFpYmAcdfCkHFxbFG7bWTGqmrm5YJtR3ny7knuBV+rT091LD8+OItRxAPlUc?=
 =?us-ascii?Q?sOntIxmUkEtYdQ/SaX8gBuzxADUzjuDWZ0P0Fs4ZWscNBInY1ZoDx+uAnyPO?=
 =?us-ascii?Q?lSfzNinlhEk64eFkArb0YJvqP5x2s7HrOgCsFZE9EDKoTvIbptXHQS1da+Id?=
 =?us-ascii?Q?kvv/uJ5zBpne9NQdWVwl0JSZVgNHlTHryzYrJIa7HL1S2x5CyebWC04MHo+l?=
 =?us-ascii?Q?cP5DPmBzkQ6Y9dU5HGoJqX30Quj5qEHX8zY6q9PeR8iaJsdYaFXnvkAU3dwx?=
 =?us-ascii?Q?u/ILecYtSzAdgYV2cSGzEhyJ38FUjZF2WLF7u33AU9DY0h9XeEah4DoWOaqA?=
 =?us-ascii?Q?AxHsalB2azeqxQ/uz71aSF1ZG3tWzYE6cjnF1JNMoprFWpawpUUjP+Lb/ltb?=
 =?us-ascii?Q?4IEh4EuL0dl0Tir+IzNH42almrhdBL7+u1eyCP2Cu1B3D1+4UXSl/pUPxlON?=
 =?us-ascii?Q?NUX5t94s6z9lxQAon+4l+53nmhKkBGtHEecqjoAauha9uVSJNJTFkqsa2EMS?=
 =?us-ascii?Q?PpTJaMYYUDU1JTe6WNloPntTJdfMBhIuTyFKdACi7UWVD4jpOpdXih0+CLkk?=
X-MS-Exchange-AntiSpam-MessageData-1: e0qY5VMe68tw7gnyJAFAvgEw8baJnipKk8s=
X-Exchange-RoutingPolicyChecked: UJlto8/OqpzAyFR+JJwqHpXmwPUKK2dX3CDQAvSc40tbFqc0UXf1ISEswdS5i+2k1TlnmiNjxE+9BzzXv0cuzAMwY/kTwgxxdSW58Aiz1ihzakS4N16xZsfuAORIlxIkMiwdf8XuCqk3dO6336mikAqV0BwTRWUEWF6+jftS6SB8k7tq0TmOWqpalXm5e6M7ZtN/VbCgmA3tZdPEKOkxCmeBibHAagGF9/Rh8NzKCePppXsx3UI6V9chwYaAthVlaWfrjnIsE6C94TEpdJLIIoEDgtFvUqsCUZL4mGOhaTEcpZ0Xsxe3bvM8GlvWYIWYdacsimDczbBvAVPrx/IKfA==
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b96a95-277f-431c-e7a2-08deb4bdaef4
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 09:13:11.3118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+k1bhfr20AYJTW3lS1ckC4QtM0ybPeenpMFoo15AOj0n9Eqpkem2L8zOUAziHOMaWFFS+Aa3rSP6PpL4qZD8fXgs4WdgS95y1Pp24QJHW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB9481
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: A83505698C8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288951-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,lunn.ch,vger.kernel.org,intel.com,linux.intel.com,resnulli.us,lwn.net,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,soc-5CG4396X81.clients.intel.com:mid];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 03:44:36PM -0700, Tony Nguyen wrote:
> From: Larysa Zaremba <larysa.zaremba@intel.com>
> 
> At the end of the probe, trigger hard reset, initialize and schedule the
> after-reset task. If the reset is complete in a pre-determined time,
> initialize the default mailbox, through which other resources will be
> negotiated.

Sashiko says [0]:

"
Does this teardown sequence properly ensure the hardware is quiescent before
freeing its DMA memory?
Looking at ixd_trigger_reset(), it performs a writel(), which is a posted
write over PCIe.
The code here does not flush this write with a dummy read, nor does it
wait for the reset to complete by polling ixd_check_reset_complete().
Since ixd_deinit_dflt_mbx() immediately proceeds to free the DMA memory
via libie_ctlq_xn_deinit(), could the hardware continue executing DMA
operations into the freed memory, potentially causing IOMMU faults or memory
corruption?
"

Reset flow is consistent with what pre-refactor idpf does, and is the intended 
way to perform removal.

[0] https://sashiko.dev/#/patchset/20260515224443.2772147-1-anthony.l.nguyen%40intel.com

> 
> Co-developed-by: Amritha Nambiar <amritha.nambiar@intel.com>
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Tested-by: Bharath R <Bharath.r@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ixd/Kconfig        |   1 +
>  drivers/net/ethernet/intel/ixd/Makefile       |   2 +
>  drivers/net/ethernet/intel/ixd/ixd.h          |  28 +++-
>  drivers/net/ethernet/intel/ixd/ixd_dev.c      |  89 +++++++++++
>  drivers/net/ethernet/intel/ixd/ixd_lan_regs.h |  40 +++++
>  drivers/net/ethernet/intel/ixd/ixd_lib.c      | 143 ++++++++++++++++++
>  drivers/net/ethernet/intel/ixd/ixd_main.c     |  32 +++-
>  7 files changed, 326 insertions(+), 9 deletions(-)
>  create mode 100644 drivers/net/ethernet/intel/ixd/ixd_dev.c
>  create mode 100644 drivers/net/ethernet/intel/ixd/ixd_lib.c
> 
> diff --git a/drivers/net/ethernet/intel/ixd/Kconfig b/drivers/net/ethernet/intel/ixd/Kconfig
> index f5594efe292c..24510c50070e 100644
> --- a/drivers/net/ethernet/intel/ixd/Kconfig
> +++ b/drivers/net/ethernet/intel/ixd/Kconfig
> @@ -5,6 +5,7 @@ config IXD
>  	tristate "Intel(R) Control Plane Function Support"
>  	depends on PCI_MSI
>  	select LIBETH
> +	select LIBIE_CP
>  	select LIBIE_PCI
>  	help
>  	  This driver supports Intel(R) Control Plane PCI Function
> diff --git a/drivers/net/ethernet/intel/ixd/Makefile b/drivers/net/ethernet/intel/ixd/Makefile
> index 3849bc240600..164b2c86952f 100644
> --- a/drivers/net/ethernet/intel/ixd/Makefile
> +++ b/drivers/net/ethernet/intel/ixd/Makefile
> @@ -6,3 +6,5 @@
>  obj-$(CONFIG_IXD) += ixd.o
>  
>  ixd-y := ixd_main.o
> +ixd-y += ixd_dev.o
> +ixd-y += ixd_lib.o
> diff --git a/drivers/net/ethernet/intel/ixd/ixd.h b/drivers/net/ethernet/intel/ixd/ixd.h
> index d813c27941a5..99c44f2aa659 100644
> --- a/drivers/net/ethernet/intel/ixd/ixd.h
> +++ b/drivers/net/ethernet/intel/ixd/ixd.h
> @@ -4,14 +4,25 @@
>  #ifndef _IXD_H_
>  #define _IXD_H_
>  
> -#include <linux/intel/libie/pci.h>
> +#include <linux/intel/libie/controlq.h>
>  
>  /**
>   * struct ixd_adapter - Data structure representing a CPF
> - * @hw: Device access data
> + * @cp_ctx: Control plane communication context
> + * @init_task: Delayed initialization after reset
> + * @xnm: virtchnl transaction manager
> + * @asq: Send control queue info
> + * @arq: Receive control queue info
>   */
>  struct ixd_adapter {
> -	struct libie_mmio_info hw;
> +	struct libie_ctlq_ctx cp_ctx;
> +	struct {
> +		struct delayed_work init_work;
> +		u8 reset_retries;
> +	} init_task;
> +	struct libie_ctlq_xn_manager *xnm;
> +	struct libie_ctlq_info *asq;
> +	struct libie_ctlq_info *arq;
>  };
>  
>  /**
> @@ -22,7 +33,16 @@ struct ixd_adapter {
>   */
>  static inline struct device *ixd_to_dev(struct ixd_adapter *adapter)
>  {
> -	return &adapter->hw.pdev->dev;
> +	return &adapter->cp_ctx.mmio_info.pdev->dev;
>  }
>  
> +void ixd_ctlq_reg_init(struct ixd_adapter *adapter,
> +		       struct libie_ctlq_reg *ctlq_reg_tx,
> +		       struct libie_ctlq_reg *ctlq_reg_rx);
> +void ixd_trigger_reset(struct ixd_adapter *adapter);
> +bool ixd_check_reset_complete(struct ixd_adapter *adapter);
> +void ixd_init_task(struct work_struct *work);
> +int ixd_init_dflt_mbx(struct ixd_adapter *adapter);
> +void ixd_deinit_dflt_mbx(struct ixd_adapter *adapter);
> +
>  #endif /* _IXD_H_ */
> diff --git a/drivers/net/ethernet/intel/ixd/ixd_dev.c b/drivers/net/ethernet/intel/ixd/ixd_dev.c
> new file mode 100644
> index 000000000000..cdd5477cc1f4
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/ixd/ixd_dev.c
> @@ -0,0 +1,89 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2025 Intel Corporation */
> +
> +#include "ixd.h"
> +#include "ixd_lan_regs.h"
> +
> +/**
> + * ixd_ctlq_reg_init - Initialize default mailbox registers
> + * @adapter: PCI device driver-specific private data
> + * @ctlq_reg_tx: Transmit queue registers info to be filled
> + * @ctlq_reg_rx: Receive queue registers info to be filled
> + */
> +void ixd_ctlq_reg_init(struct ixd_adapter *adapter,
> +		       struct libie_ctlq_reg *ctlq_reg_tx,
> +		       struct libie_ctlq_reg *ctlq_reg_rx)
> +{
> +	struct libie_mmio_info *mmio_info = &adapter->cp_ctx.mmio_info;
> +	*ctlq_reg_tx = (struct libie_ctlq_reg) {
> +		.head = libie_pci_get_mmio_addr(mmio_info, PF_FW_ATQH),
> +		.tail = libie_pci_get_mmio_addr(mmio_info, PF_FW_ATQT),
> +		.len = libie_pci_get_mmio_addr(mmio_info, PF_FW_ATQLEN),
> +		.addr_high = libie_pci_get_mmio_addr(mmio_info, PF_FW_ATQBAH),
> +		.addr_low = libie_pci_get_mmio_addr(mmio_info, PF_FW_ATQBAL),
> +		.len_mask = PF_FW_ATQLEN_ATQLEN_M,
> +		.len_ena_mask = PF_FW_ATQLEN_ATQENABLE_M,
> +		.head_mask = PF_FW_ATQH_ATQH_M,
> +	};
> +
> +	*ctlq_reg_rx = (struct libie_ctlq_reg) {
> +		.head = libie_pci_get_mmio_addr(mmio_info, PF_FW_ARQH),
> +		.tail = libie_pci_get_mmio_addr(mmio_info, PF_FW_ARQT),
> +		.len = libie_pci_get_mmio_addr(mmio_info, PF_FW_ARQLEN),
> +		.addr_high = libie_pci_get_mmio_addr(mmio_info, PF_FW_ARQBAH),
> +		.addr_low = libie_pci_get_mmio_addr(mmio_info, PF_FW_ARQBAL),
> +		.len_mask = PF_FW_ARQLEN_ARQLEN_M,
> +		.len_ena_mask = PF_FW_ARQLEN_ARQENABLE_M,
> +		.head_mask = PF_FW_ARQH_ARQH_M,
> +	};
> +}
> +
> +static const struct ixd_reset_reg ixd_reset_reg = {
> +	.rstat  = PFGEN_RSTAT,
> +	.rstat_m = PFGEN_RSTAT_PFR_STATE_M,
> +	.rstat_ok_v = 0b01,
> +	.rtrigger = PFGEN_CTRL,
> +	.rtrigger_m = PFGEN_CTRL_PFSWR,
> +};
> +
> +/**
> + * ixd_trigger_reset - Trigger PFR reset
> + * @adapter: the device with mapped reset register
> + */
> +void ixd_trigger_reset(struct ixd_adapter *adapter)
> +{
> +	void __iomem *addr;
> +	u32 reg_val;
> +
> +	addr = libie_pci_get_mmio_addr(&adapter->cp_ctx.mmio_info,
> +				       ixd_reset_reg.rtrigger);
> +	reg_val = readl(addr);
> +	writel(reg_val | ixd_reset_reg.rtrigger_m, addr);
> +}
> +
> +/**
> + * ixd_check_reset_complete - Check if the PFR reset is completed
> + * @adapter: CPF being reset
> + *
> + * Return: %true if the register read indicates reset has been finished,
> + *	   %false otherwise
> + */
> +bool ixd_check_reset_complete(struct ixd_adapter *adapter)
> +{
> +	u32 reg_val, reset_status;
> +	void __iomem *addr;
> +
> +	addr = libie_pci_get_mmio_addr(&adapter->cp_ctx.mmio_info,
> +				       ixd_reset_reg.rstat);
> +	reg_val = readl(addr);
> +	reset_status = reg_val & ixd_reset_reg.rstat_m;
> +
> +	/* 0xFFFFFFFF might be read if the other side hasn't cleared
> +	 * the register for us yet.
> +	 */
> +	if (reg_val != GENMASK(31, 0) &&
> +	    reset_status == ixd_reset_reg.rstat_ok_v)
> +		return true;
> +
> +	return false;
> +}
> diff --git a/drivers/net/ethernet/intel/ixd/ixd_lan_regs.h b/drivers/net/ethernet/intel/ixd/ixd_lan_regs.h
> index fbb88929d0de..58e58c75981b 100644
> --- a/drivers/net/ethernet/intel/ixd/ixd_lan_regs.h
> +++ b/drivers/net/ethernet/intel/ixd/ixd_lan_regs.h
> @@ -11,9 +11,33 @@
>  #define PF_FW_MBX_REG_LEN		4096
>  #define PF_FW_MBX			0x08400000
>  
> +#define PF_FW_ARQBAL			(PF_FW_MBX)
> +#define PF_FW_ARQBAH			(PF_FW_MBX + 0x4)
> +#define PF_FW_ARQLEN			(PF_FW_MBX + 0x8)
> +#define PF_FW_ARQLEN_ARQLEN_M		GENMASK(12, 0)
> +#define PF_FW_ARQLEN_ARQENABLE_S	31
> +#define PF_FW_ARQLEN_ARQENABLE_M	BIT(PF_FW_ARQLEN_ARQENABLE_S)
> +#define PF_FW_ARQH_ARQH_M		GENMASK(12, 0)
> +#define PF_FW_ARQH			(PF_FW_MBX + 0xC)
> +#define PF_FW_ARQT			(PF_FW_MBX + 0x10)
> +
> +#define PF_FW_ATQBAL			(PF_FW_MBX + 0x14)
> +#define PF_FW_ATQBAH			(PF_FW_MBX + 0x18)
> +#define PF_FW_ATQLEN			(PF_FW_MBX + 0x1C)
> +#define PF_FW_ATQLEN_ATQLEN_M		GENMASK(9, 0)
> +#define PF_FW_ATQLEN_ATQENABLE_S	31
> +#define PF_FW_ATQLEN_ATQENABLE_M	BIT(PF_FW_ATQLEN_ATQENABLE_S)
> +#define PF_FW_ATQH_ATQH_M		GENMASK(9, 0)
> +#define PF_FW_ATQH			(PF_FW_MBX + 0x20)
> +#define PF_FW_ATQT			(PF_FW_MBX + 0x24)
> +
>  /* Reset registers */
>  #define PFGEN_RTRIG_REG_LEN		2048
>  #define PFGEN_RTRIG			0x08407000	/* Device resets */
> +#define PFGEN_RSTAT			0x08407008	/* PFR status */
> +#define PFGEN_RSTAT_PFR_STATE_M		GENMASK(1, 0)
> +#define PFGEN_CTRL			0x0840700C	/* PFR trigger */
> +#define PFGEN_CTRL_PFSWR		BIT(0)
>  
>  /**
>   * struct ixd_bar_region - BAR region description
> @@ -25,4 +49,20 @@ struct ixd_bar_region {
>  	resource_size_t size;
>  };
>  
> +/**
> + * struct ixd_reset_reg - structure for reset registers
> + * @rstat: offset of status in register
> + * @rstat_m: status mask
> + * @rstat_ok_v: value that indicates PFR completed status
> + * @rtrigger: offset of reset trigger in register
> + * @rtrigger_m: reset trigger mask
> + */
> +struct ixd_reset_reg {
> +	u32	rstat;
> +	u32	rstat_m;
> +	u32	rstat_ok_v;
> +	u32	rtrigger;
> +	u32	rtrigger_m;
> +};
> +
>  #endif /* _IXD_LAN_REGS_H_ */
> diff --git a/drivers/net/ethernet/intel/ixd/ixd_lib.c b/drivers/net/ethernet/intel/ixd/ixd_lib.c
> new file mode 100644
> index 000000000000..afc413d3650f
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/ixd/ixd_lib.c
> @@ -0,0 +1,143 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2025 Intel Corporation */
> +
> +#include "ixd.h"
> +
> +#define IXD_DFLT_MBX_Q_LEN 64
> +
> +/**
> + * ixd_init_ctlq_create_info - Initialize control queue info for creation
> + * @info: destination
> + * @type: type of the queue to create
> + * @ctlq_reg: register assigned to the control queue
> + */
> +static void ixd_init_ctlq_create_info(struct libie_ctlq_create_info *info,
> +				      enum virtchnl2_queue_type type,
> +				      const struct libie_ctlq_reg *ctlq_reg)
> +{
> +	*info = (struct libie_ctlq_create_info) {
> +		.type = type,
> +		.id = -1,
> +		.reg = *ctlq_reg,
> +		.len = IXD_DFLT_MBX_Q_LEN,
> +	};
> +}
> +
> +/**
> + * ixd_init_libie_xn_params - Initialize xn transaction manager creation info
> + * @params: destination
> + * @adapter: adapter info struct
> + * @ctlqs: list of the managed queues to create
> + * @num_queues: length of the queue list
> + */
> +static void ixd_init_libie_xn_params(struct libie_ctlq_xn_init_params *params,
> +				     struct ixd_adapter *adapter,
> +				      struct libie_ctlq_create_info *ctlqs,
> +				      uint num_queues)
> +{
> +	*params = (struct libie_ctlq_xn_init_params){
> +		.cctlq_info = ctlqs,
> +		.ctx = &adapter->cp_ctx,
> +		.num_qs = num_queues,
> +	};
> +}
> +
> +/**
> + * ixd_adapter_fill_dflt_ctlqs - Find default control queues and store them
> + * @adapter: adapter info struct
> + */
> +static void ixd_adapter_fill_dflt_ctlqs(struct ixd_adapter *adapter)
> +{
> +	guard(spinlock)(&adapter->cp_ctx.ctlqs_lock);
> +	struct libie_ctlq_info *cq;
> +
> +	list_for_each_entry(cq, &adapter->cp_ctx.ctlqs, list) {
> +		if (cq->qid != -1)
> +			continue;
> +		if (cq->type == LIBIE_CTLQ_TYPE_RX)
> +			adapter->arq = cq;
> +		else if (cq->type == LIBIE_CTLQ_TYPE_TX)
> +			adapter->asq = cq;
> +	}
> +}
> +
> +/**
> + * ixd_deinit_dflt_mbx - Deinitialize default mailbox
> + * @adapter: adapter info struct
> + */
> +void ixd_deinit_dflt_mbx(struct ixd_adapter *adapter)
> +{
> +	if (adapter->xnm)
> +		libie_ctlq_xn_deinit(adapter->xnm, &adapter->cp_ctx);
> +
> +	adapter->arq = NULL;
> +	adapter->asq = NULL;
> +	adapter->xnm = NULL;
> +}
> +
> +/**
> + * ixd_init_dflt_mbx - Setup default mailbox parameters and make request
> + * @adapter: adapter info struct
> + *
> + * Return: %0 on success, negative errno code on failure
> + */
> +int ixd_init_dflt_mbx(struct ixd_adapter *adapter)
> +{
> +	struct libie_ctlq_create_info ctlqs_info[2];
> +	struct libie_ctlq_xn_init_params xn_params;
> +	struct libie_ctlq_reg ctlq_reg_tx;
> +	struct libie_ctlq_reg ctlq_reg_rx;
> +	int err;
> +
> +	ixd_ctlq_reg_init(adapter, &ctlq_reg_tx, &ctlq_reg_rx);
> +	ixd_init_ctlq_create_info(&ctlqs_info[0], LIBIE_CTLQ_TYPE_TX,
> +				  &ctlq_reg_tx);
> +	ixd_init_ctlq_create_info(&ctlqs_info[1], LIBIE_CTLQ_TYPE_RX,
> +				  &ctlq_reg_rx);
> +	ixd_init_libie_xn_params(&xn_params, adapter, ctlqs_info,
> +				 ARRAY_SIZE(ctlqs_info));
> +	err = libie_ctlq_xn_init(&xn_params);
> +	if (err)
> +		return err;
> +	adapter->xnm = xn_params.xnm;
> +
> +	ixd_adapter_fill_dflt_ctlqs(adapter);
> +
> +	if (!adapter->asq || !adapter->arq) {
> +		ixd_deinit_dflt_mbx(adapter);
> +		return -ENOENT;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * ixd_init_task - Initialize after reset
> + * @work: init work struct
> + */
> +void ixd_init_task(struct work_struct *work)
> +{
> +	struct ixd_adapter *adapter;
> +	int err;
> +
> +	adapter = container_of(work, struct ixd_adapter,
> +			       init_task.init_work.work);
> +
> +	if (!ixd_check_reset_complete(adapter)) {
> +		if (++adapter->init_task.reset_retries < 10)
> +			queue_delayed_work(system_unbound_wq,
> +					   &adapter->init_task.init_work,
> +					   msecs_to_jiffies(500));
> +		else
> +			dev_err(ixd_to_dev(adapter),
> +				"Device reset failed. The driver was unable to contact the device's firmware. Check that the FW is running.\n");
> +		return;
> +	}
> +
> +	adapter->init_task.reset_retries = 0;
> +	err = ixd_init_dflt_mbx(adapter);
> +	if (err)
> +		dev_err(ixd_to_dev(adapter),
> +			"Failed to initialize the default mailbox: %pe\n",
> +			ERR_PTR(err));
> +}
> diff --git a/drivers/net/ethernet/intel/ixd/ixd_main.c b/drivers/net/ethernet/intel/ixd/ixd_main.c
> index 75ee53152e61..b4d4000b63ed 100644
> --- a/drivers/net/ethernet/intel/ixd/ixd_main.c
> +++ b/drivers/net/ethernet/intel/ixd/ixd_main.c
> @@ -5,6 +5,7 @@
>  #include "ixd_lan_regs.h"
>  
>  MODULE_DESCRIPTION("Intel(R) Control Plane Function Device Driver");
> +MODULE_IMPORT_NS("LIBIE_CP");
>  MODULE_IMPORT_NS("LIBIE_PCI");
>  MODULE_LICENSE("GPL");
>  
> @@ -16,7 +17,13 @@ static void ixd_remove(struct pci_dev *pdev)
>  {
>  	struct ixd_adapter *adapter = pci_get_drvdata(pdev);
>  
> -	libie_pci_unmap_all_mmio_regions(&adapter->hw);
> +	/* Do not mix removal with (re)initialization */
> +	cancel_delayed_work_sync(&adapter->init_task.init_work);
> +	/* Leave the device clean on exit */
> +	ixd_trigger_reset(adapter);
> +	ixd_deinit_dflt_mbx(adapter);
> +
> +	libie_pci_unmap_all_mmio_regions(&adapter->cp_ctx.mmio_info);
>  }
>  
>  /**
> @@ -51,7 +58,7 @@ static int ixd_iomap_regions(struct ixd_adapter *adapter)
>  	};
>  
>  	for (int i = 0; i < ARRAY_SIZE(regions); i++) {
> -		struct libie_mmio_info *mmio_info = &adapter->hw;
> +		struct libie_mmio_info *mmio_info = &adapter->cp_ctx.mmio_info;
>  		bool map_ok;
>  
>  		map_ok = libie_pci_map_mmio_region(mmio_info,
> @@ -81,11 +88,15 @@ static int ixd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	struct ixd_adapter *adapter;
>  	int err;
>  
> +	if (WARN_ON(ent->device != IXD_DEV_ID_CPF))
> +		return -EINVAL;
> +
>  	adapter = devm_kzalloc(&pdev->dev, sizeof(*adapter), GFP_KERNEL);
>  	if (!adapter)
>  		return -ENOMEM;
> -	adapter->hw.pdev = pdev;
> -	INIT_LIST_HEAD(&adapter->hw.mmio_list);
> +
> +	adapter->cp_ctx.mmio_info.pdev = pdev;
> +	INIT_LIST_HEAD(&adapter->cp_ctx.mmio_info.mmio_list);
>  
>  	err = libie_pci_init_dev(pdev);
>  	if (err)
> @@ -93,7 +104,18 @@ static int ixd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	pci_set_drvdata(pdev, adapter);
>  
> -	return ixd_iomap_regions(adapter);
> +	err = ixd_iomap_regions(adapter);
> +	if (err)
> +		return err;
> +
> +	INIT_DELAYED_WORK(&adapter->init_task.init_work,
> +			  ixd_init_task);
> +
> +	ixd_trigger_reset(adapter);
> +	queue_delayed_work(system_unbound_wq, &adapter->init_task.init_work,
> +			   msecs_to_jiffies(500));
> +
> +	return 0;
>  }
>  
>  static const struct pci_device_id ixd_pci_tbl[] = {
> -- 
> 2.47.1
> 

