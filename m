Return-Path: <netdev+bounces-258370-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJ4MDr/+jGn4wgAAu9opvQ
	(envelope-from <netdev+bounces-258370-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 23:12:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 897F212806C
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 23:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B22930CB36B
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 22:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E4A202F7C;
	Wed, 11 Feb 2026 22:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Z/hzBXKz"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010021.outbound.protection.outlook.com [52.101.46.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFC534AAE2;
	Wed, 11 Feb 2026 22:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770847918; cv=fail; b=JOrS9O1FC3Be5NY2o2cq/0Yrk2qa81BaAZgQzt/xMh6QQlZJd71vE2FjUxN9UR0gHm5IvqgSXrH9SPDWri+CbX1KC2E0J3nf0rm/THlFGiqV8WoR1KZwHQRsojkSAGyzuNUmmZUP3X1OPxQifg1Xe8DcQEcA591V0RTsSkpkMDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770847918; c=relaxed/simple;
	bh=nvXz1LJBSNNkOZfN4mFZN8pdPSYpNcEy0G3fWUCewa4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=M/ZAuMlcSmyNF1swxS0g94sLUxX9BnyoY7fwtxzIoGSBimx1Ptt7toIKt7zYxqGQH6FgZuNjx90ThUr5tHY5d7dfOQ3ZXD/cCYO4PmaXDaDVl+nc9RtlrDgqB3jPD1bHd+yXQ1fc0TVo/a6hQSneZzyaV8SJ8FtFgaK+zT3Ot0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Z/hzBXKz; arc=fail smtp.client-ip=52.101.46.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytpWC5reC9XBPjWa1Nar8+a2lEvedrMrs4MBlEXKrAajOTmBuhCOap3vCHEHPHuBi5wAwPZzAXpGMtSx2AyHi3S8sADzuAC7HmvBLtFPA/ATRen988QydPYs3zBFY+iqSA8O6/yfvbkjj5TAk7yEcZaZyf1wg1LVMMCAmbY71Vfrmf+s0Xkdn5dkAunR2FWCpWd3xlkbxiUVeTjoVlu47NcuwPtsWF7rhxbfXpktF56tQ7GXq6E1kVYKuhkh6ZqHR1cCdcJ9a8lm0m5aHF7tu6S3XuipqyvGgpvCGh0XUuMoE1+QLzFRMBf7vOhBpCkCsrtbEU6/oup+EQ4vTEfyRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXriakVjgJWwi5EQihOkmBcJXFS9esiK9+vXyY1i9hk=;
 b=v667HQxuv9TsUfyKnUlQtkSjqra/gSidMuKkgMlS/9klLA6mXDHjKuDH4N7nCJGafCWjcQA7nWBoCk39n/jmS607CALlsqBMR7Hd7zlpprRsD1qZs9y7v3pbSOWIbH8fR519ne8E03/KED3qbr6cE12l+wwZEf9ozJRg9JcS+m6mrkHbde1YlwfNZFQY/hS3ebOrU/F2U6upluwV+/kYb5DdOQKxcGH70SQvIbzJLUeZbOtg1Aol0aaa56+qIVqjfG7KgUf8s+8g0xz1MMnF9g7kVEIytnn5PbKm3fLJOJp+OCBi29y2NGVAgVi75uacSj+9jUbGlIwEGeM99ibumQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXriakVjgJWwi5EQihOkmBcJXFS9esiK9+vXyY1i9hk=;
 b=Z/hzBXKzMmNDkEUtWrTJK2hpa7XXKqU7faBtlTc4dsAoPjyPC4coeUtGk4eIJsfuGzmF5H3f8G6uPZXeY8455IfnfLNlHLjdZKwj/Ceq0Af/lMotNLyFFjOQb1+LMtTcH/GVq4kQMsTdPs9pnBSuaj3hwZTLUJhd4asmoLCSzWs=
Received: from BY3PR05CA0053.namprd05.prod.outlook.com (2603:10b6:a03:39b::28)
 by LV8PR12MB9449.namprd12.prod.outlook.com (2603:10b6:408:204::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Wed, 11 Feb
 2026 22:11:49 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::64) by BY3PR05CA0053.outlook.office365.com
 (2603:10b6:a03:39b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.10 via Frontend Transport; Wed,
 11 Feb 2026 22:11:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 22:11:46 +0000
Received: from [10.31.203.44] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Feb
 2026 16:11:45 -0600
Message-ID: <c7024d3a-36e4-4e7e-934c-46c7c26b43ba@amd.com>
Date: Wed, 11 Feb 2026 16:11:45 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v23 19/22] cxl: Allow region creation by type2 drivers
To: <alejandro.lucero-palau@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <20260201155438.2664640-20-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20260201155438.2664640-20-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|LV8PR12MB9449:EE_
X-MS-Office365-Filtering-Correlation-Id: 22912a23-5776-4269-d764-08de69ba8c37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QW1Ic0pyY0k5dXN5WWsyUG91ZlZabXg0UklVSVBDbWhnUjN0eUZqQllJZENN?=
 =?utf-8?B?ZmJITVp4eCtpeXVnVGRmdmJld3ROYVZpV2M4UE9TT3A0ZGtvd1o0ZHVaUElJ?=
 =?utf-8?B?bGdHa1FWVGl0RU41a1JUTXV1RklMRGFNL2JSZ2pFSmlaTGJYRGc0cFlDdmlN?=
 =?utf-8?B?UWtjdWRuT21Gc21uQUY2UEZ4WUdkWFNSRFBrSTRFaytqQjRqTllLNk9zUGYx?=
 =?utf-8?B?djdja0I5c0FzZi9MRFJLMWNHcFRvbzNEcUViaTlCcVFYN1I3T2pFRlArREds?=
 =?utf-8?B?VE1sL0ptbmI0ZitraThQS2J3V0VKN2ZXYllqNnZ6M2l5NmZ6SUVYUzFmblU4?=
 =?utf-8?B?TGNtdGdZL3pPT2ZqOHBma05WZHZzSUp2YkZ2bVpkdW5KVTg4aU43bXJiVGR6?=
 =?utf-8?B?S1RUQU9oYWpOcURuUWhuMUUzdk05djZ5eGRSZDMvMXpCcG9yYjhxMm9SU0lk?=
 =?utf-8?B?Z0poWnNRRTdZMitCSmtqUFlJdk1LcHY2d0xYcFFJWWlIdm9DY01TMTZpbXpO?=
 =?utf-8?B?SWc5VWhVazZUQWZjVWY4VmtidzlzNDI2MUZVa0hWNUhja0lKMkwxNnorY0hl?=
 =?utf-8?B?RzVGeW5tQjFvSCtVWXlGZnlGdlgySFlxTUJaZXpDQnlRVHJGM1ZCa2h4clBE?=
 =?utf-8?B?SGcxcnZDRHNDOFRpY28rVWh4ZGNjVG5NNE9LcFd3Vzczb3dOdTV1bTFqK01z?=
 =?utf-8?B?RE8zT3RBNFpSSU04SjZFeFRtQU80OU9XRStPQVU5K1R5TStvTkNOZUJjY3gz?=
 =?utf-8?B?eER5Z3hzUTVNOW9OUEc2VVpMT3M3NjB4M2VVN3pIWms3QXpweGdaY1Fuek4z?=
 =?utf-8?B?V0hHM3hjWHpZOHZOQWZLZkpOb2RDNWwwYVNObzRPcDV4TEJEWlF1TVAvMnpK?=
 =?utf-8?B?eDZEK2c2OTE4YnRLOHVKNTd3ZzdJTlg3emRNenVucHM1V2NnMkloRGhQZ0VQ?=
 =?utf-8?B?UU5JdVBuL0l5aHZwOW95d2N3Vy9RUGJjRmV2ZHlWOStyTlRvc3BXdHppam16?=
 =?utf-8?B?OVY1UGNJVmxJeFNNMk84cXVVbTVZN0Qya2JNUXU5OVE4LzJqZFk4TTdLSFhG?=
 =?utf-8?B?Y2cvYmQ3c2FyNnB0YU9LRmVvZW9hakJ4dkhPU0EzbmxuajZtQ3BLZUdnNDc5?=
 =?utf-8?B?Y2VMV2JGY1oxdnI2WUk4RzZYQTN0b1ZOWExWeDN0VmdXOXkrY2dvb04rbjFY?=
 =?utf-8?B?d2RuQUlDSXJmRjQxT0pzVThrTktRUXBZMTgrRzFKRWxGL1RZL0RhV05RRWVq?=
 =?utf-8?B?SUgrRHBST3Buak1JbGE2blV4WVBiUEs2dE1IdGp1Y0VIS0Rwa3VKMTNaZG4w?=
 =?utf-8?B?UldocE1LQkdYRkE1dnNJMkUzUDl3c3hCUkZjQ0xtRmE2bDdCeGRpaXN5emtz?=
 =?utf-8?B?em5LaFdGNGE1TUZiYTlOY09zWWF5R1UvYU1JZWZ6V094Ylp5T2pOYnUrZlVy?=
 =?utf-8?B?VXdVZUtudURhdU8rczA3MngyWWJVZnE0R1htbWVGVzVUV0s3RnRwR1dPamli?=
 =?utf-8?B?dU4rMWg3dlorbVRoeUQ4R0hJTG1yeU03SzI2YytlZ3Q1UlVIeVBWOXRMV21Q?=
 =?utf-8?B?N3V4V3Q4REIxMUtFTGVPcXZhbHlPUnFqR1gyaDArVFZpQzRBaTZzTXl3aTV6?=
 =?utf-8?B?ZFJ1WWhYRzVxRWhyTEJBWXNMOFFLbGNYcTYzWmV3cy9zeU0yWWNDMVp3TEFt?=
 =?utf-8?B?MmdqV0YzTHV1UFZzdlR2SG9SSW56VFY4TEo5d2JkMDArRG04K0FxTXJCMlFj?=
 =?utf-8?B?MkU5UGZiYytKR2xKTEMxcVI2ZUVLU3FnTnd4VG1xcU01UzhZYmxHYndqa0tZ?=
 =?utf-8?B?TzJsM1FwR3grZXF0aU9IMi9USzNmWGZ2ZXlmNmg2ZElJWU5rVEVBMmF0Q0RP?=
 =?utf-8?B?ZDhDRUdYTGdzZFZDNFRFRDlNUHZRSld5bWV5VmpBQmNWK2U1aGRhZnV1UlFm?=
 =?utf-8?B?elZjODk4bThQYko4dWIyMDBRRENyS21oNGtaYmZYYXZQcmZIMytiT09IZHZi?=
 =?utf-8?B?YzZGMDlrRTFlaHgrcU1tTjVkcnRHbmtsalQ2WGFlTFNCaVFYQnNsQW4rSW1L?=
 =?utf-8?B?NkVSZkdhcVVJRlR3WnZqQ2llSG41MEF6U2F3b1dCQVpDQ1VVNng4d3JMR0tK?=
 =?utf-8?B?SllvVmxpcGpHWkVlbGE2TlRaak95Y2Y2czcyWDhsVFEwSGtDL2J3eVFDa1pz?=
 =?utf-8?B?MkxzWmFnUVZHYlVaWW9ydjdYMjNlbWZWbXBScGJYMWhsUU52RGFaL21FQW8v?=
 =?utf-8?Q?t36DiJr1IcmtNBsGR6rf6qvbZOVrq0W00QJNi8RZTE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XgHqFhdTDMWuq0v7r7/lLOaLfyeofIBaQAJL8W1LSSo2qxtFUlGAKcosK+mjguVsKxceWcSOAu+ANRytuuAEuUc3dUBtSssYFuZvs60Ps5Ezg7Y6V2KyLyqcWYy66ltpVEDTYWWNhsyWNvRVq5Nvr+cfI/E70KxqkYJ1ZWLS64nPbIOGZlkjoWsVYJZr1gdhN0/G1Zf77r9HiC1pNhfUuBfGJM1DV4XXeGGBcdCyGhHHhtkk8sBRLb9THd5VqeGtAcYif8BUvIvCyY2oAbKls6PLQNL5/OpEl0gmWkPVcSck/ENxjJHIlzIuZMQRX6Gp3FFEab6FGrUSCdXpSF99V+S/9FLHJQ//6HSV9DCM3SaehLI/NMGb2YTww/XqFcj6GI/uxb421dB23PcNUVZhit/WwAULbjbe9WhsCsqdZKpt1TzKOfEPP40XagheFAuu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 22:11:46.9160
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22912a23-5776-4269-d764-08de69ba8c37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9449
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjamin.cheatham@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,amd.com:mid,amd.com:dkim,amd.com:email];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258370-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+]
X-Rspamd-Queue-Id: 897F212806C
X-Rspamd-Action: no action

