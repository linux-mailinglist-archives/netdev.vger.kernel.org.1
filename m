Return-Path: <netdev+bounces-206421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8111B030E7
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 13:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1216D17CBC1
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 11:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24161EDA3C;
	Sun, 13 Jul 2025 11:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aLf41S7v"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E479A54654
	for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 11:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752407725; cv=fail; b=j00E1HvXOibu9sTj9BVb3E5AChoKsqoTo/uy3A/XGlkQZmGWK9gk6oWYvVm7iR7HRAqY//UVkJzJ1IyLA9iRqtAEENSvvJugcq5nxG9iRvExiGj1VtSv6jYHX35U2dH4EOHmXwijHdW+lSsM0U58phWp1aJ/5v+Qkf3yWEfK2PI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752407725; c=relaxed/simple;
	bh=4vd3qlw5aEAV8Wix3iZUfwoUL2up8VDEX8PpiXEEkYQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Oitll+JBGRfJ2ADEgNxl6NnuoyReSUDLo8cCSuQtL2/YFc/qNK0IuW1Shda4SpV13q83uaJ5FDLox3hKBy5sA4UEacjlM7bHqDrqvbNNyOcsH6uiaTilqCXeszAMND3asVKJIWcnc0kQy9aAu8YnmZs66ZgXwuB6wMnMw/olR8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aLf41S7v; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752407724; x=1783943724;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4vd3qlw5aEAV8Wix3iZUfwoUL2up8VDEX8PpiXEEkYQ=;
  b=aLf41S7vTlH5y83LJD6BJhOv8MaHqLyejvjQDa50dXE/Eybc4ssresTN
   zyz8ARD0uT5XaI2f2FbC9kWkJpmiJ4CgnNbVnhbCQOnsG8jptrG7sORlb
   3bt1bEMPvCJpQg48nMK75xgl9UoynG88QFUswTQx1biVMKneDnKuwx6N7
   zBjH3sGhtgyl1pxVkB0NhnXvxXz63hyMvzLL+z4b0o3zOJgfGXTS1NalN
   AZ3C1WOlgz4SSqEyWQxm9g1kT+lIpnOYXgUhgl+Rchb8wkJZuee7uHy6K
   r2CVE1EY1rqdVejxW58VzhxbxfqSZH2clsprrmJDr4kDxqpi0Sn/LAtzc
   g==;
X-CSE-ConnectionGUID: 6dFIsTYpQXONX+mvDbWPEA==
X-CSE-MsgGUID: eyUNzAdyR/6DIbySiSPdnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="65980923"
X-IronPort-AV: E=Sophos;i="6.16,308,1744095600"; 
   d="scan'208";a="65980923"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 04:55:23 -0700
