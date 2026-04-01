Return-Path: <netdev+bounces-274281-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FZ3JSqtzWlRfwYAu9opvQ
	(envelope-from <netdev+bounces-274281-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 01:41:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AE2381BD8
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 01:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33ACC302D5BC
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 23:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653263EF0B0;
	Wed,  1 Apr 2026 23:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VaiNLNl+"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A143EF0A4
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 23:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775086840; cv=none; b=Lr3XLP6lkC9OnLTcsgUkh+pzO4etk+z7cJ/TGs8EbCCc0xQgRcUqMEJ+xdahh4R3eilDmwMlzTBpE08qK/UB+jm+3GC2RCB0wRxvHJZsx6aKX5jiLIVVYRuIhmTBBvwNbYLC2VgJ5101QtTafSpr/RzrkSzcnrKPYEDitb+Hs7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775086840; c=relaxed/simple;
	bh=1m7ZVF2vDL4UqtGoLO6FbAufa1XGSQ5NtPx4G9/qG7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AxQCKE2I/NJNWo6V2jWLvJRzN+45c2S6n8LA9B0BmAR1yKwrMYF5zloOCjCe5NZ2pVKesHINg++M0QGh4ZFl9ukmNC30UbeHRFmgoASwo10fpQWCb4Rc9Vq3x9XmCI4lbGWGRyRFieUp3YSZ/BTbYHrY01NlFK8SSed3uoXvIPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VaiNLNl+; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775086827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AyjMZ5vOq5urjuRPMM8TDbtsgNxY8JY3bbKEPMX7zKM=;
	b=VaiNLNl+xIMaaKGwmBWyBvukEgKCNoF9GMC//NQC4tDioSsbXlRv+lcRHgk2dr85g1rBLK
	fA64v6z4SVFR5SaziNZgBZR5THCs7d7kezI3UEqMMLFKlQDwBGjfnXnf0EpEVWAxl4mPKk
	zoKYSLqNGghrvZuqQgb1su4WXi93lc4=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: pull-request: bpf-next 2026-04-01
Date: Wed,  1 Apr 2026 16:39:56 -0700
Message-ID: <20260401233956.4133413-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274281-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 06AE2381BD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net-next* tree.

We've added 2 non-merge commits during the last 2 day(s) which contain
a total of 3 files changed, 139 insertions(+), 23 deletions(-).

The main changes are:

1) skb_dst_drop(skb) when bpf prog does a encap or decap,
   from Jakub Kicinski

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Daniel Borkmann, Willem de Bruijn

----------------------------------------------------------------

The following changes since commit cf0d9080c6f795bc6be08babbffa29b62c06e9b0:

  Merge branch 'net-hsr-subsystem-cleanups-and-modernization' (2026-03-29 14:37:53 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to 64c535db769e9ab917343d61045802e832d621ed:

  selftests/bpf: Test that dst is cleared on same-protocol encap (2026-03-30 15:52:25 -0700)

----------------------------------------------------------------
bpf-next-for-netdev

----------------------------------------------------------------
Jakub Kicinski (2):
      net: Clear the dst when performing encap / decap
      selftests/bpf: Test that dst is cleared on same-protocol encap

 net/core/filter.c                                  | 50 ++++++++++---------
 .../selftests/bpf/prog_tests/test_dst_clear.c      | 55 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_dst_clear.c | 57 ++++++++++++++++++++++
 3 files changed, 139 insertions(+), 23 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_dst_clear.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_dst_clear.c

