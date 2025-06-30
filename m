Return-Path: <netdev+bounces-202565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A997EAEE471
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 18:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 569727AC967
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B98D28B7F8;
	Mon, 30 Jun 2025 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1MDe81H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4199C1BD9CE;
	Mon, 30 Jun 2025 16:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751300638; cv=none; b=ZbAWpPvBCOxm3goG0VyIg0H4EW0GwbK83jEhKynAgvju6Dru2MVorS8brKeOOi8Q/IwpJcGBFom2cJuneiWOJlcxVjLaPAoUOdn1oJcm/KoJWX1L+yvHuCsV6xHyMnOwEKVUMN/6GUCTGEgSLoluZT3iXCRnyqgs80/EenZyRmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751300638; c=relaxed/simple;
	bh=b6QHZKd7s72o3dJIWAfTZ0tJi8H76GiFa6F8fGzuiBY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UJOiEkKWsFxPVLqIxH+tlz9zgXYuWjZEyKaWgTHUNpOLjbFn+hP3nYJElunQk2DgNHwmtfcgjOrWii+Lxknw02ZqQtVuSYLsjuHAchphjND/BRE7qoxSMV99V3CdM261oU8ddacGx0Oq0gfC9zMScvu3u8opb8ufJ+DJ4dU+KrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1MDe81H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B97BBC4CEE3;
	Mon, 30 Jun 2025 16:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751300637;
	bh=b6QHZKd7s72o3dJIWAfTZ0tJi8H76GiFa6F8fGzuiBY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=u1MDe81HApLDErLvtO5ZHjSWVuocZb8N88pDYOs/HZtzJUesNLM64VUhwvdRUadqC
	 BtNhjWx1WnARE9kWWgf2zXDR4yIp4EBFpp7ELjCeeBhjZlhQO4B3Sy84ns0SsCsrA5
	 33b/pMZphMbVol+Wa9XQauw/cL52Zmu7ynQ+vY/gjSleW0g0Ux2SE89i006uON1Fo5
	 aZs1jgQ3OIoXY33qGiFLPCSz3W0nCyR/7pNiidZZBNbtNv0Rb6fAXS1XI8cM9emoyT
	 YeJFeQNi/SXjz7Ho8kVBu+BsNk0qd51JeDZQXZdmBO1TTb5Kv+vaWhEgl9g9GePktT
	 yzznE/UfWNPcA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D80C8302D;
	Mon, 30 Jun 2025 16:23:57 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Mon, 30 Jun 2025 11:23:53 -0500
Subject: [PATCH RESEND net-next v3] Fixed typo in netdevsim documentation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-netdevsim-typo-fix-v3-1-e1eae3a5f018@linux.ibm.com>
To: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, Joe Damato <joe@dama.to>, 
 Dave Marquardt <davemarq@linux.ibm.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751300637; l=1398;
 i=davemarq@linux.ibm.com; s=20250630; h=from:subject:message-id;
 bh=MEqm3SmnFyL3ZtTfgUhX+syORhLhO4nWf1g250ldrQk=;
 b=sKFlgQ61hUnJi37MriXk8na7tgyFykkCypzTtPzeAojpPug9LzA2wBcvywGsx7BZFOOCeNGPd
 hPcC1lX1+5zC0EbJtNACbjKigx5rypxjNDXOR0vA/bOdcZlGcm/7cz5
X-Developer-Key: i=davemarq@linux.ibm.com; a=ed25519;
 pk=eCwwhqOykPrqNNTH1uSGAhXUfNQI0Zlz7hb8uGTjPVU=
X-Endpoint-Received: by B4 Relay for davemarq@linux.ibm.com/20250630 with
 auth_id=447
X-Original-From: Dave Marquardt <davemarq@linux.ibm.com>
Reply-To: davemarq@linux.ibm.com

From: Dave Marquardt <davemarq@linux.ibm.com>

Fixed a typographical error in "Rate objects" section

Reviewed-by: Joe Damato <joe@dama.to>
Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
---
Fixed a typographical error in "Rate objects" section
---
Changes in v3:
- Retargeted from net to net-next
- Included Reviewed-by headers

Changes in v2:
- Targeted patch to net
---
 Documentation/networking/devlink/netdevsim.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/devlink/netdevsim.rst b/Documentation/networking/devlink/netdevsim.rst
index 88482725422c..3932004eae82 100644
--- a/Documentation/networking/devlink/netdevsim.rst
+++ b/Documentation/networking/devlink/netdevsim.rst
@@ -62,7 +62,7 @@ Rate objects
 
 The ``netdevsim`` driver supports rate objects management, which includes:
 
-- registerging/unregistering leaf rate objects per VF devlink port;
+- registering/unregistering leaf rate objects per VF devlink port;
 - creation/deletion node rate objects;
 - setting tx_share and tx_max rate values for any rate object type;
 - setting parent node for any rate object type.

---
base-commit: 8909f5f4ecd551c2299b28e05254b77424c8c7dc
change-id: 20250616-netdevsim-typo-fix-6e5e3113f49b

Best regards,
--
Dave Marquardt <davemarq@linux.ibm.com>
-- 
Dave Marquardt <davemarq@linux.ibm.com>



