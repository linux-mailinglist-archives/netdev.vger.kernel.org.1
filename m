Return-Path: <netdev+bounces-97727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9598CCE9E
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 10:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E98D2826D0
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 08:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E85A13D26C;
	Thu, 23 May 2024 08:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MpB2nLsp";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PvJAGHx8"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4DC13CA89;
	Thu, 23 May 2024 08:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716454340; cv=fail; b=KiZSQocs5cm6BhoIM+TERdKeVCUdqamIOEyWAKy8NThCJHroVxFIAZdqQ9lD/o+fGFEwCnINvVCsNP/j9gvgEJm8O/Ok24K4+sd2tu8iGfH6j9io+fQ6kBbCHnrTJZqe2/oLa6xkSwb2M+cW8JYqk5nmgfINZDy3xmSqeKxaKQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716454340; c=relaxed/simple;
	bh=w6gzmNofM0DtyLSCNkWNqLmRxoBldscAm8oPhHUY9hE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MAK3tkRCr77rlrIsp7BBQWJYCT1X7bTx2r13aCXAyJVOeY8dRjWyYFa+j3AGnoL96TW8LMwgjFhT/Djup1dt2xwplplL2q/F+46n3NjWiqMuIaYtjYZw6z51CEgWIMECdPtB/SFmf2g/92JoXQXN8RVIEj/+1mqP6kezWzJdARo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=MpB2nLsp; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PvJAGHx8; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1716454338; x=1747990338;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=w6gzmNofM0DtyLSCNkWNqLmRxoBldscAm8oPhHUY9hE=;
  b=MpB2nLspJ1tYbXw73aMxc4bAxUuzpolqjCeFkaJ+BxtwiLwPb9p5UKT3
   DgPxN4ZbAwpP4IHg7zo2gRgVtMWbyZS48gG/Jv2R1EwrKjh9JkTvyHhmD
   asvlc7O2pjEOYLWpm4K1oNHioXDSO7V3OLVXzKPQmugLzH23+Z/N0MqVn
   pLx8GMdFcm2xP65qEBkqq1HMfngzff/BdtsHGQK8Gq/jNa9ur1shCkvMo
   seR+FcMqfX9s+dddHWoTtiOHD6YfynvVLmn9D/d6gLw4OPaynboES5c0t
   7xC/5bPfnbf0izfJ5+I4f2o0RvzyYmZSy8mzhGqhHBJVLORyN4XXzf2Ei
   w==;
