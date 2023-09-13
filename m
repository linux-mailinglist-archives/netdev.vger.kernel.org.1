Return-Path: <netdev+bounces-33495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D1D79E33A
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 11:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 981211C20DB6
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 09:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E981DDF1;
	Wed, 13 Sep 2023 09:10:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053841DDEC
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 09:10:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A971BD6
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 02:10:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhLDfrJs5obWMlVMxEijOXnSaW6qx8awF5v2/6ShnFI2ruMcuwsFb6JgecBp8P3nf/AiCQloSEdSdJee5oS9fsWuA6ik9PYYXRU6aXNQ+TZ/ChWZzUDge4cWLJyNWb2cswSVV82/6lDYeorQXSfOIqKSSo1gc9XoQbAahDNBEOpeyMAyAlx54B8uv28DQ7vSJoPNGQ1TpKBFfrwNp8xerF1OZF9hE4I5eqX73CH6km7dNo2q1JLpWHA9Y+ehGppYhGwJg4HIXf1ARm2hlGIfGscrxkV756dOxAsiV5ZcTsQ3I+jMCZkYCbVvS0uODKdOgsBoqCpj5BvLkrsg9GRIwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dh122PgU/2sIvht2qIiTGX6/bFqvUOQVuK4+eKeeys=;
 b=Itd6I/t5xboCIELNXZ0AQuUxEl5NXus3HdeFEGAE4SaXJZ7jMPwOM8LTnSnTKwKq5o9nMkJbcdfqVROHTVKNQWktw8c60WeK/G2ydKLbE5+MI+WqPFXKwEYKo1cylfcyQ0Nb7fRVA/OodOkPYF06w6GnmsKtwTVikmhix0gTmVOln6/+QLjaCFIjQKNIboyL61+tK/TasiDyVtzBl360Naj6PSO08Q9NraVB9bkOrMbVnqfeF1mBfn/UI1mzDs77ncbQAcxqOamI9DGRQPwWtYvB1fBLKitn0ZEju+svmNnbLk+fHQGag70nB0kr/EuG1Nx3InAfC90/sm3ZofNtjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dh122PgU/2sIvht2qIiTGX6/bFqvUOQVuK4+eKeeys=;
 b=gGKkxjcIe39rdQJWjBwT5/j+aYVi/ZaE9nzMequuuulK8wG2wiLk/COR8HX6Ey9L6HbOm3o8LIp+VQYI4v6CLOtEzNNCpIq9Zk2TTdL8ATcW4eeASsT0PeyQs/lskA4YR+1zwEKBGYRaN3KP12YDHVW0mTgq/QYiiBsxLZpWcMChFzV3ClALAVBRiv6TyIXLQ+rOhFC5MCACM+P3yIxNUwUiP/Hj+MYnXcTiMjBUa9edjYrmrkfZ+iO6PyI4r8OBpp1wDNXaHZbJYsHOnfnmpIqNBu+MI1m2NyxoSxwzScPL7ocD6E6bzmNqmnqDwcyArNZHhhA3YfhST76vk7aG3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DM4PR12MB6009.namprd12.prod.outlook.com (2603:10b6:8:69::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Wed, 13 Sep
 2023 09:10:42 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6745.035; Wed, 13 Sep 2023
 09:10:42 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
Subject: Re: [PATCH v15 05/20] nvme-tcp: Add DDP offload control path
In-Reply-To: <db2cbdc2-2a6d-a632-3584-6aeafc5738e2@grimberg.me>
References: <20230912095949.5474-1-aaptel@nvidia.com>
 <20230912095949.5474-6-aaptel@nvidia.com>
 <db2cbdc2-2a6d-a632-3584-6aeafc5738e2@grimberg.me>
Date: Wed, 13 Sep 2023 12:10:36 +0300
Message-ID: <253edj2h20j.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0221.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::28) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DM4PR12MB6009:EE_
X-MS-Office365-Filtering-Correlation-Id: 7138eb00-7303-43d1-2ae3-08dbb4394e36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OGvgPSsKzpWF0R1aLSlSWoSShvWDlprEcH/8uY48lhxABYqEODKPeUsoZgeTmkmRvRAuOfzV8E04E7awqyVYVDm5bt1fJIHPpTlAbNeSP/nkmCus5ICNOrani5n2ymbpzxjmHPw2rnaoidDbGOOm5/EZUeFbOmYxWFKPNQGAWxDfJyDGj7zTjaoAfpbSwf8DyMSvWbsovi/rdUa9ghurZWKK6DzDNQNfAvm9n0kl46Qn7BTrpQOILa5hteS5fXHbfypFXES9TxGbSblqUvgashz+T4sF2+0scSyG3Ux1la23nmzvJatbz1KNA944S3hD4m9XtsC+MuL7yVbDib9SaN03WQ+KBAJzLsprd9pOZyYzvt7cOnBGo1BVCDzhFrkBkcdu39j39Gp4phBycGc6NeOsqobjtRq+JCJbt3JxDyJwnsewuEi5AokOK8Ss20mXDnnHMK2zxEL8eJRr0e3jEpoWW9xiyE1JnoL4v7KTEtggLoaPNbn/f/w07zLDCgUN/YyEg9kSgZ6czuavqhT09o3v6CT0fa02Oy2plCPcw9x0zz15ZIUBFeeL/Xi6Ek9F
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(186009)(451199024)(1800799009)(66899024)(38100700002)(86362001)(498600001)(2906002)(6666004)(7416002)(6486002)(6506007)(107886003)(9686003)(8936002)(4326008)(8676002)(5660300002)(6512007)(66556008)(66476007)(83380400001)(66946007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w2vYFlw7yfvJPhS02vPWhUPQ4HEToy8HTnr6WyxGNPy7yY6XI0JXOO0cfZov?=
 =?us-ascii?Q?iEysD+NpTPflmamIVvVrvYvqFW3yeEkNAiSCW8r02z0QcEw/zaKTTaxJsW1U?=
 =?us-ascii?Q?vaQ03J2P1Y09Gu1h+Al/g710UhANABYv+NITYd/Fr8tBfKC5NtcmIuBmjNGm?=
 =?us-ascii?Q?DdBNqdpwBPT1BcVa+QSZ2fdjO/x8/XAj91SMuDCXDqwNtu6uQZ412GgjYjH4?=
 =?us-ascii?Q?UFXkQnSU1R74XifRyaHaf6/1F5rRpQLgIZYZXnUovWm8CXd6FL8z2loypKND?=
 =?us-ascii?Q?lMuLlE6jx6uJ7BEYxokfqHiKLLkkNSQen/h8xd2Y5g4s3U1G/85P1rkWDV93?=
 =?us-ascii?Q?FvpIGKTRlwg2+2Zj+QXbzXefvhkXCGlc3oBexRbYWynIR2Dx3Bqs/WlF9xGY?=
 =?us-ascii?Q?0cvBqZ06DSJGY2QNwpPmRtR8Iu04XkQUCcgs3DpicYfQDZZ3Nzc9uYirluTe?=
 =?us-ascii?Q?Fbr3acvIWIncC9IFcR3mL29nCPfaq9/3fhT7qzFQp16Klc1y+enQ3T3n9ZL1?=
 =?us-ascii?Q?R5c0P2/XpZB+yBRKmBZr+4z0mcXO/u5Pr46odZHD0xvj+VptPpDqY+2xW6sR?=
 =?us-ascii?Q?mRNXsVkLdaTchNbnSgWsNFmC/lGh635vPD6/6GZoWmKtkuoVEITova30HY1z?=
 =?us-ascii?Q?9sHKWkCifPi3WJgjS6N9JIIgLFiEvV/XTpcZlNOIkrD2A3ATAycV9WyB30Jk?=
 =?us-ascii?Q?dJ5WETenPkOUYeOAI3u3YpBGLG23Cle+7izDICxFIg9VvTtof1oiTrLgDU5c?=
 =?us-ascii?Q?2eO6h6PxELDf0AtgPznmpwBASy40NcfkUWgLcIBQ5KKaN5Cr7eDMUNiVcs8C?=
 =?us-ascii?Q?OthkTmmCy9gALDJkRRJ7iaM/OHr9Orlkvrb1Z9VDku0t48lXqXuGLsyoSS47?=
 =?us-ascii?Q?hF/btFqMlBBaeClfaQ60RC+ntK09vjnpPkebSc1axBb6HBbfjrV03xwhXKx9?=
 =?us-ascii?Q?886BE2CxnMXnURQ37da/xfM96T/o+S9EJYgxxXV9pZTaVpSSK5Nc7bJEQr6V?=
 =?us-ascii?Q?P1E9o135IqDMysohCe6o6x3L/r21y8wEFG+cJ2shusCS3sa1TrcoSTH/ouo2?=
 =?us-ascii?Q?GAwVhAaxmWg96oxvgfgqW/4Iu0RxKVr/xWix8VdyytQHJV07pmccgPmNF1C4?=
 =?us-ascii?Q?a8TnWrGoiXz721DlRdFIFY7E2iZ6pQUwebN+5my95zRv6JES7VltLvxhvOcF?=
 =?us-ascii?Q?/OP9k+0TgacOrunNtBGWoWdWrPIdmEouhHQ88pdL71L3L8ZhpHd0pMMzyo1h?=
 =?us-ascii?Q?qkkruTt0dchCy6Fs67Kg5Oeo/YBXImM4x8+4zDNiKETu/rkkhIJuvqeUUVK1?=
 =?us-ascii?Q?VOUpokUvBtSDkzsVAPsU2VF679kjVs6WPc9E3fcPRvXvyix8ZgxtexgCXk2x?=
 =?us-ascii?Q?ls4fzgN9pd0uRtrPPqCnCw508fLZHcwKe6vpOK82HXURPaIjGgSnaBeA3Yay?=
 =?us-ascii?Q?/X0vrMU1s6XgAHp7LRgnj2cHhPp+m+loxcgtF2fyGMqEtskPbC06FPDN1niI?=
 =?us-ascii?Q?s766l9qNf0y2wbsANRZxiBYne3dAqu4YT6J7yODW45PfTM3mwoYBw6EyqZDs?=
 =?us-ascii?Q?d8q/pAcyK9Od4WmA8WoCbgLR32yrOR+ySb3yVjF0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7138eb00-7303-43d1-2ae3-08dbb4394e36
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 09:10:42.2856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sAGT3TRfCQYaLKGOQBw+98SVfpIvV3dv8hSpfP/6ePoii7HQ1yM3x2nrfxJcFIs+gU6fpIyJ0wTuFqZob6UG9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6009

Sagi Grimberg <sagi@grimberg.me> writes:
>> +     if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
>> +             nvme_tcp_unoffload_socket(queue);
>> +#ifdef CONFIG_ULP_DDP
>> +     if (nvme_tcp_admin_queue(queue) && queue->ctrl->ddp_netdev) {
>> +             /* put back ref from get_netdev_for_sock() */
>> +             dev_put(queue->ctrl->ddp_netdev);
>> +             queue->ctrl->ddp_netdev = NULL;
>> +     }
>> +#endif
>
> Lets avoid spraying these ifdefs in the code.
> the ddp_netdev struct member can be lifted out of the ifdef I think
> because its only controller-wide.
>

Ok, we will remove the ifdefs.

>> +#ifdef CONFIG_ULP_DDP
>> +             /*
>> +              * Admin queue takes a netdev ref here, and puts it
>> +              * when the queue is stopped in __nvme_tcp_stop_queue().
>> +              */
>> +             ctrl->ddp_netdev = get_netdev_for_sock(queue->sock->sk);
>> +             if (ctrl->ddp_netdev) {
>> +                     if (nvme_tcp_ddp_query_limits(ctrl)) {
>> +                             nvme_tcp_ddp_apply_limits(ctrl);
>> +                     } else {
>> +                             dev_put(ctrl->ddp_netdev);
>> +                             ctrl->ddp_netdev = NULL;
>> +                     }
>> +             } else {
>> +                     dev_info(nctrl->device, "netdev not found\n");
>
> Would prefer to not print offload specific messages in non-offload code
> paths. at best, dev_dbg.

Sure, we will switch to dev_dbg.

> If the netdev is derived by the sk, why does the interface need a netdev
> at all? why not just pass sk and derive the netdev from the sk behind
> the interface?
>
> Or is there a case that I'm not seeing here?

If we derive the netdev from the socket, it would be too costly to call
get_netdev_for_sock() which takes a lock on the data path.

We could store it in the existing sk->ulp_ddp_ctx, assigning it in
sk_add and accessing it in sk_del/setup/teardown/resync.
But we would run into the problem of not being sure
get_netdev_for_sock() returned the same device in query_limits() and
sk_add() because we did not keep a pointer to it.

We believe it would be more complex to deal with these problems than to
just keep a reference to the netdev in the nvme-tcp controller.

Thanks

