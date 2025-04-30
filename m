Return-Path: <netdev+bounces-187138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC204AA526A
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 19:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1FC4A7D95
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 17:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B937C25F980;
	Wed, 30 Apr 2025 17:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HfYKKkSL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C421DD0C7
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746033192; cv=fail; b=SqWqC4VF4+stv289MZkeROVT/U4d7EyGDLrFN7IbzGNj5J2EOM4zGY+7sc0uxBwC7CDiTacmb1/gHvAMHt1YYVq+1OUY3aO0J2Z3U9QWJLFj6xG1fGprFkGm6kUYGGeN6/QcokXEX9nBz/p62vpeoJmbxqlTDqAf4hrxNlD3HsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746033192; c=relaxed/simple;
	bh=C0AhXm54Z5tXaHw+5KJ5EOgEA9DgfiQsdqQPMKObVyY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BxBUqFg9rE2iwe5dPncFAn/SxMNEr2P8BFOtUBP+3lfIfsXKnwXm9AyGLfKI+3FoljcvznP9kybuN885duItIirf9bv4YssFMZ9C4zFImVXzs3GgopL113RGAN3NzBPkdMQ0rgp7tBBwS9q00VSAQMeTx5MEc1vM5Ec6ZWlw06g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HfYKKkSL; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746033188; x=1777569188;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=C0AhXm54Z5tXaHw+5KJ5EOgEA9DgfiQsdqQPMKObVyY=;
  b=HfYKKkSLXY22wzCxs2n+G29nxmU1InfOyg3BK7ow9dJOC4Hb6oiBMbxA
   lQpm8DCmZhqWHyZF66+EO49e9Fu2GkLLF95ycDE3+Wncu7+NgVTmAfWF3
   KUHHFa9l/sK15aGdP5r0rgjSJo38iw4NgXZTzTfOacjZQR8ApQWMX7YXr
   R9zPLEU6FRPKL8DrsDB8ejdgO8helbrnHOD9fCYHdEoKWXL4JGBcqzOU1
   jOVjVUDVYiEa2sa3yhmTk1Y/477nA7jJeUxO+vGlUMrLNAj1Gw7X5z3tW
   hNNNZj1QBvh4KDEdScLpwGMUf3TB/G6qQQU5ihkGtJKoZF4q5gRkLp4vg
   w==;
X-CSE-ConnectionGUID: 7h1NtKIrT1C5s6Fz6nFdhw==
X-CSE-MsgGUID: DMnWS2c6TUq9JtD7JKowdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="57903857"
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="57903857"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 10:13:07 -0700
X-CSE-ConnectionGUID: kSxEvbkyTgSggNO4240nJw==
X-CSE-MsgGUID: AoX/jephT3a8y6vsX57fbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="134120097"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 10:13:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 30 Apr 2025 10:13:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 30 Apr 2025 10:13:06 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 30 Apr 2025 10:13:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mp9CBE7Zh21XHdti9IZ080zfvMg2vbk2IcV6gln5pQoODTT58TiDCx3Emht44/f9IG1ANGxta7H+UwHgDtdUQ7ocEUnAYE61brbRtzYAqT0JoaoIz0EKMjp8aH+/l7dYDeev/n4J9RnPAHcUfA3h2gvEJ+e8hPA+igAgSmi9eCrmnTA+RhlzVqPS0Yxh9pocKhcJhm+JKOZG4pYn3VEFKbYHaZhst/v1jWjbnatM8vPEngZDr6jWWBkn+X0DYlojm2b71Gj8RfEXv2ECZTqQKs36uJMEyBFV0+JZj21Pz1k/3q5r1oXfsGiL8NxmzwP4OC4CdvAAfdfBTzpWYsdXjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cikuqC5YJD1ObrNO+4JIYX+ekAlWZyhvEtY8T/K2Iu8=;
 b=aWmn4hjFMS8oqBg0VERH2yrp7wangKx1PUJynC5fEoWu6ydwLbKLXV5Kty/tAW2Dh+Zzti6QC5H7LS/GLVU6AKpuILnQBD+FfcK6QQF7kMdF5uoB5yMzyt4TR7S+QRs3Sc8RpGgr6kN1mqdQuDwn2VbN63ksmvCx9hmloOEk0i8WLJHBhAzMgKo+FJQKRO1SuwLPM+xdjOuw18IWijLUltc1uM3/cspULdHssOh++5+w1BUClDYCsMTAY9EqengKfQNjTw2zriPnnXc53bOJwK7UYU5YPUeLwWh9isIClICNO4T/CUtwu50qT24pjqAA5TAcL5UYgS/Q+5wCHzA8dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH3PR11MB8467.namprd11.prod.outlook.com (2603:10b6:610:1bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Wed, 30 Apr
 2025 17:12:54 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8699.019; Wed, 30 Apr 2025
 17:12:54 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Vadim Fedorenko <vadfed@meta.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Michael Chan <michael.chan@broadcom.com>, "Pavan
 Chebbi" <pavan.chebbi@broadcom.com>, Jakub Kicinski <kuba@kernel.org>
CC: Richard Cochran <richardcochran@gmail.com>, Taehee Yoo
	<ap420073@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net] bnxt_en: fix module unload sequence
