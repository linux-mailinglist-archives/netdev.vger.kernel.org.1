Return-Path: <netdev+bounces-270922-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBH6KHFGwmnvbAQAu9opvQ
	(envelope-from <netdev+bounces-270922-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 09:08:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 427B23045A3
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 09:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CEA113039FAC
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 08:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAC73AF648;
	Tue, 24 Mar 2026 08:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PIfO2hGi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E4134753F;
	Tue, 24 Mar 2026 08:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774339614; cv=fail; b=IhbPk79sJC0+hFiGg2PxpAz0lUsFeZ9DC8F3pMzFDmkk8sRpws1Lha4IVBbr9sVwx4y+/B8/5RLwxlOIg1hQSbWZvXAq4HK7b0zLZd8Svby9Gv7fBuB8+kGu+zlJYS3ShvaqWfnfJjAdSFGcas6ZpyHEtJAY2o8Pr7O8r+qkZlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774339614; c=relaxed/simple;
	bh=xPfdo/yzWNAr+lY95nD5BvNQ/Ht8aTgdxRktP4chJXs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UWqjBrYWlFhH4lX/qKoooTQK+6G6OJldYHbWltDF3r2BIh0ie9OgS3e1ZCyDudF/c6rjR698pcTpQ/Bd+7xwLayOUtFgu/rtIZABfHEoyRXUZYG9U5JDk05vttn+XOcBt/bzUCLC+1mQjmVNrtTGGqFjeChr8qvh0v+AEuQMOwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PIfO2hGi; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774339604; x=1805875604;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xPfdo/yzWNAr+lY95nD5BvNQ/Ht8aTgdxRktP4chJXs=;
  b=PIfO2hGigH2Qj9vCzHJdZS+ivxqOxISBRxbiS588tvpTCxUEwnvDEHHe
   rV6kdeV1rWJCKTi/wHqG3eeqxh7V4Rk3cQEnpwlh4mpAwpLN+FvAs8Ju4
   QLph8zGXKhYQ78EEKYaN7K/85s82WnL9LRPdgsAn1mLW1pz1iuMra/TXR
   rK+1GO+pdlWI8K7kuaNC0ibEW1aMSstPyRo2asaXOUPxkcPEwuH4N4Ljk
   pUHvIrFzeZlcsMhAsmNKmUbMtciUajDtKOkSLKOmWq4BHIhz59OAhKbNq
   kYxnWrd1Z1oF6mllYJbuvoMhm7pnu30a5lkKTV+PBXGk5hbgSPwfPW1rm
   Q==;
X-CSE-ConnectionGUID: HGgwclm5T0ejY1rGHYKeNw==
X-CSE-MsgGUID: 6t9ifLMCSvCNZdfRYiA1aQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="79205363"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="79205363"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 01:06:43 -0700
X-CSE-ConnectionGUID: vMd1eVWHTGuZjWJXQib0ew==
X-CSE-MsgGUID: ovm8Vck6TZCbUr0OHZWmHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="217715038"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 01:06:42 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 01:06:41 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 01:06:41 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.30) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 01:06:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEd3nt/vQRf+UmlC4Az9UEjukmsN4u7myEfqraK73EOnQrS14opDYOzVCD0X5wW2yyXlBQp9t916inMpbMb+dIIscQRYoXIZquuM7aDh2flruYT1k09kzqMzewE/uIX52p1Rekl4AoRNFQcNZr8Z7MW0Zmh1rneTx8Wo7a3F/MeJJAI+p+HZzA4CamgegGB1IviWTqd0liLv68yUkhEJlx9T2s4A5uF9rYEG6vJjKD4oB1TJdZw1aAaZPBUJqxudkCVgKMVfciZen0Ks96RPVnzC0ka9hp6IedKb4IPLpGuCYtvug99lRbHLofbvJX4mEqK5OWbvvNiltHDUhCvjvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXHsgDLE1k92vwWDqzHvB2hsBMVCqDoub+keIp3ED40=;
 b=S7BzxXNdRHQvNs4w04sJEEuLybDIgWSjYExE0XI1xDz1gaCaKN6rXi9eJ7Lw7y2nZU3+x0ei0DPY8cLTgFavS336wTCm5w6CwZ9dQqXzphSHxMBbOfcV+cy4EZSesZWx7YvyiKBej86+8sj0WXPDgsOgXVMXOUhK+8LNUKXZ2sGAgsxudKmaylQaQTqhBMuI3s8Gf0+f8cLPHvylO3ffK+aYQyoESjh/cYCeMM9c8KEj17UxwmV2oGNiWsOL2Hpx/mXmxftq9T3+SPTOa+PgM8Ejzp9B/9R1zTxf7yJzGS6xkxOU9A1XaqU1u4Q6xxdRXt14NMJBMAQyrrLsRJTKFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CH3PR11MB8137.namprd11.prod.outlook.com (2603:10b6:610:15c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 08:06:38 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9745.012; Tue, 24 Mar 2026
 08:06:38 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Matteo Croce <technoboy85@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net-next v4 1/2] e1000e: add basic XDP
 support
