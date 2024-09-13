Return-Path: <netdev+bounces-128251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15224978BB3
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 01:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA5A51F25FE4
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 23:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3574B1714C6;
	Fri, 13 Sep 2024 23:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GhqXiOV6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD1D16F826
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 23:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726268881; cv=fail; b=Jfa4C7g+Ybe5F5Fs+PlqM/pVnpx6efMPPgw+nlqAcC1gzd0QiXTdMqybkT4O5N575vymQndtu2LVF5x35+sT/xbNw5mv6AzMt/UTU6lQAlIxPUv0eYQDgUboZ98xm8NGiKlk1EWFAiVDnhDr4tpWz9YhAg6CAK2YwbQvE8rjl6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726268881; c=relaxed/simple;
	bh=gqnSRa7h5bM79j4VCnBHQKRwpSKEiiY1g+c3TQoxaPg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sk8N9vXbGswcxmmk2TIuQhWqGgixbN/QNSerJExXH6aWPv+1W7DXxlqZzluIETKunB1OfJKP8LiqCPIJxw4xy0Y8LnZ+5cpFrTQ9aB7N5KnvcaQArQEelundVQHtUly3m2AN49AQINh23zseTpLUVEQLULfKRR8TR5vs8tHBcb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GhqXiOV6; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726268879; x=1757804879;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gqnSRa7h5bM79j4VCnBHQKRwpSKEiiY1g+c3TQoxaPg=;
  b=GhqXiOV6mUug6+9LlwsJiDK13V7ytlmzy26mBzeC6psaZ3nrT80Y+EM9
   XCdLn64zoCs5wdOaGAvmiZzpBi6b2czm6jrd4vRC4Pcth1UPrUJwC7D4X
   sYBu3nRRKf6HtEc4jAMvFjQ5NDC02d5/QZkzbBFXcQFyLqdElqUfwtL2Z
   8c8OmT7IY7ekpCjvFaNU7zj/dhVNGz6IxAsREGS/KfL51y7WDeln2yPoQ
   M9h6oybb43a4D37D42+fuPRbBotLOzSEhBxJq9Qh3d87XSNBtvaxdFKdv
   lEqAo5uBfYjK9GqPpvC0PrV0dndnfhvN+6iVGs4yfWdbwTO4U5RsvmzMk
   Q==;
