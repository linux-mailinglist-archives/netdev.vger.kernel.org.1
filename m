Return-Path: <netdev+bounces-200696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82924AE68E4
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF7B317A896
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EC42D29DD;
	Tue, 24 Jun 2025 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+dwQxd1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C7927FB31
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775332; cv=none; b=KwcsimNhx5zxiHA39paIgovuLuFkjvRgoVcpT9RjfEenFkQS/JqhOEx9v3nInI7/MW1JJw8WRgNDrFZUeo79BLgYuzFHO+e3fiJD3OSGTOeuoCrdVg0ikotmjQmxESfjtYD3IG4vgtKNZ5L+1wbskK7LBAzicQab/aDgsziZYgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775332; c=relaxed/simple;
	bh=CF+4MT2utR83+xFM7MaHh1SGb3Pg3yiQ/pLNwNkzSb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=axPXPPCP+gGmXHTBDdkdYkiMiIOd1GnntULYzcxJNrnNrTsZ2XkUttldHkz4V/w5QIkKdoqRLIMkMTgm6AZZLRoawg/dOj4TAT0g/h5IFBbWxMCQQ9HASA5nAFKEt61ay3qDr1SzATcHv45CczgPNyH5+pgX/QLOb9eNNVcu1Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+dwQxd1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876BFC4CEF0;
	Tue, 24 Jun 2025 14:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750775331;
	bh=CF+4MT2utR83+xFM7MaHh1SGb3Pg3yiQ/pLNwNkzSb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L+dwQxd1MCBkAuB5xFiNc8mGkjVr1nXB+KhSbuXFYvY1+lWYkxw4KwvVXtWxfjhPQ
	 eDA+bQ8KgenYpfrVpbzMm1E0r7YYUcQFbOQBI/ty21ogbk84HD5KgmCl4HzcP+rrU+
	 WAmSJP9yqgOQuyoFX2+QA1HhamKy5xebO5HFKN0HGFav41Rj+yq8WCuaofkByGh7qR
	 7W0W5bhJctTnKILUMayOL07JfJf+15687ukAPA1enIlVCmUOCyNtIQ+DZBoCtU6xSk
	 5Mmfo37GSeLeKPzbLXFxCn/IJUwDMB2IKB/wH6QKm2b+epaMgEukUgV3TYMywuEMH4
	 txb2PcKzD1iUw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	alexanderduyck@fb.com,
	mohsin.bashr@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 4/5] eth: fbnic: sort includes
Date: Tue, 24 Jun 2025 07:28:33 -0700
Message-ID: <20250624142834.3275164-5-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624142834.3275164-1-kuba@kernel.org>
References: <20250624142834.3275164-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure includes are in alphabetical order.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index ab8b8b0f9f64..86576ae04262 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -4,8 +4,8 @@
 #ifndef _FBNIC_NETDEV_H_
 #define _FBNIC_NETDEV_H_
 
-#include <linux/types.h>
 #include <linux/phylink.h>
+#include <linux/types.h>
 
 #include "fbnic_csr.h"
 #include "fbnic_rpc.h"
-- 
2.49.0


