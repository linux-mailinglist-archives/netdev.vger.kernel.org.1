Return-Path: <netdev+bounces-296400-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NGWsOOVzJmreWgIAu9opvQ
	(envelope-from <netdev+bounces-296400-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 09:48:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 059A1653B1C
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 09:48:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=QmkjXD4b;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296400-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296400-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04738305705B
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 07:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31B1394462;
	Mon,  8 Jun 2026 07:43:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E09393DE8
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 07:43:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780904603; cv=fail; b=ia9kRJvzuffUDc8VlpOO3XNY60g2ZOlUB5sPx9PWWHGi+tVLbYv1sgQjhuma7D6XRdC0WBQT3LljeTrgA5lxx2x0+JGSEcOHcy/ecg0ZdZDP+3vb03hGi/QycqTonMJwJqxmHPGaVPdRyQ1z8q5qPCIktbpHEEz5Q6f6u0ZCUDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780904603; c=relaxed/simple;
	bh=E+pYmb1CF8DANsmbj22Rd9JCfQFPv86+v5Wl1rCMfG8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uIhbNHJxNrrI0xMP5AHjAwYpdQtJfWRnPGOQSebw/nzizVcsQrFClBeskAAsH88L8qSeC7U4dNX370F1ojOOBVXaXU1ORlFTztecVhTd5Wxd/cxg/tFOKvsLvL0JjrBGOhqynadRMMg9HiJPpioOLcSZX4dCgU+7GL1M40eFpds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QmkjXD4b; arc=fail smtp.client-ip=192.198.163.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780904602; x=1812440602;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E+pYmb1CF8DANsmbj22Rd9JCfQFPv86+v5Wl1rCMfG8=;
  b=QmkjXD4bnQMj2PIQQ2u3Oi/ANm+Xqqd6Mw6muaCwnNA+g4ktSeCLW8lE
   8V3Jp3np1sNYmt1hdIbASxd8cL6rpLgeOnOGd/97/rD9qY54huewOoVCJ
   IzBkj4TZCl3hyKAGJVd1USCHxuRCrAQClZR8ftamgkuUj0lSxULBdOkKw
   gEJL5BMp+I5AVuPko26x7Ayi+E03NcC92MR/3Bs5NVoKGnIQoVfDiM/um
   89aHsz0XKJz1FQ05CVn1xkwOrTredSh3JNIFp1AjWZR7H+MNME0EyHG5v
   lPJK7d4MRhZVtFa8iUUZtGH+Hr7tGKXBwTiECMs+9Bxx6+JzF7I8MBzy1
   w==;
X-CSE-ConnectionGUID: KrgER3ZWQ4CauLk/21mtBw==
X-CSE-MsgGUID: syazDmMNTb2PtpMTCMphfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="80662392"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="80662392"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 00:43:21 -0700
X-CSE-ConnectionGUID: V+rLFB66RQSo77jVmfsLKQ==
X-CSE-MsgGUID: G++YKoEuRreY1TKnXdlrQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="250576377"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 00:43:21 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 00:43:20 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 8 Jun 2026 00:43:20 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.53) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 00:43:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5G96smLJt4WcARSnlY+BQRRglrW+bWOKPlKJ9Yt5Kswx513cDDb+Isa7Rm7wj2smsO6XxH6sUYnOCKBhTuWyjJuC76K4gZuFGW+XFRhvL3kxXjCtoL3gdt1XxDRam+ryNVDCH47NpWuWspvhWUip+R5mRL7RlxpMa5e03ihbeSvUpdtOwo16gRe0ED59mhYIZop2BBV+WOr36VIBB9fk6RSguy4JZnGSonzwE0EKJcyyjCpjS5ky3z0ef7T/SExQx3yi3qw3/DzfkB9tl/kIcrfUDQ7E1Hm9baIiNn6YoGfJecMv6ZEyeTRIi/NbHwNjZUZqIfF0JITjQPDh7HPLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDu1PS9aJlsJrlGk4Y/Eqe4DT72N46fRyeVzE6SsJ8M=;
 b=cpSU1V6zYwqcH3MEAgo+WAw0LVGW/H1QvEpAlQ9y2Sx+RxKo8zBUdglez7d4f+7pQ0WG5Cm6KdqFs8d/qTxMC69NMxGaPFqEWVuXw90giu5FkH//oYCEqreSK+fXUShRDCznOBOaYhkLwS+AZeCbRpdESka6KX8AO9pBeR4Esca9rUvBiIAhzriw2SlR94tEtmvlbObBlEeSZ0cz2Ai1JR+M0xDyDL4TIYm5t2Sb4zDeF8Hcg1Zv7zIhBiIkZiOfw0pYuQVBw3uAK/2vOWDc3Przpf9jQ2gWYGW4cmOIcU/Vuuma3bR1mManXiCxuAtvyeCAIU89VcxbVErnnMC9ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CY8PR11MB6817.namprd11.prod.outlook.com (2603:10b6:930:63::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Mon, 8 Jun 2026
 07:43:18 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 07:43:18 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "horms@kernel.org"
	<horms@kernel.org>, Breno Leitao <leitao@debian.org>,
	"michael.chan@broadcom.com" <michael.chan@broadcom.com>,
	"pavan.chebbi@broadcom.com" <pavan.chebbi@broadcom.com>, "sdf@fomichev.me"
	<sdf@fomichev.me>
