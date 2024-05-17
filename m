Return-Path: <netdev+bounces-96928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1988C83F8
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 11:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1290B20D93
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 09:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02374224D6;
	Fri, 17 May 2024 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="N6MsG7Mw";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="yrZTlx1S"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAFB168C4;
	Fri, 17 May 2024 09:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715938749; cv=fail; b=CiakpnzPFYmdl1JTAYZ9hhQT95P9xT+1wYhdstqfg18pMHYomBzjPM8nkbnAVQg51x7nMGKKB2C1B3S5bzjHztWha7kU37pyscDkE3VUggij2lRt8tgWcGv4skH6Pb94mneUpObrrbCS4+u9HYPD4mqcOVhSXdXRK0pNKj1K7zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715938749; c=relaxed/simple;
	bh=SiQJMW1FF7eLWKVkRSp050j/lp8Ca0ksi7y7dwUwdoY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hZSUhaA8q+RrC11Z3vKbCr4shax/ytC7kwmgYd43aeIQJVMZ2f22RhMlCsulss08GOlUsSUyUWug2A0hQfslPsG+ltk9YhPe7f7VdmgPe69JilMtkT0NKZUkOqM4NpRbr8fovR2nSoZ0EdFjj916J50/iQGx9e3UmfF9wjMSdJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=N6MsG7Mw; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=yrZTlx1S; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715938747; x=1747474747;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SiQJMW1FF7eLWKVkRSp050j/lp8Ca0ksi7y7dwUwdoY=;
  b=N6MsG7MwNilZw9a54A3sKEaXjTcIduq3rKAQ0Xi1Zvj5Q1RqNib3XkRb
   garT2McinXJs3ENnk+J7wExfIVpqZSjVuDHboMiKZaCGafAiKF6rF3Vte
   o/c6bCtKtdLSArSOgFmxTL5Oh4859Td8VhyOgnvo9tomLNb/qsXpjJmMa
   sFfTG+xVJzaz3ZFH5EkxvhQctlH+2dFuSOmd1AD2DfhtKV8IxuwHgq7PJ
   5+vCuBi4bSrGjlA7E5Q4TT/SQPuJIfAUNvkArVV/su5MJLJV828AKuYB6
   tM+Qeoko6QzQmpluJXb0aUlGFpyZR/5KQLTv6DNJeqiE8KPp33jWcn8rY
   g==;
X-CSE-ConnectionGUID: 8GLSUU4mRnKnT4mfIhKoug==
X-CSE-MsgGUID: tdeTPOqeRySOQM2eZhOiQg==
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="25061983"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 May 2024 02:38:59 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 17 May 2024 02:38:30 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 17 May 2024 02:38:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSSNYNBawP7ckvZfPYefSvuVVLTe0sZdt9kCkOUNvltNmqEjGNVrryg/OcH8UqX8oMLXKAQb4G3tf11JVe6v4Qvvi2x66teCTyyZVoDgJVRSKhTqL2JZIMJvmZzFeuNvHspDhRRbMq9eDnjQV3rFxhvMGrtw8HM+wiyTidjZLs/gbLeyHeQTEWUDsp0RIwJw46WKEZpnoh8P9txd1+4MQlTbbBhVj+iubhVB+tON3gUTQYeHicIxLMVtN0g78KxMpCG38wK1lYya+Z8iBQGYwcc8qTWWK7qmPXfGsGNGQfXTnYAVQaoEFOAgoVx+s6S1JaKGagSxvdCtvUelMtpd/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiQJMW1FF7eLWKVkRSp050j/lp8Ca0ksi7y7dwUwdoY=;
 b=SWWQVGVL1QgKhreTm6zaKefkVBw0ND4jP4CK10BxpEsj6xXFZYrKntqY7i1bSOP/LpxY8QRbJLxk5Z3Os4bT66qZDbal9DXSSCdjmROu51G6I5eq5DgE2nPT+kbReVPykipFy+k41h30gIMW7OVoUCH5tTPgGK5FZhyW0DEgYKq7EFNw8d8PWhvY6JJdprXmkKtV9NjWB2b+wv4DNVD51CXt6mI5ea1pFs5eZhBaXIk4reWR/1fC+ISx/0QQUG5QuDfZdJfX9+pfuasy3XvxxnovGxFnUNCxxgowigQwfhl/XyZFzdIAmabew/zvWHFtfGGErvY3Pw6DgPP0mtm/cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiQJMW1FF7eLWKVkRSp050j/lp8Ca0ksi7y7dwUwdoY=;
 b=yrZTlx1S1Lw+OoeK4oS5lq4OQ6I7j10BAAioPSBJ2ppPNDnT0KxMMdUKvbBBOcFeQ9Vcgv8excoBM3txBPW2QkYJyr7+8UhNOwVIBpGVBamYWxSHQZxTPuxh2M3F9aF20PBZDY4oBTG7rsB124y1BQ5agTzoNJ186eTsthLvtbnFsxh/jTfoP302ZrKECBeqWBWFM3/Yq3BqY95iFKdJXViRK73662U76X33b+m4be5C6tr9FFM0Jzd63oWCPpIouWsdBsZQnNY6uOZi0fwBXXvpGihhRGYHVbaz+TRRB7TA8jqz7+TeOXINXd6fBmiu3p66+9DTdsEtTkgjQidVyQ==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by PH7PR11MB6833.namprd11.prod.outlook.com (2603:10b6:510:1ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Fri, 17 May
 2024 09:38:27 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%4]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 09:38:27 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <ramon.nordin.rodriguez@ferroamp.se>
