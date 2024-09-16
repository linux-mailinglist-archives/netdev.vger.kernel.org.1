Return-Path: <netdev+bounces-128496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 199AF979E4A
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 11:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CF371C2248E
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 09:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E7614A4D0;
	Mon, 16 Sep 2024 09:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TyJKpGzS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE8B1B85C1;
	Mon, 16 Sep 2024 09:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726478389; cv=fail; b=H+H0CcM3hKNxelzSuHbJLG5fMITRcC3rb08r+fY2LqnzPCmvE2FqftTHtfLrGcqYdvVanvwWcSqVCY6wB/UatFZuZggUyuIJG0EP3StcQrDSltetdWJgaD55g2lNbVycdZPp2ZXsrL+bMARsMa5CJEDSUHVMZ+3as7Bo72vKnlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726478389; c=relaxed/simple;
	bh=pq0ZfQFi9Y+GYN376QWFAV/duOEar7JQiFiWoCASkqk=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SfPWeUMmhVYHsyz/jLhuRKNSRZU32D79+PiIINfhCw4sjhqV/f5i10KYqScDduzmqDJrO3Gfo+4qLyZgV8Dv2dWEvs6hJaXew4pAta3OpGWNeBNY4+tKsKo9+qedC1shTkh4v0lgVT/PRB6JZZMlFUhfHAWDkxjCD7ay2bHpDsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TyJKpGzS; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726478388; x=1758014388;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pq0ZfQFi9Y+GYN376QWFAV/duOEar7JQiFiWoCASkqk=;
  b=TyJKpGzSxR14fMJCVsW2JurPPw3eS2XevKb/vg73QkpReoajYZccxQWF
   yyGcFo5quPfM8EMB1ulp399oNmvfSgMa7bVYlcxV3O2uorzEgpeoRLBgL
   EDpdFdp26aGTEAr+QqnC7Ut23kMo+vAUG/Bjt/BW/IHdMMIdvo/0NDVjk
   q8jgpLlLlSJEhO7MhDOlwWYlBRMmNHTvWqepUyyhIPYxFCfR6GMNxJcTT
   DDVPNOv0BBb0e9rIRBD3tJ0UduEfZB0RTN6r4dFaR0WY+2c009/E/7TFY
   E90dJXPBJgmyC+Ca5S1vb6uJ3mt87RENGr7j10SBmixd2Wb+erpSNr6hx
   w==;
X-CSE-ConnectionGUID: WaHrddeeQjaVr0wDKTvaow==
X-CSE-MsgGUID: fNiTWU6kR5qW+Q8/gHmCdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11196"; a="25179357"
X-IronPort-AV: E=Sophos;i="6.10,232,1719903600"; 
   d="scan'208";a="25179357"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 02:19:41 -0700
