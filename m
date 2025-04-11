Return-Path: <netdev+bounces-181651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA62A85FBA
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 15:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE4463B9A88
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 13:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02621953A1;
	Fri, 11 Apr 2025 13:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SfRvqQTu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9482D1C3BEB
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 13:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744379364; cv=fail; b=KG4spDAko/cq/SUu/xocEHjokCCx4WOu5n2mzTSDNZhoZ0CL2KIWtjsadUWl2q+pFqk1VxzMrghzLhAKhjAFKxJNiBO/IdNeKiSbqgz4AIM/COblZirmxVYW18FTzCRKC22sSoUGGf0uTcPRQlgfilsrUd2ootHvYFPiLlwZOQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744379364; c=relaxed/simple;
	bh=Ygz7mNt4tF1HCG8OAQz6A1djgBzrGf7mUmF6y0JEfVQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j1k4m9vVH3bE6gHqYkS6VlHwrgYnJtmBOi0+JfHIbKs0yPTyq1vRASAE1EV/9nG7glnAtiGMYFMa5JjD2cAogtwSiBBBZ2FXpia05YmXDz4FNXiiMLpLTWz03gCE2yN3zwJZxlLp0uifYwqlv7uHmgWaNPRkbg1JlYn/fPUCBsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SfRvqQTu; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744379359; x=1775915359;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ygz7mNt4tF1HCG8OAQz6A1djgBzrGf7mUmF6y0JEfVQ=;
  b=SfRvqQTu+ScY6/2KXTYIxgRlmAYx3zakYjoJEYSU3TCtVwI/eaFrQnzO
   kYRwubscqG08Pw3vbgjNQnn1Qv8iDqWYGgw98VHszRpXsE2imov2dgPzo
   EYrJYw/2FnENjWQzuAn5rg3xzNe2148CGjRYhIuWLUlYYDaco5kYW4oSy
   oXecaq3W/+jtWjyZf71pzmtyZsHcdSvwhSAY0r/L4aowVIsPUZu048dWE
   II+RGHH305dfIT/k0EqwuRvmngOv760fDxxMEPsuC9fBcuVoXsZrDVPJ9
   lfqg/4mImryCKOTlohg/6fOKS2/8BYpG08OaL5J+TzG0jUtxJu0DRXUxF
   Q==;
X-CSE-ConnectionGUID: fhpUfXYnR1Gp2iEypsQtLw==
X-CSE-MsgGUID: a1ISiV1DSXS2cEA58rT91Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="63474180"
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="63474180"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 06:49:19 -0700
X-CSE-ConnectionGUID: cvgenspHS1mOwsgEnSd0MA==
X-CSE-MsgGUID: v4Mjs3ZJRt64Nd5NHXQ0zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="166394021"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 06:49:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 11 Apr 2025 06:49:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 11 Apr 2025 06:49:18 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 11 Apr 2025 06:49:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IldBYnzpz4b/8idhXJl8n838QTE6YOSzKLuHBykjhW0lOO33dB3PtwlH0+YnDVz7EQZIWt4yIuMKAjN9Od6pYcOZmkUV6P9iK+Rd2qo6iXVHxTxyY4+1TKnrJSmHR1w55AIY/zhGGeYMUu5lHrFK24XNgiq5BYy4GUIM/nLkKeOsvRId6hyu0nonsSPF5EX9eFntvAVORElFpL4hEz6Sd/CmB5D0lhS36bSxRv1EdFLKMWlYwxKPKkVddccm09z5uL2UE4GSbop2YlovBMiqO/YiDD8+OxSlml9pRR27B/2FZh2+KDAFr0zWeFWnY0pvbvRue2NfwJ0GAMQyA9okIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnJ8XMCRt/rNiJYBuxeQDAF5s51cbiY341HcD7fHH+A=;
 b=cTDc1I7/fWsFQApn7RLKYN+OMHSNc3MGCnxBgVdblG1GAmhlt/a7sLX+SPkTPWLHFgPrc0xrXtESRaweVDP+Y2ZBttjzKgZ3ATtLHFvE1S0rc0abR3Uu7lzK+erbOLpecUH1FgbSvurLx15qUi1fxUZqBAZsWo8px5LLa8l8avt/JkNkuMPXqDIJ9lzUuV8xwlAM7X9IPv4sD4blazA78cq54xW4D+6COzB3+OpltzfVW+3IwBBo+vWIF7Oqd2OzjySRQGApIvNBkPfXUpNSqKyKVXIk+UV1ZtVvCxXdi4bhdxV+3PiDRCLKXQMcOohugSNwmBASGsAybv6Q9Cr+IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 SJ5PPF2FCF00E1F.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::81e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 13:49:13 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%5]) with mapi id 15.20.8632.025; Fri, 11 Apr 2025
 13:49:13 +0000
