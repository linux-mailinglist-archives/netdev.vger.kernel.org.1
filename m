Return-Path: <netdev+bounces-307261-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F4wnH6YuVWoglAAAu9opvQ
	(envelope-from <netdev+bounces-307261-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 20:29:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB5D74E7DE
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 20:29:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=fU4I9PoM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307261-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307261-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 893F930421E7
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 18:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4043537FE;
	Mon, 13 Jul 2026 18:29:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2540E2E8DEB;
	Mon, 13 Jul 2026 18:29:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783967396; cv=fail; b=drsmC2R+oLYO6b0XvK6aK7QNxjQrprPPGBzbhVcGqkRFcz1k4WBo/nc5S69EjoJ6/xQgOR33yYTq3P/tqtdP6Rj5f/kQfpRlOHLgjbW36+xTodaVxUaLMI3YhGTnGpDjy3+mwok73666VxfHfuwXVKFqJwiYJe1bc/BgVBCueM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783967396; c=relaxed/simple;
	bh=U0mxUxImhuO7xdijTISqN+aZkYtq9zldaTNxmTb3jx8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jl9fe+2VX4ynWhduXj1QcWbFKT/Hqoaa5mbTDH92wDIjrfB1nwjPqCOK99U8kqVcCd6NWu0uoCEu00YIO1phxhfXQzrYxhLxgNf4gNTdNgFfwom5NGjxq3P4iLkqB8a+7oUb43ODyR/avI0KqYi1Yg52rXq+vvxdL7MFUQTBGYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fU4I9PoM; arc=fail smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783967393; x=1815503393;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=U0mxUxImhuO7xdijTISqN+aZkYtq9zldaTNxmTb3jx8=;
  b=fU4I9PoMll3gslReK9KDCo0zkZU4NeejI7B/3Z1GXjI3NI5VK8YWaUen
   +DcJQnK9SBzYHGQzBoH5/gpsT9WY5JYRsTTENoz28w2YhVkTAtZL+ZQN1
   C/BU5IksNftmvomGTwlLXuRGwSYVQ24llr7QWRdPpgq9VgTT8T6Gl7bsI
   jd/OhF7vblILWwKppEGfxTxhCWO0kdyXqWL/NcInr9IY5AcqsZ5MnGoSG
   SAOd8kkRlIcHdTIj9TSSZhp1xZiaxhavP01wIP5ZiUW8bYfg7MJyzn/VQ
   gFHKjtv8i1Gk7/XyxRhbIrb7iQAmxTe6Ta1/rcYcXqP4rWnBb27BunLd9
   Q==;
X-CSE-ConnectionGUID: Rw2l765fQOqInqnFXzV+tg==
X-CSE-MsgGUID: oiGZap8iT42k7EH3XTMocA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84777917"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84777917"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 11:29:52 -0700
X-CSE-ConnectionGUID: 8UmWu/FHTT+LDOyNUd7fgA==
X-CSE-MsgGUID: 7fQGgX47Q/GIvTp/qwhQBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="251681700"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 11:29:52 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 11:29:51 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 13 Jul 2026 11:29:51 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.57) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 11:29:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBOqy5iVwugAFhIBdQ+PFW4wANv78BJGvtiHV2nriGObDCU47Pd0bjj7/sn4ZAEigUtwJec4V+B3fKlhGu74fK1yi9WJVcmvgQVaGmYEC+2z/uZTfkRxmfcqwM7+6jiHewueroP9VGimemOEkJhUo93VnGjDdWwfviVNfBQSIVz6ou/+llSa8jwpSzFsUq1aM/nU94g6yT/lKHRN2tJLwGGLWay6N37R2oy3G+LapMjHosPl67CFMA9PHNbm6lGwYjFWQEe4xW7oAgoiZb15nqsKo4TvLv6Mwn55tYGxVF3ZTxJB4TEEpc8kVWkY9A7tOJtRcM3u6ZqvoXb8iVfSvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9USbHPzJ6DxRyIYEiYZqVSdxehoyeCdA7HOnnNjW03Q=;
 b=H8DVVRb6xnGY6M2jfRIZH2KaImba8TvvKSCahtOpmeEaHphm0m2xCJBxd46uEoyLa6SmG0H2lSV8ug50yWvcNmHcc6rG0WNYlk3/OY9pNkUNAnPwZaT+XXQ9yyHH3EHAY6Straf07bK3uWsMVReLer8PO7sHS58F7aEK6miYDk/dFGro0sQqIr5IxXWFUfXODRpXCjfHTNxMxZjTUihM4uchFZmlJqeizNynbWG5DLcZ57nD5ozfn+Q9ax8J6w/Fop+0bMHrdeKtHj1VmvmXrDMDNwHB/gpABBIifjc7rst8NtIAcKKiuhKkHqmSTbUp5v/ZpsS5xsy4O/sy3KffMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3949.namprd11.prod.outlook.com (2603:10b6:208:138::31)
 by SJ5PPFED9C9AC99.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::85d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 18:29:41 +0000
