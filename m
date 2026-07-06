Return-Path: <netdev+bounces-305204-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Fp8rDqMETGp4ewEAu9opvQ
	(envelope-from <netdev+bounces-305204-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 21:40:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 296C071516D
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 21:40:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=PKfn2+L4;
	dmarc=pass (policy=none) header.from=ibm.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305204-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-305204-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F41953004D89
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 19:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A1F32ED24;
	Mon,  6 Jul 2026 19:36:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3B83314C4
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 19:36:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783366593; cv=none; b=b0ThHvgzvkwQESPYu2gsyvJwoCyNKnRYV4Hr0jn9zye4kOJhuCZZVF6jIR1aDL+1WsIbUp+eJTkhQoSbwokAcu2k7jxfywxZ9mv1IyOxy8HWC1L7vkbnC+uc/hKs/2UAwogIRQ5SLwHG+zwwCGOw9V6gmPLNUT376sD7OrnFBCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783366593; c=relaxed/simple;
	bh=RylovPUzJOANhlR4eYq/C3c0o8VKFiX7Skx0mQi5vZU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=P9GxLP6TsK3htBpxKCCS6WLv1OdhA2HNG2hsGQ2qMsUq8yO3KOaKrGJoi1el6wBo7mBnCN/3pMDChN6oE4LS3kE7KA+5rWFpwfxyiQeNfm3co57EEELNr02fRGPoubK7hipOLf6o7lc4K4/xMeZO3IyOsBL+ELjof4cZipMOghM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PKfn2+L4; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FIE7J611241;
	Mon, 6 Jul 2026 19:36:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=fmYxoG7bBR6Y15f0kHgtZIjEYDR5
	x4dK8RpPpcOSZb4=; b=PKfn2+L4ZDhhFSPZ88wdxtuX5CtfTBCGUkWgNcZFUNsc
	UhF7y6p0CcBGbgdEKc4umRXqB6ACtE6AxuHN3g3ObYBDzqO8beD97lnH/Cb9shhA
	eqrLP+T/ajZZrS8l9+kdhODoG6IIg6Q+GJHHDLHaA+UN/9FaIDIY1mF7hnNYbv4B
	o66CPbyY0uowERmSE4splWCTkM8AkUpuWhbJTwae/HaPLpPcIuhgI1s7+6LWiJzB
	zabCZALsv9IWnJCJfRqd+jHvbjJ4ellq/pV058kLlJRs3AnvBXaGfeOQZp2Wy/xy
	ZrJ6XYd1WlrPISib0hQ3ekRWiZYu0M/iHG8keJC2BA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3k596-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 19:36:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666JYbAb018729;
	Mon, 6 Jul 2026 19:36:16 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0h6uyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 19:36:16 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666JaFx32163264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 19:36:15 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30A555805A;
	Mon,  6 Jul 2026 19:36:15 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B77558051;
	Mon,  6 Jul 2026 19:36:14 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.26.177])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 19:36:13 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au
Subject: [PATCH net-next v3 00/15] ibmveth: Add multi-queue RX support
Date: Mon,  6 Jul 2026 12:35:48 -0700
Message-Id: <20260706193603.8039-1-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4c03b2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=W5LMyInF-Pr_ibXwEbYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE5NSBTYWx0ZWRfXxeBOgtbB7rkQ
 J5w157WZa6uLrCXCYKbLsj510QomqPENRJMLgGPrMkufEx+o0xDFGwUfSFxih+BwM9+bwVl6/1i
 qZMxCwVW2oOLC+tqXldPYBMxebnYBZk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE5NSBTYWx0ZWRfX/2yDxzQ8OKq4
 UK/x7NVekyDILpFeOW/mA7tpN9NhEPkFtqKu7+4mgUY+OJqC1c4vyGE9ErlBKmYKHfcH2w9XUgR
 stFr2aYyIBXz+RQx60D5XkPtWomu8tzK4E/0gIEem91jvtJ6iTwpVvYnRmphz4B/F9/ZmqGWdLu
 iednVMQgkgb9IRUjkvvWWS/DX5lURbdfD8oAV4vcP73xCplGhnCoB+K3gWZgIfJtzv337CypFsC
 8pjZ1KJ4Rz57btfa3YIyxTYdZbYjqKi7XVB6HAQsPfdsdsPMRqTn/Qvta5Krd6XIq9Pth8bCE2T
 2uZlfQxSYQlVnbYV5cYeSiUhLqEPX04WlrvG38wnggWIH7goEud0ZzmJE7ZBXgXv5sZkZ/GRlHK
 HbXSYhWow46LZdKZXBy5Ys9sV9iF/fLwpe9TI1EfnYrK/gptyCFbh7Mvy0OygMCFm8Kg0e1pkKX
 7+yc7myBeUOi+GuIokw==