X-CSE-ConnectionGUID: qH1u7DDdTtKGNfMOeQZcDA==
X-CSE-MsgGUID: +2BdW5jYS4CC/lKCbM6abg==
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="25887053"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 May 2024 01:52:13 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 23 May 2024 01:51:50 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 23 May 2024 01:51:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwOx5Nb4Qg3BkpJJG0/OOaAwwSQTudmDSPZmSvqz20K3GYFb+cmE6MmPJnctfDH+UymvBZNZqBorzZWzOODYAzHRhxeB70QB005QvrcwwAUhQYIp/KVzYfTn4SjiA0dw/qEQjsXlOpZMBw3HL69dNBdqUq7aILxuchn/XgvY+UR+cfBCamuHevZfqo0cdoP/jmKLmwg6R5yxqy4xHTh18MsJbMFRXyCNzjecsTE1AZao9Si2Jna1IADrKrSMDI8fk1mUzV3LlzOVfR0SA6ha9pI9rfx6VxqxzBppPy5q7lNhewbVh8W1bPQLlTNuc7CruskKlEkkLRpJEqg8BIplPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6gzmNofM0DtyLSCNkWNqLmRxoBldscAm8oPhHUY9hE=;
 b=MHPyTXtBb8uBeTgr1z+RDwjHT4hm9BKntBACjye4IpT9wqT+svtGFcrTebXknltj/IMI9VV0yiZphLopPQ6vh1O5FUmzpmCYSZ1VvsB0H/HJ7Wu9gFpaYOOtMAxoEeWiskQYVTuzbk3+5/jAbCRMMAe6jCgRlvkgewZoRiwByFMX9ztgFaC6oujdsAw/dBlMtd+9ob1q/eX5ySTuKkh2N4jeY4A06H5GuqPOPkXa2iZyifGTqMrSkkFP44jJc7k8I/jtVYlwc85BBrpG77ba6+SrymnopzrNNbIOTr81u2XpqO68MCdzytImT9AZQNimOE/ArFBn80oyIEc6/qpyhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6gzmNofM0DtyLSCNkWNqLmRxoBldscAm8oPhHUY9hE=;
 b=PvJAGHx8B7gZ+2h5cjTzXhcSrjPuQDDXJBMPmivarV27QhoO+RkH+OYRBDeOcLe8Bt95VIdKm+ha2W6oYmSaJkjwgHq631/FZoIEgEvF8Nq7aad0jFcky8B43qTUcXtxJGhxfuVlBrcUpQ6rnsU/Eq6etLhYwy+p1ZRNgbrntrHC6FK90u0v5EDpu6DvuxbxdC27p6X0RnhDIOXWRNQtJHCwraql4gowiHLVkluwJWtLmINH61VMmiyllLGjTuHNb8C9UVq0jEASWFhxgXezXPbqjWVCbKSgqFU2R3/GwcopgDOpR2vm/32m+olSOH2dLexbqf0kL9uSXtkThUAcCQ==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by MW4PR11MB6738.namprd11.prod.outlook.com (2603:10b6:303:20c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 08:51:49 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%4]) with mapi id 15.20.7587.030; Thu, 23 May 2024
 08:51:48 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <horms@kernel.org>
CC: <steve.glendinning@shawell.net>, <UNGLinuxDriver@microchip.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: usb: smsc95xx: configure external LEDs function for
 EVB-LAN8670-USB
Thread-Topic: [PATCH] net: usb: smsc95xx: configure external LEDs function for
 EVB-LAN8670-USB
Thread-Index: AQHarFGdKs4gtKjRMUij/lf1SheVtbGjmkiAgADp6gA=
Date: Thu, 23 May 2024 08:51:48 +0000
Message-ID: <3e2b2b18-4dd9-4b22-9690-01e1bdd44828@microchip.com>
References: <20240522140817.409936-1-Parthiban.Veerasooran@microchip.com>
 <20240522185423.GC883722@kernel.org>
