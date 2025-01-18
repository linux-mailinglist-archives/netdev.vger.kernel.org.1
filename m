Return-Path: <netdev+bounces-159512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E17E6A15AE6
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 02:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 387FD3A135C
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 01:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245B2200A3;
	Sat, 18 Jan 2025 01:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="llEDtR/7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C99CA4B;
	Sat, 18 Jan 2025 01:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737164458; cv=fail; b=P/ACFZkjmH74+G0lv7i4zs4ZJrxDJYD0eYHitMD4qw7uxE5nbjqIutpyQMgownME/27l2IyWqgVmctvz9/8Sl9wIOb8Ih9tI/e03UthC14V6OWDp6uFKroPK8T+CQFrNAa6AKTAi640+t/HitRCvQFCorU881AyTgpV91IgXw+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737164458; c=relaxed/simple;
	bh=xVf7KXCX0eQxT5BH8CO3mihWINMyWZXGCnbpKFWFWKs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oU2iXMHfrmBZXrJHalshVi24oAokmpwOiWU/OfY3CJBA5mr8vmce8AmndJ8CsukDp68VTE05WwUBweQXCHwofyj/IS0yEU8QPXfe/4krELsvc5PLfFLyyytSGx0oUIkJNy8xltoHcGJL4kn6x9/OUpWEiEqzj8CJx8DS8iXRzEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=llEDtR/7; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737164456; x=1768700456;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xVf7KXCX0eQxT5BH8CO3mihWINMyWZXGCnbpKFWFWKs=;
  b=llEDtR/7gM/EM+l5Tc63T7f6/TeYt03Lk3U/b0ZZeA8BhK9h46SSwSSG
   co0PFHKzcEmxo7P3BnujyZ6aaGMKMwdo74luY3GkfAMgFqZm+0UKdE127
   9u6CMmXs0Pz95zm1H4RgV/5cjnsqq5anBAO1/tOVWcmBAjBw9iBB+5veZ
   arfpZIspPm4CI08whCCX9oCHNNdwigZJAKlsQFx1uEvBLDMlsa3AD1wad
   LmCFRaxTX6q+Y/hojVxpC9Y7W8i9QFs2q9nk7U14OP3L/nh1sp9wdjUH6
   8fZ73wzzsQm6SVNTldNbG1scGw3sJLOV781oSs4Anfsc4GhDbFO4mplXu
   Q==;
