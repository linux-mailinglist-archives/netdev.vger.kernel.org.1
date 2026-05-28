Return-Path: <netdev+bounces-292804-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNtID8qNGGptlAgAu9opvQ
	(envelope-from <netdev+bounces-292804-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 20:47:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C61E5F6B76
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 20:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FBAA301CA76
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 18:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CF532694F;
	Thu, 28 May 2026 18:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="RECosKdJ"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3833A3191BD
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 18:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779994034; cv=none; b=WOnxAaNLWhyNv84xeReM1iRgIDRPTUGGlAcJcNZZ2WEU1hgW5IYBe3jLvap7n7tQN2U1oMRWoGrvrg1JD090DsZpYoSRZJP0W/SpXKSPUaZZsMA/0YFkgtsM6RE9WeFaVQzHaJoGGVLN3OVvULI3CM1gk0mlNuHWeDSbH4NL+kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779994034; c=relaxed/simple;
	bh=nkOyAzHBVVx4d2t3gWAIQvqUdFKFTs7Bdx/C/ij/SfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3WNnn6JikvPN7oEWcOdoCtl6OofodbhYrXjWy6xWORu5AwTbzZIaQXAHd4FEHo+UWWYt+AOLcwVfwEZFrVTh1MPFnHjf2/HZ/iH9wgQCUH0MgbRMtmK+piOaUC5HJZ71/A/ob/Gi7Mz1aqQjP/lCQzg+ep530til7tjfcGvU8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=RECosKdJ; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1779994020; x=1780598820; i=wahrenst@gmx.net;
	bh=EhpB+YDgsPSfkQJxXCUquSNS+amM1QIzmmLJ8oJ3u24=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=RECosKdJp0raZtI0T3x1jotVG6Tcv+il7Zs7DxzHondXON2uh7Ll5NDg/H8iAHPw
	 A/SOlUH20BckVjt1jOILPRDPViAJTM+N8YWsrcbOg49E8f5F71vmgKnA6FlV9FR9h
	 mHSJsUiZ0Rj9m6hH4P4bDwXn1BuoVZDU1LyXtoQNs+72VLDQF//Zvmg5HphMAzhpQ
	 UIbeJHkqzYzTtfAZrzXYFxdwY4V4nihmS92qlcxTTL/n+SzRV3sf4L8JFS+ZksE10
	 Oh/ctPin/A2UvatvppfkeaGm8gvO8OwHK2fQ1l/BDduNDwkct5FLUi86mfcExVTW9
	 WIEKSC/bvXf/xAxBCg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDhhN-1wdQaS3mdD-006c61; Thu, 28
 May 2026 20:46:59 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 1/2] net: phy: dp83822: Improve readability in dp8382x_probe
Date: Thu, 28 May 2026 20:46:41 +0200
Message-ID: <20260528184642.33424-2-wahrenst@gmx.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528184642.33424-1-wahrenst@gmx.net>
References: <20260528184642.33424-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IkNcNzxlUG+3xi6gbl+3CIE3uFA/tgGMPSKrOV/4Lk9vPvMkUug
 JzUUM+Bl7zP4rnDhhE54IOE0skzXyCwNOMKU4GEUXtyO+P3ZfsHSLKe6/YbAEfTH+XR+pes
 ZcRdzjnqmU76XTxylO4DVaMNjypCdcyHrPzOSkBbsGb/MjIMoCYwiq0Br42AxzgOfw+U+SE
 1pLP+BNoYZSoMkNtKgYOw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:w6cS/XN+k1I=;FNSYgSoBqfMc+YT04s85cwMtWTD
 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
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292804-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmx.net];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.net];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wahrenst@gmx.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.net:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8C61E5F6B76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce a local pointer for device so devm_kzalloc() fit into
a single line. Also this makes following changes easier to read.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/phy/dp83822.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index c012dfab3171..d8c5b5cd1bc0 100644
=2D-- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -984,10 +984,10 @@ static int dp83822_attach_mdi_port(struct phy_device=
 *phydev,
=20
 static int dp8382x_probe(struct phy_device *phydev)
 {
+	struct device *dev =3D &phydev->mdio.dev;
 	struct dp83822_private *dp83822;
=20
-	dp83822 =3D devm_kzalloc(&phydev->mdio.dev, sizeof(*dp83822),
-			       GFP_KERNEL);
+	dp83822 =3D devm_kzalloc(dev, sizeof(*dp83822), GFP_KERNEL);
 	if (!dp83822)
 		return -ENOMEM;
=20
=2D-=20
2.43.0


