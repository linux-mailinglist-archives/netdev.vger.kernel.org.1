Return-Path: <netdev+bounces-233086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB3CC0C0BE
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 08:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBE8B18A1260
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 07:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5180919D065;
	Mon, 27 Oct 2025 07:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DndFfghJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928E21F1505
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 07:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761549315; cv=fail; b=EL4/9jPqmOXLnzXNxPp80WqNCLo+niE7qzOTfu9k3/W0ArniCOk8gTCnMf5roaBE05WI2myjqL1PznsU1Mwd4vgxyH4yh6sVZ/haxJtQnkDadA82XcTyOm0XGRYKZwpsuL4QNIIGmd82pNLFZjO9FrfHoR6RzYcuNnyfxg/xXW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761549315; c=relaxed/simple;
	bh=SmmiIvlYW1SWy0W/QWCJ+y9SAZLUCXXpyege4erxwyU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uyCgu5ezgP+0VkcfrbGO4az22T+BjXVR1f4JDSahbaDnjOfs0KjOmP7sNACZSBiCrTK4pywsYUk59bONI9q6biv8DwZ+YQyx3WXflSM8mdqkgrvHTfgqmEDr1wNyjCTN5UyDNdYbQ2uXSaDTjWkVp8A85sxIK0UT5787hxQRC/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DndFfghJ; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761549313; x=1793085313;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SmmiIvlYW1SWy0W/QWCJ+y9SAZLUCXXpyege4erxwyU=;
  b=DndFfghJKECipJ2XMyW0ET60EkiVaLpkND3ogYFGHmCEoKitS2NJrXfu
   Z7TbejprN1cR4TrKWeZ9o3ptWoJLj44PhV4pCaa2lSER38SNj/HoCHqO0
   NSYdbj9HdWIOf2hY4z+0Cm+QB91HFphR5xjoKTDkAOzQqdhOAGMpVuWZQ
   STdxB+TK99q8qm1w0mcRSg43WoNSgfo9nizft1yb25wQuDE8fyZypRBO9
   R8YkTSmHr+uLxcBODdfsLgEYlcFVDNZeRbX73tgFQALTG5etywu8HW7Z8
   rZ8Qfy1AW4ZV/uokafUVTUYZ78yvMCZDOxerJ+B5is/tNCegR3/88mMc2
   g==;
X-CSE-ConnectionGUID: a6qb4OK5R+S7MTymir1I6w==
X-CSE-MsgGUID: GpEY5/HETASv7gE7+brT/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="51199163"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="51199163"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 00:15:12 -0700
X-CSE-ConnectionGUID: z0X7G2DpSAy89Bi8b7P78Q==
X-CSE-MsgGUID: 0+cxKTPLSyGvJsYW3/colw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="184864804"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 00:15:11 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 00:15:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 27 Oct 2025 00:15:10 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.63) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 00:15:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dqmzvqZbNu9UZtIFG6N5rBkQP495MHDSzN0ITE2jDdAHc4GEBuoIJ/cW63iHvwp++cSaTOa8Bjy8PTz9WPiNqVN/i4Eg0Mat9cFM5Tpy/P7dZU9YcC3vsErl81K97idCrSiBaRbK0vPJlodc9oMR8jNKkaes4ESvsEn/gXevrFjencyPQfUNuYZyE6+G6ZWn9Z6eDJfj86fP3Ren3knJR0hSyqrhKb9goZHRdZhDl354eoUhEEOv/yZ7JEEiGqrreioqRv5iuJvw6hu/V8EQLI4YxrF2inJ2jWDT3y2eCFXSlD1aKYpzuo5tvTTtXcC2cDSso5Acr3uTra+TdVQZRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27EEK0NJRzWoI9fzKq19+kFqInWK0fv3dcPw0c02+eo=;
 b=ubhvCEmffn9KGqoFnk9xwZx5CCIaVQnTjQkGFqk/p/zEzo3U5WAIA23eNf18JMbpfwAWHPbPBuqeZJ7WBohMCekXlcJ0NmtnHndESyANqxBwQqngBqAlnbXkVd8igPAqpEoUpNMBr8E5RcxOTUFFcW8u/lxMMORl9UcsxE9XMSJ+WEC6BQZbF6KNwNkQ1GKDILX0ltXpP+C60fLb9+hoNXHvpg9V4f8OltDDsUfkpTVJrhl1JQAJZcqb4mTi4nQ9TE+Jppg7LgfCONc6iDXhHoeZ7ivTDfhqaeANvZ8YXSyIbngwyVFHkw1dRpCzaXkYnB9x8x267OUDGcYdWha7QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH7PR11MB6402.namprd11.prod.outlook.com (2603:10b6:510:1fa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 07:15:00 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 07:15:00 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Kohei Enju <enjuk@amazon.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Mitch Williams
	<mitch.a.williams@intel.com>, "kohei.enju@gmail.com" <kohei.enju@gmail.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v1] iavf: fix off-by-one issues
 in iavf_config_rss_reg()
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v1] iavf: fix off-by-one issues
 in iavf_config_rss_reg()
