Return-Path: <netdev+bounces-248065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC26D02D19
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 14:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8AA8300DD87
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 13:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD504A22F0;
	Thu,  8 Jan 2026 12:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XzkSR40i"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CE349252A
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 12:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767875294; cv=fail; b=Gy8pknvwCAYLgRdJQ6Z5jwkfqYJVGSUPa2brvhmLyWE9p9aVbgdvPh+2ST+WnRKQuHeo2rDedvqVH3CTlEx/R/RIQhL7WdgLDo9SX98cqMz1d03AKXdChX4/mLSjI6Ce3Jv+WWO+g8IzTA550Caci3jkvANxTTJ6eVUEa/WLwc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767875294; c=relaxed/simple;
	bh=uveHdGLOb5P1xaYu8tzqqA22Lm2gCAtbAbFjxxlwxgQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DxD+QH5p58szGmmG+NrlHrL8/4UT6Enmfo9/kGUWt3gVbIXFevBAE4mR7xgBDM99HSPtm/3j5/V9g/S+Kmi93EtMi+C1ZMU1q6m7Ysq4c5ygDGmwTVuldI/6Aa0Pvrp5kbldj9OuBCAOOWZhZqYAP6OzV1rYPfjxbKhh7e85CmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XzkSR40i; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767875292; x=1799411292;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uveHdGLOb5P1xaYu8tzqqA22Lm2gCAtbAbFjxxlwxgQ=;
  b=XzkSR40i+WrD1z/RiNwnGULdwur5mcoeqL87QlLllKNm9KXVb99ejsOH
   LHoQn8+Mb3SyfVUZbatVtNuHf5MTCXXIWySswHCBckPOugn8X+hrIhqx9
   yCRAg1XhRDQLo2Dnj42SUFjRS0SgmsamqqaHa6HFO71tlh/YtutBzb5ym
   n394KRoPHCb86v2Tlw9s+C1CZ3T4BWgmIt8tE5W/yLnve1uR7G8ei+Nmn
   Z1Ef9aj/+LNs+FOm4X4td0GSQaImlrakX1rsg6j0ovmtbH4G5ysNm7QM0
   yhvgZtm+VYiC8llKkOHzsWrlHbcDsXkbpdPnFHBnFdVvGZ4IjF4jnmzu3
   A==;
