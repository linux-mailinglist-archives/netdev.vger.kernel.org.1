Return-Path: <netdev+bounces-302817-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xJteJ+TKQmpeCQoAu9opvQ
	(envelope-from <netdev+bounces-302817-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 21:43:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F21586DE79B
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 21:43:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=xs4all.nl header.s=xs4all01 header.b="MTE/RJlV";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302817-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302817-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=xs4all.nl;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04F3A30488D2
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 19:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F623E4514;
	Mon, 29 Jun 2026 19:42:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4495A383C7C
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 19:42:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782762154; cv=none; b=LkohZQQXJ10fVm0+ZQ+2JKcfC1BmB+W7M+QUriJQZP46OnrlZPBmZCrAzWX03yF6VM0i0MV0YVmuQwjIUyiMEF43ozB6Ea6witNPvMhHbuCe/yr+9m4KXa2fHvlAqJcuOdrbK8u9RtI0AHMezuPSZhTlE9Xdg1CNqxyWB6bszxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782762154; c=relaxed/simple;
	bh=eisgDwJoChmfOxhnhdE1EBDQRHA+NYYNIr8hh8Q71Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kR+6jhwJoggYeIguGWEYzmISq1IYCbk6rbz8M/GVvSjNRDGOCHiwPsXi4yb4I7pgma4Ct/nSKhVAmDZ+8nZ4kmKv9jkwL458r6yIrhu72vhYLCHSLXVgyL+EhegI7oX5Go1dvRYAZxghqG45VJCqMkskesrTjMf6tWfxCs6OySA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=MTE/RJlV; arc=none smtp.client-ip=195.121.94.183
X-KPN-MessageId: a92667e7-73f2-11f1-8f53-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id a92667e7-73f2-11f1-8f53-005056992ed3;
	Mon, 29 Jun 2026 21:42:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=U8kYk4h73EN1gbSEbGs+NhH7K8T3j0NEsT916ylrQy0=;
	b=MTE/RJlVpt406SEuZ9S4Zs4xvKMdAHfxOzvxjqLaDuKzJf8xa6VstHjlDQBUkhPJ6HgK3rUWULnNP
	 zg3RuOXeSc6W5mRr+u4WtuyPhQNnA7iUlqpSgAIGnukBkqBBxaqjafSh3j/V0bNUEGSqIToBuOM0B8
	 Z8FZYu4G4BFRm9i0X6AABprZz23ilZMfV2HXhzQYRB/fGeAfRuY1pba+LLeYLp5EhI+VgdnlPqbMQf
	 X2PIfhE/s+N+AKTbcKwWabL8x90BJ5UQ8FfvQaNxZL7qlFo5XWcHE/CYyJRmjAYCMJow1+rKI/EZBw
	 wSjnlXOKmVueoKgbFcDoyBdJ+iH6tFQ==
X-KPN-MID: 33|XQVGMnIiPW5ttzXC5x2jjiD4udTEIZBQJ+il4wHByVByM2dgRT8316wd9Rkd0EX
 rQwMWhkA/AjFFsAycXqzM/pyLSq7z7Wdo/qsS4iERqJg=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|TguCKMKkpxNhoi/SI8Xo3ozXprd+xXv2ZqFysXVVZF+uh4p+hzCNSmfHsvzx5mV
 iDRuukju1xBFBsgf/zLVPAA==
Received: from daedalus.home (unknown [178.231.11.185])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id a62aec0f-73f2-11f1-8076-005056998788;
	Mon, 29 Jun 2026 21:42:28 +0200 (CEST)
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
Subject: [PATCH net-next v3 0/5] af_unix: useful handling of LSM denials on SCM_RIGHTS
Date: Mon, 29 Jun 2026 21:43:22 +0200
Message-ID: <20260629194327.2270798-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
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
	TAGGED_FROM(0.00)[bounces-302817-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[xs4all.nl:dkim,xs4all.nl:mid,xs4all.nl:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F21586DE79B

Right now if some LSM such as Smack denies an AF_UNIX socket peer to
receive an SCM_RIGHTS fd, the SCM_RIGHTS fd array will be cut short at
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
v3:
  - Separated net and vfs changes.
  - Use kselftest_harness.h and system() to call the test script.
v2: https://lore.kernel.org/netdev/20260616143020.3458085-2-jkoolstra@xs4all.nl/
  - Reimplemented as a UNIX socket option instead of a per recvmsg(2) flag.
v1: https://lore.kernel.org/netdev/20260428175125.2705296-1-jkoolstra@xs4all.nl/

Jori Koolstra (5):
  net: scm: move scm_detach_fds() from common path to scm_recv_unix()
  vfs: add function receive_fd_filtered() that makes LSM filtering
    explicit
  net: af_unix: useful handling of LSM denials on SCM_RIGHTS
  net: af_unix: replace copy_from_sockptr() with
    copy_safe_from_sockptr()
  selftest: Add tests for useful handling of LSM denials on SCM_RIGHTS

 fs/file.c                                     |  48 +++--
 include/linux/file.h                          |   2 +
 include/net/af_unix.h                         |   1 +
 include/net/scm.h                             |  15 +-
 include/uapi/asm-generic/socket.h             |   3 +
 net/compat.c                                  |   4 +-
 net/core/scm.c                                |  18 +-
 net/unix/af_unix.c                            |  18 +-
 .../testing/selftests/net/af_unix/.gitignore  |   3 +
 tools/testing/selftests/net/af_unix/Makefile  |   4 +
 .../selftests/net/af_unix/scm_rights_denial.c |  20 ++
 .../selftests/net/af_unix/scm_rights_denial.h |  38 ++++
 .../net/af_unix/scm_rights_denial.sh          | 174 ++++++++++++++++
 .../net/af_unix/scm_rights_denial_receiver.c  | 195 ++++++++++++++++++
 .../net/af_unix/scm_rights_denial_sender.c    | 126 +++++++++++
 15 files changed, 636 insertions(+), 33 deletions(-)
 create mode 100644 tools/testing/selftests/net/af_unix/scm_rights_denial.c
 create mode 100644 tools/testing/selftests/net/af_unix/scm_rights_denial.h
 create mode 100755 tools/testing/selftests/net/af_unix/scm_rights_denial.sh
 create mode 100644 tools/testing/selftests/net/af_unix/scm_rights_denial_receiver.c
 create mode 100644 tools/testing/selftests/net/af_unix/scm_rights_denial_sender.c

-- 
2.54.0


