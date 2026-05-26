Return-Path: <netdev+bounces-291794-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EA3lIHjHFWqMbAcAu9opvQ
	(envelope-from <netdev+bounces-291794-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:16:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 918935D980B
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 58A36304EFF5
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1483AF64E;
	Tue, 26 May 2026 16:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUe4K29I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688703AEB35;
	Tue, 26 May 2026 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811331; cv=none; b=U6XQO4tFpjILEnAnYiNZRxXMLWj330SmNOFlu1EEKdtYmFecjPZqusTku8Dm8eQ3rKLdLLVl73+MF+G2RloG7VrS4aXxX6W0omp/5LTzztyumdTGURYfEPH6TktPHrKI28lyxy6iho46rxYeRsnMSNIR45BEoaQvWrlLi9M2lxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811331; c=relaxed/simple;
	bh=nh/YYFnk+2QRmeaTsH+fiTBTVmt8pXusmpWaEqS5+CA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYSsDTt4x73bXkW/eyk+NEtGjZu5sl4K9rKlYxQz+QR3WEfZWDABfp4zoViw44Jcg8jt9jmA9U53oYv0Jmthz8l5su1SbQtl9kzeM9A3kUL4gbCiePwxeZOObm4lfNEREJZBWrAdk/CMglWZS4vo8c6Is959/NJTSFY4tSgQCUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUe4K29I; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA511F00A3A;
	Tue, 26 May 2026 16:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779811330;
	bh=b/+90Thpn5dTUDtiUqr9hBwUI0Y/MG0FBjpBpf9OJUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XUe4K29IeEeQRIlhVF4iyFXBEJWG6gx0D64wHNrR20NwmYDP7c7DwK/IirFEuFDu5
	 +D97zJSKZoYpgpnV51qjFC9blMCuPY4YemRAawslW4SPSZhnGl60kXiiS5SgzVlzdt
	 rfj8R0bo17/AMltVoruNA+p12IQZo76bFnJCT8LFhF5nns2EG1J0YXRs2hD7/GPjR/
	 6P/X5z2/XgzcNquVKXjFi6qYfqH2g6hfcaOYr/Jl2dWBPRwLV5aIKFJAT4qMRRTR0T
	 JDIy/Fzd9GzRCysjPUDo1dsCIpfjWJmvLz8Ug1mAVzRFwfL9wQzuVVWTzNv6i+ZPY0
	 iepJ802+q+Xfg==
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
Subject: [PATCH net-next 06/10] docs: net: refresh netdev feature guidance
Date: Tue, 26 May 2026 09:01:47 -0700
Message-ID: <20260526160151.2793354-7-kuba@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,lwn.net,nxp.com,gmail.com,intel.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-291794-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 918935D980B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Update netdev feature documentation for current locking rules and
feature semantics. Clarify hw_features updates and netdev_update_features()
locking, keep the NETIF_F_NEVER_CHANGE rule with the VLAN challenged
exception, fix the HSR duplication wording, and document netdev->netmem_tx
as a device flag rather than a feature bit.

Split the list of basic feature sets from the "extra" ones like
vlan_features. A bunch of the newer fields weren't documented and
having them all together would be confusing.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/networking/netdev-features.rst | 60 +++++++++++++-------
 1 file changed, 39 insertions(+), 21 deletions(-)

diff --git a/Documentation/networking/netdev-features.rst b/Documentation/networking/netdev-features.rst
index 02bd7536fc0c..6293d47e5b09 100644
--- a/Documentation/networking/netdev-features.rst
+++ b/Documentation/networking/netdev-features.rst
@@ -18,29 +18,38 @@ that relieve an OS of various tasks like generating and checking checksums,
 splitting packets, classifying them.  Those capabilities and their state
 are commonly referred to as netdev features in Linux kernel world.
 
-There are currently three sets of features relevant to the driver, and
-one used internally by network core:
+There are currently three main sets of features on each netdevice,
+first and second are initialized by the driver:
 
  1. netdev->hw_features set contains features whose state may possibly
     be changed (enabled or disabled) for a particular device by user's
-    request.  This set should be initialized in ndo_init callback and not
-    changed later.
+    request.  Drivers normally initialize this set before registration or
+    in the ndo_init callback. Changes after registration should be made
+    very carefully as other parts of the code may assume hw_features are
+    static. At the very least changes must be made under rtnl_lock and
+    the netdev instance lock, and followed by netdev_update_features().
 
  2. netdev->features set contains features which are currently enabled
     for a device.  This should be changed only by network core or in
     error paths of ndo_set_features callback.
 
- 3. netdev->vlan_features set contains features whose state is inherited
-    by child VLAN devices (limits netdev->features set).  This is currently
-    used for all VLAN devices whether tags are stripped or inserted in
-    hardware or software.
-
- 4. netdev->wanted_features set contains feature set requested by user.
+ 3. netdev->wanted_features set contains feature set requested by user.
     This set is filtered by ndo_fix_features callback whenever it or
     some device-specific conditions change. This set is internal to
     networking core and should not be referenced in drivers.
 
+On top of those three main sets, each netdev has:
 
+ 1. Sets which control features inherited by child devices (VLAN, MPLS,
+    hw_enc for L3/L4 tunnels). These sets allow the driver to limit which
+    netdev->features are propagated, in case HW cannot perform the offloads
+    with the extra headers present.
+
+ 2. netdev->mangleid_features, TSO features which are supported only when
+    IP ID field can be mangled (constant instead of incrementing) during TSO.
+
+ 3. netdev->gso_partial_features, additional TSO features which HW can
+    support via NETIF_F_GSO_PARTIAL.
 
 Part II: Controlling enabled features
 =====================================
@@ -62,11 +71,15 @@ ndo_*_features callbacks are called with rtnl_lock held. Missing callbacks
 are treated as always returning success.
 
 A driver that wants to trigger recalculation must do so by calling
-netdev_update_features() while holding rtnl_lock. This should not be done
-from ndo_*_features callbacks. netdev->features should not be modified by
-driver except by means of ndo_fix_features callback.
-
+netdev_update_features() while holding rtnl_lock. If the device uses the
+netdev instance lock, that lock must be held as well. This should not be
+done from ndo_*_features callbacks. netdev->features should not be modified
+by driver except by means of ndo_fix_features callback.
 
+ndo_features_check is called for each skb before that skb is passed to
+ndo_start_xmit. Driver may perform any non-trivial checks (e.g. exact
+header geometry / length) and withdraw features like HW_CSUM or TSO,
+requesting the networking stack to fall back to the software implementation.
 
 Part III: Implementation hints
 ==============================
@@ -83,8 +96,9 @@ stateless).  It can be called multiple times between successive
 ndo_set_features calls.
 
 Callback must not alter features contained in NETIF_F_SOFT_FEATURES or
-NETIF_F_NEVER_CHANGE sets. The exception is NETIF_F_VLAN_CHALLENGED but
-care must be taken as the change won't affect already configured VLANs.
+NETIF_F_NEVER_CHANGE, except that NETIF_F_VLAN_CHALLENGED may be changed.
+Care must be taken as changes to NETIF_F_VLAN_CHALLENGED won't affect already
+configured VLANs.
 
  * ndo_set_features:
 
@@ -186,10 +200,14 @@ Redundancy) frames from one port to another in hardware.
 * hsr-dup-offload
 
 This should be set for devices which duplicate outgoing HSR (High-availability
-Seamless Redundancy) or PRP (Parallel Redundancy Protocol) tags automatically
-frames in hardware.
+Seamless Redundancy) or PRP (Parallel Redundancy Protocol) frames
+automatically in hardware.
 
-* netmem-tx
+Part V: Related device flags
+============================
 
-This should be set for devices which support netmem TX. See
-Documentation/networking/netmem.rst
+* netdev->netmem_tx
+
+This is not a netdev feature bit. Drivers support netmem TX by setting
+netdev->netmem_tx to one of the values in enum netmem_tx_mode.
+See Documentation/networking/netmem.rst.
-- 
2.54.0


