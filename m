Return-Path: <netdev+bounces-62672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E14A8287DB
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 15:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D527B28626E
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 14:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6893D39864;
	Tue,  9 Jan 2024 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jR/UiPLx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB2C38FB0
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 14:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RuYcbITjuqzpFRChxTiT3WVa5lX7ejKvxCex/MaNsqB9Elgkr+2HfIl5p03gwX1MdRGeuLYEt+h6bYkTjKdzLU6Ii49uqPiPcc3wAPFUXkfl8jS8Lmcg5IEBr60Ps7dU9FfEIva75Q928393rqPkfuBRJ/ZyV9yJ9D1vGjMJxBPaRLyy16swfsY/71LyfMFte5X8itY6NGs2USbrnMVvbNALEuAoanzxoPtT3UhrCS7avrq0X/Agr1RC5wad1mKqmCV5XeH21w2S5faXx7aZ+hxYRSdJ09Db2Q15eD9FJl26MIvbBIg/q7Ew2i7AYDlULButgqw1iBW009zs9lONPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YNbNyxEJ6QHGxcJCmkaI2GrYyztXJkAUJcc6MROYBE=;
 b=PRJVfBX64w5IJmGvo5GrJpAqFFfiZtSmSGwMwLubu1uza5XG1DlqC03Bf1b4OeopY+QR3YflNpBqXeNrIhkAquW6SLot0Ty5z0XFYK/hlN1togfrwurijNbSn15h3kMIbsF4lVF2YRn2iWraLrMDE9pg4JSbhvw7JOGefx5Czr6exi1vOECzmv52A4ZfhPtpTraAmDdJqSU4aYqSJD/kR4LfCr/Rg6rqofBrmIjbt+KnYI1NOr1Afs+9+y8td2itBcYht44nrxecvHc6ihhy2oi4J3OpAjQ3ugPx98qPr6jYtOgE3Js1i+mzWfsfTVJzsYrl12qkG18YaiSwOAhxYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YNbNyxEJ6QHGxcJCmkaI2GrYyztXJkAUJcc6MROYBE=;
 b=jR/UiPLxGzFwB37EzJY7j9OuP3XNIZt0TYIdcZuPmVctdihDUx01krvQ6tl+bmP2+wbNfHvsmGvWFvbOGabZmmkCJm/sZeIqhssOufGUi0xgEOoxYyS/uxOEFhmz/8DNSQguxY3BNrB57ZZg9H2xn3+wL4IdgQhxkVtfC6Ec0B14iV+ypmoNQ+cbulbcdga3RusxZ5Xzs4i7TVQ8z8iejgDwr6PZ39yPxj79VQZ+IoBz5XPUB8dNxUUL+B4reovp/ZPepAGMZz5jHT0HIUMixfCy81T6nvwzhPcdEAQYi6kWImGohSt67SjiyaAxc7SGWZgbg8Sp0xUaJeprgqydFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) by
 CY8PR12MB7122.namprd12.prod.outlook.com (2603:10b6:930:61::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.23; Tue, 9 Jan 2024 14:15:56 +0000
Received: from DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::1442:8457:183b:d231]) by DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::1442:8457:183b:d231%5]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 14:15:55 +0000
Message-ID: <d0ce07a6-2ca7-4604-84a8-550b1c87f602@nvidia.com>
Date: Tue, 9 Jan 2024 16:15:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next 10/15] net/mlx5e: Let channels be SD-aware
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
 netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>
