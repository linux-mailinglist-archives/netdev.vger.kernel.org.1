Return-Path: <netdev+bounces-278936-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLa5Kmx54GkfhgAAu9opvQ
	(envelope-from <netdev+bounces-278936-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 07:53:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EE640A7C9
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 07:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCC8D315FEEF
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 05:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6B437C109;
	Thu, 16 Apr 2026 05:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="FrlfYbEJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C3B37B011;
	Thu, 16 Apr 2026 05:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776318511; cv=none; b=vDyb7JbcYW+3D5IcKMM7BDT4i4Gt6g0pgUc3EfNPJ4t0LPtKkobBfN6omkncFh1+SwLZX/MriIJeT4lS/U9QfC96SPCez585GnP2Um06IygL24hzBtDq3mZadf3AX7tHo+fzmjG7lp8iu7oTs7X2EYaB9JEYM7BXfTYWP5NTotM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776318511; c=relaxed/simple;
	bh=JduuRmjnQ2e4ZIusUDR/+qE0uE73yAgWetgwlpGCwBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XucL1CVFmMVggUQ0454k4H6H2sjf/w20g6MvdQJzc5bfZjxquPqdqL5lcRrcYMzaexjKuaazSBJSL+XEPhvPM+bj14niMVn3ZvKOnN/l0xsKREmbOeJSFcwk4tun97F1bj0bWi8kARXCT+slUndF0Wki0tLt7sh91xwdJdvP0YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=FrlfYbEJ; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 58506A385A;
	Thu, 16 Apr 2026 07:48:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1776318508; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=GL8ocY6ZzsUaFYQwSxltAT8UjlwwI/5h791H7au6scU=;
	b=FrlfYbEJjE81SAb1wxyBbFGr5ULp9qGYOfm34musx5LtmvDaU961S94Z7YUM3/Bd92DNX2
	5s8oKjLURon2GA8VeKaeq6Naf72SvTmGMRqUr610vNbnzJxjuul0D98FtOvwsv8g46wMU1
	OQjn1eH9BCip1fGEm6Zi1lX+1eZGEe7dXAZvMfPTc4m8nA7/4WVIPlW+L9lusBad7kyvU7
	G54ARMEMuT38d+jMZXRApquDXizJ+TWVDgUdr7artQ+zXaiWf19BA0VnSFTKfMzMKhQsEp
	yk2ened8Pmsagu48LYyu18piWjRC2b6zrTTyTPV5jQZ3zKm5QxpAEfnVhkU4qw==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Justin Chen <justin.chen@broadcom.com>,
	Simon Horman <horms@kernel.org>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Mohsin Bashir <hmohsin@meta.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v7 7/7] net: bcmgenet: reject MTU changes incompatible with XDP
Date: Thu, 16 Apr 2026 07:47:39 +0200
Message-ID: <20260416054743.1289191-8-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260416054743.1289191-1-nb@tipi-net.de>
References: <20260416054743.1289191-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[tipi-net.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	ASN_FAIL(0.00)[10.253.234.172.asn.rspamd.com:server fail];
	TAGGED_FROM(0.00)[bounces-278936-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,gmail.com,lunn.ch,google.com,redhat.com,tipi-net.de,meta.com,davemloft.net,iogearbox.net,fomichev.me,vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.984];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:email,tipi-net.de:dkim,tipi-net.de:mid,broadcom.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Queue-Id: 38EE640A7C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a minimal ndo_change_mtu that rejects MTU values too large for
single-page XDP buffers when an XDP program is attached. Without this,
users could change the MTU at runtime and break the XDP buffer layout.

When no XDP program is attached, any MTU change is accepted, matching
the existing behavior without ndo_change_mtu.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Mohsin Bashir <hmohsin@meta.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index e74494be7a23..e74cc055210c 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -4087,6 +4087,20 @@ static int bcmgenet_xdp_xmit(struct net_device *dev, int num_frames,
 	return sent;
 }
 
+static int bcmgenet_change_mtu(struct net_device *dev, int new_mtu)
+{
+	struct bcmgenet_priv *priv = netdev_priv(dev);
+
+	if (priv->xdp_prog && new_mtu > PAGE_SIZE - GENET_RX_HEADROOM -
+	    SKB_DATA_ALIGN(sizeof(struct skb_shared_info))) {
+		netdev_warn(dev, "MTU too large for single-page XDP buffer\n");
+		return -EINVAL;
+	}
+
+	WRITE_ONCE(dev->mtu, new_mtu);
+	return 0;
+}
+
 static const struct net_device_ops bcmgenet_netdev_ops = {
 	.ndo_open		= bcmgenet_open,
 	.ndo_stop		= bcmgenet_close,
@@ -4097,6 +4111,7 @@ static const struct net_device_ops bcmgenet_netdev_ops = {
 	.ndo_eth_ioctl		= phy_do_ioctl_running,
 	.ndo_set_features	= bcmgenet_set_features,
 	.ndo_get_stats64	= bcmgenet_get_stats64,
+	.ndo_change_mtu		= bcmgenet_change_mtu,
 	.ndo_change_carrier	= bcmgenet_change_carrier,
 	.ndo_bpf		= bcmgenet_xdp,
 	.ndo_xdp_xmit		= bcmgenet_xdp_xmit,
-- 
2.51.0