X-CSE-ConnectionGUID: W6HP+sezQ9SbQgI1NZWJPg==
X-CSE-MsgGUID: psHHkxbEQzqqS76gxw85CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,232,1719903600"; 
   d="scan'208";a="69313603"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Sep 2024 02:19:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Sep 2024 02:19:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Sep 2024 02:19:41 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 02:19:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ViNokf4IiJqvRvjerh6m6KbNyX1/OF+CeNTUCbmlFaxqMJSIQNs5crwxPcilMqWz2X5TFjlJbN7dJiHQovRl7U6U3BGtLxtwUuEZnP6p/jTmVkJVOa1kSlb8lZBTPZnP8ygxlvNr6RQJF9uLZLYAwBExfOyl6CH6Yen//FzYvDMd+bc0F3LzJe+V8ZfCnf6i5OC9wPdaaGi1ZNChn+16rNR1mJmbLOMppPBbtNoWHgu24iNpR6NkeNJn75uARdGZjkVzVN2gbSoFBacZ0pgO+L7wBVn+meGqKeBPIHGiZt3QLam1W09Po2HqVm/JZTLjxaHPYTWcVTvL8ZpavfEzEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCJriLAo46ftD9DcnuCd+TWRGA5UOjMq0c4+kUi06po=;
 b=YlmxWERNzmdadGzidvL/qwF4qOc/tlg1IIkbAs60QawG/q4wyx2Z01uU4wf6uIkoqTCtbTFpYKWjBlCu6MIYgeSTbTzWT8qNJAgETbIyTBFD+rDChpfraO0xOdwyW7ppByLEGeL0omdnVUHRE7SuIJ+RyqfsuC91kSwpsN8rg67dbJhyxqqFzMStmG7/BNCf2BBj/xh6CN6uIvxxE+ZZWZqDSBZjGl0YWXcuskaBuYK5XuIR/1LE3LqW68M088wNJmwulrMwJTGbEX2mXqDluPnW2xqE5zk0qhjnhcIWhm5zAvijkpoLnjR9Yv1NjLUI4QGtbxY61OSFwG+NQt/N/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA0PR11MB4574.namprd11.prod.outlook.com (2603:10b6:806:71::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 09:19:37 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 09:19:37 +0000
Message-ID: <b7dabc2d-19a4-42f4-ba5c-31e1803d821a@intel.com>
Date: Mon, 16 Sep 2024 11:19:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] Is this an out-of-bounds issue?
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: Qianqiang Liu <qianqiang.liu@163.com>, Ahmed Zaki <ahmed.zaki@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <anthony.l.nguyen@intel.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
References: <ZuQ6aCn7QlVymj62@iZbp1asjb3cy8ks0srf007Z>
 <c9c582a2-2d72-4258-ad67-8d159cf256d6@intel.com>
