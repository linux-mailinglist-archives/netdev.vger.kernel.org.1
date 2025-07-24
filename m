Return-Path: <netdev+bounces-209827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E80F3B11061
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 19:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E792F1CE7680
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 17:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE902D1F7B;
	Thu, 24 Jul 2025 17:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b5pfyYom"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324087080E
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 17:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753378400; cv=none; b=t4SX0NrN5Ti4p8K9AcsQdSoboGm45O2ke3DDwJ8BvUHYP/fB/Yq/PAZ9jYWr4vKmRZjL1Mi4OoahwMS39kaIFp+M1G0xFayQUhnV6j2hbHe6qlOKKRDmfqdNzW7aTaTumTtO8cr6DpXtB6axzUhQz/Q81tfETGi3oLFGZcRSaqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753378400; c=relaxed/simple;
	bh=AYPuPRueMTtTDDvyhBdbWXHwLNm6A4WjXLn678ZxEnM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n35WYKp061u/Gay+Cxq6d1xjPEor26Uu6TbvrAdh8mzCIevbrmVMM9GQH50YENyAcm7CQyUvfPgNgtKAEczWhP5qYNcjY9jsjk0aNRQn/jnezjj5hFca1rUyoNCLUSZwYKrtdUylmsqI62rRc1xYnN5pXT0mmohAbqPLLC/Grf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b5pfyYom; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753378394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KaAaOR/yrj9esdeBVvnwEmdJzS/QjSBjfQooYj1qkVs=;
	b=b5pfyYomEGRanjVOGJx60yrqPMDF7ZOz54QlGoOxjd5q6b2mC1xP0ZgW1NhAnNWR+bIXRT
	cQdI3NCeJgoQJjw5OMu+5kekzODys9m7iMlr/srEKQ+lF9MtK/BJWHrVeSzKMfk46+W0cy
	DgkTnaAemoxuip36yLPCNdKTGWujddo=
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
Subject: pull-request: bpf-next 2025-07-24
Date: Thu, 24 Jul 2025 10:33:06 -0700
Message-ID: <20250724173306.3578483-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net-next* tree.

We've added 3 non-merge commits during the last 3 day(s) which contain
a total of 4 files changed, 40 insertions(+), 15 deletions(-).

The main changes are:

1) Improved verifier error message for incorrect narrower load from
   pointer field in ctx, from Paul Chaignon.

2) Disabled migration in nf_hook_run_bpf to address a syzbot report,
   from Kuniyuki Iwashima.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Eduard Zingerman, Florian Westphal

----------------------------------------------------------------

The following changes since commit dd500e4aecf25e48e874ca7628697969df679493:

  net: usb: Remove duplicate assignments for net->pcpu_stat_type (2025-07-21 10:43:07 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to ba578b87fe2beef95b37264f8a98c0b505b93de9:

  selftests/bpf: Test invalid narrower ctx load (2025-07-23 19:35:56 -0700)

----------------------------------------------------------------
bpf-next-for-netdev

----------------------------------------------------------------
Kuniyuki Iwashima (1):
      bpf: Disable migration in nf_hook_run_bpf().

Paul Chaignon (2):
      bpf: Reject narrower access to pointer ctx fields
      selftests/bpf: Test invalid narrower ctx load

 kernel/bpf/cgroup.c                              |  8 ++++----
 net/core/filter.c                                | 20 +++++++++----------
 net/netfilter/nf_bpf_link.c                      |  2 +-
 tools/testing/selftests/bpf/progs/verifier_ctx.c | 25 ++++++++++++++++++++++++
 4 files changed, 40 insertions(+), 15 deletions(-)

