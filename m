Return-Path: <netdev+bounces-45451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE7C7DD146
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 17:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D687B20E1D
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 16:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71941200D0;
	Tue, 31 Oct 2023 16:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P88gtIDt"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB431DFC6;
	Tue, 31 Oct 2023 16:12:06 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2079.outbound.protection.outlook.com [40.107.96.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881B0A6;
	Tue, 31 Oct 2023 09:12:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgutdSL+rg6ab6d9GuWsVrKZYFaypOZctA0CPiYRYuRBw4RL2bUyIgYn4FgiuaHTZxC+zW4w695jVBJxpkorgbzYxx0wXPx2ySzcC8EyTWOxJirg4cFwHPkj3AVXNxbZGM1X+DQC2AS4AcCURjEpj4amWu5AjJfuJ8Q5AZwta99Il1TTl1UOTorA8LvUtFodtmxwfkcyXCoAVN6swcIn6g7iIUv2cpJbo4cTOSOuDKKuTlSLxOEns8jOTrOkUsKViH75VX4Osj4AfStxCTlEj/eNCy/YGuGV/O9AE65hsjX+OplP5m2NoAMt6+FcS9r/un8/qErF/1qAtVOs714obA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t74Wmi2XG1PDpMT/xqRNiSXdsY4mVLHUdi75n/Y/tY0=;
 b=eK/ASs3hLndWfydV3JvaF5QB6EgNXistLomZkQHJ+ZEiQIu4VuUckeeotdJsvCT51tz8FWJbuyiYMFSNVHhSL+VlfStgoJxp0npIpYBExrPMqItY/Bggi763+febJVbkZFnfmwEDxECvW+F/BbUOztdQ48NMT+xDqxyfyfc3Lnr6USClqKp3H1EvtCIYN3wGrEETflXPIZuloed2lH/SHubT2z8Ykz44LJIj90uS7mkYfSk//9NFoyKSH/XdWr3r7xl7iOowvEkGvySOBYZiz/OIMckBLbTxBiewCM+k4DFajw/YpaKcvXHMDfXwhTdor2JEVii0+1fY+yZtDVOOuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t74Wmi2XG1PDpMT/xqRNiSXdsY4mVLHUdi75n/Y/tY0=;
 b=P88gtIDtLuAnpkPYrxXer6bAPgKLKfFRKXG8rJ82gF+wTDQGAJL0iAxXS2eBkN2Gb1mZOjO5PytqZFtnBzaSBgqrz+3etckgNj+HzyDlXOJN004mtUq61Qhw2wSgNILe1RGm05mWGToqAwBMVI5C4G3PdG12TymqGu9YB7iFY0g5Onkxb3PogtMY7Al1LptGzovpgMzBOd+4ImBQOiIbRlq1aF8WZZAO/WkoerxRXZZnu9nIgXhi4ux3j/mvRQP2HGlixnVYQa6RY7947gYQ1orn6WTSJqd11pQLpBuIdZt5RdXObwiB0DkcIJkJO9pddyewdb4G2AT9n3XNHdRk3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) by
 CH3PR12MB9393.namprd12.prod.outlook.com (2603:10b6:610:1c5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.28; Tue, 31 Oct 2023 16:12:03 +0000
Received: from DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::8cde:e637:db89:eae6]) by DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::8cde:e637:db89:eae6%5]) with mapi id 15.20.6933.028; Tue, 31 Oct 2023
 16:12:02 +0000
Message-ID: <b4116027-8045-42a0-afa2-1dd8b17ea9ea@nvidia.com>
Date: Tue, 31 Oct 2023 18:11:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 1/6] net: ethtool: allow
 symmetric-xor RSS hash for any flow type
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Ahmed Zaki <ahmed.zaki@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 mkubecek@suse.cz, andrew@lunn.ch, willemdebruijn.kernel@gmail.com,
 Wojciech Drewek <wojciech.drewek@intel.com>, corbet@lwn.net,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 jesse.brandeburg@intel.com, edumazet@google.com, anthony.l.nguyen@intel.com,
 horms@kernel.org, vladimir.oltean@nxp.com,
 Jacob Keller <jacob.e.keller@intel.com>, intel-wired-lan@lists.osuosl.org,
 pabeni@redhat.com, davem@davemloft.net
