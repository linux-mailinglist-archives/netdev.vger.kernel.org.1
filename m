Return-Path: <netdev+bounces-29659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876FF7844EE
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 17:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93DD61C2096B
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 15:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46A71D2E9;
	Tue, 22 Aug 2023 15:04:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B99C8F45
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 15:04:53 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF58126
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 08:04:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7t1rKjvcjzc3r61nTAVWR/9tp25fAroJjEdqaLJ9qrB1SJg30VH+QsYfzdMisM6M829iTJTn0Asaig5HG06cwlbuudBjzcPiBPvw7oWKdFu8+ZbAOR2RiPwyu5TCgJxWwAevbuXuP46vGQ+437WT2TYBmPtp1a56RsEcHmDB0OC8WmT+1MbTXm03RXf51idUaFSx+pS2i5CazIFn97G7Wa5Ut6mIugZROqDbzKdppnvePRvDTnoa+GWWeQWHRKkVoNuqyjJEtPlghK9r26fv2Gsgl38m0+AfBvhu8zYxVsFeEPWHy7nCaUHbL2qbFTjfSIRKxSSXs3XMf/uO7NCAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEPUZnH3x6uP5YbjyMtxsc6NG7lpINbGU1bXfOimHwg=;
 b=Duy+ISmu8cAAo1LeosV936YbuNnhBw+S0ybOOxfP4RLa59xdjcVctRMjH3BPbyKxX7aVq5KFgEZfjYehT3ipTIS9abG1CDt3J7yl6owzmrGT54JNwZQhTskDzgLzGwxusemjzEjvhibisetIRUjjGyfQ4Ob8988MP/DE057UktSjHWHEm2Es0wWpO6sQqosAKH2dzfyUbPu175U738EyRlXWrRDJ/UI7y65zrCls2BY9idmosv2EEzJw9sKcFrq1ddPPwuduxAtFIHPmqxrCwzHXyW08ZztAuhTHuOwWxUbrj8oA47g2eK7tCSy7hAUPfgguuKXorYeNxipWlIaffA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEPUZnH3x6uP5YbjyMtxsc6NG7lpINbGU1bXfOimHwg=;
 b=tvlYOr8wNwrVgNoi1WZQbmpkxNGQD0EIYW6ujATyWml91e0A1GMewGFoyQL88tz6jp5dUw3ORP3BFfacsXr/ulx8L6QF+iosm/7nc0px8G59WmZtqX0rBdAAxniBgkBUCo9d1RAQ+zIUbBc9W6iVc96IgcidDCwMlN4kaV1D8qyhEo6xd9A6fgNifw+cg07m4zzEvlMnGyKNr6B4XtaTihSaJWm/qA9ZrXp2sLnfpWW9VPU4Rp80xCAQI6FFJBKsZcoEXwpdCoSFZQBaLjs8wNbeGn6IZtJjhAi4kJhhek0YTG0Sjoulf2yZdbemzseEWd3uzeKRsAhtckC91T/R/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by MW4PR12MB7429.namprd12.prod.outlook.com (2603:10b6:303:21b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 15:04:45 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 15:04:45 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: Aurelien Aptel <aaptel@nvidia.com>,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v13 00/24] nvme-tcp receive offloads
