Return-Path: <netdev+bounces-177822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 364E9A71E84
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 19:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BE76175EED
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 18:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A7124C07F;
	Wed, 26 Mar 2025 18:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="fQX9At8r"
X-Original-To: netdev@vger.kernel.org
Received: from ksmg01.maxima.ru (ksmg01.maxima.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B784019CD19;
	Wed, 26 Mar 2025 18:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743014128; cv=none; b=BSebRK/MiL3thA0iQOPE3pxNVf2907BqKmU5uBYzOISHGhFUvTqBe5btwmjbm2oAfd0f5fUkSXKbzpz91VaBnxslzamv8hsp5ySYzsqkwvq/bm9pikzQKhLKODtwnI3gzzdcgvPhL2+//CpWPreG+Qn0xzigBMu6AKaUObAE0uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743014128; c=relaxed/simple;
	bh=2lgBBLJUUxgEd4UPG1SLJAQoj1g2+UrjIKRChLdrBmg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qWh0ZN9zJsgtkMA2ZK/Xi/BMbhoEbQs/Ft3IVTp+VZ2ANmESE/3t/EqVzBoKyAkl4eqAINURz3uNoqmgAXOvJOitSs5IeIVC2K3amLxgypRWYUIYHW3ywA7ccaRBgB9DSgzsi8fyc5UgHrgy067T3OhY0tDBowbjMnRtQsGsth8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=fQX9At8r; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id 5FC49C001C;
	Wed, 26 Mar 2025 21:35:23 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru 5FC49C001C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1743014123; bh=QwzNWD0m4wd3ds9iEF+6Fzl1TeTeKGkwr+542XGr2+Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=fQX9At8rdW9CrByFE9cv8yWphGwOlFGLDzLFaq3v0/tPXmYalLd6nhVKMMzH6WFM8
	 X1xlZ+4AwWB8Yvi/qhMKyal5AMI2AB4Z/FqBv6BtsLeY+M01HUs4VcT0hNxyoDYYVC
	 sJS2baPox7fc2/3cOQse2iGPjwUdlulMnGn6tMAsc7Kj1yxDo4hvyAQnZNRYz4dAW/
	 Q2x1PvSGc+mFbH/PNBNLiSW/+/6PgdWNpExRXJo9RCZsaZA/QpQrqpSdELnDQ96wuS
	 RTxp5irPtC4zYSWFTxO9FbL76w2rUuDpviED0bytBh8apNsShg+fiH7I/FyUyxa5J3
	 CuhqMHH8+Xedg==
Received: from ksmg01.maxima.ru (autodiscover.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Wed, 26 Mar 2025 21:35:23 +0300 (MSK)
Received: from localhost.maximatelecom.ru (5.1.51.21) by mmail-p-exch01.mt.ru
 (81.200.124.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1544.4; Wed, 26 Mar
 2025 21:35:20 +0300
From: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
	<UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH v2] net: dsa: felix: check felix_cpu_port_for_conduit() for failure
Date: Wed, 26 Mar 2025 23:34:57 +0500
Message-ID: <20250326183504.16724-1-v.shevtsov@mt-integration.ru>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mt-exch-01.mt.ru (91.220.120.210) To mmail-p-exch01.mt.ru
 (81.200.124.61)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: v.shevtsov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;81.200.124.61:7.1.2;mt-integration.ru:7.1.1;ksmg01.maxima.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 192129 [Mar 26 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/03/26 10:13:00 #27825781
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

felix_cpu_port_for_conduit() can return a negative value in case of failure
and then it will be used as a port index causing buffer underflow. This can
happen if a bonding interface in 802.1Q mode has no ports. This is unlikely
to happen because the underlying driver handles IFF_TEAM, IFF_MASTER,
IFF_BONDING bits and ports populating correctly, it is still better to
check this for correctness if somehow it fails.

Check if cpu_port is non-negative before using it as an index.
Errors from change_conduit() are already handled and no additional changes
are required.

Found by Linux Verification Center (linuxtesting.org) with Svace.

Signed-off-by: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>
---
v2: return the real cpu value instead of -EINVAL as per Andrew Lunn observation.

 drivers/net/dsa/ocelot/felix.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index 0a4e682a55ef..1495f8e21f90 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -523,6 +523,7 @@ static int felix_tag_npi_change_conduit(struct dsa_switch *ds, int port,
 {
 	struct dsa_port *dp = dsa_to_port(ds, port), *other_dp;
 	struct ocelot *ocelot = ds->priv;
+	int cpu;
 
 	if (netif_is_lag_master(conduit)) {
 		NL_SET_ERR_MSG_MOD(extack,
@@ -546,7 +547,12 @@ static int felix_tag_npi_change_conduit(struct dsa_switch *ds, int port,
 	}
 
 	felix_npi_port_deinit(ocelot, ocelot->npi);
-	felix_npi_port_init(ocelot, felix_cpu_port_for_conduit(ds, conduit));
+	cpu = felix_cpu_port_for_conduit(ds, conduit);
+	if (cpu < 0) {
+		dev_err(ds->dev, "Cpu port for conduit not found\n");
+		return cpu;
+	}
+	felix_npi_port_init(ocelot, cpu);
 
 	return 0;
 }
@@ -658,6 +664,11 @@ static int felix_tag_8021q_change_conduit(struct dsa_switch *ds, int port,
 	int cpu = felix_cpu_port_for_conduit(ds, conduit);
 	struct ocelot *ocelot = ds->priv;
 
+	if (cpu < 0) {
+		dev_err(ds->dev, "Cpu port for conduit not found\n");
+		return cpu;
+	}
+
 	ocelot_port_unassign_dsa_8021q_cpu(ocelot, port);
 	ocelot_port_assign_dsa_8021q_cpu(ocelot, port, cpu);
 
-- 
2.48.1


