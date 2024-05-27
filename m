Return-Path: <netdev+bounces-98158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6735F8CFD75
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 11:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19994281037
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 09:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B7E13A888;
	Mon, 27 May 2024 09:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MhfR46x1";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Z4sCqJsX"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55A013A877;
	Mon, 27 May 2024 09:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716803366; cv=fail; b=d69BfvevF5DtWAhvozQ2YZ6HyF97AyaxCWWXl6rQdHh1DOmfHL4bTNUOM0Wmp2rrFHEkI0jI+Wzvv4NF6SJU8IoL1wan6snb9hjCBnc+6aB+rGApCLNCAeAJ3ITesWFl6MEDWX1+sD0/+wNIAaDtzd/XEc0SYVxe7y/EmZ22WG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716803366; c=relaxed/simple;
	bh=/IJxqFaCAJxKUoJnwjlvtSqWKrp2Ij32dr2kFIos9pA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s/OuaSKDypA3/Kv2krwhd2ANgmByE/r+86cqjx59bcMnxn8Ifb8RNzDz71GBmnxr9xW3skUOMuExdW51v9zz5C3LbHCgWLVWa5QiQ5zgV0vqUl0ZaZUsUhwRaDo5VTL9c3vWXZpUpbWaa5RRvMBElUsEIJiH51PprUFfpiQXli8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=MhfR46x1; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Z4sCqJsX; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1716803364; x=1748339364;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/IJxqFaCAJxKUoJnwjlvtSqWKrp2Ij32dr2kFIos9pA=;
  b=MhfR46x1rMv1WV+bi/mbSI50vEoT/HrL/eVqojQOXofWNJkKi2Os8f6G
   X5VNUxaRsz1j+5n1p6x5OsFVXE3PiSyRjVx3SwNMu9Ckrau8UH9Wjplfv
   lqCVn5nYdaz99EyR+GxRhiIf6Il5iLVMhDBDRWvLOLcJIjRo7UkxNqT3V
   jsCVjO5wBIMcLqWYQ22EHhPYobekkl/sO+LftetMJwN1gXU1GJQ8cXJL2
   PxKimDyCoGy7dqQGMVLnBoBGrCAk5Dzsc83N4Ybnp0b1isTw+G+Tdq5pQ
   0cAEiCsl7rojuAbJEuOVVHMnQUbdb2tOHg6V3XkEdanSGshWrFk131gZp
   w==;
