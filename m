Return-Path: <netdev+bounces-291789-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCUeFKDFFWqxawcAu9opvQ
	(envelope-from <netdev+bounces-291789-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:09:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D0A5D95A9
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2000A3026277
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1FB3ACA5A;
	Tue, 26 May 2026 16:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdiJDBTa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5126F3AE707;
	Tue, 26 May 2026 16:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811329; cv=none; b=eKAdmXpU0ip8wde1jCwoxKMzvezxNc1Vl0DFt0524TGwbSpf3VjsnJ7qRjYfLLZZZx7p+1eTVcPm4uoYK6piUw0rAXXxzpCNhCe2WJhwidxFyNSqT25XW8vAAlFv4aTG7zdyuHSwJqRVZvqVR/TjL5mnpEnSWgh2VthbqFIvte8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811329; c=relaxed/simple;
	bh=ikL53l5I0xjFddb374j1SCSCroWRI4gsprN7eGLwcJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9xDp3/AyA44/tKag8DCZE4S1H29OHoITPztleSPQOwvzst7GrnBkIr9zm5EPMHeMd4sXvmrKqiR/WO9irrO786oWwOPiCl6AV7Nx4YDx8rixablJSPyEnf6+p4kXiT96m7XgD5DJlFRtSVQmpOfZrcQOFUXxS2WW19truOsp/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdiJDBTa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE101F00A3A;
	Tue, 26 May 2026 16:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779811326;
	bh=tYamZlqxZ/y8MBrGQPb+4YS8BUL8bCOe0fK6Ny6BmcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TdiJDBTaK46e1yUTiuXBApioIXwifd2Fagp9+p8HH5B2KYrFo1UyXcRUin0rBVdnt
	 mcLC+moIpfASpdMoZeBPws5md7LAv7NYKDRw7bnKo6h7KqHSWNFpkm70LairUIi4ft
	 iEfFVlpLJtbYR0NwPu6MKnQYDquVIX35kHB1DApCmPYO7LNUPktbefalgv9lNVxbJd
	 5XtravQ1E6mivjLXiCJAR3qjENDQZyib/6csXg00wrJYGlRMXbBuQlLWbS6WEQOofg
	 K2hxIHiEU9Z5Sjnv2THGIVIB7vyABIyVA9NZq5vevHwCQt5OVGOOhVbFxn6GRAkOxh
	 LTj6NsLaY1gkA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	corbet@lwn.net,
	vladimir.oltean@nxp.com,
	willemb@google.com,
	sdf.kernel@gmail.com,
	ecree.xilinx@gmail.com,
	jesse.brandeburg@intel.com,
	linux-doc@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 01/10] docs: net: netdevices: small fixes and clarifications
Date: Tue, 26 May 2026 09:01:42 -0700
Message-ID: <20260526160151.2793354-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526160151.2793354-1-kuba@kernel.org>
References: <20260526160151.2793354-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,lwn.net,nxp.com,gmail.com,intel.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-291789-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 11D0A5D95A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A handful of unrelated nits:

 - free_netdevice() does not exist; replace two stray references
   with free_netdev().
 - The simple-driver probe example fell through into err_undo after
   register_netdev() success; add return 0 for clarity.
 - Clarify the netdev_priv() paragraph: "(netdev_priv())" was easy
   to misread as the thing that needs explicit freeing; spell out
   that it refers to extra pointers stored in the device private
   struct.
 - ndo_setup_tc synchronization note: TC_SETUP_BLOCK / TC_SETUP_FT
   actually run under block->cb_lock, not "NFT locks", and rtnl_lock
   may or may not be held depending on path.
 - ->lltx guidance reads as very outdated, it's not really deprecated.
   I suspect people may have been trying to use it for HW drivers
   in the past but I can't think of such a case in the last decade.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/networking/netdevices.rst | 31 ++++++++++++++-----------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index 93e06e8d51a9..60492d4df2ee 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -21,13 +21,14 @@ by free_netdev(). This is required to handle the pathological case cleanly
 alloc_netdev_mqs() / alloc_netdev() reserve extra space for driver
 private data which gets freed when the network device is freed. If
 separately allocated data is attached to the network device
