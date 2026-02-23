Return-Path: <netdev+bounces-260127-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qA8pM/iMnGmdJQQAu9opvQ
	(envelope-from <netdev+bounces-260127-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:23:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD7817AB85
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DBA0301F9A2
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 17:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8779330662;
	Mon, 23 Feb 2026 17:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d0ifYyVk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AE813D638;
	Mon, 23 Feb 2026 17:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771866997; cv=fail; b=ckKuDNZqF9/DaV5eGdznRHzlUzwFSw84kXWxG8xGmupMqrjptkhUPGr3xkEQQT9KTBC+K0DyexRKDjE9RnxabI+mf7RPr2m021HLuWDw2YBdbhc0Hyptf6zAjkgwpQWEC6mLFwkM1KCBoGU+bw7G50/l7Q3VYxI+h8YVSi+qmGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771866997; c=relaxed/simple;
	bh=s0f7lwkBSs/UpWV2HlZtgek3FjTCE+i/Q2Qsd33wMOo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z6RrlbFoFOAeeF/ASlvk3W65PWLi/IHtKEUZ+AwlmTQvmNqIMT6J2ByxBv9LQ3MDP0rn1ZkHcEnVjUXUXb5y07uf1Vk8KO029P6BWLUgnfeEAq4kmasZnagSxvX4IXQRsj1OtzxWIeeeIa8X2hd2cn69wi0wwye091IQWwFTq9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d0ifYyVk; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771866996; x=1803402996;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s0f7lwkBSs/UpWV2HlZtgek3FjTCE+i/Q2Qsd33wMOo=;
  b=d0ifYyVkEmT1JkhylNJQbWCgYRT2FXKPfZPgssAy+quC/bWTQH5nnL+7
   05epSdthbdffvGwN8tUe40N930n3HYuWONHiglxCyv5WI014yr3teXwGH
   xergxT8BeQLUdfjG5+/aIQh2UwDA/jINENXVS1B+IOT8BGB9vymPALrwy
   452Vx7tSYmszRmh8nl0AD+yQuyPWMCw1n5U0YhgcZTqrw9UQZxGSUYlQd
   Q8MOYVu2fievjBySGuil074LASS0FQAOJMWj4W1uWhj1Heskf8wOHPxbj
   EojIrkYLzHxKlByiNi0SLFWEqiVzO2C+QAJ0SXI+vV4z4x1gpP3BOg0aP
   w==;
X-CSE-ConnectionGUID: NoHf+F8rSCWT2pD0xKXJ4g==
X-CSE-MsgGUID: /0wMmM2OS/2tb7roU6lrHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="83492131"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="83492131"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 09:16:36 -0800
X-CSE-ConnectionGUID: g6UHuwv6SjKbx9ORwJNQjA==
X-CSE-MsgGUID: edHcVS6VQnG26KTc50Mb3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="238586819"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 09:16:35 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 09:16:35 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 23 Feb 2026 09:16:35 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.57) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 09:16:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxFzupfIvXOKK+J76JqFgPJHoIYrTmVTvIsJx6tAy0HCDmM6HC0Afhzj13yoAxHAqxDJhY6dvxUxlLtgNCWMszg9nZ8voam+3pPvn3zrup5CiCJYbl15VoUKPL1X7cj5Sg5L3wtGce90PYjCNDgy7kdQxZkhbrNbZ09X+xNjJWEk3c1gcd6lq0dB19WEfIuSPsAAr2a+PXaNWUBARc6n0NMoLwAGgyK8NaNT4vKw+pSkt8PRyOuDAaf2K72tzVx8KNz50ULL053omQbrgPOtCJPaAhdZpdGIcEiio+mEVqpUD0D1r8iMeazEOlT5fYctGWmWSGoeLuiQ4w62QWkVUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0f7lwkBSs/UpWV2HlZtgek3FjTCE+i/Q2Qsd33wMOo=;
 b=k/ZvzY6re2Or3zEbZf7wpxZ3any2hykbiDKHnaaGo1/xCdfIOHPCXNoMD+kRRM3npVz8kPWDHtjr7fM5rqe1I4Y/rBjiQVEAaQULXquKn/PdeDcmSHGBGDHASt3CAp7yWN9TbpcbL6useou2bcdt7o1XDDADk7TmR6rqGbB8uO8PZRCNNkJwldnd0pmLkm2rF9hu8uRFq/X9OjJc6O9RFjs07rxVtiw+vR9Juaco/jxyMSrTLMvcFTcSgEZXpHfYmKQBeDwEGMCp39aQjav3iDh15s8LAYTQu4OPYkqfPNUiqwuBzSuvrCLhP17FsAiPer8z+rVzMXFEgLkCkkzvDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by SA1PR11MB6688.namprd11.prod.outlook.com (2603:10b6:806:25b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 17:16:32 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e%6]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 17:16:32 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, "Singhai, Anjali" <anjali.singhai@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, "Zaremba, Larysa"
	<larysa.zaremba@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "Tantilov, Emil S"
	<emil.s.tantilov@intel.com>, "Chittim, Madhu" <madhu.chittim@intel.com>,
	"Hay, Joshua A" <joshua.a.hay@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Shanmugam, Jayaprakash"
	<jayaprakash.shanmugam@intel.com>, "Wochtman, Natalia"
	<natalia.wochtman@intel.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Richard Cochran
	<richardcochran@gmail.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 07/15] idpf: remove
 'vport_params_reqd' field
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 07/15] idpf: remove
 'vport_params_reqd' field
