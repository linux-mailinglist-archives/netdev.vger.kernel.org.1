Return-Path: <netdev+bounces-216724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C9AB35009
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 02:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77E5D1B264E1
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 00:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337761946BC;
	Tue, 26 Aug 2025 00:12:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFE23AC22;
	Tue, 26 Aug 2025 00:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756167145; cv=none; b=QpLuC7J9cQTyfcky7q/4aaXTDDH/vFFWCjjPakL0We/9cIUtS+mbgjJmFgW+72qQwfCvM8oo2iMlm8/f1YDVmFMfadwA5xXzzmyNsMPeMMb6Z2yvn+CUiFSVXan3QK1W/TuOdPpZsRUVegKvgP2vxS5oZS6dylvdi2LlxlIIIoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756167145; c=relaxed/simple;
	bh=O6ZkwTJFlV9rQHIBzRni5BKIh4ff0+xxGi0ehaNWY4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyguGRblaBfugjHMJ9ZNqKKPaz+rtBNwtyvNa4cLF4xFMNUJKEwACw3lc8lpwAJkkEaPN2Lvk34350Zt10zoaQzSrVv62YKb5vlshujAEzmkqmb9ijFB0bOFNIuR958qJHzR/OCKaWAmYvM/WqWIL+pOgjMRmqomx4FMsUU3llg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uqhIJ-000000005jX-346A;
	Tue, 26 Aug 2025 00:12:11 +0000
Date: Tue, 26 Aug 2025 01:12:08 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next 1/6] MAINTAINERS: lantiq_gswip: broaden file pattern
Message-ID: <8c42d29b711287d7aa54be93809fd8cea69b7c06.1756163848.git.daniel@makrotopia.org>
References: <cover.1756163848.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756163848.git.daniel@makrotopia.org>

Match all drivers/net/dsa/lantiq_gswip* instead of only lantiq_gswip.c.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bce96dd254b8..aae3a261d7f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13801,7 +13801,7 @@ M:	Hauke Mehrtens <hauke@hauke-m.de>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
-F:	drivers/net/dsa/lantiq_gswip.c
+F:	drivers/net/dsa/lantiq_gswip*
 F:	drivers/net/dsa/lantiq_pce.h
 F:	drivers/net/ethernet/lantiq_xrx200.c
 F:	net/dsa/tag_gswip.c
-- 
2.50.1

