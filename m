Return-Path: <netdev+bounces-239158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2961BC64AE7
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 15:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 6AE5824073
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 14:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BBA330B02;
	Mon, 17 Nov 2025 14:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aFyX5Rpw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B0B28031C;
	Mon, 17 Nov 2025 14:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763390587; cv=fail; b=a87LVqz2HTUNyel0MjBMjeuWHI1KSOaqzkz/n8Ok2Kaj8/QQ/sU/8jbpZ37oYE9s5x8I9J6KjENLWG0SLOmOW0drbdRnZWGHfoCbg15+JXGvittMeHj/269g0mlkrs7axtqmYnbTgaj3UBvh7IRE3bpsRglKlJDYlL3SVxGI/Vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763390587; c=relaxed/simple;
	bh=SGB3zeehwkZdRk1Bw+T16bLBd0euK6NQYfFeddhW5g4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gsLwRcAtYakzhn4ELaY96tcsZ4VTJMshYWsy5p9ClhCGs8S3oBSG3AKkcTW15wSoxgPF7O/Xn1JtAIu/ODXJ7ngByj6YzAWEmu+6HbJPf82Y6lCxb6JGxl/t0iHHkYezh4hSHB4dlmq7nEJNSGXZv5ETXUUaPuMvRC9eKAVpfzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aFyX5Rpw; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763390585; x=1794926585;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SGB3zeehwkZdRk1Bw+T16bLBd0euK6NQYfFeddhW5g4=;
  b=aFyX5RpwCrIpOvorbVXXIBZIjWsrV1XpvOVTe9nnCwjU0+8XS3Y2UbS/
   fCMbPVHI92DATOeBkWe34Q5gasJlYstb/yJN0f2aX5IygMqbQLyTU17dm
   WnfxsapQL7vHYrVIbHOhK0XYxIUc1vllcaa9ER6GQNvrecGUvmRG+eu/g
   zWvkmMunUibXzjtq4Wef7kpG2uMnyQMz45Fp2sZaGKwrJ+qrqZWVTA1i7
   hQT+gIvm1EgVzOihciamOs945q3Aimsiz7C99ZPa6CdRqYPvCy6+fV5mF
   lUTg79lnX5hEVcWWPA2IkuWpNWC0O7EokK7ooFf6KeNP1ThzD1xJdGM4m
   w==;
X-CSE-ConnectionGUID: R7Z2JzYHQGu091rElQGCFg==
X-CSE-MsgGUID: 3HI5tbSQRFS6mtE3mTgj8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="88038550"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="88038550"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 06:43:04 -0800
X-CSE-ConnectionGUID: yAYxNGbnQvGP9auqbkaAsA==
X-CSE-MsgGUID: rg/uhR1CSUeeZYmhE3riQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="221116264"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 06:43:03 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 06:43:03 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 17 Nov 2025 06:43:03 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.5) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 06:43:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fe3iZ9uhWOJAvbEMpHdWUvdrDnyKhb/BCuDZG1nCacz2n6bAHuHLcjobcPQj0usRTaFfYf4Tw5gqDFD37RTXKhm+vQbTrLByAg8ZdODV3hWqpjH08b1GzgF0/+cTurf5CoTlzdOi3+1OTLg4vFGYo1KwNVAYBA/koBzYErj4ZTRsrYoYyoU2teEElHbz7dtZzf/iIs0Z30HH8j/QvciMGXCbfJ4SiDtpLSanMyiqxhjTimEyZdUUksmkOc9fsEDQAMui+xa24zHJuDfNmenubsGgAc7n4JVbRDWp8lSXNYmC88qmA1RWdgfG6UC91BmiEBZMdxYKiUFfqeh65o4KYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FD3lyRgm94N+/QkJlKXA03KT93ZGy6Q/yUXRkW11XUE=;
 b=OUVuEM/wt7ZJatntVZtwO3IPvO7fngghkHg3cJrL3B6WqeNiL7l9CTO5wod3YlBkEztuPh4Yf20yNWOAHS5b1hCYr8oC1VvkyglUdMzwXhK5sP7QitYAGSZf8FPHXuA+RUjjDNzq507KF7CqyuoDxH1KG+xWar6WNL96/v3g0SLOCITI1lRCaU2BwGSyfr0opaiNr3p0nSxPFI7VYo3iWRVcLXhL7O77Bsei+O72SshG1G7qtOOirq9E3wDHv4btLFs388yIdi26MuYVakWZOxfgJsWeKOKrQvWWJeY8rJVOubhTtbRBFXOWtirm95WB4OgdDSj/hdZEnbBPFjdQGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by BL1PR11MB5255.namprd11.prod.outlook.com (2603:10b6:208:31a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Mon, 17 Nov
 2025 14:43:01 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%5]) with mapi id 15.20.9298.012; Mon, 17 Nov 2025
 14:43:01 +0000
