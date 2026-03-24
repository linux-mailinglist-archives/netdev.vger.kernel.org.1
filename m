Return-Path: <netdev+bounces-270918-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BxaIgJGwmnvbAQAu9opvQ
	(envelope-from <netdev+bounces-270918-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 09:06:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B2B304543
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 09:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F7A832217EA
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 07:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC313612F0;
	Tue, 24 Mar 2026 07:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AT2+moB9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980DF35F8B7;
	Tue, 24 Mar 2026 07:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774339118; cv=fail; b=qeNPMNZ3PbNaqUa8erZSE37R4+TJad3e00s/Qjhz8nkj6hsRaQZcg1j7tADb1k6Ga58vKJjSGW6K8+poGADj+Tc0MtIqtJ+A6ZKgGFvZj134IhoHOdCZ5UgFBEFDioBsZui4q3COtX/A6JiD1QLZWHzbtA08r/iBdBIdYnyzyUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774339118; c=relaxed/simple;
	bh=tLweQj2+rQN8/zHC5fbhTiFLJwnGunVNMJfYuEA6Nd0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JyUw29aun/y2R4VWXbKxw84u4ENJ7yTlART8NZisI17Cb1ePe7jby4+BY1CXSm9FhktAoTmGDB5cFyJknVTxDgjA8bJzkyMaIcZ8gG3idqUsvheTK3h6dlJMi3RbIiAwSeI7FyCofbHmnyDgecssY4sFRLA3w3t5JOojyGdsWm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AT2+moB9; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774339108; x=1805875108;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tLweQj2+rQN8/zHC5fbhTiFLJwnGunVNMJfYuEA6Nd0=;
  b=AT2+moB9W3pgTsqLVh0OXk/7CQ2kMM2kWF1tuU6/oQtV7sde0Z14H4YD
   KJZZYYmyedoZ1278cz2RVRaIqsRmr3krCL1XzDhEhkwoaBLuaRCZNy4Fo
   8hTH8iWFtOp6OZl7ewdt85Gx3ItgteOdj0N/ttLcBZ+SW/9d+hvQuVIYK
   gS/DgKms2S26Ko6dcTDMlCSfjgYWVqOcB543dtH7COvevIRIVH9piJlk3
   mkCbAyhlxvjgRBKwMToXzL5N+O9dq132y1JDXXXakx9WJVx7hZCeR/9gh
   Oa4GYgfkm0+BWiaHBx4ZtQG5IphdbYDRj85zbQPUTpqdRYpP8yztjEdkL
   w==;
X-CSE-ConnectionGUID: SGE1XE2HR6iZMtBILRTIeQ==
X-CSE-MsgGUID: Tvz/AgmJThKb/xKdPWnN+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="85656145"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="85656145"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 00:58:28 -0700
X-CSE-ConnectionGUID: 4oncjEBkR6Wtt5C0cXNA9g==
X-CSE-MsgGUID: nd4idjkuQEW308Mgf3SUeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="224251660"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 00:58:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 00:58:27 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 00:58:27 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.18) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 00:58:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9mrCnyHV7/W32c09t3VtWpt8egRHOvlhtWAKliDb6+HfaNBGVpkITgmteApvfL2dokveiRXnsC9RaLE/EXMNz/h+kXTnCD4lo9ird8LTWpS7mEObo1mKWJhEQ5mn8QdTeYvDeb/JyWqGuBi5TBZO4NjrMyLrAKQiBkG19zMcxCmcIhJvLMTyWImALroeBosjSUTS18BXsoI8bUBLJrzGWJ43L2SCQjWmRUOf4pD5enYyAfp5Tx1LFiTGQZ+Cw8FvCqmF3rUkUa9GZiaOXVxAZD2Rz5YqbMsCT+ih3fAG/Ky6JgKMgTwyxFMGys9cLxdyqObAzG+6OxkzlJfLetngA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPGyIJvwAA057IsH1BM1d1wRn43snEkjtCV/3V2O2RU=;
 b=JxKbZh4LuRyp0xp93WQLqgO5troBM+uAfPUDPAK46o2wzYZ5anQtIkZ1GZkI7k3QCPy+1Srjtzk904SM8tkKOrkK4zh7hrL2uEfwvrt4TLNBPYeHvH/q87DqfzRsEFXCzgyq1YSVkZuQpGWd541p4mCxZIl1e0DzHl0OY9yZjh8BAHf5nROtEbYAKInzGLOM/IcdiRy6dRHh3bV70lz4zQshkf8Jw/4DDXkVu/dCXMKuPcR6Pi/svD+W8QDqsUYO8yHU96pbdBTDq+bYHK4xPDRMCo1CFHoIQaM30yPBNjY8+iJjcwFD3WGa9PujjOW0CQMAdoyau+Tz1d1F44D5Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CH3PR11MB8137.namprd11.prod.outlook.com (2603:10b6:610:15c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 07:58:20 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9745.012; Tue, 24 Mar 2026
 07:58:20 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, "Singhai, Anjali" <anjali.singhai@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, "Zaremba, Larysa"
	<larysa.zaremba@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "Tantilov, Emil S"
	<emil.s.tantilov@intel.com>, "Chittim, Madhu" <madhu.chittim@intel.com>,
	"Hay, Joshua A" <joshua.a.hay@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Shanmugam, Jayaprakash"
	<jayaprakash.shanmugam@intel.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Richard Cochran
	<richardcochran@gmail.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v6 11/14] ixd: add basic driver
 framework for Intel(R) Control Plane Function
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v6 11/14] ixd: add basic
 driver framework for Intel(R) Control Plane Function
