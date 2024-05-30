Return-Path: <netdev+bounces-99293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6405B8D44E7
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 07:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C74FBB23CD2
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 05:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E8E17C7F;
	Thu, 30 May 2024 05:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bSV05/VK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4634367;
	Thu, 30 May 2024 05:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717048116; cv=fail; b=gpGIVLSt8e4jjPQOcwXUm2m/xzqRi5XMoAyXNQZ4pS6BmegXEgwZDS70bosH+1r+yjYvGwIywPLk9UgE+uLzkrWUDhtFGTxryvfaGct210rXSo3TRRkLylnoZNbtU/8PP+Po2YpMwAC9OZNXnxvB0g43Och24YCBQTGO54KP9jU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717048116; c=relaxed/simple;
	bh=yaZv0Y+PLZ3MirOVOMgLbfc2DGi+feG0RwrBUkXS868=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ReTXtszoJLjbmhNIxhjLsiOH9TfkYvCOE3mRLLUZ0ndNBfBsZElrvaAPidUAYr9XR/KfQtDwyfqQWTuc8s+zFIiVvQCcFIQguxst8J9g3MV0aoB64emDJ9l/iHmVSD+f8twnoOC795LtuX+zmiaNQoOV+hCeRBrVKC0Npy+LuVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bSV05/VK; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717048115; x=1748584115;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yaZv0Y+PLZ3MirOVOMgLbfc2DGi+feG0RwrBUkXS868=;
  b=bSV05/VKqtShejR6va40OmbNjrYGlI/fbDEv8zrg63/bKiTgzOy1Xm5c
   iYqhupORDUHb5REkDIn8HVJhYMu/GERjT1bRnfjMJU/J4T1rHJWATqMGx
   jKFDUxoHovnugvykuxcrg4IukVUoXLGlGiqSZerGNMkATvgvROmG0iplE
   pGPFNEj0Uctj8qLJjYI6qPXUlq8H8Qx1ry9pVQGlaNHvhDx2kPnkPn8JM
   g6uDh8UOZfpg2Ca05/3kjeIPs7OdYbfThDvqVgMqV4UcRncWEXqRRKFL1
   QeYQz6dVLto9vEayBdDEcq6MI4rLMJjOhj4XrqZc0a126dRJaU2wS8Omf
   w==;
X-CSE-ConnectionGUID: yvJ1PHn5QAyPyfmP8Y2DNQ==
X-CSE-MsgGUID: bf97qDDMTSy+kHya0NCiwQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="24917781"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="24917781"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 22:48:34 -0700
X-CSE-ConnectionGUID: otKM2fomQ66JRasoD4bYJQ==
X-CSE-MsgGUID: Lo8tN2avTk6brpDV/ebl7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="40130141"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 May 2024 22:48:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 22:48:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 22:48:33 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 22:48:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W12+JTjttI9dpOYNS5FsIdgwycyUayG84lPzwBmEIyxp/zpDPKBOaHiE/qxE1whCtD/g3bn+WEzc+CDwD8oeIRSmrFb+DOtBO0n2/NyaZi43qbhBCK+9fAdC+Ntowa38EWyK93lYCoOCqzl/0yd1FDJurP0h4X1yv9Pe5ys/8n6CHKEZabXzKCBf5gYThaq3nVy9PFS5x8ppz83Du4OiWsRjhLSPdH1RayQh+EwGa96fzWSpGbZfA8opV/KEolmegS12DjiJhfjKbsOv/cpUjnl1GtkCvAMm6OrCeCQP2dbxshKD2+ra2ZyJZIexgzegSBHWz1M419QLiS706Yx+5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TjNK0t7XpwBnyObtiVZ5JVxNURgLAfnFhb0W/+mco4=;
 b=V00/X+20iqncO3puq1L07Yu4dp7iDXLnyYV7dAw9l47J7piENZbJjjScF0X7EregrV/g31OGMDlRl6Vk1WiiIw7sK6QqAlvo2YPzlyi79qn/S5orx6jb56go1FIfZDQcfJpy7fPSljv73dX663JBDczJvT8aZUlH2YYTZdGRHiXhrF+oobF0yTJKHGGx4eJb3wZ3QYJEOBW97HwM0zF5InEl+PqmAVB1h1vCOPF9TXto4CaGw8RFeBcx4r5xMsFP2XQliuN80PYEoAV/44yyISC4RPYCFaPEeCKFnntSwTRhz4hBeRp8xtGv5T+BnlIx71pQmXXvO3sIABWnd+ThVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 SJ0PR11MB4991.namprd11.prod.outlook.com (2603:10b6:a03:2df::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.17; Thu, 30 May 2024 05:48:30 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842%4]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 05:48:30 +0000
