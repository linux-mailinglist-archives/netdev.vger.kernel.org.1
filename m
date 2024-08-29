Return-Path: <netdev+bounces-123122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 322FE963B93
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 08:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 566161C23DC1
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 06:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F7616B754;
	Thu, 29 Aug 2024 06:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="b78AsrfH"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20D915AD9B;
	Thu, 29 Aug 2024 06:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724912922; cv=fail; b=Cn4b75EECoeukXT0Hoiz3EaXPek3uWOyye1gHOwqEwUizImMyptFo8Qh19iIKXT/HZmVXdOrjoXIX28Duujl+SNDniq/v7fMimi+WarrLkDSPFeb/Yh8HZOjgi3p0ZV3noWc9nS5zycj7LnquXYy0FjCyFu0uHHc4hhGhY+fbZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724912922; c=relaxed/simple;
	bh=eRRgnoy1G5/WaS1vC0RG2BxZnFjhBExbWkMibpVtPYY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fUto+TwUWJXPGAiShOTY8D7O3SujIdts5Gfb2D6Q0OJENreNTVSGULMCTfEDsH5lDYwwyPz/nLQZQyOZZlSfmlsGXlJIofea0qqVocwgDLxyN1lK+prdoFO774BjgAQ1lvED6BpRNqI/GE61Q0EwWWnUAlATxItsVAzUR6/L5Xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=b78AsrfH; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47T1iIS7001497;
	Wed, 28 Aug 2024 23:28:20 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 419pvr6nwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Aug 2024 23:28:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d7LSbcEoWTguhnZQpfH2mfkQ+Afx1AfUBw5ngcyngrVkYHIipkhWOXfIzSvLjosfparfYXkqPSMzijYhmWAdycOn1v9MP15amckQnxbNdJmf7RgK2dFcsMfBApSALnFbRqbSbXzq0If/pVFPqRqG5p98vxwOyKmmBMGmyFjcZDrwALUjRdfQPhcardfEVDDsiQ4wgOCMMVjLFZjGGMpBYkUHKLf3JgwQ2P9aoELlMtQCOmUfvnnmtcKgmPmUT7LewtTv0rouddG9G1PYH7ZPB9v4QDaRIXVutAbl4nrequoHd76IjuTY8QPtQm/JJrs98bnJo/EKQ9YI1Qjab3HW+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRRgnoy1G5/WaS1vC0RG2BxZnFjhBExbWkMibpVtPYY=;
 b=TpAWU3nQECaQX5bedQQipjUr/rJUmlsKFvz46RkpVwH6GAuEkgvn6J+/969NmXIhfutFlSF6yzhWnNDzxL2g5C13iBaW4sKCsnVqZ+cA5TvO4idQTfKS8pzelI2ht9KIKfB5Jfqna1r8ttpGB4cR6zPTIkF6+3vd1XOZVbUiBF0hhCILCT21l4jMXHD24ll2IJY0rhIuEuBLEZoSDSN3nZFLwKKE+N1pF/g03gYqS3UDvb0/b7GFQGmj4oN3MIYVHTEdHM2XPdgAjYb3ERkryMfZDImrdP6zoZ5LD8wk5kZLR/yAv16po4m/ZF9CH3hG0kGWf+qfaTgKqsPhCBqO9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRRgnoy1G5/WaS1vC0RG2BxZnFjhBExbWkMibpVtPYY=;
 b=b78AsrfHqev4HVwNsdryO32tWVVRoEcNj3ntilHVIAVtieBmG/Z+R01WnrUhymAsTj+DiTjlzSYCunM5qV8xsoDN1p8NBWHrm8bzjjM89GBWUyyljKrUq6Q15faCbpm8LZWaR2reUk2P6Ltz+YCfUDsT0jV1Zml9oOt/39fuSbk=
