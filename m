Return-Path: <netdev+bounces-117178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 371F694CFAE
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 13:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E48BE285713
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 11:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A5F193088;
	Fri,  9 Aug 2024 11:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="d4JfXxcL";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zI2kGpWq"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBDF192B9F;
	Fri,  9 Aug 2024 11:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723204758; cv=fail; b=T1vpGvMV7xnJQXU55l6alX1POaTkaI86UdElaRtGn/jvM+EKKilkIJ2PBGrJ2hWh5vz9mxKsnRKXi9hcve9Okljecw7GfzVO4oqpaEsXvQhmvNOZhuZSGRyNBYPeDfGnTeUwJ2dOEqZGcceh/uw/stTVDSDPjYYvqeTCGFahJ74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723204758; c=relaxed/simple;
	bh=6IkD3AIV5XPIgW1lX8kvQUoTd/QV5qsu9pVgdbHmZzk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nMRcz0G79yjKclVBMpzXG+hp0Nd8n8GCc5z4l8H74IZVYKK3dApRgXjbRK8NLt+D54WFYMDWLz1gY7w3ANi9xKudkYif/VA1X4/NLJheZBVbACVmKlNOHCFk9nosTgQ6MadkRomY3XEZCWqq4o7HXd1AFLtivT+74X/mMmjNm8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=d4JfXxcL; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zI2kGpWq; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723204755; x=1754740755;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6IkD3AIV5XPIgW1lX8kvQUoTd/QV5qsu9pVgdbHmZzk=;
  b=d4JfXxcLFKbBNQLMBKM/wAWf1UarAywK14gscvcZG1QFA3dc1V8SCDiE
   6UnKGCJwflwx5kGxPQf4JJeHjtL40ZbQuceNLApq9/1xh2Iwx1SL7rmGJ
   TxZ+oq3Czz205aykLeITNvYlug7k5dkRcbU6IhbqojFCUBbl6ulwgockR
   D9dO4XyzXXJoJE8pDBp7M5mj2G6l92sWtmiRGyq7OwEHMLOtVHRVjfHBC
   1QOCEVGqTvZgUVnXyC6yVMZRlBLluwGj3axtQHoL+T4SRuEbSyr1EoEhK
   BTeBAy8DAy6ZjWTaX0IBH+XrfLgHKwetDhu5FBc5ZQM0kruWyVdKpQBBi
   g==;
X-CSE-ConnectionGUID: oXspuBNTRKuQyf0GrbkGNg==
X-CSE-MsgGUID: 2kKgzb/yR2aNaz8EY6A1zg==
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="197722425"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Aug 2024 04:59:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Aug 2024 04:58:51 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Aug 2024 04:58:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYVJ0GoGXjtxDxSD09KYu4X4vTZ61Xe5gQw7xhwdj857E7oafXcLjNp3yekZTY/9yauLbdwBAZM8CUONyGQ0V5bi1lzYepuPFOY7rfVDxt1nTXpbQXoCxuvKJdPCj+fryOzRi+Pn1JTsUt/HBaYTGpTprij8T8oj7AaJuVZTWi8wojo46OOIft52vEjkmYTy8P4qI8eczMZZzpSdk3zEl1fyJuBZY64yCZKKrFUxVLS17oCiVznwQc0Q9AxATkxkh1bY+EELLb6gnyUKRdrlneLrkPxN/PGbkgp/rtix+ZpVtf86i+BG5HN+UAfa+VutEscHd1z9+G4f6i2DwdsvDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCsGjbrtvbmNUXJxC2rMnwfs5EKLJ+YdVjbgiK04iAo=;
 b=KEvvjPnDwHR2IUZhUO/L3XBR9/6DcNip4Fx0G1PHYcjoVGW5HUSYjIAK19mD3aEkG4vHZyr5MKV6it7cwWKbUw3Uw3keahTuMSJftbUFn9yRR41vnf1Y45PNehpu+QrAYI351f3B+g4sqLjwM/e/YB40uh3Jli+/kSilSHDDGO/b8Kqx/ynrZM8MUwHlMJa2zhx5CIagm/NdTX5T9QFsUii/641TcqyE53U/06PyVU7sGAUNrZRdvBl5F5W4bCIUV4MQuNVZeB71wnezsz5m/W3MQiRypztMSECiCoosdTNJNaqKBPfH7GNzY8XkBNfbkhsIJgEtY3YH9rxefGrmwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCsGjbrtvbmNUXJxC2rMnwfs5EKLJ+YdVjbgiK04iAo=;
 b=zI2kGpWqZLGaNqz+F8qFAJESWhleO1rqvwACKkia0Oyr4d9RbTHki6b8P+9W0VRSLpqEjMOUtFPwZdYUDt00vrYft6d8rI+Hmm7ErdT/lULMpbr7KhTUyRoNG/X/bxiqsqxVQCLZ6TL6fmAxfKvaVVNP8g7xl9vAm4XKWBLhOySlGOxFKYDEcXbo3dpuavSpwOQbqYmjZuzDOwKTIBmTH/XyiuoqiATFhH425ibCttM9xrqMXpPo1jE2FMRBlc3cJfY7r3qC78tP+gfOqHKYVwIrWFNr/E1XL31ctlG/2AXh+KNjPotwaFOb6zFZrnmYtWsZrAvdNOeWSN9pXTK9Ag==
