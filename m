Return-Path: <netdev+bounces-245319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E54DCCB71A
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 11:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6097303898B
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 10:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED741E5207;
	Thu, 18 Dec 2025 10:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WRC1gdP1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0772EA176
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 10:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766054328; cv=fail; b=A5hUDtJQGxOe0Ym1SWsca+wjAQeuNl5xXzU2xA6Szau81VLXvFIqNdbRxaKibT9pucGEdPHb/sS3JXc6K6Xn6/gv0M7BBV1PAvJJzqNQJ/tSop0Ya4CP5H2Qdbl87nIWYnFq1wOnQMx0OX56PgUHrQoHTsOFteL3n2YCGggGpKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766054328; c=relaxed/simple;
	bh=BCM7evna34aq66tcNutFMxQTtAPtpJdEni/DeqIVVks=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CDhkMDG7nieOH5EvdDa96kfNdLvHqnBz/Ge2QXItI4vBUxpBW9FMfvTMmXKCzfQUSCXOrkwJdYgMW90T+qac+TX3h8JLbZdyrpXlu34Pfo+3vxqC8C0cV9vez6pDUDQiSq5i+xPdorEY6IpqSxHpFUAfzz+wEJv4xQcpuM6zS+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WRC1gdP1; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766054325; x=1797590325;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BCM7evna34aq66tcNutFMxQTtAPtpJdEni/DeqIVVks=;
  b=WRC1gdP1H/hRZ6wof3Xx/mQ/fl/tDO313EePxgirh4dT/Cetm4AmEaYN
   JpeQFAZBcVaUZZOm+9gNV6ef9WimFMylHzWyvNGJcv+E+omBtnAYBgUUW
   fSk6fQtxcBtfg28I7003+HsmabcwsJMl0kWlJHSfZ1oN7rfLlvi0IyFKa
   qoPL/XbZ0GYHpKA5HUAXNIXyX21isAj93CWY6TyLIn/V0eFFPL9m0Pkvo
   TkY1Sk5hVq50zkrNG8F5keEtiVuNdPDtGQpvikFEzQSpWpXXs4k0DJr67
   airhbOYjWvjvGEqkZd8M7jJ+mtOl1hqqLOzHp7u+uZoAirtcsRvDg52sp
   Q==;
X-CSE-ConnectionGUID: yAW8F756QMWVLsUJ7LkMVg==
X-CSE-MsgGUID: DFXU9TIoS9yWFmRzFeym0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="67000986"
X-IronPort-AV: E=Sophos;i="6.21,158,1763452800"; 
   d="scan'208";a="67000986"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 02:38:42 -0800
X-CSE-ConnectionGUID: BHIfVQI5Q/2W3PeKlRaMlw==
X-CSE-MsgGUID: KiD2ZJUrR0WvsK6jV55XfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,158,1763452800"; 
   d="scan'208";a="235979431"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 02:38:41 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 18 Dec 2025 02:38:41 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 18 Dec 2025 02:38:41 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.67) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 18 Dec 2025 02:38:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fULXbY4ReSI7IP5P8K6uMFYd68VL0cvJODD9CyAGP+TSnuji7tf2iZS/n3MTv3F/m4RuLTwTrEke4jXZFQF6Hg9RISs+HuCAg1RGaD3w/WJBxA5aMnLHQfCqMMtLFyVa5CDzMNOwcrC3WtZsejuPD3C0R5Po/qRriuiCPNpfywhfNFYk2nSUUsEaFwg/SA9GAicWm+yBtn1+4Yncc/d/2nq3kAsKVuum/kp9rUuU1nyeYhbSa+rTRPItobjZKLQjUWe+WzBq1qtauuaKKepogDVczKRTsG5e63QaM2icPq4qFxXCQX2/PQ9uk9qO6X2oJm3VCDKHE0K8BldEY8qFvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6zHhLu0se/Rdm0dZGQJSJZZACUV2u2zoXMfk/Uj5j0=;
 b=mTkEjAiDZXCd2PMo0GO/RvREGlTAjJSwM6bfC/TCVfzUf+835Q0qcK0vKwPcY0q6KKDLU/WQpc7UEMwwtI4dBqkdme/L8ZI1YTyKqowF3ff2dHyw01GmoqiCYeQFbEb5Tdwih8/e9j5Sz52TxkvmXUW70hay9k99kIOGJfw5zeqmUtCYkevRmQEG1PfzY+Dky+Uj7hvecbYWL6j1JQN7xQUoxlfl++ySD8neQ820vSB8SoEof6GTQ/SmcxRQJaVk636zx1du8zrmskGscYHKGgZ/lQkAz4w0qmKQYudLtnoDrEIWx7gHsaqgIDMc8znTQJ2s4fwevFlfedOH4L8YQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH7PR11MB6499.namprd11.prod.outlook.com (2603:10b6:510:1f0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Thu, 18 Dec
 2025 10:38:33 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 10:38:33 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "mheib@redhat.com" <mheib@redhat.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"aduyck@mirantis.com" <aduyck@mirantis.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH net 2/2] ice: drop
 udp_tunnel_get_rx_info() call from ndo_open()
Thread-Topic: [Intel-wired-lan] [PATCH net 2/2] ice: drop
 udp_tunnel_get_rx_info() call from ndo_open()
Thread-Index: AQHcb4d/zQ1TO61ihUKHBLxDTjPyJLUnNUsw
Date: Thu, 18 Dec 2025 10:38:33 +0000
Message-ID: <IA3PR11MB8986C18EDD3FEFC285CB44CEE5A8A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251217185951.82341-1-mheib@redhat.com>
 <20251217185951.82341-2-mheib@redhat.com>
In-Reply-To: <20251217185951.82341-2-mheib@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH7PR11MB6499:EE_
x-ms-office365-filtering-correlation-id: 0f7c0128-a8e1-4872-35a8-08de3e21979e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?X/bvMzTYhQ79u1c6KBK4dBP8zSUp6avfzSx9t85tewBq2VmGJq8YeXDod1oT?=
 =?us-ascii?Q?x/oDXyM9OpKccHnmd8GoksdTmijrO6Ue5bwjXOEm4zklAum7e9nPqwJb/fi4?=
 =?us-ascii?Q?VkGaxMxNdDru6ppuaVgsRXMyGnRPuq2VEK/yFI38s6Cke9v10EMVbGNmNrZW?=
 =?us-ascii?Q?PMndX8TlRKnUGz434uXmA9q4iI0YN9lIJjY1zi9yjyfI3La8NNWk/JitHhzl?=
 =?us-ascii?Q?VnOJSd4IMWsOLS06g8Ns05pjMk4yKtBycj16kbCcO+AsxxWYlZus6JkrY68d?=
 =?us-ascii?Q?/vTwjV9TayYVxX92C227b8jFEfblJsiPZcJ9GoQcl1BEXQlO+MQwLn0iqJEx?=
 =?us-ascii?Q?aEU198SFtJvjELn1OYI0GpQTBDobQAmiKLsiHKBQtMm1qvonmXI3WGHqAjFn?=
 =?us-ascii?Q?UckjA3+vjLtou6SU1rUus4kuUU4xcspJjCesgoIhHAjIxWLDzJb0FVkM0LQI?=
 =?us-ascii?Q?bWoZ2Z2LSYobZi4ClTauoWKR5uCdsCTxEGPG/BHhJa3DYF5Nlm39Z6zZ8qhi?=
 =?us-ascii?Q?3zJ9pNVah/b1wghw2vCQQe1LyfwnRy79PPLQ6ZYRCKiFOVRchDSySIz1fLFt?=
 =?us-ascii?Q?jxFmfuu06jzleql9tUK28d1K7Lj+62G4eIJ0xPH0uJZ9RROJwLsgdrjDS5LT?=
 =?us-ascii?Q?xor9xs02R6CSVlJxs4gQ/2HUBqdL88Hbj8QBpOnT9VKlc4b8Pwj2iyhSkEbp?=
 =?us-ascii?Q?n7/2WtBahF68ck/em0v9WE7tt4m6pm6FjnL9xlmbXTq0ZyorPS0uTUGP7tV3?=
 =?us-ascii?Q?iD6uOwBXq9Ijh/k/oivdQQYSGiNvpXRLCVuiQ+XMgMHU/VLpHso8vXEyEASs?=
 =?us-ascii?Q?FIgECon8COU2XQ7ttHMcf1StEjekxV6ATwHDvZARMTRLxCr16gd4lcF2DXdr?=
 =?us-ascii?Q?DyoykoJyH+I7WllmZQqEWxyWvYHLab+wCBHlsEJ3nSS5/3ZtpSzOIHYXO/2t?=
 =?us-ascii?Q?S3vUaf0PHUL3fBBQi63LyoZRD7N/dgvnSjl5/YmDFBmqD8iBWNkGK5p0mDbA?=
 =?us-ascii?Q?v6USs8f0yGrm9jRM56Vor2eonKKzA/q6CaWq+qcNrY6ukIPUL+edTKd69+gX?=
 =?us-ascii?Q?1Lm0mszjR58qfiJ7Xci6bEWz5rYf02gjVyD0oUxqDLFOHM6jiTmw9WzsT3U+?=
 =?us-ascii?Q?lY+mVxxxTTlR6hd1Yz1oqoeRgWEl3Q6DcR6wGakMxsqs25G3Lvjlj9qtpU7V?=
 =?us-ascii?Q?9P66p8Is2OFEnNFRSSy/qhFgRdRqWJJgMS1Z13fhxTdjuw5ZcDSVRAuaqasi?=
 =?us-ascii?Q?pfG9sCk2TqfWW/5r9FwtM0WqfV5H3eK9xttHON112bp480I54LyBrajMFZYV?=
 =?us-ascii?Q?tlxOm2nDFuFGzsjvkeoKyC7Ojy0iXvRcvAk1ydTeL3VV4i8A1A0Gr1ug0DYN?=
 =?us-ascii?Q?x/oRYi+eo/KQ4WKuiBYmTIY7da6RGQ7rXKBoN1oeGhr+7HnythrxmrJRZpXV?=
 =?us-ascii?Q?qjjeZrFn69XsyPIBBlNGwZCfNEIJaNtxthjoAxzx4RhjudRgiOZ/m/VSQEKd?=
 =?us-ascii?Q?NtDcnaTa3Dd+bOL0IsVFaSnQQyW1sB5IIFqB?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0cfdYYGou6O/FXxvN1v+IuKZqWhhIEDMO1MXzV1ckMHsCC1QiCidrUOcanLL?=
 =?us-ascii?Q?NcUmkWr5/r+9CepxKl3AvbBvRZFrVMzeMB1o2707RdBcQIlYyRnYCfoHQUXL?=
 =?us-ascii?Q?JKYFq7Wnw3Obp/wtqPqZ3w/ZE73LZJQETT0LpCj49eyB3bxvv0vDtNJuUfjZ?=
 =?us-ascii?Q?wPK3r5+1gAJ14Z6EsVfx2ZKhsVc3iHpH/6Zi9FzE3UlZ57Ke0lNL9NEl4Bcs?=
 =?us-ascii?Q?wJC9KIhZzElNU9p/5nZ+naHJGWxwkRK+UKrHcQSW40LD7TSWlk2A3/uwLBtH?=
 =?us-ascii?Q?vFZ7GrQpwpaZIGZ+nNb0RxJ/tU90WWUEQrCKcIsM+pKiCkBnHa0QZfEtd5n/?=
 =?us-ascii?Q?6XSuJMBnpiUhlGON44xz8AzAiUV8NIZoGCs4MH+63T9GQbTOHbicLzlgywwW?=
 =?us-ascii?Q?ZJXmIPo59FUUkgzJ68Wf0TJnNm5mE1lVJWvyMSJS8s1dSXaSx/dE3HzGN5hE?=
 =?us-ascii?Q?0yjPZm7aZRuzhGgh/YsRdTt/xPLuNGp1K98JgXxrYMgjieEJx6ScLct+FEEx?=
 =?us-ascii?Q?yMbA4K/25lQxx7dUdKKof0TYesJwgyYM/+lVSKTbES8K9IqtP+hW/Hdr5Gp+?=
 =?us-ascii?Q?9sEFvRBHGEu4malm0KIwmfPY98AeELQUiqNLiYaA9k1NHevhpS5Yel0I0Ov5?=
 =?us-ascii?Q?KRBZs5MmfbUNiPj8BPO59GJvmgC15DL6fIoGHp+UTHE8+ULzkficbo/xD5Wx?=
 =?us-ascii?Q?4C3SpFtpXUrg7ubmNMSn0gRHaCzF3ahjPlaqAtARhHHFl4mgnIr00kGDZGMM?=
 =?us-ascii?Q?aYJTI2xpqLFMkJ8S7RK7QIh8a7F/yOB2wD3ZrcQDDOsGpnEWtX93CAEFtdbV?=
 =?us-ascii?Q?pV+Lu6/Gdk4iV55a3vyMCDN2M7jkoq2j/gaN88sClMJm6fi3ooW+tOHtUgwm?=
 =?us-ascii?Q?Gvq4oNdZ6483s5Y30zydKlO/5kUfSQo+9179Nsiadd9fx7VfIiCfxuoBGu+k?=
 =?us-ascii?Q?kUM8aGQNJgmWQpN4JyZHqYgJudRcWCuQY5z9J+Yx4+GORMTSzxvxbz2y+xp6?=
 =?us-ascii?Q?idJ4MveenxFArdisnPvXI3UoY0R0PH55mCY4uImfxryxACWh+TDOqwYmi99p?=
 =?us-ascii?Q?PGNcFMhKmJGdfs6zn2nf/MH/lIqL5eQdsyKjid8FWZaDjyGwEnwhY4xk2CSw?=
 =?us-ascii?Q?nmhTMHz+TAlNxxeBq+Rdw5HhXpgoUo8JgFUYmwQNY37bDUDfZOMDC0RCk6G0?=
 =?us-ascii?Q?crqRO71MJ/InIcW2r7C759Boj84XCbid1AmNp7pQCw7PY4NcQR8g+6fIoCUB?=
 =?us-ascii?Q?atjI3gucm74ku+3efu4piQGnAW4/iBg29HeTkjP1zU6gSKhtbNxWW7xYVyZl?=
 =?us-ascii?Q?1fLq4gAOJJZDSH8ASdc60atB95OVPTMIFKk75d+1PVdwfjbQlRgTUcT5Xl3M?=
 =?us-ascii?Q?+AXD4J4Co7tvEZv9uBNM5hbvc6i3NuDS8ALOc2iF8nrLqHAkjtwsc20RVZOG?=
 =?us-ascii?Q?Gdgmsyni+L8zPHFkhk6p/E/XKaHgZ53uz8EZPyqG2l76X46hCxpImFnJ1w7z?=
 =?us-ascii?Q?b0eG5X8oAplQhW3nnIx/jsV92UqsOM2KHSgmajTnDETZKOJRoqK8n3QWdPpZ?=
 =?us-ascii?Q?77y7BUBOjtipqgor9T/OU99EdWrrN7tg4G9hjvONqwGcSyoC5WkayClnfGJk?=
 =?us-ascii?Q?Mw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f7c0128-a8e1-4872-35a8-08de3e21979e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2025 10:38:33.1530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7A2gUCXJw+fbS+7BVIDFbXhXNQs/tka4vUPrRrS2/C+lrmbKXVgjWoWXA7EgLCXvnWRWBrc8hgzgTa+6gFqILkuKjcoXyKropBSPrlknA24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6499
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of mheib@redhat.com
> Sent: Wednesday, December 17, 2025 8:00 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; davem@davemloft.net;
> aduyck@mirantis.com; kuba@kernel.org; netdev@vger.kernel.org; Keller,
> Jacob E <jacob.e.keller@intel.com>; Mohammad Heib <mheib@redhat.com>
> Subject: [Intel-wired-lan] [PATCH net 2/2] ice: drop
> udp_tunnel_get_rx_info() call from ndo_open()
>=20
> From: Mohammad Heib <mheib@redhat.com>
>=20
> The ice driver calls udp_tunnel_get_rx_info() during
> ice_open_internal().
> This is redundant because UDP tunnel RX offload state is preserved
> across device down/up cycles. The udp_tunnel core handles
> synchronization automatically when required.
>=20
> Furthermore, recent changes in the udp_tunnel infrastructure require
> querying RX info while holding the udp_tunnel lock. Calling it
> directly from the ndo_open path violates this requirement, triggering
> the lockdep warning.
>=20
> Remove the redundant and unsafe call to ice_open_internal() to resolve
I think it should be "Remove the redundant and unsafe call to udp_tunnel_ge=
t_rx_info() from ice_open_internal()"?

> the locking violation.
>=20
Please add lockdep trace evidence in the commit message.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

> Fixes: a4e82a81f573 ("ice: Add support for tunnel offloads")
> Signed-off-by: Mohammad Heib <mheib@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index 2533876f1a2f..1f94bdcbbba9 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -9633,9 +9633,6 @@ int ice_open_internal(struct net_device *netdev)
>  		netdev_err(netdev, "Failed to open VSI 0x%04X on switch
> 0x%04X\n",
>  			   vsi->vsi_num, vsi->vsw->sw_id);
>=20
> -	/* Update existing tunnels information */
> -	udp_tunnel_get_rx_info(netdev);
> -
>  	return err;
>  }
>=20
> --
> 2.52.0


