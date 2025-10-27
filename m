Return-Path: <netdev+bounces-233226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C9762C0EDF0
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 16:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9C34634DE0F
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 15:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19147309F13;
	Mon, 27 Oct 2025 15:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=aeberlede.onmicrosoft.com header.i=@aeberlede.onmicrosoft.com header.b="blytwIN4";
	dkim=pass (2048-bit key) header.d=a-eberle.de header.i=@a-eberle.de header.b="aGpfBbjI"
X-Original-To: netdev@vger.kernel.org
Received: from mx-relay99-hz2-if1.hornetsecurity.com (mx-relay99-hz2-if1.hornetsecurity.com [94.100.137.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9842566DD
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 15:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=94.100.137.109
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761578169; cv=fail; b=CgmkmANealo5PEQZoc++cPk3V+Kmh4R8dATq+oGL/iKgE6OPjW47BBvf0j1bwR3rfn1XAVdbBfU4qEMUqwHm8jdi/IzMseUsdHd4elb/c8WkvkSUm2e5Pb0tpjpTQW8bRhFlpzEzJVsTrAewWjjgs6PwQ6nE1nUEumaiDto5Vdg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761578169; c=relaxed/simple;
	bh=tcUiUS0+hywFRgYjvMiT2QCznquK32hVujArPtrcaa8=;
	h=From:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type; b=B3qxVK39nV38ud/BJlYDkEXOri+45uz1ujcGAVbw9PTP8jm6bgOe2dy18vT7twwzRlH95qkEaSFkdOiKst5m65Yb5Qh6IQGxt7NhUj7u/+pqoA3328quuEDM9Vvugg5s0Uxv1Cgyt2ncG1dmc2ezC5IGNgPiitgoJ6j0x5RtbeE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=a-eberle.de; spf=pass smtp.mailfrom=a-eberle.de; dkim=fail (0-bit key) header.d=aeberlede.onmicrosoft.com header.i=@aeberlede.onmicrosoft.com header.b=blytwIN4 reason="key not found in DNS"; dkim=pass (2048-bit key) header.d=a-eberle.de header.i=@a-eberle.de header.b=aGpfBbjI; arc=fail smtp.client-ip=94.100.137.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=a-eberle.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a-eberle.de
ARC-Authentication-Results: i=2; mx-gate99-hz2.hornetsecurity.com 1;
 spf=softfail reason=mailfrom (ip=52.101.65.102, headerfrom=a-eberle.de)
 smtp.mailfrom=a-eberle.de
 smtp.helo=du2pr03cu002.outbound.protection.outlook.com; dkim=permfail
 header.d=aeberlede.onmicrosoft.com; dmarc=fail header.from=a-eberle.de
 orig.disposition=quarantine
ARC-Message-Signature: a=rsa-sha256;
 bh=YfgnLTjPZoLvR3y+DjyKKjScpcmEZ6cHlhQHILSU0Us=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=2; s=hse1;
 t=1761578134;
 b=g8Mn9/JQRdjOjr1sPKwEauW4SIpEPNa4D5AHfs8WM3t+8RCvXBphYcjKgpRauUlyxV9Q8Lin
 TGAIqqdTtKKgrhOgtTKRLIKp6mdjYQbixMqWSPcCGwUwZ8J2zxkRBQg7z0Z2S0zaBGzAzvHVjoQ
 u2xNW5U723mvMlCtvhr53RU8YikpSjT8Uq1DI50HKaSDfMaZqyba8LpramQO9T1Tc0GNcz0jDPY
 xlcUT0KwQwlb3gwRVPVlPc97c++0Crk+xDIpiVdY1XLJHgcREZY3KxJhMc5c0W/ITCbGKwQ9iSB
 COL800pW6N+bzVLAPIiNto2qBypKVi6YRKdPj6Kxx9lcA==
ARC-Seal: a=rsa-sha256; cv=pass; d=hornetsecurity.com; i=2; s=hse1;
 t=1761578134;
 b=bUyxt4+KNhVTZP2dIxBgNV9x2MdRnc4vsz4jYbQR9mO9EAPL67ZJMgAl0PtxCPk42Uy3ITEI
 oDlOQO4M8FkuYtmUmXTaU/lfrNInjkXr6jfwWemWdJOQuD235eds2O9w2N0hClNIxHx1RxKmGcz
 8JZxborjm6E5XcJnyx2sn9FSmA600f5FNF2Rfrv1aqENiPcv6mSlj9a3pKsv2gOauaRr4RvsufB
 GC1QUQGh6v6RItKfVu75hRV4qYD1Tbf7gSOnK6my2OHdtSIX+gv+ZGu08UF099OJaCluGU+Mkwt
 WqYR0ozNcwI1cY5V8+tXlLPLw73BNzAMLI6kwYqx3uUPg==
Received: from mail-northeuropeazon11021102.outbound.protection.outlook.com ([52.101.65.102]) by mx-relay99-hz2.antispameurope.com;
 Mon, 27 Oct 2025 16:15:34 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y2EGeRNJisqguVIh0YcciWjKymyfR4wvti+ke38jwMrufUI0cr+8hfmoj4+P9L5naDaHaRkJpUotEwmy5TFA7BEwFdBreDJG1bK/bG5UawOqeBsKpnTzgDuMVCnpdhhH+WMP+QmrM1mwG/vFLciHB4u7OK5uNAtxXqJRWVFEVbLj9qH0R5awsBQA4a5369KQBjMrD+TLHrH6IoymgQ4tuiK/S3VlRA7abAUp//2d5j2bw+Alw7WEDeP8Dbfyic8NRwA6ZvwMb3ClVHuI7uaLxa+FsPTOm7SNcRBzYxUR6Zkl5e4xEFouOdrc7h597sybGwdXpzw1R7M2LIfTGHwE1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VA4usKD7FnTQJZ35+Ntg1wIQNcc2HqUH7ABhydUdFdk=;
 b=bPQh5yyq5o5egSTaVJ2ypB6iWrr5gBAS7N9vgUVgw1KSYFTFf2aZ8qAJmoBv3sOByETU+Dqnt0S8rHWow3Zs+Q9YqjAJxQusl0Lep3Fp7wIBn2J4J6N4jSdN+nk0kcDBHllrOguxDJIvh8VaPLZTxzVd1nhsn86X7jxoL6FdORv76tBAnc2UVTx1h3VcDlVHrnOqUF6WmwM3n9G/ZyZ4xy6+IkDmfVjaeg331ll7MWvbonrFu3uf6NKvmIvXQvkFfpGKhRp0esePXzNFXgB06PWJmZdFd0kb9Zo+6Vouw90K3XUJT9niXB0f4L7CeRJDWI7SJBgW8SqW1CuVkRlWYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=a-eberle.de; dmarc=pass action=none header.from=a-eberle.de;
 dkim=pass header.d=a-eberle.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=aeberlede.onmicrosoft.com; s=selector1-aeberlede-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VA4usKD7FnTQJZ35+Ntg1wIQNcc2HqUH7ABhydUdFdk=;
 b=blytwIN4VDOwZuyt7cHatk2rr/kZmKjwifoEyLpnjHV4+WmBornYZq9qx5QU2tv1snK0rNcOXBd92qQjYERj3FHA7cmePmSQqplrHovXL/p56AepRSbf1JFpg9Ua10zvfamqsf9up+LtOKNmxQ7l8h7OaQVsbo0aWkAjr08C3eA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=a-eberle.de;
Received: from AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17a::7)
 by GVXPR10MB8784.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Mon, 27 Oct
 2025 15:15:20 +0000
Received: from AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::14af:ad35:bd6b:f856]) by AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::14af:ad35:bd6b:f856%2]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 15:15:20 +0000
From: Johannes Eigner <johannes.eigner@a-eberle.de>
Subject: [PATCH ethtool v4 0/2] fix module info JSON output
Date: Mon, 27 Oct 2025 16:15:10 +0100
Message-Id: <20251027-fix-module-info-json-v4-0-04ea9f7a12a5@a-eberle.de>
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH6M/2gC/4XNwQ6CMAwG4FchOzuzdsDUk+9hPADrZAY3synRE
 N7dwQljiMe//ft1YJGCpcgO2cAC9TZa71LINxlr2spdiFudMkOBBQgEbuyL37x+dmnjjOfX6B0
 XOeYglFJgiKXTe6DUm9nTOeXWxocP7/lLD9P0D9gDF1yALqGGvZKmPFacagodbTWxiexxyeAKg
 4nRYFQtNZIq9r+MXDL5CiMTI8tdiQ0pARV9M+M4fgCqtP+1SAEAAA==
