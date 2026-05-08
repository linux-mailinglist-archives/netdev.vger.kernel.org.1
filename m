Return-Path: <netdev+bounces-285940-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCkBG2Eg/mkRnAAAu9opvQ
	(envelope-from <netdev+bounces-285940-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 19:41:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C101F4FA189
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 19:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23A113080655
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 17:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A2E2566F7;
	Fri,  8 May 2026 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6fEarwk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD38410D36;
	Fri,  8 May 2026 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262025; cv=none; b=i0HAS7EoH9XOfh3DTP6TqLK9NtETcZUmCu/BpcDgYzbPS/IskzSc6YE0U6hayur4lfI0dWgG7JdXt3/8JiQz1nehffdxVn2rB/3TbARPHcwVsHxrb3yGCuM/6eT1L7BQf1+veaKm+xdfx5gqOZ2vncriShq1QW15x7S/7x+ERRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262025; c=relaxed/simple;
	bh=djDWZ/MHnIHGN/6+CsSoHzZgeOd2vJrN4iKTIdki/ws=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OSoT2c2/6OCl1NPNRXk4pV3qYtdPh5DJc+w70ilTAritV9s7yViYgP7/FHTYruVAQoqjqQp9yIEMH2Ek05h7bdLJBf1N+AzXfse71ZwUloMrWetQlctkq9Y/EhRcLIj0PXSefJQzfgdnnor7IazP9VqMCN/Q0mxDf5wc4oDTqNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6fEarwk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37BF0C2BCB0;
	Fri,  8 May 2026 17:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778262025;
	bh=djDWZ/MHnIHGN/6+CsSoHzZgeOd2vJrN4iKTIdki/ws=;
	h=From:Subject:Date:To:Cc:From;
	b=T6fEarwktXiptA8Kiz9sOAKykMvRos9O7h36N6zNHZI8c6lir6knidIYHkkxNSfDX
	 9vSl+jKtOOOXNMg6YgrUQwQNmipNBzZzPQilnWvB5L0O+gJtEuh6QLKmVNZTS5B3Bp
	 KE3Ms2n1ZUtUIEi8wd2w1rclCzdh2pZJNt1U4QfPjbbkIszBm5wxRTXwG1Y/SvyA6n
	 HClERfV5WO89YUZCYErGROHwjscJLTn2JTNqbxDMlUi9tiu/M2dYKhoEE/qkWc42+Q
	 1CQ3Vz3H33LAP5tSFx7dfHxnAWk1EU3Ps0s+hs58D73i64zZZKTBrLLX3LXiQ+QIyC
	 Nznq0nqmXBcrg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 0/8] mptcp: pm: in-kernel: increase limits
Date: Fri, 08 May 2026 17:40:45 +0200
Message-Id: <20260508-net-next-mptcp-pm-inc-limits-v1-0-c84e3fdf9b6a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zWMQQrCMBBFr1Jm7cAYTCleRVy0cWqnNDFkRimU3
 t2ouPiLx+e9DZSLsMK52aDwS1QeqcLx0ECY+nRnlFtlcORa8tRhYqtbDWO2kDFHlBRwkSimOHT
 O96MnPhFBTeTCo6zf/AX+Jlx/jz6HmYN96rDvb1ZCykiKAAAA
X-Change-ID: 20260508-net-next-mptcp-pm-inc-limits-b825af50e400
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1912; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=djDWZ/MHnIHGN/6+CsSoHzZgeOd2vJrN4iKTIdki/ws=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL/KTAc3ZQR8Opv4+2whcf3f5ArEYvfWSvyZtH/kN1zz
 3+5OyeHtaOUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAiNz8x/NMr2Lyezd3Q6FWr
 /eF1geyTLNp7Gi6m1TVVSz3zPGvNksXwV2JfPOf/As+Jiyu0t+VVcnmmTL7zjD9wGpuImowk76t
 37AA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Queue-Id: C101F4FA189
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285940-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Allow switching from 8 to 64 for the maximum number of subflows and
accepted ADD_ADDR, and from 8 to 255 for the number of MPTCP endpoints.

The previous limit of 8 subflows makes sense in most cases. Using more
subflows will very likely *not* improve the situation, and could even
decrease the performances. But there are no technical limitations nor
performance impact to raise this limit, so let's do it: this will allow
people with very specific use-cases, and researchers to easily create
more subflows, and measure the performance impact by themselves.

- Patches 1-2: increase subflows and accepted ADD_ADDR limits.

- Patches 3-4: increase endpoints limit.

- Patches 5-7: validate the new limits: 64 subflows, 255 endpoints.

- Patch 8: selftests: use send()/recv() instead of sendto()/recvfrom().

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (8):
      mptcp: pm: in-kernel: explicitly limit batches to array size
      mptcp: pm: in-kernel: increase all limits to 64
      mptcp: pm: kernel: allow flushing more than 8 endpoints
      mptcp: pm: in-kernel: increase endpoints limit
      selftests: mptcp: join: allow changing ifaces nr per test
      selftests: mptcp: join: validate 8x8 subflows
      selftests: mptcp: pm: validate new limits
      selftests: mptcp: pm: use simpler send/recv forms

 net/mptcp/pm_kernel.c                           | 77 +++++++++++++++++--------
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 33 ++++++++++-
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 56 +++++++++++-------
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c   |  8 +--
 4 files changed, 121 insertions(+), 53 deletions(-)
---
base-commit: 6a4c4656b0d2d4056a1f0c35442db4e8a5cf8021
change-id: 20260508-net-next-mptcp-pm-inc-limits-b825af50e400

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>


