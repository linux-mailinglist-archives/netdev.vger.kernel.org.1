Return-Path: <netdev+bounces-288444-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDVeIEyAB2qQ5gIAu9opvQ
	(envelope-from <netdev+bounces-288444-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 22:21:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FFD55760F
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 22:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5360B302260B
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B23391E58;
	Fri, 15 May 2026 20:19:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D221391846
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 20:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778876391; cv=none; b=knhV0RPXUV+hEG/f7MSvxrWzANXszTu9V2bdsH5p991XS79P6tgTD4XFpdlY1wKKN6Ybe1V8PVVm8FqpbLPDGIeAP7Z4xXbEzD/Z/qhGjbgznvoTzkBnw0VrVPIZVJJA16PSdixysmR7nqrEDOu8tMQ4b7juV77qiWl8GcJCAHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778876391; c=relaxed/simple;
	bh=PEURoDySqWuQSZD27dPpBt6/0GrdH4gRDEOa7Eum+aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JaZdBbGZQ+jtC4QktK3dgPDChl7lK3M4ayV1b1SsXT+2/6+fomgnBhcexntQgYRrSz7ZK4M/hoci6QtAry+0zBWdJXpJP3DaM9kZ8IuD3BdGrk1ys9C5f/A7fAbPT3l6kPbLw/Vcov+43YVz6vczOKGZ6fE/Ng9T7wIApUfjnbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso11382545e9.1
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 13:19:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778876386; x=1779481186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kmQU4ZHn0BP9pNq3YQ9QtcvmPxZeqXAZW4pwCEu/ebY=;
        b=NwKgz9a7DXebjYGC9DvaQzG7q185uBp+pCq7fkuRI7c/VK5B7aww0ZlDOCmHRwq6LE
         ZcdudJImreHdYLwW1wDyeZ0fDrN7YDocFsLR4CwXKxUxDhUPvAAVM5ocVUrJTFmcPzqd
         w5/6upOaDwoDivz6TKU5SNDromEA8wIZxOax7wdsk7vBMdPgR+yL9o04UssDkrL8pETf
         3nByEdWH2mSk0YiaXyMtvbMfzoOYxpw3LiwXjTw4E96wPkXP7qB3qm03CVSjdqddWSVj
         jCmU4UNUo/1PI2FGYCCVOwKZjydHfW6HnacL2gOfj18bMRRvcRqVE6u96gKlhhUmwVwD
         y8Tw==
X-Gm-Message-State: AOJu0Yz7EzVJ4DgcHBeKy+q5wJBVRWAhHud22qegpu/6V/W2KAF3+WZc
	oJFlUKuizfIu7jelOgdoaP+H/JzCu7T8ketsLywXQttwDDGOgGqBM2hnLEikOOeg
X-Gm-Gg: Acq92OFJ1BJGBJT0nuIorLvSs/oKVkHqDI1lV7UBP7JvnNu0/hejd/iHHd22gtPHNAu
	4GiY29fff75oGdp7+bqMGJRta1q4Bj8Tnf9s47dmbqYQv3zY8pnoSNYMlIJrSaAqg9Bs0xHn6R5
	2twCqtZENtJgSE8tFlFYho+PnTGZmflXC3HQW/Depq0pfg/2IS15A9L409CeBTN9Bvs2NHsRZJ0
	2krBnSfQ6UlTVrC0scWbWrytNHQVq3leKBL4LTI3MTFuopqX4iRHTIuHCXFDgWhEpYjF4C70Mz0
	EWLoUqHqh6c4sKwFwjZjAmaz+tRSQh8jZci7oXAcQ4JvjC22zmk6qLaF4z6uZFaUHQcGwQg2aza
	0f/pf6fqVeVmuR8eH0PZkYb+qI7SU3pMM6MAC6G3kaaghS0ElOrihZfRj/dXKYXqfwTWYQMmmXk
	Gxk+qKiPKr9Y/Ik25SL8/kYLAJYLD4DNfDdkkx961WaQUxhl5FfctJOZRlzzy2pNXKeo0RMA==
X-Received: by 2002:a05:600c:8485:b0:48a:5339:a46 with SMTP id 5b1f17b1804b1-48fe537fb6fmr64515925e9.9.1778876385954;
        Fri, 15 May 2026 13:19:45 -0700 (PDT)
Received: from im-t490s.redhat.com (89-24-32-159.nat.epc.tmcz.cz. [89.24.32.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feab2896bsm22924605e9.4.2026.05.15.13.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 13:19:45 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Adrian Moreno <amorenoz@redhat.com>,
	Jiri Benc <jbenc@redhat.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Matteo Perin <matteo.perin@canonical.com>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net 2/5] selftests: net: add a test case for cross-namespace peer netns
Date: Fri, 15 May 2026 22:19:21 +0200
Message-ID: <20260515201937.2813983-3-i.maximets@ovn.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515201937.2813983-1-i.maximets@ovn.org>
References: <20260515201937.2813983-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D7FFD55760F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288444-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[ovn.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,6wind.com,vger.kernel.org,canonical.com,ovn.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.979];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ovn.org:email,ovn.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lib.py:url]
X-Rspamd-Action: no action

The test makes requests with RTM_GETLINK and TARGET_NETNS and verifies
that reported LINK_NSID is correct and only reported when it is needed
from the querier's perspective.

Assisted-by: OpenCode:claude-opus-4.6
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 tools/testing/selftests/net/link_netns.py | 49 ++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/link_netns.py b/tools/testing/selftests/net/link_netns.py
index aab043c59d695..2aae422d3f8a6 100755
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
@@ -132,8 +133,52 @@ def test_peer_net() -> None:
                 ip(f"link del foo", ns=tgt_net)
 
 
+def test_peer_net_cross_ns() -> None:
+    """Cross-namespace RTM_GETLINK queries using target-netnsid.
+    IFLA_LINK_NETNSID should report the link peer's namespace from the
+    querier's perspective.  Absent means the peer is in the querier's
+    own namespace.  Must not create self-referential nsid mappings."""
+
+    with NetNS() as ns1, NetNS() as ns2, NetNS() as ns3:
+        net1, net2, net3 = str(ns1), str(ns2), str(ns3)
+
+        ip(f"netns set {net2} {LINK_NETNSID}", ns=net1)
+        ip(f"netns set {net3} {LINK_NETNSID2}", ns=net1)
+
+        with NetNSEnter(net1):
+            rtnl = RtnlFamily()
+
+        cases = [
+            # "dev netns", "peer netns", "query nsid", expected link-netnsid.
+            (net2, net1, LINK_NETNSID, None),
+            (net2, net2, LINK_NETNSID, LINK_NETNSID),
+            (net2, net3, LINK_NETNSID, LINK_NETNSID2),
+        ]
+
+        for dev_ns, peer_ns, query_nsid, exp in cases:
+            ip(f"link add foo netns {dev_ns} type veth"
+               f" peer name bar netns {peer_ns}")
+
+            resp = rtnl.getlink({"target-netnsid": query_nsid,
+                                 "ifname": "foo"})
+            ksft_eq(resp.get("link-netnsid"), exp,
+                    f"link-netnsid mismatch for dev={dev_ns} peer={peer_ns}")
+
+            ip("link del foo", ns=dev_ns)
+
+        # Verify no extra nsid was created by the queries.
+        nsids = ip("netns list-id", ns=net1, json=True)
+        ksft_eq(len(nsids), 2,
+                f"unexpected nsid mappings after cross-ns queries: {nsids}")
+
+
 def main() -> None:
-    ksft_run([test_event, test_link_net, test_peer_net])
+    ksft_run([
+        test_event,
+        test_link_net,
+        test_peer_net,
+        test_peer_net_cross_ns,
+    ])
     ksft_exit()
 
 
-- 
2.53.0