Received: from CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9)
 by DM6PR11MB4596.namprd11.prod.outlook.com (2603:10b6:5:2a6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Fri, 9 Aug
 2024 11:58:47 +0000
Received: from CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708]) by CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708%4]) with mapi id 15.20.7828.021; Fri, 9 Aug 2024
 11:58:47 +0000
From: <Divya.Koppera@microchip.com>
To: <linux@armlinux.org.uk>
CC: <Arun.Ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] net: phy: microchip_t1: Adds support for LAN887x
 phy
Thread-Topic: [PATCH net-next] net: phy: microchip_t1: Adds support for
 LAN887x phy
Thread-Index: AQHa6Yq368FyCB2W40W0fvYzUDQ2srIdRxmAgAGGJOA=
Date: Fri, 9 Aug 2024 11:58:47 +0000
Message-ID: <CO1PR11MB4771395A5D050DC1662E3C08E2BA2@CO1PR11MB4771.namprd11.prod.outlook.com>
References: <20240808145916.26006-1-Divya.Koppera@microchip.com>
 <ZrS3m/Ah8Rx7tT6H@shell.armlinux.org.uk>
In-Reply-To: <ZrS3m/Ah8Rx7tT6H@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4771:EE_|DM6PR11MB4596:EE_
x-ms-office365-filtering-correlation-id: 8461018f-5204-487a-54f5-08dcb86aa084
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?1WCxRNmFuubcBSpcggjxk0ifZLPEdgYn4MxUTbazT1+/GAkAcT1jdIKy8F4f?=
 =?us-ascii?Q?dwnvDMMzi6qX/28qpQSNKQQaN+A3uIEK08wAMuOhoAQFFmMqH0C9+vBwCgOD?=
 =?us-ascii?Q?5LclXDL4DQjug7jyPR1NSGM6K43qruB1seudA3NrPgGqRNcEBl7H9XRQwRK6?=
 =?us-ascii?Q?EUTxMg7lDQ56jLQxt4uD7CBfEL9maP7/tLZ9m4oEXzRIjwaFdioxMvcjL/OM?=
 =?us-ascii?Q?fZFL2xmVr8MSFlT1+IozfqV9jBs+e5fa6I3rJiyNRbzXKfYpDME1UuvnLxSo?=
 =?us-ascii?Q?V673OK40h9YyWUI/VoEC52GCGk2zpwlM++3sOFaIJEBeJcCc6lfgeiuDKGvL?=
 =?us-ascii?Q?bseShlg56lKVOErSN5Q81gQMRK8mxbCfW5WvOqBuRk1ut3n5d4jNXU6vKBcI?=
 =?us-ascii?Q?2EpRvnRQiT0zVsI7pCNaf+dbnMWZw6plD39Xtdq7jrdXMgtbPdvWdB3FGPxL?=
 =?us-ascii?Q?JOHRvyBdqtn+iFtfZE9Yl7CxveCZ/n/vkOFxZTb+kK7tdWpHotKvI249keFV?=
 =?us-ascii?Q?/vOfJpBT18c6FbT1OVti1fxwEWSh9vsR6fgr0umSODrknb4PhEel8LEwdUB5?=
 =?us-ascii?Q?52CaYN4h75PMWImJvi0y2U5OhCzhr4LGGhk/ClOiN4EY+v6XEksJs4tKVHyD?=
 =?us-ascii?Q?Oen+7U/i4L5qKQNTKnFZSI1zQyCUjQHJ4XU8WWj7YusjbXyNvGpJpsJXnWp5?=
 =?us-ascii?Q?PzOApfZ+hKXkma6vNaMvD2bgm/12NU7bXIYlVJXfiLmZzTQVDh26Wr0zwREK?=
 =?us-ascii?Q?qYSgn0WEmXAcovYX6TTaZKgqG2r3B0aY/1CDdXiMoCuqSjm3N3vnqkJghrji?=
 =?us-ascii?Q?Z12Rs+b0As17dQq8u33WvOgRvMop6X89pFkJ9zOpiYN7H/BaId0/dNfOeDJy?=
 =?us-ascii?Q?K9BRWciDFr1vVWgpyOwqCxaEk8mcLTbrOVXpAebAkL4pEutprXBmWLUd8dMd?=
 =?us-ascii?Q?eeS3qYJ3FPnwvDHADCzFiGs8ZBdOOU3uQ/+Am3uD20QEd901L2KYktZu5Oid?=
 =?us-ascii?Q?y01bvDtDmFkEWcef+XkFZjruzFl0HRb7Mesd5/x/qam5DkWMoXt3gUufIrGJ?=
 =?us-ascii?Q?NB38aZAKNkLTfjPbJDrSOfmxQZJ6y1QbmuuszogllJdBK3F2Ey2bcSZYdKAG?=
 =?us-ascii?Q?UgCHSytgsHLkPqw/mkv+8nKy/ob7IUtUtHRst87q9xEhINkmVzxtzBddF7Cq?=
 =?us-ascii?Q?Tu7E3c0/DlFe+11idubrqXQ98d3/ZRLJwFoYstAEclDbMGZDybWAXZ7Vdh0n?=
 =?us-ascii?Q?llMWQ17tBn6ZSTiSHL1FyhiOEUQBSgX9wRLBY6e4+B1JaumaRYrA8YrvIUY6?=
 =?us-ascii?Q?jGpxzesHsJnLTGHONM3zNJAm9M2pTymPNR1bfiseRtw0CP5qfNnMujbpm3PF?=
 =?us-ascii?Q?BVjmiXQ=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Qc6vSOIJHB1Bd/XYf95g7yOZ2Ury9cQsnDRt0XdVrbPD5o4+1DMO6x/BzH1R?=
 =?us-ascii?Q?MmOG2uVsGqKCgPL4rHvMutVLpDlXCLKDDvmfSoM5QeCpnrd2c5DER1i/1JuJ?=
 =?us-ascii?Q?EH5oxR6TgaG7DdjPV3JXvvwrBVQyFjp5UzS7qm8gScuk7hNIAuvE4Pa0RsfY?=
 =?us-ascii?Q?KyUy6m0z9Np/oXyVQfqBslWoosrYKG4a3hOLHVgccdXkBCbAsgeqZrGZ+nAb?=
 =?us-ascii?Q?dRh1/OsD2qSo7FXffDvzW9TpDrVvjiVyrrMyyYA6NL9xlADalKXyRvkCsL1l?=
 =?us-ascii?Q?gbQfT4y9RqvPb5AfIV1adjsd+E3ioRwY6MEbDzEIdxJrCiia1pzDP5x3uqu1?=
 =?us-ascii?Q?hAr3Uk+74DsNyruD6igLySPOc9B7vy7KHiG/4iEOg6PlrEKB2o31B+49Xk+X?=
 =?us-ascii?Q?Kb+BRitNcuQMtx5Etg036PNjy1hzKfQHZwuWIsNSYjBjm45dhGMyJrFMen7F?=
 =?us-ascii?Q?h9xrW0Cliowqmsr2dfmKSqTGPjRgN0Uz5sUFaAM2p3+e34McKcU6/G3iR+dF?=
 =?us-ascii?Q?EjI6jkddy1QPhWEl6dqVLxy46FObCfO8tYmlbNNwEd2T729Fu/joEm9NVazF?=
 =?us-ascii?Q?k+0JKtL03OmJ0JCL+SHSWZzj+rZgToCZlxGXaHvJdj1KIWGcrb1EFjLKwtAS?=
 =?us-ascii?Q?fRcuP8T/h3ykUhjqX6Yjz1qtyW6uoAnwjHGeBeGy5/p6baF99p4Ywk47XlFg?=
 =?us-ascii?Q?OQN+EVJpuqk0hvmjbuzEERysPBCucFo8HeTaGe+WoVS45UCOp7A00x4zEgBu?=
 =?us-ascii?Q?FLie+5UyCEZjaqQweajt2u1vWvwUUFjSIlircbKFQVpxdZpQhdhlU6EIXA6E?=
 =?us-ascii?Q?PtqOfTNlSiLcVpyt0qypum8CYmVlvH1abdojtu6DYCgKQkZemGIhJpBW4VAB?=
 =?us-ascii?Q?Q0U1VPswCiO2Dv9svUrnRiMuQ6wNIfCbqK70APZyv06KNok/FHmQNeTl2mkB?=
 =?us-ascii?Q?q3Ng5gfKqs+uNewfvu9Nr0rbXAETPaj8IAQ5Dci9tD2fv7r0g+QFiJoAwgA9?=
 =?us-ascii?Q?ER7cbX3jvB3fvlxJY2AkMLE9WKlc2UH2wrCsyc/bypAYJ5nyrvBwwpPtpLGM?=
 =?us-ascii?Q?Pkb+SPXj8e6ehNrERt8FGMvcvBajfIZNJ2zOEZUYVHF1jnUNvyxzRdLxnBBs?=
 =?us-ascii?Q?yg8qGzdVR5jGacqiW4dzX3PldOP6h+FWPptOEvYhocKDE9jv+4bMwFVEke+0?=
 =?us-ascii?Q?uvV84Ukat0NgfILwpIMvBLw1zjn1hK9tfSVTsT7ByLtvsFT449v8WsBov/hE?=
 =?us-ascii?Q?CIcU4jEUwGg26q8hLUbKk/OIZArOXzu26kr9DKfRav4hwudAl2hD4Id7DSwQ?=
 =?us-ascii?Q?kj7S7JvW3sof5nUzM4pCJub7+PNNav6SK2YpzUA1H1q5hOJJG8cCkzAUH8Nq?=
 =?us-ascii?Q?WM9PgLsSkhAPaG68KdnAI2OJt62HkU4D/S04ylfKf3XXgBnPxIiSTGh3dtuq?=
 =?us-ascii?Q?KNaaekD9x5ii2rKUFrHpgJeNkp47mKJ1ZdbU/SIwPegHI55KxSU81Fm66OcX?=
 =?us-ascii?Q?jaQMn71jzMSCGjK8j4Evo+mAdRKam9X7o30YvITyR5ScANRpGP1Hpp75wX38?=
 =?us-ascii?Q?ZtfENLaIVHYRivW9+cmmTlVIZhDFDDS+n9BIj+fXEGPtHApdAq/SOuOPhjuD?=
 =?us-ascii?Q?BA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8461018f-5204-487a-54f5-08dcb86aa084
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 11:58:47.8502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6hbqi1ax/C8+iu1XQxNE9cmseWjrfofh+7QaaZd0tcwPlSwxoMbRRF4eEhK7aU9TiRv0LJrWyLERlqnZSe3P9gEdQjq6Vks5eRMJwMSoJmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4596

