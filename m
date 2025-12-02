Return-Path: <netdev+bounces-243172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D67BC9AB48
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 09:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0FD3934422D
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 08:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D17238C3B;
	Tue,  2 Dec 2025 08:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fn+gWCzp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DE822A7E9;
	Tue,  2 Dec 2025 08:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764664554; cv=fail; b=GUv3BOZzKib+w9+hC1XRQ2IzEBqPSN/MAE55y3veLcI4qL2t1D77L4qMOPvMa+JoCUGBN+udpcntX+JBOSKIFxrGodBpGiJwS8CL47RXGibq/XuGRQqpETLcLX77PcJ3QVsCYDfS56PLOl50zyUgMCniTKsryv7Q3p7Rmy6jIbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764664554; c=relaxed/simple;
	bh=LY44roSb44TUm1hBahg7/1X11gq7BVTA3d+MYhBaRkQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AUp15UHeizh4JAl//TS4Md8OOS71HlClvlSvVQdwgbY2z9m17t/IU137bIXiXcNOAXfAB1KZOyrPsGYirQrCzjJN5NvwkUAPFkF0MS/13Q9puTHaDEHkERMZ1QStdJmhZXogGxsQEBt5zQ8LKQiyv96TaRQW0Dxn9PxWfags27Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fn+gWCzp; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764664551; x=1796200551;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LY44roSb44TUm1hBahg7/1X11gq7BVTA3d+MYhBaRkQ=;
  b=Fn+gWCzpLUDP8VKqa4FCDO8rUfV8M5xyT8DNuSz1ruUvz8NZ+CMR6qxn
   1gFJ6Iac7Ut7+tsG2mmLFCii9qgmUwMAZ6s335gGe9UtOZcU4c14mx7Dn
   GBoxzrcTyU+oMJcj3VnK16rjcYS0d+jmxUmBJWFcDxvJztskPXNAKrUrk
   laPWb3P7y1rvy4iCC0nqypDv86U5xD2lXlYy6D1w6tHTkmHLhiELVVtk+
   fOpUKtTnXn93WStkgG3Us45JzDOf1F6wQYjOpuXs+gwH4aMDmYVYkqQli
   chxDrJBF/HVpiaLPidW4XZpMjRFSBoa6mAWGsH0Vd5jlZcS7hqhD7oTDl
   Q==;
X-CSE-ConnectionGUID: 8oAk07rgQcSc6+xw+BGV4A==
X-CSE-MsgGUID: O1PIOan/Q5+3FZZ3iOwUjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="66510400"
X-IronPort-AV: E=Sophos;i="6.20,242,1758610800"; 
   d="scan'208";a="66510400"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 00:35:50 -0800
X-CSE-ConnectionGUID: ItSQacQ0S6GhbZpxt3lo+A==
X-CSE-MsgGUID: /tXW+epeS5OAyEKoVQotSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,242,1758610800"; 
   d="scan'208";a="199443447"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 00:35:51 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 2 Dec 2025 00:35:50 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 2 Dec 2025 00:35:50 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.67)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 2 Dec 2025 00:35:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGwMMCy1vXAyuCCn+I1cEy+J0dp+YUIr6WHp9PEDTI6nsw9ybJJOxRZ0yUI3ZhYYA8BL5ztGdJi7+6J3aI7NqSuX9rV6rjJkcp+BKbIK7OYyW/pBVE5knk7Q/HObDbt6yLRTcEf9uixvEIjzfWxB4WUyDvzryx1Jz3MeQ8aWv/qGja8a+PeIvLeYALkWp2exjfvZdATlDqiDwgQFg/f1SYfp90yBE7md7kngDDCNT/jeSh9G5KEelmFrw1cKqmMI4a1NV3GOWywH+P0yTohhjtQcyCLBf9/NrYy2zN6g8oYIR2Is8d0p3Jjia4vDdSU9OnpxE4BdB5nWEXXof7m+uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNP2D6sw/KXYPXV4/t/nUnsf3JpyTgbLlbqIRs3Zd0U=;
 b=ViO0XWVolBYoKCrgQxsKrq3UVJYOqgZgRbBWBGoPeKAc/v0GB/bGNdEsO2r/xdWOkGLLkfC2Ssqufh+ur2XNeSITEO9HPYyNetxebn4A2pOAt3MDyj5e4RS5Q+V3ZXRum1utJtbzrtqXDr8SvnCr8IDsaKd4HHqOHHJhkee2Fqtgj6PHWLrFFAyY7YA7PqbEZ2UaAm0hC80G/xGU9id5gT9FHrC1j7bsrdxqRxJbQFJVfLN3nUweJSquAn19BnKrESyFA2QETZiUcsnIOR+q+SnmH4o9rp4Au/Iz9ZL/DkcWD4fHTkY700tHwS7jK2M56s9Jp2a1kg+H8GJJbZq85A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ0PR11MB5022.namprd11.prod.outlook.com (2603:10b6:a03:2d7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 08:35:47 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 08:35:47 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Choong, Chwee Lin" <chwee.lin.choong@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Bouska,
 JacquelynnX" <jacquelynnx.bouska@intel.com>, "Bouska, Zdenek"
	<zdenek.bouska@siemens.com>, Faizal Rahim
	<faizal.abdul.rahim@linux.intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v1] igc: Use 5KB TX packet
 buffer per queue for TSN mode
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v1] igc: Use 5KB TX packet
 buffer per queue for TSN mode