From: "Ng, Boon Khai" <boon.khai.ng@intel.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
	<joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Ang, Tien Sung" <tien.sung.ang@intel.com>,
	"G Thomas, Rohan" <rohan.g.thomas@intel.com>, "Looi, Hong Aun"
	<hong.aun.looi@intel.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>
Subject: RE: [Enable Designware XGMAC VLAN Stripping Feature v2 1/1] net:
 stmmac: dwxgmac2: Add support for HW-accelerated VLAN Stripping
Thread-Topic: [Enable Designware XGMAC VLAN Stripping Feature v2 1/1] net:
 stmmac: dwxgmac2: Add support for HW-accelerated VLAN Stripping
Thread-Index: AQHasBkLCj07Z540QUGXqLg1tlacPLGrb/8AgAB3OtCAALcdgIACos0A
Date: Thu, 30 May 2024 05:48:30 +0000
Message-ID: <DM8PR11MB5751194374C75EC5D5889D6AC1F32@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20240527093339.30883-1-boon.khai.ng@intel.com>
 <20240527093339.30883-2-boon.khai.ng@intel.com>
 <48176576-e1d2-4c45-967a-91cabb982a21@lunn.ch>
 <DM8PR11MB5751469FAA2B01EB6CEB7B50C1F12@DM8PR11MB5751.namprd11.prod.outlook.com>
 <48673551-cada-4194-865f-bc04c1e19c29@lunn.ch>
