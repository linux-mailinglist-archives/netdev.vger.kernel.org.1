Return-Path: <netdev+bounces-291942-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QA21DD8WFmrOhQcAu9opvQ
	(envelope-from <netdev+bounces-291942-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 23:53:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AC15DCED4
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 23:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 676153044897
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 21:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B693CAE80;
	Tue, 26 May 2026 21:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KewyH6kj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3714F3C3455;
	Tue, 26 May 2026 21:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779832340; cv=none; b=sp1OPxesGCh2wyELCjVg0NvcRzlbZF4+bZ8v8D6XSnqJLSVEMWSIr6IcFiIAEveT7NzX+sutut7g2hoFFNyD1HqVO6ZdpgNg8U9uq8vZYWHnc2VaOnIIGWVpt/eMrFOZxZapWS6MkGjIunKmzno9CUCur9a8dESAtJTPGukt/as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779832340; c=relaxed/simple;
	bh=VXJFwd7+XZM7tBzGTekSDUJDrHYV8J+lvqpkIxEouJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RBSQs8jlAFT88HiDcegLaKv9jOeZjAiyIs527XCDf750pDaoVnKGF73tbFjfPyh/+yvoOb4mX/PRKroMnZ91+VH8SWtPDwqjDUrFBM8LmSlsKhQ/h1v/maFfp1HUPkfW4cqIwF2sIPTAl4VAI9F5ruM7c/esLh7LymXZ9o7bqd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KewyH6kj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EDBF7C32786;
	Tue, 26 May 2026 21:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779832340;
	bh=VXJFwd7+XZM7tBzGTekSDUJDrHYV8J+lvqpkIxEouJE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KewyH6kjdZr6R6iIHvx5vqYMF8l3AXCTwNqZoLWb/LEte7ZpNZZ+hCD2R9A2Iiylo
	 KJO6Z+h6gMA/rshXzO1LRbZDgauFiO4LbwXqeAEEgpZhLhCNMJwuGw6HUH0gk+OBTq
	 CxopedjURp+feaX/GBB9GMbCW1QoqADGUhABeWgJ6xHSZgrd7u7b8h4QCWlh8bKg5r
	 iefe4a8LDsXquepBadEfXSTx4mgg6ejugXirZEjiZ+u1PCwZAh1cZbKtbrjEnR5r3e
	 RSB8cRz7gPDSo2UGewj050SJ1/31vYCSLeffFnFC7stEX0AFX+50E24rXG7eKTkKbj
	 Fm8oa94z9FL8g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DA1CD5BD2;
	Tue, 26 May 2026 21:52:19 +0000 (UTC)
From: Ciprian Regus via B4 Relay <devnull+ciprian.regus.analog.com@kernel.org>
Date: Wed, 27 May 2026 00:51:51 +0300
Subject: [PATCH net-next v2 06/10] net: ethernet: oa_tc6: Add MMS register
 formatting macro
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-adin1140-driver-v2-6-37e5c8d4e0a0@analog.com>
References: <20260527-adin1140-driver-v2-0-37e5c8d4e0a0@analog.com>
In-Reply-To: <20260527-adin1140-driver-v2-0-37e5c8d4e0a0@analog.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
 Ciprian Regus <ciprian.regus@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779832338; l=1763;
 i=ciprian.regus@analog.com; s=20260330; h=from:subject:message-id;
 bh=5HSxO/CCFrO2eIoVbKXw+TUIV7w+rmcLQuB9FhaUalo=;
 b=gAhgj0HuuVyFkkyVsoXiYsNNmhf059JmCkplHxS9/qQNqowACEYivJblAY0FDgN/MPrcOhAZ9
 Tbf0jXL4+GdCa1hPzqVzKEHCOZc5n1eI3gfDMULJqSTAeuYr3FhO9pw
X-Developer-Key: i=ciprian.regus@analog.com; a=ed25519;
 pk=8WoNhI0kQcQUl8YqJO5ZevROYk9HP8lOIeIgIYgjfbc=
X-Endpoint-Received: by B4 Relay for ciprian.regus@analog.com/20260330 with
 auth_id=703
X-Original-From: Ciprian Regus <ciprian.regus@analog.com>
Reply-To: ciprian.regus@analog.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291942-lists,netdev=lfdr.de,ciprian.regus.analog.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	HAS_REPLYTO(0.00)[ciprian.regus@analog.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:replyto,analog.com:mid,analog.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C4AC15DCED4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ciprian Regus <ciprian.regus@analog.com>

The Open Alliance TC6 standard defines multiple memory maps for the
MAC-PHY's register space. These are used to separate standard, vendor
and PHY MMD specific registers. Add a macro to make it more clear which
memory map each register is part of and allow easier definition.

Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>

---
v2 changelog:
 - New patch
---
 drivers/net/ethernet/oa_tc6.c | 4 ++--
 include/linux/oa_tc6.h        | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 904bd790159d..876891ca9859 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -471,7 +471,7 @@ int oa_tc6_mdiobus_read_c45(struct mii_bus *bus, int addr, int devnum,
 	if (ret < 0)
 		return ret;
 
-	ret = oa_tc6_read_register(tc6, (ret << 16) | regnum, &regval);
+	ret = oa_tc6_read_register(tc6, OA_TC6_MMS_REG(ret, regnum), &regval);
 	if (ret)
 		return ret;
 
@@ -489,7 +489,7 @@ int oa_tc6_mdiobus_write_c45(struct mii_bus *bus, int addr, int devnum,
 	if (ret < 0)
 		return ret;
 
-	return oa_tc6_write_register(tc6, (ret << 16) | regnum, val);
+	return oa_tc6_write_register(tc6, OA_TC6_MMS_REG(ret, regnum), val);
 }
 EXPORT_SYMBOL_GPL(oa_tc6_mdiobus_write_c45);
 
diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
index ad6f17218603..8b56a132c9e3 100644
--- a/include/linux/oa_tc6.h
+++ b/include/linux/oa_tc6.h
@@ -10,6 +10,9 @@
 #include <linux/etherdevice.h>
 #include <linux/spi/spi.h>
 
+#define OA_TC6_MMS_REG(mms, reg) \
+	((((mms) & GENMASK(3, 0)) << 16) | ((reg) & GENMASK(15, 0)))
+
 /* OPEN Alliance TC6 registers */
 
 #define OA_TC6_REG_PHYID			0x0001

-- 
2.43.0



