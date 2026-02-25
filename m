Return-Path: <netdev+bounces-261029-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEJBGEwvn2lXZQQAu9opvQ
	(envelope-from <netdev+bounces-261029-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 18:20:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7073119B717
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 18:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C0913300ADAA
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 17:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8C13D7D8D;
	Wed, 25 Feb 2026 17:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VPW8dajW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAAA3E95AB;
	Wed, 25 Feb 2026 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772040006; cv=fail; b=R3nWFWmA2nO+u1PNok4ilfh/umM30Ac2Qoli0pu61sY4hfBu9Z30xdJUAhjhE7N+Y27wqgrbghKttvckB4Hs1afiOym/hg8ruCx/4aa3v+bQGUOn1Heg+ZW/+7N+OfmE61Tln3o/Jwr6t0t3BDqDOxIHW71/fNrkW2/+h8sHAbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772040006; c=relaxed/simple;
	bh=oL07NrC0/aSPZI7dFybcfzDgYu6AhUnHp1GYwPmiD6Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hacKlQWwmvHJUjFOglvYeePVEhA4iZuH94/8h2sm3mLqG4sTz+8/pI/qh7pgWjDOSK5O2ggbU+80RNPNIXIroQ+lJ2xsWl/jmIyLgWlKQCr8KbZ3vaoEgOp3W2W5S0OVSrcoGt3R7Ml/lOYYJ2FhzQwrOxHoylywWi8hKAxLSGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VPW8dajW; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772040003; x=1803576003;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oL07NrC0/aSPZI7dFybcfzDgYu6AhUnHp1GYwPmiD6Y=;
  b=VPW8dajWNN+EbZ/T8erbEtDMmBZSm1EU4Y1R72pJ+8Mf8W6zJeqG9KdC
   9E981dVbGRLEU8VfZ5v3kNsbPIGQcR6vIi/+V4YYEGtgFXi1iPIW3ljGH
   M1ryEDbrbS7/BfC/491iByIDjz+KDJmzHYyXfYqQkg0Q+pA4epUSwnAOW
   Ny/W7Dx0AD7XwaYvGW4BJ9C0XLZGs9e59zFM0grXhu3wCm6bub85+8l8i
   TFIhKmc3wBSFJUF4BtZmN7QDGyLvyJ7hEI8MIkdnXTBgD8n9JS4Y+wrAi
   Rd5xbjj1A2psy/yNtNInkAtu9wG5SnTZlz7eXDkb4WRBCLCW37j2yBYLv
   Q==;
X-CSE-ConnectionGUID: VkJvZwdqTWSbBOnIb9DrGQ==
X-CSE-MsgGUID: l4KQxHpyTRqZD0bMiR4ouw==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="83418025"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="83418025"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 09:20:02 -0800
X-CSE-ConnectionGUID: Eh7ynHQORSeELTV0rHtCmQ==
X-CSE-MsgGUID: ZnrCiSeKSuKHewxB3ZUBew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="215064444"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 09:20:01 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 09:20:00 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 25 Feb 2026 09:20:00 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.9) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 09:20:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UFlx9+LsxUH0f1NAPiorkSU0t7uhAVm6CqWfk2QbZ/zfAFDzLRdAo5JAv6l9A0n1qZu/PzkfucTRfpEAx6c+pM2OuHQ/pKk8pzCt1VWo28vnSTsx4TknpBU04wXNIHIy3TWgzF7R/NhaXeMspx9CZx3LWiUlg6JN6s2oTQlWzv37JN+EXZlSR+bhmEK5DYXjAhvUxJDBFf5kKVSi5qCN18jZ2kpdvsbu5Qs8VJKnNYdFJxOi1Vdd4WQhGoR811HTDU/QK4yCO4sSXudP97YEPBEOOxgUZbFJuXEQJO05mQ22p6FhJ7GyYuSfPlccpkKFIOqoNuQO8U/3+5NlmPzlRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egjavjbdxBH3x0FZt7f1wlVnBb6pFcVzJ7NgXA8A9No=;
 b=SLA00SBq2Ic6SlSsp7B1+CPh4BlU9S+UQKWiB/WpLSLIxhcSQag/wTLVxCXugJCrNuqMZf3BV4lZrZqsv/X/WaRlhUnPtiRLc/C6tZTYKPIk1WtqAP5YShhmnrfOT9joydQ1Um7CfBp1rrvjpplAEZHg1yPpinY2sCTdFCPIsDOahQkP6vGLLzsrJhzKqH6kBimy++a/lnyZN4H+tWNpWg+hoihN/izqJ9APW7pSN+6WazstcHBsQiexpVhm80xdIy5yKJmEHm3EL6qj5EDdHrns1Eh0aLef4x6uoZGA8xoJlkD52xXldKySFWb6EizEkoHff9uvL0aKtiqpJk0ipA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by DM4PR11MB5994.namprd11.prod.outlook.com (2603:10b6:8:5d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 17:19:57 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b%4]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 17:19:57 +0000
