Return-Path: <netdev+bounces-269967-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Fj0NVVtvWl49wIAu9opvQ
	(envelope-from <netdev+bounces-269967-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 16:52:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 340D52DCEB9
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 16:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F3F4304C4A1
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C763B8D7F;
	Fri, 20 Mar 2026 15:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jeurXLQA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B93F3B3887;
	Fri, 20 Mar 2026 15:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774021889; cv=fail; b=d6b2dpIuwpmbzAv9vntValSjO6Q6c4FF/wTOmb+V7a6sOzeBNwLfsWJqK/rGwd5VrlSNu75vbg8UVvAXYRmWdw0qPFzSy23fs1pgVK6eFjJdZTTX0kVS6Ens5vpn5xw0osTZwU0kVmbriFJujvb1WubzkWbiG+beYx6fPfJmEPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774021889; c=relaxed/simple;
	bh=AXIsr8hqZI7tzSUvLwqnAJOX2nFLVoY9xRzTUdkbrR4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PrX6V+hLQ0nUIKk3Kwpdcyzgw+4EEMG/beqxhesSy8mi+6Bq/aMeNPR+yC0odYVnLKoLptMrGM0VXDxXBeaRvWQQtwmyzYUVhUapoJhirkr8rFkV+6OInmISd2VgMltLoecTdeAl3lVk2qkhYgaejQDwdSqA0h3MDl53bUP4gWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jeurXLQA; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774021887; x=1805557887;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=AXIsr8hqZI7tzSUvLwqnAJOX2nFLVoY9xRzTUdkbrR4=;
  b=jeurXLQAVs1HKvlA6fqSFXHb3mjJxYI3Ty1WoTgsO+sybxfFWsfZZvGA
   sltlML+A5XsK/14WeqPP2UGHnvHsHkJESEz0rONYaaUvQTae4zP5bsb+E
   yQKT6PAZtXAwXlIkGRRsRG5cDl6ki5rXv0CHNR5vfKckONCj+zM3x5Lo2
   PgQPnSSnqOkCGyt2YaLf09p8XLBJ5Pj8bZNcOieR/YSwQw8YDSK+NAaXd
   VWQwl3H7/zX6Z6SweyJheJLoXCARcF8aW9K9W/vqqr9VzgUnD3zo6v5lJ
   3F45fXFmhIepTXOOb+l5X8hupyl6nFH1s6jG26YuaFDRDn68+TU1yiR7r
   A==;
X-CSE-ConnectionGUID: 4ALNg2GOTxW3ht8vj3o+1w==
X-CSE-MsgGUID: +0YFv1OMRm6Vujq4TFVtKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="100563565"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="100563565"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 08:51:27 -0700
X-CSE-ConnectionGUID: zrltfJxiTDiT7PSDKT6rTA==
X-CSE-MsgGUID: r8FqTpInQ5SXa3qEYH7Djw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="220655879"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 08:51:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 08:51:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 20 Mar 2026 08:51:26 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.25) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 08:51:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lk4DT7vLNqHWP4mIXF1UJQQpaaJ3rL4OX50JCP1OyW9+IvVFcR4zrbYvj73Qh/zoXuPB+1wuiXUZtdA1mnVdpOvJvBxYTq1qpNqY/OCohYlBphySBA6dPu9Qlu2ofvs9/tpsLbN2aNE/439MSVj7scoPRGjhADJ3c0rwTCg+AJp0Nvu/wyuKd9mQveXz122AJFVC1/UGfug5bv3/SKoLH8GCBcd2ZnAE8oTQtmKXbtXCMfD6HPehZMGocrQ0+X6AWK1pgn5So0XwxkyaUsi+JsA5EpCsbIR3pXdTpW1U8khEEP21/XPfRaF0G0q1Ia1g4u/rJZTNKS8vcv+o7O3YZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1B9PsoROfvkoWwhC+tzP+ToyjGSeNh65u7yfu8bR8Og=;
 b=HL01LZ0+uTnNiNL+VEDTkOFQZgxyJHVggvVn4iRE14dAmXtFdLzSW4v0pdQCNJqvgXF6UXTd04ZBBanxZF8ws1XHMlCz+mmOQmNLZteuM9XeOFTEyNnRbVdjMFz0rIwrEi5VW0zHGab3Ai2VsHtBH4SEIYQIL2e9Mf3TC34phGkMHKg/eyhaZBlB1FBoVwpro6kFizxuK4rsnpKtd/kYrRqQvfrSJg1VI6mVxBomBWro+lAd76h8lIQehMDfE88lOW+r2LvouCfiY0KBBgrB3wfNGsgpmp25738Fhdf1LHXF+6fSHcYe2hby6lHneaZMZ0dDI+fxxWb1xB2UyD6nqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA1PR11MB6920.namprd11.prod.outlook.com (2603:10b6:806:2bb::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.10; Fri, 20 Mar 2026 15:51:23 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.20.9745.012; Fri, 20 Mar 2026
 15:51:22 +0000
Date: Fri, 20 Mar 2026 16:51:16 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <larysa.zaremba@intel.com>,
	<aleksander.lobakin@intel.com>
Subject: Re: [PATCH v2 net 5/8] xsk: validate MTU against usable frame size
 on bind
Message-ID: <ab1s9J5yGxCbqB28@boxer>
References: <20260319175538.479139-1-maciej.fijalkowski@intel.com>
 <20260319175538.479139-6-maciej.fijalkowski@intel.com>
 <87qzpeopzr.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87qzpeopzr.fsf@all.your.base.are.belong.to.us>
X-ClientProxiedBy: VI1PR07CA0212.eurprd07.prod.outlook.com
 (2603:10a6:802:58::15) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA1PR11MB6920:EE_
X-MS-Office365-Filtering-Correlation-Id: 109968e5-13e4-4b44-31ca-08de86988922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: EB2sJYZkdk6kxHdglz/z7tRgbkstrzh4Wl0sfCm5JgKwhszXSB4gZSP/qF4me/d7RkDPSVYMo2v0eS01zyAjvxVnIOoCqYqtJcPIOxDy7lDm6KwmgxX2PsYKHHaIZHJ9Tsk1fanAIY6/P8uUNO9DrVC7wmcWWj0CBp/2kEfN2DBbdGNzwhcFSlQXGFThPh1yjnfsWtvhSIrfRxE/gdPcLFwHrprkJmj6rk7vjymwJM4mAYreTCvWR97BodltGrl34S3GpBv0B9cr2pGe80WGqD7HNY2eo31i/BmJ2HRgRFM2crAXHYFisIv7t3OBKewcyOtJnGQD0eJGlOX/YK4qZvUguNZOvVV/FxZ3Lx/XBbtY9iS4g493cAz1X1F9ngCV/d9XoLmrh0HtM6uHFatvV2kUl0dg9iPK4Ns2wctil1XF7JEMiN0FxsmyxU/hp3BE2bld3G45YGmoiDn3OOlqZTbGCHKqpmRyoBbFnTMtMm1bWpW2oNFPClMr9r9LXows/gYoAWLx8WxkS5ljsnPnEXxrZ5x1y4Bw1IbFXYJ3USyUgiCOClmKV25qI4XvpEHzrj4rDoDA15SdIm7PU0VqFT5GZ/NoL06EQAllqyoiDih6DRyVBOI71TXdUJXsOejuQTu2A96OYUzeVdLAY4oSZ45IM6daNwO+wiKDp+XddReu+NrYyDBSLabr0I43TUVWPOUqfGyJzeF4Fim+XkvZlRf9KVbcyg1MzkDoSLcEVck=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?EL91fIrYu+0o6jP3I6bx2tjRM0qQ44gD//oQpNXP4Jzfcie9d3vnIL7gsu?=
 =?iso-8859-1?Q?JmXOY7SjxGQgjKpzSDMcIWwdOOpe5hjaCazCORee+7HdkrBkvfyu1WgBS8?=
 =?iso-8859-1?Q?bCGPvTLBAmEu8blPhj6/cOvBI/69deS2AJqNyrTmMDIeB4mdVqu9KLEadK?=
 =?iso-8859-1?Q?SuwTEtWyRwzrJap8szxFfdX3wf2x0lNb7im66juNAly6k9Mzl8LtT5Tjkb?=
 =?iso-8859-1?Q?gIMNzORhiLVUqfqgYmL2n9YZuHt+5Z1w1WTVli6EAvpuJQUlD1+UeiwUGu?=
 =?iso-8859-1?Q?UHvKcHMsYrgc1vQN+VxD+vNxBkhv+GQqsWX8lsY3jKOyJr8mDtgVzJXwTu?=
 =?iso-8859-1?Q?IblLGYI5QkFa0IhziEGEJ0CFbmviuC7/m06/50HnJPA+T04Fa3N39oDSoy?=
 =?iso-8859-1?Q?3hPM5Ymp5jAbVCM498lBRP/NAejVbOBk/t9rGVe/Nv3WJldlfjVopR+jch?=
 =?iso-8859-1?Q?/6o7PGnHI3l4tV9pc27yIoA/Bsh+sElX2YWGin/j7Q09MytMcq1zi45rQ6?=
 =?iso-8859-1?Q?v2BYISOhdgwm61hirDVXurwT+E+KMJgWZsABbfsVK5sgUu/1Govv1Avgb6?=
 =?iso-8859-1?Q?ulVBk+V3wudHKhtkg5mj1QZXM81ckP6afYZmFQrR6AHu1K7qm2+fIVNvRu?=
 =?iso-8859-1?Q?3B5yGSC82b2omYGe0t3EGoVdRySrvYwvxnrZ3tHeAsY3uDTIdof+58ev/z?=
 =?iso-8859-1?Q?XoS/kLul3ctd/fAv6AE2/fg8O7CQOYgH4NawhHCuoUtlIh1XMcVpgVVN5W?=
 =?iso-8859-1?Q?DpPhtFpzfefcpP5Lmei59AcVf6rm5btwEcHLgXfvkYf1coxGOXKQjbXOxG?=
 =?iso-8859-1?Q?JFVl6RgObnjFsy7RIgW3hzvjcIor75gK9AHt+I29mrrk7NHKCD4dz9/Vhk?=
 =?iso-8859-1?Q?iokeX7T49UymgcI1p7rRAq58BxR4I82a4BVSoAn+7qRVeDL15afPfJvX+e?=
 =?iso-8859-1?Q?ctmRys4XQ7wa032TF13tdeffeBB6YnO5WIPy/JPg2U+UGh28/229s57K1K?=
 =?iso-8859-1?Q?J1/H3erKssOxO7JtELwd6iGrE0fysUinpQdv6BW3y+ZvwOS8oN8ERXMpZP?=
 =?iso-8859-1?Q?UuWUgriitun00Fs06sIMiyyzJpGGRyhA4cY8jX0IAq7vyC6ZxfkdaWljDR?=
 =?iso-8859-1?Q?vNiA34PYb1k8VxVy2JMOc0Kqv2u/3KrmKmgrVshZxUt4GIiOQ3gTsEIoRc?=
 =?iso-8859-1?Q?dH9hvLc88eHaNTNWfokn/xDHjMdr7ngkTBNgsdDSDez3bdRbtbQyledF0B?=
 =?iso-8859-1?Q?3+AeNEd46fqqJn20P8N9PZ0OSG9kKzQKJ3Ll7jScrGHusAemmt1JMDOf9A?=
 =?iso-8859-1?Q?dPL8g3W4TS4x2FfW/mL5ITIgMqDmOTlG/i2dB9Ies/5pVaKNyWYRtDIItA?=
 =?iso-8859-1?Q?yWll6sI2uEP0EJlyBVwD8sJxxuEEbSwXbjdASdeQG0CeDeK2Be1miwXFG/?=
 =?iso-8859-1?Q?gGHJewkyya3PU2lwZQz3Mzmji3Wq4rw433LHrsZvYVwiFYsWenJvxH45jt?=
 =?iso-8859-1?Q?4LyeoluzL9mltd+pUCcb7+aBtQ7uPzU8Oie7xFXg/x82hZz9Pd79zIl8F5?=
 =?iso-8859-1?Q?LEQb/Zbw1doxa43eMJcAq+QU/EMMFXiqW1m7RMJXe710mD1gmUWYLnDmgU?=
 =?iso-8859-1?Q?r9WC+U1kQ0QDsPQYsDqa+uGAAUMUfVfRqs+4PhK+G3ii7Ds+UkwMXV/PYb?=
 =?iso-8859-1?Q?vAdR6fyVkh3vmr4J1SQCq0IltHYSfcsYopCsB4y1BS3Yi6U4OgLEs/d9qL?=
 =?iso-8859-1?Q?cBMhbtZYF39nktciUfd9YEL3ivFA8YhIRHbcUghGe+aL2gvXorMNSB4tlW?=
 =?iso-8859-1?Q?1pOZp8ffMADa8qBRMvY1xJxYcEvd4ro=3D?=
X-Exchange-RoutingPolicyChecked: thus2S28bH1/lpfu+3ojZ8G6/b1CUWn4P0sC6t/QcpewrOxTnxo1dlC99cJ4Y8xogFoIB9wVmzDorNlHSps0BI6eUjCrJ9X4zOl37kWMda2s9wnKY/vX9rsgBw9K1eR2Rc7r/IUeNlXf2wyLxx1yH107ZIyr6Tjua/hQDdptulJVjk1cSDKJ7eBPnUoobqvWfEEjbHhUQutcFXP1i/Dz5B4otF4l+oDorVO6v/QBx8cD35LTpbQW6ZOIyxxlgIgC92GDy3qTlCkijbvJgQXJGz46JkV4rm1num1Bw70FTVXkUemZCng1uDzxO5EMPFsTgZmv/r07xifn+9+qZ61txg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 109968e5-13e4-4b44-31ca-08de86988922
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 15:51:22.8444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lhDaKhAE0icCQzUUCdbrOuWxr3OUwpR00PS9SUlz6y+jyq/DDeOoD8R+KjtpVkxCIl+SxZwWu9DC+I8z6YQuzmeUzugwaE8xuGmpIVBP/yc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6920
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-269967-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email];
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
	NEURAL_HAM(-0.00)[-0.983];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 340D52DCEB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 09:38:00AM +0100, Björn Töpel wrote:
> Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:
> 
> > AF_XDP bind currently accepts zero-copy pool configurations without
> > verifying that the device MTU fits into the usable frame space provided
> > by the UMEM chunk.
> >
> > This becomes a problem since we started to respect tailroom which is
> > subtracted from chunk_size (among with headroom). 2k chunk size might
> > not provide enough space for standard 1500 MTU, so let us catch such
> > settings at bind time.
> >
> > This prevents creating an already-invalid setup and complements the
> > MTU change restriction for devices with an attached XSK pool.
> >
> > Currently xp_assign_dev_shared() is missing XDP_USE_SG being propagated
> > to flags so set it in order to preserve mtu check that is supposed to be
> > done only when no multi-buffer setup is in picture.
> >
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> Fixes tag?

My reasoning was that since this came up due to respecting tailroom I went
with no fixes tag, but missing mbuf flag setting for shared umem was an
existing bug, so we could pick something now.

> 
> This got me thinking; Nothing in the xsk core prevents MTU from being
> changes while xsk is runing? Some drivers do! Not for this patch, but
> maybe xsk should listen to MTU notifiers?

Nice, I had exact patch locally, attaching at the bottom [0].
However I withdrew it as this would yield a rework on xskxceiver - test
suite actually changes MTU while keeping XSK resources alive.