X-CSE-ConnectionGUID: +RHgMxyXSTOmX/H7JE7Yaw==
X-CSE-MsgGUID: N8dVJef5S9Oblp3h19fr3w==
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="193775910"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 May 2024 02:49:23 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 27 May 2024 02:48:12 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 27 May 2024 02:48:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+TurSleAVVbGGgddT53PDFJdg6aDZ1e3KJf12W1u2jIJrapfbPg7rOHs98h3wdTn54Pxd3UCGXMuFR3OGfMNG7fcp99Tm3+Lz0XFqip7fMAooYBoNaU83WRGWm+bTBjPCgmDrcDTelqcpkCLXJDwp9xZv544guJicW7OIFNEKxIlbRSDQqxBCKd9Lp5/b1ygiDFo3LqkkfFXEzKNZveSPpX+hgB7KFd1w9xagbsISHie2OXs2xHdE+k8dx/HxMawY76FB46AQbSpA09Q7jKf6NiCPaTg+7jJigj9q0YRVwZ7zCOIxCoahX/e9Ri1Ebd/o6gzd/A7WYvegmA4wAENQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IJxqFaCAJxKUoJnwjlvtSqWKrp2Ij32dr2kFIos9pA=;
 b=QjjEZHyM9FRMWcKTOwVgsQzQqcWnxNsEVtADVKuAf9f17XKtxXYDkibVIo4RiakwP7vi/L+zOqtiwVqNmY5sPoMYkoOPsCJdRpwUlxo27ft8falPlaSPTIRDEXS+9Dk6xAfQ3sNlxsG9Imfm+BS+hK2MnZZu0+eMgGmH2cNVEPiixVXTTEqY84yMmlAhL1V7q7SLGr+dYV1hgKpYUd0azF8X4eqozHSHWeNmHtqPYpb7fUGhZMaz7OJNLgS1hUYjDraDhFrogs2r76SImsEkcg3m9qmV1ETGII0SiKcRsLC5TJWKp5G8u0pGvdOlObazyqiahku3Y2Dv5ucW/rlh3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IJxqFaCAJxKUoJnwjlvtSqWKrp2Ij32dr2kFIos9pA=;
 b=Z4sCqJsX5pXchzfethisVS9pm8ZSrrQyackN0A2fDjjjeE0qDxZIti1THLfmw3/9nZkHbDKICTy7lVbqwFnWx4q9MCRqdZkDEXNonkqbTJtHcuMdp5a/1onxB3vl67xS872MBk9gDq/j+hyl6MUU4E3ER7uI1XJ78BgQRCesZtga0hS0kJ9XjAUTvwZzNGiBp0MxdZ7jWFepzXqnP5CohzlW511DMV9zJEEjk9kjOnAmx0ALVjVcc7vziBuITO3t7a8ZUn1bfe3hbIqgQTEg/hXHGewSEF8IVyw8Pn0vW2ERySXkz6cAULrxDF45hxocnm8GQfqvD6WMtjqKZc3DGQ==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by SA1PR11MB6808.namprd11.prod.outlook.com (2603:10b6:806:24f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.27; Mon, 27 May
 2024 09:48:10 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%4]) with mapi id 15.20.7587.030; Mon, 27 May 2024
 09:48:10 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>, <ramon.nordin.rodriguez@ferroamp.se>
CC: <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 0/1] phy: microchip_t1s: lan865x rev.b1 support
Thread-Topic: [PATCH net 0/1] phy: microchip_t1s: lan865x rev.b1 support
Thread-Index: AQHarePdJZh+m0FZZ0WCxjUHsxgGEbGmd7uAgARiaoA=
Date: Mon, 27 May 2024 09:48:10 +0000
Message-ID: <70c0b4d2-c947-499b-8263-ea7f08f853e3@microchip.com>
References: <20240524140706.359537-1-ramon.nordin.rodriguez@ferroamp.se>
 <99f56020-9293-4e6b-8c2a-986af8c3dd79@lunn.ch>
