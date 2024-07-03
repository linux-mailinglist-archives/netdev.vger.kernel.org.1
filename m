Return-Path: <netdev+bounces-109030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BE79268F7
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 21:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AF881F217FA
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 19:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345A918C324;
	Wed,  3 Jul 2024 19:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fCgzFhjF";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ACGvoXAX"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326C8187560;
	Wed,  3 Jul 2024 19:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720034844; cv=fail; b=DT6LN6G/cb9u94rVEImOhCtttvAxO21DdDbdUyT+AhjOBN899T/dep5zBicctaJlOqxWCqaupIEJHtKlPdPXM944nT0/cGc/v6V9ZdBjnKPwryEoDzMB9nLN5Rmh6E6s9tzJ0bukGOWZnGnxoADXkPb7IDx5tmtDUNkaJgu23j4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720034844; c=relaxed/simple;
	bh=W9Z0SPODXn7KkKkoxfBbBD6Wif9w9FHVmVgoi371hUs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hP5913G7i6M9BrUb//TuLFp8KijqNd7DwO1Dc3QQpu3tRfRICFAGsW6B6e1JODHKQ7XRgN1o0SK7MoIUSSxbxr3QFuHtIy2BC+ZYe2989Y7Tj9DReamJc0UGjaP9tjkZHYApRzGlwajIN2gt5mYphL3qnWa18D5JuAndpRWOWLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=fCgzFhjF; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ACGvoXAX; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720034842; x=1751570842;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W9Z0SPODXn7KkKkoxfBbBD6Wif9w9FHVmVgoi371hUs=;
  b=fCgzFhjFIJ6oM3CxcZN2hm+zpXxUoyc77SNB7+mNS91NM2Lv59VS/MwO
   KX4AL0K9RWmIfl5i7NVY3vqilGFB4P+qQi0D6gwHFwu2+YIb3l1kjaX8c
   aHH0PohB4blVqDuEN/qPe2oovgrbjzqxRXsOr3N5WMsNseC6AjYQQAk7W
   fPjfUyKqyJYZ06fcqUQKZnn8RGWwWGm/CiWtm+2uX8ykqT0M0lLLOE+4r
   BSXgXyv5++9ALp1IqHzjrHCoATYMj1dbmSFwny25EzV4STVBOKHmgrBe3
   6iWm94V5piw6LhgREAn4LKg5Le8xkDbjGAa/npwShsMtVYl2CZ2v0xuzs
   g==;
X-CSE-ConnectionGUID: qY4aSBBrQCqVOesBlZDAsg==
X-CSE-MsgGUID: I0MNPs1YQqy2pOczwRj1gw==
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="31437521"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2024 12:27:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jul 2024 12:26:40 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jul 2024 12:26:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+HH+W53unpNJ7KjbiEj2JZfQvNRZ5cJ8EN+XDU9AeoObyJWE4NPivKsvlLg+0zZikrkbDsH2OTX5eK9JzdVK6AUyndhLyYWDu/gxUgKSoj2jnh1KEA8WGK6XlXHuCYZu9s97evEndkfS6eGRe9JqkW7GsTINjjp2eYlPbEBd2TKwOe2BUpNC3MvjVgGVKyhpD4XJKZJQ4n2jS72tMW6Zd10mtdbHugpdp2MEAxoBH6WQb51YTkguqu0r0FBREMilTih08h3PRPzmc5Kv/FMeu8i84X5sWMQFA0/Cou95hjHyRmgawMMFqnrsplI7kP6s0trQncKWBi/ekVV8Ev/0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbnYurS9w6/tZCUllj8EwsVXmrFrG9SvSGdWNTpv9No=;
 b=b0j7HpVUnDfsuwZV+kpW2hLz78IJc3wCIOa8sy+AJmFyfS1dkBabvcNveUtYelL3ake/DFrpZazsilHvL0L5AApTWozX9rtu/JgfR5mCQaCCP4MxLL1DySxWX3hu7ZkA32GMA10ZfplKfEV2HOoJDviIyWbxsb9TWDNlJicU9h3YrLc96BVkcU3sO5pMCTGAP5ExgAgRF6xQFcD8QfWjSrLYa+N7g/Yu8bhXPHBepRspjXl135QdwAeEugLiFYadQyZyX4FfzCCMqWBWYSk4LMLkO6JiPt+HuB8K1dVHCz5eo/eKcao8Cdge3dtIZYLOh+pvytSrMaHFNKZ3JkwwfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbnYurS9w6/tZCUllj8EwsVXmrFrG9SvSGdWNTpv9No=;
 b=ACGvoXAXxFG3A+r3R5aetpQ7KdSMtjTdJ6I+mSDtc6Wpny6zAsszDaWOwO0nRkFyhueCOuIyVdrIzFM8eNADsHUB9xxFQSYASHKu+g27z6eJfneUZXdn0Gev/jSWMOCISoYRyILplAxa3C+zllTvmxc35H5aiGzcHWqXx7edJ022UUUUvqPGQ0XA20F5nrvl9kQCj78ff1u74ZTCRDC3NnkEy168hjsvFkZD0TzmP2g1d1Pg6OlZ1xXrIwKzOMPP3J4/j1HYukVDQuY7iHRXDXS3ny/1irX3xcqXuvkg4DflSenMsnG43qN+riv6FTNBER90mkHs8wn2etARwNzXiA==
