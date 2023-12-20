Return-Path: <netdev+bounces-59215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4044A819E18
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 12:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 646F81C25ABA
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 11:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583CD2137B;
	Wed, 20 Dec 2023 11:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AB+I3o26"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ED324213
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 11:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExwadmgaHdXN1x/n93uJQ+sNocRA6qQwVV7+CdSVn7HZ3PqITlFqu0hBHeblIoK+NAeHnE8azKIV1ZllFkHQEqOz2Ld7OXgR+rTX1iEZsN2oT5WygU+gqs0zk7hrl4gmYIemzQXAXA3W6A0tcDFqmNsBF4PTlgy59/9MMVt1og4ne7lu9fwrSqfEotCcW+rvzfC9pvZs7hcxVoFwgfNQBlsmcc9G2H8D6UPMtJyIcky090riQmE/d3vbFZf1qqWsbQW339jhWjjD2VDWnx2M+ohSCm+PMCWPpAqSjUe6oL4O7X0sFU6FuDlu4IC9xP9GcV1huPgw9bsZ8GuyjZ4isw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWKG/Dy3hz4p40Yc4mnuQtDMHh9Lqf4v7Jv0ev+nB0A=;
 b=cDD+sBdDHSifEzsXbhv2ebUUBQBqwb8+C9qifNgkTNPMWW+Pn7vxaXAcU26aVxPmS9SA3lBatTF711K+6kQr965QmYGCvfk+TL1z9aIPDyULwpn0UjaChK6txOxInKzZqVdn67Wtng/u8zS3ZrLgYNpAIEKl9HlqQ8ARZ3m1bZLqWGktFrR9+BJvRtXHu5U/4sbMNSNq1S5XUdV1hSUaFIKOpYRga21VMrhQTM2EFEsRMTeh8XUkJvvMJu3R+DVR33+L1l4zFIFXjzYuJh31mQCtnojfx3jvCjZ3QPJd3IOO+8SWLn54ur4k2ijkpeEn62irXQxvayJI1wz9/99+dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWKG/Dy3hz4p40Yc4mnuQtDMHh9Lqf4v7Jv0ev+nB0A=;
 b=AB+I3o26v3xWl0mJTzvX3ZuGihoodQvME7OuuADg3oDqQxLAP2/bFZMuucjp6YiM9zPU6frtJ8FP0P/9Knl41/GJrF/SR7x/B3kavk+mSAoHrksiuDXJpBak3cbYjZMcwc6c3LIEkKtdFlB4BlaZ9sXuZf8Xs9NWc+yu/QVAH6jP0SsuaTBoX9zauwT1rRHL2kc5riTGI4uO4sgJt8bzA89ru+yyALjiywi0uc7miy4n3waS+J1yNy74YctwKhB+6LvryWlmV2HjlyOI8w/jm2Q7G785VnKIgugscqmyE0V/PYbjEehGTzhW9PmwH7PpTRfAJ1F4mKTwjMYMNyxBPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by PH0PR12MB7888.namprd12.prod.outlook.com (2603:10b6:510:28b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Wed, 20 Dec
 2023 11:30:34 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504%4]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 11:30:34 +0000
Message-ID: <c42aabf5-45bc-4ce4-acbf-82f544ce8dc9@nvidia.com>
Date: Wed, 20 Dec 2023 13:30:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 05/20] nvme-tcp: Add DDP offload control path
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
 axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, brauner@kernel.org
