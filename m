Return-Path: <netdev+bounces-258156-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKg2N1uPi2mhWAAAu9opvQ
	(envelope-from <netdev+bounces-258156-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 21:04:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 286BC11EE03
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 21:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C990330420A1
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 20:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD8232FA32;
	Tue, 10 Feb 2026 20:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="29VJnzi8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com [209.85.167.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335D0330317
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 20:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770753866; cv=none; b=O2ox/ntc0j0PUa4o+BPv/1UBH5N6LZfsAm82qGEB+rinYRMiT1jbQu/fsJVKLQXXUArCL4H2j7x/5867IWFiIq4eyretCo+1C/mfpxMHGqT+2mPRPWqfB+BzFWKHJxPbhbCN90z0GmpD2cJBSuX17wgxUhSekkW4/avnXvtLZco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770753866; c=relaxed/simple;
	bh=e5SSuykFlipK9PqYjGXDsXgHIaFhGRMaDYeKItICHH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g2sQP6IfUHR7z3cHgLZHDRtYoaJ118oH+cvK2r7JjtZ4AQE9QSFQBt7NCY1J8nxCh3u4z/FJ1j9czFVgym+6TXrPfA7zGFXcqdsLs1pJXM3xnsg+VIo705vi69U8zkEyvaHUmqyWOi1eDap8nW4TZVz31Gtu6FbCPHNlW78JbQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=29VJnzi8; arc=none smtp.client-ip=209.85.167.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oi1-f193.google.com with SMTP id 5614622812f47-45f053b7b90so771385b6e.0
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 12:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1770753863; x=1771358663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4jsi28fUWPw+r9cG+CpQI+hgTFcPE5YO6iQNcoWxmI=;
        b=29VJnzi8ABsyVClZwq3Ld6v0Uq1o6BVXzVsMaslBO3Gx6qf93LyA3oOhaGHyTh44tC
         ew4b3KIcwtDteug9nRv9vUBBsKm5ehSkuXAa8c+d9tPcYcgkI0bwzZytSUCFQwuWU+J5
         FsyRHAGduWKW8Q5O1nMpMJMuMXO4twfP70o2IMJPHnE0oxDyuZw7n6S9C3GWMhTWveC1
         FKiYmweFqSorlqKLw51Ir0j2kNkZmRi1pJK+E3JUK2v0Znzhj2HJlLahWq43pM5Jm/Ti
         JIUdyfBefj1YVJ2BfnRLjO5zUos96b6U70CnaNPNrE9olH08U5yhGdF1n+M5aH/ONiu+
         ZCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770753863; x=1771358663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l4jsi28fUWPw+r9cG+CpQI+hgTFcPE5YO6iQNcoWxmI=;
        b=jNiOpFo1I9ZHrFV/bqQ3kLwKKuzu+4pvoke91Rb+LESXzktqi8+Ty7YhEKTg4AlKWZ
         jSn4WlLtJDoPI9HZy+r2NU7huTp+r5L/G660Gm0iNtumIhjEWXNhi+CRgN73q8hqnTt0
         GpcytFInN3OyjgLWiJ9z7JAQLldm4skWt/roasxnpCJQ57Mw4CKDs+kzLUYj5XftsXKr
         SsLRIKyRW39kN5h+ItgNfSRFctCyfeQxghPj2rQa3H57g+tWFkgGD7bbTIT9O2uL4om1
         0Cc87Tc86nZ/jRdtsSinyO5dvwhNnU3E4/zFJ7EqngSo19wAXeqr96TJstrwLJ68koID
         dpbw==
X-Gm-Message-State: AOJu0Yz4IgObptC2GimKDh/LOxyQEVsgHprbAF7KYDkOz/xt+0f9cDzp
	t4CVCXgVZmRgSLehIDiyHyNs9lVAiPbGsBjhmOqgZSuWOsaorlgSBUd5HsJbbfbVA5gE1fFyy+K
	B/0K7Nh0=
X-Gm-Gg: AZuq6aKqlbpNV7E0e6Fb9cb176ozBGH+RWqYUG2eg5kPEO1j4JAaQS0L1SqR5zWgcG6
	QW1+mnNOiYY4Orj/krOEwRFyw0v9MxJklrHmzxiCI8yAwNLyg7PSTEEKM3VtOQJIddMZkSQb7t/
	uR76Cj/3y+8WhK5o6W0DDPkxICDCr7AI6F9Iz1aNIl1gcWwOg1G62yjRPuvf5udU9SP52BMw8yD
	JbRWZGx0UZydzDwx+NdjGH2F1u6UrGdtF8LX2heiBULfsMzqw9CMyK0NC9vlIX+y/tt1oXqiHVV
	MxrANXyvxmZ4s6Z2RMrBSr6BqrVx+vVv4f1U8EiNmZdQx2cCg0bMkEf4ojuvGlG6okD8uFkvbho
	KEb/3XnZ4GBUY8ZO9NcJvwpKYGZ8yOsIlyVsA8VZPxXA0vZ2xWYlqFyL6qiLTn/KzJzZGL/KwgC
	jtOhuNX92sBPfU4Wte/J5lb3dpOjv+qOcCWTqpH60J1A==
X-Received: by 2002:a05:6808:1a0d:b0:43c:8714:fe3c with SMTP id 5614622812f47-462fcc877f5mr8659929b6e.51.1770753862829;
        Tue, 10 Feb 2026 12:04:22 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:49::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-462fe9a12d0sm8510823b6e.1.2026.02.10.12.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 12:04:22 -0800 (PST)
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
Subject: [PATCH net-next 2/4] selftests/net: Export Netlink class via lib.py
Date: Tue, 10 Feb 2026 12:04:17 -0800
Message-ID: <20260210200419.3555944-3-dw@davidwei.uk>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258156-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,dama.to,meta.com,gmail.com,fomichev.me,blackwall.org];
	DMARC_NA(0.00)[davidwei.uk];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,davidwei-uk.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 286BC11EE03