Received: from BL0PR11MB2913.namprd11.prod.outlook.com (2603:10b6:208:79::29)
 by SA2PR11MB4889.namprd11.prod.outlook.com (2603:10b6:806:110::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.26; Wed, 3 Jul
 2024 19:26:38 +0000
Received: from BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742]) by BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742%3]) with mapi id 15.20.7698.025; Wed, 3 Jul 2024
 19:26:37 +0000
From: <Woojung.Huh@microchip.com>
To: <andrew@lunn.ch>, <o.rempel@pengutronix.de>
CC: <davem@davemloft.net>, <edumazet@google.com>, <f.fainelli@gmail.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <Arun.Ramadoss@microchip.com>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<Yuiko.Oshino@microchip.com>, <kernel@pengutronix.de>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH net v1 2/2] net: phy: microchip: lan87xx: do not report
 SQI if no link
Thread-Topic: [PATCH net v1 2/2] net: phy: microchip: lan87xx: do not report
 SQI if no link
Thread-Index: AQHazUzmX9NUGxV62UeqsapgFtC2XbHlWzSAgAAGxxA=
Date: Wed, 3 Jul 2024 19:26:37 +0000
Message-ID: <BL0PR11MB29135A585E15976470CF932EE7DD2@BL0PR11MB2913.namprd11.prod.outlook.com>
References: <20240703132801.623218-1-o.rempel@pengutronix.de>
 <20240703132801.623218-2-o.rempel@pengutronix.de>
 <47b227f0-d445-47ba-9386-e8b77b733c26@lunn.ch>
