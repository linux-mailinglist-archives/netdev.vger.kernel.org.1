Return-Path: <netdev+bounces-108139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C01091DFE8
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 14:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBED31F21EB8
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 12:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71656158DAC;
	Mon,  1 Jul 2024 12:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l0Za7lnF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8F5145B09;
	Mon,  1 Jul 2024 12:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719838353; cv=fail; b=jBq8dxLh+DkPNIarWbE8LaJQDRi722jruj4+EgMr3yxZFyH87hJFIS8R4eMDCZQuSS2/dv4HLkQaxZmqcp5MbsG8Ab4GyNn8w7d1+JYV9mal03Yn+AQr/JPil1Qv5ZlMNZ9Q9K4Xq+ViLLW3H428ZrdSaA6NOM1O/bGmo586lAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719838353; c=relaxed/simple;
	bh=UxItILRvNMaEcBt8xSoDcrNBOOdsGBVCT99otAUNXsY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gXSWdXPwEQk0ORRcGOU3GEDepu3iROilSXMbWXxNduEzUI9n9tYCKRFS4thvMkyECTQsXgi8iJKVIImkp5J9X/i3mfhpy6xKJIB3Z2lv9IK7i9UtLe1KykeB5aQL3Bqb82QqpvCPlg2fmP2/zSkOTGtockODzwd07oRv8za7Xg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l0Za7lnF; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719838352; x=1751374352;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UxItILRvNMaEcBt8xSoDcrNBOOdsGBVCT99otAUNXsY=;
  b=l0Za7lnFiHJzoasR5yWS42A4cQo+D/01v1Uee2EWPb0AnLruDcGYCtdh
   fDzwSMkhlx5foLne98tjYvoWo4+WUPnA69HLHW50X3vwop2E5lYnTyDGb
   rPJOnG6ef6iRItl7JAv3wPpimV6VGq//C2Rw6sA+wiPTyqjZCDEWXaKG9
   WZiBRLvIMvneua46PCB5CPTBoR6XWoyiRFQgzE35vElmhgMD4hHeqSZQM
   Gv9IHw+aZTJJSVp3JBmyGJhVQxNFhUzeoFLF2+lZuG9Oq89OAJO6Uz/C1
   y7bnAFecSPc4/pWOekFFFY9shVUB3jg/wof2B/gKKNaZqDZsFENKKPwQR
   w==;
X-CSE-ConnectionGUID: UW6KmWeiSt6OP2fRKEIEsw==
X-CSE-MsgGUID: dZ5Z1BQuRdGojLqneX5I9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="34407781"
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="34407781"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 05:52:29 -0700
X-CSE-ConnectionGUID: t30KhTkFQrqTq7nScf8RcA==
X-CSE-MsgGUID: A5Ay0c4USSu597TKO62PTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="45407201"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Jul 2024 05:52:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 1 Jul 2024 05:52:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 1 Jul 2024 05:52:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 1 Jul 2024 05:52:27 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 1 Jul 2024 05:52:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ji204jTtf3dhC4SrEal2ci/bSZF2dCx88KlQfR5efGUxqUl0xhJb1u2uH4ZZ+4kafkMQIb9SBWR8TDB0vht89CA1hEi8PkSBxfRnRyjrk5YbLw6PO3edMZLEqNHVsjxRC4TU8IFGxjdX8Rj03RkbPokEi4KwJne3sF810ZfENA2U0DvR9cq782b70SxzrBCXLAG9DOGBIEfo/tE9VibvuPqDxv06a5/kGwFJole5ay4L5M9oMcNfryfjiWqsHzL69jAfzN+DFTzHcv9+IgalTY+zgNQefxh+NPlxies13eGI0cMgZ8ONSb5xURqollgA9C2x3Y1oHhTnPDBL6HHzuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GEe2VFjJLKF8x/dm9jX68fgewAo+6ud+3X1tHLtFAIA=;
 b=nng6B7miu7b6abxzlRK0k4BYBNCzyrNqQYdro4IhNK1o5dpMhlREa7FcZDNW8JbdVXstlQjMPaURTncdBYn7JlFZE+nUvdIzCDXvEMM1Mkn/89XT0mYf59r7NDEhGsdrgCW2GKoTxvnSPqihtAP7oySpRIOf5M5HtXklBy1DoFi1Lip8KYB97yzb4r6qSP1dh78KJBTrGrIVmlfVKaDWVDEJBuadZdZ4JNDhd1Qf0nJDB91xdrs5ZRngLiTQ3ONX/KlqE8NgSZHEeaa7VUkzUHr4QOtGvo9GMJ05muRMSP5R9jsE2wwAcCJCrspdsUprdlcpX+cOsAI16ZaWSfUbrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by SA0PR11MB4672.namprd11.prod.outlook.com (2603:10b6:806:96::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 12:52:24 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01%7]) with mapi id 15.20.7698.038; Mon, 1 Jul 2024
 12:52:24 +0000