-(netdev_priv()) then it is up to the module exit handler to free that.
+(extra pointers stored in the device private struct) then it is up
+to the module exit handler to free that.
 
 There are two groups of APIs for registering struct net_device.
 First group can be used in normal contexts where ``rtnl_lock`` is not already
 held: register_netdev(), unregister_netdev().
 Second group can be used when ``rtnl_lock`` is already held:
-register_netdevice(), unregister_netdevice(), free_netdevice().
+register_netdevice(), unregister_netdevice(), free_netdev().
 
 Simple drivers
 --------------
@@ -58,6 +59,7 @@ In that case the struct net_device registration is done using
       goto err_undo;
 
     /* net_device is visible to the user! */
+    return 0;
 
   err_undo:
     /* ... undo the device setup ... */
@@ -73,7 +75,7 @@ In that case the struct net_device registration is done using
 
 Note that after calling register_netdev() the device is visible in the system.
 Users can open it and start sending / receiving traffic immediately,
-or run any other callback, so all initialization must be done prior to
+or run any other callback, so all initialization must be **complete** prior to
 registration.
 
 unregister_netdev() closes the device and waits for all users to be done
@@ -157,7 +159,7 @@ register_netdevice() fails. The callback may be invoked with or without
 There is no explicit constructor callback, driver "constructs" the private
 netdev state after allocating it and before registration.
 
-Setting struct net_device.needs_free_netdev makes core call free_netdevice()
+Setting struct net_device.needs_free_netdev makes core call free_netdev()
 automatically after unregister_netdevice() when all references to the device
 are gone. It only takes effect after a successful call to register_netdevice()
 so if register_netdevice() fails driver is responsible for calling
@@ -256,7 +258,7 @@ struct net_device synchronization rules
 	lock if the driver implements queue management or shaper API.
 	Context: process
 
-ndo_get_stats:
+ndo_get_stats / ndo_get_stats64:
 	Synchronization: RCU (can be called concurrently with the stats
 	update path).
 	Context: atomic (can't sleep under RCU)
@@ -264,12 +266,9 @@ struct net_device synchronization rules
 ndo_start_xmit:
 	Synchronization: __netif_tx_lock spinlock.
 
-	When the driver sets dev->lltx this will be
-	called without holding netif_tx_lock. In this case the driver
-	has to lock by itself when needed.
-	The locking there should also properly protect against
-	set_rx_mode. WARNING: use of dev->lltx is deprecated.
-	Don't use it for new drivers.
+	When the driver sets dev->lltx this will be called without holding
+	netif_tx_lock. dev->lltx is meant for software drivers only, since
+	they often have no per-queue state.
 
 	Context: Process with BHs disabled or BH (timer),
 		 will be called with interrupts disabled by netconsole.
@@ -304,11 +303,15 @@ struct net_device synchronization rules
 	lock if the driver implements queue management or shaper API.
 
 ndo_setup_tc:
-	``TC_SETUP_BLOCK`` and ``TC_SETUP_FT`` are running under NFT locks
-	(i.e. no ``rtnl_lock`` and no device instance lock). The rest of
-	``tc_setup_type`` types run under netdev instance lock if the driver
+	Locking depends on ``tc_setup_type``. For most types the callback
+	is invoked under ``rtnl_lock`` and netdev instance lock if the driver
 	implements queue management or shaper API.
 
+	For ``TC_SETUP_BLOCK`` and ``TC_SETUP_FT`` ``rtnl_lock`` may or
+	may not be held, and the netdev instance lock is not held.
+	``TC_SETUP_BLOCK`` runs under ``block->cb_lock`` and ``TC_SETUP_FT``
+	runs under ``flowtable->flow_block_lock``.
+
 Most ndo callbacks not specified in the list above are running
 under ``rtnl_lock``. In addition, netdev instance lock is taken as well if
 the driver implements queue management or shaper API.
-- 
2.54.0


