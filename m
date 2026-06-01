Return-Path: <netdev+bounces-293825-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIFJO9itHWondAkAu9opvQ
	(envelope-from <netdev+bounces-293825-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 18:05:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EA1622447
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 18:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 95E46301682C
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 16:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5B929BDB5;
	Mon,  1 Jun 2026 16:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="zrtAuDQq"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021138.outbound.protection.outlook.com [40.107.208.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB841C5F13;
	Mon,  1 Jun 2026 16:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780329705; cv=fail; b=rJXGiYYCjXs+ehzS+Qe3EL39QVIsUQwQnFX1wU8bVY6bQwX1efIFb8+2Zp1TxdJlpGNk+o4fz3vvAyF5VkO142Ghj9Km8tXtm3A8ZTs76DQnkdM+n/kPbq7HswNx/Tgw//awhqdfC3HOM6NjVTMr8DwpU8bmnJGkXEiBSGfEJM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780329705; c=relaxed/simple;
	bh=6uktjFXyvs1mH1Pl4Ji5toG3cHoayg993zAMiCwWres=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IeF/BjIt48W9ipkX6uss3bxkQomx24tzXOd4njzzIdkHu8uQfxA9qVdkl0iNYZDxJijhfil9IKueCJErRN09eIEfa6C4SmRjwU6vlVtTtl6HcN0t25Qccakbujkaxrgx/R/rsHKBLjfszTdcksqjGChR4Z/9IC307LutB7MAFfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=zrtAuDQq reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.208.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zGy5/W+y8YR1eoLwBFao1cHOATwl+6dicgCydwe0XLtTMxUvfrbQvISxPNA62KyBcxfiNfsmQjjs4+YKMtGbnn2uMjGScegNw6X9dnWsOX8SDQLluWx5L/+E6eh61HDNlQvjP1KPgklkiknCb4K1ZYZy6pU+8dO/rlZZ5RY3mLiOBBDVPBsBoA8gIja2k9dY2xBj716tKiIwZp8yqyOOWfMijg0qoWpiyDfHjkrnH9PpAX9FaNGyNDKNT7Cvqti4ZkOCiAIQMOXUFhSl0JyAogQRq8Ah874DpUDM22+w9OOnZfsSog6PMj7uw2+dUvs7CuIZldHj/X5KfvtF7YMyQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0eeMAQeFo0QVRGwB+1hHrtoASQMqc8TCyQcGJrzkzY=;
 b=tQEitY2V0PPO8M80jmuj2NYwF4VdmpweqRhLE3WZg5QUepjQ2pztngsbsRZ/J67n1mpN5uBwwd8qyosWunKfMuXIAPSlcNxaf4ieFOEPDaj282DnbXe53dxBa8sRnBnCLGG7Pa7YCXWhasGdBG8AMCOLQ+1Gu+YNHllNqunKxxzirF6eaANBOVeg/j+roAgx3iKn4a5AXTRR9EuALE5iyvqJiwMrcpMUgO4S/Ip1iO2xu9VGxDmWM2mS8mTb9MSMaNch+BwSTcEpPcKzjJxAGdILiTJ/4rKXtAPYx7MnO/tOL8cCf5xrylRJXYYm+r0Yc4bjbrFcVR1fUG3XH4xk8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0eeMAQeFo0QVRGwB+1hHrtoASQMqc8TCyQcGJrzkzY=;
 b=zrtAuDQqpQdeKlwfhRqbtYYcossBwnpg+eUdiTwBL6OGVUR4QwShwDnQFWrV2NFVvAEwRG21eL8nIBYyqDDDZzALFAeJJ0MOLThsWgd1gJywMHBzdjWORTTnUuTKn0/Jem2BfswAXwWjjEgVDogqpf5aM5xnIYUO95YElPRC+Lc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 MN0PR01MB7611.prod.exchangelabs.com (2603:10b6:208:376::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.16; Mon, 1 Jun 2026 16:01:36 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%5]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 16:01:34 +0000
Message-ID: <4fabc99f-52c1-422e-9513-69e2190bc91a@amperemail.onmicrosoft.com>
Date: Mon, 1 Jun 2026 12:01:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v44] mctp pcc: Implement MCTP over PCC Transport
To: Jeremy Kerr <jk@codeconstruct.com.au>, Paolo Abeni <pabeni@redhat.com>,
 admiyo@os.amperecomputing.com
Cc: matt@codeconstruct.com.au, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
 Jonathan.Cameron@huawei.com, lihuisong@huawei.com
References: <20260522193610.234166-1-admiyo@os.amperecomputing.com>
 <20260528084611.133703-1-pabeni@redhat.com>
 <63aebaed-2456-457d-be70-5211d2f746df@amperemail.onmicrosoft.com>
 <8c2a9e591ba22a95962c2c5f7dff5971fc5123df.camel@codeconstruct.com.au>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <8c2a9e591ba22a95962c2c5f7dff5971fc5123df.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CYZPR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:930:89::10) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|MN0PR01MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: 15933b60-c28b-4bc6-76da-08debff70d9e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003|55112099003|3023799007|18002099003|22082099003|56012099006|4143699003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	kAJ3gn81t5kuvf0oViXWo6oeSJ6p06KIncmu7CsK9up7SI3p5++2aaGgswES9Ihw5hBFTNYRFYejOn3lfjmFqHDeKzYqmzTPvmUMc0e473fNonYeNfyyxPETNR0v8QNg4RgKuXSQFrGHZzKTO36md0y2AqMHktlMNDzjAt8lV8jg14RmJHq3gR0zmEevlHpSZnAWYBXE87QoDZRT/ehHUWv6OynYiSNfP1vCBsEfvvzmbFoHB41bgzaYCNT5W9PAX3bVObPY+UGzP131TE1ud+n6faSLjwUzT2DNX+0ENPSKtpC4P7cyM6cHCkRdrZyP3/NSleSCFqInK/ZZ+wbjFJ8sjP/pA1sLFwyXXk06CaHFjQYP/nHIrT467xG83pkigY41uDDuJujHWAYovhRd8hjKqRJTWGz1YtH5Vs36+F/T56Rj/RYqSF3ZH+DRMg4yrCx61LEn/ZGMiuR1Uvo6l4oweIp3tUsaX02eExLUKXJ04kyKBX9BmthOGaB4TBynr0jnoY9z7Syk/PmKAtSBVPC8aLSh6xOfa18mr2k52Irik1z9vh1gr56DhXLNWvYLnertmfEp3ik5UVqpWXHCED1dcxIDKczn8jb+MhF6u17hpXHL5/3EnDy25ASOjP8yT31Fgz4LyLYdeJT27j1NUMuqVFLmHF50X03z/zqkpjTTnUWZdYDuQIR01ooIFSKL62KxP0KVeTtgJgkzRWPO8g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003)(55112099003)(3023799007)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVJQd1VHcW5lR3lMTTZvUDVOSjdOaG9sOU5KN083dHhDTzRhako4bGFFRjlt?=
 =?utf-8?B?NitNSkhoZmJzbVJjRTJhaU1uM0JnekUybFZXUVc1Q0JKVWlBZ2FYUGw1L0JR?=
 =?utf-8?B?d0xFcy9oZVp0N2R6RU1pMVlWMENoU1UrOVZ1T29qWktjYm80V0lQQXNNYWVr?=
 =?utf-8?B?U0pkNHljRUVvOEhGcVMzZTVhQW95aEo4ays3c2x5cXU5Q3MxNHZJN3N4UW9T?=
 =?utf-8?B?R3RNcnkxWWtZMmZibG9lU1l5Qnk5ZXNtTHNUc1pkalVIVTZFck9iOEtaN28r?=
 =?utf-8?B?VzFKbkNnaGg4cDZidGpuZDc0MUJzbTk0M3QwdjY2Z1hFeGpucnM1UDJSWWpy?=
 =?utf-8?B?elJUQXRCSTQ3TmdzRUdDSlVGNmcybk1XaEl3YmdOMFR6M0tKV0lnQlFBK3Bh?=
 =?utf-8?B?UFk2N1ZZQUdUU1pUMjlkRkNDZWR5V1J3S3ZCOGxSd0hSbHNXaUpaTWhrb2Ro?=
 =?utf-8?B?NDFlNVpyVnM3Z3pXQlVwQkI3SDBSVWgzanY5aHVQb3dmSnh0TWw5dFR2RlF1?=
 =?utf-8?B?ODJOcjJjSVlMc2Q2Q09JSzcvL3NCMDZyZDRLazRYRkNPSUM4SFYyUWpZeGJs?=
 =?utf-8?B?eERWS1JVY2RhTFYvZGlpZXVZc3B2NFdvWDFkZGFnZzZLMkhZTlhRL29Ic05I?=
 =?utf-8?B?dzA2SlpEMlgrU001VGtrV2pOK21rKzN5d3d3UlF5NGIyMlhHbkhWVVI3UnJs?=
 =?utf-8?B?Y29aR3NkMzQydzRjSDEzMzBnTjcwbCtOc1lMVnpkNDdRUzJzL0NJV2V6WUg1?=
 =?utf-8?B?bmY0Zi9PQjlWamhJOUdseitHaXg0MWJVTFYrVTJzYk96UVNHR1JFcmV0ME1y?=
 =?utf-8?B?alZIRHVYYWZmN1M4eTA3cDZoYmhtOTZYRmRaVGovRWdNbzR3UUJhZUZJNjhR?=
 =?utf-8?B?K2NHUTFwdXRUWVowSlVsR1lmbk9YejE4SnJqMlVvNmVTeWd2KzJMbnIwNGNZ?=
 =?utf-8?B?dmxPeUZycVJ5cEpBb1ZxZy9NZUFBWHI4bXRUWk9seGdnUzI0QmJyY3lvZytR?=
 =?utf-8?B?bUYxU3lwYTJWWnIwWHJIQWpCMzhicHRReG5WL2VEYldiSW1GUE40NUhaSWVw?=
 =?utf-8?B?bEl1K0VtSTQvMjdKK21XWFYwK2VvRDZCNnVLWVRyMTBIZm5jdFY4eHhpU0dw?=
 =?utf-8?B?bGdwYnhONnFJUWhXSEQwc3NaRWFMeDN3bUJkVVVHZEEwWFBhemNrM3o2U2Ju?=
 =?utf-8?B?Si9CY3BSdGJrR2hPNExycTdobFo4ZGhVNEZ6QjdKVGF0WmJWZk13ZFlRbmM5?=
 =?utf-8?B?M25pNERCS2d0R3p0aUVnSmNKeDIzbHFwT21HaUE3NHhNOXozRDRxZmE3SkJP?=
 =?utf-8?B?NFZaeEovQ3krclZCZ1lVK3N6SDVtVks1STNLZUxYbmg0TGlmeTNrUUR3b2Uw?=
 =?utf-8?B?eGNmS1o3KzZWTlNSUlN3S0lmZ2xodFNXS3FrcExJcXR1ZUZjcWUxYmVVUkM4?=
 =?utf-8?B?Z3ByWkJuay92bFNRd2NzWXByYVh6d1NMMkpsRVUvWXZGQWIvM2RLT0NJTTRk?=
 =?utf-8?B?TENkQVovVVpkWTZFQi9pdXRDbFBOV0Y1bFhUMW50dWRiNzNjbDlhRGVrVy8y?=
 =?utf-8?B?WkUwdmVXS2NBZEQ0TnI1aUVUMFFUVFhPOHlaTHZ0YlFsSlhLR1RHeXI1LzAr?=
 =?utf-8?B?c2p6Y0d6ZSsvWVFWMDFISVpHSkRkcktGZFEySm5DM3ZtYXhMNjNRZXZXL1Zs?=
 =?utf-8?B?OENtUGdGb0hoQ01pano2MTJQdWVwMTljNkhRMGY4cGRKYzc3Q29BcFBNd2lE?=
 =?utf-8?B?MDQ2Y0Y2ZHQwVmo3WUNYWGZJczBzNjJBUmtZZkVESUJpMWFtWDhWVmRscHRv?=
 =?utf-8?B?Tk1VMlhXZU4yMHQrZUg2ZTgzOWdDeUsxTEovbGpLVm9ENUY2Uk5CNG9mbEFj?=
 =?utf-8?B?dDF5dmVlSERIR1R6dHpwcXowa3lmL0RKZU9adTRGamR3L2hKZ2JTM0hTTWdo?=
 =?utf-8?B?ekllbFdva1NVRmp3Y3ZrdU5nOFVCTXNSNkg3NWhnZjBCS29BS09UaFdUa3hs?=
 =?utf-8?B?N3Q5UVVpR1NHM0U5N3h1dTJRSVVQRlVJMklYNGxmV3BYYzY3QUpBTmQrN0dO?=
 =?utf-8?B?YVNGZEo5MGJLVElQeld1VktUbEJzLzFFQXhYWjlLb1ZzeWxaYW5kTHo3MXNm?=
 =?utf-8?B?V3h6Um44UHVOdWhlWUdzQjJvTll3NmZXb2JTZ09UZXNOb21ocW5yVW9XOW9O?=
 =?utf-8?B?NlNlQitYWkdpMThFeTB0eG5keFJxcllHQjdhdE9LSkpHSFFFRXYvREE4aG8v?=
 =?utf-8?B?OUhtc0hJazE5bmh6cVRnc2t3TlJmQlo2UldwV2hZdGpzckJ2K0s2MlprTFFO?=
 =?utf-8?B?cks2c00rOVRvSFNKdVF3WVRzaHlwWmNoUE9id1BhT1FHUlBBTVgyZlAzOW9s?=
 =?utf-8?Q?2dDIUZgnoC44pxY29lgssh8sUQ1DniGwaMZ5pOKj1xpGF?=
