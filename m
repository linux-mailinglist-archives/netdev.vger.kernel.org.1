Return-Path: <netdev+bounces-217062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C43B37378
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 21:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C07C7A90DC
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 19:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E10528850E;
	Tue, 26 Aug 2025 19:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LZsslVZ/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CFE2F7466
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 19:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756238186; cv=fail; b=OHHbQQLLPImkbQkebn58TqDLzPKY6JBVa4+VXt2wPMG1hBdeHS6Lp8ZBkfJb+lL5sSg56NlkjjP2C9j/VB+iJCK7CVssN55knBwwLaHApfzoZq2Nu/xwHZW8l2IJhhS0i4U44dS4EWaKs5K7nQ6QpQGWdSWS6J3daVlJpOBoOEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756238186; c=relaxed/simple;
	bh=/LzfIAhGtuqbM+GbSSS29jHiID/AfRjE9V3xXfN6Lfo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uUDKPxuq/n7gWc9S9+9YYfgvOxDPJogbiO0sWjCyi/6Z63e8DA08Ie6pe3tvfAeGx+9k93FOVI0Oy0vbBLKnaU82w+0pcoRqelvdtUGm2adjfX9ZX+xlVcOy+sqvzVNbBKYRTSE75BLC8m8y9vPuciKT58CK+oYTGfnAdoNBhP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LZsslVZ/; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756238185; x=1787774185;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/LzfIAhGtuqbM+GbSSS29jHiID/AfRjE9V3xXfN6Lfo=;
  b=LZsslVZ/tsPmcpjbGJ7NF7NC2eWEa5eqdo05TKLibeC7IABf/5nkBJY7
   gAaysfPv2G4Vs127lwa43vfi9TCBHyvwsGNSMZqc7ttuG9IHXoYyISAKP
   DfuFWgvXBse8SD3docBFR/LPNlEPnx1zazRSvMSiaQ0zI1P5UlkYwsdSA
   BM30lq9wnIjadmYwRKuPfMD9psRk4vVHGa4gBEDRCj7m9xfV6k6naGM5u
   2p9QNf8fr8VTetQph9fwFEQPzM2iCagWbzZjgjmpujscMwfLZKtwdtnHE
   HJdirTWMBTwmk16NXBMqWAlITVxu47wVQnnTCcJZRrhlLlXqn3pyNgq2z
   Q==;
X-CSE-ConnectionGUID: iR6PDoaSStqlK7tWRWwrJg==
X-CSE-MsgGUID: AABgwMUrRnihJJrPsHb+nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="69199650"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="69199650"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 12:56:24 -0700
X-CSE-ConnectionGUID: n1MZeqRfSDuPRjRSt16Ihw==
X-CSE-MsgGUID: vAhzkxRtSzqW/2myruX2Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="168904218"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 12:56:25 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 12:56:23 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 12:56:23 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.76)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 12:56:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwbIgtg4F9Fj68/2uJbikZumN+M1UEt2uQ/Vv62bBsoP8FUFnsMBF69FBbS1K2Y3LBb3P8opGhCOZ3eJIQ3SgWx9ENE4BgNQOjwpKQ12C8bVyKoMc9bU9lt/smppP9DRtJbrzdpgOvY9S05Bk4EMF8zThvaTzNT47Cb6mERHrLulTYvfZDk4q6v3ycEmdV7L4+XJYD0EESo3MnrEP8oWyCHTCZB/h1/eLHQlrqgzZ3zm4hn+JFDIC1uOjdj+XGOHsGMPc7KDc7joVGmb6Jww5a3h2jxOY4uAE9W0mwHgwq7oEJsA2CDPt1cVvQxgiY0NeFeUImWwE9o5k7wt3ZJFxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ng776n1PY9N8rzEIQWEPZa8M1Rt5OR3XkFPmBvnYYA=;
 b=MUdg1OIHlS3re82/u7XieI2CznvriFWEUmGrU34eb/Kkk02D6WPa+KQZ71ozj536Y3c4LnPMz7XCR6C6yJ7/3yUSv7aXLu7Ougk39gMdFOQ/zYF7SCSXbmtQsPdix3RXKLke4lcU+DjOZdxhP0/kZp2434p8GqS80C4F8cot8Ysze4fCysDco9wxWCi1+VeJtXcor0pL4LW26A+gc4nk/outJkZsuPoNnobanG2CRKaBBsxTzbo/mzyJM0BYUXXpzChkZap1WZkNIfoMfvcZCKlPkv2DQXfna3Mpj5HNpxEzkhzLTdRUHrE8gmluFCnCFW8hBcQkIJ0BZ0W6bkYw3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CY8PR11MB7948.namprd11.prod.outlook.com (2603:10b6:930:7f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 19:56:20 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 19:56:20 +0000
Message-ID: <dd0590ba-f791-4a1a-9748-abfdf661aa39@intel.com>
Date: Tue, 26 Aug 2025 21:56:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 7/8] i40e: add mask to apply valid bits for
 itr_idx