Thread-Index: AQHcV8kRO/57bWpJ9kWRmWonj8nuE7WRIIJQ
Date: Mon, 23 Feb 2026 17:16:32 +0000
Message-ID: <SJ1PR11MB6297B54EECB0BEE75C6178939B77A@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20251117134912.18566-1-larysa.zaremba@intel.com>
 <20251117134912.18566-8-larysa.zaremba@intel.com>
In-Reply-To: <20251117134912.18566-8-larysa.zaremba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|SA1PR11MB6688:EE_
x-ms-office365-filtering-correlation-id: c34c919c-db92-4b21-62e8-08de72ff4a59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?AlRfmKOkTGTQZged/Jyb7yNydlD7eWbBubHOeMF47noAXcGXRJsK61oxfxcc?=
 =?us-ascii?Q?aHCsz+QVClPTNwW1g0ViD3F6IScH5p5eNg5ZSR6n81yxqqOwZfl1TPMFVKm3?=
 =?us-ascii?Q?GanbpyTWKhC+gWiXTeBWAWtIDhXwlUEaTHWSEj++DqKq/2kPxL9VxZfE+6Y1?=
 =?us-ascii?Q?+FG8irlp5gSFRona6eiV/RIEUCcCwjcTRxcWtDO02PIAXKo5bVIUqknR6/O8?=
 =?us-ascii?Q?ytbkt/4vRVEo8ilJF49+91yypaTLf4cxy0dRA96t3MHq673izkLDSoFBNJbA?=
 =?us-ascii?Q?DlKDva9OzCTWEvqG0sFJZBjlKV1oqteHCh64g92nTRVFqpTGVksCFpZUsgy6?=
 =?us-ascii?Q?srmP/xnuUCxb4+x2hENDowhsknY4JXY5LJ2vFD2fSlISgtd/41qvqonsqPWZ?=
 =?us-ascii?Q?UpeMWLyadma3kzSSxi2HaNv9QSmTJohhw60g0kbwuJY5zY0eUOs7XF9WAlbx?=
 =?us-ascii?Q?QFlkShDivVDpgxTdTO6jerMQR+ynlm/jTOsfJzeKkVxnH48X9sZ3bH05UxLE?=
 =?us-ascii?Q?s7VcNAt+N6NlzCGpIljcE9m2m8WNjbtBR0HS0tdU15lulKBl1kb3siQyNQKF?=
 =?us-ascii?Q?hYx//pdSzgZ7Lv1S2P8f2Ftp2NoGvoXMf5X5gBvLZjusCbcg7ra3k/weG5tA?=
 =?us-ascii?Q?W4phMFQQwby17th8Ku0Q+1zGxyWAJnYGlbEa2bPnqupomJcHTAN6iv63RmGC?=
 =?us-ascii?Q?krZXUcqYk4XyQJJJMG6L1d+NCuIY+lHSDf+zggcb857qEDGFBHEXYQiVx7rw?=
 =?us-ascii?Q?3Mfsn8CTxX92c+CqU2X2qYGkehQL19nTJOsK2QR2IfzFP0rnvdtszdAX2/UL?=
 =?us-ascii?Q?vHgMJCYHQFI2bdDiSiBPajUx+fHq8vj+5qtw2s5ymkYPslm+jLjjn4anIP+i?=
 =?us-ascii?Q?9WsS3NvMW51mBzElNefb/6XQLoccXNOEJBteWiK5P0AiCQCiMNtDUctApatF?=
 =?us-ascii?Q?abtShw55TXxEETjX06L1HZSy/h6P5glA5YLJOSG6E3zWDdCTXxhCbLf2JSf8?=
 =?us-ascii?Q?oL73sbARadMQZPde5P1yNznwaYi6LUCbFy8f0EWemxAUYzhYoevEsJSSGSG0?=
 =?us-ascii?Q?nGqk0uPIsxae5Q2YP//rbjJoaTENsxsi0lCoWR5rG6UFd5wbDYI8tTNMSPFw?=
 =?us-ascii?Q?nFGMaxjwk00BrzQhPLH2ZvVtBtlYduXSQ+wTF8yH9v5X26ASy8aMMuHryPzM?=
 =?us-ascii?Q?b7B5hXI9WFQVheOqvCwoHIuS2OKSyKAipNikvzEW4OOqtE2GW9Aopx1M6H74?=
 =?us-ascii?Q?DcnelOWiLaNuJqggdV1wMmQnDauWbg66UNJXCJ06AFyR+8C3Bc9wpJcNMjZo?=
 =?us-ascii?Q?MWbOp2TyM52si9ZX0Zd6eMaG8u4DxkUcm+O8tl0nsFfZjy3omsi6a5HX6y0k?=
 =?us-ascii?Q?Y/5gD7FbOB4rnFHIxLUAk95PqpMall74IJ7FOQfbEj+tXNtqXpUQ6ElgmvNC?=
 =?us-ascii?Q?LsqtHJgePUD6qXAEwp4bsllICwkn+M7oEOc8tfNcRyMuPvCXq9N9ELRMvTnh?=
 =?us-ascii?Q?+hKnQhe+8O2Hi2MRGUSpw7nLxE2/nNPUqmDlTWqr8A1atmGphFmGVfhGgWLs?=
 =?us-ascii?Q?KX/UcgjX7VJDvvBeEE3fHDQW5AW3W9YTwNhG6IvXycXd6nXNwAYbDkg7cdl5?=
 =?us-ascii?Q?+YT+pLZ7VFdcXTa1cyFonak=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ARZuuIdjQG55d27Beri00wQnlXOe01nB3FC+1bh4psukiRY3R45MJuSRafrH?=
 =?us-ascii?Q?3DMBAisLTc4Gt6mlilqPVv1VbySsRVpbfxwqsCM4sw5pI2Q5LwlsCQcxCzzS?=
 =?us-ascii?Q?tj3Kafzi6juPq/FnjpNJhhZhMZHv5QYjWyYwijr/1GJ/hB7Ilw0iO7IyaqY2?=
 =?us-ascii?Q?BZNlK94Oy37xCHcUXH9SEpZLu4GU8DDw0BIRaGRLWOMIn3WtwkAe9+VXcxmE?=
 =?us-ascii?Q?AVqHbZpy3Nj9DKS+ZXaGt9c40KdZsFQyMlfH0v7T0+tcxRgVNafkeg1qmyyk?=
 =?us-ascii?Q?hI6PlFeDYM4HJfrQUe/MLQxeV+JLv4RYsSEUS/MqS4/3QMmkKk1YrtEhLva3?=
 =?us-ascii?Q?eqyLqzY3wZiTwQIWJhI2q5dsgLX57VLn8+Kmmg9hKJrqSE9karr2tRJfSPfG?=
 =?us-ascii?Q?amD+NojE35V1NZemxcA/b7T52IL2lWArxJBiIEjAu4awnTiVLeAEeZYcf000?=
 =?us-ascii?Q?SqTzdGzxPM4VWYMzbC3nnrtiX87lK6omsbqsbcGVHnI0l7Mj7LRDuK2cZNSb?=
 =?us-ascii?Q?/ErJkDcgtS7/b1+EKg2a3ZnmzO8Het+P7DTE4Nubc82JibMWHZsuCmtv5Cwv?=
 =?us-ascii?Q?Nw524SiQOtQKHYyyV8ti4KbcUK36HCCs20xOUtQlkL+TNMMXnY8nYY6NQs7b?=
 =?us-ascii?Q?+lGBh+3V8wEI0NQErKmsHx/32eymXxSJHEkD+WimhiSMGR3v4sHDFkuD8tGW?=
 =?us-ascii?Q?73qCw9D79A3ix3KemwhApJISX3BxTtzdndmxaLGOc9injyiOX3oJDr1sonFY?=
 =?us-ascii?Q?dbiYD+R/0Mf4uN4SqlEVzDcYVNHG7sBdLeC9DGmV8Jw1PWz3iNJ3z8gF4TPz?=
 =?us-ascii?Q?+fHjjD0k5kmAAOeB3+Rgrb6RJnmLcjj8ovJ3NuMgLhAgd9T297xMtMtvHd62?=
 =?us-ascii?Q?SAyGjii3EfKUSnof59dI3SB+wca8LdtaJ/6R8jOCbEy3zoUFYADfSCbK2HN3?=
 =?us-ascii?Q?tsa51HTX4qYRqXTvoGXBMeWC1HHt5OtIft/LV5gA70TA3SJvaBv0mITMjigR?=
 =?us-ascii?Q?bZGs8AAjSdQv9SOMgT1VcoAWLUkoW9QIAQeSsC8mDhcERVqmxlfdbM3KPJw9?=
 =?us-ascii?Q?6zsTOCRcfX56CSTb4E8hNehTFB5nQWkHGbjODWJ9ARpNlri9cVS9ti23SHOB?=
 =?us-ascii?Q?k4z5D+Ow9fJ9wc6lqegDk6aO4wjS4q2qRg8JskLL61kjov1vsjDf9hw7IGwj?=
 =?us-ascii?Q?94hyeotJY/4qwGCc+RtmL3jaEhwAFWCHcXNbcwWXbeMuEoc6wf621HYS5j+p?=
 =?us-ascii?Q?meIHo2D/JDjehBffyMF3T9D/Nxfcly0p0k16/T4PAsfrlyVAAgpKAw+vfxw4?=
 =?us-ascii?Q?FsKgaVRzm+oqORDfnhm+FhzMdl0IJp1AuYHQBJ+1v4vS4Lse1NdpUDb+dc8x?=
 =?us-ascii?Q?cpy986MhKlhTzG4L1/X6srbrsr7Hahcd8yAZIoliW1O+UYRbuXlYa9cowTL5?=
 =?us-ascii?Q?z1atEswxrrOZsWAS3YYojRcUAqPYEs2yo3FFq5ABLSIa6XW9EicniwwCdlTk?=
 =?us-ascii?Q?QDEi61y9Zu92fPuu+Aa+hJJGbHQe9TK0ufJBgMa4MssxeTHfSzF2fN6375W9?=
 =?us-ascii?Q?IoC7xH5tSbzklBQWDl/BOt4Bzaq1OHEUxjZtQZigiTaHudPWn+DZwS1xrhSW?=
 =?us-ascii?Q?TvqO6S2qHAHxpRv8U3eIF36MSWcBpxLyXBAW2FXNEORUh7wL782PzDv6jidb?=
 =?us-ascii?Q?VBmM0zF8pNcqo+SkuRw2q4MZvBlov5vWo8YOPu/tvo89EoCeCug57LMB4mw/?=
 =?us-ascii?Q?MzWKfOIORA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c34c919c-db92-4b21-62e8-08de72ff4a59
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2026 17:16:32.2351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GrwStR3iGswbkhvRXrEmRsdDDNRtlZ1466Q+POfJ2EpMhfdsKmceTkBndbyX4d14vQ8HR8GWU6dlimfQreye0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6688
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260127-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,gmail.com,lunn.ch,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[samuel.salin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 2CD7817AB85
X-Rspamd-Action: no action

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Larysa Zaremba
> Sent: Monday, November 17, 2025 5:49 AM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>
> Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Samudrala, Sridha=
r
> <sridhar.samudrala@intel.com>; Singhai, Anjali <anjali.singhai@intel.com>=
;
> Michal Swiatkowski <michal.swiatkowski@linux.intel.com>; Zaremba, Larysa
> <larysa.zaremba@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; Tantilov, Emil S <emil.s.tantilov@intel.c=
om>;
> Chittim, Madhu <madhu.chittim@intel.com>; Hay, Joshua A
> <joshua.a.hay@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>;
> Shanmugam, Jayaprakash <jayaprakash.shanmugam@intel.com>;
> Wochtman, Natalia <natalia.wochtman@intel.com>; Jiri Pirko
> <jiri@resnulli.us>; David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Jonathan
> Corbet <corbet@lwn.net>; Richard Cochran <richardcochran@gmail.com>;
> Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; netdev@vger.kernel.org; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v5 07/15] idpf: remove
> 'vport_params_reqd' field
>=20
> From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
>=20
> While sending a create vport message to the device control plane, a creat=
e
> vport virtchnl message is prepared with all the required info to initiali=
ze the
> vport. This info is stored in the adapter struct but never used thereafte=
r. So,
> remove the said field.
>=20
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
> 2.47.0

Tested-by: Samuel Salin <Samuel.salin@intel.com>

