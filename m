Return-Path: <netdev+bounces-149281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 786829E5023
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 09:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA60F188222C
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 08:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7D91D618C;
	Thu,  5 Dec 2024 08:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NU6rOLy2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3061D5CEA;
	Thu,  5 Dec 2024 08:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733388357; cv=fail; b=GkTy5xRqa8ecCDv3hH6dzYZVzQlpDf118LbzO2nygIyIMGR/fCmN4YtZpoMbYrFlXuflhKX0UC3IIVD4sjfsSYrcf+3lv6R5DtQxRZPZoLIoh9zctaVW2dH1DMMgJeBSkZz90veKQkMTZF3hG81IeDV8SaVwRyy7AK2aiKy1VyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733388357; c=relaxed/simple;
	bh=ExfnwmQ+gAxdlolqN6319Lwm4zfvJGh8cYqoW3+lk4w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i9/Sr9kGe8Yvn1dp+6zjtQTgQpCkG5Uq6anNEu7dtSuFQvWzSoE3ed7cQs7hpq2bk8GbH+CWwWe6HgGUNFNoKh7CyTRBprP7g8JVfdFnZ5vsP8KdyOCY/++//tt2ZaDqPlyBVwvXysQXG/E0ItD7dPbsqw9xymHb4NFsH9vwqAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NU6rOLy2; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733388356; x=1764924356;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ExfnwmQ+gAxdlolqN6319Lwm4zfvJGh8cYqoW3+lk4w=;
  b=NU6rOLy2uQX+S5UtgsHhMKRlPldH/EzgOGeSfMRh1AOFS7bcYgNncRQB
   yz9VuvTYrAQcPVZLfOQfQmoewX7gDc+oNKSPM7S2U3u1P/Ei7yZdaCdJ0
   6jmxlCBH4xTmZeJYj+WtKrLClHhODehER+AZT1xCNZIiwi8QIGYBH+LI5
   7KeM0FEdlckHqUY51hX+xHU8Q76VS29RETShY/RRTKoDG1UHeCGWmWrT3
   PFXCTa5t8pM0bAueXqMiEAE9XP+bhZG+F36lFOaTUzpBu5+tRtPzZ6PIz
   6W2NAQHcstnZhA9yj7d3LvT/MzkX9N7ekCqGB/D2zO6f/SmA10cSCAWPH
   w==;
X-CSE-ConnectionGUID: KEHrqiUQQIKjVI24VDnGug==
X-CSE-MsgGUID: pWCZtEvkQjuDmJxQD2ualQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="37623248"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="37623248"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 00:45:55 -0800
X-CSE-ConnectionGUID: ea65SP4NQpSIIDVBuTl9sg==
X-CSE-MsgGUID: 1qrnkK73SnWgOFRVwbUh1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="94864143"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2024 00:45:55 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Dec 2024 00:45:55 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Dec 2024 00:45:55 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Dec 2024 00:45:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCIgx2ibDNWm3VN2FiCTTTKMs8tpsaCycJ2sToJ1eh5GimGqoafGIGbpupHXR2T07K8RzzD4drPbX3Sw8LfEw6VsCl6mE0e9DLKaxmq8ZZWk+9Y8XYvLYICzeE8OSnBQsaWri5t7sQHIQJ1C9YhPjvsOV3xJA/92L8ZadVkJXiVJAvA6tzi6UQWtKTGMvVcs2G7U4Z2yf4LDvwuNLCGzQNyQ5NaEbDLMp5qRxVk3p4i4gZBNWvb6ybUmpQzHorgRQDvIPF84Ug4AUMAXwGK4hCaml5QFafHCNFjwCLIxQkr0hIibhXBxp6UX2Fia7b8/oagYji8JLC+FMo7Sj7KOsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yzl1Db+NDdSBqjGB/bcRqcB63jU0G2EK48BInzdWUc=;
 b=R47/vwhDE8BReaFlRmrfPaLdhZJjUmyA95X4NtuNWkSqG5awt6O7QU0/T8xebtB27d3934BpbGlWU6zXAEoi/xs7O1KvX9DjOyENcW9yvfBLJdnoUjXb9y60GGc7QpHTcpPJoI6szbMc+5J9wEvdVdwhCau8afcIyTXkHmyWRy6jJ1JNHc2h2mqgzSUU1tAKSQDjdwOc0IgmY3MjooN9EGipVMi1zUs1JJ//sx8IXfAzJ0GWOpM3AMrKUo0qSnYkKdtDj48jmSqyfBBmfmMvqaLWg3PLCuX89SSxGq4lUSkMeB3T62zewDOVz07HjI119kNR0fl1DcUhcDZWkSciag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5399.namprd11.prod.outlook.com (2603:10b6:208:318::12)
 by SA1PR11MB8544.namprd11.prod.outlook.com (2603:10b6:806:3a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Thu, 5 Dec
 2024 08:45:52 +0000
Received: from BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc]) by BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc%5]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 08:45:52 +0000
Message-ID: <d5591ca1-7413-4575-90e4-a22ac81cd2b8@intel.com>
Date: Thu, 5 Dec 2024 09:45:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 5/7] ethtool: add helper to prevent invalid
 statistics exposure to userspace
