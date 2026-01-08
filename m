Return-Path: <netdev+bounces-247981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 54841D01659
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 08:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 217D03015E03
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 07:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B242FFDE2;
	Thu,  8 Jan 2026 07:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="grNid9fI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144BE279DCA
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 07:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767857370; cv=fail; b=k0aPQgPBLhmBpU5agKxs81bFAB6Olm7fzsLME3ASgSBQ6pyvX5di9tdQvw8Svljg3XMsp0nYlEse9HR692lTLwaAF1WVDyjEovpsNWjbwasJnLQsFERN3C7btgL0q1Ar7YXo0ts3ej4+TAFbsZ/NVZM6EvV/xYR4QlvyQx5wQ4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767857370; c=relaxed/simple;
	bh=jhjHkLD6zTRuyVHpjRGNOBPjEFwrAWMF95lo9CJ5oIQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Db4ruOuEDaGWM6MHwtzEMN14iNANKSzPESmRNSm5E3+Wusaq/tczbyKSGQDqLspkh7NSOECssAnXsUM8D5TD7pNrsqfnFCdzH4wU1pi09w6jiX7bDonZAjtmrLuT6hzKTHx9jg2QP+eqcZLnVe7QPAkTSBOzE8JEz3f09pkksuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=grNid9fI; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767857369; x=1799393369;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jhjHkLD6zTRuyVHpjRGNOBPjEFwrAWMF95lo9CJ5oIQ=;
  b=grNid9fI4Xy66vhcu59EuR6X+0tLtPMwp3iFvRLh/LtSCtlITNoHiQnS
   iTaeLmcD5Tws6ppcNE8INgmPhZmUPFhEbYpgTBM8XAFRTR8JBaU2wY4AF
   u3TpVKxHnIp9pvGywlmwDcz6entpn5cSdlLbqM/Vvr3IMpssacqf9naLt
   y2ac/WMxAU4A8PwCMiRM3rN33fXbNrseCM30c5CvwxDJaTQNz9hysG/fN
   yjDh/tgy2IrY8CorD85PugoweVG9BbiZFGf3gB9IH5Ms0AgpPXxuNI3FR
   RXJRFPWAjKG7ln7IhuxmAtN66E/qtSW6nrBEG5b2b2iGtnude6rOaXO7y
   w==;
X-CSE-ConnectionGUID: NTqmXz6BRuC/OgAblvZwaw==
X-CSE-MsgGUID: dP/m8BBuSyaGupZe5vJ0/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="69391321"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="69391321"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 23:29:29 -0800
X-CSE-ConnectionGUID: lz6PO3y9SPKNm5oOjsYlbw==
X-CSE-MsgGUID: R23WJj+HRse7BW4UZCTsOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="202256518"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 23:29:29 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 7 Jan 2026 23:29:28 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 7 Jan 2026 23:29:28 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.2) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 7 Jan 2026 23:29:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwoXqOfTADxIlt5oz7fNQxfjD5nrd83Z3kGYEXDEcliogycwHbTHNdTxiHttMXQgHq1j80/H4t4wkIej2F4hw2FKJmVQhgeqU82SK1UwFgP7YOmR9dRqFPXcNBkReBT4iV1jB9QatxM4zGsr6HdMoB9lsz7mLxgyyu3kizjaX0ZUdJorpWCQgdWBkQw+XF4IXi9+R3J3Z7/m+poqGpbvvdUgcYgJVd9C5dCfHdPBycr62KBLSJNRidjw80yQdwxv5uVbiSFPMkY1OABixHcQyVOVYNHR9TUuq3Ivx5ctfkLkVrAeJsoRSQjSzemA2FcwPAsUlomclDMbs9mpOUvIig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNmFNynllu0ngXOfrCA3i1yH//LTxQgipgwCbh6qkz4=;
 b=vuotnRz8LmT+ClA3bOniFVC/3m6zYG0xKw7g/23V484bp0bcPM4AkhVjUJqmMV5IcTylTwyZ9jZLY6qrw0+HjZImxC25I7B12sdgd270Y+cX9612sbHf8H/g1OQIrSN3B0yQpS2TNFHewlVLDXPLTcWZ0ApIxTvsL8pGrTykP585KtZNWf4ULsk5dvTJDOfIZ3XNqQZVAtOGCJzjdHoqL2Cblt8JvaY0N1isr+5iNwgkk89W9rNcR7RLxIF0s/jxRKlj3hSU4YJag42ypqL9+TV52R1PIiGqYdEII7wySwT5pvctURKKJLOBD6eT0IQ6hwWJOfS9QUXAB7kFD5unxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by IA4PR11MB9417.namprd11.prod.outlook.com (2603:10b6:208:569::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 07:29:20 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 07:29:20 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Takashi Kozu <takkozu@amazon.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Kohei Enju
	<enjuk@amazon.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 3/3] igb: allow configuring
 RSS key via ethtool set_rxfh
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 3/3] igb: allow configuring
 RSS key via ethtool set_rxfh