Date: Tue, 22 Aug 2023 15:04:01 +0000
Message-Id: <20230822150425.3390-1-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P191CA0004.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::10) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|MW4PR12MB7429:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ff4b9bd-c530-463b-2e99-08dba3211f08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UWUTgKuDUxC6SzXYzDt/R1BKRMktwUObNuJ9RzPHPwe8rSNyppSroP2q5gqGpXlA4EWUx0/PFMbhYwUlGDTjmbdkSvqxN/ghyo36vDhLo/gR2+7KuE9VV0M8bOc8o/K547DtEfse9MwH9iM8CZmwLQoMtXIRgYecepglKMXxiRuSH5SDhrN5VSG1UEiiAIN9KhvfZRsWjKwWKT6pQE26UXdAfyfoZnXo2E/7i7sQqSHhwAO8h3fjquMqtgnNk8VgeZ5yvCnvhpURxobtCzk9TIVlT/5Z9Z3RK2vdLj5lX4ywXZlIwTEH2zhZ66KcK2Ah5aj/3YgNGvpyZ9o5HJTeoitlp/itwAkbSl7amkqs36AaQen4SVhJoFd4YrfPOrMYNV6hIaxaFLXlFMXqlSvmhnoplkbT+HNExVbol5jDu9YOCwqvHJrYnuxHanEboNJBNmNNkvgfqEErkjN89QfUPK0OSHL2+IQ7ppUEPabMNa4x83LbrB9YGSiqU+YV80fys4dcecGecgdWAO1pO0NAYcTpNYjwEjlvJXTA0/mtD6qkQzIzyRm7bedhbedz9sTXKTpdQXm08bgSWwEn3wxNEsX/kVMihlFxsYGfl9H8KUzEgyclC9RUX/K9cdSZ+BfQ5WoaXJeBjzYdeKCdyT04cQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(346002)(366004)(1800799009)(186009)(451199024)(66476007)(66556008)(6512007)(316002)(66946007)(66899024)(8676002)(8936002)(2616005)(107886003)(4326008)(966005)(36756003)(41300700001)(1076003)(478600001)(6666004)(38100700002)(6486002)(6506007)(83380400001)(30864003)(2906002)(7416002)(86362001)(5660300002)(26005)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3gvYnpEeHRCdGRPWmFDU2lyeHVjYTk1M2FpdGN1VjhUWmR1Vjhqak0wV3R1?=
 =?utf-8?B?Q0VXOTFQRzlsaVdnREQ0QVFDdTZmMWh4TWdRY1BFRnJ5aGlWVGQwQjlCTkg5?=
 =?utf-8?B?Vk1nNGc5V3ZORk54OWxGOEpxSVBBMXFJUi9GWHNXbk1YOWFlbDRvYWtvSVJn?=
 =?utf-8?B?a0NrU0grZ2JRdFNNY2xvRWVGa05VczJqYzQ0TGl5WFRWOGlWZHV5Q3NhWnFn?=
 =?utf-8?B?K3NKT3pkbzJnV05qV1h5NmNwZVJqZXpnREpMbjVJZkZVbmppOWltMTZyckpp?=
 =?utf-8?B?U3prQkVVT3JaWm5Hd1ErOTBxc1ByNlhpeXNCUmNnT3VVWnF2UzdtZWNEYXZO?=
 =?utf-8?B?bTRCMzloclJWcUN5UitRSmljVkJ1MmlpU3FjajAvdEtGV2w2cDRBT055MEty?=
 =?utf-8?B?dDFVUVlNMzUrU29iV1czK096ZitKdTRWYjNRd3M3QTFndlV4RHJtQnZWVFA1?=
 =?utf-8?B?SlI5ZjhDUGFUUVA4UE5HSVdrckZIL3RkZUl4MEg5emROcSswTjkvR2t4K0lD?=
 =?utf-8?B?NmgwcmcvVmhGSG1YVklDeVkvQnhqMjgxVVE4aWpuMEdYSDNCRHR0TGJiaFpu?=
 =?utf-8?B?a0ZDMG9penhhRHN6TmY0M2I3RTM0TDlCc3pzSEJBQjJuTXlIY3pXK3FpaUZm?=
 =?utf-8?B?c2FkQWdUS1Axem1XYkVzUnJTSTMvZVYrWWg0WklVckVDbDkyemoyNEw1OEdh?=
 =?utf-8?B?RS9BM2k0N2s3Ylh5WDk2aEpTRG9PU203WDBqT3BCb202bTl1VDQwTGo5TG5H?=
 =?utf-8?B?WFFaSWNyUXBVd0RUWWdKd1R1THJ4QkN1anVndXlSRWF1YUlxaW5oR1ZROHZw?=
 =?utf-8?B?bUsxT25Ubnl4ejQySXV4VStwU3NwbnhydGNrR2dicnU5bXJNeHZIdTlrNW1U?=
 =?utf-8?B?SVVPYm4zZDEwZ25IZDBOQ3ZLSGlralNFSnMxWWlPUkFDaWJ1QThzRVlWUWNO?=
 =?utf-8?B?UDZuS0t3TGd3OFN5Ni95Mll6V2lFRmdaVlhmNzhiaGVvRk82dlRMS0lHZWN0?=
 =?utf-8?B?SHk4U2JhbjRNeGV5ajd1dDlObUhHMmt2WkVxYkNSODRldk1rRG1CV09hY1c0?=
 =?utf-8?B?RG44MUdTMDQ0M2xhZk1pKzluOWkvTDRvYmE1d1VwcjE4eWZvbXkycXRGZUIx?=
 =?utf-8?B?T1pZV2xSekJja3Yvc3FWTUVPdjFQdjJsdkdiVG9LaTQ4akNRbHhpbzd5Lzhq?=
 =?utf-8?B?dEV1NkRHY1Y5cS8wWFhZRURMaFVFaUFDaXYvRFRSUzN6TnpJY1ZtZEdyMzI4?=
 =?utf-8?B?anJzTVJSYnFGZ3hIbWhNejVoQ0ppMGdPcGUwa2xPM081YlRYS0FWelV5N1BE?=
 =?utf-8?B?NTVBbVVDTks5bGU0YmlIT2tIWUdCK2xoV3J0MEVqT2pldjdpZ3B3T0FGcEZn?=
 =?utf-8?B?dVNuYkNralcycWtZa2ZBamRxNmM0djVFUURLNi9yMVRJZi9hQWhHbHI0NnJO?=
 =?utf-8?B?dzVRUGpMRHlkMGtHSjd4NmdtWXZpUGJyZjVaczg1TG1VaHZMSVl6bjRScGcw?=
 =?utf-8?B?RmhPOXVDOUd3dnpHMmQ5RnZzNXVxYXdPZ3Nqb1BZMC9JY1RRU0xkZzBNdG1T?=
 =?utf-8?B?Njcxa1dMSHBHbFNNYUN2eElncTBpTG13a2RneEpiUGVsZDZvZXZ4UEZlZk1h?=
 =?utf-8?B?ZlhqOGlvSjNKVkhrZ2NLc3ZmNXNSOXhtazN6OE9FbWowVlFXdjB2M2l6Z3VK?=
 =?utf-8?B?NXp2ZytNZDQyMHNjM0NCUnFjODAzcjFVRWJrY2hQMWRRKzAxYXcyZTNLNlN5?=
 =?utf-8?B?dktOOVBKNEkrQkFKc3hIR0ZPTy9xYmU3Uy9hUG9scE52NWJnTWM3dlVnY3Nx?=
 =?utf-8?B?VDNRc0RWUmI1Y3ZLbXE0QTU3a0VxcHZKL05PNGtxUjQ0SGRUWnNIcGE0RDc0?=
 =?utf-8?B?NW9kOFpITjg2VGRZNlhYMkd6OUJhWkRuQVU0TjB5SlJ2WWJxU0lqUkN6UUMz?=
 =?utf-8?B?TC9NWUt5SFdBTlBIeTc5bFd3RkZGT3duRVk1R1R5S2FNZGtGWmtxY1h1Z1BE?=
 =?utf-8?B?L0NSQmxacDAvdU02b0kyWjdYL1ZXcU5RV0JwbjVmVEhxZlhYRVVnekFaSjNF?=
 =?utf-8?B?TjBGd0V6My9BaE1KTlhGWXB6SnlBQjZWTXZtWnZ4YVNUVjVuRUIyYks4Qlgr?=
 =?utf-8?Q?ZPgGwCJsrjIbsicR/VJBeUmqg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff4b9bd-c530-463b-2e99-08dba3211f08
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 15:04:45.6751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2E9iCQQTlnWjlFCxR9UAYGvBR7PEOJqkVKX7mGSZL12Vqp3wdpWmakHXduuiArw6XRdCBeAMhP5NASKiaBMHTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7429
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

