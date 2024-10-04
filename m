Return-Path: <netdev+bounces-132216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E15990FAD
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A7C31C231C7
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 20:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685DD1D9669;
	Fri,  4 Oct 2024 19:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N8NRC7Da"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBBC1D89F8;
	Fri,  4 Oct 2024 19:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728069615; cv=fail; b=oEdJhXGzOOiEhNqjuUtrEZA/a23KQKv9OEJqxKXazucjhhGoLRAJR6QgaO9O/zFT46zRytjOYz4aoz3px6yvjylbuCKUm2tj4Cv4VDHoj3NKtDIEsQJQU9znZZsQFG//gvkggsV4nQ3OnZ5KzHnTphK0A5/j8iQUHxtHc+PPv8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728069615; c=relaxed/simple;
	bh=aklJ8jUb2O4jg2Qf4wRUr99tubXVjx9egEuAo/nTZgA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mn5XO7Lvh3y3bXWUQ4rXIDjkHV7sQXrff6UwIJQGlo+s1/AXHZwr5pYAOP2sA52kJjaQx1GlkfoMzHn54dJVTaDiglgB2ZNY9zFdL0ZkkphMUUYkUTFsd2KYKHmNycUl+8vuRHkDsxyZpm5/4O85vwnjd+JhVMZ54f7SkjjMbBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N8NRC7Da; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728069614; x=1759605614;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aklJ8jUb2O4jg2Qf4wRUr99tubXVjx9egEuAo/nTZgA=;
  b=N8NRC7Da3W0X05HojaMQvSN99AamkfDK8hC1I9qQDpqIPePPEmw76+sc
   qn66J3O9uOIadILBudO/w8wgu4zs6Ih01dM3gSSDSk+m8Kw4y1cpoEMgo
   Bhp4kIGZSgGXkOmxpOC/N0krwyKDIUN+1N7deXbV/KY/rYpiZuso8xgwL
   vMKkZpJvOp5gTGlyAbP+CiF2O952p0KwUZOrTORhL82qpGYi7G8jRPDxC
   znbZN3M1z1dUn9KyxYU3Jt7nZPVVEbanCYd//pshvtdIPAILRdcPR77XZ
   LbImYsr3DTwZEvmNu9Fo+5d1TLeTreHtPN3GaaqYFJ8a6otdIjnsO5adS
   A==;
X-CSE-ConnectionGUID: kGu6RlpJSUW8jnT/zauMSw==
X-CSE-MsgGUID: XCRCtAqCSr+wchLmqPNp2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="26770110"
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="26770110"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 12:20:13 -0700
X-CSE-ConnectionGUID: 5byQWSOxSLqNOvb5XhVaUw==
X-CSE-MsgGUID: 5LiXEg1jSUaW1wI+06OeBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="105551566"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2024 12:20:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 12:20:12 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 12:20:12 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 4 Oct 2024 12:20:12 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 4 Oct 2024 12:20:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arWB3w1TJk9T7aKnT6hjNmgesLeB2ykQkVO3pnPqFEPgtXC7dz+ngnTJvGiLDpBZU1WOUkkNyruQ05WXiXCtBZTasmZ2i45FAv665fvChsOojOcqDNDDKayA+RhSlr5Eh6csDQ0oehfMtN8x7NLcMQqeMjcMIbKAmkCkin/w4i6tuQIGqj534OXgeQb/Pqm45/ycfVp5/tMrbJ77puIkert7hbdESAWfXvxQc4IPmii+bBBPtqZNnHC1V3KnXLToYIaW3X4g/FLqTXiaMNPG2ym7AO+GLTCsMcRiIggph26Kbfi9TeqfFiAeb6hx4EvTu5KpSFApc7frAOpMRn1IUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+shS052yNPHc/S7VdzqL/0UdABekzqydQ7A94znWA4=;
 b=fm0nverBm2zBqHQEC6hFAuv6O0xa9tjOuaawTMZG6hn6PkV1MArDBuH5qX6UY5l3fuGk88/j2gNKJ17ij3m0g5muCjywbJYpvRb4BEOISRhHdgoSY22pCoxzGO1qitoSTIiUxs+HLrZ2Vv8kfUmj0/1K6lViIp7k9UprcwzYfqCsErKLo8ONBCK2Wm3+OvKND8f1GS6VYH5AufNtqYhlimI+HBhGbGSbscrTU0QsFLwBlzErr+2/SF7HAOIVPnuL8La+r++vdvinocuQwaAKsSuVygnOFHVYMhqJ2izQkDE0Yg7l3cIj+OTmOXP1KG86bxtk9NbKdOnN9LF7/cHKPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB7639.namprd11.prod.outlook.com (2603:10b6:806:32a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 19:20:09 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 19:20:09 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] lib: packing: catch kunit_kzalloc() failure in
 the pack() test
