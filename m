Return-Path: <netdev+bounces-157627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A11CBA0B0CE
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 09:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9CAB165338
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 08:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB7028377;
	Mon, 13 Jan 2025 08:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mAKZsq9F"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD98023DE
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 08:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736756237; cv=fail; b=mf4J3FW5m3OJw0q3b9ajvKCs+WtDeUKlgoY5064laQXk07DU4de2x9vOXbhJE3+xijhPDRxR3IKln7GMebVn6bUrEe/o3546qnklY2j8G+BkMqfWpmATinQw5h/m/ud1gAt6d2p3VA5NSEB/jtg0rx/KVmG/0jhl0fNL0ijY+7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736756237; c=relaxed/simple;
	bh=TJ3AFUMLsi+flgqopG3tVDptVh+bKfq1fh+gYCAMVAc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OVcyAMedJdOk2lU6JYuqvAUTkrNYypcbPonGA9PUlVqq7sNaV4SP0vNhV/9oqRFOYJt/yplrFieYUURjh/kF881KZJxdVc27ER+8YivFi3FSjmu5RW5FwLhJHgUOIoXE86xV55I3ah1Co0TW+5EZBqpZG/jkwbh34SHoiUInoTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mAKZsq9F; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736756236; x=1768292236;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TJ3AFUMLsi+flgqopG3tVDptVh+bKfq1fh+gYCAMVAc=;
  b=mAKZsq9FwiDw202j06eWy6q25BzvJ1W40V6Pu0sIMKJtA3Efx7Wt8+P2
   yTxYA3LHI5F5iSJIRFDmRQJE/oF8Wcg0+YAYlHREY6ND3TRp3Fc8nIX1l
   UqZUplY/S2fVRwFti1POd8cPG+JNbPYBtaiT/HnG7e+UrTTCd/RfWvCXc
   dfORfLirmTIcKfOx7WmuSlGjY+lAzitgOKxysNO2eGra2ImtT5vesLs37
   LgqDA3HS0KDP3pKqh2G1jk/a5Id3qKNo3MC4wpl3eTVDAm3khwCPmNXJN
   qcxIaiCuMzd/5otb1cbBBw6VQs96wxKsFZMa4dvjAZyjJSF3dVVFjiGKB
   g==;
X-CSE-ConnectionGUID: B05QpVphQaGRYuYJ5t3aoQ==
X-CSE-MsgGUID: 8Fw+BALoTDqvUiADetD4mg==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="37232555"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="37232555"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 00:17:15 -0800
X-CSE-ConnectionGUID: Ncgi72PtT6uYMWKXAOxlzQ==
X-CSE-MsgGUID: h9nxLPYmSV6XdT/7aQSDKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="109332327"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 00:17:14 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 00:17:13 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 00:17:13 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 00:17:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tp5lVq8HFJ22OhH2H8HBNQ384qicP3wHBqHkOO36t5EdlY8JeZ5O6hP59hwNbvfhLvBASrmy/SdfkEfqArmcZRyB7kb8quEEHxWrC+TAx26FPpsUmcr/GpWYR4PZwDKd6UNvPCl2tilgL50J/Qi5MpqZ7v0l40K/lSm+OsSSKAWkoXM5hz7EyGs00LUxCwKy9D5Bk47KLnLIj/Mq+llmd0WkmwIUBGmQu5FwIem8eFNRqAuW+qBFUqmcQOnVcoTOehgL4MkPzs2h1OYPCdSdcQ8P3Rp8Jh/xNbH0qqgp6FC2c7F6kjMjhOt/4amwFU3ReQMYIbPsmF7pJ9KmKYrxjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0lSJ/xmtAVajaSowYtYuq+xCQ0ORfvii9RFoFT+1xM=;
 b=NxyDAdAqRmL6BTQRcqGzeQq3/GF8i30eVaJwZruEQ7LYwgDqemiBtS2Juww8CvFvD88sLzMMROmCD+Nhuvx8r5HQK8wwiWd/x0qCuH5gRQSueTib6zNd++N6CuEfDxvTUAqJpcf8Tk1rHUNLpJ7aEIWnL5ADn7baMvXLlOnKrr+Ue8CWtioslaWz46q6gJCd3RX02TeBSJVcBvFn+lREeDcg2/Zxpbx2vHvQl8jpD/RLpvK0Ygj8iPR1+iaE9dw10WkUsMC32CEhdrbgXhPQybuEwA/PZvMnHSwKLAr+wCevmbSeq74jHGQtewlEEljez+h24GLCO2AbWigWUB5lGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by IA1PR11MB6219.namprd11.prod.outlook.com (2603:10b6:208:3e9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Mon, 13 Jan
 2025 08:17:11 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::1c54:1589:8882:d22b]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::1c54:1589:8882:d22b%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 08:17:11 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] ice: Fix switchdev slow-path in
 LAG
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] ice: Fix switchdev slow-path
 in LAG
