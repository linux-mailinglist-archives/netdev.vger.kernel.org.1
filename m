Return-Path: <netdev+bounces-213232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77272B242E6
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 09:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B55D163EB3
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 07:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE9B27E05E;
	Wed, 13 Aug 2025 07:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A+pfhwVq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A6723D7CF
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 07:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755070741; cv=fail; b=Q6xykgHfZzxdi6NL1GHj2xEc+xaR4iEM84rbDBOlpLLHjNXDUIXRqVo3bV6ClJKnXEgypYCW8YdJ4zSDCTzvkpMR9Htq8aoicuFOd+aXLYny/Rtgzb67MyO86/1qU4/WkPE+W/IuESpfiLJHcIa6AFS7lvDcnZI+5fGieIq6sTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755070741; c=relaxed/simple;
	bh=SsHc19oCXceMWdm4ldpyQP7PT5bXf6A3gGSXVl1Qyg8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eZn5TxCv46u/5tkHohfFuyQsACo/inuFKw8YeSA4r5mj7lMi2pH4oiktqJyALURD265l/LnQP2Qp5Xmu2zSWWLn+gDEndOzUn3Xno+tY73wgsmnSuuoCmmh0mVHlVeR6TQiMW9vSOJYVHUWEuE+niVO3HEt+WFhwM0DqLcu3LeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A+pfhwVq; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755070739; x=1786606739;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SsHc19oCXceMWdm4ldpyQP7PT5bXf6A3gGSXVl1Qyg8=;
  b=A+pfhwVq8htf8L+801mISav8cMycW/A0kOHXC/9tCiLzqSN/vaNa8Y/Y
   WcrUw1kNVVDY03jm57vQNHonUbRol4VMM8G/3Xv9BRaSjaWhGPav+IUui
   bW6gv5xIlGRWcGkTyNQf4fptc+0psthtU/xtCejCixqyAr9LmhHq0RqaY
   In7qZRqtBMSjRC2chYzOUU0dYnXyGgxOwRaJWS8iGp7rjKofOWe8IzMRu
   XLYWf+cgbVCSt1zGHeAFs9Sw0sd/eJ2hAs6SH/BLZz9lSVOMiACoiviT4
   soAB+wIWpUGBQKh+JaCnuEvYq1M0FNpro8i/CK5ZOoVsNqj8O4SZnIiz1
   A==;
X-CSE-ConnectionGUID: KshH1cAMQ5WLZbc4qajzeA==
X-CSE-MsgGUID: ODos7PzLRvqeuLaGJQz7tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="67961922"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="67961922"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 00:38:59 -0700
X-CSE-ConnectionGUID: Vpb2tT4uRF+fNLTY2rE20Q==
X-CSE-MsgGUID: tziTdb5VR6Sap5uIueyJGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="166284236"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 00:38:59 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 13 Aug 2025 00:38:53 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 13 Aug 2025 00:38:53 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.86) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 13 Aug 2025 00:38:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2zdJcUN1rIXP+NNk89U0z9cRye7PdTbT7b+Jua5vBwhG9Yg7aNRb02AKMaaLNliGPumLKtRL/PTLg1OShWWMN0t4TC+oM48M/OK5oX+kwxN0gDe8KfiuOcAgaseiFGKUOAUsb8NFRSFDfEJE0IxmpQfCZdE7WzlLrt4zvSJSGrdYJ78r8Bj5fOlTE1GAaunC4Wx05w7sd5PFNbIS2LdVILxfxDnNhggzr0LU5pUh+SOANGdDtcraHEZeBMN+Ylq/jKbwhiyYCGTEtKcRGPqzGMqCt3y2vEVhCBVBdN1TIXv/kBvcvIYuIBsKwFgSQKWYo+NYzPNpJdYOziMIxHLzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TuWjs7VWpRQAfzs5ZalCNs+oxHeLPOFNmIyh/l5FBhs=;
 b=idGOGISojEMHaiH74udLjT1jsuTo4qv3to245yRjWThx1alaO7DBRkl9bXBMXdx5erdiHeWZ/1eV9vudJQsO+IgNl1enHYK5cMXlT9LttzYHYnBQCg8PgYYX5yidP6+M4PN9tikG3L24//Bm53qStuHnrk/23ZkN1yJksbcSBE7pVqTCH3V+hKm/FAjUWZjik1YKE5Se6w6/fseejdCPWyYhdemWAdkvxfX/BFQRDCHafkH7g0fpz/WIAorlnolEXpBzw786lg0KyDRMfR8bXiLOVjFX8a1B0CcTq4l1p2pp7HVr2LvIMMqcDZimw3sntIHIPvO4bP4/aEcoVLyS1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA1PR11MB8320.namprd11.prod.outlook.com (2603:10b6:806:37c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Wed, 13 Aug
 2025 07:38:50 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 07:38:50 +0000
