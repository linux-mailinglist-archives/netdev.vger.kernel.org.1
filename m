Return-Path: <netdev+bounces-100436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AA48FAA6A
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 08:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A45AA1C2183C
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 06:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEA2136E34;
	Tue,  4 Jun 2024 06:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L90B30qn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA87385;
	Tue,  4 Jun 2024 06:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717481142; cv=fail; b=rx2DmF9ogiY5b+y7615vEG1Nonp9G53dzFQ31bFCNzGUxMw6ifqe8930hVgYdZLvMuaRHtZ1P+lV1KjokB4UspNIGmlC8DksOcMVlAQ6v6w9Ada30GvX/lrQ4SGdWx3C3V/Afc2CiQ9bgEYar+NLaXtTpSJLGzPx46k8kS8jY8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717481142; c=relaxed/simple;
	bh=9cLTA9gxwNuoxWsT1m2uuV4fMK9lUhJoNixF0Te3PoY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SSoELmmT+edCf0pitCnwo8WosXRW17UlkIVnmXS5G7zkjK0nyPVJCIYXqtpoEkFAwTn1O2S8LEeo30+UZTXhmYx6va7U6rVVREasYZ+F8jeUumap+czlNGk5T8j88coQ335ThZasaNiD0Hq6u/6m8MOu6NpmfKmj10tz0vZJqlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L90B30qn; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717481141; x=1749017141;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9cLTA9gxwNuoxWsT1m2uuV4fMK9lUhJoNixF0Te3PoY=;
  b=L90B30qn+HLSboeUUAAWhe1hZpxE9uyU4XqKsRlsTKCNY0n44V8Qrpee
   4GTwjU8NX8H/DVj5KCCTWG9BbBcj2ILdSWP/LHP8L2d65CeRTun4zWN3M
   Eub3TmqQ3OLlG7WxFaqLbxusfb9x1ahMl9MDFv0SD1Dya6gpS7GVHBVN4
   PFwaGxjek63GsTGS/s6/lQSO/9vYzQ8xAjvCf1BL4GLEber+R9Hr0ID4X
   0vZ/Tj8qDmyOCyBjKc2I7zZTxWX99mRHXiwNXqCxQ6i3FbIpLCxqGdJgy
   U1QBYTcAXXmm4faCLuZg54LmnCVheNKkger2XpxHodyGsPTmw//DWIIL/
   A==;
