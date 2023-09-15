Return-Path: <netdev+bounces-34171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2427A270E
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 21:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD0A6281972
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 19:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2B518E2A;
	Fri, 15 Sep 2023 19:19:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891F6FBF7
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 19:19:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CC610D
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 12:19:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIsfug/ERjcUKrV2cGTMPDmI2OEWEJ9VS1HKO8+G++8eD3VYIk7PWeDmMuD0a9fp1c3noEH4u2VKPnBhZr2KkRexKRniXZrKtfzuZPG4dUaqJC60YI8smaKvdV64dosz56kaaDA2Ts5N3LCRalPmwrev7H+4FiHLtXJt4bV9y3GoXO6r/3xO+X4BBzEp2jJQYzNScIBvOKGrwMVdGjqY7BTXANnryez4sTWEEKJuTsMh9zh0b8KrSUui4A8HSe0Hnh5oAatBBRjsYbjeRUWBFgQ+ZdfHDUzoKq0trEjoYPBkegvLAb1a5XQIKWOtgKz0H+vH0qOCC0Lmvbcshni7AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bfi22eyvBdvYOWTOcJF9Ao4HmRsmPfzyoWA5In9QB1c=;
 b=Z9kfLriAyBJF9PL26LKr/xU/ytO62ty6f7+Exo4eabSsC4cqgM4AQxsuPsH5Wk5pkyiC9UcBJ1mcm2+SW9XezX8iFR+OVSk4XQB9QWbM5x43Za1yvFBNpy0XF0BcT4iRQLi+WYmQpCXU+W0MH62JQKZlST9/0LYEYjzlds3EzKXxJboa5ShzYoTYELUM7boOejfd+iX3zv5oEiNI6OhZZrdTOA/GzC26SJszUAFeV8CneJVYgxrbYG93+XGya0f6r9oO3+3x/K3Kb/qU4q7uQtPs7muigWzrrdmL2KJNUiQv3cg4IlBDV0afWbck21ssDJ853n1HNCUUsd3CW73F8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bfi22eyvBdvYOWTOcJF9Ao4HmRsmPfzyoWA5In9QB1c=;
 b=i8AmpQ8OCf1nniX3dWSqJD/t+fmIqaYD/BUz/yVW7CaYAku9BpWAaQVLuyylfLehQ8q1oJ2bpdUEoHXlDrVWVL7mrPxkXw/9jt3uIIJx7/WpYkc0JcWz2dtZ8uq+9FOQh2VTiRi6gMJhm6MHT6OP0yTaQqF8Z5GN2AfdXwlseSI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by PH7PR12MB8055.namprd12.prod.outlook.com (2603:10b6:510:268::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Fri, 15 Sep
 2023 19:18:59 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd%7]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 19:18:59 +0000
Message-ID: <d6c6b06f-4f90-62da-7774-02b737198ce0@amd.com>
Date: Fri, 15 Sep 2023 14:18:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net] amd-xgbe: read STAT1 register twice to get correct
 value
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>, Raju Rangoju <Raju.Rangoju@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Shyam-sundar.S-k@amd.com
References: <20230914041944.450751-1-Raju.Rangoju@amd.com>
 <4f54056f-dac4-4ad8-8f87-0837334d1b01@lunn.ch>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <4f54056f-dac4-4ad8-8f87-0837334d1b01@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::22) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|PH7PR12MB8055:EE_
