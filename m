Return-Path: <netdev+bounces-269015-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IqXByWsumn9aQIAu9opvQ
	(envelope-from <netdev+bounces-269015-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:44:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E362BC424
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BC46302DB64
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 13:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1463D75D5;
	Wed, 18 Mar 2026 13:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="hA4wwfJN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3047E3BED04;
	Wed, 18 Mar 2026 13:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773841371; cv=none; b=osTrA30x9fjkNacrJ0O/cv9J6A13lMp3I+2Rwg4KcRibr05ZngycFukhibVmTNEWeCoCtXaLY9rjH5tl+sADRe7w/mspPIwYH20sWRU6YugS21GPmlThSuIunp0IgiSfuye2et9T6wVXZWT6dgd6glO+i7URBvBOhj13+d30dgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773841371; c=relaxed/simple;
	bh=2OzD/J8k/cBc6COFTR1LzI3L46hz8U/fqCEw6yd/GpM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hc67M09+nnnnNLgGbNKijMY+P7QB0B3JQcViBudmWD7ApfMEbVsrVZqE/EZpjsFFpzFf19kKR1AZTtbwjZkJUeUxyCWXCNbB46jma7Je280pT/Ff54rSEBs5+3oPvwjVyXUrM6TvxIVKymOdXP8I4Lx8fMNAO8v5AkakZlpeedo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=hA4wwfJN; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
	by m0050093.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 62IAD6NR450017;
	Wed, 18 Mar 2026 13:42:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=jan2016.eng; bh=Hivxn+B/2KnkhsDfh1AzWhyRWQ68NyuXR
	fGb+HAPCr0=; b=hA4wwfJN9hCPqknkMPpX6D40QY2mPB5fX/WyCSUXiFc2/AcW7
	EkydiqaVH2hnUR8/x6RKRXkjguWjP0nkqbc5on0d+S5ZzmMINb0L5ixM4C8tbhR3
	wH3hYT7njeRoiNR/eBcx+cLis9qN5f/ZiRJr6umvxG9IR8mqkK7d6SFXEwkB4VKh
	db+UH/AhYtzhpfDChHxRBnLyYPIRxQWkVd4jTskgNxOt80DBjtIaokymatAyGJkE
	iQw7L+pgDZAYAxH+NW3y3L+c96V8COIdiBQO1uQP3YRDjFL+R2MFAdLuMIG9BD4b
	69cQoGh4d/FRfX+drXlp/gg0t0668iGKyOo6Q==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18])
	by m0050093.ppops.net-00190b01. (PPS) with ESMTPS id 4cw03sjmxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 13:42:45 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
	by prod-mail-ppoint1.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 62IDYBr1004428;
	Wed, 18 Mar 2026 09:42:44 -0400
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
	by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 4cw30xr5pe-1;
	Wed, 18 Mar 2026 09:42:44 -0400 (EDT)
Received: from muc-lhvdhd.munich.corp.akamai.com (muc-lhvdhd.munich.corp.akamai.com [172.29.0.147])
	by prod-mail-relay02.akamai.com (Postfix) with ESMTP id D03BA95;
	Wed, 18 Mar 2026 13:42:43 +0000 (UTC)
From: Nick Hudson <nhudson@akamai.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Nick Hudson <nhudson@akamai.com>
Subject: [PATCH v2 0/5] bpf: skb_adjust_room helper refactor and tunnel decap flags
Date: Wed, 18 Mar 2026 13:42:37 +0000
Message-Id: <20260318134242.2725749-1-nhudson@akamai.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=724 lowpriorityscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2603050001 definitions=main-2603180115
X-Authority-Analysis: v=2.4 cv=Q+LiJY2a c=1 sm=1 tr=0 ts=69baabd5 cx=c_pps
 a=StLZT/nZ0R8Xs+spdojYmg==:117 a=StLZT/nZ0R8Xs+spdojYmg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=d4nn1RXdvEacMIURMw2s:22 a=TkABgq2hV1jZ54fXNKYA:9
X-Proofpoint-GUID: wGUB8ZXmSj51UKwqbwYGOnmGNumy4d4K
X-Proofpoint-ORIG-GUID: wGUB8ZXmSj51UKwqbwYGOnmGNumy4d4K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDExNiBTYWx0ZWRfX5Se5px8bDnXr
 I9N3YdpuRrWlKE5krOhAZgPglnrpyGy8GQqpkVN/yMcwIYCRofY75ASkus8vSuZC1JRS0vT4Fq/
 c+ZcyaNAwX2HTjQYR4wGeSZFjQrHCbHCUrlRRzVLSo70+eyeGF/vYHx5sP6rR4/tDHpv5bsaWWI
 YpM93sksOYyHyrVjfT6uJ1KMJJw8jHWBi6mSpFSHDmyB/7jVVwLGp8zg5QEY/hFJHLjIz96iSps
 /AkquIfezYwMVlwGC+KaywwC7kSPLU1Y51bgZE5v2jNb7DCn8M8mzKCpcViq0l5iW9wAcBwXELb
 MhCbMMPBDcPPUhzgUU+5lsWH51erQwiGETiPL3L8uPBVojZ3EqrS2pdJInoB9nuOLPgUzZqFgoi
 e0LMy692zpsFOdAOnslIvc1tEpYvJpK0R68KBBGSOsusxLsjeZggawpTbl6FZ/h1FxWlrRe2MDn
 N7RBG4ek5Gy7KrzsPmw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603130000 definitions=main-2603180116
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[akamai.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[akamai.com:s=jan2016.eng];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,akamai.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269015-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nhudson@akamai.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[akamai.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[akamai.com:dkim,akamai.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 75E362BC424
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series refactors the bpf_skb_adjust_room() helper to support tunnel
decapsulation with L4 and IPXIP modes, in addition to the existing L3
decapsulation support.

The changes are structured as follows:
1. Name the enum for BPF_FUNC_skb_adjust_room flags
2. Add new BPF_F_ADJ_ROOM_DECAP_* flags for L4 and IPXIP decap modes
3. Introduce helper masks to simplify validation logic
4. Enable the new decap flags and add guard rails for invalid combinations
5. Clear tunnel GSO state when decapsulating in skb_adjust_room

These patches enable BPF programs to efficiently decapsulate various tunnel
encapsulation formats and properly handle GSO state transitions.

Changes v1 -> v2:
- Patch 3: Decap flag acceptance intentionally remains L3-only
  while adding the helper masks.
- Patch 4: Decap with L4/IPXIP support enabled with guard rails.

Nick Hudson (5):
  bpf: name the enum for BPF_FUNC_skb_adjust_room flags
  bpf: add BPF_F_ADJ_ROOM_DECAP_* flags for tunnel decapsulation
  bpf: add helper masks for ADJ_ROOM flags and encap validation
  bpf: allow new DECAP flags and add guard rails
  bpf: clear decap tunnel GSO state in skb_adjust_room

 include/uapi/linux/bpf.h       |  36 ++++++++++-
 net/core/filter.c              | 107 +++++++++++++++++++++++++++------
 tools/include/uapi/linux/bpf.h |  36 ++++++++++-
 3 files changed, 156 insertions(+), 23 deletions(-)

-- 
2.34.1


