Return-Path: <netdev+bounces-36855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4967B208C
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 17:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 00B261C20928
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 15:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07BD4C844;
	Thu, 28 Sep 2023 15:10:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F47F4BDD8
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 15:10:11 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2077.outbound.protection.outlook.com [40.107.100.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C7319E
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 08:10:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWPKRAklzWFVd51Dlclb9YEZMMxB22oGeaY7YWvopPngK4/u8X192U8pXE7+As2+fPu9LizHRKVGX/fcp1GFrLVPT+BaJmU8DAcidGKwIMFOIpO44gh6/YpPBav0G9nB8nmq0Pd2kb6y6IYWl9AIaPGqzgdboTmCXeRljJNt8gU59vo62dh1dPtsXNiu96gu9eJDEb0xorLDHGQz0yVAk53f36MBc1d0LDgNiTR1i0TOw4qB6r5e+Mx8bVPMbVzhNlXuNQACvap+dcAo8o6XkKbJ/44nZneoe6FS64FDuqIRJZW7nwdR/fRS+SRb5PPUnN45H1VHGfHt4toDTpdcxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNiKCzPCIEEwaJKOn9oTBr8E8i2A8mgFQ1oforJnH7k=;
 b=SYs+YTrfYTX/0ZxnWi7tM9Dc0L5BcA+OoFyfq3PxaoCyFaD6m9+LGPiSmIKq1NPz6tq0HaYz6a4+elZjT9fBAlvc7aFm0xjI4gzg6pKOF6ftmQHGk7eFQZ44gnXUiX7I2aYbvVMZ7deHPIpdfckaNF7gz3KG6yQa8ZkOAYT6D1fceOhXjSxPzukCnHOHySSv7JjilchuT3GmZ5i0U2EK84GMIyacVwHawcs6SVRnYN7cLznB/c59GvFWRcrbhbvE4hhWepOJ8ObnBAoH3ZJ1CnRAJdLeGWB5XMakJr3QQ83Dlc1c8b8P1x+RBiisr87GQ7sQCvv2OnfLN5UmtOAF/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNiKCzPCIEEwaJKOn9oTBr8E8i2A8mgFQ1oforJnH7k=;
 b=bKfG5i7hGuFQQK9ZZcc07Pie8YBRtgWQGl/437ej3nLiJACaMZ9n5yNJQr2DrgaZ3ygyroqFWMFQF5lTPX5myKKZ2PdpVZ/Daa/D50KWtShgbF2BaQAb134vPHK2xWRlr9s0TbsHGLPBA1m9YQbTPIJuDtVClhVF6PhtEnSJ4FWmDo+pVq+ITntNC8Llk94OKGw+/euAv9vo6cxDRocMkmOa4dHVf61NOqaFdfQB5rBL7ooIWtnCQLX3xulCOhq8roZG2TWEfqYQ6p0XOsGAzCa2wfWMeUhbDXWm8zw5MhZYpFHhSVZP+sLRmoyD5dxhADUvVsVdbad1ZUu7AvY82Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by BN9PR12MB5067.namprd12.prod.outlook.com (2603:10b6:408:134::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Thu, 28 Sep
 2023 15:10:05 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1%4]) with mapi id 15.20.6838.016; Thu, 28 Sep 2023
 15:10:04 +0000
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
Subject: [PATCH v16 00/20] nvme-tcp receive offloads
Date: Thu, 28 Sep 2023 15:09:34 +0000
Message-Id: <20230928150954.1684-1-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P250CA0018.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::13) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|BN9PR12MB5067:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bd11d9b-7af8-45f6-fec8-08dbc034fe4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dFGMuk86PrsiScPYntTNzm13ZDvIEfNoa51Pnt2HYAth+smubQLljUvMRdwCKh8O6TheAOqyl0ygYBYsAnv+xusmlGsehM4TItTqlQKOxDvUM9DlRM77p5MamApKOl+1VMeT798ukycgCiJyySWu2242bNxH6GkTIMaClRgoMU7W0MIyHG/dwZV0mC6a237Zql5lEI6dy72frugD/KXJtq16yaOSftnsBqx+FMBP/5mk1hk2XhS3OvRl7ee5bVZyyQ12tphTiimf+lIqEYbT3R1Yfr2GkDx5W59X8QkctmGurvpRUjqjwYx4WGQ+SK8McQLMSVbaBviSHZjvPQKq93OeEV9DkL0uj0Am3GN2/eF4MbXLxtOxq1wranjr8o66DWTM+ahxvyguMcgrh3EEN0kxNMjtIFK6yNZkGbTebN87ZcJLvtGmBO0b49V/WJeLnJ3tY4v7ifdme1daD07QkbL4GCb/wJ1U8SCqJE86FYArqCmT3sAhSdY9x3lzJv0R6h8ap1ext2Xg5sW3tqhWOuu88apcty8RJUazHa9PgH3xBymyVx9xFAEU8kqA9JsD+FWYGYExHIeY2EIZHew2+MRw6fdcJidiAczb9d6cWKKqaVJBN4RiMOIak049n1QPvK91+vMz7pkdfaj76xv/TH+Z2BORsXxDjPocNkClvmXsKEMvnSy65EezrBMZRvLM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(346002)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(30864003)(7416002)(66899024)(107886003)(1076003)(6506007)(26005)(5660300002)(36756003)(316002)(66556008)(41300700001)(8936002)(4326008)(6512007)(2906002)(8676002)(83380400001)(66946007)(6666004)(2616005)(6486002)(478600001)(66476007)(38100700002)(86362001)(966005)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnczQmIwWkd0dnBTUjdsbzUraFJiZW1QUHdyT1pJa1ZmbHM2R0RTbk5sQkdl?=
 =?utf-8?B?SkVSVDJDU1NQYW9OUCtRUHZESm1yd1VneDhIMk51TzlnZnNIdlBtSWwwTDF0?=
 =?utf-8?B?VmhkcFJiVHRMSE1HQzdaOE1LQlRNL3BySjFHakh6eG90YU8xVVRpelZyTEI3?=
 =?utf-8?B?YzdOLzJnU0REQ1NJeEdBaVlXVkdnLzRkZ3pnaUdXWTBBaGtsQTA3a3RtaDdF?=
 =?utf-8?B?bmx0eHV2Q1VWWU9QRy9TOGMzVEpDMUsvY0tPS2ZGMXJnakk2QWlZUldJbWFT?=
 =?utf-8?B?ZWo1VDJ0bVlDNjU1SU9wd3ZGR09TZnozSG50bDY2aEpIOC83b1EwTmJ5eWNP?=
 =?utf-8?B?NXVySm9jUzZjZiszNjJ6Q28wYnE4S1prR09NRjVaSE84b2pJWUtuSndmMmln?=
 =?utf-8?B?bTczNjgxWWo1U1pCZlh1d1lFNWx0VnBoL2Q4SEVIRmlWNWkzbTgvSFRMTDNP?=
 =?utf-8?B?MjY2NEIxMDRSY0NsbjZOK1ZaUkovSTBvRzdxTFM5YytkdkNmdkhrS1FrY1JE?=
 =?utf-8?B?MDZGNzVJUG5TemZ2SVpPN0kzNStMSFptTGRGb3BPVHRWOCtmL1ZXNytrK1lS?=
 =?utf-8?B?TGtYMFUyemlxZFkveVo4cHBjTzB6bVRjeVJaVDJTOXIzNnNIWDZtUUdOUTRD?=
 =?utf-8?B?RVFBNldCN2VtYXAvb3pvWW81UWlkd3RvQU5RRTBxckZocFRtMDM0ZDEwUUY3?=
 =?utf-8?B?SlI2VnIrM2ZmRXZiY0d2czFQSmI2ajVXV1pBVHF5ZFU1UG9iY3RhS29nZ3h2?=
 =?utf-8?B?aHJpKzBVTEF4OEt1bWE3NG5XUndkK3ZCN1RiKzMreEQ0cGFLTTNkNTgrcEZR?=
 =?utf-8?B?YkJYdmFBK2JhdGc0NGQwSTUzdUNMMFZIRHdoZVo0VkVLbDcvR0EzbWxGT3pp?=
 =?utf-8?B?d0tQeFdtT2VLb2dTSGY5RVFLNHBhdDRXdmxrN3MrN3ZtZTlvb1VyVVZHbkpp?=
 =?utf-8?B?cVlpdkg3UzVYNHNFUFdkVUg5V1ZUVjloOW5UVUYvZVJQWXFvRHZyZ2VXcTJ1?=
 =?utf-8?B?a1FHSjFPV1RQd1hqTTNWRktJNlJSZzJlR1pHWFhldXRFRFhWNndhdk9TRXdl?=
 =?utf-8?B?Sm9jc2VmRUVQcVY2WXFyT1BJQUI2Y2xYbUtDVGV6L0NpQ3hieTM2bXZsWkpU?=
 =?utf-8?B?bnpxalR1ZFYxRk1tSHpPK2dJcVcrV0lsY0NMQU5ETGZqT2V4d3BlOEQydUt4?=
 =?utf-8?B?TlhzUTE1VDdkbXBUZ1dkOGVRbnJwWUJxeExpQjlsbFdCMmFnelJxeXBCb1M1?=
 =?utf-8?B?QWsrMW4vQWh6MllTRmZpRG51M2pCOXlxUnFGMm5MUE10OGR4Wlp1QllqaGJF?=
 =?utf-8?B?NjlyUVp6SmZPYnBOYUxSQm10emJGODVQVmpJc0Y4TGF0a3RVWFI1VDlJU3JJ?=
 =?utf-8?B?UlFhQ1hEanRDQWNUMC9wYlc3SlJVVHdvUUtBa2lkUkQvYkMwRWl3dmI4Z0k0?=
 =?utf-8?B?bTJKVmk5clRTYVgvYnA2UGNzTE5LdDNmTzJWN0U3VHhqMHJ3dVdaVzFITzhm?=
 =?utf-8?B?SmtHZUtma2ltd3pjS3FjSno3NTEyUk5ZTVNZSmg0RjBib0RVYml0c0V2aU1q?=
 =?utf-8?B?TWhKbStwMy8xNEIvL3B5ZXlWVGQ0R3hBN3NqZXJiekk1L0txcHBxNTMwZ3pG?=
 =?utf-8?B?ZHN2dklaT1lsWWJrVjJkZW1xOVlJOHdSMERMTVJVMm5QR1MrNnp5NkZqdXhC?=
 =?utf-8?B?RnpGS0p1Q0lBMHBrQStiU010T2NySGtScUhaRmsrVjBtSHRoRUdqWVdMcG1X?=
 =?utf-8?B?OTBVcFJTS3dOSlVJbEJRZ2Z4SEt4cDZ3aDgrZ2RwYngzWXRqU0lHNDRQZTZG?=
 =?utf-8?B?VHR3VGhsVzdvY1ZBc3hVb2djSHhyaVZOaUVZMitxUmh1VjAvMUFxOW9OazFU?=
 =?utf-8?B?Ti9ZRXYzS3JMMnJGUVhZdkJyUVk1S3ZuQzY1N0RkN2NyVllkZnhlZ25YbU42?=
 =?utf-8?B?Y2NsS0lLYU1tOEtVeXpWS2wvVldiL1BXaXp0T3ZiTEt4a3h4ckVrR1lqem5n?=
 =?utf-8?B?TDhNUUdQelBua0NFY1lOaExtSmp0ZlpNcHhQQk14a1EreWVXZTYrMjVtQlZQ?=
 =?utf-8?B?R3ZmWlNMdHVKcEtaWm4vMWQ1M2Q2T1MwUjl0MVJRN3NqS3d4OWd6dDNIZmZS?=
 =?utf-8?Q?277R0Cz6do7SeiIsnIVunc8Ez?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd11d9b-7af8-45f6-fec8-08dbc034fe4c
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 15:10:04.3743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FvW52GMmR3Qy9bksmbgGx9ZNlIpvq0bvWmQGo62MBBNGFaRYcx6oy00Rdzw6PZgsQcoUHSAmADCJcvwAEFg7zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5067
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

