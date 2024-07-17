Return-Path: <netdev+bounces-111914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E918934172
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 19:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0014B1F213CD
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 17:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6601822F1;
	Wed, 17 Jul 2024 17:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UBh9GBep"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859C11822CA;
	Wed, 17 Jul 2024 17:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721237101; cv=fail; b=GnTO/DbAFdtkw7QQCaqxmvgiroR+Kc8WVI3VcgusdNTqdvBL0dc/5kQLLHxczwPzie/3y7qEvxWXoR/ht3ucXZLq32Rc+gEUFZvUEmsCRJWT/l3Be23qNF4y82kvCisq8bo5SHvPAoqww7nahrKqntFjz4roGReLeBIFQ4/Ho+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721237101; c=relaxed/simple;
	bh=qcc+7//EPAW0NROsu9WcUkDvmdpC8yVhVxqTgFKOn1s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tu0Hc6fD4KFqa+ZBhYcgf90jAJMZHISRuektwOdkl1H0k6tEu9lf6fZ4zy5IKXX/tDoGIwkyz/391joqqtXxOYZ0bfmkT25B0iqMgeaGyE+lxwDpdxanVEqz/gKaMdEiVAaCSwFiTWWkiuBGPSuBBhO1sLsKQm0sk/JUw493W3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UBh9GBep; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721237100; x=1752773100;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qcc+7//EPAW0NROsu9WcUkDvmdpC8yVhVxqTgFKOn1s=;
  b=UBh9GBepNs1W4bHO/CykQCDlXqNaf7z2Kj0jtkFL+jtNEotPkeca7vK9
   bMNHto7FwClBRrM0FtgegHR/wbFgTGtCcCCL/nbRh2vIu2BTdvyEfA1aY
   SCm+/7VSvmMdxRZ+MCQ/CUQqDn74YuZ5e8JOru6LSwZ3RJf38aVmXUEP5
   nbhfa8AD8qe+gOcZOiGUlxYHWZtbUov698IBD1cJy2eYeN/AhDe8koMl/
   zAvcdQ9E9NJTtv7HOHm6lWKFV8dCXxntxRiUCZHhqGWHOcjdTQO48NEVH
   LtyG4xQBtIXXp1XXtNANzHBxkEZsLgXM9TkSp+s9oh+nOj4NoXyQEitEw
   Q==;
X-CSE-ConnectionGUID: R29AnZSiT/+YBDp+VJRI2w==
X-CSE-MsgGUID: FpUw3P4ZQKi4H/6AZcHEPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="29909064"
X-IronPort-AV: E=Sophos;i="6.09,215,1716274800"; 
   d="scan'208";a="29909064"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 10:24:59 -0700
X-CSE-ConnectionGUID: idtkoK/2SmWItzyzMWBREQ==
X-CSE-MsgGUID: 6oGWgNweSk+IvYkhpS3U7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,215,1716274800"; 
   d="scan'208";a="73704190"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jul 2024 10:24:58 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 17 Jul 2024 10:24:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 17 Jul 2024 10:24:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 17 Jul 2024 10:24:57 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 17 Jul 2024 10:24:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MRlumxTzRfQh1PCiawF8tMRp3KUW2dPdUhHQqpH4DQvSmoIavdyuqOBFuAn0ckxdcjdFMtgA0V8w2JCc9ljF5GIANI9R6E4ay0arxkbCj1/KUCoPnPoqIDzw42hOF4jghAqwMQzG+wRXhappxYJz+ILKnlW3yjfqwYtsubWDaF0822eM0X6RmOGZFhLbpsHrtuv1MHHJvwZST9SyVxLECP+0xYqi5Y1wHYeCZxz2tLKccWWGMMLefK3rk6nayOhfrICAZcPV1kM43Q4nbCseD4e7LudnYVGYAY+CRp/dCgeDL5kT4UQ7gpXKWa/QRnujUwA6gJfRXFoy2orNs2z1aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuDvwIpejEkwTXg4CXrPwp400jFse9oPNezPAwrebQc=;
 b=TlWmAFjpBFStdWSDdlEOfqevzRSF7StgM1qEOgLeI+zWj8OSY2e5/+opJ3H/QD7lKapoRBJTW0Df+1qTLk1CmaB18Eu3x78UnMLospco69YbjC4C7yEgeoS+HXnry3tUNjOStHYXBIRO8311yt1ByAuC+TKJp6ucu9U11dU2FXDfm8BKYDdMDv4+RHAvTQfcYYwl7Vz2Twk3EarZOUFCC4flT0ZquWEfgpVeree1oS2fEzQXUnvtd4+viZIJl477XUWNl+KgFe8GKYK2lum0XgiRbi3KkGmBxUd9k8jVw59tDdVY1cKXkySd1/7WeDOFmKGGzGyeLEO2QKvNgQ8+bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ2PR11MB8537.namprd11.prod.outlook.com (2603:10b6:a03:56f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 17:24:55 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 17:24:55 +0000
Message-ID: <b28b6345-aaf0-48c0-a80c-390d8e583f6a@intel.com>
Date: Wed, 17 Jul 2024 10:24:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 11/14] net: ptp: Move ptp_clock_index() to
 builtin symbol