X-CSE-ConnectionGUID: XGeiF8RSSpClbvZ2UfS5kQ==
X-CSE-MsgGUID: 40vu4kGPTv65cdH9snEd+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="40421602"
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="40421602"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 17:40:56 -0800
X-CSE-ConnectionGUID: 3N2yOOipTHGXZqIUeoyv9w==
X-CSE-MsgGUID: r8tt1UcnQbu467gsjTHj9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="110953964"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2025 17:40:55 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 17 Jan 2025 17:40:55 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 17 Jan 2025 17:40:55 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 17 Jan 2025 17:40:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMlqJ5pNE+lQ3SYoJRvRjtrC1hthOD4ineXAP1ZVonvM6F+gk4vEWDoKnVGNlBG0QHKDRzjmrg/u4bbX9tHhevxgqnd24M35KorwVYUC9ti8HB2qj6CPOhej90/oATfGvv1zf148m9QWCFsEoTAqSnWc2sq2OHZR5WD2cwAMxFMfA699DPXCDXEkr+pmnvibfoqsLke0OEpFHzRnZotmDpZFgA97ppoO5q6W52WtckI+FriiRkuROi5iuUc5I5I3vMvPfef+6sdx/sMMCrlNHBuCJeVlyssG1tC7t6DV10TTNL5+Ath0i7CWOpDpYp+vpPfX/uQRspkOhJGvVJZ5zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/I0IWTy4QKiVB0K0lhKiloU6dL77YRu61kyTV1wrl4=;
 b=Aw7eGgrTTGjlFVm8h3G2FiBnptNih2mz0MQWJPPGIXjjQTL6YRsKrxWhONkQIq7z21aR+TpLnbZ7s4MHTiooseAz1MxsBE/TWgEA19CgwSdAeQQ2e1vlRYjdUcpgj2xt3SOMdciV0vfb79GJwUApvgV2lTC3SCpnk1B7l7eBxorbHH/iXjOVOOwgk2PBRh3FUuRPFf7sL+GrGCKz0nhS8UA4/L1mbMxTvy66yC5SJRYZ9zhF3TZVZm9Rl5hM9UwWWSAJ7Plux3cXTN9SOTFuc8bZtWFwRSUb7gtXZKCEGAnYM92okeYk+ij4PDMk3Bl6J8Fw9KG036OrTwhV2t5BOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW6PR11MB8437.namprd11.prod.outlook.com (2603:10b6:303:249::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Sat, 18 Jan
 2025 01:40:53 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8356.014; Sat, 18 Jan 2025
 01:40:53 +0000
Date: Fri, 17 Jan 2025 17:40:50 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v9 04/27] cxl/pci: add check for validating capabilities
Message-ID: <678b06a26cddc_20fa29492@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-5-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241230214445.27602-5-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: MW4PR03CA0047.namprd03.prod.outlook.com
 (2603:10b6:303:8e::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW6PR11MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a5acd22-de2d-4b67-b51e-08dd376124f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IlSPJ/mAcUTvC05u7XP6laZuQvitsbD2zT1VmlF1WFMnsax9JaZwZmFM62On?=
 =?us-ascii?Q?gEsEYniBybemBFFVbS3qc21j0J0bIVp6gwWIyON70/6S+nXdVZBwhapcp8VJ?=
 =?us-ascii?Q?Pi5IPm1bqY5QhziU2vHXv5UnJv8Bf+WyrSXReug/ZDzOoHzrUAzC2Vwxw739?=
 =?us-ascii?Q?AM4R5jYU5ancbh9cpLcbbTBFJzLavjkVLN9olmPxWTz/yIVxZj0kAgOkw8Cz?=
 =?us-ascii?Q?PSZgMUE2mmJK9ZH0ebR21Xo22ziJJN8cJsiDe+cBvSwPctO1yRjnXukaNLOf?=
 =?us-ascii?Q?d5oTZFB7xNtNgs9i4s4z7tcYESiCSTZUqXE396xxEr6oD70DlsZZhagNi2yp?=
 =?us-ascii?Q?pSbioydlFkJclFdXLCU41HaQajcryK7RGf/xghZSbQHSyLlWF5/4S3OrDz69?=
 =?us-ascii?Q?iWBR1wHQiflU89z3OlpCU6mMV/ZU3BaFwNUTC/5K8eX++M43RpiUGpCaTFO3?=
 =?us-ascii?Q?keiKppLJTUz2WraHrEPRXk/umJUUfR1Fw5s28X79pHm2clcp97OgMVUX/EcP?=
 =?us-ascii?Q?UtVvjgrvAY+vJGj3L1jrKFqWNiZ8uKsNjjEWCgo/LwLOz8dwW2UmKOLqmdQR?=
 =?us-ascii?Q?sEIrpYb+AV1rjMTYBkKeDfPEL9NWwCIekDNM0qICrpNQbtFGJeGul3pWEiNR?=
 =?us-ascii?Q?JAA9x+YUJnfMDAuv5hMvMB4/ChVPJwUyfcZbUP/H1uqeHXc4K4sRePeOTuUT?=
 =?us-ascii?Q?0clvGOneR7RZCUtgPgG//cmtCnt3I1Hy7Wbxd7dLZjK2sFgyhuhMhScFwZcF?=
 =?us-ascii?Q?12dd2d5vSDGdy34heJn6ipsbreZNY9JEkt/aMAHCZ7SsJqq5SnSsvfLhFXk/?=
 =?us-ascii?Q?q5DH54HNtRvGizlzcgfmBtmgrGe60OFd5UhA2plVytXkr9zUtkxVCKghB1ES?=
 =?us-ascii?Q?JUt+jK+Vb+tQCl1s2zo3tOVUdMWfG8ezbfreQH4btZB4y87611LIL5gK3+vV?=
 =?us-ascii?Q?uxNnHXp9socT+7RJ6DU9Y/SRG3QIeR944wCuGMxiMoTL9CL6nHQ3eYoTMX4H?=
 =?us-ascii?Q?u7iSCPCf3ODJcZpoMlxZjUJHbTPmGOr5jnmwazZ6fwal/ts6hJZvRyVIRkun?=
 =?us-ascii?Q?DmyJIhcmSZRfRDusQrGt8/cRgLN9ibcoM8xA6JGqGy4B6Ti7c5gIZPl6xbKB?=
 =?us-ascii?Q?eam3ZAPMU4dkm5kyKpMi4Jmh/kLFgPXJBBWBS/vC3f/TSVLF6EtWah2/XKRU?=
 =?us-ascii?Q?MRTIyyoIPB9643tM/Ik5jO4rpCT2YGph7Su0COvZYkU5vHs81jN2s2cUsnfJ?=
 =?us-ascii?Q?zFm8CvFiCsuVYODdWRCiXqXJdgwG2ixt5MC6C+Qa3H8D4bqRKlH5j+T8/wIa?=
 =?us-ascii?Q?GmCzPNOo/2CIy7pBzePdApeR/aa2Fg40iPz9S+X9/oR7zXk7k+4FYH6bFdbI?=
 =?us-ascii?Q?RE9I8TP50Hzvw18JEL/CKQB13lTne83+Zq5xOuNLLPhNKr8/RCFFJkaXH3gE?=
 =?us-ascii?Q?k+8w0oE6rak=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lu0hosmga5DDxv2FA6OjLvbcY851wNamLL4BahgAHu4NuwogHDgan2uGDR54?=
 =?us-ascii?Q?JdpimjwVOCOiCTpQZhoJRFjeQfL+OFXS7n0eU0lqEx+YMUBzausDXmdPHO/7?=
 =?us-ascii?Q?Oj9H0kE18HSLtLZM7qDV2icRF/izWEi5GDEBgMxdl0uD/BcdKO4wustsDeZx?=
 =?us-ascii?Q?EZSThA85LnY1OkntvFQGeXCirHL5PJhpKHw9zAzb8qpnpeU3tBKDJk9FE4Qb?=
 =?us-ascii?Q?hiSaK1xXA6L8II4THAsHzE/ymQjMWoOUbfqMLgX6NFhWmJCM9DkFoB397WdH?=
 =?us-ascii?Q?/3XbnQn1AOYOshawS1cQ3PHig+d6pkHZW8+MylJCjBDSRSxZrUbsGdZWf8bd?=
 =?us-ascii?Q?WSwaSPWx+8TDZEAK1iglvN96E1rftwrXH2N3ZiZExB56/WrDScGYhMJC3b4g?=
 =?us-ascii?Q?RtCBORJqrq4678tpyA6La0COXksSStmXz67BGE+XhmdKjcVVDYzqyy/olXBf?=
 =?us-ascii?Q?OKuSiIbr+pZFBoMqlmGnKGDH5Fj2XJGiK6CwnR+slVG9kpDYbr8KlcYcJB67?=
 =?us-ascii?Q?kvHyf51svtSkdyqQx22wrNMXZKtUI3xI+xZ4Koz7Y3H1dIpUt1sGArv+hbvg?=
 =?us-ascii?Q?o4CMaxvkVU18DaWZ8+C8A8RXMbE2ojC11ZqZdQuCB9Okqz8QOOBDeH6w3dr2?=
 =?us-ascii?Q?cy2WyDoIaAnCVFZs26tL2in2qwCfuG07MrlIKkLBLh+SRrcvsYQahwxwzubb?=
 =?us-ascii?Q?jcaiTmhcM/2tFtz6w87qCylITBM3Dpb9WEEGbP0HdEiXfuVd+NfB79BprRIP?=
 =?us-ascii?Q?+nr4uLjhtsXBWKw2JOewUH4YGdC0ds6AjocS0Wp+OEr41gHAE/8iEB4bMXnf?=
 =?us-ascii?Q?qUEh7B7CZpPTPuBPbRxQaKGcedgrMXM1iwjPL1ngze44Cpj1Ap6KhlehacJC?=
 =?us-ascii?Q?4D7439Kdo4eS58jiOKhVzhNpyzQNKgc6FLFQvD2hhRO5g4gEqpTCLB7RSgrC?=
 =?us-ascii?Q?02EzHrJlL5ZNR88b2EtmiY5qVshlC6zifD5GR3YobKyIHUyEMVgWvB97lcLp?=
 =?us-ascii?Q?3A44AcI4BN/QUbbWL3DsN8cFcZy4ulKA4FVHB0uj03WoYxwzHbjaChsfh+Tr?=
 =?us-ascii?Q?BiR3yfc0pPwJTGcLLSxr2RPpVRcSSmHJFCgj847IPx9tN2kEEsMkPPNDKF9M?=
 =?us-ascii?Q?WUPXSPda9+tJ4sEesnqM51SE+zTFidSYhdRvNdWIBWcOepqtmyv+gpAlPmgB?=
 =?us-ascii?Q?OQS8OtF4MdXMXhi+AkjZ7hObO1eDGm6Q/G1PgPDuc8hqJwPZnWcWgsb0DidK?=
 =?us-ascii?Q?Y/KkrRHPAjkY6Ya1A9JxSxMlJiBXLblu2U2pRKh/4536GRfXK3fTUB18KWUJ?=
 =?us-ascii?Q?m3Rr3xn4gKZVzRHKccfsye5hB02T8QwqRZzoRvVBi4wIhic5camwLPzv97h2?=
 =?us-ascii?Q?ZryHeI2UxvTpTwvmIYBkqzOHzjiDNmWgH8dNfCm1xXDUjoPEHdccOZiDy4rX?=
 =?us-ascii?Q?Y+SGHUe7GZodMiZvcCYxqxeUu8+bdBTUYQalYwuf6M1wklP1jDGUeHfAMp4e?=
 =?us-ascii?Q?vBGSxeEEmcAamcpacMgJntbc3zPxHxokhkdh+1oGXAnosbY3Y8ak8nVue4J3?=
 =?us-ascii?Q?cCdNBPuCP+yiXGSVWpgOJy6hnmbcCclSbjQrlFqKPQWO9nQI/AgUz879OCeW?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5acd22-de2d-4b67-b51e-08dd376124f9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2025 01:40:52.9208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OEISLkwh6FETxKqMvG2H9728nBSW5Eu5nzvsjkQ74LahZ1YrPoq3Dg9Pv8ywOBrFqA7XcIv823Gm5Kgz+NVOFbwP1FTJq2gy/esR/vtnpL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8437
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> During CXL device initialization supported capabilities by the device
> are discovered. Type3 and Type2 devices have different mandatory
> capabilities and a Type2 expects a specific set including optional
> capabilities.
> 
> Add a function for checking expected capabilities against those found
> during initialization and allow those mandatory/expected capabilities to
> be a subset of the capabilities found.
> 
> Rely on this function for validating capabilities instead of when CXL
> regs are probed.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
> ---
>  drivers/cxl/core/pci.c  | 16 ++++++++++++++++
>  drivers/cxl/core/regs.c |  9 ---------
>  drivers/cxl/pci.c       | 24 ++++++++++++++++++++++++
>  include/cxl/cxl.h       |  3 +++
>  4 files changed, 43 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index ec57caf5b2d7..57318cdc368a 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -8,6 +8,7 @@
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
>  #include <linux/aer.h>
> +#include <cxl/cxl.h>
>  #include <cxlpci.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
> @@ -1055,3 +1056,18 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
>  
>  	return 0;
>  }
> +
> +bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, unsigned long *expected_caps,
> +			unsigned long *current_caps)
> +{
> +
> +	if (current_caps)
> +		bitmap_copy(current_caps, cxlds->capabilities, CXL_MAX_CAPS);
> +
> +	dev_dbg(cxlds->dev, "Checking cxlds caps 0x%pb vs expected caps 0x%pb\n",
> +		cxlds->capabilities, expected_caps);
> +
> +	/* Checking a minimum of mandatory/expected capabilities */
> +	return bitmap_subset(expected_caps, cxlds->capabilities, CXL_MAX_CAPS);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_check_caps, "CXL");

cxl_setup_regs() is already exported from the core. Just make the caller
of cxl_setup_regs() responsible for checking the valid bits per its
constraints rather a new mechanism.