In-Reply-To: <47b227f0-d445-47ba-9386-e8b77b733c26@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB2913:EE_|SA2PR11MB4889:EE_
x-ms-office365-filtering-correlation-id: c081814f-54d4-481a-326b-08dc9b960ef1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?3ktSbi9ppkrcln2oiUrY7u1jdGXZv2tAsovH6R+6vFBHpzBuYgF3/z5xBlSZ?=
 =?us-ascii?Q?yVwNOW2W3aVc6T2H4IEzaY0cYjKNRG+zukQN+Vqm/VKiaxp46zUuKRqx+Yj3?=
 =?us-ascii?Q?O1xNZNboS3gtYoDOQ4gSm44ooSXLqJgVRXkKjTebQtXBHsaEICyOKqYjcLas?=
 =?us-ascii?Q?IsFC2VykocgWW0/xh+xXB+yZHya7uY52vDK/kewWrcHTC7ZpZkF2Oy3M0bWH?=
 =?us-ascii?Q?EApQloOQauopd/IJVzLPPcA5tFOGF4V+ZegqX7D6nJH+6h/K3n84u/pwPLIt?=
 =?us-ascii?Q?X9WlhbkUlSCVJ73ZTmYPpZRPAjiUfACSanwUKO1/zIM/ORYwcRw3eepN9vTr?=
 =?us-ascii?Q?J2CVJwRh4oGYIyhxXYru6m61Ku04vY9n28OHKmgj/QK+geUV0xXonpf4vm4C?=
 =?us-ascii?Q?bTnGrJhgMOqAmmFDY6pgM+1tXstCLOS50hmzLgeFBN/4WQh1Cns203dINmWM?=
 =?us-ascii?Q?VBUkO7P7qLvjkL/QVNwquW/bho3E3IOrQXNvTic9xYc9v4ppjnnIAC3kIymb?=
 =?us-ascii?Q?rW9GNHQD1TjnH7Xs/iDS+rc8jRClry3AO+K7O47kXpdGAzzCEh4iCiVIvD5B?=
 =?us-ascii?Q?HBpSP6uSMriDVE28B/zjfMQx1K/3ooeBg4D0KwJILuf/9+d5NVtAp7rqYw4g?=
 =?us-ascii?Q?NyGHHczZfqRv+yVvoJe2q89ERRwzGZBZC0rs+AAkuzFJW89pQWqwn3fxEA8X?=
 =?us-ascii?Q?5Ay9D4SHOyckX/Xv1k7spbB2DwhhhE9QPyWp2jy/8nnIgPV2lbAwaJOwQL8+?=
 =?us-ascii?Q?fwf8MjFFYOTZlRQBDp4ma0swcB/zq0XGeGGZsO3UlutI3j3URNvKjJHDBQi1?=
 =?us-ascii?Q?28+5VPvI1iQ9lqzqvVZoQ+b4+bnJDFW6E7jzwOtWe82RKfz4LYVu2HJdrApi?=
 =?us-ascii?Q?6Qd9uZHjndI7We+x7PeXSZWKjR/rbUN/B2c4GB9idcciW4VnM7KRFDQa6xeY?=
 =?us-ascii?Q?kMy36/C3raIjMVfdDlxv+YC5An+iUj3S3FAdNt5spplroitSlonz/i32FM8j?=
 =?us-ascii?Q?usqQfSv9cfvqNd5mc5IgkPDV9k1sB/2X3fQciZ6iR4BFeMr5lr047Agu3ZNX?=
 =?us-ascii?Q?d0zfoYePDMPu5hmApmX+liNJ3c6c8Gx10IRJOa47Myil6J3VX7Yk6u53GUOI?=
 =?us-ascii?Q?2V+SnyPYUW06I1yExkCR9F5SgFpZ5758jWR+3EE2Sl43BY81AD7ZD+4A9XAw?=
 =?us-ascii?Q?uOBM9YmBB2h6/sjNTPNTicWeNdEptowtE5I1ot8qezmH+Kjr1Tu4zGbs1Ep1?=
 =?us-ascii?Q?Fy8HO61RV4E2XNsLFOhB07dQBkM2Nx3A//4NOD8YCW9K8qxHuvp3IEKSAKG5?=
 =?us-ascii?Q?9nqalzUmsSRV+VQdPtN9Pc6I7w/DWvF3Nbm4cWTe22+YV8ZNQisd7vEinepO?=
 =?us-ascii?Q?A+lALkM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2913.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PH8DFNiKgdVQ9cxzhep2c4N/KrhEikGnvmfzlW6E1qRJIediE1o+ZdgCkxDE?=
 =?us-ascii?Q?4V2XUj2GwFU/wI4unDEXVNoewePjZ8aEYEb6WXv8udkd0GXsXsBEHS1spP+i?=
 =?us-ascii?Q?rhLMhP/upLHouOn4REf11vsgJdu20ffmAeUVVElFXH0WwrmLoIKdDnnKGp6/?=
 =?us-ascii?Q?rFnlzvTBOcE3HgK4hH3lshbQ1j7AsEm1PnKegvK6YJQ5i7MymF50NWPeBHAz?=
 =?us-ascii?Q?6ZWvnyAFu6v6sUenzVBYR/3e/mOpKRs3cc9oQLFedKFqsTvxvT73qUuHNrSh?=
 =?us-ascii?Q?SnNtpxHpt2Sm4viEobu4FnQuZuDEeNYUTN6o1rDOz6Gd9qyvyNwwMKd1rBE4?=
 =?us-ascii?Q?NIWxlSFAnY/cGVjxJbwH3YJgsqeeRmdzEakdqMKBmMzgRhPANhMjuOzHYAmf?=
 =?us-ascii?Q?xWdIE6KXuuSN2NsT1qe6OA+1wM9cSP6d91PFEZZ5K5nGxzwKhMdF4cUfoSId?=
 =?us-ascii?Q?Sx3JHAGFB4Kh8xtUflMkUw4tRfdD5BJNJfdEuMM/SaSvd0T+lIrtTEdPt7WK?=
 =?us-ascii?Q?hUDaVoTMQzlYFI8dRUUKc1Q9CYGxY4bTur64KWgyHP0iGeMEUlfKo/ulk5be?=
 =?us-ascii?Q?3vntkMGKUVFYIxmswsNWF302e/V/+mAylwBWK6nuH2DFZAsHVh1vivbJI8Kf?=
 =?us-ascii?Q?1n3a41XUpN/HKgrcXTOmvFV2Zs+p5v8EppJ85dZO6lMDEdBPPabEoHrOyd39?=
 =?us-ascii?Q?caV2j43flJL4Yvc5X8sbSwewBodA5cmZiKa4VHU6muOh5y6PXo/DHBtc5gBd?=
 =?us-ascii?Q?leKegNA7IGhLdl9QkrMRjk5pdhfp2n4kKeRdCiYQnyRNqU2CaQbrosHvHDyZ?=
 =?us-ascii?Q?jsc4iiX4m2w2W71w6/mpw5ZFMuMltBUPKM7NqAI87AIEVISZtJROVK5zK64X?=
 =?us-ascii?Q?nQyLS6W1QkSgoNX1jHs5Ys5W0/G24FV1CH+SqaYNNoy1d1a/hoS4jxQ4ohdO?=
 =?us-ascii?Q?dkprsnxBXqMth7111iM9CIzRQpqbNVrIbYEjAVcydfmLAJeBIu36eGSU9SM0?=
 =?us-ascii?Q?cPuiNfVWpwJDXzOJe8/I/+f2kZ1SqoREzJIvDpuo0BCOuaLgIYiEpaG/EVIH?=
 =?us-ascii?Q?REFc26ALhdplj8WRv3ihhQuvBKHKQDcazX078CBafjaMtHrcKzi70vqDqMO+?=
 =?us-ascii?Q?I25ZE9LhldbQty27wZhutT5JWkapl8f7ANHRCZPYLoo4nVJ0Y9F+s8zmWB+U?=
 =?us-ascii?Q?SXHizpsICH0QycoNhuMRQAoYW7JpIWeapyVG+WzNMGeLbyzwAN+I999Keq+2?=
 =?us-ascii?Q?OoDT/XcScmAfOGDt4jJ/afBhfr7i3qcb5ZvjT+iGROD1dDp1PL0VI36URhQE?=
 =?us-ascii?Q?DKFt8qODY9JwdNPfQXqOwdS0IHM9RWEEUYfOm4s0HsZm730OE/M6QmR3LXyT?=
 =?us-ascii?Q?N7X2R+mlbFD5dibpTL7xMJxBeqyPNLzg1+HXnj+tPdPdum9e6YHQD7bhxVFR?=
 =?us-ascii?Q?SxEEK4uoZeCPcmI79w3n+p+M81FQDFrlPS0wP1SCJJGigFDBnPhnqWdAdYNr?=
 =?us-ascii?Q?gRXLtEJy5kyeloz/MrQfbF7a+B9KdB2QaSsO4dZPjPkaUoMz1G2KXI+UDu/N?=
 =?us-ascii?Q?IwIaKHaCZXZAD/t4gZq/bcJABRf5SLrdMKsXXjZO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2913.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c081814f-54d4-481a-326b-08dc9b960ef1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 19:26:37.7235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zYdhmFcKyJscP1yLyL5Rk6ZSFUq5UY6Gl0U6zvfyRJ0D2CdEBz5lNW7DNyq9MUrzPWInv7KUD9gS4/g//b3WR0vBpkNWVr8eW9Cy+gole1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4889

