Return-Path: <netdev+bounces-132105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B662990716
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 17:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2545228C717
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 15:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194451D9A60;
	Fri,  4 Oct 2024 15:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G2OtLtML"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C58A1D9A47
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 15:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728054307; cv=fail; b=tcciDz66z8Hz8qXPx4ryp2HZ1UmwsoypCVZ/jlAw/RLAloAsw6WcqC5Fh1osckUrYAsUt97SeksF5oqlgzLAXsDKl/n6OgQB2TahOcY1SO7ZL+0oyvWvUqaTDtXvCDN80i0QRJtEVcQAYryiS6khfc2ChoAT/kUrJr+oPviPbQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728054307; c=relaxed/simple;
	bh=7kHWXH6KvBR9JjaVNZNbetYisrKWwHj12511kV8uquQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cqbsOf7YZnV1bnSw48nfBhb5LuJnNX5VhLk3zWKKAbmlwCRkFPN1YCJ9mMnIvXd5jXtwnUj9gHjl+8A7QH+8kzVVloYpkr2Ph7y0HPNcf/Vie3X98/eFTzIyNsf50SzESS5jtjeUxsImV492OKMn34QRxjVjecrCS8M+tYXdroU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G2OtLtML; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728054307; x=1759590307;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7kHWXH6KvBR9JjaVNZNbetYisrKWwHj12511kV8uquQ=;
  b=G2OtLtMLSGkI12Eut7vcz6+3nLAPWhHL2cFY795FaCO6eMaauYqut3h1
   /m2XhYtSuXsAbouXm/Yt7hGsP/GacnOoFd9aqgD4ADLLqPrek/5SPvVFy
   ErYSGXfFAAzH5h4EZdcM6rckCRNZNM3hFM1JLfgtfUXNvbQTMh6vvDsaK
   LcAAvf/mk8bEm1wILojjN4gw+a1TEyUiOXcnWV0W9on14hgqAWNWxWMvJ
   RzW3VSmYZZg0stEEqKoICG3YCyOng6L1SkIGvnT/rDJz8vNf8rK3IQ2tL
   Hf6NcwqtJ/GGm9U9A3JRSmM6N2D26Os3p39snRs+4t/Cyd7jCULRw06I8
   Q==;
X-CSE-ConnectionGUID: TANlxPs4SwyTb45beZsWXw==
X-CSE-MsgGUID: wqumvvX6RIuBmk164qrZzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="27369968"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="27369968"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 08:04:59 -0700
X-CSE-ConnectionGUID: kHiOruz7S4SML0u3AldM+w==
X-CSE-MsgGUID: LwUD3fCPTlCA1KPJ0v5plA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="79302775"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2024 08:04:51 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 08:04:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 08:04:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 4 Oct 2024 08:04:48 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 4 Oct 2024 08:04:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7iI07xusgOBOxRYc+jNNUIfV/mR1Ydryuc504X6YU6KiD6SprxaOQEfYwpjhwJeul9Ypo37glvL3aR8V9WeQGsZd4Wtm8Z9aNigrlRomsqnVAX4uNiCiLwz3CfL7plcun3R3ecNHSEVoTc7oXpn3BAwOGAAck+gcQZQ6lZoTliUHLuH4YK9BEAdX21cVr+gtcIbMUcHHGrTbMb1Z6zKgO5DnXeSqR2PnWuKakRhQUXQtaALXx1pLxHrxkHEtfY/hNHmCe+BdrD2wGynRv/8JQmFxYLB7w9TYY0+8FqG2qbcOXphvHJt0oZ1NJpxf7wzPxBRR6gQctKPEdxU2nYnAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJjgXfI8GbEKL2ozJpVa4hgzPzqKeP9vQ3DorNZ4a1k=;
 b=pETw/DjpfHqfMFhNeJqi/bSLAUFZT6ZMvjePamLEh8o17Z29JWLQW5EjzkGgiqqJ8WhpbYn/Ywx1dSVSzmT1CSJkQCa1O8T5GDjpKsak4KfNGGAQbHaQ85ewcNTD35xxxpSzdqfljMNJlpST8nSz5FSUMpDnpSuq0qaIet+7mDrK53rFlarwS3KxUGaTBkZyxEeRqGlyct6dZZ6OvBaMEvVKbxeQjl4VkqoAxgYMCquL7I4w5ltbXHSQlre+U60xJ6fB1q8UGNEkpMgM1lPJ/L4XSw268XFFXeZQCC54tzK6/C6hm2gLLypjJYh5358KdZWC/jzhts/5FsdKncAWew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by LV8PR11MB8771.namprd11.prod.outlook.com (2603:10b6:408:206::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 15:04:44 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%5]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 15:04:43 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Kolacinski, Karol" <karol.kolacinski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Greenwalt, Paul" <paul.greenwalt@intel.com>, Michal Michalik
	<michal.michalik@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Frederic Weisbecker <frederic@kernel.org>,
	"Kolacinski, Karol" <karol.kolacinski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Anna-Maria Behnsen
	<anna-maria@linutronix.de>, "Olech, Milena" <milena.olech@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v12 iwl-next 7/7] ice: Implement PTP
 support for E830 devices
