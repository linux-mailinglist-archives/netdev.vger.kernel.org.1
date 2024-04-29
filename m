Return-Path: <netdev+bounces-92025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8BD8B5010
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 05:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 058F01F2110B
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 03:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014548C1D;
	Mon, 29 Apr 2024 03:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VZk259tq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499998479
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 03:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714362681; cv=fail; b=BRtQw4Pd3RagQ8X+w5hAZwPr+EYtgJ9qC885Si3YGhBXatmPCqekNvfzA3CQLBbABKJ/2L8VJ/sDROQ/PqlxLOzsLzZdRFkQjwLihWh7FpTbmyZyWlBxrHgp6gteTGZC+IJDo9cvS0rwbmPQTFdzLDoeslJQF1zn04G4Mt9OASc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714362681; c=relaxed/simple;
	bh=iv5C1CjM/dYCHECMGkXVRdqlh0GGZlAxV0d1/TgOf6k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b2MfzxoM8g2qy4oMbtk4K4XG9PRuzp6kArHzLUhAvYk6yi/UKLg76JVNX+BHfKkkzh9rtH/q+/zVyDIgvs1s12gqd6iwpovUmKkXSIiOP2owVsqD8shX2O4kCQJmmnLb2IEv0QZs0LLt7JnbJlLUPsZPgLpzdYa5I3lBvltvh1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VZk259tq; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714362680; x=1745898680;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iv5C1CjM/dYCHECMGkXVRdqlh0GGZlAxV0d1/TgOf6k=;
  b=VZk259tqWhys6Mvg2johT7ktVWvh81y00zpzpEmJVAl5CqHjNEpXTIDQ
   AqorqElzZ3RrAEwlWHCn41MCtjuaw2K1lVs9MvIe8wNOwEizW2Y9oLA9W
   QFsNRqP7CrNBJa3novExuUY3SwWQu4d6Fnio5WyrddlJiMsUH43FYnOvQ
   cqx5Gx+65YMpsRTWlrf31yXqek6eEME+fcvHnWy8m7jI78CJLpZ0mEu7o
   BXuaVzkCLbKDslCrdT+NJ6NCvv0hiDWUeDB4/K5JlS5mIEAjTaRmyEmWC
   J3nMGs4DY3iZhPpke0azHqqW977mBNjkxSocvw9mgd4+dec8/XKgkGKvK
   Q==;
X-CSE-ConnectionGUID: mpNE++MOSwuSKGTJiryl9A==
X-CSE-MsgGUID: 2wbUQsTnSJG/rflTefOIRg==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="20564421"
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="20564421"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 20:51:19 -0700
X-CSE-ConnectionGUID: o8pl7ELsQIGEujK1h1zXNA==
X-CSE-MsgGUID: 0gUxwcoDRVq2QslUbuI1tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="25997559"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Apr 2024 20:51:19 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 28 Apr 2024 20:51:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 28 Apr 2024 20:51:18 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 28 Apr 2024 20:51:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EigozlnckhFdooRJkt8ryEFN8w0WjSMqht9kqwQWERXR+8SSf02gjyCskfS18aWdNHtnK4ZFSJFHF3t/PGwg10va0M0BwM4IaDbI22Wf6ZNbUm6YTjB13B+OcJiNfE3X7QzVESnt2iKnN7D3e+jR/+6pc4NvuekGmPxgTJLoq3p84xpdxGTVr21yRBzJHVn+NZgko6pAK74Ml5ooGRbb3so9nnsFNb9F3TEqit9DA40GvWYVyEiinKjHD4F9ho36B90CenMATVElyl5hJZdWc37FQPiOhR9e0HfqXiGxLCqoFKpVifEy05C1iwCShCUFaYGLL1Tbkeaw0BUm5/LCVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Wo6cnyYQAQFQDaTSHTNdTYVakBJkzQRvdHyk6V2nRE=;
 b=bWqus7LsJPrd+yyPh/S/ax/X9zM2IK5ZU7pyuGEQ7V340iRjEJYI5lKz3FXyshZq2mbwvsdPq7JFcFLt4op4lDqZtpjTqmr0+95VI2irn1THLbrQzPUhWG27x5xwUD/CKgznMCNDP5qSIB2RHAF5PIytqt685h2ov9gwebf3914wy95WIks+5mwQf6TrOKWhM37mfWRiNAlmbZQuPDcSyo5Jyd97z7CoYb/LB3urvZVpAwjhIwXX3HZBGMUFeriUtMNyUMft4XnzfYyNfBCayDrYa56cDUs39tDSuyc6BS+oDA7SsU6RBSOUFRcKHFLp8h0hglBWaRZhpppVpPCSOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by BN9PR11MB5322.namprd11.prod.outlook.com (2603:10b6:408:137::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 03:51:16 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4434:a739:7bae:39a9]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4434:a739:7bae:39a9%2]) with mapi id 15.20.7519.020; Mon, 29 Apr 2024
 03:51:15 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Kwan, Ngai-mint" <ngai-mint.kwan@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Chmielewski, Pawel" <pawel.chmielewski@intel.com>,
	Simon Horman <horms@kernel.org>, "Polchlopek, Mateusz"
	<mateusz.polchlopek@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v3] ice: Do not get coalesce
 settings while in reset
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v3] ice: Do not get coalesce
 settings while in reset
