Return-Path: <netdev+bounces-59314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 790E981A60C
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 18:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 311EF285A51
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 17:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36ABC47790;
	Wed, 20 Dec 2023 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tU2u2bel"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70A847764
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 17:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CprnMbzaoQD0cESXMUhNmKouj522P5m2qxofpPh4JRPAuHw3ux2JUf/bhc/8qd4dah0+P0/DQ9+aEBAPtuZoe6tm7+ua3xRJN7D+ljpLF0Ddt7dC01xvYAMmssuvuqddNjxBw9MS2pEeLyo0s92dIYmhS09w3vblR63fQPyoiEahKw5XS/CIyxCLoshdtL2sJKy3mGpc3HEV2nqfG8loBVnw8c2ByeIdX6zGwGLsFYh6lZ6/V3J2iNGZZJ+thugSQ85/QfCkRiD+UkRKgvpetW45U6zCVZyTSWugKZXdOdAw8vNoPXXOLChTMCLkbimp552+4uyPB3/C5Phfo/yaTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqs/Q7Pk2GFNBdkzm3zkFnacNoKdX760a0mXRuP+L7M=;
 b=gGYHOrsJW6O5J7k9Q/cSi7zXqR0sx/qGAmLLUbqVJfZHvWRz2DHCtBbQtj3l4efvwYSq8aQfB5cF9UPM/jKqsjHKd++US+gPFWqWVETHE6TJnl//ptmAVc+Aw7f+LyA2G6aFU2/mBy/k3fwIfkQX5FAAVtvTPlCQsQvm7f8FbrmfG2nVOd3woTsiW1mCqDCzqEveRyX5AiJL1MWXvOQhpOe78yaEsBbB6LyL4KwaQNcYipilvxiHbZojTQIfdIhstaZT1MDuY0j5pwz/204jg9oLZ7CRD7wQoQkmOjpeSSx4ts3YzES/5c2QTSrbltDFbZuqX887wYQg7THcaSA5WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqs/Q7Pk2GFNBdkzm3zkFnacNoKdX760a0mXRuP+L7M=;
 b=tU2u2belv/9qCG0V2VjbgBZhU11Zc6JNxcuhA2D+aIEAdjMLimeGYUDkj4804mvG/hsmtz1/iiyP9SBWVhQodlYbEMzY446V8S3FKSJTTDJiRydFXTG3zY+rB5WAEugoRugYHNAQz/kgA1IXIsWTWf+b33GQeDI5l8k75o21iRM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by CY5PR12MB6105.namprd12.prod.outlook.com (2603:10b6:930:2a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 17:11:40 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bec4:77b3:e1d1:5615]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bec4:77b3:e1d1:5615%5]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 17:11:40 +0000
Message-ID: <28644ecc-24a1-8155-e6e8-c75a2bc64356@amd.com>
Date: Wed, 20 Dec 2023 09:11:38 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH iwl-next v3 2/2] ice: Implement 'flow-type ether' rules
To: "Plachno, Lukasz" <lukasz.plachno@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Jakub Buchocki <jakubx.buchocki@intel.com>,
 Mateusz Pacuszka <mateuszx.pacuszka@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20231214043449.15835-1-lukasz.plachno@intel.com>
 <20231214043449.15835-3-lukasz.plachno@intel.com>
 <693fb63e-8369-9cf7-4b41-7afc00b30618@amd.com>
 <bf21c58e-a857-4096-932a-cc9718ab9779@intel.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <bf21c58e-a857-4096-932a-cc9718ab9779@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:a03:217::16) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|CY5PR12MB6105:EE_
