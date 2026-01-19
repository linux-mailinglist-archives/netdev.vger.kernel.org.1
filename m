Return-Path: <netdev+bounces-251162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F329BD3AF15
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 16:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0071D3006470
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56015275AE3;
	Mon, 19 Jan 2026 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpN06rJV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3299F233128;
	Mon, 19 Jan 2026 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768836785; cv=none; b=Gg3MAd7x3W9BLo8ljb5qciuB7qxaoCHlTNYfHGmKaONCSswCz9r7zr38CxioftPUj+9q5537M0BOxd5SEyHo03lXWY5jbQJbO13UsyA7x/yXijUIvq3OnIyA2+wYFY01eRMXnzi5i4FOxexP9uWerLhlqefy1UEi8V+fMmbx2/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768836785; c=relaxed/simple;
	bh=qCOlgkLkBdIOO3vDqA1UxzM+1Hg8d2IVWg/s4RzhgoI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=k3mNUH/M1MnidTxo0v8dHbkjr0UG7xHGFdkIhw56p7xxuwGBmm8niN09MRKTwZyOvK9qea3V1vkmruybyJmcn+HIgm8OhyNNwD186kdsNfW48NuYap109aFDTjBMKcma/Fmez7OY3VwsXfpAzvGUyg+ZN2Psj9wyiAPY8Km+g0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XpN06rJV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68535C116C6;
	Mon, 19 Jan 2026 15:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768836784;
	bh=qCOlgkLkBdIOO3vDqA1UxzM+1Hg8d2IVWg/s4RzhgoI=;
	h=From:Subject:Date:To:Cc:From;
	b=XpN06rJVi7+SvkWosx9xeQnxKLhUcZJ72DnQjIdXkU1eQ8Z+C5bJDAzfHqDm22jre
	 73wvZWs3v8+SmRW7J5e0bGrHHe0sn53anNLctBNXWSwy33i9n7vd+7MP4MAsIVGdLO
	 GkQg0qlURR9ZiqGJfMZ/yVzxvtYFslxk05FKj8ob5yl+rr2QGoEAUEtZefD7yEdsXQ
	 8LvfQgL0mhUslduSbsnha7g5X+xhT/dwLMtHCeq+lrgSTpFc5wlnAFR1whD9hCLUZ0
	 IqGo6OxpPEf5w0alHlRv1ruCTluliBU9uajmFzQZOoiOcYap0yF9NU26P8xUQ8nYes
	 FDETolMeEDdzA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v3 0/2] airoha: Add the capability to read
 firmware binary names from dts for Airoha NPU driver
Date: Mon, 19 Jan 2026 16:32:39 +0100
Message-Id: <20260119-airoha-npu-firmware-name-v3-0-cba88eed96cc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NQQ6CMBCF4auQrq2ZThGIK+9hXBSYQqMUMmjVE
 O5uIS50ocv/JfPNJEZiR6PYJ5NgCm50vY+hN4moWuMbkq6OLRAwAwW5NI771kg/3KR13N0Nk/S
 mI6lT2gGgUUZbEc8HJuseK308xW7deO35uX4KalnfqMLfaFASZA2lSosyyxXYw5nY02XbcyMWN
 eCnpP9IGCUsqlLXqAEh+5LmeX4BTtcbywsBAAA=
X-Change-ID: 20260107-airoha-npu-firmware-name-34e5002a1a3f
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2

This patch is needed because NPU firmware binaries are board specific since
they depend on the MediaTek WiFi chip used on the board (e.g. MT7996 or
MT7992). This is a preliminary patch to enable MT76 NPU offloading if
the Airoha SoC is equipped with MT7996 (Eagle) WiFi chipset.

---
Changes in v3:
- Roll-back to approach proposed in v1 using firmware-name property
- Link to v2: https://lore.kernel.org/r/20260113-airoha-npu-firmware-name-v2-0-28cb3d230206@kernel.org

Changes in v2:
- Introduce "airoha,en7581-npu-7996" compatible string to specify the
  firmware and drop "firmware-name" property
- Link to v1: https://lore.kernel.org/r/20260112-airoha-npu-firmware-name-v1-0-d0b148b6710f@kernel.org

---
Lorenzo Bianconi (2):
      dt-bindings: net: airoha: npu: Add firmware-name property
      net: airoha: npu: Add the capability to read firmware names from dts

 .../devicetree/bindings/net/airoha,en7581-npu.yaml |  7 ++++
 drivers/net/ethernet/airoha/airoha_npu.c           | 42 ++++++++++++++++++----
 2 files changed, 43 insertions(+), 6 deletions(-)
---
base-commit: b4e486e2c46f754a515571a8ca1238fa567396dd
change-id: 20260107-airoha-npu-firmware-name-34e5002a1a3f

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


