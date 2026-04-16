Return-Path: <netdev+bounces-279005-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIekGSrF4GlelwAAu9opvQ
	(envelope-from <netdev+bounces-279005-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:16:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F3A40D3B2
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8FF30312DF35
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 11:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A9D3A7581;
	Thu, 16 Apr 2026 11:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SRDlAvvf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32423A6F03
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 11:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338046; cv=fail; b=Qio+aUHJtYjFX74w3bliQepWwaksWNsCq05V3lsYhkM4eKhcFSdlQ1xp21ul6RHQTJHrjHEPqkwpssGIApFPuiBuICAzTlCugJsU/X6LH7tGJ2KvLpkEr8HeJUqw4LwBUkxUWVlNoy8/GON5EDtCfak7ws1CQ9qUyFJvKgys2yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338046; c=relaxed/simple;
	bh=fG5Vfw13J/9oPhqCc8vNHsQqeRItOK7Xq1QKJkbJVJM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hYMTYRte0ottJZUmOZuJ9Dcx+IEd8BTOPxvlQR3gFuQHCfXSYwZ2P2IiLtF3QgA6SgvEbiDb3uwdpHBtDfE7+C2hcQjjJLgmttcM9HDm8J6EHPSLoMJIYUda4cDqiHL0uVqIedE1VRGuMCtNULwUW8WDci0chlBa1jskJYHXNII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SRDlAvvf; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776338044; x=1807874044;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fG5Vfw13J/9oPhqCc8vNHsQqeRItOK7Xq1QKJkbJVJM=;
  b=SRDlAvvfYbBA4pytFlzsCbzdzZQrhEG5XlEQ6p/RGcUtM5vFNG2gyFi2
   sFKGsnkE/fLJVcWytY065LGMibQFgymdY992wiIxUK3wOB8fBl5MdI30Q
   y85fDbPqNECZOJCMuRlbyJTAp/HWzNi9QF/W5wsK5H4nxh8cBpJXdHi8S
   NIsrMIW4mJF3mXhFKWBf7BeOGizcLzYgMBvm/BcqEko4buIy3vanCDu/5
   j817TtI6P5QuDppRy/uyBQXHbWjlNl6pVl8XBd4KTfG9fes7p9zduuS2f
   WPMBmoboeAFjr43eo0OtLatWLyTp3jhEEBX8zlhh5Vv8S8LjXmsaxIfG7
   Q==;
X-CSE-ConnectionGUID: rWHnjxTnS1ujCAzk7WvxIg==
X-CSE-MsgGUID: OifLm/fcQSqBtl4OOXqs5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="76366288"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="76366288"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 04:14:03 -0700
X-CSE-ConnectionGUID: vzb7v9CDSVOxl1ucuMrV7Q==
X-CSE-MsgGUID: bkdOizJIRgqj+5HLfvfWBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="230948002"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 04:14:04 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 04:14:02 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 16 Apr 2026 04:14:02 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.8) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 04:13:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SuuVmqHOeJGfsY7hAnsmbIBeXkF072H4MhGY2SmxQw7K2wXGxhHJM2joyqcunx2yN6d54JmEE3dX5ItyKPwQhmg1rlBa4T7Mi0rkmZdbt74LuH3V1SLMjzBa5ivnsdIfAT9VZzmemlOSq5Xmfu2zLnzNC64d9IkhIAtdMIDWuO7mfI82UuVa4qZ6z4L5QzUAaeUGm8y0XyAWCjwXA1xbXBSfGtmecNUiF8StVarf8rlLNCF4I8+28GH6RBERMGdduyGuYfDEYz0Rq0Q3jnwOfyqTTafcdIcMABJBQMWC38KGiNsQ+iCHzkFLowYjnIl6YBhyG1A59j2uUhu2OK8cqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDPf5RyN1LaUkFaXyWPMMCuUbTcJBwHEcedIqiWCBoY=;
 b=LBFEGMROF5pThB6g2G7+zZmsfQUMJ2W7gJGSDAJRi9oXhb2JcmJBfFwQmvCJ3N7mJkVZ8IeC047/nR0ZquD0XS9IosgcyqkiYdyGs71XaHWnC6fTAcs7BXAtYzXjzok2L0Xt5007MFNN7GQh0esIX5llygcygOLt6/k8ZHp6R8WZzVHmVCU95w1K4koLrSx5vhuSzouzVh6ney3VIl16up4jdXKacGitIyGxWuk9JYg+fgD986B7yxcWX77tNJrSgiPY+lkSW/LcciR7yyBcNjaLp5eZGLgz20rPrCZeUl+b/J7sWDjoE1w8CeQmOBdEW1Y7A6DvLflqJF85rwhfgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH7PR11MB5818.namprd11.prod.outlook.com (2603:10b6:510:132::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 11:13:02 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.20.9818.014; Thu, 16 Apr 2026
 11:13:02 +0000
Date: Thu, 16 Apr 2026 13:12:53 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <przemyslaw.kitszel@intel.com>,
	<jacob.e.keller@intel.com>
Subject: Re: [PATCH iwl-net] i40e: keep q_vectors array in sync with channel
 count changes
Message-ID: <aeDENQXk8Mz1elXb@boxer>
References: <20260414121405.631092-1-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260414121405.631092-1-maciej.fijalkowski@intel.com>
X-ClientProxiedBy: TL0P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::13) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH7PR11MB5818:EE_
X-MS-Office365-Filtering-Correlation-Id: a5a782fb-e190-491a-4f65-08de9ba91fd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: wbmnWN6sDlUQy3BRBQyDO7aeGLkuA5LVkCH+9MHnj94w3/HJOkGKbGtvVCa6pxzUPIaX1BmuojJhoJmCn4oy4kmocmhI+Fd4w+uIeos8evpcHDHnbn9NJU0BO5OPyenNY05fsg/FTRpQJkx4Hmd1OkdrpWPfr+ZsGrz9i/dAJk6MYcMQ8L4zjMBbQfUuRMTsbrPK3GZAYc90khOGGjMcW8JOoVPKpmG2XU2OiPDSaotD1L9pS6i5wOjtcSU29BmPrar0q0RC51RgcbhOp+m2sWlG3QX0bbb7eeXeTBrBxHSX97Bt6vQl70oIeq3CSrqaft3DLwwzMhY8P3TgZFluUba8/Z6h2/ienjsWhdwseTKYHykXF9jxf9b/RzLwjTX5PT3H7Z4ziFDAGILEsmONZFtLV27v5hXNDpHXs7lupEaHL9JiM2oYaNVDZCv4mzIMv/i+vuGKN+pjHZwzGi3Updi8GtJaHeLXrJ9ObQCBkzikI0m6/JyvhUUQcyXi27Fs1eKdO9Hr+IxY1WFcn6F//4NVq7TPAQRrZzGwbId+ZeiKAaEp732G+/nbsLqvAOTvK4fM4aRN2FIm2/FBlm8J9E6cZjmtLDeqrAbtJLIAeB5bEgMbLOnfOKaOmcefN8e/ljfm4MPy4vMLg0FRy6DBf56qwrXjyDF0ZHFfL2csnaprJygwWCODGO8OWvciOKLaVl/iPbiqj1jbYx4iLa34Lu7iXvQ/SVSHrSpzEa4h4I/MLDxZIW4iJ3c/T20r10mk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DY6MVmYc5ajLiKlxg9wHKI77TJPnG9c+0+NNELqw9aYRkNyyheIsHu9YYzlX?=
 =?us-ascii?Q?mxeYWoIQFx5Sh5JiHlFIzjxis3MN7Na/+tiNQ6jkPAX6/R7h2+kv1YtozVyi?=
 =?us-ascii?Q?TMODaIGVDPC6wBEuj4jBO2k9AzcDsOtCd9PQ00HiMmcgXShnjqazc77hCCNx?=
 =?us-ascii?Q?qvcPQ1bp0ksDqQDnynbTtTlU2x+aBVDAx2FjIvyz0kBwDtwA4Urq9NggKbYM?=
 =?us-ascii?Q?GTVJV19xCD7XYoR+wNn0vhs1VBQ7neBKZoePTc+WHJ2YTq0PRo5QyfmOi48u?=
 =?us-ascii?Q?7k1Pl+/2Zpu8KzhQvNlTAq2j1cc3D7p+8SBnVKeQajkl6Xd3pdJb2r/Ki53Y?=
 =?us-ascii?Q?Khx0rHCQvxyWinSMVSh3iwonCwMP+WN0/tkegFly1lPQWQj4jH6WspoMIzpZ?=
 =?us-ascii?Q?pKqYcg0D+xdcTXwx8kENFeugwalzG/m1lTHXo1i1Pwr5B7aMzgb1zNmabSZm?=
 =?us-ascii?Q?f2la31Ahaogsq3aczazL+hl6RCWBTvYkWuX9zvnRiSF1/JJjp22gZCuRT6yl?=
 =?us-ascii?Q?lgUO6out0ruXmkD1f7oa4s7gHz5yJVkRcpA2ye9zf1XsNRCK/hOPcqNNqBUb?=
 =?us-ascii?Q?ho33seZ2vwenKc9htWw9ArwbFALIwCo12oJkLjMFYtJLKzzMGTC85nxmCj4I?=
 =?us-ascii?Q?d37Lk7unJpxseBhJnWS9+SqwomlS29jm77way1O2UAMy2M3SKC0RYnWQeCTe?=
 =?us-ascii?Q?Wg559lTwgzgibH61mr3w3gs/xLLkcQxSbmvve3AMs4E294bBbz1/REhBVHBp?=
 =?us-ascii?Q?A7CT6bCx4E/4aO+CzUriwEDfp6zLKJ2X2Hp6H7ev8+qyLnWceteNrubFV9W0?=
 =?us-ascii?Q?i/kRiR509Bc1Yx9vqWobOtjtppHWgulKVzm/MP84R1FYWpIYFKiAKc/NsHar?=
 =?us-ascii?Q?mRt9ABF/Y6wyLHWURZ7iFFDOYFvbROELCSL0XZxup6rL+PoU48FJ1JzNoDa4?=
 =?us-ascii?Q?Pfm2wO4UFcuG9m2Wz8bTXGpGVZ1te+1kT3EAG2MDO6rSgNaoJMWXxTkCiRut?=
 =?us-ascii?Q?aeYiejMMe+qDOKewZlU7WuKV/9F6BWof7FimFXw2Yro81nQ38/ortIXFcdLK?=
 =?us-ascii?Q?1MoDP4fAvRIospHZR/cNQcfCmBNum0AFgKutJVJFZ0sIEM2QJidQWcQWg0dn?=
 =?us-ascii?Q?VjluTUMcLKZOIme5QnwaEM+rY0ArVLtrkjXB09oWyuUmfEDY/ia4cyWW/kJr?=
 =?us-ascii?Q?y0VrhVcP1f0uJ286N7Z1PZoV1LSwzonA/pHK3QNT5ClPCZZl190on5Kwv/dv?=
 =?us-ascii?Q?0hXdl58I3RcXtSi7qFdZB6M4QeFKz4oZwCzWoxslUDTaLlMzfhBSTx9/Cqab?=
 =?us-ascii?Q?MWj1VIr2gPEYDdb+x//ijO06IOgrG8PUR8dD5xoKwX2PwwZYXvfgvzxO9aoS?=
 =?us-ascii?Q?IgDUKWJ0XlH+3Lhx+mQnYkJafOho9JnLUmBD8Z6Nq2vkATCBhQr8uC4mIxkG?=
 =?us-ascii?Q?Pvaind7hAlZG+MIIwgFn51fgSQVFk6ScOUo5hHbrA5srfAY1j4BVNk+OGe3j?=
 =?us-ascii?Q?smHivLcZ1V8o5cK3ikZq2hjxKc9upsjJnrJVgYuB8hZ4REJuvQobwrAJ/vyx?=
 =?us-ascii?Q?2GXN8N0zZpB0KcZ+s2bK+foexFiEOYbVa9TaBuoPo8sQ5BNLkKFCQB3VTZm/?=
 =?us-ascii?Q?qDY5lFsLQzUdCCjxSbK7BSoGGA6sKZVtx7rvsDgUiQZNewa65hqK/whv3phm?=
 =?us-ascii?Q?2LSyX1N/R/2LBfbaVSY+gCqkS757zywPZgJrJxObThMnfd3Gqf0owehe/u9G?=
 =?us-ascii?Q?DWUkNueVemoAvK5uJ8ofqR1P4NnT0QU=3D?=
