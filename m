Return-Path: <netdev+bounces-278956-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id DZIrOPyV4GlMkAAAu9opvQ
	(envelope-from <netdev+bounces-278956-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 09:55:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A415840B3A0
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 09:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1294D303D8B8
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 07:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC26B37C0FE;
	Thu, 16 Apr 2026 07:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="hscZot2L"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA6B37267E;
	Thu, 16 Apr 2026 07:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776326136; cv=none; b=eDo3NhtYmJdM9VcY36QJJaw3u0tIH+aw7/SvFAcvCNu0P1Mr4H6xAd/FbZ258JEQ+KrhUroQQAY8D6w3A89dBt0bzuBvl5TUDXfLUvTb0xjHbAt2uqBajxyEbizabpLoNIRbJ9GJ/o3JWZGx6Ed6/Fi8sMB7LGjoNCmux9HMP5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776326136; c=relaxed/simple;
	bh=QYXw9LtRFflxyok8cvGwn5NcAzPKkeU75c3UWatbWgU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JDtc3D/5eWmXBoD1VIj8ulsBbiiq2y0CdaDt456W/Zefic0tB1EhlButmRh2qI+LWgN2UY0wUp3xH/1ekQChjU+xzs+IieeSj1PaKJipi79f7OtrT+XJ3sM0r85kLnSxQDuTK17CBwm6bTFG9r9qsCL0uOeqdsPxTJCpN4IGFJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=hscZot2L; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0122332.ppops.net [127.0.0.1])
	by mx0a-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G4u5tX2832352;
	Thu, 16 Apr 2026 08:55:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=jan2016.eng; bh=QujEQLwB7Hxzlp0pLiE3nC4vO+Nxk0yWB
	WMoGt7WB3Y=; b=hscZot2LMmc90cgMYy8Hfxk66M0xw0IE6AFS7pXjrQi2sf2g2
	Z91xsvZySf36UAuzWNo+943N8KmR4RI+fVqYOSF1V6NUgyROoygK3sVj90GzRi9P
	ffOlF4nmWNUl3Mh2uc/Bczy1APutTwK75SkcKmsomCtnu/psKaxiYmY1i1aIt6E/
	iCLP0gWnUKPhlsLuo+EPbYyoIB6BqcY9rO2+XzQuQS11XlxnW8eiOWzu5avGXPa7
	pwJdZ6t0IKJ0tl8TkfjwIq+/FYotUtj2a2Pu/qPS7lTiupOk3zqUf3vTP0ibtHs0
	DTH2qXK6pJ3V5vFiLrR3v8ibb6qIDvmOO1OCw==
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60])
	by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 4dfeerwd4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 08:55:18 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
	by prod-mail-ppoint5.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 63G7ff8E011501;
	Thu, 16 Apr 2026 00:55:17 -0700
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
	by prod-mail-ppoint5.akamai.com (PPS) with ESMTP id 4dj2yre0b4-1;
	Thu, 16 Apr 2026 00:55:17 -0700 (PDT)
Received: from muc-lhvdhd.munich.corp.akamai.com (muc-lhvdhd.munich.corp.akamai.com [172.29.0.147])
	by prod-mail-relay02.akamai.com (Postfix) with ESMTP id 34B578D;
	Thu, 16 Apr 2026 07:55:16 +0000 (UTC)
From: Nick Hudson <nhudson@akamai.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nick Hudson <nhudson@akamai.com>, Max Tottenham <mtottenh@akamai.com>,
        Anna Glasgall <aglasgal@akamai.com>
Subject: [PATCH bpf-next v4 0/6] bpf: decap flags and GSO state updates
Date: Thu, 16 Apr 2026 08:55:08 +0100
Message-Id: <20260416075514.927101-1-nhudson@akamai.com>
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
 definitions=2026-04-16_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604070000 definitions=main-2604160071
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA3MyBTYWx0ZWRfX6ltBp5YTlNsF
 CUHIkuUU2gbnehh7MjsqdAHFuJ0NEDFcFWhYOi6jz667zFJ/01GM7yOU07+L4cplm0kw8aEmhgg
 aUGGenCOzSH5hl18DNKL8Dbo01zq3Ta/px6j1l58eTDivDVmJTIbJzyAaqWt8Wj0Jby0pjxnLnC
 Vbg/hOTqcXl4BLZqVjiUH1dhon9NegUMEtR+dEzOExQAc5DV+fXBT4fJOEz1NVHL7c6Oc95NYb7
 cNJT3vq2tTz1auB7zLU1QoQnxv7HVK8o0857/0mW9hWjgrer/yQlBAizURQMXEr02Oh/IcvxJzZ
 ujIAJB3YCdx4DIRgTon5e1YMIIqlw2HzXweLtE2he38Wd1RM9G6UXkYYFJjNhvSgEaxWLW7V5SO
 stsLD2uQbw7ZLPP/Bdj09L0pU2KHZjuYJc00b0CccZoIR3/EN0NhVnRS6OrFVB9iwH2VNkz6XVR
 u1JSZfxPz/+yHh2gHVw==