We can get back to this idea but I didn't want to stir up the pot too much
in this set.

> 
> Seems like we're in a bind-time TOCTOU gap...
> 
> > ---
> >  net/xdp/xsk_buff_pool.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> > index 37b7a68b89b3..e9377b05118b 100644
> > --- a/net/xdp/xsk_buff_pool.c
> > +++ b/net/xdp/xsk_buff_pool.c
> > @@ -157,6 +157,7 @@ static void xp_disable_drv_zc(struct xsk_buff_pool *pool)
> >  int xp_assign_dev(struct xsk_buff_pool *pool,
> >  		  struct net_device *netdev, u16 queue_id, u16 flags)
> >  {
> > +	bool mbuf = flags & XDP_USE_SG;
> >  	bool force_zc, force_copy;
> >  	struct netdev_bpf bpf;
> >  	int err = 0;
> > @@ -178,7 +179,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
> >  	if (err)
> >  		return err;
> >  
> > -	if (flags & XDP_USE_SG)
> > +	if (mbuf)
> >  		pool->umem->flags |= XDP_UMEM_SG_FLAG;
> >  
> >  	if (flags & XDP_USE_NEED_WAKEUP)
> > @@ -200,10 +201,18 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
> >  		goto err_unreg_pool;
> >  	}
> >  
> > -	if (netdev->xdp_zc_max_segs == 1 && (flags & XDP_USE_SG)) {
> > +	if (netdev->xdp_zc_max_segs == 1 && mbuf) {
> >  		err = -EOPNOTSUPP;
> >  		goto err_unreg_pool;
> >  	}
> > +#define ETH_PAD_LEN (ETH_HLEN + 2 * VLAN_HLEN  + ETH_FCS_LEN)
> 
> Yuk! Move this somewhere else.
> 
> > +	if (!mbuf) {
> > +		if (READ_ONCE(netdev->mtu) +  ETH_PAD_LEN >
> 
> I think READ_ONCE sends wrong signal to readers. We're in an
> ASSERT_RTNL() region.

Good point!

> 
> > +		    xsk_pool_get_rx_frame_size(pool)) {
> > +			err = -EINVAL;
> > +			goto err_unreg_pool;
> > +		}
> > +	}
> >  
> >  	if (dev_get_min_mp_channel_count(netdev)) {
> >  		err = -EBUSY;
> > @@ -247,6 +256,9 @@ int xp_assign_dev_shared(struct xsk_buff_pool *pool, struct xdp_sock *umem_xs,
> >  	struct xdp_umem *umem = umem_xs->umem;
> >  
> >  	flags = umem->zc ? XDP_ZEROCOPY : XDP_COPY;
> > +	if (umem->flags & XDP_UMEM_SG_FLAG)
> > +		flags |= XDP_USE_SG;
> > +
> >  	if (umem_xs->pool->uses_need_wakeup)
> >  		flags |= XDP_USE_NEED_WAKEUP;
> >  
> > -- 
> > 2.43.0

[0]:
Subject: [PATCH net 4/5] xsk: forbid MTU changes while an XSK pool is attached

AF_XDP pool setup depends on the netdev configuration that is in effect
at bind time.

In particular, the usable frame size seen by zero-copy drivers is
derived from the UMEM chunk layout. Changing MTU after a pool has been
attached can invalidate that setup and leave the device and pool with
incompatible packet geometry.

Reject NETDEV_PRECHANGEMTU when an XSK pool is attached to the device.
This keeps the policy in the AF_XDP code, avoids touching individual
ndo_change_mtu() implementations, and stops the MTU change before the
driver callback is reached.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 net/xdp/xsk.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index e6530996053b..73cbd5774031 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1790,6 +1790,18 @@ static int xsk_mmap(struct file *file, struct socket *sock,
 	return remap_vmalloc_range(vma, q->ring, 0);
 }
 
+static bool xsk_dev_has_pool(struct net_device *dev)
+{
+	u32 i, n;
+
+	n = max_t(u32, dev->real_num_rx_queues, dev->real_num_tx_queues);
+	for (i = 0; i < n; i++)
+		if (xsk_get_pool_from_qid(dev, i))
+			return true;
+
+	return false;
+}
+
 static int xsk_notifier(struct notifier_block *this,
 			unsigned long msg, void *ptr)
 {
@@ -1798,6 +1810,11 @@ static int xsk_notifier(struct notifier_block *this,
 	struct sock *sk;
 
 	switch (msg) {
+	case NETDEV_PRECHANGEMTU:
+		if (xsk_dev_has_pool(dev))
+			return notifier_from_errno(-EBUSY);
+		break;
+
 	case NETDEV_UNREGISTER:
 		mutex_lock(&net->xdp.lock);
 		sk_for_each(sk, &net->xdp.list) {
-- 
2.43.0


