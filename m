Return-Path: <netdev+bounces-107526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C1F91B518
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 04:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 884211F2223E
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 02:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5270312B72;
	Fri, 28 Jun 2024 02:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="IzX5LRLH";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="etUnPb7O"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C2F1862C;
	Fri, 28 Jun 2024 02:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719541905; cv=fail; b=ew0yATf/mrs2VIUH0wKebixvnGBIFSU/8UmwEm0LobWhVz34TMADGyUjz0zqylPSYawZy3QUZ2Hs4GpKMHI02r4KPmmXh7TfcBwuXm91TYZAFgEEm+NvG3rvKbCjc6KdxwzXlRpB7medqDGjOJ37hnKmAg9SErGJskeK5UEGVAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719541905; c=relaxed/simple;
	bh=Tu/ddnp37qDA7r03AofrAB5mYxC+SSY6Z4j6S0l+HEg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gdsZrVzTFIzCQTgQZljGNU8L+UERdc6tSGW8tNxAgRXBwAQnHCoYLDkLZqRJdt9kqDFGNDLAb9icvCzUk9ue3kzbrlaR2hI8EiC415NJJ0adm8C1LanoV1SNUhZY6FAsWMUnIN4afqUZbOSficq/i5ozoYs04nVOploVnqrau+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=IzX5LRLH; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=etUnPb7O; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1719541902; x=1751077902;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Tu/ddnp37qDA7r03AofrAB5mYxC+SSY6Z4j6S0l+HEg=;
  b=IzX5LRLHPPMHShNknWml80a1xobZY2eSlBz4SNWwj4y7ltU8/eEjdol8
   m+D8L3s+haGvtVtdpBrPUx0ZQsZ2erZg5d3Eh9IE4f1JgfBYw4WPSp0Iq
   6KYxMje8j4TWb4sN+Y3UwVy9rVSWxHqvQovTqCpm4257C5tdwcHDLe8BZ
   bp6EpKMfIOAQ0ni83OE6oNH9dpY4zpkUzCoqIR13O3T/amUdCzQZ/Qace
   GeKiFW6RNF8Nx2TldhelIR495m3vUgdfNlCz2ABBPqviOTduP8RBUzfb7
   CW7lvm14r2japQSRh9ADGPBo56aYQlR1evHcOnq5RNEuuVBcJkKzbZKJY
   g==;
X-CSE-ConnectionGUID: ys2ocuATS1aTmHL8QuJnqA==
X-CSE-MsgGUID: TIRuwz6zSUqNeSE0t+rpBQ==
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="29246956"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jun 2024 19:31:40 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 27 Jun 2024 19:31:30 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 27 Jun 2024 19:31:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQt6oe+IsyBXIAy4uxtbv3HfN2JBfgYfuQPlvr18tHe8iKsIMc2Aln8xzsikOL1IpVsew0Org5aoOB0jcWG3OU1/6X/JhQdw1bfqr4q4k/aTe7GBJmRsE3snJqSpYRbi5QIQ93CNVxh1js7jtbcHxLWQZdE+DI9gMc7xd+eKA8h6T4vZ49lPdL/cJx1P+T0dryP5m3aH6RNPMJeHouui8Ssjs7eoPnA+SCkrwVlxN5EV320oCRb0vjLR3shxSAiKXU6xecQjs4EGZfYLtTc9KzPPAX5WehL3lTNaj5W45ugMaYsNoxMKCAHV+D4pd8OPSUe6kfYdZswOaDfp6YBeOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tu/ddnp37qDA7r03AofrAB5mYxC+SSY6Z4j6S0l+HEg=;
 b=mWn10vBweWYKow9FUcg1R/DpatdJ3uINMldl4vAmRb4m+RL4jPHzzavgKGpIPMRFYWcIkhNPoOEGuPE4yWNF5Q/39Mb/QeStPqjtmgHx45kJPl9t0gZteLQdVh0xWEBuX3NLio1IOhYbTC+/1sA0H4PTidHRaYoMYqxFvM8sayYbg6NukfZyT+pkiQbTDu/zdc/7wlLo98hpFsWzHMrsQqCx8UR1DzrrhwfDlMUjYgrCmMpdWKMuxWVUtRe96eygS2IVxZIAUZssjFfIwlIq4kWqdfTwAgjVP/KmwNBTZVz37bAIpHhP0TkKqWEYCa5ZuidsIVPrptsd/sAvr01DGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tu/ddnp37qDA7r03AofrAB5mYxC+SSY6Z4j6S0l+HEg=;
 b=etUnPb7OMCJizAf7Qmsp4Qhk5Y2fIQetkuGSkyBJR4kdvorFcItm4pSha1Wz1ocqIsH3584md35yrFO9srXzA/+4u+kLxCnRa/8ghXtZDXy97vRv1B7uxKH+0oKZMkHe/+FMlIjavOyFmXUHrlQhU5apBuPsSQiq7UgtovkJWjQ3CMo/4ssUJgV5glbskHrHd9teaeSxrdrK1Yj1Lb+fUHXjaI+0mlvFplby20bJBkIEf/MDvhe0+PesykynrVRKTMqrofu37Olo/vpdk/lh3I2YTBXt8d09KWQRIEgGTtScVErw3XQFmUh/OGCGcUy9u8gPewodAdzOGNbSSjpNjw==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by IA0PR11MB7331.namprd11.prod.outlook.com (2603:10b6:208:435::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 02:31:25 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c%3]) with mapi id 15.20.7698.033; Fri, 28 Jun 2024
 02:31:25 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>
