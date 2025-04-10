Return-Path: <netdev+bounces-181204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFA4A8412A
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 12:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB3F83B5E22
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 10:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D48281516;
	Thu, 10 Apr 2025 10:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hVdsQRkQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2606228151E;
	Thu, 10 Apr 2025 10:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744281940; cv=fail; b=eBqJzd4XubIZ/HtlaUtMNn0w+nQ7d6H+DxGDvY2R+YQTQL65nVw7CRkHsM1LPpoe1LCiGaJwMuhIB0iaHwjkA5TElTCpATrGMJyzNKeHiftwjYV0UW07tDsncK2AlT0MfzWBNt9NEbUdArTordr0vKMSbZlYUYPNYb2+jg6h6GI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744281940; c=relaxed/simple;
	bh=vBwfINGeP4Sd6CNthM6IQPDYPVXyYADB15Z7DFrj4i0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TQFfkF2HnMCQhwvZTSE5AtvR7T3nQT6mxtYQhhe4ZIaUOmsD+ebUHJoUURxjNhWtUKT0vROeCrZ65jK5780REgNDRVQyrQDF7pZ1w5i6ZvQNc8aq9GJ38ZE6FS5f6nHefUwgW83YO518EGEMSdKSB6iGweF9qdGaMYj0OY7ZlDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hVdsQRkQ; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744281938; x=1775817938;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vBwfINGeP4Sd6CNthM6IQPDYPVXyYADB15Z7DFrj4i0=;
  b=hVdsQRkQU7AYnKIg+2lkJsQYuETi5wpyF0FDqphP6fqBg8IU6jzvwnDY
   gvDrBOTiT7lSgMFXfltrZiirnZVrsZR9FHmlhbuQa+fLaMKoe4ZC3bKNg
   vz7wrHqrdyPdVGplDnsIO96zsFuAsfre5l0vskwGQdqWLm5JY2HKpqWaN
   8YK1bmv0OYEDq5pQryLW4/+9yw/1g4vaJxR2v6nrDSue8z3rhORDRW8Q+
   zdr/jXCV6tpAvqkJZ/RC0M8d1ccIPuv0ntLFavR9s5Pcwut2SqJkHuWrO
   1/nQdXrdhjRXtECnJak3dydCBFGRO3uVhhyWlukgr+ATl2LTrh7QiaxM1
   w==;
X-CSE-ConnectionGUID: K9CncFujTmSgnM6N+OJOyw==
X-CSE-MsgGUID: mVlg86UlSWSOG0Dl8wBC6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="56432924"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="56432924"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 03:45:37 -0700
X-CSE-ConnectionGUID: KgC8p68ITlOqkuWcJAzkuA==
X-CSE-MsgGUID: 74SL5tw4QPS5bizfXjd45Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="133988699"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 03:45:36 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 03:45:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 10 Apr 2025 03:45:36 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 10 Apr 2025 03:45:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQcLqKIusyYqG9O1VzIccovP3iv3J7Cfi6u+R6Z2I1M9u5RU19uUMxWU9Ts9GWlE1JfygFUtgPphe0iu0Q9fA8bPj+HnYBHsOO8t/Jeopn8sNlHf3VyJqRjU1ARiqkQgObUQfMbLroNkU4LBDVgXdzJ9dJjuaq4/IwHnazTPU25wEDPuUsrRA4EVtaf3iPJMvYbGCRHYsYs3uLYQacMgEBSrNGax0S4NtYntNWDjIaUKDR0tIv0PxedY50Ax4WecrgQKag0KAW2YhyHoesXLm+/eY3a1ocjg8RuAzHwwHXDUu3xM9STGI6TsAd+iWProU8p5Q8BBXbK1JFPN/ZZWQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftGZTZgRKX5vGOyONAzQDFe0SGQsQc1mT6dqlYq+h+k=;
 b=ja9PneWnRpXdeUWeOP9lkGGoUZFxYbxL9NRgSqxYNXlJs9yVutWZKhkjWdg8anOPvtwyMtrfrwR4RtQCjg2QnkVpCjMhe2KvM33i5lIOy8NdhUbe+b1jTIPG7loLJH+9wNlAlBgPDRumC1u3f9X0zFET2HWDpRC4h3Nce2zav3QwnIj6NbD+k4ZiGBnI6SP++i71eekiGxPGWJthhS9VxWjqAB9DQ5iEqSIc6e37vyvmZMeSpL+vlLGD0xrshlJskjJYOuH+835JYudPhjZxJE12UGKH/E4wPGfuxdTj/lN4S99TR5Z3nVL8RGbL/WwE2T9mZeI0g+DBIArFif6fIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SJ5PPF4DC104A0B.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::827) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Thu, 10 Apr
 2025 10:44:51 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%4]) with mapi id 15.20.8606.029; Thu, 10 Apr 2025
 10:44:50 +0000
