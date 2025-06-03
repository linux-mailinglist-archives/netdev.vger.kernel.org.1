Return-Path: <netdev+bounces-194737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC67EACC302
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 11:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC74C3A38C7
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 09:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E6728151A;
	Tue,  3 Jun 2025 09:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VmnZLayt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD1E2BD04
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 09:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748942901; cv=fail; b=q+WnXZJmj3o9M/2XCRp/RDMMVA8J2ZFy3J7NH0NLiVZDubPRS54Bi2AY8tWDRzkUbfFdCzAG9lShX1NA9ewHj+PkoDuQcmUu5ZgRfMCJtJePFsvONRdKsL07yRZiS3Gwgen3kF5kBc+3QIVgsOW6Rf2eUNAitkMI/0ECLIFmtHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748942901; c=relaxed/simple;
	bh=MsAMR5pgU6OO7fpQ5Aln3KxvZCjWFWvogBankv4ZsJM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J39+sC39mEkBI+Z5CFoZSqYv4ruFMgDfCl5Q4aVoNXGL46imXrjfag3tEcke9cAum20i1GGvjmQ6FiM4xZhoX0xZFvna34msWAVPliiWE55YNoinctrk1Eldy1SINGuQGeEV7GIxTK2TCVHrSx0G7d5yR7AajYfMPwSq2Yn1WUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VmnZLayt; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748942900; x=1780478900;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MsAMR5pgU6OO7fpQ5Aln3KxvZCjWFWvogBankv4ZsJM=;
  b=VmnZLaytEaGm1WIRAK/k80jmalhWsQM00dM30NP5K+GQFZ+1gOKQrPBP
   wxZjTOYAnr45/ZcAGpTKnVNP1gRlSM2n4fjPCxWC4EGlorS49JSuRDtpQ
   hx/BfdxrB5TVakustva2sme5TAtVi2pnwx+eeBK/XZnaZdoF3HDEHFuLY
   pX508kLYYppktqs1spzesRDaoSEis0iIgrrwAGIoWxbOIyEl4p/kjThiN
   5pewoGBX8MNmseV69jIRZIioJQL3lr1aVEteQGhzvO82WoCoh6AbkaQyi
   PlYrbP234H3vCZQqGVd72+v/qhjybM71YJG7GMiBtiYy+1W2KZsqG5KnO
   w==;
X-CSE-ConnectionGUID: bBDQCbqwQV60mMBzyFbR6g==
X-CSE-MsgGUID: MuJIxA71Q3eFWh59UC7rHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="51075485"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="51075485"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 02:28:17 -0700
X-CSE-ConnectionGUID: 2GZtmVlQSNSHpVF+A1ebNA==
X-CSE-MsgGUID: kykF90uIQOy8BeCyHRCqHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="144775135"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 02:28:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 02:28:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 02:28:15 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.68)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 02:28:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iorIS0fPZ8jqWTAb8EkgtQ3tv17WAINBxDn95JkOg4PK54R9uVcb65CcgeuS82GG26Ae3PE0MIPIg/IxO2siuqkUJb9N1Q9+2yNiWVJz11Gqbvg0kNKbjKe92iCa6UkEL2CV1MouPoF53kYJ4FkhG4OtzzOH87tMtFAZQSJsONH1jgL48cemmiM45sRagbvYKrS4sFNJF/Rzlyjs0Vux87yC8JICFs+E5Q8kkv+Q7J5koDSzafjhlY4YrYE6O6C4d8FxnIVmuFNIYi1dKnpq3Q3JXqCfvpbp4YK3M0DMOqn+T2OizRy8p+pt/pabCdd30aEdSa/nb2pDO9tXAHMMoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=op5meIjk8tzaHKnWOadUpQt+4AOeACZvO4KW2L9FkUM=;
 b=wa6HBtsQeHzBz1Uml7zIweyOUggE0iofyUebEeYNZPwdgn3q7k1UULDNbaZRE0dBQqLKTt5EJFt/d4l4+zXNQMjd/5pqhgSbY49VoyWzNtfAXD239FgpXvsshR5sa1aDKV2ILlCmMO8jXWRTeyiR3oAYwhlWnQfNZWXyVi3xB06SY7pUYYKJUcyUL6MZw78d7r+uk96G8sDhS32wCZ8VpRd7yaISK++DzN7ena8nvw2HhfrWxJKz8lrLiZMUVt7BiIsyLDYXnB9BWQkPLYtRRAx3j7pg0FgoYsVDlLpgsFeaHt9ONsXxAxFdyjc1WbZWIUZFb1oL2tAYy7z/DXFWPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by BN9PR11MB5289.namprd11.prod.outlook.com (2603:10b6:408:136::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 09:28:13 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::4955:174:d3ce:10e6]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::4955:174:d3ce:10e6%6]) with mapi id 15.20.8769.022; Tue, 3 Jun 2025
 09:28:13 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Stanislav Fomichev
	<sdf@fomichev.me>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net 2/6] iavf: centralize watchdog
 requeueing itself
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net 2/6] iavf: centralize watchdog
 requeueing itself