X-CSE-ConnectionGUID: 6UUwAIb6Q4+isfUJ+/BM9g==
X-CSE-MsgGUID: +sT4nhYZTWKfpRIqBHBwdw==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="13949934"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="13949934"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 23:05:40 -0700
X-CSE-ConnectionGUID: QbWboP8eQi6w8HTMApOEWw==
X-CSE-MsgGUID: HTfLggyFTCKp+99EbC4y4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="37105220"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jun 2024 23:05:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 23:05:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 3 Jun 2024 23:05:38 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 23:05:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVvitG/F/dNm5gDnefRQdvrY1Cp454HgEhhJ+jPZ1iwKQqPgrzaLFhsysd7SW8d2rT0xML0gXpBN7RiFmVzmFz9ggriLM6iyJQ8kc3bWib0dj7oDYbsutIeZ0ZsKWvmolypLYaYq452lMROtCfss7UcEJi1zh2F+EHaV0GxG4kZ56R3vlUbFN9ileoqdm+nBdtl1CYzQaLM1HgwWw0+NwJTSSBRHYFoUXjimPuYAbfS3GW+NXb1soIBr6v6HkJo2g3JwAwvrf4hITEIzMMw6q6uTc5W/d+hzL9e7qEajGr6M980q2R89cnEtmkwNkGB08yE6Sq8kjiKs2fQDJmkd+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6EO1Rr98gyp5uY6pUBXo2zpl2GOPdHCsukQ7zW9NLM=;
 b=nhxwBQ7IoTY7ZuvF2uKhmVG9Vo7qOcnT9syzEvyVNiNlMYEVlVd5g3jmjEeAF7tuJQtoJyLUhz/ryhV7QJNm14W1r9rQyz963LgxMN4txyKLl3Qx2zx8MagwJhRT16Tz6eskBm9PtvxIIsfUy+yJxNXQOpTYmLhvkE87VrHgjSddOarroA45yPRuXxKsQC2PJdApnJL3kWeKm1ShDitwiFrvsRSYc9PJqHhZN7sUx6FdVIsXBGjgidPXAvDt0oQu/dLKCL4v1iR2Szevobvhhy8dtqoXY8B8B18HGt6wpnS4Osi3yU3fIPB5878JIk59ceSsqPaIgFAEPNBLQcNB0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL3PR11MB5748.namprd11.prod.outlook.com (2603:10b6:208:355::12)
 by DM4PR11MB6165.namprd11.prod.outlook.com (2603:10b6:8:ae::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.21; Tue, 4 Jun 2024 06:05:36 +0000
Received: from BL3PR11MB5748.namprd11.prod.outlook.com
 ([fe80::4de:65ae:ca8f:f835]) by BL3PR11MB5748.namprd11.prod.outlook.com
 ([fe80::4de:65ae:ca8f:f835%5]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 06:05:36 +0000
From: "Ng, Boon Khai" <boon.khai.ng@intel.com>
To: =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Andrew Lunn <andrew@lunn.ch>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Ang, Tien Sung" <tien.sung.ang@intel.com>,
	"G Thomas, Rohan" <rohan.g.thomas@intel.com>, "Looi, Hong Aun"
	<hong.aun.looi@intel.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, "Tham, Mun Yew" <mun.yew.tham@intel.com>
Subject: RE: [Enable Designware XGMAC VLAN Stripping Feature v2 1/1] net:
 stmmac: dwxgmac2: Add support for HW-accelerated VLAN Stripping
Thread-Topic: [Enable Designware XGMAC VLAN Stripping Feature v2 1/1] net:
 stmmac: dwxgmac2: Add support for HW-accelerated VLAN Stripping
Thread-Index: AQHasBkLCj07Z540QUGXqLg1tlacPLGrb/8AgAB3OtCAALcdgIACos0AgAA0dwCAB3I7sA==
Date: Tue, 4 Jun 2024 06:05:35 +0000
Message-ID: <BL3PR11MB57488DF9B08EACD88D938E2FC1F82@BL3PR11MB5748.namprd11.prod.outlook.com>
References: <20240527093339.30883-1-boon.khai.ng@intel.com>
 <20240527093339.30883-2-boon.khai.ng@intel.com>
 <48176576-e1d2-4c45-967a-91cabb982a21@lunn.ch>
 <DM8PR11MB5751469FAA2B01EB6CEB7B50C1F12@DM8PR11MB5751.namprd11.prod.outlook.com>
 <48673551-cada-4194-865f-bc04c1e19c29@lunn.ch>
 <DM8PR11MB5751194374C75EC5D5889D6AC1F32@DM8PR11MB5751.namprd11.prod.outlook.com>
 <322d8745-7eae-4a68-4606-d9fdb19b4662@linux.intel.com>
In-Reply-To: <322d8745-7eae-4a68-4606-d9fdb19b4662@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB5748:EE_|DM4PR11MB6165:EE_
x-ms-office365-filtering-correlation-id: c4705648-a379-40eb-cb4a-08dc845c59e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?EuftZEtTDOznYKLyKTmERnPyBtyA4V4KAiWa3EeY9k6jyEzsUsLbbyFHvA?=
 =?iso-8859-1?Q?XMfbHlcmCse5PUcxo7dxWmn5/6R8EtDODkAHXRifrTn1Yd6FynudjolMvz?=
 =?iso-8859-1?Q?SHaANtzP08vv/9Ae3l7o6DVVeC5AdEI1hir7Oe5k5XNnt9dN++RT6TE0Sc?=
 =?iso-8859-1?Q?og6AyRVncnuA0CPYV9R1AIUQnPZpwYBIkDMDTcX7V+28xqsgMDS3nXyS2D?=
 =?iso-8859-1?Q?skevJvrEr6Mb2ILHOqH99SkcA8rD4+HnLsyje5C/+l1xHOLYHVZKL/wY6Z?=
 =?iso-8859-1?Q?OvYw1XkbzK3OPg8sfcmjFLIaS4mI8pD9MIJMT9H3ii1lVpjo1/YhtcyDXx?=
 =?iso-8859-1?Q?dvy+hEY5xOd6e12LHzEz6oZOJcCcMmbUqVK9a+ngESKUZ0w7vYm99AI8vl?=
 =?iso-8859-1?Q?+Jvgr7dw9+ue70AD7Yqk+4Cw7Jv+T/4Yb9Z7TtSU0P/Dcp+OvtWIMr4GBi?=
 =?iso-8859-1?Q?RzjlHkW8pPMcicZGG7ToKNHDbfOeufF/mVY+ApNVMKY6QuIaGj+pmC7xYQ?=
 =?iso-8859-1?Q?DyQKkH20hwF13NJYCEdWdkhcQQsF2GJaNKWuzoJv56oq1Aexo0XClDpSkV?=
 =?iso-8859-1?Q?+41YaHb9Lh9xwQTU2RPFblqq/Fhuc2yHhsSDtmmTDMhfLpKoUkotKXesHq?=
 =?iso-8859-1?Q?Vyrh4t1eNUwHxZ4fjH6q9I/NJrcd6UDa9IzFnrqYm5a2yakaImb5Dc9D38?=
 =?iso-8859-1?Q?qI9G7vFRtKF356Be/srdQn2BuIonFRYjgWLPb0bk2aqykZC8VQ7/5rr2Iw?=
 =?iso-8859-1?Q?6WQKEGpQnGV6Iwr1oPp6sRyQAkBbddHCnRhJVXDgPueXxhNfJ9FLp+i0Kx?=
 =?iso-8859-1?Q?B08LvRk1Clz+Y4UjnfP5Kz1g7HwR7WKa0GA8iojaelNEyKYaFNUX5hvKjg?=
 =?iso-8859-1?Q?AtnYZo9oUpu4g04GAxMn6iIdIQcuJ3/6j5oQgZdqHBbgZDBbA+7XRa1fEd?=
 =?iso-8859-1?Q?TJaoUVnSBmbObbPQg2RN23Ff7kC8WvC6gM8S8mGuk1RiqLvRcLQFj0RhnA?=
 =?iso-8859-1?Q?P/87seBeFGh6RZwXXREu1KMCOEQIlImwODSY9JWY+uHfHZ0n1DuoMZpQeI?=
 =?iso-8859-1?Q?ISzgpSi4sn/QfB9LKu2/3r90s01GBbqZMNgWES58FyDLvDutU5oGdTAd1I?=
 =?iso-8859-1?Q?dW/gQ8i+D+60FgNpTE4x5iZeOFetxuyEdOenT4VEJJ7YULFdjcwIZ7WuXG?=
 =?iso-8859-1?Q?cIwL3UBYwfDu7q+lAiVwmKRoj/y6Co+g2az75S5euPuh6C+ge8/NZjhdLA?=
 =?iso-8859-1?Q?oU3KotKtMVLEqPh63qHGTLQsTcJ4Xkk1IkQRL1D5z8lWpzcX3r0B+P6ycX?=
 =?iso-8859-1?Q?2R49ZNd9XnigvsBdO5wC+gT2+ZF4FxJz2Di/ZZkabC385hzDCuQKoy8Obo?=
 =?iso-8859-1?Q?3NzVXYdRKaYh4pfLVG/suA8C3yPYOtUA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB5748.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2zfqMfi2/WiMygIREk5pi1V64umL3Sm9lpwosWlMjzpEMDtbAZ2ogmCFm2?=
 =?iso-8859-1?Q?IxCEDCHXU6PV9WMvoJATvz8ULHnCFbVY1Fgx8z9Zc02H3hTNhHdw8mARGb?=
 =?iso-8859-1?Q?bsz9YfpOvcBd9BBFJpBoZRwtIGTWPpdbBWWAY0HKAlazdlz9UqTD+nmcmm?=
 =?iso-8859-1?Q?rKwWTQKHX8XSzbU+d3uRf9Np4C65fr6RalWxS3q/JB5CIYqN8o8PJUrNiw?=
 =?iso-8859-1?Q?aq+GaIbpbSzOnq5JsMwa9tn3u2R0jc3PG/gYl0k0wcUz1DpOZFNDZsqZH6?=
 =?iso-8859-1?Q?AWjrKAa67rPjwhdOt+3wbhVIIOMbyoReDDF+XXH1tK/hWFyBOtRevZ0bvH?=
 =?iso-8859-1?Q?JYqs2+Wfl8pxmrIeTomsaZ0+hDsko+SWV07ypBgxi5Z48ey7MawfoBsPTZ?=
 =?iso-8859-1?Q?vTjW6hin6Oa+IDdcOMH28i6tm8Lav4zA2O6xHSwYuf+S7qrEV05sF3UxUr?=
 =?iso-8859-1?Q?o0HoDVpMdV8y05YLAakD+lpFT2b7pn7s1fphmeaSXXLzQGyLvKH11eEXAy?=
 =?iso-8859-1?Q?6FNV8zk0P92h7UrAcoG17gChdvMhnldrJJH2nxGTUDv7S9Wtkm7LTGkfmf?=
 =?iso-8859-1?Q?Pa9du6hxjxo8FyIsScxbz0hxKHIcstM3dd9k84mXMlMi/p2VHTbHgLCCMy?=
 =?iso-8859-1?Q?3YqvgoRP9z2IIzfrcHQlA9r4DFcqVo7M4upi8Q1ykBimc/9EBna26leLN4?=
 =?iso-8859-1?Q?PRP0bpE+WrtDuJxQCl0U2LoSUlLvE8QNQDet/L3Kpj/da9R1M4Zi+8e5uV?=
 =?iso-8859-1?Q?HjTccUDLP+1Zx5Cs+d6O2WV9ycsrUt4mI98CKm1eRwPjIAPK2kzXkzcMsU?=
 =?iso-8859-1?Q?9hoQGezdC3bCrfHfWXSTxKXqgN+KkrLhz/2X0pnKDimT9ZVKI3gxvBFpdQ?=
 =?iso-8859-1?Q?ZD97c2kvsyn9yrXLmUuvMWFpSKyFAZSPY376P0sqZ0m+fZhmPOcDVdZafU?=
 =?iso-8859-1?Q?6ghWm/2fYIRiywaBiw7D2XgC0jzynsNtoNZkAq+4y3mGaT2DtJQvkn0bID?=
 =?iso-8859-1?Q?rMkS3AXkhsbalYDnWki2bq7l0HCT8SvtlnzP2IIANcWyGk2NC89z0DoUPJ?=
 =?iso-8859-1?Q?tFKkQzbzXyTZzsRL5elGDRpDVVyQv1CGHz/WmfmdL3evRwcJdE/O3wAswb?=
 =?iso-8859-1?Q?0zDncImdUMEARkQbD6KyrNhWBCldNdSYaK6dBVtUGR3o1xbs0qXlmQQDc0?=
 =?iso-8859-1?Q?VeN9u7l8mBT0J7pJV8GCGNAxVorCEGa9EHQKl2FAIzmzHVKm1Sw7vtAwel?=
 =?iso-8859-1?Q?GSbYryAlYwwxYChHgJECfXxLVCDhAv3Fj9STFWnEvcrcuTJ0n0UrqLRhYW?=
 =?iso-8859-1?Q?4GkhCphhxeNsD9zOsgU2Jx5XwYPPxWTpoEZK8v/xnc+Ozz/Gl5ThhnRt8/?=
 =?iso-8859-1?Q?+2XwALUMSBw9NYL6XiZa0UMliY7qjweaTJkiwu1HKKOVehU1qN5e3dP9c+?=
 =?iso-8859-1?Q?VO8AgDyBPRZ5CSoRNY1OvOk5YnSTtq+A7hZvxby2sP/BME/pJes0onW2tr?=
 =?iso-8859-1?Q?k89YCZBY2B/vrdxC0H7KZ8wfxme5PYU+65SlX5xmRKbxhm69PdT6HG46gy?=
 =?iso-8859-1?Q?XgyzjEq4b3v3e30/ieK9AYkzabesTbdy6Cjtxk6FWjUV0xBtBioZDc1a8E?=
 =?iso-8859-1?Q?XHBgbDQ3r4YtsKE1+UFdu+Nv+pgMHENE9N?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB5748.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4705648-a379-40eb-cb4a-08dc845c59e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 06:05:35.9656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jy0Hpa/nLzViUqDND2sZbD/xJ4mnx6dkYA2T5Xx9CJNaDRm5NjbAWA8cOa4UtyTmLqEBP1rhB6SDi8rfJ4x7SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6165
X-OriginatorOrg: intel.com

=20
> You should generalize the existing functions into some other file within
> stmmac/ folder and call those functions from both dwmac4_core and
> dwxgmac2_core.
> Do the rework of existing function & callers first and add the new bits i=
n
> another patch in the patch series.
>

Hi Ilpo, do you mean I should create a new file for example,
stammc_vlan.c,  and move the common vlan function inside?
so that it can be called either from dwmac4_core, dwxgmac2_core=20
or stmmac_main.c? or maybe I should just consolidate them into
stmmac_main.c?

> Unfortunately, it's hard to catch copy-paste like this from other files w=
hen not
> very familiar with the driver.
>=20
I totally understand that, while I think Andrew has already call them out
In the previous thread.