Date: Fri, 11 Apr 2025 15:49:02 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
CC: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <dlemoal@kernel.org>, <jdamato@fastly.com>,
	<saikrishnag@marvell.com>, <vadim.fedorenko@linux.dev>,
	<przemyslaw.kitszel@intel.com>, <ecree.xilinx@gmail.com>,
	<rmk+kernel@armlinux.org.uk>, <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next 1/2] net: txgbe: Support to set UDP tunnel port
Message-ID: <Z/kdt3KkcSdzOSTn@localhost.localdomain>
References: <20250410074456.321847-1-jiawenwu@trustnetic.com>
 <20250410074456.321847-2-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250410074456.321847-2-jiawenwu@trustnetic.com>
X-ClientProxiedBy: DU7P194CA0008.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::25) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|SJ5PPF2FCF00E1F:EE_
X-MS-Office365-Filtering-Correlation-Id: be6339c4-a1f1-4997-eb70-08dd78ffa4ef
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JGCIAt3nAj1MQaEiLVLuPVozMlvBuBLrhzjmqd1FFTcO+rwp3j/mt09K5B5S?=
 =?us-ascii?Q?0xsbB68n9+pqEvyMMC/yo3jMCFT22v5AfnNR6G1eiIetEaSEDA5B4pGuE2B7?=
 =?us-ascii?Q?MiFenLZbEu+osz5LCD50uh/BRnp8yp9+yEICY1vto6i5gpx2njPZXJhj1jaP?=
 =?us-ascii?Q?ITlL0Wr5oPNfQpaRhjqtemOIzz+5NKf9L4OzoBqlWtFV7Y9MSUuPx4rz3zJB?=
 =?us-ascii?Q?39Dtz33Mg7+GdHcaPQXvIJiiuCidx2snASmRChtF/GLhDCDRSEPL6gPD/W3y?=
 =?us-ascii?Q?TLfB/HyU7FpF0iiwR9QqVwRBeKKNUiVR7fYNe2GrSAToNAOGsn+B64dNvWHB?=
 =?us-ascii?Q?xOObZvOqOdL+Lmh9tVzwdIuf65Zytdh4KUOJElGN/VqbPQOu7xkaDEfi09It?=
 =?us-ascii?Q?WUjg8A0HI0G2AWA0m6NSZWz7/fC/SSWGaN1OELzGS+DMBTuV6krwLxobzp2x?=
 =?us-ascii?Q?i26kqu7nGuw37J6zWfoc9aY5oQHLInXwSuMGY2BfDBW/dookKFiO8wm1PVvr?=
 =?us-ascii?Q?XjNfZaw7KSO0o2u4YUV9XLaIHTJpibBU2xqBsHvxyhHB0yAtgjtFdBCfEgfv?=
 =?us-ascii?Q?ce/BUl9gya7b1mDJ/yf4RBLDAtPbC4bcaAdnfOyt4gpiWelAOAfBGBqwCP2i?=
 =?us-ascii?Q?N2m8lENx3u70Cz7q2zV25BaXeCW2RtyvwMQsvKOQOK6oweIfZztYsm8q3pOG?=
 =?us-ascii?Q?G0JFtcRvYt9vGAXL0eztaWFq5WknelFGEEWe0ae/In9wE+qLDoKtIcsaAof0?=
 =?us-ascii?Q?8m2zsDrToonVsRpvgk8qdcHHIT9s+xrN6o/D3QxYWEUgGZilFdj1B8x/H0uS?=
 =?us-ascii?Q?jHvECcYFvYY1gEUuIEY/UNxYhQkOLy4O5magyRJ9n/drbN5jwAwfttlWJxcz?=
 =?us-ascii?Q?ZYWTwqq/Jins5VRZXwxqf+pnRQnT7ZAVEYSpiByDpTa4YlWNMqijrKS0oy+L?=
 =?us-ascii?Q?wPQdCxNOff4aPlHK7mIH3VcZLZt8uOwWATPKhNI+9oXmdjp+Jv67g8AXKJNu?=
 =?us-ascii?Q?FpoVIP1/0cc3w0GE1InXxKrJPl3gNzT2MTolGmkI+QkH8jAklwgBMg/0IrC0?=
 =?us-ascii?Q?5Mtk+1+kkrD+nimFEuGkCbuHcxHZJw+J2UqmHL0MkhHDBXplolq6BHfL+Dfv?=
 =?us-ascii?Q?/r9ZOTQdSx2q3kC9TPpG/G0o7ERQicNeqhCfblep9OteM87zXRMenjk4u+7F?=
 =?us-ascii?Q?v2fwzPKWWfhdLkrgjC6VrbrKii7E8U6lcatKZ2h6tlUlP4VCX4H48Z4SGWjG?=
 =?us-ascii?Q?wYH2OVIHiBDGI6gUatOSXRrAt9SMoe534OOCxYVY+KL88kTMXXLTMt3sc1KY?=
 =?us-ascii?Q?9itBIRJYKjyoAnArDApyGC1c0YJnjd1lMm5Gcl35/VhYD4QVOXLwfUxmAFux?=
 =?us-ascii?Q?+tFSekMR0+XFwB7/TH6ZMJ4sMRPmY17RIxKd09yb6ANTTwj/fQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nhHQqWuNLJnl/zxjwyofsTKOjXYJCJPd4z8i4n7w8R/aKG0magVVb52aixJx?=
 =?us-ascii?Q?QS6mMP3OfNJVs8UHQsLqRczkgQ/9lLjJVfj8uYCXn/lwPaTcdYm0329vqNuU?=
 =?us-ascii?Q?Pq6P6NHj7LfqqnuWHBXeewF54YqN0YmkoRKRDyt0sHemAaHjg6ZxTBNMWxru?=
 =?us-ascii?Q?A8UpL9R3+5KP0rTuyyiji6Iays69qytGZWpmM29oW8tRiAw8DyWx2proP67e?=
 =?us-ascii?Q?H5GKpfnFvMAmAqN+f78K4O2wvWEd3julx79Kj/pZSlk6Edhkp0u1QHU4ox4z?=
 =?us-ascii?Q?MqfXvSqgxgvrujx2tSbl4C1kr1N6JT206Bmm+SRp31BNm37JOkut0xJ4rXjf?=
 =?us-ascii?Q?KBPOAgKgAVphCogNWxVKD01sQ6lltFcrzzkFbk2KzXzfA3xZmWz4jbnsivCt?=
 =?us-ascii?Q?4jXasVr05diK79JMUcfId+FFtdw3eQQY/ejc2yZKn7tugnlvaABUy/EfUD9Q?=
 =?us-ascii?Q?M1NdBnKrs73BhFrayKCYmeCeCTyeYcrMHsBfiABQ66NdHzMmHm6U7QaQWXuy?=
 =?us-ascii?Q?L97elSp/PHe/wI9hAylmrfJ0kmpIF6CMVfcBaCfi1icOaWkJRlWAWNwFjeJT?=
 =?us-ascii?Q?iiqwc1r/9rRJRlCbvThsz0d+fDU3y5U+rOnm39mK/6S9l7a1Ib+dx9th54JN?=
 =?us-ascii?Q?unUtdwgcm1F3LGPeIq8fqAdhgJBv1ah2YE1PCcIIBirLvCx4o9HfWQtkMdG8?=
 =?us-ascii?Q?qAIw5iaxGtUd9xLrJQEfMYP6vj6+Atl3HWzzBHcjcBlvaBxiDYYno/XF/aOD?=
 =?us-ascii?Q?h0RNWG4MXTfAAjkez7WePPdkTelU+tm7iDd7jCUxnwIGYgsoyeGVCiPnzTLr?=
 =?us-ascii?Q?KSlk/leQ21mG64QFgtPsZmhuEUht3Te7q0UupPpWtFvgaIQ+UABnUaqpqlLj?=
 =?us-ascii?Q?XE25x1PaHUR29nfDi5Z0pRY/zHNueYmgyKZwmq2MbKFE7Zs7hhEIGaW6GClM?=
 =?us-ascii?Q?SJqutRyc2EMNfEHzp0UZaBGlVKIEQydowYGqI7+HA04EHvesjIo+CVGnFhRS?=
 =?us-ascii?Q?4FsBswdXvKMSYsEZOZXh8VbZioMvTX1xG8wpGcMtXF9DDowVhBRu/gY2PB4R?=
 =?us-ascii?Q?vNEAm9MeyP/43ZYg/3OHcf7+CVSDSpEo740lenkqc3g0qUl+kkanLOdseR1h?=
 =?us-ascii?Q?kMTToqkV29Ed/NiLfwUWCUcdgHx7Rsz91rz788tHIDYprVKZz5oFUdn5MpPW?=
 =?us-ascii?Q?2iVxEIJgbPhw7LHn0Y6bJt5PGb/e1lULwv4bkKdKOjLSChO7gZNEX5Q1P15q?=
 =?us-ascii?Q?u/k8lxS2n37eKZ+Sgft9fZ9ExMT+QqPo6y0Li+wbhIkMTWMM+BdDxSnCECpL?=
 =?us-ascii?Q?STTRL/630OSKCxf4DnWrBcJOdoqe/UC5e+J9spG2CVqMVux8cOXeqgU3DQAY?=
 =?us-ascii?Q?/fBph/SXRcwCVdfCKstXJ7d2jqra8NHy+i7wlb5O4phCGzaLYi22W/Qjw9iQ?=
 =?us-ascii?Q?erSd0NbduoONpZaJnOoa8mJXcn9XcxTyqRYQ4S8HpHDkVEGh+WjKbmkn5fGL?=
 =?us-ascii?Q?GsMSHsvURxT7JbMc9jD8Tj2vPwXcwj82kKSNr/rVF+1dHVmRNb3v8yEglt4C?=
 =?us-ascii?Q?JRla7Tb0Kml/ZVx+f24Itp07z8HsZQIskuKxMmQ9r386oa3z8+nvGtoU9cIB?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be6339c4-a1f1-4997-eb70-08dd78ffa4ef
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 13:49:13.7713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tgXTFp6B81tP5oJZRj254WRDx7rx3ScBdViEjzWCNFx4JqgAhk6nmzT2rK8w2+Nv2J1V5ehxaR1Hs5md57/KYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF2FCF00E1F
X-OriginatorOrg: intel.com

