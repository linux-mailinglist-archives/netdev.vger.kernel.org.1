Return-Path: <netdev+bounces-219808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB6EB430F2
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 06:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F276177F58
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 04:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4575523AE9B;
	Thu,  4 Sep 2025 04:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HqVDUXuv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB37B23875D
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 04:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756958997; cv=fail; b=guRgwaU5CsTnaBXmn//KcM0cTDspnphs3uP9hNXZw5oIqrmXMkXRpi1iADr8tx7iOUMxN1vSNsZCnozAkAAe7XMiacg/FXK5RkdszFlyp18XjziTNC3/F+W4ANvJWVzK56qnCYl262fMNmH9JWd/I31bi2BR9NObVCTwG7n/OHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756958997; c=relaxed/simple;
	bh=QCxJ24oNiGARp8eQmlWgv4bH3yqA4t6/sY1kQ0L+AQ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h45FTNi+e0vBe9TqrTSTTQXbkYX3Da56rM2pGfzLn8j93YX/29dD7KSBbt3S5xioR5DTbV/l+lJ6NfTXja82jgUOc7vd38mSflo66PMzKfQW5gJIqhoCEdSzDRWGxvc/y+knRGwGqBsEz6rNcvTBT2Qwkl3TrRguyuaQ/7dYhgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HqVDUXuv; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756958996; x=1788494996;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QCxJ24oNiGARp8eQmlWgv4bH3yqA4t6/sY1kQ0L+AQ4=;
  b=HqVDUXuvwFZxpxJq8nl+pTQAVXkcJapuYmMLUOD4yeoSwoAWz2yjz15G
   1i3yYp+GW77xNcY8cnyMjPy6Tmz3/CFwi6ZyWZ4bnTT6X1G2oqR0jfcjS
   CmUqvAOxwnKHWwKyDGOhXTRRKa1ygBKldSJ0IZpXSXbdmd/TzUkzxpsg7
   92jCvOKwug+c9P+fxXlmMKS0FUnp0KMMo3ZvQAs/d8PtLVArMhQ719kg8
   TTo+U5Prs64zphbaJuE76s7b3HJ8dIsvfOiPqI/nkSSeG1/CE0LtZgu9+
   ZcxjOvWGu6CHwpCpTVsjKWh9VCy2ftK87ixBxF9Gz/izC0MaLLQQrGQz/
   Q==;
X-CSE-ConnectionGUID: Q4czsf1gTX6IWKYfs8dd9g==
X-CSE-MsgGUID: E5SvY/FlS1GgHOsHO/fU/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="59226830"
X-IronPort-AV: E=Sophos;i="6.18,237,1751266800"; 
   d="scan'208";a="59226830"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 21:09:55 -0700
X-CSE-ConnectionGUID: CcvcIYGcTbiWjuwqSRj0iw==
X-CSE-MsgGUID: a9qiWoMGThWo6KgcpK8aiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,237,1751266800"; 
   d="scan'208";a="171339859"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 21:09:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 21:09:54 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 21:09:54 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.62)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 21:09:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nYrx+8aKimNXkrHaOKwfGTpJWiZQlNCaN1GXtsVm+FnDxsVk0zrVkZc1NI6FkQf8woUi741cVZlEvB10eilCr+rf+SoUlE28bFwEGo+uiO5WBgDqhTneBTO3fVH918HnVgFXP0WKjxCuqxHN/XLL3BstvbRjJYPnnMb23SQqgxR6q6IyNKepDLMAdQwyVxcCLa8xoYYXKUhwpCT+3xXQnvAq82vQjFdXKBmoXCCVeB9ZFygW2Xln30VKaVyTAbez9w3pRT/o72W2eqfwLq/9n7mbvrCAOf0mulnvJwFgglhD0T7XcSu3MKF1hpTgl3wn8XtdvI98xxeRxr00cFx52A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiaiP8sWQxBL1vV9w57uezJkzKUM5Y31H5UvOwQjgx4=;
 b=f0+ZD/DAI9BKSx968V2m1792ogQYiLPIsDzTSn1HoEeqShjGAwMWt6yCs05NzdB80aFK2xu5QMitIEMBDrHZEcI7rcDb7P9vj+ggyCitrfOm1uCdw+lHV8qXNFq5j7L/udW2KUWuomBsJpJvPJNcTdR1WYUqOouL+s5qLNN7Esjy/fW6X6U8hiKftxrW00q+7oIqHjRg50E0OSVI2UknRVtAH2CVUvc2nhUc434HM7QFwngS3i0gelqDrQ3Bj95SgDMObyqUJ9LrPJm2rKCF+3RBIi9DQ5e2gtkfDr11d2lfgYST9WCt5riMuGJy3ztXOqj57dK/2Y5sSdH/Ex/reA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by MW3PR11MB4699.namprd11.prod.outlook.com (2603:10b6:303:54::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 04:09:51 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 04:09:51 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "dawid.osuchowski@linux.intel.com"
	<dawid.osuchowski@linux.intel.com>, "horms@kernel.org" <horms@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 13/15] ice: reregister fwlog
 after driver reinit
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 13/15] ice: reregister
 fwlog after driver reinit