Thread-Index: AQHcRdC9rsPGqRtf3kKh6KjjuBt3drTVlxxA
Date: Mon, 27 Oct 2025 07:15:00 +0000
Message-ID: <IA3PR11MB89863CD2849732EABD1DCF5CE5FCA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251025165902.80411-1-enjuk@amazon.com>
In-Reply-To: <20251025165902.80411-1-enjuk@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH7PR11MB6402:EE_
x-ms-office365-filtering-correlation-id: e95b3095-5063-4c1f-7eb8-08de15288ad7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?6H4W3hC75A1Qbp/cp4kFQdf5sXRPyNFZ4RNUYR0oW80hxJRGdD4sqgtaBfa9?=
 =?us-ascii?Q?Ujjk95PCgYnkAyPCxU9HS8USpGFUDoKyckWEkL8m1U6Coqa5Ldf1l1SHRx4p?=
 =?us-ascii?Q?MUv8J7HQ7RWQ3YxjuQdXRz/79dhfM0+7yaT/8xN2DxuN+PVTIu+BfwndSdAS?=
 =?us-ascii?Q?bu4OTULZNcp4abmxCZ1xEJbkeOqUOnvstoy2iWivxAYG4apzSwlesi6bayjE?=
 =?us-ascii?Q?yYocZtMQJSxLgLgHuvRFD9TXIexzei3J5TgQlgECAzndDFA7fpQ3ziX+3UJo?=
 =?us-ascii?Q?p9x2B0uLkanRYVBlAiXi9aVqS8j11WeLkGnfQGu1TVRQ5Or+3SVQNbwGY+Z3?=
 =?us-ascii?Q?LSydcKfonBGpiKjpanpgtbMMVTQsnLxHZKiC6F8KE63OvpV2SDu8dASNQC4K?=
 =?us-ascii?Q?ld5ryu4OS71clooREPVssLPHhU3sF5H9TppSuwdzFehaIDtvvnk9bQpKy2OT?=
 =?us-ascii?Q?8W3NNw15Iacs1na6OSAvwE+KJ0WfwzMYz/NkD8pVY7RyMSgrjCIbmY7w626l?=
 =?us-ascii?Q?JR4prNGMH1U9hVWsHD8l11GqPPp2WQw1UOQp5nnJXwakSPVTGsU5jysdzBsM?=
 =?us-ascii?Q?fPLHknija613QsP0bhp/W1ajd6MRg9PHjERM3T3z4QVfFqoX/mLfrFdSLxaH?=
 =?us-ascii?Q?HNm25QNuirX085CX5pI3qo9OlenNbJRN3QF5OoROJwJoEdW+JP6zLLBZnOCA?=
 =?us-ascii?Q?Y9Ap9CzxoDGPgkxkaxhaJ0K+Rq9wbVVJW52ltxkoEQMriNyMjK2EYZDIUOwd?=
 =?us-ascii?Q?kd3Z393DTC3QYki6ntEiPtzKMqAXo4g/3BPljzNhsVIRAmyIkUF6v7GDsA3e?=
 =?us-ascii?Q?YoTaHaDGdKP8vFsKSsF1VKDO/EmDGi4hGT+OhdO+qj05h69a161br94Vm+qj?=
 =?us-ascii?Q?plI/WJ9sbM+iyNfhk8tzkrvj/RcZsQ2xpe4DBhD4xgG3y6uW7oDZ7WAyvUbE?=
 =?us-ascii?Q?ldeMVz+St/XsWDCBGdKbszMBlNgl+Z54sW27CaMyyLPA5z8lrYw2PP859Ykh?=
 =?us-ascii?Q?Tacqf2y7i2hieD0M3umL6eXyfcGoXD4/qG+PRKMITivhWJAHSFIvvTmaRYKy?=
 =?us-ascii?Q?nj+KMIUvd7u1t8UsR4IXpxjhsj72dVcNJvH77ooHqQ0Pi7uetLJ35DC2BMZJ?=
 =?us-ascii?Q?I4SKiSJ/BXxJGUfMlI4apQ4K3+hoKTOhZ8Gj57rHPpn0ZaY231AA8VPKqh+v?=
 =?us-ascii?Q?FslPW9+aND4/FTUUvzYsHYefR3+XQCOgdgNtaCXB87boAXvxYvduubs/V/1+?=
 =?us-ascii?Q?JRh2jXhTsFTJh6TWyTEE9FiLQ7eperDivyLoq7aaSc6UpJcfYnh2uCpopvD+?=
 =?us-ascii?Q?rRhCMZj0cb/omPIPmRKOyjAgbPPUbS9Em3AYDMaNEo6Xz7dGyrb23zTu4iq9?=
 =?us-ascii?Q?gpEwWvY4O4g0sxH8n8+eiU8cjnLHe/3z76i+SDePON4yzPoB84TbUr3gQms6?=
 =?us-ascii?Q?ieF03tx/Y6n8SGbu/fSbP2n4QpUY//m2oeVOqsD+SNr/GyIFzHl/Cz66Cl5N?=
 =?us-ascii?Q?vx2hCWI0ipwjL5rMqWfCt7UNTZ+CoE0Yv7A+?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6PUVjMSEuqDxo7jazNZdYHd440xlYvVZlNPjU9hjr98NJAXQdA6Homgkss4O?=
 =?us-ascii?Q?v3ykt0SiQiDR3KwmOyjnk6VvjkNe/Nb2sdVXNd60mzp1eLKYKYcAI1wfLK05?=
 =?us-ascii?Q?5uuo7EWTozS1kWHYls3xaYOLxFKk9mc6p11k+i9tFteKigdD2ipOXtE0S+Xf?=
 =?us-ascii?Q?QiW6rUHf+/tR8H2+xHp0Dh+e4rwpb37TjzogSGxJBOlgiuCVabD65ycR8b/S?=
 =?us-ascii?Q?nXdxddlLa+bS+1wBRsq3VPYGXfOIo4l1d/20eJtni6XdaTkMp4utTAOhjGtM?=
 =?us-ascii?Q?z7sI8p5o0Dq18k0bw54KDnq+sqqX/5h36oEoqT/K4xCYYMlXz5MK/OxR0FEo?=
 =?us-ascii?Q?f2Y4TkMwLcY1g/bT40V+jS17XEb+gGXa8+p+yOb3xVK1QZ8cK5Mrez9cI9RP?=
 =?us-ascii?Q?0DEZF35wgVq8NxcuAiz62FDVoKsUhF1LzwiD+p9f/ng1FCUYOozrcuYI5geS?=
 =?us-ascii?Q?Cwz0NE7B1LlWBvnFLeCCB+lIC0TME72Ww67CGinz3B2oN0IZ1YynfqvcMtXW?=
 =?us-ascii?Q?okwDIdK5EiwVSB7EVT6grQBWfH0+1+desMPgGuPZjqj5X3AwleN00WOv/qa4?=
 =?us-ascii?Q?nL8xtU9Bg1nkrh6odENwzpEmG/f0f7inA+3yGdU/pBqdPGIbQ4ZX9uPIQFUS?=
 =?us-ascii?Q?vaFFfkAl81735DNEdVp+EuLvbfYKXJC6+sSifcCLi/8X1o9vG1kuvAv6ZHTV?=
 =?us-ascii?Q?u2dnkGQZ9QBLWrKuX4pesFESKVuFRoOJ46+Gz5QFjtaSiDEhIyt0crJd/Bo/?=
 =?us-ascii?Q?adnmCL8Pk2s844oOQv0LmjXSePfsMQ8/OSAW28+xyKPPRf/Mox7NaVGrB28M?=
 =?us-ascii?Q?Ajj1KriAx4tAH3RX98wobRIP6a/+3nyG8Opzql2TpRNcIvPa5SIBIKCtDRia?=
 =?us-ascii?Q?UoFOgJOjyo+x7O/5R24mEtLCGHqLFfCKejCDJnoHGCTSesPSxUEEsLlrPqen?=
 =?us-ascii?Q?S5TWjJN5XsrAuP5lP6D6Rn26oaYpuTbxQqkVpbUY+Mye/CKvKps3aeI5nnk2?=
 =?us-ascii?Q?hZhIqxBS0EPGzM+og/L+iEHgfmZ42HjVSXfVsPDUiRvEBOa5OgkFx8ArYpgd?=
 =?us-ascii?Q?+cer2yBOabFEIIYzUTL41ijz5JWfO7/9o+i0u5XfZzxjhhncdZKyim/TOFQz?=
 =?us-ascii?Q?IeThEA0F+2bgwKNrqrBUgc6u0cYMMRtdqyroa/kxzNr2r1KvPuP7pfxpX/nh?=
 =?us-ascii?Q?jhocmyqavSZud3RfzVz0edsjghRBf1CNNQuZqwn4jj5EJ08PE9YsPxYcfCs5?=
 =?us-ascii?Q?BjRQnf4lkLwYp7SlfokCNZNJs+JorutwPCU2mIAfER91kvE4zH9bQLff4xwL?=
 =?us-ascii?Q?1AoUrOgjipe7OhCv8DUhQPmzAdmzoFcQI1czbhVgkMZyngnghoWVRMTs7QzQ?=
 =?us-ascii?Q?IkcFRnDs5X7mihkfGtCoDDvY+TKEr1Px/iwKna2dxh57CDRV7qIKVNNUWYJE?=
 =?us-ascii?Q?6CdrR/+hDrvvcAvWVArgbETcAnwJhIJCDsK5Yg4eo1bLF4JizW//tGe9zVzo?=
 =?us-ascii?Q?Jf2QTuIQOsRA/kFJ9f/gwaTEucSjSWUu35tswffCYD1thSIaCQja3FsUrBiC?=
 =?us-ascii?Q?MxraDme8YRowMoB6p+NGk1e+/KZxbBU5mMc8kmrpuyrll2Eu1gkRIOiUcSmu?=
 =?us-ascii?Q?zA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e95b3095-5063-4c1f-7eb8-08de15288ad7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 07:15:00.5188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lRy5wrirh3TO+3SprjkXxf+iSdMW0hgrgHRT5SvJxPyF+53nSNUhik5o2MDGiy8lrgYGRTky31osBFd+ikJmYUD4lSOTSWJkRBj1dutFC4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6402
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Kohei Enju
> Sent: Saturday, October 25, 2025 6:59 PM
> To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Mitch Williams
> <mitch.a.williams@intel.com>; kohei.enju@gmail.com; Kohei Enju
> <enjuk@amazon.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net v1] iavf: fix off-by-one
> issues in iavf_config_rss_reg()
>=20
> There are off-by-one bugs when configuring RSS hash key and lookup
> table, causing out-of-bounds reads to memory [1] and out-of-bounds
> writes to device registers.
>=20
> Before commit 43a3d9ba34c9 ("i40evf: Allow PF driver to configure
> RSS"), the loop upper bounds were:
>     i <=3D I40E_VFQF_{HKEY,HLUT}_MAX_INDEX which is safe since the value
> is the last valid index.
>=20
> That commit changed the bounds to:
>     i <=3D adapter->rss_{key,lut}_size / 4 where `rss_{key,lut}_size /
> 4` is the number of dwords, so the last valid index is
> `(rss_{key,lut}_size / 4) - 1`. Therefore, using `<=3D` accesses one
> element past the end.
>=20
> Fix the issues by using `<` instead of `<=3D`, ensuring we do not exceed
> the bounds.
>=20
> [1] KASAN splat about rss_key_size off-by-one
>   BUG: KASAN: slab-out-of-bounds in iavf_config_rss+0x619/0x800
>   Read of size 4 at addr ffff888102c50134 by task kworker/u8:6/63
>=20
>   CPU: 0 UID: 0 PID: 63 Comm: kworker/u8:6 Not tainted 6.18.0-rc2-
> enjuk-tnguy-00378-g3005f5b77652-dirty #156 PREEMPT(voluntary)
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-
> debian-1.16.3-2 04/01/2014
>   Workqueue: iavf iavf_watchdog_task
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x6f/0xb0
>    print_report+0x170/0x4f3
>    kasan_report+0xe1/0x1a0
>    iavf_config_rss+0x619/0x800
>    iavf_watchdog_task+0x2be7/0x3230
>    process_one_work+0x7fd/0x1420
>    worker_thread+0x4d1/0xd40
>    kthread+0x344/0x660
>    ret_from_fork+0x249/0x320
>    ret_from_fork_asm+0x1a/0x30
>    </TASK>
>=20
>   Allocated by task 63:
>    kasan_save_stack+0x30/0x50
>    kasan_save_track+0x14/0x30
>    __kasan_kmalloc+0x7f/0x90
>    __kmalloc_noprof+0x246/0x6f0
>    iavf_watchdog_task+0x28fc/0x3230
>    process_one_work+0x7fd/0x1420
>    worker_thread+0x4d1/0xd40
>    kthread+0x344/0x660
>    ret_from_fork+0x249/0x320
>    ret_from_fork_asm+0x1a/0x30
>=20
>   The buggy address belongs to the object at ffff888102c50100
>    which belongs to the cache kmalloc-64 of size 64
>   The buggy address is located 0 bytes to the right of
>    allocated 52-byte region [ffff888102c50100, ffff888102c50134)
>=20
>   The buggy address belongs to the physical page:
>   page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0
> pfn:0x102c50
>   flags: 0x200000000000000(node=3D0|zone=3D2)
>   page_type: f5(slab)
>   raw: 0200000000000000 ffff8881000418c0 dead000000000122
> 0000000000000000
>   raw: 0000000000000000 0000000080200020 00000000f5000000
> 0000000000000000
>   page dumped because: kasan: bad access detected
>=20
>   Memory state around the buggy address:
>    ffff888102c50000: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
>    ffff888102c50080: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
>   >ffff888102c50100: 00 00 00 00 00 00 04 fc fc fc fc fc fc fc fc fc
>                                        ^
>    ffff888102c50180: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
>    ffff888102c50200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>=20
> Fixes: 43a3d9ba34c9 ("i40evf: Allow PF driver to configure RSS")
> Signed-off-by: Kohei Enju <enjuk@amazon.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index c2fbe443ef85..4b0fc8f354bc 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -1726,11 +1726,11 @@ static int iavf_config_rss_reg(struct
> iavf_adapter *adapter)
>  	u16 i;
>=20
>  	dw =3D (u32 *)adapter->rss_key;
> -	for (i =3D 0; i <=3D adapter->rss_key_size / 4; i++)
> +	for (i =3D 0; i < adapter->rss_key_size / 4; i++)
>  		wr32(hw, IAVF_VFQF_HKEY(i), dw[i]);
>=20
>  	dw =3D (u32 *)adapter->rss_lut;
> -	for (i =3D 0; i <=3D adapter->rss_lut_size / 4; i++)
> +	for (i =3D 0; i < adapter->rss_lut_size / 4; i++)
>  		wr32(hw, IAVF_VFQF_HLUT(i), dw[i]);
>=20
>  	iavf_flush(hw);
> --
> 2.51.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

