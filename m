Return-Path: <netdev+bounces-282032-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mK/oH7Hz8GnUbQEAu9opvQ
	(envelope-from <netdev+bounces-282032-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:51:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D946B48A350
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46F273021E62
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EB0450902;
	Tue, 28 Apr 2026 17:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="HEJPERLN"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C104508E4
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 17:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777398701; cv=none; b=dpH7vtngMGXMnT1mJq18V7NUIP2fDbr3Z5KncBrvGz1i1bOAvaQ0F8EKGYiqr9qy5Xm7t5w8XxELxjbq7hl+sCAgJVy4fj0Hne96EL4RijLGB2bXdW+vVabISZKMuoqF2AjN81S2amXyXRJYl5q5qAKKea99hXHJPPA/XQOZWQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777398701; c=relaxed/simple;
	bh=n9FVdQ1uEyi/PBlzCmOggXo6+G6h3ePsoXtn35YHVIY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VULi1QfEn0B9xVq199Yq5251AC1ajnXG9LrUJf7FYdA3IqU9EdvsGvcThNq9Zq7fsyu9t/4vLmtqSE+p63dnNK+5Dusm3DIVTTf1O9+eweN/7p7WkwEMckyYeFTfmyb8csfyxc5VJY6KSbiK6qrnJJpfzfQmwr2wGw8evs8COeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=HEJPERLN; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: e362cf5a-432a-11f1-969c-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id e362cf5a-432a-11f1-969c-005056abbe64;
	Tue, 28 Apr 2026 19:51:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=ZRY63AiAXDrQrXJ2zE2OgHCwlnaw+JKlAYeAAzR3Zj0=;
	b=HEJPERLNkdWMrQWAi5DCd1Ap5Dib3eYUVsZyGRtqEcjEOsFPEevvkx0EaVLNCN9G2BlCp2IPeH1Q1
	 xnldk9R1vx+BHYTyENmiYfbIRrCmcS6Ng8xnOHZTGs36121roABC4vWKepDtVo6QdrZ+FEx0R6M2Yk
	 Mf9pIAJVtYbsRtR0pPDFUM70GOxD8XAGaX1MLwGE3iEUwxWO8KBn9auS4VBGZ8vYw+jEW1EeAWVAx9
	 E5jYWp6pbGm3O8Wx4jHscNsXcdVQIuI91Om60DUhKTglvd/92h2DO5YhL7BDrnyyWBV5+ioAxN5+ay
	 9YjuiW3qjE++e2giGXE8jlbLC0HAnTw==
X-KPN-MID: 33|R/lK9H93AizS+hzyOwdleLBowpfl+uzeoSJgGdlgYc+JgmN7z2RXMyR6cPzbs7x
 CW4nuOdyM6b8kl0HwLKwdYj5FGVFSGDMTEM2Y1xjzL10=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|liyIqlP40w2KDfUk5LEuceqffi6LGR5FYkPPcC6K+JY8x+ru9yMGdh2ieIw37OK
 +30cQP/JJ569HPhzLtFt8Yw==
Received: from daedalus.home (unknown [178.227.109.38])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id e088b9af-432a-11f1-b8eb-005056ab7584;
	Tue, 28 Apr 2026 19:51:30 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Kees Cook <kees@kernel.org>
Cc: Simon Horman <horms@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Jeff Layton <jlayton@kernel.org>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Oleg Nesterov <oleg@redhat.com>,
	Andrei Vagin <avagin@gmail.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Joel Granados <joel.granados@kernel.org>,
	Charlie Mirabile <cmirabil@redhat.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: [RFC PATCH 0/2] net: af_unix: Useful handling of LSM denials on SCM_RIGHTS
Date: Tue, 28 Apr 2026 19:51:23 +0200
Message-ID: <20260428175125.2705296-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D946B48A350
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[xs4all.nl,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[xs4all.nl:s=xs4all01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282032-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,amacapital.net,chromium.org,xs4all.nl,redhat.com,gmail.com,virtuozzo.com,cyphar.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[xs4all.nl];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkoolstra@xs4all.nl,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[xs4all.nl:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xs4all.nl:dkim,xs4all.nl:mid]

Right now if some LSM such as Smack denies an AF_UNIX socket peer to
receive an SCM_RIGHTS fd the SCM_RIGHTS fd array will be cut short at
that point, and MSG_CTRUNC is set on return of recvmsg(). This is
highly problematic behaviour, because it leaves the receiver
wondering what happened. As per man page MSG_CTRUNC is supposed to
indicate that the control buffer was sized too short, but suddenly
a permission error might result in the exact same flag being set.
Moreover, the receiver has no chance to determine how many fds got
originally sent and how many were suppressed.[1]

Add two MSG_* flags:
 - MSG_RIGHTS_DENIAL is set whenever any file is rejected by the LSM
   during recvmsg(2) of SCM_RIGHTS fds.
 - If MSG_RIGHTS_FILTER is passed as a flag to recvmsg(), the SCM_RIGHTS
   fd array is always passed in its full original size. However, any
   files rejected by the LSM are replaced in this array with -EPERM
   instead of an assigned fd, while keeping the original order. If the
   flag is not set, the original truncate behavior is used.

I am putting this out for RFC for two reasons:

1) The MSG_* space is quite limited. We can do without MSG_RIGHTS_DENIAL 
   if needed.
2) Does userspace ever do anything else than bail out if MSG_CTRUNC is
   found set? If not, we could maybe also get rid of MSG_RIGHTS_FILTER
   and just make this the default behavior.

[1]: https://github.com/uapi-group/kernel-features#useful-handling-of-lsm-denials-on-scm_rights

Jori Koolstra (2):
  net: af_unix: Useful handling of LSM denials on SCM_RIGHTS
  selftest: Add tests for useful handling of LSM denials on SCM_RIGHTS

 fs/file.c                                     |  21 +-
 include/linux/file.h                          |   4 +-
 include/linux/socket.h                        |   3 +
 include/net/scm.h                             |   8 +-
 io_uring/openclose.c                          |   2 +-
 kernel/pid.c                                  |   2 +-
 kernel/seccomp.c                              |   2 +-
 net/compat.c                                  |   7 +-
 net/core/scm.c                                |  11 +-
 .../net/af_unix/lsm_blocking/helper.h         |  37 ++++
 .../net/af_unix/lsm_blocking/receiver.c       | 187 ++++++++++++++++++
 .../net/af_unix/lsm_blocking/sender.c         | 126 ++++++++++++
 .../lsm_blocking/test_scm_rights_smack.sh     | 172 ++++++++++++++++
 13 files changed, 563 insertions(+), 19 deletions(-)
 create mode 100644 tools/testing/selftests/net/af_unix/lsm_blocking/helper.h
 create mode 100644 tools/testing/selftests/net/af_unix/lsm_blocking/receiver.c
 create mode 100644 tools/testing/selftests/net/af_unix/lsm_blocking/sender.c
 create mode 100644 tools/testing/selftests/net/af_unix/lsm_blocking/test_scm_rights_smack.sh

-- 
2.54.0


