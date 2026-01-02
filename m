Return-Path: <netdev+bounces-246620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD9ECEF557
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 22:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AF2630054B3
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 21:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06B029B22F;
	Fri,  2 Jan 2026 21:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NCt2UDvT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D233821D599;
	Fri,  2 Jan 2026 21:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767387776; cv=fail; b=n8V6TlmRgwSh5cwekSy1B26cWtdBCzU4g98jTUtG14zBZ12D9abv1zWaaUn6cXQwW3kHxizrdHzN/KGlZ9UyyPy7tsmgrCEmJFV3NiJg/iUDZy5XJ7JA6hclipwIkZ9ZrPyy/c79wNfLOXi8jgXV3wTAwKGmCxCD1zwuOqilt9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767387776; c=relaxed/simple;
	bh=Bc7yk3Zoqh98cC4VV5va0KiE4QTUXG5hxFQWV1E1MQI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z3BxnKqsxhBpCPYPcvxd5WCwq3Zz+g//r0X13Wm+jQkovbQHuG2rgCmRRRJ91LnHqypxIafVKX+JZoE6e9GkxYfJl4qkhKCDiUZmaQYm9GpurzUccO+upeGP7LCgxQDpjUcmFBE1T2+dY0F4KMY3cwBMGc+bi5UAZ0FGbLtxTxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NCt2UDvT; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767387775; x=1798923775;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Bc7yk3Zoqh98cC4VV5va0KiE4QTUXG5hxFQWV1E1MQI=;
  b=NCt2UDvTRksmhbe1YmCf4WWrIEeOknUIAIzn8osrsVfuBmw2DGATN3rf
   5txvdDTwpy79pPgudfdRzbw4UC8/lY2m/GFAAlXIBGzHpMUSeGLqAriNB
   Yn5jdwfbt+gAfVdrofCyvDHbxRlErEqN7COFfUPAO8EjKj1fYDHl3FjdW
   ojyAXEiUgdD7MVzoJWf/nfkePMq6WAN/7GQrXkATkBJjyoKMkwRdTyVTY
   OD5IshS/20rumfM2PgwJJ/6sfERt8MDTwSUkx9rZTeFgVemoOzvXYoOzl
   CCLE/BHYAZlu06Mk/tT7RGn2ghJ+L/HY+0zbIvQeFoFHEbo6DrUuIwYZ9
   Q==;
X-CSE-ConnectionGUID: 86PPQW2ST/29CIi0uXatyA==
X-CSE-MsgGUID: 2H2qudQkTo6vjtz1zT81Dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11659"; a="79994300"
X-IronPort-AV: E=Sophos;i="6.21,198,1763452800"; 
   d="scan'208";a="79994300"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2026 13:02:55 -0800
X-CSE-ConnectionGUID: EB3cI6IHQN6mPS/oljcWpg==
X-CSE-MsgGUID: Y03huR2YT5OzNndz8FDNGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,198,1763452800"; 
   d="scan'208";a="206373863"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2026 13:02:54 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 2 Jan 2026 13:02:53 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 2 Jan 2026 13:02:53 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.14) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 2 Jan 2026 13:02:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FjxaFbKg4oTtjyRhcX304b4kgKWBjz8B9EXbANk/AxwF+lsdB4I1dfAjo8GzSKG8+vbIclZsykiGWtel8/xXLLjLpuIcto8UqFkbolhhFKOeZha5TS4y811STYPaQ7vgI+MH4KxLztBCk2ROC5y3IryLbmB6QBFemA5v/Eaa3QTUerkSoSt36dqW0RaRRk8c9tV1/yhjCbAPsRCTV/EUW526dDyVDoIOikwnmy2KhU6hRueSxMp5AfIr1zmr4qtNUeElHc4oNia5nEYFp36I5RsBJtcuhpE1QpWVf73vxWgmDBEXbzn5T2h838GWeAX6Nxym4qd9gjY6rHhQRHO41Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dvSlgpxlByaKHob+wpe6ZdwkRINdD/qta5OF1d56CU=;
 b=APl6y2RyoJuAEkc2PCVH9r1PD2g/mcJuFO0p3+/w/MwU431EZu3jdXJ/e3vU5yCdh23BbF1S3m++Tt+0ANqwbNr9G0lLuNCGl2pTZ7gibfyJH+B/bnNFNKSFbW9Q334n3/rXeAH9flIJ3OaGB9exs3U98dAz1irVryCc9w1+SoiXWMo3e7u2Uq7sQw8zC3dsPdoTPzB85jYgrL8wx0srBPX6e1ZXChYrX5GGjix5A/ssTZcdH8qk0CwbEdsihY33WHFwwZuqs+NQwRyUMaZAJJbZTtAgHYE8mF1a9lqShQjWIkdEogX5b/YmcEdoYFCgEQkhIFOZgkTdk6RF7y6Dlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF0442004E1.namprd11.prod.outlook.com (2603:10b6:f:fc02::6)
 by CH3PR11MB8315.namprd11.prod.outlook.com (2603:10b6:610:17e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 2 Jan
 2026 21:02:45 +0000
Received: from DS4PPF0442004E1.namprd11.prod.outlook.com
 ([fe80::8591:6563:2984:832e]) by DS4PPF0442004E1.namprd11.prod.outlook.com
 ([fe80::8591:6563:2984:832e%4]) with mapi id 15.20.9478.004; Fri, 2 Jan 2026
 21:02:45 +0000
From: "Singh, Krishneil K" <krishneil.k.singh@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH net-next v2 1/1] idpf: Fix kernel-doc
 descriptions to avoid warnings