To: netdev@vger.kernel.org
Cc: Michal Kubecek <mkubecek@suse.cz>, 
 Danielle Ratson <danieller@nvidia.com>, 
 Stephan Wurm <stephan.wurm@a-eberle.de>, Andrew Lunn <andrew@lunn.ch>, 
 Johannes Eigner <johannes.eigner@a-eberle.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761578119; l=2222;
 i=johannes.eigner@a-eberle.de; s=20251021; h=from:subject:message-id;
 bh=rGU1TZLqtHuNuSpaDNLmd1rSXdNrZSt/YNRL/0RRvAQ=;
 b=VH+v6cI43zr4ODKzUOFtMmW7FQ6ZJSz4zmyM7MVPM8CemdQvQ1yz69TqmoRljIviAb3HwZNZt
 52paeXI1qiLANNo84CuX8l5inN1mB4DIjg2uvAXA2eXI0472hZrr1q+
X-Developer-Key: i=johannes.eigner@a-eberle.de; a=ed25519;
 pk=tjZLx5Tp2iwCN/XmbFBW4CrbjZnFMF6fyMoIgx/dEws=
X-ClientProxiedBy: FR3P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::16) To AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:17a::7)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR10MB3873:EE_|GVXPR10MB8784:EE_
X-MS-Office365-Filtering-Correlation-Id: 15d8426d-4552-405f-f00d-08de156ba4cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWRrREEvOW9JMmp6TEEvSEdMcis1bnhvZ0dvM2tsbnIxYkZXYUQ0M0gvR015?=
 =?utf-8?B?VHZCQ3U1T3plSUFaK3U2OGlCYXJGOFZtMHJTR2FLN05sRjdnRU83c1N4ZWgx?=
 =?utf-8?B?YXhvWHNSVmFkZisySmc3YmpMdlB2RjBxQWJ2NFVSdkdlL09KZU11YWwzTFVK?=
 =?utf-8?B?b0FJY3hUeXdsZ3A0UEdJRFVIOXlIczlJQ1pCWXlsbGJtMGpDa1o5eEdEQmV4?=
 =?utf-8?B?UWZ0MGo1VHRISGVTL05rekZtVDNRYnRKS2dHeEYwd3A1Y1BUQVQ3MjR0bWll?=
 =?utf-8?B?KzgxUXpwNVpiS3FzeUVZbm5sN2lHOXlkTE9Kb3g3MUZLVlN1cmdZbWJGbkpw?=
 =?utf-8?B?aTUrSDc3Mmt6VVV4MTN4cS9CTkUwblpsL3FYWGwwYXh3UEY0MVN3VDR1Z053?=
 =?utf-8?B?R0lPQmhlckNUelhPbUlJS0tmSWp1bmljTjdhVENzVTNiaTdwczhVRGRWQ1Z5?=
 =?utf-8?B?ZGswdEdPZTJFcXlnVEJ0dm1uVVlXc2gvcXFNZ0kwK2N1bk1sbWRGcTdLaFRy?=
 =?utf-8?B?Y21USnJXU01PVk91eEtpdFMrUzU3WlVDMUo1eVl1NHQveGdvQWxFa1ROa1Zy?=
 =?utf-8?B?dlh3RmlxZjBsMGtMM3M0K3dlWXc5dkYxeHVjQjgrRFhNeHZuZjNTRUFUOWJ6?=
 =?utf-8?B?TFFtQzl5ci9vczJESlpLOWRlemlhSXZsMWdsRDM5Y2E5WlJvdEMxZUpJUE0r?=
 =?utf-8?B?Y3hadXFNRFR6ak5lWURtTkU4dHFkY3F2ZkFmR0VIMTI5RFVCUlZvaThNRHFx?=
 =?utf-8?B?VFpzOHpua0phTjdaSk1QUXRRem1yVTgvOEhLaGxwR21zUlJuQmdEenhWeXR0?=
 =?utf-8?B?VUU4T21tTzJwQkhQM3g2TFlpWGR5VUdNaWJHd2paM3ZVRFp3UFBDS3ZFTDFI?=
 =?utf-8?B?a09nOU5vM3NSNEV5L0JTVUgzUHJyV1RVSWk1WjZvakEwK3gzMU00YndRYWZE?=
 =?utf-8?B?OVlaL3dHc0VCVUNqcm9xOFI0Szd3ZXVCeHVzWkVVeExuM2s4YUpNSXRWZHpy?=
 =?utf-8?B?TCtPcFBwMVM1VUZjYTZBUlVqd25qZkwwYzZNYktnMVZ3bXJla1ZiYjNucmsx?=
 =?utf-8?B?RmlhZUVhQ2xUcnJYT05sb2JyMDdDUmx0clBkSG9WaGY4YldITHZITXN0RjYx?=
 =?utf-8?B?UzcxcVozeXF4a0RrWjZxK0YwL2hhdDJsRkJEYlRJRHNrNmx3T2xXOGZnQXJF?=
 =?utf-8?B?UHRac3hxSWI4MkFJTCt1bjFSZGZYWEhyYmIrNG5FUGdJNFQzYjJ5NWJJZmQw?=
 =?utf-8?B?OE92SFVpbktCNHlERnIxSVNlRkYvaGRWWkhwbzZiRXhTR2ZwaGpwNFdUTWlm?=
 =?utf-8?B?MExvZzF5eUR1TFUyNEVaNzc4K3ZCQWpnbzBaQzE5QUQxaFhSOC9jZEVNVmJT?=
 =?utf-8?B?K3hFMFNrMk43clh0L1NSSlhZZ09ZY3N5M0FjMnc3dFp5RFdlUkRXTEJiZ1Rm?=
 =?utf-8?B?d1VkbkVvQjQ2dXRBU0hnMXlid2VrQmRaNmdKNUZzNjc2Z0M2NnZOMnAzQUNy?=
 =?utf-8?B?TDNiMk5MT3RMK21JQXhKcVBkblpCTmhuditZdHAxR3pPRXluM0VBQmxaUEtR?=
 =?utf-8?B?SDZMR2xTUU5nQ3JQSkNmcCsvQWVnb3Frc2Z4THg0K2k2dzdzWjZPbzFMbFRy?=
 =?utf-8?B?dXhpL3k2V215UWgxa3BPMUxhN1BENWVseVRZVFBIVXNKcHB2cVZOa3lmOEhS?=
 =?utf-8?B?NS84NGNzS21zSkR6MEovcEdjNC9rcTNIL3pMVEt3QW1NTFE1WTAwQ2VDcUxW?=
 =?utf-8?B?N0JYbVpjUzFobUV3YTJzSGFRbWN3Tllhdk56eTFJdGtUN2sxSnFVK3JzTkty?=
 =?utf-8?B?NXFzQ3RJRUVzNkF1Q1JsTWVQbDJQSVR1clRXbzNKTDJ1Rm1RYTErK0d4RjlM?=
 =?utf-8?B?NHcvNFpvWDN6SGc5a3B1VWhMVjJ2ODF2dlBvRHdwS3BGSUpkYzgyc29qRGRD?=
 =?utf-8?B?bkxsVDBMa3htbGpJL2ljL0p5TVd0bG9ncjRNVnFZWTIzUlFuWlFETVVPbjhk?=
 =?utf-8?B?RHcreThKb0pBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVhOYmR5RCs0am45Q251cVAxUmExYlRnR2JuMWtTWlRoaUdITTk3K015bURS?=
 =?utf-8?B?OHRCTnQzK0ttTFFDdGNmV09xZEpnSW8wd0VIcXd1cVRzWHZUSlkrZVVNdTA0?=
 =?utf-8?B?WmJySm9RcFhsdUNtZzNBYU5PNkUxOVhwT3IrUlZtbzV5TTExcWJ4d29IQ01z?=
 =?utf-8?B?M1p4amxRMkZpVUJMR0ZVUFoyMUdhVlZuR2MrVGwzamxEQnNHOXZSQ1VJT2w1?=
 =?utf-8?B?YVpFR2VBR1VHS2hQMkNHL0c2WFhBRlQxSXlHZDNZNVY4Q0dSNmdyTkJ0NVBa?=
 =?utf-8?B?RnBwMG5iTmxselJtRllwclpRSXlGL25lWVF5c2lDVnNuMEdYWGR6NGVZV3Bo?=
 =?utf-8?B?R0QrKzUzSzJzVkc3Y0RXV25LZGh5ekRoNTZsanZCcGRteGY5cjRFcXFRcXd1?=
 =?utf-8?B?UHNPVlA4K2RlbGtLNlBSK2tWbjZqR1FDYmlrdHNXMi91VENTVjlDWkdQeG8r?=
 =?utf-8?B?QkxrL0pWeDdua3VCNDJ5YUxlV0x2VzArU2hUeWpVaERkRGlnT3VyZzZDSFpt?=
 =?utf-8?B?Q2FJQmdnelhubExQTnA1N1Irei9FSFdGNExXRlBLUVYrUVE1TVNLQmdBaE1Y?=
 =?utf-8?B?OXp6QXpiYmgyWFhleWU5UHlXQUhXZHZJZ1lDUXpHSFRFU0tUNXhGZ1N2ZjBL?=
 =?utf-8?B?dE8wN0xPYzRUOHdVSzVXeG1WNmpRVDdsWHdTV1dHVkprMU5iTWpVU0orMkdG?=
 =?utf-8?B?UVMyN2hleGtCSTMrTUt1VjhOS2ppdll5TUNQVXh6RDc2WGc4SWdoMDNMaitN?=
 =?utf-8?B?R3NRZGxPNk5NbmdxVmxqUmFJNkN1M1dtOTR0dTk3QzNJc1dyOXJQcHVuU3BX?=
 =?utf-8?B?WWtTOUtTbkQ1V2d4S3J6U0hjekRpZVJvU1d5OExhWmZDZC9XR29lQVMyRXg5?=
 =?utf-8?B?Z01zTzY5bGprKzR2enR6aG5CUmJkdE5yV01IcGtseVNDQkNCVld1eEVjbTA3?=
 =?utf-8?B?ZzYyNCtrZmF5dHV6dzRnRVM5UHdOQ0VEVmtDTzN3OGlBZ2tJRTU2THFnUFJE?=
 =?utf-8?B?ZDhIQVhGU2ZEOVNybzNkV25jb0ZsMXBIUTB4VFBDRFpVV3hLdWNrN3JId3Na?=
 =?utf-8?B?RFB4bmJVa2ZjR3RDaWkwbWJxWm1TSXh4bWFoT1hNSnByVGhhb0dtVzZCR1ZO?=
 =?utf-8?B?dmhvbEVaVVBNTWhRVURNY0ptNjI2VVBIb3ltUWZEdTlVUDZxaVI0bkpYMFcy?=
 =?utf-8?B?MkNQcnpuTmRRYjAxTkxBREw3Y3d1ZFFNQ0ltVUhXbkROenJNWVFQMVA0di9W?=
 =?utf-8?B?N2VDUWRVUnc0QVpOTlhqS3dZR3JKeFBzTGM4b1ZpbG1pSDQ3Mk9yaGRyUnND?=
 =?utf-8?B?dWw3WW1iOEJEZHJuS05wZTlCbmdLNEtaOE1oM1o3ZXArTUJCeWhwWWhpbXJU?=
 =?utf-8?B?VHcrbENXNGc1YUxjNEo1cGFOWVQ0eEhBNzc1S3AxcEFwN1hsalZ4RXZXZERG?=
 =?utf-8?B?NVNFZk1HMjBRcDJEenNrOU1iZ0dFZ0JJaTFvTDJRdUtLTStqS0hKOVljZDdp?=
 =?utf-8?B?b0w0ZlpVUGhaL1MwTGFhN2wzUG9PVGpubm91amViNmNWMFZSSjlGS3p4c2lF?=
 =?utf-8?B?K1N3Q1FPMkVyV2VlRVhJN21iN2tBYVU4dzc0V2NTcDRVMXVyOHNKcmxkQjZL?=
 =?utf-8?B?dnQxOVJjQjRjd1o4bllHdjhsbVJLYzNTNnVENmR6WTcxb2wyczNnbnV0c0h5?=
 =?utf-8?B?RzlueXZ4RzZsRzVlVEhHa1BMRjJYY0RQSnQrOFM2NXlkUUUvMFcveFFWQVhL?=
 =?utf-8?B?S0xic05UVjBXbjdRVHdLamRLQ3Z2REV6M1JlQjBjOEZkSW5EeWZDNDdiRDhs?=
 =?utf-8?B?TDdRcUs5bm5HVDkreUk0ay9JTGVlWVU4a3lsZ0M1T29SUTMyQU9tbUNYaE0z?=
 =?utf-8?B?RUFFNzFseXZGVzJCTWxEZmR4N1crVlRaQXZncVF3MFdWRDFjRE9KM1RYcjJS?=
 =?utf-8?B?eDEvcGpsa0NYUFpiWDdRazJ0TzNhL1BNUzYyKzZVd203SXk0L3ZZWUtFQUl1?=
 =?utf-8?B?NDV4cHpobld4MHU2R1VHZHNiMkVZblkyOWRZNnlXb0syT3BHQXlpd0VsamlW?=
 =?utf-8?B?NEdxY0hMZElJVUxqTm96TVpCWXVvdStOM1B3TGd0QWUzbzVCSmw3RjJyUkUv?=
 =?utf-8?B?VzVXMjRRcUxtTUNNK3NIRUtLYkxmVlA5RFRXdXUzU1gySi9FYWpBSFVCVS9q?=
 =?utf-8?B?cGc9PQ==?=