CC: <andrew@lunn.ch>, <Pier.Beruto@onsemi.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <saeedm@nvidia.com>, <anthony.l.nguyen@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <Steen.Hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, <Selvamani.Rajagopal@onsemi.com>,
	<Nicolas.Ferre@microchip.com>, <benjamin.bigler@bernformulastudent.ch>
Subject: Re: [PATCH net-next v4 05/12] net: ethernet: oa_tc6: implement error
 interrupts unmasking
Thread-Topic: [PATCH net-next v4 05/12] net: ethernet: oa_tc6: implement error
 interrupts unmasking
Thread-Index: AQHakZAQrurZHAw3l0Wxg+eFKGxGMbF8la2AgAAX2oCAANNtAIAAVU8AgATxiICAAQb4gIAAAoaAgAFdYYCABFWYgIAAWygAgAr+tICAAGnoAIAADcgAgAD6j4CAAq/ggIACWJOA
Date: Fri, 17 May 2024 09:38:27 +0000
Message-ID: <e75d1bbe-0902-4ee9-8fe9-e3b7fc9bf3cb@microchip.com>
References: <ZjKJ93uPjSgoMOM7@builder>
 <b7c7aad7-3e93-4c57-82e9-cb3f9e7adf64@microchip.com>
 <ZjNorUP-sEyMCTG0@builder>
 <ae801fb9-09e0-49a3-a928-8975fe25a893@microchip.com>
 <fd5d0d2a-7562-4fb1-b552-6a11d024da2f@lunn.ch>
 <BY5PR02MB678683EADBC47A29A4F545A59D1C2@BY5PR02MB6786.namprd02.prod.outlook.com>
 <ZkG2Kb_1YsD8T1BF@minibuilder> <708d29de-b54a-40a4-8879-67f6e246f851@lunn.ch>
 <ZkIakC6ixYpRMiUV@minibuilder>
 <6e4207cd-2bd5-4f5b-821f-bc87c1296367@microchip.com>
 <ZkUtx1Pj6alRhYd6@minibuilder>