Thread-Index: AQHbXUkpqrY+BZuBp0GpUp8gdKyMl7MUbHCA
Date: Mon, 13 Jan 2025 08:17:11 +0000
Message-ID: <PH0PR11MB50138B635F2E5CEB7075325D961F2@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20250102190751.7691-2-marcin.szycik@linux.intel.com>
In-Reply-To: <20250102190751.7691-2-marcin.szycik@linux.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|IA1PR11MB6219:EE_
x-ms-office365-filtering-correlation-id: 38dc63f1-5ceb-4087-0a6a-08dd33aaadeb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Cj1aPYiuhUVAeHz0mrpKqENpH3GqzCVGB3hpVOntFOWgLN8a2HBsTaytgqx4?=
 =?us-ascii?Q?eO4w+1JT3HfLYlyd9ZEZ9XkfMkA60BYO7nVjTLExPx+hwQEZdoJvcUIM3twz?=
 =?us-ascii?Q?+IzpcSoX8buuR4qSdCa/3xN48waifTPhHddHX8ogNFgQZvzBqJEVJXLJfg3Y?=
 =?us-ascii?Q?oknoodqDQfu9SvKseAc5d5iyF+gr6mE9qyAOSiFIYRVqVVlDoh/GnIMwJaJk?=
 =?us-ascii?Q?9HjYRPjqRlXXfRftOXpath8X3UBTEry8K5BeQAX/DA8i9wKUo6ebYvmlUMP/?=
 =?us-ascii?Q?5QjBmT4WXTKpsPv1HekUN0L2T2EsWLsfA5byiLeEoFoTH7MdUE1mgyh9JO5R?=
 =?us-ascii?Q?d+Av2qRyv3Bm6DhM2J3PSm9c/5NYF2+ywQONq2Hzxj/rWJ6yWIMWoxiPAP1N?=
 =?us-ascii?Q?EmzQFiEdwvGw0oHmfUzhgu2Fs3DCtupHA3t/PBDFHqFJueEc7hvzbvMVq7Ej?=
 =?us-ascii?Q?LWpjaiZt+3PfrwRbRDQHW8yL22y+KliETnPOHMt1rYbo7OarpkVhkoRtOPPM?=
 =?us-ascii?Q?QgpwDKX7+b+rRVi6pJEs32R3sEKd6am/N4tON+v8E50T3LPl2/NYCtlHZl/J?=
 =?us-ascii?Q?tN4UhOvak371bd4LfBNyRhMHzXMsT6q992Au1c7Bw7hjGTezazgAwf8cBxtt?=
 =?us-ascii?Q?zgT83g8SNm3DTrdV5FSynApI3u2YHRo0y0MvzKa0qD1hcAYf7rsgNTyTwrKR?=
 =?us-ascii?Q?i6y+yRHEC9NOoU5n3rdTEkUqoZ/d6UVsUAApOpjpNNBfHYac5U8xoO80pVC+?=
 =?us-ascii?Q?6EpmwMzE5v7jI4iwbpbyHmYCjABxNVzBpWR20lIbdR/NG1RutDBisWfG0liN?=
 =?us-ascii?Q?D5PHywzcq/V9wYXOuWlPi5IC30lxINQYIHOlfhHhp1fChQYDBZu1Xgy3gjQH?=
 =?us-ascii?Q?wQ0AJXZbyxoZ72U/lj9PRb0kFMIGZaBsVaepcImB8fh9kAfDOWuv/2Lfh982?=
 =?us-ascii?Q?PgJA3Zgn51ZgLZnrMdft+6QM+C+QKA7NNip+kVTo6mVT/0pZWzymCdOnDLA5?=
 =?us-ascii?Q?HLCcGri5u3qWGEhg0INy6LFwB2YUwAaPucZAWWcR47RZKq6O26W4bV67atbk?=
 =?us-ascii?Q?ALRRiQf/naE4k6b8obJE4m1p2zo4ojRzm6Ax4WRIZjVe7PcG2AvlTnTb6VOD?=
 =?us-ascii?Q?cOyvFeOaoVdeAdSPTRTf+EwaG7Dj6GDQY9Vp+LWWNupfvYfa0dn4+FrtGVYX?=
 =?us-ascii?Q?NCj4cGcnLK1z0pBX8VN1ATQeODNYsBURIXS2uit6hGZnJEbURkpNkhTu1+Aw?=
 =?us-ascii?Q?xRFiMRv9sIbXhEMmtFikzmDQpl/jeOwW9h1rBClKg+89mNTGSJGcXKY3c9qx?=
 =?us-ascii?Q?gomB1f8sRWKIULjIB6jQEqpGKq8n9qzuJxwftYj7icWgmOT5QnGvkw9r8jnF?=
 =?us-ascii?Q?b1SU01aOxHEfXpTpoFUJBjgY4gsENn5RGL813qRPT8twBij7W6dBGlOc0lv+?=
 =?us-ascii?Q?/5pZAbqb8k5DDnIM26NuT8Jft+/xEsmN?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UwIZtWozdKhrGjeNC4iLG0sOYocHnhX1g3daHQRF3PdD/xzUubNUfUmmRF/j?=
 =?us-ascii?Q?XyDjPwsSXod8nvt8ANTZEUHM6CYG+Ifp8lqqDczxQqD121wxoBFqDBtMlazu?=
 =?us-ascii?Q?u0nQdBG0PXRA9fz8GEPgHDp71o4wES0PcyMwgBnmtcrfXB5NJWU93foYYJ1v?=
 =?us-ascii?Q?fLOm6mgGtbt/BBo+tdfU+HDIe1qY6zi33QafxtQAp+rmtWH64gaadbvxYCrL?=
 =?us-ascii?Q?t9AgQx+tR06J+kNUtyE4hCH13aH4Xy9uuzX3OD0iAeomEN8/McBWqhwlT0xT?=
 =?us-ascii?Q?dVnp9Sdkw1rDBfa8YhYdCIgZPmhDKP+TRMUShluVlbPe7gXN1rlVB7XcHPNM?=
 =?us-ascii?Q?O/bKek1mpo53V/8K8+iN+b9uhVRe+h0dn/14HdfJkohkidMROCQVSgYu6vij?=
 =?us-ascii?Q?zJO4t+uzcVIz3c87+uVDA7lnwMNaNfp+1a1jDL+f8x4J2u/txPJAzZ1/gOJk?=
 =?us-ascii?Q?0lLK4MVNOcNxtsrk56AYUi/dMPMkZ/Trnx/sKpk3BlRWVA3BjHDQmF5qlC+K?=
 =?us-ascii?Q?O3hdEkrsPUSvn4kaaOcDlVxM6sa1oqp4CthsBqi8t8B4bOnIP7LFgsySSJnk?=
 =?us-ascii?Q?uw4Z0r3PEVJ0Ma9KDcBSb7txlonlj4XLFm7XQUi/Q5YwLftUTYpTGZZwiKPK?=
 =?us-ascii?Q?y9ge9km3HeFMyfWJzpteK9te4KzakSuJO9Ld64IHXH19yHt3w75nSl4YMPdb?=
 =?us-ascii?Q?f2jKVLTeTziVcxYvYR7BC/1kMu++nQWgPO8CCWMkJILtXUb3DdjIGTeTmLGx?=
 =?us-ascii?Q?z40SlhGjsYI+5xoIzsoIDOVD9jtEpjH4RkIsEGC058iLlBQyGnf2o3G/4Z3S?=
 =?us-ascii?Q?UXE3AWbeUS++kYLjaQf3OU+8epDAw5CKPMS1ebXreYWd79jnXjvzvAEwh5Tb?=
 =?us-ascii?Q?NSwowbGYyHwFLJ3DxNaoailZimm2KBPlTaxUJjPbsLaF3VAWPf+lNIvs42uR?=
 =?us-ascii?Q?SjZEpsdabVJgzQXVgUyWm/323tJBAZ2ERDvnWrPCINVxUtgTh+yLwq0HmyTP?=
 =?us-ascii?Q?S3YDLwNCSMW5VSRnHOLKolaY1IK8fFbgFA0L1tMFaq1U17cbnMZY1YIZiITM?=
 =?us-ascii?Q?/vP7+28MYph2JAU/Guqe+3xiB5dzw+HC91owW2Nck1zR6+Yys2jkRB3/9/7D?=
 =?us-ascii?Q?r01KBUT363cqgswpoMwqc67+/NxAdy2hoQZ+vgWJheNMQyaxupxe6O746/3c?=
 =?us-ascii?Q?KZlFSLl1xhkk458u9BlFqt+zceh+l5YfHAMgK1O8W9R1JCiUN5MoFXhlBXpp?=
 =?us-ascii?Q?I1MQ+C++6/4pnVOPNJ+gUofuepUR4Xj8bbGoh0r9NXBW5qD6Y5i5c8swqW+5?=
 =?us-ascii?Q?3CI/1ACWcdFyLo/+pIYhDlGUHWJM3IeuKx/UeRTy1qWHnBZAWFolP7yOjVq7?=
 =?us-ascii?Q?H0jDXOAS2bce4GW9qCImHqwvbuv9Xiqpb0VqkPvNhWkFRMjEda8mfFZEAWBl?=
 =?us-ascii?Q?3UbDK8nh+iufzzJy0srzZ9JBxoi9YIrgXyYQ5ZH27DJ65OLIcsohaDITNcpa?=
 =?us-ascii?Q?zvy+XN6dJZ59f72H9DK1J5xzgTIcoHOqcEZhlFMa9VTOqkr9kLSiIJMoTjjJ?=
 =?us-ascii?Q?Ys8ZlPSjvg7l7QJcCJL2yGIkeOoSnRpsc5rW4ERlPLEfsNdyeJGB4yMxepDQ?=
 =?us-ascii?Q?Ow=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5013.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38dc63f1-5ceb-4087-0a6a-08dd33aaadeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2025 08:17:11.1470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8IYjQ1gH0p7wBNyIo2tUTvGsKJ9O7IwDPV/gZqhQY5gssjLJGjsfQSdjb3X2udLRCbleA5mJ6sA17pmnUa+7kdUQ9R18qSkwsLOnPa2hFAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6219
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Marcin Szycik
> Sent: Friday, January 3, 2025 12:38 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Marcin Szycik <marcin.szycik@linux.intel.com>=
;
> Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net] ice: Fix switchdev slow-path i=
n LAG
>=20
> Ever since removing switchdev control VSI and using PF for port represent=
or
> Tx/Rx, switchdev slow-path has been working improperly after failover in =
SR-
> IOV LAG. LAG assumes that the first uplink to be added to the aggregate w=
ill
> own VFs and have switchdev configured. After failing-over to the other
> uplink, representors are still configured to Tx through the uplink they a=
re set
> up on, which fails because that uplink is now down.
>=20
> On failover, update all PRs on primary uplink to use the currently active
> uplink for Tx. Call netif_keep_dst(), as the secondary uplink might not b=
e in
> switchdev mode. Also make sure to call
> ice_eswitch_set_target_vsi() if uplink is in LAG.
>=20
> On the Rx path, representors are already working properly, because defaul=
t
> Tx from VFs is set to PF owning the eswitch. After failover the same PF i=
s
> receiving traffic from VFs, even though link is down.
>=20
> Fixes: defd52455aee ("ice: do Tx through PF netdev in slow-path")
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lag.c  | 27 +++++++++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_txrx.c |  4 +++-
>  2 files changed, 30 insertions(+), 1 deletion(-)
>=20
Hi,

