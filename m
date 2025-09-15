Return-Path: <netdev+bounces-222923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A0DB5705E
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 08:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ADE43BE56D
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 06:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1F528000F;
	Mon, 15 Sep 2025 06:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TRoem41g"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E5E275106
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 06:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757918012; cv=fail; b=mee/RN1180wpSbunfeZVPgI9BhfhdXQqOYXQSIMPPp2K5D5Dl0vd7mvpT8XJOx0JI8+q/gJ0WXq6BGE+8MjLtOVxKuYZ7yIiZhl2Bls+acN0l7aJwf7kwN8IaR/IOcaIh9jBcTVs0DqrIToa+dAOtFWrnxgD1wKMiY21qBMYKiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757918012; c=relaxed/simple;
	bh=neMHmlNcSZCey+KQU2NhpkoKcoGLtsa1dKo0YAFq+Vw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NcSenW4Rx/bG7LHA/yMvRw5uWrIh3se28cU5K2txlZqHzabqC6x1W9fU23+vl/oKB31CYcOYbAP7Wl+iCUATtss2htUhVyQKB9XVzk/krDupjioD3b8QdADDxT95QCOCMQ4EJWnUIea0aYpTO/KdMkj1xn71oCzjabemkMb626Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TRoem41g; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757918011; x=1789454011;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=neMHmlNcSZCey+KQU2NhpkoKcoGLtsa1dKo0YAFq+Vw=;
  b=TRoem41gVoF9Xu+DelLv/DWIBQ8ULIiIpPSv7hFS7YAJRx1WVnbpIygs
   /VuKk5swh+zlfzs2xvNbu4PksI+l/Gy/JIeuZF+I8QsWEAvGxt+LrUvwO
   JRG1kVyYUe/kKUWoeu5lmwvS0Fo8edqleOerGW4LlTu88zOyPum8dD7WG
   ft7yLNMgqhpOVwl5EsWlLarredNhJ08KBx+scSTydZ63yO2mBosYIPg6F
   rDnCfU+qfgVPj0gg1vP6Hk29wXRsocxYTlhjBzkbG6m40+EOUcqCPYza7
   5iH0p3PwBU0DxhcriN/A2L105fDhaCrsl2cc/o6NW8AWc6bUwK+igwxQi
   Q==;
X-CSE-ConnectionGUID: tE54ieaLQqWhrHIGYWyaZA==
X-CSE-MsgGUID: Q4boGAOvRPCUbC/veIQEIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="71260095"
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="71260095"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2025 23:33:31 -0700
X-CSE-ConnectionGUID: 9PgCho7mQ2eAocf5ZcDATg==
X-CSE-MsgGUID: hEqPf3kFTYCdQuRBrNbyOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="175324266"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2025 23:33:30 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 14 Sep 2025 23:33:29 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 14 Sep 2025 23:33:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.87) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 14 Sep 2025 23:33:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qG8i7GfuoWKMPE/58xDg6cFgSrp+nHNfjErWm7IeCcga3rh/m0Kuig015JQW+8GAky+mGGDUroCZRYLwbu3lpHZYKLVPdXGMqJw4/zOX3y6KL0eDreGE4prib9OLZ6yIBZulwG26ipM/UcQUw2QxMXogJZGtREdWsI9Vhqbq56LUNiU9hDA9D8k0+rgwHeiew2QIZx+mb3kNknPhvmXDhJVRJCKMvJ7KbsLmzp710kzLGLGU0yhmEjEKEz9XKs5iWoIkN6uEAkjwlVndpae/SDNMGTGd8Oux3sUCjpjolTI/CQxknKWnXqA97rsJ8lUURwgdZjp6kPwiUR3NWTmuSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VvbldS3YKUU+4d5qukGkIokoLx5aA8tGB1+MhVZxiA=;
 b=CKEt+3AW9BBXvR7dZ5XuPhPDILvRIdsQhuJpaKA/G/8XHAH9smttMY1DvtMd9ALVjY/zOUiztzNNri81cH1QgYxHolW/O6hbx4w5ClMN+uxBSp0u8nKrKHE6tpXDNxzqwHex3BkRmkdjpePPjtc9vBNXhqUbxi5MwrslAQsMp6cSGsKmL+tuBc4hAEXezf2mRZMv2+Ysd1HXMjrQdVFpEN+z25H56+mQ2wOXyreEtJyjRBi4cY8NjkjAjAUdNpMfr6//FDyb2PA92RjKiaJK5SQcLw1Fdswy3YZTh03coQJyQ81ru7Vdy7A/4VgsNv38dgCi9KsAR6EMMoRDoIxQqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ5PPF8A8418B02.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::840) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 06:33:22 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9115.018; Mon, 15 Sep 2025
 06:33:22 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Simon Horman
	<horms@kernel.org>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 5/9] ice: move udp_tunnel_nic
 and misc IRQ setup into ice_init_pf()
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 5/9] ice: move udp_tunnel_nic
 and misc IRQ setup into ice_init_pf()
