Return-Path: <netdev+bounces-228726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB27BD3508
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 15:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 306E14F28C2
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 13:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C01238176;
	Mon, 13 Oct 2025 13:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQqCuYvi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A552367DF;
	Mon, 13 Oct 2025 13:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760363950; cv=none; b=m5cNznq3PXfeOfE68+rDlkFft7qsyiMZBukMe1xQcruRA2aiMrk8iB0yGfjWQotcPoNLyjG3X+mLBmr6QK925ZNQWxw/IbBoyvdKCo1FXzL0Fc1tW0Nx8JwW/IfdZoeH0IEhZKRfjlNV5hufBosmGuvoq4EJCVUiw3zUmSYNLSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760363950; c=relaxed/simple;
	bh=OQF+uf4SEvxYvmb15IWXMVY/5y/3pewqBdXN6tQkC3E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dcKMuEctzbJ3wkgs2N+Mt84aOvFQkaqttlUp1lAyZPhHUU/PhXcC8ERU/mQhzWn1rjueYdKe4vtg4ze6TsZ6kbighiNoouXDb9WxW8gYPpsMcKdD92LVUTpGoOtT/CsQvQYb/BLfXEKxdtWG1CgFEGdTchNp0J5LXl7B8kpMuOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQqCuYvi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A45C4CEE7;
	Mon, 13 Oct 2025 13:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760363950;
	bh=OQF+uf4SEvxYvmb15IWXMVY/5y/3pewqBdXN6tQkC3E=;
	h=From:Subject:Date:To:Cc:From;
	b=AQqCuYviYzysF6VFw8wkJCpJZyED/68w5OqTamcwnD8W5K5DbDVqXZJMEw8NTGfLF
	 a4d0BW2V9f4/ydg4/aJfUI//r1Wi1Lc6dmRFlIi45SG+HY5LBimIH4rVtTG0OYAkzo
	 6YJzoOIm7nB3Jr40jzeHR6h1lcT1e56pFUeqfaRnwfn6lw2r2ZYu3Ftoyedjg0X6oI
	 nBJ95LN4uXtUcMmMQRd38ng+bZXBVVd8mBwBFWGGn9uIcS26nVNsxqTKkaufmXFB4l
	 dV9MN4sGeVyuhJRAUlfOVIFtV5v/28o1C64gviMETafaD6M0f5MlRyraX8aQJqMioa
	 Lg5KPq0udO5Fg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v3 0/3] net: airoha: npu: Introduce support for
 Airoha 7583 NPU
Date: Mon, 13 Oct 2025 15:58:48 +0200
Message-Id: <20251013-airoha-npu-7583-v3-0-00f748b5a0c7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJgF7WgC/3XNTQrCMBCG4auUWRvJf6sr7yEuQjppg5KURINSe
 nfTrhRx+X4wz8yQMXnMcGxmSFh89jHUELsG7GjCgMT3tYFTruiBa2J8iqMhYXqQVnWCaIGSCcq
 0lhbq1ZTQ+ecmni+1R5/vMb22B4Wt63+rMEKJlC0q5L2jXX+6Ygp428c0wIoV/gm0vwCvADLuj
 FXWInNfwLIsb/u+z6XwAAAA
X-Change-ID: 20250926-airoha-npu-7583-63e41301664c
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2

Introduce support for Airoha 7583 SoC NPU.

---
Changes in v3:
- Rebase on top of net-next
- Link to v2: https://lore.kernel.org/r/20250927-airoha-npu-7583-v2-0-e12fac5cce1f@kernel.org

Changes in v2:
- Introduce airoha_npu_soc_data struct and generalize firmware load
- Link to v1: https://lore.kernel.org/r/20250926-airoha-npu-7583-v1-0-447e5e2df08d@kernel.org

---
Lorenzo Bianconi (3):
      dt-bindings: net: airoha: npu: Add AN7583 support
      net: airoha: npu: Add airoha_npu_soc_data struct
      net: airoha: npu: Add 7583 SoC support

 .../devicetree/bindings/net/airoha,en7581-npu.yaml |  1 +
 drivers/net/ethernet/airoha/airoha_npu.c           | 93 ++++++++++++++++------
 2 files changed, 68 insertions(+), 26 deletions(-)
---
base-commit: 18a7e218cfcdca6666e1f7356533e4c988780b57
change-id: 20250926-airoha-npu-7583-63e41301664c

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


