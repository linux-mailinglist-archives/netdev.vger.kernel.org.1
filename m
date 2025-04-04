Return-Path: <netdev+bounces-179286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2D2A7BB31
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 12:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5333217B6D1
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 10:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA341AF0BF;
	Fri,  4 Apr 2025 10:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E3C3JGQS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453031A9B24
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 10:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743763954; cv=fail; b=D/VqdHUEWS2nmz8iSgCcSBDkjZ2br56knHgTYOkRjb1GpXH24vF6KW5dJKYPQ1o/yiXhULLysQOjR8GRdT2ssbf7MK1G2Qz8WWQZ7gnV26YyyPqOrllLWK2whcKQppJ6Aa3DXk9LtvYBWdeyh++9NX1alFF/TckvVZ+05X9T5Zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743763954; c=relaxed/simple;
	bh=NxeOb3XU9HZiCjOnBIg+aBfMeblAE/yTqrISb/aujuQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pQvWO0q76DTHmABO02WjkM/C30AZvAfxIE8RafLKsvZ1C6iaaMCf/O1+tLPYT/iQXoHDcbQbKii/HjvYRBjhoPzgFcrur0G2EmXE8FWCASel5G6OIF9nEX4afd8Y0HHtNAx+QElaZSaJbECefQz0fTcRtGbZIwst4BmDU0fWPho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E3C3JGQS; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743763953; x=1775299953;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NxeOb3XU9HZiCjOnBIg+aBfMeblAE/yTqrISb/aujuQ=;
  b=E3C3JGQSHV3sZ6LhguE12rzVu/ryp1jD6Ne3q/RxganFRQ4iOGpQaA0M
   x0nBkmXmgKf3JBPkx2Ue/J+yJugihtzphOWURB89N70w2prXTi9bDl3Gy
   V6iL/tBkOCrZ/OG3qX9XXt2UGO/f34Sg6hGrvb4Q5+pOvrGZ+HrS5zGLD
   netyiDl9QL2ecAFNEcW88/H5MZjxp4o/eAk8hXXSMLRJuffoX+wLO0vny
   ibSWiQ/nIgSzSvMYnnnd41oe7KEQJ8viqeIkPfov3ACNEFwy34eSwYuTL
   GIC2xfurGnACFnqQTrxwaL5NQV8CJCeWSzr8Pn7NzrXv/i/8irwfHGsa1
   Q==;
X-CSE-ConnectionGUID: PHengl6XS1WDJSvDAF9TKg==
X-CSE-MsgGUID: 1XuoTDv2Q06rn+/rHp/2rw==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="67671966"
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="67671966"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 03:52:32 -0700
X-CSE-ConnectionGUID: UmA6nmdUSm27AxG6o4UHCA==
X-CSE-MsgGUID: nRM0Yzz9QFu4QR65K3z1mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="131409733"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Apr 2025 03:52:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 4 Apr 2025 03:52:31 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 4 Apr 2025 03:52:31 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 4 Apr 2025 03:52:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBncLOm+nCS/G4kEke6vD98KbY0bslf/mpE+SE+D2gYVXNTDbevhJR9jbezQpOuM3uk4IKTGE4xkz4PrT7z48g+AfMpdKVFMAH98Js/3Pv1tY3nI09+DN5tGaSOGzj4PfaI5PRqwBD4H+DXdlyGgxCdcjFzSXk0Nzn+J8AbxUI+rAZXEkTqi2NCKcD/Jy4TV9/Kzpc2sRhTWl2PwbbOoylwCmEIFpZ1UZqpIud/fQAVnoDsTseRUI73q7NHwtYkC2UutXAQSR847T4IRxajyMFwVvPx/y9UV14jKIpY3li7MW+p4BCXBaPKYfLDA+7zYTIrAAbwTS06qJwhewMZ4Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxeOb3XU9HZiCjOnBIg+aBfMeblAE/yTqrISb/aujuQ=;
 b=HbxprYv5gLT3ZuyAN9/PM7kg/P/eQx4PCW46CMweJMONFT/mrs2n+9YoX5+qeb195ZF1CDICnHyn8C4DzQ8FdqwGVisvjzfXM7cvvfqRTCz1yrh7ifagsCjq+vxRSerJgKH9mtNoTkeTbBFdffYeva9UNBSmL2nzTqlJJlnHv7XdPN+vDMpIDvYgSlH/Qz6E9tvspxXGMp33EcWOEqSzHCln+7X00Fy2zdU6BNcQJsuBt2EadoFrLNFkGV/M5mO7zkZ2NebN/uKwmFLajCJQtqbaB5XTocmMc2RJbJECEI4mCw+mmXas3DqW3nbpz8kRTN5erGuIkcD0qBTtSIzGRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by SA1PR11MB5803.namprd11.prod.outlook.com (2603:10b6:806:23e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Fri, 4 Apr
 2025 10:52:28 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::90b0:6aad:5bb6:b3ae]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::90b0:6aad:5bb6:b3ae%5]) with mapi id 15.20.8606.027; Fri, 4 Apr 2025
 10:52:28 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kolacinski, Karol"
	<karol.kolacinski@intel.com>, "horms@kernel.org" <horms@kernel.org>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v3 1/3] ice: remove SW side
 band access workaround for E825
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v3 1/3] ice: remove SW side
 band access workaround for E825
