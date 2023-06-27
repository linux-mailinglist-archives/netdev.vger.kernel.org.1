Return-Path: <netdev+bounces-14245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DF573FBED
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 14:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07F041C20B02
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 12:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A2817FE8;
	Tue, 27 Jun 2023 12:24:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BF21775D
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 12:24:21 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807271999
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 05:24:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3aVYZQxlPBX+7LYZakVrsQ6HF2ZeF5Xw51M+PX/Y39YsQeTZXC478aDJ7IxZLEgCpM9hDPUJcUU0mR6zRaHmmooI1Zno6neKWwWHhRYoMlS7KZxXcfrvYeWK3W3YCWDXFFuWcnux41s8dYLa4nKuqzVCHCvdXzF/O6dwY4bWSCmzIih3Y/vhOL8X3q6y/FXMoHY51mm2cYnmeOijZAPRqRIgR9UPpKg8/5N3gv3OInqkwy1cBSZBHfdcPLYg/LlUEBA8f+VuB3/Xzx6C2StjBB23XyrtTR4MScMqsj1/+G/ZFcmVv3PbiGB2VAaIlk11dRugaxc9/RKBvwbyPVuEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJ36TvJgBM8Id4QEDLmyoRjN7wfumnv7yGWLujzmM1k=;
 b=aipFgt8FtxTCc6+r5bJ58xdY/MaRD1VtYdF0Ldq//yvM8Goiy+pOc4dbukSisw0TF43hYKJrJTholurrc7szgNCaCKMXUVndsOuQj1MIcmlj5qvMhRKoZ7swwf9Wc6VKJRxfZMdIRWkS1wg7Hlqi5x4lVCQj6Xm0bFKYxbHpdFnissgbLKkchyGSrsPsf/UWsNCUnFzipeau6EB/hBDG6JGqiQ2jXdXlaEBQ8tuSCW6ElNgzhf01zEdLj2h4uamBPnEBMD2xruzXw2xCu/oO8AuRRWJRNqrxfPR5JGsRRUQumQ3okHQU62E3Z5YZYIt4RMo7AX43UNYB3+4b0MO6Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJ36TvJgBM8Id4QEDLmyoRjN7wfumnv7yGWLujzmM1k=;
 b=s+/tHKCNSvVAgFW9CsC+/xA3FgXqYTjx5FIYpjkb4VR5r+Cn/p9Mq0KCrY8P4/7yOdfSRktVSe5Y1tEjpndWht2ds1dnRF2ZXgwoUoe6nprEh9GeDAbhNIX6LIS6PLdgTPJqoZL42kXqb07goRtwjSJ2uaJqtQoyVLMubHps5ocPbiZTmP+loJzBEBp7EBcxAsJKVXBvLwOVzz2I6boM3wCfag2VctIRvz/YT4qxcdevxB5fgfP0TRb/1Dbar7fW0S+ozxBJI0griQrNLP3jf+oTxdypMcBn1+uwiB8IAgRnqJvRLxLEyb2dHpogNa2tCtjkfOjl0LJ5gGRmYgExqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) by
 CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.26; Tue, 27 Jun 2023 12:24:18 +0000
