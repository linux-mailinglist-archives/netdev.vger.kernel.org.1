Return-Path: <netdev+bounces-141117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 823759B99FA
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 22:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47C012832E2
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 21:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4351E5718;
	Fri,  1 Nov 2024 21:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6qxa404"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7327A1E282A;
	Fri,  1 Nov 2024 21:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730495636; cv=none; b=EC+OccRSnC08rirER8e72eyqbWGXQxvc/yfxTUDBg9IQwCsUn5U9x+vwDdJD7EbxGdFOcn+O4sxxat45y4SEfxQ9unp4CwW59W6TC2SZV22LZXu1MfJWz/u/h7IyBaT0umnweXN60suKhMB5cIFBVz8muTkzzsmn41u0zko60ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730495636; c=relaxed/simple;
	bh=mAgVkQX8+XFq+N+g/hfycujsgkdhA6PKg1ePTiZHGiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UwJPq5GjCmHQh7/5f8bcKBWHICBXX5kNGNTx+/KgjjWXnp7ZLfL5B5YNxVLoHWrHGvIocOxLsxcbeaXJ+4cVG/e+BShPDrMaFe7bFmPNoDuXSl2PdyykNyA1olcMMfO9sapE8GtH5NH7iAqkwfMhFSI0/6XgZLqEq7cSiWRleVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6qxa404; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3EE0C4CED1;
	Fri,  1 Nov 2024 21:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730495636;
	bh=mAgVkQX8+XFq+N+g/hfycujsgkdhA6PKg1ePTiZHGiY=;
	h=From:To:Cc:Subject:Date:From;
	b=I6qxa404brhWL/cJ1HbTe915BfugbTV4XIFVzFbpaVn61pmBfq/ZxG8u3UH6m4S3e
	 b8IwIN8aH7QZhWNRUZUiOnclDVwDL6+EmaiAi7WAYC+fb3SNf1tNOJ23aMV+glxx/O
	 UkkmTHbL1KwIGuW6g9WEoO/wXp1R+4pFoWWN9q6aLTmUhc5C8FokhvrrE2u8NhZXXw
	 NJGmELdOl4Fb7AEnujmnz9bwE53r2FkjeLZORfAAwi9cB8USH2GIUXxHHTYtC5CBFw
	 KbtC+ekbuIbvsTEKwiNbk4lKjEaOHWsfELA+z7Kfmeg3eNEQzzwMydsn7eMtMpBOwW
	 VY3PePIxkUi6w==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] dt-bindings: net: snps,dwmac: Fix "snps,kbbe" type
Date: Fri,  1 Nov 2024 16:13:31 -0500
Message-ID: <20241101211331.24605-2-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver and description indicate "snps,kbbe" is a boolean, not an
uint32.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 4e2ba1bf788c..f48a0f44cf2d 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -560,7 +560,7 @@ properties:
           max read outstanding req. limit
 
       snps,kbbe:
-        $ref: /schemas/types.yaml#/definitions/uint32
+        $ref: /schemas/types.yaml#/definitions/flag
         description:
           do not cross 1KiB boundary.
 
-- 
2.45.2