In-Reply-To: <48673551-cada-4194-865f-bc04c1e19c29@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|SJ0PR11MB4991:EE_
x-ms-office365-filtering-correlation-id: f60a8003-973f-4e4d-1ea9-08dc806c22a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?iDUrntGocTGa5ueeKfRdj0WSDtV3uQvcV+kW5hrFCor6CSZOMqSxsh+4yetN?=
 =?us-ascii?Q?f9npcHuEDNApuUTN7JUo2NaXFmzAPiJcz0ZBtvZkfrogg2KiZ/lA+C2Ltu1q?=
 =?us-ascii?Q?RXPw9nHyc11N1Ur5Ikk9CgSTGH2PRGU42uFEebLv7DBM2VwytxesU+vVizWU?=
 =?us-ascii?Q?3isA5DYYk1w8NixUmXz09QydwricioBNqCsakcCIjy7HBLtkdDL+P/Y7r77l?=
 =?us-ascii?Q?hVPRL/cMi07ykxJpVbQp6L1jc3baXLirT7n4YlXNTfiTwjGM+scFVnMJe7lJ?=
 =?us-ascii?Q?rCBDSEwb8MgqJ9yH9PYP94VWvCVjv7sxhOxwMT+PShyGpj3QdFHVtP3pHPRp?=
 =?us-ascii?Q?Me1wAGhA8aVDxbn1OMi2L85+gVo1pt8G39LUpTlgn9tt80jg+UnZGc7L0KgK?=
 =?us-ascii?Q?dtbWGJ0y8nIRdpxUAs+d/3+Me2wA189BUlXPQVBZH+l3/BQZCfPC72O47BJW?=
 =?us-ascii?Q?m+ZkjAq8hsP4U8dZoVzZWbtfe2jxf1h/m7NiMqoZkqqwqvGsD1G0EXD5XmGr?=
 =?us-ascii?Q?zROxqykSPEQs3OGt2eN9NdUtkmu2TPae5zD7iyN0YyZZKKAMy/vYBSbC5MUm?=
 =?us-ascii?Q?zTxX2t5VUHCsOag1Wip4SzwKDe+gSazzVk/e3hdFMzQxJA4CmENcYUslkN1z?=
 =?us-ascii?Q?v30juGtJ5hPlehXmu6alhEoIWrNyrIMgIvyzZlvS23g2g0Zx4IqE2UuynjHL?=
 =?us-ascii?Q?ignkDnYenz/y3IEPNEUni5NC1I6IvjpMs+exQ7sz3pmyAVglk/o7UBcEsBBP?=
 =?us-ascii?Q?xq+n0+FJ/d2GduoYXZXtZkFOGhoZvOopmWcYeIqRTIKbQHpT9lNr8mfs0pW9?=
 =?us-ascii?Q?7Tc4lxPnUWo3IXWpnxvdKP2uvj6zgPN9G6gFsUfDVW2ulMoNy7X0YUMis1em?=
 =?us-ascii?Q?BlNQ/DVbgSpzJr0PiqC0IeDM2mW1ps25OED6MnuJTx6JQEvV5HgCN5nWixtL?=
 =?us-ascii?Q?3w7vxW8LGFmr3jeEGJ2C3EuZaZFCqxXLARuL4DCWOhd8SKjaFCm/zSLWAhEW?=
 =?us-ascii?Q?AT1c4diaNQRbufOlK8FAfpTLsVXJhNtTgtlIl9uE/7axb/FgnTfjVYjchdxr?=
 =?us-ascii?Q?Z2Fm68G0dcCbWYgLhxDwjo4QZrH23+Q26qW6gOSNFBpLZx1+z/NwdCQE0Jek?=
 =?us-ascii?Q?tQL/mQNvPNPNZS8dskIgGHINlZOvvqI5lCM+SiB7bGCJn4pnOBc6jYWbDV0V?=
 =?us-ascii?Q?b5WMBClbpMxuigadlC7NhWUP6VaJfFzn61Ov+tLyTcRoLbA7mGcKEh4gqM4K?=
 =?us-ascii?Q?Zerfw1gHM983ZAuk0w/eIlV/lvc0WKbDyvn9AdqqJ96MHmguG5zHYBQ5M6ws?=
 =?us-ascii?Q?HssNdkWDswpDzuV6/UOVlGw6lPHpTxV4Zs6GgXF4T7ldow=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bvkVTP6kFeUf5Gw0al+6A4daCC66Zs5AyalNzytwaMmriHt8M3bRxeiolrv7?=
 =?us-ascii?Q?8WcnWH5s/QNzuRpcHKlEcKcn9fZjZbf9EkKJMYM534YWmkGIOetQBltiP6sM?=
 =?us-ascii?Q?lUpQSiA24z+zcF5FoOt5FsCo1bxpzCktye2xueG7gAQbvsDiVzsLns41lF3y?=
 =?us-ascii?Q?Q+j82CPZbCwVHBkCbxcME7W8FIWe80uO9Y4krvDcebIi7uPv7o6OHLfmJFWc?=
 =?us-ascii?Q?Ep+ZV5UcpJF2ECTEC5AYUN0beYJqBZHTqEQ3uvY0FIpXiMp5kVcQkY69mkW4?=
 =?us-ascii?Q?ugaGKfQTpNJ77r4muxCUMtZL6PQlf/+O9eB8KsAG74w5VBGJ0gNLzJrt/gJS?=
 =?us-ascii?Q?XjjfBEMaCAu9gL1giZxUj9zP25eLlKCH80XKK3l9q38GrkrBKuLP4tr2E/47?=
 =?us-ascii?Q?xOGEj/R4Lf+bElpD4pTc3m27GkyKTcHykgqGQoAxjBa5kSQz7fiv/iYi8ae/?=
 =?us-ascii?Q?rOPjz7rk4uO/jACHdMgrumDLS23TzGQsf2aPrNJhespFrFRuj7kjgYk9bLp8?=
 =?us-ascii?Q?+Bd8QkFlfrNzY8V4jt7xGsSj0Gcj2FCRYsdsZh2bH6ulL5Kjh9ZYMYoBxxZN?=
 =?us-ascii?Q?0AJ0OoqsNSnggk0tPBphiMlNgkV26d+N10HDAjIYK6/SaERFp9d6Yos7I00a?=
 =?us-ascii?Q?s5uGMTDHx9rIaEO1drkdSbnFo9Egupme/6pNh1C3tBRoQ9WYREcTu7T/pNSZ?=
 =?us-ascii?Q?uS56khR+sPoIpPWzyz8zyjRE+lSJYVCqPMoNOX0nI9QGlYeJECQinZ8ZR/x3?=
 =?us-ascii?Q?k1uY2ZG0WH+Oyv6hLAXJTKvutE/xu165o9GzWk9YkrcC5HTpvlfG/ssKTvjc?=
 =?us-ascii?Q?iRh1K/ND1r/wg6B+n9cCxz9z/Ydcvx3PqdPuhaxUgsPRUjfiOzKzOLeRjhzh?=
 =?us-ascii?Q?RrKlSwhSCIARc46Gf6q+2RCBOae0XWmBEJy/5SeJygiUiyMVrtliUyXkV13e?=
 =?us-ascii?Q?NfF4JdFzQkC4z7PtIqIAnRwGFPWnbXSFgnVJIvY5vqLSOAHKQfMeLWXiZaO2?=
 =?us-ascii?Q?/vhHQi6YHwLTuBNci4QwW8EJ+gwyY8iZ4EYxuVd8uk4xDLcxyNlmVsFpucqh?=
 =?us-ascii?Q?R7yDX6xubcDHOygiJ4ezypavESy/k8CFQDznQD1uoGSO/YHRpeAJGq/1cFAw?=
 =?us-ascii?Q?4dNMgmm3vUQIKNVtXha8gsaHtxTvAtLps/hwvzxAj9johUu4SWyJAvysZTyT?=
 =?us-ascii?Q?Y8k1xI09+89WnAlveHLBYoUWzw/0eRTFDYg6uoIl5Kn0+WJCC6wz25D4nwlW?=
 =?us-ascii?Q?Vo6/93hopGlkc5H8ZZ1y100JbhCpKn2MIYTDKQt7jfL2HwIogNz3FskTBRvC?=
 =?us-ascii?Q?cYeifD+z/Q9FWnrDAsfgWPr2A6aKMQ+eEMhzbnQtfKYvRFd7NFXxmWkerj9i?=
 =?us-ascii?Q?0gD49EX/qdg2m+sRGSTXBycc8lJtLQ/9/qJQkXNtmVfKuFUqkuH9ePOTQg/D?=
 =?us-ascii?Q?BSZXACbWVy+DHQr0y5ENgDVBAMAcX5pLfIEOY72Lby9YowJ41h4PhOh+OikP?=
 =?us-ascii?Q?2T/mFECf3t29xrDlO4xOjeMvzeacPz0HalCRe2AJ1s99hPd8O7nBcqbpy2nV?=
 =?us-ascii?Q?bql5dltFCWtzdSZs/yseYlia+HN2q72avjPpmxXSsJBJPW0Ul2WMeSdQcEYz?=
 =?us-ascii?Q?ynZ41EKor9g4433ls+AXpPb6LaWd70J/bmERVO5CCxPP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f60a8003-973f-4e4d-1ea9-08dc806c22a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 05:48:30.5931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tn391YElnsOYJCoXjeSjL1kNhf7JkVLeijB72vqHCEv+L2gU6ZblCHpodSBvQg70e0Oylycdbd9Y+xgfH90bpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4991
