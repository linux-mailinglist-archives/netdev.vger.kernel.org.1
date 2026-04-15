Return-Path: <netdev+bounces-278753-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACH1NJp532nFTgAAu9opvQ
	(envelope-from <netdev+bounces-278753-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 13:42:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F93F403F4D
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 13:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECF703018BC9
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 11:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1215137AA6A;
	Wed, 15 Apr 2026 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eVIjyOJS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB740340298;
	Wed, 15 Apr 2026 11:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776253226; cv=fail; b=ZqiPKXlnWR7aGnQlxRDd6851NI13I7jB389VptLCuikQPylrceeBMkLDFf228pOpcSXeMHqjM2SBD2NT62Z2NChZfOTefGZr2xtuYzl67ADobfRmcCeXaNHQtOcl8tv4PESioryTTyfpHwCQR+JYvhTe8WktPuiYNITjgzzGgAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776253226; c=relaxed/simple;
	bh=DB8g+zQTLpJPQTk7J3pY7vZn6iWjvN/xL81/usYTjGw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qwJFm+yaX8JRBEJxbfXlSxt2IQh+58qUERcsDVk7l5wWGwozg+L+FREBHma8F9Ze/gLRFqgIZUz9AVf0miB9RqAbtb24rpH+HRDEUPXxuanoTiN9+E80T2jbeeYUuBkMq1uzC1oiP3Oz8lVek+d0jzvDBw8y05vsaNqZa7E0rXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eVIjyOJS; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776253224; x=1807789224;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DB8g+zQTLpJPQTk7J3pY7vZn6iWjvN/xL81/usYTjGw=;
  b=eVIjyOJSE604Fdgk/RonFhaHSlFprB91eNJOVGItyRTuWpYvIwMDMrAF
   U6Xp983Qmiiq+sAa1tCSsDJUerjoY1xEKe1oja23H9DKBlB4VVwzK149k
   LnHcEHe5qlKSyGJGqNArZVKlL/4/KFqlmXwLHDcmOHP98bmhbZdf6JkXO
   +2/F6mTxElz5QrK90BXK1BauKl1KrIApueRy1lam1l1SdlyHH2EMW28dU
   /LEowgooJtiFvl1YVS7hjJvsP6XfGflsiYbT0vx8KNz40r1SNshekMTlx
   /UiZZizGt5iXam/V3IttLrqMwB9v6X4hAMGVDXxt9KCVOfvtPlpqvUqOm
   Q==;
X-CSE-ConnectionGUID: JGAbeXzaQPauyNwMm0WsMw==
X-CSE-MsgGUID: x7TxX4KoTHqo3oaxL1co/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="81095987"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="81095987"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 04:40:22 -0700
X-CSE-ConnectionGUID: +cGzsoVoSeuOBTXQCvhVPQ==
X-CSE-MsgGUID: y4dMhntaQ4yibui0zpE00g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="227749819"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 04:40:21 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 04:40:21 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 15 Apr 2026 04:40:21 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.33) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 04:40:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VjzSMhe+d4aexSC4uYx+dR8CR365j2wShrnZWxRklY5V02+/lUuQpz/tctK4SXM0tsi3h1W7FWcLymh9wsUb+L2HCd1tNH7qUZnUQkK1pScxyI+v8oBeMQtbpUc30pwRRdF5b/PlvBN0kdPcLfuiqrPjIbN6KQ4Od2/ICsoyCqMcveItKZwJtCzuWH9Ye4VCxj0QKy7qgClTYbcICtGDiC1gMWF+Cx31QmC+VgFN+cBDAgTyzZJ3kdJs4xU7+RanKHeRbJDHtJj23meJK4DBuIIZwM2/P+yMzq/ZCd/ySL0p+a1dsAUThcHQ+nmPoK+USmd9vw9ANXNmhjHcU1Ke3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNn9zmPxxti9Uw/JBgV9eO1qE5YvwyokVMaE373xCN8=;
 b=BT+EAxwShx+J9znCgRsgZ+5Bye/smUcmDKS3sEMhECTShTfgy0qZIfkl0iJnQPzUpWl/noLJu5EJfemowi3lso6dyhYxqO6KN6g2dP9jNAtBlTZsz/KEeWE0CKrs3krTvrag6VqNFskV/TOhkJC4LqHuGFjR6jl1r+Ie5Z2iraesW1pxx6UZN1qYl8fuM3IayQDlma+htl0TGkS2+X52uUzX+jvu/YUkFamcBj+zO1MzxyORd0K0V79vPD07oBBNjA4dEPDXnhYbjvK8wxmdz9bXMaqHpOteX4baiNplg6BDkVtFF9UayL6hP+faE9VHvcW1WoSgDxIx+0Vibhcixg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by DM4PR11MB5971.namprd11.prod.outlook.com (2603:10b6:8:5e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.20; Wed, 15 Apr 2026 11:40:18 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b%6]) with mapi id 15.20.9769.048; Wed, 15 Apr 2026
 11:40:18 +0000