X-OriginatorOrg: a-eberle.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 15d8426d-4552-405f-f00d-08de156ba4cf
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 15:15:20.7409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c2996bb3-18ea-41df-986b-e80d19297774
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AwdmKhvLC99FbNrUcTYVZBD2HhRAniz/JGCf6QyomAx1/eIXxvyKh15yBkiZgKic6cbOJoD6nYAXXQ/vL4Xv7Padcd2SXxHKeqPdrWA9GdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8784
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="----725851C534BD963C66CC8CF2C29D354E"
X-cloud-security-sender:johannes.eigner@a-eberle.de
X-cloud-security-recipient:netdev@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-crypt-policy: TRYSMIME
X-cloud-security-Mailarchiv: E-Mail archived for: johannes.eigner@a-eberle.de
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay99-hz2.antispameurope.com with 4cwHBN1Q5kz28mXX
X-cloud-security-connect: mail-northeuropeazon11021102.outbound.protection.outlook.com[52.101.65.102], TLS=1, IP=52.101.65.102
X-cloud-security-Digest:c3fb0269340097fcae74437aedc85404
X-cloud-security-crypt: smime sign status=06 sign_complete
X-cloud-security:scantime:1.663
DKIM-Signature: a=rsa-sha256;
 bh=YfgnLTjPZoLvR3y+DjyKKjScpcmEZ6cHlhQHILSU0Us=; c=relaxed/relaxed;
 d=a-eberle.de; h=content-type:mime-version:subject:from:to:message-id:date;
 s=hse1; t=1761578134; v=1;
 b=aGpfBbjIMg4Yycgxhil/dHClWtpH/aWLeC20aC5Exq8jXdJtEhkuJ68jH3Qiqx1g5W1loL3f
 Evm5Xh7DBuciU2ijRj0Ae6iy6UlQ8+j7H/fCv8+nF+6D0FzCbERz0Vz+ts+0gIkY2TzsrfgkcHg
 vPITUhs0BTAbEFtZvKk7dM8yBZQ9muKKkKPeNnNS2TeDQbncgcYmn3aBVPaQYASMXLR1LPLG+Ez
 ByDJc/JqWr5qNZmoNWHnnHLeJjXTFc9RTIf6E6vxsdDeslegBSkPoSn8rfPP0VYhQrNWJkgl/Mq
 bDk9mAbCJsEWMu//oyhJp7Dm3LJF97RURixynVppsFx0A==