References: <20231214132623.119227-1-aaptel@nvidia.com>
 <20231214132623.119227-6-aaptel@nvidia.com>
 <51446197-3791-dc89-5772-1496b768cd4d@nvidia.com>
 <2535y0vi8lt.fsf@nvidia.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <2535y0vi8lt.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0334.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::34) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|PH0PR12MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: 56e3a663-75ed-49c4-8d73-08dc014f14bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3BhabJlD+1MsapZKNAAE7Vh7s62C7xo+3FXt3Dej3r7pMuoiYnGnAg2FFuUyxvSV0J8lR8IuIP7tceGaSrOfFHg+ajOnM5Du94E6trN1YBLeMAvdx3D5kJM19zexy/qtHJ6VJwfr8knP1STM5cWjSwlqOB4UOpuEq7A1UkP+G/inGbfeiBbfbjQR/7LzkgUN2eplfiacdSpw4jSjwRHby+OiH069WhiapSsRmx2VF3Q5dERg+QuccDo3Iyi9XLKbIVtxVCL/8HC0bHnRWQzZtvAR7JpMb5H0zZ90rasqwGyeukdkR6+L5cF0cLMkRocjzHvNdEjQIPtBLPtmNe45sv0MRFxy3cgiEmdzqWBbM3SPYYPjv8H7vN3C5IEVPpDPTd6cjKgFp+/edSS24idLGR89nLPGxtXLcatDKevzqGWVRLoDRYLa8xuw2TMWVAVCmxhIRo+W42prt2OnDhLG1YNuh0IKYFrnRsD6+8jgFKUDN2J57V7mCPToZC6gVmen3KtiPowPwC8p/pQ4bs3kyD/aelLcakU7hWpkU/1TcQ5vdpsZ9pt6d9uw8j8xXWGwcncDLYdxQ8R7Y4PkDsHon1+8gffkXmWDqThwex8vFSoAMGihddyoQAkAESVeMG2+uGEoC9YCoo1tf2OMhSbwYVeSmjgOP5LfnPnNXVz4Wlc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(6512007)(53546011)(6506007)(26005)(36756003)(2906002)(83380400001)(921008)(5660300002)(7416002)(2616005)(66946007)(66476007)(316002)(66556008)(8936002)(6486002)(478600001)(41300700001)(31686004)(38100700002)(6666004)(8676002)(86362001)(4326008)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NytySSs2S1J3bTFVMDBLUm1QSzV4LzNSUU8yUDMvR2VhUTd6SVlHWGtSeW8r?=
 =?utf-8?B?aDRtS2hlSVpVaC9SYWlnSnQxZHZFOXdlejlFbjdjMEEycFlhaFZkNElQWjFD?=
 =?utf-8?B?eFVWcFpRL0YwNWt4TjJpRXhwOVVnbnQ5WDBYRU5SYVp2d0ZLSG5KNlZnc0lP?=
 =?utf-8?B?dERoRmZNRWkxSUs4d1ZsemlXVmthdnRISWVVc0Q1OCtiMUZieEZHclU1cUdL?=
 =?utf-8?B?MUM3TC9oOENXem9WYXJvT3RiNDEzTWUyV3hIL21GdGJ0LzBQVThyMnBaRjFZ?=
 =?utf-8?B?bjlnd0R5RkJmMHVQM1oyTlArUDlvQUVSYVE0MUVIeUViNVhoN0owajlibFdt?=
 =?utf-8?B?Z0Z3RklzcmFSNWY4UWxmWkxYWDRxVitYcXh2NUM1L0NydFlJSlVLcUM3UlBt?=
 =?utf-8?B?RXljSWYyRnlpcTRLN3dRUDNpNTEyc2FreXZNRU9sK2U1akRxdW13a1MxdXBO?=
 =?utf-8?B?TVo0ZC9uS3ZOOHM1WWFDOWlpRjlnWUlwdEhNa1BoNE5oWWRiVFZ2ZnBIOXMy?=
 =?utf-8?B?Sm9sT3hHT25QVmlmaEcrS2k4TlErYjhRbzladG42QmJ3Q3ZZZ29PNjBHNGl3?=
 =?utf-8?B?Y0krcjZIOUtYVmMrVXVlTDl6SGV0K3ladzJCYkU4WkFmUWdRZ21lcXl4bE1q?=
 =?utf-8?B?Skp2TkxLMWpvU0p4V0dOd09MOWtzUS81OVQ4L3BkMm4xUDFUSlVtbDlGR2d2?=
 =?utf-8?B?dVB1dEdmUzBoaDdPUGRrSGQzK00zR2ZoMlhRcCtTVkV0T3RaVFAyazlTY0VL?=
 =?utf-8?B?LzdidHErVmU5MDZxUVFKakJRNTRhMVhBTmlnakNvU2tlLzdTRmt1K3hzWjB0?=
 =?utf-8?B?OFppMmVkbjZ0TlZvaXl1bmpEcDhvcWExUzJDRG83VWN2SU9KaDJ5NlEwUHZI?=
 =?utf-8?B?YmlvaVU3TWlnT0RjYUNRY0pHaG1lUzVFWWJOeWRhTjJwMjF0ckxLZDdicW1P?=
 =?utf-8?B?bmNBQlJpaWlVKzRDMWdwTFdMVWlpa3BQSnluUkI2eG51M3VsNDROSERMaDNC?=
 =?utf-8?B?eXBLNnVjbCtWWWNYNWtwdGhiWkJYOHpQWURzY3pTUC9Ka3BlNnVCd1oyc0pS?=
 =?utf-8?B?cUpHdFJ0c1JHZEVSTEQ5N1JtMTBiZ3lrRjNBcWNhL2IyL1V4aDl5OElOME4x?=
 =?utf-8?B?cVNOQWVaT21SdzFQYVRXQkVjYlA4REsvdW9nMHhnUGszdlJYZE9qb243YWE5?=
 =?utf-8?B?dnpTdlVycHFUWmk0REtiYnBBT1lKUTB5S0p4VTMyZTFjbjA4Zmd6T3lkWVNM?=
 =?utf-8?B?RCtKN05WMktpdUVQZXJ2ZjdBbVNoZlFBUVJOUmhZdDhwS2d0OXRDVWJSNTlQ?=
 =?utf-8?B?TS9vN2pUcHdBdDlUNkc2UDhEWUJpRWFVWHhGaEV2b3BDM2doaHhiZkQyVndO?=
 =?utf-8?B?TGlFa05LTHNLZjREbzdNOE82aGdJb0JSYStxVDBhckQ1SFF1RWw1TlZYTERB?=
 =?utf-8?B?WkZHbGVMRmFEYW5XZjZNMVBNUk9KL0hCM2JzcFdTZHVvOWVWZllScFVHUGJk?=
 =?utf-8?B?U2tOSXNjcXF2UmdOZk8rNk0zQmcrWDVlRjFBWGpiWUgyK1Zld2ZyQXNKT3JQ?=
 =?utf-8?B?UUVwSHlZcEtCRGtQb01qUllNRXQ1YmZpYlNyNWpQck0xTXQzUXNyNStqYjcz?=
 =?utf-8?B?ZjBORVloRk9SSDBlcjluNng4cHBQOUk5clBCOFFJcldhQXRzclI0Wlh6UUFN?=
 =?utf-8?B?WDUrRXBBVjk2L1NRU3phK0pBOW5ITkltUnVMQVAxcGMvdXI5eUNxK2wyM0lS?=
 =?utf-8?B?cnY0ZEN3ZGI5ME1rbUpMQUs1RWxjVG1rTXpHSXcxWjIxaGt6UWlSUnFTdi9L?=
 =?utf-8?B?ZlV4Nkd3SHBTb09CSjZFTVBZRW9zaUczZ3JmVU1VVFk3TW5QNkoxaWppdVBB?=
 =?utf-8?B?SU5NbjFQTTJlbkdlQlpMOXYyeFhGWW16bjhnTDRWOGtqQWFJc0x2MTdWUTR2?=
 =?utf-8?B?Ulc2UzF3L1BlRVAzY0FleituZU11WGtUaW1ROVdEcHN6eVY2UEhhN1dmY2lX?=
 =?utf-8?B?SzJ0djRJajkxRlVOSm5GbnhvYkxaeXp0K3QzdjN1VmQ2Wm1UN2Y3WEFXM05M?=
 =?utf-8?B?MXVhWnJ5eHN0SEt0WGx1cGFtTGRYRlE1djkxclQ2MGRReThrQWJ3RDZRUmtO?=
 =?utf-8?B?VjJ3b0tkeno0NXJrc2hCNGkrS0htZk0yYXg1dE1JT1NZOCtvSmFWbWlTQmNm?=
 =?utf-8?B?Y0E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e3a663-75ed-49c4-8d73-08dc014f14bd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 11:30:34.4533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXXeBaKlnvuBXf96pwrno+FUKpK1ioUlFrVwzxOYudwnEmsfBZAqWZsxQOgjS5rKMcXxOwhd5HILTAPHLD4nMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7888



