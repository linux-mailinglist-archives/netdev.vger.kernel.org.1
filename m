Return-Path: <netdev+bounces-209630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E52E3B1015F
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 09:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D24843AC075
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 07:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2A5225792;
	Thu, 24 Jul 2025 07:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MYZU2e0D"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E43205ABA
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 07:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753341133; cv=fail; b=FeLQpPVVrsJ5eUIv6Qh//UwP++sFEu8Hq1BDRiUU+MiqlNHpYZYPUz9g6al2FUE0O1OHldCJmU6BMKHP3LX24OT2jjjDHwcegEcdFJ+JTmlzCsSiFFWE8msJmDccAtBWHfg6jep71fw2OjryiY+nSxlDAPIdQ1YvD0EPencM8U8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753341133; c=relaxed/simple;
	bh=Hb7sH/55g2EAO5O0Jw2GjsfdG7dggVgnG+YJqoA0JXQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xcb5jWT5ku5BwUiSUxp+6ZAo+htOfB4UDmtufDwQ+W3OJTBVzbTX+zl0oZqIHWslkdK854pe7q0/57njCFoJirLbybjXL8Z9BoFbCBfFX4WzpQvsKQrb7lPkMf0SYJCHwoCzvvLo5pU3We5YGsSwGxYIHfylFDeq6NIKCtUdi5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MYZU2e0D; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753341131; x=1784877131;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Hb7sH/55g2EAO5O0Jw2GjsfdG7dggVgnG+YJqoA0JXQ=;
  b=MYZU2e0Dc9VMEwMbyYeFgtyWKon0cjtoRf36e3iDf8J30xmmepE7yu0q
   yLk48dDVxhPOJFtfsL+EyD74fzwCnKKaJkXGLcvx725zYlLwdNKXQCjE8
   1/KXS0YyAOMug6FygeHsqcPmokaRJNy+B5YmCe5IxMxHX4od25bacKf36
   QoxX9fP7PTjzn7yavFppgoyi6ANfgiayEeLPGwd4qv4n4uX2IKhk0O9qM
   jocZ5lWcjACr5T/7KqbqDnIqo0K+0wPSno/fpTUl4r6twfE2GjZ0XTDD9
   g//VG5LZ5fVyKi8854YD7IrKWsTUVb8OW5gntv2OGSdCqHdgVt1cTC8Zz
   Q==;
X-CSE-ConnectionGUID: 8yrt9rbIQWCV6VDhTtYRbA==
X-CSE-MsgGUID: CCcKDCtVRLG2grnJWaKgfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="73098467"
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="73098467"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 00:12:05 -0700
X-CSE-ConnectionGUID: AP6nG01WSiCmH/0kHpoPhA==
X-CSE-MsgGUID: DGuXzICaRQ220GHP8IEm1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="159655800"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 00:12:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 00:12:04 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 24 Jul 2025 00:12:04 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.44)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 00:12:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AaS3mRlQ0/acVGFUZTVjy8E5Dm5hX5eMaYg1RcSmD7ip9bJC2xC2RUMJTpytYFj9EMaojZmRkA99z6RfNCbvd1P6euuov7KYzypPdc7AldEknZ2HHAgZ/m0djFEjkWT4UA7snamcsWMMXOgTrOj1EvGnwrQ+LfBCK85Aca7+C3ty34+CYkPVqS0wAOoqHV5BRdfj4khYFEyZPopLn6oXC1ARFIpx5utdv6zFNurnGdqY1zNeTunupGfO+L9YWTM+FDAglkXb3G7Q353qEAUBWbWwlLgj6sEm3tCXkvVE5R+E5zPQNOpu92E4GsqoXskcfk2ZIClofHD/E/C6826dTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGkvuoBfk6yzvcOdmZpHZ2saUTBWMxTqeastS/jucdk=;
 b=AdRLWlkHPnEcYzBiIrEcB+VS8UfDrIRlj9adsoO6p7TtjSUAmnJTs+/6+93DWzB8JqU7ADM28k+wGsodDFEjw7UkYhgHnGgMKezVlVFQ06eT2uE2Pt56xqVUWhseCE8RhGOuKOA+NBElKaXB59HTj117NygJoEI/BlEpplFviqfJPHLNkNjODHdbZtBy7hO6lYSMhvhmRTJ1zIxihNgVvPFmC1NbdN617HcDo8pcfo8BRT2pgpUlGmdyiStV/BoAjocLw5hdgp0Iv/I3PEHXfu1pOu907SDr0chVPqISnLElyzNHZdC4QpDEFiJvUpyClHW/14+MlfGbKALjyj8tEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by IA1PR11MB7270.namprd11.prod.outlook.com (2603:10b6:208:42a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 07:12:01 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::4955:174:d3ce:10e6]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::4955:174:d3ce:10e6%3]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 07:12:01 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Kwapulinski, Piotr"
	<piotr.kwapulinski@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Jagielski, Jedrzej"
	<jedrzej.jagielski@intel.com>, "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
