Return-Path: <netdev+bounces-100818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F1F8FC223
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 05:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E34301C2101E
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 03:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4772C42AB5;
	Wed,  5 Jun 2024 03:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="aJ9OFA20";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UdAOdlb1"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031C763B
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 03:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717557547; cv=fail; b=tiXj/aXTgNgRky9OOEzhXaDiDkG4DC038TI2gbbiQDrOg+PCbwJtG2f9iLnNG6KzRKAmalE406jXKp6sG4/GJtSZb4iKcqDaPVDFOChnx4pjOzRPibdo1u43Zj1rwSf31S003h0z9jIJ6r5noDSAceKGO14/tWhGJor6IKINAuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717557547; c=relaxed/simple;
	bh=WJghl7577ydkIea+qeP5NYuXZIz9LIRtXGkq9b3uHd8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A0bVlbYi3oHcySDljWt2imc6rT2/WioQrRj2hQVkHp8x8aSsPr3gIyg6kfv9E7PZAhJ49Her5+97eYuvDTYptJz2RILmnhk8kM9FqHZ/noSOKxTq2tCjFPNVwb4IiFo9DPQ7J9oqx9OEhnDIOhls19bxf1+nEc9PA7jWwZc5HIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=aJ9OFA20; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UdAOdlb1; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1717557544; x=1749093544;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WJghl7577ydkIea+qeP5NYuXZIz9LIRtXGkq9b3uHd8=;
  b=aJ9OFA20eW/A+lvSlhtbUYYfAITN9dyKxV1Nm6FgXiPakm5NFvpKVqKA
   cDUE1XmIlfmx0diBFhr9ECs7PJppOV0C27yaVSPRCYeGx5kDy/bOmD6F1
   cwLGv6kN15rRsc94/ilb/c5KNI8a/FpP5T2haBYUz5RXGIxl0cfl3GS7B
   snxh93pX9ylF7qhaQE307cUk2mc+CIvxg8lY28fB2r+BIwr+Tj6J0/wlV
   Kn7KLozmwhs752FTZKNJCop0y0lmxLCuLe7eeYiKFHAEGbWcMUE8abBQV
   PCumXJcFAbQCZwceX9cOFfh5Soob9hRFjxKgdooBPRGNXne0E/ZqQm5Rm
   w==;
X-CSE-ConnectionGUID: PXHb13qlQ/eQpOSsv7ySPA==
X-CSE-MsgGUID: O2YhY6WvQG+XiY8uoYhraA==
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="194390693"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jun 2024 20:19:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 4 Jun 2024 20:19:01 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 4 Jun 2024 20:19:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJQ/sSUrRXhTMfAKYSfy28C+Gk5fOw+CAL3HEKxDrJPPLkTxnLOsi9cinQ5cSCUTrq+WIJ0mNLZJRxGn9RvMB5qME0AItwkadBD9fqJduDglkX+vxZMJ6sltOynoGF+o3jNQVaB9CjE0R4ym8i4BwdvEjC/B0ps4WbxB6aIshcFYOLhUfvz7ls9NxSkXQ/xJ6Z38TBYgqTIU/JsrDQmtlJmw4EcF9AUXnSe+MF1DfKJE9Q+ihLN3sx7Fq2DcJuw+XhxU57H8JeaG0Ionv+nzm69zSuaIQWqeafxvsc0zogWSHNFFyfekpj04VLZiIB5OUxJNUDuyloXjUdRqF+r0hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJghl7577ydkIea+qeP5NYuXZIz9LIRtXGkq9b3uHd8=;
 b=lwUbvQ3CPZCP39/R3UFRhnoU0BElcKI6+ktXb7h5bJlzixmLFZBCJP3PsDlHaoB7VmIYIMzVwxpExTNkB32joe+pEUKGVvrP/zD7H4y0N2NORifOn0SY7xfauTg3JCL3jYHDCkJHImuScAn6B9oGO17TEeRYiKgvq04hsGLLLwzbIHrjTadrIIVg+kbPBx6fiTa0X7d+qzkwdjtpuCEY6iTbvFaUMN83ciVBuwUIP4FEoaqggHRDkvtmcv6fbnReMaStMpWEu3ObcezT1J7T7g0bR83EH8rRAbMVtXAlOlq1iZgSKPi+Han6tVXucP2PU+ucNkY9DwXGvn/BnxxpEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJghl7577ydkIea+qeP5NYuXZIz9LIRtXGkq9b3uHd8=;
 b=UdAOdlb1bnoBlLuwpzd4v8ZGRXK/DlfgP0I5jr7aF48gyYzMbar8vXgC8xJQfHZD+z4O3/OvGs72rBw7mqpgL2frW67E2uXPZXwuYUmEpftSq1aeq17Vi+BRBuJgMznY6J5Ns75EVoO20drlgx9mRKsjpKvbneS61+y6lal9kAxJNja0PTRl8UsQegTMaHLdkR6pXE3RT3ntsfe2YAdCna1dc4Z5OrjnWBYk+l9VYivO8MxZ87VuigbPuOCoPwP6L8ozcv8RcFjXtIQweuU8ks/TcsafKXTQroGmcbCbkkak/+8B4CcLXdevOKBxFTdMzwKFLGZTP1QIyVf+ZKtT/w==