X-MS-Exchange-AntiSpam-MessageData-1:
	2DYP36/3vRbBzE3y3RgaVxJMcdqBliI1pQBB68cyOlaLnIo33aGWh3O5
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15933b60-c28b-4bc6-76da-08debff70d9e
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 16:01:34.0995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B9dhXlKJ/kR+0clpp44nV0/gVXgSv+J+0enF4MRT1YhRqCDS5cSJ+JTLbvU/ViQ/PLBt0L/9WCuWwgsJnEuPN4udC9kHBk4PJamfzrvZ1SGsWZpmUG4LmtHvx/nYHGls
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR01MB7611
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293825-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_PERMFAIL(0.00)[amperemail.onmicrosoft.com:s=selector1-amperemail-onmicrosoft-com];
	DMARC_NA(0.00)[onmicrosoft.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amperemail.onmicrosoft.com:~];
	NEURAL_SPAM(0.00)[0.996];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@amperemail.onmicrosoft.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,amperemail.onmicrosoft.com:mid]
X-Rspamd-Queue-Id: 27EA1622447
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/28/26 21:44, Jeremy Kerr wrote:
> Hi Adam,
>
>>> [Low]
>>> The Link tag and the body of the commit message both reference
>>> DSP0292_1.0.0WIP50. Is it intentional to merge an in-tree binding
>>> based on a Work-In-Progress draft of the spec rather than the
>>> published 1.0.0?
> This is probably worth an update to reference the non-WIP spec version.