The next iteration of our nvme-tcp receive offload series.
This submission was rebased on top of net-next, and on top of
the NVMe-TCP TLS implementation v10.
https://lore.kernel.org/all/20230816120608.37135-1-hare@suse.de/

The changes are based on the comments from Sagi Grimberg.

The changes are also available through git:
Repo: https://github.com/aaptel/linux.git branch nvme-rx-offload-v13
Web: https://github.com/aaptel/linux/tree/nvme-rx-offload-v13

The NVMe-TCP offload was presented in netdev 0x16 (video available):
- https://netdevconf.info/0x16/session.html?NVMeTCP-Offload-%E2%80%93-Implementation-and-Performance-Gains
- https://youtu.be/W74TR-SNgi4

From: Aurelien Aptel <aaptel@nvidia.com>
From: Shai Malin <smalin@nvidia.com>
From: Boris Pismenny <borisp@nvidia.com>
From: Or Gerlitz <ogerlitz@nvidia.com>
From: Yoray Zack <yorayz@nvidia.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>

=========================================

This series adds support for NVMe-TCP receive offloads. The method here
does not mandate the offload of the network stack to the device.
Instead, these work together with TCP to offload:
1. copy from SKB to the block layer buffers.
2. CRC calculation and verification for received PDU.

The series implements these as a generic offload infrastructure for storage
protocols, which calls TCP Direct Data Placement and TCP Offload CRC
respectively. We use this infrastructure to implement NVMe-TCP offload for
copy and CRC.
Future implementations can reuse the same infrastructure for other protocols
such as iSCSI.

