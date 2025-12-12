Return-Path: <netdev+bounces-244517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D25ACCB9486
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 17:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E3CA30AAD6C
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 16:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548B12D2490;
	Fri, 12 Dec 2025 16:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="ZUghnVms"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CD72C2353;
	Fri, 12 Dec 2025 16:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765557437; cv=none; b=MwKfn8SU6wtJZnH/a6rSVPI3cf7meZjUAo4c9qqlFyADh7urt2OSJx1g3jGfWwFQ8QR7dwTCaiId0wyQl9TpHEWA6kkcGFksKCYVP32SVpHJCLyAXVh8eGZpfC5jjC/E/NtnaBxNsXMkdZFR7E1AcO27H1Ezpmhptwhm7+K2zYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765557437; c=relaxed/simple;
	bh=xecVtFNLx6sQjRgi4xtJ1P1ImeMUj3IejjyRlYE7G1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eIr7TFyZ662E3ArHKx+ua3bUVkpYflhyd3tdXYlFyXoHNMPXqmugYN/YuBE+2Yt55464AaD2ythy8WDv0DHq+lPPzzdo0LRMypyxFwZwFA4njsYQ+y0lR8Y8PVa7BpJKKg3Fgfn0ivNJcxHo/9Op7vrWqT9HAsXJXISJIDgoiqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=ZUghnVms; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1765557433; bh=xecVtFNLx6sQjRgi4xtJ1P1ImeMUj3IejjyRlYE7G1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZUghnVms5HFd9KA4hD7YwfLyJrHVizj74BGYK8mLHm3127220LXXkntq/q2S0wmFu
	 HCm1fsgqseEG6gnDr29W0igWX0VxgG26NQq9JkdqWRe5kmD5CB2xYm6Qx00G61Ibg2
	 wWLFSWgXOXHSN+cMqXIRdXfi3GAfNJHvAUK/NpiSHHtwP/80/MaF5JEUybe9Xj6L4o
	 aPoMfyeky8Dn+olK5aWd8HuKXZuD5OzQEhOSbqcbvhMyrycJkfqM3EPpASgz46c6lT
	 LTgC/W7WCZuf8Sz4guEiFFa7u8rU9L2m6mXgddDWsaIn5QWC+SlsgYMEc2VnOu7CPW
	 P52sLzBukDHrA==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id DB5BE125494;
	Fri, 12 Dec 2025 17:37:12 +0100 (CET)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	netdev@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [RFC PATCH v3 8/8] landlock: Add documentation for UDP support
Date: Fri, 12 Dec 2025 17:37:04 +0100
Message-Id: <20251212163704.142301-9-matthieu@buffet.re>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251212163704.142301-1-matthieu@buffet.re>
References: <20251212163704.142301-1-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add example of UDP usage, without detailing each access right, but with
an explicit note about the need to handle both SENDTO and CONNECT to
completely block sending (which could otherwise be overlooked).

Slightly change the example used in code blocks: build a ruleset for a
DNS client, so that it uses both TCP and UDP. Also consider an opaque
implementation so that we get to introduce both the right to connect()
and sendmsg(addr != NULL) within the same example.

Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 Documentation/userspace-api/landlock.rst | 94 ++++++++++++++++++------
 1 file changed, 72 insertions(+), 22 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 1d0c2c15c22e..758217c2b260 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -8,7 +8,7 @@ Landlock: unprivileged access control
 =====================================
 
 :Author: Mickaël Salaün
-:Date: March 2025
+:Date: October 2025
 
 The goal of Landlock is to enable restriction of ambient rights (e.g. global
 filesystem or network access) for a set of processes.  Because Landlock
@@ -40,8 +40,8 @@ Filesystem rules
     and the related filesystem actions are defined with
     `filesystem access rights`.
 
-Network rules (since ABI v4)
-    For these rules, the object is a TCP port,
+Network rules (since ABI v4 for TCP and v8 for UDP)
+    For these rules, the object is a TCP or UDP port,
     and the related actions are defined with `network access rights`.
 
 Defining and enforcing a security policy
@@ -49,11 +49,11 @@ Defining and enforcing a security policy
 
 We first need to define the ruleset that will contain our rules.
 
-For this example, the ruleset will contain rules that only allow filesystem
-read actions and establish a specific TCP connection. Filesystem write
-actions and other TCP actions will be denied.
+For this example, the ruleset will contain rules that only allow some
+filesystem read actions and some specific UDP and TCP accesses. Filesystem
+write actions and other TCP/UDP actions will be denied.
 
-The ruleset then needs to handle both these kinds of actions.  This is
+The ruleset then needs to handle all these kinds of actions.  This is
 required for backward and forward compatibility (i.e. the kernel and user
 space may not know each other's supported restrictions), hence the need
 to be explicit about the denied-by-default access rights.
@@ -80,7 +80,10 @@ to be explicit about the denied-by-default access rights.
             LANDLOCK_ACCESS_FS_IOCTL_DEV,
         .handled_access_net =
             LANDLOCK_ACCESS_NET_BIND_TCP |
-            LANDLOCK_ACCESS_NET_CONNECT_TCP,
+            LANDLOCK_ACCESS_NET_CONNECT_TCP |
+            LANDLOCK_ACCESS_NET_BIND_UDP |
+            LANDLOCK_ACCESS_NET_CONNECT_UDP |
+            LANDLOCK_ACCESS_NET_SENDTO_UDP,
         .scoped =
             LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
             LANDLOCK_SCOPE_SIGNAL,
@@ -127,6 +130,14 @@ version, and only use the available subset of access rights:
         /* Removes LANDLOCK_SCOPE_* for ABI < 6 */
         ruleset_attr.scoped &= ~(LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
                                  LANDLOCK_SCOPE_SIGNAL);
+        __attribute__((fallthrough));
+    case 6:
+    case 7:
+        /* Removes LANDLOCK_ACCESS_*_UDP for ABI < 8 */
+        ruleset_attr.handled_access_net &=
+            ~(LANDLOCK_ACCESS_NET_BIND_UDP |
+              LANDLOCK_ACCESS_NET_CONNECT_UDP |
+              LANDLOCK_ACCESS_NET_SENDTO_UDP);
     }
 
 This enables the creation of an inclusive ruleset that will contain our rules.