Thread-Index: AQHcuuxW0JVyxeHNzUS4x3ACW0nVz7W9UfdA
Date: Tue, 24 Mar 2026 07:58:20 +0000
Message-ID: <IA3PR11MB89866C5138753CEB9F9833D6E548A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260323174052.5355-1-larysa.zaremba@intel.com>
 <20260323174052.5355-12-larysa.zaremba@intel.com>
In-Reply-To: <20260323174052.5355-12-larysa.zaremba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CH3PR11MB8137:EE_
x-ms-office365-filtering-correlation-id: 170405de-4d48-4dd1-c19f-08de897b1dc5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|22082099003|56012099003|18002099003|7053199007;
x-microsoft-antispam-message-info: 9ZiJ5TBBKaE1oFktmMlt0NCAY7YYFLrximSUlBCwrQTzNcVcAE+4SkedvlVKsZmKhN8gN6QCP4dP5S5ilFf80FhaBXhCSPlBZplEcsVWs3jlGVEAdS55hb8i7u1F+Aij40BjfBuavz1UPFkUfEko3UwC8ZeZ/ZKpHZJjEXwDM12HbcewtSod2TO5cRn4CC4nDLt38i1xhhLWV2W+FWsDJWhdku8fNILzLiB0nFt//4qRSwWMM8OjIp6pa7LhbuIeYuvJS+pEkFcV5iodsdsd27pmM7YCRnceuFxg0lJYPPJSD7SbEoB4l7MOvQieS3lfMLnMzDybWG30BEjeAJQlwbZ/kpy7D/CrGttPpv6mGdcfVqfF+GfPu7CqvO6Hd4kdYjF4lBVOytp3fSOB1KQ4OJtb8eqr0SOnBZBCXziLKEO31aW5vcCuwY7eLpOTJ1OvkP0TOjqP9d+dKrZRsGQVKuM/UdbyH0TzUPHdsS35ZnT7lVTLgugMG7h6TWg5Q1zqBN+jFUnVZSSzXQ16LqcBEXBM1ZMlSrsPvCPgsiWMqP5KoexMLUZXB4el6xnJxjcQWEPzL69Cn2vkHISihNpYS/cZ6lSZLVpidFQ4QcP29PCG79qCNhc53+8oo8LlxVqGKXUhTT/xq3hMFTIFKUifMUnCuvrj8PqL73JbSglt79lzl+/7Y67ezPYFNE1pR3K2kHt44GZ2TCbeg+aCEI12cAHVFfx1twGhIras3vVvtqKRAMkzAJ+hYymjmiwLQJnCNKg2Yg0VDQX18zWZ0OF9ysAdJHwXJ0hylnm2afcu7vE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(22082099003)(56012099003)(18002099003)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IOoOJ9XfUxb+3TjErvkFV4lNDrrDrHSN0IHWzQZJT01Mlu+tNTTivdWO+vP9?=
 =?us-ascii?Q?R9Iqlr86JjkqxQlyDOQt8KiSQmwhkmHktxkFLO6nAbetVhynGKWXP2HDW7Pp?=
 =?us-ascii?Q?+wRgY4o++nmBN59VHrvp8Sx1RKEGgNxFtxFU1+wdlaNu6KKo96EWUHK7a4Y5?=
 =?us-ascii?Q?l2H42RP6ZzykNs8BS+FnIzqcGf60CENUKTHoBcm/8Zujmyx5GKk/EPJz70oF?=
 =?us-ascii?Q?kJkrAE+FJCU4+5Sky3qDhod/6VPK30xPqybEPv08noOETVcgyHngYSDito+X?=
 =?us-ascii?Q?omW6QnsioSxOehVLSkpLqvL3wnHI14YtzJmKYOmkX4lniBdrHsKT5IW09VZo?=
 =?us-ascii?Q?1BkaqOdnQDCndmE/HWHN0+dBQyBRs93jOBziH0Gvq6kuBB9s+KCVkP1B/kpR?=
 =?us-ascii?Q?6+wa+6m1zYO81+MB2IWK/0QhqMWMX0tKHmaCJj1Ap5NvEFuhkobBnmTqlHd7?=
 =?us-ascii?Q?hJ/ifcTtpruJysMTv9G7fnLJnl7qcdRde8yzC6pWM8qv8JlIieiRSqzA/OfY?=
 =?us-ascii?Q?eRCv+MJuy7vmxKMlOhc755TKG5oLI89eBldEy0yOsLW/zet/v/Wu3Rei0avl?=
 =?us-ascii?Q?3JLDM+AWENNyfdofyElhezuALqjl2SLpaaKDiDMB3h4EJ26jQycFtNhDp2Vb?=
 =?us-ascii?Q?+im9KvfbwRNJKoTxqZJAQJsBujb3k5fV1452pJ/IJ4XxBFM9dWEUfNnsrtc9?=
 =?us-ascii?Q?mst5cVDC6hJ+wkdqT8d9768sZh/pYCnhVtK3lB8I2lskda7vdH/gJsZeyhMI?=
 =?us-ascii?Q?mygFEXGOk+faUAS7xPeXH6ul3ZCtvvUv27vr5Xauxc+IpeDymGjSuNx5oyGJ?=
 =?us-ascii?Q?7bGYAVYWUJJuMBkiYAkYLgAA+qWlmiHacsdo+yZVYSLPX0zLIv4LRgrfoSV7?=
 =?us-ascii?Q?qQChLCHIS6qB09JW8PPw9qVfkWwDc0SD+UeEY6cZS0CEhaevypBToOOja2gl?=
 =?us-ascii?Q?8y4uHdgXPkeFapkhcKij8sCbeTrh4HugAY5cAIpmoAGT8UROlMxymjZ0646R?=
 =?us-ascii?Q?0m/zIBnUkUt7Qpb3b5ctemmC0cm2v6FQsGRZ4cNbnl5JgSQs+/HHMaLw/4up?=
 =?us-ascii?Q?aXl45KLovp/YB6rkwW8WP8V6PUAtSXh3b4u5Aez75uTKUGqN/fK/nXyLMPuk?=
 =?us-ascii?Q?Q+FAXD6RfbE+9J38Sgqs+Up6NGVAwTqspGEhJVpUaZboobzuBGWmb791DTlh?=
 =?us-ascii?Q?Qd7h8vrTflq6dmQ/amaGB4irVeZzDnv5TYbKnLfAocbq3Y2PwxsoDDYZPsrZ?=
 =?us-ascii?Q?sz2o2exW0vlbmcEllgfoVEgW6PLocaUxggtrRZUV8+HOzifPbXeKkhrks6/s?=
 =?us-ascii?Q?XoVLj6eI+VC+Zo3fUY0h5CTp1I9C5/Uu51PEd+A7IKbWdIb8JTYTqCvkYsGJ?=
 =?us-ascii?Q?KALIdUXY9KRVI7E6q/hkJjriCDu2jhcvZXX4xdm+29n1sC/ARi7Y9mfhcnQv?=
 =?us-ascii?Q?8f0H3vEJ4O5NixL+YrQGbqmg11nVOI5i7ystUFqofqdQCSjEUimfLsWcgGK9?=
 =?us-ascii?Q?Hnhar/T0XN0vO7IvtFWs48hpYOt+okLaZfMSxpSV0Qu/YrHVn7uvrDxXKmQX?=
 =?us-ascii?Q?g8TRy1+S0IDHp03/qtygeUc7VYN49DNhXPiFk8rmElGEjECnNDj64Az3YHC1?=
 =?us-ascii?Q?iFVrLPxY/CBd4n9K6DjhX/NzXp7O5mysu3vVDrWrIcM6BWxlKp3fU2sACsBN?=
 =?us-ascii?Q?leleBVgMXglF2nz6p9ZC/2YCBe/V8wf4WT1LDujtAk8NHO6xmwpk5y6jpC5i?=
 =?us-ascii?Q?czqP8rBaBBGpGTJRVJpsedSagMwD80Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: v1KQXhqie6dnHMWNTu/ZN857KhqomPGm2Yx5E078UFMJe5LTXHnJ2aWejsNZZY/foVGRlhXEBS3pWcImiw6PUEmrT60triGyHHSZVzTtzQ2ibMfYJjxYnpgejBft6Du8RJTmeMXGfDOw6Nk56/YzUAzDvI8LvG3GpmtGo7u+rVKC8jpkVDkFB1CxZBoe2KM22Gu/rUvzAzxCL0DFXubdwdGFSva7YpsX7HQEF4cC9XCClRAAZ829QaCBAaNjpwcH8qptHQAT9Rd0WydmmhtdoFSnlkMXzSjDuemFLi4nz6g+aFEpw2RHVHXofj9vRVUN7ZGR30/AXKELojeHy2bWGw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 170405de-4d48-4dd1-c19f-08de897b1dc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 07:58:20.6384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ffoo6EQxzf2Tqq+1WT18B58KLYwXI2+dVsq2Zv62FH2wFP7gurp7PKsUuohPUpWeSUgSBu4qWoBaZ32Lfc3fvwXJNXFycWEQwP9ZpTnrG1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8137
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	TAGGED_FROM(0.00)[bounces-270918-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,gmail.com,lunn.ch,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: D9B2B304543
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Larysa Zaremba
> Sent: Monday, March 23, 2026 6:41 PM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>
> Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Samudrala,
> Sridhar <sridhar.samudrala@intel.com>; Singhai, Anjali
> <anjali.singhai@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Zaremba, Larysa
> <larysa.zaremba@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; Tantilov, Emil S
> <emil.s.tantilov@intel.com>; Chittim, Madhu <madhu.chittim@intel.com>;
> Hay, Joshua A <joshua.a.hay@intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; Shanmugam, Jayaprakash
> <jayaprakash.shanmugam@intel.com>; Jiri Pirko <jiri@resnulli.us>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Jonathan Corbet
> <corbet@lwn.net>; Richard Cochran <richardcochran@gmail.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; netdev@vger.kernel.org; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v6 11/14] ixd: add basic
> driver framework for Intel(R) Control Plane Function
>=20
> Add module register and probe functionality. Add the required support
> to register IXD PCI driver, as well as probe and remove call backs.
> Enable the PCI device and request the kernel to reserve the memory
> resources that will be used by the driver. Finally map the BAR0
> address space.
>=20
> For now, use devm_alloc() to allocate adapter, as it requires the
> least amount of code. In a later commit, it will be replaced with a
> devlink alternative.
>=20
> Co-developed-by: Amritha Nambiar <amritha.nambiar@intel.com>
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Tested-by: Bharath R <Bharath.r@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  .../device_drivers/ethernet/index.rst         |   1 +
>  .../device_drivers/ethernet/intel/ixd.rst     |  39 ++++++
>  drivers/net/ethernet/intel/Kconfig            |   2 +
>  drivers/net/ethernet/intel/Makefile           |   1 +
>  drivers/net/ethernet/intel/ixd/Kconfig        |  13 ++
>  drivers/net/ethernet/intel/ixd/Makefile       |   8 ++
>  drivers/net/ethernet/intel/ixd/ixd.h          |  28 +++++
>  drivers/net/ethernet/intel/ixd/ixd_lan_regs.h |  28 +++++
>  drivers/net/ethernet/intel/ixd/ixd_main.c     | 112
> ++++++++++++++++++
>  9 files changed, 232 insertions(+)
>  create mode 100644
> Documentation/networking/device_drivers/ethernet/intel/ixd.rst
>  create mode 100644 drivers/net/ethernet/intel/ixd/Kconfig
>  create mode 100644 drivers/net/ethernet/intel/ixd/Makefile
>  create mode 100644 drivers/net/ethernet/intel/ixd/ixd.h
>  create mode 100644 drivers/net/ethernet/intel/ixd/ixd_lan_regs.h
>  create mode 100644 drivers/net/ethernet/intel/ixd/ixd_main.c
>=20
> diff --git
> a/Documentation/networking/device_drivers/ethernet/index.rst
> b/Documentation/networking/device_drivers/ethernet/index.rst
> index 5f3f06111911..5b6846f387f8 100644
> --- a/Documentation/networking/device_drivers/ethernet/index.rst
> +++ b/Documentation/networking/device_drivers/ethernet/index.rst
> @@ -38,6 +38,7 @@ Contents:
>     intel/igbvf
>     intel/ixgbe
>     intel/ixgbevf
> +   intel/ixd
>     intel/i40e
>     intel/iavf
>     intel/ice
> diff --git
> a/Documentation/networking/device_drivers/ethernet/intel/ixd.rst
> b/Documentation/networking/device_drivers/ethernet/intel/ixd.rst
> new file mode 100644
> index 000000000000..1387626e5d20
> --- /dev/null
> +++ b/Documentation/networking/device_drivers/ethernet/intel/ixd.rst
> @@ -0,0 +1,39 @@

...

> +module_pci_driver(ixd_driver);
> --
> 2.47.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

