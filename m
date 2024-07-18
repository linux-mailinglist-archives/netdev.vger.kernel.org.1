Return-Path: <netdev+bounces-112016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B731934918
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 09:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45F551F25059
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 07:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EB278C76;
	Thu, 18 Jul 2024 07:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCblOIgK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E399277114;
	Thu, 18 Jul 2024 07:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721288578; cv=none; b=RvXt+IalFcuY9EpG1/W/kd3uXE5zmfdS4aOB3ZGcDZXEtHympgI7riFU9NiqRlzGjew9pvhoDSXbLP9Pem9FnS9RPe2hjVYgkiNasRac7w4qKCFhkC2g8HEXoSAqYVBeXvKCLzoOcC23wgHmEEX1AX57UGC9Qt/k9Gc8ZdBKhs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721288578; c=relaxed/simple;
	bh=ee0MfqKhJwu+BmHNrObmbBkQYcwyzrWWQyYQK6nZ/Zg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BREzO0vtKjr4eSMa+Ql+03dffTulE50bmhE0GTkJFFGcf1X8pcrAVWSPrnEmWivCwH/T1XOKGAKKkaxR0oJzt/NRPkZ2/mblxcrRe7EbLX6EK3A64M/Y1Ook/g8BwepZ26rnSIPkYppy7va42PIQfcFua8EeLWjemjj8mZHXJz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCblOIgK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 724CCC4AF18;
	Thu, 18 Jul 2024 07:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721288577;
	bh=ee0MfqKhJwu+BmHNrObmbBkQYcwyzrWWQyYQK6nZ/Zg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=iCblOIgKmaRrbPXODihLGXr5/zFR1NIqr7Y80DAeXc9mSrt1Jm1ZT45J5vSK7gcOw
	 83hPt62nBwyRRBlJGJg8MtZKVedB36NHFzDNdq6xP2E/ilbO14WqLE4B7OZLVKb+DF
	 gSNvhKRmUuTPG6V1rpEJ+IX6ixjBvK/drDH/55fwwLnFQVTYZuZc/8FpLpSoSs96Lh
	 BSKZLYQ7k2SliNr5Kd4NS68rVWKCpJzhXjHXRYtwbs8Sw6Ogye6ftmPNIBhujay1rW
	 i7NToj9tL3G2gUrjZOytWhbg2SNJCxpUkg6p4Bda4N2ZzvbRxp0WfETyxJ5gvjWGNj
	 A2kI1N1Cq2zyg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C85CC3DA49;
	Thu, 18 Jul 2024 07:42:57 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Thu, 18 Jul 2024 15:42:21 +0800
Subject: [PATCH v2 3/3] MAINTAINERS: Add an entry for Amlogic HCI UART (M:
 Yang Li)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-btaml-v2-3-1392b2e21183@amlogic.com>
References: <20240718-btaml-v2-0-1392b2e21183@amlogic.com>
In-Reply-To: <20240718-btaml-v2-0-1392b2e21183@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721288574; l=782;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=JCpkGkVAbaLnnsN6aT/w92n7ppHeCAU2X3+VbVGUtEo=;
 b=dqlyPJlQ7D31d+7nDV9lqqizBGcv+gyxgoHx4JDZkWMNTXKqQTT1EwWn90g1dVlPXg5KV0FFo
 2Ji6eH/HoCGB+Wf8hESpkf0u074JZ6vcTZhiWyVIn8Rhz6/QQKRB+tJ
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

Add Amlogic Bluetooth entry to MAINTAINERS to clarify the maintainers

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0b73a6e2d78c..b106217933b2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1149,6 +1149,13 @@ S:	Supported
 F:	arch/arm64/boot/dts/amd/amd-seattle-xgbe*.dtsi
 F:	drivers/net/ethernet/amd/xgbe/
 
+AMLOGIC BLUETOOTH DRIVER
+M:	Yang Li <yang.li@amlogic.com>
+L:	linux-bluetooth@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/bluetooth/amlogic,w155s2-bt.yaml
+F:	drivers/bluetooth/hci_aml.c
+
 AMLOGIC DDR PMU DRIVER
 M:	Jiucheng Xu <jiucheng.xu@amlogic.com>
 L:	linux-amlogic@lists.infradead.org

-- 
2.42.0