Thread-Index: AQHcY0ZCQKzT4kb/JEiJMh2OTayj6bUOBrBw
Date: Tue, 2 Dec 2025 08:35:46 +0000
Message-ID: <IA3PR11MB898696FA859625A437E07A04E5D8A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251202122351.11915-1-chwee.lin.choong@intel.com>
In-Reply-To: <20251202122351.11915-1-chwee.lin.choong@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ0PR11MB5022:EE_
x-ms-office365-filtering-correlation-id: 17b9b09f-b8f8-4449-9094-08de317dca71
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?JRBV0yhRcqEIgnJaKkecjajrFGLycIIqrI66McR7FMaith5/XX3wDHG9MwMe?=
 =?us-ascii?Q?+/Yia0IKi55Ox8P00KcEFNMzB7mj28LKKUb3+qt4evrWZI85vHUsxgHfsiXf?=
 =?us-ascii?Q?K6DX5U4IbZtAcIdBhvD0K/arSzyyVGLXYVQzF3CjBu+0DqisAX8SRbT4eVh2?=
 =?us-ascii?Q?Jsn3Iaabwc1miusR9GFvV87LbYEz0ZTy2ofHHKWafXeNvSgpmnFArOsmMIUm?=
 =?us-ascii?Q?Zr3aEZ0FKJTmHOS/lWeyc7LVOXD2LIfs8a7zmst6yiA+kj5Vt1rDZ6nc+6mi?=
 =?us-ascii?Q?VUjjrfn8yxul/0iZITGdd1Xu9iU9fO5CpHSta9ebD+Gw9V6/5rNBtc+IPsnR?=
 =?us-ascii?Q?Vm97NWM0yT5ku2ReaWnXNjNdRynBHpoG5MgMk9rFoInLgaU9iwAvdQ/3vKZY?=
 =?us-ascii?Q?XZ20Se2vA1FaMtFBgkPamnkTUlyCOOaJcFzUPlWHuimdCXHttKUzMyG4LHJz?=
 =?us-ascii?Q?HTdKE9Rnjuoy3TYbdYKQIxE1o0fLGhvEvJC0ODRwPwbiOKeWGhKnGi7MsZ3U?=
 =?us-ascii?Q?8cuBytXJmM2MgAtHdqh/letF38/x887caF5lh9C64nZ0odsjdUaK3UxsBR8t?=
 =?us-ascii?Q?iVEebqT3Dp/EUvqg6rnk3R48ZInXbC9WDTbF2yDmH1ue+M+vON24CsEjxhdE?=
 =?us-ascii?Q?6CrrlfEG643xCtLM2b28cXKgf3u4mgenFfOObPBj3CYRCx6jEkS4Br46HroO?=
 =?us-ascii?Q?Qa23s4E2mgI45v/Wml2D176Lc64d3rm6krEUCrGdUJaUB6yhJrFjaxWq4ZUp?=
 =?us-ascii?Q?J8Bl3cLt9kPDW1A+qBvhBptIjN6L9aWfUMZsJSyPyvwkN57LtQcXobZ3DlUG?=
 =?us-ascii?Q?aOGtXUCLhktPuxRFpBSrVh+kIrhVeonmzvoe5aRb179XGE5LFA9iUkkqluEw?=
 =?us-ascii?Q?TBkxzHISWiCQGBYfnBK8ZVfsOzrCFm7Gw3KRiLnoWQVEDYiKkEoo1X1lAMae?=
 =?us-ascii?Q?QgpCAPL/PrC1KoHd1nEGNgjC8Appc2/h7kg2KmbTAzeHZRJ17w6REdjYXQKb?=
 =?us-ascii?Q?BhTxQ1Hzd+BnsdG20eNPErjBQh9QYfSn/dEjekiNcJqCk3rgYxquZptqscrw?=
 =?us-ascii?Q?7J+1ood5I00yKxFz4TtiHrdf+gYuILby+yAL1yMxYvGVgvoYgbZT1WaWrJrL?=
 =?us-ascii?Q?j0rPEuhPmvIbEc+k/nwLfmi/a/y7qZ/Ik7d1MSSD4F4kdjmV2N94F2YDRhQB?=
 =?us-ascii?Q?KQ/x+slBh8LZLNJkCy0WCZNP3gvjVTRj7EDtPgKCIztivvgdsP3b1BGgGd7+?=
 =?us-ascii?Q?jtE2YW8bUTTqSBHMKOXgJoUo5VTTZBhcpPLh5ILCVtjsmjFh3mlCu2FT6izI?=
 =?us-ascii?Q?wORaM/Ee8YGa/seUwXJ7zGH7rp4i0BvenNT4eh3zNLmtLQYgEjhpQZvjfXqV?=
 =?us-ascii?Q?oBRi5M6lPUhTrjlzIxwEF40R3vIqQKHglVmzFxTiSrWfgkf+9XwZD9Tu1pWl?=
 =?us-ascii?Q?D1RY7EQosKOFUEYO7cr7L358+ip3Z0Fn9ZCj7DJMQvUMsec6VULLKllvzqLQ?=
 =?us-ascii?Q?UlHnoILk520DGdD2+qQ4xhqzzPBffMPUkjzM69iwkgXyn6wApNOuJNkkpw?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xISbqxcjNPO7GdAZTHylMoivv+dyhduZbBWmJQgZb4zSlbJfDuxQZ8JKJiuF?=
 =?us-ascii?Q?odoUp4cNp94a2IHv535k64RV10SknFrmUm8W7JHtFg0x8j71c8BW6fK3ceAn?=
 =?us-ascii?Q?fo5xB6l1tDf5PzU9ZMOEAW5Pla/z6Zhlh5IXE50iAy2Nbacq8jc+1RkmItqO?=
 =?us-ascii?Q?YtuyLzPsENESFE2xP1ISy9npHnzCHTJ4shdDvUX/oPTxJjJUiKKrTXkrrQtr?=
 =?us-ascii?Q?GkwEdtsgbsIBLHTpOr/1EffGUHAEiV0HjhKzbxXYLX6DP9Sz8ivBP13ofFbm?=
 =?us-ascii?Q?um8uLk8SjfUkV8StYIvTqT8hNl1/V25JVKvHSTxQwC40bELTnxRxbrtJOR6h?=
 =?us-ascii?Q?hNc9kyNjR9XaIQEbLo7CA97ljMlGPkIwV5FgmSdU+wmMMGersblZGpVHJnBh?=
 =?us-ascii?Q?TJSo4Ph6aO24RpvSZ+d7tjUGnleGZjwUjUdU8LNkMjPltXbeWfei7kN32mVh?=
 =?us-ascii?Q?Nkrf600KFOUeDyWW99S6f0Ri6U21GTvOJY5S/jw4mVnMNHY1BQjH8twk0d44?=
 =?us-ascii?Q?b+U5NH3eL/Us14c06savN75zOLnOAgJkgN7cBVMEfA+FMpMw1Um+hF9/EKkc?=
 =?us-ascii?Q?x/Iw+fTrscFBzNb0vnVJg7wSO+8qykZvT/2STBWPPNJ1eLDqRUFy99EyEixO?=
 =?us-ascii?Q?r21Z86+1+Wsn8Gu8g0LzvANGcs5nza1jFadWuKciEZi52sFQkrxejCBj5WWx?=
 =?us-ascii?Q?EupG1JzxAzwF3KbFSbXyGtsvM7PQDnOF/MP3BUvEnpUgPjsrzOsW9c55+v9m?=
 =?us-ascii?Q?efeWv7qoztQ/s1MQgB4abqbK/fu1XI/1LoPpP1m1dEya3S9VjSGbLlndhyPh?=
 =?us-ascii?Q?c0kRV9I5BAPnr550LamxPt2VN2Y7A5BCaQfDMylEx3BJYuQlGDiyqid56f2p?=
 =?us-ascii?Q?e+wcL3/CTGCu6eqw4FlIuqUzn1XFBaAPUuOpLErYWm0l05mblZRssLAZhjNX?=
 =?us-ascii?Q?SZPpQom0S6rw/hCfqP7yxXQ6an1LSFAiPy4BLlLThVQFZxHfsQwUtRUwmHys?=
 =?us-ascii?Q?ApxzvjDu0uxoqmIu2gm8eX6BNRyfuzk15ZLLKeOna7JNNqFEXqd2v7dC6yc2?=
 =?us-ascii?Q?j6+0Cb3zKW8rHUDabHMcwTYmnCTY0LE3tI5S3F73ME6lSMzzsD3rOfMCU5vU?=
 =?us-ascii?Q?nrWOw+6dKqQzVsodws1zKfkXdQaRrW/GD40uekXr+bSLfpDLRGgRzoWCgyus?=
 =?us-ascii?Q?jx7g64qCdkJr8R9t/uNkSjb8TG/BFhNDgjKbZrokViYm6dJeS6dnc02LIC9M?=
 =?us-ascii?Q?v3QFHYuBWOA3L+L/eg2SG7+glrFtccj69wqudnQbWMlIK9PhE6AzQDskalTr?=
 =?us-ascii?Q?gV2qM8WDTI3oQhZpOuDisN3eXADFXt4cdzKA/nYKV0e5WbTpx6/aZ26gCHP7?=
 =?us-ascii?Q?wQefWzII+TqJPyJkTd/AvWH0hk4TsroteZm0VljfgkXMHirtySxYsanIQmNJ?=
 =?us-ascii?Q?l1rPBxlG0hXh65g9Ch2UTXTQ/70dEvEtl9NavRYvmhxtwi208bp2wxYAXuGi?=
 =?us-ascii?Q?IK2+EdCXoqVSNowlhBXN48YFLqO1UATjvhGDN/RJW/zqv9xQExXmlCFJiRCR?=
 =?us-ascii?Q?IXKYWfUbEQfjhJrL7cb0QOGrfSCAZ7zHssJRDCtdgPY7yknbhXL+Oud1528i?=
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
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b9b09f-b8f8-4449-9094-08de317dca71
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 08:35:46.9867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A8VzlL3ReizXyLJkh0UaPbHnw36Y+pVzjSN2QLBOTJmgK/RQgkKXdQ0iwNIZrm7EiK6WmVj7FFbN26PzReOFWmP20v6jWiBt9lrDYk9IGCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5022
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Chwee-Lin Choong
> Sent: Tuesday, December 2, 2025 1:24 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S . Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Bouska; Bouska, Zdenek
> <zdenek.bouska@siemens.com>; Faizal Rahim
> <faizal.abdul.rahim@linux.intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net v1] igc: Use 5KB TX packet
> buffer per queue for TSN mode
>=20
> Update IGC_TXPBSIZE_TSN to allocate 5KB per TX queue (TXQ0-TXQ3) as
> recommended in I225/I226 SW User Manual Section 7.5.4 for TSN
> operation.
>=20
> Fixes: 0d58cdc902da ("igc: optimize TX packet buffer utilization for
> TSN mode")
> Reported-by: Bouska, Zdenek <zdenek.bouska@siemens.com>
> Closes:
> https://lore.kernel.org/netdev/AS1PR10MB5675DBFE7CE5F2A9336ABFA4EBEAA@
> AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM/
> Signed-off-by: Chwee-Lin Choong <chwee.lin.choong@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_defines.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h
> b/drivers/net/ethernet/intel/igc/igc_defines.h
> index 498ba1522ca4..9482ab11f050 100644
> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
> @@ -443,9 +443,10 @@
>  #define IGC_TXPBSIZE_DEFAULT ( \
>  	IGC_TXPB0SIZE(20) | IGC_TXPB1SIZE(0) | IGC_TXPB2SIZE(0) | \
>  	IGC_TXPB3SIZE(0) | IGC_OS2BMCPBSIZE(4))
> +/* TSN value following I225/I226 SW User Manual Section 7.5.4 */
>  #define IGC_TXPBSIZE_TSN ( \
> -	IGC_TXPB0SIZE(7) | IGC_TXPB1SIZE(7) | IGC_TXPB2SIZE(7) | \
> -	IGC_TXPB3SIZE(7) | IGC_OS2BMCPBSIZE(4))
> +	IGC_TXPB0SIZE(5) | IGC_TXPB1SIZE(5) | IGC_TXPB2SIZE(5) | \
> +	IGC_TXPB3SIZE(5) | IGC_OS2BMCPBSIZE(4))
>=20
>  #define IGC_DTXMXPKTSZ_TSN	0x19 /* 1600 bytes of max TX DMA packet
> size */
>  #define IGC_DTXMXPKTSZ_DEFAULT	0x98 /* 9728-byte Jumbo frames */
> --
> 2.43.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