Thread-Topic: [PATCH net] bnxt_en: fix module unload sequence
Thread-Index: AQHbufHveYoeyMSrkU+P2g+EQ+b1JLO8ckFg
Date: Wed, 30 Apr 2025 17:12:54 +0000
Message-ID: <CO1PR11MB5089C0D4D11B2E01255F0692D6832@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20250430170343.759126-1-vadfed@meta.com>
In-Reply-To: <20250430170343.759126-1-vadfed@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|CH3PR11MB8467:EE_
x-ms-office365-filtering-correlation-id: bf41b9ff-c39d-452a-ad21-08dd880a3f08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?hhRxCY4R6GpGAEakk6e3JPgXTym2CrfvlvWUI76R/RPTt6KquLBfFdZuIPUL?=
 =?us-ascii?Q?Mh7lejx2/8nFpyewDioIiD+u7Jfrno0w9p898xTAmvmhNVRJMuFg2IKkQkOg?=
 =?us-ascii?Q?SD9Jlsle+HnZj0lalthi27DSu4HkLhOhf27f8M+AKR2fNNH54AUTTEqTVhFB?=
 =?us-ascii?Q?QUC/JBDDaBwZqiIYE2ddYC9ieoowTuZQ3lzz7cbUmKZcQiq/cVNNMNJPNoSY?=
 =?us-ascii?Q?uKy9KHlDbaH25Y5RytB9PX9XP4GW27OfmIpxosPnJ56s4BVPzt9i7Ju9fPoZ?=
 =?us-ascii?Q?T/RkpX3CMtcj061gHcmQ25mnYrd3Mkbf3EqnQIsb6kiFq8fV2wQVkglYDuEo?=
 =?us-ascii?Q?rd/a4rditI7rOmNaI+tfgzcNjJDCGhRgxuiewk+qesXstE7NmX9RSBsPGrW2?=
 =?us-ascii?Q?u/XovT25Oq4jv+SvNO1J5z92hnIRHqM5WtuUWMsuHZOAwmyjteewEeTzLH8n?=
 =?us-ascii?Q?vScYMbnYehQ7t4jQigAGJth63Jgp+DxUoJcdM+bJ0wjLbH7xfV+FU0bRUp4m?=
 =?us-ascii?Q?XI/a5XmoIMNRYVr3e/+AAK7qJc6NCWTluJiTSiBtrAj/JntWAJxWa8lW9M4/?=
 =?us-ascii?Q?HYoqmIxzhnPUc4nU20eLmia1dZ9zlzKwXIbVLbNiqsULm7HQOdXZ1R3hvvjf?=
 =?us-ascii?Q?4/ebBqj1X8OTvw3jFi3gWfHJC+AKW2S0OYJgIfq+Lg5Zmc143QPQuwEerF63?=
 =?us-ascii?Q?cBI551Bx75qd+sxhQSj8o41RfddTm7yW7n/8KGVCrksNid2GdppGLKlMr8pv?=
 =?us-ascii?Q?TKaYJrAy6HZ+vQS8iXv1jESIpPGtlOjsvArMPfTdP13Q0vVqIdg2VDshDb1B?=
 =?us-ascii?Q?tanDsS1XYNxONS2OQoGW0sUz7bkKAy8ZGYlwuj2UIGNTeJ1ivFokMR5NzOBt?=
 =?us-ascii?Q?mZ3JC2v8ELa37/IrB1Vxn6msHo/gapMVWLwJhODPTsxAgZUUazZZD9ohUIi6?=
 =?us-ascii?Q?UjgzfCcENMPmdrrDx1zEpCIYM//D5xkj5MQoVYg1RlujPtP0R9ZmIB+5XUiS?=
 =?us-ascii?Q?5jh3gSsVEOMCDJANNSMeqDuncqx3n+5W1qHS7b7UK7VzdzP3JN6t46HC8F8T?=
 =?us-ascii?Q?/j+BcHg/W44F4MwXWK8pTyzqazrsUEGVH85WwSjklzK9NWXJTy/Fun3WCSMW?=
 =?us-ascii?Q?Pd1dxAREtIte8TGA5w/Lgo+apOwopCgOupp6Dq6rVdo6btTaiuh/yTSroJ1N?=
 =?us-ascii?Q?NO1hfqHCWTIdMhjiHEgGpZHvohEqENj/VZBdbO+6R18Ma6VoJLdGK6z7CM/1?=
 =?us-ascii?Q?oBeSEqoJy47NiAjeOP93J5p2vNaFkfX6tgZ+RHcgICsHrU0BnhrQ+YVwiFxQ?=
 =?us-ascii?Q?5MhOjHLGTNR7KVUjnjpABgdoCnP+YcA4sTfQYXpjk3y/PPwmUxBr9iyEHnwF?=
 =?us-ascii?Q?PGGdiYskuxWl5FZ1A0sFR4DU0ogoPp/uKGWDtU9lbtPCTls1abVpXzl1tnGx?=
 =?us-ascii?Q?Fpjjd1TEPPSEv82QfsC4HOWoCIqSs8JJKU8vi6Lx12W4r725tyra3UG9XShB?=
 =?us-ascii?Q?Z9smhjVrcyJeWAo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?whzdI5XK6KlFqx74AcfgWNB82KYWKNHPWr8IeWqYi+LLqk8+QreqvXXqEW3u?=
 =?us-ascii?Q?rimyHSgQ6LhyCet8v9ilwL2rrDqvIw98e6EJ3jPl+yKlZDs3Xv4PvC0whnXS?=
 =?us-ascii?Q?bpb13UFJXB7gDJkDANaPOWGtUC9lzFfnp8zF9tZGmk7mvbalP/e6m+FXs9OW?=
 =?us-ascii?Q?/arnwTR09JLJtnKqn/QPLOLCPeayn80JTjHs1+DgUpl4Vr1TNCURA3Fivb+w?=
 =?us-ascii?Q?NRAEKcFnMKvFICqd6VuCpjbqw1ZtC6yMp/omgo+9/kuza8NevZk20DhGy7WQ?=
 =?us-ascii?Q?UciP6ydm6LuDGrkXerly6EZ38Vl53b+JtAMM1C7ukRrP8PKkj8lIXBgYYXS9?=
 =?us-ascii?Q?0CYbGAjxd6AZwcf8Li29P+jkSvhrGpfMZGZ2YT0kTxNkb1AN79gH2gIClNy7?=
 =?us-ascii?Q?srR+DJ/ADgvyApIhuzOjo00bauyzb0kl9lW8APJ+TsIVd05dwUOGyeAiGWsh?=
 =?us-ascii?Q?1GOeDl1BOF2s+X6KwB3JKe6wKMTIZpRL0b91drRWx1yokAFuVvXL/hMJIalO?=
 =?us-ascii?Q?uJVmCm5uWniz63vXBZfsr00jW49mbK0EgNGNS35CqZP+cTCv25YdPkV18Lbu?=
 =?us-ascii?Q?azL1TDzfIs6jvM2cOm+HUwzwfsUmI028MeGloHOvfD013b6dDd8zFeRoPg9v?=
 =?us-ascii?Q?Qli7lk06jmZ0S+JDAgXPKgiXcK0yeJ/Kh3mBOgDJ5hAclL38Yaybwm+oi46X?=
 =?us-ascii?Q?D8aBPA5Rt0mVacVn0zHh3NZRSQT8khyqgqQ+wVBqU34cCp8fb8M4aPvIt8Ba?=
 =?us-ascii?Q?TY8KoAeU+dIUpy0MaaqczJYThkfjHmpWcMeUWMYnLbQdTc2scTcTPdloMW/q?=
 =?us-ascii?Q?CTGPBBVvdvjXu3GQNjumOXCem1dW4qyCGyXnSZWQNqjscG8qRRdpn8PQpzTQ?=
 =?us-ascii?Q?byblKAOxYxljrlMKF92RPFKtJTwITcUmqA2G8rwqHJAFuSSFwjQopo9u/jqF?=
 =?us-ascii?Q?tqVTWKqRx3v2gDo+P/0vFIyZyGvuRwqHm4S5AGJXxWU3I2EpT1Thxv3SMlLB?=
 =?us-ascii?Q?thWEgvLWzD8Fc9moJQnaNqc5AH3Le9ebGQZ680gDpTyB20DRcLNoV1ctD2KP?=
 =?us-ascii?Q?jObaSPUvTCkMLdzY3lrfxK82J389A261z5GSwo/d1wgnjD3cO9RxXC1scwiD?=
 =?us-ascii?Q?SrYbBeuGqjDl3TZnqlhEaFyZ48IGJXn+CwusLjFQZSuA96tu6dGFhlh+3WHJ?=
 =?us-ascii?Q?tHj9agcsjqtNuCUPWrcBDR/NiR03qjOKL/yzS15tM5y76Dw8MyV2duXEO7lU?=
 =?us-ascii?Q?6eEHGVVxKlNL963hm5SY2phQ2jCqTlovKR7uZlKuhIJ8mqeI9N2JMlQIWrrb?=
 =?us-ascii?Q?jaRF41zb0k6m5tShad6q6qYrtC4JGY58XggFYE2xEwRz89efix7eVWMENauH?=
 =?us-ascii?Q?UF8nk4evbwQHgnS6CE+ypNQAGFNk828UvcBqF10uWYXiHCD9IduMYx684osl?=
 =?us-ascii?Q?fi8PvlidAJx4UWYjZxTNoCqbGM6WFwYrQGeB+YSHhNW4gGVbF59hsr/heom9?=
 =?us-ascii?Q?uLjZ/n96Oc8VJ91TafVuTigFYcNwq7FgCDk/G5A9kb2JBJ773mQNWYG2KkKH?=
 =?us-ascii?Q?p24FCMh37LowX164x+u5M5U8snPudK9pKo3kRBRe?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bf41b9ff-c39d-452a-ad21-08dd880a3f08
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 17:12:54.4610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dPK3lJUmYJQ0BXgvJqd5mJUDZvh6Mlc6icju9cXdbe7V+wLq07t0bOj4l1B+aB7g6W5MiUEVdl2fwIDrnLp0o0R08CV8W7EVlKKh+pnYfrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8467
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Vadim Fedorenko <vadfed@meta.com>
> Sent: Wednesday, April 30, 2025 10:04 AM
> To: Vadim Fedorenko <vadim.fedorenko@linux.dev>; Michael Chan
> <michael.chan@broadcom.com>; Pavan Chebbi
> <pavan.chebbi@broadcom.com>; Jakub Kicinski <kuba@kernel.org>
> Cc: Richard Cochran <richardcochran@gmail.com>; Taehee Yoo
> <ap420073@gmail.com>; netdev@vger.kernel.org
> Subject: [PATCH net] bnxt_en: fix module unload sequence
>=20
> Recent updates to the PTP part of bnxt changed the way PTP FIFO is
> cleared, skbs waiting for TX timestamps are now cleared during
> ndo_close() call. To do clearing procedure, the ptp structure must
> exist and point to a valid address. Module destroy sequence had ptp
> clear code running before netdev close causing invalid memory access and
> kernel crash. Change the sequence to destroy ptp structure after device
> close.
>=20
> Fixes: 8f7ae5a85137 ("bnxt_en: improve TX timestamping FIFO configuration=
")
> Reported-by: Taehee Yoo <ap420073@gmail.com>
> Closes: https://lore.kernel.org/netdev/CAMArcTWDe2cd41=3Dub=3DzzvYifaYcYv=
-N-
> csxfqxUvejy_L0D6UQ@mail.gmail.com/
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 78e496b0ec26..86a5de44b6f3 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -16006,8 +16006,8 @@ static void bnxt_remove_one(struct pci_dev *pdev)
>=20
>  	bnxt_rdma_aux_device_del(bp);
>=20
> -	bnxt_ptp_clear(bp);
>  	unregister_netdev(dev);
> +	bnxt_ptp_clear(bp);
>=20
>  	bnxt_rdma_aux_device_uninit(bp);
>=20
> --
> 2.47.1
>=20


