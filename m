Return-Path: <netdev+bounces-109543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6EA928B73
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 17:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D6D01C248FD
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 15:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D72416CD0F;
	Fri,  5 Jul 2024 15:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wJ0FJ2ox";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CQv6Lpdo"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A241487D8;
	Fri,  5 Jul 2024 15:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720192551; cv=fail; b=S78F+TRKQzGKboTaJ5hQ2PYGrCl55Q+GgPuqEcQNd2qaxlRxnAWcwSn2AiZ3VzBGPj/JvHhO0DT0XTf+8u4Tp31NtLa1cmJwAMbbM0Sx3iVBEV2XMqcUFXHk8WeJmlwLC7inVzXgOSG7gFe2ZH0xZ005R++3+lrQEKKvll10K8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720192551; c=relaxed/simple;
	bh=c7fEYwok8PgzRkIH04QSc8IcxzcA1TRH+gi0nwpEJow=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rtpBmTlGpa/seJtrivDSMQ2g6pHhV1Z+jyuTgSE38ihYkUip2gSl+D/og2Vt/9Iln3JtDa9VdaLzS+aakbkloIIphpGo+HhdzeWr/RjYefBrqivjNrbGDFVHn6Ba4nWNn5tXWGuXi0akruwdnEIDdSv1t4NTyDW5DIlAEOXhJhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wJ0FJ2ox; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CQv6Lpdo; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720192549; x=1751728549;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=c7fEYwok8PgzRkIH04QSc8IcxzcA1TRH+gi0nwpEJow=;
  b=wJ0FJ2oxl/ugDLsnTXE7dkgGADIYZ6PVQGwI/vUhfZ/j8VM43yte49yR
   NEw61QPqB1ul3n6QBtyrcE99S/0YUIeEYySQm0bjhsUl1aNjI6/XFh77p
   oJHfsJg40a9OcDy3kJtF5I+r37pKG9Ce1nwPyH/goOsVx8UP5kTQr7I3D
   /u4ok8Y2a9aG32vXyPSIcmrSiMydn6CwrcNjSrNtVwhQCyQJH9wi26WRU
   +kav5IDSkDWsj2E7bbsI2T+fbOMPtjUB85zaGpyJyOc7srLX77Qz6SNsU
   u+Q5XuM8lV6adyBwk6k+p4/igRBHlp/2njSEl2DvZGohX6s93qXeInmYJ
   w==;
X-CSE-ConnectionGUID: SGBNr3YkSCa4G3qHgs5FjQ==
X-CSE-MsgGUID: 6likrZJdT9uCGM8iNBVAIQ==
X-IronPort-AV: E=Sophos;i="6.09,185,1716274800"; 
   d="scan'208";a="29531098"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Jul 2024 08:15:48 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jul 2024 08:15:40 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Jul 2024 08:15:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdY7uUZ0X+Wf6icUgjcq73VwrJoTpNJURsL1Ofatn4i9o7HnystQXr3Nqay9Ib7ZCcfXKjvukvR6tkOQKLdu4mjgOtRyiXTc3Wcj4oHhNp1liuWBBMBfGQxFAD3t9fE+XJXxsJcjWd+LeQ1/EUMOFjeM+LJJPYxHiA5VUngKSJ0+kbMId1aHr6lPjrrUKUuM+lW+Me2nexnWX880fYo1txJ0KaDzEd7NXd9vl+kd8uG76Dep7h8aov5MRa+fzsBpbblbhT5Banowc1R8RacljmVxC4Fuev3ssHXw76CQgRL2HaIzC0Q+KYJEzo0OX9QFBVowwwI6vYC7nWCVUax56A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7fEYwok8PgzRkIH04QSc8IcxzcA1TRH+gi0nwpEJow=;
 b=ePSPX9IVAD3MAgqhucjkt2GqIPJ4JKmYLfQzAGrOtOXVmjPW7DKMjhIWTnPa8abRAGCn6nwPEUDUwBXky5w55DnSQfwUWYbJlBZpHOQuHO54vbeGPkfvhTx6eF2CdgJHP+Br148ZQ99kbO30fCv0pDWXDGEXnKVKiU6knwJHTTDIUfFpN2vECXVwzUF3WRcrZ6ih40jzBNCsttTNkeSpe/oYEeRu5NDOw2HQIts65kgKT+w4ztchi/jdO0L8WU6wTdY3ELQ8Rm7wdY7WIsd813kyRLiNif80Gqt/TYC+COKzvqYubyicgPmEUnRLUNjJaAxOW5BQtTYct4zvLBJgww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7fEYwok8PgzRkIH04QSc8IcxzcA1TRH+gi0nwpEJow=;
 b=CQv6LpdohsYPr6brBS5PGKeFXVSkI0sVgh7hZ+NRMRrsffFqgLRpB2DocToXZKT238EOou7D7MV4y2j25OfG7YYLvWRFgjZ1a6ARrWS3KrVOjKz3wdOxLjtQBdIVKgQttXOMJXTYxUlR5lrxcoqDVRUn+N2kBKg+Gg0Hwtj4QPBBuSmgS1fDzfQ8J99b/ffCliWBx881YK2w6Paeek/oZABkuHXe9+M0mTKNrWee8QO5Hm3u7QvttRfF+H+kJIZDH7fzs86Vb9iKMV2SElaglq50DrRG6i5QCJmVYY4AgN9AJK8bdpXRBq14xkiRT1KcCkTMhRfGh7KFJ2IO8JKlzw==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by MN0PR11MB6205.namprd11.prod.outlook.com (2603:10b6:208:3c7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Fri, 5 Jul
 2024 15:15:37 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c%3]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 15:15:37 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <davem@davemloft.net>, <hkallweit1@gmail.com>,
	<Yuiko.Oshino@microchip.com>, <linux@armlinux.org.uk>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>
