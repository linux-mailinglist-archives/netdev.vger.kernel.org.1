Return-Path: <netdev+bounces-132755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D014993012
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12FF31F2390D
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 14:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4C71D7E37;
	Mon,  7 Oct 2024 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="SnmbQkSr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seco.com header.i=@seco.com header.b="tJ0GcxTv"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11022130.outbound.protection.outlook.com [52.101.66.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FAD1D6DB9;
	Mon,  7 Oct 2024 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.130
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728312672; cv=fail; b=YsrPxwOsKM0HrMz3OxMKtONrU7npZpnwjWYp96NhoMiTBwlr9HygpfjuYjiHvQDctwR4ojOg1wFY8/zm8kz0Wa/rGbGIzN/Pw7yM+9ERrfpJr2v5M/Bx1V8S0nJ32PFfrAFUJcKnw03Y56MnrM32toLbbRiLgBOA48qfgDWXsw8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728312672; c=relaxed/simple;
	bh=ayuxaajeWFxlHkoRTxG/iEZMdNMWiOVnvlIhY46prIA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BN+4/hfZWRJ9nUO+bU5hPx/sO9oumnh92/ObldAC6K2vgXJkaj3QIZqhjGD/4znK2Rmc+HXhcfv3p1MlsBsX+Snc/xZ2T3Jpx6F+6P09n4C7Mfv+meZpHJJgGnSa1OT0w2E8o+6Hrr4UUoFF3/AZi39ROfrl5eCnRdz/LnNA6gk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com; spf=pass smtp.mailfrom=seco.com; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=SnmbQkSr; dkim=fail (2048-bit key) header.d=seco.com header.i=@seco.com header.b=tJ0GcxTv reason="signature verification failed"; arc=fail smtp.client-ip=52.101.66.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=RQwMVxhdwfsmgRuFx9W0vIFrRNZGMlyevxyGg0g1TC/gQwPQObCkAYnrpxZs+JeujiQHa3FAOvTbxslm12ZbKAj78qthLVjyYwFxVkiNu1oYvaSVgWeZqMEDEIej9JBbiIaxFWXqhopirdO7tTxkNhU59DLdcmjpYSEQJDg9ilWLQzBYyAbhvdNQ4bK+ek7lwRgtNU+1xMdKibu66dG8ZAkFhtY/Vui2flmykY5b1j7D0Kq35cXcBxDJBYYpOhi0MWzTqUY4OPJeILbeEk/3vKnolcYmCr05fZJCa1bKUtVWTohxNZMuJR+cB4UIGlq03b5Ilh4KE5Ysqt+Lhn+j4Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIGKtHjJk7YjRHoROaAN4tAfXmkFHQic+S86cyXC4TY=;
 b=KEiXrgny/ZrMunqaARbLbFYqpxb1tc3MH9smPvXtECpq8EzRDdnocXCHoxyQVcoPzV3YE0tsLZzmjDzqFRd+2hhNTlUXw/kP71MG/AW8FgDnY6yPAaEDgX1AHfMmX5vJlzqcWidlHh+GRmpZLEZrX+OicIidWFk1LDd2TOya29pYNUiWv6DiFVl7WEUli9rc3TlT/Uqrhgcr1D8N7Lll0jLaYWhr2WqxQjq+Da3CQqeGcDu/hPYSssObxJKuodXC6+j0PusUG289JQcivSIVY4cl+0tj3SscYbllAu4LGqzHHeylPVcG5f0X1EbA1agbSlOyCZAUIiua3ZPBJVjChw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.87) smtp.rcpttodomain=davemloft.net smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIGKtHjJk7YjRHoROaAN4tAfXmkFHQic+S86cyXC4TY=;
 b=SnmbQkSrb6/fu/JVGMghDCexa3EkD7bzUudyKozNUUmUL+nAGbbeUEc5luQnNUFDcGjAHRedfTN2YJRmS3u7jwIsvTavLp+bnPW4EPno4gIiuD/a+ItWJH9JgeUsEv6dh1qXmWDkDoHo6m7OVaBP1Od7MUqbMWWKkw7uDr0naQGd2gNgEWMRtDFVxq/8I3T/YsLHe3qw0KDE49XuTdhqIWFQ7ZwOeyQ7sXPdIMo7hGRJ0YLdfAhvNUpw1k0Ogz9taxYT2kR6zZSCbv02PqhY90l6MWrO3Yy2WWBM/7poS/uqJzuP5EqzvMd71XczTBEuXtAB2U/f5f5wUW0mR/hw3w==