Thread-Index: AQHbpUyOY8nHgAu+zU+rCoHwyKomWbPxiPuQ
Date: Tue, 3 Jun 2025 09:28:13 +0000
Message-ID: <IA3PR11MB8985A5BECEEDE55C00FB2C758F6DA@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20250404102321.25846-1-przemyslaw.kitszel@intel.com>
 <20250404102321.25846-3-przemyslaw.kitszel@intel.com>
In-Reply-To: <20250404102321.25846-3-przemyslaw.kitszel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|BN9PR11MB5289:EE_
x-ms-office365-filtering-correlation-id: a7611ac4-7853-472d-ccfb-08dda280f6ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?juiPGrL9MYEkjJc1Tn/VQ6m+wBb71JUoInlmRjlTz27qYMheofIdEnyZ0+dH?=
 =?us-ascii?Q?ssDl9ATLObiEIygQcpiJ3SZ3ue34kOVcrfPiVhnYJhJ42uOd1z65/afQIEwY?=
 =?us-ascii?Q?STji9SkU6pKyEd14S73m9MkjckIv7TskhFfWyXx7roRStvlx8ZMkus49yRNj?=
 =?us-ascii?Q?WSLDWBnO7yX76paGHWE3SaK+z7NXEceGhsHrLz5x/sZxzj8IRZlC7LliaED5?=
 =?us-ascii?Q?j/Ro5um9h5ORKf8UyDpwdphzIYcShu6Q4oa7Ok+ph7twslswALgxje7u4v0V?=
 =?us-ascii?Q?cCXyJ1FNBDj5BqTFai23nOa95GXomY+NLnD+uwdghtmua0FcbG4Eoe6BBH8B?=
 =?us-ascii?Q?mQ4M9bkSWRc8M50yFDGUFWvUHr6rCj6P7J7fZVlz5XKtF1ksImNGOzhMws/u?=
 =?us-ascii?Q?+IXr8J9cVeXZMLJ56X0zLoEBDf1m9T9EP3/bLSKZ5KuptbLl1ICImZmsB2OE?=
 =?us-ascii?Q?I9Ro//JMxfxaWt53UjMphBRcWpFaIa9gG85SFph5r3ylw1GWJkSOx0rdXeb6?=
 =?us-ascii?Q?mORGLCSJagXCV/f+HQSIKrOOKtr9wV/lXnguM03nT2F/Q9U13pBDo/Fu6sFb?=
 =?us-ascii?Q?d6/KRSdvl0INAQca9C3Arnw7znDMAf3ivvXMyt+MzGWxiJ34gPhmtTKGOext?=
 =?us-ascii?Q?oxNZBzI0WIH7W23R96JjOoeeid+KiUZuKcf6HXXmWME1uqC4RtP2MRq7kz9b?=
 =?us-ascii?Q?dzG1Y0lTLScIl3sCkLH7Pc7RkligJZ6CQdtCmnM4cMuVEinNzlemtn0fj6tD?=
 =?us-ascii?Q?wwknTd6hFpo98axuBa3uKFJBd89nu/szm1EV3wha4X6xpppqixpRSHVgifD6?=
 =?us-ascii?Q?Y2/HJB9uxP2upkVRyujQuMMK7zso7Bu3jpP6PzmOFCHQDXvThnfkimO+MAB2?=
 =?us-ascii?Q?yY6hQaeEhM+2hHrQO4DVeSPvXbja/DWECj1ArWSi90nCzmqc78p8PQKVIjI3?=
 =?us-ascii?Q?aJ2k/DYyQ6ZVWutgVYtv8uIlSpWdgjYJ1PoZoRLZRIIn2PkUXez0J07kej6b?=
 =?us-ascii?Q?9hNbBEQ/NTYGAABf4oMWAnW3yp8u/Gq592T0X8BAG/N17u+sVMsZRfCO7cO8?=
 =?us-ascii?Q?LqqTYNNrZZPV7Q7ZDba6F7hOlI2cTmJwZ9WkeW4q1198svWFbHBh4AbrOQNA?=
 =?us-ascii?Q?Mf9wMYItgZ51SLQkB3huRZS7CfiKTxuNkfX83SJMIGcBU/bS9Uc6a3WFcRNO?=
 =?us-ascii?Q?n6bQa9o8tww2VHDCqVaLzPXCGywiRj7hroOrHnvG9jul7RzvvkJ2NUe0p1Hh?=
 =?us-ascii?Q?HwjWRdPY9MQj6AD6fk+1GfAYPuBFdO7VhT7T0N+Fp+hqeErqYy+gMuNgGZQn?=
 =?us-ascii?Q?St22Brob4gpR6yw9R9EgZBvufgF7byocWHK9ueOuxgwbF150N4sl7GCnt2sQ?=
 =?us-ascii?Q?UN4qcFYINHKkJQPLNhtdRIoNhEmzPOek4heXzaMgTFEapi07nAWvQtqorPza?=
 =?us-ascii?Q?y6/k+t8Iuc5GX5uszEMRJHK052ZDFs51ewrG+5Ds+twKqhN/PtqJQjzOMoAp?=
 =?us-ascii?Q?6M0X3nA/8oi+ZVo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y1S4qWLqqgXgG+dUbhN9PtUk4Wyd55YkutUP2oF+TMtw7Po+qxH22rLnZYRQ?=
 =?us-ascii?Q?ZHfq6k0YRmv4K/l2mQ0wl5wyMZs6emFizCmQRSzDeBxQm7bxRi7qucis0mRo?=
 =?us-ascii?Q?cXCyDyn2ODHIFlL374Ns+yN1Wd4i4eKgCpwiXz3ZsodJLvQmX6i9ugl1o+gh?=
 =?us-ascii?Q?MJp/jYAI40bZD65KxZgvs4diGriQqLrp6ZgfQkOWowfS2GUIt9OIgJAyMBA3?=
 =?us-ascii?Q?dV/hkwzOgTIHfgJccsTB0S1MN/No49jSbMuPPj0igT/1n+HTzYsv+DCaf2bt?=
 =?us-ascii?Q?AwaSQqYakRN2ZO8vCGlBF6K0IjN+lf+nvSi7ow5ro77XIPKBUN0uAqug6aA0?=
 =?us-ascii?Q?7Jhis+zTXHnUbp/CQ6KTNnyocdRaSYUvECuy69kk/Iq+hH2PB98A9mSy42rC?=
 =?us-ascii?Q?g+u6988JNXCQIvUKl6+b6fwVx1SdRkNN6JYZLEtpaTObfBx3EEIR9IuEk8MD?=
 =?us-ascii?Q?dAOjd/3BQcMozpfpHSkPAvATYgFZU7Ib3Kfsz1vOc3YcSdReQwgPiZZwEv/t?=
 =?us-ascii?Q?unpqkfbb4Asvfyo9PCVPMLv7tuGkc/nCOBKn6B2higfzHlcAXl3ssa9wUZ7Q?=
 =?us-ascii?Q?2MJDIs6GEr6rrDxmZ1vNRcgBaO4F1cxLqbqqzBFzL7kQGE57bYwyCEKtYY2N?=
 =?us-ascii?Q?SRwM4TAoaf6nhKrqPQaMThthDvODqyIdsJAwOT8ptHxYwxVclTGb6Kn5ZmWS?=
 =?us-ascii?Q?CvlHPP2Xjm+3JLtaMHk+Rqyr5Ir6ZQihl26xN8IqS6B2KfAaAII+PMvJRIDh?=
 =?us-ascii?Q?iU6G4Uf3QjPqbmDiMOphNJ+Tei+4YSYspS+GsawuOEI7w2GZHpH/UNP8DjOO?=
 =?us-ascii?Q?RQzQ819BleeLFQT8CX9HGq8RRW7UIZpas6SgJzbRo9Q8CA5ndycZ+CZCoYM5?=
 =?us-ascii?Q?ioKpfKUtSORGpKj4T5PemI3hAbXaKnR5Q/FNWOEc657XwE28c7OfpwxEuZcs?=
 =?us-ascii?Q?9LExnuGp186Dn5ZM0a6tiHLxm95CCtyogwhrYVOc85iYnVjJMEC7gX2KnSSM?=
 =?us-ascii?Q?j/mOwjZsOOVErJ4BdLunUdBns8TRFl/4oOZBaD3wAPsFhQb45/D2CRwFeong?=
 =?us-ascii?Q?8DiOzqrmyAmB2eQbjVLK90+gtB+glCiskbtbYIWN27SHfsPPN5xPWyjTilIK?=
 =?us-ascii?Q?fZKJV+dkIUfCCs6ImP2cX1tqrbwROmUfBrRMVcv+NGnogU2tEclclZirv8V2?=
 =?us-ascii?Q?TCx4lvKfj+Erdk71JNuDv8X+k8HkOgHh256bcTEPkVFajXXAkz0a6tw5sVRy?=
 =?us-ascii?Q?d5XV08gNDut48rSxCjwfy+8o7RISx2ja8P6oTLq/0JanLGgnaM5n9GNpruA6?=
 =?us-ascii?Q?dLcIo3LwGaKoYLcUxZz3o12lvN/uFDhdETiG5ruJ2HLOfYmiUxq+JZbc2Q7z?=
 =?us-ascii?Q?udEQ105oKOjtQ9IUO/AEowrkQvcXE8/rel1QCpL1Wk0GTtYsBZjtNkEJ+2aK?=
 =?us-ascii?Q?bJnwmAnKQ7tRN1fJ30r2/eCjH0vGXztMtPhQTAzTvE0VSyn7SidYii7QFYUH?=
 =?us-ascii?Q?t2ro/rKw827YxKRXkL/Go3mZmercPZffZtrkXMp0H1bqDOzhpASKe6zshkmO?=
 =?us-ascii?Q?yFUIzm28byd8ufG8iKocS+sXULL/uUY2TyhqhUh+O9IP01rSKE/PhKa72QIy?=
 =?us-ascii?Q?4w=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a7611ac4-7853-472d-ccfb-08dda280f6ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 09:28:13.8555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7qGtrXPlTF/x3Njsqnm/vXPhTF+Ipzf1teYpyL+aks2/EO+lT8dfhXac41SwylLvDX1s7oh09TZlqruVYNZIQwdUDs05CtMsVIx5JNl1rGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5289
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Przemek Kitszel
> Sent: Friday, April 4, 2025 12:23 PM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>
> Cc: netdev@vger.kernel.org; Stanislav Fomichev <sdf@fomichev.me>; Kitszel=
,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net 2/6] iavf: centralize watchdog
> requeueing itself
>=20
> Centralize the unlock(critlock); unlock(netdev);
> queue_delayed_work(watchog_task); pattern to one place.
>=20
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 103 ++++++++------------
>  1 file changed, 41 insertions(+), 62 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index a77c72643528..2c6e033c7341 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -2911,6 +2911,8 @@ static void iavf_init_config_adapter(struct


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