On 18/12/2023 22:00, Aurelien Aptel wrote:
> Max Gurtovoy <mgurtovoy@nvidia.com> writes:
>>> @@ -739,6 +937,9 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>>>    	size_t rcv_len = min_t(size_t, *len, queue->pdu_remaining);
>>>    	int ret;
>>>    
>>> +	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
>>> +		nvme_tcp_resync_response(queue, skb, *offset);
>>
>> lets try to optimize the fast path with:
>>
>> if (IS_ENABLED(CONFIG_ULP_DDP) && test_bit(NVME_TCP_Q_OFF_DDP,
>> &queue->flags))
>>       nvme_tcp_resync_response(queue, skb, *offset);
>>
> 
> For this one, when ULP_DDP is disabled, I do see 1 extra mov instruction
> but no branching... I think it's negligible personally.
> 
> $ gdb drivers/nvme/host/nvme-tcp.ko
> (gdb) disass /s nvme_tcp_recv_skb
> ...
> 1088    static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
> 1089                    unsigned int *offset, size_t *len)
> 1090    {
> 1091            struct nvme_tcp_hdr *hdr;
> 1092            char *pdu = queue->pdu;
>     0x00000000000046a6 <+118>:   mov    %rsi,-0x70(%rbp)
> 
> 880             return  (queue->pdu_remaining) ? NVME_TCP_RECV_PDU :
>     0x00000000000046aa <+122>:   test   %ebx,%ebx
>     0x00000000000046ac <+124>:   je     0x4975 <nvme_tcp_recv_skb+837>
> 
> 1093            size_t rcv_len = min_t(size_t, *len, queue->pdu_remaining);
>     0x00000000000046b2 <+130>:   cmp    %r14,%rbx
> 
> 1100                    &pdu[queue->pdu_offset], rcv_len);
>     0x00000000000046b5 <+133>:   movslq 0x19c(%r12),%rdx
> 
> 1099            ret = skb_copy_bits(skb, *offset,
>     0x00000000000046bd <+141>:   mov    -0x58(%rbp),%rdi
> 
> 1093            size_t rcv_len = min_t(size_t, *len, queue->pdu_remaining);
>     0x00000000000046c1 <+145>:   cmova  %r14,%rbx
> 
> ./arch/x86/include/asm/bitops.h:
> 205             return ((1UL << (nr & (BITS_PER_LONG-1)))
>     0x00000000000046c5 <+149>:   mov    0x1d8(%r12),%rax
> 
> Extra mov of queue->flags offset here ^^^^^^^^
> 
>    (gdb) p &((struct nvme_tcp_queue *)0)->flags
>    $1 = (unsigned long *) 0x1d8

Ok we can keep it as is.

Sagi,
any comments on the NVMf patches or on others before we send next version ?
we would like to make it merge for the 6_8 window..