Hi Andrew & Oleksij,

> On Wed, Jul 03, 2024 at 03:28:01PM +0200, Oleksij Rempel wrote:
> > Do not report SQI if no link is detected. Otherwise ethtool will show
> > non zero value even if no cable is attached.
> >
> > Fixes: b649695248b15 ("net: phy: LAN87xx: add ethtool SQI support")
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >  drivers/net/phy/microchip_t1.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/net/phy/microchip_t1.c
> b/drivers/net/phy/microchip_t1.c
> > index a35528497a576..22530a5b76365 100644
> > --- a/drivers/net/phy/microchip_t1.c
> > +++ b/drivers/net/phy/microchip_t1.c
> > @@ -840,6 +840,9 @@ static int lan87xx_get_sqi(struct phy_device *phyde=
v)
> >       u8 sqi_value =3D 0;
> >       int rc;
> >
> > +     if (!phydev->link)
> > +             return 0;
> > +
>=20
> Is this the correct place to fix this? Can any PHY report an SQI value
> if there is no link? Maybe an automotive PHY using T1 and good old
> fashioned CSMA/CD could report about background noise? But do they?
>=20
> Maybe this should be fixed in linkstate_get_sqi()?
>=20
> Also, maybe it should return -ENETDOWN, not 0. Do we want to say
> "worse than class A SQI (unstable link)" when in fact the link is
> "class G SQI (very good link)" once it is up?

I lean to Andew's idea because "SQI values are only valid
if link-up condition is present" per OpenAlliance specification of=20
100Base-T1 Interoperability Test suite. [1]

[1] https://opensig.org/automotive-ethernet-specifications/#

Thanks.
Woojung