Hi Russell,

Thanks for the review, please find my reply inline.

> -----Original Message-----
> From: Russell King <linux@armlinux.org.uk>
> Sent: Thursday, August 8, 2024 5:49 PM
> To: Divya Koppera - I30481 <Divya.Koppera@microchip.com>
> Cc: Arun Ramadoss - I17769 <Arun.Ramadoss@microchip.com>;
> UNGLinuxDriver <UNGLinuxDriver@microchip.com>; andrew@lunn.ch;
> hkallweit1@gmail.com; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH net-next] net: phy: microchip_t1: Adds support for
> LAN887x phy
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> On Thu, Aug 08, 2024 at 08:29:16PM +0530, Divya Koppera wrote:
> > +static int lan887x_config_init(struct phy_device *phydev) {
> > +     /* Disable pause frames */
> > +     linkmode_clear_bit(ETHTOOL_LINK_MODE_Pause_BIT, phydev-
> >supported);
> > +     /* Disable asym pause */
> > +     linkmode_clear_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
> > +phydev->supported);
>=20
> Why is this here? Pause frames are just like normal ethernet frames, they=
 only
> have meaning to the MAC, not to the PHY.
>=20
> In any case, by the time the config_init() method has been called, the hi=
gher
> levels have already looked at phydev->supported and made decisions on
> what's there.
>=20

