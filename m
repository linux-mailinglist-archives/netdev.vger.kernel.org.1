Return-Path: <netdev+bounces-180586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C83A81BF1
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 06:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4DCD1B676B9
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 04:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA721BC099;
	Wed,  9 Apr 2025 04:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EuruyUQc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E926259C
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 04:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744174450; cv=fail; b=m+HCB96ymPFtTQW7cdadbPG2osKlNBqMee/lLL5gxuDBYV2yhn21T7SG48Mr3bVFKgr3N3WPz0U1B5RU8wX2Kznoy4/jHBeySBC0MDQRRr8MN5RB3mHFt9URTKdp/Wj+0/m3+xidQINhTXLC3A9Kim9tIIulVHZDil2PuNslhZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744174450; c=relaxed/simple;
	bh=OS22k+XdXBwQj78i9jn6uT7AE3p1h6J4ioRDnF/yEd4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rer6VHMNDkxKd90feowju1gGRuqtW1NJra/goACLyLxVELQ/7kUX0OVyAfksND4JIHJx8RYKYNqDHLSRDnEAhP3KCrqd7isv2eLVkDjeIVWlKO9ZgfWzkQaOGXZsS/gD3n9YBCzW6DvgSxHIBX8CUOGHkJX4nycsY6lAgn2HGPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EuruyUQc; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744174449; x=1775710449;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OS22k+XdXBwQj78i9jn6uT7AE3p1h6J4ioRDnF/yEd4=;
  b=EuruyUQcy9wdfslcAiJCHoRei0EL7g6tggpKpuFuXE3CQzpgUAZcRRLL
   t9V9vOR1w+h13FkIPL251C588u1YwouGeyjsbDFQTxCBN5QKAY9HRn+lk
   sVW7N8CRrruMkk2cx+qKQNz2jrEX3Ei3PM7uy9Nbfk2YKTB+R1/8gu44S
   pq9u+e3Ckv3QoLOwdf5EZ7ZGoDivs4xz8kDZH3pCkbT4IHE0nAHEaZnr0
   DFEhNIpkYA87xBU/BW5jRBH5ibKrERQdej8M3LINYaFKnHc8kX8X1VF4p
   o5RHEMqvoAO1Lf2RgnUq8hzII6Myu3c8ttCOdLRzoYbbNOLmrqDw/FLpb
   A==;
X-CSE-ConnectionGUID: G/EySN7lSsG/+yYAVdv4dw==
X-CSE-MsgGUID: 8fTAOuK4TrawvfuHQenk/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="49425730"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="49425730"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 21:54:09 -0700
X-CSE-ConnectionGUID: Kac1bmVNRcSMPucCIaCyVA==
X-CSE-MsgGUID: u7aWgXY2RGK69zOpuubGJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="165700985"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2025 21:54:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 8 Apr 2025 21:54:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 8 Apr 2025 21:54:07 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 21:54:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UxZF7JVEkdXjnAGygIDxhn5gE8zmk9QtXAOI7RPZ3qmv5APFSWmXRQgaqj2zV33cagATV2qBTdKD+aaFZlKOOGm2QLTSoeKzUs96xdDtz6XsQKnY2/LfHoqt+WAMyrkyCRKRucZj8yR7XMG4XblihNPKg5lP1jSwXVKuNtr/Xv1n99WGf/aLiqawfzlqiA9KO2LaKj7jj2+P8XDv2tufeMUCUZSWrmiZoo0klPW3a2panNRAo0z32yg8ZH8xOIxNNOX5rTNZZN5RqvhgzNqGtUG//6KAC7+fQ9vX3+n3ZcD2Ko40MQOdBlagMOTVedNbU+IrA+6Y1kGdCT40JxO99A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rECU3qx650asqu6cKvwlY+GLa+bs0vKoq7TvyjrNCYk=;
 b=SoaBBpx+fVwe9dIOhRkAEG4OAuR5nJBFJ41eiA28EtTgJkTycZiOuLVd6Bl7zMUcH7vPb6FmM+0W6UfzhWV6KUQyanlS0+omCFt2rQkbRyLQQbpd39pRdaM9VSQ4QPqybSjxapmnuvUV8HBJyEDbHFWDPExgOPbPxJmCHwdWAjMnrRKCdoR4QMfnEtr6x2RfnBOiAWrCt5OzC2elXgJjq/mHqRwHxaasq5+znljaSgwA5IyWiZA0WByeiNJFZQxe6OCUw4tT65u0EDP6joIM2p/tZ7UulvIjnqsDCSdytEJSDd4NkmHno9M/mzEOEIalaHo4bAGfxPfP0FN5Cb4COQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL4PR11MB8847.namprd11.prod.outlook.com (2603:10b6:208:5a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Wed, 9 Apr
 2025 04:53:29 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.017; Wed, 9 Apr 2025
 04:53:28 +0000
Message-ID: <241a1402-6cb5-494e-9830-c74767af72c4@intel.com>
Date: Tue, 8 Apr 2025 21:53:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/13] netlink: specs: rt-addr: remove the fixed
 members from attrs
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<yuyanghuang@google.com>, <sdf@fomichev.me>, <gnault@redhat.com>,
	<nicolas.dichtel@6wind.com>, <petrm@nvidia.com>
