Return-Path: <netdev+bounces-198693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B96ADD0A6
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5111B164B01
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 14:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22E42DE202;
	Tue, 17 Jun 2025 14:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GEV32lO5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4F1202996;
	Tue, 17 Jun 2025 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750172147; cv=fail; b=fFj7/H4zikAA5tWG5djab28m5WofIEEXASsQjsx5eYj4Bsuewx5InWCsJ1FmVz811RyQsdBfYlktU5Ixm4r8OnkmcZXN5nZZx4iuSskUKRi63Uxn/Qv/zrIrYfEjkdwY91xDYtFp0eSlmhJ2Bb0LpmDT1WUL6UVsfZ8baxKyH2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750172147; c=relaxed/simple;
	bh=FmEwFeDbMmE55XZUQe50sv8+kk+gNz3H+3ByON8/wo0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ji89n922DmJ8kA3QrffGGE0Aa3F7JYX/Ap+t5ZYJlLu+SpNOg2FDbX+0wgOjES4jh1wxUF78b596rh5GmBeKAoaYe976EjwKNghVHULBpY4ll9QXKXO7l7pv3IA+Z0Rl8t7K7RJJF0Mjyqoz9EVBx5O2r9x/v0CRkpBkKpVOwh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GEV32lO5; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750172146; x=1781708146;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FmEwFeDbMmE55XZUQe50sv8+kk+gNz3H+3ByON8/wo0=;
  b=GEV32lO5BfN+ZU7uju4bg5UeAF8ciat70Scnw1UV4G9isAA+/9PE7Py6
   HWGphPokaQbXKLC/nduAs6PTIHvddkZtl3tTt6aJVxo7koWcuqidZCpGo
   4h39Nr9hpRfAScNrXhBi3SXgZAgoSterLsrE0RHGfzadOGW+7rfJHPLWx
   TVwK2hG8221EAG64t6Bi4NTYL0Hi8EH48W4CYymeV/VDL+ulIuhhkQ0rC
   TToGdAY1cHO0ECb5spTqi/pWiDDK4g4dKjCoC0PsHCIMivDp9yRbHByc2
   m+oAhEtSS5pB0u1TcbbFlMq9QYqcVZS+Yxt7VZ2KC9PIYrxx2D6nnueTh
   w==;
X-CSE-ConnectionGUID: CeJAC7UWSO6iR5V0wQ5KlA==
X-CSE-MsgGUID: bece9gF1RFOedy/CDd/QUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="54971585"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="54971585"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 07:55:45 -0700
X-CSE-ConnectionGUID: PObPSUb9TDSeQXltpKAeqw==
X-CSE-MsgGUID: Gc5kli62T8qgtI3mthSVgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="149696901"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 07:55:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 07:55:44 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 17 Jun 2025 07:55:44 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.54) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 07:55:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dd5NTEAGHfovgPaSFt2FptaHGzO0uKH5vDQuo3jT3rY729dQftQOO3644rviqRfeDFZTqsECFAKcU5XMTmFAquvKyC2/qVApcK57Het+jLOGgJwU/hj8VatC3ac2GMiJ5NFe3QT84m2BgualVf8vBouAIUz3jTakinmY0tq9u5IOjsZ6qf9tSVpY+oP/TB/BABe33/W72zg9KKSPWnFshqbF/xHIjuI+hEQ+vozeLsiwc+JyuBpvjjSXsLvzyucNo8jlIkQAQ+gQTmPa0vPIqiiCwn3um+fllnsPHFq3hH5W+c2t+Ru514u3VRIFMSEK8i8vbizxyDcAdu+s7lEtSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZJZSNS+gixC1BUubSZt8dT4bwmaYPILSOskUWMuWUQ=;
 b=NGh9iK2N3s7ZAvwBHoDoGlrxm8JH4fS37pqotO1NtYjkPAXJ3x0uTz0Er4VlFEj9sdvp0N5ASyFSc4ehVNTg6r4wc0hnreXCKW+GapqgVOCqBwHC6r+ox9lIaL9KgJj6WIBnNhwczBGRQptsZRqS0HzPsYSKpY8MDSj/b1SqYf1tzrfonnXQyjxq3X+s4tGWxKSYxoBb8rXYlg19nmKTf+LbJPrhsjNnW4CGYpUKu/MaNXsuwLkFz6cDaRdPgbmZ2enQ9ltDHuDS7xz5jAUQIze6o8YQpWDmnUV4r4UirMpDKYuR32m9tVxA6TeB4W5/OtXLCuZbGRVrT1FgbaHe9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CY5PR11MB6257.namprd11.prod.outlook.com (2603:10b6:930:26::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 14:55:26 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%3]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 14:55:26 +0000