Received: from MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d]) by MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d%7]) with mapi id 15.21.0181.019; Mon, 13 Jul 2026
 18:29:41 +0000
Date: Mon, 13 Jul 2026 20:29:30 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<przemyslaw.kitszel@intel.com>, <aleksander.lobakin@intel.com>,
	<sridhar.samudrala@intel.com>, <michal.swiatkowski@linux.intel.com>,
	<maciej.fijalkowski@intel.com>, <emil.s.tantilov@intel.com>,
	<madhu.chittim@intel.com>, <joshua.a.hay@intel.com>,
	<jacob.e.keller@intel.com>, <jayaprakash.shanmugam@intel.com>,
	<jiri@resnulli.us>, <horms@kernel.org>, <corbet@lwn.net>,
	<richardcochran@gmail.com>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH net-next v4 00/15][pull request] Introduce iXD driver
Message-ID: <alUuiqh_VkGhQp7T@soc-5CG4396X81.clients.intel.com>
References: <20260710215313.1475803-1-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260710215313.1475803-1-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: WA2PEPF00000899.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::653) To MN2PR11MB3949.namprd11.prod.outlook.com
 (2603:10b6:208:138::31)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3949:EE_|SJ5PPFED9C9AC99:EE_
X-MS-Office365-Filtering-Correlation-Id: dd26b28b-13d8-44c2-af37-08dee10cb43d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|10070799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: WOzH/ku66JIlCjc5Hqto5khcQBD+DpvI9vrPLeKADmfvDOKJqSh3LLDT9qHyosA4RBdyKzbxAdlUzE2L/LrPvza2uQ7fg+EIble4svoytbPBMGMMfsPe0JYDzoHmJZS6B21HtDeSZpmMwJMSSe0UvDUZ0q4+2EivtlhI7lewb/I4XcMtG2Ka9pPDlE+SDtgo4pELyQgrqCtK7N5cXab/tbb8yiSk00X3F6uT1J68Zjyai2OZSpHvf5zdQBCDKA4brZCWNybQwbTvucb4vl+Bo0F/hCD5N6ykcbV4hKJPggKnsNpRQiG8c3K9KUv+aKB+1JTVjU/xE327ErV9XugZN4STd1Hi8elELxvmGBQK4eYmUoeC9b7DpxOj+7zmNJOUcm9IxIQnCRzeFi7TbWEH0sgGq9C53YvahHxnS3VlhtuJ5oYXx3vyScdtmCwqel3ClRFdlLnP9Pwk4a5hDoKnnzCtevRMhCpblWau3tHGDt45WKxXwfUtOyP6u2Y5VshCMeKDEn5K2dCeCzqGWiPEfb64d/1aXH1dfrTnasnzKj091iF1hKI3pBLrpktEAhnW7yEODkvmp7fWYd/FxI3aax9FQn5g62s4zxjy2B9YZHI+EwVoYiX9IlZNrLNdHQNjNo4alSFJtII84H06HHa7Gv92BNl5IhMjBWQgHcXYtAA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(10070799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FBafKyUCG98GEV5FYc0weOu3oX0Tz9IPH2hybfy2RtpnnpMSUIgOzpLqMZeF?=
 =?us-ascii?Q?yfid4JthkGaEO7Uh3deLyZU68QvUrXf7tAYimAcMh/cuvDmTsBL1wUlv/Jri?=
 =?us-ascii?Q?eSPOPcDyMtY9a6ds47vN/u/f7X24d9b5XtP9Gtb2awkYH6ra9/Ii+jzF36Xz?=
 =?us-ascii?Q?oUvvlwKMmSKGvoV48yHz41kr02H3fmKVoa6ZRWAyPEQe81KoGovU4MY76708?=
 =?us-ascii?Q?nEvH3YUTKK0/pjuFUu9nDzumguuLpeV97cZXAPYt/RGz/Z9MBv1U8PQz4bji?=
 =?us-ascii?Q?O8zTk2P6nNbKd2BTSfB1U/qtTQ8xDEdXP/XcZLopkYK+8/h791duDFqLrVTE?=
 =?us-ascii?Q?2OAmZXpnF+09lCk1jhcHDV7y7sFsHOW22M9Ne68ZINZ8ie8oh1ogTJ+bRB6/?=
 =?us-ascii?Q?V2Ffkpf59sj6SF1ETkJFUSumGri65ElLkCn8E5+kCLzMJpFfP31ITIaev9nG?=
 =?us-ascii?Q?s8vzQe5VgGa3usod8Hvx5gmEqoUJd5s4toZxRAMZw4iDo5tMST3g7F+hhxTT?=
 =?us-ascii?Q?VdH3bG/YERZN/eoVoD5oi4uIeQl71AqCAbKCFJIwTCqGxHueogs2f9+SUvU1?=
 =?us-ascii?Q?k+mQ9f5fwlfZN03YIgmlynyWqduEOlH5tLId8nUyhhr/3iOPFf1XMPiCtyj7?=
 =?us-ascii?Q?gORcIxbE6BJ4Unm42K1PPzYmklGJxSg6zOfaOYwby+2z4Ir0BHizwB8h3JjG?=
 =?us-ascii?Q?myI5QINIQzs986gbkrxi7t4snLdJzoprXaA4Ruec5ICTkpxUjRCDBjdtdxwC?=
 =?us-ascii?Q?0GjiBsgu7vK+Mf3e3N2UJsWFhH0ZG7ZUuczEiwGf7EE1oOQyviwTjefhe/0Y?=
 =?us-ascii?Q?OQWPFK5EzYXVRRT+fDdplfSPdgxA89coHAtyGzaAHeeFdKvxupp5jNWOsjco?=
 =?us-ascii?Q?WvA3p7tAOLpzWgeF7jbDJizzyc3Zo9v21IKtz86O3rjZ36P11GJn6vy2cshL?=
 =?us-ascii?Q?Y4aEry/DnDHKv5G/N3gQIPN94zDOYXOpfRiBKSITbrvS64gJ5WJJjR7XrSeM?=
 =?us-ascii?Q?2HXY6yY25WhYlUuotU7KFoh0eQL7+q8vQvcszkrUUC2fyYGKSNRiuoS+CvXG?=
 =?us-ascii?Q?Cg3kwEmNcuCJ9eeb7yplg5q51tU2w6+yltaYSiIqmN42MYFWL4LPv9zUXg8P?=
 =?us-ascii?Q?9id2fdFDL7VD+ohJLfCLFW6kp5Fvir1Dia9hZi3ymbQ7HtlZNa0LZQJF6y0v?=
 =?us-ascii?Q?lLLaflZQ8NcF1vA09Io3cbt7RZ7eJOOd1KjzPliaoDGQ2QA+s8q3JlB2znKK?=
 =?us-ascii?Q?tVqVT3TGuSltKGqs98Jp3fAqLpUziLDAoIHhlV2v3dTeV+wmcU6+qtVIYLXm?=
 =?us-ascii?Q?2hSCC3juhcKNdKk41Bog9wKZ8U9GKgQU9/9H5gvPvA0aoa7F6Zb4TH1UXoaX?=
 =?us-ascii?Q?WCgcJqFlbgBUH926hqbMgP51jNEDCYRv8YPMnpd5k/tRAZUk2C06tQ/2ZSiN?=
 =?us-ascii?Q?BLRJoHpJHONmVhH5mY3+/JJKvw2NsdacrqCtfUeAPxwMzBpd4X+denRSFz+S?=
 =?us-ascii?Q?dCHy3Ot2xXCg1neNLMUx2pMyEd3AsthM4Kd4uvrqYzfx4WDT7VwfN5cEXM21?=
 =?us-ascii?Q?YB8mxo+uqRqIBQnHvfGYtQPwm7jlvuQ9L0L9bwNXVoiDcAbu8aBCqDWL0N6x?=
 =?us-ascii?Q?dMFkAA431YuMYh/QGrIzvDxPXDGPdlBsAjutycfHnX9jcZcNPUTwGcaxoHhP?=
 =?us-ascii?Q?wwwp509AXBfS12BRSg38c6Q2USS59Vh3EA2QlfX8Thk5AnH8R8xjnJwweKKu?=
 =?us-ascii?Q?oLEms5S8KjiERUZ6J3xTzuyAg8mGoELfPa2SwZQsVXMUafGQ8klU33j7X+RJ?=
X-MS-Exchange-AntiSpam-MessageData-1: 7OTK+nhZPXoerbAEhtSvdj+u99Qu/iP85mo=
X-Exchange-RoutingPolicyChecked: P3Vx37vXKYC7SUw1uXvwKQHN4mn44IfdvtfYekktXVvkgCHByGJa7yU3xy1z3BjkOw1SUPvGMMwk4acR4ACCGbDm4h8nUgMQEXMpvOpefGRnKsdl6eFsro8WSvA3DLpS/C1YdzzaUXTve32QGgrB+yKDIEduAiJ5vvV8YFflPBLD7gr7ip492Q1MdDRpimu1ppu1MvTus+cvw11vSJ/q9LaJ9CndhgZxpGo9wgxLvxEgTuOgeT3HlTBOIukwRalft1BtP0V5Su76hyVtMdMCilV6OJpzgaUNmmsrA9wgsJnV3ce4fUl50V/E2j2963PIs3QN4L3owPw1ClwGPtZyiA==
X-MS-Exchange-CrossTenant-Network-Message-Id: dd26b28b-13d8-44c2-af37-08dee10cb43d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3949.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 18:29:41.6735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2dAtrUDsq+JzRKLjafFgGFrpED4IGNoELHXDKTPbl3MUqnlLVHzL4UDSnYMJeeXD3VTg8X9e+jN0fy9ERReTiFw2ozlUvfta4aWreNkOfP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFED9C9AC99
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307261-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:from_mime,intel.com:email,intel.com:dkim,soc-5CG4396X81.clients.intel.com:mid];
	FORGED_SENDER(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:przemyslaw.kitszel@intel.com,m:aleksander.lobakin@intel.com,m:sridhar.samudrala@intel.com,m:michal.swiatkowski@linux.intel.com,m:maciej.fijalkowski@intel.com,m:emil.s.tantilov@intel.com,m:madhu.chittim@intel.com,m:joshua.a.hay@intel.com,m:jacob.e.keller@intel.com,m:jayaprakash.shanmugam@intel.com,m:jiri@resnulli.us,m:horms@kernel.org,m:corbet@lwn.net,m:richardcochran@gmail.com,m:linux-doc@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,lunn.ch,vger.kernel.org,intel.com,linux.intel.com,resnulli.us,lwn.net,gmail.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BDB5D74E7DE

I have addressed Sashiko's feedback for each patch.

Those are the only 2 important changes that came out of that. 
Please, notice that the first one is not a functional regression, but a memory 
usage issue and I tested the change.

commit d7a772efb77228a1b12558dced6b1fdfeef123c4
Author: Larysa Zaremba <larysa.zaremba@intel.com>
Date:   Mon Jul 13 17:02:01 2026 +0200

    fixup! libie: add bookkeeping support for control queue messages

diff --git a/drivers/net/ethernet/intel/libie/controlq.c b/drivers/net/ethernet/intel/libie/controlq.c
index c043c07dbb89..8e7b2783b86b 100644
--- a/drivers/net/ethernet/intel/libie/controlq.c
+++ b/drivers/net/ethernet/intel/libie/controlq.c
@@ -720,7 +720,7 @@ static int libie_ctlq_xn_init_dma(struct device *dev,
                        goto dealloc_dma;

                dma_mem->va = libie_cp_alloc_dma_mem(dev, dma_mem,
-                                                    LIBIE_CTLQ_MAX_BUF_LEN);
+                                                    LIBIE_CP_TX_COPYBREAK);
                if (!dma_mem->va) {
                        kfree(dma_mem);
                        goto dealloc_dma;


commit 740e3b2dc9fab1ad24ee7fa1420d0c7025bc89ac
Author: Larysa Zaremba <larysa.zaremba@intel.com>
Date:   Mon Jul 13 20:25:21 2026 +0200

    fixup! libie: add control queue support

diff --git a/drivers/net/ethernet/intel/libie/controlq.c b/drivers/net/ethernet/intel/libie/controlq.c
index 0392608856c8..c043c07dbb89 100644
--- a/drivers/net/ethernet/intel/libie/controlq.c
+++ b/drivers/net/ethernet/intel/libie/controlq.c
@@ -509,6 +509,7 @@ void libie_ctlq_send(struct libie_ctlq_info *ctlq, u32 num_q_msg)
                if (unlikely(++ntu == ctlq->ring_len))
                        ntu = 0;
        }
+       dma_wmb();
        writel(ntu, ctlq->reg.tail);
        ctlq->next_to_use = ntu;
 }