Note:
These offloads are similar in nature to the packet-based NIC TLS offloads,
which are already upstream (see net/tls/tls_device.c).
You can read more about TLS offload here:
https://www.kernel.org/doc/html/latest/networking/tls-offload.html

Queue Level
===========
The offload for IO queues is initialized after the handshake of the
NVMe-TCP protocol is finished by calling `nvme_tcp_offload_socket`
with the tcp socket of the nvme_tcp_queue:
This operation sets all relevant hardware contexts in
hardware. If it fails, then the IO queue proceeds as usual with no offload.
If it succeeds then `nvme_tcp_setup_ddp` and `nvme_tcp_teardown_ddp` may be
called to perform copy offload, and crc offload will be used.
This initialization does not change the normal operation of NVMe-TCP in any
way besides adding the option to call the above mentioned NDO operations.

For the admin queue, NVMe-TCP does not initialize the offload.
Instead, NVMe-TCP calls the driver to configure limits for the controller,
such as max_hw_sectors and max_segments, these must be limited to accommodate
potential HW resource limits, and to improve performance.

If some error occurs, and the IO queue must be closed or reconnected, then
offload is teardown and initialized again. Additionally, we handle netdev
down events via the existing error recovery flow.

IO Level
========
The NVMe-TCP layer calls the NIC driver to map block layer buffers to CID
using `nvme_tcp_setup_ddp` before sending the read request. When the response
is received, then the NIC HW will write the PDU payload directly into the
designated buffer, and build an SKB such that it points into the destination
buffer. This SKB represents the entire packet received on the wire, but it
points to the block layer buffers. Once NVMe-TCP attempts to copy data from
this SKB to the block layer buffer it can skip the copy by checking in the
copying function: if (src == dst) -> skip copy

Finally, when the PDU has been processed to completion, the NVMe-TCP layer
releases the NIC HW context by calling `nvme_tcp_teardown_ddp` which
asynchronously unmaps the buffers from NIC HW.

The NIC must release its mapping between command IDs and the target buffers.
This mapping is released when NVMe-TCP calls the NIC
driver (`nvme_tcp_offload_socket`).
As completing IOs is performance critical, we introduce asynchronous
completions for NVMe-TCP, i.e. NVMe-TCP calls the NIC, which will later
call NVMe-TCP to complete the IO (`nvme_tcp_ddp_teardown_done`).

On the IO level, and in order to use the offload only when a clear
performance improvement is expected, the offload is used only for IOs
which are bigger than io_threshold.

SKB
===
The DDP (zero-copy) and CRC offloads require two additional bits in the SKB.
The ddp bit is useful to prevent condensing of SKBs which are targeted
for zero-copy. The crc bit is useful to prevent GRO coalescing SKBs with
different offload values. This bit is similar in concept to the
"decrypted" bit.

After offload is initialized, we use the SKB's crc bit to indicate that:
"there was no problem with the verification of all CRC fields in this packet's
payload". The bit is set to zero if there was an error, or if HW skipped
offload for some reason. If *any* SKB in a PDU has (crc != 1), then the
calling driver must compute the CRC, and check it. We perform this check, and
accompanying software fallback at the end of the processing of a received PDU.

Resynchronization flow
======================
The resynchronization flow is performed to reset the hardware tracking of
NVMe-TCP PDUs within the TCP stream. The flow consists of a request from
the hardware proxied by the driver, regarding a possible location of a
PDU header. Followed by a response from the NVMe-TCP driver.

This flow is rare, and it should happen only after packet loss or
reordering events that involve NVMe-TCP PDU headers.

