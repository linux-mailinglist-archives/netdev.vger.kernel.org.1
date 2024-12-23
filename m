Return-Path: <netdev+bounces-154076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A86F9FB38C
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 18:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9280F7A1C12
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 17:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4375C1AF0D7;
	Mon, 23 Dec 2024 17:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jDnIdb7B"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D00F17E015
	for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 17:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734974308; cv=fail; b=SOE2qXjXE8+rFcyNm/fK5KSg6ZgFw6+V3pdAUynmxcLHOMn/OYUD1/4XHzrPTbX7tLYYvL41BzPvjnuXohe9KExXtjxlDrNaM9R/3l4sszV47kkrfDjfI1Yml5LInAa7Osof5NtMW2/Q5S7grSCA8QTDfk8JaL5HbfRsUKfWBh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734974308; c=relaxed/simple;
	bh=yS5UxhBe6q2p3NOiuCO+VYjRpllE2XNHJ5B2t37bqeU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tS4K9OuDp0fs/KfCnUChhw2J++Yyi9W89wxzgovBugVhUXDFOw7AStmdbHuZejimPYcOTH/iQcIo5Ftnu83NbOjiP0/Lr8wyKgAVIi/EgLB4yEyjSl8FPwwmjtjQFXXFIVcn5TYGiekove/tyXno7DGxG3gzLrkJYYrpbblOAxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jDnIdb7B; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734974307; x=1766510307;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yS5UxhBe6q2p3NOiuCO+VYjRpllE2XNHJ5B2t37bqeU=;
  b=jDnIdb7BY9I7S1z5FZgYUqOBzOWEyS9Cwgbn0Q42L9Z15SXbFEDA3gIv
   PfI7ghtQS9ymMjpdg9jlcjSUY8uZf1ArXJTqMb0PN0v9aiZNAoIznpPxY
   jtHTjLrT7OQ7SielvxeOPGjKYgR1h/LahOScbAjrqQ0N8jzWtrzdfWX6K
   tkiWrnQPjMzDfRME4XgUOswJzYbnaIbQ7+I2RjKGW5pyuhaL+Gvu70j7z
   RwaqAYxnX6OSWkQ4jxnKCQZNEyXZUE/Hj5zqUza4X9LB7/D7WrUG73Cf8
   zKLghoFtZfrAJaxsRSSiDAjiyciGPZznEqE/tTJAZqFM5uOOpDL9OSaTP
   g==;
X-CSE-ConnectionGUID: MU2tIpD0Sg6g9itvoGNC2A==
X-CSE-MsgGUID: RpouZLqDRpqQ+kA5TVE9Ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11295"; a="35341233"
X-IronPort-AV: E=Sophos;i="6.12,257,1728975600"; 
   d="scan'208";a="35341233"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 09:18:26 -0800
X-CSE-ConnectionGUID: wPftDmV7So24DDsZy6iY9Q==
X-CSE-MsgGUID: mMW9yP7fRNOfSIoSGKZtyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,257,1728975600"; 
   d="scan'208";a="99116079"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Dec 2024 09:18:26 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 23 Dec 2024 09:18:25 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 23 Dec 2024 09:18:25 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 23 Dec 2024 09:18:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mbqKjLYMzj//Yla9b/DIAVUdy4BBA8MV8tebQ46CIXxE5lUS2AJW/xZsqXOUcgBAhHghjespBbNM9zK5fvDS0AXWq1mIs5MKA/Bb7b9D/nGfn4Srnte4OymXmg9NIvhkb9jmWy6GSGroTGiQ9Rr4qndiMsuKrxiMR08soX0nOUassM43BXyTykyzYxlt1KgDIT0AhC3PJ6GSNepfUqhshNTGxQH0vsgepLXqA617kyTxSsPvJ2EMLdCEd9lDitB95Ae3l86za8XU1WYGBRJr5fgRTlCdAdqbWvpRShxcokVZwM/dMxOSjTjqmKdLh/lhoprGd1Qp+I0T8JC74aPIPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jJnYFsOgUESWtiG548VkyjLmFo9CDH2hc0GMTTcdSk=;
 b=uexk2nVUM3ZHoia14Ud0HCiy+dc7ppJQ9hE+ge1NEIQMoDtNnPX9bsFLiHJFvkaKcd7MiW4iqeh15CPsAoBWfhnONbW33EX8IjOOjzKSnKZvLLjy6HdK106E8BqPAObqs/Ek8NazgDKQoeQcTt8FmXRuFpBz9SLjesi/qLN3Ld0oSDN4RnKwoqt0c4E5xJeFhR1iYVOc6fvnM059QW2FrVCFzPoPvZAjyRUfGq2zAEfN0d6orE8oKbH/B03sLqePdaR8hb5P0oE5QTKuWUuv0R1M0HDKutxpdMovkveK3MAAhCVm44YVEYx9bT7X3AWKFt+dC2BOhjBx/lq+ub613g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by CY5PR11MB6187.namprd11.prod.outlook.com (2603:10b6:930:25::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.21; Mon, 23 Dec
 2024 17:18:03 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::90b0:6aad:5bb6:b3ae]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::90b0:6aad:5bb6:b3ae%6]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 17:18:02 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Knitter, Konrad" <konrad.knitter@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "brett.creeley@amd.com"
	<brett.creeley@amd.com>, "marcin.szycik@linux.intel.com"
	<marcin.szycik@linux.intel.com>, "Knitter, Konrad" <konrad.knitter@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v4] ice: add fw and port health
 reporters
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v4] ice: add fw and port
 health reporters
