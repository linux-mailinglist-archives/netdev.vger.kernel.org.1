Return-Path: <netdev+bounces-109444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D42D69287C0
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 13:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 900EA2874F5
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 11:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776AE14A0B7;
	Fri,  5 Jul 2024 11:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOxhoovT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459A3149E14;
	Fri,  5 Jul 2024 11:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720178459; cv=none; b=FZZWyV7cMs8/v3y8W+Mf8qsdf7CUoyvhiLX7PAqttMVp0bkJLFTvDZe4GJ96gy1hN5xcyPwMzKgdVt2S+uUwPxiAd3CsYS9iBq7qV5fAovCfl7gDS/Gk0rkYz4bmsT2ZvhFE7IpXXgoDrfTGkFPs+dXPSendYi1DmA4xzJ789Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720178459; c=relaxed/simple;
	bh=2lziA+/6JKSgfq9RoAqeOwVB85rk+sMBHVFJcgBRrhg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c3J+Yq5p/Hy3Jj5JZ45DjpOBIlziGVy2srXuzHdN4wuikY1WDC+ahWDKwHGMA/O9aNtiErZYFSyo0PUEjJOeGmuu4TSdR0oJ59+AGnYGUPIImVQ6w+jB4wrTVXarBH4lYYWwxsDTsewCFUPtW6eocbWaGLDm26OHbKovdCrts0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOxhoovT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2088C4AF1C;
	Fri,  5 Jul 2024 11:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720178458;
	bh=2lziA+/6JKSgfq9RoAqeOwVB85rk+sMBHVFJcgBRrhg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=aOxhoovTpToa7QO+/LQxmShtHJLAhrBy4EJ/FyepHQSLXTgZmjPPHnMZ7uCmFQbL7
	 S4iKDyuukdXxQBKHvW9mwbDgqMX/aKXW9V/EF8WqFbf5mmoRYKYkeDzgUZJiEBRqtd
	 sLKQPdk40PqOaNjGLstomU37mxf3pRWsyfS2w+b+K0Gf/k/KR7Ksz3+GWvoKfjkVk4
	 czFkFo/BLbnTRD3suP//ybioOkkjX4S+3HFDxS5/Lkmo6er68s7X/4U2hgz4jz4xVR
	 Q92hzAJYUUuD59+8KYSkLHe6sRtyS/yrHr81kngGLVuVKHCRSEHHA36z8t/NVYczUq
	 Q7vo8qpplz2SQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99164C30658;
	Fri,  5 Jul 2024 11:20:58 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Fri, 05 Jul 2024 19:20:47 +0800
Subject: [PATCH 4/4] MAINTAINERS: Add an entry for Amlogic HCI UART
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-btaml-v1-4-7f1538f98cef@amlogic.com>
References: <20240705-btaml-v1-0-7f1538f98cef@amlogic.com>
In-Reply-To: <20240705-btaml-v1-0-7f1538f98cef@amlogic.com>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720178456; l=791;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=6p3yKY36l4948ddX8ZSkIlVHnk6qkn9A/zzKu777K74=;
 b=Ed7f/l9Xlg5GkNfTRh8J13KkPIycQeC2NgSckQjHhjTH/Y3uWKotFhN3wov3NdBahWbrMVZyg
 75upTDaX0koBeQHlSe1OyWlp8GW4djERI79GjmWdXegcqIa0lTlRKjh
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

Add Amlogic Bluetooth driver and driver document.

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd3277a98cfe..b81089290930 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1140,6 +1140,14 @@ S:	Supported
 F:	arch/arm64/boot/dts/amd/amd-seattle-xgbe*.dtsi
 F:	drivers/net/ethernet/amd/xgbe/
 
+AMLOGIC BLUETOOTH DRIVER
+M:	Yang Li <yang.li@amlogic.com>
+L:	linux-bluetooth@vger.kernel.org
+S:	Maintained
+W:	http://www.amlogic.com
+F:	Documentation/devicetree/bindings/net/bluetooth/amlogic,w155s2-bt.yaml
+F:	drivers/bluetooth/hci_aml.c
+
 AMLOGIC DDR PMU DRIVER
 M:	Jiucheng Xu <jiucheng.xu@amlogic.com>
 L:	linux-amlogic@lists.infradead.org

-- 
2.42.0