Thread-Index: AQHbmZrMxqByqAX6jEW3mYM0LY14N7OTa1Sw
Date: Fri, 4 Apr 2025 10:52:28 +0000
Message-ID: <IA1PR11MB62414C53CC537B46F9B9581E8BA92@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20250320131538.712326-1-grzegorz.nitka@intel.com>
 <20250320131538.712326-2-grzegorz.nitka@intel.com>
In-Reply-To: <20250320131538.712326-2-grzegorz.nitka@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|SA1PR11MB5803:EE_
x-ms-office365-filtering-correlation-id: 90dc6dd0-c54d-47e8-0b6f-08dd7366caff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?qpMVRcCwUTUiYmz6gegP4GhhJNZYIX6wtXk/raeiUcqSvytkpplysfY2eXdu?=
 =?us-ascii?Q?ZmXBKL6jvF0RWndLLdFDV240z3b1ZgE+dgq2OKk1R/By8qNSDyjgdm1+IWOS?=
 =?us-ascii?Q?CyTMCRdVRsVi65KhNOgDv9cziaAlrlrniCDvSAin+9rE6Azl6l1m1iYHg/ne?=
 =?us-ascii?Q?nawiOP07yfaZlUHxraqgE9RhSiA/z2Ifze+C3TVx6UhuDMAwbiLXz2QAgmF3?=
 =?us-ascii?Q?3eVZLV9PYahBDzfdOHNDWlfBRNBu1eNqAzI5l3nYvymjKNgPN/jjo2OGlFNZ?=
 =?us-ascii?Q?UVd8g3nb0XJkO3i7zQwQFrqOMy1oxg5trd2v8MWpL0gJH/UipM81TeV3vDOA?=
 =?us-ascii?Q?OxRYO11gAdc2bzJrQEBvLD39C7pDyajA4HYnpJ8DlPFzanlZrkIllLlgRZHj?=
 =?us-ascii?Q?4nvU5lt0uDUjyGiIWW//tLKCAV0thDGCSrLuGdy53Yl0yWMQ0RUPhj52kg1B?=
 =?us-ascii?Q?ii2I6UVmZ7lbrsWpsc5W0c/1tofeoPgk90OOajCaeH7ttukPs/YS7nBm6Y/Y?=
 =?us-ascii?Q?DDW5H+RvoEoyK5JNg/Mf0Ytf4cf6XpLqn88y8691Pwp1hf+CjhAnsXcjg0SF?=
 =?us-ascii?Q?osgNbIcOLupVKa38XSS4HhdS8XSn5+jnckwzeDBs5stWtS1iYRJBxLS8LVjr?=
 =?us-ascii?Q?Nv54+xgLALB7+HVUY1fWzz5vxoXDCL4EzqRAE/E2jDyPUkFXaWvAThhGZY1c?=
 =?us-ascii?Q?GULo09XE2h+oPft3jnXIoGga+ixgTGOaaCqWZcqaX594BV/Zr7+syJBfnekX?=
 =?us-ascii?Q?1sf6vJcWproX4CCXPi0dJZTXsF/K73SRZrswjMK3Fd4wEFbKkNLAtzqxcdv1?=
 =?us-ascii?Q?dke5ihN0qXOa5oITKBXE4/bRE9UWRS3ul9ZMJOq/FJLk9BucCjMq3k3mawnu?=
 =?us-ascii?Q?4xnBw+H74Wbzy25P/Ft8NRZN5tRzkmL0mBWXzzYM6xFNUoqjpyUaWY0gJS34?=
 =?us-ascii?Q?2sbWKILp9Vwdvh7FSXuYnjMYSq8RJ+qPDhyctGRcGct3IEsaqmhH4u6CL/2p?=
 =?us-ascii?Q?vmPPmp127YLhE8hxk8VLq3cQ/Z1kci9qcJvM/WlmwY4qIAXW86TpygSIY6WJ?=
 =?us-ascii?Q?amZHRrnmvD8L9xakLNDqRVqoTwkAmg6JHWwCza2Hd44X7sL+NXhc7jZv2oUb?=
 =?us-ascii?Q?+UR+wGVzoceoel+Xy3JZ94GOXBOG+5qdBDzRqbRNPmED2p5v5ci+WiEOTIFb?=
 =?us-ascii?Q?O3qkY6m++u4DbHbzhE3emvA5n0XQKpTeoLSQHJXINHUNIb5jEdcXwtdc/IA5?=
 =?us-ascii?Q?/fKEGw+wiRiF2UkeRvCd+447XjkCERLillARW/W03e9rdzj+SEA9sKVP19Ot?=
 =?us-ascii?Q?JixXZV06FUCoN/wZvCZy4k6aDCn8HZdzL1Bkpj9qJsk7NL+fKyXIsgaZjiJ9?=
 =?us-ascii?Q?cjMwx6WlvvprLMTflr0h7fokE9P8OkcGZsDpgeAJb/F5DeU0RL+Ne3iqzKul?=
 =?us-ascii?Q?oh+xf8PqIb74yph7YacxCEH2Y/D9tSXe?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P3UHYJaZtU/ohxu3leDz1M4ya7vELeyk9X4Rpx+5m1jjqdrUOX2/MOlO60ie?=
 =?us-ascii?Q?L0njsVev1+P9aN47yVRfU/8q7TV+YgF6wZtzxGizP5/QJhQU2a5KGwpntUcb?=
 =?us-ascii?Q?Ltk58i205jMXcO30HVqFsZ2hUlXWbeD/aRU8VNeOV4g9KfXWplceQEneXeLp?=
 =?us-ascii?Q?kpyE4MAkNHHBVGK4TfJkBmynJQ3R8lDz58/Y6yQaind4+tQ3oi9cKzAa/wYr?=
 =?us-ascii?Q?mCauQkCiHRuL9wTuu01+nkGdyURa1D/AoX3pVgkz4GuF0IBcgigZ205oCElo?=
 =?us-ascii?Q?16oOJxtmQ/JydAq2FgSspqHDh1uexD2aE1ppKeKyKQEtxSAhx77tMZZfQlAN?=
 =?us-ascii?Q?fokR8XULeV6i2N8hEbx6L49L6Nrn/RtLNU83ClkEdEyIHUuiZryk7qSzXRou?=
 =?us-ascii?Q?2x+N/mm/JTTiAhw6UlltkLm2hbn1EJ30MGiJdZlUWNN4j1PEgdKpjMGhMny4?=
 =?us-ascii?Q?MtaO5rVZzkA4c6ViDVc7Ob6Cn9AiQBYQpBAjXRxpVY3NAIul5JsJwXze9+ay?=
 =?us-ascii?Q?lHMnJ7lr/olgUcmmaL7/10+RLgHSySUrH/6qKR+mvaWMq0zLbUOMmIxGq7Dq?=
 =?us-ascii?Q?zf9Fyq9HTzQFVDkPUd8pyP6U1Y30/PShoYbDogtWuXsA+OIhESb12sPT1NlB?=
 =?us-ascii?Q?ypxNTsNlBICWcA8ZPjIoioye0fcIJOcbjYfhNlJQDu5/CTR9QJYfDXlQ1yW8?=
 =?us-ascii?Q?viQAOsIrvnhOLWGH3i+4H+ETnSW9Od9/Blnsdvl5IGceUU8DHvQmMEPawXny?=
 =?us-ascii?Q?fI7VdeLzA3wbeOsWMCGssOBWI60/86fNCG7HTxGtDs98xCxnEmvTHgFBF0I6?=
 =?us-ascii?Q?2RwL0FXFEu0ZkUcNUCBZ1PfgMSYcuUhW4kbIKiIwWdL3YAecqfWpRI/OSahu?=
 =?us-ascii?Q?igUjWU/y19VVc1JwHqGsSYBHBQZ8iPkEUPH2pACScUa1sr+ry/qdZ4XAb0/n?=
 =?us-ascii?Q?cRQyLnV/X8LDw5rlSWTu79/RT0ZZLq8okJ4BEG/CE+xQ4/keBAwgNRY/mOMy?=
 =?us-ascii?Q?quRi3kKyNAy/ILukcycVIHV813Mm9dEuMsW8gT+pgFcSjRgNKK/Xd1VJXEcR?=
 =?us-ascii?Q?E464GOQcCiO4+x/CqMLHJyyFkLxhr6L0kjIH3cHZqCnFlaSTpybDynUrmbQT?=
 =?us-ascii?Q?pi0jrOV8GOluZoyBCJW/2mloHjacbxWVyvvrfwRA4aeIuXtjvIyF+z1Abm0c?=
 =?us-ascii?Q?Lk3jO+RbOE3D4wmJHK92rfFU/DF7xY5xDQcsIaLYVW71g1qqT6UUc8EKs1rB?=
 =?us-ascii?Q?L33L17qRdv0FqL7lPFWIsMQmqneaEL7hS4c6GXqlYnl9UFPLKPGzqCZhPJFt?=
 =?us-ascii?Q?vNnyyk0GrOYyj1bgMeYXT2JM5dCbplQVEeuaFJHdxjhETzUB2YISpWyrCvZC?=
 =?us-ascii?Q?AVLcxUw3bIRwYMERX2HzS+LCjkqMDM4su+KcnEtvg7tkq1KgdwMPbQyWqYhJ?=
 =?us-ascii?Q?2GaQXkXTraUhsSkbpbus7evPJvB+6bfotwo9+AF+1C0tJ4962y/x+H0+4Jms?=
 =?us-ascii?Q?yJhtdRPAM7N300NG1why94RvTslsExGLpkhxA3UT3/PheHRDK7SPhnbj1WP6?=
 =?us-ascii?Q?e2mQOevEStKBIdFdzCGcLIqyi2FjYuuL+PVtiDiA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90dc6dd0-c54d-47e8-0b6f-08dd7366caff
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2025 10:52:28.5656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P29+WQtL+kkhBEVhI6VBiGh079w3CD2kXbxxGl3czjMhqEBbVMtXYXfPIbFWByWz80+np6IyL5Mj8PGeOtvGuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5803
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of G=
rzegorz Nitka
> Sent: 20 March 2025 18:46
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kolacinski, Karol <karol.kolacinski@intel.com=
>; horms@kernel.org; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Mi=
chal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v3 1/3] ice: remove SW side ba=
nd access workaround for E825
>
> From: Karol Kolacinski <karol.kolacinski@intel.com>
>=20
> Due to the bug in FW/NVM autoload mechanism (wrong default SB_REM_DEV_CTL=
 register settings), the access to peer PHY and CGU clients was disabled by=
 default.
>
> As the workaround solution, the register value was overwritten by the dri=
ver at the probe or reset handling.
> Remove workaround as it's not needed anymore. The fix in autoload procedu=
re has been provided with NVM 3.80 version.
>
> NOTE: at the time the fix was provided in NVM, the E825C product was not =
officially available on the market, so it's not expected this change will c=
ause regression when running with older driver/kernel versions.
>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> ---
> drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 23 ---------------------
> 1 file changed, 23 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

