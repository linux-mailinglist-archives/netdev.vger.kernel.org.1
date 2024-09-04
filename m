Return-Path: <netdev+bounces-125100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B407796BE30
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 15:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69DC41F24F51
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 13:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D716A1DA31E;
	Wed,  4 Sep 2024 13:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xQeuwogp"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BC31CD25
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 13:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725455974; cv=none; b=sekEUwJyfjptO5oEfqcOnseBvl1w+31+jlizDsGiWDkKKqFqOm14W9f54G7oPTc56oprn30SeLx+wXV9IaEnGqWr0MOtwixcjq42a4vVziugPB8SIPe+YOPeDqLy0w+IlPReLj5z/iXUssBMhEhUSSWILb2dhUdruJUkWgm2f2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725455974; c=relaxed/simple;
	bh=JeRnoEmi3A45X7ygxO7Vd4Asxb8+/puWX3n4OQ4jOrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CTyW8LHag0sflUn9T0aqcuYB4oayliUCnGChDNE0r16AFVhVE2Y+D3GzLkfCZbs4qpWk+M7MgkA18IfyE+2onXX7MUwx6sIdhbC18zb8wcM6tlgLGaJdNwb8QsN8Ic8fpunZpjVkP31Xv5VvfojtqIwlZb5MMox2PDKuWL7JD+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xQeuwogp; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725455968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7HI/weEryH/HNQsoVvflw0zuKhBl79APgHqAgYtDrBw=;
	b=xQeuwogp7Fu7RLAKttuaPBKbBgBVvRMz/F5Y7KSD1C+MaDsKVjGHylfdCrQCxRR8j5wvrL
	wJP/FFAbUF5k3vzbN/s1h6kdwoCR/2Vq2d2dw260F5kUKCDUeCXT1Lm/iPETy6myftPaaP
	HEoLP79zYNnnPyRJ2zvnapDUDgjwQB8=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	netdev@vger.kernel.org
Subject: [PATCH net] MAINTAINERS: fix ptp ocp driver maintainers address
Date: Wed,  4 Sep 2024 13:18:55 +0000
Message-ID: <20240904131855.559078-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

While checking the latest series for ptp_ocp driver I realised that
MAINTAINERS file has wrong item about email on linux.dev domain.

Fixes: 795fd9342c62 ("ptp_ocp: adjust MAINTAINERS and mailmap")
Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
I'm not sure if it should go to backports queue, so if I'm wrong,
please, redirect it to net-next tree while applying.
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5e5e85841a2f..8b28943a0c19 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17118,7 +17118,7 @@ F:	include/dt-bindings/
 
 OPENCOMPUTE PTP CLOCK DRIVER
 M:	Jonathan Lemon <jonathan.lemon@gmail.com>
-M:	Vadim Fedorenko <vadfed@linux.dev>
+M:	Vadim Fedorenko <vadim.fedorenko@linux.dev>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/ptp/ptp_ocp.c
-- 
2.43.0


