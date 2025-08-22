Return-Path: <netdev+bounces-216118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA6AB321B7
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 19:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F3E01D63C18
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 17:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26BA285C90;
	Fri, 22 Aug 2025 17:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j6Fg6RIf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3022459E5
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 17:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755884956; cv=fail; b=Zr2KkkkSyQsBjIsI6cg6DTBXKqTh6p+iBRdzkuOoxRAo+0DG1e8a6Rp8N9MBP5bc8zFZkfndJtF7bsOb7fC82C1sIsf1RNyQV1Gfu1X2gFiOp4SgtiiILhqPr3SycqpyfYbx+YZLAHlfoJ6N6lGgNZdJWz+/q7LSJjwnbuM+Pbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755884956; c=relaxed/simple;
	bh=34TUjBRPv42i8SEGBSPJCIR+qEVRFfd4GfHSieeRVYg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qy8PzFnMBwxUUsUHWHhDQvqMSnqvyGugg6HVsx6FkmCOXJmm77+hzLJzXXo3lxIHxHPc3C+y6E27EkqqZuQYR0oYCXjEgOv3DmmUkEWDfRf0ogaWe2rgHdeqfFsHjlVD1jJMP/mFN/kYVK7mcnVd1QJzP91gIXjFSKCeTyNajgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j6Fg6RIf; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755884950; x=1787420950;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=34TUjBRPv42i8SEGBSPJCIR+qEVRFfd4GfHSieeRVYg=;
  b=j6Fg6RIfSvugiSMBnbhopGjAqFAzDilTSEywLfZGhYjSiqaXR/i+p6Vk
   ahqsmj/jOG1oaaOviZsxL2Y5pTPLApZ7k7WjCnOe1vTlTUD56o8lkWk/E
   R0fJeOmEY3hOkOnl+uU8lIHV8iRTFNleR2qki687nfxwzhttvRe6oXOr4
   3dMzOz9CVjhbVbSjxTt3xAs0iO2PKu+ox/TbBh/vC37R10g8VQdS5Une2
   CpMhb+iKdyx4MAtyADZrKMMi+akZU4sSU9pOWxClo8LYOEnijhWVmZZa0
   MTosI5HN6or9qmXDQGOEq4YYxlWbAsbcjBcupODLn6Pn3MJq6faT0Hp3e
   Q==;
X-CSE-ConnectionGUID: ZWL8FvAZRwqM4YqxXsPffQ==
X-CSE-MsgGUID: Spuyv61QRGCocgIFuuCxGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="58124223"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58124223"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 10:49:09 -0700
X-CSE-ConnectionGUID: l7n5OszvRmeDAnIangNrYA==
X-CSE-MsgGUID: xIFZRgK+SxqrzrFYtoAyDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="167989344"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 10:49:09 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 22 Aug 2025 10:49:08 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 22 Aug 2025 10:49:08 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.42)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 22 Aug 2025 10:49:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a13K8SCZAhIQtQNZoPEfvuEAKucXPkWEaIj1xg1SLmMx5iiYJWHMnvLiNO45BrpN2gyZDakQvz8UmrHOlEe6rXAsZm7HPeHEugLSdhy1boIVtwKQ/Qy5TIVPgSf3zE0DKC7w+8KUQ8FG3TjRb1WACx6EcJU+zRASGXKJrtIEX81U7tjYFz8pa9ugWyC/VnkdAOT9dM7Kg/Ta38NH5YavRMysXw3fPcZLhbsCZsXWC46rTnAFWyZXwaAXYuDXKqWpe1doyt913sTM8SsH0bbqqkicYFm878uYlhBH9MChPD4lI2++vhzLoQeQHSlgyGX6Ip1pEh18u5NBMr57H+Aq2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTZqLAHydrgKDAMnxVvHMacYOjp7i6O5MMnIvxPGtDI=;
 b=wT4f8013mIzZnMpp29Ft5yAOgcSe8+iTkaMKm9v52b49PE2vR6Ug2MTOLw8/2W92Hs52GNzEIjMhp0iZC1Vqtv2gvOASzgUhMusPZZ5kuqDb7crX8/O5TC2oesGeMRpT/aSw1K8ji/ha3YO3WJt+eMRAOm5Cxm2KnUMHPjPz00b68pPcpu/ErvRIZQYAxMKkXvfiHZl9Zo3+i9mqSp14QayG1CbZijaUjlHQgpNfMQPSNpPWeWi/sz90f3CJQhPzKYKqWrJObJHIl0hskfs6c6Igo56XRzAXARnzQYDBfo9AgTVH5c4DoUtgRaqy22hy0UByWCJh4Y4a7WmIgsHBGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by SJ5PPF867D7FF5E.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::83d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 17:49:05 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21%5]) with mapi id 15.20.9009.013; Fri, 22 Aug 2025
 17:49:05 +0000
