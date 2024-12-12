Return-Path: <netdev+bounces-151320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 406439EE1A5
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 09:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDE1E283221
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 08:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405FC20E00A;
	Thu, 12 Dec 2024 08:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UY+lLJN8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8A120DD77;
	Thu, 12 Dec 2024 08:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733993057; cv=none; b=kR0iiY8t6pJEvHslwkRKjrd8IQEm4/uNdnsxrI8JxZ4KzkOantmvh09HmYwfFYS+fxiOpGL+4DAMuvUrdEbB2MJZaYbVK+Ekd0WJdy8KUsfvnyc4rakHgC61X8MuCLktOFrGo86pD36wty5BEWGlzFHshNz32BS9KP7tIFRNVvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733993057; c=relaxed/simple;
	bh=BsCgYFZcnDgVtF99wPIkB0aPEfMbStFx+F00Xk/qQfg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EWcMQue95Y8QmARuUppZ1Smm5Ukj6T9Z+bJqV27WN/gd6EEDf5N+AdIOG0gLzBOkKiFZ3ONowESz/FuVqMsPuusALHCHnRCfn+rQzxdXLgKznGMnDXBshj3LNYxTJjqFmofujIy3oGNQIgbWN7ubdPA/cxaFkKz4Cf7BUV8V9b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UY+lLJN8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BADD3C4CED1;
	Thu, 12 Dec 2024 08:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733993056;
	bh=BsCgYFZcnDgVtF99wPIkB0aPEfMbStFx+F00Xk/qQfg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=UY+lLJN8wjdd28yefr6xtu7mrW1prG6HvqLDD5jVqU4X+SZW3luhIKOSpIh7nE1P6
	 VBGe2lYUJZC3zHpR+eOGBx9kIcRtXZxqQtMQxwvwkJ3LKy1/DSCYnID+wzJUGz4rl8
	 5ES9Ki0L4ZW3+orfdcWrlTctcI3SLGt5X89qxANAE52M/Laab7bDoywMGP9on7M1po
	 X7xQ1baIpMYkQUbRAOuxRI1yAkTtPWFjXe3rsRSX5O1wu58MXEGttCnaWHbE4A9wu7
	 E369NtGVMe/TGAY3VtuaBWdAjKbfGs+iwQqf5dCnLoP8l8u1F7nTjUmUSArIszWiG0
	 nlCQ6ZxN28lYQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A874EE7717F;
	Thu, 12 Dec 2024 08:44:16 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Subject: [PATCH net-next v3 0/2] net: phy: dp83822: Add support for GPIO2
 clock output
Date: Thu, 12 Dec 2024 09:44:05 +0100
Message-Id: <20241212-dp83822-gpio2-clk-out-v3-0-e4af23490f44@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFWiWmcC/3XN0Q6CIBgF4FdxXPc3ASXtqvdoXSD8KKvEgTGb8
 91jrIvW5uXZ2fnOSgJ6i4Gci5V4jDZYN6bADwVRgxx7BKtTJqxkFWWlAD01vGEM+sk6BupxB/e
 aQelWGcGRn7QhaTt5NHbJ7pWMOMOIy0xuqRlsmJ1/58NIc/+12x07UijBaK4aaerWmPrysNgN6
 P1RuWdGI/uBKN2DWIIErWRdGSGV7P6gbds+04fsRBABAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733993055; l=1627;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=BsCgYFZcnDgVtF99wPIkB0aPEfMbStFx+F00Xk/qQfg=;
 b=arNm8HpkQ/hNROhZaSL+MMtw3sgiZkb8Qqo0ATyNiD2tTdFWk+9DFb2cOnueh7L75oYQ+pWx4
 tyQZYnbO/b5B5xUD1aEn9N27qvWhFxGoOo32jX6r1QBw4n0oGsINntf
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
Changes in v3:
- Dropped <dt-bindings/net/ti-dp83822.h>
- Moved defines from <dt-bindings/net/ti-dp83822.h> to dp83822.c
- Switched to enum of type string for property ti,gpio2-clk-out and added
  explanation for values, added example.
- Link to v2: https://lore.kernel.org/r/20241211-dp83822-gpio2-clk-out-v2-0-614a54f6acab@liebherr.com

Changes in v2:
- Move MII_DP83822_IOCTRL2 before MII_DP83822_GENCFG
- List case statements together, and have one break at the end.
- Move dp83822->set_gpio2_clk_out = true at the end of the validation
- Link to v1: https://lore.kernel.org/r/20241209-dp83822-gpio2-clk-out-v1-0-fd3c8af59ff5@liebherr.com

---
Dimitri Fedrau (2):
      dt-bindings: net: dp83822: Add support for GPIO2 clock output
      net: phy: dp83822: Add support for GPIO2 clock output

 .../devicetree/bindings/net/ti,dp83822.yaml        | 27 ++++++++++++
 drivers/net/phy/dp83822.c                          | 48 ++++++++++++++++++++++
 2 files changed, 75 insertions(+)
---
base-commit: 65fb414c93f486cef5408951350f20552113abd0
change-id: 20241206-dp83822-gpio2-clk-out-cd9cf63e37df

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>



