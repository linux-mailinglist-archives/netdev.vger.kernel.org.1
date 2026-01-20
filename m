Return-Path: <netdev+bounces-251437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C150D3C5A7
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 11:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8514E6A83DA
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 10:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20D83D7D9F;
	Tue, 20 Jan 2026 10:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyvlNeeD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B013D7D8C;
	Tue, 20 Jan 2026 10:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768904270; cv=none; b=ArRD18E6t0mYJpYM5FcVBm5Mmm5gNE7Kam/mONPwFFMIqCdYc5TNOND+Y722tI4aCPKDEn6SzCaKXcOE7jK73WHmxmLQpgLj+kpl8JeUEgNnxcnGoJj4Z+kTFLohlU1+t1dtgXrmg7EEBYy5/Jt5idY7ElF96K36NB8IAWujPpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768904270; c=relaxed/simple;
	bh=KO+K1i+AhFEyWElV5V29fhgrpXDoQ8qehhOTJGwc4xo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=L+uJN5rvaKfIEJmZYptE8esu9A4j0bOdhfbqi1/OkrfFkIFdizMK9KIh9P6OvRIhuK8wy0nfKvLH7sNNopMur05EXjPYcB4MSF8sdTgAOwD3BNnjBtEvbvCdBkiJcMp4KOuuZyCAQFThtWuNmEQuAiL7J8EYO6aSvnlBxeve/00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyvlNeeD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94BFDC16AAE;
	Tue, 20 Jan 2026 10:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768904270;
	bh=KO+K1i+AhFEyWElV5V29fhgrpXDoQ8qehhOTJGwc4xo=;
	h=From:Subject:Date:To:Cc:From;
	b=AyvlNeeD+z+5r8oFKfnkDh7hAQc96IEoFclF/RDuQ+bgidBpDJePKCFT60rvyEU0E
	 oSaYX6yvovRPTlJYAdzhdpfq2Eym4jxiVuqPNMR/F+9mWkI8vW8z79Ct7EVW8d/OVj
	 HEeF0RGAhwg18nxls4K0MkE3R5pekCj7QEMkV995NUu9LainqMTzd56rTOfV4rMbqB
	 heIGUM9s5mf5Atk7gn4mVLIv18nIHag11G/VPmmI3zk91Oy7nK/g6649HdjwZQLd2y
	 3yFR+tACAS8OS4ik+X3aEnDySKldljelZeUx9ePgYELGP1Z+SITVBtlEaJav9XNUH7
	 X+ClNHFRbAUng==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v4 0/2] airoha: Add the capability to read
 firmware binary names from dts for Airoha NPU driver
Date: Tue, 20 Jan 2026 11:17:16 +0100
Message-Id: <20260120-airoha-npu-firmware-name-v4-0-88999628b4c1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NQQ6CMBCF4auYrq2ZThHRlfcwLko7SKMWMlXUE
 O5uIS40Rpf/S+abXkRiT1FsZr1g6nz0TUiRzWfC1iYcSHqXWiBgDgpW0nhuaiNDe5WV5/PNMMl
 gziR1RksANMroSqTzlqny94ne7VPXPl4afkyfOjWuL1Thb7RTEqSDUmVFma8UVNsjcaDTouGDG
 NUO3yX9R8IkYWFL7VADQv4l6Xdp/UfSSbKlKQoit86t/ZCGYXgCRbU9EFUBAAA=
X-Change-ID: 20260107-airoha-npu-firmware-name-34e5002a1a3f
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Andrew Lunn <andrew@lunn.ch>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2

This patch is needed because NPU firmware binaries are board specific since
they depend on the MediaTek WiFi chip used on the board (e.g. MT7996 or
MT7992). This is a preliminary patch to enable MT76 NPU offloading if
the Airoha SoC is equipped with MT7996 (Eagle) WiFi chipset.

---
Changes in v4:
- Add missing MODULE_FIRMWARE definitions for EN7581_7996_FIRMWARE
  binaries
- Link to v3: https://lore.kernel.org/r/20260119-airoha-npu-firmware-name-v3-0-cba88eed96cc@kernel.org

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
 drivers/net/ethernet/airoha/airoha_npu.c           | 46 +++++++++++++++++++---
 2 files changed, 47 insertions(+), 6 deletions(-)
---
base-commit: 4515ec4ad58a37e70a9e1256c0b993958c9b7497
change-id: 20260107-airoha-npu-firmware-name-34e5002a1a3f

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


