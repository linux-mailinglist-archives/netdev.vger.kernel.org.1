Return-Path: <netdev+bounces-271308-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFREKYEAw2nRngQAu9opvQ
	(envelope-from <netdev+bounces-271308-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 22:22:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D98631CCB7
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 22:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85033300F9CD
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C7935AC1A;
	Tue, 24 Mar 2026 21:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cd3vTcUo"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013056.outbound.protection.outlook.com [40.93.201.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B80235295C;
	Tue, 24 Mar 2026 21:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774387233; cv=fail; b=nvFR/wI32tftEZZrNG4IdnPMa5vinh8ymnO3y7CMu5In7J0UR3GxQfDnuMq/ucbVsU2tBdr7cdnQwf5bQFjUcnnYiqGlq9sg8PzAhiLaHCT2+0/aK0QsudVUsAz2g/CaTT/CMkDKgXcX3xSgU4mUWcTHYQPchgnby6Rk9379Rl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774387233; c=relaxed/simple;
	bh=ShPWpZZPxZnzzYQvIsAGS/CaLn70A33ahRwhLS2AaMA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NHNjsorC40X2Kf+dYQ46TVlONXJHLpC+a9+g3MaOeAjvVGh99iJmUWpkDvb5TYWY8VB8tHZS3fMROSBdRl+FqCxREw89OpNitI/wmI7/B64t6r7APGuwYxEH+2Xw2pYFWn8rO7JpFtOFxfp1oGcVnP6A35swPPmJaWHII+bhF0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cd3vTcUo; arc=fail smtp.client-ip=40.93.201.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8qkgAl2S629fD9j1hj0mQwHzEHE4xMOcabUr+a63g4rJO2Wqzlk2dkfMVzNhsCXwN7Sh7VXnHSFpOIbQNRlaAPtZo6x03AZRXnBozVEEtsqFwnczHqSceuyQ15faUDqhXMH32GRCOp7s3dEf7dHqQe+FdyMN2G8kL2lVxMlBsG8N/eGoZjhsMyYnL/S10wxDLk7KqILDt0hmCDs+nUiy/mwsQ4hgFIOxJ9fMyM7wbTne9Q6iKASqkbRfW8qXcndp7YugF3k6wHZtxQbHicY9O7CLNVj6Onc3n9eLpbNcT8vrlEh9ZmNyOHX/a4J4XGSJTlVOs4DcwfDcJd6AytxEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtvrJLE57NjEbECogksAXum2jI5qIIxQVchionh1aVc=;
 b=XmVR/SrAqewVIiME4zEAcF1iqykcdKLgfb0F5983rCBaBgB/yVx1l6ul99AQkOub0LreLGKEJ6vr6dR1aRK2jXz2FyM+7Bd2qtAPRcCmxUO+a5tbB+2+g6KpeCzroqvTsUNk4oMO8lK8AFXC9ULRt2Jhh0I9000P/tov6L559tOVLXGw4oXSRZvGN9iy78snQ5UFH9qp8h9PJJr0GMJN6qTiJYvTVyg3o67+ECrwC9/V/qmeQ4ALwE/4CQ1Idas/xaZQ9w1mc5rVjOzii7/OAM/OfUl54aqCNY4YRb2ilWMcgsEBjxU3NvdcOAONmke6j/t0Yd9t0KmVoJP0h3dDGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtvrJLE57NjEbECogksAXum2jI5qIIxQVchionh1aVc=;
 b=cd3vTcUoVcD+nhfAaVJg6auoELfDbtlrV9LFhDKPpvv4vYLmIA6YTGPkp07M+pVLdUoquyGNr2kFzbiS5I8TiZLZZhystN9TrBvb94nYN51//oiNuyeabOF5/R53qiPxNpoDpcojTBPs5utzBLQPnt14fzs4WQiVOV8vY+ZIM4w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS7PR12MB5982.namprd12.prod.outlook.com (2603:10b6:8:7d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 21:20:24 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 21:20:24 +0000
Message-ID: <b592bec2-4db5-488d-a7af-87d073bafa85@amd.com>
Date: Tue, 24 Mar 2026 21:20:19 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 06/11] cxl/hdm: Add support for getting region from
 committed decoder
