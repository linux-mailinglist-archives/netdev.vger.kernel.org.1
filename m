Return-Path: <netdev+bounces-277312-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AYmKRLH2GlQiAgAu9opvQ
	(envelope-from <netdev+bounces-277312-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 11:46:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FED3D5289
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 11:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EC8E930466AB
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 09:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205F233E35C;
	Fri, 10 Apr 2026 09:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BuoB0nNN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C53B36D4EF;
	Fri, 10 Apr 2026 09:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775813941; cv=fail; b=q6hKFUTk7F6lULmCgtlqKtYSE38HXEEYDuM7A0G/2HthBBRggthtvG1hYIFvAEKqlXRZ9+Uxp7u0gdn15yfV/MMZND0uyxoQneD0jtz214yF6EbxYusPY47pwC0mHBTG0B3j0yXzH9yHDnuYqdrcYLpea+gKggjQp/EaAyvZTEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775813941; c=relaxed/simple;
	bh=VlURzyna38OybJ7Wxw0xLYbvhohcwhwg/fjmU5sMUJk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MkC9eTCl6BCipotj6BMScCweZ3jaoSedFRcC+8ySGFU8bh6sIh92hCQ5yUdYuawrWc8JZQal5ZwKk63hFzDy0Nn2f66eCitW8tXM8mpLPLO9/VrONcWarnoM+zFvBpgDjtwOGmzIwetjyHMiLPi5L4oewP5QAt9krX71vOib0+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BuoB0nNN; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775813939; x=1807349939;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VlURzyna38OybJ7Wxw0xLYbvhohcwhwg/fjmU5sMUJk=;
  b=BuoB0nNNoORuUkeFBM5IS84WrSkQvMxA2tT2L+7EAxYlAj4aSqm7W093
   2OCBdgzuzGcEWYq26tXEuJaRwA3VK13v76gAlHOfdypOWDBn2R6hYpxL9
   52S+FNsPyhGHNgt2b8Nvn4lfxPY96ScU0ySyfaJjP/jXUdNufBTQilbsL
   M0Rz/G9e/KgosxmhD3Ln9l9mQk8d6Fmj3tI36TK3NXUQOH0edIQBZV3hF
   XTQYgFlON8NRON1BjCfa0cjtFc5Dgjk70kYQOUfcKYYsxNEO3OsHhXHK6
   vYyFTZeASiTBGK2t4q2jWIOdSYw1A5CkRF0ApiIX3CcB45mWRzLYENmuG
   A==;
X-CSE-ConnectionGUID: UZDeJ/4XRfWGhLr4K68h9w==
X-CSE-MsgGUID: k0rmZ+7JQwSR4SkXX+O7Vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="80423049"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="80423049"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 02:38:58 -0700
X-CSE-ConnectionGUID: UPGTggXTR9umy58cOop3pQ==
X-CSE-MsgGUID: NCKWiMgFR1680TtIOpNGFA==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 02:38:57 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 02:38:56 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 10 Apr 2026 02:38:56 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.50) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 02:38:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AbBBDDCRZFRqw8K6X+zCglnucahA/DAd7wJxoVZgkSMzTmZ5+egyWr7+njLc9Ab6fcZvZsLbgt8z3y3lhUtOogTE3Qpz6UtZNOIqu5ETDjfsYzYXFNLJ7q6KAWDtM3Zr1r95xTobOhfxrm9pw/rTBCrK8fEy/7Veh7gj1WC9FQ+A8zbM5DiIJEgZ8Ldp/Jh2DqDdlJYjrpu4EVFNXc25tCrpcWfCBBTUfyI/P7akgTbiz/SFXK2+zoZyLg5Ur3+sAO0leKp2rjCCXZcNrXpqdJxaIjZaRYwUT5TLY+7W6xN8o+yxpNqtXPZAtXOWn1VhB1roR/Lzj/mD86LOdOxGzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+F3eMxO/fc9nBhFEG8fg4YvBJ04ea+G8pBqq4EpcC0s=;
 b=e8Dhe4cQXADLQs0AIJnU6XWaaYkRq5XiKLNlvmfO7iLFDq1ZpSj4+FZJKJp0Sj7G99a+/EgwPznBHBsH5GaeFgnf9+t3H3Y+/B20f7EfNbTJWBhPPj9HovhIlE0tP6bRuKs6xvgOzLgC9R6xZtfLRDvs1ChBIhXhvRqF9btDHS6d93yk3y0NTtcvDZloVFsRoLprlSOxdDXMIDAPm50w2LRdjlGCsGNNL1TrvLWGQPmlQhsZOKF387piTytszS0cp5p7Ea/+7ROa721L8oGAA5YcidcQ96GLFgdUbhbAbIQKSOSMO7D8A0QwrHR5fccKjM/dclH0J42qelpL4FCW6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA2PR11MB4940.namprd11.prod.outlook.com (2603:10b6:806:fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.33; Fri, 10 Apr
 2026 09:38:54 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.20.9769.020; Fri, 10 Apr 2026
 09:38:53 +0000
Message-ID: <1dc56269-d6d5-48da-a4c2-0686ce4fd1f6@intel.com>
Date: Fri, 10 Apr 2026 11:36:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v5 1/4] octeontx2-af: npa: cn20k: Add NPA Halo
 support
