Return-Path: <netdev+bounces-98834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 951778D2969
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 02:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41DCF286616
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 00:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847EB1FA4;
	Wed, 29 May 2024 00:22:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77CD1843;
	Wed, 29 May 2024 00:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716942167; cv=fail; b=NHmYnfNOBF/oSwtxrMGEa9qfwthCwzO86T76/FcydsfjDZY7YlLiohMfXtcKJQXuESwOXtof4/9ZMjcH7MF5Fm6GjsdafPOhayBht2NmKZaA9hoiNLxLV+ZJiakRewFxioPoRGDHZvk9apyLJfy93vao3CyT0yyX8bUyj9wmZM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716942167; c=relaxed/simple;
	bh=IeOm1qW6w0n9vHWvzWkKhZM9dTDBKmE5YTYPCtfs5NI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LizQZobd/J77SK/u1pMMo00bMbtjG0BvE8mf4QjdUrCXmelM8ZGwIxsN4t7zTv3vMgVULb5iwPvMcU1nnmBt3hoFzpe9vQF9MOQ4Zhd5YlVIb4FOe09RQvuSzSODyRt4mCLV2BmQGJOMJatsRwYYTo/pLBkwWQdzcIrCwk+zOCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44SMKKT7004323;
	Tue, 28 May 2024 17:22:12 -0700
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ybb90beau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 17:22:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WIy4WADQao0Tu0i+muZLDhe3HkSrLPNGM/r4YQn1PxrHpU4OEFyIDbMhAtnjjF5LZ2F76V+9b85Q13dwbdNK/4bdQ6ZsH+k8UKR8SOITezxgKyPLhaqHhmabSpcq/U42TMbLXfXTowRabs98xinWONpWcYhidVgcnYtSK1G+Q+khZRZRfRDEInoEVu3TKxZjs/z+ZHi3ZaDtwf9nhcepr/zHSP/6URsGFevyo6YYzyGMUWd7QQ1ibR63qIjaxbCNajFPcXfp8mWecJ8s/M0KVEEbxdxFtuuJ4f+pODZp+XLZnM/NomNpDk05HYQAPl9g8181xfCPkdnOrgURSO3ERg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fo4Li1nkhdgkOgJ+rtmDpeR/Bph7XUjMFoWcxZNiqno=;
 b=YvSP8DFA/f6RnWtDTzALefHHBZz9NsmUhQ7MlOqfYE67G0SajArwSZb0ZLrDi/CDloMHDa9CU/5Xh0bBKbk/FmWWx0dzhJAGc3pw0di1DnE1TZU+gGrZ9SX98B6FPDaWsIeRhy9/BnMC/ReG7Ga1wJOVJdNIXeM7mkWAaZeT/9ISA8qNRXpu7Mb4bJoZo1WiRmVFeZSOhbHzEIqo7mNvMEnhrPTsoqnGZeB4TMJlp+Ep+qDWMsPnEw61FngTqeCUfwZzB+gKb5OXNDtnWixV7u5maxNlXZjMdtosfOujQCx8nUkmh1UOEY+ytWuHox3vcq7HYug/lDGhUlQF6Ii1Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by SA1PR11MB7698.namprd11.prod.outlook.com (2603:10b6:806:332::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Wed, 29 May
 2024 00:22:08 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8%4]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 00:22:08 +0000
Message-ID: <b499cbcd-a3c9-4f38-a69a-ad465e7f8d5a@windriver.com>
Date: Wed, 29 May 2024 08:22:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH] net: stmmac: update priv->speed to SPEED_UNKNOWN when
 link down
To: Andrew Lunn <andrew@lunn.ch>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240528092010.439089-1-xiaolei.wang@windriver.com>
 <775f3274-69b4-4beb-84f3-a796343fc095@lunn.ch>
