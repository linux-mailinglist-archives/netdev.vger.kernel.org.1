Return-Path: <netdev+bounces-238785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E1697C5F60A
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 22:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 725514E0702
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 21:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590A93559C8;
	Fri, 14 Nov 2025 21:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U5EeqYP+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90493016F1
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 21:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763156005; cv=fail; b=hMUsqLUTzNNz3eY90Dym8v6ajGSM1XIL3KAvHnBuRsB1y9mZ7EZwWxNMlmVOXFNj6FIyTZwPL7Rxd9AeMaaC+dZ38E72cDhOZgl/lS47Jk50YpZj1xmjFHAlBz+bHW4Z1Ym72pYayE8vy/+DYt4PkK3FPxiG1hwD4OBY5mGyuFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763156005; c=relaxed/simple;
	bh=TToGND3A3EORyv3UqyEy0w8IpSzImkB7fAKMfibgeY8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C6x13plYCkjRMpdw0cpPXadu3tTrInGbOrrOhPRKkoDAa73Osas/zzonQct0Odlh1pvlsWy1KWsqsbegpPmQtqsXw3ixdZqSU6xE5gK4vYokO7oqdoLA4vXVrxA45JGqWpxs6YyUira4zimpg61NCoAD2mSlARrUXkYgv96auL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U5EeqYP+; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763156003; x=1794692003;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TToGND3A3EORyv3UqyEy0w8IpSzImkB7fAKMfibgeY8=;
  b=U5EeqYP++cHTDwQ/Vw3V3FVMoFOkQA6221RyCcZ32gU2/b9qmSY+TwsD
   rArIaFV4nP7SnoJdC+LbZxCs2nvHMI3ZNsF0qGGvAcLb+v2ydloOGiht3
   MJbf5HBRk7RLbV/5PF/BwMHg2rqtd98QNFY9+iAau4FsN6K68EePAKk5a
   wSpPhyIVC/9/cQNP/VEbB/Uhc7rRkISbi9RerDsuDYBEKwKV7FEOG+knG
   pS99nClAHCZdhHMjk+Z4OXFz7l6fWuYQgtChPW3LuSmVNuqgxajQygTIe
   KFgWKWH07/a+Y9XsTIlMdoVRSwDsWItqCZNF+iU7qUtwXS7s3iXHVEp+2
   w==;
X-CSE-ConnectionGUID: QUIFFG29RLehPAxGP96MzQ==
X-CSE-MsgGUID: MDiQxA6LSI+yUs4lQNsn0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11613"; a="64966120"
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; 
   d="scan'208";a="64966120"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 13:33:22 -0800
X-CSE-ConnectionGUID: 4SuGvuE1SnmjYMM7W/Tw3w==
X-CSE-MsgGUID: S2wmvDB5QYCXu55bUjHB2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; 
   d="scan'208";a="189896982"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 13:33:21 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 14 Nov 2025 13:33:21 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 14 Nov 2025 13:33:21 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.24) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 14 Nov 2025 13:33:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jeMLNOMorSl+0nP7UVUoY/8GwQQMdEYIyAGSH/WdKJ0SQEphL8QlzcoKVO0V5iE9NDhzzJH+3c//4RjHcx9QXMBcyMqbMmA44wuHXW8dqYmD5ZDNKcS6Py2l975uvR/gxaKMObPNbndIjb4/LsvnqF6MVfrF7vsnNXrNhFGCQXR0TAvTuJJDPYubDUhoSvweqBhXIxCq59EpqvVwLN60DcGOGCpgqjfLABU1geDQQbLHPsVIERkNdce4CuYEl3nvr/ZnjeVwOZucKFD/pvQcFgqpGyl7zfOUqSAZx23RaZXsxIaPw2pDVdJaWzL/uvw4YcVn+7jHRnyWWq39OdDdPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0kkF+dwD0PcvfEBNcMbZwApsHWmDRSe/QMfJWvYLCo=;
 b=q4kHth5v9D0HQodfw2OsmPa2pxXJOnhMMs82AGRGirP5xu2xC0iaTtj0+ZyFEMA/qyLjlOSqlm1PGM4ByQhtaR19uMtRLMgaaNv22n0EciH7239SMWXkn9FbgFdf9zvqrExsQWC8gISi7Qq5gPW658eOJ9ANVpfcu+CVUyy6fGdtNfBxhlMyf0LPn+2FVkd7p6gyZkilg7xNWbgxc5FF7q+g5Kd3JAFvXcyHNdb5LjdG71hAO1IOSCusnPSQqIhcQVY14Dglak3AKHdyP4wiO0IsLCoerVspoO7G3zMfjb5xa1lXo/OARcc/GQPNASNwb3KD7kVSHn0OVGzN5Pyrlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by LV8PR11MB8608.namprd11.prod.outlook.com (2603:10b6:408:1f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 21:33:19 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7%5]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 21:33:19 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: Simon Horman <horms@kernel.org>, "Tantilov, Emil S"
	<emil.s.tantilov@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"decot@google.com" <decot@google.com>, "willemb@google.com"
	<willemb@google.com>, "Hay, Joshua A" <joshua.a.hay@intel.com>, "Chittim,
 Madhu" <madhu.chittim@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] idpf: fix possible vport_config
 NULL pointer deref in remove
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] idpf: fix possible
 vport_config NULL pointer deref in remove
