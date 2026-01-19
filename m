Return-Path: <netdev+bounces-251143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2BBD3AC3A
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BD6403012A6C
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF5A23C39A;
	Mon, 19 Jan 2026 14:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPgyBTgR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357601FF1C7
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 14:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768833017; cv=none; b=TchoZDsNHcv9F08Gkp69anqRGx6TVK3AZ/No0eYBVfjF6f9Tm8MNtx6ltpvUvSg9LnOLv6/3lkZNa6HmFWzGJ2pWzQYWgPxPchj1m4xAU/M+ZC8vaPP5u3cUQ5Bz5dy6j3xHLf2BM5ULoLWB/AJ8Pt9t5LamR/YnqS4HvnXEcvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768833017; c=relaxed/simple;
	bh=nly2BsUTWXdKfhE/cjmvmuU8HIFEayixTBYvU1BVqzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B5XtKRHwBm4L54TSoATvCLDC+szd8tEXI/fpHM7zFPBFCPKRFMDs3ED/3lTJv8dd6WoPkmdNcK33z8z6domcWAitqe6BQGqouN5lBCW8ZR885iPDFu656/S7YrSCa3TZiSsZuOMmQ8tWnMWULB/HyUJ1beUtgMirQXMd33UZKVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPgyBTgR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191E3C116C6;
	Mon, 19 Jan 2026 14:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768833016;
	bh=nly2BsUTWXdKfhE/cjmvmuU8HIFEayixTBYvU1BVqzs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fPgyBTgR50fn6l3sax8WKhk3mpzy/DQ97v0s1I/daP+QebXa2RCOjvhk56T8oc7Cn
	 gn+EPmtRHvVH+hpxUsRXnsVogYGA+gA1rpbV4u+IXiRuia07ZXihSRR5FGdWTEFUL8
	 M7oCI4eFQugCus9e14IQF8eGoQLO+WPESXaQGdz1gLgJESO49cM8ZtTHZ3pE5sxCrd
	 83gbUsDKE35lPIckkTufyjKT1wX7U7b4VgnejrZ4kNByWMSiUSsOxlEhB4GYATH1rN
	 MAKntLJ8rk3LRHlPINZyDCjLTDLoqnlo4pkfYkSLkqd7qcrND6HPEEt98Jsqds5bap
	 hWctZbJSAQzwg==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 19 Jan 2026 15:30:07 +0100
Subject: [PATCH net-next v2 3/4] net: dsa: ks8995: Add stub bridge
 join/leave
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-ks8995-fixups-v2-3-98bd034a0d12@kernel.org>
References: <20260119-ks8995-fixups-v2-0-98bd034a0d12@kernel.org>
In-Reply-To: <20260119-ks8995-fixups-v2-0-98bd034a0d12@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Woojung Huh <woojung.huh@microchip.com>
Cc: UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3

Implementing ks8995_port_pre_bridge_flags() and
ks8995_port_bridge_flags() without port_bridge_join()
is a no-op.

This adds stubs for bridge join/leave callbacks following
the pattern of drivers/net/dsa/microchip/ksz_common.c:
as we have STP callbacks and these will be called right
after bridge join/leave these will take care of the
job of setting up the learning which is all we support.

Fixes: a7fe8b266f65 ("net: dsa: ks8995: Add basic switch set-up")
Reported-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/ks8995.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/dsa/ks8995.c b/drivers/net/dsa/ks8995.c
index 5ad62fa4e52c..060bc8303a14 100644
--- a/drivers/net/dsa/ks8995.c
+++ b/drivers/net/dsa/ks8995.c
@@ -461,6 +461,26 @@ static void ks8995_port_disable(struct dsa_switch *ds, int port)
 	dev_dbg(ks->dev, "disable port %d\n", port);
 }
 
+static int ks8995_port_bridge_join(struct dsa_switch *ds, int port,
+				   struct dsa_bridge bridge,
+				   bool *tx_fwd_offload,
+				   struct netlink_ext_ack *extack)
+{
+	/* port_stp_state_set() will be called after to put the port in
+	 * appropriate state so there is no need to do anything.
+	 */
+
+	return 0;
+}
+
+static void ks8995_port_bridge_leave(struct dsa_switch *ds, int port,
+				     struct dsa_bridge bridge)
+{
+	/* port_stp_state_set() will be called after to put the port in
+	 * forwarding state so there is no need to do anything.
+	 */
+}
+
 static int ks8995_port_pre_bridge_flags(struct dsa_switch *ds, int port,
 					struct switchdev_brport_flags flags,
 					struct netlink_ext_ack *extack)
@@ -635,6 +655,8 @@ static int ks8995_get_max_mtu(struct dsa_switch *ds, int port)
 static const struct dsa_switch_ops ks8995_ds_ops = {
 	.get_tag_protocol = ks8995_get_tag_protocol,
 	.setup = ks8995_setup,
+	.port_bridge_join = ks8995_port_bridge_join,
+	.port_bridge_leave = ks8995_port_bridge_leave,
 	.port_pre_bridge_flags = ks8995_port_pre_bridge_flags,
 	.port_bridge_flags = ks8995_port_bridge_flags,
 	.port_enable = ks8995_port_enable,

-- 
2.52.0