X-OriginatorOrg: intel.com

>=20
> It is well know this driver is a mess. I just wanted to check you are not=
 adding
> to be mess by simply cut/pasting rather than refactoring code.
>

Okay sure Andrew, will take note on this.

=20
>=20
> static void dwmac4_rx_hw_vlan(struct mac_device_info *hw,
>                               struct dma_desc *rx_desc, struct sk_buff *s=
kb) {
>         if (hw->desc->get_rx_vlan_valid(rx_desc)) {
>                 u16 vid =3D hw->desc->get_rx_vlan_tci(rx_desc);
>=20
>                 __vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vid);
>         }
> }
>=20
> Looks identical to me.

Yes, some of the functions are identical, the driver has been divided=20
into dwmac4_core.c and dwxgmac2_core.c initially, so to enable the
rx_hw_vlan, it is porting from dwmac4_core to dwxgmac2_core.
 =20
> The basic flow is the same. Lets look at the #defines:
>=20
Right, the basic flow is direct copy and paste, and only the function
name is updated from dwmac4 to dwxgmac2.

> +#define XGMAC_VLAN_TAG_STRIP_NONE
> 	FIELD_PREP(XGMAC_VLAN_TAG_CTRL_EVLS_MASK, 0x0)
> +#define XGMAC_VLAN_TAG_STRIP_PASS
> 	FIELD_PREP(XGMAC_VLAN_TAG_CTRL_EVLS_MASK, 0x1)
> +#define XGMAC_VLAN_TAG_STRIP_FAIL
> 	FIELD_PREP(XGMAC_VLAN_TAG_CTRL_EVLS_MASK, 0x2)
> +#define XGMAC_VLAN_TAG_STRIP_ALL
> 	FIELD_PREP(XGMAC_VLAN_TAG_CTRL_EVLS_MASK, 0x3)
> #define GMAC_VLAN_TAG_STRIP_NONE        (0x0 <<
> GMAC_VLAN_TAG_CTRL_EVLS_SHIFT)
> #define GMAC_VLAN_TAG_STRIP_PASS        (0x1 <<
> GMAC_VLAN_TAG_CTRL_EVLS_SHIFT)
> #define GMAC_VLAN_TAG_STRIP_FAIL        (0x2 <<
> GMAC_VLAN_TAG_CTRL_EVLS_SHIFT)
> #define GMAC_VLAN_TAG_STRIP_ALL         (0x3 <<
> GMAC_VLAN_TAG_CTRL_EVLS_SHIFT)
>=20
> This is less obvious a straight cut/paste, but they are in fact identical=
.
>=20

