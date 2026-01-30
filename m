Return-Path: <netdev+bounces-255228-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBwcJFv+fGnLPgIAu9opvQ
	(envelope-from <netdev+bounces-255228-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 19:54:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A384CBE01A
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 19:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0E7D4300B293
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 18:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E04387353;
	Fri, 30 Jan 2026 18:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wre9+n1g"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4C9385EFE
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 18:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769799250; cv=none; b=Jh2NggyWNzNGTRt1/ksidTDMTxh+KjShY/XiDeYEk2dLb4ofRH3Umsm67ejZ9HJURm66DiKwzqjqOa1fVjIHnrPc7xUz0L9k+t1VNRuG+n+USY5ZIMQRHp8jJrh5bb4cZY/H/Hsn3Ixv06bq6FXFmRo7P84rFqCnSgn3tapgAKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769799250; c=relaxed/simple;
	bh=H6Le6PGu+WGJvOksZ851xu79aGm62xZOfuhPShQUi3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KKisxpLjD9yc2TLNJCyvq+oDbIiSEUZxi4/gUBrjEh4ZBH3+WLKutLumfd7XvxHYw/uVdUcwnAMLFH6skpDjp1fsudzIAJRggpUa/RcgV2Bq/6Lke6mcWANPyljhhIKktMSMAu1oO98idsojFf3pToiylfnLre6QRQYPMHUNPck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wre9+n1g; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769799249; x=1801335249;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H6Le6PGu+WGJvOksZ851xu79aGm62xZOfuhPShQUi3M=;
  b=Wre9+n1g4uWc3/LEDgNOv4Tl64oJygexnbHXCZ56E4CqcIcC/4a6hBHy
   cytHFHAGu+zp5iDYD9i7dtUEKW+pWTGEfVqby1qdtNPj4Yh/B2XT5o44Z
   1WueyWLjUdp7DC0Ql5vW32uh7h0pNZAXyIGWBvi0+yJBG1gclQ1pDhsF1
   OHnJbJO2FimoeiBK/jCYZK8nwamMDu+NGRBttspBBL7+/F0FVeVJNJABs
   Fhjtvri0CErIkYT5+z6e8FB1uCxKlGAuXA8eNwKglfGWBJO1cLI6BngIi
   0jnSXwwd/6EYQ+RWXz4GZQkC2bc89JwT10GpaOgYH0B6mOtAWyFzw7KSb
   g==;
X-CSE-ConnectionGUID: aXkhxPBKTfiukKkICyhAXA==
X-CSE-MsgGUID: fv84nTu5STe1WhoiDp1NTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="71091293"
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="71091293"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 10:54:07 -0800
X-CSE-ConnectionGUID: WmkAKozvQIqCVKhuIp/3cw==
X-CSE-MsgGUID: dvISkb9zThaUmlJ4kjA48Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="231841011"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 30 Jan 2026 10:54:07 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Mohammad Heib <mheib@redhat.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	sdf@fomichev.me,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 4/5] ice: drop udp_tunnel_get_rx_info() call from ndo_open()
Date: Fri, 30 Jan 2026 10:53:57 -0800
Message-ID: <20260130185401.1091523-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260130185401.1091523-1-anthony.l.nguyen@intel.com>
References: <20260130185401.1091523-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255228-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A384CBE01A
X-Rspamd-Action: no action

From: Mohammad Heib <mheib@redhat.com>

The ice driver calls udp_tunnel_get_rx_info() during ice_open_internal().
This is redundant because UDP tunnel RX offload state is preserved
across device down/up cycles. The udp_tunnel core handles
synchronization automatically when required.

Furthermore, recent changes in the udp_tunnel infrastructure require
querying RX info while holding the udp_tunnel lock. Calling it
directly from the ndo_open path violates this requirement,
triggering the following lockdep warning:

Call Trace:
  <TASK>
  ice_open_internal+0x253/0x350 [ice]
  __udp_tunnel_nic_assert_locked+0x86/0xb0 [udp_tunnel]
  __dev_open+0x2f5/0x880
  __dev_change_flags+0x44c/0x660
  netif_change_flags+0x80/0x160
  devinet_ioctl+0xd21/0x15f0
  inet_ioctl+0x311/0x350
  sock_ioctl+0x114/0x220
  __x64_sys_ioctl+0x131/0x1a0
  ...
  </TASK>

Remove the redundant and unsafe call to udp_tunnel_get_rx_info() from
ice_open_internal() to resolve the locking violation

Fixes: 1ead7501094c ("udp_tunnel: remove rtnl_lock dependency")
Signed-off-by: Mohammad Heib <mheib@redhat.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index c1033070d0c7..d04605d3e61a 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -9662,9 +9662,6 @@ int ice_open_internal(struct net_device *netdev)
 		netdev_err(netdev, "Failed to open VSI 0x%04X on switch 0x%04X\n",
 			   vsi->vsi_num, vsi->vsw->sw_id);
 
-	/* Update existing tunnels information */
-	udp_tunnel_get_rx_info(netdev);
-
 	return err;
 }
 
-- 
2.47.1


