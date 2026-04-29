Return-Path: <netdev+bounces-282161-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xL5VD8RY8WnwgAEAu9opvQ
	(envelope-from <netdev+bounces-282161-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:03:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2672A48DD88
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0315D3009E00
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7F8175A8D;
	Wed, 29 Apr 2026 01:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="c/fcFZeG"
X-Original-To: netdev@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.135.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE16E40DFBF;
	Wed, 29 Apr 2026 01:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.135.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777424574; cv=fail; b=J1s3+cNlSPeJg2T03kKuUkZ2x2A0UbmsVf9CBmYbZNkzi9zyIkImKmDt2Dms4xycmmTs4dduWd/bEZo+4TRUqhYTn6ZBuQDaoijhHG6lKC5N6Egw+ErbjL6DLvgc4iAVRul6YBu58WWHhMH6PM7AZx4/5EcEN/5GcN1dFsZ7UZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777424574; c=relaxed/simple;
	bh=DkySQx5+QaFPBxLagRSMXv1dyuAJHxADurbR8QESxwM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rvPSogjCYcuE1WpVRXuxI9ESUx92fVOW2Xvm4ye7zF1k2HVn+F2XTSEIq2+F1dzy0ywz0MHyj2lE40sKHNSAh1QYoPcdh0U+tPkDv36P+V5LPbPuQ8xySG/yL17HQTv9poY0r3nMsoaxvwgbGOL/GYkCO1YwqOLDTQpMd9wkjb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=c/fcFZeG; arc=fail smtp.client-ip=216.71.135.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1777424573; x=1808960573;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DkySQx5+QaFPBxLagRSMXv1dyuAJHxADurbR8QESxwM=;
  b=c/fcFZeGBK+BWc/GPppZsq3WTy9nXTyoDjetwlsk+bHDeRji9huJnQ3E
   5ilzlQcTdpIrfcqFjWQuvAV3HrrcfQdStmLTYlyn4uDiW8u7K5sfBtPaq
   aTwbot4UWjDnqSEnvGXt04EG3RIEAIk1+ZFZVhWAeUXwK54Q0VnRw4I4p
   4=;
X-CSE-ConnectionGUID: Pd2CH9AQQKCNbzZ1kBRbuw==
X-CSE-MsgGUID: GmVke0PLQUeRWXL8RhQfRA==
X-Talos-CUID: 9a23:ZEBIQGNqoPgzre5DYCU9325FM/kcUVb7xmXiekySM2x0V+jA
X-Talos-MUID: =?us-ascii?q?9a23=3AZskHgg5SEY2RuG8s3IeS5afDxoxH5pqtBRg1taw?=
 =?us-ascii?q?7tvO7BQggATekgg6eF9o=3D?=
Received: from mail-canadacentralazon11020134.outbound.protection.outlook.com (HELO YT3PR01CU008.outbound.protection.outlook.com) ([52.101.189.134])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 21:02:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ssWHotrax1svoTtpNa6LuEGBA7g55VZqAaPJO8f3KFTwAdI/Vx6+loRcDOL96gqAdfiu8cwdeaiI6hVYTTD4kBGxVpThCBPLk1AODCy4xeVUGqiJDgH8rEbAyn3Zqf6IjQWkN/C/3HyTbsauyKYhV4CmDb7qyLqDpWECJMjnCjTVYHOSR2950QULAs14+AcUZt4vce19M2OuKS0CTMvBAdWVm7tnr0Xf2AxIlckW/bb/RM0yUEWi0TQ3h1CaP1ScTyIGGiT9ZFl0f520ETNJ9xoEENYAlsVltUuSAcl1eBATlxSp7/dpPE4EjG+PxomnPkgQwqq7EBMEslqe5WhYVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOkpiB1RtO6WoJDlMIxwFe4wK1712sCX6UaL+7pctH0=;
 b=YmyFGJqI8qlPmDHfFWavhy25qD++9e2R3hCQqVlbsmZ1FNM+vi30eQrJViiwtQ95JuDJGfoWNi+4B81alsouHRNutTNTJJEg1YdPSSOGV2US0Urg41vnkrNNBx8qxJLoChT0p8s75TAXuW3yS4k6QC4ucuTdyQLh53KhkJBRswkKeReAItCkO5RsiAxHIqdElRJnpLZMVp1s9ghg5TR6Oq6Ja9l4AaC6U2xlVEo3Rsh5Q6SDwMNDR/7Bg047dIU02rACo8OO5oakShX+vS1vUuRXnM8LreDUHBJ2kW5ZN9exqnaHJC0H+CBixq2dS2D77+1Uz+bj3sKbSvF0FGjOEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YT3PR01MB6565.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:70::22)
 by YQBPR0101MB8592.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:57::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Wed, 29 Apr
 2026 01:02:48 +0000
