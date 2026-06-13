Return-Path: <netdev+bounces-298988-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3pJzNpGMLWqPhQQAu9opvQ
	(envelope-from <netdev+bounces-298988-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 19:00:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFC667F1BC
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 19:00:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kDCArR1M;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298988-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298988-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB3413048575
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 16:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2825E3FF88C;
	Sat, 13 Jun 2026 16:59:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D278F30DECE;
	Sat, 13 Jun 2026 16:59:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781369971; cv=none; b=MzYXjwH+rbh79OcaWFy91kASHe7pXDoBR1gcfZqnH+4zefVPrHkxAKstZCDfNl/obrt+pUzA2Ysvip1pPZPsUUg+LUlwBgml3jnqaKnmFdY2xHfaJjlEWEI8xDbD1JnL38DL/j68U94uQgVmGuVJWqRVUuQqHsvF/NeGZIIBhxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781369971; c=relaxed/simple;
	bh=D7/Mzo5e+5VWLEtVYVgkwc3DygrunrzHZAWo1Yrfk4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H8VYxLBXkoiwd8WCCEXVZ/MBXLvS1LYovcFgGMetdhrb+9S9Rco12gPLik1vKJVmUCNl1ql2LjgEbkC0kuZ0EWYXM+0PUK1WdAqFmy025B+aR0/7vi9t8mPKF98g+0yp7KG9SJb64vH11xQrWMmpSlBtVJZdMzHV11DXxSjs9bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDCArR1M; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BC51F00A3D;
	Sat, 13 Jun 2026 16:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781369969;
	bh=MpH5v7DVv18T+ddYArDGKMK3ROzq6Z3ud0/C2F8Yez4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kDCArR1M61CuVcEEkROnooeMI1Nr+It/tBL55MdCW3h5D2a+1DKRkOH0iYkbobc8V
	 FLix2xEbA1vQTHONFFpnb0Cbhdf/kQ32kf9SL7SlufFvzeQnkL9aqVWMZzyug7BC7W
	 Qf1QC+zJvf8UWQlwf+FPDG2udQiVKzi6MYVnNUDiolNomgWaz+9BVKsXocf1+8bb6V
	 r61sbSY0VxqWFMX+a01HSmo89gUPSv1XurYs/x63WH5snew/zYdFYYqntnPwdXRwK3
	 OkivSWoT0VGZyxC4cKLp1mIQ633mjoqneZz2KtZieSZByxfqb22JtnL9mO59Uo58U8
	 wXJbEtPlvW0IA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	john.fastabend@gmail.com,
	sd@queasysnail.net,
	jiri@resnulli.us,
	Jakub Kicinski <kuba@kernel.org>,
	skhan@linuxfoundation.org
Subject: [PATCH net-next v2 2/3] docs: net: fix minor issues with devlink docs
Date: Sat, 13 Jun 2026 09:58:45 -0700
Message-ID: <20260613165846.2913092-3-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613165846.2913092-1-kuba@kernel.org>
References: <20260613165846.2913092-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298988-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:corbet@lwn.net,m:linux-doc@vger.kernel.org,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:jiri@resnulli.us,m:kuba@kernel.org,m:skhan@linuxfoundation.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,lwn.net,gmail.com,queasysnail.net,resnulli.us,linuxfoundation.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lwn.net:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7EFC667F1BC

Update devlink documentation to match current code:

- describe health reporter defaults (it's currently under "callbacks"),
  best-effort auto-dump, and port-scoped reporters
- fix generic parameter names and values
- fix nested devlink setup wording and registration ordering

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jiri@resnulli.us
CC: corbet@lwn.net
CC: skhan@linuxfoundation.org
CC: linux-doc@vger.kernel.org
---
 Documentation/networking/devlink/devlink-health.rst | 12 ++++++++----
 Documentation/networking/devlink/devlink-params.rst |  2 +-
 Documentation/networking/devlink/devlink-port.rst   |  5 ++++-
 Documentation/networking/devlink/devlink-trap.rst   |  8 +++++---
 Documentation/networking/devlink/index.rst          | 10 +++++-----
 5 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/Documentation/networking/devlink/devlink-health.rst b/Documentation/networking/devlink/devlink-health.rst
index 4d10536377ab..bedac58a2f36 100644
--- a/Documentation/networking/devlink/devlink-health.rst
+++ b/Documentation/networking/devlink/devlink-health.rst
@@ -33,7 +33,9 @@ asynchronously. All health reports handling is done by ``devlink``.
   * Recovery procedures
   * Diagnostics procedures
   * Object dump procedures
-  * Out Of Box initial parameters
+
+Drivers also provide default values for generic reporter parameters when
+creating a health reporter.
 
 Different parts of the driver can register different types of health reporters
 with different handlers.
@@ -45,8 +47,9 @@ Actions
 
   * A log is being send to the kernel trace events buffer
   * Health status and statistics are being updated for the reporter instance
-  * Object dump is being taken and saved at the reporter instance (as long as
-    auto-dump is set and there is no other dump which is already stored)
+  * Object dump is being taken and saved at the reporter instance. This is
+    best effort and skipped when recovery is aborted, auto-dump is disabled,
+    no dump callback is registered, or a dump is already stored.
   * Auto recovery attempt is being done. Depends on:
 
     - Auto-recovery configuration
@@ -75,7 +78,8 @@ User Interface
 ==============
 
 User can access/change each reporter's parameters and driver specific callbacks
-via ``devlink``, e.g per error type (per health reporter):
+via ``devlink``, e.g. per error type (per health reporter). Reporters may be
+registered for the whole devlink instance or for a specific devlink port.
 
   * Configure reporter's generic parameters (like: disable/enable auto recovery)
   * Invoke recovery procedure
diff --git a/Documentation/networking/devlink/devlink-params.rst b/Documentation/networking/devlink/devlink-params.rst
index ea17756dcda6..ca19ee3e63c8 100644
--- a/Documentation/networking/devlink/devlink-params.rst
+++ b/Documentation/networking/devlink/devlink-params.rst
@@ -122,7 +122,7 @@ own name.
    * - ``enable_iwarp``
      - Boolean
      - Enable handling of iWARP traffic in the device.
-   * - ``internal_err_reset``
+   * - ``internal_error_reset``
      - Boolean
      - When enabled, the device driver will reset the device on internal
        errors.
diff --git a/Documentation/networking/devlink/devlink-port.rst b/Documentation/networking/devlink/devlink-port.rst
index 5e397798a402..9374ebe70f48 100644
--- a/Documentation/networking/devlink/devlink-port.rst
+++ b/Documentation/networking/devlink/devlink-port.rst
@@ -38,7 +38,7 @@ Devlink port flavours are described below.
      - This indicates an eswitch port representing a port of PCI
        subfunction (SF).
    * - ``DEVLINK_PORT_FLAVOUR_VIRTUAL``
-     - This indicates a virtual port for the PCI virtual function.
+     - Any virtual port facing the user.
 
 Devlink port can have a different type based on the link layer described below.
 
@@ -134,6 +134,9 @@ Users may also set the IPsec crypto capability of the function using
 Users may also set the IPsec packet capability of the function using
 `devlink port function set ipsec_packet` command.
 
+The ``migratable`` attribute may be set only on ports with
+``DEVLINK_PORT_FLAVOUR_PCI_VF``.
+
 Users may also set the maximum IO event queues of the function
 using `devlink port function set max_io_eqs` command.
 
diff --git a/Documentation/networking/devlink/devlink-trap.rst b/Documentation/networking/devlink/devlink-trap.rst
index 5885e21e2212..ac5bf9337198 100644
--- a/Documentation/networking/devlink/devlink-trap.rst
+++ b/Documentation/networking/devlink/devlink-trap.rst
@@ -516,9 +516,11 @@ Generic Packet Trap Groups
 
 Generic packet trap groups are used to aggregate logically related packet
 traps. These groups allow the user to batch operations such as setting the trap
-action of all member traps. In addition, ``devlink-trap`` can report aggregated
-per-group packets and bytes statistics, in case per-trap statistics are too
-narrow. The description of these groups must be added to the following table:
+action of all member drop traps whose action may legally change. Exception and
+control traps remain unchanged. In addition, ``devlink-trap`` can report
+aggregated per-group packets and bytes statistics, in case per-trap statistics
+are too narrow. The description of these groups must be added to the following
+table:
 
 .. list-table:: List of Generic Packet Trap Groups
    :widths: 10 90
diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index f7ba7dcf477d..32f70879ddd0 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -13,8 +13,8 @@ new APIs prefixed by ``devl_*``. The older APIs handle all the locking
 in devlink core, but don't allow registration of most sub-objects once
 the main devlink object is itself registered. The newer ``devl_*`` APIs assume
 the devlink instance lock is already held. Drivers can take the instance
-lock by calling ``devl_lock()``. It is also held all callbacks of devlink
-netlink commands.
+lock by calling ``devl_lock()``. It is also held across all callbacks of
+devlink netlink commands.
 
 Drivers are encouraged to use the devlink instance lock for their own needs.
 
@@ -33,11 +33,11 @@ devlink instances created underneath. In that case, drivers should make
    lock of both nested and parent instances at the same time, devlink
    instance lock of the parent instance should be taken first, only then
    instance lock of the nested instance could be taken.
- - Driver should use object-specific helpers to setup the
-   nested relationship:
+ - Driver should use object-specific helpers to setup the nested relationship
+   before registering the nested devlink instance:
 
    - ``devl_nested_devlink_set()`` - called to setup devlink -> nested
-     devlink relationship (could be user for multiple nested instances.
+     devlink relationship (could be used for multiple nested instances).
    - ``devl_port_fn_devlink_set()`` - called to setup port function ->
      nested devlink relationship.
    - ``devlink_linecard_nested_dl_set()`` - called to setup linecard ->
-- 
2.54.0


