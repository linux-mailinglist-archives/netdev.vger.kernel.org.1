Return-Path: <netdev+bounces-126760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 917C197264B
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 02:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E27B71F24BD8
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 00:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FCB748A;
	Tue, 10 Sep 2024 00:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O+g7FWnK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC5223AB;
	Tue, 10 Sep 2024 00:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725929117; cv=fail; b=j/RHd+mn9A06oBzjM0CaIhuTpN/xBb7d60evKG6GDPXBa8TjG8RLlcPQFjbfG00eSdxLJvDX1gM+Gksbzpdo78JmVfsbgA+nIitcDOjZ/x/cN/hM0wQ3zwBL9KFDO4KuWQrFWkctC6g3tOfE10JA1iTdR2A9ly8c2mAqUZgiANg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725929117; c=relaxed/simple;
	bh=GDmWVAzZ1N0kwIRgjeIvjI2SdiJoG7HYd8gLCmt4PGk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Odsh5rZwTgYpUE+CfUIGHbt5rSMhwIRhd0IiNpxVEgdupGUF+UP50DpzNivOHx+r/DwOsXn0E42wxq3TYvttvemnZarIbIHN9rG+00lX/pQB889g1GF0ee+FDhvSsHuyJnW/v3nA2lb+PwHdBifY/5S0KK4jY9IoruLGyvWwCBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O+g7FWnK; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725929116; x=1757465116;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GDmWVAzZ1N0kwIRgjeIvjI2SdiJoG7HYd8gLCmt4PGk=;
  b=O+g7FWnKiM+k0PvWCrjbtFOfBJ16uAdVnJyCrXKlquL7zw3LFqowMEpr
   f8cy7jSWg/6vnWXcSZDjqGc1c8N6doxq7NjqLMnnatO7uHcjHNEiviwMx
   AKvJjxATOjAwMVJJNIHnhhzTeY2RhhcV0Ypktnvf1XId0s9kE9Q2rxptM
   LVJe4+qUxtCkH1/agQv1cTb0w0xIjF+t2xx1KZd7NVJNWV68jRdlyMeGE
   UDJRFofssYXt2nxdcQmyWtG6SvhVUawMXHkjkQFsBvFwMB/EKXr7lYnhc
   ivDI9FLND691QzMDXb5LDznAl3WWns2Vs/z8eHHAuQbP1HlsGyJe9j9mc
   g==;
X-CSE-ConnectionGUID: bs8wUoFtRHGZfLUQce8LCg==
X-CSE-MsgGUID: xpF5MxL1S+Ok6ONqNF3cmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="24155967"
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="24155967"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 17:45:15 -0700
X-CSE-ConnectionGUID: u/LsyzirS0uhZNDluh7CbQ==
X-CSE-MsgGUID: GF1/py1zTyCChgk3vxAP4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="97657804"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Sep 2024 17:45:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 17:45:14 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 17:45:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Sep 2024 17:45:13 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Sep 2024 17:45:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i0lPg6UtBxY1ZDLAjRHr5wReWPMdRM1/M2f5FZFlOGeI4cJj44vUL/sYXTIeUmpfHqUi88jyAxo6IaHN7c2ST0SITK98hJCqGaS0YxrwaIV6eZdJADVEzwW4NyrJO04XaLm7qnlLUaz0yR6+F0Txw0+JbOzC64Z755GU/frv+EkYCe3AcdzZ9m6rSCXQd7tMk+aFqInoTAQAhbpWUTgi13AsD8XpziWicP+xVvIwPBHwXdACjyMjGTo8j+f9t/mxbCWvy2Iu4P2JbbpAHMS12+CcupqkYbrF8swRlwS2xgJskyFwfbTvI9n+5SRd7RewcA3x1dgEUCR/neLanlgzaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXnr3ExNY78178mbBjS3/w7VOw++7LAjQuQBZ4F6tRQ=;
 b=GLTssz41b2fL85MO5FJ8K5eymwtqXfmTv+FInNeYsoizwR2sKV1i8y8Y6LJpXj448pBrYCY7xS9AaUekNMFuN1tyZa9rh2oLdmKTPnwo+IPsY9bTzjaXCl9tgEb6NFXrlER25tB/fCOp7slJPDAKjHVV4o/hDffxwWCUbZqH45Dt1kMF/+/xdJJeD8MyfdC8f06rQSlEFejbLfQLlTcr4dRd1YR5rL0YLKJYlDzwMWYuZLA07tIdt2fOivoM/eVE9pbqXH7rKNuROvGY8VIKufUqF+dHVJSieQ6l2flPRoOKfSRxNwPXHdJioXu2VYVmp7X1LMb78fApcwVyqKPyYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6287.namprd11.prod.outlook.com (2603:10b6:8:a6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.22; Tue, 10 Sep
 2024 00:45:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7918.024; Tue, 10 Sep 2024
 00:45:11 +0000
Date: Mon, 9 Sep 2024 17:45:07 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Zijun Hu <zijun_hu@icloud.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Timur Tabi <timur@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v4 1/2] cxl/region: Find free cxl decoder by
 device_for_each_child()