Thread-Index: AQHbS7qg4jYzMB33+kGTst5q0RsbRLLuo/LQ
Date: Mon, 23 Dec 2024 17:18:02 +0000
Message-ID: <IA1PR11MB624145EE61E5BEEE1DECAF2C8B022@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20241211110357.196167-1-konrad.knitter@intel.com>
In-Reply-To: <20241211110357.196167-1-konrad.knitter@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|CY5PR11MB6187:EE_
x-ms-office365-filtering-correlation-id: 9d081918-e5bb-41f6-ad25-08dd2375c201
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?8QM8lD3yb6KO7FLhBbqlJFm66gNmFLM8ge9XSD5Lby8webIxbRdQr2nYcSdp?=
 =?us-ascii?Q?VsNjQuPpTVmoA1YCzptLfETk/Ml8FL6ZxYxQyBaCB6EAme+EGd4kJxbL6gqn?=
 =?us-ascii?Q?mE2Y+HICoM/AeMBXVPU5w6oBrQ8X1B58b5UMvczTUxWK7ZDAfW4r8dtX+iN9?=
 =?us-ascii?Q?6IKgcWEawOY8IVzANZgQ+mgYXeFY0KgKqLKjG02mBDDgEYXtDRrsGUMk+Kbj?=
 =?us-ascii?Q?jNHEUNJo8mo6f9psw4oDWlSs+EbdPI3h2Cc4QmLluHVZj0bcHRgAs0dgHB4E?=
 =?us-ascii?Q?eo75SYBtpLMnMmZKeguOOYuUYSLmPjqJvtYsrnbKnHXMGU0/7tCH7uc/T1ba?=
 =?us-ascii?Q?t2dEFcXPmBDJ1wkqYQRYWC7MxaGU8z8MfloYwgEgas5Vre6pE86Cg1V6m5Vs?=
 =?us-ascii?Q?QuSNFplXQ3NcbnG1qQZUPJepN1oLiFY5tWgoXPpyUUcIPNgSstYLh45MnDYF?=
 =?us-ascii?Q?CMusnJsxcxgSORgeD9MpWS5vFwrHkn7n8+Y8A1S07xWs7rvasmjnKYciILfB?=
 =?us-ascii?Q?+Nn4hLvlslzd31p9vYvWfKTSdE0bH383wmc7qiauuw4QF88maWvnPIElNRXH?=
 =?us-ascii?Q?7QxwUwlhKg2kq9dq9/Zo8LrKMtYZqeOPw44ZmqRvvdZ2PHQxb3ASBt/97QZ1?=
 =?us-ascii?Q?P5ST/+99vtqEaXlr4fCM/ndPfigN4DFwNTD3l4X4YZ3aGAJjXqCYpFjmwR+M?=
 =?us-ascii?Q?mPyrjUl8wQFxNnBVmIx0kpubHVwbI+21t6QcVfOo1t7Oj+8aN5vGEbfWJPM2?=
 =?us-ascii?Q?RSPbiRUfT4C0Jo1DR0+mUqVPxyR1aR4K4GPDgImKcUcaRNloGkm7c1u81v4q?=
 =?us-ascii?Q?UgNstSpNhNSJa+/RQ5e4DuwuthotIKvXeO7+Fowd2xscvUz03/1xwf+D2glD?=
 =?us-ascii?Q?Pme5g9yRAukz6xzos9hiVsZaoQexNI86VFyXjLq0cfDAXubHfBlzcsEAMLCH?=
 =?us-ascii?Q?rlPa+ERiwF5whLj6iyqf7m4gIcEsliACL1oI9oCVfDWf4+ReKjg9t70IPC+2?=
 =?us-ascii?Q?o7ce43ZPgTBxLcqvrzsx8kSy0zjjC0OOXOJxNMKKTPWcfatJ036cyG1cq+Ma?=
 =?us-ascii?Q?oB1IQvIUS8haXn3yYoYz6ZIStepBC+i6OuwGhcQRWEXrAfiulZKpcrdLCm6y?=
 =?us-ascii?Q?NZdtvEhXfHJg6nZPjsUpeaNC5eybjOydlnIafRVYOJqiCjVhjtNl9+Yy5sWr?=
 =?us-ascii?Q?1bIyk5ev67dyfMpoPw9gOvo4cIAsS6dDR/XRpXmd2kDqSRsw5WhR9hPYXzaq?=
 =?us-ascii?Q?HixSvnXRrDINweLsqGG+Fs5ItJso7aQrZwvY7WG0NcUzTxYEzrzljWLktqBW?=
 =?us-ascii?Q?NidxGGYIPShjSrTockp5zFyFb1Isi36El72NU5lDTQp5akCabQrdTFdB25PY?=
 =?us-ascii?Q?mh2MF973xmgSKo/b/AAThyXOlqAncbq2BgjGWhRYIirqZyOc+w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m7pNzmaFu1+n/oP/hFsB15w61k2jvnBBPJ4QgktCBFUnC/ZuGFXSngKnNwbr?=
 =?us-ascii?Q?FgOdOjWHHc/qRRgj97MbnROZu5/E8p4Gefenm2Ye5gY0EmnXNoPe10OvIbdt?=
 =?us-ascii?Q?zg1NLwPCMmx5XgIQ+mrBdyADOrwAFuEzUkXdgU6qcYQxrjI9WdaRU+fCHZ/l?=
 =?us-ascii?Q?k3cV7g6/JW1RmcIMaXPnnvsBnsZjIxmzpeYIAzG11xVP0jETdFHyieWtFEHI?=
 =?us-ascii?Q?MPBfn78zdD2K5SPbsM9wL1gCFgFxlXdiw9kEgHXLzVy8SD/SNRLYAR9VyRhC?=
 =?us-ascii?Q?WOG0gwMhYspSFE7KBNh/ScUaDmommlTrKCGaCAmMETN5+V9FWeVJyI7K+QD3?=
 =?us-ascii?Q?JyqCv0srDyleaM05Eh8iLeLvI8aO/Y3TW3zPsAX5MzJNMDXU7wdshcr8IEUm?=
 =?us-ascii?Q?pzP53Q6zCMzZFtNLey/EwBllywZbb43+Pu9un3/GmoF8knlY1OLa5rVLtAf3?=
 =?us-ascii?Q?7L6mJv0XSUwTRRaUnCz7F6wnL4iEev8tgexSM+SsPPo2wNDazIYeFcYDI9D8?=
 =?us-ascii?Q?Wp6QCQf22nBMFAbHQeh6NBh72mHqxfMTxfGuqBTVjmtX1iifgmLDnl6epKuY?=
 =?us-ascii?Q?fkku6OmAlt/8sa+joWaYKh7Grmjio5My8pFA4/hOvW3Knlzg9bGCPNlkPu75?=
 =?us-ascii?Q?DFuYpZvVU4s5PAxus2QBFWWvsMfMuHJ2yzAmA4JUVA058ECd9/4/t3hU04Fj?=
 =?us-ascii?Q?kw7mYFsZVe/rPblaU+m4tO2W1/+2Vd23XOVDtm3yYQHqKPn6uOGiwH41oYej?=
 =?us-ascii?Q?juDlaOJn9aZOVL9rWyRdXH/A++SevzMq5UBb3MTsCwIj1GiaI38lej5+liTD?=
 =?us-ascii?Q?9x7gmXTLfnSmSiuJt3twsNljsGkT4gzhgFtGzo17C4uA+OsJjqCd4j/U8Kiu?=
 =?us-ascii?Q?tMXvxkRO1d0dujnkVp43JcB8scIt6OJaZ8zTdZ0Bwmp1XFEmwul4og/D5TWj?=
 =?us-ascii?Q?nUOVv3qqkBJKfBUTTUJqzaW+bieD9RXb/ZnVbHO3lvU2S2+G9b7/pe7fkyoW?=
 =?us-ascii?Q?ds9eBKO1cstptWCQZOb1wqI8hCVoneppQvIH1eYF/akbEdd2vPsBbLT5HO9L?=
 =?us-ascii?Q?YaTN+sIzqF8K0A2R+SGPsckzaIqEEml7TanjW8X7iBL9wa0ZiJx10ZbgL8dH?=
 =?us-ascii?Q?RcKyTDOD8bHx0LMVf8incZJXDOoci1cdAsCSB0MCnf0r8T0WrxgTIBW6IRYv?=
 =?us-ascii?Q?WltTuyjJXv3daNlW/G+OSRhFcW4bhwTAE53m78AtGy7sD803sHKf8gsSGWfr?=
 =?us-ascii?Q?Q+BOIKBT4Gc9ZiuK8GL9W7Rn6OsscyIyXye+ZOV8BfRcnDkBFZw0WimO3wdV?=
 =?us-ascii?Q?ceTeGMd+zbN0GPqkbm2EW0zDubmwF/hYQse3Nd8iz4HlCnnqmqbQN0kRxIM6?=
 =?us-ascii?Q?3U2Y7epPBkMxfFaO23RtdanXanr3jsLb9NWO7/0dn0LPtdY79YNsWRlvvxab?=
 =?us-ascii?Q?ozkwJZL2KiJeErXEMQfEjxS4tVReYml9c0aWsITMbsxWNkuAJzjgMLguEBDv?=
 =?us-ascii?Q?mNySej50dKYtp76NEv4fF/0Fdfwut+sVd3CJgadncEfhk1u2KEYaOmPPcYgf?=
 =?us-ascii?Q?QVYdbXyhUxpP4p/JRUhYpdHLJzfoyo5AFSCItMfA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d081918-e5bb-41f6-ad25-08dd2375c201
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2024 17:18:02.8977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eFSDb/KNqnCBrjRKjRJG7MRXMsfnx4+s6mJUH4e76y5KzyTNIrO7XV0gWEkR86eGS2ZMcYHMDs0MUIFqDKCzTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6187
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of K=
onrad Knitter
> Sent: 11 December 2024 16:34
> To: intel-wired-lan@lists.osuosl.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <=
przemyslaw.kitszel@intel.com>; netdev@vger.kernel.org; kuba@kernel.org; pab=
eni@redhat.com; edumazet@google.com; davem@davemloft.net; andrew+netdev@lun=
n.ch; brett.creeley@amd.com; marcin.szycik@linux.intel.com; Knitter, Konrad=
 <konrad.knitter@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v4] ice: add fw and port healt=
