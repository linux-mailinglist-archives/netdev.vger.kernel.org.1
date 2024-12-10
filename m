Return-Path: <netdev+bounces-150691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDF89EB2FA
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 15:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6CED283265
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B0A1B2EFB;
	Tue, 10 Dec 2024 14:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YSAfXk5q"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BF11AB523
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 14:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733840316; cv=none; b=S01e3B0noDJR3J3QaIK8gTfYh7aladEPYwq6yF4Us9bVfdiK5gp0ETBOKI6eUr1ydb77YOi+9sDdEIv+UCdAW3hP29/+/POZ+Hl5apLocwTn5cTsaX/cvPRrDTJggislUwzUykuEiiSgyf0O9GMW8xlvBm4yFb6EeRh9ARIX/vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733840316; c=relaxed/simple;
	bh=UNSKRjfjfRvmg/aq/j8WbqhkI+NkL9e4sjQzMjd8/qI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=oM3JeRPA3iIdciPRqWsPLQVuECEQA/fQQePteOxUwLvLPVO/h15FUKgOHySS1K10baFr/l3OVFdm5E05jYMhCxDUYWXBackm6Dz4VL72asIMIwS6ijaLc6Ik/VNjFCm0s3gdno+GWyCxcrvok99bnBXaSFxeeoHjaUMKa+2wyqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=YSAfXk5q; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=w4Gug0yZHJ7/4tL9/AB4gLC4PdFqXx2MGKoxDny63/Y=; b=YSAfXk5qKDIfwmAXk12sv+Ppvr
	5rtupGvOTYtWzTs9JRNmrA1CoMOMsSYB621by2WX3SxJqZAhycCbRFa9kAyePPdZrKcbwCv1FU1l5
	zKPPc45mA9KghxXGQwNoAwAX+KyLJHfl6700rEG7uNuyI3wsGA0mxzsEO+sxpusgFrmpuAQV+3/Qo
	FaDRL0QKWpsWGjnXDRSeiFUHv69srKutm2gWbPXCaAxSc5s++dJ1ZYBoTbpcpl/6A/qkOwGxzih7b
	D1e+Ze8Jex/RQsZPA1gxd9kElFCSyp8PMFBKjIygUgZYTnG6GIwrsaxHVIMTJhNffk64/73QLxR6v
	HogjcfUQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:39220 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tL14B-0002T9-0y;
	Tue, 10 Dec 2024 14:18:23 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tL149-006cZJ-JJ; Tue, 10 Dec 2024 14:18:21 +0000
In-Reply-To: <Z1hNkEb13FMuDQiY@shell.armlinux.org.uk>
References: <Z1hNkEb13FMuDQiY@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Ar__n__ __NAL" <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Simon Horman <horms@kernel.org>,
	UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>
Subject: [PATCH net-next 3/9] net: dsa: provide implementation of
 .support_eee()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tL149-006cZJ-JJ@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 10 Dec 2024 14:18:21 +0000

Provide a trivial implementation for the .support_eee() method which
switch drivers can use to simply indicate that they support EEE on
all their user ports.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 include/net/dsa.h |  1 +
 net/dsa/port.c    | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index aaa75bbaa0ea..4aeedb296d67 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -1384,5 +1384,6 @@ static inline bool dsa_user_dev_check(const struct net_device *dev)
 
 netdev_tx_t dsa_enqueue_skb(struct sk_buff *skb, struct net_device *dev);
 void dsa_port_phylink_mac_change(struct dsa_switch *ds, int port, bool up);
+bool dsa_supports_eee(struct dsa_switch *ds, int port);
 
 #endif
diff --git a/net/dsa/port.c b/net/dsa/port.c
index ee0aaec4c8e0..5c9d1798e830 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -1575,6 +1575,22 @@ void dsa_port_set_tag_protocol(struct dsa_port *cpu_dp,
 	cpu_dp->tag_ops = tag_ops;
 }
 
+/* dsa_supports_eee - indicate that EEE is supported
+ * @ds: pointer to &struct dsa_switch
+ * @port: port index
+ *
+ * A default implementation for the .support_eee() DSA operations member,
+ * which drivers can use to indicate that they support EEE on all of their
+ * user ports.
+ *
+ * Returns: true
+ */
+bool dsa_supports_eee(struct dsa_switch *ds, int port)
+{
+	return true;
+}
+EXPORT_SYMBOL_GPL(dsa_supports_eee);
+
 static void dsa_port_phylink_mac_config(struct phylink_config *config,
 					unsigned int mode,
 					const struct phylink_link_state *state)
-- 
2.30.2


