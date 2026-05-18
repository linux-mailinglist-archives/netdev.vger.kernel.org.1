Return-Path: <netdev+bounces-288882-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wM9QLgLACmq87QQAu9opvQ
	(envelope-from <netdev+bounces-288882-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 09:30:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E870567902
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 09:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A38C304E419
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 07:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5D13D2FE0;
	Mon, 18 May 2026 07:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OiCVPCzd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1123CD8A8;
	Mon, 18 May 2026 07:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779089089; cv=fail; b=sJnuFo3kJhQLbEG8scO6XGubXKVg4ze/UFv2fjAUvhF98dUE7zp587+5kJmYZdELrDb2tnIuSmrETVgcpwjr+apYAC0TEZ/6F/stxuk9vIwBju+ng7/oDYH+qpjhfLq3IxvjhFUvFPM4TmufVq3HaKZpO0WSS5ZR9wFG8RR1we8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779089089; c=relaxed/simple;
	bh=OP+M4kJQSCqdL7BWYroOd6BaktsXJuOmZiyq5HXUgzU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nxz/dRGlnkMT2D5EaGZT4uuETEQdj75/PbAnYwwNjh8AjAnKA/hfUv5PggyO1imRdKOwkfA5P7tUTGzMVKJg2phtpNHug1FWqO3mxR1lK5f+qQIqAZleQIosYDGrkD2xxDbqL1pRBvoD0PYf6eWdwQKSEtmViT9Lji8vMB91I7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OiCVPCzd; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779089086; x=1810625086;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OP+M4kJQSCqdL7BWYroOd6BaktsXJuOmZiyq5HXUgzU=;
  b=OiCVPCzdhnr8KCtWpEFtncR60/f2GyNdOOTyJpGB064qHncGZMyg4v4a
   Epo4Vo3sa5ZfTaSvufpn6Zb6B2zTRuSo62/R21HNQV+Npe5deFmRPrD47
   bv7NhfoxBUOyml8/Ei9lXTImMRXQujZ1qcw5lpbhaM3K/oBg+pnlVXmX8
   49Au91MWtOBLaRMQaaPG/Dgi7LqmU4ecMmCGDzdkwMQsXv8EeVIZExR7x
   /dkZ+d+glKQw1e7ly6UEy9IJOoyMlKVo1Y4dnlxgc9unMExrmrqV6aXOv
   kke3NLx752cc75e10wavpeTNuWjINQB7sNEkbBjjgyqJexqcmWmT27LhZ
   w==;
X-CSE-ConnectionGUID: X35ell0ZQBOnyoSvIRgqIw==
X-CSE-MsgGUID: m3YmUTUtQ2up7eKC9lKFgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="79789177"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="79789177"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 00:24:45 -0700
X-CSE-ConnectionGUID: ExuPP8zOTbGoVPiCOTp13Q==
X-CSE-MsgGUID: ea4tXIZnQ1mYHJoc7MQbfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="263125618"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 00:24:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 00:24:44 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 18 May 2026 00:24:44 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.49) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 00:24:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IudNzPCnjUS7bcTZf7jkAZSgSb14WBmjyX8VVn75eLkpt5mRr6Uis8UFVmZMDFe7KdBOyUaD82rjJpXaNNaQHwtWpt+k+z56ifDQlu9f/K1xLUe8RVEbB0iuymCEFDI3ESU1SibLYgQnKMWF9dEiHX4W6bP1wCf8imLpxX4HqQc+Aj1IQ6yOOhxfBqAjSl611x2VouqJbbe91UBgG+ZoUYHdV4BSmszgyTUeH0yNlMD2d+rwdw9hYaWwAJtduRMzIxG8owzInUNAfLIhnLJ9vNGU/S49o8MHWOXWfpssm8XLKUhMdkOlMUVdOAiEvHimkFLD5QN6CX19ZerLpuvlbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpmyGw9FlZk4FIHmfVCPoW2mNs8T4KTbA6ZsgXbtCME=;
 b=fI5aDhrBGHgf+Jxf0MHVLvL/6SAXWjrO/ZWYdQS8WLkiAye0PDacCtE/3QAsJwnqE/S5wxYhTouoyKbj0+MeEWk6F5QrTFmaV87H4i8TwKtzSaUEyhOrzest87C9o3olm/YJ7yxkShMzZOa1X2F8kL0PFx9b+iR6wG3zMRnFjKcqmI1yRLcpxwdajRLf/lrPofhbGMsYDHjyuwwVKPbILGT8rIsmH7FGLn0QOnMSVEbqzys8ZwkLL3CHZAfHsk7euZLB6BBTsFxAl1VSsY3V00SlQyz9+9Y+7r6RDwofkdrsicvcw/GRKHaTqWlkjwJpXaaTMjL85yG8BBf5RLARuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by CH3PR11MB8443.namprd11.prod.outlook.com (2603:10b6:610:1bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 07:24:39 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b%6]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 07:24:39 +0000
Date: Mon, 18 May 2026 09:24:23 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	Phani R Burra <phani.r.burra@intel.com>, <przemyslaw.kitszel@intel.com>,
	<aleksander.lobakin@intel.com>, <sridhar.samudrala@intel.com>,
	<anjali.singhai@intel.com>, <michal.swiatkowski@linux.intel.com>,
	<maciej.fijalkowski@intel.com>, <emil.s.tantilov@intel.com>,
	<madhu.chittim@intel.com>, <joshua.a.hay@intel.com>,
	<jacob.e.keller@intel.com>, <jayaprakash.shanmugam@intel.com>,
	<jiri@resnulli.us>, <horms@kernel.org>, <corbet@lwn.net>,
	<richardcochran@gmail.com>, <linux-doc@vger.kernel.org>, Bharath R
	<bharath.r@intel.com>, Samuel Salin <Samuel.salin@intel.com>, "Aleksandr
 Loktionov" <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net-next v3 05/14] libie: add bookkeeping support for
 control queue messages
Message-ID: <agq-p2zr2Xoyvd3F@soc-5CG4396X81.clients.intel.com>
References: <20260515224443.2772147-1-anthony.l.nguyen@intel.com>
 <20260515224443.2772147-6-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260515224443.2772147-6-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: VI1PR0202CA0036.eurprd02.prod.outlook.com
 (2603:10a6:803:14::49) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|CH3PR11MB8443:EE_