To: Subbaraya Sundeep <sbhatta@marvell.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
	<gakula@marvell.com>, <bbhushan2@marvell.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Linu Cherian <lcherian@marvell.com>
References: <1775728404-28451-1-git-send-email-sbhatta@marvell.com>
 <1775728404-28451-2-git-send-email-sbhatta@marvell.com>
 <00fc6c1e-638a-4e80-b3c4-14e4dfa3651a@intel.com>
 <20260410093536.GA1783667@kernel-ep2>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260410093536.GA1783667@kernel-ep2>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0155.eurprd07.prod.outlook.com
 (2603:10a6:802:16::42) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA2PR11MB4940:EE_
X-MS-Office365-Filtering-Correlation-Id: a024d52c-bf5e-47f6-7f8f-08de96e4fa9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5lepC6SPSU7GVJW1ZXtMySu10/qkcQ6Apu/1KBE9xsa9u0o0QIndIs1lFV9mqYi5L4VuGIyq1gS6Q7yhR3SA4efr4E1CvELIZshsy2/O826fMXSkJOBHvQb8iXf9MkoqH9J3NCd1cjoBXerx+r50m+jlntdJKmQ0GjoTRKP01ThdEaScq14F4O3U7RV53YFqejlzyuCwk/WgHx240NzkQvFHnMqDFDPW2Zs498pD08QYpFRkffaoIvuzj3+azVCKNllMRGJVofU73gA3c1J6wxiNidTffn/GKSOuEZdUGSiAoDL5A58/4+BiQj5O475ZXkMgE71sv0T0EWRc+FU2eQRCOurIpuhqyiB9TmBqEagaZiI1xR4dlr8+K/Csh+25fA1HDIt8oxpV0Q7COuX5J1dM+hSA73AM5p6M9IF9cMN4V5DuiXmeiGN2KETmvUPvt0t8ObqnkwK7BjT92y1gWnU9mBT4dxVpQL6DuLv8Jc1caXIIs9IPBN8HoidnO6rgLwEHmuX9O/BUK1e5vF8sWvSAxcq23FtW+gkePkfpbD8XJ27PS2xFdCbhbNFr/cvqSTvQgnjX/k2HG9wB3H6dNJIGHlSTsVWW+hbSa2Y1X+7xhEw1F2NzPRcKxSC8colgRsg1XxGMGmmPWRS2N2sZ+czr+M5GjDT8K88Gn4LzKtwRxOrC8HnZ33X41mAgQboWoRBCOzMlKg0S2j6Z7+N0EIVva1R82PN6BS5/LFBsMSU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0RQc2VFZThmZmE4cFY1MFlLSm5GcDBPZEFZNjFFYW5HT0twYndJTzdxaisv?=
 =?utf-8?B?UkZ6WDd5NlZHdHFnU1IxUzBZOGgzM21Da2JSc2x3OW5LMW83dDkvZ0NoQW04?=
 =?utf-8?B?cWdVTnE4UHloeXFab2MydGVCalpzbEU5cUhERzZQUzducXlGOHdJZTFaTlJD?=
 =?utf-8?B?Q25SeVFLbFEybW1GQzF1VXNPdXNubDVqN3RNeCsvUXppTTVUUjAxVXBISmRY?=
 =?utf-8?B?YXRHckUxYUFmTUdSVXVYUm1xNUx6enZGTjhBV1ZwdDRoWS9Dd2NmRUFRZGhm?=
 =?utf-8?B?NERNeTR0YVc2SWpWL2loN1dhOWl3RmdVTHIyY3JJMndIS0VDSng4REVPYmpW?=
 =?utf-8?B?K0JnTDFBcWdkYXpCMFAxLytQOHNDSTJ1WjF6ZXVWL0U4dnQ1M0sxQVZWOWx0?=
 =?utf-8?B?dGFxS2w3eVNWTmd4SDVPMmU4bjYyME1QWUxYUW5UQjRGSE5yVFBnb1Z5RGMv?=
 =?utf-8?B?UEtmYnh6cVJSVXpsQk9XVC81YXlZWXJ5V3FMN2VHV1FwV3JxQkhENXNVTGpj?=
 =?utf-8?B?dXRYSVdhREh4RG9mMUFIYzJIYjFEbXRteUw2UVNNOFBRZlFMdGRQdlB1cVFz?=
 =?utf-8?B?YjZ2UXBmYXZWaXEvODJ2NVVkclcvUVZkUTltcWUxTzBTbmVqQmRXQzVwNlA1?=
 =?utf-8?B?SHl2Z3JIYmtqa1A0NllQeWxsQlF6T3hUQ0F1TU1ZTmhjZ1ZLcGZGYW9qSFRa?=
 =?utf-8?B?VHN1bmh0VzV6WHFJK2kvUitqdExnV09MdHB4VVZ1bGxVeGJQbWxCbUVVUitF?=
 =?utf-8?B?cVFlN3RKS0lCaSthSDF2eWthM2Fvdm1PWFZOOGpMVmJMTHlkNGJyUENwS0No?=
 =?utf-8?B?RWxhRnQ0aHNwajU0TmUvQ1NQYnd2TGt5T1FVVnVTYTcxdWNFMnZFZXN6NTh5?=
 =?utf-8?B?dXdnRGxPMHFISUY5SnRiRlVVcXFRK09xMERkNHdzNXZhKzJ1NWJJVkQwNTZG?=
 =?utf-8?B?RFpEdzIyM1puQnF1VTBHSHVwUDlWSnN3dkpiSDZ1QXpRQ0NuQkdJWG82ZGF3?=
 =?utf-8?B?eVIyMmRXSkxhenJ4WmZYZE1zeXptWXRrTmhBNjR2TndobUZzcDNOLzltV1pW?=
 =?utf-8?B?eGFvTjc5NmxKUWx5S0FxaUZ0R2pZUFFGdEtlMjIxTHFlMklzL2ZUT2tvZGtv?=
 =?utf-8?B?SGhCamhkRGV0L3dFcy9TeXhiZ254WkhHY094RFRXR0dSY1RvMGlKSGI4K1k5?=
 =?utf-8?B?R2ZvRHFuclVxbnlsQ1M2NDI1cHU1andnREs5K3N0VFdraC9lRjUxMTBaenNV?=
 =?utf-8?B?Q3lmaWRnMW1FYVZaVDBtVE0wQjV5OFllVTVwQXEyR3BYTHRVRVVzZGZNRFdV?=
 =?utf-8?B?eHpHVW9pVXZld09qMFErMzlldVloOEhDeE9NL0EyemxxMUlrb2g5MHZ4RU04?=
 =?utf-8?B?Sk5ZWEpEYlUraENUZW5lVlhWMExxWkxheC84WG9jdGltZkM2aVpQUHNuQ2lw?=
 =?utf-8?B?cEtlYmV6YTBBZFFFenE2UGtKQXNYemRFbG9JOVlGY0tLeDBPOUw3UGh1Y2lC?=
 =?utf-8?B?TmdiVUlLeDM5cjV5a010V0hHb1I1T3BWa3p3M2xYOUV6L1hlRUkvZXlwOTVH?=
 =?utf-8?B?b3JkTjVCWEFQYjZwTGZ2b29ZTHpDeTB6SVR0dkFzK0Jkd3krQzZBYmQ3bmpM?=
 =?utf-8?B?bHl4VzFTbFVWdDdENlpUZlZWclJPUUgxZkFwVk9wOEJNVjdzNjlEQVhSVS9y?=
 =?utf-8?B?dHJwc1BRREFhdzlRR2ZMV0FmYU03RTcxS3Y0c2VraG95ck90TlRXNTM3dDVp?=
 =?utf-8?B?SGNQaXNieWNPa1dXaTZUaGJWd3NyVHdkVlZ0d0hHOG4xRU9kcUdtOFdybXVt?=
 =?utf-8?B?d2NGaWpqVithM01RVU1jQVM0NGZIeEV5akhrY2FGZnhFTDVFeWVRREphUmJU?=
 =?utf-8?B?RGh3SDlFcUpscHpBcjR5UlFKNTlYZG9VZk1zaWNPK0pWNUl5MkZ4U0VhbDFm?=
 =?utf-8?B?a2h5Vy9xaFcvSEZQeFgybkxSTncwZDZ1MVNURTZRMVFsS01TRHU3Wktvek9U?=
 =?utf-8?B?YlA3OHBwUzNzQUZTNjNlMjJINFpxYzB6YXluREN2dFRYWjhkQzV6UThaY29r?=
 =?utf-8?B?bER2SHFlcnBLb3pJeGFYKzN4YTlXd3V2bjEwKytVNWZtZGFZTi9FTGh3SWZF?=
 =?utf-8?B?M293TEVVVTBVRlAyc0ZtTmk0aG02dG5yakVqVzhYME5nRm91MGNXMjJmelBH?=
 =?utf-8?B?Ym04ZkcwRUlyYnpTenJhVjlnUGJFNjJFTEpkZUJOSFhoOTlsL2plRDdpUFZh?=
 =?utf-8?B?a2hwSW5hWlhRdzJxbkNvVGcxTDMrK3pxVTdYcm5uSHhoUWhOb05iaThDSkhR?=
 =?utf-8?B?UnJ6TlVycGsvQitJV0NWb0dtam9JZG1uOGROaVlRY0JBUDdCZXBsNElUVFRv?=
 =?utf-8?Q?iEDJgH2OP0vTO3i8=3D?=
