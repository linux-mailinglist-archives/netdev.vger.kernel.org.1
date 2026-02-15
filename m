Return-Path: <netdev+bounces-258765-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCjOL1SVkWlmkAEAu9opvQ
	(envelope-from <netdev+bounces-258765-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 10:43:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D9813E68B
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 10:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EBEF1300370E
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 09:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E783B2BEC27;
	Sun, 15 Feb 2026 09:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BfRrROl7"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012042.outbound.protection.outlook.com [40.107.200.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD943C2D;
	Sun, 15 Feb 2026 09:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771148621; cv=fail; b=GVEb9xVo+xooGzVK5//q3jK9HxxUIw/x8jArtp5YPBVgpgpf29+EQtBLaobHGlZGaLMot6zGa0ITwZnPSt+eksV3kyPt/A93jbJnOH5cVu8aRsIFwxORONxhK7QNq8I+uz6hWlbYQtU92XM3RdfOrJI+c1+tlQgJLuToQXtfJ3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771148621; c=relaxed/simple;
	bh=iuXEBAhn1bTIYWiGp+w3vWtsVoskMeN3JtJ0NHjUZCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PtZiB6x7cnlRgtjybsxHTugpzgbQYKGaL2eev4vGycuZJuC846F4XRfPjbGnSETEW5SJ6WaPfZa73E0TtsbJfRnvTDsD94dbVXsHEDtURUa8r1vtwq7DTlkNsGIkRuMBahYKv4YHpccxzWiZo0yvL3fqHA8G6waiIfXnL0/lBJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BfRrROl7; arc=fail smtp.client-ip=40.107.200.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3QnEUY48VTcXWAmfyntZf5SlGODrVxPcL7ACUbiYxIWVgbXLDYcD2gHrlim8OXUyhJK/VkWZQNBxjUciHCUu1vS5S8TosAKvDpSyy7r0xsNvRXhvF8h6CXyK+Z6WzKAfLYA/Tqn6mh6xQHcg0gVeX+clG8VFgySGIqgyLNV9g3AoGm4t3IDhLr2Yzl7TxbTFhtk5O1isos5fL9Cam29XMGPg90Nipzae+UKM79PMr1zNGxEsDznXteIDZ9qiCykgAXr3YVC4y6aKsZWpESatJe6wvoO42r/YXplA4qSJ+mghhx79FMBc/gjvxxOjPw2s4WkDJlV08bI8d13WFM1rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kW2HDdvTND2TZ/+VC1PvqgrTovuDwf1eV4vT4gHcigk=;
 b=qPRgqW6rfkxYlGJGg2nNEu4qQl7/sihXxtPGTCXYT1/2/lcKL0GjRZzw+oc1JViGm6n19TM5dcbz6fPi8TJKPRjg/jeX3/dAekQthP9X5fkpri2xT0rTiCQFa33DnWPbBVA5WKX2fwDSh1U4t2wmZCByCkPbyxRgcTWbach1gGmSyt2Gkd1YmXpOboWxFItP560kSc4jLfQKengEAGDLZYg+l3jRmI9JsKoYQtjv9bDk7J2XRdzwr3+Wc4DWLrdRPcV9bPoLMoD2jHIExXQPR9dgbFBeRDm7UKWlhbbJnIOzKdnQkH/PwHnwW6oRdWt1g3aguve3vBUIA9gi9X+c4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kW2HDdvTND2TZ/+VC1PvqgrTovuDwf1eV4vT4gHcigk=;
 b=BfRrROl7cTy0bevJKFT4Qk2sO1D12B8dWhJM4Isk7zdQWMn7d6ugcltMHmgtDDRmyHxuRz8oX+9r2aEqGN1TMnLfBE5Q2MDChZEe/KRI51JOs2dbb6HahInm8ekJ2GlGFyJguTEusuycQwpKoCIiZlVktahP6VZn5BajFe7WXctTQzKUNvWZDkU5V+9YOwfWec07hX0pWg/5JlangL+UyDm2+jnGg0pXM9JFivrFBP9QaTj6/U/J0icYjcnQF3y1K23TSHkZGVe7IWro3qDdoPyBQW6jSzMEdA4UMCOSJmnrxRWoH6gHvcnpmiBqhF968PkLeE8ca4E2JN0cxQ7SnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH3PR12MB9249.namprd12.prod.outlook.com (2603:10b6:610:1bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Sun, 15 Feb
 2026 09:43:37 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9611.013; Sun, 15 Feb 2026
 09:43:37 +0000
Date: Sun, 15 Feb 2026 11:43:26 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>, Amit Cohen <amcohen@nvidia.com>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/3] selftests: forwarding: vxlan_bridge_1d_ipv6:
 fix test failure with br_netfilter enabled
Message-ID: <20260215094326.GB114305@shredder>
References: <20260213131907.43351-1-aleksey.oladko@virtuozzo.com>
 <20260213131907.43351-3-aleksey.oladko@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260213131907.43351-3-aleksey.oladko@virtuozzo.com>
X-ClientProxiedBy: FR4P281CA0200.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::9) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH3PR12MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: cb4143d1-811f-4b2e-27d8-08de6c76b150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkJVRmRnNWh4bHN1Qk5wckloMHVzZmN6WS9LTHhSQWpoRkg3Qkw1alF6NHA3?=
 =?utf-8?B?ZUZtdm9UclJ0UGl4UG40U0hQdDRDeWREODcwUE9DbkhBdVJXOHFORHpaWXZi?=
 =?utf-8?B?QnRrZlRPV2tKMVNkaVhzeDlkRzlwQVNEUiszTFBid215QWdBaytXWFJuSTZv?=
 =?utf-8?B?YmdoOWc4dWxtbHlreGR3VkZwNEM2VDJzUUYyM1F6cUQ2RGs5aER0aDNTbUlI?=
 =?utf-8?B?QncxTjdQY09ZalBKdHdXM1llM3BXcW9DOU1VKzJtSlphTUJ2TkZMeW5XcHdp?=
 =?utf-8?B?dXFHazVrSXV2WENFQm42KzZjWnRJUXZlN2ZJRC9nRjlhRzZoOGZZWmZsMVR6?=
 =?utf-8?B?cUx0NEROMFpZU3AxSlB6Wk9tazJjTENKR21mQlEzbVhQWFNKa1FkK1c2ZHdt?=
 =?utf-8?B?UE13alp3UE9ETzE3Tnpab3lsWmJIODl4UW5nSDJGNDNmc2pkRlN1Tmp3aXFv?=
 =?utf-8?B?ZFkyZk40Z1o2WFRhNFVicFRoUWp5b2Z3cUthZFBpZmhyQWNzaDNneUtGQzgy?=
 =?utf-8?B?WklZTW5hUGYzNzBIMWo3U0grVnBnSWlJMkVIRG81V0FFRHJtNnhWY0tHTWYv?=
 =?utf-8?B?R1RtSyt4U1lSRGJPbC9VZEdVNVIwVFZqWm8vVWQrVkVybmFwWEgxYmdXZHo2?=
 =?utf-8?B?UnVQUFdFbGtwWVRJOVdTa3pPYk9Kdml1OEF6VzZmL3FxM1V1K2Y4aDJYbjI2?=
 =?utf-8?B?WXRKelBxK2J1Nmo4RTZrUVFQRFpiOUF3VGM0R0ZIazBMU1NwWUJFUFlmbVRG?=
 =?utf-8?B?VzZBaWNsTVMwRUF6SE1yb0h2UGJMTi9QUjNTbTJ0Ujd4R1lqMDh5VUMrRVVT?=
 =?utf-8?B?emNuMTBRS2c4MmY3TnNsWWdMU01hUUorQ0pybGxJMHVhd3liZ2dZVU5xU1Rz?=
 =?utf-8?B?N0JqTzRtWHpIN1Z0eGtEWVIvOXFoMEdjWEcrREllVE5TZ0dvVHNaR2dXMDc5?=
 =?utf-8?B?SUpsUUd4UnB2QmE2VUJqYk5ESURUdENoM2VnTzU1VzVrMjdtWm1WZDd1MG5y?=
 =?utf-8?B?OWZWQ0ovVnIyMjBsK3pWMU5sejJYUXVsK0VKSm5ta1NtN2s5dFN2cUF3M2Ex?=
 =?utf-8?B?S0ZyOGtLUkJ5U1JNSUlxUGZrQ2V6eG83NldYalB0YitoZUZ0aU9OUmk3Q3JT?=
 =?utf-8?B?dXRvckpjVHduazNpQjRaNVgrbi91b3RNMVFVUkZvUTJUT2tmM2Iyb1dPY2RU?=
 =?utf-8?B?bmRNTHVYM3JlSkZvTWdDMVJIQ1I5WHN5SkJUcy9MZk1RT0pzZDc4NSsyMEp2?=
 =?utf-8?B?RlNCN2s4NVowTmcwOG1tbGtoNUIyd2FzeGY0SC9FMUJ2Yk9PTHpBTjRpR2ZT?=
 =?utf-8?B?WUp6aTBRODFFOEJsWUVHcU00bHlkY0pXb1N6REFGbk1rUmtXb2hqZDhiZXVF?=
 =?utf-8?B?UTI1dkJ3TG1CY205aXNPZ2hYdlBrNWE4VjVCR0FYaEplQUQvYVVKcU1ScnhZ?=
 =?utf-8?B?QzhRMHdpN1lCa1RuWDVCUWM3KzZTbTR0MSthNU1SV0JXS1dxY0hMaTdDeENM?=
 =?utf-8?B?VTlSZkZZY25vczNMNDVRM2tMSFhLSEdJWUhyTjJKMUhRU1p3ZWxwb08wM3g3?=
 =?utf-8?B?OHNNZStCM25seE9UV3B2K2dWbEd5c3QzOHFORWI0c2s5VndrZVdCeFN1Um5D?=
 =?utf-8?B?Mi9XOWIvckpyR0xBYWNpZkJwYnRBNDVSQllpSkFOdW9jQVB4SDBFd0I3Z0wz?=
 =?utf-8?B?Ly9PYkhEYzVMU2RLaU55cW1UdzNGbldYNXlzYUhUYmJWWG44MitNOXNBcUVo?=
 =?utf-8?B?aEJUdmpxNjRpbHRtZ2padXVNOGFYa29mdkJsMW44NXBqbDFvbEV5ZTF5TWFH?=
 =?utf-8?B?eG1TWWFvckNRQldRWk9GZGNaQUVuNWE3ajNCZFJCWEZORzN1NlJUTThaMFEr?=
 =?utf-8?B?cEZCVkVOeDJnQWUvazNNZEo3cTFrWERIMnNBVy9kYnFSU01FWjRJMnI5QUFJ?=
 =?utf-8?B?NGtZNGhkNzBBdi9ObHJlQ2dqbjdpQjd3WS80V1NKUUdsemlXcVJNZWZBT3Va?=
 =?utf-8?B?TWgwdEVtUkJjOXFTVHNCenNRdFVLWTZ2YTdmWmpYSGdxcVdUOHRTQ0FxQktT?=
 =?utf-8?B?U1RTQWJJdGFQQVRMcHIrcVVCYVM2RmIvSk8wNDVUcEdvZ3JSbDJQdE1MdUZa?=
 =?utf-8?Q?k00Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ynpha0pvNEpuMjVDSTB3bnhFOGlvVmgyU3hUUUFYSHpCWFNlekFJSURWazg3?=
 =?utf-8?B?K0xCK2Z1Y0lDTnRxcXkyMnJIbG5HbTN2MkxXd3YvUHk2OUlaTGtZY1FpaWRh?=
 =?utf-8?B?dWk3K09RV3F2ZVFuclk5N04zdkFhWGw2dzltTitydmxVVU11RzZzWnVUeGJy?=
 =?utf-8?B?a3ViZkdRS2NWQUlHaWUvNlNjY0x5NWJpcG1DTVRaR2FnUFdHK3p0WWpPVHVU?=
 =?utf-8?B?bHFYbkd0NGdNeTFWUHhyK0lZYTJYYU9LR1FjRzBXSGxVRmxLMi9mTFVBclV5?=
 =?utf-8?B?ZEZ3M0hCN3ROeTMrYzRmOUxNUGpydHZCc056UVV0bHQ5UGZVOUZ1V1lzbVNH?=
 =?utf-8?B?Z243dDd4MXBMSkxad1E3UkN3OVZXblNrUitycmpLaklMK3hWVnVOT1pLM2di?=
 =?utf-8?B?Z05McDR6dUozSGxEakN1YVdhandTN1Jjei9pV1dzYWFnTzIxejliNlVOUzVs?=
 =?utf-8?B?TnVsMllHTHZsc0Y1eGtaR1ZiaFpab3NYWVlBdG5pUmNBOUV1R2M0d3RsM2JW?=
 =?utf-8?B?VnBKR3diR0VCMzVOYXhyeTVBVlBRaDFzQ2FtWXNsSGIyWjFPUllJNkZkak8z?=
 =?utf-8?B?NEsvejZtb3ZQMjNwU2NmazlSR09XNU5qbjNNcUs3UWdkTmFoVGtTdWJuRnpu?=
 =?utf-8?B?amNuZUNYZUlBY2V3eFJaa2dZU3U1Nk9wUlFkM2tzb0ZwRHJCbEZqR1p0ZTdr?=
 =?utf-8?B?WktsREVFRVBkYjF6eHZ0Ry9BajlFZTJ2VzFGaEhUdmZ1SGY0MHUwUGRhUGNX?=
 =?utf-8?B?aGN4MHQ1b2RBR2JxWlA3MlQ2MDdJZGtCbWlnV1JCOHM1NW00SzkxUU16ckRB?=
 =?utf-8?B?Q2VCM3huaW9leE5adlFzbVo0WkVSaWI0cVFNTjd1NmNGVm5CSUljTVZvVktX?=
 =?utf-8?B?SzY1RXRwaFdhWjN4cW1MUjJLTG1RaVJ4ZnhtMGJOb3RsNGw1akJuZ3RtbWhh?=
 =?utf-8?B?UC94ZlBPdHRKMFlYcG9jcFZLQTIvbFJUVTBaTTY4V0RBcHZIZTZXQXJ1Vmlp?=
 =?utf-8?B?SUZpT3BodFY5RVQ2NGpBczcwTjFKQTFUOEQydU1KMnlhMTVZaEw5QUlRd0RD?=
 =?utf-8?B?VjFNbzRQbnY2M1dxU1gvZjlrTGhvQkFTKzl1TStWVGpQNVV3TlBITkEyUkpJ?=
 =?utf-8?B?UkRuMzJ3YVY5WmF6K0wxcWprVE1aeFcyeHNUM1JRNnBnRWlGVHJwSW1nRUpw?=
 =?utf-8?B?MzlBNVFmM0ROMTFSdHZyNW1oWUV1bWI0VlhlQ2tiVjB4dlg4bjRMc1pnMTdT?=
 =?utf-8?B?MHhNYXpOYkhCc1p2YUVaVzNrbFVkdTdoUHZvdGxDbHphc3AyMXR3c09KaStF?=
 =?utf-8?B?VzFkUWxRV1MxU3VHRkg1VUlrRzYwejZOS1ZERVZzQ0plcmRaMXRvR3lkYUxu?=
 =?utf-8?B?SStBR1R1a0hJem9yMHZUS2kvYVIvZzFVUVhIeFdUK0FyazBOR2daWlBSa1BJ?=
 =?utf-8?B?eW9rbkRNOXJ2bDF1OWg5OG5hemNFdHZRNEN5Vk9leEo5YTFGODVkWlRuQUVV?=
 =?utf-8?B?Y3JON3FzUm1NUGVuRm5wWHN1WUlQZEVTa2xjckxSU1ZXY1c3OHVJcmR5WDAr?=
 =?utf-8?B?V0ZEdDFISVpoVGxuUnhnQTNkRnE0c1g5WGdzblhFdnUvTEFQRCtad0ZLMU5U?=
 =?utf-8?B?RDBjeWdQVjdsRWprclR3M3NWZlVQS3RtVmJLZkZBdmg0ZUFSdkhIdVQ4dmox?=
 =?utf-8?B?NWlmM24wSkx4WGw5eU1HQWZJQmFnK3I5UjBEVG1MZ0JVS2VRRVNxNXpoSEc4?=
 =?utf-8?B?dDc1bU9IbVhtQTltNXpoWlJnTlRuaU11Q0g1c2hNTitUU3Q0Zys5TmFiaXZ5?=
 =?utf-8?B?cEhmT3VmM0ZMYmppSk96RHNMOWlCZXhTTllXYzNxQlhJSllDLzJjNDJJL0dG?=
 =?utf-8?B?QnRnbmFxZ1NVUS9kbkllMFc4SjJzZHJJY1FRcVlicFJHTHFSQjZFY1B4eUZl?=
 =?utf-8?B?MC9iSzMzS3MzUmt0WUJRdHpwbm9XSFUyeVpwd2RaS3lQRVZETHpIM2pUeExL?=
 =?utf-8?B?MzJheEJLcXMxTDN4OTd5aGhYRGR1WkhuajlXWEs5YmxRK2M2Q2pEQXhzMTJB?=
 =?utf-8?B?ekNjd3pDRnRKV3dwYThha2UwUzBoSTgxZnpuVE5TODRIVUNzZ3kvNUFNZm43?=
 =?utf-8?B?QklyeUxyNUFyeTNaUGhtOG81RmtHTGNJcGIrVVV2OFkyNjBVNlpMcS9qaVVi?=
 =?utf-8?B?TWFzalRTNEIxNXh0YTRQUllzTTQ5Nm1INU9Fc2p4TVRWT0cxUFpXU0FWbFNp?=
 =?utf-8?B?Tlhha0JtWkZaVTgrcVQ5WUZUMDY1RGhvQjN2RFliZzFQN1hRMlpveUdTdlN4?=
 =?utf-8?Q?WqU1bXUeWr7sf8LQ20?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4143d1-811f-4b2e-27d8-08de6c76b150
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 09:43:37.2212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9uo/KSQmOdaaIa5lmuW53nC1EWM5tSlzKalNYtWvMqXTMCWRQWAKkngCjobzl6Qnr4sNJMkJP/ar0dA8GRu3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9249
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258765-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 00D9813E68B
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 01:19:06PM +0000, Aleksei Oladko wrote:
> The test generates VXLAN traffic using mausezahn, where the encapsulated
> inner IPv6 packet has an incorrect payload length set in the IPv6 header.
> After VXLAN decapsulation, such packets do not pass sanity checks in
> br_netfilter and are dropped, which causes the test to fail.
> 
> Fix this by setting the correct IPv6 payload length for the encapsulated
> packet generated by mausezahn, so that the packet is accepted
> by br_netfilter.
> 
> tools/testing/selftests/net/forwarding/vxlan_bridge_1d_ipv6.sh
> lines 698-706
> 
>               )"00:03:"$(           : Payload length
>               )"3a:"$(              : Next header
>               )"04:"$(              : Hop limit
>               )"$saddr:"$(          : IP saddr
>               )"$daddr:"$(          : IP daddr
>               )"80:"$(              : ICMPv6.type
>               )"00:"$(              : ICMPv6.code
>               )"00:"$(              : ICMPv6.checksum
>               )
> 
> Data after IPv6 header:
> • 80: — 1 byte (ICMPv6 type)
> • 00: — 1 byte (ICMPv6 code)
> • 00: — 1 byte (ICMPv6 checksum, truncated)
> 
> Total: 3 bytes → 00:03 is correct. The old value 00:08 did not match
> the actual payload size.
> 
> Fixes: b07e9957f220 ("selftests: forwarding: Add VxLAN tests with a VLAN-unaware bridge for IPv6")
> Signed-off-by: Aleksei Oladko <aleksey.oladko@virtuozzo.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

