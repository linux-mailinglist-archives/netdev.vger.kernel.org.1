Return-Path: <netdev+bounces-281733-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EoKHkB08GngTgEAu9opvQ
	(envelope-from <netdev+bounces-281733-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 10:48:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E760E480839
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 10:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E4453027D88
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 08:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84C13D5640;
	Tue, 28 Apr 2026 08:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B7SRC36G"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7223D5226;
	Tue, 28 Apr 2026 08:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777366065; cv=fail; b=uDed0VyOFvIeSBuzrWtICMGK6FLT2N9ZCRLiKGLZTQu/TB5/9iAiR1S9oQjm+KwSD69GFsjE9KUuCUZ+hBo5jFpcRvJiSwIBwQ+1viTt2sCjyeHMaRg+Cyx73gUS5MxqBeX2rvY95x3h8WhAcWoFYWHzYjtiqQ1IK1k4lkFP4V0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777366065; c=relaxed/simple;
	bh=zlQjR6ONi4oWuUweLQThC7kw5ciVMN0A96ssgHhlBQ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XDFOYx3UKqtUdfz0fz8WeyeGrh8Lu7Mwqtftg4O+T1EXAFKLz1ZPBws6mI6c0voCNo0q0t0qGdZpn6jT22eSoEFkMZpqnzq0qylGvf6CDu9SeXnx8rdLxf/SLAizcog+azIypoHxnUBqAeyxn23yqseks3qdNwY31RWkUNz9hHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B7SRC36G; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777366065; x=1808902065;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zlQjR6ONi4oWuUweLQThC7kw5ciVMN0A96ssgHhlBQ0=;
  b=B7SRC36Gccx2w4xpelYqDPZu48xCfzlbw2lh1ahVCj6vaqG+IH8ju6Ec
   qBPn2+I9sFZwb+vJGMomtDO+CDNc5P8KB4PycHJ0RbQgm/BM/ZaCW9q72
   kq2KjyQ403Nu6YN+b/b2nl+4dCpRR8Ml85P4AzyvGPruyh1PAp8l8jeZn
   7Q1pidWCUUOGc2JG+dAU3k7wMjst0ol0RPJ+yX9mGER4M6kzETCdHehc9
   3JEBa4ogwI7fdQNjPnzvJGEbkTpzoPNSvF0EEGtiaQgSMKaun/acz+hK6
   QpOP2yhtHWKicuxxRZOv05t+xe2TEgHcncSvSBqM0T5WSzZsDqqWiVXmK
   g==;
X-CSE-ConnectionGUID: Z6DQkI44SZmSd/fsv+glVg==
X-CSE-MsgGUID: zONNFciRTsW5+YCm/1BpsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77972720"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="77972720"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:47:44 -0700
X-CSE-ConnectionGUID: ZTtVUEI9Qbqr57722JnJVg==
X-CSE-MsgGUID: c56dWMN4RLWWuTJ9xafhjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="233845476"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:47:43 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 01:47:42 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 28 Apr 2026 01:47:42 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.26) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 01:47:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMqIjO9VnuB6zpP+aTKFoZCdWh7qJT2TAOCR6yhL6ngQmP+9/xZKcxV/g6g6+B/0TXJW6bKE7qBCKmTgJWGayVZlKmGBczRu69qjxgj26C5pSt9GNu/ZALFzUe06upL22UEcTBYyHqQjlCp02BdBU7/Xb++yDGFEU0lntN9AIuHd6VKSrBkw5ZSiSws2PGuVgE1Zru3dwhq+Q8Ec09NRUgD6HZW2Dxld8diwNpR8DsikxOAqKLEsC1IjgWNWTTynFNPhj9SSXd4x9fKOC8xvwsE+68SjLwxfoMlaDtnlHPnENpevspvJRetQUQ80vdTRe2/AA/6n8pt5HWZpySw8Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybkORzFNB29M14NF+p3LSOFuqiu6R2AE4ApIL7z7ay8=;
 b=dE40fufjkyCJF55yIwvneq/0mxrLFqAvGpjFdpYo6I7m+5qw5sx3biMcxK09s7ii9n07iklNbYoxHpN0+erpi9f4vPCkf6EiIarDh9QMAREvwFo2KxbvzglQW43ZFL8CqPJvmhfeAvqw8lXSq5eGTUMMK+kXNvxx6iwfm1rK0i0cd/v2ExUNLPDFTgMXZyOB/lo0kXPIWdfW0+EJM0+PvjGPakkVFZA5Q/qvMxjslFkSwI1hP0eNZBtmuFXZtwBMmR8jgpNe9uROhCi1RmqOivu+aTzSaVOFFxBnw5U0UFYET1uU8FjIAqtAVM63tdVldvDnHx8jtdpGZ3Tahma1Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by IA4PR11MB8964.namprd11.prod.outlook.com (2603:10b6:208:56f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 08:47:29 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 08:47:29 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, "Zaremba, Larysa"
	<larysa.zaremba@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "Tantilov, Emil S"
	<emil.s.tantilov@intel.com>, "Chittim, Madhu" <madhu.chittim@intel.com>,
	"Hay, Joshua A" <joshua.a.hay@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Shanmugam, Jayaprakash"
	<jayaprakash.shanmugam@intel.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Richard Cochran
	<richardcochran@gmail.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Salin,
 Samuel" <samuel.salin@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v7 07/14] idpf: refactor idpf
 to use libie_pci APIs
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v7 07/14] idpf: refactor idpf
 to use libie_pci APIs
