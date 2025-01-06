Return-Path: <netdev+bounces-155530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC2FA02E54
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 17:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F4841885F5B
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 16:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398A21DB360;
	Mon,  6 Jan 2025 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBrPr7jU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169F61ADFE3
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736182468; cv=none; b=Dub7EguupX/qb3lWcinqbGIR4mLavHmbrlJSPquGXx+DpoVe0pCs8Ky39zwp45Ybn8dNGQkYym46SJhv3Yg8Lw2HQZ0dsrtfztI4Ol5PxL6y+9/U7Sf1+skk/9Hs1iFBQr7A4RzHLEneOBuqiVj2EfuqGEYXoddGtIJIRTDELVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736182468; c=relaxed/simple;
	bh=xG9h1zUQlyJFhkVZOGJVKYgSUTqNvRYKRo7NmSkTSOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G9KgmJmYBd3vVZzvT5WMvZdn3NEtLgBzoBV4KVo4UpaQIFtwMbVeeN19hq2SjnZNO53GCXj/RLYU7Ym4D68vM3s3NR9chGcXaYwKeGRN6Tg0b/4dK8D4IV1FYVlZ0J5YqPov5kkMKn+mXZwO+qslrElP5GhFq8Ebq7NEx5lsV5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBrPr7jU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A720C4CEE2;
	Mon,  6 Jan 2025 16:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736182467;
	bh=xG9h1zUQlyJFhkVZOGJVKYgSUTqNvRYKRo7NmSkTSOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gBrPr7jUAXsn7UQPlinC8nSDUTnS3xYPjagzl15m8oHGZCTbm+zE2sHVhSPRBwyrP
	 7vNAplksXICkyJvNpSFFJHdMDbq0athCpwFO9ML5c7buZc5xDTCNdtzEr1LJ9VXJat
	 pFw7JhaYdorzbCxA1WzxUTpK22TQSH+ubuIDllZ+tsE82AMEwX64D7a9XnGupewRPl
	 oScUiM0Y03OlGyIUNyeYtYSvwsyuyHF5lpEgWCAxfmldEZGYo0ljPPHvribBEqO45d
	 1Ugdg2Ck/fGpBcnvvvOL9iMDoypMMixPUrmOGrOkkj5h2V8wf5qeS67HYnqy/PRqVR
	 AzIJrwtpTC0Cg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	Jakub Kicinski <kuba@kernel.org>,
	woojung.huh@microchip.com
Subject: [PATCH net 2/8] MAINTAINERS: mark Microchip LAN78xx as Orphan
Date: Mon,  6 Jan 2025 08:53:58 -0800
Message-ID: <20250106165404.1832481-3-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106165404.1832481-1-kuba@kernel.org>
References: <20250106165404.1832481-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Woojung Huh seems to have only replied to the list 35 times
in the last 5 years, and didn't provide any reviews in 3 years.
The LAN78XX driver has seen quite a bit of activity lately.

gitdm missingmaints says:

Subsystem USB LAN78XX ETHERNET DRIVER
  Changes 35 / 91 (38%)
  (No activity)
  Top reviewers:
    [23]: andrew@lunn.ch
    [3]: horms@kernel.org
    [2]: mateusz.polchlopek@intel.com
  INACTIVE MAINTAINER Woojung Huh <woojung.huh@microchip.com>

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: woojung.huh@microchip.com
---
 CREDITS     | 4 ++++
 MAINTAINERS | 4 +---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/CREDITS b/CREDITS
index 2a5f5f49269f..7a5332907ef0 100644
--- a/CREDITS
+++ b/CREDITS
@@ -1816,6 +1816,10 @@ D: Author/maintainer of most DRM drivers (especially ATI, MGA)
 D: Core DRM templates, general DRM and 3D-related hacking
 S: No fixed address
 
+N: Woojung Huh
+E: woojung.huh@microchip.com
+D: Microchip LAN78XX USB Ethernet driver
+
 N: Kenn Humborg
 E: kenn@wombat.ie
 D: Mods to loop device to support sparse backing files
diff --git a/MAINTAINERS b/MAINTAINERS
index 188c08cd16de..91b72e8d8661 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24261,10 +24261,8 @@ F:	Documentation/devicetree/bindings/usb/nxp,isp1760.yaml
 F:	drivers/usb/isp1760/*
 
 USB LAN78XX ETHERNET DRIVER
-M:	Woojung Huh <woojung.huh@microchip.com>
-M:	UNGLinuxDriver@microchip.com
 L:	netdev@vger.kernel.org
-S:	Maintained
+S:	Orphan
 F:	Documentation/devicetree/bindings/net/microchip,lan78xx.txt
 F:	drivers/net/usb/lan78xx.*
 F:	include/dt-bindings/net/microchip-lan78xx.h
-- 
2.47.1