Content-Language: en-US
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dave.jiang@intel.com,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20260323113117.2352709-1-alejandro.lucero-palau@amd.com>
 <20260323113117.2352709-7-alejandro.lucero-palau@amd.com>
 <20260324164813.00003801@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20260324164813.00003801@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0136.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::12) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS7PR12MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e00e10c-a201-426b-70ee-08de89eb2996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	FXS2rfxIT2XlIh2oUfH5WJ/kNfsfDtkqiz67euhsMdic6I2+liA3ytaLl+e9UrsPKvWJiPiVnZrW7FF/P5Ik71yGnjX7agxp7QG9WsJRI6c2156Amkq85LqdsQgMBnEPQfrzwIfOJkd6J0dkuTXtEY+MyQRe1JhCTMUQZjWhk6eapKPbMe9ckZFVdo+khN4xVUNAMKvtg3h9s3TZXrffrluQQDfr/GYrJtweP8aOI21dXSfURTy8wKGpjBAS2lAChysJIXQbqylbEupuqXE0oebtIBPczaMfU1zwNifpJYKFdUmIrQ7R52MgBJhMwG8UEnWk6RBh1UOUQlI3lu/IbB2LU8Rdqh+fsEdi2E3Ckv4/XfvamFx2cR+XrsU2FNK4bE/wJRKWOQwzFVjzTz1jQNhSskYdo41xd0TrkF8yXN6YqJHA8juxD6t3VF1IyZ47DS9BpyvM39OH47SjlJ8Ad/krmHJABTEOXEgR+Uy+vOzZUhhfI6TS6T90aVyw8U3/otMZBI4NDa5PPDgbv2OXW8j81P3SC479yEDUr4NQof4hTdgomrhjzwOuiKOanpckeFgsaEwLGLw9+bFNmeA66y3fw0R05KchEhUHXxY4iagmkBFoTH0/lJFGTYMvS16Kht+kXHtrqkVUhz2m22ivnCPNofDZwuab1NXKUbshowM1VTCTsVcMcfXveR/ExNs2mw21kIynVuXxZRh8yPgj9oMhxx+rhClH3K6w79A98mQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ym5iMEo5cHRSR2F0d3IrMDZDUVBFSGJZbzdIWG9QRHBSTjNJbUxSMGozYVdQ?=
 =?utf-8?B?cnRteGVjK1VzaWROWHYvNWUxRTlVcWFOcWRPS3ZsWkJOOG5rYmtSK1JjNlVO?=
 =?utf-8?B?aHdwTlh2ZUVudFQxVmJXalc4NlhZYzVkN2xYakg1Ym0wUTVmeW5TZXQ2YkdW?=
 =?utf-8?B?eHR1VUdxaTB6MHQ5VENXcTBlU2FSVVNIbGo3ZXBscSthVGpnN0c2QlFiRzlJ?=
 =?utf-8?B?MXZ0S3ZVV29tcTdlRUFyaTFKOGR0aU9hQngvdFVYWUhneXRobWppRDN1SXk2?=
 =?utf-8?B?eXgyNTBCUzUya0ZHa2dBWHJyV01mZDBkUUI2Wld3cktIbGFJcnlWbllRb1k1?=
 =?utf-8?B?UGZ1ZzRUR0txOXc1ckliZkxBUXh3TFJabzZYVWVrWHZtQSt1d1ZJc0NvSnRw?=
 =?utf-8?B?OUQ5VStybEhwVGszU1BWMEhLamNKeGd2ZndFUDNkT1ZXUjdqTGI2akVoTXNO?=
 =?utf-8?B?dEEzRzRWWUR1SlFMOUI2enA2VE9mMmRLK3ZJMDBvM2thUnVGc1N5d1huYjRh?=
 =?utf-8?B?eE1ROUZRTGRaTnptNUwrd3FZUElubzRQYWRVSjdmY0hMbDFjL2pybzdhMWlY?=
 =?utf-8?B?T0JnajJTNmJUWUZkbWJQZ0grMDMyV0JJNEtPVnlyWW0ySGNGbWVqQ0hXaitN?=
 =?utf-8?B?M0c1TXQ0dncrVllFcXpCTHkydXAzNHVHd3o4TGdOa0ZZOHpyRlZDbXduYlgv?=
 =?utf-8?B?S24xeUQ5WXcwZE9qTGRDdFJ4TXNaUWY3bHNkWExscit0dmJVUGR6cExjVy95?=
 =?utf-8?B?bS8zemVEK0h1dE9yRkhWMU5LR0lqY2JDQUhOL0szUzR0RjR6NHQxTEpEYnZ5?=
 =?utf-8?B?SzNIQkIwbGVGN3NhVDBPNFhrdjdhandRWnl4WmVGRmhOb0YxTmtmc2R6ZVda?=
 =?utf-8?B?cVZvYkY2WjNpbWJIdk1MSzUvZHdYVzJYbnFjSUVIWHhMKzFaOWdJZkcrNmtD?=
 =?utf-8?B?S0tIUHhGbmpGU1ZzZ0dneWx0QUl4T0cyYXJPYVcwWVIzWjN1ZjM0RjQ4c1U4?=
 =?utf-8?B?eTZrODJpQ0xZSHdQci9TUG9nWUtGMGlEUU9XUU1kd2M5YTlpVm13VWY3Y1hh?=
 =?utf-8?B?MUZNMW9QYWZ2bXI5dE94SzI5K3FJV3pHTis0QzZsbVQrbFRoT0locXlDS1Ez?=
 =?utf-8?B?OVE1TkUzUTUrOEs2NXdXRTVRSHRURVhSVFhuOXdhMjl4ejBGeGlHbVJwMHZN?=
 =?utf-8?B?TEZ4OHdxaGRMTkZ6Z2hCbks4Z3V0T3JmWEhEYXVYU2M3MHB1Tmx0TlRCSCtq?=
 =?utf-8?B?MW1oQnVzeC81anhVUDZ2dDRkSmh3YXhFc0QrTmt2Rlh3NjV2dGtUMFphcU9Q?=
 =?utf-8?B?UXpOMnNWUlR3bnhHQ0s5N3h4dmY0dDE4NmFrdmJkL2pHN3lQaTlBZnNIQW40?=
 =?utf-8?B?WmFQc24zVUJXd1kyZHBscTRzUTNPZTY3K2VTanJrRzVPNUt4eW5rVFEzRW5I?=
 =?utf-8?B?ZTliSkNrdHJ2emszVVEzRWdtdlZMQXdCaitBM2lCM1FZeUJ1b01hYnhZZ3da?=
 =?utf-8?B?MzdXRHR1OXEyYnJNdUZGVkZjMGhXYzBsRTFvL3N0KytpOVdvbndXcUZSenkr?=
 =?utf-8?B?UEpaa0JjUlZWZ1RVYWtVcmY4cjdiaGFJTGlnUmxSMU9ZUm0zQTdkWGJVdm1a?=
 =?utf-8?B?eUhvN2p5YlJJZ3VYTG5PUHJUcGVsNEo2Y3h2eGFyWkY4OHgzMzIwK2hoV2VW?=
 =?utf-8?B?UjZQV1IxMW1NYXdPcDFqMVh6NVRsSy8xTm5ReGVBWnVqZlNXQy9YQW80cFIz?=
 =?utf-8?B?aFg5ODB0QkJCeXBORVlOeGM3M2xnVEUzeUlONE1MazlkZEZkQ25OV0pQMHAr?=
 =?utf-8?B?RCtTZ3I5aUhKT1M4YlY4TWlucnZWazNIREQzV3RSS1ZlSCtPVDhMQ042clRx?=
 =?utf-8?B?VW56ZzRjTjVWZnRyMGJJdTAxNVhsZmtuMXV6TTFHdDEwQjZmSi96VXVWc21r?=
 =?utf-8?B?VzZmY29tLzNpVDBxRDluVTdUQk5aVlZCZlpmZWdXQzVQZklHdEtSYkNiTk9z?=
 =?utf-8?B?MG9FcU5tL3pPdmVXTHRLWmlZcTVkWlhyT295elZCNndJaXFzWDd6YkhndWV3?=
 =?utf-8?B?R2pyUmhNcE1QaUhzL2FHTkZpTEg5M3Y5MFFFMUU1eEYwTk9yM3hHY2FqTTlF?=
 =?utf-8?B?MW5JNC9tTTJyVDJZelYzd3RuUHFlWnZRZ2hCZUpBNmwvSDdJN1hvSnBxTFFR?=
 =?utf-8?B?QW5HY21qMUZQaURnd3h2NTY5MHFyYkxHQlJuZWhWblVCelIzcjIzeklPUGVU?=
 =?utf-8?B?TkFYNDBOOG1LYlBCaCtLZVFPQ3U3d3h5bTNzTEhqeFpPTSsydWJOR053YVRi?=
 =?utf-8?B?UUhnSVVkc05KRWJrT1FId0pMUGI2RWlkVEk1RExPMzVwTWw0MjdtZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e00e10c-a201-426b-70ee-08de89eb2996
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 21:20:24.3747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dOyzHXyOr1Ndv+mlJ9CLOauTkg23qbOulCD2U6zc5qotNLIru5Zw1+E2lIci7XTdp5UhPbDEddJeMDr4SWutJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5982
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_FROM(0.00)[bounces-271308-lists,netdev=lfdr.de];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+]
X-Rspamd-Queue-Id: 0D98631CCB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/24/26 16:48, Jonathan Cameron wrote:
> On Mon, 23 Mar 2026 11:31:12 +0000
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> A Type2 device configured by the BIOS can already have its HDM
>> committed. Add a cxl_get_committed_decoder() function for cheking
> Spell check commit messages. checking if there is one
>

