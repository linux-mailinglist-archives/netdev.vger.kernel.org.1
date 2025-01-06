Return-Path: <netdev+bounces-155595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CD2A0320B
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 22:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30C7C1885C71
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 21:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010F91DFE20;
	Mon,  6 Jan 2025 21:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hyvhSEVe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF0D192D8A
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 21:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736198994; cv=fail; b=k0K+Y1ieDz76ARYC5pt1Pj4dSbP0Meva0YNVv/EgEvqxN69vPauUu5+uEm4Bo1rF/jM2uRtwYYGAFwwBjPQcVcUYY7JHOCtOH05D3tmlblXmV2PwZSrmHeduTSul8ctrS5KWazgYj+w1ReifNQqUEf3PR5u7eql0YB7dn7h7ITw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736198994; c=relaxed/simple;
	bh=IbWYqqdnuWE0oWmRr0o3fFXVqmNh6vumqKQEB2ALnZk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nqHbgZMrWALQeb+jzUmgPsthAKJAFV6nXIJLMwDagB9Z/ns2P43PAvgr2hqb2qGoddUrBnhDCK9+33eNw8PW4vNGhSUNs7JI5jxbMSLvBTRDq6y+mlc5kAkWwv+/Jx5B/krrepie1xIHBNcoIKN3Kdj1YPYCoBvQYETKFucRBUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hyvhSEVe; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736198992; x=1767734992;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IbWYqqdnuWE0oWmRr0o3fFXVqmNh6vumqKQEB2ALnZk=;
  b=hyvhSEVe0rjnecGoDXrOQwxJzu1cSGHluFsWDvZ4wbHAIKmf6gfxYgzB
   +0YAErBsGC7DzYWbd05zaRpIHctKzeha6Wm28f7v8H0BV2IO4FjNJ98Wt
   1Hmukm85KOLEho4FJp0Ck2p1wCdFJMJyzylhSFhWs5VFYqxI0Ksv/Hc84
   BzoMRGKx5lX/Mc5toeE6kr1KiqdCxXIZLMcsMJ1PskxbbYOfhvdZq2rS8
   nMA3U1wWC8Srum58Vfqole/engJRcBmOduKvP5tmhFBDFxLdkJ0WyC46p
   tO5LdQEG9rTCVu8YV3uFmcSZgzd3+IhkxWxtvHj1kmfxd+H8IZHMnwI9E
   A==;
X-CSE-ConnectionGUID: 87Sl6qOlSUS1VdePPVZykA==
X-CSE-MsgGUID: pg1/Noi1RxK21kIy2kCJWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="40035431"
X-IronPort-AV: E=Sophos;i="6.12,293,1728975600"; 
   d="scan'208";a="40035431"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 13:29:52 -0800