X-MS-Office365-Filtering-Correlation-Id: a1f3ea9e-7a1e-49d5-6f02-08dc017ebb58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vu4PXE4AXPmN1ulWpHWv+GyBo4TWzHKOIrxx3fdzqyKYOnb6pNqbnnjlMCH5kN0g6pAPKTlfkeBA1sznERN7qaoeXFIiaaYA0NrfvkJP/JiJNoOphl9QTUreUYB3VXhq7aj0H3VMbksCIbY+2SQvvwxKo9oAT2I0hMQ59fnAEqlJTSO+slBvqiuQ2lnCvIK+YKdP2YVERMNd3ohcfNU7N7bpLmWiRM1MMp+T2QsT56b16ghu9+7rgVE/qM8ewM+efNP5DZ83p5vFCWqg6RJ/p/v51ZcumGgonWFm5PTXFcZQTknUfNuPDpPdVmH4bOuzrSduL4QyyuZCnHjml0VQQc/9tXQh0UHQ5TCwA1SnDqUYUS8mRhTgEGyfEuwe/l1ge+qNDGx3E4aLzHWpccO133eTpj8ep5e/hL8iTAASLEJr94MHS3I/D0OJiJhbTln9mSxCPSwckA5bPC+/j2aQwr1LGw1oXlmGYzBVM20jPTwS26L1rj+DnDpN3xL1UIgYAkEHCLf6W4kuWG7rxCupQFAY4/FhYDKMZu+TDbvkNKRn/0FgTtiy2EZ68rKZEcG5Lqq1FVRo60ssT5rrPrKvgf1NJ/WFHQST45U8mkZweNp+4Pg8w9A7qaeVthnhVcnXJJTf5JQtl/aKc3wMY1y6HMpXxcvisq4YyzWfbrvc0ZhRprkMYgyGoJh5g5/qtpCF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(376002)(39860400002)(366004)(230273577357003)(230173577357003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(2906002)(5660300002)(31696002)(36756003)(41300700001)(38100700002)(478600001)(53546011)(6486002)(26005)(83380400001)(66556008)(66946007)(2616005)(66476007)(54906003)(316002)(6512007)(31686004)(6506007)(8676002)(8936002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alplN2JQZGVFSHBuTlAyVHNQNnpBeDJtWUN3ZHFCRDNtaGJ1VEwwck9nUzF4?=
 =?utf-8?B?d08ySW96RkdvdWREVisvWDgxZUYyMTl1NTVmVHR4OFhXOVY1Smw2dGJscXkz?=
 =?utf-8?B?bWhCMUlONHU0dE9hNEt4TDlLSWxRVUtxRHFQWk1BNzRJYUpTbWNXT0s5dDZT?=
 =?utf-8?B?RUEvK0tNL2tWMjd1cUQyOTB5Wkd4UkZ2OWdMa28vdlVWWG9qZnZYL3oyMHUv?=
 =?utf-8?B?Skl0aEk3OU51ZnExQnk2aXpRNGFvcVlSTTBtZEJzeGxPbndJRU1nTUEybW1o?=
 =?utf-8?B?WkRNbmxjTXNnZlY5R0Y0UFp6UzNEb3NUS1FnN3F0ME9kdlQyM1MyeWlFdjdW?=
 =?utf-8?B?MXZER3VHTGxyMEtpMHhHa3lvVUo1Z2FEZjU0a1A3N3grUlRVV0UzUFhFNzR4?=
 =?utf-8?B?YVFITkRtUURPb2pRL2F6NWtuRU16Z2tCL2t1NEJaR0lIdlhhSm4rUHRjempr?=
 =?utf-8?B?R0NpTWhyMHgwdW5PSStsWEY5WGhsdnBIQXY0ckpXTEo5NkIrVmM2UFJ0SVNn?=
 =?utf-8?B?MUd0dm1wSUpBNHByS21BL2FFbkNoWEREbEJXdmVEUHN1Q0hkTS9vUWY5Vjd2?=
 =?utf-8?B?RVlNR0xTdFpsUjBTcWdLcXhHZmdaNTUvcUZTV1ZLckEwWFhGdU1DVTIydmhL?=
 =?utf-8?B?bmVGZyt4NHdBZGxjaTJJZmMxNDdBWEs0VFZkRGkvNyt5WUdTdWZwbzFBM3dj?=
 =?utf-8?B?elh6NWNaNE5PbFlla2RIWTRmMHRrUGZKRzEvWWNYMElreEQxb2dxZXFiVFZv?=
 =?utf-8?B?QjJpeW5aNlFiUm0rVFA2ek9jZ1BRelAwYktxdnFCWUN3VytXTldXd1pFdm02?=
 =?utf-8?B?UlB0T2Z1eGxwSU5Xd2p3OERQSGRkUERmTXpjTXZEc2ZNZVJBVjlpS3RzTFRu?=
 =?utf-8?B?NVJudU90VW53a2JVUW9DUTQxcGt3UzFNcXVqQmFoR2xSdHdiSUJoMlZPZHFW?=
 =?utf-8?B?NnVqZDhHV0tjVVlIY3RPVGVoSVVIQ0FwelljcHJkejZNMFpmSWl2b1pkZkJX?=
 =?utf-8?B?L3BySnV5UzZHNTUvZzNneW4yWUdLYVA2VzcyUlRqZTg4N2k5d2RNZE9qRWlM?=
 =?utf-8?B?anEyV3pWVU5COEhPTXNTTHRhL0ttaVJVMmd0ekZnS2ozSnJJTzRFZXdDaEpj?=
 =?utf-8?B?OUVpSnlyY1ZwUllUYm9PQ3dEYml3dVVHYVdIUWpoMjV5UUlMSnAxcG55Mlgr?=
 =?utf-8?B?bkhiRlZVYm1tK1lQdlNrVldtMUMrNzZSUkM5Q25BWTdyMHNnSlVsMW5hYVZI?=
 =?utf-8?B?ZG43ZFNZck92MkRmbDNGWkczSjF4SHh5L1d0OWkvYmNOUzJ1bEN0VWlrV2sx?=
 =?utf-8?B?MlQxSzZHSk9ZaktuNmxRdUJ5OVArVnJNNEJBZk1PUmFYOEhSQmZzUDhyOXQ5?=
 =?utf-8?B?alRwTGFGM0ltNnNYSkQ1NG5oeUQwRVRmYnJGamVXL1oxeDdhb3JRRkc5ckE3?=
 =?utf-8?B?TkpkdFN1aStXWnVScGdueFNNaFBRODFWNUtRWEtGU0lsN0RDaFhsYW9RT1Ay?=
 =?utf-8?B?YVBIN1k0cmo4VkQ1dmRwdit0a2JMWnQxejFpU3pyOFRqR2tMM0JWVkx0YVRs?=
 =?utf-8?B?Qmt3dHlId21CV0pnRkR2Mm9qdzhvbEt5eDRUM3JKR2N2cDBhUTF0SWYyM0VV?=
 =?utf-8?B?UnNTdTdRZyt1VjExNVlodmJjQmRNNERPME16U1k2NHh1bEVpRFFLbUhNTWFH?=
 =?utf-8?B?L3VkSjZjODExSFlieHozRTdnT2pILzZ4NWFpaExSMDI0UkdvOFJ5S25Jclhw?=
 =?utf-8?B?RW5FQnQ4RjhVeVA5S01oS3ZLT3oxckt5RkhqU2xZM3ZXdURxMU8rUFpWVG1q?=
 =?utf-8?B?SkRSVndqQlpCMlVORHBneUxzclNNdjRrTFQwamhPZ2VaYVVoQXA2ZXBGMWpu?=
 =?utf-8?B?eTFzQlVVdXp5NDVwelJLb3JaYjljL0JRZmFGeHM0QXp6VEt1RzRWTTNEd1FZ?=
 =?utf-8?B?U0lFVXQ2dDhQaGlQZ1IrRk1WQVh6WTR5M3BweFQycFZEMEhLM1ZJVk9GVjRn?=
 =?utf-8?B?ZXI4ZFBPSmhFL0pIbXJmSVFUWWpoSVlRdWZ5OVRxZGZ3RXlYSVpqVkF4aGY0?=
 =?utf-8?B?SmZyMkU4OXBnMGd1bVlBenJyd3dkc2lud3NlSUhOMTl1Q1NNMGtqbEN1Z2tk?=
 =?utf-8?Q?+kUz2nSuH4U4IpzQCFFyMtrzJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f3ea9e-7a1e-49d5-6f02-08dc017ebb58
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 17:11:40.2011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: emLU+LmC5cnC6PU6juWbJwB6P06iZ/nrBRqVh7eE4ll3MZajkTXJ2O4KNRgMgPfjhO21Ku9VvhAAr7EBtaeFqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6105

On 12/20/2023 6:19 AM, Plachno, Lukasz wrote:
> Caution: This message originated from an External Source. Use proper 
> caution when opening attachments, clicking links, or responding.
> 
> 
> On 12/19/2023 6:35 PM, Brett Creeley wrote:
>>
>>
>> On 12/13/2023 8:34 PM, Lukasz Plachno wrote:
>>> Caution: This message originated from an External Source. Use proper
>>> caution when opening attachments, clicking links, or responding.
>>>
>>>
>>> From: Jakub Buchocki <jakubx.buchocki@intel.com>
>>>
>>> Add support for 'flow-type ether' Flow Director rules via ethtool.
>>>
>>> Rules not containing masks are processed by the Flow Director,
>>> and support the following set of input parameters in all combinations:
>>> src, dst, proto, vlan-etype, vlan, action.
>>>
>>> It is possible to specify address mask in ethtool parameters but only
>>> 00:00:00:00:00 and FF:FF:FF:FF:FF are valid.
>>> The same applies to proto, vlan-etype and vlan masks:
>>> only 0x0000 and 0xffff masks are valid.
>>
>> Would it be useful to have user facing error messages for invalid masks
>> stating what the valid masks are?
>>
> 
> Do you think about something like:
> dev_warn("Driver only supports masks 00:00:00:00:00:00 and
> FF:FF:FF:FF:FF:FF"),
> or there is a way to pass custom message to ethtool to print it to user?

Using a dev_err()/dev_warn() was more along the lines of what I was 
thinking.

Brett
> 
>>>
>>> Signed-off-by: Jakub Buchocki <jakubx.buchocki@intel.com>
>>> Co-developed-by: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
>>> Signed-off-by: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
>>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>> Signed-off-by: Lukasz Plachno <lukasz.plachno@intel.com>
>>> ---
>>>   .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 128 +++++++++++++++++-
>>>   drivers/net/ethernet/intel/ice/ice_fdir.c     |  27 ++++
>>>   drivers/net/ethernet/intel/ice/ice_fdir.h     |  11 ++
>>>   drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
>>>   4 files changed, 166 insertions(+), 1 deletion(-)
>>>
>>
>> [...]