This is an S/MIME signed message

------725851C534BD963C66CC8CF2C29D354E
To: netdev@vger.kernel.org
Subject: [PATCH ethtool v4 0/2] fix module info JSON output
Cc: Michal Kubecek <mkubecek@suse.cz>, 
 Danielle Ratson <danieller@nvidia.com>, 
 Stephan Wurm <stephan.wurm@a-eberle.de>, Andrew Lunn <andrew@lunn.ch>, 
 Johannes Eigner <johannes.eigner@a-eberle.de>
Date: Mon, 27 Oct 2025 16:15:10 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

In one of our products we need to show the SFP diagnostics in a web
interface. Therefore we want to use the JSON output of the ethtool
module information. During integration I found two problems.

When using `ethtool -j -m sfpX` only the basic module information was
JSON formatted, the diagnostics part was not. First patch ensures whole
module information output is JSON formatted for SFP modules.

The same keys were used for both the measured and threshold values in
the diagnostics JSON output, which is not valid JSON. Second patch
avoids this by renaming the keys for the measured values.
This solution is not backward compatible. But keeping the broken JSON
output is not an option either. The API change is kept as small as
possible. Further details are in the commit message of the second patch.
Second bug is definitely affecting SFP modules and maybe also affecting
QSFP and CMIS modules. Possible bug for QSFP and CMIS modules are based
on my understanding of the code only. I have only access to hardware
supporting SFP modules.