CID Mapping
===========
ConnectX-7 assumes linear CID (0...N-1 for queue of size N) where the Linux NVMe
driver uses part of the 16 bit CCID for generation counter.
To address that, we use the existing quirk in the NVMe layer when the HW
driver advertises that they don't support the full 16 bit CCID range.

Enablement on ConnectX-7
========================
By default, NVMeTCP offload is disabled in the mlx driver and in the nvme-tcp host.
In order to enable it:

        # Disable CQE compression (specific for ConnectX)
        ethtool --set-priv-flags <device> rx_cqe_compress off

        # Enable the ULP-DDP
        ethtool --ulp-ddp <device> nvme-tcp-ddp on nvme-tcp-ddgst-rx-offload on

        # Enable ULP offload in nvme-tcp
        modprobe nvme-tcp ddp_offload=1

Following the device ULP-DDP enablement, all the IO queues/sockets which are
running on the device are offloaded.

This feature requires a patched ethtool that can be obtained from
Web: https://github.com/aaptel/ethtool/tree/ulp-ddp
Git: https://github.com/aaptel/ethtool.git
Branch: ulp-ddp

Performance
===========
With this implementation, using the ConnectX-7 NIC, we were able to
demonstrate the following CPU utilization improvement:

Without data digest:
For  64K queued read IOs – up to 32% improvement in the BW/IOPS (111 Gbps vs. 84 Gbps).
For 512K queued read IOs – up to 55% improvement in the BW/IOPS (148 Gbps vs. 98 Gbps).

With data digest:
For  64K queued read IOs – up to 107% improvement in the BW/IOPS (111 Gbps vs. 53 Gbps).
For 512K queued read IOs – up to 138% improvement in the BW/IOPS (146 Gbps vs. 61 Gbps).

With small IOs we are not expecting that the offload will show a performance gain.

The test configuration:
- fio command: qd=128, jobs=8.
- Server: Intel(R) Xeon(R) Platinum 8380 CPU @ 2.30GHz, 160 cores.

Patches
=======
Patch 1:  Introduce the infrastructure for all ULP DDP and ULP DDP CRC offloads.
Patch 2:  Add ethtool string sets for ULP DDP capability names and stats names.
Patch 3:  Add ethtool operations to get/set ULP DDP capabilities and statistics.
Patch 4:  Documentation of ULP DDP ethtool netlink messages.
Patch 5:  The iov_iter change to skip copy if (src == dst).
Patch 6:  Export the get_netdev_for_sock function from TLS to generic location.
Patch 7:  NVMe-TCP changes to call NIC driver on queue init/teardown and resync.
Patch 8:  NVMe-TCP changes to call NIC driver on IO operation
          setup/teardown, and support async completions.
Patch 9:  NVMe-TCP changes to support CRC offload on receive
          Also, this patch moves CRC calculation to the end of PDU
          in case offload requires software fallback.
Patch 10: NVMe-TCP handling of netdev events: stop the offload if netdev is
          going down.
Patch 11: Documentation of ULP DDP offloads.

The rest of the series is the mlx5 implementation of the offload.

Testing
=======
This series was tested on ConnectX-7 HW using various configurations
of IO sizes, queue depths, MTUs, and with both the SPDK and kernel NVMe-TCP
targets.

Compatibility
=============
* The offload works with bare-metal or SRIOV.
* The HW can support up to 64K connections per device (assuming no
  other HW accelerations are used). In this series, we will introduce
  the support for up to 4k connections, and we have plans to increase it.
* In the current HW implementation, the combination of NVMeTCP offload
  with TLS is not supported. In the future, if it will be implemented,
  the impact on the NVMe/TCP layer will be minimal.
* The NVMeTCP offload ConnectX 7 HW can support tunneling, but we
  don't see the need for this feature yet.
* NVMe poll queues are not in the scope of this series.

Future Work
===========
* NVMeTCP transmit offload.
* NVMeTCP offloads incremental features.

Changes since v12:
=================
- Rebase on top of NVMe-TCP kTLS v10 patches.
- Add ULP DDP wrappers for common code and ref accounting (Sagi).
- Fold modparam and tls patches into control-path patch (Sagi).
- Take one netdev ref for the admin queue (Sagi).
- Simplify start_queue() logic (Sagi).
- Rename
  * modparam ulp_offload modparam -> ddp_offload (Sagi).
  * queue->offload_xxx to queue->ddp_xxx (Sagi).
  * queue->resync_req -> resync_tcp_seq (Sagi).
