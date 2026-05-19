Return-Path: <netdev+bounces-289261-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCQWLnbUC2qaOgUAu9opvQ
	(envelope-from <netdev+bounces-289261-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 05:09:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFC1576B52
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 05:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F9B13020D59
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 02:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70C233554F;
	Tue, 19 May 2026 02:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="W1sJY0uJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2300331A41;
	Tue, 19 May 2026 02:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779159588; cv=fail; b=R83OqNfBruaIQxWWuqGLF1CVkm8a7qSRLqKlYJ/in85dNc2ptV9CNp/eDW6vLJjFWnDemccS43UKY2lkArtOUMy8uqyx5Z2zVX4dt3rCWz0CPwPtMNDliVJADp+lCMSq88S6XGtugwWQkC5MucPtvO7zfKvvqKWmvbBqwrzxL+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779159588; c=relaxed/simple;
	bh=LS70x0Bh24Iq+Uw53eAZgPv4fyNJJylaP4g3Q2djkEk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gaG5kxzVQkUsJIBiUkBv+nkitQrggSDF5K1pEJktBrIPcgfYeSV0OgCv8eTHvO0ez/4mYzuxVlIi3q+x0XGY45NhF46aqqF7dGb/3VrABzMy7y8EXsSpKs2ZXeDALxNRWpMhLlc0QcFGGuehEEB7JrpWZ4M4G/tQPVaPHs7wTJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=W1sJY0uJ; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J12MNw2507992;
	Mon, 18 May 2026 19:59:23 -0700
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11023091.outbound.protection.outlook.com [40.107.201.91])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4e6nxkpwgs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 19:59:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x2vontYROmGJdoUMfCSrUIadXVwwC0HVvy8KPdtbW75lq2y7btTPXqO+p8li/Y+yjaPuky/1VsDccr5DdxhqczA00s5F6d3CQ/jr4n1llK9bq1Haj3TbdaLVdc1oBXSDGfqSGaZB+j4hH++PJnqWIVlrULAItiAv5K6hMKXvNem+WgRDAlDSVwzw7N2G14aPKNFzRSmt0MJFtKt/qn82aZ3rjkWcEOVQ1/ArVkFfjx2Ck6+jAyMnrUbdU1Ouvs+hoQ1fvIzZEUCreu0iw+E7hk0HFoTDHOEx9RLI0T1t8WM8keKgltz+EyeKXfsVsaiBRrmtobi4Bl28ViEctScPug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LS70x0Bh24Iq+Uw53eAZgPv4fyNJJylaP4g3Q2djkEk=;
 b=IpUPllXtQXfL/gH/8irrRNxHGdF76cWXzGTDPAHyd7cKu2s7nrZHMYBG3PbwpuSX0OnU1bkOohuSSvScZv+My0Wu2k4IpsWt/V2sn3JyqCrGEzamc1QtKIeVdUCvZeqsZEbk08K1sD0CaK5qU6UJy/IE6g4EFuOuRiVf5UcdeMYLXBbi/7nLNM1UTCnp6ofGvdJW3k8+XaFhOMje7QYtrKaZ5Vcs+jntBALM4AqT13UwqwaZSLo1Fma23FhYsFKGb6asVDlj8592mizG3bC+z4au7hbujIuiRYWziZpe6UAha2Tbi8Al1fh5z3qDVMjU+C94naR3aK6BPS1IxkJZVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LS70x0Bh24Iq+Uw53eAZgPv4fyNJJylaP4g3Q2djkEk=;
 b=W1sJY0uJlEZiT4POVWdDF+XVhwXFLsK5diGdAeYTqehATX/HGppI857dVuF/DQ8gFfcTygbP59zzsIr2QOeCnkEUin3kD0W6FftBFHX6wCGJa/+3Y+3RzS6Dct0Z20RLCukgPExgaoM+uo9IFNq1bURE+vxeFnMr2t2GGpYda9c=
