Return-Path: <netdev+bounces-251574-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2C3oIPXbb2n8RwAAu9opvQ
	(envelope-from <netdev+bounces-251574-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 20:48:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A594AB76
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 20:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5F47F35E9A2
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 18:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E33441024;
	Tue, 20 Jan 2026 18:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8AP+0Rk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C95B426687;
	Tue, 20 Jan 2026 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768932204; cv=none; b=mZJ4sm4/WbypkzPolok724CmRG6NSiAjqzqGS1ulIE5cunRGR9TdshKbuDQcJS3EeRNMRb+TY/sNqiwEHuuUDEIhc43gwM5/jf1U1WeVf49er05oi+17qK6HyP/wSIJEViBmZELzyG1wbX6ukRgsPy0pw+4aowgTG5mfucgkPjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768932204; c=relaxed/simple;
	bh=Am3rZMrXWgdmBEKyRk0Vap2KbR2TTr9+UxoU2DYIAAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hrUZgb+qE1vDOWZb9AhiscMTU0oZMpvZ4bta/nDzwblhZDQIaU9ilOKjLBa0DRRKeTHLXqSVBzfnhS9rNkplejZWyuVFOlBWivpMDJQ4fUJcnajcCTwTcLq6XMv2xwQctAdPsEn6RwwCwzswXkIhCyXrG/ecXiNwPiR4ObBHXZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8AP+0Rk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ECF3C16AAE;
	Tue, 20 Jan 2026 18:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768932202;
	bh=Am3rZMrXWgdmBEKyRk0Vap2KbR2TTr9+UxoU2DYIAAM=;
	h=From:To:Cc:Subject:Date:From;
	b=E8AP+0Rk6iwgLaCX6a8S5p00ne/IEJcgrJEKpGuAZ4aowlKBCaidO1b8feebvSr/V
	 CAN+ZEs/P9XS8PVaTFu+eBEW7kmcWCylxsS83MupVZVYmXrfUVyNCXzQByX4RVjPF0
	 H83HvO97wE1JvgjowD7pyiAAatr3A4lZoEoxjSrN7hj3hZ4mKqaOPja22Cpgb0QAig
	 +7N/U8A3iuCuys91Kc405W2hxdvMa/ddtznVpDaiETB/MUlgKEGvjdjUhpiXfQPxKJ
	 qRdj3VHCFXo4KTO17zpTAWIQqiJKc1oehLPr1kxDfwpLi3gQXZQN1pq8LwrbcFjLS4
	 BifWBzfqK3A7Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	sdf@fomichev.me,
	almasrymina@google.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: drv-net: fix missing include in ncdevmem
Date: Tue, 20 Jan 2026 10:03:19 -0800
Message-ID: <20260120180319.1673271-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-251574-lists,netdev=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,fomichev.me:email]
X-Rspamd-Queue-Id: 30A594AB76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit ca9d74eb5f6a ("uapi: add INT_MAX and INT_MIN constants")
recently removed some includes of limits.h in uAPI headers.
ncdevmem.c was depending on them:

  ncdevmem.c: In function ‘ethtool_add_flow’:
  ncdevmem.c:369:60: error: ‘INT_MAX’ undeclared (first use in this function)
  369 |         if (endptr == id_start || flow_id < 0 || flow_id > INT_MAX)
      |                                                            ^~~~~~~
  ncdevmem.c:77:1: note: ‘INT_MAX’ is defined in header ‘<limits.h>’; did you forget to ‘#include <limits.h>’?

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: sdf@fomichev.me
CC: almasrymina@google.com
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/drivers/net/hw/ncdevmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index 3288ed04ce08..16864c844108 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -48,6 +48,7 @@
 #include <errno.h>
 #define __iovec_defined
 #include <fcntl.h>
+#include <limits.h>
 #include <malloc.h>
 #include <error.h>
 #include <poll.h>
-- 
2.52.0


