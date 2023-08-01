Return-Path: <netdev+bounces-23384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4B976BC2B
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 20:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD077281191
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 18:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D526F235B7;
	Tue,  1 Aug 2023 18:19:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D78200AC
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 18:19:41 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAC7213E
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 11:19:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ee+dDK5kyABgRqn/2NHQFjbA/fBr3rcs8VrILkNnzP97qtN8CIj8SnyYqoNsQ6rs+h8lwBgUhXhM1tOZnWCstkxgNNpisGRgAXp3nobePtL+CUunYQjDP7Sld7ngxL8qVPY+dNpIoQ/BPe4r0yAr1h0M40Y83AGM2GiqSigzUBZ46LHFqQYSW5JKgWnE7ssNDaw7sHmCFxqpr7hlP6nc5TQj0/IFyvmjftvt9tH9FPZlme3Z85OWTHvjz8ydZK3KSB3e5fvitVhzq7yugkosaj7pHxjO4lFjtAXP0BA+f9MwUgIzNzGonNc980L5tueCMBfse9RxklpjJ5JYoSvxkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RIpdBOoVpsA+KEz4Z8uQz9npBlglIv6wdPRX5w0TKE=;
 b=Cs8UwBiwK1pLErOX1k34iYgAvTJgPmElHk/l1Wa+ttENy1wqQVneQDb9v9UqsDalJwlFXFBAMBtnZWS8sHIJDsvV9PbGIYyqFtycccpESZLlpOlRqVkGrZTrtgSmo2SpWoonuykPPD7B8qHqVtAlsIPd7p4J+yJTN90wqoUPrkqmzvbq0JfEl1C/ugNKlGW02/ttbOOqJ9BcWMtkkPOQe0qSDrYWPLfpTACX8M03WhV52qhBqLXnrkQxdcyBQCVhkBvdBKYGfgryd76mrHvGkpdTCkq8G/SFcYxRtZgNpvCa5/M8ajc5jjxm1g07fg+K9i6IkLf486uKurPKsLQseQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RIpdBOoVpsA+KEz4Z8uQz9npBlglIv6wdPRX5w0TKE=;
 b=mhjC0hRWgV+wCxi9xZx+9o7ZVpvUtQli91q1ViyGQQX2G0Uq9Ba1BheX7lYIL2ykKrOJOMRtSrR10MZ7nwOuJl+Eme29fWU25yFVkBWQL1X37q62R3iGLS/T089NLQ8mOvpYWjMas7boszaf4Zwg9X3dIrLdm3p7xHjFBZifdfE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by DS7PR12MB8249.namprd12.prod.outlook.com (2603:10b6:8:ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Tue, 1 Aug
 2023 18:19:37 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::6872:1500:b609:f9cf]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::6872:1500:b609:f9cf%5]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 18:19:37 +0000
Message-ID: <a88ef5bd-a437-00ef-026a-dd971ed27209@amd.com>
Date: Tue, 1 Aug 2023 11:19:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net v2 0/2][pull request] igc: Enhance the tx-usecs
 coalesce setting implementation
Content-Language: en-US
To: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org
Cc: muhammad.husaini.zulkifli@intel.com, sasha.neftin@intel.com,
 horms@kernel.org
References: <20230801172742.3625719-1-anthony.l.nguyen@intel.com>
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20230801172742.3625719-1-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR17CA0062.namprd17.prod.outlook.com
 (2603:10b6:510:325::23) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|DS7PR12MB8249:EE_
