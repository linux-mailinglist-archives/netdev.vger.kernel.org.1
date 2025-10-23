Return-Path: <netdev+bounces-232175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5FFC020D1
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 17:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F293A4D71
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 15:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79723330B35;
	Thu, 23 Oct 2025 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YYr9MV6j"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC3626AEC;
	Thu, 23 Oct 2025 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761232197; cv=fail; b=uOeFifTGRCEjsuywWlO+VMG4jveCJSlZda5M9+K0SQWM1tXu61zvmPHU6UfQp3ApxDXlJBTsSnF78Px6ukq/h4daz0I6by1XXAiLrPaVK9JJTsRtvZ2HrN+lIp3VnD3kE0Otq+gZj9IimABI43D7O5SVhOdJktIKUPkUFxgX4tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761232197; c=relaxed/simple;
	bh=QZ3j20Ch5JBTnxC9wTWO23BH1YlXE47woZT27n43QOU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=grf8nZ5QjRZjQTKacLk5o7qT/ZTgMFenTk2+JMJ0DzOOi3uO16iILAl+CnsF64Z/LKPsxWw+TGGTcMvEUXpeeL+IB/4w7SXcsO0zjSkVpnXyC2nv5Qt6xqFPsxQ/H3OlJIGVPhMyuVAwY8rq8JkTPHE/c83ICyHFlRHnj+Wf+5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YYr9MV6j; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761232195; x=1792768195;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QZ3j20Ch5JBTnxC9wTWO23BH1YlXE47woZT27n43QOU=;
  b=YYr9MV6jBW0dGMH4hyRQUZ+xz3C5/snCU4tksOeGP5WR2JjQPMsDC0z4
   VO3MV+rE545KfCZYf8QWzObVHhnSYegKLe9HCGyb4E7qlEVSFscxjfEIM
   CcPLL5BhjLXMGGmvKoM9zfg0eNzK8KktcSfgKbZ+/btv2wkaz5q7/8sPx
   +LeL68JYlwwWmgTkRmEofMmsI0bObQ7eMHAVwgItSC7ql1Ql5HhELbAeC
   LP7RZnoW5E2rYkXkvV4QekDYEJ+YlcmEpPbCRr8eX7jjKfuXAI1T7c7C6
   NBSGonXAgn2CrFFkRiEND/AUzlgYnlaqDxzVDd6sCJ4xq2bOVnNA+7W4d
   g==;
X-CSE-ConnectionGUID: P8F6EaItT0CzqAPpyFElqw==
X-CSE-MsgGUID: 6jtp38GnTTep+JiPILF/gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63308159"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63308159"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 08:09:55 -0700
X-CSE-ConnectionGUID: r+KFatuHTQ+UMQoB0VLHlw==
X-CSE-MsgGUID: Hy4xxrMsRNa5d7dwNhXY4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="184108533"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 08:09:54 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 08:09:54 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 23 Oct 2025 08:09:54 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.15) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 08:09:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hq8cgSiTcoo3IybRiZqOFq+UIDQzx0zE8aGzJDyoc8bL6MaJA2932K2IH+Xjxw177z3wAsReyNxUqiXsE4YjKZzR0f/Tc7dHVQm4O681PtyVIN60A8ici02gYISoFgNBpYnPDrEg1oD89ECDoNnM2QHtmLCdjC6jM1Y5LZNjw2XW8sh3mEB/91y3MoPB/ZDuyTFk/H/2slGkZDQFy6yaE2Os6CwK39ImC8Btg7DPD6Qx3h1HMuh7GqWqKsVCCKiQFMynmnbCE1MAqYZ5YBf7q4zXmXuCai5xXvFPRxW07cnQ1cIfmxAK9bcwCl2FOceNvwiGOmPoj2WGZLBhW8H+lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADEERbEhdppCH5Wn+8bAtaTVlX4RXv85r6vYNNLLvFA=;
 b=V4Rr9KXKSYKuQTU2CbIIRic4WQiaOBhWvNGA5DCNz77JKYTyLulnNhUeadMaoAs7GS8s6P4J/VEIbB1r8kmthFQqBHwJbTsXJq5qGyhcDyrJOxUEOnP3bQwQxAOYF78qxDQOtq1ZRW4jnP7YvKb9CrckEuOV3KtrSZA72kWHDTsJBT9LogUQLL8rUOIZUdEVzyJejYnuqFDbiG3qykcvu1kRSpqi1VoNjXdu6Oz755l3eeBNnLoTL+SHvJbSOobodSy/3SjnEMtc+88MqJLZGutQe4Tc6bf7jtc+SVseoWif12IZF6pb+u5F4zvtf4B3W0dpOiTJNbpAkLnixxcmRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SN7PR11MB6797.namprd11.prod.outlook.com (2603:10b6:806:263::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 15:09:44 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 15:09:44 +0000
Message-ID: <79082124-aba3-4737-8a2c-a3ce1a4b8a57@intel.com>
Date: Thu, 23 Oct 2025 17:09:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/2] There are some bugfix for the HNS3 ethernet
 driver
