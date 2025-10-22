Return-Path: <netdev+bounces-231917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44251BFE9D2
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 01:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC1163A1E2C
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 23:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B9729CB2D;
	Wed, 22 Oct 2025 23:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H5NrJaZD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFBB22A7E9
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 23:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761177246; cv=fail; b=fPv500EQikAcFZJJ29cKFKoHrF1PhDsEAEfKSOwe/NjPd/teck7IIm3Z3kkaava5GmKR0BUYHQmWbyMrplOQbqlBxiDU0p9EijodTz50xozNP/zUXx798fgjyHeFZTiiy5nuzv/Bvd3mr6tSv4WU9MHC6rgfBsM/UD7ViDlseIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761177246; c=relaxed/simple;
	bh=H/bh3p06YncA8z+FJTkkqa4z1b90hmn3KE5+OF6lzAI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dGzPP/KymSmigXnwuV+Ywv/4WPCMwhoT4D/eDosAFEQWiL4fBw0rtQhVjBFL8HTlU78lhRXeKc9R94OhMJ0bDgfwy7eOfmB3d4S55/TaeWaAz8NLo0O4w2DIm/Wx8kh8C/0KH14qglLdQ9DjoAnMcW8YOf6AgFJlCVGfV9HUbMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H5NrJaZD; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761177245; x=1792713245;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H/bh3p06YncA8z+FJTkkqa4z1b90hmn3KE5+OF6lzAI=;
  b=H5NrJaZDwZ/frCySe8xPXUDRrvFvM4pjN1Rg4iWxxpdZoOK1B44Il9no
   PdIuMjgjWXgF3yzNYGOHaFL9Ih4UhXCcwMY3dyur4yYBtwpk7HP/i7muL
   YdC+sKquthJVbvsjnJDTOgp4OZE7Ys1q4eNPfQKp/VpEYxmAClxgdj0IN
   Dct2aXBT+56jEtO2DnD4n7VHX+jXMGzWLyf+jc0PCcWups7y/rtDzEULd
   Lg2qkCFnCIcF8y1jD0D0w80iQuWfEPKCj+n3Z8L7pIFyg4iSTA41HQgfh
   S1tSiyhn+iIn4GCI5lyeeLdYSXQgQxiz1H33w4uC3Azo/y46WjGcx3Yee
   g==;
X-CSE-ConnectionGUID: 1sPz1k3WQcuIBZdg9WhH2g==
X-CSE-MsgGUID: h04Ku/3ERquMWB67DKOXBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63241299"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63241299"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 16:54:04 -0700
X-CSE-ConnectionGUID: DNz0w1nnRrOeiSzjuViKng==
X-CSE-MsgGUID: 2kHzTu6zT2S2dkCS+D5ZZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,248,1754982000"; 
   d="scan'208";a="188293321"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 16:54:04 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 16:54:03 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 22 Oct 2025 16:54:03 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.50) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 16:54:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODx2KmlXF1F4xMdFy4Qv2BpFpQ3ZFrSyHWUAE9ARqH89IYuwUYu9jY6ScAWRwBN9li8QJCrCAjCGCQrVtL8qEUVpEb5Vs7vTeUnWjZ7RfAVFS1UXu2N0NKmKoc1+xAFM1Sfn9bl6VhSVPu99mTghvSQl1Gd07pGVaUoRP87NQsuBtibvWjRcmZ3eBhYbbQz0Ywc3GWfLouUWrtJDFDhk9XyzOpAv0Ed/kPhFh9/O8eVBvx/rhHNQTkbYv4OQssq+bbFcvb+RYi8lqplD/bT2gU1qMJFHm/n5HkPukRyFac2I/NN+W7STy23KF6NKzJeGFYhrY6aiXcAHJA1CF1iN3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqzsuhe0QNKGTWN1J1/SIbb3SvoozbOzT7ODnBaCrCM=;
 b=ILeWUPYKHsAF7JKbzpHsZ0i+uqeMmY2ZhzGhCA6XPVvmMECVh/Jow18meEs0VzU/OgZVDDRzdf3WMUDrTZj4i6tJRQAVGVSPPtdQqcxGp2LLyinMUSRbDVrEKK1gQpPhIdmjvPQSEGWGo62UjGzJE851AemkaYFyqaxsYVK4qGYbM53nVBQzA7QzUTZqLXZMHu/4YvV/1COvWRERWMEL1Pm2NCfyEuZf9jtiysGFSuEkGgGuPHN2KQ4QAQB/MgExL9ohIPDlUfLf0qwcXts5WElNuJyZICMYPOBtmrzeL94Acz6ssLtKowGWJSnv0lRxTmpvhjjU4gop1YcwxuCckw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by DM3PPFCBDC4B878.namprd11.prod.outlook.com (2603:10b6:f:fc00::f4f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 23:54:00 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::241d:ef75:baf6:dfe9]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::241d:ef75:baf6:dfe9%6]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 23:53:59 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: Michal Kubiak <michal.kubiak@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "pmenzel@molgen.mpg.de"
	<pmenzel@molgen.mpg.de>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kubiak, Michal" <michal.kubiak@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v3 1/3] ice: remove legacy Rx
 and construct SKB
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v3 1/3] ice: remove legacy Rx
 and construct SKB
