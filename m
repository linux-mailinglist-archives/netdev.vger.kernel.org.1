Return-Path: <netdev+bounces-290027-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eI2TJTMaDmpT6AUAu9opvQ
	(envelope-from <netdev+bounces-290027-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 22:31:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED78C599B7C
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 22:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9F783226F94
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 17:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314E63F9288;
	Wed, 20 May 2026 17:23:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9833F8704
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 17:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297830; cv=none; b=mnLRPodgPvKtom0pL//VUsRPPud4bwjr3RGIJGpc55JW2yjNTWlDwv67o2RIAzCt0pRcWi4lRKtiOiQ6PcHjN/CcWQgSSsQQuB6yBzqmpdPexa6q5X6KAb4aW4FfM5eWKrJ9L72kF9iz7nf69X7OnKwxxMx/saOqN2itCYM7f0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297830; c=relaxed/simple;
	bh=8ee1KK6pbWiMoa+lm6mq4reiA3CNV5J1Dikiqs/l0Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sGJDA0L5TgD5KD36xBgD91j4ZgxyzWje7l18p4Ew+eypy+H6wFvFyN9XXP2ESwKnocm803szrdYTi3HsdZpC3F1fcnbD5IanDmjRwWj86QKxlbXGAN01gEuKjLEWTXIpuFjh4lPq96JbwieOJ6rneJjXxcGJXfdEU2+fSrHIRQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso42441965e9.2
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 10:23:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779297827; x=1779902627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DryccTLU/nbCr+QwWZ91fsYNK6rnvVP3JQDHF5PbwEg=;
        b=A1g/ghCtoc7bgZyb3YxjDUCrJ/4xd0kfsxeowhZJWUi0qzbG4WtnWzBb5IEllzP+US
         uFFq9l6p9M5o42MaAGTwdU9mm0jsicQfG3Ke4gBH/Q6x/9POE3RbAGotFT++oxaNCTbd
         bC7GR+q+L0HxMvk3wO59b9viSzUSpFCFK0P5oqMIxPbT5HeRGsUKboWVH4sFYxoCWUa0
         v903zsWel+5lCacATsBONIC1COQyzREg/MP1c3rDU9nFCTWb7/t7aA9vRmWa62NBNdkb
         0ZIG/6pELJPd2P6IWwdckmunz/YC3tBhN0bwrBWxSX8/6eTjMCMbosqVUGdCQKRyVGXx
         5X8w==
X-Gm-Message-State: AOJu0YwYJPFN/Fq0dPbaTTmUycm7NN6yDPjoWKmySWrKoRtpR+h5Q20W
	NjAnVqoz0CZ+iCZdo1Yj6cTo5LMbfGLSVu7BoxcfcCBEwYmISgdcMaHf9UReQZfQ
X-Gm-Gg: Acq92OEaSqDbgbNIsN49ywoj33+xxQbn0ipfQpDFHZpap6FFoRe9bW1HooP7BtgpUyr
	JgE1RqxCm8Jj8h/TLzWGRHFwFeSai66mcz/jdIw6SZJlsi8xtRm7PAIgC3rq0z/fFcftHLoKe16
	TqqYhUwrfJmBb8FjEBhKzhCVWxCvBLb3MeJIOgMOPWr1AawYNKtmqNfAcciRu1E2ADY6fXJcg3b
	jvxbmzI2yIYkzAMT7bjL2j6C8P9NPGgB6wQlUBRsiiTM0xu1aT6YLS+veSPqeAiierMQm2EXVOu
	J8VN07yDPyFYtz377pBzLxAzgueP7QFVn+gEF/TFFLUljNzAe/OnC1aJ1S2EoppKZFsq+HTO0oJ
	7JyFJsESVyXDjFKlG31ALB2PbqME55BgTjMHcQGNDLKFxodSdMhVGdM5rH4528VP6qa0iPB/1YN
	04MuuMfJl5XIVhudC7U5rqs0VJCgsqTImb2KQXb6M3mjwZoaI+XUCrcprtc+A=
X-Received: by 2002:a05:600c:1d99:b0:488:c078:bfda with SMTP id 5b1f17b1804b1-48fe631389bmr363429105e9.26.1779297826824;
        Wed, 20 May 2026 10:23:46 -0700 (PDT)
Received: from im-t490s.redhat.com (89-24-32-159.nat.epc.tmcz.cz. [89.24.32.159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe0fecsm51125580f8f.26.2026.05.20.10.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 10:23:46 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kees Cook <kees@kernel.org>,
	Adrian Moreno <amorenoz@redhat.com>,
	Jiri Benc <jbenc@redhat.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Matteo Perin <matteo.perin@canonical.com>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net v2 4/4] selftests: net: add a test case for nsid in all nsid notifications
Date: Wed, 20 May 2026 19:22:38 +0200
Message-ID: <20260520172317.175168-5-i.maximets@ovn.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520172317.175168-1-i.maximets@ovn.org>
References: <20260520172317.175168-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_NA(0.00)[ovn.org];
	TAGGED_FROM(0.00)[bounces-290027-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,6wind.com,vger.kernel.org,canonical.com,ovn.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ovn.org:mid,ovn.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lib.py:url]
X-Rspamd-Queue-Id: ED78C599B7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The test subscribes to link events from all namespaces and makes
sure that local events do not carry NSID in their ancillary data
(even if there is a self-referential NSID allocated for the local
namespace), and remote events do.

Assisted-by: OpenCode:claude-opus-4.6
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 tools/testing/selftests/net/link_netns.py | 61 ++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/link_netns.py b/tools/testing/selftests/net/link_netns.py
index aab043c59d695..6d1f863b6262e 100755
--- a/tools/testing/selftests/net/link_netns.py
+++ b/tools/testing/selftests/net/link_netns.py
@@ -3,13 +3,14 @@
 
 import time
 
-from lib.py import ksft_run, ksft_exit, ksft_true
+from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_true
 from lib.py import ip
 from lib.py import NetNS, NetNSEnter
 from lib.py import RtnlFamily
 
 
 LINK_NETNSID = 100
+LINK_NETNSID2 = 200
 
 
 def test_event() -> None:
@@ -32,6 +33,57 @@ def test_event() -> None:
                   "Received unexpected link notification")
 
 
+def test_event_all_nsid() -> None:
+    """NETLINK_LISTEN_ALL_NSID notifications: local events must not
+    carry nsid even with a self-referential mapping.  Remote events
+    must carry the correct nsid."""
+
+    with NetNS() as ns1, NetNS() as ns2:
+        net1, net2 = str(ns1), str(ns2)
+
+        with NetNSEnter(net1):
+            rtnl = RtnlFamily()
+        rtnl.ntf_listen_all_nsid()
+        rtnl.ntf_subscribe("rtnlgrp-link")
+
+        # Case 1: no nsid assigned, local event, no nsid expected.
+        ip("link add dummy-lo type dummy", ns=net1)
+
+        # Case 2: self-referential nsid, local event, still no nsid.
+        ip(f"netns set {net1} {LINK_NETNSID}", ns=net1)
+        ip("link add dummy-sr type dummy", ns=net1)
+
+        # Case 3: remote event, nsid present.
+        ip(f"netns set {net2} {LINK_NETNSID2}", ns=net1)
+        ip("link add dummy-re type dummy", ns=net2)
+
+        # Collect the three newlink events, ignoring unrelated noise.
+        events = {}
+        for msg in rtnl.poll_ntf(duration=1):
+            if msg['name'] == 'getlink':
+                ifname = msg['msg'].get('ifname')
+                if ifname in ('dummy-lo', 'dummy-sr', 'dummy-re'):
+                    events[ifname] = msg
+            if len(events) == 3:
+                break
+
+        ksft_true('dummy-lo' in events, "missing local event")
+        ksft_true(events['dummy-lo'].get('nsid') is None,
+                  "local event without nsid should not carry nsid")
+
+        ksft_true('dummy-sr' in events, "missing self-ref event")
+        ksft_true(events['dummy-sr'].get('nsid') is None,
+                  "local event with self-ref nsid should not carry nsid")
+
+        ksft_true('dummy-re' in events, "missing remote event")
+        ksft_eq(events['dummy-re'].get('nsid'), LINK_NETNSID2,
+                "remote event should carry nsid")
+
+        ip("link del dummy-lo", ns=net1)
+        ip("link del dummy-sr", ns=net1)
+        ip("link del dummy-re", ns=net2)
+
+
 def validate_link_netns(netns, ifname, link_netnsid) -> bool:
     link_info = ip(f"-d link show dev {ifname}", ns=netns, json=True)
     if not link_info:
@@ -133,7 +185,12 @@ def test_peer_net() -> None:
 
 
 def main() -> None:
-    ksft_run([test_event, test_link_net, test_peer_net])
+    ksft_run([
+        test_event,
+        test_event_all_nsid,
+        test_link_net,
+        test_peer_net,
+    ])
     ksft_exit()
 
 
-- 
2.53.0


