Return-Path: <netdev+bounces-305136-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dn0/Me/VS2p+bAEAu9opvQ
	(envelope-from <netdev+bounces-305136-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 18:21:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90327713281
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 18:21:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=XNF5NqQ2;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305136-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305136-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 14B8E301DC67
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 16:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA773B52FF;
	Mon,  6 Jul 2026 16:10:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19373414A33;
	Mon,  6 Jul 2026 16:10:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783354249; cv=fail; b=Mjd0h9M+EhO0e57wnA5X70zvLJFo2Ftiye1rqulB2uf3N31qDih9PxaoAI79x7ZObzNwUcqykbCbWEP3MMgjI6/Ce1AO5Mmiin+wVhbj8N1v5SztBIvrWT0xWVuux2pvOeXL5+ehBv20YDvNb+K/hKpnpi4mVzDe2ydQzU9F3po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783354249; c=relaxed/simple;
	bh=vOyYK2cYvHd+Zm8LGMRrGL9Eogdqv5qsSRJJ1SMRNYg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z/DSpuqxUfkKJ7P37Np8FnHVTKufteWBxp+r23r9B4gxHs68z+3AA4IbT00bijAxFm085YvY8zzyY3QlaVDyulLBkZlUAlwC2YZ7ypzhbwSgvnJDEc6zwBaZdOcL1ZFK84DQHF/Yg1El0FBIVNG86HKnfM3zSpEO7kJ1G1HubiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XNF5NqQ2; arc=fail smtp.client-ip=192.198.163.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783354247; x=1814890247;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vOyYK2cYvHd+Zm8LGMRrGL9Eogdqv5qsSRJJ1SMRNYg=;
  b=XNF5NqQ2n/aGOBWTJ4YN2VbNEMha+AN09rGuWNF8zJwIs2F7+wMRMajf
   N1ReBnQW1WKs50Gou/+Z9ztVmX/1VyR45RSdX+u96mIGQwg3TiTvYjOQU
   6rJJOVw7YiwhbU6hk7opIPzXAnjLV/M4QHeM6hLWRFzHvBn6/rMj4T8k4
   siWKKjyxbjnNcXfDo9h2IgjuNU20ZOKGG5DT6fux+DQJi45mHEhtPslPD
   RhiZl2TvEta/VncEY6aK6ar5LaBCFW0LNe0rhFHReEwj1LtzSOmvAJlmG
   QgqkYiOJruiwTC+LxsL9jyTAYT/ByBCIgikl1WRABr1lv6vwKG5m53dvF
   A==;
X-CSE-ConnectionGUID: 4EpLSWQTRbuXcolrEPFIkw==
X-CSE-MsgGUID: 9pPi3muMQlm5j0Ztq41lbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="94597555"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="94597555"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 09:10:46 -0700
X-CSE-ConnectionGUID: LEm4AJAqSvmAXrT1sdGHLA==
X-CSE-MsgGUID: Wu9QOktKTDWAMEbznCb+AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="249764749"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 09:10:46 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 09:10:45 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 09:10:45 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.47) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 09:10:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=En6yIDYjzKB7AnKQwG0fCim0s7TqEn0hPXfv6afH5OuJ71NSrYiHUwq4TWRkcJ7Tz+ExBb83tyQ3HInILDbcEp+vv1tbSkX4y4jXF1q4IxpIICGFlXae/cz9nbEtrtDtwB1UbkGoWfFvfnZcE0S6YH42AUH85IaDK2PG0CcFOEqnLR6jxkVJ/98aa+k3lPhCWoH9bphIWuWq2UdrGr2cGNcddnUkQPOijdWwY1xSPR38G3BLXbpgODf2W39tPe9bmAecy18vS6dfmXg3cW9ja6oRugGZ7oR5hPMjrK2rQ9OOvdbMSR/gkJ5ahpYEQLZ4odzuSGBFXmfZ5kKXromi/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u465hzd32+Nn7Sh4crY5bKnFTXtoDZLg1PxpkELlX78=;
 b=G4GBWW1zYRBiqgCwqG0kwHvrQPRFXurPvLHaqz9EXrxQZdag164OXUjp0+vi77FdTH6enGEhWbaLh5y1SqnSeBreeO/uyrHPBA9/bjLods5fJpwiHmbFe2QrUzYr4XOpJWxqJqZ4cjxph18aEr247/teJJ34Qjb8nrIZOEtjvuUCxk0/BLvVGgHTPn+3ZtCaHoQfb2yUt0FasrV6up0dXnGzvg0cv5+ympFIXEgEg+TL0kuS61F/yWoOTwF6VwZZd5j+5YMaFpv94ySOaX6H/AKxLvQHWEKZ+KnifM5XqVLHB3anV5vbWuAmLKEK6MG8pLHflFjQpixJKakwYzeqCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4SPRMB0045.namprd11.prod.outlook.com (2603:10b6:8:6e::21) by
 SN7PR11MB8284.namprd11.prod.outlook.com (2603:10b6:806:268::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Mon, 6 Jul 2026
 16:10:35 +0000
Received: from DM4SPRMB0045.namprd11.prod.outlook.com
 ([fe80::b630:ca9c:20e1:f485]) by DM4SPRMB0045.namprd11.prod.outlook.com
 ([fe80::b630:ca9c:20e1:f485%6]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 16:10:35 +0000
Date: Mon, 6 Jul 2026 18:10:28 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>
CC: Veerasenareddy Burru <vburru@marvell.com>, Sathesh Edara
	<sedara@marvell.com>, Satananda Burla <sburla@marvell.com>, Shinas Rasheed
	<srasheed@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Guangshuo Li
	<lgs201920130244@gmail.com>, David Carlier <devnexen@gmail.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v4 2/3] octeon_ep_vf: Fix RX page leak on
 napi_build_skb() failure
Message-ID: <akvTdFCJ2a/bCM+1@boxer>
References: <20260706150208.2944898-1-maoyixie.tju@gmail.com>
 <20260706150208.2944898-3-maoyixie.tju@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260706150208.2944898-3-maoyixie.tju@gmail.com>
X-ClientProxiedBy: VIXP296CA0009.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a9::14) To DM4SPRMB0045.namprd11.prod.outlook.com
 (2603:10b6:8:6e::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4SPRMB0045:EE_|SN7PR11MB8284:EE_
X-MS-Office365-Filtering-Correlation-Id: 76c93880-f089-4328-a53b-08dedb791cbf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 5JHdpCJzRs1ltSNr/4DkFWl13F6BljzbNnnmRRT5jzrjpOm1UgIYDAr4i3r9ESxjU5E9459nCHW5eo+64J5I1iStQOCPUNnsIoOdXGmWwaOcTg4Si4S9kv964CJND3utmn79xsZTWJI8fqtLAJn3yQXNSwlmbaN0fuddw9qk+VKkYwEQlD/8iGQx6jtlriIdAPtF3b7W6+QNj5DQkCvSXyjG5re1UTEaFgvA0Od/YALCMwfShsYmkGMujUtCbCQiKLN8DPvCTOiQ/cIP/kVj5it6c2RZg5XvBAAScnw9biYyXvbuv2L1JCV3akZXRkqaPuHChWyE7HDwUpJF/ZM/TCoUKpgLl0ijLf0AqAEVBhP2AcR5+onQ8k+W0Kwq3zXuTNNPeAgM+Yn57q37mi9XVMEkd9dm69p8gE+3EEqTzCgniHjhOZ1avP1gUkkjj7A+faajMoiX/JL/hPJyowESYV0qltDXoqNx/PJfA8oxSn/fSZnyIrLGwBzamsdTPuBd+7rpNTy2PV+ORR4t4XwBu4Bf8uDjnn8tPvyEWBjrgIeUmwp7oZ/UhdsEfSoh/K4Ui5qynyYL4O9vgI3fWjopZ8qarFW9giFNi340fQlHGjPygCz4Eamfsma5x+lYCcWSWmvb2JzzHtr/VW/Q3MmHFzeK12rxLekQPa1Ya2Efxic=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4SPRMB0045.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6Ntg4//BD4/oqPqeGpypWHKSX4qCSZjNL7BihS5V42qFzHdAPkwiLiYxaK5c?=
 =?us-ascii?Q?kBzQ/Xydu+wJTo/aFlsSBQdz92o3wCwNdPLLupUjqSCi5DnQeK1xNLvsrQvm?=
 =?us-ascii?Q?3WgYka5JRI6LPcneDnKnKB6KvmV4KcPy6Azb5vH4nmZrTbI+tUsYvXHScFVT?=
 =?us-ascii?Q?92Vfl1s/i+2cegndFWPdH7RrGoycrW0wdZo/wO5H72+3pWDugZ5OEhli4Vn9?=
 =?us-ascii?Q?q5biA0K8mktHvLcMitSsUeEgmltB9PqMLUuj9VGCSdslYuRbM7G8VJw8Nyz1?=
 =?us-ascii?Q?HORh5ZVfK8dRkUBZ1d7LEmMzzndmTCqYb2HoPXfSNRUkpPWqemv/YI9C3hfE?=
 =?us-ascii?Q?7D7O13XLErc9xkFkd1zQ21la6HHyry/7pHeC3E7I6QqQk+uqhnTHVDjCkEdO?=
 =?us-ascii?Q?wf3jyYyVwkOAGicr5sEPasmzs+MZ9f3r+d0i1T8XLMczMOWx5gMUHt34vEQM?=
 =?us-ascii?Q?UdMgVUsrdzAnvTbYECHLnWpADJkGUa/dWkbB1l7NOYIzZJYS0/NrNamYDKXB?=
 =?us-ascii?Q?OSrvMfED5yk852IW9j5eSmTXsPHNNQgTUkEii/4Fb2NyqKiL/UaTYYXlG2au?=
 =?us-ascii?Q?EPwS5HvV1oo2Uox3uJF0fC79UzTYLfZ695aPOHTuXKqBtCai+0PCpO+2x+Tv?=
 =?us-ascii?Q?qSZj5vnzIq+4P5KvzxpSbi88w3WVuxMGbEo8lsr90aBtKfpUmr7Z6n14aLVk?=
 =?us-ascii?Q?z+MURfU/FNo51iZUXUC54sx8/yT/KsjjSe8Xr0Z+hHgzpIlMUpAI03YdeYJI?=
 =?us-ascii?Q?B3LHmpEwwOxvwRFtXuTnmYg9SjnhaZHNCMti8EQcLLI6NmGyb69Aso2yEEB9?=
 =?us-ascii?Q?OKVLSYkUiVRgvakOGzAJh4egvV7utPxRRJtvfrA/yi0bolOK94AsVLJmkuub?=
 =?us-ascii?Q?AnJUQqR1mH0MKOdSlNc5vIY+qYaYnPzMYR+Xv+V+8yvcKSjN+T4+cSy/bh5H?=
 =?us-ascii?Q?l6Ev+7nhtVh//urzUK3dc0pGRfu3rVo45HR1t56aLk7djr0/N8BpR9mnKEy8?=
 =?us-ascii?Q?FT144fBv8yitgMmwsB614WGI3/xAhO5IEpr+SXdnDsFIeF6eEW5ulMQFGqDh?=
 =?us-ascii?Q?iaK8MZOY2KZ0OYSprSBNhHZqcSy8sU/GVheR8sciTXscO0Fy/KCRYift6L5b?=
 =?us-ascii?Q?rOKSBGjUTCBr++rstRyM8Jzj8NIeycdYslbn6uTu+OJo3u88EHHbvC9S55XG?=
 =?us-ascii?Q?TJEdAOH6fGeox3lqIwEExU/tIuLTg3NbnJtlDwVlLag6i6ObG8jM2bDrort6?=
 =?us-ascii?Q?3Z/oSRvfEITIfUBuNLtqEfUH0gKppow0VabEaADlF/aV4guaLmLdQbCQUuu4?=
 =?us-ascii?Q?z2xLsBHmq3ArSbXcwg8VABsjS6WuXdCttk2UDFx9ejK1AY/Fxp44mBnBEM3n?=
 =?us-ascii?Q?dw7s/0rvLhn3CULKqwa7vdysMaQAfxTCgedMYyrJjKVAHrxUC2MN6nor10XR?=
 =?us-ascii?Q?WvWjoQ6DI1t/TwWpwtvhGJSwF+6BQD81KWux2O86WXV/hWbDyweq2mSziujB?=
 =?us-ascii?Q?QHMn+z6SNEOYa+3pNpgHn3KRmkNfTeVW4/Oxu5HFf7WELBERfueOGpRqLDLt?=
 =?us-ascii?Q?iWnbgJ+ktmN2hJqmvkzliNwAfOgA4p3hdOIHKdbWuqhlSVltoGrvDqMnXoWx?=
 =?us-ascii?Q?TPCc8G0C2r0brxTdFbh1u4GCJWLj+C6zNN6Y8v91nzVKnWJk/5k8/fhNlKf1?=
 =?us-ascii?Q?EdQVro9dOqi3LBJKQwhI3L2RorET0zphlMNhGGGX4k9txlPF0h7Zg+VDEa3p?=
 =?us-ascii?Q?fqFBDWQCzZp5xVZP+5Zi2Qu9radoB5k=3D?=
X-Exchange-RoutingPolicyChecked: ch4ZvgRCxEoRtn3So4732L8g+ynngdMllQ1l7bqZADY/9Acc2xT/VTNxqbhP4cUzyzrqscoQvFMzxYZCQnm4OsC2WA5MkZzyFSv7a/xzGD5uWsI45BCk44q6IVWE2/6ItVzTJua6zUi37lHKRsq/52xVGo8kDq0pAyNlFTEMTi9Pvp+Ik/XNbVhat4Or6tU0/yRbuzwcZ4dTLSufvkz1UukOm1D4SvnK7m43JHdNa6xMPZ9HkhOBQEhMQ/0oh5tXeNflt7kev84qZZzsbIvdzcJObc5v+ooSJ9+n1n6NzzKFVSWhc8vnn1xcCr6/OA0iCaWWv4oOlhJpHRO+2GyxLg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c93880-f089-4328-a53b-08dedb791cbf
X-MS-Exchange-CrossTenant-AuthSource: DM4SPRMB0045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 16:10:35.3768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hdV5XAGPRRWMJZA5B/IysATSs8IGZTz1haGKjYmqpmps4NlEEl/MrHLFekxVvMHSWsRlGzobyRzdHnIif8rXjU/94LULzRLdHU9BUIGp6pc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8284
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305136-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:maoyixie.tju@gmail.com,m:vburru@marvell.com,m:sedara@marvell.com,m:sburla@marvell.com,m:srasheed@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:lgs201920130244@gmail.com,m:devnexen@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:maoyixietju@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:from_mime,intel.com:email,intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,boxer:mid,vger.kernel.org:from_smtp];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[marvell.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 90327713281

On Mon, Jul 06, 2026 at 11:02:07PM +0800, Maoyi Xie wrote:
> From: Guangshuo Li <lgs201920130244@gmail.com>
> 
> __octep_vf_oq_process_rx() clears buff_info->page before building an skb
> from the RX page. On the success path the page is consumed by the skb,
> either as the skb head or as an RX fragment.
> 
> If napi_build_skb() fails, however, the page is not consumed by an skb.
> The error path advances the descriptor and leaves the ring slot cleared,
> so the page is no longer tracked and is leaked. In the multi-fragment
> case, the remaining fragment pages are also unmapped and removed from
> their ring slots without being released.
> 
> Release the head page when napi_build_skb() fails, and release each
> remaining fragment page before clearing its ring slot.
> 
> Fixes: dd66b4285470 ("octeon_ep_vf: add NULL check for napi_build_skb()")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
> index d982474082..302559b16b 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
> @@ -418,6 +418,7 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
>  			skb = napi_build_skb((void *)resp_hw, PAGE_SIZE);
>  			if (!skb) {
>  				oq->stats->alloc_failures++;
> +				put_page(virt_to_page(resp_hw));
>  				desc_used++;
>  				read_idx = octep_vf_oq_next_idx(oq, read_idx);
>  				continue;
> @@ -434,6 +435,7 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
>  			skb = napi_build_skb((void *)resp_hw, PAGE_SIZE);
>  			if (!skb) {
>  				oq->stats->alloc_failures++;
> +				put_page(virt_to_page(resp_hw));
>  				desc_used++;
>  				read_idx = octep_vf_oq_next_idx(oq, read_idx);
>  				data_len = buff_info->len - oq->max_single_buffer_size;
> @@ -442,6 +444,7 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
>  						       PAGE_SIZE, DMA_FROM_DEVICE);
>  					buff_info = (struct octep_vf_rx_buffer *)
>  						    &oq->buff_info[read_idx];
> +					put_page(buff_info->page);
>  					buff_info->page = NULL;
>  					if (data_len < oq->buffer_size)
>  						data_len = 0;
> -- 
> 2.34.1
> 

