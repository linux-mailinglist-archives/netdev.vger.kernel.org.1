Return-Path: <netdev+bounces-294980-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VBQRKY3BIGpn7gAAu9opvQ
	(envelope-from <netdev+bounces-294980-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 02:06:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0058563BFC8
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 02:06:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="Uw4h0m/i";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294980-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294980-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7821B30CEFAB
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 00:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC5D4D90A4;
	Thu,  4 Jun 2026 00:00:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49A34DD6E2
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 23:59:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531202; cv=none; b=UwizDht6FbLdUxZ06/IdW481Z7qZNRVnQlsl+YxQWvZV66kA0Oj2RJ/OsKxJFZ2G34snemcpPPhbnttokHd58NDOA74NLpnjKoX1g+n21x8rZonUBtgibpaM1RPhjcVqlGWeYHcec6RXyQMzh4umz5QIKSjzO3xGC0pLNe7GzV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531202; c=relaxed/simple;
	bh=OhJbjIOfQiyqX+VBPGUU4l+97aO08xqz2lZaA2dAuzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kpRF95SXXpvDszHybC+XnuIp7/zci/hCb4x9AzMaXxw6wDHxblSIXJlbPE+W18wB85dLA0JEAJGv4e4yQbFxa65rlOCJ8LBde60PplLtHDM2v0BOWtYUYfYz2i2zz7Hch+wXQRXxSjNwjQF/8T/Qwf1P730PrKVW8l/9mWXBvgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uw4h0m/i; arc=none smtp.client-ip=209.85.128.174
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7e2cf9bf458so53937b3.3
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 16:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780531196; x=1781135996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCIuJUMUKWEw0msVkX0+vxAzDEyP3Mh77zY2zIL+NRU=;
        b=Uw4h0m/iqv2jlnHlGO4631TwEvorJ+xMGTjK5PeKT8d5o8MOAPhiCTbxH5gyrUklmU
         I8j4KDjc1YkVEOueHZ+nfV4dMPrLiOq3mxhNfgxXPp6+8Npp6FSppLupvcgKh9rCrwMD
         VRPwneq6M1viI+/SJ+BunrFZFjaO4jTDhnKxxm5cM9mzZz1yJhSz6S/JTYKYi+aWY9g0
         CZDNyz6GM1herEZ/UncHCZY1sxg8NAYvF123aVBMMaOvyrvU27uHXHInOtUt8X7uBnRn
         C1VdiBa+jPiAziLEesBLfCD4wDs+lgGXJB6lKmyV/w9iYsyg2qdZ3WjIMG7UNsNOSuGN
         gXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780531196; x=1781135996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NCIuJUMUKWEw0msVkX0+vxAzDEyP3Mh77zY2zIL+NRU=;
        b=OaynCyeBMk+8h7zYaIdmVuh5ByUi0FNMUgAKRrH6tN6cC+xb0pmXeNhD40KI+R0jE0
         lvuBQ58sssh72taKO67n6uA2jcv312fnaYNjPMm+mtdvD/FWcxRmsQC+4M4/TJA22mFt
         FYVJzAptyJmt+4si47CsLFpTApF2bqg72BSaCw3TtcTrX4viYevxDivyb07v+fwOVmAW
         zXzAdtLOQ5cWtMK8a+6WXDOCaNTciqPoejIeK1v2o4Otr2BGr/6jWGwy0By9QDJZ+B0B
         n13jj/VQHsKSafFcBRXQ28lQAFd38Nc2nONOPOgKbGbnUTBXEUydJTgMb+xJQSya2EnV
         5PDw==
X-Gm-Message-State: AOJu0Yw0ksgPlFolyDOl9ioWTNdmMYc+9G8QMxm7oQryFgIZfbDMPdRl
	jzuLWTGErRjFifcwUtih0jOlufZzVwCO5ZwO4xVNyuf5EoIpVUBYIOVhfNlVpA==
X-Gm-Gg: Acq92OEGD8NfMaYqmHLESG39Rbmo2z5mN+XW6vaTY9suXOuihl4CtlTnXNhLw9t37ec
	NX+IzlNbfuH0MaKVKnltC8C0E8lXxXLUETjX/La0fc5HNDiikksod1Q7yWDD6QkKNWwcpwfm/t8
	87JT9G8fmytaazOTut2BBawmbIKEc58h2HRrbKBTlPOgKNuEiT9d8UmxyCKmMDvyrqzNkzBiPew
	jI5ci14oKu5Ao1wiJnMH8SJZyX5qny7B6sGdjgEnHEevGmxxSTrGkUziKj2+c5GyXcDuq2ZXdet
	KGud/aD13bB/oNCvrZycXZ+X8TF+Iabd4J1SFTdOnyNqwjGxPJwx/MP4J1G5mefsNQ14bt7Jtc+
	5YMZlbaVvI0Ig52GIDsCnpxM09trc7zE/K9dmRWXN0Zvi0CiCcDpcHai6VN6/dWTNzqkBkfFjxs
	bGp13H3JWqvnCzoxqn3rvN+11mqBdNrf+9sO0=
X-Received: by 2002:a05:690c:81:b0:7ba:ee87:87e0 with SMTP id 00721157ae682-7ea2fac76b4mr36080777b3.3.1780531196024;
        Wed, 03 Jun 2026 16:59:56 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:4c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea2148b168sm25755887b3.14.2026.06.03.16.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 16:59:55 -0700 (PDT)
From: Wei Wang <weibunny.kernel@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Wei Wang <weibunny@fb.com>
Subject: [PATCH v15 net-next 06/10] selftests/net: rename _nk_host_ifname to nk_host_ifname
Date: Wed,  3 Jun 2026 16:59:35 -0700
Message-ID: <20260603235947.2986110-7-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260603235947.2986110-1-weibunny.kernel@gmail.com>
References: <20260603235947.2986110-1-weibunny.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-294980-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:daniel.zahka@gmail.com,m:willemdebruijn.kernel@gmail.com,m:dw@davidwei.uk,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:weibunny@fb.com,m:danielzahka@gmail.com,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,fb.com:email,netns.name:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0058563BFC8

From: Wei Wang <weibunny@fb.com>

Rename _nk_host_ifname to nk_host_ifname in NetDrvContEnv to make it
a public attribute, matching the nk_guest_ifname rename. Tests that
access the host-side netkit interface name (e.g. for cleanup after
deleting the netkit pair) no longer trigger pylint protected-access
warnings.

Signed-off-by: Wei Wang <weibunny@fb.com>
---
 .../selftests/drivers/net/hw/nk_qlease.py     |  4 +--
 .../selftests/drivers/net/lib/py/env.py       | 26 +++++++++----------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/nk_qlease.py b/tools/testing/selftests/drivers/net/hw/nk_qlease.py
index 139a91ebd229..f5fd64775989 100755
--- a/tools/testing/selftests/drivers/net/hw/nk_qlease.py
+++ b/tools/testing/selftests/drivers/net/hw/nk_qlease.py
@@ -193,9 +193,9 @@ def test_destroy(cfg) -> None:
     kill_timer = threading.Timer(1, rx_proc.proc.terminate)
     kill_timer.start()
 
-    ip(f"link del dev {cfg._nk_host_ifname}")
+    ip(f"link del dev {cfg.nk_host_ifname}")
     kill_timer.join()
-    cfg._nk_host_ifname = None
+    cfg.nk_host_ifname = None
     cfg.nk_guest_ifname = None
 
     queue_info = netdevnl.queue_get(
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 42c0cb777fb6..1d8964538abb 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -339,7 +339,7 @@ class NetDrvContEnv(NetDrvEpEnv):
 
     def __init__(self, src_path, rxqueues=1, primary_rx_redirect=False, **kwargs):
         self.netns = None
-        self._nk_host_ifname = None
+        self.nk_host_ifname = None
         self.nk_guest_ifname = None
         self._tc_clsact_added = False
         self._tc_attached = False
@@ -393,7 +393,7 @@ class NetDrvContEnv(NetDrvEpEnv):
             raise KsftSkipEx("Failed to create netkit pair")
 
         netkit_links.sort(key=lambda x: x['ifindex'])
-        self._nk_host_ifname = netkit_links[1]['ifname']
+        self.nk_host_ifname = netkit_links[1]['ifname']
         self.nk_guest_ifname = netkit_links[0]['ifname']
         self.nk_host_ifindex = netkit_links[1]['ifindex']
         self.nk_guest_ifindex = netkit_links[0]['ifindex']
@@ -405,11 +405,11 @@ class NetDrvContEnv(NetDrvEpEnv):
 
     def __del__(self):
         if self._primary_rx_redirect_attached:
-            cmd(f"tc filter del dev {self._nk_host_ifname} ingress", fail=False)
+            cmd(f"tc filter del dev {self.nk_host_ifname} ingress", fail=False)
             self._primary_rx_redirect_attached = False
 
         if self._primary_rx_redirect_clsact_added:
-            cmd(f"tc qdisc del dev {self._nk_host_ifname} clsact", fail=False)
+            cmd(f"tc qdisc del dev {self.nk_host_ifname} clsact", fail=False)
             self._primary_rx_redirect_clsact_added = False
 
         if self._tc_attached:
@@ -425,9 +425,9 @@ class NetDrvContEnv(NetDrvEpEnv):
                 host=self.remote, fail=False)
             self._remote_route_added = False
 
-        if self._nk_host_ifname:
-            cmd(f"ip link del dev {self._nk_host_ifname}")
-            self._nk_host_ifname = None
+        if self.nk_host_ifname:
+            cmd(f"ip link del dev {self.nk_host_ifname}")
+            self.nk_host_ifname = None
             self.nk_guest_ifname = None
 
         if self._init_ns_attached:
@@ -468,9 +468,9 @@ class NetDrvContEnv(NetDrvEpEnv):
         self._init_ns_attached = True
         ip("netns set init 0", ns=self.netns)
         ip(f"link set dev {self.nk_guest_ifname} netns {self.netns.name}")
-        ip(f"link set dev {self._nk_host_ifname} up")
-        ip(f"-6 addr add fe80::1/64 dev {self._nk_host_ifname} nodad")
-        ip(f"-6 route add {self.nk_guest_ipv6}/128 via fe80::2 dev {self._nk_host_ifname}")
+        ip(f"link set dev {self.nk_host_ifname} up")
+        ip(f"-6 addr add fe80::1/64 dev {self.nk_host_ifname} nodad")
+        ip(f"-6 route add {self.nk_guest_ipv6}/128 via fe80::2 dev {self.nk_host_ifname}")
 
         ip("link set lo up", ns=self.netns)
         ip(f"link set dev {self.nk_guest_ifname} up", ns=self.netns)
@@ -546,9 +546,9 @@ class NetDrvContEnv(NetDrvEpEnv):
         if not bpf_obj:
             raise KsftSkipEx("nk_primary_rx_redirect.bpf.o not found")
 
-        if self._tc_ensure_clsact(self._nk_host_ifname):
+        if self._tc_ensure_clsact(self.nk_host_ifname):
             self._primary_rx_redirect_clsact_added = True
-        cmd(f"tc filter add dev {self._nk_host_ifname} ingress"
+        cmd(f"tc filter add dev {self.nk_host_ifname} ingress"
             f" bpf obj {bpf_obj} sec tc/ingress direct-action")
         self._primary_rx_redirect_attached = True
 
@@ -557,7 +557,7 @@ class NetDrvContEnv(NetDrvEpEnv):
         self._remote_route_added = True
 
         filters = json.loads(
-            cmd(f"tc -j filter show dev {self._nk_host_ifname} ingress").stdout)
+            cmd(f"tc -j filter show dev {self.nk_host_ifname} ingress").stdout)
         redirect_prog_id = None
         for bpf in filters:
             if 'options' not in bpf:
-- 
2.52.0