X-Exchange-RoutingPolicyChecked: Y1xv4BFeQYakMhujaCESG1KKepfUIxzFAYbjD8zARE0UyhMfRK7bTJw5/5URsmHqQDv2xs4XJ8l80BHtcUqB8svBeNcMAIgJGtupioZS72JZaMZVJOM7C2O7gGJCtWMCZS1/gcLGbiSg9jfufcneN//Sc9FpR0e1vV0WhE7U/+TesUtqSvW4H4pC37qxTQcNAKH3W6cNixDIDou5Aj+cnUt/PTYKhgcUm6bcI3wC9Sye0F7Q+VtH2ZJZ0g2wLkid86dliNP7DAYTjgJSwon48llzQZCZ7oI3AyotA1yCuWeQ/u4PmvDZn3iXjV3mcRr2BvSXxuM2E8NyaKZ4abcKSA==
X-MS-Exchange-CrossTenant-Network-Message-Id: a024d52c-bf5e-47f6-7f8f-08de96e4fa9d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 09:38:53.8015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hae/TOROvFWWENzjoHpdYX3+uA4qSsaBVWlwagbrm1DNdkO4Mzgs0/Nm4E5SAXHPeG+nmCGEvzNXqg65LsvFZzMUfrH7JndHDlfaUzn37mM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4940
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-277312-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 45FED3D5289
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Subbaraya Sundeep <sbhatta@marvell.com>
Date: Fri, 10 Apr 2026 15:05:36 +0530