Date: Mon, 1 Jul 2024 14:52:12 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Liu Jing <liujing@cmss.chinamobile.com>
CC: <edumazet@google.com>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net/ulp: remove unnecessary assignment in
 tcp_register_ulp
Message-ID: <ZoKmdGBqK7pN8vUJ@localhost.localdomain>
References: <20240701114240.7020-1-liujing@cmss.chinamobile.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240701114240.7020-1-liujing@cmss.chinamobile.com>
X-ClientProxiedBy: MI1P293CA0001.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::8)
 To PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|SA0PR11MB4672:EE_
X-MS-Office365-Filtering-Correlation-Id: 074791da-a403-42c8-ff29-08dc99cca7c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MMScmigU3g4aUffZU8zq/cbiyuvKqPG6l7WMZBcI6ogNWE5VvXcVxZ8nowrh?=
 =?us-ascii?Q?7/jA2snz2AmGErs0fomNMqTb7QbpmkxMI3akaUQcewXPsWuqY5h34LLtXXwR?=
 =?us-ascii?Q?SbnCzMNsxaBCIOw1Tme25TiO/Ql+hbdJwhMZJeWGc77uS1Lzsl2X8rpxFdSD?=
 =?us-ascii?Q?LGf0thNwz1FqhJKhpaE7pbf6H6sJv4tlzrcGWBK4Y75zwj6wBl1uAi5pihpJ?=
 =?us-ascii?Q?5+VF5YizvZs3J16dvwOwjcvByV0KkpgrLKVQAC4dMVJ/SlA1pn2F+AJWM/Zc?=
 =?us-ascii?Q?FF/pFIhU/SCdM9Dp8gZf55pIxP4pjV8XsbO5CcC4ZKveIEzExrhHJeSK4FgW?=
 =?us-ascii?Q?k8q/ZaE2KHH5Xp2tQMVrFuRxApsl6/zkiQUHjFdHsdP9yIZ3u+YCoNZyFwvg?=
 =?us-ascii?Q?AZmf4sdG5cs7Q+cga+7XpPjMIWGdLp5mn0SeKK6J44bjfmRi2U1DNBMeqigZ?=
 =?us-ascii?Q?+3omwvkwV27Kq2yBTaRi9RiBzlMFXQKT9MHFDd3kNwn1aLmQbZ4Yg1i5bjNi?=
 =?us-ascii?Q?lHEOwJRzHjrr8BzCWf+/6I8jJT60cVyPF05eDCwx7P/+wxW3kGhYFRy+WZNs?=
 =?us-ascii?Q?4NMOd3/atjSHJLr0Ew5PPHO07BCIcCPSgdztEMD9bue89LPWl+GYCS47WAix?=
 =?us-ascii?Q?qjZ8s39AoBQ21JvHEBpi4wsEjUN3YkMLND96sDxtdccTol9OwgE7LzirO734?=
 =?us-ascii?Q?IGbVw/8sjY3GUMblnMEh3GQWZ592rxPOdTW2hcI9pGZqdG6e5DxcnP7+sNlv?=
 =?us-ascii?Q?iQFdP/BWlI9+OllqOOymgxQgL2a3F++oLs/AjVcygFxejvLR/WsiW3QnFMYy?=
 =?us-ascii?Q?/zQhYNbfwuQzc1cMidQC9Xe5is6d96odqYISx1HBL8CoPXEL5nSSIGmoP591?=
 =?us-ascii?Q?awYUjPb0BWtbtv1XsvIwhz6YKh5Z4p/+JROMZmzQHIqWp5EoaHJgFRgR6RDF?=
 =?us-ascii?Q?Nkl1zjExI2wd/o2j+ed4d1WqGcP5yWwRizYv4Frs+X19Qm/ZiWAkGyRSjHWQ?=
 =?us-ascii?Q?MiU17kgCE66TiGQeUnJ23U0qyayTfaXRt0gWlpWTYJtSNj2oYBpY2T0iky8x?=
 =?us-ascii?Q?simNvr0epGgcbvDgYbDRwAlWZUeUG863gQXmhQeVNJYwotjmQFXibQMuYJL1?=
 =?us-ascii?Q?XhQ2gNyKxP42biWFeb/IsZA/f5Pl8/hiLwpcXwer+cWQ2NYK98MB6UB00wAN?=
 =?us-ascii?Q?NBUnTWVrk1qcsvzKsJNjPjwCtXnCZjxof1XIf3QeCdNMN0HuZCYmF/daZRx/?=
 =?us-ascii?Q?M41hH8m6CDSoH2j031XO4CJNQGMiJCCPLam4a0b7A+m0PzQAdgg18A8YXD3S?=
 =?us-ascii?Q?8UVvrXepw4XEaQm7CnYEbig+0+tH26LgaH5rpy1v5BpKwA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+ZDDmYPN63QLOAsOf7i/l602WUUkHS3iffWiv7RZqiAYDWFjFKVgOpxDWxFS?=
 =?us-ascii?Q?RQHlWcGKhgaP0fB0akP5krSFUnKqc8YOwNnpqR2Wf8ElDYxLMKu8euVqXjWq?=
 =?us-ascii?Q?tFZFhwjdEJRgmQBX9RZE1/FUk9gnsLSKiwH7x0IO/ONKO1UK3Av8g/OYkRv1?=
 =?us-ascii?Q?HxmqAX5p/fvAE3JS5Y6+ClmOlJdSQ4Vn+pHccr30VhskNrOUYaIa1cPmE76+?=
 =?us-ascii?Q?ZvcOOKvxV7raCtLyC7eAsPTAfFbZxzSf1U4gCztfjfhD17SygnKAASfVBkKR?=
 =?us-ascii?Q?l2MQtjMARRtssySU78/sehluUlmexaEyeGEGJXbVTfTNm6fejBZtdhllRhHU?=
 =?us-ascii?Q?zwbegdObimIrQiG8asq+hlpoIHXCTdphyx3ViwybBc+8CyMM3il8B1xlTE71?=
 =?us-ascii?Q?1/2WrUPJ+2Rkl3c8KJvk7Ti1kCPbvqoYESq+BGShxpu0guGo8k/PwuXhxceU?=
 =?us-ascii?Q?vbEUXlESu+4t+XPGN5n/aTdRn7mdpjKtTnJe44v6GoF/qMQm34eYB5/xdROd?=
 =?us-ascii?Q?qMtqB9GI/l1qxHdNKo2Bpt2nURamjONQa5uI/qo1YU9Li6UPWnrrWVlzCIkt?=
 =?us-ascii?Q?pAYydMLJSm08zSf/mYczYDwZEW5RHL0fP9FiJ7xJHeBydvcKzn86QGfpPOlp?=
 =?us-ascii?Q?YUjuVlxvv30VeWK7KXJx162zkvCo1SemKK02IaQ0YFyuOtYDBRabvk3KgAMH?=
 =?us-ascii?Q?F7lTIVfW8rz2tpe1RUqjKzdpLhoJBLkJ0mN34hq0kSi857N5hsh7EwWGjtaO?=
 =?us-ascii?Q?78tBRxrBAKTJTd3PoYgOCriZ1odh5BkZSwWPZOzMTU89l/eTyWle9DczzR7S?=
 =?us-ascii?Q?BNEJovE1+oEDu2murQlUkVZKo2d/eIr1daoGuvm3LJNwiBg/z4wrZpBMrW6Q?=
 =?us-ascii?Q?FLCVGo5AtGnGurxjgAja1x/tFyAV+p4zCcgQKjjifBbh7mBhlNZN3xJcw0fG?=
 =?us-ascii?Q?VCqrMcx2nn511xNVeDC0/WFb9q+LuCG5+vI4nQWCNxOLY6LzFZ+MeLKmnR9h?=
 =?us-ascii?Q?6rfQqLdYg/HgnM6wQlVdM7sx5K8j8eZ1y/dx1i04IRJKHi1bXwyArvHKWQYd?=
 =?us-ascii?Q?POFmy15UmYqBCQmfEMgrfHbUg+hFiC1kFv1dsbB05tRv+OJro85Dw2bkrrbn?=
 =?us-ascii?Q?yKYF79Npe+QrajRI3zFkbudCrm8QErQn/1dJ+PDd7hyKEgoXkBucZ7IAFz9p?=
 =?us-ascii?Q?J7FxAQqvUClaPVZbpCo6N9yJiIhYB1BZJFtq/5x2jqjuOKfG3RI9FLpoxmFF?=
 =?us-ascii?Q?RxmvqfqTJ0L+OLVib5wAP2MlQXMtNFHJG/Ax+gfgFuZJo53KPuhCxU35bX9q?=
 =?us-ascii?Q?oa7xPFvBl7GU+VcQDEGFfZ6e5MjtA8DEKC2trHAoXHyYv4uC76YzaSlWzCyR?=
 =?us-ascii?Q?5z28Pgf38NwJ21Y5AcqtoFMtrZGbwcnB+K8wvPVzjE3RmD7yVk2/CfQJ7KEq?=
 =?us-ascii?Q?8WQU9oDe+mTP+4uaXqXMW3pMmuEI3hWlhPeWFmaq03JWNlnR+e3XHZDW8eZk?=
 =?us-ascii?Q?9qsppPzi2jcu+O2IzVOL9fP6E/CA8iqoe7g03aB0P8X4+dBfRH/8M5cGrORO?=
 =?us-ascii?Q?XPdtxAsEacnNnhBltiUz7XT6pSQ+jqUfnnJtM6w3CZ+OkMtfpbKDgMSEFS6i?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 074791da-a403-42c8-ff29-08dc99cca7c3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 12:52:24.7713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0oRaogRGLiewQBHH5rFDXwnuRRw84XkOf8ye8dYGvRm4L/L1+2W/17IHfRaawc/YN6iQRDHg+V4U5BabhC6ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4672