X-MS-Office365-Filtering-Correlation-Id: e569bc58-615c-4680-0bae-08db92bbdd52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Xq7JOqpdptkPjV0HHj+odE4YqIjNRdESoRDkFClOU6Yz3BQZsCuBQNBKYZcztNFHTAs4NCFB3kLonVWRyWeNqcYOFodIjX4vrPgArZ3fOb1FWSkpwXgyJQH0bubLo1BzDVey4ScOK9KoJjyur/UGqaAMC5aOhvLjbb0z1jICzUVKeADQHWmNxeVAhKEJEF+XuXXP4c2Y//mbp8s0CqTFpiTg8cGzlaiV0B0OcKr0lItcDKEVoWdPnu2xdVfSq1ZG/cPxbq5DyhKil3ATj7gvZfYWpKiOJIlSnvr2VlxzH0/KNvxcFzGuVg9NDtHJsUJEPcTTILtn14UP6j+d4XZpw5xVRv7AfAKlO/TX7a7YYNjTFQk/ZQWMCFwzXezzEXsOv6t3JXvuxiwMSCjhj9fcvSvDQcWUCeBfx6PN32yTdyiSA1/9RvbWZ9rgLfV+80JMTBz4lsPYnxSCNRqnIbo+ppPxBC76k+TGe4h8+oAcOhuGlUiRuO7E/TD3XF2OeuxOOs4x3/TP6pQwcLpU/0mCP8hN+r3OYqSHTZY4cYckFnu9V6glmyo4T+5gAq6YtkE8Vh5w3w/bipQBry+rV0WuINDs+ZKviClwT376v39fp8YCwd8SiXLgZpMWrLfGQEImXkB76gYr0ZIux/9+P45Yag==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199021)(2616005)(5660300002)(8676002)(8936002)(6506007)(53546011)(26005)(83380400001)(316002)(186003)(4326008)(66556008)(66946007)(41300700001)(6666004)(6512007)(966005)(6486002)(66476007)(478600001)(36756003)(2906002)(38100700002)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGdXekpsZ2hyK1VCeFBzdzlaQVBRWjhHM2RCV2RxbHgwWUJzOWt1TVpwMW0x?=
 =?utf-8?B?WS9BKzB1cHV4NE81aC9kN1JTbGt5RXNvRG40NXBLTy83UjFPbTFhYlVYYzBp?=
 =?utf-8?B?eHBjaU5DQWIxVzhiR3d5eGpwcDdla0s3N0ZESnN5QmRYSUJwZWNWbkhxRElB?=
 =?utf-8?B?NGhVWjVKQ1NEQ3lWbzNwQzVtZThNV0J0eWtXOTRjNitxTEJqbG9yRndlRnVw?=
 =?utf-8?B?UmVTV0ZJQ2tXbW93Z0pSSFo1SDZUb3c3aTdiWXgzeExHaFVYWHRJRG9nZ2VZ?=
 =?utf-8?B?TWdQeTlvaUNPbHozdXJYSVpCVytieGdXbGF5R05OR1gzakdKVFNVTXdSNXk0?=
 =?utf-8?B?WDVjU1BVdG04cjVKamdSYWRza2FpazVpSmxqMDg0TmdLS1doOXMvbmdoVXRY?=
 =?utf-8?B?enNrMVhCY2t5Q2F4emEzM2JRbXZLYlVqZVY5YTYyOEFXbHZaY1FYVE4zN0NX?=
 =?utf-8?B?ZDVHZkFVRzFuYjdrQlRUVWlJSVRTeUNlS0dmNktMeHBJSUU5L0d5bE1pN2xE?=
 =?utf-8?B?QU0wWThXWFBOdHVsSis4TStLUUwza1p5eTFTc0k2S0VNczhwUGlzQmgrbzFz?=
 =?utf-8?B?c2dmZVZhMWtlK2pnUDhud1ZrMTBXcWp3c0Q3dC9TTlp1M2ZycEdjK0dUeEs4?=
 =?utf-8?B?L3N5cjIxc0l1VTNpYUhldTFDTTJ4RklQd3NZK0tuSk9iek41Ym5wMW5sQkdy?=
 =?utf-8?B?SlVtNENFK0FuMmhLeEJiZlRyakFwSVNwOGVpSjMxRkc4Q0EwNWNiV002TWtB?=
 =?utf-8?B?TE1JYVJkNDYwOFdJN2dvaGJSZHVLdXpvbGxtS2ZiclZ3alQ5RE8yYVZiVEhB?=
 =?utf-8?B?UmZ2NXRaaUFzWDRQY3kzM1RjR1VDaWY1OUsyL3Mxd2tDTUZBeUJ4ZHdVZDJN?=
 =?utf-8?B?Tmhlc2s2c3g4VUlXckl1N3U4eEovRVQrdmxPMXc0N1pENE5HTFNzaFo2OFdy?=
 =?utf-8?B?SEZtOEd0amYwc1pPSzMvYkpWOUlmTW5jZW9DeU5Ld05YMTU2bHFiRWQ4UDJ5?=
 =?utf-8?B?ckRDZnZRS0dqTWtjMzlqZ0hXbzg1RWVMSFZRRHhRajV2Z3E3SUFrWVVrd05Y?=
 =?utf-8?B?OTVwOXM3SzFzMjhLUWVSU0xOSG5wOTA0VUZkdXYwVjRuanBvdCtaWEdNQWZj?=
 =?utf-8?B?bUlnTUQvOXc5T0RvQUU1VERqZUNYNURlYUJPUGs4VnkvSWRtVWNZeE4zMzBa?=
 =?utf-8?B?SStKWlVQQ0RQREtwaCtNNVdMTituN0c0RXlJZURWRzJQb29HVndpbHZXZDNp?=
 =?utf-8?B?aVJyaksva1NDUXhjYXlxa3VXdHlnOCtvaGZ6UHdUTHVzS01GQTNVam00VmNL?=
 =?utf-8?B?a0dYVGNoWXVBQjJYM0JBNDhHWTJqeElHUFhWRmxyOFQzalFZdGpwVytrbnl2?=
 =?utf-8?B?UUNMODQrNFRYaE9uR01WZW5ZTVd2RFlmZWo3Vm1jcVVBTEF3YytvaTFXdTJI?=
 =?utf-8?B?ZmU2VllFaW9sK0Y3N0prSVBya2VJRmVONVMwb25Ib0FseGRXVDk3MmtNUGhO?=
 =?utf-8?B?TU5DZXpmNTVKN1c2OHJ5TGlBUVIzTlRDWVhnSFJYc2pEU2hwR05hR2hROHJV?=
 =?utf-8?B?Kzk5eGNwbFZHR3RjOEl6c2FHalhjUjFPNUxQQWhta203MC82YVh2cCtHaFps?=
 =?utf-8?B?R2U2NTJjZ0RkMWJkL1MzWHJ3YlFncWVXK1JOZEU0cmxzTTRoK1RUZ2Vlc3FK?=
 =?utf-8?B?QkRBWFE4c21hOVhUSGwzbVZ5dlRkUHdqWkZDbWNFMHN3dXloQVV0cVhRSFRX?=
 =?utf-8?B?MFhrK2hleGRkRFhGeXlhTEVXbnkvM0RDMy81dlFobDR3c2tXYWpUS3VqQm5S?=
 =?utf-8?B?N1lCZng5allEemxHNzRlaVE3VTZEd3ExN1VLRklyVDFoZFczYXlBK1VqZVBh?=
 =?utf-8?B?enp0RzFrSlJTR0syNHZadzY3UVFTY3lYVkdQMHdnUjE4QlJHMDVYQXkvQm1r?=
 =?utf-8?B?TG9WeXFGSFRlYmNxbVkwb1p0c2luc1hkR0lSN055VElDSmQrV1JWaUgraWhE?=
 =?utf-8?B?Y3dQZ0hLb3BWQWhoUUJ0R0Z0U1dlZ1ZETzdMTmtleU9TWmg1eUxtai9FbU1n?=
 =?utf-8?B?ZURpRlRFMEJxRmNZclBjbHNKZTkrMmRoNURyanVsczNXend3Ty81SmVGQzZS?=
 =?utf-8?Q?pLsqhT30c/3I/cQKkhP6D/u1B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e569bc58-615c-4680-0bae-08db92bbdd52
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 18:19:37.3487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HONzqA1VCoqVcIS3puOqodhe5En+DEtvmhimsh5GVOJFzJKlOMSKzXeKcMt69IJIO4kLGQUvhGizLb/pllYNLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8249
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/1/2023 10:27 AM, Tony Nguyen wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> Muhammad Husaini Zulkifli says:
> 
> The current tx-usecs coalesce setting implementation in the driver code is
> improved by this patch series. The implementation of the current driver code
> may have previously been a copy of the legacy code i210.
> 
> Patch 1:
> Allow the user to see the tx-usecs colease setting's current value when using

nit, s/colease/coalesce

> the ethtool command. The previous value was 0.
> 
> Patch 2:
> Give the user the ability to modify the tx-usecs colease setting's value.

nit, s/colease/coalesce

> Previously, it was restricted to rx-usecs.
> ---
> v2:
> - Refactor the code, as Simon suggested, to make it more readable.
> 
> v1: https://lore.kernel.org/netdev/20230728170954.2445592-1-anthony.l.nguyen@intel.com/
> 
> The following are changes since commit 13d2618b48f15966d1adfe1ff6a1985f5eef40ba:
>    bpf: sockmap: Remove preempt_disable in sock_map_sk_acquire
> and are available in the git repository at:
>    git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 1GbE
> 
> Muhammad Husaini Zulkifli (2):
>    igc: Expose tx-usecs coalesce setting to user
>    igc: Modify the tx-usecs coalesce setting
> 
>   drivers/net/ethernet/intel/igc/igc_ethtool.c | 62 +++++++++++++-------
>   1 file changed, 41 insertions(+), 21 deletions(-)
> 
> --
> 2.38.1
> 
> 

