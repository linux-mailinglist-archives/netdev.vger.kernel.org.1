Return-Path: <netdev+bounces-287539-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCFZO/laBGqjHAIAu9opvQ
	(envelope-from <netdev+bounces-287539-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 13:05:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DBC531DC1
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 13:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1A9730078BA
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 11:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CB23E9C2C;
	Wed, 13 May 2026 11:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="FTJCAcvH";
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="FTJCAcvH"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021115.outbound.protection.outlook.com [52.101.65.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAAB357D04;
	Wed, 13 May 2026 11:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.115
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778670072; cv=fail; b=R3b9aUnGMWfDa+lKUYrVPVKx7IvXTfeYYhXTyO4ANYqfLLtz6/NNu4rfmh0lKQcy8+s2lpId94UHyrpAozE8h2Q8eBQYv5Dm87wSNZ1MuG2X0Up3ca6NqV1PmOzqD1TbDrrMQ12l3+ul0alxqI9bXeHBN3+Bl02qs3L94z5OKgk=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778670072; c=relaxed/simple;
	bh=25YUbMwiwCLL7dCOFpySp8e5FHJht6bLacdC7abNLU4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QniJAYQIdJte8euCN0hfrQJAn5LnNwsxzsMjQRhI+FttSMTr8lKyYRqMXYsCxg/xcHQ2q2stxOlJD0OWAaTKzJWuMwIEwKgfcTuOtpBjPDrHUutPbtjr90A7FZBohKnO3Ef0hol1ISOrkY7guom7u2YY3NeGa6m/pzOLCsA/86Y=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=FTJCAcvH; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=FTJCAcvH; arc=fail smtp.client-ip=52.101.65.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=keThulHYWuCMF/cuNZGXCP3Cuedqlj5eNBERoS3Cp9H0/JddC2nWDs/7qD3wzftFZ68mtPWg+6OlLoW41ywL8jb7pxMEx8pcypg86LNI+d14YPZ3MH7+wH2SnFhHIsYnGfE7cOVeTL10T1z309986q9pWo7VLjyOyB5+3l/1jGFXtTQaZL3IHK0Nm7pvEtlDf73ZZ5koaFkCIAn3rf1PLeOehaettX+wT6UG8sFraHfHtBg+lSha3y3wub1TL9Nvruc+U4RuOXGwcf/KhkzbbgVbKNVIlEGzLadgjdZGEmX7vPdR0bUiwBT64BgAztG45L85AZC1NguuK44ryFYGHQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25YUbMwiwCLL7dCOFpySp8e5FHJht6bLacdC7abNLU4=;
 b=jr1YeQhuNfHZU5h5/BrfFbCLve1ZjRGcpTVUDiiwILNTJfqmzoiYMfTYKLVKhAKOyaA4vIrdemFfpCKs181Urc8IVhvmBIA5alhuYqLj3psnqd7kPt0ac+My3yiZJUgF37rrh2sBfiebMsYWqklGK/mwAW2TJLU/GZnBLIn/IMLVPPfnF+w+rBeofR7GQo+Iv47jjGUXC41JL8PO93h6bE3odAzr5ib/vF2Qb7u0tBNt4FLsEFtH57RzkHH0wn3bQRIEDFF7HDTNwjgNLK7PXE6203IV0AGrBTe8P/wZhk8SoPw8c6TN8iZ/vF14sIqLtIR0ynLG5EHQWS9+EJrunw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=kernel.org smtp.mailfrom=solid-run.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=solid-run.com; dkim=pass (signature was verified)
 header.d=solid-run.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=solid-run.com] dkim=[1,1,header.d=solid-run.com]
 dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25YUbMwiwCLL7dCOFpySp8e5FHJht6bLacdC7abNLU4=;
 b=FTJCAcvHS4W9hTjhqBEUyHF3pcOvwUY8i0FFykEuWNHXOKuvrrvAVEeTOYycsgGhKGhz6rIvatrFhvuTfXEo1kWnEPdgPO7Gxjk6FF0hXN0OMc7TmMBB1ZGSzv5Dyl6RkRg/lV+YtyfOYR7Hc+YN/Tte4VJrnIZXnC+vmsqTs/a9TDoCe6EHdNkNVJe5UunnO32/wsAOajQOrrLtqZ7oRXo3Hlx/BspeqSVJgDltFPE6h1ylie3Kz4peLGwTuXVGRYN3cINYnxHGU71Iz3VNbv09SEHZZT1c3qDRmY4vH2Mo2EcoPhElRYVlb0BY/aC+34dxoQ6KIogYbudnZZJpMg==
Received: from AS4P250CA0004.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5df::12)
 by AM8PR04MB7876.eurprd04.prod.outlook.com (2603:10a6:20b:240::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 11:01:07 +0000
Received: from AMS1EPF0000003F.eurprd04.prod.outlook.com
 (2603:10a6:20b:5df:cafe::f3) by AS4P250CA0004.outlook.office365.com
 (2603:10a6:20b:5df::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Wed, 13
 May 2026 11:01:07 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solid-run.com;dmarc=pass action=none header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS1EPF0000003F.mail.protection.outlook.com (10.167.16.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.13
 via Frontend Transport; Wed, 13 May 2026 11:01:07 +0000
Received: from emails-968540-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-220.eu-west-1.compute.internal [10.20.5.220])
	by mta-outgoing-dlp-305-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 5CA0B7FFFC;
	Wed, 13 May 2026 11:00:52 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Wed May 13 11:00:34 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uGRk2E09ljs1vETt7KyyxNxN8dE8D7diroLlIcc7QyCi2fy97lYDNy0G3w9ey5rj24VhbQSIDs/w48mZ1jnrZTek1t8+VJV0MC7R83iWQr3xuA07m/EJqXl8rZNzyNxAqgNN6xoFFTalBGw33u0Hp6XhlucokNMZevdLGQ1N5oyPViIOnWHRz4PKH1ExW8fjvhm4PB0Q/lQu04/fAHfxJ5n584S4KnEOSYAV3LAk2jLY4u3x1pBHxf7dbbYRKNvaoTbZ2uqK1dBXZbykX3zlO0gj+MXGqHReCG7ft0ziDDpvlqTNJ8WaETvHtdyAUxlNfwLFWkAUPTXP2P1zkGwQQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25YUbMwiwCLL7dCOFpySp8e5FHJht6bLacdC7abNLU4=;
 b=aRMRUWQED5R3OfBlrA8cuZwd8ApGyzSdCZvBD4zVZp/f1QEGTDNWNf5mssiaNmc0poPHUhI1RgxzzfG0cJGln0pAbxepRM7s0pCZ1Uyx3d4JwaCuKaIw8Jx3XenqBUyrCF+5eqDSVKswiJ+OX0Aj8lpO92SicX10MRfP2UNaA9uR6sy8Tt2y/CagbMi9AKKHIAZCJFcjPwjZDC9ooz1wuj7nJX9al/doiI/BFz87mzmgThZpECtBLKL43ErYkVD492rYeRQ95/Vvt8scK5Lo4zpuS5fN6XH5nQGoHOXhih4th2IKoo8xg7G7bzmJkP1PVdCOKdP+Dl2cHgV85NSoGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25YUbMwiwCLL7dCOFpySp8e5FHJht6bLacdC7abNLU4=;
 b=FTJCAcvHS4W9hTjhqBEUyHF3pcOvwUY8i0FFykEuWNHXOKuvrrvAVEeTOYycsgGhKGhz6rIvatrFhvuTfXEo1kWnEPdgPO7Gxjk6FF0hXN0OMc7TmMBB1ZGSzv5Dyl6RkRg/lV+YtyfOYR7Hc+YN/Tte4VJrnIZXnC+vmsqTs/a9TDoCe6EHdNkNVJe5UunnO32/wsAOajQOrrLtqZ7oRXo3Hlx/BspeqSVJgDltFPE6h1ylie3Kz4peLGwTuXVGRYN3cINYnxHGU71Iz3VNbv09SEHZZT1c3qDRmY4vH2Mo2EcoPhElRYVlb0BY/aC+34dxoQ6KIogYbudnZZJpMg==
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 (2603:10a6:150:313::24) by DB4PR04MB11277.eurprd04.prod.outlook.com
 (2603:10a6:10:5e5::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 11:00:32 +0000
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b]) by GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b%7]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 11:00:32 +0000
From: Josua Mayer <josua@solid-run.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Ioana Ciornei
	<ioana.ciornei@nxp.com>, Vinod Koul <vkoul@kernel.org>, Neil Armstrong
	<neil.armstrong@linaro.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH phy-next 5/5] phy: lynx-28g: add support for 25GBASER