Received: from DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::12e5:730c:ea20:b402]) by DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::12e5:730c:ea20:b402%4]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 12:24:18 +0000
Message-ID: <7db2f8db-ee36-d510-c0f8-b4b680ea55a5@nvidia.com>
Date: Tue, 27 Jun 2023 15:24:10 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 net-next] Revert "af_unix: Call scm_recv() only after
 scm_set_cred()."
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 Konrad Dybcio <konradybcio@kernel.org>
References: <20230626205837.82086-1-kuniyu@amazon.com>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20230626205837.82086-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::28) To DS7PR12MB6288.namprd12.prod.outlook.com
 (2603:10b6:8:93::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6288:EE_|CH2PR12MB4087:EE_
X-MS-Office365-Filtering-Correlation-Id: 29365edc-fead-4d91-70e9-08db77096d63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5i3I6+CTdtYL/2WAXLUm+QmIuuI9p41u8/bS+BynnQVwxBK0Mu12e8ibVH25cCpT8C/OEHOL1f2siNpKfWys8AfQVbJB9XvJwsr1hMO5y60CefSEm40jjPFJELhMuuqCrGlRCiq4+37cEvVVAFrenyQYjMc8f4ITXqdAL7xw/22SrbX32LERrfK46CiyLpy6+ZO3HH/pucLpCQYSD2iNCRfP7KaBtkuQOJHQaPDuHLoHh2fS42xBI3mw57vFQYhf1T/mkcBjxBrETWC+Y6f1z2VJzIt7kBI/GtC1gyeHiULbioSoNARVwieZrPMIgksN2qNXml/R59+Vel2uN3NwvX8M3wxYoXZKkUkU5UU2VdhVE8e15lGWymQQU6F5aGynrzaLuLKXHZY+M6dQHPwIAeKR/7z3Au7xUbm/u2kiXs/rtPvrHxbszKk4t9AC0Hu411zbnLjsu62Xf+WplqUnMHdfLMjEwsioFzFKwKMw/NO2w3981W1XIqYA5oA8N4VqiZyMvm/GHc7ebcjMesSw0U9rg0eW20o8U3WyrmXWXsh5QEfPIZ4XFsy8b+SyZEDh/RKIL/xay2U2DsPFiLgiKrR8i9XPUmIMjkll8dZ8nq0gfkjN5xw67zNIcXYKEKe4bxpixqP0aKY7OIxADZkEaYCg8NVPXzFwMDGkeSLE3hkmfs9Ly54R47IN/y//993Q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6288.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199021)(31686004)(53546011)(36756003)(5660300002)(66476007)(41300700001)(8936002)(8676002)(66556008)(86362001)(316002)(38100700002)(31696002)(66946007)(4326008)(966005)(2906002)(26005)(6506007)(478600001)(186003)(4744005)(6512007)(2616005)(54906003)(110136005)(6486002)(83380400001)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXQ0dHJ3NFpLeVIyNDJSSU51Yzl6VTJoNjJLbVpCSUtVUzFYVlltS00rYWFT?=
 =?utf-8?B?QVBERm9Zb2dveFlLeks2UmZVRE5mOUVMQ0dOS0k2eDJYcmprbUNIaWlvRW4v?=
 =?utf-8?B?NW5qaVc2dXE3YzVjOFIwWitHY2U5bW1SVzRrbXB4OERjSFFEMUgvSDB4ZzB6?=
 =?utf-8?B?QjVTV1ArY25wZXVVTWs0UkEvYkZ5WWE2NlYxT3kwWjFYRnhZdEFqWExwNXlt?=
 =?utf-8?B?ME5FN2lEOXlGd3lENGl0ejNJTzNhY1RSZS9ubEJ1VSt1SHlZT0piQjh2WHQ2?=
 =?utf-8?B?WGZxdVoybm54NmcvKzZUdzhWWjJiZFRqVmhOcGwrQTEydzB4YTVVOUxvQVNY?=
 =?utf-8?B?TXFvZmNTVDc1RVgySkpmL2VFUUxsVHA5VDZva202Zk5vUjJhYk5HZDdaa0s5?=
 =?utf-8?B?YVpJQis3S0pCbCsrVGxpVTNZVk9QKzFhUEdmQzJ6d2NrUWlEaGFhdnpGWmtK?=
 =?utf-8?B?RFRuOGZIblRNcjVSaEFSaDZkai8zaThocVVmRVVqQlpLKzNoSEZHbG9DRWd1?=
 =?utf-8?B?U3E3UXlBTWpNb2pFRmE2dFlYYWlQL1JzQ1BEN2MwSWQ2Ry9GY01Dc0x1VkFP?=
 =?utf-8?B?VEJBd3ZQWDFhSVlPd3FiQjFPVnlTTXZ3bXMxWDFOdHpvRVB6WWh6NnliMDNL?=
 =?utf-8?B?Zm9ORlhpSndMbXFCVEg0cnpjWFJCODljZE9KRWJwWHpwZUdHQ1dRejY5V3M4?=
 =?utf-8?B?RE1LZFJLYU11RVQvV0ZvaUlZcVYyczNKbXUvc3FGamVROE4yUlRhR2hEWnBr?=
 =?utf-8?B?K0hPNkhNeWtoSHNDblZlVDAwUkF6WHNXM2lxRkR3eHQ2dzRlYnJteUcxbEF4?=
 =?utf-8?B?aDlMZ0lNNHBIc2diSTkyaFZTRUlZYWZNQ3JwZzNJaW5WbHdTTnFSOGVqTkMw?=
 =?utf-8?B?U0szVUxseVVqTE56bHo4QUhuTXlPTFc3UW1ORWhQZFg0a09EUzQyYWRlck8x?=
 =?utf-8?B?L3A5Z2YxWEZpeExxRG9KMXdIS2M3SG85a2FEN1hjSlFMQ0t4a0c2NnlRbnhN?=
 =?utf-8?B?eVptUzRUYSsyTlZ6dWdqTEJvQnJoNTdTZXEyYmRGMjByb1Z1WnVNZzdZenFz?=
 =?utf-8?B?b245cWFCZUljeUhuSDVIb1o5TnppS3NHT0oxMnVnRDJXcUFxUXIzLzNyYlhD?=
 =?utf-8?B?T2EvaE50RFhpekJPMVhwR21DTlpNUkQ3bUQ4bVpwZnMra2VFYzlhYXpUUGJV?=
 =?utf-8?B?WW5EcDUxc0o2dGNuOEU5KzNBTUVOWHZrb05jdzM2b3FZQlpMQUFrTEEyai82?=
 =?utf-8?B?U0Z1aXVBRFlWTFZwejVsVWhlUk9YZEpaWCtmWVcrbHFyeCtGTlpoakNkdDgz?=
 =?utf-8?B?a3RQcUhUVmhjRFdsdUJlOUFJZXNXL1pHb24xaGUxVUtGKyt0YVpwekwzQlhi?=
 =?utf-8?B?S0pYUFJDSmZIZnVNMkZ5YUQxdGpIeUh3RGJmdVJFdVV0c3hPRWd5OXlnNDdo?=
 =?utf-8?B?K2ZwWnJkVnRGZHJzZWhvYWhhemdZOFpJb0VtdVhXTEYwa1BaQmR1NkJIVUxa?=
 =?utf-8?B?T1dPMHpkQzlnYzd5bWxGRlFHQnB3dTVNRzB6Uy9QczA3YzNoYXlUWjkzbUMz?=
 =?utf-8?B?azZEUURMWSs3Q1FjWDFaMEdvMi9PNHltbnBhY3lFN29GZUpPNHBNSEkxM0RF?=
 =?utf-8?B?SDJDWEhTR3ExQVorNW13QlZ6MkRxUFY1TlpRcExKY2wzODZNM3MyMnl1L3M1?=
 =?utf-8?B?VEorL1YwK2lnZ2RxVGoxczhZaWR6eGRFVHc4czBZaFlYcyt4OTE2TmsvTDg4?=
 =?utf-8?B?cnlHT1FHZnRWNHVpTDR2Q29EU3k5V2JOdXB4SkNhN3lqV1NUQ3hzVW85VUdr?=
 =?utf-8?B?clBFdUU2VGJnQUlMenQ2SDBwdytNbnkyTXFmTldOczJhSldHb1dZenNta2Qv?=
 =?utf-8?B?Rm1LQjdUMFIrOU41KzVQSk5WTXB4MkJuM2krNlE4eXBXTStTZExDckxJWTBp?=
 =?utf-8?B?ZytneEVaUjk4cldWQ0ozcUovSmZsY2RRenlzNXVCaG5IZm1Nd3IvaklIZi8w?=
 =?utf-8?B?L3Y4TEIyQ1U2aXhGZTlSbEt6b1h0aTQvWHpzYzc3MS9jZ3piRVlZQjZTVkd0?=
 =?utf-8?B?aUJWbFBwQ2xzYzlTOGs2NFh2T3BJdmVwc29sVG04WEFpS2Fvd0dCQ2RQVlpQ?=
 =?utf-8?Q?N+E6L6hwnEDKAaeLFTxc+PIGT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29365edc-fead-4d91-70e9-08db77096d63
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6288.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 12:24:18.0819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 772kX52xIGwK3L3VdTmvtf5yDXrQMqgBckNSPtUAv5JFyOYodvroAEXc1sqnsouU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4087
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 26/06/2023 23:58, Kuniyuki Iwashima wrote:
> This reverts commit 3f5f118bb657f94641ea383c7c1b8c09a5d46ea2.
> 
> Konrad reported that desktop environment below cannot be reached after
> commit 3f5f118bb657 ("af_unix: Call scm_recv() only after scm_set_cred().")
> 
>   - postmarketOS (Alpine Linux w/ musl 1.2.4)
>   - busybox 1.36.1
>   - GNOME 44.1
>   - networkmanager 1.42.6
>   - openrc 0.47
> 
> Regarding to the warning of SO_PASSPIDFD, I'll post another patch to
> suppress it by skipping SCM_PIDFD if scm->pid == NULL in scm_pidfd_recv().
> 
> Reported-by: Konrad Dybcio <konradybcio@kernel.org>
> Link: https://lore.kernel.org/netdev/8c7f9abd-4f84-7296-2788-1e130d6304a0@kernel.org/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Encountered the same issue.

Tested-by: Gal Pressman <gal@nvidia.com>