To: Jijie Shao <shaojijie@huawei.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<shenjian15@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<lantao5@huawei.com>, <huangdonghua3@h-partners.com>,
	<yangshuaisong@h-partners.com>, <jonathan.cameron@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20251023131338.2642520-1-shaojijie@huawei.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20251023131338.2642520-1-shaojijie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB3PR06CA0036.eurprd06.prod.outlook.com (2603:10a6:8:1::49)
 To DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SN7PR11MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c250744-3dc9-475d-c4c3-08de124632b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVU3TkhrUThjbFAzRlFGZUJLSHQwbkZKY3Z4SEJBc2pQMGJpNWovdVZwaGZZ?=
 =?utf-8?B?cWJXT2FJbFY1QjhUU0RDa0hZYnltbkQzRFR4UXdvamJSSkxIYmpPOU9XOGZj?=
 =?utf-8?B?VTZvREZXYlZCOGM0L2ZIQ0piejEzYUczVkVSVm4xcDdFdGVGNUdaOHZ4bjc5?=
 =?utf-8?B?MTRZSHIvRW4yelU1ZTdObEFiZ2tNY3VhY3Jwd2Z6aXpuK0Zwc1A4Z002Sktr?=
 =?utf-8?B?VWN1Z3VVZDhlRERPc2F0cW5nQU9GV1d3V3dKdTJWWk5BMC9IYlM1cys1ejZW?=
 =?utf-8?B?eW16Mmh3anJnZ25iS2pRYTdPSXhhb1I2L3N3Ym9qZ3E3cjdjZno2Ymg4M0ZF?=
 =?utf-8?B?TjhOSGxaOWFMSXdsMGp4c1dVVEdaMThKd2tBOXBSbFZKTG5UeHJkcVdwU0k3?=
 =?utf-8?B?Vy9zeldoUVlsanBxeTZZakJjbHFpZHVvWDdXcGVBcGp1MHhHMWlWbUJHSHZE?=
 =?utf-8?B?eWIxNmkySSthaG4rRGw0V2pKekdhakVlM2V0eXR3NFB1SmpSVWFmQzNxNkRz?=
 =?utf-8?B?dHg1KzkzaWcyYlFrZHFlWUhwNHFaamVrQjB6VEw4YTJDTXBtWlkvcE5MY0pJ?=
 =?utf-8?B?WnEyb25EQ3ZQejRnRlpBTnZnWk54NmxLcnZiMi8rNFQ2YUR6RlA0di93U3Y5?=
 =?utf-8?B?ajAxSEVUZGU1L1FzYXNnTXVLZktsUkJyT0svTlRnUFlkTzNtRkdsV0REbnpn?=
 =?utf-8?B?aXY0TEFXaVdMa1dWenlXT09MZExGLzlxUU9PU0x4MEo4YlYzeDZVWW1RVGE1?=
 =?utf-8?B?N2RJdVVFRHJlcXg0YjhGUXNUNUVuUDRzdzJGRHZuc2tvbTluaWFPYXRaT3ph?=
 =?utf-8?B?Ukx0emc1VE9rQlFJenp4dXZIZDVoQk5WUDZBZDgvV29MTThlU2g2RVM2Nmlu?=
 =?utf-8?B?ckoySnpTRVJTSWRPcnRTd0dwZ2JZdkZSSU9MUnZRMGwyY1EzeTdOZzJTUGVR?=
 =?utf-8?B?Ni9rS0R3RW5xVytRVmM1alB4aGVQTzcrZGlxb01OZkdsdGlGcDNTaVo5OVVR?=
 =?utf-8?B?dGlrUGgwdHVjbzBnMytKdkFma2FXVitaVWNDV25FN0NGY1lFV2krNlpRY1kv?=
 =?utf-8?B?Y2U4NlJWdHlvRytLWktpQ2YvN296elFLZ1NFRWVWSDJYbVhpcFYzVlgwSnBZ?=
 =?utf-8?B?WGgraE5qUk80UkhnV25WRi9oN3RWSjhEdDVYUThoelhaalZNcGc5MkQ2eWtK?=
 =?utf-8?B?dXlIaXJQY1pZdXlHV1YydlliSzdxMEYrNGJXWXRYYmdhNjMramR3Zjc2M0I1?=
 =?utf-8?B?L2N4Z3A2eG42QjFwU1ltNEwrMUNCU2NqVXFkdzFsclJkTk1xeUJXM1RoN3or?=
 =?utf-8?B?SktjTzFhajhVN1E5U2lCRkdoTHJyZTZBVWIrK0ZvWVg3dnRnVUw4Y1U3SUpz?=
 =?utf-8?B?QkM1dnhiNjZ4U3ZRdDYvbXJ1YmhsaXRFd2VBaVREbWtUS0VzREdVL3hQWER5?=
 =?utf-8?B?U1BBOHcrYWNTSjkybXV0SU41QVdMbDBFU01VcCtCSVhPVVF6K3VCZWhQZU5v?=
 =?utf-8?B?ZFVTcTlFSE00WW10Z25TSW5wQzFFZjJVSnY3OXVLUDhmN3piaUo3Vi9TU1BQ?=
 =?utf-8?B?U0RFN3ZUMDR4dGkzN3ZFOE51ZVpSSjVkeHFQdWhqdnRjVzcxa3F6U0p1eXFV?=
 =?utf-8?B?N1FKa1NYVzZYY2RTTUt4YTZabkRqRHB4ZFZrd2s4ZmhQamlzNDI0UmVHeUkv?=
 =?utf-8?B?bjNhNnh6QUFsY2pPZ1l5YWthdUpTZ1hCNmtyL2tIV3JKWDQ3U2YxaktYcjli?=
 =?utf-8?B?SXRSZXJRQmQvbVdobFZNeEVCYzhMMjZlRVl4emhGektQMXZFbTMzRkxiUnBL?=
 =?utf-8?B?Tng5bENSQ21FM0dPbldITnN5bDlZQnNQOUN3WEs0TURiZWJ5NFBOU3BhL1ND?=
 =?utf-8?B?NHFObmtJZi9aaHZFWWpBY28vMUVGRjVvUjVXZzdYcndkaitPSkRWb2g5VVE2?=
 =?utf-8?B?REVLNkRUckhoTXc4ZzZMZVJXa1cxb280UG5lczEzbDgvT3FSR3BDclVVZFJH?=
 =?utf-8?B?dXdJL1lET1F3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTU0ZHlvUWRUQUpIc0VJbmEvSnRiMlpqdWlwalpuRWN1QnE4WVRnVnNOZWZT?=
 =?utf-8?B?a0R4RW0wakROYlBWaDFnZEVzd3pQczNGVDZRd25UWis4S0dob2VzWm16SUtP?=
 =?utf-8?B?SWNVU2dMeDlCdmU1S2JZRWEwbWhNa3R4blBqb0RUMHlROCtZa1JLc1dDaGlo?=
 =?utf-8?B?MVkzWGlmNmFvc2lINGRCUSs1a29iTmNGMlRCV2JpWmNLOXN5Y3VWQTBMQklI?=
 =?utf-8?B?RmNtL1dCYWFDWS9HWndRWXBiNWp5NXZJeG42N0Y5emlXYnRoNnFXYXJUQTI4?=
 =?utf-8?B?SDlTYU04anRyaFZlVkd2NmdaSjhyc01GNkdlcnBpVVlKeXJkN0Z4MjFNenpV?=
 =?utf-8?B?dVBpazZGdENGR0xGLzFESnBmQmY5RjVPbE9ySUJLeW4rVHRSMDgrR1AwaFVB?=
 =?utf-8?B?MGV2dHF1MUgyWFRsMEpDTDBKcUxjVjYrSjRFWG1zb1diQ1BwMWdxWUNBS2dt?=
 =?utf-8?B?Y2Qvek1jOGJyTnNPUHhZR2x2bmJleGxmRi9GRzhLOUxuSzBUNldQQnUySXhy?=
 =?utf-8?B?b0dTV0Zvc29iQnZKaFJPcjdpdzBtVlZvVkFsZ3RJM3FTZUVJeDcwWE1zZ1Rr?=
 =?utf-8?B?VFFVc0JVQ3IvMmhMWGpVNEMyaWlMZW9OL1JZeHNxWWJRQXluMXhvQzhVc0NY?=
 =?utf-8?B?MDBGNEFqMGVkdEVRKzJXdTdNdWs1TVVYYk1LRlNWejk4WFFzdDV5c2pFQ3Z1?=
 =?utf-8?B?MUFiRmltUXdCZFA2K0szL3ZXYnYxR056WDRxRXJjVmdwQS9VWk5zQlJXTU9Y?=
 =?utf-8?B?RUV6aTExNmp0cWdQM3dEblRGRXR3OFRscGVOYngzeVBOTnVWb051ZGdCWVV4?=
 =?utf-8?B?c1hzTWxGZmpnSzJoaXZQd0k0Y1VrT0ZuZi80MG51OWt0Q1Qra1QrRWUrUjJn?=
 =?utf-8?B?aWw2Ym8zdFp2anhHSDBCaTJvRVpBN0RGQURyelFSWHZWN3Bramc0dXFHUkM5?=
 =?utf-8?B?VjlVa00ycDJVQWxYZGRVMzZiK3hpU29RSmhxaytCR1duL0pwTGUvNVFUSVpo?=
 =?utf-8?B?WmV3cHJGTXBndnVpbmgxbmFkYytUanRsVlE3TjdQQitTaEt3N1JOYllwVTRo?=
 =?utf-8?B?RXI2VyszdmV5TS80dnF0R3ByVy8yalJIVFl3RDYwOW85c21uOVJ3RmJIS2Vx?=
 =?utf-8?B?bW43THZRK0pvbjg1TFFYczA0NWRLQ0h0aDBvUzlwSU9JeDBUcTZiOUNlL0FB?=
 =?utf-8?B?Mi9uNmxmUEVQK0lDOVFxMzRZRU9iS2pNV0JlMVByRkYxSU9HOHJjSjhNRW40?=
 =?utf-8?B?YkhhTlhmanBkdFk4a1NsTDgxd0s2QklYSGt5WFZYMmVTWDZyWENJcStWZHpB?=
 =?utf-8?B?TXQydmhKdE05NXJIdk4vTnV1Njd4czFONzNrSnYwTEdZMy9FRkNKM2VTMGt2?=
 =?utf-8?B?RjNiT1BRcmVaUFltY2E3U3RqR240aTFKdXBSSDBnTU9pNWdaQ0pKYlNrVGFH?=
 =?utf-8?B?azRyRGhUK01DQW02REJpajNlMEN4cGNqOFpmSW51YnlPUWhkQkxscnQ0Q2sw?=
 =?utf-8?B?bnJLazFEL2VYTUJYaWY1OWZud0E0RnZhVlFBamtCQ1ZQTVVGYTRiSnR6U1FV?=
 =?utf-8?B?KzVBQmZraW9KdHpYd0tOcERiak9qN21RWXJjQjJBV3Y2RzlqWGQzSVY2Qlhw?=
 =?utf-8?B?WWRhdHVjSXFOUUo0clg5V2dWSEg1YU14azB2UzZoa1FJL0xaQmY3RFkxWVJO?=
 =?utf-8?B?YnBwZmhxdUFFaUJRVXNZVnZMdWFrSnpqVURlU3czN0ZnQy9La0QrL1E1d0ha?=
 =?utf-8?B?aWlTd1JQVzhnb1duY1VPTk9NSXBWK3pBUXMzTFNJZHZjRCsxZ2ZzYjFFdVNm?=
 =?utf-8?B?WGMydTd4MlRHdlhpdzdZRURuRDVJKzRaWDJrM1FQSmpNT2ZlaUQzZmwwVU1j?=
 =?utf-8?B?aDlHTTFWNWJBV3d5SjVMOVBKcVNKVlhFU1Y0bUJhb1lTdUd5eVNXRlNmYTdl?=
 =?utf-8?B?MmZGSHJvdUZaYWM3bzVVQVcwMy9rUk1BY3pMNjF2RUJzYklwbWNKSEwwRm05?=
 =?utf-8?B?RStmY2c4Rml2d3AwY0dJZnB1RjZOUFRBeTBYVmpqbTRKMWYyeXpJM3o5RndG?=
 =?utf-8?B?Rlh6aGdwL2FZM05kVnpFWnp2NFZ5eVRUV05YYVgrWlJUcndWNUdwWk1pejRw?=
 =?utf-8?B?a1dqc3UzejRNQUhBWUZrZFd4VEtmYmUwVk43K245WGxsZVY5SkgzK0ZDc2Zh?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c250744-3dc9-475d-c4c3-08de124632b1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 15:09:44.3795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GYgnNnHUSfExESzGv4t3QeA2Tz+uOMZOYzQGtRUsCUJPNR7y8ogA6qOC0yCTargf+LaUhzsF0E86X/nTmXx8QzHgRHA0seIzW276KqBKKk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6797
X-OriginatorOrg: intel.com

From: Jijie Shao <shaojijie@huawei.com>
Date: Thu, 23 Oct 2025 21:13:36 +0800

> This patchset includes 2 fixes:
> 1. Patch1 fixes an incorrect function return value.
> 2. Patch2 fixes the issue of lost reset concurrent protection after
>   seq_file reconstruction in debugfs.
> 
> Note: Compared to the previous version, this patchset has removed 2 patches
> and added 1 new patch, so it is being resent as V1.
> 
> previous patchset:
> https://lore.kernel.org/all/20250917122954.1265844-4-shaojijie@huawei.com/
> Patch 'use user configuration after hardware reset when using kernel PHY'
> will be sent separately.

For the series:

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

> 
> Jijie Shao (2):
>   net: hns3: return error code when function fails
>   net: hns3: fix null pointer in debugfs issue
Thanks,
Olek

