Return-Path: <netdev+bounces-112687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D347B93A960
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 00:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87E7E1F212FA
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 22:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CB2145B28;
	Tue, 23 Jul 2024 22:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/hHYG5D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FA11428E5
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 22:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721774049; cv=none; b=ULbvWW14SUZJwXVKemA7vJlJcCg2zq7gpJ3NKq0nNaz5hP276YZSmHSRouiHtNTIPoZI5Ga+9UaSZEySJZMBByxh7DbsKbGZYnojOT6VCbYK9U3iDpRUgjqbGHt2UCQWs1ew3m06LfcE4EGwuYq52Ke8K/G00xdfEpbfM1wEcpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721774049; c=relaxed/simple;
	bh=BMy/YnGz+1e6M8YIFYOHt7x04txC19mkMvaWiGuOu8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GT1Ynj6kIWSbJS7VEpE04IjjF+A8VJBr8alXzIsea4GLGuf9USRc8i8t/GqUuu7J98gRPJeZlQPh02TW5i8jGQkn7b5O5+3ntIWSsoJye7D7A4fZ/mty5RmzKd1IsKAQKyMAQRh9K1WL6KY3/mVSbkXZtE5DakRLi1GUvl5cPgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/hHYG5D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E24C4AF0A;
	Tue, 23 Jul 2024 22:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721774049;
	bh=BMy/YnGz+1e6M8YIFYOHt7x04txC19mkMvaWiGuOu8k=;
	h=From:To:Cc:Subject:Date:From;
	b=n/hHYG5Dv153nb4dzpKDrD/ImOt70Msski44i5Fa86AMkkF2dWEAO2DVlsl04iyX0
	 3B7nzMs5z3Ry205YPVSPobAfA8AQQ9ZzNoREC6xEnILfGw6pmhEKb3UiC97bnAKNl+
	 Uf167WcSB0jKv4FgaAX8WXqXpvmgwpsrqBwpeWbgncABBsO9Uf76P2Y2+tn5AKqu+g
	 hBTds+Zx3RGOUV8sSETSoYSuHHJkT4BysXTMpAKEbcrE0EF63tLlGlcTHy/dBsc1GO
	 fk8HBMpICMRWofc8ICggqm4WPU0DPQtDkEKI9vusqw3dJ5RtkFiJhaPcKgrAq1BFWP
	 YCCJ94w3hj40g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	leitao@debian.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net] MAINTAINERS: make Breno the netconsole maintainer
Date: Tue, 23 Jul 2024 15:34:05 -0700
Message-ID: <20240723223405.2198688-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netconsole has no maintainer, and Breno has been working on
improving it consistently for some time. So I think we found
the maintainer :)

Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4e3f4416cb03..a85234de4fd0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15704,6 +15704,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml
 F:	drivers/hwmon/nct6775-i2c.c
 
+NETCONSOLE
+M:	Breno Leitao <leitao@debian.org>
+S:	Maintained
+F:	Documentation/networking/netconsole.rst
+F:	drivers/net/netconsole.c
+
 NETDEVSIM
 M:	Jakub Kicinski <kuba@kernel.org>
 S:	Maintained
-- 
2.45.2


