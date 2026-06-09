Return-Path: <netdev+bounces-297273-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AfygGVh0KGrrEwMAu9opvQ
	(envelope-from <netdev+bounces-297273-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 22:15:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B71206640CD
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 22:15:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=iAENGndj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297273-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297273-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CB33306B7C6
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 20:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A723382374;
	Tue,  9 Jun 2026 20:12:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A7C38CFE7;
	Tue,  9 Jun 2026 20:12:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781035951; cv=none; b=IFFdV6fnXjnAuXlBzgE9BgOvy8UXZ1OTvK2BpfYPeBmBhA8BAZWzwLBQSzFIa4vHwlArvGydhq8JEriwkEzh05n/LncWgNdYHuol5KNXkyR0nQyf8bqbqD30l2/4deZkFsg6bRseQIzrhdbHAFdouyq1qKtZjdEpVwQ/MgH8n6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781035951; c=relaxed/simple;
	bh=D7/Mzo5e+5VWLEtVYVgkwc3DygrunrzHZAWo1Yrfk4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTSbgpzFO7Tzjn0T6o7PJZZNBt4eDX/hQ1WNJa2h437vBEcMdm/AibUa9zSynmbrW2VR/pb8aneIXdT63ZIiCwZQIfEo69prPc+qzkpu9dxbHCTL7QSZ4qb/nadnTcdsF6OzM20sDwojd5c2tyr1JDgnEI6iV/7gC0ntzPMRYhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAENGndj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88D21F00893;
	Tue,  9 Jun 2026 20:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781035949;
	bh=MpH5v7DVv18T+ddYArDGKMK3ROzq6Z3ud0/C2F8Yez4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iAENGndjkV7VfPS4uQ6HbD3iW7BCAUB33VXKE6+WpRPeK4lXbOF40065xNARysX5J
	 riq4RUfeX0bBrMQZ7x9Tv8RmL0a1k/xhSWXQxs54WWfixacD9aZU9KA6B9ENc1B3Fa
	 n29vkI5OvXfoFX+SZUChAuICFY8akoi3CLX6idcq3dCgj293X3Q3mex2Jj9V9Y25Rd
	 WLZmbH3T+hgMobMmkcDRJrCtBbRiaSPs5AlWrz6L/ZpVDOxBApZs5j+8U8GcFErlcW
	 tV20dcs08OnYOW/iWswZ4qvP0+TKBDtmVV8igSnlUeKCGYiq463DA2jmvJf355EQPc
	 cgXjdiyXCuadA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	jiri@resnulli.us,
	skhan@linuxfoundation.org
Subject: [PATCH net-next 3/3] docs: net: fix minor issues with devlink docs
Date: Tue,  9 Jun 2026 13:12:24 -0700
Message-ID: <20260609201224.1191391-4-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609201224.1191391-1-kuba@kernel.org>
References: <20260609201224.1191391-1-kuba@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297273-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:corbet@lwn.net,m:linux-doc@vger.kernel.org,m:bpf@vger.kernel.org,m:kuba@kernel.org,m:jiri@resnulli.us,m:skhan@linuxfoundation.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,resnulli.us:email,lwn.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B71206640CD

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