References: <20231016154937.41224-1-ahmed.zaki@intel.com>
 <20231016163059.23799429@kernel.org>
 <CAKgT0Udyvmxap_F+yFJZiY44sKi+_zOjUjbVYO=TqeW4p0hxrA@mail.gmail.com>
 <20231017131727.78e96449@kernel.org>
 <CAKgT0Ud4PX1Y6GO9rW+Nvr_y862Cbv3Fpn+YX4wFHEos9rugJA@mail.gmail.com>
 <20231017173448.3f1c35aa@kernel.org>
 <CAKgT0Udz+YdkmtO2Gbhr7CccHtBbTpKich4er3qQXY-b2inUoA@mail.gmail.com>
 <20231018165020.55cc4a79@kernel.org>
 <45c6ab9f-50f6-4e9e-a035-060a4491bded@intel.com>
 <20231020153316.1c152c80@kernel.org>
 <c2c0dbe8-eee5-4e87-a115-7424ba06d21b@intel.com>
 <20231020164917.69d5cd44@kernel.org>
 <f6ab0dc1-b5d5-4fff-9ee2-69d21388d4ca@intel.com>
 <89e63967-46c4-49fe-87bc-331c7c2f6aab@nvidia.com>
 <e644840d-7f3d-4e3c-9e0f-6d958ec865e0@intel.com>
 <e471519b-b253-4121-9eec-f7f05948c258@nvidia.com>
 <a2a1164f-1492-43d1-9667-5917d0ececcb@intel.com>
 <d097e7d3-5e16-44ba-aa92-dfb7fbedc600@nvidia.com>
 <CAKgT0UdObrDUGKMC7Tneqc4j3tU1jxRugoEB=u63drHhxOeKyw@mail.gmail.com>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <CAKgT0UdObrDUGKMC7Tneqc4j3tU1jxRugoEB=u63drHhxOeKyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P265CA0021.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::8) To DS7PR12MB6288.namprd12.prod.outlook.com
 (2603:10b6:8:93::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6288:EE_|CH3PR12MB9393:EE_
X-MS-Office365-Filtering-Correlation-Id: a672c2c7-855a-40bb-e47e-08dbda2c1e6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kR7giDjOYTZuwE2xk1NZQc2Ug6plirtCx4u6RHOdAg1uBan3f4RuPpI24lg0S47wp6azCG2K6I8yKD9Y8cdurwuPJkv2eGzCp8de/3eo2+1jReAjHWJO4tpywcUZIcpZ15bVAO9LLamgrJbX8acB8JmK7OUOwAt+c+3SWB2JnjN052YhUJdF+yjLT328TiYl02hvEWRz7I829B0Y+VNUklqJH1cNbAX/Mr9AEkAXwHoxanFKh9tMBcO0zxJ3GSXXBrszji/sg++5vBsymkk//ASFPQKC26Ir7a6Ju5Ef0vjSLJWUXaK+t/F/c7IRYYfzFauX2VHJ8IUXT/C+ffsT1QK3N8YnMJHUJyMomOapPn5oD42p9lDO3QIbDLJfnJwYE5MZ0Y/5HOOAT2b1oYi5Vy4eLJifO80TVjdyTSkE158AE7BPBTSTQj7qw8Zv3XnRrzJTqYQZ2HzK9BJWm1oJr4g74+7rFC/3z2Ep04M67OCWWZnA1oOuzVP83FFTOqap45ekVxPHKLMuwh6Q+8jOzr8mKRqw76LTaHhJiATf9jpKsZ+ggIW4xKZ6NyUI8J8gLofgwH9y7JfPBCRUb06BznE+Zb49qUWIq6f+XjkF1XLdXxj8pZWgYQIc/NGhkXbsdvu7lWrG5FtoDrm5JUO9UACbH0QBMX6CEpB/PTrpNE8uzird0wXwbSEymprEC96t
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6288.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(346002)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(31686004)(6512007)(26005)(2616005)(4001150100001)(38100700002)(31696002)(36756003)(86362001)(316002)(2906002)(6486002)(5660300002)(7416002)(83380400001)(6506007)(53546011)(478600001)(6666004)(8676002)(8936002)(54906003)(4326008)(6916009)(41300700001)(966005)(66556008)(66946007)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NyszSDR4RE1FRUEyZFRVekRMY1FTVG1iaGpRTXhrZ05FUk5TUVZPbk9XYWRK?=
 =?utf-8?B?OEtGRFBYd3QwZDUya2JxTHlTWWVFaDJxVW1WVjFUMEgvazlCTSt3ZXNPZW9v?=
 =?utf-8?B?a2NSZjdadDNvbHFQWE1rWi9KRy92L0l6YXJXbFRDYVhUT1RGWGNxTHVGZzhD?=
 =?utf-8?B?c1RyN3N1bFRHT05jM3Rjb0p6cTUwYTRIMlZ5OWMvbFhjaE43ZE8zM0JzQ3Zz?=
 =?utf-8?B?QndiSWRXcktWeHJYUHlhUGVuTlg3N3BTc0xsWHdlTld3M2tkbFI2WDEweWdS?=
 =?utf-8?B?QnhvbXpjNHN4ajBkc0NtUTFydHZHR3ZseUpNUEpBRE0yYjhMaDMxQ1JmN3Yz?=
 =?utf-8?B?RGdNVnhnUUE1OUZOeUdmelZrbng4Ym1YR3pkTWxpU3Z0OEQzYm9XMVVPcWZy?=
 =?utf-8?B?T3diU29pN2hhNlY0WUZKRFhoOFhBczNXallTVzQwL0V5eUtNMllJTXJlWVk0?=
 =?utf-8?B?U0JsSUl6eVBsNHI3QTFuRG9WTFlLZmU2VnN0T0R6QU5kZS9KUng1c0ZXT2hD?=
 =?utf-8?B?SG5zRW04dEs1MDZwck9PWHVLWmhoWm5Ib3ZvL2JHWHA2d3o0QXRNSzVjWDBy?=
 =?utf-8?B?Y0VmSllsS0phazc3WGVyYm43ME1JR1hSdHl5ZVJrMWhiSExqTzZITGRPWHZU?=
 =?utf-8?B?R1RIRjcxTzgzT1dDWHd2RlhmMXpaaElhRkZMaS8yczBSQmVwdUl3MmtVM3l0?=
 =?utf-8?B?bVJNa3hNTk5EVmdoTkZudjAxOVhoWEVJUXc3WFB2Q3IybXRkMVo1OGtHV2tX?=
 =?utf-8?B?Qm03bHhXUTNzd3BBZWUwMFJrakVHZzBPSDZlVFJlWWFWTXlhQVRqU0xEaWFw?=
 =?utf-8?B?eVJJakVaUWlud1B0RFVRaGlObHNIdTJtSE92My9zL2N5Ulhaam9oZENzck9W?=
 =?utf-8?B?dWtVUGZvcktrV2k3ZXRyQ3Z4alRKZlJNVFQ2SnZhV0o4bTJjc1hyczJNZi9p?=
 =?utf-8?B?ZEJ4dmxIUmtMTWV1VlFEMDI4S2orU1U4Qkd1eFQyU1phOHlaQjNkangwMkZ6?=
 =?utf-8?B?VUhUeG11TEZIZGRIeTA3Q2lOV1RIQWhYV2VMV01JU0RZN2JzYWtWK2dLT0JX?=
 =?utf-8?B?YWQraXVORkwwYTYwMHNaK3V1a1lMTUtxRE82TjhhbDdmMjF0TTFyUEJuOFZD?=
 =?utf-8?B?SkR5VXpWYlR3ek5MT2xVaHZvVm1QSXg4dkhtSGxiZFlXT2s5SmRkY0hLYVB4?=
 =?utf-8?B?L3NrVXgrUTN0WUJaOHVYQkxTY0UreGJSeFNuQ3pHbWNMSVBwaE9WbHk5dzhu?=
 =?utf-8?B?NU4wVmx0TkYzTktlVnZEUnVncDlYZ2dUaW9vRjd1RnpjMWhUVWwyaG9obEJO?=
 =?utf-8?B?QjhjcW1Eb29nUmNQVXFFRVhuakpUeUFHam9qNnR4bnpZS1gzN0F3V0JZY25L?=
 =?utf-8?B?SmZSOWxVay9XengwaXhGekJoU0d0bWQwS3pSNHJpaXJma3ZtNVltSFNLUGtj?=
 =?utf-8?B?bnU5MFJZdmsxbTVBb01MZlA5U2ovMTFKSlhRM3dHRDR4OWlRNG93WCtMYjFP?=
 =?utf-8?B?ekFyY09GQ29kV2cvM0xuN1R5WndGRTdLVk9qYnV5VmRMVzUzWFFYQ05zTFdV?=
 =?utf-8?B?djdQZHpaem5XWmZLNlRnZStrVzMvMWQ2WXFkVW5jZUx3UDNRNDh4L0ZDSnhj?=
 =?utf-8?B?aDgvZUk2TXZNWnFnSXhEa2s4SEFhQUQrUVRIUm9mOVE1d2VUL1VraVBtdGdL?=
 =?utf-8?B?SjJkeEQxRmwvbnU1SVpDUXU2QUVBbGRQcmNDME9nWEtZbUROZjY0MWNtS0dn?=
 =?utf-8?B?S2QzNi9vMUxRMTNQZ2QyMXdkS0k3Y3V0ZzNHazZxYVFMVlh5cERuZmJnSWlm?=
 =?utf-8?B?aURGc0E2MmJJWG0vTnhna1NxYzRnV2QwbVNEeFBsS0UyUUljdGZhZ25Vb0dP?=
 =?utf-8?B?RWowVHI1dnFKV0FVTmpsdWZLVVlQRmVGZ0ZRSkJZRXRxckxtbmZ5VUxWZHJ1?=
 =?utf-8?B?N3QyNDllYVlUbk5TZnMveWlKMzVnWXNDek9NTHQyNUFNdFBtQUxXRFdLY1Qx?=
 =?utf-8?B?VmN6UlZiVW8vNWFYakVUWjVTRVdlUjRrQ1dVbWZtZEJDZjZXUjIzQW45S0NF?=
 =?utf-8?B?Y0xadWtRajdpZHExTTdPWi9wbENGMGZjV3BmZzczMldWQ1VXM2ZkSUVGbHRG?=
 =?utf-8?Q?WStA6eNhQtIU3Y9yk4klkpI0R?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a672c2c7-855a-40bb-e47e-08dbda2c1e6a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6288.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 16:12:02.9098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gC8WaZsH+1aIt3ST7LpoNoRM5RCUzTblHcDg6DofOJ38MfWSaaTGb4uUPEDcxcfT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9393

On 31/10/2023 16:59, Alexander Duyck wrote:
> On Tue, Oct 31, 2023 at 5:01 AM Gal Pressman <gal@nvidia.com> wrote:
>>
>> On 29/10/2023 18:59, Ahmed Zaki wrote:
>>>
>>>
>>> On 2023-10-29 06:48, Gal Pressman wrote:
>>>> On 29/10/2023 14:42, Ahmed Zaki wrote:
>>>>>
>>>>>
>>>>> On 2023-10-29 06:25, Gal Pressman wrote:
>>>>>> On 21/10/2023 3:00, Ahmed Zaki wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2023-10-20 17:49, Jakub Kicinski wrote:
>>>>>>>> On Fri, 20 Oct 2023 17:14:11 -0600 Ahmed Zaki wrote:
>>>>>>>>> I replied to that here:
>>>>>>>>>
>>>>>>>>> https://lore.kernel.org/all/afb4a06f-cfba-47ba-adb3-09bea7cb5f00@intel.com/
>>>>>>>>>
>>>>>>>>> I am kind of confused now so please bear with me. ethtool either
>>>>>>>>> sends
>>>>>>>>> "ethtool_rxfh" or "ethtool_rxnfc". AFAIK "ethtool_rxfh" is the
>>>>>>>>> interface
>>>>>>>>> for "ethtool -X" which is used to set the RSS algorithm. But we
>>>>>>>>> kind of
>>>>>>>>> agreed to go with "ethtool -U|-N" for symmetric-xor, and that uses
>>>>>>>>> "ethtool_rxnfc" (as implemented in this series).
>>>>>>>>
>>>>>>>> I have no strong preference. Sounds like Alex prefers to keep it
>>>>>>>> closer
>>>>>>>> to algo, which is "ethtool_rxfh".
>>>>>>>>
>>>>>>>>> Do you mean use "ethtool_rxfh" instead of "ethtool_rxnfc"? how would
>>>>>>>>> that work on the ethtool user interface?
>>>>>>>>
>>>>>>>> I don't know what you're asking of us. If you find the code to
>>>>>>>> confusing
>>>>>>>> maybe someone at Intel can help you :|
>>>>>>>
>>>>>>> The code is straightforward. I am confused by the requirements: don't
>>>>>>> add a new algorithm but use "ethtool_rxfh".
>>>>>>>
>>>>>>> I'll see if I can get more help, may be I am missing something.
>>>>>>>
>>>>>>
>>>>>> What was the decision here?
>>>>>> Is this going to be exposed through ethtool -N or -X?
>>>>>
>>>>> I am working on a new version that uses "ethtool_rxfh" to set the
>>>>> symmetric-xor. The user will set per-device via:
>>>>>
>>>>> ethtool -X eth0 hfunc toeplitz symmetric-xor
>>>>>
>>>>> then specify the per-flow type RSS fields as usual:
>>>>>
>>>>> ethtool -N|-U eth0 rx-flow-hash <flow_type> s|d|f|n
>>>>>
>>>>> The downside is that all flow-types will have to be either symmetric or
>>>>> asymmetric.
>>>>
>>>> Why are we making the interface less flexible than it can be with -N?
>>>
>>> Alexander Duyck prefers to implement the "symmetric-xor" interface as an
>>> algorithm or extension (please refer to previous messages), but ethtool
>>> does not provide flowtype/RSS fields setting via "-X". The above was the
>>> best solution that we (at Intel) could think of.
>>
>> OK, it's a weird we're deliberately limiting our interface, given
>> there's already hardware that supports controlling symmetric hashing per
>> flow type.
>>
>> I saw you mentioned the way ice hardware implements symmetric-xor
>> somewhere, it definitely needs to be added somewhere in our
>> documentation to prevent confusion.
>> mlx5 hardware also does symmetric hashing with xor, but not exactly as
>> you described, we need the algorithm to be clear.
> 
> It is precisely because of the way the symmetric-xor implements it
> that I suggested that they change the algo type instead of the input
> fields.
> 
> Instead of doing something such as rearranging the inputs, what they
> do is start XORing them together and then using those values for both
> the source and destination ports. It would be one thing if they
> swapped them, but instead they destroy the entropy provided by XORing
> the values together and then doubling them up in the source and
> destination fields. The result is the hash value becomes predictable
> in that once you know the target you just have to offset the source
> and destination port/IP by the same amount so that they hash out to
> the same values, and as a result it would make DDoS attacks based on
> the RSS hash much easier.
> 
> Where I draw the line in this is if we start losing entropy without
> explicitly removing the value then it is part of the algo, whereas if
> it is something such as placement or us explicitly saying we don't
> want certain fields in there then it would be part of the input.
> Adding fields to the input should increase or at least maintain the
> entropy is my point of view.

Thanks for the detailed summary, that was helpful.

Though, if a vendor chooses to implement symmetric by sorting, we will
still have it as part of the algorithm, not input.

My main concern was about losing the ability to control symmetric per
flow-type, but I guess we can resolve that if the need arises.