X-Exchange-RoutingPolicyChecked: c2XvotGXWm7z2JW3ITh+OPWz6jTFieOjT/w0JBfVmCtjta67iNVz/uvFFA3Q1JMb72nc4WepLiCp8cOYVBJ8twX6pYXHUlICIvWPUiXk3fg9JXaLJn1f171yeoEB20kdki08uY7iEQE7EsJFs/UxM5zlMkcHKlDr3OTrI0lRApSltHC/Wd04Fk/jjEGKsqFsgmP0Bmrdisk8URlFTXKxf150HERLD8gB9oX0QeHUE7EwuaG47g97We9AwL7fbpzK00kGGL5W8c+3lvljM3CAXFvy4ljkEEgSGkVXS8tOI0BdE7WpTK+EDXEmlEhTLnNdROq5H2e7O8/pSqJMvynHTA==
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a782fb-e190-491a-4f65-08de9ba91fd4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 11:13:02.4747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cbl/xgPzWbsUxTQ3UD+NsIu+h/m7PFufZhAP8Tvn2hDHjK2d9E5gFrK1Gzlns0ERBbgJWNFFuyTYG4Qw2ocZj5tmWWRIjuWPHeXdQRzZ6kY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5818
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279005-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,napi_threaded.py:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: D0F3A40D3B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 02:14:05PM +0200, Maciej Fijalkowski wrote:
> For the main VSI, i40e_set_num_rings_in_vsi() always derives
> num_q_vectors from pf->num_lan_msix. At the same time, ethtool -L stores
> the user requested channel count in vsi->req_queue_pairs and the queue
> setup path uses that value for the effective number of queue pairs.
> 
> This leaves queue and vector counts out of sync after shrinking channel
> count via ethtool -L. The active queue configuration is reduced, but the
> VSI still keeps the full PF-sized q_vector topology.
> 
> That mismatch breaks reconfiguration flows which rely on vector/NAPI
> state matching the effective channel configuration. In particular,
> toggling /sys/class/net/<dev>/threaded after reducing the channel count
> can hang, and later channel-count changes can fail because VSI reinit
> does not rebuild q_vectors to match the new vector count.
> 
> Fix this by making the main VSI num_q_vectors follow the effective
> requested channel count, capped by the available MSI-X vectors. Update
> i40e_vsi_reinit_setup() to rebuild q_vectors during VSI reinit so the
> vector topology is refreshed together with the ring arrays when channel
> count changes.
> 
> Keep alloc_queue_pairs unchanged and based on pf->num_lan_qps so the VSI
> retains its full queue capacity.
> 
> Selftest napi_threaded.py was originally used when Jakub reported hang
> on /sys/class/net/<dev>/threaded toggle. In order to make it pass on
> i40e, use persistent NAPI configuration for q_vector NAPIs so NAPI
> identity and threaded settings survive q_vector reallocation across
> channel-count changes. This is achieved by using netif_napi_add_config()
> when configuring q_vectors.
> 
> $ export NETIF=ens259f1np1
> $ sudo -E env PATH="$PATH" ./tools/testing/selftests/drivers/net/napi_threaded.py
> TAP version 13
> 1..3
> ok 1 napi_threaded.napi_init
> ok 2 napi_threaded.change_num_queues
> ok 3 napi_threaded.enable_dev_threaded_disable_napi_threaded
> Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Closes: https://lore.kernel.org/intel-wired-lan/20260316133100.6054a11f@kernel.org/
> Fixes: d2a69fefd756 ("i40e: Fix changing previously set num_queue_pairs for PFs")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 34 +++++++++++++++++----
>  1 file changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 926d001b2150..5636ad71f940 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -11403,10 +11403,14 @@ static void i40e_service_timer(struct timer_list *t)
>  static int i40e_set_num_rings_in_vsi(struct i40e_vsi *vsi)
>  {
>  	struct i40e_pf *pf = vsi->back;
> +	u16 qps;
>  
>  	switch (vsi->type) {
>  	case I40E_VSI_MAIN:
>  		vsi->alloc_queue_pairs = pf->num_lan_qps;
> +		qps = vsi->req_queue_pairs ?
> +		      min_t(u16, vsi->req_queue_pairs, pf->num_lan_qps) :
> +		      pf->num_lan_qps;
>  		if (!vsi->num_tx_desc)
>  			vsi->num_tx_desc = ALIGN(I40E_DEFAULT_NUM_DESCRIPTORS,
>  						 I40E_REQ_DESCRIPTOR_MULTIPLE);
> @@ -11414,7 +11418,8 @@ static int i40e_set_num_rings_in_vsi(struct i40e_vsi *vsi)
>  			vsi->num_rx_desc = ALIGN(I40E_DEFAULT_NUM_DESCRIPTORS,
>  						 I40E_REQ_DESCRIPTOR_MULTIPLE);
>  		if (test_bit(I40E_FLAG_MSIX_ENA, pf->flags))
> -			vsi->num_q_vectors = pf->num_lan_msix;
> +			vsi->num_q_vectors = max_t(int, 1,
> +						   min_t(int, qps, pf->num_lan_msix));
>  		else
>  			vsi->num_q_vectors = 1;
>  
> @@ -12043,7 +12048,8 @@ static int i40e_vsi_alloc_q_vector(struct i40e_vsi *vsi, int v_idx)
>  	cpumask_copy(&q_vector->affinity_mask, cpu_possible_mask);
>  
>  	if (vsi->netdev)
> -		netif_napi_add(vsi->netdev, &q_vector->napi, i40e_napi_poll);
> +		netif_napi_add_config(vsi->netdev, &q_vector->napi,
> +				      i40e_napi_poll, v_idx);
>  
>  	/* tie q_vector and vsi together */
>  	vsi->q_vectors[v_idx] = q_vector;
> @@ -14265,12 +14271,27 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
>  
>  	pf = vsi->back;
>  
> +	if (test_bit(I40E_FLAG_MSIX_ENA, pf->flags)) {
> +		i40e_put_lump(pf->irq_pile, vsi->base_vector, vsi->idx);
> +		vsi->base_vector = 0;
> +	}
> +
>  	i40e_put_lump(pf->qp_pile, vsi->base_queue, vsi->idx);
>  	i40e_vsi_clear_rings(vsi);
>  
> -	i40e_vsi_free_arrays(vsi, false);
> +	i40e_vsi_free_q_vectors(vsi);
> +	i40e_vsi_free_arrays(vsi, true);
>  	i40e_set_num_rings_in_vsi(vsi);
> -	ret = i40e_vsi_alloc_arrays(vsi, false);
> +
> +	ret = i40e_vsi_alloc_arrays(vsi, true);
> +	if (ret)
> +		goto err_vsi;

Sashiko warns about potential double-free on vsi->tx_rings. I will send a
v2 where I include NULLing this ptr in i40e_vsi_alloc_arrays().

Thanks,
Maciej

> +
> +	/* Rebuild q_vectors during VSI reinit because the effective channel
> +	 * count may change num_q_vectors. Keep vector topology aligned with the
> +	 * queue configuration after ethtool's .set_channels() callback.
> +	 */
> +	ret = i40e_vsi_setup_vectors(vsi);
>  	if (ret)
>  		goto err_vsi;
>  
> @@ -14282,7 +14303,7 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
>  		dev_info(&pf->pdev->dev,
>  			 "failed to get tracking for %d queues for VSI %d err %d\n",
>  			 alloc_queue_pairs, vsi->seid, ret);
> -		goto err_vsi;
> +		goto err_lump;
>  	}
>  	vsi->base_queue = ret;
>  
> @@ -14306,7 +14327,6 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
>  	return vsi;
>  
>  err_rings:
> -	i40e_vsi_free_q_vectors(vsi);
>  	if (vsi->netdev_registered) {
>  		vsi->netdev_registered = false;
>  		unregister_netdev(vsi->netdev);
> @@ -14316,6 +14336,8 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
>  	if (vsi->type == I40E_VSI_MAIN)
>  		i40e_devlink_destroy_port(pf);
>  	i40e_aq_delete_element(&pf->hw, vsi->seid, NULL);
> +err_lump:
> +	i40e_vsi_free_q_vectors(vsi);
>  err_vsi:
>  	i40e_vsi_clear(vsi);
>  	return NULL;
> -- 
> 2.43.0
> 