We tried to disable this in get_features.
These are set again in phy_probe API.
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/dr=
ivers/net/phy/phy_device.c#n3544

We will re-look into these settings while submitting auto-negotiation patch=
 in future series.


> > +static int lan887x_config_aneg(struct phy_device *phydev) {
> > +     int ret;
> > +
> > +     /* First patch only supports 100Mbps and 1000Mbps force-mode.
> > +      * T1 Auto-Negotiation (Clause 98 of IEEE 802.3) will be added la=
ter.
> > +      */
> > +     if (phydev->autoneg !=3D AUTONEG_DISABLE) {
> > +             /* PHY state is inconsistent due to ANEG Enable set
> > +              * so we need to assign ANEG Disable for consistent behav=
ior
> > +              */
> > +             phydev->autoneg =3D AUTONEG_DISABLE;
>=20
> If you clear phydev->supported's autoneg bit, then phylib ought to enforc=
e
> this for you. Please check this rather than adding code to drivers.

Phylib is checking if advertisement is empty or not, but the feature is not=
 verified against supported parameter.
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/dr=
ivers/net/phy/phy.c#n1092

But in the following statement phylib is updating advertising parameter.
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/dr=
ivers/net/phy/phy.c#n1113

This is making the feature enabled in driver, the right thing is to fix the=
 library.
We will fix the phylib in next series.

>=20
> Thanks.
>=20
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

Thanks,
Divya

