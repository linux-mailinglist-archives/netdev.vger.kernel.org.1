Return-Path: <netdev+bounces-263855-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OakAF5OqGmvsgAAu9opvQ
	(envelope-from <netdev+bounces-263855-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 16:23:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5009C20292B
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 16:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAE3430C2F85
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 15:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4617B3242B5;
	Wed,  4 Mar 2026 15:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kP9BjpKE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2354624676D;
	Wed,  4 Mar 2026 15:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772637410; cv=none; b=IfFIwjI1WV/enKkxrqVjtglnQZWxy1dfMLsa/p32OGHeRXx3v5ZXZ6VgEYjZtRkU3LohCM4/K2wsb5OJNzgWVLm3s2dlzFkZmaG++A3xdcqibmHKLB+GO8ku3NqsseuqWoqxKDjcD9Ze7l3SBGfJzKfqnSV23d1QeCcrcXwO3AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772637410; c=relaxed/simple;
	bh=Hwalj6XGGeHJHa78r5hc0CzaU3kjmvKcFZnz/ZUApGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VOMRQZw+VcuObkHqu1sUyFf6MqKF4LlU6q9ul8dt/GoHxtOgmV+H1OWytnqKDX69mwRHPSBzuwbrbr89k/ZqaM1V4pkCupSig6dMKn4Y+rfm2xgMaahJxuSHpz/OYRQ0zceHhzaKQL1qaPu6DP0V1WL9ziC7LG31gjHJjct8CqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kP9BjpKE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4A5C4CEF7;
	Wed,  4 Mar 2026 15:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772637409;
	bh=Hwalj6XGGeHJHa78r5hc0CzaU3kjmvKcFZnz/ZUApGQ=;
	h=From:To:Cc:Subject:Date:From;
	b=kP9BjpKEgVUse0CsIZYAp+9Aw4PewrgVr24UbBpYTEYxGJ7wLuj0W4Tc0t/kFeWbH
	 tI4ROeHMM+bCxICrweSU04teCK9rCHkiy7xUe6iW3LuJgH41e9mlajsXRsX+gni7xL
	 YT4MP45Yh/mDuMPyDDe5VSitq3PJD+Gxss9xwxqpi9SSZi3M9sYTINCI3CPSDIxRQ0
	 FD2cDYc+21busLPjtewCzOjPlXTCYwcqGZORgGUM7HvyXoAOHZB4tMn6/GmAkQk4fk
	 C+ffaukk1XvRvTXUdYMkLAwlZs6QEbcARI/Q1cJhQ2vimK+TIFkpR+xVkOQy9YsUa0
	 oxN3f/g9IMtuw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next] docs: netdev: refine netdevsim testing guidance
Date: Wed,  4 Mar 2026 07:16:46 -0800
Message-ID: <20260304151647.2770466-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5009C20292B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263855-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lwn.net:email,linuxfoundation.org:email]
X-Rspamd-Action: no action

The library to create tests for both NIC HW and netdevsim has existed
for almost a year. netdevsim-only tests we get increasingly feel like
a waste, we should try to write tests that work both on netdevsim and
real HW. Refine the guidance accordingly.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: corbet@lwn.net
CC: skhan@linuxfoundation.org
CC: workflows@vger.kernel.org
CC: linux-doc@vger.kernel.org
---
 Documentation/process/maintainer-netdev.rst | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
index 6bce4507d5d3..3aa13bc2405d 100644
--- a/Documentation/process/maintainer-netdev.rst
+++ b/Documentation/process/maintainer-netdev.rst
@@ -479,8 +479,14 @@ netdevsim
 
 ``netdevsim`` is a test driver which can be used to exercise driver
 configuration APIs without requiring capable hardware.
-Mock-ups and tests based on ``netdevsim`` are strongly encouraged when
-adding new APIs, but ``netdevsim`` in itself is **not** considered
+Mock-ups and tests based on ``netdevsim`` are encouraged when
+adding new APIs with complex logic in the stack. The tests should
+be written so that they can run both against ``netdevsim`` and a real
+device (see ``tools/testing/selftests/drivers/net/README.rst``).
+``netdevsim``-only tests should focus on testing corner cases
+and failure paths in the core which are hard to exercise with a real driver.
+
+``netdevsim`` in itself is **not** considered
 a use case/user. You must also implement the new APIs in a real driver.
 
 We give no guarantees that ``netdevsim`` won't change in the future
-- 
2.53.0


