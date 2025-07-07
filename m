Return-Path: <netdev+bounces-204724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA045AFBE2E
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 00:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22089177DA5
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 22:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1D7218E8B;
	Mon,  7 Jul 2025 22:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B1rc9V7l"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97066186A
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 22:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751926639; cv=fail; b=u8Meko8eKjIYMI5Vs+ci55fZjhMubbfgbmYq5LTbssSmFuwc/4LOcn5wm7jfwf10Ump28EOyzNm8UZ5FaPt1qwVDfSfEKhne6dQpajluep9tGcoOSYEG6AUc9BAyIFK8pOK7pUqmpBR/NhkjV/VR1qcB//c5KgA4Oawa2MwhXCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751926639; c=relaxed/simple;
	bh=2fUHkui64p0UvGDx3rRsYiBoCk09Na8QIpOr2u1NOEM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fxF67nH8GQPdlZP+PoaBIyKsPc3/JBdKoVy69us89GadAWzJrtgTScydYVh8se5YFGaLwRAd+smPiZ62g3P2aQJcmbil8FF6uakbpaCXFRpL+PvDciChVflCBRHjP72YDBYQ+MoF71Fsv8ntEy9Ay2QyB2vpE5xgYyeKHh6ASfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B1rc9V7l; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751926638; x=1783462638;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2fUHkui64p0UvGDx3rRsYiBoCk09Na8QIpOr2u1NOEM=;
  b=B1rc9V7lNLmGGZoB0cfEFYchlwXGgQxHkPXYIANYR5G6OjWAlhvbcvtt
   dCKyLXDy6GCd0EIkT8rFF2zSjRwjofcRJXffeAtt7wjceMcYWBM/CkhQq
   g2xnZLwdopc2lSw0u4RleK3zBP5MQ6DW+r5nsCIAAodrsdK9CD0t6y+ah
   p/shB3IoOqVv9wDNl42JUMk64/6htf1xcd5AmijVkCDr8DDkac00U3pIX
   xs3UcI+r6DhzGy7tnxhza6NqZIRwOtnDFtqgwR/aSC2PqAPlotCXjGTOh
   6ijP63v/FaUHf80nGYM8jZFLMrPam7bQLwBV4Ep05/wC8YDMVUsdYyV37
   g==;
X-CSE-ConnectionGUID: 2Lz3jX9pS0+SEfJM4G/7Mg==
X-CSE-MsgGUID: Vnx1Hj5OQZCnaVs8oc0FRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53369309"
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="53369309"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 15:17:10 -0700
X-CSE-ConnectionGUID: DD99oCFZS+25q4ajLbp2WQ==
X-CSE-MsgGUID: h1apd7XqQPa0jQvjpEprmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="155069733"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 15:17:08 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 7 Jul 2025 15:17:08 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 7 Jul 2025 15:17:08 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.86)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 7 Jul 2025 15:17:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yhtmHe+kdoxEDIBR9BKod2VRbThwLzWN7QHElZAUxVcrMU2G5QtRtpBcNMYObTZco/2y5chKVz16F65A0wtUjIrcThpzcLtfvcz7Mr0Gl4EVhi9o3dsaER2dLP56HLkvlUitVv55Bw+aB24i1x0lK8dPejJa+1C+5yQAJcIWZGJtsJ+I6Xbv/IidY2/RsHz8VaT6usGTlFahFw3YtjuSQUVVFiwALyhipx5pi1HkgeF6mDO72vBdeS28F8BxHN5wEDDt/KYnQvWMc+eZzRuk10vAyAjMoP4IAg8aBnnpNdCm2DkzTf9JHQ8oLFKsz4uBW5sZwdjtT8XczSV6CrG7mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fUHkui64p0UvGDx3rRsYiBoCk09Na8QIpOr2u1NOEM=;
 b=gIFYTVqtSUayca5LpdLjgxaqBaqH8RdnArPGbfPwBYI0A/W1e92YI+UtYuiOUSBGTvNrAOTK6+foAGAan+9+gQDgYOaM9eWiT4g9lFFWqMpj2G5TZEoPjS/6HNvdfi5wax7PHsuCQqlrjYE18oD7Q0TfXc6pZwaOYM7m4bIXM7kG/G+frl7+RppBEmUtUbtYSdUcLSe6+GD0cfu6qb1J+IkqkrzNWMhmni4bOiOBn1M+PHDZFXNl2AJkZFJWkBdzXjp+ZrpqzNAS+615woMs9Q+vtKfv0jVDeRrQIYolbHPY2SMmulTgTmlGU7rRdio70glkCw8gJOyFi7sCW5Frng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by CY8PR11MB7745.namprd11.prod.outlook.com (2603:10b6:930:90::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 7 Jul
 2025 22:16:37 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7%5]) with mapi id 15.20.8901.021; Mon, 7 Jul 2025
 22:16:37 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Zaki, Ahmed" <ahmed.zaki@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Zaki, Ahmed"
	<ahmed.zaki@intel.com>, "Chittim, Madhu" <madhu.chittim@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next] idpf: preserve coalescing
 settings across resets
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next] idpf: preserve coalescing
 settings across resets
