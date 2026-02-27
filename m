Return-Path: <netdev+bounces-261798-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGofJsNqoWkOswQAu9opvQ
	(envelope-from <netdev+bounces-261798-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:58:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 044EC1B5A95
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6499317FBFF
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 09:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20E8395261;
	Fri, 27 Feb 2026 09:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SrXs6g6W"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2027336AB6E
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 09:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772186036; cv=fail; b=j8fN3vv89m2e8N6UWrzaFdigqJ8IH/dzln9U24D1hNavmAGTE7XBArB1dL0r3zMuVFw7R4LWFdlHs/I1A//BIWR8FFmGUImX/fMDXKO4ewPG0vIeMWuHnt0ijrm8g6bb30uErEMJ0Oppb9HkNa8PVgOzZnayBpOsotinEfv/M0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772186036; c=relaxed/simple;
	bh=qO95eSBNpl3QcveW7qhyp9tzsJ4AE2t4OLkqvrzHJKg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GYQAOO4yqMUo7/lO0wEIDAvhKdJcOQ8qj/40KXhwgz3IS2f6P87+txIGYcBtRv5NDLWm+LYRT/9a7jd1Xd1BzqEIrjKO+cYctL4H5+WCVIfbRYcz4M6G43CNODRvP12RkRXoyanD5hujruKJ+1P4QOldHdJv7HzUFomSNz+Og0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SrXs6g6W; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772186032; x=1803722032;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qO95eSBNpl3QcveW7qhyp9tzsJ4AE2t4OLkqvrzHJKg=;
  b=SrXs6g6WQowd405xLlHPS5+4xtFDKsSRQkmTZUut32cpla+5VGcQoTHj
   v3boY5CyioQThxiHzexGKS97aGPHhoejGuxKMEfhT1iTB0sQQDaoXltf0
   TQQIovpfm4GCl3eIjHIiZxPJJlx86aZ0e1SdQLkMzIViBE87Vgz6Ai+Jv
   B3fz1I02MkiZQpdW3JRma5ThF7jGz1X5be3vt3g4yBoCvaKOJ2DYK4xG1
   ULgaIX+we+MR1ePWHNHIO0nbfQpzxvInIvuqKt4+W616T8VSWSnmkBZ32
   AmqJ4rNOl5SaBzJO08WRoR+324x7Z45Bs1uQeKDNl0Ao9WwNXQGAybyCF
   Q==;
X-CSE-ConnectionGUID: MfU2O0VTTBCsiblOcKyMpw==
X-CSE-MsgGUID: MNL+cEqKRLaa0asA41lnLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="73450000"
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="73450000"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 01:53:51 -0800
X-CSE-ConnectionGUID: LSGsZzcISPWm27/npwCOsA==
X-CSE-MsgGUID: Dn1M+KB6SqWfNYmfnSUHog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="214292200"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 01:53:53 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Feb 2026 01:53:52 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Feb 2026 01:53:52 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.49) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Feb 2026 01:53:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nStvjJz9rvl9F7ZU9IXj3ri/uUxIQQJIlOfXIuyue1nr6PYMxqS+IjRLMJ2Bqjrt2KaGmZJSOF0djt2GXjOB2gbETLu4fu9P7+y9t8wXwPOoN7xGBa2Mhe796E3+gf5/dZqqUPfdnMIZdcOsRoXOcGYZMFWuqsqfpQcVv2/nFphqDAV1oxyENo2L6nnYUWS18peaDee0yKb8u+u2Nu1VqNKT74AdRvPAE85TI7uFbIsWWj7ELG5JGPd2jy2xlPBTYZJDhTco7G8W+2LqLMbfeH2M9UeYkS2Ta2jMv5EozcqKx+Qq4U/ymBjjiHjH9P8gPAlwcQN5PswwJrdGVf71pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4b9RwXxuuxar8aSHin2NCmmDbNU+pkhHTh377NsAEYY=;
 b=hEDWN4Wvc9WlAYcK5nFru2yx8nodkQC9Mq0taFXII0nSt9NSElnhrTgc7wwmisEwussQpEX3qEb/rwagl2nLWq5V0z5UYeyVEqbVNaE4TuWnh8ArrMPnkSTJk2lGgjtUTRuz6LU1i0SzUzF6D5eMdZ9/bj4zOdRGrqKDiVrjfnb3i5W3QWqJhYplEdbj58MhMu3hbwJHqJTbrGHGDqZDbZPLbjXxVdsY6ecS/gw84WEFxo1lNvE8/ohZg7DXTVUJRg4YQM8qFG65tgzrmOOB4MmcG6uLzMhiJ4uEej6g9t/55tDhqARM/VB8yOnM1j2qny9QfgKdsrHyA1KaJjFS3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6258.namprd11.prod.outlook.com (2603:10b6:930:25::16)
 by IA0PR11MB8333.namprd11.prod.outlook.com (2603:10b6:208:491::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 09:53:45 +0000
Received: from CY5PR11MB6258.namprd11.prod.outlook.com
 ([fe80::3aeb:4e49:6de6:9ee]) by CY5PR11MB6258.namprd11.prod.outlook.com
 ([fe80::3aeb:4e49:6de6:9ee%3]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 09:53:44 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Takashi Kozu <takkozu@amazon.com>, "horms@kernel.org" <horms@kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "pmenzel@molgen.mpg.de"
	<pmenzel@molgen.mpg.de>, "Kwapulinski, Piotr" <piotr.kwapulinski@intel.com>,
	"enjuk@amazon.com" <enjuk@amazon.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v6 1/3] igb: prepare for RSS
 key get/set support
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v6 1/3] igb: prepare for RSS
 key get/set support
