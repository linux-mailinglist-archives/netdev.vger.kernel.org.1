Return-Path: <netdev+bounces-306975-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LqEuJRTrU2rOgAMAu9opvQ
	(envelope-from <netdev+bounces-306975-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 21:29:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D21745C03
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 21:29:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=xs4all.nl header.s=xs4all01 header.b=Ff76l4VZ;
	dmarc=pass (policy=reject) header.from=xs4all.nl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306975-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306975-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2536300A135
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 19:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DDA3B47CC;
	Sun, 12 Jul 2026 19:29:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722D8369981
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 19:29:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783884558; cv=none; b=m84ex4NUKcSNgUn+fJvs5QEs0DXQ7XhsXSnyANC0T9re6FTRTIljru7nkVojTx11TbhcovU3+olivwk5PkGRogQk39U34AdHB/WS4iNOwaqQG/DdYNmpSWShmg8M7av8xAXG6cdknA7cRBJmlPSp78ZckvfsR06Y6LItNcDL6NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783884558; c=relaxed/simple;
	bh=7FeLZRz1lyQ0XU/V8TTu9YNCIok8MYLB4V1l1DzpssI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e/1ykABlwBwC6uVBPfHC5S4fvPlrMUYkLD5Qk/a19q/sKFRmfYBsyi+GtQnN2rmIOLsn5kqWfsBi+iWNXaLQg60uYF/GQuUyjAyWNL6fXpSfbo+OkNQHT9NnZzPg8Yuf5S6Ls/LgXgd42DlUkK7/40JL+Wl+ffoAbucBJ7z19GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=Ff76l4VZ; arc=none smtp.client-ip=195.121.94.185
X-KPN-MessageId: f5dfb728-7e27-11f1-9e8e-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id f5dfb728-7e27-11f1-9e8e-005056999439;
	Sun, 12 Jul 2026 21:29:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=KPf/aoCZlxQz+vFaLELeH6sLcVCRcc/cpJwz2gB1uqY=;
	b=Ff76l4VZAlo8WoJ/NSgZo7rqkAQLKXflzwa40rgvvddCT1bv4LwYKMs5+TIKFkNxx+4zs+hQ7f0sW
	 Jaeln7sK+7jPCQPcNfCK4UT2kfH6QJ6u9JqJ2VsViVbHXwyyNSkWlM70kFHiJiuBElbQstlrxmqlw4
	 jq1bf6dWYhmJ/iU4C+ZTWtntdZHNKy/kGR9Qam+fdL1F9hSIGYQeHP1fc7k1UPuRI2OL3PXGcfIqr+
	 ri1X5hPv1KZSFRm1J8ZqLicyuyBlABgASKjxH/qWZCaQUDhweMpY0tlmTwcPPH4V2hhuRGKETgepPc
	 y578Q3lVQp4WHn6jJktMGx2lxZW/vCg==
X-KPN-MID: 33|NYkvUMlNyR46n+JRRCp856l9S28XqQfb+s46ITKw0XLuvpzEgl2ZEC+qYh6JX+1
 vHqmKoABwQMHh/auUzF9i+FbCL7fl0Ri+TyOaheDxL+Y=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|JHIEU+RzsCoWXECWdl/V5mzobVXmY34k9TsvMANEMCsS+nNjc0sUyWXN67sO1LQ
 p0KvKFx6+NwwSTjL1TbbcEw==
Received: from daedalus.home (unknown [178.230.226.124])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id f09634af-7e27-11f1-8dcc-00505699d6e5;
	Sun, 12 Jul 2026 21:29:11 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [net-next v5 0/4] net: af_unix: useful handling of LSM denials on SCM_RIGHTS
Date: Sun, 12 Jul 2026 21:29:54 +0200
Message-ID: <20260712192958.1631672-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[xs4all.nl,reject];
	R_DKIM_ALLOW(-0.20)[xs4all.nl:s=xs4all01];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,xs4all.nl];
	FREEMAIL_FROM(0.00)[xs4all.nl];
	TAGGED_FROM(0.00)[bounces-306975-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:cyphar@cyphar.com,m:kuniyu@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jkoolstra@xs4all.nl,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jkoolstra@xs4all.nl,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkoolstra@xs4all.nl,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[xs4all.nl:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,xs4all.nl:from_mime,xs4all.nl:dkim,xs4all.nl:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E4D21745C03

Right now if some LSM denies an AF_UNIX socket peer to receive a
SCM_RIGHTS fd, the SCM_RIGHTS fd array will be cut short at
that point, and MSG_CTRUNC is set on return of recvmsg(2). This is
highly problematic behaviour, because it leaves the receiver
wondering what happened. As per man page MSG_CTRUNC is supposed to
indicate that the control buffer was sized too short, but suddenly
a permission error might result in the exact same flag being set.
Moreover, the receiver has no chance to determine how many fds got
originally sent and how many were suppressed.[1]

Add a SO_RIGHTS_NOTRUNC option to UNIX sockets to enable more useful
handling of LSM denials when receiving SCM_RIGHTS messages: instead of
truncating the message at the first blocked fd, keep every fd slot
and store the LSM errno in the blocked slot.

[1]: https://github.com/uapi-group/kernel-features#useful-handling-of-lsm-denials-on-scm_rights

Changes:
v5:
  - Enable SO_RIGHTS_NOTRUNC on all AF_UNIX socket types.
  - Added required BPF CONFIG_ options to
    tools/testing/selftests/net/af_unix/config.
v4: https://lore.kernel.org/netdev/20260705123826.3818443-1-jkoolstra@xs4all.nl/
  - Removed the __receive_fd() helper and moved logic into
    scm_recv_one_fd() directly (suggested by Brauner).
  - Moved selftest from Smack to BPF (LLM assisted).
  - Add arch specific socket option values for SO_RIGHTS_NOTRUNC.
  - Undo patch that replaced copy_from_sockptr() with
    copy_safe_from_sockptr().
v3:
  - Separated net and vfs changes.
  - Use kselftest_harness.h and system() to call the test script.
v2: https://lore.kernel.org/netdev/20260616143020.3458085-2-jkoolstra@xs4all.nl/
  - Reimplemented as a UNIX socket option instead of a per recvmsg(2) flag.
v1: https://lore.kernel.org/netdev/20260428175125.2705296-1-jkoolstra@xs4all.nl/

Jori Koolstra (4):
  net: af_unix: enable custom setsockopt for all socket types
  net: scm: move scm_detach_fds() from common path to scm_recv_unix()
  net: af_unix: useful handling of LSM denials on SCM_RIGHTS
  selftest: Add tests for useful handling of LSM denials on SCM_RIGHTS

 arch/alpha/include/uapi/asm/socket.h          |   2 +
 arch/mips/include/uapi/asm/socket.h           |   2 +
 arch/parisc/include/uapi/asm/socket.h         |   2 +
 arch/sparc/include/uapi/asm/socket.h          |   2 +
 include/net/af_unix.h                         |   1 +
 include/net/scm.h                             |  13 +-
 include/uapi/asm-generic/socket.h             |   2 +
 net/compat.c                                  |   4 +-
 net/core/scm.c                                |  40 ++-
 net/unix/af_unix.c                            |  19 +-
 .../testing/selftests/net/af_unix/.gitignore  |   2 +
 tools/testing/selftests/net/af_unix/Makefile  |   8 +
 tools/testing/selftests/net/af_unix/config    |   7 +
 .../net/af_unix/scm_rights_denial_lsm.bpf.c   |  36 +++
 .../net/af_unix/scm_rights_denial_lsm.c       | 285 ++++++++++++++++++
 15 files changed, 404 insertions(+), 21 deletions(-)
 create mode 100644 tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.bpf.c
 create mode 100644 tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.c


base-commit: f6f3b36c15ed44de1fbb44e645e4fae8c4a4453e
-- 
2.55.0


