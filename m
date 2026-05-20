Return-Path: <netdev+bounces-290026-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENFwNYH0DWoF5AUAu9opvQ
	(envelope-from <netdev+bounces-290026-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 19:50:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74193594BB2
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 19:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8A9ED301F829
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 17:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC40C3F5BE1;
	Wed, 20 May 2026 17:23:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2623F4DE7
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 17:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297827; cv=none; b=ePZ9mrMCklZZkTXU0g8Ls6mwgF7n5n67IGY+dM37N5Ys7PB1vs/ADNDrAR3+CXNIci1uVGQMbqRiSEV2a0NlpdRcT3tse6E7Uo3EGYuqfoO1SPeXy91ZRWUkuqpNdoBZLi9r8FAjlplvDOsEwkDOmM9BAGWZJNqARt4RrIMgZkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297827; c=relaxed/simple;
	bh=2UYvNlSA+2GlROQWwNORHOgZveV7UHr6PN2hwqWlNuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejut8f5Gxudx5dBkZ2v+twrKvu9gHulXumT9QMYDnZcBXgdGsXz/yd8PQi0qWgJvoyYrtY7O70zif4ZwGRCIs7XAsUIO+ZTTW+2rS7l2ePANIBijmRDuyQ112JqpJxIyjhpRrFl8+ZH9KkfWMUjzeI6cJrleFWrGM+jHiy3Spyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-44a14580111so3824304f8f.0
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 10:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779297825; x=1779902625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EqFt3aKsOC7Q71BIE2C6rkJYkvil00DlAxCbqMAvtdk=;
        b=pDj1IHVD699ID4AD4noCPeLOZ8WmSn1JTLyrI2HZ3Bl7iLXtX63rMITJXtL2li4SvF
         5K40ia3OAhI/b1o+cRlDrR7ResNl9FNdhdojljjqXs8JlE2Y/s4p+rnpFXMz+fwdLCsi
         y8WsibcvOXSTNEwZD5lAN7Pk0+ajDHXrI0e0kwmcMITKa8qe5jMSYYfdsSRSFx/ucTuT
         7bpq2YjE6J116XrScjiZj5j5Xk4EC9eVjZlKW6EeEX+B33GFgIAg4PqSBJAMGD7PAKmV
         tqBTL6n7ZiFxzJTAluDCV1LA6GmFkwgNX37yUEJ0mmgxfXHb49HqOtCU3hsszBoFSdyI
         T6Aw==
X-Gm-Message-State: AOJu0Yzs2urfTwCd1xyV4pkrW/hJLeQAezCo+vFWGYNOzMUHDpsSAenG
	2g1+u7OCM1OzE9+MnOt0cw0uMeaQ2sGY0FwUBoCEFcBshTC0vGx7e50KqzLG+kaX
X-Gm-Gg: Acq92OGXnKEHBw9iJqJarfvFPfun5LkgzCPZzuZFc/PaGGh8G0uebRsUGez0EQzYjkw
	BYcZmxF4Z3zASa6Llk3ENTZ5sE4cLvNNLDXGD4sQH8XpEWRVn6NO84F7Unk53v5Qvo9cCP7cO2l
	5283yBrHF0GrcBusr2eCcp9fdF3EBdlwX+dFtUeKv++TInMZwKZ823oGtC9MPH5H8szT08gWAiV
	xVuncjFjZTVcNtknn8j4E0B9Z9lwz/JzKndPJ1jwMZuLd+SfpsbPBi4U9ZJ8mibxmzUslkB4PSs
	HLqb0EOCrX55Z9OBNd8Eu79jeQ1wE06jeJOgnuuDX9P81Z7NprTVBZozKtIsct/4GKmfdQM7FUa
	TDCwHWd0dyoQfT48Zjv01ayWH2yZaX00/koerAmCvRIioZ1crYTiNTGrye/Ij8uOr0N/7PJ/Jim
	OLLcYLIbLu2DLKTmcVDHv2Y9OpIHHsTGg0QHe+HwxO9OaIj0km/PbdrM4eI/8=
X-Received: by 2002:a05:6000:46cc:b0:45e:a0ab:8bc8 with SMTP id ffacd0b85a97d-45ea0ab8cd1mr615345f8f.3.1779297824693;
        Wed, 20 May 2026 10:23:44 -0700 (PDT)
Received: from im-t490s.redhat.com (89-24-32-159.nat.epc.tmcz.cz. [89.24.32.159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe0fecsm51125580f8f.26.2026.05.20.10.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 10:23:44 -0700 (PDT)
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
Subject: [PATCH net v2 3/4] tools: ynl: support listening on all nsids
Date: Wed, 20 May 2026 19:22:37 +0200
Message-ID: <20260520172317.175168-4-i.maximets@ovn.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290026-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[ovn.org];
	RCVD_COUNT_FIVE(0.00)[5];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,ovn.org:mid,ovn.org:email]
X-Rspamd-Queue-Id: 74193594BB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A new method ntf_listen_all_nsid() to enable listening on events from
all namespaces.  Useful for testing cross-namespace functionality.

recv() replaced with recvmsg() to be able to receive NSID through the
ancillary data.

Assisted-by: OpenCode:claude-opus-4.6
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 tools/net/ynl/pyynl/lib/ynl.py | 37 +++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index f63c6f8287359..010aac0c6c67a 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -42,6 +42,7 @@ class Netlink:
     SOL_NETLINK = 270
 
     NETLINK_ADD_MEMBERSHIP = 1
+    NETLINK_LISTEN_ALL_NSID = 8
     NETLINK_CAP_ACK = 10
     NETLINK_EXT_ACK = 11
     NETLINK_GET_STRICT_CHK = 12
@@ -680,6 +681,7 @@ class YnlFamily(SpecFamily):
     Notification API:
 
       ynl.ntf_subscribe(mcast_name)      -- join a multicast group
+      ynl.ntf_listen_all_nsid()          -- listen on all netns
       ynl.check_ntf()                    -- drain pending notifications
       ynl.poll_ntf(duration=None)        -- yield notifications
 
@@ -748,6 +750,23 @@ class YnlFamily(SpecFamily):
         self.sock.setsockopt(Netlink.SOL_NETLINK, Netlink.NETLINK_ADD_MEMBERSHIP,
                              mcast_id)
 
+    def ntf_listen_all_nsid(self):
+        """Enable NETLINK_LISTEN_ALL_NSID to receive notifications from all
+        namespaces that have an nsid mapped in the current one."""
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
 
@@ -1235,7 +1254,7 @@ class YnlFamily(SpecFamily):
                             f" when parsing '{attr_spec['name']}'")
         return raw
 
-    def handle_ntf(self, decoded):
+    def handle_ntf(self, decoded, nsid=None):
         msg = {}
         if self.include_raw:
             msg['raw'] = decoded
@@ -1246,15 +1265,22 @@ class YnlFamily(SpecFamily):
 
         msg['name'] = op['name']
         msg['msg'] = attrs
+        if nsid is not None:
+            msg['nsid'] = nsid
         self.async_msg_queue.put(msg)
 
+    def _recvmsg(self, flags=0):
+        reply, ancdata, _, _ = self.sock.recvmsg(self._recv_size, 4096, flags)
+        return reply, ancdata
+
     def check_ntf(self):
         while True:
             try:
-                reply = self.sock.recv(self._recv_size, socket.MSG_DONTWAIT)
+                reply, ancdata = self._recvmsg(socket.MSG_DONTWAIT)
             except BlockingIOError:
                 return
 
+            nsid = self._decode_nsid(ancdata)
             nms = NlMsgs(reply)
             self._recv_dbg_print(reply, nms)
             for nl_msg in nms:
@@ -1271,7 +1297,7 @@ class YnlFamily(SpecFamily):
                     print("Unexpected msg id while checking for ntf", decoded)
                     continue
 
-                self.handle_ntf(decoded)
+                self.handle_ntf(decoded, nsid)
 
     def poll_ntf(self, duration=None):
         start_time = time.time()
@@ -1335,7 +1361,8 @@ class YnlFamily(SpecFamily):
         rsp = []
         op_rsp = []
         while not done:
-            reply = self.sock.recv(self._recv_size)
+            reply, ancdata = self._recvmsg()
+            nsid = self._decode_nsid(ancdata)
             nms = NlMsgs(reply)
             self._recv_dbg_print(reply, nms)
             for nl_msg in nms:
@@ -1374,7 +1401,7 @@ class YnlFamily(SpecFamily):
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