Received: from SA3PR11MB8047.namprd11.prod.outlook.com (2603:10b6:806:2fc::22)
 by MN0PR11MB6034.namprd11.prod.outlook.com (2603:10b6:208:375::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Wed, 5 Jun
 2024 03:18:57 +0000
Received: from SA3PR11MB8047.namprd11.prod.outlook.com
 ([fe80::a585:a441:db24:b547]) by SA3PR11MB8047.namprd11.prod.outlook.com
 ([fe80::a585:a441:db24:b547%3]) with mapi id 15.20.7633.018; Wed, 5 Jun 2024
 03:18:57 +0000
From: <Arun.Ramadoss@microchip.com>
To: <enguerrand.de-ribaucourt@savoirfairelinux.com>, <netdev@vger.kernel.org>
CC: <linux@armlinux.org.uk>, <horms@kernel.org>, <Tristram.Ha@microchip.com>,
	<Woojung.Huh@microchip.com>, <hkallweit1@gmail.com>,
	<UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>
Subject: Re: [PATCH net v5 3/4] net: dsa: microchip: use collision based back
 pressure mode
Thread-Topic: [PATCH net v5 3/4] net: dsa: microchip: use collision based back
 pressure mode
Thread-Index: AQHatmD6yPpwDNY41kWStWLKAL6RI7G4ggcA
Date: Wed, 5 Jun 2024 03:18:57 +0000
Message-ID: <53b6575f6d9ffd167f590a5709e700237bd91811.camel@microchip.com>
References: <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
	 <20240604092304.314636-4-enguerrand.de-ribaucourt@savoirfairelinux.com>
In-Reply-To: <20240604092304.314636-4-enguerrand.de-ribaucourt@savoirfairelinux.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR11MB8047:EE_|MN0PR11MB6034:EE_
x-ms-office365-filtering-correlation-id: 53efabe7-c3e7-4c0f-1138-08dc850e3cd1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?NWVCQmlOOWhOSkRUa2NvVWdhL0R4MklQa3l4RDNEd1RjdVlnYzVaQ1pBSC9l?=
 =?utf-8?B?WTJEQUNaV0NaeHdkTDBaRFVjTDdTUnA5MjkrRDliemt1QVpoTytFR0VpbzJK?=
 =?utf-8?B?eGlkem4vK2l3VWVMNUVEb25UZXJoaG9pTGVDOXJCZUNob29uT1pOeFM1SEhW?=
 =?utf-8?B?cGJmd09WWld5KzNzYU9GZWtmNFA4TVFyRDc0Z0hYbGhpejM2cnMxaTNNNndw?=
 =?utf-8?B?ZnVUdDREL3llZi9jTUN3eEJ2OG1iMU9VaDhJM1ZvSVBLNlF6MVFEM29VaTFm?=
 =?utf-8?B?T3Nta2Q5aE9sZEFpNEo0UDJhVWVZUnhheEpLRjJhaXhiMnYzUGIzZm1IZ2FM?=
 =?utf-8?B?SUJkVGtZdUZDUWFMOW9BemQrUEpnb0dxUU1XV3JQL3c4VHhHWGpLQWQ1T0cw?=
 =?utf-8?B?TEYvUlU4S3IyVzl0QXNpT3pkSmhHL25pb1Q1ckVpd3FRQUhhMFkzS1VmSXpQ?=
 =?utf-8?B?RWdaR095alJKSkcxUHJlalhZbEJYMUU3Uy9IM3l1aU9PdXZkQmQxR3BaNzQy?=
 =?utf-8?B?em5UNzhkYTE5UEoxZm13cUlGZzlmSUNkLzNFTENDdjBpdW94SlF4SkRaVDZq?=
 =?utf-8?B?RXBTV3RObDVIOTF2WUR2YjNpbEUzTVdIMDdKZDJnNG1IMmgrcENzSEZRNjVv?=
 =?utf-8?B?SmNZM1FmdkNoUnF4ZlloK2tIMVMrUXZFWm5xU0xkQjluZ1daWnVZamtmRVcx?=
 =?utf-8?B?cVpZUXpQNUlZd3BpckdhMDJhclJnYVkwSW1IeVFVaXBuUG1wNW4rT25nbFFI?=
 =?utf-8?B?eGgxeU9SV0k3ZFQ5NTVzMUZDTHRYYlE1c1g3MFltZnhEb1B5YW9qYWYxNlJs?=
 =?utf-8?B?c081Vlc2TVBseS9NOUFRays5bWNxcXU3c3BYaFY4bHdNeERHRFdNUmpkQTFy?=
 =?utf-8?B?NEtuWVRlNkJ5QS9BQ20xbWxPblBuTUZpZkN4WlpML3RtYlN1blpsQ1pOSGtu?=
 =?utf-8?B?eGZBbDlXSTBRR3RNU1lPamZNcUF0WjJPbXdZZ2llZ3M2ZlE0WlRpSldid21L?=
 =?utf-8?B?OUVTSU5QeEs1VmxEUUNqRmtMVkJsUnJlTGxCQmZhaEZxbHYwUnY0QmZEaERz?=
 =?utf-8?B?RDh0RFhTRmJPc2dSQ29vcEdDY2hDOGttZWRSTnhhZ0ZJenVIYkkzWFdLUGFU?=
 =?utf-8?B?UTlMZEswQlBxdEVaSU11QkgyMHI5U3RWd1lreGRLZ3hNcjVmVDl0dTNSWC8x?=
 =?utf-8?B?ZlZpM3VLam1HMWtkWVZVbGdWQjZtb01tNzBjdldCU2llUXJ5cG5QSzFZdFNI?=
 =?utf-8?B?ekY3RUNhQ3FyeFE3WHdsSDkrYXJURU90QVRTMC9RNHVwRml2ai9XbzdDVW9P?=
 =?utf-8?B?cWVCM3RBNkQvTjlKT3R1ZW9SZHBSdjlqS1JzblFVd0pWb1dWTGpRUGhZT3By?=
 =?utf-8?B?eVhEZnRwSWNsMmd5aHlydjhsRVphdXJvZDZKSUFFU2FrS3F2bngxQWM2am5p?=
 =?utf-8?B?VjlQYUpMNE92MnI3M01wekordzBEY2IwQlJpZlRTaGoyUnJiWmt5Q29STE9y?=
 =?utf-8?B?L2F0eEEvWDhZT0cvZzk1TDB0M0svN1k0akRUOS9CRTJpVFhNb3FscVpwY0Iy?=
 =?utf-8?B?TU1JRTRIV25WSFdIT25VWUtZdHBSeGtQY3phYmdKSzlNOVJEZXJZUUlETk85?=
 =?utf-8?B?M0dFUjZRWDNJdDBHS3QzTnZneGZlaXJoc05XTHJTdUJYRVBzMC9XdVpacFE3?=
 =?utf-8?B?aEFOSldFUVVYTnlCOE0zTlhCait0d1FLOS9YT2w5SktpQWdhNTMrWmRKQnlX?=
 =?utf-8?B?NWpPaG10Z2tvZ0ZJaWoxZ0tBVnRpK013aE5tUEVBSW5Za201NDlwclAzRGZG?=
 =?utf-8?Q?6pHhePfG6kkHT2M333u3m5ksVUN3hnl6eW6ZA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8047.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3VUZmZOd1VoYUxYSjgxU1NMSkthejRxMWNMRTM0R28xcUc0NjRST3ZlUlVD?=
 =?utf-8?B?V1ZTMVRkUzRLaWRKbStucTFFODBMTUliWnBWamZ3amVVL01XM2x0Nm9Oak1l?=
 =?utf-8?B?b3VLbUZHZU5jMnowcTNHV216WFN3V20rZHZYS1ZjM2ltVmx2NHU5cC9rd0tp?=
 =?utf-8?B?VUlWZDJjcXBmeUh0d1JaOExwM3ZNV1dPOHdyY24waWpDMkhEYmErY3hrU292?=
 =?utf-8?B?ODVoR0RWd1FSSnhHcmRkMi8wUi9FVHhDaEkwRlBId1A0ZktaQzhBWFAyQXp4?=
 =?utf-8?B?b2grSis4b3RYcWY0Vk1uNXZqRytQUEI5L0UzN1NNSWlJZlpCU3JQYlZ0ZkRt?=
 =?utf-8?B?dys2TC9ZRGUwY3pkSDNsSjBlNWNCdzBuSWx4UHdZVnhhU3ZoaCtGd2NaeThD?=
 =?utf-8?B?U2pnUXZZWGQ1OFU0RUUwRmJPQmZDV0FwMlhJNVFYajBzUk5NM1N1eG5UWlF1?=
 =?utf-8?B?WGN4M1dIY0ZoN3ZETE9NNm9BbDJxbjVPVXVBbUsyeStMZ0JReUVMK0h6Q1VS?=
 =?utf-8?B?OGpyZFVkUEVvMlhKU21zZ1l3SFlKd0VxL1grdzFtblR3TDcycmMwWktrSnpq?=
 =?utf-8?B?cmpBZjdDNitENDI2cDNiK1FUT21uN2tPbWEwcDNXc0VCSlp2MTdSbkNsZWxY?=
 =?utf-8?B?L2VWaWE4S3pwdm9mVDRsaHNqVkdBU3RqMjJ6bWp0bUVwUUtCZUk1c0N1Z0hK?=
 =?utf-8?B?NnFmdFRjR1ZNUE1qNUZadXplQ0RYZ3d6VElTbjJKOEl5YUN4dmcyRUtBc3J3?=
 =?utf-8?B?WklGaU0rQ2JXY2VScG9vZDFjQnNsUTdnMkFkbjNYU1BvQXZUNGJxVTdWZkUw?=
 =?utf-8?B?NHJIR1JiSGVFTUp3VlhOd2dOOVdWS2NJMkJFU09rdWFuc1lZN1poUjlEaTBF?=
 =?utf-8?B?L0p6Q1NxbFE2N1FCc3R3aFJvNHAvTm9HNWU2eDJ0cFJ2T2huaTF4WGU1RmZI?=
 =?utf-8?B?d0x1Sk4wRHRxRjZucmcycEZicFhtdDVWM2pkc1hCcDJpNmpzQzFSZHUxamFm?=
 =?utf-8?B?L2thb2VSUWRiTXEzTmp1WVFWQXNwK3lXc2RRWEdsWEpkRnVVUnpKczBnb3Zn?=
 =?utf-8?B?NS8zQkE3R0pFdVYwamZVb3NWaEIyNExmT3F6YU5FeVU3NEpqZnhVa244Q1RO?=
 =?utf-8?B?VS9GbS9tTU9WTDJUSmRDNGVvNG9CZTE5N09palc3ZE5aU1FiVCt6cG53dDVL?=
 =?utf-8?B?T08xZWhWdFlPY2pBRFZ3eDJwVitkaDNnQmtBak1mTngrTGlqbDdlS3pWMmJh?=
 =?utf-8?B?YWZWRnpSekdEN25uWktnalpRWEFSOUtaUnloUVJ5aEJGM0FCZTNJNWRyc0lx?=
 =?utf-8?B?bDRlcWFLNjJZU3dPSWVnbXdKWWxnWkdUTUdVdGVtZ3p3V3FaRDFvcUR0clJ0?=
 =?utf-8?B?YzVVMGcwdmhLWGVqZGFjeWVDSTNScHFMNTB4MHNnTW5nR2lxaGk0Ymk1UnVY?=
 =?utf-8?B?OXFMTlRZNStvUE52VC90blhyT0x5MDgva2tsQTBLM3hoNzRWN05Rd0FxL3px?=
 =?utf-8?B?YnJrSXB4VzZzNk5RR1Flb1RFNUxXa2JmVTV4Vkg3MU8zNVRjWndaUXV4ODhh?=
 =?utf-8?B?bWxBaU04N0RFT0k5L2FPeTBaQitHeGx4NlRNZ2VjbUtSVlRJeHcyWXRQazdN?=
 =?utf-8?B?K0l4RERmY1FETlh1ODFOTGpDV2tSTFo2dEVvRFBrTGVsSGhKenQwdGd5N1cx?=
 =?utf-8?B?Q0tUV0txSHhydkdxU2xReFR6ZGhEUis3bDY2dU5rVDBYMi83dXFjcFVuajFC?=
 =?utf-8?B?KzFHZ0gyd1FBN0ZielUwMmZ4TW1wUGlVZkRDVmN4UzdFTi9DOUFGUi9jQUox?=
 =?utf-8?B?RjJ0ZWdybm50a3VSOU0vRE1WTVJkMHJOZFhNZURaeWFJZWYrV3B1RkxpUW9I?=
 =?utf-8?B?dndXY1ZHTkNrNkt5bWhTQUwwWng5QVR0SzNnNDN1Nys2bzIxMEI0cTZqeFNX?=
 =?utf-8?B?aTJsQ3QwWTg3YmlkTmcwQmU4d09DajBEV3BRa2VBWGhRcE5aV3MwRGhaTnpQ?=
 =?utf-8?B?QUhpVG5BVFcrVFQ5aTdxaDZrbGJMTTc5dnRnUExqMXRPSzdUSmlwbWRpci93?=
 =?utf-8?B?SmlKZmJJRHhQVWxCcHAwQnNEb1diTE55MVY0Q1orQnNZa0lKR0JpTklCamcw?=
 =?utf-8?B?aGkySkNKMW9UVk4wTWVkbWFlK0FJeE1FbFlxUGJBbkpXWmlqa0dRUmpQNEN5?=
 =?utf-8?B?NVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2B70534C5164B4AA11017C37B84CE6F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8047.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53efabe7-c3e7-4c0f-1138-08dc850e3cd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 03:18:57.5867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EkdxNxmWiqVTYsUTqsm0s3GPLRKQEu3pdRQ9Du76QcoES3ctJ/+oufBCjRLaR72tuaXn4TRmXQDvblD/2cxN46zIuaOYlB8Olj0Q4MP0xgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6034

T24gVHVlLCAyMDI0LTA2LTA0IGF0IDA5OjIzICswMDAwLCBFbmd1ZXJyYW5kIGRlIFJpYmF1Y291
cnQgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4g
RXJyYXRhIERTODAwMDA3NTggc3RhdGVzIHRoYXQgY2FycmllciBzZW5zZSBiYWNrIHByZXNzdXJl
IG1vZGUgY2FuDQo+IGNhdXNlDQo+IGxpbmsgZG93biBpc3N1ZXMgaW4gMTAwQkFTRS1UWCBoYWxm
IGR1cGxleCBtb2RlLiBUaGUgZGF0YXNoZWV0IGFsc28NCj4gcmVjb21tZW5kcyB0byBhbHdheXMg
dXNlIHRoZSBjb2xsaXNpb24gYmFzZWQgYmFjayBwcmVzc3VyZSBtb2RlLg0KPiANCj4gRml4ZXM6
IGI5ODdlOThlNTBhYiAoImRzYTogYWRkIERTQSBzd2l0Y2ggZHJpdmVyIGZvciBNaWNyb2NoaXAN
Cj4gS1NaOTQ3NyIpDQo+IFNpZ25lZC1vZmYtYnk6IEVuZ3VlcnJhbmQgZGUgUmliYXVjb3VydCA8
DQo+IGVuZ3VlcnJhbmQuZGUtcmliYXVjb3VydEBzYXZvaXJmYWlyZWxpbnV4LmNvbT4NCg0KQWNr
ZWQtYnk6IEFydW4gUmFtYWRvc3MgPGFydW4ucmFtYWRvc3NAbWljcm9jaGlwLmNvbT4NCg0K