In-Reply-To: <20240522185423.GC883722@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|MW4PR11MB6738:EE_
x-ms-office365-filtering-correlation-id: c9833c85-2c46-4b8a-0364-08dc7b05954c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?cDZyRE82TmZpdXk1bkFVKzZnN09wdUxqQ2Q3cEJ2RlROcEdSV2NTVVFEK2RU?=
 =?utf-8?B?ZW83cnRQVVFIS0I5VkV2TTk4Y0pGR3QvUTk3Ym1UTnhwdGJ0R2tPdFA1QStu?=
 =?utf-8?B?UXlmVk5aV0NuUTZBVkpwQ0F3b2V2UzJlanNKcmZuNWkyTWh5a3c5WEdlN2Fo?=
 =?utf-8?B?bDYrcDlBTU1ZUW01QjcwMEFqWGFRUW9pOEU2Q0ZjRlhoZWFjYVF3NGdYaVBu?=
 =?utf-8?B?bTlnQURZazhsZ0lramFiTkNtNi9LVW5VR1RSUTJGbzdIQ05NVDYrR05OL1Vj?=
 =?utf-8?B?R1V4Z050UExnUGRlM3p5QklzeDNhNzJoTGxabmJoemwwWW13c1RsODZYSDVV?=
 =?utf-8?B?d1JqYk4wc0FsVmtvSm0xQWoyOGticmNnbTV4ZjcyVjJIanREWW5HM3ZiM0cx?=
 =?utf-8?B?TzluZkY2Q0Z2NGdGL0tXczRxTjBNY2c4dlh0QjgzbXdwMjVXK1JncUJaNG5P?=
 =?utf-8?B?L200SzBtQitBWnowT3h0R0JKdUxKQjdHSnp4U1FhaXdIbFFhdGlNdG0vVW50?=
 =?utf-8?B?MnpmZjUvRVJrZ3FSV1R3aVVTem9UQjIvOFhyNm5EZEp5dnhVb3BaMk43SmVy?=
 =?utf-8?B?VzBOajd1Y3dBcW4xZmtCT2NlcGFHb1N0bm5mSVFING9jOUthTm9hWjlMNDgv?=
 =?utf-8?B?VXM5ODdZNkdKcWdNM2ZnSXJkYW41eXh2Y3dyZ3ZTNFM4bGh5Q2k3RmdjelFn?=
 =?utf-8?B?ZVpWb2F2WS9oTk1HNEJqWFM2eFc5TFJvcGJLRitwQURna1Z4K0drM0Q0QUxh?=
 =?utf-8?B?djlUUzNnN1g4ZmIreUxMeXFvMFJtVjBHR0F2b25IUUp4dkhxOUhUQzFpK2hR?=
 =?utf-8?B?aGpWYTRIZnN3d1pIRWhxREh2L0ZsSzcrNnI5cnU2NDRjaExLMHF3NHRMcGh1?=
 =?utf-8?B?N1JHY2M2WG9XZzRPWlpxdlZaRWlGK2szOEJaZzlPZWdEZzBvNGIwbmVHM0Ey?=
 =?utf-8?B?T04vQ3drVHkvN2NsdTQrR3luaGRhZ1I1K0g3dTYvS01JU1M2azV4dWUxbUZr?=
 =?utf-8?B?TGg0YzJ3b0RlY3Y1UnkrTUMxYmZnWk9DV3FpNHRoU0ZQZkF2UnJVS1lSSFVz?=
 =?utf-8?B?cy9UcDlyOEtvd2ZEayt5c3Y5bFk0NnlmVGgvcG45NDNkSVVVS2tuN3pRd3B0?=
 =?utf-8?B?T1FzV3JZTzBRNGRsTmZHRmJRcks4SXJxQlZ6UGtVOVFKcXpBSkZydHYxN1dI?=
 =?utf-8?B?Tnd0RHI1Y2xGN0dUeW85K21nRTJwalY3cXFyOGt2T2J5RmMxOEkzdFR0Kzlj?=
 =?utf-8?B?UThNMDhPbktkS2RzQTBIR2hKblhXRDJaT011aGxiM2VsT1UvemVhaE9rY3cx?=
 =?utf-8?B?dlZrQ2VhNnNRengwZ0NwSk42NEIvY3pGNzNoZEo5cWVnWlNRcUlEalVUOC9P?=
 =?utf-8?B?WjdpdmgycGFpdEorL3Y5WitWWnRVL3JzbGg2TU4wTWQ1bEdWd0FkL2F2YUov?=
 =?utf-8?B?U0RqMnVRT1hlUWJaSm5KZCtNWWk0WmtwWVFEd0ZHczIvN3JPN1BTUzhSWm1Y?=
 =?utf-8?B?bmdtL0VFMFN3eHpaZ2VlK05iZnFTRURXUjFYRkl3eHdaVWxFcEVIcWJMWXhO?=
 =?utf-8?B?dkg4R2xUYS9laC9hVmVybkplWE1Kd0dGMFNyVUUzak5nVjg4eUxlM1lCcWZ0?=
 =?utf-8?B?UG1ZalliZXA3THJQRmw1UCtUQlhKNFNYMWVaWTVvaFJFYXhONnJZaHltcWZq?=
 =?utf-8?B?ZmU1aFlySFB1SHFIaVoyRmp1S2Y1YXRkRHZ6UFN0TWZhaUxCK0xQYW1obzBk?=
 =?utf-8?B?cStuSWdNR3QwTWVQTkNiSXFWNXRKWEdGWXFEVDlyTWJBNnpmQjhNMy9VR2dP?=
 =?utf-8?B?TllSKzlQTnhGZjVGalRvQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2xYUURDRld4OW9LZGRGd3dWc2RXMENUcC9Td29KaW4zczhJMTRxcXlmYkNr?=
 =?utf-8?B?Y0FLOXVVL2J5MVhETzg2ZTUvNEd5U3d1M2E3U0ZqMEg4cUZrTVRCWFZQVmtx?=
 =?utf-8?B?QjdwTDVEN2dhRHJKaG5pOVhKRUo1MCtycFBTOWFEb3VZM2dnMEdnS2VDQU1G?=
 =?utf-8?B?RCsxUVcySDQ3aERQb2dGR3NCV3M2aVpMTFlKOHFFY2tnY1B3UkdVa3FKTWYz?=
 =?utf-8?B?eFo2TE5IY0xXaW1wU2MzVDVCSkJDVWdGRm5FYVI4R0NKSHp5L2o4Uzd1dUV6?=
 =?utf-8?B?RmR4K0Vab1VPVkNKd2NzNS9GRS9lOHR4ckRDZ2Y0Tk8vSDA0ZnliOVlUdll3?=
 =?utf-8?B?c0RzYjd2UmVLbEFybG96THJDRkI1VW40amFmc2VoT3JSSzZKdHJZV2ZHV1hj?=
 =?utf-8?B?S3BSTE9ML3FVUnJvWGZQSzFMMllyVjFYUmRUMVhuMXQvRkNGMUZQMnFjWlJK?=
 =?utf-8?B?cVRxZUFtWVdtdWFrYWhqaXl4b1Ixc08wWGNoSW5Ic3JvdHFLeVJ0RU9DZ0Nj?=
 =?utf-8?B?a0Z2cjcrS1hUWmNab0REUTJEZDc1WS8rdlE1Wi9kMElaTHdZSTErVTZIQ09k?=
 =?utf-8?B?SUdVVmVWTkdjVjdqaHp0eGUzRWVUS3V1Ylo1SG9KSWxocTZ5U3l3TzR5Y3RW?=
 =?utf-8?B?cnpSY0ZweUNpSmlYY2k0QStpNW8zQVZQWmxYb0lnbHRCUHBPRm0xM1J5cC9H?=
 =?utf-8?B?YWhNbzlta0YxSTdqeDlVaTUwOEZOZTRmZm5MVS9QRi92ODdiUnNiSFVRQk03?=
 =?utf-8?B?UVpINlJCYmNZNCtlb1phbjhnRVJTM1h3S1hLSUd1QlhoQmMxZzljTklDSzV1?=
 =?utf-8?B?U3poRXVMeGxDYnM3SVpEaXBUWWJXZld0ZVVuaTJwekI1bmp0OG03TXNOU0Vn?=
 =?utf-8?B?YU9rMG9MbG1TTGZudS9lOHcwU1dRblVQMEozSEdTV1dEdnV4N3pNTlFYb2Jp?=
 =?utf-8?B?VjJ5eDllbjRJV1V0NUUzbnVRTmtoOStrNzRzNkQ1c3E1amdEUlAxSmZlOW5D?=
 =?utf-8?B?cEw5cVZ5cWxWQ09KYUdpMWZ5WGZRVU5TUEdsRW9BSzE5anZxKzJyS1dZeHhu?=
 =?utf-8?B?MnIxVWplWUxiWklYTUNDZUFobkh4U25JN2hDRXpNMENxTEJBci9FUjlWR1lS?=
 =?utf-8?B?L3FjQU0vOTFBZTZ5My9DWUxxZ3FVQ2x2QVBzOWpCTlVLNXIveHUwWnFKV21L?=
 =?utf-8?B?QWwyUnNJVG9tOC9PZWhaK1ZNWGc4d3N5TnVna2txM1FqL0ZpMURXcGlydWxa?=
 =?utf-8?B?SGhGLzFxSFVpMkRIbTk2OUp0RzBRZlhkNHRaOGdBYXFNNVRxbmFiWjBzQ1Zn?=
 =?utf-8?B?SFhmaWFtQWlUMFdLQkxqek1NQThrYjlVcmhhdzg2NGs0VkhZSmROYnlHZENv?=
 =?utf-8?B?Vm1XQTgwb204dk91MExxb0U4QUFmaEJEWTkrdkxEdkNUMHdBcFBiV2NzQlNV?=
 =?utf-8?B?M2RyYXVvVWNVb0cyTjREOUpxU2tma0dpdGROSml1aDRnb1pHc3VLRGowZVph?=
 =?utf-8?B?dUVFR0svL1R0NUpQbFVTVkNoSDRoY0lDczdmcHFVZzZUTXl4Q3EyVit4cHd6?=
 =?utf-8?B?NGdCamowY1RQMkJvNUZGSHBYVDlwclgwZE15SXdDQUpUSXdYTTVQMjJjQWx5?=
 =?utf-8?B?R1pYZHVWcEFUSVJnYWU4TTl6VUNoWUx0M1hrc1JISkVxdXhPeU5wQmp2OFNL?=
 =?utf-8?B?dDJQam9hVEg3K0lsdzJPSzZnUUNBM1plMFdiRzhGOW1qVTZKMHM3UlU4dmx0?=
 =?utf-8?B?RWtIbWF3aFRycFZXVDVYQTZuSGdGYnJBVDlSanMvU3pJVWpDcGZmRzgraUp0?=
 =?utf-8?B?a3pJTitocmRkcFV4N29PdTBmQ2Q0RCttSEdaa2ZpOU9qYm5hWjVTaHRvUkk4?=
 =?utf-8?B?THBJMHNSN09mbGI2TE9SNk1maytTT1NqcWZZbjhkVGNCM1dNd2tMUjhEVzU0?=
 =?utf-8?B?Nngya3dQV2dlUkZxSHQ5OVVNdkVESCt0UU1pZVJDRnF4em8wbXMvSWR2R3Jj?=
 =?utf-8?B?NVh3a2VmWUV3bCtuMTc2Tm50QmQ4cCtTWkNPbXNqSWU3ajN2Yy9yVXhJSm5l?=
 =?utf-8?B?ajFtNjYzMndDMDFWaEhyYyt5dUU5T09EVFhzbFI2RDJQZk9rOHM1cjA5OFBB?=
 =?utf-8?B?NHFIbGhhM2htZkd1R0hQMm9hL25rYWdsTlBIRDQxc2JxaUxlVnJuakoyK0xo?=
 =?utf-8?B?dUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C748AD61E977147B0DA5B0797AF4C29@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9833c85-2c46-4b8a-0364-08dc7b05954c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 08:51:48.9522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RRBmFwmq+hfZ/o/O/XVQNMr1YyCu9TRmWv9PCNsI3K1c/j/b2c2/KB+d5IUDHmzIeF2YDXE2ewnoZYydyV/RxShsNXcA3BmEnruvRWwJNlahpORlCHwVzTQEo/k/XZ8E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6738

