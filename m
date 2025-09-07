Return-Path: <netdev+bounces-220689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A878B47FE3
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 22:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9914200960
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 20:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06FE26E6FF;
	Sun,  7 Sep 2025 20:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QLm8o2o7"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FC11F63CD
	for <netdev@vger.kernel.org>; Sun,  7 Sep 2025 20:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757277816; cv=none; b=gLbC4dn0PT7VEfA8J4We6VLL0zr9VOVZY41141tWL44RkeOGCQfryCC3p+oGPXWuveY2dJfiwbcOQHCr4MawF+qhqPDb4KkvBlq0H8R8fVQIe/rtaZEAfuoDVyb0GcgV6BH2FNcrgsbDEbRVZ/6BxyLjuyfAmudfftRIYPmG75k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757277816; c=relaxed/simple;
	bh=RZDPYvusx4oieNYT1UxXlOum4dkYokqjyaJiLq6q+yM=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=pwsWKGGqcRGr11TgGBrLDJM/dx6t8B/xuROus5vtrMKgLme61CNv8lD1ZdLzctFoNwje0a0Pb0d+7fZKpcRv1ueltdTxE4RTsftPK9ToPbi2Yh3hPsn92zv5+xB9Qb92sSDJ18IvKLw4VyVqNd5UpE2Bk2hOkqJGnJVUJGOwGh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=QLm8o2o7; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=m6k8V/tLgevsU5z7JgRaUL9LtapavzXZnwfqOKje87o=; b=QLm8o2o7bn4dLYI47DCflJb/p7
	KqNlmE5r8/cMaylrImV7ivhmq+uUCNj+7Ss1T004GW9xxZ6CzXZzDAFfzvdF3st4vSm8v2x43AJjE
	fAIcUsgNsPoadqKA5cwWvP7a5GNGjd4gHqUYppbIVBh/deblH3IXpeZH4a83jY3npld9IaQRhzwVI
	y4lpKhOsc7CXnF9mX84ycJJZwXCtVF6bxdq76p0vPkg+JghP7Y5AtyB0X3mGIaE2MpGkvXNwoymv8
	S5z1XIBcgRNMKcMpt+wk3NIf/MvDg0/+3jutxT7ZWnqu932VvF9zSkvM5uZo/Zm52URJU4WJUwwi/
	QWotR0WQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:58182 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uvMEL-000000005eP-1jpR;
	Sun, 07 Sep 2025 21:43:21 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uvMEK-00000003Amd-2pWR;
	Sun, 07 Sep 2025 21:43:20 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Alexandra Winter <wintera@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Shannon Nelson <sln@onemain.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net] net: ethtool: fix wrong type used in struct
 kernel_ethtool_ts_info
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uvMEK-00000003Amd-2pWR@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sun, 07 Sep 2025 21:43:20 +0100

In C, enumerated types do not have a defined size, apart from being
compatible with one of the standard types. This allows an ABI /
compiler to choose the type of an enum depending on the values it
needs to store, and storing larger values in it can lead to undefined
behaviour.

The tx_type and rx_filters members of struct kernel_ethtool_ts_info
are defined as enumerated types, but are bit arrays, where each bit
is defined by the enumerated type. This means they typically store
values in excess of the maximum value of the enumerated type, in
fact (1 << max_value) and thus must not be declared using the
enumated type.

Fix both of these to use u32, as per the corresponding __u32 UAPI type.

Fixes: 2111375b85ad ("net: Add struct kernel_ethtool_ts_info")
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 include/linux/ethtool.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index de5bd76a400c..d7d757e72554 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -856,8 +856,8 @@ struct kernel_ethtool_ts_info {
 	enum hwtstamp_provider_qualifier phc_qualifier;
 	enum hwtstamp_source phc_source;
 	int phc_phyindex;
-	enum hwtstamp_tx_types tx_types;
-	enum hwtstamp_rx_filters rx_filters;
+	u32 tx_types;
+	u32 rx_filters;
 };
 
 /**
-- 
2.47.3