Date: Wed, 15 Apr 2026 13:40:04 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>, Phani R Burra <phani.r.burra@intel.com>,
	<przemyslaw.kitszel@intel.com>, <aleksander.lobakin@intel.com>,
	<sridhar.samudrala@intel.com>, <anjali.singhai@intel.com>,
	<michal.swiatkowski@linux.intel.com>, <maciej.fijalkowski@intel.com>,
	<emil.s.tantilov@intel.com>, <madhu.chittim@intel.com>,
	<joshua.a.hay@intel.com>, <jacob.e.keller@intel.com>,
	<jayaprakash.shanmugam@intel.com>, <jiri@resnulli.us>, <horms@kernel.org>,
	<corbet@lwn.net>, <richardcochran@gmail.com>, <linux-doc@vger.kernel.org>,
	Bharath R <bharath.r@intel.com>, Samuel Salin <Samuel.salin@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net-next v2 05/14] libie: add bookkeeping support for
 control queue messages
Message-ID: <ad95FNgQ0DIB7ONT@soc-5CG4396X81.clients.intel.com>
References: <20260403194938.3577011-1-anthony.l.nguyen@intel.com>
 <20260403194938.3577011-6-anthony.l.nguyen@intel.com>
 <b559c877-7712-4ed7-adb4-d2b667e16e74@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b559c877-7712-4ed7-adb4-d2b667e16e74@redhat.com>
