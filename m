Return-Path: <netdev+bounces-246277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FA1CE8073
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 20:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9ED123002D48
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 19:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2B8273803;
	Mon, 29 Dec 2025 19:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDD0DYKd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FA33C17;
	Mon, 29 Dec 2025 19:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767035870; cv=none; b=POGtd5R+T5UHYbnl6fEdrsZAUO92onnAfy5e3GWItdTVyoNljpnCCbZD2XlcBLFKgotQyXa8FVDnhZBV+t+XuWri5psNYbsG0HoupzhKlwUlu33gIjeHQDdDUwNfmkGuTZ2FsEaDEBZ4hwDVXHWC/qIu2r0LR8B0YFaUFKn0deE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767035870; c=relaxed/simple;
	bh=zdlHc9b8U/eLbV40R8AjoSBbW+do0gV1EArSnhErV2k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=j1jp6tPv9Fs9ZxaCltDGUzpz6yKfDLWwZIZJyR4nK4P+WD/SMca+EWfILBK51yLJsWZk2dKXJii+xN27FCvixPZ6jtixYrK7GoIMiLsBqAXBnialwVvywQH2QfrfEH51HvQuT8JhEYjwINm/JlwTcFHWdr0mxy58jFI7sFmYIcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDD0DYKd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB3EC4CEF7;
	Mon, 29 Dec 2025 19:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767035870;
	bh=zdlHc9b8U/eLbV40R8AjoSBbW+do0gV1EArSnhErV2k=;
	h=From:Subject:Date:To:Cc:From;
	b=bDD0DYKddFO9t4bNWL3dHmtzIF2wveGBSz+wSIKQYJbNBiZH9y01pSdBj+XgACWgQ
	 e2QdH9VWV+ecyvZKvhl6fVdJXfWcOcnbHVoZa3wJpn2O6pNTS09aaOEfFH8O9rfGMP
	 mVDh98XVeec2Xd9phjy1VdHvrB2fxxl7Mj4ubSr7qSr3HgXoXZSRo4gj/XlcbR5GdJ
	 uXmeJJFzgqvy4S1QsPC0mAgwX6g0BJYbAQZk1eC89ofqJVknL6mBx7ocS7/nmfQ9sf
	 ghvpd4EaCukL0S/9XindaXUyblacRVYbKcMu66CbtL4xv3+nkxB/bgUGotJ3hXZ7/o
	 rtQThsQZ09ByQ==
From: Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH 0/2] net: stmmac: socfpga: support both stmmaceth-ocp and
 ahb reset names
Date: Mon, 29 Dec 2025 13:17:17 -0600
Message-Id: <20251229-remove_ocp-v1-0-594294e04bd4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL3TUmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDIyNL3aLU3Pyy1Pj85AJdExNzCzNjC8skA1MjJaCGgqLUtMwKsGHRsbW
 1AM0q3YdcAAAA
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Mamta Shukla <mamta.shukla@leica-geosystems.com>, 
 Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: bsp-development.geo@leica-geosystems.com, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1395; i=dinguyen@kernel.org;
 h=from:subject:message-id; bh=zdlHc9b8U/eLbV40R8AjoSBbW+do0gV1EArSnhErV2k=;
 b=owEBbQKS/ZANAwAKARmUBAuBoyj0AcsmYgBpUtPajPcHRktCl6d3QxwkIhZ2Lk0tQNNBHtOPl
 Q3EviyokIWJAjMEAAEKAB0WIQSgeEx6LKTlWbBUzA0ZlAQLgaMo9AUCaVLT2gAKCRAZlAQLgaMo
 9LCLD/0dyo8tDOFsr5e4FSCd3GNSLC5hPyhi3YsYZiPc8K5/kuipShDEByFZEZfLsmtCL3qJ940
 rmb+v5MOeZstGprn3+5KqWB9aUBb3khGtscPgBVVHUNxLglJKpJ0HR8RBx8fi3FkZs2XIfOcLxl
 kFhEYoq4h8wW1z0kbp+aVMghyNWyk0Yd0HXj1hGm/7d28pmlxjUFtCrxmvt6g2FsIdG0qcnZb0U
 MDIln98k0VRZKUjCKC2Gx8edz9YzqlEDQImBbsDsd9p1ZsT1+4x+ucbki3ZpdrtVANkuCFHw+q1
 ZcaHV7RHyhSlwBiP9dSGlT8GTI4n30MzhAVPJnCNuyQRr4jis6Rrruzhcqi4PkawiXw+d/68Oh+
 pBLbjOhGR6N3I4les/6kj87AF1AwnBII2JyUglCGQY4aH+unaHaH8VDbVAPa03NjahGDCiyc0eS
 OFrMhs8sdiiirc9QbfeLNPsPic7Bby8PVN6qfIhwySgnDLiiQ/TaaQJHpMmuo0ILLB1kwGv9opy
 OqYv/Yenr1apVZYhPsEe6CfOYtlodgZA2tghefVcmOLUWfJq37AoqKl+vBg9tj+3u+x7b6A6JVb
 92PuCM8HsMIucn+py1BrXnyK0bSqlNeSTohJfbZbzZWgUCgi7tQrEv8rPJmOPo8tgSu4SIoWrPa
 Pq5NyQ5Mc372zCg==
X-Developer-Key: i=dinguyen@kernel.org; a=openpgp;
 fpr=A0784C7A2CA4E559B054CC0D1994040B81A328F4

The dwmac-socfpga stmmac ethernet controller supports 2 standard reset
lines, named "stmmaceth" and "stmmaceth-ocp". At the time of upstreaming
support for the platform, the "stmmaceth-ocp" name was used for the 2nd
reset name. We later realized that the "stmmaceth-ocp" reset name is
the same as the "ahb" name that is used by the standard stmmac driver.
But since the "stmmaceth-ocp" name support has already been introduced
to the wild, it cannot just be removed from the driver, thus we can
modify the driver to support both "stmmaceth-ocp" and "ahb", with the
idea that "ahb" will be used going forward.

This series add the support to call reset assert/de-assert both "abh"
and "stmmaceth-ocp" to the dwmac-socfpga platform driver, then reverts
the patch that uses the DTS "stmmaceth-ocp" reset name.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
Dinh Nguyen (2):
      net: stmmac: socfpga: add call to assert/deassert ahb reset line
      Revert "arm: dts: socfpga: use reset-name "stmmaceth-ocp" instead of "ahb""

 arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi | 6 +++---
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c  | 4 ++++
 2 files changed, 7 insertions(+), 3 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251229-remove_ocp-44786389b052

Best regards,
-- 
Dinh Nguyen <dinguyen@kernel.org>


