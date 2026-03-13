Return-Path: <netdev+bounces-267413-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aInxA/Lus2m4dQAAu9opvQ
	(envelope-from <netdev+bounces-267413-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 12:03:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8587C281E04
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 12:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D9AF3139974
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 11:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02BD34107F;
	Fri, 13 Mar 2026 11:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z4g+Okw2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD15A31DDBB;
	Fri, 13 Mar 2026 11:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773399726; cv=fail; b=ZbtosDoYR5Gu5jzD1Ig3epY4XxR3UGHjshSdgjwV23yW+n8IqqHAm1uUeCa8V2M5sxLX2RMQeGiVkU1VvPiiGXQ+sCwntb+QLsvNi7HyISGY4Tpfimzt2SStx4JwOU/DJHzoc7FohgALryzWDkdixgxvH2dMtcVnUaEVyed5u9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773399726; c=relaxed/simple;
	bh=XxsQ8ses33gmYyyLVscdmUsJEd8Yj0TtIzdIAUrDtY4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lSlHrTEzz4INTUldV2FQGM6l5CofOItezWwoQXP/PUN3WneLn5GcQxlDOpn6n7m23X4TfQ/ZmO348NpHUl3U5ztSZFeyIdSwtH5SbOgSMHqSnwgGDEXXisCwBhdfVic60WoaTAS1VFkw4KWphN+nEwEpTl/76HMA5ufbRjvcOXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z4g+Okw2; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773399725; x=1804935725;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XxsQ8ses33gmYyyLVscdmUsJEd8Yj0TtIzdIAUrDtY4=;
  b=Z4g+Okw2s46ypwJK089XKwN9qHpi0su1j6vzgrQYYk0imbSFc6tTrUkV
   gy12Z7euFqSPFRNjz1PgnRMhQHdVlLkHip5Mm3D3VDqf/f2+ivwZkNimS
   v2Q4QUEY5+poYa50LA4E1v7JTmXcIGIOeloeYfpRGPNInBbtfoikPaIkQ
   yq7zYRZj4m2bnmBh9jR/qo9e+h5aKo1IDloUUXmaA6iegUU9JdBIhagwi
   vp+EwXnJ4G3dPrNfA5Va2KYzvDWOJ1TdZP+7GIsXx0d3BC8Y66DXius4u
   HnHoI2voAKEyaY2NLgV4xr+pZ/5oU9lf8jwtJWXHPpkQQKFYZOioYCW5a
   A==;
X-CSE-ConnectionGUID: NJs3l7PSRvmRHz/H8iApLg==
X-CSE-MsgGUID: f/hTVwwgQqWsVlP1J7NahQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="99966516"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="99966516"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 04:02:04 -0700
X-CSE-ConnectionGUID: iumt8Hw6R8Kr8cM9ariM1g==
X-CSE-MsgGUID: 1Zd/vImSQBSiggfbmYGaGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="244152118"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 04:02:04 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 04:02:03 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 13 Mar 2026 04:02:03 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.19) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 04:02:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTydGF8zp2ftmOaZohp07blKh3HZlqWlZf6mCg8EDcl01KqQotvii5vp5GTiSVuotuQruagQmxieOP4PllZEszRGN95a9LKlxQOaVVnQrbSLC+sxkiz2I5j+JyAML6Oe2FBAtGKTv97N+4GpQbPCFXSfKDU7cuZJKpCoC1FsM/xiFJyDfzJqcGGnyHZeDN/hq6wsDNvMBpcweYpfr7+vlxy8R85QSxB2CQ9Sd3kPDFpsksCKklrSwXHNIuPugvdAVGEWJUMVwMGu+6d9+mqiMmLq9teLsfeNZ3tn04MvMkVPoUueRJU7p2zienqIR5MoPfPu7JSQRhZHj4Pa/0qGPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CpXQ2memlGkshSYZWYn+DRj/R0g3Ztj4VjMYHd7UPoI=;
 b=iXSfgRumvQNyK7tUnSVYp0GE8xdzL8hDf7XeQYQzzdR/MNJP0KQDwDQTK18My/BoIodnLmDO7NiSlV97L3SY/N32v1fE33lXWlTVhdIC8S1UXo3DSqDrapVTk4TOuNtEZTT8LkQb59P24l6gPT4mz8Iey1N5m4wEDOWQW7N53ibjyAIsOrj0575PxEjMnvY9ZP7QNuNq1YPKEw3hXhQyKbD088dTRepgQk9cJUAZ277h3Jpjuiw+AgWnKPn/RPwmRbMkU3SrNVEojY/0wYUCmhUSa39ltq5NWBHurBmn1udfbzqbstefCrN+9vKITuy1mdlV1hxzSzeLxCt1rU07WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Fri, 13 Mar
 2026 11:01:59 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9723.006; Fri, 13 Mar 2026
 11:01:59 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Schmidt, Michal" <mschmidt@redhat.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Keller, Jacob
 E" <jacob.e.keller@intel.com>, "Jagielski, Jedrzej"
	<jedrzej.jagielski@intel.com>
