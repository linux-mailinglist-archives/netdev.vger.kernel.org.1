Return-Path: <netdev+bounces-195091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B14BACDEB9
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 15:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C1DF1884821
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 13:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A0328F512;
	Wed,  4 Jun 2025 13:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hsAUtmpP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4183C28F508
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 13:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749042671; cv=fail; b=ML1vXeEyssw5YMybkl0+0LukA3ZfXSS4kBk/7LOPvhWNLT2IXXgPnsQOsZZkkuxcZ2as+x3VTqo8yqGGQNr0QzRjPal0HWx3y7R5YoY2Kn2QuGi5bHvifm3AvnKrjgzkCMTuM3KThBqtl/e0tNIi8bVb6X0dKbSQt8HPlD4b+pE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749042671; c=relaxed/simple;
	bh=edeNT1NpQlBtYaggwu6ShobxwRUk1dtnzZknMhxqk5s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s4Bt+OL9lfZ/wtr7eDaSqgwRPhBB7lzA4IrJHq4yw9TMbnW+LeLYqMtSjfZ4TQYvErPP511ZEqbHK2a2eewuVtCJhv1RUOJ+TsJaazXRN6JC2+CxX3bsZF3iAv2b6h+wmDas6vc0H7vdfgD+vB33SUzNk/wmSsvR4C9Putiy5B8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hsAUtmpP; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749042666; x=1780578666;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=edeNT1NpQlBtYaggwu6ShobxwRUk1dtnzZknMhxqk5s=;
  b=hsAUtmpPCI9E3im5OC4yB8Uz1w16GspwFQ30Rs3OcrvPmScUKCM2rHT5
   35FmxUtZwunLvuc1csIwhkgLc8/JRIInQd3io4TX3z+CuRVRcT3D1ZUJq
   pNqCYT5GCN7fzcvUVkQSuRyp8F2UIH1zCCpVSXfgFjItF7j8pPjTT2pNL
   yokNOBvNOdACyThXNcV4CytmtCkE07/XSg+2AwWrXPKKRGljtKjJudX/I
   ZzVCDJ+xhvW6oLLcHjl4ZqAv82Pn0F/bOfY5U3+QkcWAKQVP5x11KRNhI
   yUd8bIN/uE6f5lNLVeECiaofHV4c80xwzTxW5uwIrg+AFC8+/qhkQteqG
   A==;
X-CSE-ConnectionGUID: Ick2yUTCTSOYRf9BQBARpg==
X-CSE-MsgGUID: J5rQRtlhTsK1Neo98fKxiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="54913648"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="54913648"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 06:11:05 -0700
X-CSE-ConnectionGUID: jNtzyzIUQqKG1pep2Mx1pw==
X-CSE-MsgGUID: PmFA9tCITSSGGWsrcnim3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="150346597"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 06:11:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 06:11:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 4 Jun 2025 06:11:04 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.51)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 4 Jun 2025 06:11:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v5JdlsbN7eo+ss+yUmWVxqEKRIjaM5LGA8H/DhIvY8bfEgFmZ9lyw6A85ehGNBGmAnEXaIVjjPUM7PijYFnxAZEXHiX8RAkRrBNGCwku9nf2VaQv+XbfxHWbCKlhT16gfxZ8Zm/k7v9w7jtv+ahZtPunhh5hUo5x9Qc1V73UsO3PBLD96p8QRPMQBonNDqADk91NTjmQOzkWDRIgQdqxi1C00VhOJr8MT2lOwajB//3TCq5yqXegGPfbbaPQJcpPc1txI/2k1fuUGgbp3cQsJldIX1RCU6EJQAL5fTq6X1mGlJuI9UylrSEUb4em+c/ui1gxinrYNqbdkIAwpb77RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccVMhogUu8j7pQTJIjhiZoF2j8s9V0uj9rw6fdOS0wU=;
 b=ujwEtX9PbuR7Uck0rV4xzcr4XtddT9vjmPpOXO+vMj8McBtgltYGm7U7hZciyhyxzyZcKU0Ep5EfZhYiIMVS6VLOS36P9bOjWWV4ru1z9ji8W8+TtR4pOmGKJ2fQip1ZmhPmQOKXErAyC9bvUMbZS46Th847cT0cHQ/nM7SWNd/qv9ZqbD2pN3/JmYhkMrznhlyY8aWixww+GVAr0EZlCSQldUNMnu2D494FikIWldwIRxCJMv8SGXRwBHPBEuACY2L7D6PSQC2pElYTriwEI9gmtt8tYRUlu6QudrZghGq+NTK/cX4PWKNj5fOl3nJQFotCc5OdJyB/e0vO3oZyQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by DM4PR11MB5295.namprd11.prod.outlook.com (2603:10b6:5:392::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Wed, 4 Jun
 2025 13:11:02 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::4955:174:d3ce:10e6]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::4955:174:d3ce:10e6%6]) with mapi id 15.20.8769.022; Wed, 4 Jun 2025
 13:11:02 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Simon Horman <horms@kernel.org>, Marcin Szycik
	<marcin.szycik@linux.intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Zaki, Ahmed"
	<ahmed.zaki@intel.com>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] iavf: fix reset_task for early
 reset event
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] iavf: fix reset_task for early
 reset event