X-Proofpoint-GUID: qEaD0OSzD_WEr5eZ1fO6Kmni69vUGPNN
X-Proofpoint-ORIG-GUID: qEaD0OSzD_WEr5eZ1fO6Kmni69vUGPNN
X-Authority-Analysis: v=2.4 cv=CMgamxrD c=1 sm=1 tr=0 ts=69e095e6 cx=c_pps
 a=NpDlK6FjLPvvy7XAFEyJFw==:117 a=NpDlK6FjLPvvy7XAFEyJFw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=4OENtXgxWbduB0e82o7S:22 a=X7Ea-ya5AAAA:8 a=1oy85zK9C34BhurvvrYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160073
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[akamai.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[akamai.com:s=jan2016.eng];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[akamai.com:email,akamai.com:dkim,akamai.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-278956-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.c.6.3.0.1.0.0.e.4.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[akamai.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	FROM_NEQ_ENVFROM(0.00)[nhudson@akamai.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: A415840B3A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series extends bpf_skb_adjust_room() with decapsulation-specific
flags and tunnel GSO state updates for decap use cases.

Motivation
----------

When BPF decapsulates tunneled packets, skb GSO state needs to be updated
to match the removed tunnel layer. This includes clearing the corresponding
tunnel GSO type bits and resetting encapsulation state once no tunnel GSO
flags remain.

Series Overview
---------------

- Name the adjust_room flag enum for CO-RE lookups.
- Refactor adjust_room helper masks for maintainable validation logic.
- Add new DECAP flags to UAPI.
- Add guard rails for incompatible/invalid decap flag combinations.
- Implement decap GSO flag clearing.
- Add selftests to validate decap GSO state transitions.

Changes v3 -> v4:
- Patch 5: drop SKB_GSO_TUNNEL_REMCSUM handling from this series.
- Patch 5: clear encap_hdr_csum and remcsum_offload directly on UDP decap.

Changes v2 -> v3:
- Add a new selftests patch to validate decap GSO state behavior.
- Reorder the series so helper-mask refactoring precedes UAPI DECAP flag additions.
- Refresh patch 2 and patch 3 split to keep refactoring behavior-neutral.
- Patch 5: add decap tunnel GSO-state checks in
  "bpf: clear decap tunnel GSO state in skb_adjust_room" (per Gemini/sashiko).

Changes v1 -> v2:
- Patch 3: decap flag acceptance intentionally remains L3-only while adding helper masks.
- Patch 4: decap with L4/IPXIP support enabled with guard rails.

Co-developed-by: Max Tottenham <mtottenh@akamai.com>
Signed-off-by: Max Tottenham <mtottenh@akamai.com>
Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Nick Hudson <nhudson@akamai.com>

Nick Hudson (6):
  bpf: name the enum for BPF_FUNC_skb_adjust_room flags
  bpf: refactor masks for ADJ_ROOM flags and encap validation
  bpf: add BPF_F_ADJ_ROOM_DECAP_* flags for tunnel decapsulation
  bpf: allow new DECAP flags and add guard rails
  bpf: clear decap tunnel GSO state in skb_adjust_room
  selftests/bpf: tc_tunnel validate decap GSO state

 include/uapi/linux/bpf.h                      |  36 +++++-
 net/core/filter.c                             | 118 +++++++++++++++---
 tools/include/uapi/linux/bpf.h                |  36 +++++-
 .../selftests/bpf/progs/test_tc_tunnel.c      |  58 +++++++++
 4 files changed, 225 insertions(+), 23 deletions(-)

-- 
2.34.1


