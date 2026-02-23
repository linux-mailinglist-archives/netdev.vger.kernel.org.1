Return-Path: <netdev+bounces-260083-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBs7NTVznGmcGAQAu9opvQ
	(envelope-from <netdev+bounces-260083-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:33:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DF2178C35
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3EBA63073871
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 15:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C368028C869;
	Mon, 23 Feb 2026 15:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Locr35s6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08A7191;
	Mon, 23 Feb 2026 15:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771860681; cv=none; b=tDpoLzBzarAdA5/0+0ZBVCRtVToTVb+0lzc+GebTwSTm2HEJrPt5BiCaC8c3fCo0wNnHgqp5muq2KSKpj96507hQ1P+/lSYQ19KnfZ6cIrimccjlWS34xVoyZkSuMBqD9SkmJPtTHu7t9TnHRPmAltmIGXKX3vwkzkpjvhimKLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771860681; c=relaxed/simple;
	bh=ctP1UU27tLiOW211tKcjYzIW7T9UCOnyQ+3z045jeUs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hhqZfk3D9hHsd3iHzW8drrDRgn8m7BTBQ3QYmp5CrgeN1OgNa1ZFORUwRym/x6IAgnQ0/roB3VTWrzW/1RXKdibVXHmXZpuR+xdMxW2hYcRHYZHRgfxmJRW7l2Mg4GLjyNyfs4FxS54o1QUw7//CeQ+nTgkGuBlr5xnCxnTFLvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Locr35s6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A6DC116C6;
	Mon, 23 Feb 2026 15:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771860681;
	bh=ctP1UU27tLiOW211tKcjYzIW7T9UCOnyQ+3z045jeUs=;
	h=From:Subject:Date:To:Cc:From;
	b=Locr35s63cRteDBT9nn+5mbBlHIoMU30aMUM9UiLDZiVKM2L1WQaqlea440Q9D/1s
	 PIPFsU3GCN+LkOMgz3oiotDAUTpdBxSHjHPMlh3/O3EmPjk2VRybKxogElIxdnGdPW
	 lsWO/Fy78o0rt2l4kGc3aSoKSDV+bUAGzjHqGzkXsaV7Hih9DDV/YpfIruMT4tMwjO
	 WXxuz9RlS+4EJgjx4cLk6uFhZXHb/14s1FRrbMCER+RPLLhp4cgI5AsqDGdJdF2NXZ
	 xfh4XVXxJ73K8gJ+RBszVv8oxYEmWw7H+M3v5ebwX0oH3nTnejeLKIieidQARd1kVx
	 RkjspPRYU/Bww==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH iproute2-next v2 0/3] ip mptcp monitor: add JSON support
Date: Mon, 23 Feb 2026 16:28:37 +0100
Message-Id: <20260223-ipr-monitor-json-v2-0-f91fccccf917@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACVynGkC/3WNzQ6CMBCEX4Xs2TXtAmI8+R6Gg8AC609Ltkgwp
 O9uw93jl5n5ZoPAKhzgkm2gvEgQ7xLQIYN2vLuBUbrEQIZOhsigTIpv72T2io/gHdqyyvPKllS
 0FtJsUu5l3ZU3SG3/mZnQ8TpDneJRQpp+98PF7qX/7sWiQW6KxnRlX53JXJ+sjl9HrwPUMcYfN
 sjHA8AAAAA=
X-Change-ID: 20260220-ipr-monitor-json-1573371524c1
To: Stephen Hemminger <stephen@networkplumber.org>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1090; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ctP1UU27tLiOW211tKcjYzIW7T9UCOnyQ+3z045jeUs=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLnFB2zYDex9jS9tTnyjnTcVYbKKeUTGh8e8A64Ll+47
 4fnI97CjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIncF2VkuN67c8YVs95583pv
 5JR2B2+d67xsz8sEsW1afExfWkMe+TP84fvOJjpFM7nw/5tLfSZTU7wvWZurfgqt4bq7KdP1b3w
 aIwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260083-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 70DF2178C35
X-Rspamd-Action: no action

With this series, the command 'ip [-t[s]] mptcp monitor' produces an
output with the JSON format.

- Patch 1: a small refactoring to uniform the code.

- Patch 2: add JSON support in print_timestamp() helper.

- Patch 3: add JSON support to 'ip mptcp monitor' as requested by
  Stephen.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- Patch 1: clearly mention the "fix".
- Patch 2: ignore argument.
- Patch 3: print token with 0xhex, use atexit().
- Link to v1: https://patch.msgid.link/20260220-ipr-monitor-json-v1-0-eb4b0d5f7820@kernel.org

---
Matthieu Baerts (NGI0) (3):
      mptcp: uniform stream closure
      utils: timestamp: add JSON support
      mptcp: monitor: add JSON support

 ip/ipmptcp.c | 94 +++++++++++++++++++++++++++++++++++++++++-------------------
 lib/utils.c  | 12 ++++----
 2 files changed, 71 insertions(+), 35 deletions(-)
---
base-commit: f120cdb35da76ca99932d0428a0917bd01a843da
change-id: 20260220-ipr-monitor-json-1573371524c1

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


