Return-Path: <netdev+bounces-203838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4FBAF76F2
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 16:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9878B1890590
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 14:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9375B2E7F03;
	Thu,  3 Jul 2025 14:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kn1+/5A1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012932E6138
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 14:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751551970; cv=fail; b=jd95f53M2XvsKzNk6WRjUYcCqltRZssBjMTYWgI+/qiOIFMp7ZMYDo2hOTdLZrRioozQ+/Vkb6nHAhsZ4kP9iOoDoGdGE6J7mysm0amhCFNKCMY4SpcvuRHv0lu00/wAVqjPCn3v0Ff41/T32MO09LsGHUaB7I2OyE0MbdYVVto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751551970; c=relaxed/simple;
	bh=QYEcKSu131Ia7eJ8vNbCCLTyXsdVzoVLm+vR7K0DMY0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EWW/NkIyi+fZiM4G2wLHcpk8hTBDnz+TwBx73Co0SkUuPhHbkfi3UTrqs2PBAIbfKOHc0z1dJR4AhjimXNKWEdNKv99eo8NbRGW/0yOht1uRDTf15njb+8VJIz1DvtAlcFIMnkjImDNQ4vQCKGoxd/ONPZx6QRHr4jBWPJd7OYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kn1+/5A1; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751551969; x=1783087969;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QYEcKSu131Ia7eJ8vNbCCLTyXsdVzoVLm+vR7K0DMY0=;
  b=kn1+/5A1LdRhAMN0C2b647FyjmWjp4caM5UKdly1iMI9bcSkv6XQi/4o
   +yTCYoBfIm6nLqGkRo+BmA91wOAzMQxzHRI3lCpXJXEWetfC/T1ZS/sxn
   qOHGzp/uoh2AlFIWfeKsad9nQ0QIoW6+rBeID4CpY+saT/vmbW+o6Abxp
   +SXVGYWjtvpV7o27E92qPzFHbFw0Bp7tGz1J4JWBVt71SgLeOjqIBivVD
   UHNoIBjQgYUzgCeEzLtSVBVUb7c/npyYJofTeZFUHnHEw7bC79PYnB5fk
   19jk8zLUEtpCYKv/N81Pt0iCrYQGTGsZCIDGGPFbiBP8hsVeJ15hrwuKI
   g==;
X-CSE-ConnectionGUID: Z6BtQX6TSp+zXUFlsQ3jyA==
X-CSE-MsgGUID: F94GEKN9TRWnfB5Kkp45IA==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="79316930"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="79316930"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 07:12:45 -0700
X-CSE-ConnectionGUID: eqMEWdtWTH6pYsxKWWwn2Q==
X-CSE-MsgGUID: /BuqTyS/SP+XeVPmfNKKHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="158656498"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 07:12:43 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 07:12:42 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 3 Jul 2025 07:12:42 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.41) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 07:12:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ayWZve+VJzq8Ay6PNfPrWfcDjNYA98Jp0CV2j0kJn8VD6JZhk9RTCJJ72iMuSvd/ZgbiFt7P2296sDzWyyK/WX3xtUi7QM4szyHWVUYXIsFz7f54+lAR6Iha+iz7/vl4UZm2gzNYdS+FPE8sLTcjtfzjo/lGl3l0nfR/8vU5icP3QJlJeB59SOmgCTguj6T2pdPN4IFAJ0cI6bMOlNm/M0Hp8zCfhG99eKzxo5aU8dxUqTZGI1rFl8LktV0F1tBh8zYUKp/jQe6NIFhJxLapUTKSqNqAZkG3XVFzyCOZErdBlwKCMb8x7fwOn9hTRsOi1rdbhicJ6u1zZEZ+pWY5ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHRgqgIJsGYrkQb9vqURVQRgsgRvMG7vy2gjApwK1RQ=;
 b=UX/4ux+D8macnjPuBG8H3fCSwwzGSjSHKeEtlLu9yfKJsMFhQX98EN/4dAk1IDIqCuH0TVQJw7MNM7eobTnlJGNq2Th5nq2vyhMIwr47fBffP4YPW7RXHVNw1f06KoEsB+WxYm+RKFsjnq4cQBnYoInCInbGAfwcoleI8pOTPp3wV9fxs9iNhbKb7Hv8PRZgdp4/k7+sGT+pQ/1PnNYbteaHlNuzVNCfcm+y1bly8aLcL78+lc8nsU4Yd5RzCcRDsQzmy4MCGt1857XEauKIZzH41CxG+iH4RYQBX2jgZbqQnNMKp1zB0ubXgSW8Cwf895qiw5ngNhZ6c0sv6pObGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by PH0PR11MB4965.namprd11.prod.outlook.com (2603:10b6:510:34::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 14:12:39 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::4955:174:d3ce:10e6]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::4955:174:d3ce:10e6%6]) with mapi id 15.20.8769.022; Thu, 3 Jul 2025
 14:12:39 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, Kohei Enju
	<enjuk@amazon.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Kohei Enju <kohei.enju@gmail.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v1] igbvf: add tx_timeout_count
 to ethtool statistics
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v1] igbvf: add
 tx_timeout_count to ethtool statistics
