Return-Path: <netdev+bounces-288447-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKThGfiAB2qQ5gIAu9opvQ
	(envelope-from <netdev+bounces-288447-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 22:24:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B5C55765E
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 22:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D4C730277D3
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0382392C28;
	Fri, 15 May 2026 20:19:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A12391E6D
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 20:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778876399; cv=none; b=SY+3ZSeuHlkWdNaGkP7PAb4MMtTM+ykmxLMBzuOSu0VKHI4nEUDZo6IlJDRik6JO3JvHQT0pBhb7ySO44Rtj+n4/UEhDcHNY+KDpb1pje4aueNJ3xP9rb8nAd5OvYba3HcqE5V0NjnOp8W9tpmxZnOvaRIUo54Kvx4mUO5nPJj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778876399; c=relaxed/simple;
	bh=dSCFWc+eVmOl8KjQ/GacAUEGoakHTq/OkpAjt59yuYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owvd2W2rPwpRCbZPh3tLjOpdpmfvkrOevJ3z1Ga9o+850bN9NXyLauQEZe8+k5Lg3teBLbcYWVHY6Pn8UBoYiaefhzfslkcIycpR9xp4ZiyuXibxQ0xRf6M+a/xghv90zi5mMf99UhWZB5o1++dwDKjQK2je+REUvAm6EHVCknA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-48909558b3aso2034655e9.0
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 13:19:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778876392; x=1779481192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R4vKfoZnMD2eHQmb96XRMlOUXaCZqDG0laQcmMFUQRk=;
        b=e8Ufo/b4DfF/+qVo4UQ/wa0a172S88tmITEot9e8u7UsQOlsojhY2s4G0Lthd1cebR
         AThNs2eT0/U6x9yMItgvIBG4UwTE6t6Uz2lr4xwfJO0QbCY4SZ073MaFaYq0KTYMlONx
         R+9wtw0hZOPVVFA0nx++IQOzKNRzHCb5rBlxsi7pdlRewbvjCaMmUbpDLSG71Kbd/F2W
         sjth/0c5Gg6xfxTmKY7sYgK4aFmAB4jleft8qDv12w5exezGRS4wrySjYFA/Xw9nIQhC
         vIyYMeOqCOvceEf1PpdsohfHageA9TYrkS4uJ6hRdm0kGrsQuJNy2oAxKewaC02GntFL
         wMrw==
X-Gm-Message-State: AOJu0YwYmgRQXMhxYbMILSnv1vuCTXDPgSgJloow2bRVQJ9P/DakZYHb
	y4bZ7ttPlOrPkXcPJwYxAXqLltO/x+WGlBry05qQcHISM39qd/q7fS7iakn8oJGL
X-Gm-Gg: Acq92OEBkAe4/9Eg2gDaiGq4fLPwJl0fOFyOUt4UXErvUgeKm0riCof7xQIsZS9F88D
	T3+aPW+GOqsGX+Rf+XxCIbTfuLCnpkW3C7Wq2bFCgG7Yz262VyZWIlykbonx4gQBiDnRso8sHI/
	pEDuTlugkvweEPgUe0DYS4LMV04k5jUtDcI3LJver0rqJG/BBmkYLb1NWsd1FvkjA9K6nYDbftl
	i13KIlaFWzC4ZN22rMJTL53cCTL3OukW2WKQn+2PcurXKJi/OqvPHOqaNn9oueIAPykJyOcUUt6
	pJrUbmjE9RZgLumNa5hjvxYcQdDRw9DmHemOF1QNPgJMX0TtyDgpcZPRE/bBt677r44Rl3soGcb
	20yHB2+RCqckFtFPow8H1mIh+HSwUi2eMwDfD6ZP9qksXr0V0HsI1OWPZqYs8UljgepC1jdUYyY
	w5iW+fdF64IE25ON6fgsy6NM3vw7IiwwKaSD7s+JzwIaiAw1BzgroESIJnULiuFe8GXK+4kw==
X-Received: by 2002:a05:600c:c087:b0:48f:d612:3c4a with SMTP id 5b1f17b1804b1-48fe60de6bdmr63511375e9.1.1778876392152;
        Fri, 15 May 2026 13:19:52 -0700 (PDT)
Received: from im-t490s.redhat.com (89-24-32-159.nat.epc.tmcz.cz. [89.24.32.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feab2896bsm22924605e9.4.2026.05.15.13.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 13:19:51 -0700 (PDT)
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
Subject: [PATCH net 5/5] selftests: net: add a test case for nsid in all nsid notifications
Date: Fri, 15 May 2026 22:19:24 +0200
Message-ID: <20260515201937.2813983-6-i.maximets@ovn.org>
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
X-Rspamd-Queue-Id: D3B5C55765E
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
	TAGGED_FROM(0.00)[bounces-288447-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.943];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ovn.org:email,ovn.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The test makes subscribes to link events from all namespaces and
makes sure that local events do not carry NSID in their ancillary
data (even if there is a self-referential NSID allocated for the
local namespace), and remote events do.

Assisted-by: OpenCode:claude-opus-4.6
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 tools/testing/selftests/net/link_netns.py | 52 +++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tools/testing/selftests/net/link_netns.py b/tools/testing/selftests/net/link_netns.py
index 2aae422d3f8a6..1e766154cb573 100755
--- a/tools/testing/selftests/net/link_netns.py
+++ b/tools/testing/selftests/net/link_netns.py
@@ -33,6 +33,57 @@ def test_event() -> None:
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
@@ -175,6 +226,7 @@ def test_peer_net_cross_ns() -> None:
 def main() -> None:
     ksft_run([
         test_event,
+        test_event_all_nsid,
         test_link_net,
         test_peer_net,
         test_peer_net_cross_ns,
-- 
2.53.0