Received: from SA1PR18MB4709.namprd18.prod.outlook.com (2603:10b6:806:1d8::10)
 by LV3PR18MB6281.namprd18.prod.outlook.com (2603:10b6:408:26c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 06:28:18 +0000
Received: from SA1PR18MB4709.namprd18.prod.outlook.com
 ([fe80::cfa8:31ef:6e1b:3606]) by SA1PR18MB4709.namprd18.prod.outlook.com
 ([fe80::cfa8:31ef:6e1b:3606%7]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 06:28:17 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Frank Sae <Frank.Sae@motor-comm.com>, "andrew@lunn.ch" <andrew@lunn.ch>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yuanlai.cui@motor-comm.com" <yuanlai.cui@motor-comm.com>,
        "hua.sun@motor-comm.com" <hua.sun@motor-comm.com>,
        "xiaoyong.li@motor-comm.com" <xiaoyong.li@motor-comm.com>,
        "suting.hu@motor-comm.com" <suting.hu@motor-comm.com>,
        "jie.han@motor-comm.com" <jie.han@motor-comm.com>
Subject: RE: [PATCH net-next v4 2/2] net: phy: Add driver for Motorcomm yt8821
 2.5G ethernet phy
Thread-Topic: [PATCH net-next v4 2/2] net: phy: Add driver for Motorcomm
 yt8821 2.5G ethernet phy
Thread-Index: AQHa+dyipQF2g3VaVUaEna8ZwMdg+Q==
Date: Thu, 29 Aug 2024 06:28:17 +0000
Message-ID:
 <SA1PR18MB47090943351773233B16C0C9A0962@SA1PR18MB4709.namprd18.prod.outlook.com>
References: <20240828091047.6415-1-Frank.Sae@motor-comm.com>
 <20240828091047.6415-3-Frank.Sae@motor-comm.com>
In-Reply-To: <20240828091047.6415-3-Frank.Sae@motor-comm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR18MB4709:EE_|LV3PR18MB6281:EE_
x-ms-office365-filtering-correlation-id: 1ee388cb-bed1-4ee9-bc12-08dcc7f3c52e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dnlZbjkrbXFzRjcyeE9hbGJoT1ltNzF6V1dLbno0bEFMR0FzbXBZbkhSNUdy?=
 =?utf-8?B?TTJCVXFicUc0QnozSjNyZTUzaWlpR3RxbWl4N0o2YzZkTkJoT3JlakNYaDli?=
 =?utf-8?B?c2l4ZWwrZzJJL3NTUXlpbXdTR3ljcUR4Ung5b2JIRWtjUko2aUJZbWxtaHNI?=
 =?utf-8?B?Q3Z3enQ2N0pTcHRzRS9kTUxuc0xYakVqeUpNbE9sVVBTQWhFQm9VaS9VNkg5?=
 =?utf-8?B?UlhBODFGbXJ6NTVkc1dIUVZsYXozcjM2dmUweHJ0OWlFcm5wemFXWkdjeXRa?=
 =?utf-8?B?V1d5SzB2MjBCTndneWp6L1l2S1dQSEplVUkyRTN6cEdyenEvV0JhZS9ib010?=
 =?utf-8?B?RnQ0bzd6TW9RYWlCaHdwd0RYaytuSW1wc29qZEZwMS94OWV3blpvdkdGSjNR?=
 =?utf-8?B?V3lpTHVmc0Q1c0pVeDJhYU56VjVPMVJuTUJtNTFnTm01OXpZTllBSXZUSDMr?=
 =?utf-8?B?Ry82SU5nTDVTWWNjMWRNa2lHRTBJV1pwYTh4ams3NXMwdy9wVkhxRVViRm5Y?=
 =?utf-8?B?V3dsazUvMUVHYmhHWHNmTzhaTGFZbW5pc3JKSTA0UDE2RVhYN25LQTdGRW1W?=
 =?utf-8?B?RnNKS2FBMHJjY0FkKzVSZGlvOUdaQTZoVVNxbTVGSlJUdEl3YlhMekZpRFBz?=
 =?utf-8?B?a3ZsZFNxZldDcFlabGpKWFRnTUJVb082MVI2djM2Y1pYMHRURDk4dEp0VEpT?=
 =?utf-8?B?TEczbVFBWCsySlZkUWhKZW1samFBa3Noa1VicHFvdGlMdE80cWpYYmdoOTlN?=
 =?utf-8?B?aVN0Y0NOSGlJYmRDWjlNWUk5K3FSbEwvTGpGVlFORUdnZTVMSnl2TEM0MlBi?=
 =?utf-8?B?K0lPeFZlQTcyeVRDdFE0dWNsN0x4ZmxMMjMxSmtIRGE1TTZqeTR1WXg4SFll?=
 =?utf-8?B?bDRyK3I5U0tzUUVuYk16anJkVEVHQWExZFQ5OVBkWmF2ZUwwVXBjOFpCM2lq?=
 =?utf-8?B?cmFnOTNCRExGZXR1WFVDbmtyVWpDOGhRTCsyUHBnZkhJbzhERnRHZEpveWp5?=
 =?utf-8?B?SzlldlRpNSthek1kYVNvZzRzTW42U2RXcU1HUllRTjI0NGZKZS9JMi9vbjVU?=
 =?utf-8?B?UlgxejRjbnVFelRSejN6aGRlTFdEcGF3WCtSMFY2SGRsQXdaTVZKRmZ0QjFS?=
 =?utf-8?B?M2o2dTVTUCtuckRNTjFyMlJtc0cvTHRhdk5tY3hUWnIvUWZBS0NIZTN5OHZs?=
 =?utf-8?B?WCtTTlVMYVJPR0o5eVV0ZisrNnhlRkhVVksrcDRNemZuUVpFR3IrNUlPdEhz?=
 =?utf-8?B?ZHZwUS9IVUV0L2hNMUtlcHM4MitqdWExL2ZseVdLZTlIYi9DbGFlWGd1bHFj?=
 =?utf-8?B?OEhTbkVYWG9EQ1gwZnhZSGpqNk14dFBRLzVUUkh4dzI5d2hqN1NPSm42RWgw?=
 =?utf-8?B?QzZYSEwwYWwxcW51MkVOU2ZSV3RoS3c1b1JCY1BsUVF1N1ZvZUpSeWFmRjZw?=
 =?utf-8?B?QkNnbC9tQm5pemNBd2tnS2drRmtiUnZBbUpWV1Nvc2lHVWZvRitPU2dudnJ4?=
 =?utf-8?B?cGZQWTVhZ1NnN3RzWmlQbkpxVG5ZQWVISnlnSUdzY2pscjZrWUJ1cEhsd0hm?=
 =?utf-8?B?Vmxiay9pcFo1UXNRci83OWlqbjZ1WVE3V3NFdWdMU3c0NlZna3RGcHZxcFZL?=
 =?utf-8?B?YXo1Z29Pa0hyVGw4bjdRYmFVcmM1YkRtK3VENU51emhjQlg1TkxheU04djFq?=
 =?utf-8?B?YzVqMzkzNTAySkNvRlFVR1lLWkkwRWkyM2t3b1h3Z1pweDN6bHAvZEg4MkN3?=
 =?utf-8?B?b0xKSkFkNGZHcndMM094UVlkSzhzSzJ4aG93SlhNYWpUZitlWXF5aHJGNUV6?=
 =?utf-8?Q?/5kLXbXyikTLHZPCSmscyNMtdu5EEhy5YKB8g=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR18MB4709.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c0NnNDZDdTBIWjVMcERvelpkUi90ZjhWNFQwTXJtT0JsbTVOMFBJVmx1UkZy?=
 =?utf-8?B?c2FhYUs0NmxhT3BHUTFyNnNEdDFLMDluRkxPSjNPTmhIbEE2UW90UDZySE1m?=
 =?utf-8?B?SHFiTWZkcE85Y2x1MkRWckY3dGFEOUJXRnBVUGJpcHJHTnlvMmRSZE92R0tH?=
 =?utf-8?B?OHYxTEVuQ2g1WVVGWDcvMC9xeUhiNjJjZDBmRlRjVlA3Z2R5Y2oyVzhLbEhH?=
 =?utf-8?B?aVJNbklyaENnUFRUZmxSWWNjWmVzZ2FKRkoraTZwdlJUS21wM2tRWkkxSm15?=
 =?utf-8?B?L295YjVUYlBlSE5mZnh6eDl3U3p4a1lJUkdURk5zb0ZQTVFqNVg2a3ZpZGhB?=
 =?utf-8?B?aW42SHFJR3dzQ0pXZUIxcC90cUF2Ky9SZmY2a21jTHE2VzJ6bmRxNWxWWFFo?=
 =?utf-8?B?TDVCNGF2ZzV3cndoU1VsUnZhM2xDRlBVaXVQWVpFMUZyczJEZE9zNFJ0eWxW?=
 =?utf-8?B?UUZtc282U2piT3RDWVA1UUFKUytjT2hMSUhFdHRMeFJ4aGFTR0R5MC9zN2M2?=
 =?utf-8?B?OWV3WHVsMVVsZGxaRWltMTZmMi9qNlJjT0gxTjV0dFhrQWpNNXdQbENJekJY?=
 =?utf-8?B?dVVNOUYyMDVGUEFTa0cyeThHMDdoS1RHWmR3V1ppTGQ1Ti9LczVvLytVdHdM?=
 =?utf-8?B?bHZvV2wrNmUxajBqWjYveXFJeGpacGlPOVNYNjVsTTZ1OHdlNjhDbVdXRVdK?=
 =?utf-8?B?cnljck5xYVk3T0RkeFRPd1p2T1VhbXVKalVzakJNNDVMKzRrbmoxT0s0WFIv?=
 =?utf-8?B?VnIxNkd3RUorN20raVFnQzMzaDJPb0NNdmJhTEt6Q1B2cnZZbHpmaWhOVjE0?=
 =?utf-8?B?NGk1QUhtNFFOOTM3bmRjeENWUG0zVEhCZFlPdnN3SmFEdXNhVUFhaEtVMU1u?=
 =?utf-8?B?eWtVTXZFVHZzQWN3Y2l3bllZNjJEK0V5cFdoK2toWDJrdk1TUGJJZ2Ztc1FI?=
 =?utf-8?B?TGQ0ZXRnLzRWMnVLL0NTOVpaZ3dGcXh2M3JxUHVPZUc5K2xlbVhSV3Bsdm82?=
 =?utf-8?B?ZFpyTXZRM04rU096akFHWllXNENXVk9vSTMwNTNFYy9ycm0vdWp6bUZXb3FI?=
 =?utf-8?B?UWZiZTQ2V0tWQkQwcER5SjM3NFdmTDlGS29xZEZpZnNWOEdlVUFsN1VTVGpq?=
 =?utf-8?B?R3YrdXhhaUQ5bDhhakphbUlYM1FmWExsUjk0UGNHV1VwRkNiSGJvRUpWS1NS?=
 =?utf-8?B?Y1hpRXIrK2daOGVHR1FOVjIwV2NLUGF5SlZsemp4UG4xT0QrN0hoK2piM2xt?=
 =?utf-8?B?SEVod0xLUzFZZlNKUCtHRTRXcWU2YTNMb0MwWFVKcmY5VmJEVUZudGFrTEdw?=
 =?utf-8?B?NUt1Z3JrSG9ZOTRNckhPakJRQkdSVnMyQjFGNHBxNTVnN05SNmltMit3clIz?=
 =?utf-8?B?LzhVanB0KzloeGdRaTlsYnFucnF4VmQ1QXdHeWp4V2o1R1hLRXl4RThuek5J?=
 =?utf-8?B?dWlkdGJrTGd0RVZtVDlzdDBIbi94TWErNGdDcXM0akNIb2lRR2FFRkVlanRJ?=
 =?utf-8?B?SEhoSnhWYmtqaUcwZVg2WWVCbng2cHdFYXlrTytlWmlQNTRndkpGd1NUM2ZZ?=
 =?utf-8?B?ZFNCWmZSVjdxOFpzT1poLzVXUTk2R0NuSUdEWW5UTmt5MWVGOUNrT3BaMGFL?=
 =?utf-8?B?cWtFdmVybzhZWEx5a01IZndFcjlrT1FXVEhxUGg3c1F4c1JGSEFRWWw4UFl5?=
 =?utf-8?B?ckR5U3lhVUEzdEhEZHFKU0dYbk02ckxQNjFDVFR6eVRlT2RONkpJU3lDQ3Rw?=
 =?utf-8?B?WG83OEl0WkNEMUF1Rng0QllaK3NFU0RQZW5QY1ZBUzN6U2UrZmxSVFJTK3Bl?=
 =?utf-8?B?TDEvMXZiSVpiTE1vYktRQUs2L2JUWjdoRDQyWGZuUjBoSlQ1WFowNGN0eVFi?=
 =?utf-8?B?UXoveCtuWjZQam5oeWUvQURVQ2IxbFhjemZvRndwZDhNNDVtenBpYkJsdllX?=
 =?utf-8?B?WGF6d3ZlOEcxcFJQa2FrTGJ3a3lHNDB3eEpwK3dLUVYzT2lhbm9FN0YraWM4?=
 =?utf-8?B?QWlhOENybklWNHhQUGh4K2M4NjBNL09XSFRXL0F0Q1VhT3JxZ1d0OWQxMENo?=
 =?utf-8?B?bnFFNU9lbzdURTYwZXMzL0I1c0dVTDhiK1RJUDRYamRZWTF2S2o0b2pSZDhy?=
 =?utf-8?Q?eAgbJz4ZNtJ67L18QVLeUVy6F?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR18MB4709.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee388cb-bed1-4ee9-bc12-08dcc7f3c52e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 06:28:17.8575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uu+BiyRiVBZW8ZDS++wkQlVOcvoDTVoJN1oX0+YMY4ioYLeNfN4pBCeP76N0ECavzI8TC/born17Ku6OyR7cig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB6281
X-Proofpoint-ORIG-GUID: Xo5mVaDOu9NHJ6IAm9tUiMtdIs-FvxiI
X-Proofpoint-GUID: Xo5mVaDOu9NHJ6IAm9tUiMtdIs-FvxiI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_02,2024-08-29_01,2024-05-17_01

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEZyYW5rIFNhZSA8RnJhbmsu
U2FlQG1vdG9yLWNvbW0uY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCAyOCwgMjAyNCAy
OjQxIFBNDQo+IFRvOiBGcmFuay5TYWVAbW90b3ItY29tbS5jb207IGFuZHJld0BsdW5uLmNoOyBo
a2FsbHdlaXQxQGdtYWlsLmNvbTsNCj4gZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29v
Z2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOw0KPiBwYWJlbmlAcmVkaGF0LmNvbTsgbGludXhAYXJt
bGludXgub3JnLnVrDQo+IENjOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOw0KPiB5dWFubGFpLmN1aUBtb3Rvci1jb21tLmNvbTsgaHVhLnN1bkBt
b3Rvci1jb21tLmNvbTsNCj4geGlhb3lvbmcubGlAbW90b3ItY29tbS5jb207IHN1dGluZy5odUBt
b3Rvci1jb21tLmNvbTsNCj4gamllLmhhbkBtb3Rvci1jb21tLmNvbQ0KPiBTdWJqZWN0OiBbUEFU
Q0ggbmV0LW5leHQgdjQgMi8yXSBuZXQ6IHBoeTogQWRkIGRyaXZlciBmb3INCj4gTW90b3Jjb21t
IHl0ODgyMSAyLjVHIGV0aGVybmV0IHBoeQ0KPiANCj4gQWRkIGEgZHJpdmVyIGZvciB0aGUgbW90
b3Jjb21tIHl0ODgyMSAyLuKAijVHIGV0aGVybmV0IHBoeS4gVmVyaWZpZWQgdGhlDQo+IGRyaXZl
ciBvbiBCUEktUjMod2l0aCBNZWRpYVRlayBNVDc5ODYoRmlsb2dpYyA4MzApIFNvQykgZGV2ZWxv
cG1lbnQNCj4gYm9hcmQsIHdoaWNoIGlzIGRldmVsb3BlZCBieSBHdWFuZ2RvbmcgQmlwYWkgVGVj
aG5vbG9neSBDby7igIosIEx0ZC7igIouIHl0ODgyMQ0KPiAyLuKAijVHIGV0aGVybmV0IHBoeSB3
b3JrcyBpbiBBVVRPX0JYMjUwMF9TR01JSQ0KPiBBZGQgYSBkcml2ZXIgZm9yIHRoZSBtb3RvcmNv
bW0geXQ4ODIxIDIuNUcgZXRoZXJuZXQgcGh5LiBWZXJpZmllZCB0aGUgZHJpdmVyDQo+IG9uIEJQ
SS1SMyh3aXRoIE1lZGlhVGVrIE1UNzk4NihGaWxvZ2ljIDgzMCkgU29DKSBkZXZlbG9wbWVudCBi
b2FyZCwNCj4gd2hpY2ggaXMgZGV2ZWxvcGVkIGJ5IEd1YW5nZG9uZyBCaXBhaSBUZWNobm9sb2d5
IENvLiwgTHRkLi4NCj4gDQo+IHl0ODgyMSAyLjVHIGV0aGVybmV0IHBoeSB3b3JrcyBpbiBBVVRP
X0JYMjUwMF9TR01JSSBvciBGT1JDRV9CWDI1MDANCj4gaW50ZXJmYWNlLCBzdXBwb3J0cyAyLjVH
LzEwMDBNLzEwME0vMTBNIHNwZWVkcywgYW5kIHdvbChtYWdpYyBwYWNrYWdlKS4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IEZyYW5rIFNhZSA8RnJhbmsuU2FlQG1vdG9yLWNvbW0uY29tPg0KPiAtLS0N
Cj4gdjQ6DQo+ICAgLSByZW1vdmVkIGFsbCB0aGVzZSBwb2ludGxlc3MgZ290byBlcnJfcmVzdG9y
ZV9wYWdlOw0KPiB2MzoNCj4gICAtIHVzZWQgZXhpc3RpbmcgQVBJIGdlbnBoeV9jNDVfcG1hX3Jl
YWRfZXh0X2FiaWxpdGllcygpIHRvIG1ha2Ugc291cmNlDQo+ICAgICBjb2RlIG1vcmUgY29uY2lz
ZSBpbiB5dDg4MjFfZ2V0X2ZlYXR1cmVzKCkuDQo+ICAgLSB1c2VkIGV4aXN0aW5nIEFQSSBnZW5w
aHlfYzQ1X3JlYWRfbHBhKCkgdG8gbWFrZSBzb3VyY2UgY29kZSBtb3JlDQo+ICAgICBjb25jaXNl
IGluIHl0ODgyMV9yZWFkX3N0YXR1cygpLg0KPiAgIC0gdXBkYXRlZCB0byByZXR1cm4geXQ4NTIx
X2FuZWdfZG9uZV9wYWdlZCgpIGluIHl0ODgyMV9hbmVnX2RvbmUoKTsNCj4gICAtIG1vdmVkIF9f
c2V0X2JpdChQSFlfSU5URVJGQUNFX01PREVfMjUwMEJBU0VYLA0KPiAgICAgcGh5ZGV2LT5wb3Nz
aWJsZV9pbnRlcmZhY2VzKTsgb3V0IG9mIHRoZXNlIGlmKCkgc3RhdGVtZW50cy4NCj4gdjI6DQo+
ICAgLSByZW1vdmVkIG1vdG9yY29tbSxjaGlwLW1vZGUgcHJvcGVydHkgaW4gRFQuDQo+ICAgLSBt
b2RpZmllZCB0aGUgbWFnaWMgbnVtYmVycyBvZiBfU0VUVElORyBtYWNyby4NCj4gICAtIGFkZGVk
ICI6IiBhZnRlciByZXR1cm5zIGluIGZ1bmN0aW9uJ3MgRE9DLg0KPiAgIC0gdXBkYXRlZCBZVFBI
WV9TU1JfU1BFRURfMjUwME0gdmFsIGZyb20gMHg0ICgoMHgwIDw8IDE0KSB8IEJJVCg5KSkuDQo+
ICAgLSB5dDg4MjFnZW5faW5pdF9wYWdlZChwaHlkZXYsIFlUODUyMV9SU1NSX0ZJQkVSX1NQQUNF
KSBhbmQNCj4gICAgIHl0ODgyMWdlbl9pbml0X3BhZ2VkKHBoeWRldiwgWVQ4NTIxX1JTU1JfVVRQ
X1NQQUNFKSB1cGRhdGVkIHRvDQo+ICAgICB5dDg4MjFfc2VyZGVzX2luaXQoKSBhbmQgeXQ4ODIx
X3V0cF9pbml0KCkuDQo+ICAgLSByZW1vdmVkIHBoeWRldi0+aXJxID0gUEhZX1BPTEw7IGluIHl0
ODgyMV9jb25maWdfaW5pdCgpLg0KPiAgIC0gaW5zdGVhZCBvZiBwaHlkZXZfaW5mbygpLCBwaHlk
ZXZfZGJnKCkgdXNlZCBpbiB5dDg4MjFfcmVhZF9zdGF0dXMoKS4NCj4gICAtIGluc3RlYWQgb2Yg
X19hc3NpZ25fYml0KCksIF9fc2V0X2JpdCgpIHVzZWQuDQo+IHYxOg0KPiAgIC0gaHR0cHM6Ly91
cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLQ0KPiAzQV9fbG9yZS5rZXJu
ZWwub3JnX25ldGRldl8yMDI0MDcyNzA5MTkwNi4xMTA4NTg4LTJEMS0yREZyYW5rLlNhZS0NCj4g
NDBtb3Rvci0NCj4gMkRjb21tLmNvbV8mZD1Ed0lEQWcmYz1uS2pXZWMyYjZSMG1PeVBhejd4dGZR
JnI9YzNNc2dyUi1VLQ0KPiBIRmhtRmQ2UjRNV1JaRy0NCj4gOFFlaWtKbjVQa2pxTVRwQlNnJm09
VmNrSHV1am5tRGQ0R0YzSDFRRG4yT0RHWDNKUUZHZWNPYXhnX0tGTA0KPiBtcW9qZ1RjdjktDQo+
IFNqNHQwMVNHZTkzd2RDJnM9ZXNUbG5fSUhNN2g0aW04VFhkQ1UzR2M0OUEza3BiVUFfOUtUUzlV
Ql9NTQ0KPiAmZT0NCj4gICAtIGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91
cmw/dT1odHRwcy0NCj4gM0FfX2xvcmUua2VybmVsLm9yZ19uZXRkZXZfMjAyNDA3MjcwOTIwMDku
MTEwODY0MC0yRDEtMkRGcmFuay5TYWUtDQo+IDQwbW90b3ItDQo+IDJEY29tbS5jb21fJmQ9RHdJ
REFnJmM9bktqV2VjMmI2UjBtT3lQYXo3eHRmUSZyPWMzTXNnclItVS0NCj4gSEZobUZkNlI0TVdS
WkctDQo+IDhRZWlrSm41UGtqcU1UcEJTZyZtPVZja0h1dWpubURkNEdGM0gxUURuMk9ER1gzSlFG
R2VjT2F4Z19LRkwNCj4gbXFvamdUY3Y5LVNqNHQwMVNHZTkzd2RDJnM9Mkc4LWtNTGZtT0l5eW5M
V1pwbHdvVGVRdy0NCj4gbHVGd0ZtQ0VTTjV6eV85aHMmZT0NCj4gICAtIGh0dHBzOi8vdXJsZGVm
ZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0NCj4gM0FfX2xvcmUua2VybmVsLm9y
Z19uZXRkZXZfMjAyNDA3MjcwOTIwMzEuMTEwODY5MC0yRDEtMkRGcmFuay5TYWUtDQo+IDQwbW90
b3ItDQo+IDJEY29tbS5jb21fJmQ9RHdJREFnJmM9bktqV2VjMmI2UjBtT3lQYXo3eHRmUSZyPWMz
TXNnclItVS0NCj4gSEZobUZkNlI0TVdSWkctDQo+IDhRZWlrSm41UGtqcU1UcEJTZyZtPVZja0h1
dWpubURkNEdGM0gxUURuMk9ER1gzSlFGR2VjT2F4Z19LRkwNCj4gbXFvamdUY3Y5LQ0KPiBTajR0
MDFTR2U5M3dkQyZzPTRld0szTllPWXJsWmNBSkdDcnpSUnVBTHlXYU9xRHUwbEVOS1dqc29DUVkm
ZQ0KPiA9DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvcGh5L21vdG9yY29tbS5jIHwgNjYyDQo+ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDY1
OCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L3BoeS9tb3RvcmNvbW0uYyBiL2RyaXZlcnMvbmV0L3BoeS9tb3RvcmNvbW0uYw0KPiBp
bmRleCBmZTBhYWJlMTI2MjIuLmE5MDc0Zjk4Y2Q4OCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9u
ZXQvcGh5L21vdG9yY29tbS5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3BoeS9tb3RvcmNvbW0uYw0K
PiBAQCAtMSw2ICsxLDYgQEANCj4gIC8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4w
Kw0KPiAgLyoNCj4gLSAqIE1vdG9yY29tbSA4NTExLzg1MjEvODUzMS84NTMxUyBQSFkgZHJpdmVy
Lg0KPiArICogTW90b3Jjb21tIDg1MTEvODUyMS84NTMxLzg1MzFTLzg4MjEgUEhZIGRyaXZlci4N
Cj4gICAqDQo+ICAgKiBBdXRob3I6IFBldGVyIEdlaXMgPHBnd2lwZW91dEBnbWFpbC5jb20+DQo+
ICAgKiBBdXRob3I6IEZyYW5rIDxGcmFuay5TYWVAbW90b3ItY29tbS5jb20+IEBAIC0xNiw4ICsx
Niw4IEBADQo+ICAjZGVmaW5lIFBIWV9JRF9ZVDg1MjEJCTB4MDAwMDAxMWENCj4gICNkZWZpbmUg
UEhZX0lEX1lUODUzMQkJMHg0ZjUxZTkxYg0KPiAgI2RlZmluZSBQSFlfSURfWVQ4NTMxUwkJMHg0
ZjUxZTkxYQ0KPiAtDQo+IC0vKiBZVDg1MjEvWVQ4NTMxUyBSZWdpc3RlciBPdmVydmlldw0KPiAr
I2RlZmluZSBQSFlfSURfWVQ4ODIxCQkweDRmNTFlYTE5DQo+ICsvKiBZVDg1MjEvWVQ4NTMxUy9Z
VDg4MjEgUmVnaXN0ZXIgT3ZlcnZpZXcNCj4gICAqCVVUUCBSZWdpc3RlciBzcGFjZQl8CUZJQkVS
IFJlZ2lzdGVyIHNwYWNlDQo+ICAgKiAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgKiB8CVVUUCBNSUkJCQl8CUZJQkVSIE1J
SQkJfA0KPiBAQCAtNTAsNiArNTAsOCBAQA0KPiAgI2RlZmluZSBZVFBIWV9TU1JfU1BFRURfMTBN
CQkJKCgweDAgPDwgMTQpKQ0KPiAgI2RlZmluZSBZVFBIWV9TU1JfU1BFRURfMTAwTQkJCSgoMHgx
IDw8IDE0KSkNCj4gICNkZWZpbmUgWVRQSFlfU1NSX1NQRUVEXzEwMDBNCQkJKCgweDIgPDwgMTQp
KQ0KPiArI2RlZmluZSBZVFBIWV9TU1JfU1BFRURfMTBHCQkJKCgweDMgPDwgMTQpKQ0KPiArI2Rl
ZmluZSBZVFBIWV9TU1JfU1BFRURfMjUwME0JCQkoKDB4MCA8PCAxNCkgfCBCSVQoOSkpDQo+ICAj
ZGVmaW5lIFlUUEhZX1NTUl9EVVBMRVhfT0ZGU0VUCQkJMTMNCj4gICNkZWZpbmUgWVRQSFlfU1NS
X0RVUExFWAkJCUJJVCgxMykNCj4gICNkZWZpbmUgWVRQSFlfU1NSX1BBR0VfUkVDRUlWRUQJCQlC
SVQoMTIpDQo+IEBAIC0yNjgsMTIgKzI3MCw4OSBAQA0KPiAgI2RlZmluZSBZVDg1MzFfU0NSX0NM
S19TUkNfUkVGXzI1TQkJNA0KPiAgI2RlZmluZSBZVDg1MzFfU0NSX0NMS19TUkNfU1NDXzI1TQkJ
NQ0KPiANCj4gKyNkZWZpbmUgWVQ4ODIxX1NEU19FWFRfQ1NSX0NUUkxfUkVHCQkJMHgyMw0KPiAr
I2RlZmluZSBZVDg4MjFfU0RTX0VYVF9DU1JfVkNPX0xET19FTgkJCUJJVCgxNSkNCg0KLi4uDQoN
Cj4gKyAqDQo+ICsgKiBSZXR1cm5zOiAwIG9yIG5lZ2F0aXZlIGVycm5vIGNvZGUNCj4gKyAqLw0K
PiArc3RhdGljIGludCB5dDg4MjFfdXRwX2luaXQoc3RydWN0IHBoeV9kZXZpY2UgKnBoeWRldikg
ew0KPiArCWludCBvbGRfcGFnZTsNCj4gKwlpbnQgcmV0ID0gMDsNCj4gKwl1MTYgbWFzazsNCj4g
Kwl1MTYgc2F2ZTsNCj4gKwl1MTYgc2V0Ow0KPiArDQo+ICsJb2xkX3BhZ2UgPSBwaHlfc2VsZWN0
X3BhZ2UocGh5ZGV2LCBZVDg1MjFfUlNTUl9VVFBfU1BBQ0UpOw0KPiArCWlmIChvbGRfcGFnZSA8
IDApDQo+ICsJCWdvdG8gZXJyX3Jlc3RvcmVfcGFnZTsNCg0KSWYgcGh5X3NlbGVjdF9wYWdlIHJl
dHVybnMgYW4gZXJyb3IsIHlvdeKAmXJlIGRpcmVjdGx5IGp1bXBpbmcgdG8gdGhlIGNsZWFudXAg
d2l0aG91dCBhbnkgbG9nZ2luZy4gSXQgaXMgYWR2aXNhYmxlIHRvIGFkZCBkZWJ1ZyBsb2cgYmVm
b3JlIHRoZSBnb3RvIHN0YXRlbWVudCwgdW50aWwgdW5sZXNzIHlvdSBoYXZlIG90aGVyIGNvbnN0
cmFpbnRzIHcuci50DQpNZW1vcnkgZXRjLi4NCklmIChvbGRfcGFnZSA8IDApIHsNCglwaHlkZXZf
ZXJyKHBoeWRldiwgIkZhaWxlZCB0byBzZWxlY3QgcGFnZTogJWRcbiIsIG9sZF9wYWdlKTsNCgln
b3RvIGVycl9yZXN0b3JlX3BhZ2U7DQp9DQoNCj4gKw0KPiArCW1hc2sgPSBZVDg4MjFfVVRQX0VY
VF9SUEROX0JQX0ZGRV9MTkdfMjUwMCB8DQo+ICsJCVlUODgyMV9VVFBfRVhUX1JQRE5fQlBfRkZF
X1NIVF8yNTAwIHwNCj4gKwkJWVQ4ODIxX1VUUF9FWFRfUlBETl9JUFJfU0hUXzI1MDA7DQo+ICsJ
c2V0ID0gWVQ4ODIxX1VUUF9FWFRfUlBETl9CUF9GRkVfTE5HXzI1MDAgfA0KPiArCQlZVDg4MjFf
VVRQX0VYVF9SUEROX0JQX0ZGRV9TSFRfMjUwMDsNCj4gKwlyZXQgPSB5dHBoeV9tb2RpZnlfZXh0
KHBoeWRldiwgWVQ4ODIxX1VUUF9FWFRfUlBETl9DVFJMX1JFRywNCj4gKwkJCSAgICAgICBtYXNr
LCBzZXQpOw0KPiArCWlmIChyZXQgPCAwKQ0KPiArCQlnb3RvIGVycl9yZXN0b3JlX3BhZ2U7DQo+
ICsNCj4gKwltYXNrID0gWVQ4ODIxX1VUUF9FWFRfVkdBX0xQRjFfQ0FQX09USEVSIHwNCj4gKwkJ
WVQ4ODIxX1VUUF9FWFRfVkdBX0xQRjFfQ0FQXzI1MDA7DQo=

