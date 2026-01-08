Return-Path: <netdev+bounces-248078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A6ED02FDF
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 14:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 29ED73016448
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 13:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A6A3EE4D5;
	Thu,  8 Jan 2026 13:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRMBic0G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E053D7271;
	Thu,  8 Jan 2026 13:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767877710; cv=none; b=r3NOtscsckW+lD5UTJEzr9pGId18NALjs6Ts+p3R1rmD0TlDlIj0zHvuJ/0fvSs4aPw8ncCGWZ8fL/sOZejuF30XAWAhj5hx2oIx7DtjxgDZLAwWm7Ebj7DhjYkQaiKV2n4Fhz7QWiQIlVDYYnKxmrOAA+RHefTmO3jwZeqrCbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767877710; c=relaxed/simple;
	bh=BEFqASubnMhLuZshwv8XM1o9a6Rbhxs2caSt9SThpyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QTOLmYLVGlIZEwdfXLzIIeJiTXBgCJNHD/X4jL9r+DCTLBM8+U7bMYbPk09zCTLJPEGWIWe6C6oW4WRTmNDUSpu5OjvxMGErVDjtL+3UlsLdjAtISJfgHHrJasE6n+b22EnLAIQSgDDtEaucwJrKJPWcC+kHFDQqtkE/Kh+Gv04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRMBic0G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8F6C19422;
	Thu,  8 Jan 2026 13:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767877710;
	bh=BEFqASubnMhLuZshwv8XM1o9a6Rbhxs2caSt9SThpyQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XRMBic0G5unXBBKtPVKjxLP9Y21Uw1rOGHGXAdcJY+W+/4GY/AZXl7TsdSOv37RbZ
	 61xlZT8ixVHx4g0L7GbF8oKbMcBXdHa1+IeoRUWXbiPWkRSz0ps/8caEufs/g/hbCK
	 e8Vai3kIOSHV5bLEhiY2zY2bOZ/DBYQ/+HufR7NfR7BmbGxuvhwjPgVZl/hEw6WRIA
	 sRmxBoImpSjAgoDKZr9nnHFIcrk26Nl614qIhniVpDlqNKzx6YcIengo4fXZfhtcnn
	 9tSX4XKE1fv2yFOpANCggDXjuem8gpXLQRZDD95/UN6ftHrv8eq49KkKXgV7oqEgjp
	 7PYEnxduZarrQ==
From: Dinh Nguyen <dinguyen@kernel.org>
Date: Thu, 08 Jan 2026 07:08:11 -0600
Subject: [PATCH v3 3/3] dt-bindings: net: altr,socfpga-stmmac: remove TODO
 note
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-remove_ocp-v3-3-ea0190244b4c@kernel.org>
References: <20260108-remove_ocp-v3-0-ea0190244b4c@kernel.org>
In-Reply-To: <20260108-remove_ocp-v3-0-ea0190244b4c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1088; i=dinguyen@kernel.org;
 h=from:subject:message-id; bh=BEFqASubnMhLuZshwv8XM1o9a6Rbhxs2caSt9SThpyQ=;
 b=owEBbQKS/ZANAwAKARmUBAuBoyj0AcsmYgBpX6xGixoksxcAk+BFIhc7a5PDFAUf6fYBGoSrA
 QcXF26GOf6JAjMEAAEKAB0WIQSgeEx6LKTlWbBUzA0ZlAQLgaMo9AUCaV+sRgAKCRAZlAQLgaMo
 9HqGEACCdtcSvnQAfq+6jLL6yfY2+XXhl5DnzWzojSs6HegHQ0ZbpDwfCGPrifVoSJXFmkD7nr0
 CltAAh4vut2VGb3rI9/x+5N01I14VcqhnKhiABEFf3YYyHYOi824DJ2sVosKuYycm3GRvHPqw7l
 wkxNNjK1DLhriPS0GSjbmBllVOwdtIYAi/MUFrybzDAT1eVKd0Nt6WUifwwx4GOR48aXPzXOImT
 iSGrytZczmKbxCRNR91MYOQPNpaupejVUiv+qk49e1Wvo5/zw1j2c8P+x4kbgIQ5hsI7I95CtY1
 Om6E9OJDZeEBg+fH+EYZAhwfRIueYWLKPi/LkJENvBkJxPWODdxTipNv5+tjfO3iV6PjjivYz2w
 2sj8/XjplvBsA2a7A30BB9KLxqqcLFubf24+DoFqOmNh3pBTAoezTfZoU6NfTk+uKKTGoh5uYZ8
 D7D+HbKQ3qJ+rSbt9PX/m+uzA4FaYZsJjR9plqPHYuXRPQfW3PfkrlZzH89f9PcSNPH3OD0k6dO
 AxxEjPE/Ky/2CCNxN+NF6DStkntbtUTJkVuCZbRwZM333eIaZWMKZmgNfizBOd4w5mUhg7Qw63D
 Zm6KHOdH9e1jh8H+4ABegP6ar0SPeJbLGeIPvccBNiypKQZGMgBtF/g0tpvcKWyBXt6ccVLmyPo
 UDCLYSxQxcxiDTA==
X-Developer-Key: i=dinguyen@kernel.org; a=openpgp;
 fpr=A0784C7A2CA4E559B054CC0D1994040B81A328F4

The 'stmmaceth-ocp' will no longer be used as a reset-name, going forward
and 'ahb' shall be used.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v3: Addressed Rob Herring's comments and updated commit header/message
v2: Introduced
v1: n/a
---
 Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
index fc445ad5a1f1a..8e7077d4319eb 100644
--- a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
+++ b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
@@ -13,8 +13,6 @@ description:
   This binding describes the Altera SOCFPGA SoC implementation of the
   Synopsys DWMAC for the Cyclone5, Arria5, Stratix10, Agilex5 and Agilex7
   families of chips.
-  # TODO: Determine how to handle the Arria10 reset-name, stmmaceth-ocp, that
-  # does not validate against net/snps,dwmac.yaml.
 
 select:
   properties:

-- 
2.42.0.411.g813d9a9188