h reporters
>
> Firmware generates events for global events or port specific events.
>
> Driver shall subscribe for health status events from firmware on supporte=
d FW versions >=3D 1.7.6.
> Driver shall expose those under specific health reporter, two new reporte=
rs are introduced:
> - FW health reporter shall represent global events (problems with the ima=
ge, recovery mode);
> - Port health reporter shall represent port-specific events (module failu=
re).
>
> Firmware only reports problems when those are detected, it does not store=
 active fault list.
> Driver will hold only last global and last port-specific event.
> Driver will report all events via devlink health report, so in case of mu=
ltiple events of the same source they can be reviewed using devlink autodum=
p feature.
>=20
> $ devlink health
>
> pci/0000:b1:00.3:
> reporter fw
>   state healthy error 0 recover 0 auto_dump true
> reporter port
>    state error error 1 recover 0 last_dump_date 2024-03-17
>	last_dump_time 09:29:29 auto_dump true
>
> $ devlink health diagnose pci/0000:b1:00.3 reporter port
>
> Syndrome: 262
> Description: Module is not present.
> Possible Solution: Check that the module is inserted correctly.
> Port Number: 0
>
> Tested on Intel Corporation Ethernet Controller E810-C for SFP
>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Co-developed-by: Sharon Haroni <sharon.haroni@intel.com>
> Signed-off-by: Sharon Haroni <sharon.haroni@intel.com>
> Co-developed-by: Nicholas Nunley <nicholas.d.nunley@intel.com>
> Signed-off-by: Nicholas Nunley <nicholas.d.nunley@intel.com>
> Co-developed-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Konrad Knitter <konrad.knitter@intel.com>
>
> ---
> v4: Extended documentation to ice_is_fw_health_report_supported.
> Comparing host byte order event_source.
> v3: Changed patch title to add health reporters. Style fixes.
> https://lore.kernel.org/intel-wired-lan/20241209093204.173817-1-konrad.kn=
itter@intel.com/T/#u
> v2: Removal of __VA_OPS__ usage. Style fixes.
> https://lore.kernel.org/intel-wired-lan/20241209111359.GA2581@kernel.org/=
T/#t
> v1: Initial version
> https://lore.kernel.org/intel-wired-lan/20241118104810.477794-1-konrad.kn=
itter@intel.com/#t
>
> Depends-on: https://lore.kernel.org/netdev/20240930133724.610512-1-przemy=
slaw.kitszel@intel.com/T/
> ---
> .../net/ethernet/intel/ice/devlink/health.c   | 295 +++++++++++++++++-
> .../net/ethernet/intel/ice/devlink/health.h   |  14 +-
> .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  87 ++++++
> drivers/net/ethernet/intel/ice/ice_common.c   |  38 +++
> drivers/net/ethernet/intel/ice/ice_common.h   |   2 +
> drivers/net/ethernet/intel/ice/ice_main.c     |   3 +
> drivers/net/ethernet/intel/ice/ice_type.h     |   5 +
> 7 files changed, 436 insertions(+), 8 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

