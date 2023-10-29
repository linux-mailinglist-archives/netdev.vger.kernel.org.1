Return-Path: <netdev+bounces-45073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D25EC7DAC53
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 13:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90B52281633
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 12:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAAEC8D2;
	Sun, 29 Oct 2023 12:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CJGBZmmp"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09D5B675
	for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 12:02:05 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79947BD
	for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 05:02:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hx6SoBoZiLIB9xU/eh6t+a92vmhTEXu7mEzBbDnGcYzWx+1BqKLBK+PQIvRqCXAEWClGk4pAf8agaFlWyj24hk5AD+rFrZCSu3fB0GUN26Xds3U2ymHgD58YebwzxrNxbqc/d2S2O9oyJde+iztxYQYoZTBRHKO2Ww5Ajnn+f0CmDS/ObrOH7Sta+rn6B0S/OVGfBIHoHHbXbYuUL6YurF5ZG5Y3Khh+OcVCRS8CITSmTbIQ2V4oAQB8lSQMMYdiaONT3lArDuGyNw6Ie8ZiYjKFe3dzCqA6CFNIYDxeE9hwdERtAIlLNJpKxwhLkfXeAPVpbTBKsxi8UfxVzCgzWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABAYtsPGOOFBQGLjkNDa8KeKd8LWlFlfGZhlyZUNCpM=;
 b=JmQ1ff/75/GbjIeLvtDbjmnD+6hAqlSpk8zbCX/6rqzeKv3O1lHi1g/UgdoHXoTs52LJvDMrIC/JdvHgaKn6xthw4kAHPOASHrsI9M1VWHAsIFP9TzZcBXryKjWIYohVvrDZob9ALIqRwjiYRUk1EEOQznChqFufmDsEbhpO6cKCdOPQf8oxiSjCPBnBQ287QNfDtBkLHF4thZoAbLW6q9Dxx69C8oAq1okTOMVFhlRYs0MlQkF/mdn5nvkrB/oGcRMCHpt23LI+DEi8z7UnwPdNdUZHemL7aADDrV/pe68ZyHc3L2GmR6gMrdHVl/MVcsI7xB2aRov6l2ytRqcyxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABAYtsPGOOFBQGLjkNDa8KeKd8LWlFlfGZhlyZUNCpM=;
 b=CJGBZmmpb4Tvm12LxE4wD92conyfg+Kf5gxj3Ffh+5slJDrwM1SJhafOv1Vn7sd798tHfeY/XdopjFWiF95+daGHtf9SB0yehQ+UJb0SiTUu8KMIPXSxioljbFgsfjq9v6zdAdApZX6MC/+ebLNclKM6yE23JBJq8eWjmCNI0BC9A6oQA5S1IbpWfSGqA/qZ1XrZl8krNgMXLvLO/8KX9Q11UQ+wv+Ohw9v/loEkSMuwKtrCZTgznH3PFDgXxtI0X1ogh9vdgljVNxQzDPIZBw3GguJEAMnj2OyTbOGISdNh70zZtn1+IjlBoOEvJBKSyUeteafPmyWaElDszQK3MA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) by
 PH7PR12MB7870.namprd12.prod.outlook.com (2603:10b6:510:27b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Sun, 29 Oct
 2023 12:02:01 +0000
Received: from DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::8cde:e637:db89:eae6]) by DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::8cde:e637:db89:eae6%5]) with mapi id 15.20.6933.025; Sun, 29 Oct 2023
 12:02:01 +0000
