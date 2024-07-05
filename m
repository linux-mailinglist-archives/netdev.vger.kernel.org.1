Return-Path: <netdev+bounces-109517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44366928ABE
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 16:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC646283C44
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 14:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC29166318;
	Fri,  5 Jul 2024 14:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KmOtSRdJ";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Ehbx43xI"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E01146A8A;
	Fri,  5 Jul 2024 14:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720190017; cv=fail; b=hd8YV4mn9OzSo6qwM+e+7aEi/VXkeqCfY24NnGsAU17StNiHcetBIVCnlB9n+6hKkEktYwIhgRGhgTOq/sExhf83B3okOG/Q6vWJ4uo62XkIIwY/36uCNvJ9EwjBj2+Ok4FVfzJ60LBrNei+Z2tx/AqOwMfWR7Xno7AIsCrWAy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720190017; c=relaxed/simple;
	bh=BEHwSnxPzaZgT7dWNHOCbRItraWUP3gpInP3o6ouOlw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O5rDAGxcrUpsqVkHGI16UPo2zYovalD51993sgtP7gUggoFBuk58QQvA62R3FlGdBF5y6yDiI+rpen16a2ZqEp9tOd5JKHPcd1k1TlmT7uJPZrUiNWw9ODkBxMkXQGxtaFdu2n/fzo7OBovdQ3Ia9k4CthjL7rcuCINUdHxTBPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KmOtSRdJ; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Ehbx43xI; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720190015; x=1751726015;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BEHwSnxPzaZgT7dWNHOCbRItraWUP3gpInP3o6ouOlw=;
  b=KmOtSRdJ7k5b9BA59d+5BXk7LjmG+EeaAj+R1t1N+9ukzV129bp48G+u
   eEzi7xg6geEo6liwyROo7G+1W7nB6dz3hzkfidmxYWwUgUPOFge3nJSTW
   v2SM0VqtPsUK8/9uqwV26snIjWDQp2ELw7RER7uKu+10owteZdZzi41xe
   QC7h8ETpmkV7JQcW4zaK14fYIJvHtOzCVRnT/1RfKZdSjcVt6Fitgwsyk
   OH0DrC8q3pSTMDsP1RO0OzjdVjoNC5wrD2KAYkmU8KU26YxhnxGaILin3
   OPbA2hxY9ZW572kKH470xcOxHIaIvFNq0QGfQQEvNjXL3MnKEAtmBH8U5
   A==;
X-CSE-ConnectionGUID: jwpyOECDTrmFVJ/wySGXqg==
X-CSE-MsgGUID: 1O6ObmpBSGG9eco5S2oLEw==
X-IronPort-AV: E=Sophos;i="6.09,185,1716274800"; 
   d="scan'208";a="29529862"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Jul 2024 07:33:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jul 2024 07:33:13 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Jul 2024 07:33:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RpNtLksxAr1Ff+4K6R2xiOKHrnyVp4uAvUEsDTPckvDoM8V3qPxsIs32lJDS9yzZ1edEFQ0x7pzBoSBBq1zyywFXdOmvD/Hj1kUMjQgxlHO221vrKH3tPFWBanbRK7uS0PxfM/hjnSmC/GNv4xetIyK2EGBrw+f70zHqvlvRxcIMjiNdxMP3Zq+wAKsSCj/hh8V5IFvNX+Zee60NudG6gEWQ/RdD8ZBUFJBsqA3ybbW36jn5Wg3995MAc5aUtXea28af/sbeZ+QEkf/V9CQRng8D7sxOML6qiwWwgFRt21QOFBO5BICzX8hV887ViLgY/IYimPF6rDXuOrUd4eIgxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEHwSnxPzaZgT7dWNHOCbRItraWUP3gpInP3o6ouOlw=;
 b=Ql6asMiylgZABPC/GStSWVJ0VetTym3kTdzAhmTO0zU6BKoT0+S0Tv15rcVtDCnokIZ3b4t8krlErseB2VDx0+TAs6ucsgJoUQ9rX/7Y6BvZFuRnHcjzcZEwiEUxQ6Y2s8IjdH0WV6cm/s5LKPlpP4N/8UeJVQf0sClKAZM1NHM864Y/qMLfnW2bE3/OMfoPRr9mOredqfyGDziPOt+0aiEIyeM40HkJXNjRcTLOZ0dZuja7N7G6Pc2NH3FyGm2l1fQO40tWtGJK6L5jdqaKJEpg2M4qU8euY73mlKOMgW/EaQglha/dwKbSm7s09cyO80AkKAz9hLF5BZkpuztT+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEHwSnxPzaZgT7dWNHOCbRItraWUP3gpInP3o6ouOlw=;
 b=Ehbx43xIQQIiU55M039cNO1v3PO884U4ds1eM1FazwUG3mKUQSYqHOV4jTaX1ZhUv5iuJw08z6Omxi1/hbOyXNcSmjrvZOCEnIH0c4cM+96VrXF1U67FGPTeZ8KMkyv01xtfkWXSQNiR8LiDR/LUmwFZ8LSs9WiFxqdF9WLnsdf3Kjmw4U9w8j5d9TqkTriM98C3JBSCDeNk8lexVwj+FSbIX4pjiwEeB5PziduC9EY1YGVN2kcybiFDrqdGyN7hATbtNYImq64XPBh0xuHsxqLBVgtNRcZ3ArvGzpiTnEVZMgb5ESReW8uc0sVZjX/wHHzNNaCjBK70DR0dRBRuCw==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by IA0PR11MB7934.namprd11.prod.outlook.com (2603:10b6:208:40d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.36; Fri, 5 Jul
 2024 14:33:08 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c%3]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 14:33:07 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>