Thread-Index: AQHcPFU9cKlsCEv2SU29PB7v95U7NrTBYEuAgDGDXvA=
Date: Fri, 14 Nov 2025 21:33:18 +0000
Message-ID: <SJ1PR11MB6297A43E2537C00F48BD8DC99BCAA@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20251013150824.28705-1-emil.s.tantilov@intel.com>
 <aO4XCSu0jZ57k-1Z@horms.kernel.org>
In-Reply-To: <aO4XCSu0jZ57k-1Z@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|LV8PR11MB8608:EE_
x-ms-office365-filtering-correlation-id: 39b2979c-c261-4e3b-60e8-08de23c56dcc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?zuQMCgQtlGgCJ9UaMCAKk9F4RdCHURbKtGL/4xBThir0HlLjb0wO00Ps5dbM?=
 =?us-ascii?Q?1zhrTfxyjfaY0mHidcMYgQ8cyQikp7auEjdHDuwtpU2OxITMoG7XyfshmSRU?=
 =?us-ascii?Q?mSAE10+A0h60lhTfzSPrLMjhB37IloYfpWHbfNX31k6yPL6f51SS4qr4ZXK1?=
 =?us-ascii?Q?FlEbc0yQv5FY4KADwuFStQcgLW1O/82MUJDyInASHxyxfo+8C+H2vTUKUUbK?=
 =?us-ascii?Q?7egmJdbRCMOXv8CBaGVxeEnQkSvhzfxH46KVeUNan6FWxr3fTw9MNKTU6ZL/?=
 =?us-ascii?Q?QJC47/I0LMDrnDgpTj5NtZyCwPB/W4x0JgWAW463nUkC2WBNOqGOoS7u0ieJ?=
 =?us-ascii?Q?4E38RcLveCavEBDKku7OCFDtpDfuhuJ6h4NjyKcamjrMeRH/qd73JeL9RD7c?=
 =?us-ascii?Q?O+GjosIW/77gmX5tgy4ojYIgKTiRQkajgZy1YyuCJ6yqjq1JzQf49cSC4KNM?=
 =?us-ascii?Q?AyQzhzFsmbwzIKyg7+R2+iID2o/l+oiAtsjhXhSXn2CNdiTrZ4GfuyqQLzYF?=
 =?us-ascii?Q?sIFpIc/rOaoPjxARsWJoI0i2/+mhYJmsVyl8yeW0vPJoXh+V3weos0bMgc6O?=
 =?us-ascii?Q?qPcw3ClXBtgKq+6nij/wzcj3eRBxAUZI7dHhCXr8san+aGlICmAw4n3s/mvm?=
 =?us-ascii?Q?rCdDNT/ASaDbkfs95ccjl7uBNUS6dTUvQwKg9JpeJVBIorCAH9iTUwlEkpaq?=
 =?us-ascii?Q?lmLObW7Ph7K8eG9nFd4AlgQ9ObtEZvjQaXyTu2LutxKwNIVaxH9K4Xo/pO4j?=
 =?us-ascii?Q?Lz1zH2eU9M+Ey2pEHvDlIX/ZEOTDE93BOJEV1aYTDDASN6GtvDPrIefC6Tcn?=
 =?us-ascii?Q?aZStFU5e4QnD70ebEWbr93eTmnefzrRTpT4BylMEF6chng+7s4aH4hzcxKRN?=
 =?us-ascii?Q?RbstGnPmz2zCnlwD2vlmlH/yr2demi+8FdqQikaynvu1mBL3etRPmJRwFQQ7?=
 =?us-ascii?Q?31ldpn/G5EUNq++NEzyB6gkwtnXKlBWD2A3zYcs0nnmKqpkHAtM9bjlgIbm9?=
 =?us-ascii?Q?jnURVL7wR2fjl08uSSk3inpTQpvbbTIs17a3FLMhUYwvdjYoFQFeRVKWxhpF?=
 =?us-ascii?Q?Y+1YdnMhVkLIgrb+mE4PPl4FxEbIdNHpjuDSpIav8SuOimLJLnGA9y6KWuEW?=
 =?us-ascii?Q?IggjnVhVM7SBY4AUBI2P4UfMSWpmLqzlu3DAZES+DvETOU4Jufl42QYdErRk?=
 =?us-ascii?Q?8P9qgVFWDDUippubJN5i0QaEV4hGA2JdLvrHd5R7EBasK95sBt54U4llwPkL?=
 =?us-ascii?Q?aPAbuIk7y4AFnHA94tmKWqkEMmhjY1x13whRjiH0/ZW2+NObuMDZxY26SIkb?=
 =?us-ascii?Q?m4RSa1yar/pQpycpQp88EDLxTWP/VM9uaJGdzXpkAqSph9zeN56xccsTOOZE?=
 =?us-ascii?Q?O+QseGLHjwhkkvfxi7zMur3nYY5IGKIdkAf5exDmLXvy59zoS/x8O7uho/xs?=
 =?us-ascii?Q?OcFrfL1FoXGtBnQvzB1zoGCBdNKio7yN32nBOOaX9lfrdUtZjX0tij3naZkM?=
 =?us-ascii?Q?IhQqJyCJV3vcOj1VfVYd2xUwuKcGmNMd324o?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?07AsDtTtbp0QH6g0Hw2ALcXGMAwhzIJg9xRPylsSHJSwdNnlugN/x0DinG/m?=
 =?us-ascii?Q?u9LNbKJwLL/UQzxFTGT8CucA/DZawe72nke2Um1dNe7T+r91dOYA6LeLJO8s?=
 =?us-ascii?Q?kAR5ZiX/NuSEIANl4TNH8l5CC0OxDQzcwfkxbhMmnZPhFyZEAMBdaHEpxS5B?=
 =?us-ascii?Q?NDDelB8VsVHarUjx5J/Qc0N6+NzAsbNNzn7LFBQgLkfRhALOqOKYjejsAxxL?=
 =?us-ascii?Q?Ocf4/+viXym02m/kxE2tnI0bGIPVt/wpGjP8oqirzV3BJuiARMkncMy8uvdQ?=
 =?us-ascii?Q?fPUk8Go6/wewwwymSGxn6FTgrNTQh5EyyXUnxKZyf2+b3Wkdw7umJkR4ZHDx?=
 =?us-ascii?Q?Ei8y9BTWpi/QqcKS3fk8GvyiReZaTecbea0RF59H4iM9rqMG2hw+UKVqqaei?=
 =?us-ascii?Q?eHNCbPE2IoOYE02st2K2hr9YMPypY7+BmZ6QVRYMMZlg0S51Sah+2aZioUgl?=
 =?us-ascii?Q?WIDoTcYKUE9X+pU6UyMee1BI93vYMR7XWdEkaKL5c642tquMbgbBmfnSXPQp?=
 =?us-ascii?Q?ZjRMzd+r5LZNOLk61xGu/Zby4nHm3i2MqOHV7Si60LdsRPusJIkkN1x87A17?=
 =?us-ascii?Q?8WziXVVQAFhTBv88hRsNLZCH/vjGtdQByL5vZ5yvI3Maog0vl27h8vsdmHWz?=
 =?us-ascii?Q?vHi66SwaIOpRBVT5ZqDL33M0zpd5T8FrNNR3xMREM/+UQ9YWNfcqg9npI9E6?=
 =?us-ascii?Q?yskj/dzRq8sV/Zv7IkZuQw93t/UvBuuBZYh0P4d0StJcRb2R8s5Mi+LrO79R?=
 =?us-ascii?Q?GuI8ETFqbvU2cJFlKAiCmJbwGvZrktsBpiurJo8IUsoU3JPCQJbo4GU5DFUg?=
 =?us-ascii?Q?cRp6CkoVpOYtF8U1uEp8wwVGPg4Cm5vZcJzKL8i/fDkV6ocVHA9Y+vyGKYjN?=
 =?us-ascii?Q?V7LvR4PU74FQQoXUUSpCd8cnhSyb0yeo8l0mdi0z5/Ql3vE3HAD+GBh/enJg?=
 =?us-ascii?Q?ypydo5APPXOZGNya0Zw56Z5cGijcrHLWzAdItg8lf5h82E0iqDRFvftqIbNc?=
 =?us-ascii?Q?AJBT2le7mEA3gOdLKwJuSsWgTXe1nZtsXx9P5p1RV+h+eb2DEkBmu+IM+glG?=
 =?us-ascii?Q?gK1S+koR3DV5+DAVh5Cd+RiHGEhPDw55NkrL21FmjhVKoCX37XDezIYyfQor?=
 =?us-ascii?Q?Z7ukDL3eFd1D+FUXlTQbjoWaYNQli86qMCc0fwB11OkU+MBZL87JpEzw4j3E?=
 =?us-ascii?Q?c3UXvsFyzGKu686S7fFDLthvCMePcfvWhQMxg1rC94UgJBJInoXLrlkrVowF?=
 =?us-ascii?Q?XdUuqORtfXANQ6M5DWhI9fWRYu8LiyFKDoZYoSZQ6zDCQh4+aXWChKNic+iN?=
 =?us-ascii?Q?4yde2tQJcYa2aqnJG1C1gp8lXY6l9TU8TqUBumJ/nOIpIPX9z/XhzHLXpXca?=
 =?us-ascii?Q?2qJERGjqcvbktjO+cMyOPeE7XCb/hIm5xZVw7Xxe7nS8Qzx54vLpz/AS86BK?=
 =?us-ascii?Q?XfekQQkvMK2ctxOzbJUZlONLADwva+Q3c4PyfPybh/wdz7pbKI4TboXndkbV?=
 =?us-ascii?Q?rPgMQwYAFCfeBjZbA/HDPQctKkGvLfCCVeLlBDWrhQ3YiZsgDnh9EgPPBK4Y?=
 =?us-ascii?Q?2gpWiP20vr1/KhlBLqs1rMVTNKddUg0JaCjv1/aX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b2979c-c261-4e3b-60e8-08de23c56dcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2025 21:33:19.0348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S9ROg131+wQ6UGHvEkNzlJDFLXnYy2riN22T+EOmcjfsF4slEOnry6nG2Kv6nXqbRQpYxNPcv/3qejqKyJxPzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8608
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Simon Horman
> Sent: Tuesday, October 14, 2025 2:25 AM
> To: Tantilov, Emil S <emil.s.tantilov@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; decot@google.com; willemb@google.com; Hay, Joshua
> A <joshua.a.hay@intel.com>; Chittim, Madhu <madhu.chittim@intel.com>
> Subject: Re: [Intel-wired-lan] [PATCH iwl-net] idpf: fix possible vport_c=
onfig
> NULL pointer deref in remove
>=20
> On Mon, Oct 13, 2025 at 08:08:24AM -0700, Emil Tantilov wrote:
> > Attempting to remove the driver will cause a crash in cases where the
> > vport failed to initialize. Following trace is from an instance where
> > the driver failed during an attempt to create a VF:
> > [ 1661.543624] idpf 0000:84:00.7: Device HW Reset initiated [
> > 1722.923726] idpf 0000:84:00.7: Transaction timed-out (op:1
> > cookie:2900 vc_op:1 salt:29 timeout:60000ms) [ 1723.353263] BUG:
> > kernel NULL pointer dereference, address: 0000000000000028 ...
> > [ 1723.358472] RIP: 0010:idpf_remove+0x11c/0x200 [idpf] ...
> > [ 1723.364973] Call Trace:
> > [ 1723.365475]  <TASK>
> > [ 1723.365972]  pci_device_remove+0x42/0xb0 [ 1723.366481]
> > device_release_driver_internal+0x1a9/0x210
> > [ 1723.366987]  pci_stop_bus_device+0x6d/0x90 [ 1723.367488]
> > pci_stop_and_remove_bus_device+0x12/0x20
> > [ 1723.367971]  pci_iov_remove_virtfn+0xbd/0x120 [ 1723.368309]
> > sriov_disable+0x34/0xe0 [ 1723.368643]
> > idpf_sriov_configure+0x58/0x140 [idpf] [ 1723.368982]
> > sriov_numvfs_store+0xda/0x1c0
> >
> > Avoid the NULL pointer dereference by adding NULL pointer check for
> > vport_config[i], before freeing user_config.q_coalesce.
> >
> > Fixes: e1e3fec3e34b ("idpf: preserve coalescing settings across
> > resets")
> > Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> > Reviewed-by: Chittim Madhu <madhu.chittim@intel.com>
>=20
> Thanks,
>=20
> I agree that prior to the cited commit adapter->vport_config[i] being NUL=
L was
> harmless. But afterwards a NULL pointer dereference would occur.
>=20
> It also seems to me that the possibility of adapter->vport_config[i] bein=
g null,
> via an error in idpf_vport_alloc() has existed since vport configuration =
was
> added by commit 0fe45467a104 ("idpf: add create vport and netdev
> configuration"). (Which predates the cited commit.)
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>

Tested-by: Samuel Salin <Samuel.salin@intel.com>


