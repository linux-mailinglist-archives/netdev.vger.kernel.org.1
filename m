Return-Path: <netdev+bounces-185479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C2EA9A98C
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 12:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DE9B7A82DD
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 10:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228C0221284;
	Thu, 24 Apr 2025 10:09:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FFC221269;
	Thu, 24 Apr 2025 10:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745489375; cv=none; b=Z79Oxz1vyKIWSjAlYAKKvTozxIC+CIvbmS9vRJzb3Dz4Ne6xcnLUqPH7ns19S+xT3K1WZd49CwHB1VpPrGs/h17YV5zFafsEfWenWV9O1YSQGVmCniTMVUEiewxJNt/kqmWCQ/njhKT35ab3EzRLQDs5Zu43JBoZQw7aTnTM/AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745489375; c=relaxed/simple;
	bh=5l+lKBdeLBoQJDeDwdunSWCv3VLlQKCuI1baaiMgJfM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ACMHXCP0/7sNaSkJEL34WYmooyRySWRfoqC76L8RK06idgt3vhrcF/n9TjSj2mOwtO/BJjMRau14YtQPAxfMgayTCMutFA6PDkokBKzzEGs5rwFALRsheKaGkvTZHBzrkHQhkk+irP5mGbY7hNInJJd4H+jsQoUKIgxYoX7ImIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [127.0.0.1] (unknown [116.232.18.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 7F9BC343016;
	Thu, 24 Apr 2025 10:09:27 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Thu, 24 Apr 2025 18:08:40 +0800
Subject: [PATCH v2 2/5] dt-bindings: arm: sunxi: Add A523 EMAC0 compatible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-01-sun55i-emac0-v2-2-833f04d23e1d@gentoo.org>
References: <20250424-01-sun55i-emac0-v2-0-833f04d23e1d@gentoo.org>
In-Reply-To: <20250424-01-sun55i-emac0-v2-0-833f04d23e1d@gentoo.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Andre Przywara <andre.przywara@arm.com>, 
 Corentin Labbe <clabbe.montjoie@gmail.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1008; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=5l+lKBdeLBoQJDeDwdunSWCv3VLlQKCuI1baaiMgJfM=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBoCg28uZAZCSSi4mwqc7sIZwc6y+aLe4/0Pz9Ic
 1dXFjTTTpaJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaAoNvF8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277b2cD/4h+l7YLvA7EAXzKL
 8HoziTK7ZctMgLc2J9Hx8zSOr9UreAxgu7L1CkoAx0rm1k83BV8lbkb+DMXaFThM2HdsoAsCPZY
 0Q551tfrpUSVaYvgq0/jgZZ5vVuh2D9cOTFYYnS+Vq8uiD0agscnOeztT2o4EnMbKJr1nMqb1O/
 oYOuwCRhWIXqJHJb1v9iGVizoJz/wRysE3FjQj+PTVge5Sn5jK0qRpTx8qKDBlEdLVL1iaDzzEP
 JxeG8CDPdUBH5KoEfQQkcZULlOwP9d9PErUI8Bv+y1OpOkJlMtlkcB7a000L8BY5DPF+kujigwQ
 8AvJkQ8XMGRCIoTb0P2qoz+9xdbLIcS82Oyh/loTv8JMFFwb/s6s4IzB4fFnv7GLU90V0jjPeWK
 GM0VvzdOqZ+23JUmF9cZ7yang9hzw58lXGPqmjTCoZ+EPBv7hDvqGHYX/x6Yc6IuFt6kC3ADAzT
 jnnUi0+tz2prfT7A4z5V5zNNfC3dcxhWBiFWZpIbBagzjlvrNbjvhCZw30a8+o3wEwHdgvPxWIn
 QoJ50U+/oPhQACQA0fYq1BU2OhtqSxPJFDGxX85xO8TZ7CXOwemZzs5YNNBCIjilDIMdYBnYckB
 iyimtcEXwQjVHVbqJTXYCSZp6SX++fZlGHmaLGhDb1ngFmwa6xGQ1N4gIj+LY0gqhRjA==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

Allwinner A523 SoC variant (A527/T527) contains an "EMAC0" Ethernet
MAC compatible to the A64 version.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
index 7fe0352dff0f8d74a08f3f6aac5450ad685e6a08..7b6a2fde8175353621367c8d8f7a956e4aac7177 100644
--- a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
+++ b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
@@ -23,6 +23,7 @@ properties:
               - allwinner,sun20i-d1-emac
               - allwinner,sun50i-h6-emac
               - allwinner,sun50i-h616-emac0
+              - allwinner,sun55i-a523-emac0
           - const: allwinner,sun50i-a64-emac
 
   reg:

-- 
2.49.0


