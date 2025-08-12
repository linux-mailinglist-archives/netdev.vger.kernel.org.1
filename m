Return-Path: <netdev+bounces-213020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7D3B22DB6
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 18:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42CAE3A54D3
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 16:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C8B1632C8;
	Tue, 12 Aug 2025 16:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UBt4NQ/L"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CFC305E38
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 16:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015995; cv=fail; b=FTzYqzVzuf97zQ7Qzz+3OPTcWNwPhCQDOrVdOFAPrUeBDVu+aMpViNryZgTxtcY+Ah0qcMkFxZVS8zj06He4vtsaO2xM1VMsGCrXX1mInszEec5T2G8LQIZVuzz0qCL7/moswR9FiXOxxfvdKqWAEykfPdtIqlbOpUMErezv/Ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015995; c=relaxed/simple;
	bh=YYSugs2IxxC5Kfd84jzSePeQv+ynU5132XUCrWeHzk4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qLU3Tthfoghd/SHGvs7cerA+67smGjr5DjzyZtj9QyARENw7GvFGmMye/Peo+HdC37rIfgtgsfe1dQt3H08rdtF4FXZBKT/eJdLHptZ7T/nH/gnZP3uo442Ko4z9AbUKzYgke6s4xwuVTN1lPod54vOc3Yskkcn2CYgPwtjZIOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UBt4NQ/L; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755015995; x=1786551995;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YYSugs2IxxC5Kfd84jzSePeQv+ynU5132XUCrWeHzk4=;
  b=UBt4NQ/LNiNWQ8ung3cf4PxP3lHj4pUeXmuNZfenlffQVDxQIcnj6scs
   klUpOXE+KfAjqmQPwlsvi6NuQRbyiXhnNtKhrcNMz8pLOCxcAdCc/8onP
   mSOCpiLNORV4fPhTkUvxNQvdpZMLH3vNf+usEkRLCmGQGzwK1A9zSZbwW
   Y4xcTItGFWY9Yrr24ZYvzXlU3msBJSWlsdmCqRCc0/wuMfmNCL5h2vUJi
   AhqpR1kHamLdboijzBLOsSOE43WMNYYalptDRfMVLEkZhhkGnQN9/l7fD
   4xzbgs10AyVfy/wYQgnEPFRFlKShuslhaExCYjyEeNw8f/km6JuN+lQjg
   g==;