Thread-Index: AQHclQxat9WdXfjBVESJ3LfBrYyi07WWafMQ
Date: Fri, 27 Feb 2026 09:53:44 +0000
Message-ID: <CY5PR11MB62589640F247F342BD8BDDD88B73A@CY5PR11MB6258.namprd11.prod.outlook.com>
References: <20260203125417.37285-5-takkozu@amazon.com>
 <20260203125417.37285-6-takkozu@amazon.com>
In-Reply-To: <20260203125417.37285-6-takkozu@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6258:EE_|IA0PR11MB8333:EE_
x-ms-office365-filtering-correlation-id: 860a0581-9299-4128-12d5-08de75e6189c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info: De2Ln+HEh5Jug2e13ECJqCAnxI7XEqJJT0lFaJg/LjTgJ8ORGDlOj9R3vOgBPxUWDF/2zJWQyMb9vH1xfqik/40ynmpZex6tKS6GEKuGEgB4XZxZM267lcRPkcQCR9Vu2DIQkS8xuDVt03qAQ4BDIGrg4MS3d2iDF5f9HyTaHeGBm2FlwxPwFAU9rMQIB1H/51ZL1Rhh+l15k2d5e+F3f2nFxddKY1p8EvUTs8X1AZk7GKaq7H9bFmkM03jovoDQ9TqpSyQA9TkbJgpbONCciQtis92pI70iwFIFZBhxmTnNxF+5fLgjwsYDWZPjIa3KvcWSawgnZlzexYQNPWyaxUCJakifluOSK5X5SSOOJb1MFQGXtqCekojGDmnwxM/9yH+KbWCi/u9GK/nTDyImBqe+Yc7ckdoJWfaRy627f1WpBdEMcr7emjKYMw5VQQ6BB0YXFY80bwc2uYd+gfkxLgu5QK0eW0q5KilqG9nUPMswDWq4xGOkSdNd1waOGDqm/UCgzBrSBjta/5hm22+uErZK+ctKBesFllbvuQJVIRdS8QWF4ip0c3kA4ji+ewXVBHqSbrjzUgxB+HnQc31GG/LoBuGK8fG8Y18U4WM1o096zjlJDMCOtvZO7vdHR5xv6R6y3SunU/JwNdyykC1dceks90YT2CjKAN/1Y7LH1dL2dG2k7h5vbaKOA6p25k54s0mLtDpXp1oXL3cU5Fw5+VWzCyJDRBxluLlrgDpeQTUZIXZF3woCsD0twwNOMr2ekxuhB98qWOvEk8PgfXsZZ51TTOnF8RfAccnKjUTRCbs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6258.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dU/EX2eau6JZy3s3t6X5KcapWmr1VM/Eba6sDh+sROC0gpmCHeuI0IJZiykN?=
 =?us-ascii?Q?caKJjwEnVEJj4BQHuLpzDzryuBR4zjMr0x7RwAQk15HbDone1ChxbbgY4TZM?=
 =?us-ascii?Q?DdpNNHzeZIo159+v+m1K7twG9bjDpUTYExRuUZqcCGNjTHiJDeRl4zd1eY8F?=
 =?us-ascii?Q?+d74jMVfzhmkMg4wmFXRpwJYUP3mJih57fbdj8S7Oh/MqOcjItCTRJqEhTLu?=
 =?us-ascii?Q?X3rDBQrarPEH66SYBstzLjZEhJxjTlrlwz+nWwg/ovvwKdMcwmYvEf0iIIV5?=
 =?us-ascii?Q?6evZzZqny1hdO6s4LBqOANdO7/G/jfsnuVgR+oHh3/0Ss4Ah9PV8Dr/qfLhW?=
 =?us-ascii?Q?s/f36xEd5EPzU48FQksk9ROVgC4iznPaPU3jUnK0U/Kr4b7WZbqpm2MS7jBH?=
 =?us-ascii?Q?lMoN9HUpHdhT7o0COJxPwS4tq4C/lVdPJ3lhN6AnSMcSoy+eIAc7QUUXEKCC?=
 =?us-ascii?Q?grhB1AqSGSjIXbd4z3F7zRbfdcoXX1UcDvl8kjFpWHcF5sxJs6gGejDwi1yE?=
 =?us-ascii?Q?vqmsnhVPwW82/MSrNhD0wK4WzZmsmOraip2fMS8sIyexL8rrdWSIwWf0bN7J?=
 =?us-ascii?Q?AH9aJ5j0EMPN720QqU6uLnBfbb1t6O6mYO6qS0JBUMfezqpTtnRXmXWbY5x0?=
 =?us-ascii?Q?C+beNJIn1YOM0FmPCFlf2Moh7nMGNksZDErXY6W9w3Yx70ACvn2m+92bcoQP?=
 =?us-ascii?Q?BYcupLivfAPZW4TKvh7750ZSmCoR1xpIw4uiAnS3+NZuqtfzWEtPUZs64d94?=
 =?us-ascii?Q?MQyv8kMgKsf8MH/fANWSiSP3XpL1aqmRmES1DJbkeUsZgamjQ9EqAl5nl/F5?=
 =?us-ascii?Q?nDI0QcKs8oHg3OJUdsxFz943LtMQghfzQw5txZ6uDndQQzMpg6WRN8Y/cvMv?=
 =?us-ascii?Q?DNG47p1lCAK1mrH5m5VVEkGJgX2WpR72ttstVrBvKeiFN9rahbXI4IpHHUFE?=
 =?us-ascii?Q?gXpyA7nFtWon9nl9NXTKmMNTe3suuObteSSruUNpD4hFkLHMQ2u85R+5Mp2S?=
 =?us-ascii?Q?Jhu8UtJqWWYd4HqERfHSaquzY7YgSanbrM5f0y1DBFdTa4F8yyCopKO16yAJ?=
 =?us-ascii?Q?kfnhdJpEUtQK22lbBgq+CIrWIiZS/nbsP9zfZOtSi8io7/NWgYdxu/rU1jkB?=
 =?us-ascii?Q?66KPrfIsuoA8pzKtECdEg6auPXTCjluyrYrX5D0LLqpioaHj62eRpCHYdfnv?=
 =?us-ascii?Q?JZICIKUuRac+yxlafB0NKFrfz4W1vPufZnknLUp53gWJrDUxmNoDh+MTosm/?=
 =?us-ascii?Q?sPgnphYAPsXWPdC4ceHFVZF7mhllDnuJN68/TgU2FiUm9AnjKT0DEtWVJ737?=
 =?us-ascii?Q?vQ58iQa1hWp1cDNhSJfDNnzhgwmFLnJPccHQC+NxrGtpQv83T3hqlNPDfzXQ?=
 =?us-ascii?Q?fyu5hGWsGqR+86fjvciB0sZKQ6vPM7r/5Q1RfxX7bLa5adU5F1Ne77dfy74m?=
 =?us-ascii?Q?UHO1dpQ+MdfzWZmiAjuyCejuY7kU+k7yhazM3+V9dv7J9XmCjKsAqs+SGc9D?=
 =?us-ascii?Q?gdG8mmVX630Yzzj/dtq5RZYU15iIBIHdjZ7d2o3o4ayxnv7cxeDb2g9VXqIa?=
 =?us-ascii?Q?YTSjiPm6ic2vWLzD5uqbIVVAW+EIRlSX23ij9sYmbqepEiDUzFtUK2YF/bWJ?=
 =?us-ascii?Q?NNckiqYwDV2j8bih4F7Vtvf5iIJ+J3DB4aFTBy8QdEohLo0LJnrAvIOJdfvD?=
 =?us-ascii?Q?yLRbgeGyGIpg0JvJsXpdSw6oXQIQiV56D2JpanBklBx6WBti?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6258.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 860a0581-9299-4128-12d5-08de75e6189c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 09:53:44.8424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hx1JZuUMeJT3bOmyV68/im6f1ToaW7KiN5/V1leIF3YsijibpO8rM3bOu73z04ao+GsHGnDCanfuyv1FY48JkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8333
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261798-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 044EC1B5A95
X-Rspamd-Action: no action

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of T=
akashi Kozu
> Sent: 03 February 2026 18:24
> To: horms@kernel.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <=
przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch; davem@davemloft.net; =
edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; intel-wired-lan@li=
sts.osuosl.org; netdev@vger.kernel.org; Loktionov, Aleksandr <aleksandr.lok=
tionov@intel.com>; pmenzel@molgen.mpg.de; Kwapulinski, Piotr <piotr.kwapuli=
nski@intel.com>; enjuk@amazon.com; Takashi Kozu <takkozu@amazon.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v6 1/3] igb: prepare for RSS k=
ey get/set support
>
> Store the RSS key inside struct igb_adapter and introduce the
igb_write_rss_key() helper function. This allows the driver to program the =
E1000 registers using a persistent RSS key, instead of using a stack-local =
buffer in igb_setup_mrqc().
>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Takashi Kozu <takkozu@amazon.com>
> ---
> drivers/net/ethernet/intel/igb/igb.h         |  3 +++
> drivers/net/ethernet/intel/igb/igb_ethtool.c | 21 ++++++++++++++++++++
> drivers/net/ethernet/intel/igb/igb_main.c    |  8 ++++----
> 3 files changed, 28 insertions(+), 4 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