Thread-Topic: [PATCH net-next] lib: packing: catch kunit_kzalloc() failure in
 the pack() test
Thread-Index: AQHbFkyovMasxAyjhkimZ9GSYotRCbJ2+CBg
Date: Fri, 4 Oct 2024 19:20:09 +0000
Message-ID: <CO1PR11MB5089426510DEAF985A5A4CB0D6722@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20241004110012.1323427-1-vladimir.oltean@nxp.com>
In-Reply-To: <20241004110012.1323427-1-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|SN7PR11MB7639:EE_
x-ms-office365-filtering-correlation-id: 7bcb32a6-3711-4951-6c66-08dce4a98fbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?hqrYZF1P6ICubV4ROg7vdXB2rpLsWOEaEFY7R2P/ZuFPZnJtkrzzyKtJogRZ?=
 =?us-ascii?Q?vBujnhtrtVxTkM5rmBQ15m7XF9zE6GDXOSoPo6fiMEXo/af4a6w+rFvDtpWY?=
 =?us-ascii?Q?bKY87pw+hUxlyDW9ojkHyDFktNZWmHvaEwgD4B0zDtd9gcKko5Hsg6duVprz?=
 =?us-ascii?Q?aqzhvPMqjPuRb8i7j8Hu4OO2K9kZNHggTO7UIeD+8SpE4jD01m6IGU2fYI5u?=
 =?us-ascii?Q?vGwY53Kpm74TtNB51C69PJg3ooe/VTT4OJZEYyVVBAFMX++0rN52dIAS1NL8?=
 =?us-ascii?Q?vfqpYVyxkczIYykTMCzb3Q7obajp4QQrFEUnbLjDvlSOyvA+OyQjakKmGIqI?=
 =?us-ascii?Q?0HDkPWjcgsf5bHpjAKuBdFSvIqlRSVDscNU575qyYaD3yPpQhMLnEd3m4mBX?=
 =?us-ascii?Q?t3/Gad1k98I1t+IGO6nRJhHiTBA7J01VFPhUiOBlWNeBqyu35Vf5R42HjbT8?=
 =?us-ascii?Q?lgK4Cfci2hrPYV7Eodc2glGP+UzVlUaZ3xN3IBC0fLBzpnI25OkhvDJlB6zD?=
 =?us-ascii?Q?hGbQA6y67rVFPMvAORml6rrZQUaAfVUQ7qautnoZMHBpQ66fCxIvboBCyUFk?=
 =?us-ascii?Q?xF71/TJ/iNkfq2FZbzAKELDc06mJFcXMHfKIDUiBKqgO6KIoULm1zh9XccXR?=
 =?us-ascii?Q?Grx7r7wCXk9gVnYqrtPKYBEov65yqPOsWt+QqpG1SaiDL84Ff5kvJcr+mB9V?=
 =?us-ascii?Q?v11pXlqY1cgJck3+gbqaC2uVM/bh1zRLaOryyJBJ1JxFvbUM8OtjOlRqItWW?=
 =?us-ascii?Q?84sCdSClaOivRq+4AMb/YRsr+UH4f+dwkMP1oGM/yNlK2e1CwSuCq3A9RQ4/?=
 =?us-ascii?Q?BGKzOdFG4YVgNKuQ7jKl2vOnatBZOy7muypJMU666aVyLuVmltB+PV8An9rF?=
 =?us-ascii?Q?T8zvI1r9vb0y2dFKKSlkhlcIa2D8e0kAsErBOmbMZBiH2fySbf0zvqRBOIbW?=
 =?us-ascii?Q?bKG9CS6o9Rt9Ex+J7IHNbNaEKsYiRhbljZOcnaWOIfHeWEWYIXzZDu3fwLil?=
 =?us-ascii?Q?MZBdxbGXVstii7hIPtd0QRsdzu5BEJziAO+zmIhaBVXpESrTnaW9OdklSMvl?=
 =?us-ascii?Q?v59FOjuyigVsQfJJw2yu7rRklc2Vs5jC4abR+KDp9O36muCQjxfUPt0TNbmw?=
 =?us-ascii?Q?6S7Unh7RAXZ9UiHD+qxms4/UGsxuHxZEMI1hWTFp1a3wxrFVFjnoJVaicEFb?=
 =?us-ascii?Q?BQYHbJfaWOUuytKglKiDwgvmmPri/90lXfog7+B4qs5HPioSvOKoAwlHY04m?=
 =?us-ascii?Q?P8gpVY7Fi17FZsWAhcItLoagepEuRpJrbNekMbTvMIO0QUpKi1RN39ERxFOm?=
 =?us-ascii?Q?po3BTQxUAT7665i9lm3KvOVBmItYcIPWuunF6znPds23Uw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?scTdeXQEUy33iZnD/+ZfI8ixbhvGBy5tUGjLKS5RSa+eTdcVrEtWqwJa7jSw?=
 =?us-ascii?Q?qGHeA+0Kw1i6WQxYhm+jDuAbp0gtEFtlk5dsK/oQ7wm9eXSifzuLoo5LvqGa?=
 =?us-ascii?Q?n0xf2d/zLNKa1IAkQQWmvMGdp9HLlIwj5Fo2AYNvOpEyv4C1InzeRm7/0awK?=
 =?us-ascii?Q?7BtiloM7eFN+xbvpeGMZdbqdYTADr7bSOcaVY355FJyYfOA2AMfeZWjzkhG4?=
 =?us-ascii?Q?83UCeRq0Wkpwe099D7Z49v7Scq0PHSEDP+9y9WPdyr7dcjCMwvqvXEzpUpVZ?=
 =?us-ascii?Q?X9MFqCZKp7psn4NiTz5obN2Zyec/krZMztxJoZsE0EVxlHebiqBDedej4UuZ?=
 =?us-ascii?Q?IJ+dYz3omPyrB0BH2wIucISZWihq6q1srlXH1ZZmLspKWQtKjItCQJJHacr0?=
 =?us-ascii?Q?jDgLxDDvvKJ6HaOpVWTCnJAz2KRViF7oWVuTueGE6vqaDP+h2VM8PBQczOTI?=
 =?us-ascii?Q?4Q4xsxoFt4fdWZXzcqboU4Qnjeg6QhHzi7U+vz7lf5mgPfyeks0TS8EuEOr1?=
 =?us-ascii?Q?2SdYAqXLMEyzEVJOkbrnDUq9TFYwQYk11fGhSYfngCSwlRu5+KlLQHZ5Gfis?=
 =?us-ascii?Q?FKCv+3rykYi1J/LChOzE8nDja7HTfVS8hKo5An/rLVbjCQ/b7G5wqTXPLsX+?=
 =?us-ascii?Q?WjfjPU9mfWTECKKjVEJVEHOkeIoJJg+m9V6I4dUkiO3m+EeNp+/DrLL44wG6?=
 =?us-ascii?Q?/RtoQQ4zjSYWobdkTYOcqtc+yI/2w+YufmL7Qw0/KAUHYUAdMCTURtSc9hF4?=
 =?us-ascii?Q?B9ogOr1SigVOAAMUUGnhv3HmjFed0Vl9MUQtaIGU4wnHUih542hHtHn3/QYK?=
 =?us-ascii?Q?J1vDrx1CGyqL9uqmCGFrRqHZVsaJN7Bp6VSltgXLh4nRvO3hLWZa821JHuBo?=
 =?us-ascii?Q?QktovQvnlTuCQiSN8akAhGQdol8Lc/QUPBMXOnsOYda6yBjEAg0Zgx3feLnS?=
 =?us-ascii?Q?XD8VkSFkeUSAzn/oVLST1MLCd7aOSvBqXkoavsqlqhX5hlTTbm9TaCS7XOw2?=
 =?us-ascii?Q?n2nFTnV8eVySjzsnaep2Agqp0Rzm4I2TaRpdCYJLCKd2OXCAZOMVXiJmJPEH?=
 =?us-ascii?Q?JMxYUzSR3CjNhLXecVt+cqr4K7kHpHVBX+FF2+Z/YY3HxNCnTjGN1eB5u062?=
 =?us-ascii?Q?4csvQMZjC7l7DtyVYkzXF7wElxAWFVyAAX0DXwJDtPlp0YuLAkbzAhmr/O7o?=
 =?us-ascii?Q?DpfFXn57isNMOzIpy/YDIpHAanEwzSax4AvxRp03HxPxxEBKaYRslbmrWkrW?=
 =?us-ascii?Q?YF8wtHO+JFRDUygQLzuncZRjx5UcEB8etRBLYmxQcZqiohbdssBgngVS1oSf?=
 =?us-ascii?Q?XESFPauOAtS8uv52mcRL7cGikZZ/A+pahlnoOLBxQIWLFfN/fLx+HuH66VrE?=
 =?us-ascii?Q?8MM89zZ7jRnRVL8k+5odVQQc8DjzAu+e8bn3FeEat4fcZkTdgDmBEWva++jZ?=
 =?us-ascii?Q?kF9nFnhLnt9i3HEuVyTUXl35WuEgPB0mn31CZrGsR7gZ/kGmWAhXzX7KtWGk?=
 =?us-ascii?Q?q3h1pG7TumuAkFSdwlYrPmNzSMcL5R5jaszWiDlP+//mOzipMZuc6caElaNC?=
 =?us-ascii?Q?1lX+LvsKwxKGD2paB2tedFy6UUUk5LwkLB1aQIz0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bcb32a6-3711-4951-6c66-08dce4a98fbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 19:20:09.1547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DcdYzB7r6CJPoD6UP1AtM4GT7aDzcL+jvvBx2oPKMNO73BxmqwY/NpjdDK0SNa8da8oMZ+hR6vmLczu/Bg34DGKxEYTBSHblSjCEBQMQRr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7639
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> Sent: Friday, October 4, 2024 4:00 AM
> To: netdev@vger.kernel.org
> Cc: David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Keller, Jacob E <jacob.e.keller@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; linux-kernel@vger.kernel.org
> Subject: [PATCH net-next] lib: packing: catch kunit_kzalloc() failure in =
the pack()
> test
>=20
> kunit_kzalloc() may fail. Other call sites verify that this is the case,
> either using a direct comparison with the NULL pointer, or the
> KUNIT_ASSERT_NOT_NULL() or KUNIT_ASSERT_NOT_ERR_OR_NULL().
>=20
> Pick KUNIT_ASSERT_NOT_NULL() as the error handling method that made most
> sense to me. It's an unlikely thing to happen, but at least we call
> __kunit_abort() instead of dereferencing this NULL pointer.
>=20
> Fixes: e9502ea6db8a ("lib: packing: add KUnit tests adapted from selftest=
s")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  lib/packing_test.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/lib/packing_test.c b/lib/packing_test.c
> index 015ad1180d23..b38ea43c03fd 100644
> --- a/lib/packing_test.c
> +++ b/lib/packing_test.c
> @@ -375,6 +375,7 @@ static void packing_test_pack(struct kunit *test)
>  	int err;
>=20
>  	pbuf =3D kunit_kzalloc(test, params->pbuf_size, GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, pbuf);
>=20
>  	err =3D pack(pbuf, params->uval, params->start_bit, params->end_bit,
>  		   params->pbuf_size, params->quirks);
> --
> 2.43.0

Oh good catch! I guess I had assumed that kunit_kzalloc would itself detect=
 and fail instead of continuing....