Date: Mon, 17 Nov 2025 15:42:49 +0100
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, "Singhai, Anjali" <anjali.singhai@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, "Fijalkowski,
 Maciej" <maciej.fijalkowski@intel.com>, "Tantilov, Emil S"
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
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v5 13/15] ixd: add reset
 checks and initialize the mailbox
Message-ID: <aRs0aeCUYLxPbwTd@soc-5CG4396X81.clients.intel.com>
References: <20251117134912.18566-1-larysa.zaremba@intel.com>
 <20251117134912.18566-14-larysa.zaremba@intel.com>
 <DS4PPF7551E65522C74552DC2ADB1887607E5C9A@DS4PPF7551E6552.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DS4PPF7551E65522C74552DC2ADB1887607E5C9A@DS4PPF7551E6552.namprd11.prod.outlook.com>
X-ClientProxiedBy: BE1P281CA0463.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7f::7) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|BL1PR11MB5255:EE_
X-MS-Office365-Filtering-Correlation-Id: 43d5bf7e-0237-4a64-6b8b-08de25e79b73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/fz9Til3I4xeJTnqjsa/Q1qOL+kXs/vBYy8Pq1+J8EpgbGVA5mxMYXZcTyX7?=
 =?us-ascii?Q?JCtsSGUrr0B/rrJq20J5LkYTwrt4R93fGk49MkT8uvboEuzfA5XNKqZwDfeh?=
 =?us-ascii?Q?mWb/eUfzHK87F4mk25PpgJB2ZOqVy3anZyxNtyf/D7j1Gi6fVLk73e6QWjBh?=
 =?us-ascii?Q?N2RRBKjF1mZXEnSugJtDrsSecThz3E2efm3hzQafI21WV4yc0Hj4gKCMZngh?=
 =?us-ascii?Q?ZoWqoLgtzJsbIC4WVA2Ino4PgNeZR28b4P8dsIGt2+S8Dqi7AvAv4ctL6feS?=
 =?us-ascii?Q?TAm6K/GPB1v+CSs28n4aUuGC5h2lfIDhrh84649NQCjl6ttL/YmrveS9ibEs?=
 =?us-ascii?Q?gAV7uS5rzr/frtJp1RhTvH2a4/YucaH9dx6CO2obStzoz65ut7aAjFW9oXb8?=
 =?us-ascii?Q?a+X49FGfCQDvzdXWyq1e4CajEoMj12r/igzuSZPbP4yA05CKrVXwX+lurITn?=
 =?us-ascii?Q?n5SFBHZO7ZrCAZzaAH8PUjq9oLSYSI2aOpmeMhjefOKYQOpIaBYwvK210EoP?=
 =?us-ascii?Q?54olK3xuLLFG6LTOwnMYw26ScT+sPcIMVrV4215UfnwQ8bSU52FUc5FqQZzt?=
 =?us-ascii?Q?Fmn5/cGrAbYDyUkhFTWuZ+QHZsPRhvEIW9hUOSCwjpKClQJfyu/RyoKgajjN?=
 =?us-ascii?Q?mfdxdNsFgOQ9KQRVYndcunC5skRi3VHIA57VE4LF/e9KwEpnGOJXuhTWli5O?=
 =?us-ascii?Q?cq9nD8Lk5KBkpfeT6aj9tJKGeq9w5dfT3EFEMH0VPe0K2fFzUTrQT8Vd7gs5?=
 =?us-ascii?Q?UXfvKYRGBArMgSlho8MpALuQa1TG+/EW9fKLDLIZSSprp+ic1rYWY3K0olTw?=
 =?us-ascii?Q?gI42C7G0fWSb2rmk/+dcYl5A+CRendabtM15osPqmsErY9l35XkeFj9CNX1W?=
 =?us-ascii?Q?jbgkhh8hOVQOpKJflClmkLGcbWfTEGNIut1S0fIxUDm9a6T+xBUvINu7EvlS?=
 =?us-ascii?Q?5lYoh0ms/A0l+WcIfQvQZzpogn7xK+3yPlr8xMY4BZa0eX75/mkZLJ2Op0xy?=
 =?us-ascii?Q?SzWc3oRJEyGk9TXExhlQUEollUFTqmUPL8CwqIC5nK25L9ZkT11Sg5UU23CN?=
 =?us-ascii?Q?R5OqlyM0/UuGDDTnpR6TeqBszz75MmXWPWV964SyLTfMgYCT4u3i8m5wjE6B?=
 =?us-ascii?Q?6mgc+HnFWZTqEo3zZRA9VjJ0jhlGV668FIrEcilowFPiL/iMTwtKje5umguE?=
 =?us-ascii?Q?68UM5iWlD8lEf4mVsl8GT3OIffYrwcgpwKBz4Wt/+CfSA7DehiBEwuzFmXpD?=
 =?us-ascii?Q?//Qnl7hdhhmZh97f64uirvk6GWiK7HD/HxLpI9Y0nqiqiFhkAg1Smj+rLg/l?=
 =?us-ascii?Q?sGD6XhNoCSdVyrbIizhLbIqJ0KA5oORmnHvj0QhAgERzHhujJ8Bm8h1duWVf?=
 =?us-ascii?Q?hf7oLKuY8uG4R8+kk+rAumWw/30SpI6zc8VTpNu18FOqc6RwtyHIyTVcWB/Y?=
 =?us-ascii?Q?8exXgTU8+eUN41ZloRExeX9i0VvBj5T7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?usQcie25eiC7BdQvUgBF+5uqP7roxF9qAQIp2c+LLm8xO638qoqoWVvYYu0C?=
 =?us-ascii?Q?trS7h3tPLpjYOYGYm98eByyXmHbH6bLA+xTmKfWi7BrzhrOfr8z8LUYlK/Aw?=
 =?us-ascii?Q?fRvkasBBiAPoNnuTed08uMDRRtMmYrcwCOxEsKfqagsY/nzcjQRfQ/yaFAuf?=
 =?us-ascii?Q?cDzLE8sRUJkN50b9sGm6ISwKNdWnSRWJI/AzRZNvpovmSlDmF1sqFuYab2Do?=
 =?us-ascii?Q?IZ6OBkDEY8scsuPVxjFEgyzk6G1b1Uqa2RUQI9TKkORq2lir46G/Z+sywxEh?=
 =?us-ascii?Q?gnOAeGLa30TLgBaHF2VlCh4Q/vW0NIw9P1MTrT+Aq/ukaSJv+Z4fAcWT3uJ0?=
 =?us-ascii?Q?DKBwMjEu/CHQ51w5blsc2yPYJvg+dx840/miWaDWfVLcfmOjOCsN2fWYabOP?=
 =?us-ascii?Q?8H8AIxPXQTwQMwf80CBd1k6C0e9cwwXyjPHVFnEhV3fVq23R9ELr/DHq8P/4?=
 =?us-ascii?Q?/mE2lcc8LoRHyAW6ekc/CQR6pa07dJOozjNOnl8/b73xjfTGpTPJ8OL8AhO6?=
 =?us-ascii?Q?TG0oz8Sk034VNolBy3WdMFAMBX/9h+HLjVDkY55vHYYfdZo8YR/atq6GhnSH?=
 =?us-ascii?Q?e1XO45lppLUYQ/VdDpOudg9F8D8mtnorUcx36NSh6wtVao8kSbuB6/N5w2an?=
 =?us-ascii?Q?yV49l+J4PdJ3bjsY+Hlj0COs+cA/RmQDCXrOzs4+L41xv1fkA7Lg2EIgIVe2?=
 =?us-ascii?Q?O+J7OPXg3zz78wwg3sawKm3WERR7YP0lCHlsRLW9lrkCo/4Q0eqDHE0sbnsc?=
 =?us-ascii?Q?kKfa8AfM3r0AMJdvewUqUg/sEohbSHg6pWWLrcSFNqWwlU6fbiMAHrOarQRX?=
 =?us-ascii?Q?grg6m6RfuQcL+RhhzYFkAk53L0iPGrWAs/lsIbt/ejiWR1mPvwJNCKDsEVqB?=
 =?us-ascii?Q?vyUOlMTDGGP4BWYAFLfwTXSnCZKUQatVdNAAtbfssMGAsY1vs3PCHwnuheQB?=
 =?us-ascii?Q?lA3RJktYMz1Xzo32eZF8+jRvpn3rbUma0psz+75SYUpVS7mv9U3T8WcpGWSW?=
 =?us-ascii?Q?nU2Os2F49i+K/fSQTsIB0Zz5yuuLGvEvvLLP8eYAtlolktrx40h//GN5RYv+?=
 =?us-ascii?Q?RYI7wPWENtVVI9IO1TDeQopHujBZKSgNdaK/7rxFtgvs+XYrqSci6F6HhYPM?=
 =?us-ascii?Q?q1WkaMhNbZDpkT94zc1q0yDtUAZ4+j0FE2yf5vS11s0ZfUYszAExq/AhTH10?=
 =?us-ascii?Q?lHekGEhxj/ES72EiOWte7sal9tgfHNjcLSgtuzkrKedmtCydFc1Al0fdeOln?=
 =?us-ascii?Q?GuwW9/uGlh+WnU7qrNdo6/kybjryFTRcofCXG7sph6p4YcuRBBhl+HL/NYYG?=
 =?us-ascii?Q?bZNc7PWacThWxdl0iRCRYbNO4oXRiLBUwpHR9m+uqe1LTmk8/fflON0o6C8N?=
 =?us-ascii?Q?ubnXzsETdDgHcE6zzuButw9+AJJo+tIKATl4HtoMRG7WNKVAlU4E2rF7TlcO?=
 =?us-ascii?Q?eIEVJAc4Z1Gk/PTIFTlCJoThiHpYkdtMBF9aSMhnpUNb7apKfextEKWhZLFH?=
 =?us-ascii?Q?v2jyJXg9wGUmyLFW6ydYHrUZTI8dUl8ONRo+weAT6FCx9FjEKa8aW5pxPQTR?=
 =?us-ascii?Q?vT9gIVbj/+uCxgjkd8zXCe003sOFmN+vsQzjtM7IxdONjnXvZAj+vnk5jKYv?=
 =?us-ascii?Q?+kgDR4ER37Uw6iCchQBK/rbn6dF9C6ErsyGYjY/T31jgC0lQp2C0mb4FgG43?=
 =?us-ascii?Q?kWDsrA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d5bf7e-0237-4a64-6b8b-08de25e79b73
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 14:43:01.1609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lNkdnCUD/Zkypi8dWPLqQoO9yz52mNBhOZ1L5A2RAquGg/9aIZYjBzLoG6mKaDoGWXUbpO+i66h0Ajwz/EfebjhbKW2Ay490CrCo0M7zCNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5255
X-OriginatorOrg: intel.com