Message-ID: <8dce1f98-2d7f-4997-a2a2-86f5b24587a6@intel.com>
Date: Fri, 22 Aug 2025 10:49:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2 2/5] ice: add virtchnl and VF context support
 for GTP RSS
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <mschmidt@redhat.com>, Dan Nowlin
	<dan.nowlin@intel.com>, Qi Zhang <qi.z.zhang@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>
References: <20250818123918.238640-1-aleksandr.loktionov@intel.com>
 <20250818123918.238640-3-aleksandr.loktionov@intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20250818123918.238640-3-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0304.namprd03.prod.outlook.com
 (2603:10b6:303:dd::9) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|SJ5PPF867D7FF5E:EE_
X-MS-Office365-Filtering-Correlation-Id: ddd73e0b-99b4-4352-5083-08dde1a42fc0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmlaamQrZHJLSzJrWWNvZkFOV29TUEZCODJkcFFSZlU2WkhCSUE1aDkvMnJ1?=
 =?utf-8?B?NC82UzBZMTNkT01SZUhONTdvRGhyVzI1M2RDWS9INGpOTUV6NUljVmVHL2xE?=
 =?utf-8?B?eFM4UldLK3Rna3JlRGZDaUxPRm1ZYzRJTVJwUjhmM01XSUJwT1VFRnVZc0Ew?=
 =?utf-8?B?SmxocEdTVVZ0UEV2NkwxQkRYUGthUXBIQUVPQlM0OHphZi9UMmp5SGRzc3hH?=
 =?utf-8?B?Y091TUEzM0pvVnhYdGhOTkNOaENwNTlkcWdMbGpxZjI4QkkvOGJneHVCb2F3?=
 =?utf-8?B?bTliRUhtM3NvMy9haDlOMmh2QU5zRklYMnZzWWtxZkRjVDBxUy9oZ1U1SDJ2?=
 =?utf-8?B?dUFpQmZ2QXQvNjEzb2NYYVVSOEhRQ2JScS9YTE03WGF2VlJJODdzajg4NTlB?=
 =?utf-8?B?UFBOMktSeEV5a1FBTllFSE84M1NUVkVYRjZCMjZZOXd3UkFMWUVibDVRUlBE?=
 =?utf-8?B?anBUTUp2dy9Jd09ueGk0eUV5dkFXWnNxNk9BeEVzT0l5ZnEycFgrOTVpRmdz?=
 =?utf-8?B?MGpyTG84MExjQ0VBUU1BUU9vZDlyTmJ5UHpSbHRHYlIrVlBzbURxcE5Gc2FG?=
 =?utf-8?B?d3gvc0hwYWs3MWpiemNISUZCS1VDUDlHSHpLdDdCNXEyQnNCR2gxb0hpa2pt?=
 =?utf-8?B?azJtd1laVmdyakNmOXVsVkIrcUZSaWFEZ09xV1ZwTjNNQXBsaEh6dGNobHYv?=
 =?utf-8?B?dUVacmJYVUFzbW5NeEdSaHM4ZlZDNkF4akpYamZ2YkhmQUNkcVVYRVNNM240?=
 =?utf-8?B?VjNhTUlwTHlyR2ZoT29VZGMycVhIalJhZnBwWVZSRG1RakYxWnpOOTFqbmlw?=
 =?utf-8?B?WHJIQ2NPbGo4NmpSYm9jeUc0cnA1S0Q3Nkc0OTNmUzFocDVuSUxtRGYxWjQ2?=
 =?utf-8?B?NjhqUytTcS9UUWhrTDdiR000eDlka05MejZnbytMbkNEMXo5UFpYY1dTOWlL?=
 =?utf-8?B?TWRNb01kSkprSFU5YzR0QmNneXc0Sjh0Y01CQThISGI0M2ZsMXkvT1ZIWWFG?=
 =?utf-8?B?K1NiZXpMMjZNSEIxWUFpank3bDR6bjcvQkxsSXVlRzJpNCtGU0p0cFNlWFJ3?=
 =?utf-8?B?NDh5QUpZRW00dnUySGVXTmU3UVNrc2JWVHRVYjI4VHhnV3UvNEYwcURZZlRY?=
 =?utf-8?B?MW0rR3krVTl5a1JTSWEyQnljbTYzajhDaHBZcUVqWmphWU5LZmtUWTNHRjV1?=
 =?utf-8?B?RmFMZHpjWWEwUzVXWmtyMHFkYTlTdzNtSkJlLzFwMTl6YS9mUU1CYW9MMVdM?=
 =?utf-8?B?andlVzNzS0p6RGtEUW40Znl5UXY5R3haelRmTEd4YmM0YWtUZGhYTnI3T0Fv?=
 =?utf-8?B?VHczWXRiZ1lYekNINnl0TlNYQlR4d2hrUWZRclEyOXdleStUNVptSVRlNXdV?=
 =?utf-8?B?eXRYdVFVK1ZoNGZmdkhveEpJMHNLdHRGNXFpU0Y5a3hVRldLek5kY2ZtdGxm?=
 =?utf-8?B?YVo2S21SazhkZ2NPYnFKK3JOdThPRnBmcjY3UDN0SWZrMGZ2cTBkaVBtZEpr?=
 =?utf-8?B?NW55b2JHVWhXNjF5cHhYUW9NVTVJcWFWUWNoTFBXSTlHZ1JTUkhKM2pIVkZo?=
 =?utf-8?B?WUVvVlFZNm1EbDRBa0tQMkVrWkVFTzFDRlJ4cG9xQTdEeGd6bXVlUWJFRDR5?=
 =?utf-8?B?My90ZlF1SEszQ0FWU1kySnpsbS9VdjhyTHBqMXdLRjEzZDNDTlNwemt1ODhi?=
 =?utf-8?B?NktQeVA3eTluRUN5Wm9Vd2xtVnczQnVUUGpSQ2J1aGYyZHYxUlZ6d1lEcVRI?=
 =?utf-8?B?OEYwQVpYK2hLWTBod1JLUTRsWE9rMldXc3lnaWoweDlybkNUK0tZN0g1clJT?=
 =?utf-8?B?RVZXN3N6MVc3S2MyR0pvREpvNS8zRTZtUlNzaTV2Um1wMUxMWlNGR0Q0Ump4?=
 =?utf-8?B?ZTBOUS9hTjFGSWVXU2ppSmR2L3kwZmIrYkhFQ3Rjb3QySlE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEdOUkdBZDd0ZmlQNjFDK3ROdjZ1aHBuTkFNdHduRkxSeVFJZ0F2THlZck8z?=
 =?utf-8?B?Nm5rUFFKaXVVa09pWXBJS216akVldTZ0dTkxTENWRGk5Tlc4Ti9JK1Vsc3l5?=
 =?utf-8?B?WXJUVWFGMnVSdUJQN25RMEJJWW13a1pqbHFHMC96YzlVN1pFMTJEa3RQd2RJ?=
 =?utf-8?B?cVBLeGlGWkRIYmNKR3p3ZjVxVzBxWTFEL3J3RzRkbnl0aVFnTlZjMVJXcHNh?=
 =?utf-8?B?OVlKeFRYYTE1Ni9STS93TU5QcXpiTUNtRWJRblFzYnhCQmVhTmpPNDdUWTMv?=
 =?utf-8?B?WHJNMlZ0V2FSclI4VGM5dlVPUDc3UWFDYmQ5ODBGQ2c5ZXdPVnNIcjBOTGZ0?=
 =?utf-8?B?cE1vck1CZXJIMEhPbURUdzBGNkxFWWhLVXV1TUhsYmFIWUJhSmI3eGdJaGgy?=
 =?utf-8?B?dVdxNk5RTTBqTzV5SytqKzE0SHdrUXdSSkQ0Tjd1Y3ZMNEQ4SGZoeG1jbDU0?=
 =?utf-8?B?ei84eWhMKzd3MGUxbHdoSi82S0ZMZjFyd0ZEOFkzbEVjMnJkSjF2UG92OGRO?=
 =?utf-8?B?ajh6bm1wSnF0ZUFHQmFIeVBWL2hjK011eWpoRyt4TlBodWhHSVVvMU4rSDIx?=
 =?utf-8?B?OUVKczVCeTFGaS9hcEZMb0lwN3FNM3kwZERUdm14WkxSZ2xQeW5CTmFnSDJB?=
 =?utf-8?B?cXhrTGVpQzZ0eWRxTWJoSWQ1QldGY2VvV3NMVkNYa01BVjZXTi9IQ1IwMkFK?=
 =?utf-8?B?cDZOZG41K3RiTDREUjNRVVFkRGRkVDE4eHFIbjlubkxFTVl5NlhQNGFuNUhK?=
 =?utf-8?B?Ym0xQmZ4WDdSZW9Xem9NQ1hrVEZaZ2ljMWIybkcrMGViMXhscCt6dy9kd2Ir?=
 =?utf-8?B?cmdvMzVURDdTV0QwNlRUUGhTeTFzNGhVWFJyVmJpTGVJR1NFOXBxQjdUSG03?=
 =?utf-8?B?RzdwMXJMUlZ3T2dPS243YXk2aXBndDhJaXBlYmpyVVdaZ2R2YkNRZzBXLzc0?=
 =?utf-8?B?SjVhOWdLOERmL1FQWmZSVXlJcUNDWVE4aXhGK1NNSHl2NU40dzhHbndManRY?=
 =?utf-8?B?WHN2NklMZENnMlZvMk9oMERRQ0FMaVhkdkFGQkwrbzJZeUNhYTUzcCtvZzRO?=
 =?utf-8?B?OG9nL0JQUEl6U3dXTXFXLzZ2N0NSbTAzaGZmOWtsUk05VTBYMSt6Tk82cDNi?=
 =?utf-8?B?V096UDNJMUpUNFFNT1dwWThXUDg0ZitZNEpKdU12WkhFTDBqaytpZlZScTNF?=
 =?utf-8?B?UmcwNjFvQ2R3ZFpsT1ZvbE5Tb1drUmlmaVlLVTdDUk1SV294a25ueUlLSnln?=
 =?utf-8?B?L09jVGNyQllsTDExRlBrSDR0TnFOVmhHdkdZSk1udGo4UEQ4c2VDUEh4YzJp?=
 =?utf-8?B?SmVBdUZIM21sajU2c2JJb2ZuQ2tJL0p2MG9wRnAzZVBPZG5XcTBjVG9kTzNV?=
 =?utf-8?B?N3BlQTludkgwRlBoMkxSbTZ6R0dFb2ZVVjh6YndQRFVyQWVEK3FOSmNrUnE4?=
 =?utf-8?B?bkdrMHh4UWFia25uemNNZFltREJaUU5UUitYUDZUZ01BNENidXJJaG9ZTTI1?=
 =?utf-8?B?ei8wam42cjlJaGVER2x5aFZmUC95T3MvTU1Sa1ErdEhsZjI4STQ2cENaMW1D?=
 =?utf-8?B?VGVCWFhtdi91NVU1QVd0KzhSc1VTbmVuRUNvcktja3g3SlI0TWZwdnRzSEl2?=
 =?utf-8?B?NnRUd0xpUWJJS0w0NEJ4YVI5SWpyTVlsTGdkekNGQ1ZRZTc4bmg4ZHVyNTRj?=
 =?utf-8?B?NS9qdUZPTU1PSWVHNHl0Q0ZURTdNYXpYS1VubVhyUjRjTGpBRVBwVHZCbUxN?=
 =?utf-8?B?NWJqcENxK1k4czRZMWljWDNyZlJldytwVkRMYTd6NWwvNjVUSjB1L0RnL3ZB?=
 =?utf-8?B?OUVtODdiT1hZams2WWNQUGkvckhPZDh0MHp3eisxa0kxc3FDdlNLTkZWajNa?=
 =?utf-8?B?TU1zdWRoaTE2emQ1eVlvRDNvOVgwRW9nUVFCaWZJSXZRQVNDcUpvU2FjQjUv?=
 =?utf-8?B?cExaTHl6QzlWbHFKc1lScTFBa08xek9mdmY1bmlqYUxnbUxKbVZjWDlxUG9z?=
 =?utf-8?B?U3ZtWHJvZ1VFckJudndUejFHM1h1VDhsV0J6TzJPc1RlY3FKcGc5MitPVk9F?=
 =?utf-8?B?SUcvZmtXdFdQaWs4YmVvbUR6N2lTRnA2dno5ZlJDbzN2UXJwSzR2NTJ6dXdP?=
 =?utf-8?B?RmJqczBzdnBxay9KbXJHdVdER0VIVjZWdSs0bFFEODFoMWdvSXJKOENnNEVp?=
 =?utf-8?B?UGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd73e0b-99b4-4352-5083-08dde1a42fc0
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 17:49:05.0949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LnN19ZjrIVDNfX6uyV94CEN4tLw/rvQSuhI/RfCa5DuGkJeZIBlFaD7jS1wGuijSNhEOnpDiSYqzGNKszpQqdZvI5mkjJO0uIzwOfDQmEOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF867D7FF5E
X-OriginatorOrg: intel.com