Thread-Topic: [PATCH phy-next 5/5] phy: lynx-28g: add support for 25GBASER
Thread-Index: AQHc4VcBNwfvvLflf0GuY4D0POuBgbYLzL+A
Date: Wed, 13 May 2026 11:00:32 +0000
Message-ID: <375dddbc-385c-4dcb-a280-33292215ae67@solid-run.com>
References: <20260511150023.1903577-1-vladimir.oltean@nxp.com>
 <20260511150023.1903577-6-vladimir.oltean@nxp.com>
In-Reply-To: <20260511150023.1903577-6-vladimir.oltean@nxp.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-traffictypediagnostic:
	GVXPR04MB12057:EE_|DB4PR04MB11277:EE_|AMS1EPF0000003F:EE_|AM8PR04MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ed4707b-da62-42b8-854a-08deb0deef41
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|22082099003|3023799003|18002099003|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 4DhQbR/tXpUOulLNAJdGXYiVxWdI7zZv9B6ytVA8zVxKHv2rR5hQHCB5f/8lQZud0mKKTr2JkWW9/nEVpFFLYHLF4x3dktfRlgo9IohPCdpWbx156HNv/ZkGPiQAgn8uVL2Q6aVkk2hMgAItrFaxaSR74bcMnTr4tohX+BGAJSOvud+8faM91g0JyTiUAgQ+V3W6JjCTTIbRY5pmLSu9fkl6jX3LfZUIX8IgGva8DMw3N3KZSwf/CLC2iaD8qW2YsnRWowWUVCUsYLqkj0kixmacaOvXg5+1r1B/Q9rLNe+5IjSyfAW7fSjJL28r9JL0goHmKqPH+ZizEXUQlvDnBBA2Z2jqVqZ0CrEtGeX/cVMNMM+0lxzfBzIK6CohfcGNR2XwoQnyibVkKKAuCuLG0WBcvB8kzd1O4mYETNG+GKd6K4Xc7AoLDCUd5uvBq0f/Xa0ZtVKhHg/4FmNFkUZXQyY2jWBtbMGjgn8eQdV66sVZx0SCWATe7uQC53ZGyPC76f32e5g0N/mmUME++1618GdhAn9jTV/ZMpBS3aYjT0Ak5+6iGtSKgSaG/o+4/IgsKPlxxplJRHA9rOf84fD4Hzgp4cmyy1EDwg899VWpfDloDPB0sJV3gZTMWbT2VtLkthSkMmo6TuVS1uO9mYwuW7OQq41dadU3Z1zvro8R0pbTEAQfPHynO5BTf9ZO0jVIXUc+dwrmKjOpH9Evyn258OafG7irYvAXm7HOnc0+VqaAmLV/3wIDb12ZljRgsMah
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12057.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(3023799003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <19B055E9EDD8F946942BED91BDEBA291@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
 vOaOjEzs0Sv4I5yBs3QVZnvWUZSRimb4JhNkZYqAsSdOagYkDsrxj57QAzqquFfYEZLkHikq92/dTWUpOJGhQmGLLYoBao56L7DJttP9Y8jNCvgSn9fd9XrECBOCUDMwubzpLEQv51je4XHSwrgQ2sVwcj6eURqiNiqiFHuS0jz1xu4NmpENsWJrFo30TU/Rh6ESGwzMK3HbJEiCfjqhwdcF8jCayn216IWUWjRzThSBGV+O/Y2yAJlz4nq1kE6n7FEoS59mQ/3D85JPYD6gio3wjh15b6rsImNPAPrfwerdeaA9ra36j75bxHYibjcQa2gCQRKvOXrBuORK34oETA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR04MB11277
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2-7.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 2341ea01ebfd49dda37a7d71be6e497a:solidrun,office365_emails,sent,inline:1412bcce9e7a9c86e8f6ce96ca54cbf1
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF0000003F.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	655b392b-23c0-4390-0b21-08deb0deda2b
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|14060799003|82310400026|35042699022|56012099003|22082099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	xTTUR64LqkTcYTcSgyy+dNRRql0TtKK20v1RjF7ylzHMGH0p9NplbBUNnfKRLX7zbqp+mFKdf45U/36Z6NgEpjCwsM4UBZrhseCGJQ/wxuSvmhkRnGP7s0F96cvWde20WASFcWik1M8iz3DM/ZbXco5Bf23cOxmRXAAK5dPmlsp86KWqKcUnvSG4kj36nRejMdnZdK0W/tdljORVWJWPyd43jvNK5nRryq9n/k1hU8H/yhtRHsBvc9Zlo5gWkbWtQLEN/D47JAMrL7/VB3igqv3xhk0xdgbusO8c7sfqjhdqGFMB5NJd8ievozKGaCF2Gl+kzDtS+DAcEq8QjTufTyfM2ZrYh6ZgPYy2LpTg5UyA6GYS2OEJ7VAZbEOdmhTKVNKzjqsrhsZbUSAQEncjhbwbszvrjGAEWi+NC+L2Ikuj50J3wQ24i/z93WClX0iGMOefkyr8HGCi+LqBsYpmjTL35H1VqW68wh67RWysrBpdSIW7K5dRP4jgGyqdkYOAvjsnVYH2m76HPBNSIVw6DjMXmzW7cfb6dWlhtmRrtHWlapoKgRA4rQAp16eGvDPEtjcwGFH5Nnzu499n24Xj/XB5Osjot3OCu3mDBCIgm+86NxxvSEWgYgmAKzPm74BHQKzeiiWo6wOi1Q+u0is2pV7KnOP0yAFMiLS87VY2i1qDgiIl3h9r7FNGfsNLqJezJcNdwADNb/35rXox0qiEWP5NXNT6mIca5Nh7zChQEV4=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(14060799003)(82310400026)(35042699022)(56012099003)(22082099003)(18002099003)(3023799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	48NUxG63YQEOg6+jh6jjhgprG0gdRe1dJwH4iS9uYeTkfZP+dPwfKTb+7oWVT98V0hgPLi0TcXxedld4/nFk4cKfxWy33vubeISUI4T7fmK9wukWCWi6+tfvcz9Ne112Z8fGLsDGgXVHpNlqHjbEMJq6FeCM3nZVV8188TMEHfv7lPTl4EZbD2AmzNwXZ+hnvow/H1gTsweaRS3igk1M5rEsiLyXtosNuF07Ryt7UlOlU4xyrDR3BxAYJUKc0ZjF4dgLFB+vMHgtXRf8HObjtAjl6B7t72AExjo6ugmDBV34T4FElIwfWcbxSMJ2H6jYTa1+Qn7kw5GzWcxQ4B732cHSM1GSX9Hg2ZDcEO9aKBiCQl5TZz0qHoN6Ct9ln5J+Xoait9Y6rC4ZyqFiQWXiNk8ovXCNpbi/jFjbZDKDXtgreZ5I2jnTSOF5cPL50qrJ
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 11:01:07.5664
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed4707b-da62-42b8-854a-08deb0deef41
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000003F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7876
X-Rspamd-Queue-Id: 56DBC531DC1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=3];
	DMARC_POLICY_ALLOW(-0.50)[solid-run.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[solid-run.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287539-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,solid-run.com:mid,solid-run.com:dkim,nxp.com:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[solid-run.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

DQpBbSAxMS4wNS4yNiB1bSAxNzowMCBzY2hyaWViIFZsYWRpbWlyIE9sdGVhbjoNCj4gRnJvbTog
SW9hbmEgQ2lvcm5laSA8aW9hbmEuY2lvcm5laUBueHAuY29tPg0KPg0KPiBBZGQgc3VwcG9ydCBm
b3IgMjVHQkFTRS1SIGluIHRoZSBMeW54IDI4RyBTZXJEZXMgUEhZIGRyaXZlci4gVGhpcyB3aWxs
DQo+IGJlIHVzZWQgYnkgdGhlIGRwYWEyLW1hYyBjb25zdW1lciBvbiBMWDIxNjBBIHdpdGg6DQo+
IC0gcGh5X3ZhbGlkYXRlKHBoeSwgUEhZX01PREVfRVRIRVJORVQsIFBIWV9JTlRFUkZBQ0VfTU9E
RV8yNUdCQVNFUikgdG8NCj4gICBkZXRlY3Qgc3VwcG9ydC4NCj4gLSBwaHlfc2V0X21vZGVfZXh0
KHBoeSwgUEhZX01PREVfRVRIRVJORVQsIFBIWV9JTlRFUkZBQ0VfTU9ERV8yNUdCQVNFUikNCj4g
ICB0byByZWNvbmZpZ3VyZSB0aGUgbGFuZSBmb3IgdGhpcyBwcm90b2NvbC4NCj4NCj4gVGhlIGlu
dGVuZGVkIHVzZSBjYXNlIGZvciBkeW5hbWljIHByb3RvY29sIHN3aXRjaGluZyB0byAyNUdCYXNl
LVIgaXMNCj4gd2l0aCBTRlAyOCBtb2R1bGVzLCBhbmQgcHJvdG9jb2wgc3dpdGNoaW5nIGlzIHRy
aWdnZXJlZCBieSB0aGUgU0ZQDQo+IG1vZHVsZSBpbnNlcnRpb24uIFRoZXJlIGFsc28gZXhpc3Rz
IGEgMjVHQmFzZS1LUiB1c2UgY2FzZSwgd2hlcmUgdGhlDQo+IHByb3RvY29sIHN3aXRjaGluZyBp
cyBjb3ZlcmVkIGJ5IElFRUUgODAyLjMgY2xhdXNlIDczIGF1dG8tbmVnb3RpYXRpb24uDQo+IEhv
d2V2ZXIsIHRoYXQgaXMgbm90IGhhbmRsZWQgaGVyZTsgaXQgbWVyZWx5IG5lZWRzIHRoZSBzdXBw
b3J0IGFkZGVkDQo+IGhlcmUgYXMgYmFzaWMgZ3JvdW5kIHdvcmsuDQo+DQo+IFRoZSBsYW5lIGZy
ZXF1ZW5jeSBmb3IgMjVHYkUgaXMgc291cmNlZCBmcm9tIGEgY2xvY2sgbmV0IGZyZXF1ZW5jeSBv
Zg0KPiAxMi44OTA2MjUgR0h6LCBhcyBwcm9kdWNlZCBieSBQTExGIG9yIFBMTFMsIGZ1cnRoZXIg
bXVsdGlwbGllZCBieSB0aGUNCj4gbGFuZSBieSAyLiBUaGUgY2xvY2sgbmV0IGZyZXF1ZW5jaWVz
IHByb2R1Y2VkIGJ5IHRoZSBQTExzIGFyZSB0cmVhdGVkIGFzDQo+IHJlYWQtb25seSBieSB0aGUg
ZHJpdmVyLCBzbyB0aGUgYWJzZW5jZSBvZiBhIFBMTCBwcm92aXNpb25lZCBmb3IgdGhlDQo+IHJp
Z2h0IGNsb2NrIG5ldCBmcmVxdWVuY3kgaW1wbGllcyBhYnNlbmNlIG9mIDI1R2JFIHN1cHBvcnQs
IGV2ZW4gdGhvdWdoDQo+IGEgbGFuZSBtaWdodCBoYXZlIHRoZSBhcHByb3ByaWF0ZSBwcm90b2Nv
bCBjb252ZXJ0ZXIgZm9yIGl0Lg0KPg0KPiBJbiB0ZXJtcyBvZiBpbXBsZW1lbnRhdGlvbiwgdGhl
IGNoYW5nZSBjb25zaXN0cyBvZjoNCj4gLSBkZXRlcm1pbmluZyBhdCBwcm9iZSB0aW1lIGlmIGFu
eSBQTEwgd2FzIHByZWNvbmZpZ3VyZWQgZm9yIHRoZQ0KPiAgIHJlcXVpcmVkIGNsb2NrIG5ldCBm
cmVxdWVuY3kgZm9yIDI1R2JFDQo+IC0gYWRkaW5nIHRoZSBkZWZhdWx0IGxhbmUgcGFyYW1ldGVy
cyBmb3IgcmVjb25maWd1cmluZyBhIGxhbmUgdG8gMjVHYkUNCj4gICBpcnJlc3BlY3RpdmUgb2Yg
dGhlIG9yaWdpbmFsIHByb3RvY29sDQo+IC0gYWxsb3dpbmcgdGhpcyBvcGVyYXRpbmcgbW9kZSBv
bmx5IG9uIHN1cHBvcnRlZCBsYW5lcywgaS5lLiBhbGwgbGFuZXMNCj4gICBvZiBMWDIxNjJBIFNl
ckRlcyAjMSwgYW5kIExYMjE2MEEgU2VyRGVzIGxhbmVzIDAtMSwgNC03Lg0KPg0KPiBTaWduZWQt
b2ZmLWJ5OiBJb2FuYSBDaW9ybmVpIDxpb2FuYS5jaW9ybmVpQG54cC5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IFZsYWRpbWlyIE9sdGVhbiA8dmxhZGltaXIub2x0ZWFuQG54cC5jb20+DQo+IC0tLQ0K
PiBDaGFuZ2UgcHJldmlvdXNseSBzdWJtaXR0ZWQgYXQ6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpbnV4LXBoeS8yMDI2MDExNDE1MjExMS42MjUzNTAtNi12bGFkaW1pci5vbHRlYW5Abnhw
LmNvbS8NCj4NCj4gQ2hhbmdlczoNCj4gLSByZXdvcmQgY29tbWl0IG1lc3NhZ2UNCj4gLS0tDQo+
ICBkcml2ZXJzL3BoeS9mcmVlc2NhbGUvcGh5LWZzbC1seW54LTI4Zy5jIHwgOTAgKysrKysrKysr
KysrKysrKysrKysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgODggaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkNCj4gK3N0YXRpYyBpbnQgbHlueF8yOGdfZTI1Z19wY3Z0KGludCBsYW5lKQ0K
PiArew0KPiArCXJldHVybiA3IC0gbGFuZTsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGludCBseW54
XzI4Z19nZXRfcGNjcihlbnVtIGx5bnhfbGFuZV9tb2RlIGxhbmVfbW9kZSwgaW50IGxhbmUsDQo+
ICAJCQkgICAgIHN0cnVjdCBseW54X3BjY3IgKnBjY3IpDQo+ICB7DQo+IEBAIC03NzYsNiArODQw
LDExIEBAIHN0YXRpYyBpbnQgbHlueF8yOGdfZ2V0X3BjY3IoZW51bSBseW54X2xhbmVfbW9kZSBs
YW5lX21vZGUsIGludCBsYW5lLA0KPiAgCQlwY2NyLT53aWR0aCA9IDQ7DQo+ICAJCXBjY3ItPnNo
aWZ0ID0gU1hHTUlJX0NGRyhsYW5lKTsNCj4gIAkJYnJlYWs7DQo+ICsJY2FzZSBMQU5FX01PREVf
MjVHQkFTRVI6DQo+ICsJCXBjY3ItPm9mZnNldCA9IFBDQ0Q7DQo+ICsJCXBjY3ItPndpZHRoID0g
NDsNCj4gKwkJcGNjci0+c2hpZnQgPSBFMjVHX0NGRyhseW54XzI4Z19lMjVnX3BjdnQobGFuZSkp
Ow0KPiArCQlicmVhazsNCj4gIAlkZWZhdWx0Og0KPiAgCQlyZXR1cm4gLUVPUE5PVFNVUFA7DQo+
ICAJfQ0KV291bGRuJ3QgaXQgYmUgbW9yZSBjbGVhciBpbnN0ZWFkIG9mIGluZGlyZWN0IGxhbmUg
b2Zmc2V0IHNoaWZ0IHdpdGgNCmx5bnhfMjhnX2UyNWdfcGN2dCwgdG8gaW5zdGVhZCBmaXggdGhl
IEUyNUdfQ0ZHIGRlZmluaXRpb24/Og0KDQotI2RlZmluZSBFMjVHX0NGRyhpZCkgKDI4IC0gKGlk
KSAqIDQpIC8qIE9mZnNldCBpbnRvIFBDQ0QgKi8NCisjZGVmaW5lIEUyNUdfQ0ZHKGlkKSAoKGlk
KSAqIDQpwqAgwqAgwqAgLyogT2Zmc2V0IGludG8gUENDRCAqLw0KDQpUaGlzIGlzIGVxdWl2YWxl
bnQgd2hlbiBpbnNlcnRpbmcgKDcgLSBsYW5lKSBpbnRvIEUyNUdfQ0ZHIGlkOg0KDQooMjggLSAo
aWQpICogNCkgPcKgKDI4IC0gKDcgLSBsYW5lKSAqIDQpID3CoCgyOCAtIDcqNCArIGxhbmUqNCkN
Cg==

