Return-Path: <netdev+bounces-176668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0565A6B3CD
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 05:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 072B9189C1DE
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 04:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C531DFD95;
	Fri, 21 Mar 2025 04:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MQTcXgnz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029FB3597C;
	Fri, 21 Mar 2025 04:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742532392; cv=fail; b=lz9CZQ75rihG5Yi4FWotXo3M8I6jXsDWN+iLe2dakIuDgJS7Y4CRDdRRakfRnCAdraLwZWSgZnQaNLRS7oxJOpM+WQyPNa+aV21DoTF/YXyGOmcoKP1D/WM5mgUB/JR6ZPkh8hR05RNbt4DOhzViYPVwwikyep67NZzdqO0Q3EE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742532392; c=relaxed/simple;
	bh=/OvMKy5f+xGGieEdrCV4NjU9QWRtHed4+J6RAoW6oT4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IAKPYQoiEJkyp5lB4Kv2mImHqIi+TOxGwXk1+B6AQliOO8eaBlRD5vN5HVLRlVjjGzhpWfujO8B9aoPdE5EFyk1E74cHRIFmxeEgMEdNWWke2A3Q/GwJOfJJuHdt/Pa2FmUHs2R/4JyHc0fdKGCWoQDpZNOnUtmD8xkDPG2zoPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MQTcXgnz; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742532389; x=1774068389;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/OvMKy5f+xGGieEdrCV4NjU9QWRtHed4+J6RAoW6oT4=;
  b=MQTcXgnz4fNHXNqZW/bfApTbQjp6P5ss04N+idAJrqygFw1Y3RB/Qd5G
   T3kVFWmENCyUftwWu/u6dhsVPz1T77NMX2ZiBHX+frEKHUSablAjx8dZq
   8Uv8y/NbYQuXV1vYRtk9q8CHhFycY67P4Z3yYpTqXud9bEy+B13TRyGWl
   CK6kgvXJ0p8gZnfFC5we7z3IoX98pxhCUOMPOypnIAjVe9ynpkybC3vSu
   gnvQ3Qat7iC9y02kRBfBxY4GokEwsaQX8Ghknzhv59xygS3TocpFvAosi
   Q20EQHgCdpacAXTO0wgWMcdyVv28CAK0YVZfDYXM+c/vZm7xw7b1WL/tr
   w==;
X-CSE-ConnectionGUID: 8LmnC898SheyMlYl1BCf2w==
X-CSE-MsgGUID: iQpebynaTMO10vJ0l4u9Wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43670213"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="43670213"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 21:46:28 -0700
X-CSE-ConnectionGUID: iy0YByU7Q/q6HHgaBBe5XQ==
X-CSE-MsgGUID: 7YOrEdPJQS6Grwqph0h2Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="127979990"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 21:46:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Mar 2025 21:46:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Mar 2025 21:46:27 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 21:46:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTLMJ6iQN12LNSQh+1CORf431Ys9eDV06Mu5+VwvmxuJUlYVjqhRnQ3HPvmWTxhewzb1E3oPNlH6u/2iAU+AoNj1l/AAq0vkgD7tjAeKzB9PEAVKyeG+b+ggZRZfRGQgQw4YSyinDx2ZvdXg1KrokuWdU2CXqtACuuau3wkoU+cBPF/fv4tuNflF/kr4/mCWCT6qwTmlQrgvOFRIIEKIeckbRXHTG5r4NKksEChJ7qyrCbg928i5i8dArGPIThBZIjRwIVyWdHTVrXbzaLKYWHkoCQ4JkvZLK8Z1z3kqEvnn0AF89GZW3v3pj+M/yydYgw1oAf5IQCFqRPiR14jcHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/OvMKy5f+xGGieEdrCV4NjU9QWRtHed4+J6RAoW6oT4=;
 b=zW5gT4NjtOadVVMABrbzpJnDjF/qLPdtNWpkE/YbC1UrRiTHI8v/yE/ko2CQDJhy0Fe4kGoBAZZJUr4Ro5MUAvoVSWP8UbOxFTyDg8yZCRe3zTRxVLTOAqQNdx6bxaBRcaa/DvzirZcHV5B/yv48dMHSGWzPtDAVD18mqhFbNFXOCtaPI17rRzpkakfb+VPXL0PJppUrHYfjEsZoQB61qfzOTG052ro2NuvAw2RryO6OjKclrlfvn74rlcWJzqgpe5A9QaPi8kx1Dnv5aEMTkAUfYIvmZGK9LdIW+KtfJOGGIStcmaRvZy551iMsATKGK3g3tGTbJwysilFNNnVyjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by CY8PR11MB7083.namprd11.prod.outlook.com (2603:10b6:930:51::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 04:46:22 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::90b0:6aad:5bb6:b3ae]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::90b0:6aad:5bb6:b3ae%7]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 04:46:22 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Rand Deeb <rand.sec96@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Dumazet, Eric" <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "moderated
 list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>, "open
 list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
