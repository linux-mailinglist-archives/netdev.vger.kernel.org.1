Return-Path: <netdev+bounces-184910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3E7A97AF2
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 01:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B85187A1644
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 23:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7FB8632B;
	Tue, 22 Apr 2025 23:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="icfr9HGP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F666184F
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 23:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745363748; cv=fail; b=jJ4jUOkdpbo1d8Yfytz2O2yv3xNnPPGFQTSL8vxS2hmyETDazG41uzGK8dstvoNkAaGHYVXVyuI3K3ttXJMqfJ/mBLwDL6lVN3WKJv7EXvZOgtZOxbJsuWsxuJY7xodeDQoorhCzZgCSb5lpC0j11gHALPrV+xF902zbW2b1mQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745363748; c=relaxed/simple;
	bh=0/lHWpnO8aAygSPANa+KJ+3XW/GHHmpaHC0tcff11lY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UIBZatIaIsWHiTaP/3BQjTFR/9lxfLCRMoJ5zViYHrtUmiQM0jagnhVXGu6WJI8tBUNp8KfjSLmitOX8kyJnF8fATgc3v+SW5Dyqs/TCTtrDEGaGEEkEcVssuEoLu9/DV9+ArRAktLXsNFngXyvOUt+FkGh8iy4TXRhuq14gGmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=icfr9HGP; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745363746; x=1776899746;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0/lHWpnO8aAygSPANa+KJ+3XW/GHHmpaHC0tcff11lY=;
  b=icfr9HGPFM3XVbcBLHBpYz/QHm1ai4oSKezLLbXwy+tB4ehegvomQwd1
   +oEx7xoM6Do5zkdTr9rcx1xQFp8E6m4GQqAOKdEh886PttYsvvdnOfq4q
   RxKFArQY3oq0RCQBTUhV4OgJedFRPayeCrZui0Zv9f5zyo4/Fk30kEfN8
   PA4Q/zS27vCvj/6E3MI2ZJZEctZJA4lcHMU9/rfJshBKPv3dabpZyMNNx
   Hgt0/FkzYh204WBpbC7dKcDjo73ibmXQgkvCP0NRsW26DM5we2mi3M+B0
   fiJJ4tvcJUHJngRh6tkhWJnUgt4r3fEfqabzHnPOu70K108redrmFh1p+
   g==;
X-CSE-ConnectionGUID: AeKgMkk3Q5eGOM35EuWQLw==
X-CSE-MsgGUID: K8nlZRw5SFigHQpaQ0g7lQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46177617"
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="46177617"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 16:15:43 -0700
X-CSE-ConnectionGUID: 1upvBvqGTZC+dn7XAOy9Rw==
X-CSE-MsgGUID: QeEjg3bwRc24fu6b2GXuSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="133024132"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 16:15:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 22 Apr 2025 16:15:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 22 Apr 2025 16:15:38 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 22 Apr 2025 16:15:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=diXjDLuSRphfpcedyaV573RmDkNWzr3ArZDTjf8WB3b/kfLSayNKuIDha8VYtug/NLTmeWoDKBRbtu9tNlPHsc92A6D3NQWMBirElGJCG/3ZzSdEaTWXYA2GJrbKaCEbVdsfX8fOvdtSvY2PkytHoDU0xPN925kswcU6ooOam7w5/H6qhjUVmUjC6ysy9Ana+D0mslaz3PT8LPO5P9pn7krtCApZf573hqXs954nJTTWPa3u7N2y16XzcXLxZilYSpJtLEiFZO4Y/TdOqYXZEC3VkSmH6IQBtcED+YkwdMTkLPyQynEcBMmZSZHvtlbZY0xMwLiGH+R8Heb6iEgjSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dCzDtJ2sWOaDdHIlOED2ZK23QZBdU3N3+CStxZlMfM=;
 b=RLw6NDeywVaAWX3tLfFhY6dmcU+lR2YChTLiOvPHG0m/JgKXs0Puk04dd+xn6qygRfcCkwu1jgcjNnqgUd9hu5m3777lMS+cxFrN8wHl1jh5kgkFTBIrnYBIdxxVLl8mZ+x7eShuJ6+Kq29NFhyrMUzT2arqvQq0Zez/0X0O/C10v/eWD/FBo3lXJmCmmeYVmMZV5LsnXLjBtbiGg/rP0MLSItZylAhPHFLVp3JTUv+WsDWYE467jkDE5yxqgNzQ7BUJb9RdOMMy6GsRupdIULhKb/4RKFHiZHeQpvgWzjKzOIs61N5/joJ90XA7CqIwGNehQqNTlLVOWskfopgkvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5042.namprd11.prod.outlook.com (2603:10b6:303:99::14)
 by IA1PR11MB7294.namprd11.prod.outlook.com (2603:10b6:208:429::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Tue, 22 Apr
 2025 23:15:35 +0000
Received: from CO1PR11MB5042.namprd11.prod.outlook.com
 ([fe80::9b:7c08:c7d5:a021]) by CO1PR11MB5042.namprd11.prod.outlook.com
 ([fe80::9b:7c08:c7d5:a021%3]) with mapi id 15.20.8632.025; Tue, 22 Apr 2025
 23:15:35 +0000
Message-ID: <8ffa3734-e3eb-4a07-ab7c-3e227c34044e@intel.com>
Date: Tue, 22 Apr 2025 16:15:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] idpf: fix offloads support for encapsulated
 packets
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Dumazet, Eric" <edumazet@google.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "willemb@google.com" <willemb@google.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, Zachary Goldstein <zachmgoldstein@google.com>,
	"Salin, Samuel" <samuel.salin@intel.com>