Other changes are of much lesser importance. Look at particular patches for 
details on nice-to-haves and false positives. Here is overall nice-to-have diff:

diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index 5a191644b28e..184d30c12abb 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -265,8 +265,9 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)

        err = idpf_dev_init(adapter, ent);
        if (err) {
-               dev_err(&pdev->dev, "Unexpected dev ID 0x%x in idpf probe\n",
-                       ent->device);
+               dev_err(&pdev->dev,
+                       "Failed to initialize device (ID 0x%x): %d\n",
+                       ent->device, err);
                goto err_free;
        }

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 04a0421c1b77..d768b63700c8 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -2931,6 +2931,8 @@ int idpf_init_dflt_mbx(struct idpf_adapter *adapter)
        adapter->arq = libie_find_ctlq(ctx, LIBIE_CTLQ_TYPE_RX,
                                       LIBIE_CTLQ_MBX_ID);
        if (!adapter->asq || !adapter->arq) {
+               adapter->asq = NULL;
+               adapter->arq = NULL;
                libie_ctlq_xn_deinit(params.xnm, ctx);
                return -ENOENT;
        }
@@ -3993,7 +3995,7 @@ int idpf_set_promiscuous(struct idpf_adapter *adapter,
  * @send_msg: message to send
  * @msg_size: size of message to send
  * @recv_msg: message to populate on reception of response
- * @recv_len: length of message copied into recv_msg or 0 on error
+ * @recv_len: length of message copied into recv_msg
  *
  * Return: 0 on success or error code on failure.
  */
diff --git a/drivers/net/ethernet/intel/ixd/ixd_virtchnl.c b/drivers/net/ethernet/intel/ixd/ixd_virtchnl.c
index 66049d1b1d15..5b04769443b9 100644
--- a/drivers/net/ethernet/intel/ixd/ixd_virtchnl.c
+++ b/drivers/net/ethernet/intel/ixd/ixd_virtchnl.c
@@ -120,8 +120,11 @@ static int ixd_handle_vc_ver(struct ixd_adapter *adapter, void *recv_buff,
                return -EBADMSG;

        recv_ver = recv_buff;
-       if (le32_to_cpu(need_ver.major) > le32_to_cpu(recv_ver->major))
+       if (le32_to_cpu(need_ver.major) != le32_to_cpu(recv_ver->major))
                return -EOPNOTSUPP;
+       if (le32_to_cpu(recv_ver->minor) != le32_to_cpu(need_ver.minor))
+               dev_warn(ixd_to_dev(adapter),
+                        "Virtchnl minor version does not match, proceed with caution\n");

        adapter->vc_ver.major = le32_to_cpu(recv_ver->major);
        adapter->vc_ver.minor = le32_to_cpu(recv_ver->minor);
diff --git a/drivers/net/ethernet/intel/libie/controlq.c b/drivers/net/ethernet/intel/libie/controlq.c
index 885b4437b4f0..8e7b2783b86b 100644
--- a/drivers/net/ethernet/intel/libie/controlq.c
+++ b/drivers/net/ethernet/intel/libie/controlq.c
@@ -327,7 +327,8 @@ libie_ctlq_add(struct libie_ctlq_ctx *ctx,
 {
        struct libie_ctlq_info *ctlq;

-       if (qinfo->id != LIBIE_CTLQ_MBX_ID)
+       if (qinfo->id != LIBIE_CTLQ_MBX_ID ||
+           qinfo->len > FIELD_MAX(LIBIE_CTLQ_MBX_ATQ_LEN))
                return ERR_PTR(-EOPNOTSUPP);

        /* libie_ctlq_init was not called */
@@ -493,8 +494,6 @@ EXPORT_SYMBOL_NS_GPL(libie_ctlq_send_desc_avail, "LIBIE_CP");
  * The caller must hold ctlq->lock. The intended pattern is to first check
  * the number of descriptors available, then fill in the messages and perform
  * send within a single critical section.
- *
- * Return: %0 on success, -%errno on failure.
  */
 void libie_ctlq_send(struct libie_ctlq_info *ctlq, u32 num_q_msg)
 {