- Use SECTOR_SHIFT (Sagi).
- Use nvme_cid(rq) (Sagi).
- Use sock->sk->sk_incoming_cpu instead of queue->io_cpu (Sagi).
- Move limits results to ctrl struct.
- Add missing ifdefs.
- Fix docs and reverse xmas tree (Simon).

Changes since v11:
=================
- Rebase on top of NVMe-TCP kTLS offload.
- Add tls support bit in struct ulp_ddp_limits.
- Simplify logic in NVMe-TCP queue init.
- Use new page pool in mlx5 driver.

Changes since v10:
=================
- Pass extack to drivers for better error reporting in the .set_caps
  callback (Jakub).
- netlink: use new callbacks, existing macros, padding, fix size
  add notifications, update specs (Jakub).

Changes since v9:
=================
- Add missing crc checks in tcp_try_coalesce() (Paolo).
- Add missing ifdef guard for socket ops (Paolo).
- Remove verbose netlink format for statistics (Jakub).
- Use regular attributes for statistics (Jakub).
- Expose and document individual stats to uAPI (Jakub).
- Move ethtool ops for caps&stats to netdev_ops->ulp_ddp_ops (Jakub).

Changes since v8:
=================
- Make stats stringset global instead of per-device (Jakub).
- Remove per-queue stats (Jakub).
- Rename ETH_SS_ULP_DDP stringset to ETH_SS_ULP_DDP_CAPS.
- Update & fix kdoc comments.
- Use 80 columns limit for nvme code.

Changes since v7:
=================
- Remove ULP DDP netdev->feature bit (Jakub).
- Expose ULP DDP capabilities to userspace via ethtool netlink messages (Jakub).
- Move ULP DDP stats to dedicated stats group (Jakub).
- Add ethtool_ops operations for setting capabilities and getting stats (Jakub).
- Move ulp_ddp_netdev_ops into net_device_ops (Jakub).
- Use union for protocol-specific struct instances (Jakub).
- Fold netdev_sk_get_lowest_dev() into get_netdev_for_sock (Christoph).
- Rename memcpy skip patch to something more obvious (Christoph).
- Move capabilities from ulp_ddp.h to ulp_ddp_caps.h.
- Add "Compatibility" section on the cover letter (Sagi).

Changes since v6:
=================
- Moved IS_ULP_{DDP,CRC} macros to skb_is_ulp_{ddp,crc} inline functions (Jakub).
- Fix copyright notice (Leon).
- Added missing ifdef to allow build with MLX5_EN_TLS disabled.
- Fix space alignment, indent and long lines (max 99 columns).
- Add missing field documentation in ulp_ddp.h.

Changes since v5:
=================
- Limit the series to RX offloads.
- Added two separated skb indications to avoid wrong flushing of GRO
  when aggerating offloaded packets.
- Use accessor functions for skb->ddp and skb->crc (Eric D) bits.
- Add kernel-doc for get_netdev_for_sock (Christoph).
- Remove ddp_iter* routines and only modify _copy_to_iter (Al Viro, Christoph).
- Remove consume skb (Sagi).
- Add a knob in the ddp limits struct for the HW driver to advertise
  if they need the nvme-tcp driver to apply the generation counter
  quirk. Use this knob for the mlx5 CX7 offload.
- bugfix: use u8 flags instead of bool in mlx5e_nvmeotcp_queue->dgst.
- bugfix: use sg_dma_len(sgl) instead of sgl->length.
- bugfix: remove sgl leak in nvme_tcp_setup_ddp().
- bugfix: remove sgl leak when only using DDGST_RX offload.
- Add error check for dma_map_sg().
- Reduce #ifdef by using dummy macros/functions.
- Remove redundant netdev null check in nvme_tcp_pdu_last_send().
- Rename ULP_DDP_RESYNC_{REQ -> PENDING}.
- Add per-ulp limits struct (Sagi).
- Add ULP DDP capabilities querying (Sagi).
- Simplify RX DDGST logic (Sagi).
- Document resync flow better.
- Add ulp_offload param to nvme-tcp module to enable ULP offload (Sagi).
- Add a revert commit to reintroduce nvme_tcp_queue->queue_size.

Changes since v4:
=================
- Add transmit offload patches.
- Use one feature bit for both receive and transmit offload.