Message-ID: <b6687ad2-1fd9-4cb5-8f5d-8c203599f002@intel.com>
Date: Tue, 17 Jun 2025 16:55:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 03/10] net: fec: add missing header files
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, "Clark
 Wang" <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, <imx@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel@pengutronix.de>, Frank Li
	<Frank.Li@nxp.com>, Andrew Lunn <andrew@lunn.ch>
References: <20250617-fec-cleanups-v3-0-a57bfb38993f@pengutronix.de>
 <20250617-fec-cleanups-v3-3-a57bfb38993f@pengutronix.de>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250617-fec-cleanups-v3-3-a57bfb38993f@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0289.eurprd07.prod.outlook.com
 (2603:10a6:800:130::17) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CY5PR11MB6257:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bc9a67e-0a94-4783-132a-08ddadaefe7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVduZHA4RVkwUCtsUnJsaHJ6NklEcVhKcDVCY0hCNmJYckp4SDJFZjQ2bkd3?=
 =?utf-8?B?NEZZSXNHaUtQK2VyQWtmUWprYmVXYWhjVzVIVmRUTS8xazZpZVJFaHJaVVpH?=
 =?utf-8?B?NE1aMmV2ajBiNDcvaXd5clVLYVU0TEl4VXNKNUJVaVIwVWFoekJ4ZmdVd1pz?=
 =?utf-8?B?NmJUaG5USG1rc1c2OU9KaC9mcWM2NVd3N2pFL3IxdWdPZWJ5dmVaaWF5Unlq?=
 =?utf-8?B?dTdNZHZtYndXN2tKTStVRUNzUnU4STg4dUtRUUJpWHFLUVBPb2UxMk5neVVv?=
 =?utf-8?B?c2F0TkEyeDEzUzUxZ2Y1NDVBZy9hU2pkaTIxUVVoclJrK0ZHaUVrZ2N2bUtL?=
 =?utf-8?B?cy9KRmxKbDZaWEZ5Y0V0bzRsQmlwZnNJTyszd2pLM2s0SjBydVlNcDBqbjdB?=
 =?utf-8?B?Q0ZweVE4elNMWUlwQWd2YVg2NVBocHlEaDRXMmJGbzllRnp5VXhkMERFODFs?=
 =?utf-8?B?aDIwQUVLNnpyRm5qRGNzOWg3dElvaUFBWkt6SGorREdOY3NWRHpXeGFHTUoy?=
 =?utf-8?B?YjNnUU1XNjlxc09QV0JVeFVsZnJ4QVZpL3VEWWdjREdWWS81RWhDSk5xbUts?=
 =?utf-8?B?RFliTUxsVkkyTlIwU1FVMVhhc1BwcTQ2UGxLNk9sWElFVTV4dTFRZmViSW4r?=
 =?utf-8?B?cTlZNG1vUXFlVHRsVHN6R25tbmtWK2pPYzl2eWdHTHdBZ2d0SmoraFFZU3FU?=
 =?utf-8?B?cmVDM3FPblpJK3JUL1RMRHVqbnNzMHh4Y1Zva3BIRWJ1K1k2Ry9YOG5lRXR1?=
 =?utf-8?B?eXZ2VG8rd1FaT0pPYjMxc3Rzc3AzWkQ5dHIvQ0tkaWgraFVJY2FXdHBVeHBP?=
 =?utf-8?B?cVM5bS94Z2lvTnV0TUR6MEFGSUUzNDJmQjE2dC8rak96UlBySnZkMnkwNWRB?=
 =?utf-8?B?WDlTYWdEMGZmR0NhZWNxS1d0U3Vqckx0NisyR0IvM1hUbkh3WE1HV1RpV3g2?=
 =?utf-8?B?WUgwU3JUZCtzeE5Dek1mZktvUE1CVyttTUJkTGhuRktaYzV4L3FKVlVYOTMv?=
 =?utf-8?B?NlZ6eWRkbFg3VkxBdEhuNUNzRTNMbEEvNWh6UDQ3TzdRUlUrV2hUWnVlQlNH?=
 =?utf-8?B?N1FiRlQ2dFIxOTZ2a0ZReE1GQmcxVzZZNzFNU2VxbmpjZUEzbFZNd01hVExs?=
 =?utf-8?B?NFg5Z1llZ3J6dDljN1ZPNWVjSEVHQTVqOTA3SjdUbXlJUXJTWTZ1QTk0ZWdm?=
 =?utf-8?B?MzFjdXBpeU5yRldBMWp0cW40YWZab1hxRVZheGhQc1RCeXFqVDhHZnlmTlps?=
 =?utf-8?B?b3A3MVRKZ1BSSE04bGhtTTFCYnZuN2E3S3BoeG44djVMelViRjJhdXVyaEhw?=
 =?utf-8?B?U2ZaNjhnQlJUT2V1eXBIN2x1d2VibzBiODZ3eXRGWUJBK1VhaTVUVUhwS0Ir?=
 =?utf-8?B?SVI1dlA2ZjBaVG9NelZ1UkNxa0x4dXRobHFGSkRYc1ZORWJZd0RMU1MyTDBK?=
 =?utf-8?B?dko4Z3JOVERvWGJWYVFwSXY1R2lRQU00bXZpcjcrYnROZ0ErN1NhSlFNM1lB?=
 =?utf-8?B?Y1BMcm5idk52K0kvdDQxbDRybC9CdENFSHhPbXR5b2FDYnhFaEVyOUpsVUor?=
 =?utf-8?B?aWNlQkRjQnJDQXkzdjdOUTRJd0lXM2pJWGVtWE1hWDNrTU0yRUdQcEREZTJy?=
 =?utf-8?B?bkdMWXF4aWRGb2FBcnZVTld0cnlySkZ6T2dkWXZ4aE1KcGlyeUxTVVhtZ3NO?=
 =?utf-8?B?MmFWVDVVdHdhaEZMcXMxYkhBVWtlYmFtMXFFNWJTbWY3dGZFQlZGaXlsZmFB?=
 =?utf-8?B?bysvZTNQS0Q0S3J0dStBSWlZdUNsd1c1RjM2blQ1QTFIWjdZOG1HdHpQTVZK?=
 =?utf-8?B?N3I5dUE3WThja2M2YUN1T3Mra1NjTER3aThublJlSWUwbHRWT29DenBDOXQ4?=
 =?utf-8?B?UDVoZ3ZUWXdaT0FjamdJS21WMjRPVVdqYTcvY0tWcldQbHFTR01ZZHVaa1Jr?=
 =?utf-8?Q?51KH6z/DWv4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzRmUzdhdllBL0NzWHZ5dnNWZjRLbXYxaDVWQ2ZnbHJaUy80SlFpVUFqbXRk?=
 =?utf-8?B?TVhHZzZXc3NkejFRSXZ0RGE5c0RGNVNDM3FyaEJPeGdSV3pVK05jcGtPdk9L?=
 =?utf-8?B?N0R3VTVuelUwaVpuOVJ4ZFJtaU1hT1ljK1RYcXNkWDlVdmVDdnRiMjY3VnBq?=
 =?utf-8?B?UEE4UWtzTXhiVVZ4bG1lbkExNXlkeUpNblk1ckN3WHMzV3ZQc28yZGtIUWk2?=
 =?utf-8?B?ZWlldm91Tm1JMUU4OVBjYXkvZERWS3Q5c3dFUGZCRFN4ZUpQZHVwV0tCQ3U4?=
 =?utf-8?B?bkFOUjBVVDFUcDlkZkgxZldJMmtKZ1ZFb08ybnZaWGJBakZITEp1c3hlOUdL?=
 =?utf-8?B?eFdGQXNzRWZwN0lheDN4SWRFc3FYT1M0aHdMcXZkaVc2QStKZ29GSW1uaVpY?=
 =?utf-8?B?aGY1SHlqeWlEUWpvakFlVlVLUWhzYnZxL3ArcDhROENKSEp2SzY2YnYzbEhr?=
 =?utf-8?B?TDVmMnBRa1FtZzVacUpOb3Y5MXFIMmpEcnVhVnVsMWpJZlRNZjZjSTN2eGlR?=
 =?utf-8?B?anROdXZ4NzlkR29VZjc2cyt3Nm5kL1BWU2tGUGEvU0VXWmxjSHpPWWRoUHBp?=
 =?utf-8?B?YndKOVVjWGRFUWd3VGVYRlJzcDllVW5NL21pTG1EYkgxQlJjVjVIWG8rZUE4?=
 =?utf-8?B?Q1YxZjRUWW5pSzNyWGJtWE96WmZDazFXRDFwWk1QYlhlc1ZSTGFoU0tIcVBq?=
 =?utf-8?B?RWhKQkZhMTFRWll1RFltT1dqQUFtSnJWY1NJRkFNRTdSRXZ0RWVMQ2hqN3d6?=
 =?utf-8?B?ekpQOU03V29tWHBqeEhDZnNzQTFNamQzcFA3UXM3cUR6VUsrVStycXNDa2Z2?=
 =?utf-8?B?eStsQmhzcVE3SWs5cDRnaGtxNnF2MEZCY0hVR1RSVFpWWmRNVng5OHZhYzc2?=
 =?utf-8?B?OGUxZGQyN1BaNG9ldHp1enhQRTkrMWVaTm45L0haV1pvSmJydVVGMzFTWUlt?=
 =?utf-8?B?Z01vTFpRTVRoWnhuNDdyR1ZRNlpiY2w1U3JzTnlzUGZvZVNCYVFHWXk3QnNY?=
 =?utf-8?B?Y0xMS2JjSE9hdVBBaVFTajBaWVJFWjZwc016bDlMcFlaUERxQ0tTTndpQ2hQ?=
 =?utf-8?B?aDdBSFFHRHNUb1ZuTnVoOGtDdXlybWphb1NEbEpBZjd3SlR1ODgvUWFWT0h2?=
 =?utf-8?B?dzJHbVkyWm5td3pMTE1pYngzL09pUm9sazlGZGx4UTI4NWJEYzFrc2NoRmY0?=
 =?utf-8?B?MHl0Rlo1bi8rYUVHb1daMzVVSExRRWZhZUprdDh6ZUJQdE8xMEtsZk55NTZT?=
 =?utf-8?B?UGRZeEZxQm9BZW9IL0Z6L0pnYURXeXdIZkx2SzBHbjk4UDA3WTRLNHpZUW9a?=
 =?utf-8?B?VHJBOEovaWhNeVNYR1Y2eWdqY25UUy80M3JDQ0JZN2dablJlUnFGU2Z0eUZH?=
 =?utf-8?B?OVR3TVVjZG51dWxZaXY0MUNLM1g2S0pMN2FtbTlTc2krVTVuWmZtbHpTeVN4?=
 =?utf-8?B?MnpSU055RE0vVm1BOWxPY3dYSVdBb0hobFVwUEdtbkt1MCtwV2lHcWxyM1o1?=
 =?utf-8?B?OUhDQWhrTWVWSlRvd2g3NGNMU3ZiaHFtWGVhNk80enZWczdsbjlTMVJaLzd5?=
 =?utf-8?B?dHNFclBYcWZQTjIwMUhVU1AyazBpZ1FGTlUxOEs0MXNBYVRPbUV1Q3hyWFRD?=
 =?utf-8?B?elpvUm95ZjIzRFFuQ1Y2ZWVKN2o5Um01MGhQNDhPNWY5TjhWRVNDQzI3Nm9i?=
 =?utf-8?B?Wi9hYzJaNi84TmlBNHNuVlZSRlNFeFNPbnI2bkxjM2VXZDlxbE5ndUdjSlF1?=
 =?utf-8?B?OTUrUWQ2WWZiRExlUkJVM1ZTdXNXalBaSVBIQThSS3lJY2djc2p2WFg4SjlX?=
 =?utf-8?B?L1cxWU1vbm8rdmR0bEVBSGFxd3hNb3RxZUxWSlZlQllPcmhDSUlmbUE3bXcv?=
 =?utf-8?B?OEZrSXZ2MzNWTFBodzEwWFh2SEdaa21JTmNSN0xOWmdxUTE2SXBNQ2t0aWxv?=
 =?utf-8?B?TUZUYjJ4WEpLZVkxOWdtcjZ2cGt0STFnM0MremtQS25PT1NsVU9kMDFHeGp0?=
 =?utf-8?B?RGZrSHk5dmMwS05yRWJERTZlS2syNFk1RU8vTVo2Z0xYbnRUZmlUWmNsYjJr?=
 =?utf-8?B?YjlHQjlBSEVrMlptWllwWGhSSWVRUEVBQ2hLd3dBQmZQNFBoR2I2bUJTSy9x?=
 =?utf-8?B?UEM5SHZFWU9QMWtzTjBTaG52QkxIYmJVQjJYU0ZrQm1jckp2VFNReW9tM1U4?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc9a67e-0a94-4783-132a-08ddadaefe7e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 14:55:26.4818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJZiu462ItKzZjkP+fIaIb1iFtonaZDMTg6fgShH9fKrcT9iLaJLiaKXnPwT8rNy6StBU2YFF0g/3eg22+WttH26VzH42DO0JcAyRCnPU1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6257
X-OriginatorOrg: intel.com

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 17 Jun 2025 15:24:53 +0200

> The fec.h isn't self contained. Add missing header files, so that it can be
> parsed by language servers without errors.
> 
> Reviewed-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/ethernet/freescale/fec.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
> index ce1e4fe4d492..4098d439a6ff 100644
> --- a/drivers/net/ethernet/freescale/fec.h
> +++ b/drivers/net/ethernet/freescale/fec.h
> @@ -15,7 +15,9 @@
>  /****************************************************************************/
>  
>  #include <linux/clocksource.h>
> +#include <linux/ethtool.h>
>  #include <linux/net_tstamp.h>
> +#include <linux/phy.h>
>  #include <linux/pm_qos.h>
>  #include <linux/bpf.h>
>  #include <linux/ptp_clock_kernel.h>

Sort alphabetically while at it? You'd only need to move bpf.h AFAICS.

Thanks,
Olek