X-CSE-ConnectionGUID: LfMtDpRHS+ugzC7mIUIK/A==
X-CSE-MsgGUID: wt4yMGc8Qk6G27imy8Rbpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="139903209"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Jan 2025 13:29:51 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 6 Jan 2025 13:29:51 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 6 Jan 2025 13:29:51 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 6 Jan 2025 13:29:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DjurdgBozDfLiTg62t/pbuMYPtoi7WmKMpEEfEe53O8bv48Zx0X1gGPa45X5UxOZf1bpX9Ox58nrZAGvm4yDQnAwTgZicc9mH0gD/mN7PzwN4GRAZFYyTWtZF5rPt2rlDxffVcyclKwmcFEGCMmJrzjdfPyqUoaAVwfMnEcWtzSRj4AtxE+7XdtDqRn6Dke7iUHW2I7FYmPeN1DjW4MZImswreb3gNbRIEt2GpPSChuLEknu9CFsb6PpzEof6aBm1hS4e875XYL6AObhKHaznorfeDUnFsttzwCAuz6iO/umYwHeVow/phuJcQmxBnkZDmYh9Gk9Y1WekagX8XFKdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mIiEK1P6MehoytyaTeb1mXLz3+/l2EncWzYRLMFZa8=;
 b=WU+mMmSaTdXbUyvOWgaBaxyuGfn5s64W67TfbQV9ybDsrwUiwkohqAXlRZtBgtjdAZzB32Mn4gjLzwDq/+mZQitAifIOkJ0Nv664eY4xgGNcx0oNOcuHgAYrD3gJxXeY+vjVCzntT4bESocnbVPaaZWz+LU4prQCtjCx38DsAL8cEeM3FnrBpob7By0NE87WKWpge7i6FSCl17uOuXkrr5WSZX1s0SbjvhdChyu4ZjRhH/aPXQUsCHlP1ooi6YofNDAoXOk5PKGyQM2jSBrla4GmMB05ndYvB6n0pVvfwA8fXQSaQskIUIEP91BB8cRTMQkIOYdyW6Ke89DYZCJT5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB8162.namprd11.prod.outlook.com (2603:10b6:8:166::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 21:29:44 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8314.018; Mon, 6 Jan 2025
 21:29:44 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "horms@kernel.org"
	<horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
Subject: RE: [PATCH net-next 1/4] net: wangxun: Add support for PTP clock
Thread-Topic: [PATCH net-next 1/4] net: wangxun: Add support for PTP clock
Thread-Index: AQHbXP592WvooA1AlUit7fQ7JWjNQbMKSbww
Date: Mon, 6 Jan 2025 21:29:44 +0000
Message-ID: <CO1PR11MB5089A049124A5DEED5F15A4AD6102@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20250102103026.1982137-1-jiawenwu@trustnetic.com>
 <20250102103026.1982137-2-jiawenwu@trustnetic.com>
In-Reply-To: <20250102103026.1982137-2-jiawenwu@trustnetic.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|DS0PR11MB8162:EE_
x-ms-office365-filtering-correlation-id: 49da5cfd-2aaf-43a5-31e2-08dd2e993d21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?5FPicQvWpc2N3RxwiK9u+pkcGKcJS1vJ9DZZq8LnXD7wPRfij+Nrjf4hnrFO?=
 =?us-ascii?Q?yhbMS+dS2cRHS+MLxTpiqLQbkO6xXDb8rrGO1zbZvpKLnNNo4apzlYTyq5cN?=
 =?us-ascii?Q?kbZG714jpI1d4jPcM2NPIgJ/QPCsLyLA4NBjmF9IQROdS4P8MiAAuoyP09TS?=
 =?us-ascii?Q?ZtLyDL4N8H4VrwE2TQIza+Ws9GodJN3G8aF9QSInND1DHB9gJO1rpk+jPsgv?=
 =?us-ascii?Q?sObv9hWdic1V6/QZW6i34Ve+bXwNNFmBA0ihqHjLjMhxP/bNrStTFVkbC4PW?=
 =?us-ascii?Q?wDQavZ5+7qXlyT0/SWH42cv/f9knZjy/ThqVinTkZ+pDt5JKk2LumPacRd8Y?=
 =?us-ascii?Q?s7Mmd9uFGWUsTwTz/JdrxejwlBKkSabe6fpVaLecfdF68MH6/+CL0OFSKj7m?=
 =?us-ascii?Q?OFv/ouFETPcAVaElS/7bJGNI+P4n70u8NvRC88n2X6cTwVT6V+t5YMTET9ys?=
 =?us-ascii?Q?6e2DwrPOjHud1j9BVOnzpr1vDk8gD5VRfww2lD6rEkdxj85otg+tNNLOoa7b?=
 =?us-ascii?Q?cYUcKEGKgca+bRaPDl2+xDZs60deQzgh2zVKW2N9U//yY31PGsHs6zNvdhx2?=
 =?us-ascii?Q?/aefM2OTm0QNQc1EHBmN6ZeFfIQqzQflRnlulDPjTofF0vfLhmaflZnVrX/7?=
 =?us-ascii?Q?Z283QCI3T6PnRTVl7AlQNwZ5vQ4pxOmZmecj0w+DeZZaqGL7cGZakhFFbHrn?=
 =?us-ascii?Q?D9rJvchpFfZpqkrk1Iq//4SpBSgtWeqXhbF3kscXbQmspff5IO2yNkbmaqGS?=
 =?us-ascii?Q?O595sPyBocVyjXsR+WHTu07Cq7coEUP9QQQJtI9mceunqcpXiFqKJ3z1fNlt?=
 =?us-ascii?Q?w7jxA2GjHQpPLXGhqDGckzgkc6/ykJ/6O8Q9Ap7AjE3xgvE3dw3CAbNNPZNt?=
 =?us-ascii?Q?lE5AtiG+LDbpW1Ed7OJtpDRsCdejCwUmSVz37jaIctHSZUlVp0D2iYUCoAPD?=
 =?us-ascii?Q?/W0CGpM1+F3Y/uHA2vnooAS/SDj2xYIPcvFjv/yAUpvXgune6oQYtj4FD9CG?=
 =?us-ascii?Q?Nhed4ZaBQSXb/+9Cc8NQEx8zW3lNhq1ofboikELRLClwk6K0zm0P42WvQbqL?=
 =?us-ascii?Q?3xnmNU6FNd4e5se3fxFiDkOfrBBJu7Ni9sUO7eQmYtFxjSGgMObTG6Vy8n6W?=
 =?us-ascii?Q?T9zbd+kB6ytzRT285xvKnAsULyxupx5gepiMjw2398AZyGD4Yh4n8rd9Mq/X?=
 =?us-ascii?Q?vAHctP7SRAy2t0OPbhnsvgt4ua3tvMYYt68HK9OSmFYOc6KnMEspvfbZU2eV?=
 =?us-ascii?Q?ULswmOYcmLPNuAZJYQgF/a7l4MGaA6+DgBq6EOavMTJxfOGOc1Os+oWO3u7p?=
 =?us-ascii?Q?oyaXPi4aTgIhwr6YiwD+GVcN/QKO7px6UuThSZDUNt3az1B/owTYNBUPfHvy?=
 =?us-ascii?Q?lxBZ5hD3chpr62W6J266LhSzaAX1g8qnO/yblkkjqM+NNlB/APlojC/HnMqE?=
 =?us-ascii?Q?CrocyQ7WDCJubvFQ8pJZCmsSCUXXOkqSmB+3MWie3nn9tdxygIUzlA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P9T4X18XGs206fT15zPdUv90zU+mmlu6tHjwOZ6gmIzT1kPGoAvNAAnY0P1B?=
 =?us-ascii?Q?8JxEQwlUBRgVlrzoiwMLQ2zm4uGf0M5HQSG9ypnZvdlLZ16nM5ajBmCKsk+5?=
 =?us-ascii?Q?3oPHl62n6tGrbUta/nlDF2Xf/uY6oB3Ccihew301gX8Wx6HCqphrz2kaWmFi?=
 =?us-ascii?Q?6de0BpvTSB3zSUTB8qknIhy5O2Mve/orqgLo/Ir2wfenD0GFQYXesjdKsJkQ?=
 =?us-ascii?Q?QfKe771P0er6LblcDqi/oxJkhFZZoGW+362IPxxY0j1+wn9LsZp/r0lB3orW?=
 =?us-ascii?Q?Hq74Q1wWjAdIEhgVnV8xjRG0r5xblGJKRzwkAmB9ZkdQ5k8yAHFQUC4hcTt/?=
 =?us-ascii?Q?g5cY76en8MypWYgoDILjjuO5Ee4UvuQ5SLslBYEOrEbJJB7sC2hTvlHeBEGW?=
 =?us-ascii?Q?/Nz2q5hF5sNU4GJjUWJPQ5qWcoIJ6eRM9RWC62BA2QXosHkU7a7NwCuh3UIE?=
 =?us-ascii?Q?E4Jc0kP01w1s7cIBUToyQaGWmoh/eJUdn9Wm8CxBjQ4bNkstYLofnNaiEKWn?=
 =?us-ascii?Q?cGV3K0uQwbrgtYFQ9/O8dxa5IMIQMSgXUlueh3OpjkFGprp2ot7RDaZjitvt?=
 =?us-ascii?Q?vvW8l0UWLeXWcY9rChUYlokfF5obiSjlaxCS9ylk/ke/qV5Gywl9qAyIatX9?=
 =?us-ascii?Q?gZIPIJA3y+25msLKaMJVGKKbtEN2ELUn2XqmQWZ2qwU4DQi7tDtYjJ9CRIKN?=
 =?us-ascii?Q?IBG6ejKC7ABVbddg8s//f/ZoDb1l4TIW2epN086jU83azfa6SD+7kgjq6OEb?=
 =?us-ascii?Q?icKqT9Hdh0+dVhPuCh1GV+PCdGlZVYe8QDHJuyGw/6mKI3HiBjeHJ1pxfHv4?=
 =?us-ascii?Q?a2FzaKUu8tkPRCttSEVEBoMAuLXucd5eWVijpRWrSPL2bMWSPo9Mhvt64rN4?=
 =?us-ascii?Q?UeIi7dwakGNwBkZPlUR3FrxrFCei9magckYsLyJSxSGZq0JbGa2tu1dD/4cr?=
 =?us-ascii?Q?vaphgV909bapjSZwIgRGHgwDeH+sh+6nZ3xfJLaW8jv/+klOq6AOq76HSxxk?=
 =?us-ascii?Q?0O057K2SQ0FmTtk0g3oXqcoBRZPHf0xkFdx9OvHf21kodNmStq4BKxZfNZFi?=
 =?us-ascii?Q?jdZWKQjliWJL1JqeGANk8MsWlLRRMr9afHNcXCgRAOTNMeJew7TpcCQERZxV?=
 =?us-ascii?Q?vQA4UIgxCrnd4S/3TZioXZSacVO17ZCgBCNdy7VUAfq3g1u+FiBw4yE2DviC?=
 =?us-ascii?Q?FXHVuqQvEFnoxK155yeAr7OdRWVVeh6UH1SOuPcf/+ZRZISo6mLiBSniHLX1?=
 =?us-ascii?Q?nYuuYYQmAl2ymqjrdy+U1wbfVM0JA9BJTKzyE8M40/luAV9s++ctQVIyihv1?=
 =?us-ascii?Q?KROOzl25mWuytdvrg173Vzhxc2AhSHIkg/ITNwdt8hRJ5QfP3rGP4cVOKfNb?=
 =?us-ascii?Q?gIrNol1elK9swcEDijXmkYMgYs6zrmsrdFvE7tdeKKyL32ZCcmt6WywLuOWB?=
 =?us-ascii?Q?B8+mw3NoOgVo1Tp+cQbdOSwrhQXQgbkoAw47X2w8gE3jYr4CEbzkmE5EcsXJ?=
 =?us-ascii?Q?E5g4GsEnlg7+0u71ruWuJbicnyp/T6ZVJvxMbW/22xgmjuftbYI6X3LNv9+p?=
 =?us-ascii?Q?9OoapMuVW1I86sE/FdqJjHrWwNYqudnUPOZYeifm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49da5cfd-2aaf-43a5-31e2-08dd2e993d21
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2025 21:29:44.6398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jeGrS9XaemsgwurWBN89Jf/SKyJX+t8MyGSmMrxsAWyM6WTQq0rDPbn0hjAyxcJpWF8ng4GtQRLDW3WwcKrwjmwsapGgIEPLn5qH3NCIQgI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8162
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Jiawen Wu <jiawenwu@trustnetic.com>
> Sent: Thursday, January 2, 2025 2:30 AM
> To: andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; richardcochran@gmail.com;
> linux@armlinux.org.uk; horms@kernel.org; Keller, Jacob E
> <jacob.e.keller@intel.com>; netdev@vger.kernel.org
> Cc: mengyuanlou@net-swift.com; Jiawen Wu <jiawenwu@trustnetic.com>
> Subject: [PATCH net-next 1/4] net: wangxun: Add support for PTP clock
>=20
> Implement support for PTP clock on Wangxun NICs.
>=20
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/Makefile   |   2 +-
>  .../net/ethernet/wangxun/libwx/wx_ethtool.c   |   3 +
>  drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  64 +-
>  drivers/net/ethernet/wangxun/libwx/wx_lib.h   |   1 +
>  drivers/net/ethernet/wangxun/libwx/wx_ptp.c   | 719 ++++++++++++++++++
>  drivers/net/ethernet/wangxun/libwx/wx_ptp.h   |  16 +
>  drivers/net/ethernet/wangxun/libwx/wx_type.h  |  67 ++
>  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   7 +
>  drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c |  10 +
>  .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  10 +
>  .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |   9 +
>  11 files changed, 902 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_ptp.c
>  create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_ptp.h
>=20
> diff --git a/drivers/net/ethernet/wangxun/libwx/Makefile
> b/drivers/net/ethernet/wangxun/libwx/Makefile
> index 42ccd6e4052e..e9f0f1f2309b 100644
> --- a/drivers/net/ethernet/wangxun/libwx/Makefile
> +++ b/drivers/net/ethernet/wangxun/libwx/Makefile
> @@ -4,4 +4,4 @@
>=20
>  obj-$(CONFIG_LIBWX) +=3D libwx.o
>=20
> -libwx-objs :=3D wx_hw.o wx_lib.o wx_ethtool.o
> +libwx-objs :=3D wx_hw.o wx_lib.o wx_ethtool.o wx_ptp.o
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> index abe5921dde02..c4b3b00b0926 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> @@ -41,6 +41,9 @@ static const struct wx_stats wx_gstrings_stats[] =3D {
>  	WX_STAT("rx_csum_offload_good_count", hw_csum_rx_good),
>  	WX_STAT("rx_csum_offload_errors", hw_csum_rx_error),
>  	WX_STAT("alloc_rx_buff_failed", alloc_rx_buff_failed),
> +	WX_STAT("tx_hwtstamp_timeouts", tx_hwtstamp_timeouts),
> +	WX_STAT("tx_hwtstamp_skipped", tx_hwtstamp_skipped),
> +	WX_STAT("rx_hwtstamp_cleared", rx_hwtstamp_cleared),
>  };

I know this is a little old, but didn't we recently introduce a generic eth=
tool interface for PTP statistics? Could you please make sure that interfac=
e is implemented? I think the current policy is that the more specific erro=
rs can still be here, but we should implement the basic standardization ava=
ilable.

Thanks,
Jake