X-Proofpoint-ORIG-GUID: 393L4oTKwJMAD1oMnG438WFF6E9hfYCh
X-Proofpoint-GUID: wvUI-ZUNqd50VhKQ-K7cFrmcZCt5Zwir
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060195
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305204-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.ibm.com:mid,linux.ibm.com:from_mime];
	FORGED_SENDER(0.00)[mmc@linux.ibm.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:horms@kernel.org,m:bjking1@linux.ibm.com,m:haren@linux.ibm.com,m:ricklind@linux.ibm.com,m:mmc@linux.ibm.com,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:linuxppc-dev@lists.ozlabs.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmc@linux.ibm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 296C071516D

Hi,

Power11 PHYP firmware adds Virtual Ethernet multi-queue (MQ) RX for
the ibmveth device: multiple logical-LAN RX queues, per-queue buffer
posting, and completion delivery. Guest Linux did not use that
platform support; ibmveth still registered one RX queue even when
PHYP was MQ-capable.

This series adds the ibmveth MQ client. When PHYP advertises the
capability through H_ILLAN_ATTRIBUTES, the driver registers
multiple RX queues, receives on per-queue NAPI, and exposes queue
count through ethtool. Older firmware without the bit is unchanged.
Please apply to net-next.

Background
ibmveth today registers one logical LAN, one set of buffer pools, and
one NAPI context. PHYP MQ mode gives each RX queue its own handle:
buffers are posted with H_ADD_LOGICAL_LAN_BUFFERS_QUEUE, subordinate
queues register through H_REG_LOGICAL_LAN_QUEUE, and traffic can
land on any active queue. Queue selection is firmware-defined; v1
does not program RSS or hash tables. The driver needs per-queue
pools, IRQs, and poll state to match.

Queue-aware hcalls are selected only when probe sets multi_queue
from H_ILLAN_ATTRIBUTES; legacy firmware keeps the original hcall
path unchanged through the entire series.

This splits the work so review follows the actual bring-up sequence:
  1. Hypercall definitions and MQ data structures (patches 1-2)
  2. Refactor open/close into helpers - RX, per-queue pools,
     IRQ, TX, PHYP (3-9)
  3. Turn on the MQ datapath at probe/open (10)
  4. Per-queue RX/TX stats and sysfs pool readout (11-12)
  5. Runtime RX queue resize via ethtool -L (13-14)
  6. LPAR stability fix (15)

- Helper patches (3-9) reshape ibmveth_open()/close() into
queue-aware helpers. Runtime behaviour is unchanged through that
block: num_rx_queues stays 1 and multi_queue is false until patch 10.
- Patch 10 is the switch: probe sets multi_queue from firmware, raises
num_rx_queues, registers subordinates, and replenishes every active
queue.
- Patch 15 fixes poll hangs after aggressive ethtool -L cycling and
NAPI/close deadlocks on ip link down.

Testing
Tested on ppc64le PowerVM LPAR with MQ-capable firmware:
* Aggressive ethtool -L cycling (16/1/8/11/1/3/16/8/1) with ping
* MQ path: ethtool -L under iperf3 load, link down/up during traffic
* Legacy firmware (no MQ bit): full open/close/stress on the
  refactored helper path to confirm single-queue behaviour is
  unchanged

Changes in v3
v2 resubmit with complete patch series: v2 accidentally omitted patches
1-2 (hypercall definitions and MQ structures). This v3 includes all 15
patches in correct order. No code changes from v2; same LPAR testing
results. v2: https://lore.kernel.org/r/20260701222327.61325-1-mmc@linux.ibm.com

Changes in v2
v1 resubmit as 15 patches (Patchwork limit): same code and LPAR testing;
squashed split plus checkpatch fixes in patch 15 only.

v1: https://lore.kernel.org/r/cover.1782758799.git.mmc@linux.ibm.com
Patchwork: https://patchwork.kernel.org/project/netdevbpf/list/?series=1119106

Future work
* IRQ affinity hints for subordinate queue IRQs returned by PHYP
* Summed global no_buffer drop counter across all RX queues in MQ mode

Comments and suggestions on patch split, design, and testing are
welcome.

Mingming Cao <mmc@linux.ibm.com>

Mingming Cao (15):
  ibmveth: Add MQ RX hypercall wrappers and call definitions
  ibmveth: Prepare MQ RX adapter and statistics structures
  ibmveth: Refactor RX resource allocation for MQ RX bring-up
  ibmveth: Refactor buffer pool management for per-queue MQ RX
  ibmveth: Refactor RX interrupt control for MQ RX queues
  ibmveth: Refactor TX resource allocation in open/close paths
  ibmveth: Add RX queue register/deregister helpers for MQ
  ibmveth: Refactor open/close into MQ-ready resource pipeline
  ibmveth: Add queue-aware RX buffer submit helper for MQ
  ibmveth: Enable multi-queue RX receive path
  ibmveth: Add per-queue RX and TX statistics collection and reporting
  ibmveth: Expose per-queue buffer pool details via sysfs
  ibmveth: Implement incremental MQ RX queue resize
  ibmveth: Wire ethtool set_channels to MQ RX queue resize
  ibmveth: Fix MQ RX poll and shutdown hangs after queue resize

 arch/powerpc/include/asm/hvcall.h  |    6 +-
 drivers/net/ethernet/ibm/ibmveth.c | 2452 +++++++++++++++++++++++-----
 drivers/net/ethernet/ibm/ibmveth.h |  226 ++-
 3 files changed, 2285 insertions(+), 399 deletions(-)

--
2.39.3 (Apple Git-146)

# Made with Bob