X-OriginatorOrg: intel.com

On Mon, Jul 01, 2024 at 07:42:40PM +0800, Liu Jing wrote:
> in the tcp_register_ulp function, the initialized value of 'ret' is unused,
> because it will be assigned a value by the -EEXIST.thus remove it.
> 
> Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
> ---
>  net/ipv4/tcp_ulp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/tcp_ulp.c b/net/ipv4/tcp_ulp.c
> index 2aa442128630..d11bde357e48 100644
> --- a/net/ipv4/tcp_ulp.c
> +++ b/net/ipv4/tcp_ulp.c
> @@ -58,7 +58,7 @@ static const struct tcp_ulp_ops *__tcp_ulp_find_autoload(const char *name)
>   */
>  int tcp_register_ulp(struct tcp_ulp_ops *ulp)
>  {
> -	int ret = 0;
> +	int ret;
>  
>  	spin_lock(&tcp_ulp_list_lock);
>  	if (tcp_ulp_find(ulp->name))
> -- 
> 2.33.0
> 
> 

As far as I understand the implementation of 'tcp_register_ulp', the only
case when -EEXIST value will be assigned to 'ret' is when
'tcp_ulp_find()' returns true.
In all other cases the return value should be zero.

According to my understanding, uninitialized return value has been
introduced in this patch which is not correct.

Thanks,
Nacked-by: Michal Kubiak <michal.kubiak@intel.com>