To: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, "Jonathan
 Corbet" <corbet@lwn.net>
CC: <kernel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, Simon Horman <horms@kernel.org>, Russell King
	<linux@armlinux.org.uk>, Maxime Chevallier <maxime.chevallier@bootlin.com>,
	<linux-doc@vger.kernel.org>
References: <20241203075622.2452169-1-o.rempel@pengutronix.de>
 <20241203075622.2452169-6-o.rempel@pengutronix.de>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <20241203075622.2452169-6-o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0002.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::22) To BL1PR11MB5399.namprd11.prod.outlook.com
 (2603:10b6:208:318::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5399:EE_|SA1PR11MB8544:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a785999-d9e4-4610-b747-08dd150939a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWN4SVFuT2UyWVkzZ3lHYWlmVU1iOFQ1NkUxN1ZZcHRDOGpEN1Y2TDdkZ29Q?=
 =?utf-8?B?SEFjY00zclZMcWVmQWZXU3BmaTBBODVuK25ySkFDVndwYnh6SmVyZVpkcFFx?=
 =?utf-8?B?Wi82RVBvZEpLYjB6eVlSTytTc2VsNDh2dFJBSlcyMUxaS0M4dkhqN0tkdUlQ?=
 =?utf-8?B?K0N5RThoT0MySHNocmxaa0RJOWwya09wUS9Yc1kyMjdqK3hHb2lSVHNXVjIz?=
 =?utf-8?B?T0pNdVJKOWU3OGRXNHF0R0dQdFJSeFNsU1ljaE5OMVpLTEFHeWdqek92QWEr?=
 =?utf-8?B?TTJsclg4ZGN5dFRVdVFxWmR2Um9JQ0tJTzRJejBkU0RLK3I1SEFNQXdRaEh0?=
 =?utf-8?B?K3l4ejI3dldTTWJBVzVNaHlKQUQ3SHVHeW9YTEhsbVVGc0IycDhtbjI4N29K?=
 =?utf-8?B?ZXpISFhnbm12VjhrdDVNZ3p2UzFMdzhKdXRWQzhHTE9IdDQxY3dLNXR0a05y?=
 =?utf-8?B?aUpNUnNPeVpTM3g1RXVIeDJDWGZBYndYT0Z2QnJYY1Y2TDlCYVFkTU9vbHVC?=
 =?utf-8?B?cGJFWmFZQWJuSWxSYUpTQmN0QUVPNzI4MitjaGh6LzFDaUZub2FPZFQwbUpi?=
 =?utf-8?B?L0VsZDFDWjg1RERQdFowcklBWmVvaWVZUUp3TFFTdlBWOVZibkNCUmJaS3Bk?=
 =?utf-8?B?VTVBMm1xcVp5anRadjloLzhSdkRkNlJpVjZJVXg3Qmg3Y1NsQkJKYytlVnVo?=
 =?utf-8?B?LzBoclErRmNxZU5KR1JPaVhkbTVoeEhhbUxmWEtiT2pBNXNXNFRBaDdsTUNI?=
 =?utf-8?B?K0srQmRud0pXNVNzVXJubE4yUVJ6ZE1uODBFZTRKeG94S0JNZFM5SXJ3dy9j?=
 =?utf-8?B?ZHdYZUpoamNmNVlUYWZVYVRmNHBRTzdIcXhxdVJSaS9xcGtuNnc2SlVVMXZZ?=
 =?utf-8?B?bHBITGxzY2NjZUlJVHpoMHdiRU5XTHhlamlpOHpNR2VzTDM5N3NJUGNCakRC?=
 =?utf-8?B?bnR1ZDlEa0lacHVoZlJaUTlSVm1NRGgrV1FJeEpJb1I3clpDZ09RZ1Z5Tk9Z?=
 =?utf-8?B?YzZIUWxEdkdqdThVcWdWaURVaEpBcWRNTGdYMkpiQWFNWnQ0NVhjbHN4SVBL?=
 =?utf-8?B?Z3gyclM0RlVvWEJGdTVlTmFDcnR6MWxtV1RNRnVtNkJvUGUweDErQkdET1RM?=
 =?utf-8?B?OG11TlViNkFuSzR3UnZlc1F2ZWw4V1FJQTJJalZTR1lNTE5YZGlkWW9YamRM?=
 =?utf-8?B?OVVTeFM2d1Bha2IwcTZ0M0lDclJmRzZmVTZPQzkvUmd6N2hMMWhLdll4cTVm?=
 =?utf-8?B?N08wSDJjeDRhVU54ZjVzd0h3ZG9BajVjUjB6bjh6Mjd6SG0zUWw2YlBnTTd6?=
 =?utf-8?B?NGYrSWM3eXFjamczTWVJNS84WkltUUo4SHgzbWlOMUltUlorUEdtd2Jwdlly?=
 =?utf-8?B?UDZJWDdLMEE2YkhYZXVyb0NvY2RVN2ZmdHJ3VFhVK29LMjA3bDZUOHdSaWwz?=
 =?utf-8?B?M0NDOGlOblNmSWtlYnQ2OHo0dUhXdmZydWlKU0NLeStQMWxSaHhwd1pwRVBa?=
 =?utf-8?B?NnRYUTZUWFVFNmVhUmZBcGphSmhlVlduWWtOUS9UeDkyakgxZktNUmdaTnNZ?=
 =?utf-8?B?b1graHEyaGhLeEdyTnc4dkxubW1oN1VheXRxSzRCOExjOEtkaERldWhoSkhs?=
 =?utf-8?B?TU82NWtjNXU3SERnR2RPOWFGZHZzL1dhSHFrUy9nZVZ1KzNwS3FCbmQxZW1n?=
 =?utf-8?B?dDFtVEgyOHYzNURQVzNSK2Z3am90MnJjOUtFS3U4bThlTk9QNXBKUnlnVmkv?=
 =?utf-8?B?SmVqWEkxdUtVR28zamdmYjdNNDNDbTRicU5lYVcwMTB4Yk01Qzh2MGF3ZUtO?=
 =?utf-8?B?Q2o4M2p3Z0lvYWNHQ1JPZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEIvMjhIQXRCNUJVMktNRTJjUlFXaUhQS3gzUWl3VWsvVWpqZDc4LzlkNGlv?=
 =?utf-8?B?L1VHdmIyRUJueVJ1UkZiM3J0ODZVTDZkQzNXaStKNm93aUdvTVVEdTBwV05k?=
 =?utf-8?B?VHZCYXJlbmZMTFo0bDhaaVhrL1FaM1kyRFpkWjVqRUpMakRWbnBiZWMrTGRa?=
 =?utf-8?B?blM2UTdNYU1PMDdqdTlMclNDak1aYms4NHJlYlJ0Q0JoRkVJN3ZTVlRQdm5x?=
 =?utf-8?B?SE9FRlFReWhIQ0hodDg5MDFhQnNJdEZYMzYxRTVITjhjaFhvc1ozSzQxdm5B?=
 =?utf-8?B?OWFwazVIY0k3bXZXekY0MytaZEw0VVVpU0dOUHZCWWVLZWxqVmRyVkFCN0Jh?=
 =?utf-8?B?RVpYV3ZWWkhEMHhwTzlkQStDbWdFb2QzZ0FqdTFFNlhEcjF3SWhid0hxUk9u?=
 =?utf-8?B?MG8wVmdnZ3V2eHJhZXRLbEpUVUNnTmdoUDFKQXJHWTNRQU5WcGZtNVUrS0RT?=
 =?utf-8?B?azAxRlRuU2l2MnNIQURHSWw5QWhNdGV3dzF1MTVvQUoyaHpMOURpV0M4cExa?=
 =?utf-8?B?d3VqUnU2QXUwVlRwclVsdDJaMHMxMG90NldKNDJ3ZWxIMGVhTHhvcW5JbUFJ?=
 =?utf-8?B?OFlWVGxxWEljL21RaHF1eWhlYTYvQ3BVYTNPN1d3R21zT3YwaDVzYnpYeEcz?=
 =?utf-8?B?NmlmNHJZN0wwMjVOUTFYc0FPZ3pMbDMydWxFWmRqdE5tV3BzN3g5VFp1YllH?=
 =?utf-8?B?bEtUSHlVVGxFWml1eFNFSWQvMFVKTFRndmxQZ214SkpJbnFMK2x1N2FFMGYv?=
 =?utf-8?B?bWg1aUNlbEx2a2RuU1ZoUXhadUNvOTRLakxlZ2poREI2cXNBdldlSUhpTXNN?=
 =?utf-8?B?ZmRmaTFteklROW5wYWJ5N2grNVpzcHh2NDVHUmxGTzdBVU4wTjlEeWJhZGxY?=
 =?utf-8?B?RGhnTldlOU5Dd3JSVFdTSk0zRGd2bjdKTllRa1c2YmtXcUZNMVFQUnZQZ1Rm?=
 =?utf-8?B?YzRrWHZCSmUyL3RVQnJDa2ZzZmpPNWtnczJnZHRhU2JMbmVFVC8vQk5sUkxQ?=
 =?utf-8?B?Q29GMS85eTFHcWxBN3d0L3Y2Y1YxSjVuZTg3QmhiZmpsL3NBYUpsK3RyQ0tu?=
 =?utf-8?B?VFcrV2o5WHpZTUtEQm9RQkVCcEhRTjlMNlRJOVlLcWZHbG9vdWZyOTFRVDNQ?=
 =?utf-8?B?YXBZSGVjekQ4eUEwV0Z2N2ZrUEsrS1dlWlJzYnlEQWY3MkdWRm4xN1ZlUEpj?=
 =?utf-8?B?bFp4aE4xaFRjazJNa2FGKzJqOWgySGNlbkNLdXJjS3JMRlM0VkhEWmJ6d0NB?=
 =?utf-8?B?MTZXdUxJOTFwOFg0emI1MlY5S3FlMFNhOWlOTFgwU1crUlVRbGUxa2Y2NCs3?=
 =?utf-8?B?T25wT3BCdTVjSmJOTmpNaVVzMEhFSDNWcEJnK2V5WTJNbks3UnRUeWN0TGhw?=
 =?utf-8?B?UTZKTVFzM2VKTVRhOWFVYldQcGhsRzlwbWxYeEl6LytLUHJZRW15UEo5OVVk?=
 =?utf-8?B?SHFybkNDcUFwemR6em5Fb1pFQXVyTHYxYkxya3huaXkrODN3VEY2OW5COWRm?=
 =?utf-8?B?aUprSHVaSjliS1pMZmh5QzJZS1lkQyswdjlJT1RaUHd3V24zRGZXOUc4N0RI?=
 =?utf-8?B?Yzd2UDNwOEJBYUJHNnEzWnhSSGwrV3dFckFBc1dLQlRWS3hqNHdmR210akVY?=
 =?utf-8?B?NDBPYU5VZVFGNDJZdjFrQVFZRm0xNDU4RUJsdFRmdmszZXNGdEJFUmdBUWFF?=
 =?utf-8?B?c01Pb0NWZDQvZ2lnb254d0pLZS9YS2RXZmIyei9DK1dOQTJvQmhPc1J4dTVa?=
 =?utf-8?B?T00wTlRwbVNBeUJSbEpLU3d6WW0xRTl1MVhyVitXNDhFOW5aVlFaT1REclhB?=
 =?utf-8?B?dVdTcW1DQ29zSnNxZ3V0QVNLcjlyc2VseHBLWGNPeHQ0dHozMXpYbk1rM0FS?=
 =?utf-8?B?cy83b2ZYUGZEWmdYMVNqWTNqYVZnc1lBZWxyMDRrdnhhclZCbk9LNlJzMUhz?=
 =?utf-8?B?RGNYc1hJVUR6WnV4YVRUcmlkZW9TNmdjMllTQjl0dXFvNWt6Qk45VXU1V1Fo?=
 =?utf-8?B?L29YbFBRcTdwVlIwak9CVXJWTkhXbGQ1dkNCS0Y4T3JIL1o2TkMwcW5FUTJz?=
 =?utf-8?B?azVGbi9oZTB5cW5KTzc2VUFDMXRRY3pwek0rbUkyL0F3QkVYRzNuU3RVU2NO?=
 =?utf-8?B?aVc5VUFjMkVWNnZML3BWZW40WUhkdTd0ekJQUjJzVWRDcXZOeElGaUcza3Fa?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a785999-d9e4-4610-b747-08dd150939a7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 08:45:52.4590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0PEb6vxX4U0HBMpy64BNyVZBM2YOPoA10w0C9lR6eBTxe0JJJ4kn5XUT9cZp8ezmyDGZRACbtlPEfp5zOeOBzXYyblVaDNEfWtHGoZo4B+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8544
X-OriginatorOrg: intel.com



On 12/3/2024 8:56 AM, Oleksij Rempel wrote:
> Introduce a new helper function, `ethtool_stat_add`, to update 64-bit
> statistics with proper handling of the reserved value
> `ETHTOOL_STAT_NOT_SET`. This ensures that statistics remain valid and
> are always reported to userspace, even if the driver accidentally sets
> `ETHTOOL_STAT_NOT_SET` during an update.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>   include/linux/ethtool.h | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index b0ed740ca749..657bd69ddaf7 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -371,6 +371,22 @@ static inline void ethtool_stats_init(u64 *stats, unsigned int n)
>   		stats[n] = ETHTOOL_STAT_NOT_SET;
>   }
>   
> +/**
> + * ethtool_stat_add - Add a value to a u64 statistic with wraparound handling
> + * @stat: Pointer to the statistic to update
> + * @value: Value to add to the statistic
> + *
> + * Adds the specified value to a u64 statistic. If the result of the addition
> + * equals the reserved value (`ETHTOOL_STAT_NOT_SET`), it increments the result
> + * by 1 to avoid the reserved value.
> + */
> +static inline void ethtool_stat_add(u64 *stat, u64 value)
> +{
> +	*stat += value;
> +	if (*stat == ETHTOOL_STAT_NOT_SET)
> +		(*stat)++;
> +}
> +
>   /* Basic IEEE 802.3 MAC statistics (30.3.1.1.*), not otherwise exposed
>    * via a more targeted API.
>    */

The code of function looks good

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

