Return-Path: <netdev+bounces-171807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38315A4EC43
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 19:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6161E18800CD
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 18:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9491A260374;
	Tue,  4 Mar 2025 18:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uE3U1BLh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE9825F988;
	Tue,  4 Mar 2025 18:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741113450; cv=none; b=HfwjDPctx6n0XndHPlaBa9JDoB5NIyJ+dlbtv5ZxxzPsFSoiM6aLFPIB+NAEsmrCRcMLebScWkJRXvq62xTaSN49zDYGsxkhp9Qysv1+mvDM+zarsnEyq3ymRjzaueXnj3/3KsOQBKuK5GrF/DUD/avYUcnHAo/J9q1EeADZQ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741113450; c=relaxed/simple;
	bh=Bw/dVSTLK7luxcPDdZYBYiUmYtXIgw/tfsWJ50AcuGA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Yu5Qm/kdrBT2L63v7kzbaGqyAN+DDouR8QDf5viNyUF5znA2RpBsQeYEQZJyzNkEkecrm3nzkJGVFlIR6bVREv1Tiuvfzp73JgLzVlsJil69RjSZC+7fiZNhqUrzoAL6QPl+WGrNyCv4dLA1sHWkh8rIOglIi4cGvvnICchF8+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uE3U1BLh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D69A4C4CEE5;
	Tue,  4 Mar 2025 18:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741113449;
	bh=Bw/dVSTLK7luxcPDdZYBYiUmYtXIgw/tfsWJ50AcuGA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=uE3U1BLhEOuwLaxVg+JZG5XKsSSfP1T2pUF+zZHJRr1BN3MstaP5V99m1NQUx7j02
	 cJjKefiFfAxALJtPhY7l3KU3O3QGJ1KT4uZO2DiXvfId13hxWf/z1//86Q2JtPcL3R
	 AJIrGib9bOsFvzw4Veq7vGhB5pKmUDDiq8lhTrJWwYKxX184nKuoF6XVYgVi1UngCB
	 COXwJk+qV+sHq2+CHeyrAxXLkiqcHlGN+0bXAf0ytVF63He8/coEgyiPBBNMuby33S
	 YTbQOP3gI7GDgjxWIxnV548jeOhwLj11LSKRwkCT0V1vDsHix0K+cF9zdRfHQbhIq7
	 8sGU7rkCUy/Og==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3624C282D9;
	Tue,  4 Mar 2025 18:37:29 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Subject: [PATCH net-next v2 0/2] net: phy: tja11xx: add support for
 TJA1102S
Date: Tue, 04 Mar 2025 19:37:25 +0100
Message-Id: <20250304-tja1102s-support-v2-0-cd3e61ab920f@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGVIx2cC/3WNQQ6CMBBFr0Jm7ZhpCyisvIdhgWWUMdqSthIM4
 e427F2+vPz3V4gchCO0xQqBZ4niXQZ9KMCOvXswypAZNOmKDBlMz14p0hHjZ5p8SFgZXZ+s4ma
 wJeTZFPguy568guOEjpcEXTajxOTDd/+a1e7/Z2eFhOpM3JSVaWqmy0v4NnIIR+vf0G3b9gP0m
 GUJvQAAAA==
X-Change-ID: 20250303-tja1102s-support-53267c1e9dc4
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>, Marek Vasut <marex@denx.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741113448; l=746;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=Bw/dVSTLK7luxcPDdZYBYiUmYtXIgw/tfsWJ50AcuGA=;
 b=Lzb7ZvTFLeQN9Nzmki4hto+FnxiU8s/DQkQenhhoHerRNaslxzIRqEOGw3vcesOTL4i2oe3KD
 4uGh0FLyG+PAddTFUCm3rw3b1I76uKesd9t+x87abubgFa4kWbW0pOl
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

- add support for TJA1102S
- enable PHY in sleep mode for TJA1102S

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
Changes in v2:
- Drop fallthrough tja11xx_config_init
- Address net-next
- Link to v1: https://lore.kernel.org/r/20250303-tja1102s-support-v1-0-180e945396e0@liebherr.com

---
Dimitri Fedrau (2):
      net: phy: tja11xx: add support for TJA1102S
      net: phy: tja11xx: enable PHY in sleep mode for TJA1102S

 drivers/net/phy/nxp-tja11xx.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
---
base-commit: f77f12010f67259bd0e1ad18877ed27c721b627a
change-id: 20250303-tja1102s-support-53267c1e9dc4

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>



