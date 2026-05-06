Return-Path: <netdev+bounces-284731-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOUkNyvu+mn3UQMAu9opvQ
	(envelope-from <netdev+bounces-284731-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 09:30:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5138A4D73EE
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 09:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A40EA30817CD
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 07:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F8837882E;
	Wed,  6 May 2026 07:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="e0ZNKn6c"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A32636EAB0;
	Wed,  6 May 2026 07:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778052383; cv=none; b=XK7dLm5HUGS1SJiqlb96lFBljrDXFB54kS6m0ZL4qDZK0ppPmpnsgNtpaMRkQCs8FtTeczBrfza40hnSkFVk+gRWGTW5fvjlOJyIdBvUfBKk2ZKpKHkiIYSdmAX1cLyZ/+l8EqMxBUVk2Binp7hzt2Y+SJcP0oVKorsXuhcgOds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778052383; c=relaxed/simple;
	bh=p4pAZ0/fok0BwxIaJ58/y4fEjxsVXXl/HmXllQWn8+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=NRLthwSfZcfsvqZ84W6NzNCU3ze7TBAdgL0zLF2S+Kfxhnly6WaLihMsRQ6cw3brNiGkxcq9Bw8+muMFvxcBj5E8hh21DKHy749tQ9Y/KNhCArKbvJlledaelyxgXQi/b7Yc18yJzbi5I7moDSjD4ZMTAm3ljUJDAZfynnZXXgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=e0ZNKn6c; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1778052382; x=1809588382;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=p4pAZ0/fok0BwxIaJ58/y4fEjxsVXXl/HmXllQWn8+4=;
  b=e0ZNKn6cH5CwnQE6jEyvV4vpEDqAAdMc5gSG5U8rhAD6Dfw85JrJFFLN
   4jODsx3lQE49N8juZMZ0fHy6Kl9MsbfnCJVpS8X/Slv0/oAbTwccpIF8o
   3fIBGSGVtkrbRHWAD28Txsp5s8MnHcsRgu/dIMx6z6WIo7xZI2YvHeSMq
   ME/8He7hwa7MeiWIsQkFMLgP9Azi9nopnN9wCNBImbx9hnn22XXu0CSJY
   cAHx04FiRvuEiGmh81/iwoonPgVCSH3IVXTTWZJyCZ6RgvkRVt1JbI/vm
   7W0KMRIb63ZBbvu7XfFsYXc3kNR9mJ6MGHCq3QT5lj62PQAY1miRYeVEJ
   A==;
X-CSE-ConnectionGUID: aytPD8RyTQSa+hCeH27eTA==
X-CSE-MsgGUID: xUSBkdGQR/+QHPXKO4BH+Q==
X-IronPort-AV: E=Sophos;i="6.23,219,1770620400"; 
   d="scan'208";a="57105539"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 00:26:15 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Wed, 6 May 2026 00:26:15 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 6 May 2026 00:26:11 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Wed, 6 May 2026 09:25:37 +0200
Subject: [PATCH net v2 2/4] net: sparx5: fix sleep in atomic context in MAC
 table access
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260506-misc-fixes-sparx5-lan969x-v2-2-fb236aa96908@microchip.com>
References: <20260506-misc-fixes-sparx5-lan969x-v2-0-fb236aa96908@microchip.com>
In-Reply-To: <20260506-misc-fixes-sparx5-lan969x-v2-0-fb236aa96908@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Clark Williams
	<clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Bjarni Jonasson
	<bjarni.jonasson@microchip.com>, Lars Povlsen <lars.povlsen@microchip.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <kees@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Steen Hegelund
	<steen.hegelund@microchip.com>, <linux-rt-devel@lists.linux.dev>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 5138A4D73EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284731-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microchip.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:email,microchip.com:dkim,microchip.com:mid]

sparx5_set_rx_mode() runs with netif_addr_lock_bh held and iterates
dev->mc via __dev_mc_sync(), which per address calls sparx5_mc_sync() /
sparx5_mc_unsync() -> sparx5_mact_learn() / sparx5_mact_forget().  These
take sparx5->lock, a mutex, and then poll the MAC access command
register with readx_poll_timeout(). A mutex may block, which is not
allowed from atomic context.

Convert the driver to the new .ndo_set_rx_mode_async callback introduced
in commit 3554b4345d85 ("net: introduce ndo_set_rx_mode_async and
netdev_rx_mode_work"). The async callback is invoked from process
context, so the mutex and sleeping completion poll can remain.

Observed with CONFIG_PROVE_LOCKING, CONFIG_DEBUG_SPINLOCK,
CONFIG_DEBUG_MUTEXES and CONFIG_DEBUG_ATOMIC_SLEEP enabled:

  BUG: sleeping function called from invalid context at kernel/locking/mutex.c:591
  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 217, name: ip
  preempt_count: 201, expected: 0
  Call trace:
   __might_resched+0x144/0x248
   __might_sleep+0x48/0x7c
   __mutex_lock+0x74/0x850
   mutex_lock_nested+0x24/0x30
   sparx5_mact_learn+0x78/0x100
   sparx5_mc_sync+0x40/0x54
   __hw_addr_sync_dev+0xc4/0x170
   sparx5_set_rx_mode+0x4c/0x58
   __dev_set_rx_mode+0x64/0xa4
   __dev_open+0x1ec/0x26c

Fixes: b37a1bae742f ("net: sparx5: add mactable support")
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
index 1d34af78166a..1061874c9edc 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
@@ -162,13 +162,15 @@ static int sparx5_port_stop(struct net_device *ndev)
 	return 0;
 }
 
-static void sparx5_set_rx_mode(struct net_device *dev)
+static void sparx5_set_rx_mode(struct net_device *dev,
+			       struct netdev_hw_addr_list *uc,
+			       struct netdev_hw_addr_list *mc)
 {
 	struct sparx5_port *port = netdev_priv(dev);
 	struct sparx5 *sparx5 = port->sparx5;
 
 	if (!test_bit(port->portno, sparx5->bridge_mask))
-		__dev_mc_sync(dev, sparx5_mc_sync, sparx5_mc_unsync);
+		__hw_addr_sync_dev(mc, dev, sparx5_mc_sync, sparx5_mc_unsync);
 }
 
 static int sparx5_port_get_phys_port_name(struct net_device *dev,
@@ -249,7 +251,7 @@ static const struct net_device_ops sparx5_port_netdev_ops = {
 	.ndo_open               = sparx5_port_open,
 	.ndo_stop               = sparx5_port_stop,
 	.ndo_start_xmit         = sparx5_port_xmit_impl,
-	.ndo_set_rx_mode        = sparx5_set_rx_mode,
+	.ndo_set_rx_mode_async  = sparx5_set_rx_mode,
 	.ndo_get_phys_port_name = sparx5_port_get_phys_port_name,
 	.ndo_set_mac_address    = sparx5_set_mac_address,
 	.ndo_validate_addr      = eth_validate_addr,

-- 
2.34.1