On 2/1/2026 9:54 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Creating a CXL region requires userspace intervention through the cxl
> sysfs files. Type2 support should allow accelerator drivers to create
> such cxl region from kernel code.
> 
> Adding that functionality and integrating it with current support for
> memory expanders.
> 
> Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/region.c | 131 ++++++++++++++++++++++++++++++++++++--
>  include/cxl/cxl.h         |   3 +
>  2 files changed, 127 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 63c2aeb2ee1f..293e63dfef22 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2944,6 +2944,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
>  	return to_cxl_region(region_dev);
>  }
>  
> +static void drop_region(struct cxl_region *cxlr)
> +{
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	struct cxl_port *port = cxlrd_to_port(cxlrd);
> +
> +	devm_release_action(port->uport_dev, __unregister_region, cxlr);
> +}
> +
>  static ssize_t delete_region_store(struct device *dev,
>  				   struct device_attribute *attr,
>  				   const char *buf, size_t len)
> @@ -4047,14 +4055,12 @@ static int __construct_region(struct cxl_region *cxlr,
>  	return 0;
>  }
>  
> -/* Establish an empty region covering the given HPA range */
> -static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
> -					   struct cxl_endpoint_decoder *cxled)
> +static struct cxl_region *construct_region_begin(struct cxl_root_decoder *cxlrd,
> +						 struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct cxl_port *port = cxlrd_to_port(cxlrd);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	int rc, part = READ_ONCE(cxled->part);
> +	int part = READ_ONCE(cxled->part);
>  	struct cxl_region *cxlr;
>  
>  	do {
> @@ -4063,13 +4069,26 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  				       cxled->cxld.target_type);
>  	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
>  
> -	if (IS_ERR(cxlr)) {
> +	if (IS_ERR(cxlr))
>  		dev_err(cxlmd->dev.parent,
>  			"%s:%s: %s failed assign region: %ld\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>  			__func__, PTR_ERR(cxlr));
> +
> +	return cxlr;
> +}
> +
> +/* Establish an empty region covering the given HPA range */
> +static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
> +					   struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_port *port = cxlrd_to_port(cxlrd);
> +	struct cxl_region *cxlr;
> +	int rc;
> +
> +	cxlr = construct_region_begin(cxlrd, cxled);
> +	if (IS_ERR(cxlr))
>  		return cxlr;
> -	}
>  
>  	rc = __construct_region(cxlr, cxlrd, cxled);
>  	if (rc) {
> @@ -4080,6 +4099,104 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  	return cxlr;
>  }
>  
> +DEFINE_FREE(cxl_region_drop, struct cxl_region *, if (_T) drop_region(_T))

This needs to be "if (!IS_ERR_OR_NULL(_T) drop_region(_T)". If construct_region_begin() returns an
error pointer, drop_region() will be called with it as of now leading to a garbage pointer deref.

> +
> +static struct cxl_region *
> +__construct_new_region(struct cxl_root_decoder *cxlrd,
> +		       struct cxl_endpoint_decoder **cxled, int ways)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled[0]);
> +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> +	struct cxl_region_params *p;
> +	resource_size_t size = 0;
> +	int rc, i;
> +
> +	struct cxl_region *cxlr __free(cxl_region_drop) =
> +		construct_region_begin(cxlrd, cxled[0]);
> +	if (IS_ERR(cxlr))
> +		return cxlr;
> +
> +	guard(rwsem_write)(&cxl_rwsem.region);
> +
> +	/*
> +	 * Sanity check. This should not happen with an accel driver handling
> +	 * the region creation.
> +	 */
> +	p = &cxlr->params;
> +	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
> +		dev_err(cxlmd->dev.parent,
> +			"%s:%s: %s  unexpected region state\n",
> +			dev_name(&cxlmd->dev), dev_name(&cxled[0]->cxld.dev),
> +			__func__);
> +		return ERR_PTR(-EBUSY);
> +	}
> +
> +	rc = set_interleave_ways(cxlr, ways);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
> +		for (i = 0; i < ways; i++) {
> +			if (!cxled[i]->dpa_res)
> +				return ERR_PTR(-EINVAL);
> +			size += resource_size(cxled[i]->dpa_res);
> +		}
> +
> +		rc = alloc_hpa(cxlr, size);
> +		if (rc)
> +			return ERR_PTR(rc);
> +
> +		for (i = 0; i < ways; i++) {
> +			rc = cxl_region_attach(cxlr, cxled[i], 0);

Position parameter is hardcoded to 0. It should be set to i, right? This kind of goes back to my
issues in patch 12/22; the interleaving functionality is there but it looks unused.

> +			if (rc)
> +				return ERR_PTR(rc);
> +		}
> +	}
> +
> +	rc = cxl_region_decode_commit(cxlr);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	p->state = CXL_CONFIG_COMMIT;
> +
> +	return no_free_ptr(cxlr);
> +}
> +
> +/**
> + * cxl_create_region - Establish a region given an endpoint decoder
> + * @cxlrd: root decoder to allocate HPA
> + * @cxled: endpoint decoders with reserved DPA capacity
> + * @ways: interleave ways required
> + *
> + * Returns a fully formed region in the commit state and attached to the
> + * cxl_region driver.
> + */
> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> +				     struct cxl_endpoint_decoder **cxled,
> +				     int ways)
> +{
> +	struct cxl_region *cxlr;
> +
> +	mutex_lock(&cxlrd->range_lock);
> +	cxlr = __construct_new_region(cxlrd, cxled, ways);
> +	mutex_unlock(&cxlrd->range_lock);
> +	if (IS_ERR(cxlr))
> +		return cxlr;
> +
> +	if (device_attach(&cxlr->dev) <= 0) {
> +		dev_err(&cxlr->dev, "failed to create region\n");
> +		drop_region(cxlr);
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	return cxlr;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_create_region, "CXL");
> +
>  static struct cxl_region *
>  cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
>  {
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 4802371db00e..50acbd13bcf8 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -281,4 +281,7 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
>  					     enum cxl_partition_mode mode,
>  					     resource_size_t alloc);
>  int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> +				     struct cxl_endpoint_decoder **cxled,
> +				     int ways);
>  #endif /* __CXL_CXL_H__ */