Content-Language: en-US
From: xiaolei wang <xiaolei.wang@windriver.com>
In-Reply-To: <775f3274-69b4-4beb-84f3-a796343fc095@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0223.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::19) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|SA1PR11MB7698:EE_
X-MS-Office365-Filtering-Correlation-Id: ef477c91-1cef-4e1f-1ae1-08dc7f756032
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RGZPa1F5dDB2V1FXRERIN2UxeE5OVnhjWWpmQnpjSk9NZk1oY3VSd25zQzhq?=
 =?utf-8?B?R3RXOW5HZ0QzeWJsUWF3UWlaYk5uK3hUYVZHTFFIRDY0YUwxVzBCNlBMR1N5?=
 =?utf-8?B?bUtIb3NnV2F4Tms4WFFuT05XR2c5L3NzZ2ZEaklKWWd5WjcrcXdhOEw0K3V0?=
 =?utf-8?B?WmtxR1gyTUVZRFQrY1ZIcVFoRkNwUXE5bEhrYU9INUV4RFNndmVDNTdkYWVz?=
 =?utf-8?B?MFJMMmlmblFnN3ltRVhMMXN3SDYrWUpQMEtKWUh2Ylpab1Z3TTFRWlp4UVNN?=
 =?utf-8?B?ZmU2RE5DcjRPT1NtaEZLM0t5YmJXeFd4L281U1lkM0kwOGh2RHNXc3RqSWZZ?=
 =?utf-8?B?WGJsRzhheHh5QU9Vcm05S2RHdVFsbWJVUWFxVkx2NHFQMkpqL1VsTkxrV2lq?=
 =?utf-8?B?Q2QwV3hoVDNMby85czF1YnF2N2d4b1VGVE1BeFB4SWhoaHVsejVwV0ZSb2Vx?=
 =?utf-8?B?Yjl3cGNmanpFV0FPUDFLazMrR3lYb296VHY0WnZWYVV5aGc5L3paRnMwbm00?=
 =?utf-8?B?eEFDa1Nva0s0UVZzN1B0NnAySmRraHVKR0YyYUxuM29qcHVkSld6b3dzd0lk?=
 =?utf-8?B?Sk1KL2ZVMStYd2tuWDRQSlZVSWtNNm1NNUh2REw1ajNQNEhjK2M5V3lBODVR?=
 =?utf-8?B?eWtQWjlLVWRlVStKRW4xMWd6YjNsb2RtbTRnaiswSG5XZ0diNFZEclR4YUJQ?=
 =?utf-8?B?blNhTm1XNEUwSzdvRVdlOG5OeWpycTlPYU8vM082TGVaZEk2MjBycjZ6bVgy?=
 =?utf-8?B?Qk1sR3NReUk4bXE4QlZxeFE1b2FuZTNlak9nclNjdEtBbW5wRVhxekhwajRq?=
 =?utf-8?B?cnc0REdYMHdJVFVmekRyZlpwT2cwOTZJWEFsQjI1QmpjRHZiUXMveFRvNHQx?=
 =?utf-8?B?NloyTTQzelY5MlNtZ1huSytoajZsNzlIWmt5L01xMGhqS1BMY0pXMTBGdFpY?=
 =?utf-8?B?RmZZVjBTQThENnp3WTJmQkNNTysrdk5iTmlLOFlyWlBmYmhIMGZHQnh6V3Uy?=
 =?utf-8?B?bnU0aVBpZ0RxYmQwR3V4dE16QWpKNFl5VDludCt2SFU1eEJIR2RQUnNhT1pK?=
 =?utf-8?B?cjRlMEMwZGU2dTNRSzJiV0cvRXZKeFV4ZWtKRGswWXUvUExHdTRQYStGMURG?=
 =?utf-8?B?S2x1ODFkVHlpWnZRR1F0UVdBUFlsc3B4a2M2MmlDbXZaaGpLdWhma3FWUk0r?=
 =?utf-8?B?bkphRkNZNVV4WkNkeVVla20vcjRNVjVneFpZY3ZqVHdSYjZ0RzJoSnFXZVFI?=
 =?utf-8?B?SmNqMUsrVkVVaUxGZnJyTE9LeWtEaUhpRlZNN1BrblpkVnEvM1BmS1BNMlF0?=
 =?utf-8?B?ZERIU3Znd2RxM1FFbmU2UGNkR3RSdGl1NFFFRkFTUUdXaTFtWVdZaFFKMitT?=
 =?utf-8?B?Tkk4eWVMcFY4VkltS3J6VFB5aXBNNVFwMjNGK2k5MGlsTzloSERkdHJTcjV0?=
 =?utf-8?B?RWQweXBzRkN0SEtHUWhXc3Z4TyttWS9lSjF4WklSS084Q0xXVTl6ajFNbk1r?=
 =?utf-8?B?S1hVSUpKTTZoSHlYSzRUN2hDTWkxdW5CQkdia05GdFlyOG5LVVVuUlJ1ME54?=
 =?utf-8?B?YXl1SkdSZ0dRNThINzJQZmt2N1pOR3p1QkllZTM0ajErQTZNZHhySjA5NXpz?=
 =?utf-8?B?VGxkSlBRU1VKbnY1Vm92aUFTVHhpWTZBaFdqaGQyQkRkNXJjenkxeVBJQldE?=
 =?utf-8?B?TjVyVXZ6SHdGUDMrbEVJQTg4ZExZTitPVzBVUERNOWRHZEFOcXlpcXlRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aHBOa2RVemwyRW1VT0tmN0hhL2JVaDFwY0txWTlOTVRUOUtLYzhESU41eFNv?=
 =?utf-8?B?MlUxbVVtejRvT3pjMGpBQkVUN1NxaHphMjZPcVNrWWJXNmNUV0ZqMkxLMUVB?=
 =?utf-8?B?eEpBVXA4dGw5TFQzS0Era3RhYmVLa3hNTHZIZGZiQ202VjlnR2Z4dVJMelpZ?=
 =?utf-8?B?akEyOEJvZUVhdm1GeUpTU3Nud2lRbS9lYjcralhiRnhVODVIQkh4WUtSL0xS?=
 =?utf-8?B?dG9VK3pFYmtnQW1GVDMzaVlwY3U3L21jdFlpWC81YWs0WUZMTEZrbTFtN1p2?=
 =?utf-8?B?L3pKMUxxZWVoUFBjZVR3OE5OeU9SbG5MeG1UQWdNajlZVkdXa01RT2w3RWxU?=
 =?utf-8?B?d05vVHpHTzFhdGZqc0h3WGpnYnlUSGdxYzJaZkZEZ3ZSK0RkSzUvWnp6eWlK?=
 =?utf-8?B?SU5lR3VGNjcxNW1mZkdxRlcwZUdYUytseWZEQWVYR0tuWGkzOWdwRlRTSjBj?=
 =?utf-8?B?aHUzVXJETE9yQ21rSzZLcytCUERkV3IvTWNnZVRMNU5BQWVQN0RoT3pzNDJZ?=
 =?utf-8?B?bkpRLzB0azd3RWpJY2t6NlRzY2VvYmw4SjIvQVN4Nm1LQ3dqaFdJSzBjNXZ3?=
 =?utf-8?B?MEI2dCtZWkhuVnNrek9ydzNjTDB1TkRnNUhHUzJrc1EyRnpaekd2UTk5djlO?=
 =?utf-8?B?bVk0MjhzbDVEMFhXWEx4a0gzMlZkZE9zNkY1S05aSk85TDNBU096L0ZaZEN3?=
 =?utf-8?B?UE5MN3Z5NktDV3pQdFowSVRuZTI1UDFLc0dwV3Z6QmsxTGowNUJEV0ZIUDZv?=
 =?utf-8?B?REdaSEFNRnlqelBwVzA5UGkyREZjc3IzTVRaOXNCcndOc01FeFg3VTN1RmdX?=
 =?utf-8?B?SFNKQUlTdi9ZYmJ2clQ5Nm9meldPNnlNVlhSbjlDdmdCNEYzdm1zYjROdTNJ?=
 =?utf-8?B?cy9lR0xLa3ZIWHptSEgrWjQ0SG9lWk1xdXJ1SlpzV0hNSzNLT0NXbmRXa0ky?=
 =?utf-8?B?Sk1DNldxdVBVZU5lQ3dIT0JTdUZTUDIvSXdETzlMZ3pCM2U2WEMrTk5lUkND?=
 =?utf-8?B?UmhzbFJpZXNBWXVHM2V5UnhBTThSZ2MrMG9kYXhuNk9MbldHSnU0UlZSTEVF?=
 =?utf-8?B?S052a2I5bW1hOWIrVlRlcFI5VTBVSDR3aHhwTE9XaGl0Z3BtWWlXOXFNTVVl?=
 =?utf-8?B?bnRGZWtISXFaRjNVY2tNSUYwNU9KSnJ0Ym5TMUFSSGlwaWJMVFFUNTVDQUdv?=
 =?utf-8?B?L2ZOQlJWR3dKRGdSSldOQStkTkR6NjZOUmw4T09yUnRUVy9LbE4wVjdCMVps?=
 =?utf-8?B?UUNNQlVKL3FRb0t5ais3Z004c0tnWGNpYW05MzUwMjFHMWcxUk5YU210MDJH?=
 =?utf-8?B?djV3d1ZLRkF0SW5Zd2dOeTdJQnhpaUdPWnFHbTFVckppdjA0WkpiTisrYita?=
 =?utf-8?B?WkFXUGFvWXdyWW9CNE1vM3daUE9kSVcwTlpNQm5KT3NUQW5CaTZQUnloZ3Er?=
 =?utf-8?B?T29KbnZKZ1ZVS3dGeDcrbnlCSzJBMm1kY0trNTJTUXJGazBkZkJVVnAvQlNt?=
 =?utf-8?B?RUhBZVVGbWxDdldFbHNCS1BYckFDZm9EcWVUL2M0SVFVdWRmQnJlWlpzdzhV?=
 =?utf-8?B?NXhaOTZveERkeEhSSUhYU3dsZm5QQmpjSjQ3L2hUSU9Mai8vNFRMbEdheDIv?=
 =?utf-8?B?WCtZZ1RJYlJ5UFZFczlpMElTR2FGdVBEOUhOVTNsUzBEeDNLbG1uQzlDM0sz?=
 =?utf-8?B?RVhCVHN4Vzc3aDFCUUE5RnZFRkhYUU9xaWhjS3BYSWZYbi92SGQyK0ZIREJL?=
 =?utf-8?B?SGxGK1pxR0t1elA3YkR3cHJ3azNBenZZOFRXRVc2RWNSTmVicEFYZGkvOWtH?=
 =?utf-8?B?V09WUjlwMm5ZMUx1VkpBMmRXT2pLR1FOY0RlckF6STRKNU9LZkRVeDZGazVI?=
 =?utf-8?B?NlNjVlVwUHZRMFNrRVh1aGJQR2Ixa3Y1UHZCQWFNRXBuVzZ0UFAyL0p6T2RJ?=
 =?utf-8?B?MUJoOFFraDJLR3Z4RTh3MFBqS3J1dHJZek1ucmRNNnJPYytyQkU0VVoyRWxa?=
 =?utf-8?B?a2dKNlZhSk5UNkhMTUdRUlJLNmtxQ1FIem1oWGxvY3ltNWtIWTVjQk52VEs5?=
 =?utf-8?B?R0p1ZUtRMjMyMi96YUZncjQwQkJyckN0UEE0Z1dGeU9RVVFnRkNpRDM0TmNj?=
 =?utf-8?B?MU5nVEp6Z25ONnFPNlN4Uit5V1NCeER6QXgwSzFpd053WnhGVG8vS3R2aDQx?=
 =?utf-8?B?M3c9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef477c91-1cef-4e1f-1ae1-08dc7f756032
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 00:22:08.4057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dwvZZPZnqH6+eZZQIAE/pgSji2MSh6HClZ2mNI4qXTy/KOlVgq/azI+8Vfbvz9ht+SR3dF8+eITnnr1B94xU7hnP/O0QvZdvpuonk10NCIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7698
X-Proofpoint-ORIG-GUID: ooMPEcMQLuOifvyYOFC0n82SD1ztWC_l
X-Proofpoint-GUID: ooMPEcMQLuOifvyYOFC0n82SD1ztWC_l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_14,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015 impostorscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405290000


On 5/28/24 21:20, Andrew Lunn wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Tue, May 28, 2024 at 05:20:10PM +0800, Xiaolei Wang wrote:
>> The CBS parameter can still be configured when the port is
>> currently disconnected and link down. This is unreasonable.
> This sounds like a generic problem. Can the core check the carrier
> status and error out there? Maybe return a useful extack message.
>
> If you do need to return an error code, ENETDOWN seems more

Currently cbs does not check link status. If ops->ndo_setup_tc() returns 
failure, there will only be an output of "Specified device failed to 
setup cbs hardware offload".

thanks

xiaolei

> appropriate.
>
>         Andrew

