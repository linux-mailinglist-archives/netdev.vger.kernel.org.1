Return-Path: <netdev+bounces-58657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C6B817B91
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 21:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9C99B23814
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 20:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843A871478;
	Mon, 18 Dec 2023 20:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bl4ZPNYl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B065371456
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 20:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJKyTBh5HB3ywunQtBQmelh2NurBIhXBF93tHgrfB6lU5EzkSB7WvLsdiJtu0UQzboIFFpdlHr6qQqnXq0gSseYutPxIET5Ys9b+daQkdswv9/P2mybIQhz+SLpauICWwzX3Bw5VOSRqprssIJ4ndhBIxLGl+yU1B3K9OrlQjAu7VDoLwhEG4/wxbsm6ThtpHHk7jPOcszkT7FRb+DnadPw1BuVLspZZpJmMGjJp798yHxy8SkVaMc1SyDFu5mTOE4cu7Sc1X2ZEiPrV0GTRWJbm6ZCtvEX4ZjvQYXyOtuA/S/do13DMRDZrabM2/VotVndbxPpOTs+v2e2Naj9v+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9gmR96LGGGVCP7fht61wEJ2JtB14JGftbQQa1M115Q=;
 b=C6MXpqDTiZKkvavv75Xad+SWykjW8kqf30i6H6klqjS4Xm9ZC3gOD0UBULdfpBDWNpClKLtH4h+DnLoMdzcSCJupkX4g0FGCirGBFIgfq7bSktwCguBWRegkuEP8sKzAZucvRrNgJzxKWjshnFAN+kl4pmSnKuNJfzco2RN4n7Rp7ZqRHomJPi7nj4BWlpnkpsZTBn4U7j18Bf0s+3iNiH9t1/wvevGSqfI9c4TKqPpL/KxMzWozeD3jGlg4r+F9lgB+Z0tULZaprfkf8Xbn1FrzvEYQe5gauSssF9PcxFWSlWl+tqlQiK3/wIEnH6IV7L1i3y2aYIf3cb24fDaGTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9gmR96LGGGVCP7fht61wEJ2JtB14JGftbQQa1M115Q=;
 b=bl4ZPNYlom7nuXjagZtFzkvB5LHmaG8AFMKiw2ZRYAN8c7GDtxiCCt2HEi2ZK7rOYwda7EaSMsJflxCgTG88NeO4eVgKCug8aji2V5D1UFzq6uJXJodmfVpdwdcuDvi2JhWmfRzs2Cz/GnLa+kguguG2fRzAg2CvXMmYfXqC8GJAy6IfF6jc3HkkOk8Ia8Tpd74b5JFRZ5RTbNWnT/IXRKXtx+oovxOFhYFgXqxeUOTV4fS3clYS7ekX8d3jWa8WQ577wFkXfCEoRLqE7RodHtX410U4cuOXGhZXWwMCUOKU9MprI5hV675AC66u3dJOvLa4XchqvO7cloWbqrH+QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DM4PR12MB6616.namprd12.prod.outlook.com (2603:10b6:8:8e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 20:00:51 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 20:00:50 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
 axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, brauner@kernel.org
Subject: Re: [PATCH v21 05/20] nvme-tcp: Add DDP offload control path
In-Reply-To: <51446197-3791-dc89-5772-1496b768cd4d@nvidia.com>
References: <20231214132623.119227-1-aaptel@nvidia.com>
 <20231214132623.119227-6-aaptel@nvidia.com>
 <51446197-3791-dc89-5772-1496b768cd4d@nvidia.com>
Date: Mon, 18 Dec 2023 22:00:46 +0200
Message-ID: <2535y0vi8lt.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0037.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::6) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DM4PR12MB6616:EE_
X-MS-Office365-Filtering-Correlation-Id: 6035e157-bd8c-4203-38e2-08dc000408ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uT87WqakvQZlQ2hqxYwv5Up/v+ACu1JTacqBglZRrAqBgoXbNaDEgQwo6w2FCrsUOum2ZhM+FYpf9swM0yoaT+Na6r57Bcc85v2LUnCYMwRGMTxhqHloA+dGqmM+1oWBhC8eKbYri5LCBVytrd3qQpptiBlZWGEJlueihRVDbSothHLhnTV2h6wUgRB1ZIbAyM+bxo6WG0nzBwsJAeTefY4tnLSD0NHzINSTgCv6ZHcjYQ/wvotRpIQ3IL9cf5nClP0sCkPDV9BjNH/v1l5Lss+pyt0EKI0N+w97OF5Zi60oD6GJMcHigVYw0i6jB9axDo1NUUuHnnvKoJQV4jkB6afh/TSQogrpgrfBXVedz1mLYOA3D8s38MSMTNCQilDpZAoQat0UM9oNTUo8YgqMlAa9XkYaEGEarGn5JZ6Ghm+8HriOnGwgDTM2WBTRpEEppfG9D2o34/bqge/YkP/YSHpUAvcP9zgMlZXeSzkXWpOwlvtNtDc6S7TCBw/V95hLna9UnkhCjTlsvRVilMiNuvXydeufi5G5TbL/QoQkqQu2SHGhyLuYpYVj05JXpZwD5lneOHza14r0xuAiGOPNMFOTK+RzE4FgDP2FJKuVCfI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(39860400002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(2906002)(7416002)(5660300002)(921008)(36756003)(41300700001)(86362001)(38100700002)(26005)(6486002)(2616005)(83380400001)(66946007)(66556008)(66476007)(478600001)(316002)(6506007)(6512007)(6666004)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?96bg7hRgBiyAZv07FfoqD62RGI1+OUmtUGNZQ5/7ypHAYxEjHwrNV3sVESOS?=
 =?us-ascii?Q?4O1tQRKrTn1GDiwXYklVa8D4g3wkJY83C+sTceYjSseA7dAhjJG2wDOyBPIh?=
 =?us-ascii?Q?1v0xn19pEP5c4/EiRIqYSqpa+X/NaWh5O72zBqdCJR4AOFML5SRM2IvxPsv+?=
 =?us-ascii?Q?eqSlHSZFQN4/UpeEnz6L6tunegeMbPaqbgbbz3ns/YFFt1yL63um5XNlRNAB?=
 =?us-ascii?Q?PXGwkl4ix9KplJ7jLksPhVBLS6oNJ0rYAAwsyFMkzJDfQx/3nMUg3J4w1lIa?=
 =?us-ascii?Q?qKZV4tK0hdLLptXDKhQ2r3ZftHATH84d4vJTV+d93GftGovDD8QKi1+J0l1b?=
 =?us-ascii?Q?lBs+nYfIc+xwF9TOrMjhbQ0rfgsNO1GxbL4TuLKftoKochcA2XAwwsKrZmV5?=
 =?us-ascii?Q?L/4zJeVz86rA9bRHbzmqgz/3fnifdOD1VyapUpu790QEZfxl0zx8iU+eHom6?=
 =?us-ascii?Q?8SfyxDJ498Uwrc4z3GNZ/sT8idqAvoFy76jU8kEM0NvvfED4uMhMPI0kDdXn?=
 =?us-ascii?Q?wHdoq4Z2EbEQfPhoPOzGjuMGu3wVCfksHYE6NWytCKQ6mkvv1vuxtQuY+QGw?=
 =?us-ascii?Q?UWZmuh0xL1A1LGrjz0WW4p+Iw3atuh4vKq6RfNjt7TTt+7o7mxySJ1FqixS3?=
 =?us-ascii?Q?RxmhNo5lylzrSORJz3unOUaRv8rja1cjmW3PwO2wIyTtzRJgEZr2YmZ+E/uJ?=
 =?us-ascii?Q?Oa4wxY1OLikPXC1FU2l9nIYNz2KNYsUR7z9SpgSnuqbKPNZfCAmJ2BrO/mJ5?=
 =?us-ascii?Q?WVgCDumbBSvt5m2IkPsAZZIkW39K1Li9VkgC5jqQID1e7XwElLfxBoHZBZUL?=
 =?us-ascii?Q?9OuVtmEdm6XvG5m2tkJGynVzHFXg0y3wOoWMju+ENxTXRKNiB33FNz+chxn1?=
 =?us-ascii?Q?rGz8LY0JjwM6afrDf7XpPKIYwvCW+SZFHC2t4QSHIj3cxZppn9acVR1qsn7l?=
 =?us-ascii?Q?8UxB2umd2DxJI3cj5ro/PlrchgqzOwa/Xm3YXXLvYIIOVJX+vddqwCL6RaYi?=
 =?us-ascii?Q?cwS5iwwsTUuq7mdMXA6E0oreRdYPfhmPc7lLeUc94kfntQtYX58M2UVhrN2m?=
 =?us-ascii?Q?6T37SeP+5xwcr5SG8b7JrKQGzCEdJU4nOB6SpYPYy+lhkb1jIk6McUKNAkf/?=
 =?us-ascii?Q?yKjV2OcqPMy6C/A4aLuTqLXkUzkGQViYzMCisdvX7WnKAutvWv7QRR4cgNhh?=
 =?us-ascii?Q?PDavlZNbed2vgtjDyI/5V/klYXk86plGRUaJv1+tHT/ZKmdkeYXcN8SPOvtJ?=
 =?us-ascii?Q?WCqLtioyoIR+SlDzSpBvD5JHPJ4WBePcDag7l2M14f1x029/PFKRld96mmL4?=
 =?us-ascii?Q?RIGeqpjNnyPAkfohMp6JkGc8U8ihWsyAt50ZPmaLRec3JU1V17hgH10qp/UC?=
 =?us-ascii?Q?S8jLmO58QDKNnfJkfhIae+SWtAzaQOp54hThMMzEpL5etrL9c9lt7cNS3SeH?=
 =?us-ascii?Q?63TNwpdYZnNjtTMl9jLICOi6pmlHXNHuQvlOLuUMwjiboGRIt6P8NUG6+WUp?=
 =?us-ascii?Q?0f1egaIH3xYMQhVCIkoNmd3rpYBzAzKyySf3aBowwXGDtt/Yq4pN4OTR49lq?=
 =?us-ascii?Q?43Ps52hSA4BE/2KaiYCPyHstClxkj7RQzQwxcrOM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6035e157-bd8c-4203-38e2-08dc000408ac
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 20:00:50.7156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uFqxq0dUhnV1xLUMAgEVaHMH8dmhSNsVErkY5W0t5CZHy3RDhVRXnkdAHUUNWfgEWARMi6boCM/EPrLAnnjZcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6616

Max Gurtovoy <mgurtovoy@nvidia.com> writes:
>> @@ -739,6 +937,9 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>>   	size_t rcv_len = min_t(size_t, *len, queue->pdu_remaining);
>>   	int ret;
>>   
>> +	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
>> +		nvme_tcp_resync_response(queue, skb, *offset);
>
> lets try to optimize the fast path with:
>
> if (IS_ENABLED(CONFIG_ULP_DDP) && test_bit(NVME_TCP_Q_OFF_DDP, 
> &queue->flags))
>      nvme_tcp_resync_response(queue, skb, *offset);
>

For this one, when ULP_DDP is disabled, I do see 1 extra mov instruction
but no branching... I think it's negligible personally.

$ gdb drivers/nvme/host/nvme-tcp.ko
(gdb) disass /s nvme_tcp_recv_skb
...
1088    static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
1089                    unsigned int *offset, size_t *len)
1090    {
1091            struct nvme_tcp_hdr *hdr;
1092            char *pdu = queue->pdu;
   0x00000000000046a6 <+118>:   mov    %rsi,-0x70(%rbp)

880             return  (queue->pdu_remaining) ? NVME_TCP_RECV_PDU :
   0x00000000000046aa <+122>:   test   %ebx,%ebx
   0x00000000000046ac <+124>:   je     0x4975 <nvme_tcp_recv_skb+837>

1093            size_t rcv_len = min_t(size_t, *len, queue->pdu_remaining);
   0x00000000000046b2 <+130>:   cmp    %r14,%rbx

1100                    &pdu[queue->pdu_offset], rcv_len);
   0x00000000000046b5 <+133>:   movslq 0x19c(%r12),%rdx

1099            ret = skb_copy_bits(skb, *offset,
   0x00000000000046bd <+141>:   mov    -0x58(%rbp),%rdi

1093            size_t rcv_len = min_t(size_t, *len, queue->pdu_remaining);
   0x00000000000046c1 <+145>:   cmova  %r14,%rbx

./arch/x86/include/asm/bitops.h:
205             return ((1UL << (nr & (BITS_PER_LONG-1)))
   0x00000000000046c5 <+149>:   mov    0x1d8(%r12),%rax

Extra mov of queue->flags offset here ^^^^^^^^

  (gdb) p &((struct nvme_tcp_queue *)0)->flags
  $1 = (unsigned long *) 0x1d8

