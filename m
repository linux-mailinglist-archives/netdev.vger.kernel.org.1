Return-Path: <netdev+bounces-291790-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIA7HlbHFWqMbAcAu9opvQ
	(envelope-from <netdev+bounces-291790-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:16:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7B85D97D7
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 13FB03040356
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A6E3AE6F4;
	Tue, 26 May 2026 16:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bh/Hpy+0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12263AE713;
	Tue, 26 May 2026 16:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811329; cv=none; b=E9c14UDlJ2dRmRuvWGyFwtaeGubbsvT/qwPd8ieKh56v+L+8bt84C5P+oZglNAoQS6aDXu7g3SI1YF/bnPwiY4UleX4laEXyLwPuROjgJA18k2qEe9h5+nWCvAJxjb5Zp4+2u4botJFAjQooa599epE8CuXAoRx/XDJe13Ra488=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811329; c=relaxed/simple;
	bh=KOXzdd4xd6nTSWHCtC/WE6KKKs2l14a8IICPQ+bpz+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iueD+VQ5HEvpH6zR81J41NZ/aMMnCii6N9knsvTfnfFNEBMRNbwJcjdfdB52ObWs3TvVgEQnOLEOOSY6ZiYMcir7gAiEV5PPhLG/fm5aXDaup2k4kfSbH4dQKm35lbh5lZWbxn2oqtXbyNCNroM28KUDXtqGXBKzkClSu0CgRE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bh/Hpy+0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3251F00ACF;
	Tue, 26 May 2026 16:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779811327;
	bh=lsbczLgSlFDkeQUbxwLuD+CmyZHjIC341E5zE3yocKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bh/Hpy+0fXspY2MEsQH0gy5RuoZooje8nyhtK6VvPlAPCmtikRCB3kOPK20D68D+r
	 EhytfHmqXdalyJD29S2sBZ/1WxquF8UcfGG17bsWl6hadyGULcKjlLRokhOEyMXGvy
	 a4LrcIhQ9mIIAtTF2iaG3SWk2zOsZiOMq9Wgwq54DhE1cj8im70Nls6xCjuWyLNV7Y
	 jUD/lEvDERgTOi5wqMeNECMosdJT7q8+oZvjD0T+FL8jLsKWxyh7dBnf6IiKDfsiLH
	 ejxK9Q4bl8OZn2kGMIQ2vpKbK6yV3MVA9bnis4sVszjN42R0Ui2el+decElq5M6sYQ
	 gV2rdCCZGYS7Q==
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
Subject: [PATCH net-next 02/10] docs: net: fix minor issues with driver guide
Date: Tue, 26 May 2026 09:01:43 -0700
Message-ID: <20260526160151.2793354-3-kuba@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-291790-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 7D7B85D97D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Update the driver documentation TX queue example to match current APIs:

- use the ring-local tx_ring_mask field in drv_tx_avail()
- stop the selected netdev_queue with netif_tx_stop_queue() instead of
  stopping queue 0 with netif_stop_queue()

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/networking/driver.rst | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/driver.rst b/Documentation/networking/driver.rst
index 4f5dfa9c022e..195a916dc0de 100644
--- a/Documentation/networking/driver.rst
+++ b/Documentation/networking/driver.rst
@@ -51,7 +51,7 @@ Instead it must maintain the queue properly.  For example,
 	{
 		u32 used = READ_ONCE(dr->prod) - READ_ONCE(dr->cons);
 
-		return dr->tx_ring_size - (used & bp->tx_ring_mask);
+		return dr->tx_ring_size - (used & dr->tx_ring_mask);
 	}
 
 	static netdev_tx_t drv_hard_start_xmit(struct sk_buff *skb,
@@ -69,7 +69,7 @@ Instead it must maintain the queue properly.  For example,
 		//...
 		/* This should be a very rare race - log it. */
 		if (drv_tx_avail(dr) <= skb_shinfo(skb)->nr_frags + 1) {
-			netif_stop_queue(dev);
+			netif_tx_stop_queue(txq);
 			netdev_warn(dev, "Tx Ring full when queue awake!\n");
 			return NETDEV_TX_BUSY;
 		}
@@ -103,6 +103,9 @@ Lockless queue stop / wake helper macros
 .. kernel-doc:: include/net/netdev_queues.h
    :doc: Lockless queue stopping / waking helpers.
 
+The standard macros like netif_txq_maybe_stop(), netif_txq_try_stop() etc.
+are well tested, prefer them over local synchronization schemes.
+
 No exclusive ownership
 ----------------------
 
-- 
2.54.0


