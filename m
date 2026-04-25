Return-Path: <netdev+bounces-281088-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMadIfIO7GktUAAAu9opvQ
	(envelope-from <netdev+bounces-281088-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 02:46:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0650D4644D6
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 02:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4422300D734
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 00:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA161A0BE0;
	Sat, 25 Apr 2026 00:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ep3mBV2Q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AFC208D0;
	Sat, 25 Apr 2026 00:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777078000; cv=fail; b=MmgpyY2QztWmZh/9wVGnewpctoVpVJNuI2BJsvXUzFY3gggm3kAHUfTV+3zLbsSNR+gGp+9RuoPAI+MfFjVj7dzTHWwFxia984uOboYCzgxEnVWYYIGZM8xsLKkMK+TRvVXtEtLqjS1bIekt75karmaysidd9Gtt3RIyV+rBjds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777078000; c=relaxed/simple;
	bh=nNNPulpGDXutWdaXSVtQkUTZthwqly6gqKXlM6316uk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eupcy1+Acdnhjt5QYdyf4TsCxjp4yE104HtBRkGXgC+bZ/uMprOuA2YxrpLePO1uXpZmdlBNSij7SsipElLpHBtrGpco6xl7getnrh3+6uV43U1DY54zqcuqJSRt408b6tdiYK6i8saO+HggaK9g8d6HUBIMFY3y9mKp3ys6eo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ep3mBV2Q; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777077998; x=1808613998;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nNNPulpGDXutWdaXSVtQkUTZthwqly6gqKXlM6316uk=;
  b=Ep3mBV2QfKdLVdpqe79EMCbQmAioYSxCUJm3bmAL4jFK8m2Bm5d5Z0gU
   1ii2qXk2w5T2vTtZK7eeIaMA0909Rk6PwhWdrTVAM+Kegz9y0KqAy895L
   EM/tranBtzUGgWH1MDx50Fd6YGaHci0UoPDwZCxHckZrv8aEgY9pWznSM
   ARNMjHmO5+AGUpi4iya3dPZV/MR51fSKGwUyfmUq4Jac0nt08mVAMuFWg
   w3SVD2/Z6iY24iSnp0K1aW4Gy5PylSYmyfQ6ikDHLLSDwiKpgpetF8rPx
   8irgMXI2zedp9WxK5zVLRa3sa3gS38qZh/1cW9vOvgFtT4Vk/DWks3g7E
   w==;
X-CSE-ConnectionGUID: wOkhhHwYTWeFeWm5Z5tFaw==
X-CSE-MsgGUID: 92uPqWAXQLW7j/MmNGaKzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11766"; a="81922986"
X-IronPort-AV: E=Sophos;i="6.23,197,1770624000"; 
   d="scan'208";a="81922986"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 17:46:37 -0700
X-CSE-ConnectionGUID: YpVAW5iiSZafdw08O9puhA==
X-CSE-MsgGUID: jrNrUCjtRAGlgl9EB7hhfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,197,1770624000"; 
   d="scan'208";a="237059557"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 17:46:37 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 24 Apr 2026 17:46:36 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 24 Apr 2026 17:46:36 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.58) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 24 Apr 2026 17:46:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PYXdPYcKy/TjVgaK984Y6homRfzoWjQof8Stg2O6mwaMPaGs5FH2Xx59VY5n2f84EbX8eb1y+ygykdYQIZQGq4dFwW4NiGXvDQ3aGqKa6XNy4ld3SViqbe+eWR5tLaE/w5QIg731Em4UjmpMLs6MIy+6UYgpqrG5YSOA4OgZ1Xqas4w9XNhA10ttaq2aN0r0mt8R22whGbwykrmn+4ey7p9r0J3jz1jujaYg4+SpLOrWxFddpx8RzJakXKCpQwbUaAswFpU0OYU5HDszjG6u6euyWbcRmn3hcgl32hnfV6m1KoqDIv0PuvgmOL3xFXstGm1B/FdiRAwOPzHx+vbD/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEyfbMNp5MmY65wsJx10lGwHabrQXKUaL84wcYt959g=;
 b=Eg9wgSQT4XQZx/p4BFSE+nR6nmpMfOG+iBYnRGddDfXeiXATszh/H0X3BDmDftFRIfzVaBnd2fThATH9SkSMl3Ql/53Ytjgbl54SyPW0llxvCO5LCjBMp6GKo74CBE9d805k9qLjA9O9PLlZYUoVmnzCbD0KR9vKO9vWKmAMssvHenDzwRyjBHvdarY8m9qe5EYOQ462kcZddxmXztggJAPki6A1NDW5rnFCImoqR+gzLy5jFo4LBaESS54pNizt711IyTO60QOSWrDLGYHH9vIXcsoraY/xvFm4eaKD8t3zbaKBguscgYJP+LCsR3eYridC4nWEVWlXvYIdMC9WLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by CH3PR11MB8415.namprd11.prod.outlook.com (2603:10b6:610:17b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Sat, 25 Apr
 2026 00:46:28 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.20.9846.011; Sat, 25 Apr 2026
 00:46:27 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Eric Dumazet
	<edumazet@google.com>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, Simon Horman
	<horms@kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2] ice: fix SMA and U.FL pin
 state changes affecting paired pin
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2] ice: fix SMA and U.FL pin
 state changes affecting paired pin