On Mon, Nov 17, 2025 at 03:21:06PM +0100, Loktionov, Aleksandr wrote:
> 
> 
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Larysa Zaremba
> > Sent: Monday, November 17, 2025 2:49 PM
> > To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> > <anthony.l.nguyen@intel.com>
> > Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Samudrala,
> > Sridhar <sridhar.samudrala@intel.com>; Singhai, Anjali
> > <anjali.singhai@intel.com>; Michal Swiatkowski
> > <michal.swiatkowski@linux.intel.com>; Zaremba, Larysa
> > <larysa.zaremba@intel.com>; Fijalkowski, Maciej
> > <maciej.fijalkowski@intel.com>; Tantilov, Emil S
> > <emil.s.tantilov@intel.com>; Chittim, Madhu <madhu.chittim@intel.com>;
> > Hay, Joshua A <joshua.a.hay@intel.com>; Keller, Jacob E
> > <jacob.e.keller@intel.com>; Shanmugam, Jayaprakash
> > <jayaprakash.shanmugam@intel.com>; Wochtman, Natalia
> > <natalia.wochtman@intel.com>; Jiri Pirko <jiri@resnulli.us>; David S.
> > Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>;
> > Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> > Simon Horman <horms@kernel.org>; Jonathan Corbet <corbet@lwn.net>;
> > Richard Cochran <richardcochran@gmail.com>; Kitszel, Przemyslaw
> > <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> > netdev@vger.kernel.org; linux-doc@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: [Intel-wired-lan] [PATCH iwl-next v5 13/15] ixd: add reset
> > checks and initialize the mailbox
> > 
> > At the end of the probe, trigger hard reset, initialize and schedule
> > the after-reset task. If the reset is complete in a pre-determined
> > time, initialize the default mailbox, through which other resources
> > will be negotiated.
> > 
> > Co-developed-by: Amritha Nambiar <amritha.nambiar@intel.com>
> > Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> > Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ixd/Kconfig        |   1 +
> >  drivers/net/ethernet/intel/ixd/Makefile       |   2 +
> >  drivers/net/ethernet/intel/ixd/ixd.h          |  28 +++-
> >  drivers/net/ethernet/intel/ixd/ixd_dev.c      |  89 +++++++++++
> >  drivers/net/ethernet/intel/ixd/ixd_lan_regs.h |  40 +++++
> >  drivers/net/ethernet/intel/ixd/ixd_lib.c      | 143
> > ++++++++++++++++++
> >  drivers/net/ethernet/intel/ixd/ixd_main.c     |  32 +++-
> >  7 files changed, 326 insertions(+), 9 deletions(-)  create mode
> > 100644 drivers/net/ethernet/intel/ixd/ixd_dev.c
> >  create mode 100644 drivers/net/ethernet/intel/ixd/ixd_lib.c
> > 
> > diff --git a/drivers/net/ethernet/intel/ixd/Kconfig
> > b/drivers/net/ethernet/intel/ixd/Kconfig
> > index f5594efe292c..24510c50070e 100644
> > --- a/drivers/net/ethernet/intel/ixd/Kconfig
> > +++ b/drivers/net/ethernet/intel/ixd/Kconfig
> > @@ -5,6 +5,7 @@ config IXD
> >  	tristate "Intel(R) Control Plane Function Support"
> >  	depends on PCI_MSI
> >  	select LIBETH
> > +	select LIBIE_CP
> >  	select LIBIE_PCI
> >  	help
> >  	  This driver supports Intel(R) Control Plane PCI Function diff
> 
> ...
> 
> > +/**
> > + * ixd_check_reset_complete - Check if the PFR reset is completed
> > + * @adapter: CPF being reset
> > + *
> > + * Return: %true if the register read indicates reset has been
> > finished,
> > + *	   %false otherwise
> > + */
> > +bool ixd_check_reset_complete(struct ixd_adapter *adapter) {
> > +	u32 reg_val, reset_status;
> > +	void __iomem *addr;
> > +
> > +	addr = libie_pci_get_mmio_addr(&adapter->cp_ctx.mmio_info,
> > +				       ixd_reset_reg.rstat);
> > +	reg_val = readl(addr);
> > +	reset_status = reg_val & ixd_reset_reg.rstat_m;
> > +
> > +	/* 0xFFFFFFFF might be read if the other side hasn't cleared
> > +	 * the register for us yet.
> > +	 */
> > +	if (reg_val != 0xFFFFFFFF &&
> > +	    reset_status == ixd_reset_reg.rstat_ok_v)
> Magic number, I think 0xFFFFFFFF should be ~0U per kernel style.

I believe ~0U depends on the int size, but GENMASK() could work.

> 
> > +		return true;
> > +
> > +	return false;
> > +}
> 
> ...
> 
> > --
> > 2.47.0
> 

