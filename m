Return-Path: <netdev+bounces-291941-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +F/zGFsWFmq7hQcAu9opvQ
	(envelope-from <netdev+bounces-291941-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 23:53:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E175DCF1C
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 23:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39B54304DFC9
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 21:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2F63C4551;
	Tue, 26 May 2026 21:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3Tk3KA6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6253C344B;
	Tue, 26 May 2026 21:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779832340; cv=none; b=VimMRB5+Tbj76RGWQ/KXh0p/CYa6YYeCYxJKsElkDsUGJp6KkBx4tdgp4DL762t8VIpZwBUCjpdhbO/xP5GorezQvTLIAocy1ep+RdwLwE51esA61y8Gdv5YsB/IzHq4KUebEx4yFxPMWV0wnAIpfgZ997pl9KyPONTEEzlvZug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779832340; c=relaxed/simple;
	bh=wy3Jx648a//MUt9p/ltDo3IVRrC1JhvoQ2FZ28LqGVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kk/2Ef1I6Jq6M1GlWsD89IVrkP5g67iBL+alMvvKdkJn+M9A0DPr0K8nLJCxnOwXXGC5zdDHq11blzDFHjOf1iOQFyvFJxo6mceNajrjZU214acsaAgVPFT6nYbnH6lCDKEc1wmBUbJ78+HNWGn0h8MJNOhYN8qy9fPzNijFU+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3Tk3KA6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D74BFC2BCFC;
	Tue, 26 May 2026 21:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779832339;
	bh=wy3Jx648a//MUt9p/ltDo3IVRrC1JhvoQ2FZ28LqGVM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=g3Tk3KA60xS0nHabooTXsjhTwwc/rX5pMRFRmu7pm2khhPHgn9TyuhIgj7fFWy3Am
	 fM976EIaFBxlBJBqvohd8c1qk3HUREvceRwelMmLcV0CpRgS78W+ISr8hBsxdsDKO+
	 nVJmVmWmb31EX91JTjIbKd1QWzLSCnUDkQ01YxZUCoBDsODorm0JpaIWfO0zh62aP6
	 xhFbvormTTXjkbGMDnOeE9KVxgeNvDTnXdO/ZOl1WnoQAwn+rNXMF8gQ3Lq9g31uvO
	 g/OuUEyn1lBz15cdJkAfbs/Xkvb48SvwW1QTbMBSpbfwXdz3FF8bL0X+o4BcbPAF0m
	 +le+kbp5mySQQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F88CD6E43;
	Tue, 26 May 2026 21:52:19 +0000 (UTC)
From: Ciprian Regus via B4 Relay <devnull+ciprian.regus.analog.com@kernel.org>
Date: Wed, 27 May 2026 00:51:49 +0300
Subject: [PATCH net-next v2 04/10] net: ethernet: oa_tc6: Export the C45
 access functions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-adin1140-driver-v2-4-37e5c8d4e0a0@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779832338; l=2238;
 i=ciprian.regus@analog.com; s=20260330; h=from:subject:message-id;
 bh=G2YKLlP+q7gpNa7VGIqaY6JB/wn+q0v7tTUGj7fc4Ig=;
 b=rXoEtqv1uWHPXPcoFBESGbR3Q5tVL3l15HQBWIwlJn83PG/06JuEZTrkdpI7sO6ZufvqNxuAG
 +xsByidfo8ECAxj++HQOMh/6/3lXG4A1QZPEgZr5tAPniZA+QwpJ7nU
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291941-lists,netdev=lfdr.de,ciprian.regus.analog.com];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	HAS_REPLYTO(0.00)[ciprian.regus@analog.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:replyto,analog.com:mid,analog.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 03E175DCF1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ciprian Regus <ciprian.regus@analog.com>

The C45 access functions can still be used by some Ethernet drivers
which set the OA_TC6_BROKEN_PHY flag. Export them.

Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>

---
v2 changelog:
 - New patch
---
 drivers/net/ethernet/oa_tc6.c | 10 ++++++----
 include/linux/oa_tc6.h        |  4 ++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 7ae3639beadd..4a1fd9fd75ab 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -499,8 +499,8 @@ static int oa_tc6_get_phy_c45_mms(int devnum)
 	}
 }
 
-static int oa_tc6_mdiobus_read_c45(struct mii_bus *bus, int addr, int devnum,
-				   int regnum)
+int oa_tc6_mdiobus_read_c45(struct mii_bus *bus, int addr, int devnum,
+			    int regnum)
 {
 	struct oa_tc6 *tc6 = bus->priv;
 	u32 regval;
@@ -516,9 +516,10 @@ static int oa_tc6_mdiobus_read_c45(struct mii_bus *bus, int addr, int devnum,
 
 	return regval;
 }
+EXPORT_SYMBOL_GPL(oa_tc6_mdiobus_read_c45);
 
-static int oa_tc6_mdiobus_write_c45(struct mii_bus *bus, int addr, int devnum,
-				    int regnum, u16 val)
+int oa_tc6_mdiobus_write_c45(struct mii_bus *bus, int addr, int devnum,
+			     int regnum, u16 val)
 {
 	struct oa_tc6 *tc6 = bus->priv;
 	int ret;
@@ -529,6 +530,7 @@ static int oa_tc6_mdiobus_write_c45(struct mii_bus *bus, int addr, int devnum,
 
 	return oa_tc6_write_register(tc6, (ret << 16) | regnum, val);
 }
+EXPORT_SYMBOL_GPL(oa_tc6_mdiobus_write_c45);
 
 static int oa_tc6_mdiobus_register(struct oa_tc6 *tc6)
 {
diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
index 6c38bf49e2a7..95e041d7d77b 100644
--- a/include/linux/oa_tc6.h
+++ b/include/linux/oa_tc6.h
@@ -32,3 +32,7 @@ int oa_tc6_read_registers(struct oa_tc6 *tc6, u32 address, u32 value[],
 			  u8 length);
 netdev_tx_t oa_tc6_start_xmit(struct oa_tc6 *tc6, struct sk_buff *skb);
 int oa_tc6_zero_align_receive_frame_enable(struct oa_tc6 *tc6);
+int oa_tc6_mdiobus_read_c45(struct mii_bus *bus, int addr, int devnum,
+			    int regnum);
+int oa_tc6_mdiobus_write_c45(struct mii_bus *bus, int addr, int devnum,
+			     int regnum, u16 val);

-- 
2.43.0