Observing below call trace while creating VFs in Switchdev mode with this p=
atch in net-queue.

[  +0.000188] ice 0000:b1:00.0: Enabling 1 VFs with 17 vectors and 16 queue=
s per VF
[  +0.000062] list_add corruption. next->prev should be prev (ff1d7c830300c=
6f0), but was ff282828ff282828. (next=3Dff1d7c5367d61330).
[  +0.000015] ------------[ cut here ]------------
[  +0.000001] kernel BUG at lib/list_debug.c:29!
[  +0.000007] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[  +0.000004] CPU: 81 UID: 0 PID: 2758 Comm: bash Kdump: loaded Not tainted=
 6.13.0-rc3+ #1
[  +0.000003] Hardware name: Dell Inc. PowerEdge R750/06V45N, BIOS 1.3.8 08=
/31/2021
[  +0.000002] RIP: 0010:__list_add_valid_or_report+0x61/0xa0
[  +0.000008] Code: c7 c7 a8 97 b2 8f e8 7e e4 af ff 0f 0b 48 c7 c7 d0 97 b=
2 8f e8 70 e4 af ff 0f 0b 4c 89 c1 48 c7 c7 f8 97 b2 8f e8 5f e4 af ff <0f>=
 0b 48 89 d1 4c 89 c6 4c 89 ca 48 c7 c7 50 98 b2 8f e8 48 e4 af