Thread-Index: AQHcC0VGPT/IHGjATU2mzChRuytp/rSBDygQ
Date: Thu, 4 Sep 2025 04:09:51 +0000
Message-ID: <IA1PR11MB62417E39788F3C3A40DC1B798B00A@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20250812042337.1356907-1-michal.swiatkowski@linux.intel.com>
 <20250812042337.1356907-14-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20250812042337.1356907-14-michal.swiatkowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|MW3PR11MB4699:EE_
x-ms-office365-filtering-correlation-id: e25958bf-0578-49e4-aa14-08ddeb68e594
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?8U+qfegxnqhXzS7IS6Iiul38Yt2KJxmBYmqKe6lf/Qzw6DShEc/AqfKbSzcl?=
 =?us-ascii?Q?lXOt+H7CrURrDsUJW93QUT3YREcTRtGuTL0IV1AJn8X6urDSYIUOKBTwWX2a?=
 =?us-ascii?Q?uiF8XnEzczAiiSYBLYEPgPVEsqiCOLZMf8ntKzrrj7QehPh8z9seVBBFC0g7?=
 =?us-ascii?Q?cXo8WoR2UJBl+nsZp5Z/lmPKmcEh5myrlotizJrQYV8egZCsL3ks2BIEMEUU?=
 =?us-ascii?Q?6J3clI+srMIk1VUJrKn0wayqWtfU+AywtHJ3XWK7Wrw8T5md+1ylvjDbqA5f?=
 =?us-ascii?Q?IDkq9WT6B9HkOlXxG84qbEnVzoc6gTXQYemeTGD3LAU/nuALezd+onuoV/gj?=
 =?us-ascii?Q?0wnT4vLE9ukNcwL+gF1JDCLbYJ53EgtYMBZ/j1ekyq+qEGVJKhNnp/g1iS8d?=
 =?us-ascii?Q?U0TRzwPVJ7Xg9NwiqeiQm/idid/JmjV1JMrYCBdBkzGb3Xizld3LSxf7wx0/?=
 =?us-ascii?Q?vDkX6tVS63UiGBHpaXlOFN+UO4nRQbbCDMNi/I9lKKkVDHHEKm/QYRv6LdnZ?=
 =?us-ascii?Q?nQEmQT8BQlZiWS7T8nDbwVhOWdtM0T+V3es+vLWZt9nuyINMewT9K2GGqwDK?=
 =?us-ascii?Q?kMf5qAqgGsKtZtwZRNjw1UhrF95pAZ4ekNbciWxEKqfJmMMoxMn7bSULTHmj?=
 =?us-ascii?Q?Lkr4PNtVdvDwQWVCj3GwK7ixhtCfzXicusegE7pl3QUtxpY2/igb+HYejQpm?=
 =?us-ascii?Q?J6au2pQ+0GLuggHKGyae5K1SWYMQLn/eNuhoMysJbhl/EU9KSBQ/XnyXWe2s?=
 =?us-ascii?Q?/KdpRUqXv+byF3j0G3RitYNXf6LCLU4ck54MRkCM++kKWqJAwZsvPuLesw+Q?=
 =?us-ascii?Q?bQtYKy4vh5/z0c42VRuAJpStcx4JFB62Tw2YaQIamBHV0rNn6xKRiN6NFjnj?=
 =?us-ascii?Q?3zR8dSbMu41QNVklpO/2bZznFgx7G1LPLizEjYsXkRJJkw5l7wvzffoOAvPs?=
 =?us-ascii?Q?1lADWTSD37wO37471R3gi7DUMjucmqtDX3r2k3jD24mEYmKzBFYrfXPvNfV0?=
 =?us-ascii?Q?2BIhc5uS5d8yPIsFatizca/GmCaAsj2rmjEa0pVXCOd07qvqtJXqK+AEnUyX?=
 =?us-ascii?Q?7PW/uTkPxHxxB+ahIyZGKY9f1zbGs92GqlLJCJq5Dc9xeyJrJEIQuNx+3gfB?=
 =?us-ascii?Q?gg2PET+OnyYqEiGaorvnVY1qNrokO2oIBoZ3yyFh8lC/IgfEuRhi11SS0u7z?=
 =?us-ascii?Q?Ooiw2hvM/JVwGeo6bo+pJwIulyKZOqtQCylmq9vys5CBe68U2EWqJ71BLNaP?=
 =?us-ascii?Q?vvV1YLTYeqnII62X2Z0RqhySb16QKDqlJlEHa3SQKeaLkNu2e+Af9/XYZHyL?=
 =?us-ascii?Q?4WjcuH3stVeaK5ne7zzE3974xi6jy+cE5voRVImiZ9oc2uocH4MzUgMcNsdx?=
 =?us-ascii?Q?u6uCsYil9iTp3i7pIuIPV33cba9uILeor8Ddc6KSa7cITEZ7WNuHK8in/FAu?=
 =?us-ascii?Q?4y3S+Xa81za6qJCd8ercPP352yjNY/xN?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZwTUAaXsueQNVknOqbWu1sy6iOpLYV1Po5pBewj2CFPS5Yln+pDEk+ICE9UB?=
 =?us-ascii?Q?AmQjda4ge7XOzZaPRFg07tulsh8bUfxp815F6lDI2rl/Ngvww3g83SdGNPET?=
 =?us-ascii?Q?SOoMpyMrUQuoybLyLHTbtuqhWg6kZRHwLr+VNwjfHPSfGYl1p0zcGdfKzmVZ?=
 =?us-ascii?Q?oOUwCpvcjMlPl4L54+ogAZs3F3vk/KZwkvR2F7YpJalrKRAZkEMkCvdMENad?=
 =?us-ascii?Q?IQshNcJRxMuoRfzn3HULMJOqkpds42OWv7vIRHJGu97T7/OwiO68FsheoOKp?=
 =?us-ascii?Q?2lbftZjV8wqnHmJZ4gwGkiDjXb2zqFiDWTSDCNvJYQsRMYXOk5bWyNJozrZ1?=
 =?us-ascii?Q?biwILOwAn72TRR8LWgF05Y2dre7m7wdQ86GmnX5PRh42eUsYez5lVN0/mo/M?=
 =?us-ascii?Q?7I3bJ7RuHoGhIIbiLcLokSqPKzTmcoHQCDo5Trl12nAt+vMTsBT8RqD2+/bb?=
 =?us-ascii?Q?6PYgZcojHkQFok3pV/xkwsJmqaRq/1oueIfNciJoCZf8bJ+XluuMXrbL+qrI?=
 =?us-ascii?Q?uNfIl99oAByeE8/uR8zF1ZEA0M1ip4wCqKzWsF6w6CXO7V4Ktrwoi73FLmXG?=
 =?us-ascii?Q?e2xPejbQHK/CZytR4cizkECZSmBYAWXKBAXcKOr9it5ESd3ZqgCJ9bLFM3yQ?=
 =?us-ascii?Q?u2wPxp0ePHx9ibakZOSYNtYhiEYuHtA8Na1znDrpd0keej44Xi8LYn4nAm6s?=
 =?us-ascii?Q?Y6ilGXbw3YtKB61CIkDilxMIXrPazNHdHTt5YOufECm9CKwxc9eo4coeh1WR?=
 =?us-ascii?Q?oO7hk1ho/N6xMcdhTYrYkJsK96om92eJhnY1T8XLn2KVU2vaGSDj57y46TzS?=
 =?us-ascii?Q?bLFMI94zw/60GJukw6Vaq5lbDCNc1Pu+6BGOJ4iFCiPAVK0tQDWME363GuVt?=
 =?us-ascii?Q?1fPBcTOjevNsi8Mtv73qnP1vLIMPW4U4aFaAHAH5f0KKFMAa+ABfo/T5qAYR?=
 =?us-ascii?Q?vQ7Cz1Bp94d50Lt+yAon46ZGchbaO+DjtdpKXvEF3PqC5pgKRvX6IuOuVFSQ?=
 =?us-ascii?Q?xg95r/4y7nDsPQ0hoT55EEgn52tENm6YF/OapSXVcAgaD9whSZ3LNuJQXIzM?=
 =?us-ascii?Q?VE6RIm9A3nrkro9OsHOeNlDPXl2ZrXmcrHE2aqqmoN/LCjMMIQPdVkcUmXo6?=
 =?us-ascii?Q?eanqKeuDkOGpqxUYxYnLEknWTBfikYuVeKQHBGWLxUa2XdO0m5ycN5qyJk5q?=
 =?us-ascii?Q?SIUucw8pnMk55MW+WIkJcbwY7hEUinR81Ajww6GjNf2CfdlDNFHLbBCUfCpZ?=
 =?us-ascii?Q?uUNtM3eJYttQFn1ew0I8miGgxD/2JfRI4X8mQr5nq47soCXW2xPej3YL86bt?=
 =?us-ascii?Q?8a/r8y/wxnVFjHHsvI5o1TfqZpxbNAgg/YdpaZGd07Txw7jn3ut29lHZh2j+?=
 =?us-ascii?Q?Y7ka4YTbW2JLgCQHa2Mykt7d1abf16PrN5+qcEA2EdOJ+ePhs/OZMyVT3blT?=
 =?us-ascii?Q?SltjEFCTxHmR972Q+ggMkQGND2MdCzf9y0e2tgT6oqFg7Zm4eYFW4U/s6sRk?=
 =?us-ascii?Q?dOj01s4AmK8boDL1Jo3yJUz8cFcvTYHJvTOpHnTto+9nd2ycy3Haa0c90h8T?=
 =?us-ascii?Q?CRJNwWQtlDh3IdMRLvW3K9rN66C0lJSeIyn9eP5V?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e25958bf-0578-49e4-aa14-08ddeb68e594
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 04:09:51.6498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9nqRlzU/w8ENcvAtIKOQmalmzOXKtR2YiUIvFKW9kV9MbeB0OgI0Teah50Mq5xRCoOTf0ARyrHFvzNH46lkWBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4699
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
ichal Swiatkowski
> Sent: 12 August 2025 09:54
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kitszel, Przemyslaw <przemyslaw.kitszel@intel=
.com>; dawid.osuchowski@linux.intel.com; horms@kernel.org; Michal Swiatkows=
ki <michal.swiatkowski@linux.intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 13/15] ice: reregister fwlo=
g after driver reinit
>
> Wrap libie_fwlog_register() by libie_fwlog_reregister(), which checks fir=
st if the registration is needed. This simplifies the code and makes the fo=
rmer function static.
>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
> drivers/net/ethernet/intel/ice/ice_fwlog.c | 11 ++++++++++-  drivers/net/=
ethernet/intel/ice/ice_fwlog.h |  2 +-
> 2 files changed, 11 insertions(+), 2 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