X-CSE-ConnectionGUID: ov7cGZBVQaGfRBOwQlh2/w==
X-CSE-MsgGUID: DldFptVDRC2LHdFdqDX2BQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57378578"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="57378578"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 09:26:34 -0700
X-CSE-ConnectionGUID: mod2YOC3TtahsHlyVYZYSg==
X-CSE-MsgGUID: HWpBqtuOT5CfcO5e7zPyLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="170457743"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 09:26:33 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 12 Aug 2025 09:26:33 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 12 Aug 2025 09:26:33 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.40) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 12 Aug 2025 09:26:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=clfgL6+DJXZViAFbLMD8l2Re7DBZnG+pO9qUZDwYaFgUsAET95K64otn/0jXJOPYn385exfbSubtW3yzYYGVlzA7dZpWu7bZhg1nyBKWFu4xFIkXdbdw4IwBsUQqRfqqAC2hWl8MDOQyXgkcyV15MqJ+ya4qpsJNZ90wBhPU53H/1c6SbCvMl/mlaK95p044j1Af/CbHg6mC9IbKCX1LHOdETHquw29iCGioqqWDGEgw0wqVq2JL5EHqB5po/gPEuVJz1rU0OOgG17eDpmXg7FpBfPDJk0AGboo2LMgEfKwDAX2llYmMs/Aq56lkDHz4k4IrWpjsosGavZa12+4F4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpIcdPAMm3+DXGqoXVzeFfsGebbH99EKRzA6C93OpR4=;
 b=oVl6uWRIPrjP4AoU9ZFbzORDc3rGCqabOD7cNylx7X06gjSDykKiFCT6OFAMlpMMr9hrm5dGj9DT/kq+1d+iafbKBFRR1pDlIwgr8ctJYXSvIsoNKTGGFEOiGhzoIdEewsl6DghwNiwaIgwkQwm1KgLLAITfsFNC9vmma60PzYYnUa/kiIv8SNe+7W94cH8VECI/QVYFDzZJwLgFwUhzLFwxtEB3w3GY4PnngnyWORiZHyceYI9x6yXNcgylb2jKZhexlyr49BD6Wn5D3c7A52KxXwf5dmUeqPN6hbEOpP6x18BlAgawHnbS2OzelHKeCOuhKjLVycIaI9PaLVa/nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF7551E6552.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::31) by SJ0PR11MB6815.namprd11.prod.outlook.com
 (2603:10b6:a03:484::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 16:26:29 +0000
Received: from DS4PPF7551E6552.namprd11.prod.outlook.com
 ([fe80::29e3:35cb:6d5a:4d7b]) by DS4PPF7551E6552.namprd11.prod.outlook.com
 ([fe80::29e3:35cb:6d5a:4d7b%3]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 16:26:29 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH 02/12] ice: split queue stuff out of
 ice_virtchnl.c - p2
Thread-Topic: [Intel-wired-lan] [PATCH 02/12] ice: split queue stuff out of
 ice_virtchnl.c - p2
Thread-Index: AQHcC59J0Krk/bLUOUaIenzjdlSjPrRfNE8g
Date: Tue, 12 Aug 2025 16:26:29 +0000
Message-ID: <DS4PPF7551E655265834FCD26747861C180E52BA@DS4PPF7551E6552.namprd11.prod.outlook.com>
References: <20250812132910.99626-1-przemyslaw.kitszel@intel.com>
 <20250812132910.99626-3-przemyslaw.kitszel@intel.com>
In-Reply-To: <20250812132910.99626-3-przemyslaw.kitszel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF7551E6552:EE_|SJ0PR11MB6815:EE_
x-ms-office365-filtering-correlation-id: e6b5910c-6656-46b2-d661-08ddd9bcfe2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?YqeJEEDxRm/kZBZwpxpCbNrB/hbo2jUSp2hQzEDZip1bRsv06Eh19wpCkx9c?=
 =?us-ascii?Q?kNzDPwTFv6sj5uc/9ROfZ5grBxv5GysFrliRJ18ht+lGCxl7HFIbNFQKiUZW?=
 =?us-ascii?Q?qJZkQiStsl8WEjbdn9OjvblP9fKCkddmHAfz8STjKE1TQN1wwHlAF4Vt9sl+?=
 =?us-ascii?Q?47kK4EgHwrNwsi0lG/yVV1n6S2TciBLSkob1Brqs/PjnZfMtzcTSEl9NGhYp?=
 =?us-ascii?Q?5p10C5PzvnlURjnKsrWgiI3qXnQ7Oheng+mcs2oqCnvIQyYVuMOJxZTKrXzE?=
 =?us-ascii?Q?daUgkS8PilPoecSIfXtP8zOWrUtOHOnZ3NGlRL1fgeMwalZQ3uwhw4olA2yR?=
 =?us-ascii?Q?VichrmHCXSeR1oFSd3/WrsY5l8kkuzkG19N7qdFr7TrO6eZC4ldj3ZHC+ekW?=
 =?us-ascii?Q?1Az7MPBpPtTbERJtScHq6Dzi7Agp71erWWO7sYZCDbJIthJnSFb337LGW1xZ?=
 =?us-ascii?Q?JEYv/ZZHU8WGjhhwsUrPkf5907UOjCgN0lYPQpct7E1miG80G2xkO8iLUA3O?=
 =?us-ascii?Q?TtwRfTSBc0kEDxReP7o96VX3S7nIVzOIiusXRLWWrC/yHTPCzamvfR2yJGrn?=
 =?us-ascii?Q?ePbYzDXEf0f0EICoTgPama3R/io+UDMRHjsOFbB9WEQO6bnOuZ5C3KcZDkZR?=
 =?us-ascii?Q?ZUDEBcCvI7NCveCj2qZS/O+UvDz58Ne9CtElsY301zgxD0+ZpXTf3Qjm/8Hg?=
 =?us-ascii?Q?rzYyoNm3lSdWvkJInTkSnVCJ7QnUrQSJIoD8xLoem9+LFxTroC6A8dQgPE1R?=
 =?us-ascii?Q?DDUP2qjkrq8YzQynnLCizkJT24scWu5CBal03KU1sBlNOxyFCdf52Mct6cjd?=
 =?us-ascii?Q?nDHXgrOtzRcosF1e7FMbNau79tumjnDMPQe1rPL5YbVjBqBoxpDhRViBthMQ?=
 =?us-ascii?Q?NnVzC5fgM9VZhyrBN0I7R0n7rYVlwoeaKhN/kHDayWrfjcccwBbnJJzXDD9S?=
 =?us-ascii?Q?9YcpmFfiwXLvBiFgLKgnVCI3AJO6SrDUNMQ0fw7kPVDeqoEgrIgknySraP9S?=
 =?us-ascii?Q?QmAlnug89RHXMOm7Js0owzyDivZ7MMynHLY4aie3/R1Oy04k7smNgF8Im1Q2?=
 =?us-ascii?Q?LZd2MnSNZScOaH3hFj6Qo/SdG7yfe/MWrX3lqteidbI+GX8tNIfI5WGs9REh?=
 =?us-ascii?Q?H+e/ywyL+5xlokesj64uRLCU+7rM9U13+8dfAqYUKUHIP5UEAMJSIdhMcdsh?=
 =?us-ascii?Q?p1fTcgBifP2lMbBenjlxwXaQVXJdFBdKj91bspZt3NKB4LJ3YJsLh+fh1QEI?=
 =?us-ascii?Q?wffR7kA/wce4VAb7CnJFfdi4CnJMZZhPru/8tdCWsTHty6r01H59SOcTKwW7?=
 =?us-ascii?Q?5awmVQUcEaaaLnd0DW63A/Sc0UBLnRzOGlianWfnK5JlieYs36EI04rxteHW?=
 =?us-ascii?Q?8iuJ5YIHYbLv7cqParmecclRMJbLwPCWElt/SPHRq9yBF48319eKCrbn+vjE?=
 =?us-ascii?Q?PkXM8KaTFKXq3ae152fGCzq18wjNoXiHOEOo57YezWMZ5z0VcMVPOPfE8Z8j?=
 =?us-ascii?Q?a60yRUAKvSlJCOA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF7551E6552.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L+LFlw2R70HgSEoIN48rlWUBKEQrF1rJTu1r2oDoBhYkzZXLKXVAqnB2uXx6?=
 =?us-ascii?Q?BL9IdJZzfrGQZ2JP2IBcD9XpTLjCdu6SIvL8W1nDk9foJgm6nPyio9bkzjhh?=
 =?us-ascii?Q?DRP5YLOUjUH45+Vk8Q5lIkk7GE7S+HwlPyV54Q0kTzWuXhlNlX8Lt/2Jcg+d?=
 =?us-ascii?Q?OsyBG3eVUeLRFHdoky3GylZyT4R9zUiwNGo+RJ+I76/rOA7+8+GD7QgkDLA3?=
 =?us-ascii?Q?kPiqUIW+msMfVpHO/kjUyHZp2fBfdN4s+j99yMgHCXD9kPBAjUfzIo028EbN?=
 =?us-ascii?Q?/qiF/ZPVRD79UrcwD2cfCPlnweXRlygXnARVfD5bx8cuawTUztytW+e2fRkb?=
 =?us-ascii?Q?bpJLVWSESF0BvDqiZ385rdYYyWnbHp6Vdx6wgSCXeQzTfPnUuXhiaQs50IVd?=
 =?us-ascii?Q?TEKZgVeBqY0L1Sc8TvaYaJY1Z50jugVFue0NPWI4ocfSVR7V1JODWukoMhtO?=
 =?us-ascii?Q?NUXiPvIWwHJg8wAyhpk8mN+QHWWYlGYsu3awxRbXl7wnaBaNcBDCHhEINXXm?=
 =?us-ascii?Q?DGvPjt0zK4VNYAvusCG1axBijjG8VEHKV2f7H4Ni3/FBmKFSmH8c0SorcyMD?=
 =?us-ascii?Q?mbCH6yGiH3nNU3oxvsO2ph6u3lO5TwF5rXrFlz0Reje6pfBasmBMMY09Aa+b?=
 =?us-ascii?Q?yklnnvHQ2FyO4NYKZXYg8uxsdwmbHW+z0RJ1zgav8qISmPpekmfaUKhUamUU?=
 =?us-ascii?Q?PeFUp/15/CsAbDc1ZQ4l2j92jJVSHFqlsv9St07AHZ1jxVAeq9LDpbPl6OuH?=
 =?us-ascii?Q?N2kBFQaefD0Tn85tyeOktCFCxdNEHolj3MrGlB6r2k7H/Udnb/nTZv1R3mfb?=
 =?us-ascii?Q?PmuKT3V+EcgSb0o/s8EM0v8A3grGnTHpAgtUP0lY/2cHoVbgJ8lKM8rbPrFS?=
 =?us-ascii?Q?9M/P87N5Y56lea+UEthnjqhhAw0M4zMooY3J0iAT4AEoInf6F6f3Z7L2Trm8?=
 =?us-ascii?Q?2kXrnbjPN8SnkJ0MjbbModL4FP/7RiSY+wd6oTq1pTrYHWzYVRBBSfm9un7H?=
 =?us-ascii?Q?9i4MCHuBKJa6DrEzlgYPtPRAQUoeplGNr4BGohQ7fpbDm2FATTKGIbrgpC3t?=
 =?us-ascii?Q?aZ+2gmDAVT6AuROnid1rbWB3lsPWqRi5pnWkfNnGS4hdKUvBv1E0BvsetSZl?=
 =?us-ascii?Q?gImFS4tnTeTAEbadTy3t1EGB5oKhQySCEmpeYqwccKozEDjV51tZbUKtl/8u?=
 =?us-ascii?Q?8cssT138KqmdWV5FXHr07VCq+9cFiCTRIc13GS3ZMaUW63PpjrlmpJvjeBSx?=
 =?us-ascii?Q?p85aUiGRAc5rc6NT5li62Iz2az/ickMfyFxbSr3Y5j11Sr/glbZrQVjj3eQz?=
 =?us-ascii?Q?k2mlhQYW0JEpJ+Ga5QnlPwHKlgKnFOrnm/peT06EIdn0k8SgNYgzrGZeiamC?=
 =?us-ascii?Q?53WgmzMP5Kvcow1Oemim1+Gg2Jmi+RxKhCJ+dErpL7dz7SOWMcaZ8YUHcuOX?=
 =?us-ascii?Q?Esbm3E9kI3vdINOhNkKPaAizC+gRymz6qa4Kr4BOLtjpV5+5pzeyjCrH2EDL?=
 =?us-ascii?Q?IHp0NDq2ObXmspWXo0bondGqgK4QNtJBb/iuGP3oQoq3FllTjHPatruBMWj2?=
 =?us-ascii?Q?IXVGELG4sroWt4XbzEGnuNfEgIrLwdFKAYSZDzUlNFJcQ4N17nZIwY6oCy1m?=
 =?us-ascii?Q?Xg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF7551E6552.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b5910c-6656-46b2-d661-08ddd9bcfe2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2025 16:26:29.7731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jOfg5Ouy/KaERUmJTbVnqMA5ksc/YbC7L+f4GP5B0cFIJYO4Zetk+U1QWZ0oq0QWWuycoGFGk+ZZZlz2+aTErbdnJ1i30UqAbs4YlvuT/0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6815
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Przemek Kitszel
> Sent: Tuesday, August 12, 2025 3:29 PM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>
> Cc: netdev@vger.kernel.org; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>
> Subject: [Intel-wired-lan] [PATCH 02/12] ice: split queue stuff out of
> ice_virtchnl.c - p2
>=20
> Add copy of ice_virtchnl.c under the original name/location.
> Now both ice_virtchnl.c and ice_virtchnl_queues.c have the same
> content,
> and only the former of the two in use.
>=20
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/Makefile       |    2 +-
>  drivers/net/ethernet/intel/ice/ice_virtchnl.c | 4611
> +++++++++++++++++
>  2 files changed, 4612 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_virtchnl.c
>=20
> diff --git a/drivers/net/ethernet/intel/ice/Makefile
> b/drivers/net/ethernet/intel/ice/Makefile
> index 56aec5ab9e6b..d0f9c9492363 100644

...

> --
> 2.39.3


