Return-Path: <netdev+bounces-112571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7586939FB7
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 13:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D178282BF2
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 11:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD33514F109;
	Tue, 23 Jul 2024 11:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iyPE4Puh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1744414A4DA
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 11:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721733818; cv=fail; b=KNstS9WdtVobsOx7GFGdogYbU0/uA8mySZK90AlKlK+r4ZdwIeaq2kY9uV1OYwgfzsuS1lqQb6T17uqdJV/lH5EF875mC21Bbp5K03yaweqpVAiRxkoYeZQgS2jhonpU/vjPb1iWMXt6XA6TmZ8PH8I8im6ymSUGk8J2JY/RZns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721733818; c=relaxed/simple;
	bh=YFasXLGW1FbzITnQsUdPx5lDIhT8OuXGW87VdWLiRn0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kpdjrEZYzGtemZdNNPn+AyAEswoB/NGqq9y4bP0D/GOeZx3HBTkRSlROHVIIBymOl/so+f4coF6DhDkzQySOp8hfujfTzE220yEl5DhlTNIU2zPYud+xYrOPGKZ8rNFYakIvyk+y8rfP56c8mMuXEni+pyg/KCopi/s3F+NnLV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iyPE4Puh; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721733817; x=1753269817;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YFasXLGW1FbzITnQsUdPx5lDIhT8OuXGW87VdWLiRn0=;
  b=iyPE4PuhNtCxG9NxhxTAIhR8O3ZZEtEaOWXwkV67fUKVAVGQYUZbcuKl
   Xab0HHRjb8TCzcpXuRgu6FETx5QjxX+ZumufqavzFZuQAmnzXEYDlarPd
   kpq9k2lRqdsYo7HAEcPgmV3sqUzBw25IAlDxdnJ1YpR/HdUe4AfuQ6PAn
   GBlrFBqhmMzoEv6rN8mBWL26juz9ZgYrLWrrL91TKi6zNG4JRDBMTMQoi
   mh4TtcRkCWqHc9yA+ML2MbSyQCOCB47DwXNE4Ep6PQySQii2VWxT6ADah
   bnkt7Uy6tSszpEhJCmRjm9H2aDpxhumRhe3PHGlBNmCLKdMgMvyWqQk7V
   Q==;
X-CSE-ConnectionGUID: ylUZYaNWQL6vsXT/8NQ27g==
X-CSE-MsgGUID: eWkU4wpWTpeyOn+8ygDMmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="19225649"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="19225649"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 04:23:36 -0700
X-CSE-ConnectionGUID: 4fFKL6DCTR6qKx9EhS4saA==
X-CSE-MsgGUID: oX8JveOzTRqRzBe2gvH+uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="89668207"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jul 2024 04:23:35 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 04:23:35 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 04:23:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 23 Jul 2024 04:23:34 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 23 Jul 2024 04:23:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UcqimMffH9QmERbYkqKbFSD1BBkdTLM1WL7hgAERe8Y7laoPp2nImFrBtTQt74Ic98KwaDb4ZejCIKh1igma9FtJrqRLmaa1nHAvz7lAowSZQQ8kQvz/PphfdvzNKH8NBONwWHTnXV3r14M6mmQZ+R13dmZBXf+32gIcMmgr78uGLBpC3g+boM7mzNjkmKQvWKl4NSuuXJPgHu//IknNKe0AvEr69SLwzL4Y+AnS3ouJNkoPIY9wQ8yq3vm0vB0pim+UEQF8OalzPCF4fJo0i9Nim5CVR5Y1gfXCJMQbbcgV8BZHEO00H0Phpf3NXrMR7pFJOKVhA3creACMR8tT4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6osHvIDoFjpGwtbdOBGK0etwsvaCPiNsPImTgrxRD0=;
 b=yZMbqvUFLST8GamTcTlAQOXnK5WcQB8QIjazbKbbe75lkfsKyQMtiAiZ4JF5cP0vylq6vXCdn5rO5CuERFv6eGpZWFj+fx2HDxAAd+BW6f19iatGMjuzKOV8LBNeBckdLIoyZKMMwY65HeqMyakEOEYtLxB67rdNT6PPqI3hMv5Tz+73GGd8WizgZwwzPF1rIvxrdOsdzZfLGT/cbs/tRDpi5XRn533pxbVdKHStgXzwBhi2sMnBr415Qdthdszfm4SRtQnXft2MtodJkmTHvCud1JK88e5tXNUdAEfu/Dkl8uomilqvQ5CAPT1Ckm7DmX9RRvsfsuE+KCRdrB4vKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com (2603:10b6:a03:428::13)
 by DS0PR11MB7802.namprd11.prod.outlook.com (2603:10b6:8:de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 23 Jul
 2024 11:23:32 +0000
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5]) by SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5%5]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 11:23:32 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "shayd@nvidia.com" <shayd@nvidia.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "horms@kernel.org" <horms@kernel.org>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>, "Polchlopek, Mateusz"
	<mateusz.polchlopek@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "jiri@nvidia.com" <jiri@nvidia.com>,
	"kalesh-anakkur.purayil@broadcom.com" <kalesh-anakkur.purayil@broadcom.com>,
	"Kubiak, Michal" <michal.kubiak@intel.com>, "pio.raczynski@gmail.com"
	<pio.raczynski@gmail.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"Drewek, Wojciech" <wojciech.drewek@intel.com>
