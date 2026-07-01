Return-Path: <netdev+bounces-303768-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9W+SFvtBRWoZ9goAu9opvQ
	(envelope-from <netdev+bounces-303768-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:36:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1C76EFD9E
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:36:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=bleQLgTr;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=xOfj7SO5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303768-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303768-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A64E305615F
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 16:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E942B372B3D;
	Wed,  1 Jul 2026 16:36:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30709372042;
	Wed,  1 Jul 2026 16:36:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782923767; cv=none; b=YHdPHLL8OQUiYn74230xF7EulrZ4/EW1SU9SN+Dj/v43XAkeRGBuMYnFXIm8MBVTAS8PiecrYzFhc3obN41zr/pHLHslbsDXqd1BCSad6GOwYDLJJsIybOGHn6YD0Rv0Ku9g2PUXXSixNTqfZc6qVF/lY0qUHUZkettthIMQFJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782923767; c=relaxed/simple;
	bh=CroDMHHmiIQyna0VCr/XtFwno+upP7Q2YV/zU8bejh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jaEhCaQo2scCGWJ85IJqT0y4WVjv0V5HEDJcWrL3lYaCknyeoRMbyg4AuT7QEW+gu1KTIc78PVG8n9hMpRmy9WyBlsZp5/IFiQfKs6wUOg/Bvm6tWxBnkZXOPWrY+bzGY51RSTRHupp3q4lMZJFLAFoyRIDTmu4uUp9WCwQmRAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bleQLgTr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xOfj7SO5; arc=none smtp.client-ip=193.142.43.55
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782923762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rUTUUgOylEJnjpHRy1A8ekyG049f1No/xJYdiwGlZcE=;
	b=bleQLgTrGeFx/D60sT7TK56L6eDCCeklZS153G7xhlf1vq6xYzZG+cujkWDi8VRU/OPUYu
	aL4JG50tGePOK42H4iPs8psejwyKuoG67W0xyHqYjvB+fjOCruy/Y2v2f5GNocV4hnxHWu
	8pvStidTIKn0XlEdOOvw+0bajGltPBWYnd/X9+M509FJ2zxsmS9YRrzsdZmtGyfELafiHv
	aVxbDlqom92Qp9CfGp3CxcTIbibkFMdYU3QplXrOJ8w2qcfcpOSaMeSX5voHGPU8Vvqqj3
	GPRISMI8OyaiFIk1VYHEokDtX7FaNZbEavl2/FQhieHc6lOhEHZXVktVp8DqFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782923762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rUTUUgOylEJnjpHRy1A8ekyG049f1No/xJYdiwGlZcE=;
	b=xOfj7SO5mTVldqoNKtg1NhWXMTkcvrO73aYM0C44x4EQAXu6DkqY6Yr/g6epcK9bhanbj0
	IVonhdpo1+pOMQDw==
To: Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 0/2] af_unix: Fix priority inversion issue
Date: Wed,  1 Jul 2026 18:35:52 +0200
Message-ID: <cover.1782922354.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303768-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[namcao@linutronix.de,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rt-devel@lists.linux.dev,m:namcao@linutronix.de,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namcao@linutronix.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linutronix.de:dkim,linutronix.de:mid,linutronix.de:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DA1C76EFD9E

Hi,

While auditing AF_UNIX sockets, I noticed that the sendmsg() code paths may
block on the garbage collector running as workqueue. This can cause
priority inversion and latency for real-time users.

The implementation does kindly avoid blocking "sane users". However, it is
impossible to tell whether the kernel's definition of "sane users"
accurately describes all users out there.

Digging into history and figuring out the reasons why sendmsg() needs to
wait for garbage collector, it is determined that those reasons no longer
apply.

The first patch remove that block, and the second patch is a simple
post cleanup.

Nam Cao (2):
  af_unix: Do not wait for garbage collector in sendmsg()
  af_unix: Clean up unix_schedule_gc()

 net/unix/af_unix.c |  2 +-
 net/unix/af_unix.h |  2 +-
 net/unix/garbage.c | 16 +---------------
 3 files changed, 3 insertions(+), 17 deletions(-)

--=20
2.47.3