To: Simon Horman <horms@kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>, Greg KH
	<gregkh@linuxfoundation.org>, <jeremiah.kyle@intel.com>,
	<leszek.pepiak@intel.com>, Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20250813104552.61027-1-przemyslaw.kitszel@intel.com>
 <20250813104552.61027-8-przemyslaw.kitszel@intel.com>
 <20250826163420.GE5892@horms.kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250826163420.GE5892@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0280.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::26) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CY8PR11MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: 92435fa1-f64e-44ef-6ad1-08dde4daa097
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VzVISEI3Tmg0YVg0NEtEbHhTV3YwNWppK2JVbGE3eVpwM3p4MjU5TUJxc21v?=
 =?utf-8?B?OWsvLzhFMG1Pd0d3WGNwK3NjZGtKRWFKNE4zSUxpS1ppRjAwMjJkYTZLK3F6?=
 =?utf-8?B?K1Nza3F2b2did3IwNmQ4cHJPYitqQk9uRmVLRW8yQ0tmVkdzM3VzbTFXZXpl?=
 =?utf-8?B?MWc2WFdacitOamRWV1lvdW41R0srTk9FaVE5NTBnM1FJTis2NGkrWG1uVkR5?=
 =?utf-8?B?TEgzNnIwMmJYOVc3WG9rK21BOU13My9Pc0FKSER0dE94V3FCZWZabkVOUU5P?=
 =?utf-8?B?dmRzYTFmYWZyc1d2ZUcrSkxNNkxzYVBjSlFPVTVZdGYzWEVqSUJINFFGb3lm?=
 =?utf-8?B?QktVeWpCYVZ5K1ZmMU9BS1J0T0wvTHRPdHMzeTN1Y2xwTitXNC9weE5BelI3?=
 =?utf-8?B?OGRoNUM0VWg4WnlLdjF1bWZOWWFUZUpvRjJKZTBCNkR2aEV3UEptVFQyMlcw?=
 =?utf-8?B?WXVMcEJVa1k5Mi85SjVaSnp1cmptN3g5R1pPeTZYRWhGVzAyYlVydXdmNE5r?=
 =?utf-8?B?NDJTRWg4aENhSkhRREYxMm96STlodDdLcEVPaTFuRUYxbGt1bHpEUU9uM1Zo?=
 =?utf-8?B?cTdGL3JaMEZ1Sm8yRnB1ZXZSQWVkMS9vZ1VCd1FxZ0c2L0ZYOWdYMlc1SU5N?=
 =?utf-8?B?UEo1eVdTWWJIeGtubTcwaEE3R3dJczIvUnFiOWhUK1ZpeXZsdkdNQlhvYXht?=
 =?utf-8?B?ek90Ti96MUgvTzlXejN1SzJnNGFEWkR5Wmd2bHNEMGpXVHBpYTFZSGNnbjdn?=
 =?utf-8?B?NHpYRXRxSlF3UDkyMEExZ3FQd2VEam4wT29EVGVjVFh2SmpYdUVVcGp4WmVP?=
 =?utf-8?B?K3B4LzJQN1BMM1JpTkp3SDVOLzNMMEh3UENGdUNLTVo4NUE4dW1BNSt6aGQ4?=
 =?utf-8?B?SHJ0NDNiOTZlaFVOZ1Z1ZzQ3UTRibzUvOFVTTnVVVEdEb3BrZml0QTVFaExB?=
 =?utf-8?B?UFJRNFZMR1J2SjBmbXUxekdFMlFHT09tcmQrSEkwckRjd3pqMzZ0ZGs4WjRn?=
 =?utf-8?B?c0lmR1hXR1U4SkJqcTN4K0ZvUFdKdUl4N25ybnlqQ0wyL2lFbTRocXRGWTJa?=
 =?utf-8?B?d3NYRjQ0Y24wNjI4Zi9zL09oV3I3QWdSZmxVZ2ltUkh0TXZsWTFmYVFlUjNu?=
 =?utf-8?B?eDIxUkVqM05jcUhYb0FUdDlwKzdNdG1vTjA5VmdaRjhWYTlnYzNzUHZsb3hM?=
 =?utf-8?B?Ujh4OER6Sm1IUTVIZUh4SmI0ZjUxUnkrbWo5d1JEWmc1VFFGR1lKNS9KaWdX?=
 =?utf-8?B?aTNaRTFqUWFTeUY0VnJYdnVBOTlzRWZtSURrOWtOSFVJTmFpWjNkWTh4b1BO?=
 =?utf-8?B?QjNDVXpTWS9rUGpINU1IRFhuS09mUzBHaUZaWXJjTTgrOS9CUHcvZlgyTnBt?=
 =?utf-8?B?d21WMU9GZGlxQ0NzUzV2ME1Uak55Tk5vblpZWWJJVEJkQ0pJeEZ6enBPM3VB?=
 =?utf-8?B?MGlYdWFiNjRzd25nV3Z1U3JZc3EyRjJ4N3RPbmVaV1Y1dCtoUXdQWVBQMmlR?=
 =?utf-8?B?dElYTlVCVEdNeXRZRHVZUE43RzY1OTlMVXhWR2EzQTlKblp2Q2NtdGhkUXQv?=
 =?utf-8?B?OU5DcVZsR1JCTHpCU3ZRejUxTXFQVWx6WjlvS1JZUTR6eVhmeEhVamhBTlVa?=
 =?utf-8?B?VGNKK2RPSWFCU2dHdFRvdUdnaksvWU9aRHFDQmFnVlREVkk0ZTNvVjE3c0M2?=
 =?utf-8?B?elVkN0V5aHZJRzdxWVY2WTdMVUw4UEo3empERVFTUnhqcy8vUmRJY3pUR1VJ?=
 =?utf-8?B?SG5oUTAreVY1d0RWeXFHK1NXcERJSnF6SG9ab1RoanlTdUJyNzlKVGh5QVhn?=
 =?utf-8?B?NXgxRDdWZFV2YWJLZTBSQjVzZUZ2YlIrY2dJQjZaUE1RdG5tT0tQUCtmUkJl?=
 =?utf-8?B?dWFCU081dTV1VndsNmJHVXlMYVU3UjVRQ3lNRXNwcUxwUHc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzVtNTNqM25KRW94VFlXS1JVSkJkSkQ0ckhYbHVsaXBCLzN0bEQzOXN6b1FT?=
 =?utf-8?B?ZTVjVVRKL1d1WTF1YVdxRnBIYnVPZzU4QzNEOGwwajRRVWY5d0tGaFZOM2NF?=
 =?utf-8?B?UTdRN0VCS2Y1RXdWWTdqYTZLYjM4MW4wRzRoZ090aWdmUHJKRkxtUVJ1REdF?=
 =?utf-8?B?b3ZQQzBaVHNUNkJPNFJwcDBhcmY5amFZTTZVb1UzaDhNNmxYRGFFdmV3YlJ2?=
 =?utf-8?B?OGtYdndQazdvOUtNbDllKzNTdk14TEY3UGNwMC9TYlRGcVVKbW56dnJYSDlR?=
 =?utf-8?B?dU02RFFTZnduUDQrWHAyYkU1bkY0UFJlZHZFbCtVbi9hQlo0N3hSNU8vZWN3?=
 =?utf-8?B?ejY0V3VBT2VUYkM1MFQzSENzNUpxcWxLWG1PWE1oU1c4VHJwR2RFcElrQzFC?=
 =?utf-8?B?aHorNVdYL3JmMWRUbUtGemVxeGp3cGFzMFR4VWlINmhXcWdZSFJ5UTZWK2RR?=
 =?utf-8?B?Z3IvZzVTQmc3WEg0ZXpONmhnVVRpcFdKaDFuaWtCNlZJQ3lKWmIyUmd3V3Uw?=
 =?utf-8?B?d1BCWWRBeWUvRnlNZG82L2dDdUUyKzZUQmRGTXJlQjdUVnRTTGhsbzNCalF1?=
 =?utf-8?B?QjdhcjFQdVhtYURBMVRCSkZSeXMwL01kMGY5SWxiM1dsUmtTZC9kUXFSdUlF?=
 =?utf-8?B?YUFoYnF3djBqSSt1Skt2L2pKWHB2NW1lTHRTMkZYRklIdFV0eS81OW5QRWha?=
 =?utf-8?B?VXpQOUJacC9HNWpDbWlMeWxkOUFTcWxKZkZvTUtJSmM2b2hLUnRxcjVpNGg1?=
 =?utf-8?B?akxyUUIxUlptdkxlQm1qbDMxQXhOU2wxRUNQVFREYjcza0lHWVJyRW9HMzNv?=
 =?utf-8?B?WVZxZlRoQitCT3U2WmY4eEJMcW5sRHJ5RzE5eFhVOG1jSk4yWTdDc2hCZnNB?=
 =?utf-8?B?dE9ob1hTeGo5WHhOb1BKbjB5RlJJRjAwWlFxVXA2a215UFdGZ3dpQkN2UE9n?=
 =?utf-8?B?RHNLTmxiNXBkQ3VwUWt0NUFWejZ5dHV6SnZaejc1SjJDanZzbkYwcTlpRGpX?=
 =?utf-8?B?UGt6SjNINEJXcndHNGNlUlczZ004SFAycjBBQUdUUXdKbC9TVkdxY1p4cEpL?=
 =?utf-8?B?aHdyMDhFYjg0QXkxR1c3Vld4a1h4c3BxazNkNTJnRzJ4cmRCN3BPRU1SS1kv?=
 =?utf-8?B?V3NVWG5Qb1R0MEcyUGljd1RjQWVkQmRPUzRYVDJ3dEdwYlQxMXAyN2RrbUFS?=
 =?utf-8?B?WUI5ZkROR3QvandEZHk0NFpQZHYxZmwreWtIZmJKOGtSNG45Qktka3JxZkt3?=
 =?utf-8?B?R1FPd1NidkZ4UmpGR2NqQXBIemEra0VGQW52Nks2QWY2ZGFBL2FsN1JqSWE2?=
 =?utf-8?B?M1l1MHZKcXdoUkNPMHk2ZGxNWFFyMFlCam9WYUI4dENDdjZXTXEzOHA4b3VM?=
 =?utf-8?B?cGEzTGlUOXpjc0dyYnh6bDNWbzdyeUNaMVlPRGZkelo0clZIbjRjQytuM05T?=
 =?utf-8?B?d2h6Y0NKN2lubnpzODZJOHc5VUxKTlgrWDlxRm54ME5oeVQxR0ovdy9qekY0?=
 =?utf-8?B?STQzcUwwZC9zQzl0ZGpGTFpaaFl1aTNWRnJLalNmdUxEeUp6ZEpUUEl2TTdu?=
 =?utf-8?B?SFd3c2xLeHVoWkc5SUp3cm5lR1U5b245SU1ITTJEZ0lSQ0xiVFNPc1BCLzcr?=
 =?utf-8?B?alFDaWlKUGp4Kzc3RWZsWXZSRWtYazdhUkNsdmJvamZ6VEZoUVJhMmFGMmVB?=
 =?utf-8?B?a0dpWXVxeUk5OTFRaGY5K0l6TE9nVWc4cU14VXc1VTZyV3dLY0dobzBXaWJN?=
 =?utf-8?B?OHdCOVZXNlhDR09Qb3B4czBYSXZmQk1oTExOVGxiVmtpSDlOOEtWNmRhRDJt?=
 =?utf-8?B?OWUwd0d2cnFPSlc1UWt1NjlCZ2xNU0NDR3BDNHBNQVYzWlNzZnpseDlTcGx5?=
 =?utf-8?B?VmRmMDVJMWJ4cUc4bWVwMTFFWUhBUjRTRXVkMWhjcTdmVDlYYkVsTXNsRlBY?=
 =?utf-8?B?YWJyVnBiR3NlZExGOWIrYlhZdkdFdlpaMGZXc3ovUkRFWkpQYmxxRzZ5ZnNv?=
 =?utf-8?B?ZGFUQmxzNFdSdlJjSnl5anpMK3JwdVVnKzkzREZESmRVRkJkNmZpR2NyTXRn?=
 =?utf-8?B?cE5GSURZbzlDNTNFUVNidzg1R2NiVFl1Um9uL1g3dk1ONlp4UE9hc0VHQkNL?=
 =?utf-8?B?SzQyZVhSVEt2YmM5QzNJcjlua3h6TTE5RWw3WlRtcHJoN0FpV3pSaHpBWDdZ?=
 =?utf-8?Q?t1r/c10I+aLsOYBoeomzLrI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92435fa1-f64e-44ef-6ad1-08dde4daa097
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 19:56:20.6659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ZkjvYJCgdUkJ5f8Nu1bCn7i7mIck2lyMF3X2twoGaGdleg3O2+YvOcFV2uqUtH+lBZGH+1efBWqHIUf78T6LEjL5d746I1MTfoMtKRTIzQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7948
X-OriginatorOrg: intel.com