Wilco

>
>> The ACPICA code used to access the PCC region and registers is imported
>> an external project, and it hard codes the values to machine, not
>> explicitly little endian.  So making this little-endian only ensures
>> that the ordering is correct.  The only machines that are going to
>> support MCTP over PCC are little endian and 64 bit, so this is strictly
>> speaking correct.
> The configuration is less about "which machines you think might use
> this", but more "what does the implementation require".
>
> The LE condition makes sense, as the driver does not support BE. But
> what is requiring 64-bit?
The code itself will not, as written, work on a 32 Bit system, as there 
are 64 bit specific code.  There is no polan to support 64 bit nor a way 
to test it currently, so this is preventative.  Should this change in 
the future, the driver will need to be modified. Limiting the scope.
>
>>> The header comment says DSP0256 but the URL and the commit message
>>> both say DSP0292. DSP0256 is a different DMTF document (PLDM for
>>> Monitoring and Control). Should the comment read DSP0292?
>>>
>>> [ ... ]
>> The DMTF DSP0256 is the MCTP Host Interface Specification. It
>> standardizes how Management Component Transport Protocol (MCTP) packets
>> and messages are communicated between a system's host software and its
>> internal management controllers (like a BMC or satellite controller).
>> DSP0292 IS specific to the binding. Neither are PLDM. THis comment is
>> correct
> The comment is:
>
>    Implementation of MCTP over PCC DMTF Specification DSP0256
>
> But DSP0256 is not the "MCTP over PCC" transport binding spec. Either
> mention the host interface specifically, or use the correct number for
> the PCC spec. I think the latter would be best, as the host interface
> spec seems less relevant here.

