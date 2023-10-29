Return-Path: <netdev+bounces-45038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A00D27DAAB0
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 05:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59C8D281773
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 04:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366BF15A4;
	Sun, 29 Oct 2023 04:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="f9Rmiofb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC7A53A8;
	Sun, 29 Oct 2023 04:27:26 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D71AD;
	Sat, 28 Oct 2023 21:27:25 -0700 (PDT)
Received: from localhost (unknown [188.24.143.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 87BFD6607340;
	Sun, 29 Oct 2023 04:27:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1698553643;
	bh=4Ac1sglox319ZVY8QnDJ6GHvVijM8j/9ar97NnhyoHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f9RmiofbNDogf+uRfHtS+0K95TOVfmqAfkEvxWAwnE/dhAKhpBy0KtWzjSQXD1w2u
	 foLopAjd7AESsMpHFRXmsiPu2JZ4DcYMLZ+ituDeDEuH3kJKchUVaKIg/YtjwgxTH/
	 +2477CasfBUls5EIXnwVF5u20RDEVMS+kq8HZbYzTNqiVLjvXMSbhIk1DYpt4k7C9i
	 Cjlbu6okC4jp5dRj0OGQpLvRZo8HQTx3yH+VHlIiIs8VypO8W10n1/vYNqne8iEVVL
	 aboZIrf6qfiqONkhYZVqypqVm0R5IgG53qO9JW8iAzmG2yY6phGyaX8YVja9l3JzbD
	 lcQpNxLbad60w==
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Samin Guo <samin.guo@starfivetech.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v2 02/12] dt-bindings: net: starfive,jh7110-dwmac: Drop superfluous select
Date: Sun, 29 Oct 2023 06:27:02 +0200
Message-ID: <20231029042712.520010-3-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029042712.520010-1-cristian.ciocaltea@collabora.com>
References: <20231029042712.520010-1-cristian.ciocaltea@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The usage of 'select' doesn't seem to have any influence on how this
binding schema is applied to the nodes, hence remove it.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 .../devicetree/bindings/net/starfive,jh7110-dwmac.yaml   | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
index 5e7cfbbebce6..cc3e1c6fc135 100644
--- a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
@@ -11,15 +11,6 @@ maintainers:
   - Emil Renner Berthing <kernel@esmil.dk>
   - Samin Guo <samin.guo@starfivetech.com>
 
-select:
-  properties:
-    compatible:
-      contains:
-        enum:
-          - starfive,jh7110-dwmac
-  required:
-    - compatible
-
 properties:
   compatible:
     items:
-- 
2.42.0


