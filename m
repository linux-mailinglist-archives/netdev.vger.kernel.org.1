Return-Path: <netdev+bounces-59762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D0A81C032
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 22:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82617B21E00
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 21:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA13E76DCC;
	Thu, 21 Dec 2023 21:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xpp4mX16"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFD0A5B
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 21:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jy8osVEn8a9g2JARal1OA+a9ZHsbhaF9Y09t3QfAzJ69yAxFHzajU4f24b+QMcjRjgusaZ6D2NZGRpxbvywOBHXdSCPCOwQaritxqm+jsUUEDuqyypB33OxxrDpIaBi8MYful4fcbQ0VSQFQ1VXKOTW7OC10KBMkrlwBtSJQxJd/2kbK0eScs+/9MOD5T17Tdq7+llVxmetQvPdaxpuDRvh5w/tPBJeXs/Htmw2RtdSb8tKkTn9HIkofke3tyc6p1Xo78tosaIxoP4LiaeADmJRmQ1zK3fROqwnDSNqbaIyOLEoS3C2MTpwYMPlE+8CFu1qlq+5zoM6OvueJUoId0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9V8F/AON/mCTwT4HaNxsY0OiTQ8cl0fqrP4h2yeTmJ0=;
 b=dRyVwF7SyxMNmAB0XLEP+uJjaIr6J/K7BL1GVfzS22ksQseossW63O3DO4taSwWb+lsZOKjykQhz15lZSG0ALgmZmeaLGWzQrj81gCLHMbFimKgm9+4X68hoo9Gsyl22YyYSHVz15wzAZ+YYG89uh0vxbnY8nHT+Zy8RkpopMsofIEsbM93vOVUiNwD83efb6wKzTBoN/XRSXSD+IVhDP2vE2/VoRIaJZ8DdwjU+NVjyWZ7N1nL0GFr6bD9xaVWPLoFLp6e4k2nyx+bD6d2OXcPZ+IdZ+Zy8OxU4pKJG5KKPQvq30wu4SERtX+fe/uAx4WXe092yACkArmam5B9wwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9V8F/AON/mCTwT4HaNxsY0OiTQ8cl0fqrP4h2yeTmJ0=;
 b=Xpp4mX16j/VpYrpAeTg7U+BtF/y25OBSjeSXzzYCmrAvgCNsw+OLWEsq4k+P7cTP2Nu4cJ+1LKtPh8Zfs7gI133/ACWgk87QITRIrjsLfhWptkK8iLiG7lVQ04QtE5YSX+eIqSTeovEQR2fjj/KIXGjaFSzmbTAvzOtY5kyBKzRx9sK1YcAFYCIP/Ymf9GJksFoJ4n2VghZpRosARWHGr15SVoNbq0imMrRNLVVZpyL+uEZV8tWd0csQi61lF7HjegII7an9es7g31yHEt+IHSHkxaR474XnmDAp1OLAvHxIXJXfvGoEIYK0l861Aq60sB2a9zzsBRU+xfupHecTYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by IA0PR12MB8647.namprd12.prod.outlook.com (2603:10b6:208:480::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 21:34:06 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 21:34:06 +0000
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
	mgurtovoy@nvidia.com,
	edumazet@google.com
Subject: [PATCH v22 00/20] nvme-tcp receive offloads
Date: Thu, 21 Dec 2023 21:33:38 +0000
Message-Id: <20231221213358.105704-1-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0004.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::13) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|IA0PR12MB8647:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a096175-c111-4430-e266-08dc026c8f17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	04LDZyvnAOV1z0J3HcVXSVukIFvKodtGGQYKZA9wChR40/MlHEIjxp+/rByrHOTLjlqX/NDhTsZjCykOtrhtdePmp8zuV7wt/BOLulkq0x3JjdnS7/UhbI4KfbRWpE3va3y1KqQOlRTTk/+7BepsvMhLrQsJMteoNT+Ak76DJV8NB8xD4GVRfAMZ5JMdWq2sgR+WFWPZArY7ATM+wdXzcpx2nk0DZ3SajZUyZA/LhiqXllYJGTz7kWMx1VVBNMWxM06SSahoZVqPydHVm88dM+kY/Gzne/xp0KZOLEET3e+VW0hwT4XeOzlpS8JkgjNB4hqr1MMH/O2hPx3503kkjqOWvIY8rPYp5MHqPUFQKwdNYonh7t+MlQl+UOFvCFMu4i6xF/5UO5GW62nxgEfqd6qNgY4FLC9/99kIj/vlfR/GvPaoGKbzZEUNCRjrkPP3UJ5eNcTYk+5GrHQaY0ZTLQSOKOM70PFNymtgtIK/hBCgb0Irwq0F8gADLnqoIvlJb14/14uv756T9TXG1SgR7LUVMReQeJOQ5pYQExaWnm5FlVzBLO01fJme1uf4qgsdrushcg6gja0riXrHleu997dTnhYz4hlAdp6+XLgRz9Fofm3nsYNkUG2Lfw3EzYipARDU0SEVHZUHTZRrsitSLpeZyaHELdb/ZX/D9egsdnmwds+XJc4bsDEhDcBRRMxS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(39860400002)(396003)(346002)(230922051799003)(230273577357003)(230173577357003)(186009)(64100799003)(1800799012)(451199024)(6512007)(6506007)(478600001)(966005)(26005)(6486002)(2616005)(1076003)(41300700001)(66946007)(83380400001)(66556008)(66476007)(6666004)(316002)(86362001)(66899024)(36756003)(8676002)(8936002)(38100700002)(2906002)(30864003)(7416002)(5660300002)(4326008)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STRNS0EvY1Q0U3lKTFhWVUJvbkVBR0NHOG1yb3JWRStJOFlIVlV0eXNxZVBj?=
 =?utf-8?B?WitTVkN0TkZNbkpuSnZKOUVoZnFpTXUzNDJBMWx4UHFhdkwxZklhMjNQSXds?=
 =?utf-8?B?c3Fia2JMWXRvUUJMT0FXNThQYTZEaUJINUNLUEN3aGxiNWY3RjdTK0xuTWN5?=
 =?utf-8?B?VDlMMGM0U01PNUl6T3VCbTJTTG1tL3FvVm94eS80TkVrdTB2ZjNTOFlhdXo5?=
 =?utf-8?B?T3NSbVlTeE9DYWpWY1NXVUlvVzN1QzFFbVh2MTBZa0FsNnN3VGE4cjVrei91?=
 =?utf-8?B?dDU1NnhtTUtIazdCdzlJNkYzZ3lCS1JodEFNT0E1SkJaN3V6VWFLa0UrWWs4?=
 =?utf-8?B?VWtEV2lheDdFdVUzMS91Vll0MG9ndXo2Ylc4dWdFVkVsQytBTG0yeWZHWjN2?=
 =?utf-8?B?M1hlUFlWWGFKU1I1V2twT1AyU01HZ1NUSVVkUzk2ZXlLMG9IMGpWeXJiaUVH?=
 =?utf-8?B?d2Z0R2MvQSs2cSsza2dSRnd5Tjl5eFBKQzZYdDN3bE1uSjd0aTltQTd5dFc5?=
 =?utf-8?B?Y2hBUlFaS1RrZnZudDR2TUxLWkFBbXBXMGVwaEFONXhweEdObWFQSFYvOENZ?=
 =?utf-8?B?WDhIUG9rK3ZNV05ZeURNOUswMlhVWVIzclUvWTVFQXgrSXltNkxFM1RmQ04y?=
 =?utf-8?B?dGcwbEduN1YxMjJHZUhLaGNoTmRaQlZMUU13L1dmbUltbEhJdElmNnlPQy90?=
 =?utf-8?B?dE5UZWtJR0RselFXS0x6SkFCa1k4VHVVd3JSREl0ZVoxZm50Yk52WFZNOE1F?=
 =?utf-8?B?Z3R5SU9pU2U1OGZGRHZGMm9UUklPdjJCVVh5L0o4M253WU43YXJzU1lhbzV3?=
 =?utf-8?B?S3ZJUmJiTk80NU03S2pLTXBrZisvdE5oNkJtbEkrSUEvU2g3cGRzaU9XelJG?=
 =?utf-8?B?dXhBY2hWTzM5M1RGb1hyMlptMU1iTngxR0wyalVEZE1jOFY1QXJpVUdZeUcz?=
 =?utf-8?B?VGRlZE16bDE2MFc3djlyMkE1V2VmbldtbFNtTUd3dldHRHZTZGRCelFPOGJO?=
 =?utf-8?B?T2dkVEpQRlVia0x0eEs3SW45QnhCM2RrazZra3NCR1B4NUJFM01KNFdjU0Vn?=
 =?utf-8?B?RjJhMFFyVkpDcVpEL0lvbG40VDlxUmVTSUFtcWtyWmdNSklZd2ozcW5EZ2ZS?=
 =?utf-8?B?TUN2TFhjK0xpZHBwRXhIYnJFeTlpNDJValE2SEVUdWZ3bXVYYUF2b0JFaW8v?=
 =?utf-8?B?MDQ4b3lJYkM1RXp4VjFGN3paWjloYUVaYVlxd2FDaFNPZ2NCSWVLMHZvQkFm?=
 =?utf-8?B?dVdsUmc5UU9uWlZRRTB2WVl6dGNmUmNkbTZpcElJRlRiWjFUNkZBZ2tqQXF0?=
 =?utf-8?B?Ukk2bUYvZWdMdmlYNFg5YnV0WmJhNGVvV09BalUzYTdQRkhFSUIzT1BzVXBp?=
 =?utf-8?B?VDFyMldSNTIzM3JIM29FcXdXVFpnamRBSng0MGxyeENJSTNqRVk0L2luUzly?=
 =?utf-8?B?c2FKdWo0WkZDakFOTzJ5cmdCOUNHdURWbjVPTG1EYUwzWVY3WUFaMmI3SUJP?=
 =?utf-8?B?UzBHcHRxN3RaL1NoSThmK1NPQjNGM21pQTBWVGI0Q2pyUm1YNENTQU5vcFJR?=
 =?utf-8?B?Tmdodm1ONGcwdjJCWlp4aHpMTWZ0WE9XQTQrM1ZGUVA2VDJpTHFrRThZU0hx?=
 =?utf-8?B?Y2ZBRG51Z3VaVk9lTEs5eUJKVzNaMDh3bzIrdVhuZ2U4aWdKWVp5OFhOeFZj?=
 =?utf-8?B?OUExVmplTVd2Z0ZhL0VpMkJIbTkxVXhrcGR3QnNUSlVkYTBZVzA4RWFzNlZO?=
 =?utf-8?B?S3c5eGVIMFhaVWQzTjNvR0Zack5EYVB2S3RzU2RpUW9NSWM4ZTg0RFczTjZp?=
 =?utf-8?B?b2pwYnJQaTFpY3hVT2xCYUtyYm5TUitxS1lERFAvNmdzQTZQeklYK2xVQ2Qw?=
 =?utf-8?B?QjJaVXlaYXJkWmxYME1uR2FlREhTb0p3RGkyVC96QUdSSml2SjFrRU02d283?=
 =?utf-8?B?YkxUa1NlSnNBNDN0d0ZIWk9wMVBTZ1NvN3RYK2hQNVFDWGI5WFBPTmxJVkpp?=
 =?utf-8?B?UytNUEY5OE4yek92c2E1ZnlwVjRIN0VkdVFFTlBycWU5U1c5c3FMcU00amhW?=
 =?utf-8?B?TDU1Y09jRmhKQUp2L2creU5ydjEvY1RvR0JHVWw4THUyMEFGTmZjU0d4bWk3?=
 =?utf-8?Q?UutS5pBFmT7pd6jb9W9Kn8x13?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a096175-c111-4430-e266-08dc026c8f17
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 21:34:06.2945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cj97VQ+PuHTe9UYsVIgRQDG/4yRwu7izNowwpZfii4EAwE90ir+ASxFT1LZ2ADy9xqCs/8DLS7zGcUpv5gBK9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8647

