Return-Path: <netdev+bounces-112563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA936939F8B
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 13:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8F501C20D6F
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 11:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5B714A4DA;
	Tue, 23 Jul 2024 11:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y/JE3mov"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62EC1B960
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 11:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721733381; cv=fail; b=cDaM1KX9/hf4KELLAdBiMh5z1iU8Bse+nwoc1Y7OMIN/JYgqY6RXJhAMBNV3Sq0sfXa60R2zlQ0zUarEAonW1EYbjY3rAZnOuWGb2fVsvo0Jr+GjOEZA52rbgA55f+ypCFxfiGvX9w1w9s/VlMSMKzgo7pigOS08tHpVOfCU/gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721733381; c=relaxed/simple;
	bh=7/Dy0xmPGu9o0hIUhHrHzZjYwbRZRtOeqpoWS+LSvZs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bdD+4qlmTKgVkyqHywtxcfu2aDG/wfPkEQ6s2QyIBQPzv2bQM2pjOFyFbxo8F+uJn1QK4DvECjte+8WORMGNp2j8p+mJ5171Iy8j5MoF5sOhoCSjB7kgZIj9RLO/9noMKPvnLWwS5nOupjQHHf1xszN43fre4cVnOhzhIjCwoMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y/JE3mov; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721733380; x=1753269380;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7/Dy0xmPGu9o0hIUhHrHzZjYwbRZRtOeqpoWS+LSvZs=;
  b=Y/JE3movEY+aFg8T+bVQyxWKP/SfqjV/lCq9nwId5CjC5MlVwvsWEoYT
   d0rfQlYXp83y76W4IL/tq5aoCmFkb4nmhVc6zvpOBNZDcogHIzoE8FAFP
   HwckWe8/TYXPgi+ZpXQFw8ac6aDoDiroMnwEBnZYQhLwaBD57ot0r72/i
   0IhI3UwNITyqOMIqve3T9QZBQFmO4jCgJMt5EccaLwQx1VWs6rwrat2IY
   6j2KsysvgEaudLC5rSgJn9A+yxG0o9wv9JOLtyR+lklFwMCLqaywEJzjZ
   HDvq0D2vIM6LZVY6zH8Zb4dTivTwARiyegg2b3uPq8mQ2zoyxd9xHldCz
   A==;
X-CSE-ConnectionGUID: abrT4CApSDKAzw8Aomo92w==
X-CSE-MsgGUID: 6Qgz17dORhaU3IZ6aO3wkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="29940417"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="29940417"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 04:16:19 -0700
X-CSE-ConnectionGUID: gpUm5yL6Qde4FLJzamNWww==
X-CSE-MsgGUID: +LiYesQ4TJqDbqy3VZyOAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="83212375"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jul 2024 04:16:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 04:16:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 04:15:50 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 23 Jul 2024 04:15:50 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 23 Jul 2024 04:15:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4Dxluw1vL3IGMQGzzbLf5UgsWOBibT7SAV4bqDCYwGdcY4nOreEv9f1HwHiX4uZfytbLdSGHEqEHwzLowHArrDNDC//F96nn+IBc7nf82eCW7PjVw5JibO7x2hI8JzsfIfjpO63pz3qh4Ys531XD1hXLOKMiULx0eH4BcOQSDHqYNtlHHiwm7xOR4JvzQjhFHcJ+Uz+/LO0Pepoh7w/sU/OdBiZGDbcYnu2PNJzlpAI7KlUgZD/DsoVuM4MIPFbIYy3ex6gS/eR7JkVxoCTkcm5Z+5NIbWodtDm/fgfM3gJQHiUwAP4qB4W2+RBiuXNDkIvFnOcM/Fd7prUGe2x1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/Dy0xmPGu9o0hIUhHrHzZjYwbRZRtOeqpoWS+LSvZs=;
 b=ZIk1E6E89N17/hjMJS770vhbTpdKY1Yl/a96vgR/UCVAD8wdW1jhJSrOnT8MUunq+lvFv3PiSRu7LdznA856ivc6qIgYFxWFOoXLKeZCQgxGN06aYSYyc/UbGmMr5955Pw9vo3yJi06lSSz95NMFTnQE/P0NuFQ+ZyrhYXV+Rsc2ZlfyfQDyP4uH7iSHw3kaB7+2x2u03XYnW5huXbwuaLUp7cbwUERXn0H1rLT/VdZOlOmitZUwa4GSfEh2U4etcY/Yr7+po/q7O2xr8NfWE2YJfGjqOJkDHIXGMfYv8aPjtNpY5GQwZhSGkL42YBuy7LqKWGwoWoJSxJpHb8y0xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com (2603:10b6:a03:428::13)
 by DM6PR11MB4611.namprd11.prod.outlook.com (2603:10b6:5:2a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.15; Tue, 23 Jul
 2024 11:15:27 +0000
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5]) by SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5%5]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 11:15:27 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Simon Horman <horms@kernel.org>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>
CC: "shayd@nvidia.com" <shayd@nvidia.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "Polchlopek, Mateusz"
	<mateusz.polchlopek@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "jiri@nvidia.com" <jiri@nvidia.com>,
	"kalesh-anakkur.purayil@broadcom.com" <kalesh-anakkur.purayil@broadcom.com>,
	"Kubiak, Michal" <michal.kubiak@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"pio.raczynski@gmail.com" <pio.raczynski@gmail.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"Drewek, Wojciech" <wojciech.drewek@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [iwl-next v5 05/15] ice: allocate devlink for
 subfunction
