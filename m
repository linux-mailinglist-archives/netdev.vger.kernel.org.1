Return-Path: <netdev+bounces-145386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DCE9CF55B
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 20:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38D24B2BC14
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 19:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79AF1E1A34;
	Fri, 15 Nov 2024 19:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+jJoLYn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978771E103B;
	Fri, 15 Nov 2024 19:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731700571; cv=none; b=RnBjPySloum5ETugqCKL3EQuw9WCHVg/I/31Er1PfqyjSNwDoC8D3g6pihL4QgE/vJ4Gq85A2KA8e43rtlvgSShILlwbeqoDuQyg5sRhqMNNFY450swiBCFpdm9/PFtXWaBzn0Z9emmAtFXLmQpsjAV6RGAI0USIIo4XFM0LxYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731700571; c=relaxed/simple;
	bh=M3Rvlnnvu5tf1XE6B9A9tOdxKMsJHXuAf/M4yoGhRS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N7vDFClq0i0v7aDU44V/grRQyEfTterguJl4q/5MF2vicpmkl73j/SuyxCijAFLpKZntVEpCioKcaMZV19W3D2oiEwfqR9PRHgPXOQ+BiKNa2UxKyvMx0B/bVqYhtpRFWRDOvCwfPmGzwXD7dHj70KsHo0yBa7uQHm01H/kwXV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+jJoLYn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6ACBC4CECF;
	Fri, 15 Nov 2024 19:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731700571;
	bh=M3Rvlnnvu5tf1XE6B9A9tOdxKMsJHXuAf/M4yoGhRS0=;
	h=From:To:Cc:Subject:Date:From;
	b=I+jJoLYn55rJ8b4VaXSRLp5CHZqVn9jtSxhkMfH9Ikh+pCozMXzJt/XxBTmqrDQGM
	 50GGfxfRDS8Fz6Q2QfLXrKSP1X8wz2sMbHOjEm5cfqf2WAQGL4WpgEk0yjTww9rlow
	 PcN5VQDM1Uc0yf1XTZh4aOijx5U4ldWQj0rN9h2l3zwOW9qxOUakDhQ1mX7clIL/rM
	 rJcboU7c4cE5Noq8ICLF9SNyV2VXrZLItYzEpZv29JcmymhKcwnj3bi6Jjbc5XrpHV
	 3W4fYomWk4B9BrqH8+QnUcb8Ulef3ltD1sA8eLep7Ci/STT9JrYbCadORJRMpCWK6F
	 e9ZEJeze77fnA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	linux-can@vger.kernel.org
Subject: [PATCH net] MAINTAINERS: exclude can core, drivers and DT bindings from netdev ML
Date: Fri, 15 Nov 2024 11:56:09 -0800
Message-ID: <20241115195609.981049-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CAN networking and drivers are maintained by Marc, Oliver and Vincent.
Marc sends us already pull requests with reviewed and validated code.
Exclude the CAN patch postings from the netdev@ mailing list to lower
the patch volume there.

Link: https://lore.kernel.org/20241113193709.395c18b0@kernel.org
Acked-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: Oliver Hartkopp <socketcan@hartkopp.net>
CC: linux-can@vger.kernel.org
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1c80c1a33567..9b466e76cdb3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16103,7 +16103,9 @@ F:	include/uapi/linux/net_shaper.h
 F:	include/uapi/linux/netdev*
 F:	tools/testing/selftests/drivers/net/
 X:	Documentation/devicetree/bindings/net/bluetooth/
+X:	Documentation/devicetree/bindings/net/can/
 X:	Documentation/devicetree/bindings/net/wireless/
+X:	drivers/net/can/
 X:	drivers/net/wireless/
 
 NETWORKING DRIVERS (WIRELESS)
@@ -16192,6 +16194,7 @@ X:	include/net/mac80211.h
 X:	include/net/wext.h
 X:	net/9p/
 X:	net/bluetooth/
+X:	net/can/
 X:	net/mac80211/
 X:	net/rfkill/
 X:	net/wireless/
-- 
2.47.0


