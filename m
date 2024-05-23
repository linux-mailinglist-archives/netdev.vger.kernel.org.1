Return-Path: <netdev+bounces-97726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC718CCE9B
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 10:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4533E28260D
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 08:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0114813C918;
	Thu, 23 May 2024 08:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FYdBEXSa";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FCHZqbvZ"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46588339A0;
	Thu, 23 May 2024 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716454337; cv=fail; b=lLQUn5b9vu9ML4jSRhMMBO/ZqWptMRMO1jrbuS4QZrSLaYD71eaGlhh2TIFRzYJ+0dDZiA3I9jfOXCkBBtARnCA7UIfJItCVYjnlEfsO4XH17Q+xUgTBWrsIrROTPECu+m2seP+L9xewxkzObPtMjEzYynbGUEUui8DseV0bW4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716454337; c=relaxed/simple;
	bh=iA+uA+qMWEYYrRnfaiWKhW7ITknLN5bPBYsWd8bUQKY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jKGDJAYBE6Yt9TkLMaNvBnYg0wZNV82TmF7QGN8uNbnyYxNRprvR88FHoFm8PU4zSqh+DyGryqIRrhrkRCeMFHAV8JZzL+hhqgXj57uND3u5/kC4xv/vxyRjO5btP/ZQuLZrbvLpo2Bvx3AEsezdRNsgGrKsjISz/askQUx8nx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=FYdBEXSa; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=FCHZqbvZ; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1716454335; x=1747990335;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iA+uA+qMWEYYrRnfaiWKhW7ITknLN5bPBYsWd8bUQKY=;
  b=FYdBEXSaU5+QL4yKn17w8xlEZMl7P7BfyVUp9ZcB9db2xOAaFMeYMJfb
   cLAM3CjTvsD83dAC+tQE+S5hLcXR8GZ4ZJdpiFeu2MiteO9iuaVSolm6O
   aUWljcUZkJDsweVoqePur8v3hcA43WrmpdpPGJ4qbPdAw4++R3SCpOCd3
   6qnZpqQ40c4TaMxJjihh0y8iUrG9QNF3QuM+6QTBd6mcFaIgq6gk11F3C
   4//Wc6lmZmRZnEFGW7fW8TFC/oA9Idb53P1+mW36MLYGef3Q9pzAZ6zd4
   el2hPE4QXEbBIYPO3yL/OeGMLjQXfljg6AQ3wL/82dlHGmXZhwpPqz63Q
   w==;
X-CSE-ConnectionGUID: qH1u7DDdTtKGNfMOeQZcDA==
X-CSE-MsgGUID: 9Onahtp/QHW7w2H1BuG/xw==
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="25887049"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 May 2024 01:52:13 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 23 May 2024 01:51:42 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 23 May 2024 01:51:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jl9+rpE5Ev9BdrSFxJECoiybkq8UV+XcOnx3Ic/+ixW6KNPZWQDxOoMBd6MTxRiZ3X7UW3Y7deHGImNatvaPWoPeIu4Tkq+tWkBcrRm6I6XrknCPrluoiRkSfZTJ6Z5JZa3rY3X7l4mpfiYFFYMuALQWEk3MJ4dZgyYT5ZfyTnP6h+cVXKR91Rj3Qr3ESwaUY+6e1ODw6EhhsQHjGkCRCn+8uTa5YrNJQ5kN7yZInbnzc7da4Cv9q1Ie7/ejAde9y9mbZNL6dy+XajLYgYMyOxtRQXaIbalOBtjcYNVFpeC940DnJC0B3g6MTQc2HEr7WDRVczYLCca6j6ZDfLbRNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iA+uA+qMWEYYrRnfaiWKhW7ITknLN5bPBYsWd8bUQKY=;
 b=QrZijexMgbi+sUSnAazsQq7l67dot0XI/m3wxJIOVOBls6lhgVFogmjZ9yK2/AErWVnzQdsMWBXespY9v2N9KnYBRQXwdBRnbbFTI0e8TTc5MdF9FsTw6uUkDqtAra2lFxRbY8HKOIXVPeejJyNqhFOPRQWoqaaKpY0oaYzhCr7LAy6CiYF5AbB+1+PO2HS8fA/Hvz0RpFiNR1UF4xcbFKpx0pBCkJo4Ac+RHNg8UT6hryCkl0Xy0H1lXrWjJbvhYZPcrVJoq/WIQdVjqE+ps+T9h1A4JH8cgwYLNsb4Pr6qK2pDEu4F1U9BJ8ipn8JuLZSEnBJC3gww641X9AAMUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iA+uA+qMWEYYrRnfaiWKhW7ITknLN5bPBYsWd8bUQKY=;
 b=FCHZqbvZzq+O2Ei902O4H05S7OUU226Y3+7pysGUUFnGz1uMb/ZGV4zKBOdvgOfLb72W1Fnuk6b2pksJro6IcqES13p1057Bd7nOaXECFFnLJjk7XjwQAOEQoPigNXu/HqDt7vMIrV8Qw/pjeoBM9ylaDGuGs3MAYlqEQVF1fCP27D7bAKMSP1+6dZfo5I9u9CQn7agi7IvvftLor/GCVZ/g5CuSKYCag0Z7peGY8m2kVOKqgUYFsAeLIb2t2FaiE3MuaRXoIXuNAYtCNaLdrKAa69US+1Q3MQtvae5TNAKM8QOhPeqbPy/bJSbxDfSLhkLuj9GGR4qorGMsn1zxsA==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by MW4PR11MB6738.namprd11.prod.outlook.com (2603:10b6:303:20c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 08:51:39 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%4]) with mapi id 15.20.7587.030; Thu, 23 May 2024
 08:51:39 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <Woojung.Huh@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <steve.glendinning@shawell.net>,
	<UNGLinuxDriver@microchip.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH] net: usb: smsc95xx: configure external LEDs function for
 EVB-LAN8670-USB