Hi,

The next iteration of our nvme-tcp receive offload series.
Main change is get_netdev_for_sock() using netdevice_tracker.

Previous submission (v21):
https://lore.kernel.org/netdev/20231214132623.119227-1-aaptel@nvidia.com/

The changes are also available through git:
Repo: https://github.com/aaptel/linux.git branch nvme-rx-offload-v22
Web: https://github.com/aaptel/linux/tree/nvme-rx-offload-v22

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
            --spec Documentation/netlink/specs/ulp_ddp.yaml --do caps-set \
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

Changes since v21:
=================
- add netdevice_tracker to get_netdev_for_sock() (Jakub).
- remove redundant q->data_digest check (Max).

Changes since v20:
=================
- get caps&limits from nvme and remove query_limits() (Sagi).
- rename queue->ddp_status to queue->nvme_status and move ouf of ifdef (Sagi).
- call setup_ddp() during request setup (Sagi).
- remove null check in ddgst_recalc() (Sagi).
- remove local var in offload_socket() (Sagi).
- remove ifindex and hdr from netlink context data (Jiri).
- clean netlink notify handling and use nla_get_uint() (Jiri).
- normalize doc in ulp_ddp netlink spec (Jiri).

Changes since v19:
=================
- rebase against net-next.
- fix ulp_ddp_is_cap_active() error reported by the kernel test bot.