Thread-Index: AQHalZFzCasF5mtpDkuDBU8ovdasSbF+pV6w
Date: Mon, 29 Apr 2024 03:51:15 +0000
Message-ID: <CYYPR11MB8429CB311160DDE188F7DB33BD1B2@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240423114308.22962-1-dawid.osuchowski@linux.intel.com>
In-Reply-To: <20240423114308.22962-1-dawid.osuchowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|BN9PR11MB5322:EE_
x-ms-office365-filtering-correlation-id: 8f82320a-c4c0-4db8-210d-08dc67ff9ed7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?4+7/OG/DVVP+OEyGRUYasZJOWumnWs4QAdWpCjplqUFZwgDsK9qx8W0v6jcl?=
 =?us-ascii?Q?k7q/OL2CktElFMiWHNZcutmYLA/xAgh43cxMx19Gow+KvaWnZDT2sHVm9Xn0?=
 =?us-ascii?Q?WxeuKomYj9oczQcEtip3qCfHJ6VIOQfn2qtMntmxjJAL5jJsPNpXl0HV0fsZ?=
 =?us-ascii?Q?4Kjc5dTFPiATtyYiJjFnguSagmOm5Q+lgZNp6MPrPFqPoPJ04efN5+8CIK7y?=
 =?us-ascii?Q?B5YJoGtwJ01q8DjZvJLQ05mppySENKBjuSZB3UCKSH7OBtGXS/JhynezrYA3?=
 =?us-ascii?Q?XzHuLQ0/J/SDVh8J3x6kslO8h96k85LeLGlbT825S0jlTthbDWtAIGsoReZ0?=
 =?us-ascii?Q?QIeHfeXec6UHRkQb2c/sMVgL+FvEyBpkJmX0+tjryJ+GKqC26+edH1muudF3?=
 =?us-ascii?Q?qoBQlyeBRDG+lcqunFuVzOWGU3W2GWtUA/i8uVL11/Znwn7SvxoQqAcx6Hni?=
 =?us-ascii?Q?Dn3xdTqvXIkdM9HSJbYIqhaTwfkhPj1b5f0qBBM1BJGKaQemiEhkrDN5UMXR?=
 =?us-ascii?Q?7hfhuDePcJgnSonwkIvKSYj1lkBzBEKgWwJBTCVEe8SIOjCvd3zidjFGidfa?=
 =?us-ascii?Q?NqdAHz0V6h9+fiVo6wfHvrP3yqF9YVHUHM7WTNxzP6z5z6QYmMPMVYpZOO18?=
 =?us-ascii?Q?p6cUwngXwcUD7fwPTLg+zf6PcaC6ewJ/xXqHftHEy7lEjL1nVseipXfdRMDM?=
 =?us-ascii?Q?8HLYWxdtvL0MBS/EbmTqLY2vC0ZzngAynejk6EXWVurkucoe9TeSmu3H/Dn8?=
 =?us-ascii?Q?9ptAMvnKtI3s66gFC56CTWKtd9fa/I/Nkan8owMGM0IW/OHO5rb1UkYMz+Gp?=
 =?us-ascii?Q?49/kA2imokeZTdAKNRlNaUmXNDy8G0kaQ79RoJBdNkRskr1rUc2qRdUH04nb?=
 =?us-ascii?Q?VQUL/V8LYHbp9qJ+LXxCf+NpO4S1L68Ub4MyQtcZaPH9qoMP5cfIjkPuvyjN?=
 =?us-ascii?Q?WUDSJbmepOYNo/G1yjpjtnQ1flkGzBuQbzHReXomsGT6cZ35Ie+yXQmsKsqn?=
 =?us-ascii?Q?wQFbjTc8Y87cmGr/ot3Ift95Tt9u9fPbB6Yea0gLFH2jk0w2w1TSIRnmvmxe?=
 =?us-ascii?Q?+afw8jfCvTUmza0suq5TLM6SZ2JT2AQISu12CePvhyWbVGxg8FJpEE9RFnI/?=
 =?us-ascii?Q?y7T5kcfo5rrtvw6arrQUVum0x9qXT1CT/6F4lstX3uDWJWhm3ZAqcPRZUjvj?=
 =?us-ascii?Q?afkSpZ5CZ92TGU+efHD4aqUAHN6WWVwkTpAwtODFLg40nf4gU83AX2MfqVqf?=
 =?us-ascii?Q?gS2Vb84qygSFyvqzjFGC0HTghdTqvF+yRlPg8aRaFyzW+PhlKCPBtR6SOAQ7?=
 =?us-ascii?Q?YMeNoRUIXlErrZ0k1pLuZKAg48VUhLgnLCvtCrRxZl+aog=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?65WSCvVOKGwWS8ukb1AptHVwXQgkx3IHOUtdJxpZL8OSTIArLM7v7960NpJJ?=
 =?us-ascii?Q?LJTV5TBHf3tqsRG76naYjmnpar6grVyLS5MqKKP7iuM2R99vaZiHX/XQOYrJ?=
 =?us-ascii?Q?zDA7zLQVQA0UxXRTxEGrn4rdrYMDTnBS7paZuCtoc8TG4rKmcJfFa9vmSAyi?=
 =?us-ascii?Q?yGl7cWtphRfbC8o2X+QyGXvkwrpuEtur1+UQk+F0uciqwBEXXqP5TM2Cxvuv?=
 =?us-ascii?Q?ucqABcKYmrygNG+v0SzucSt6gQkvQ/cyb08305cUKr/anW2W+Mx3XG0dk1Cr?=
 =?us-ascii?Q?fohNfM+TvLjfpuxdjpuFN6dYFpEsIRM/JsTot5sSiuPwlUdqa1s/bLnN0SYt?=
 =?us-ascii?Q?i3aCTgYVHlklzHesr6W8cl9oVfFfr8fiIwOiq+jJaGfK56T/lfPde/22T4Xd?=
 =?us-ascii?Q?z4wqlqARnksJrHqMlTpEtR6G8GcG38JvdyCypLDqinLuPogiRFmH8Bhayp74?=
 =?us-ascii?Q?TKCk0CI05jt8C9XqrjdbM0Ld/zgNGetC1D+h6fWTdUcCGFeS5mjN4ikn/DBZ?=
 =?us-ascii?Q?+F6hdUzG3ZA7vkU/MD/Mt0Pavi2barqm6wRlrG+39yukMEvkeTrB9s/gvmZF?=
 =?us-ascii?Q?nTwF+2Cuaazojv+AjliH1ULrZZCJPzvQhGTl6LUpR0zFpwO3BZHaaUK2HLJa?=
 =?us-ascii?Q?VKHb+HJ3vaPPyeGC7TjOQOI+HthEHMZ1fd2nm3H6/SY80izXuz0NLcH5H3Nw?=
 =?us-ascii?Q?211QuiXHzUVLbibJVZzRRR1WkoRlhmAMmOFxcIo9vGbV6Gv9ECPo/Cn2wQoh?=
 =?us-ascii?Q?VpSR5ywisKATOhhGnvhTMnWhEBaIia2IpQ76EIrR0klcCKgtnqFQ5TgU1OXC?=
 =?us-ascii?Q?lzXlaafvP3Rm5Nsvo+ZIFRGmy9YLj7+KIKZT1IW1NUME2w5qIpReV7WRVRPK?=
 =?us-ascii?Q?HGMYABcyzw9N6EtdZrT8g5pDFP38zvzHQhDmHbzDVKJr5Qsgcy4clHUML4TP?=
 =?us-ascii?Q?8ixBGjg3rzkj30rJQXmDytwTAiZDHK0Ykw2xjFscIT2zVGtguXy+qJW6KWXr?=
 =?us-ascii?Q?z+BKD6zze4Dmd1pREMJGCUUKJAuwkyzwOHOlFPaXdqqwLbj5Xvut1Fn0Gjlx?=
 =?us-ascii?Q?9beTsLVc1vsyyzwjmQGcwX7WGIGMFtxDXWroHw8n3YU9zP+gZvMWD9gYNa1h?=
 =?us-ascii?Q?UoMsAI8Mgbo3D3Yv9uRerJWEcMGzOET95Rwk9+VIevzeMMcCT1WvDH/ipsg8?=
 =?us-ascii?Q?GrQod4vB883+4tYaVJSaIYd8Wo0rD06FlL2c0WFvqcc64dY3ltP3iyWoi+ek?=
 =?us-ascii?Q?mxkToa5yOifgOCpegTJ1/dwFTiveL09pSZoa6p6Mk10Fg7+zBZoXYH+xBalj?=
 =?us-ascii?Q?4j3E+lVlILhoRstw8BF+x93w4pzIFxmz141Ol/Zxnj42xwxsEdnyHJbE+kSE?=
 =?us-ascii?Q?sOMoUrEqKwI75FQZLvH+v4wdBNc+Lnjv4PSwTx9B+6vHltRwffj1XryyAbfz?=
 =?us-ascii?Q?Tz7KYj1pdUlADuWTg8itmI1NYlT1d8/ryaFCDXVDm2/HBVR4krC5xyeJeXrA?=
 =?us-ascii?Q?ZJmbP95k8nDCiLQGXRQ17e69stmHA2EptzsTFVbAkh0ZE7wLmW5HZd7PwIwR?=
 =?us-ascii?Q?ubOUm8HHbwz8en6i1Q6Q5e17b9lLLjee3JIjH5cxfLc2VPo+DOyZ6ReTxiV5?=
 =?us-ascii?Q?BQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f82320a-c4c0-4db8-210d-08dc67ff9ed7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 03:51:15.8832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W0NxZ4pQ9mya/GOGMi4+17mrEVwpKUDFeQ3tfhoeBBWtfmwqJDn0U5TbCATLf19eQlNr7nELwl3lTQYxfkAVaS56QWm5JMrG55ovuBzFMyh6vaUPzonBjTIV9SsStwAH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5322
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of D=
awid Osuchowski
> Sent: Tuesday, April 23, 2024 5:13 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Kwan, Ngai-mint <ngai-mint.kwan@intel.com>; netdev@vger.kernel.org; C=
hmielewski, Pawel <pawel.chmielewski@intel.com>; Simon Horman <horms@kernel=
.org>; Polchlopek, Mateusz <mateusz.polchlopek@intel.com>; Dawid Osuchowski=
 <dawid.osuchowski@linux.intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net v3] ice: Do not get coalesce se=
ttings while in reset
>
> From: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
>
> Getting coalesce settings while reset is in progress can cause NULL point=
er deference bug.
> If under reset, abort get coalesce for ethtool.
>
> Fixes: 67fe64d78c43 ("ice: Implement getting and setting ethtool coalesce=
")
> Signed-off-by: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
> Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> ---
> Changes since v1:
> * Added "Fixes:" tag
> Changes since v2:
> * Rebased over current IWL net branch
> * Confirmed that the issue previously reported for this patch [1] by Hima=
sekhar Reddy Pucha was caused by other, internally tracked issue - repostin=
g this as an ask for retest as well
>
> [1] https://lore.kernel.org/netdev/BL0PR11MB3122D70ABDE6C2ACEE376073BD90A=
@BL0PR11MB3122.namprd11.prod.outlook.com/
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 3 +++
>  1 file changed, 3 insertions(+)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)



