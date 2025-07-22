Return-Path: <netdev+bounces-208935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB07B0D966
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 14:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64B9C56031F
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 12:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216FF2E92C5;
	Tue, 22 Jul 2025 12:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IvZDtJYP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352472E9733
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 12:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753186647; cv=fail; b=D8Ybdfuod4FRBYjuCEP7/YEjQnUACFoYG2EmWck1XyslfSo07RBG+Cxw0AoJk6bjqPrY6Kw6oQczjdnR5Lsn+KmMUYUjhBIKMG1vMo9kj5QuICDd/DjgZo3nnf1bdAEa4q0BmSAfWs0Vx1fK1FXPD3Wl/5KAhL7hlhrnUH8J02Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753186647; c=relaxed/simple;
	bh=JQUpsjptVU60I8VgTqrrRxVMsCJseIgBdaz2BerRMbU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fDqDTwfxDxd25K/PG+BKEJTy93Lr6G6ikTb2ViB19sTQut5T3Q0aBncOrSZK/RoOqQPGg1PUrWIvb83UfI8Dvp7CQNahI1SXqFLejRR9M8zJq3VDyF1njR2fN9qUjya4spzuBJvOLxql9imUzxsPSppcRa3uvp942d6RKjzxJIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IvZDtJYP; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753186645; x=1784722645;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JQUpsjptVU60I8VgTqrrRxVMsCJseIgBdaz2BerRMbU=;
  b=IvZDtJYPkJht7XHAu95L8CIEJviGQlQNuKonZKnFE+GsJYvIc5m7qakN
   M4iu6HYHs0IuaxZ41fqzPtt3NEHt9nPb65MO6oEnL7X++0ug1liO0xWmI
   uy96NxTLh11CMQ3K0+0tkushjfWFzmNK3vr5DbRDU+OmHaNq2p0hFas1h
   aARvEqjwSDNS4w5W7/+6RjlPRk5NN7BVzN1zv71eTql4CF6h0kQKwHYBG
   8gqk85VJocMigqh+BIvOrrOj8l3qXuEQHOtVNcjmuG8x8JTL/K7x21QDV
   cg4+XS8SXqRonYiIm1p11TItdj7JK/UKhLewI2J6RpndTxrfPX2cd79A6
   A==;
X-CSE-ConnectionGUID: eknZCPGTSEyoUxhw9TaIsg==
X-CSE-MsgGUID: HhaWItMWQFerazh4RCzI0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55389871"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="55389871"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 05:17:25 -0700
X-CSE-ConnectionGUID: 3aceb1kJRPS56s1O0IeiMg==
X-CSE-MsgGUID: PSwswIX4Q9a6wVrqZgucGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="164597401"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 05:17:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 05:17:23 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 05:17:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.73)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 05:17:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDpxn3YPmF6Y1P2zZWWarMikjV5n1o8zl6uPt19WDSjplvGSV0T2xEGyVyCDVh+7JVwGaDuHSujAswgjl/SIPgzMKREkZR8WF/vyxfVHHyBoB171BDUibJxdYjNi0tVn2EbrfFbU/0XjOtQBB+69bxSHAUsns2+REVRnNxzgr6ybzG2VkKyTN9+U0uKd1lUqybhRmIn9s1a0/JygBtkV2QVq5wA57NOc9TgXpriPp33C5bIYwJZydY0xZNP1/tj6fEMLLXpFeaBIWQCx7EZUjaApvWeTnu7HOjLcUZUXK/BVVWc7IWdrXBcY20o0hzbAjxGsq0xS/mfpRxWIq50GIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQUpsjptVU60I8VgTqrrRxVMsCJseIgBdaz2BerRMbU=;
 b=idxfyb/Q/TQAt/mQv0Sh/onhsxMSJ28gVjuVRqWRXQbdxifU6LjVK8R56AItvUP1wX4KjD5achNoyQyCmaRtZ8YsoP/fGyk45MCktJzWfUUj9IfWnaUFXDjgLQSK5Sc8instO3WSEZzv+bljbXcUvvsDFvt83BsPSivfoMfFnpgrCFjkLqGbDS1b2TiSuYn8V/QUiySIWlTxIDo7Z+s7XHZ64t3NV6+vibcWmp6t4bRd36zoZqrxO09i23Ykei/KQdkJhBXxnB1PtXemG4nbitaCzUuPwfnsvoZrh+67+64IAJenATCZ1py+zaRbI446u8nPEhgPPb5AEVdtpAWG5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DS0PR11MB7580.namprd11.prod.outlook.com (2603:10b6:8:148::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Tue, 22 Jul
 2025 12:17:20 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%4]) with mapi id 15.20.8922.037; Tue, 22 Jul 2025
 12:17:20 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "dawid.osuchowski@linux.intel.com"
	<dawid.osuchowski@linux.intel.com>, "Zaremba, Larysa"
	<larysa.zaremba@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v1 04/15] ice: introduce
 ice_fwlog structure
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v1 04/15] ice: introduce
 ice_fwlog structure
