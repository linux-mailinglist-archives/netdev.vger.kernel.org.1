Return-Path: <netdev+bounces-304776-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hmjkEkBQSmoYBQEAu9opvQ
	(envelope-from <netdev+bounces-304776-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 14:38:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3C0709F92
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 14:38:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=xs4all.nl header.s=xs4all01 header.b=MWu0WN1D;
	dmarc=pass (policy=reject) header.from=xs4all.nl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304776-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304776-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFDDE301AF44
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 12:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B873803DD;
	Sun,  5 Jul 2026 12:37:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABCC3783B4
	for <netdev@vger.kernel.org>; Sun,  5 Jul 2026 12:37:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783255068; cv=none; b=aaFBx6dnkuoJyX4K5UGMwlUqdgbdZCcCUYQxvuubu09tLAfofN/zJ3Ezz9SVg4Lh1y6KkSvAhHRL9kzay2kFFRZqN2IbQnXRfBP/j/dGpQYYGZQgUe2RB5gqfz9S4w9VXm1JK5Uy5VlrSpWD3uk4yoV23+5CA9ssX/Yz1HjIzV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783255068; c=relaxed/simple;
	bh=5528LQnXY4DgziEWBAr/+cyM2Z7L2cB6bboVdxg3mZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dE+6cUaVCyX/CNO6+HWgr7Zt/l+V3xppQOQFVjPOAhh/XO31v5wbw0sRZkG/qtwDD1YjVIOn0jMR3N7G7/xPKgCGrBDjsdcslyceEHycShDTn7GtdwBbnOsM3YjaYEwo7XJLtciYavGsTi576C6ySxEz0qhokNS/HtMO5bM1hMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=MWu0WN1D; arc=none smtp.client-ip=195.121.94.185
X-KPN-MessageId: 4d355043-786e-11f1-9e8e-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 4d355043-786e-11f1-9e8e-005056999439;
	Sun, 05 Jul 2026 14:37:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=wdFpwB+D4BEZw72dTeQ35EIL70JhkCEnJqFkXB6VJI0=;
	b=MWu0WN1DfggNYoyoIfXoHA4oQUPxpX83J170BBi4bQLKw4ipL0SAw191lF026wXbvG5SDlFSVJd85
	 MlmMcBk2LTBcLSHylyOP/j4+/Btaqyf3IXKyXV8tTCHbLayGiY0av9ZZIt09l/GF62prd4oAXIOzx4
	 XczFcMfelAw2OYD6RobU2/AsxvPaEPDDeVJ55lsPfCLSrrjCF9TcZwvHTRwCFzaoUIXOxOYgcB4shv
	 2dvzmFtBwi4cl7XyqDEI3M08ysS7VFuAK5BB1sKqJshAdUkOMX2imjhNqcH5qR+CzL0pGW5B9gJbF+
	 G/CB5mjDJGjllgCZqPfDyWH0yslY2EQ==
X-KPN-MID: 33|p5HVcgMt1RE1Llurp2Eo7RnIftjFYaGW5kkgxx5XE72NO3hGoSlMO2gMwzRm1bM
 PL6wC5ASm8kge3LqFegzUuw==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Jx6NSeSoukrFATFvUBO2qRFdr4CWYH1BGsN5+kZG6jnhDHjsXsYKrDSZhtMsN5S
 VbU8iFE21BkGLiJVE8UNMQw==
Received: from daedalus.home (unknown [178.231.11.83])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 487b75b7-786e-11f1-807b-005056998788;
	Sun, 05 Jul 2026 14:37:36 +0200 (CEST)
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
Subject: [PATCH net-next v4 0/3] net: af_unix: useful handling of LSM denials on SCM_RIGHTS
Date: Sun,  5 Jul 2026 14:38:23 +0200
Message-ID: <20260705123826.3818443-1-jkoolstra@xs4all.nl>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,xs4all.nl];
	FREEMAIL_FROM(0.00)[xs4all.nl];
	TAGGED_FROM(0.00)[bounces-304776-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xs4all.nl:from_mime,xs4all.nl:dkim,xs4all.nl:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AE3C0709F92

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
v4:
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

Jori Koolstra (3):
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
 net/core/scm.c                                |  42 ++-
 net/unix/af_unix.c                            |   9 +
 .../testing/selftests/net/af_unix/.gitignore  |   2 +
 tools/testing/selftests/net/af_unix/Makefile  |   8 +
 .../net/af_unix/scm_rights_denial_lsm.bpf.c   |  36 +++
 .../net/af_unix/scm_rights_denial_lsm.c       | 263 ++++++++++++++++++
 14 files changed, 371 insertions(+), 17 deletions(-)
 create mode 100644 tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.bpf.c
 create mode 100644 tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.c


base-commit: b73bc9ca3686b78b642fb35dcc1fdf874ecb74a1
-- 
2.55.0