X-ClientProxiedBy: VI1PR07CA0270.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::37) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|DM4PR11MB5971:EE_
X-MS-Office365-Filtering-Correlation-Id: 19403542-0631-44ac-958d-08de9ae3c482
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|10070799003|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: ssy6qcKFmPKKLmDkqpqFmaRCl7TYl8Jz4WxbytENOnT38qNozs5OQqMsTbQVUdU8r6wNivOkiEQoCchK3SaeO3XT6UIOGvreUAvCkNdtsFvYu8WJSnwKN0s2mmS2u0s1os8QVoKx4Ei9dgZthvBoKDaoZ1Vo6u4KYbnBxVjgi1aMIEjH86RLg7Ksm0VmOB+JI3RntBRITl6ZQfT/QsEn1nicNMekm4Zv9mkLgulCjgFNR9igRq2+meB7+qFzmuAAK/oH4sDcNsQqpoVeKvUS/6bI84x6DRv7c8+eLdU8HexUw0/XnD1YGq/rPLX/+aSYlqU3V73H0ErSjJV6bBpu+aVK4YDjU8/1b4+UBPkyNZMTjhYygScTYYkJ2Cv8kFGYd2DCWkxPYAw/ykQUJwqP3duBoA9H/ooo+8ASTF69uLhGKEExYlWjAj1dqcG+gP1frQ//2n+H0DBdxNT3i5L0iS41WKTd75foTxemkecztq5VZQN6r01Gs3PAQOu9j46lU2cgRbp1AgRViEveaQ1yhZgC+s5PHAiBDRXFl3gkey9u41FgY+yZDVxpT9GhIUvIymSgM8bKfrZ1b8Kt9DtnwjXUrK3TI+03WMbhKsLMsz+i/lxFBG0a88rY1JreTBA4Qd+BMqrdNUAFt+qREqSmbt+tn7nJdErTYtwnC20FTBZqx21kr99eJZD/s7S4Pa5UWBiO6BPHUe6Wa1FU0PofJImxoUma8o4NrR0zj2+SIKs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(10070799003)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mHKqMAs1rRHjaHFTmA7kjsPNpUTy/p1fILXv8wQCmuBGYv4CWTtHhN+VH291?=
 =?us-ascii?Q?OIy1fIYzVW06Zkl38WvNUVjlPp5w1yPtl4YDMd9YKJA90E79/lUARx9/GtzW?=
 =?us-ascii?Q?pd1W6G1ygKEAbojmhCQWJ5Dl5VhEEYt2x5ubhh6cT5KixsZu/t/ROBd4cUyI?=
 =?us-ascii?Q?pk84cTYQtws3cnG12HtwDD8SuHAMKt+iRXIK0EkaEU9xgd4kMj5aPq4Z5R3U?=
 =?us-ascii?Q?Kzi46zDus2dVfLrs8xHYTBIyqhY/18k3aqP5xqYdZTf83q/Uka6Dci5F2Wmp?=
 =?us-ascii?Q?1ioN6cFnXSt7SjLNOrdGCBs7ysPSGqWZHiwNhCErpFziqlqftf9z2ebpOtFz?=
 =?us-ascii?Q?02U8JfuK6yTkYsfWX/JlkpTN8CL2FrDGHzONlLaijb2fZOzR4otfCNPatIL9?=
 =?us-ascii?Q?7dP+pXWJT0FFIdP0M+9rhNlbcS8YPwwuuyeEaYby67NjbEpksE8dFWG1v3f/?=
 =?us-ascii?Q?b1yL18rksP7AyL3VPfayDZFA7WLSAa7F8+yfVLeRAkCRiF0Fi1GnOncuwnyC?=
 =?us-ascii?Q?10dGYhGwPErnD4rtMkJGsaw1Ku0juFMAbxKmCeXAWbVHafvU5kdyfehKvjoG?=
 =?us-ascii?Q?cwlJjvOJyrLNMT4uQHYcFhr2gaQeQvXhl5mZOoYZTjbOReNf4aLmDRS4/a5f?=
 =?us-ascii?Q?miILwJ8VCztFeyZEU9yfr9P0fjhnLi0XlbrLBYzxviTwcPjQcncFU9/G5K1o?=
 =?us-ascii?Q?G9KIQjeNpn6dHg6VoFyiUWLQt8Agps7OyY1Kj4TBA3BFBz8nT6L7jb8NfROD?=
 =?us-ascii?Q?7E5pVU2hGTTPR56p79c+U47i3SyfhlptwMuOKHDalcTNzTtx8Xi7RN+Gh/qU?=
 =?us-ascii?Q?zOZ7Dz+4zFcof/sKCNXyNEZNVrSb55FTGq5AmH9DKsJDuzbm2Q28xY/avOMv?=
 =?us-ascii?Q?wNjegkutqWrK0BT2phVaRywGhK8eYa6467g1ybHwQKW881LSjlwZoZdauHU+?=
 =?us-ascii?Q?9nfrPZlOQKN68uN4CfQtnlNvYg9s+t1pTELcifzNG9A0YWHKeAEeH8vef0Gr?=
 =?us-ascii?Q?ZMuPlZJTwD59zldCcUVKzeM/jYVWgCeoM6VepWpmQOuiG1ZUM29ni50znDcJ?=
 =?us-ascii?Q?LFSnx6DRcyixGJKf82tVNpl1M4PgxoFXLOt4E6JS0c8G8jJ1ENB7OQ2KS/uC?=
 =?us-ascii?Q?q8JtCqXGor+hkAtjfChM9lRiRV9Zj9f7Q23xqxca+2+TPfHeMsPveIcxwMZJ?=
 =?us-ascii?Q?M3x6LWmtUeqzUXZqDGH7xZcwwUwSpaPtFJYEWFn752kNO23QIBL0LIgHVRAj?=
 =?us-ascii?Q?bpcM0Ap7+nIEnk3lfvpzmZdGYMm/9xw4odzdJkox7WWLi9gyg2YPHz0u8tv2?=
 =?us-ascii?Q?HnIiMLkPhPaduswaKD4ShjwNMvyz92aSQA/AVWKPFN2YKvse2G8aD8a0MCM8?=
 =?us-ascii?Q?MJwV0ifsDIdR8pteg0vTZMIYnU3JG5C+s28gH80lHulGFFZA/jINvo9cYSfj?=
 =?us-ascii?Q?G73A9vXOMIxP+YNC12r2RXk80OZEWrO/Yn9T2Ga6M3z0bLGTf0vhsiBmh2AS?=
 =?us-ascii?Q?OxcNOcAXeWe5C9xHowlIx0gqbMaNwkM8NR4Hv5YBgBbTUPY1TPuWDGD6MJ0S?=
 =?us-ascii?Q?+mL/tZBEUFY2HXuIwfCnS7zcxm3qBsvl9PYzD8UFKa5+xd9H/OR2p6NCEI+r?=
 =?us-ascii?Q?hACpUNgXTpCHfBZ+hCDD6/78mIkUsr1Il8TDr40zd0W1UHS8EGlrFp1ciScy?=
 =?us-ascii?Q?HjWd+ej22LlyaMPzpnsQuM0Egv4+c73PRcfu0vGwaCsoi9W5PcB5Wc08hsH5?=
 =?us-ascii?Q?qSxt8+WqH4FiicnKx7VmlQeCZnLZXDdQFAJHB00SXFroq91r+k/giaH50tY/?=
