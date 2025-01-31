Return-Path: <netdev+bounces-161707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CADF7A2383D
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 01:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6C833A6A91
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 00:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAB68F66;
	Fri, 31 Jan 2025 00:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B4vEinZk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D633312B71
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 00:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738283312; cv=fail; b=XQLpAY0l2IKVbcux+k6OssmT60cpKAA+l6UeIfydClFoJ9r9GYlAJjjgTbw381n3Gi0PEF5sjvFh2142CetsgR/47ThvqtCejig+tsa5ihpPIiAyj1k6GzPKF9+97EfzF43+2z9Ym3FAyxWsdiSInR2/EIPDVPYEVsRpY9ji/kA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738283312; c=relaxed/simple;
	bh=xJMm8A89D3mB060i4fb+J993o2OXasLO14u4V8BrBGk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iNtWjKbFw5l2+5Wi3lAM0S+6Smdrdzkb/n8woJZ/9gg8fqdhafnN4q0gthelIxT/vDQprS4fymsuiBhcV9JvzIpW0EvhyWHYs0r8AhGzjwW7zLtOsOsuec71M+budIX9hhBz7TIUrRzgBqAbBRiBDFCBhkjNdgzMn3uS2GEuE7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B4vEinZk; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738283311; x=1769819311;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xJMm8A89D3mB060i4fb+J993o2OXasLO14u4V8BrBGk=;
  b=B4vEinZkzp9oMxhuHwYdHi+hRzX97h+um3A6urk00olSvOfYy2XEUjsr
   lyFzXz7KSlLE/FPy97SHqjUMhrBXCp96pJ1NtaJeLteXLub9fGKekezQ+
   /mQ8878u9/Es8XRiaGWplD1r9Cmzd0ON0BOn0S5DPJWM66WNJrk9J3r8u
   wXLxiykAi/UgxkgwpBH/uuBC+6ysnst7NuCT/xWv3Nlv6gLLxz/bsQ4+p
   rYsBZKHu8ufLXDE/Fksz3X95TVSI5cCuE17jFSM9Q8tPlNv35KRx5iJ+v
   N7PZVkDDkACUohAK0q8CxdwzLmnBi7h8tWcNZUZeZgG1juA/QKv1kE/dp
   w==;
X-CSE-ConnectionGUID: 1VmZyS+vT42B6rHqDB3LiA==
X-CSE-MsgGUID: zU9+97J3QiaAkJvLcqkNiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11331"; a="49447454"
X-IronPort-AV: E=Sophos;i="6.13,246,1732608000"; 
   d="scan'208";a="49447454"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 16:28:30 -0800
X-CSE-ConnectionGUID: SqBLDmTBTbuWEVB0fjy0/g==
X-CSE-MsgGUID: jzRyPN/oTjCzBXcwBlE/Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110369665"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2025 16:28:30 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 30 Jan 2025 16:28:29 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 30 Jan 2025 16:28:29 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 30 Jan 2025 16:28:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kVgWPCAMfgsLIV3jCOJvy2Wgp6u2+su9FKbeoolLAgcASCZ1d1GfykqqKNdEx9jAzJL3wz9wvbpgTaFs1b43f+gi1JNC70egylrrObrfUFvqZ+LleLE6ZtoZzs3AsMyqY58qnNsfzEZ1SmlFPJpigQArbuUbjVptf4dEO53TU/iF6fxvF3D7LHheMDVvMtsD+H8sPjA87DL1erXZUbJsk0AhGBXk6TqpSFvrUZsZ+3e72WzF+tUMBKNxGTIT3y7Hu3msNGYvCxKIK5VkAJ+xPS+5uAsM330ISWFJHhjh5QaXhu9TVJ4x9bi2eY3FvWiCcS9RxtkNF/18BIIglGsr5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PX1nYWiYxe42LOWelchvMRzGT+su054oatlpXMdc1ZE=;
 b=Pu450nR5DEOoSJFL5lF15leynD17/u/XpAHLKyZeaYBnIJBdlpHSw1yK0jgKKJajHSEnkH5QWhbVPwe5nwohWI2QTeHrfrg4Kti3DahIHaPmd5qzXafC9N8Y69La9sULpE7FHAtas5jb82X+iQJw+7btjVojyAAyn75eSZA5ytrWwFobMeDKBtn24v7rEMIDR3DHfxrSJzFFkHc+1+EFvasjDbbwT0UVDeuj0HFxHnE4ig7MesYnTlnTJEcnmxRWjRlrHM+0AuONbxSAHkEotkk9R1GpytbpQsDWB5VtANbZsXMiZf/oUS9Ilhfolm+WuGZl5fj7ZS6eR5yUAxFNvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8313.namprd11.prod.outlook.com (2603:10b6:610:17c::15)
 by PH0PR11MB7615.namprd11.prod.outlook.com (2603:10b6:510:26e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.29; Fri, 31 Jan
 2025 00:27:57 +0000
Received: from CH3PR11MB8313.namprd11.prod.outlook.com
 ([fe80::3251:fc84:d223:79a3]) by CH3PR11MB8313.namprd11.prod.outlook.com
 ([fe80::3251:fc84:d223:79a3%7]) with mapi id 15.20.8398.017; Fri, 31 Jan 2025
 00:27:57 +0000
From: "Rout, ChandanX" <chandanx.rout@intel.com>
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "xudu@redhat.com"
	<xudu@redhat.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Simon
 Horman" <horms@kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"Maxwell, Jon" <jmaxwell@redhat.com>, "Karlsson, Magnus"
	<magnus.karlsson@intel.com>, "Kuruvinakunnel, George"
	<george.kuruvinakunnel@intel.com>, "Nagraj, Shravan"
	<shravan.nagraj@intel.com>, "Pandey, Atul" <atul.pandey@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v5 iwl-net 1/3] ice: put Rx buffers
 after being done with current frame