X-CSE-ConnectionGUID: 9d+LXs5DQcqY744PyP0e4w==
X-CSE-MsgGUID: qU4+i07VTcebMpnjKdMcuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="80615484"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="80615484"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 04:28:10 -0800
X-CSE-ConnectionGUID: pIHOyl5xSYmxATBcfK65hQ==
X-CSE-MsgGUID: wO9NCt5hTFWoKS7sUVO9+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="233907707"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 04:28:10 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 8 Jan 2026 04:28:09 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 8 Jan 2026 04:28:09 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.64) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 8 Jan 2026 04:28:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lipfDMFVA/kb70JnXjxdy02JLw7doCKjXslL/bqX61NCrkIvLjHU6LQKjM/eM6PFcSD1rzMnclzBHOEmagIQLlR4uiV0XDVfkRMQnuRJGcKsimXz+CiZ2Og3QpB4h8y6R3hohHidn8lvUmjsJYlt+vdtpiafNfgIRl8+k4Q6Occ9tDInDFoyn1M03YV8hmB+M6W9Y07lgVfsazjadxQdIi6EVsWYiN74Jh6tOjZCd9AwKkjS21+AXl80C/KsD6fSvGck6Zagj+XnWD1w/k58oCXGPUXlILe++QZdcbmpuT5EcPsMfzvEloc1+qEJhasrraZ4ojov0P0vml/IR2vO4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DqH31b8OlknIzHQPKkeesGn9/n/C1NCQUTgpOnyZtPA=;
 b=cs/st2TbZFLsqrDp2hwQcs8uVKaB5q9RY080YhWIshJsdvzPZomLshfB6BIqteNe/c9GlFGNcccS9JA2yaTNj0hvEpnPG2dAiQGk1/kMlAhCmGNtv63SSlJPyZr7V0K8oiwPY64vGkq0nXuv4+ltyrveI+2hw0IExbMHfPI45nYs/+32U6kZCXuvc2DiftkVq5EzbRfhDmaP7RgIPYbbrvp8DweqpTmfU4uHlaCwQq+Hv7MqBSsB4QUrCVctVPjAWnGgx6A4gVTqnUrYAqmsM8xGKVN+Fiy9AfbVfpw2hBe0SHiz1tQbo5hsBT1X1UHgFCRjEtnTQ4/uGMYa4tVgkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by IA4PR11MB9372.namprd11.prod.outlook.com (2603:10b6:208:568::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 12:28:07 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 12:28:07 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Kohei Enju <enjuk@amazon.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, "takkozu@amazon.com"
	<takkozu@amazon.com>
Subject: RE: RE: [Intel-wired-lan] [PATCH iwl-next v2 3/3] igb: allow
 configuring RSS key via ethtool set_rxfh
Thread-Topic: RE: [Intel-wired-lan] [PATCH iwl-next v2 3/3] igb: allow
 configuring RSS key via ethtool set_rxfh
Thread-Index: AQHcgF7gmLGugxsz7Um8qgZKBPTLwLVH29MAgABRLACAAAZvwA==
Date: Thu, 8 Jan 2026 12:28:07 +0000
Message-ID: <IA3PR11MB89865D0189D37BB3393B57F5E585A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <IA3PR11MB8986D6E9C30B7FFBCEF64394E585A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <20260108120400.75859-1-enjuk@amazon.com>
In-Reply-To: <20260108120400.75859-1-enjuk@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|IA4PR11MB9372:EE_
x-ms-office365-filtering-correlation-id: 4c21172e-0440-47a2-a108-08de4eb160a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?69/bY6+NtuwWCaWb9CSAnSlE5QZVjGWbxa/pJlM3TGp7bLp4vQGAiPmpuY2K?=
 =?us-ascii?Q?yhTwjtfyLei89iyULblAiJm0sqZFzNMdtx25t7HTb9vfB53K7m1IdqCYGAsR?=
 =?us-ascii?Q?+QiGRpmlwUkfKSX5l6lLyjrEOsuyDjcbphZTFvb2VfXEkqT6OaH3kjJ4qOk9?=
 =?us-ascii?Q?wf18EqXNF9W7plC6lNPFNTjUHpqQzACq0TlruVfuqAQAMPPqK1eE94lwepdw?=
 =?us-ascii?Q?imXDyIvj1rQ40OgffZob1d2OaxISsfZXtoZ2swnwJFKgMAmMM0xeeFcrC7D2?=
 =?us-ascii?Q?1n76/jIJLl+PKaVYyZMmGVlODAksNXvIw0cHoidZoOqqNZOdtKhfmHObZdvc?=
 =?us-ascii?Q?PzjfM4DiW/4vCrX8ST40ALq4a7sPSPlbrGKoTc3pbnKOUXNFnsr/gTAhw5fz?=
 =?us-ascii?Q?k9OqN+bcge96cylTt1n3lIi/b6zW3+/c2BijF4BWRAld6TmVOnK2ApnXjUcC?=
 =?us-ascii?Q?g0/LcRYys7zv7NKd4rPdBmmgwBk4PB/fhgNMcWiNKUIMIgsmLYTgh0f5WOBc?=
 =?us-ascii?Q?r7WeptA6DCI4VvB5OSvB+g9spRQvXExaoSEwDmi3UbWMwlVspY+RY/KFywGJ?=
 =?us-ascii?Q?S1Z8ZOngxTruxlzOHVQoJBKldZGOD/0yVueOhvrm1BvXlQwlO3i4rLHIh+NL?=
 =?us-ascii?Q?DZim6x5MbeLA/kCkYMAQNBCMXFtgG00EuwcdNtME0XcHAtqgwCJQcPbRKabX?=
 =?us-ascii?Q?dyr8iODGl4CLAhPp052fNiZysMgK+7LNPl6l58qS+5+HLkwj0w2wL5wTz5Zn?=
 =?us-ascii?Q?63SdPk4hiZ90Wu7bb/iBEaliWtMQaV3jeVr5nY9D8JWBP0YnUXym5oxubtS+?=
 =?us-ascii?Q?V4rmk/HbEAwb1TV4iX9kM9EPQsF8TNWlKUtKbqjCS4upceSLJdOqY8ntnhbu?=
 =?us-ascii?Q?r6BkdVN/tget+hlVG8ObeHVCJN5e3HqEZZMyrsvYdU5qCfw34WbDRo2nCRCc?=
 =?us-ascii?Q?QCdiME0U5gk11h4Te3SdVJPmeSgM1bGRxXlq7cpPMEw9cmThpMCJhhBfbH1o?=
 =?us-ascii?Q?9Bc+6UOhLlCnTuX9QewwxXdhwbrFhoBkGmwbVfTvP13zfJCD0OleJFv54F/C?=
 =?us-ascii?Q?cF+Ayj7F1aiXR9GaxHHAyqZsxCfAQND+IaVds2EXaQneathBVQinZgByhncp?=
 =?us-ascii?Q?lWElpTaq1HYhm0qZxAvSqdI1MHtUVJZbAC/qTEU/nfZHHja9h24+iLZuf9Rt?=
 =?us-ascii?Q?ovNT0MZ3ifHzIK92/S2VvaQrTGxitIyAr/sKn2rVBLiIpbTGYEuKREpLheje?=
 =?us-ascii?Q?2ragk8RanndObkMQKz8sKBndARpn/mdxvvIHtlOc5G9oeKDyLqq1kCqXWnDl?=
 =?us-ascii?Q?hgke36AeCjwsjyd+cB5BhdxutzG9Kzh0DYCUW90Jm0QKjHAJq1CnOhttyYFB?=
 =?us-ascii?Q?9gzrb9ZAh+YBKg9lQeH5jcOu9i9vMN/yuUpt/leKsre8wifsFGJmx8vIRNJj?=
 =?us-ascii?Q?eiDHXI6bJmJHGuwfRqpOND6YY2F4Dp/77CVp4vtSKRh3U8vcOlJqvPvPQ30D?=
 =?us-ascii?Q?5h+aOhkMj+mL1AF0wVfmZ4K6WXp9Zf7VVIfC?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2YgPRS1sAgFlsPEXmDdKMebsr2GvvviWxg9OiBxFVSLK2ozVz049P02B0ezg?=
 =?us-ascii?Q?3z9m1qLeT7FxRF/WkLQdQJUwwH3hUnJNprl6KLOse3k2k4HY7BZ48TmIQr53?=
 =?us-ascii?Q?6u4X02TyV0pm7OkWLCUHlQSEQsLkGzq3n3AjhtZ1L81cIet9CKz2Io/iwInD?=
 =?us-ascii?Q?zdHTB1Mcx/yVNC8AuBqGO5S4jC49kut2lsmYw4iBwjC7A9uw6VjfRnMysyfy?=
 =?us-ascii?Q?qU4dZ22Q8aDEkAvUKZoJqZYBhR2S3N4oW0QWMqDG1VClCCa02lejgC3i3sut?=
 =?us-ascii?Q?mF6KuA1NEhcb4B3zK7n6ZQORZpKWJGKk4o63KoMPyk1kclSFaWmuMjyZqZtq?=
 =?us-ascii?Q?zTFTVSvu4hVExfN1tWBBEGCbh6FaWxB2HiJ0hEotkUzxDWjDUXSvlNRWNp0A?=
 =?us-ascii?Q?08y4bl6p3rqCSrS7JXMCbbdVURYQkmTCIyoaj1WagKyQTcLGEK4hM7PJPxnw?=
 =?us-ascii?Q?f5AL1V0pRWqQKp3nZEGPKQ6RkEThBiyxzHGGw0+X828wKpYMvDK44hGXQ1HG?=
 =?us-ascii?Q?y2poGjJemaj7ni6WOTR/eNq1h2yNygg5ocwRCOHZ980Uq8LaR+oUnmXTuYlE?=
 =?us-ascii?Q?HUnaYxhtO5QDNsG26kyZvoXG11Z8d8G4I6watNbgwSdoS72gldidAphEtQRL?=
 =?us-ascii?Q?uHS8H6rJ6Tlljvs2LdY7529R3HnyVPTP2SDPGX7rsmrxy6If9zvQ7Wu4xjwo?=
 =?us-ascii?Q?Z20hTf8hpVIpj+66qbWiEo+iMg3GNea2R0JTpX8/OYPkIMABrmG4IVF7yoIb?=
 =?us-ascii?Q?R1By/u2Cz40XV6aAUYNm6SKXmgn8taQdZdyTpi0JOPt2vDQVR2hrb/Z+QEna?=
 =?us-ascii?Q?5MHxDHE7KHs8t5amBIDAE+IgV3PVeUsEllGt4db03xkmhlWKc0HUnRz/EGYt?=
 =?us-ascii?Q?OcCHOFrCDW3rNaIBUwTlZ3dhSZSygP6lhL0aNzeo4wwmyjXQjmGSMKzOPRml?=
 =?us-ascii?Q?JdrST6KMQVfYfJ50t/qWQlJaZK+RLhTeM28EI7lAU4ustnBF2+bVonGizljF?=
 =?us-ascii?Q?imFeOhLYp7mhEltwtHlY3ddSmQQ1gREZ4LdIYWPeSMx5QCQ9nVKC53IZ5Xds?=
 =?us-ascii?Q?NVrfKbK/oIyNQ+CGrmlEQYHYkv4xqEsEsDYw3GqPzSfOfhrVcMIDrD1TOIw8?=
 =?us-ascii?Q?hLcpA32FNJ4HCi64t/ASrrAXSt9Jqn7gtonnGUc79vEI5k6iWVi/Lki0zxK6?=
 =?us-ascii?Q?M5qZegsJ1AVa8aTydDzQiPCqB4B0GGAiUJarU/qju15V9IGgo/UDWzFgSprW?=
 =?us-ascii?Q?wA2oDTUZcM1Fj2S9YFxpG4WV5Pi1ypwV2GBXkY6g70MOcKOPQ/n6Re99l0TI?=
 =?us-ascii?Q?hYaD+nxRJV8eKw4QCC6TAyPyK56qhBqbQ8atPj1P6hDGLhrXv5g35Z3t5vfh?=
 =?us-ascii?Q?pwPmHN3o2Mkywel0Qqx5ebDqYd5L0soqrA5MH8AdYS3oc0iiUDAlXvgkplPy?=
 =?us-ascii?Q?JfAVLH8J9Cq+LZeX6fyr+y0MhmBYmnkeFNDEO2ZWf7L8NEh4RaLhBF5+CoAn?=
 =?us-ascii?Q?WoV4wQ6FL/8IjtUzOsd/O/pPJJjsx0xqnf7WZvHW+Z+YRgXiPBp94iYwCTsi?=
 =?us-ascii?Q?Kc1PLJg/V1V6pgu7o6yrUbVj2KWwjziI6pEMv6HmdDvZHeUml7fqDF3ImsXL?=
 =?us-ascii?Q?NLUtqaPxlqB7FCKTedJmS7M+vWgv/yME8u7zMYBR4QM2AKFZwPBpbbG9l2uR?=
 =?us-ascii?Q?hvKHPjYjJm15AV5UVA71Vq12t7t+ShYqJ6Cj7GZNWfAe9omQrcipFIdsXM8p?=
 =?us-ascii?Q?cjcJrV8PyZXBHypq8qRuJGsgWvkms8s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c21172e-0440-47a2-a108-08de4eb160a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 12:28:07.0632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i4L3fonyrCav+x1Ha2hSTjOll+dibQBXExFEPCo6lkfVS5gad5rLN4HsFf5ZUbM+CuRY53ZJw15ltg4i2DRN9wuue9WmDGyD3RqgvvrBwSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9372
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Kohei Enju <enjuk@amazon.com>
> Sent: Thursday, January 8, 2026 1:04 PM
> To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: andrew+netdev@lunn.ch; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; davem@davemloft.net;
> edumazet@google.com; enjuk@amazon.com; intel-wired-
> lan@lists.osuosl.org; kuba@kernel.org; netdev@vger.kernel.org;
> pabeni@redhat.com; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>;
> takkozu@amazon.com
> Subject: Re: RE: [Intel-wired-lan] [PATCH iwl-next v2 3/3] igb: allow
> configuring RSS key via ethtool set_rxfh
>=20
> On Thu, 8 Jan 2026 07:29:19 +0000, Loktionov, Aleksandr wrote:
>=20
> >>
> >> -	igb_write_rss_indir_tbl(adapter);
> >> +	if (rxfh->key) {
> >> +		adapter->has_user_rss_key =3D true;
> >> +		memcpy(adapter->rss_key, rxfh->key, sizeof(adapter-
> >> >rss_key));
> >> +		igb_write_rss_key(adapter);
> >It leads to race between ethtool RSS update and concurrent resets.
> >Because igb_setup_mrqc() (called during resets) also calls
> igb_write_rss_key(adapter).
> >Non-fatal but breaks RSS configuration guarantees.
>=20
> At my first glance, rtnl lock serializes those operation, so it
> doesn't seem to be racy as long as they are under the rtnl lock.
>=20
> As far as I skimmed the codes, functions such as igb_open()/
> igb_up()/igb_reset_task(), which finally call igb_write_rss_key() are
> serialized by rtnl lock or serializes igb_write_rss_key() call by
> locking rtnl.
>=20
> Please let me know if I'm missing something and it's truly racy.
I think you're right, and I've missed that missing rtnl_lock was added in u=
pstream.

Thank you for clarification
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

>=20
> >
> >I think ethtool can/should wait of reset/watchdog task to finish.
> >I'm against adding locks, and just my personal opinion, it's better
> to implement igb_rss_key_update_task() in addition to reset and
> watchdog tasks to be used both in reset and ethtool path.
> >
> >What do you think?