On 8/18/2025 5:39 AM, Aleksandr Loktionov wrote:
> Introduce infrastructure to support GTP-specific RSS configuration
> in the ICE driver, enabling flexible and programmable flow hashing
> on virtual functions (VFs).
> 
>   - Define new virtchnl protocol header and field types for GTPC, GTPU,
>     L2TPv2, ECPRI, PPP, GRE, and IP fragment headers.
>   - Extend virtchnl.h to support additional RSS fields including checksums,
>     TEID, QFI, and IPv6 prefix matching.
>   - Add VF-side hash context structures for IPv4/IPv6 and GTPU flows.
>   - Implement context tracking and rule ordering logic for TCAM-based
>     RSS configuration.
>   - Introduce symmetric hashing support for raw and tunnel flows.
>   - Update ice_vf_lib.h and ice_virtchnl_rss.c to handle advanced RSS
>     configuration via virtchnl messages.
> 
> This patch enables VFs to express RSS configuration for GTP flows
> using ethtool and virtchnl, laying the foundation for tunnel-aware
> RSS offloads in virtualized environments.
> 
> Co-developed-by: Dan Nowlin <dan.nowlin@intel.com>
> Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
> Co-developed-by: Jie Wang <jie1x.wang@intel.com>
> Signed-off-by: Jie Wang <jie1x.wang@intel.com>
> Co-developed-by: Junfeng Guo <junfeng.guo@intel.com>
> Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> Co-developed-by: Qi Zhang <qi.z.zhang@intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> Co-developed-by: Ting Xu <ting.xu@intel.com>
> Signed-off-by: Ting Xu <ting.xu@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_vf_lib.h   |   48 +
>   .../net/ethernet/intel/ice/ice_virtchnl_rss.c | 1297 ++++++++++++++++-

