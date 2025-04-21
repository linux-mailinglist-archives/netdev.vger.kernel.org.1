Return-Path: <netdev+bounces-184432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7417A95693
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 21:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFCF517081D
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 19:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73801EDA0B;
	Mon, 21 Apr 2025 19:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NDy8fUTG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AF1149DE8;
	Mon, 21 Apr 2025 19:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745262861; cv=fail; b=N501paB2MfhVHVp2AhB4wvTl0cyxT3e15TFXmAlzobloRRFY/kGHadnU2/RR/b6FWoiBwNfo8GzGJa2bj+/eK73Vmrr98IDpt4mv8UkTkYIHk4voqJKj8vcIH5dXbFCnc58eLd5wP3TRzHIg/yz+MVeO1fGIGz60Y5nJVSn8rmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745262861; c=relaxed/simple;
	bh=229SASNtgGdlGut0xXwZDQ8o67YT48nXy0B8rr4mGdE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e5bviDtVnc3u6pryF4qubU+aivYN99OVs9Mmcs4fZLCb87FePbui/5ax6z1F5KSYGy9ki7AfjM56vZI64dCp5pOcdRZd8wttXabCf57rA+mZOrbOqLg7AwohH/6RmKsmPojJxEL6AONstYxcpW7HJuP0SbjCTv6PKE+JMO2byuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NDy8fUTG; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745262860; x=1776798860;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=229SASNtgGdlGut0xXwZDQ8o67YT48nXy0B8rr4mGdE=;
  b=NDy8fUTGMtAczo4hEgEkRTIy9fYEQ5VEGUcR0I5j3/yiWGUU1OboLR8G
   F27DrljtPgpeeMRrQtVlnbB39qv4czJgqPIlFmefxvklX4s+UY8+lcS/0
   ST7Don7CScSS64t1IgRr5k4RcjLtKdhpcU/4MHyGIFmkiedK5NkMWfTQd
   9v6RdRBq0LvmRiqRaLn4Wa6q6+gdZ0SgXbdOSXmU5XYe4SQu7bX/EMrOb
   OZdUkTKuHnar7jjNdWALI3JH6XnbbT+i9qQmF4Vi0jZiU1kvnEyDmFZfL
   uqaq+igTDUU1cP09Nbpz0IwjeFjvUW5A+fNGfgDfXY4ZtrrtGpBmrvKTp
   A==;
X-CSE-ConnectionGUID: bwnTfU2dRMCisH/dAoV1Dg==
X-CSE-MsgGUID: o0vHaf4aRIOwuFteK9tO3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="46812199"
X-IronPort-AV: E=Sophos;i="6.15,229,1739865600"; 
   d="scan'208";a="46812199"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 12:14:18 -0700
X-CSE-ConnectionGUID: 9CFD/uBmSmOBEqm82+1G1Q==
X-CSE-MsgGUID: GWlXPJpiRHCdLfuLm4hV4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,229,1739865600"; 
   d="scan'208";a="131545321"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 12:14:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 21 Apr 2025 12:14:18 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 21 Apr 2025 12:14:18 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 21 Apr 2025 12:14:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYWbN4MbO1nhcfe/Tg2LHmHwI/W0Zy1r4k9PnZaA+OOCKCo6R/QQ/kOe5elg7fGoNSZxHWo7A4mh3G139RvySa1iLMGyP3tki1E3cWinv0aXVYxHILvY40H1xLFWmjqyW3Be4sIMjhR5QW4gTdxM/rbICJnFaxFBKWWqnseKoYnpY96AMR8sz/JYxjyXAr31R85C3rYB+PDOEJQ0hRBxYyGeYm0DvgnOkE3oG4BTc7cb6NZR8Lhd224D5zJ5PrxxNBJvf+M/NtebQjSE4McKT5bdB+v/OeO0uaYDl4RLjTqdtjBabyseGovPYOfvjrqsBAoUL2ogRqF0rRLL9SFkzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dyq7pW3DH570GPXHnHaNV5K/ph1ht1WstA7Zj1KTjE8=;
 b=tZ3V5rNdwunwGmfEbq/LbXywAaW9RLl76g/ZtxriBoGr2lBuzUfa5WdNGQSPZ/FonsSUu194SG2KMNsG41Ho7YDRumDmFHSrhMr5yuDypez/5i4Jauox2N2iYMNR2aQwUVCDVDCojWxusM3v3JdtH7gBFbCNnjoVm1KPn20Cp+DRIL1/S0acfy/2bH1awGEIW12rkhRjwRz4lxkBrMEeX5FgGAkOyJ9IHWpCxei7wg4aphXnpwXgl7MIush4XwXsTNtY9odvZ0UrHDmcGpQ/R0W6Pgqtw9MAFVRJfFYB9rq9bVWPDwSFPmfToYzEBlbEFRrF2ZJjUVQ1H7Xs1tf3bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ2PR11MB8565.namprd11.prod.outlook.com (2603:10b6:a03:56b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Mon, 21 Apr
 2025 19:14:14 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8655.025; Mon, 21 Apr 2025
 19:14:14 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Shannon Nelson <shannon.nelson@amd.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "brett.creeley@amd.com" <brett.creeley@amd.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "Dumazet, Eric"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "michal.swiatkowski@linux.intel.com"
	<michal.swiatkowski@linux.intel.com>, "horms@kernel.org" <horms@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH v4 net 0/4] pds_core: updates and fixes
