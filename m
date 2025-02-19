Return-Path: <netdev+bounces-167708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD3BA3BD92
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 12:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 003CB16AA76
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 11:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888741DF251;
	Wed, 19 Feb 2025 11:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="POu1JT8g"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC8F1DE4F1;
	Wed, 19 Feb 2025 11:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739966290; cv=none; b=otgaLKXnJ13HyS/5VkUg0jVhQRWbEB33kX2n5JR7ePxFC7yEJSrj2FvrersFtQIUv+0aelHWlQKV6oFhumdLtTJx10c6HIjzzjrn/3jLiXxdvZ6pRGHUIXB1QXMzsIELK3bWM0nb5+gEVemzximxAuun6EsE/PtNOi7O0G5nLMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739966290; c=relaxed/simple;
	bh=yfucNtav9zosEn23eavh+hcBR39Pgv6g7EaIOb9LX+w=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=pNB9KTp5ULPG+RE8nvrZdL0Vni52IyDk4en4vfErNbAT5XwOUCXlxY2je2rVZDZSHMp+KT3+YdIJM3WDqdfP7QfpPM4gp+MMItqZ0d5H45oeNgN0d6N7HskiyBjJhmteWi7S+TWWDdoTipeqG/QVIxvq9VW4c7xM3YwVK8ppq6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=POu1JT8g; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kpNp8MjIizYb7OH3AFJBJFxIeGnBoky4xSMY7bm6YaM=; b=POu1JT8gRqxYf6k2RglvMqqRcU
	5E3AVChz13gXtmPBOcmfbqXveOI4iTx00Si/PAUESwrE837IShuGE9f8lYTcv5dSbogmxMCf3V2yz
	33dAvKrQWiPtrDnLzLa8bQaRNHGiIcZheGBd9f1J0wb1WsKM5rrVZVOdWb9zJmVzsVpJUqzbTpE2x
	6yxTjUA+Hc3UTz8JS7rRgs0HfyyPojCAMlT/1oNWJ99oHUgkDYrPshaRFOYoAMph0fS1WIrHIKM9E
	FlJNQTl+TgZymAu1jFkAF+YgDjn+j7OJpDBeo7O9f5NZhz1T5SGDQ7M4XqT/aQ6ZM7IAur+UYQ9M9
	EI7TY5+A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:32898 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tkiiH-0005b1-2e;
	Wed, 19 Feb 2025 11:58:01 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tkihy-004TEP-0O; Wed, 19 Feb 2025 11:57:42 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] MAINTAINERS: fix dwmac-s32 entry
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tkihy-004TEP-0O@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 19 Feb 2025 11:57:42 +0000

Using L: with more than a bare email address causes getmaintainer.pl
to be unable to parse the entry. Fix this by doing as other entries
that use this email address and convert it to an R: entry.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Fixes: 6bc6234cbd5e ("MAINTAINERS: Add Jan Petrous as the NXP S32G/R DWMAC driver maintainer")
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0bfcbe6a74ea..4795b6209711 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2877,7 +2877,7 @@ F:	drivers/pinctrl/nxp/
 
 ARM/NXP S32G/S32R DWMAC ETHERNET DRIVER
 M:	Jan Petrous <jan.petrous@oss.nxp.com>
-L:	NXP S32 Linux Team <s32@nxp.com>
+R:	NXP S32 Linux Team <s32@nxp.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
-- 
2.30.2