X-MS-Office365-Filtering-Correlation-Id: 497ada33-b627-4908-2dcb-08deb4ae858c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|376014|7416014|1800799024|4143699003|11063799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: q9HfdHwT70gpp/p9LRiRZgbTqPC62Sb8fgpBrt2E/uLK2xJ+47xc1SuOMu/7Cp7TCUvocB27F3jwFbxuhloD75sDKl+gQ5w9tpUBijZv0VpDEE61uEiaoIAQ2SlkqtNIzjYod1DytJKVBD87fNvLy57bWBZ+lhs6PQ3ZMC3/gW4GV9liL/L3SMtMX8fJNSB3FmRVuihNrnwBvxpHtaN9eJwC6nJS03mSihLCw1txpNGvNPxZowHJSgK4cWWSPopwPJxBzt5zx8npdy2HWoV4ZJKaqEaZusr88TpzABfix6lXtpHuHTaDFTgYAutG3Gv2LgHYHyFNTOtxAOlwfsn76q/iKi4HGockEtKaGb0tXyK3pEqqMnpQUEjdsqA9x9NkLL6AyoTOFN6fg3jgJDcgc4DUkMW7jJU5g4qoOoRe+MUVR0PX4hnA2HBaG7c508cGbbdNHGtDGLy4nPqzQ9geOf1J4iB8+DimfQqv27W91XlYNV1+HtrJx+sxmLmbNX9XGfSU6bRz9JXw4/tZjWrAlHUCDmBXrI4mOvZMqAamrwckL3pZju2cplcYa90QTewNWr8ULaRzhOPhPrLhAllrH89P17J/GgBZaBOgkTheY4abSBxCzKFRf1X5RGZn5Jx19VobH3LkEeCbq//p+F9ePw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(7416014)(1800799024)(4143699003)(11063799003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A0rH2NPmhrDPO0ov04zxtZC31ka+b8+Yi1h5QScNQJ3qYFVaeK1Po0y/H0AM?=
 =?us-ascii?Q?zyxo+0ByPCXU+THssWBAgSplct4ddoJYtdljSS6ySdM0WgyaTV47SkrWAW08?=
 =?us-ascii?Q?mLU8e4pTkOyv7e9SJMzc1WvgDaZX6BfIWRWE9Uf2twVC157gEFKHSt6z28sJ?=
 =?us-ascii?Q?rEcC+NxixeGRSBfnpay1ej2eIWqRy2Lzu7Y6KSJDQ1nrhQA6Yi8kQ6+04cG0?=
 =?us-ascii?Q?H75KzY7e1icc+xd5LsIhM/8aEmIfdWQ76RvgIy9OfR3jGj0vj2GoLsUBnW5K?=
 =?us-ascii?Q?6Tgagbd4Gorq5UV+a1/5r2f0sptp0Q0Tz63PAbeMgadIMB/ynjrXZkE+zUH1?=
 =?us-ascii?Q?psKpPgBfpCjLOr3bsR22T3tWh+yDP+dtY9+ztocCYhBu9U5+os/GPg3G6bK9?=
 =?us-ascii?Q?2wmd+yzQbIJlCw9uM67ikdFueMVkypevh95FwtcJBCGFzZnmDMh+XpJNp92G?=
 =?us-ascii?Q?3ZjBIhKca13jARFxaoxviVfpq+hOePz1YsTrecmTsmWMsOuzVd/RYALoLuOT?=
 =?us-ascii?Q?6knMFnFFSUg35YVgWYQ71qdvCa+h7dgl4SrHof1nfHgMC4TNx2BbUs06NhTS?=
 =?us-ascii?Q?FYJ98XSmJxbkoCo5MtMnzz7ckfYa2xIeKgr3SMtGx3Gd9Yb4vnGhQhKZ0auo?=
 =?us-ascii?Q?gQOqbk0lUXQH3PIW8rPocnhDfAmxl2F9zlPT54BxjGx5rnw0JlyA4raGFVRh?=
 =?us-ascii?Q?SosLk5/psMqWh6x5OBd7ffiwvU8LjUMgluTafodYVr8rFHbR+iYHf/Rgdl/j?=
 =?us-ascii?Q?5kNEeBMTpLKFZv0mXgceLIVNzC6mwim4sNwy1X52hF5QgIES+K0ghSSL1jbM?=
 =?us-ascii?Q?Y1n9wNQXxfkTCcAbKyYuVUEj2CIzjNADXHVfUc+6zheGBzNxxPyJOAIwIud9?=
 =?us-ascii?Q?NNOjKCOFR8ozyD3c8ywfaSWWIiuL9DQVhQKgdWxTDYYUg9Ggze0/uFer5dJx?=
 =?us-ascii?Q?HzsS+EvgG54bByLrmX7X3dsg1khbMv7i9EGgFPPOFcylPlo3B69VR8i365Gq?=
 =?us-ascii?Q?vtyeUT1xR+vq4yiqSIL4w6Qh9hKKOg5YBzedhVTt1bRyVk+wtm6EXbSj0VNM?=
 =?us-ascii?Q?llCnu+x/zMqvlKhyCPvw77rbjlO9qHfyMmJNQ9Th4AfCcSiOA2mrdS7Unqp5?=
 =?us-ascii?Q?qXBhwp+knU2kAlZM6QzPOiFYOsgIAd7BP4hR5lCtfW71+vLOVuAYjnbtp+FS?=
 =?us-ascii?Q?bi6qtoeo+qRRGY0Qx/AxSns7tUTeEghLy4sMAH9tc2qA81pVPz3d8P5k9LBV?=
 =?us-ascii?Q?lDe7iuO/QAxqOJt723AQpo7WgXwQYcNQUhcIgLgOYgtKP1B/P/5FRBMJ21yY?=
 =?us-ascii?Q?2dh2rtfYcJNMsWFRpCQnvwwQhDwMZ9P5uvUEBzR33NGVL75pg+TCQL4V6cCo?=
 =?us-ascii?Q?QmXltHg0xmTMzUMrYr8EEPPpKimNv7ryY5YB5FdBeujwtgz2+zMNnLVt00sB?=
 =?us-ascii?Q?BsPFivJUqWHf6bkm9hF7V7pBM2hmRqlCGB0PgXe0Pl8SaKsVWejp//zJU+Nc?=
 =?us-ascii?Q?durF5bff0rHXxrsRa3/JqTG1bH1lTkqHTq9o/LRA4myKpHZVqiP/g5MN4vFb?=
 =?us-ascii?Q?g9USyRGetLBp9dKpuADqi9FU45ml0Qa4/E73DZjRq89MdGe7AZ1PQV/LEurb?=
 =?us-ascii?Q?5DzFERvZYxbvAP9TGNfxJIT+iLxHz446FGeW0S+Ytfc+NSspkEw2CHea7Gtn?=
 =?us-ascii?Q?hLM1W+fYe2zr8fC8QU8UDOVLr/m00kpGu13LITfTCe3scT/aeQg6jJzuskGX?=
 =?us-ascii?Q?ugZwUrIol3xE/wIp5YH0RVN1WpruGPC4VGkgxxHnWkLVbkC1QtF55wjgfTae?=
