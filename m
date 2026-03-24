Return-Path: <netdev+bounces-271268-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FXpITLtwmkdnQQAu9opvQ
	(envelope-from <netdev+bounces-271268-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:59:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D753131BFBC
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A60C302801A
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894F72FBDE0;
	Tue, 24 Mar 2026 19:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="A4TMfPkz"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020073.outbound.protection.outlook.com [52.101.46.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CE03090F4
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 19:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774382286; cv=fail; b=Mj0KZ2Rk4ZaqRb11AhWSLf2Dx9bLhCTlAZsvbA/Cr/pvxsM5HWIQ3qSk9tatLbe1e25vzeeTMahSstz0XEom86Cl/pVDxNypAm8avWybSwKhUKQHVQ+QTI3kE3XZaOoCogGyljK8qByytR4n5VCD8SGTYojJwBxWrC0+Lbki1cA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774382286; c=relaxed/simple;
	bh=wBMNPJ8E1T/EDZ0AUkIKatnhyxBlvx3iZqpnFlFSqO4=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ITftElUvXYjP8J6y259IA6imllZmWNImn0rUTwL5D70IihDG+zkuswGla904j/trJHbS5qGvZyl/C4V3jbENohMshUle36ELZR6oexeBAGlsUkn6TjXPTH0JoEcJomy6UBy2q/navNA7LAXueCbAdm6eJjehsbvVb/fL+8raiDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=A4TMfPkz reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.46.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSrzMf1jsTgleCqK+EnrWsYCsdW7HLNV62KN2MtegKEb8fARRsTKwS7tt6ne+f+19P/ynOwp9LovnucphLtn+sZ4Xack6w3p+3Mcd2sq8evdQXrv/CBJL69a96Z0VspjH6vbWpH68ILZNcF9L6K/v4zaIh6NnqmkWVUv8ap9HBKQNdDkwCbxuIlQYsp76oV4/fcE8vxrDERvXqZ9LwbZg0KgkhjSPUa5jHjR5w6OP3QBBrXl31POw3YyTH6uYwKn9kI83L70lXk8VTz7SkwO7MXpnFhepmYZDdzObyyAeCr/4JaYXFwVAI2W1hF8jetrC6H5PbiS/fY7ZRPt5SBKEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHvMA9KdkfaYq+NHIx++W5+bmT+QkRLl96XZznmB+34=;
 b=OgWplY/KZ0mMNA461DXqqPxNz7+V8jUbD3UQ+d0VApIfPq9JvBWA42SGB/TOFaWKsbzFwhrcrHL0kU+P4tz+MXff+dWhApDTl+hucyCiPmdDfFG46BtI/kE1S6l7KrIEbdFVmpSe01I6a1RumN37Bx9yz/djt5AmfXs/f8FuDYnG+NbCs7dgT8IQviOEayQiWyYqIP9Wn3lk2KEJshS+op2HvzkJEz0Wy1nS2a5SsMLfmkdU/kQYcHFrwwtP+y0o9nZ1RDpl5zt7IBn1X7cpRK/GunoH//e+awjd7bYWHIf9YhQh7CgHzoA3isP6XH8GJy00PSIB0E5Ngl6EHhaBpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHvMA9KdkfaYq+NHIx++W5+bmT+QkRLl96XZznmB+34=;
 b=A4TMfPkzojWAcB+sCJqmV4qIlyl5T+g/juwga0qicI5jxF1czvHhHSOtZrW3Fwh2OJPqBh4PfkD1kyMZXgKlgSESUA4t3+GX2wkzaKQby5hf9btMU11r/+PQ2MbQWv9iQaAEOsNE5VpajmZUj0iiWCUIEQxbm/t/CwwCB952WT8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 BL1PR01MB7746.prod.exchangelabs.com (2603:10b6:208:399::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.31; Tue, 24 Mar 2026 19:57:52 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 19:57:55 +0000
Message-ID: <fce1bf3e-325c-412b-9b87-0536e273717e@amperemail.onmicrosoft.com>
Date: Tue, 24 Mar 2026 15:57:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 13/13] net/mlx5: Add a shared devlink instance
 for PFs on same chip
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org
References: <20260312100407.551173-1-jiri@resnulli.us>
 <20260312100407.551173-14-jiri@resnulli.us>
 <bab5b6bc-aa42-4af1-80d1-e56bcef06bc2@amperemail.onmicrosoft.com>
 <c37ee2a7-8e19-4aaa-aaf3-4cd5a9c171d1@amperemail.onmicrosoft.com>
 <ib6r4armffxw3f56fxxor3bg4ejhnsfg5ddg4dncae5u6lonty@ds6bfkjoykbl>
 <sim5ddxllwk5dwnbax4w4ieseziqnis7j2hr2vffaymzsvxcsw@b5q2r4shnlg7>
 <d4d7aa10-10f1-4321-9476-266ce7fc7c31@amperemail.onmicrosoft.com>
Content-Language: en-US
In-Reply-To: <d4d7aa10-10f1-4321-9476-266ce7fc7c31@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0343.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::18) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|BL1PR01MB7746:EE_
X-MS-Office365-Filtering-Correlation-Id: 754a5650-1ed3-4a95-26be-08de89dfa3ff
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|55112099003|7053199007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ZYfRilcnyHd4u4mYTR0ARFVVc5ZPQFVCHDCatjZW/c2/lUBrGWEA2QAeSAjMJ9yOw0cWuHGuwLSVW6jC9CkMorlIt5JOqsgMmY+sZ/o7DRFB7Rs1YDijfMsaWjntNSyDbhuaexM+2dGLj/Sh7gK+dnABBEyImHpdsxlQW/iM85AcZPMgeWC1mRozjc4GGHNAA5a/0Z+9j0RKHBsL5KqP++byLXYDPi1u3mk6YntbIFGdxCy+6Mt1XTbC1qf7CJa7KsnpTPJ3ivbY6m1z6kKV5Ch5A3Jak6indNP+c+ZvTqp5aHTAEmL13vNqsNCiw96AX3u2TdL5J/yblhq6jaoJyqQ2Rv0q1XIL6MTj/cfngTrErDGG/T14N+D3Yewyr9AoqDhGVZ1odXt8y8cCKTfJt5d3Z2Wzva5a5DgzOpLUN491pW7q28R54zCk5ObCvdbbK2VT1DnsiRZPNMVq6WnWVcxrOLUfea8vMnc24iBmsMicpQqlmQt8VgJSUV09MFQwcwszJo6nKUmfdgv8RcHvKQ4xtQv3ckUqb/za59oZtxfQZlwR6hDLLPj23t3VttS9jtoAigEru8ve/A49ZHmMmjY80+zqTGrjWNnEuKjnMC9Dz8UFqBLdiomiwG4H3a9T7rTBU25MSyTl4HiZW/Y3b2mYoxNxQR1jHm9X/CXzegGOKBsovaGF5DdRlO+bsJydF/YS6WreUjdvr9N2OFHwH0pVuAnxH/AFPVU6Ovww9nY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(55112099003)(7053199007)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SitobGh1ME05MFhZdE1jdFYrZ0VuV1F2M3BvbWhUTE1TQ1M2VW1ESG5qam42?=
 =?utf-8?B?QjhmbnNoZldKWHNmdlJtTEJMSnh5MlM4SEVINlVMUjc5cHlGcWJvMjRFUVVu?=
 =?utf-8?B?ODNMcXdWYktRRkdYbGVCODJOTVQxc0ZoMnpZUnQ4RFQ0bUZGT3hTZy8zVTBk?=
 =?utf-8?B?Vm1iTU03VGJFcVhCYVdlMWpGdmkyRGp5TkhzR3RoMklmdGtpNjFVajdNcm1m?=
 =?utf-8?B?cjFSNUQ4S04wbnYzb096TU5TVnJ1UHBSaDk1bjZnTUt2RGdyZzNtSS9pd1BC?=
 =?utf-8?B?cnI0c1FUYk5oTDBMYWk4OHVrVkU5WkU3c0ZpUzFXbVU3S1U2YUNpNGtUVVFl?=
 =?utf-8?B?VGdBemU2aXFwWEFmQUMyU01xMHNRUzVER3V2bzNXOEpjL1ZTTkFSYjUrL1VB?=
 =?utf-8?B?K3d5UDRuNk9IMmdBTFJxcWRvY1o3NWZnZGNtRUdtdE9uTm9WdnZNTHpLZzNH?=
 =?utf-8?B?dytaNGoyY0JqVnpUSEpHd0lEajExb1NnanoxQ0JJUHIxeGxKTDN6VlltMzdu?=
 =?utf-8?B?K3BJZzhhZSs0L3VLbHAxNVhaamVZOWl5UndzRDBLaTEzNlAzeTZjeE93bVZC?=
 =?utf-8?B?THIzc1dabTVNbFd6VG9HenlubkE2L2ZrbTlPZ09YdU94Q0Y5dTBhOGU0VGpD?=
 =?utf-8?B?Uk9RNVg0WnU2VEI4ZTM5djZtNnpwNHJGMTRGekNNelJweW13dkkvbFl6d1lE?=
 =?utf-8?B?aHpSMStYdFN5WFhRcVYvaFpCZ0ZIVW15ZmN3ZTZTdUhNbE1aMWxCU2NnVjBa?=
 =?utf-8?B?VEZUK0VDTURyMmk0c3lXK3FjWkZNaVczdCtJN2o0UFVaNTJLRWlQd3BDV3p2?=
 =?utf-8?B?SHNnWnJLaU52d0ZoNFhSZzdqb0NWcTYzNmdoU0NOS0ZvVnFTcEZncGVXNzFI?=
 =?utf-8?B?KzNudHdIYUNWTFZIdC9SSkRRbElzdUwrTk1IQUdPNnVGM0srTUZGd2pQSFgx?=
 =?utf-8?B?SHl6NzJvWEk2SCtXcFkyd1N5Q2M4YzlCeWlMZFdueFhBd3U4Tk9oZ1FmY0xG?=
 =?utf-8?B?elBEV1plRng4WTZvN1JzbDIwb0VhbHhBcGdVOHpxSUxMNCtrNEp1d25vVHVR?=
 =?utf-8?B?cW10NWNEOW9jKyticjY1VkhrMjZ5bnNDVkFOa2NpbnBVTEp1TXVyZjhCNDB6?=
 =?utf-8?B?MHhabjZqVi9zWHRjSk9jRDdVUS9XTUIvc3hsNGRPK2t2UVROcmkyU2xWYTJP?=
 =?utf-8?B?d3lLTVg2RFBvZWxXcnB4UXFLWXFHOGRneFJFaGpRck56VGJ6azBJOGlOZDdu?=
 =?utf-8?B?NXlhbVZkTFpHUnIvd1M3b1BXV24rL25ObGlUODhaeitRNEZ1a2hDejYxbmxO?=
 =?utf-8?B?VSsyekU1R0xUMGpxZFpEZEExZUMzOXAzLzNVU2ZUSE1GMWVKV1hQdUVldzRx?=
 =?utf-8?B?ZkN2M2lCektwaDdhZk5UWHdOelhzQTNyNXBJb2wxTkVyRzdCNnYvZmlzNDk3?=
 =?utf-8?B?QW1wUEtRd014NElrUk5sSE1VYzljZmpFT0l0T25GUXRaTkVIL3VwdUJuNFFT?=
 =?utf-8?B?YWZvclduMVpyNGcwMWgvbmtBVkJhelRaMDYyajJkYnJvTWlUejJ6UlY4SFlK?=
 =?utf-8?B?YnM1TFN1RVl4MVdhRjg1QmNsMTRZV0tWRG1UTDFYQjV5dERuQ1h1eHhlazZB?=
 =?utf-8?B?Tmp5bGVuSjJHNitkaDUvcnpaYUlGaHRaWlV1SVpkMFZVSkRRekE2QXZEVlA0?=
 =?utf-8?B?NVZrTE5oS3F2MXA4Z1dPdjd3elY5R3h6bUpJSnlEeE5RMlNlSHJXdTdNNDF6?=
 =?utf-8?B?U3dTeG1aWm9WM3VXTmFTY3kwZkZJOGVKQVNKaVJnQmZUNGpPK0RhVlp4OGZk?=
 =?utf-8?B?MjVsd0sxTVdLenNiWXlTZHFKOEpQZnIyRFY0RFd6bFV5OVo3bUs2STFyV1NJ?=
 =?utf-8?B?MVBONHFuMGxNVXUyblUxRkUxdzVQeXBBUThwdzVqY2FsNnBUNmpGU3hFQXNS?=
 =?utf-8?B?dW4rVXpHWWtZNTFzMjY1eWxyV3hUTURlS3Y4WVRNNURpLzRTWW1vZW9hSFN2?=
 =?utf-8?B?cVpwOWUvQ3FYMGRZeUQrRWJZVEVNVzQ2eEMvRWljOTBPY3BVSE8wbkl0VEZQ?=
 =?utf-8?B?SXY4ZStsWFlZNWZmQTFwclYrWU1CKzZFdmlERmtqODNyUmtpZGRxb1BsRzNP?=
 =?utf-8?B?K1lhNDR4SytNWWlBVS81RWt6WWdKU0xyMVZnamUvbjZEZWxaTTNBZVNsWENH?=
 =?utf-8?B?aWxCMEhXQVFIa3prN2NNRWxQTkMzWk9SWElWZnZyQlVxTzRlKzBib3E2bkVQ?=
 =?utf-8?B?b0xWSFd1bkJMdFUreS84VnJ4dkZ2NHRDTHNKTjh3K0pUNTNobXBZTHl2YVR3?=
 =?utf-8?B?Lyt4SldzcDZyZElkay9yY1FhVEdSSWNKZ1htTmNjbXRycHZsUnJxdnZ6aFk2?=
 =?utf-8?Q?aA4muEEnkLoLTYNMBtbfxExRLJvs6Fsy59ANOk+xC7ga6?=
X-MS-Exchange-AntiSpam-MessageData-1:
	d6NQEThfReoj1iI6XINr/UEWgDc4fqRrwpDQ53MnZRzrRWtOyrbBV0k+
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 754a5650-1ed3-4a95-26be-08de89dfa3ff
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 19:57:55.8019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xjz3yRx2HnGlAzNKn9iCuk+F3tTI77VXGfpbtCklvqhW2mgRLCYeDnzEUI7Z+9xoM+2a/JIiGNT45tbg0vgR0NU5ECYa600TzjHlJxN3tbBRFeDQEAZw4ktdUor+gY1n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR01MB7746
X-Spamd-Result: default: False [0.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[onmicrosoft.com];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_PERMFAIL(0.00)[amperemail.onmicrosoft.com:s=selector1-amperemail-onmicrosoft-com];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.861];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@amperemail.onmicrosoft.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-271268-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amperemail.onmicrosoft.com:~]
X-Rspamd-Queue-Id: D753131BFBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/24/26 13:49, Adam Young wrote:
>
> On 3/24/26 09:02, Jiri Pirko wrote:
>> Mon, Mar 23, 2026 at 04:05:19PM +0100, jiri@resnulli.us wrote:
>>> Sat, Mar 21, 2026 at 12:37:06AM +0100, 
>>> admiyo@amperemail.onmicrosoft.com wrote:
>>>>
>>>> 0005:01:00.0 Ethernet controller: Mellanox Technologies MT27710 Family
>>>> [ConnectX-4 Lx]
>>> Cool. Will try to reproduce this locally. Thanks!
>>>
>> Hi. Testing this with:
>> 08:00.0 Ethernet controller: Mellanox Technologies MT27710 Family 
>> [ConnectX-4 Lx]
>> works fine. What's your output of "devlink dev info"?
>
> Running on 6.18.6:
>
> # devlink dev info
> pci/0005:01:00.0:
>   driver mlx5_core
>   versions:
>       fixed:
>         fw.psid MT_2420110034
>       running:
>         fw.version 14.32.1010
>         fw 14.32.1010
>       stored:
>         fw.version 14.32.1010
>         fw 14.32.1010
> auxiliary/mlx5_core.eth.0:
>   driver mlx5_core.eth
> pci/0005:01:00.1:
>   driver mlx5_core
>   versions:
>       fixed:
>         fw.psid MT_2420110034
>       running:
>         fw.version 14.32.1010
>         fw 14.32.1010
>       stored:
>         fw.version 14.32.1010
>         fw 14.32.1010
> auxiliary/mlx5_core.eth.1:
>   driver mlx5_core.eth
>
I just confirmed that the error is the failure to look up the SN or V3 
keyword.  The following ugly actually brought up the adapter:

@@ -32,12 +34,14 @@ int mlx5_shd_init(struct mlx5_core_dev *dev)
                 /* Fall-back to SN for older devices. */
                 start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
  PCI_VPD_RO_KEYWORD_SERIALNO, &kw_len);
-               if (start < 0)
-                       return -ENOENT;
         }
-       sn = kstrndup(vpd_data + start, kw_len, GFP_KERNEL);
+       if (start < 0)
+               sn = kstrndup("random", 6, GFP_KERNEL);
+       else
+               sn = kstrndup(vpd_data + start, kw_len, GFP_KERNEL);
         if (!sn)
                 return -ENOMEM;
+

SO I think you need something other than sn to key off of to name the 
shd (if I understand the code correctly)



>
>
>>
>>
>>>
>>>
>>>> 0005:01:00.1 Ethernet controller: Mellanox Technologies MT27710 Family
>>>> [ConnectX-4 Lx]
>>>>
>>>> On 3/20/26 19:16, Adam Young wrote:
>>>>> This breaks on my system:
>>>>>
>>>>> On 7.0.0 It boots fine.  With net-next/main currently at this commit
>>>>>
>>>>>
>>>>> commit 8737d7194d6d5947c3d7d8813895b44a25b84477 (net-next/main,
>>>>> net-next/HEAD)
>>>>> Author: Lorenzo Bianconi <lorenzo@kernel.org>
>>>>> Date:   Fri Mar 13 17:28:36 2026 +0100
>>>>>
>>>>> I get:
>>>>>
>>>>> [   21.859081] mlx5_core 0005:01:00.0: probe_one:2017:(pid 10):
>>>>> mlx5_shd_init failed with error code -2
>>>>> [   21.863266] mlx5_core 0005:01:00.0: probe with driver mlx5_core 
>>>>> failed
>>>>> with error -2
>>>>> [   21.866360] mlx5_core 0005:01:00.1: probe_one:2017:(pid 10):
>>>>> mlx5_shd_init failed with error code -2
>>>>> [   21.869937] mlx5_core 0005:01:00.1: probe with driver mlx5_core 
>>>>> failed
>>>>> with error -2
>>>>>
>>>>>
>>>>> I am happy to help debug:   what do you need from me?
>>>>>
>>>>>
>>>>> On 3/12/26 06:04, Jiri Pirko wrote:
>>>>>> From: Jiri Pirko <jiri@nvidia.com>
>>>>>>
>>>>>> Use the previously introduced shared devlink infrastructure to 
>>>>>> create
>>>>>> a shared devlink instance for mlx5 PFs that reside on the same 
>>>>>> physical
>>>>>> chip. The shared instance is identified by the chip's serial number
>>>>>> extracted from PCI VPD (V3 keyword, with fallback to serial number
>>>>>> for older devices).
>>>>>>
>>>>>> Each PF that probes calls mlx5_shd_init() which extracts the chip 
>>>>>> serial
>>>>>> number and uses devlink_shd_get() to get or create the shared 
>>>>>> instance.
>>>>>> When a PF is removed, mlx5_shd_uninit() calls devlink_shd_put()
>>>>>> to release the reference. The shared instance is automatically 
>>>>>> destroyed
>>>>>> when the last PF is removed.
>>>>>>
>>>>>> Make the PF devlink instances nested in this shared devlink 
>>>>>> instance,
>>>>>> allowing userspace to identify which PFs belong to the same physical
>>>>>> chip.
>>>>>>
>>>>>> Example:
>>>>>>
>>>>>> pci/0000:08:00.0: index 0
>>>>>>     nested_devlink:
>>>>>>       auxiliary/mlx5_core.eth.0
>>>>>> devlink_index/1: index 1
>>>>>>     nested_devlink:
>>>>>>       pci/0000:08:00.0
>>>>>>       pci/0000:08:00.1
>>>>>> auxiliary/mlx5_core.eth.0: index 2
>>>>>> pci/0000:08:00.1: index 3
>>>>>>     nested_devlink:
>>>>>>       auxiliary/mlx5_core.eth.1
>>>>>> auxiliary/mlx5_core.eth.1: index 4
>>>>>>
>>>>>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>>>>>> ---
>>>>>> v2->v3:
>>>>>> - removed "const" from "sn"
>>>>>> - passing driver pointer to devlink_shd_get()
>>>>>> ---
>>>>>>    .../net/ethernet/mellanox/mlx5/core/Makefile  |  5 +-
>>>>>>    .../net/ethernet/mellanox/mlx5/core/main.c    | 17 ++++++
>>>>>>    .../ethernet/mellanox/mlx5/core/sh_devlink.c  | 61 
>>>>>> +++++++++++++++++++
>>>>>>    .../ethernet/mellanox/mlx5/core/sh_devlink.h  | 12 ++++
>>>>>>    include/linux/mlx5/driver.h                   |  1 +
>>>>>>    5 files changed, 94 insertions(+), 2 deletions(-)
>>>>>>    create mode 100644
>>>>>> drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
>>>>>>    create mode 100644
>>>>>> drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
>>>>>>
>>>>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
>>>>>> b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
>>>>>> index 8ffa286a18f5..d39fe9c4a87c 100644
>>>>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
>>>>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
>>>>>> @@ -16,8 +16,9 @@ mlx5_core-y :=    main.o cmd.o debugfs.o fw.o eq.o
>>>>>> uar.o pagealloc.o \
>>>>>>            transobj.o vport.o sriov.o fs_cmd.o fs_core.o pci_irq.o \
>>>>>>            fs_counters.o fs_ft_pool.o rl.o lag/debugfs.o lag/lag.o
>>>>>> dev.o events.o wq.o lib/gid.o \
>>>>>>            lib/devcom.o lib/pci_vsc.o lib/dm.o lib/fs_ttc.o
>>>>>> diag/fs_tracepoint.o \
>>>>>> -        diag/fw_tracer.o diag/crdump.o devlink.o diag/rsc_dump.o
>>>>>> diag/reporter_vnic.o \
>>>>>> -        fw_reset.o qos.o lib/tout.o lib/aso.o wc.o fs_pool.o
>>>>>> lib/nv_param.o
>>>>>> +        diag/fw_tracer.o diag/crdump.o devlink.o sh_devlink.o
>>>>>> diag/rsc_dump.o \
>>>>>> +        diag/reporter_vnic.o fw_reset.o qos.o lib/tout.o lib/aso.o
>>>>>> wc.o fs_pool.o \
>>>>>> +        lib/nv_param.o
>>>>>>      #
>>>>>>    # Netdev basic
>>>>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c
>>>>>> b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>>>>>> index fdc3ba20912e..1c35c3fc3bb3 100644
>>>>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
>>>>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>>>>>> @@ -74,6 +74,7 @@
>>>>>>    #include "mlx5_irq.h"
>>>>>>    #include "hwmon.h"
>>>>>>    #include "lag/lag.h"
>>>>>> +#include "sh_devlink.h"
>>>>>>      MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
>>>>>>    MODULE_DESCRIPTION("Mellanox 5th generation network adapters
>>>>>> (ConnectX series) core driver");
>>>>>> @@ -1520,10 +1521,16 @@ int mlx5_init_one(struct mlx5_core_dev *dev)
>>>>>>        int err;
>>>>>>          devl_lock(devlink);
>>>>>> +    if (dev->shd) {
>>>>>> +        err = devl_nested_devlink_set(dev->shd, devlink);
>>>>>> +        if (err)
>>>>>> +            goto unlock;
>>>>>> +    }
>>>>>>        devl_register(devlink);
>>>>>>        err = mlx5_init_one_devl_locked(dev);
>>>>>>        if (err)
>>>>>>            devl_unregister(devlink);
>>>>>> +unlock:
>>>>>>        devl_unlock(devlink);
>>>>>>        return err;
>>>>>>    }
>>>>>> @@ -2005,6 +2012,13 @@ static int probe_one(struct pci_dev *pdev,
>>>>>> const struct pci_device_id *id)
>>>>>>            goto pci_init_err;
>>>>>>        }
>>>>>>    +    err = mlx5_shd_init(dev);
>>>>>> +    if (err) {
>>>>>> +        mlx5_core_err(dev, "mlx5_shd_init failed with error code 
>>>>>> %d\n",
>>>>>> +                  err);
>>>>>> +        goto shd_init_err;
>>>>>> +    }
>>>>>> +
>>>>>>        err = mlx5_init_one(dev);
>>>>>>        if (err) {
>>>>>>            mlx5_core_err(dev, "mlx5_init_one failed with error code
>>>>>> %d\n",
>>>>>> @@ -2018,6 +2032,8 @@ static int probe_one(struct pci_dev *pdev,
>>>>>> const struct pci_device_id *id)
>>>>>>        return 0;
>>>>>>      err_init_one:
>>>>>> +    mlx5_shd_uninit(dev);
>>>>>> +shd_init_err:
>>>>>>        mlx5_pci_close(dev);
>>>>>>    pci_init_err:
>>>>>>        mlx5_mdev_uninit(dev);
>>>>>> @@ -2039,6 +2055,7 @@ static void remove_one(struct pci_dev *pdev)
>>>>>>        mlx5_drain_health_wq(dev);
>>>>>>        mlx5_sriov_disable(pdev, false);
>>>>>>        mlx5_uninit_one(dev);
>>>>>> +    mlx5_shd_uninit(dev);
>>>>>>        mlx5_pci_close(dev);
>>>>>>        mlx5_mdev_uninit(dev);
>>>>>>        mlx5_adev_idx_free(dev->priv.adev_idx);
>>>>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
>>>>>> b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
>>>>>> new file mode 100644
>>>>>> index 000000000000..bc33f95302df
>>>>>> --- /dev/null
>>>>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
>>>>>> @@ -0,0 +1,61 @@
>>>>>> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>>>>>> +/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights
>>>>>> reserved. */
>>>>>> +
>>>>>> +#include <linux/mlx5/driver.h>
>>>>>> +#include <net/devlink.h>
>>>>>> +
>>>>>> +#include "sh_devlink.h"
>>>>>> +
>>>>>> +static const struct devlink_ops mlx5_shd_ops = {
>>>>>> +};
>>>>>> +
>>>>>> +int mlx5_shd_init(struct mlx5_core_dev *dev)
>>>>>> +{
>>>>>> +    u8 *vpd_data __free(kfree) = NULL;
>>>>>> +    struct pci_dev *pdev = dev->pdev;
>>>>>> +    unsigned int vpd_size, kw_len;
>>>>>> +    struct devlink *devlink;
>>>>>> +    char *sn, *end;
>>>>>> +    int start;
>>>>>> +    int err;
>>>>>> +
>>>>>> +    if (!mlx5_core_is_pf(dev))
>>>>>> +        return 0;
>>>>>> +
>>>>>> +    vpd_data = pci_vpd_alloc(pdev, &vpd_size);
>>>>>> +    if (IS_ERR(vpd_data)) {
>>>>>> +        err = PTR_ERR(vpd_data);
>>>>>> +        return err == -ENODEV ? 0 : err;
>>>>>> +    }
>>>>>> +    start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size, "V3",
>>>>>> &kw_len);
>>>>>> +    if (start < 0) {
>>>>>> +        /* Fall-back to SN for older devices. */
>>>>>> +        start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
>>>>>> + PCI_VPD_RO_KEYWORD_SERIALNO, &kw_len);
>>>>>> +        if (start < 0)
>>>>>> +            return -ENOENT;
>>>>>> +    }
>>>>>> +    sn = kstrndup(vpd_data + start, kw_len, GFP_KERNEL);
>>>>>> +    if (!sn)
>>>>>> +        return -ENOMEM;
>>>>>> +    /* Firmware may return spaces at the end of the string, strip
>>>>>> it. */
>>>>>> +    end = strchrnul(sn, ' ');
>>>>>> +    *end = '\0';
>>>>>> +
>>>>>> +    /* Get or create shared devlink instance */
>>>>>> +    devlink = devlink_shd_get(sn, &mlx5_shd_ops, 0, 
>>>>>> pdev->dev.driver);
>>>>>> +    kfree(sn);
>>>>>> +    if (!devlink)
>>>>>> +        return -ENOMEM;
>>>>>> +
>>>>>> +    dev->shd = devlink;
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>>> +void mlx5_shd_uninit(struct mlx5_core_dev *dev)
>>>>>> +{
>>>>>> +    if (!dev->shd)
>>>>>> +        return;
>>>>>> +
>>>>>> +    devlink_shd_put(dev->shd);
>>>>>> +}
>>>>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
>>>>>> b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
>>>>>> new file mode 100644
>>>>>> index 000000000000..8ab8d6940227
>>>>>> --- /dev/null
>>>>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
>>>>>> @@ -0,0 +1,12 @@
>>>>>> +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
>>>>>> +/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights
>>>>>> reserved. */
>>>>>> +
>>>>>> +#ifndef __MLX5_SH_DEVLINK_H__
>>>>>> +#define __MLX5_SH_DEVLINK_H__
>>>>>> +
>>>>>> +#include <linux/mlx5/driver.h>
>>>>>> +
>>>>>> +int mlx5_shd_init(struct mlx5_core_dev *dev);
>>>>>> +void mlx5_shd_uninit(struct mlx5_core_dev *dev);
>>>>>> +
>>>>>> +#endif /* __MLX5_SH_DEVLINK_H__ */
>>>>>> diff --git a/include/linux/mlx5/driver.h 
>>>>>> b/include/linux/mlx5/driver.h
>>>>>> index 04dcd09f7517..1268fcf35ec7 100644
>>>>>> --- a/include/linux/mlx5/driver.h
>>>>>> +++ b/include/linux/mlx5/driver.h
>>>>>> @@ -798,6 +798,7 @@ struct mlx5_core_dev {
>>>>>>        enum mlx5_wc_state wc_state;
>>>>>>        /* sync write combining state */
>>>>>>        struct mutex wc_state_lock;
>>>>>> +    struct devlink *shd;
>>>>>>    };
>>>>>>      struct mlx5_db {
>