X-MS-Exchange-AntiSpam-MessageData-1: VxeCRZQwDe9APA==
X-Exchange-RoutingPolicyChecked: nR2Kol1Uh1fGvowvXM3AHeyoGURFoS6XTOVnZXXfhuepS1BgzHEiKCX4T+G7SB0Gm2OW+AsxDpXjJmF6dn2bJk4dohG9GCuLOJckuEC6o1Bl66iSn48ELI/4BwxzbmKjsc0QiJlesntuZYJTxC+RF60gQW1jPsT0mTym7xIH64zjSse3HrYRILfGiREC91Eq7SPnk6iT7a5CqImNwRuXTVaDbKCrauaKhNWthontoiPmeW5NXea8IjJwDmIS4dpbCoPeTUVyRAudm+e4U7tZMqTGuKqVOnTj26d4vgBxmDP+YFHF3r4rrfKKqGJA+P5PK7+zhp23+nAJb0zxQmBJIw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 19403542-0631-44ac-958d-08de9ae3c482
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 11:40:18.1229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ypa6L6mLrutvYY4sVB8RkxDJSh86zIEiZj1uJDNsNTEJwgs1wmT4TGti8gWuegZbb8LpTjEN88MNMLfoQe7x8iqPzZCZIOnKOL9FDlPNwfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5971
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,kernel.org,google.com,lunn.ch,vger.kernel.org,linux.intel.com,resnulli.us,lwn.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278753-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 6F93F403F4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 11:07:02AM +0200, Paolo Abeni wrote:
> On 4/3/26 9:49 PM, Tony Nguyen wrote:
> > +static bool
> > +libie_ctlq_xn_process_recv(struct libie_ctlq_xn_recv_params *params,
> > +			   struct libie_ctlq_msg *ctlq_msg)
> > +{
> > +	struct libie_ctlq_xn_manager *xnm = params->xnm;
> > +	struct libie_ctlq_xn *xn;
> > +	u16 msg_cookie, xn_index;
> > +	struct kvec *response;
> > +	int status;
> > +	u16 data;
> > +
> > +	data = ctlq_msg->sw_cookie;
> > +	xn_index = FIELD_GET(LIBIE_CTLQ_XN_INDEX_M, data);
> > +	msg_cookie = FIELD_GET(LIBIE_CTLQ_XN_COOKIE_M, data);
> > +	status = ctlq_msg->chnl_retval ? -EFAULT : 0;
> > +
> > +	xn = &xnm->ring[xn_index];
> > +	if (ctlq_msg->chnl_opcode != xn->virtchnl_opcode ||
> > +	    msg_cookie != xn->cookie)
> > +		return false;
> > +
> > +	spin_lock(&xn->xn_lock);
> 
> Sashiko says:
> 
> ---
> Because the cookie and opcode are checked before acquiring the lock, is
> it possible for the transaction to time out, be returned to the free
> list, and get reallocated for a new message before the lock is acquired?
> If that happens, could the old delayed response falsely complete the
> newly allocated transaction since the identifiers are not re-verified
> inside the lock?
> ---
> 

Yes, there is a race condition risk that is easy to fix.

> > +/**
> > + * libie_xn_check_async_timeout - Check for asynchronous message timeouts
> > + * @xnm: Xn transaction manager
> > + *
> > + * Call the corresponding callback to notify the caller about the timeout.
> > + */
> > +static void libie_xn_check_async_timeout(struct libie_ctlq_xn_manager *xnm)
> > +{
> > +	u32 idx;
> > +
> > +	for_each_clear_bit(idx, xnm->free_xns_bm, LIBIE_CTLQ_MAX_XN_ENTRIES) {
> 
> Sashiko says:
> 
> ---
> This iterates over the bitmap without holding the lock. Concurrently,
> other paths modify this bitmap using non-atomic bitwise operations like
> __clear_bit() and __set_bit() under the lock. Will this cause torn reads
> or data races that might lead the timeout handler to skip valid
> transactions or examine invalid ones?
> ---
>

This should create only false-negatives, which is not a problem, timeout time is 
much longer than libie_xn_check_async_timeout() calling period.

> 
> > +		params->ctlq_msg->sw_cookie = cookie;
> > +		params->ctlq_msg->send_mem = *dma_mem;
> > +		params->ctlq_msg->data_len = buf_len;
> > +		params->ctlq_msg->chnl_opcode = params->chnl_opcode;
> > +		ret = libie_ctlq_send(params->ctlq, params->ctlq_msg, 1);
> > +	}
> > +
> > +	if (ret && !libie_cp_can_send_onstack(buf_len))
> > +		libie_cp_unmap_dma_mem(dev, dma_mem);
> 
> Sashiko says:
> 
> ---
> When libie_ctlq_send() fails here, the DMA memory is unmapped and the
> buffer is freed by the caller. However, the software tracking ring at
> tx_msg[next_to_use] still contains the populated send_mem details and a
> non-zero data_len.
> 
> During driver teardown, libie_ctlq_xn_send_clean() is invoked with
> params->force = true, which processes the ring without checking the
> hardware completion bit. Could this cause the cleanup routine to process
> the failed slot again, resulting in a double-free and double-unmap?
> ---

Yes, I think that in trying to avoid unnecessary copying, I shot myself in the 
foot, will fix.

> 
> There are more remarks on the following patch, please have a look.
>

There are also a few AI's comments that will result in fixes to stable.

> Also, it would be very helpful if you could help triaging such
> (overwhelming amount of) feedback on future submissions, explicitly
> commenting on the ML. Sashiko tends to be quite noise on device driver code.
> 
> Thanks,
> 
> Paolo
> 