Changes since v18:
=================
- rebase against net-next.
- integrate with nvme-tcp tls.
- add const in parameter for skb_is_no_condense() and skb_is_ulp_crc().
- update documentation.

Changes since v17:
=================
- move capabilities from netdev to driver and add get_caps() op (Jiri).
- set stats by name explicitly, remove dump ops (Jiri).
- rename struct, functions, YAML attributes, reuse caps enum (Jiri).
- use uint instead of u64 in YAML spec (Jakub).

Changes since v16:
=================
- rebase against net-next
- minor whitespace changes
- updated CC list

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

 Documentation/netlink/specs/ulp_ddp.yaml      |  172 +++
 Documentation/networking/index.rst            |    1 +
 Documentation/networking/ulp-ddp-offload.rst  |  374 ++++++
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
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 1118 +++++++++++++++++
 .../mellanox/mlx5/core/en_accel/nvmeotcp.h    |  141 +++
 .../mlx5/core/en_accel/nvmeotcp_rxtx.c        |  354 ++++++
 .../mlx5/core/en_accel/nvmeotcp_rxtx.h        |   37 +
 .../mlx5/core/en_accel/nvmeotcp_stats.c       |   66 +
 .../mlx5/core/en_accel/nvmeotcp_utils.h       |   66 +
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |    6 +
 .../net/ethernet/mellanox/mlx5/core/en_fs.c   |    4 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   29 +-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |   71 +-
 .../ethernet/mellanox/mlx5/core/en_stats.h    |    8 +
 .../net/ethernet/mellanox/mlx5/core/en_txrx.c |    4 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw.c  |    6 +
 .../net/ethernet/mellanox/mlx5/core/main.c    |    1 +
 drivers/nvme/host/tcp.c                       |  511 +++++++-
 include/linux/mlx5/device.h                   |   59 +-
 include/linux/mlx5/mlx5_ifc.h                 |   83 +-
 include/linux/mlx5/qp.h                       |    1 +
 include/linux/netdevice.h                     |   10 +-
 include/linux/skbuff.h                        |   25 +-
 include/net/inet_connection_sock.h            |    6 +
 include/net/ulp_ddp.h                         |  323 +++++
 include/uapi/linux/ulp_ddp.h                  |   61 +
 lib/iov_iter.c                                |    9 +-
 net/Kconfig                                   |   20 +
 net/core/Makefile                             |    1 +
 net/core/dev.c                                |   30 +-
 net/core/skbuff.c                             |    3 +-
 net/core/ulp_ddp.c                            |   52 +
 net/core/ulp_ddp_gen_nl.c                     |   75 ++
 net/core/ulp_ddp_gen_nl.h                     |   30 +
 net/core/ulp_ddp_nl.c                         |  342 +++++
 net/ipv4/tcp_input.c                          |   13 +-
 net/ipv4/tcp_ipv4.c                           |    3 +
 net/ipv4/tcp_offload.c                        |    3 +
 net/tls/tls_device.c                          |   31 +-
 60 files changed, 4236 insertions(+), 162 deletions(-)
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
 create mode 100644 include/uapi/linux/ulp_ddp.h
 create mode 100644 net/core/ulp_ddp.c
 create mode 100644 net/core/ulp_ddp_gen_nl.c
 create mode 100644 net/core/ulp_ddp_gen_nl.h
 create mode 100644 net/core/ulp_ddp_nl.c

-- 
2.34.1