Received: from DU2PR04CA0067.eurprd04.prod.outlook.com (2603:10a6:10:232::12)
 by GV1PR03MB8077.eurprd03.prod.outlook.com (2603:10a6:150:1c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 14:50:54 +0000
Received: from DB1PEPF000509FE.eurprd03.prod.outlook.com
 (2603:10a6:10:232:cafe::48) by DU2PR04CA0067.outlook.office365.com
 (2603:10a6:10:232::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20 via Frontend
 Transport; Mon, 7 Oct 2024 14:50:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.87)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.87 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.87; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.87) by
 DB1PEPF000509FE.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8048.13
 via Frontend Transport; Mon, 7 Oct 2024 14:50:53 +0000
Received: from outmta (unknown [192.168.82.133])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id 0374D20080F8B;
	Mon,  7 Oct 2024 14:50:53 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (unknown [40.93.64.8])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id C5BBB20080075;
	Mon,  7 Oct 2024 14:50:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHuBBEVO+seTkwe+CaT8sMU/3sPlUPuYewgs2lAXnStewL0RnsmyDuPq2WoF5RaovmdqRmqOTPxOYVVsznH0tqDf89+KKOyVwpJtKXxEDznpmEl0LY4PiRoJciFY9AeH7VOoTgeWCVnMfDVZunOh7CjdnbFI/01VunqQ2LKgJP3gf+sP8kstHXMeoMUeDKwpQWSN1FHo/mtqyfJt/T2GeIZ73E6JPjzmPS3FEybOsT/8bL7yKA+iaGrMobNbY+De5eNAEU0ulsiFw5GspQprfjs43H5wLT0C9zZ23elXoMSBW8gZSAgpjfYDOgLPGzz/TW8UsZarisl6fb6W67lCxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPFSMuCjZClYWkswJ2p2XSKOnk+4bXHyH8jUqCUAoe0=;
 b=LmbSBsuIIMCYYqjsAtcbD/weuBrCzBNiglbZdeMSKuE16nQim7tEUMIvPoSNvBhE1VtJZaR03y49dM3YUFwcnC+cm+JZxsNSzTILoHhE10/JxIPVdPwGvCoE1YVccqWg47s8aoso/zav6pwUda+EJSoMvg09S+heI0h9L7pazs0/DSocI/EagYRYvg/ANULtDNKeSMIVGXx49FITRw9mxcoa/2iNvNT7oaDUNNWxrp6kf6Hou2lomzftL8M2u/FptAnuEkfD4YJjQXTOZJ8WqAYS1XFXXDoR2nJfMHDpiirycepHKi7Ig66UR0HS/jTqrq4UUzl1DVxkeozvt0p0Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPFSMuCjZClYWkswJ2p2XSKOnk+4bXHyH8jUqCUAoe0=;
 b=tJ0GcxTve069MfQ2rjNxmWee2aCOB/zc5yEKnehNRkhNgly2wKnWnBNU5EqM3yPc3JlmZoERfSu5dAdsAndQeJN+VUn0zazriqK3TcUOdKjw3u8rrNMxKglYAN6/PP5p6TbHg7B2PKYdC5nt+U2Ykw3IWKgOMX3C47XjTxlYZ7/WhDh82BPZqygTYQLKrzlOEscuNPpHTOo2Td29z0+OY4CR4NVzT1npEQGgZJYzY56rGFkEG1MRHwgEWYL5x8W6JuJbRUfel+RN9+DJmkK9BgCkNngxElH0WrN0bYyky4mn61j5Uq3Fqk/Ky7k1PFVSKZD5SXmPPByGJiON9Jgaqg==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
 by AS8PR03MB6744.eurprd03.prod.outlook.com (2603:10a6:20b:292::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 14:50:49 +0000
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce]) by PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce%4]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 14:50:49 +0000
Message-ID: <264db5ee-17af-4fff-8253-859c2c39bfed@seco.com>
Date: Mon, 7 Oct 2024 10:50:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net: dpaa: use __dev_mc_sync in dpaa_set_rx_mode()
To: Jonas Rebmann <jre@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Madalin Bucur <madalin.bucur@nxp.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de
References: <20241007-igmp-speedup-v1-0-6c0a387890a5@pengutronix.de>
 <20241007-igmp-speedup-v1-2-6c0a387890a5@pengutronix.de>
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20241007-igmp-speedup-v1-2-6c0a387890a5@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR01CA0044.prod.exchangelabs.com (2603:10b6:208:23f::13)
 To PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAVPR03MB9020:EE_|AS8PR03MB6744:EE_|DB1PEPF000509FE:EE_|GV1PR03MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aa81044-ad33-4447-6628-08dce6df715a
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?SW1sczBqZGxsZ21XOFpveHNBTGRFMnNxZDI5RzZnSWoyTWRWblZFYVV0aC9n?=
 =?utf-8?B?dWJJVjFhb2ZxejdkM2VQeTlEc0I4L3pEUjNROHhwam0waktMZ0V6b2hYQUI0?=
 =?utf-8?B?NTNnMTZscm55d2daWTNlS3ROQ1lvZjlmQ0w3RHVTdkRrc0U1eGF1T2VZL3JM?=
 =?utf-8?B?RCt0ai9BTHBpb05hK2pSOGVscDZLOGNIOVlOQnh3RGhhK3BEMEdlVVk5bnBz?=
 =?utf-8?B?VW44TTdLb2dRc1BpWVBCOHRkWmZxdmExVm1NYUR5Z0pSRmthbWdBcnc0eDlw?=
 =?utf-8?B?eWVxV3Z5RHJpem9OL2Mza0lEcXBIeHRTak5LOEx0NkhSQnVwVG9FVDVKNzc1?=
 =?utf-8?B?aElYZFVJUlBNakpJbEloREtNOHVMaVZQMFo1YkFiNC90N1NjeE9kWkhRUTA4?=
 =?utf-8?B?Z2FHMFBSZFJsZ0YrQ1daNHhQR3U2QVRYRFU0NnJDcmNIK21WVUQyWWxDVC94?=
 =?utf-8?B?N3hKY2ZIMWxwMnZZRGJHL1BOc1lQYjRlUzBFZVE1cllQVWg4UFBoZkZ1TnRH?=
 =?utf-8?B?SzlQS3gwOHE5NWZyUmtVZmEvYVNaUHdHNW8xeTFDMjdZeVpadUFtRnRNYWls?=
 =?utf-8?B?UVZvVGx0b1RlUjluTnVJZEJocGE0S1RIYVhWMkxNVDFpdlJBb3NmUUU5b3cz?=
 =?utf-8?B?c25VQmxTSS9OUjgxMWs1U0RTNENWWTRTSkFwcE5IRi96U1dUSmxZbHUzQzJi?=
 =?utf-8?B?VGxVVGI4NHBsVkNJTUU0MDN5ZTJOK0d2R3JsWWI2UXd6NlducTQvMnNEaktX?=
 =?utf-8?B?ZlJ2WHZCWnhJMVg2bkg3aFJab2FoblR4cDQyWnY0L1VvR0o0NXExNlRrTHl6?=
 =?utf-8?B?QmUzTi9FRmY1cDJyZFVOMDFOdk1MdlJQUVR5NnczalRoOXcvQ05TUll3c2pz?=
 =?utf-8?B?T0FSOEpEeHEyTTVDd1N3ZXpVZm5INGFMMFJKQnBUcGd1QTRkdWdRalVxdWox?=
 =?utf-8?B?L2huSkVhS0wvaS9GckphTlp2MGR2U3hhRnlXeGFabC8xeGhrb2h4MUI4akI2?=
 =?utf-8?B?TmhzVDl6NEdiaGFPWU5MMktEVGtraE4xYytHcktRbjl5VERuSHNOZ1RyZTBs?=
 =?utf-8?B?eVJqSUxUbS9nWWdPZnJuQnpHQy9xWmVvZ3JjWEwrYW8xZnAzcDBJcFIrVkFE?=
 =?utf-8?B?K1ZXcmZyVmRFUGNUSEZoV3c2bVFDYk5SSXkxUFRhR1JNZ2J4K0dreGZwWTdT?=
 =?utf-8?B?RkNvMXlNZkxDQzJTRVZ4em11dDZIdVlQSGVpN1lWWTVmbGRUcTNmeHBObHZH?=
 =?utf-8?B?RmhsK1dpYm9qV29laGJsWFpnenR2ajhDUUZrTnFTRk1EZlpodEk4QkpQOTVo?=
 =?utf-8?B?MGljQVNqTWU3VDlPcWRMY1pGeWxEYStOYW9rcmRtNk5hd25mN0xVRnRhS2Ns?=
 =?utf-8?B?M2VkUmhUTW55eVZCL1FoRDhjUklORS9hMUVyamVFZzh3QkVYWDVwWERDUWFs?=
 =?utf-8?B?K2RYUElvS1FyUUJ5c1Y0R1BPcEtsOUQ2blBVajRMcE9laU9QbjFPeUFrQ21Y?=
 =?utf-8?B?U2k5L0RnNm5LUnRCSTVLbFQvQVdBalJKemxyeVlPWDNVakVWVW0yK042REpP?=
 =?utf-8?B?U241SXBCcHhpRFhyVmh3NFJaUXZsYXVoc2hvN2RrOE9WaFFYWE1SdTYxcS9v?=
 =?utf-8?B?TTVwWXdjVHEvMXVPeXlSNTNYNWtLVkdqZHFFTmpyWWRoQmdaNVZFYzR0bmdx?=
 =?utf-8?B?L0NubGJuUGVITnFTQTlOSDZwa0IwL1E1OGdDdFFTUEMvUmRCNjQzRkROTUtt?=
 =?utf-8?B?TURDVGhxTCs3cmpSZDFrZGQwWUlNb2wvSHZPNWNwUU1BcGl4OGI5M2xodGpk?=
 =?utf-8?B?U0pjRk11SDBSWU1zOWJSZz09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR03MB9020.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6744
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509FE.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	dfa6d10d-3d2f-4aa5-3be1-08dce6df6eb7
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|35042699022|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czNzazN2cXVlSzI3UWNQM2RjREhTc0JCTXpDcnBSV1FaVXVpTDE0UkwvUnBO?=
 =?utf-8?B?UmkxR0Y4RHdmc093WmRhUWk4YUxWaVJFQlg2VE1ZOWVkSGZ5V1JHcGJTckRD?=
 =?utf-8?B?VHhZM2szU2pHOElKWWZJYktva2FIa2hwWnY4S0R0Q3RVdWYxNU9NQW0yQ3lG?=
 =?utf-8?B?L21WTlZ1NWVHVXJOZHBTeEZvNFVud0JRWnFyM1VJclE3TDViTnBieGRwOW1T?=
 =?utf-8?B?ZTFsRnQrQkVZNkVyNy9KSzUzelY2MHJqakp2cHJkVkRlaVI3azRiSGpMM0RG?=
 =?utf-8?B?bEsxMmViQ29WWloyVVVMMWg4RnpPWWozNHExb01QcGl2VDRvWHcwL2tmTitY?=
 =?utf-8?B?eDhDTHpoaTNKQktaK25uSzJ3ZUpnQ2RtUlI2Q25TTDFkSFZPaVdoN2M5NG55?=
 =?utf-8?B?dXBYOUJrUjJtQ1NJN3ZmU2dzNHVXQVpxK0U3Y0NxYzVvS3Zzempqdm1pRmRp?=
 =?utf-8?B?ZjNuR1dNRUhVbGJaMEU5a3Z2Sm90S3p1NG5TTi9qLzNPdlVpNHE0cmtaS0ZT?=
 =?utf-8?B?d2hsZmFJNG5sOWJTS3NheW9QaVQxSXRnZytFekpkZkRlSWpoYzhKeTNFSUtE?=
 =?utf-8?B?R2xQcEUzY0pib1VLb3JETEQvandycWRHTVkyYVJBR3pkSDBreWx6L1RnelFa?=
 =?utf-8?B?M3ozVFpkTDdSNjlpNTdUWFR4c3FnQkNjb1BxTmZVNzluSzhUZTc5RGhaMk9m?=
 =?utf-8?B?bUJzc3hzSWt5NkZKRUNNcnd3dzR5dWt5Vzg3em10eHBENFZQYUhUSnpTMldq?=
 =?utf-8?B?SEFwdWg3bWJpelRVZ29MUjRCY0xvM3VKSGkvZW9iR0FFeXR1UkJxU2lteUVY?=
 =?utf-8?B?aUpEdGRONlYwR25IZDhad2I2djB1bSthNHJxN3VnYW9rRzdURUwyb1c1K1M5?=
 =?utf-8?B?TXo0cmU0QmdZNTV6cTZYMmVidE9MVFVla3o2emVXSEEwNWI2Y2JRU1Z1T2g0?=
 =?utf-8?B?RzZ1azJIZnpDcHlGYXBZR0VJdzdRL1AvbkpKbFNpVHY4SXJwZ2tHMTBKd0RX?=
 =?utf-8?B?cWVZQjZSQlJveThUdmc2bXNVV0FiK1dPN09RN0NzK1k5eFRBdXRQcjJTNUxy?=
 =?utf-8?B?QndQWWlNVGhqSXdHMStPQTkwVVBDWWZLT21oRzhlWStDNU1hcmpBV2ZXYW1H?=
 =?utf-8?B?cnNDYnZRc2puVEU2eDBxNkJHQlh4d2pwdWhZejdTY01XZkZjUTlLc3MxOGlY?=
 =?utf-8?B?ZWd4eGwrdmpiVXB1OWxuTko5UDk3U09acU1ZOEJWNWxHdVhUVDQzT1g5dFVZ?=
 =?utf-8?B?WlhhYm1QdGVpVmZqb1pIcmpDWDhUMGFzanp4ck9YYVlyaDltazB4YmdYVVM4?=
 =?utf-8?B?YkVIVmdKS2lkYkVSeHhLTnhuaXRrUHlFWWh5K0FjcXBBc2NEd0tHSzhiNUtZ?=
 =?utf-8?B?NWwyaEd4V3h1eklXOERPc3hkRlM2ZUNlbDRHSVJtNnhVSmloS0dNQjFhZUFi?=
 =?utf-8?B?cENLWGhIaFFhbXZDbHQyUXE0cjEzUEdJY2E3MDFLRDBqUVFRekdlNnpnVXh2?=
 =?utf-8?B?LzlhK3Vub1ZlQVFkam1vWnJ2YnNzczlvTVBXaGZJTEdZR05YT1cvWERoNFov?=
 =?utf-8?B?K1FrOWIrMTB2VG9IMjc2aC9GWVZ0eWVMalNCYk53THhkKzFPWmNtY2x6U1JH?=
 =?utf-8?B?N1Z4bEwwczhBblVpRTFhZy9OU0lWSWJnMXhoT0JrOGhJZjJrZDJldXkrRFph?=
 =?utf-8?B?QzdvY3pDZktaN2FzV1dsR01yS2ttMlJKdUhPMEdZWS9QdWhvaitFRFo5RmQz?=
 =?utf-8?B?a21tZCt3cys0azlLWmlybDV4eXhiRW1EVSt0bVU4b0NDTVVTblNoTjhGUlBq?=
 =?utf-8?B?UDlMZFk3MmZLT21jRFdRY0JUWFhhS3VhQStpS2Z3bXlJZS9iL1piK0NEY1NR?=
 =?utf-8?Q?zP3q5oSyETT1l?=