> On 2026-04-09 at 20:39:02, Alexander Lobakin (aleksander.lobakin@intel.com) wrote:
>> From: Subbaraya Sundeep <sbhatta@marvell.com>
>> Date: Thu, 9 Apr 2026 15:23:21 +0530
>>
>>> From: Linu Cherian <lcherian@marvell.com>
>>>
>>> CN20K silicon implements unified aura and pool context
>>> type called Halo for better resource usage. Add support to
>>> handle Halo context type operations.
>>>
>>> Signed-off-by: Linu Cherian <lcherian@marvell.com>
>>> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
>>
>> [...]
>>
>>> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
>>> index 763f6cabd7c2..2364bafd329d 100644
>>> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
>>> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
>>> @@ -377,4 +377,85 @@ struct npa_cn20k_pool_s {
>>>  
>>>  static_assert(sizeof(struct npa_cn20k_pool_s) == NIX_MAX_CTX_SIZE);
>>>  
>>> +struct npa_cn20k_halo_s {
>>> +	u64 stack_base                  : 64;
>>
>> It's redundant to add : 64 to a 64-bit field.
>  Agreed. But this is for readability, it helps when checking HRM. For
>  instance HRM says [703:640] and we define as u64 reserved_640_703 : 64;
>  so that we do not have to count bits in mind.
>> Moreover, on 32-bit systems, the compilers sometimes complain on
>> bitfields > 32 bits.
>  This driver depends on 64BIT.
>>
>>> +	u64 ena                         :  1;
>>> +	u64 nat_align                   :  1;
>>> +	u64 reserved_66_67              :  2;
>>> +	u64 stack_caching               :  1;
>>> +	u64 reserved_69_71              :  3;
>>> +	u64 aura_drop_ena               :  1;
>>> +	u64 reserved_73_79              :  7;
>>> +	u64 aura_drop                   :  8;
>>> +	u64 buf_offset                  : 12;
>>> +	u64 reserved_100_103            :  4;
>>> +	u64 buf_size                    : 12;
>>> +	u64 reserved_116_119            :  4;
>>> +	u64 ref_cnt_prof                :  3;
>>> +	u64 reserved_123_127            :  5;
>>> +	u64 stack_max_pages             : 32;
>>> +	u64 stack_pages                 : 32;
>>> +	u64 bp_0                        :  7;
>>> +	u64 bp_1                        :  7;
>>> +	u64 bp_2                        :  7;
>>> +	u64 bp_3                        :  7;
>>> +	u64 bp_4                        :  7;
>>> +	u64 bp_5                        :  7;
>>> +	u64 bp_6                        :  7;
>>> +	u64 bp_7                        :  7;
>>> +	u64 bp_ena_0                    :  1;
>>> +	u64 bp_ena_1                    :  1;
>>> +	u64 bp_ena_2                    :  1;
>>> +	u64 bp_ena_3                    :  1;
>>> +	u64 bp_ena_4                    :  1;
>>> +	u64 bp_ena_5                    :  1;
>>> +	u64 bp_ena_6                    :  1;
>>> +	u64 bp_ena_7                    :  1;
>>> +	u64 stack_offset                :  4;
>>> +	u64 reserved_260_263            :  4;
>>> +	u64 shift                       :  6;
>>> +	u64 reserved_270_271            :  2;
>>> +	u64 avg_level                   :  8;
>>> +	u64 avg_con                     :  9;
>>> +	u64 fc_ena                      :  1;
>>> +	u64 fc_stype                    :  2;
>>> +	u64 fc_hyst_bits                :  4;
>>> +	u64 fc_up_crossing              :  1;
>>> +	u64 reserved_297_299            :  3;
>>> +	u64 update_time                 : 16;
>>> +	u64 reserved_316_319            :  4;
>>> +	u64 fc_addr                     : 64;
>>> +	u64 ptr_start                   : 64;
>>> +	u64 ptr_end                     : 64;
>>> +	u64 bpid_0                      : 12;
>>> +	u64 reserved_524_535            : 12;
>>> +	u64 err_int                     :  8;
>>> +	u64 err_int_ena                 :  8;
>>> +	u64 thresh_int                  :  1;
>>> +	u64 thresh_int_ena              :  1;
>>> +	u64 thresh_up                   :  1;
>>> +	u64 reserved_555                :  1;
>>> +	u64 thresh_qint_idx             :  7;
>>> +	u64 reserved_563                :  1;
>>> +	u64 err_qint_idx                :  7;
>>> +	u64 reserved_571_575            :  5;
>>> +	u64 thresh                      : 36;
>>> +	u64 reserved_612_615            :  4;
>>> +	u64 fc_msh_dst                  : 11;
>>> +	u64 reserved_627_630            :  4;
>>> +	u64 op_dpc_ena                  :  1;
>>> +	u64 op_dpc_set                  :  5;
>>> +	u64 reserved_637_637            :  1;
>>> +	u64 stream_ctx                  :  1;
>>> +	u64 unified_ctx                 :  1;
>>> +	u64 reserved_640_703            : 64;
>>> +	u64 reserved_704_767            : 64;
>>> +	u64 reserved_768_831            : 64;
>>> +	u64 reserved_832_895            : 64;
>>> +	u64 reserved_896_959            : 64;
>>> +	u64 reserved_960_1023           : 64;
>>> +};
>>> +
>>> +static_assert(sizeof(struct npa_cn20k_halo_s) == NIX_MAX_CTX_SIZE);
>>
>> Now the main question:
>>
>> Is mailbox's Endianness fixed (LE/BE)? Or is it always the same as the
>> host's ones (I doubt so)?
>> If not, these need to be __le{8,16,32,64} (or __be if it's Big Endian)
>> and you need to handle the conversions manually.
>>
>  Yes endianness is LE and fixed. This is NOT a host side driver for an
>  endpoint card. This is driver for on chip PCI device of CN20K soc.
>  Hope I answered your question wrt host.

But the mailbox is shared between the SoC and the host or HW or not? Is
it possible that one client of the mailbox will have LE and the second
will have BE?

> 
>  Thanks,
>  Sundeep

Thanks,
Olek