To: Kory Maincent <kory.maincent@bootlin.com>, Florian Fainelli
	<florian.fainelli@broadcom.com>, Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, "Radu Pirea"
	<radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Horatiu
 Vultur <horatiu.vultur@microchip.com>, <UNGLinuxDriver@microchip.com>, Simon
 Horman <horms@kernel.org>, "Vladimir Oltean" <vladimir.oltean@nxp.com>,
	<donald.hunter@gmail.com>, <danieller@nvidia.com>, <ecree.xilinx@gmail.com>
CC: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Willem de Bruijn <willemb@google.com>, Shannon Nelson
	<shannon.nelson@amd.com>, Alexandra Winter <wintera@linux.ibm.com>
References: <20240709-feature_ptp_netnext-v17-0-b5317f50df2a@bootlin.com>
 <20240709-feature_ptp_netnext-v17-11-b5317f50df2a@bootlin.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240709-feature_ptp_netnext-v17-11-b5317f50df2a@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0058.namprd08.prod.outlook.com
 (2603:10b6:a03:117::35) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ2PR11MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b23bab2-fc1c-42f7-2f73-08dca6855fd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dmF4RHpSQkFTTmxFOXp6OFBmbXZGTXd2Z2R6eE9CUHBkT2hzUjI3YlpNd1Rk?=
 =?utf-8?B?M1ViZnR0dDFmOTFTbTRBMEp0azhLcC9NK0xGZWlLOTM1dGZLUlZ3aS9mQVJ5?=
 =?utf-8?B?eHE3NElHQ2t1c3ZrYzlLR1Y5SWlsOU5JMGZpTTNzV21hVFFnVCtWdTArS3Fx?=
 =?utf-8?B?dmxnbDRIUmlZZmpGSUF6UTJDcHZ3Y2NpellkQUxIZjFycG5XRzhueFVzRlc3?=
 =?utf-8?B?WVIxYjRJc2ptZ0JBK1hEbWRiTVpoR2tFV3E5T0FMM1Z6RzV0bnE5VUc5UStl?=
 =?utf-8?B?M1FtdVpnZmR2enZzaTB6aWQrdEJmRktjQXBhMnZCMVdMOHBmNHh5Wlg0RVo1?=
 =?utf-8?B?YVlwcEJSaXgwVTFMNlZtWHRIZW54ZFJqVEE3aVpGb0JWR2VmcEtlNkd4dTFC?=
 =?utf-8?B?YVFMdUtNQTV5cTVKeG83RHRwcWtDbWRObldTbFpZNGdodG10Vjl0NWw5cXl0?=
 =?utf-8?B?aVFxVWYvWWF1ZGdBZ0tOYkNxK0hPc0lITFJSeFBDV2IxN1JXbGppcVQzWkxM?=
 =?utf-8?B?M21PZzZqNnNYdVdCNGNUS3FqRGZ3Rk9FaC9XUk5wdmQySFdnYTVhTW4zQmVE?=
 =?utf-8?B?NXdaRVhyV2ErTUdRNWVHQmJNQk5tWUt2aEZQTk9kZlRsVm9sMk9wVTJLV2NM?=
 =?utf-8?B?dW5wTVlJTjY5cm1GbDg2YkVGVzFTeUZmdjFENFFJZi94d0dOcmw5RktQT1F3?=
 =?utf-8?B?WFJlYlZkdS9xbm44YlZwT3dCdTA4bXBPdk83cHlvcmtxa1plUXo4eWJiZzNt?=
 =?utf-8?B?N1NwdVppS3NORTBJbWhJZVJ6ZDQ4T3FrRFZ6S2xzNTE3VEN6cnY1Vnl1VGZa?=
 =?utf-8?B?eFo2WTBCTzBTV2paN08vLzBLZUtJUm9KL0VTeDBzaExBZHVMZU9udnpGazB6?=
 =?utf-8?B?NkZ2WFJ0QjBpdTJxS3pvc2JwRmFzTEQ2clFIL2dhV0VScjBnbzBhUVo4aXdX?=
 =?utf-8?B?V0VSeHo3djFKVkZxMnc2SU92LytPZnVGTHJTaWVKZWY3dm82UHdlT294NHMv?=
 =?utf-8?B?T1BSTGc3cS9OdFlaaUh3ejRBbU00RG5FdmM1aEpZeTBoY3dLeTJZTmp5UWFW?=
 =?utf-8?B?b0FKR3ZFcDhTOFBFeVdTbXorMTZlbVNxcTlOQk1TVjRNaUdZZHJiR3ViZmtN?=
 =?utf-8?B?Wlc1eHNsU3A4UlY4bmlNWDNENkJud21YbEVscTZ5YjhBZkNuRmJtcEUxcXJ1?=
 =?utf-8?B?NVhGS0hFdVk1R1dzL241OVNITU1ySFE3SXZyNWRqMVVCSms3eVdjOGRHSGt2?=
 =?utf-8?B?TmdDYVA0YjB6UURtOHdhZWZSTlVXUHdCZmRQSVJLc1BqbFRSdm02UDRDM1FK?=
 =?utf-8?B?L29BQk9jQTZLTHdUT01rNU9SQU1RWmFiZU12RmxvTi9iRmFHSzVoKy95TUVy?=
 =?utf-8?B?YnhMY3IzZ0l4Nk0xQXlRZVhvWUlZNTI0OXlPMkNLVk1DRzdRWlBVU25tRXhD?=
 =?utf-8?B?UG1Ca0VYTmhDVHRlMmJJd2xuTXdXVitnWlkxNEd6NmhONjZjVldpbEE0TEtC?=
 =?utf-8?B?c1I0bVdVamZ1WUU2UlBGVDBKdWxmRjZraERTa09rTTN4WjVaTXBOcWRTV29W?=
 =?utf-8?B?VGl3a0VockpnWUpmMlV1QTVGeFNTRmFZR2pHZjFxNEdiU3ZkTDUyWUdTZzBK?=
 =?utf-8?B?cEsrOTRZZmUvazFBcGgxenZNQ00wSXhkcENMa1EvUVVIRzRPT0xXcTJEcXl6?=
 =?utf-8?B?dC9BUlk3N0FYbllHamIyeEh2ekd4UitVa3I1SlpGbUJ2QXpMMnBFUmxDWnV4?=
 =?utf-8?B?TVV4T2l3QVZ3bW9NVHJrekM3N1B5bVBZK1JJRVU0VVhxNndJQWpZR0tzS0Nv?=
 =?utf-8?B?ZVFWVUV1UGVBSi95bTRVWjZ0THltaXFiT0tCOTBtQ1pYaGhPaXF6dVVRbEZF?=
 =?utf-8?Q?I5YkJcdDQoKE+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1Q4SWYwbnBYbVlpVGpmQnI5YzlYL3Yzek1BNllYR2xweGFyVGRXN3J6djVa?=
 =?utf-8?B?RHJkTis1dFpUbWJPREFHczRqSzVjUWRXUXRkdlluNkNJaFVkSXgxTjd6cytt?=
 =?utf-8?B?R3lHckVMQiszTnY4cE83VmZocTRQbmZBcUFRNjAzNDROSkFydXJTWE5JUnoz?=
 =?utf-8?B?NlQzUTNWR1FUZDd2emR6NVN5QnpjcWI5MSsrMXZsMFBlZitUQ2NDU1FLa3oy?=
 =?utf-8?B?bklTbUNqalFhdVcxZllMODdTYzZPLzdMTXJkWnJmb2dKU3g2UFBLOEdjQzJ6?=
 =?utf-8?B?ODViN1VmWUNZOHExY2MvMTJpaXUxK2FGeGhYaFJDMzVBNFZIMnhPVUdQdUpI?=
 =?utf-8?B?QWZxSnc3YlN0ZFJpOEpHUHJSYWlqNEUyWllaVnlXRjV6bFZHM3JZR0FPTlli?=
 =?utf-8?B?eW9zME91eUtEOGRab0RYVEV5RDRzRHFNQU13SEpWL1JUMlNuVXNhUUt1d1hO?=
 =?utf-8?B?bTFkSUw0N2RDT3p0T0xSWERPVmx0ZHdkMVRWZlF4bDBGQWx1RklOaUQvRzF2?=
 =?utf-8?B?TVN6bXpXQklJdU5nTWxiVFhLZzYzZy9vT3p0bWxPOHFNVnJlNlpCRUlMV3da?=
 =?utf-8?B?RnNFSElETU9oaEdwenhDcGpaS1ByZERBMmFUQUVUOGNNZU9pT0ZmWkNudWRh?=
 =?utf-8?B?YWU2eFQyV2hSOXpBTUhQN3hsZEpwNUdOQnFYaWJYTGJzRDdjYjYxdzZIWkp1?=
 =?utf-8?B?Q3I2VGtaU1lDMGhQR0FkckRoaDJ3cWZ3LzlDTWxCZlBKM21XKzFycTNYa0JT?=
 =?utf-8?B?aG1NSUdvcGhYbWxTeUo1dkZTYmNiOXMzdWpTalNZSjBVNVoxa09UUVRLWnB0?=
 =?utf-8?B?d1hwN2VZb2IxL3BWc0p1Ny92ck5KNFR1d25SeWlZcmpkMkhvN3VYNnljNzRY?=
 =?utf-8?B?U0xTZ09Pb255dy9pTW5LV2dueXB2NXBVMzJ1eHllMS9Bd0EySS9WOURrZkoz?=
 =?utf-8?B?aENoVXdBSE05Q0ZiT0FQdWh0MXRKekoxY2NYeVg4UG9IRldCM3ViS0lwK3BO?=
 =?utf-8?B?WUFlL25SVHdEelBLcVpoUXNoV3J3RE4vbGNvaGQ4eTZXM0R3cHVtYU1OM0t1?=
 =?utf-8?B?YzNMUFZNeVRYTloydW9tOHlTVG9NL1VWM29HK2Z6akhodFFhRTJKMXVyS3VB?=
 =?utf-8?B?cWRJNW9jOG1ldnJMSjlUWUZCSW54WWMwVzgzRkJ1cXBLS0FHaVFLVnMzWjlS?=
 =?utf-8?B?bUhhS3pTbkU0dnVUWVZ4ZElJNDYrejZ1ZXpudWpkK2k5NkllbW56NkdYRHNV?=
 =?utf-8?B?RU8wSEMrNm4yZFBOQVZFc1d5dEErZGJBODNDRnF5cEREejd2RkpVSk1UY2NK?=
 =?utf-8?B?U1hLdjhPL3dCRnVYK0ZuSDNVV01ncENmRFQ2RzVGdWJFbFcrYldKeFI5YU5U?=
 =?utf-8?B?d1NJZU9CNUl4SlY5U0xTRjVjK3Nja3BPbGZzb1IxWlR4Qjg1U0FWRVo2NkRO?=
 =?utf-8?B?dGQvcVhJeHdmWThHSnNPVURFTzMxVC9IT2Z5YmUrSWVCbW9vNThJcWdzd1Zh?=
 =?utf-8?B?RlNOOXIvWEo2VUIrbkhjbDJVb3lINjhCRC9UTEFyOHdrS2lnMHprWXRocmdX?=
 =?utf-8?B?bEhTc1gxbTgrc01LTXFUaDVSOWpQWUw2T3RtVGROYzR2czN5Q0tnTnVuZldU?=
 =?utf-8?B?cGU3MWRXdU43UzlkdGY3eXlBY0duUGh4dUpCUkNqS28wc1VkbDBERXRiK0I4?=
 =?utf-8?B?TW9IL1NvUHVBRml0Z1JteXhPblAzZFFmM1M5akNXTnlyQ2ZvYXFoMWpXQXkv?=
 =?utf-8?B?Qm9HTkNzWHdPOE1TaEVGbXAxcENIUHNneFJZM1ZvaEV3UXpJOFdmbHZjb2Np?=
 =?utf-8?B?SHlucGFVN25PclVUSVZhb3FPOGU4UXhJUXVUNUZRQVFjb1d1MDEvZ0w0MkVD?=
 =?utf-8?B?azkrcEJEWnJqN0pVbld4amFyN2VrdngzL1dtYWhnaUMrZ2IxS09kSURYYS9X?=
 =?utf-8?B?VDZ0Yk9EcUlOTkZYMjBkN050TmlpOFhhNXRwYkcwV2R2WkdvTS9nSjJGbllr?=
 =?utf-8?B?S1NPUXlibWNLcHZSTUIvK01xSE05L2dpSHQ5eVRFL2NNdkdkczkvWXNEMkZ2?=
 =?utf-8?B?NklXMkYxQ01IZnN1emlUcE5sa1NHY0tpMkFiblNuUkdVd2tpTnlGbk4xRjRN?=
 =?utf-8?B?Z0xnbjg1N1EvOXFBK3FuMWJiUnl2WWJoMlprZUdvbm9ReWpkS3VWVE9wTytN?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b23bab2-fc1c-42f7-2f73-08dca6855fd5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 17:24:54.9543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DdTsV1sPGqC9TGFA/nU4tcUve9vFV87Qb4GYQmsdcMr5XFHEVqdAI30jtwndMSl5ndRH71+8QMGL66yg/vRT4kQ6ENTK63zuyhrLdyZtDs8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8537