Received: from YT3PR01MB6565.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::4837:6b4a:2a3e:174f]) by YT3PR01MB6565.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::4837:6b4a:2a3e:174f%4]) with mapi id 15.20.9846.026; Wed, 29 Apr 2026
 01:02:48 +0000
Message-ID: <3cdded27-22ac-4581-80c1-9485f31686c8@uwaterloo.ca>
Date: Tue, 28 Apr 2026 21:02:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next 2/2] net: napi: Skip poll when arming GRO
 timer in busy poll
To: Jakub Kicinski <kuba@kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Gal Pressman <gal@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Joe Damato <joe@dama.to>,
 Frederik Deweerdt <fdeweerdt@fastly.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260428175134.1197036-2-dtatulea@nvidia.com>
 <20260428175134.1197036-4-dtatulea@nvidia.com>
 <20260428173734.7f4ee58d@kernel.org>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <20260428173734.7f4ee58d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0017.namprd08.prod.outlook.com
 (2603:10b6:610:5a::27) To YT3PR01MB6565.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:70::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB6565:EE_|YQBPR0101MB8592:EE_
X-MS-Office365-Filtering-Correlation-Id: f499ca97-c69f-49c8-5c5c-08dea58b0769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|786006|376014|7416014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MWYYRhrxG/N51OME5nPBD2PqPnT/YQYfYELQUiRFyYNnsFRjKDk57zLMVaEOxEDq5a2CW0zv8dFwiX2tzbpZRHSXuXTmPF2MEV5QyVtU8qYv97GMEWurBiNIqFSDbRBnZ9UWguxittdoC2h+Rfn7bOqBXjmDfSdRxZGFEXptLiqb1HCQ0Gigtn0ijcYyUUlB9saWwPU0M3Vb9uRhuJDpBUF8GKtaEAvllLFHseEEw1fcBxlfyacr8+5WRhJY9kVcVaAL3qLocWRwRGw9uIm7zghLnwOtIw8NsYuUkJVpCu7OpPJMHtHKJaS4sUliSY9w4YcQ8mAq0A2e+e+W39WAdITwrqhjR3EWhWgD4deFKYJdampKgC04IzAoIFdnn4upR4TA0aUgU6uP65zuMtkHqjKQOWnOFHp8DZfIB7pEO9RQDp7sK/Hioei9eWOJISQ8zhXd3lwQplX+eE0rGgOfB+IipY+lmnZpDOFZzPaksvo2mnPs98HO6j0UzzeqU1VSyRXXRJdOTltVHqYPemGnbyGAUwnnJD75AcamFVqsVFaQR90xuovd648enRXgD9HAe8hIjB3kuhp2zkZvgfTrErRjKgeFsEiRQmRCzdWJvSM6lpVXskEVrSAVeYibA3uAtqN1Nlhyey5NvakmQY+DPF3BtPSwJ7ymiU1AAUc/hT8A4Q9yUSNB5ijOhcZoBF+OkQ/6pGzGGSrn7pDrBCo5ZvQbU6tWVlutL0mp1mZdQjg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB6565.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(786006)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVZPTjFBRjdabnkzK3ZUa2ZXMm85RFdheDZqaWk4MDhsVjhyQXFZRTJ3QXRU?=
 =?utf-8?B?REt4SzVHRVZpR1Z3RzVwUThvNDZITHVKaVF3MWZST1JqdlVsL3hqUWRMZ2Z6?=
 =?utf-8?B?b2gvbWExTVNkLzNrRXdqTlZPd3B6SlJvYXNjSkVVRGVlMHhDK3d0TndzZkx3?=
 =?utf-8?B?S25lUGNaZk5aMC92Y0xpZ0FnaWZsMEVnempvQ1IzSWRmbjhubytma0hyZzR6?=
 =?utf-8?B?ZDZOMXpyUVNNQlJJL0hxZVZFK3V3T2ZLMmZIRE9HQ1A1cmtERlVudkNYRGVs?=
 =?utf-8?B?YmI1QlBUdVd6a2c5YWJaeDBQK2FMSnZSeFM4L0QwaHhzS3VnV00wd2VnamNw?=
 =?utf-8?B?YjF3OGNhdEpzV0hQUkhiTTdJOUZndzIwem1UTU1MbS9OZjBDNmVQTWJ2T0Zm?=
 =?utf-8?B?OTBNd2w4UVpjZTdTNmZVMzVQekhQQXNVa3hrSEloWU9jYmNiU2NLWWNuTU5M?=
 =?utf-8?B?VW5BWllYQW44cmY0bzVYNHFWdVlMdlRxZmdGNUZUV0ZBTm5DMHQ4c2RibWhK?=
 =?utf-8?B?MjRlaXpYV3RqNTJKalh4dVpxN2FuREZUWEx2aktBbEwwbitWU1djWFJTOVVP?=
 =?utf-8?B?aUFldW1maXhVTG05M0o5YmRpZ0d3RHdxTnRCNTBUR0c3a1hzS0pIT003OGFB?=
 =?utf-8?B?b0xGL3h2Rkh2VG40YUlZOGdZdDM1L0p4Zm9xaCtpTFF6WkZRVzBxNjBwWk15?=
 =?utf-8?B?UitOcWM2aC8zcWp2Rk1YZzdRdjZ0VDBiQUlVVDl6RU5MUFpOVFNHa01Ld1FJ?=
 =?utf-8?B?L0pYdTR1eE9IMnROd2JFR3VSSnhZaHZrL1E3SUlKM0VOMS9QbWxxWFdkcGhD?=
 =?utf-8?B?RHk1TjI1bEtjRmZpY2lURHJUQlQwZ0Y4bEVJUE1VOGZUVU1CYmFSRVhXK3NL?=
 =?utf-8?B?cjBLQk9FbHNBZXNyc0cvdFRhNGs0RVNCKzZsNkJ0eHdlZVVQdGRaQnlQb1Fn?=
 =?utf-8?B?YjZTbjY2ZUhZcUVmcVZNd0NobDdXR3ZsV3ArTlJwMzVzM2hyR25wRWUwTE5s?=
 =?utf-8?B?UEtjdndPcEd1VmdwdjlMTm1nTWxGeUxZM21LdkFsWDdIOWJHRUZBOHZWMVpn?=
 =?utf-8?B?Z3BaZjZGbmg1WHJpQlVUU3V0VnBHTVpHZFlYTDlvcFhRczdDS1AwUzNRd3JU?=
 =?utf-8?B?UGhwSm84YVE4NzlCU0swU0xpV1lscTNtRkk5MTNxMlpxZnhCU29hK09wRXRB?=
 =?utf-8?B?dXhGckh3cGlncm0wL0hBYzJKdTRNZGp5MWo4Zzg3V0JLQ1NrRlUxeUpCTUFp?=
 =?utf-8?B?RHowUFFPZmZmTkRJMXZGdjRXb3pvYkdqSmRiaHZxaVh1R2ovWGRKc0U2RnBl?=
 =?utf-8?B?elM1eXJpeDJYbEZyY2hjbkF0L0J4emJKckFEZXprazc0Y25iMFMyTENUOG5N?=
 =?utf-8?B?UkhkSERXakdzQWNVOVBiMVpUV3NpS1hvVDZMNzFTZnArc09hV3NkM012cjN2?=
 =?utf-8?B?Y1hNc1FqOG94NmViazBRRDVaaFZkY1g4OVhPVWpnRnoyai9GVW15cTNkL1dX?=
 =?utf-8?B?Wkl3MWU5VUtPbUlDb01qNzk1Y2ZtUklRZW5zMklmaE9CRm4xMm1tS05Ycnp6?=
 =?utf-8?B?dXlPaEp3bm1QMUZlcGNKRllheVNIU25Kdm1yTEU0a0lGekFpSy9nSzd2V2tY?=
 =?utf-8?B?MXZycDkvNUpuOTJiNzNtL3B3dnp5RktKc2NDaEJvVWhLdWFzNkxTUWZ5KzZO?=
 =?utf-8?B?M1QzTGpxUkI0ZWdCWjZtaCt6Y3hJRnc0MkxIaVBJWXZHRkFib25pRzN1ZmRQ?=
 =?utf-8?B?S2lUcE8xczVkSnNPa3ZtNHpaRXRZcDZvZXU5a3dQV1VCNC8rYlZzOEJWS2ti?=
 =?utf-8?B?RWR6UWpuaHJDSGtjVHpXY3Y2ZHV5UzQ1R3N6Z054QWNJN3NDZUJiS0pvNDBM?=
 =?utf-8?B?QWsyb2JodzMvbW1LaVI1L3M1bldiZ3Ixc1J3Mm9DSHBEeHM3ODdQRU5LbEV4?=
 =?utf-8?B?bStMaDJBOU5ya2pRL0JRQ05qY0Fxd3FDRHlXWmYxSzlHTVkrZ3F0TkhZbFR0?=
 =?utf-8?B?VXVUTUM1U1haN2tFQmNBbXJKRFc3RHJGVTczdjhiN0VVYURTdGY3VVVwQ0g0?=
 =?utf-8?B?SXloOWRkTE82ZXFWckdZdk9YZzROeVEya1dYaVJ0VWpIODcyZFF6V2lpNkFG?=
 =?utf-8?B?VHlwNEMvUzVBNjAxc1Fud2VtY1pnOHVZUHA1a1BibExUbWtVbmtNeCtoWW5K?=
 =?utf-8?B?RFJGZHRGYjZOUDhDRWZ4QjdWOEcyMEdIa3BuNFhhZXAxb05rMzNFcTJYYk96?=
 =?utf-8?B?a0Z4d3Y4a0NPTEdyN1F2YXNkNFdVUEg1YTI5SktBMjdrOXo0cjF0S1grNTR4?=
 =?utf-8?B?MnNYRVhnVFNMUVAzM1NTcWVWclJsM21XZTlVU3FKTXJsVFAwS3NRdz09?=