References: <20250409000400.492371-1-kuba@kernel.org>
 <20250409000400.492371-4-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250409000400.492371-4-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0182.namprd03.prod.outlook.com
 (2603:10b6:303:b8::7) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL4PR11MB8847:EE_
X-MS-Office365-Filtering-Correlation-Id: 85ca6b8e-c14b-4847-64a1-08dd77227841
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z1MxVWVPRGRXUnRoL1YrSFhGNCtvYUV3dHd4NWJId3Q2Y0MvV2N4ZnlwSWlZ?=
 =?utf-8?B?elA1VklRVVVTaGF6OXJ5N0QzWEZWT0lWdmJxTHdaeERxcW9yY0Q1UmhMaFFx?=
 =?utf-8?B?T1pRQXYyckdkWkJ3RFg1SGo1UVI0YWovc205a1NBVml6NXZrK005NW1STldH?=
 =?utf-8?B?M3Nwd29TWnJuelFOcTQ3d3NUYVhsOGlGVEhWckpsT3Zyb05FOW5SNlV6MUM2?=
 =?utf-8?B?elh3K0EwcG9LNXNHNHhua3A1cHlycDhIbjlPdlQ1NVQ4ZEVmZHp5ajNmTWpZ?=
 =?utf-8?B?b2NGckVmMUc5cjBOcTVFYlJCdUM3ODJZREtzekVBK21TM3F2OWhSYlFuRkN0?=
 =?utf-8?B?OUh2cExCVGxWL0xvRitFeERkTHJxTDdzY3luQVJWdmRZZWdFOVQwWHliZytW?=
 =?utf-8?B?SEtVVFpZN2JYOHJ0dTRIU3BQWFhrUk9sdG5EbzVSQjFWaklWRitDVnhXa1Qv?=
 =?utf-8?B?bVBmRFJvSG13aGpkd1pSMmFyNmYwMHVrVXNFVndNTUd5M2lOUExiZ1ZTcjZN?=
 =?utf-8?B?aTV1QjRkMkI5amJ6OVFmWlh0MXY1ZE1WTVJRRnh6MmJFeUYxYkpWSFVUSmZq?=
 =?utf-8?B?d2JCZDh6bFR2UTRxbUJlUExObWlWY2NKU05Iam5ob0xPUHQwcTZsQU9zY1h3?=
 =?utf-8?B?T3NXVTNZZ1ZRUXlWVTRzUXdqeEJYcVlJWXhQbFZUNEpPSjdRY29wdnhIT3Vl?=
 =?utf-8?B?NDZndnZRakNvM3FrTCtiVytTVDQ5TkFLbXFwMk5rMmFiMTB4U0drQVU2Wi9G?=
 =?utf-8?B?WjNkQkttdXZEWjFueGlUaVZldmZQdW5HNldrT0RWUHdKQm5Jd0FjYnh0OVIw?=
 =?utf-8?B?YnRmK0kvMFJDOWNidk1pUHJOdVhDRU9VeE1UTkVKUlBXQ1ROME5aMSt6b1JR?=
 =?utf-8?B?dnd6bk5zS21hVElyZnZiTnphN2ZiWUpyYWVsUFdTZXBhbTNhakxEUWQ1TmxT?=
 =?utf-8?B?RFhWMnBGekpxL2pOTVBOZUptaXRaSS9aUEdQbjM1b0xQc0JxOUNabmFTOWtq?=
 =?utf-8?B?LzJ1cnlwZmpHcDNFZmxlaWpyUERSeXBpbmY2TW15dmdBRjdtRDBBRG5GK29S?=
 =?utf-8?B?SFpaNXJyVTA3UGc3b2ZycEE4cUlxY3V6Q0Q5M09lY0xyWVpUYVNQei9BQTBu?=
 =?utf-8?B?cmcxYXlFQ3AyTXh5cDJaUjRTOHVSU3FPTzJ2VGtmT2FtYldKTUNiejJWTmZX?=
 =?utf-8?B?Z0lFRjZDNUpub3FDSys4MmVINFd3dmJaZW9RVWNEMlV2QytjQ2dJdGVUZ1My?=
 =?utf-8?B?eCtpRWo4eUtCeDJpbVg2V01pekJWcmVrVlFhRktOYVh0SDVBK1dEamNacGNH?=
 =?utf-8?B?MTRoay9JZUVjaUx1Ukl0OEJvSExqdHJuZ0tuQkdnNnl2ZE1MS2JKQ3dJYlNq?=
 =?utf-8?B?Z0lBeWZMa2RremRKcjZ5bXRUWjlxRmdqS1NlclFXMkdDUDFUMHNpM1hvSjJT?=
 =?utf-8?B?UndyNXExdzhnb3g4dlpJUkNvZTdYamV6MEgvd09oZUVoeWE2ejFnZEt4ZHhq?=
 =?utf-8?B?YzhWdHJIeWxHUXlPM1VDa2dnb0ZhRHh4NEwyQWo2Q1dReEE0K21IYllNNDN5?=
 =?utf-8?B?T1NPYVd2R2dSa21MbHFIeThOR0dUTEJhdjY5aWplUU9rUTlSOXIxOU15aklB?=
 =?utf-8?B?ZzllbTYvTUd5UFVTRmlXTktrbWhROTB2UlBEM1JET1ZwTXZmN1ljd2JKdEdI?=
 =?utf-8?B?ZnZ5MVU5ZG1qbXJLWWdXaHgweENLWHJNc3ZhYmNHdzZETnMrcEFFMTBxdUlj?=
 =?utf-8?B?ckFnOC9icS9pSFUwY0JDTEVhcmFNcm8zTzM3ZzdrZHJZRktMNWNtSXhPS2hE?=
 =?utf-8?B?VHVrRjFhZERNTTE2cEVGOTArUmxZRzZaeFlvZ2l4RFdQZzNsK2ExbWNUaDdx?=
 =?utf-8?Q?+2lyG3wN71dt/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cURtT0gxaEZVMjRzVUVUVG9rN0NRN2hwMkJqTjhhem4yWkNLZGYrZkQ1eWY1?=
 =?utf-8?B?MHdUcG5Dd0hsL3FxV3QzeGVOemhxWDFLN1VLbWVQQTQ0Z0tkNlEwTG4xRlps?=
 =?utf-8?B?VW9nVmp0QlIxYktqemdqSFlUSGl6UkVpMjVBZ2VJeWZZRStiQ2lia3VrRVl1?=
 =?utf-8?B?RTIrUDR1b0hlMko0U3YxWkNSSTVDZ0ZVUXhsdTlGbkU3R2hwakh3S0JGdktT?=
 =?utf-8?B?KzJadGoyL3RpYnVoeHVXMDZpdEFYU3Q0K2ZIYTZwalBNYWppZ0NzZDg2dm5o?=
 =?utf-8?B?WUpPcU9DNHlOMlI4UGs2SHpSaUJkQ243cGVYS1MwWE42aFdZK2M4VFdtWlNV?=
 =?utf-8?B?eG44a0NENjA3RURSWGttdDJPdkFKc2FRNGVsckZFTEF0Wjcyd3RZbkVSa1dv?=
 =?utf-8?B?UldQTjRPS2pTbVN2eWxJMER1aHIzWWcyU0MraUdVZjZLZXBITm9xK2RJdW9Q?=
 =?utf-8?B?QkxwMFRxWTY4ak8yTEMvdFlSY3czTjN2VkxYRWVlR3duVnF4NklOYUhqVjda?=
 =?utf-8?B?MjBrdWg3TGgxWS9wbG1CcUJmTUR4b25IK0dIYmRWc1lDN0dYaWs3bjVpZGht?=
 =?utf-8?B?TTJsMnJmV1cwc1R5M1ZES1JNdlorUnNBSEtEY1lxekcxM1NtOWxqRVc1Qkx4?=
 =?utf-8?B?eDVWNmtJV1YzV2lqL2lYdjNTQkNQYjlBb0hCMEV0d1g4eStLQlRmUFVPcUg4?=
 =?utf-8?B?OTV1QlJpNE9samp6MnZZT0c5WFl1U3VJQmswbHlwVjZGREV2YXArNk9UN1dU?=
 =?utf-8?B?RU5rMHhnUG5iOGYrbUNuaVVNSGdoMldaTlVjR2hobHllRU00cERacjRaOGVB?=
 =?utf-8?B?UU0xaGFKTnptMlJnU2tKN2tPS0Fvc3plRUZJcUJ2NVVWODhUMnF3TktEcWtX?=
 =?utf-8?B?ZzF6NXNkL3BoNFJuTENNRW9CV25FeTYzT3lNaDN3SFcwMndrRDV5VHI3TTVz?=
 =?utf-8?B?M0thYy9VdE53bDIwZzFMbUZOclJTeExMdXpuT2o5OHNoK2NPNUk2OXU3MklG?=
 =?utf-8?B?OEYxdGdPMDYvelRzSjU1YzllcjduUXRYZTVpbkFkNU5CcVJ6OGlEOXpRVWU5?=
 =?utf-8?B?L005UjZFWWZ4MWU3OTBWK2hoK1huY3pIRXp0WDM4YUJ1dXg5RTVZSWNDRlc0?=
 =?utf-8?B?SGFMQjZML0M1cnRaU3lKZGZpbk56OURaZytpUlUvSTVHNjFLdHhoNm9XYzNT?=
 =?utf-8?B?Vjl4Qkg5NGhoNkhGR2RHOHVSYm03U01CRUloUVhDL1UrYy9ZV2RkR0lCZ0Fh?=
 =?utf-8?B?UXRNTHE0SVQ0UWowd2dnUWVjV3lpdVBSaFBXTG45YTlIYjhFV0pMekZMZ05E?=
 =?utf-8?B?aTZPaGlPMERyUWVwREtpb3dqTHRLVlNBRzVoZDhRZ2JWU3krWlNFdkJDMGxY?=
 =?utf-8?B?ZVVNY1hJallJZ2IwNVp3WlpxYnFQd2RuN1ZoZEh0a05NZzdheUIvY2x2aUZ6?=
 =?utf-8?B?M2ZCVURiMnZlVmFQQ24wbXdmcCtUbXhaZk5tOFJVTUpVK0RkN3VYZDhDSGxD?=
 =?utf-8?B?UTk4aVlFRVJkVmhQQThUS2puR2FCZ0lka1hrWHBlTGdiZFFldTVWMHRsOHhw?=
 =?utf-8?B?ekN2WjlsNVBIL1FZVHAycU5rcWtIa1VuZXVQc2VJY05XUUJ5WXJRUGorSXcw?=
 =?utf-8?B?STFVd1hPRTVvbjRjUi9NS1RpRDJNNy9oU0syYml4K1pZT1NBd00rb0c5L1oy?=
 =?utf-8?B?QTZGT29YdFgyV3V2bjR6Q0lZaTVMdmhoNEdYYWpaYlFMWFM1L0htTHNCekxt?=
 =?utf-8?B?QnQ0V1FUem1SQ3Z6cjlyRnFtVk80Q1dnUUtTMHl2SzlUWVcxVmZnWmdGVUVX?=
 =?utf-8?B?bnZ6eDBmUG9FaVM3ZmhTNzVXK3BLY3lCbko2MjlnQ0RkdHRLanIwNXFHNmcw?=
 =?utf-8?B?bE9udGxrajlvbDVqQ0R3YnkwcVJkeW1tdjJ2dmdGV1FVbU9OVCtCclZwWVlY?=
 =?utf-8?B?dzNxemtZQVdjZEJuc0QxZ09IaTR4bitIRzJMSFRwUWdLcWRqWHVwTnVDUlNF?=
 =?utf-8?B?SXV5czNsSWtPbnlMRTQxNUc5ZHMxYmE3Tm9lNEtGSGc3VFM5TUZIRnVNQnh5?=
 =?utf-8?B?WWhPN29OZGdFSDI4RTQvclN4cGE4SHNwdmp0NjV0SUZoOU5CTjRVT3IraWlo?=
 =?utf-8?B?Qm9EMTg3VlJ6NjVobWtPZ2JZQzZBYUNNT0lrR2FIeitEWWVSNVBaclZwb08w?=
 =?utf-8?B?Wnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ca6b8e-c14b-4847-64a1-08dd77227841
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 04:53:28.7656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bj9uPHxDywvhx3Uvs8F02GKNjiYbdsuz4A1+3ku7U+esgVToP8+ASnIbsvSD9eSn1hQknSVR+mGQqwoWT9dRzwGnmf0d5XJkoJgaQyaBzc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8847
X-OriginatorOrg: intel.com



On 4/8/2025 5:03 PM, Jakub Kicinski wrote:
> The purpose of the attribute list is to list the attributes
> which will be included in a given message to shrink the objects
> for families with huge attr spaces. Fixed structs are always
> present in their entirety so there's no point in listing
> their members. Current C codegen doesn't expect them and
> tries to look up the names in the attribute space.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  Documentation/netlink/specs/rt-addr.yaml | 20 +++-----------------
>  1 file changed, 3 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/rt-addr.yaml b/Documentation/netlink/specs/rt-addr.yaml
> index df6b23f06a22..0488ce87506c 100644
> --- a/Documentation/netlink/specs/rt-addr.yaml
> +++ b/Documentation/netlink/specs/rt-addr.yaml
> @@ -133,11 +133,6 @@ protonum: 0
>          request:
>            value: 20
>            attributes: &ifaddr-all
> -            - ifa-family
> -            - ifa-flags
> -            - ifa-prefixlen
> -            - ifa-scope
> -            - ifa-index

From the wording of the commit message, I interpreted it that if the
attribute list contains a struct, then its members are implicit and
don't have to be listed..?

I guess I'm missing something here since It doesn't seem like that is
the case.

Does the commit mean that structs are always available regardless of
whats listed in the attributes?

