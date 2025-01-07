Return-Path: <netdev+bounces-156073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5796EA04DC2
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 00:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43EAE166796
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 23:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C1B1F708D;
	Tue,  7 Jan 2025 23:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F5XzwO8H"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6716C273F9;
	Tue,  7 Jan 2025 23:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736293344; cv=fail; b=EWkD/SmL3yJR1LEByPtnLOTrFKujL5RKK8Sr4ewTOEluuMqznhyBpRWceNS5eiYVzFW8/sUNC8SoJrCoQbSF8494lFOMPFY+oi3yWYzCn15lDq6iYhjoTc+BT1AxhJte4iid0IfKGp4Q9CLdnL0AryX29OrZQWeU6ZLHE5eYGfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736293344; c=relaxed/simple;
	bh=YbupoFRCQctxv84gLGdOnVQ2ku9QplL2Mo0+ydiUzZI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KwNTHTpIX56AEK+PuAiW9pM1bCa1Egrxx21QbtHENeJQ3mXklZ+2v6TCzm4YItjF5Iy+wIxGpLKJAoccqfHFnNXUs/Plv5hsM8EUpms/HFURwiVPecpddsTugvbkx7wIfSw+l59ALQa6rIDad6JJ8zBQb2fNqVxFoFgLPYx7qUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F5XzwO8H; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736293342; x=1767829342;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YbupoFRCQctxv84gLGdOnVQ2ku9QplL2Mo0+ydiUzZI=;
  b=F5XzwO8H1/YLEZgLVJwFZMRPwMg29GtgB0eFmr5VG9SXOczl7zVqJHjL
   Ouvq18VeNXj7FRGR9qNCc7o/8xhHuoGyae2mGkkk7v7kp+4TCHLP2kGuS
   VpmL2C2U0KiDswV6/zzGmkfuuBTmrfQgL3/cF1OlPUrXzuG3ShRfjjfA0
   91OrX2P5QkZJnPbBO++DeEz+4QSqPG/ZbP1CYoFHtff4ksllYTiV/68NS
   MacT48yYfpZUZ5K96I2kDT+hJEIir039st0NQq3WyzgOAMoPoAsBp8dv+
   s24eSe5XKS1p7shZEh0skH8lWDf0qSbPkiYuUGAyy8cDl7dQNXc5Awu1n
   g==;
X-CSE-ConnectionGUID: rcagkFM5Rc6W2lmRio7NDw==
X-CSE-MsgGUID: I9bXb6QtRwST+hrimHH2mQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="36717759"
X-IronPort-AV: E=Sophos;i="6.12,296,1728975600"; 
   d="scan'208";a="36717759"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 15:42:22 -0800
