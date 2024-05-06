Return-Path: <netdev+bounces-93740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E208BD078
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 16:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3321280EC4
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 14:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD371534E9;
	Mon,  6 May 2024 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PefvTSSy";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fSgVhlNV"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8541811FE;
	Mon,  6 May 2024 14:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715006443; cv=fail; b=sLhX7wgdKFk33Nz5J4dHylzAp4zKu40ZnSAwrLOekbNTj0uLcYgUKWcbJKJjgE/04BvtRTl0+A6rfdqZ103cQdIoBFnc0JHsUxu9Kgwq4Dh4BXJh5DJIzCupvs6M/MGTriyuvjagazhylmG4ZrJm5b0lW9dJxmlhItVpQ/+JkMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715006443; c=relaxed/simple;
	bh=pIPMmjoMjSCFR+ZF7Imfb0WmQcPm00IBp7cYmnJBuyM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bpxrG81btsZ+df3NHcU6ETHNG8AYhepdjC456L8N5YrJLpghOevg+XeG7KnZYhqWcc+gdK7DJdHimcd59kW9jOyPZH43ol2EuKQHXOF3eKNMltiLXOiPMkWMkQzGYMnPG4XLQG4bVWYd4tKd6NZR+q+q2CnuvjR9kVv67UnbXzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PefvTSSy; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=fSgVhlNV; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715006441; x=1746542441;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pIPMmjoMjSCFR+ZF7Imfb0WmQcPm00IBp7cYmnJBuyM=;
  b=PefvTSSycLJPWTu0q+zIon9MMd51XMH2So5j8zS9x/5XLDv3k9e0CaQc
   es664XIPGWUj2woXOYmJQ+ftChxx7i5rWH8CajWWmUO+vt3wMyPlP5Lne
   qMv3QS8skCxfQJWoEBCOjJoyD/uTyD6aceI0JJMA/HAG5wL2LbvEkj3F4
   jna+TUSkP7eaz7lGtyR+0i5MBckJJohEkUJR+cRLkiI13M3YXChHSBcQQ
   EHaksjRCFBeZCWtSS/J/K49pmFLry0dIvmYhsAy3igwZNhsJJiGAaoW19
   loo9rckzND29AepABYqSf7B2U/1gO/VzNLjahPO4l/mT88oU3cz6h6lKZ
   Q==;