CC: Xiaoqiang Xiong <xxiong@redhat.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH iwl-net] ixgbevf: add missing negotiate_features op to
 Hyper-V ops table
Thread-Topic: [PATCH iwl-net] ixgbevf: add missing negotiate_features op to
 Hyper-V ops table
Thread-Index: AQHcssKmqAfFA8HfP06whTfdmXHofbWsTAjQ
Date: Fri, 13 Mar 2026 11:01:59 +0000
Message-ID: <IA3PR11MB8986823EDFC614EEFA90C9FEE545A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260313082230.195208-1-mschmidt@redhat.com>
In-Reply-To: <20260313082230.195208-1-mschmidt@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA3PR11MB8118:EE_
x-ms-office365-filtering-correlation-id: f2a3b494-2008-4358-628e-08de80eff317
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|921020|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: HvEuiM9a0xBFKXLTEc3nOG0CJpEaynKa1crwg8YxlzNgD7jM77MaGps56vxpdfASDiQTF/lF2uyVxZ0B56/6QyOANdN7ExSkqDuamNLDwjl+QyVzyDW7Uc4b8sIl67nl1y/vPFKGcUjzdxe4QpGJNXRWCtj84iCM4S/aOIjL/vBYRCCnO9RjAdRSecKkXqRJAg9Lr8gOTJtgG4Z1TRN/PVSsDnQME36GpETdYyvk1km2R1FcKX1fe+UpRyQ9kKReH231lgkwdqsh1HlrKOpLlLW5ffWURNaXqjHZWoGbQQGL8ZXNu1OSiIyTzf2RfjSFMRR6UTi3XsiyG1uXgaNbI9XywuU0Tl8F1L9H4VTmbCZy1OP2FbcZUKaaib0nx3/W4Yu0J8og2em+aFVwk1W944p7FOVO/inhi+zMQTrjSz6mJaM+s3h5umIgGM7ZG/ewc3K7iKX0NQFCtsuXctqMbEhWIr+XpT7+cq97cpj+dOJ/M4lC1Lwb8gxgcBy3oOG60ShcU3xgogEz/206NCigAiug4uN9b5qS4dKqlh/veHPeeajIk002ON8bB2eNxgqxbuPMAixgBPIN3JEc0NyMkqkWb0DkgecUn0Z+ZJ55Ywc7Gnn86qjkNSXiXDH1Gowl+BC9BM0Q8/RASGjpWy7WbWDcWNYwtXIRlafiRbgYX6REiOgalzK2V0O9ZSHGIVeWcUoWGVpZZ6RImu/QPW8/8gIo2JNy2BX1/m1KhCsxeboP+EJzQYcK1UdUCOC466UaJr9vBTexJoyeR7GuQaqTojhjFtbebu4juYHbCv/s22WWZmJKTQouAtSZ49foDYBs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W88wP15NW7r4GEbtqdkCPThW7t9+lHYTm0v+DVrGXU9r6/DXhJUiErJPMQG0?=
 =?us-ascii?Q?45VZd3k5IiAt1xuV+ew5JnWI6dOqaxwom7dBEzRCtRNOiPX8CJ2DYP9bvnv9?=
 =?us-ascii?Q?d0cheDC1pMgjqSxgxciTeMZjHDQuz+rl5OY4nm+zh3vSCNvM/OrLnWj4Kbmv?=
 =?us-ascii?Q?atzVVUpMXEqkb5wg5ykjiiRwTcN2b3nePit6+847h8TLckIJ1Q+J+YGQoXdT?=
 =?us-ascii?Q?GEmpr4iIR61JxsvAorSqf47W9axdbxdRb+xb3j3r77tTZ/L02vdHBdQeEcjP?=
 =?us-ascii?Q?TRcquhJwKkFlauGFHFpquRies+xftJOPt3+8/Hq5GgOKfvBfssrKA5hgwJKa?=
 =?us-ascii?Q?asu2Rif/CcY3Q8kdRDu5SojxUgfqH7RIWOyFTRRBxKnA8Zvhm54xYkBjiaDi?=
 =?us-ascii?Q?KPKfOXESvevVe2PAuc8lt5+gauPW/syc0Y0DQaJfW+8dbREa3F71w8c1RzsD?=
 =?us-ascii?Q?BEdkChZXrSc01JybvS3X+2t8wBiFhMQabzXElIR/ivX0erZ9g/Rf/yKGG91s?=
 =?us-ascii?Q?E9ks2eZNJJpb90fH6kdcnwWFk2SNM/OJ27JumHB3JY/Xe4AMddmhWPqWkbFr?=
 =?us-ascii?Q?/DShuSAODN8z3EDsKqlFclRnGqLHZsmPBD1yC74I5tqf4P5JbJE+L8F0AsGn?=
 =?us-ascii?Q?ljNwxP2/k8ZUgLkmDZioqkrt4qd3HxyiG48tgT0heLVcApZDr3vT1u6sImOQ?=
 =?us-ascii?Q?l5bTZgC1KtxNgI/rfZtBLqjA91kDNacNyOSQ7T+uRW6lYnejvrCdNu6lVBId?=
 =?us-ascii?Q?ZsPZ7jsSRnNfPm7FmSbr4NH4go64u3TLKUqrFBQdTKMdUhmN4SkEnr7skEYk?=
 =?us-ascii?Q?j+FtFvMjlV+mRjSaJ3G5oD0bgI1VjJHH8nDHvuwK78aqiycBfjBalMO1UA6l?=
 =?us-ascii?Q?rIIsQmSGAErF0Kw4gM4jU0wdUxJ7NAbGQnEYDPDiguyBIk0QrKQJfTEFqQ7p?=
 =?us-ascii?Q?viUOxKWnofQJ8JeR1xEF5YISd24ka+e1+zjnGj0KyQQBEI6QAdPBXcp/E5vK?=
 =?us-ascii?Q?+iCWm/WZE3bvvLJX169EHoq+kqKdFBkJMoNj0okWbvDNj8kPLJjC5zNmykv0?=
 =?us-ascii?Q?lbwfaRqp6HQWuDMo98QyM4v7RL/rPhqQNNTMoTf93rgCClf8+w+3ATRDZMOh?=
 =?us-ascii?Q?UYJJ71Vh2NOfmJH98juflL1+J4pSvgc5bYLJIlHwF3eY0HkAz+yvkQ2QkgXF?=
 =?us-ascii?Q?tilHzb+QDcbCrMozB4G9MNkU/qWDgi26ZAz2PfJ1bYhiHHoY3o397kpCgix8?=
 =?us-ascii?Q?Xqg7tVVjBPRFWzD38OdaOCOur6uXUyuU5dK7zZQ5QHG+PmQbwlhCP+7eCcJ9?=
 =?us-ascii?Q?599J2sOLv/4M3NnY8f3KKnTF2qm0NXF+/2LBUAVKqfZirVWiPAVI4n8bIdw6?=
 =?us-ascii?Q?ZpY1ss8EGVSlD/qAdPwcAHfzbASfOu0kUAQwcyZPHh6Un9aJkQ6vzsBK9n64?=
 =?us-ascii?Q?9fDR/s9tJy6s6j+pGsaSHHjnUZg4xnVgce6B8sLhC0iqwR0WlxWBSyYduEWD?=
 =?us-ascii?Q?qBbvhBvMRnOUy9eT0C/CDm5vtUfz7J33n4yUH0ZSdivGy/M4+eE21Eg2dJFe?=
 =?us-ascii?Q?RGwXshFSfY/HztfjZJEc5QYbA2C2euHRM9ZKeCWF9P1H4dnGYqb4BeTpz2VD?=
 =?us-ascii?Q?n3D9r5uFUocP5Vwhlk3pqIcWKE+ozbyKnxp+a6S0/Qf1+zUcE8nKYPgYBFHm?=
 =?us-ascii?Q?9C0dX+ltDZjYHgt2RWwTgljXBlUZ0vlC4US2MziURyPJRPCWR1p0BgYa+bOx?=
 =?us-ascii?Q?W18p64651F1pZHuf0nsKTLyf7wsTB1c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cD9m8tncXYPRbJj1M9zB6We9lJo/9A/iP8rLKEXxtCQ9Tjav30rXn+T9bTzhWrG7WBa7z/P6xg7DvqrDvfLe0OhtrN2a2tg1OANwZnvN+PVhDX/Q0o1Jdl+adLBnd8zDNZjIZSQg7uWb+fe0VfbFXyRteeY/Vnt7zR8xM2yZmfBZHSh5bVoFwuOpXWTa3PASw48kf+knRCiHBWMQGACxcFxOpFwCwQ9cAoBEFsvFq8h645FKS1Q5T7ad8rAVSyActY6PZkEt8nMQe+7C2pE8BaZeVPUkJt9SXFVsbxFf0w8Ln4nc17yb72HMDpW1L4CBNHqokV2UJA0+Sy2jkxqJIw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a3b494-2008-4358-628e-08de80eff317
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 11:01:59.6574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /vgGroCoYKPuyicEkFEyxkmvk7PRYoEVYj8kgD1ZbkNlLZ3IK/3y5SqJg0qM07q1o1GKECCB/rz4Z8lDSKd6621buYH/CJ5uRa6uI5hy//0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8118
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267413-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,osuosl.org:email,lunn.ch:email,intel.com:dkim,intel.com:email];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 8587C281E04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Michal Schmidt <mschmidt@redhat.com>
> Sent: Friday, March 13, 2026 9:22 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Keller, Jacob E <jacob.e.keller@intel.com>;
> Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; Jagielski,
> Jedrzej <jedrzej.jagielski@intel.com>
> Cc: Xiaoqiang Xiong <xxiong@redhat.com>; intel-wired-
> lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH iwl-net] ixgbevf: add missing negotiate_features op to
> Hyper-V ops table
>=20
> Commit a7075f501bd3 ("ixgbevf: fix mailbox API compatibility by
> negotiating supported features") added the .negotiate_features
> callback to ixgbe_mac_operations and populated it in ixgbevf_mac_ops,
> but forgot to add it to ixgbevf_hv_mac_ops. This leaves the function
> pointer NULL on Hyper-V VMs.
>=20
> During probe, ixgbevf_negotiate_api() calls ixgbevf_set_features(),
> which unconditionally dereferences hw->mac.ops.negotiate_features().
> On Hyper-V this results in a NULL pointer dereference:
>=20
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   [...]
>   Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine
> [...]
>   Workqueue: events work_for_cpu_fn
>   RIP: 0010:0x0
>   [...]
>   Call Trace:
>    ixgbevf_negotiate_api+0x66/0x160 [ixgbevf]
>    ixgbevf_sw_init+0xe4/0x1f0 [ixgbevf]
>    ixgbevf_probe+0x20f/0x4a0 [ixgbevf]
>    local_pci_probe+0x50/0xa0
>    work_for_cpu_fn+0x1a/0x30
>    [...]
>=20
> Add ixgbevf_hv_negotiate_features_vf() that returns -EOPNOTSUPP and
> wire it into ixgbevf_hv_mac_ops. The caller already handles -
> EOPNOTSUPP gracefully.
>=20
> Fixes: a7075f501bd3 ("ixgbevf: fix mailbox API compatibility by
> negotiating supported features")
> Reported-by: Xiaoqiang Xiong <xxiong@redhat.com>
> Closes: https://issues.redhat.com/browse/RHEL-155455
> Assisted-by: Claude:claude-4.6-opus-high Cursor
> Tested-by: Xiaoqiang Xiong <xxiong@redhat.com>
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/vf.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c
> b/drivers/net/ethernet/intel/ixgbevf/vf.c
> index b67b580f7f1c..f6df86d124b9 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/vf.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
> @@ -709,6 +709,12 @@ static int ixgbevf_negotiate_features_vf(struct
> ixgbe_hw *hw, u32 *pf_features)
>  	return err;
>  }
>=20
> +static int ixgbevf_hv_negotiate_features_vf(struct ixgbe_hw *hw,
> +					    u32 *pf_features)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  /**
>   *  ixgbevf_set_vfta_vf - Set/Unset VLAN filter table address
>   *  @hw: pointer to the HW structure
> @@ -1142,6 +1148,7 @@ static const struct ixgbe_mac_operations
> ixgbevf_hv_mac_ops =3D {
>  	.setup_link		=3D ixgbevf_setup_mac_link_vf,
>  	.check_link		=3D ixgbevf_hv_check_mac_link_vf,
>  	.negotiate_api_version	=3D
> ixgbevf_hv_negotiate_api_version_vf,
> +	.negotiate_features	=3D ixgbevf_hv_negotiate_features_vf,
>  	.set_rar		=3D ixgbevf_hv_set_rar_vf,
>  	.update_mc_addr_list	=3D ixgbevf_hv_update_mc_addr_list_vf,
>  	.update_xcast_mode	=3D ixgbevf_hv_update_xcast_mode,
> --
> 2.53.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


