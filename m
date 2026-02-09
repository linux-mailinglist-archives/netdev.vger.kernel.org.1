Return-Path: <netdev+bounces-257894-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNxnIkZsiWkZ8wQAu9opvQ
	(envelope-from <netdev+bounces-257894-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 06:10:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 661CD10BB75
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 06:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C523430013BE
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 05:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E001F2D5C71;
	Mon,  9 Feb 2026 05:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l02nvOTj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A242C0F6D
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 05:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770613824; cv=fail; b=qEdLUNhBIIH0Y24ak46xX2rv6XvQMN1/hSYq41XwdP5FFfygTV36cn6ADXN7v4D4AFM7GSyM56ApPcAizp+X11Ts2fKk9YRzhLt4p0LZZt+8lub82CvwBdwtl/ErGc8kVzhVFugiFToeX1dU8Y3gvKrDxsj6onF5GDvRwnkba4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770613824; c=relaxed/simple;
	bh=7Sp1eZp7wd1fG/Dd1lCXGNp6pfteH2+JLaqMdJSnoiQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m/JMO+iHK4fULWI6A3l6ETgifgYzJCL5hLBQrONl5yTroZCCdTcHg6GNP2kXh+NjwihuJizvpm9+ke50xbwYdG3oEj1UoD8IlUe/ldDb9Q92PrLyNNjO9Lmy39HweIb6JxzLXq2uHR6eIHenNZeiNXJxKspDtmjvVDT0VneG21A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l02nvOTj; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770613825; x=1802149825;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=7Sp1eZp7wd1fG/Dd1lCXGNp6pfteH2+JLaqMdJSnoiQ=;
  b=l02nvOTj90fTnlXzYKLn40ZC5jdhuQOPDNxEqGfZdmjWJlxqFBQYEOx8
   Cq0HNyCKB2+8qtxHfMwMF3rZ+NT776oRhDqy3kdj4FLKwhteIZCQcB5PC
   2hSjKj5+f92ZkeB7cuN8MpC7A5C0igozsQ/9W/CINHtZDrLcLireYRr+4
   ZBJ55MLDSYmnIKyhAjYUAvAez4FkhEUedod7KDSWBkbJIdgb0daV3I4fT
   FpDl8ynhY2b9XtnhW6Uen+G+qsM4t7GrOWasIep7nhUtZ5zRfApxcj581
   szGRTk98+5tVIB42XOoZZ/Yg+559tm93wcugmIOyXdHPeQ+YBLEM74CIH
   g==;
X-CSE-ConnectionGUID: EiqZQgcKTqW1wYtOzgHDlw==
X-CSE-MsgGUID: 2JwJtkcPRfqIMZobawlArQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="83090879"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="83090879"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 21:10:24 -0800
X-CSE-ConnectionGUID: i3Z+QoQyRPmgp/2Ard4TsA==
X-CSE-MsgGUID: 9soWveqTT027/SEDmQ1fgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="215961218"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 21:10:22 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sun, 8 Feb 2026 21:10:21 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Sun, 8 Feb 2026 21:10:21 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.48) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sun, 8 Feb 2026 21:10:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gR3zxpvjyuksoeaxVERGfoj4q1wGyO3LCFkPh904gj3LbdyhGMojAWn4ULnCnTm8SUPqj45chNzQwFf/mxff+sbJfn0P58xaEoR71Z0bUTjNY2Apov3HYc4rRXm5pbX5+hyfa+hYOK2cgDiDhag1nwlwB4OyFwaHdMByatGiVRg8EjremSIEi2/xKUAFgND/HAKsUiwd8PUHgBgh8nwr3pmdNzclMh1OmJ4ZSRdVOCEKa0QjoDII8zx7OmjAbElpuZ2G11cz98Qcit+6mtoCBNqHh8i2LsoG121XP7H1l2fw24Tmi1vDaOB6lU8RkifJ7qJxOpdjDDxxX2DZVoxHGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgClTLraCfe+k8eH8NXv7c73chsoURnfX2Z++3a3ICM=;
 b=aYsZRJfWdO7p5Kfv7NJqY+tG4dYwQomnm2Hwd+jgXdLpmpMzoE000SlpIZ7eYevxLzcIhohHyOtLjDmoKrkMYUYPtASrWMVyhf4C7GVwFlocZuTL3WQWgqIvA1WPa3o3ID+Y3VYGEbbk0xCuO/65OUMT527Qp2Yl7sCrBWqpIqQQpLIkpQbtsow2AnluKj95m266pU4bxUl2XzKHsCVe9ISkZ93qaNWbzkgNCpH7lbqMkrztk5bD2Fy0mSt5POhk5gv8gyZmISBQ7JNKhm/kq8odi6eTL56bwQrPnXWuiZnsrHEd40GsxcteRR8Emjcqy7lk3SEKHgSf47bTdh9arQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB8523.namprd11.prod.outlook.com (2603:10b6:806:3b5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 05:10:11 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257%5]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 05:10:11 +0000