Thread-Topic: [Intel-wired-lan] [PATCH v5 iwl-net 1/3] ice: put Rx buffers
 after being done with current frame
Thread-Index: AQHbbafHkW3yIZmixkqnhRAF5DkqjLMwElrA
Date: Fri, 31 Jan 2025 00:27:57 +0000
Message-ID: <CH3PR11MB8313DC9AE85F7B2AF4AB20F1EAE82@CH3PR11MB8313.namprd11.prod.outlook.com>
References: <20250123150118.583039-1-maciej.fijalkowski@intel.com>
 <20250123150118.583039-2-maciej.fijalkowski@intel.com>
In-Reply-To: <20250123150118.583039-2-maciej.fijalkowski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8313:EE_|PH0PR11MB7615:EE_
x-ms-office365-filtering-correlation-id: 3adccce6-cf40-43d0-f13c-08dd418e1c73
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?jp8uisLKsWdfaa8wHrOhDS2RxI2aSSdljqJN5gkif/fWdkw9iLrLoGaMfWo0?=
 =?us-ascii?Q?kNqOMrMIHW7YGzQtnjafC9AM/7XRkO8tcgFtl8lEoCOxCg69cYK77cUEV0Yw?=
 =?us-ascii?Q?QKIbDhZgmFshpaTOvDcoRD85Swxf5TF9FwksMhmmLHuDA424VLt0PGlS15Nf?=
 =?us-ascii?Q?O3VktQGKUS+9MX7UFM6g7Tzziu6vbW3BjH+lHigkq5RmGOCejMGOFgozhjoD?=
 =?us-ascii?Q?hjgatd27JmRxb+AOb5UpJQuZaf+FOqzHpgAhtHX2SHMiSaIjIKGSiQ/9Acca?=
 =?us-ascii?Q?2Hs2js8jAEg7CzCyX9BrScgDJMMkKSfk1asy/HzVjw2hkBIKG+T8LITitaoZ?=
 =?us-ascii?Q?DyyLMUQtRrGyMfQ7z8rC82YPL29DcDLXGFr/pjtU3OJF3X92PZa0v4vnNbS2?=
 =?us-ascii?Q?gohm4XTOG0aiJ3C1ChlhLOa/alhY9qYCcUxWiCrlqeM0+WGPE2D0n0Db8sad?=
 =?us-ascii?Q?LEt9MMOs+bFD1sztUeogY9FMe19LATgYuTTprZ6K6kjOdtwkTihCByNZSfXv?=
 =?us-ascii?Q?d+66qS4fX16TNfCYX8oW5ZurevyyulK0Bai7/2lL1O+MATCz8hlTpuNnmS2J?=
 =?us-ascii?Q?kvQKcntBKLlqhxJlblKieYSH140zQUkjrcM7Pf46LEX5RHmvW5aL6/4XPDM6?=
 =?us-ascii?Q?YtXx/xFfKgNpV7cWVJ9RIYXZIAZEwbxPD6sp3rx+B220AExZFZNv8XkuD9/E?=
 =?us-ascii?Q?wBNXRyIB+gxK9ZuvnzWFFvKJP4cvm/V8OZsdCjhy1RMEojbfIqR5SP4+HdgF?=
 =?us-ascii?Q?cdcsZXhp7O7X7Qmxzx5n5hStuLgVaDMX+AOUYSupJ//LRF+Bb9/nohsZHE8s?=
 =?us-ascii?Q?ELYzfGL1V0tcWzkumB6Y/H709RY5l/kLTkQdsUYNkuhr41txnn3ihK5SV+PB?=
 =?us-ascii?Q?P+m6rxTEwHp4lz41Jv0Z9tNMQB5NilNiVQk48o3U0k9yNlb3+7F6BHzgdTDb?=
 =?us-ascii?Q?e88yf/4g/az+mofzF8R2XiPeJx6KbuRWjlZqoq0nw0sC1ab4pQfWfM0hQGdR?=
 =?us-ascii?Q?0wkFy5fERYR6I/U1/qh48NE7eqiDD4UCoA5NibID77/ERSa8c4PIcYD2CScr?=
 =?us-ascii?Q?6BN8fNtw2rhDKXy4MNWQFysoasHMXdEtICU1cTDo32rNVRcYrpu/yAue8x17?=
 =?us-ascii?Q?qkV4zxRJ+l9vNbmQ5jzx1Cq+dkS5q/qFMwhb/hjkgkQOlkUNhcbFoAe9VvQm?=
 =?us-ascii?Q?H0my3iYSA74g4TPlKyVcu/7oeY2MvhQm5BRZjmhH+AbvExmbMWwGnxvHHUqo?=
 =?us-ascii?Q?htJ27zwf/yDB5p18x4+bDJQcpXujG7AsVMM3D3fWNA22AdLyw/3uPEOWU+hI?=
 =?us-ascii?Q?2cphFsZTlTykCNvuCz4BO94Ho4xMgOzm+eiQ7SR4NlglmCI1JzMXDA4cdn6H?=
 =?us-ascii?Q?pzpkMRCmbNwBkItMpVKn3veh4sqLGAkRXzy5ZcP4bwBREQNHjS8LDNOZsWzF?=
 =?us-ascii?Q?wlTZt/F7QdBRr6XawbMf0Pr1h589of1f?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8313.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mvMlO5CxHZz7w9Hfftjsjb5aHUfEahSduZMbCpwqbvux0v7alGGOuALcr2Fn?=
 =?us-ascii?Q?aJUzZpbjwHWwiNRWHf3SARM2yWOsU8ni8fPSOd29p0tuYpIbNKBYqTVrgxFC?=
 =?us-ascii?Q?9t+b1Z6Fja0FiXIE3rx94+XRooMhOo99tDquviwD4fxoUeopQkAwjudMKPe7?=
 =?us-ascii?Q?sKhTEErmJWAwUqYdHekLZEshWRIJSXWplYJebei2QUBIQ0cxmnuv8L5978Xc?=
 =?us-ascii?Q?ppD+FIErWe6xpRuroLRSDTHnj4PBSGPvrH5/HBEYHA7aa5A/jKOt6hPLOkaW?=
 =?us-ascii?Q?g30M/D8xDLYevuvJfIk/ZqFMbDc8ljNIuELvR4UXgOchB0zjUsVsqsVnGr+d?=
 =?us-ascii?Q?XPg4MBQlXL22j2Hw0wI/nqEM9SzOuTGea9BvW7jTEfCsmVV6x19G2wGCrORG?=
 =?us-ascii?Q?VRf8bt1Frr7Mcd+KfBFbsyJgRkAtj5bC0CXTAZ2M1Lg4gIErgtJdN1ehLOci?=
 =?us-ascii?Q?kvRNaxyZ2DuE99uo7vrY2g7JJpmG4y6x2v2/YSZEiJxKASx3eH8b+0tjRUSN?=
 =?us-ascii?Q?WqeAxEC7j8ahg7BNRrpFxkLniYeQx+/RawYM3cxU7flROuajRJlWyIiOw4J4?=
 =?us-ascii?Q?TkuPfrLdbBoErbSSOgCDFtlTT0jW0IkBcDE5pw9goLck/rJ2YculXfT67RQW?=
 =?us-ascii?Q?ydjaKSA3FtF5kyUFfjYk4JO/4tC8NxEeSUmJgXMq3Z4cPck0L3tKVcSRWMs/?=
 =?us-ascii?Q?t8CAg3wk2solH52sFN50Af1UxCJ+ddFJUqXQ+eVRV7+27irS/mVPAklOnxF9?=
 =?us-ascii?Q?syyl2bnl8qaPD2Cb1sLErnA6t6drRGgK+d9C3gXC+/GntpOJQ6+VIeAFZ/k3?=
 =?us-ascii?Q?Q5xZirp/NK3K1rPwDV5FqzFeO4gXOIjzQjg/zA3FgOGhWh4MG54IDct1IHcd?=
 =?us-ascii?Q?WhoYVbWrG1AtUpOjJd+sQyf4Bpf1j1cyvvtHBapo8n2v/l5YmBwVMxxYvlkH?=
 =?us-ascii?Q?6Zp96v06BTzkVd4oUYSKzjYmU/vXkYvUPjppLhzqYpxbJnngUSO7f0WBnLcq?=
 =?us-ascii?Q?9NruH1T8C4GvVswD0Upmsso3Qnbj/5kBtQfjVGNjvC1/ncnDhqbzWhwynluC?=
 =?us-ascii?Q?0br43aKiqE3Sn04mDyaw+DUDgI/1R7JPkEjLcq/G2qMZbSbq67kG5rHCWFlN?=
 =?us-ascii?Q?t/96COTZoB6XV9CVxmEJev/6U+gijX9XiwlD91v/rW6V3Bvp4yPTHRaHYW0x?=
 =?us-ascii?Q?D6Q6hgE4CAGtgdcwByF38AfBVSRPmFYsQOHz9DCGD/ZgaWS85p5b3dbNkQtv?=
 =?us-ascii?Q?tPDiDJNN2I5ZWKplNhgoZS5Dtu0swBDnd1PydjsKe9vifYLUu06/uB35NZE1?=
 =?us-ascii?Q?HdC9GK7RLaybiPjBZiRfvm0ZYec01gsaOFTYvyE7go8HTEOnh89LYn7h4R17?=
 =?us-ascii?Q?Q0zt0zOdm2JqtrZ9VmDXFNlwBY0meqcrxix6bUCKyt4FVTPJZa4TnReWyazM?=
 =?us-ascii?Q?ibtU+ZiK2zimj7v/3zUcSU5Y2pFP+AultOEG/qc7e87Z8XcKpraVu47/kEFf?=
 =?us-ascii?Q?iO+eKD1ohHwe3vbwLXl2KMjbUnYurfqrLmCosdTenOQKV1QwHWT8HVDul5yt?=
 =?us-ascii?Q?YT3HzkoGyuV0ibJFjhrgeBV5kkmY+yo2mDvjKRr6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8313.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3adccce6-cf40-43d0-f13c-08dd418e1c73
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2025 00:27:57.4895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CMozu4Rx7nit7VKuuyjEqWwZFaUekR852q1MikZpSqT2x9QdetiuikJ98XoguSP59M87VeLvXJ6PEuQ0fFkqqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7615
X-OriginatorOrg: intel.com



