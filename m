Return-Path: <netdev+bounces-111910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA74934161
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 19:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C374281CD1
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 17:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133EA181D0C;
	Wed, 17 Jul 2024 17:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MS/z5/PN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165941E4A6;
	Wed, 17 Jul 2024 17:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721236949; cv=fail; b=gPMHgUPGk6GdX2dqPEreTdGlgJdq6fXE3twAVgV1yAb7JIut33P5AkVnc+9EHBdHAbtxvrPsf9faVfLUfhDm0o89to76YlUAbc+bgNSt2OIqoW+44+L7bkVu/VfFhIf1DWvUmMOthUrr+bqyckzPkyHUOIvNAO38U++liwPD8Fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721236949; c=relaxed/simple;
	bh=0IQ+65rsml9RGj4KnJkTHaSCi6A9YV1j5N15cyauwmQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=usIYMPJxPJYC9GnOE066luPZ6cw4f4dxL/OAu8bewEvYLG//xZCW5mGlTIrYaW8xup88Uo4/vA/rPBuMIGdWY5FicS3DDqtlXaodJm43O6DXOK/9qcmrESI9V2aCtwCvnKSXnT+2t57N1PBnYPqf+tCJLOzSeyvLG146gwR7/zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MS/z5/PN; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721236948; x=1752772948;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0IQ+65rsml9RGj4KnJkTHaSCi6A9YV1j5N15cyauwmQ=;
  b=MS/z5/PNoiTOQANOAKFIvI6H1KLmyUR/rWHpXnUt23w4BsPR3dJOou1K
   AUb5qjM5o+EQ+jlOf73r2XBDE6FOwF4BC3JyV8uvdofoCHkQVQjQvg3Me
   b22IYcFAwkkW+rSp85Np4x6fjSC4yycddeqnn8cPIhOapZap4b+GjjL5d
   isxwMAwgp7SNCemDVyfcnvNnU+bjeKH7i+eopkLOhkMFd2fryjTgbvk4Z
   Rn1Sux0eDMNtUXyHz1s3hlYEzFenT0kkj8/+Pp7hsIFXViBvzdY8zki32
   WF/Vk990yXVkQF1/9Cq3B3BhzTTmOk4RwNP49HtcimhggYXquBz8dBVXs
   w==;
X-CSE-ConnectionGUID: hULRdarATTaiqdUyvJUu2Q==
X-CSE-MsgGUID: ++htm1K1T8eJxKV2elpNBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="36196797"
X-IronPort-AV: E=Sophos;i="6.09,215,1716274800"; 
   d="scan'208";a="36196797"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 10:22:26 -0700
X-CSE-ConnectionGUID: zUzJUJW9RtWc0NgdLWl5gw==
X-CSE-MsgGUID: veJBBYwqSwigi57OYSKdUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,215,1716274800"; 
   d="scan'208";a="50207996"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jul 2024 10:22:25 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 17 Jul 2024 10:22:24 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 17 Jul 2024 10:22:24 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 17 Jul 2024 10:22:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wwNw3rGrWyP5s29dV3OcXCvBBvaMRB+niShZOyp7+kcFBUuTs8Dtcoc82bhscRdQRdGCHISqeI3/iP0bpa5QgnZIVwO6QfHlXuArhDs8TMOvteXO+6LVjuER2doYILhCum72cI10HnQ1tUxi1NVCPk8040rQj2dFghkJQhf3ahnEL+ftwVLbKzXr5OimarsqUc7SSKaE9bbK0MnH4IMSKFBe7zHiWlNSCKxm1Xiw4Y3/JvSknIM9CMcQlY4KkHdI7U2pJZHnZnVa1ipeKSzhiCDf/fGp03AP6xASs+MoEBc9BWqDI65PS03GI8g4mLhyEc/MmLjCFdth61XXHlpWWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tvt7DSImlEOZwACq2P2U8sdq7PJiPLpFT817TXsfRkw=;
 b=FuYIyJMniMAsMrD3lezhwRCU67QRf7VPUGwcNq/QKT4WeRjcH24+M9Dav86qRga1CYPYha7pc7leZZwffrhiUGzEgr5GhkFB3oIuCjHbXF6pqd1GBqOncwoN7zTIgE/+eWqX+XZMbzkG08wtucCIUWxeb9GPN6yH8zzF55d1Hlc3pQf2gYdZAYUoYX5grjAEV7qoFfFEg31I6gDi5yG3zyOt7foxQVBkXawazFEGS6hquQ1kwGtc3BU5WNV0Wwt7tdnLwVpHoyim7jsuX2vLFSaLJW2PKD9TWOCJOWWnaBfmmrHzevZrbwkXTGyjQOp1XjDZdEwzi3mVd6ZL89mKxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB8041.namprd11.prod.outlook.com (2603:10b6:806:2ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.25; Wed, 17 Jul
 2024 17:22:22 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 17:22:21 +0000
Message-ID: <aba17b24-a00d-435e-ba43-99f98378f986@intel.com>
Date: Wed, 17 Jul 2024 10:22:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 08/14] net: Add the possibility to support a
 selected hwtstamp in netdevice