Thread-Index: AQHbtR88iopvVdHBV0eauzLXFUdt7bO5DEkAgDotpSA=
Date: Wed, 4 Jun 2025 13:11:02 +0000
Message-ID: <IA3PR11MB8985888AA97037B8244F9A888F6CA@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20250424135012.5138-2-marcin.szycik@linux.intel.com>
 <20250428124422.GB3339421@horms.kernel.org>
In-Reply-To: <20250428124422.GB3339421@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|DM4PR11MB5295:EE_
x-ms-office365-filtering-correlation-id: cc7635e9-37e5-42f6-e12c-08dda369417f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?WetMGTKM0cPwppsNaSCKCpeM2pzsaMhXw/GQWYPLDiNodkJLTyKMowsZxay1?=
 =?us-ascii?Q?6y5HMEZJJU96TUeR1bp5B4sOp/9V2NxrhwnBmEXMJjsdqJ3YA6C+pQkc2UW1?=
 =?us-ascii?Q?7ObdK+Fr+oVmrvHMCOvezYQWAuiSrSIwD1+FChqF5mytaelvqBG3CLF74MsB?=
 =?us-ascii?Q?whHKccBoWd6HSuY9iAv9VfYD8Q5lapwiJ+7mMhyUB3W57B+adMYREe1KwPut?=
 =?us-ascii?Q?dLVvmPLOPEzEs5jN3j9uyxgRaC4UFkxYsv6GOMopJmx74HZYEklt7WDI9eaq?=
 =?us-ascii?Q?DGK2cJpNHHb5M8HYE2dGGBJ8ycOHRYiV1tVi8FbIJGfWNbX2v9clzO7SDuOq?=
 =?us-ascii?Q?gXus7YBzBt4jp2R9r44TgPRMJroN3LrgTB1gohChDbiqDJg2jW3IzlbHG06T?=
 =?us-ascii?Q?OW/1C9Tnx6FW6AYfhz/z66xiVRf/RZxe15MYH/5AYIZ7AMy1wQwkXRo3yJoU?=
 =?us-ascii?Q?+2qwqez9kdp7whxNOyvkSkotAwRWINTKpKxRkWVzjwWKseqKKvyqEJfNtiNy?=
 =?us-ascii?Q?LIdADN2o3AZ3NKTf5c01HYBhTVNjlPD9LDz/Dpr5uLGAkSfaVvLjiIpGJ+k2?=
 =?us-ascii?Q?Juv0g6LrEz6nqZc7zBkson5qyNKz5XUagXI4p4Y2WBjvPZt8YO2OjOVVnHHK?=
 =?us-ascii?Q?8d2WYMco5ACXtMzfVLRWG1kFG8H++fzQe5klkumn3ajaZmMhSdimc1ojN7g8?=
 =?us-ascii?Q?+dWwdbVQRVKTWnZv2u5nhXT7FLWKsHyJcaUCHCojaF3y0iJTlPmLO0UYvEIK?=
 =?us-ascii?Q?yNjQ1z2/+UY9/3/tULsVNVvDzaRAi9DJ3iIuVbJebe4T3iaVs+5DKuh8XnrG?=
 =?us-ascii?Q?wVhtlRXqjoSSSgCBlXI0UM76UItk/6NdrKbBpldDe+Q2Z74ZFkwmjp4qLtQP?=
 =?us-ascii?Q?22gzdfg/OCOZqG1QBHyg4fuXrpN+16zzzaul7kcvBtqtq4rb++vM5qjAhQaL?=
 =?us-ascii?Q?4MwJOsKsa/uBN3PBi7P1Py+RJjye1O3AX/zMsy/82I0krWrG4SBh0SOM8tZ/?=
 =?us-ascii?Q?PSWJcr6EQACn52TtcqDmH2WdAlTEZ9qYp58SfCo0NNxnnK2gxkEWMWqGny9w?=
 =?us-ascii?Q?6pFRoIT4zkYb1yMi9LML+Z6h+8quX3ZZaaLzbRr2+FfmEtXR4j7j2Lk9JsUx?=
 =?us-ascii?Q?qsXZuDtwF+NdV9Jzxh2pw6TxQhzWAposyDjvlVCYqOb+mG8vi0YAicoBCtoN?=
 =?us-ascii?Q?k7ol4PWO+m88KM/vRl6K5/BbeQqS9sbP45QXZkqrV3eyDjH8lnGDWugBrV4H?=
 =?us-ascii?Q?4OLKjBAhUI0Hf+DsD1JH2k8kIjcInuVUo/vFHx/rJB7qay6ftKS+M7YurOZ0?=
 =?us-ascii?Q?187uJS9fK3PkqfNUYacQac0EdDj1u+ZuSeLv4+uWeJ95sBkkVn5rRmdIs3km?=
 =?us-ascii?Q?24j9ZWUgZigG1QyQKrw3LUFjlE3QJjAvyImsVYEomTQMWl6OyHtKH1TmnY6Y?=
 =?us-ascii?Q?vGCdsIi7QllRHAFq5s+mbnQ0k9xGM9HoX0xqMV5tvTYL7FwyVB5QUidpltQb?=
 =?us-ascii?Q?N/wgOOPk8+eSuX4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hLxGo3Ru035MTJlgw4n3FyA1ux7UEOM88lte/geJ/rUFXIfG1FWdxuav0NyY?=
 =?us-ascii?Q?yxf6gX7vSVkwbBsFWzcA7W9sz+myQJJZZT0Qq/LqxnIQWcAjm9tzdyw5DIZb?=
 =?us-ascii?Q?VchsBEoinQnVtYza6xtT6HrjTVpm1Kb2qnyUFULrZvWchZMHm62iWgLlHWYd?=
 =?us-ascii?Q?zaNlnvG+NxrMaef9Am6C6UsH7AyT9w0d/NHSCfTJN/NLFiRoTSfFlwWb17Nb?=
 =?us-ascii?Q?fcIWjDMPNATNcifm93FqADVyGxxm29GsxhEYB8eoa2FIEwJggExs+/yuUqDp?=
 =?us-ascii?Q?QW3q5e8AeOmE1xeNfbIV1nHFOuaSjXSxC/YhYjRlnCBfPVaDOM+nr94Lrnyg?=
 =?us-ascii?Q?ezQyib3ZUJW/l6IUCMjF9pUG38cRPTmdqYkYAisYQPYUPJqyu0q93SxD80Yr?=
 =?us-ascii?Q?Va2TChhNpvmA5F2updrwxukxSjZr2KUlXySeQxpLH1FRRi+4z5QvBxSUXrsR?=
 =?us-ascii?Q?YfYZS8xCW4cX0QcxO1SNaqen3uWcfYDR1LY4r8tkCM7lqquKJl09FT59LTBR?=
 =?us-ascii?Q?ja+OMUby+JY0KEA71Gf6Q8eGxkaqIc+zX0zMLaCt4BiFO5DDfB4n6YQT6XkJ?=
 =?us-ascii?Q?ibOEQAGkccrpKhaKUal80B200Y+MnKqGOlmBGgo4YXD51Ulw67dXjh4GaHDC?=
 =?us-ascii?Q?utF7DaB3gVWsd+RU5MjDxbmCEB0xNNVXZKpGAgNMTkly4DyZZbHCH9xOWSYu?=
 =?us-ascii?Q?tXwrTrsNsYmnNq9MzkCezCGIeziBb1tIbRUMOt0j8UbdWvnbi3+wpqTHrJ36?=
 =?us-ascii?Q?mw7x9i01mwyOOP0F3qFZWCldlSzU1wAMklfB2lKbOIotNalcGQ674vCE3YUu?=
 =?us-ascii?Q?LDVR68RcnUql+jj/H6AFVRa3wmpt1YNkX7QEzdruMb6k3m/vaS+vZSyID+w4?=
 =?us-ascii?Q?rks/+8LLXHWwCpx4cmsq6m44DcTkASuABD4vhBREppV1/Hl78XSHCRSSb12j?=
 =?us-ascii?Q?76uy3FHxp9co1dt9Y+5+9PfI/bTiZ4IfnE8d71je5V9nUFlVC3+1lQJZ30yL?=
 =?us-ascii?Q?RUtglZXWcrraUeqiDo3TQeTZMC2C5d2DR9jFubaCwTRHmhg5CHi7z2DfPKDZ?=
 =?us-ascii?Q?0zU51qJGnYVHCpt6pcWrPDbb7AMNaWyUa505gUq6E4XihZXMHsOwlIlXUL+k?=
 =?us-ascii?Q?z7g8A1n8d1oZrWpn+k4HypR3Ajnew3NNWTPXH06Kf/EcAiaStp8KMlIlFaxi?=
 =?us-ascii?Q?nOAiW97ARBki6PmvZUTn7z87Kj3bM9KwfCz/LCz7ntYEdMPduTCQzvhQRn9y?=
 =?us-ascii?Q?Dt2s3N5wgP1PNzhJkPN5xVhhj0y/zY9sreqYsX6J/JPb7DmBQSlbVzaE+kX1?=
 =?us-ascii?Q?nPd6l8SDobyq0zytd5qCIcLpDdwqvQ++2PhVCfT9Cm0uWD6X/OnaMAUxbCvN?=
 =?us-ascii?Q?OuCxMLilWm5wEJwRpMKwLFfc3W4tWWiHdiv7HaWHJrxphFy+o7SJ8N+cZFm4?=
 =?us-ascii?Q?Z+RN9GYn8sjhoRitIH0IqArJnvxvobu/kCGly7a6lXplDHkZcQbtM1JgRH94?=
 =?us-ascii?Q?CYcJhuxUBn4jRiYDlMzxeZc6KghH8WDyl9Z8dHC7OgrOilvYvBiLkZmEu3tr?=
 =?us-ascii?Q?8GnKpzq6hKroDEi/LYXOYPYNf4bih7FHjOxFA1r/2vE/qARPau/dBda4kciF?=
 =?us-ascii?Q?hA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc7635e9-37e5-42f6-e12c-08dda369417f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 13:11:02.1699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y6n477rPz4NptOmCWJBllnQCjasOQhTlKrYA1mk9AkFJGBzgxsL0zyDbfwjkCg45GTYIPzK116K6mldgvlg/rMG7yi6JQ2mr2Xnw/OcGffs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5295
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of S=
imon
> Horman
> Sent: Monday, April 28, 2025 2:44 PM
> To: Marcin Szycik <marcin.szycik@linux.intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Zaki, Ahmed
> <ahmed.zaki@intel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com=
>
> Subject: Re: [Intel-wired-lan] [PATCH iwl-net] iavf: fix reset_task for e=
arly reset
> event
>=20
> On Thu, Apr 24, 2025 at 03:50:13PM +0200, Marcin Szycik wrote:
> > From: Ahmed Zaki <ahmed.zaki@intel.com>
> >
> > If a reset event is received from the PF early in the init cycle, the
> > state machine hangs for about 25 seconds.
> >
> > Reproducer:
> >   echo 1 > /sys/class/net/$PF0/device/sriov_numvfs
> >   ip link set dev $PF0 vf 0 mac $NEW_MAC
> >
> > The log shows:
> >   [792.620416] ice 0000:5e:00.0: Enabling 1 VFs
> >   [792.738812] iavf 0000:5e:01.0: enabling device (0000 -> 0002)
> >   [792.744182] ice 0000:5e:00.0: Enabling 1 VFs with 17 vectors and 16 =
queues
> per VF
> >   [792.839964] ice 0000:5e:00.0: Setting MAC 52:54:00:00:00:11 on VF 0.=
 VF
> driver will be reinitialized
> >   [813.389684] iavf 0000:5e:01.0: Failed to communicate with PF; waitin=
g
> before retry
> >   [818.635918] iavf 0000:5e:01.0: Hardware came out of reset. Attemptin=
g
> reinit.
> >   [818.766273] iavf 0000:5e:01.0: Multiqueue Enabled: Queue pair count
> > =3D 16
> >
> > Fix it by scheduling the reset task and making the reset task capable
> > of resetting early in the init cycle.
> >
> > Fixes: ef8693eb90ae3 ("i40evf: refactor reset handling")
> > Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> > Tested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> > ---
> > This should be applied after "iavf: get rid of the crit lock"
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