Thread-Index: AQHcI+ej928sPyvhnkKHooVHxdFqrbSTzVNg
Date: Mon, 15 Sep 2025 06:33:22 +0000
Message-ID: <IA3PR11MB89868EAFED53EF5BC5F90B09E515A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20250912130627.5015-1-przemyslaw.kitszel@intel.com>
 <20250912130627.5015-6-przemyslaw.kitszel@intel.com>
In-Reply-To: <20250912130627.5015-6-przemyslaw.kitszel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ5PPF8A8418B02:EE_
x-ms-office365-filtering-correlation-id: 1f26f9b8-8494-4875-dc37-08ddf421c447
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?SuM/CYni8yNBYpbX+bYWp6Rfgr72b7QXsooXcZVNz5qGXVhq7uzPuPKd9DSd?=
 =?us-ascii?Q?RXGPsL1U3vmt+GdEX+k6yKg4jIENjfps0Ama/0jA0LwOiTt8aWo8biY0Gns1?=
 =?us-ascii?Q?oukvIC8xUNZu3lZQChSznQeAnf/C17wc0Uxi5dfbLtY49370C9f7AX7xZBtO?=
 =?us-ascii?Q?oCKNnLJ09MzXEbB9ijL/w9ZQ1STqK88FG0RtsAcwfyLGr0phXOQ7hyQeswKg?=
 =?us-ascii?Q?OHwiU0pSLCkVlObyTzr1og7aTXs/DNkchv8S8u6sJBHhY7OgNZ+vPyVIl9RG?=
 =?us-ascii?Q?GNltB9z7TgbVmYYo99BpsboshOuq1lj7O0rH1qkICX9WNadOi5ONXLcUNbol?=
 =?us-ascii?Q?yqtUgNKDQtXasX2XZSEjcsNtoJc5XiMgh+3Mqc4fQT870qGLytLJAXAYTS4K?=
 =?us-ascii?Q?AchFR/GsBUqlYn0uK00o6fzVekYlQ5++qSNXCi43uVHnTsFwn4wRpFhEdvQM?=
 =?us-ascii?Q?BhMkiCEtjYc2bxsdjH3L9GzUUcK+uOqw/NUqE6QVdQKWpSRYxiaYkLAgL/TL?=
 =?us-ascii?Q?EiIjytcrPfpq6Ge16hNCKLj9IkKackveSV3jXMMP7231FO5+4i8QmvJRjRvC?=
 =?us-ascii?Q?4zCjS0so2AQhYQmL0RBFiYopCUH3L3JnXvBO7i80Jnpd5qOxjU3UWC3V/oJO?=
 =?us-ascii?Q?seuJ6zJofeUlvpbaRBOuS6Hhagnj/RQpZ3z+U4nf03b3XGuAfFSKGFLu8OD0?=
 =?us-ascii?Q?3qNgYfyB1SLuxUmHMSMmla8BPRTplnhNfOLBcvlrDKO0hjlfjCe03pyCs7yx?=
 =?us-ascii?Q?oTKrBK2iGkRuJxjUNaTXTTWN3DMI5GnHXp+rXXWg3wNb1inlOPNXITIDfV8X?=
 =?us-ascii?Q?65++Kw9WWuCQTY8AdkdIyTTB62za7wmXUX8//HsJ3jrvh5/mlsoWucmOwE/T?=
 =?us-ascii?Q?vVvgwJYmob+isNgGw5m6DJganWrlFant47VQlzNrHZReUamFM7HzmXNQGbAE?=
 =?us-ascii?Q?drd8516gj42R/HwgDupNy1wjV4X8ne7L7QbsmEclE39OCpLEHzHN5KfYf2xV?=
 =?us-ascii?Q?xh9rXe4zMISsZqeNhoThn8BJt3h99UokUGni45KJym8/qrGiTazx+Zcc2Win?=
 =?us-ascii?Q?kjR4gXkRJpqvzBMKHiOBcuakDvHIm4MYphgR0Dr/l/KzNhJqbx9aLHUrLPPX?=
 =?us-ascii?Q?UQa/HtoK5SOQHElSWVpxUMDkkRURRWq6+I0AGGJTduI8BrYmxPEJmhmOE2Vd?=
 =?us-ascii?Q?EVOvQpAKi0ZynvW95/zLcRxKuTZqOZtiQJ6Pmp28kDUMdv17zDpRGOibsM5u?=
 =?us-ascii?Q?yLQlsEwrl7H71WjQDXVbnGlRzBhtlhE3F6SKns19t526y+5gcxTls4p9sM7s?=
 =?us-ascii?Q?3PHIpfnRt+015K2ugqupKTR/BPk4j/K6+UP0mv1L7aT90kSTTQBug+jIj/S/?=
 =?us-ascii?Q?LJZj0giTJeGmNsD5Fa0oYUlpCuU3FJzcLTy/yIO0WKI8Tm8hw3VhLk+izCBb?=
 =?us-ascii?Q?uEI8XcnAvrVZnE66iw3e1YELFABJ+oZDUpPJe9RTf4/Hn0i/xf8vjdqrfcWk?=
 =?us-ascii?Q?GvTi7ARcTbjXcaI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NXNf/FRBXMwefLVM87cSjXwPI3aSecXJbPqSc2W4fckvZPnrN4dOjQ9v5CR6?=
 =?us-ascii?Q?BG9k9X7Q/ADfESdm9mTJPv+RU7A8RKsBE0togv/AXBJuUfaaCZz3xASssGAZ?=
 =?us-ascii?Q?jzdV9pYeYoRz853+df6v4Su4+gbwQmA31ajI7sascVDWutJM+qCuRP+hQq9k?=
 =?us-ascii?Q?QhpfDibp3omgUGYNb3vYcGORag+v9MR4oA39zmo6hUaRBToh5hJ2V2lM7lO1?=
 =?us-ascii?Q?KhyErTUZ9QnoqIZ5g4pF1LSDCnBkCVlSBSmEAMLShBeIcY+OZg3Rln1XbBYx?=
 =?us-ascii?Q?9QIJ5HE12mnzHlY42kGfrxokCB1I2R+eXz+kwsG0nSpYhZUJhpSP11DIq6OB?=
 =?us-ascii?Q?tB7v8z9uLT6NFfCqdEkzxAz2WEMTynt7mzpcshs7h9ZjCpTHakYzg2GTC/0j?=
 =?us-ascii?Q?la7FE9w6YIpBtrW4owh7pXpspHbZ5IaEcmvLlHkJa0oewNJv6yqCyShNGw0R?=
 =?us-ascii?Q?2DCqWs+/OjpJWs23JLGqd5595trOkQhSVJb1tkbyxjeT92ir8GUlowZurnJa?=
 =?us-ascii?Q?wLLIVubTU/MNRm/86PQHeup32JXDFizL9PSvtJHBLoOJ8K2Tbjw1SYoJUHug?=
 =?us-ascii?Q?Wa+ZjEFo60ocs7S0MwE40kD+I+Hmy9I2xD95AaxF+YGuhItyTiA1s2+XCAdT?=
 =?us-ascii?Q?u/jc+ely1RIxg7eM4ZNFBL6Piq+8oRhKX829AEFAyRRAfGwj2ydmphNnfp42?=
 =?us-ascii?Q?Emmeeu7XHle1HtFXXSbBpb1Bc/kZY9pAKTFUBli9H1zY+cWF6LE0dPzjxorf?=
 =?us-ascii?Q?mLSqIIMQbOu6QvGliH7ZA+byZOpbG6XOymNHckWENu8eiSgyl5DoXrKuCM4L?=
 =?us-ascii?Q?FaBnyjVBNMPsJHdiY+kLkBK6i1F41l/riiiSJIa8n8LhcLM2KLcUtl0jaIID?=
 =?us-ascii?Q?3rkL7RD/bfh8UOBEbVJpyqHq4ZJnoJoO0c4dkhSYDAqL/Tap+SGFaclnOH2H?=
 =?us-ascii?Q?KPpBOXZ073AvkXbuhs6XbG8rB0EaHh6DU8hyZMPZZ+vfTQBEz9ldF6l9mrzF?=
 =?us-ascii?Q?N0Mq7YrUZb3IEDU65NTgHY99kHDwOX2+mBMQZYSMN/2v2t40jKnfrXsZGJPc?=
 =?us-ascii?Q?/gSDBu87T11dcVKkllObKosh0ZhpwgKWT2xjfl97uM/HMEnYzGowtGYQGX3N?=
 =?us-ascii?Q?uuG2vGkk+NLbFK5bcD/pb4FnmjspgcigHnU8gi9FepCZkWFFrZarJGsuQpkY?=
 =?us-ascii?Q?Prw5aW/8/yGXv3G3LSBtLSz1hUbIUESEUgfflIZSdyYSbsXyMlpeP47q5ry+?=
 =?us-ascii?Q?BF720C9c8BzX+Ws7Kyaje+eg1MqmByc+TYBk473ANSNRfNdMCVhGqAym9Sl8?=
 =?us-ascii?Q?z73BW5tS62eNT4S8lc/ViEb/WOtjgVZrF2qmYHI9T/P4kBm6wCWr0OmcgX8h?=
 =?us-ascii?Q?W1pZCCqCA+LmsbuC5jcQq+6xV5iSR6ahmaKj2Lf504Or/se18Lfq9Y7UaCr+?=
 =?us-ascii?Q?tEDO1lzBJUYfntnQR7WRCNigQ1bsqqmuBCCo1pYTJDSMENB7ilkqTD5BOh6T?=
 =?us-ascii?Q?NzBzec2u8KiYvvzGaP2/4dBbUEVVjK+ybbQB5AChXny97d2OiF+mcPgBUDHq?=
 =?us-ascii?Q?/BdYb4o2of5S+Pc35cVQZCFytSCS5dJEVfxCZkoB38PjVIxQTtK7wDRwGyp6?=
 =?us-ascii?Q?kA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f26f9b8-8494-4875-dc37-08ddf421c447
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2025 06:33:22.0206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /cOzDoJ4pBgRffZmK/Pt/Es9IrVh8WHtGwkq2CB9kOdRi+zsRxtCO0k9BRQiAVXppHe23pPZj4KVPSX+//ZGCO9ij3kEeEGfS6pbRx6YpDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8A8418B02
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Przemek Kitszel
> Sent: Friday, September 12, 2025 3:06 PM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>
> Cc: netdev@vger.kernel.org; Simon Horman <horms@kernel.org>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next 5/9] ice: move
> udp_tunnel_nic and misc IRQ setup into ice_init_pf()
>=20
> Move udp_tunnel_nic setup and ice_req_irq_msix_misc() call into
> ice_init_pf(), remove some redundancy in the former while moving.
>=20
> Move ice_free_irq_msix_misc() call into ice_deinit_pf(), to mimic the
> above in terms of needed cleanup. Guard it via emptiness check, to
> keep the allowance of half-initialized pf being cleaned up.
>=20
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 58 +++++++++++-----------
> -
>  1 file changed, 28 insertions(+), 30 deletions(-)

...

> --
> 2.39.3

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