Date: Mon, 9 Feb 2026 13:10:00 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Eric Dumazet <edumazet@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <netdev@vger.kernel.org>,
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, "Neal
 Cardwell" <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
	<eric.dumazet@gmail.com>, Eric Dumazet <edumazet@google.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH net-next 2/3] tcp: move tcp_v6_send_check() to
 tcp_output.c
Message-ID: <202602091222.231689fb-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260203144053.83193-3-edumazet@google.com>
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB8523:EE_
X-MS-Office365-Filtering-Correlation-Id: 521658d7-20d5-48e6-45b0-08de6799804e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BiEGUBok1poKiikcVKPdHNzwRSUT5kYPGqCAe6WRepwy/x02Nse6e2HAN8kX?=
 =?us-ascii?Q?fQS46y5zPOSnXXEoJs86F0Aa2tCDA+xaJx346DNe1Rt3pyXn10KFkUH7xw+T?=
 =?us-ascii?Q?A732J4JhEt8CZLrX7cdLy5pdjvm+Kee6TbuyIES1i88APXzpdjz0DWcMfQj2?=
 =?us-ascii?Q?Kg5poL2HueLBMpV41uw7CLu0vt91sLedDDRcg2J8AIyMABfhCKVRjurLFUv1?=
 =?us-ascii?Q?2Nw92T2xOtXWWom79UJYRKHIBjHnHqRrkL/ckoIOPhqqnh62VA7WSEQDed6c?=
 =?us-ascii?Q?1otQF7z/O32nWvIEm4YZWa/hUTBHSe78fGDJCR/EscgSstydyUw59QYBsfJf?=
 =?us-ascii?Q?XHIbcQgn/B1MQkb2kCnhID6gdKgRYxWknTaejj9iew9hE8ZG2a5A1+ON0mer?=
 =?us-ascii?Q?bP26cIdY9UZyyp6UOa3lpZSRhG45qkBD52AFnAuwR3CEc5ns/xWDDDOedI8d?=
 =?us-ascii?Q?ZgJ+rJ2x95UelVroUOptnEBfdcsrjPfKp68PPXa2fu5pCSspHYizdb4BEOfK?=
 =?us-ascii?Q?pyWFssbn8Kdg5treoBQSXaTPZzEvt2zAwZDfewGIItOklyO/GD753ZtyFX1f?=
 =?us-ascii?Q?phr6sR3RxVqc5Xs5bS7Pz8xKjZ+4EuOJ8Z+KBrLZdbvyMBx3tvoNM000X2Za?=
 =?us-ascii?Q?4tUVJDMZeX/6Joy5xFDwRGgRwEVshgeH+66x9Gg93Dn4orOIaTAJaXV7Ol+o?=
 =?us-ascii?Q?g6q6qfVaaNa3PefMaywst4v48RPEAB/sKeikM3SgrlTgAcCuYbYeflEurcBY?=
 =?us-ascii?Q?vGloadivF324AY+47MTb4a9URQBiDrByxnCc/9Qpviz5z51Ckui6Ng3g03Ft?=
 =?us-ascii?Q?MhMtGMQrrds6zFyjXmt9eetiGxZZJD3nwdWGg8vs0utCX4memcvbYib8vvZ6?=
 =?us-ascii?Q?9EqDAU3F3xBRE614tL++VIdLBWJ7a4hF2RCZDOW+AjrbdLN5wp3dKfb9E0t+?=
 =?us-ascii?Q?2oWim+dsm6AYOI6WDlRrD6Ju1ZWlapk32rV4CVDNWx86n7ynvRH77Oh9UU7z?=
 =?us-ascii?Q?EE10GIFw8QkHndg0iQiryMWHDgMFTtPznBBoga9fHRwhBk+EtxKH7Up38RBm?=
 =?us-ascii?Q?WSlxueP0e0EBLHTtRb2dC+OUERhxwyXO680X+Svha+PSU7RYbLvCS47Lzusl?=
 =?us-ascii?Q?65UBA4et4rA9UNpg3IhxIPDm12qYx9auHkhRPCyfxCNl213zQcvkuCrorNRC?=
 =?us-ascii?Q?/xs/AlwggXhPAbRQe+9EvLRAG2pid1GJ1tA/c/oK0wYBrDLvXerxlJoR4tCA?=
 =?us-ascii?Q?kYeHVnmHnmzD9I70CtbqGoO586oma30gAEVU6g2+A2KlDgKndIulQCQrwpiA?=
 =?us-ascii?Q?Ya7kETW5wd7IWG+N80ycOkRIPWc024HA9Fixm9RlVmxyoC8fsVMvypLpA0z1?=
 =?us-ascii?Q?U04elmmrtDdnxbIsIeJOOuOnMV1K/VNtPOfp3z3YGqsikY6jVYEgTVIRFLGJ?=
 =?us-ascii?Q?96R1JbayaXMToMQBstgGNGuRBeauEEOZFoTEbpuTpb8ggZiLxIws1mlcbAaM?=
 =?us-ascii?Q?KFGv0INsm2ABhYS31EVgOoCRj08eNxUaW/4slmYA12IrXSQp2WIdmq0lSqH5?=
 =?us-ascii?Q?vlC4VoqghApd8XsEg688N9Ysu50nHbZzjoTT2waH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RWVShascZYnyO5u0xsFt1AiWAd3WD7Xqkq5Odi+7DJtQTeMAHAx+Wa1T87jM?=
 =?us-ascii?Q?5n5534EAf0b2/dCJ56oWh8MLUWxDJjjX5cBi1sP7aYVGNWZcghyeBlXIqM9p?=
 =?us-ascii?Q?7kw8zq6zwxaJoVSjotLamP5YqBEHajd7pmcYQTiS4Dqm4U8cQMLaCCvWYBfd?=
 =?us-ascii?Q?wHCclzH7Mmvcr7mdiUevVjbwBY7/olVtLeq9xpo3oh/qlMeWaGXWV4iAWK/X?=
 =?us-ascii?Q?Sg4E1EMbPzam2myDWgDvLVPJa7yoGyrGvOeNn8KdgsktzwiCcF6/N1FsWyA9?=
 =?us-ascii?Q?5Xbu1T0NdVso8/Uaku4lGeXQELCo0UohgBysFrifzB3vtTrPqnSFJoA1ERn9?=
 =?us-ascii?Q?3U9jAA7ITO2Mnn5FDd41zFSimh9WdEQtK47vdzmIgD31Y1pt9PIhZyRetb9P?=
 =?us-ascii?Q?b5r27O9C9FAPRCZ8q9QtPgLnvNMNWLMiS2KSxNEczkZwmdf+J57Cj6oZdDpS?=
 =?us-ascii?Q?sVaeLVQ1Xw3lzxg8p2CK1oUmjyEQYkVLAUiFubg0DFfjcwMKPa3VrVMCK3Zw?=
 =?us-ascii?Q?vaqMI/4fQFYt8WcZcGbe+pDff2PVyUr2dQXGmR4xpxKOD38fPsmjKaSWVr/X?=
 =?us-ascii?Q?P5Yx3uKph2G8OkIvaojjrShHRjpKJm7bDtd+ReJWuLTD4ZWBaobXJszm/RBF?=
 =?us-ascii?Q?8Vl3+tkfhxJt0ven2btDzu2R3sCPYmYTaPD0+US+zGUgv2fRd74hD+4rDGn0?=
 =?us-ascii?Q?ILHA2Dt57sm2W4230NuzBW8zG+rZ7aCIiFtcFBIgLMQmENMXpAorz4/xtPSe?=
 =?us-ascii?Q?nRW3L8hBl28G8tiSVVXVYK6RFijfGLOkiEgzLxrKcL8Z4wROSSNRl71abXk+?=
 =?us-ascii?Q?9wiB91D4z+q9/roUQrsJiXomIdWIPjGYhm5HhIPr8wYAJZaqnWdErVBdf7/m?=
 =?us-ascii?Q?0hR+MZnwQ/giItZa72BYQGnNN9nTL4dA2qrCgL3HCvBBQsnPCwxws2VW9pVl?=
 =?us-ascii?Q?7bMiWuCIjTbHFhwRS6CNfmkR71h/NkeOt2TqKoNB16/OI+mf0EBWQpT8QS6L?=
 =?us-ascii?Q?vzt09EbQSsvAa8rsbnr8caP+HbGD3xLLmYxbs17w8p/ZeYzm7ZBH5B7nuOpP?=
 =?us-ascii?Q?oI5Wrq4be/vpSnitXmcdzm7OqoMLsnOxQ3ul46oWESgFfrUZ9BkC/f26zPVj?=
 =?us-ascii?Q?NLUSZwnNMgZ6kdjZA7cYJxy3zD7/WvhxN72jOsMNpBlsg7zUW1NQwwQJOWEq?=
 =?us-ascii?Q?5B4mrYZCuTh8zScDhlqTDQBMvNXcK1M/O9sksgKxNHncIQbo3c+68watPeDk?=
 =?us-ascii?Q?fb5UOpTSCxi7fJXGGAVDQtAI9uCDTtGcUaOxmHSK+WiYwZHtRQuEx5IpYJG/?=
 =?us-ascii?Q?yKWHNmjIVH6qjAc41swm+ZNpqZ2oEnJzE3CgoYKlzJXFkln3s+w0yQjdmYJz?=
 =?us-ascii?Q?OTHavP5URRnwq3ZJuj9pElMPtNxzUlUlMkEDbXhmNihy9NP+YmJJKD1H4yHK?=
 =?us-ascii?Q?g4EaCE/RVYcoS4Med6UbEWIGjpBEiXOOeSLNnQ3Qz4ZDXRwR2KZ/zX+D1bYz?=
 =?us-ascii?Q?ITrrcvUiAp+7MFSunqYT1OVf78ZHryFjzo1Ux1cQnFhbwo390Z/oNx2caGYg?=
 =?us-ascii?Q?Mg1tmm8GBzIMp9SUVG56ksgPfGqnlEJ8sXzIsDMZpErVgbME44w5Iwi7Y91g?=
 =?us-ascii?Q?aLtZrjCTcngI+tSNUBleqKBCZq91K3ES4/BPAi95DepbYFFF5VojpQaimG4T?=
 =?us-ascii?Q?E7BlQDexDjWGDAcG4SHgySAfV+mwJco7512OROkZFTcvNc4MSWGy3uis7Ahk?=
 =?us-ascii?Q?F+N7D6QdqA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 521658d7-20d5-48e6-45b0-08de6799804e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 05:10:11.4719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8hP+KDfEtfhTZoJ8lWxHjSCz0ugKnbBbVoGHEn0XAJ+etDS9loisFXqi1AcpfzzObgom8RQvX03UIwxVWc6XvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8523
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257894-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,intel.com,vger.kernel.org,davemloft.net,kernel.org,redhat.com,google.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 661CD10BB75
X-Rspamd-Action: no action