CC: <l.stach@pengutronix.de>, <kernel@pengutronix.de>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next v1 1/3] net: dsa: microchip: lan9372: add
 100BaseTX PHY support
Thread-Topic: [PATCH net-next v1 1/3] net: dsa: microchip: lan9372: add
 100BaseTX PHY support
Thread-Index: AQHayI8WYyLFR5L4FE63BWKWAC4lcLHcdgyA
Date: Fri, 28 Jun 2024 02:31:25 +0000
Message-ID: <bbdde2f70747c9f9c973d46e1d744537dc5969ee.camel@microchip.com>
References: <20240627123911.227480-1-o.rempel@pengutronix.de>
	 <20240627123911.227480-2-o.rempel@pengutronix.de>
In-Reply-To: <20240627123911.227480-2-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|IA0PR11MB7331:EE_
x-ms-office365-filtering-correlation-id: 7dd795b5-e823-4a62-097b-08dc971a6827
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?c0tpR1ZDNHJmN2RBa3JBS3MwYXNTaXlVRCtQSzJGZVpkZWpLWVd0TUxZR3VY?=
 =?utf-8?B?dE5xMFU1eDNqdWR4blF2dDE3NEZmb0FvdGFrNFh0NDdkZlN3OWxwcU80RjZR?=
 =?utf-8?B?N2tKZ3RkcldOQXU3V1dwY3dUQnJtSHNpUkgxcEVHUmJOYzc2N3hPQ0RjeVov?=
 =?utf-8?B?Mm1BWlZ2SGdkWmtGNllyYjBSV1pWOVBHU2dlVm1JUlFYR3JVZzVqWnl0R0Nj?=
 =?utf-8?B?UldRR3pRL09wTUwvUGdFKytBVXpXNUN5VnBoQXdFcWcwd1pVNmdTUm1ab0lj?=
 =?utf-8?B?ajhnc2tUSGgvUVBMMnkwcWtndjVuUE1aeEk5TmlCTWpvYlRWQlZQVmI3Sk16?=
 =?utf-8?B?NEQ3QWpteldHR3BLdzhsQ0hKUlJNRm16Z2p1T3M5Snl5dzdaa0cxWTU2QzZl?=
 =?utf-8?B?a25DaFdoM3lxOGtnQVVvZUNkQUthK1FIayt0c2pJU1dIdm5vdDlENzVZSGpF?=
 =?utf-8?B?N1I3bFhWZkNmbTRNTTRqbHVsU3lMQkN3N1l1WnUxazJYVENoZzdtNUNxNUFT?=
 =?utf-8?B?SW1VUlNKYW11RFhtcTBxTmNCeUVsYWF3RFpWZ1gzcjZ5aWVTU2lzNkt4UG83?=
 =?utf-8?B?TkN2NS9UMG1iOERhcHBBZzFxVVRvWEU2QURlVnE4TkNScVVrZldEeHBpNmo3?=
 =?utf-8?B?Vlo4SGtaOGl6bCs3YWVsRUFmWE1GRjlwK3kzbGNFTG5ad3liQktzMUtvZ2hE?=
 =?utf-8?B?QWVheVBpaVFib1k2aWtCemE3MU5rNWdGOGRkd0FoblhBSURTSllqUFJxS0lK?=
 =?utf-8?B?RW9KZzVKZzI1Sko1MHhFNGNFdnhxYmNlclZES2Q1VWwvN0s0a05VaXNrYTZ1?=
 =?utf-8?B?OE5ueXVXV1E0VWZsdkVKc2dVYkg4TnpxNWMwOXlMUi82V2dacW9nRVRLTFFm?=
 =?utf-8?B?MVNZYUx3L0FJTmwxVFJMZmNpWWY0MVhXN0t2NTcycXVxTnpCRytjeGZXQmlY?=
 =?utf-8?B?RFNsSGhxU3VURFdhTlRvdGtNMkNxNkRlbU9GU0hFZ25kd0tnSEN5MVZLRW4w?=
 =?utf-8?B?U3VQVUxKSmhnelAyR1c3aVAzZkowTlVUWFpEOURBdkJMaUZxRUdXd3l6Mngr?=
 =?utf-8?B?YjJIZDA5Kys2VVdWZDN6MGpkSGxvSW05WnpONTk1ZmNVbzZYTjV5ZEtwZm5a?=
 =?utf-8?B?b2FlVE1wTU5GOFV4Y3VkS1pRd2FncU1OS216QUVJc1hkY2VKbmRJVWc1elVh?=
 =?utf-8?B?ZDBMekw3dlYySElqWmI2SEw0MmNtbmdDNEJDZG9JcW4rem1nMUhYMVpBL0V3?=
 =?utf-8?B?U3JTU0hWd1AwNnJiaVdqUHdHa1RPNjZKVFNVT05SKys4ZVIrd0JVR09rOGRE?=
 =?utf-8?B?OUREUzdzRENPakxYL1RiS0VScjJkQW9YN09OSHh0Q0NURVZKUllwUDhTNUZB?=
 =?utf-8?B?QmdaV3BiSWRuSm5INndGYVp1cTFCcFZ4VlFDcTk5YXRieGJCaHhuZy8zZWhj?=
 =?utf-8?B?MDhQVGZ6VmNoNTdONnpWREZCSlF5ZHd6RVdIbzZmNE5RZHZacWl4d1ZtTzlh?=
 =?utf-8?B?aVhIYzJjeHo3WHU3a2I3Q0RESllDVkp6QUhDNW9Kd3h4blNXUk1naTVaajl4?=
 =?utf-8?B?VUh3UldDTlVHREhGNVczT2V6NmZ1VVRZRncxZnBIckhPN29FSEJPQTN0Rmh0?=
 =?utf-8?B?UzdhbHZpaDYwS0FhcDhLTWgwZjVsNDFqZk9kRHA3UzMyVlRPT0lSVmtVbnJk?=
 =?utf-8?B?QkRSdDlqMlVsaUdid3Y4dWc5THhMT1lZV0pOQjVJV2JuRXRLTkpwZXZ4R3d3?=
 =?utf-8?B?aWlWKzIvNXlvRjBUTnlETkUyaDdZQ3FtR0ozVTdqRFBIVjNjcm9vejJoQ1pO?=
 =?utf-8?B?VXB5THJQSU5SQ1N2ZHRuY1hZQzNrcmI2WHVVV3FVYWVjQUZMTHRVeVdUR0E1?=
 =?utf-8?B?V0V2cERDSllvb1VpY25tS3VFdFF2anRWNC9lb24ybzZsd3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0dCWFczOFJSQWN3LzEzQVYzQTNuR0VhNlpKRG14NHRJQ21lWUx6K1BhRFdE?=
 =?utf-8?B?dlkveElUNWxCN3V3S0luK3R1T2RsUWRHRTZnOGNhSnBlVjk1ZGIzZDVuaFBT?=
 =?utf-8?B?ZHFvcTFNS0tWbE9rai9LRkZJS0ZwVVBZa012djhsNml2TlU3ZWR2aWVFd1lJ?=
 =?utf-8?B?S1BPWWcrSjRHQVluU2x2aEl6U1NPV2xsZFlkcGsrcEFzeU1iOHRqYXBsUzZR?=
 =?utf-8?B?RlFqVGlYV3VraU1kT3NWSENwWk4zZmRzUE5nLzBQOXNtekpiWUZSWm00Mm5R?=
 =?utf-8?B?dTRhd2wxZTkwUXgwejZ1bWJORmN6TnFFT3RPV3RKdTc1dmdlRGtTTkkxVUUv?=
 =?utf-8?B?WXplQWxYRHN0T3V3UXBTa0FnQzNUeXdPcjg4Z3ZBb011d0QyWXo3T2VwTkxN?=
 =?utf-8?B?RlAwYjJOWk1yd25qMjVoTXJOVHlPYVBSb2pkT3hKWUp4R0R0SjhyM3g4UXZN?=
 =?utf-8?B?ZUhkRXNEcjJ5YVhrNnNPcTN3eEdreFZxWWNvTTZvcHREang2WUtzYzZrUHUv?=
 =?utf-8?B?Q2UzRkFUNkhZSjUxUmFGL0dBUlVJWjVtSDBHc0Z1TExlb2x0Z3F0MmtLS21v?=
 =?utf-8?B?K3k2TFhnSFUwQjg5bTNTNEZjZTVYSEsxc0lBVk4wTkVtUTR1ZFVmb1VPZXQ5?=
 =?utf-8?B?U1ozcG42Z0tsTmhkNVM0WE1jd0VJbTkxUHk0OVRkTnBXUlJmN05KZHZVYUVH?=
 =?utf-8?B?bzlBL1dna2RwOS9SVjVoaTJzeFpqY05oOVJ6d3NyUmVDVXBqTFR6TXpvSkox?=
 =?utf-8?B?U2RXVUVKNzZOQ1dGQTl6ZkRMdWZGWHFLMEhXSEtzTC9oclhzc0ZuU01VRE05?=
 =?utf-8?B?RElYbGRnamN4V3NWVTBxRFVMWHFJQ2NnTVBreUhQdFQ3b3kvT1BOQTM2Slg4?=
 =?utf-8?B?RVk4Z2xEaG4vOE5HVEVHY2Y0UjFXbmU3eUYwaE9SaXFINHdLaWlUSzhpQ0FT?=
 =?utf-8?B?dVFrN0FhVnlOVng3cUFnZG9QNnVKVm82NDQvOWtVU2dJQ3lrUlVndzRUSVlF?=
 =?utf-8?B?Y1JuTkZyU01TZzZXTHJZT0pkY3pRc3dHZURTSEZVLzY2U0JFc2RwVU9MTGxZ?=
 =?utf-8?B?Q1I2VFc2QnE1M0FCUXM0cCtVZjlkNHhMMFJ5VWREem5oZjh6SWJaTkpGbGhO?=
 =?utf-8?B?Si9MNXFYbWZyTDFMUnUwL0pXeE44VldMcC84TUdNWGVuV1dqU0kwVW5LcEZl?=
 =?utf-8?B?SXhzRDRqUzJQODQxK1NHK2pwNTdVZlpwdytoV05NV1BoY0NsR3RjTWgycktH?=
 =?utf-8?B?OVJZbmRkUnJ2K0pSSHJQTVhtQ2Q0dTVHSWc5VUJKZkhvSVI2Y2RPQXdCMVRi?=
 =?utf-8?B?bitoTFZlb0RSV3hYMmpHRmhHSkk1VUJPZG1reDdNV09xVGxoejV0cHdYN3V6?=
 =?utf-8?B?b0NBWm50V3NaMXZFdTVvM2l1S21WakwycU1rbnhXelQzbkhvbnJWcXBKQ3Zl?=
 =?utf-8?B?b210N2xQbmM0bWhUcU5tOVgxYjBLK1ZESnFSU25aN0Rnb1gra0JPcWxFVnFD?=
 =?utf-8?B?OFZWd2J3VXhCeFVhNExWc05oaitEancxcmRDZmhSbWtyc0sycXVFbE9LVlQ0?=
 =?utf-8?B?UzJZZTBkWnhNODJZTWcwVHRmZ0RtM3ZudFlybTdzZVZQRm5uRThBbnpwNWZC?=
 =?utf-8?B?L1FCOGd6TFdQeXBMc0tISEdqYXg4NGsxelB4S2k1T3pqNW5ZdHl1RStoZ1BV?=
 =?utf-8?B?QUJUMXhnVGcrMFZHTEgxOVJCRitnSWpRRjQ3S0FJdkRGdUxSaTJjdEFtWlhS?=
 =?utf-8?B?QzQvaEEvcDk1TmRKVnpZdi95Nm1vK3I2UWFheDBoOGlQV3NHM1R3dHE4RmVI?=
 =?utf-8?B?Z0dxQW1OVkQrcnlwbFVRWXBVWmgySGY4SWNMVEhPTWhmcWJqd1lyaVU5Y253?=
 =?utf-8?B?aERmdUtCNFM4ZFRRRE5KbXBsRVNqUm1udkVvUTNjL20wUzh1eUZJOVpTeExn?=
 =?utf-8?B?YW13QjA5d2MvTTFZYXlsL3plL2RydDllVlh5a0tSdW42bmt3UGRkODdnckcr?=
 =?utf-8?B?OXhBN2FnVFI4ZkVQN1ZXdkFORVltOCtuNkhuMFdtUjZLc2VrdVNLc1RUbkRB?=
 =?utf-8?B?bE0xeEJiOHhYTFk4bXRzWU9QWFlIR2JlQTVrdDlUOW1XcU9BbURRbGM4eCtO?=
 =?utf-8?B?eUlBQWI0ZDNrS2l3VDNFaGdZTndjUEM1UDcrSlQzTGpaRWV1SmRXWjZXWFBL?=
 =?utf-8?B?dUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47B7B8286067594989E90210753A2871@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd795b5-e823-4a62-097b-08dc971a6827
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 02:31:25.1830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 51Lzouj3rnd8RLYTcbG5Utsg/KjjU/glPrJAz+KxxY8GxX12J4sSNsWYYeJTpojrxPRdeWTr+u7PG9BOZgbTGeNQsH/qllldMTsCcZ5DMjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7331

SGkgT2xla3NpaiwNCg0KT24gVGh1LCAyMDI0LTA2LTI3IGF0IDE0OjM5ICswMjAwLCBPbGVrc2lq
IFJlbXBlbCB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+
IA0KPiBGcm9tOiBMdWNhcyBTdGFjaCA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT4NCj4gDQo+IE9u
IHRoZSBMQU45MzcyIHRoZSA0dGggaW50ZXJuYWwgUEhZIGlzIGEgMTAwQmFzZVRYIFBIWSBpbnN0
ZWFkIG9mIGENCj4gMTAwQmFzZVQxDQo+IFBIWS4gVGhlIDEwMEJhc2VUWCBQSFlzIGhhdmUgYSBk
aWZmZXJlbnQgYmFzZSByZWdpc3RlciBvZmZzZXQuDQoNCkxBTjkzNzEgYWxzbyBoYXMgNHRoIGlu
dGVybmFsIHBoeSBhcyAxMDBCYXNlVFggUGh5LiBDYW4geW91IGFsc28gYWRkIGl0DQppbiB0aGlz
IHBhdGNoLiANCg0K

