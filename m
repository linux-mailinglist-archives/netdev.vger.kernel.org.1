Return-Path: <netdev+bounces-244301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E2DCB43CC
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 00:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 71E44300848B
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 23:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972C6302145;
	Wed, 10 Dec 2025 23:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bUB5B0lO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A1E2FD1D3
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 23:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765408934; cv=fail; b=nfzkI1qHPT8/S6KBAnwQBRLfnccpNu+0cPDPdgmrZ3oLyNBKDcbDd7mTubwYtx3LiXKfDG5jBSv6uAlT/EooEtB0M/E/sAISkomy3qBRf/7JGSSD38Eqa9+1P+v64ZmpobBEex1eP3UGQlTyMxRNKOBVytAiwalYcNhX1Ts8HAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765408934; c=relaxed/simple;
	bh=uc+W13BHhECD7OP7vjnBFgTR2rDRFr0KkTmncPGhQtI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SqHxDlXSpWTzgsa/57oWgO1ZGm376HIe1O7Zy0nlqLf3spKySsjqnvH//4WJuXQrttZ4h+/Knxo6NXsgwwxxrL3gh0vaHl+lMFgMOk328ICs9hW+o7Yl2wsuQ5ZPi9AQZv7zgb4j8Vyz2DP5XgvhvLJPoZf3kZ8+EfRuSSsBy2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bUB5B0lO; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765408929; x=1796944929;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uc+W13BHhECD7OP7vjnBFgTR2rDRFr0KkTmncPGhQtI=;
  b=bUB5B0lOHiZIgDwyuvwk4g8L34PlileMWQ/iJvvQEsm0IjaPtDbPbTcs
   1hfhLN8znR1Y7R5O4nOOvu1f1rRcvXgDu4sq3eTsCt+UHZNU7zqIyn3Pc
   JvRxqQZgD3YR75pbUBMG1zXniqb3b/AtyY6QJ4dQJZIIQmbD5EZTyXJxT
   79Z4Kk8qcEcrbVdcwiMhqSPcqAf0XfLtL4E61BV3j6VWwNlk+Spbfs5TL
   kv8NgedimdV7P1Ca/BF73/wQvh7MZhYubL6JJINQS5uPEmHoXHBJBwoHf
   /tebXG4lkPQpcAlvQisrK+Cpm04DX4YHdtWtNaJjSaiKSNHSW2MddgurP
   Q==;
X-CSE-ConnectionGUID: 6qfVvG3HRkORhVvph7FsQQ==
X-CSE-MsgGUID: ccih8Eo2QganBSiMTjbDCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="71236359"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; 
   d="scan'208";a="71236359"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 15:21:59 -0800
X-CSE-ConnectionGUID: mu7dIOUiSNmNriFmuweCOA==
X-CSE-MsgGUID: 3HlT84lnQCi7z3gRZdXZNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; 
   d="scan'208";a="201566887"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 15:21:59 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 10 Dec 2025 15:21:58 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 10 Dec 2025 15:21:58 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.46) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 10 Dec 2025 15:21:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EfP+4sqVLS1wP7pdwF+4pjCOrzXcadTT9Y/uXclj6yFKjwhj/MSAfafuokP4xUOe53ErdQ8hZRIHwVuH3zOsrmwMoOWnOD55+Z1M5P5/34n0IGtwfByZZc7df/FppTRD5daVi45QSquvCHSBPIZJsKQmVHONv4Abrx3gR31Lo0G1g6akT2guhClGwjCtm0rj4QBcZ9zqWgBNXIzXBXeUNkvOjZJEMQo29/KgITC39XFQEuF+auufo08LcQgkiYm/aWH+gYBeWBkpzS6bhGX0PpNg5ZMIbAlqS+yvSw18sOkLeuXRWU/V57A2FH0l6+yplD+RqW8zJyx4Ct3OgoDVLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uc+W13BHhECD7OP7vjnBFgTR2rDRFr0KkTmncPGhQtI=;
 b=k48K5DHLYPYba2DBDG0fNAzKDc/5Tg6GKeM0oiWwLPTbuhCarxgM8KHcZSuO1bjkiLpTOfug6KAjuk1f4XQPCAfD5UbF160iuEuuCjzMUWcgcYvFoR9h4PCF/C2ZJ1oO9/Vt91OprkFxNjSMzII17mGcgpqP+cuS9fvuYtlD/SwcFw2Dpljos10pIxroZmBmK7RUO9/zDb5EhVqbTMB+Dau5z9lS872jpUed8cO4V87fJI3HdQlOIzAT9ncGz2VXRMK8E+/u/oh2bCv2wLjpbcekxxzjBJLhZ40dukWE5vUr6v113AVA2A6wnwLck6G6GMAFZ5XnJf9azg361UGKQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by SN7PR11MB7510.namprd11.prod.outlook.com (2603:10b6:806:349::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 23:21:56 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7%5]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 23:21:56 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Hay, Joshua A" <joshua.a.hay@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v10 10/10] idpf: generalize
 mailbox API
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v10 10/10] idpf: generalize
 mailbox API