Yeah, just going to drop that line as it is redundant with other info in 
the header.

>
>>>> +static void mctp_pcc_client_rx_callback(struct mbox_client *cl, void *mssg)
>>>> +{
>>>> +	struct acpi_pcct_ext_pcc_shared_memory pcc_header;
>>>> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
>>>> +	struct mctp_pcc_mailbox *inbox;
>>>> +	struct mctp_skb_cb *cb;
>>>> +	struct sk_buff *skb;
>>>> +	int size;
>>>> +
>>>> +	mctp_pcc_ndev = container_of(cl, struct mctp_pcc_ndev, inbox.client);
>>>> +	inbox = &mctp_pcc_ndev->inbox;
>>>> +	memcpy_fromio(&pcc_header, inbox->chan->shmem, sizeof(pcc_header));
>>> [High]
>>> Can this dereference a NULL shmem during teardown?
>>>
>>> Looking at pcc_mbox_free_channel() in drivers/mailbox/pcc.c, the
>>> channel's shmem is iounmapped (and the pointer cleared) before the
>>> shutdown path runs free_irq(). Until free_irq() returns, an inbound
>>> doorbell on another CPU can still fire pcc_mbox_irq, which calls
>>> mbox_chan_received_data(), which calls chan->cl->rx_callback (cl is
>>> still set at that moment) — landing here.
>>>
>>> Existing PCC clients such as drivers/acpi/acpi_pcc.c::pcc_rx_callback
>>> do not touch shmem from their callback, so this driver appears to be
>>> the first one to expose this ordering.
>>>
>>> Should the rx_callback bail out when inbox->chan->shmem is NULL, or
>>> should the ordering in pcc_mbox_free_channel() (free_irq before
>>> iounmap) be addressed in the mailbox layer first?
>> That needs to be fixed in the PCC layer, and is submitted in a different
>> patch.  When that patch is accepted, this issue will be fixed.  I do not
>> want to hold up this driver for that issue.
> Understood that there's a fix in development for this, but we can't
> introduce a potential null pointer dereference in the interim.
>
> If you want this merged before the fix, how about a guard for a valid
> shmem pointer?

The mutux used to control access to the create-teardown path is static 
to drivers/mailbox/mailbox.c

static DEFINE_MUTEX(con_mutex);

I could run mincore, but we would still have a race condition 
immediately after the mincore call.

The patch that this gates on is:

https://lore.kernel.org/lkml/20260522205220.237355-1-admiyo@os.amperecomputing.com/

Please comment on that one to move it along.


>
>> Yeah, the Big Endian reference is spurious.  If there is another
>> iteration I will pull it.
> Sounds good.
>
> Cheers,
>
>
> Jeremy