CC: <kernel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
	<florian.fainelli@broadcom.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/1] net: dsa: microchip: lan9371/2: update
 MAC capabilities for port 4
Thread-Topic: [PATCH net-next v2 1/1] net: dsa: microchip: lan9371/2: update
 MAC capabilities for port 4
Thread-Index: AQHazrgNBojpzw/Q60e75GwNw25y0bHoM7QA
Date: Fri, 5 Jul 2024 14:33:07 +0000
Message-ID: <b07fe50cefaad3a50731e943b266189f28de51cc.camel@microchip.com>
References: <20240705084715.82752-1-o.rempel@pengutronix.de>
In-Reply-To: <20240705084715.82752-1-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|IA0PR11MB7934:EE_
x-ms-office365-filtering-correlation-id: d954003f-ae7c-4c83-5331-08dc9cff6373
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WHY1Vm0xeWVBOW9Bdi85bGgzZWVTUGZoWFVrWFJ2R1pZQWF1RXJaYXVpdGh6?=
 =?utf-8?B?NW42blVLaEtmQ3BWbnVIUGRvQzB0M2dJdmJGN3dsM05iem1mZEZTeUZ1TXJB?=
 =?utf-8?B?RVpnQkFzR2tTdGQ4Z29veUxLR0srcktBVjNDdVVLUnRKZnBTeVliK1h2UW5t?=
 =?utf-8?B?V0Z5Y0R3KzZWOVlvdysyOEh3U0RMaldXbURsSTlnV0RrL2RGV0ZxdExJenln?=
 =?utf-8?B?ODY3dDd2eUFjVkx4ZDczbUFtY3BIQldBdld0VmlYTWxHV3lrcFFuOE9PRjRF?=
 =?utf-8?B?c1JFZElUcXYwYkFxNEdta2xSbFFKUU5NT3QvNCtVb1RPY1JLUS9nY1l1ZFds?=
 =?utf-8?B?anFrZUt1cElHaUN0TlVqWllOSDZmdkNjZFI1dThIaVNMTXZXMUlGM1hVb2Vk?=
 =?utf-8?B?aDhZeU0xYzArWSttdmRsWUhZOWFFYkhGQVVoblJ0aFh1SHpPNk85ZkhGdU9l?=
 =?utf-8?B?c04xZ0RaTktoYUJibnhQT2swZzVpVVQ5eEYxWVNpZUhCK21FU1B0a3dkQzB4?=
 =?utf-8?B?VnRoZGk2S2ltUkpZTGFFK3FqWlZ6NDJRdFJwM0JmSEtJS1FDTUwwRFFtNHk3?=
 =?utf-8?B?OW5NcEYxWnBIbTlxUXRIZGhkM003SXNIYVhIdmtab1o3QkpyMUZTNnZJVHc4?=
 =?utf-8?B?NlFuOWZMUjRWRWJxQ1JzT2pBazRpbDFJS0ZuVW0vSnFXeElnaVVzWU1oY2ho?=
 =?utf-8?B?cG5wSHZ3WFBBOW55YnJUUC9pMUNUVS9TdXFDSnRXdDA3Q0Fta29QVGlvdmF3?=
 =?utf-8?B?SGxFcHUzNm5sN1R5YjFKYm4weGdBSUZpSWg5TnVQZGFBQWgraVgzL1BCZzRV?=
 =?utf-8?B?WHA3ckFZb05xSVlnVW5CdFdWWnowd3lpSVNPOWxQT2RFLzI5NUNJTis4VER6?=
 =?utf-8?B?dFpWK0VabnZUSXR4bVgvUTgwZ0hqcHB2cjloc2JxRjdTRG5IMnVQOFpsZ3Vy?=
 =?utf-8?B?SmdqKzRvY0RIUk5MTWFTWUJacStXRmMxQTRNam00and0SUdKTzlEdW9UK2Nv?=
 =?utf-8?B?OVJuc0djS0dCMm53clVuMlFpUEpFd2VMenlUVFNsVVpIaytwZ2c2eUxISEl2?=
 =?utf-8?B?cWxuYXk3R3oxcWxFM3hvQ2c2cFA5ZEdlYVRjNkxmKysyakR0RnAxdGdNK21C?=
 =?utf-8?B?WjNTem1PODBiN0lOb3BXN2theGpOOXNHYWd4bnBsWGVmUG4wdXp3cVhqVHl1?=
 =?utf-8?B?RjdTRjZPbC9WZmtiZGQ4TVgvVWp5WGRHd3lpeWdZYUJyVklEWE1XVzFSQU5S?=
 =?utf-8?B?R2psd2tZZXYzcERVRnlXYTQ0bG83WmhOZThyTXZnVEFEODhqQmdQWXN0UEJO?=
 =?utf-8?B?dk5vY3cvdWxoQksrVEcvK24wazQ3MkxBbVUxWUpIaFRVc1paYjVPOGVEenFZ?=
 =?utf-8?B?OXhLZkxXVlNUVk5QMmErNVgwM25LbTZOUUY3RHVrNU5TRjA1d1g3dXF4VlR6?=
 =?utf-8?B?Yk9YckthU1hmdlRodnJvMlVHRlhOTmpCWEYybGJnczdGdjdFODhXK2xieTBm?=
 =?utf-8?B?QTdicXZ3a0l2R1JJNEFIbXlFc1FRNTltbFJsV2dNa2NEdXIzWGl0Mzc4cTl0?=
 =?utf-8?B?amdSSUJaRm8zbTJqMHloVnR3VVVLRTUrTDJwQ1hiK0Q5SWJsWVo3M3p1L0h2?=
 =?utf-8?B?RnNzZ0pmMm9QMkxZNGVXZEEra2dGS0V2VnJrWDJhNGlEblVpT0VHNlBoelBr?=
 =?utf-8?B?d3JxclZERkJHUDRMVk1oMEhhTUpXd1BmZlhJOU9neGpTN1dKUnlFcVJtMk8x?=
 =?utf-8?B?SjNhVDlmV250Tk9hQjNyMzBXUlFOTzdieXZwc1ZhTzc4Wld1cFVvclRjVHFy?=
 =?utf-8?B?bFhoOEtMZzNiRnpKQkJ0ZjM1M0ZoTkFTSzlFQkQyRGRHc0tSSHhrbFFuLzQ3?=
 =?utf-8?B?c2lwTHp2MXI2YU1QWWkraHFHeTZpT2w3cnR4VmpZZWJKaEE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEFkdU5sYTZ2ZithcEZOOHNiVll2S3l5ZFYyNTkrTlN5RkhuRkQ4SjlhVDVY?=
 =?utf-8?B?N2JibW5qdGpXNFFpTDJIaUJrbXFSKzhnaXpQbnRqbW9UQmVuSmdiVUFaMDAy?=
 =?utf-8?B?ektaYktibHRoZ1JUSWgrVkhsUmdoVU5VSHdkMkVJR1VDbXExV1FVRGdKaGpl?=
 =?utf-8?B?QkVvU1JYY1dscEk1WWNmUExUUWJiaDYwcGFjRkxSK3BpY01URytzV29qQ0JI?=
 =?utf-8?B?SXlQT1I4OUlTSlVsU2ozWktaZ08xV0xSa2l2dHJLN2lNYWhlWEhjMXpIU25z?=
 =?utf-8?B?Z3p0OUxneFAxajRHR2VtWm9GaGtEZURPdWdkUjF2bTFkOUNXeEtucEVNeFVn?=
 =?utf-8?B?MHNoU0k1QVNEOWRTczdRODRXQzB5R0JtLzNaVlRYMk1ORU5Yc1R0VnFzUFBU?=
 =?utf-8?B?emNvRjREVC82eDdxcGlsdkJRV1NCditGeEpoenNtMm1DcFE5TmFIMDZibldv?=
 =?utf-8?B?TXRBWW45VTdlZzkrVW9HamU0WnFPdlZ3ZGN3MmNzbGw2alkva2R0djlkMUJF?=
 =?utf-8?B?VGg5MU43WFV4YVZQRlFXY1ZhZVV6SHVQeithMTUyNU9KYy9rU0RMd04wUmxB?=
 =?utf-8?B?Y2haeFY0STl4Z1V6WDN1NGQ1ZUZzMHpuaktaL0oxaXNaQndEdDFLa3p2ZmhF?=
 =?utf-8?B?SjdiOGZKSTZuY21SWjh0a010RFQ4WXVhTDRLV2xjcVAvbzlsS2orZFJJanlo?=
 =?utf-8?B?Zk1qSVAydVF2VEYxRU9yWlB6YUV4YlkzRjJxM2ZsS0JzUXpkMTV1bG1Oc1Nu?=
 =?utf-8?B?M3NGWndjVmdxSXdBT0NRMDRXVys2cm9Qc1B0YlpiK3lEUFBGMzlKYythRjVr?=
 =?utf-8?B?Tjh1TjFPNEp1YUQwK2FzczJxbU1peCsweHk5L2czUlpCNGRoN08rSW00US9C?=
 =?utf-8?B?eWZoYklCY0JEQTBKOEViNEptZS9MWWgvbzVXcEVHYTBLR1J6cy80d0F2TE40?=
 =?utf-8?B?KzdZam9odmxFeUZsKzdPWGRKY3liSGQrSDFpWXdZVU82YlBmaVlteHpGTUFK?=
 =?utf-8?B?azdyWU53ejlqc1ltTWd6UVkxYllOMmRUUkZITEZCYWR1L2c5bDdjb2xtMHN2?=
 =?utf-8?B?Vy8xSEY4bEszdXZZUE5Xbm1hd1hoWHByTWUwTjMvYXBXU2hQRDZ2VGQ4N0kv?=
 =?utf-8?B?aWp4SE42MFZKS3Rod1BQdDR4ZTJnZ0ZWVGdmRVpJQXRMMzE1enFHVGNDbnRI?=
 =?utf-8?B?QjNtS2k5MXN5LzFYaGV5c1ZaNXoyS1NJZnNaSzJob1QxWjR3U3pteWFlYlNj?=
 =?utf-8?B?S2xtdXQwbStMSDhZSDl2TGtJem5vOEdQMEhHTnA1clRTMjVRS0pOZkEzeEd5?=
 =?utf-8?B?anhkMk00TE9zcXFCVTBMS1I0eE5seWNjTjdNaXRDUEFVMnkydGlDeHdnYklT?=
 =?utf-8?B?U1JmS2pJVXNGQmZMNVhCVHhhTTVXVmZ0MnFGWW1yTDJxOFdLQWZSUWlCd1J6?=
 =?utf-8?B?a1lVdGJpeW44dDUxaG85b3c3dTdkbnZQNytFM2lmd1JuaHdwRzBWNW9wb3pB?=
 =?utf-8?B?YnowSGkvN1ZGZDAzbWFuUWhyK2VVcTNPVVJVRDlLc3VoaGVISkhQSVBOeHhO?=
 =?utf-8?B?WklxYmk3T0tjYk5GVDEvL1ZxM1pNd2RXR1REN09pYzFXM3F5SUU3aGYyMVB5?=
 =?utf-8?B?VENhYjBMai9pVnlIUzZIUWtLdVdkY2Vtd0d0WnNXMlFTZGdxOFd2Q0RGSU1y?=
 =?utf-8?B?VjN2MVMyYzI2akJxc1hwNElhRFFPWTM0ckQyWEVYb041aVFCR2hnNkVHdDVj?=
 =?utf-8?B?VFc3Wk1aSGVNc0xIS1dNWkg3V2Y5NTRoRm9MNWNPdzMwRzFIV2hGb1BHWFBJ?=
 =?utf-8?B?UWVjajZFVWhZUXkzajJvaDNjYXg1bWhEYWdhRHVYS0pYcDZwUzVPbDVXVVBF?=
 =?utf-8?B?WU1GY3cyMmFLMmJLTDMvL3NJaXlyWGlqZkM1YWhxbHFHMG1wVGZBUTVqcmZS?=
 =?utf-8?B?LzJqUVhwMHdONmh5N3pGRFFCbnhKUVlHOFFPOTRKZXA2QnBTU1BZdHJyNHVl?=
 =?utf-8?B?eWVvQnVlVGRiSFREQktRSjAyNWtMUEpGN0N4U3JSLzhDT3hXcWN4OVNMM3hs?=
 =?utf-8?B?L2ZQZUNzUk5keXZxYk1lVkExZXRkYXpMUnUxSGZDV2VJVG02cDVRL0dUUmRI?=
 =?utf-8?B?ZmpRV1BsYWNjNE8rVzlDS29MYk03bEZDZ2tRZTVBVWxaNGpoV2dtcU1EN2h2?=
 =?utf-8?B?WVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <446B8C5B4453C44BB0C130E7EED64843@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d954003f-ae7c-4c83-5331-08dc9cff6373
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 14:33:07.8461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u+cxdcqFXkuXGtkMcUzAwRxAYxOCdChKGsDZ/GNp3uVHpC0dzyZ7BY4hMRsCj4I0sqZo43nGZnROSlIOGDFIw9H0WNT1g1RF79VouvVAPsc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7934