X-CSE-ConnectionGUID: bb7diXRaQnG7NDTYZNgrOg==
X-CSE-MsgGUID: TWhl0azVRaOsXVP/Qlyang==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,308,1744095600"; 
   d="scan'208";a="193925778"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 04:55:21 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 13 Jul 2025 04:55:21 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sun, 13 Jul 2025 04:55:21 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.52)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 13 Jul 2025 04:55:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdAxFQy7lrTwI1wYrnHiFo/fBd/ZP+q3bZvsDDqJMFl4ldxm2tGliTt4Qk2pUX8OpVQnukHtKx/mi0+0IOhJwmyCbSTZJi8TlgPi5Xgk1fJevOiAP2aOsd2WTwrgsCXGnL8pG4soBKK1IaUIRVxyO1qpov0cfV+YclBTe+Ke0XjiHEFsLFHVPMXLf9hygm0utmnzSkg1WVdYWqFJmButG63u+FC+Wwg8tRkarAebagS9I6UxPbjD1LBGocG0e6ngdruWKX3LZiyHhMMiCyeNOXwsqbM6xE4RZdfwox/CYK8R8t4spgBcVwdZ2WysXK63PEgghp/HL3L2Amnb2QeZWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAOmKbr7cAT6kFIvCOaBH20P0DTFkAEb1il3Vax2srI=;
 b=W4SyPrKxaklrBLeQddP4iujS0IjOKtCbATfKw+d0XmGBmTbYhvqYJyeV0Meo31Jv+3HtuSU85v8VqVaqyEqtb1NtQZ9rcJCCJ0vhmtKf9ATkDz51RZ0A5oqCQCksJWq/H9wXPTq03YhQHK5hOc94T9GLIcYKYRt71RBVlja8oaqpegDvnaGcD4kW4mcaeQrJt6Qsm4FvbXsXBbT4wvNxIx41G7aGMa+WnFXs1lu/EWJ5++iUW/0xGKBl6Qq+l/QCLqZFwiupkiC3xxUlw7yEibEcFKry2IIVbDcHQbGm2326zwdDyj4EQF1ulpju6BYMu40k3bzcaSZY2flm1uRa4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6307.namprd11.prod.outlook.com (2603:10b6:930:21::20)
 by MW4PR11MB7029.namprd11.prod.outlook.com (2603:10b6:303:22e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Sun, 13 Jul
 2025 11:55:18 +0000
Received: from CY5PR11MB6307.namprd11.prod.outlook.com
 ([fe80::1fa2:d2f9:5904:2a14]) by CY5PR11MB6307.namprd11.prod.outlook.com
 ([fe80::1fa2:d2f9:5904:2a14%5]) with mapi id 15.20.8901.024; Sun, 13 Jul 2025
 11:55:18 +0000
Message-ID: <344e825a-566c-4f00-8c57-21b351cbe63d@intel.com>
Date: Sun, 13 Jul 2025 14:55:11 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v4 1/2] e1000e: disregard NVM checksum
 on tgp when valid checksum bit is not set
To: Jacek Kowalski <jacek@jacekk.info>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
References: <3fb71ecc-9096-4496-9152-f43b8721d937@jacekk.info>
 <22c8ffce-a0f4-4780-b722-492487d58b88@jacekk.info>