Date: Thu, 10 Apr 2025 12:44:33 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Leon Romanovsky <leon@kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, Jiri Pirko
	<jiri@resnulli.us>, Tatyana Nikolova <tatyana.e.nikolova@intel.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Michael Ellerman <mpe@ellerman.id.au>,
	"Maciej Fijalkowski" <maciej.fijalkowski@intel.com>, Lee Trager
	<lee@trager.us>, Madhavan Srinivasan <maddy@linux.ibm.com>, Sridhar Samudrala
	<sridhar.samudrala@intel.com>, Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, Mateusz Polchlopek
	<mateusz.polchlopek@intel.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
	<netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Karlsson, Magnus"
	<magnus.karlsson@intel.com>, Emil Tantilov <emil.s.tantilov@intel.com>,
	"Madhu Chittim" <madhu.chittim@intel.com>, Josh Hay <joshua.a.hay@intel.com>,
	"Milena Olech" <milena.olech@intel.com>, <pavan.kumar.linga@intel.com>,
	"Singhai, Anjali" <anjali.singhai@intel.com>, Phani R Burra
	<phani.r.burra@intel.com>
Subject: Re: [PATCH iwl-next 05/14] libeth: add control queue support
Message-ID: <Z_ehEXmlEBREQWQM@soc-5CG4396X81.clients.intel.com>
References: <20250408124816.11584-1-larysa.zaremba@intel.com>
 <20250408124816.11584-6-larysa.zaremba@intel.com>
 <20250410082137.GO199604@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250410082137.GO199604@unreal>
