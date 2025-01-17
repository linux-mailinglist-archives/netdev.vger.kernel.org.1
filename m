Return-Path: <netdev+bounces-159268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D87A14F4C
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 13:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AC737A3E8E
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 12:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B8B1FF61B;
	Fri, 17 Jan 2025 12:39:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B511FF1A9
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 12:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737117583; cv=none; b=SUqTbyD1tDbTfU+gQf1iuODgvhwpIBYfqDU25a2u2pTLeIaI8efO3OE962wpWnox99DzE0QhkHoFb/x6AYlqMFopINwpqiTwssiLbwAz7qzcozH5HakXNGJmxEtlrCdKdnAAF5FidkXdHhmvyN/C7NP2pOfeRzkCNJwoH8q/72s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737117583; c=relaxed/simple;
	bh=ssZeFyI0w9AVbDnjhIcKy6pR2gNDgAIntXO7xJQHGs0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gVnRr/GyRtDW0uZ6f2d1i7fzfkmAEnCTge9BhVcGYOW+UdH9W6kGx49FFwIBp/G5gtqNku4cwSHhkZrOCdd4WprLPc2YWixFNVIxEUB/P4JDYu0K5EIK9Wu90kLAqZ+hAy/Sq5yeW5P5S8oOVu3n9a+1HvuMfXsu/kKyoTkPB4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300C5973C90D8A96DD71A2E03f697.dip0.t-ipconnect.de [IPv6:2003:c5:973c:90d8:a96d:d71a:2e03:f697])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id B51E6FA366;
	Fri, 17 Jan 2025 13:39:39 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Marek Lindner <marek.lindner@mailbox.org>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 06/10] MAINTAINERS: update email address of Marek Linder
Date: Fri, 17 Jan 2025 13:39:06 +0100
Message-Id: <20250117123910.219278-7-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117123910.219278-1-sw@simonwunderlich.de>
References: <20250117123910.219278-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Marek Lindner <marek.lindner@mailbox.org>

Signed-off-by: Marek Lindner <marek.lindner@mailbox.org>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 .mailmap                                | 2 ++
 Documentation/networking/batman-adv.rst | 2 +-
 MAINTAINERS                             | 2 +-
 net/batman-adv/main.h                   | 2 +-
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index 5ff0e5d681e7..53e038f5f654 100644
--- a/.mailmap
+++ b/.mailmap
@@ -427,6 +427,8 @@ Marcin Nowakowski <marcin.nowakowski@mips.com> <marcin.nowakowski@imgtec.com>
 Marc Zyngier <maz@kernel.org> <marc.zyngier@arm.com>
 Marek Behún <kabel@kernel.org> <marek.behun@nic.cz>
 Marek Behún <kabel@kernel.org> Marek Behun <marek.behun@nic.cz>
+Marek Lindner <marek.lindner@mailbox.org> <lindner_marek@yahoo.de>
+Marek Lindner <marek.lindner@mailbox.org> <mareklindner@neomailbox.ch>
 Mark Brown <broonie@sirena.org.uk>
 Mark Starovoytov <mstarovo@pm.me> <mstarovoitov@marvell.com>
 Markus Schneider-Pargmann <msp@baylibre.com> <mpa@pengutronix.de>
diff --git a/Documentation/networking/batman-adv.rst b/Documentation/networking/batman-adv.rst
index 8a0dcb1894b4..44b9b5cc0e24 100644
--- a/Documentation/networking/batman-adv.rst
+++ b/Documentation/networking/batman-adv.rst
@@ -164,5 +164,5 @@ Mailing-list:
 
 You can also contact the Authors:
 
-* Marek Lindner <mareklindner@neomailbox.ch>
+* Marek Lindner <marek.lindner@mailbox.org>
 * Simon Wunderlich <sw@simonwunderlich.de>
diff --git a/MAINTAINERS b/MAINTAINERS
index 1e930c7a58b1..c5e909a759e6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3867,7 +3867,7 @@ S:	Maintained
 F:	drivers/platform/x86/barco-p50-gpio.c
 
 BATMAN ADVANCED
-M:	Marek Lindner <mareklindner@neomailbox.ch>
+M:	Marek Lindner <marek.lindner@mailbox.org>
 M:	Simon Wunderlich <sw@simonwunderlich.de>
 M:	Antonio Quartulli <a@unstable.cc>
 M:	Sven Eckelmann <sven@narfation.org>
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 1fbe3a4dd965..964f3088af5b 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -7,7 +7,7 @@
 #ifndef _NET_BATMAN_ADV_MAIN_H_
 #define _NET_BATMAN_ADV_MAIN_H_
 
-#define BATADV_DRIVER_AUTHOR "Marek Lindner <mareklindner@neomailbox.ch>, " \
+#define BATADV_DRIVER_AUTHOR "Marek Lindner <marek.lindner@mailbox.org>, " \
 			     "Simon Wunderlich <sw@simonwunderlich.de>"
 #define BATADV_DRIVER_DESC   "B.A.T.M.A.N. advanced"
 #define BATADV_DRIVER_DEVICE "batman-adv"
-- 
2.39.5


