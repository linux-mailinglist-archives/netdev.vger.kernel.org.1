Return-Path: <netdev+bounces-242905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EF16FC9609C
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 08:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6AA6E343475
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 07:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D812BEC5E;
	Mon,  1 Dec 2025 07:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CdrgFZV5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5202BDC29;
	Mon,  1 Dec 2025 07:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764574912; cv=fail; b=X5rhRs5yDxlubEN3haNLmyPojcvdItMMnAp+EtpmgjTc2nAvON3TzfyrZD2pPGiajA1dBprIVa2aLEoLy9Q8awERL8Uv7FezEWxC3Lbor4h4JBGYw4haI9cTyjnGrOC9LfFktMT6D7IiX19/zGrx4Q5+GNoSI9HZTYk+K529Eyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764574912; c=relaxed/simple;
	bh=y3UxV6KM1HImOnbi2IlQ0pcfA104IIONzD1OYx+ygxs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ti1TiHWBc/BtHb4eoZ+DFJ11dhpTo1ZnOdHp/NhOLRlHurZn3SXIiqP7AsXt0NgcadUk2yZn/wFqWfQ6WRO02io2Wc/nkveaxIhOdJDdnxQVkqPJbziT2Fr2EIqR4l0u9E8jQV3qoBpe7hisFnxOqLSJ5ktLLMfE3YBbHaC77eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CdrgFZV5; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764574911; x=1796110911;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y3UxV6KM1HImOnbi2IlQ0pcfA104IIONzD1OYx+ygxs=;
  b=CdrgFZV5rdkvLJIL9fw7dt9OclJqoBNjfUGS10RQD0hUopJQ/VelBZZJ
   scwQccFS+tKLt51ZNmZ485M9V7qlOOSWwCVsdBk6a1hhKt89lViH7zKsx
   vhvYRQAeypJ+ImpFwPuYNv5TW6az5/Po4SqSo7r9bkWyi7jXny+N4gHXr
   YaqVYfNXMgQzapBlXY6Myf/aDXvvARDHSYm+bDwaCQ/lfWZPOxCtuzF/o
   JFBJb/ND/tW5zBuK37mcJwFM6pNt7EnY/PenOIVx4wjiVrzMt3xIfTZyL
   SC0j62yz88qyguNQAKTy2TEA/6pWyLDClLutkZMFqqo3I/fn8qsMCneTN
   Q==;
X-CSE-ConnectionGUID: ksySa1EPTCS8dyP7AQ/htA==
X-CSE-MsgGUID: vKXTyjZbQPCykBs6z6qmAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="54059969"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; 
   d="scan'208";a="54059969"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2025 23:41:50 -0800