Content-Language: en-US
From: Mor Bar-Gabay <morx.bar.gabay@intel.com>
In-Reply-To: <22c8ffce-a0f4-4780-b722-492487d58b88@jacekk.info>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::6)
 To CY5PR11MB6307.namprd11.prod.outlook.com (2603:10b6:930:21::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6307:EE_|MW4PR11MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: d88323b8-db5a-4ca3-3dc2-08ddc20422df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eTV1cEYrdnAraFRMbFptYnVMYkYweDlRcmZFMWdaU2JCazM0aGJ1U284SFV6?=
 =?utf-8?B?bGo5N3NKOEQyc2prSlVqZWtjOW9uNUg5MnFjMDZJcVNBbE40TmdxRUVLVlpu?=
 =?utf-8?B?VEFMU2tmUlpKdklrN1J2OGlNZHh5QnVPMHhURjJ1akVtV01uOEd6eHo0NWI3?=
 =?utf-8?B?L2hqUTM5NWFzL3l2cFZyeVBmOW5kTjRtZ1ZXK2VnbndhMjlNeUYrSG5XdlEy?=
 =?utf-8?B?UHNONWs2RDBZOHk1V01LZ2ZhQXNqZmIycjZQYXZTUmZXZkFER2w2TVA2RUMr?=
 =?utf-8?B?Nlk3WXJEY3RqUXdMUkhVWkVwLzRVbXNZc2kzTEdmeFhxOWpOcElzL1hpeFl3?=
 =?utf-8?B?WkNzRmpkZGlmTXMzRElOaE5Uamd4SXR1NVRGNUt4cmhveTA5S3psRUNPMHhG?=
 =?utf-8?B?Z2Fsd2d5RGJCZDRYS0xGdGN5REZIbHA4WHBySVB6RUJwbGxRVXNmRFBpVzIv?=
 =?utf-8?B?M0xuWVpRajF2a3lDUTRMSUNuWmUrSkY4eThGYjI5cjloUERPZHdYOUpWbVYz?=
 =?utf-8?B?RCtBY3RTV3M3YjY0cjZtTFdIUThxbVZybnB2dDh6VHFDcWMxZzVCcmxmZnVD?=
 =?utf-8?B?NWpHcEZRdk1iZUZYWlk1ZmR5Q25lRDBGOVRCRm1CK1ZQMno0OWo0M0VUeEtM?=
 =?utf-8?B?Q1VITXRoMzJmN0NLUWEwSzVPcmVmelpWVDNBZDZiaW1XT3I0SzRtTi9MZmow?=
 =?utf-8?B?US82N0Q3K0xKdVFBd3FoZ0tVZXJWRGZKYlF5VUJaOXIwRVFmamlMWW4vY2V6?=
 =?utf-8?B?N3BOK3cyS2gyQ1R0MjREMVJZcUtMVmtucXI5K1lORHNSdEh4KzF1eURabWND?=
 =?utf-8?B?V24reGNkeGtROGw1UGlqOHVybWtxQkdZaExyTkNVVk5TSGpNdXFOY29xWEJq?=
 =?utf-8?B?Z2dKZk95elZMbGRNakdqOHoyemFFakdvZVJLclZxNWVIMG1wdlNsZDYwc1dW?=
 =?utf-8?B?c1FrZVhjOElxQ1BCUDFMVGVFSmw4dTgzenhkVTdWMzR3WFVjdHJKNmFYWFpl?=
 =?utf-8?B?T1lzcEkxK0diOWhMOXFoYnJSSmFJK3EzdjIyMmFYUU5OZmVPMGcyY2pFYzZj?=
 =?utf-8?B?Z0tBNEhiYXZiaUF1VlArMHFYSnV2NEppSUtFVHlPT1haYUkrKzNEbWRVM0k5?=
 =?utf-8?B?T2xOTWxZU3hPNDB0NFo0QUM3OWFUYVkzUjluRFl1blhMZjEveU9yZ3d0bEY5?=
 =?utf-8?B?Z0duc3RTSTFyeitBSExFMUowK1d1Ym1HT0RTOTlYaEhuVTVTZ1BmemhsVmFq?=
 =?utf-8?B?U3F3QjQrZTA4N0xuaHlQRktLN3ZweUc4VUk1RXNlOHRNUEh0MGdpRk1oK0V1?=
 =?utf-8?B?SnUxdjFEMG9RWm1ORmVzL1BwTkV6aFFYUDBCRm9tTGpteGJXdDVmTlF0cG1K?=
 =?utf-8?B?a0JveCtZdjVqNnJTdHpnRzVuakFneDFjdGhRVktaS2hhV0R5QnR1ZjlaVXdK?=
 =?utf-8?B?TTdiN3puUXd4QVRwdCtVZUtLM0dubU1idGNrR1hrMkRBSGlGNWNNd09PdytT?=
 =?utf-8?B?cE95cy9SelY5aVAxSmVvS1phU2RDdGxId1BySFN2UjJvYk1hWnBjN3lWQUdk?=
 =?utf-8?B?Z2dQb2ZuRzdJWVhJQjJhcGdFTnh2VElJNnR2N1hKYW1HTjZ4V1Vvb2pxSVg2?=
 =?utf-8?B?cEx5NEVPcEtWczRuemU0OHRjZTErTG9Vb2xsRXA1MVBFMllOVGxLZWlVOTVP?=
 =?utf-8?B?NCthVDREV0hwRWRRNGoxdGVqTlU4RXczaXF6ZTlkWXFKNmh5bkpJOE1sWGJn?=
 =?utf-8?B?ZVZjN3h4V04vN2YxQjNCakI4Y1dsTmM4Nk1aV09KS0E4TVJUSW0zbEMweHVD?=
 =?utf-8?B?OXhSdXNGcEo5Qndnb3hYOWlLaHpsMXZHV3FxeHBsSlphek80cTg0dHZhNmJz?=
 =?utf-8?B?ZkxzSndpSnJtYTlrbmZTeWdjdGVTemNyaW81Q1JRdWNWZDNvYVdGQVVHQTl2?=
 =?utf-8?Q?PLpLwRacOt8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6307.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlVENjhWQkFuVjlYb09FRnZnanBORkwyVTB0N3AwKzJxaG9QZGVva3BMdmZp?=
 =?utf-8?B?T1hsWHVPWnpYa2hsS3JHRXRCU3V6MTY0QUVKSVdIVys3cTAyWERQZld3anBy?=
 =?utf-8?B?akx5VTZsT1pSTEYyODRCME1oRkF6RUZuMkNUZDdsaHdFYWJmdC9QS04rSmFs?=
 =?utf-8?B?ZkdtZWZqYm9xc29GOFdoN0p1bW55ZS9kQnNRMUlZOFQ0UDFSbmNDL0hDU1Ba?=
 =?utf-8?B?QncvbXVOUlovdGxDeFg0RXc2TVJyM1VydGdzMThKVUhTNHUrR0dNUEFpU1J6?=
 =?utf-8?B?OFV6azBVZnhJYnZrRjJsczZoQndhRnJrTUJZcmFEMzI1UmJoQ2pJY2ZPbWJ5?=
 =?utf-8?B?TGhxL3YrbHViTjBJbE5nL0Jibm9ieXM4NXkyUlpodEZ5a0JXRm9GWG83L21v?=
 =?utf-8?B?b3h6bXNUSjFWK1pjUFVkUkNwZm1qWEZ3eDRncVJYdDBZbDJTUjQ1YWJZc0FV?=
 =?utf-8?B?N0kzY0Q2MzI2UUkvUUQvdVowY0c0TTR1UEt0MXplbEM2bDA2aHdpWFZzNnVk?=
 =?utf-8?B?ZkVSMWUvMFFhaHNpNytYb0kzT3UvZmErVS9kWUtwcWVIK2daVXBKZHE2cGNP?=
 =?utf-8?B?bzdyVDZ3UnRva1VQdlpReUlvdDBmNC9YOXNBUTdXTFI5N3lGeVUraktURUVh?=
 =?utf-8?B?VWJla3ZUKzBzS2lBWWxXZHJ0YW9UNE5aSGRkOTZSeUxsMDhJdnZlL0dCMDhV?=
 =?utf-8?B?MDYyUXVnSy9QTnJLUTlQSlVoSmk2MlRqdVRSclpqdlBXK3hETS8zYmZDY0Jy?=
 =?utf-8?B?aXBGOUQ4Uk1BRVQrMmRRUTNzSnpiTDlNSlZMd2owQmZEbjkrb1BRMzU3WUJM?=
 =?utf-8?B?VlBqZkJHckFLU0ZBTzF1U1J4QmVyNHJKZWZ1L3JjMDcrTm1YN0VNbWZsRkVI?=
 =?utf-8?B?eTlVM2ZWcGozVU9nTjhqaThSbmU3Vkw1N3JmVTh6cnp3dDZ3WllHUStDalFC?=
 =?utf-8?B?c3NOOTMvNk5oV0lFZGNTaHo2SW42KzdyTUZnNEJ2QkxnL2JJeENqZzhpVnpE?=
 =?utf-8?B?MFN4SWdrV2ZWdTdXL0tLRmJuOEkyTkVYQ0h0WVl3NXZKaDdxV1pHak9xQzZn?=
 =?utf-8?B?L0NtdmsxN2ZQbXh3TytMR0hqQzRVbWV4a2FpOVJ5L2pLQTlWbkQ0S05vVVht?=
 =?utf-8?B?UWJFRk5EZ0FaTlhJZUU3QUwxNWYwbzhXTGNueGRzMkk2TUQzR3EweXdZa2FD?=
 =?utf-8?B?b2N2K2hkZ3crUWhaYSs4Y2k1K2MzTWs2azNrNjVLVXNnMjRqd3RCdnU1azVs?=
 =?utf-8?B?dkNjM3BWM3cwU0xTQnNDVnVIa1Q1Q0lyN2RWNzAvS2FLT2xtdWNHMzBJWlJu?=
 =?utf-8?B?VTFhL0J5YW9DVktTZmFhWEVWeTBWYjRxTU50NjJUamc0TW9EL3hqcmNZM2ZM?=
 =?utf-8?B?bXNja1JyaXBRd2hkZEsxYWdzR1M4Y0xzcFFlb09XbmlhYnV2OWFsUUd1b2FZ?=
 =?utf-8?B?Q24vRE5FTitTYXdtaTBpY0NGSnlERUZBRFZIOG9XOUJkNkkxQlI4elQxUlRn?=
 =?utf-8?B?ajQzWFVheHpUQWtHaWJtWXl2aVBaZDJPdDJrSjhWc0ZOcUNwWUE2SzdHZkNU?=
 =?utf-8?B?bytmWnNpR3YrZG1hRmNWR1BSTGVpZU52OVZLRVNUQjRaaXEzUXI5cEtZMGh6?=
 =?utf-8?B?WEh3SlFGWnhJRmpWVDBJNXFDVmdKK2tMUEZtTTI1RkNwQXZQQ0x5M0pDa1Za?=
 =?utf-8?B?a3hLaS92QURPeXh1R2NkclRmZzFjOTEzRHBMSms0N09lZUtuY2NxaUxoSmxi?=
 =?utf-8?B?MkUyZnpya2JMaVo0Q0lqLzdnUnhITXRDeFZWSm1LaWM2cUdUaXpWdWY2SWRi?=
 =?utf-8?B?MHZwV1ZsNXBCTS9aMlM4aWFHbU5GYWQzWUZMYXVhRlR5dFB0dVpYQkdaVFgw?=
 =?utf-8?B?UVZZdVVRVGRLZHMzNFNnQXV4emZoVFF0UDAwQlVKK3B5L0pGRlRZWFRuRWtF?=
 =?utf-8?B?Z3U4aDE0OURwQWh0N3FUaTBSSzExSi9qZ1ltQlRFQVlSRWtBcFlaTUFZV29W?=
 =?utf-8?B?RlJkSGc2U1RCK3R0RDMweUZPQTFmMnRWTGp5R2J3RitmQjg0YXl5WVdvd2do?=
 =?utf-8?B?M3cyU3lJS1g1anNIK0RwQ0taaEV3RnVjcVpneWVVS2JFMnJlY2wwN0Ftcndh?=
 =?utf-8?B?THBlTElCUEQwZjlHcTV1ZmpyNDdTbXFYR2x1L0w5cC9DeUVCSTNlZ3BHcmo1?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d88323b8-db5a-4ca3-3dc2-08ddc20422df
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6307.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2025 11:55:18.4366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BpBoJgkRQWanhPKfa4w+Nom0fev3ULO2ecQTkx7fLfekWnjsYhpviYkY5tcHaWnAL4ds/wBfW3rz1XYdzB4MzO+8gJWI8zfbVhOPtKXTBls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7029
X-OriginatorOrg: intel.com

On 30/06/2025 11:33, Jacek Kowalski wrote:
> As described by Vitaly Lifshits:
> 
>> Starting from Tiger Lake, LAN NVM is locked for writes by SW, so the
>> driver cannot perform checksum validation and correction. This means
>> that all NVM images must leave the factory with correct checksum and
>> checksum valid bit set. Since Tiger Lake devices were the first to have
>> this lock, some systems in the field did not meet this requirement.
>> Therefore, for these transitional devices we skip checksum update and
>> verification, if the valid bit is not set.
> 
> Signed-off-by: Jacek Kowalski <Jacek@jacekk.info>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> Fixes: 4051f68318ca9 ("e1000e: Do not take care about recovery NVM checksum")
> Cc: stable@vger.kernel.org
> ---
>   drivers/net/ethernet/intel/e1000e/ich8lan.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>