Signed-off-by: Johannes Eigner <johannes.eigner@a-eberle.de>
---
Changes in v4:
- Update Reviewed-by tags
- Thanks to Andrew Lunn and Danielle Ratson for review
- Link to v3: https://lore.kernel.org/r/20251024-fix-module-info-json-v3-0-36862ce701ae@a-eberle.de

Changes in v3:
- Reworked second patch to minimize API change
- Update description of second patch in cover letter
- Link to v2: https://lore.kernel.org/r/20251022-fix-module-info-json-v2-0-d1f7b3d2e759@a-eberle.de

Changes in v2:
- Add fixes tags
- Do not close and delete a never created json object
- Link to v1: https://lore.kernel.org/r/20251021-fix-module-info-json-v1-0-01d61b1973f6@a-eberle.de

---
Johannes Eigner (2):
      sfpid: Fix JSON output of SFP diagnostics
      module info: Fix duplicated JSON keys

 module-common.c  | 4 ++--
 module_info.json | 4 ++--
 sfpdiag.c        | 4 ++--
 sfpid.c          | 9 +++++----
 4 files changed, 11 insertions(+), 10 deletions(-)
---
base-commit: 422504811c13c245cd627be2718fbaa109bdd6ec
change-id: 20251021-fix-module-info-json-0424107771fe