In-Reply-To: <99f56020-9293-4e6b-8c2a-986af8c3dd79@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|SA1PR11MB6808:EE_
x-ms-office365-filtering-correlation-id: 68dfbbb0-10dc-45a0-5c1c-08dc7e321ebb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?bEswUWtsZE8zVHFtTm0wbDFyUm91a1haWXJ1N0taRnFOWi9oUGh3Z0tEN3l6?=
 =?utf-8?B?M2I1QzJlUndjNTlFU2Fmb0hlbUV0YlR3Ym8zS0ZwbTd5R0F5ckV0VnF3QVYz?=
 =?utf-8?B?Tk52emh3cDVHVEgvdDlqNVU0a0NNamhWZDBRenRSaHpVd3JXMGdVcG1IMnRD?=
 =?utf-8?B?UnFKbHdKRndqU1lOT1MwN1NzbnhCT1RMeTJxZmFvSVpSdTJvdjl2UGJTTkZX?=
 =?utf-8?B?TzM3WE54eFE0dmVPZ2lhM01rQ3E3UGNSejJmQnVhS05nNktrK3hlMlpSSS9D?=
 =?utf-8?B?UUxBMTNIU1VEVy80N0dTQURzYnpIZnBvY2hXdElGOFJFM25ZS3M0YlFlNVZ6?=
 =?utf-8?B?TlBQbXlIbDl3dGdadE1GS2NyenFRbDRBWVBJc3laZEFhOEVmWE9DSDlCdGVw?=
 =?utf-8?B?c3o5UEdpQkQzY28xRk5Ga2NKbGhYa3djdWxrOWpQS293QTZtSTRjM3RFbzV0?=
 =?utf-8?B?eU13N3ppcDVNai9CTG9QTzloMFphUVA0STVLazkyNWhjd2xYMmd3SWNseUtr?=
 =?utf-8?B?YkZ1a3hyU0F4TWR1cm9nZmpkTkVIdFlVQXZZOENEekluRzNVQTI3R3djOUhW?=
 =?utf-8?B?WUVkR0FwRnhnY0J4VFU5d01na0t4WlRMcEZheTB0VW9vZmJVMk5saS9jVTBJ?=
 =?utf-8?B?K0pFR3hKMkZxOHB5K0loSGlFQ0ZiRm1qWXhmVTF3dEJMNXB2MWVYSnBaQWUv?=
 =?utf-8?B?Zm1PSVlUSlVKcXJFNC9oL2YyVnNmckJ6ek10Y0JRbFNlekZiajRkYy94bEhI?=
 =?utf-8?B?dUprUkxWcU1PRFdlb3g5TldFaDFKczJNYUFhM1pOLzlMa0V3bzBocmp6NHFE?=
 =?utf-8?B?bCthamVGc0NpTW9DdFF3OXh0eUZJZ0duMzNjODVJVEhnYUQyTHovU1NHck9p?=
 =?utf-8?B?VmlmZjhHcEtjeEF5R0NKSnVaWk1OVml4UlpGajc3UHZXc1JHRFZhT1FsUkMx?=
 =?utf-8?B?MkV5a0dqYXN2NkRvakdGUWhGNHRLL0ZBc29xL0hab2Fac2RTQ05SZm9oaWZ4?=
 =?utf-8?B?VzN1S0p2R3RCK2pPblBMc0g0dVQ5VkVaL0ZUVVMzNUlOWlphZWlJa1J3TGF4?=
 =?utf-8?B?S2xuNWVoY092K1phM0R1NklCVm91LytvcEN3dk1ScjdwNUJ0MWxldVRCMXJL?=
 =?utf-8?B?dm8zRU8rVDJvWHBhRWcySG82Y2ZzNm5qV2E2VXJoK0hvbXJCVjVHNGJjY0Q0?=
 =?utf-8?B?NHY0ZTVvbW9ZTDNRMmFneCtFZ0FtWEx4cjFxVDMyaFJhcUdYdEpRckc3WnNU?=
 =?utf-8?B?ZXVwaXYrVXRZVWVadmppdnhoNEZvTWVPK3VMcWhYVnVuRzh4N1lQOE5MVEs0?=
 =?utf-8?B?ZEx1OWhnNExrL1NUZmQvalFHeDZWcFAwdnk5cStIbGovNndLYk1WaGRVcUJN?=
 =?utf-8?B?TjBiZzZqWEVMTDlQeWcvU3R6cjVLdWorUjBIL1VLZkk1ei95aVllUFp3V2Vr?=
 =?utf-8?B?bCtTNWZ6czJWN01IbkgwZ0dZcDNRWVhHRmMwL255MmE1SXA3UFlPWm0xeHdC?=
 =?utf-8?B?aHowblJ1alZFSStFY3UxMDRRc2lvc0RuNmhRazh0WERyRFpiNk5ZeGhzamtD?=
 =?utf-8?B?SURKaW1CLzRMVzBxTHEvYTFCN3BLWUZxZ2lqcTM3YXhEREJBOFV5dmRMOVZo?=
 =?utf-8?B?cWVSb3paMjZiUFhNOW9NbUpzdi9UampqN1RsTEFXcXNKY3pwcFc3OG00YnZ2?=
 =?utf-8?B?bmQxWFlUQm9oanNKQUk2V2Ixd0JiOWtDcnRCTm5BNzE0NU5yTFdxaHFZTFVF?=
 =?utf-8?B?SFNibEMvS0hWMHJtekpEQjlmQUxoQ3pSSGxRMytqamZkYVdBMEZoVlFMbWRh?=
 =?utf-8?B?Ry9OTlZwaGJoM2V6VEJXdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0xNWExvKzRYWGRNTG1SSmhKRldxZGsrdE95RU5aajdPcDJvdFI3REwxbGRo?=
 =?utf-8?B?ZXpFdlpzSlFRTzRIckIvTzFYYlE4TkhQTGdLMk53Nk12dFZtU2FCeUp2Ymkr?=
 =?utf-8?B?dlFqbGhpK3RQbGZQeW5OaTJMemR2SXJ3RDNIbmtoRFlGYWVpUkhYekoyc1l0?=
 =?utf-8?B?Sk00QWU2S2hxamsxZnlkcG1Hb2FRaWMvMGR2YlQrRktCMS9lMzE4RWFZcWtl?=
 =?utf-8?B?bU81MXNRWHRDOCtnay9CUGdFSUhiRnJrVmdtL29XUjA1enpHVXVkNFliQ1By?=
 =?utf-8?B?cWhrTHk2VGQ0V0tFRG5icXdxYUVxZzQ0Tld3anZJUE41YjlvU0x5RHRBbEcw?=
 =?utf-8?B?eXFlVWc0ckEvcHhrcmRYKzdGd2g4SEMwdG1QcHJTWjFubEFFYzRzdldZVk9j?=
 =?utf-8?B?ZThObTRiT1RTajVhNkk0MHBrM0xGSFR3Ni9ZS1hpcFNSY2JHTGUxa1JXVXMw?=
 =?utf-8?B?eUNXT1k1V05LVHlvelBZazJVT3VEZnM4enBLUW1kYkhZRHliQVRYaWlhZTFO?=
 =?utf-8?B?aXdTNE5ib0huNEwxdnE2cVUvalBqa01zQTd1Q1JlNlBRaWJsR1QyZHRRRXJ4?=
 =?utf-8?B?WThkT2V4SENsbjE2cEZ2VjFPSmJOMEFCcDlEbzczdHo4MUxhRkowUFc2QVR2?=
 =?utf-8?B?eXdKWUd6NTB3N081VFBNNkJJUEFjdVQ2ZUZEOFlkSlJKWk4vbUJnakw5MDhB?=
 =?utf-8?B?eW5UUUFKYVUxc1hVMTRhS3NHYWZ6VUF5OFdaKytvdmowVXQzQkhjOGkySFhJ?=
 =?utf-8?B?eXdQaTB3WmdTaHVGUi9KRHlQZFRvYU0vRE84NzlZd3liWDNZamthWm5sL0dY?=
 =?utf-8?B?SE80SUY4czQraDJReG4wdjFES3BGWVNidWVLWEZIbDdpSE9RR2t0VzQ1SXQx?=
 =?utf-8?B?UUV6OVpjeWdBVWMzZkJoc1FKQXJ5NGNJc3NBcUFuSXFlVVJNUy9RNUdTSTZF?=
 =?utf-8?B?aDFTbkZzTXl3WUNtZVFwUXZvbW9TdzBheTltZGtWYTR1YmVOZFpNVmljYmFK?=
 =?utf-8?B?eTk1bG1pa1NzYk8zMEpnc3BIRmtFeW0wTndXV1BhSXB2NnE4MEVoU2d0eC9D?=
 =?utf-8?B?WVdyWk9xa1hPQmRSeU56U0doV2s2Zk1Mdy9ZcEtyWmpQQnlrNHhGTmpkRWI0?=
 =?utf-8?B?L1hqM3QvR0I0T083NkJTamxkMkF4QUd6NVg2NmxXL05yVVNvZWNCUW01Wm5W?=
 =?utf-8?B?UkdpWmt5ZHMvQ1ptem4yQ214NzNFaTFuYzczQkpLbTNMRFkzQmhKWnFRTjdE?=
 =?utf-8?B?b05yVzI3UFNJRlduRmFpeHZBSUlCd2VwS0h2MVR0dEttL0hHSUR2SmVQNnVs?=
 =?utf-8?B?NEtQV0JaZFdHZ0Z4dW5YYlBsSitFNXFMcnVielpCNGR2U0VCN0FmTnlCbW5n?=
 =?utf-8?B?OSs1clZrdmVuU2pSbWkwcENtMzY0YjQ1b0VIYlF3UFhKV3p6c0ZhL2hrZDhL?=
 =?utf-8?B?d1dYU1hVQ3ZzRVY3Sk5RK040WlF6bFdCdXVUVTZzSTd5SW9MWGpKRmJnVjcy?=
 =?utf-8?B?VXkzYU50Ujdlb3ZIVWlGaDdrcTlRTzZQV2hwYmdySEU2MFpYQXpCbUNuK2tm?=
 =?utf-8?B?eHhxTElrTHlmT0llSHJQZnZ1QjlFRGZFUlRsVzNsUXpsYXphTXUzYnloTkpZ?=
 =?utf-8?B?ZlZLQjdXcS8wbm1uR2tVdmRVQWx0V0FKdDFZTW5WaE52ZkhhaWhGTU0rVW4y?=
 =?utf-8?B?U1AycTFaK0Q0dGxiVndUa3J3cHlGRHp3MzBvYXBsOGtFUXhia3k1d0hubXhF?=
 =?utf-8?B?ZmVBTExOa3VRcWNzdXhhQWR4dWMyck9LVGtCZHZNZGFrNXQwS3VwU0RpQ2Nj?=
 =?utf-8?B?TWhZdmdOdDgxQnNPWTJxYzl1Wk10RnRKODRhc3FDYzVKc3QrMTFiUlV5Vjcz?=
 =?utf-8?B?cmdnUzZNdmpuSXJNb1RFVExvOEFFZ3ZpZnpVaFJ6alRQNTBNNk1YbW1sUlc0?=
 =?utf-8?B?d1BaQTBFWTVCc055ZVFVSkpSeS9FaFliNGZCK0UxMVhHRVlMamhwYUl2MXdp?=
 =?utf-8?B?M0lDRUljWVl3N0JKOHVST3dIbkNXdnpkbVd6b2hPUFF0eFR0Yjk1aEg5ZXRp?=
 =?utf-8?B?VGxUaFNmeWk5V2ZQamhDWnROczkwZ2QwQUtDcjFMTVcwZyt3ZWsxRGx2UHZU?=
 =?utf-8?B?QWV0anJBZTBTamNKT0NyYUJiTEZkS2hZYlJOZ3FUYTFFZFJnNmZyODZldzBh?=
 =?utf-8?B?S2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49FD1F3F6C83384AB285755A5F20C4B1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68dfbbb0-10dc-45a0-5c1c-08dc7e321ebb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 09:48:10.8243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: osC3ohz0CC8uYaaq1nvWnDdRkhS+xP3OCb9YG9vn0KOf2WqUaZwu6N/s14p5AJ55NkDgCxZ/qSaSMwrZZgZj4wzeQy6jVM7yTI8DRYWOWNk8Mj6fDkoeGb1Iq6Lc50Ka
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6808