CC: <michal.kubiak@intel.com>, <kernel@pengutronix.de>,
	<linux-kernel@vger.kernel.org>, <florian.fainelli@broadcom.com>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/1] net: phy: microchip: lan937x: add support
 for 100BaseTX PHY
Thread-Topic: [PATCH net-next v2 1/1] net: phy: microchip: lan937x: add
 support for 100BaseTX PHY
Thread-Index: AQHazrk2FAzyo/q7tk+yVkoRt9mE/bHoP5CA
Date: Fri, 5 Jul 2024 15:15:36 +0000
Message-ID: <457179162ca6fd067b22b3b7733c60c2a17129a5.camel@microchip.com>
References: <20240705085550.86678-1-o.rempel@pengutronix.de>
In-Reply-To: <20240705085550.86678-1-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|MN0PR11MB6205:EE_
x-ms-office365-filtering-correlation-id: 0a617187-979a-4e99-a50a-08dc9d0552d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?azNDYk45Nmo1VCszYnFIUXR4SnRtOUVSUU5kNk5VbTBCZ1hKRW1NWCs0cFRh?=
 =?utf-8?B?czBSK3MwNnBZend0MTExTEJ5MG1GVlJTK0gydjZyZGNTdzNzL0lHVlFLMmZN?=
 =?utf-8?B?TkY1bWduODc1eStyYU5yNjlsMWcxci9NWnNIV3pBOVRLdytTYXNUSzBGWmx2?=
 =?utf-8?B?Ump3b0d5YkF6LzM5Vng5UjVxaG51UTE5ZHhDaUdrRmdadWZsYjJlWjJrc0xK?=
 =?utf-8?B?UDdtUm9ocG1QMnJWbFV1ZWpTZ3ZsTnZ4dHFDTU81UFpkSFQycmhMc0poMERx?=
 =?utf-8?B?ekY3dmR5TXdGRjZnWWZ4WmxYWDBoZSt1cFc4bjRtT1lDTGZaVjhYN3FqaThy?=
 =?utf-8?B?a1VURnIyTk1MeDlnZkJ5R1Q3TFlpMG0xMGdka3pMQ1RlNWhhUjFlMWNqdzYw?=
 =?utf-8?B?UGJYeFY3ZXFaWUV1YkRGdSttMHc2YmFDekROVXpXTjIwM0hjQklBRzFycW84?=
 =?utf-8?B?aFZUUUJQZmxyRUl5UHYxMXFCWFBBZHZGL21GODBSTURzVjhGM3g5QjZPQlBS?=
 =?utf-8?B?MFRDaVoxdVhQVUVaUEZ2c2dETmdNQ3BxU0V2dTUyU1hBSGlQSTdsVmNpZ1pU?=
 =?utf-8?B?bmVVSVU0STh3UDhLdVlXSXI2SWZIRWJiWncydllMZlQ3SlVLY3RBeFRyZlQ3?=
 =?utf-8?B?c08zVGdJSWc1cU03STRQMW9XTW5ZRmNqbVhiSHBQUlhMbUZWZkMxQzVDSGti?=
 =?utf-8?B?eWswV0ZWY01tS2ZFM2lXOFlTQXhNeDRKRlIrZFNWYWttRWZFb3NPUmxjYjA0?=
 =?utf-8?B?dkkzL3JYT1JNYTNIeUJiRWtscm1aMnh2N2dUK21RM3B6R0hRby9haXVBbHpK?=
 =?utf-8?B?S29MT0FPZzluWmhHeUljVFpZYkhUREZGbFJ1MExjNjdVZCtmbk95RXpTUUhI?=
 =?utf-8?B?TmFxRTExcGNxR0dnUmdoTE9wakFxc2hWaUZDZVMzdlB1NkhrYWZQTDJrU2Y4?=
 =?utf-8?B?VjM1TTdoVWxhcWFiNEZ1cVhxTVdNNVF3WW9yMG9qSDZIdkhPaWtCSk9lcEd0?=
 =?utf-8?B?RTFmRTVLQUsvbklKUzRtTEtPY2lwdVh1Njg3KytvYXN5NFVtb3dPd2pTc0dQ?=
 =?utf-8?B?WDh1U3ZMQ3VURjdIVDhNU09xYW9oWGovUzJTYzVPL2VhMnBSdlNVdkZuS2NE?=
 =?utf-8?B?SE5Rb0V3Zm0wSjl4S3ZXdXJZTFd4anJBb1V3dU5vejdQdzRvU1lIWVZvT2hH?=
 =?utf-8?B?bWt4SVU4OUNsRFNMNUZ4dGJKOG1kSmRtSTNHdFkvZjZZTkxhYkdLU3BkSkxJ?=
 =?utf-8?B?bktIeFd2QU9sUUpOUE04aEhWbUR2Y2FEMmNQbEJnVVdiam1sck54SjNNZXZQ?=
 =?utf-8?B?SlBwVUh2NjlEWjNIZHdPVVdtVVlwQWw3NDZHWUlVR05pdm1iRXhqbmNGQ2Z3?=
 =?utf-8?B?dGlhQnY2d2UyK0tEQ2VmUGp6M3pjTWtRR0lFN2dGeTZyZU5PNVlhZXhDT1Qr?=
 =?utf-8?B?WDY4ZVF1VHBVaFBKY0lVWjh5QVV3NHNQKzlDM0Q0cUh4aXhuWElKNWMxUkdl?=
 =?utf-8?B?ZEY1UTZITzFTRVZLS1hvd3pJdVJpQVNpNlFLcHBVdm8rUTcxZVNzM1AveGRM?=
 =?utf-8?B?ZzZwSExaVURnTnBMN09hbEQyRW81S3JvZElNbW44ZkZVOUFxemNqZVZoWFJ2?=
 =?utf-8?B?Z2FGeDdtRURXdE5RdDA0cytxMzZNb0RRVFljNFpGMVcyWi9HVnZCVHNDSWNz?=
 =?utf-8?B?QWJsaDRGUXI2NGY5WVZIVmhOYTBQMWNaNmxUNVZMdDNWaHJXaE9xZnVpTFMy?=
 =?utf-8?B?S1RJbkNCOURPVUx0Yml6NUtNcnVuZWhaaVJrSm5ka3R5akpROTl4MkxhdXBJ?=
 =?utf-8?B?b2lVZzBXY0UvejVDVWpvRTJEV2V3S2pyYTRTTW9kaVN3N0xkYWZ6VTZ1aktR?=
 =?utf-8?B?VDkyR3BIZlN4VDFkZElQeCtnWVdTRGNkcGRBb0Q3ckd3MkdTdEJtdmJMYzND?=
 =?utf-8?Q?7XRu8DzZT3M=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFlrWWZybWJKMHdySUozd2NVWHR4K3BVZXAyQlU5NHdudndEaXRUalhOVVVE?=
 =?utf-8?B?RzNQZDNDNzk4RFNnZFltdU1oaDJXZUh0VTNrL1JMN0ZIMzFBS2IxbSszQ3pK?=
 =?utf-8?B?TDhmNHdhTUk2d21GUUVUN0lqbHJXbmc0VTRMdEdCUGpSUlF1UmpoTFZTTlF0?=
 =?utf-8?B?UE1vRjFNREhJWmhPblNXNjF1NStmQkRXb3o0OTlPZDJxZ3NOZWowOWtzbGx3?=
 =?utf-8?B?ZDFxVVVEcXdKNUNGNDV4VlloaWliYUlVTStLeGdXN0R4UG9NRUlKZC9wVVJI?=
 =?utf-8?B?cllyS0dwaUk3UnB4ajRucW41bkhRRDhwRlZ0cVJzV25kTllFMEQvM2tpZTZT?=
 =?utf-8?B?bjZNZWluREU3Q0MxUHluMWpudU56ZzVvVXFEUUVCUFFITkQ4S2VScGpRM1dY?=
 =?utf-8?B?QWN1eVF3c2xWbGg3OGYxTmJwQUt5YzVWSTRVeFlxSmJnQzY0ZE5mQlpaWUtI?=
 =?utf-8?B?c21UOG9hN3RpNGdVaE1DWWIzMVhiQWxXM24xQUJTOEd6K2FvWWxxUkVQZmRO?=
 =?utf-8?B?aWc3TEc0Ryt3S3JNMlFIaVdoWVM5KzEzSmh5V0NUcStlOFZ5MXFZZDd3amVj?=
 =?utf-8?B?SXZGOFFDeUt6STZmUS9BNmx2NE1IQzVIeHJqbXJkbUpodGlsZDM0YjJMTFYz?=
 =?utf-8?B?cmp1dFozREx0RTYrT2hDSGx3MytlN2p5OG1wTStSa0hSOXk2bEhucWFYSmRl?=
 =?utf-8?B?bmFKRUI2c3Fjb2JNSTEzMmVOT0MvQ3duVHpyaDgzTDJXcHdqTjQwdkQzNlpR?=
 =?utf-8?B?ckpxaDUraUltS3RzTlpkZFBRVCtDRFNtZmlXQ1dwd09FSnZuNHhiblUyV2VU?=
 =?utf-8?B?dUdlS2h3SHpDci9RTTMva3dQbTcxdWdMb3A2ODRBVDdvZjA4K1J1WFJhRDd6?=
 =?utf-8?B?UE5tRmFwN3VWM3JraG9YWUVsM3RweGdZdEw1dE9NcThWWHNJcTdFcC90MTlq?=
 =?utf-8?B?R0wvT0ovd0ZTaFQ3bUhEcldSM2dkUS9MeEc5ZlBJOE5uT1FLWEFMV3l6TEE4?=
 =?utf-8?B?VkVmODQ4MUNmbjdhRkkrblpJR0V0SnNDR2c1NmFDZG5WVkFPN0tFODN4RENj?=
 =?utf-8?B?UU84cDBNMU9ybjJ1NUhmM0hUQ2RpeGRnM2ZkT25rN0xwaW0xV1g3UjVPZVFm?=
 =?utf-8?B?UWxDL295cDZ6dVJUVVBXN1Q3enpOc3BKdmYyVE05RTNVOXN2SDJQZHhzbWJl?=
 =?utf-8?B?ekptY2JZMXFMZDBLYlRoOGQyNm81MlNyeWVXQjlRM2RDWXM0VXRXSjB5TjVK?=
 =?utf-8?B?WE5TaWxtcFZoZWRXOEYwSmJTbGJaQ3B3Y3hId0pnYncxeUFYKzYweWxQYytt?=
 =?utf-8?B?NFhuajlzTGZQQ2p6VmZzWDB2ZDRLSHZQVjJ5Rm1NeHZ1RnkyUHRVNzVFcEFz?=
 =?utf-8?B?UUUzMWZLczFSbENBdmMrSUlHd0xCZW1HRHdwTFFSUVBjN05Qa2N3RWt1Ukp1?=
 =?utf-8?B?SjhMRVd1dXBWdEs2bkpQTHplUlNSUUlPUFNuUVRpdnlQMFc4VW02V0hkV3Jv?=
 =?utf-8?B?bjZZTmZ6VUJGTWpnNTRwMEtYaFFGM0t5TUtXZU10LzFEY2YzQU9NaTcwUW1q?=
 =?utf-8?B?TUxVTjF2MGgvYWdSSXRTUnlEMzZEUFNGN1N5dEd6dkN6MzBPbU9JYzNaMXBr?=
 =?utf-8?B?OE1YYjFmVGJzbWY1Mi8yUmtPME1yUCtjS2pQV1FoZ0svL0h4QnFCWnR0Z0Mx?=
 =?utf-8?B?bjJEbkFNczdiSEtmUXZWSUI5YktXOFV0UENHVjRPaDVsOHlhUmo5RmRkMEJ6?=
 =?utf-8?B?WTN5VzRpV0VIWXlRU2hWM3R2TEY3d3RpeUlBYS9oTkg0T3JXRHdRSGZiQ1RG?=
 =?utf-8?B?OG45UnVXTDlIT3NJb0Y4LzUwWndxWXBsUkRMZGN2R2dpNE9QVHVPcTNla2N4?=
 =?utf-8?B?VmZUWHZXbklZaFg5ZkV1eU5jT1lPeXNHMHNROEYzMEhXeHJRTHlVbkhjNUVJ?=
 =?utf-8?B?R2p2SlVkOVd1T2tneVo0cldzRFgvVUxwVk9LNEQybjl0VDNoNmhWRzZYNEZq?=
 =?utf-8?B?bDJ2V1UvUUo3bTBublpMQlFOTmhWR3VUNmFZL3JyOXV2QnVEdE9Xb2o1Q1hV?=
 =?utf-8?B?c1VIVlZhM1FNdkFDbUwwQzZkTXlVKzhVUWNMS1cxTWFiTElmRzhwSG1Hc0cw?=
 =?utf-8?B?MTI4ZXNrOSs3MXJnN25aTGFnZW9LbUhOaExWb2VmTTBwL0NIT1F2VFdhclRm?=
 =?utf-8?B?TUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A968ED39F0D32C4CB3889C0A3DC2A681@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a617187-979a-4e99-a50a-08dc9d0552d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 15:15:36.9374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nwG8KFP1VhaU4ExfSUYtymPlovmUTrVEdZQCweCdxBmp3RZEMvY5bgjmY9NxjCiYY9Q/Ge+DcZfRll3dGfex1mbapVGJxK7u12S73P006HA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6205