Thread-Topic: [PATCH] net: usb: smsc95xx: configure external LEDs function for
 EVB-LAN8670-USB
Thread-Index: AQHarFGdKs4gtKjRMUij/lf1SheVtbGjqp0AgADZigA=
Date: Thu, 23 May 2024 08:51:39 +0000
Message-ID: <2044fda4-84ee-4e2a-8b33-65c443643d15@microchip.com>
References: <20240522140817.409936-1-Parthiban.Veerasooran@microchip.com>
 <BL0PR11MB2913394A02B696946324E830E7EB2@BL0PR11MB2913.namprd11.prod.outlook.com>
In-Reply-To: <BL0PR11MB2913394A02B696946324E830E7EB2@BL0PR11MB2913.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|MW4PR11MB6738:EE_
x-ms-office365-filtering-correlation-id: db0807e7-ec02-4398-8264-08dc7b058fb4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?dHh2VDlTaVVMZnF2V2hkYTVFRERRak5lYnk2dDB0YVRqOFZoTE5CNW50OFdn?=
 =?utf-8?B?dTVHNncrVkMrYW5Oa01VTVR6VnJOd0ttcjRaK05jYk5QalhlcE51Z3hOa1Nh?=
 =?utf-8?B?NCtRVGNhY2VoR3VDWVNCQStCWEhlUDNKQWNudG9maFRNVEMxY0M3dEZPOWQ2?=
 =?utf-8?B?K2piWXRPOWdaYnNzWjBQenIrV3NaRHhZT2Z6cXNvNkY1TGtPMUgrMnhMZUVJ?=
 =?utf-8?B?U05pVFFKUTVXRkxMWFVXdVJuT2lNWXR5Skp4MGhMdEUrbGRLQlBpZWNGbkp6?=
 =?utf-8?B?NCtoOXdtck5sM3I0MWd5YmljUFdpQzV2UDJrRkdWRTdXQjdzek84SnFsUVhK?=
 =?utf-8?B?eitwbGpqdzN3UjQ3NkZxYW9vZ3BMZW5iZ29HV1Y2YlNNbGYwOVVkODRYeFBJ?=
 =?utf-8?B?M3ZFam9INDV0dC9rYTlxa1RNM2NPSEUyTVg3WEZqb3ZweUZVTjNuYm9RNlFJ?=
 =?utf-8?B?NitKZm9kVE9VMWZzUVluYVAxckZPSE5tdGF2dVZnNTJyRGpRS0NpMjFveHF3?=
 =?utf-8?B?Z2kyaTBwQUl3SWlOWHJqYlJjMUFPWDVkTlk0QVFieFk5UU5IcStyWW85cnRS?=
 =?utf-8?B?NVBoY0lmQjh2SUNxTzdsc2VmL1FQK2NpZDhnT2I1Zm9NTFZwNlIwVDF2MUVY?=
 =?utf-8?B?V2ZyaHd2eHlSUmtEQVdsR2lSamlEeXZETEZtOEl5bHkrSDBXQXl6M3pWanJY?=
 =?utf-8?B?RWJjWXpHU3BjNjUzM1FFVTJHakJOZ2p4amtyNVZPb0tsM0dZanhPUFlGQ0lF?=
 =?utf-8?B?RU9lYmxrNDVxTFUxNnowakFUVks2MCtxNHc3cnJSTVl6RFBzSi9hVm53cncw?=
 =?utf-8?B?cmNacWhtTnQvc2tnekdVVlVnaU9NNU9zQ215ZVAxeTFoNDZIQ3RIMy9kdFAv?=
 =?utf-8?B?ZG1ZVTRMTXNHK1pkaEVvR1FwWE90WkdxdzduaElPNE1jcHhyVmRueVJUdmFj?=
 =?utf-8?B?dzRyb21DWmk1dmJSMENoTHZ5eG85Z05WME1sQ0FwWGhvTHo4QlR4RTQ0SlRG?=
 =?utf-8?B?MjJGdVpVaEJiQTBKcFVndWJIenJ1aG40T2RSYlJaemlTcnZZbDF6Tjhoc1Q3?=
 =?utf-8?B?R0lNLytvdXhWcHJVdis5MEV4SXZnYXM5TFhNRXRVdU1nL0Z0UUFJV21obCtS?=
 =?utf-8?B?ME5HNHpXU0NLMVptVWFOa1JXL2gyVmlnMnp3V0FtUUZRem9nRGdLUk96b2s5?=
 =?utf-8?B?OFVLUFNvRWJsakR2RGt6UndyWHhKcFpnSmRsTWJCYmhwZ09ac0xqLzJJTmQ2?=
 =?utf-8?B?eEdiZkJhblA0SGUxNFZJM2FEWU5HOE5YbHBGTitQYTA2bjhJdlZySkd3dFph?=
 =?utf-8?B?d3ZCcFl0NkJWQStMSTFqSDhvZXB1T2VNVng4WVY1dENUSFkrR3BmREZwSlJU?=
 =?utf-8?B?ZUJxd2VaUEVZakVRUnA5WXRHUTNMVEpOY3pPM3VqbW5jRWJSamh1a0RrUEhI?=
 =?utf-8?B?R3d1cDZYdUJaU0FhU1VHS2lWS2dJUGZhVmdVdE5xVDZxOUN5RFJWSEZLMUtD?=
 =?utf-8?B?N0N0RGhMVkZTWmdGRitkYmMvUEhUSXhVeG5oMlJvOUtqM1BzQm9WeGl4d3hW?=
 =?utf-8?B?SG1uc3AyZ0lYQzI0SWpqOGx4N2F5dzN3QmhJUzhsTmkwZDd5a2w4SG9Oa2lU?=
 =?utf-8?B?RUtGR2RYSmVsSUJVYnNjTFBWM1JoVDFaNUdKVXRkRVFIQTFZU05ZWnVadEY0?=
 =?utf-8?B?STliNGdlZ25tcytvYThldkhCTEhCR1dKYTZTN1lMQ1hkNHJoRlJMak13MndR?=
 =?utf-8?B?dUptbXVIeWs3TXNINHl2SEJNODBER0tkS1Fxdno1aGMxU2VnVENhNVhCVDIz?=
 =?utf-8?B?QVdERjlOL3QrcTJTSCs4UT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGVQSndTa050RW0yVlZ2c1lMRDUrbHJxMmpYZS9HZXZiWEExMUZOVEVVR1Ns?=
 =?utf-8?B?cU1PdFFMMTdPOUI0RHlyd0dIV21NdXp0bm5EK2Z4cTluVU5RbXVGMXp3dHlE?=
 =?utf-8?B?Z2JZemovVG9xSnFSQ0tMWXNQTmdKaWh5TDg2Q3B2SHRHNmp4UkppdWU0K2F6?=
 =?utf-8?B?aXZEZzYvSkRkdFltOElyVTdLaVFDdlFhOUQreklLRnlCczJxazNUTUpoYTVI?=
 =?utf-8?B?L2I5MVZvSTQ5Z1Fkemd5NlBXQnBuRUp0aC9zZnNBUytlczlXTjI1UWdFOE5T?=
 =?utf-8?B?OFc2TjBRbHc0eE4xbitMT0dYWlpMN0k1TmJ5U3BlTk5Lbi8vYUJ5SUQxYU51?=
 =?utf-8?B?TmwrMElhSDdRUkpVRDJOd3RUdEptcEZ3cjFhYi9KNG11akFaM3VXWU9panFj?=
 =?utf-8?B?RGJMN3JVek91alg4em1Kamx4dStGNmppSUFNaVMzYzFueGc3WEc4UStJLy9H?=
 =?utf-8?B?bnp5WVY1TzVId01lTmM0VjJLcmlHeWZSVFFBMlk0Y3EwZ2tHL3Z1bjFPcG9I?=
 =?utf-8?B?eERnMlRKY3dzODRVblI2QlN2Q3hOM20xQ0diS2YrSDQ2Z3J6aEFJdkc5a2Fs?=
 =?utf-8?B?VWYrYkRnRWJiS20xT3BrYzl5RkJ4Rm85WkFJUmFGRGg4S1pnYi9UTkVtS0h2?=
 =?utf-8?B?Sk0yTmh1emdtOFY2V25ycG8zdm5jNUM0VG5oSksxV1FYcHBCbXZhYjl0TjBt?=
 =?utf-8?B?bEhuMStMTW02cTU2QVdSSmZDUEQ3cGhkaDFRL2VJdldPcHMyK1BGV2xhSmVY?=
 =?utf-8?B?SkRvUXpNVjFSWDRneG5weGRPbFNHbDQrZGxLeCs1bzMrSzJyTSs4ZHBzQ2Nu?=
 =?utf-8?B?WTIvRVJyM0MzQmlsWGZGTnlIeHVXQVdYcTNSMENKNGhvZk5XQU1FdjVlcFMw?=
 =?utf-8?B?RDdJRlVOdHo2T3gwTUloVVVaWmpzeDlMV1huZFc2U2IrZ0pJWlEzOVh4L3Bp?=
 =?utf-8?B?TWFPQWNPNldhL25VRnNCTEdJdWtqRDV3QzBtZ3owVU9YL2dwTWlWNTdzOEZm?=
 =?utf-8?B?dy9rYUhZS2VTYUxEbk5CWG1YTGJ6TEEzYW9PQ2grZmxnbWVlK00yUmxwRWVl?=
 =?utf-8?B?Mmh3TTllTzJwdGRBSzhJUkY4blVMYVZxbjVNcmxORzU3UlFZa3YyTkdIOVAv?=
 =?utf-8?B?RnVLSG5kSjErUERISldISTVwMTY4QlNDZkZMS3ArQ2RxV0JEN2JlZzUzUjV1?=
 =?utf-8?B?SW5LNVVsRTFzVUo4dElYNXA1VzVxQVdqQ2k1MndTVzloMEUwV25lTkxqTkF0?=
 =?utf-8?B?VW5tanQ1eVE3UXlFVVN2dm9XTTVmQkZVK2FLVEFnSGFlQTlIRTczd2s0amhp?=
 =?utf-8?B?Mk1EelBvY21TLzhrRG1LR3o4K2lES0gwZ0p0WmlHdTFMR1FlQVJscW84QkR3?=
 =?utf-8?B?RU9QdFZScWZoT0piNy8zODJveFZNY3A4RXVwQTB1NkRzMnBGZFJHRDdBcWFG?=
 =?utf-8?B?eHJaN2tEOEMwZ0NSOG94Tno2ZTZ3TkUwZ2RBOVpHemRXT0h2cDA3ZkVpVSt4?=
 =?utf-8?B?RGRkbE9PN2MzNXFxcWNvanhGWjExdHlKYnZkMU9XVEN2Z0prK0YxRE1QWVdm?=
 =?utf-8?B?b0E3QVMzMHZVak1rK1J0em5WZFhZMjBEMm54YVpxRVh2bEVzZ0E3UnIvRmlU?=
 =?utf-8?B?NXpIRmlISmViMUVYandYR1JSNnBsUEVYTUJJZ1VpdVJUWTlVc1krWk81Y0ZC?=
 =?utf-8?B?d3V4SDVCbTdYbXJMSmxIdmxEOTViU2d6LzAwUXF0SGpZN2t6K2RZdTJ1Rnps?=
 =?utf-8?B?R0poN3NFdkl2TmNnOXlhSmUxWGdFelMzVXZRYnNDMkxRRUJBZkZWaGlJa25n?=
 =?utf-8?B?OXJ1RTFGSm5UaUhUQVRGa3Y5U2xCUlFLNzdqOWlKTW5kc0tnSUVIMWRyOGRh?=
 =?utf-8?B?bW02SnRhL0xNMm5hU0FsRVRBWG9DMDQrdDBGeVplNHF5Q0pzSlBROVFpSHo4?=
 =?utf-8?B?aDJJSWo1M21ldEVKQ2V3azJwZGR2RXVHNHRnZmNhaVlpS0cvb3FKOXZEVTRG?=
 =?utf-8?B?bjdhUm5XZGp2OWJCUUtxeFlVOFRWbUZFSStQWDN1ZithM3h2TDFRcE9CZFpC?=
 =?utf-8?B?UDNZNlB3N01la2tQbEJsSFgydkh3K3NDZktBY0l2aG9mUHBuZEhRUnpCSEky?=
 =?utf-8?B?RE5rQUIvaFBkT0MranQ5c25nUHA2czRZRC9CTzdENWFMMVBzSDNDZXpjYW5u?=
 =?utf-8?B?U0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D12094CCC441314EA6205301727A786F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db0807e7-ec02-4398-8264-08dc7b058fb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 08:51:39.1668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PW2cDjfsqyX+R6dJGeyuGzhEvj09ysSzVjisvSxjNoYuO/seffTtwuAzAyzN/dPZc5gatBoXXNzH7ZEzuaGVduJdnF2UuiE/rpPrKvPh/4vkCEpRaZ6+Yh+HCgJAGAin
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6738