X-ClientProxiedBy: WA1P291CA0016.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::27) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|SJ5PPF4DC104A0B:EE_
X-MS-Office365-Filtering-Correlation-Id: 48ca3554-44d7-45fa-b76f-08dd781cb884
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/uyW3bYwj5d9GI0lBpdSIpCFucy4Bvv7t4uz44JTr4nAIuC0KZBfh7yLU4QX?=
 =?us-ascii?Q?mKrIv2gl0rbMyjjkiejM6g33wRF+9FLzr0ZPR1LTEazY6zeG6lmNRzNo6fFP?=
 =?us-ascii?Q?sJ7wVAZjadKcnlovmeIeGx9t9JUJezLHr097mWesMq5U1cou64Nn/o2sOrIT?=
 =?us-ascii?Q?Aa71svAuIiZCve057OQSz1sjmtwFASY7O+M6ZmtPdnbalS5uussvsI3EkgWm?=
 =?us-ascii?Q?sYIlnBPgb3mm4ZQaRikHeWQw666mShKG0AaeAYTRWO9nSbrb0Er7M2Cy4Qdx?=
 =?us-ascii?Q?CqkXV5R34+O2eaE+/ZrFE3babHDfeQ5pp9WDExCbL8gefRmcCStPjrad9zux?=
 =?us-ascii?Q?EpKEYvhXP/W5gtmS+4oWj17DnQLzzgfNkpYeYBzPpyqq3PMiyOhJYsxg+tmJ?=
 =?us-ascii?Q?mdoqtId38fbk+YHEe8UaFNWZndZ2ODbltqQLea9oeUtOxYDwNynZNAYq0fZY?=
 =?us-ascii?Q?ZYgDt6HFiA3r5pvIyMo6oqHImzg+V5+/aORYotqncYu/MiDgsxeRmaUmw09H?=
 =?us-ascii?Q?JyZZofXveyZRf5VAEl/wpmRsfzhRTGt3du6GEDVe2wnrCFwlmozL7sE3iSY2?=
 =?us-ascii?Q?MREoWVB+zg89NSrefoZ6E1SZ8lH6larUtUVofVkPC3sW7vEiIB3RHApTdrRp?=
 =?us-ascii?Q?YubP+sbUnMkVVUAkmNaH5ZC1/AcOYYXOSBgMyMCustvJKlpdxuNunKTdDC9S?=
 =?us-ascii?Q?FBjlnzifk/XYecd/VCA8fiLhc9tFIJW58/smf6M974FDKNTWdrgnqPGDpj1T?=
 =?us-ascii?Q?h33POqtUAGf1i9tKoZpr5q0GIrc3uTepZZihGvzXR4cBIh7kP76ZshyYYEiG?=
 =?us-ascii?Q?EZyNYLlSkOBvbqgxy++qx61Qwm+a2g9Wl0Z25H8GQA68CtjVcX6QA89NV4mj?=
 =?us-ascii?Q?jqNXlmGZgh6Tyd1/9GwsvXyzrVj+BVNcUdJp/oZI6Yl0uQxZ1XG/jdqJ9oJo?=
 =?us-ascii?Q?EBdgxJDfCpRu7Oszay7UEv5VoQFnhvpkgVnKyS9SMlHpA5ELKqur3nk8eRpO?=
 =?us-ascii?Q?o2B5WchdUfUSzMkBhmnU/q9I5fgI8qQBnQqr6LcuwA+MfSB2U+MF3L6SCJh+?=
 =?us-ascii?Q?A8N5MlBUMVGx54b8YwvoUpS9kdfaqWbxNgQ5vRh/2hbOxZf9p7CwwxdjSCGO?=
 =?us-ascii?Q?HK3O/g1HX9hn0hx72pJZAHwkGG58+6dAFbVt/f5FpgwIffxBn9gMhCyp1Ho8?=
 =?us-ascii?Q?XMPuUhFhr35Xyy5qjZaDkteXQqNGhfhRfeP9DnaAck2QQJObXkBjr4cvy20D?=
 =?us-ascii?Q?8gzTA/OkQ8TPkTMIfabfH7VovpnDM29ilfrRdcuVtDf7DaxzS7NAIE7QkUeW?=
 =?us-ascii?Q?/bm90kYH0N3V20igS4f3dSV8ckKuAs6voCamqKBwpZMLndS+7ffpFJApb8Mk?=
 =?us-ascii?Q?enelNlg0vMaPXnwgoJ5EdR5NtHUk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ofh0L2q71kKQTGbHM/cb8fQ743yZAlyVG8rWwJpRY9N06Gf7nZe/+oQOcWkr?=
 =?us-ascii?Q?ss+ecsbnE+z+qjVhiWX7F6+affD6LU9wT6J2HU2ZenDtUXQILz1z7Il/iN9z?=
 =?us-ascii?Q?QVU6g7TKxHIw8ByPwksQmywciKzAo6tXVMBZzXpDCYdslFUTzCsGwC5Plg/r?=
 =?us-ascii?Q?b7Forog+HUwPxjnXw0k+BU5DpJAaJXKtwWPVi8UQMTw7gE5Uecdu8G4Qitqn?=
 =?us-ascii?Q?aSUyNG5W6NVtfeFejLWclfPGa3fuVtGoITYUdU8+ccJjDkne7DCEwIl2p3cM?=
 =?us-ascii?Q?L/fcqs9YIf4iiOT/QMowq5kEztw/zP9l6jrm0oVRIK8DGI3LsmX44apSmPPg?=
 =?us-ascii?Q?adAgoYLYkHDBriJB27ylDaBXHMKUDvTZ6mhF5xoLitqumjhxkxYD8ekoLmTn?=
 =?us-ascii?Q?ZYWqu6uCpnmeKxkT7ULsddYPqRGWT5YN4mKbD1WTzLWvsIXQxqCXh62kUKyy?=
 =?us-ascii?Q?fKOEaTxctM4D8F6q+aJNz4ciwg4wA04LHpZIaZ+e1S+9wGhBhJTB4db4DrQK?=
 =?us-ascii?Q?Rg5+ZV/qqn/x8MIsZB6jBEjDHMhFK1AOOsEkiNTjVRdhvr1nk7tgrP0XQPSr?=
 =?us-ascii?Q?WlaoqjN3csHX+A7H4eQdemOk8jSo8Y5uhxwP7tqPOk0SSuxsyEoEvjVHU2Tp?=
 =?us-ascii?Q?WxJc/ymcaLjh+e4uSGza8wpxRK1RfZldCi/QGHeR0E+R0eZq44O3gnGlgxy1?=
 =?us-ascii?Q?EVKneKl4/s+pJyhef04O6dYX5Adivyz/OUpLgDhA+iD+tNK6u/iI0pj78+Wn?=
 =?us-ascii?Q?jBL0U15gqfbRF4hYxUiMPi4Nv+0NR/bzkFF17GZO8KtQkgZT72JHPC/xPxst?=
 =?us-ascii?Q?rrJ4rfSRg7oG9RC73uWb46XQ9H+AiJlY5/uzxYHSjl20a//pUra7t5M9tXNm?=
 =?us-ascii?Q?3os2XikFiDsaSZhL2inzzysE3u9MIJufGdrh6kDEfAb0fFg+42+SvYNTpit4?=
 =?us-ascii?Q?EST+nWRkuT1LmT5o7SCy9kDjzxS+Xd8IQ5Ro+Gj1gh86IOfrd0GHunAI7uEm?=
 =?us-ascii?Q?z5CUFLrkpDB3NDObE5WVzwjtaUboKw2eft0osPgtFyJKn0h7ILI7lPpcRLqe?=
 =?us-ascii?Q?MupR0534roqQ/1xG2hzIZNsYfjPT0CN9iApgdUbfrgiDPBvwZeuy9+Isi9Js?=
 =?us-ascii?Q?/CmFl1Lk18+FC903+fMIh9kRnzEhg2L9q8kMYGCc/b7NueFP45AYZEUEvKNe?=
 =?us-ascii?Q?gOrelKkVo/DwnTLvz9EnO7NW4rauLT5DIDzmqdNAs44U0bKwDPcUOMHeFJND?=
 =?us-ascii?Q?OE0qTBLappk1KykLmIvWHSoF2T3uWLaS9+43ojJfj5Bu3PYnuoIAipnXZuyc?=
 =?us-ascii?Q?LVg7evn0Hww+hiKf0dPeEme2nA1fGhLWweOtcjWRvKMQU3YPjDoxdK2QCvvB?=
 =?us-ascii?Q?WjtsJSbMETeWUK4JDKs/8yI76a/rWSlA6I9+QSbO3jhrLaRrKtEPETdVRPIx?=
 =?us-ascii?Q?JtwBzvC3pD0s2KbRH4KGAoA6ylcomTH7gYi9gqAGXkaZqpjFCdz6cef6AH43?=
 =?us-ascii?Q?BGm7BkeE90TQi1Mbh4d0E1SyrJmuVi0nf+04IhJW8aAro6J1KrBVRoP5cGXB?=
 =?us-ascii?Q?l4USAeoOlgCYQGe2ChQLncQc1DQgp2KyvQTbDl/Bkua65+MTSeiHaecdJNWc?=
 =?us-ascii?Q?9uVZHuwJVAqcaIjhXMnHduXgmypYk6KNyDbfKQffbbjzogShUlI82SLss6cu?=
 =?us-ascii?Q?BGtjVQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ca3554-44d7-45fa-b76f-08dd781cb884
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 10:44:50.8946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8UBj0uhp4h+706zeBrbtIWQWUxem8PIFATdgF4yoMDRUa7XcpKPv46003nNpQF5FJqpC1XZvJgAj6v7K5xPjXlTEWt3feN78RNTdTLs+iBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4DC104A0B
X-OriginatorOrg: intel.com