X-CSE-ConnectionGUID: PwOd5NQoS3GbVzFV2X8ihA==
X-CSE-MsgGUID: gk+WQOZzQnax2jWBsWHbPw==
X-IronPort-AV: E=Sophos;i="6.07,258,1708412400"; 
   d="scan'208";a="23796079"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 May 2024 07:40:34 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 07:40:20 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 6 May 2024 07:40:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hUSJgA3R4fawMvren4H9wTIGWxMFdPVh7H5PpsqmOLXKsw01n+Bfj/il4zlMXPwzjkYuhdmYQVebgpfDTqj8P3sw8eDItWn8yN1oyMD8yQ5Y3pvl5BcsUtksWIgJCjUUpXpm2vdXz0KaptludXqSoZK0L2Nw6oK2c708sHKk9rmfup1vQvCZhwAqTRBjMb/5vleINCR8qyEJdsJE0TTG1OkK8ab93M0i82xbeWz2cVr9mQ0QyMWlM8i5fXa0Jq9Y4VAMyRRty34x/MiBk9IyyvJe9/9uxM0b5XsT6XsURHMJmlxelZtC8+S0YgdYoG5e7cWzHz0//kCdcT2i0Cil1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIPMmjoMjSCFR+ZF7Imfb0WmQcPm00IBp7cYmnJBuyM=;
 b=TV/2WPnlFy0Kuav1dJNXPh8IJi0/zNHjO3PfP8D8h6i8VIE1IyjnLpgTQmpr5/nVQRzdvCOG5uJ3tTpF8veUWdN0n6UHtC6Js0ThDPG3Ay3sP+D47wvnLOySfENYXwS+d/AklDfQU8abIhRX26FOinnHI2tsrhm7Z6jzNM6EMw4FbzzOV3aFyAblJMG6yVcPqM299P3glx/qngkbtsRllbPbrO+rxSu+Shg5muJOQWthCv6vZhd+A5qCJ13VMTXB3d+JDADEWsl5BwU8PoCDPmdcRW/eGghcDrc7XUHlr8gSth6MhNtj3yPRtaSsdYO5UL/f0iNZ4hwXFk4d6IBgmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIPMmjoMjSCFR+ZF7Imfb0WmQcPm00IBp7cYmnJBuyM=;
 b=fSgVhlNVfHb3ssLUJumS3KjPbQVvhQ90DwxKoj1cMoNJtPZ66wKdD90UwtwG3bjbDFb7b2TVJh3VWznGGXm6sr70otU4zDaqINvhmcWE3tYLbpmJC7stdoEqPcMA0aidbg6e9U+GGxws/cW1BVQWN5gkW9juUVBikOrE6TOJEZedgLDHUOJ/4xeksm1ZREZSesj++VQgXgDBxvv1+9dPV0JTtTQ0uS9cWky/6GQTdnHyMyzc//xewRxNrqf4NeNxKvlX6ArOjtWEj3SRctMrkUsWUcNFqWMAA4XSxTJKFJq8Vc8p131r4yMqraNSxszhDbPjzC4GEbALTJXai6vHAA==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by SA2PR11MB5194.namprd11.prod.outlook.com (2603:10b6:806:118::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 6 May
 2024 14:40:18 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c%2]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 14:40:18 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>
CC: <kernel@pengutronix.de>, <dsahern@kernel.org>, <san@skov.dk>,
	<willemb@google.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <horms@kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next v7 08/12] net: dsa: microchip: init predictable
 IPV to queue mapping for all non KSZ8xxx variants
Thread-Topic: [PATCH net-next v7 08/12] net: dsa: microchip: init predictable
 IPV to queue mapping for all non KSZ8xxx variants
Thread-Index: AQHanVvgXsKMDmqmN0aLo+5ceIvItbGKTGoA
Date: Mon, 6 May 2024 14:40:17 +0000
Message-ID: <d4b566e268be215a4dcf0872dc56c75c690369b1.camel@microchip.com>
References: <20240503131351.1969097-1-o.rempel@pengutronix.de>
	 <20240503131351.1969097-9-o.rempel@pengutronix.de>