Thread-Topic: [Intel-wired-lan] [PATCH net-next v4 1/2] e1000e: add basic XDP
 support
Thread-Index: AQHcuvL2ls/Zpu65nU2IEljeWVhcO7W9U0KQ
Date: Tue, 24 Mar 2026 08:06:38 +0000
Message-ID: <IA3PR11MB8986EC18B4FE10649049AF87E548A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260323182823.5813-1-teknoraver@meta.com>
 <20260323182823.5813-2-teknoraver@meta.com>
In-Reply-To: <20260323182823.5813-2-teknoraver@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CH3PR11MB8137:EE_
x-ms-office365-filtering-correlation-id: 51d7fdf6-82d9-4df0-9da0-08de897c46b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|921020|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: sawJSEjEYI5a6kytpzHHJ8uysFRDV+u7nPeYW4iFUxMo9pcwiuPweshO6IM4ZtVp8cn2qeLG8I4/3096roAbHXdSi2mv+B27C0SHg+45PGPACop3gH1HRXyCPz1mQ80s2ZfI23w4WkC2Ios1NJQXo9EJI2YI1BYSrNFLTxzEJ+TNxpweAw4lRX9Fnm9DD12wuL9dIuiiUQ69RTUM0collQrw49VUV/zQvE35eyCiClKzUcm1MVmQhy6AXQGy+Vii+hpvcme6OnYUG32t0PCu1vygFC7N7Jl/GEH9g6m4to4DOyo7mzJTraBZ5GVkH0LJaKTEEby2AS6dH+QHpnNdb/9KC5uaHyhtg4Lmw8j4h5IAwOdEqoICL0xhyFAZmFShVT+cXL72rBit6uBIlGBmk53F2fovmCPJtCB3nLU14UNvk+tZvyslRCBF4HnJQF0E5bpULga0tWaWy8O5ehz1vL+l4P8hsVlZJIn16oD1zs9ogW0e1a3dEq/6muHx9kpGZjpr/ulWmQDx5XONZ8xzSrirwrUzXVyCns05yREOE2eaxnRtfdOjXqEmsDXoWFsHIIvNAlfcNJaDGeqs6XFGK6qjUSy5nbunZqZ6fQWh99vCTocZEeO0/+NPnkzldCms7h3T+z0q1Bh9T69jh47IXldgk5LUiXDoEjHYojbV7fbnGmpX5K7z6yYqNJDRUProT/a7ggVC4TTavbh70KVQvZAx6Dqat0+U+yQPmj1hZys3Tchz5KqkjEaRTD0/mBTHODp2A324/Wqp5BJEo5Q6ixLTFpMgDwBhq7M2z1soDHsjuLH4KKDF26tYNDnvEWXz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PFb/b0+a8E3l8c/pJwO+D9+z8PszQxYUXSJrhcVE5YpVeBu2L3baB7qSpMp0?=
 =?us-ascii?Q?VQJvaT2yGLnovg056I1kFXvd0IORORbTuEHZ9FyibPSd2xQeLYssD+xFBDjx?=
 =?us-ascii?Q?zItEDZN5ufifLCn+zTOpSzlSRByLmxG4NSFboGAylB68DfHDm7D2SHhSdl7k?=
 =?us-ascii?Q?Pe/CnVdk7AJJpnBFa77xmanoMVMUxf8J+rsXqwleMAFmJvmyLgY5IrjB0jjK?=
 =?us-ascii?Q?RMLjlXCPO3uqJggsdbPxhNuOp4RaIFH0e2ZaVjr2QCPiXMLI6+/Eyv3eEupE?=
 =?us-ascii?Q?UIk6eq99HhwNuc0jqTrdVhU/7h1Dxmv7Maq7PJ0IzPOo63tUVvx1zEd5rzAV?=
 =?us-ascii?Q?qBiv5UkwY1CxcR9x6RAPO9wloMAYs3zj8Yp9APiqn89y2Hk6ofRCKA3v5VUj?=
 =?us-ascii?Q?NWXDoywUItOiU841lSwuBcRlVloz0TrYJ/W6lkJqQ6rRSgtOFOgy/FALEz+w?=
 =?us-ascii?Q?G/3GAMLSFOTUxt08C9FzvVuGLL19ZNBtCWMAAw9oyfYrQqWTmlqjCtrPsk5Y?=
 =?us-ascii?Q?R3Une7k8emglZ+R3J6kzMaSJfpaCUJEYljiRx7yugTbT9i3zY5jHewo0PfZu?=
 =?us-ascii?Q?eyAM37e1JrDlFFbP08HivchghNdDCW0kk20vp5b97BH9W5AJj/T+WEuPhxLh?=
 =?us-ascii?Q?qgx7guWvl+3iigrwFkjjid+6oTrRaQACU3Ntbi7G2jHWOQIKIf8l90R6JSQN?=
 =?us-ascii?Q?uVhJJijJatStjTSt9l9fwrkcvEHsvTQAFZR5gM9zGqgVOARLo+qn/9dMHByM?=
 =?us-ascii?Q?PdrVcPBcwchMVDTiV+yHmFNc0aXekqtdjQpY+nXOY8OthyFQ4Dd+LXgA7A04?=
 =?us-ascii?Q?D16Ogh9N+Kd4hYzEdbAsj9OdJABM2nek9xwte1LSAE+MsQMznVI3R9V4Up/s?=
 =?us-ascii?Q?phFm524u9uTZBUoz4OqhtYuLhbYePlbHZ43qunyeaQeTcnLVDr4Lag5rTQ/I?=
 =?us-ascii?Q?OJhN9oxGUCL7uzsRwReRRAq1usxHxEYQAzK8Db6XOPAV2W6mpUOW3LmzqVP3?=
 =?us-ascii?Q?jLWNPckOuvRHOT+gz5ofnFbqbqQs+ds8qovVAjDLOMeN/7n2WFiGBAQdwLR1?=
 =?us-ascii?Q?bnW1CWoJza7YWZ2r78dxVLUCy0hSBX3vOAopJFPFs2heUDaI3UoqyCHe3xK7?=
 =?us-ascii?Q?tGYG91wj5i3xG81OKMu57t0TqGE7f9Na7hG+AurQERhdwUFQGJC457NusIu2?=
 =?us-ascii?Q?U4vrb0kIA3eLKl2NkeV8TwINMuaOBLpUUWOPgC4vI1kBXq527E3080R9LjJu?=
 =?us-ascii?Q?RQt30NBXhz0b0Aeb69NXG8uw1P8Ca2TZATo10AaSIkn4+/haSDwYblQoqfBC?=
 =?us-ascii?Q?ddKsyPiHMDZA7l4A+MzjIqhs935KbaWcnXFghYR/kXwBSjk6UH0Xy+8Drm1k?=
 =?us-ascii?Q?KtGVmyw1jBLN6G7ZVTeFuYD09iLfwM8Rpk1SM4RYlf+sMUVbU+MJ56q1KowW?=
 =?us-ascii?Q?QGthX/U7B6SO7UIk0GbWIdHEcnEcvw2qa7FGI1ZCC9b7o3v5syYa7r3FULPU?=
 =?us-ascii?Q?mewg9wn1o8MxP5UeiY6PNYI7y0ksQ1Imu7BtMcufPNd+nuwReFudgPo0ijTY?=
 =?us-ascii?Q?H1qBLoUN67eKJ7lhJw4r7io4Nhi/WIf2NKwASxF1DqR8h2wxYU/FGwuvCG2o?=
 =?us-ascii?Q?FWmg5f8EtB3OtlAENqiw1rzIvwI2QAZluZIdItYPNBoxOF/Rlzeq1e6hRtLA?=
 =?us-ascii?Q?Kkg9mdDK5Rm5fpR+q3caRFrQDd5onACNQHw6xUWEndH9g3LRDiwBA75moByb?=
 =?us-ascii?Q?qetmxkCOQMa+Iq1X0T0r+LBr3tb+BO4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fVqW0uB2QI6hIbGfCwL/0U/APNLZgnI0UhTHb8vg/rYXpYVXFdOkc4qBf+Bl5qBbya+OJuXk05EBET9U53YFd6/jdObpyDr30nsl3QrvBdqcP44pZyBv5w/e59wANZBwMTsqp3dVDi0vh2BNT2JAbHkvYJ+/kQEgqcC4x23DK9droXQOvERSRvPE3wIogHYifmQAUAPHsv61ljBfoX95ZmTOOgSwEbshqRSiMIwzVtayaiMHOHr4xClmMNHkvrUNmj1xwkbbhC9pUoHfhmPZeVb9BMYG9lBPk1Wzan47db4MXWZTzqmDAGhY94Z5/hZwym8yRmUSSdqi2aCVO4LetA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d7fdf6-82d9-4df0-9da0-08de897c46b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 08:06:38.7908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YQ/oO4E1I8QKtut3hbHGmfp4cKsxQhQt8nr/9J/rlPtmWnK/ZRdxTMTYnc5fu6Ftohq9M5W7GVVjDSXUTQMKYx6LvyxlakwDQBxo8SE4m5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8137
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270922-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 427B23045A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Matteo Croce
> Sent: Monday, March 23, 2026 7:28 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Alexei Starovoitov <ast@kernel.org>; Daniel
> Borkmann <daniel@iogearbox.net>; Jesper Dangaard Brouer
> <hawk@kernel.org>; John Fastabend <john.fastabend@gmail.com>; Mohsin
> Bashir <mohsin.bashr@gmail.com>
> Cc: netdev@vger.kernel.org; bpf@vger.kernel.org; intel-wired-
> lan@lists.osuosl.org; linux-kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net-next v4 1/2] e1000e: add basic
> XDP support
>=20
> Add XDP support to the e1000e driver covering the actions defined by
> NETDEV_XDP_ACT_BASIC: XDP_DROP, XDP_PASS, XDP_TX and XDP_ABORTED.
>=20
> Infrastructure:
> - e1000_xdp_setup() / e1000_xdp() for program attach/detach with
>   MTU validation and close/open cycle
> - ndo_bpf support in net_device_ops
> - xdp_rxq_info registration in setup/free_rx_resources
>=20
> Receive path:
> - e1000_alloc_rx_buffers_xdp() for page-based Rx buffer allocation
>   with XDP_PACKET_HEADROOM
> - e1000_clean_rx_irq_xdp() as the XDP receive handler
> - e1000_run_xdp() to execute the XDP program on received packets
> - SKB building via napi_build_skb() for XDP_PASS with metadata,
>   checksum offload and RSS hash support
>=20
> Transmit path:
> - e1000_xdp_xmit_ring() to DMA-map and enqueue an XDP frame
> - e1000_xdp_xmit_back() to convert an xdp_buff to a frame and send it
> - e1000_finalize_xdp() to flush the TX ring after XDP processing
> - TX completion via xdp_return_frame() with buffer type tracking
>=20
> Assisted-by: claude-opus-4-6
> Signed-off-by: Matteo Croce <teknoraver@meta.com>
> ---
>  drivers/net/ethernet/intel/Kconfig         |   1 +
>  drivers/net/ethernet/intel/e1000e/e1000.h  |  18 +-
> drivers/net/ethernet/intel/e1000e/netdev.c | 533 ++++++++++++++++++++-
>  3 files changed, 540 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/Kconfig
> b/drivers/net/ethernet/intel/Kconfig
> index 288fa8ce53af..46e37cb68e70 100644
> --- a/drivers/net/ethernet/intel/Kconfig
> +++ b/drivers/net/ethernet/intel/Kconfig
> @@ -63,6 +63,7 @@ config E1000E
>  	depends on PCI && (!SPARC32 || BROKEN)
>  	depends on PTP_1588_CLOCK_OPTIONAL
>  	select CRC32
> +	select PAGE_POOL
>  	help
>  	  This driver supports the PCI-Express Intel(R) PRO/1000
> gigabit
>  	  ethernet family of adapters. For PCI or PCI-X e1000 adapters,
> diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h
> b/drivers/net/ethernet/intel/e1000e/e1000.h
> index 63ebe00376f5..4c1175d4e5cb 100644
> --- a/drivers/net/ethernet/intel/e1000e/e1000.h
> +++ b/drivers/net/ethernet/intel/e1000e/e1000.h
> @@ -19,10 +19,13 @@
>  #include <linux/net_tstamp.h>
>  #include <linux/ptp_clock_kernel.h>
>  #include <linux/ptp_classify.h>