Thread-Index: AQHcx0gPU2o1QMvej06+ogp452EDY7XvCwGA
Date: Sat, 25 Apr 2026 00:46:27 +0000
Message-ID: <LV1PR11MB8790E920167A4D440349980890282@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260408110504.1032879-1-poros@redhat.com>
In-Reply-To: <20260408110504.1032879-1-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|CH3PR11MB8415:EE_
x-ms-office365-filtering-correlation-id: 961f504e-eccf-4663-1bfe-08dea26415cc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info: MIhWb6W7K7SIxOV1+ExnQ47bRuefRj56L/MD6iJVBZfQRLfUbnpmGNBjStFINAhyZeH4wQSwVTlA/Hczktd0bOVCPBZGZz66fDNPrgVzFZz2ynsJZavn7IdQV/hP4bBE2s94YI+2T6KgrLOj6asOVZKbrVo3i0Efe33tXtHZqBntXyAT3CyX8i5tCGi+ZjYVRliVxvw/wwMThS972e/ZZQrABZ89rnmqugevv+8nJc7+Gg9hhy1XnqPZq6vCGckCSKzw4I3gNgh+xUdIHxDcJpUFGeeDuz4Vn9eDKZDew22n8BjRPDu6asWANsbOsFJHc7qykCoWIcIzN2gBqqlw6c+Gua0fUvpSmJIYBo0Hf0cTZmjBubFTd9HbFjmQ+V9iFK1CTHsjGaKhlLdk9FSPTN+YPjVkhf92X56UGmEhHaK+FYzAdMKjlESlXqMl1fRJxQ1jVyZ7tOfYVqA8B3bcFBRNQgIVi3oT5auNDXU1OX9d2YJ2nQGIBg6EKmze1VhrCk2FGKTmBxBnKpbHmhzz2HOtmNY8lQ60bZCUMr1DdkIbw6qR2XUqhF2FHtJnHFPULpKT6akgvfLuZq4hMzaY07EH3DgSRhvM8nPcEzFnGokiZlHmfevbhtu3XWSVJ7L6JD79FWH/y5aVu+oOyv96fzdO6TrNTG2eKP36Lf4Hr1g9ec99UsWBdIkVWtqgZZPsBoQjLMIcbqnEmXcwNUsJMD610ROOp5hAjtD1VDucEXNZXh4wHcQWZQaHKtwTM1HpPCa+beLL40Ap6VExhsMpeu716WafwEqtV2dsibAwAZ0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5wuYCWHJpRsMVYMxS6qYeITV9NxK4PQhQ6SakylC4+bHR2Q8bp4JxZu80hGq?=
 =?us-ascii?Q?U0upzMFG4YLnXItlac1+BYhe0T2N5Xfxy3QboMMBn8xaxnBUEQqyBFpCwAzB?=
 =?us-ascii?Q?AkCi3VyzjOqL/SOpYHqoXWDmG+HkKyXFkApYZbNKbXwREOiYaTF59F7Psl9g?=
 =?us-ascii?Q?mxmtoVO7+Qn8GFAD8zvPZ56cfvGEkUYh7pFzWeNe8pfnb4FcuLYc5TK9tEuI?=
 =?us-ascii?Q?teTMoabLR0wz3ygh8bOiFEqNbrL6HAdnvm2WguYwX9H4lagT+bL+pgH/aTJz?=
 =?us-ascii?Q?oHMZ+awj53YIu0AxKG3EN96dI8y6P8O3XjIdbbo+3vns1tJkFIUefQQ/qsHC?=
 =?us-ascii?Q?HjewPhV/WTEEkBO1PRQhvqxLjjOCZP6gtBvI3nxVAuAgM9TgTd2nnbqYyPzp?=
 =?us-ascii?Q?JjXEmAVCsxZqhexjMbjqF6bxFQt2ctocWDDsAButb02w6aHsmeyLI6cqU7Tv?=
 =?us-ascii?Q?PmeDOQ43H3O/hV8RLd8udiFT5x2k36v26DoVPSAYQOU1nGQR0+S0FSFiihWK?=
 =?us-ascii?Q?5VUOHGGLpdRrylchp46qt7d0vCZxGiK6JDkLOx3JHJsWgMPh153oEMWDWRtB?=
 =?us-ascii?Q?+9/eL0Dw0vpa2n99tn8mw1pz9LaF8rUj1HukFuuWdm6YQ1NXgzBJIJB+OHi7?=
 =?us-ascii?Q?90tGoZr2ETs10cXngPCFDoxQ4vvfg2R/INR+ULFbnPCqrcQAgm/rcK6lOr6A?=
 =?us-ascii?Q?2A2O/b14nQ82h28/tsp2Ugce3LRQx4SnnfnUC5O1Ea77At9XfBiS8e9R41WR?=
 =?us-ascii?Q?ptTlHSyvhnfN/4FlY26FUPHNs2c7oitLt8qleO5+NkfV3kpPjwzISHp197VC?=
 =?us-ascii?Q?oUWOVEfi481bj9Yw7UXk7MPu7nPPRbYw0J5fYnGlEBi+Fy8eboVkJEYIwNkC?=
 =?us-ascii?Q?xQeTfHNFqnsm0DVSjykmBm7dh4I83+ChiqpHvn+wDnnkvnTBS/NPCuI2RuZ9?=
 =?us-ascii?Q?dv8yvGWL4KdaDtbigg2iPycmhRP7aNwaD3mVDhD73d5rQWn83OaHvePKiDDn?=
 =?us-ascii?Q?tF731Gztfd2lxANhyOF/ysxA6Ck5u6Us9rBDVYHwIysGWqnhLlFL8EpCkdau?=
 =?us-ascii?Q?IEaph9qvAPKvwZ9A4JzS9WOImkLL2sXfxJR11XfGfapKRRkfBANotG9tZl6n?=
 =?us-ascii?Q?Oc+q3yiKMGw/ob831kF/mIMTrn+7H0MnAK7uGqdP45jd//Vgt1nwbIiJ8yoN?=
 =?us-ascii?Q?cg+fe8tOZURXLuySslP7EZhNAd+Um9ygutbhtRBReYxU5210r/jVrezg53Us?=
 =?us-ascii?Q?wIXGxUod6d+ug7upYCOozXuly4FmNxu1qDHlnVff2hQmjOuXOJOi5BMi8ND2?=
 =?us-ascii?Q?SOqK1xg/YZUNYfb+ES/IAluONm2RE5zHuoJSPU5asB3ASH0PF7jU3E+vUPB0?=
 =?us-ascii?Q?/yExt7oP0ToO8QEBRkhRYiE2WBjXmKMmsdxHRaKwG1aABir7mqciUemjw2zK?=
 =?us-ascii?Q?216tVqXMcP9TjSQqtY8dVRUYRM5ZSGvXeTREf0YJGXyaNAsMCQcW+/IsDC0V?=
 =?us-ascii?Q?uygzlIFJ8sITfjzUzURlAps3C4XmFW1/XDfl9yYnwth2MWpG1z8YJuP4aJQV?=
 =?us-ascii?Q?T2Y5Dqr6xSsNGtcpRRf/8ZUheg+vi+XQL4MqYVldMsMC8Yzc6wGOGzgs8M35?=
 =?us-ascii?Q?poMPs5XZBUqADstSRtTPZv1hVNISDmgq4ULafkSC0OkiH9puQkaGsNEOvmHQ?=
 =?us-ascii?Q?qBHzMeOyB19yuwGMZ+/IGzWx1o1/0ZInDT6oZghHS1yeaxZyGZ4BlcfYt3l1?=
 =?us-ascii?Q?dWjxY2u+ig=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HMIAA9riq/0HOftUp8U4zuVlBJ1m9BNVaoNJnIdgYEq8Qc5AKccPav08yEPmG8NFyf5NnDU+Rd5yNDIhdR47rrbz6TnnKgi1LQU8ApKd5oITcyP7boSsiXTQ1qUYY0nACP8SeeFnai3qFICUbKEEVpAr6OH/HZ85DrGlx/Nv2ri5wbmUQc/QQ5z+XuZVtSXh0gchLZno4IxZX5U8dfKMjtSxzeUpLdGmcut6nIddpc63yL6PpCMbOGxMB0/HhAc85CQP/eUnjL/T/g8/6t484y+zr9BZgXwL4pJM/K8q7bu+i++CHWkVLgwkkp/sVpDTHd8+cur/sOm4UyayCZF+XQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 961f504e-eccf-4663-1bfe-08dea26415cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2026 00:46:27.9016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: avZj9nQNgf7iEpCQgR1xpttXWzxOM7PBSpSTTJKIs4jpVvbh6Xdg7j6N4a7ZRzHjmgxGikWiuN+m23e+Cl8z0Thd+2AHk883+wZ43hcnODQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8415
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 0650D4644D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281088-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.nowlin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of P=
etr Oros
> Sent: Wednesday, April 8, 2026 4:05 AM
> To: netdev@vger.kernel.org
> Cc: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Eric Dumazet <edu=
mazet@google.com>; Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>; =
Andrew Lunn <andrew+netdev@lunn.ch>; Nguyen,=20
> Anthony L <anthony.l.nguyen@intel.com>; Simon Horman <horms@kernel.org>; =
intel-wired-lan@lists.osuosl.org; Jakub Kicinski <kuba@kernel.org>; Paolo A=
beni <pabeni@redhat.com>; David S. Miller=20
> <davem@davemloft.net>; linux-kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-net v2] ice: fix SMA and U.FL pin s=
tate changes affecting paired pin
>=20
> SMA and U.FL pins share physical signal paths in pairs (SMA1/U.FL1 and
> SMA2/U.FL2) controlled by the PCA9575 GPIO expander.  Each pair can only =
have one active pin at a time: SMA1 output and U.FL1 output share the same =
CGU output, SMA2 input and U.FL2 input share the=20
> same CGU input.  The PCA9575 register bits determine which connector in e=
ach pair owns the signal path.
>=20
> The driver does not account for this pairing in two places:
>=20
> ice_dpll_ufl_pin_state_set() modifies PCA9575 bits and disables the backi=
ng CGU pin without checking whether the U.FL pin is currently active.  Disc=
onnecting an already inactive U.FL pin flips bits that the=20
> paired SMA pin relies on, breaking its connection.
>=20
> ice_dpll_sma_direction_set() does not propagate direction changes to the =
paired U.FL pin.  For SMA2/U.FL2 the ICE_SMA2_UFL2_RX_DIS bit is never mana=
ged, so U.FL2 stays disconnected after SMA2 switches=20
> to output.  For both pairs the backing CGU pin of the U.FL side is never =
enabled when a direction change activates it, so userspace sees the pin as =
disconnected even though the routing is correct.
>=20
> Fix by guarding the U.FL disconnect path against inactive pins and by upd=
ating the paired U.FL pin fully on SMA direction changes: manage ICE_SMA2_U=
FL2_RX_DIS for the SMA2/U.FL2 pair and enable the=20
> backing CGU pin whenever the peer becomes active.
>=20
> Fixes: 2dd5d03c77e2 ("ice: redesign dpll sma/u.fl pins control")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
> v2:
>  - fix ice_dpll_sma_direction_set() to manage ICE_SMA2_UFL2_RX_DIS
>    when SMA2 direction changes
>  - enable paired U.FL backing CGU pin when direction change makes
>    it active, so it reports as connected immediately
>  - (both reported by Intel test on the SMA init and notification
>    patch threads)
> v1: https://lore.kernel.org/all/20260325151050.2081977-1-poros@redhat.com=
/
> ---
>  drivers/net/ethernet/intel/ice/ice_dpll.c | 50 ++++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>