Thread-Topic: [Intel-wired-lan] [PATCH v12 iwl-next 7/7] ice: Implement PTP
 support for E830 devices
Thread-Index: AQHbEzK4XSxjBZsos0ujhixi94gWY7J2tlcw
Date: Fri, 4 Oct 2024 15:04:43 +0000
Message-ID: <CYYPR11MB842919C5C3BAE3EE4751DCC1BD722@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240930121610.679430-9-karol.kolacinski@intel.com>
 <20240930121610.679430-16-karol.kolacinski@intel.com>
In-Reply-To: <20240930121610.679430-16-karol.kolacinski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|LV8PR11MB8771:EE_
x-ms-office365-filtering-correlation-id: 71b6b382-09e7-4f17-42f4-08dce485e128
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?hk7hzIKpnxoAGAXXo37xmygk/Ns2Pqla1v9GmB1T1GiM8D9Up39Qz1+qcPib?=
 =?us-ascii?Q?pkK3DJe4tme/oWFSbwb0/+M9CIVcbuCz9MVEaUJIZkz0C3yWmZXHj/J/BONz?=
 =?us-ascii?Q?Y55/+fWCyee6Eg91TXMvP1aa/Vocium4viBsXjScpJIQSnlBJ9N7yeV4APuR?=
 =?us-ascii?Q?Kvs9OQ3UpZkdQi4GUfEF3PMMUTCTO6rXKjIDrcbSjF4Bf7Zl37NDgKZS3xBj?=
 =?us-ascii?Q?lSFX+IVsybt2/RVqjv6RjMWvhvqrk7IALI8id2bY4G4Eq9OPlqJaq7AMV8Kb?=
 =?us-ascii?Q?SRH3eMSvKmXDEKIhbC3hkd0eIb6kEbWqSzPYPF2lSMqzZENL1DinJcx1z//Y?=
 =?us-ascii?Q?PZeDB7TflOLEaVyv9V2rnp8NkxX7X1YdaxNgFLTXAYEZtHQUcs4usMrpMz39?=
 =?us-ascii?Q?M7VInQ1J37S4DCBEfWoUBynBt+6lGhc9fUCSWZm08N7cXGXHKkUBX6fAPnM2?=
 =?us-ascii?Q?KhrjjxRDLJ0v8TgL2QhZlzuyj1pc32sh6fa6VnB/VCzdGsIxx5h1nVwsMXRn?=
 =?us-ascii?Q?HJtlQwldvsIpOQFNElgn6+Ia3952KayTtXSFbq6TLzZTbsy+t+tHVSf2Llwa?=
 =?us-ascii?Q?Mbxv7mqtPMQ/U8XoMSTJQjvqWOEBQBkNBrsUbAlYVXATRPHrkZbI77TKIIV3?=
 =?us-ascii?Q?rMg1iyOphYIbpPV8a9qn51YFZQw0mCrXKOKRLWGDpB4pADrAkGyGlNWHvbaG?=
 =?us-ascii?Q?Of2JyGmFtWwd4g5kFu50tDYK/trOBX+xk8ZvsA/8U8deBMBplEFD0UW5ldVF?=
 =?us-ascii?Q?AcioocAMO/gzsEjTOFgQJ6qCoWkvWekfaEWRDwJFYGfgvPfmAKz16qulOo8Q?=
 =?us-ascii?Q?N3NUVmBSFA4Awh/ahvXnD6PJdYmrt32tWFEO9CV5cp2OkZ49+Kg15qV/+dHO?=
 =?us-ascii?Q?wf0GwAIQXmNpXXhiHYs2paBN91WX6H9p/3/jw67PObBITbKG4CKA8+hCqNr8?=
 =?us-ascii?Q?jGYZNk/PCQ0s/owHdsAectADeoVcOHUriDFaaA8xJX6YefKKS9CRznnqQJfR?=
 =?us-ascii?Q?GYcsODs/BC9gktjSv4TqXKNlS+/FUmgEXUenG3Eo1LlOi8KOGy6oeKNlnP5o?=
 =?us-ascii?Q?QBbA1Xx1Mz/0M+zY7zBcJflHc03m7N9WvVM5zLsPyErWCu2gAwAZVlVb97Lt?=
 =?us-ascii?Q?Tlxh1d4s07IX6XAXC2Ii2usJ+vpokzmicGA6GRS/GFWScBRK/HPba0bzDuYN?=
 =?us-ascii?Q?FdztbLK6330hziFEoBpC/lCrcPdkPcxvXOzdJCbrGGoyHX7X0VUPQiTg03kH?=
 =?us-ascii?Q?Jl8fjThv0ZupwUQhC6N4QvMfopxMCm4GBE4zwYe8BY23mL/hhchLvqksj61j?=
 =?us-ascii?Q?ovJIH2rSJdRzCciFDg0r0rSBP4dexztAPmiHk9FTOTlFlQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jYsow7pHQW2T3fxVRVDrKDzC88JFi2nS19sGuIArv55CuMe2l+dBF/6cS2kh?=
 =?us-ascii?Q?aHvzwmXxG/J7I75zR8eYo/21cOusw8CvwBu2jK3AjZ8SVTWTB5pvhvn8iV7A?=
 =?us-ascii?Q?PDUQ4H7RkFW5KDpG+x2jlGEUXH2EcVxO/v328nIBHIdcTWbmCaSkSihnoX8H?=
 =?us-ascii?Q?iNv4vcR27u4Iz62mmimbyttWs8L5EX87tcqD0DVI7KjHNzPe2wn5VqlL4mRy?=
 =?us-ascii?Q?/cBDdVJYRPEdReT8wqqW2FhyiGC9iOhv+rOD9VmySG4yJ4idD1WeYV9uRI08?=
 =?us-ascii?Q?Jsti1X7/oAx+lFN6mwBltyJTHRaZijMu4oxDwKA97Be+Fxmjm/ClBccyfA7v?=
 =?us-ascii?Q?jsSZ5gKjPmCeoOrqNcoMOsH7UPk7srlm/Gwkiv8bU2dEhF8iNmIKyDBj4Zby?=
 =?us-ascii?Q?yHZWkCyO6NOwH0Jz0eyFCHFPpPRA9nc5BpNqHEHzpogjSONmWq/84IwDlQTi?=
 =?us-ascii?Q?hcDPaz54WpunJIkuREkcGYFuPAMpFAqy2P78ZnHqpilSxWD0IqPg3Z/oZjC4?=
 =?us-ascii?Q?hDS1RYxJdBt0H8xUNFxdU4FJfA/cUw+qL6Ud7Xy/14HnI1qJJPwRUtPKRfS9?=
 =?us-ascii?Q?LpiVVfeMRNkzyFI/XVLjm+f40fT8t3K0UzZudvIFi5NKgjZ501yA5KESoV43?=
 =?us-ascii?Q?tGOI4FIKiaWMhpy3XAc9VUXjU0b8wLhhvhIzEEVoKtGfcyRNpRRLIH1AceyL?=
 =?us-ascii?Q?PA2eO3v+wWF/DC+T2jqDEpdZORG74sXy7exLG16NvZQ3iq/aWiH8i5az9enq?=
 =?us-ascii?Q?NeISUake3/QHB+OVQdi+sjW8EsAP1xskn7PzKqSySbV6DGUmeZnwrv3FkVgx?=
 =?us-ascii?Q?JG0FCSo021X1UFCZQJUtqnHU0CQ0C2ibUe7FDmO0X4/SM4CyoU6Cp+xwn0Ve?=
 =?us-ascii?Q?h0uvW3v5naZukYl2NSmKkegn/H6Q9EJwho7TRPLHHodqKMFll6UYIiUo3thL?=
 =?us-ascii?Q?PAGsq9y8AXVg3kJIa9ZvCaYXZskpQSVDWDWAAsTAVyFVRQyWztngFvwl1sY5?=
 =?us-ascii?Q?IOEXRykhXIricuON2URzAtCyCRCCFkSxGQxDKyKeVQhkDSgBhTGuZ8jOICkj?=
 =?us-ascii?Q?MoiaNmJSSXfMCXFpCGyrBrx30dl9kBRJ2azLPbrIK0NRLv72c5OSyfoTVUvi?=
 =?us-ascii?Q?ye62QWvQPsvV7N68ecIroMzMAtp3TsolV9AanTtOYHDnPf0Kx0MiYa+EuEiL?=
 =?us-ascii?Q?fI1UXDEg/P0CnUUKInZr6VR6NphtNA0g8lnDrTpTx9kBJGM+D/Cq/nkbhddR?=
 =?us-ascii?Q?kWRvpmc7UkuyZPdZB0ewBoV5+6iBMbYpoLCBdZSIw7TGiMyzm6nSdArGzAl8?=
 =?us-ascii?Q?jdfrjz9evP2kfm3LRwL+ahZme8Q5HSOW934lXBImNTc4K5cSwLZ2kZN2i9gT?=
 =?us-ascii?Q?1kX2dmJcy1ntvzP/4bcrDK2a4wUst+9WJbkVRJEj+v7a58PE4wQ3n6tiVGJH?=
 =?us-ascii?Q?t7SGKtzu3DRfEkTbGnz6aOx0Lr4NE7KZbg++oK0B9LKobsEs8DUzuq1wad+E?=
 =?us-ascii?Q?OnZBhJKWB9Fg19oEv7YbtE7HfBdRuUQLA75LZFqWygnCGTioHB7/Mkgy9aX9?=
 =?us-ascii?Q?SjfDH4YsyyW+LwwJbA7iVm909RYju0PMdSy0L9fo8uSgj3qc5WFFl1BW7xcd?=
 =?us-ascii?Q?gg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b6b382-09e7-4f17-42f4-08dce485e128
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 15:04:43.9042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EDNZI/p5ly86AHJLRID8/egf2Wkt8WmthuVSfndcrabLZHL6qHrF7Trg5LWgScPYAxEQf47MpYfrqun9mb/ceg3D4xe2C6F+hluPdA5SHlM3IEDvgAvTj0l2EgLqCT5Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8771
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of K=
arol Kolacinski
> Sent: Monday, September 30, 2024 5:43 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Greenwalt, Paul <paul.greenwalt@intel.com>; Michal Michalik <michal.m=
ichalik@intel.com>; netdev@vger.kernel.org; Frederic Weisbecker <frederic@k=
ernel.org>; Kolacinski, Karol <karol.kolacinski@intel.com>; Nguyen, Anthony=
 L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@in=
