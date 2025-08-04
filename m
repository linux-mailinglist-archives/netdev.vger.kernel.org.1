Return-Path: <netdev+bounces-211547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B26B1A0A2
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 13:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AFC23BD6CB
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 11:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E999253B52;
	Mon,  4 Aug 2025 11:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mr8Aok07"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7E8246780
	for <netdev@vger.kernel.org>; Mon,  4 Aug 2025 11:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754307601; cv=fail; b=ueR5r5lhdbkck6Z6qKKwMvSrXsGmLZ1gu55eSaKpbiXOQjTYdTdZmFfXOqwY5ilfINjkOqohYPn0MeJ8akAadhBLCpqdJ5eHsEXvZnSmj+nxrvLE3miTc7+OlZpkVXcF41MhrEGqTaRaAq3W7yUvESHbusvPHfPtuWAIyCfOT/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754307601; c=relaxed/simple;
	bh=vXnZ+dUYUGs7GD6bSLqKyeYQoLjkU6FWR/ep9UKGiHI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I6Jv1H00lQC+aMt+C/Noeqh0gsKCymg/WugPP/eJY5lacgjUphoXFlmX9+ch/oPCVsuo97mkHfhlkZ/JNSfcj7gp5O7wiphDBg6oiK/sw6lcO5oeiU4Ezv4gIhkBaSxrmGhUsfjGgqZdvuinwPEblMZOA3G4+84tyz3pJrb21Eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mr8Aok07; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754307599; x=1785843599;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vXnZ+dUYUGs7GD6bSLqKyeYQoLjkU6FWR/ep9UKGiHI=;
  b=mr8Aok07sm8/xTDDhx5mBpOAy9hUnmUFOLS7Zgi0NU1G1iVybF+GOMZd
   9Kul9XPKYVjzsbfrELa5kbITwWdN7FGKMe9v8I5orIzeAfyBUgDtWPU7S
   NxkY2ynXpIBNgv+TOl+DShBjFdS1nGYoL0EKvUzqm6e4OxSFF0E0ZcEFJ
   Xag3+AJiW8VNqx24VoGluB/nLO/rFaj/09qvu/5oK+0h4TMc0JUNyAOD8
   w5A8ospGq7sDh3VRVikfIzSV286+54INujAlj5d7l0PtX1R5a3sbJNm60
   mQHm8eA4x45Pnun2CTrWlt1LhKHyvKOcGVHIFzgGGLmmW7FWHb02rNY8/
   g==;
X-CSE-ConnectionGUID: ssBdJInEQCqk6ZwXpH9aQg==
X-CSE-MsgGUID: 12cLF92IRWqWbkB1T653GA==
X-IronPort-AV: E=McAfee;i="6800,10657,11511"; a="67628700"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="67628700"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 04:39:58 -0700
X-CSE-ConnectionGUID: f3cTyudGQx670TwNmYYjgA==
X-CSE-MsgGUID: gzJL/afITFCbSyx/uD4zMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="163686772"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 04:39:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 4 Aug 2025 04:39:57 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 4 Aug 2025 04:39:57 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.70)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 4 Aug 2025 04:39:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LGbijyuhnJeLZY4MyMhu8QWkzBIccT82UGjV/3ULOCN6ysQlSjstP1ly9InWCYF4lxhcMc3TtkTo7/JhW44EbUoJQWR9RlMgU85Do06JWr7wnJ3l6NTQkKgs4lc5f5OokY2KcpQnyDfDT0tZtKeLb1gajEwsNqtSIkTRN6yzxuP6vWxaOjHszqtVy/kzTEQhUVmiDIWyTh/HUGgI/GzV6o8ZLGd+zPbx+nVU/cYpX7jO5805Fx+TdvGHG1DW5a/AUhjU8UuiCRP8eF6GigM4dGqTrU6vxAlL9VrLg4nD7YLb+iCDTm5ZLLmdc2tZu9tqVgLpqP2SIqWF5E56xiAhLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbKYl5SoBi6pgQct5JtusqZnAmn+Dy0rsAorWxHjCKw=;
 b=LMYyyy00VkL9Y8jwxdBoTzEjbkj/hUBrKUhgrEQKoFvNpHlJYzTML2p8wR+0Tn94aKNDWFadWjs+cyycx+bS0R1ZvGT8NvJD6ZsAaB4M1xVbNuNsvgTCpvnXFp5Uj3TpTwWpFTYiSF9GBedq88ASXysgKzc6wlwkNaJhK26x0iMTT3XZVt2K0N+kE/5cTNRcJbYd/itYgE9kl656D23RMUP2BCVLZMYzbcbV6rq5zcO1XHLtmqMpxdcrpx78Nalg6gwl6S4ZN3YaBeESgM4/TXP/7/eo4S8+8LJwdWSWyc75P1AvblMn3d1416nBSK9p47Gg0EzB8OM4fVY/aG8cNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by DS4PPFE901A304F.namprd11.prod.outlook.com (2603:10b6:f:fc02::5b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 11:39:56 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::4a8e:9ecf:87d:f4ca]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::4a8e:9ecf:87d:f4ca%4]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 11:39:55 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "edumazet@google.com" <edumazet@google.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"horms@kernel.org" <horms@kernel.org>, "David.Kaplan@amd.com"
	<David.Kaplan@amd.com>, "dhowells@redhat.com" <dhowells@redhat.com>, "Paul
 Menzel" <pmenzel@molgen.mpg.de>
