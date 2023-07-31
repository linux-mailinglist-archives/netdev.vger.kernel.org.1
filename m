Return-Path: <netdev+bounces-22934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFAA76A1AA
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 22:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49F9F1C20CAE
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 20:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F681DDDE;
	Mon, 31 Jul 2023 20:02:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA4D19BD5
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 20:02:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E578F
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 13:02:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0FH5qPhXwf/riDcpNjkZhje9J6DgH+sT/Ar04jWnANNgj8lKNDiZopx0wkcILmk81/uegsjXS5A94vZhefYFjX7exBmyA3LaY8E97iIuUKKLp/+iBgGDYbf44vDYGCqAi7yTF9XGd/0bXOzRqvwna9reH+sOwoh1ixC5XA/JM+q3pJ49Iu8AQbLEgo4F/y5ORIJA9uNGPx2mcO/9vJALhxbJ/BrER1LnWmnufAZB9bb9MCcwN+/JSj29pKhjt8Au8VKaAud+xuMBCG5TQc4ZLLPcPNWbLK5/0/XyYC17lDiADHOFJg8sdb5Ny9KVphb/dIddT2wFnF2Yg/nmr+d6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfUCFoRcJa2koIyv3sYJCAPEKY3Rng+R/i+DN8UMM78=;
 b=dPH3hL1NSC1KGO8tbOAOOqD3q0NMRnwgzCxehHrSeYvl8eQ3N7u7LDD0VAhW4nENdForYtUQp/aFtJTkFj2ppCKo63jDZBi98RcfJj6yzslEwdZabXVp8yd2MmSSwVYKX5x4UirugAKAZtD7Tq9ToTffq+3Jf+4qAv47xO7MpSGO1LtqaqoZ6swYAAWb1HkNXwkfQd6EO1WYxWwMk4InJMpPF4VCKWqU2p72/x1S6q4Dplkt5hoWUaqq00O2FbLSxniRQQ2Ge6PdGJ9GpdL7b8gd2bvRaphwQthleFiPBmNGhbuXmajkJt76nmbY18kw4Ev0w7dtVJcvZ1QqFKkIbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfUCFoRcJa2koIyv3sYJCAPEKY3Rng+R/i+DN8UMM78=;
 b=NlDnRWt0L+x30980zudRRWx1X74g7Txvj1C4oZM/iHHXUvhAwxDXNmf8SyNOgfFXXGZM0VdQb9YvHEjtAWnqJ3VO7GGOj7hltiOGKM9ePu8a+jHNUSxd3+8FYuMh9K3qICiCZ6D7GFHnn4vGMLY46wDqdU7nM+hYbHutz2TDURhGm4Swmtdtf6wyIT9lMZGfW5TwK7IM8KUFXT8IKPJ3sYDqlATHZ/01KLmggxptJxIvsu2TntLhn4V2RYatpMyiaygOO8bKKH2kma7WdfIQxGPqKmsPbCn3WH7RNuDgxYsDPLYaHgcFaojuE0xVZAPqM7P13j8/gKyeCTPPs9pbsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW3PR12MB4377.namprd12.prod.outlook.com (2603:10b6:303:55::11)
 by CH2PR12MB4922.namprd12.prod.outlook.com (2603:10b6:610:65::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Mon, 31 Jul
 2023 20:02:22 +0000
Received: from MW3PR12MB4377.namprd12.prod.outlook.com
 ([fe80::621b:c381:1974:456e]) by MW3PR12MB4377.namprd12.prod.outlook.com
 ([fe80::621b:c381:1974:456e%4]) with mapi id 15.20.6631.026; Mon, 31 Jul 2023
 20:02:22 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Roopa Prabhu <roopa@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	netdev@vger.kernel.org
Subject: [PATCH net] vxlan: Fix nexthop hash size
Date: Mon, 31 Jul 2023 16:02:08 -0400
Message-Id: <20230731200208.61672-1-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0178.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::21) To MW3PR12MB4377.namprd12.prod.outlook.com
 (2603:10b6:303:55::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4377:EE_|CH2PR12MB4922:EE_
X-MS-Office365-Filtering-Correlation-Id: 5899c647-a4e9-470d-ae18-08db92010d42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y+hM3+oKnjSE/8LXtsW7129DRnAOqTddlZaWLMew68JS20LTGA9LNXs9dlmw1xsLKGFdYEcKxCiBFyWey8IvrGYCsSx/+R04srFYEbsGVmL0zYYOGBpslejs4fZzM7ycGphD8QaM+TdNYGA+GuWGXtZBsXkv2HdDwINjeIKxUNyRhFOZzj+m424kIHqzoKW6YjBjChYj2eG30jJcF4Py4KOvAKganGVQsWMEfpWw7BKzQI7R1wdjYvWkRSTxRvZqSgtEoLSSxZjomIk6xIEt2O5I82I5YVCq1+d0Vm5+HweAIk1l9toH7ckF7aKlJ/AsVCkeXx74U7oqiNiMqsl+yI4x85TAnU1YyOP8MxAnSnkhl3+znjTQErN9zQp8VH4D2QTEn2lnFnU6AR3DvgB88gzGRUAyAgYq4EuMfV+GzpRQwEqIcngX1berJTAG/DAlDT1+V6Vhau3PWHn1qsouJgqy1xtKwke9OxzbQrgMi32vDC38neIFFRxXNpiZV2kEkuEC1K1OC8VH4GHUr6MSZVZ/vSFrEHVtA8n6VJcUaWxOGdtezFajjIMDzWhKb5Gf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4377.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199021)(2906002)(5660300002)(8676002)(8936002)(316002)(66476007)(66556008)(4326008)(41300700001)(66946007)(6506007)(2616005)(36756003)(26005)(186003)(1076003)(38100700002)(83380400001)(6486002)(6512007)(6666004)(45080400002)(110136005)(86362001)(478600001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zmwm1Es8wH2ZjArJbv/4eEE8pG5ATx0WvplyjztaRqlB5wu+/kioy6s1ccmo?=
 =?us-ascii?Q?HeF/U7srAF6sbeBsCVWaew3WqF1jKCj2bn8UbTV4C4ZA3qlAPifzUo7N5Ypz?=
 =?us-ascii?Q?w+NemHi3zchfZlxm7UO/JdSzZ/P40UpBzvqOx92m8ELiT7rMMWl2rpv72+Z8?=
 =?us-ascii?Q?CauPbHGMRQ9Y5C3GP7lK9UuLlmz+/RKYuHOS4Dqn8N7DPEmcXjFijQURjLeo?=
 =?us-ascii?Q?fQxSShKmhLaZrC9J43iraA+c/fppxiG38PQo+bUFpINJ975DDeHfjzlPhNR0?=
 =?us-ascii?Q?qQSL7F1UCD21dqIjntztyxqMWuPCvqSN/ZEXBNG4/E7A8kQoqLtcdIRYyZRC?=
 =?us-ascii?Q?7+MnMGV1jspqo7yrTHdSy8S0vW5vf5ewrDBuwGeV6HB5x5RoZjJLfxm8i6Ac?=
 =?us-ascii?Q?9XmucVjifqM1CCOwJ8ryb9FWlcLjSbmhfSIwIPEfzqafYWXmCU5ja1yeD9jw?=
 =?us-ascii?Q?30ywg9yNni3cP7vUjXzFSz00eSHj2KoumGQepAzDjS+0/rvRm2WCqOvnSxVb?=
 =?us-ascii?Q?yv45aJ1/k2eHfVwgB7SPMzm62g+dJvhmrwlslceioEmBHscF2JJp+NzXGXJ0?=
 =?us-ascii?Q?g10+daAiKcbgCSm5iT4lu5zvMxuj+b8QEGF++9FdeMHdUH+/4SIklZp7XvR+?=
 =?us-ascii?Q?VLwvQDtPc3qZZVy0q2EhYwWUDVn8qMjisAu4BUD+qvP9MaqE7A12R328besn?=
 =?us-ascii?Q?gXeAw/96NeQCI3IQgnxEN3T/KF+yUtc53jil1zEE5+CdB/Z/xkpvygVqycWV?=
 =?us-ascii?Q?KKhk28UBZ1dICldT5o7JXs8o042opeYb549UWiM0vekOAT/QZPraQuWxrnIh?=
 =?us-ascii?Q?o+NfE8xE9EXJmEsKty9H1jvzVq23IJURvVFApWPcptrtwZQASw9/IIsTRlgq?=
 =?us-ascii?Q?ODayKTy+RIxeD9h1RQAvVG2x6vSSuS2n7DZ5yP4NaigEY7e5eGNEFtpgSxXm?=
 =?us-ascii?Q?LATFyjGdo8y8NUcfBkNbuUmnzN9HDdRLfYKKbqmPn9A6PJEPdKQuYZUusB/X?=
 =?us-ascii?Q?CGgwp9wxHBaNwSqJSSKjWzoEwXsZTVVCrWmNXERFpJ9h2++K6MzhPadPbNDj?=
 =?us-ascii?Q?NFVcBpxrUJp4uUhEX2FRYirOthf1/2pq3ERWsK2U+LkIiIhFQlRaFNh2Pghh?=
 =?us-ascii?Q?ib5ykB4kGvGkaxng12t1yE/IH/LWR6wJih0GcWlK3/g6RqVgG5nZY4TBIuaA?=
 =?us-ascii?Q?9qllADxG/8429y17i3o+Un8fp6p+ocjiLszjOs7qKICrvBj7u7blSevkLKoB?=
 =?us-ascii?Q?2xMUVRhriHtiKd1jKIr+n7V7HWXctagXJsS2op/Cbl5eu38SaE2RIjWHuE8o?=
 =?us-ascii?Q?9j2hoplCMyKSe3hrpCEG3YppUdhAAHMt7LQdday30qmns16iZPx11dbr2TuI?=
 =?us-ascii?Q?vSDtBlrvCmaGBNEYHjfwzWGeQxHvLt6+Fxux3Sq3gMOigRU8PyKMRztw7yZt?=
 =?us-ascii?Q?V3ufvrmtBxghWGohx3K8Svj/iC9zuAt2xDw9pyHb53z645L9SZvx3TD5hXiG?=
 =?us-ascii?Q?9Ssc8cvlBLncmiIz52aOUXeK1R7d2zdAm9gDjJYCl5JrkSg7HuD8A6L1iOXi?=
 =?us-ascii?Q?I+pBhq+8lJTuW0WcDe01sIrD0t7sTu/vL5XWD7b+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5899c647-a4e9-470d-ae18-08db92010d42
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4377.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 20:02:22.2784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9FfwYCDlj9uQWysMrEpo21prW3mUDfutfYrg4F9SeJ33b38ysiAXayEttmz+z5HrmXNN2bzg+eolJdXJJQXPGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4922
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The nexthop code expects a 31 bit hash, such as what is returned by
fib_multipath_hash() and rt6_multipath_hash(). Passing the 32 bit hash
returned by skb_get_hash() can lead to problems related to the fact that
'int hash' is a negative number when the MSB is set.

In the case of hash threshold nexthop groups, nexthop_select_path_hthr()
will disproportionately select the first nexthop group entry. In the case
of resilient nexthop groups, nexthop_select_path_res() may do an out of
bounds access in nh_buckets[], for example:
    hash = -912054133
    num_nh_buckets = 2
    bucket_index = 65535

which leads to the following panic:

BUG: unable to handle page fault for address: ffffc900025910c8
PGD 100000067 P4D 100000067 PUD 10026b067 PMD 0
Oops: 0002 [#1] PREEMPT SMP KASAN NOPTI
CPU: 4 PID: 856 Comm: kworker/4:3 Not tainted 6.5.0-rc2+ #34
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: ipv6_addrconf addrconf_dad_work
RIP: 0010:nexthop_select_path+0x197/0xbf0
Code: c1 e4 05 be 08 00 00 00 4c 8b 35 a4 14 7e 01 4e 8d 6c 25 00 4a 8d 7c 25 08 48 01 dd e8 c2 25 15 ff 49 8d 7d 08 e8 39 13 15 ff <4d> 89 75 08 48 89 ef e8 7d 12 15 ff 48 8b 5d 00 e8 14 55 2f 00 85
RSP: 0018:ffff88810c36f260 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00000000002000c0 RCX: ffffffffaf02dd77
RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffffc900025910c8
RBP: ffffc900025910c0 R08: 0000000000000001 R09: fffff520004b2219
R10: ffffc900025910cf R11: 31392d2068736168 R12: 00000000002000c0
R13: ffffc900025910c0 R14: 00000000fffef608 R15: ffff88811840e900
FS:  0000000000000000(0000) GS:ffff8881f7000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc900025910c8 CR3: 0000000129d00000 CR4: 0000000000750ee0
PKRU: 55555554
Call Trace:
 <TASK>
 ? __die+0x23/0x70
 ? page_fault_oops+0x1ee/0x5c0
 ? __pfx_is_prefetch.constprop.0+0x10/0x10
 ? __pfx_page_fault_oops+0x10/0x10
 ? search_bpf_extables+0xfe/0x1c0
 ? fixup_exception+0x3b/0x470
 ? exc_page_fault+0xf6/0x110
 ? asm_exc_page_fault+0x26/0x30
 ? nexthop_select_path+0x197/0xbf0
 ? nexthop_select_path+0x197/0xbf0
 ? lock_is_held_type+0xe7/0x140
 vxlan_xmit+0x5b2/0x2340
 ? __lock_acquire+0x92b/0x3370
 ? __pfx_vxlan_xmit+0x10/0x10
 ? __pfx___lock_acquire+0x10/0x10
 ? __pfx_register_lock_class+0x10/0x10
 ? skb_network_protocol+0xce/0x2d0
 ? dev_hard_start_xmit+0xca/0x350
 ? __pfx_vxlan_xmit+0x10/0x10
 dev_hard_start_xmit+0xca/0x350
 __dev_queue_xmit+0x513/0x1e20
 ? __pfx___dev_queue_xmit+0x10/0x10
 ? __pfx_lock_release+0x10/0x10
 ? mark_held_locks+0x44/0x90
 ? skb_push+0x4c/0x80
 ? eth_header+0x81/0xe0
 ? __pfx_eth_header+0x10/0x10
 ? neigh_resolve_output+0x215/0x310
 ? ip6_finish_output2+0x2ba/0xc90
 ip6_finish_output2+0x2ba/0xc90
 ? lock_release+0x236/0x3e0
 ? ip6_mtu+0xbb/0x240
 ? __pfx_ip6_finish_output2+0x10/0x10
 ? find_held_lock+0x83/0xa0
 ? lock_is_held_type+0xe7/0x140
 ip6_finish_output+0x1ee/0x780
 ip6_output+0x138/0x460
 ? __pfx_ip6_output+0x10/0x10
 ? __pfx___lock_acquire+0x10/0x10
 ? __pfx_ip6_finish_output+0x10/0x10
 NF_HOOK.constprop.0+0xc0/0x420
 ? __pfx_NF_HOOK.constprop.0+0x10/0x10
 ? ndisc_send_skb+0x2c0/0x960
 ? __pfx_lock_release+0x10/0x10
 ? __local_bh_enable_ip+0x93/0x110
 ? lock_is_held_type+0xe7/0x140
 ndisc_send_skb+0x4be/0x960
 ? __pfx_ndisc_send_skb+0x10/0x10
 ? mark_held_locks+0x65/0x90
 ? find_held_lock+0x83/0xa0
 ndisc_send_ns+0xb0/0x110
 ? __pfx_ndisc_send_ns+0x10/0x10
 addrconf_dad_work+0x631/0x8e0
 ? lock_acquire+0x180/0x3f0
 ? __pfx_addrconf_dad_work+0x10/0x10
 ? mark_held_locks+0x24/0x90
 process_one_work+0x582/0x9c0
 ? __pfx_process_one_work+0x10/0x10
 ? __pfx_do_raw_spin_lock+0x10/0x10
 ? mark_held_locks+0x24/0x90
 worker_thread+0x93/0x630
 ? __kthread_parkme+0xdc/0x100
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x1a5/0x1e0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x34/0x60
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1b/0x30
RIP: 0000:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 0000000000000000
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
CR2: ffffc900025910c8
---[ end trace 0000000000000000 ]---
RIP: 0010:nexthop_select_path+0x197/0xbf0
Code: c1 e4 05 be 08 00 00 00 4c 8b 35 a4 14 7e 01 4e 8d 6c 25 00 4a 8d 7c 25 08 48 01 dd e8 c2 25 15 ff 49 8d 7d 08 e8 39 13 15 ff <4d> 89 75 08 48 89 ef e8 7d 12 15 ff 48 8b 5d 00 e8 14 55 2f 00 85
RSP: 0018:ffff88810c36f260 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00000000002000c0 RCX: ffffffffaf02dd77
RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffffc900025910c8
RBP: ffffc900025910c0 R08: 0000000000000001 R09: fffff520004b2219
R10: ffffc900025910cf R11: 31392d2068736168 R12: 00000000002000c0
R13: ffffc900025910c0 R14: 00000000fffef608 R15: ffff88811840e900
FS:  0000000000000000(0000) GS:ffff8881f7000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000129d00000 CR4: 0000000000750ee0
PKRU: 55555554
Kernel panic - not syncing: Fatal exception in interrupt
Kernel Offset: 0x2ca00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

Fix this problem by ensuring the MSB of hash is 0 using a right shift - the
same approach used in fib_multipath_hash() and rt6_multipath_hash().

Fixes: 1274e1cc4226 ("vxlan: ecmp support for mac fdb entries")
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 include/net/vxlan.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/vxlan.h b/include/net/vxlan.h
index 1648240c9668..6a9f8a5f387c 100644
--- a/include/net/vxlan.h
+++ b/include/net/vxlan.h
@@ -556,12 +556,12 @@ static inline void vxlan_flag_attr_error(int attrtype,
 }
 
 static inline bool vxlan_fdb_nh_path_select(struct nexthop *nh,
-					    int hash,
+					    u32 hash,
 					    struct vxlan_rdst *rdst)
 {
 	struct fib_nh_common *nhc;
 
-	nhc = nexthop_path_fdb_result(nh, hash);
+	nhc = nexthop_path_fdb_result(nh, hash >> 1);
 	if (unlikely(!nhc))
 		return false;
 
-- 
2.40.1


