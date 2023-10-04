Return-Path: <netdev+bounces-37930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E17747B7DD2
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 13:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9AC382814B4
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 11:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F11C11C91;
	Wed,  4 Oct 2023 11:09:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6A4111B4;
	Wed,  4 Oct 2023 11:09:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6769C433C8;
	Wed,  4 Oct 2023 11:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696417757;
	bh=cIK310loNJ2BR+OPVmSjuH3dT9aW28cXGyvHv5GQJRE=;
	h=From:To:Cc:Subject:Date:From;
	b=muwOzbM7de19wBjNPm7pS7dN1UXW5jDvXiLqXtvzchKcHh0MWe/X2SJBDFaNpEBvn
	 kVMxYvRRRgFvMWDy7+y/0WAds3A8G/wTXLEJUl5JwrjoXoYauzn6OPDf8FToABW7QY
	 1VT4MZbaYqzFwyM4XHz9gaUOQlt9bDFBinO1bpeN01cu3vA90N7/MuCrzrVOe25Bg1
	 AqM/9ZU4iCK9KlnreyzpwIYryhNSoY7Ik9irx7HpWG9Nlzk4BL/crso/RNm7CMXTJ3
	 alCfUILE+coHx5L51sKHdCJerv7xXTTn9O8jrlmxX2zntD2wI+HXOJw80AuWf0RhMP
	 5GWhkKhFuBhyQ==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sami Tolvanen <samitolvanen@google.com>
Subject: [PATCH bpf 0/3] libbpf/selftests syscall wrapper fixes for RISC-V
Date: Wed,  4 Oct 2023 13:09:02 +0200
Message-Id: <20231004110905.49024-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

Commit 08d0ce30e0e4 ("riscv: Implement syscall wrappers") introduced
some regressions in libbpf, and the kselftests BPF suite, which are
fixed with these three patches.

Note that there's an outstanding fix [1] for ftrace syscall tracing
which is also a fallout from the commit above.


Björn

[1] https://lore.kernel.org/linux-riscv/20231003182407.32198-1-alexghiti@rivosinc.com/

Alexandre Ghiti (1):
  libbpf: Fix syscall access arguments on riscv

Björn Töpel (2):
  selftests/bpf: Define SYS_PREFIX for riscv
  selftests/bpf: Define SYS_NANOSLEEP_KPROBE_NAME for riscv

 tools/lib/bpf/bpf_tracing.h                  | 2 --
 tools/testing/selftests/bpf/progs/bpf_misc.h | 3 +++
 tools/testing/selftests/bpf/test_progs.h     | 2 ++
 3 files changed, 5 insertions(+), 2 deletions(-)


base-commit: 9077fc228f09c9f975c498c55f5d2e882cd0da59
-- 
2.39.2