Thread-Topic: [Intel-wired-lan] [iwl-next v5 05/15] ice: allocate devlink for
 subfunction
Thread-Index: AQHauAObzOR0cHeqn06eCXflv9EmxrHHIrIAgD1Qb/A=
Date: Tue, 23 Jul 2024 11:15:27 +0000
Message-ID: <SJ0PR11MB5865EE561C6E01A182BDE2A28FA92@SJ0PR11MB5865.namprd11.prod.outlook.com>
References: <20240606112503.1939759-1-michal.swiatkowski@linux.intel.com>
 <20240606112503.1939759-6-michal.swiatkowski@linux.intel.com>
 <20240614105526.GG8447@kernel.org>
In-Reply-To: <20240614105526.GG8447@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5865:EE_|DM6PR11MB4611:EE_
x-ms-office365-filtering-correlation-id: 4d3bd589-9474-4cbf-86dd-08dcab08c1ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?vFgp0KGDVdEvXnio3a1qp+4178fZBNxoFGnsn7CIlw/Nu/PbqlXcxZuCimCk?=
 =?us-ascii?Q?3M5T7w7MLko2Kw06+Oo8vWEbztSEphCiXyqoICbKfaSuSjrXu7fMilAfLfKb?=
 =?us-ascii?Q?v0m/5Hj1qhrYAAfchpzPMqcsKnb+1t9tWiOcSQBDM56zCHTNyIYQrT64Utgu?=
 =?us-ascii?Q?l8Vt8A0NRQcgrcS1gG8xMHFVWhEt5+DazM7PPKIdEUeo+nTTDi/nDJbiIDRy?=
 =?us-ascii?Q?YKl6U8mSAxg4lrTUe6TSSyRiHQeJ2z1W5PEeFd/QrgVGXwlJrVzZcIc0RCAr?=
 =?us-ascii?Q?E3TkV9pJJ8/UkvzCSASGXTsPH82KBEmHhAmbmitZd+NkLD8gkzYHJU4OBTwM?=
 =?us-ascii?Q?LkyO02lFWvxTlQow4e50uypaf34fclUV13McpXhDHLFsHhm7wdyHEFQQpRsb?=
 =?us-ascii?Q?hQVmG64/fAvXLeyyIEx1bqRePKeoLhlagiEF8IqfNEIpcDeTiSNXmmM1mSJ8?=
 =?us-ascii?Q?epMzeGFHy6NnYWyuTLNtSpnBsg1gqavq9gUVO+YODwXPET6jaemYf/5DzUIw?=
 =?us-ascii?Q?TFu5bux+6RyX0Hvk56jeQZ6YTAkjb6h8CtCxNLQ1s+knbnZsW96v+jULLoVx?=
 =?us-ascii?Q?SEFJZy/F7pQgBAeFV93Vyph/YGbxSpnBq7F2/ePbHD0sEN0VBc66sPv5Fm+z?=
 =?us-ascii?Q?5l4kcCLzPDezdvJXuIX5DE1/1rFGMkU/v5EEoYfqqjGP0vuLkJ0h/yc8agWO?=
 =?us-ascii?Q?8JcAawtnrnbL6vqexBQIoJsypGQDTB6KOcw5/7jpVSWfk08m9zsdlS4AC3sB?=
 =?us-ascii?Q?a4CJTt3WoM8bXXOa2rxIjx3U91mcdXgtmqAzIrftNDCtJAWffdKIJIPF4w33?=
 =?us-ascii?Q?fBymwjv8rgswGiChkyuE2dgF+pS4GK/oUt+9HnjLqVIiCxwwmL/l+IPGiJte?=
 =?us-ascii?Q?k5IM/u6Frr5bKR1xW1QSPuNohaSKKEidrwbaG3ldDvEzb3lpE4KaQ4wp8Eft?=
 =?us-ascii?Q?jVLiiGAMgOazUJi/d8TI2KiRHWlpVLawV2YTPCAZp9oMoAwuBgIEwfVmeV0W?=
 =?us-ascii?Q?nZ45ay3EhkpRQnYoBZRXALW3m+cFSlzdVfw7PA/uNMsEzSM+zPYShR5b4xBw?=
 =?us-ascii?Q?kwX5xKbXZWXRD2YvEyNymaRZ8CRqR3qSXfrKXWHLw2gHruPTwmbp5DeG79sT?=
 =?us-ascii?Q?6+RDCZggR/xeIVmwAXCwiUsKuSjdiwK3s5+m5B8Z/8p0Xk8nlQ7fpHGsj8jr?=
 =?us-ascii?Q?GdM0qmPwPq+a9FEao/WWYgmmotue47n8YF0zkpoE3LV5s4JZf+Mp+0FBW5Uq?=
 =?us-ascii?Q?bRFWAceCiYRAoaiHdnVvOjxkrSA7wVa76N9ojqpbKxhDub7Ay5pGbcwz9xn7?=
 =?us-ascii?Q?JJiIZ0PHmyB8VSYbjiLz5QhybYoN+Sp1krkRRTBKJG4FpUc0hWtqf/YupToJ?=
 =?us-ascii?Q?jK4j8KOHAdKaJXfkSCnWAR36j3bbVvxyp6mH0imB6GrskL6Sbg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6KXRnMRzTyYgWu9+49b+CsQcm+E0A8nTjrxF6PGMxmzZPLqW26OJqKV/p0jD?=
 =?us-ascii?Q?wh54Yn+L71wSa2iBoueVqmLvrlPfY5ldYwghn1wK14g/MjpSdgix0Swg46tk?=
 =?us-ascii?Q?UoHLk1SKkWPKU+02T0AJZD3Q7eULezgmW+CdnD0HSGp2L/QEbbgVFx/3+Krh?=
 =?us-ascii?Q?qhxo2QVnoqPReDP3hMNZ7l7+gvFHqvephnmp3V7M9T6sFwA73iSRjndKdUaj?=
 =?us-ascii?Q?h3ubA/CCbO/uEEwa1RjgbD303McNT7JO9e1RgRuLwn+Iu0m4DbacdQmRBYAR?=
 =?us-ascii?Q?QdbOnQYJ/Z0YiwJ5G78bqbvEp3moHuC3ulrYAhxN3OAqTC6PdBed0/s6qZQc?=
 =?us-ascii?Q?IJANArlCRsS3WYIN+va0eDc3e5UQ8FtLvFbo65IT2IJ26Ph6VO4utBxSJhZz?=
 =?us-ascii?Q?WmwYD28i/TIyvcv4dwpEv2xuoNkrxJCr3uCMD4SXSbQd0UzQf2vRgS3+Q7DP?=
 =?us-ascii?Q?GGbUAFj70k9v5pzfomntuL6EKj4kAmqv1f8iAE9KaJb/9InhRNyplJk+UUbh?=
 =?us-ascii?Q?eYJccsn8904zy3kog7RIjtGvbaiWTMceN5kZCkjNi0Edi0KX2cQxu6rgzaAH?=
 =?us-ascii?Q?OSznJfS27O2gdbH+n/B+id2vv/3LoK1A/UdxqA8ju4bhuAWaTTHVHamAkMhh?=
 =?us-ascii?Q?RJlGX+V75EH8Dt0pmGooGYTR1sYQAVR/vLjDIBHkZTlkrd9Xn4scD1nu45RR?=
 =?us-ascii?Q?+CRd8ql8MquM59PVHAEw2TpCx/wlLPKplc6qk9FRdcKqwpVCblgJkNWUV7dn?=
 =?us-ascii?Q?qpeIY+SkttUGHRVV1HOxjz8bM35knHogWJIzE+6NgYqPcyg1fNZxu2qI/bvB?=
 =?us-ascii?Q?dbtPVgKKIb06yZaY8XaEkbu3n4+G/QJLrfvlkAxbhgQC9Fzk7k26WU52T6Xz?=
 =?us-ascii?Q?Mp2pSME4Zh+lPJMCAvcQ0MsOeq2nY1KAznwbPWmJqH3a93v2KXOA6OampZKW?=
 =?us-ascii?Q?qBNi+mxjU1LTNpIORGQ3xOEzhWCceWJXy2lT/VpA67KBv8LM5yyLduqdyPhb?=
 =?us-ascii?Q?Yfrl/MwyKregpNOUhpyuMrsb/9OBrk3qxiVD0HuKxAhtCSBIf8UzVbzV65n6?=
 =?us-ascii?Q?vqGX8g0WSkxm4BT9Nvx2J6WaBm/2xImXeJMC8tWvDJhk3PJe23aOnnJ8doRM?=
 =?us-ascii?Q?nMlXhcUnFNBd+jQIQE5vgdeZeRMWuarAhXmQZQ7XnZ22DhIeiONCb8aN6vFq?=
 =?us-ascii?Q?1EDclpuzUSY+MFcPq4wDB2Dkp3NcygXtLz0Thj89di4aL/P6QqORWxdBeqyI?=
 =?us-ascii?Q?buyy9r1OJvXlyIz0MKsiYAx8OnffK/aazDix1D9LC445oonnFISqnNbuu6cH?=
 =?us-ascii?Q?28Eej+voi8UtCtj6Kfb5HsotVccK9VdbcbBtdZNRzv/Fv/OrqMPIVUHR6Nbn?=
 =?us-ascii?Q?OvU4S2B2Z493RtNOTH1yC8q3NXq48J7rz9yWZa5uOPXlSPcMPzxIkFcM54wK?=
 =?us-ascii?Q?h2rcQ6aN0LDWwEDUBts9/AakqqUmMdr4yzFfcMc3PTp/uxcO5u50KxmRd9C7?=
 =?us-ascii?Q?nBETqjBDYkcCF31xA7+wNy2Tm8r/KDMjDQ2QURXRDJ1CnBH7XVxb2L+x+ZLl?=
 =?us-ascii?Q?trpDQpNpef7vv4lFqsFTCuxb/9S/T/lq2RR696PGkUY1nG0mmH3h5DsfIsbf?=
 =?us-ascii?Q?0w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3bd589-9474-4cbf-86dd-08dcab08c1ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 11:15:27.6946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tjz3pwrurve+1rykoUd2KzhwxE0TDhSZqwgUiZUuG9Rxzu3I/cU1Vy5kPxF5NP9IZ46yv1SPPKx8siVpvaQJkICJhYxRxpzLPlxwGN0k17c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4611
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of S=
imon
> Horman
> Sent: Friday, June 14, 2024 12:55 PM
> To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Cc: shayd@nvidia.com; Fijalkowski, Maciej <maciej.fijalkowski@intel.com>;
> Polchlopek, Mateusz <mateusz.polchlopek@intel.com>; netdev@vger.kernel.or=
g;
> jiri@nvidia.com; kalesh-anakkur.purayil@broadcom.com; Kubiak, Michal
> <michal.kubiak@intel.com>; intel-wired-lan@lists.osuosl.org;
> pio.raczynski@gmail.com; Samudrala, Sridhar <sridhar.samudrala@intel.com>=
;
> Keller, Jacob E <jacob.e.keller@intel.com>; Drewek, Wojciech
> <wojciech.drewek@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>
> Subject: Re: [Intel-wired-lan] [iwl-next v5 05/15] ice: allocate devlink =
for
> subfunction
>=20
> On Thu, Jun 06, 2024 at 01:24:53PM +0200, Michal Swiatkowski wrote:
> > From: Piotr Raczynski <piotr.raczynski@intel.com>
> >
> > Make devlink allocation function generic to use it for PF and for SF.
> >
> > Add function for SF devlink port creation. It will be used in next
> > patch.
> >
> > Create header file for subfunction device. Define subfunction device
> > structure there as it is needed for devlink allocation and port
> > creation.
> >
> > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
> > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>=20
> Thanks Piotr,
>=20
> I believe this addresses Jiri's review of v4.
> And the minor nit below not withstanding, this looks good to me.
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>
>=20
> ...
>=20
> > diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> > b/drivers/net/ethernet/intel/ice/devlink/devlink.c
>=20
> ...
>=20


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