T24gRnJpLCAyMDI0LTA3LTA1IGF0IDEwOjQ3ICswMjAwLCBPbGVrc2lqIFJlbXBlbCB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBTZXQgcHJvcGVy
IE1BQyBjYXBhYmlsaXRpZXMgZm9yIHBvcnQgNCBvbiBMQU45MzcxIGFuZCBMQU45MzcyDQo+IHN3
aXRjaGVzIHdpdGgNCj4gaW50ZWdyYXRlZCAxMDBCYXNlVFggUEhZLiBBbmQgaW50cm9kdWNlIHRo
ZSBpc19sYW45Mzd4X3R4X3BoeSgpDQo+IGZ1bmN0aW9uIHRvDQo+IHJldXNlIGl0IHdoZXJlIGFw
cGxpY2FibGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBPbGVrc2lqIFJlbXBlbCA8by5yZW1wZWxA
cGVuZ3V0cm9uaXguZGU+DQo+IFJldmlld2VkLWJ5OiBGbG9yaWFuIEZhaW5lbGxpIDxmbG9yaWFu
LmZhaW5lbGxpQGJyb2FkY29tLmNvbT4NCg0KQWNrZWQtYnk6IEFydW4gUmFtYWRvc3MgPGFydW4u
cmFtYWRvc3NAbWljcm9jaGlwLmNvbT4NCg0K