Subject: RE: [Intel-wired-lan] [iwl-next v5 10/15] ice: don't set target VSI
 for subfunction
Thread-Topic: [Intel-wired-lan] [iwl-next v5 10/15] ice: don't set target VSI
 for subfunction
Thread-Index: AQHauAO7RgPoIi7TekWqNVvVtEE31LIEdWZQ
Date: Tue, 23 Jul 2024 11:23:32 +0000
Message-ID: <SJ0PR11MB5865DF77D166585D400CF4678FA92@SJ0PR11MB5865.namprd11.prod.outlook.com>
References: <20240606112503.1939759-1-michal.swiatkowski@linux.intel.com>
 <20240606112503.1939759-11-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20240606112503.1939759-11-michal.swiatkowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5865:EE_|DS0PR11MB7802:EE_
x-ms-office365-filtering-correlation-id: 7c1fb45e-fcc5-4d5b-56da-08dcab09e264
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?p64UP2r3kcTKYQISUmR3YTidEZEFHfHb4HDDmzTvECx7m/4Al7jKxwEtxX21?=
 =?us-ascii?Q?gsZXX+RpTuWVEDqazjolI2fDumBd9AjhZa4DCfW4Y1WiexQfJkaeNswR8xcQ?=
 =?us-ascii?Q?u5yLhwwrhBgq02K2uFswiPi08zF1UuuvmJA1/gIuwinaJS0lDvtq9fq7xuy5?=
 =?us-ascii?Q?m8abqCPfZzUAK+EdrI22KUaY5COqZEsVjcecN8vvYsyOajWq4NR7NECjQArb?=
 =?us-ascii?Q?3+LaDajtJuvNQ5K4YDCHbRJbfpccZfpQWBlQcr+AI2ScwjCYwYe47RyOJcWd?=
 =?us-ascii?Q?vYcxTpJBU3DAGrQYXzzOPzj64oc0J6YvzaW3Hl2ZnXGuHAxlbybHSMCrOHxf?=
 =?us-ascii?Q?6IvP6oc7PIONea2LmsCe6hNgt/pztc2ZbBq0dM72HfNbun3ZgCr5qCzb4BxW?=
 =?us-ascii?Q?MZVB/ZZF5PTFIyTTlYXC+jGatp5nShhctBTumiFw+jmpefO6P7UU59rRnftC?=
 =?us-ascii?Q?quMQcYHhjUuqlD0nqrScv2izugTFkrE3JDOdnL/kiBUUq2PC1m7w9eSMyb+g?=
 =?us-ascii?Q?VOwT+IC5S02B1WJIkF50XeBAjnizyicC0IQzNzAiUIUrrpprGCkYXh7R9yhr?=
 =?us-ascii?Q?StOSqaeE96EznZicvBiZCA5j09/JH1j8T0XTm+a8EYPYNyyP6zcR07i9qQYF?=
 =?us-ascii?Q?HGg85tVFzVrA86gWBMIp8QEDVuSUVDhK3zzTgLXRbbv7TVOYdPevR11/7JyE?=
 =?us-ascii?Q?0zjAtyfHFYqGJtu3yFYuE77oBQi8ZJNLOaWNJTOmIp6/s0kI9cEt6a1nmJVS?=
 =?us-ascii?Q?SJYQoGzWc9fNIiPqqMqTP/wgU184PnMm/o37hgtKB98sufLSoJrsC9rGA7RQ?=
 =?us-ascii?Q?mYRQcQGHla7RiyHN7g+eM6WltXR3qhi9WTLK3HAP7udbUNUpgTqgSOdvZdF/?=
 =?us-ascii?Q?ZJcXAweLhhbXVrFgXmNJi2el7GRBPjzQoLwla+iC6oJlw+P6XaVjp1JLdMB4?=
 =?us-ascii?Q?2O5KQMr8TbuaDlpdQt6/yjHgJ+0b89PrxhXAyj9Qx99+MyGsCPB/WcK3IQ8X?=
 =?us-ascii?Q?oY9Ssk/nIZAvyPYROEvs6tmLhQeclCLTu3zHRNymwOpTsOuc1APJAJrOULkM?=
 =?us-ascii?Q?Y0fKARln3GHLrIceuRZwc7jQh5Woq2eDH+fFXu56vi8wrKTNo94q+rMxSK+i?=
 =?us-ascii?Q?yn1tIs4F2ekXdfxfHCNFdIQQ46jJWj5tXzUUNKPnZVsCRQFgWqIjfNTKclWR?=
 =?us-ascii?Q?B5s94Bs/X17rEaMWPaZttWADSff0ASYPfGWhmwmCZvHslF1CZ5FDcBilo3sB?=
 =?us-ascii?Q?KnzGWzYDss0P43yrQ2Ko06fr9s+MwMRUENjPzZttLU1WLgFIjY7XpbRo7dgl?=
 =?us-ascii?Q?vgGOe2zJRmNKEgUlYbIgPsmDklwhvyMuhdXf0LR3/3Yy2lthSCfEcn2rtpa6?=
 =?us-ascii?Q?IxR3tDiSqENISuiggrisf3DNCCQf78iKotQ6UjGFpv+3mD2Opw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CTv0Nw7FgzIzvW4a0usLBlYhlcprAxcL4w5XBJrqhALSPNyyGS2i9mHyKTKZ?=
 =?us-ascii?Q?eKxcMuhz+2b5+38T51hS0oDXjynNlS1OPJbNLUi9YssgZkeUHyRu+pK9q8QF?=
 =?us-ascii?Q?KXLoTSVL+UGOWLxUKN3ShIH4Dq+XicE2Gr4cml3DWDnMK3lhEmcuO6LY0Wf4?=
 =?us-ascii?Q?WlRXMZd27Y+QeaUviWe34UPu8z5+5fuxpeYlymAr3wbv4ng2mDKppqVY2mVa?=
 =?us-ascii?Q?YhRWWSCeLvhZ3XIsnbpcq8lzonMCik8MIW1MKuh9rC3Yu/tSQtRajfIK3iBP?=
 =?us-ascii?Q?KD/94Q8DA+r34axl51hYHj6TRrVPDCEdEJlSGyA0umKJB9nyQmVRq3Hb6vxS?=
 =?us-ascii?Q?Dy7ReSaKULZF0i7H//Ly9/91umeMjN3+y4mV5Ibl1Zt0C245XNBQhfFucuOc?=
 =?us-ascii?Q?ZW5Wx9liMe7tr7/wsbbq4SgdVZMJsqL6WsWb0Te/uB1ePKoOxQQV9CrjFYtv?=
 =?us-ascii?Q?1DcPIQ58sxBqQbXeyePpzBFJZPIbQpFGXZOCRonigyfuH8icuXkJQQ98QIQN?=
 =?us-ascii?Q?I5jlQBq5FbbVZZWhSEBg0hkA9SPFE0sJFWpPHakL9QNAL2Xe3KzI0hB7OdsF?=
 =?us-ascii?Q?ggT2X5D/fiOwTdvzTNgEAmvJL+Rw5oGYgI/6mBVaCQvQrLeKl94hWBx8tdva?=
 =?us-ascii?Q?pRALv6Mxj4AKhdNuMKSfGlSTztrwsqGRedzNNHWhrjDiyGUAC+J/PnHN8UKh?=
 =?us-ascii?Q?USTsjhKM5HhWkty4J+X0hl9wDIE/xE0gIngyz6WM/gWUNDsqfPhagcNsViXT?=
 =?us-ascii?Q?KFRUuAWaIYuy2QQTnoIT5+G9UentzZWkCuU8+15rMooxORBsaCjnYERPZ/f9?=
 =?us-ascii?Q?uk66Xqui40f80HUvjaLU8ayzBzOMBwJz6mb+MhYQjx78HafAJp410giF2RPI?=
 =?us-ascii?Q?8fzX4cdRbOlzU+5V79Annh77MWamQ6X1QiRUJd/exuW/2Qm8AHCmt1Ktk/0y?=
 =?us-ascii?Q?CxSenTnUiSWClC+EjHJXjWmx0fw9AGzmtM99tBwzXOpMLEzuGSUSEihhFoPS?=
 =?us-ascii?Q?YTsnVkXGmjapSXFl3Xm0mtwbhd1ufe1Bd3hr2V42pMKgsM70dSvxLAA708ZN?=
 =?us-ascii?Q?Q2Pjvt+DNLIg/U5fNfqQw9f7mchgD7JnBDHFrH1VYKjG7KXOe0C2Y/5INj3F?=
 =?us-ascii?Q?8rXnJjyzMxnJm/tnT9g+kEIdA7V47bXcy+qdgo3YmYbTk3Ui4RlSVYYt668W?=
 =?us-ascii?Q?DGyLe3mGocSRaH19fph2QJSYXpFbDSLjOCIqszQ8O0zZYHSiVGGCkA5XK9g8?=
 =?us-ascii?Q?ohVeyaMjVJwPJOEajK+2+h3hp5kIWY7EATdA9BJzxQG4e7WwYC5hL6UQr1LC?=
 =?us-ascii?Q?BVVfVnLzZj2W+8vraTIV0lYs8DRRdcxg+m/uhZRnfP2Fd83t+aIL4AUFdxOC?=
 =?us-ascii?Q?Z5zOoEg1swDpYgkaKrtt4ZFFRy+2G+3z7WfhO3AlfyViAhx8iV7QLdwWq5DG?=
 =?us-ascii?Q?tot8NJFeqRShQAWePmSeAZVBPcZV/0/PWM7DUn/qxINAJJb6TN+ae/WjsVc7?=
 =?us-ascii?Q?J5WGkF9Ml/I/i7KLCLgj9eqiWein2dgh4UwZP8fMe/v+mw5cckHUcp54U30/?=
 =?us-ascii?Q?bxBflD68uTCHb61VyKgh/0KAWdU40a+hcsh4JbvnqDOGSzY+fR58D/Y42B51?=
 =?us-ascii?Q?1Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c1fb45e-fcc5-4d5b-56da-08dcab09e264
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 11:23:32.0787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6KR+7AL6gIEZEbjGFIKWpxVX6XuD4PfoQMct2nbcxv5ltzRVUAoAZ+bKGfbnP3BcvouwX/3AAtN4RM6dU92hSsCJUSSMnnbjkZObzcCJ/P4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7802
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
ichal
> Swiatkowski
> Sent: Thursday, June 6, 2024 1:25 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: shayd@nvidia.com; Fijalkowski, Maciej <maciej.fijalkowski@intel.com>;
> horms@kernel.org; Samudrala, Sridhar <sridhar.samudrala@intel.com>;
> Polchlopek, Mateusz <mateusz.polchlopek@intel.com>; netdev@vger.kernel.or=
g;
> jiri@nvidia.com; kalesh-anakkur.purayil@broadcom.com; Kubiak, Michal
> <michal.kubiak@intel.com>; pio.raczynski@gmail.com; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com=
>;
> Drewek, Wojciech <wojciech.drewek@intel.com>
> Subject: [Intel-wired-lan] [iwl-next v5 10/15] ice: don't set target VSI =
for
> subfunction
>=20
> Add check for subfunction before setting target VSI. It is needed for PF =
in
> switchdev mode but not for subfunction (even in switchdev mode).
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c
> b/drivers/net/ethernet/intel/ice/ice_txrx.c
> index 4c115531beba..277e8ea3e06c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> @@ -2405,7 +2405,7 @@ ice_xmit_frame_ring(struct sk_buff *skb, struct
=20
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