Thread-Index: AQHb+vjL50dBRiqSZ0i0OYvG24s53rQ+Dw2A
Date: Tue, 22 Jul 2025 12:17:20 +0000
Message-ID: <IA3PR11MB8986DC3FA814C3C731FE0884E55CA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20250722104600.10141-1-michal.swiatkowski@linux.intel.com>
 <20250722104600.10141-5-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20250722104600.10141-5-michal.swiatkowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DS0PR11MB7580:EE_
x-ms-office365-filtering-correlation-id: 619fb942-212b-43de-2ede-08ddc919b524
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?YRnMRXE64wjS6h1gaRiIEoXy/E50fgztyw9JHxnleiKV8n14XqBg6fZx/kdc?=
 =?us-ascii?Q?Tk/uUEi5TeJCmo7AhJbYWV3d8Fnn2Ll8B3wstmVRe0J98Gya8TRM4Qi9V6wA?=
 =?us-ascii?Q?4pBYwiyBUwVt56eNsa8LywPZy4g2bF9lUbuLyNm2im0yQa6+VOsYwJoYwI2w?=
 =?us-ascii?Q?6ANb+CENsaDQ4LBp02baSGEUjoN4Xz7RRRJL8FexmFYXKJZZQSOwV/egCKGC?=
 =?us-ascii?Q?zSixvoGgg+e/WXaIGGkgNSOAWvTbWfof9m7nIZF2NHvSpU2KTRuA4p5VfjSN?=
 =?us-ascii?Q?JvOOCX47UkZ0cZBmVZGQxgsuQtS/9QhD5AbjpjCUgRN5yVpoVUWgdkDm7F9y?=
 =?us-ascii?Q?KPohes2moBO6mtVpT2P1Mz9lPnfe5pR1BFunV6TN27bpjXgu2l2eKihXy3yH?=
 =?us-ascii?Q?4rta29CmSZNued5NeSHf7+KLlRH/Yc5/zhGFzQoCeAZ3IxiVwl1/b3tnSGeO?=
 =?us-ascii?Q?dl0c9KmfqdBNANaiDgCi123dCm7jMyTU7lnKy12sY9RoxAEF7D7Khrc19sLY?=
 =?us-ascii?Q?/ZCghEyGUIrqIvFOaAINl5Zh4x20OK0P0IMZ4LXJK+Zr4g9tz3WfppLrQFNF?=
 =?us-ascii?Q?/xa8ydNk9SNBGhjgxQaUTpRmV3pdHGEs5l6QkMs6YQYHawvmJPAWrxrvrrY7?=
 =?us-ascii?Q?hNXHtppmZZUoN/EFZqfYO4oRgQb9OGe8l5kuWQpNlzGJ+2sKzbXygi1VGy0d?=
 =?us-ascii?Q?+wveH3FXJtXhqfFOYAVS3zQKMm5kI3H+XHD5kDlQhvA/bCv85iqinWtOeBxs?=
 =?us-ascii?Q?0lvugFLsT2K7un/yH8elPJ5d+Z1W6pl3SoUYAJ3zftcSQoyVbxPjA3blbGpW?=
 =?us-ascii?Q?DYvaYBsCPek7pX2WVUw2KLqY6y0+0DW+4+QLU7lQqw1aD+YH729Ebkdl6dzM?=
 =?us-ascii?Q?fj5x2XQSIBMrEclOJosMV3c0QaDAjnW9pmvWbxnmYkhZo3Ek34XOpFOzjeA6?=
 =?us-ascii?Q?hna26xjaUI25dtMKB2z+Niw5mveJp60HHYkzUXXwmuy06zXWz82OykLvuQiX?=
 =?us-ascii?Q?yXdI6yEtp4HH028ic5na2hN95byiiUTvPVebNio1wwgDvy9BjaYByrwz4RD4?=
 =?us-ascii?Q?bnvz8SkiSJbGdjpt66mbLhlEKBr0poG4uvdkNIo3OescJTna6BLtpw2L0oYM?=
 =?us-ascii?Q?IUQ4Veosh6ifisZVMIJ+S0ppSdKYuadXGagp5pafKHW4N9nkZOxCE+scTtAI?=
 =?us-ascii?Q?/Sm4CAe4b8RW2kOJYeJmZX2SyaJeieAFaVWTQwZ34PDfUkXOGHM8dXgJMWRW?=
 =?us-ascii?Q?jnfpocHbexu1XrTiFIyAfSaWkx1Ruhdhf533ySQ/sHHBmSMSquFm6OKT3AYn?=
 =?us-ascii?Q?HC8YkiKQ2LGOlTfh1PE+okjLr0656JJ05jbDYyhOEDAeU7m+G4zm7zA7AVUD?=
 =?us-ascii?Q?A3bICojK8kMe7+Fxk7cA1LX+bTATRAmxl1/3IG3pAnR3MTk6XFPow4CqLaHb?=
 =?us-ascii?Q?W6/BkQjdqIipBopwsEQ38DTvjXBgDJRtkA18u1TMwWRr27+MM3pN4w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Nnix8Dz7HQGDyFH+8rhDfJp0PR+B8Ikqq1q1Yr6aPahlEGOPDWissdRQsfVJ?=
 =?us-ascii?Q?Ds06apI5Bo/9yZc7XKA5e81tn54YEw00dHhUmx4zwiC9GVe77psljhyJDMuH?=
 =?us-ascii?Q?MaNhuYfqC6q/h2SPqx5tFGBuis1Q/jF1ZLXtckNpaKF1JrkifO0j1+MGuZWc?=
 =?us-ascii?Q?kXyu7KXRdX1l3fPH5tiZKEQVDw5l2BewEI0O/diFNSDjX2poufRcWf1CaSCm?=
 =?us-ascii?Q?8tIquCfOCmzL+aJo9nlMheMVgxc2krrsriXEWRd0GectW5j7ra1glOPvu+Nh?=
 =?us-ascii?Q?lg0xu8ViKGYlFso7YLCV7gZ0JjkeQ2QgGLs0EMCGRfHCVojeahPQvFvebh1m?=
 =?us-ascii?Q?HC6AsDLMuM+6MmRtw8RewX+2/q7VTIRRo5Z4cYw+otz/mmowNcLHw2jZPfJj?=
 =?us-ascii?Q?8fVOdMzN9pD2S2/yJSZDPLTuX+fip2Rsp7tihybGh5XKyxcvKHA1/GvcMpyw?=
 =?us-ascii?Q?4if/T1EUVYNckiHxOphP4MJU8h5/T1+YUSxRvWcEJCXrbh3d3F9qP/n3sORw?=
 =?us-ascii?Q?/Q+OeYwX8UHqZlHexU/ybf2sLcJcr3svLAFSuln6SeCgWKNIK1FzWjLVGdJN?=
 =?us-ascii?Q?U5C5Wlcd7aIor5qK/rS9cHbJO76u/k4SUpb9Z/e4AFOhilHGb+pVrlHnyIEl?=
 =?us-ascii?Q?Z1p6V/vq3VBGA45539k/bU3bRovWHXuIpK97kqidNzwcefypjbaExog+A6eq?=
 =?us-ascii?Q?8p1hDfMVyncdaGsjhZkY2PkCVTqW6eB15xXdkbTyPR3zJyxtDMxBQA+s9nyK?=
 =?us-ascii?Q?MCoNcJ2jMpY/xs8JsyZys0dw7iXhMkIYfOGCls4eTgdJzEM6PDn2q5NxP6Lp?=
 =?us-ascii?Q?NM+Jz0AegjwPqwNGOii5dWqlYVTfp9oRpYIVjYwYvd6rAHLGCkCVYXlXHexI?=
 =?us-ascii?Q?YuYqpOYHzbgylUV2HQaMD3xEkx8S/AsgaH6puCRUwjqJ6fwgoht5Q6Hlyxw0?=
 =?us-ascii?Q?TYXtM3YUPjTUozcEJF/fA1BxRH1EP+YKL4gpv5+sfIpT9ENzvmtKp66D4S2W?=
 =?us-ascii?Q?ro7TXZDF2G6QFme10CLMz6Vga25VCY4DbDu1rb/u35wSpSJWh+VnWUcpY2yV?=
 =?us-ascii?Q?ux+M1HTLhprqestTrl7ToEHGvaK0gCqXIw6AyTS2bD1vGI6dHLQ1MRNIpV3O?=
 =?us-ascii?Q?cMG1gqFYjVuP/r1p8+4QSBYek0JODQ/eSeW+Tx9OcbvMHkIXI+2qVhEGaNqN?=
 =?us-ascii?Q?EfI61ZwgNJQfmLn3qkl79R4hPkEKepEzG01S2WhAv6USaaVzPEiaqJVQXz4u?=
 =?us-ascii?Q?CZmUwoYMqGZK9t2QreE7rgia2z1M/l75YjKrGPfKTuEX1/ZgRLLae6JUnwBl?=
 =?us-ascii?Q?58xXVNdI2883UKhyOR7Ry9zMW43+CvezdlO5lhrlj4APPVJPXAX/32lPgssF?=
 =?us-ascii?Q?XHzXUlMU28uCAjVltyMK6jrM8jrmz61XRyggkmoW92anLb6rUKSgwj8g7RO+?=
 =?us-ascii?Q?MkXa3asb0LfH6PLuc4Ahu4jOWPFb0VVoONXynqo5cPQeVM4xl+BbkPhaMpfD?=
 =?us-ascii?Q?sFndlAFGlOf7AindKAkYf14a7KwOM16p7T0dO85frCdH0nb7n9iUZByGn35B?=
 =?us-ascii?Q?uQvekoeRykXMkvbKk6GIeZYdFuHkP+YB+ws1LPCJ9lTzJZK0f3RGI2RZyyeY?=
 =?us-ascii?Q?Rg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 619fb942-212b-43de-2ede-08ddc919b524
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 12:17:20.6789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DiCJSDg7aIIH51FVCuD4O1Twtt8CRVDFNvTdd0lF2B+SNyl1XsfE5d0dNQg9lW78RX/BQfsBIJUw/mvaY6zjdvZZ4cWHhu7L/fzApi3huQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7580
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Michal Swiatkowski
> Sent: Tuesday, July 22, 2025 12:46 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; dawid.osuchowski@linux.intel.com;
> Michal Swiatkowski <michal.swiatkowski@linux.intel.com>; Zaremba,
> Larysa <larysa.zaremba@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v1 04/15] ice: introduce
> ice_fwlog structure
>=20
> The new structure is needed to make the fwlog code a library. A goal
> is to drop ice_hw structure in all fwlog related functions calls.
>=20
> Pass a ice_fwlog pointer across fwlog functions and use it wherever it
> is possible.
>=20
> Still use &hw->fwlog in debugfs code as it needs changing the value
> being passed in priv. It will be done in one of the next patches.
>=20
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