X-MS-Exchange-AntiSpam-MessageData-1: uiCZnheeqjLZOTEt6a4iPK9LZycDqH8b7XE=
X-Exchange-RoutingPolicyChecked: aEMmq3owURRuTkUJs4kUgibrNYXJP57g+a6XU8GHYQXfBdPEut29S3yIzQMlATeYSBaL9ychgPhPCh4PIst59IKK9/Od1oiJJ5NMmUQwkvZ+7OGBTgE5WbZn+7T1JYMFeDndByn/Jcq/jxBnnjTDLmdI3t7j8rYlIcGD3sX3KsmIW48LM4eGTgqKOxLTv2f/qtXSdhUGwVqE/frCIJXtrW3VcxIWzWS34PuP4tvtDB+um+2br81kJRqdJhM3J69hZJ5LD+rIKL5SO4IznXiGoiCiMnSJHxrdeJqNjyO/79EPAEYL7nIuh1JqrnnJTwm1nYucXBa34AjHwM/Nk+wHjw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 497ada33-b627-4908-2dcb-08deb4ae858c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 07:24:39.3634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LnZicMHCFfQB3QOWJnCD1fb1l/a/KSG6onFGQnE5p6rw+oH6H/zcIRhUOCWrf21ywfsdm1nqD6bcmWeBITOWCHNu2mNwdFelmeLMGqOXm8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8443
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 1E870567902
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[33];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288882-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,lunn.ch,vger.kernel.org,intel.com,linux.intel.com,resnulli.us,lwn.net,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[soc-5CG4396X81.clients.intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,sashiko.dev:url];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 03:44:29PM -0700, Tony Nguyen wrote:
> From: Phani R Burra <phani.r.burra@intel.com>
> 
> All send control queue messages are allocated/freed in libie itself and
> tracked with the unique transaction (Xn) ids until they receive response or
> time out. Responses can be received out of order, therefore transactions
> are stored in an array and tracked though a bitmap.
> 
> Pre-allocated DMA memory is used where possible. It reduces the driver
> overhead in handling memory allocation/free and message timeouts.

I had reviewed the Sashiko feedback [0]. Here is why I not find the feedback 
very helpful for this particular patch:

1. "Should the cookie be tracked per-slot instead?" - it is, the xn cookie is a 
   combination of xn manager cookie + xn index.
2. "If the callback attempts to send a follow-up message" - not intended.
3. "[if] the driver only expects matched responses (providing no default 
    handler), will this dereference a NULL pointer" - no, we can expect members 
    params to be initialized properly.
4. This code is not intended to run in NAPI.
5. "could the hardware eventually read the new payload but process it using the 
    old descriptor's opcode, causing control plane data corruption?" - it is 
    highly unlikely, timeout time is very long, if HW queue stalls for that 
    long, data corruption is the least of our concerns.
6. "recv_mem still contains the pointer from a previous successful transaction 
    (which was already passed to the caller and freed/consumed), will
    this cause a double free of the page pool receive buffer?" - no, such 
    transaction is treated as a timed-out, and hence not containing a valid 
    recv_mem.
7. "Active transactions in the LIBIE_CTLQ_XN_ASYNC state are unconditionally
    pushed back to the free list, skipping the invocation of xn->resp_cb()."
   intended, resp_cb() is not supposed to be used for cleanup.

[0] https://sashiko.dev/#/patchset/20260515224443.2772147-1-anthony.l.nguyen%40intel.com