On Thu, Apr 10, 2025 at 03:44:55PM +0800, Jiawen Wu wrote:
> Tunnel types VXLAN/VXLAN_GPE/GENEVE are supported for txgbe devices. The
> hardware supports to set only one port for each tunnel type.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 113 ++++++++++++++++++
>  .../net/ethernet/wangxun/txgbe/txgbe_type.h   |   8 ++
>  2 files changed, 121 insertions(+)
> 
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h

[...]

> index 5937cbc6bd05..67ea81dfe786 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
> @@ -88,6 +88,9 @@
>  /* Port cfg registers */
>  #define TXGBE_CFG_PORT_ST                       0x14404
>  #define TXGBE_CFG_PORT_ST_LINK_UP               BIT(0)
> +#define TXGBE_CFG_VXLAN                         0x14410
> +#define TXGBE_CFG_VXLAN_GPE                     0x14414
> +#define TXGBE_CFG_GENEVE                        0x14418
>  
>  /* I2C registers */
>  #define TXGBE_I2C_BASE                          0x14900
> @@ -359,6 +362,11 @@ struct txgbe {
>  	union txgbe_atr_input fdir_mask;
>  	int fdir_filter_count;
>  	spinlock_t fdir_perfect_lock; /* spinlock for FDIR */
> +
> +	/* tunnel port */
> +	__be16 vxlan_port;
> +	__be16 geneve_port;
> +	__be16 vxlan_gpe_port;

nitpick: Can these definitions be reordered to keep the consistent order in
         newly added code?
         (In all other places you have the order: VXLAN, GPE, GENEVE).

Thanks,
Michal

[...]