In-Reply-To: <ZkUtx1Pj6alRhYd6@minibuilder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|PH7PR11MB6833:EE_
x-ms-office365-filtering-correlation-id: cce9dbc1-c0a7-4a51-0de4-08dc76551ac5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?ZU16dXhycEtnc2IxR0RFS0dWTTJpa3REU2VIVWJQSzdRU3hIajRjbFNkY0N1?=
 =?utf-8?B?Rk0vSUxXdlJHOUNFOXJCeEdia1o4bjZld2oraFBrTkJ1ZXE1N2RHTTJKOXI4?=
 =?utf-8?B?VkNRTk1wSy9WbjdacXcwWHFub2Npc2xsaE90M2lhZjdKWEJubEdaVWd5UVhw?=
 =?utf-8?B?NUpCeTFuOTc0QnFZcmNzY1ZodFRlejVhYzlBOWx2bTRtcHpRR0RGcW81YTR1?=
 =?utf-8?B?WlVjckZZcEt0bVdXZ0xxWFV5bEpNTnVJcSt5VklpU0Rxc2Izd0w5aGw4QTVw?=
 =?utf-8?B?V1N0a1VERUtsNWpjWTVISXF6MlJDaGxhek8yOUw1akNvY1FsQzV5OG9QWUh5?=
 =?utf-8?B?WVY2bUNlS2tublh1VDM4ekcxZjRoM3JNS1JGWUV0dUJwemdDK2JsSC9sbjJ3?=
 =?utf-8?B?NCtIWW5PRXI4Zkh3Qi9MamRyR3ljQlhsVVplcmZZK1FVSGIrTkU3amU0S0hZ?=
 =?utf-8?B?VWJCOW5PdXd0emYwZEdCcjBsTm96UGFKZ0JpZ3o0eWpoNGRQM0NTV0VSSlVE?=
 =?utf-8?B?czlKNEp3SnF6WGlJTVNTWkZrTnFJdVBMWGVBd2pGSlN2emJLVXB5RFFXUnNl?=
 =?utf-8?B?aHhRREhlZE1PSWxCUXVmWDdoeFk1MHBFdGdIdmw2TGZtS3ZIc1ptZmxQQnVr?=
 =?utf-8?B?bEVhVkovbGRCdldmOWlsYWNyU01GNmZ1VWhGa3gxV0RoK1RTamlvTFFMTDVX?=
 =?utf-8?B?WWIxTW5GNFdWN3NQVjJkS09xbzltbGxvVHp5aC9VTVNJUkRMOTg1YjF4WTJZ?=
 =?utf-8?B?Z3ptMHdvR3hoZlROSGoxMy9OOWZwQ1B6RzJUdFdZTkNIbFV3SEV5bnNvMUFJ?=
 =?utf-8?B?V0s4S0RpYU5ENk95b2d6YktzSHNHUk1QZ28vMmZKQytxaHlEYUJKZVJUTFA3?=
 =?utf-8?B?VXV4bmQ0K2M3SDM4Qk80VVFOZHlHMkdkdldPdGhob3NFaGdwVGFGZGlXRXNa?=
 =?utf-8?B?aDkwclJBdjVqVDkycXdEZ20raHQ1WGpkMjg2M1MraHd6OFpXamFXb29IeWVV?=
 =?utf-8?B?bUJudE1wVUZOaWNhb1dHU3RhM0V5SjA4YzlnYjgrNStoMlhKM1pSa09QSTN5?=
 =?utf-8?B?K2ZiYmxXUU5EU3pBV0xyVVBtNzBOdjRObEs3ZkhpZmZWejdoUXQxNnFIV1BO?=
 =?utf-8?B?Q1Y0QmJzZVZmUGhqQ2R4bm1QUDhTSEl3NU81UVdqUCtmcEpwUXhkbFdvMUdY?=
 =?utf-8?B?MFlsOWg4QjdwQ2FHclc2Qk9mUS91Qkg1TENsM1JjRVBSYWlHUlN6U2EzR04z?=
 =?utf-8?B?bEZBaEh6dXZ3ZFdnUWJIZFBMbGIxUmxCREZlYUNPRTRrNnVOeWNtWVdGVDBu?=
 =?utf-8?B?ZWVFZytVQlNkRG5hWCtZSHhqSUF1dDEyelNyUnhheUZMQ1lhbjlnaGNwSFg5?=
 =?utf-8?B?YU1KVmI3Y1k0MyszRDMrTlE2am0rbDM5S2lndjJaQlpzRU14dTVPNzZQUWdE?=
 =?utf-8?B?MGo3UUdQeUwrcGRTL2oyY1JKZzVvb3p6dklFb0loWmJCQk5LWFJmVEloMDFk?=
 =?utf-8?B?TjJvSzBvRXZyUy9WamszNjBLOEVWUFp3czk5cGhxaHVLUFJKSnliV2dpVytX?=
 =?utf-8?B?MlJTam4rcWoyN3pVVGxFTHZKa29uT0Y1eTFMVS9EeU5uNnE1b1ZzR0t1Z0F4?=
 =?utf-8?B?VWwyU0tBVjZrZk9qVkc4RGYvZkdoOWlvb2ZxNDladnlQcmRLMUNKekZUSTls?=
 =?utf-8?B?Wk83cjc2b0J0UnN6aGlJMis1QmwrUmN3ME9MYkdBdTFiWG0wYkpRVlFTeUtD?=
 =?utf-8?B?WlcwRlhvcDhoelJyTGdyOEJVbEIyQVhuaFI5R0RZMDY5QlFaQ0FKVFpST0ty?=
 =?utf-8?B?ZjNQcWlsRE1PZnZ0aW1ZUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHBuQUJTMndBc0ZGQm1BK1ZIUDMxSU4ycFVjMmVSSHh2N3JieS9IbTlDQVNF?=
 =?utf-8?B?NjFjc0lGYzJ5SGp4Mm9RUEtZdTZXaWcweVBvUVZuUjBpUW5oU2ZHSG5jbm9U?=
 =?utf-8?B?ZVJ1N0MwWkRaTDAxakJBRHZBSGo0Q09WcGVhMlo0YTNsMkhIK0NSdCtVWms3?=
 =?utf-8?B?eTUzZjNodDVTNmczVk5xcmJBeXVmeUdnZUFiai9XUjEwUmh0TWhvVVJRYXpX?=
 =?utf-8?B?Q2RrV3RsZVdMa0NxQXFQZHZqSHNuT3BFNXRkTjFZWlRycXVseVF3WDgxZ0gz?=
 =?utf-8?B?cUN6WlllM1hXUml0VzBZUHYyTElRQk5Od0lJbFZ5NnZ0WVBSOFhLU1l6TEp5?=
 =?utf-8?B?QmNuUXRMSjdZTzVZdW1rNmVIQmh1eXorbWk1ODB3a0VuYXJjY1VCWEdpUlow?=
 =?utf-8?B?RWJLbEc2aVZmQnhaY21KR2syU1JLNVg5b3c5QnRkak51V2k1OVJIQ1ZrMkV0?=
 =?utf-8?B?SGNJRmRPUTBaOU1VejMrRnl1bVRMcXBvOHdMR0hkeHphNitJUnhocHFTN0Vi?=
 =?utf-8?B?R2VuMFRwbzBZcDBEb0pFT3BwM2FCQUJvTTdjZkZVNjNpUmJNWFI3VzIxb2Zm?=
 =?utf-8?B?OTI3QkZXQ1lxK2IvVXV4ejYvWWp3d0d3ZFF1eVBFcEQ2UC9Ob1pDNTRBc3Mw?=
 =?utf-8?B?YXhKM05pV09iMmxnRmEzN004MkJ0Vy8zNE55SmNjTkhEaUo3RFJUdTA3V3lw?=
 =?utf-8?B?dWYyWnFvdEsyY3ErZlVrdXZCRndTYjhHVVpjK0RSY0xWWndUNHliZW44M3NX?=
 =?utf-8?B?dTJPWERLelQzZU8zZFlUVHFaTFZTLzU5NFZQOTM0cXhkY1pPamRhSGJLWGda?=
 =?utf-8?B?dE93bVB4YUF1ckxaektVRndPM3lYRm5RUi9Gd25NSkFGUUNSWUVzbmQ5MlBU?=
 =?utf-8?B?Zlo5YlEzeG5vQ2x3M2NUQXZSOTQ1SnNUWFlWc24rdE1nYUdMSE9JNHlia1kw?=
 =?utf-8?B?cHpudjJmanNONW1FV0FINGQwRHNSQ05KSFg5S1pxVExpNkhQOXNNdWFQNmVn?=
 =?utf-8?B?YVp2TDRQaGlnNWZnQXV1dzVUQmlWdjdxeW9VZllrcEx2Vi9LZnEvajlpZWFv?=
 =?utf-8?B?WktGOTk5Sk5VNHJLY3R5SU1FYWw5U1RleHRBVU42L01WMGRicW0xWWNVYmFI?=
 =?utf-8?B?aXZKbWxFMDVIOXcxcEZ0OE5VL0FybjltbGN5SmRzQnhNVkRjemdPZmpzcWdj?=
 =?utf-8?B?a1pJbHM1NjNzTExMVHZMbVI4QzFmcncrQ0lNaUxwVmxRYXk5c1NIVFFPYTBs?=
 =?utf-8?B?c25TcWFiRkFyOGRyZ3hNZFdYUGtMcWE2Wkt1amxWTzQyNFBuYVFyWndkM1Zp?=
 =?utf-8?B?V1ZDQXhKVWFCb3pxTzcxRjVrL0gwRStBNnpydy84eE10Q3J6ZDg3VWNNR1oy?=
 =?utf-8?B?Z1ZMUmNCQkg4NmtqWjkzMFNWZFUvZ0tKd1F1Q2NZamQ2eXNmMktsbVNzMUtR?=
 =?utf-8?B?R3JqR0VsNjV5TWwwaGN1ZWd5ZFFUVThNb2E3ZmF2TENMa2xFMlREWWJjVlN2?=
 =?utf-8?B?andXdStINkoyaS91MXZhdDJBOFp1RVJqb0RscHNPbHVuOHpoN1JoWTRPc1Fu?=
 =?utf-8?B?bHcwSXd4c04zc1IzK2RIUEhlRmxHbCtpdExESjlFbjNjYTY1d3VHaUlFYnRL?=
 =?utf-8?B?bFJxTUdqUXVLVCtlNnBkZDRmUTY5K1BpOHVzMzNiWUcxMmM5YmRXOG1QajZD?=
 =?utf-8?B?alFmdDFmQ3NhcGcrMnhDeTkzRzllekhHZ0tFcUF4MU1ST1Z5VVVFbTRMTEFN?=
 =?utf-8?B?WW1ZTHhZZ0RpUm51b0lOWjlKZXdqVTE5U2hsaVJXV1hhTkR1WHZlRkNNS01I?=
 =?utf-8?B?cVc1b2pFQnhCZGFPdmhmSnBLSGtDNUtNN203K1F1N3ZBQ09EdmxIVjlqakhN?=
 =?utf-8?B?WkZxTHUwWmZybWJtVFpZTnJtTEo2YkJYL3A0Z25LR0lKZHUrcU9Rczc3YmRP?=
 =?utf-8?B?dzVQeWNGYTRXT3NsRHYyOGJhR2pxR28rK1V0WURZNlJJZUVpeUdiSDR2TGVk?=
 =?utf-8?B?M0RJU1pzZFFwUnFSVzlQcTA1ZEFuSERZT0wzM3RncTBjMzFRMlVId2xlOWs3?=
 =?utf-8?B?UzhLdWtieFQzL1dDazIvZzZlY0hCVzlxenEzWVpCZmhrK3Z5a043cjNFem1p?=
 =?utf-8?B?SXJySDNXd2VobFhLYWs4WlJFT2FUenJWRHFkbklyUkxRV29TWWhRV0tUTUFo?=
 =?utf-8?B?aXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE07400B807A1E43AA65D075D1C88FCA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cce9dbc1-c0a7-4a51-0de4-08dc76551ac5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2024 09:38:27.3046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AW4GSLS+QItFcCz7D6VnHpg1fR5iMXgNPdoo6O3FkC6Wq4oeCQZPv5Mb5bgjyV+fvwrPh4PhmsJLkNHDawt5W5MX5QwikKymKgOh3drTduxbZMJ3AHYr8IndOW8yL/sI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6833