Hello,

kernel test robot noticed "RIP:skb_checksum_help" on:

commit: e0b782187c458dac827263181b85fed32e3e0faa ("[PATCH net-next 2/3] tcp: move tcp_v6_send_check() to tcp_output.c")
url: https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/tcp-inline-__tcp_v4_send_check/20260203-224938
base: https://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git 667539f6dce27aa7db0a711375f94e14e714a698
patch link: https://lore.kernel.org/all/20260203144053.83193-3-edumazet@google.com/
patch subject: [PATCH net-next 2/3] tcp: move tcp_v6_send_check() to tcp_output.c

in testcase: kernel-selftests
version: kernel-selftests-x86_64-9f2693489ef8-1_20260201
with following parameters:

	group: sgx



config: x86_64-rhel-9.4-kselftests
compiler: gcc-14
test machine: 16 threads 1 sockets Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz (Coffee Lake-E) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202602091222.231689fb-lkp@intel.com



[   58.597580][ T2071] ------------[ cut here ]------------
[   58.597581][ T2071] offset (-246) >= skb_headlen() (74)
[   58.597583][ T2071] WARNING: net/core/dev.c:3591 at skb_checksum_help+0x3fc/0x6b0, CPU#9: wget/2071
[   58.597589][ T2071] Modules linked in: btrfs blake2b libblake2b xor zstd_compress raid6_pq intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel sd_mod kvm sg snd_pcm irqbypass ghash_clmulni_intel ast snd_timer i2c_designware_platform rapl drm_client_lib i2c_designware_core snd intel_cstate drm_shmem_helper ppdev ahci soundcore wmi_bmof intel_wmi_thunderbolt libahci intel_uncore i2c_i801 drm_kms_helper intel_lpss_pci mei_me intel_pmc_core intel_lpss intel_ish_ipc pcspkr i2c_smbus libata idma64 mei intel_ishtp intel_pch_thermal ie31200_edac parport_pc pmt_telemetry video acpi_power_meter parport pmt_discovery pmt_class acpi_ipmi wmi ipmi_devintf pinctrl_cannonlake intel_pmc_ssram_telemetry intel_vsec ipmi_msghandler acpi_pad acpi_tad binfmt_misc fuse drm nfnetlink sch_fq_codel
[   58.597670][ T2071] CPU: 9 UID: 0 PID: 2071 Comm: wget Tainted: G S                  6.19.0-rc7-01160-ge0b782187c45 #1 PREEMPT(voluntary)
[   58.597674][ T2071] Tainted: [S]=CPU_OUT_OF_SPEC
[   58.597676][ T2071] Hardware name: Intel Corporation Mehlow UP Server Platform/Moss Beach Server, BIOS CNLSE2R1.R00.X188.B13.1903250419 03/25/2019
[   58.597678][ T2071] RIP: 0010:skb_checksum_help (net/core/dev.c:3591 (discriminator 1))
[   58.597681][ T2071] Code: ff ff 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 80 3d 38 9f e0 02 00 0f 84 13 01 00 00 48 8d 3d b4 86 ea 02 89 c2 44 89 c6 <67> 48 0f b9 3a eb c8 80 3d 17 9f e0 02 00 0f 84 69 01 00 00 48 8d
All code
========
   0:	ff                   	(bad)
   1:	ff 5b 5d             	lcall  *0x5d(%rbx)
   4:	41 5c                	pop    %r12
   6:	41 5d                	pop    %r13
   8:	41 5e                	pop    %r14
   a:	41 5f                	pop    %r15
   c:	c3                   	ret
   d:	cc                   	int3
   e:	cc                   	int3
   f:	cc                   	int3
  10:	cc                   	int3
  11:	80 3d 38 9f e0 02 00 	cmpb   $0x0,0x2e09f38(%rip)        # 0x2e09f50
  18:	0f 84 13 01 00 00    	je     0x131
  1e:	48 8d 3d b4 86 ea 02 	lea    0x2ea86b4(%rip),%rdi        # 0x2ea86d9
  25:	89 c2                	mov    %eax,%edx
  27:	44 89 c6             	mov    %r8d,%esi
  2a:*	67 48 0f b9 3a       	ud1    (%edx),%rdi		<-- trapping instruction
  2f:	eb c8                	jmp    0xfffffffffffffff9
  31:	80 3d 17 9f e0 02 00 	cmpb   $0x0,0x2e09f17(%rip)        # 0x2e09f4f
  38:	0f 84 69 01 00 00    	je     0x1a7
  3e:	48                   	rex.W
  3f:	8d                   	.byte 0x8d