SGkgU2ltb24sDQoNCk9uIDIzLzA1LzI0IDEyOjI0IGFtLCBTaW1vbiBIb3JtYW4gd3JvdGU6DQo+
IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gV2VkLCBNYXkgMjIs
IDIwMjQgYXQgMDc6Mzg6MTdQTSArMDUzMCwgUGFydGhpYmFuIFZlZXJhc29vcmFuIHdyb3RlOg0K
Pj4gQnkgZGVmYXVsdCwgTEFOOTUwMEEgY29uZmlndXJlcyB0aGUgZXh0ZXJuYWwgTEVEcyB0byB0
aGUgYmVsb3cgZnVuY3Rpb24uDQo+PiBuU1BEX0xFRCAtPiBTcGVlZCBJbmRpY2F0b3INCj4+IG5M
TktBX0xFRCAtPiBMaW5rIGFuZCBBY3Rpdml0eSBJbmRpY2F0b3INCj4+IG5GRFhfTEVEIC0+IEZ1
bGwgRHVwbGV4IExpbmsgSW5kaWNhdG9yDQo+Pg0KPj4gQnV0LCBFVkItTEFOODY3MC1VU0IgdXNl
cyB0aGUgYmVsb3cgZXh0ZXJuYWwgTEVEcyBmdW5jdGlvbiB3aGljaCBjYW4gYmUNCj4+IGVuYWJs
ZWQgYnkgd3JpdGluZyAxIHRvIHRoZSBMRUQgU2VsZWN0IChMRURfU0VMKSBiaXQgaW4gdGhlIExB
Tjk1MDBBLg0KPj4gblNQRF9MRUQgLT4gU3BlZWQgSW5kaWNhdG9yDQo+PiBuTE5LQV9MRUQgLT4g
TGluayBJbmRpY2F0b3INCj4+IG5GRFhfTEVEIC0+IEFjdGl2aXR5IEluZGljYXRvcg0KPj4NCj4+
IFNpZ25lZC1vZmYtYnk6IFBhcnRoaWJhbiBWZWVyYXNvb3JhbiA8UGFydGhpYmFuLlZlZXJhc29v
cmFuQG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9uZXQvdXNiL3Ntc2M5NXh4
LmMgfCAxMiArKysrKysrKysrKysNCj4+ICAgZHJpdmVycy9uZXQvdXNiL3Ntc2M5NXh4LmggfCAg
MSArDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC91c2Ivc21zYzk1eHguYyBiL2RyaXZlcnMvbmV0L3VzYi9zbXNj
OTV4eC5jDQo+PiBpbmRleCBjYmVhMjQ2NjY0NzkuLjA1OTc1NDYxYmYxMCAxMDA2NDQNCj4+IC0t
LSBhL2RyaXZlcnMvbmV0L3VzYi9zbXNjOTV4eC5jDQo+PiArKysgYi9kcml2ZXJzL25ldC91c2Iv
c21zYzk1eHguYw0KPj4gQEAgLTEwMDYsNiArMTAwNiwxOCBAQCBzdGF0aWMgaW50IHNtc2M5NXh4
X3Jlc2V0KHN0cnVjdCB1c2JuZXQgKmRldikNCj4+ICAgICAgICAvKiBDb25maWd1cmUgR1BJTyBw
aW5zIGFzIExFRCBvdXRwdXRzICovDQo+PiAgICAgICAgd3JpdGVfYnVmID0gTEVEX0dQSU9fQ0ZH
X1NQRF9MRUQgfCBMRURfR1BJT19DRkdfTE5LX0xFRCB8DQo+PiAgICAgICAgICAgICAgICBMRURf
R1BJT19DRkdfRkRYX0xFRDsNCj4+ICsNCj4+ICsgICAgIC8qIFNldCBMRUQgU2VsZWN0IChMRURf
U0VMKSBiaXQgZm9yIHRoZSBleHRlcm5hbCBMRUQgcGlucyBmdW5jdGlvbmFsaXR5DQo+PiArICAg
ICAgKiBpbiB0aGUgTWljcm9jaGlwJ3MgRVZCLUxBTjg2NzAtVVNCIDEwQkFTRS1UMVMgRXRoZXJu
ZXQgZGV2aWNlIHdoaWNoDQo+PiArICAgICAgKiB1c2VzIHRoZSBiZWxvdyBMRUQgZnVuY3Rpb24u
DQo+PiArICAgICAgKiBuU1BEX0xFRCAtPiBTcGVlZCBJbmRpY2F0b3INCj4+ICsgICAgICAqIG5M
TktBX0xFRCAtPiBMaW5rIEluZGljYXRvcg0KPj4gKyAgICAgICogbkZEWF9MRUQgLT4gQWN0aXZp
dHkgSW5kaWNhdG9yDQo+PiArICAgICAgKi8NCj4+ICsgICAgIGlmIChkZXYtPnVkZXYtPmRlc2Ny
aXB0b3IuaWRWZW5kb3IgPT0gMHgxODRGICYmDQo+PiArICAgICAgICAgZGV2LT51ZGV2LT5kZXNj
cmlwdG9yLmlkUHJvZHVjdCA9PSAweDAwNTEpDQo+IA0KPiBIaSBQYXJ0aGliYW4sDQo+IA0KPiBU
aGVyZSBzZWVtcyB0byBiZSBhbiBlbmRpYW4gbWlzc21hdGNoIGhlcmUuDQo+IFRoZSB0eXBlIG9m
IC5pZFZlbmRvciBhbmQgLmlkUHJvZHVjdCBpcyBfX2xlMTYsDQo+IGJ1dCBoZXJlIHRoZXkgYXJl
IGNvbXBhcmVkIGFnYWluc3QgaG9zdCBieXRlLW9yZGVyIGludGVnZXJzLg0KU29ycnksIHNvbWVo
b3cgSSBtaXNzZWQgdG8gY2hlY2sgdGhpcy4gV2lsbCB0cnkgdG8gYXZvaWQgdGhpcyBpbiB0aGUg
DQpmdXR1cmUuIFRoYW5rcyBmb3IgbGV0dGluZyBtZSBrbm93Lg0KDQpCdXQgSSBhbSBub3QgZ29p
bmcgdG8gcHJvY2VlZCBmdXJ0aGVyIHdpdGggdGhpcyBwYXRjaCBhcyBXb29qdW5nIHBvaW50ZWQg
DQpvdXQgRUVQUk9NIGFwcHJvYWNoIGNhbiBiZSB1c2VkIGluc3RlYWQgb2YgdXBkYXRpbmcgdGhl
IGRyaXZlci4gU28gDQpwbGVhc2UgZGlzY2FyZCB0aGlzIHBhdGNoLiBCdXQgdGhlIEVFUFJPTSBh
cHByb2FjaCBtZW50aW9uZWQgYnkgV29vanVuZyANCmlzIG5lZWRlZCBhIGZpeCBpbiB0aGUgZHJp
dmVyIHRvIHdvcmsgcHJvcGVybHkuIEkgd2lsbCBzZW5kIG91dCB0aGF0IGZpeCANCnBhdGNoIHNl
cGFyYXRlbHkuIFBsZWFzZSByZXZpZXcgaXQuDQoNClRoYW5rcyBmb3IgeW91ciB1bmRlcnN0YW5k
aW5nLg0KDQpCZXN0IHJlZ2FyZHMsDQpQYXJ0aGliYW4gVg0KPiANCj4gRmxhZ2dlZCBieSBTcGFy
c2UuDQo+IA0KPj4gKyAgICAgICAgICAgICB3cml0ZV9idWYgfD0gTEVEX0dQSU9fQ0ZHX0xFRF9T
RUw7DQo+PiArDQo+PiAgICAgICAgcmV0ID0gc21zYzk1eHhfd3JpdGVfcmVnKGRldiwgTEVEX0dQ
SU9fQ0ZHLCB3cml0ZV9idWYpOw0KPj4gICAgICAgIGlmIChyZXQgPCAwKQ0KPj4gICAgICAgICAg
ICAgICAgcmV0dXJuIHJldDsNCj4gDQo+IC4uLg0KPiANCj4gLS0NCj4gcHctYm90OiBjaGFuZ2Vz
LXJlcXVlc3RlZA0KPiANCg0K