Thread-Index: AQHcVDTgqLUxipoKC02W0Z4a5NXOzrUbrvoQ
Date: Wed, 10 Dec 2025 23:21:56 +0000
Message-ID: <SJ1PR11MB6297AAF67FF931AE50DF69419BA0A@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20251113004143.2924761-1-joshua.a.hay@intel.com>
 <20251113004143.2924761-11-joshua.a.hay@intel.com>
In-Reply-To: <20251113004143.2924761-11-joshua.a.hay@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|SN7PR11MB7510:EE_
x-ms-office365-filtering-correlation-id: bf7ff564-91ea-4a00-ca40-08de3842e952
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?i5p/YRj6sETtOTEAM6nWMn4/sTLGEWSVn4sP2AzeZu7KNyK5EBROhIpmWzRl?=
 =?us-ascii?Q?zj6QySipt8hE8Exd1LVU+wqS6hgtLbQl/7Gu9YC8hJu7df6qO/aW2sWkIslT?=
 =?us-ascii?Q?7rr2q7WeM570+NzbTu5fbu0UpxIrpdq14UdtcZZTzs6AawmbSOTG8+YLMyGS?=
 =?us-ascii?Q?/yzBKPYg5T3m0Y7Y9avQeJ/yCFpqiXyim++8znNzoPNf7WP/OmXeyDvdSdxm?=
 =?us-ascii?Q?JQ9peZYTsJo8PWZLoCWrVjMY8Omg4FNfvaYYfUK8Mol02iazcx+oVydohq3c?=
 =?us-ascii?Q?RujVd2u7kkkmQFmewJ7mw4vhk4TpM7/xel6F1XAuhbSuakbYnqkGt6i4409b?=
 =?us-ascii?Q?L3a0XI2I+zjLaoPHmYveywhI2eNut+5en5ZL1ganSEKo62UMIPYEi6+vMDca?=
 =?us-ascii?Q?YxtNRg80k0lvGiY/o8U9NEQNZVP0U4U0vRO47CXA49+UBdLc07i4vhvjWp3a?=
 =?us-ascii?Q?CL880pHqLgj21zmpDdFTxh3RT9CxhvXHuQXPRFRMnO5ktIhloT/VltbEcRuT?=
 =?us-ascii?Q?FcPw647FfHgZnHgxcinq7qKDzz7ymNDMe+fvHlvlVA0FB98DK9edyuz6Ijyo?=
 =?us-ascii?Q?66uluLOkmbrrI1rneTBNl6RjAfi77E5Lkiy41jpT0Hg/2WhIW28CpuUPQnEm?=
 =?us-ascii?Q?NZhN+sp5auVd80AMLGbsI4Yf3uwwQlxTWdmJu1QQzpN6L6KVsoM00ZZRmCCo?=
 =?us-ascii?Q?S5wG2AJLvmKkmzgXh1CHsLe3+xy8B0QJh6p8wwwS1uv975lBWahj5curQJPI?=
 =?us-ascii?Q?Lz7Rzi4CF+dnpTubCM2Pt+JRnoGxF1Oe1N8air0u/QsABBIatepLvJ7wIklX?=
 =?us-ascii?Q?z8TakMDBDRu6mlpxZ+PMkOt6amwrj6uyEyAslfVGg3AVMvWJVG08ZdOGakDA?=
 =?us-ascii?Q?gPYnJeqy1gb9uuOjLOZ5G+eXXNsUWbbn5sbmWoMmM3gMs/77d+VMOoCDk0Oc?=
 =?us-ascii?Q?E4qElmnGvHCvoJMvKCbldtqbQz/4ceHdDh15mKHxt4hVxOlgzWXJW4kQYuDM?=
 =?us-ascii?Q?Vg5qknAX3rxVTPFvbNr3V91ZdYnn1Au9Z8dD1vaELFopWPTapz/xeQoAAPzy?=
 =?us-ascii?Q?Et0eim2mCoR2Zs2tf4vIXbMgTBtsnPr4x3GkPG05oR6eQ4QyAOpx9qf0CB4Z?=
 =?us-ascii?Q?93I5UcRAsjYMaTTB5jLvxBQLsdIe3+nC3MLoffpQLD1rmtVKvLW+mCF1eNu4?=
 =?us-ascii?Q?AzwrTrAge2ZhAVzkZsRqwNZYlILgBOsx925w+HSvTD/3C+RdnVqWICr38S/d?=
 =?us-ascii?Q?+IGYSVSCDFXpIKJ/T02xcDTamTuuBaj5ktC/WM2mC7j4NYd3z3bSkZ1+wsn4?=
 =?us-ascii?Q?TXHI2R+xs3qqWV4xdbqaGa1uKDJkTU3bWSVQuX148t1gHRGDkBT5C8b7oRFN?=
 =?us-ascii?Q?Vuya7a0zwkWm2IQiRb5imfNzO+RUKYoE5vIl9RTjPkuMbqgvZH7KH+bYWiNq?=
 =?us-ascii?Q?Lpg1hxHnfN9MRLsST0awDN9XyK1ZVmPQ+lLi6DVJLtDxZyOkF7A+iQFZIRMM?=
 =?us-ascii?Q?yT0m1zCl7c+kXwqcBt30w2B6G/LIMyRYgKo2?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KXBAagyIKJ8/YNVNvc7IdCQ09JFgosiydeDAT/0XnzCT6TqPsoZfiBxmDcis?=
 =?us-ascii?Q?pLl6umngWhAisMmeQkAn31uPIt0IXHLKM8NWg2FLmImF0aOeGkk4cPWSaCjy?=
 =?us-ascii?Q?4EoA9rLFKc9KaN+Ezcw9XD0Ya+VQjmBfl1tC8fmtkeV1dufqzSmTbIsC8uvw?=
 =?us-ascii?Q?Gavj2jkaWJesKR5wcGIoIztmtWlwtC13vQjEkpG1dxe0o5oydmqbNYMDwH4q?=
 =?us-ascii?Q?DIBVK7R/XNhRlefcCIgGi07SjrmOOb0ijdp2yOjgHOpiFAkhn58IySYUUpn0?=
 =?us-ascii?Q?CA7JfiF0PdWMUkvuKJeVNlaUwwqx45Vo9EsYFcKifbHwr2kr3gfL9NZD67YY?=
 =?us-ascii?Q?8NzJpXgai/dUt9GkuZcXhx0ZRTRxlyRjrVfBjR8UItkMrgYuj4haLLyw1ixh?=
 =?us-ascii?Q?sW4lG7nJgtVWvR/5FT6Z20TWa0IFjF0Nn3sEa5OjDlJscnoF3HPB5le/vzTK?=
 =?us-ascii?Q?nHE93SnZjO5/ul4t0HSijONaiET3hx2tsvm5Hm5e8E45VAvsVgODq+f01nsq?=
 =?us-ascii?Q?Asnwq7pO0iAIAzJs9gz99kKMgy/+38REfKn/nyeSim5lS0KlJK56FfzM6y5X?=
 =?us-ascii?Q?SdSZ1mgmWr+3RcCECjuxc1miyHyF1Ny3ssk3ADC/qAewX5f7I9a0kvjYswEq?=
 =?us-ascii?Q?UjUAj2aomrMROaVZJ9hetusP3aBkilPIvdey9wPnfabrA2hO99aHoNVdewx0?=
 =?us-ascii?Q?theCuO1Zf7aU0/7/U4i5bifkBmiLmfd4uKKVoEwOzrxYd67Vt+ESppQA0xgg?=
 =?us-ascii?Q?hclXqmnMbwMA1uji1NmvxjXEoLuH8BKcpzeTFAUBfS29v5tdLQ5/3zMOqmtT?=
 =?us-ascii?Q?2Z91w152fU41pFu3OgUQfxXCZZpBUPVpV5EVR/OKilECekumyEAREA4Wit9M?=
 =?us-ascii?Q?N4PdC03h1MdYPbRGkbeT4dz3uww3+FPaeUiw6VLPF4Hrp+EcHpa8IXTXDEDs?=
 =?us-ascii?Q?kvg2AFX3behFAnnrWpXwgqjpSVJCOIKuwUAmNOzGmEYgaH2UnQrbVaVxlOqx?=
 =?us-ascii?Q?Vcz+qomjsD+i4eusTL65iDAI64MYLdEdVuRcBSQUvctolomlIJW/66Fhok8p?=
 =?us-ascii?Q?/kbRWhk890uMmFblJNmgNC4i+XV7h7TGpiIdBME1536c2XxsBRQGlgD4bUzO?=
 =?us-ascii?Q?OwhoJjkdqEzVxZ3GHLb1dL0N1Djr0/BsBQgR2hdu71y2sVyNB50urif/pnZI?=
 =?us-ascii?Q?rmMCCKetJ8DyxNiVMGwZJjtC5P6KQb1YLa3E8XQmE0+HxBa8Npp6pubBPmSk?=
 =?us-ascii?Q?7RbOMAJf3ALP9tpluwO4GMEJyYtcEVIYD47KXfj5Sj/RyyJOaiIA4TW8dMOK?=
 =?us-ascii?Q?35nn4+dh7YllRzJ2G69TwQBicbhfTSOcXIAI6GNF8F9rCxLAL7Aw+Nz4FCS1?=
 =?us-ascii?Q?c0of+smmqrpbNxdIKIj5AYlKgKur7TeY1rxfRqak9XfGInmEezAxBa7DVGhg?=
 =?us-ascii?Q?PN0BTtnqYi4IZtWC8P6Bd/CKQMotoCnhDSjcivhrg4UA2oIJbjsBXebylj6i?=
 =?us-ascii?Q?jJ9Q4ou9pN+/LLNA0ujJ+62Ryz3zc0VIg2UGt2n8BRqGvmWb88qbcANjqAcz?=
 =?us-ascii?Q?AzGNN0hvoYv8i833tTbH5lFMAG4kQmtkX2D89000?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7ff564-91ea-4a00-ca40-08de3842e952
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2025 23:21:56.6313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pd8wNxJ2+JmJ5ai4EvL5cALMtT7CMnqcXMdOUaOSRRVQqDBpfO1MVad41javU4lCcijNfNnAU8PuXYxoq/Y5vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7510
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Joshua Hay
> Sent: Wednesday, November 12, 2025 4:42 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v10 10/10] idpf: generalize ma=
ilbox
> API
>=20
> From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
>=20
> Add a control queue parameter to all mailbox APIs in order to make use of
> those APIs for non-default mailbox as well.
>=20
> Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v8: rebase on AF_XDP series
> ---
> 2.39.2

Tested-by: Samuel Salin <Samuel.salin@intel.com>