Content-Language: en-US
In-Reply-To: <c9c582a2-2d72-4258-ad67-8d159cf256d6@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI2P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::13) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA0PR11MB4574:EE_
X-MS-Office365-Filtering-Correlation-Id: b259baa0-804a-4da0-0137-08dcd630af13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dllTWkhqWWNjUUZlbE1IdGo0QkQ3TlVkUXZ5bGxqMlE5UHFWVE5oVmtpbXRq?=
 =?utf-8?B?V1Y5TEY3ZXkvcmZOVlBONFpId1c4a2dCZEh1amZTcjFlcVZObzlCaEtUNnZp?=
 =?utf-8?B?TnptTnI2UU51aVlSaGZ1OFdMdHEwQWw5aS9kS1MrSUxhVEY0bis3Z25vUTJw?=
 =?utf-8?B?c25ka0JZNWNGeHl0ZHJRaFk5ZngvRHpzeU5iVWNVMEMxNnoxMnF2VTBEWE4v?=
 =?utf-8?B?bEdmd0dpWVAzSDBjUjBqcTA2S2tEQStEWHAyTUJGeTFNVk5DbHRDbU0vUVY2?=
 =?utf-8?B?a25ORGFWNk5pV3REWllycDFzVFl0UFVGaU1lWmExdnV3aEpSSjEzTlFZVnVK?=
 =?utf-8?B?NS9XSStoaDl0VGpJcFphL21YeTVhMGZJaDNzSjBISG8yWjNGcFlnZDVWcVdn?=
 =?utf-8?B?Z3FjSzY5VFR0clNWR2VRb25KNlY5Wkt3UDRGQmNYbE56TjIyQzFuNzBCQzJ5?=
 =?utf-8?B?VTFIWEhCTEJ6WUFOd3lNNXZDQzQ3b2tDUVZrRnB2Mmp4bkt6SjlXZXRtdk4w?=
 =?utf-8?B?bnlBS1RZams4ay9EME1jcHdLZEdpZkdBMFhnZ0o0R3VvWDhSZmxCSDhYSHVL?=
 =?utf-8?B?d1FnSFp4bkpsQ2t1UzZWVVNqb3dWc3hESDRxbEwzMjNSVXBLMERMWjR1VC9i?=
 =?utf-8?B?Tm9ZWjI3VWZjMG5xODJ3T1JnRjczNnp4QUZEd3paTHZyNnk5V1RrSWV0SmJp?=
 =?utf-8?B?bXJLalErRWlCMUdHQXcrNmpvdVlCbi9EK0NNM1oxLzgyNDFEZE1KZHJvNVNn?=
 =?utf-8?B?NC91aEJ0VUlkMTlvbC9lS2RnMFRvbVdMQnp3eGZONjJzc1JNY3FBeWdFSjha?=
 =?utf-8?B?S0N2MDF0REE1czNPTVE5a3VJVGgyR0NqQWtEa25SLzVsL3M2c25ZajJkdlFF?=
 =?utf-8?B?dWRmWGg4SXRwU016azQ0MWRaZmY2YWZ1M2Q2cjFGUlNvWk9ITy82LzdmT3RL?=
 =?utf-8?B?QThCYXlnanpoeHQ0SWtZQitXdndOQjJmVlRGOGpqazRZeFQzekNSeDlVN0NF?=
 =?utf-8?B?bXg3ZzJSU1JmSTFoTTlZeVdic3hJb2RMQ0NsaWJtUGlOUU9JaVlOQWxaUGdp?=
 =?utf-8?B?Mmh0bmJJQUI3UlhuOW1ETit4Wjc3NnlZcUpobzQrRmxXYlUrbUs2REFtc2d6?=
 =?utf-8?B?TzM0cjhqMVRBSVp5REI0UDc2WkRHWkhnWGgyRS9wN3BMU1hpSEpxZHpXVW5I?=
 =?utf-8?B?WWhsbTQ4N3FXTDV4c3FGVC9WUktuam92Vzc0d1hoV2p0aTMrR2pLOWtjdzdG?=
 =?utf-8?B?ZHY3Z3M4UlBJdjNFTjZWbUhGVWVJUFRCaWQ0WUtkMFlrdG1TNitaSXpacUhW?=
 =?utf-8?B?NEM5Q0Z2VFo5eC9RTGpIOW44M0pKa1FVT29EVTV4OU43OUlUOHhUU2JuY3kv?=
 =?utf-8?B?NGhEcVl5VXVKZG9NZWdOZjdnN2J3UC9jMmtRc0RzYy8rcGRLWStuZVZNY1Bi?=
 =?utf-8?B?bXozK0JKSjlNNG5NSXJrYzk2ckpQUG9Hakp5WG1TeGZ5d0h2MkdYZldpaHhX?=
 =?utf-8?B?K2ZGaitldXBhbUhqN3EwUS9SbEFuYTFrbzNUK0FZWGovaGxvVldUMWtWZHFz?=
 =?utf-8?B?bCtJbzZlN3BpcUxrS1VPK3gvdXJKNTQydkljOVF2d0Z4TWhQaTNVSTI2RjRX?=
 =?utf-8?B?VWdJZktxOFVwSGJQQTdaNXArVDM3cUJyYjc0bWwvV1BTblBoaUpTanQ3akdM?=
 =?utf-8?B?OXgwQVhoaTN2NHhhdEpuNkFUUHY4NjdoN28zTHVCU3FIL1BOZTZMVytPRmta?=
 =?utf-8?B?T3VOTjdJaEJrQ1ZsclM4Q2NmdDZqWGpEVE01cGNueDMySGR5eDJXYU9HQXFK?=
 =?utf-8?Q?kD2ZZNYOsKUq89qVSIX0MGz5LipyHY6Lo0RqI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTJ2V1UyZEU0bmwrajdITVhkT1dYSGNJdGR6aWluYmptaU8wOEQzRDVlQkxG?=
 =?utf-8?B?ek4rSEI5cGVvWUJPcytEYWtQak51c0J6QVppMW9mWWl2QlMwU0lWWi9rM0dV?=
 =?utf-8?B?SjJHcE1wYk9sNlFBdk9ER2Fmak8zVW92VGhsdThCT3BBTWNxUUFxWEROb1lB?=
 =?utf-8?B?ZXZiajdXYTNVWUhYTGZTeHdpMjZ1NWlvbVpzY1ArUTYvT3VjWEhYZU5SRnR1?=
 =?utf-8?B?ZlVHQzk4N0hQRGxNRkJ2QWl1Sk5xL2Fad2JERWMyVmVpUlVjQzQ4TDJ2dEJU?=
 =?utf-8?B?Z1EyTWU0czROUjhwQXdLNFRJUUhyTkhCczY1S0p0VDdIaUlTWk5jSWVwWkJH?=
 =?utf-8?B?eW42WVhtZ3VFc0ROOUFSQ3ZUa3hnMWhFeHNjS2s3MjdhSHd1U25uR1UxT2Ny?=
 =?utf-8?B?VEN0Q25RWFFZSFlqblpQR2orYkYzcW5vU0lteHdrM0VJL0dEYnd3Z2JiTStY?=
 =?utf-8?B?UmR6dVQwK0ZHb1lheWU2SnlBOVZBSWlDQkhmYnh5NWJtd0FTOU9jQTNoVjJ1?=
 =?utf-8?B?dFRsZzlkZkh3QzFjY1VGWGVMYnNrNUdRVEdzWlNDbUVUa24yaHhrYlh0WG54?=
 =?utf-8?B?UDRXNkQzdkVhT0NVc01INk9pWm1CcXJ0QjFJM0lGRXdjU0N5VU0rTGZzdGxn?=
 =?utf-8?B?QXBEQmlQV0JodjQxcE5iNkV3SElseXMwc3hZbG5rK2NOU2xqT1RRYU1wV0tu?=
 =?utf-8?B?ZEYvYjZQSnlLakptT1k0ekt1Tk4wKzNmOSs3RUwvUGhSMldLYmx0dWpsc2F4?=
 =?utf-8?B?ZEpMZkliYmhWand2a2dLMnBzZ0N0d1J0NTcyQzlMVWZzME5yVnk3QXlqVTgv?=
 =?utf-8?B?NXQwd3NlTEVPZmovY3Jndk9ESCtYY29zMlp0alZYeTJNS21KNFJhNGR6Z2Na?=
 =?utf-8?B?Y2xpNVIwRlpZYkFVNG9sdUpOZ3NLdjdlZHFoL1ZabDNCQlN0dnVaZ3l4UUFR?=
 =?utf-8?B?ZHg4Z1NTRmdOVGtxVk8ydzlqSGJEUTd2T21sTXh2TVU1ZVZ1aGs1WDJneElH?=
 =?utf-8?B?L1VNVmE5RkNDRnJtNXhkV04xSnU3eEdtbzNZVU5obXl6em9QSVJJVVpmVFhp?=
 =?utf-8?B?eG5RSGQzM20rNXI3aGJDeldQNStlR2UxaDl6VE1lMVhGNjd5eWhCZ1N5VVl0?=
 =?utf-8?B?NTBsSllhZlpId2llNE5HRXNSZ2lVYU5vWUs5dDhkODZxWnFOVXU1Z1pBZC9D?=
 =?utf-8?B?YnQ4eHJTYmZyOTRCb05iL3pGdC9EZFFQTnRQbFdaRkZ1cjJJRHRnU1ZyZDlR?=
 =?utf-8?B?TzJxeUdoTXhVdGo2MXA1OHBwSksyQW1HUEdJazMxdWcrNmx6SHhZRGVsOURs?=
 =?utf-8?B?L2JnMEVENENoVjBWbkZiRjJIa2l6OTBWUEVBOWZjVlVJSXFVQTlZd2I4dE1p?=
 =?utf-8?B?NFVLWTJVV3N0ZUZXd1ZVbnJRd25sdmU1K1FsdGVaVGpycnhMZHdnTTQwS3dY?=
 =?utf-8?B?bHY0NzNCRGNmeDFuUEZMZFNBUWVYMVRsY1lVMUF6SFF4MThvWlZ4bDVpM2Jh?=
 =?utf-8?B?MHlJSzBpaUxNS3BkQldRWm1qRUd0SHZNaWhtRkFpc2FHNG1QRFFpTm5aUCtk?=
 =?utf-8?B?U3lRdGZOUWhmeDdxaWlTZnh3UHBub004eEFDVk9hR3dWLzJkTmFpMnBaYmtE?=
 =?utf-8?B?MyswWStvT3BJbGlVclZ4cUZSdVBVZHE1cnBnRWZpdkhyTVdtRjBuWGR3ZkMv?=
 =?utf-8?B?NGhjK0ZJNGo5RjVCaEZNRjFIcVJvZythYnRveG80Q0c3cWVVVVJwdXVMSFNU?=
 =?utf-8?B?TERKT3VLOHUyS2ZPcXphTEd4STFQcjErc0ZHdUZtUU95bFRkNk1oRTNmTXE0?=
 =?utf-8?B?L2dPcWl0a2R4dHpJS1pKVHNsRUhPZ2NybTdQQnh5TE0xbEVCYmg0UTV1TFc1?=
 =?utf-8?B?L2tKMC83UGN3ZnRySjMyN3BML0FWb1VrVVZCWFFrQWw2QWxQaFZFYXpNZmZO?=
 =?utf-8?B?aHZTVVNYRUExTDdyWmx3eURuV2tpRCtxUUJDT3BKZ2RIN3hCSE9NZEg0c2VV?=
 =?utf-8?B?K2hYRjFWcnJISlYzeW56YlkxUFFpNFNyaWduUnQxcGdaWklUeitTL2dFS3gy?=
 =?utf-8?B?aithVHNTUlhBRUVXU205TElOeG1wRHExK0drNUU1bEVEOUVzd3kyYzNFY3gz?=
 =?utf-8?B?TTV2bDBXRHpjYWhBZDYwc0JkczJtc1NNTURJU1hZL0RnbFkwbmc0UDEycUEy?=
 =?utf-8?B?UUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b259baa0-804a-4da0-0137-08dcd630af13
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 09:19:37.0491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrpPC+0uBqBqSwxnHS1fkarXcPAxrO5lM1TSVcAtXCNV8yh1aR6g3AiNnAybOlfGyThHQ0omao+r11wcyEP5PvC2ja7O12oACb2mzHUnmEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4574
X-OriginatorOrg: intel.com