Changes since v3:
=================
- Use DDP_TCP ifdefs in iov_iter and skb iterators to minimize impact
  when compiled out (Christoph).
- Simplify netdev references and reduce the use of
  get_netdev_for_sock (Sagi).
- Avoid "static" in it's own line, move it one line down (Christoph)
- Pass (queue, skb, *offset) and retrieve the pdu_seq in
  nvme_tcp_resync_response (Sagi).
- Add missing assignment of offloading_netdev to null in offload_limits
  error case (Sagi).
- Set req->offloaded = false once -- the lifetime rules are:
  set to false on cmd_setup / set to true when ddp setup succeeds (Sagi).
- Replace pr_info_ratelimited with dev_info_ratelimited (Sagi).
- Add nvme_tcp_complete_request and invoke it from two similar call
  sites (Sagi).
- Introduce nvme_tcp_req_map_sg earlier in the series (Sagi).
- Add nvme_tcp_consume_skb and put into it a hunk from
  nvme_tcp_recv_data to handle copy with and without offload.

Changes since v2:
=================
- Use skb->ddp_crc for copy offload to avoid skb_condense.
- Default mellanox driver support to no (experimental feature).
- In iov_iter use non-ddp functions for kvec and iovec.
- Remove typecasting in NVMe-TCP.

Changes since v1:
=================
- Rework iov_iter copy skip if src==dst to be less intrusive (David Ahern).
- Add tcp-ddp documentation (David Ahern).
- Refactor mellanox driver patches into more patches (Saeed Mahameed).
- Avoid pointer casting (David Ahern).
- Rename NVMe-TCP offload flags (Shai Malin).
- Update cover-letter according to the above.

Changes since RFC v1:
=====================
- Split mlx5 driver patches to several commits.
- Fix NVMe-TCP handling of recovery flows. In particular, move queue offload.
  init/teardown to the start/stop functions.

Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>


Aurelien Aptel (5):
  net/ethtool: add new stringset ETH_SS_ULP_DDP_{CAPS,STATS}
  net/ethtool: add ULP_DDP_{GET,SET} operations for caps and stats
  Documentation: document netlink ULP_DDP_GET/SET messages
  net/tls,core: export get_netdev_for_sock
  net/mlx5e: NVMEoTCP, statistics

Ben Ben-Ishay (8):
  iov_iter: skip copy if src == dst for direct data placement
  net/mlx5: Add NVMEoTCP caps, HW bits, 128B CQE and enumerations
  net/mlx5e: NVMEoTCP, offload initialization
  net/mlx5e: NVMEoTCP, use KLM UMRs for buffer registration
  net/mlx5e: NVMEoTCP, queue init/teardown
  net/mlx5e: NVMEoTCP, ddp setup and resync
  net/mlx5e: NVMEoTCP, async ddp invalidation
  net/mlx5e: NVMEoTCP, data-path for DDP+DDGST offload

Boris Pismenny (4):
  net: Introduce direct data placement tcp offload
  nvme-tcp: Add DDP offload control path
  nvme-tcp: Add DDP data-path
  net/mlx5e: TCP flow steering for nvme-tcp acceleration

Or Gerlitz (5):
  nvme-tcp: Deal with netdevice DOWN events
  net/mlx5e: Rename from tls to transport static params
  net/mlx5e: Refactor ico sq polling to get budget
  net/mlx5e: Have mdev pointer directly on the icosq structure
  net/mlx5e: Refactor doorbell function to allow avoiding a completion

