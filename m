Return-Path: <netdev+bounces-281776-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CQ8C/WH8GnuUQEAu9opvQ
	(envelope-from <netdev+bounces-281776-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:12:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E2040482525
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 684AB30008B9
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 10:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B903E5594;
	Tue, 28 Apr 2026 10:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qoy0qM1z"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DDA26B756;
	Tue, 28 Apr 2026 10:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777371097; cv=fail; b=bdN7lzCugka3bc97lagMHavmsm+IvwewGG0c7m251zifxvJjn/+Gd8FRlfbt7aapLPseaDNkyqGVWS9xskyKmFmAnt7tlpWXdLGCEqaSf4GWIGOutvpDeKbBOYHosd67aLqhROKS7PwYs6nfcqvY2ocnji+lJcxboL+tY6Uvx6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777371097; c=relaxed/simple;
	bh=VKT+9ZroM/gSr/vxivpfJroU+z4j8TwNaBo23XjVsDA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gxv+AAi164WHcbwfj85pa4j7AeFxtFh3ACDO0NbKKoYCDW1d8c85j/1H1nmlcUktxrQWlfLiZ3srnnKzfq5LdaCKa9wgXxfRw1cEauOxb20Tad/IenrDhzDk4fueaMILdq65WzqkF5qweRU+04BbSlzZmnRNVCwex1CAjn4pBhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qoy0qM1z; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777371092; x=1808907092;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VKT+9ZroM/gSr/vxivpfJroU+z4j8TwNaBo23XjVsDA=;
  b=Qoy0qM1zROAbvYJPcozGchjHXl2fHL4zgXrm+nhHGUkTF4po+16juT9A
   U4XYxKgZbpSqvrficfJrQW+rVTbGZHqZi4BcaoMkUJ81GbzrDZe7YWblv
   70Hu1dn/TeOslntdcWR3RM5Ev9mpeSZciIR9RBbBgpks5GdOdTY4Whib0
   xKAUxZhE6mArOzKrtLaqw2tQSoIGsVexeheVi4+TGDhXR/ZDYz5JtQJKY
   7eJj8jyTNWbu0yh4fQDhZ1D/SdTj9OGYujQ80Ed3HxbiKdzbxrbo/C173
   j00d1pH5sVRXkFvxD9dabbZbL+cX1KzAlAO15gUMHpzR/N3D2W3jaJ5se
   A==;
X-CSE-ConnectionGUID: 6g6KkfeZRcOAc8dz+kaF6A==
X-CSE-MsgGUID: bwy/QIgbSnaasBnAvg03VQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="65805276"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="65805276"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 03:11:31 -0700
X-CSE-ConnectionGUID: 7npIRChjSYWZSTYqhFRf2Q==
X-CSE-MsgGUID: N7zfUBT5Q2aLfVUjdl8x7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="257223626"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 03:11:31 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 03:11:30 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 28 Apr 2026 03:11:30 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.51)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 03:11:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YpuVi6oJTit8INsJW3Fene+MQ3aolD1g9KIfnazBzk140ClhlwGprH6uKOKcV5dLKUpbQlFeBjReYzb7+tnsgX+hBj09RvmQqZw5RKicpbMHO3Kc0qbDBzqxOodwQHYJkRqpwouOMXhf7M4+iJH5R5Zo9h8LtymVkpOk9cfuJcNvfEwj3YuYLeSGRRc7SWHmLydx/dKHZFVCE3S7ebr5cokdeYM5/Ecx0gMUTbqiG9wy4NSIpkgqSPSUS5J6CCocwc2DCfSDLEAoRYWk8Jj1GLMs4L7Z+gaNZXrayfEiILPVAltMS0RwvKwSw4BAKgFC5s+Eow3Hf08HlmorWAiDrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gT/b4dz3Qd8P3PEnKwrSwedenN4eSG/DlnJZBj7pTpY=;
 b=maO+tWNt0I4ZNbXGcY3Hv2cfM4GnyrMwfMTnX4XSlcUUPxpPCs3PXisQtCmTBpgmn+KXPAqo7HgmkduodebhnpKxnTsq00hMo59xnVpgZ6ZCTBKep6Q6eEl7xGbP4A2yXasnIaVbcocwftekJ05ayBc6f8w9Ph1+b+33gW2IPGRGdoF7zBjYBWC2uCwFfodADcJa04xPOgMPzdz6088JvGhV+cKBrL7+sMT0uJs1vtkJ0dT86oxfQXAXvB4qwE8fgAvBGRGCVpcsOPqo0zbwF9u1yZPBb5HxvYHIQdrPrxSZggRuBBDAAsmQEUkDINukdjEWq4UC80LDPHtYz/yFIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MW3PR11MB4716.namprd11.prod.outlook.com (2603:10b6:303:53::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Tue, 28 Apr
 2026 10:11:28 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 10:11:28 +0000
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
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v7 09/14] idpf: make mbx_task
 queueing and cancelling more consistent
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v7 09/14] idpf: make mbx_task
 queueing and cancelling more consistent