In-Reply-To: <20240503131351.1969097-9-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|SA2PR11MB5194:EE_
x-ms-office365-filtering-correlation-id: c30d4257-0044-4bc2-323c-08dc6dda7303
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?VkQ5d2pBM2tya0FDVFNPaVlCS2N0aVdwRnNwSm40NzBpNnZwMldsR3BPMUFq?=
 =?utf-8?B?SWxUaE9VN1MvelljUTNMdFdTeXBmMDdnNzFnWk1pTFFhSnpaMkFyV0orbFYw?=
 =?utf-8?B?aEJzaFMvb3dmU08zNzd5MStzYk5OckxsRTYvc3VXSVkxc2JXUWFGbW80NXVV?=
 =?utf-8?B?eFpRNUkwZTRTZUR0c0JLVUd1YThoWmNpZlNYbWladGtQbUY4ak84REQrb0Y2?=
 =?utf-8?B?SThTSkRxSWl2b0VhL2FHZHN3U3NKanRhRmtqTjVwZE8wYmcvYzZPdlNZTVFq?=
 =?utf-8?B?emVUamVKZjFaTWptdlIydU9zQ2xDNzlEV1dqcXpReGVSVlpjK1I2cGd4ZzNT?=
 =?utf-8?B?eHA3eFMyYzlBYTZia3VYb1pGODFDVjE0ZUJUL2EzcE4vWmY2OVpLSzljamVB?=
 =?utf-8?B?Vm1oUlRCditiR2lLbEhIY1VDRENiUHpvUTZORThjdUdWODZVUEJkekhkbEIx?=
 =?utf-8?B?ZzJ3UmhRWnAvbVVLYWRsemFBZDlhZ3EwRVhDWkRRb0NtRXFMQXRIOFp2VVhF?=
 =?utf-8?B?RHdhZWxQNE5pT1FRRGV2SllnZDRwTXlNOGx1QWFMVGhrSzVrUnJocWttdE5W?=
 =?utf-8?B?SDU2eGVEOEFvNTc1VERGRjhhS09SbU5QWVZvc0ZKS2JxaTJJL29vRVQzSVVh?=
 =?utf-8?B?TXgzZlVnaHFxM2hnQ0Y1Q0dSRWFQMUJ2eXJYUGFuVDVmckhQNjl6K2pWR3lY?=
 =?utf-8?B?Q0JoekJZenVvYlUza2g5bTQwY1NFT3VEd1ozT2EwTmw3TFdQTUFiVmVORUdv?=
 =?utf-8?B?ZjlDcCtXcjRxbG1WdjZ0R0pTTWtzRXhESmFzcXdVUm9VV1M0ZXhIa2U0VnV2?=
 =?utf-8?B?QXFQSXQ1NEt6TDNKTXVhRkN5RW42bmwvS1FCaEowRG45T3NkZHBDcEcrdDlV?=
 =?utf-8?B?b3FZZGxtN3R3MWd6UU4zamxLNVY5SHVoVU1MVjVkZEg5bXR3WFVCODVFYVcr?=
 =?utf-8?B?YU9adi95eTJrYW5FT2d4RTc1WWU2ZmZRS1lraGZ2bGhvaStuNVlxZ2o2S1VG?=
 =?utf-8?B?T2lyT2I5STkxNGNhSnNvditYdkN3UnNDUTRNMStGWHFOYlFNYnNrcWlkeDky?=
 =?utf-8?B?azlYeVFYdlZCVnduT1hoamVBOHRSbytERVhBNVRiUDAxT3ppYmNwU00xdGhY?=
 =?utf-8?B?RHZmV2p6aEFrZEkwcXpmd3lPKzh2cEJNWG9KdUd3MnRhZFg3MW9Bc0t2ZXVM?=
 =?utf-8?B?SEpDY0RiTkZvc0JBVyt3WHE5YWxOSnJORGQ0OGczYkJqN2RqMDVuRnBya3NZ?=
 =?utf-8?B?aEFKclNIMWFjQmhOSWFzZHNsd2c2L2pBQWlEekI3M085YUdUdEhDVWdDNTho?=
 =?utf-8?B?djZtdkJrOUNXc296OWRIcDhlbmdOeFNhT2ppU0t2ME43MjNOR0dWN1cwZWlY?=
 =?utf-8?B?QWxFbDFFUmdQcW12cGdjZlppdDZzMkMwQzQ4S2RJU0xkdiszQ2J0dkhacVVm?=
 =?utf-8?B?MVRDc0JQVDJMZkFucDZTZkNBNnpwRUR6RFRCdGRlbFRGb053bERVeEpxZVZs?=
 =?utf-8?B?T3ZydUo4UDhNL0JQakpCWGRETENsSjlZMmRsK2tDT0lZL0tqNFdtckMxcUxa?=
 =?utf-8?B?cGdzSlo1VFFrRmprNXFHN29xNnQxNU9zLzlmTGU1bWlwcEptZ0NYdFU1TXVH?=
 =?utf-8?B?TDJNcHZ2eThMbllYVlI3K3pEMnArYlpPaHVDam5vK3hDVzFBay9Vb1BPRjNj?=
 =?utf-8?B?TXRReWovVDJpNUc4M2NHY2I0YVpSVEREYVJsQW52WnJzb2w2bFBKNkZhVkl4?=
 =?utf-8?B?MkRtNFpveGlZY0lja3BYY1l4WGNBU2cwS1hSaFdzRUY3c0dTV0d6blVPcjhK?=
 =?utf-8?B?RDA2N1ZNVW83Tmt1YmNlQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnV2aERwUHR6N2VJcE5nMnc2aGE3MUtoRDNHeDhPTnlSK3FYTXRWWFdMc3dD?=
 =?utf-8?B?Y3BXT0dBVE1OZU5Ed25qc21jWVRKQk5zV2NSTm8rMmtpc1p5MXMvTS8rZGp6?=
 =?utf-8?B?R0lHNnZ3MmtEM1NnRStVa0l2QTI0c01kREdqQkpmeVNOQmEzNUxrNkd5Nk8z?=
 =?utf-8?B?UWxEMVQ4WFZkTWdEcUVjTE1PRWsybjZUV3l0dlNwUmY2d0FVeUVmc2ZvVW9J?=
 =?utf-8?B?ZVlSbnJTc05mQk1uSnY4RmI5WDVXZFh3ZXo2S0trOVNVYnhKejhmbWhpN1lB?=
 =?utf-8?B?MlJydisxUk5sckZ6WXlMNTF0bG55Q2M2Z3NyNWNBOVVFcTRrZFBSVStaVThH?=
 =?utf-8?B?N3J4ZmhIbUwwTHR5RmVPOWh6MTJtR2ZKbTkrZUhWdENoVDdLM0U0aWR1UUYy?=
 =?utf-8?B?dTlydHRBcFFDbWE1OEJEVjlscjNoampORDZicTB0ZVgwSjVNalF5TlJRbW5y?=
 =?utf-8?B?RUhWL3dQQjMyS2RLS1VsMkVLTEF1TS9WcjJiZm4yL0ZtelQ2M3F4Z3c2aFFp?=
 =?utf-8?B?N3RzbXVtZWxPNEtHM2M4WDN3dDFBbXA0YnpFUkFFclkwYlBxaVZGVE5LTDAx?=
 =?utf-8?B?azVkVGMwNncyaUYxS2lzVTMvNXdpRVBEb09OUS84M0M5TGN6UTl0UzE1OHI3?=
 =?utf-8?B?Y2lEcVRkSlZMemRFTnhYZjlCcU9FNkwxRTZ4Z0dDakdEKzU3a1F0RytObEFD?=
 =?utf-8?B?Yml1SFV2WGJBY0tiblZHMExOM0lNMWE0TVJ5NnNGekZIR3BIbGFWUzNZMS9Z?=
 =?utf-8?B?ZUxUNW83OHVJaCtLekZldUUxQmMwVkdhVDZHdzJMWTFTc0VTc01mK1NQVlVv?=
 =?utf-8?B?ZytEOW9nSS9VWHdtaUFHREJTUzVEdXE0TjZJNEN0WmVCT0Q5cG04RlBjc3dI?=
 =?utf-8?B?dnkyWVZnbExMc2JSb3BYbmFUZWxOQ3R1bTVpL0NKZmtNTjNrakZ1SHVtVFpP?=
 =?utf-8?B?L2FXRmVyU3o2YkxLNklBczY4RFZoV0tFM0lnVzl1T1FQOWxMMklnOEVCdUN2?=
 =?utf-8?B?ZElaUE91aXYvS0RMeUlyN1FWUEhTL1pBWHQ2VVVNZTBKZEwrcjZmdkhOaW8x?=
 =?utf-8?B?eDluWWg1NHZQaTEvQmhCQUw2TXNyZmM5V0kvVXczbXZ2bTdNbEhDcUZ1OEd2?=
 =?utf-8?B?dXFTNmE0a2RwSDVlVHBwdE5oa3VlTFBlNVlmZTJ2QWRObWJzZlFRMmhyOTk4?=
 =?utf-8?B?K1F0WUpEUGZoejlwdDBjWTJYdTNwaExSZmYyKytJSWZMeG5uRVdEZ1I0SE1q?=
 =?utf-8?B?d09VeVh5RklDblZRN1lIVk5JYlBqQkhIRUVadzY4c3IxQjdWdTFOMWVaQlVl?=
 =?utf-8?B?YXUvMTJJeStkcjN4MlhIZEdPeldaZlkveEFVekdUblRPcUlJVXJrR1pKUW9l?=
 =?utf-8?B?VlhBbzFtSlRwYXJLNGYxZjFEeXpESWV0cFRhSzZ2cVZUeEtmeEg3Y1Y5QTZ4?=
 =?utf-8?B?emZCOFZ4K2dEWUl5Y1pJejMyT1lzYkxpTkpSOCt4RzkrMjZiZFVWMXVnNmwy?=
 =?utf-8?B?Wjh5aDV1VjVkWXRkSUltWGZUNjVvZkplNVhuSTh5aUxiUjVTWi9rR1htbWF5?=
 =?utf-8?B?d3pwVXpjRHdZaCtGQ1VPM1QrWnFMdk9aUFRsUVRySklZVFRXMWVHVnNocEcx?=
 =?utf-8?B?VCsvbGcvTFVMWUhDSEZvQld3YWRvMkFSRlJjWlhvSEtCOCs1WkFkcVY3Z25Y?=
 =?utf-8?B?bktSdklNeDRyQnhZSk1Rclc1Tkpqd1BPdTJrSnZCRUk0L2NPdlRBdDhUOU1t?=
 =?utf-8?B?amxGdzQ5SkI4bzY3T2FiLzdwVVJNNVZSY1ZBZ0hJN1pFKzUxT0t6QU1uUnA4?=
 =?utf-8?B?U21FVW0zZmh0RW9DTkVNUlhDdlFTVitQN0tGOGc0Mm5rRFRldndnL1dYUVBn?=
 =?utf-8?B?eEEyRnZXVlRhN25Cakg1YU4rVFpKKzFhazlnRFNTcEk0ckRkR1FUcG8zRWkz?=
 =?utf-8?B?NWVSZzJveG1pUXlFNURDbTZsZlZlWHhvclJVOTczNDdKdkhQeC82Wm00MVdD?=
 =?utf-8?B?blVhRjBNUXQ2NTNVV3I5RjcweE5hdk9sYnJKbXFHUStRd0ttYTlrZStTdDQ3?=
 =?utf-8?B?a2M5ZnlML0I0MHY1LzJDc3hFQk9KellsaWp5c3JiQU9VTFdUcVluMGphRHlO?=
 =?utf-8?B?OFlEVW1acHoydkcreTRlMmhtWHNvMTM2eVlJSVZobzdnN2FVbitEbUlkeFJ2?=
 =?utf-8?B?TVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE8FAD1B17FFF8418C3B7AC19A1B946F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c30d4257-0044-4bc2-323c-08dc6dda7303
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2024 14:40:17.9243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bx0itZHAQlq440usVWAo2Kz4lyWnKsVkcNQH3Cwfh9rypcDu0lu29VkXBlGicfa+qBGJswc4+hfkgmsOMbxPtuXP+0FoEXFeL3WSpLj+7dQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5194

T24gRnJpLCAyMDI0LTA1LTAzIGF0IDE1OjEzICswMjAwLCBPbGVrc2lqIFJlbXBlbCB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBJbml0IHByaW9y
aXR5IHRvIHF1ZXVlIG1hcHBpbmcgaW4gdGhlIHdheSBhcyBpdCBzaG93biBpbiBJRUVFIDgwMi4x
UQ0KPiBtYXBwaW5nIGV4YW1wbGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBPbGVrc2lqIFJlbXBl
bCA8by5yZW1wZWxAcGVuZ3V0cm9uaXguZGU+DQoNCkFja2VkLWJ5OiBBcnVuIFJhbWFkb3NzIDxh
cnVuLnJhbWFkb3NzQG1pY3JvY2hpcC5jb20+DQoNCg==

