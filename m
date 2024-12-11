Return-Path: <netdev+bounces-151018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9209EC681
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 09:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38BC71886C88
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 08:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FFB1CCEE2;
	Wed, 11 Dec 2024 08:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9urXzK1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BF81C5F03;
	Wed, 11 Dec 2024 08:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904293; cv=none; b=hq8f8HBHwPoJhS7QpXB81BDqlb/boZF+F9H98fKpa2aWTiDaAVm04svZvnPXpAEiQp1JYLHnLsmBR0YLF4lRDeYUS9zLBy37G7zLPFm2zei1mZdruXQrDxhjtpKpbupIi6UJyFUMyQ1KokXyF05czFxFHo6DIZ2YkuWD2hvgPDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904293; c=relaxed/simple;
	bh=ZzbxjgecJ8fa0v+feo6S6Xx4k2fRvoVfmSCJajpyxHQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BjCiOUTVcKvOglL9WAGDspNurOAQF96mtG35enH5wG6YTOec3OQBEo4eTL8qNcFYFKzDEWk3MuTwZaiAH2TlguElSn5Cf2oLwgekYrLopv5c4urt4lxOvXAEcJQdhPcjwLyRpuP3IXzx/+pzFkcWDXKV1P/XaaNC3TzYjL5kta0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9urXzK1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35F9AC4CED2;
	Wed, 11 Dec 2024 08:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733904293;
	bh=ZzbxjgecJ8fa0v+feo6S6Xx4k2fRvoVfmSCJajpyxHQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=s9urXzK18UZQl3ofNAqQNQRgp8K5Z1nZcmAdq7v6AT8DUKGlQj/d6rUp48BHdNNUP
	 Eou/xv68miRLQYxeIR4p1bRKGltEGvqOxVW5lNUBe/neoYNQOtrLsn+7yKU7CXNV3S
	 W+/xPyCwI9Syqgm4UADksGPAHCPh4fjhzAENw0ECysujRJ+R2Xk329h+JjTekSOUE1
	 AZo0z8WNpsXR5pUngx/00Qa8i7aOJQ+rV+DKDff9Nf69pnBGT8tQqk/VFOVSKA8mPh
	 0q7p9POpQc9U/aeJf580wke65W+6exQk9+vZKJstxkghLbwPd8pm1/swp4YMlbD46h
	 VaB15h2WHEDsA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A487E7717D;
	Wed, 11 Dec 2024 08:04:53 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Subject: [PATCH net-next v2 0/2] net: phy: dp83822: Add support for GPIO2
 clock output
Date: Wed, 11 Dec 2024 09:04:38 +0100
Message-Id: <20241211-dp83822-gpio2-clk-out-v2-0-614a54f6acab@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJZHWWcC/3WNQQ6CMBBFr0Jm7RhoBYGV9zAssJ3CRGxJWwmGc
 Hcb4tbly8t/f4NAnilAm23gaeHAziYQpwzU2NuBkHViELm4FCKvUM+1rIXAYWYnUE1PdO+ISjf
 KVJLkVRtI29mT4fXo3sFSREtrhC6ZkUN0/nMcLsXhf+3mT3spMEejpap7UzbGlLeJ6TGS92flX
 tDt+/4FEX7aKMcAAAA=
X-Change-ID: 20241206-dp83822-gpio2-clk-out-cd9cf63e37df
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733904292; l=1344;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=ZzbxjgecJ8fa0v+feo6S6Xx4k2fRvoVfmSCJajpyxHQ=;
 b=sNlY2EfgzLwGNb75JNVptc++ZJf3vlOpn5gLzzjBlNAnNB4zy2Al0D50jxbE8q+7pR6VXf+3W
 T/iOfzIr1arBmYAzRZpt/FjSEXBERck4PI0DR0BuQAOLyIMTPfACQMB
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

The DP83822 has several clock configuration options for pins GPIO1, GPIO2
and GPIO3. Clock options include:
  - MAC IF clock
  - XI clock
  - Free-Running clock
  - Recovered clock
This patch adds support for GPIO2, the support for GPIO1 and GPIO3 can be
easily added if needed. Code and device tree bindings are derived from
dp83867 which has a similar feature.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
Changes in v2:
- Move MII_DP83822_IOCTRL2 before MII_DP83822_GENCFG
- List case statements together, and have one break at the end.
- Move dp83822->set_gpio2_clk_out = true at the end of the validation
- Link to v1: https://lore.kernel.org/r/20241209-dp83822-gpio2-clk-out-v1-0-fd3c8af59ff5@liebherr.com

---
Dimitri Fedrau (2):
      dt-bindings: net: dp83822: Add support for GPIO2 clock output
      net: phy: dp83822: Add support for GPIO2 clock output

 .../devicetree/bindings/net/ti,dp83822.yaml        |  7 ++++
 drivers/net/phy/dp83822.c                          | 40 ++++++++++++++++++++++
 include/dt-bindings/net/ti-dp83822.h               | 21 ++++++++++++
 3 files changed, 68 insertions(+)
---
base-commit: 65fb414c93f486cef5408951350f20552113abd0
change-id: 20241206-dp83822-gpio2-clk-out-cd9cf63e37df

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>



