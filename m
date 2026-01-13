Return-Path: <netdev+bounces-249363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75581D1741C
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 09:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A23853075162
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 08:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE1937FF59;
	Tue, 13 Jan 2026 08:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfgZ2ADd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF6437FF43;
	Tue, 13 Jan 2026 08:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768292450; cv=none; b=bcZUEnl2bKz3Ivpl2miLwb4SPGF0lIhkiRd+EhbYDW5egcg11o7ELz4xIfKX94OchepfKsjuY01NzOWcBP9/8DC+MOYRN5/P5Ee9vi9fXS3NFSLzDPhVs2N517FNaqUo2wpPCNSLA52MzerF4zJHUpEoC4IUZqDILAZALeokaIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768292450; c=relaxed/simple;
	bh=i1Y5DZjciIYzsq+vPdVY9mHZmjo4XAc4nVfHVj1ap6Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AzyoY0NNb5pWaz9NAFD4yqcRbeDL+GxKehzNFx39aoZpRaREIMzq3xMNewtXTvqqS0Q/4Duw3pXJEXvNZT0lLF5YGhbrZ61hJAkY3Wx+YV2UZPSnx0lthunRP6c9hTI/SmDOExFKQuyfjGpMqOCH6ehh/YLj2spGtDuMpebcpGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfgZ2ADd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70ADAC19421;
	Tue, 13 Jan 2026 08:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768292450;
	bh=i1Y5DZjciIYzsq+vPdVY9mHZmjo4XAc4nVfHVj1ap6Y=;
	h=From:Subject:Date:To:Cc:From;
	b=RfgZ2ADdX4mp3904VOIWBrIYyUUskCFYCDkp3OdIPf01lkjme+pG5wX4HHPxiFR+C
	 v/iQ+FAs45BH1AhOx42vD7s8Qsrmezw8T/N/cxGCWyimRQrrjcfA9/dmiEj7XaonbN
	 c1OKcIEx5KxIX4HKpzYDHIjDMi+7VK9gyusKPoc8aug5hQp+GzYWnhxk1/SlCMgW7O
	 qLeMw6mIRgY6csOwFl2j45dyfTUo2AL5CyR8hp+mjDH3AvRRFebrCfo6T0b6cj2Z8s
	 fljMUTcZHIL3J7bjtAGYWMkze3KH9c46t26jCgOIvebVMX4S0Ht03f78fVr+ufDYPH
	 siQ4TNLxihYWw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v2 0/2] airoha: Add the en7581-npu-7996 support
Date: Tue, 13 Jan 2026 09:20:26 +0100
Message-Id: <20260113-airoha-npu-firmware-name-v2-0-28cb3d230206@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQ6CMBBFr0K6dsy0IBhX3MOwKDKFidKSqaKGc
 HcrcevyveS/v6hIwhTVKVuU0MyRg09gdpm6DNb3BNwlVgZNiRorsCxhsOCnBziW8WmFwNuRIC/
 ogGistrlTaT4JOX5t6XOTeOB4D/Lenmb9tb+oNv+jswaEDltdHNuy0ujqK4mn2z5Ir5p1XT/hz
 epFwQAAAA==
X-Change-ID: 20260107-airoha-npu-firmware-name-34e5002a1a3f
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2

This is a preliminary patch to enable MT76 NPU offloading for MT7996
(Eagle) chipset since it requires different binaries with respect to
the ones used for MT7992 on the EN7581 SoC.

---
Changes in v2:
- Introduce "airoha,en7581-npu-7996" compatible string to specify the
  firmware and drop "firmware-name" property
- Link to v1: https://lore.kernel.org/r/20260112-airoha-npu-firmware-name-v1-0-d0b148b6710f@kernel.org

---
Lorenzo Bianconi (2):
      dt-bindings: net: airoha: npu: Add EN7581-7996 support
      net: airoha: npu: Add en7581-npu-7996 compatible string

 .../devicetree/bindings/net/airoha,en7581-npu.yaml       |  1 +
 drivers/net/ethernet/airoha/airoha_npu.c                 | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)
---
base-commit: cbe8e6bef6a3b4b895b47ea56f5952f1936aacb6
change-id: 20260107-airoha-npu-firmware-name-34e5002a1a3f

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