X-CSE-ConnectionGUID: VqvYJOXxSiisSUnwbjot6w==
X-CSE-MsgGUID: pEvOYAsoSumD4CjiHqkYtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="126210371"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jan 2025 15:42:21 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 7 Jan 2025 15:42:21 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 7 Jan 2025 15:42:21 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 7 Jan 2025 15:42:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdOqo5/kblAO6vi/iMvALMerPtxxIRnZwBRUSJavtZIybHBZ9W2jqtCzgENhPHRyKpQIQl0r63ajnIdwgCy9xzkL+jb2Y5JhGgU+7Qrsr5CX2fjsd+xrNr0YD1nWK9LuFweCIHPDl4J+R3XAMu4E1odq0rjJot7FErwA3Hm42N/ged0UdaWEgF6rLdMg+rqAPpOKtjEKEe2p2xqrgXKQXxQPqVjZSz1UdPYxfm5azFtTqeaLXXWjrr+tqlFBhIjqhlBvR9AMKl2i8bN+la6WWcTIM8GduDOgEzSYjAMZHwl9DFkqzoZdCuIMz4ElCPdpPU8NFSW8YZhg9dcUB5w94w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmXin7Znrqt/HStV9F7MyOd+kgCLALiUol2JfMQOJ3o=;
 b=KqjZ2oXOWx3Nb3wo9i2R541V5E7nV3ncL8vF7pY8fk0DCiP99WYliBgYZElBdXBYPg6Yq9XNFYGTQzstCMp6pHpsgupjfU7t0Eoz5okATIAfQOxbFWian1OPA2f5DTJvztnQ/DI3izKPyZ+fEbnmhF8YKM8VulmAsf+Cs4JWOakQv2HYJhJ+6WXzGfHvoHY/esQCb3uxWRJUhNTIV6cr9ukgn2Q5CpOQklXSzPpI/WcCZgINdV6zg90K73CAPywQjRLq50wMBTdjL6MGqXP7p+k6LDDKSW/AYZ5X4fzBho2m5r2Yag4+oy3yvpcFRvV3Kz3VnZVsMVH1LfN7jVQFfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB8445.namprd11.prod.outlook.com (2603:10b6:806:3a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 23:42:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 23:42:14 +0000
Date: Tue, 7 Jan 2025 15:42:12 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v8 01/27] cxl: add type2 device basic support
Message-ID: <677dbbd46e630_2aff42944@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-2-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241216161042.42108-2-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: MW4PR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:303:16d::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: 36ced7fa-4e8e-4393-9681-08dd2f74ea23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6kz/KyQnU+Fqy79DJ3euZ/DA4zK9qz6YUyyGZk0oIFyMQqGoIFuVASeHv8e0?=
 =?us-ascii?Q?FgJgGA6zDBCTum8MsDxVuCBx7jib+YBxWejkEqPTna/OFJicUnLsT+kt35Ee?=
 =?us-ascii?Q?Qi5W8xBOlDtGpytu8dKmNts255/IBWmWepFQ653rOV/Y9i/BvNbgSWunQkeW?=
 =?us-ascii?Q?q2rBZszNqbc2+Q6BS/2XYSeeqxEkc98pbdzW5FLc3yQTEyyAabRG4Rbf9OXH?=
 =?us-ascii?Q?oHFGihoHAWslcXE102C8AvuEdTNvF9rIzOUECAuBvXHTPTmsL0reygx2fNvO?=
 =?us-ascii?Q?XSTaE6yRXo/qjSkLlv+f9m+WDULqn6JEbWlXG5H7moEt9WA3kJRBkByiFsJs?=
 =?us-ascii?Q?aQ9rC2KMXcn+VCaNlqzoPnXudaMAOJdhExDv6GJDc5BEtUTFJIik4xypnExO?=
 =?us-ascii?Q?WDYXTEmtQvRwCuqHeCu/9f2tVZ4Qg6jpEl/VhRgpQpP0OCZWyFe+/If+/AQH?=
 =?us-ascii?Q?phJKGv+SFQT0QnJvoqsiXBiRZWlLZbGTNGpdWWyl45vQH+zL//TztAeJPiWY?=
 =?us-ascii?Q?sBmAI69KSaAfIS/9FrhXXfmRff9AToLQOVkhS49Oo674YDrRsQlg4H1TeRAb?=
 =?us-ascii?Q?UtulbLOYXkZKqi2FNDPSk0aDUAPPzpQ+bdTzwL/uL14d7n/kKMKNumTkNu29?=
 =?us-ascii?Q?tri3qadHJcK6eNM/0WnZwCC3zLQboOpna8XhsgRnHiLCGR/XxAYW71bL4m74?=
 =?us-ascii?Q?mIkWkV7g9gSlzElBmPCo+FxX4PjN89b65U2XiE+AAnNEuy8ObKbdH5oSg7w0?=
 =?us-ascii?Q?Epm1mLOaYF8CwHPZ63tSptD9CeSzPdwH0tl8rduHSuGJmc9ZR/X2ue56LX75?=
 =?us-ascii?Q?aL/Bwu1weIQCsilvFiyjIzkzqJpU8Yu7qLy4Eo2weUyCf/lnEAWrAdY604YJ?=
 =?us-ascii?Q?a15rvq559mVQDUC16kcnzZ5q7mpMVa7W7ivs85YU0WGah22OvQTlKb90YtcQ?=
 =?us-ascii?Q?LP+IPFgre+OIm5BaZMZh7qPn9GMpe1++sjhKrBY562masdkaLquW/vUMkz4p?=
 =?us-ascii?Q?JHi417tyy+ejHk/1xnr1C94DyGrB68mWGT/nowAIfN546BeR1Cqo81sOfKlX?=
 =?us-ascii?Q?KF8I4vIKkgG3Nc6oYlnDatTBPmSGRUgtO0ef8twYHhJp4PWBXmwt6JIteSND?=
 =?us-ascii?Q?lJqNmLrJTbQqmepQBcr+BtBz3hdhGFF5fLrtAIDuKSY/mfdxJZ/wHqIRqidU?=
 =?us-ascii?Q?BWdJ/kUaTOvbuppBIkCcerbOVfg4tXlAOVwUjXWlMHJ4xBzGnwIb4Vb8pb47?=
 =?us-ascii?Q?SqwXNE2e5dbbxT94euMv6zwlR9Jnun53Kae8lG/A1tZJM9rQdg0Q81fvLOqZ?=
 =?us-ascii?Q?8Onn8ZFWYuEFg1hryVWYgZpBjAOwbJDdjVGDp6YP8izz2PSrm9ZFdGOVi1WY?=
 =?us-ascii?Q?hFwAh+r/3PUKBbiJi0DnpyU90GqwT2SCo0hxZ2ppbTJM9cGUZdWfkfdKZxfw?=
 =?us-ascii?Q?zN1Wh87IzVd1Pb4OYxE2TzOxmlrB7hb2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?awq9QPPZ/nljTbyF8i6TKNH77eFZrASbCT3+bLqxmwhk0I34Y7dE6j0tln6T?=
 =?us-ascii?Q?f2OU7nZRHccACnJhCRN9B0ymT8VZh1Ygi8H7+jt4lOebShhPuXGYWLd+oP6Q?=
 =?us-ascii?Q?hRi0qNyJ1yQ4IYt/8CFSP5iGLn/Eg2bhtozgW8Zk6HAHFjNQ1HlfnPUKEuPP?=
 =?us-ascii?Q?wYk/WLbUoPsNecLCC74rtWSeUsIjQOPtQdf2/CptUs9tRL3REkG6N65WOilC?=
 =?us-ascii?Q?g7pmX/azjfHD058FoRQzfdXkgt8Dc7fnHuZx9/r22o+Y8iRDJH3yydfhHIkz?=
 =?us-ascii?Q?TlDlOAccWfiMxwOoidAHcjbG7PtsbDZMGWd+6dEcjlOaNTVn7FnXeOhvRjEr?=
 =?us-ascii?Q?wIaFpGHZ4hyg7nwt2Yu7oc7cs7IzgiI0qSy6nBhSY5kpI/yheQjUBrObY7WH?=
 =?us-ascii?Q?C2IpN7K0K1YFam/nvIskJAvW+dWvj7IpY4JsXAz3SnSjoZUOQhZ8TctTL9mk?=
 =?us-ascii?Q?b3BtCZWvDWHDlXfCYyjxHjFriMFOx1NrUww//9NH0kOk4POhCgqZnzkRdDAS?=
 =?us-ascii?Q?iWry/L2YfYrkYusRqeilh+wZ5Tn45+Kiw/xRN2cUJHwcX+CtgyGM8m+3xvgM?=
 =?us-ascii?Q?cGkLsnoE6co3SWV18dOkzWn9aEWwhq9CppOqaupYJDhN/KS9XvysOw2FCF6S?=
 =?us-ascii?Q?2KVdubRyHbOvn3KJ6Ah+b1EIVJ5ciFD6i/gek4DPY/oRoohnJlwjmMiGLNPY?=
 =?us-ascii?Q?lPl+Uo3m6Vt8AwBHTqR8b6OZU1521bZ1zT+EliL0ZsDxsylWA1KtLoxViwTe?=
 =?us-ascii?Q?EsBdTFWPoe9+czYjfopbEoH9BxlkmQv+1C5NUxEsg+aj6UE8sf3crp40iCmC?=
 =?us-ascii?Q?HXtFfxdx8TmcsIGU0h4h5vnRQFMtOoO1xB0LIGNjnz0f4D6gusm10PIEMc4M?=
 =?us-ascii?Q?ahir0NH3oZKLsnZi89gyJwwmhlqzAuDtnBu3Zv9nINQXuyQmfUBSKsXAsmBi?=
 =?us-ascii?Q?Wuwke6v0vmw0rVK/Q+adS80qWQFkA9G7IJOU1KRmTRzmL3f+aaGRKglKXMiq?=
 =?us-ascii?Q?MDIipfAVlsnNcDn+zms0VF+nrE8uF65OP1JmCqthJGie4FzQQB0XWgjFzhCQ?=
 =?us-ascii?Q?14FOZRRu/0lr7ceSAe781w+T7PlI86rVJzf7ryO94YKMmnRcSBoqUs3PgSaO?=
 =?us-ascii?Q?V7+75tkLjzdPMhbHrJPWb1TRoJOLyh6a+903HXdlznHPBcJN2kjxxRAh/kOw?=
 =?us-ascii?Q?pkAMMwLHCzCOMVth6QOx62KxkuVyk/yREegL3FZa7IATCCz4JROB2xVNwm8P?=
 =?us-ascii?Q?M+P+iQKneu6f7Q02h1//piUrFP+Rr1HT7fRG8BHBNEAa7NATNzRO9soWBLXS?=
 =?us-ascii?Q?gwptK21HNCLiHmHSr2TJDtU51kppDN/TqRlqqX4hAQBPHuHZIimXGGgCEpiY?=
 =?us-ascii?Q?yLTb8anoaovlSCZp8IDsCPrLEood7WkToz9y2Ch9e/7EJeQiVgJZrbfMq1aV?=
 =?us-ascii?Q?4k5l3tJ1ZaVxwPyNsJmUA+g3FcO3CmdN0MCFrABdaBzM4PtVYzBL8luT9n4Y?=
 =?us-ascii?Q?bxG9blAxHbYAWmGkpLZLBGDQHGl6YBf7oITrbxzu34B+7pLIPXqLB7+TfRjD?=
 =?us-ascii?Q?hHgQTLhWgJpzhC0JApZTdAQXnndfD98AL/q7F1Gkpgt66OLMiX+UfbLbsVPE?=
 =?us-ascii?Q?XA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ced7fa-4e8e-4393-9681-08dd2f74ea23
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 23:42:14.8944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tVF9pKl+3qk2lxD+3YJWW6CpmkscRLWMi81WndW0E/XNO+icPHWcZtFWaYTa65Glon1tXgYiQ9kVmyjy+G0U1m8sIxX+V+piPEja+xEIrIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8445
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Differentiate CXL memory expanders (type 3) from CXL device accelerators
> (type 2) with a new function for initializing cxl_dev_state.
> 
> Create accessors to cxl_dev_state to be used by accel drivers.
> 
> Based on previous work by Dan Williams [1]
> 
> Link: [1] https://lore.kernel.org/linux-cxl/168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com/
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>