Thread-Index: AQHcLf8WBRzHVUpQ5ke5qJLLgIIfQLTO/qvw
Date: Wed, 22 Oct 2025 23:53:59 +0000
Message-ID: <LV1PR11MB87904288260EF07A2D4A589C90F3A@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20250925092253.1306476-1-michal.kubiak@intel.com>
 <20250925092253.1306476-2-michal.kubiak@intel.com>
In-Reply-To: <20250925092253.1306476-2-michal.kubiak@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|DM3PPFCBDC4B878:EE_
x-ms-office365-filtering-correlation-id: d9f88e1b-bcd3-4254-1131-08de11c6455f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?As1gWepVshlSHq4y/XqJ6cUPW2bKO6XMluvuGVMxuteA77CfWbg2VSfiPw2V?=
 =?us-ascii?Q?KKsAA6uhnjqZhuy/dt6Rvh6TV4Y6yH4FfzbBB1btlraHEA8RNcz4AGaydmjN?=
 =?us-ascii?Q?UjBI5/fAobA2IG2jlAiKVoxG2ytf5y2J8gcXvjsF6YjKVMGXdK6Of4XW8mR8?=
 =?us-ascii?Q?/iztXd73hqRcrH5oR/6qaiR3CW8hbCdKNJ/cC1jubR+U7F2GsSqryxL4OtWA?=
 =?us-ascii?Q?3QBz+ax1eoK/tFaes8RI0z3YLuxD4hjzj12URAgSfQAELVfJ3Op1VIlf4usK?=
 =?us-ascii?Q?N4AykM85PlaS4yVpFl0aNZ/W/twGEYGDJoPbWfKQ/Zt66DGA0SWUhTeqiRFs?=
 =?us-ascii?Q?TuQke47Kw8/tSW95Tn3hUG2aBxYNGaShCmV8X5SatIKgtMpT2EeCkxvG3/hk?=
 =?us-ascii?Q?LnTNOCGJ5/XKGUxLJcGdYaocJkKPSHek1EAmkgQOV1uP44bPL1E9cbkb6Von?=
 =?us-ascii?Q?sWwxlcZ/tDo/FyHtqmLM+BW94ZKjJLdcRX5yR+HQjgsylL5jXf6o5x86dfql?=
 =?us-ascii?Q?ejlYTWCukVBBfQClb69tyzKbbqcGtNcrXS2O0+4myu92O3bSvvgIQp+nc4iQ?=
 =?us-ascii?Q?KPZA/W24Nx9hai5x1foMYG1uiaf39piH6M3qjHTn31Q4+x+xoXf5wcwOF0cI?=
 =?us-ascii?Q?nehnwoeuP9V19TCTSupLiE1MOunH1U+yexvqZFabR/AiMl6HZ5SgHopazpPI?=
 =?us-ascii?Q?8hylTWQ7HIUXAE6G8kTCbfJ2jrSOOtYp8h+1UT/bFvN3bpaEB/q9/IQ0Qf3U?=
 =?us-ascii?Q?ZLn/JqPwyAuP2qe9HG6eseq8pCBd/uXRt+Ab0cdBJMHMUPN7ONL8ZxHdywY/?=
 =?us-ascii?Q?kwE2iFUrTsvbOvFj3LpaqxLO7Tgc/oRg4cI7KG0BfBVjZu+QLNz7hs1nRAz7?=
 =?us-ascii?Q?msLpEDhWUJ3TE5mTqILPP92vvlTfHw+w+zK6K4gZrI8F/GAtGU7zoihCP1iO?=
 =?us-ascii?Q?xU09DI8BPdZw40MiKmJdqE7cYhrBKfJhvvwa9PF27k4ywwA/DIzjg28EIhmB?=
 =?us-ascii?Q?TUoVhEZdlb4dxcL9AkJ80P0VDehQ3Zgfxz8UvV1+5lJME6jlX21cI8VNw1e6?=
 =?us-ascii?Q?RUrShD2yAK9JmZVNO+xsw9F4IKXWAi9+D/O1NCyztCv89wdoSXyLM4LVj93v?=
 =?us-ascii?Q?RrzDpB0CbwnPmw/LZ2qkMdYUtWbmLk3aKJowUrLzksXXAbCJzdv4ewKUyJIp?=
 =?us-ascii?Q?fL+6HSzF2+piL67tGg5Do3j0weJyHhY/NCX0/n7LsV3Q8U4wOcQD/fOAU/Kn?=
 =?us-ascii?Q?9MZotkQv6aT8hZfqJbbRtt7gvzn1T4gFvv4NMYNDfVWsHHGfh/AKmnaTQtb5?=
 =?us-ascii?Q?QSANxquF0Gw/RV36Xf7DPl0YmoFiRUkA7W3IWJBtNibTOX+pBuWirZQvXri/?=
 =?us-ascii?Q?d7e1RRREqhaIhX3L7EugRKpB73dO8383gNDys3yV2kSG8FW/0ebbAiH7zBUa?=
 =?us-ascii?Q?CYqOiHN+aEXSU08CtbFRc9VJhjmTk6AUdpEv1rC1PRCSX5/OcO5vVN5IHmRa?=
 =?us-ascii?Q?lzWnEJDdsGYkm8yGpcbUlyEBewU21la5ky8Q?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zEO9VwM/JWdbOqTeXgYt+593P/xhXXfmWSV+v4WyMEe/TLWiXNEBa/CVgQAy?=
 =?us-ascii?Q?TVgSzbtS/NUBhzUJmA+vtnHrAagms5RMeERnuLJMJz1RwUI4XsQSZ9s8BXBR?=
 =?us-ascii?Q?Erx82dSHV5YUOaMlc1u1te+EmT7BhvKqvbqG7AoTsOcuaX8mWcsMoX+1rl26?=
 =?us-ascii?Q?+QzlrvP6NSUZ7YquSCeQaYp/VOLQm3XaFccuOLtvPX/FLdtnNgDPSqkmfB6k?=
 =?us-ascii?Q?TSJbDOE8LuubOdwfr2hz48AOPQbo96qLGxMSsPNP0EY/2drUI72VHdXVSYDd?=
 =?us-ascii?Q?p4ljYgVvvd+CWoYthPi3g3Q2/nu3w0VJkkJ0UXwebiVs31ilRDWTCcR6gC/u?=
 =?us-ascii?Q?oB3Ycbbfwz4sahXsvszXt/25vsgwM5nJB2ZrzlTNKhhgb9c4jH3qNV/pnkRC?=
 =?us-ascii?Q?77A4oJIn5WlFq7XPF+PLqP/c6HJwzhymVvH6fXhk6h3BGo4Ls+DlFXdbjFPN?=
 =?us-ascii?Q?4Mt4lTgr9ZIRsn8tE9h0h4uMpSlIjllZlI7dnZOxO5RdLeD7M8ws5/GDFZnb?=
 =?us-ascii?Q?4MYNHrli7mttfiJjJaWquT3SyhGNFcvOv/dmshZOMLVuDW9j+D18ElaBkk2F?=
 =?us-ascii?Q?j3VbH/Z0jB+f3tXSnzGxC/DdsrM2+HtEBqxQTuoNQ2BnOEWpVqcabfryHngn?=
 =?us-ascii?Q?9c75xQLqE//JkPo1lqQLvzhmlVdXZXI3F4EhKfOioIkH3xuCvExG4gkYszAq?=
 =?us-ascii?Q?s98tuB1roSYXQwW0jjPpntqqbv5a5bndqIhclona6daRKP3JgXCCBp/vb2ph?=
 =?us-ascii?Q?bfe/pqykkreFlBaeEtdPBclSY+K7QrjpXbpkSGN7F5R/yvufVMEyzb8tWYjt?=
 =?us-ascii?Q?vJ53gceC61Wl4djvC7mDT+Y3+J/TFzYN/ijYj1mIjg0r2O1CcL+sBEp0blVO?=
 =?us-ascii?Q?KGIMvNNi7WBhe78SOyChFLMvjYtIsOe1kUZbKIxV/l7pUoUqam6sZL2B3rI4?=
 =?us-ascii?Q?THpsfngnw7MnpEFgLOZTqOIPyesKUGlK/wZ5tykwKFExFrMtNR8hsU5WoBRi?=
 =?us-ascii?Q?N1DHgqa9HDYWjvMS8NkZph1Pjg46jUpBlLVTncJURTAR9B3qCBOk8ZlA2EGR?=
 =?us-ascii?Q?bKmyZhRe2OGM7V53BdEvXWXGn9lCDC++7CHilrhOqsANF9RAL04ZfqYLa1aU?=
 =?us-ascii?Q?xKZ0gk6a2kWHGXo/WbqkzLg6J/eikyuINB+YkUn2wP1mawVW4LSMOAnMHZ/m?=
 =?us-ascii?Q?2zn6klH+eTZkx0XZD3xGH4kif1Yz38nycn0pytVy6nO3Bjgx12IZhTjPc1kB?=
 =?us-ascii?Q?kKvC1l796GPGK6p1jwYXLCpQrA/5lLLg0quVdYj7i/wsXZ4yFxkQq0TcyHAA?=
 =?us-ascii?Q?ZKbLTh3mAeUuZiSoKsAgZzkB6i9f0DmIrM/KPSLQI6IiomDO7pD41CWn49N2?=
 =?us-ascii?Q?98kDv8TZj8kQFXdiOx84KAFi3+kc4t8x8TWZy399vD1Th1gmtkRoIWUShWI8?=
 =?us-ascii?Q?BY6lemJvZuwyEGkl6RnnyN4SiEtta0UZTUYfQQAWqG85E6dQuG491AYS3aOE?=
 =?us-ascii?Q?tR/GCBtmpSRcgs+PeYs6nQNyadEgLUclP886aEJRqlS02MTTltMLR/pf3jwF?=
 =?us-ascii?Q?9yOGIKRvY8pjX2tB4A97mAlyRFYVUtZiiNytPD/6VlzJkUmEt4vc7o+2vXf5?=
 =?us-ascii?Q?Rg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f88e1b-bcd3-4254-1131-08de11c6455f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 23:53:59.7635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QdkwfBcp+M7or6bZicDpGvE+jqGG6XR6hib8iJJ9LT+uRuCqLzvXu7mYMLedtqKA3z178BXftzTPuH2pxrsIugH9HLNcCZzihq5QHJJYloY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFCBDC4B878
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
ichal Kubiak
> Sent: Thursday, September 25, 2025 2:23 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>; Lobakin, Aleksand=
er <aleksander.lobakin@intel.com>; Keller, Jacob E <jacob.e.keller@intel.co=
m>; Zaremba, Larysa <larysa.zaremba@intel.com>;=20
> netdev@vger.kernel.org; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com=
>; pmenzel@molgen.mpg.de; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; K=
ubiak, Michal <michal.kubiak@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v3 1/3] ice: remove legacy Rx =
and construct SKB
>=20
> The commit 53844673d555 ("iavf: kill 'legacy-rx' for good") removed the l=
egacy Rx path in the iavf driver. This change applies the same rationale to=
 the ice driver.