On Thu, Apr 10, 2025 at 11:21:37AM +0300, Leon Romanovsky wrote:
> On Tue, Apr 08, 2025 at 02:47:51PM +0200, Larysa Zaremba wrote:
> > From: Phani R Burra <phani.r.burra@intel.com>
> > 
> > Libeth will now support control queue setup and configuration APIs.
> > These are mainly used for mailbox communication between drivers and
> > control plane.
> > 
> > Make use of the page pool support for managing controlq buffers.
> 
> <...>
> 
> >  libeth-y			:= rx.o
> >  
> > +obj-$(CONFIG_LIBETH_CP)		+= libeth_cp.o
> > +
> > +libeth_cp-y			:= controlq.o
> 
> So why did you create separate module for it?
> Now you have pci -> libeth -> libeth_cp -> ixd, with the potential races between ixd and libeth, am I right?
>

I am not sure what kind of races do you mean, all libeth modules themselves are 
stateless and will stay this way [0], all used data is owned by drivers.

As for the module separation, I think there is no harm in keeping it modular. 
We intend to use basic libeth (libeth_rx) in drivers that for sure have no use 
for libeth_cp. libeth_pci and libeth_cp separation is more arbitral, as we have 
no plans for now to use them separately.

Module dependencies are as follows:

libeth_rx and libeth_pci do not depend on other modules.
libeth_cp depends on both libeth_rx and libeth_pci.
idpf directly uses libeth_pci, libeth_rx and libeth_cp.
ixd directly uses libeth_cp and libeth_pci.

[0] https://lore.kernel.org/netdev/61bfa880-6a88-4eac-bab7-040bf72a11ef@intel.com/

> Thanks

