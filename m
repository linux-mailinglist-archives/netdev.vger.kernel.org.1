Return-Path: <netdev+bounces-48102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB7A7EC86A
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 17:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6177A280E9F
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 16:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BF3381D7;
	Wed, 15 Nov 2023 16:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s7/vOT18"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E02381AE
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 16:21:44 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8143CC
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 08:21:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYQM963NcHToJNpildT7c0Nh4YwgslVuIfLjZfI3qcLVWL4XxQXpP0erN7cWMRvEnM6DOR2vsetVPy+74RHK5AKUUehoucgYFrpltIv9VhyACXGtDDc9g+0n62QgpTIAoaseExDXg4KJrY0bRDFhIOrpthMwCg8g35cSkIIczCHfkCndFEB6aNIJxRaNzwG/FfIDcIukZakpfMxdNsIqVOskoRP8kXaok+OFIlqUv4IP2z5rIpyoQLREQt8qSth0FdpdX41vNg1RJRMWMMytcswm7nsZLXhjtAqgUgEwmAmwvCxDD0jMR4cYaVH/7N4z8kXF3TUOZ1uhXtyW2xaRNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PI9Dq8YNKA7qS52+aS6UIQu1tLn4Hb8coFpk6wAVPSI=;
 b=NR+JhmdfyyDwqjWceUDoOmvCTH9odaSkwQrUzBRIHBeMmx7m2wVKNOKsD0RJFWodysKMSBg7eCPvVuwj2GlETGuILJwpOCiM2rkJ1KmB9lIoJCqTYL3Eii3LlcHvRs0oz6vYH8uzfy+ZkiUCtmHpkAV89DV88h5BZxSjpg4fW8Pbs07DN5LEBjusOz9Q5qtHRLKlk8Q7VyyvHc+76cRqQLDtKqLzGs8yNZW2ne/gg/CA3Bbz/0ZlJ51EceQj2a9KaNvDjE8acAwfVpfhppvSDNaojcUz/xKowLj9qa2pI6LsaKSp/BkyjUpRtzmNlXFFcJ66JIlpqRms9smjeuRmJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PI9Dq8YNKA7qS52+aS6UIQu1tLn4Hb8coFpk6wAVPSI=;
 b=s7/vOT18+YB7waGNwaXne688hl7tpWcmjCWcFfLe77ciuJ6qSo589j4KBk1eE0h+c3fTJRnHNhhBkCWGz/NrMgmDrMz3/o8wS/94Ka+tJDjya6jKIxHGdur2tjSii6qWoZLB3bCUstv2Q2SjJ3uP7jJrtnGQdb1jICuPrD9/00QinQYxvn1gNarzJhKKflYNEVmWNiGGVOLF26SnJ4bPWdAWMJ1B8nabO4YJVoSyJVKvi4A43s22bxmrGMh9aZVEVXPy2sDX8MJPDrFXo2MkuTqqh90wSQm7xrFjPRc9P4sIbgOoeJnnYqXk8GUqZlBExj9+k5gC1pEqxKOLA+gVzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by IA0PR12MB7505.namprd12.prod.outlook.com (2603:10b6:208:443::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 16:21:40 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::a24:3ff6:51d6:62dc]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::a24:3ff6:51d6:62dc%4]) with mapi id 15.20.7002.019; Wed, 15 Nov 2023
 16:21:40 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org,  Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>,  Eric Dumazet <edumazet@google.com>, "David S.
 Miller" <davem@davemloft.net>, Saeed Mahameed <saeed@kernel.org>, Gal
 Pressman <gal@nvidia.com>
Subject: Re: [PATCH net] macsec: Abort MACSec Rx offload datapath when skb
 is not marked with MACSec metadata
References: <20231101200217.121789-1-rrameshbabu@nvidia.com>
	<ZULRxX9eIbFiVi7v@hog> <87r0l25y1c.fsf@nvidia.com> <ZVThf1Z-hExKlDE2@hog>