Date: Wed, 25 Feb 2026 18:19:48 +0100
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Simon Horman <horms@kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexander
 Lobakin" <aleksander.lobakin@intel.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
	<hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, "Stanislav
 Fomichev" <sdf@fomichev.me>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Natalia Wochtman
	<natalia.wochtman@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH iwl-next 03/10] ixgbevf: use libeth in Rx processing
Message-ID: <aZ8vNEn7V4VVoOHr@soc-5CG4396X81.clients.intel.com>
References: <20260223095222.3205363-1-larysa.zaremba@intel.com>
 <20260223095222.3205363-4-larysa.zaremba@intel.com>
 <aZ3jzpKs7VcVi-mL@horms.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aZ3jzpKs7VcVi-mL@horms.kernel.org>
X-ClientProxiedBy: VI1PR04CA0061.eurprd04.prod.outlook.com
 (2603:10a6:802:2::32) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|DM4PR11MB5994:EE_
X-MS-Office365-Filtering-Correlation-Id: 33d6ba5f-0412-4f0a-771f-08de74921971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: aj7QpNxMH/TqEmLF+w5OJ5p7Tcdf5K2/r5GHuPJpsGJJZYTdLQ7MO/PJhuwGupOoHXMQD7XqFCS1dSkQznqznhu2mPwFvq2NHBtd+618llWAMbZsNzdMh6mbmz/FBczorySj8PMrVKz+5Gr4SZhOXqYlrwEMHmVSebUTu1Deh20qB1oPA1acGgPMKGMoIlSQyk1c8HvUfqK4AdX9ggXoKI72j7UM9YUF+HOYrenK9jBzzGO7BdK3F4cSmfeIZ4jsEXt3ianiNEF7b2CDoy0udis/Ib9wmN7DZqTMT0Hw/5J++UNbWSlH/ynPvbkzCRNMxfygr44VbkFPQAYSOpD1jErSQk3GUpif+uzZaVch04fK1gQOzpDcj0cCiaj+S5Cc5W9hH6OkRM1LOl0UA9ttpkb7MZAzYVISbOCrhotGPxIZSwrJb6Tf3Q6VVp9yc+f4lr8ZSLo5G6UkYCC5a9ueUMPi2XJkbunuW7rUiZ689d7kGOesaD+KgCP9iezkARjiWeA0/XWXX+DHzvbmqAb+9ZhSNNP18f7Ovrd2dKJ9ZwCbv7s2UtoWANzsooIvTLmRbvo+ZfqNKg+Lwo2rqdjy0MSvNS5UcUeR8lxFl7a6FzmtlkarYcXcvCIbJgrqypYvvtxjmBzp0ESifyejv8pzy3BC2HpfAXw08lzDbBTQ3MURNTv9C+dEAIcn25L9BV3u9BLSggNs5cjGLGyA9xIIW7CrF1h5cvvnPExwAYBqOhM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AKcNYOt1gaAYU1nlVmd62KtWPVVWQNMGvmIVEFRp8PtSAxdnN+x/Z6LbHOnK?=
 =?us-ascii?Q?W2AGJzKqqrZySETIbh9u/0hFNUQagVt+FdWWA2yRam5HtKXoCLTLuwMHL4Kt?=
 =?us-ascii?Q?n1QpJwzqrH/DxXma2Ojr4hahEifqymGpUTD+RLgpkk7/wnqHMQoNCZqCdcI9?=
 =?us-ascii?Q?OoYbX9ES1XIten/xMR44bR6CGbR8/xR6cOO0WyKGNzDRXBwCOUFC53ioGqPi?=
 =?us-ascii?Q?/7SohZByPogD/bXzmFiCRT9LVz499nuvWAsvAeDXvjxHcuoY7OMshNo70Rz/?=
 =?us-ascii?Q?xAobXnR5CIc/xkdyWVKxWmOvV33WjO0OsmpkH85n/t+DFjhXL/oBpzdusm4k?=
 =?us-ascii?Q?k9QuWj0ZfegFHlYWw/gKiHvyaew+ks68zfL77EnStPCKu6OXVZGKjvIZYbEH?=
 =?us-ascii?Q?wXvcOY7WHoMdwW0qsDiY8W13v3bsXgm7DtTAgXNqrIaXBeBk1U9ZZrmrYQe1?=
 =?us-ascii?Q?obavPHj6ShGcHpbhy74604NyEOst5y1a0E83SM2hi4N5Lqjc5S5E+lr/a6mh?=
 =?us-ascii?Q?nKALOZAvZGiHWT8tfEJYRt5X9P/73KY8pDgxU1QA1Stznqow27APpkwwsuoi?=
 =?us-ascii?Q?vEqeD3t+vwsB2LHuu9MujvX245eln7sESwxGxGFY0MN11drLy62AY7/IY649?=
 =?us-ascii?Q?rLJ9u8bCEc6Y7hX9hgwG5sKV/9FB4S5KQS6KIXR3qEXLrDnj2EntEem8aDE/?=
 =?us-ascii?Q?piJKAF0yWeW/aeBrsW7+ifQZ9+9OF1c3sDsLtvWf/Jh1AFY25tgg8vrW7ZBz?=
 =?us-ascii?Q?iXrsViLiZOR+CO7VEz966FJIjEOVVtlNyzgVk6BkBUDpT1oaJfmPQU1iBiuB?=
 =?us-ascii?Q?T9hGVrBxHtjgOtZINU/jA8D7LjshTqQUfK+Pm1DKR/MI+J4Q0Lin3jil/j4h?=
 =?us-ascii?Q?Ff0Me3C606MdgTdz3NH/ARiF9odiH3XNXOEDqqZoB5LdnRpj4ejefUetTktC?=
 =?us-ascii?Q?KZtVpXSeomaPRAozz0TRuWawkVZvoJdl1zDPfZgjGOrJyyT6nM+1oYfH1aNn?=
 =?us-ascii?Q?DjRzztIhZ3EEtZC6ZPqsqpIKdt85lOv12d1SyaZIuC0JHm6qQdPu7PGFMvP0?=
 =?us-ascii?Q?tAdyPNOnCxXLkn0zIPBrbR3HW+rcPWfqljaLW2YGOwLnQ8kHEsGXRTe1UJCJ?=
 =?us-ascii?Q?QKSjyqi/105aAGcAZcc85rZKEFq8zoLlXnecQI47jaXo1IDVFNk5GYEv6IDa?=
 =?us-ascii?Q?nk+Y+hXzdU2M5/I5er/SHHCe3pDEgWlxchie83Qy/M7jhaXasjztPtxR6KQI?=
 =?us-ascii?Q?ARXx1LsQiG+T6NKilN6B/9hO+lbPHXz0Iuq8wD4rVqZYYjY89wqM41H3MMA3?=
 =?us-ascii?Q?GKkPQCQb98RUW5zCBQ+/w4cfftwWrAsJ/wrHMPdW3GXLEH6cypji2JRgRCwt?=
 =?us-ascii?Q?cvOy+tOvFE1O8AipDMxQcKoCN4s/HT1QoaiE74kc3/6mE0/nZF87ff2VQZu2?=
 =?us-ascii?Q?0z4ZKtkUc9j9K8lpg/p+TYFP5lsvQkBGfZH9NH+0lcYFtcELZodfiRR2VIM/?=
 =?us-ascii?Q?u26wFaSqe4RoQIbKw6N4U04rbQP0YRW1Xoea8fqlXSqgGYPBtU/53IzjUzxZ?=
 =?us-ascii?Q?7c2QOdxPNLkIvvJGaT7GnDuLm9wr7wsE8G2SY2opzzOueewOrUQnzOz9T4lk?=
 =?us-ascii?Q?h7iVodlliiaOqy0cVWfrq28LO5otodSJ0qpNdb4gGUS+N5I2unHH/qV8+LVL?=
 =?us-ascii?Q?OglIqTOzJ2M+YNCxmk7MlBcmtiyUQiym5uU6VMc4mm1AAy0KkV1d3baOEph8?=
 =?us-ascii?Q?1QAv8De82OLVjZqymBiqmSyfvSRFt3H9GOUxGOTk74DvwJkhMJFzOqK/wBjV?=
