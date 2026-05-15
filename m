Return-Path: <netdev+bounces-288446-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJCEBsCAB2qQ5gIAu9opvQ
	(envelope-from <netdev+bounces-288446-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 22:23:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E679557636
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 22:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 081183063219
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74D73AF64B;
	Fri, 15 May 2026 20:19:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76803B27FF
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 20:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778876393; cv=none; b=hIaWtGum+0ct1VChWej7A4YFQIz/SQeSEO89sRhH4zxLAQ9kuiUb2XbXcgtU8TVVaPN1AYzXSLRHrXMLLRoVCfMaGds+cUTiXi0/cgY3SluvQMoeqq1Od+F0RWxePioOM0R61vJcbbKQHSQ6zgYeXbFSKwx7KSG2rm3ylcmKrZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778876393; c=relaxed/simple;
	bh=7IM3ALLv1AgX0seWLzIVOzbdOeXPtSRRe0lozcL/OEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tY/IrTEUbKzd60UiVFADiJYaD3WZR1iCbA844cMFbdNdHWygv1HK9d2XoaTRU1cBruwRNw3zx2yd/9UqR9Q1zltTzH01GVl48EnPOYE7PSuWYiVdZDZ1ZSESVF5hrxd9aMFbV9CD7i8neE1zYRbiDBbfshZNbcQlVjj6CIejoZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so1061325e9.3
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 13:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778876390; x=1779481190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ahZgkQzq/Ce3e/XVp5af27PA0zXGWrRU0/owFyh8aqA=;
        b=BOKocDkJArWOQaRkUGwf5wN7mTki7OsMgtQRApQKF9CL54ooJ21sXJs7TXhOVCXuaf
         /kvMeNupfsWBHjCtJvS1VKe97RY+cuPludAvQxsHzSFDxAfJ8ox1bAK4XbAAsJje5Igb
         XSPUIVl8uG8idSWiyU1OsUFHe7oCe3QTTWZy9IxLfjFLoTAKR3840+tcmpIIfcXvqE8O
         brUieXjrXOxfvNEPsYRceWvYbBDhe5ZG/XNH+Kdg6xSECrvONI2r3KODztmOdj4IsYs1
         hcyMsghpOAqMWzdtVLi5aaCzPWf1hSNkPv3AnXZaPBFrPdjKGZGL+OvVEFaB9+MuEMC+
         sUUw==
X-Gm-Message-State: AOJu0YzbzLv4sdS+J+yS6MOjW9r/Nc9rmD1IpdljUQm9chLWzTaPts3I
	p31BsI7ZVBvYrbeYKAuupyHkBlcB8beXrYcQvvrTWnq0i1BeZlQjZT7hFnTxSrf/
X-Gm-Gg: Acq92OG2DOyuexagGgaxdn0PKfb8Ng/j60VGnI/6COWChykxlFwKt1PGB1aH2Z2cA3m
	WFuUa80XnzJLN5v4Gbvw++6wsntOmcpUYW2xGw+35ey/eGrVfEeBGmdqG7qVAJq4ZP4jApxORAy
	33k3XHrpA+x6X4e4RwB609Jw4k43kc4qSOwcarANa/8Xqqhy0QevG5WT1VrqZaguMltDWmPTtW1
	OIgiawZDOJRwxTG8oS2RH/gqQ/PUUzs9oykGvwvaCtbJie1Sn/IITgdVzb2gRASSHbAqUbWBIjd
	0icaYU0ZGeheOer68uSdatj3iOsEHmPK5DV/cxac1me0hiJErbqspffmBeEsVNH3ruQcuRNX/kX
	qwZ+6WD/UfCXQ/3yKufIhucM9N9GeYNtPc4yEOHb+jGSVWwOwx/DI8IFJ3VZGplIP7bbOgMSA88
	m5SbDKjPy7G/hggmHaZlK0AgcdLRIa6eyfxgNt/LgEfjm9Bwp1v9o6x/XM/mp2sEdUjj+fyQ==
X-Received: by 2002:a05:600d:8:b0:48a:93f8:dd02 with SMTP id 5b1f17b1804b1-48fe61f291cmr71924875e9.14.1778876390168;
        Fri, 15 May 2026 13:19:50 -0700 (PDT)
Received: from im-t490s.redhat.com (89-24-32-159.nat.epc.tmcz.cz. [89.24.32.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feab2896bsm22924605e9.4.2026.05.15.13.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 13:19:49 -0700 (PDT)
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
Subject: [PATCH net 4/5] tools: ynl: support listening on all nsids
Date: Fri, 15 May 2026 22:19:23 +0200
Message-ID: <20260515201937.2813983-5-i.maximets@ovn.org>
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
X-Rspamd-Queue-Id: 6E679557636
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288446-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.947];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ovn.org:email,ovn.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

A new method ntf_listen_all_nsid() to enable listening on events from
all namespaces.  Useful for testing cross-namespace functionality.

recv() replaced with recvmsg() to be able to receive NSID through the
ancillary data.

Assisted-by: OpenCode:claude-opus-4.6
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 tools/net/ynl/pyynl/lib/ynl.py | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index f63c6f8287359..6d96c2b06507e 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -42,6 +42,7 @@ class Netlink:
     SOL_NETLINK = 270
 
     NETLINK_ADD_MEMBERSHIP = 1
+    NETLINK_LISTEN_ALL_NSID = 8
     NETLINK_CAP_ACK = 10
     NETLINK_EXT_ACK = 11
     NETLINK_GET_STRICT_CHK = 12
@@ -748,6 +749,21 @@ class YnlFamily(SpecFamily):
         self.sock.setsockopt(Netlink.SOL_NETLINK, Netlink.NETLINK_ADD_MEMBERSHIP,
                              mcast_id)
 
+    def ntf_listen_all_nsid(self):
+        self.sock.setsockopt(Netlink.SOL_NETLINK,
+                             Netlink.NETLINK_LISTEN_ALL_NSID, 1)
+
+    @staticmethod
+    def _decode_nsid(ancdata):
+        for cmsg_level, cmsg_type, cmsg_data in ancdata:
+            if (cmsg_level == Netlink.SOL_NETLINK and
+                    cmsg_type == Netlink.NETLINK_LISTEN_ALL_NSID):
+                nsid = struct.unpack('i', cmsg_data)[0]
+                if nsid >= 0:
+                    return nsid
+                return None
+        return None
+
     def set_recv_dbg(self, enabled):
         self._recv_dbg = enabled
 
@@ -1235,7 +1251,7 @@ class YnlFamily(SpecFamily):
                             f" when parsing '{attr_spec['name']}'")
         return raw
 
-    def handle_ntf(self, decoded):
+    def handle_ntf(self, decoded, nsid=None):
         msg = {}
         if self.include_raw:
             msg['raw'] = decoded
@@ -1246,15 +1262,20 @@ class YnlFamily(SpecFamily):
 
         msg['name'] = op['name']
         msg['msg'] = attrs
+        if nsid is not None:
+            msg['nsid'] = nsid
         self.async_msg_queue.put(msg)
 
     def check_ntf(self):
         while True:
             try:
-                reply = self.sock.recv(self._recv_size, socket.MSG_DONTWAIT)
+                reply, ancdata, _, _ = self.sock.recvmsg(self._recv_size,
+                                                         4096,
+                                                         socket.MSG_DONTWAIT)
             except BlockingIOError:
                 return
 
+            nsid = self._decode_nsid(ancdata)
             nms = NlMsgs(reply)
             self._recv_dbg_print(reply, nms)
             for nl_msg in nms:
@@ -1271,7 +1292,7 @@ class YnlFamily(SpecFamily):
                     print("Unexpected msg id while checking for ntf", decoded)
                     continue
 
-                self.handle_ntf(decoded)
+                self.handle_ntf(decoded, nsid)
 
     def poll_ntf(self, duration=None):
         start_time = time.time()
@@ -1335,7 +1356,8 @@ class YnlFamily(SpecFamily):
         rsp = []
         op_rsp = []
         while not done:
-            reply = self.sock.recv(self._recv_size)
+            reply, ancdata, _, _ = self.sock.recvmsg(self._recv_size, 4096)
+            nsid = self._decode_nsid(ancdata)
             nms = NlMsgs(reply)
             self._recv_dbg_print(reply, nms)
             for nl_msg in nms:
@@ -1374,7 +1396,7 @@ class YnlFamily(SpecFamily):
                 # Check if this is a reply to our request
                 if nl_msg.nl_seq not in reqs_by_seq or decoded.cmd() != op.rsp_value:
                     if decoded.cmd() in self.async_msg_ids:
-                        self.handle_ntf(decoded)
+                        self.handle_ntf(decoded, nsid)
                         continue
                     print('Unexpected message: ' + repr(decoded))
                     continue
-- 
2.53.0


