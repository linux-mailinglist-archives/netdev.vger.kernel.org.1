Return-Path: <netdev+bounces-156315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A841EA060C6
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 16:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1238169376
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 15:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937C41FF7BC;
	Wed,  8 Jan 2025 15:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="laEGEr9a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAC51FF5F4
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 15:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736351567; cv=none; b=aWPu9FE6ROrDUlSU9iwLyZLYyFRt8bez6xWt+ALANnXXGihof6wFfs/5UDTHqFhCoo659gsVB6tub4typKoHgskV3qh2KLgXftdtAWBJw9f7FiikHBNc/RNieh0obwcoU8noXG4eZLhwZRnbZgfh9KE2iFAQfu9cBpq5yrkYYKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736351567; c=relaxed/simple;
	bh=fpuvH2H0nOhbwYvjPA8XrrOFvDoJ5CGSJwbMpmUH5zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3x2TISXWQI0mvC/9JoYdxykq+iVNYY42y8AHiBPazdaYfk8AGbQUncKMrO2JLUrf1OyR3QnDbW6TOcCUYB/r64mmFzIwRSDQm5YW5kT6sZm0zmrVoigmw2FFktNaf42v7+j0p/7kRVt1Cjj31E0zoomhnj8kkzQb3bfjZfbY+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=laEGEr9a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04FBC4CEE4;
	Wed,  8 Jan 2025 15:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736351566;
	bh=fpuvH2H0nOhbwYvjPA8XrrOFvDoJ5CGSJwbMpmUH5zM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=laEGEr9a+VpFQ/R4hHPxY1vQMMcUrQssJGQvLD0mJTPjlNvzPoVy5AZEKCokbO+7y
	 1Rtf0l58PS85Zfk0Zl0616LKdoojFgjUykSYgwlwKvqCOiJvAYyQ5s418dHX5fN8oN
	 E0q4Lb7TgMeO3vTdqF7UCCTFyCgKgoJHGnex2Hv2sN17aDeoEKXba97WJmc5e/OwM2
	 VF+813zc2FvAfGg0CyEMt/+KRD3nbnFSvV/sLHxlHaNI3bMDM1DFuOSGzL1DzRqHjX
	 POmP4RGnouflawjgeegyZw4Mlkl0L0OoPVb9WhvecAm0xQKThY0whGXdQb8YWBxoXT
	 G1mpFSdhGxpCA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	woojung.huh@microchip.com,
	thangaraj.s@microchip.com,
	rengarajan.s@microchip.com
Subject: [PATCH net v2 2/8] MAINTAINERS: update maintainers for Microchip LAN78xx
Date: Wed,  8 Jan 2025 07:52:36 -0800
Message-ID: <20250108155242.2575530-3-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108155242.2575530-1-kuba@kernel.org>
References: <20250108155242.2575530-1-kuba@kernel.org>
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

Move Woojung to CREDITS and add new maintainers who are more
likely to review LAN78xx patches.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - add new maintainers instead of Orphaning

cc: woojung.huh@microchip.com
cc: thangaraj.s@microchip.com
cc: rengarajan.s@microchip.com
---
 CREDITS     | 4 ++++
 MAINTAINERS | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

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
index 188c08cd16de..f2cace73194e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24261,7 +24261,8 @@ F:	Documentation/devicetree/bindings/usb/nxp,isp1760.yaml
 F:	drivers/usb/isp1760/*
 
 USB LAN78XX ETHERNET DRIVER
-M:	Woojung Huh <woojung.huh@microchip.com>
+M:	Thangaraj Samynathan <Thangaraj.S@microchip.com>
+M:	Rengarajan Sundararajan <Rengarajan.S@microchip.com>
 M:	UNGLinuxDriver@microchip.com
 L:	netdev@vger.kernel.org
 S:	Maintained
-- 
2.47.1