X-MS-Office365-Filtering-Correlation-Id: c9a5ba51-2f7b-4bac-b0c0-08dbb6209cd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PusOZQUoCpgGl7D4v569tl7KisFyeHTDFXdx8+LOeoweYS/om2FIaYc/N+1fKitIt61C2NUhSgcjLAMFsJp9vBfT6meOO5e3RCWUR9MM/JUYdqc0bM0fGW5mfKGA4Fzb3rdpR5XrU0eQHSwZIe+SYnRARq36/6pC7ZSgaY4p1UOkbLTK2CJQLh1C7BDXiLDaCnKN3r4mCpq0bEZiJK11MecikyoHrDgICWIwwmUKd2gzige4ZjpCZOpFxmTIpdNptHy+r/LpYlWaO7DN6ZSLGsTOBa2rzixz41tqCyhS5A2fvaljhqQZQrcVLL1jy/XsR1ktbkuH03KI5mxgVoJ33080mkgyG0ncNk9UxCZ+IRWEY0xdMOe+3vXhkHaG1vbEdpxSQxrDUWBCOi5F1LLcNIrsoSglFq4V589m239AYzjs8rv8q7FLfgY2S3zV4447QKn4a/ybasyIRhyF3nXVuFm7+83cvC45IF+RuBIrEwmRfnBV52sojIrbmF/VstsRiGeXB+AqsAPk8IR5wAEmc+aXTwh6aHSd+RRZFcq5DX7oHIoWrps3BJ2K2dIEETOUCct2XU68Tp89FZLt7RqD4vpRbql6BsGemZ0tjMwGDDbRBCwX2RTuT3RQDGfOm/JcQMe1BPnLn3XSsMEtue1sFg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199024)(186009)(1800799009)(6506007)(6512007)(53546011)(6666004)(6486002)(38100700002)(83380400001)(86362001)(31696002)(36756003)(2616005)(26005)(31686004)(4744005)(8936002)(6636002)(41300700001)(316002)(8676002)(110136005)(66946007)(478600001)(4326008)(5660300002)(2906002)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YW8wempJVlNQYURta2M3RThhUmY1a2k4QXBSbEthUlhBOWVyY2ZSV1lEOU1B?=
 =?utf-8?B?cndUVDVYN3oxbVhOTCtCU2NUV1FwNEhITkhDUmlLYWhXek1ZQnJJMEYyV2Jh?=
 =?utf-8?B?SDRjb1BMVWhIZ04xL1dnRElBdFJZRXkxNCtIWXFFellINVRSSEdSeTBoMVRn?=
 =?utf-8?B?VklNQWR3ejZQNDJXNjBJY2RWV3NyODR6Yk5rZXBuS1dEMDhYOHM2Z25hS3g5?=
 =?utf-8?B?ZlRLTjRrZXg3aXhPUzRncmUyMGVuYnF2RVZ1TGdvcWVTaStsUEJMQXVsS2Ju?=
 =?utf-8?B?K29jcndZcDNBWnpUU0tpelN2SDVEaGRXSS85OVRhb2tYNmlRWDhic2hxSUg4?=
 =?utf-8?B?V05yZWFKN0JIcDN1M2xnRCtJcE9uMGl0R3ZzS3AydWFsZEtSVnA2RHRDSkkr?=
 =?utf-8?B?UzlpbFdtOGxGN0ZRcGZxSUMxSU1QSE9xblJzcThQR0o0Zm4rclY4MDlIZmg3?=
 =?utf-8?B?ekpWVW9CNTNCWFVvUlFCVm5aUGJxOWNrTXNhUnRheTJMUWppa1ZlUFhhcXRr?=
 =?utf-8?B?NHFPSVdGRWMvMGg0a1lqZzdCUlVoSDJGTCszeFpXQUFyVVJtNXgrOHgxb3Fl?=
 =?utf-8?B?elNSL3RDQnN3SjJYTnd3elppUGQ4aEZHZ3QxMzEvbmNFWDJPb2Z5eit6VDZR?=
 =?utf-8?B?VC92V0hRS0lDeTFEU2tYeVJIeFJiTG9xdmhSRmFiQmFOZ0YyNm9QNlBRVDdU?=
 =?utf-8?B?bHpPL0VnWjV2d3FIYytQbFZHWkFCY3A3RkNKbExyNHpuOHFsSVY2MjVIaDdn?=
 =?utf-8?B?MXh1YmtFYWlPTHRyRHdKVlVsYnloZW9UMDJWbUl0T0Q5bDU5UVExZGsxQ0tn?=
 =?utf-8?B?R3RxKzhuYWtGMjgrSEJtdEphZkJEb2syTGx1VkV5cEpCR2hsZ2RZeG5zSG5l?=
 =?utf-8?B?TWUwUVFwUUN6blhPVU5hT095aEViSmxvRkZXRTNXWXNaUW9UMzF4T0xzeE1U?=
 =?utf-8?B?NGJCQk51TDFXYXhQVmtxMzhWMFFuVVNrZzRzU2RJWm5pc0ZCUndNY3RMcmdU?=
 =?utf-8?B?dmFVcWVaWUlHTlE5V0VzYXRqREw1TC92TnZseU1ZNHFVOERPNkRKcEZrTWd1?=
 =?utf-8?B?Z2lyWDlXQk13VGZkZEgvK0FDbnpLM012Rks4dXN0dENsdER2NEpueGdSdFZ6?=
 =?utf-8?B?ZG96RVpDSlJBcGdrWTN3d0JZNHlseVh6OEdmcU9jSmh1Mmc1OTdFT2kyTkRU?=
 =?utf-8?B?OTJ0TWc4TloxaGtpTVI4RStXbUdXc3Y1QkljbTNPMDRjQlVOcG56eS9mdW1x?=
 =?utf-8?B?a0ZFcEE0eWpvcklnampOK09WNGd3RHZHVzFIUjl2TXpxdGxjeTVnVEtWQTZv?=
 =?utf-8?B?QldWWmlla0VhMXBDcHo4MllFc3pxREMvYkQ1OTg4eTFLU2ZuOGFPY2R5YzI3?=
 =?utf-8?B?VmN3Y1UyMU1PK1RFMEdqQWtRTmh1b0VFcDBKSHZ1K08yc2czUHZBbTluUFNm?=
 =?utf-8?B?Ynk1dWFReEppT3dqWlFvSWN4WGNNVnIrZWZFVG5FTFJVODBidUpDbk1LaVQy?=
 =?utf-8?B?SitBQ2RUNVhWY2EvRGxlSm5XRFFwb0dMVCtZYkJYT0lhSDYwR0tSMkg4WXpn?=
 =?utf-8?B?WldiTDZJV1RLZkF4SG5ON2pocHBmZjJ1a1h2em51WFBPNWdUYVhycDJhOGNV?=
 =?utf-8?B?MG9FVis2SnEvb0NXdG5zRHNBenQ3eWE4djk1SnVzdmxmYW1EcFNRQ2VyQWRW?=
 =?utf-8?B?MEpuUld1Zi96MDdWczhsOURpcjZNTmJ3eHp1ckVwY2ZhdFNHZnZ3TXRwY2NM?=
 =?utf-8?B?bkZGSkVCbENZZ3JRLzlsSDUrdi9yQm9GMzJyWlRTYTkzemFOdlowV3hTeVpt?=
 =?utf-8?B?ME1tcXREc3pXRmlGT3lnY0dRcTRlREgySGN2YTF1T0poMzVxczV5NDUzUjhi?=
 =?utf-8?B?a3piVnEvMU1tYkp0MnY5T205bGR4M1JlelBHajdlOGFyWnRPSFN2TnkzUmFS?=
 =?utf-8?B?WEROZi96WHEzY2dseTl0R01oVUR0Mk1pa0hDemJoR1c5VlRhUHErV3BtZmpO?=
 =?utf-8?B?WDdhWTJSdU9NOWMxT3ZNY3JYNm9OZ0sxUFh4Nis2WUd0TExUbFp5Z3JKdnhC?=
 =?utf-8?B?YytMdXVZVFpZc2RFZnprRk1HWjhxWUJORHAyTVVxRndaUTZqUExUMWJIUGov?=
 =?utf-8?Q?IZdTXR/jrTXl6umkvr8Ztke6R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a5ba51-2f7b-4bac-b0c0-08dbb6209cd2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 19:18:59.1503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rfoK8tYEzm8iht0xAnR2H9GsXQarViRwS+Th3GtlKOPh2kMgW70udizp1swTd7IryyX0VfpEsMNnFek3L+oWKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8055
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/15/23 07:41, Andrew Lunn wrote:
> On Thu, Sep 14, 2023 at 09:49:44AM +0530, Raju Rangoju wrote:
>> Link status is latched low, so read once to clear
>> and then read again to get current state.
> 
> I don't know about your PHY implementation, but within phylib and
> Linux PHY drivers, this is considered wrong. You loose out on being
> notified of the link going down and then back up again. Or up and then
> down again.
> 
> But since this is not a Linux PHY driver, you are free to do whatever
> you want...
> 
> Also, i believe it is latched, not latched low. So i think your commit
> message is wrong. You should probably check with IEEE 802.3 clause 22.

Granted I have an old version of IEEE 802.3, but "Table 22-8 - Status 
register bit definitions" has:

1.2	Link Status	1 = link is up	0 = link is down	RO/LL

So latched low.

Thanks,
Tom

> 
>      Andrew
> 