Yoray Zack (2):
  nvme-tcp: RX DDGST offload
  Documentation: add ULP DDP offload documentation

 Documentation/netlink/specs/ethtool.yaml      |  102 ++
 Documentation/networking/ethtool-netlink.rst  |   92 ++
 Documentation/networking/index.rst            |    1 +
 Documentation/networking/statistics.rst       |    1 +
 Documentation/networking/ulp-ddp-offload.rst  |  378 ++++++
 .../net/ethernet/mellanox/mlx5/core/Kconfig   |   11 +
 .../net/ethernet/mellanox/mlx5/core/Makefile  |    3 +
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |    9 +
 .../net/ethernet/mellanox/mlx5/core/en/fs.h   |    4 +-
 .../ethernet/mellanox/mlx5/core/en/params.c   |   12 +-
 .../ethernet/mellanox/mlx5/core/en/params.h   |    3 +
 .../mellanox/mlx5/core/en/reporter_rx.c       |    4 +-
 .../ethernet/mellanox/mlx5/core/en/rx_res.c   |   28 +
 .../ethernet/mellanox/mlx5/core/en/rx_res.h   |    4 +
 .../net/ethernet/mellanox/mlx5/core/en/tir.c  |   15 +
 .../net/ethernet/mellanox/mlx5/core/en/tir.h  |    2 +
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |   34 +-
 .../mlx5/core/en_accel/common_utils.h         |   32 +
 .../mellanox/mlx5/core/en_accel/en_accel.h    |    3 +
 .../mellanox/mlx5/core/en_accel/fs_tcp.c      |   12 +-
 .../mellanox/mlx5/core/en_accel/fs_tcp.h      |    2 +-
 .../mellanox/mlx5/core/en_accel/ktls.c        |    2 +-
 .../mellanox/mlx5/core/en_accel/ktls_rx.c     |    8 +-
 .../mellanox/mlx5/core/en_accel/ktls_tx.c     |    8 +-
 .../mellanox/mlx5/core/en_accel/ktls_txrx.c   |   36 +-
 .../mellanox/mlx5/core/en_accel/ktls_utils.h  |   17 +-
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 1117 +++++++++++++++++
 .../mellanox/mlx5/core/en_accel/nvmeotcp.h    |  142 +++
 .../mlx5/core/en_accel/nvmeotcp_rxtx.c        |  354 ++++++
 .../mlx5/core/en_accel/nvmeotcp_rxtx.h        |   37 +
 .../mlx5/core/en_accel/nvmeotcp_stats.c       |   66 +
 .../mlx5/core/en_accel/nvmeotcp_utils.h       |   66 +
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |    6 +
 .../net/ethernet/mellanox/mlx5/core/en_fs.c   |    4 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   30 +-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |   71 +-
 .../ethernet/mellanox/mlx5/core/en_stats.h    |    7 +
 .../net/ethernet/mellanox/mlx5/core/en_txrx.c |    4 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw.c  |    6 +
 .../net/ethernet/mellanox/mlx5/core/main.c    |    1 +
 drivers/nvme/host/tcp.c                       |  460 ++++++-
 include/linux/ethtool.h                       |   32 +
 include/linux/mlx5/device.h                   |   59 +-
 include/linux/mlx5/mlx5_ifc.h                 |   83 +-
 include/linux/mlx5/qp.h                       |    1 +
 include/linux/netdevice.h                     |   18 +-
 include/linux/skbuff.h                        |   25 +-
 include/net/inet_connection_sock.h            |    6 +
 include/net/ulp_ddp.h                         |  262 ++++
 include/net/ulp_ddp_caps.h                    |   35 +
 include/uapi/linux/ethtool.h                  |    4 +
 include/uapi/linux/ethtool_netlink.h          |   40 +
 lib/iov_iter.c                                |    8 +-
 net/Kconfig                                   |   20 +
 net/core/Makefile                             |    1 +
 net/core/dev.c                                |   26 +-
 net/core/skbuff.c                             |    3 +-
 net/core/ulp_ddp.c                            |   70 ++
 net/ethtool/Makefile                          |    2 +-
 net/ethtool/bitset.c                          |   20 +-
 net/ethtool/common.c                          |   23 +
 net/ethtool/common.h                          |    2 +
 net/ethtool/netlink.c                         |   20 +
 net/ethtool/netlink.h                         |    4 +
 net/ethtool/strset.c                          |   11 +
 net/ethtool/ulp_ddp.c                         |  316 +++++
 net/ipv4/tcp_input.c                          |   13 +-
 net/ipv4/tcp_ipv4.c                           |    3 +
 net/ipv4/tcp_offload.c                        |    3 +
 net/tls/tls_device.c                          |   16 -
 70 files changed, 4157 insertions(+), 163 deletions(-)
 create mode 100644 Documentation/networking/ulp-ddp-offload.rst
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/common_utils.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_stats.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_utils.h
 create mode 100644 include/net/ulp_ddp.h
 create mode 100644 include/net/ulp_ddp_caps.h
 create mode 100644 net/core/ulp_ddp.c
 create mode 100644 net/ethtool/ulp_ddp.c

-- 
2.34.1