X-Rspamd-Action: no action

Making rtnl newlink calls requires constants defined in Netlink class in
pyynl. Export it.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 tools/testing/selftests/drivers/net/lib/py/__init__.py | 4 ++--
 tools/testing/selftests/net/lib/py/__init__.py         | 4 ++--
 tools/testing/selftests/net/lib/py/ynl.py              | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index 8b75faa9af6d..a18e21069f7a 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -19,7 +19,7 @@ try:
     # Import one by one to avoid pylint false positives
     from net.lib.py import NetNS, NetNSEnter, NetdevSimDev
     from net.lib.py import EthtoolFamily, NetdevFamily, NetshaperFamily, \
-        NlError, RtnlFamily, DevlinkFamily, PSPFamily
+        NlError, RtnlFamily, DevlinkFamily, PSPFamily, Netlink
     from net.lib.py import CmdExitFailure
     from net.lib.py import bkg, cmd, bpftool, bpftrace, defer, ethtool, \
         fd_read_timeout, ip, rand_port, wait_port_listen, wait_file
@@ -31,7 +31,7 @@ try:
 
     __all__ = ["NetNS", "NetNSEnter", "NetdevSimDev",
                "EthtoolFamily", "NetdevFamily", "NetshaperFamily",
-               "NlError", "RtnlFamily", "DevlinkFamily", "PSPFamily",
+               "NlError", "RtnlFamily", "DevlinkFamily", "PSPFamily", "Netlink",
                "CmdExitFailure",
                "bkg", "cmd", "bpftool", "bpftrace", "defer", "ethtool",
                "fd_read_timeout", "ip", "rand_port",
diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
index f528b67639de..fec518c2a0dc 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -15,7 +15,7 @@ from .nsim import NetdevSim, NetdevSimDev
 from .utils import CmdExitFailure, fd_read_timeout, cmd, bkg, defer, \
     bpftool, ip, ethtool, bpftrace, rand_port, wait_port_listen, wait_file, tool
 from .ynl import NlError, YnlFamily, EthtoolFamily, NetdevFamily, RtnlFamily, RtnlAddrFamily
-from .ynl import NetshaperFamily, DevlinkFamily, PSPFamily
+from .ynl import NetshaperFamily, DevlinkFamily, PSPFamily, Netlink
 
 __all__ = ["KSRC",
            "KsftFailEx", "KsftSkipEx", "KsftXfailEx", "ksft_pr", "ksft_eq",
@@ -30,4 +30,4 @@ __all__ = ["KSRC",
            "NetdevSim", "NetdevSimDev",
            "NetshaperFamily", "DevlinkFamily", "PSPFamily", "NlError",
            "YnlFamily", "EthtoolFamily", "NetdevFamily", "RtnlFamily",
-           "RtnlAddrFamily"]
+           "RtnlAddrFamily", "Netlink"]
diff --git a/tools/testing/selftests/net/lib/py/ynl.py b/tools/testing/selftests/net/lib/py/ynl.py
index 32c223e93b2c..a52b067f7589 100644
--- a/tools/testing/selftests/net/lib/py/ynl.py
+++ b/tools/testing/selftests/net/lib/py/ynl.py
@@ -13,14 +13,14 @@ try:
         SPEC_PATH = KSFT_DIR / "net/lib/specs"
 
         sys.path.append(tools_full_path.as_posix())
-        from net.lib.ynl.pyynl.lib import YnlFamily, NlError
+        from net.lib.ynl.pyynl.lib import YnlFamily, NlError, Netlink
     else:
         # Running in tree
         tools_full_path = KSRC / "tools"
         SPEC_PATH = KSRC / "Documentation/netlink/specs"
 
         sys.path.append(tools_full_path.as_posix())
-        from net.ynl.pyynl.lib import YnlFamily, NlError
+        from net.ynl.pyynl.lib import YnlFamily, NlError, Netlink
 except ModuleNotFoundError as e:
     ksft_pr("Failed importing `ynl` library from kernel sources")
     ksft_pr(str(e))
-- 
2.47.3


