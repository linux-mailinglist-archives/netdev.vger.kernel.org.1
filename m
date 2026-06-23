Return-Path: <netdev+bounces-301372-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UxWAAVuLOmoJ/gcAu9opvQ
	(envelope-from <netdev+bounces-301372-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 15:34:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A536B77A9
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 15:34:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=DHDEHySX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301372-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301372-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1AB653029D67
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 13:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5DF37BE60;
	Tue, 23 Jun 2026 13:33:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2E437BE74;
	Tue, 23 Jun 2026 13:33:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782221609; cv=none; b=nse7xtT+KRr3WxQWydV/sKhl8JD4bP0G42f4+a6YqFudLO5oDsHuAvZCmHSNJSZHUiIumkpP0iF9EzwS27JVhqjGCH6+JigSq25/d7MLeFPl3SUdR2X1pm0cc3RBF6qn8st/1fjJhdVU5J86sMpluM7VVdwnG92EOLVrpH1DJe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782221609; c=relaxed/simple;
	bh=RiH/SSqf55hB48rdQWOBYZ+gB9VxNuiEWCwkZUkGrcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WbOHkD24kL89hbkWFNha2NxElmFhqvz91KUSp1Mcu5p7QSv+hzcTI1tYhqZkoQ3zHnJXkNJputf2aITHoyMTlKA546LQFBcCOAzAqi/wZBoYD1SVsECFuIGR7YwHdQcX9TdIagODiK/4XVX3F2VKGC1sUl4xRTvKToXwlyYCWns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DHDEHySX; arc=none smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782221608; x=1813757608;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RiH/SSqf55hB48rdQWOBYZ+gB9VxNuiEWCwkZUkGrcQ=;
  b=DHDEHySXoY+QcHNOdI3WDhD5gDJQcTtEFjoIxOXmtGCUSfObTWbGtmbI
   e9kvBUmqZpMI6kbYmmIeva6tj1z/WevirJuKrXapQI/zkp6rSc3NQABHp
   5lkl1KZY8d6JVQDrz2+Nj39D1w2MV50NtXOkmlW4NuPZAmI8xH5FEWZYb
   P8wbAHh0jxzpkXyziTMhznmJBLdz8Ztv5zcdoQAV+pFOlY7LHV7wUQI8X
   gKaHgI0suMlNntVKCmHt5bo0p4WoSpph5dvw02LGZU8oqVuSYqNEchuUz
   HulX+1a9mZju8F48tj9qdMGBqGEn/xFpfQjH+MG/ILjivk/Q9lwPm4oUL
   g==;
X-CSE-ConnectionGUID: cpGbxmf/ReGiyu6zVeZViw==
X-CSE-MsgGUID: bAgA9h1bSXqU9j87yJm48g==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="83153551"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="83153551"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 06:33:27 -0700
X-CSE-ConnectionGUID: dOV6FPxsQqiyNM6iP8j7jA==
X-CSE-MsgGUID: lHI7hKCRRieih+LOsnaPSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="251447514"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa004.fm.intel.com with ESMTP; 23 Jun 2026 06:33:25 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kerneljasonxing@gmail.com,
	bjorn@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH net 4/7] xsk: reclaim offending invalid desc in generic multi-buffer Tx
Date: Tue, 23 Jun 2026 15:32:37 +0200
Message-Id: <20260623133240.1048434-5-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260623133240.1048434-1-maciej.fijalkowski@intel.com>
References: <20260623133240.1048434-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-301372-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kerneljasonxing@gmail.com,m:bjorn@kernel.org,m:maciej.fijalkowski@intel.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 04A536B77A9

After an invalid descriptor is found in __xsk_generic_xmit(),
xskq_cons_peek_desc() returns false and the loop body is not entered.
Jason's drain fixes reclaim descriptors already attached to xs->skb and
later continuation descriptors handled through drain_cont, but the
offending descriptor that made peek fail is only released from the Tx
ring.

This loses one completion for each invalid multi-buffer packet in the
generic path. Userspace then waits forever for a descriptor that has
already been consumed by the kernel.

If the failed descriptor belongs to an already-started or already-draining
multi-buffer packet, publish its address to the completion ring before
releasing it. Standalone invalid descriptors keep the existing behavior.

Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 net/xdp/xsk.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index c489fadc3608..43791647cf18 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1125,8 +1125,22 @@ static int __xsk_generic_xmit(struct sock *sk)
 	}
 
 	if (xskq_has_descs(xs->tx)) {
+		bool reclaim_desc = xs->skb || xs->drain_cont;
+
+		if (reclaim_desc) {
+			err = xsk_cq_reserve_locked(xs->pool);
+			if (err) {
+				err = -EAGAIN;
+				goto out;
+			}
+		}
+
 		if (xs->skb)
 			xsk_drop_skb(xs->skb);
+
+		if (reclaim_desc)
+			xsk_cq_submit_addr_single_locked(xs->pool, &desc);
+
 		xskq_cons_release(xs->tx);
 		xs->drain_cont = xp_mb_desc(&desc);
 	}
-- 
2.43.0


