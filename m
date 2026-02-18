Return-Path: <netdev+bounces-259207-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MC1DP1NlWnIOAIAu9opvQ
	(envelope-from <netdev+bounces-259207-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 06:28:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C1B1531ED
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 06:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FD7830209DE
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 05:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67715302149;
	Wed, 18 Feb 2026 05:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=poleshift.se header.i=@poleshift.se header.b="b0o1Qo1g";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="BIWUcywv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=poleshift.se header.i=@poleshift.se header.b="hpW+Y4GI"
X-Original-To: netdev@vger.kernel.org
Received: from e240-2.smtp-out.eu-north-1.amazonses.com (e240-2.smtp-out.eu-north-1.amazonses.com [23.251.240.2])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB08302741;
	Wed, 18 Feb 2026 05:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.240.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771392506; cv=none; b=rTAlXhTkRUI+IXU9Ad+MOgXzmJ+5/hcdWjilM8W2B4eF2dFjrx7EuiqJvM7mSkrrzE6AbbjgLoHt8ExQifL8aJ/tQm0hNC4P10p3xoSD+LwZnWOZP/cq9ab8v8+Zqj6IdexBNtpK+yMSiLwj0JRM2AOfxYHXFLMUrK4moyFaoZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771392506; c=relaxed/simple;
	bh=pYwAnMSFwzMSy5YViKb3RtaiuMhEnOHJimnRsrg7mDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:Cc; b=J8jOKl3bjnUs4zD65PuAqN9stOeXNQQ4XR7IOhrDDpOI+1Xa1oSB5gFXZwTrFLzacLya8bjbuSNz/v96vuDjnl7b0JCcnbyNsM3y8zbSU5FyODuJRf5rM9rOJK4SbajY/y+Ia91bJMisS75aGkF1RmVZQ1WkFKDiF0iGqPAqiVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=poleshift.se; spf=pass smtp.mailfrom=eu-north-1.amazonses.com; dkim=pass (2048-bit key) header.d=poleshift.se header.i=@poleshift.se header.b=b0o1Qo1g; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=BIWUcywv; dkim=fail (0-bit key) header.d=poleshift.se header.i=@poleshift.se header.b=hpW+Y4GI reason="key not found in DNS"; arc=none smtp.client-ip=23.251.240.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=poleshift.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eu-north-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=n6aiayff3zq3manwyovyvpolm4pou2ef; d=poleshift.se; t=1771392502;
	h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:To:Cc;
	bh=pYwAnMSFwzMSy5YViKb3RtaiuMhEnOHJimnRsrg7mDA=;
	b=b0o1Qo1g9NcqcT3do2js4UvNScuqY8nLbcgeNwypT0obcRNbqQWknmpCcGKHWMwt
	yLxJiME4ppaI1QU7Fgl6Ry1Nr+krWehCBQxFE8e8bMsog9/99HEdDloaOMu/5Z2LhOd
	fA0yjMPQJSbiTPNHhMw4dLvw/59jnCs4DuPEEFl1JPo7XE2c4WDzMnBptBUFBrQW4Jn
	3OnfQ+iDpeP/S1+IsQpaxCfBhcUG8w/Iwm5atkI23kAw85YTYcck1WuBhgkyEOgTqJU
	TG1ufhMb77HdX0jypEYcWPDY2kbTy381cxWxswtQhHFdOgBIWQ45fstWS6ZOqtmUawt
	NDQ2cH5gEQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=icdr7g7fbtu2nwxgaimytihkt42k3kiy; d=amazonses.com; t=1771392502;
	h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:To:Cc:Feedback-ID;
	bh=pYwAnMSFwzMSy5YViKb3RtaiuMhEnOHJimnRsrg7mDA=;
	b=BIWUcywvzyLwNZ2gpMk7noLH6HVzCamt9YqoLU2yi4zOZSx422In+nZqpDFVSIdK
	PVxyFIEN7FdyfAo+vf6TWrZSeemrrMuYBEAhVHIEsoPLenI0Uyz6nXvN9yDtcArucAa
	molJaytKPB5Xl1MHRyYQW3ZNib/Bi0RI8mt+RwmU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poleshift.se;
	s=20230429; t=1771392500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F/pKx2TLXuF3OwfKFAD9ATqLuWyO3+40ljoC9QdG8KU=;
	b=hpW+Y4GIlSJ1Gdu2xX9JjdsDPI0yVCistgHBQhelJ2Td+OahdM6cOZ6gVXDtb7He7GeLxc
	520Y2nmTSNVtEuuhv0+pgSTENvhv3lXh2QBSgibRmOPE7ljpXs41i9x4oUnvfDB1o7YPWd
	ipNsFtTH15Z/CISZ5U9n/LmRS9n9RBo=
From: =?utf-8?q?Martin_P=C3=A5lsson?= <martin@poleshift.se>
Date: Wed, 18 Feb 2026 05:28:22 +0000
Subject: [PATCH v3] net: usb: lan78xx: scan all MDIO addresses on LAN7801
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <0110019c6f388aff-98d99cf0-4425-4fff-b16b-dea5ad8fafe0-000000@eu-north-1.amazonses.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XNQQ6CMBAF0KuQWTumLaWgK+9hXFQ62EYE0pIGQ
 ri7hZUxMS7/n/w3CwTyjgKcswU8RRdc36WQHzKore4ehM6kDIIJxQSX2OqurKYJBzvjS4cnNm5
 CLdPVEC+0rCFNB0+p3tnrLWXrwtj7ef8S+db+ASNHjvlda85YpTjJy9C3FKxrxmMg2MwoPh31w
 xHJUXQqqTiRMbL8ctZ1fQOjnhBhAwEAAA==
X-Change-ID: 20260214-lan78xx-phy-mask-fix-a4260de15a4c
To: Thangaraj Samynathan <Thangaraj.S@microchip.com>, 
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>, 
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, 
	Woojung Huh <woojung.huh@microchip.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	=?utf-8?q?Martin_P=C3=A5lsson?= <martin@poleshift.se>
X-Mailer: b4 0.14.3
Feedback-ID: ::1.eu-north-1.nVsitYrO9p3qnPLcZXP017jV0c/PN62ZbS4lYSSQpnA=:AmazonSES
X-SES-Outgoing: 2026.02.18-23.251.240.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[poleshift.se,reject];
	R_DKIM_ALLOW(-0.20)[poleshift.se:s=n6aiayff3zq3manwyovyvpolm4pou2ef,amazonses.com:s=icdr7g7fbtu2nwxgaimytihkt42k3kiy];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259207-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_PERMFAIL(0.00)[poleshift.se:s=20230429];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[poleshift.se:+,amazonses.com:+,poleshift.se:~];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin@poleshift.se,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_MIXED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazonses.com:dkim,eu-north-1.amazonses.com:mid,poleshift.se:email,poleshift.se:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 99C1B1531ED
X-Rspamd-Action: no action

The LAN7801 is designed exclusively for external PHYs (unlike the
LAN7800/LAN7850 which have internal PHYs), but lan78xx_mdio_init()
restricts PHY scanning to MDIO addresses 0-7 by setting phy_mask to
~(0xFF). This prevents discovery of external PHYs wired to addresses
outside that range.

One such case is the DP83TC814 100BASE-T1 PHY, which is typically
configured at MDIO address 10 via PHYAD bootstrap pins and goes
undetected with the current mask.

Remove the restrictive phy_mask assignment for the LAN7801 so that the
default mask of 0 applies, allowing all 32 MDIO addresses to be
scanned during bus registration.

Fixes: 02dc1f3d613d ("lan78xx: add LAN7801 MAC only support")

Signed-off-by: Martin Pålsson <martin@poleshift.se>
---
Changes in v3:
- Removed restrictive phy_mask assignment and comment, relying on the
  default mask of 0 to scan all 32 MDIO addresses (Maxime Chevallier)
- Link to v2: https://lore.kernel.org/r/20260216-lan78xx-phy-mask-fix-v2-1-6e97e59edd47@poleshift.se

Changes in v2:
- Added Fixes: tag
- Link to v1: https://lore.kernel.org/r/20260214-lan78xx-phy-mask-fix-v1-1-3baa100861e4@poleshift.se
---
 drivers/net/usb/lan78xx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 00397a807393..065588c9cfa6 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2094,8 +2094,6 @@ static int lan78xx_mdio_init(struct lan78xx_net *dev)
 		dev->mdiobus->phy_mask = ~(1 << 1);
 		break;
 	case ID_REV_CHIP_ID_7801_:
-		/* scan thru PHYAD[2..0] */
-		dev->mdiobus->phy_mask = ~(0xFF);
 		break;
 	}
 

---
base-commit: ee5492fd88cfc079c19fbeac78e9e53b7f6c04f3
change-id: 20260214-lan78xx-phy-mask-fix-a4260de15a4c

Best regards,
-- 
Martin Pålsson <martin@poleshift.se>