Thread-Index: AQHb27V6LjvoZ5NoXUq2u7CVc3mT7bP/uM+AgCDYvxA=
Date: Thu, 3 Jul 2025 14:12:39 +0000
Message-ID: <IA3PR11MB898508E41FB217EF240FB5E98F43A@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20250612161630.67851-2-enjuk@amazon.com>
 <IA3PR11MB89867EC734772F4562F67564E574A@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB89867EC734772F4562F67564E574A@IA3PR11MB8986.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|PH0PR11MB4965:EE_
x-ms-office365-filtering-correlation-id: ea653181-cff1-440c-7b22-08ddba3bab4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?5jp5EOdZqD+pxSr0SPYX5FHauHU52eDf9Pooc/FAhRKavD6KdmECPxPQnu61?=
 =?us-ascii?Q?lWWnW81DGdwtiqeWW3NcshEKDbV8lC6Dr0s3Hrm2x8hc87XTej9hCr0RN38w?=
 =?us-ascii?Q?7W4xBH74LdwpoCtHldmaSYGYc7xEvseV29nOphK4pzgBf1q9qFduRYZiE5uC?=
 =?us-ascii?Q?GNSeUUAuauGJIKWGMtWBS2beIhwTm0IUrjsNmoBurl/eDIb0WGlCykIrCWA9?=
 =?us-ascii?Q?s4w9hQsFTnWoOSuBVodjV8Z4phfWpRZIh35Sbn1Sh1v705HLbcJskML4myip?=
 =?us-ascii?Q?dlAwKHQyHVAqmv3JeS0L1tLtgEC6kD+EUv/HGYcfs/9BFhsj/xZ7pj85RGSC?=
 =?us-ascii?Q?y/QoXZcsg09OXCFX963tpXbKLuZ+0XRLwoLlZoF/TqDKaiYbdQA3Y9U1neka?=
 =?us-ascii?Q?OrzCGJpi4g80dVP9jNz8NHq4zeq3rV+6gDd0a+Adi5q/mPonrgkMpF7e6rLQ?=
 =?us-ascii?Q?D6yS610Qk4vgJAMvX5yLPPq1EoXjkhdgHgjnB1IycaumQEaqF+jh9q88ldgD?=
 =?us-ascii?Q?/XOJ5Ww7JVnE6pOoWtELSufhbow6LJ/wRyzYg6zKkTchhuAsb2hxOTwuJecL?=
 =?us-ascii?Q?/g2v60kHWVS1qLsk1+pnBWEeP2iysOHWC+22TtkegZZ7reOjxEyugaKMFrxK?=
 =?us-ascii?Q?Sd+ys7Q0c+6G+tITHTl6eJMbxqirWsTcB1KgfXTdaVHH4r9dQ9Wh+kZjVGES?=
 =?us-ascii?Q?4KjT4IWWKOknTfG+4jXabn+c7qUKx/VaftwrSO+RTvDA9cTQcTvPYaX3VNlO?=
 =?us-ascii?Q?+dWn6DTKER69cov3omRjlYO70kBCMBcaIuXDGAWe5NRFo9ngpVTw4g/Pa/1X?=
 =?us-ascii?Q?8DTdUHRIiDUOwDEOTUel+6iBJhfbJpGNVpGeTHh1uh3B9l9jBW8WRTA9l6p+?=
 =?us-ascii?Q?nSlyHMaqyOoFuiqtZzFX7w142xGf9BEiCPkpOiUrh24FpnUtXrrGk+c+BLdV?=
 =?us-ascii?Q?pi38fBFnRsp84iTg0OIeU9mEb2YahIAXw4puaqnVb1/auzBY7NTDhzmM5TVp?=
 =?us-ascii?Q?yM+Lii+WU7VaMUBfT+nUyTd8huaG+zSJZuK003no99m3SqW6qCpL7PwzwdUu?=
 =?us-ascii?Q?rnuFlMnxUfQAAdU3y+qnPsPq27WTfks3JDipW/HPoTmZAK3Qdd90+FSRzEbu?=
 =?us-ascii?Q?1XFX4wQ4Ayr26KAmFsudN+E7VpbDLuyqbWuiv7WsHTguH9CaB3xO3aKjFPvZ?=
 =?us-ascii?Q?q0FU7lKkBLIqpVO1Sk0xnrWDkU2R0Weby6XHBc7fW6JqKxSm4619ybJcbF8h?=
 =?us-ascii?Q?xLI3CGQ4HW6MF/uRPDkxcFDYo5koisxg/NrE/Os1jGw/8lejqJS/Sl+KDu3I?=
 =?us-ascii?Q?YMmg4U03HDZPt7oBz1YkIwwH0ZhCLmL+ctM26lPLFoDdGsxCn5xGvS0LVV/j?=
 =?us-ascii?Q?mqw89IN9qiEYFXNTb4Qbx/Ghq4o7t7l1p2y5WefcWCNGR3rDeuM5y1CkUjVS?=
 =?us-ascii?Q?y5WffxZMseoKDVHUQ6t8WEca0B+4OJ76206AFAR0Z3aLDLggtX63btsxOLgj?=
 =?us-ascii?Q?nZBpy4vMfdwPIG0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5S8aS1G0jsh+apl2MVVuZFf+nqMjAHQSfKI79896ZpbRkRIThpA6w5Rj+Th5?=
 =?us-ascii?Q?enFrd70oymVarNxzoxAwk5jpu1aj4HusunLgpE/35E/kbPlO2M5LfJrObc02?=
 =?us-ascii?Q?ZOTGBsiaDoE2/6/6OwtLcrM2ge1DDyTS4GIfvy9xI7dWeJG4ZzVAKh0pO5Dt?=
 =?us-ascii?Q?tqlTt0AXXwMf9d5V7LfWY07jIsKd/J2KsZy1e4msifVKl3Pf40Z/P/y6UX4I?=
 =?us-ascii?Q?o03kFh+HQHPsWtKo6ixBDgAPplwBlC4FG6h8yG3bwUHBrTF9BJmCDtKlmR8z?=
 =?us-ascii?Q?iumsccCweHNrS3hIKinEzV39CbS8FgSgCXrYqMkOzzI/I9ssnaHLsOcYIX+a?=
 =?us-ascii?Q?fe3Xz8Tnntm1P+0sIo2tLny/p+Oua6JCFUqhSZr/db3Zpl8+sDCSD+WW1t/l?=
 =?us-ascii?Q?GVElZphunw907yNbMvI8nhVljrKYCrfkQM3NljaLvjoEip9yGzpEAUUua+et?=
 =?us-ascii?Q?us3Ul5AAf1ekrNBu7Q+V1K6etytJCVwErZ3ufBeaVZQ2+qnp4gyfIxosGziu?=
 =?us-ascii?Q?R7K0mxXn3IsUjw/oxK+wDbB1p2A8HjZeB0beS12G2NqCe0BbioND6pAp/FJm?=
 =?us-ascii?Q?K9PQirh2+6iFG+lakUDrRuktM0Nm7N5vJWZ60285YaTcbT3rKdt7V/KTIAv3?=
 =?us-ascii?Q?Ty9lUc7BYo1sg+u23Z9kMRz6PeGo7ZRa977o+0n1a9h/Y4zpcyKjIXIQjP5L?=
 =?us-ascii?Q?uUzjBxNRItWUEqH7THl3M7HOsB5vRywZ8ijO4wS+NLT1yFuBOPmUQF8Zmzu6?=
 =?us-ascii?Q?UGr21+lUxVX2zkmi2k2M75/+S9RJLZeWAdDVZwJ5rZlFdmvONBWdE3KFP+Sg?=
 =?us-ascii?Q?X8u2xdiIusONHLPxHKMpsOWaRS2w341PowNEsdBop0LoN0s+u1MCVTG4fqyk?=
 =?us-ascii?Q?hrr3Y6Fzjx5Nz91OVUMq84D3iVfi7CC/AKPJRwjgN51S2RhZaEnjfp5EiCeL?=
 =?us-ascii?Q?KNsXQ/6AuKUhAOtlKH4Y5HXnHqU3svuiAs7WagH41lwQTxgZFNMgV3TOfom6?=
 =?us-ascii?Q?F22tKdbBD636Sy/6jzOjg7f/s5uborGixmEBihPYOtJDdhOXcVonBZKNKyUH?=
 =?us-ascii?Q?85de4pD5hM8Muxc6V64hNHAfghVgxqhh/Wqyr7U7bZhmQ7i4bH0mzqmOJzni?=
 =?us-ascii?Q?FtiMutSKlGPpcjf22UIznvOq7VagVIQbCSEPFCvC+n9t4xpRWWy4XQ9wKH7r?=
 =?us-ascii?Q?3Y8AuA587BlsaYIVAZBuMTEtsIldtPrY5Ju67QmFNfgrx4Gp33PUcmTn0a8M?=
 =?us-ascii?Q?ZAYpnfByocEMMXCMK1/GpQur49YTool2MhEGeZq/qAoqH1/TJCT1a1fEAXx/?=
 =?us-ascii?Q?d5addqPctUmmkPo3MgaenyPfVveuAfjedVlTGulG/3+jfsZXbyKdDyKKcN9D?=
 =?us-ascii?Q?rZ0qLe4UFajivduHyngBcxbu6V1EH+ZO5xtfj7Ha7TyQl4Qz2Kd2DQi27bJI?=
 =?us-ascii?Q?QOYiti3sVIbPDji+FC7DuKudGVets4y3I48nQs0g4Ip8N54HlZ0cKmvnZssG?=
 =?us-ascii?Q?UDKE5GDO8CWkhJqf/KtLNuKCBdtcknGPkD96R5WLf6PI1oCA7jdK2AmOKGVb?=
 =?us-ascii?Q?QkzfucGUIzfQMafHF4uSytG9IOds4FobF/6dVTgNXcwRoPTUUhZtzfusW3SS?=
 =?us-ascii?Q?XQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea653181-cff1-440c-7b22-08ddba3bab4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 14:12:39.5981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BXdH4MEzmUkDUTrALC8y2Qen8CeJ/wiZ4QClwuHIrkFjBC9MGybw7BJO21hS4SFnNynZuYajUgl/NeB+Y+vhYZ4Gb1DNpUunRo8jNgV/g80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4965
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Loktionov, Aleksandr
> Sent: Thursday, June 12, 2025 6:36 PM
> To: Kohei Enju <enjuk@amazon.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S . Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Kohei Enju <kohei.enju@gmail.com>
> Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] igbvf: add tx_timeout_=
count to
> ethtool statistics
>=20
>=20
>=20
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Kohei Enju
> > Sent: Thursday, June 12, 2025 6:16 PM
> > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>
> > Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Andrew
> > Lunn <andrew+netdev@lunn.ch>; David S . Miller <davem@davemloft.net>;
> > Eric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>;
> > Paolo Abeni <pabeni@redhat.com>; Kohei Enju <kohei.enju@gmail.com>;
> > Kohei Enju <enjuk@amazon.com>
> > Subject: [Intel-wired-lan] [PATCH iwl-next v1] igbvf: add
> > tx_timeout_count to ethtool statistics
> >
> > Add `tx_timeout_count` to ethtool statistics to provide visibility
> > into transmit timeout events, bringing igbvf in line with other Intel
> > ethernet drivers.
> >
> > Currently `tx_timeout_count` is incremented in igbvf_watchdog_task()
> > and
> > igbvf_tx_timeout() but is not exposed to userspace nor used elsewhere
> > in the driver.
> >
> > Before:
> >   # ethtool -S ens5 | grep tx
> >        tx_packets: 43
> >        tx_bytes: 4408
> >        tx_restart_queue: 0
> >
> > After:
> >   # ethtool -S ens5 | grep tx
> >        tx_packets: 41
> >        tx_bytes: 4241
> >        tx_restart_queue: 0
> >        tx_timeout_count: 0
> >
> > Tested-by: Kohei Enju <enjuk@amazon.com>
> > Signed-off-by: Kohei Enju <enjuk@amazon.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > ---
> >  drivers/net/ethernet/intel/igbvf/ethtool.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/net/ethernet/intel/igbvf/ethtool.c
> > b/drivers/net/ethernet/intel/igbvf/ethtool.c
> > index 83b97989a6bd..773895c663fd 100644
> > --- a/drivers/net/ethernet/intel/igbvf/ethtool.c
> > +++ b/drivers/net/ethernet/intel/igbvf/ethtool.c
> > @@ -33,6 +33,7 @@ static const struct igbvf_stats
> > igbvf_gstrings_stats[] =3D {
> >  	{ "lbrx_bytes", IGBVF_STAT(stats.gorlbc, stats.base_gorlbc) },
> >  	{ "lbrx_packets", IGBVF_STAT(stats.gprlbc, stats.base_gprlbc) },
> >  	{ "tx_restart_queue", IGBVF_STAT(restart_queue, zero_base) },
> > +	{ "tx_timeout_count", IGBVF_STAT(tx_timeout_count, zero_base)
> > },
> >  	{ "rx_long_byte_count", IGBVF_STAT(stats.gorc, stats.base_gorc) },
> >  	{ "rx_csum_offload_good", IGBVF_STAT(hw_csum_good, zero_base) },
> >  	{ "rx_csum_offload_errors", IGBVF_STAT(hw_csum_err, zero_base) },
> > --
> > 2.49.0


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



