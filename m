Return-Path: <netdev+bounces-173102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3675BA57445
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 23:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 421807A4C2D
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 21:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E724B1A316A;
	Fri,  7 Mar 2025 22:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PizfEiW2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EF47E9
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 22:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741384854; cv=fail; b=HxSBm7JLZCTM624PbIl4F2K8PfFuIPnWMO2RB6MCG4qm+0xllK0GaIO37OVhawEDJl4ul1my4IIUEaucSkUusM2aosJUYwYTaUu4hTFr+q/BA9khKcjLe9juDr+Qk6Vl9peC9Bh1mTiglGX1zTgSqhKD9S8W0eGqBj6XghH/p9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741384854; c=relaxed/simple;
	bh=MUn0XkFk/pz97QrVDs8hI15uf/wmiOng8KuQRt2Ly9U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EZk97t18n1cw4RJ2ZJu2oFnBDCeVz6M3bkCP/wDOc7cKkcj0LYtvJJ9JrM45egxZnIjyG6h7Rk879r0QUavJpbfJkLhJhznosvUWl2b2/3Qu7jk3kqhypda66JTZ5kVqcTh+jvlGTf7G8DC2ci94Q02qzH0A/HgIa/pRAA1nLrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PizfEiW2; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741384853; x=1772920853;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MUn0XkFk/pz97QrVDs8hI15uf/wmiOng8KuQRt2Ly9U=;
  b=PizfEiW2SOaR0WuZtAcYWFMEC5R2XAen1z9m3IUmE/k8pcpBMwC8W8W9
   RPk5+6WqFe4P+0Y5G/krkGOQDVJZOfHE/9rGccEG10SnBl5eHp23LEmD5
   VH9KfhnoskqyVq5h+lFzr6hVsaTmvbW6U/aYlaeXuzWYmuG//XFYze8ro
   KTASYYLHV8r0snBFvxZmf02t306pX56HwDDck2k/fsqDSZ+Gsjk0V8bwM
   3zZahhRHCQqxB85X9Qx9/kBpcQjAJvR9DmyhcsHkKKi0PicEEDZSkEjrx
   pv3mhY8vSAe501/NRztQTaa51k4v4MsggfVLRSA7HVVDMY4zSBz8xPcsk
   g==;
X-CSE-ConnectionGUID: EXZPyp3QRyesKC2nwQLrWQ==
X-CSE-MsgGUID: 2JOediJzS22SlZB4YxTxuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="45250596"
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="45250596"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 14:00:52 -0800
X-CSE-ConnectionGUID: /aCai3tIRxS6EA7tUZ7Iew==
X-CSE-MsgGUID: 6E/ST3YeSgi6F16/SiDEfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="142670397"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 14:00:52 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 7 Mar 2025 14:00:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 14:00:51 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Mar 2025 14:00:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qb0vb48GXxuSRRVsg7lAcoR6OmAtcY2MV1PHKY3DycWAAoIqZdYVb+/YWoKviXlnNiexhJClfXciPtiKL2GJHRX54nQl/Y6FwWaqT3SIA97WMNAIpJSgca5psfEUMffAkkB0/YmJajMIG8XyWrIBOwPu2Jy4CoQibzgL5okf0J2Db8d76zYZFH6kupwP5DcFMSYiDSD7qEy7UE9FC2/GSb590u5dC8YzpP4+ESQa+XE5IpzTPxD/rk05TQSBohRTFaR+bQnH/EH1OGw+lpxiw3ON5YjOkcM2NnyuXHJhY46v75pwW+wTedq5tlOuRPeTJlPTXIcsD0qr2xUoBJTaYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dR5Mg4uZvRfv7nDo1fHfzQVqzH8YoZccx32TW8yRA74=;
 b=u7LFyCn0TxRS2nVNwf6HSw5KcXbDEVdz+hpOlY/e9WXgSm2Q/cR0MxyrZDRcYEbcj3xxm6iJ14IA+8ceVUAM3W1ZEQOde+MXBJIyavPqYz0sRCqBZA/7oNAzQ3qo52+WrVZKLeucpfTV6JzN2Fn8GOFPfJwPy/zAjzi1a3RkVOrUqnOXQfpIqlVE5DA1kvVL1/+ZXWI8yuHDv4qhQarKQiQ9CWX/ka7h4xJj4ylHCqk2psshkYbI3KaCdvSQje5QgsLa0Uh8L+k5zeC2ycIfjTkATVdmheVWY/90x+H1MiXjBF7GTRe/QYlxsGhviW00uLFUYzsnLADIzTeAqSvd9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7813.namprd11.prod.outlook.com (2603:10b6:208:402::19)
 by MW4PR11MB5912.namprd11.prod.outlook.com (2603:10b6:303:18a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Fri, 7 Mar
 2025 22:00:44 +0000
Received: from IA0PR11MB7813.namprd11.prod.outlook.com
 ([fe80::3799:df24:a514:9db2]) by IA0PR11MB7813.namprd11.prod.outlook.com
 ([fe80::3799:df24:a514:9db2%5]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 22:00:43 +0000
From: "Lokan, JeremiahX J" <jeremiahx.j.lokan@intel.com>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>, "horms@kernel.org"
	<horms@kernel.org>, "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Polchlopek, Mateusz"
	<mateusz.polchlopek@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5] ixgbe: add support for
 thermal sensor event reception
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5] ixgbe: add support for
 thermal sensor event reception