Thread-Index: AQHb4gcIdSgzLlp9u0GAcF2ikOVPyLQnVLxg
Date: Mon, 7 Jul 2025 22:16:37 +0000
Message-ID: <SJ1PR11MB6297C5347D40BCAC0B6A883D9B4FA@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20250620171548.959863-1-ahmed.zaki@intel.com>
In-Reply-To: <20250620171548.959863-1-ahmed.zaki@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|CY8PR11MB7745:EE_
x-ms-office365-filtering-correlation-id: 52446b63-16d7-46c7-c419-08ddbda3f0f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?799pdjQgvMWbTWImbRnTh3JobTsHoq2+UiUkxFBWnEkFYMhjdpOfNf0Rn6Oo?=
 =?us-ascii?Q?qzQ7O+VYSjRdJLIZSoez78+4dCRAzXpRVvkYIb4oJsxMkOQr4cDiM4lymLXZ?=
 =?us-ascii?Q?6Z+2+CYwlCdA7JcI7NkNrYFos4mpRi4p0/1gHw5MgsCZEcQRruAXQ3Ub5MvY?=
 =?us-ascii?Q?Nox8Kf+EcSL6C8Bk1cmu9ACArag7e1D1+Uq+6ngiIJi1kTgrqUQ3LGOvc5n0?=
 =?us-ascii?Q?YfzyXXNlXzwxOF+20s1Qjcl5vZ/q3CXrtlUdeZR0abVs4J2/G5QStnoD4wfw?=
 =?us-ascii?Q?4eqxETqVZkLOGVA+EEHv8ZUu0iEJE3ybMqDsO6IZKchEWcYm21YISV/ADXT7?=
 =?us-ascii?Q?53Kcx4EW9z++ZrnssnkKWodzuUk6mq7Pub/liJIMx9M7GfQK63iWc+Z4qWmi?=
 =?us-ascii?Q?4ySSORBrUVonRe/O1tvi222dfMbhZYA8WL2O+RivsM8vAD0bnTnMv14wFuG5?=
 =?us-ascii?Q?S2K3I5qAIk643elH7lP1EQj90QXD6wNCtmxfo2USeXDSI1AMMv1Cmrzh/NV0?=
 =?us-ascii?Q?OpzhVbwhK94QRXsCIReFi02UxGLbzBrfy962gCZczsYTBF7N3abZA3rORdzI?=
 =?us-ascii?Q?itJUD4vTXUtqhh/hud3c3cFKmpPk9x94FLDzgCrXigz+vmhOvoyPiFp5SWDy?=
 =?us-ascii?Q?3uREwR20J652600eYzv0hHXhitYljwn8asQZD8XQIt/qowVAFeWnn+xa8IgC?=
 =?us-ascii?Q?ExqGvFOrcvPuHiRYY46viM3OB9J58TSxDi38c/xMt15t+2SUYHI06ouQcJ0N?=
 =?us-ascii?Q?gZM5OZ7quXCud0IAhgftxYMIBn3yFe/GdJH6fcdO2lzyPOL2cD43+vzBtQTi?=
 =?us-ascii?Q?jO2LxhviEliOTHyQNzp8BAyKDj5xtKf+ivjub7aLKiWuD32JNCtPRJZoW0qX?=
 =?us-ascii?Q?a+0a788DUaZ+Uv3ajLZ/j6e6NxtthoYm3wq57p4Fjdfcr4B4C5QI5dMA8J//?=
 =?us-ascii?Q?UIVa6Ft5vHtNtEfOL9nik6YcYJtNGtJpGVjDXt0alW0N69BPcOMI2gJaW1yF?=
 =?us-ascii?Q?yvfdOPrTzQtNpOzLHQfm/u3of97mbQShzEwocwYJb4FxeKX+OHu0uYs6XMIy?=
 =?us-ascii?Q?sw6fBv+pUdAXLsU5bq5H6yuUyEjalcrrQrbPu66FHxYM70RxpFIN8YCJUCPw?=
 =?us-ascii?Q?keSfZNiUU13BBaGFmRNKe/ZVtJvvx5l/2EVIWfDb0+9nJ3/dFZVXWkGv/ZMv?=
 =?us-ascii?Q?laFikHIHdYrtxLFJDTBUinwVwa3zddzRjPH/N8E+6o9FGaeDEq7ZGj/oOiH4?=
 =?us-ascii?Q?gHFy7/oFu1WteKzCE199CzKMh7710t2LSCYl/ix1PZbBf5ACpghzxRWnz6Gz?=
 =?us-ascii?Q?cAFbOjmkRGHW86r2mIdLonK+VK0Isagdydkqt7h2DQ0gL/OtJRGF9EYZAzd5?=
 =?us-ascii?Q?/qzhnFqE0lVM1xtCgYRPV/0rb0XftALrOcG0V2372cw0ZpZ5Sybz4LIZSNrR?=
 =?us-ascii?Q?K74ZmDhspZ3Dj2H5J7Hsa/DddXwovGG8r6JDoin9qPyYkQoM3oxDlw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DPXI7y0+oSPk2zwY3t7fTxs+Q0oUpDawjJK9MndCoIu95hzGMKPU2i4WS7/9?=
 =?us-ascii?Q?gGxUg5KeOZQfxp2hurGGPZzXBTbC8gtt86LsRcAI8g6geuJfveQNMBCMKkve?=
 =?us-ascii?Q?AJSzPK5pkkjAV5ptVY22aB3QdOf7ARePDixwq0aXxR85FM1mIoEkipPNpmlf?=
 =?us-ascii?Q?8jrFQDGwKtzsR72a7190GvNIjbbu0EIHsFWajiLUZDrGr6PpRC9hkXUQVq1Q?=
 =?us-ascii?Q?YBGfXH106kHouzlOEKbrIB0PdVMzdLxWXm0nS9X3oeir8KK46Zzxgm8dPSdC?=
 =?us-ascii?Q?78oFhVCKC8RN80GiwNynOzF4EfIbYzTXiFfvkNaWPu8VArrN+enuGKhOYa81?=
 =?us-ascii?Q?C1dijgoX3VyVLtvE7uzckmGSyHB6Rw5dAJIZGpg5b0xMC90i018NaHTHM+Ij?=
 =?us-ascii?Q?saz9bFD5QFFxnQtotHwqP+hx8tsbBDvSsdLS/V1zDV6TWXb6JH+YpsnKeqmh?=
 =?us-ascii?Q?lEvMvZi+o1qeyKKPKHeCVjyfKpfdGF9laP1HVJM59o51dC/vUusr0DZPdjnA?=
 =?us-ascii?Q?lboa5a9BoQImYu0ls5T1ifnmNS/rZ3Oha9HhDRYMVEDCm0Map45xem7AfxfF?=
 =?us-ascii?Q?HMFdy9ovh1saMphNSEN6YfmdjK/YBMCY/pmmUMhk2BAZgiKR7AzgdfJT3wF7?=
 =?us-ascii?Q?2qV9I/qTQgU5EY0DN1tAgINRXFn/qKn3LMzHlhcJJSDv/omKSdA8/7wk/sFn?=
 =?us-ascii?Q?V5qiBYwXMjZiB0ciqq6Tdu+TmhVlcfSlgsdNCO3N+KDlocJUxeXwh8O789St?=
 =?us-ascii?Q?OUB8X5wJ7EM6vzT85tfLkLdkDM5EWm9p0bACcdSBD35sZxUIhKZoIUBu/XdT?=
 =?us-ascii?Q?N/rtrb/8jPybzMf/0QHJ8u98kea33BeAjxMlGQKW8/sRTkmbVjFaH1e5SIU6?=
 =?us-ascii?Q?qEfLWUuTjU9K/I7D0hCpfbS8kT9yW0tUvGKxmvzPxEW3Aohn7FdQYg5retc5?=
 =?us-ascii?Q?EBpAd/UPp49AkprAo3KYQZm/Zj2Py5BgEGvWEHwKNw9LqWM68sRWraScR046?=
 =?us-ascii?Q?L4fgMC2zrSYoJlfdleI57KaGfI1C0rYLBjynMSa1aQV1kbaHBpmsfoc7ONxi?=
 =?us-ascii?Q?jaz95VftGnFVx+ZZ0fEdtt9fyJLdqt/QcCI19GANQCe23lCZvq1mX4WRjudO?=
 =?us-ascii?Q?ugF4FiN5GUVZAptcJoLI4gUzkC5Z/zbADOmEtWKoZY5Kl3JUeYsoUSN1Kn26?=
 =?us-ascii?Q?i1IGtMugqMcysCbdjxR70UfmG5wh8UkOPXzpOPvevut6bxJblo9XTeXWjAs6?=
 =?us-ascii?Q?gKrpeZyzu8nbVvxYROu/RvWhgyE9OaFWXott60wsCOy8wqddXHIKWUVo9VWx?=
 =?us-ascii?Q?gojc5CrPgQwHFrMGVH1LmQxkz6Y6RfScx2TQLKkB0w0gIfLVIrICidGO8SYE?=
 =?us-ascii?Q?ku4jJol8hHzQoJkoY02P431ZOP5Y+8rsY16C3P2MwbtId4Td4j+TXrsMHDL6?=
 =?us-ascii?Q?BqqJ9nqnX9/wlJVlj+N4aH+9E3eX2hTvqJlnC1Dg7tj8KS85ifaPuUkyvL9E?=
 =?us-ascii?Q?oCw5XGz2ZcExajIS3s0o0a/88qXPKsSInzbeD+E5cIKUrkhLhKMYYaYXJToY?=
 =?us-ascii?Q?7pXzcyrHN8W8WTY9dX5koilMpzF40mFECCEL6EM7?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 52446b63-16d7-46c7-c419-08ddbda3f0f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2025 22:16:37.6108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eqAJt0GRfaeZd0A5jG0JHtpzAkKhbPQZcWJgOHeBWOH/iBVQt6c7b6FS6nSVq+pcgAHm+wgI4deiCsb5v40Zkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7745
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Ahmed Zaki
> Sent: Friday, June 20, 2025 10:16 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Zaki, Ahmed <ahmed.zaki@intel.com>; Chittim,
> Madhu <madhu.chittim@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next] idpf: preserve coalescing set=
tings
> across resets
>=20
> The IRQ coalescing config currently reside only inside struct idpf_q_vect=
or.
> However, all idpf_q_vector structs are de-allocated and re-allocated duri=
ng
> resets. This leads to user-set coalesce configuration to be lost.
>=20
> Add new fields to struct idpf_vport_user_config_data to save the user set=
tings
> and re-apply them after reset.
>=20
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> ---
> 2.43.0

Tested-by: Samuel Salin <Samuel.salin@intel.com>

