Return-Path: <netdev+bounces-254390-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBlFLO1Memkp5AEAu9opvQ
	(envelope-from <netdev+bounces-254390-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:52:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 129AAA740B
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BACD308DF2D
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 17:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE8836EA91;
	Wed, 28 Jan 2026 17:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CQZ45vTe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B0B36BCF3;
	Wed, 28 Jan 2026 17:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769622380; cv=fail; b=CNB3NiPNkrp530asrfOPtEAQayWlRAYfG8sYCowJq4D2oGs8iv+Q2RsxsidTmNU15KmaPHEFjLxjncVaIaLYXPmO64HpmesBitAlmaYLinGDnwcoFNJx9cp3IhBCPbSuDlUMQHSQulpYcvQN7lALOeVQSBkPZywL05n5BufeOkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769622380; c=relaxed/simple;
	bh=Ud+vzS8zqpGXTFE9gnVIW2rMvtFy7GaNWPPEo46LvXo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CxmDdC5R6HIkhfScYf2YIBZQvaiIs7YihCMy/fdufu7rrhs+fjoQhVtPNNpWGY+27dWsxqa/dHoPS3No8T99NlUiZgSSpq54QQsotFe5jjKPcpcAcDUBBfGlknp1JAximBtrk8q2MMtGaJYtzdrVHZcgyRou8orTzrdfsfQLImI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CQZ45vTe; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769622379; x=1801158379;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ud+vzS8zqpGXTFE9gnVIW2rMvtFy7GaNWPPEo46LvXo=;
  b=CQZ45vTeUPNb/levaRRNtgEYsb+BOdnvW9iiufA28sp6+CFFWmVRK37K
   dGzetagCRDkcgvH1qcchw4xn91UMA/aP7UomfpydmVwcmZCuVHjRU6oo6
   LTvTjHKWcYm54UFeeHFQxEZ/CPTKm9VzdvwBltgKQj3hSEKokuWWyc5Sc
   /jaOJv/dmly35hwuq2oHrFAoAUiF28icyp0smndHH20ihEHLjDMsdJT86
   zAfADRtJoM2hCEXXNKfuYZAhLpk6hNDuqBVbkqQgazUvfjYBTxd73rETW
   9CN5rVUIaAflQrLNOjba0H5YZulx5TQptyFEBTKRguKU5m/GD9TQm29bh
   g==;
X-CSE-ConnectionGUID: 88fa1jQySb2p/jZ2cpr4VQ==
X-CSE-MsgGUID: USh+FDoFQ6uGL3nqAVX+JQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="70934186"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="70934186"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 09:46:18 -0800
X-CSE-ConnectionGUID: nbweBagrQWy6ZZdsGqep3w==
X-CSE-MsgGUID: evpfSzakR3K7APbB0QJoFQ==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 09:46:17 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 09:46:16 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 28 Jan 2026 09:46:16 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.60) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 09:46:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PEr7cGrkBm3F+PiD7xi7E2+Jt4lwXAC58QD8PaZn1v+Dl8Aq3t6ok74nuZ5+/7hFmrLq+r2iOPl8uB9PGA2OUa8pBrq5rp3GLUDjJij4THGsxo47hQnanaH3jQw7Bxjx5TyzWjbCysb6MXiCZm/yZtDwCrs9cnjxzu1YwKVSs0cIHGvrQSIYigmf1Y7Oqz4seZ6btZvLqIf9fojyovmcS/REwVma42oKMq0u2U5S29ThGkIKij/mhgoFv8okCetIWzPG/VklhfnyWIRPQEug70PQ3OWtdihp+4oBYHZPnjwTwhrE74v8leolvhUtYaMxPgDew1IXc8qt6fUHlvJyWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ud+vzS8zqpGXTFE9gnVIW2rMvtFy7GaNWPPEo46LvXo=;
 b=WePLyROVdz8cdlWXZINk/ybtPx+GcZYTnxN0T71lH3QDXZkkF39ayHyTx1BYFuTvJ2pCepC8ccu3ywfqaJft6vFpulq7YKHf/N+l1fNRy/WYyxJa3F5mjx1qkSl+lMd/WPtEk1yAKYViyC4SmGqYGybkfzVR4rOmTHf7o8ZKDsqWqkfNQv1JNLei0AZSrujUzcj7VlvgHu8YrmD7mOH8+zPoAXYZ+3rZcvZxEqSEhtvneIhzPPz5d2o2CCFt17LtRPqlrcoaWRjuYRuCFAJD68AB8TMojyrg/QhxiGHjR3sN3EhT/x7tpiwwlW5F5TEqs8m2IhTXVm3RCmSu+kOqLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA1PR11MB6991.namprd11.prod.outlook.com (2603:10b6:806:2b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 17:46:14 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 17:46:14 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Linux Doc Mailing List <linux-doc@vger.kernel.org>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Stephen
 Rothwell" <sfr@canb.auug.org.au>
Subject: RE: [Intel-wired-lan] [PATCH v2 09/25] docs: kdoc_parser: add some
 debug for variable parsing
Thread-Topic: [Intel-wired-lan] [PATCH v2 09/25] docs: kdoc_parser: add some
 debug for variable parsing
Thread-Index: AQHckHZQswEFmoruvUmoF9tmMM4nh7Vn2wMQ
Date: Wed, 28 Jan 2026 17:46:14 +0000
Message-ID: <IA3PR11MB89866D4DF615D146CCEFB324E591A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <cover.1769617841.git.mchehab+huawei@kernel.org>
 <e7d2dcabb0211447772127b6f32483184cd577ca.1769617841.git.mchehab+huawei@kernel.org>
In-Reply-To: <e7d2dcabb0211447772127b6f32483184cd577ca.1769617841.git.mchehab+huawei@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA1PR11MB6991:EE_
x-ms-office365-filtering-correlation-id: ff4beef2-a820-4406-e3be-08de5e9521d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?WG4venNIckVnSTljS0Q4blI4RWVOZi95cFVaK2lNb0hJK2N6YnloUjd2eW1T?=
 =?utf-8?B?ZklYRWZRUGxIVm04NVFGOGZtd1BMNTBiUnRMOW9OTDErSzdpZEpGNHRJeW0v?=
 =?utf-8?B?ZnJrZ2tnbHErdFpyNDdCVjV3Q0FMRUU4bE5YSkF4UlgxcDhkK2tZY01UdmlE?=
 =?utf-8?B?czdEdWFJQlYvQW9mY1NGNUZ1ZzJHV1dNSzN1NWVqeHcvUW1lTzlKRWZrZyta?=
 =?utf-8?B?TWJWeVR5UU96dit5czBZMzBuNGVDZnJsa21aSjBHcGdUM1hjNzN0RG9xc1h3?=
 =?utf-8?B?T1VHYmZ1OGo0Vit5T1NMamRaMjdNZXBhMk1KYSs4N05qbEJlSlY1cGR6c3lK?=
 =?utf-8?B?ODFaRXluTjZDLzRESGc1amRHUGVDam1iTFl1RFFlL0dENlhTd2tGd1d4NjhC?=
 =?utf-8?B?VmlWb05udGFtS25kb09jT3g0ZDlmbm4xR2Y2OTdmUzRPMnpyN01LK3Z1ZFpL?=
 =?utf-8?B?ZnpNeGpzMDhzR09IcUhrZEg1K05VV1YyYTdEZDU0NHp3dnp3NW1xNkJwc2Qr?=
 =?utf-8?B?UEdZQmhpb29KWVNja0xjSDVTalJLaHB3QmVsc3llS1dMZ21oa2p5QTd1cEN1?=
 =?utf-8?B?djF0bnJuZkNNTmN3SmxJM0ZmSmdYekxjdU8yTVdXTUJxYThDQlpGc24xZlI0?=
 =?utf-8?B?ODE2OHhOeEt3eHl6Z1JBcEllaXhwNklGWFpGeXQ3ZWdqcW5jK0hMLzg5WWxm?=
 =?utf-8?B?UmJyZWhKQlN5YXZQbUxEU1lpNk1NUDFKbVRmZjNHNzZTR0JuL0tHL0ViUTZt?=
 =?utf-8?B?YVVZNllGR1NUdklGT0tUY2E4UmN5Ni91OUhac2xGUjJYZU5UcER4YjJIV2gr?=
 =?utf-8?B?S1hvSUIvSCtJWFZCb01UYUh5TDZFTVF3UHY1L1dTQW5Oa25YSTVwL2ZYZVhB?=
 =?utf-8?B?QU9UeU5oOUNSTGc4b1puQlpJV1BHMTVubUdwell2Ynp4ZFBVcER0SEhDbWxj?=
 =?utf-8?B?SS9jTkFuODRrUGVWQUFSdnRGZjRleVBGS21zamJpcVZLeHU1dTh2OVFKN1pX?=
 =?utf-8?B?TUpWbitmZFBQV21NaUN4Z1gxMGYyNFJ3UGJiODRLWlVLemVWbitmRnF5NU43?=
 =?utf-8?B?bXhreFVPSG1iejFHZ2tGNTJmVmUvZSt1UVdSL24rM1hraUt4Z2pCbGZ4cTBn?=
 =?utf-8?B?SndEUlU4WTJTeDhwbElqbWJpaWxBQUVMakdXZzNkdXlGRU4xeXZvTjdzUVFJ?=
 =?utf-8?B?ZzRCcDh2UHNZZ1Q3UzM3N3RxVG1GMGplTmdWay9vWjZhc3RTaWgyUmN1TUNi?=
 =?utf-8?B?MlFnbWdzRWk3YW41Z1p6Rld1OXZsV253dTJrUUNSZFdLREZVOE41ZHlpZGJw?=
 =?utf-8?B?Yzh3bXFoRExObkFwNEYrTjFjcXhjK3BwcGhnUWVFWC9xVWl3K0dTYk1VYjgv?=
 =?utf-8?B?eFpLdktzTUF0QW5MUk5rK29GcjVVK3NVS0Z3ZEgzYVJQWWJaN080WndGUkRt?=
 =?utf-8?B?bW1FREl5S1VmcDFHc1NwQSsybUxNSC9EWVpwYmdBMDRQZWY2VWlPRjl2cmpm?=
 =?utf-8?B?Q0pRMmZRN0NiZktxTW9GQlpoNDVibkFzNm56VXdYSk0zUXJkSXV4cEY2bTds?=
 =?utf-8?B?c2ROREFvZmdLMWVkejYyais1d045VWxzZE1HL2JlMFI1YWpTQWtmbVFvaDJm?=
 =?utf-8?B?eE9hYlQ4MXo0ZjBHbnJnOU5hQ05EVWEzSk13UE9MK3JJbVZla0VmRlkzUWVB?=
 =?utf-8?B?Sjc2TVc1YVM1MElKdWpkdGYvS1UxdjZiYTRsczBlSzAzWEwrMmpFcUR4L0h1?=
 =?utf-8?B?aHcwZ0JnSHFDckRpcyt3ellOTGpJQjZDNEtrZExWamowR3hRY21wKzQzak5E?=
 =?utf-8?B?Wmx5Skp2Qkhla3ZsMXVxUEdQSTdBU1V0TllwbFUvZVFlb1pzR0VDK0pPSFlO?=
 =?utf-8?B?QS96OWVoYlVkSE1lMlBzc21OVkNXdnlqaXJuRjJYVm54cVhjZXlEcDc1K3JJ?=
 =?utf-8?B?MEFXV0pIRVdiRmxFa0NGV1ZZdlpnU2VUaGNWcjNUZjhMcUpCNDVTMGsweFl0?=
 =?utf-8?B?RENIUGNpNkxzamUvb2Vwa1BCUUxwOUtUMGY5K2NYcW9meUZOTTJLdU9OdG5l?=
 =?utf-8?B?QkhGZGlIaFRiUXJNQXVkNGQwRnpmeDI3ZWpjckNSUE1yZkZqSGJ3VVczaHZ1?=
 =?utf-8?B?Vnc2Sm5HOGNKUUxoSXFLZFR0VzEzZnJoa0J4L2JTSDhlNzB4bThlWVJaN21Z?=
 =?utf-8?Q?Czem1VRvuMCpRaD6VdCmO84=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ty9RVWxPdEI2YnIvL0FKbnlHZGNMOGlsQTJoSnZJNzVBaHhISTNRMkxJc2tG?=
 =?utf-8?B?eEtyWnpQcWxsckpVQXcrOVFnaXZrQVA3QldHQ2I1ZGE4S0t5S245NE9XcmFS?=
 =?utf-8?B?d3EvbUx5MHh1MHFpalZnUTMvZUhTejBEcyt2QmFWbzBvK3hiMkNnaFF2amlC?=
 =?utf-8?B?NmxvajFza3huakh5elhzaEg2WnhhYTlnMEpoT2Juem5GRW8xd21FYUNsT2xL?=
 =?utf-8?B?MEkwdldpWWlJWEUxcVN5R1l5aFJQOUpIbjlNT1JyK0ZHcHNITVZuNXlwalVK?=
 =?utf-8?B?OENHdDQ2S0lSR2dUY1BpVUFpaW0xeUxPTTF6RG9hWTdmR2I3R2J4U1VKWEhs?=
 =?utf-8?B?dkQvbTBuaHc4a2lnRFdDRGlDem1DZDFoOXBhME1lYW5EU0FjREF0TTB4cVgx?=
 =?utf-8?B?bEd1eWtIUHhSaU0wZUZmZzlCdDhmaWtSRG45alJ2blJ4V3RyZ2ZRa3UxamFs?=
 =?utf-8?B?d21kU0NGeGwxc2pOV0pnUkNmWDBveDJ3SUYrYzR1WTIvUmExL1dFNUVZOHpN?=
 =?utf-8?B?bk1WWXZzYndTNklXVlQxL1dsQ2tnUlIzVTlnZTE5dGRRZ3FwN2ZQVVBIUGhY?=
 =?utf-8?B?clFBZXZ2RHhhU1hqVGh4MVd6d1ZaaDRwTHlHckVxS0NRRHI4VGJQRlNSSHUw?=
 =?utf-8?B?amQrS2tWeTdoV0NNd0RiZXliMEU5aENZSzdkS21YNDVoTk1ZZFFQOUV5Qk9i?=
 =?utf-8?B?SzQvOWsyQTZHamJwWFY3TXZ5MGJtMTc4Zm5QMHl2ckMrMEhORVoxa2hXa3ZH?=
 =?utf-8?B?UVYzWStDZGxlNFhUS3RoK2pia1IrV3BGVm9GWkcyOG03STY0MjF0SmVnQWNK?=
 =?utf-8?B?eGltQ2lRSUIyam80ZE1sY0FCdjRjRTJSWWVQYnVVT1AyMlNxeWRpSWJxRTUz?=
 =?utf-8?B?UEZXeWxEN2hTOXMwcGFQZU9UWnp6R3VPa1gzaWtKT0JDTjU1VDdpdkh6bWJ5?=
 =?utf-8?B?S0I5c01Bc2FsMXVkQngyR0phRjg2VjQ2NlVaL292ZjhXMlpXdFppTzJMdnM5?=
 =?utf-8?B?SnJ0VU1RZUhsMEp1SURRei85bUVkenM3a1hKaTNPU3dVOVFCY2xxMVNsaW9s?=
 =?utf-8?B?V0V5U1l1ODVtNFdPdHB4R2VyT2JmbGp3UGg3NlJYbVBFMjA1TytnSjFhSjJZ?=
 =?utf-8?B?OHc2eERGRjZ1MGZzZ2t4ZWU3UDZEZTNRemZ0SUdZNEUrd2dCN2diSEJxUnVQ?=
 =?utf-8?B?clptSHcyd2UyYjI2eHJ3THJkL0lXbkNqRGo5cjVJS0xUVzFxZkdacFc3dG5E?=
 =?utf-8?B?Yi9LaGswSythakxudUduTE9idGFNNm5JQW5DMU9NZjdBOWh5TzNvaWZoNjk5?=
 =?utf-8?B?ZGRmWU5vL3hFZzQ2cFBYRTRDZmZuTFQxc05NcGl2REwyVjVEMnJIM1NwdkY5?=
 =?utf-8?B?WERYRE1qclZlbldRemZUcEtmREdTTTgxQ2xGWTNxTU5hVG1IUVRQQ3FJaEVF?=
 =?utf-8?B?Yi9zNDBmOFhDeURNSzJ1Uzd5VHZLU1VlT2RJWmV2ZDhQYWJ3MjcvVFNlZThJ?=
 =?utf-8?B?RXdrc3kvSDhQWGpsazlFNlhxS3pVRDhaZWNjd21raVhLVDMyVW1FbXJxdEdy?=
 =?utf-8?B?ZkVmQlQ3OHJ4Z2ltTjhGeFhPeG9hOWcrNHRzTnF4WFZHdlV3dkdKNVhKNlJq?=
 =?utf-8?B?OWhiQ1M0NXNEQWswQVFuSTNlRmhVL1ZGVXUwd2lYNXlqWCt2WVJkV0Q3c2NW?=
 =?utf-8?B?M1VmM2FZZU5JK0pheXVkT2lHMk5OSEk5clFEQ2RKM3RmZlBZVy9UU0NrbFI4?=
 =?utf-8?B?eFZpcldLbzNoaXVpdWlzS2l6QkRkOUhFcFJQS0VJZmNmWVJ6OXVuZWxxSzMz?=
 =?utf-8?B?YUlvZkVGZ08wMTAzNExWRmRQdCsrakZmMkxOd2gwUXA0ay9ockdEWW9tbkVi?=
 =?utf-8?B?M3p6emJWdE1Dc3d4WDFudEVzT2FYTVB2UWwrbmFpamdNYkNIWE1xSzF3QW1s?=
 =?utf-8?B?aU5oTjlmZ3FBRkRBS2hhOU9UeHI1T2ZXb3BpODVybjI4V2NmUEN2Z0E3cmNW?=
 =?utf-8?B?VEYrTU9BTWFrOU42MHk0RER6WFJpdGhVcCtZN1QzbHorbzFKMXI1TURVWnRR?=
 =?utf-8?B?d2VDSmhKeTJ4M3k3YVNvbk4yekJVcVBRdzdiY0JRN0xEUkMzb3BQY0ZOM2pU?=
 =?utf-8?B?UDdsdUZ4RHZPeTdVNzhVbnJkM3hqcHBDTm1vdzVrL2FZMWVwQmlRR2JuNUpT?=
 =?utf-8?B?ZzR0VnJFV01uVW55Y0ZIYXZ6RkhVVkdyWDgyWCtKdVJ3VUNJZVRsTjVEUFcw?=
 =?utf-8?B?cDR4V1N2RDJYSHA4WGRSYmhuZW5YT3V1eG9YM3JtNEVTOFIxMGJ4LzhROVE3?=
 =?utf-8?B?bmQ5aDA4TmxyVXJ2NFU2K0pSeWpDc2VOa240MkpWQVZOVzNNbnY0QVlEaEI3?=
 =?utf-8?Q?5XZlqQjCtXh3MNIM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4beef2-a820-4406-e3be-08de5e9521d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2026 17:46:14.3468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NbW9DLBn/ua29neCGM5qG+y5JFTakv0LDG7DqFLD8wNjRSYkHMshjstQ+DNE1546d2PSZsWYe8Qfm/rpNn3D0lzREmbR+UtFbl5I6tW3Zws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6991
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254390-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,huawei];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 129AAA740B
X-Rspamd-Action: no action

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgTWF1
cm8gQ2FydmFsaG8gQ2hlaGFiDQo+IFNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSAyOCwgMjAyNiA1
OjUwIFBNDQo+IFRvOiBKb25hdGhhbiBDb3JiZXQgPGNvcmJldEBsd24ubmV0PjsgTGludXggRG9j
IE1haWxpbmcgTGlzdCA8bGludXgtDQo+IGRvY0B2Z2VyLmtlcm5lbC5vcmc+DQo+IENjOiBNYXVy
byBDYXJ2YWxobyBDaGVoYWIgPG1jaGVoYWIraHVhd2VpQGtlcm5lbC5vcmc+Ow0KPiBicGZAdmdl
ci5rZXJuZWwub3JnOyBpbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZzsgbGludXgtDQo+
IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IFBldGVyIFpp
amxzdHJhDQo+IDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBp
bmZyYWRlYWQub3JnPjsgU3RlcGhlbg0KPiBSb3Rod2VsbCA8c2ZyQGNhbmIuYXV1Zy5vcmcuYXU+
DQo+IFN1YmplY3Q6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRDSCB2MiAwOS8yNV0gZG9jczoga2Rv
Y19wYXJzZXI6IGFkZA0KPiBzb21lIGRlYnVnIGZvciB2YXJpYWJsZSBwYXJzaW5nDQo+IA0KPiBU
aGlzIGlzIGEgbmV3IHBhcnNlciB0aGF0IHdlJ3JlIHN0aWxsIGZpbmUtdHVuaW5nLiBBZGQgc29t
ZSBleHRyYQ0KPiBkZWJ1ZyBtZXNzYWdlcyB0byBoZWxwIGFkZHJlc3NpbmcgaXNzdWVzIG92ZXIg
dGhlcmUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXVybyBDYXJ2YWxobyBDaGVoYWIgPG1jaGVo
YWIraHVhd2VpQGtlcm5lbC5vcmc+DQo+IEFja2VkLWJ5OiBSYW5keSBEdW5sYXAgPHJkdW5sYXBA
aW5mcmFkZWFkLm9yZz4NCj4gVGVzdGVkLWJ5OiBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFk
ZWFkLm9yZz4NCj4gLS0tDQo+ICB0b29scy9saWIvcHl0aG9uL2tkb2Mva2RvY19wYXJzZXIucHkg
fCAxMSArKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykNCj4g
DQo+IGRpZmYgLS1naXQgYS90b29scy9saWIvcHl0aG9uL2tkb2Mva2RvY19wYXJzZXIucHkNCj4g
Yi90b29scy9saWIvcHl0aG9uL2tkb2Mva2RvY19wYXJzZXIucHkNCj4gaW5kZXggY2JmZGFiYTM5
NDk0Li5jY2VlNGUwYmNhYWIgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL2xpYi9weXRob24va2RvYy9r
ZG9jX3BhcnNlci5weQ0KPiArKysgYi90b29scy9saWIvcHl0aG9uL2tkb2Mva2RvY19wYXJzZXIu
cHkNCj4gQEAgLTEwMzMsMTEgKzEwMzMsMTkgQEAgY2xhc3MgS2VybmVsRG9jOg0KPiAgICAgICAg
ICAgICAgICAgIGRlY2xhcmF0aW9uX25hbWUgPSByLmdyb3VwKDEpDQo+IA0KPiAgICAgICAgICAg
ICAgZGVmYXVsdF92YWwgPSByLmdyb3VwKDIpDQo+ICsNCj4gKyAgICAgICAgICAgIHNlbGYuY29u
ZmlnLmxvZy5kZWJ1ZygiVmFyaWFibGUgcHJvdG8gcGFyc2VyOiAlcyBmcm9tDQo+ICclcyciLA0K
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHIuZ3JvdXBzKCksIHByb3RvKQ0K
PiArDQo+ICAgICAgICAgIGVsc2U6DQo+ICAgICAgICAgICAgICByPSBLZXJuUmUoT1BUSU9OQUxf
VkFSX0FUVFIgKw0KPiByIig/Oltcd19dKik/XHMrKD86XCorKT8oPzpbXHdfXSspXHMqW1xkXF1c
W10qXHMqKD0uKik/IikNCj4gDQo+ICAgICAgICAgICAgICBpZiByLm1hdGNoKHByb3RvKToNCj4g
ICAgICAgICAgICAgICAgICBkZWZhdWx0X3ZhbCA9IHIuZ3JvdXAoMSkNCj4gKw0KPiArICAgICAg
ICBpZiBkZWZhdWx0X3ZhbDoNCj4gKyAgICAgICAgICAgIHNlbGYuY29uZmlnLmxvZy5kZWJ1Zygi
ZGVmYXVsdDogJyVzJyIsIGRlZmF1bHRfdmFsKQ0KPiArDQo+ICAgICAgICAgIGlmIG5vdCBkZWNs
YXJhdGlvbl9uYW1lOg0KPiAgICAgICAgICAgICBzZWxmLmVtaXRfbXNnKGxuLGYie3Byb3RvfTog
Y2FuJ3QgcGFyc2UgdmFyaWFibGUiKQ0KPiAgICAgICAgICAgICByZXR1cm4NCj4gQEAgLTEwNDUs
NiArMTA1Myw5IEBAIGNsYXNzIEtlcm5lbERvYzoNCj4gICAgICAgICAgaWYgZGVmYXVsdF92YWw6
DQo+ICAgICAgICAgICAgICBkZWZhdWx0X3ZhbCA9IGRlZmF1bHRfdmFsLmxzdHJpcCgiPSIpLnN0
cmlwKCkNCj4gDQo+ICsgICAgICAgIHNlbGYuY29uZmlnLmxvZy5kZWJ1ZygiJyVzJyB2YXJpYWJs
ZSBwcm90b3R5cGU6ICclcycsDQo+IGRlZmF1bHQ6ICVzIiwNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGRlY2xhcmF0aW9uX25hbWUsIHByb3RvLCBkZWZhdWx0X3ZhbCkNCj4gKw0K
PiAgICAgICAgICBzZWxmLm91dHB1dF9kZWNsYXJhdGlvbigidmFyIiwgZGVjbGFyYXRpb25fbmFt
ZSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZnVsbF9wcm90bz1mdWxsX3By
b3RvLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkZWZhdWx0X3ZhbD1kZWZh
dWx0X3ZhbCwNCj4gLS0NCj4gMi41Mi4wDQpSZXZpZXdlZC1ieTogQWxla3NhbmRyIExva3Rpb25v
diA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+DQo=