Thread-Topic: [Intel-wired-lan] [PATCH net-next v2 1/1] idpf: Fix kernel-doc
 descriptions to avoid warnings
Thread-Index: AQHcX3Hdqrr+VAdE3UmiMduYT5TziLU/ls+g
Date: Fri, 2 Jan 2026 21:02:44 +0000
Message-ID: <DS4PPF0442004E1CB06D450B1A9F7292F38BABBA@DS4PPF0442004E1.namprd11.prod.outlook.com>
References: <20251127074516.2385922-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20251127074516.2385922-1-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF0442004E1:EE_|CH3PR11MB8315:EE_
x-ms-office365-filtering-correlation-id: a2c1840e-eff0-4326-2307-08de4a4246ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?6bzKVBLvr+ejV9W1zp0mZiyPq7Jbxi+xhNteP+OtbjnJsrO7KtP/RAU3zFga?=
 =?us-ascii?Q?ftTlXyxcxLyAw1niJupOWr2iAwH4pjSTojARNc+cNJcT/hq86QFXBWBCPPaJ?=
 =?us-ascii?Q?+LzqXFvmW6Bp0CsjBuns/7msvmzx1hfmVEe4jV2xd0QkaJc2G2RgH+p/hmOx?=
 =?us-ascii?Q?/Jn/c8hDORzDQK6ICtO/W6ME43t2I1Y5LmvRkMSJwAqMRRoO0XEhKWtV7PAp?=
 =?us-ascii?Q?7Enqb5apu9zl1/zbF68I0FqNKOdOpeY7sjdw3VWpJs2xUXT1AmfB0hzgDAkf?=
 =?us-ascii?Q?SVp6KNdcuZtTbcWH/sXjsNdgWZHSXeaF7Z1A6gBNLLfJPn4SRanBOzbueCdu?=
 =?us-ascii?Q?6oDAAul8bI0WR9sxL64p1nMtrXPdV3BGjyi4mpXD4aefh5qw1Mln+DfTeJhd?=
 =?us-ascii?Q?VyixuUXTdB+qXPv622PXvxFPeh+8S+/50whGRtvI7SELGicuAmPJsx/Y66sA?=
 =?us-ascii?Q?/gI5RIpPv51/hmcmzbNnW6r1hU0FMDkoxf3wucu9+QUyvd4nUZTrkVqpQvCv?=
 =?us-ascii?Q?ovAUZ3XILRKbjcPaYjnlvocc3BKgJ7Dm2u7yxks2nf3PctkKmFbGuexUXMyx?=
 =?us-ascii?Q?NfOtwMpp8kiNXXBeoAL/8fW9bTeL/tx51EMu72dKktD6DI2Mfr9dyer1ZsAx?=
 =?us-ascii?Q?16aXQqvyyyX0jfq/1g87km8lvMLfVpn4yl49fLEAPWdNj+e3Wx7pDBrPp9l8?=
 =?us-ascii?Q?0jzirCHc4o+Sr5bfhBeJ3LeVCdDeLWnU38fGvwMwd/ovyKQHtSyS1abruRAw?=
 =?us-ascii?Q?MK98q/ZKoI/Kmi0aKJ0N/TNB7ZCs4BbUKxSha2y9ugfunYRGll9eqwWqBIpO?=
 =?us-ascii?Q?XzClXwftEXDQ46U87FINhjivLl1LwJA8RqZ5jab3mi7h7/uh9vLY3WlUVaTD?=
 =?us-ascii?Q?vi6g+o/bfOe7JkgSLWB+54EzH7Ex3Q4vSKDvjXkWPNo5XqiO4Py6jYrtOzDy?=
 =?us-ascii?Q?Dv6iWjvrNjhThr1EPo0efnJybeiT7F+Tg80srfWQXJXLrk9tzls3gvkbJi1o?=
 =?us-ascii?Q?PEDYWVKEKpnnX3wyHfLEZrtK4xJw3MLXDO3+u12weBhAxp4kd+MsedkIL0ge?=
 =?us-ascii?Q?7bqpEFmvqnWeileko/qjVEBnNK0AYsLsODW1pl9fjHKQRaZ+xFLsInEugRBV?=
 =?us-ascii?Q?JFCBpZwTzaVs9U7m9yuh8I6iM/nJ+AbhE0Ho8dGv+837TRFxDeboAey7S5tg?=
 =?us-ascii?Q?U4ocLHdTaErG8LKvXNyhd/AXWy+4pxmR2Pqy3GVQsU/3KktmaUpLjbjFhYjw?=
 =?us-ascii?Q?EJ/5fSEWtC+Zr/m2QOFDsCWAl08dy0W30Taf3S5y6cmZlCMkekz2aMk28Ae1?=
 =?us-ascii?Q?Qb3j127A6Lltg/mIiPFQb/QVBjyI1moPWxdzw7stn4XcpD6xLAeshYbi9GsX?=
 =?us-ascii?Q?0EQLVEmBZvQcoQnggz0R2EeEOQ4/HTifGykzUs4GgBg0bpE0/Zm49l6WaPQy?=
 =?us-ascii?Q?wK8/5MOqJb+qzlJTdQr6wYc/Mhh7gyykqpwMRTL9quWxEHt7hPZMpKpXnjDp?=
 =?us-ascii?Q?M/DVk9AvoKoLTDQ7+dWGQcXQJZKFC4ThY0YZ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0442004E1.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ij2pAEv3OUuvr/O15ZS75ZXRbqA9C2gf4jymqsmRCoaXrJCTV1P3Srd0Lqk6?=
 =?us-ascii?Q?aFKmd79uGXubOlACIr3o37YpkSyWDRb9T8zR4oFfOY2jFV2Jc0pnaNHSkWy6?=
 =?us-ascii?Q?U8ijb28Gfzb3zMsHbTLWHQeCM1AJppiIDppMr6iLXytM5Wjt6q+PP3/I8moc?=
 =?us-ascii?Q?5dOZsNgocGTws5lhpuMXdJm0yK1K77b3h18jsv+Z2iW8naQ0U8hHZaPmbNSB?=
 =?us-ascii?Q?2RfkfF5EY06VLbyu3WvpGHExNNHAInpBhcSfVCuK45xXbvU5Gr6uQQWVzllR?=
 =?us-ascii?Q?hD6/Fz2syE4VXn3Ca/Q08AeRExQNKIGDzYpcfcLOM+hWdkYy7AdBOh0bkEOn?=
 =?us-ascii?Q?VKE/Hd3XUuRTRW/4GhoTdhp+G+huq69B3KwbFqxxL/Aa/2xdj3vuNoY7fUWc?=
 =?us-ascii?Q?+ylcEefQg7oWzc1ehDKo1N+d6JFmlwWtQFYfY4dWRq58YeR9JdOyA8CoVgTG?=
 =?us-ascii?Q?b0bhUi6CYt4g1uINcJMAOcLJuvUb7A1Lq3y0Jmkf7vhUl8TqMeNG3FkxquOf?=
 =?us-ascii?Q?0RmN55iyiz4Z0mGk5a4W++ZxpCJM+7zzf9786AcT0P+MzAp8HHEZQS79nqmZ?=
 =?us-ascii?Q?F+qN5YGKhEJm5ZA/7VXbn8P7HXzU3PL3ArJ46Xe3nWkxXms4i6GOdo8cBOIv?=
 =?us-ascii?Q?RDSJESDMN3V8/umYKuAnnyBrqaFd8kFKYwDUzoeCUyDBPY0RGH12IaaazAT+?=
 =?us-ascii?Q?CBYCK5JHiBVOkxL6soe9Dv4JQdkVwFhPCMayKYFhFjaXvkbiDJ5dhyWkeQxx?=
 =?us-ascii?Q?eRgyzTSpS18CQSHQyBNTP2A5kKEDQIoshpx7igcOkcujL/eOlyVs5NrXDMmB?=
 =?us-ascii?Q?OHOeoJkMYOCJMmijWR43MzmVIm+KsxV6I+g4q3MRDAn4WsDkOaFzzshm/D6P?=
 =?us-ascii?Q?rLhTS/yG1FyBWzdbVvgAwKCwn7MNHRXvascncQ4p/slLhNKXvWZV6icv8TbL?=
 =?us-ascii?Q?BQQzmgb5gWc/4FUKFDwlZ/gUCfvZSlY8uS8hkqiXSatWivRwCTkzZmSJHuXV?=
 =?us-ascii?Q?JvZw0rWr11C+U8FvTJw5VwlzU0O4EuHDJs0izUWKs+DEtDJuwWMZKjNMyCC0?=
 =?us-ascii?Q?FMhPh4K34CQgGjQJYMwxe2ZGFU3FQ4JzXIpf5GQtXdoRhW/1Vx2dJ+mbam+j?=
 =?us-ascii?Q?U9oAmSxCozJqk0a1c4ixk1wxhtVsvkbrGp3T019Xl5oKxtmL6IOWn7kT/aN9?=
 =?us-ascii?Q?NmOEjWIoMsBBr3DlA5vWMIbaYfLlHtBc9XxiixOODTHZyF1yglhIatVtQRyS?=
 =?us-ascii?Q?Pt83x4wkXI9CD/aew+Q0XdKKgBiQ1klcC5y6NEFVjNxxGAD5XEKgqdbWfn/T?=
 =?us-ascii?Q?Bqmk/lNfCu+DF7Na2+buedWEvqyXBNe6iC7mSKC4r/BGt8bLKrHaN5LNY0ON?=
 =?us-ascii?Q?/8zTARrpFJUzp0JON04GXj4ZoBhdW0n7NVcHJ6aAL05zd8y8Lj6+evc81q14?=
 =?us-ascii?Q?Wt9eSGbsTXMMBXrDL74Dk8TYNnKT8TX13u5lPSTu6+wYxuQn+FqeeK9jqmZQ?=
 =?us-ascii?Q?OUdAFB8OxTdE1dG6pUn4d3E6p5TnDsn+mdIoxnRPLaAkwbe4yoM5rMCjuXJT?=
 =?us-ascii?Q?C/ncp/w/kuzhOlOFsdm473d57zF8ump0IgU09VgJIJ3aMVBVXybJhuUExOD8?=
 =?us-ascii?Q?If12kmN5NvdThzzv2IqkG53WUgynJLrKcY3PdSh7oHFoVWiO9na7BchK+TxK?=
 =?us-ascii?Q?lr0JWv8WV35rXe/g8aayKZKbVwRl8dmK0jjSugk3BJHglRwrQoYwzLcCWtgt?=
 =?us-ascii?Q?bM0DANp2NQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0442004E1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c1840e-eff0-4326-2307-08de4a4246ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2026 21:02:45.0806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5mZxEiTOj0dYcT2pu9gWpNUSnXNhnR6d3CxK/Jxbe0JDPKVnHoukKfU+7zJtJIua8CHXuvCiZUEuqVhOVKaPR+5BbTWvSQ+UmZHlwbz2yx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8315
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andy Shevchenko
> Sent: Wednesday, November 26, 2025 11:45 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; intel-wired-
> lan@lists.osuosl.org; netdev@vger.kernel.org; linux-kernel@vger.kernel.or=
g
> Cc: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next v2 1/1] idpf: Fix kernel-doc
> descriptions to avoid warnings
>=20
> In many functions the Return section is missing. Fix kernel-doc
> descriptions to address that and other warnings.
>=20
> Before the change:
>=20
> $ scripts/kernel-doc -none -Wreturn
> drivers/net/ethernet/intel/idpf/idpf_txrx.c 2>&1 | wc -l
> 85
>=20
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: collected tags
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 96 +++++++++++++--------
>  1 file changed, 59 insertions(+), 37 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index 828f7c444d30..28eb34c35d57 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -19,6 +19,8 @@ LIBETH_SQE_CHECK_PRIV(u32);


Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>



