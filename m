Return-Path: <netdev+bounces-226724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AED9BA4758
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 17:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 254A45612E3
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 15:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776AC21CC55;
	Fri, 26 Sep 2025 15:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNPR4TfN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CACB10FD;
	Fri, 26 Sep 2025 15:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758901414; cv=none; b=tfvANcDy1Ok/rmBi7Aj59PxmrxqUUGnVegktbLxcjtVVr7iFjC9zdUHWwICGtbDgckxGTTcjNCnOeU8MS6kjHQR2vlEsCdymqxQpqdny3QVpZQ9OL7PftYrtCgNQXUb3DZ47RWfZP464JOtdk9HIluVO2XovrNbfxg3tSRB+yDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758901414; c=relaxed/simple;
	bh=kiQw1h1Bhq5/hBehSmba5mkf1vpWGZs7wBgPUjiAOwc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=m4BTe6YeLBKTyWUWrJBVFK/nkDgri2dSWyE6h9wHgZTCZxOWhuSELek+vtV5Gy2GtVjiFIsbsaeHoSl/g62XpwmHeZGETmxMHV3wT16AcCffGa0wjPt5rNjLP3mJirGkEFHwiiqtgIMx+Gfy3f1uUy4RAQofy8XpvsJkg4C35Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNPR4TfN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D37C4CEF4;
	Fri, 26 Sep 2025 15:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758901413;
	bh=kiQw1h1Bhq5/hBehSmba5mkf1vpWGZs7wBgPUjiAOwc=;
	h=From:Subject:Date:To:Cc:From;
	b=tNPR4TfNmex+GgVpRuaQwhJGpQVmEF2UwUhVjOQyTLK+XU8wrCimu8rdWzNMrv9bj
	 LrYHFZbuA7cuFGzOb5raIB+L4Mdl2/kQPmZabAoBhzFcxmBVDHKfwYsSgcxFHqS9Bj
	 wSPjZaW2ZZZoKGCDRUhs+8d+PAw14qzBlqU24MInxa2lzqRLQiINhEIKHuXp+N9CiN
	 ejEN4QOMaT1UF+a8rqMxkCJ3Y2t6NU/nbNGQ5Nil/EKWGuLEgh9kPMwuq4+0oCy23a
	 eNvpf6T18/2KP2Lxzkr/ZUxxJnS0XSCaK/mbkUysMiimBKtWOQy+nKTqjawzmo69v6
	 IYXE8FVWwCK7A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next 0/2] net: airoha: npu: Introduce support for
 Airoha 7583 NPU
Date: Fri, 26 Sep 2025 17:43:21 +0200
Message-Id: <20250926-airoha-npu-7583-v1-0-447e5e2df08d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJm01mgC/x3MOQqAMBBA0avI1A5kd7mKWAQdzTSJJCiCeHeD5
 Sv+f6BQZiowNg9kurhwihWybWAJPu6EvFaDEsqKQTn0nFPwGI8TO9trdJqM1EI6Zxao1ZFp4/s
 /TvP7fpwh/41hAAAA
X-Change-ID: 20250926-airoha-npu-7583-63e41301664c
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Introduce support for Airoha 7583 SoC NPU.

---
Lorenzo Bianconi (2):
      dt-bindings: net: airoha: npu: Add AN7583 support
      net: airoha: npu: Add 7583 SoC support

 .../devicetree/bindings/net/airoha,en7581-npu.yaml     |  1 +
 drivers/net/ethernet/airoha/airoha_npu.c               | 18 ++++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)
---
base-commit: 203e3beb73e53584ca90bc2a6d8240b9b12b9bcf
change-id: 20250926-airoha-npu-7583-63e41301664c

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