References: <20231221005721.186607-1-saeed@kernel.org>
 <20231221005721.186607-11-saeed@kernel.org>
 <20240104145041.67475695@kernel.org>
 <effce034-6bc5-4e98-9b21-c80e8d56f705@nvidia.com>
 <20240108190811.3ad5d259@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20240108190811.3ad5d259@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0079.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::12) To DS7PR12MB6288.namprd12.prod.outlook.com
 (2603:10b6:8:93::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6288:EE_|CY8PR12MB7122:EE_
X-MS-Office365-Filtering-Correlation-Id: 113fa30b-1ea6-4b81-1704-08dc111d7ea4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yO6ZPoA0VvrFTvvJE1ac8nX38BEhPRNw4+v7s2uyCKZ3Fer8jiCMGVyeV6phEp7NVScNIsaFX4B0aEz8L8xW7Aw4FxFn0J78fN/yRRg0v6HHsl28En9XGSNkjIoPw51eHXyIyDKohtAf33pHkHBYqq2LPV1Lj/0Yqv/hj+cC+bfDBkvz1bFL62jmxuJWN8gEthUjOzoaTMnjx1GV0umPVt0s85fDBOQIG3TgBXSmGFkgMD4hOp24MhyjjHVo9FjVBL90P962pp/hhDoyDotF9A53FV9bUbdziySHdVk75UTGrXa92AMIe8llZluCCckM1GY8dFcrf4rsG/18p/E4qXSY9ot/ex7NhYqhYhrYfCJtPJcTrKeZT7nFfWQNFMVTr0AGfuTD146FMAnH+sEPg6fOGOFqP+Z8icJDpaEdaiie4+/DB0Pknlm5VN903ixuI3CU7zfWr0gCzqUaqYv0jvGJ1JkhdZL31EerkVRtlBoqj5hrsAjV8UaPvo6CjCvdUgfv23xiM2jkwNITtSDUiRMIZz8NhDMRZ5JBsodJyMZ1DUbjNWuRkeV06G7LNiPEYra9QvLmUm5wGDHWi02iUfVe/VJallGep/LnHW+qixAy1A8SGQYPmdas6TkUExWor2RiLbLYi7CVQoGfK3UcpA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6288.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(136003)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(2906002)(107886003)(6486002)(2616005)(26005)(66946007)(66556008)(66476007)(41300700001)(31686004)(86362001)(31696002)(36756003)(5660300002)(4326008)(6506007)(54906003)(83380400001)(53546011)(6666004)(6512007)(478600001)(6916009)(8936002)(316002)(38100700002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1Jhcjh4SVJoeStHcC9uL3g2RDBtbzdvL01xQVAxTUxEcGZ3Rm1DN3d5OGhl?=
 =?utf-8?B?K2VBdUwzdnJQdFh1ZXowdFQwdTFOZUxEbmpxTi9Ua2t6V2c5M3gralg3Vm9h?=
 =?utf-8?B?Rk1mSzF6WTUxMVpyNjRBZllOdVJFQVlmR1QyYUQ4U3J4S0xYTFdrQ2w0cHZu?=
 =?utf-8?B?aGhxOERFdUUzVjRrRkdDd0RYTGFzVHUyU1lBaHp3QU1YODlLVng4dmY5ZVVp?=
 =?utf-8?B?djd3U0Jya2NjSEJVVGxuVjNmc2xFMDJiSGZEeFNLVGpaNGJJKzZnMWE5TndK?=
 =?utf-8?B?TVVEc0VGa1cxbVU3VnJxUWxVR0hxak8rZEFhK0R5cjY3ejFhY3REVElyeXNa?=
 =?utf-8?B?aGNpTzZzSXpBakNkSnErQ05OVFc2UWpLbTBWN0J4dFdMSXhKUXNTNW1obnNn?=
 =?utf-8?B?RTYvN0VYVkRhZ2dRK1RJSjZBTks5Z2F5TXduSGp2cFIweHMrV095SUUrZ3po?=
 =?utf-8?B?cjhuS3ZqQXpFb3NIaUhvbEZIWElmdDNrTEJXN28ydUNKWXlLalV2UEZyZWtj?=
 =?utf-8?B?TDUzRDFmWG04dC9BOFVCTVFCOUg4QnBreFpoWjEzLzJybC9EZmpqSTR3ZW5y?=
 =?utf-8?B?MXpYZDJHblpRcDA3Njl3Y09lb0FEZ0hVRlRjTkxqcVgxSmpDRWVsejdJZXB1?=
 =?utf-8?B?dlZzeEE2K2duNHIxUEk3QVRzQnZXTE5SVlNsbDg2MlBGdzBYdE0vaWJjbk94?=
 =?utf-8?B?NXNUcHBaK0t2czRzZWQyUk0yb3YwY09LMThUa1lDSlcyRjZnQUZYZmRRU3ly?=
 =?utf-8?B?UXI2V2xKdjhMQmFUS1dvSTVzNmlBVmVxWXF4UG0rL3o3V3puQUZRODdnSkM0?=
 =?utf-8?B?L3lhdzM5NHc4Z0xKZkJPT2IraUhDTXVHOHFZQXdIelhOM1BnbTZ0Q0dXUEdh?=
 =?utf-8?B?WWU1STZEcTd5Qm44cUxQNkMzckg1N2tiYVhFZitiRHhDTXJ2Y2xHcU1STFRU?=
 =?utf-8?B?MFEwMi9mQmFLZXo4RlJKelRNQUc0YkQ5eTJ3aHpCdnlwSElmOTF2ckFHNWFl?=
 =?utf-8?B?amZvV21NaVptZit4dURrcDNUdFpkTVhULzFXL0JPUWNuRHVXdEI0ZTNFZjMv?=
 =?utf-8?B?a0pXeXltT25DWXJhTGtnZzh1a0RoUkp3NmNGZTcyb291ZmRwdDVBY1R6dkJW?=
 =?utf-8?B?SHRNY2h4ZjMxczBOSHhNWG9LSm9ocVJwK3pvZllIcWVJUzFwQkF5eTBXd0FN?=
 =?utf-8?B?YTc4bjFONW5pc1lDRXJDbmhsZkMwbW9mSGh5VXpSMU1BaVlma29aUEx3YVBu?=
 =?utf-8?B?M3FtUG1tZCtGdm5VSVY3emZBTFVFR3FOclQvSGd2eUZsYi8vejZLNGcrU2tE?=
 =?utf-8?B?MWt4V2ZpQU1wUHB3NEIvRGJKbXlmTUllZ2I3bHhjMzZ4amZzbTdFYVNZdjdS?=
 =?utf-8?B?bDhKeGJsYXU4SExGUWY4b2F0RnBHaHFlbTYycEhVejV0SVkwZjVqVnFJTWFu?=
 =?utf-8?B?TExjY0VFUXI3WVNNWm5oR0UxQ1UxNWtLWjMzN3U0Y2NobXRBVUNqYmw0amcr?=
 =?utf-8?B?TmxzUkFyVjhlR0xFSk92RGh3ejRJdjkwZ0E3YjcxRWJONExxN25MczRqdWcz?=
 =?utf-8?B?WlJPcG96UEJXMlBUUnpTK3JybkN4Y25vcmtlTWxhcm9JTUdONStmMFp3bGh5?=
 =?utf-8?B?cmZhWVlFMkNabjdLeTNTYVVlNlRRVURtbG1uVlpETzFMWUxLNHZOUGc2eG91?=
 =?utf-8?B?cU9RdFZjZW9aKzdPT0ljL01xc1M5Q2xmZTBUNWtlU0UyR2lBS2dCTkt6aXgx?=
 =?utf-8?B?TE1DWVFXYmx3ZXpNOHU0aUc3bzNTS2M2UjZnMUlDc2p4WmJGZmVVa3k2Umkx?=
 =?utf-8?B?blpKdnVZNGZob0E4SDRKU2xzakxEeEVYbDFTMld1RmQ3cGtHYnZ5OE5UMXQw?=
 =?utf-8?B?MERKRWx0cnRFRHlvaTU2YlZNSTRQRHdsaTJXcmZpcXNrVnJaSkRwNUhlb2Zn?=
 =?utf-8?B?Nm5JcU5IU3RLbVJwQVpCa1JVVkQxeTc3QnNIOEZhNXhkdFh5akdvVW1uVk80?=
 =?utf-8?B?YzNmeWNXNU1tcVVwNE5VMmVNbkIxMmFMM1dYbkN6MFRZVWVmZnY0ZjZpNTZT?=
 =?utf-8?B?TUk3U3orSGFQTCszdjRzMWdJNUN2ZXV2ZkJEUFVWUmU4TUJMNWFXa2xjSzdv?=
 =?utf-8?Q?ub4IBBAu8efRQO6CPW2LRXykC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 113fa30b-1ea6-4b81-1704-08dc111d7ea4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6288.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 14:15:55.8748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j41+4myQOJHiUNv9V9lOMNWyfdodwuTvDH8C2NKJs7RgKZ+LRg5ZZY/XK5YhSRby
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7122

On 09/01/2024 5:08, Jakub Kicinski wrote:
> On Mon, 8 Jan 2024 14:30:54 +0200 Gal Pressman wrote:
>> On 05/01/2024 0:50, Jakub Kicinski wrote:
>>> On Wed, 20 Dec 2023 16:57:16 -0800 Saeed Mahameed wrote:  
>>>> Example for 2 mdevs and 6 channels:
>>>> +-------+---------+
>>>> | ch ix | mdev ix |
>>>> +-------+---------+
>>>> |   0   |    0    |
>>>> |   1   |    1    |
>>>> |   2   |    0    |
>>>> |   3   |    1    |
>>>> |   4   |    0    |
>>>> |   5   |    1    |
>>>> +-------+---------+  
>>>
>>> Meaning Rx queue 0 goes to PF 0, Rx queue 1 goes to PF 1, etc.?  
>>
>> Correct.
>>
>>> Is the user then expected to magic pixie dust the XPS or some such
>>> to get to the right queue?  
>>
>> I'm confused, how are RX queues related to XPS?
> 
> Separate sentence, perhaps I should be more verbose..

Sorry, yes, your understanding is correct.
If a packet is received on RQ 0 then it is from PF 0, RQ 1 came from PF
1, etc. Though this is all from the same wire/port.

You can enable arfs for example, which will make sure that packets that
are destined to a certain CPU will be received by the PF that is closer
to it.

>> XPS shouldn't be affected, we just make sure that whatever queue XPS
>> chose will go out through the "right" PF.
> 
> But you said "correct" to queue 0 going to PF 0 and queue 1 to PF 1.
> The queue IDs in my question refer to the queue mapping form the stacks
> perspective. If user wants to send everything to queue 0 will it use
> both PFs?

If all traffic is transmitted through queue 0, it will go out from PF 0
(the PF that is closer to CPU 0 numa).

>> So for example, XPS will choose a queue according to the CPU, and the
>> driver will make sure that packets transmitted from this SQ are going
>> out through the PF closer to that NUMA.
> 
> Sounds like queue 0 is duplicated in both PFs, then?

Depends on how you look at it, each PF has X queues, the netdev has 2X
queues.

>>> How is this going to get represented in the recently merged Netlink
>>> queue API?  
>>
>> Can you share a link please?
> 
> commit a90d56049acc45802f67cd7d4c058ac45b1bc26f

Thanks, will take a look.

>> All the logic is internal to the driver, so I expect it to be fine, but
>> I'd like to double check.
> 
> Herm, "internal to the driver" is a bit of a landmine. It will be fine
> for iperf testing but real users will want to configure the NIC.

What kind of configuration are you thinking of?