Subject: RE: [PATCH net 1/2] devlink: allow driver to freely name interfaces
Thread-Topic: [PATCH net 1/2] devlink: allow driver to freely name interfaces
Thread-Index: AQHcAwju1ku13/ui80af7ngNXNUuGLROO+eAgAQmwpA=
Date: Mon, 4 Aug 2025 11:39:55 +0000
Message-ID: <PH0PR11MB59025732C1FB84E780AF0906F023A@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20250801172240.3105730-1-anthony.l.nguyen@intel.com>
	<20250801172240.3105730-2-anthony.l.nguyen@intel.com>
 <20250801131513.45a6274d@kernel.org>
In-Reply-To: <20250801131513.45a6274d@kernel.org>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|DS4PPFE901A304F:EE_
x-ms-office365-filtering-correlation-id: 41219c40-93aa-4c47-a1c1-08ddd34ba244
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?lKkoPZFwii7zMNwtrhCjNui8DXdPwX4ONW5G1ZlSQ+s3gYgT1e8Kp2J9QxW3?=
 =?us-ascii?Q?vbhk3JyvtQM5W5NGYy7CQUZP6rZVsBc33pV094HPZCW6+aSPSUFYGQr/Mjc5?=
 =?us-ascii?Q?t9BTXqyyulJstftfCtrGu5M0CBQX8rHPrs3aNMfYUzIctoeovsFPVa2cUCWj?=
 =?us-ascii?Q?8GxKPoqTMiigGVZDYP/1MKQfZqvu0rO21pkPgk005LyufKXe0GJ/OpGS7uQL?=
 =?us-ascii?Q?ZyGW81Y2r0CWIbeEwx5Pi7hFvPcPS7kR//OvCX69Y209stVo2kBbFmzhrBSd?=
 =?us-ascii?Q?mgg1/HCw7N653wXok75tYTIFwhOlws8QFmItRaD8P14HhV+MvXT75/mukvT7?=
 =?us-ascii?Q?n0m1SBmc4L3oPZKSwkuzlSiE/tNvk/zMyfFCXEQPf5x7b/feNZNs3H46qXpv?=
 =?us-ascii?Q?EDuM8j62+3biVkgPUp9TvM7LRNhadNCVS9TuvSeHBlLl2F7zSfxnl5fk+5zF?=
 =?us-ascii?Q?ay3aYAkqIkoxihj1j3G7WUd//NoysRNFqPG3I30bTb/XLAYG62FBZ/k73LSD?=
 =?us-ascii?Q?nuDI+hbC1YAqTBywl1IeJVLYSn8LM5cMa5AswGG5f3DwIkvowYXgWMWDu23a?=
 =?us-ascii?Q?3GsoJCKd0XOSYlQZGHzszmfhOqbUsWVN7LctnMSCF7GwW9wZ7CeJixH/zbir?=
 =?us-ascii?Q?tsjF8u79yuonngg/9Oq5vRGOPnOupDNbebhp1WMGQZb58PHW8Lo6McFjbJti?=
 =?us-ascii?Q?b7JeuNMa6DCvj21Cb5a/NHU/FQ3kt0tc6katY3BOb0TcNySJVPGC5MA/ttEN?=
 =?us-ascii?Q?7Dpj2vEALFf0f41b1FTEW6TPgeBc0RGvZdmCtz/HvrAne+XxWOMUbJePN2xh?=
 =?us-ascii?Q?5R85EXqqcaVS3MbfsKOStzP/dbGjAavB6F2qZFkfsYd/pVbQbZkaxhqybfXk?=
 =?us-ascii?Q?BSpfE7L5a9BqUGiqRpKpenorHtHREzs5QO54snZJNqffn052MOzqeXveT/UF?=
 =?us-ascii?Q?yKaBZcQqieXrf6ckvy6m1yK0iO+fNW56No1NNnTzPforkkzl+iUE5hvnC3nJ?=
 =?us-ascii?Q?GbAs7v+0UWY7WEEYbL1BjOcuzBJCyF/YmqUbvMEjBNR4N44reT9Wei6/GgLT?=
 =?us-ascii?Q?KIugDIxalgbcJoYdxVXy2g8yHRKm9CcyPFyukYH++b9t33XyLHlhYLs+SDuV?=
 =?us-ascii?Q?aBxrXVVpNX0PxxvRG9SGnYhk7Sja+ypP9apahYg0Si/Li59979EYrv1Rw+RI?=
 =?us-ascii?Q?Sy0T2dxeQJs+cNilwoPNlpTDDnltyaBQsaS/gsEdfAo6RLAM13TgmXnFqGeV?=
 =?us-ascii?Q?9pdxpnFqaCd27/LeP3y1okbUJ1Y1ms1aWhkh3ZdA7vcJqXXrIyl+pHJU0Ze2?=
 =?us-ascii?Q?OKPx0tvhfIOolYkmcburC0wHBvoQRnxr/caZgXeDZ/jcxbL8WUV2PPPqCf6B?=
 =?us-ascii?Q?oDN+ztsHV/271Lyrt/M/8VZH1spZNsk5cUF733k522mj8wl6uG8oInAi8KeS?=
 =?us-ascii?Q?SiNy+rRsqwHoIXrG9wnaFoHe/+2U23TRATzDqNpay6hbFvjCfsbVcg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9PWjAKnQIOyvl9If/bqdnXGfxyvBTMPOycZR/4w/TFtLr4TaKWhlZHHQaRo4?=
 =?us-ascii?Q?ENomqZKITGT5YHUzs5/qTfAvJIVXZvnEczRL3i5gbHYS9P+sQpXsF5r6Ga+D?=
 =?us-ascii?Q?FhgRmPCDNU91adthuhNZrEOnVsaxK0yg9l/7ysIQSMY+OAedH882NwF16D3j?=
 =?us-ascii?Q?RahqDzJMKwRGAD7Ryst9TjLGbxD0wfNQaEZP56aG3WibnzGjvQXcZOSmXIz7?=
 =?us-ascii?Q?kbpD6b4tiUjUxNytL1jI3cqUd0AsMIU7ehoXsnbdVBL37AM5VV9Ym45Oza4l?=
 =?us-ascii?Q?FTmbySCGJ6OrdRyRQ02VUMXTRQ2hvQNUSphvyVU8v7rIbP3aThfO/iq0FWMl?=
 =?us-ascii?Q?LoxWYZ44oV4XGLcmgWdiP1Az8xjyLntSPVlqzKo8h/xHan6wE9/T0EXzy4+C?=
 =?us-ascii?Q?gbaKKUpQ8M0WMvHOLxdLHiMpon89KQJjnxxhDLkbTz6ahDyjBsinS9D2Bgu0?=
 =?us-ascii?Q?90L5XO5ivg7gS5iwU/uXnKUYjCiq/LmLLt1CMQVvMzQfoi/Igz/6Vo5x45fD?=
 =?us-ascii?Q?Atu/AEHAr0vloFzyHfpwqGEBIcl21kBoSsVl3UPnhbmLFqCmHHsXMNvpAsa2?=
 =?us-ascii?Q?bCjjZq8J95heg29JNyGhKZsIeqtSeaHWngmDA53ObZ2sMajr6FtiGum2+U4G?=
 =?us-ascii?Q?qjEsWWqESUUePXNabzTaNX5v3c2bqnWP2NZQqdookGqheRpPPmeQA9dNoNo7?=
 =?us-ascii?Q?PXtV/rGw5yU8sRRr+yDijaUsYARVporrvTKuNO1qfSRcdyqsKw3agCskI+Cy?=
 =?us-ascii?Q?XjG4B/3rOlrVFjU9QRqWgwvDC99Lg34yjy1BRS2vDuMXNA1Ow+SIBbYIxDIG?=
 =?us-ascii?Q?NyUIj6FA3od2fHMTgShxYN0E26GwPiEtfk/ZvCB060HmJFqBv2QQmaiHaeDn?=
 =?us-ascii?Q?Ocdmp3+WEdzzHTRZbn16HT7e1btauGLFjECl8ZRFA1/istLQMxIHQiJS7s/R?=
 =?us-ascii?Q?DIkqp2pIT0eMrmsYgWjSNdlEVovb5ACTphrPmAQZuPlULGiLfGcykYPEF7dV?=
 =?us-ascii?Q?N6Mrv3wGfMIe2LvmKWdKJOa/T+vstYhEBFSlItv41lIRLLC9VuHyiO8bvC+N?=
 =?us-ascii?Q?NlSKNnV6j0p1h9MqA/NkX1WiMss7FR4sf/PLTcTbMHnVHQ6OyPLvLzFhWh5r?=
 =?us-ascii?Q?bxAAR+zg03i0d3o1UylHkcjdFgGlNTYgbSO4GyI5tDe4xaWOAG4YHxGQ8rK4?=
 =?us-ascii?Q?rxlTMyqH/kkhc+ZcTz00jmAQqN9jR5dwixb+4zcbQI5qlwhcleL3lDVoAApS?=
 =?us-ascii?Q?Ilr9XxwZTHz2rFuR3Kar4YV2KCjJALBLmP6G5anXTKw+ekILJhiCF5OTITGZ?=
 =?us-ascii?Q?FV+jv01OCF2Ni4C12ot54pNb3DX4r0vNtjlUvQGagDEXWLd2CeqyfpJdi5Se?=
 =?us-ascii?Q?ULvJGTsNDgTQO9XIGewryHD8IK7BR4tSTZNgnf8jG/RrA8WlcxXmYSpiorB6?=
 =?us-ascii?Q?/kzRLj0JyydI2l/uzE+6BsRI2rnoOqvEgQIQ5tyIZeiJOocq9bAGp4Y/qzEs?=
 =?us-ascii?Q?dbdV0+gbZB9DgHhfyhKdXgYDKamAcDHLziC9LNg0nSeYOd+PKDHO0IMmNIJb?=
 =?us-ascii?Q?2GaOabsqoyusfF+WOSq7vGhOy5/z2+U7lwE1yjlI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41219c40-93aa-4c47-a1c1-08ddd34ba244
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2025 11:39:55.4322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XfOkeZ32SHBiJIAMwWtGk9ShFDKgeEQGBVJaKcg1lf3qePb3d/kPTQS4Nb7awlPSdYh0PtHfoz7F05B1lHIRxxCcUtPs4kaozcp7PlyybKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFE901A304F
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>=20
Sent: Friday, August 1, 2025 10:15 PM