References: <20250422214822.882674-1-anthony.l.nguyen@intel.com>
 <20250422214822.882674-4-anthony.l.nguyen@intel.com>
 <68081e80888e6_3d8ff0294f9@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: "Chittim, Madhu" <madhu.chittim@intel.com>
In-Reply-To: <68081e80888e6_3d8ff0294f9@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0020.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::25) To CO1PR11MB5042.namprd11.prod.outlook.com
 (2603:10b6:303:99::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5042:EE_|IA1PR11MB7294:EE_
X-MS-Office365-Filtering-Correlation-Id: 63b21ea7-7eca-438b-6610-08dd81f395b3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bU93bWJLR3JxYnF1Mk5QVkt6bE14Z3U5QjQrbzhhOVVTVGNVd2JHckxkK0M1?=
 =?utf-8?B?aHk2ZDVqUGtiZDd5VXhhSlRMMkhtdzBhYnVXSEpnVjZXN2dQZVJNRHltU0Qy?=
 =?utf-8?B?N3pXUE5VVUNpUjlvdUhpaUNqWHR4TC81MGVGVk53TkZ3dndLbjFwMm5mR1Rh?=
 =?utf-8?B?QzUzOUxHQXFKTHY4bzBuZS9nRjFEQ01BVnBjd2Q3NytRb1BKVHo5eWtJbVpm?=
 =?utf-8?B?M3FVdHFmcGs2RkFzYzRIVTB1VGtRa0xPOU9OTjgya3ZSS3RqOHBjcnV0bkc3?=
 =?utf-8?B?RkN5OXd5cndsOEZZS0VwN0t6VkFjL1kyeEFjRUlIY1VzS294Z3I1RFo3SHl6?=
 =?utf-8?B?V1Nkc3JxUzZVYjZuQnBVcHdGRHZQYXhaSUh4UEo5RjRUbHNIWHkvQ0JTd2xx?=
 =?utf-8?B?d2x6a2UvTzllcDE1dHNpMnRjRHltYm9Va0didnJuWjArUEtCR3NFRERmZTJJ?=
 =?utf-8?B?T0lCRXp4MW4ydDBiTkhnUDlMVFU5NDlNR29WRXpibk5pOUhuRVJSS2REQnRJ?=
 =?utf-8?B?eDdXRGlkMWNwdEJhZzJaQWtMNGlFVkJNZmNrcWxycEtwZDhJYkhsSkJOcXNX?=
 =?utf-8?B?M1VCMmovRzZiaTF1QWJqTGpsb3Z1VUdQdTZZek56RStJQjV4Q2V4akoreG9z?=
 =?utf-8?B?eHFIUU1OZGpvS2hCRDVzWWZ3UCs4SUFXV3VFSzhXSE01amliQldrNnVtU3dV?=
 =?utf-8?B?YnBIdTg0MFUyZlByNGxKc0VFb3M3WE1FQ2cxeXEvS2lFY1lUYWxPZzFmQUxI?=
 =?utf-8?B?aGVuT0VYczBITGZRNUE5OTFtVnFCcWI2Szc2d0ZxYUtDSVhtSTQ1Y3pYZWkz?=
 =?utf-8?B?d0JSc2ZESTA0SXhPcjBZL2ozMGsxNmNBdEo1WXRzeUNTdG1RYmMxekVXSExG?=
 =?utf-8?B?WHpUY3I3bjdkdC91WGZNb0t3STh3Wm1JajdNUUJQSVZtZHZ5UHU0UkZTMFJ1?=
 =?utf-8?B?WTZ4dVdDcXNnWmFWZXp6bm5INjJ4OVIvek51eEpVbWNiUk1KUi94VmlhY0NL?=
 =?utf-8?B?d1ZETDBNTVlDUEoweU1xVEk4NEtpVHBLaFN6SnNSV3pmZU5KdWNjdjBNVTdt?=
 =?utf-8?B?d3BUK1h0VlpKUlB0TnhDdFo3VmV5THFUV3hJeDA4eVR5aC9xNFR5QUt6Tno5?=
 =?utf-8?B?MkNRS3VYYytWWXMxWkp4aTRnU2JTUlA5b2FtYmNxck5LZzhaa1dKVThTYWNp?=
 =?utf-8?B?WE1Bc0RmekMrNVp2aFh4UlhnQmgxbmV6VytqTzMwY1lWL1V4c25wUit2YUcx?=
 =?utf-8?B?bGFpRnVpUmg1SkR2eHM4R0dKZUlLeXUxak5aLzhYNmg2SmRtRWM4N3N2OEE0?=
 =?utf-8?B?dzhnRkFuYk1hVExzeHA3ODFVU1NiU3VIY0g5eGxZV1cyTU1yYlB2WlFjL2Rn?=
 =?utf-8?B?ODF5L3BIaHJXWmlleW9XYVU0VFBDN2J1SndwUTRlWUFZSzRVVUZQNi8rZXdn?=
 =?utf-8?B?YmJzcERtNnJhNTNWQXIwK3g3RlpWdFNxamg0ekEyNzVIL2Myc05xSmMzYnlE?=
 =?utf-8?B?aWg4SUlOVmlmcDdNTk1HQ2EyMDhUU29yeDVSQlFGQkRiZklZNEZhWDNyS2hG?=
 =?utf-8?B?WExxQmlIUkE5WUxpNzB0ZnI0VC9ESlFWVmM1OTFKZjJRL2JmUUFuczBZVWJM?=
 =?utf-8?B?TVQ0T3lPWmNTWnYxazNMRFAySWoyYWcveUVXWjBJWjlLdEtqcklGa0tYN1gx?=
 =?utf-8?B?YUh0Ull1cFFtWWpGSW1KSzE3eUdrcjg4dXFiNklwc0ZNKzdEa0ZoRVNUZlZB?=
 =?utf-8?B?dlh2UmliM1lNNU9FaEErZzh2ZkdSTW1zc0lWTDFQZ0ZKZmtMd2tVMHYySDJC?=
 =?utf-8?B?bVlDYXgrYStSbmI3OWxhZTM4WFF0b3VBZXgvTENGZVliZFZJTlZLUS96cE9S?=
 =?utf-8?B?c3EyYUM3RG84YTVHRVI3dkl0SFEwWkxNSmdUNmQyYVBTUDh3OThxTWtoQkpC?=
 =?utf-8?B?MVNvY0ZVelpGQzNIUkJOdzE5L2VlNUpZNVhZUkx3eVp3QXpzMC9iS2Vldkhq?=
 =?utf-8?B?MGMvbXh0VElnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5042.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akdCVDhXdU5oRnYrbDdvcC91cE85YmFTM1FzNHlXemY5WUp6dkY0V0htMEw5?=
 =?utf-8?B?dWFUSWZlbGNLL3pwTU9LMGhOeWdJdUIzajNBemhkMXJuek9pZ2RtNlg1bmlS?=
 =?utf-8?B?djhjazdpU2ZPNXJHSUFmMzBOcndDS2VOS1czT2wzLzlEVjNMNFF0VGpVMmhi?=
 =?utf-8?B?WkRxQ0tCazJyYVpQNTVnWVNjakxVU0x5d2NPNVI0bEhLUzBpUFhBVHJnM0tK?=
 =?utf-8?B?N0N1ZnpKdFVkRDlVcHMvTTliTG81b1F4YlR0aTRjVWhsSXVjbWdIZ1pWRlYv?=
 =?utf-8?B?UEx5K1RtRXk5SmhWTGpyeCtDV05ibEo2a25aUTg4TFdjL0t1bENHR0l4S1dU?=
 =?utf-8?B?NXRYdXY1RzVqVkNUeFZJcDdPaWlMY2ZpYXQ4Z09TcEZsRU1qMnR2Rnl3RVpR?=
 =?utf-8?B?N0N3bXdKQndXS293dnY1U05TY09NRXVlaEhDdktQZDA5RENIbHhxT2VDZHJh?=
 =?utf-8?B?SWlPdUg4L3ZhZDhkeHphQzdOVm84T0FTb1FFVTdydnFqdFNJZU9wSDdQODFz?=
 =?utf-8?B?QWVGRTQyQ0ozMmd5OVJoUGRuTjJhY2xTTWJjaFVwaC8xVHV5M2RPSjd3eGdX?=
 =?utf-8?B?UFB5S25HK1R3ZCtReUR6K3hnM002aEtLb2tsWkliWkhabVJjczJ0dzBsWUlx?=
 =?utf-8?B?cVg0U2lMNG9TMXhIY3VGZ2ZoaW1idUNEUGJJakcxSENIRTJiYlVGaHROZlds?=
 =?utf-8?B?SVU5M2F6R21SY29MUGdtTFZFN1F4dUMzZ2pkN3FVMVVBOWs3N05Qd2JpenNi?=
 =?utf-8?B?UmVYK2JSdk5IUDcvMHRXWkFKRWNzcG5TcGR0VXB5ZXJVNzkwZGw4bHMrY0JI?=
 =?utf-8?B?VHQ2c29xajN4ejF1WU9zVjZ1Y3BuZGNESVBtR09FYkYwY3VlODYxdEtWb3Ft?=
 =?utf-8?B?VURqZXdnV0h0cjZ4YVVOYW5HUklGWFJNZDZsOWZpWGd1dkVVeng2MVhTdlBh?=
 =?utf-8?B?NVVoSlEzeEJKcUYzYjExUkt5YmpGTUlNUXFod2JmM21oekZwbFl1cDJvRXRM?=
 =?utf-8?B?U05HKzJGK2VFUW1vZ05XZU1HalJGYkVIQ2lOOWxGWEVXN1cwQVIyb2lFNWVN?=
 =?utf-8?B?TDhqSG1HR3kxYWx0L24vWklxdkhqaHdQZDU1b3ZGMnBOd1VQRmZWVlM0U3NN?=
 =?utf-8?B?L0JXSFJ6dVZWOW5LazN3Z3N4RzhvSzl4T0c0N2J1WXp2dzR2d2M1TExiTkxp?=
 =?utf-8?B?ZTAzTXpKREhaRVl0OHlibDNrN0RlaU9hQm9WY002ajFwMFhZSll1SWM2eFd1?=
 =?utf-8?B?eTNHR1NQdFVqLzY5dy92ekFKekdmb0ZmNU9HQjI3V2dsQnEwOEpHU0pWQlBR?=
 =?utf-8?B?M2VMNmVkTHlCMXhLNGttc2o1OXFOcWc4cGpKSHpuQmx3NmsyeTF0OVJQcHZR?=
 =?utf-8?B?RTRNa2JGRFpmZGQzODdPTFdRV1F3bUxJNDZieW5wek5WUmhZSktSWTJwTEpy?=
 =?utf-8?B?dkJ2akpuc045cmloRFYzakZCUGp4ZkdBN1NjVE1mWG9oVXg0RXByRjA4ejlH?=
 =?utf-8?B?ajhBYWdxdzU5Z2JENjN3TnpabCtIamt6SEZyZlpIbTBvWWR2QTRZb0h0ZW43?=
 =?utf-8?B?bWxoTThONGlWbjk5RFI2NW1nR2pFZGNuRlRia29qTjRjZlNySHcyUmZQTjEr?=
 =?utf-8?B?eEFWZkVGY2hqRWUvUkpjdS9OZXoySllsSWJ5cXAwMlhNOUhuc3lRQ0NqbGll?=
 =?utf-8?B?VXhKQnhkMWRPaXdRd2Q3d3dkT3lyMm9mZmt0TC9oOURxcHJSVFhuTHZCcEFm?=
 =?utf-8?B?MjBpMnpPa2dFNGkvWjE3cTd6YTR3eExZWUIyOUpwRlN3eG93QytYekxib2xJ?=
 =?utf-8?B?QStBeWpBdm9QQVpVbjBxOVBCa3h3MzdHZVlNZWdabmFSYUhJYmE0M04xZG9k?=
 =?utf-8?B?SVBZdW1GRHo0ellGbXRpU256YUpGaVpPT0N0Y2NYZVk0L0QzN1VPb2swL2NV?=
 =?utf-8?B?UnlUWkNLeXowdklxcDRibTFZRnh2WjU0U1BoQUJnYVhnTi9OMTF2bVFXQWgz?=
 =?utf-8?B?WmNXWFRJaGFTQkdsNnZiREs2cTVYcWcvekMvZHUyQm1zTGdCR3BISGNFVXhQ?=
 =?utf-8?B?V1o2dVRKclUyUjJmNEpjMjJjS014V2E2Z3M4OUJWVytQcjVHSXdMSWRUQStF?=
 =?utf-8?B?dU9IZkRvUzBwb1VHU1BsME9kTUQ5ZExRWFE2M3NOOE1ndG5FQmlFTm1VZ01R?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b21ea7-7eca-438b-6610-08dd81f395b3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5042.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 23:15:35.1308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qe4goCmYvDBEPLWT2KIzVZ/9qpbEJrbtBruCL4uglFzQPeo7O7XmBw6Z3Q9uxI9cR0CZopdpI/s8KAh01Jh6HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7294
X-OriginatorOrg: intel.com



On 4/22/2025 3:56 PM, Willem de Bruijn wrote:
> Tony Nguyen wrote:
>> From: Madhu Chittim <madhu.chittim@intel.com>
>>
>> Split offloads into csum, tso and other offloads so that tunneled
>> packets do not by default have all the offloads enabled.
>>
>> Stateless offloads for encapsulated packets are not yet supported in
>> firmware/software but in the driver we were setting the features same as
>> non encapsulated features.
>>
>> Fixed naming to clarify CSUM bits are being checked for Tx.
>>
>> Inherit netdev features to VLAN interfaces as well.
>>
>> Fixes: 0fe45467a104 ("idpf: add create vport and netdev configuration")
>> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>> Signed-off-by: Madhu Chittim <madhu.chittim@intel.com>
>> Tested-by: Zachary Goldstein <zachmgoldstein@google.com>
>> Tested-by: Samuel Salin <Samuel.salin@intel.com>
>> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>> ---
>>   drivers/net/ethernet/intel/idpf/idpf.h     | 14 ++++--
>>   drivers/net/ethernet/intel/idpf/idpf_lib.c | 57 ++++++++--------------
>>   2 files changed, 29 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
>> index 66544faab710..5f73a4cf5161 100644
>> --- a/drivers/net/ethernet/intel/idpf/idpf.h
>> +++ b/drivers/net/ethernet/intel/idpf/idpf.h
>> @@ -633,10 +633,18 @@ bool idpf_is_capability_ena(struct idpf_adapter *adapter, bool all,
>>   	VIRTCHNL2_CAP_RX_CSUM_L4_IPV4_TCP	|\
>>   	VIRTCHNL2_CAP_RX_CSUM_L4_IPV4_UDP)
>>   
>> +#define IDPF_CAP_TX_CSUM_L4V4 (\
>> +	VIRTCHNL2_CAP_TX_CSUM_L4_IPV4_TCP	|\
>> +	VIRTCHNL2_CAP_TX_CSUM_L4_IPV4_UDP)
>> +
>>   #define IDPF_CAP_RX_CSUM_L4V6 (\
>>   	VIRTCHNL2_CAP_RX_CSUM_L4_IPV6_TCP	|\
>>   	VIRTCHNL2_CAP_RX_CSUM_L4_IPV6_UDP)
>>   
>> +#define IDPF_CAP_TX_CSUM_L4V6 (\
>> +	VIRTCHNL2_CAP_TX_CSUM_L4_IPV6_TCP	|\
>> +	VIRTCHNL2_CAP_TX_CSUM_L4_IPV6_UDP)
>> +
>>   #define IDPF_CAP_RX_CSUM (\
>>   	VIRTCHNL2_CAP_RX_CSUM_L3_IPV4		|\
>>   	VIRTCHNL2_CAP_RX_CSUM_L4_IPV4_TCP	|\
>> @@ -644,11 +652,9 @@ bool idpf_is_capability_ena(struct idpf_adapter *adapter, bool all,
>>   	VIRTCHNL2_CAP_RX_CSUM_L4_IPV6_TCP	|\
>>   	VIRTCHNL2_CAP_RX_CSUM_L4_IPV6_UDP)
>>   
>> -#define IDPF_CAP_SCTP_CSUM (\
>> +#define IDPF_CAP_TX_SCTP_CSUM (\
>>   	VIRTCHNL2_CAP_TX_CSUM_L4_IPV4_SCTP	|\
>> -	VIRTCHNL2_CAP_TX_CSUM_L4_IPV6_SCTP	|\
>> -	VIRTCHNL2_CAP_RX_CSUM_L4_IPV4_SCTP	|\
>> -	VIRTCHNL2_CAP_RX_CSUM_L4_IPV6_SCTP)
>> +	VIRTCHNL2_CAP_TX_CSUM_L4_IPV6_SCTP)
>>   
>>   #define IDPF_CAP_TUNNEL_TX_CSUM (\
>>   	VIRTCHNL2_CAP_TX_CSUM_L3_SINGLE_TUNNEL	|\
>> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
>> index aa755dedb41d..730a9c7a59f2 100644
>> --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
>> +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
>> @@ -703,8 +703,10 @@ static int idpf_cfg_netdev(struct idpf_vport *vport)
>>   {
>>   	struct idpf_adapter *adapter = vport->adapter;
>>   	struct idpf_vport_config *vport_config;
>> +	netdev_features_t other_offloads = 0;
>> +	netdev_features_t csum_offloads = 0;
>> +	netdev_features_t tso_offloads = 0;
>>   	netdev_features_t dflt_features;
>> -	netdev_features_t offloads = 0;
>>   	struct idpf_netdev_priv *np;
>>   	struct net_device *netdev;
>>   	u16 idx = vport->idx;
>> @@ -766,53 +768,32 @@ static int idpf_cfg_netdev(struct idpf_vport *vport)
>>   
>>   	if (idpf_is_cap_ena_all(adapter, IDPF_RSS_CAPS, IDPF_CAP_RSS))
>>   		dflt_features |= NETIF_F_RXHASH;
>> -	if (idpf_is_cap_ena_all(adapter, IDPF_CSUM_CAPS, IDPF_CAP_RX_CSUM_L4V4))
>> -		dflt_features |= NETIF_F_IP_CSUM;
>> -	if (idpf_is_cap_ena_all(adapter, IDPF_CSUM_CAPS, IDPF_CAP_RX_CSUM_L4V6))
>> -		dflt_features |= NETIF_F_IPV6_CSUM;
> 
> IDPF_CAP_RX_CSUM_L4V4 and IDPF_CAP_RX_CSUM_L4V6 are no longer used
> after this commit, so the definitions (above) should be removed?

Thank you, will fix it in next version.

>> +	if (idpf_is_cap_ena_all(adapter, IDPF_CSUM_CAPS, IDPF_CAP_TX_CSUM_L4V4))
>> +		csum_offloads |= NETIF_F_IP_CSUM;
>> +	if (idpf_is_cap_ena_all(adapter, IDPF_CSUM_CAPS, IDPF_CAP_TX_CSUM_L4V6))
>> +		csum_offloads |= NETIF_F_IPV6_CSUM;
>>   	if (idpf_is_cap_ena(adapter, IDPF_CSUM_CAPS, IDPF_CAP_RX_CSUM))
>> -		dflt_features |= NETIF_F_RXCSUM;
>> -	if (idpf_is_cap_ena_all(adapter, IDPF_CSUM_CAPS, IDPF_CAP_SCTP_CSUM))
>> -		dflt_features |= NETIF_F_SCTP_CRC;
>> +		csum_offloads |= NETIF_F_RXCSUM;
>> +	if (idpf_is_cap_ena_all(adapter, IDPF_CSUM_CAPS, IDPF_CAP_TX_SCTP_CSUM))
>> +		csum_offloads |= NETIF_F_SCTP_CRC;
>>   
>>   	if (idpf_is_cap_ena(adapter, IDPF_SEG_CAPS, VIRTCHNL2_CAP_SEG_IPV4_TCP))
>> -		dflt_features |= NETIF_F_TSO;
>> +		tso_offloads |= NETIF_F_TSO;
>>   	if (idpf_is_cap_ena(adapter, IDPF_SEG_CAPS, VIRTCHNL2_CAP_SEG_IPV6_TCP))
>> -		dflt_features |= NETIF_F_TSO6;
>> +		tso_offloads |= NETIF_F_TSO6;
>>   	if (idpf_is_cap_ena_all(adapter, IDPF_SEG_CAPS,
>>   				VIRTCHNL2_CAP_SEG_IPV4_UDP |
>>   				VIRTCHNL2_CAP_SEG_IPV6_UDP))
>> -		dflt_features |= NETIF_F_GSO_UDP_L4;
>> +		tso_offloads |= NETIF_F_GSO_UDP_L4;
>>   	if (idpf_is_cap_ena_all(adapter, IDPF_RSC_CAPS, IDPF_CAP_RSC))
>> -		offloads |= NETIF_F_GRO_HW;
>> -	/* advertise to stack only if offloads for encapsulated packets is
>> -	 * supported
>> -	 */
>> -	if (idpf_is_cap_ena(vport->adapter, IDPF_SEG_CAPS,
>> -			    VIRTCHNL2_CAP_SEG_TX_SINGLE_TUNNEL)) {
>> -		offloads |= NETIF_F_GSO_UDP_TUNNEL	|
>> -			    NETIF_F_GSO_GRE		|
>> -			    NETIF_F_GSO_GRE_CSUM	|
>> -			    NETIF_F_GSO_PARTIAL		|
>> -			    NETIF_F_GSO_UDP_TUNNEL_CSUM	|
>> -			    NETIF_F_GSO_IPXIP4		|
>> -			    NETIF_F_GSO_IPXIP6		|
>> -			    0;
>> -
>> -		if (!idpf_is_cap_ena_all(vport->adapter, IDPF_CSUM_CAPS,
>> -					 IDPF_CAP_TUNNEL_TX_CSUM))
>> -			netdev->gso_partial_features |=
>> -				NETIF_F_GSO_UDP_TUNNEL_CSUM;
>> -
>> -		netdev->gso_partial_features |= NETIF_F_GSO_GRE_CSUM;
>> -		offloads |= NETIF_F_TSO_MANGLEID;
>> -	}
>> +		other_offloads |= NETIF_F_GRO_HW;
>>   	if (idpf_is_cap_ena(adapter, IDPF_OTHER_CAPS, VIRTCHNL2_CAP_LOOPBACK))
>> -		offloads |= NETIF_F_LOOPBACK;
>> +		other_offloads |= NETIF_F_LOOPBACK;
>>   
>> -	netdev->features |= dflt_features;
>> -	netdev->hw_features |= dflt_features | offloads;
>> -	netdev->hw_enc_features |= dflt_features | offloads;
>> +	netdev->features |= dflt_features | csum_offloads | tso_offloads;
>> +	netdev->hw_features |=  netdev->features | other_offloads;
>> +	netdev->vlan_features |= netdev->features | other_offloads;
>> +	netdev->hw_enc_features |= dflt_features | other_offloads;
>>   	idpf_set_ethtool_ops(netdev);
>>   	netif_set_affinity_auto(netdev);
>>   	SET_NETDEV_DEV(netdev, &adapter->pdev->dev);
>> -- 
>> 2.47.1
>>
> 
> 
> 