Thread-Index: AQHc1ujrRn8SYixNeE2oi9pXfZqfY7X0QNiA
Date: Tue, 28 Apr 2026 10:11:27 +0000
Message-ID: <IA3PR11MB89867A33B8133A1F0DC30384E5372@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260428082654.44364-1-larysa.zaremba@intel.com>
 <20260428082654.44364-10-larysa.zaremba@intel.com>
In-Reply-To: <20260428082654.44364-10-larysa.zaremba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MW3PR11MB4716:EE_
x-ms-office365-filtering-correlation-id: 09161ab9-de45-4aaf-9c41-08dea50e8315
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|18002099003|38070700021|56012099003;
x-microsoft-antispam-message-info: KCIX9JPtJjQ2k5WOE0DlXGSHCwnmi5xvFCxOndOq8n9/GnmkRZUigcx4IEdUziVoDTUIaZfdnrq3oxM5PDrMr/w3gNCrzS8lSgGJAFvRRDoCjCZnbYxygIftl2RP9Q7sL3zOHveP1eTYUW4W8ipvdHVSZQb4+Curu1aCdsh4xb9ABqHzPgvaX+ESllQRWqa8wNG+cd445E+ikyfzpEbMHGRMkCWrs4+6DciUcZVJYeaJa2OIo69rCulHqDARZWOCFYWD6omVv43CRhhtOmJjldYF8a2y6speXnROEQ2CeMaCAhQErJXuXMOuF29ap7b37Vl6y61+c5X9Fj0HPoIjU2J9gCdGDXse8lhlowLqY4+Jdqv6DaGE6j4eVQx0fhUkt5pEPndsFpKgLrOk8qZLrNWG2Xz+Xi3byIYXcNZiPBo+nEXleY6TGOt4UHFgYVVZLZiZKWaj1hiTaWxOljkok0JzP6eR4+40DxzabMmTvnxbOaDlB3CbM2AN6gRGR1FSJukGU2Abjzd2bl044JSBxK4kC697sUq0QUfjOt9fT48AnoPYAF6WHuSzDC3P/qF2wFVj04Te43oqUulFs6yxFmMwYCZcRlnhrxVCcO1LkxOWjV5lok4G8fBPRANBoUUkDJkqH3GAchxa1Ni5ZNI/S5XjqDwFKgkS+apMy1FFyo0SDP4tZzezzF/uDnPdGGFTgBL3CuSkN9e3OY1xIaBwJFqP2PlWwkE90D0JSer+QnLEIbUSiMVka0jiRnzZ9hBoogwZ0oqUMuEQhu4yrH4T+iySCw6R4hxIklhSIk59tp4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(38070700021)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3RgOyE3sKI567kWsRcTHvIIduTkiWAdcURPQbDUiRbU7yPTAX5a5DPd8pFxz?=
 =?us-ascii?Q?tYHSdFUvVoMlFAeXGgWUtikvWfGoO5YY4DSy/7gA0lPcrDuow4JywNdcvHRW?=
 =?us-ascii?Q?rycH4TESu7gxN9pw32+tQLd0rIk5O6D2c1Sg2Sm7+NmsarlttJNFiUJFhzyr?=
 =?us-ascii?Q?HFxfNlMMe2xtpuSpjqzIPuq7OI52M4EvfcJU/FPpXTTGV5+SRxOE1Qfka+PY?=
 =?us-ascii?Q?PZjWCFKmf/5cwC9sRzKemGn0ctBdQZR/TO52U2b1xiDnBTcdsyKApEucllGS?=
 =?us-ascii?Q?AaL3rqjPDqXyI3oLq+zntDUnIrN3HuTkBYrYVAWuG09tbU0/F1UpA/d0dwf/?=
 =?us-ascii?Q?C8OSleUFk9wfBkKUiKbtPp5hbpQS9XNBUYk+Z1o5zBBug4zybrAI72mKJz7E?=
 =?us-ascii?Q?xIEVwZ2N/bciOImFHvnvl+UZO9ZirtGD5OnedK5fusYv5RSncjUFw2xtzAFP?=
 =?us-ascii?Q?8Q4LlQcwyImsCbV7Ra+gVIOLSuCvrOfxAMChvj3CPrZZji0FKDjzNZnAjxn+?=
 =?us-ascii?Q?3QmQikRH2XyxhpsthZn6DgymRg6luMEjuCHsoZofhwoYv7JnzVVzlB9UOjPj?=
 =?us-ascii?Q?xddLXAisCKaGD6KFcebkySWp3DnP2TaSYC7x9OoL0NC2yPVEj+Hnq/e6VkO9?=
 =?us-ascii?Q?cWfyLPcTagivO4eeqO5LB173vjcJckoXrW4lwU9WcGGMl/DInrMOqRL37UJm?=
 =?us-ascii?Q?sAwLOOoPlJ0iwYed2kDqqxKiwndf/KgH5rYSkhHoiNdLTkfJ9JeutDyZ1hf7?=
 =?us-ascii?Q?GJjuVZ4pavPZHOGjjUBrrnXhdvbEE+UWZjRYGhoP7LDmOUN46844HlLj2ZOu?=
 =?us-ascii?Q?mJtfal73zAgol0NJbdBFtIteIfR0a7sbhjaBJeWjMCx+UZjFAd2Ks4rpZRa2?=
 =?us-ascii?Q?VXD8QU9Q8ciK4YbqsqFDaFyFfaN3LrOKt6viTNlj/wsRKWMQe61M6qFoO+j8?=
 =?us-ascii?Q?G403uGE88vL8oXpV20AGd5v33BFAS+/LYtN/3a8cc3apizJxi0Abrmjjq2vI?=
 =?us-ascii?Q?2KpUBQwF08NOcH7tQo6gxRFVVvfOz5ITFMbkbjKnYkgAIaLlVt0axNvl7/lZ?=
 =?us-ascii?Q?myW8Y4+gbaP4o5ebr7WsRi+gV/Lg5eTPuQL1vSTDZu6w45tknfRwsFTClVQk?=
 =?us-ascii?Q?mBa7TAa/Owo4GOehkCr4h/PjCjyrONy6icsKk+2fiR6oCpS7VUr+07QXtgHS?=
 =?us-ascii?Q?eqJ21arqlApotIoHkq/dG+08pCzsm/X2YqF1PXJXyUzkjbt46GkJJUEhWnwE?=
 =?us-ascii?Q?FME59IJfcBbFuLPvy3u6W7voI6vzsJe9yOarUIbMGCUN7lV7zcPj2Q1rSZWy?=
 =?us-ascii?Q?UrlW4iI8EZeplMzcMTkELyPq+tBf28e0A+V5urJ8qc4MHtPeDMkJd0U/3iqF?=
 =?us-ascii?Q?pC9wqcVOJkZTROGWAPrVL4mcbibpfup1RJabiDXP15FmANL8Y2wydlUfiKs4?=
 =?us-ascii?Q?ZtWJ+ZpKxv6Q4puq3IxMTkxM7hI/Ed3Etbz7pZd+mb8Pww9RJ2IBQsJe9Gna?=
 =?us-ascii?Q?YpXXh/xjUHFyyq4iUJed2/Hg4xwXTWLu5m68VTP9nLi1WOwjRiE0Cansj1Nc?=
 =?us-ascii?Q?ZWCWPyh7xDOcOHawncPyXdHU28s74Mnck5lsqUe3JEnIBdnT5XjeckTi5pTf?=
 =?us-ascii?Q?0O+C9/XoJ/4DoEq/B38zWAQ5hpxF+Qo7B0z6KMXa6wmpB5eG38uWXhP/eD1R?=
 =?us-ascii?Q?j+QOro5yLCXiMhAK1EtMFAKitExhQMGz+TcAvmhhIdTCivE77IEhQn8udx6/?=
 =?us-ascii?Q?0lcQ+NLDuUVh1GpWPTY/hnV3HQu5Q88=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GTqaMTn8u9lNoOMWDn+VW8D4VbAFHbOc2ZgaE+DJvfy0gjsuagjrMDM29Fyfp/QPpWX8MNi9LNykXdjGl3J1cEBPb/tQd+nEXXY6UkSEkr8igHP1cKj1IJ5kut5Wpw+p9Ak/aukWKhBQv9fV1U0YKBIqAvdjTaPw6qoAXsBpMJ/0qsAmYuXn5QmqhVDUoALP275kw5jWSUwFu8pEGa6bSuiCBT7ih4uF+vPYvOtptSO48qPrKxQOM2slm3JjegSVTogqU5MzEl8XHXDnR2wQPVUEisyc9x/4/ai3ShHjIF3YDxGxx5FmRvHJF99Z8haMvDV/f16pUHZ3qmVmIplrhg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09161ab9-de45-4aaf-9c41-08dea50e8315
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 10:11:27.9991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CDoMvkRCgtd010ExUo9dGrWOFdrh3fzryy0pDiv2jW+7SJhtW+kk5ZnuQ79bFA47TIrDoCGevWWyvTnj7/sNZLPAAQnDYuJRGiRE3hxndN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4716
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: E2040482525
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281776-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,gmail.com,lunn.ch,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
> Subject: [Intel-wired-lan] [PATCH iwl-next v7 09/14] idpf: make
> mbx_task queueing and cancelling more consistent
>=20
> As a consequence of refactoring idpf code to use libeth APIs,
> idpf_vc_xn_shutdown was merged with and replaced by
> idpf_deinit_dflt_mbx.
> This does not affect the Tx path, as it checked for a presence of an
> xn manager anyway. Rx processing is handled by the mbx_task that is
> not always cancelled before calling the new consolidated mailbox
> deinit function.
> Moreover, in the reset path idpf_intr_rel() reschedules it after the
> deinit is done. This leads to mbx_task referencing the freed mailbox
> and causing KASAN warnings.
>=20
> To remedy this, in the init path, do the first queueing of mbx_task in
> idpf_init_dflt_mbx(), in deinit and reset, always cancel the task in
> idpf_deinit_dflt_mbx() and in every flow first call
> idpf_mb_intr_rel_irq().
>=20
> Reviewed-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Tested-by: Samuel Salin <Samuel.salin@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf.h          | 1 +
>  drivers/net/ethernet/intel/idpf/idpf_lib.c      | 9 ++++-----
>  drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 6 +++++-
>  3 files changed, 10 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf.h
> b/drivers/net/ethernet/intel/idpf/idpf.h
> index 679539a1b947..1d0e32e47e87 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf.h
> @@ -984,6 +984,7 @@ void idpf_vc_event_task(struct work_struct *work);
> void idpf_dev_ops_init(struct idpf_adapter *adapter);  void
> idpf_vf_dev_ops_init(struct idpf_adapter *adapter);  int
> idpf_intr_req(struct idpf_adapter *adapter);
> +void idpf_mb_intr_rel_irq(struct idpf_adapter *adapter);
>  void idpf_intr_rel(struct idpf_adapter *adapter);
>  u16 idpf_get_max_tx_hdr_size(struct idpf_adapter *adapter);  int
> idpf_initiate_soft_reset(struct idpf_vport *vport, diff --git
> a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> index 0d131bf0993e..7988836fbae0 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> @@ -68,9 +68,11 @@ static void idpf_deinit_vector_stack(struct
> idpf_adapter *adapter)
>   * This will also disable interrupt mode and queue up mailbox task.
> Mailbox
>   * task will reschedule itself if not in interrupt mode.
>   */

...

>=20
>  	idpf_vport_params_buf_rel(adapter);
>=20
> --
> 2.47.0


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

