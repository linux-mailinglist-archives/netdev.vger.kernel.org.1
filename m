Return-Path: <netdev+bounces-257246-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMyRHFzChGk45QMAu9opvQ
	(envelope-from <netdev+bounces-257246-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 17:16:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C7FF51B7
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 17:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A5D7C3008619
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 16:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BDB42188A;
	Thu,  5 Feb 2026 16:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPu012I9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B512C0F91;
	Thu,  5 Feb 2026 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770308176; cv=none; b=caVq2G6GB2BDKXeOQt9E4AXWtn5/xfaVRNz+m+xrDc/VkWJqyUEfgsqibuTelIor16hA0BUUl6myVeTTKpiZx8YWh9Dn143J73z0eEy7MLBFG1ZUgppH/D8J6AQ76BkU0OrB6Li+tEO+Rj+piCMmtVpnkjKBoSeuqfFSQyj7nY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770308176; c=relaxed/simple;
	bh=PV2Zzmkef21eRrCOQf0Q175nJBjzm+KyKai2dRqEd3E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oPTpPd4PYgAtq591dwL02MohUcOgtUUOREcLCKS6sXjloJzw6prHY+Se+1zBb56mvRu5CRoicPhaHUA51HuyWSRNEIcPvPwu1YI++F9d0rzbbDLe32kW0lzWBMfCwnTomyA3nnyHUb5NPPAvJCij7hbMQtVnWsDn9jX7Le21ZZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPu012I9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35156C116D0;
	Thu,  5 Feb 2026 16:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770308175;
	bh=PV2Zzmkef21eRrCOQf0Q175nJBjzm+KyKai2dRqEd3E=;
	h=From:To:Cc:Subject:Date:From;
	b=XPu012I95Da8GFicm+it7uSEyUJWRr9grvbTowU01/ql5Q84ZvtvdEMyfi/aEcn8f
	 sPH8R+a1EAD1KaWzDCyO1K9HGkt3BftsC7lGcJyXqWc0qk4VdSR3bdm8jA3o4qU0E0
	 cdd0vMvt/zX2k258Do+FwWpUM3i+CbvBcHtdU6RjKovV7N7Hf9UAz2oqkVmAlZEAfY
	 VfdlPYBsfCsABiURwQ2sRqXLMtj/aVy6Krnpq3e+02yltKjQpmVew6khzAx5HIEKIH
	 sCB+gQG/LPTfNUKNtyqENBtlCSuUgDohv+zTvCax5KYynvezSvNLUC80kGfgR0qjVu
	 9DKwAvY9IjuzA==
From: Arnd Bergmann <arnd@kernel.org>
To: Fan Gong <gongfan1@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Zhu Yikai <zhuyikai1@h-partners.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Xin Guo <guoxin09@huawei.com>,
	Gur Stavi <gur.stavi@huawei.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [net-next] hinic3: select CONFIG_DIMLIB
Date: Thu,  5 Feb 2026 17:13:48 +0100
Message-Id: <20260205161530.1308504-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-257246-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A0C7FF51B7
X-Rspamd-Action: no action

From: Arnd Bergmann <arnd@arndb.de>

The driver started using dimlib but fails to select the corresponding
symbol, which results in a link failure:

x86_64-linux-ld: drivers/net/ethernet/huawei/hinic3/hinic3_irq.o: in function `hinic3_poll':
hinic3_irq.c:(.text+0x179): undefined reference to `net_dim'
x86_64-linux-ld: drivers/net/ethernet/huawei/hinic3/hinic3_irq.o: in function `hinic3_rx_dim_work':
hinic3_irq.c:(.text+0x1fb): undefined reference to `net_dim_get_rx_moderation'

Fixes: b35a6fd37a00 ("hinic3: Add adaptive IRQ coalescing with DIM")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/huawei/hinic3/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/huawei/hinic3/Kconfig b/drivers/net/ethernet/huawei/hinic3/Kconfig
index ce4331d1387b..02d6f91a7f4a 100644
--- a/drivers/net/ethernet/huawei/hinic3/Kconfig
+++ b/drivers/net/ethernet/huawei/hinic3/Kconfig
@@ -11,6 +11,7 @@ config HINIC3
 	depends on X86 || ARM64 || COMPILE_TEST
 	depends on PCI_MSI && 64BIT
 	select AUXILIARY_BUS
+	select DIMLIB
 	select PAGE_POOL
 	help
 	  This driver supports HiNIC 3rd gen Network Adapter (HINIC3).
-- 
2.39.5


