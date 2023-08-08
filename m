Return-Path: <netdev+bounces-25320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD97773BB5
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 17:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEB4B1C20341
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 15:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B9315AF5;
	Tue,  8 Aug 2023 15:44:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598791C29
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:44:36 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E8E213D
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:44:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCpxLPBTzOAt+fizPW92HfPjCygKmllPhKGh3xRNMK403qxGo7tVqz3LJbNK0TQWbwcNFLbjLAr2AWZsMyxX7uEsRx7EYN7DHZXE84dG51/iIlf21CU3+TZR20A0pPYM6seqgdCNnZxKRcgBrDRwoQwsWLgB7FmN5F2kEGj+ce6KIh9YHo/qXtx3ON/YOuHye/tRqJwD43YJII0CCULEjjnHHArUVWYuoS5K5blFkw1mShXPoiw22aQl2jC/Gb0rKuoKnVL7rHuh8X+Ak976SllHh8jlckLYF8KO+optA4PMZ68S8YdQeke2Z28Sxfv+3zMoTb9xOG24f9pc4yE3dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nw3wlZEn/dGjER021nHV/YEIC6tSofueHA9wOH63tTg=;
 b=nNFIgicVC7CQf5Is4t4N0Kh2WFnN40rjWOSsOQeCx4/7Yg4A/Rogu4uJPdgDAWRl0N9bCzhay6Vs5eb2Pn5uUEsjvhwJjcjJjevsp30/IMmmYe64QakwmvBMypDwGoNBms8QIvNA8xdtu0yxfFuPyGXaZr2Tp4kjX2/nWLOxisk5YmUgACwlFtnuYbnTXEBcR3Jh86xdnZxzArgHTumkYjRO8bqvrBQKkZ4is5hPd7Vh5MPsJHCmZE4zvpxTdi+6L5WUU/97DKEW0BJdVb0Gvfg4rHdnK46WQJm838ORosUsHEHXxu1P05T6KX9E+GrQO5j4grnTrH/avESKEj1+Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nw3wlZEn/dGjER021nHV/YEIC6tSofueHA9wOH63tTg=;
 b=VCjfJ5aNsB2bfzuEbF8iQjMedG8YOlINupCiVfMbzoWq8dW+9vdf+7eGmpe5bRWfzaV5NW+DlmpAcUPHlA42+M8hJHi7Agm8VGzotd7M1GlWnbBLskOzXDg7o5sZvwne3GQtfNV3XdeIu9rprLyTnWIUrcNoXZNHojoL8O+WMNlFLNc1iRhengFH1yWo/3IEq8JjgPOJ4gvebEYsc64DB3Eg/jyh3gK0h6mfHieov4aa4QgsCKHK2uWd7dYI7WZX/Vgatxcdmbq09e+TQ2GxPqqMkuMhgalJL4cK93xl5E4dItqn+cKeuUzr5CAAV9bhgXzL9x88t0GrkHbN7jUoWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 14:44:24 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::e8:f321:8a83:9a0c]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::e8:f321:8a83:9a0c%6]) with mapi id 15.20.6652.025; Tue, 8 Aug 2023
 14:44:23 +0000
Date: Tue, 8 Aug 2023 17:44:13 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: netdev@vger.kernel.org, Petr Machata <petrm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH -next] mlxsw: spectrum_switchdev: Use
 is_zero_ether_addr() instead of ether_addr_equal()