Thread-Index: AQHbh5RMaOB7RTXb70uLLzeRDDXPiLNoR8IQgAABVnA=
Date: Fri, 7 Mar 2025 22:00:43 +0000
Message-ID: <IA0PR11MB781394B4225982A8AED985A0AFD52@IA0PR11MB7813.namprd11.prod.outlook.com>
References: <20250225143355.190469-1-jedrzej.jagielski@intel.com>
 <SJ2PR11MB751819A3836C0055710BCA16A0D52@SJ2PR11MB7518.namprd11.prod.outlook.com>
In-Reply-To: <SJ2PR11MB751819A3836C0055710BCA16A0D52@SJ2PR11MB7518.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7813:EE_|MW4PR11MB5912:EE_
x-ms-office365-filtering-correlation-id: 46653070-fc77-47b1-d49d-08dd5dc38218
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?uavDg5n5qF3e7UWG6HOCrrhzxmtGIRlCKmyMRls6XcBTuSsigDJIAM6Ekb4Z?=
 =?us-ascii?Q?ne2gFX8k+/2To1bwukroB3Z6bqFq7LtkL54FnOH0MocO+r1/O6y+njC/k3ws?=
 =?us-ascii?Q?rHVhk020fx8xCm4WqZa8zNkrkD8NJaFEFJRC7IUHA+BczEvWTESRbv0mrXdJ?=
 =?us-ascii?Q?csKsYlFOmsRO4QrtSy1DTgtDP0RuSQ8skmkmJA7O6CXkTZEfjPwg+vnICJkc?=
 =?us-ascii?Q?lBLWJeD44FsoDTBy2v35D3LHeCEVuMChazkG4rOq6wCWe2BTsBpzMwRanRvR?=
 =?us-ascii?Q?sHn07JY20FgefenT0yayxwt3zoEDq3gVtZ2zpUv8BS0GmSu0TTiiTtxVo+Q/?=
 =?us-ascii?Q?Wt7IjoZTndBHnSAN5jj7+6QkmAWOSwXiuoXcpoBU0kGQ2MOWMzdygmkrZRhj?=
 =?us-ascii?Q?OQb704dXWyFUZ7OqYy/K5muvYf/whXXPcl+NlrnMrYcWsN3hmWUl9m5+a7nL?=
 =?us-ascii?Q?KZD34lc0AldIvxds2KGtMN8BCOU54Ul2ZONvqcHojIsDHMW+lzXSjXNUtW+t?=
 =?us-ascii?Q?VW3sWBJu91EZQtlNHuqCaF061Ous3LLVMBKFUQ9VjLr+VrQzoK1naG+zRk84?=
 =?us-ascii?Q?1/Xnis8XrzTycnNDbPMZczXLR9ju50OgnOrHXgpcGLr4AaBVdqCCUYc/yWcP?=
 =?us-ascii?Q?lpSFWCVVY5wqjLgPFVvsxGI82K1h3KuhApHceyIA7dCCdai9e4qvV0iyIOFj?=
 =?us-ascii?Q?2qHHYI+pw11qhvtw4k0FEKnQvyB26N0PpWOMscH+qiQP+VvesmtHdmE0ige2?=
 =?us-ascii?Q?tr7GeSS0IsZ06fKQpRF6sX/VSERaPvZvXKVNvvT7QQh9HuPYsmpq0l/UC4ZI?=
 =?us-ascii?Q?SRVAh0JwG9z9XRAfxkh9uxgqtmBst6Kzo8vB60KrPVEev4dvXVSDpVgO33r9?=
 =?us-ascii?Q?Ec0oAqApoiO+qinOyh6hZQjC8xkAt26B3h8SlRlig96lTBVIQJzTj+G7bRdT?=
 =?us-ascii?Q?88iZoyDE00wdnWJ/2gyT0U75qNS3BgeQtIjzlJM+7RFNMWa5pEkWy6g/l7R6?=
 =?us-ascii?Q?xaCt1QjqL+gtHwga+PPoc1u4Sl9Eui08jQEmYP2szlJLWX/DBmLcnvzEUUMo?=
 =?us-ascii?Q?0dzAALjZl41pxNHLiJLEYZWWdYPSeWm80QD3lZwq2/JIp5VaIHDErgzDpy76?=
 =?us-ascii?Q?57/8lTdXDiDerkXfGt7UbnAECq02G5c9XpSi6Wh0iNs1yvrz/hPNu0wxPLnC?=
 =?us-ascii?Q?RdG9XZPKFxC0HSjWndd/WsYI+PcWOAfqtxcOS9/8Y9OBo5k1lArePEemDYoC?=
 =?us-ascii?Q?hP/kqY2kwgvE5iHnb1wIBmDYX9hGyOslGhjmh/51QaNniDqP8+WI5CYzRybf?=
 =?us-ascii?Q?dVUZo81w8sdMv9D5NDjA+mBbA4j5tgXGa4hvZg1yJVeiMWgIh1RS8KCZt8D/?=
 =?us-ascii?Q?uhmQGjFjnk/4c3UIeAkvTJFKuqmMpwiZP7Ocde0i/HmvItQa+qLuDlcIHy7g?=
 =?us-ascii?Q?kxfmgNuZ6MuvmjNqdOqr6/X5xaF5YiWd?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7813.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XAHiANyEqKOlAqMuX6r6cG2bGi5XYnBs9niHRhT/DnfWtwK0EO8X35oLCepD?=
 =?us-ascii?Q?q6OSfgBK1riiAMbz0lwRqAWHagGgpeIzR1CAjA4HBI/Kzn+vki/Srl4DWAAV?=
 =?us-ascii?Q?qBuQxZOwlvfHTEZOIiNx2OEG1sUgj/cTwadYlag4rfwr/TnYzOym62DSVkQh?=
 =?us-ascii?Q?EArRo+m4dBCiR4IZlniB8j6xyw6eFb9xNKG/XBlOb4WSSzZ5dLSU27dxNcbS?=
 =?us-ascii?Q?aO2YOk/xZeziEE6XPQ57ZmSZQq7hON5OhobzndJllAoqcy/7r0Uvud170meQ?=
 =?us-ascii?Q?gO/QNtM5r6aPdP+KFf/S97GarWm3ZNfEJAVwTXNMuNx7qLv87RC6I1o39VFd?=
 =?us-ascii?Q?hGTOjZLNzOjHr7uEMaDjXmdg+frvXZ9X0w5/P88n5dnSgwsvEU89xVWuIzVC?=
 =?us-ascii?Q?CLdl/7jPh/aFJXBurV4DRhHCmNH57bGbvhZhTZco21qF3a7gcmdVzkyb6nk/?=
 =?us-ascii?Q?b615roAXjD6IE+cUd69BrFgshKQr+OR4lBv9vdg6eublJ6ueUYjuvwIkssDf?=
 =?us-ascii?Q?CvPJa2ByfqqI5WkBnPZaNFuG7yGftQkUO3xoWzzM069X/qnjuY5GCEMVa4WG?=
 =?us-ascii?Q?AHuFQM017aesfKLGLIqzEU3yTry1J/jNRHWM4/Nf+F5kMrdqJeYjwIH2XrGJ?=
 =?us-ascii?Q?mAEVilc+MvdpqpThN8XBtAjH/3VLlC761sL43l2M/ZFq9a4WynDvnOMxS9jl?=
 =?us-ascii?Q?eU7ZYYRj79nIY8SJfYvc+StCuWcgawvKHfOxAJn7joCrvaTDvdlrCnygPg5l?=
 =?us-ascii?Q?rDz0vlFBVdl/fEYPxsfWudkDMAY3hELGJ7AE79fvGonKsMMyLMK0nLjvXXub?=
 =?us-ascii?Q?ixlxzxkYMbtfxG8VjIa+9e4UMjAk1zfw0cNdJ/i0g8rnv48yMgbM+GmHimB4?=
 =?us-ascii?Q?ATnqT0SwgAv6CwchbzgwNgXKtad5g38ccsk+EgsHhFXfDc0OAwYKAvl4Bmcg?=
 =?us-ascii?Q?GXxLX6wePoQACBmYFqdKQTfRj3Fn48ANkFPnyYRPkGk/VznuK2HO343HvtML?=
 =?us-ascii?Q?BgLL8ZLNW8nFwCtTMt9xeybGAcrEOfb+O09G0dXN4iFp0V6xJ+DIw50OSIHt?=
 =?us-ascii?Q?RUK8nzWVkfDwOkC3MZdOz8mznQyzSxNMMupSri7Vm3QpnL+F3YzR0zxxCVjG?=
 =?us-ascii?Q?jORaZac7++OYyQ4jvyOiTaFuxYCMS2JgBWPrsVJkXf7DdjZXz/V2yilvYY9y?=
 =?us-ascii?Q?NXUqKrI0EcdvqoUyth9FyKWomQ+A789DGQWqEa6RqxqOSIDkixaWM2uyLmcg?=
 =?us-ascii?Q?KVNNJruRxlZuN1UxUSYbBDxMASWPYc8pLI2ZK5PS7kZUZ91Am+8QQLrDy6G1?=
 =?us-ascii?Q?mIE9b7MgxbuKT8lrx82Kx7ZzMeM3twLQTTTqM5QUAifRl+9dGF6Od31aCooL?=
 =?us-ascii?Q?6a+Hooku34FO/ogbtbYyTMC1z2uuJQYTVelktmBsRXsdoFyhFLvm4Zs6/J0N?=
 =?us-ascii?Q?W4JyQMd29+BcoQABGoHVBejdo15t1KMMRc8jLU0APYkYMB7YNkF61zpf7D+Q?=
 =?us-ascii?Q?+2YfX21rbk4ee9SyOApkvpSD0gGq2CzS9G4l4QvRxxmwBuhrUF4eXJPGZ1Oi?=
 =?us-ascii?Q?9imV4a4O8bBjMQM6nBNpUiSaVOG6pn5whrKoENkm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7813.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46653070-fc77-47b1-d49d-08dd5dc38218
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 22:00:43.8630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vlt7ay4515yEH3DNYKKPaIgxnoyFC5SrpkMRHgDXDxikr/O5R9RRPR55sXBrIMyjApladDOfFN8AB9q7Goe+6R0haMjQrnzDD8RbbbcPqnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5912
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf=20
> Of Jedrzej Jagielski
> Sent: Tuesday, February 25, 2025 6:34 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>;=20
> netdev@vger.kernel.org; andrew@lunn.ch; pmenzel@molgen.mpg.de;=20
> horms@kernel.org; Jagielski, Jedrzej <jedrzej.jagielski@intel.com>;=20
> Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Polchlopek,=20
> Mateusz <mateusz.polchlopek@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v5] ixgbe: add support for=20
> thermal sensor event reception
>
> E610 NICs unlike the previous devices utilising ixgbe driver are=20
> notified in the case of overheating by the FW ACI event.
>
> In event of overheat when threshold is exceeded, FW suspends all=20
> traffic and sends overtemp event to the driver. Then driver logs=20
> appropriate message and disables the adapter instance.
> The card remains in that state until the platform is rebooted.
>
> This approach is a solution to the fact current version of the
> E610 FW doesn't support reading thermal sensor data by the SW. So give=20
> to user at least any info that overtemp event has occurred, without=20
> interface disappearing from the OS without any note.
>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> v2,3,4 : commit msg tweaks
> v5: use ixgbe_down()
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      | 4 ++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h | 3 +++
>  2 files changed, 7 insertions(+)
Tested-by: Jeremiah Lokan < jeremiahx.j.lokan@intel.com> (A Contingent work=
er at Intel)

