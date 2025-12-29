Return-Path: <netdev+bounces-246238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55515CE72FC
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 16:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDFA1300450B
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 15:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22E91DB125;
	Mon, 29 Dec 2025 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rn+khP+2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EAE224B1B;
	Mon, 29 Dec 2025 15:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767021417; cv=fail; b=VZUa14Ek5cGBtPt/AR7hVTo5qLc7umKYlCk0ay3AVGToD1n9M544QbbgTDe5yyAGD7/GMDAPlv/W3P9lgD438xK78d0OIlK3NhzRtOGCauPzFxWBCuPpEViDxsSisBu4qyyYPmu6KaHYp8eoMny3lnRIHfyMtXphVrjZsHMEmjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767021417; c=relaxed/simple;
	bh=KHu8wkKR+Ig6BNBKHj3SOj+W0sL3RQCoKINf3xaSpgc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ruLWH1qHczGQMM6Ec0HiWl5pseoZefGPLvI0tdVD9jrnUGIg6lmql+iIIDjmaam6u7qd3jEyOJk3Bpe+wzqwozUNLCOlOBlxMAIgZ0FV41pCV1T8/VFDH2atQjUoW5eYsn+xuE03LLJQ+R2RM2KEPJS939oK1Z51S/enT5moOTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rn+khP+2; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767021414; x=1798557414;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=KHu8wkKR+Ig6BNBKHj3SOj+W0sL3RQCoKINf3xaSpgc=;
  b=Rn+khP+2cvPmlFCvSntsvgKvaLTqG5/rkCFCn3BzpZX8BsZReqtab0K6
   q+I/4bBDbwpn+XKMYBlPGfvi6zqDOEQyFSzZV7smcRj1sE7otvy4jqCd2
   Cne+Tth6Oo6C9A0EeadtwApcgJWiGciOSuw6eUe7thEO17WYEZQrfcjlu
   lFpb5SvEKnTmRawBtM96kx8o0p1GrR603nl74ny5TD0mIgFsHp0n0348Y
   vfg/JWuwTGRbIYrA2dCj3LERB4e7JrJXaQqYHzJqszMm8kT9DDP/5c0Mv
   5FKTyisnTqEuWb28lpzo5jTkR44/AcA1doIep81Ga6LIA7I4Vz08nEXI7
   g==;
X-CSE-ConnectionGUID: V1RRrDdlR0CcyJYIl5zaCA==
X-CSE-MsgGUID: zSzMuuu2RTuz1NJH4dRXFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11656"; a="79356534"
X-IronPort-AV: E=Sophos;i="6.21,186,1763452800"; 
   d="scan'208";a="79356534"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2025 07:16:51 -0800