tel.com>; Keller, Jacob E <jacob.e.keller@intel.com>; Thomas Gleixner <tglx=
@linutronix.de>; Anna-Maria Behnsen <anna-maria@linutronix.de>; Olech, Mile=
na <milena.olech@intel.com>
> Subject: [Intel-wired-lan] [PATCH v12 iwl-next 7/7] ice: Implement PTP su=
pport for E830 devices
>
> From: Michal Michalik <michal.michalik@intel.com>
>
> Add specific functions and definitions for E830 devices to enable PTP sup=
port.
>
> E830 devices support direct write to GLTSYN_ registers without shadow reg=
isters and 64 bit read of PHC time.
>
> Enable PTM for E830 device, which is required for cross timestamp and and=
 dependency on PCIE_PTM for ICE_HWTS.
>
> Check X86_FEATURE_ART for E830 as it may not be present in the CPU.
>
> Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Co-developed-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> Co-developed-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Michal Michalik <michal.michalik@intel.com>
> Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> ---
> V11 -> V12: Fixed missing E830 case in ice_get_base_incval()
> V10 -> V11: Fixed adjustments not working on E830
> V9 -> V10: Removed ICE_FLAG_PTP_SUPPORTED check for E830, which was disab=
ling
>            PTP only for E830
> V7 -> V8: Moved E830 parts of other patches to this patch
> V6 -> V7: Fixed timestamp acquisition
> V4 -> V5: Edited return values
> V3 -> V4: Fixed kdoc for other ice_is_e***() and other _e830() functions =
in
>           ice_ptp_hw.c
> V2 -> V3: Fixed kdoc for ice_is_e***() and ice_ptp_init_phy_e830()
> V1 -> V2: Fixed compilation issue with GENMASK bits higher than 32
>
>  drivers/net/ethernet/intel/Kconfig            |   2 +-
>  .../net/ethernet/intel/ice/ice_hw_autogen.h   |  12 ++
>  drivers/net/ethernet/intel/ice/ice_main.c     |   9 +-
>  drivers/net/ethernet/intel/ice/ice_ptp.c      |  71 +++++++-
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 167 +++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |   8 +
>  6 files changed, 262 insertions(+), 7 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)