X-CSE-ConnectionGUID: qzZJP4UfRvyui2AcnWmNGA==
X-CSE-MsgGUID: wTsyIkt0SIOz13px8DCm9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="36564632"
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="36564632"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 16:07:59 -0700
X-CSE-ConnectionGUID: hlgLDu6ERem43S5hS9P1tQ==
X-CSE-MsgGUID: m6OgqJI9QcWHRavADtAYYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="105678967"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2024 16:07:59 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 16:07:58 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 16:07:58 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 13 Sep 2024 16:07:58 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 16:07:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pLjx80fj1t/xueVAb8/5CXHd9+RGBVCes0LG+peky84fMCgfA5Xx9ZyXkoYdBYXLPcuzMfnOfGPpDBOH4OclDnWkC+Li63q9WrX4vyVj9hzfbXwrH+VKUunrtdLeMu5V2bRUALAq4d95GII/BnLeqPVgNtGYB85o4U7uJRIdJbVv2MVyUmetmoKFEkPUfhtESERJdTCwSEXMMcF8vEnLd5z8tncZs7BdIk54YasnhzVkuIs9Mw/rTcxr5J2IdzEng/cIb9vAef+TanLsvtdu7WPmte5BWSXHkFcjYD0geY/t2ROx1GFQzJIqMcKuVRgwQvp/seWunsAO/sdY1OuNaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UtPT4N6hWuYuUV+in1lFaJDYZDLOewisrDZOnkfglxc=;
 b=vx7fwPghVyqvC525QtQtgWpAKBrDCBnqQZXeLRf8i5sgKkewYO+OBz6gJmo+DmTtJDUoZRRDE/6CZazU9aU6/QHI/MaSdonSVXEBgdzxYumkaywSjySQ0+lFh5y5jRzCLG8GptqjKlKzLWN519MjkhZbmi7Cvv2hAm03DsvDf1Q6eo+ShbZJ3HBS/baef6FCpQjvs/ZXxlz4Z5bkTiP/GHFLtpJVGxKDSYlw4I7aV2AiKGoyF5NrMJh7/IXgSCUS0Oj8DBKsNaPXwZP+UgYd1t9+3DnzTWuzaJ+cWGxLe7GsA03kzxLzjMHPzL7P/gS4k4osGYmzny5PGpxoEbPY+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6266.namprd11.prod.outlook.com (2603:10b6:208:3e6::12)
 by DM4PR11MB6310.namprd11.prod.outlook.com (2603:10b6:8:a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.27; Fri, 13 Sep
 2024 23:07:54 +0000
Received: from IA1PR11MB6266.namprd11.prod.outlook.com
 ([fe80::7f3a:914e:c90e:34fb]) by IA1PR11MB6266.namprd11.prod.outlook.com
 ([fe80::7f3a:914e:c90e:34fb%3]) with mapi id 15.20.7962.016; Fri, 13 Sep 2024
 23:07:54 +0000
From: "Mogilappagari, Sudheer" <sudheer.mogilappagari@intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Michal Kubecek
	<mkubecek@suse.cz>, Jakub Kicinski <kuba@kernel.org>
Subject: RE: [PATCH ethtool] netlink: rss: retrieve ring count using
 ETHTOOL_GRXRINGS ioctl
Thread-Topic: [PATCH ethtool] netlink: rss: retrieve ring count using
 ETHTOOL_GRXRINGS ioctl
Thread-Index: AQHbBcDCNfFxzJCH10CXGFshkzVK97JWT2gggAADUwCAAAQ1oA==
Date: Fri, 13 Sep 2024 23:07:54 +0000
Message-ID: <IA1PR11MB62661EF398124FC523CC3C03E4652@IA1PR11MB6266.namprd11.prod.outlook.com>
References: <20240913093828.2549217-1-vladimir.oltean@nxp.com>
 <IA1PR11MB6266964963DBC6242C5CC6DEE4652@IA1PR11MB6266.namprd11.prod.outlook.com>
 <20240913224858.foaciiwpxudljyxn@skbuf>
In-Reply-To: <20240913224858.foaciiwpxudljyxn@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6266:EE_|DM4PR11MB6310:EE_
x-ms-office365-filtering-correlation-id: 5bfc0649-b06f-4a78-dd69-08dcd448e608
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?TgjZdgBSi9oq0gajT+sKyqerQDiHN9g00rl25V5HCTwKGFIq2iFF3//LkEHr?=
 =?us-ascii?Q?Im50giSbuN9IyWt1jTVdlfYx+PcxycoEgp1KBfb7UBtKcwGHQ6j0KHRG05Bx?=
 =?us-ascii?Q?ucyWqpxLycMURdkZPG9exZ4+bldspNix2DKr0RE0sL5VBZ5QRTAv5ocnk7za?=
 =?us-ascii?Q?0ywdY4xb7xhXIcnrE8oPmytQ57/891inKvsrHzqtjsZcyTWesNchqVrE1Qj8?=
 =?us-ascii?Q?twKXcBuTvUjOj2+nTEzLUYNcRRwYFZwdc3B16P1XJqJOMFJSU7ki3+cHWN1F?=
 =?us-ascii?Q?QBw/CnbvbQYAPy387bmM+l5nBPINesgE2XV5u49V6cpqXvAYYW7ByN35aWEY?=
 =?us-ascii?Q?PyYmkZ8XkQDBpdupmkNFiYlRj4OESy4mQbhbIJ///P+rfnb2rh28nhWuK7bd?=
 =?us-ascii?Q?LjwALSFax81lMfWfzHr8G0qkG6kD2aaSumQZ2EryAN9i1buPNdlUjK5gqza3?=
 =?us-ascii?Q?tehlULJ+eAJFfCRLnPOtx4uL0aUMWTpUH2BD+wXxHanm5/4DbJvUB195tgcX?=
 =?us-ascii?Q?72LVERm7QYsSyk6GfvOWZYZ4O/Wfyw4PxSz013CyBWog2WThbN9Etof081dv?=
 =?us-ascii?Q?p3gifm6cOvJOz9t1eCodTFei39oMMMCqWpden6oyW4S2OWWMV0zNfnrOXW55?=
 =?us-ascii?Q?W4LPmI3h8uTdp2Kg9CU45XxoGtcoYXrE4a7yHmBVIhj6TeU/nT6z+Vvg7pnL?=
 =?us-ascii?Q?Ne2K10QOHVOrCzc/CqF6/bvJ4UcTQr8jMjx+dxjJMalR/aUmicQvyMlEkDoJ?=
 =?us-ascii?Q?PHIzl5oaQPfcueXFhyLcm4mW2XPiCqVdU/BiXBO1Kz60xLS/ZPxFys4vIGnW?=
 =?us-ascii?Q?Z7+Xwxkb/hE3OgLs75o6nuTXNkFc4SEWfADJ0qD+o8gR7A0vdVpDgN2Zp64a?=
 =?us-ascii?Q?9rWuE9sMb5x1LBF3SPhII6fZqtZB0lbJ9t1FoEop6TaAfwiX9KcnweT3Aj7o?=
 =?us-ascii?Q?L3yHTLAiG3MLW5y3kmlS1YrQbazETAKS2DoBUn3i6I5p9SSxnYIjITSU3Bt5?=
 =?us-ascii?Q?aMqo+DT+qwqhcoG4gK7OqqigUydrGIdave7xgqBY4a6qgO8u6T8lob2gscZ+?=
 =?us-ascii?Q?3t0m4uUqy4ZJ0vX6UsQFD1+kU8A2T4ea7/OHB8TgMRZlRWoN3DHpveos/DsL?=
 =?us-ascii?Q?f2ylfYdSH+IGT0wyH/68JPvoBZEgcWSkkuxemEm8fEtZWU6ut660cGZfYz+8?=
 =?us-ascii?Q?d8LdSw3NHf8yJJqHAe/hFiyzIGtI+s9vpdyS+oNlIt3vUxGf8luXkd6Uc5QE?=
 =?us-ascii?Q?3i/jURlkKOTLjYdfWeo8Y0Sun8qY0kFvm15xz29v027PrGsY61Tgok7h4fng?=
 =?us-ascii?Q?Uh6MXk3RA7Lo9eLrVkTDp+wSnD5xoabkvL1gHoPac1W39bKrQpI0QYlesBxy?=
 =?us-ascii?Q?8/QnNNVRhOf4FLStIvkJZ80EXtGYtFkPZyg7WGgaFct9DXGdgA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6266.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7isEUpRleNQ8bKStbYJHjrr8Zabwq6JR5637u3GAa2zEKlOPQBJ99H/I8uGI?=
 =?us-ascii?Q?zNAWqSCpCgxf7Vxl/IfaIPGUjKjBdX5apgk/rlK/3y3BKrCGON2iTPjBtAoi?=
 =?us-ascii?Q?bt0nOeDTruQBwbhcUqNtL+MHeFaTDbOYFN2sKA6FAlDcnL8WodV4oyVjU5d9?=
 =?us-ascii?Q?QnSwdeUCMGYpz62fL9vs0RfKX8mxAI81R3bAS134fSaR7lEIijbZMqgDQp8y?=
 =?us-ascii?Q?orYfYI4RookfHuiHHQxgIkXXMg0v2pikOFYQcEhXC7UwPLuLCbUViloMmBUs?=
 =?us-ascii?Q?9vRVTotR0Q1sau1q5Rah2qpD+41nQ/F/ef9BRpOJwLOPrwPb69vGUOYUbTDi?=
 =?us-ascii?Q?apzEhVPODhEYJWtTNqRkPVqw2VnoA+DUFmT+j+g+5Fc1Pcb4OguYj6ZOLnYu?=
 =?us-ascii?Q?iMKfterZkYb5/0RsEr9zJRRpl1IRr6awwumxVKzYrv7YJ2RsUqAKyoIkXWfZ?=
 =?us-ascii?Q?WH+IfkT5aewb0ANkdPrnP46dqUlJI5a5rqBi1P9tbS7rqPQ8iMJrq2/9EvEH?=
 =?us-ascii?Q?CaOzNkXqzuGQ9y1bnGcY/8cUyhFeAwO6B2d2JvBCQ+P9/szdPes2k3nDHAEb?=
 =?us-ascii?Q?nn8/FJKk3AbHohLe7UnKYlT3suZLJjva66hWjvAsc0OCYXzesl29U/L4uK48?=
 =?us-ascii?Q?t1hNHnKISHRrFr6V7lxlb+n3w1RVX/eZus4cd4TDOd++p+K0EvkfrcTGOaU0?=
 =?us-ascii?Q?lzqsxxYbZTpM2tqRsge/nr+ZlyyzxKRrVUKVdQ55oUJPL0TV1j76axQmUsud?=
 =?us-ascii?Q?Howh9TXoUQaUu1Cf4BWm0sB1E5WafvvvK3K/mSd2x/f0v0QrkfW0o/ZlbsxF?=
 =?us-ascii?Q?qLduzirM7ArIFK6baTf4Uy1Zy3QT6dC01+D2iYCOhEINUSdGJkjxwoaxbx6T?=
 =?us-ascii?Q?xy2JDarM3vBfUhor0Foq4fNCUuhOV2aoUcVeLeDtAoRf0ZY9wQHIEgZZFt50?=
 =?us-ascii?Q?z0U27XXaIsrreQdygxiYhodUeM7wkVL2fVVAnBL1FjR2JyMXr+29x5hLEeRx?=
 =?us-ascii?Q?6MDa5fmHyqHXSLXXkcKWfSOzNW2SamgH3JIJCTvHI9CS8rqB5j1GACXpQrOx?=
 =?us-ascii?Q?z+QLHW1HcUissRgp9PuI6PK6KIA9i6atZw5XfNzAbeh4ipuaSKKBT1WLhGju?=
 =?us-ascii?Q?WEEBheK3uWa+BADVwaGALsDWT470s6/y8fdnzn+vX1zki4TUxnZCNQswOs1Z?=
 =?us-ascii?Q?ll4U2kg2gopVaQx+CBQFaY+Qx/ubGpZhSVn4QMr7pFrdeFJlckBPFDBDYSeW?=
 =?us-ascii?Q?4iEobxOx344i5ginF8IY2TtXeWqaogxOZDCeU4GoB69OrXgiHUquWU0+9E6R?=
 =?us-ascii?Q?hiamOc9wDgNP7Z5hv3h374McOrhQtSGufX0NhMNiuEb/rBnuebpta5S+rZ5j?=
 =?us-ascii?Q?J+MEazCz0gV9bK5SuTM2dTM7Lp2oSqZt8OfsJIwyXoDcwIypHLowPa46KUfk?=
 =?us-ascii?Q?dVWkfxP4DGreCMcYZ5BphUOKCdFeHqxw9NUkBr6tB0AsaKFJKB6UfO7QKFp6?=
 =?us-ascii?Q?JLbfHUzWd4Tf6qj5+vGszOr8ohYJlgRinNB0MGgXF4xca55/iEKwBJLYb6Ut?=
 =?us-ascii?Q?o6/sTPPl2Mj1E8QfR+XeIdvq/MPDoN0y+1aJULgQqcYcP3JBTI3d2KKuVuMi?=
 =?us-ascii?Q?EQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6266.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bfc0649-b06f-4a78-dd69-08dcd448e608
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2024 23:07:54.1598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Iye0v4SaokaLmauDpNIRNhnyTKLKricUCkD/BCoFK6tTcPP84fGUDvb32owxSW832wcyrYhbHoazHfX4Gakb2WfiMmTIgQDk31YqUIxatDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6310
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> Sent: Friday, September 13, 2024 3:49 PM
> To: Mogilappagari, Sudheer <sudheer.mogilappagari@intel.com>
> Cc: netdev@vger.kernel.org; Michal Kubecek <mkubecek@suse.cz>; Jakub
> Kicinski <kuba@kernel.org>
> Subject: Re: [PATCH ethtool] netlink: rss: retrieve ring count using
> ETHTOOL_GRXRINGS ioctl
>=20
> Hi Sudheer,
>=20
> On Fri, Sep 13, 2024 at 10:43:19PM +0000, Mogilappagari, Sudheer wrote:
> > Hi Vladimir, my understanding is ioctls are not used in ethtool
> > netlink path. Can we use ETHTOOL_MSG_RINGS_GET
> (tb[ETHTOOL_A_RINGS_RX]
> > member) instead ?
>=20
> You mean this?
>=20
>   ``ETHTOOL_A_RINGS_RX``                u32     size of RX ring

Yes. I had meant ETHTOOL_A_RINGS_RX but I see it is ring size and not ring
count. There seems to be no netlink message that fetches ringcount info.=20

