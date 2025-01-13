Return-Path: <netdev+bounces-157583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA43A0AED8
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 06:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A6953A7E0C
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 05:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E55230D39;
	Mon, 13 Jan 2025 05:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwVCTon5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F38C14A60C;
	Mon, 13 Jan 2025 05:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736746829; cv=none; b=ulw3lY8OHNznjbMSEBu/cCpeiJd99mBSX53dHod4kHmf7UQwoqOUK7GVBlBbKDbKTgJTlSOuFWyixKuyZFBWjHODYSSXMNIWrsA3TzA42FDd7dFjYwMbieBhZ0dyIj8uLaGnkfKfOGr/Swb653clc46fnBNlBc78OnAob3Sbz4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736746829; c=relaxed/simple;
	bh=CMktPUZ1l4ycL/1KVGf9E6EF7MwJYouBdAu3wr7LLjA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=toq1NPGHXE26kMD+Bbbg/AmrGoSWtaZwQ4uzL3qE0oZ38Y2fG9Ko7BMzdUcMGvsg05QbtrXQJSpE/Xiyg9SMmbewhDnOCgwHneO2AGmPjpa4fwv1SdjhrSjxP5LQbM0+NaYDncxJStbaHHCs2j3bSHyMDjqlQrMX88DUIznpO+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwVCTon5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10F69C4CED6;
	Mon, 13 Jan 2025 05:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736746829;
	bh=CMktPUZ1l4ycL/1KVGf9E6EF7MwJYouBdAu3wr7LLjA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=IwVCTon5m7hP4Rz8zrKCQVyYCzA1RZoRfcsFDsvQOFhc4uN6fv6dKfa0GHn14qa3N
	 WaDYUOcrKpl+siebNb9BUHGjQcNo0DKQ0hKmX9kv+RVqPfTb7AHEKEU87mMurq9sk3
	 kmVyhzPgzRrothjWNvmFk11R/aR0OY0JeI/YUOWQjYFY+K6LH4VZTv4k5elK2tZyvP
	 8PjEVhGXuAUO2VjqSsTnQdJ3Z0q+mi1AoCPYAdwwCuM3Bykqby9O2RD2BNXZWvxI4Z
	 Jf4yaH4iu176rGGPhraUNDlVA/MyNUr33MWL6wNvSzHA+TIOWsAxz9H4Na13NhDhlH
	 QLbtL6IliFPXA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F333DE7719E;
	Mon, 13 Jan 2025 05:40:28 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Subject: [PATCH net-next 0/2] net: phy: dp83822: Add support for changing
 the transmit amplitude voltage
Date: Mon, 13 Jan 2025 06:40:11 +0100
Message-Id: <20250113-dp83822-tx-swing-v1-0-7ed5a9d80010@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADunhGcC/x3MSQqAMAxA0atI1gZsHFCvIi4comYTpS1aKN7d4
 vIt/o/g2Ao76LMIlm9xcmqCyTNYjkl3RlmTgQqqDJkS16stWyL0Ad0jumM9T81iuJuLpoaUXZY
 3Cf9yAGWPysHD+L4fOXfUxGwAAAA=
X-Change-ID: 20241213-dp83822-tx-swing-5ba6c1e9b065
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736746828; l=741;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=CMktPUZ1l4ycL/1KVGf9E6EF7MwJYouBdAu3wr7LLjA=;
 b=dbdzM3ZZU5gwurgEXklNsudXAT9os5VxcfxqueqohybLOoAlKkQMczcH3GWhx81HDhTfM12J0
 CVwLo8xavb2C7mMy2kT2yYwmpNMvqCC3Sk4FX9E6BSwNKPPxtsW32D+
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

Add support for changing the transmit amplitude voltage in 100BASE-TX mode.
Add support for configuration via DT.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
Dimitri Fedrau (2):
      dt-bindings: net: dp83822: Add support for changing the transmit amplitude voltage
      net: phy: dp83822: Add support for changing the transmit amplitude voltage

 .../devicetree/bindings/net/ti,dp83822.yaml        | 11 +++++++
 drivers/net/phy/dp83822.c                          | 35 ++++++++++++++++++++++
 2 files changed, 46 insertions(+)
---
base-commit: 7d0da8f862340c5f42f0062b8560b8d0971a6ac4
change-id: 20241213-dp83822-tx-swing-5ba6c1e9b065

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>



