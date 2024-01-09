Return-Path: <netdev+bounces-62708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E15C828A40
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 17:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFB30287FC1
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 16:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CB73AC34;
	Tue,  9 Jan 2024 16:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ix9Y77Z6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792D63AC24;
	Tue,  9 Jan 2024 16:45:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4571C433B1;
	Tue,  9 Jan 2024 16:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704818726;
	bh=ng8hG7XvXxuBXqWkTVtckgnpL1hNaS8M8BBMxELykF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ix9Y77Z6oJ80/ZCA/7vON8O9Fv9tjqqPS1f6f14rcowhFxdxipFrbz6DT1TrCWX0e
	 h8FpGiPxIm0/6JQVsY8VtRcNgeL/uXeXOPLqUoRIEnpRY4qbxLp8Y3NwUlRPMDsXS7
	 fARXW95G3OcPAzWFAfQ/aJYdfYHk/y+xOgLGmkzcQmJWFTqnhymyWSgfL9VUnG2m1v
	 meriOz9TxzzTVyFWD7PAIjoBAm6g+x//m/0d6iQtcPhd0im0S+B5O/jN2bmpWUtJzE
	 9dsC980W0lc9t+eyeMQr8g1Jfw1Fbx+fiC2/MTWiW8p2q8dGBqWLBSVrQZDu2oYfAs
	 oOmdEyhVzCTPQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH net 5/7] MAINTAINERS: Bluetooth: retire Johan (for now?)
Date: Tue,  9 Jan 2024 08:45:15 -0800
Message-ID: <20240109164517.3063131-6-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109164517.3063131-1-kuba@kernel.org>
References: <20240109164517.3063131-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Johan moved to maintaining the Zephyr Bluetooth stack,
and we haven't heard from him on the ML in 3 years
(according to lore), and seen any tags in git in 4 years.
Trade the MAINTAINER entry for CREDITS, we can revert
whenever Johan comes back to Linux hacking :)

Subsystem BLUETOOTH SUBSYSTEM
  Changes 173 / 986 (17%)
  Last activity: 2023-12-22
  Marcel Holtmann <marcel@holtmann.org>:
    Author 91cb4c19118a 2022-01-27 00:00:00 52
    Committer edcb185fa9c4 2022-05-23 00:00:00 446
    Tags 000c2fa2c144 2023-04-23 00:00:00 523
  Johan Hedberg <johan.hedberg@gmail.com>:
  Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
    Author d03376c18592 2023-12-22 00:00:00 241
    Committer da9065caa594 2023-12-22 00:00:00 341
    Tags da9065caa594 2023-12-22 00:00:00 493
  Top reviewers:
    [33]: alainm@chromium.org
    [31]: mcchou@chromium.org
    [27]: abhishekpandit@chromium.org
  INACTIVE MAINTAINER Johan Hedberg <johan.hedberg@gmail.com>

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: Marcel Holtmann <marcel@holtmann.org>
CC: Johan Hedberg <johan.hedberg@gmail.com>
CC: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: linux-bluetooth@vger.kernel.org
---
 CREDITS     | 4 ++++
 MAINTAINERS | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/CREDITS b/CREDITS
index 18ce75d81234..1228f96110c4 100644
--- a/CREDITS
+++ b/CREDITS
@@ -1543,6 +1543,10 @@ N: Andrew Haylett
 E: ajh@primag.co.uk
 D: Selection mechanism
 
+N: Johan Hedberg
+E: johan.hedberg@gmail.com
+D: Bluetooth subsystem maintainer
+
 N: Andre Hedrick
 E: andre@linux-ide.org
 E: andre@linuxdiskcert.org
diff --git a/MAINTAINERS b/MAINTAINERS
index 1e375699ebb7..388fe7baf89a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3595,7 +3595,6 @@ F:	drivers/mtd/devices/block2mtd.c
 
 BLUETOOTH DRIVERS
 M:	Marcel Holtmann <marcel@holtmann.org>
-M:	Johan Hedberg <johan.hedberg@gmail.com>
 M:	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
 L:	linux-bluetooth@vger.kernel.org
 S:	Supported
-- 
2.43.0