X-Exchange-RoutingPolicyChecked:
	Vf3br0zdKdGo7LVdF5pdUIMMe2sSuCdvxSfoUGFBN/Fpgj5gJ8dENsZOmXHGq9XAOiElAgWY4TrhGVJ9uqg7lovGAelQrFBKaEF5JhK3VV65F+7qrLh16P6nhl1ZGGI5DOtJb6UyP/HUcYGoqzvVmBB3unsIRALev1qllAYoDQP2BhrMIxraskYqtOeZdx4yPYkwy8uELdgdm+EW/e+SKk5ABdbfb0P8gDs0hlN2/KFEoaxkkTWtVQY/Rin4HDQxNXAuxTZE8hILr39wv4GcZSTqSa8Cy8pdH2w1iuc6Q0NgeZQHJ181UI7JfaTwYRDchXw6y2q5m/dHYx+27D/bvQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vUTTSZVUSK8S/zGJ8r/UqMSiNv5sDRd5R9XQM+lfFf6BhBnFaiVkDpo6eEqkEGbQE+34JZzW6JFJgiNAObVMuvuE8l9BXGwR8d2W3YYB6FdRxR+tmgab76VI6oe3nT8eH3PZclXwvTtZ0ytvJjEWjTpO7kt5SgcS8JLNStQf2BPxVlaJ9QyOiwU+4KJFuD9ynCuoQcGkrBvDG7tQLsE9whLJBmSdtn1XtIQOMHBi3vuk0rXeL1fk7YdN23D2cssJLtJCIuI7pWQLoMv5/Tr1XqSMcnXqHLij8WB5E2aPZX2YoVSIDbhOmwcKVlHWYwtUR3pr7r/9lGzqBfZi0GwJc1aUeRfi9PO+GKXK/AVsgALyfMymiydgnYUG1jImi18mnmlTehpRjOVNZBYKt+KLwEIoOUJCyZuqE8mRKCqaOLwTgIeobE8Eke2EcCQsEoFywPdSFgvLDlZcCdG0pl7ZU3xTz5aMRDTBoQjvnuWmQI3ypskS1WZxfwHtWIufc71d0kD5kciiAJwCZ1xhpDVDpXFHiKNtRRjinOTynzO7z0waQ9KosZK8TZOjsbdIQDHfc94Nx+kxqrvpjtur8GVBlaUSs8EyDX+7nuPelaqP0ZEmbINqpPjTYvw1eYfri7ag
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: f499ca97-c69f-49c8-5c5c-08dea58b0769
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6565.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 01:02:47.9169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mhdQtowkVyfilYN5io05N+WfrtBh8z/d4yIJlm4snbkmjA09KNEPy01ZwOK9qPhGpuffZqmYuguRpt6A8yUI2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB8592
X-Rspamd-Queue-Id: 2672A48DD88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[uwaterloo.ca,none];
	R_DKIM_ALLOW(-0.20)[uwaterloo.ca:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282161-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[uwaterloo.ca:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkarsten@uwaterloo.ca,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On 2026-04-28 20:37, Jakub Kicinski wrote:
> On Tue, 28 Apr 2026 17:51:31 +0000 Dragos Tatulea wrote:
>> From: Martin Karsten <mkarsten@uwaterloo.ca>
>>
>> As referenced in the previous patch, having the GRO timer scheduled
>> while poll is running can lead to issues.
>>
>> Skip the extra call to napi->poll() when the GRO timer is armed. This
>> removes the need for having a separate __busy_poll_stop routine and its
>> code is moved directly into the relevant places in busy_poll_stop.
> 
> This needs to go in separately, the previous patch should be a Fix,
> this is net-next material.

Ok, thanks for the recommendation!

>> @@ -6918,13 +6898,28 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
>>   
>>   	if (flags & NAPI_F_PREFER_BUSY_POLL) {
>>   		napi->defer_hard_irqs_count = napi_get_defer_hard_irqs(napi);
>> -		if (napi->defer_hard_irqs_count) {
>> -			/* Timer will be scheduled after napi poll to avoid
>> -			 * firing during a slow poll which could cause the
>> -			 * queue to get stuck with interrupts disabled and no
>> -			 * scheduled timer.
>> +		timeout = napi_get_gro_flush_timeout(napi);
>> +		if (napi->defer_hard_irqs_count && timeout) {
>> +			unsigned long flags;
> 
> Feels like either timeout should also be declared in closest scope or
> flags at function level

Good point, thanks. I also just realize there's two flags - I somehow 
missed that before. Maybe the 2nd flags isn't necessary after all.

>> +			/* Drop prefer-busy state as in napi_complete_done(). */
> 
> sloppy comment

Ok, will improve.

>> +			clear_bit(NAPI_STATE_PREFER_BUSY_POLL, &napi->state);
>> +			netpoll_poll_unlock(have_poll_lock);
>> +
>> +			/* Flush too old packets. If HZ < 1000, flush all
>> +			 * packets.
>> +			 */
> 
> sloppy comment

This one was just copied over from __busy_poll_stop. TBH, I don't know 
exactly what's happening in the 'gro_flush_normal' call.

>> +			gro_flush_normal(&napi->gro, HZ >= 1000);
>> +			local_irq_save(flags);
>> +			hrtimer_start(&napi->timer, ns_to_ktime(timeout),
>> +				      HRTIMER_MODE_REL_PINNED);
>> +			clear_bit(NAPI_STATE_SCHED, &napi->state);
>> +			local_irq_restore(flags);
>> +
>> +			/* Timer started, so need for another call to
>> +			 * napi->poll().
>>   			 */
>> -			timeout = napi_get_gro_flush_timeout(napi);
>> +			goto out;
> 
> I think an else branch would do here? Let's not abuse goto

Ok, will rewrite. Among other things, I thought a goto avoids 
indentation of the unchanged code and thus makes the patch smaller, but 
I have no strong preference.

Thanks,
Martin