Received: from SA1PR18MB4600.namprd18.prod.outlook.com (2603:10b6:806:1d3::7)
 by SA3PR18MB5577.namprd18.prod.outlook.com (2603:10b6:806:397::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Tue, 19 May
 2026 02:59:16 +0000
Received: from SA1PR18MB4600.namprd18.prod.outlook.com
 ([fe80::a9ff:1d54:811d:cff9]) by SA1PR18MB4600.namprd18.prod.outlook.com
 ([fe80::a9ff:1d54:811d:cff9%6]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 02:59:16 +0000
From: "Sukhdeep Soni [C]" <sukhdeeps@marvell.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Igor Russkikh
	<irusskikh@marvell.com>,
        Egor Pomozov <epomozov@marvell.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next 7/9] net: atlantic: add AQC113 PTP
 traffic class and TX path setup TX path setup
Thread-Topic: [EXTERNAL] Re: [PATCH net-next 7/9] net: atlantic: add AQC113
 PTP traffic class and TX path setup TX path setup
Thread-Index: AQHc3WB+yMFggXK1FkOiaHvFHBSI8rYKL8+AgAqE7OA=
Date: Tue, 19 May 2026 02:59:16 +0000
Message-ID:
 <SA1PR18MB4600BF59A4CDD56EA6BA19F5BA002@SA1PR18MB4600.namprd18.prod.outlook.com>
References: <20260506135706.2834-8-sukhdeeps@marvell.com>
 <20260512095411.134924-1-pabeni@redhat.com>
In-Reply-To: <20260512095411.134924-1-pabeni@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR18MB4600:EE_|SA3PR18MB5577:EE_
x-ms-office365-filtering-correlation-id: 5d133ee9-bd89-4290-96f6-08deb5529d79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|11063799003|56012099003|38070700021|22082099003|4143699003|18002099003;
x-microsoft-antispam-message-info:
 FWstSzPLtidd15/7jxtK22nBlsMabYeRkj18RmsdSOmVS9KY+iLKoN8em6a90bHZ3a3vhhnCaOFxP7AYaZOu/5BnivwbLh8eUrBZXnY9YgT2ipAYrVW9fMiuwEyV1yUu4/hjUCx0gNMpV2G67L972qfDlJPnjXNvCwzUSvMREROcQlWeniSxQMdYs7uwi2s2/7WOPFvogWVdakgLx/7HMMv2QqEt2DMmzyZh3syn3qKHwh0QWZhPztnDYi/QQ7ztrH+0nhoXkFYFR80SOgKr2o1fGfpIOD3NGxXSl/Sb6lvGQMDh0wq3UYrHo0cmnF4hLq7w2tbFSgjhPp7/9Z1JD3h8yj8arOpVae37MuWUUu7o5Bpjt4l//Iswvfp12JPJwPXV2XuaDRa0wPULZ01mNatkeumjA5lhffJJ3wyJEFbcd33ZH1R2Q4a5e5yXUmDg4w3POs35P2rNQ/CIx0hi9mb+67zNTODT5mHtf6FpaJN+pawp7/Bz3Dz/xuyQsho6kt7gygjN+peqO2PIPnezoUx+d8pZk8WsU+dQoZvyMJp/JwNZnB7Mj61Dm8kF7muioIZNxeIrtzBL0lEreFB81QqxBMhLlu/aUF7byoekIXTp+5Ly4oLI1Tbf4jZH2ACZEQqDgJ1UcfcDnjdyh7deuO8lKIv/7UYi41tYRNYCKrXLvu54lICD2mJ4CRGdacx6PCJsmS4jjQcL19pthe9zT7yD9pW3DlWmv6f0DkzPVCC+8Y6BM+VmzIiqCUtJydLO
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR18MB4600.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(11063799003)(56012099003)(38070700021)(22082099003)(4143699003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eUIwSEdBSWcyU2RtcjJIeVZXSURaeHVaZ0s5YlRwb041R2E1cG5FUmdMNGs5?=
 =?utf-8?B?UDBKdmZvci9EaWJmUFlxcThxWHFaNDUxRVZWR2l6NjNVQ0xVbFRDTEJmeVV5?=
 =?utf-8?B?RUY3K0NWaSs3VnhxMEI2RFY4Vld0ZjRIdG9ucXU3aklYVXllVGMwSjlHSmN0?=
 =?utf-8?B?TC8rdG1TSGhoTmFQaHZXUnAvSllYdlhMOHFDOWlpMFZWVU5iQUZWVmdvYlJB?=
 =?utf-8?B?dmRqeHRaSVZnM2tYUlpFL0x4ZXA1MkhtekRWaG5FdmlyTDMyTkpjTWpXaU5U?=
 =?utf-8?B?YlB0WjRUZ3dVTTdPblAxcFZWTnlsZzZUbzJtVlBWSGUwckRnU0NjRVJFM251?=
 =?utf-8?B?OHdIeDdraCtrdGxCUlFFQWZsUktuazNiYTZiMzhVOXliMGUzK2x0R0JXM3Js?=
 =?utf-8?B?bUhWcFdjRmdYVzJ6OFFzUDlkWWdvQUtwdEJuRDNqTTY0MkRTcHY1ZmJxMktK?=
 =?utf-8?B?ZlRBUVFycEU0Sjd4QWJTNGwzSVFHc0gvY2p3NmtSdno1c2pTbXBHL21yeXBQ?=
 =?utf-8?B?QXl6TmVFSnRPVDhwMUxFMkswWmxGNnZoT2F3dC9lNnF3eUJXTzBvRngycnZx?=
 =?utf-8?B?Z2NVWjR6NXZiYm1GWkRCcDJ6QVhuK3FnTklhNXZPU2NUUmExWXJrNGNJZVlY?=
 =?utf-8?B?OWNLcjN1ZEJ2eWEzMXU0MEtqT0g5L3NySUsybTNwcGY2QVA1ZHVLKzFFRXJF?=
 =?utf-8?B?TXVFS3VDM1JERVZXQ0FDS0Q0ZGhNVDkvNERnendBWDdRQ1dwMEwySFU2akxk?=
 =?utf-8?B?THo3WnQ2eUw3WkdoL0Z4QWxvZy8wMGowMHNZNEkyc05jdVJaUms2TFNSZFpI?=
 =?utf-8?B?eDFYaExIc3M2ZmcwNnZPSmNzQVpab29EQkdrSHIxbHpLQmt3cjQwbUdNeEkz?=
 =?utf-8?B?emt1SERGZlZ0Ris1QjBZZllMOU96Um1vOEpCS1ZTTjMvWFpubWM0VU1oQ3A3?=
 =?utf-8?B?WjUxUld1OU82REdYRTgvV3puNGdadTM1aXFkOXZFcmxja1ErLzllT1V5NFE2?=
 =?utf-8?B?SnpzRHdkYU1UMEdOSDgwSTMxVnB5OHk4UlZSRWVROFo0QXRwcGxJS1VhNGh4?=
 =?utf-8?B?eUIyTnJUenhRSzc3aHV1WEVMUTlONVhtUi84dkdZWGQ3ZWl6RVNBVVFzN0F0?=
 =?utf-8?B?RHlrNkdLb2ZYbE1sUDNCVmV2U3h1K1JBTytFMG5Ob3JDcUluZ0cwOXZhVlA5?=
 =?utf-8?B?SGo5YXBKZFFZbkkwQkhKMUJ6Uk45THJZSjNTNS9ZaHVTNk5mTFk1c3Y3UFdR?=
 =?utf-8?B?dzNodXo0QkFqbmZmVzZjdXozRkpnNHRpYjZhbS9hanJ6TEw2M2RaRGVxb1E1?=
 =?utf-8?B?WXdGbmVhZitDNXRtYTh3SWQxNkFiZS9RQitWUVRINWpwZERKRHprWnNCYVdx?=
 =?utf-8?B?dUU4ZVpzOU9wRkN2NE1BQnVYY1BuSVk5dXZLWmtqU2t4R2w0UlE2ZytwS0wx?=
 =?utf-8?B?UUx3S2NiTlo2UnpXK24xOE80NEJ3U2JDeVkvZElLRHlUWjh4eE5mWUdleTZG?=
 =?utf-8?B?aGhQSW9NcTdQU0xRTnJGMnYxMTVUMUQwNnhiTWJUOHV5NmIzdEJEeVFTeXJh?=
 =?utf-8?B?dW1Mb1ZyUlpHSWxUbzYrOWJBVFFoU21lcHZVK2E4WFhIT3JkUWNZV3VQb0FZ?=
 =?utf-8?B?YndYZ3A0R0svejE5VkI0QzYvQldQRmxhR1UyZ0d2bXZqbk8xeENhK2V5elZH?=
 =?utf-8?B?ekdtSE5hOFhncG5JQ3EvWUxGYkZXODVMa0ViNVZwRkNVeVZzU2NVKzhsMHFm?=
 =?utf-8?B?NzI2MzZ4QXpra0ZKS2xzeEpiYis1RDN1VVd6b2NVQlJUeWoyRnRCQlJYWVZ1?=
 =?utf-8?B?emEwcVBQNkdaSEU1VFNXUW51VEYwb2pXR3lmT0pEYkJwc0VuRWNtTzd2djRI?=
 =?utf-8?B?VVhNZlV4cy9oOHZ6K3YveHA3Z0RpeVc0Q0xPbldCU1g4Q2FXcG1hVEtrYVUv?=
 =?utf-8?B?NGJ2bUlieG1HYVg1bUhFMzBSMElHOWJCQlh4MWRBVUN2bVdyWEdoSyszTXRr?=
 =?utf-8?B?aUIvLzYrenNRVDN0VVl2bGtaOVkyT29DVUgyK1laV3p2YWZKbkRheEFHbExP?=
 =?utf-8?B?Q1FrTHB1dWRSVE9sSGs2WU9jbHNVYUphaDNLSGFQNjN0R2hyaVdnWjVDS2Yw?=
 =?utf-8?B?R2R6emIyeFV6N2NKR2tMZlVrOUdqVC9FZmJPUFZBb1ltMkpxeXk5Mm9ML05C?=
 =?utf-8?B?WHRkOFJiVm1hQnhYRjZNdXFkemJ4VTNWc3dMam95aFFrcmh5UlpxUFg1VTRm?=
 =?utf-8?B?Z2tWMFB3K0RsNGUvVmtrSmFBNWRjNG1CNVg5QnpMSHRPZ2hqY3FldWF4cFpM?=
 =?utf-8?B?VmJtR212MVRKWVVFVHRwWlJMWnQ4NkNxanRNVGxuQXJic0dQSmpDOVptaHNp?=
 =?utf-8?Q?MVeyO3Q40bUBHYrVm8m69ZWkejS7+YyjVRQyFTpDSGXb6?=
x-ms-exchange-antispam-messagedata-1: +cZJXcofaS2LmQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	VBlLt12/DXs3PQ3hgDcoaCIYLD7vIuSayMzoZJjVCFLR5waEkUONB+s24u5ohb2rtS/RQ0gbT717lbQcCAOWBFtmfIZxJN3Y88xt/cUtn3ZrB2Z3dGejh3f4pblawkQRjfrd0uH/MoyK4bGVQrmL4FHqg0IccWIJ8q+bl9UZDkA4TYog0bKcc6QqIf4B1TPp9z2Mo9XTmPBF3NOhZ4MbAlBA0Er5dPNhRLG0DOAyQGQ9QXDxLtmdGZIMzGoyEuhCFLe3eV1TYHjrBLWIX/HjzHp6G3g0HzW2EA+msJlWjN8LXgnYDaejkfOAPhONB89r8dVR3pwMOYidHbMitV4/3w==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR18MB4600.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d133ee9-bd89-4290-96f6-08deb5529d79
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 02:59:16.6537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 36t69Wg6B9LRkeE1QPyvPz9hweGMFceCabbrFbjHAhtw6MpS1cZKoUpV/zB9n4/tV7W6SynaXhui/1gUDz/oJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR18MB5577
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDAyNiBTYWx0ZWRfX0HkwSSASJsaf
 mC359Qz0kdlzHHHeFp5a0cJajE5ziDJHQIJxZmTZYRdDcZe3rGxLjoOWLRePQTr7dgLCZLBrHBx
 UGKoMbmaJlAuhWLuz7mB4FniF3t/Mgen+5z/qW0xuIG8Cq7MXuzMHs4Dpop5kbh+4CAXXqEPrGE
 PXJ+/MoV4hfXZGp2ULpJ7rCr3MWUbbZKGVJ+SE/1neXYzFoQKbQ6aQf5AqgcaapPJN76gSA4+8p
 ht+qEqjJFqLVTSx1D0T3HLLE0OYMWNBu/RXxHNaW54JePHDsnimE4ZWhKju3aDQy4QlHYQoF/4/
 zpv05wPoyOAuYyuX+PFbjh8RTD4XdKUvygh7mu7Vgmc76UbarTnvAT8rEVpqERSkyQrjiqVUJ+U
 90gpYKTHW3uCl3bxO7noEjmaXCaAABuCUyd89z/LoCkJ6NleN6EdILVtSPy2eBk5U08lc+vBqBK
 wMvtivg/T1mXcZULCDA==
X-Proofpoint-GUID: AITLPr2_GKIvmNqla6saOhQcRZ56-sx-
X-Proofpoint-ORIG-GUID: AITLPr2_GKIvmNqla6saOhQcRZ56-sx-
X-Authority-Analysis: v=2.4 cv=NbPWEWD4 c=1 sm=1 tr=0 ts=6a0bd20b cx=c_pps
 a=yYYKAKAKl8D9GxIYT1WzoA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=8Wq_HXEf80eose6ypw4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_01,2026-05-18_01,2025-10-01_01
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289261-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SA1PR18MB4600.namprd18.prod.outlook.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,marvell.com:dkim];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,marvell.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1FFC1576B52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gMTIgTWF5IDIwMjYsIFBhb2xvIEFiZW5pIHdyb3RlOg0KDQo+IG5ldDogYXRsYW50aWM6IGFk
ZCBBUUMxMTMgUFRQIHRyYWZmaWMgY2xhc3MgYW5kIFRYIHBhdGggc2V0dXAgVFggcGF0aCBzZXR1
cA0KPiANCj4gUmVzZXJ2ZXMgUFRQIFRYL1JYIGJ1ZmZlciBzcGFjZSwgY29uZmlndXJlcyB0aGUg
UFRQIHRyYWZmaWMgY2xhc3MNCj4gd2l0aCBubyBmbG93IGNvbnRyb2wgYW5kIGhpZ2hlc3QgcHJp
b3JpdHksIGVuYWJsZXMgbXVsdGljYXN0IGZyYW1lDQo+IHRhZ2dpbmcgZm9yIEFSVC1iYXNlZCBQ
VFAgc3RlZXJpbmcsIGFuZCBidW1wcyBUWCByZWFkLXJlcXVlc3QgbGltaXRzDQo+IHdoZW4gdGhl
IFBDSWUgZXh0ZW5kZWQtdGFnIGJpdCBpcyBhbHJlYWR5IHNldC4NCj4gDQo+IG5ldDogYXRsYW50
aWM6IGFkZCBBUUMxMTMgUFRQIHRyYWZmaWMgY2xhc3MgYW5kIFRYIHBhdGggc2V0dXAgVFggcGF0
aCBzZXR1cA0KPiANCj4gVGhlIHN1YmplY3QgY29udGFpbnMgdGhlIHBocmFzZSAiVFggcGF0aCBz
ZXR1cCIgdHdpY2UuIElzIHRoYXQNCj4gaW50ZW50aW9uYWw/DQo+IA0KPiBUaGUgcGF0Y2ggYWxz
byBidW5kbGVzIHNldmVyYWwgdW5yZWxhdGVkIGNoYW5nZXMgaW50byBhIHNpbmdsZSBjb21taXQ6
DQo+IFBUUCBUQyBidWZmZXIgcmVzZXJ2YXRpb24sIGFuIHVuY29uZGl0aW9uYWwgYWNjZXB0LWFs
bC1tdWx0aWNhc3QNCj4gZW5hYmxlLCBQQ0llLWV4dGVuZGVkLXRhZy1nYXRlZCBUWCByZWFkLXJl
cXVlc3QgbGltaXQgYnVtcHMsIGFuZCBhDQo+IG5vbi1mdW5jdGlvbmFsIFJTUyByZWZhY3Rvci4g
V291bGQgaXQgYmUgcmVhc29uYWJsZSB0byBzcGxpdCB0aGVzZQ0KPiBpbnRvIHNlcGFyYXRlIGNv
bW1pdHMgc28gZWFjaCBjYW4gYmUgcmV2aWV3ZWQsIHRlc3RlZCwgYW5kIGJpc2VjdGVkDQo+IGlu
ZGVwZW5kZW50bHk/DQoNClRoZSBhY2NlcHQtYWxsLW11bHRpY2FzdCBlbmFibGUgaGFzIGJlZW4g
cmVtb3ZlZCBmcm9tIHYzLiBUaGUgcmVtYWluaW5nDQogY2hhbmdlcyDigJQgUFRQIFRDIGJ1ZmZl
ciByZXNlcnZhdGlvbiwgUENJZSBleHRlbmRlZC10YWctZ2F0ZWQgVFgNCiByZWFkLXJlcXVlc3Qg
bGltaXRzLCBhbmQgdGhlIFJTUyByZWZhY3RvciDigJQgYXJlIGtlcHQgaW4gb25lIGNvbW1pdC4N
CiBUaGUgUFRQIFRDIHJlc2VydmF0aW9uIGFuZCBUWCBwYXRoIGltcHJvdmVtZW50cyBhcmUgZnVu
Y3Rpb25hbGx5DQogcmVsYXRlZDogdGhlIFRYIHJlYWQtcmVxdWVzdCBsaW1pdCBpbmNyZWFzZSBi
ZW5lZml0cyBQVFAgVEMgdGhyb3VnaHB1dA0KIGFuZCBpcyBtb3N0IG5hdHVyYWxseSBpbnRyb2R1
Y2VkIGFsb25nc2lkZSB0aGUgVEMgc2V0dXAuIFRoZSBSU1MNCiBzaW1wbGlmaWNhdGlvbiBpcyBh
IG9uZS1saW5lciBtZWNoYW5pY2FsIHJlZmFjdG9yIHRvdWNoaW5nIHRoZSBzYW1lDQogZmlsZTsg
c3BsaXR0aW5nIGl0IGludG8gYSBzZXBhcmF0ZSBjb21taXQgYWRkcyBvdmVyaGVhZCB3aXRob3V0
DQogbWVhbmluZ2Z1bCByZXZpZXcgYmVuZWZpdC4gSWYgdGhlIHByZWZlcmVuY2UgaXMgc3RyaWN0
IHNlcGFyYXRpb24gd2UNCiBjYW4gc3BsaXQgdGhlIFJTUyBjaGFuZ2UgaW4gdjQuDQoNCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2FxdWFudGlhL2F0bGFudGljL2h3X2F0bDIv
aHdfYXRsMi5jIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvYXF1YW50aWEvYXRsYW50aWMvaHdfYXRs
Mi9od19hdGwyLmMNCj4gaW5kZXggZTU4YmZmZjM4NjcwLi5jNzFlOGQxYWRmYzkgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2FxdWFudGlhL2F0bGFudGljL2h3X2F0bDIvaHdf
YXRsMi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2FxdWFudGlhL2F0bGFudGljL2h3
X2F0bDIvaHdfYXRsMi5jDQo+DQo+IFsgLi4uIF0NCj4NCj4gQEAgLTQxNSw5ICs0NDEsMjAgQEAg
c3RhdGljIGludCBod19hdGwyX2h3X2luaXRfdHhfcGF0aChzdHJ1Y3QgYXFfaHdfcyAqc2VsZikN
Cj4gIA0KPiAgCWh3X2F0bDJfdHBiX3R4X2J1Zl9jbGtfZ2F0ZV9lbl9zZXQoc2VsZiwgMFUpOw0K
PiAgDQo+ICsJaWYgKGh3X2F0bDJfcGhpX2V4dF90YWdfZ2V0KHNlbGYpKSB7DQo+ICsJCWh3X2F0
bDJfdGRtX3R4X2RhdGFfcmVhZF9yZXFfbGltaXRfc2V0KHNlbGYsIDB4N0YpOw0KPiArCQlod19h
dGwyX3RkbV90eF9kZXNjX3JlYWRfcmVxX2xpbWl0X3NldChzZWxmLCAweDBGKTsNCj4gKwl9DQo+
ICsNCj4gIAlyZXR1cm4gYXFfaHdfZXJyX2Zyb21fZmxhZ3Moc2VsZik7DQo+ICB9DQoNCj4gVGhl
IGNvbW1pdCBtZXNzYWdlIHNheXM6DQo+DQo+ICAgIEVuYWJsZSBleHRlbmRlZCBQQ0llIHRhZyBt
b2RlICgzMi0yNTUpIHdoZW4gaGFyZHdhcmUgc3VwcG9ydHMgaXQsDQo+ICAgIHdpdGggaW5jcmVh
c2VkIFRYIGRhdGEgYW5kIGRlc2NyaXB0b3IgcmVhZCByZXF1ZXN0IGxpbWl0cyBmb3INCj4gICAg
aW1wcm92ZWQgdGhyb3VnaHB1dC4NCg0KPiBEb2VzIHRoZSBjb2RlIGFjdHVhbGx5IGVuYWJsZSBl
eHRlbmRlZCBQQ0llIHRhZyBtb2RlPyBUaGUgY2FsbCBoZXJlIGlzDQo+IGh3X2F0bDJfcGhpX2V4
dF90YWdfZ2V0KCksIGEgcmVhZCBhY2Nlc3NvciB2aWEgYXFfaHdfcmVhZF9yZWdfYml0KCkuDQo+
IFRoZSBjb3JyZXNwb25kaW5nIHNldHRlciBod19hdGwyX3BoaV9leHRfdGFnX3NldCgpIGV4aXN0
cyBpbg0KPiBod19hdGwyX2xsaC5jIGJ1dCBkb2VzIG5vdCBhcHBlYXIgdG8gYmUgaW52b2tlZCBp
biB0aGlzIHBhdGNoIG9yDQo+IGVsc2V3aGVyZS4gVGhlIGNvZGUgcGF0aCBvbmx5IHJhaXNlcyB0
aGUgVFggcmVhZC1yZXF1ZXN0IGxpbWl0cyB3aGVuDQo+IHRoZSBiaXQgaXMgYWxyZWFkeSBzZXQg
YnkgZmlybXdhcmUvQklPUy4gU2hvdWxkIHRoZSBjb21taXQgbWVzc2FnZSBiZQ0KPiByZXdvcmRl
ZCB0byByZWZsZWN0IHRoYXQgYmVoYXZpb3I/DQoNCkNvcnJlY3Qg4oCUIHRoZSBjb21taXQgbWVz
c2FnZSBpcyBtaXNsZWFkaW5nLiBUaGUgY29kZSBvbmx5IHJlYWRzDQpod19hdGwyX3BoaV9leHRf
dGFnX2dldCgpIHRvIGNoZWNrIHdoZXRoZXIgZXh0ZW5kZWQgUENJZSB0YWcgbW9kZQ0KaXMgYWxy
ZWFkeSBlbmFibGVkIGJ5IGZpcm13YXJlL0JJT1MsIGFuZCBpZiBzbyByYWlzZXMgdGhlIFRYIGRh
dGEgYW5kDQpkZXNjcmlwdG9yIHJlYWQtcmVxdWVzdCBsaW1pdHMuIFRoZSBkcml2ZXIgbmV2ZXIg
Y2FsbHMgaHdfYXRsMl9waGlfZXh0X3RhZ19zZXQoKQ0KdG8gZW5hYmxlIGl0LiBXaWxsIHJld29y
ZCBpbiB2MyB0bzogIkluY3JlYXNlIFRYIGRhdGEgYW5kIGRlc2NyaXB0b3INCnJlYWQtcmVxdWVz
dCBsaW1pdHMgd2hlbiBmaXJtd2FyZSBoYXMgYWxyZWFkeSBlbmFibGVkIGV4dGVuZGVkIFBDSWUg
dGFnIG1vZGUuIg0KDQo+IA0KPiAgDQo+ICsvKiBJbml0aWFsaXNlIG5ldyByeCBmaWx0ZXJzDQo+
ICsgKiBMMiBwcm9taXNjIE9GRg0KPiArICogVkxBTiBwcm9taXNjIE9GRg0KPiArICoNCj4gKyAq
IFVzZXIgcHJpb3JpdHkgdG8gVEMNCj4gKyAqLw0KPiAgc3RhdGljIHZvaWQgaHdfYXRsMl9od19p
bml0X25ld19yeF9maWx0ZXJzKHN0cnVjdCBhcV9od19zICpzZWxmKQ0KPiAgew0KPiAgCXU4ICpw
cmlvX3RjX21hcCA9IHNlbGYtPmFxX25pY19jZmctPnByaW9fdGNfbWFwOw0KPiBAQCAtNDI5LDYg
KzQ2Niw5IEBAIHN0YXRpYyB2b2lkIGh3X2F0bDJfaHdfaW5pdF9uZXdfcnhfZmlsdGVycyhzdHJ1
Y3QgYXFfaHdfcyAqc2VsZikNCj4gIAl1OCBpbmRleDsNCj4gIAlpbnQgaTsNCj4gIA0KPiArCS8q
IHRhZyBNQyBmcmFtZXMgYWx3YXlzICovDQo+ICsJaHdfYXRsX3JwZmwyX2FjY2VwdF9hbGxfbWNf
cGFja2V0c19zZXQoc2VsZiwgMSk7DQo+ICsNCj4NCj4gSXMgdGhlICJ0YWcgTUMgZnJhbWVzIGFs
d2F5cyIgaW50ZW50IGFjdHVhbGx5IGR1cmFibGU/DQo+DQo+IFRoZSBzYW1lIGhhcmR3YXJlIGJp
dCBpcyByZXdyaXR0ZW4gdW5jb25kaXRpb25hbGx5IGJ5IHRoZSBwYWNrZXQNCj4gZmlsdGVyIHBh
dGguIEluIGh3X2F0bF9iMF9od19wYWNrZXRfZmlsdGVyX3NldCgpIChzaGFyZWQgYnkgYXRsMg0K
PiB0aHJvdWdoIGh3X2F0bF9iMC5jKToNCj4NCj4gICAgIGh3X2F0bF9ycGZsMl9hY2NlcHRfYWxs
X21jX3BhY2tldHNfc2V0KHNlbGYsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBJU19GSUxU
RVJfRU5BQkxFRChJRkZfQUxMTVVMVEkpICYmDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBJ
U19GSUxURVJfRU5BQkxFRChJRkZfTVVMVElDQVNUKSk7DQo+DQo+IG5kb19zZXRfcnhfbW9kZSBy
dW5zIGFzIHBhcnQgb2Ygbm9ybWFsIGludGVyZmFjZSBicmluZy11cCBhbmQgb24gZXZlcnkNCj4g
bXVsdGljYXN0LWxpc3QgY2hhbmdlLCBzbyB0aGUgaW5pdC10aW1lIHdyaXRlIHRvIDEgd291bGQg
YmUgY2xlYXJlZCB0bw0KPiAwIGZvciBhbnkgaW50ZXJmYWNlIG5vdCBpbiBhbGxtdWx0aWNhc3Qg
bW9kZS4gRG9lcyB0aGlzIG1lYW4gdGhlIEFSVA0KPiBjYW5ub3QgbWF0Y2ggUFRQIG11bHRpY2Fz
dCB0cmFmZmljIG9uY2UgcnhfbW9kZSBoYXMgYmVlbiBwcm9ncmFtbWVkLA0KPiB3aGljaCBpcyB0
aGUgY29tbWl0J3Mgc3RhdGVkIHB1cnBvc2Ugb2YgdGhpcyB3cml0ZT8NCj4NCj4gSWYgdGhlIGlu
dGVudCBpcyB0byBrZWVwIHRoZSBiaXQgc2V0IHdoZW5ldmVyIFBUUCBpcyBlbmFibGVkLCBzaG91
bGQNCj4gdGhlIHBhY2tldC1maWx0ZXIgcGF0aCBPUiBpbiBjZmctPmlzX3B0cCwgcmF0aGVyIHRo
YW4gKG9yIGluIGFkZGl0aW9uDQo+IHRvKSB3cml0aW5nIHRoZSBiaXQgb25jZSBhdCBpbml0Pw0K
Pg0KPiBUaGUgd3JpdGUgaXMgYWxzbyBub3QgZ2F0ZWQgYnkgY2ZnLT5pc19wdHAuIFdoaWxlIGl0
IGlzIGJyaWVmbHkgaW4NCj4gZWZmZWN0LCBkb2VzIGVuYWJsaW5nIGFjY2VwdF9hbGxfbWMgY2hh
bmdlIG11bHRpY2FzdCBmaWx0ZXJpbmcNCj4gYmVoYXZpb3IgZm9yIG5vbi1QVFAgdXNlcnMgaW4g
YSB3YXkgdGhhdCBuZWVkcyBqdXN0aWZpY2F0aW9uIGluIHRoZQ0KPiBjb21taXQgbG9nPw0KDQpU
aGUgaHdfYXRsX3JwZmwyX2FjY2VwdF9hbGxfbWNfcGFja2V0c19zZXQoc2VsZiwgMSkgY2FsbCBo
YXMgYmVlbg0KIHJlbW92ZWQgZnJvbSB0aGUgY29kZSBpbiB2MyBhbmQgdGhlIGNvbW1pdCBtZXNz
YWdlIHdpbGwgYmUgdXBkYXRlZA0KIHRvIHJlbW92ZSB0aGF0IGJ1bGxldCBwb2ludCBhY2NvcmRp
bmdseS4NCg0KPiBbIC4uLiBdDQo+IC0tIA0KPiBUaGlzIGlzIGFuIEFJLWdlbmVyYXRlZCByZXZp
ZXcuDQoNCg==

