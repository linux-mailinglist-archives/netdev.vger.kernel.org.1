Return-Path: <netdev+bounces-264509-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNc9ISHJqWkAFAEAu9opvQ
	(envelope-from <netdev+bounces-264509-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 19:19:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C58216E9B
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 19:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC806306B09D
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 18:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31C83CB2E7;
	Thu,  5 Mar 2026 18:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="OLDCSxjJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD4D3CF67F
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 18:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772734704; cv=none; b=E6bF2inWMonlopr1VRFLNdCSEeo84tQ+yu/E+Ey6mozErY5eta1r1BDkIoGIp+GvYkfr4zlSjQLrY7hXGBnpOQnR/XiF6RyrITNzooVsYYfLLXOu47Xg3T1GaE1+9e+UUKhlke+GiCxb6m7MNzZvOhLXeOIeZG3oaGjNg9bW5tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772734704; c=relaxed/simple;
	bh=Q7YUcUBZ5CpKpRue7jfrBx9l650uBSzIJ3m4i6MWYRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SiqBp8ahJjZCSXvnG9PAy78R01XOCaYWNEp3N4Ci/WobW5i3bHm0eBQvTO708T7ywypAPwshGX5d/v4WZ/gLUzHZBOZsdLQg3+RYZX7BjeIWW+IzpNHeZ9OlUnFyesCK4IoeBbRGEUnRt7I6bNmGiwlQLZ1HujUIdkfv7CS2yrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=OLDCSxjJ; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-67a22322cebso1729948eaf.0
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 10:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1772734702; x=1773339502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlJKKMG/buku6oNuEJcGlPdtNe6GA9AHm1QSZu33fyc=;
        b=OLDCSxjJ96abLbWcmHuWGh79L3XLxGelcd1+qHtSvl6bPqznMOL9/zRXVMfqIdg2kU
         EOGmF/PvenjZj2ZUR4QyqYza+/wJaoZk9af7V4sMxU6iV7mvqD7SsEHf6nb00fIrSbv7
         fcUHgS85xuWskpXTF5zPpLFrhYeeCsryXrs6inEZJ07djwpajtpQ7QjwCN7rr+C5KKZb
         AcvQ2jmMov/rhogot16DjZYxEpfUOBHl9FjBO8X1QczkZMmH46pVkSwsAJgDo1j21kuA
         iWGFi/uY5zwu0P+yC2zMbLM91kJTyetWU2HVizxAH5RqQ2ughPmREbnxxWk73g1cXyOX
         ZuNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772734702; x=1773339502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IlJKKMG/buku6oNuEJcGlPdtNe6GA9AHm1QSZu33fyc=;
        b=g/+qkQwoM9YDuL1aYk+3kYjhU1xBUjnhuQmzB5NKkkfv6PBlF1eWsAGRkcQKa+sEsP
         THmgk0zmWyn4t+4a5WNf4yOuiadvWBrz/sbeiAU4zc14Z7VwRe0U9kbdXEv1ievZES24
         lTwptj8NIrNNYcQJI1d2uwirH/Qvmvh33qemi4XyQH8V9hmS2YVW7ixW1ygVZgu2Al5D
         2oSuBbvjkRNEICoLIs5pwA0Vlg0mmQNzAFqKwRwbSlBYYdvJHOSGWTNsR7Ny11C7By/g
         5l3+CPcw2sCeNilgvToE9ZJ3xDXxnNSrfI29+jmGy9EUalCAyVHgRvJRQjkUCVG00F54
         Zg3A==
X-Gm-Message-State: AOJu0YwJXPq82nGe+ZSjXh94Sxw8YbY5Z5LrtsjH8j4lLIMr2HVMg5To
	tK5S8qEutam227v8lrS0DWxgVGfU2sNJ1o9RzGXOYdfKtwDRVfGJOL6A57trPjKGTVxB0wSF3OP
	78/+5
X-Gm-Gg: ATEYQzw+zfHrKJfexMJLDVL5w/YZENmP8HBeWRapoI1cJeEcNFwGRU7KlVwX/LAeM7R
	se/uzFOooM4gUFsDX+6yHMNUYZKn2SsZVrr3dC/F9n5TMUgdHTe0qXFfwBHQw8FnmU13gpFwvfM
	wLjS+vmGMvCM4o/xTaMB/iw+3RSh7fNx7/w+f4pri5v2DCr5nx+3UrNUruPEt6m3D1eVk8zxwEm
	7gjR5HB4N/WhZHX5CAu8w0cNTe8gDYqVe6WRrDyTCe7EbhDETvVnXJ4C0+8jE6sTTGZVB3ZEgz4
	xjsTjr7l8TFIL3GiWBA4nH+IdzvaXuK0YIwsWD8nmOL26kXBDJA0+E8uTYfICYWTs8bh+o0l4DF
	pugpey5Seus7I7mMPN+Jij2L373O5x9zYDKYmAIYc+Kksr5AIWzkGOeuJMe/7WTip3NZBoJG4MU
	4zPcf60hVYWBoBQo5vWQVqC90/iZMS6T9BGokKndThDtmjE20jkABF
X-Received: by 2002:a05:6820:812:b0:679:e7ba:79de with SMTP id 006d021491bc7-67b1e915370mr3997381eaf.67.1772734702437;
        Thu, 05 Mar 2026 10:18:22 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:73::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2db737bsm15852325eaf.15.2026.03.05.10.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 10:18:22 -0800 (PST)
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
Subject: [PATCH net-next v3 2/4] selftests/net: Export Netlink class via lib.py
Date: Thu,  5 Mar 2026 10:18:01 -0800
Message-ID: <20260305181803.2912736-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305181803.2912736-1-dw@davidwei.uk>
References: <20260305181803.2912736-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D9C58216E9B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[davidwei-uk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264509-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,dama.to,meta.com,gmail.com,fomichev.me,blackwall.org];
	DMARC_NA(0.00)[davidwei.uk];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dw@davidwei.uk,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[davidwei-uk.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Making rtnl newlink calls requires constants defined in Netlink class in
pyynl. Export it.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 tools/testing/selftests/drivers/net/lib/py/__init__.py |  4 ++--
 tools/testing/selftests/net/lib/py/__init__.py         |  4 ++--
 tools/testing/selftests/net/lib/py/ynl.py              | 10 ++++++++--
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index 5872d114f142..e5ef5e949c12 100644
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
         fd_read_timeout, ip, rand_port, rand_ports, wait_port_listen, wait_file
@@ -31,7 +31,7 @@ try:
 
     __all__ = ["NetNS", "NetNSEnter", "NetdevSimDev",
                "EthtoolFamily", "NetdevFamily", "NetshaperFamily",
-               "NlError", "RtnlFamily", "DevlinkFamily", "PSPFamily",
+               "NlError", "RtnlFamily", "DevlinkFamily", "PSPFamily", "Netlink",
                "CmdExitFailure",
                "bkg", "cmd", "bpftool", "bpftrace", "defer", "ethtool",
                "fd_read_timeout", "ip", "rand_port", "rand_ports",
diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
index a584e7f806a4..54e84282781c 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -16,7 +16,7 @@ from .utils import CmdExitFailure, fd_read_timeout, cmd, bkg, defer, \
     bpftool, ip, ethtool, bpftrace, rand_port, rand_ports, wait_port_listen, \
     wait_file, tool
 from .ynl import NlError, YnlFamily, EthtoolFamily, NetdevFamily, RtnlFamily, RtnlAddrFamily
-from .ynl import NetshaperFamily, DevlinkFamily, PSPFamily
+from .ynl import NetshaperFamily, DevlinkFamily, PSPFamily, Netlink
 
 __all__ = ["KSRC",
            "KsftFailEx", "KsftSkipEx", "KsftXfailEx", "ksft_pr", "ksft_eq",
@@ -31,4 +31,4 @@ __all__ = ["KSRC",
            "NetdevSim", "NetdevSimDev",
            "NetshaperFamily", "DevlinkFamily", "PSPFamily", "NlError",
            "YnlFamily", "EthtoolFamily", "NetdevFamily", "RtnlFamily",
-           "RtnlAddrFamily"]
+           "RtnlAddrFamily", "Netlink"]
diff --git a/tools/testing/selftests/net/lib/py/ynl.py b/tools/testing/selftests/net/lib/py/ynl.py
index 32c223e93b2c..b42986bf39e3 100644
--- a/tools/testing/selftests/net/lib/py/ynl.py
+++ b/tools/testing/selftests/net/lib/py/ynl.py
@@ -13,20 +13,26 @@ try:
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
     ktap_result(True, comment="SKIP")
     sys.exit(4)
 
+__all__ = [
+    "NlError", "Netlink", "YnlFamily", "SPEC_PATH",
+    "EthtoolFamily", "RtnlFamily", "RtnlAddrFamily",
+    "NetdevFamily", "NetshaperFamily", "DevlinkFamily", "PSPFamily",
+]
+
 #
 # Wrapper classes, loading the right specs
 # Set schema='' to avoid jsonschema validation, it's slow
-- 
2.47.3