@@ -175,26 +186,53 @@ descriptor.
 
 It may also be required to create rules following the same logic as explained
 for the ruleset creation, by filtering access rights according to the Landlock
-ABI version.  In this example, this is not required because all of the requested
-``allowed_access`` rights are already available in ABI 1.
+ABI version.  So far, this was not required because all of the requested
+``allowed_access`` rights have always been available, from ABI 1.
 
-For network access-control, we can add a set of rules that allow to use a port
-number for a specific action: HTTPS connections.
+For network access-control, we will add a set of rules to allow DNS
+queries, which requires both UDP and TCP. For TCP, we need to allow
+outbound connections to port 53, which can be handled and granted starting
+with ABI 4:
 
 .. code-block:: c
 
-    struct landlock_net_port_attr net_port = {
-        .allowed_access = LANDLOCK_ACCESS_NET_CONNECT_TCP,
-        .port = 443,
-    };
+    if (ruleset_attr.handled_access_net & LANDLOCK_ACCESS_NET_CONNECT_TCP) {
+        struct landlock_net_port_attr net_port = {
+            .allowed_access = LANDLOCK_ACCESS_NET_CONNECT_TCP,
+            .port = 53,
+        };
 
-    err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
-                            &net_port, 0);
+        err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+                                &net_port, 0);
+
+We also need to be able to send UDP datagrams to port 53: we don't know if
+the client will call e.g. :manpage:`sendto(2)` with an explicit destination
+address, or :manpage:`connect(2)` then e.g. :manpage:`send(2)`, so we
+allow both. Note that granting ``LANDLOCK_ACCESS_NET_BIND_UDP`` is not
+necessary here because the client's socket will be automatically bound to
+an ephemeral port by the kernel.  Also note that we need to handle both
+``LANDLOCK_ACCESS_NET_CONNECT_UDP`` and ``LANDLOCK_ACCESS_NET_SENDTO_UDP``
+to effectively block sending UDP datagrams to arbitrary ports.
+
+.. code-block:: c
+
+    if ((ruleset_attr.handled_access_net & (LANDLOCK_ACCESS_NET_CONNECT_UDP |
+                                            LANDLOCK_ACCESS_NET_SENDTO_UDP)) ==
+                                           (LANDLOCK_ACCESS_NET_CONNECT_UDP |
+                                            LANDLOCK_ACCESS_NET_SENDTO_UDP)) {
+        struct landlock_net_port_attr net_port = {
+            .allowed_access = LANDLOCK_ACCESS_NET_CONNECT_UDP |
+                              LANDLOCK_ACCESS_NET_SENDTO_UDP,
+            .port = 53,
+        };
+
+        err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+                                &net_port, 0);
 
 The next step is to restrict the current thread from gaining more privileges
 (e.g. through a SUID binary).  We now have a ruleset with the first rule
 allowing read access to ``/usr`` while denying all other handled accesses for
-the filesystem, and a second rule allowing HTTPS connections.
+the filesystem, and two more rules allowing DNS queries.
 
 .. code-block:: c
 
@@ -604,6 +642,18 @@ Landlock audit events with the ``LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF``,
 sys_landlock_restrict_self().  See Documentation/admin-guide/LSM/landlock.rst
 for more details on audit.
 
+UDP networking (ABI < 8)
+------------------------
+
+Starting with the Landlock ABI version 8, it is possible to restrict
+setting the local/remote ports of UDP sockets to specific values. Restrictions
+are now enforced at :manpage:`bind(2)` time with the new
+``LANDLOCK_ACCESS_NET_BIND_UDP`` access right, and at :manpage:`connect(2)`
+time with ``LANDLOCK_ACCESS_NET_CONNECT_UDP``. Finally,
+``LANDLOCK_ACCESS_NET_SENDTO_UDP`` also restricts sending datagrams with
+an explicit destination address (e.g. with :manpage:`sendmsg(2)`) to only some
+specific remote ports.
+
 .. _kernel_support:
 
 Kernel support
@@ -666,10 +716,10 @@ the boot loader.
 Network support
 ---------------
 
-To be able to explicitly allow TCP operations (e.g., adding a network rule with
-``LANDLOCK_ACCESS_NET_BIND_TCP``), the kernel must support TCP
+To be able to explicitly allow TCP or UDP operations (e.g., adding a network rule with
+``LANDLOCK_ACCESS_NET_BIND_TCP``), the kernel must support the TCP/IP protocol suite
 (``CONFIG_INET=y``).  Otherwise, sys_landlock_add_rule() returns an
-``EAFNOSUPPORT`` error, which can safely be ignored because this kind of TCP
+``EAFNOSUPPORT`` error, which can safely be ignored because this kind of TCP or UDP
 operation is already not possible.
 
 Questions and answers
-- 
2.47.3