This patch causes 
> ---
>  drivers/cxl/core/memdev.c | 51 +++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/pci.c    |  1 +
>  drivers/cxl/cxlpci.h      | 16 ------------
>  drivers/cxl/pci.c         | 13 +++++++---
>  include/cxl/cxl.h         | 21 ++++++++++++++++
>  include/cxl/pci.h         | 23 ++++++++++++++++++
>  6 files changed, 105 insertions(+), 20 deletions(-)
>  create mode 100644 include/cxl/cxl.h
>  create mode 100644 include/cxl/pci.h
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index ae3dfcbe8938..99f533caae1e 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -7,6 +7,7 @@
>  #include <linux/slab.h>
>  #include <linux/idr.h>
>  #include <linux/pci.h>
> +#include <cxl/cxl.h>
>  #include <cxlmem.h>
>  #include "trace.h"
>  #include "core.h"
> @@ -616,6 +617,25 @@ static void detach_memdev(struct work_struct *work)
>  
>  static struct lock_class_key cxl_memdev_key;
>  
> +struct cxl_dev_state *cxl_accel_state_create(struct device *dev)

Lets just call this cxl_dev_state_create and have cxl_memdev_state use
it internally for the truly common init functionality.

Move the cxlds->type setting to a passed in parameter as that appears to
be the only common init piece that needs to change to make this usable
by cxl_memdev_state_create().

