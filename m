Return-Path: <netdev+bounces-225785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1215B9842E
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 07:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20ADD19C7F0D
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 05:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A59224B05;
	Wed, 24 Sep 2025 05:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OlLcQ5F8"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFF0522F
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 05:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758690208; cv=none; b=mZcNye6TDbiZQ07QiVluCiUXSZF3dELK0E1Pazylra6Bk4+vegjMuOaXt+fihK7kRZL1Ysz2Zrrgs0CM+t0SEmYLlBlS+lYOyTRcT5LMyX9ZwVpOQuuj1Z99+vYlFdisEYlf3qtXqfgjAP9Em000RkqfCwuHtW7PBdknA/l3dMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758690208; c=relaxed/simple;
	bh=9vIfY/9PjudNrBRj6JjXxxp9FguJXINT05+D+3mp6xI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U98RRgDcLTFsikgdG+yk93djde16zyLkbk8bW9d+UvJAGY9L3h6STXUT8rjDy1HHrglkid9ITvprFle3iCOopOc36+X99hv03impPYbuEr2dQnMxML2iuEtePT7nWCKgoQcFg1qrGavspJqLBoEosLNUq1ZxvNqfdEgFOWkMUdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OlLcQ5F8; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758690192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3WWDuTTfdkUAkocz6IqPMwP+6eR+fb0ElX8BN/IPLcc=;
	b=OlLcQ5F8zoNi3Dww28MM7Mpn01Vv8DYnrjE+SqGYuskOPWlThqufqPwXcbspSUAsGUu04t
	CMrqy4PIwXvUj0hy60FtGfRqUVtZQNcRbMwWhQ3yrRjq7lhoEANrCXZF4Bo1O7IlPRd++6
	UHPO4Q2M4uQhl8bN2VM/tGmgwtUvtj8=
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
Subject: pull-request: bpf-next 2025-09-23
Date: Tue, 23 Sep 2025 22:03:03 -0700
Message-ID: <20250924050303.2466356-1-martin.lau@linux.dev>
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

We've added 9 non-merge commits during the last 33 day(s) which contain
a total of 10 files changed, 480 insertions(+), 53 deletions(-).

The main changes are:

1) A new bpf_xdp_pull_data kfunc that supports pulling data from
   a frag into the linear area of a xdp_buff, from Amery Hung.

   This includes changes in the xdp_native.bpf.c selftest, which
   Nimrod's future work depends on.

   It is a merge from a stable branch 'xdp_pull_data' which has
   also been merged to bpf-next.

   There is a conflict with recent changes in 'include/net/xdp.h'
   in the net-next tree that will need to be resolved.

2) A compiler warning fix when CONFIG_NET=n in the recent dynptr
   skb_meta support, from Jakub Sitnicki.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Jakub Kicinski, Maciej Fijalkowski

----------------------------------------------------------------

The following changes since commit 02614eee26fbdfd73b944769001cefeff6ed008c:

  idpf: do not linearize big TSO packets (2025-08-22 10:37:18 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to 55d5a5154d751023bdf12c196fb0f1accdacf300:

  Merge branch 'bpf-next/xdp_pull_data' into 'bpf-next/net' (2025-09-23 15:46:52 -0700)

----------------------------------------------------------------
bpf-next-for-netdev

----------------------------------------------------------------
Amery Hung (8):
      bpf: Clear pfmemalloc flag when freeing all fragments
      bpf: Allow bpf_xdp_shrink_data to shrink a frag from head and tail
      bpf: Support pulling non-linear xdp data
      bpf: Clear packet pointers after changing packet data in kfuncs
      bpf: Make variables in bpf_prog_test_run_xdp less confusing
      bpf: Support specifying linear xdp packet data size for BPF_PROG_TEST_RUN
      selftests/bpf: Test bpf_xdp_pull_data
      selftests: drv-net: Pull data before parsing headers

Jakub Sitnicki (1):
      bpf: Return an error pointer for skb metadata when CONFIG_NET=n

Martin KaFai Lau (3):
      Merge branch 'bpf-next/skb-meta-dynptr' into 'bpf-next/net'
      Merge branch 'add-kfunc-bpf_xdp_pull_data'
      Merge branch 'bpf-next/xdp_pull_data' into 'bpf-next/net'

 include/linux/filter.h                             |   2 +-
 include/net/xdp.h                                  |   5 +
 include/net/xdp_sock_drv.h                         |  21 ++-
 kernel/bpf/verifier.c                              |  13 ++
 net/bpf/test_run.c                                 |  37 +++--
 net/core/filter.c                                  | 135 ++++++++++++++--
 .../bpf/prog_tests/xdp_context_test_run.c          |   4 +-
 .../selftests/bpf/prog_tests/xdp_pull_data.c       | 179 +++++++++++++++++++++
 .../selftests/bpf/progs/test_xdp_pull_data.c       |  48 ++++++
 tools/testing/selftests/net/lib/xdp_native.bpf.c   |  89 ++++++++--
 10 files changed, 480 insertions(+), 53 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_pull_data.c