Best regards,
-- 
Johannes Eigner <johannes.eigner@a-eberle.de>


------725851C534BD963C66CC8CF2C29D354E
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIQNQYJKoZIhvcNAQcCoIIQJjCCECICAQExDzANBglghkgBZQMEAgEFADALBgkq
hkiG9w0BBwGgggw7MIIGEDCCA/igAwIBAgIQTZQsENQ74JQJxYEtOisGTzANBgkq
hkiG9w0BAQwFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCk5ldyBKZXJzZXkx
FDASBgNVBAcTC0plcnNleSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNUIE5l
dHdvcmsxLjAsBgNVBAMTJVVTRVJUcnVzdCBSU0EgQ2VydGlmaWNhdGlvbiBBdXRo
b3JpdHkwHhcNMTgxMTAyMDAwMDAwWhcNMzAxMjMxMjM1OTU5WjCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdv
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTCC
ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMo87ZQKQf/e+Ua56NY75tqS
vysQTqoavIK9viYcKSoq0s2cUIE/bZQu85eoZ9X140qOTKl1HyLTJbazGl6nBEib
ivHbSuejQkq6uIgymiqvTcTlxZql19szfBxxo0Nm9l79L9S+TZNTEDygNfcXlkHK
RhBhVFHdJDfqB6Mfi/Wlda43zYgo92yZOpCWjj2mz4tudN55/yE1+XvFnz5xsOFb
me/SoY9WAa39uJORHtbC0x7C7aYivToxuIkEQXaumf05Vcf4RgHs+Yd+mwSTManR
y6XcCFJE6k/LHt3ndD3sA3If/JBz6OX2ZebtQdHnKav7Azf+bAhudg7PkFOTuRMC
AwEAAaOCAWQwggFgMB8GA1UdIwQYMBaAFFN5v1qqK0rPVIDh2JvAnfKyA2bLMB0G
A1UdDgQWBBQJwPL8C9qU21/+K9+omULPyeCtADAOBgNVHQ8BAf8EBAMCAYYwEgYD
VR0TAQH/BAgwBgEB/wIBADAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQw
EQYDVR0gBAowCDAGBgRVHSAAMFAGA1UdHwRJMEcwRaBDoEGGP2h0dHA6Ly9jcmwu
dXNlcnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5
LmNybDB2BggrBgEFBQcBAQRqMGgwPwYIKwYBBQUHMAKGM2h0dHA6Ly9jcnQudXNl
cnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FBZGRUcnVzdENBLmNydDAlBggrBgEFBQcw
AYYZaHR0cDovL29jc3AudXNlcnRydXN0LmNvbTANBgkqhkiG9w0BAQwFAAOCAgEA
QUR1AKs5whX13o6VbTJxaIwA3RfXehwQOJDI47G9FzGR87bjgrShfsbMIYdhqpFu
SUKzPM1ZVPgNlT+9istp5UQNRsJiD4KLu+E2f102qxxvM3TEoGg65FWM89YN5yFT
vSB5PelcLGnCLwRfCX6iLPvGlh9j30lKzcT+mLO1NLGWMeK1w+vnKhav2VuQVHwp
Tf64ZNnXUF8p+5JJpGtkUG/XfdJ5jR3YCq8H0OPZkNoVkDQ5CSSF8Co2AOlVEf32
VBXglIrHQ3v9AAS0yPo4Xl1FdXqGFe5TcDQSqXh3TbjugGnG+d9yZX3lB8bwc/Tn
2FlIl7tPbDAL4jNdUNA7jGee+tAnTtlZ6bFz+CsWmCIb6j6lDFqkXVsp+3KyLTZG
Xq6F2nnBtN4t5jO3ZIj2gpIKHAYNBAWLG2Q2fG7Bt2tPC8BLC9WIM90gbMhAmtMG
quITn/2fORdsNmaV3z/sPKuIn8DvdEhmWVfh0fyYeqxGlTw0RfwhBlakdYYrkDmd
WC+XszE19GUi8K8plBNKcIvyg2omAdebrMIHiAHAOiczxX/aS5ABRVrNUDcjfvp4
hYbDOO6qHcfzy/uY0fO5ssebmHQREJJA3PpSgdVnLernF6pthJrGkNDPeUI05svq
w1o5A2HcNzLOpklhNwZ+4uWYLcAi14ACHuVvJsmzNicwggYjMIIFC6ADAgECAhAl
5qzXGH8Da+FSta/hHFZ+MA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEb
MBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgw
FgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENs
aWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIzMDcx
OTAwMDAwMFoXDTI2MDcxODIzNTk1OVowLDEqMCgGCSqGSIb3DQEJARYbam9oYW5u
ZXMuZWlnbmVyQGEtZWJlcmxlLmRlMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIIC
CgKCAgEAwEFNcbuq7Ae+YCfg2alacqHWh08bvE6bFOZZ1Rxl1w/sFuXUwJ8o+gbB
TA/mmITzst+fnsjwMmrjtCecn8wILPitSD2wXy+yiaWmn8ywuBBw8toRX0xSMgif
KM494f9SSFjJDOgZGmAG+umMO6v5KNA1K0wSWrlZmG0yC0pzp6FFVVyMnp4/vJh3
6BuYgOf0s7KK5ShCQ4mKOD0dOOcMTBFHcQuD8d2Ha9lH5KzF4CVR6W3p+DUs2r6o
WwSPc0MrTqq0Ci9KPaKmvxzMQRZqSqa5ySqyw4guw0vnPYwtS0BEYZM+mL/5BwAP
Uga7nUg/9tjzyEgUY3tmimfWD0UIi9oDHT59n4s5iriWcnZNS5dAWnu7NqEBs+w6
lpWo2g60mmxPULNnwSUYxqdfXn5udIde0boYLKfEy11JC9xkshXBgLPhq4xTkbWs
fkoH+EQyEdep5AhaLeTsJHpw0tp2whpeH9Fwck8tx/nWtudo7bfYZUF4lDtyEHmi
p7UJa6x4LKEO2XFlY5v6ZOfVAm+zqNWEdDGO3bfv3HO5ciIHjXHLVFx/XI73OVsC
aObazBuEcqXafTK9ThLS5Sh4uZ3nLv3n5m8m/UUUKbOmOI7MTId7WlP9hOeNAzEu
SiA/n8VFk4RO7iwajXximGU/0rxuUJtN7RJFumksH7sbO5ypjCcCAwEAAaOCAdQw
ggHQMB8GA1UdIwQYMBaAFAnA8vwL2pTbX/4r36iZQs/J4K0AMB0GA1UdDgQWBBSz
BXMVnJ+omSJdNUgpzP64lg+gRDAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIw
ADAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwQAYDVR0gBDkwNzA1Bgwr
BgEEAbIxAQIBAQEwJTAjBggrBgEFBQcCARYXaHR0cHM6Ly9zZWN0aWdvLmNvbS9D
UFMwWgYDVR0fBFMwUTBPoE2gS4ZJaHR0cDovL2NybC5zZWN0aWdvLmNvbS9TZWN0
aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNybDCB
igYIKwYBBQUHAQEEfjB8MFUGCCsGAQUFBzAChklodHRwOi8vY3J0LnNlY3RpZ28u
Y29tL1NlY3RpZ29SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWls
Q0EuY3J0MCMGCCsGAQUFBzABhhdodHRwOi8vb2NzcC5zZWN0aWdvLmNvbTAmBgNV
HREEHzAdgRtqb2hhbm5lcy5laWduZXJAYS1lYmVybGUuZGUwDQYJKoZIhvcNAQEL
BQADggEBAMJhsGQW6C4UBZr7OpMg/n65GOd5Iy7i3vXW7gO7sgPe1pHYi1LJZ68J
lB9sP93yDViPMJ4Cir+/QqU7AtLyKkf+oo8nQTlx5gQeJnftZ/O6RkCS20I18GxC
aRDRRwD2JViL5Dk9uB87sV5DlOZV8w2VNWh+mm8wZGonaQ3NoNX+7jHcF5QX23Hx
x8ikwfv4jj3qajpv1l362Wl5FySKhdEXB/hhyxLjMfHEYs8PKHnjeWGbMPnqyTtt
xgnK+Gtmc4fjSlRf8Nzpr/q3iPppdSOmVk1lGmaGTJ+7ItiA1OTcFf7Atm8GomFp
QXdyoI/DW3zj355K+YADYhwhosfaQY4xggO+MIIDugIBATCBqzCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdv
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQ
Jeas1xh/A2vhUrWv4RxWfjANBglghkgBZQMEAgEFAKCB5DAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTEwMjcxNTE1MjdaMC8GCSqG
SIb3DQEJBDEiBCDNyJIwj2uSHCUCIf46TxKlf0rNe3dmSDyTsbmCJbT2JzB5Bgkq
hkiG9w0BCQ8xbDBqMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUD
BAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAH
BgUrDgMCBzANBggqhkiG9w0DAgIBKDANBgkqhkiG9w0BAQEFAASCAgAcTpvb1oe/
VadUySqgjAMpW5PlBb0IzmTgxNvwc/3U4gaixNA4Dgcf8W/9ipbrS84FvoMuCwD5
2+w0Dm8lLJn8VJkhJ2rjCdo75DjlWH7HH68rfmhtPJCUbRAor84e+9eC2fU4XIdI
BpT0gc/d4XG9uLJ3pWCRf7C3675fWcccIghil4WVpOOPcHmShva6tKDG+96uOkjn
noD92HgTwS012dn4CtqZ6ec640sIBaBg20mtj5Yf+rRe38sP3pY1euuJVeihV6L3
EerSE0AmHIVzDvu0SnHnk0QynF7Es1xu7AfdUBbYXXtlWDUpMRKQw0qajg0hAeZV
563zmtBQAQCiGj2e+shd2tKORC9QrqskPy+QhO2Nvn3i7gKxMyIdq40pq4BsHOUw
Ycl5naFwOqm+CVU+/+erxs9wJvQbWo9prwsXE0NHoJuBJkwLn5vBuWh9wEcEleh5
1pexXTWVWyborKMRziWLfMvDXSgY88PCQNeisLhGEnNZDrWRAYPpMtS+3fvS4i3U
K0b98EtZ9bHLOrb8RtD7eW2sybKAlt6VMe1ZQVDDeCe/Y5A7f9YDC85GUkRKy2Df
n7F6Wlj9pISFRwILif3Mbvhq0JH3WGAJQzbEG+gyja3hLdlV4XjPdDVdKXmKdKDQ
O6qQxhXSChGqjGfYcyZg5MrUN5J66kur5w==

------725851C534BD963C66CC8CF2C29D354E--