Date: Wed, 15 Nov 2023 08:21:27 -0800
In-Reply-To: <ZVThf1Z-hExKlDE2@hog> (Sabrina Dubroca's message of "Wed, 15 Nov
	2023 16:19:27 +0100")
Message-ID: <874jhnoum0.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0146.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::31) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|IA0PR12MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: d8cbb683-39a6-4f97-ef6c-08dbe5f6f2fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	r1XpRag9G61mLAICJkoWXfa5iwGrcVRJHITdSj1lPC/cXKD+9gTrtj8jmWIZ0hba4POvbZf1Qku6hkBF/H50yDi8JPvBcB/nv8ztKk6DGj1m1b6Z4lu/nQAIL4h4Z+kdOnhdWmSAgZ6dRyL2xqni3Ucj+IqUESEqA05osDycsznmANXLmN8xYVmjaeT2Fek4szEx2vTjreiV52j/IGrH4U5FDaC/C8HQlLwwacymGRuG0xdi8TUHPvVKAtXofKIUNTwV2BzayxDba3B/90EzGxDBlDGSiNgjfMvFWLC6SusX4TXzCdn3FP72BkoGuyT9Dbsck3VlzAeu4ctjSH8bRwTItxFiEzkjcVsYafSXe0vNauFPqbopyKiU77nvc9IcVLrviJ86uY4FXj/6pcu/drk26NeQ5pYttnxGIetl8OaYv6uxG0wH1LY6VXAnZuUnqVn84EaWDz0nuXh/NuNRwbz0DLem9rClV3nPcq6fM3yukE8RKSeQ17OYSddHWvrvpVP7M7FcOoihYx2uGhQCIMtJ2uYbZ/YWd8d1x3Yl1EGUuZk+ct2+owCABqPCQHzmrG52VAJL+hakgqc4RRKZKnKjL85X4HIHqkIQN/hSn0MxhWcss3qT5Cny1iyxKGm3pUSM4oNz0b4U5nSQBzSQWyA273zwNM6qANTD+8z+wh9mmZmcA32eRIOoD5OeBqjgBACiaJ1mwta7wO5sxsFQEnUlLowbRyLa/hp0phJpMb6Vw7tAgjdJ0TT89nGzC0k2WgXfVeMZK6+N4sHCoicDIZiZsxgIan76hUJ+W1W6nDZYN7baLpRSuW8e/GqRIF2xRDUjTFlka/aok48e8ltSUQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(376002)(136003)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66476007)(66556008)(6916009)(316002)(83380400001)(2906002)(478600001)(66946007)(6666004)(8936002)(4326008)(8676002)(5660300002)(107886003)(26005)(6512007)(2616005)(54906003)(6506007)(38100700002)(41300700001)(6486002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L8p8fGEIyhfEcgqyQPL1D2nTBvM0oUPfg3nVzofFZ1MS9jFYyspukrAkfeQV?=
 =?us-ascii?Q?gtJwBbJ/N+rr3khNT7d688d/yezlrkbKn+AI2VraGuH38jgPEv3hNIfxnsy0?=
 =?us-ascii?Q?xK4vM1e2G37zys2TGSOfmod872+3Q0kxNhbi7u1NPW0XQmWZOQYRIUbg/doG?=
 =?us-ascii?Q?fcgeThlJFLITSt64cMz0oSNc2r704Ex0F76eDghcP04kxdMcqOfFBUmVuWSs?=
 =?us-ascii?Q?XDop1SPFHWAXg5BFzHph4Py7TaoZa1Fgiq7jJcsUdeTV+HqVtNYA++o2pXF2?=
 =?us-ascii?Q?QboEJRNbokHEHaMoJZZze84bk8yY8O0GjgvBcIk7zHu/TnWzJrR87RWeKZzi?=
 =?us-ascii?Q?7n4I+D8l+cgGhazVtWXF6KuM9m+2CPCq6uFG2jxe2qP+buhndXp7r6qgDbP5?=
 =?us-ascii?Q?yVVqMgn1WHCOw6/6OtlKSqJBBeo/X9/5GMY+Laz9iXCREye8mVbxM6BijtpR?=
 =?us-ascii?Q?rnMEw6OAWGD0EeiPwn4dO59VER1jgiKGH3Izd5IB+UqKDnBjwTc2Js9Aa7x4?=
 =?us-ascii?Q?qE6QBnXCmzavLTlYde5Y/Hk6ejEAaM5k56AxRnyiea5xl9jEYWe0fdWLtEc2?=
 =?us-ascii?Q?K3KxXNcH1ANxPGyzfVBG0GrJKOIxtne1TiWCa7dx9BxxDlPOpTFa6FvK1tGn?=
 =?us-ascii?Q?lOlYQMwB+sibBVaUFdMmWlLOs3l3E7HaL1rvJavMFPuCWaIlazsOQ6xQlt6M?=
 =?us-ascii?Q?C/WxXO/9B0a4iKNt7ucHEuPY8FArWzVYfPCePVGgNckIoGKmAvnjJtyshyFZ?=
 =?us-ascii?Q?CmJrTz3dZAelf3ZSm8DK4vQS8i9JGh6YU6LO/qBcQ/UnmB8X/JhNytPv2lxn?=
 =?us-ascii?Q?XTWYB9TV9lnXsrwBHIL0vq+c4aSLwcCrDn6EER/10pOUObhMoLgNz0NQuZ3+?=
 =?us-ascii?Q?o5UYAC1/3UXiNQULqZd9SyJYQq4laVwbtwlMEwTIai/hMV4Tdr9uWuUe4iQv?=
 =?us-ascii?Q?lRLPe64pjMTkaqY+yg4/4s2yl9RJxM4sWbtm+Ay/liCfilWnjfJzU8vaie63?=
 =?us-ascii?Q?SSC/j3zu1nTA1pSe0nLuDRHs94DE8OduAUziRQo9lJJHRXzDMXaiCCQrbh2O?=
 =?us-ascii?Q?NIt1dhNqpeOJSvQDTrCaDvyUvBZkWKcwvYD5iWVydaWeg5VgemY5+1AKW54w?=
 =?us-ascii?Q?ppogvU0zl4v5Qy7E2PN+Mu3ooPCs3BAwUym7I6qPeQczOAgSHTvfJxZV/ERk?=
 =?us-ascii?Q?n73bBAZ+XjyMUOk3fpo2F9ER7dqTDlyHqkspRFWRvuczqLqxzpz/VnZaMhP+?=
 =?us-ascii?Q?BwGxo2JBJsnaY3TLPhJsrSG+K8vEXEdC+EKDKYEYnb6BNMxlfKRd4WIuJk8U?=
 =?us-ascii?Q?vi1dbpApPdwCr5Gxm8ioUjl7QoWFEgczm83/1+L5T70bnwbKcYQ1dxcoBnHs?=
 =?us-ascii?Q?eHMZy5LHJm6ar7zuC92Zrx6bzfwy2y+2/AlsM+Q+I3cknyaTwf1nsbI/+vaF?=
 =?us-ascii?Q?qIS0SGSuUpd40mHoWEguiaHEP6Oc06B2F2C4h+doJc0scAiGQo08kOtDT3y+?=
 =?us-ascii?Q?JBh6ChetS05IupQxuDiN9hIb8Ty4wuq5OzP5bgyBJmA49EcILViP7qVsZMaf?=
 =?us-ascii?Q?QGgPZzZI6Y4k4xj95NqOK2i9qiYXzialOtfqyH11?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8cbb683-39a6-4f97-ef6c-08dbe5f6f2fe
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 16:21:40.6514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TUpBpBSmhw0qFujOuVe4iTdFIVavHj6mlSg6Nmihmzfl+6DP/BGIhbyuTCueghvJAWhzOtSE5zQt94lTbAvK+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7505

On Wed, 15 Nov, 2023 16:19:27 +0100 Sabrina Dubroca <sd@queasysnail.net> wrote:
> 2023-11-06, 14:15:11 -0800, Rahul Rameshbabu wrote:
>> However, I believe that all macsec offload supporting devices run into
>> the following problem today (including mlx5 devices).
>
> If that's the case, we have to fix all of them.

I have an RFC patch series undergoing internal review for supporting
devices that advertise md_dst for handling non-MACsec multicast traffic
sent to the port. In the cover letter, I describe why I do not believe
the same case can be trivially handled for devices that do not support
setting md_dst since there is no way of knowing whether the traffic
received on the port was MACsec or not.

>
>> When I configure macsec offload on a device and then vlan on top of the
>> macsec interface, I become unable to send traffic through the underlying
>> device.
> [...]
>>   ping -I mlx5_1 1.1.1.2
>>   PING 1.1.1.2 (1.1.1.2) from 1.1.1.1 mlx5_1: 56(84) bytes of data.
>>   From 1.1.1.1 icmp_seq=1 Destination Host Unreachable
>>   ping: sendmsg: No route to host
>>   From 1.1.1.1 icmp_seq=2 Destination Host Unreachable
>>   From 1.1.1.1 icmp_seq=3 Destination Host Unreachable
>
> Which packet gets dropped and why? Where? I don't understand how the
> vlan makes a difference in a packet targeting the lower device.
>
>> I am thinking the solution is a combination of annotating which macsec
>> devices support md_dst and this patch.
>
> Yes, if we know that the offloading device sets md_dst on all its
> offloaded packets, we can just look up the rx_sc based on the sci and
> be done, or pass the packet directly to the real device if md_dst
> wasn't provided. No need to go through the MAC address matching at
> all.
>

This is exactly what the RFC patch series I am proposing looks like.

>> However, I am not sure this fix
>> would be helpful for devices that support macsec offload without
>> utilizing md_dst information (would still be problematic).
>
> Yeah, anything relying on md_dst is not going to help the rest of the
> drivers.

Right, I have an example in the cover letter that elaborates on why I do
not think it's possible to support this on devices that do not set
md_dst. I think the existing handling for multicast messages and
promiscuous mode in handle_not_macsec is the most appropriate for
drivers unable to set md_dst to indicate whether traffic received on the
port is MACsec traffic that will be handled by the NIC's offloading
functionality. Let me try to get that RFC out on the list soon for your
review.

--
Thanks,

Rahul Rameshbabu

