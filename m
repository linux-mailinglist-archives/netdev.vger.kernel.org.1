Return-Path: <netdev+bounces-258560-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AM1LFDShjmmNDQEAu9opvQ
	(envelope-from <netdev+bounces-258560-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 04:57:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8112132C74
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 04:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0206303FA82
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 03:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA10024E4AF;
	Fri, 13 Feb 2026 03:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NJOkyqmm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B768A22CBC0;
	Fri, 13 Feb 2026 03:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770955055; cv=fail; b=QoKmHjW7olkH5G4dL9H6rCPleMVrMdirMzVxrRBXf3GVD0XI0pgBh2/5R0pKmJkcJOEhEwP2b/9U1tuGApVX+gGfr7k/dQ3+yqqSG2Rx9TeAGIaEhe+ELbJI2VvNEdJAZvNYoD5pUhK17CfqEqjOAbN1fX/rigJ9TM+RurHxLaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770955055; c=relaxed/simple;
	bh=I2di7U8/PMeK702ahN7eMeluIkN6BseOhjryrnvxMvU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DHnCllCu+OQFB8bLZY9NZ4sWzWLHjCzBT0jwvSDK38Bj4hgaaeRb131CU67qOfU1TnoTi87ZkmrfMgSsxrNzhydFepBgpUYDiiXRQPjgLTkZG/9CBc0v9lrxovDQEt+GoMxrkdQFM2D3fqnWGXnAWMFBVtcFtSXo60TOsgGcWEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NJOkyqmm; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770955053; x=1802491053;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=I2di7U8/PMeK702ahN7eMeluIkN6BseOhjryrnvxMvU=;
  b=NJOkyqmm9GzXpa0OLXxyOycWJFg1FbP2fzgDImk2w4avxj1wzSuy0fXx
   wwFnzeSWYWzW0tFNvuafA/VJ4gENbDMiAc7bT7RHZDxGf3AY+STm80NYW
   cwi4wKeibiJ5krcyDXAsO3Al/4iyxnOodLcnhkUYcThfdL4EwBrx1iJ+3
   uHohFm7vI2BZ9cTOhG1Je/OasnzrLsY9+6fXrrma9q6IeTlkFqwYcgH/H
   Cf0Oa8VjCUdhb+q5B9Kmp0LuOO+t7zO1CRGNqD2zMMDURV+q5ApZqG2Vb
   SnUD7YcrrrS1EQWsky0Cy03zragVJvKwFADeo42bkJd1cE9/+4o991bt1
   g==;
X-CSE-ConnectionGUID: 8ZONAyrVRwq1ogDXIVBZwQ==
X-CSE-MsgGUID: DJKIihsNQnmcms+5BnHeBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="75982750"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="75982750"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 19:57:33 -0800
X-CSE-ConnectionGUID: Ono41SIwTtCrlgd4S813sw==
X-CSE-MsgGUID: D2hHXEaHTWKQiyxaxUGMcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="243406470"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 19:57:31 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 19:57:28 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 19:57:28 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.62) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 19:57:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8UcAr1vHKZ4u3+jQ90KtPYlrzZVjxQSuDoR4vDFGcqeNWIrHeauezuPGWP1C1TNV8skb2i1XxrfxaJrEF7VrqW4u1d0VlKY11GBIKWSqOaUJW5HoMf0iAYr0syoPwW/19axvAnklXPrFBtpSbFc4H3LYDQU7+UbU+IEd3RflyPKjLyO+Nh84awiAWMyAwkl3OshymhoaOK6cyRxGi8EkaQ2LsP1Wfr3NtnXUSxC8PKPlaGczz6zHxfwwNrmNHhu1d0YIej4wk8BPzzKtPK7hgAxTMyH0TimSeK2te7gL1yDZEnmdfXa3jVE1Zr6nSu5YDw184EGnA5SGKGr1NQ24A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2di7U8/PMeK702ahN7eMeluIkN6BseOhjryrnvxMvU=;
 b=JjGVchDOcAmV3Uf+9xN9DjYxLO8c+CPt//TNUg5FiDmKxl1psElpo8yQQm9hM9emph7JoSPfRvVOe7i3ZfSehVjbKvGKMe29GSvRuvgdsMJ2RjXjOejmziZMFdO/cDpxtSjsRPfhTONHxi3wS+PP8HhpnTbOAMC1+jzRq4CGU4HL1ySHSr+yjN8ySXkeCgyL9vLkhVSTtagZ7v5e9shNszwPsdbmud1qV0uNU2Shn/0meSPVtBWslu+kdz6mSbx9cObwLbGoZkxNv09c76al08/P6noGaxmuM6m1tvEDYO6pte9inOH3vXHZzMhbl+u3BrWOtKcpLWmZAV5q/Vlaew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DM4PR11MB6168.namprd11.prod.outlook.com (2603:10b6:8:ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Fri, 13 Feb
 2026 03:57:26 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 03:57:26 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Zaremba, Larysa" <larysa.zaremba@intel.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
	<sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
	<kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
	<jolsa@kernel.org>, Simon Horman <horms@kernel.org>, Shuah Khan
	<shuah@kernel.org>, "Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, "Bastien Curutchet
 (eBPF Foundation)" <bastien.curutchet@bootlin.com>, "Vyavahare, Tushar"
	<tushar.vyavahare@intel.com>, Jason Xing <kernelxing@tencent.com>,
	=?iso-8859-1?Q?Ricardo_B=2E_Marli=E8re?= <rbm@suse.com>, Eelco Chaudron
	<echaudro@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>, "Toke
 Hoiland-Jorgensen" <toke@redhat.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Dragos
 Tatulea" <dtatulea@nvidia.com>
