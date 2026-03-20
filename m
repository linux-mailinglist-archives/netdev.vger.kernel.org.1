Return-Path: <netdev+bounces-269968-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHwQNntuvWme9wIAu9opvQ
	(envelope-from <netdev+bounces-269968-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 16:57:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 842AD2DCF70
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 16:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D3C843008C3A
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758283BAD83;
	Fri, 20 Mar 2026 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S1pOgfGH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB31E3C3447;
	Fri, 20 Mar 2026 15:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774022264; cv=fail; b=MYFZeF0Z0j6h58DzfPwWj7AgBMe9fZNgYP+jEXxLrIv/buwlVwzaoJT+eJCE/+JxnL1lBi/z608JbENhPx1/Dlgs/Zmp66Gdzu5TB23eru4q3ruWv2XHv3M/mQKC63fDCZqU2ciDG53GQbwvTpDS9DoeQPV1xtQnJ/9sc7921og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774022264; c=relaxed/simple;
	bh=VxsDSwobM1P2hkPNe409EUTi3EtM5ImGN8bPIBlKWBE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lIv1l9ZHkCwksbucSJi8trX9wlBUotINJpHNcllmMl/bO0z4auDZpl9mGYVql1i8SWJ9Th+4EqE6ylXO3Lze6nLF+iGkssTIew1pHlxpuQkIPzZb6thrwtlQF3kEmdFGzED/zmEE+wMpHduhzTf0/3ygwRwdgjlsGoEZGRB567Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S1pOgfGH; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774022263; x=1805558263;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=VxsDSwobM1P2hkPNe409EUTi3EtM5ImGN8bPIBlKWBE=;
  b=S1pOgfGHPK7Ls0gG34NpChQsfJeUyDk/rav19IVPusnJRJiFtnTJgu9B
   SMbNqveDXr6E3AUJ0UBVavITHttMzqnn1JhZT66n2eTCgcdIJDam8paWy
   fII4felVWENS+flgZbOkqqHpD9epmeXrYe6ceUI5skORMBo25Qun7BeDG
   ZbC4dGMwPF0UCfV/Jj+wzv9lzOxc9BnEccTljbqpRtehabji4/8ChY0O5
   0/QX06gwmY1AC8ywGywUqjQ8RgOOYSa8s3mXnJFnErkoZQupP2/gOIM+I
   KFtyApE5cn8VldbM22DFKcm3nhIzgPw2b5vvGl2znSHi7EbtcPAUiC6xF
   w==;
X-CSE-ConnectionGUID: qAOhyUA1Q2+cUOSrQVjh/A==
X-CSE-MsgGUID: BAC25lZhSCaalUKPUM4+0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="92494876"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="92494876"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 08:57:42 -0700
X-CSE-ConnectionGUID: E/sdFPzHRXy4TeIpYgX4ww==
X-CSE-MsgGUID: HT4umgjiTo6BFes8xyw+LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="261227795"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 08:57:41 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 08:57:41 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 20 Mar 2026 08:57:41 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.30) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 08:57:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cOd5RsErrU/BEyPC6hNedjqZdZaFNdE1G43IBv5rLfoG18UX5z9tVy9euKpS0jgINfkufjApNOQT5/Od2lOBVBNUEk75PYi+Ndi6BNa/CD+yHj9gByr9z/3XKXjnWxedMUxRbnpyz5OKldrv5yGxDTsQ0veT/hosg0hQCMpJTUCebe4FyBKqF4p5LTLKhN0uaHkd1yNtLEGhoAeP1uXj97Zo7IeVNTunUnVvV1W62lidx8UqsR3DUw+GL24nFaxmMdpOh0/yT/mKy086zB4D/3dF7gTW17cDJD9gP0G3WhdvI3GmzeuSHvNpxhbDgfR6vancWABAS1OdD5rBW7jJag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SzztiCRvD29Ea4TtKFGMx5LLb9UR1fyoMcP5fKUvr3E=;
 b=Ab+bi63v07CD4gY8nI/AX28vSkhWgAc1KBGDUiflaqS6qe/4AEljOaOFjSUP28gdHcQkTj+tnNfojLvB2pffdRZYLtH6cnyxxEAYJrVUdNB3Ax5th/Hj9H2PW/f4itZlz/Hm3IIP4KCCWlgR3ujPGQujwG/MCPjv199eyZhK1+GqQ2/8t9yhzMCt+1O0VnpxuD/9djQ7Q8L10G8O8140Yh9Fb6QZspZfRxOgn4sIa+Wa3N+3w1Tz9x22XAynpFlhThxvVwSAxOMdpXd1U+ZMs6hkdYT5QXs3m7JpYUDSOmA+UkXpC1lpXFJqjrHPmQkXiIEWRJO/dx7uK0H0h6rpng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA0PR11MB4672.namprd11.prod.outlook.com (2603:10b6:806:96::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.13; Fri, 20 Mar 2026 15:57:37 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.20.9745.012; Fri, 20 Mar 2026
 15:57:36 +0000
Date: Fri, 20 Mar 2026 16:57:29 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <larysa.zaremba@intel.com>,
	<aleksander.lobakin@intel.com>
Subject: Re: [PATCH v2 net 3/8] ice: do not round up result of dbuf
 calculation for xsk pool
Message-ID: <ab1uaeVELU9FLPXJ@boxer>
References: <20260319175538.479139-1-maciej.fijalkowski@intel.com>
 <20260319175538.479139-4-maciej.fijalkowski@intel.com>
 <87y0jmoqwk.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y0jmoqwk.fsf@all.your.base.are.belong.to.us>
X-ClientProxiedBy: VI1PR10CA0110.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::39) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA0PR11MB4672:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f6074f4-a59c-43ab-3dc6-08de869967af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: /L+9krLAgXkhjR7qBr1bAFUY70DTxoRq/01gY0V0Q6HLxWTNbC8ReCa5NXjeuZtkeCX772pfXOGAA+j/SdFpB9ZhuBhmw+sBQG62a+PDj3zpxPllDACIzJzvhg4gjCaxkBNg01diEtxhlmU1NQ16T6KuhgaXIiWR4D7ZODM4H+Txfsp/gfyYkwjhoU6a3+3jF6xiAYrW8vs/NX0F/NQgzRLnn3/oKqIwi1oM6A30AMo4gvesBhFBl549+k0/0GxM2uAJ7o3f77TRVTLRyOelR3MpGnIJ9Lp/3e1oH1vjswhKZROfzKwUGP8FNWyOovP5AylRXKPZCNnZkwKIHOATYllfPonYpcLYtNCFqRHZwdX5euq+nwtqNum9p+gf0lYHxp3qTDzeKY5DVD3LhlYwPWRoZrRCyPhKOcuvgVeQfMQbuWVS6YLZKUxZqq4xIZiTUFm2HMpltz+hXh+/4PUwXxroL+MSw0Q1jkSRbU1+LCGIj+pGIbox7/QfvozDD4fVjs4QO0OLj6dBictmWer/ZsFpNUK6QlRQUpevG20UXb00iqALwYV72P8UrxgDTiXUy+Gdp7WqA94GvuKMzLZt1XsJYpSYGmcTqi2UJHjKLgMkSw+rjaSiP9jN682PGTRYfauHkJepetbpbpU++BAutqWcYUqExLEkk8q/BeVb4gty3l9hoqpqhlUezY+UEZS5fcZsxCisqlR3wr0ZTYU21uGFiD2a8jI8MiZXmT32FSI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?MV9YYKVpY6CmMpWVeA8YKfdTKZV9ykAVsy0OhSHvyddOQAwF2WgDw35Vnz?=
 =?iso-8859-1?Q?DqI763w+hWyKcM2W1NrDTSV5YUmeMbkVZvwJA/Q7MFEgd2o3lgY/ze5iwc?=
 =?iso-8859-1?Q?GTxgP1j4HUnU3iphcQWQQSHIvbNEQverODJ5N4Vo0TMEqrZDBpIZBYYb1I?=
 =?iso-8859-1?Q?mDXNmpC/+EJxb8p/PNSwTc79SAIoDl6yYGhz9c44QhwUDSpx5aiOnyE7Ol?=
 =?iso-8859-1?Q?kbYwMU6LtZmD87qFfyDk4GPh0me/ez/eC38vtJXgE/Gfb4KdP9jcwpKcrO?=
 =?iso-8859-1?Q?iLVMPcARQ34k+rHSGZK/37VxDxKhogwock0Yp3cfFkwN7Z6uPkfsvqtM4Q?=
 =?iso-8859-1?Q?4cakvFpyAcQMvYqYFbeUCIk76MwQhX+NcBfH8pbj9echGlPOfFJ7SjG6m0?=
 =?iso-8859-1?Q?HDotwiqpnAiotohswbyKD7kLacqT3UPtVJ0jUb9lqxtrJkZWaDcZP/77nL?=
 =?iso-8859-1?Q?+Uwez439Xb3mKdA6Xk+hiufuJgnMouHI0EFFusNcDb4OcdXPHCLoHIuWkv?=
 =?iso-8859-1?Q?gXDQSs/Z7ywVHQpfYGRWShhSEU8uS1awa8Ad6412l90/Uh98WvLH8Sh4Qk?=
 =?iso-8859-1?Q?k6Ap/I2fD6gl11AFQPRFMbZ5ibgArueVlx75oZCHuZ6iv0FaUm4gB50SOh?=
 =?iso-8859-1?Q?EMkcKZ8HuUNwjGQ4O2kkq3dNSkr0HeRNHkgLsUndA3MhGLdMYT5uLt6Tf5?=
 =?iso-8859-1?Q?KYwjgRxFKIi9ssDdDooviKTPu09P8Bgcr+AYQnPBAxCFV8/gn/Jx5oKHXv?=
 =?iso-8859-1?Q?AO37wW3tWZEOqjuNrURNFrHdsdHAp3F3SXaxreTwIB6ZHwL+K11PrBHnLC?=
 =?iso-8859-1?Q?quKd+uhyFAAcBCONI9Au1m1YxH103/rpyin9U7f1OsR3G7VxNVImqoXMmE?=
 =?iso-8859-1?Q?HOEyzqXYI6abRcRkCu+bDzBMqAESCdQkdIQIhzBHh8vLzVSu/dF29STqZp?=
 =?iso-8859-1?Q?OOK2xJimZKcLWmAUEHQb03RDRQr8pC7Fn8Wx0TMZa7nhvKZZLyql8HwFVN?=
 =?iso-8859-1?Q?U4zd6njKTZq6xc19ZrOXOZ0of82o4vEu1878hAZuDJZM1iY8R2S2vyeHgA?=
 =?iso-8859-1?Q?/JkSTz+08Gpz72w1ni/Oca6wEEbD79FDQVtI1puQXCRz3/8dEJ/Q7DUzDi?=
 =?iso-8859-1?Q?GUcEYJz1uLItrV81CrFQdNcK1ZbSCTgyDAhVtKYb5+RNELfv5pqVmgFXu3?=
 =?iso-8859-1?Q?IR34VePFoofNfxxvRWo1y1KlemPjW4hg8n4/uhEUNpAu51m42jv6fN14q5?=
 =?iso-8859-1?Q?awYNjBSKPFZUjV0mj4+dgPCfNXAvtEbNeZ8gJMMP7igMFPPrgSPsCl/nOA?=
 =?iso-8859-1?Q?SJZwzu2fJLEbSIWmX7lkl4tqK5manNOoESrePVs81KvVY8vLkGK0VVDgKV?=
 =?iso-8859-1?Q?8KMxQo1ue1BbIwpF6MNBLTLhU26amOdYbmihyPXbjIlCNE/gydbK7/NkCG?=
 =?iso-8859-1?Q?Wmloy+yl2K/acCylmyzAwi4jVR/dFmKmGiCyZkiBRxqj6sVDOQbRuLbGOA?=
 =?iso-8859-1?Q?G0dZNTV4wq3SrCCl8omn2BSoYpO1/dCR1Aw1EiatOwydNhL+KbJcN1YYTN?=
 =?iso-8859-1?Q?dqJMDR05LlPpYzBCP4iefl2/diau19cseAvkxqVTYKMYfh2KNwK2t7i6cC?=
 =?iso-8859-1?Q?vz2Wbk95zwkinj0NZr1tFVzKT+fADuc4A5p/t7HEoUKBQ3J4Q/1PiYm6Yc?=
 =?iso-8859-1?Q?4ROezeqOqkAN0jVV/tGW+hxeb/ISbNzpLBB07EldUBa7CgU9mWTPq+7MRM?=
 =?iso-8859-1?Q?JtlPA7pYfBhMzEujp6Qy8ltsRfMOGiQAAb3XJOytVREi/IJma2Ut7JSm+g?=
 =?iso-8859-1?Q?EeADdQiT0THrtnbPLUpoB5XED9185g0=3D?=