X-CSE-ConnectionGUID: l+WKGqMYTUmM1ucqEh1XVg==
X-CSE-MsgGUID: xvUJ7UKiRJWGMCvVyd71ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,186,1763452800"; 
   d="scan'208";a="200660264"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2025 07:16:53 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 29 Dec 2025 07:16:52 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 29 Dec 2025 07:16:52 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.8) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 29 Dec 2025 07:16:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tHS8qxGkR+Y/p3F+8Hnd7nJXZ7liUdKY2aanJrCvDEsE599tn7bCkbn482Dmh/LxFT1fV7o9Qc8coBvZFe1mAdro6AREakT5mMRAhG9SLvtMODX6yR3Luj4strV4ZJNso/avu4dwGKmsUela+laqJyA/WndAaSzhv8Ynmj+yWpOX4p7WphBVSjbJI1BBX2zNtUWDQir2Vbi3/oPcaKA0X5rj8Vj58ZoZ543HStHiz/jaAxIZzh2T7BRsTlLbeRTrvP98zTld+uqCYUec11Qgy6TpF1+jf1tHrWAQpEPQDypNpzp2dvBw0+2dhxUbIRULXr3xaBWqOT+dd+HCzkbO6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URiKtHSi947AaHBOghjNl3EytqwLr5PgW1Dv+pw/3kA=;
 b=GBGnkksXvbmE3NBbZFU0ZQnzG66lP1GS27kNu63g+MEtlxkaKOWPOgmLoL2mnC8pUIO8ZtuWpzpehG/xDeKHLqdwh1mcMZgmrP4dJLGiuXE04apxSRMGayQOLeNKvAH5vD5Ed7q2DcCHjTnTODOZB7QeqKhsTcPLlrqa1M2MXgiNAldQtc2LiSfRYEoXzDEJAQZUgGmhSi+rY2t0LLTFbIci7xt7MkSM2tWm+iKIzyFdnazHO4QxvvloKz4VdqwkaesqoMfVgAc6WJg903/H94ZfL6syVy8J4A9ryBqK59teA2hyNjnJbamaLMqVhdOc3/EHRmAMJLT2FgicI5nOBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by BL1PR11MB5317.namprd11.prod.outlook.com (2603:10b6:208:309::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 15:16:49 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 15:16:49 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Aaron, Ma" <aaron.ma@canonical.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH v3 2/2] ice: recap the VSI and QoS info
 after rebuild
Thread-Topic: [Intel-wired-lan] [PATCH v3 2/2] ice: recap the VSI and QoS info
 after rebuild
Thread-Index: AQHcdWbMdTjEAav1K0mmoZuREVG4x7U4wRnQ
Date: Mon, 29 Dec 2025 15:16:49 +0000
Message-ID: <IA3PR11MB8986DB21D9701025AB3E5501E5BFA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251225062122.736308-1-aaron.ma@canonical.com>
 <20251225062122.736308-2-aaron.ma@canonical.com>
In-Reply-To: <20251225062122.736308-2-aaron.ma@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|BL1PR11MB5317:EE_
x-ms-office365-filtering-correlation-id: d65aa070-6fb2-41a5-9ae4-08de46ed49fe
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?KedoYGj0mcheJLxnauc6bbbPvYETsL6Vl2s0xo9rDz9thUyfcw5peA2GWzry?=
 =?us-ascii?Q?lmaZykCO+9Bvir1XCf8km1Li9Y7K2zW2m2AmME/ENpbF3cZJ7i03QWYzphnY?=
 =?us-ascii?Q?OY9owe/IlCKPZIAlWn0U8kyiMCp/Lzh3/UvPf3Vkn1fMcPg+Z4UFDDkynEYJ?=
 =?us-ascii?Q?Ur7w1V0oKqrI+8gREUJA5cg8tj2ZplG6Fa/m1in//dSw4CASXaFY1In50F4j?=
 =?us-ascii?Q?FY3SMxeQOM0eo+fGyYSa6q2Kurfx6F5T8o3ddCu+DxLBWljK08aKj5DKLB8y?=
 =?us-ascii?Q?0tglSSr99yY14sT0VQeQwT9pDOtKHnV3mHqeUtoJfRCviAUtzx6QQsDEgmtu?=
 =?us-ascii?Q?WMum7eO07Ig1A3WKA5aleaRcMOOJIBdoka86jHx1N0ZdMLtpozFazYXnFV8b?=
 =?us-ascii?Q?wPt0cwNoA5p6n17xr4VyfqUAjycOeu+A+8FXmImduyTd2MnO2ZS164AHKj3V?=
 =?us-ascii?Q?k1ydlChdtqGm8XL+f/MXB9e7ONHREAh9wjwAuNyinzxEqob3s+pN6SjYLcVZ?=
 =?us-ascii?Q?lsGz7g1DaN1H2MOHCmAmJqz40q1eeotmL7MHjGR0S2+pjJ1ZUBT+PiezFR4s?=
 =?us-ascii?Q?wfqaD/E+oKULhS4I/hDnMOEKkuePUJKhyBphmBCgCvMb8C8W0FywVFPXMEqX?=
 =?us-ascii?Q?gVa19UVW7e2kHheDDRU9LAZhPabHVEkAPQqw3d1KuIMQ0lnsrhX1b8x7KSP8?=
 =?us-ascii?Q?pa+KYdQydkK3IZmfHtQyzoxsK3soBjZx/gM9ptDp1Bfb5YR2RJnH7FZf0PUm?=
 =?us-ascii?Q?cueAe8mIpeGAK3BS19oTGVz1H2LVOmfZD5jEUh995WQ/m+++ZN2qGO3+IQ/r?=
 =?us-ascii?Q?Q9+OIjuisZaq/TiX6cu3rPUtP+RBA/GjMKslq/kWHmWRLCLfnyABiyLufVjz?=
 =?us-ascii?Q?cqzJVyMn8VCIkDSCkojFQPiFK6WuJudtEcQ28aJhNkDklbhBU4ykp6TDeavt?=
 =?us-ascii?Q?dzGSz18iS7/V8LCvU9CTCck0aoLlVU0hQJ5MIv7UQHeftZ7TBRKJSTHR7waO?=
 =?us-ascii?Q?9N0RnONuEgonA55cAtBB3HkOkvAOw1DPy5C8gINN7aKfKsAjmHlS04v+qPAx?=
 =?us-ascii?Q?2ne0eP6mpQy7j9pHARJKn4NzvHqfvfymHCck9xTBEcC0N0AYMxOTfuVAIi/8?=
 =?us-ascii?Q?brN95on054p2XbnqGZWIzKrz4LWsu6dzpbsszCKtWtOkegZZ4Jl086J2WPH+?=
 =?us-ascii?Q?WEGeqfGWUbVfTKJ9GPEUJn5iivA4gZ6v4fq+Q6n5Xs948ierudP4uHlq0TxD?=
 =?us-ascii?Q?B4c9mlq4s7bcHSu9U/v3DpwXQl3JThp2G3MU025ppmmK6IIH8Uxsce+b66ka?=
 =?us-ascii?Q?9y7iV2YNZxT3S46npHKGyesZlDR7vdQIbNXP/1ic/rakfrCj6VmP06zuPEzl?=
 =?us-ascii?Q?dX3YXAOMx/dOwZRt8ubzokiPiE3bC7+G+675Mz26zbl6tvsoBfwnvtqLLnV8?=
 =?us-ascii?Q?9KH5krfOU0NiFqxABJireHIe7rtOZGdYUGNAwc8+DQSKa8BfJ2DwdGMcWGN8?=
 =?us-ascii?Q?KwLK1IdKzw4jakr3CVMFL6oxpA3BncENOkP1RppQ7aRXOeJI8BqukZtOqA?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/2qYDpqakX+Zd/zi6LogQkAutPcQ5XeM5qNfSQgpcwIRZlGBrC78008uLgXx?=
 =?us-ascii?Q?iCCo8rkAbsCgMHgdVQK/B1JVADZ4LC13P4h+amzUU2TB9OyYQUHz8eqATJCg?=
 =?us-ascii?Q?P73J6yEo541tzcc6wv1A9lFuyXJ4gVQhF8vNcgypm7U6kgQ24GJ7xWl6CQok?=
 =?us-ascii?Q?j/9qZqBfbLQM/1EqDrSRuq1tUwpYaWVWZptoMJ1GFRQL1QEbLRJMw8QUnG7k?=
 =?us-ascii?Q?hunHthTnMcndbYAo/aH7WyAGzlneNRZI9yd1wgubilU11QaNgS4N0gMpM76h?=
 =?us-ascii?Q?J00E2DKWfYgo0H49qUdLIdGm3zTwAzdBDkoHsBZQR4y/QDeOuqxfBnKAWiGE?=
 =?us-ascii?Q?6Fx+91f+pdKJas/gYuZOTmgJKTTKWCCKqhesLbSNhWHIHzjfUo0726H0dd2E?=
 =?us-ascii?Q?XZadZQ7hpCMZqAY3Zrz66t3j9uyVgWvcNfc+ai0FK2KH4HtkSCL1rbiJryKi?=
 =?us-ascii?Q?AcP2sKckFJRabqA9wucoDA4+hl/faZo+pS085XD3KpWPYQzJ9/UxZl+E+VOA?=
 =?us-ascii?Q?a6FhxAR5a50czmJDlSV9DU1zQVmZWr6EKsmcdV83HSD+qLVLq7TOLCZK74ey?=
 =?us-ascii?Q?q4BK2GEh11uYixcvoevORuLj4EYYlsm1gAScEAbxsN92BiEe7RJKkyTT9uhs?=
 =?us-ascii?Q?OyCLftF8WDca6dpZ9jVy/18Wtlain/z+hFctnS8asXHnlUtSw0+btEP6q3gW?=
 =?us-ascii?Q?Xn7hziBdj7tSjKBxXOVTuIvXB1PJ7uYEcJrzD8BaaIL8/ScTKzFjq/KqMxl2?=
 =?us-ascii?Q?vZ01lHYUKz77+ankXlwF594epXkm8O/9pgjbVmo6i1FLO9tYIhlNxU2bO0+P?=
 =?us-ascii?Q?YBp7ElbCRVb6tCmtF3c+BgNrt/47V5M2BCXdu9gDuAP/Xy9ehK0+LqsxVqx2?=
 =?us-ascii?Q?vr1KYedBc1slublQx56Tbjar8Ye/9xxuXw2+mbcN/laaRi7jaXneVMShR8TF?=
 =?us-ascii?Q?d1RziXrW0Qdp8LfyofR3OU0llT6P2Ds49Nc+RHCbOXNcMlfnNOuNmhehEOa1?=
 =?us-ascii?Q?0xPvYttLydguIykiIvTrCFEs7AAn0AESimyr6ScpV9g6n+Bkb2DUNsYwXeTT?=
 =?us-ascii?Q?nLmABDr0zxK6bfFV4Gs5FDPaP9kLivcMS/Hh3u2mUhX0bYnjJnZWK8FLhTDe?=
 =?us-ascii?Q?hOjFsqow5JhtgtmGKjAiUPZt19xx3mTuWrDMMC7MEIwBXPbpXYXhI1aMXcQ+?=
 =?us-ascii?Q?urbtIQ1rIai/zgIJW5hV19PnzNS3cFmXGqnU0Pf2fVFv2yerlPs6+6wtwoJY?=
 =?us-ascii?Q?uEEKX3zdZfF9PugYM7mPHR0j58whjFHgY1btDBGsefQXwPR5Y3nMYDMCFB73?=
 =?us-ascii?Q?bb4pC/SFcRGlLiV5GiBYPJLFqCqHGLp4pJUTujKa7EsbBknqH+8zdMNdLOGK?=
 =?us-ascii?Q?JbIFSiIieVWYDpLb7X2QJwEBNz7JQKtphQetjEqpwzo0O7+Di/63/GlnRLwP?=
 =?us-ascii?Q?ONuHUtOwsYZg40pEFv/SkX5TsSiLhQJYW1shQExCmeVFzfu0q1hE+k7hoGc5?=
 =?us-ascii?Q?M1E/RmLSAG3pppS+4EwPYz3Aomw/mZ7D/ly6bcFWMAnUTxI7TuDH6DAeRMmJ?=
 =?us-ascii?Q?/gGmnJdakmYQNTnbVRBFBR+AhZatpf7/87gFcdRBT0gUV+L5IkKrqg1EN53H?=
 =?us-ascii?Q?fgEzIa7shgH0Tzm4XEEJAmaNxGwvOCwAWJVetnCbXRRs6LRKja6SRbOVHcnG?=
 =?us-ascii?Q?h6Ve9TGg1+TH0OKtpjomUDiKYI0c1ApoDVtjMxibCdtquAEFT1QORuoOf38N?=
 =?us-ascii?Q?+FBBYl/qKW9kw7RZjMhNbIhNG9tXGe0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d65aa070-6fb2-41a5-9ae4-08de46ed49fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2025 15:16:49.5430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BbDlBCYaYPeAH06BnmO0DcwBP1t93Mhl5piqBkbV47uQkeWq2ebR8xuVTmLdbTZsjZ30iduYio8N6lrCqGMoYRE3qLRHs70PYbofGZJ2hvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5317
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Aaron Ma via Intel-wired-lan
> Sent: Thursday, December 25, 2025 7:21 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH v3 2/2] ice: recap the VSI and QoS
> info after rebuild
>=20
> Fix IRDMA hardware initialization timeout (-110) after resume by
> separating VSI-dependent configuration from RDMA resource allocation,
> ensuring VSI is rebuilt before IRDMA accesses it.
>=20
> After resume from suspend, IRDMA hardware initialization fails:
>   ice: IRDMA hardware initialization FAILED init_state=3D4 status=3D-110
>=20
> Separate RDMA initialization into two phases:
> 1. ice_init_rdma() - Allocate resources only (no VSI/QoS access, no
> plug) 2. ice_rdma_finalize_setup() - Assign VSI/QoS info and plug
> device
>=20
> This allows:
> - ice_init_rdma() to stay in ice_resume() (mirrors ice_deinit_rdma()
>   in ice_suspend()
> - VSI assignment deferred until after ice_vsi_rebuild() completes
> - QoS info updated after ice_dcb_rebuild() completes
> - Device plugged only when control queues, VSI, and DCB are all ready
>=20
> Fixes: bc69ad74867db ("ice: avoid IRQ collision to fix init failure on
> ACPI S3 resume")
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
> V1 -> V2: no changes.
> V2 -> V3:
> - mirrors init_rdma in resume as Tony Nguyen suggested to fix the
> memleak and move ice_plug_aux_dev/ice_unplug_aux_dev out of
> init/deinit rdma.
> - ensure the correct VSI/QoS info is loaded after rebuild.
>=20
>  drivers/net/ethernet/intel/ice/ice.h      |  1 +
>  drivers/net/ethernet/intel/ice/ice_idc.c  | 41 +++++++++++++++++-----
> -  drivers/net/ethernet/intel/ice/ice_main.c |  7 +++-
>  3 files changed, 38 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice.h
> b/drivers/net/ethernet/intel/ice/ice.h
> index 147aaee192a79..6463c1fea7871 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -989,6 +989,7 @@ int ice_schedule_reset(struct ice_pf *pf, enum
> ice_reset_req reset);  void ice_print_link_msg(struct ice_vsi *vsi,
> bool isup);  int ice_plug_aux_dev(struct ice_pf *pf);  void
> ice_unplug_aux_dev(struct ice_pf *pf);
> +void ice_rdma_finalize_setup(struct ice_pf *pf);
>  int ice_init_rdma(struct ice_pf *pf);
>  void ice_deinit_rdma(struct ice_pf *pf);  bool
> ice_is_wol_supported(struct ice_hw *hw); diff --git
> a/drivers/net/ethernet/intel/ice/ice_idc.c
> b/drivers/net/ethernet/intel/ice/ice_idc.c
> index 420d45c2558b6..b6079a6cb7736 100644
> --- a/drivers/net/ethernet/intel/ice/ice_idc.c
> +++ b/drivers/net/ethernet/intel/ice/ice_idc.c
> @@ -360,6 +360,35 @@ void ice_unplug_aux_dev(struct ice_pf *pf)
>  	auxiliary_device_uninit(adev);
>  }
>=20
> +/**
> + * ice_rdma_finalize_setup - Complete RDMA setup after VSI is ready
> + * @pf: ptr to ice_pf
> + *
> + * Sets VSI-dependent information and plugs aux device.
> + * Must be called after ice_init_rdma(), ice_vsi_rebuild(), and
> + * ice_dcb_rebuild() complete.
> + */
> +void ice_rdma_finalize_setup(struct ice_pf *pf) {
> +	struct iidc_rdma_priv_dev_info *privd;
> +
> +	if (!ice_is_rdma_ena(pf) || !pf->cdev_info)
> +		return;
> +
> +	privd =3D pf->cdev_info->iidc_priv;
> +	if (!privd || !pf->vsi[0] || !pf->vsi[0]->netdev)
Direct array index access assumes VSI 0 exists without verifying the array =
size.
What do you think about:

    if (!privd || !pf->vsi || !pf->vsi[0] || !pf->vsi[0]->netdev)
        return;

?

> +		return;
> +
> +	/* Assign VSI info now that VSI is valid */
> +	privd->netdev =3D pf->vsi[0]->netdev;
> +	privd->vport_id =3D pf->vsi[0]->vsi_num;
> +
> +	/* Update QoS info after DCB has been rebuilt */
> +	ice_setup_dcb_qos_info(pf, &privd->qos_info);
> +
> +	ice_plug_aux_dev(pf);
> +}
> +
>  /**
>   * ice_init_rdma - initializes PF for RDMA use
>   * @pf: ptr to ice_pf
> @@ -398,23 +427,16 @@ int ice_init_rdma(struct ice_pf *pf)
>  	}
>=20
>  	cdev->iidc_priv =3D privd;
> -	privd->netdev =3D pf->vsi[0]->netdev;
>=20
>  	privd->hw_addr =3D (u8 __iomem *)pf->hw.hw_addr;
>  	cdev->pdev =3D pf->pdev;
> -	privd->vport_id =3D pf->vsi[0]->vsi_num;
>=20
>  	pf->cdev_info->rdma_protocol |=3D IIDC_RDMA_PROTOCOL_ROCEV2;
> -	ice_setup_dcb_qos_info(pf, &privd->qos_info);
> -	ret =3D ice_plug_aux_dev(pf);
> -	if (ret)
> -		goto err_plug_aux_dev;
> +
>  	return 0;
>=20
> -err_plug_aux_dev:
> -	pf->cdev_info->adev =3D NULL;
> -	xa_erase(&ice_aux_id, pf->aux_idx);
>  err_alloc_xa:
> +	xa_erase(&ice_aux_id, pf->aux_idx);
>  	kfree(privd);
>  err_privd_alloc:
>  	kfree(cdev);
> @@ -432,7 +454,6 @@ void ice_deinit_rdma(struct ice_pf *pf)
>  	if (!ice_is_rdma_ena(pf))
>  		return;
>=20
> -	ice_unplug_aux_dev(pf);
>  	xa_erase(&ice_aux_id, pf->aux_idx);
>  	kfree(pf->cdev_info->iidc_priv);
>  	kfree(pf->cdev_info);
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index 4bb68e7a00f5f..1851e9932cefe 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -5135,6 +5135,9 @@ int ice_load(struct ice_pf *pf)
>  	if (err)
>  		goto err_init_rdma;
>=20
> +	/* Finalize RDMA: VSI already created, assign info and plug
> device */
> +	ice_rdma_finalize_setup(pf);
> +
>  	ice_service_task_restart(pf);
>=20
>  	clear_bit(ICE_DOWN, pf->state);
> @@ -5166,6 +5169,7 @@ void ice_unload(struct ice_pf *pf)
>=20
>  	devl_assert_locked(priv_to_devlink(pf));
>=20
> +	ice_unplug_aux_dev(pf);
>  	ice_deinit_rdma(pf);
>  	ice_deinit_features(pf);
>  	ice_tc_indir_block_unregister(vsi);
> @@ -5594,6 +5598,7 @@ static int ice_suspend(struct device *dev)
>  	 */
>  	disabled =3D ice_service_task_stop(pf);
>=20
> +	ice_unplug_aux_dev(pf);
>  	ice_deinit_rdma(pf);
>=20
>  	/* Already suspended?, then there is nothing to do */ @@ -
> 7803,7 +7808,7 @@ static void ice_rebuild(struct ice_pf *pf, enum
> ice_reset_req reset_type)
>=20
>  	ice_health_clear(pf);
>=20
> -	ice_plug_aux_dev(pf);
> +	ice_rdma_finalize_setup(pf);
>  	if (ice_is_feature_supported(pf, ICE_F_SRIOV_LAG))
>  		ice_lag_rebuild(pf);
>=20
> --
> 2.43.0