Thread-Index: AQHc1ujyZSMaxGI7NE+CoLBnF9lmm7X0KUQQ
Date: Tue, 28 Apr 2026 08:47:29 +0000
Message-ID: <IA3PR11MB898658952B56FC5666A64EE2E5372@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260428082654.44364-1-larysa.zaremba@intel.com>
 <20260428082654.44364-8-larysa.zaremba@intel.com>
In-Reply-To: <20260428082654.44364-8-larysa.zaremba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|IA4PR11MB8964:EE_
x-ms-office365-filtering-correlation-id: 2fc410cd-93bd-45e0-68f8-08dea502c7b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: UmUvij+xkqIEEjF3xF6BCUdwBYuvp/Q9b9R1GdHlJq2LXUiRz9/es0g/zPUkQF4OpOwZKscSvvXDSdtWRLT+1KnQXgvSQuQmq217BhIRP7FZMBMjIBfQHrpsiNXJBZWitu9HCzjKLvg/pdGVy3YttmyxzG81lyYrNeDQJeZaMxFb7ILUfx3COE+3JRyPjnsGc/W+r8D7RCEO74Gt27pIsfqk3q4OQNXGxMrQz2U1liAE6UR4VdaI9RirioV3DwlBAD+d90SyJqYbwMRhUF5Bar20I8Xfsa6GuqErnZm2t+/L7G+x2s9cay7KbTYX2WW9BgSnizbcoEtWs5eeJ0K55amZysoCSOImBmKh8kDpPK0GZZFwGxwqO56qXONCPTb4pDXyrXPHJSRLQ1IdpI7Da3b3ooII+vhZpO1IsUcIVX8+WDZOCFif/Sgiy8ioxbnkcSsWR09JdX5mJCFnJ/HOsqPIkbUirFOnX099Gy/h6AklgpXBea80r4YuH4LlhHxpHQu9hVdN6s1wBgte/59t0rfZ19AksOLRT8+0JoIFOSoaT/tVgBnZgT0W4kqFqSqL/8dQM41FtKspCbYkN8TNtrJzsL8cG4JH60XZ0EfmgKfYxsEe7bMVMUF9ifSbyS3auUVFWNAxVDhgl1lqjTXzC0u8JkFEo3rk5bBhCEfqWm1LfWz0ASitcCpJ6FOP23grlHVeutJkJTjFdmm+2W9NhUp+x/pIw+fgEr5EjrpCT2h3mIh7XY20Y4OxMESHM2ltQQUrADbt1T5NaA+cAC4cnwE52drvc+g4q9N80iRYZnw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Fkp2WXJPIzUbjj2/TW0zR8cwklJPSHvmeu4RYWVGUQVDCzfeCx7jlFhXE+B0?=
 =?us-ascii?Q?mYl9iUHVOx/1+8J0NVvb2oNR9yJtlY4ZVfcB6HwemnXfvTLVpcxOxRVfnQiM?=
 =?us-ascii?Q?6OGSNTh7Fav+JVcUdLYVbSoMdzIGyhficwIgnWsxI3JA+xCEJAUIJZkYt+9c?=
 =?us-ascii?Q?AGsxBUWGx5h2kdCdXA6TjyjsYd2wPsbBnQqg01rk7UcDz0muXl6zATb4PnpR?=
 =?us-ascii?Q?LRVYilUrmPu+RXZdP52yQN9QEeXTclxVZ9GObjvjqhG7VsAtNQItReelDJNX?=
 =?us-ascii?Q?HsP4hO/cBba+plKbqKTzVH8ZUHTeZ3i/9o+MuNCJxd9UHCV/dJU357T+TfRa?=
 =?us-ascii?Q?0HIeO+9qbzC29om4jMf4AEk13ATETNLv/1OC0nHk94LafjbhxapvNNJ64K4M?=
 =?us-ascii?Q?H+STHBgqyhKL5A83EU8qlRYODzP+VuUrj2xQIk/RG31IXw3CsrWgyvghtMdh?=
 =?us-ascii?Q?wkcMLKWVVzWKn672qIak+jBzXlVAIGS430NPot139jYNg/URrCQbDfAOqF6+?=
 =?us-ascii?Q?qyxw1XJC50zTpUTdbhHEhH1/PAbxt104X1793JSgJQfMby/qoUXpLyov+yhS?=
 =?us-ascii?Q?RUlkszCwPNvBH1YymZTEP7M8RFVIN1UBd+d3r7D0QzAWEl9xZ3U6Pi+zBipB?=
 =?us-ascii?Q?THN7CMfgjLtbd5CJGDKfj3ctSNsPCvWME0yKX5deBTGiGA+BR2tgi9MgUQ/D?=
 =?us-ascii?Q?Mosd/51dUc49PKmbngJoILZWPGHZeTbq/GaFze3H8gmt6eXY62W2BltcUGSb?=
 =?us-ascii?Q?u+DRcNyTxuhBEnChae9HYdeXO7PSs1vhW0x/QGEru9v7VgZuurFRpHg/W1O4?=
 =?us-ascii?Q?KqF+FnXxs9G9WFh98KhISFqxchJhI1Xd86Wi+JTQWmYWMP3D9ZAjCHmhZy9A?=
 =?us-ascii?Q?8pkmw8QL/oJfEwpHZXaANC6KZmvhNCoIrZibOHVD7ZDFQOs0MXrOvtgiHPrJ?=
 =?us-ascii?Q?U/jxUujVBC16ZKfS/WXWMa5SG1xQ/afMcnHZJwVPvqkxdJlGTtE37mc50TC6?=
 =?us-ascii?Q?DP3xNs49KiaG1BFWiaoLi3gDAZukh94jCd1x//MASSltIwa2URY6wLZUeUy1?=
 =?us-ascii?Q?saxVQHG2gvClOqmgl9Bt0ELh3DKHA453OtRykoRXsokYbDqwFyYmcPv8uSQx?=
 =?us-ascii?Q?8JFmC9MFJYylChU1dpaRK5eCm20oRJhgIOAC0XH+zEP1RyS4kgCWCsNwaS6h?=
 =?us-ascii?Q?p00cFwikSI9gbaZjAwB6UnXxIWhjG+aToORvWYUP7DQf8+waJpqIzVQNgutu?=
 =?us-ascii?Q?5Kat56Xe9ULJspzbX4iQbkY1qdEeVPSQgWT9f/XIsc4wKL+QbmvLd4qStCoJ?=
 =?us-ascii?Q?P8jYLL6QPipvIor9dwqUsL3LPY8X7qtA3ALLOFWycAK0GJqo1+38gMQeNZ2g?=
 =?us-ascii?Q?PxLmkGINnfU73aBO/zFYZ3SeUKi2CYZ2yyNA7VZtB5tuNG2cNDYcoLwTxU7H?=
 =?us-ascii?Q?tYBw0WI1a5Z1kgT0mFRLsW2QHqmzNyL5VFBDBhy0AaZ7lsu0z+zbsbUdKY1M?=
 =?us-ascii?Q?3gxx+RGlOSOsfVE8C7sSAzTfNBNkh6JRBTzWC3QLKeRdi6RNkmJQ4HKrlTxa?=
 =?us-ascii?Q?tEGmL9K7MivCGeu7Wfcvp3D27vIc+oqv5wwkXcV2MS6Oaf8ZL15HSx4LG/7O?=
 =?us-ascii?Q?eqDy53dL6NAmVdUfccF3YHEBDAbcc3CVsnjxGlkNJHsYn70evOgYvvVBdtbL?=
 =?us-ascii?Q?N5AXqy2CqAdLScUQfXnLTxsoN+NXWUEyNp/ppw+kKde+ihmKpkd+bDLtEmom?=
 =?us-ascii?Q?ZYPWcmdVqO0OJsnrWdOZHMvbQumauLc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vfeeJI8WQwBOMUTBHzlSqpQXvIpyWgZGyGW6xo/an3M65H1j+gyrxV8NDijNOeEGJGhu+VSg8MyVS69p3OjpYpaI7OslCZJ+iRFxUpdaFkvE9mT3hE4xtrzpWx9LYLTqZ8tw4R1YUuzEmntN8bn5ZZu9fOClfdJlkMZktNqFOkVwCMk6ckmoW43AvcKAVuQ/T0y1/HO4tEoCANjIuds0m8L7PkV7rJSMQJJr6nWZ1cczOAwXiaJ42AGK80HYEDwhkEBXcIKOB9EFmATq4xyO4pXxnHnbopKwAobNfjtyWyuedm2k3HPWd27pAgwvhfRNnTjsRo2J3pnE4f/0kG/ORA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc410cd-93bd-45e0-68f8-08dea502c7b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 08:47:29.1666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pdnGXtWm6fqZhtG1U6knr4kzAnTspsM7miBtC4nXIolydQ43EZaCWJMOiUmGuXR+xr3NpKjWAM69R0C3nPmC30I3q3H/vhQUqiznKuNag7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8964
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: E760E480839
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	TAGGED_FROM(0.00)[bounces-281733-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,gmail.com,lunn.ch,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Larysa Zaremba
> Sent: Tuesday, April 28, 2026 10:27 AM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>
> Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Samudrala,
> Sridhar <sridhar.samudrala@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Zaremba, Larysa
> <larysa.zaremba@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; Tantilov, Emil S
> <emil.s.tantilov@intel.com>; Chittim, Madhu <madhu.chittim@intel.com>;
> Hay, Joshua A <joshua.a.hay@intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; Shanmugam, Jayaprakash
> <jayaprakash.shanmugam@intel.com>; Jiri Pirko <jiri@resnulli.us>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Jonathan Corbet
> <corbet@lwn.net>; Richard Cochran <richardcochran@gmail.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; netdev@vger.kernel.org; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; Salin, Samuel
> <samuel.salin@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v7 07/14] idpf: refactor
> idpf to use libie_pci APIs
>=20
> From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
>=20
> Use libie_pci init and MMIO APIs where possible, struct idpf_hw cannot
> be deleted for now as it also houses control queues that will be
> refactored later. Use libie_cp header for libie_ctlq_ctx that contains
> mmio info from the start in order to not increase the diff later.
>=20
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Co-developed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Tested-by: Samuel Salin <Samuel.salin@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/Kconfig       |   1 +
>  drivers/net/ethernet/intel/idpf/idpf.h        |  70 +-------
>  .../net/ethernet/intel/idpf/idpf_controlq.c   |  26 ++-
>  .../net/ethernet/intel/idpf/idpf_controlq.h   |   2 -
>  drivers/net/ethernet/intel/idpf/idpf_dev.c    |  61 ++++---
>  drivers/net/ethernet/intel/idpf/idpf_idc.c    |  38 ++--
>  drivers/net/ethernet/intel/idpf/idpf_lib.c    |   7 +-
>  drivers/net/ethernet/intel/idpf/idpf_main.c   | 114 ++++++------
>  drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |  57 +++---
>  .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 169 +++++++++--------
> -
>  .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   |  58 +++---
>  11 files changed, 288 insertions(+), 315 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/Kconfig
> b/drivers/net/ethernet/intel/idpf/Kconfig
> index adab2154125b..586df3a4afe9 100644
> --- a/drivers/net/ethernet/intel/idpf/Kconfig
> +++ b/drivers/net/ethernet/intel/idpf/Kconfig
> @@ -6,6 +6,7 @@ config IDPF
>  	depends on PCI_MSI
>  	depends on PTP_1588_CLOCK_OPTIONAL
>  	select DIMLIB
> +	select LIBIE_CP
>  	select LIBETH_XDP
>  	help
>  	  This driver supports Intel(R) Infrastructure Data Path
> Function diff --git a/drivers/net/ethernet/intel/idpf/idpf.h
> b/drivers/net/ethernet/intel/idpf/idpf.h
> index 0d08f51be7e3..efdb58990a8b 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf.h
> @@ -23,6 +23,7 @@ struct idpf_rss_data;
>=20
>  #include <linux/intel/iidc_rdma.h>
>  #include <linux/intel/iidc_rdma_idpf.h>
> +#include <linux/intel/libie/controlq.h>
>  #include <linux/intel/virtchnl2.h>
>=20
>  #include "idpf_txrx.h"
> @@ -625,6 +626,7 @@ struct idpf_vc_xn_manager;
>   * @flags: See enum idpf_flags
>   * @reset_reg: See struct idpf_reset_reg
>   * @hw: Device access data

...

>  	for (i =3D 0; i < num_vecs; i++) {
>  		struct idpf_q_vector *q_vector =3D &rsrc->q_vectors[i];
>  		u16 vec_id =3D rsrc->q_vector_idxs[i] - IDPF_MBX_Q_VEC;
>  		struct idpf_intr_reg *intr =3D &q_vector->intr_reg;
> +		struct idpf_vec_regs *reg =3D &reg_vals[vec_id];
>  		u32 spacing;
>=20
> -		intr->dyn_ctl =3D idpf_get_reg_addr(adapter,
> -
> reg_vals[vec_id].dyn_ctl_reg);
> +		intr->dyn_ctl =3D	libie_pci_get_mmio_addr(mmio,
> +							reg->dyn_ctl_reg);
Stray TAB after =3D

>  		intr->dyn_ctl_intena_m =3D PF_GLINT_DYN_CTL_INTENA_M;
>  		intr->dyn_ctl_intena_msk_m =3D
> PF_GLINT_DYN_CTL_INTENA_MSK_M;
>  		intr->dyn_ctl_itridx_s =3D PF_GLINT_DYN_CTL_ITR_INDX_S; @@

...

>=20
>  	return 0;
>  }
> --
> 2.47.0


