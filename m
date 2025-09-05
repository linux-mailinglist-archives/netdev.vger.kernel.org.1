Return-Path: <netdev+bounces-220314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB75DB4560F
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 13:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CD227BF571
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 11:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B63350821;
	Fri,  5 Sep 2025 11:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BJ2kHyf8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B435D286898;
	Fri,  5 Sep 2025 11:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070909; cv=fail; b=QoCiLlGjzmd2ZsrYjqR8XMxklHyzE7W1ULHvms5cmID4GPYBe0U9oUIsqOsA0ftcvljfdD6iaBlJBvrKMKPd6ki/qZKP9rXaZZAMm5Mnoa2txNAYEewMmEbIfLeEkyuhw4veN+XAaW1cd+XIdb4h0i+ZUa3QcXXzLdvR2gROy6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070909; c=relaxed/simple;
	bh=F3zp1Ray7c+F5gjpW6wLs32gmJC1K0NRlUTThh07Rpw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xn0DtyaUNLwlqJLUiWdhSPSoOfmjovVxZUwR7dQHjPB2ALLPJ41HWjfGe+EngjPJYxhkMOIWB0raPFBsdxNiiqgF/dVRW5AYzanflJzXL//pqUvKjxbRypA/WBByWLZoA+hCSE18VWaugmQuw5eQZmpw2xpOfsoLYejbeX+44Qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BJ2kHyf8; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757070907; x=1788606907;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F3zp1Ray7c+F5gjpW6wLs32gmJC1K0NRlUTThh07Rpw=;
  b=BJ2kHyf8rJ1AlkCmaiwHZZcI4ej6LDxN4UHEVx4p66N1ZFnUcUETuOw1
   WEi/0rtWUGmkZPqhvvRdjFbUawEpULheZBnBnNboDYcxMlWLzEff4YW/T
   uWxmqyUMDPIlFTA+zqGbWL0lrSM7clIKSobaOcflcPTE7DNyUZL5hvazc
   x0jEATgJWRYBawahetLqrX9/NFlnfiKH0hgm/iXUNqeuM2kBH3W039Q9t
   jlMxIgrSYhEMxF5oWgZWjfOjyKRX+koorMGzsE4DGl+2yHoZNUVBSV4tP
   d7BJzXTw+6ASnXsgUzI0H2GbAwE+Zb2l+sDTGCDBnoYJCjQpw61Qp+inn
   A==;