SGkgQW5kcmV3LA0KDQpPbiAyNC8wNS8yNCA4OjIwIHBtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4gRmFyIGFzIEkgY2FuIHRl
bGwgdGhlIHBoeS1kcml2ZXIgY2Fubm90IGFjY2VzcyBzb21lIG9mIHRoZSByZWdzIG5lY2Vzc2Fy
eQ0KPj4gZm9yIHByb2JpbmcgdGhlIGhhcmR3YXJlIGFuZCBwZXJmb3JtaW5nIHRoZSBpbml0L2Zp
eHVwIHdpdGhvdXQgZ29pbmcNCj4+IG92ZXIgdGhlIHNwaSBpbnRlcmZhY2UuDQo+PiBUaGUgTU1E
Q1RSTCByZWdpc3RlciAodXNlZCB3aXRoIGluZGlyZWN0IGFjY2VzcykgY2FuIGFkZHJlc3MNCj4+
DQo+PiAqIFBNQSAtIG1tcyAzDQo+PiAqIFBDUyAtIG1tcyAyDQo+PiAqIFZlbmRvciBzcGVjaWZp
YyAvIFBMQ0EgLSBtbXMgNA0KPj4NCj4+IFRoaXMgZHJpdmVyIG5lZWRzIHRvIGFjY2VzcyBtbXMg
KG1lbW9yeSBtYXAgc2VsZWVjdG9yKQ0KPj4gKiBtYWMgcmVnaXN0ZXJzIC0gbW1zIDEsDQo+PiAq
IHZlbmRvciBzcGVjaWZpYyAvIFBMQ0EgLSBtbXMgNA0KPj4gKiB2ZW5jb3Igc3BlY2lmaWMgLSBt
bXMgMTANCj4gDQo+IEluIGdlbmVyYWwsIGEgTUFDIHNob3VsZCBub3QgYmUgdG91Y2hpbmcgdGhl
IFBIWSwgYW5kIHRoZSBQSFkgc2hvdWxkDQo+IG5vdCBiZSB0b3VjaGluZyB0aGUgTUFDLiBUaGlz
IHJ1bGUgaXMgYmVjYXVzZSB5b3Ugc2hvdWxkIG5vdCBhc3N1bWUNCj4geW91IGhhdmUgYSBzcGVj
aWZpYyBNQUMrUEhZIHBhaXIuIEhvd2V2ZXIsIHRoaXMgaXMgb25lIGJsb2Igb2YNCj4gc2lsaWNv
biwgc28gd2UgY2FuIHJlbGF4IHRoYXQgYSBiaXQgaWYgbmVlZGVkLg0KPiANCj4gU28gaXQgc291
bmRzIGxpa2UgTWljcm9jaGlwIGhhdmUgbWl4ZWQgdXAgdGhlIHJlZ2lzdGVyIGFkZHJlc3Mgc3Bh
Y2VzDQo+IDotKA0KPiANCj4gSSBndWVzcyB0aGlzIGFsc28gbWVhbnMgdGhlcmUgaXMgbm8gZGlz
Y3JldGUgdmVyc2lvbiBvZiB0aGlzIFBIWSwNCj4gYmVjYXVzZSB3aGVyZSB3b3VsZCB0aGVzZSBy
ZWdpc3RlcnMgYmU/DQo+IA0KPiBEbyBhbnkgb2YgdGhlIHJlZ2lzdGVycyBpbiB0aGUgd3Jvbmcg
YWRkcmVzcyBzcGFjZSBuZWVkIHRvIGJlIHBva2VkIGF0DQo+IHJ1bnRpbWU/IEJ5IHRoYXQgaSBt
ZWFuIGNvbmZpZ19hbmVnKCksIHJlYWRfc3RhdHVzKCkuIE9yIGFyZSB0aGV5IG9ubHkNCj4gbmVl
ZGVkIGFyb3VuZCB0aGUgdGltZSB0aGUgUEhZIGlzIHByb2JlZD8NCj4gDQo+IEhvdyBjcml0aWNh
bCBpcyB0aGUgb3JkZXJpbmc/IENvdWxkIHdlIGhhdmUgdGhlIE1pY3JvY2hpcCBNQUMgZHJpdmVy
DQo+IHByb2JlLiBJdCBpbnN0YW50aWF0ZXMgdGhlIFRDNiBmcmFtZXdvcmsgd2hpY2ggcmVnaXN0
ZXJzIHRoZSBNRElPIGJ1cw0KPiBhbmQgcHJvYmVzIHRoZSBQSFkuIENhbiB0aGUgTUFDIGRyaXZl
ciB0aGVuIGNvbXBsZXRlIHRoZSBQSFkgc2V0dXANCj4gdXNpbmcgdGhlIHJlZ2lzdGVycyBpbiB0
aGUgd3JvbmcgYWRkcmVzcyBzcGFjZT8gRG9lcyBpdCBuZWVkIHRvIGFjY2Vzcw0KPiBhbnkgUEhZ
IHJlZ2lzdGVycyBpbiB0aGUgY29ycmVjdCBhZGRyZXNzIHNwYWNlPyBUaGUgTUFDIGRyaXZlciBz
aG91bGQNCj4gYmUgYWJsZSB0byBkbyB0aGlzIGJlZm9yZSBwaHlfc3RhcnQoKQ0KPiANCj4gRG9l
cyBNTVMgMCByZWdpc3RlciAxICJQSFkgSWRlbnRpZmljYXRpb24gUmVnaXN0ZXIiIGdpdmUgZW5v
dWdoDQo+IGluZm9ybWF0aW9uIHRvIGtub3cgaXQgaXMgYSBCMSBQSFk/IFRoZSBzdGFuZGFyZCBz
dWdnZXN0cyBpdCBpcyBhDQo+IHN0cmFpZ2h0IGNvcHkgb2YgUEhZIHJlZ2lzdGVycyAyIGFuZCAz
LiBTbyB0aGUgTUFDIGRyaXZlciBkb2VzIG5vdA0KPiBuZWVkIHRvIHRvdWNoIFBIWSByZWdpc3Rl
cnMsIHdlIGFyZSBub3QgdG90YWxseSB2aW9sYXRpbmcgdGhlDQo+IGxheWVyaW5nLi4uDQpJIGNv
bXBsZXRlbHkgYWdyZWUgd2l0aCBhbGwgeW91ciBhYm92ZSBwb2ludHMuIEFzIEkgdG9sZCBhbHJl
YWR5LCBJIGFtIA0KaW4gdGFsayB3aXRoIG91ciBkZXNpZ24gdGVhbSBhYm91dCB0aGlzIGNvbXBs
aWNhdGlvbnMgYnkgdGhlIHRpbWUgdGhpcyANClJldi5CMSBzdXBwb3J0IGhhcyBiZWVuIHBvc3Rl
ZC4gV2lsbCB0cnkgdG8gZ2V0IHRoZSBjbGFyaXR5IGFzIHNvb24gYXMgDQpwb3NzaWJsZS4gU29y
cnkgZm9yIHRoZSBpbmNvbnZlbmllbmNlLg0KDQpTbyBJIHdvdWxkIHJlY29tbWVuZCB0byBnbyB3
aXRoIFJldi5CMCBzdXBwb3J0IG5vdyBhcyAiQ0QgZGlzYWJsZSBpZiANClBMQ0EgaXMgZW5hYmxl
ZCIgZml4IHdoaWNoIGdpdmVzIHN0YWJsZSBwZXJmb3JtYW5jZSB1bnRpbCB3ZSBnZXQgdGhlIA0K
Y2xhcml0eSBvbiBCMS4gU28gdGhhdCB3ZSBjYW4gZXZhbHVhdGUgdGhlIFRDNiBmcmFtZXdvcmsg
KG9hX3RjNi5jKSB0byANCmhhdmUgYSBpbml0aWFsL2Jhc2ljIHZlcnNpb24gaW4gdGhlIG1haW5s
aW5lIGZpcnN0Lg0KDQpCZXN0IHJlZ2FyZHMsDQpQYXJ0aGliYW4gVg0KPiANCj4gICAgICAgICAg
QW5kcmV3DQo+IA0KDQo=

