Return-Path: <netdev+bounces-268020-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CC/TBJp/t2kmRwEAu9opvQ
	(envelope-from <netdev+bounces-268020-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 04:57:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CD84D2947FA
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 04:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1BA59300612D
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 03:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B5B3246FE;
	Mon, 16 Mar 2026 03:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="NbcDfp1J"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022117.outbound.protection.outlook.com [40.107.200.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30AB17A309;
	Mon, 16 Mar 2026 03:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773633432; cv=fail; b=J6F8AiXYxUzeAWX4qf9rDFU1fAVVvRYfaOyjxMrISxMvc5EPZaYdxSSyFZLHPfFXeMwPN9rGV2jXSsRERG4f68F4R4nW/GH9BkkGC41Dss3PEla8Z0NfRkVMjcSp5xDGV8sZD28+1TrtrCGLYen5ni/nnIKPA4XD+GiPXEZz3sU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773633432; c=relaxed/simple;
	bh=kix4t3cFE6qRxKDFYGz6GsRqGxv+rkrvshntt7QP5EI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qt0bJrI2uCMQh1VoBTCgG4SPpwDUMLoQuDSksABRtF5+MlxVU/BjrYYKqScvf+1W59Emaac2/MeNd0wWp11pZ10b2LgERoYHdqxj4ZiAceJoLbdIF+6oU/nv+mmfOrsDybfDfzRKH0Q56mdVY0n3y0cbUo6K3jELvBqttvbeLcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=NbcDfp1J reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.200.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DHh4gT5IkP5eIyNJQ7ddPNBSqdHmwZamr3nI42qjcY+lJjtNc2tP8+eRPewaqrZNi9nnWgulpRJxu0RIV7xg6vJmIjjetDaqw+Es3D+jm5IrY/IvyjGY1OLGd+kkBxZu5xSlJdIxlxkZUCay8s0ARdq1qb4gE11JjAkZkank6OxJFK301w4cdsfVm/xyPsCycKCORXa+jpynfpbljHeylgObIoxid13npUh2Ud6iNlZUvEWTUTZt6k0ipCTOKm4WVDy/9XafVLRnUChZ21lzQDQ0+1K/yGm862SVeEg2nbA2W09oykjO1Ies/xEAAbfU9CXRgJVgZAoUMuiu6ZL9Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLgFEHlTbMhIZx8RA6MjsIu+zvzcEE9rAOY7b/J/oeY=;
 b=GCkxuByZyhXzMyQnc3w6DLzNOdP9aVZppVUqqgMBsqFYlufB3emUAqWWP4G9Wljqr995xd45UDHhMaSnRxEVZmPprfT5XFiN8l/0Pjkyil4c8wlEka4nPaGU5DV67e7MPz4s8K7eJ1J9X+dVh3Cpn0Z7+uDBnHu7EBiVTEkp6b/Hz60zQDP7ZeZ6rCx77U9uTfmbLCjz5HgKo+MHY6wHdC7uYi8k9Xxd3ullEz87a2XTDRvdafFv493Fhw40N0nbn8eZkDFbI4OpPRci1223upyCB6WJJ8XL5u0pDteth7sT3D4vvOgOoa1cmXlSTOnCR1zZ/QD+gRYaPpRTXH1lOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLgFEHlTbMhIZx8RA6MjsIu+zvzcEE9rAOY7b/J/oeY=;
 b=NbcDfp1JzzTygXcc+/b8cBMHOzO/JmzjmyIb4QmDxM1mJcZK/iXRJHlVvDDTMbYynBKSTG/kCJ21sPog2oXzb9/6ytVH5PuWzAEqjV7qq27lfeAtY5AJiBHvxoZx5mU+4yEKdUjMKitG5m6h8nOM1bGHqu/GmKZFqudEFbSk7qQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 SA3PR01MB7942.prod.exchangelabs.com (2603:10b6:806:315::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.19; Mon, 16 Mar 2026 03:57:03 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.20.9700.021; Mon, 16 Mar 2026
 03:56:55 +0000
Message-ID: <84401e08-9a0d-4ee0-bf28-35b36b218d98@amperemail.onmicrosoft.com>
Date: Sun, 15 Mar 2026 23:57:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v32 1/2] mailbox: pcc: functions for reading and
 writing PCC extended data
To: Adam Young <admiyo@os.amperecomputing.com>,
 Sudeep Holla <sudeep.holla@kernel.org>, Jassi Brar
 <jassisinghbrar@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20260303213649.237851-1-admiyo@os.amperecomputing.com>
 <20260303213649.237851-2-admiyo@os.amperecomputing.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20260303213649.237851-2-admiyo@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0021.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::34) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|SA3PR01MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e01dc6f-6efd-4bd0-0c7a-08de8310108d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|376014|56012099003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	Jj4lP0JlYHY8jLOGyE/wrrZq9paaHkybh5WnABgTHJYST2xLA0Knlv10MI2V29u7tniEDcWZ7WZrbaDpXyPJhLOo3bjnvt84uog6LLqfwgKQ0d1rJrEPIBUIC8CbbXPwj8wxpnMnaEtA6nMvQtcmCGgnHPsFz65FVPonwKUFj4+sWlXcdC+jqiQZCIIY7rRfM1GiPXsycchFEsSO4fM/Ccu17sArjyXZ+gIFQmWJklur0u45l9VQpoKDdP9hCMeVzOdW57QxtY9sUGLsMB4D1ijqIscfoIkro69HbIpKijOQfpj0juA2G4Bct99nliNsfB0ALdUJMCki53Picio5hrFPj8rZYJ8Z4rbHPTrZGHeepcHz1WlTmUbcxybT3DXl0ZJ+XlkSh9nyuUaikdmFqLcbOQvt9bjNHaRwXo2poiHc6yNEXGQz1EszOx1mrTU3XLIgnR8LFiRZB4azKB+TL+t4LDidxXS8A+FxvRu/bUw8PNJCS3loNeAT29RdSlM5KAO9vx8LA3vn+RTPCtUqPQRNDEBQqkYLzmQS2HDssijZvO9Z7GLA0iZuSJWAmAdjurYnGvR2qIVhiqSP/DnjuNYYbPXGpJxZuA+FdHd7lueVEkOMS5OTXExq4y3xMvbBxZnzsgURzD5fc+e4GVyWUAJH46cWxvIqDa48awAILAgV1PRf7oIz21K2HdTOLoH2UUBjEVlyN5/BGY56BhSfs3XcpbWxduQyVpPsOlp69QA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(376014)(56012099003)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmkyOTl0VVhvY3JNWkF5RjUwOFU1eGlKWWh3ZmhJMzRUNEdjdzRVNDBBNWIz?=
 =?utf-8?B?a2ZyWnVhcUVwc21lRFk3TXlvZTlRU2RSakFlMmk5aFBva0VSRmVJRlZncFR6?=
 =?utf-8?B?WGhXazNHL3g1OVh6eVp2K1orUVFCL3BSNFpXYnRSRVpIVzNhazc4bE1Ub1hY?=
 =?utf-8?B?Q0RFempnNXVTZDJFbHlaUWNzcFJRNytsekUyeHYxVWYwRXlUNXFTZHAybWFp?=
 =?utf-8?B?UCtEN2tmQWhzRFZ3ZlVrV00xLzNGMjltYW15clV6bVFaUTByUVczdEpXYTV2?=
 =?utf-8?B?UVNoaFJNc21Wd3kxOXpTNXFrQ25HU0UreEJ2VzJUTW5LUmhPMS9SOXVYVzJl?=
 =?utf-8?B?OW1ZbGMzWWVVMi92M0hJaXk3V3BRSGN2YXdienBjQUI3TTJIb3dHUmJhTTN4?=
 =?utf-8?B?eExqV2JJL1FqdHRtSklNK1BacGhYcDFsd2hPZm5MRVlBZVFmVU55b2lCNWJT?=
 =?utf-8?B?ZCtaaUE4Y2h2ZE41Z292Q2VSazZDVnNyalp0c3N2T0Q5ZENCdURhSExEN1Bs?=
 =?utf-8?B?RnpOUDB3WnA5ZTdzbnNJVjBpbjI4bktUaVg2eHkxK21udzA4Rmh5Q1JFVGRu?=
 =?utf-8?B?dG9Wcm5nVEtEQWkxT0RvNGJmVnNSR2FmeGJDOEdNaGdOaS9SY2xaNnVQWUJa?=
 =?utf-8?B?em1obHZaaWV2LzA3VzB5S1pZZ01BUVdxeU5qK3RmYWdObHJSb2R2cjZqNEZv?=
 =?utf-8?B?TVVVc1BGKzE2R1p3SzduSWFGVzY3Q2wrRlRiWGxlRGhML2lrYVo5MW5oTnpP?=
 =?utf-8?B?SG1NaDN2aEthOXNzN2FHQkdwY1ZlVm1scEFpU1UxUEZjRlBPMkd1amY2S0tB?=
 =?utf-8?B?R2pHbHUweGYwbmMxM3RFUlprWEtvZE42aFRIUkxjYWNNY0JVWTBheXMvSkYx?=
 =?utf-8?B?TU1pVG9tVFhWak5nUUNMaFF2VlBEL2VZOHdMZEhQeGIyNFdpbTZpU0NHdUZT?=
 =?utf-8?B?VzFZM0FSeC9JeVBsMVlGMWJEVHB3eTV2K3ZQVXFNSmtFbDRCdDhSQXFLNUtD?=
 =?utf-8?B?SjE3QVVWSUpDNHJSYUJrcVhxVFk5U045N3lENjBvZTFpV1FUd0dqNWVGZlI1?=
 =?utf-8?B?VGJBTE9YSjhpWEo5UWxJYmtQdEdBNnRncjNoczdoK2hjUnczN2FIS1Z5MjhQ?=
 =?utf-8?B?aTFVVE95d1Z3QngrZ2FmRDg1dnZ3eS9ydjhQMDZjaWViS3NhNDFpc0JjR01h?=
 =?utf-8?B?ckYvNDNDL0dLR2FvRm92Uk45Mlc0SExpOFo1Y0c5NXdSampGZ0hjNmJkMk9h?=
 =?utf-8?B?UzFtV0RRTnlzelBxd0JoWFliaGU0MWNsVGIwbU9mckR5TG1UQUR4K04wM0V5?=
 =?utf-8?B?UVFJUG43eGx5VjdtNjJyYTZaQmRYV2ZzbHppdWZ2MVhFRXNITlJYM3ZkWGJj?=
 =?utf-8?B?ZUdncTR2N3U2VXFnODVOSTJiWjFsN2xqTUl6YVgvZDB4VEdPNGVsd05ubFBn?=
 =?utf-8?B?UHJwZERBSDlFTVduMWlQVnh6V1h2bG54VEZLRXgzTzRGU2RsRDI1V1V6cmd4?=
 =?utf-8?B?V2hiWXJURmhlTEpHKzVkSVpmc0dQWUlSemNtOUxaMnFSNnlQYXVNWnVqOGJw?=
 =?utf-8?B?TjV0OW1tbjhKWGI5c2MvYUdGT1pZMGNSMjA4Q1k5K0h0NGJ0cmN0bHNIZ09C?=
 =?utf-8?B?RVFWZ2libVBzQXNVU25tVXN3bTFiRWEwNGFNWjZJUFUwSlpleEJJYVhTelA5?=
 =?utf-8?B?ZFlYbEFFdmJ2d3g3UG9rc1JBTnNNdldqVkUwaGQvQXdNY25SbklSRjBCS2Ux?=
 =?utf-8?B?Vld3N0FQNEtKVzhQblRoNFhqTXR6alFrS0ZCUnQvc3NMYjlSeFhEVlJvakE5?=
 =?utf-8?B?UFZLeThtNUpMT1l4UGNnaHQ5RnhkR1ZldDZHRTFaNm9id2FaVHlpSHlxZXBJ?=
 =?utf-8?B?ZUQzdUdUU0RMN25TQkpnUHhXQW84ejNOMzVUejN5aWhMZ2IxNjU1NUVBckc3?=
 =?utf-8?B?OGx1RUM1U1IyV3A2VG5nQWN4SkNHSWNMRFQ2a2lpMTBydHJocUJEVU1Tc056?=
 =?utf-8?B?VHN2RVNYaUh0aVhBUDRlM1pnWXlmZG5oTXdqdHBoQmwzeFdIdUtQN0c0NHF6?=
 =?utf-8?B?R3JOd3dvYnBCRkFKZlQvck5mN1ZNSkhaSkdUZ1NucDRiSTJ5dUxUUEdFUUsz?=
 =?utf-8?B?YiszdmNGaUo3SnF2c1ZlTXIzRCtUQkthUDc2NUVzaVJXU2hxUWQ5MTg4NSti?=
 =?utf-8?B?TUpkTEluRjZ6UExyaWdIYVBVbVlGT2VsZURHNGVxcU5CbHNNbGJpellwN2NW?=
 =?utf-8?B?NjE5K1BvRmpHZlU0OWM2SnNQYk1WRGhkUWV5SVlyQk5uTU9BdTRvYmdLSFFn?=
 =?utf-8?B?MHN6TWVkY2Q1YmxNZUpldE5hMUNoTjVOWW9nOTUrZUlIblVpUEVBWHdzeVI2?=
 =?utf-8?Q?Pz5z5pu7sW1Ee5N+d1ktTxJ3jSDvC3WHmK6pR9OA1zdsv?=
X-MS-Exchange-AntiSpam-MessageData-1:
	QlQhVxav1qraFbNV9NdqiiZw5q+3gGKPmgOBOC/zkKZjWXsIusZ0cdMs
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e01dc6f-6efd-4bd0-0c7a-08de8310108d
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 03:56:55.4948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xuVVWiZRktOhaRpgZOwbMaCLObDESRzYWvj47y/+9frDpmArCbD8d+VTLr491VklgprTR/oANtJj0bC/4lgvowhoSfTxao8h/W5SaPLX2JdKA2AexQzTkZ2WntzecU6j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR01MB7942
X-Spamd-Result: default: False [0.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268020-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[onmicrosoft.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_PERMFAIL(0.00)[amperemail.onmicrosoft.com:s=selector1-amperemail-onmicrosoft-com];
	FREEMAIL_TO(0.00)[os.amperecomputing.com,kernel.org,gmail.com,intel.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amperemail.onmicrosoft.com:~];
	NEURAL_SPAM(0.00)[0.778];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@amperemail.onmicrosoft.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amperecomputing.com:email,amperemail.onmicrosoft.com:mid]
X-Rspamd-Queue-Id: CD84D2947FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I am withdrawing this patch for consideration.  It is no longer necessary.

On 3/3/26 16:36, Adam Young wrote:
> Adds a function that allows a client to query the number of bytes
> available to read in order to preallocate buffers for reading.
>
> Adds a function that reads from the shared buffer into memory
> provided by the client.
>
> Adds a function that writes from client memory into the shared
> buffer.
>
> Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
> ---
>   drivers/mailbox/pcc.c | 86 +++++++++++++++++++++++++++++++++++++++++++
>   include/acpi/pcc.h    | 22 +++++++++++
>   2 files changed, 108 insertions(+)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 22e70af1ae5d..a8b377a64e05 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -419,6 +419,92 @@ void pcc_mbox_free_channel(struct pcc_mbox_chan *pchan)
>   }
>   EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
>   
> +/**
> + * pcc_mbox_query_bytes_available - count of bytes cwreadable in the shared buffer
> + *
> + * @pchan: pointer to channel associated with buffer
> + * Return: the number of bytes available to read from the shared buffer
> + */
> +int pcc_mbox_query_bytes_available(struct pcc_mbox_chan *pchan)
> +{
> +	struct acpi_pcct_ext_pcc_shared_memory pcc_header;
> +	struct pcc_chan_info *pinfo = pchan->mchan->con_priv;
> +	int data_len;
> +	u64 val;
> +
> +	pcc_chan_reg_read(&pinfo->cmd_complete, &val);
> +	if (val) {
> +		pr_info("%s Buffer not enabled for reading", __func__);
> +		return -1;
> +	}
> +	memcpy_fromio(&pcc_header, pchan->shmem,
> +		      sizeof(pcc_header));
> +	data_len = pcc_header.length - sizeof(u32) + sizeof(pcc_header);
> +	return data_len;
> +}
> +EXPORT_SYMBOL_GPL(pcc_mbox_query_bytes_available);
> +
> +/**
> + * pcc_mbox_read_from_buffer - Copy bytes from shared buffer into data
> + *
> + * @pchan: channel associated with the shared buffer
> + * @len: number of bytes to read
> + * @data: pointer to memory in which to write the data from the
> + *         shared buffer
> + *
> + * Return: number of bytes read and written into daa
> + */
> +int pcc_mbox_read_from_buffer(struct pcc_mbox_chan *pchan, int len, void *data)
> +{
> +	struct pcc_chan_info *pinfo = pchan->mchan->con_priv;
> +	int data_len;
> +	u64 val;
> +
> +	pcc_chan_reg_read(&pinfo->cmd_complete, &val);
> +	if (val) {
> +		pr_info("%s buffer not enabled for reading", __func__);
> +		return -1;
> +	}
> +	data_len  = pcc_mbox_query_bytes_available(pchan);
> +	if (len < data_len)
> +		data_len = len;
> +	memcpy_fromio(data, pchan->shmem, len);
> +	return len;
> +}
> +EXPORT_SYMBOL_GPL(pcc_mbox_read_from_buffer);
> +
> +/**
> + * pcc_mbox_write_to_buffer - copy the contents of the data
> + * pointer to the shared buffer.  Confirms that the command
> + * flag has been set prior to writing.  Data should be a
> + * properly formatted extended data buffer.
> + * pcc_mbox_write_to_buffer
> + * @pchan: channel
> + * @len: Length of the overall buffer passed in, including the
> + *       Entire header. The length value in the shared buffer header
> + *       Will be calculated from len.
> + * @data: Client specific data to be written to the shared buffer.
> + * Return: number of bytes written to the buffer.
> + */
> +int pcc_mbox_write_to_buffer(struct pcc_mbox_chan *pchan, int len, void *data)
> +{
> +	struct acpi_pcct_ext_pcc_shared_memory *pcc_header = data;
> +	/*
> +	 * The PCC header length includes the command field
> +	 * but not the other values from the header.
> +	 */
> +	pcc_header->length = len - sizeof(struct acpi_pcct_ext_pcc_shared_memory) + sizeof(u32);
> +
> +	if (len > pchan->shmem_size)
> +		return 0;
> +
> +	memcpy_toio(pchan->shmem,  data, len);
> +
> +	return len;
> +}
> +EXPORT_SYMBOL_GPL(pcc_mbox_write_to_buffer);
> +
> +
>   /**
>    * pcc_send_data - Called from Mailbox Controller code. Used
>    *		here only to ring the channel doorbell. The PCC client
> diff --git a/include/acpi/pcc.h b/include/acpi/pcc.h
> index 840bfc95bae3..9be1ae358056 100644
> --- a/include/acpi/pcc.h
> +++ b/include/acpi/pcc.h
> @@ -37,6 +37,14 @@ struct pcc_mbox_chan {
>   extern struct pcc_mbox_chan *
>   pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id);
>   extern void pcc_mbox_free_channel(struct pcc_mbox_chan *chan);
> +extern
> +int pcc_mbox_write_to_buffer(struct pcc_mbox_chan *pchan, int len, void *data);
> +extern
> +int pcc_mbox_query_bytes_available(struct pcc_mbox_chan *pchan);
> +extern
> +int pcc_mbox_read_from_buffer(struct pcc_mbox_chan *pchan, int len,
> +			      void *data);
> +
>   #else
>   static inline struct pcc_mbox_chan *
>   pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
> @@ -44,6 +52,20 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
>   	return ERR_PTR(-ENODEV);
>   }
>   static inline void pcc_mbox_free_channel(struct pcc_mbox_chan *chan) { }
> +static inline
> +int pcc_mbox_write_to_buffer(struct pcc_mbox_chan *pchan, int len, void *data)
> +{
> +	return 0;
> +}
> +static inline int pcc_mbox_query_bytes_available(struct pcc_mbox_chan *pchan);
> +{
> +	return 0;
> +}
> +static inline
> +int pcc_mbox_read_from_buffer(struct pcc_mbox_chan *pchan, int len, void *data)
> +{
> +	return 0;
> +}
>   #endif
>   
>   #endif /* _PCC_H */