Subject: RE: [PATCH net] Reapply "bnxt_en: bring back rtnl_lock() in the
 bnxt_open() path"
Thread-Topic: [PATCH net] Reapply "bnxt_en: bring back rtnl_lock() in the
 bnxt_open() path"
Thread-Index: AQHc85NsXo11rHL6WUazpN1qb7gNKLY0Taaw
Date: Mon, 8 Jun 2026 07:43:18 +0000
Message-ID: <IA3PR11MB898688E85BDD0D41E0C20066E51C2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260603195845.2574426-1-kuba@kernel.org>
In-Reply-To: <20260603195845.2574426-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CY8PR11MB6817:EE_
x-ms-office365-filtering-correlation-id: 79e655aa-742a-43d2-2bf8-08dec5319b3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|18002099003|22082099003|11063799006|56012099006;
x-microsoft-antispam-message-info: N5HFyU164ekZFLCVrxeV4GpAY81xUMnhyHssQl0MtGjUAdCFwf6OJeP9ZPCz3bs/DfNYUcPux4obo232TLSe6jjtd3r3iME4bp7xhLWHQaOUwDo8juVGJ2QSjmOVuEFPlujHxq+xqS2afZrQY3iRIXIebIjSYVtduBpQPbsOw4El0ifa4sumGNXYIsKK6oSUuMVSys7HTFU/5nwaZlHb4ZNbsyx2DzZ1rljrSr8roPwo+v1N1pJSQcW5N0EoY8ULwWYjNT5bjWEVy8xTZJ8Ncam/TamezrXC/FgZM3rllpFNAgXs364L8cQpHME9VwH21eVDp2VwZFde78Z15w+fQq5UI5HEpHYIaz5zQdN0q+9ptdhRUGmR4RJboTw9suAA708wBu7a2lySdPkdoxnBj4CAEJBHziDbBqSG+clXml7Y6KTnCKXEUj92xp7qNqs4FFgzzy8NTBIb27B0kagTjI0/zGt7nvHI2OXGI+++BlNOVn0q/boCF+icotNtNFTibrxeqH3Zpj5npUC1Z0y87qwOVyJOMPwJZ7xJzBxa5ET7WUTDcbvjZGhqyEXwCsyJosOYVfoy/zpdz0yQvs/ixeds/M5MvS2AKFHirOR1F2prOB4BkJz9VVG0y5NlswbbQfxagrqneLGUFJWDR4ruYaxX2V/jxSbtzJy5oAGnFJzY3NUUmg3gJoinoi/TW5ceoQk/UC7z6uAU3luazl/xoVxXeTE5Kv7Q0EY18hAx0bgbni6k4szl8lSnaYfk23HQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NvIeEOxZbc6d4J9kCf9CZBBT9bNfgt9JABLlJvetvLFLmbg5DLj/GaLBMAKl?=
 =?us-ascii?Q?9t3Oc7phAH4k7IiBHzI35d3A/vTFZaWUgiq8fCeBxBKNE1yEX5kjuUIhOBbm?=
 =?us-ascii?Q?NIN9Na10jkUS9OXZlJR1CSa7yhjx8OfRdGLDBO9pRHZLyeCEXHt0ZmRnfbMo?=
 =?us-ascii?Q?vX1ji+w8q0cTTXbdmngQPRTgw3bHixqqIccAUKFKY4Xt4rfme4ufJd3zN6qe?=
 =?us-ascii?Q?F73YP2XR9xR99Za/ZlowS8bydXarkjYLDZF44Do0I7gO2PkYyBO/V/c66ceq?=
 =?us-ascii?Q?snlvcVHL7yHzmGp+Ysdf6+C6wbV2+sJiazXh8kHANPRVbYEKm3lrWckieHDu?=
 =?us-ascii?Q?jYrTX8BsROqalXp5FRt9PhMMfywBntI/oaw2XkndMgaJ+l5eYnDSUCQ8vsXu?=
 =?us-ascii?Q?yqwWdMGEPhRXa4Xmkig2g0FcTLoidFrTTWlvWy2tRItv/hk9rcxc8sPBSHyy?=
 =?us-ascii?Q?e/g9qNScxjXhd3DRJS/1ZQlEJfA4Qh+Sno8QcRk1KyoBMMnB6WlgM7BjEXZ9?=
 =?us-ascii?Q?614jsDRa+m4i6U99xf9LtplpL61dIJc/B5CTYDZCzIEIWPMs9jYTaCzmUVQZ?=
 =?us-ascii?Q?s2oKai7CvhyU3aqcW2L8JbND28X3pOnH++plKd+vUOGymEAVgxWABTkjzt+q?=
 =?us-ascii?Q?WfIjdcwaWSyhIT3dhNAqRpVcZvtbutKfSoe2UuEetYMJqx4fGwZffNOm7Ghf?=
 =?us-ascii?Q?8Zp0yZvo9DO6DCdc2OW/1PCIyx8UGbL+V7y2IQ6nn32UX6jwvrRCEVCdtYuj?=
 =?us-ascii?Q?lYlCISvBoZid89zq37rD06rFtpg/isI/cEFH6TFxSIYqmFd8pjOiqDFFc8+0?=
 =?us-ascii?Q?1fJ8IVQQ6K3NNgQKm9pW12ufw4Mlj5NAApF2U6FicFbCwoW8m68luv7deKO8?=
 =?us-ascii?Q?i7IIe8UNWzH44j8szjIM5OvV6+gGs6j6V+eH9pQHwQ02E/zZpWuFAONAljQb?=
 =?us-ascii?Q?Jaebt4IAoAw0YJ+bEW11qrYjnnlJ3Sit9g0cMPFJc26b/y3YOmk/7lj+/qGi?=
 =?us-ascii?Q?dqnx4CydjUdMyWrYzNhevnV87S9s0nc4XFl2hrElYq2YSJeBLi/USDl2AYn5?=
 =?us-ascii?Q?HQCVGH1pUV+3m1GdzeiQrHurYgYkpVB/IkKWR3nRgR4kHi34k/AMjv/uzVVm?=
 =?us-ascii?Q?zlWvOHucHHivErdZZG08zDKj/px9guuMZ9ssLq2PwF2RdyEGgVl3wqInFkGq?=
 =?us-ascii?Q?OdEvyWpvHMok0p2eOa79meJwiMFyTZ9mPE6Enjyxr6kbw/hJSv7z7Ro36yBO?=
 =?us-ascii?Q?fwU1yJVquWu/XNGdibAGbUR8MI9LYJNXiairxAqXrDDDz+CTquuZoboAMvDn?=
 =?us-ascii?Q?2tBK7fEyHrSlNk2RGp282bSmt56Ty7T5zbe7GN1ldjTdhwLneVXi3sAz8P7a?=
 =?us-ascii?Q?m/URby3yaKnqIqFmK+NvkeVP+jNLV1CqsuIU6j2ivNzXhibhtFF5txgBIKFO?=
 =?us-ascii?Q?TIDIgSwDfkVDIgtj0AY6ypGep75ESADSM4NWO9Jty/dnS/rHdshhE2gNdjh0?=
 =?us-ascii?Q?ZydHWQtryBGM3kExjvB/gd4UrOUFuxdgXf2/XahHBh/9C+3UXlfBI/9iPGE9?=
 =?us-ascii?Q?ZdV4GGeiy8ZiTUzVo8zud/7CuO809Vn2EJJc6Gofhnzwic+f8ZgR3qmeMxT6?=
 =?us-ascii?Q?Pgjhuko0t5UOcjktuPEeJnNouE6byo/8F2zIfF79KNqldMss6VToknmD9FLg?=
 =?us-ascii?Q?OsoH74+SCLg6Da1urMuM2CVEPxNenAyap51CPgvdJ5UBRBR1BNJEruDFxz7b?=
 =?us-ascii?Q?2AeXOuMGx2xzZ4aag1qlerNNBKhrvRo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DSq19G6dHSh3Wt8jCuW74EBqFfwQgINlUFCnJX72mGs5LQMHoPafTpJ+4+FIaVvLNnpwD8PAaX4XSUG2RV8GiL04M/D/51SXtHelg3bdVPSviltBTYriw7B1+4Bj3i+0pgdyanrBbcP/UHjBFvNLUfQ6xsKzQvLCl/S//HZSABg3D31nlxK/lNoaZgazF2fMhg9UcOXnzqqrdQ0jjJAMKe8NwoGELflDkhIGqGwCaPokxCv3may7+Z9uIJWQaQu049kLN1t+BQO8SxeafFyjCVtLb9DyPOH2qxd5JwsL2zpe5CXmEJcIk6Ijx4Xv9fQoDF8rlO992LRvsehy3DT7XQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e655aa-742a-43d2-2bf8-08dec5319b3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 07:43:18.1216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X9ZJFFX0ApJOs25lZEzMpXgAvJqGC9/nD03ICpIkaHFXHbe2ZRr8F4r5LgvUrfyyByYJ8dRt7NC2we7ur3I36Pi/+o88ygEmoNMZaF8xHLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6817
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296400-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:leitao@debian.org,m:michael.chan@broadcom.com,m:pavan.chebbi@broadcom.com,m:sdf@fomichev.me,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 059A1653B1C



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Wednesday, June 3, 2026 9:59 PM
> To: davem@davemloft.net
> Cc: netdev@vger.kernel.org; edumazet@google.com; pabeni@redhat.com;
> andrew+netdev@lunn.ch; horms@kernel.org; Jakub Kicinski
> <kuba@kernel.org>; Breno Leitao <leitao@debian.org>;
> michael.chan@broadcom.com; pavan.chebbi@broadcom.com; sdf@fomichev.me;
> Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Subject: [PATCH net] Reapply "bnxt_en: bring back rtnl_lock() in the
> bnxt_open() path"
>=20
> This reverts commit 850d9248d2eac662f869c766a598c877690c74e5.
> This reapplies commit 325eb217e41f ("bnxt_en: bring back rtnl_lock()
> in the bnxt_open() path").
>=20
> Breno reports a lockdep warning in bnxt. During FW reset the driver
> may end up calling netif_set_real_num_tx_queues() (if queue count
> changes), so calls to bnxt_open() still require rtnl_lock.
>=20
>   net/sched/sch_generic.c:1416 suspicious rcu_dereference_protected()
> usage!
>=20
>    dev_qdisc_change_real_num_tx+0x54/0xe0
>    netif_set_real_num_tx_queues+0x4ed/0xa80
>    __bnxt_open_nic+0x9cb/0x3490
>    bnxt_open+0x1cb/0x370
>    bnxt_fw_reset_task+0x80d/0x1e80
>    process_scheduled_works+0x9c1/0x13b0
>=20
> The reverted commit was just an optimization / experiment so let's go
> back to taking the lock.
>=20
> Reported-by: Breno Leitao <leitao@debian.org>
> Link: https://lore.kernel.org/ah726OtFX-Qw3U-R@gmail.com
> Fixes: 850d9248d2ea ("Revert "bnxt_en: bring back rtnl_lock() in the
> bnxt_open() path"")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: michael.chan@broadcom.com
> CC: pavan.chebbi@broadcom.com
> CC: sdf@fomichev.me
> CC: aleksandr.loktionov@intel.com
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 36 ++++++++++++++++++----

...

>  	if (!err) {
>  		bnxt_ulp_start(bp);
>  		bnxt_reenable_sriov(bp);
> --
> 2.54.0


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

