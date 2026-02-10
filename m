Return-Path: <netdev+bounces-258157-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGFgGliPi2mhWAAAu9opvQ
	(envelope-from <netdev+bounces-258157-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 21:04:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBDE11EDFC
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 21:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC51C304A205
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 20:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBE233121E;
	Tue, 10 Feb 2026 20:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="mMzlRZFb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCB2331A73
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 20:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770753868; cv=none; b=LfDxuCX1Y7IkBkjWDpj5LuC1w4UVA8VKd49B3IQEAvC8ApEDTcpAoqTbwcWDL96q5HlimYaaWNq05u+hvlDN87jwJRzSu97wA6qlNNkDgc7qPdFIJjuu/bggQVG0p6xLKJ1CjHgODA+zsue8hRI0nJ0c8IP8UpBP1aujQw6veWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770753868; c=relaxed/simple;
	bh=icHZY2wqQ9jqRK4LJNunuA+NRbPEqtIg1aKitJDaEGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kiIM3qSuC6kg0581qi6vpJqhBHC3PNI1cj4D3DUVzGNtTuq41I3VcsbaZfjsX2RW5K8kbkqoKkJJWuQlQNSjUCQYWhAUOEG+vP/q2yM89Wv/bitaUtDLZJxhMk6/vAh3mOtDAtyxGGmFAHSMDcioeRdNfG7NrK8yZYCuNCdzMu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=mMzlRZFb; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-3f9ebb269c3so2851324fac.3
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 12:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1770753865; x=1771358665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pdi5TfqHB20Phx1gxNlcCaQkHXP3aF10Zkb2EJi23sI=;
        b=mMzlRZFbsua6y5W8VzQolOnvShVDUnbN0pRj/eiRTbQVKYcYFpI6SkC3G/nRPzCydC
         Rtrv408fNFWKuMExCEYQNKwap5UiKfAYcE/ucjrIj/Z4UwjXjKmKmv47whB9BOaGXeJT
         sPEl5uTV1UTkOuAMU8JePFIsVLCLph/MAIbQhN2+JO/YLCJ5r/9LcXW4so47QlGSFSDl
         FKIKZYX8U0AP/TZOy8gQeDRksISxpFBYUAQH0uegJX6J1UD8IBV36jh46auvOfG6W3os
         9GI/b/uUWEJG6wjtcma3FivZZOTO0CKIUnuHyBUyvKo7Af57CV8Fx45udRMDfaFTakA0
         EtFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770753865; x=1771358665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pdi5TfqHB20Phx1gxNlcCaQkHXP3aF10Zkb2EJi23sI=;
        b=GsMt9Y0zjtVFk0FttTEswfZHbEc698tmk4g2UfH4blGdtJdC6dLd6DTilqboezu8+J
         1YF1k8kulL54twI+eRl36Nl5fItU1IrejsYij6ur6i2g7DTxAu4fM6Peev0mZiggglPW
         Epi3YEEsXew9iamMOgp78W37jksOcu8MGpICSetkOy8CleHsWmnZBZhwvV1/xCgycGbU
         fGJOW5g3703IblKxJyOSrWpjlvoQ74JJkcL3wtE3zZJ5AedQvIDbS68HYF2AJXN+aJE0
         4KFf4FR4CDftFXeWhRIABWth4+mw++pns5icptXDWGjpuWfpbEAtm4MIK4TwiirwjMV+
         PRqw==
X-Gm-Message-State: AOJu0YzvmUbBgDy5TsGmUOkqkVAcIC3YqH6bs/jUwngXoGOEgcsIdOUp
	AHZ9BF+FXVgcQlUY+RcW1XoBsXVWKKF/Y5E9TPKZFaJAqIm1sdPl4N+GX8g98WpGiSVhbYR/FUi
	HffAR
X-Gm-Gg: AZuq6aJsh5qAAK5VwrsW7O5A7zgLvozJtREnCOSRC8hiFVz/yzJ0XCyIdAVDRcPBDHI
	lIwytEwAFf1gG/EHxhoZ3+AXy2ernhm3nyvc6cMDc4jUDYjCCQ/4TtJX7VxsHeM8z9Dvley3D9C
	tDKc0jU76J2+eywz/thd7B/7W0FnaJwOcx+StqPYLkjNBzYiTfaWjqF+AZhkjvYp0Qe+ohfylOe
	HoJLkSOUwPF6EXhBDlEMboBXljrI38ntxOE+uWU6+Y3JSuvgzYBR2vyJasPOocwAiQxdSpXh0wU
	+w0FAOnt37Q1pDo1j91I80VjDqgFX2/nG3Xx8IAMUD/qxZ57LzO2xMRnE62ebA/wi6qvg5qBntr
	ydM8a13D9VpPmnmEeju1ri9Md2kKmQ4rLrTENJVsD09LLrQ0k5Wix5brLELtRx8nsuROjLqNkpF
	x4SHohu3nFjebK5kK10jbaOX8MlCajmvBma486tDxsjw==
X-Received: by 2002:a05:6871:2ea1:b0:409:7d3a:bfe1 with SMTP id 586e51a60fabf-40e5149c808mr1775276fac.13.1770753865102;
        Tue, 10 Feb 2026 12:04:25 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:4c::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40a992edd71sm11008082fac.5.2026.02.10.12.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 12:04:24 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Joe Damato <joe@dama.to>,
	Wei Wang <weibunny@meta.com>,
	Bobby Eshleman <bobbyeshleman@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next 4/4] selftests/net: Add netkit container ping test