[  +0.000002] RSP: 0018:ff5ebf3d22093d20 EFLAGS: 00010246
[  +0.000003] RAX: 0000000000000075 RBX: ff1d7c54143a1330 RCX: 000000000000=
0000
[  +0.000002] RDX: 0000000000000000 RSI: ff1d7c81f06a0bc0 RDI: ff1d7c81f06a=
0bc0
[  +0.000001] RBP: ff1d7c83030097d8 R08: 0000000000000000 R09: ff5ebf3d2209=
3bd8
[  +0.000002] R10: ff5ebf3d22093bd0 R11: ffffffff901debc8 R12: ff1d7c5367d6=
1330
[  +0.000001] R13: ff1d7c830300c6f0 R14: 0000000000000000 R15: 000000000000=
0000
[  +0.000002] FS:  00007fea5e4e4740(0000) GS:ff1d7c81f0680000(0000) knlGS:0=
000000000000000
[  +0.000002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000001] CR2: 0000562ef57c7608 CR3: 000000019037c002 CR4: 000000000077=
3ef0
[  +0.000002] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000000=
0000
[  +0.000001] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000000=
0400
[  +0.000001] PKRU: 55555554
[  +0.000002] Call Trace:
[  +0.000003]  <TASK>
[  +0.000002]  ? die+0x37/0x90
[  +0.000007]  ? do_trap+0xdd/0x100
[  +0.000004]  ? __list_add_valid_or_report+0x61/0xa0
[  +0.000003]  ? do_error_trap+0x65/0x80
[  +0.000002]  ? __list_add_valid_or_report+0x61/0xa0
[  +0.000003]  ? exc_invalid_op+0x52/0x70
[  +0.000005]  ? __list_add_valid_or_report+0x61/0xa0
[  +0.000002]  ? asm_exc_invalid_op+0x1a/0x20
[  +0.000007]  ? __list_add_valid_or_report+0x61/0xa0
[  +0.000005]  ice_mbx_init_vf_info+0x3c/0x60 [ice]
[  +0.000076]  ice_initialize_vf_entry+0x99/0xa0 [ice]

Regards,
Sujai B