X-Forefront-Antispam-Report:
	CIP:20.160.56.87;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(35042699022)(36860700013)(7416014);DIR:OUT;SFP:1102;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 14:50:53.2675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa81044-ad33-4447-6628-08dce6df715a
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.87];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB8077

On 10/7/24 10:17, Jonas Rebmann wrote:
> The original driver first unregisters then re-registers all multicast
> addresses in the struct net_device_ops::ndo_set_rx_mode() callback.
>
> As the networking stack calls ndo_set_rx_mode() if a single multicast
> address change occurs, a significant amount of time may be used to first
> unregister and then re-register unchanged multicast addresses. This
> leads to performance issues when tracking large numbers of multicast
> addresses.
>
> Replace the unregister and register loop and the hand crafted
> mc_addr_list list handling with __dev_mc_sync(), to only update entries
> which have changed.
>
> On profiling with an fsl_dpa NIC, this patch presented a speedup of
> around 40 when successively setting up 2000 multicast groups using
> setsockopt(), without drawbacks on smaller numbers of multicast groups.
>
> Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
> ---
>  drivers/net/ethernet/freescale/dpaa/dpaa_eth.c   | 20 +++++++++--
>  drivers/net/ethernet/freescale/fman/fman_dtsec.c |  1 -
>  drivers/net/ethernet/freescale/fman/fman_memac.c |  1 -
>  drivers/net/ethernet/freescale/fman/fman_tgec.c  |  1 -
>  drivers/net/ethernet/freescale/fman/mac.c        | 42 ------------------=
------
>  drivers/net/ethernet/freescale/fman/mac.h        |  2 --
>  6 files changed, 18 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net=
/ethernet/freescale/dpaa/dpaa_eth.c
> index 6b9b6d72db98c22b9c104833b3c8c675931fd1aa..ac06b01fe93401b0416cd6a65=
4bac2cb40ce12aa 100644
> --- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> @@ -463,6 +463,22 @@ static int dpaa_set_mac_address(struct net_device *n=
et_dev, void *addr)
>         return 0;
>  }
>
> +static int dpaa_addr_sync(struct net_device *net_dev, const u8 *addr)
> +{
> +       const struct dpaa_priv *priv =3D netdev_priv(net_dev);
> +
> +       return priv->mac_dev->add_hash_mac_addr(priv->mac_dev->fman_mac,
> +                                               (enet_addr_t *)addr);
> +}
> +
> +static int dpaa_addr_unsync(struct net_device *net_dev, const u8 *addr)
> +{
> +       const struct dpaa_priv *priv =3D netdev_priv(net_dev);
> +
> +       return priv->mac_dev->remove_hash_mac_addr(priv->mac_dev->fman_ma=
c,
> +                                                  (enet_addr_t *)addr);
> +}
> +
>  static void dpaa_set_rx_mode(struct net_device *net_dev)
>  {
>         const struct dpaa_priv  *priv;
> @@ -490,9 +506,9 @@ static void dpaa_set_rx_mode(struct net_device *net_d=
ev)
>                                   err);
>         }
>
> -       err =3D priv->mac_dev->set_multi(net_dev, priv->mac_dev);
> +       err =3D __dev_mc_sync(net_dev, dpaa_addr_sync, dpaa_addr_unsync);
>         if (err < 0)
> -               netif_err(priv, drv, net_dev, "mac_dev->set_multi() =3D %=
d\n",
> +               netif_err(priv, drv, net_dev, "dpaa_addr_sync() =3D %d\n"=
,
>                           err);
>  }
>
> diff --git a/drivers/net/ethernet/freescale/fman/fman_dtsec.c b/drivers/n=
et/ethernet/freescale/fman/fman_dtsec.c
> index 3088da7adf0f846744079107f7f72fea74114f4a..85617bb94959f3789d75766bc=
e8f3e11a7b321d5 100644
> --- a/drivers/net/ethernet/freescale/fman/fman_dtsec.c
> +++ b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
> @@ -1415,7 +1415,6 @@ int dtsec_initialization(struct mac_device *mac_dev=
,
>         mac_dev->set_exception          =3D dtsec_set_exception;
>         mac_dev->set_allmulti           =3D dtsec_set_allmulti;
>         mac_dev->set_tstamp             =3D dtsec_set_tstamp;
> -       mac_dev->set_multi              =3D fman_set_multi;
>         mac_dev->enable                 =3D dtsec_enable;
>         mac_dev->disable                =3D dtsec_disable;
>
> diff --git a/drivers/net/ethernet/freescale/fman/fman_memac.c b/drivers/n=
et/ethernet/freescale/fman/fman_memac.c
> index 796e6f4e583d18be6069f78af15fbedf9557378e..3925441143fac9eecc40ea45d=
05f36be63b16a78 100644
> --- a/drivers/net/ethernet/freescale/fman/fman_memac.c
> +++ b/drivers/net/ethernet/freescale/fman/fman_memac.c
> @@ -1087,7 +1087,6 @@ int memac_initialization(struct mac_device *mac_dev=
,
>         mac_dev->set_exception          =3D memac_set_exception;
>         mac_dev->set_allmulti           =3D memac_set_allmulti;
>         mac_dev->set_tstamp             =3D memac_set_tstamp;
> -       mac_dev->set_multi              =3D fman_set_multi;
>         mac_dev->enable                 =3D memac_enable;
>         mac_dev->disable                =3D memac_disable;
>
> diff --git a/drivers/net/ethernet/freescale/fman/fman_tgec.c b/drivers/ne=
t/ethernet/freescale/fman/fman_tgec.c
> index c2261d26db5b9374a5e52bac41c25ed8831f4822..fecfca6eba03e571cfb569b8a=
ad20dc3fa8dc1c7 100644
> --- a/drivers/net/ethernet/freescale/fman/fman_tgec.c
> +++ b/drivers/net/ethernet/freescale/fman/fman_tgec.c
> @@ -771,7 +771,6 @@ int tgec_initialization(struct mac_device *mac_dev,
>         mac_dev->set_exception          =3D tgec_set_exception;
>         mac_dev->set_allmulti           =3D tgec_set_allmulti;
>         mac_dev->set_tstamp             =3D tgec_set_tstamp;
> -       mac_dev->set_multi              =3D fman_set_multi;
>         mac_dev->enable                 =3D tgec_enable;
>         mac_dev->disable                =3D tgec_disable;
>
> diff --git a/drivers/net/ethernet/freescale/fman/mac.c b/drivers/net/ethe=
rnet/freescale/fman/mac.c
> index 43f4ad29eadd495ce7f4861b3e635e22379ddc72..974d2e7e131c087ddbb41dcb9=
06f6144a150db46 100644
> --- a/drivers/net/ethernet/freescale/fman/mac.c
> +++ b/drivers/net/ethernet/freescale/fman/mac.c
> @@ -32,8 +32,6 @@ MODULE_DESCRIPTION("FSL FMan MAC API based driver");
>  struct mac_priv_s {
>         u8                              cell_index;
>         struct fman                     *fman;
> -       /* List of multicast addresses */
> -       struct list_head                mc_addr_list;
>         struct platform_device          *eth_dev;
>         u16                             speed;
>  };
> @@ -57,44 +55,6 @@ static void mac_exception(struct mac_device *mac_dev,
>                 __func__, ex);
>  }
>
> -int fman_set_multi(struct net_device *net_dev, struct mac_device *mac_de=
v)
> -{
> -       struct mac_priv_s       *priv;
> -       struct mac_address      *old_addr, *tmp;
> -       struct netdev_hw_addr   *ha;
> -       int                     err;
> -       enet_addr_t             *addr;
> -
> -       priv =3D mac_dev->priv;
> -
> -       /* Clear previous address list */
> -       list_for_each_entry_safe(old_addr, tmp, &priv->mc_addr_list, list=
) {
> -               addr =3D (enet_addr_t *)old_addr->addr;
> -               err =3D mac_dev->remove_hash_mac_addr(mac_dev->fman_mac, =
addr);
> -               if (err < 0)
> -                       return err;
> -
> -               list_del(&old_addr->list);
> -               kfree(old_addr);
> -       }
> -
> -       /* Add all the addresses from the new list */
> -       netdev_for_each_mc_addr(ha, net_dev) {
> -               addr =3D (enet_addr_t *)ha->addr;
> -               err =3D mac_dev->add_hash_mac_addr(mac_dev->fman_mac, add=
r);
> -               if (err < 0)
> -                       return err;
> -
> -               tmp =3D kmalloc(sizeof(*tmp), GFP_ATOMIC);
> -               if (!tmp)
> -                       return -ENOMEM;
> -
> -               ether_addr_copy(tmp->addr, ha->addr);
> -               list_add(&tmp->list, &priv->mc_addr_list);
> -       }
> -       return 0;
> -}
> -
>  static DEFINE_MUTEX(eth_lock);
>
>  static struct platform_device *dpaa_eth_add_device(int fman_id,
> @@ -181,8 +141,6 @@ static int mac_probe(struct platform_device *_of_dev)
>         mac_dev->priv =3D priv;
>         mac_dev->dev =3D dev;
>
> -       INIT_LIST_HEAD(&priv->mc_addr_list);
> -
>         /* Get the FM node */
>         dev_node =3D of_get_parent(mac_node);
>         if (!dev_node) {
> diff --git a/drivers/net/ethernet/freescale/fman/mac.h b/drivers/net/ethe=
rnet/freescale/fman/mac.h
> index fe747915cc73792b66d8bfe4339894476fc841af..be9d48aad5ef16d6826e0dc3c=
93b8c456cdfa925 100644
> --- a/drivers/net/ethernet/freescale/fman/mac.h
> +++ b/drivers/net/ethernet/freescale/fman/mac.h
> @@ -39,8 +39,6 @@ struct mac_device {
>         int (*change_addr)(struct fman_mac *mac_dev, const enet_addr_t *e=
net_addr);
>         int (*set_allmulti)(struct fman_mac *mac_dev, bool enable);
>         int (*set_tstamp)(struct fman_mac *mac_dev, bool enable);
> -       int (*set_multi)(struct net_device *net_dev,
> -                        struct mac_device *mac_dev);
>         int (*set_exception)(struct fman_mac *mac_dev,
>                              enum fman_mac_exceptions exception, bool ena=
ble);
>         int (*add_hash_mac_addr)(struct fman_mac *mac_dev,
>
> --
> 2.39.5
>

Reviewed-by: Sean Anderson <sean.anderson@seco.com>

[EmbeddedWorldNorthAmerica2024, SECO SpA]<https://s2.goeshow.com/nmna/ew/20=
24/registration_form.cfm>