Message-ID: <a551d1c2-1714-4168-b647-b55a9ec8bac9@intel.com>
Date: Wed, 13 Aug 2025 09:38:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH 02/12] ice: split queue stuff out of
 ice_virtchnl.c - p2
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
References: <20250812132910.99626-1-przemyslaw.kitszel@intel.com>
 <20250812132910.99626-3-przemyslaw.kitszel@intel.com>
 <edbc1372-b063-4294-b045-72752adf37b3@molgen.mpg.de>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <edbc1372-b063-4294-b045-72752adf37b3@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZP191CA0017.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::28) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA1PR11MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: 458eed7a-a1fc-491e-7987-08ddda3c7238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0VFTHhKVjU2Mk1oelV0M29BZGZpMGhEYmdWSElBZEdFWTF4Zm9TdHJVZDdB?=
 =?utf-8?B?ZE5oMi8wa214RkVrMXY1d3ZvZkc2MTRaMCsrZUV6K2p2TjBFZWF2RVdEK01q?=
 =?utf-8?B?Q2FBcDNDSEtxUTE4Mk53aTZPYnlHL0lZZVpFSG85WCtVYnRqV2RQdE9lOE9P?=
 =?utf-8?B?U0hRYlRMVzZYU1FYTVRScGRHRm9rYVRyZ3VZcDlwUHJON2ExcDVFYVN4TTMw?=
 =?utf-8?B?am9hd1Z0czVVbjZiOXhGV0o5WDVudjMvZkphRmV2TVE1YndISnA5ZzY5VytT?=
 =?utf-8?B?d2tJcVhkRFIzYUhxeHkyY25nSE53RHl4Zy94ZWd4ZUlha0xnTHpaazRiMDBF?=
 =?utf-8?B?TDlEY0JQeWpXZjIrSEJGOFpBZkVGU1VzdVp4NzRtMlpQNlZUTDdycEpUMlBM?=
 =?utf-8?B?cUlCOWpIQXN1TUVrL0NLWkU0RktYU1NjWnhBbnRXV2JtcnEya0crWWpvdTB2?=
 =?utf-8?B?bDNoekNmTmhyb21aelFVbU5La0o0Z0wrZnQzMmRZYUNVYVpuRW9oU0ZEeHpZ?=
 =?utf-8?B?YTc5U0JwbWhaZjdnV04rTGdPTDBEWHVlekQycjE3dWR5UWNUZ3NjNTAzWHVG?=
 =?utf-8?B?dkZMWDQ1RkxGSURIbXh5VHZ1NWdhZFNuZUFDcUw3T3B2OWZXOXpjOFg4Q3Rp?=
 =?utf-8?B?WlBhQlN3UjQ4aFU1RHVham5ybE5hbUJzWkQzUGpSSVBkblR0RGZRNk5MTTJu?=
 =?utf-8?B?cUxwTHRnK0luakY1U3dvdnArNnJ5b2llSk1tS1N3WG5aSlhSVXhoYXdzdFdE?=
 =?utf-8?B?a3dKNnRsLy9RbENNeUxXSkdza0RQSTd3a0NEcmYwTHVDck5hanVVY0drSGNM?=
 =?utf-8?B?NE51dVVFTkl0UmU1K3V4K2lydWlKVjdNcFVpdmZvS3k2QXFGVnRWVkhCWit5?=
 =?utf-8?B?cGJ1Wm43QnhVUDV2Zm5lQ0NYY3pXU2FReVhKLzNtMzlHLzFjZWRVV0M5Mzl6?=
 =?utf-8?B?T2ZVbDZpUENWTDVuWmNsUm1ta3pQNndnYzZlcCtHdkxLZUpzSkY5VTJZVFBm?=
 =?utf-8?B?dk93UDlETHpVMTBZdEx1cFBxN0pJU1pXUkZTT0hBSUJSMjdSL0MyWXVlcDRp?=
 =?utf-8?B?QzE2eCtuQ000VEFCZ2R1UFZRdVEzUU5CNk1ST3k1ai8vNnM1SE04Z1k4aUFy?=
 =?utf-8?B?eldFaVhRR1pWZElxVlMySG1KNG91bEZqQ3M2TnBxNjdJTGJoVGM1SVNKZVlp?=
 =?utf-8?B?ZVVoSTJBNjdnTzdUNlFNM3Nudkc5dXlSNE0veFFOVEtCckJZUWQxRjlEZEds?=
 =?utf-8?B?aW1KU29rekJZVzZjajZiSDlrdUtmUEhJR2x5SjZMUmJuR2JyeDVpUmo2TWlU?=
 =?utf-8?B?Q1J6cDRORENna1M2akFPa04zRStkS3BuVnVpeks3YU9aOEwrU1lrWEN6M2Fn?=
 =?utf-8?B?ZGRhMTlDQVNKTTdVaWVIL3VrbGNoVzE5a0pJSmJMNVNnUDRMMHBCSTVxTDFE?=
 =?utf-8?B?QXRRZ3I4OUVBL1BrMjRjdGFvK1oyMTlMZFNKWlA4UWJjUm80TjF4cTVCNEIx?=
 =?utf-8?B?aGp6My9saUdHL0Z0bEFWRjNGdzZEcWoweHBHSHJMY0lPYmpHOUg2Z0lpZ25a?=
 =?utf-8?B?NjFtRTVrVnJDemZuaG10UUJVbDF0Nmx6Tlp4L2VYbFdoLzJzWjZlMWtJWW1N?=
 =?utf-8?B?dnRSalR1TVVCN1FVUHpmM2p1eWtVME1yUm10MzY1ZldianpWOFNxRWVqVldJ?=
 =?utf-8?B?WmRFQmI1S1F6R0F3L25qMmdpTW53VTg4Y3Q1VWxsZG9KUEVURDJCelc4aFdT?=
 =?utf-8?B?eUNDK3dSdDZsMUdJTkpJR0l1V1phK0VheHNVd2NIci83YnV2bUVqaUprajB0?=
 =?utf-8?B?WmVnRThXdHJEMDdNWVlIR083N0VIVTVLd3hKMlZDSTdFVytZNUo2bjg0d0Y5?=
 =?utf-8?B?WEdtWnZQelFHTWd1OW5FeE9HNk5Pc0lyb3JZZkEvL2RmODl0bER0SS9vYkxo?=
 =?utf-8?Q?wTmhHLU9JZg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEoxRDU4UkkxMFNVT0YyOU9mZVl0VFdOWjlGRlZzTHlzZWNLTE94NUlqaGJM?=
 =?utf-8?B?aXlXVURjbCtLVVdyTXgxQlAxTHpDaUhwS09yUHBCbUVmMWJlbmFNUm5QUU1w?=
 =?utf-8?B?TERSL1J3dmZ6clp1bzc3dUFoL01ZVG9CUFRTSWx5TzF0aU82Mk51SGcwMmlV?=
 =?utf-8?B?bDRoRmxjSGdqa2Z6VGxPRWtpcmh4UFZVWXc3NTd6UnUxZFNWbnJYaEQ4NU9H?=
 =?utf-8?B?NjlCNkRxYzNuODFjNC93V3VXNnlDZWFoeDVaeHRWWFJmVXBGSWxXZU1PTWVp?=
 =?utf-8?B?OXh0ZU40NW45T1VmNFgwMFVyMklxQWJuUWxhR04vUnY4cUdCVCt3QlEwRkQv?=
 =?utf-8?B?UnkzWEROS0hoLzZGSlJ5aXZnOWVqaU1QTzNKeUJKTW1aRWxVTThiOTRiSmg4?=
 =?utf-8?B?cys4YVdUcEF1TUVyK0gyZktlTTdXa2ZBRFB1U2RHa0ljNjRwVG4yWGxybTFQ?=
 =?utf-8?B?aUlZZUE4a2VpNWNnQXEvN0Y4eHdiLzNzNE11MmlUOVdKUmpZaGgwMHdFZUtC?=
 =?utf-8?B?V1dLVHJTOG1ONXR3L0tCQUN0NCs5SnBoeDFDUlY0YU4wcFl0eEkvYU0vUExn?=
 =?utf-8?B?KytFcWxieWQ2OXRTWkhJSmM1UGVRbEE3OHhlWGpqTFRzVGFxMmxwcUs5ek13?=
 =?utf-8?B?T3MwOGtwUHlSZDlMWUFnaXkvM0g5aGxwcnFSeDV6TnpXOENteUJoTWQ1WjZP?=
 =?utf-8?B?YkNCakVjMnRxUkcvemtZeFdJN2lVV0hDM0lMMzR2VUYwVjlCM2lub0V6YWta?=
 =?utf-8?B?dXo2SWN6RHRGc0lOUEk2Q3U4U3NYdDZKdVpFTWl0Njd2RFI5VG5mQjZ0aUEr?=
 =?utf-8?B?YVE5ZC8yN0Y0YkprekdWNjc2d2tIOFhCQlFKblh6YThiSVNZRkZDdkJ2UDF4?=
 =?utf-8?B?QnJXKzhsMlgxMkI4eTdEQVYrY0FnbVZSSHl0b09tQXM4V3RxSi9MT0Q2Y1ZC?=
 =?utf-8?B?ZWNKUm9mdi9XRmZLbkpQRTdWNnliUHR5WlpObGNvWUNyYlhSM0xTZjhLdTBW?=
 =?utf-8?B?Nlh2WXdCMlV2NmtuYy93dDN2eXZLLzlMZ0hwMFNZN016K25IdUZiYitjSHUy?=
 =?utf-8?B?aEQ3V0VtTXZKRlpPZmgwSVFGbmJaYkdLRUVnZWlhZ0YrbTk0VEJRTEE5aWFo?=
 =?utf-8?B?djlTZUxJbjhSeXU2UkpMNXZMcHVmZTRNbE1CdWVuSGpMWlNrOXZFaE9OWlBY?=
 =?utf-8?B?bExNRDc2V1V4NlhBaW5UbnhmVjltV2ErenIxY1prWjRtQjZxcGxHMUN6eWVq?=
 =?utf-8?B?L1B5MktOSzdNTUhVRk5HVEoweW1KdUMzbnhqSE5BYVdwZnpPVkY1d05mRFVx?=
 =?utf-8?B?TXQ2a2c1dVErN0hKcWZjcEYxNGJyTmpWMVphQ2oyRUVSS04rbDVZTUwyVEZr?=
 =?utf-8?B?OG0zNnVCekJTSGVFV1ZzNnVqV2lSSHd6dmxQdGxlOXlZTG1mbEFTZUMvRjZr?=
 =?utf-8?B?aTlzUzl1S2FzeWtwYy9SRzBQR0RsdVl5L2ZQUENpVUdjN2wvcUM4dEJWSXdj?=
 =?utf-8?B?N0pxcE1memJTWkFNZGpVNFdsS3U4dlVKN1JSK3pIK1pWQVd6Nlo4MXhIYzZ2?=
 =?utf-8?B?Mmh5bGJLMUFXanFXSHhla01VNno1S1dOanFSdWxsY1RJK2RtdjZJdkhWQWI2?=
 =?utf-8?B?MElKZzhCUEhVR3RUT01mRWNLQzJqd2FNK1JoL251bWNuUW9PTTMxNkJuWTQ0?=
 =?utf-8?B?QUV2VVl4QmtzcTBkUTFzNHFBdVJFSzRNekZaQ2htdVhNUUN3NmlZUUExNVoy?=
 =?utf-8?B?L0tzNVBSTjRJOUhMYktCbHZWMXRjNm4rWlhaK090c0lUemhzZ1lGQy9OTi9N?=
 =?utf-8?B?Q2l6dGdjM3p3YzlDaHNSclFReFNBY244K3JTemxYVjRoWUFKdHRScjI3enFU?=
 =?utf-8?B?TUFaME5RNnNON2t5Sm1rM2U4aDBrVm9UNVo3eVBJZTFKU3VnTnJSSGdSQm5L?=
 =?utf-8?B?YlhVN3BoWkFHaytBa3pNRnpUK0NVUW1Mc0V6eDBtazlOUStxQWRqY0kxUDhz?=
 =?utf-8?B?VGpBclpSVGFmY0RsbnI0K0dKZVlBTThZWlBMWlpBNlhtVGFxRFpIblRka2VL?=
 =?utf-8?B?UXFSbGdNYlJOOEhTbUFZaG80WmtQdUJjbUs0c3NHb05jOFNzVmJDUUUzd0tj?=
 =?utf-8?B?NlVRWFFET3BkUUQrZ2F4ZVMxbWcrOG1FYjYxZTQzYk1UT29XSUZUdTN5WHhz?=
 =?utf-8?B?ZEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 458eed7a-a1fc-491e-7987-08ddda3c7238
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 07:38:50.7787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +BIpxFc2Mup36CVe+ml1T4sVVm6/UDujgV+zRqdyVU9VKBSi8JAH6QaQBHVAXhwonG8JM5z3GAkzw/sl9lG3v/Etc10P3x3rqyebwWsReuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8320
X-OriginatorOrg: intel.com

On 8/12/25 22:07, Paul Menzel wrote:
> Dear Przemek,
> 
> 
> Thank you for your patch.
> 
> Am 12.08.25 um 15:29 schrieb Przemek Kitszel:
>> Add copy of ice_virtchnl.c under the original name/location.
> 
> Why not mention the rename in the summary/title instead of p2?

that was "technical git detail", that is gone after the full series is
applied, anyway, I could apply:
	s/p1/tmp rename/;s/p2/copy back/
(but would rather avoid sending whole series again on IWL just for that)

for "cleanup - pX" commits I would keep title as-is, as those were split
only to avoid git creativity in minimizing the diff

> 
>> Now both ice_virtchnl.c and ice_virtchnl_queues.c have the same content,
>> and only the former of the two in use.
>>
>> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> ---
>>   drivers/net/ethernet/intel/ice/Makefile       |    2 +-
>>   drivers/net/ethernet/intel/ice/ice_virtchnl.c | 4611 +++++++++++++++++
>>   2 files changed, 4612 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/net/ethernet/intel/ice/ice_virtchnl.c
> 
> […]
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

thank you!

> 
> 
> Kind regards,
> 
> Paul