To: Kory Maincent <kory.maincent@bootlin.com>, Florian Fainelli
	<florian.fainelli@broadcom.com>, Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
	"Heiner Kallweit" <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Radu
 Pirea <radu-nicolae.pirea@oss.nxp.com>, "Jay Vosburgh"
	<j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
	<corbet@lwn.net>, "Horatiu Vultur" <horatiu.vultur@microchip.com>,
	<UNGLinuxDriver@microchip.com>, "Simon Horman" <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, <donald.hunter@gmail.com>,
	<danieller@nvidia.com>, <ecree.xilinx@gmail.com>
CC: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Willem de Bruijn <willemb@google.com>, Shannon Nelson
	<shannon.nelson@amd.com>, Alexandra Winter <wintera@linux.ibm.com>
References: <20240709-feature_ptp_netnext-v17-0-b5317f50df2a@bootlin.com>
 <20240709-feature_ptp_netnext-v17-8-b5317f50df2a@bootlin.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240709-feature_ptp_netnext-v17-8-b5317f50df2a@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0380.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::25) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: d78cde51-9d5c-414d-692c-08dca685048d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bjhwNG5SVXFsTmNmQzJTNmg4enJUT2FnUEt3dVpZTkg0VUJSOFVjaVozNXJS?=
 =?utf-8?B?bUVvZ1JqYkl0OHhOV1F3VEZEUVJYTEMwa2RsbHhyZ2lBQm9uUjVWZzh5a2NI?=
 =?utf-8?B?YXdjSmZSNUhUQVhCdlRJOTUzN3p3OG1BUnJHbEQzSjFGa3VlR3VpeFhyOFBN?=
 =?utf-8?B?WkhFTnFwUTlBRTFaR1RudFdBakszUzdkVVdtQUx3cm5tK1dwaFhwRXYzVlhn?=
 =?utf-8?B?aWNZY3JjVk43LzAzQ2pzN213bWc1eWl5cUhNWDcwblpsUHc1NldyajA1UWJK?=
 =?utf-8?B?b2FXcGEzUXoveWNvcllhcjd2dUFaWHRwUEJuc3dlN2J6TktMbUhKMHljdERB?=
 =?utf-8?B?TjFRa3F3emtrMGtIK1NVL1MycDlRU2gwQjZWbWY3bDlJdFQ5R0U5YnZqMzJh?=
 =?utf-8?B?QTQxcENuWXFSZmhNajFHdjRnS05pUyt6MGd1SjMyUVdiREg4Snp1UldMMGxs?=
 =?utf-8?B?R2VPU2dZRVkxS3dZTGFDNWlCZmRjd3ZjWExXVzlHMlhYWkhITXQ0ckl5a2tK?=
 =?utf-8?B?YWxVS3VMQXJMOWwxUENxeXc0WWxiNGJQSWZuR2NTL1BocFkyQStML1RDU0hV?=
 =?utf-8?B?SmwvVFlTeG45cmYwZDVNOG5LTGRRTWlGTjF0anJkN2xicno0VzJSM3NQNktI?=
 =?utf-8?B?U3V0ZllWcmN4dEJJbWErZWRQT2ZDUmZHZVNIOHpTZG00VUNTZ09NNlFnZGRu?=
 =?utf-8?B?Zkd1THgwSEdUWk9HWjdBK0dLMUFhUnFCZjMwN3ljRTlNUEhHY1FpQ1gyY3U1?=
 =?utf-8?B?c2YxdnBIVEJMQjcySlFXRWE0aG5LSFBSZlVJNC9IMHRYNi9GdHVaWDN6bmdP?=
 =?utf-8?B?UEk0Uk5OWUg2SWYxZWt1OXcwU1ZiVDIwODNnY1lMNUsrOXJiQnRrSjFvT0xN?=
 =?utf-8?B?QktXQmNsRHNPTGVWcnZBMm5VVWN4NXdNOGVjY082WmhoM3lycFZwL3Y5Sk9p?=
 =?utf-8?B?TTVYUDd0ZGUrZTBNTVNtekV5THN5TkJycGFLUFhJc0N3VHJXM2VGRmdZRlA2?=
 =?utf-8?B?V3pac0M4dENINURCaUQxQ1AvNHdEdllwOU5ydTBmcmlKL2dUU3R3UjJFN0VJ?=
 =?utf-8?B?UG9VNzlRRFE3allvc0NTb3JrMUoyNTdZZERzRisvbXFQbmFhN1RjaDRZM1FK?=
 =?utf-8?B?OGJIOWpUa3pNQXc4ZVh2MUEvRGF4MXZGN2llZVdFTHhhcDBSNUtFa2luT3JO?=
 =?utf-8?B?bVl0OFBsT1o0RnIzR3g4Y2pQbnkyTEpQbVBXd1VTQTRNMElIck9mNnhmR2wx?=
 =?utf-8?B?d3ZBUUEyU3IvWCtsT0tLd2hNRW5HSFc3b3JMcTlkSGxsTlJSWVloSTJ4L3pB?=
 =?utf-8?B?UUVvZjVBOXIrU2tqdDkrNk0yclQ2SnNCS2hpNitSd2dxUWtMd1p4T0YzbjBF?=
 =?utf-8?B?d3NRTnRqRWJHd0FmM0V2NVBsZk1tR01tRTFWQW9sbnNGQ1FEclhsYS9hTFFw?=
 =?utf-8?B?NStrUGdUK1JSWXhaUTlkRlpBck1ENktkemR2Y0ROQTJxazdmU3BrSGdoQjhy?=
 =?utf-8?B?SEd3eUtwSHpYb0RjSWFaelU1dlpTSmtOYTZpZk5DQlZXV29GeGxrRWIwVmhK?=
 =?utf-8?B?OTV5YXRJYVdyaGp0M3ZtVUZwbHM2RStxUDZRVGRLVFM4Y1FBazJaakhXTWJj?=
 =?utf-8?B?TVlQdmliTlBCZUZZTFF6MTQ0eXBHQUhIaVpiMGx4Y0VwaGd2TWFJTlAybkwx?=
 =?utf-8?B?dE5QR1NibFdwNzZrWHBkZ21SZVBOZDNndnpXbms2NFluZzl2V2tRVVB4Z3pL?=
 =?utf-8?B?MlQxckJyMlVlUXdCdTI0THYyMmkzVC9Td0g1TDRLeFJ5TU1nczNQalVSZjZU?=
 =?utf-8?B?aVpXTHdUZE0yM2pqcG5YZnlOL3JmRm5adnQ5T3VIZVJrSm5kaEZWb1c4aHUw?=
 =?utf-8?Q?1GbBvCvsUYLPu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnhEN0wvd3JxVWloZTVjSFlzeDlTdkIxVmRhUi93aGE2OURjNmp0Q0tKRTJ5?=
 =?utf-8?B?MUdJTk55WkdyNFdFTE1lMlhzTjRRNWhLQTZCL1k4cEZxYUdXQVF5aEVYbll3?=
 =?utf-8?B?WmEzbXlrbDhOZTBqQytGVmZXcytTcElhaWN6ZHNRNXdDQmtIdi9XbWsxKyta?=
 =?utf-8?B?N3cyckdmMGdDYzlEa1FIdU9lTkNGR1VBVGJQcTVXeWg1VS9yMzRKTDY4cmRi?=
 =?utf-8?B?QmZTcnlpZVdHSFIzSkl1SUU2Qml1VjM3OEN0Ky9EZ2k3WnRia2RuUmk4SUh0?=
 =?utf-8?B?WXhNaG9UaGMwMjJoYUlQTnNONHFBSCtIem9LTkpHUUx6TWZ4dmpuYStJSWxn?=
 =?utf-8?B?cHlic2d1eUs1cFp6eGtKZnJnM3laWmF4RktCZVBabXJBc1VrcXVOOWJjNjFU?=
 =?utf-8?B?MkhvdmxyUjVyOWNYTW1CZ2lLaUNPRmJObjJ3Z1RZdDByZEVHRFc0eGVOMVFM?=
 =?utf-8?B?VTBhRHlZL3JZNldJQmFwL0tKa3pQVUxQc09zOHhObm9CZ0NzWE12RXNOU2pw?=
 =?utf-8?B?bk5DQXllK0tlcFZyeUxWaVA1WUpnTzRMMFkrZnRQZ3RVTmw2TE83d3FWYmlh?=
 =?utf-8?B?SXhIWUxvZG5oYlduYi9FenlYZVIrRjZBWmh5UCtxUDFhTlBJeS9xb3lSV1RC?=
 =?utf-8?B?UGNZbmFPMWdUQWdTN2Vtd3hDY2krRnBPMUdHSHppTlc4azVWV1p4Z1lLcm8v?=
 =?utf-8?B?RVBmdk9OZDhtbDgyU1NBK3lrRm9ZRTFZUVFUMXhKM3ova1lmTkdTcHBsbTEw?=
 =?utf-8?B?dC9iNjUxdkY2K09NRVBBenQ5VnYrTUNLRTZ1T05ucjBtM0RNNUhidE5GeGE0?=
 =?utf-8?B?b2M0d1o2c2ZyWmQ5ZEJmRXY5ZVRFbXFrL052MStJWnJBNXRnZCt5aHczVjNi?=
 =?utf-8?B?QitCYnhBS1BYTGJLTHFmempVcXRQWmpiNlhZNFJJQlBJYkVlOGpQeVFOai9E?=
 =?utf-8?B?dkdpamFlY3lqS3N4cVpLQlJxN0FJQmRGWXdNc1ovWXFGUUZmOGNWTDhuS0Fi?=
 =?utf-8?B?QXRVU1NLdFozQWFVbG10bzBpcXVES09idzE5UW4vRDFhY3Z6eC9sazhtcEdY?=
 =?utf-8?B?UHdjdFhvS0d5dFNsRXk3eEgrMWxmVWluaStqWWxBVW9LZHlHNGdZUEhZY3dq?=
 =?utf-8?B?cGZlVVpBRjcyd3pJMXVqVjNJUktxY3c0aFBtY3hWUmY0YWdmU0pJRGc3dTY4?=
 =?utf-8?B?eXAvS3c0emR0RlFsZjd4a2wvRzRvakM1R2NHZThicnZkT0tLdkxTRk1vM1Jx?=
 =?utf-8?B?N2U4Vk9UWkwzSGIyQUVuT3pqYXFkcDNaOXBoUnZEQ29ScFV6eUl6c1lBSTRo?=
 =?utf-8?B?MFpZZ0FNZXpBTzNmeDFBaVNPSW5NWlZuWWNMb21MSFo5bTR1OXhLVlQzNVBP?=
 =?utf-8?B?QW85Q1Mxd0hwVFpUZVdlSXcvNVIzRW0wcWxtaWNOUTVsZllUMlVEb1ZBUlBu?=
 =?utf-8?B?bjY0UDB2OVMydHFrNXBrQ0VMemwxN2xlTmhjY2hlQUhyUmExYmF6aUJTVExD?=
 =?utf-8?B?eVpYNVRmNGdrcEhGWEp3TGd3WnRiZEpwOTRXMGZESGFYdnNYRnRrVmhuNFVZ?=
 =?utf-8?B?OEdWZnNOV0lnbjMyWGxaQTFaTGt0ckhoVHUyRlRFYm5ra2VxKzV6bEltcFhq?=
 =?utf-8?B?RUJaQTIrcy9uMkxLVyttY2VhYXFDajNBajNKUWh6WXZPUzhHOE5pRVR5Rnhh?=
 =?utf-8?B?ZXBIVy9QM1MxYXhMUkZmaTQyR2dkTGdyS01MNGtrd2RBc0Q0VUdiam5Va2VH?=
 =?utf-8?B?LzNsblBxWDY2THJ6cUxKdEgyRUxTN3lkR1NhM3ZGN0hnZzZ3V2RUaU5QWWZC?=
 =?utf-8?B?SFRhR20wa2pMTW5pU1o0djVlc0ZzOWx4QkJDb1dSTFppZ3pqbTRkYU81cUlG?=
 =?utf-8?B?MkQ3NDhmeHV0c1VTS1I3Qk5XN2dibGhXbEp0UDVFcWlnOXVZTkp1ek11ZCtX?=
 =?utf-8?B?aC9LRU55N0RGUU9CMVN6SGJKTXpWM29MK2FFd1pUSEd1NGdjUzNQekNLKzJm?=
 =?utf-8?B?M0ZxRkNmN1hJVzcxQW5XRjhlSTBiR3RnWHFJeUQ3MHJCdE16SEdVbU1LM1U4?=
 =?utf-8?B?VzZMSHkwQVgwWEMzeHkzQytTYTFONDZkREZHSjF0WHNlQkI5WW5oa090bDZQ?=
 =?utf-8?B?SzJKSDMxWGh0c0JkbGRXLzIwSUZpc3pIMU81a09TQ3ZoNGVqbzZlUUllM0Jw?=
 =?utf-8?B?d2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d78cde51-9d5c-414d-692c-08dca685048d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 17:22:21.8654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5C8oqvgtwrbe5WCKGa6UKMa1mCfOyd0bm/CXbcIlN4pjSJ6GsAr9T5VIvQJ0vopQ65LtygZNJqUL7tN5lDqz1zMGIx/HvbXK5Yn6lOysFII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8041
X-OriginatorOrg: intel.com



On 7/9/2024 6:53 AM, Kory Maincent wrote:
> Introduce the description of a hwtstamp provider, mainly defined with a
> ptp_clock pointer and a qualifier value.
> 
> Add a hwtstamp provider description within the netdev structure to
> allow saving the hwtstamp we want to use. This prepares for future
> support of an ethtool netlink command to select the desired hwtstamp
> provider. By default, the old API that does not support hwtstamp
> selectability is used, meaning the hwtstamp ptp_clock pointer is unset.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

