Return-Path: <netdev+bounces-31530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D0B78E920
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 11:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E23331C20958
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 09:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3AF847B;
	Thu, 31 Aug 2023 09:12:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2607579F8
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 09:12:20 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2121.outbound.protection.outlook.com [40.107.6.121])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A58CE9
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 02:12:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wa0F6jAWEO+MLLaaz5AMraGSV4/Y3iNxfCrV9/JwnRYx41AeuS2Fvpqa47N0t5kMHwvq+3fxEX3Dp/u7CINIGHS/BOPjoY4vy10Yn1vPru7oiil2Pqjhe7FAEYyaCyOLu58fTCV+WQqdH0EZNPbeAtBy0UD2GeylVcCkxFnctpbmIkIoowmEDzOu3hnRlswR3kFNSxEDf0Vs/iU6v3IXHiCIv6p4OM0brEwyf9saTbrQLv2R/r9lY49vllsJZ+vnTNrlVPA0Ml6HWIplG412VtcvZzDA9g9rIEfhFoYjVYVGYHAnGjj/nnpO+wBhj1YdBeqeCgnVtn704n7UuyAYcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YQiqOEXQt1FL47ZSAk72e6h0aTp9ZhlnLGwn2BFOkI=;
 b=L3n4XYq8Sc9nS8i3IQBG4PHCgTeFCWGbfcPWLsMcy9/se7+/SA6rVdM9RykcHj3QGYduLFCF0O0xQibxl/1r1GPjUJh0MrHrPaWo34VPVPRwaLHKi59pDDM+W1kF+hyYhCdQBpVgVGDboFLriF2DBUP+760u7lOjL2pYOMM/krcnzUIrDUcxF48kt+4+gli0PDpVaWyv8qs8fQxlpSV2Odizz1E4+EuwkYJpBKsazkSlnyNVvvNh+Lc9to8L61NdWXxXbbnXWk6KuMPAjcsgR7Et9/Pq0TqVpG3q2+vJ6jXPnfoqhJzqJf0AJ777y9UYsAib2IdSWTO9iFYrZoDfTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YQiqOEXQt1FL47ZSAk72e6h0aTp9ZhlnLGwn2BFOkI=;
 b=ZEbv5O7PDl4Kl3TCwgXEhTXc5Cf+woDcM8MlVjbb9+KdsvDdwaocLfbCfyTJzm7CTSPjJ/NC+KLBT7sdIAmOrkEgDEXTgMvowjktb4YwFvX7AOR+V86HwP45uc7dixQom+qI+LM7wxwu97UHgn3kvNZgNjk/WiFdZUR+CxvoVNhs9FfCnZTvg04nCJCSRobizEvY/SB3E8dYxoEg5t0ziJyBES/7zzP40QXa4OMxU7O/0IRIpAbVOyRllyqto/8vVtppFH/0Dn7J+DgccGMtzwSd19UXrdECu+24ASze654+HQQ16v7UPYBW4T6Y+pODeu0Qap+q/wud+aVaSqg1Ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from DB9PR03MB7689.eurprd03.prod.outlook.com (2603:10a6:10:2c2::11)
 by PAWPR03MB9834.eurprd03.prod.outlook.com (2603:10a6:102:2ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 09:12:15 +0000
Received: from DB9PR03MB7689.eurprd03.prod.outlook.com
 ([fe80::b3b9:9dc1:b4b0:ffe2]) by DB9PR03MB7689.eurprd03.prod.outlook.com
 ([fe80::b3b9:9dc1:b4b0:ffe2%4]) with mapi id 15.20.6745.020; Thu, 31 Aug 2023
 09:12:14 +0000
Message-ID: <6897e76b-546f-6c56-36ab-46f97555e922@uclouvain.be>
Date: Thu, 31 Aug 2023 11:12:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH iproute2-next 1/1] tc: fix typo in netem's usage string
Content-Language: en-US
To: Donald Hunter <donald.hunter@gmail.com>, Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, dsahern@kernel.org
References: <20230830150531.44641-1-francois.michel@uclouvain.be>
 <20230830150531.44641-2-francois.michel@uclouvain.be>
 <87ledssftn.fsf@nvidia.com> <m2pm33eg4k.fsf@gmail.com>