:-)


I'll fix it.


>> so after memdev creation. A CXL region should have been created
>> during memdev initialization, therefore a Type2 driver can ask for
>> such a region for working with the HPA. If the HDM is not committed,
>> a Type2 driver will create the region after obtaining proper HPA
>> and DPA space.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> I'm not following the logic below. Perhaps some comments would help
> me understand why the condition is sufficient.
>
>> ---
>>   drivers/cxl/core/hdm.c | 39 +++++++++++++++++++++++++++++++++++++++
>>   include/cxl/cxl.h      |  3 +++
>>   2 files changed, 42 insertions(+)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index c222e98ae736..006be88efaa5 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -686,6 +686,45 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
>>   	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
>>   }
>>   
>> +static int find_committed_endpoint_decoder(struct device *dev, const void *data)
>> +{
>> +	struct cxl_endpoint_decoder *cxled;
>> +	struct cxl_port *port;
>> +
>> +	if (!is_endpoint_decoder(dev))
>> +		return 0;
>> +
>> +	cxled = to_cxl_endpoint_decoder(dev);
>> +	port = cxled_to_port(cxled);
>> +
>> +	return cxled->cxld.id == port->hdm_end;
> This condition is non obvious enough that to me it maybe needs a comment on
> why it works.


Uhmm, yes, that works but because I check such a decoder is linked to a 
region inside the sfc driver.


Benjamin Cheatham pointed out the weakness of this and I did a bad job 
trying to improve it

.

I think I should check here the decoder state and if a region was auto 
discovered based in such a decoder instead than by the driver.


I will fix it.

Thanks.


>> +}
>> +
>> +struct cxl_endpoint_decoder *cxl_get_committed_decoder(struct cxl_memdev *cxlmd,
>> +						       struct cxl_region **cxlr)
>> +{
>> +	struct cxl_port *endpoint = cxlmd->endpoint;
>> +	struct cxl_endpoint_decoder *cxled;
>> +	struct device *cxled_dev;
>> +
>> +	if (!endpoint)
>> +		return NULL;
>> +
>> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> 	struct device *cxled_dev __free(device) =
> 		device_find_child(&...)
>
> or something along those lines to avoid need for manual put below.
>
>> +	cxled_dev = device_find_child(&endpoint->dev, NULL,
>> +				      find_committed_endpoint_decoder);
>> +
>> +	if (!cxled_dev)
>> +		return NULL;
>> +
>> +	cxled = to_cxl_endpoint_decoder(cxled_dev);
>> +	*cxlr = cxled->cxld.region;
>> +
>> +	put_device(cxled_dev);
>> +	return cxled;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_get_committed_decoder, "CXL");
>