I don't believe you are based on Przemek's changes as this should be 
under virt folder i.e. series doesn't apply.

>   include/linux/avf/virtchnl.h                  |   50 +
>   3 files changed, 1340 insertions(+), 55 deletions(-)
> 

...

>   
> +/**
> + * ice_is_hash_cfg_valid - check if the hash context is valid
> + * @cfg: pointer to the RSS hash configuration
> + *
> + * This function will return true if the hash context is valid, otherwise
> + * return false.
> + */

Many of the kdocs are missing the 'Return:'. For the boiler plate kdocs, 
we should probably just remove the kdoc altogether.

Also, as "This patch..." is not liked, I feel we should avoid starting 
many of these with "This function..." Saves some chars too :)

Thanks,
Tony

> +static bool ice_is_hash_cfg_valid(struct ice_rss_hash_cfg *cfg)
> +{
> +	return cfg->hash_flds && cfg->addl_hdrs;
> +}
> +
> +/**
> + * ice_hash_cfg_reset - reset the hash context
> + * @cfg: pointer to the RSS hash configuration
> + *
> + * This function will reset the hash context which stores the valid rule info.
> + */
> +static void ice_hash_cfg_reset(struct ice_rss_hash_cfg *cfg)
> +{
> +	cfg->hash_flds = 0;
> +	cfg->addl_hdrs = 0;
> +	cfg->hdr_type = ICE_RSS_OUTER_HEADERS;
> +	cfg->symm = 0;
> +}
> +
> +/**
> + * ice_hash_cfg_record - record the hash context
> + * @ctx: pointer to the global RSS hash configuration
> + * @cfg: pointer to the RSS hash configuration to be recorded
> + *
> + * This function will record the hash context which stores the valid rule info.
> + */
> +static void ice_hash_cfg_record(struct ice_rss_hash_cfg *ctx,
> +				struct ice_rss_hash_cfg *cfg)
> +{
> +	ctx->hash_flds = cfg->hash_flds;
> +	ctx->addl_hdrs = cfg->addl_hdrs;
> +	ctx->hdr_type = cfg->hdr_type;
> +	ctx->symm = cfg->symm;
> +}
> +
> +/**
> + * ice_hash_moveout - delete a RSS configuration
> + * @vf: pointer to the VF info
> + * @cfg: pointer to the RSS hash configuration
> + *
> + * This function will delete an existing RSS hash configuration but not delete
> + * the hash context which stores the rule info.
> + */
> +static int
> +ice_hash_moveout(struct ice_vf *vf, struct ice_rss_hash_cfg *cfg)
> +{
> +	struct device *dev = ice_pf_to_dev(vf->pf);
> +	struct ice_vsi *vsi = ice_get_vf_vsi(vf);
> +	struct ice_hw *hw = &vf->pf->hw;
> +	int ret;
> +
> +	if (!ice_is_hash_cfg_valid(cfg) || !vsi)
> +		return -ENOENT;
> +
> +	ret = ice_rem_rss_cfg(hw, vsi->idx, cfg);
> +	if (ret && ret != -ENOENT) {
> +		dev_err(dev, "ice_rem_rss_cfg failed for VF %d, VSI %d, error:%d\n",
> +			vf->vf_id, vf->lan_vsi_idx, ret);
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * ice_hash_moveback - Add an RSS hash configuration for a VF
> + * @vf: pointer to the VF structure
> + * @cfg: pointer to the RSS hash configuration to be applied
> + *
> + * Add an RSS hash configuration to the specified VF if the configuration
> + * context is valid and the associated VSI is available. This function
> + * attempts to apply the configuration via hardware programming.
> + *
> + * Return: 0 on success, -ENOENT if the configuration or VSI is invalid,
> + *         -EBUSY if hardware programming fails.
> + */
> +static int
> +ice_hash_moveback(struct ice_vf *vf, struct ice_rss_hash_cfg *cfg)
> +{
> +	struct device *dev = ice_pf_to_dev(vf->pf);
> +	struct ice_vsi *vsi = ice_get_vf_vsi(vf);
> +	struct ice_hw *hw = &vf->pf->hw;
> +	int ret;
> +
> +	if (!ice_is_hash_cfg_valid(cfg) || !vsi)
> +		return -ENOENT;
> +
> +	ret = ice_add_rss_cfg(hw, vsi, cfg);
> +	if (ret) {
> +		dev_err(dev, "ice_add_rss_cfg failed for VF %d, VSI %d, error:%d\n",
> +			vf->vf_id, vf->lan_vsi_idx, ret);
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +

