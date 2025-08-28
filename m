Return-Path: <netdev+bounces-217891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0144DB3A4EA
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 17:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B33C0561325
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 15:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FF524DD01;
	Thu, 28 Aug 2025 15:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OQx9mSS4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CE61E502;
	Thu, 28 Aug 2025 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756396141; cv=fail; b=L5z7XjYaCFJaBpyP7MDxjAsrDGKa5TjnkWbvMDCazNyH12/mj5f7q/fz5n9xfujp0wIbzkXngt+mCnjfGeKzLf7sFu1cx1uN56Ld0u/nVq4hYvpj3waCh+hbYMC3z3Is09URaMe2tyZibGQYwDI6xT6QM29D9z0a/WOWHcXbnSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756396141; c=relaxed/simple;
	bh=Xq9SGNirqlU1/P4HOSNg3VqVt9OgDGFCqg0yR7QGNYc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z/R84Pn7xCyoJCSa0RSnt14XtmADV0smWdOOR2EVVXiVdY6UicN31by7pWNqD8eA/vd/KwyY5NWM5KTbggc4NnRSIkwLNXH4zns2I/5pCazIGyvcbuMHbpi5UMWAOhPUmPxmNlZaETgwbwhJjWj3GnibmvtKETGJXgcqtHGO5sA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OQx9mSS4; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756396139; x=1787932139;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Xq9SGNirqlU1/P4HOSNg3VqVt9OgDGFCqg0yR7QGNYc=;
  b=OQx9mSS4oU5bs5RGYdL8AtwJ1eE8vzEpah0Cc+UAii1XPLcPp+zEh/Nt
   YRs7JeI7uxtTJZsryij6lKIhaddjZKKQCOiKg4NdXhCs/alXR8cMk9f1G
   JubRf8cojMWgM44YhPTJ7ppFwl4nSJox2DpDOmReM9c82hpI90zbwXIto
   g5wNeaJQz50yjHFo3y6hYouT4vtQRY5cwuC2YZ8e6HK8sQDm4J05fLNsG
   gcx4ag/821X9S4tPBdqw5a37FOhMf8fMk6WkLFH6h+A1h/N89tOeGqyrT
   KYTGtPIb2mrM+DdhSo6mxGDapciS0TX5DSurqCISlyo/9DNqJiy5g8O8E
   w==;
X-CSE-ConnectionGUID: YUOHpM+OSOmvdBopaGh6jQ==
X-CSE-MsgGUID: PLaONGVHToq362Rl/Jk56A==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="58734762"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="58734762"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 08:48:58 -0700
X-CSE-ConnectionGUID: lN0F8tNPRNi9R3FEUjEteg==
X-CSE-MsgGUID: 3aSjDXNISEyg6UOLKXJmCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="201064709"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 08:48:59 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 08:48:58 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 08:48:58 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.49) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 08:48:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFRldJdW5NjpfDO3Pv8hNE8I6QT9+1fTA0JU+OcTl2PsCIq9LdsjvVGsJFcI3X0VFNDKb1gVUULgYKhfxMahZBYzr1zeCJD6sK60KCT6ulSLA5qMcHZ3pwSPKTxLvKN8m2j4U9ZfS5TWznfU3tY++SYbQP3pv3TRdixOcrxEHYHdvyb9+krBXDDq3jKUZwQQI6kuaNCUggtfyZoTuv4SU1aPHtHDv41JnOGiuHo8WhgfbPrnB1Mf9JpalL++B1LDuMoqRDp+E375sOrpTpvJhnGM6ryk7bnClx8Pl3OkFf3sMTNB1PbrYbsacu0raBAlQDA3IS+Y4NfS9BPWAtRB+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnRqBY00tbDqfbE6mW5bDoUFSwBQO5GymTeYCmA/drc=;
 b=CZSrIRxXhJI4nzXyIJzl0ZxmF9eF/DffyAd+uom4nxFKWX9/DcDN26vcGTEUWVYAOXkUAM/t5CeUIThk6TUQEO3LpZbt7MGlEpf1lkzYVb6P/obquoOkKUl9n5PA+OLv8AkuucebOdOkTTFdmSyLc87tBuAJlaxlF1aGdGyhAPDo/HMDh25QdFAb/bk65crETRgd3W5LGzFCqnqQVFXXalxu1drGkQ4bv3iRfVq4PoRMNz0ASz/8HqhwrN5AUxx1wlhFaeqKPyT7o41ht6uWmmTVLKgbKkORcO0iW75pr6QhMXKYYr6k1bDMpg0vAS8/sSz4+Z1ZP4Amg43ms3CwAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by IA1PR11MB8787.namprd11.prod.outlook.com (2603:10b6:208:598::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Thu, 28 Aug
 2025 15:48:51 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%4]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 15:48:51 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Ranganath V N <vnranganath.20@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "linux-kernel-mentees@lists.linuxfoundation.org"
	<linux-kernel-mentees@lists.linuxfoundation.org>, "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>
Subject: RE: [Intel-wired-lan] [PATCH] net: igb: expose rx_dropped via ethtool
 -S
Thread-Topic: [Intel-wired-lan] [PATCH] net: igb: expose rx_dropped via
 ethtool -S
Thread-Index: AQHcGBDIZpI8cqDHj0yiQOwj+Q/ecrR4NbWw
Date: Thu, 28 Aug 2025 15:48:51 +0000
Message-ID: <IA3PR11MB8986CE742B3E107719C070B4E53BA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20250828114209.12020-1-vnranganath.20@gmail.com>
In-Reply-To: <20250828114209.12020-1-vnranganath.20@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|IA1PR11MB8787:EE_
x-ms-office365-filtering-correlation-id: 0ea01d3e-ece4-485b-aa2c-08dde64a627b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?myN5mdx0R5yZjV2VjmJ/9C23P+mkvAo5Y+oNJ9mM38lu2tePgBnKh/Hr5Yg0?=
 =?us-ascii?Q?SOSHg2bpRuM54FgPAaHhulKwp5Mm09PPHS2pkyd5PI7+1XgLik9awVQ+xInX?=
 =?us-ascii?Q?23urH15jfnv/2a9nWzBT72N0WY5fhAV6l8u4ep0/d5i9jImSEhAGzF6R0AgF?=
 =?us-ascii?Q?BCCyj/xiWLT74DcPFjq/HBnhQXkhmcb8670VDr4i031YRjBVyuefdWVtksY5?=
 =?us-ascii?Q?9pM1F6J2O2YmpspcikhMd0YJZU+LA3tXbNIHrdSKMQsa3wwYYooBPfdfSKSN?=
 =?us-ascii?Q?+N3YSudlOq2x+iE8nj4AxFDjF5pIx/S0mGovOLvzcM24PDdHQLK/TVYLHB0C?=
 =?us-ascii?Q?tOJRBW3WzrB+OlWqVIJYWhaIMiXhVoDCPUwYcKZeFJkNaO7/7exvOD98DSD+?=
 =?us-ascii?Q?VKosBKLnJnN2s4ENWbevb7z8F8yZ8lbv21X9bEo8Tg4yFmZew29GXtfHhfLb?=
 =?us-ascii?Q?qDf0Qp58l/O9Kp9668jrrzKiKwLmHwy7dDHgUweLfYrDfeo/LPJlOgM5dlgp?=
 =?us-ascii?Q?xiM1r0YgoVCopSxZoQ6nCNxdlwygCPoplfG07rTukJV/aPkQddji/Ox+lRdj?=
 =?us-ascii?Q?RRZpBOowlZ/khSikwHXJ38naOZGsSpJae+y8rI3o3yRSKmJ2VTZLkmWg6hgs?=
 =?us-ascii?Q?SpnPTowETIknJPalUi+7bRUYdVXBSPGvRFlloiYgWbvOPtjzfObYcPaYLuKe?=
 =?us-ascii?Q?NAgAEnnpK1MxmyMfy+zr5JfoFpw9tOdAzQP9xn+4PEPt2Sb+hAw+lzF/wj1m?=
 =?us-ascii?Q?SloCBMaDzBYeeKV6JERL11OBE+mUc9dv0Asuh7ECGTen7O8Bb2p9hKxOuVns?=
 =?us-ascii?Q?ov2/4rhN/+6onUIQ8TqR5AfE0w36SRi8GwYndi2i0/CAerCqgyVcIY4TSJ4q?=
 =?us-ascii?Q?NF/WzbhFeCYMeHs+dVFx9LoP682jF4J6CbtQIfxHQKFPUAHaMPtWYV9wewBJ?=
 =?us-ascii?Q?ZTqEqhSgo7YywizxAw0jPkP/h5d5TMisL/qRwNPKi14iFPZTfxS1L8zMBbBx?=
 =?us-ascii?Q?dKEaAWNLHDoMFdD2btS7vy9MjC+i5Ufl8zWWjjmBt+yCzTzMEcmQfwA9byC+?=
 =?us-ascii?Q?XAR55IUVYLNu+nz4T8gDBKq4TEodArEFLO8F5G6+WUcfOrTmKZU+Lj6TSNbq?=
 =?us-ascii?Q?zQoASFTAQxNJLRG0o3v01nuUz2AQmjGNr6fvRmhPl9hI9RD24ZWJaiGMlRFm?=
 =?us-ascii?Q?C4BmfjVHtZfztqXWQgc4ojUUYaMwRosqJt+1LfYZHaLb/w2zwRhfy9JFuZ5R?=
 =?us-ascii?Q?17D9QrWSiZyBF7sAYcQ+pim2Fsman9Ew2mN0G5/ej9O3RAGHhqvZmIHZnb30?=
 =?us-ascii?Q?jlj+6zj6teGq1U2pXkWGv4n7mYASzSHVrytPzIZ6+LXz7vRVzZPfONx8XWOA?=
 =?us-ascii?Q?1Zc3YRGeEQwka734c6rYD2J+dbkdO6FFVQZlk9oIrGmu88e+qpxdrp8Qovan?=
 =?us-ascii?Q?6ViVWBWUINvvxFcI3GTKSp1fpDcCyGYQS1j1B3E49GdYc4TmwQ1UgV4mD2zr?=
 =?us-ascii?Q?d1ol7aeRlyleGIY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TKqKtchQEX0ykZMZ3dFpCm0jPOQ46W2CurQcxpG72cwA8TL+Kr8Ia5O/QeBx?=
 =?us-ascii?Q?scS+3wZ3XlbliAjiQLzQoypHzqcTSJed712Dg/Qf1Z2Y1mc7jRfRK+zaBDDp?=
 =?us-ascii?Q?vLipYWTf+qbu3jVR4Hev1pj/7YkuLT6OikmRmmmk6CfkBzD89Nlm0z4UoC8n?=
 =?us-ascii?Q?yWzs9GnfGIpWYhdLNyWqt1AEloMC9SEseCK2YbaPv31Kk39Ny+MfcvSEB9XB?=
 =?us-ascii?Q?KygP9r4jZ/JOacTyI4/1BSdfrF1nqDOJTHFLOagVsqHqgsFZ5eOGoO5v4Vmy?=
 =?us-ascii?Q?3ba1Nd5oPcp7w26b46PTzPPY0urec7ktusRmjNfDuvfz9ZHDDozRcmxJ82XO?=
 =?us-ascii?Q?OKep21sehqCfP+Qeq6n3KvGKlWoxrEtbce0+lnVYpiaS0bHehayt3X4k4gpM?=
 =?us-ascii?Q?YoPushyebu7qS/aACm9rkwfueHUu1z+a1TKiZbE0fZw+ajK+5f04ThNxaInA?=
 =?us-ascii?Q?Er2PYB47mYtb57/UdtYsZmJGuH7gkGjRl0QtcUiw/sMFi3ej86bQB9cwMQ8x?=
 =?us-ascii?Q?fJBQYxNTS/JdSpHPjlNKTIfIkeVj7gblloLKNiXIl8Ep1VYIuRJyavJGWrfe?=
 =?us-ascii?Q?DzqCC2nox0JGhSIdyEwRHmOXWyyEhUtd0DiemtwaFagYC7PP8gZthgv6qDU7?=
 =?us-ascii?Q?7oVBtOyWW04sZq51Egtb90twLF2PrxaycXFuFrRt/6q8wel5Zvvvh1dWL3md?=
 =?us-ascii?Q?/F8aYd9/SmQTUoDx/HAJJiA/7GKMSz01zB9IMr0sL8fQzmLjjnP1nH5uMoAj?=
 =?us-ascii?Q?e7FJQ4iZH9m0lYqxnbBIWCE2nk/WeaOTBXuZiG/hkWNJSI6kn+LoCxJTSWCy?=
 =?us-ascii?Q?ftDAp1tAm9+EcpD3IlqZYunHrT7Kdb7RwX/RRF96HXn4FAWo30LmD32HIXp5?=
 =?us-ascii?Q?XNti2LB1/uOMiW8mJTftOx1TZvRjlwJaJvUmo5wiObMCDLoQDaSZnGhfCwYY?=
 =?us-ascii?Q?vg69x/WopmCzso3s4ZBw0J7p4FkYCSBx2luw43oejGRv7cxTqKVeUth2qGBd?=
 =?us-ascii?Q?Ym85YRB7/PuI7QYtdzfhllmDmNGajAKjLHu7TsCVwh6Z/ctSX2nl+yvsYJnx?=
 =?us-ascii?Q?jLgPv7+AqbLS0r8paaXKyr2LJY1cwbAW+486wxXVecmP4g/OZYIcmMRHZWQg?=
 =?us-ascii?Q?p5tUF3Cx8oPxamknBLQK2hZ8rXtF89yli8gSLDW3rO2IQ6nZQwZ+J7xKUxD+?=
 =?us-ascii?Q?S2qxy+pbeE6fJTisJAJtuX4PwSPvBzRyC3PybD/JBc+rPnyoN2hN5uyCYaDn?=
 =?us-ascii?Q?ROy2X30QSHhhNBPsxR9sTRpxw4HuX+IuSAkpqGvFoqUu4w5v00lKK7GInElG?=
 =?us-ascii?Q?A0Lw/Zi4JPFjPLrGn4xQtvNN0DPY7dRLsAJIS+VK1L4c8Hn9gHpnjjihCUnU?=
 =?us-ascii?Q?PkuTBLaQih0X6CWNEr5s2AmG5nhEVI/9422sWX0KC3SnKTu/VWBMtm+rzuX8?=
 =?us-ascii?Q?ivICuU40bP71vAXpDu6WW4jkprhYoc9ih2Uc/3HPPIid1BwbOA4jtkQ7HAC8?=
 =?us-ascii?Q?9Rr5z06dOAY0xV0RtOGkPa+1VI+0ZB6x/8/1lYaDVqVAZHspnWsdezZyLNMj?=
 =?us-ascii?Q?3lgkQiEaAXdicLKLSIzOb0h+0vgKS8D3m7GaveqfdojwHwfQNyxKL+Ljo4mG?=
 =?us-ascii?Q?mw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea01d3e-ece4-485b-aa2c-08dde64a627b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 15:48:51.0573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RA35D98i7VFMrWrJJoER8N9C5a+F6F06ZWwbzb2JwAYLM7Wa0IQ+gbXMI6sQjySqbkzn8iVdsfYQ81KbigEp6yJYpRE1TT0xTCl5Uj3e0+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8787
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Ranganath V N
> Sent: Thursday, August 28, 2025 1:42 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: linux-kernel-mentees@lists.linuxfoundation.org;
> skhan@linuxfoundation.org; Ranganath V N <vnranganath.20@gmail.com>
> Subject: [Intel-wired-lan] [PATCH] net: igb: expose rx_dropped via
> ethtool -S
>=20
> Currently the igb driver does not reports RX dropped
Minor fix: s/reports/report/


> packets in the ethtool -S statistics output, even though
> this information is already available in struct
> rtnl_link_stats64.
>=20
> This patch adds rx_dropped, so users can monitor dropped
> packet counts directly with ethtool.
>=20
Should it have Fixes: tag, what do you think?

> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
Looks good for me.
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

> ---
>  drivers/net/ethernet/intel/igb/igb_ethtool.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c
> b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> index 92ef33459aec..3c6289e80ba0 100644
> --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
> +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> @@ -81,6 +81,7 @@ static const struct igb_stats igb_gstrings_stats[] =3D
> {
>  }
>  static const struct igb_stats igb_gstrings_net_stats[] =3D {
>  	IGB_NETDEV_STAT(rx_errors),
> +	IGB_NETDEV_STAT(rx_dropped),
>  	IGB_NETDEV_STAT(tx_errors),
>  	IGB_NETDEV_STAT(tx_dropped),
>  	IGB_NETDEV_STAT(rx_length_errors),
> --
> 2.43.0