CC: "deeb.rand@confident.ru" <deeb.rand@confident.ru>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"voskresenski.stanislav@confident.ru" <voskresenski.stanislav@confident.ru>
Subject: RE: [Intel-wired-lan] [PATCH] ixgbe: Fix unreachable retry logic in
 combined and byte I2C write functions
Thread-Topic: [Intel-wired-lan] [PATCH] ixgbe: Fix unreachable retry logic in
 combined and byte I2C write functions
Thread-Index: AQHbjrK2j63sAJcuFEWVS6/FGGqhjrN9BdrQ
Date: Fri, 21 Mar 2025 04:46:21 +0000
Message-ID: <IA1PR11MB624176A294140023F6AEAFFB8BDB2@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20250306101201.1938376-1-rand.sec96@gmail.com>
In-Reply-To: <20250306101201.1938376-1-rand.sec96@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|CY8PR11MB7083:EE_
x-ms-office365-filtering-correlation-id: 09921eea-8222-4b5f-8b3f-08dd68335412
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?jl8RuNvi0Bx8ZDs73ZNH5lqtFDml/TYIp+jbLLAqmX4C1qKeGiA5BTTO6LtR?=
 =?us-ascii?Q?PqHdLeR6UeyZdmDGBh8pFJo6bQ1ro5DcA+lE/oC+m6BOJUHXya/JQTQDaTf3?=
 =?us-ascii?Q?FQKQ0/FVFCr3Mv1Stk4opm8tXnpXfwgj/CCqIGlcjrkMXI48jUuX6IWlESaS?=
 =?us-ascii?Q?d678mqgkcydlBVco8fmUCSZrex7Da0ah320nOE1fmBPWok24dCVI4j4jALSB?=
 =?us-ascii?Q?TJgk8a3zm+mQmOiy0OKmKZxdK9rJ0PaSDgS1g52LKm9Ydida6rQ/CVsNPB/z?=
 =?us-ascii?Q?q2ptjrOHtCIvjPhxvW5ufaNFIgkyl6O/HQf2K27B2jK7aodCDLSfZm7Xn4oq?=
 =?us-ascii?Q?att+1PRuPt0V7W+FNkhHMQlZ2YwveILOLnoSb1kBzYs7eEO2TWoEkUOBVvMl?=
 =?us-ascii?Q?WVaQ6QjbuSGQ4zoGRSGrHutT99BQBzgSet0d8Nng04WKoVbtyve+IHcHGGKk?=
 =?us-ascii?Q?tBxc2T5P8GEdrXKgOb7KqOoDXcsD4cfVyqk4aCwEYfVIFZ5VNmTpwhJmyASX?=
 =?us-ascii?Q?9INxBU3dOyMpECywTvdNPu5xmUvRRV7+sahCqyrXGMYj5NDwzZVeJiAbykRC?=
 =?us-ascii?Q?tUCRWKe5rvWkvnUP2I04mkT2lsUw6ppBGMhGDg65xReIf4tSh5URLIsnUKsG?=
 =?us-ascii?Q?gDSLibnQ3df4U9zWr2vLrN/ykQDiemV5MxlE9DNaz0/bL+m/bK3vJDBzKrZ+?=
 =?us-ascii?Q?JGRQs3PlDR7mktGzK8cgabcvLmS/KA7aL3BQC2gLW5i5uRagB50uMLIMtHfL?=
 =?us-ascii?Q?3gse72NhgFa03DkCWmfN3KMhbuclTPVhLqTASKocdReiutbSgItAJQ7bffEf?=
 =?us-ascii?Q?t4ABuDj0Xpl/3gv+mPhaImpPY3v/ALOrQG588WdskXmVV9LfYqLLLUT8LEsS?=
 =?us-ascii?Q?GCBXjfwWWMAlssaQajzi30xkhtViESi+iwyJ+qBwqtBYqRzHG+mRKMUpFt01?=
 =?us-ascii?Q?3XPFHFU8srgP1nYcduAizXsF48CEsTzLi9rAWXokGHXUWei1EIpi6lD40AK6?=
 =?us-ascii?Q?Q+XWzkmy18lDJxpJpCO7rnOYTmjTt/ejkfotEjgplKBV62fTnQqRuM8s7Gw4?=
 =?us-ascii?Q?7W4wIFxpmKV+Tt0XVsD1DVgKAkYYcaLnSuG+TJ3hwHbs2Z5hFXurEAYEpHPy?=
 =?us-ascii?Q?cLHzyaxpS9XupEUQcGg795T8jsvWNT00CsXWffVqNwSeSBpd3ROCFyI/dd08?=
 =?us-ascii?Q?d5RSL/yTWicaZIJrjq6uuTSLwUtUUR1wdlBu9n/cP8ofRrBGK2Mhmalbk5Bq?=
 =?us-ascii?Q?e2/JxoL0b9YpgjraeVXep5Ah+p/jP0r7sZAsyqXSUZrpOPKf+oV9VjGavWJP?=
 =?us-ascii?Q?rOY1LXyYLMlMqUwBUSd01z4/zPaLApXDuAKMI5BsYb9u3oMjv8EVbTkuVTL5?=
 =?us-ascii?Q?w1QXTdKlqE+WgyNR9IboyVWAVnILmftsPO9ypNpqjfrpTB0+Yx40biGZrRxE?=
 =?us-ascii?Q?Owk/Qb8ITRP9p5cjAm+9fIyuLkSZMGhTNv5qe3ztbLYN7a3agP09aw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7zPagxqyFYLTueuYXFti2Q9pomsTViVmx4BFP3rRwYcyDC63a4I9dsS5L8L3?=
 =?us-ascii?Q?ujccDien5rO/WL4JrLxKWWKMNTqjL5wClmUXNk1l4Q2UXIeBRTcUHybiLd4v?=
 =?us-ascii?Q?jj5KBz7xV2PF2Lqm+nw3Q2oiX0HZJuxNx4JHSHXuQdhCOne7Bmj9eNnqMpNh?=
 =?us-ascii?Q?s86+her2P/ne9ilwr7Q5CbG6DcmmtWLl//92D3v63auRw5s5yde8UzXdeT5/?=
 =?us-ascii?Q?H1aCTZt470wJPlp6cWJd51fVNYCuHfCflayleIliV3V/KGkul56A9/HnQqWl?=
 =?us-ascii?Q?K0LvO5Yk/z3zpvcp9rMsgCc5QXMeifzBkUnGjjzBE4aunqKSv73lSkM/4kUz?=
 =?us-ascii?Q?cFTlL2nzdUFIAF2cvSf3rIcnxR5W7oS+ztB+z85sbdkv5xvkZbSMBOlkjsVv?=
 =?us-ascii?Q?SDF4tffhpPeRyTV75QG8yXt7iq46N8Us9LzA5fFmgWwva66VHnhcxCZUBZV4?=
 =?us-ascii?Q?BpGklFMAN7RwdxNHMUZIT80vMtdoJwsPM2SqsHWhGGkPa2jpBej7QlCeQvXm?=
 =?us-ascii?Q?YH81iqyHDZoI+zz5H/x2K378lKcUvLc9yqmeR31fck4sOI4DRsvPe3C7DuvG?=
 =?us-ascii?Q?xTGpGO3/UlE3uHGx/unNlH9VjaJ3LN3O2QoPnVGuCn3ZcNU2Suv3ZfGPLpn7?=
 =?us-ascii?Q?mDHE9vrypZqD1/mGq9jgWEbAQGP3CoCwAOOQoV++9k6MhrLPRgBQMmLwIg+W?=
 =?us-ascii?Q?LIcIVi40tJyfqg1LJKc1Urfb3WuYJscq6T68SRpWvnVegHQwQ32Lr6fN+gmg?=
 =?us-ascii?Q?2Efr32QfwrdEobvwYzzSil8oIGJq2Iq9Ff8ZP63PsRbX1jspYBw81X7M4JJS?=
 =?us-ascii?Q?JiUQ7gJEcWtqFfhuoedITuB1/nllRRDKnbNX4WDn3Wy7w+73Lp9QhIe5j8x6?=
 =?us-ascii?Q?5p31JTP+nzUYuxT5KxWf1BhWjgPORqNzr/nHb1cPTYkGKtyL+nM3frX9mlgP?=
 =?us-ascii?Q?maP76/Gv38jkz+j63ST9JBwzJpkRtf+261hAKsJQQlLGrBKhyb8XoWaCODhw?=
 =?us-ascii?Q?7vTpm9qCpohbrDKTYQEet5HA1U6QBQwGewbna7M1bGzjR107Sk3soagJlSkD?=
 =?us-ascii?Q?Hd4hpgzFsr3VNiwn+S10oY8eQP2VwDU/RzaA98okLwzbYJzgiBP27OvDMuFY?=
 =?us-ascii?Q?gR6MxbelxEvRvvsyMlq6hbHAtA/EziqhaKmoFwO1jmV8yADR/P2o3OfvG/A/?=
 =?us-ascii?Q?ayxGcVR1KAj/5Q2QTVHpJXfc6IJSSBclrbSpVMrlyOWd9VMNEJTXWqUUyJgl?=
 =?us-ascii?Q?CtO9onC4ebI6NyRLTXlKofAVbCUdyN19NRje+e9Islx7EzRpYvLLvvfqt0ex?=
 =?us-ascii?Q?IKJ/nKIQqHJLinfoa5f6eQs12clRPd7iDL/TPaCHgOrtrh3tI3b/63nEa1oJ?=
 =?us-ascii?Q?yKDBnt4Nof9WUn/2Zeuk5f8fy4ENOASI6klaCIbDsebbAhL+oGP8wYMX+vAP?=
 =?us-ascii?Q?lTlkIDOpPhUt9L+zOp3j7J/XdgaRYWxBaVnN//7NcvU1+NWVVk5AHdxf1eky?=
 =?us-ascii?Q?9jGwqSuHILmMOy+m0mZKqWEFPEQ1lNZigi65csvK/MLm6J7kGDtEU8hDCQF6?=
 =?us-ascii?Q?XpSdo2oJC6E7EzWW7onZ0bw8FAzJUXztDh9yZXgf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09921eea-8222-4b5f-8b3f-08dd68335412
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 04:46:21.8983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k0pt4yiFPpsz51Wbav5c7F3aGNGg3Dr0BDjw9QYyfS5QX4xHPXF+vr1bAauUAQkbdfMAZ3Rl/05cKHV4daNOxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7083
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of R=
and Deeb
> Sent: 06 March 2025 15:42
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <=
przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>; David S=
. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub K=
icinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; moderated list:=
INTEL ETHERNET DRIVERS <intel-wired-lan@lists.osuosl.org>; open list:NETWOR=
KING DRIVERS <netdev@vger.kernel.org>; open list <linux-kernel@vger.kernel.=
org>
> Cc: deeb.rand@confident.ru; lvc-project@linuxtesting.org; voskresenski.st=
anislav@confident.ru; Rand Deeb <rand.sec96@gmail.com>
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix unreachable retry logic in =
combined and byte I2C write functions
>
> The current implementation of `ixgbe_write_i2c_combined_generic_int` and =
`ixgbe_write_i2c_byte_generic_int` sets `max_retry` to `1`, which makes the=
 condition `retry < max_retry` always evaluate to `false`. This renders the=
 retry mechanism ineffective, as the debug message and retry logic are neve=
r executed.
>
> This patch increases `max_retry` to `3` in both functions, aligning them =
with the retry logic in `ixgbe_read_i2c_combined_generic_int`. This ensures=
 that the retry mechanism functions as intended, improving robustness in ca=
se of I2C write failures.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
> ---
> drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

