Return-Path: <netdev+bounces-104530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB9F90D087
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 15:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E3F286810
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4FD17966D;
	Tue, 18 Jun 2024 12:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="BiNsRdUr"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC75D178CEC;
	Tue, 18 Jun 2024 12:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715539; cv=none; b=EcF+iN/RTR5jjz6pColK5oHjAp/pgMF2Ko6V0VeKs7RKexaEBmWGKcVFXTSAVCdkItHJaUtCw1/E8lmy4EpjsJRSWYGqCRDB3+zYQHD6G7Dboi+QI59j+4Q4F7VLWT7mFFlsbDDp3/7re6knwbS/aiobTJ1qW22IHvY4iPWCgeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715539; c=relaxed/simple;
	bh=hPD+8Xx85gcAS6/UvDfGA9czp7+E0QgLN2t1AcM/NiA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ezQW/HvvNRN/05cZvq4aVQZNmm1J20wY0jH4wSZJ4r4Q+6cPACRJ0gMUTJUDAzzA53Sh2xCh7lTnK2biPlu7zM+R8IokyV1VoC3ZJcisbBuxpd3W/l0axRUkjBBiNiFJjpGS97RTdjGRQcdDRoCo+XwjUCm33Ap+FVBg6L9/F6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=BiNsRdUr; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 6BA2A8819D;
	Tue, 18 Jun 2024 14:58:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718715530;
	bh=DQfD76xJQq5dfMp6UYwX+X8hAF7ZeXHxs58Z551u1Jg=;
	h=From:To:Cc:Subject:Date:From;
	b=BiNsRdUryqdv0yh7/TTBbnWZ+jpk9J30ePHowzuz5fG9qsCf9gnbcHQoDcyv33Ulx
	 JvNzOePtYVxJCWiqqGzS/+G2Y4Py4Fzmgd3zkA/yGn7Tr7pn2FFP4ophVGfgof7bGJ
	 1u0WZvIR8VOcJijbRYLstXEbY5MGgHRL4veWq05u1eeNh99BvWp2hPFoFMBO9oLL4h
	 87fs2nNMxI2bmssKdDroLUnOm3xWGioI7z1mDKeodzoPovNxR6beK5eJbWSJzLTALs
	 QSAumWTZ2WrSKCNaLEWE7z22naKy1pjuA3a+Q/mAXqdFFV0Y0yRKVM3XwUFoNrdq1+
	 U4E2YEg1v8p9A==
From: Lukasz Majewski <lukma@denx.de>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Simon Horman <horms@kernel.org>,
	Arvid Brodin <Arvid.Brodin@xdin.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Casper Andersson <casper.casan@gmail.com>,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>,
	Geliang Tang <tanggeliang@kylinos.cn>,
	Shuah Khan <shuah@kernel.org>,
	Shigeru Yoshida <syoshida@redhat.com>,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v1 net-next] net: hsr: cosmetic: Remove extra white space
Date: Tue, 18 Jun 2024 14:58:17 +0200
Message-Id: <20240618125817.1111070-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This change just removes extra (i.e. not needed) white space in
prp_drop_frame() function.

No functional changes.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 net/hsr/hsr_forward.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 960ef386bc3a..b38060246e62 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -421,9 +421,9 @@ static int hsr_xmit(struct sk_buff *skb, struct hsr_port *port,
 bool prp_drop_frame(struct hsr_frame_info *frame, struct hsr_port *port)
 {
 	return ((frame->port_rcv->type == HSR_PT_SLAVE_A &&
-		 port->type ==  HSR_PT_SLAVE_B) ||
+		 port->type == HSR_PT_SLAVE_B) ||
 		(frame->port_rcv->type == HSR_PT_SLAVE_B &&
-		 port->type ==  HSR_PT_SLAVE_A));
+		 port->type == HSR_PT_SLAVE_A));
 }
 
 bool hsr_drop_frame(struct hsr_frame_info *frame, struct hsr_port *port)
-- 
2.20.1