Thread-Topic: [PATCH v4 net 0/4] pds_core: updates and fixes
Thread-Index: AQHbsuVdXaQ1R0kolUiLU3dT7zI3irOufTuA
Date: Mon, 21 Apr 2025 19:14:14 +0000
Message-ID: <CO1PR11MB508963234A8A077D47AF1815D6B82@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20250421174606.3892-1-shannon.nelson@amd.com>
In-Reply-To: <20250421174606.3892-1-shannon.nelson@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|SJ2PR11MB8565:EE_
x-ms-office365-filtering-correlation-id: 941cd720-6e81-4e46-1f42-08dd8108b4a4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?xbhavfMHU4q8C8vpRTCd4oaREO4ZnexLZU+easMzHfm91uIlCwBNn9ucPUHX?=
 =?us-ascii?Q?gCbs5VR0PP5dom6DwfNcBH0g4ecZ2AChwY62R2fO6BvZEa+6GGPNO0KOEEGp?=
 =?us-ascii?Q?fCd4/ny1s+k9Tz7O03oAEOXdgvhUp+hJXljGj/jBJGK5i21cYzBUtP5dDqxn?=
 =?us-ascii?Q?oal3XDtXRFi6lDppNCpaUFR01/W7wgZKLgd6cgdshHirq0BsaY1MGomXe7gY?=
 =?us-ascii?Q?/JZwQxjqGNJnEiWLj6CLBTK+58GCfoTVg8Mw2+L5ZaVKvSIsufKgrCWY27jN?=
 =?us-ascii?Q?MlpiiA2ibbvKSZNugdfhuoCyvE+NicusQTVI5m2d1SzZwRSwL2UccsNGaIXz?=
 =?us-ascii?Q?IZ+wgO/4/XcrsfXk5+/5OM/9Lfg/KCH/W9T5ZMGvgDb5EKUxVC5Lwv25SU6L?=
 =?us-ascii?Q?A9bboyCMRGzKPPoFSpFTusGIvJccOX06KARYEn1rj9f8erc++dmbNOwmasaG?=
 =?us-ascii?Q?KVALXggAx6Cb19cAlipPyV3Gibt863DPaAxFRQSvwmr/75hCW4y4undjivvl?=
 =?us-ascii?Q?kNSFrmKWYEGBooRyKQ4C0mmVN1Eu8a+u9rtZMrYeksZkwWXlQm7JMDnXJiL2?=
 =?us-ascii?Q?7QLaBFsonuY6yCvMjLL0HATJVb6KTXkwA0vJ5eYqZ8xS04P0iPL3BIvDlLmS?=
 =?us-ascii?Q?nztiTBA8l6JueesUe9pW3darUNGTn/drnHRSVd9JHFOaeeEYzJHY+d15gcx0?=
 =?us-ascii?Q?KoQFdjZaWYRjk/Bdh3H4KONliWGLkU6NDMaQYvXEiYyWhJlUQIFyKbf1zpk+?=
 =?us-ascii?Q?tTcvGCOPZ3jkPBW+W9eM8D2zby1ZMCKGuKHe2pELicqO2dVoqhVroTahbhl3?=
 =?us-ascii?Q?g1Wqm8fC5NbyESJRQ39QuKvOS5SCn8uvS5L/5TYTj/lmh1jEXEMpZ2xwJ5yB?=
 =?us-ascii?Q?S2FDqQY7yOQd/M7khdumNUeMDeXGUDHN28p94ChwKDtB8KDN7pcb4t4S2TAE?=
 =?us-ascii?Q?TpLMJ0CHXNvgRStUfKpWJbE4ljF4ffccB/NdgKm/30CipKJYyDB1gEN37yJP?=
 =?us-ascii?Q?9Vl4S/YLudzm4QmFoyKvM48DXDFRSFsaJNVU1yKFfaP2arw9UiB06xzbwvam?=
 =?us-ascii?Q?wrEQO3MMxCAkqQRhNppZj9PJnAFGZW2YVO8Ti4vQPDogxk+mcM7pyx3fMTGr?=
 =?us-ascii?Q?guHIk83iBQTVUd3lzAAlKjiBj3uIKPO0le4L5zeLS+a6s768EdFNV5Q/8Cpb?=
 =?us-ascii?Q?Vm7QBRUPjRnD8qtD5oIFACESiBlAKl9XlYVTpnoBEOhA6ArLak3lBHyQXL7l?=
 =?us-ascii?Q?RV1F9dtMsh+9LPNEPnDx7pbhITmYZF+5hg2MGyIlT6R4i0QjDHZjwguOZ5UC?=
 =?us-ascii?Q?w6ezsmESvhjlWQJeFE0GpWDPzkcZ5zd/zdiW+8UsAzeEMQqK6ANvZnIPZaR0?=
 =?us-ascii?Q?rAnmmfcT4wmWxdpDp2vOXrIPqiRYfE3yUjCYoiDNYoBfb6BRqNs78fXFPqqH?=
 =?us-ascii?Q?WwLvdG2POQFwbAA4VK8z/3WUc00dGy2zz1XMYfjr4cfECQVoBGUekZ53YXg8?=
 =?us-ascii?Q?nQMJDRIFe8+cz/8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QlgjCXCJ+lwQZwdgVWUqvSdnxr1t4OJSY/ZLGMGVNM9/jRBjxG6wWI5V7bk1?=
 =?us-ascii?Q?4ZqqNkYR21DKKE5q+w3UGMogT9R5sZfUkL5C0k+aBB0aYq656QCNha8e5NQH?=
 =?us-ascii?Q?39CeD5lQZW+DWAR0TLO3QbnfyshwyHG8ZKFZ9C1mJtctiCvB3Z/sf5+ItEjD?=
 =?us-ascii?Q?8gVrfHy5mQ2W9A52QQF3W4J+ivjFeYfqn97TL1Dqryd26Udix8MRUuSqUlgs?=
 =?us-ascii?Q?sEfQx/bXqCrhIBKpQM5ybxKMq+RN6kWdafkYWbmeqKB34MWWIFkmlEgT1tkI?=
 =?us-ascii?Q?ybbqNIpfz8oWxNo6/CXHa+bn28zXcjmDXq+yMoza5oDuJVdQ4eibf+DkTdfM?=
 =?us-ascii?Q?G3lk83Zl7IZvj/Pedx9/Mz+qg2heTo6tzgV33vb9Riv36aippI3/kxC5Ak7P?=
 =?us-ascii?Q?pNHPbLorzDjCKeK3LhsiHgrnA21r18QUXpcesCmdSlpAGGrweuBpjMIX0E41?=
 =?us-ascii?Q?VGpICRkDh+1apeqNPt0CdzZlTls4zRM7cN7HZaySUH3Hyq+QZcQsoomldJc3?=
 =?us-ascii?Q?8OVjg0niNHJjEnG43+DOGLRxUN3BeEtOmIxxd2/asnKpRfWru55yD1TTp4KP?=
 =?us-ascii?Q?L2ZuqzqrRe+KorOuhDwzyq7ay5Wl8jUAlApPVHNCUQ1o+X4jQsRmbiHTYyo6?=
 =?us-ascii?Q?G9BGcc6eWwMk7vsxVyZrTUh4AXdiNZIqeE3eh9zzlRHgB2w/vaTXIRAejV3Q?=
 =?us-ascii?Q?iEG22ZBmrHrBg2+p0mqkRavJNM+sykEjMkzsixLUufY8K3IDE0UfIwhP4k+k?=
 =?us-ascii?Q?qtMiTLYJwOscHsKdmZql6rdp36dmiC3RF8WQnp1ARNzY8Rqbvhk3+1DXYAve?=
 =?us-ascii?Q?3yyV/iv10sPiFT2epb/66C0qhMKhQTnZRNaz0tZFDsObE4yKK2NseyKzw9yu?=
 =?us-ascii?Q?9X6zt4WDxnov0UmQEEU0OPXVIpgsflCgWnjAPdc85ABBabCTkS7f0G72tldu?=
 =?us-ascii?Q?X/9wveJ/4t3KVAF8L+b36jYWn7QAxd4/dKJ1YN45ZDk9lsAdn4yHr+SgdJQV?=
 =?us-ascii?Q?rikZTxGxCZGdLfmvHlxz8VWQmWx6DP+qY8lkxpxLys+XJWPDLzBx0faeTxKp?=
 =?us-ascii?Q?YGFX5FqKOkQ//k+oIWoQsMAjOWMV5CvKdf3CMXtfImAN8UekmN7rghvlLFh3?=
 =?us-ascii?Q?szrbD38WeKakxjvkTxlZJEjJVriIzjiS0laFk9XyX7skF1zUQ8ARjd8ObRo0?=
 =?us-ascii?Q?hCjvFqBw9WbOVf5i4xvw/QMuGwLFq9qxvZMNlaKZa92XrxYcMVV23p6sPRtu?=
 =?us-ascii?Q?ow2XmIQXNbU4tAD4qhM3tYX301djNCRNe0cJQDg1YxxwfYLB3UavgGANOoTM?=
 =?us-ascii?Q?g83AGOffctVOIvOO2PY/sDQsu6vM+X99MIO4hSux59oOsryF6E874JYaW9xK?=
 =?us-ascii?Q?PuuRJ5nxx0kzrk81mv4TWvUX4WatuEqxoRBp/GdZ4moJqrU4C8bRtXBxgYy+?=
 =?us-ascii?Q?m9wZ2IoLVqfAEOXkgQVcvZ5KgHmLKz5yaBWd8xaZFMG/tDRNNaKnBqm4kNxe?=
 =?us-ascii?Q?kbIChLo2ILGwLirBXHP8/Y4/jxPC0Q24cI0jWRyZRajoWe/1ht0Etotnkbea?=
 =?us-ascii?Q?JqkaEkYQ7kFmGuNpN9Z1mh6sh7BV8X9LH0IDikSr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 941cd720-6e81-4e46-1f42-08dd8108b4a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2025 19:14:14.6373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hCL8eIUoJyTfNlNmsEAZzibPk4DpaFVJgihMSC83w5xpuqL9NlMOjsnGxJbZ7U/RSkSoj5gw9YKcKqoD1dm/fxlnsQHQWVVvpYbVq8TyF7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8565
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Shannon Nelson <shannon.nelson@amd.com>
> Sent: Monday, April 21, 2025 10:46 AM
> To: andrew+netdev@lunn.ch; brett.creeley@amd.com; davem@davemloft.net;
> Dumazet, Eric <edumazet@google.com>; kuba@kernel.org; pabeni@redhat.com;
> michal.swiatkowski@linux.intel.com; horms@kernel.org; Keller, Jacob E
> <jacob.e.keller@intel.com>; linux-kernel@vger.kernel.org;
> netdev@vger.kernel.org
> Cc: Shannon Nelson <shannon.nelson@amd.com>
> Subject: [PATCH v4 net 0/4] pds_core: updates and fixes
>=20
> This patchset has fixes for issues seen in recent internal testing
> of error conditions and stress handling.
>=20
> Note that the first patch in this series is a leftover from an
> earlier patchset that was abandoned:
> Link: https://lore.kernel.org/netdev/20250129004337.36898-2-
> shannon.nelson@amd.com/
>=20
> v4:
>  - use init/reinit_completion() rather than COMPLETION_INITIALIZER_ONSTAC=
K()
>  - use completion_done() to protect from completing timed-out requests
>=20

Just to confirm, everything looks good to me in this revision!

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>


