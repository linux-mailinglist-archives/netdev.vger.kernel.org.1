Return-Path: <netdev+bounces-172545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC34A55547
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 19:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E1D41893472
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 18:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFAE19E99E;
	Thu,  6 Mar 2025 18:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="lOjurV0U"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B08B667;
	Thu,  6 Mar 2025 18:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741286750; cv=none; b=OjjmIZKltu+fzeK7/HTlJyIsYLe5JTUQIY3bevk6w1RxE/SYEN5P9URPe5aarnsNRiG51lBQpFZUvMSCpqQTebCjqbNZJX0jzxZvOB1Kjh9fq0J8pqHCGeOQVzuIDasp9faTJR6BnW102bfmvUOMvhYxvhQPE1iVmhkT8Tjz/Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741286750; c=relaxed/simple;
	bh=vpj02Xcibt1fcSHiLyj+EWeG4DG8e1S9LTnMiIS0l4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ze1tNQETndIH9PJ+I0mioBuvovMSsM+zUJYx0FfPawZw5TDw9MLoIOW2PeWJW4Sn+DEScDIo/+Cv/SfTa0yLY2xQRvBBo90w+yVBpWFfQ3nNPmxPRFtDOpJNFLqXR/kBjG6mg5zQEfOEpq9SBvWO7zSVuohTRnoZ5OpBuPsjre0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=lOjurV0U; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=9qD6hhzVShQ+yvnvzEbzDxl+ULTsOh6MSm995HpgMyA=; b=lOjurV0UivhNfL5G
	J6XMGKBbMgP6zpc5jF33X9lJ1DnS6sP8uVl5HMFAlmyH40aMZYO4Awlph23M+DKK5hdrX8CBXv7zd
	67TKVfys0XQAJooYY5/QJabVYt9wXwDAjIvgdo2d0cTPoqzNADfWiSkRI4gv08a6ASUkIpD/W4qgU
	fwALpnJY5w3CYAlkjg6tRNSDZ0xUScERTQ/9HdAEQBvk2b0SuNcVNTd9Sw+D011VmMPhvInXi8Ob2
	2muv4QZJlu6IgDQ+iSKHcSsrVCwma0irOTdQ0PL+LI+aCWipmpaxfEcofIzjHqV5sjZnTzmcxgZDb
	JvyiG0qa8JN9lN0+bw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tqGDv-003CiH-2q;
	Thu, 06 Mar 2025 18:45:35 +0000
From: linux@treblig.org
To: linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next] net: phylink: Remove unused phylink_init_eee
Date: Thu,  6 Mar 2025 18:45:34 +0000
Message-ID: <20250306184534.246152-1-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

phylink_init_eee() is currently unused.

It was last added in 2019 by
commit 86e58135bc4a ("net: phylink: add phylink_init_eee() helper")
but it didn't actually wire a use up.

It had previous been removed in 2017 by
commit 939eae25d9a5 ("phylink: remove phylink_init_eee()").

Remove it again.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/phy/phylink.c | 18 ------------------
 include/linux/phylink.h   |  1 -
 2 files changed, 19 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index b00a315de060..734869ec6f74 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -3159,24 +3159,6 @@ int phylink_get_eee_err(struct phylink *pl)
 }
 EXPORT_SYMBOL_GPL(phylink_get_eee_err);
 
-/**
- * phylink_init_eee() - init and check the EEE features
- * @pl: a pointer to a &struct phylink returned from phylink_create()
- * @clk_stop_enable: allow PHY to stop receive clock
- *
- * Must be called either with RTNL held or within mac_link_up()
- */
-int phylink_init_eee(struct phylink *pl, bool clk_stop_enable)
-{
-	int ret = -EOPNOTSUPP;
-
-	if (pl->phydev)
-		ret = phy_init_eee(pl->phydev, clk_stop_enable);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(phylink_init_eee);
-
 /**
  * phylink_ethtool_get_eee() - read the energy efficient ethernet parameters
  * @pl: a pointer to a &struct phylink returned from phylink_create()
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 898b00451bbf..7fbabd8b96fe 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -694,7 +694,6 @@ void phylink_ethtool_get_pauseparam(struct phylink *,
 int phylink_ethtool_set_pauseparam(struct phylink *,
 				   struct ethtool_pauseparam *);
 int phylink_get_eee_err(struct phylink *);
-int phylink_init_eee(struct phylink *, bool);
 int phylink_ethtool_get_eee(struct phylink *link, struct ethtool_keee *eee);
 int phylink_ethtool_set_eee(struct phylink *link, struct ethtool_keee *eee);
 int phylink_mii_ioctl(struct phylink *, struct ifreq *, int);
-- 
2.48.1