Subject: RE: [Intel-wired-lan] [iwl-next v3 7/8] iavf: use libie_aq_str
Thread-Topic: [Intel-wired-lan] [iwl-next v3 7/8] iavf: use libie_aq_str
Thread-Index: AQHbtaiI7tCWLOFcQkGs9JDzt1CBM7RBaQrA
Date: Thu, 24 Jul 2025 07:12:01 +0000
Message-ID: <IA3PR11MB89851784EC3EE882EB1FF6668F5EA@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20250425060809.3966772-1-michal.swiatkowski@linux.intel.com>
 <20250425060809.3966772-8-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20250425060809.3966772-8-michal.swiatkowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|IA1PR11MB7270:EE_
x-ms-office365-filtering-correlation-id: 4d9125b3-8cf6-43a5-263e-08ddca8162dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?RWzokAhcrfqBlUEcHFpPDdQZTrCKrm9cXZeeI2jIH1oUNBk82mFdyv7nJQvq?=
 =?us-ascii?Q?v7DmWzD7q1ZBm7ZISWhuLhDy8hOlyx7lvr6VgQJImFlOu2VUvIb7AXpNexXJ?=
 =?us-ascii?Q?0cDBzMHvtGwTwnifTzwOjBT/B0hsoHVDLcLxyWRokifi1Zi/kn2erlFIRjkx?=
 =?us-ascii?Q?CVG7fK6MdLRfP3/VMU4olZggABbZSL+BkvQYeSpe3KXYOZMlaDqUhA1gW4t2?=
 =?us-ascii?Q?yyXNSTc+lfWsGNvMVRklaN4+bagw3gup+QM6LkqYOnr8WQvOR9pby4s2bBAs?=
 =?us-ascii?Q?/YoSLgUx2HZxnmBg6uRGwBlZMnrLlvpj1YB6ADoSlROf3E/ZzyGmqyycMdM6?=
 =?us-ascii?Q?7cfJVPpBfPcyp6DIm8I5yqiEXZTsyzKV5z8gsPtpH3zruxqIWhX89a1nnz0h?=
 =?us-ascii?Q?Aq8lWOYUeJ45Cytyp2Iv4Hp8av4ck3FQD2aSiUSLf2jv2Wnj4to/+407Jbu3?=
 =?us-ascii?Q?vRaEnh9Sk2dsGciHV67S8OdSI+8wjkh9wPzlUIgOskmzrmcgDMxiruQ8X0D7?=
 =?us-ascii?Q?9pvQ0qekyR/dY2VnoOGQeqTcz01RbPedHhsY7YB9BrW1LxZf2EeiZpJwdSlX?=
 =?us-ascii?Q?2n+ShHf2bIUsysikTc6zrZ+mme14URbabW5z9ECQrgK+9XOzFSisT6u7I5aY?=
 =?us-ascii?Q?9UA5bbsRWYBaLhtghLhCVgVctjbssnwSlvX4xtLtJzMAMwxvQ0+5ZI32XsPH?=
 =?us-ascii?Q?9NXbO6u3TkYp/vAzhMktE08l0ScilUs+wVEiT5PR7J33FTydmsS4RKkVPdAw?=
 =?us-ascii?Q?IvnC7iPsmMJtnWPr98QTZuJR+TfvQZRGcSv9Iha/AILeRfn+zrcKbW10Op9A?=
 =?us-ascii?Q?VSbdlq/p+FoqxVC5gIoNNoS0fq33HqZ+TbiAxv8XU7q/M25vVd5yiBFFi0e2?=
 =?us-ascii?Q?bFNl9hObXFUoVW5jywSZQXDls4iVYvaZScjpXVeNms2KSKXX3/kai7sz96Hc?=
 =?us-ascii?Q?C7Tmvr7bmWzFMg9fZtewuoWHkXl5r18VVWaldf5U0f0+Fo98urwFhjIhDtCg?=
 =?us-ascii?Q?n9LAjGHUAp4m1k2cwnnunWEYyKpRRvHyMi+DgLxuHNErGKTSRPuNYIGJJnDy?=
 =?us-ascii?Q?G6ERpTgepczhbvmBarzmItNj/oBEihA5gdh3XY0fkaAIKFGutgZgA/YukKWT?=
 =?us-ascii?Q?woYdP/HlnYkz8HCOSOCZoNCKn6eCWxwyx0fp0HXKouvabtJCJjfWXhZYlY19?=
 =?us-ascii?Q?CGBqgDSX4TbnHBfxOFnR9WFYSqgwjB7UWUBVCVS5FnYSQrYqcXXASbQsKzo1?=
 =?us-ascii?Q?XACfsnnrGgubPfAY0HdYPxGcP9YqM4C6jepNmXG2bQLpSMwJC/tejX56m53K?=
 =?us-ascii?Q?10BJlO/gaK9ogWl35ggBH5hGPsPBFmSG61IDWQ1TLi8Einy+CmnvC/FFRZFI?=
 =?us-ascii?Q?Jk31lcLoLnBAKLj0+QKh6u9yBMLPmp9Qya0MUroGAL83gQM0O9ZomtGKIh3P?=
 =?us-ascii?Q?ss+av7MJs9aJzjrZ4f53S2Bv4q1XU16eIQyIsvk1JfzCmkU1AcSwwQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VbHyEvqHXndmDPQAxGbq08A1nEhCiB84mEyK3jlFkAOA1jU77X01EZOoXvs6?=
 =?us-ascii?Q?tVRr9Ly7jNwy1MKKOiobQT+tgad4kuUjIb4QtDHLTwNsc6DbnrEqW4S6yAMl?=
 =?us-ascii?Q?UmIAO3t4Yrs5109b2K+HAactyjxkcFBUknmQK28lNkXgs65HsCEwDJDJW4lH?=
 =?us-ascii?Q?yzWkmeWdZQc9hVIU3QLYigp19dTvy50y6DMUjaa06d/sxzxuyxVdKXxg8bWK?=
 =?us-ascii?Q?OMsHnOtwKpdOs4spnXFaWlMrx0D11ZANhn5JsreWuu8mnSBY1h+Q3Wi9NKxD?=
 =?us-ascii?Q?t5Q6+tEISbqGjN4362VzoLfKXTVQ3DExtTutedQc6/lJUbAo+wIbFfqEX1Z0?=
 =?us-ascii?Q?VAWfTotRiNuXY3OLOkAb8wmff86lRMWNLLF/k9xEC+UDIftDNyjLyKDPaBH1?=
 =?us-ascii?Q?HnfCpQbQuBI5Dne+oZ4qNbLd/8behuDVVGu78mQgQRth0k7BK3X91MPM/6I5?=
 =?us-ascii?Q?h+sLJJqIxqWt30NQOx/tz3dgZsg40jils631IzwC40VY4LSC2bMfOYpgL7sx?=
 =?us-ascii?Q?WrWoFePo+eX0KJux30ewgDVphWTwVUpkyis+YzIViL4QKTLsnRJFie4xOmVN?=
 =?us-ascii?Q?iXCIA8xmqrR04xZIF/qcBdyHihmKwaSvP1oenqTIOXbOd/NRwqWXPI+IAQGx?=
 =?us-ascii?Q?xdaZIARDg6CRjVJcLSrp1G2Ifvqsrotk1LGeg1z1QL9OEwLfspVlTj2tGytS?=
 =?us-ascii?Q?CxkxtIOKjhcLOFzsn8/CnS+y1RcP+EzMZe4gkP7PJL85+WppJMk6q4l99rOI?=
 =?us-ascii?Q?AILS4WlX4b125cRuor3aev/wQZDlGKSpOU6f587UZjbb2zAtHDxu85ee5m7F?=
 =?us-ascii?Q?8WvHW7UmawghEyFl53CzcwihIWdkYP9BRJJyZZgfDgXvkt24SSvFEETTXypA?=
 =?us-ascii?Q?20cLdldPACxmEh3/Oreb8/p5jPKsUAGdioiKzF2/7E3OAMrQhGa4JAH77vQm?=
 =?us-ascii?Q?9CgqvDZXZUdgIRFatnNycFq4nln3xFT3CPFdx8Z7/st3bLkM97QmLOE12YDk?=
 =?us-ascii?Q?GTxJURppXBuLZbFHz536ckLVwWAVg3fnT/Ih1YsTXdbZo5eDfuIVh2KYpBsu?=
 =?us-ascii?Q?IoeKMC5jqFhtKrv4cN4poeWxlzhYh8EBUmo7tqIZPBXOS6c12BI0n1p3mkZA?=
 =?us-ascii?Q?tYuowe0f0c+hD5YnQaqXPNJMAZzV233IZNA6w+eIcLGCL2nEd42STsi3fOnr?=
 =?us-ascii?Q?39ZvykeaCnnXfYscgAzWZO0nehpKYZxDdrhaWG7MkruJRCTfNiKr4eRnelgB?=
 =?us-ascii?Q?8LRjbtrtsZTY/H7Po1Rd50l05hBl8607UPTRqy/3Oy1u9e8bTIVTgxtwnWn/?=
 =?us-ascii?Q?85kxEMcHbIOjwHvKpfqyRBSEvYK/LaIxCrJ3IeCnYRvqA7RvEDKkOTK166Wb?=
 =?us-ascii?Q?Afoi25yJeOf9Yb8eQGFsPopJUaK7L3pdSdf4wb5zbD8WnCJEzO21qBt7wPEE?=
 =?us-ascii?Q?NysYWTouyPGkJEO6qbO7BJEamaB39L+KT+Jm1VlEG18Zb1eKGPLgU/9GgEfv?=
 =?us-ascii?Q?9Gr1Kci1lvOLZ4YU1eDCuFZBQIXfVSm7KJBXvKt8wFs7ZSgZSvm1DDcjfAdy?=
 =?us-ascii?Q?fkkMqNDne7GIf7GuL1L5m86JKEY0icjX+gv4/khk5r0KnzR2QoV0AccPVb97?=
 =?us-ascii?Q?FA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d9125b3-8cf6-43a5-263e-08ddca8162dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2025 07:12:01.4384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g+FQAa2pVK57hdx81ChlbZwkWqcnU0J/RF+Rn3Dy8B7AVLxPH43ImS0uZLRN7QNFoqL1pReF72qFHOjT/JYw2v+KzxAHFyYerxeGBaAqEXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7270
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
ichal
> Swiatkowski
> Sent: Friday, April 25, 2025 8:08 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Kwapulinski, Piotr
> <piotr.kwapulinski@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Jagielski, Jedrzej <jedrzej.jagielski@in=
tel.com>;
> Zaremba, Larysa <larysa.zaremba@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>
> Subject: [Intel-wired-lan] [iwl-next v3 7/8] iavf: use libie_aq_str
>=20
> There is no need to store the err string in hw->err_str. Simplify it and =
use common
> helper. hw->err_str is still used for other purpouse.
>=20
> It should be marked that previously for unknown error the numeric value w=
as
> passed as a string. Now the "LIBIE_AQ_RC_UNKNOWN" is used for such cases.
>=20
> Add libie_aminq module in iavf Kconfig.
>=20
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/Kconfig            |  1 +
>  .../net/ethernet/intel/iavf/iavf_prototype.h  |  1 -
> drivers/net/ethernet/intel/iavf/iavf_common.c | 52 -------------------
>  drivers/net/ethernet/intel/iavf/iavf_main.c   |  5 +-
>  .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  2 +-
>  5 files changed, 5 insertions(+), 56 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/Kconfig
> b/drivers/net/ethernet/intel/Kconfig
> index d5de9bc8b1b6..29c03a9ce145 100644
> --- a/drivers/net/ethernet/intel/Kconfig
> +++ b/drivers/net/ethernet/intel/Kconfig
> @@ -260,6 +260,7 @@ config I40E_DCB


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