>On Fri,  1 Aug 2025 10:22:37 -0700 Tony Nguyen wrote:
>> Subject: [PATCH net 1/2] devlink: allow driver to freely name interfaces
>
>The subject is a bit misleading.. Maybe something like:
>
>  let driver opt out of automatic phys_port_name generation

Sure, title will be changed

>
>> Date: Fri,  1 Aug 2025 10:22:37 -0700
>> X-Mailer: git-send-email 2.47.1
>>=20
>> From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
>>=20
>> Currently when adding devlink port it is prohibited to let a driver name
>> an interface on its own. In some scenarios it would not be preferable to
>> provide such limitation, eg some compatibility purposes.
>>=20
>> Add flag skip_phys_port_name_get to devlink_port_attrs struct which
>> indicates if devlink should not alter name of interface.
>>=20
>> Suggested-by: Jiri Pirko <jiri@resnulli.us>
>
>Link to the suggestion could be useful?

yeah, why not, it provides some context

>
>> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
>> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>> ---
>>  include/net/devlink.h | 7 ++++++-
>>  net/devlink/port.c    | 3 +++
>>  2 files changed, 9 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/include/net/devlink.h b/include/net/devlink.h
>> index 93640a29427c..bfa795bf9998 100644
>> --- a/include/net/devlink.h
>> +++ b/include/net/devlink.h
>> @@ -78,6 +78,7 @@ struct devlink_port_pci_sf_attrs {
>>   * @flavour: flavour of the port
>>   * @split: indicates if this is split port
>>   * @splittable: indicates if the port can be split.
>> + * @skip_phys_port_name_get: if set devlink doesn't alter interface nam=
e
>
>Again, we're not actually doing anything the the interface name.
>We're exposing a sysfs attribute which systemd/udev then uses
>to rename the interface. From kernel PoV this is about attributes.
>
>>   * @lanes: maximum number of lanes the port supports. 0 value is not pa=
ssed to netlink.
>>   * @switch_id: if the port is part of switch, this is buffer with ID, o=
therwise this is NULL
>>   * @phys: physical port attributes
>> @@ -87,7 +88,11 @@ struct devlink_port_pci_sf_attrs {
>>   */
>>  struct devlink_port_attrs {
>>  	u8 split:1,
>> -	   splittable:1;
>> +	   splittable:1,
>> +	   skip_phys_port_name_get:1; /* This is for compatibility only,
>> +				       * newly added driver/port instance
>> +				       * should never set this.
>> +				       */
>
>Thanks for noting that this is compat-only. I think it'd be better

It was Jiri who instantly suggested that note :P

>to consolidate the comments, since we have kdoc..
>Move this note up to kdoc; or document the member inline:
>
>	splittable:1,
>	/**
>	 * @skip_phys_port_..: bok bok ba-gok!
>	 */
>	skip_phys_port_name_get:1;

oh right, it will be moved to kdoc

>
>BTW the name is a bit long, "no_phys_port_name" please?

sure, i like it, will be changed

