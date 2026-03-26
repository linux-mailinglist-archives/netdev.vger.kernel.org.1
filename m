Return-Path: <netdev+bounces-271924-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNUtL4XvxGnv5AQAu9opvQ
	(envelope-from <netdev+bounces-271924-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 09:34:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 596F83316BB
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 09:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55AD130F81A9
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CEF391839;
	Thu, 26 Mar 2026 08:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="YgKUtAxt"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888D53B47C6;
	Thu, 26 Mar 2026 08:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774513506; cv=none; b=D4+CLp8+b9/Eqm1yN9pEqJbxvH6nlf7PRU2JQZAsA8ARvK+kWBdNoKExyL4eP0EOs0EFmSjsCRY5Y6BXm3F0eHco4rxqGSAjHVLhZkwsh+NnneHa2d3Ldg0fdc5k3S2kvy0E+IdUMZkNhxr7FHbnD2HZun5A/yGJzkEwU/iciRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774513506; c=relaxed/simple;
	bh=hRCgaVZNwegcubRgKs/u00hJeZ/asLC65BM6OmIdJkU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OKDWImPSx2r3LV4BoRzEd4kOXQJhM3M43+4jTT2ifh5SsPQL6TpdlcFhzf/jPXUp4RLDqoZkTVVkexV9R1nhrGdYmC14KrqRNDzJC7lwn5/HKezIkGzFUcFxid0dJhzIF9G3xkv2MUy71RL4AuA4RSIlw+EXLa4ZzcXcJtW1B9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=YgKUtAxt; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q7FPEK146719;
	Thu, 26 Mar 2026 01:01:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=9TpCz5888lBYHvNX0U5WkFA2ea7b9zUscC/cyQLmNBc=; b=YgK
	UtAxtCdfFzUjWYGTl6t+zkJcSzf0ev+G9Gl9BWFOBy/rkbAoYz78ryoY/4haTI0q
	hyujA8afehZG7PAVOvx66A+a9cmdxFM/3whhTP9TU4eYnsofuA9nYDWPGuS1rsT7
	/U/wYmakHvoX/RcE3byvR72BSDs58aRkT89pKirggTuJs9mZN2bWJTZ4J8WQrN61
	7gpChGW8WT/RWKhTwt1mniZoKTtHdZMa4liczD9KR8DTO7jLqqTv3AYfrNkYmENr
	3j4ukjHu81fYK0A6UP2S4v4TJqsThogXTUV4C7vsKyiANwL/286rOvn7mavnwIFs
	kO+IBH586VjlEhjCLJA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4d420jmnbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 01:01:03 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Mar 2026 01:01:02 -0700
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Mar 2026 01:01:01 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 26 Mar 2026 01:01:01 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id AD1773F7070;
	Thu, 26 Mar 2026 01:00:57 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <bbhushan2@marvell.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>
Subject: [net-next PATCH v3 0/4] octeontx2: CN20K NPA Halo context support
Date: Thu, 26 Mar 2026 13:30:44 +0530
Message-ID: <1774512048-10740-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: EBGN_rfXZUDRV0if20zQ71lDEq0zh7Ag
X-Authority-Analysis: v=2.4 cv=ULDQ3Sfy c=1 sm=1 tr=0 ts=69c4e7bf cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=Apbl8yOqu0udmtBCm5gA:9
X-Proofpoint-GUID: EBGN_rfXZUDRV0if20zQ71lDEq0zh7Ag
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA1NyBTYWx0ZWRfX4mTs2HMImYgc
 +hP1kr/mvYF24fVV9po6yXZixJ6h4oV14wWQjYQaaIgotR97eP9p79rRjuLLgh1WcsPgRqM9Jg0
 EDFj8T8US4NEoqKb3bse/WsBn4tY2HkshIzNDY/jO81WFGp1ONSHDfkYRjnTJWcCP6NZ1nN3EFO
 tz+xeoiK3RIxosI0afl+xed8x5kH7SQ3u8JVdvH0UWtTtdfwoXB28Jr8uunOqGBUjhrXOf439dy
 EsLbXxLuwMMs9X2c4jq6SiRO4fomgCari57Uu2pO9yC9HkerkumpnoM1+Z6phe59BcTSr4tbJes
 DwzvBXDej7NmyQSb1rw9QHaLhogmWEbsxpFGHdjfHeboFTko+YaQKRaRRQM7MiOAkd+I/Fw6Nb+
 l1cdmGw91Lih2cRNdUEkdXhwefTWDKzxc9UmjSmLITQGvJkjV1nzf+FdDGPbqT3UmOaZr+FCWTU
 T6A+gAATRwpTJLZjApQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sbhatta@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271924-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,marvell.com:dkim,marvell.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 596F83316BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series adds NPA Halo support for CN20K in the octeontx2 AF and
PF drivers. On CN20K, NPA supports a unified "Halo" context that combines
aura and pool contexts in a single structure. This is a simplification
in hardware so that there is no need to initialize both Aura and Pool
contexts for queues. Separate Aura and Pool contexts are needed say if
we have to point many Auras to a single pool but we always use 1:1 Aura
and Pool map in Octeontx2 netdev driver. Hence for CN20K use Halo
context for netdevs.

The series:

  1) Adds Halo context type, mbox handling, and halo_bmap tracking in AF.
  2) Adds NPA DPC (diagnostic/performance counters) 32 counters with
     per-LF permit registers, mbox alloc/free, and teardown handling.
  3) Adds debugfs for Halo (halo_ctx file and NPA context display/write
     for HALO ctype).
  4) Switches the CN20K PF driver to use the unified Halo context and
     allocates a DPC counter for the NPA LF.

Changes for v3:
 Fixed all AI reviews
 Removed inline for npa_ctype_invalid(as per Simon)

Changes for v2:
 Fixed all AI reviews
 Removed inline and added const for npa_ctype_str(as per Simon)
 Fixed build warning flagged with W=1


Thanks,
Sundeep

Linu Cherian (3):
  octeontx2-af: npa: cn20k: Add NPA Halo support
  octeontx2-af: npa: cn20k: Add DPC support
  octeontx2-af: npa: cn20k: Add debugfs for Halo

Subbaraya Sundeep (1):
  octeontx2-pf: cn20k: Use unified Halo context

 .../ethernet/marvell/octeontx2/af/cn20k/api.h |   6 +
 .../marvell/octeontx2/af/cn20k/debugfs.c      |  60 +++++
 .../marvell/octeontx2/af/cn20k/debugfs.h      |   2 +
 .../ethernet/marvell/octeontx2/af/cn20k/npa.c | 156 +++++++++++++
 .../ethernet/marvell/octeontx2/af/cn20k/reg.h |   7 +
 .../marvell/octeontx2/af/cn20k/struct.h       |  81 +++++++
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  25 ++
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   5 +
 .../marvell/octeontx2/af/rvu_debugfs.c        |  71 +++++-
 .../ethernet/marvell/octeontx2/af/rvu_npa.c   |  77 ++++++-
 .../marvell/octeontx2/af/rvu_struct.h         |   1 +
 .../ethernet/marvell/octeontx2/nic/cn20k.c    | 213 +++++++++---------
 .../ethernet/marvell/octeontx2/nic/cn20k.h    |   3 +
 .../marvell/octeontx2/nic/otx2_common.h       |   3 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   6 +
 15 files changed, 597 insertions(+), 119 deletions(-)

-- 
2.48.1


