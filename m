Return-Path: <netdev+bounces-139615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6FE9B3918
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 19:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C588A280E13
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 18:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDA91DF966;
	Mon, 28 Oct 2024 18:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armitage.org.uk header.i=@armitage.org.uk header.b="pSObhqoh"
X-Original-To: netdev@vger.kernel.org
Received: from nabal.armitage.org.uk (unknown [92.27.6.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ED91DF266
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 18:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.27.6.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730140066; cv=none; b=aP6X9SoNujfzSDkbuxEzH9RtyC35uI3dg4Emfr3JEGW4Va+D2Guw/XblqwzKCuTSxCG+4d5jq7olZ3Zeynryn8X79MYkA9iEmTcrQkxwOEjMDMTHEMLOEAkXdkqDuEqzJTqGwPFeBFTNnYGW19rDVphTXe6kTMVY+IZmJJM3Z9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730140066; c=relaxed/simple;
	bh=SRhDUy94X6I+pX3Ala0fVXalVMonR17U3QsUtu2JJF0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aR0A6B/0Ee6E9MdGekWOSaIjFlArf3iaM7mQluu6HW+kkPuVs9Rx4aPU85dk/FgM47STVVU8NJd3ySKFlgz4MTg6U7srvf433cbuHTeab2crIBCoqHbA/RO6whiBTq2WE8N7MCOCFMx64G0U5cCwr1mklA4cbkPYahxfjgB+KOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armitage.org.uk; spf=pass smtp.mailfrom=armitage.org.uk; dkim=pass (1024-bit key) header.d=armitage.org.uk header.i=@armitage.org.uk header.b=pSObhqoh; arc=none smtp.client-ip=92.27.6.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armitage.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=armitage.org.uk
Received: from localhost (nabal.armitage.org.uk [127.0.0.1])
	by nabal.armitage.org.uk (Postfix) with ESMTP id 637C32E5353;
	Mon, 28 Oct 2024 18:27:34 +0000 (GMT)
Authentication-Results: nabal.armitage.org.uk (amavisd-new);
	dkim=pass (1024-bit key) reason="pass (just generated, assumed good)"
	header.d=armitage.org.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=armitage.org.uk;
	 h=content-transfer-encoding:mime-version:x-mailer:message-id
	:date:date:subject:subject:from:from:received; s=20200110; t=
	1730140039; x=1731004040; bh=SRhDUy94X6I+pX3Ala0fVXalVMonR17U3Qs
	Utu2JJF0=; b=pSObhqoh6k1PVbgwLMp72kderlNm74f6P1ghvof3VrFqtT4Ox2I
	TJBmisZrtwtIT7McE6iqcbFf5nUj9MUxn/OrJP3ISOm8xuOY/PSoFxwWWMhucwN/
	TKNBKciK7dy88S5FX6MOvBYVaOuaHQ8MUD9ef5PKYE6JOU9E3AWAMj+c=
X-Virus-Scanned: amavisd-new at armitage.org.uk
Received: from samson.armitage.org.uk (samson.armitage.org.uk [IPv6:2001:470:69dd:35::210])
	by nabal.armitage.org.uk (Postfix) with ESMTPSA id EA96B2E53B6;
	Mon, 28 Oct 2024 18:27:18 +0000 (GMT)
From: Quentin Armitage <quentin@armitage.org.uk>
To: netdev@vger.kernel.org
Cc: Quentin Armitage <quentin@armitage.org.uk>
Subject: [PATCH 1/1] rt_names: add rt_addrprotos.d/keepalived.conf
Date: Mon, 28 Oct 2024 18:27:07 +0000
Message-Id: <20241028182707.310560-1-quentin@armitage.org.uk>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

keepalived now sets the protocol for addresses it adds, so give it a
protocol number it can use.

Signed-off-by: Quentin Armitage <quentin@armitage.org.uk>
---
 etc/iproute2/rt_addrprotos.d/keepalived.conf | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 etc/iproute2/rt_addrprotos.d/keepalived.conf

diff --git a/etc/iproute2/rt_addrprotos.d/keepalived.conf b/etc/iproute2/rt_addrprotos.d/keepalived.conf
new file mode 100644
index 00000000..9a86251d
--- /dev/null
+++ b/etc/iproute2/rt_addrprotos.d/keepalived.conf
@@ -0,0 +1 @@
+18	keepalived
-- 
2.34.3