Message-ID: <66df9692e324d_ae21294ad@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240905-const_dfc_prepare-v4-0-4180e1d5a244@quicinc.com>
 <20240905-const_dfc_prepare-v4-1-4180e1d5a244@quicinc.com>
 <2024090531-mustang-scheming-3066@gregkh>
 <66df52d15129a_2cba232943d@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <66df52d15129a_2cba232943d@iweiny-mobl.notmuch>
X-ClientProxiedBy: MW4PR03CA0219.namprd03.prod.outlook.com
 (2603:10b6:303:b9::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6287:EE_
X-MS-Office365-Filtering-Correlation-Id: a0a3bbfa-5747-49b3-2bcc-08dcd131d350
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3VybfDfBL+7LlpSlJ9qhtKrQCKZfVWOd68KNlfTtOwwfzHwWM83m7KpG5t2E?=
 =?us-ascii?Q?SYhhl/3gclP0cbDV50D0e8IbzHZIeNzoOYelq0rnDowcX+l8rusPssz5OvqI?=
 =?us-ascii?Q?aqLPD4LK26EkUxe2N7ZKgco1ihSfV9WeQFdOkwcGClAU49Q2pR8FxUfxR8Q1?=
 =?us-ascii?Q?LIId1A7lCsamEFkdD/iAG7xExf1wxfxeWHq9bYIhsSdpS7RIVwc7/4bQ43BU?=
 =?us-ascii?Q?v5x2XpOGDIg3F/vqGD++MgxJT+cfUDwJOz/JXj9WGo35v7BrQFS2PVw19da6?=
 =?us-ascii?Q?zQg6/wtRZGjKw+b3R0Dl7JMHJtCp7zK+q0SxMaqq5KE9JDrK0Z6KCNxi1HGs?=
 =?us-ascii?Q?JBqugLJ3wDjlgk/AIDe8ri/x6CFaDYnc9Nq1nqerDdjE+8Yh/MWFWUlrhBTw?=
 =?us-ascii?Q?VjtEdUdUWzkEIEEW4POVlPOKzBHOLxYgWT9qn0TbLJq86k/IAelJFnJ/bjSK?=
 =?us-ascii?Q?X/02ZhwDeBt5TOHtQLUfhkPzSCMdHguCT8iyg5PP0bjjox1PsvlbTLSI6KZF?=
 =?us-ascii?Q?odfEy5j01E/1PFV+qvBVb/S2zSyCNTSM3FrT3kCvnCuNcQJUolqNgraDD5TH?=
 =?us-ascii?Q?H8PV8WDDlSz3A2qDN8q3VgFO6Vu8nQOq/hmY2PSKvccS2krcx3i+C7UPdAtk?=
 =?us-ascii?Q?/bervwM6bXgvqnl2c71Kop3hDp9YB1KITOMNGZeM+PG3Y2bTZF2FU2oPl2oC?=
 =?us-ascii?Q?WTF4QizGgVEuZn0Xs4WVIvPzbGMjBXSy2GoyLq8ThwjIO0jXpvtn2+jMWYQO?=
 =?us-ascii?Q?hOsg5VjUWXQ/jrKIh2dLpvgT0UlAlSJ3ULSFJBNsli3wZgI7uy9QKL99K25O?=
 =?us-ascii?Q?se6vcFKiKF1/HP0qFAd/VjTH4BIjBK672dpYacshni9IRN2gHul4hsBzHTyQ?=
 =?us-ascii?Q?mNy1f4mrDe0cBntjoES6KqEPKen3N2WhBSe8ROQIDrpeC3dMtlVGEzTG9fsZ?=
 =?us-ascii?Q?mXvfY+mTyf0zQs+P3kEDI64aYWwLySNDM14e/fOdJ4Agr1B9b3q+pHXRCtY5?=
 =?us-ascii?Q?MuwQa2O3ICNAsSQnR04gdznmYmuYvv+jeurfngL5Wp0E/GYvkWahpX7GmX8q?=
 =?us-ascii?Q?uu2SzEdQYolzruEWJqVMZ4km15EC51CnstEOtJnjgDZwxKIkhwRDfN/SHsoT?=
 =?us-ascii?Q?2Lf+xoCb6Ob0K8ibhERw2REv34uzWmA6nSe/nCUNgXGNMz5McYH3RfWHhG1z?=
 =?us-ascii?Q?/b8FwrE7JlYhpkjhxGp14ZcXcwzdidmJC8O8i46KMcm01HyeF2Cl62B8j8Lw?=
 =?us-ascii?Q?ZJOICDwwxAMAykxictjVMh2LS/VGl1q+TojC95cHfjxjf3XUgDKH7zaJDkxk?=
 =?us-ascii?Q?g473DMnXsAtBuppeCixVQlF9WRqf6JFHq2cnx/fntjZzlg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sD9M2700ZZxqI01uywbkln1586RfkBBeenqY4KrzVFIZaAR54cDlXJjGKtQu?=
 =?us-ascii?Q?zKZT+fEecjYXyIWt3bcFM8rzL512BSJddXRBnYPNvuPJxakyxpfBq7T5V6JU?=
 =?us-ascii?Q?/rWf1FFNgLtYGN8YEo7eRBTal1MRhQdYinKQySUW65M/w1Ap8QyapBd+gESc?=
 =?us-ascii?Q?3x0I1MOfJoyTmiMrV0aRgZJjY51IvLufjm/VVjHHzE2PLY7VHYC9z/6701X5?=
 =?us-ascii?Q?61wnOF0aj27+gDCrTemXmJOe63JR9Apa6cN8j5XfaLdFm0kp3Yf5nmNXees+?=
 =?us-ascii?Q?nZnlU4ZSrHx3/Vnyt+Ym33QbjkI0cTRP9WncRTZIAhNo02+gL5AvZua4g35u?=
 =?us-ascii?Q?R1oZG4ahKvkDnqkTkVpikfj8zDxBjjWQUy2+09ihCj6d+6VccBJgTTIHyz5P?=
 =?us-ascii?Q?LprH+3XRl+uGdtt1zIdQhhYLpHU9vrg8SLygRwZNm8zWiCVsZVUniP5n64F8?=
 =?us-ascii?Q?0lv8FqOyx1YGuqYI+qd5EwcGgraQaGdnrAuKxBe9PEMLtgHEFAV96iwATCSR?=
 =?us-ascii?Q?dGi1aMcZSAUZUvB2lQvImnYXb+XEj+ugFVH8xdSWTFdpgdt8jm9+Z8AKVInP?=
 =?us-ascii?Q?OQa+0Id5xrgUaZp9ci4DYuKjzBjksogq+CZmz8lHeLfLHKF0d7WvHfktgYWl?=
 =?us-ascii?Q?LkWibZ7LDBtOhZSD4f3peaTpG8+139X4WP6vCTMXqHv2gkM67kC5fn3G2//v?=
 =?us-ascii?Q?MiNaUEfJvG3gSaCIkYTuRn7j+8qgEJnqMgAOtwPOnfOjUuUX/rumGv0dYgDP?=
 =?us-ascii?Q?84ZvfwWhl5+YTs+5FFxm3iXoifITcT0xwR4NTR8gh+eN2ONWQkgOVV+rnf3c?=
 =?us-ascii?Q?XYtbI7AkKfeh5Kw+4HLT4MqH1M+1xCRc3Fy9H9qwtvy1ntT/D91PKJRbFfjt?=
 =?us-ascii?Q?2rWr8ck1fJBOCgiD4Usi8COUHht8mT3EvfIJzDkoJkjmLWgr2F+IlEHugkxa?=
 =?us-ascii?Q?cfipvhBIv2z4r64yFXBZFBlglQzujnbYi2lIMw2X4sZDgEe8AcPMHL8eRrfY?=
 =?us-ascii?Q?+llbMTOo2lSk8N7kB/wUk3aO1kP+UVE1opJguwsMDePY3az7gsJbSzILIZM1?=
 =?us-ascii?Q?lk4JcLvguv4+i6+DrIDt9VLpmXt735jUkaEFXyMMIVLVEfmf+wg4ajQ8UPSx?=
 =?us-ascii?Q?3pNjzS4kyQ5i5cMJOHG5nD1+FadDMm/6jZ4tuZnvMXFUANSnQtA7XYZ5GdHv?=
 =?us-ascii?Q?PW/tXNq3oOgbgviyN5aw8DDP9DHeBNA42+9VINAfbFuaHSLL1x3+uOJB5kzB?=
 =?us-ascii?Q?ZvlaTfjkQTTI22NNQ4R9l/nxqJcA8C8CXjC1IT9mwzl6CdF7ylcMfUxZsB5s?=
 =?us-ascii?Q?4wwpkJHL0cWoboU2o5gzuUKv7jtFDcT9K7ULbvjJhB+hEwkFXRxnMPYnUQ1l?=
 =?us-ascii?Q?OTwRCuPC2fPE3GYeox0hO7bznsdAfbEfZEdjTDCbHf3Qwf0RJ/hxbbKI4zj1?=
 =?us-ascii?Q?9RmIm+vPNrln4Z1jp5iX5WxO2KXh/NOKcUoE+mLvDpLt0tM3GFAt/d1cnny0?=
 =?us-ascii?Q?15R2l1mgLCiG5KqI+s0msdvVo39+nptfy9FZh93gr6zxMTCnamA2CiAIxEj7?=
 =?us-ascii?Q?Sf3GDj4jhFPn5pC908AG0oVA1iv0b6Qsv9/YECk5dyp+09RiwdCJY2k+5emN?=
 =?us-ascii?Q?dQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a3bbfa-5747-49b3-2bcc-08dcd131d350
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 00:45:10.9663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 20kU/8sCHji21JAyMNbdhx/sOVi+5NGVJcmvDmwrtQokhBRgPxtlzK6lsyia9gZ+qRoLMFhNlzUL7Y/pjJL2VQdTBd40sswReNVovlMbWrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6287
X-OriginatorOrg: intel.com

Ira Weiny wrote:
[..]
> > This still feels more complex that I think it should be.  Why not just
> > modify the needed device information after the device is found?  What
> > exactly is being changed in the match_free_decoder that needs to keep
> > "state"?  This feels odd.
> 
> Agreed it is odd.
> 
> How about adding?

I would prefer just dropping usage of device_find_ or device_for_each_
with storing an array decoders in the port directly. The port already
has arrays for dports , endpoints, and regions. Using the "device" APIs
to iterate children was a bit lazy, and if the id is used as the array
key then a direct lookup makes some cases simpler.