X-CSE-ConnectionGUID: Rfft9yk9SkKWxFg0825LRA==
X-CSE-MsgGUID: rAq+ryzxTpWxBOS/tDksgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="58632789"
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="58632789"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 04:14:13 -0700
X-CSE-ConnectionGUID: 0r4Tnf8KQeSTZVofVB78Yg==
X-CSE-MsgGUID: EdlUHDxJQfW4U6IrRvVLNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="177379487"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 04:14:12 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 04:14:11 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Sep 2025 04:14:11 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.44)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 04:14:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvs+PoeYACt+iIIEO8y2YyS5kYfHZpi8EW7dGRE9UeXpd/sk6l20ycGRPoO0sXZTk11YXrufT9z7joFMUcqcYjSVnrIlb7uKzwPFUtTiGhO+ZcxfNlbYOp4/WHt713uLu5nJr58bXA38ANkoLSlagVQ10HtytTS51rWZLCGgM/E9i9KDL9afJuxD6qpWpTYrOSt7c+ViSQhhSQmZzagpv4NLl4pfeCXUyroMjb27vd9WWVAsWx4YVqZdvFWxzOOND8mG8jxtK0ySYe1g21UOCOYBUMM2YpHne6GNHtJqqUm9r3Aah2N3YOAyyChUb80WS0I+0u21g2DZ48GSh/ztcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3zp1Ray7c+F5gjpW6wLs32gmJC1K0NRlUTThh07Rpw=;
 b=xhlGYTTNo6Nbla/h+P2qBFTMdI24pyI4z+a9BLMY6RZ3Z9J6wBmGYwS0plwxY4yl3rQK08DciHP5qM1WVxIq4q2isEqpHvAH6JCysa4jyK/7Ak5tP6jueoI533LkeEKjnzXOOPC27xy+rLEtZeIoW3kNvxrNCaIUI/eN4Nv485KEUw4973S+p+DTT6RE3y1jFl50Rp08P45yOFeqVA6XIIkhWQYbf0o+3V/A+grOHo/e3LB6eFvn767eGSDK3/pQW3ifB6YKdpNAQwXLmf4xlONqANpH/1pYQTP8Yvw5o4k26SHPm1c+/JbH3byYeLoYWO+Udoy3QQeRUitp9n/S0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB8452.namprd11.prod.outlook.com (2603:10b6:a03:574::22)
 by PH7PR11MB6031.namprd11.prod.outlook.com (2603:10b6:510:1d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 11:14:09 +0000
Received: from SJ2PR11MB8452.namprd11.prod.outlook.com
 ([fe80::d200:bfac:918a:1a38]) by SJ2PR11MB8452.namprd11.prod.outlook.com
 ([fe80::d200:bfac:918a:1a38%4]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 11:14:09 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>, "sdf@fomichev.me"
	<sdf@fomichev.me>, "almasrymina@google.com" <almasrymina@google.com>,
	"asml.silence@gmail.com" <asml.silence@gmail.com>, "leitao@debian.org"
	<leitao@debian.org>, "kuniyu@google.com" <kuniyu@google.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Vecera, Ivan" <ivecera@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [RFC PATCH v2] net: add net-device TX clock source selection
 framework
Thread-Topic: [RFC PATCH v2] net: add net-device TX clock source selection
 framework
Thread-Index: AQHcGDvl/LMwp05JjkKtLLSsBfpR/LR4pqiAgACPnCCAASTjAIAKIApg
Date: Fri, 5 Sep 2025 11:14:09 +0000
Message-ID: <SJ2PR11MB8452D62C5F94C87C6659C5989B03A@SJ2PR11MB8452.namprd11.prod.outlook.com>
References: <20250828164345.116097-1-arkadiusz.kubalewski@intel.com>
	<20250828153157.6b0a975f@kernel.org>
	<SJ2PR11MB8452311927652BEDDAFDE8659B3AA@SJ2PR11MB8452.namprd11.prod.outlook.com>
 <20250829173414.329d8426@kernel.org>
In-Reply-To: <20250829173414.329d8426@kernel.org>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB8452:EE_|PH7PR11MB6031:EE_
x-ms-office365-filtering-correlation-id: c1955c10-617c-4886-db07-08ddec6d55cd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?jqRQ1HtWhXRpjvG2hginNPz3viOQcJB70sb1Rk1zMOMlUR7c52QAU7gJEmBl?=
 =?us-ascii?Q?OBMIfpJRDG0TFVLB8PFAKcTRSiEKk5+Th5oJ4+4D+XHbsVJ8aXXWqr6KxF5D?=
 =?us-ascii?Q?+lVp7QrMNZqK1kYhs//ZyufNUiH8dgevu0wxXTozuqyYXaVUV1lM/VxTTaTA?=
 =?us-ascii?Q?XgGkjGQFfl3LdgBNnrvx94VpNldahH+dXPfIoJcp1SvDhu4DFTHdB05wB2ZR?=
 =?us-ascii?Q?OX7OOhPEb/pgv2f1err7bMn4X5Za+eTtNsNRFe3Qk7mUMUnWgITgadOcpMj+?=
 =?us-ascii?Q?YL7fXv/6ydSqIiZ11NBSh0Y0ulF1brKOIabefCAIIWWe2/Igt2G6/IWGbo6u?=
 =?us-ascii?Q?9HREtZcZGat4SxgzihfqvOonn5WlGFOJ6iKQRMzhLrixM/juQLTY3nnIA2RX?=
 =?us-ascii?Q?SCMINPecbYbV1LesXJ3Mz2jmlYciJw13kfFWxnq2+z754sgnXRybld/WIvnK?=
 =?us-ascii?Q?SrepaXYGUQsdZPr5uQu1vO1A2pdyxePzj2tEIItVynxAfnjbe8RYPDkfvloU?=
 =?us-ascii?Q?BKOIRXy1L539ZK8rsgAHRPwwYWS/ziiO0mvdAkxR5enLKHFs4KXluz59m2/v?=
 =?us-ascii?Q?yTCFxg1NBfTMPmyA3uo9nPvn08Zsgxo4wvBln4/mQZIYGZc7kmwwOfxNK09V?=
 =?us-ascii?Q?MexiVQXfWr8L45pTVAT8grOPOUaa6v8VnhX/eR1zudGUN5atkDb7Ewl/ceRr?=
 =?us-ascii?Q?ZGLpHYVhpRf85tQ598orwKc5X8HBmZet/8aNbRvrddhfvFc11f/w9I8VjKS5?=
 =?us-ascii?Q?3wDgGhr26kozINCejH0wA3e3Z9/FIbvhtaHRrZ9rUQ28/sgMWgJqSfr8z5EJ?=
 =?us-ascii?Q?+249jsqvYouZwswLYZsOuLkSSi9WQNx4l4vIA+pdtz8yyiin8faPk+70dwdE?=
 =?us-ascii?Q?IYJhrfDMczsh/2ns+RPV3iiArdkp/qekysfc6moKtaCFijyF8jeyfxwD0vrz?=
 =?us-ascii?Q?tLwy9ePp7BvK+hSR+Zz7nBk0VklB3ydg/wU1q7xpNnMisF9wZMGoB4sE0bfB?=
 =?us-ascii?Q?ZIp7YpW0QT+z8SMkkVX04BJu2kiTfZOGlr034RpWAPbmalqdvjY88JASurW3?=
 =?us-ascii?Q?Xu4K3nxjFeDKCwawW7rxd1jmZO6rKBzPeWj1gv27ytZchZdPeobREIZPib4L?=
 =?us-ascii?Q?lJSnlCU0RG8WXujc/UWFm74MS7YBpAiJjUihkfWrJPECOyBQjl5o8C/ZGaCY?=
 =?us-ascii?Q?ZJnY/Qs0Ksl1IgtLlsId7y+nJxxAsKYuwdVuhxxWotUo8VQRI1gADPBKx+/K?=
 =?us-ascii?Q?p0nD2KUdpXcpzpr174lwX6f73i4VcgaWJDgrTuR954c71tVd01ZnVsiY8bm/?=
 =?us-ascii?Q?Z4yDo8OuQsqm/tsNx2+T1ROwBClXPG8/7JplEIjUVTagKGztkVEWWVX4yY6m?=
 =?us-ascii?Q?rX1Gu0br1oyORyIMwn1Vu9U3sclUznjdFXZ6jSoJGVAA6X0KGKwShsFbS2nr?=
 =?us-ascii?Q?RXioKiNjoTQa2XQjOThZDbW5qp135J7TFDhT6G1c4MI8Yi9M7xsnKQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8452.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EDPqn+nwk5+wX0n2+WhBU/ZvjeDR30T6nbtJd+yL6xASmc8tS3YoLGJXUdtP?=
 =?us-ascii?Q?MP/U2BmGrHOirecAEkLnUPXsWc8RareFaWOZ/SrzaqlblHtCSdriLQWm7u1x?=
 =?us-ascii?Q?d7K7hL3KtyThUGEPDV5DTQIk4xDsi+CZz0HJHPIPxDe/+DwNhan1DFdgFlzF?=
 =?us-ascii?Q?lNnzb5+KcRfm9wnJ3JxPNbsmbM8539Vb8QQ7DZVvRKzWWA0u3WZxod9Kg4yi?=
 =?us-ascii?Q?aXaQqpQpAdlaqbJKPHWQgLCkUSZ2MPCpxdsS/SN6c8D0hTR2dvqImZOX6rNB?=
 =?us-ascii?Q?gSJhO1gUmuLzQ51LRcruqy7Xmk+EHfDY3GGshlrEdb/jIrcAsKRFbTb9pPyg?=
 =?us-ascii?Q?Y543k+Qn8W7Ro84lLB582VzdPVhgq74BhTk8JEgKd9AZfDLI3JoXlG2Qi50U?=
 =?us-ascii?Q?7hZJpcYy/f2PFbYxaKXK7lgT4UQ9E6mVzLxP7rJEyxvTt1eKvMwxiJ7D9jqf?=
 =?us-ascii?Q?UGlTwZAzl9XuUkwyt9LwdCi3VDaH3fX/ZdthyQPoB07gWmdzV8p/IX2vxX2d?=
 =?us-ascii?Q?T4odz4oL8DHgClaSAJr79E6A638qZGgz8fpnq26T8tcrBaO0FT4ls0+KuDNi?=
 =?us-ascii?Q?Mfyj+iZWFYR8GUPh8R4/B1G0OTNZZOUWQjYuaAT8iOkniKM6JovARkUZPCS4?=
 =?us-ascii?Q?BDkwgCr18/wi89k+bW1aaGVI/XE3axnJy3eohf2kVKQ2hD6dQKJtJIOPFuLZ?=
 =?us-ascii?Q?eIhNt3Y7jOY0Q1ijDRUvCS4CM1+mZZus45sR5sGVlRBUOuTFFWjuFyToHrle?=
 =?us-ascii?Q?9ngeouyjoZ0CcB7AM2ZfkBEZq1qmbldTj/jb9IanuZhBcpUMagaLq4sstb9D?=
 =?us-ascii?Q?Vutm02R+bLY50EnWZROw7NeDa5LrfwttMfQBhAgXRRuGPwSQU8hKoWsvZXSf?=
 =?us-ascii?Q?ifKgDHArUHwvTwGgFpGbH/i6J1p6VEL1lh1sbzq4TE5H1hin2UgijSNX9iZH?=
 =?us-ascii?Q?OKZ/S/GB0WxHKKyBEa5W9tZRul1QvmGA+ZeICmPn5+90ddA7TNFBxxkI9szB?=
 =?us-ascii?Q?2l/oGmm932sM6TMm4IcbA3YTBEkr6eLMxV8KyzXj6IBOBr6yjAuWsJ0gZj2S?=
 =?us-ascii?Q?agAxOnlHxAoRmg+9Hzgdeuy/iWf5VRsfEUVIO0IvMSiRdRlKIaJcsVxCw1Vj?=
 =?us-ascii?Q?MMxtuQODAih1YxndKP/HmQOkXtZEqm0Df/66AsbNiTZsfwaxEo+qp06rg1kf?=
 =?us-ascii?Q?inIytp8EBXFcKB2pGm76W+16j1+62joF6zUi+IKHczrTSMx3PtVpngeHxfiJ?=
 =?us-ascii?Q?TwlYmNGpRuo5iEcJz1ILgydFZ3GaYANWTbVzW4/Pp+LA2nDjpMtihWkLQx74?=
 =?us-ascii?Q?9LB+UeFpgTgCEKv+BCw2ZKj5kAO2HUhUaNd+a7F08H05OZ2Lj0RQrEkuHD89?=
 =?us-ascii?Q?4/4D2TK6JOJ6pSz0ZTtBNDM6q0AX8/2Y6EsHDBv1EWMTrbwCiwNwa82B5tfI?=
 =?us-ascii?Q?n55+22qrqBws7vm9eUYbM5fzbhGcUx6qzCYHucUEHy8jzJ289dwLgpxceWFV?=
 =?us-ascii?Q?ut8e3RCadO3XrhcA37CEuPslAsNmlT+zDgrqb3WT3hU28vWSMtarwgtG3wUu?=
 =?us-ascii?Q?bkgUHjR5RzMWWGukYnYCFyPDNhKWRnc4RVA8NoztFV9EZ7fPQIEW/+iVU1My?=
 =?us-ascii?Q?KA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8452.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1955c10-617c-4886-db07-08ddec6d55cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2025 11:14:09.1502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t/PIs95i00FYPdbCZUzHORG+M+rv+48hs2nsTO8BETe679dXFWcE6O87L4i2+GDsTMhovBz0siW0iktbdegEzI7E3urZofrZxqVAqsn2LLg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6031
X-OriginatorOrg: intel.com

>From: Jakub Kicinski <kuba@kernel.org>
>Sent: Saturday, August 30, 2025 2:34 AM
> On Fri, 29 Aug 2025 07:49:46 +0000 Kubalewski, Arkadiusz wrote:
> > >From: Jakub Kicinski <kuba@kernel.org>
> > >Sent: Friday, August 29, 2025 12:32 AM
> > >
> > >On Thu, 28 Aug 2025 18:43:45 +0200 Arkadiusz Kubalewski wrote: =20
> > >> Add support for user-space control over network device transmit cloc=
k
> > >> sources through a new extended netdevice netlink interface.
> > >> A network device may support multiple TX clock sources (OCXO, SyncE
> > >> reference, external reference clocks) which are critical for
> > >> time-sensitive networking applications and synchronization protocols=
. =20
> > >
> > >how does this relate to the dpll pin in rtnetlink then? =20
> >=20
> > In general it doesn't directly. However we could see indirect relation
> > due to possible DPLL existence in the equation.
> >=20
> > The rtnetlink pin was related to feeding the dpll with the signal,
> > here is the other way around, by feeding the phy TX of given interface
> > with user selected clock source signal.
> >=20
> > Previously if our E810 EEC products with DPLL, all the ports had their
> > phy TX fed with the clock signal generated by DPLL.
> > For E830 the user is able to select if the signal is provided from: the
> > EEC DPLL(SyncE), provided externally(ext_ref), or OCXO.
> >=20
> > I assume your suggestion to extend rtnetlink instead of netdev-netlink?
>=20
> Yes, for sure, but also I'm a little worried about this new API
> duplicating the DPLL, just being more "shallow".
>=20
> What is the "synce" option for example? If I set the Tx clock to SyncE
> something is feeding it from another port, presumably selected by FW or
> some other tooling?
>=20

In this particular case the "synce" source could point to a DPLL device of =
EEC
type, and there is a sense to have it together in one API. Like a two pins
registered with a netdev, one is input and it would be used for clock recov=
ery,
second is output - for tx-clk control - either using the DPLL device produc=
ed
signal or not. Probably worth to mention this is the case with 'external' D=
PLL,
where ice driver doesn't control a DPLL device but it could use the output =
as
is this 'synce' one doing.

> Similar on ext-ref, there has to be a DPLL somewhere in the path,
> in case reference goes away? We assume user knows what "ext-ref" means,
> it's not connected to any info within Linux, DPLL or PTP.
>=20

Adding control over 'ext-ref' muds up the clean story of above.. The 'ext-r=
ef'
source is rather an external pin, which have to be provided with external
clock signal, not defined anywhere else, or connected directly to DPLL devi=
ce.
Purely HW/platform dependent. User needs to know the HW connections, the
signal to this pin could be produced with external signal generator, same h=
ost
but a different DPLL device, or simply different host and device. There can=
 be
a PLL somewhere between generator and TX PHY but there is no lock status, t=
hus
adding new dpll device just to model this seemed an overshot.

Exactly because of nature of 'ext-ref' decided to go with extending the
net device itself and made it separated from DPLL subsystem.=20

Please share your thoughts, right now I see two ways forward:
- moving netdev netlink to rt-netlink,
- kind of hacking into dpll subsystem with 'ext-ref' and output netdev pin.

> OXCO is just an oscillator on the board without a sync. What kind of
> XO it is likely an unnecessary detail in the context of "what reference
> drives the eth clock".
>

I agree this could be hidden, unless there is user case for selecting one
from multiple available in the OS.

> All of these things may make perfect sense when you look at a
> particular product, but for a generic Linux kernel uAPI it does not
> feel very natural.
>=20

Yeah, I like generic, but after all we are all HW dependent.

Thank you!
Arkadiusz