X-CSE-ConnectionGUID: ilaJcOvoT3u1/HMPcHOU/Q==
X-CSE-MsgGUID: Nsrt2A56SJ6vSlddWa6m9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; 
   d="scan'208";a="199121097"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2025 23:41:50 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 30 Nov 2025 23:41:49 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Sun, 30 Nov 2025 23:41:49 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.25) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 30 Nov 2025 23:41:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQnk4vqTi5Uki3M6pf/BJCJZZVHUST+CPjxltKkwF0j7JJA7mQCYMqODuLUHUSSmVrqoXrUH5azrDaAWFqr5MZfH5I3YS+ICY/9g1E+N8wmjHdaCvmnQtJUCzd1IFP5ho/zlLoz1gQgNNQe9OoCHoEW6qMNa94fSGasaG+aD53YfTCyQkbWS8h3OPNv0WNxYK9ne48NeMfpJ/Bthc02dRrQe3dPl5qNFdWtkSVMLe7wHvHCIOhW+TPTQRwSwHLK6VE43UxtTUGx71bW7IrygE4R1AwAL+fGnHU74SwRRVRWeB9uIVzF75uBkzN0WUe5DWL8zwvX80kk5TQe1GbhiDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3UxV6KM1HImOnbi2IlQ0pcfA104IIONzD1OYx+ygxs=;
 b=gYWURY9GqmGe8+V06Y8sLqRpfo15+RyTj1fimF9eh+k9yNFsDMwspGOZy+lBAqjLFj/dNhd8F3voX0OuELpYRB5OpENPQsq7rHr1d9q0Gqb05euf/2lV3jtNQ9h0JzE/E8ok63gkgZDQ9Hng4ni2mBYZycwqXL/QX36MmwWdpd1dmJkv08LZ7Gnf4Qpnnm5ZYargHNokQA17f+3JIWuoRWu6htvDSwQrIwHadbrR8UMIqYZdD6lv8PcOfElkySKg6FGXOVoNW5wEjPEa/0UnWFb+KXk0itvUCleyxOVppcPGDX/2g+zbTk1XLirhcolDGzp89Z8X84aehY3mVAzI+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by IA4PR11MB9252.namprd11.prod.outlook.com (2603:10b6:208:561::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 07:41:47 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 07:41:47 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Slepecki, Jakub" <jakub.slepecki@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "michal.swiatkowski@linux.intel.com"
	<michal.swiatkowski@linux.intel.com>
Subject: RE: [PATCH iwl-next v2 5/8] ice: update mac,vlan rules when toggling
 between VEB and VEPA
Thread-Topic: [PATCH iwl-next v2 5/8] ice: update mac,vlan rules when toggling
 between VEB and VEPA
Thread-Index: AQHcXeZwj7qoLAXCrku3q4UNIxO7jLUDFbKwgASwogCAAAIDsIAAQOiAgARmCBA=
Date: Mon, 1 Dec 2025 07:41:47 +0000
Message-ID: <IA3PR11MB8986BC04F434F7D36300D2A8E5DBA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251125083456.28822-1-jakub.slepecki@intel.com>
 <20251125083456.28822-6-jakub.slepecki@intel.com>
 <IA3PR11MB89867D7081F88828EAC0E107E5D1A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <30c166ee-c113-434d-acca-15bc7c46722f@intel.com>
 <IA3PR11MB898691972766E6929CFDF934E5DCA@IA3PR11MB8986.namprd11.prod.outlook.com>
 <12bcee25-7ec4-418e-b8c7-60642d8073c0@intel.com>
In-Reply-To: <12bcee25-7ec4-418e-b8c7-60642d8073c0@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|IA4PR11MB9252:EE_
x-ms-office365-filtering-correlation-id: ef361f3e-c29f-448f-8fec-08de30ad1517
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?K295clBjaGxlZ1MvcEpUTTJhNjBNL0wycWo1bFVlK1JHWXVIWWtLMjh3UzNQ?=
 =?utf-8?B?TUlxcnN3akhxMHVxcm5NU1VUckdLM1drczJiTU9IWDIzdjhjNmQyM3EwdjBH?=
 =?utf-8?B?NTVLc00zR2tVbjZZRWpqb01FN0FuSHFENldKanZMNTlGMDBZZ0c3YWVZd01l?=
 =?utf-8?B?Sm1HVWxUQ3IzWTlxSDFYeW5RRlFyUXR1S2NTTWJjS2Y2V1dIRGN3Mk9kL0U1?=
 =?utf-8?B?KzMwNjZWTEFXWmdaVWxxc0lBVGhXMFdQU3BhcUo5b1BUNlJ3MUxHZCsvOHpt?=
 =?utf-8?B?WXVoVVJPZklrVlRQaXZEVnFmek9ZUkNxT2RNWHhITzI3Z1JjdnZ1OGFERnMv?=
 =?utf-8?B?WmNURCtIMVdiQWZhL0taQThhbEZzWFowU2I1SVBFSFhlQkdWZXJ0RzJIa0hl?=
 =?utf-8?B?b2RMQjQ4bkFkS28yRDNVRmJEYStVVFQ4R3ArRGpiNFpRS3REWDJqcnp0ZjA0?=
 =?utf-8?B?d1B1Zld4aENIbVc2Rk9TRFM5ZHVqRVdEUVhGNlRteEFlTjlqZnYwTk1qTXpC?=
 =?utf-8?B?d2QxT05YdVVET1R6VWdCY2hPRlRQWjNaRGR3WXJYMDQyREpjNVRRcGdmbEVl?=
 =?utf-8?B?d3FVYUtkbmhXZzdwbDRzaGd2cHRRMjJWNlhiekFaSTVBd21jejVXc3hxL1NE?=
 =?utf-8?B?VlhuUlgwR2hwMkg2eFlGSGUxYm9mRVVyR3RZczdsWHNkSnB3QkIyWUZlcW9Y?=
 =?utf-8?B?NXEySmYyc2FjWUlUT1VEajdnd2x2UlJGNHQ5Y05hall3R3NSVHhadGVPM2Fv?=
 =?utf-8?B?bDhCNkQ4YmdxVjdMd3hBb1c1bjJCMHp3UGJnQnpjRERQUStzMWR4MmZ2b0RF?=
 =?utf-8?B?Y0FlSVEzWEIxMGw2YkE1YWtIdnRzN1IzU2MxTHp0UHlUdC9kdTczc2hSQTR0?=
 =?utf-8?B?ZTJXdFh4dENkWFZWU3c2MnJFdDFaWmlPT0pudFFEWWtXTkFsb29sdjNCb09Z?=
 =?utf-8?B?dTVIenR4UVlzejJaUnNZeFhGeGtnamVpSlpLRDhsSU9lYjN5QWh2SERzbERL?=
 =?utf-8?B?RDVMSFZkWDNsbnVvTk1tMVQvU0FOWGg0S0pBTVJYRzVVRGhLWVFhcHA3d215?=
 =?utf-8?B?SmMvZnA5MXFFenBOcGx3OHBITlNobHF1NEM4R2V5a0NZZnU5RCsvOHh0cFRQ?=
 =?utf-8?B?eEkxcWdDNkZNa0h5QVk5Q3QrOXF2Qk1JbnFJaG05dnBlWXc4Z0VPUzF5SlN5?=
 =?utf-8?B?MUhqQzBPeUlNTENCM1BTWUFFRVhaaytSN0pSak5rSEZhUFBndUJaczlxN0Fp?=
 =?utf-8?B?dnhvV2FBNzdCMlNNQm1LSGlhbGQydm5sNmFBdDNFMmtlbEJzT3RXYTF6eTZE?=
 =?utf-8?B?akFvL0FVL1NnUGQyQzNxaGc3MlVBeVRITG1UWXEySmw0TTJDZzUyWk8rWVZS?=
 =?utf-8?B?bHo5N1M3b09BZEJ0elppSGwxSytsbEtaZ1F0bnpVS2xMVXhsZG1EUkdsempw?=
 =?utf-8?B?dG5iVUhRaDJWTmdzamY2eFdsSXlVcm5oZklBTzY2WG50U1VvbG81RlVsMEI4?=
 =?utf-8?B?ZGpaZE8vR0pGYUw3UUtBVmwrRlpqZkcydUhhZzU1a2FUTitYZERUVVU3NnVn?=
 =?utf-8?B?WEFzTExKSkxqdTNhNWdoL01xcVQrbnVidUIwcHVUMnRrOS9OZU5rOC9nZWlw?=
 =?utf-8?B?bE1zYzcvNXdHM0MvdGJYRHlXWThjc24vQ01jODlhUW1xTkxYWDRteFBWeTNq?=
 =?utf-8?B?bVpUOWRDeVlBdndLOU5jUUk3V0xNcFEwSklZelFYbGJGeDdFMkpXbU10R2FO?=
 =?utf-8?B?d0E5Vmk1M0dWWldHNU9LRjg1M2ZCOUZWN0pQblNVMkk4ZkhPbmk1Z2JVcXBZ?=
 =?utf-8?B?VW5ETGtiYmFCS1JKWlFsYXg0S0FyZ1BubGh0dVRYOCtKVmZ4Sy9zZXNNOGJw?=
 =?utf-8?B?Mm0wd1I0bllLQzdUa3ppMS9oWXFjMlpUWEdRRmxuSXY4OFBYSWtXMVRIQzND?=
 =?utf-8?B?SFhuQ1pneFN3eUVQZVZLSVdWcGJTbDllSkc1bXRma0JSYmhLN3YzYkM1ZDVC?=
 =?utf-8?B?UnBCbWlhUUozRVVGWGM5Q0RsSW1vUCthYml4YXkvSkxsSk0vUGtkRzMrT2Ft?=
 =?utf-8?Q?Myc2cV?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTNzbHpLeWtPMjIzY1NDbjZiWFFQNDRDazhiUXZwWEtrcHlJdnZlbE11MlRr?=
 =?utf-8?B?dDJyY24rWjk1VTlGMlV6Zm0zZ0ViVnJjSVJQQmV2S213NTNwcEQzd01yejhL?=
 =?utf-8?B?Q2wreE1HS1lMZVNBczJkS1BwU3kzaVpIWWNrbmp4WUswRFNFQnhORzc2THJT?=
 =?utf-8?B?eC9TM0lIM3R5d2RnRmhQZWlSMHJCQWJOME9kZUdLcHlWSlk3blFlc1FBUFds?=
 =?utf-8?B?cVMrU0doajFmVmljaTlWRUZVc0lLMjhSZE5oTFl2RjFlWXN6VjFDd2JkcGZ2?=
 =?utf-8?B?SE1mSllBSDF4WjRMWlhyRzgyOTRKcVNLK2pvbXFpMlB1Q1NSdEQ0bTNGTThJ?=
 =?utf-8?B?SXZhQmdVZlkyNjF0R3NCeTYzL2U0M0tocEo3UkxVSzdnYVVzQ05leW5HOHQv?=
 =?utf-8?B?amlPQmQzTWdHMHJtSlJreFk4OTJ6Y2lQMFpDN2ZOeEJTNTVMSzN2R1RsY2tp?=
 =?utf-8?B?c3drQ1dRVDl5alJyL3BEYzR2TWQ3ai9ZVWxyS0QySm95VGJJQzVtaU9FMGV4?=
 =?utf-8?B?N2tFTGcvVmdUTW9laUdJRkpuRE5PU0RlNWdCRVFqdXpTbDVndVRTQ3hadDhP?=
 =?utf-8?B?b0UyOHNHbzdwUkFEb1FsL3JpZDJ4d2xadzN2V0dNeHVBYnVRMEVzR3hiUHo1?=
 =?utf-8?B?Y0szWE1EZ3BmRHZGYUdYMlN1bjVvWm85dTdQVThzVEwzYjRoRjEwOWVYLzdN?=
 =?utf-8?B?VjVHLzlBblBEc2V3Z3YyL0tUQUVIUWVGaXpIcHFsN0tyT09XaDJLNXJ1VlIr?=
 =?utf-8?B?Y3c3Y0x4Vm9rYWxGbCsyL2kwbnNwUHJ1dFppSnJyNFVuZ1YwNHUvYUZkZXRJ?=
 =?utf-8?B?RVFLd0FtSkF3RG44b0NPbXRKMmZKL0R1djUvSFBwOXdORVZGL2gyTm9CLzdn?=
 =?utf-8?B?ZjlqcFNsMmx4OUtWbWdlbWFNMmovSGtjWTdxb1l0d3RxeWs5aGJZT2h4VWdZ?=
 =?utf-8?B?N0l0Q1d6N1hHQUdDT0ZHTTZPTlF4aS9uWXJObHpScHRhdVZYWUJTWkpZUFIw?=
 =?utf-8?B?WVZMVE9JR0syUkIrZEI0cVJ2c3RGMGZNUWY3Wm5teTV5SGxjTlhMVHNZU1Fo?=
 =?utf-8?B?VDFvNVZmRHEwd2tWVVB5VXRPc0ZFT3lLRDFSalpTMEJud1dGUWFTY09YY2FT?=
 =?utf-8?B?ZGlDOEtVamcvcHZIL1VsUU9ZVS9kd254ZWNtektBWG9qUG9uUWlPS3ZVV3F1?=
 =?utf-8?B?MU9ydnN0clovUEN3RjdpeG41ek5ZM2xTV0dlc2ZYbWJzQ0l0cUx0a05IVWR0?=
 =?utf-8?B?SFAvNXdyYXd5a00wMVd4Q1JXUXBVV1Z5NnZnSGJRYU5RRGl0aXcyRjBGUm12?=
 =?utf-8?B?ZmZUZWU2dWhuZWtaVnpYRUs0VmM1RjF4RXE3NEptMGRtSWJ0dUZrTDdIeVV6?=
 =?utf-8?B?eUhHWldENmFmVjdKMkNrM2c1dWVnNTVGMVRYaEY3SjgwZlgvSDJtN1h3MUpV?=
 =?utf-8?B?YWZtSUdtQWJ2dnBXdzZycThYc3kycEc3M09xaFRRQ0YwejlpYlZTZGVxU2lo?=
 =?utf-8?B?VHJvRzdkVHFQZmhNdXdNR0FlWU8zSS83Z1ZVNlREK2NGdE9zY2t6MFc5dndM?=
 =?utf-8?B?RnlydEVYT3dPVytHbC9LWlo0UkptaGYxeThZUlExL3dnZkptSThpUXUxVDVO?=
 =?utf-8?B?aUxMMHIwQUdGc3dVYXU3L3lNcnVZZmpRVk1XbmZvRGJvcHF6VFhRMDFPQnNH?=
 =?utf-8?B?aVlOQWJENmxMak1OVFJ6TGduWUs0ZUFkdDZWMkdCR2UvY1ZvUjdhdDFxamJF?=
 =?utf-8?B?N1Jodys3UStId0ZpSy83YU1XU2tlMEI4UHU5WVc2YnFMOWh3RnkvTXZKdGt0?=
 =?utf-8?B?b1ZZME5zZ2haOCs0dG5UMjFOdmw0N3B4bTB4SnBmUUpvSTZYMmtFQjBZMjFZ?=
 =?utf-8?B?RWF5NjhMNm9XaFNudk9wclBnQVZlcHVJWlQrTU5COFBqNGswUUwxL09uWDZC?=
 =?utf-8?B?d2R1bkx6VStvdkF2WWkza1F6RnozRnBDa1RaTEpHdlNIaGFlbDUwRXNZNTRG?=
 =?utf-8?B?T3lJVEdJZ0JyczhqS2pKSXRrNCtkdjM4OWZORnVvZWhNU3YxY0Faa0w4SzdZ?=
 =?utf-8?B?YUJhMFVlQ0VZdFpGTEx6SVdVQmVXRGdKRHFOdElqQ3pUQittS1VVQ0RibG1L?=
 =?utf-8?B?QllRdTRTalRHMHRoZE9nZUpQRHhxbEpQdUhtb3JGZTFrWGcwWFRwbml3ZEp0?=
 =?utf-8?B?dGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef361f3e-c29f-448f-8fec-08de30ad1517
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2025 07:41:47.3956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y7nailLwK7dAMui2WmRef/zUZ8M0dMSKmbJ2v3vqPNoQceFllSMkJT6LTn85z498QxzSYE7OPnt2qLJWugyBzRZe5pVGwsYvwhrSkqIoz18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9252
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2xlcGVja2ksIEpha3Vi
IDxqYWt1Yi5zbGVwZWNraUBpbnRlbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgMjgs
IDIwMjUgMToyOSBQTQ0KPiBUbzogTG9rdGlvbm92LCBBbGVrc2FuZHIgPGFsZWtzYW5kci5sb2t0
aW9ub3ZAaW50ZWwuY29tPjsgaW50ZWwtd2lyZWQtDQo+IGxhbkBsaXN0cy5vc3Vvc2wub3JnDQo+
IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwub3Jn
OyBLaXRzemVsLA0KPiBQcnplbXlzbGF3IDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPjsg
Tmd1eWVuLCBBbnRob255IEwNCj4gPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgbWljaGFs
LnN3aWF0a293c2tpQGxpbnV4LmludGVsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIGl3bC1u
ZXh0IHYyIDUvOF0gaWNlOiB1cGRhdGUgbWFjLHZsYW4gcnVsZXMgd2hlbg0KPiB0b2dnbGluZyBi
ZXR3ZWVuIFZFQiBhbmQgVkVQQQ0KPiANCj4gT24gMjAyNS0xMS0yOCA5OjM2LCBMb2t0aW9ub3Ys
IEFsZWtzYW5kciB3cm90ZToNCj4gPiBPbmUgc21hbGwgc3VnZ2VzdGlvbjogcGxlYXNlIGluY2x1
ZGUgcHJlcmVxdWlzaXRlcyBpbiB0aGUgMC84IGNvdmVyDQo+IGxldHRlciAoZS5nLiwgYGlwcm91
dGUyYCB2ZXJzaW9uIGFuZCB0aGF0IGNvbW1hbmRzIG5lZWQgcm9vdA0KPiBwcml2aWxlZ2VzKSwg
c28gdGVzdGVycyBkb27igJl0IG1pc3MgdGhhdC4NCj4gDQo+IFJvZ2VyIHRoYXQ7IEkgcGxhbiB0
byB1c2UgZm9sbG93aW5nOg0KPiANCj4gLS0tDQo+IFRvIHJlcHJvZHVjZSB0aGUgaXNzdWUgaGF2
ZSBhIEU4MTAgKCRwZmEpIGNvbm5lY3RlZCB0byBhbm90aGVyIGFkYXB0ZXINCj4gKCRwZmIpLCB0
aGVuOg0KPiANCj4gICAgICAjIGVjaG8gMiA+L3N5cy9jbGFzcy9uZXQvJHBmYS9kZXZpY2Uvc3Jp
b3ZfbnVtdmZzDQo+ICAgICAgIyBpcCBsIHNldCAkcGZhIHZmIDAgdmxhbiA0DQo+ICAgICAgIyBp
cCBsIHNldCAkcGZhIHZmIDEgdmxhbiA3DQo+ICAgICAgIyBpcCBsIHNldCAkcGZhX3ZmMCBuZXRu
cyAkcGZhX3ZmMF9uZXRucyB1cA0KPiAgICAgICMgaXAgbCBzZXQgJHBmYV92ZjEgbmV0bnMgJHBm
YV92ZjFfbmV0bnMgdXANCj4gICAgICAjIGlwIG5ldG5zIGV4ZWMgJHBmYV92ZjBfbmV0bnMgaXAg
YSBhZGQgMTAuMC4wLjEvMjQgZGV2ICRwZmFfdmYwDQo+ICAgICAgIyBpcCBuZXRucyBleGVjICRw
ZmFfdmYxX25ldG5zIGlwIGEgYWRkIDEwLjAuMC4yLzI0IGRldiAkcGZhX3ZmMQ0KPiANCj4gQW5k
IGZvciB0aGUgJHBmYjoNCj4gDQo+ICAgICAgIyBlY2hvIDIgPi9zeXMvY2xhc3MvbmV0LyRwZmIv
ZGV2aWNlL3NyaW92X251bXZmcw0KPiAgICAgICMgaXAgbCBzZXQgJHBmYiB2ZiAwIHRydXN0IG9u
IHNwb29mIG9mZiB2bGFuIDQNCj4gICAgICAjIGlwIGwgc2V0ICRwZmIgdmYgMSB0cnVzdCBvbiBz
cG9vZiBvZmYgdmxhbiA3DQo+ICAgICAgIyBpcCBsIGFkZCAkYnIgdHlwZSBicmlkZ2UNCj4gICAg
ICAjIGlwIGwgc2V0ICRwZmJfdmYwIG1hc3RlciAkYnIgdXANCj4gICAgICAjIGlwIGwgc2V0ICRw
ZmJfdmYxIG1hc3RlciAkYnIgdXANCj4gICAgICAjIGlwIGwgc2V0ICRiciB1cA0KPiANCj4gV2Ug
ZXhwZWN0ICRwZmFfdmYwIHRvIGJlIGFibGUgdG8gcmVhY2ggJHBmYV92ZjEgdGhyb3VnaCB0aGUg
JGJyIG9uIHRoZQ0KPiBsaW5rIHBhcnRuZXIuICBJbnN0ZWFkLCBBUlAgaXMgdW5hYmxlIHRvIHJl
c29sdmUgMTAuMC4wLjIvMjQuDQo+IEFSUCByZXF1ZXN0IGlzIGZpbmUgYmVjYXVzZSBpdCdzIGJy
b2FkY2FzdGVkIGFuZCBib3VuY2VzIG9mZiAkYnIsIGJ1dA0KPiBBUlAgcmVwbHkgaXMgc3R1Y2sg
aW4gdGhlIGludGVybmFsIHN3aXRjaCBiZWNhdXNlIHRoZSBkZXN0aW5hdGlvbiBNQUMNCj4gbWF0
Y2hlcyAkcGZhX3ZmMCBhbmQgZmlsdGVyIHJlc3RyaWN0cyBpdCB0byBsb29wYmFjay4NCj4gDQo+
IEluIHRlc3RpbmcgSSB1c2VkOiBpcCB1dGlsaXR5LCBpcHJvdXRlMi02LjEuMCwgbGliYnBmIDEu
My4wDQo+IC0tLQ0KPiANCj4gPiBPdGhlcndpc2UsIHRoZSBpbnN0cnVjdGlvbnMgYXJlIGZpbmUg
ZnJvbSBteSBzaWRlLiBQbGVhc2Uga2VlcCBteToNCj4gPg0KPiA+IFJldmlld2VkLWJ5OiBBbGVr
c2FuZHIgTG9rdGlvbm92IDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT4NCj4gPg0KPiA+
IFRoYW5rcyENCj4gDQo+IFRoYW5rcyENCg0KDQpHb29kIGRheSBKYWt1YiwNClRoYW5rcyBmb3Ig
c2hhcmluZyB0aGUgcmVwcm9kdWN0aW9uIHN0ZXBzIGFuZCBjbGFyaWZ5aW5nIHRoZSBlbnZpcm9u
bWVudCBkZXRhaWxzLlwNCkluY2x1ZGluZyBwcmVyZXF1aXNpdGVzIGxpa2UgaXByb3V0ZTIgdmVy
c2lvbiBhbmQgcm9vdCBwcml2aWxlZ2VzIGluIHRoZSBjb3ZlciBsZXR0ZXIgaXMgYSBnb29kIGlk
ZWHigJRpdCBoZWxwcyB0ZXN0ZXJzIGF2b2lkIHN1YnRsZSBpc3N1ZXMuDQoNClJldmlld2VkLWJ5
IHN0YXlzIHZhbGlkIGZyb20gbXkgc2lkZS4NCg0KQmVzdCByZWdhcmRzLA0KQWxleA0K