This was Ilpo suggestion to use Field prep and Field get instead.

> #define GMAC_VLAN_TAG_CTRL_EVLRXS       BIT(24)
> #define XGMAC_VLAN_TAG_CTRL_EVLRXS	BIT(24)
>=20
> So this also looks identical to me, but maybe i'm missing something subtl=
e.
>=20

For VLAN register mapping, they don't have much different between
The dwmac4 and dwxgmac2, but the descriptor of getting the
VLAN id and VLAN packet is valid is a little bit different.

> +static inline bool dwxgmac2_wrback_get_rx_vlan_valid(struct dma_desc
> +*p) {
> +	u32 et_lt;
> +
> +	et_lt =3D FIELD_GET(XGMAC_RDES3_ET_LT, le32_to_cpu(p->des3));
> +
> +	return et_lt >=3D XGMAC_ET_LT_VLAN_STAG &&
> +	       et_lt <=3D XGMAC_ET_LT_DVLAN_STAG_CTAG; }
>=20
> static bool dwmac4_wrback_get_rx_vlan_valid(struct dma_desc *p) {
>         return ((le32_to_cpu(p->des3) & RDES3_LAST_DESCRIPTOR) &&
>                 (le32_to_cpu(p->des3) & RDES3_RDES0_VALID)); }
>=20
> #define RDES3_RDES0_VALID		BIT(25)
> #define RDES3_LAST_DESCRIPTOR		BIT(28)
>=20
> #define XGMAC_RDES3_ET_LT		GENMASK(19, 16)
> +#define XGMAC_ET_LT_VLAN_STAG		8
> +#define XGMAC_ET_LT_VLAN_CTAG		9
> +#define XGMAC_ET_LT_DVLAN_CTAG_CTAG	10
>=20
> This does actually look different.
>=20

Yes, this is the part in the descriptor where dwxgmac2 get the vlan  Valid.=
=20
it is described in Designware cores xgmac 10G Ethernet MAC version 3.10a
page 1573.

> Please take a step back and see if you can help clean up some of the mess=
 in
> this driver by refactoring bits of identical code, rather than copy/pasti=
ng it.
>=20

Appreciate if you could help to point out which part that I have to cleanup=
?
Do you mean I should combine the identical part between dwmac4_core.c
and dwxgmac2_core.c? or I should update the part that looks different and
make them the same?

Regards,
Boon Khai

