Return-Path: <netdev+bounces-34508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C887A46F6
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 12:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AD67281447
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 10:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B5D1C6B1;
	Mon, 18 Sep 2023 10:29:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AB31C6AF;
	Mon, 18 Sep 2023 10:29:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76923C433C7;
	Mon, 18 Sep 2023 10:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695032997;
	bh=zT/VqPIJgqnrap3GKwzfg3wRyyyaBajlc9TMmjJ9FgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tY57RlMqWG0XaYJxZj60FxrXKxMACozrz9XSzD64kBZ2QFRgmFgI3U0O/3pI1hXeb
	 /Zmn7lzfTMpjQaJplyTdmyuMYpUFBDHbjYQVE8lecRJc3AJALJaR+e2HMXdSLlLgd4
	 MWAEn3uKxCP+QL5Z/kHdxTJ2UCAa8Wo91TO+AFNYyzxvIq3od7AwMQCJoZMM+NXoOE
	 y1zcj9fzIEHtXd/RNBUzpEShZjXqsubWukAM+bcznQWuEfTsg5PyRG2krFza+z5ImP
	 6MNlzE3CQZPEZEyU5+MY/OdYc02T/eyyU30Ang/jCBhDH+3q6mf8ZfULzBPu3iLgaR
	 Qy1wZwF6l2Kdw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	nbd@nbd.name,
	john@phrozen.org,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	daniel@makrotopia.org,
	linux-mediatek@lists.infradead.org,
	sujuan.chen@mediatek.com,
	horms@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 net-next 01/17] dt-bindings: soc: mediatek: mt7986-wo-ccif: add binding for MT7988 SoC
Date: Mon, 18 Sep 2023 12:29:03 +0200
Message-ID: <771d7b43e4b5698bc0cf684533537998b22690d8.1695032291.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695032290.git.lorenzo@kernel.org>
References: <cover.1695032290.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce MT7988 SoC compatibility string in mt7986-wo-ccif binding.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../bindings/soc/mediatek/mediatek,mt7986-wo-ccif.yaml           | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt7986-wo-ccif.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt7986-wo-ccif.yaml
index f0fa92b04b32..3b212f26abc5 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt7986-wo-ccif.yaml
+++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt7986-wo-ccif.yaml
@@ -20,6 +20,7 @@ properties:
     items:
       - enum:
           - mediatek,mt7986-wo-ccif
+          - mediatek,mt7988-wo-ccif
       - const: syscon
 
   reg:
-- 
2.41.0