On 8/26/25 18:34, Simon Horman wrote:
> On Wed, Aug 13, 2025 at 12:45:17PM +0200, Przemek Kitszel wrote:
>> From: Lukasz Czapnik <lukasz.czapnik@intel.com>
>>
>> The ITR index (itr_idx) is only 2 bits wide. When constructing the
>> register value for QINT_RQCTL, all fields are ORed together. Without
>> masking, higher bits from itr_idx may overwrite adjacent fields in the
>> register.
>>
>> Apply I40E_QINT_RQCTL_ITR_INDX_MASK to ensure only the intended bits are
>> set.
> 
> I'm all for using FIELD_PREP.
> But can this actually occur?
> 
> If not, it feels more like a clean-up.

I don't see any other place that we validate VF-provided ::rxitr_idx and
::txitr_idx of struct virtchnl_vector_map. So it's up to rogue VF.
With that, I would like to keep this as a fix.

> Which could be more universally applied.

this is also true, we typically apply such conversions when doing other
work that is related (so this time it kind of triggers :))

> And targeted at net-next (without a Fixes tag).
> 
>>
>> Fixes: 5c3c48ac6bf5 ("i40e: implement virtual device interface")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
>> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> My question about the target-tree aside, this looks good to me.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 

thank you for looking into this series