...

> +/**
> + * e1000_xdp_xmit_ring - transmit an XDP frame on the TX ring
> + * @adapter: board private structure
> + * @tx_ring: Tx descriptor ring
> + * @xdpf: XDP frame to transmit
> + *
> + * Returns E1000_XDP_TX on success, E1000_XDP_CONSUMED on failure
> **/
> +static int e1000_xdp_xmit_ring(struct e1000_adapter *adapter,
> +			       struct e1000_ring *tx_ring,
> +			       struct xdp_frame *xdpf)
> +{
> +	struct e1000_buffer *buffer_info;
> +	struct e1000_tx_desc *tx_desc;
> +	dma_addr_t dma;
> +	u16 i;
> +
> +	if (e1000_desc_unused(tx_ring) < 1)
> +		return E1000_XDP_CONSUMED;
> +
> +	i =3D tx_ring->next_to_use;
Unsynchronized read of next_to_use. ndo_start_xmit on another CPU can be
reading+writing this same field RIGHT NOW under __netif_tx_lock, which we d=
o NOT hold.
Isn't it ?

> +	buffer_info =3D &tx_ring->buffer_info[i];
> +
> +	dma =3D dma_map_single(&adapter->pdev->dev, xdpf->data, xdpf-
> >len,
> +			     DMA_TO_DEVICE);
> +	if (dma_mapping_error(&adapter->pdev->dev, dma))
> +		return E1000_XDP_CONSUMED;
> +
> +	buffer_info->xdpf =3D xdpf;
> +	buffer_info->type =3D E1000_TX_BUF_XDP;
> +	buffer_info->dma =3D dma;
> +	buffer_info->length =3D xdpf->len;
> +	buffer_info->time_stamp =3D jiffies;
> +	buffer_info->next_to_watch =3D i;
> +	buffer_info->segs =3D 1;
> +	buffer_info->bytecount =3D xdpf->len;
> +	buffer_info->mapped_as_page =3D 0;
> +
> +	tx_desc =3D E1000_TX_DESC(*tx_ring, i);
> +	tx_desc->buffer_addr =3D cpu_to_le64(dma);
Writing DMA descriptor that ndo_start_xmit may also be writing to
at the same index - probably causes ring corruption

> +	tx_desc->lower.data =3D cpu_to_le32(adapter->txd_cmd |
> +					   E1000_TXD_CMD_IFCS |
> +					   xdpf->len);
> +	tx_desc->upper.data =3D 0;
> +
> +	i++;
> +	if (i =3D=3D tx_ring->count)
> +		i =3D 0;
> +	tx_ring->next_to_use =3D i;
Unsynchronized store - races with the identical write in e1000_xmit_frame.

> +
> +	return E1000_XDP_TX;
> +}
> +

...

>  	kfree(adapter->tx_ring);
>  	kfree(adapter->rx_ring);
>=20
> --
> 2.53.0