From: =?UTF-8?Q?Fran=c3=a7ois_Michel?= <francois.michel@uclouvain.be>
In-Reply-To: <m2pm33eg4k.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::17) To DB9PR03MB7689.eurprd03.prod.outlook.com
 (2603:10a6:10:2c2::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7689:EE_|PAWPR03MB9834:EE_
X-MS-Office365-Filtering-Correlation-Id: b41babc3-75c6-4081-956a-08dbaa025dfe
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CZzpD4g8/y4rSdWVGdQDP1ljEW5Bt3UlrHo+ypTpB97WmyyZ8gVKLBDHkHAs/4pHTx2LhD5pOBCa6uiItUGCm8u08aQx6zWv12RFEF3kXfB6D0YCskbxz9eKciaQ2Eqz0VDo17J1xpzvFiyFDLI7frYbxlnEb6qkYNGUTeauvj75vcmdnpADj4TdGf8thLpmym+JVB05zRUTnP7fjzmERD5ALgAvqme0aZEngbv7u+gwmcivS7wA9VZZ+PBPmkyp5lpfsYyFrVJJOGgrQUgrp7vYwT17GRIBhRp7YjBLXkPv1//l+0BB0cxTirjU/wLWmbqdJbcQu+tmLExWVVWpV+AU1IAbVrZ91xEMFSO2nAJDjQ1pA5b2Jjp0074I2Cm3Lc9dFkTzFMWFh09sfn9MyAzceQbEkBIK1cZACWe50yUGbT4/MomrEo66oHfnNKC64Q0O/FZd64Ziyc/SpBG91BKJfNhWOwWc31prFSp6/dTy7nIgfUoIuX8A8Rmur3cM401pAcCD0Bqfpf4y0eAuyLaafbJHY7VnC6yJLs+aMhp94zm/gmaDSZ8LAercWozs7cbCfpJ8mawJWVA2gMJ/eEG8E/Vfwo2wm9OCoY/VEud0duuU6IOpJfjdVaQTVMp6yohI3ZDgDaToKxm0c9D96w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB7689.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(39860400002)(346002)(396003)(186009)(1800799009)(451199024)(38100700002)(45080400002)(478600001)(966005)(2906002)(8676002)(5660300002)(4326008)(8936002)(66556008)(786003)(66946007)(66476007)(316002)(110136005)(41300700001)(36756003)(86362001)(2616005)(83380400001)(6486002)(6506007)(31696002)(6512007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVZHY2FSSXhycXRqRFEwdzV1ZU5IYVdpeEFIZWkyeEo2VlFreFNhYWQ5MkFw?=
 =?utf-8?B?SmxiM1paeWFPRXJxamQwRWhab0dGbmY4VDBlTE41UFdzbnBqeE5nVTJHU2dV?=
 =?utf-8?B?Z3l6L0IwWlhMSVE5d2xyMUtDQzZ3ODJoSFpIS1pEdk5HV09ER2lyUXdHZ2s4?=
 =?utf-8?B?TjY0SFE4YWp3bnBVWGNZZExOeGtOMVErc0JYRTExNVlTR3ZRSnJYaEFTc3Q3?=
 =?utf-8?B?cFhxc0JJYkR1ODM3M0dLc0RDL284T3JGTGRmUDZReW1XenVPOUc5MnBuSjJh?=
 =?utf-8?B?LzhQcXBFcDZyaWtLM2pWN1VwcUhUT1ZPTDY0cllqdXpvdm54ZlpiTjdMN2po?=
 =?utf-8?B?Ui9ibjdFNzc0blhxNnU0VUM2Y2o2ZjRqN2J1NmkzSDVrL0xOUkFTT0E4dktI?=
 =?utf-8?B?TklYMndINE5FR0U0REx1bFA0MHhiQXo2SHdJYTJKeDFaZmUySDhmeHhnMGty?=
 =?utf-8?B?U2hiVTN6ekpzUFVFVThZekxoOGJMdEJwV214RXVYLzA0SkhTN1JMQnZlQmhG?=
 =?utf-8?B?eTBHTElaVGpwaW92YmhhZW5TeWI1eUVudEZjRzFrc0NDaXBJUDZMallZZk9H?=
 =?utf-8?B?WEJSTm8yTTZEZkU1RVFoVTVDZ0FTOWg5RHpQdnhJdm5YOUlRa05VZytmYnYr?=
 =?utf-8?B?TGFSLzNCR2p5d1luVzhwZnBHaTllcmlDbXJuQXFJWE5Tc0xacEZkSE9OM0E2?=
 =?utf-8?B?ajIrUlZxT1RZZTZqeHhCT2xhLzhHREVzcWd2RWh2VmFGeTk2bXhMUWRtY21j?=
 =?utf-8?B?cmxjT1ZoSU05bk5DVTJoc1NPUDFCK3FvVHV1ZWQ1V3pHYWpHeFNNenpXWXNn?=
 =?utf-8?B?aFJYZlRjejNFK1JtWW1EdVVhWkNRekpBclYzM0xOQXlHbzd2cmJaSnZlS2V4?=
 =?utf-8?B?L1ZVYitFOWtSbHJ5K2hTWUtlMURxeFRxWlRId1cwNHJrRVhLcTFzY2NsSU93?=
 =?utf-8?B?QmdlQVM1RmlHWUJjbXd2WHRDTTI4aTM0VE55ZW03Y0k3SUZ4c1Z0OVpYRWlR?=
 =?utf-8?B?ZzhUaFdRWW8wQ0ZEa0xXd0dUdzBlVVJNSnFoc2lTbm5xN1gxbXJJMDBNNmJu?=
 =?utf-8?B?MEwxbEQxS2Y1N0h2ZWo2SWcrbC9MNzdNeVY0U3YvUDRUdVprRWRCYzFiSVh3?=
 =?utf-8?B?dk43bmhPS3ZLVFJLamx0R2laTG4xL3BzT0hzRG9GcWtjR2VVRTRNNHd3cnJX?=
 =?utf-8?B?aVE2SGR0cnNDT2IrQTh1QXlZYjNjenpaZ1o0RkY2Qm82WlpzcnM3KzZZVHMv?=
 =?utf-8?B?S3dkelRPQ2p3SGpEcVV4MXFuV3NhY1QyN2I3bUo5RGZHYWNZQ1JYQmhaOGow?=
 =?utf-8?B?dEpldy9COGhQbzljNlBLYTBrOStXeWJ3NllnQlVEVEUzOE9aUkgxYzJrTzg1?=
 =?utf-8?B?eDU0R0F1bk5MUFhyeEpEQTN4Tk51QU1maTRKNGRPczZ5SUZLTE10ZTJLL1BH?=
 =?utf-8?B?VTIwekRLcGNDZTNBSElUOGVoMDA5bVZPUU5FT3UyNUgrVGpBUU1ORzRpUXpY?=
 =?utf-8?B?ZE5ZRnYzRVlqb3hDZFZXS0NrUDFXK2xyQWhwQUR0dVVoQnBMRjZkejUxanR0?=
 =?utf-8?B?T3BnWk9XZkROT25Iam5jb3hiOHM0Y1hLd0d1M0NEWE5ERnlmM1MvdEEzclBz?=
 =?utf-8?B?SFNrKzJDTFdhL0dQaEFZTWJnemRrVFZ5SE5hdGU4ampHdUhMR2xMN3lUdjJ0?=
 =?utf-8?B?RUJwTE0xMVdKcXIxVjBZUHFYdzUxZWo3VWpySURoK2lSTVhhOWhDSkl3Z2ZD?=
 =?utf-8?B?L0xDNXVUNU1tUDNvWVNzRXFFSXRtYzVPTno0RnQ0NWcza29WTVk0RXdVWlpQ?=
 =?utf-8?B?eHB0TEgzdVljR0FtVU1IM2pncDBWSGdtbTVjNEtUNHc3d0tMczdGTWJ1Qy9x?=
 =?utf-8?B?azRFS3A3QVNST2JNYXFqN0Q0RE12NkM0NWxFenphUndGOWF3WGhrM3MySEhr?=
 =?utf-8?B?VkxNa3VhSldCODR3ZEFzRlBYRDA0NXlGeUc1V0NtSng1UkFIKzNqaXVzbGx3?=
 =?utf-8?B?N3IrZ1VhNzMvaTRYR3JwSUFhYjgxMWs5OXpFdWlpME4zTURWRXpNNjViUFF1?=
 =?utf-8?B?d1FLemVocTNqZzNWaVhpcDkzQXJ2OEJuL0VMQlA0c3o0TUwvSmJIVEplSFJ6?=
 =?utf-8?B?R2dLelNyallsWHZOWUk5Q044UkdVWEIrOW9RUVZlVEpzRmVrTlo0akpIVzdz?=
 =?utf-8?B?VHFTdHFxaDNJWXhraVlMMkcxTzNKYU5ObTN2RlJQMCtsZlhrT2ZFS1RHSEpt?=
 =?utf-8?B?K2ZwTDJiYUZNNUNxZm12b0pQMld3PT0=?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: b41babc3-75c6-4081-956a-08dbaa025dfe
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7689.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 09:12:14.8394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LlNjR0AxLtUtlHPDdEwBOqCE4+ZSr64IgTstP5ob/T4hdEql2Kh1UEcSqCnc17uU8PcCi0k/BTbqx7CFTmWv+f0MtOqvS5s0xMGsCpC/RiM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB9834
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

Le 31/08/23 à 11:05, Donald Hunter a écrit :
> Petr Machata <petrm@nvidia.com> writes:
> 
>> francois.michel@uclouvain.be writes:
>>
>>> From: François Michel <francois.michel@uclouvain.be>
>>>
>>> Signed-off-by: François Michel <francois.michel@uclouvain.be>
>>
>> Reviewed-by: Petr Machata <petrm@nvidia.com>
>>
>> That said...
>>
>>>   		"                 [ loss state P13 [P31 [P32 [P23 P14]]]\n"
>>>   		"                 [ loss gemodel PERCENT [R [1-H [1-K]]]\n"
>>
>> ... and sorry for piling on like this, but since we are in the domain of
>> fixing netem typos, if you would also fix the missing brackets on these
>> two lines, that would be awesome.
> 
> The tc-netem(8) man page suggests (and usage confirms) that P14 is also
> an optional parameter so it should be bracketed as well.

Allright. While we're at it, I'll will also probably unify the spaces 
around brackets. On other qdiscs, brackets seem to be systematically 
surrounded by spaces.

François

> 
> https://www.man7.org/linux/man-pages/man8/tc-netem.8.html