Thread-Index: AQHcgF7gmLGugxsz7Um8qgZKBPTLwLVH29MA
Date: Thu, 8 Jan 2026 07:29:19 +0000
Message-ID: <IA3PR11MB8986D6E9C30B7FFBCEF64394E585A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260108052020.84218-5-takkozu@amazon.com>
 <20260108052020.84218-8-takkozu@amazon.com>
In-Reply-To: <20260108052020.84218-8-takkozu@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|IA4PR11MB9417:EE_
x-ms-office365-filtering-correlation-id: 1654be9d-b247-41a3-773f-08de4e87a33c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?4kZxzaXhKL8NdhX0Yqj/Ti6/hh83Nk/s9VUu7NnNpHNbt8XZ4Bpx9dmGR6tE?=
 =?us-ascii?Q?/5qExuB7CYD4SaPD0ju9zPtfCThiPmkCK0B8AhjU5N2yg0Udvka0BkSCxpcE?=
 =?us-ascii?Q?fiyRDFb4o/Id2599vj2d7o1oAsIjcFbgOXZUEB5Yxi7LOpQXIM+2CMrAge5x?=
 =?us-ascii?Q?+L8Qn7JQi6O4u5ACeYfuSqA8vUSMggLP5xWbf3SianwvK5uuK3kXz3vTCc6J?=
 =?us-ascii?Q?HbqHCYIOE3eqPLipn4AQ+M8IdL85KTmc3yr8R9xc+HnGb1+hHg8Kkp3XiNxP?=
 =?us-ascii?Q?Ryzq53lREr8rtzqyPAdw0cQogxjQiL+SeahOU6ErulE1qNVAS+VYnlpNyija?=
 =?us-ascii?Q?/FOAwq9d5Ctztq0kwiFXyXZTVodwri+o88JTgvx6CPXXzYNraoF0BrvZKkEI?=
 =?us-ascii?Q?vZP4EvSYunimphQxF0/eDPNcPcQH4X8KIMURPk3rp/F5YUXKn5gCGqBr8vHx?=
 =?us-ascii?Q?2GIzrD88ipDwu4ZGOLD5ptab1VFGSJpo7cSnnJvomkhwW1cwzs2kDuJC7xAD?=
 =?us-ascii?Q?hz2RosSzyT8EMLjbOGV305kfiZiB5EkZkJ42dTjBpuLSNr3YDvF686wCuJfi?=
 =?us-ascii?Q?FgGlU08o/XwwXMvdJSuDVEhcsWcJewBsYncfxqZhvUi8JMZy51H0Yd918qUW?=
 =?us-ascii?Q?N1M7Qb6+gUAiJfdqbqR2qO1pYIdXeFBfVatdkqVIJBnceUMQyQv4YjoVFJKh?=
 =?us-ascii?Q?RjaGw1HzK5wIU0+gmDpZ6PM/XO6IUNnCHbpNnChHOYOkrQ5Gby3yUoCNmVR2?=
 =?us-ascii?Q?Z4k5rvsDDjWHwFdzVvHK+m4GJbrueZ/bqLRMQflHuyFRWAKbqSEx/cBgRwug?=
 =?us-ascii?Q?V9Cnb+VzRU+ve4wk79Tq9ieYybtWaxj2smVIHu/5woed4G/If/akoB+EXJyc?=
 =?us-ascii?Q?qpgkqEMSqGcVzNrX54oui2ha8oTdHyOX6XaO5nOQQ2NqiyPsU9UgNhTsNT5O?=
 =?us-ascii?Q?IQzedR/Lqtx8OvCzy6twzYPysgqFtYFIw6heHFamOG+pHiYAQk8O7FVzDInA?=
 =?us-ascii?Q?5aFsa+6yf1jnYg6L1dJ7YjVWRfaHLaQ7Yf0uadqjj8NY+PbzZzI3cJOO72Gh?=
 =?us-ascii?Q?Zi0nFMvKgxHPCiLcyoFs3JcyvQoTs65kBkw9oPQFTFA9r9WyY36FruVqy+zo?=
 =?us-ascii?Q?dcq1T5Fe1UpZMB/RXU1QTZZmSJMgvvPI1AB6LfetOmCVgnpSV1seRhTqfQ5D?=
 =?us-ascii?Q?124JhN6/urgTlq9KE4H1dkQoFA+T7U1/nvCuovP9MLJKAoCx3MS+CBkv2kd4?=
 =?us-ascii?Q?TRYpcjAcO8Vy9M7jZM43M32eKzAkMkGpjjuhyhUnzfPyBHkFlBKh4zdSjfOg?=
 =?us-ascii?Q?tlSeiS6sBH9dafbOkXLZXVyNiPV4pRJhBZ67TU4ojt5itOXljenCskKsm4CW?=
 =?us-ascii?Q?FDQqXscKuKVd1qkgbOtILqsbVqkX7kFHOZ5FSf2u0KAl3pv5QwYBMJLd/9RT?=
 =?us-ascii?Q?/2h4erdD0Ca2EN/xfsC3gBQzrVVT5576DK/Vn9jAc7sqWJs/tRanOFa/pTtV?=
 =?us-ascii?Q?VrPe239728ddh+q1Vz6g0hhMpq04iRGHxIgL?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z2qL9UMmDQPq2qYveUE7O9lR9tnXG1azml2bDGuV18AyH8Ao9Jp+8VkKBVll?=
 =?us-ascii?Q?C/dKrCuOJPD5ZrYzvp/jUyPwA9GnVeUEnM9NzePjVpUoLbEr1ravZ/F4MlIw?=
 =?us-ascii?Q?r5Cqhrbk/5morSukhPbZhMoHUB9wzoOFXouTPbefxqv8ODY7Gk2IvAiiJpBR?=
 =?us-ascii?Q?4yT96HjuG3uhUenl0BAGLpFOd2ajZU9kAZL0w67QZ1psgWJOoxlVp7pD5y+3?=
 =?us-ascii?Q?P3NXcFH1Snau1ubD0IpwjT8BJtGZHMXU4hqZPv8vt4cT6Maj4iU9ueE+u2kc?=
 =?us-ascii?Q?/aIu1yWxmDtDkIOE47EpcjPnt+1b/nwcxl2rS8l0XQcQHIYdrqa45rDzw/b3?=
 =?us-ascii?Q?9nShh1mgRDafUoodzs+rKF5gzqVFB2R75FtvNx11MML+BekuMHuqQnd408Zg?=
 =?us-ascii?Q?iHe1t1I4RlapAQp3QqMV9h1YoEAJLaLMhH8ROQPpiWNW8TMRY7EBS6UDHoB+?=
 =?us-ascii?Q?TMUO02UsBlfTR2dIoUelYnQW7zEEbZVm2suqfjdIEyPtKZQF0TjnOJ2AC5/H?=
 =?us-ascii?Q?kh7XxXIL2jMJw5p7a0ZWrhNiu+KRTYmwH4Jv2aHoNsJPq6hrDmcpnUP6u0eK?=
 =?us-ascii?Q?SlBMdC+MPeP3GBB1dikcoRJiMYxrsRf+wrhxsYfQbfabiYSICKIKe5xTeGa/?=
 =?us-ascii?Q?jO/RTJ0EveMHEpezpCGwd8979KMqic6sCo+KNrg5XcuYkiNAypbhsPv/EfQ5?=
 =?us-ascii?Q?SWKbVKTYKLkooDa6j0TF5EmHlGd/f3FgYUdO4Dgs27/dU41xZPYG1OA+TzQC?=
 =?us-ascii?Q?2/flBAMBCEa4wYcdT7FKJF/MjddTzbvyKoT0TtJOelR53TMxDG5XdZDQGDiq?=
 =?us-ascii?Q?8RDTYSnG/FTN7yE0WpJwkZgl8tZl7wexyF7PBFQFQDB0HLws8AEefEdHsQBU?=
 =?us-ascii?Q?qGKuBOn71yuf4nfn8OO9KHg9d5tyjoJNHyWfsmndtONIn/GhQhRl1E7SF/f1?=
 =?us-ascii?Q?uXfFLUug23cP4oo5Ds7yfqw8Wb+hM6U2Mz6keNKgkST3nMEvaXJEieTwDcjm?=
 =?us-ascii?Q?TL2SWtEQwARuFYc1eikVlNHJLT+ViBDy+YMxdVy8FTk+2A8RslDTDt4PbnZf?=
 =?us-ascii?Q?fICm22iOicLu/o4fTmisN7TomCK2vJOaLAnCN+5jXJkQfpAE3y1jMoojW/5n?=
 =?us-ascii?Q?cNlS4+AA4POLBkEPbZuP7MRAXASDkeOHKpcy+PS00QNGD8HZRREdDivUMFo5?=
 =?us-ascii?Q?LlpaDH+Khd2Khm9Xfe3HQi8XEFxYnaCzqYMMgfjUx3wfDYfZVN0GOJmQZyAg?=
 =?us-ascii?Q?tKdaU4LzIkMRGvsYogna0rAjs469sd6g4bCHEdbPvFxM0jQWc7uI4wnXqbpw?=
 =?us-ascii?Q?bFecnil3m67JfZ9DKoVZA8eVIEMPSZP+hzv/fRQMwL7R+0Ro6wy3kRfkeHDV?=
 =?us-ascii?Q?yjJYOFqKxyGB5Zj20mqNOwa5W/Ieag0LmIjDJMV7phPEnDwFheaBHk8kdxFr?=
 =?us-ascii?Q?Q2Te/pWDbKJ0rvZJlKN0qTfKY9URiqzjDuQ5wWJbbe0AmaMCBbBmBnVMg0ED?=
 =?us-ascii?Q?aK9TUVw089sv7r+glhGud8XtXx/VBTWl8K477LSddKf5F2fvuSWGpsCbkXBT?=
 =?us-ascii?Q?m+zTxrvU3DNszH5t7+aoFa7s9d4Ab1IZVkOfhcHUwGRs3kCYyyJs9yZ1NOwb?=
 =?us-ascii?Q?wHvkuMX26L7QCLXzs395gU3XP18zdNzBCbRIZy9XWi02RzhZSOOreR8pY/Rd?=
 =?us-ascii?Q?waWtjCO5vMtV6eIgT8ntpU64ZboqzsW3LuTrg1xz1U20igttILl5xnKYiDiO?=
 =?us-ascii?Q?GrUn5Swak5KCHfiN5C/x4odQkixtrsA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1654be9d-b247-41a3-773f-08de4e87a33c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 07:29:19.9121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mIRvxG7waNYLWthEBh19yekMt8nc+SGbv3Laj/pMUTQd5sIZNNe3AJtrFaUUgND9wE3t7SBbkgmoxi4s58Rfqv2rgKIMA6aGSH967pU2S8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9417
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Takashi Kozu
> Sent: Thursday, January 8, 2026 6:20 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> Cc: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>;
> andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org; Takashi Kozu <takkozu@amazon.com>; Kohei Enju
> <enjuk@amazon.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 3/3] igb: allow
> configuring RSS key via ethtool set_rxfh
>=20
> Change igb_set_rxfh() to accept and save a userspace-provided RSS key.
> When a key is provided, store it in the adapter and write the
> E1000 registers accordingly.
>=20
> This can be tested using `ethtool -X <dev> hkey <key>`.
>=20
> Tested-by: Kohei Enju <enjuk@amazon.com>
> Signed-off-by: Takashi Kozu <takkozu@amazon.com>
> ---
>  drivers/net/ethernet/intel/igb/igb.h         |  1 +
>  drivers/net/ethernet/intel/igb/igb_ethtool.c | 49 +++++++++++--------
> -
>  drivers/net/ethernet/intel/igb/igb_main.c    |  3 +-
>  3 files changed, 30 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/igb/igb.h
> b/drivers/net/ethernet/intel/igb/igb.h
> index 8c9b02058cec..2509ec30acf3 100644
> --- a/drivers/net/ethernet/intel/igb/igb.h
> +++ b/drivers/net/ethernet/intel/igb/igb.h
> @@ -657,6 +657,7 @@ struct igb_adapter {
>  	u32 rss_indir_tbl_init;
>  	u8 rss_indir_tbl[IGB_RETA_SIZE];
>  	u8 rss_key[IGB_RSS_KEY_SIZE];
> +	bool has_user_rss_key;
>=20
>  	unsigned long link_check_timeout;
>  	int copper_tries;
> diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c
> b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> index 2953d079ebae..ac045fbebade 100644
> --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
> +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> @@ -3345,35 +3345,40 @@ static int igb_set_rxfh(struct net_device
> *netdev,
>  	u32 num_queues;
>=20
>  	/* We do not allow change in unsupported parameters */
> -	if (rxfh->key ||
> -	    (rxfh->hfunc !=3D ETH_RSS_HASH_NO_CHANGE &&
> -	     rxfh->hfunc !=3D ETH_RSS_HASH_TOP))
> +	if (rxfh->hfunc !=3D ETH_RSS_HASH_NO_CHANGE &&
> +	    rxfh->hfunc !=3D ETH_RSS_HASH_TOP)
>  		return -EOPNOTSUPP;
> -	if (!rxfh->indir)
> -		return 0;
>=20
> -	num_queues =3D adapter->rss_queues;
> +	if (rxfh->indir) {
> +		num_queues =3D adapter->rss_queues;
>=20
> -	switch (hw->mac.type) {
> -	case e1000_82576:
> -		/* 82576 supports 2 RSS queues for SR-IOV */
> -		if (adapter->vfs_allocated_count)
> -			num_queues =3D 2;
> -		break;
> -	default:
> -		break;
> -	}
> +		switch (hw->mac.type) {
> +		case e1000_82576:
> +			/* 82576 supports 2 RSS queues for SR-IOV */
> +			if (adapter->vfs_allocated_count)
> +				num_queues =3D 2;
> +			break;
> +		default:
> +			break;
> +		}
>=20
> -	/* Verify user input. */
> -	for (i =3D 0; i < IGB_RETA_SIZE; i++)
> -		if (rxfh->indir[i] >=3D num_queues)
> -			return -EINVAL;
> +		/* Verify user input. */
> +		for (i =3D 0; i < IGB_RETA_SIZE; i++)
> +			if (rxfh->indir[i] >=3D num_queues)
> +				return -EINVAL;
>=20
>=20
> -	for (i =3D 0; i < IGB_RETA_SIZE; i++)
> -		adapter->rss_indir_tbl[i] =3D rxfh->indir[i];
> +		for (i =3D 0; i < IGB_RETA_SIZE; i++)
> +			adapter->rss_indir_tbl[i] =3D rxfh->indir[i];
> +
> +		igb_write_rss_indir_tbl(adapter);
> +	}
>=20
> -	igb_write_rss_indir_tbl(adapter);
> +	if (rxfh->key) {
> +		adapter->has_user_rss_key =3D true;
> +		memcpy(adapter->rss_key, rxfh->key, sizeof(adapter-
> >rss_key));
> +		igb_write_rss_key(adapter);
It leads to race between ethtool RSS update and concurrent resets.
Because igb_setup_mrqc() (called during resets) also calls igb_write_rss_ke=
y(adapter).
Non-fatal but breaks RSS configuration guarantees.

I think ethtool can/should wait of reset/watchdog task to finish.=20
I'm against adding locks, and just my personal opinion, it's better to impl=
ement igb_rss_key_update_task() in addition to reset and watchdog tasks to =
be used both in reset and ethtool path.

What do you think?

> +	}
>=20
>  	return 0;
>  }
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c
> b/drivers/net/ethernet/intel/igb/igb_main.c
> index da0f550de605..d42b3750f0b1 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -4526,7 +4526,8 @@ static void igb_setup_mrqc(struct igb_adapter
> *adapter)
>  	u32 mrqc, rxcsum;
>  	u32 j, num_rx_queues;
>=20
> -	netdev_rss_key_fill(adapter->rss_key, sizeof(adapter-
> >rss_key));
> +	if (!adapter->has_user_rss_key)
> +		netdev_rss_key_fill(adapter->rss_key, sizeof(adapter-
> >rss_key));
>  	igb_write_rss_key(adapter);
>=20
>  	num_rx_queues =3D adapter->rss_queues;
> --
> 2.52.0