On 9/16/24 10:10, Przemek Kitszel wrote:
> On 9/13/24 15:13, Qianqiang Liu wrote:
>> The code in drivers/net/ethernet/intel/ice/ice_parser_rt.c:
>>
>> 114 static void ice_bst_key_init(struct ice_parser_rt *rt,
>> 115                              struct ice_imem_item *imem)
>> 116 {
>> 117         u8 tsr = (u8)rt->gpr[ICE_GPR_TSR_IDX];
>> 118         u16 ho = rt->gpr[ICE_GPR_HO_IDX];
>> 119         u8 *key = rt->bst_key;
>> 120         int idd, i;
>> 121
>> 122         idd = ICE_BST_TCAM_KEY_SIZE - 1;
>> 123         if (imem->b_kb.tsr_ctrl)
>> 124                 key[idd] = tsr;
>> 125         else
>> 126                 key[idd] = imem->b_kb.prio;
>>
>> The "ICE_BST_TCAM_KEY_SIZE" macro is 20, so "idd" is 20 - 1 = 19.
>> "key" equals "rt->bst_key" which is an array, and the size of the
>> array is ICE_BST_KEY_SIZE which is 10.
>> Is it possible that 'key[idd]' might access invalid memory?
>> Should the "idd" be "ICE_BST_KEY_SIZE"?
>>
>> -    idd = ICE_BST_TCAM_KEY_SIZE - 1;
>> +    idd = ICE_BST_KEY_SIZE - 1;
>>
> 
> We already have a fix for that from Ahmed, but it is not yet public.
> @Ahmed, please follow up.
> 

ugh, sorry, it's already public:
https://lore.kernel.org/all/20240823230847.172295-1-ahmed.zaki@intel.com/

awaits our VAL