SGkgV29vanVuZywNCg0KT24gMjMvMDUvMjQgMToyMiBhbSwgV29vanVuZyBIdWggLSBDMjE2OTkg
d3JvdGU6DQo+IEhpIFBhcnRoaWJhbiwNCj4gDQo+IExFRF9TRUwgaXMgY29uZmlndXJhYmxlIG9w
dGlvbiBieSBFRVBST00gd2hpY2ggc2hvdWxkIGJlIHBvcHVsYXRlZCBvbg0KPiBFVkItTEFOODY3
MC1VU0IuIEkgd291bGQgc3VnZ2VzdCBjaGFuZ2luZyBFRVBST00gY29uZmlndXJhdGlvbiB0aGFu
DQo+IGhhcmQtY29kZWQgaW4gZHJpdmVyIGNvZGUuDQpBaCBPSy4gVGhhbmtzIGZvciBsZXR0aW5n
IG1lIGtub3cuIEkgdHJpZWQgdGhhdCBFRVBST00gYXBwcm9hY2ggYnV0IHRoYXQgDQppcyBuZWVk
ZWQgYSBmaXggdG8gd29yayBwcm9wZXJseS4gSSB3aWxsIHNlbmQgb3V0IGFub3RoZXIgZml4IHBh
dGNoIA0Kc2VwYXJhdGVseS4gUGxlYXNlIHJldmlldyBpdC4NCg0KUGxlYXNlIGRpc2NhcmQgdGhp
cyBwYXRjaCBhcyBpdCBpcyBnb2luZyB0byBiZSBpbnZhbGlkLg0KDQpUaGFua3MgZm9yIHlvdXIg
dW5kZXJzdGFuZGluZy4NCg0KQmVzdCByZWdhcmRzLA0KUGFydGhpYmFuIFYNCj4gDQo+IFRoYW5r
cy4NCj4gV29vanVuZw0KPiANCj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+PiBGcm9t
OiBQYXJ0aGliYW4gVmVlcmFzb29yYW4gPFBhcnRoaWJhbi5WZWVyYXNvb3JhbkBtaWNyb2NoaXAu
Y29tPg0KPj4gU2VudDogV2VkbmVzZGF5LCBNYXkgMjIsIDIwMjQgMTA6MDggQU0NCj4+IFRvOiBz
dGV2ZS5nbGVuZGlubmluZ0BzaGF3ZWxsLm5ldDsgVU5HTGludXhEcml2ZXINCj4+IDxVTkdMaW51
eERyaXZlckBtaWNyb2NoaXAuY29tPjsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29v
Z2xlLmNvbTsNCj4+IGt1YmFAa2VybmVsLm9yZzsgcGFiZW5pQHJlZGhhdC5jb20NCj4+IENjOiBu
ZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC11c2JAdmdlci5rZXJuZWwub3JnOyBsaW51eC0N
Cj4+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFBhcnRoaWJhbiBWZWVyYXNvb3JhbiAtIEkxNzE2
NA0KPj4gPFBhcnRoaWJhbi5WZWVyYXNvb3JhbkBtaWNyb2NoaXAuY29tPg0KPj4gU3ViamVjdDog
W1BBVENIXSBuZXQ6IHVzYjogc21zYzk1eHg6IGNvbmZpZ3VyZSBleHRlcm5hbCBMRURzIGZ1bmN0
aW9uIGZvcg0KPj4gRVZCLUxBTjg2NzAtVVNCDQo+Pg0KPj4gQnkgZGVmYXVsdCwgTEFOOTUwMEEg
Y29uZmlndXJlcyB0aGUgZXh0ZXJuYWwgTEVEcyB0byB0aGUgYmVsb3cgZnVuY3Rpb24uDQo+PiBu
U1BEX0xFRCAtPiBTcGVlZCBJbmRpY2F0b3INCj4+IG5MTktBX0xFRCAtPiBMaW5rIGFuZCBBY3Rp
dml0eSBJbmRpY2F0b3INCj4+IG5GRFhfTEVEIC0+IEZ1bGwgRHVwbGV4IExpbmsgSW5kaWNhdG9y
DQo+Pg0KPj4gQnV0LCBFVkItTEFOODY3MC1VU0IgdXNlcyB0aGUgYmVsb3cgZXh0ZXJuYWwgTEVE
cyBmdW5jdGlvbiB3aGljaCBjYW4gYmUNCj4+IGVuYWJsZWQgYnkgd3JpdGluZyAxIHRvIHRoZSBM
RUQgU2VsZWN0IChMRURfU0VMKSBiaXQgaW4gdGhlIExBTjk1MDBBLg0KPj4gblNQRF9MRUQgLT4g
U3BlZWQgSW5kaWNhdG9yDQo+PiBuTE5LQV9MRUQgLT4gTGluayBJbmRpY2F0b3INCj4+IG5GRFhf
TEVEIC0+IEFjdGl2aXR5IEluZGljYXRvcg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFBhcnRoaWJh
biBWZWVyYXNvb3JhbiA8UGFydGhpYmFuLlZlZXJhc29vcmFuQG1pY3JvY2hpcC5jb20+DQo+PiAt
LS0NCj4+ICAgZHJpdmVycy9uZXQvdXNiL3Ntc2M5NXh4LmMgfCAxMiArKysrKysrKysrKysNCj4+
ICAgZHJpdmVycy9uZXQvdXNiL3Ntc2M5NXh4LmggfCAgMSArDQo+PiAgIDIgZmlsZXMgY2hhbmdl
ZCwgMTMgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC91c2Iv
c21zYzk1eHguYyBiL2RyaXZlcnMvbmV0L3VzYi9zbXNjOTV4eC5jDQo+PiBpbmRleCBjYmVhMjQ2
NjY0NzkuLjA1OTc1NDYxYmYxMCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbmV0L3VzYi9zbXNj
OTV4eC5jDQo+PiArKysgYi9kcml2ZXJzL25ldC91c2Ivc21zYzk1eHguYw0KPj4gQEAgLTEwMDYs
NiArMTAwNiwxOCBAQCBzdGF0aWMgaW50IHNtc2M5NXh4X3Jlc2V0KHN0cnVjdCB1c2JuZXQgKmRl
dikNCj4+ICAgCS8qIENvbmZpZ3VyZSBHUElPIHBpbnMgYXMgTEVEIG91dHB1dHMgKi8NCj4+ICAg
CXdyaXRlX2J1ZiA9IExFRF9HUElPX0NGR19TUERfTEVEIHwgTEVEX0dQSU9fQ0ZHX0xOS19MRUQg
fA0KPj4gICAJCUxFRF9HUElPX0NGR19GRFhfTEVEOw0KPj4gKw0KPj4gKwkvKiBTZXQgTEVEIFNl
bGVjdCAoTEVEX1NFTCkgYml0IGZvciB0aGUgZXh0ZXJuYWwgTEVEIHBpbnMNCj4+IGZ1bmN0aW9u
YWxpdHkNCj4+ICsJICogaW4gdGhlIE1pY3JvY2hpcCdzIEVWQi1MQU44NjcwLVVTQiAxMEJBU0Ut
VDFTIEV0aGVybmV0IGRldmljZSB3aGljaA0KPj4gKwkgKiB1c2VzIHRoZSBiZWxvdyBMRUQgZnVu
Y3Rpb24uDQo+PiArCSAqIG5TUERfTEVEIC0+IFNwZWVkIEluZGljYXRvcg0KPj4gKwkgKiBuTE5L
QV9MRUQgLT4gTGluayBJbmRpY2F0b3INCj4+ICsJICogbkZEWF9MRUQgLT4gQWN0aXZpdHkgSW5k
aWNhdG9yDQo+PiArCSAqLw0KPj4gKwlpZiAoZGV2LT51ZGV2LT5kZXNjcmlwdG9yLmlkVmVuZG9y
ID09IDB4MTg0RiAmJg0KPj4gKwkgICAgZGV2LT51ZGV2LT5kZXNjcmlwdG9yLmlkUHJvZHVjdCA9
PSAweDAwNTEpDQo+PiArCQl3cml0ZV9idWYgfD0gTEVEX0dQSU9fQ0ZHX0xFRF9TRUw7DQo+PiAr
DQo+PiAgIAlyZXQgPSBzbXNjOTV4eF93cml0ZV9yZWcoZGV2LCBMRURfR1BJT19DRkcsIHdyaXRl
X2J1Zik7DQo+PiAgIAlpZiAocmV0IDwgMCkNCj4+ICAgCQlyZXR1cm4gcmV0Ow0KPj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbmV0L3VzYi9zbXNjOTV4eC5oIGIvZHJpdmVycy9uZXQvdXNiL3Ntc2M5
NXh4LmgNCj4+IGluZGV4IDAxM2JmNDJlMjdmMi4uMTM0ZjNjMmZkZGQ5IDEwMDY0NA0KPj4gLS0t
IGEvZHJpdmVycy9uZXQvdXNiL3Ntc2M5NXh4LmgNCj4+ICsrKyBiL2RyaXZlcnMvbmV0L3VzYi9z
bXNjOTV4eC5oDQo+PiBAQCAtMTE0LDYgKzExNCw3IEBADQo+Pg0KPj4gICAvKiBMRUQgR2VuZXJh
bCBQdXJwb3NlIElPIENvbmZpZ3VyYXRpb24gUmVnaXN0ZXIgKi8NCj4+ICAgI2RlZmluZSBMRURf
R1BJT19DRkcJCSgweDI0KQ0KPj4gKyNkZWZpbmUgTEVEX0dQSU9fQ0ZHX0xFRF9TRUwJQklUKDMx
KQkJLyogU2VwYXJhdGUgTGluay9BY3QgTEVEcyAqLw0KPj4gICAjZGVmaW5lIExFRF9HUElPX0NG
R19TUERfTEVECSgweDAxMDAwMDAwKQkvKiBHUElPeiBhcyBTcGVlZCBMRUQgKi8NCj4+ICAgI2Rl
ZmluZSBMRURfR1BJT19DRkdfTE5LX0xFRAkoMHgwMDEwMDAwMCkJLyogR1BJT3kgYXMgTGluayBM
RUQgKi8NCj4+ICAgI2RlZmluZSBMRURfR1BJT19DRkdfRkRYX0xFRAkoMHgwMDAxMDAwMCkJLyog
R1BJT3ggYXMgRnVsbCBEdXBsZXggTEVEDQo+PiAqLw0KPj4NCj4+IGJhc2UtY29tbWl0OiA0YjM3
N2I0ODY4ZWYxN2IwNDAwNjViZDQ2ODY2OGM3MDdkMjQ3N2E1DQo+PiAtLQ0KPj4gMi4zNC4xDQo+
IA0KDQo=