Code starting with the faulting instruction
===========================================
   0:	67 48 0f b9 3a       	ud1    (%edx),%rdi
   5:	eb c8                	jmp    0xffffffffffffffcf
   7:	80 3d 17 9f e0 02 00 	cmpb   $0x0,0x2e09f17(%rip)        # 0x2e09f25
   e:	0f 84 69 01 00 00    	je     0x17d
  14:	48                   	rex.W
  15:	8d                   	.byte 0x8d
[   58.597684][ T2071] RSP: 0018:ffffc900078feeb8 EFLAGS: 00010202
[   58.597687][ T2071] RAX: 000000000000004a RBX: ffff88885161cd68 RCX: 0000000000000000
[   58.597689][ T2071] RDX: 000000000000004a RSI: 00000000ffffff0a RDI: ffffffff8669e580
[   58.597690][ T2071] RBP: ffff88885161ce38 R08: 00000000ffffff0a R09: 0000000000000000
[   58.597692][ T2071] R10: ffff8887d84ac7cb R11: ffffffff85611318 R12: ffff88885161cddc
[   58.597694][ T2071] R13: 00000000000000f6 R14: ffff88885161cdd8 R15: 0000000000000000
[   58.597696][ T2071] FS:  00007f92ce5929c0(0000) GS:ffff888850da1000(0000) knlGS:0000000000000000
[   58.597698][ T2071] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   58.597699][ T2071] CR2: 00007f820b871060 CR3: 0000000320a0a006 CR4: 00000000003726f0
[   58.597701][ T2071] Call Trace:
[   58.597703][ T2071]  <TASK>
[   58.597708][ T2071]  skb_csum_hwoffload_help (net/core/dev.c:3910)
[   58.597714][ T2071]  ? __pfx_skb_csum_hwoffload_help (net/core/dev.c:3910)
[   58.597722][ T2071]  validate_xmit_skb (net/core/dev.c:4040 (discriminator 1))
[   58.597728][ T2071]  validate_xmit_skb_list (net/core/dev.c:4068)
[   58.597733][ T2071]  sch_direct_xmit (net/sched/sch_generic.c:335 (discriminator 1))
[   58.597740][ T2071]  ? __pfx_sch_direct_xmit (net/sched/sch_generic.c:322)
[   58.597742][ T2071]  ? do_raw_spin_lock (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 kernel/locking/spinlock_debug.c:116)
[   58.597746][ T2071]  ? __pfx_do_raw_spin_lock (kernel/locking/spinlock_debug.c:114)
[   58.597750][ T2071]  ? lock_acquire (include/trace/events/lock.h:24 (discriminator 2) kernel/locking/lockdep.c:5831 (discriminator 2))
[   58.597755][ T2071]  __dev_xmit_skb (net/core/dev.c:4248 (discriminator 1))
[   58.597761][ T2071]  ? __pfx___dev_xmit_skb (net/core/dev.c:4155)
[   58.597765][ T2071]  ? netdev_pick_tx (net/core/dev.c:4673)
[   58.597772][ T2071]  __dev_queue_xmit (net/core/dev.c:4797 (discriminator 1))
[   58.597776][ T2071]  ? check_prev_add (kernel/locking/lockdep.c:3245)
[   58.597779][ T2071]  ? look_up_lock_class (kernel/locking/lockdep.c:933 (discriminator 28))
[   58.597784][ T2071]  ? validate_chain (kernel/locking/lockdep.c:192 kernel/locking/lockdep.c:3912)
[   58.597787][ T2071]  ? lock_release (kernel/locking/lockdep.c:470 (discriminator 4) kernel/locking/lockdep.c:5891 (discriminator 4) kernel/locking/lockdep.c:5875 (discriminator 4))
[   58.604179][  T427]
[   58.609631][ T2071]  ? __pfx___dev_queue_xmit (net/core/dev.c:4739)
[   58.614759][  T427] Setting up libperl5.40:amd64 (5.40.1-6) ...
[   58.622521][ T2071]  ? __lock_acquire (kernel/locking/lockdep.c:5598 (discriminator 1) kernel/locking/lockdep.c:5227 (discriminator 1))
[   58.622528][ T2071]  ? find_held_lock (kernel/locking/lockdep.c:5350 (discriminator 1))
[   58.630933][  T427]
[   58.639329][ T2071]  ? ip_finish_output2 (include/net/neighbour.h:554 net/ipv4/ip_output.c:237)
[   58.639350][ T2071]  ? mark_held_locks (kernel/locking/lockdep.c:4325 (discriminator 1))
[   58.648209][  T427] Setting up perl (5.40.1-6) ...
[   58.654544][ T2071]  ? neigh_hh_output (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:119 arch/x86/include/asm/irqflags.h:159 include/linux/seqlock.h:74 include/linux/seqlock.h:836 include/net/neighbour.h:510)
[   58.654549][ T2071]  ? __asan_memcpy (mm/kasan/shadow.c:105 (discriminator 1))
[   58.659944][  T427]
[   58.665171][ T2071]  ? neigh_hh_output (include/net/neighbour.h:521 (discriminator 6))
[   58.665177][ T2071]  ip_finish_output2 (include/net/neighbour.h:554 net/ipv4/ip_output.c:237)
[   58.674975][  T427] Setting up libgcc-14-dev:amd64 (14.2.0-19) ...
[   58.750584][ T2071]  ? __pfx_ip_finish_output2 (net/ipv4/ip_output.c:201)
[   58.763043][  T427]
[   58.767700][ T2071]  ? __ip_finish_output (include/net/ip.h:518 net/ipv4/ip_output.c:308 net/ipv4/ip_output.c:297)
[   58.781614][  T427] Setting up gcc-14-x86-64-linux-gnu (14.2.0-19) ...
[   58.786471][ T2071]  ip_output (include/linux/netfilter.h:307 net/ipv4/ip_output.c:438)
[   58.805959][  T427]
[   58.811915][ T2071]  ? __pfx_ip_output (net/ipv4/ip_output.c:429)
[   58.811918][ T2071]  ? lock_acquire (include/linux/preempt.h:469 (discriminator 2) include/trace/events/lock.h:24 (discriminator 2) include/trace/events/lock.h:24 (discriminator 2) kernel/locking/lockdep.c:5831 (discriminator 2))
[   58.820369][  T427] Setting up gcc-14 (14.2.0-19) ...
[   58.827634][ T2071]  ? find_held_lock (kernel/locking/lockdep.c:5350 (discriminator 1))
[   58.835497][  T427]
[   58.843338][ T2071]  ? ip4_dst_hoplimit (include/linux/rcupdate.h:341 include/linux/rcupdate.h:897 include/net/route.h:395)
[   58.851846][  T427] Setting up gcc-x86-64-linux-gnu (4:14.2.0-1) ...
[   58.860005][ T2071]  ? ip4_dst_hoplimit (include/linux/rcupdate.h:341 include/linux/rcupdate.h:897 include/net/route.h:395)
[   58.866491][  T427]
[   58.874333][ T2071]  ? __lock_release+0x5d/0x1b0
[   58.878004][  T427] Setting up gcc (4:14.2.0-1) ...
[   58.880336][ T2071]  __ip_queue_xmit (include/net/dst.h:470 (discriminator 8) net/ipv4/ip_output.c:131 (discriminator 8) net/ipv4/ip_output.c:534 (discriminator 8))
[   58.885595][  T427]
[   58.891439][ T2071]  __tcp_transmit_skb (net/ipv4/tcp_output.c:1696 (discriminator 4))
[   58.896997][  T427] Setting up g++-14-x86-64-linux-gnu (14.2.0-19) ...
[   58.901427][ T2071]  ? __pfx___tcp_transmit_skb (net/ipv4/tcp_output.c:1513)
[   58.906158][  T427]
[   58.911321][ T2071]  ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4629 (discriminator 4))
[   58.916669][  T427] Setting up g++-14 (14.2.0-19) ...
[   58.921472][ T2071]  tcp_connect (net/ipv4/tcp_output.c:1714 net/ipv4/tcp_output.c:4380)
[   58.925973][  T427]
[   58.930620][ T2071]  ? __pfx_tcp_connect (net/ipv4/tcp_output.c:4300)
[   58.936411][  T427] Setting up g++-x86-64-linux-gnu (4:14.2.0-1) ...
[   58.940337][ T2071]  ? get_net_ns_by_id (include/linux/rcupdate.h:895 (discriminator 5) net/core/net_namespace.c:383 (discriminator 5))
[   58.945154][  T427]
[   58.949884][ T2071]  ? lock_release (kernel/locking/lockdep.c:470 (discriminator 4) kernel/locking/lockdep.c:5891 (discriminator 4) kernel/locking/lockdep.c:5875 (discriminator 4))
[   58.949914][ T2071]  tcp_v4_connect (net/ipv4/tcp_ipv4.c:347 (discriminator 1))
[   58.955368][  T427] Setting up g++ (4:14.2.0-1) ...
[   58.959662][ T2071]  ? __pfx_tcp_v4_connect (net/ipv4/tcp_ipv4.c:225)
[   58.964136][  T427]
[   58.966346][ T2071]  ? do_raw_spin_lock (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 kernel/locking/spinlock_debug.c:116)
[   58.972814][  T427] update-alternatives: using /usr/bin/g++ to provide /usr/bin/c++ (c++) in auto mode
[   58.977548][ T2071]  ? find_held_lock (kernel/locking/lockdep.c:5350 (discriminator 1))
[   58.982282][  T427]
[   58.986831][ T2071]  ? inet_stream_connect (net/ipv4/af_inet.c:750)
[   58.989558][  T427] Setting up libdpkg-perl (1.22.21) ...
[   58.994118][ T2071]  __inet_stream_connect (net/ipv4/af_inet.c:679)
[   58.998769][  T427]
[   59.003583][ T2071]  inet_stream_connect (net/ipv4/af_inet.c:751)
[   59.008877][  T427] Setting up dropwatch (1.5.4-4) ...
[   59.012874][ T2071]  __sys_connect (include/linux/file.h:62 (discriminator 1) include/linux/file.h:83 (discriminator 1) net/socket.c:2098 (discriminator 1))
[   59.015120][  T427]
[   59.019936][ T2071]  ? __pfx___sys_connect (net/socket.c:2096)
[   59.025375][  T427] Setting up ebtables (2.0.11-6) ...
[   59.031064][ T2071]  ? _copy_to_user (arch/x86/include/asm/uaccess_64.h:126 arch/x86/include/asm/uaccess_64.h:147 include/linux/uaccess.h:206 lib/usercopy.c:26)
[   59.036408][  T427]
[   59.038621][ T2071]  ? __x64_sys_rt_sigaction (kernel/signal.c:4646 (discriminator 1) kernel/signal.c:4627 (discriminator 1) kernel/signal.c:4627 (discriminator 1))
[   59.045289][  T427] update-alternatives: using /usr/sbin/ebtables-legacy to provide /usr/sbin/ebtables (ebtables) in auto mode
[   59.050243][ T2071]  ? __pfx___x64_sys_rt_sigaction (kernel/signal.c:4627)
[   59.054368][  T427]
[   59.056585][ T2071]  __x64_sys_connect (net/socket.c:2111)
[   59.061751][  T427] Setting up lib32gcc-s1 (14.2.0-19) ...
[   59.066293][ T2071]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
[   59.066299][ T2071]  ? lock_acquire (include/linux/preempt.h:469 (discriminator 2) include/trace/events/lock.h:24 (discriminator 2) include/trace/events/lock.h:24 (discriminator 2) kernel/locking/lockdep.c:5831 (discriminator 2))
[   59.071388][  T427]
[   59.075940][ T2071]  ? __might_fault (mm/memory.c:7177 (discriminator 1))
[   59.078713][  T427] Setting up libx32gcc-s1 (14.2.0-19) ...
[   59.083070][ T2071]  ? find_held_lock (kernel/locking/lockdep.c:5350 (discriminator 1))
[   59.089460][  T427]
[   59.094354][ T2071]  ? __might_fault (mm/memory.c:7177 (discriminator 1))
[   59.097161][  T427] Setting up lib32atomic1 (14.2.0-19) ...
[   59.101827][ T2071]  ? __might_fault (mm/memory.c:7177 (discriminator 1))


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260209/202602091222.231689fb-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