X-Exchange-RoutingPolicyChecked: oyiYOrnVJVtKiGm2gMXwwXoo4zNn8n3PKf1ByeV07kv6I9ScDaoN9i6BSW9clNytewaIRKYbOd7i7M2Pu+/HHwhflJez/MdqQ6AkEHlPzklFKx7+XJPLA13Ipbgi/laizrjxuEBTLmF0AwtsZZ/HrpdTyOlObt/Y+ZEkS0+GlDIGUkwiN9MIxTLqU+K7quDls6VKMws6JHwcyo86DZVtOhnQisFOd1iovMdXP9murRnbIMmtMes06/XBZJR4cs5lpvk5uAiWA3+C4k1PXy6E61tQcYdXREXnoGDJS/KAj4R+oTOocCFkpzSy66mNo6tP20tjzt+EycygcXZ031IvaQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f6074f4-a59c-43ab-3dc6-08de869967af
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 15:57:36.6523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0R7gSwuRjcOi8QXZQfACaNGDvxH6ct8SoRSUdDC+WP1E5cd/vxZLJmLquwYblIkK580HsZGf+jDpDWITZdn8HqUPKrvYSU7+5PK8ZTJOCm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4672
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-269968-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 842AD2DCF70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 09:18:19AM +0100, Björn Töpel wrote:
> Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:
> 
> > When programming dbuf on rx queue context, avoid division round up as
> > it causes to actually corrupt the tailroom for AF_XDP ZC. Below is an
> > example based on 4k chunk size when xsk pool pointer is valid on given
> > rx ring:
> >
> > chunk_size = 4096
> > headroom = 256
> > tailroom = 320
> >
> > ring->rx_buf_len = 4096 - 256 - 320 = 3520
> >
> > rx_ctx.dbuf = DIV_ROUND_UP(3520, 128) ->
> > 3520 / 128 = 27.5 -> round up results in 28
> >
> > dbuf programming unit is 128. If we give 128 * 28 = 3584. So HW will
> > corrupt 64 bytes from tailroom. Decrement dbuf by 1 when xsk_pool is
> > present on given ice_rx_ring.
> >
> > Also, restore ::rx_buf_len setting via xsk_pool_get_rx_frame_size() as
> > of now it respects the tailroom.
> >
> > Fixes: 1bbc04de607b ("ice: xsk: add RX multi-buffer support")
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_base.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
> > index 1667f686ff75..f9514d7bb83c 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_base.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_base.c
> > @@ -500,6 +500,8 @@ static int ice_setup_rx_ctx(struct ice_rx_ring *ring)
> >  	 */
> >  	rlan_ctx.dbuf = DIV_ROUND_UP(ring->rx_buf_len,
> >  				     BIT_ULL(ICE_RLAN_CTX_DBUF_S));
> > +	if (ring->xsk_pool)
> > +		rlan_ctx.dbuf--;
> 
> Hmm, wont this be overly pessimistic? Smth like
> 
>   if (ring->xsk_pool)
>     rlan_ctx.dbuf = ring->rx_buf_len >> ICE_RLAN_CTX_DBUF_S;
>   // else round up?

Ok!

> 
> 