>=20
> The legacy Rx path relied on manual skb allocation and header copying, wh=
ich has become increasingly inefficient and difficult to maintain.
> With the stabilization of build_skb() and the growing adoption of feature=
s like XDP, page_pool, and multi-buffer support, the legacy approach is no =
longer viable.
>=20
> Key drawbacks of the legacy path included:
> - Higher memory pressure due to direct page allocations and splitting;
> - Redundant memcpy() operations for packet headers;
> - CPU overhead from eth_get_headlen() and Flow Dissector usage;
> - Compatibility issues with XDP, which imposes strict headroom and
>   tailroom requirements.
>=20
> The ice driver, like iavf, does not benefit from the minimal headroom sav=
ings that legacy Rx once offered, as it already splits pages into fixed hal=
ves. Removing this path simplifies the Rx logic, eliminates unnecessary bra=
nches in the hotpath, and prepares the driver for upcoming enhancements.
>=20
> In addition to removing the legacy Rx path, this change also eliminates t=
he custom construct_skb() functions from both the standard and zero-copy (Z=
C) Rx paths. These are replaced with the build_skb() and standarized xdp_bu=
ild_skb_from_zc() helpers, aligning the driver with the modern XDP infrastr=
ucture and reducing code duplication.
>=20
> This cleanup also reduces code complexity and improves maintainability as=
 we move toward a more unified and modern Rx model across drivers.
>=20
> Co-developed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h         |  1 -
>  drivers/net/ethernet/intel/ice/ice_base.c    | 23 +-----
>  drivers/net/ethernet/intel/ice/ice_ethtool.c |  5 --
>  drivers/net/ethernet/intel/ice/ice_main.c    | 11 +--
>  drivers/net/ethernet/intel/ice/ice_txrx.c    | 86 +-------------------
>  drivers/net/ethernet/intel/ice/ice_txrx.h    | 16 ----
>  drivers/net/ethernet/intel/ice/ice_xsk.c     | 72 +---------------
>  7 files changed, 6 insertions(+), 208 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>

