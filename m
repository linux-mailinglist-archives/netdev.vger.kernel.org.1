Return-Path: <netdev+bounces-178478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB9BA771C4
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 02:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 234B3165725
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 00:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA852B9B4;
	Tue,  1 Apr 2025 00:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGv2ulVs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE32FC0B
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 00:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743466527; cv=none; b=nvYr8DRubPJx3OR0Td/3xn/ONZiMfqW78EPqWsR3amfGX7SHDxExMEkZiNm/vgixqY1eKHv5cAss7/2vLhPEVc9jB6k5C4cHm2GNlanICYGO1X+ADDdkptV5icA74eru5xKmB7bYUWzwojPW06t7rg1tJcpi3VnywdE94M30vXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743466527; c=relaxed/simple;
	bh=jPX8NoWWr8jf4VNHZIELRu22MOVU4PivsxNnj9USGFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OAia1RfRjpmqgP4YrD0Ldx5uHXaUcL76/bcm+ONkG+rrhwhxdxXasxxXJsb3NM7U9dZqMO8DjAmmZG4vD4HlSQHSo4/l5uAXF/1B8eLz+IsejV7NpFYFVdbe25JYlaPcUhQVf8uIxh3+JbmrQfvx/meBaKUQ70GDaHY+2Xdh8iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGv2ulVs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4113EC4CEE3;
	Tue,  1 Apr 2025 00:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743466526;
	bh=jPX8NoWWr8jf4VNHZIELRu22MOVU4PivsxNnj9USGFg=;
	h=From:To:Cc:Subject:Date:From;
	b=OGv2ulVsSe1OjhiwY/F1ieQoQYuyOItFKbGb8yzuJIrI/pVtNjWSh2cXjVjeXiacf
	 eGX3kbgXre46+SsD003cyOxwpRUhdGVySTavEe9YzZpIoX55Lvt1D7OCykDSrs1Go0
	 Bovjhq05gMKk+NMyBmcG06uBt6GTSuB7RI6CFugg5bVS2reZeZxSPtyBTC6X1bkmeb
	 g6wSFmWpHc3IK7ukO1Gkfiz0crSmuU3hLH+bPfHglChno5srgzAWpl2VEftTie4MIF
	 a/DePAcc4MVzOJ8TbE1ER11AQl7r/IvxbWXwAPpp3K2C0JcNuZTJoem+vnQTaeX7yP
	 UW5xRMngAZ7gg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Aaron Conole <aconole@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Eelco Chaudron <echaudro@redhat.com>,
	pshelar@ovn.org
Subject: [PATCH net] MAINTAINERS: update Open vSwitch maintainers
Date: Mon, 31 Mar 2025 17:15:20 -0700
Message-ID: <20250401001520.2080231-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pravin has not been active for a while, missingmaints reports:

Subsystem OPENVSWITCH
  Changes 138 / 253 (54%)
  (No activity)
  Top reviewers:
    [41]: aconole@redhat.com
    [31]: horms@kernel.org
    [23]: echaudro@redhat.com
    [8]: fw@strlen.de
    [6]: i.maximets@ovn.org
  INACTIVE MAINTAINER Pravin B Shelar <pshelar@ovn.org>

Let's elevate Aaron, Eelco and Ilya to the status of maintainers.

Acked-by: Aaron Conole <aconole@redhat.com>
Acked-by: Ilya Maximets <i.maximets@ovn.org>
Acked-by: Eelco Chaudron <echaudro@redhat.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
cc: i.maximets@ovn.org
cc: echaudro@redhat.com
cc: aconole@redhat.com
cc: pshelar@ovn.org
---
 MAINTAINERS | 4 +++-
 CREDITS     | 4 ++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ec10a4823937..40d01e564174 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17875,7 +17875,9 @@ F:	drivers/irqchip/irq-ompic.c
 F:	drivers/irqchip/irq-or1k-*
 
 OPENVSWITCH
-M:	Pravin B Shelar <pshelar@ovn.org>
+M:	Aaron Conole <aconole@redhat.com>
+M:	Eelco Chaudron <echaudro@redhat.com>
+M:	Ilya Maximets <i.maximets@ovn.org>
 L:	netdev@vger.kernel.org
 L:	dev@openvswitch.org
 S:	Maintained
diff --git a/CREDITS b/CREDITS
index d71d42c30044..41f071734dc7 100644
--- a/CREDITS
+++ b/CREDITS
@@ -3650,6 +3650,10 @@ S: 149 Union St.
 S: Kingston, Ontario
 S: Canada K7L 2P4
 
+N: Pravin B Shelar
+E: pshelar@ovn.org
+D: Open vSwitch maintenance and contributions
+
 N: John Shifflett
 E: john@geolog.com
 E: jshiffle@netcom.com
-- 
2.49.0


