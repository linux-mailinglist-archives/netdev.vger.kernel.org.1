Return-Path: <netdev+bounces-51891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 313A77FCAAA
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 00:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 621811C20A6E
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 23:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D685732F;
	Tue, 28 Nov 2023 23:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcB5nDHY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E34A51;
	Tue, 28 Nov 2023 23:19:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71876C433C8;
	Tue, 28 Nov 2023 23:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701213562;
	bh=hhcwRip5QXrstPbex+rljitmLtgeBa7S/t+VzvU+UvA=;
	h=From:Subject:Date:To:Cc:From;
	b=XcB5nDHYtLQFLReliPAOTzuyl16NX7ENIEzxjRrZR6xSjLhjhIiFhyv4UPKVInKrO
	 0pGCz/FVKdRUDPui+HJCAsiMzXZwvKKaUGY7kZY5URODCNZx6MQm+9pIdExKaC/xHR
	 85lg80xSwixFL4QeA7FjX3cXeiXwdSoqFY9Ov0ez2k8nnOJLW09fzqSI4WUYI4xC8x
	 DEsZPk6yAIvddgaFWPFi2iKUKykZnP139mMK6MDdRCjVwFOi6oXeoXUUmgwh93KUJ5
	 Kuv9W+G8gPa5CZK9pOD0BD2xoojaZ1MJUx/fZklDfPWqjSpiX535u5JgfIRrOGpk0o
	 BFen7hyRICQ+g==
From: Mat Martineau <martineau@kernel.org>
Subject: [PATCH net-next v4 00/15] mptcp: More selftest coverage and code
 cleanup for net-next
Date: Tue, 28 Nov 2023 15:18:44 -0800
Message-Id: <20231128-send-net-next-2023107-v4-0-8d6b94150f6b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFR1ZmUC/4XNSwrCMBAG4KtI1kaSSdKkrryHuIjtpA1KKkkpl
 dK7GyqiIsXFLP55fDORhNFjIvvNRCIOPvku5CC3G1K1NjRIfZ0zAQaCM9A0YahpwD7X2NNnW9M
 SnK0KbUrNOMm3t4jOj4t7JK9tcsqT1qe+i/fl4cCX+R974JRRJtC5UioolT5cMAa87rrYLOQAb
 4ZzucZAZs6FYlZqLQqofhjxyag1RmSGo1OGS2WNgS9mnucH2wWi51MBAAA=
To: Matthieu Baerts <matttbe@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang.tang@suse.com>
X-Mailer: b4 0.12.4

Patches 1-5 and 7-8 add selftest coverage (and an associated subflow
counter in the kernel) to validate the recently-updated handling of
subflows with ID 0.

Patch 6 renames a label in the userspace path manager for clarity.

Patches 9-11 and 13-15 factor out common selftest code by moving certain
functions to mptcp_lib.sh

Patch 12 makes sure the random data file generated for selftest
payloads has the intended size.

Signed-off-by: Mat Martineau <martineau@kernel.org>
---
Changes in v4:
- Include Geliang's fixup for patch 3, to fix test script variable scope
- Include Geliang's fixup for patch 14 for consistent whitespace
- Rebased
- Link to v3: https://lore.kernel.org/r/20231115-send-net-next-2023107-v3-0-1ef58145a882@kernel.org

Changes in v3:
- Include Geliang's fixup for patch 11, to include test_prio in the refactor
- Rebased
- Link to v2: https://lore.kernel.org/r/20231114-send-net-next-2023107-v2-0-b650a477362c@kernel.org

Changes in v2:
- Rebased on current net-next (v1 was deferred due to net-next PR timing)
- Link to v1: https://lore.kernel.org/r/20231027-send-net-next-2023107-v1-0-03eff9452957@kernel.org

---
Geliang Tang (15):
      mptcp: add mptcpi_subflows_total counter
      selftests: mptcp: add evts_get_info helper
      selftests: mptcp: add chk_subflows_total helper
      selftests: mptcp: update userspace pm test helpers
      selftests: mptcp: userspace pm create id 0 subflow
      mptcp: userspace pm rename remove_err to out
      selftests: mptcp: userspace pm remove initial subflow
      selftests: mptcp: userspace pm send RM_ADDR for ID 0
      selftests: mptcp: add mptcp_lib_kill_wait
      selftests: mptcp: add mptcp_lib_is_v6
      selftests: mptcp: add mptcp_lib_get_counter
      selftests: mptcp: add missing oflag=append
      selftests: mptcp: add mptcp_lib_make_file
      selftests: mptcp: add mptcp_lib_check_transfer
      selftests: mptcp: add mptcp_lib_wait_local_port_listen

 include/uapi/linux/mptcp.h                         |   1 +
 net/mptcp/pm_userspace.c                           |   8 +-
 net/mptcp/protocol.h                               |   9 +
 net/mptcp/sockopt.c                                |   2 +
 tools/testing/selftests/net/mptcp/diag.sh          |  23 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 110 ++----
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 376 ++++++++++++---------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |  91 +++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  39 +--
 tools/testing/selftests/net/mptcp/simult_flows.sh  |  19 +-
 tools/testing/selftests/net/mptcp/userspace_pm.sh  | 143 ++++----
 11 files changed, 409 insertions(+), 412 deletions(-)
---
base-commit: a379972973a80924b1d03443e20f113ff76a94c7
change-id: 20231027-send-net-next-2023107-92fac6789701

Best regards,
-- 
Mat Martineau <martineau@kernel.org>


