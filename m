Return-Path: <netdev+bounces-302343-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +xUmFlcJQGptbQkAu9opvQ
	(envelope-from <netdev+bounces-302343-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 19:33:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C671E6D2681
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 19:33:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ik6+XT+5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302343-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302343-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63FBA300BC8F
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 17:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830D133D503;
	Sat, 27 Jun 2026 17:32:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D8F282F3C
	for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 17:32:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782581569; cv=none; b=T3qGnTRcm3HYpTgw+lULjNkRwSGlBGlV2fU6QO6iKU3c4VzdAvDcTuXfyWWEgpZybW7xz3nUQzw3hl8ys1kqMEbTjQoMigYHIF+/DKg7yUTEaJQSveRfZOD+nUe1pYXOQ8NsaZ0ApXH+rp+y03xKh2iFZnHYg5++sEoYjdRt3go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782581569; c=relaxed/simple;
	bh=3ZeA/JwqkGnLuKY6VbEnYkOqELtIspGNKjSjuhvOjM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pWq2EMdhWZ9HT31TUZ2QFbILUsfNBTTUc9mr+xXpx11pWG2PnRp/RfH3XIzkA53sn3F0AHpnBJ173fXP97v1/qWhvucD0h98LcZgVbVvAgsaag3jWkmvHMDvUqMFID8B9p627m7aIlxHqO6Ak0Wo0EKREhy+rNxtYW3+/wbQvMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ik6+XT+5; arc=none smtp.client-ip=209.85.128.46
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4926046fbc5so22607635e9.0
        for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 10:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782581566; x=1783186366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihXC91kXXIkZLdL67dRJWock4PheYhmjDZA0RD2CU3M=;
        b=ik6+XT+5Tu39N1Y7IsAoJ/+G1TVVznHcxDRhPQ4CupBLxmgz+7KdX+IBZrAH6JrV+/
         J3mDd0uqwbrIWEzTKybaohdhEfAwhpK86WfCI8SQ3xxhYw00hTXSTc510dED6O1b/CY8
         dVoOtQ3g2wL60I63SisE32Eif0+JDSA7X7kscSSc9I6lREeAyptLYsi2dzx/d7eRBiqN
         0TpATlQSonJ56gJWH4KqGIkhAWGlcQdkyKQBpIKzAQpgFF7SaXwEuub+zsa+O91oqKb3
         luQRTPAmkGuwN5ZXN6/hANguxk9plUDiRBmP4+eGbBYlPySy0sp+MoSWX4qQBHmBvh92
         DXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782581566; x=1783186366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ihXC91kXXIkZLdL67dRJWock4PheYhmjDZA0RD2CU3M=;
        b=IVLwG1n0+C8tzzdmhq4mlppDs8HGr8m8Q3ZfTbygUbXY+DpTHScSlRJefTm5WPd6AM
         h8uqd1xS/KyI3/+SDqR5RDYvvNbx8MKSEcXcHz1QysTZi4hJbC82N7n4UWAnIp4iV/mo
         BsQIPgLoPAN/y4aHNV1gwdt5we2TY9406EBGL1OwbaXz5urefQvwR9RxE8yNaUzJH0Uj
         aCd32GK9vENEmLkej9zdfyfpj5aXl77edh0noB3/EjfFOLUS4hU+HA4+fO/zLYowziCo
         Wecvqp7wyInByFvED8aTH5piqAZA7asuJjEzCRgQ7ZSgWDK1yDv2mLSaUC2zbgF3I5yB
         9bZQ==
X-Forwarded-Encrypted: i=1; AFNElJ+cL2HHCDmOlnjvxFPdKhBEjaOBPaJ+3sK+wuzR5wo04JV/kHeBXBnzi807dxiklI3ddqaVU4w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/GzxLdSvaSOWtOcIkVRUQShs+Tgc/VexyAjbAvXjT+R5KgOER
	XROIqW+2TGqaj+tDgOgcW7dsxnuhRMtE8542FHv+C9rf6IxLGDfQvebU
X-Gm-Gg: AfdE7cmEXe5P1aOWI5oVbOrpTHAm8pUHnz4L5JqPtAPjmCpnfNSYRamqMuwP+QtSefU
	yvuV5Yeo9yO850e7mwzgdyJ70kK2Rjs9UyIwBIomNn9tcwmOCikyj62sXtvwAtanLVYJBckJUgi
	woYnHxK3MCuzVh0hMq1txLd91cwRtZHykQC33i7rEZnZnO0M1XMjviSCIMCZ1Boch0Id/tvOsgY
	8eq6cLhwUh5dvHXDub1GEJW21b6ipU9XW3hitfnXZn5x2L+TD32G72TecdphRAjbkZTeR2z/Vom
	XzBcBnXbIh+y0/MPU+t/hIQ5ceU2wQR5P2VS0sRxT0hn5A9OU88pVKYjCl9BCVlDUGZlh6q2jJ6
	vNKnMkI/nPNP6S5Sw3+t6WeAnieymeqgd644DqIOAqQD+hnzYj9zAR/nBBxqyZ86t4w/QdoNfh6
	YDdAc9pWZ5G0kj5tBFfmtcN02ijdkLT/+XpymLIwnyn1dEX/FxuKoOugGXF6ziQvErUywlZ2h9k
	CmvSKE=
X-Received: by 2002:a05:600c:4e0e:b0:48f:e230:29f5 with SMTP id 5b1f17b1804b1-49266424176mr167003885e9.16.1782581566356;
        Sat, 27 Jun 2026 10:32:46 -0700 (PDT)
Received: from localhost.localdomain (ip-89-176-136-191.bb.vodafone.cz. [89.176.136.191])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4932f100e4asm64505955e9.1.2026.06.27.10.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 10:32:45 -0700 (PDT)
From: Petr Wozniak <petr.wozniak@gmail.com>
To: linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com
Cc: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	maxime.chevallier@bootlin.com,
	bjorn@mork.no,
	olek2@wp.pl,
	kabel@kernel.org,
	Petr Wozniak <petr.wozniak@gmail.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>
Subject: [PATCH net v5 1/2] net: phy: sfp: free mii_bus in sfp_i2c_mdiobus_destroy
Date: Sat, 27 Jun 2026 19:32:41 +0200
Message-ID: <312bde8176fc429aa89524e3be250137f034ba84.1782581445.git.petr.wozniak@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1782581445.git.petr.wozniak@gmail.com>
References: <cover.1782581445.git.petr.wozniak@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-302343-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux@armlinux.org.uk,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-phy@lists.infradead.org,m:maxime.chevallier@bootlin.com,m:bjorn@mork.no,m:olek2@wp.pl,m:kabel@kernel.org,m:petr.wozniak@gmail.com,m:larysa.zaremba@intel.com,m:petrwozniak@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[armlinux.org.uk,lunn.ch,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[petrwozniak@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org,lists.infradead.org,bootlin.com,mork.no,wp.pl,gmail.com,intel.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrwozniak@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C671E6D2681

sfp_i2c_mdiobus_create() allocates the I2C MDIO bus with mdio_i2c_alloc(),
a plain (non-devm) allocation, and registers it. sfp_i2c_mdiobus_destroy()
only unregisters the bus and clears sfp->i2c_mii without calling
mdiobus_free(). As the only reference to the bus is then cleared, the
struct mii_bus is leaked.

This is hit whenever a copper/RollBall SFP module that instantiated an MDIO
bus is removed: sfp_sm_main() takes the global teardown path and calls
sfp_i2c_mdiobus_destroy(). sfp_cleanup(), on driver unbind, frees
sfp->i2c_mii directly, which is why the leak only triggered on module
hot-removal and not on unbind.

Free the bus in sfp_i2c_mdiobus_destroy() to match the allocation done in
sfp_i2c_mdiobus_create().

Fixes: e85b1347ace6 ("net: sfp: create/destroy I2C mdiobus before PHY probe/after PHY release")
Signed-off-by: Petr Wozniak <petr.wozniak@gmail.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/phy/sfp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 03bfd8640db9..c4d274ab651e 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -963,6 +963,7 @@ static int sfp_i2c_mdiobus_create(struct sfp *sfp)
 static void sfp_i2c_mdiobus_destroy(struct sfp *sfp)
 {
 	mdiobus_unregister(sfp->i2c_mii);
+	mdiobus_free(sfp->i2c_mii);
 	sfp->i2c_mii = NULL;
 }
 
-- 
2.51.0


