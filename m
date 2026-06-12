Return-Path: <netdev+bounces-298520-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qCfeAwbFK2rUEgQAu9opvQ
	(envelope-from <netdev+bounces-298520-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:36:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A1C677D9E
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:36:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Aol55Kh/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298520-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298520-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFBFF3046E8C
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 08:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5848336A009;
	Fri, 12 Jun 2026 08:35:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFA63624C2;
	Fri, 12 Jun 2026 08:35:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781253344; cv=none; b=QH9nINiCEzEN64YP37hcSBVZGrz2UKDVuawipj6ih6PqIQOYx9zGA9OoNtPr47EjJ9PVV4q6+MmHcxWGik7mgbc0i3oM5Zv/EW+7R1b2h9qgGRqZ1QPpYmpBUB4/eTAIw0c+wZ5T1HCjRQO9dmZ7drWrfxaxJjFTSkmQKHfNpZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781253344; c=relaxed/simple;
	bh=LitPuHr6nd9t5eP+ZBjTvQ3/VVfDLwUrViqLD0nD/ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XdQmoZGSnerezg8gkLy00CUza4GFNoe4F1sag2IHOigMVPtVYruvg3g9Cwe7G4QMH3eZxi55rqkEDDVLcBS66dYxk+RBWm3egfmOuu4bDe7j+nD/7bAu3xf3qLgxvvTkegMZKk+K5FHYpGvwR5HCRgJVMk4un0H8j74pGdiXW4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aol55Kh/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6351F00A3A;
	Fri, 12 Jun 2026 08:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781253342;
	bh=D11eKalF3HDUUj65wSQBN1ECBMeOIdgbH/AiYJYL5kQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Aol55Kh/N1w6SWoT2fcWD/vG9nSjGPP65Xd8KMDivrLpHL2Nd9EJksoC3Z9ZpQLSb
	 fcNjyfOaGLZbsDVxLYBMemfiiXgmNURVlhg2KCfJdChtIZRrRJmeJnXpExp4hLpqmT
	 FgTvzkrdlmLn8OtQQ56vqTr2FQCpR2qWTG6TENsdncbx6ZbKriyV7/Nze62cKhwWER
	 ijehMVtcH0jxmV8aTAuenSieAILyrx5lpuJ6f/mYTWVGsfv8JEX0Rxw6ISiiur815i
	 H3qcCoFKXc/OS6QZ50Ju84rwkBFIdyAt3K1Axl3uIOIgZhJSg7rgaFuo/wI/6XdhCS
	 thNs0g7PiFs4g==
From: hawk@kernel.org
To: netdev@vger.kernel.org
Cc: kernel-team@cloudflare.com,
	simon.schippers@tu-dortmund.de,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	=?UTF-8?q?Jonas=20K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Christian Brauner <brauner@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Yajun Deng <yajun.deng@linux.dev>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v7 1/5] net: add dev->bql flag to allow BQL sysfs for IFF_NO_QUEUE devices
Date: Fri, 12 Jun 2026 10:35:24 +0200
Message-ID: <20260612083530.1650245-2-hawk@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612083530.1650245-1-hawk@kernel.org>
References: <20260612083530.1650245-1-hawk@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-298520-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kernel-team@cloudflare.com,m:simon.schippers@tu-dortmund.de,m:hawk@kernel.org,m:j.koeppeler@tu-berlin.de,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:kuniyu@google.com,m:sdf@fomichev.me,m:brauner@kernel.org,m:frederic@kernel.org,m:yajun.deng@linux.dev,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 57A1C677D9E

From: Jesper Dangaard Brouer <hawk@kernel.org>

Virtual devices with IFF_NO_QUEUE or lltx are excluded from BQL sysfs
by netdev_uses_bql(), since they traditionally lack real hardware
queues. However, some virtual devices like veth implement a real
ptr_ring FIFO with NAPI processing and benefit from BQL to limit
in-flight bytes and reduce latency.

Add a per-device 'bql' bitfield boolean in the priv_flags_slow section
of struct net_device. When set, it overrides the IFF_NO_QUEUE/lltx
exclusion and exposes BQL sysfs entries (/sys/class/net/<dev>/queues/
tx-<n>/byte_queue_limits/). The flag is still gated on CONFIG_BQL.

This allows drivers that use BQL despite being IFF_NO_QUEUE to opt in
to sysfs visibility for monitoring and debugging.

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
Tested-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
---
 Documentation/networking/net_cachelines/net_device.rst | 1 +
 include/linux/netdevice.h                              | 2 ++
 net/core/net-sysfs.c                                   | 8 +++++++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index eb2e6851c6f6..a65d48b6ecc1 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -169,6 +169,7 @@ unsigned_long:1                     see_all_hwtstamp_requests
 unsigned_long:1                     change_proto_down
 unsigned_long:1                     netns_immutable
 unsigned_long:1                     fcoe_mtu
+unsigned_long:1                     bql                                                                 netdev_uses_bql(net-sysfs.c)
 struct list_head                    net_notifier_list
 struct macsec_ops*                  macsec_ops
 struct udp_tunnel_nic_info*         udp_tunnel_nic_info
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 7f4f0837c09f..f699fded20b4 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2079,6 +2079,7 @@ enum netdev_reg_state {
  *	@change_proto_down: device supports setting carrier via IFLA_PROTO_DOWN
  *	@netns_immutable: interface can't change network namespaces
  *	@fcoe_mtu:	device supports maximum FCoE MTU, 2158 bytes
+ *	@bql:		device uses BQL (DQL sysfs) despite having IFF_NO_QUEUE
  *
  *	@net_notifier_list:	List of per-net netdev notifier block
  *				that follow this device when it is moved
@@ -2495,6 +2496,7 @@ struct net_device {
 	unsigned long		change_proto_down:1;
 	unsigned long		netns_immutable:1;
 	unsigned long		fcoe_mtu:1;
+	unsigned long		bql:1;
 
 	struct list_head	net_notifier_list;
 
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 0e71c9ed41e8..3cb470b0f17d 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1939,10 +1939,16 @@ static const struct kobj_type netdev_queue_ktype = {
 
 static bool netdev_uses_bql(const struct net_device *dev)
 {
+	if (!IS_ENABLED(CONFIG_BQL))
+		return false;
+
+	if (dev->bql)
+		return true;
+
 	if (dev->lltx || (dev->priv_flags & IFF_NO_QUEUE))
 		return false;
 
-	return IS_ENABLED(CONFIG_BQL);
+	return true;
 }
 
 static int netdev_queue_add_kobject(struct net_device *dev, int index)
-- 
2.43.0