SGkgT2xla3NpaiwNCk9uIEZyaSwgMjAyNC0wNy0wNSBhdCAxMDo1NSArMDIwMCwgT2xla3NpaiBS
ZW1wZWwgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiAN
Cj4gQWRkIHN1cHBvcnQgb2YgMTAwQmFzZVRYIFBIWSBidWlsZCBpbiB0byBMQU45MzcxIGFuZCBM
QU45MzcyDQo+IHN3aXRjaGVzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogT2xla3NpaiBSZW1wZWwg
PG8ucmVtcGVsQHBlbmd1dHJvbml4LmRlPg0KPiBSZXZpZXdlZC1ieTogRmxvcmlhbiBGYWluZWxs
aSA8Zmxvcmlhbi5mYWluZWxsaUBicm9hZGNvbS5jb20+DQo+IFJldmlld2VkLWJ5OiBNaWNoYWwg
S3ViaWFrIDxtaWNoYWwua3ViaWFrQGludGVsLmNvbT4NCj4gLS0tDQo+IGNoYW5nZXMgdjI6DQo+
IC0gbW92ZSBMQU45MzdYX1RYIGNvZGUgZnJvbSBtaWNyb2NoaXBfdDEuYyB0byBtaWNyb2NoaXAu
Yw0KPiAtIGFkZCBSZXZpZXdlZC1ieSB0YWdzDQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvcGh5L21p
Y3JvY2hpcC5jIHwgNzUNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0K
PiAgMSBmaWxlIGNoYW5nZWQsIDc1IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL25ldC9waHkvbWljcm9jaGlwLmMNCj4gYi9kcml2ZXJzL25ldC9waHkvbWljcm9jaGlw
LmMNCj4gaW5kZXggMGI4ODYzNWY0ZmJjYS4uYjQ2ZDVkNDNlMjU4NSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9uZXQvcGh5L21pY3JvY2hpcC5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3BoeS9taWNy
b2NoaXAuYw0KPiBAQCAtMTIsNiArMTIsMTIgQEANCj4gICNpbmNsdWRlIDxsaW51eC9vZi5oPg0K
PiAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL25ldC9taWNyb2NoaXAtbGFuNzh4eC5oPg0KPiANCj4g
KyNkZWZpbmUgUEhZX0lEX0xBTjkzN1hfVFggICAgICAgICAgICAgICAgICAgICAgMHgwMDA3YzE5
MA0KDQoweDAwMDdjMTkwIC0+IDB4MDAwN0MxOTANCg0KPiArDQo+ICsjZGVmaW5lIExBTjkzN1hf
TU9ERV9DVFJMX1NUQVRVU19SRUcgICAgICAgICAgIDB4MTENCj4gKyNkZWZpbmUgTEFOOTM3WF9B
VVRPTURJWF9FTiAgICAgICAgICAgICAgICAgICAgQklUKDcpDQo+ICsjZGVmaW5lIExBTjkzN1hf
TURJX01PREUgICAgICAgICAgICAgICAgICAgICAgIEJJVCg2KQ0KPiArDQo+ICAjZGVmaW5lIERS
SVZFUl9BVVRIT1IgICJXT09KVU5HIEhVSCA8d29vanVuZy5odWhAbWljcm9jaGlwLmNvbT4iDQo+
ICAjZGVmaW5lIERSSVZFUl9ERVNDICAgICJNaWNyb2NoaXAgTEFOODhYWCBQSFkgZHJpdmVyIg0K
DQpuaXRwaWNrOg0KSXQgY2FuIGJlIHVwZGF0ZWQgdG8gaW5jbHVkZSAiTWljcm9jaGlwIExBTjg4
WFgvTEFOOTM3WCBUWCBQSFkgZHJpdmVyIg0KPiANCj4gQEAgLTM3Myw2ICszNzksNjYgQEAgc3Rh
dGljIHZvaWQgbGFuODh4eF9saW5rX2NoYW5nZV9ub3RpZnkoc3RydWN0DQo+IHBoeV9kZXZpY2Ug
KnBoeWRldikNCj4gICAgICAgICB9DQo+ICB9DQo+IA0KDQpBZGRpbmcgZnVuY3Rpb24gZGVzY3Jp
cHRpb24gd2lsbCBiZSBnb29kLg0KDQo+ICtzdGF0aWMgaW50IGxhbjkzN3hfdHhfY29uZmlnX21k
aXgoc3RydWN0IHBoeV9kZXZpY2UgKnBoeWRldiwgdTgNCj4gY3RybCkNCj4gK3sNCj4gKyAgICAg
ICB1MTYgdmFsOw0KPiArDQo+ICsgICAgICAgc3dpdGNoIChjdHJsKSB7DQo+ICsgICAgICAgY2Fz
ZSBFVEhfVFBfTURJOg0KPiArICAgICAgICAgICAgICAgdmFsID0gMDsNCj4gKyAgICAgICAgICAg
ICAgIGJyZWFrOw0KPiArICAgICAgIGNhc2UgRVRIX1RQX01ESV9YOg0KPiArICAgICAgICAgICAg
ICAgdmFsID0gTEFOOTM3WF9NRElfTU9ERTsNCj4gKyAgICAgICAgICAgICAgIGJyZWFrOw0KPiAr
ICAgICAgIGNhc2UgRVRIX1RQX01ESV9BVVRPOg0KPiArICAgICAgICAgICAgICAgdmFsID0gTEFO
OTM3WF9BVVRPTURJWF9FTjsNCj4gKyAgICAgICAgICAgICAgIGJyZWFrOw0KPiArICAgICAgIGRl
ZmF1bHQ6DQo+ICsgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4gKyAgICAgICB9DQo+ICsNCj4g
KyAgICAgICByZXR1cm4gcGh5X21vZGlmeShwaHlkZXYsIExBTjkzN1hfTU9ERV9DVFJMX1NUQVRV
U19SRUcsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgTEFOOTM3WF9BVVRPTURJWF9FTiB8
IExBTjkzN1hfTURJX01PREUsDQo+IHZhbCk7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgbGFu
OTM3eF90eF9jb25maWdfYW5lZyhzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2KQ0KPiArew0KPiAr
ICAgICAgIGludCByZXQ7DQo+ICsNCj4gKyAgICAgICByZXQgPSBnZW5waHlfY29uZmlnX2FuZWco
cGh5ZGV2KTsNCj4gKyAgICAgICBpZiAocmV0KQ0KDQpJcyB0aGlzIGlmKCByZXQgPCAwKSA/DQoN
Cj4gKyAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ICsNCj4gKyAgICAgICByZXR1cm4gbGFu
OTM3eF90eF9jb25maWdfbWRpeChwaHlkZXYsIHBoeWRldi0+bWRpeF9jdHJsKTsNCg0Kd2h5IHdl
IG5lZWQgdG8gcGFzcyBhcmd1bWVudCBwaHlkZXYtPm1kaXhfY3RybCwgc2luY2UgYWxyZWFkeSBw
aHlkZXYgaXMNCnBhc3NlZC4gQWxzbyBJTU8sIHRoaXMgdHdvIGZ1bmN0aW9uIGNhbiBiZSBjb21i
aW5lZCB0b2dldGhlciBpZg0KbGFuOTM3eF90eF9jb25maWdfbWRpeCBpcyBub3QgdXNlZCBieSBv
dGhlciBmdW5jdGlvbnMuIA0KDQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBzdHJ1Y3QgcGh5X2RyaXZl
ciBtaWNyb2NoaXBfcGh5X2RyaXZlcltdID0gew0KPiAgew0KPiAgICAgICAgIC5waHlfaWQgICAg
ICAgICA9IDB4MDAwN2MxMzIsDQo+IEBAIC00MDAsMTIgKzQ2NiwyMSBAQCBzdGF0aWMgc3RydWN0
IHBoeV9kcml2ZXIgbWljcm9jaGlwX3BoeV9kcml2ZXJbXQ0KPiA9IHsNCj4gICAgICAgICAuc2V0
X3dvbCAgICAgICAgPSBsYW44OHh4X3NldF93b2wsDQo+ICAgICAgICAgLnJlYWRfcGFnZSAgICAg
ID0gbGFuODh4eF9yZWFkX3BhZ2UsDQo+ICAgICAgICAgLndyaXRlX3BhZ2UgICAgID0gbGFuODh4
eF93cml0ZV9wYWdlLA0KPiArfSwNCj4gK3sNCj4gKyAgICAgICBQSFlfSURfTUFUQ0hfTU9ERUwo
UEhZX0lEX0xBTjkzN1hfVFgpLA0KPiArICAgICAgIC5uYW1lICAgICAgICAgICA9ICJNaWNyb2No
aXAgTEFOOTM3eCBUWCIsDQo+ICsgICAgICAgLnN1c3BlbmQgICAgICAgID0gZ2VucGh5X3N1c3Bl
bmQsDQo+ICsgICAgICAgLnJlc3VtZSAgICAgICAgID0gZ2VucGh5X3Jlc3VtZSwNCj4gKyAgICAg
ICAuY29uZmlnX2FuZWcgICAgPSBsYW45Mzd4X3R4X2NvbmZpZ19hbmVnLA0KPiArICAgICAgIC5y
ZWFkX3N0YXR1cyAgICA9IGxhbjkzN3hfdHhfcmVhZF9zdGF0dXMsDQoNCkRvIHdlIG5lZWQgdG8g
YWRkIGdlbnBoeV9zdXNwZW5kL3Jlc3VtZSwgLmZlYXR1cmVzPw0KPiAgfSB9Ow0KPiANCj4gIG1v
ZHVsZV9waHlfZHJpdmVyKG1pY3JvY2hpcF9waHlfZHJpdmVyKTsNCj4gDQo+ICBzdGF0aWMgc3Ry
dWN0IG1kaW9fZGV2aWNlX2lkIF9fbWF5YmVfdW51c2VkIG1pY3JvY2hpcF90YmxbXSA9IHsNCj4g
ICAgICAgICB7IDB4MDAwN2MxMzIsIDB4ZmZmZmZmZjIgfSwNCj4gKyAgICAgICB7IFBIWV9JRF9N
QVRDSF9NT0RFTChQSFlfSURfTEFOOTM3WF9UWCkgfSwNCj4gICAgICAgICB7IH0NCj4gIH07DQo+
IA0KPiAtLQ0KPiAyLjM5LjINCj4gDQo=