Subject: RE: [PATCH bpf v2 4/9] ice: change XDP RxQ frag_size from DMA write
 length to xdp.frame_sz
Thread-Topic: [PATCH bpf v2 4/9] ice: change XDP RxQ frag_size from DMA write
 length to xdp.frame_sz
Thread-Index: AQHcnFJWY0K5zIVdPkeQziXVWaIttLWAAH6A
Date: Fri, 13 Feb 2026 03:57:25 +0000
Message-ID: <IA3PR11MB8986F7044E60C1DF4DFD44A3E561A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260212183328.1883148-2-larysa.zaremba@intel.com>
 <20260212183328.1883148-6-larysa.zaremba@intel.com>
In-Reply-To: <20260212183328.1883148-6-larysa.zaremba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DM4PR11MB6168:EE_
x-ms-office365-filtering-correlation-id: 8b26aa5f-a52d-4f10-2aec-08de6ab3fffe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021|7053199007;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?H88gjmJCKLEMQ4BtL3RKaxTDSWCRfKomtTUIEAoC9xSiZyLQlh+HWztgql?=
 =?iso-8859-1?Q?8X8NfpkdTCFs72DA5Itx6Hgs4FUpFGrYb9pRh6YZxj6EuyVszf691BFMNn?=
 =?iso-8859-1?Q?7YIX5wvJ+5+21y/F+bWJV4ioL16dgOfmGD6QmkRXYjIxyafA1XW70gj3ig?=
 =?iso-8859-1?Q?q2PQZe2+/El8rcrwQhwS5qqG1AA+Kk6vnCoSYDj9WiMIdDkybbDfMUPiuZ?=
 =?iso-8859-1?Q?153tL29STh2idhqjD4kObqGqSzOzVGrJ1K5bM6+tEO00Z6p8dzHi6C+WJS?=
 =?iso-8859-1?Q?Lesi7udlS+LnAzltG3cao65NcA2n8W73TLyyd6+2yZ9v016i+pq62UnBAJ?=
 =?iso-8859-1?Q?Elo2OYtctfUcm0p8UfnR/e+caSSSoyJgR77gQKwxcYekjcJK09N3rCTLqX?=
 =?iso-8859-1?Q?DbQwKuC+zqgxYNGkNQoqP5px3relseHchN5VXUzqNNDik3CCobAYjKnq5E?=
 =?iso-8859-1?Q?mVc2ix64hJk/ukMWhUoa87YDGA0VB21/YseRF55P/CmG0qWKDJoa+1ebX9?=
 =?iso-8859-1?Q?vQsBRg96Y4BPTVetNZBaXD3avKLoyVSI8pddj8Ns1Y7HZ7evzD8ZzuCtOZ?=
 =?iso-8859-1?Q?poWPgujjxWu+zB48SFPEowxvNlDnjsEW0w1qBvIoTnDXsCFRcN6z12DJf/?=
 =?iso-8859-1?Q?kG+u3N+3hzK3dmL9omJvZx3dO57jc6GLWhxRuQUr/M68lvinhKBdwcfeoh?=
 =?iso-8859-1?Q?WlYNvLpGBADaOzFkV4mYrsG8eYF/B6Y7+DnT04TEl7b2S0W40wtkjFqTWA?=
 =?iso-8859-1?Q?LrpBWG6IWOXXu4WTx8V14g6S4ppSiz9q0h6h7qW6YCZqsl6KWar1h0qIlO?=
 =?iso-8859-1?Q?G9Sa2KnS05g0lF7EKg9n+7TVEfLcKSfd2NOI9CmpPgleTXH5sD3tWPOA9+?=
 =?iso-8859-1?Q?pNi6ZQp/cnoqSRspbd2JWjCOi8WkCbn6XkpL8fJXwMssWFIFTNLd80zCzE?=
 =?iso-8859-1?Q?IUrCMLjtmMcyNccNZz8fumVkxXkRZYniNjazU9CmOTIyaqXSX4SSdh9s8Q?=
 =?iso-8859-1?Q?q8NxdgE5aeqL48lZOcH8ka6uxj7DVDByWP4INGkhRpSuJTA9E43A0/sTgi?=
 =?iso-8859-1?Q?ST3SaJbgTFAE/MpGpCgIHaEAlcDo7THzljaKUp4soMC/KUhjnNPtU/Cm5Z?=
 =?iso-8859-1?Q?vLQiT26tf4yaW9pDBhHRCbr0XBHi82XRLA+KQEANJcUUK22Xm9dmVJS9Oq?=
 =?iso-8859-1?Q?NxxSAnFfbqDS3vaSBqP9UGlDQiKmhtVIPxRuRXZdBEg4sWhCqh7mk31DX/?=
 =?iso-8859-1?Q?2Pb5mHbtP46tGxDKY+4adtk27/cUFOCHreSbPBYANnlf1UrrL4ClhJQ2Yz?=
 =?iso-8859-1?Q?QwkC5MUz6EkaMnjgtJAP79r31Y8qilcnFOBRdBAPaq591JSpRFMB54a2Tz?=
 =?iso-8859-1?Q?tLtfCL9oErt0jKL3SiKmPJ0KPu4brxf0avW9Fp6oohW1Ck83yFsA9qVBzz?=
 =?iso-8859-1?Q?a5/J2O30BAuo+BhJwrXJYJEPWmEgYPPOScyiEZvSvxgoBbbnKSrxINZJox?=
 =?iso-8859-1?Q?znDKAUnrgq6iyrYm3MWwdc81ZTh683CYHudRS8MOrxuuTLqzQwtEMGxr/B?=
 =?iso-8859-1?Q?xpof83aH2m2DNofkFPF+H2Md16i4ai1WsTfqdiL2TP3HCNJ4C07/oigXxO?=
 =?iso-8859-1?Q?uJL3z8g8sN+PRGZhfUsKHGNwl3gaN9lvM9pj8fhEDFwO1Q0VTQWoLNypxq?=
 =?iso-8859-1?Q?4HngNMaM1BYUDfyjFkA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?V7YZ6eDTOnvzuxBPA79F9nh1WheA+vYLETUMfsldKmiOqXjskS3C7oXKaG?=
 =?iso-8859-1?Q?iu+Q94lUpU5vgPLXiGeju/zl69rj1QzyHJhG05tYXNt6Ot/S2JrP7JzVv+?=
 =?iso-8859-1?Q?iS9aNbS51ZSma8BAJ+vEE1gcvQh+ld6zFrBILEMkEGNi6v8Sx8fTimgjLW?=
 =?iso-8859-1?Q?emiK6Q24n64h7JCKO54C/G8Ctnj6jStKSHT8F8XHWs4sSL/MalZSoi7h8x?=
 =?iso-8859-1?Q?9pBNSTnpo0v5F5yHHmCrXFngSQHRghR6rhcHiPBqLEoiDM6wpy7eIOykE9?=
 =?iso-8859-1?Q?Lho69nFKbqkfEW5dkZjhs2symZilqa6xNCS5/f3iWSX4RcsueG7Wyd3rp2?=
 =?iso-8859-1?Q?NFFjN3VRnJaDqB5yAe5qDHHjuj1r7d7sRTznEQnBKm592GylqfX/rAEUMz?=
 =?iso-8859-1?Q?FjudKY6Hv2Ur31jd5FytauNbafVRhejg2C92/HDqHbfH4HnSmAXu63kUek?=
 =?iso-8859-1?Q?UfPGWBrPL4Q/0PzdqbcS4wWTIU1zRf9Rvxdlv+d6fB7U8lwncR/h9gRRp8?=
 =?iso-8859-1?Q?MuT3RydTzLFEjQQtig2e1xwPDdSM4wMtI34Fhr7SbrUyUS4PNKPREQ7pUa?=
 =?iso-8859-1?Q?pfm7IARwuIN6MYRuCHZ/g5IbrwKkKgnA29SNrZ6PQ+Qe22UNd5Wg6dj9I0?=
 =?iso-8859-1?Q?IYWUVNc88n1S3x3U7qynAoJUl5d0yCd22Xtrss0ekCERlUN7Jd9ebrIsje?=
 =?iso-8859-1?Q?v5oQD+tGZ7/3Y8HTCe+IrSFoOrUMakevhNo0g5v6IhUg6dpQqHTz7ecwEp?=
 =?iso-8859-1?Q?wmr4xy0Qyr0giaBW4zSs+yGGd8pNH12LKKL7UfpgGH38sP8m0R6e/rIZ3X?=
 =?iso-8859-1?Q?C11gO2L/FcI3KUBqsPrbMgmpd29GbqbduvBXpxajO/0cmdVpVraRHizln2?=
 =?iso-8859-1?Q?pTnOMOwwn+RwIGX7RquKMTezo2ON+WSEPvlpBHfp5hUH5YXlTugpAnDgPh?=
 =?iso-8859-1?Q?dqRc+pUnEAk78pi8AiGebocV6QdV3Bt/8jzJTFfn7yPNutnue6GJYJBiCP?=
 =?iso-8859-1?Q?I/te/xlM6b7sk9qD2wMGf0jfhW5B1b1e38Xm2NPYEiJr5Qt4v9swGtBx/F?=
 =?iso-8859-1?Q?HAEHtdhT9PLG4LueB4qONN0hiV9Jp1ycmJNLXPQHIoHoCszG3unTr0BQQc?=
 =?iso-8859-1?Q?c6nNY6rJi0uLReYbYLn1GbtXGrsmuyE+We+G0OxZO1gE6kWeUaLQBfC2hD?=
 =?iso-8859-1?Q?rkVbpfs6mfjV3K9vYb3xyVL+NYaFj4BiNvM5FZjsMiUAjZ/oTeffSyKwo+?=
 =?iso-8859-1?Q?L+u3UVE/qXAhzfQNOHYqYPruk5FBlMT9hZLawf32a/YjqV5iDmI4WTU4Ds?=
 =?iso-8859-1?Q?0L+tMFNHUVdyLTGgWecZWMe/CVI2qzDVTz1rqqTjAeq0x+L5yZUMqJox/E?=
 =?iso-8859-1?Q?8slyNd5hoE1DPeiY82uUVUN+GBlSQUHLEungSDup3NbpRVdVlrGNOeamqd?=
 =?iso-8859-1?Q?5KExp8NYiwJvaGWvIDUOZzEUD2ByvhxmO+A8004NRhdBkEV/uvUkceFaCs?=
 =?iso-8859-1?Q?xKWOani2mIutu/zCFyu2px6z64rBNOhYlvrlP5DGED+gvRF7GfQU8UgkMI?=
 =?iso-8859-1?Q?dsQ6WK/7Y3fS8w3n23LwxQzkWdmBMyMDpLZtpARsft25mBqJ+DMEN6u3LJ?=
 =?iso-8859-1?Q?DrusYRuVkW31940HpHuZh4bRLtOwVjuIbTG2KGxVkg6mvj61DLOcuOGrsV?=
 =?iso-8859-1?Q?9WFB++IX757aD73ANGeM73cgj8zyGFPk5lGS/t4xG+8kJ1G5eSxb15tTV1?=
 =?iso-8859-1?Q?6O3Q7AUVSiahVAWdm0nTzFGZ7QNTgDYvOe1w48dY1rcvxprxTuIXuugfBN?=
 =?iso-8859-1?Q?L89xBXu5Jw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b26aa5f-a52d-4f10-2aec-08de6ab3fffe
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2026 03:57:25.9349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QY/Pfy90mw+CnjJTsr8JPeFYmSfRbyS2i6OSFhIpFVmDaX5mbK1lm44MXA4c1w46Jk4hzjxHHh3QFHuXSoosjWprTQIJJcprbnoOXQF5U0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6168
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[43];
	TAGGED_FROM(0.00)[bounces-258560-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,intel.com,iogearbox.net,gmail.com,fomichev.me,linux.dev,bootlin.com,tencent.com,suse.com,lists.linux.dev,vger.kernel.org,lists.osuosl.org,nvidia.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: A8112132C74
X-Rspamd-Action: no action



> -----Original Message-----
> From: Zaremba, Larysa <larysa.zaremba@intel.com>
> Sent: Thursday, February 12, 2026 7:33 PM
> To: bpf@vger.kernel.org
> Cc: Zaremba, Larysa <larysa.zaremba@intel.com>; Claudiu Manoil
> <claudiu.manoil@nxp.com>; Vladimir Oltean <vladimir.oltean@nxp.com>;
> Wei Fang <wei.fang@nxp.com>; Clark Wang <xiaoning.wang@nxp.com>;
> Andrew Lunn <andrew+netdev@lunn.ch>; David S. Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Nguyen,
> Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Alexei Starovoitov <ast@kernel.org>;
> Daniel Borkmann <daniel@iogearbox.net>; Jesper Dangaard Brouer
> <hawk@kernel.org>; John Fastabend <john.fastabend@gmail.com>;
> Stanislav Fomichev <sdf@fomichev.me>; Andrii Nakryiko
> <andrii@kernel.org>; Martin KaFai Lau <martin.lau@linux.dev>; Eduard
> Zingerman <eddyz87@gmail.com>; Song Liu <song@kernel.org>; Yonghong
> Song <yonghong.song@linux.dev>; KP Singh <kpsingh@kernel.org>; Hao Luo
> <haoluo@google.com>; Jiri Olsa <jolsa@kernel.org>; Simon Horman
> <horms@kernel.org>; Shuah Khan <shuah@kernel.org>; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; Bastien Curutchet (eBPF Foundation)
> <bastien.curutchet@bootlin.com>; Vyavahare, Tushar
> <tushar.vyavahare@intel.com>; Jason Xing <kernelxing@tencent.com>;
> Ricardo B. Marli=E8re <rbm@suse.com>; Eelco Chaudron
> <echaudro@redhat.com>; Lorenzo Bianconi <lorenzo@kernel.org>; Toke
> Hoiland-Jorgensen <toke@redhat.com>; imx@lists.linux.dev;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; intel-wired-
> lan@lists.osuosl.org; linux-kselftest@vger.kernel.org; Loktionov,
> Aleksandr <aleksandr.loktionov@intel.com>; Dragos Tatulea
> <dtatulea@nvidia.com>
> Subject: [PATCH bpf v2 4/9] ice: change XDP RxQ frag_size from DMA
> write length to xdp.frame_sz
>=20
> The only user of frag_size field in XDP RxQ info is
> bpf_xdp_frags_increase_tail(). It clearly expects whole buff size
> instead of DMA write size. Different assumptions in ice driver
> configuration lead to negative tailroom.
>=20
> This allows to trigger kernel panic, when using
> XDP_ADJUST_TAIL_GROW_MULTI_BUFF xskxceiver test and changing packet
> size to
> 6912 and the requisted offset to a huge value, e.g.

"requisted offset" -> "requested offset"

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> XSK_UMEM__MAX_FRAME_SIZE * 100.
>=20
> Due to other quirks of the ZC configuration in ice, panic is not
> observed in ZC mode, but tailroom growing still fails when it should
> not.
>=20
> Use fill queue buffer truesize instead of DMA write size in XDP RxQ
> info.
> Fix ZC mode too by using the new helper.
>=20
> Fixes: 2fba7dc5157b ("ice: Add support for XDP multi-buffer on Rx
> side")
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---

...
=20
> --
> 2.52.0