X-MS-Exchange-AntiSpam-MessageData-1: oQSIBFDwZpXUFl/oH2tmiv/jNJM0txSQ/60=
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d6ba5f-0412-4f0a-771f-08de74921971
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 17:19:57.6859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Au8sGGeiHeKEMk6v2xWeypxunWslalu1jsPQZSx5gmWWROHfP6S1mDcJD7EpSsxOuVTdrJsEREUEyy3Kq1av1pJuE7Ca//idMAKO0MvIDIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5994
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261029-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,lists.osuosl.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 7073119B717
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 05:45:50PM +0000, Simon Horman wrote:
> On Mon, Feb 23, 2026 at 10:52:10AM +0100, Larysa Zaremba wrote:
> > Use page_pool buffers by the means of libeth in the Rx queues, this
> > significantly reduces code complexity of the driver itself.
> > 
> > Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> > Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> 
> ...
> 
> > @@ -3257,12 +3133,26 @@ static int ixgbevf_setup_all_tx_resources(struct ixgbevf_adapter *adapter)
> >  int ixgbevf_setup_rx_resources(struct ixgbevf_adapter *adapter,
> >  			       struct ixgbevf_ring *rx_ring)
> >  {
> > -	int size;
> > +	struct libeth_fq fq = {
> > +		.count		= rx_ring->count,
> > +		.nid		= NUMA_NO_NODE,
> > +		.type		= LIBETH_FQE_MTU,
> > +		.xdp		= !!rx_ring->xdp_prog,
> > +		.idx		= rx_ring->queue_index,
> > +		.buf_len	= IXGBEVF_RX_PAGE_LEN(rx_ring->xdp_prog ?
> > +						      LIBETH_XDP_HEADROOM :
> > +						      LIBETH_SKB_HEADROOM),
> > +	};
> > +	int ret;
> >  
> > -	size = sizeof(struct ixgbevf_rx_buffer) * rx_ring->count;
> > -	rx_ring->rx_buffer_info = vmalloc(size);
> > -	if (!rx_ring->rx_buffer_info)
> > -		goto err;
> > +	ret = libeth_rx_fq_create(&fq, &rx_ring->q_vector->napi);
> > +	if (ret)
> > +		return ret;
> > +
> > +	rx_ring->pp = fq.pp;
> > +	rx_ring->rx_fqes = fq.fqes;
> > +	rx_ring->truesize = fq.truesize;
> > +	rx_ring->rx_buf_len = fq.buf_len;
> >  
> >  	u64_stats_init(&rx_ring->syncp);
> >  
> > @@ -3270,25 +3160,29 @@ int ixgbevf_setup_rx_resources(struct ixgbevf_adapter *adapter,
> >  	rx_ring->size = rx_ring->count * sizeof(union ixgbe_adv_rx_desc);
> >  	rx_ring->size = ALIGN(rx_ring->size, 4096);
> >  
> > -	rx_ring->desc = dma_alloc_coherent(rx_ring->dev, rx_ring->size,
> > +	rx_ring->desc = dma_alloc_coherent(fq.pp->p.dev, rx_ring->size,
> >  					   &rx_ring->dma, GFP_KERNEL);
> >  
> >  	if (!rx_ring->desc)
> 
> Hi Larysa,
> 
> Prior to this patch, if this error condition was met,
> then function would return -ENOMEM. But now it will return 0.
> This does not seem intentional.
> 
> Flagged by Smatch.

No, it is not intentional, though the problem is fixed in a later patch. Will 
correct this one in v2.

> 
> >  		goto err;
> >  
> >  	/* XDP RX-queue info */
> > -	if (xdp_rxq_info_reg(&rx_ring->xdp_rxq, adapter->netdev,
> > -			     rx_ring->queue_index, 0) < 0)
> > +	ret = __xdp_rxq_info_reg(&rx_ring->xdp_rxq, adapter->netdev,
> > +				 rx_ring->queue_index, 0, rx_ring->truesize);
> > +	if (ret)
> >  		goto err;
> >  
> > +	xdp_rxq_info_attach_page_pool(&rx_ring->xdp_rxq, fq.pp);
> > +
> >  	rx_ring->xdp_prog = adapter->xdp_prog;
> >  
> >  	return 0;
> >  err:
> > -	vfree(rx_ring->rx_buffer_info);
> > -	rx_ring->rx_buffer_info = NULL;
> > +	libeth_rx_fq_destroy(&fq);
> > +	rx_ring->rx_fqes = NULL;
> > +	rx_ring->pp = NULL;
> >  	dev_err(rx_ring->dev, "Unable to allocate memory for the Rx descriptor ring\n");
> > -	return -ENOMEM;
> > +	return ret;
> >  }
> >  
> >  /**
> 
> ...