> 
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Phani R Burra <phani.r.burra@intel.com>
> Co-developed-by: Victor Raj <victor.raj@intel.com>
> Signed-off-by: Victor Raj <victor.raj@intel.com>
> Co-developed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Co-developed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Tested-by: Bharath R <bharath.r@intel.com>
> Tested-by: Samuel Salin <Samuel.salin@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/libie/controlq.c | 599 ++++++++++++++++++++
>  include/linux/intel/libie/controlq.h        | 177 ++++++
>  2 files changed, 776 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/libie/controlq.c b/drivers/net/ethernet/intel/libie/controlq.c
> index 934721c98f34..5b06d797facf 100644
> --- a/drivers/net/ethernet/intel/libie/controlq.c
> +++ b/drivers/net/ethernet/intel/libie/controlq.c
> @@ -609,6 +609,605 @@ u32 libie_ctlq_recv(struct libie_ctlq_info *ctlq, struct libie_ctlq_msg *msg,
>  }
>  EXPORT_SYMBOL_NS_GPL(libie_ctlq_recv, "LIBIE_CP");
>  
> +/**
> + * libie_ctlq_xn_pop_free - get a free Xn entry from the free list
> + * @xnm: Xn transaction manager
> + *
> + * Retrieve a free Xn entry from the free list.
> + *
> + * Return: valid Xn entry pointer or NULL if there are no free Xn entries.
> + */
> +static struct libie_ctlq_xn *
> +libie_ctlq_xn_pop_free(struct libie_ctlq_xn_manager *xnm)
> +{
> +	struct libie_ctlq_xn *xn;
> +	u32 free_idx;
> +
> +	guard(spinlock)(&xnm->free_xns_bm_lock);
> +
> +	if (unlikely(xnm->shutdown))
> +		return NULL;
> +
> +	free_idx = find_next_bit(xnm->free_xns_bm, LIBIE_CTLQ_MAX_XN_ENTRIES,
> +				 0);
> +	if (free_idx == LIBIE_CTLQ_MAX_XN_ENTRIES)
> +		return NULL;
> +
> +	__clear_bit(free_idx, xnm->free_xns_bm);
> +	xn = &xnm->ring[free_idx];
> +	xn->cookie = xnm->cookie++;
> +
> +	return xn;
> +}
> +
> +/**
> + * __libie_ctlq_xn_push_free - unsafely push a Xn entry into the free list
> + * @xnm: Xn transaction manager
> + * @xn: xn entry to be added into the free list
> + */
> +static void __libie_ctlq_xn_push_free(struct libie_ctlq_xn_manager *xnm,
> +				      struct libie_ctlq_xn *xn)
> +{
> +	__set_bit(xn->index, xnm->free_xns_bm);
> +
> +	if (likely(!xnm->shutdown))
> +		return;
> +
> +	if (bitmap_full(xnm->free_xns_bm, LIBIE_CTLQ_MAX_XN_ENTRIES))
> +		complete(&xnm->can_destroy);
> +}
> +
> +/**
> + * libie_ctlq_xn_push_free - push a Xn entry into the free list
> + * @xnm: Xn transaction manager
> + * @xn: xn entry to be added into the free list, not locked
> + *
> + * Safely add a used Xn entry back to the free list.
> + */
> +static void libie_ctlq_xn_push_free(struct libie_ctlq_xn_manager *xnm,
> +				    struct libie_ctlq_xn *xn)
> +{
> +	guard(spinlock)(&xnm->free_xns_bm_lock);
> +
> +	__libie_ctlq_xn_push_free(xnm, xn);
> +}
> +
> +/**
> + * libie_ctlq_xn_deinit_dma - free the DMA memory allocated for send messages
> + * @dev: device pointer
> + * @xnm: pointer to the transaction manager
> + * @num_entries: number of Xn entries to free the DMA for
> + */
> +static void libie_ctlq_xn_deinit_dma(struct device *dev,
> +				     struct libie_ctlq_xn_manager *xnm,
> +				     u32 num_entries)
> +{
> +	for (u32 i = 0; i < num_entries; i++) {
> +		struct libie_ctlq_xn *xn = &xnm->ring[i];
> +
> +		libie_cp_free_dma_mem(dev, xn->dma_mem);
> +		kfree(xn->dma_mem);
> +	}
> +}
> +
> +/**
> + * libie_ctlq_xn_init_dma - pre-allocate DMA memory for send messages that use
> + * stack variables
> + * @dev: device pointer
> + * @xnm: pointer to transaction manager
> + *
> + * Return: %0 on success or error if memory allocation fails
> + */
> +static int libie_ctlq_xn_init_dma(struct device *dev,
> +				  struct libie_ctlq_xn_manager *xnm)
> +{
> +	u32 i;
> +
> +	for (i = 0; i < LIBIE_CTLQ_MAX_XN_ENTRIES; i++) {
> +		struct libie_ctlq_xn *xn = &xnm->ring[i];
> +		struct libie_cp_dma_mem *dma_mem;
> +
> +		dma_mem = kzalloc_obj(*dma_mem);
> +		if (!dma_mem)
> +			goto dealloc_dma;
> +
> +		dma_mem->va = libie_cp_alloc_dma_mem(dev, dma_mem,
> +						     LIBIE_CTLQ_MAX_BUF_LEN);
> +		if (!dma_mem->va) {
> +			kfree(dma_mem);
> +			goto dealloc_dma;
> +		}
> +
> +		xn->dma_mem = dma_mem;
> +	}
> +
> +	return 0;
> +
> +dealloc_dma:
> +	libie_ctlq_xn_deinit_dma(dev, xnm, i);
> +
> +	return -ENOMEM;
> +}
> +
> +/**
> + * libie_ctlq_xn_process_recv - process Xn data in receive message
> + * @params: Xn receive param information to handle a receive message
> + * @ctlq_msg: received control queue message
> + *
> + * Process a control queue receive message and send a complete event
> + * notification.
> + *
> + * Return: true if a message has been processed, false otherwise.
> + */
> +static bool
> +libie_ctlq_xn_process_recv(struct libie_ctlq_xn_recv_params *params,
> +			   struct libie_ctlq_msg *ctlq_msg)
> +{
> +	struct libie_ctlq_xn_manager *xnm = params->xnm;
> +	struct libie_ctlq_xn *xn;
> +	u16 msg_cookie, xn_index;
> +	struct kvec *response;
> +	int status;
> +	u16 data;
> +
> +	data = ctlq_msg->sw_cookie;
> +	xn_index = FIELD_GET(LIBIE_CTLQ_XN_INDEX_M, data);
> +	msg_cookie = FIELD_GET(LIBIE_CTLQ_XN_COOKIE_M, data);
> +	status = ctlq_msg->chnl_retval ? -EFAULT : 0;
> +
> +	xn = &xnm->ring[xn_index];
> +	spin_lock(&xn->xn_lock);
> +	if (ctlq_msg->chnl_opcode != xn->virtchnl_opcode ||
> +	    msg_cookie != xn->cookie) {
> +		spin_unlock(&xn->xn_lock);
> +		return false;
> +	}
> +
> +	if (xn->state != LIBIE_CTLQ_XN_ASYNC &&
> +	    xn->state != LIBIE_CTLQ_XN_WAITING) {
> +		spin_unlock(&xn->xn_lock);
> +		return false;
> +	}
> +
> +	response = &ctlq_msg->recv_mem;
> +	if (xn->state == LIBIE_CTLQ_XN_ASYNC) {
> +		xn->resp_cb(xn->send_ctx, response, status);
> +		libie_ctlq_release_rx_buf(response);
> +		xn->state = LIBIE_CTLQ_XN_IDLE;
> +		spin_unlock(&xn->xn_lock);
> +		libie_ctlq_xn_push_free(xnm, xn);
> +
> +		return true;
> +	}
> +
> +	xn->recv_mem = *response;
> +	xn->state = status ? LIBIE_CTLQ_XN_COMPLETED_FAILED :
> +			     LIBIE_CTLQ_XN_COMPLETED_SUCCESS;
> +
> +	complete(&xn->cmd_completion_event);
> +	spin_unlock(&xn->xn_lock);
> +
> +	return true;
> +}
> +
> +/**
> + * libie_xn_check_async_timeout - Check for asynchronous message timeouts
> + * @xnm: Xn transaction manager
> + *
> + * Call the corresponding callback to notify the caller about the timeout.
> + */
> +static void libie_xn_check_async_timeout(struct libie_ctlq_xn_manager *xnm)
> +{
> +	u32 idx;
> +
> +	for_each_clear_bit(idx, xnm->free_xns_bm, LIBIE_CTLQ_MAX_XN_ENTRIES) {
> +		struct libie_ctlq_xn *xn = &xnm->ring[idx];
> +		u64 timeout_ms;
> +
> +		spin_lock(&xn->xn_lock);
> +
> +		timeout_ms = ktime_ms_delta(ktime_get(), xn->timestamp);
> +		if (xn->state != LIBIE_CTLQ_XN_ASYNC ||
> +		    timeout_ms < xn->timeout_ms) {
> +			spin_unlock(&xn->xn_lock);
> +			continue;
> +		}
> +
> +		xn->resp_cb(xn->send_ctx, NULL, -ETIMEDOUT);
> +		xn->state = LIBIE_CTLQ_XN_IDLE;
> +		spin_unlock(&xn->xn_lock);
> +		libie_ctlq_xn_push_free(xnm, xn);
> +	}
> +}
> +
> +/**
> + * libie_ctlq_xn_recv - process control queue receive message
> + * @params: Xn receive param information to handle a receive message
> + *
> + * Process a receive message and update the receive queue buffer.
> + *
> + * Return: remaining budget.
> + */
> +u32 libie_ctlq_xn_recv(struct libie_ctlq_xn_recv_params *params)
> +{
> +	struct libie_ctlq_msg ctlq_msg;
> +	u32 budget = params->budget;
> +
> +	while (budget && libie_ctlq_recv(params->ctlq, &ctlq_msg, 1)) {
> +		budget--;
> +		if (!libie_ctlq_xn_process_recv(params, &ctlq_msg))
> +			params->ctlq_msg_handler(params->xnm->ctx, &ctlq_msg);
> +	}
> +
> +	libie_ctlq_post_rx_buffs(params->ctlq);
> +	libie_xn_check_async_timeout(params->xnm);
> +
> +	return budget;
> +}
> +EXPORT_SYMBOL_NS_GPL(libie_ctlq_xn_recv, "LIBIE_CP");
> +
> +/**
> + * libie_cp_map_dma_mem - map a given virtual address for DMA
> + * @dev: device information
> + * @va: virtual address to be mapped
> + * @size: size of the memory
> + * @direction: DMA direction either from/to device
> + * @dma_mem: memory for DMA information to be stored
> + *
> + * Return: true on success, false on DMA map failure.
> + */
> +static bool libie_cp_map_dma_mem(struct device *dev, void *va, size_t size,
> +				 int direction,
> +				  struct libie_cp_dma_mem *dma_mem)
> +{
> +	dma_mem->pa = dma_map_single(dev, va, size, direction);
> +
> +	return dma_mapping_error(dev, dma_mem->pa) ? false : true;
> +}
> +
> +/**
> + * libie_cp_unmap_dma_mem - unmap previously mapped DMA address
> + * @dev: device information
> + * @dma_mem: DMA memory information
> + */
> +static void libie_cp_unmap_dma_mem(struct device *dev,
> +				   const struct libie_cp_dma_mem *dma_mem)
> +{
> +	dma_unmap_single(dev, dma_mem->pa, dma_mem->size,
> +			 dma_mem->direction);
> +}
> +
> +/**
> + * libie_ctlq_xn_process_send - process and send a control queue message
> + * @params: Xn send param information for sending a control queue message
> + * @xn: Assigned Xn entry for tracking the control queue message
> + *
> + * Return: %0 on success, -%errno on failure.
> + */
> +static
> +int libie_ctlq_xn_process_send(struct libie_ctlq_xn_send_params *params,
> +			       struct libie_ctlq_xn *xn)
> +{
> +	size_t buf_len = params->send_buf.iov_len;
> +	struct device *dev = params->ctlq->dev;
> +	void *buf = params->send_buf.iov_base;
> +	struct libie_cp_dma_mem *dma_mem;
> +	u16 cookie;
> +
> +	if (!buf || !buf_len)
> +		return -EOPNOTSUPP;
> +
> +	if (libie_cp_can_send_onstack(buf_len)) {
> +		dma_mem = xn->dma_mem;
> +		memcpy(dma_mem->va, buf, buf_len);
> +	} else {
> +		dma_mem = &xn->send_dma_mem;
> +		dma_mem->va = buf;
> +		dma_mem->size = buf_len;
> +		dma_mem->direction = DMA_TO_DEVICE;
> +
> +		if (!libie_cp_map_dma_mem(dev, buf, buf_len, DMA_TO_DEVICE,
> +					  dma_mem))
> +			return -ENOMEM;
> +	}
> +
> +	cookie = FIELD_PREP(LIBIE_CTLQ_XN_COOKIE_M, xn->cookie) |
> +		 FIELD_PREP(LIBIE_CTLQ_XN_INDEX_M, xn->index);
> +
> +	scoped_guard(spinlock, &params->ctlq->lock) {
> +		struct libie_ctlq_info *ctlq = params->ctlq;
> +		struct libie_ctlq_msg *ctlq_msg;
> +
> +		if (!libie_ctlq_send_desc_avail(ctlq)) {
> +			if (!libie_cp_can_send_onstack(buf_len))
> +				libie_cp_unmap_dma_mem(dev, dma_mem);
> +
> +			return -EBUSY;
> +		}
> +
> +		ctlq_msg = ctlq->tx_msg[ctlq->next_to_use];
> +		if (params->ctlq_msg)
> +			*ctlq_msg = *params->ctlq_msg;
> +		else
> +			/* Unused ctlq messages are already zeroed */
> +			ctlq_msg->opcode = LIBIE_CTLQ_SEND_MSG_TO_CP;
> +
> +		ctlq_msg->sw_cookie = cookie;
> +		ctlq_msg->send_mem = *dma_mem;
> +		ctlq_msg->data_len = buf_len;
> +		ctlq_msg->chnl_opcode = params->chnl_opcode;
> +		libie_ctlq_send(params->ctlq, 1);
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * libie_ctlq_xn_send - Function to send a control queue message
> + * @params: Xn send param information for sending a control queue message
> + *
> + * Send a control queue (mailbox or config) message.
> + * Based on the params value, the call can be completed synchronously or
> + * asynchronously.
> + *
> + * Return: %0 on success, -%errno on failure.
> + */
> +int libie_ctlq_xn_send(struct libie_ctlq_xn_send_params *params)
> +{
> +	bool free_send = !libie_cp_can_send_onstack(params->send_buf.iov_len);
> +	struct libie_ctlq_xn *xn;
> +	int ret;
> +
> +	if (params->send_buf.iov_len > LIBIE_CTLQ_MAX_BUF_LEN) {
> +		ret = -EINVAL;
> +		goto free_buf;
> +	}
> +
> +	xn = libie_ctlq_xn_pop_free(params->xnm);
> +	/* no free transactions available */
> +	if (unlikely(!xn)) {
> +		ret = -EAGAIN;
> +		goto free_buf;
> +	}
> +
> +	spin_lock(&xn->xn_lock);
> +	if (xn->state == LIBIE_CTLQ_XN_SHUTDOWN) {
> +		ret = -ENXIO;
> +		goto unlock_xn;
> +	}
> +
> +	xn->state = params->resp_cb ? LIBIE_CTLQ_XN_ASYNC :
> +				      LIBIE_CTLQ_XN_WAITING;
> +	xn->ctlq = params->ctlq;
> +	xn->virtchnl_opcode = params->chnl_opcode;
> +
> +	if (params->resp_cb) {
> +		xn->send_ctx = params->send_ctx;
> +		xn->resp_cb = params->resp_cb;
> +		xn->timeout_ms = params->timeout_ms;
> +		xn->timestamp = ktime_get();
> +	}
> +
> +	ret = libie_ctlq_xn_process_send(params, xn);
> +	if (ret)
> +		goto release_xn;
> +	else
> +		free_send = false;
> +
> +	spin_unlock(&xn->xn_lock);
> +
> +	if (params->resp_cb)
> +		return 0;
> +
> +	wait_for_completion_timeout(&xn->cmd_completion_event,
> +				    msecs_to_jiffies(params->timeout_ms));
> +
> +	spin_lock(&xn->xn_lock);
> +	switch (xn->state) {
> +	case LIBIE_CTLQ_XN_WAITING:
> +		ret = -ETIMEDOUT;
> +		break;
> +	case LIBIE_CTLQ_XN_COMPLETED_SUCCESS:
> +		params->recv_mem = xn->recv_mem;
> +		break;
> +	default:
> +		ret = -EBADMSG;
> +		break;
> +	}
> +
> +	/* Free the receive buffer in case of failure. On timeout, receive
> +	 * buffer is not allocated.
> +	 */
> +	if (ret && ret != -ETIMEDOUT)
> +		libie_ctlq_release_rx_buf(&xn->recv_mem);
> +
> +release_xn:
> +	xn->state = LIBIE_CTLQ_XN_IDLE;
> +	reinit_completion(&xn->cmd_completion_event);
> +unlock_xn:
> +	spin_unlock(&xn->xn_lock);
> +	libie_ctlq_xn_push_free(params->xnm, xn);
> +free_buf:
> +	if (free_send)
> +		params->rel_tx_buf(params->send_buf.iov_base);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_NS_GPL(libie_ctlq_xn_send, "LIBIE_CP");
> +
> +/**
> + * libie_ctlq_xn_send_clean - cleanup the send control queue message buffers
> + * @params: Xn clean param information for send complete handling
> + *
> + * Cleanup the send buffers for the given control queue, if force is set, then
> + * clear all the outstanding send messages irrespective their send status.
> + * Force should be used during deinit or reset.
> + *
> + * Return: number of send buffers cleaned.
> + */
> +u32 libie_ctlq_xn_send_clean(const struct libie_ctlq_xn_clean_params *params)
> +{
> +	struct libie_ctlq_info *ctlq = params->ctlq;
> +	struct device *dev = ctlq->dev;
> +	u32 ntc, i;
> +
> +	spin_lock(&ctlq->lock);
> +	ntc = ctlq->next_to_clean;
> +
> +	for (i = 0; i < params->num_msgs; i++) {
> +		struct libie_ctlq_msg *msg = ctlq->tx_msg[ntc];
> +		struct libie_ctlq_desc *desc;
> +		u64 qword;
> +
> +		desc = &ctlq->descs[ntc];
> +		qword = le64_to_cpu(desc->qword0);
> +
> +		if (!FIELD_GET(LIBIE_CTLQ_DESC_FLAG_DD, qword) &&
> +		    !(unlikely(params->force) && msg->data_len))
> +			break;
> +
> +		dma_rmb();
> +
> +		if (!libie_cp_can_send_onstack(msg->data_len)) {
> +			libie_cp_unmap_dma_mem(dev, &msg->send_mem);
> +			params->rel_tx_buf(msg->send_mem.va);
> +		}
> +
> +		memset(msg, 0, sizeof(*msg));
> +		desc->qword0 = 0;
> +
> +		if (unlikely(++ntc == ctlq->ring_len))
> +			ntc = 0;
> +	}
> +
> +	ctlq->next_to_clean = ntc;
> +	spin_unlock(&ctlq->lock);
> +
> +	return i;
> +}
> +EXPORT_SYMBOL_NS_GPL(libie_ctlq_xn_send_clean, "LIBIE_CP");
> +
> +/**
> + * libie_ctlq_xn_shutdown - terminate control queue transactions
> + * @xnm: pointer to the transaction manager
> + *
> + * Synchronously terminate existing transactions and stop accepting new ones.
> + */
> +void libie_ctlq_xn_shutdown(struct libie_ctlq_xn_manager *xnm)
> +{
> +	bool must_wait = false;
> +	u32 i;
> +
> +	/* Should be no new clear bits after this */
> +	spin_lock(&xnm->free_xns_bm_lock);
> +	xnm->shutdown = true;
> +
> +	for_each_clear_bit(i, xnm->free_xns_bm, LIBIE_CTLQ_MAX_XN_ENTRIES) {
> +		struct libie_ctlq_xn *xn = &xnm->ring[i];
> +
> +		spin_lock(&xn->xn_lock);
> +
> +		switch (xn->state) {
> +		/* if an idle xn is not free, it is about to be either
> +		 * freed or initialized, prevent the latter and wait
> +		 */
> +		case LIBIE_CTLQ_XN_IDLE:
> +			xn->state = LIBIE_CTLQ_XN_SHUTDOWN;
> +			fallthrough;
> +		/* waiting thread possibly needs a push to return the xn,
> +		 * transaction will be reported as timed out
> +		 */
> +		case LIBIE_CTLQ_XN_WAITING:
> +			complete(&xn->cmd_completion_event);
> +			fallthrough;
> +		/* these states will return the xn soon */
> +		case LIBIE_CTLQ_XN_COMPLETED_SUCCESS:
> +		case LIBIE_CTLQ_XN_COMPLETED_FAILED:
> +		case LIBIE_CTLQ_XN_SHUTDOWN:
> +			must_wait = true;
> +			break;
> +		/* no thread should reference async xns at this point */
> +		case LIBIE_CTLQ_XN_ASYNC:
> +			__libie_ctlq_xn_push_free(xnm, xn);
> +			break;
> +		}
> +
> +		spin_unlock(&xn->xn_lock);
> +	}
> +
> +	spin_unlock(&xnm->free_xns_bm_lock);
> +
> +	if (must_wait)
> +		wait_for_completion(&xnm->can_destroy);
> +}
> +EXPORT_SYMBOL_NS_GPL(libie_ctlq_xn_shutdown, "LIBIE_CP");
> +
> +/**
> + * libie_ctlq_xn_deinit - deallocate and free the transaction manager resources
> + * @xnm: pointer to the transaction manager
> + * @ctx: controlq context structure
> + *
> + * All Rx processing must be stopped beforehand.
> + */
> +void libie_ctlq_xn_deinit(struct libie_ctlq_xn_manager *xnm,
> +			  struct libie_ctlq_ctx *ctx)
> +{
> +	libie_ctlq_xn_shutdown(xnm);
> +	libie_ctlq_xn_deinit_dma(&ctx->mmio_info.pdev->dev, xnm,
> +				 LIBIE_CTLQ_MAX_XN_ENTRIES);
> +	kfree(xnm);
> +	libie_ctlq_deinit(ctx);
> +}
> +EXPORT_SYMBOL_NS_GPL(libie_ctlq_xn_deinit, "LIBIE_CP");
> +
> +/**
> + * libie_ctlq_xn_init - initialize the Xn transaction manager
> + * @params: Xn init param information for allocating Xn manager resources
> + *
> + * Return: %0 on success, -%errno on failure.
> + */
> +int libie_ctlq_xn_init(struct libie_ctlq_xn_init_params *params)
> +{
> +	struct libie_ctlq_xn_manager *xnm;
> +	int ret;
> +
> +	ret = libie_ctlq_init(params->ctx, params->cctlq_info, params->num_qs);
> +	if (ret)
> +		return ret;
> +
> +	xnm = kzalloc_obj(*xnm);
> +	if (!xnm)
> +		goto ctlq_deinit;
> +
> +	ret = libie_ctlq_xn_init_dma(&params->ctx->mmio_info.pdev->dev, xnm);
> +	if (ret)
> +		goto free_xnm;
> +
> +	spin_lock_init(&xnm->free_xns_bm_lock);
> +	init_completion(&xnm->can_destroy);
> +	bitmap_fill(xnm->free_xns_bm, LIBIE_CTLQ_MAX_XN_ENTRIES);
> +
> +	for (u32 i = 0; i < LIBIE_CTLQ_MAX_XN_ENTRIES; i++) {
> +		struct libie_ctlq_xn *xn = &xnm->ring[i];
> +
> +		xn->index = i;
> +		init_completion(&xn->cmd_completion_event);
> +		spin_lock_init(&xn->xn_lock);
> +	}
> +	xnm->ctx = params->ctx;
> +	params->xnm = xnm;
> +
> +	return 0;
> +
> +free_xnm:
> +	kfree(xnm);
> +ctlq_deinit:
> +	libie_ctlq_deinit(params->ctx);
> +
> +	return -ENOMEM;
> +}
> +EXPORT_SYMBOL_NS_GPL(libie_ctlq_xn_init, "LIBIE_CP");
> +
>  MODULE_DESCRIPTION("Control Plane communication API");
>  MODULE_IMPORT_NS("LIBETH");
>  MODULE_LICENSE("GPL");
> diff --git a/include/linux/intel/libie/controlq.h b/include/linux/intel/libie/controlq.h
> index a6ed4fa159b1..e355d161ca5e 100644
> --- a/include/linux/intel/libie/controlq.h
> +++ b/include/linux/intel/libie/controlq.h
> @@ -20,6 +20,8 @@
>  #define LIBIE_CTLQ_SEND_MSG_TO_CP		0x801
>  #define LIBIE_CTLQ_SEND_MSG_TO_PEER		0x804
>  
> +#define LIBIE_CP_TX_COPYBREAK		128
> +
>  /**
>   * struct libie_ctlq_ctx - contains controlq info and MMIO region info
>   * @mmio_info: MMIO region info structure
> @@ -60,11 +62,13 @@ struct libie_ctlq_reg {
>   * @va: virtual address
>   * @pa: physical address
>   * @size: memory size
> + * @direction: memory to device or device to memory
>   */
>  struct libie_cp_dma_mem {
>  	void		*va;
>  	dma_addr_t	pa;
>  	size_t		size;
> +	int		direction;
>  };
>  
>  /**
> @@ -246,4 +250,177 @@ u32 libie_ctlq_recv(struct libie_ctlq_info *ctlq, struct libie_ctlq_msg *msg,
>  
>  int libie_ctlq_post_rx_buffs(struct libie_ctlq_info *ctlq);
>  
> +/* Only 8 bits are available in descriptor for Xn index */
> +#define LIBIE_CTLQ_MAX_XN_ENTRIES		256
> +#define LIBIE_CTLQ_XN_COOKIE_M			GENMASK(15, 8)
> +#define LIBIE_CTLQ_XN_INDEX_M			GENMASK(7, 0)
> +
> +/**
> + * enum libie_ctlq_xn_state - Transaction state of a virtchnl message
> + * @LIBIE_CTLQ_XN_IDLE: transaction is available to use
> + * @LIBIE_CTLQ_XN_WAITING: waiting for transaction to complete
> + * @LIBIE_CTLQ_XN_COMPLETED_SUCCESS: transaction completed with success
> + * @LIBIE_CTLQ_XN_COMPLETED_FAILED: transaction completed with failure
> + * @LIBIE_CTLQ_XN_ASYNC: asynchronous virtchnl message transaction type
> + * @LIBIE_CTLQ_XN_SHUTDOWN: transaction cannot be used anymore
> + */
> +enum libie_ctlq_xn_state {
> +	LIBIE_CTLQ_XN_IDLE = 0,
> +	LIBIE_CTLQ_XN_WAITING,
> +	LIBIE_CTLQ_XN_COMPLETED_SUCCESS,
> +	LIBIE_CTLQ_XN_COMPLETED_FAILED,
> +	LIBIE_CTLQ_XN_ASYNC,
> +	LIBIE_CTLQ_XN_SHUTDOWN,
> +};
> +
> +/**
> + * struct libie_ctlq_xn - structure representing a virtchnl transaction entry
> + * @resp_cb: callback to handle the response of an asynchronous virtchnl message
> + * @xn_lock: lock to protect the transaction entry state
> + * @ctlq: send control queue information
> + * @cmd_completion_event: signal when a reply is available
> + * @dma_mem: DMA memory of send buffer that use stack variable
> + * @send_dma_mem: DMA memory of send buffer
> + * @recv_mem: receive buffer
> + * @send_ctx: context for callback function
> + * @timeout_ms: Xn transaction timeout in msecs
> + * @timestamp: timestamp to record the Xn send
> + * @virtchnl_opcode: virtchnl command opcode used for Xn transaction
> + * @state: transaction state of a virtchnl message
> + * @cookie: unique message identifier
> + * @index: index of the transaction entry
> + */
> +struct libie_ctlq_xn {
> +	void (*resp_cb)(void *ctx, struct kvec *mem, int status);
> +	spinlock_t			xn_lock;	/* protects state */
> +	struct libie_ctlq_info		*ctlq;
> +	struct completion		cmd_completion_event;
> +	struct libie_cp_dma_mem	*dma_mem;
> +	struct libie_cp_dma_mem	send_dma_mem;
> +	struct kvec			recv_mem;
> +	void				*send_ctx;
> +	u64				timeout_ms;
> +	ktime_t				timestamp;
> +	u32				virtchnl_opcode;
> +	enum libie_ctlq_xn_state	state;
> +	u8				cookie;
> +	u8				index;
> +};
> +
> +/**
> + * struct libie_ctlq_xn_manager - structure representing the array of virtchnl
> + *				   transaction entries
> + * @ctx: pointer to controlq context structure
> + * @free_xns_bm_lock: lock to protect the free Xn entries bit map
> + * @free_xns_bm: bitmap that represents the free Xn entries
> + * @ring: array of Xn entries
> + * @can_destroy: completion triggered by the last returned transaction
> + * @shutdown: shows the transactions the xnm shutdown is waiting for them
> + * @cookie: unique message identifier
> + */
> +struct libie_ctlq_xn_manager {
> +	struct libie_ctlq_ctx	*ctx;
> +	spinlock_t		free_xns_bm_lock;	/* get/check entries */
> +	DECLARE_BITMAP(free_xns_bm, LIBIE_CTLQ_MAX_XN_ENTRIES);
> +	struct libie_ctlq_xn	ring[LIBIE_CTLQ_MAX_XN_ENTRIES];
> +	struct completion	can_destroy;
> +	bool			shutdown;
> +	u8			cookie;
> +};
> +
> +/**
> + * struct libie_ctlq_xn_send_params - structure representing send Xn entry
> + * @resp_cb: callback to handle the response of an asynchronous virtchnl message
> + * @rel_tx_buf: driver entry point for freeing the send buffer after send
> + * @xnm: Xn manager to process Xn entries
> + * @ctlq: send control queue information
> + * @ctlq_msg: control queue message information
> + * @send_buf: represents the buffer that carries outgoing information
> + * @recv_mem: receive buffer
> + * @send_ctx: context for call back function
> + * @timeout_ms: virtchnl transaction timeout in msecs
> + * @chnl_opcode: virtchnl message opcode
> + */
> +struct libie_ctlq_xn_send_params {
> +	void (*resp_cb)(void *ctx, struct kvec *mem, int status);
> +	void (*rel_tx_buf)(const void *buf_va);
> +	struct libie_ctlq_xn_manager		*xnm;
> +	struct libie_ctlq_info			*ctlq;
> +	struct libie_ctlq_msg			*ctlq_msg;
> +	struct kvec				send_buf;
> +	struct kvec				recv_mem;
> +	void					*send_ctx;
> +	u64					timeout_ms;
> +	u32					chnl_opcode;
> +};
> +
> +/**
> + * libie_cp_can_send_onstack - can a message be sent using a stack variable
> + * @size: ctlq data buffer size
> + *
> + * Return: %true if the message size is small enough for caller to pass
> + *	   an on-stack buffer, %false if kmalloc is needed
> + */
> +static inline bool libie_cp_can_send_onstack(u32 size)
> +{
> +	return size <= LIBIE_CP_TX_COPYBREAK;
> +}
> +
> +/**
> + * struct libie_ctlq_xn_recv_params - structure representing receive Xn entry
> + * @ctlq_msg_handler: callback to handle a message originated from the peer
> + * @xnm: Xn manager to process Xn entries
> + * @ctlq: control queue information
> + * @budget: maximum number of messages to process
> + */
> +struct libie_ctlq_xn_recv_params {
> +	void (*ctlq_msg_handler)(struct libie_ctlq_ctx *ctx,
> +				 struct libie_ctlq_msg *msg);
> +	struct libie_ctlq_xn_manager		*xnm;
> +	struct libie_ctlq_info			*ctlq;
> +	u32					budget;
> +};
> +
> +/**
> + * struct libie_ctlq_xn_clean_params - Data structure used for cleaning the
> + * control queue messages
> + * @rel_tx_buf: driver entry point for freeing the send buffer after send
> + * @ctx: pointer to context structure
> + * @ctlq: control queue information
> + * @send_ctx: context for call back function
> + * @num_msgs: number of messages to be cleaned
> + * @force: clean even if DD is not yet set
> + */
> +struct libie_ctlq_xn_clean_params {
> +	void (*rel_tx_buf)(const void *buf_va);
> +	struct libie_ctlq_ctx			*ctx;
> +	struct libie_ctlq_info			*ctlq;
> +	void					*send_ctx;
> +	u16					num_msgs;
> +	bool					force;
> +};
> +
> +/**
> + * struct libie_ctlq_xn_init_params - Data structure used for initializing the
> + * Xn transaction manager
> + * @cctlq_info: control queue information
> + * @ctx: pointer to controlq context structure
> + * @xnm: Xn manager to process Xn entries
> + * @num_qs: number of control queues needs to initialized
> + */
> +struct libie_ctlq_xn_init_params {
> +	struct libie_ctlq_create_info		*cctlq_info;
> +	struct libie_ctlq_ctx			*ctx;
> +	struct libie_ctlq_xn_manager		*xnm;
> +	u32					num_qs;
> +};
> +
> +int libie_ctlq_xn_init(struct libie_ctlq_xn_init_params *params);
> +void libie_ctlq_xn_deinit(struct libie_ctlq_xn_manager *xnm,
> +			  struct libie_ctlq_ctx *ctx);
> +void libie_ctlq_xn_shutdown(struct libie_ctlq_xn_manager *xnm);
> +int libie_ctlq_xn_send(struct libie_ctlq_xn_send_params *params);
> +u32 libie_ctlq_xn_recv(struct libie_ctlq_xn_recv_params *params);
> +u32 libie_ctlq_xn_send_clean(const struct libie_ctlq_xn_clean_params *params);
> +
>  #endif /* __LIBIE_CONTROLQ_H */
> -- 
> 2.47.1
> 

