Return-Path: <netdev+bounces-157189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E44A0946E
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 15:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 697C43AD72F
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 14:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D629821170E;
	Fri, 10 Jan 2025 14:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RmoURz+w"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABDE21323C
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 14:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736520648; cv=none; b=gmAPFHWVaqbDNIS4Y0Id7JBgzE8OuKvbaOvw8aUKjOTO+8b26VVfhHfUZ+2u2Qr5zVGSSZiWvjrkykajsLmeVX+MteaZWIAvWX+uhHsFUKap8d8aNUMeDVYxkVjn4x3FaUZP2HMk5mBWrmdwNJa7Tm/2EpEzoIEi54ou/xivmLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736520648; c=relaxed/simple;
	bh=QhczLHiPlfSMHBvF6sZefsENgKOBIcG0bClUpeyvhgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qWP5jylNSMhuyCPIKEj8viLMEwqzDofeof+SLm7RXRU7Huw5sLYgeLQhFTVZ5rHvBeNB42KXVUZmI7AxsRzLWY5vOUNdba2jsP+hCJ0Z+0hAXjUmzDiKqwzTchM8fGlytr+RXEbxZImrQD4HsIVRDJ2r9W6Cs4YtJUIf5accjlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RmoURz+w; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736520639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SO9nY4CrnWWQvgbk8AzZaqtkfceRkJDXS4xgkNRdYYA=;
	b=RmoURz+wmjCbYvClcw8z0uqyQ92W6bQlwB7bsRdNmY4JrYvB1GYm7ohdQPY3eTcoRk6Jxn
	fYq1Q+Q8UEaFQqRhCFtCkteMj2J+puf3eMdCinwybClgPd0aesSoAScp3fV2PeYql3SVEW
	vId3r7ZdBEqcyJYWwTvun31Bb7qIz5k=
From: Yanteng Si <si.yanteng@linux.dev>
To: kuba@kernel.org
Cc: Yanteng Si <si.yanteng@linux.dev>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH] MAINTAINERS: Become the stmmac maintainer
Date: Fri, 10 Jan 2025 22:49:43 +0800
Message-ID: <20250110144944.32766-1-si.yanteng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

I am the author of dwmac-loongson. The patch set was merged several
months ago. For a long time hereafter, I don't wish stmmac to remain
in an orphan state perpetually. Therefore, if no one is willing to
assume the role of the maintainer, I would like to be responsible for
the subsequent maintenance of stmmac. Meanwhile, Huacai is willing to
become a reviewer.

About myself, I submitted my first kernel patch on January 4th, 2021.
I was still reviewing new patches last week, and I will remain active
on the mailing list in the future.

Co-developed-by: Huacai Chen <chenhuacai@kernel.org>
Signed-off-by: Huacai Chen <chenhuacai@kernel.org>
Signed-off-by: Yanteng Si <si.yanteng@linux.dev>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 481b2dac1716..9e754ffa8ac4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22677,8 +22677,10 @@ F:	Documentation/devicetree/bindings/phy/st,stm32mp25-combophy.yaml
 F:	drivers/phy/st/phy-stm32-combophy.c
 
 STMMAC ETHERNET DRIVER
+M:	Yanteng Si <si.yanteng@linux.dev>
+R:	Huacai Chen <chenhuacai@kernel.org>
 L:	netdev@vger.kernel.org
-S:	Orphan
+S:	Maintained
 F:	Documentation/networking/device_drivers/ethernet/stmicro/
 F:	drivers/net/ethernet/stmicro/stmmac/
 
-- 
2.43.0


