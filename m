Return-Path: <netdev+bounces-74979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2774F867A20
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 16:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6D0128F1B7
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 15:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D40605CB;
	Mon, 26 Feb 2024 15:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="ZiEnNBAm"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B247E794
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 15:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708961104; cv=none; b=nIrtvLH6UeOYgweKzkCTx78H6CgExVoqmhfedQgrp6b4sAmVu8eG7ABkOS9IzFXJe04DYiwk32gC1GAnJz8S2bfr0yEEUcV9dXnc1ZPbm/ekW1SeWmX7/BgCDK9qtFilvNaBSFNNYgivrVbiUt4o+TMNGhbI5qBsLUskng+67XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708961104; c=relaxed/simple;
	bh=ilzirgl7PSLZ7JVNoUjXSU8qiT7GXDLCn46h1Pg4PU8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=De0Q0q/cc8kT2yZgRvivMTNYAQtXige2CJFtYy8wuHzwM1onk/gVZ9u50e+nkEeR6tIx3Hp24/OAWwDVpaTiY++vHJa9VV+YfOVYwfaFUNpsX7iibjG6q5RSz6UD57gpweHgUIZO7rAVIySfCIy0W5zBlFZv/2MidHKwAnWW3PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=ZiEnNBAm; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id B9CA187EFE;
	Mon, 26 Feb 2024 16:25:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708961101;
	bh=tGJTuxjcA1eBfu7kPjqMfytqq8b2iDxIn1jbssfD890=;
	h=From:To:Cc:Subject:Date:From;
	b=ZiEnNBAmajYgnhGz2fBoG4eXc8A8UFMdomMPH6FMRK71ZnygMiFgNOz11AEThrAW1
	 to7GRZn9/4SinTQwhPuetwkF35i3M5NLBTF6Pk4OBqG3w8dTpU0qkm8ubkP7PVpeJg
	 OLtjbXg4ksQ88tIOF+8o99iFJYdI7Zfi9Ao/vn6u8QcViEgMDkjfbkUG28GR8V7swg
	 bINOmcxXkC0Kw3Ja2FDJNuLeYlz7NG+kwy4hfNWo/UAMA56r1pKJEzh0a7nRLoXlJ6
	 NfRRkpK64E5nO6IZQVGWIzor9prlLQZKSbUfWMU4b4JMFhk+8OZOQTkVSJsBi5BEOh
	 SfNZzz5bI+muw==
From: Lukasz Majewski <lukma@denx.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH] net: hsr: Use correct offset for HSR TLV values in supervisory HSR frames
Date: Mon, 26 Feb 2024 16:24:47 +0100
Message-Id: <20240226152447.3439219-1-lukma@denx.de>
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

Current HSR implementation uses following supervisory frame (even for
HSRv1 the HSR tag is not is not present):

00000000: 01 15 4e 00 01 2d XX YY ZZ 94 77 10 88 fb 00 01
00000010: 7e 1c 17 06 XX YY ZZ 94 77 10 1e 06 XX YY ZZ 94
00000020: 77 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000030: 00 00 00 00 00 00 00 00 00 00 00 00

The current code adds extra two bytes (i.e. sizeof(struct hsr_sup_tlv))
when offset for skb_pull() is calculated.
This is wrong, as both 'struct hsrv1_ethhdr_sp' and 'hsrv0_ethhdr_sp'
already have 'struct hsr_sup_tag' defined in them, so there is no need
for adding extra two bytes.

This code was working correctly as with no RedBox support, the check for
HSR_TLV_EOT (0x00) was off by two bytes, which were corresponding to
zeroed padded bytes for minimal packet size.

Fixes: f43200a2c98b ("net: hsr: Provide RedBox support")

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 net/hsr/hsr_forward.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 2afe28712a7a..5d68cb181695 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -83,7 +83,7 @@ static bool is_supervision_frame(struct hsr_priv *hsr, struct sk_buff *skb)
 		return false;
 
 	/* Get next tlv */
-	total_length += sizeof(struct hsr_sup_tlv) + hsr_sup_tag->tlv.HSR_TLV_length;
+	total_length += hsr_sup_tag->tlv.HSR_TLV_length;
 	if (!pskb_may_pull(skb, total_length))
 		return false;
 	skb_pull(skb, total_length);
-- 
2.20.1