Message-ID: <ZNJUvRsToJvMFVDW@shredder>
References: <20230808133528.4083501-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808133528.4083501-1-ruanjinjie@huawei.com>
X-ClientProxiedBy: TL2P290CA0025.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::20) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|MN2PR12MB4342:EE_
X-MS-Office365-Filtering-Correlation-Id: ea844d7c-6bed-4f1c-a786-08db981df4d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YPnJlGutXqYqo00sU/LvrZKq2jypPqvwOsLqRssNn+K+sINqcWZ/u6frbls4u4foZWV+68R9/+sGKRG0L7WrDNIV7tuyO/DnVj4y8am0vqnP+eoB4alpmatgN+Oe8bPBIHaxJ2IFnQaAgzIGIfLiXWai1wMVBoqPFCccKYtyF0UVy8/ST5tvwW+jgzkwbqFzUK/NLp4iRLfDwng+a7LfrvcOyQ/0WSy2A71sYwHn+PsTi6NTb6pOJoLL0vh/dIvOFtJ3lGYxKFXOLQcCWCvdQmwgDujptN623EfT7/Ckp7+IvQ+4h66XKtI+hJGsqh3wQXPXbxlcJ6SIIWPLS5nVIgjFOP4axVC+o93k43326OzlPQAgTceP7tqAs4l9ed4/E//lF8/dDJLKhqHEzAgrdBynj/LLk9Se5SRCmiojEv29sTsV7hfNWV54qRebxmxMAd6Vw2LfpQbXvnDVEzQpIcuHSZWwM8ds9dvLjF//s9BzgPYlWqTU21p/R7cU5YvtsLoZds6Hk9pfd2bOmVrB4KZx6G98q7u/pBy3aFs/SZUeDntUNyWXNp/czU+Rt5XWRF/disGES5ZkzGqLa8E5Sg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(1800799003)(186006)(451199021)(86362001)(38100700002)(33716001)(9686003)(6512007)(6486002)(6666004)(966005)(6506007)(26005)(316002)(66946007)(41300700001)(66556008)(66476007)(6916009)(4326008)(478600001)(4744005)(54906003)(2906002)(5660300002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I3yhQ/RmeXSQGmVbozZ4nQruAZf0OoOqtjlfBb3GML2KqOCqul7g++IiiXuc?=
 =?us-ascii?Q?FYmbpAbBUJDMeKrOv6AZByQBKijCaINMMYzTSHlAhHHcZoDQA7GCj6cMdr/a?=
 =?us-ascii?Q?9rDRynqaq38PzGjay4vFGISTJI11eNSL3Px5GOh32ld3CAlLvLxwhLxEA9A6?=
 =?us-ascii?Q?6Gy7DoQgVRwpah6zN9L3k0R8RvRPqmnjxyNvelmwRlgxlIO/y4BeyhcQcS5T?=
 =?us-ascii?Q?5JiqRl77HMlcL6LLssIfTNGc/75LJmVE97dQrWsxxEWc373K0ml8PUGHqm5D?=
 =?us-ascii?Q?OasSFyoSsIl3lIex1b+QXpmMzc6sUkijgEG8I/6QE/dy7j7u3ps4fmMbC4NY?=
 =?us-ascii?Q?bWD+wKnGODze+rbgl4B2u8WfR2rveOsnE+VauSMBkMDYcactO6h/yrPiCNoh?=
 =?us-ascii?Q?/UdRBQ+b6PnK+1ZWfuVbVcRnrQSTSqg5LwEDfNWa2FAoi0IYT1fL0+rGMpyl?=
 =?us-ascii?Q?iKhsB0moqQZIyWxta0qsS1frHhd4vt3HfbAFHboyshG+0mTn3mBdpOu+9FmW?=
 =?us-ascii?Q?x+941GIAIUfgLhbfF5lQMwSBttcov6f3/DK/tzqy72hiFH8unkUK7NKzuZu0?=
 =?us-ascii?Q?bC09lmX+lJx2hcgsz3akpgwXqGW04KZZOFXWdgkLNapeFczVfCZrryHLq6BU?=
 =?us-ascii?Q?KKgVfoIJo/natgrWuuJ+jXYHV31vdpEyJ8vkSTgvNdsQtJ9ZGBzYfT1Z3iTt?=
 =?us-ascii?Q?rLF+/olKAFA2n5NPR6YoyBduEV0fTYQ9KTsY28LBRYbE/BV8xPqXgWFRVMHz?=
 =?us-ascii?Q?qdtXpmQzvY5EyYTqx7HIHYpxQAXVaclzBBvWJR5pWLUYrhySr1oafPRUiPMS?=
 =?us-ascii?Q?WYJ8V1OCCqLQrZvQA2oiI2LA8WqyunUlCeUh8oHcDPjyi58PWrpnujAyRBwz?=
 =?us-ascii?Q?LFrjbHxQsqScDvS/rBqG3gLCaxIw4G6RSrvGP6BZCwM2DZFJ8Qhj1P8gffQQ?=
 =?us-ascii?Q?8upUUBtOo5hWvpWFNJLsRRUIAGDGZ9NNXmAzwPSQntWZjNErxQ3ZKnk8Sv9r?=
 =?us-ascii?Q?vTQmWZbnKR6jIwXWCN4owvP259aTFSMm40idLNGeNqXdSiluHZ/TQJSxXvoL?=
 =?us-ascii?Q?aeG63FBoaINMIQko5tCRKKfdgw7n4lAaVsCsEMY+92nwkko+Bew9FLm640w4?=
 =?us-ascii?Q?RfdNcHpcvCwLl+0hZHU7tibu1Mo/FBDmt1b+yZqVahPBR8DDXD6PCdB3pHaJ?=
 =?us-ascii?Q?oaJPBsV38OJsfmHu+WnIh9MaZrd2dRm7c2gHcHD186QvjWRNWNg+n8P49I7P?=
 =?us-ascii?Q?nFzhrJ+Td93SKCdJL0NvuYpOaJ2lGds2XfPNlRZ45KyKfZ09Zvx0IXsRy/g0?=
 =?us-ascii?Q?ONgPjg1Ht+0VOWFfvEMM25VNenWbt0mz1qklf+SmC3PiCQSZT9TMOhF5Ahna?=
 =?us-ascii?Q?oDLHa6ZTMOpM7ejLEWuE3EqZcOBNPKuBBxsCh8oDigSe/QV5YBINMwBzDJrr?=
 =?us-ascii?Q?DQl77Ao05XTF1mZ4hySTak1O//yADP4vCbAL7s6DP6iGJ31g1f0A5Y0N1VPI?=
 =?us-ascii?Q?GlCzpDQfwF1orKqhwXfOAAT7EQq8kE+6loTStodBCiBovM1vt2dNdCSaG2M9?=
 =?us-ascii?Q?Z8IFMZRZ/lqm0NKjo4jC7PsL4q2cLzwHM2+UVs3w?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea844d7c-6bed-4f1c-a786-08db981df4d2
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 14:44:23.3621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KIY1UV25w25t0lvF7OA1P/leC/g99UVPl/2Zbg8QNSn6bOlkqnh/bnt2gbjCEGjLb6/MJIDzAe2usbOZTgaZcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4342
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In the future, please use the correct patch prefix for netdev
submissions. See:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#tl-dr

On Tue, Aug 08, 2023 at 09:35:28PM +0800, Ruan Jinjie wrote:
> Use is_zero_ether_addr() instead of ether_addr_equal()
> to check if the ethernet address is all zeros.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Thanks

