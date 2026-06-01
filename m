Return-Path: <netdev+bounces-293500-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFN4Ikv0HGrxUQkAu9opvQ
	(envelope-from <netdev+bounces-293500-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 04:54:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 16909618F0E
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 04:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5D34B3008269
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 02:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EF81FC0EA;
	Mon,  1 Jun 2026 02:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+2YG407"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A693923393F
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 02:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780282428; cv=none; b=r4k856bOmA/Khhhf2HhFwnaiu36nK6NbbWTJEU4z+IT92kBKo0h9cwonzk1vByBu0vy6VC1yQnaUXcIcDxJ8By1zOgfegU5knMcLJp1gIvDyUaA6/D+LFv3UnZo/dmWjwZmrds6VmmGL1oYcGbQvxfdIm0mpFzAJ8A4UD8ulidg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780282428; c=relaxed/simple;
	bh=wJON3ND0A32cOFWdeF/I1FnClnEqHzAji1C/rkxEVe0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W7eoeSE5HPvVTEzX+uex2ZmM+NXcigQhrH4kD2LppD42IdAIcPmwn56o5pZHt+6eR45WFGO8OVblMMpENofUCRRs43gONmBuy+Uuls4XY+jMDD81f245Cbg84wufggW/z2nsusTcDpTGYyp0VRgnO2bYpuAc4ewwNplFYz0WBpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+2YG407; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6604176b575so2435234d50.1
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 19:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780282426; x=1780887226; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4E1d30sjFNKIHkIaLJ5IKe2fw+jjLdbLjBOofT8Tt/0=;
        b=H+2YG407P0MMpsbUZ/FQuq9dNM9kIOSZ+MrIj7Omi4dwDNeZY+ZMRFsCdoZeQAoe1D
         khs/XK2hQ8r4GkcD5rqm7TDjujXpa9a8GlU7qaWcfiiEHfYPKFQcZnHBqZNdgCzcXRrC
         EkX8BaypEBP+/di5ubduWstEI6dcm0CO60DDmbVCjCvfcdY1yNNv+JqQpDODgWPOdYcF
         Fv6PUg1ig3V56wlhHjt6RmtMWqGsX2Vln47gbrp4PGBH5XQJ5njUf8qhyemYu8p8OQQi
         dPUbqB4emJuyMoQplvWs82LZEE75Nr/xqRkn2zpmDN6Cd821wwWBY1azSaqHiiKXT5yj
         2gzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780282426; x=1780887226;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4E1d30sjFNKIHkIaLJ5IKe2fw+jjLdbLjBOofT8Tt/0=;
        b=PgxIcR7GYpClg+8QeJF/hhrhcfVmJjWJ6qRfQUiuPEATGG+H/ttNQH3Cvh6EbEttxd
         7SOMR4FECBaWywchdJA9hN3nk0Y0skRvugasG7ekc9mknIgD7YhegAaL19GfXPAmE0TA
         wMGrPI3DKRc0IIImDVzcaU+JsQS4U647YmUew56Pt350FvwBUz8dqBUCl7Kvpr7qs5kS
         0ezfAEjuErUdQzTObwHdSbS/B0Sr0Fer5nibsqU+lxli3N1Vvlb2x6zbRGYQlCv1IpDQ
         qDvcmTl6ZV1plEHXSYgbYiA0V++gFiUAJRCWdL8wFjD4+XpajfO/MjZuFejueggubqpJ
         PdbA==
X-Gm-Message-State: AOJu0YxEjIg3CdZ6Jxo6UKDhOvHsqdWzwj1KJJL4rx2LEohdG36euq0v
	kXf7qPVYCG8IvV4RXq5EnO5erfGlwcC+qZfw3PEYGcG7weRwOgpbYJvY
X-Gm-Gg: Acq92OEN5muLzVLzft66cMihaJRTapcVv7sDl0p2GqFoag00jNOnWgfeSJeG9ih/a0d
	7ynOaUDES9iG6+D0WKMdWZD6EZ/ndJwHOaGixdcGJ6UCbDq6kQxGSst33ic+MMwyNirO7eT9gEn
	yhicmspD8bCyYxVk4TlSgxA5930Iit62fC9MnAsB78ZtOw4cd72skg7PZBl3lL/M5gw7bdpRFaI
	Wlw1nEnm8gZlrmq8hIMYCuyyaql3TtnZMOXeZwJhEA7igNDkorO4xGTECAeKRxX99EAIG93FY3D
	RdVbVwsb9mjhTeE3Lh547reWlMi+9OgZCiVCth3Jr8Q7/Vjn5oyj7JNIUqa18r/+LwSCMcA0oSR
	UEPMLEG4O/YYKJjLYg0QcHTWRd2zQ7D83BafKdzpqc3osr6Pkhgm9HAW3t/mlB0lIm4SDfXFBrC
	O7sPi4YW7vpV7AqRmSEMu6l7zC2we+vAgPgsmb9SPPB1qVjDPhZAdx45Jr62vH
X-Received: by 2002:a05:690e:1687:b0:660:446b:7aad with SMTP id 956f58d0204a3-6605f179d6fmr7206221d50.57.1780282426580;
        Sun, 31 May 2026 19:53:46 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6606977ab05sm2952518d50.9.2026.05.31.19.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 19:53:45 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sun, 31 May 2026 23:53:17 -0300
Subject: [net-next PATCH v11 2/9] net: dsa: realtek: rtl8365mb: reject
 unsupported topologies
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-realtek_forward-v11-2-50d60f5717e8@gmail.com>
References: <20260531-realtek_forward-v11-0-50d60f5717e8@gmail.com>
In-Reply-To: <20260531-realtek_forward-v11-0-50d60f5717e8@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mieczyslaw Nalewaj <namiltd@yahoo.com>, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293500-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,yahoo.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 16909618F0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Explicitly enforce the presence of a CPU port (-EINVAL) and reject DSA
cascade links (-EOPNOTSUPP) during setup to prevent silent failures.

These topologies were already non-functional. Without a CPU port, the
driver does not activate CPU tagging. Additionally, the switch hardware
was not designed to be cascaded, and DSA links never worked because
CPU tagging is not enabled for them.

Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/rtl8365mb.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index 2637884fe472..37e1d7654b1d 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -1991,6 +1991,20 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 	else if (ret)
 		dev_info(priv->dev, "no interrupt support\n");
 
+	for (i = 0; i < priv->num_ports; i++) {
+		/* Cascading (DSA links) is not supported yet.
+		 * Historically, the driver has always been broken
+		 * without a dedicated CPU port because CPU tagging
+		 * would be disabled, rendering the switch entirely
+		 * non-functional for DSA operations.
+		 */
+		if (dsa_is_dsa_port(ds, i)) {
+			dev_err(priv->dev, "Cascading (DSA link) not supported\n");
+			ret = -EOPNOTSUPP;
+			goto out_teardown_irq;
+		}
+	}
+
 	/* Configure CPU tagging */
 	dsa_switch_for_each_cpu_port(cpu_dp, ds) {
 		cpu->mask |= BIT(cpu_dp->index);
@@ -1999,6 +2013,13 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 			cpu->trap_port = cpu_dp->index;
 	}
 	cpu->enable = cpu->mask > 0;
+
+	if (!cpu->enable) {
+		dev_err(priv->dev, "no CPU port defined\n");
+		ret = -EINVAL;
+		goto out_teardown_irq;
+	}
+
 	ret = rtl8365mb_cpu_config(priv);
 	if (ret)
 		goto out_teardown_irq;

-- 
2.54.0


