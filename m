Return-Path: <netdev+bounces-256425-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UG/oL3BDgmlHRQMAu9opvQ
	(envelope-from <netdev+bounces-256425-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:50:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2BFDDD8B
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71E7C314585D
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 18:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51C331ED73;
	Tue,  3 Feb 2026 18:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tiZJ35sP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7630B2F7ACA;
	Tue,  3 Feb 2026 18:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770144148; cv=none; b=kOf+8Hr21Jpu6Yadka4x0Pdu3drlpZqU/6Fo41TkkJiyhMKgeC2v+JLBW/HInk5mJSGYj+ypHtE6UXlSm+2Vxpg86D8Y1QJ2vfunxg+pTnT3jzAffdBts3zY9+0O4AhLKwptpQhmvXMvK0tjQTQK2zgvU99k8wiRp1/1ZLfPvWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770144148; c=relaxed/simple;
	bh=wRIpaO20lQckRnYerb9WukDrN5roa3A/MNA4U+4guRg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=u2qLhfI9HJLOgBZ31D9f/t1yo5LlwVRhbCR98auk+I4T54mAgr5w6YT8gNWHZyaAvnZf/S+oplj+TjCDioYwLW8yi6zaUevO90aoCP8GWIDJaQ0m91yu9j8Rnpkwn8d7NWSDZ9oDJ+IcmP2EqN6sOtx+rI2WWr51fsqQSNZFnvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tiZJ35sP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08EB7C19425;
	Tue,  3 Feb 2026 18:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770144148;
	bh=wRIpaO20lQckRnYerb9WukDrN5roa3A/MNA4U+4guRg=;
	h=From:Subject:Date:To:Cc:From;
	b=tiZJ35sP0M7IuI9LonWVl2o0SvN79IdtumFLpGZnlqZCEI7NXgdz11zLhC293ptU+
	 StHwcR3tUAyCuDTLlM0xSJZFaYK+dYbcYip2VqCCjrsfhinabJ6fTAelAPemxxjm6C
	 gWg7Vh5Ge8vlj0mXnknrEoqWsyoAWqico2g2MlBqc9HYQOC2i5dqHssUlnvzq/k+GP
	 SybrfYmsPXYYqs+B39P5/Lfdu1sAJ4l569lQF5JXOowdfifzo8EsNaeyd1gpIeQg1C
	 WKmALzfh1m8wfULj3noJIbJ1rsHSinpSuR62GbxZSmSchZamNUW7X/TwjVFzsvz9IK
	 sOmIuGSp74KLg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 00/15] mptcp: misc. features for v6.20/7.0
Date: Tue, 03 Feb 2026 19:41:16 +0100
Message-Id: <20260203-net-next-mptcp-misc-feat-6-20-v1-0-31ec8bfc56d1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAExBgmkC/zWMQQqAIBAAvxJ7bkEtpPpKdFDbag+ZqEQQ/T0JO
 sxhDjM3JIpMCYbqhkgnJz58EVlX4DbjV0Kei4MSSgupOvSUC1fGPWQXcOfkcCGTUaMSKMj22sr
 GutZAeYRIC1/ff4Q/hel5Xo9H2dx5AAAA
X-Change-ID: 20260128-net-next-mptcp-misc-feat-6-20-0eb96b13bc4a
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 linux-trace-kernel@vger.kernel.org, 
 David Laight <david.laight.linux@gmail.com>, Gang Yan <yangang@kylinos.cn>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3082; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=wRIpaO20lQckRnYerb9WukDrN5roa3A/MNA4U+4guRg=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKbHNuemLbz3WC2nPS2bfbHc8fsbTx7V3RwW7Sx1H1m9
 au5vvRvRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwETmpjP8T9nAoLJzu+vmzPS+
 q0vPbzfjsfE6uu30hLf6/fsCd86eNo2RoXHhPqPSx95fb74/Umqy9IfSpj8BL13NPQ9OvmB96M2
 SFGYA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256425-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,goodmis.org,efficios.com,gmail.com,kylinos.cn,linutronix.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4C2BFDDD8B
X-Rspamd-Action: no action

This series contains a few independent new features, and small fixes for
net-next:

 - Patches 1-2: two small fixes linked to the MPTCP receive buffer that
   are not urgent, requiring code that has been recently changed, and is
   needed for the next patch. Because we are at the end of the cycle, it
   seems easier to send them to net-next, instead of dealing with
   conflicts between net and net-next.

 - Patch 3: a refactoring to simplify the code around MPTCP DRS.

 - Patch 4: a new trace event for MPTCP to help debugging receive buffer
   auto-tuning issues.

 - Patch 5: align internal MPTCP PM structure with NL specs, just to
   manipulate the same thing.

 - Patch 6: convert some min_t(int, ...) to min(): cleaner, and to avoid
   future warnings.

 - Patch 7: prepare future extensions replacing sk_write_space().

 - Patch 8: sort all #include in MPTCP Diag tool in the selftests to
   prevent future potential conflicts and ease the reading.

 - Patches 9-11: improve the MPTCP Join selftest by waiting for an event
   instead of a "random" sleep.

 - Patches 12-14: some small cleanups in the selftests, seen while
   working on the previous patches.

 - Patch 15: avoid marking subtests as skipped while still validating
   most checks when executing the last MPTCP selftests on older kernels.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
David Laight (1):
      mptcp: Change some dubious min_t(int, ...) to min()

Geliang Tang (1):
      mptcp: allow overridden write_space to be invoked

Matthieu Baerts (NGI0) (9):
      mptcp: pm: align endpoint flags size with the NL specs
      selftests: mptcp: diag: sort all #include
      selftests: mptcp: join: wait for estab event instead of MPJ
      selftests: mptcp: join: fix wait_mpj helper
      selftests: mptcp: join: userspace: wait for new events
      selftests: mptcp: join chk_stale_nr: avoid dup stats
      selftests: mptcp: join: avoid declaring i if not used
      selftests: mptcp: connect cleanup TFO setup
      selftests: mptcp: join: no SKIP mark for group checks

Paolo Abeni (4):
      mptcp: do not account for OoO in mptcp_rcvbuf_grow()
      mptcp: fix receive space timestamp initialization
      mptcp: consolidate rcv space init
      trace: mptcp: add mptcp_rcvbuf_grow tracepoint

 include/trace/events/mptcp.h                      |  80 ++++++++++++++++
 net/mptcp/protocol.c                              |  56 ++++++-----
 net/mptcp/protocol.h                              |  12 ++-
 net/mptcp/subflow.c                               |   2 -
 tools/testing/selftests/net/mptcp/mptcp_connect.c |  17 ++--
 tools/testing/selftests/net/mptcp/mptcp_diag.c    |  29 +++---
 tools/testing/selftests/net/mptcp/mptcp_join.sh   | 107 +++++++++++-----------
 7 files changed, 189 insertions(+), 114 deletions(-)
---
base-commit: fae1c659d7bd5640012be21b5b5d6490b83c0df8
change-id: 20260128-net-next-mptcp-misc-feat-6-20-0eb96b13bc4a

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