Date: Tue, 10 Feb 2026 12:04:19 -0800
Message-ID: <20260210200419.3555944-5-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260210200419.3555944-1-dw@davidwei.uk>
References: <20260210200419.3555944-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[davidwei-uk.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258157-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,dama.to,meta.com,gmail.com,fomichev.me,blackwall.org];
	DMARC_NA(0.00)[davidwei.uk];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dw@davidwei.uk,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[davidwei-uk.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,davidwei-uk.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: BBBDE11EDFC
X-Rspamd-Action: no action

Add a basic ping test using NetDrvContEnv that sets up a netkit pair,
with one end in a netns. Use LOCAL_PREFIX_V6 and nk_forward BPF program
to ping from a remote host to the netkit in netns.

Signed-off-by: David Wei <dw@davidwei.uk>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../testing/selftests/drivers/net/hw/Makefile |  1 +
 tools/testing/selftests/drivers/net/hw/config |  3 +++
 .../selftests/drivers/net/hw/nk_netns.py      | 23 +++++++++++++++++++
 3 files changed, 27 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/nk_netns.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index a64140333a46..91df028abfc0 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -32,6 +32,7 @@ TEST_PROGS = \
 	irq.py \
 	loopback.sh \
 	nic_timestamp.py \
+	nk_netns.py \
 	pp_alloc_fail.py \
 	rss_api.py \
 	rss_ctx.py \
diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testing/selftests/drivers/net/hw/config
index 2307aa001be1..b6524040418e 100644
--- a/tools/testing/selftests/drivers/net/hw/config
+++ b/tools/testing/selftests/drivers/net/hw/config
@@ -1,3 +1,4 @@
+CONFIG_BPF_SYSCALL=y
 CONFIG_FAIL_FUNCTION=y
 CONFIG_FAULT_INJECTION=y
 CONFIG_FAULT_INJECTION_DEBUG_FS=y
@@ -5,6 +6,8 @@ CONFIG_FUNCTION_ERROR_INJECTION=y
 CONFIG_IO_URING=y
 CONFIG_IPV6=y
 CONFIG_IPV6_GRE=y
+CONFIG_NETKIT=y
+CONFIG_NET_CLS_BPF=y
 CONFIG_NET_IPGRE=y
 CONFIG_NET_IPGRE_DEMUX=y
 CONFIG_UDMABUF=y
diff --git a/tools/testing/selftests/drivers/net/hw/nk_netns.py b/tools/testing/selftests/drivers/net/hw/nk_netns.py
new file mode 100755
index 000000000000..afa8638195d8
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/nk_netns.py
@@ -0,0 +1,23 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+from lib.py import ksft_run, ksft_exit
+from lib.py import NetDrvContEnv
+from lib.py import cmd
+
+
+def test_ping(cfg) -> None:
+    cfg.require_ipver("6")
+
+    cmd(f"ping -c 1 -W5 {cfg.nk_guest_ipv6}", host=cfg.remote)
+    cmd(f"ping -c 1 -W5 {cfg.remote_addr_v['6']}", ns=cfg.netns)
+
+
+def main() -> None:
+    with NetDrvContEnv(__file__) as cfg:
+        ksft_run([test_ping], args=(cfg,))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.47.3