SGkgUmFtb24sDQoNCk9uIDE2LzA1LzI0IDM6MTggYW0sIFJhbcOzbiBOb3JkaW4gUm9kcmlndWV6
IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFR1
ZSwgTWF5IDE0LCAyMDI0IGF0IDA0OjQ2OjU4QU0gKzAwMDAsIFBhcnRoaWJhbi5WZWVyYXNvb3Jh
bkBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4+PiBJcyBpdCBkb2luZyB0aGlzIGluIGFuIGVuZGxl
c3MgY3ljbGU/DQo+Pj4NCj4+PiBFeGFjdGx5LCBzbyB3aGF0IEknbSBzZWVpbmcgaXMgd2hlbiB0
aGUgZHJpdmVyIGxpdmVsb2NrcyB0aGUgbWFjcGh5IGlzDQo+Pj4gcGVyaW9kaWNhbGx5IHB1bGxp
bmcgdGhlIGlycSBwaW4gbG93LCB0aGUgZHJpdmVyIGNsZWFycyB0aGUgaW50ZXJydXB0DQo+Pj4g
YW5kIHJlcGVhdC4NCj4+IElmIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHksIHlvdSBhcmUga2VlcCBv
biBnZXR0aW5nIGludGVycnVwdCB3aXRob3V0DQo+PiBpbmRpY2F0aW5nIGFueXRoaW5nIGluIHRo
ZSBmb290ZXI/LiBBcmUgeW91IHVzaW5nIExBTjg2NTAgUmV2LkIwIG9yIEIxPy4NCj4+IElmIGl0
IGlzIEIwIHRoZW4gY2FuIHlvdSB0cnkgd2l0aCBSZXYuQjEgb25jZT8NCj4+DQo+IA0KPiBJJ2xs
IGNoZWNrIHRoZSBmb290ZXIgY29udGVudCwgdGhhbmtzIGZvciB0aGUgdGlwIQ0KPiANCj4gQWxs
IHRlc3RpbmcgaGFzIGJlZSBkb25lIHdpdGggUmV2LkIwLCB3ZSd2ZSBsb2NhdGVkIGEgc2V0IG9m
IEIxIGNoaXBzLg0KPiBTbyB3ZSdsbCBnZXQgb24gcmVzb2xkZXJpbmcgYW5kIHJlcnVubmluZyB0
aGUgdGVzdCBzY2VuYXJpby4NClRoYW5rcyBmb3IgdGhlIGNvbnNpZGVyYXRpb24uIEJ1dCBiZSBp
bmZvcm1lZCB0aGF0IHRoZSBpbnRlcm5hbCBQSFkgDQppbml0aWFsIHNldHRpbmdzIGFyZSB1cGRh
dGVkIGZvciB0aGUgUmV2LkIxLiBCdXQgdGhlIG9uZSBmcm9tIHRoZSANCm1haW5saW5lIHN0aWxs
IHN1cHBvcnRzIGZvciBSZXYuQjAuIFNvIHRoYXQgbWljcm9jaGlwX3Qxcy5jIHRvIGJlIA0KdXBk
YXRlZCB0byBzdXBwb3J0IFJldi5CMS4NCg0KQWxzbyBJIGFtIGluIHRhbGsgd2l0aCBvdXIgZGVz
aWduIHRlYW0gdGhhdCB3aGV0aGVyIHRoZSB1cGRhdGVkIGluaXRpYWwgDQpzZXR0aW5ncyBmb3Ig
QjEgYXJlIGFsc28gYXBwbGljYWJsZSBmb3IgQjAuIElmIHNvLCB0aGVuIHdlIHdpbGwgaGF2ZSAN
Cm9ubHkgb25lIHVwZGF0ZWQgaW5pdGlhbCBzZXR0aW5nIHdoaWNoIHN1cHBvcnRzIGJvdGggQjAg
YW5kIEIxLg0KDQpEbyB5b3UgaGF2ZSBhbnkgcGxhbiB0byB1cGRhdGUgdGhlIG1pY3JvY2hpcF90
MXMuYyBmb3IgUmV2LkIxIHN1cHBvcnQgT1IgDQpkbyB5b3Ugd2FudCBtZSB0byBkbyBpdD8gSWYg
eW91IHdhbnQgbWUgdG8gZG8gaXQgdGhlbiBJIHdpbGwgcHJlcGFyZSBhIA0Kc2VwYXJhdGUgcGF0
Y2ggc2VyaWVzIGZvciB0aGUgc3VwcG9ydD8NCg0KQmVzdCByZWdhcmRzLA0KUGFydGhpYmFuIFYN
Cj4gDQo+IFINCj4gDQoNCg==