Message-ID: <0190647d-4458-4626-8160-d235a6afa149@nvidia.com>
Date: Sun, 29 Oct 2023 14:01:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: sched: fix warn on htb offloaded class creation
To: Maxim Mikityanskiy <maxtram95@gmail.com>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>
References: <ff51f20f596b01c6d12633e984881be555660ede.1698334391.git.pabeni@redhat.com>
 <ZTvBoQHfu23ynWf-@mail.gmail.com>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <ZTvBoQHfu23ynWf-@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0325.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::6) To DS7PR12MB6288.namprd12.prod.outlook.com
 (2603:10b6:8:93::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6288:EE_|PH7PR12MB7870:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e8d417f-a285-4434-16dc-08dbd876dc2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NlVPC2RcEFLQ7T1AT6ZezVNZriiGtuCf45qtyA8YhbuiU3KAy5YhTKBu/2fm5KntoJ3o2mPwsCAbYwmKhBTrDn6K+2rGgtjQeCHW9j7/ybmNlnPHTBXMQaTiOes1XNIOQ/H2VkJFpmy4nqOHwjZGi2xQuPsZ/HM6+eYpNknKOfllhLXPKkmB1QAqtu5LdDPTMxnaKbLNH1e9R8KD9TJRvWkyMtM1m3H6wEmmsEDot9l9gw19c0OOphGQ5KyHyiHuBcypPNzISSGZDrQToRLtAILyWpW2JIlROAQ1Q4EdgSgcAdN1gj22SO7XB7EJ4pkuyZetSNnn2OsyC1zwACHYXY1Y+TB4M0byDvw5zIoE32Rxq6GVoqVkDN+h9XCmheh0lU+GXUF20y0hcxdizN+o/GSlaglAirq3SVtuDLbleVfyGJFhTMxJCop0qutiGPg6jptKK6f8P4LsBb4WOou/tpzBsxq+L+hOT2fUrWcqhKIyjjap8biUBPE/N/UeyuhWLiuzDC5pDrX3gD9T9ljd3CM/Tf66dZ5WnJBwBRshu7UGlkrr28yA1/lSY3MFKgRG2JcWL9g7PUo4erX4ggOYfgQLOI5WvxBB7bX+IKCaLXBMVf66xsE2I5k/0MyectRIqThehkZxmQrORtDI+4+DR+CAQbynmnrItemajFntnP7JXMy1dL0dzJU1QYgu6AXP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6288.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(376002)(39860400002)(366004)(230173577357003)(230922051799003)(230273577357003)(1800799009)(186009)(64100799003)(451199024)(2906002)(316002)(54906003)(66476007)(66556008)(38100700002)(6666004)(53546011)(110136005)(6506007)(478600001)(6486002)(83380400001)(66946007)(2616005)(26005)(6512007)(107886003)(5660300002)(41300700001)(4744005)(4326008)(86362001)(8676002)(8936002)(31696002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVVvOFcxRVZPSU9ZbzdLNjNVMFBJRDEzRW9jR24rN2ZURlJBRkdmV0RzWGhR?=
 =?utf-8?B?WkJReHpuSzZyTi92M3NDaDNiOXlTYTI5bHVNOVhGWitSWkhJZGtlbVZuTmkz?=
 =?utf-8?B?K2czaTlRaHdoV2N4WHNUQnQyelZ4QmlhQVNmUUJxdVhlNXlvZjIydWdueXp0?=
 =?utf-8?B?dmV0bElTdWM5MWhnRllmWFVGbTdIU2ZRL3VSR3YyZ1QyYkVnM3V2ZEltZ0dt?=
 =?utf-8?B?b1RTQTBnd3oxTkU0eHVPOW9Qd2hqbVQ2OXY1V0FaOUMzaVpUOGZnUmkvTldI?=
 =?utf-8?B?ZG9uMGdwK2Ird2t5OTFEcTRteGQ1UXN3Yjd0RVJGdFlyRTJFU1JwM3JnVXpz?=
 =?utf-8?B?UjFrYzhOMHJvUFZMRkptVFNKWDVqbHBHaXcwTElhMC9WZDVIOWRBM2VMTWUr?=
 =?utf-8?B?SThlVUsrMkR4VFF5Q1Jja2tObnNZZWdiYlorZ040bHU0NXl6NWdNdWxjSExt?=
 =?utf-8?B?dUFzOVZ1eUxMVWtJdHhkZS9tOXRtSWVJcGZqZUY2SndVSUNVMEU1bHZibHph?=
 =?utf-8?B?RENOaS8yUlRLN1pUTWgvamdqWDdqcW56TnAwaS9OMFRkMVJJcGg5SkJhOTlK?=
 =?utf-8?B?SFZvMnVYOUJ1WXRKZUhHVEkySGptWTNveWhUVHFidU0vOU12R3Zid3U5U1Jt?=
 =?utf-8?B?NE15cU4rQngrbXFuU012bW5PS0IxTGVWbU15ZnpYTVlrbDZsT2ZtVjFuQkpt?=
 =?utf-8?B?RStCOGk5eGdybjVQOWZWSFBuNEV3VGJwQmFrNVhXcEovaE1sZ244TmdQd2hR?=
 =?utf-8?B?bzh2eWovZ1d1cUduOGN3Yi9TaDFIWW00cFFNVU9yTkRiQWg0VlVZazFkSmJG?=
 =?utf-8?B?T1poenRCOHFxY0wzZUVMQ3VYMXRDeS9XM1loQXJpWk0va2dLdU5hYmdTWmxT?=
 =?utf-8?B?TWZGVDVqSGluWS9wNUJwTjZqZmpDTnRVTmNmUTVTMEh4NnVJTjJQZHJmdlR5?=
 =?utf-8?B?SkJtbjMxRDNodXI0TERPTWFnMlNRc2VCRTJMTHFDb1AvN0kzVTNLazVLczZD?=
 =?utf-8?B?bktJZE9qWUg3QUZMS1paM3IrdUFSQmk5UkRaak80dU5sK1d5azM0WEtHUm40?=
 =?utf-8?B?M2NhMThGMkVTSjlEQURXd1Vxa1ZMVzdhUjUycDNiTmhZcTBoMmFQS3lmMEJh?=
 =?utf-8?B?emp5ZXg1MEtRVStqRHdDNlV3UGx3djR0cTJUL3hUdktwM3hEZUhwZmpNR1Rw?=
 =?utf-8?B?YUJUb25HbnlQQktaN0YwY0pHbjZ1OXZqNGMwL1hjRzk3SXhJWWRlZi9ySDR1?=
 =?utf-8?B?ZUY2QVQ0bkdabklNLzVuYXoxMUMvZUpybTVBTWl1b0YxcjByVHVtQ0Nhc3Z5?=
 =?utf-8?B?YTFkbjlRVDA1Wngybk9mWnFkRFN0UkRkOVVoMjZsTlVMaGpJcHY0dHE5M0dw?=
 =?utf-8?B?SWQvc0dsUzB2QUxFdFRJbjU3VVJqb0tWYkpOTlpLOWZQWFE4SjZSQlFDd0Vh?=
 =?utf-8?B?Z2dsNkpGZEg0U1VwNHNZS05ibjIrc2kwTkRkWmNZcEdtVDhaZU15N1B6dXA4?=
 =?utf-8?B?dFR1VXlwdlJmcGFaa3JSK2tES2JyNHBKN2p3ckhWV2lsM1JTZ0ZRa3JMVlNU?=
 =?utf-8?B?em13SGF6MFo4MEdiOExYeWRLeFpVUU1yVWhLck1JYmg3Vmc5dE1QZ2hNYUln?=
 =?utf-8?B?MzVPdG1oR3BKcVUvN25mZXc3MGZkb3p1UDE5MTVmRFJoOGpDSko1a2NycGxD?=
 =?utf-8?B?ZXpXMjg0RjVLcTVMd1NjNmh0ZTk0SkMwVElwSm94bTVIckdnZDlpZ1Q5eFFY?=
 =?utf-8?B?RzJwRlFRYkZSUGt4Z3VVQ0pyR05DeW4xNDN1QkhmdDhZTlFNdkpZVE5sS29R?=
 =?utf-8?B?cEpLVnltRlJ2VngzSGl0Z01IUjNIT3hwd1hCYkNhY0FwQXU4QmsrS1RvNFc5?=
 =?utf-8?B?QVBzYVNINjVJRk5HV2l3aFpybDNGUCtyOGFXM0gycklIcHRKaTJjckNBcTd3?=
 =?utf-8?B?YXdselFHclU4bFhuUVRmeGZSTXIzUDVvQnU5cFhkQ2JtcS9OVjgrY3k4dFlF?=
 =?utf-8?B?NkErU2RJR1hKbk92Zm1lUHQxZDFSeTZaQTZHM3pvQmZHbmhpL0F3SHd1QjRE?=
 =?utf-8?B?bTNid0lhMHFLQW9vanM5cjZibW5BTmxab01Hc3ZoM2Z5RGREaU1JdlIzSXp2?=
 =?utf-8?Q?XW19qTJVHHcajvU+7wHLLChhl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e8d417f-a285-4434-16dc-08dbd876dc2a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6288.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2023 12:02:01.6796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FZfDDtqlVpfgZq0i1j7DBC392eLnIeDcIDW2NgfFoQ53TTgHTzytxB5ZA6F1koC6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7870

Hey Maxim!

On 27/10/2023 16:57, Maxim Mikityanskiy wrote:
> I believe this is not the right fix.
> 
> On Thu, 26 Oct 2023 at 17:36:48 +0200, Paolo Abeni wrote:
>> The following commands:
>>
>> tc qdisc add dev eth1 handle 2: root htb offload
>> tc class add dev eth1 parent 2: classid 2:1 htb rate 5mbit burst 15k
>>
>> yeld to a WARN in the HTB qdisc:
> 
> Something is off here. These are literally the most basic commands one
> could invoke with HTB offload, I'm sure they worked. Is it something
> that broke recently? Tariq/Gal/Saeed, could you check them on a Mellanox
> NIC?

This is working on our NICs, we do not hit that warning.