That would also fix the missing initialization of these values the
cxl_memdev_state_create() currently handles:

        mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
        mds->ram_perf.qos_class = CXL_QOS_CLASS_INVALID;
        mds->pmem_perf.qos_class = CXL_QOS_CLASS_INVALID;

> +{
> +	struct cxl_dev_state *cxlds;
> +
> +	cxlds = kzalloc(sizeof(*cxlds), GFP_KERNEL);
> +	if (!cxlds)
> +		return ERR_PTR(-ENOMEM);
> +
> +	cxlds->dev = dev;
> +	cxlds->type = CXL_DEVTYPE_DEVMEM;
> +
> +	cxlds->dpa_res = DEFINE_RES_MEM_NAMED(0, 0, "dpa");
> +	cxlds->ram_res = DEFINE_RES_MEM_NAMED(0, 0, "ram");
> +	cxlds->pmem_res = DEFINE_RES_MEM_NAMED(0, 0, "pmem");
> +
> +	return cxlds;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_accel_state_create, "CXL");

So, this is the only new function I would expect in this patch based on
the changelog...

> +
>  static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>  					   const struct file_operations *fops)
>  {
> @@ -693,6 +713,37 @@ static int cxl_memdev_open(struct inode *inode, struct file *file)
>  	return 0;
>  }
>  
> +void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec)
> +{
> +	cxlds->cxl_dvsec = dvsec;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_set_dvsec, "CXL");
> +
> +void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial)
> +{
> +	cxlds->serial = serial;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_set_serial, "CXL");

What are these doing in this patch? Why are new exports needed for such
trivial functions? If they are common values to move to init time I would
just make them common argument to cxl_dev_state_create().

> +
> +int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,

Additionally, why does this take a 'struct resource' rather than a 'struct resource *'?

> +		     enum cxl_resource type)
> +{
> +	switch (type) {
> +	case CXL_RES_DPA:
> +		cxlds->dpa_res = res;
> +		return 0;
> +	case CXL_RES_RAM:
> +		cxlds->ram_res = res;
> +		return 0;
> +	case CXL_RES_PMEM:
> +		cxlds->pmem_res = res;
> +		return 0;

This appears to misunderstand the relationship between these resources.
dpa_res is the overall device internal DPA address space resource tree.
ram_res and pmem_res are shortcuts to get to the volatile and pmem
partitions of the dpa space. I can imagine it would ever be desirable to
trust the caller to fully initialize all the values of the resource,
especially 'parent', 'sibling', and 'child' which should only be touched
under the resource lock in the common case.