The next iteration of our nvme-tcp receive offload series.
This submission was rebased on top of net-next.

Previous submission (v15):
https://lore.kernel.org/netdev/d761c2de-fea3-cbd0-ced8-cee91a670552@grimberg.me/T/

The changes are also available through git:
Repo: https://github.com/aaptel/linux.git branch nvme-rx-offload-v16
Web: https://github.com/aaptel/linux/tree/nvme-rx-offload-v16

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
        ./tools/net/ynl/cli.py \
            --spec Documentation/netlink/specs/ulp_ddp.yaml --do set \
            --json '{"ifindex": <device index>, "wanted": 3, "wanted_mask": 3}'

        # Enable ULP offload in nvme-tcp
        modprobe nvme-tcp ddp_offload=1

Following the device ULP-DDP enablement, all the IO queues/sockets which are
running on the device are offloaded.

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
Patch 2:  Add netlink family to manage ULP DDP capabilities & stats.
Patch 3:  The iov_iter change to skip copy if (src == dst).
Patch 4:  Export the get_netdev_for_sock function from TLS to generic location.
Patch 5:  NVMe-TCP changes to call NIC driver on queue init/teardown and resync.
Patch 6:  NVMe-TCP changes to call NIC driver on IO operation
          setup/teardown, and support async completions.