X-OriginatorOrg: intel.com



On 7/9/2024 6:53 AM, Kory Maincent wrote:
> Move ptp_clock_index() to builtin symbols to prepare for supporting get
> and set hardware timestamps from ethtool, which is builtin.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Change in v13:
> - New patch
> ---
>  drivers/ptp/ptp_clock.c          | 6 ------
>  drivers/ptp/ptp_clock_consumer.c | 6 ++++++
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> index 593b5c906314..fc4b266abe1d 100644
> --- a/drivers/ptp/ptp_clock.c
> +++ b/drivers/ptp/ptp_clock.c
> @@ -460,12 +460,6 @@ void ptp_clock_event(struct ptp_clock *ptp, struct ptp_clock_event *event)
>  }
>  EXPORT_SYMBOL(ptp_clock_event);
>  
> -int ptp_clock_index(struct ptp_clock *ptp)
> -{
> -	return ptp->index;
> -}
> -EXPORT_SYMBOL(ptp_clock_index);
> -
>  int ptp_find_pin(struct ptp_clock *ptp,
>  		 enum ptp_pin_function func, unsigned int chan)
>  {
> diff --git a/drivers/ptp/ptp_clock_consumer.c b/drivers/ptp/ptp_clock_consumer.c
> index f5fab1c14b47..f521b07da231 100644
> --- a/drivers/ptp/ptp_clock_consumer.c
> +++ b/drivers/ptp/ptp_clock_consumer.c
> @@ -108,3 +108,9 @@ void remove_hwtstamp_provider(struct rcu_head *rcu_head)
>  	kfree(hwtstamp);
>  }
>  EXPORT_SYMBOL(remove_hwtstamp_provider);
> +
> +int ptp_clock_index(struct ptp_clock *ptp)
> +{
> +	return ptp->index;
> +}
> +EXPORT_SYMBOL(ptp_clock_index);
> 