>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Fijalkowski, Maciej
>Sent: Thursday, January 23, 2025 8:31 PM
>To: intel-wired-lan@lists.osuosl.org
>Cc: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>;
>netdev@vger.kernel.org; xudu@redhat.com; Nguyen, Anthony L
><anthony.l.nguyen@intel.com>; Simon Horman <horms@kernel.org>; Kitszel,
>Przemyslaw <przemyslaw.kitszel@intel.com>; Keller, Jacob E
><jacob.e.keller@intel.com>; Maxwell, Jon <jmaxwell@redhat.com>; Karlsson,
>Magnus <magnus.karlsson@intel.com>
>Subject: [Intel-wired-lan] [PATCH v5 iwl-net 1/3] ice: put Rx buffers afte=
r being
>done with current frame
>
>Introduce a new helper ice_put_rx_mbuf() that will go through gathered fra=
gs
>from current frame and will call ice_put_rx_buf() on them. Current logic t=
hat
>was supposed to simplify and optimize the driver where we go through a bat=
ch
>of all buffers processed in current NAPI instance turned out to be broken =
for
>jumbo frames and very heavy load that was coming from both multi-thread
>iperf and nginx/wrk pair between server and client. The delay introduced b=
y
>approach that we are dropping is simply too big and we need to take the
>decision regarding page recycling/releasing as quick as we can.
>
>While at it, address an error path of ice_add_xdp_frag() - we were missing
>buffer putting from day 1 there.
>
>As a nice side effect we get rid of annoying and repetitive three-liner:
>
>	xdp->data =3D NULL;
>	rx_ring->first_desc =3D ntc;
>	rx_ring->nr_frags =3D 0;
>
>by embedding it within introduced routine.
>
>Fixes: 1dc1a7e7f410 ("ice: Centrallize Rx buffer recycling")
>Reported-and-tested-by: Xu Du <xudu@redhat.com>
>Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>Reviewed-by: Simon Horman <horms@kernel.org>
>Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
>Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_txrx.c | 79 ++++++++++++++---------
> 1 file changed, 50 insertions(+), 29 deletions(-)
>

Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worke=
r at Intel)