Patch 7:  NVMe-TCP changes to support CRC offload on receive
          Also, this patch moves CRC calculation to the end of PDU
          in case offload requires software fallback.
Patch 8:  NVMe-TCP handling of netdev events: stop the offload if netdev is
          going down.
Patch 9:  Documentation of ULP DDP offloads.

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

Changes since v15:
=================
- add API func to get netdev & limits together (Sagi).
- add nvme_tcp_stop_admin_queue()
- hide config.io_cpu in the interface (Sagi).
- rename skb->ulp_ddp to skb->no_condense (David).

Changes since v14:
=================
- Added dumpit op for ULP_DDP_CMD_{GET,STATS} (Jakub).
- Remove redundant "-ddp-" fom stat names.
- Fix checkpatch/sparse warnings.

Changes since v13:
=================
- Replace ethtool interface with a new netlink family (Jakub).
- Simplify and squash mlx5e refactoring changes.

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


Aurelien Aptel (3):
  netlink: add new family to manage ULP_DDP enablement and stats
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

Or Gerlitz (3):
  nvme-tcp: Deal with netdevice DOWN events
  net/mlx5e: Rename from tls to transport static params
  net/mlx5e: Refactor ico sq polling to get budget

Yoray Zack (2):
  nvme-tcp: RX DDGST offload
  Documentation: add ULP DDP offload documentation

 Documentation/netlink/specs/ulp_ddp.yaml      |  183 +++
 Documentation/networking/index.rst            |    1 +
 Documentation/networking/ulp-ddp-offload.rst  |  376 ++++++
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
 .../ethernet/mellanox/mlx5/core/en_stats.h    |    8 +
 .../net/ethernet/mellanox/mlx5/core/en_txrx.c |    4 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw.c  |    6 +
 .../net/ethernet/mellanox/mlx5/core/main.c    |    1 +
 drivers/nvme/host/tcp.c                       |  497 +++++++-
 include/linux/mlx5/device.h                   |   59 +-
 include/linux/mlx5/mlx5_ifc.h                 |   83 +-
 include/linux/mlx5/qp.h                       |    1 +
 include/linux/netdevice.h                     |   18 +-
 include/linux/skbuff.h                        |   25 +-
 include/net/inet_connection_sock.h            |    6 +
 include/net/ulp_ddp.h                         |  295 +++++
 include/net/ulp_ddp_caps.h                    |   42 +
 include/uapi/linux/ulp_ddp_nl.h               |   59 +
 lib/iov_iter.c                                |    8 +-
 net/Kconfig                                   |   20 +
 net/core/Makefile                             |    1 +
 net/core/dev.c                                |   26 +-
 net/core/skbuff.c                             |    3 +-
 net/core/ulp_ddp.c                            |   71 ++
 net/core/ulp_ddp_gen_nl.c                     |   85 ++
 net/core/ulp_ddp_gen_nl.h                     |   32 +
 net/core/ulp_ddp_nl.c                         |  388 ++++++
 net/ipv4/tcp_input.c                          |   13 +-
 net/ipv4/tcp_ipv4.c                           |    3 +
 net/ipv4/tcp_offload.c                        |    3 +
 net/tls/tls_device.c                          |   16 -
 61 files changed, 4318 insertions(+), 157 deletions(-)
 create mode 100644 Documentation/netlink/specs/ulp_ddp.yaml
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
 create mode 100644 include/uapi/linux/ulp_ddp_nl.h
 create mode 100644 net/core/ulp_ddp.c
 create mode 100644 net/core/ulp_ddp_gen_nl.c
 create mode 100644 net/core/ulp_ddp_gen_nl.h
 create mode 100644 net/core/ulp_ddp_nl.c

-- 
2.34.1


