Return-Path: <netdev+bounces-261140-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKyCHQuzn2kpdQQAu9opvQ
	(envelope-from <netdev+bounces-261140-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:42:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E071A02D6
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B82CA3042B7D
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154F8379989;
	Thu, 26 Feb 2026 02:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="PGF5kZWO"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AC7361DAE;
	Thu, 26 Feb 2026 02:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772073493; cv=none; b=OwXAa+y5OIBBpwdEjVqi/i5hfEGXVYsalSB5zGyCq0Qn+LBCe4s2TOHEujOkyfjyu7KcOXSmVdcs1R9amjbcWmPpYZC0T+355oyY3ypC1hn2usKUIynbmrCjxA9mQJYKNgl6URNdYVzWKwRi+VAOe6aBi/V6X42qrv060mv+jVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772073493; c=relaxed/simple;
	bh=g5haHZm8e7PnYlb0LPTN0ha+hOHkoWSv4+6HUnLH95s=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Fqy/NE/NMmpFx5W8lJzzHjFk88OhldvtdkJ97FRICuAo3ldvoat13WDZnMA50SO39IWNoM6+ssXV9eeMJT3cINNsj+Jjgx/46EVsoTsvUFNo82lKiRfXvUWjuKV66OsuhkYS2QfWGBJLKgXbid1qzmHumK//s7ZFHCsBDcuYOeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=PGF5kZWO; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1772073478; bh=vByrrmuYq8JjbY0LQ9meQth0I8mJWC5qiADKGasmzwU=;
	h=From:To:Cc:Subject:Date;
	b=PGF5kZWOwnTt8e61AUOsqMiexe9wcf5o5QcrekXR3i4YM1H3IetPaupJ53PX+U7ZJ
	 9YNC4S/Zyjrv3toYMyXyr88THGnmqOVRdATNGecfVN0utENWNuAUnGiC9sK/1X619B
	 PelhCvbFc3hMcuWmbuFKQiFPuOzTFDP7rWRDIsQY=
Received: from PC24010019.. ([38.150.8.229])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 96B15423; Thu, 26 Feb 2026 10:37:43 +0800
X-QQ-mid: xmsmtpt1772073463t06a9u899
Message-ID: <tencent_E4FD5D6BC0131E617D848896F5F9FCED6E0A@qq.com>
X-QQ-XMAILINFO: MeukCuWaRbQlPPIO4Jinb8VNP1gkfsKHtBFkcmKFxGqfHtznrB+MrcwoKn0VZ7
	 89rQx2rLA3LMDXkigBh1LjAghFT081elnyMXkIOyo0WZ1jDb5Ktsg0JU5Iab/Nvb5JKYTMoiPYAv
	 JSgtmApBbwxAnclrQqZcTejRPIULepviitqIyXsCLxDob/h2sqS/2j8V+N4zklvwJkKdYdRGIPSl
	 h9FG0Xjlrn4m3mIOZXJF+Vl5cvJ/jnTlxd9af5kxvcxSs6w1j+D+084kqrXoKM+8cfFJrL5OrJhU
	 MTCaol6wY6lqqP2mvLNftLplHWu50cRbevMF/zgRMryxirpPcf853YBMkNL1vHtxdzGtvCKUIP0L
	 9ox4BgEZlaUPo3yXY+g+bqAQX0f251KOYk2qr44NCPvcyCDYzVMuPtq+NcsM3zIGDWkLAxnHHbv7
	 VGbQuQQEttW3VnFhYxrGRt/BMBJSsjjZ4ragTSY+9LXNxR0x615182eO+fF3k66O+PppDgrAODXj
	 3ypRkW+r9uGmS5TY+JRvVNIqRhUJVZ+m8wis0PuoiZfzKfdMvILQgfv4um/Q/Dl1OEbJarLsPOh6
	 8oVE0K4+QobAcExEpU1tus8vxewd5h7qC6e16pnAy283XsK1KYktxR+7igxGHxjWWUuAdk3ia42D
	 6Wixy1Zvbtd2+gNDAaAMkG3KL5moQ8eD7CHbYF9K/28SeNA1jo+q/o3l4RAgxXrJ2t6dHcwNi3oQ
	 4MZQoShWxSwEeQ25MksSHDMCkzGvq/oREZv/qmJrN6NqQNUsVJnyF1R4Fc9q0Wa54MxNIl9hql7a
	 LrNmnu2Axh3YTjSsdMjg5dFcxHsoCXjr039EDeExLkRXZoCHhWwcibkI8sgh8TdfyQU4KHutlu0N
	 fCXpdG1o6OAlq3vWYka2bV0sfNN5Uio1cleiOCxNtkORTCBXmYjO1WU+RB7itOWipEBx2PzvW8DZ
	 6deFnguQ6rHWt01zADmGCN4penNJxjGUxq+gr3pREELN82ijzCwzICCpxheTXGV2DX31fqPzA7qj
	 aG1Ignsja1v1TgLaTkn2Kp/cWfDEA2roDrsqcQa0MXqdWsXvNTDEhmn16rGXgC2/GPxV4p+A==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Zhengping Zhang <aquapinn@qq.com>
To: lorenzo@kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	zhengping.zhang@airoha.com,
	upstream@airoha.com,
	Zhengping Zhang <aquapinn@qq.com>,
	Simon Horman <horms@kernel.org>
Subject: [RESEND PATCH net-next] net: airoha: fix typo in function name
Date: Thu, 26 Feb 2026 10:37:08 +0800
X-OQ-MSGID: <20260226023707.2077737-2-aquapinn@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261140-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lists.infradead.org,vger.kernel.org,gmail.com,collabora.com,airoha.com,qq.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aquapinn@qq.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 44E071A02D6
X-Rspamd-Action: no action

Corrected the typo in the function name from
 `airhoa_is_lan_gdm_port` to `airoha_is_lan_gdm_port`. This change ensures
 consistency in the API naming convention.

Signed-off-by: Zhengping Zhang <aquapinn@qq.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 2 +-
 drivers/net/ethernet/airoha/airoha_eth.h | 2 +-
 drivers/net/ethernet/airoha/airoha_ppe.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 62bcbbbe2a95..3779f93b47bc 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -76,7 +76,7 @@ static void airoha_set_macaddr(struct airoha_gdm_port *port, const u8 *addr)
 	struct airoha_eth *eth = port->qdma->eth;
 	u32 val, reg;
 
-	reg = airhoa_is_lan_gdm_port(port) ? REG_FE_LAN_MAC_H
+	reg = airoha_is_lan_gdm_port(port) ? REG_FE_LAN_MAC_H
 					   : REG_FE_WAN_MAC_H;
 	val = (addr[0] << 16) | (addr[1] << 8) | addr[2];
 	airoha_fe_wr(eth, reg, val);
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 20e602d61e61..59ed7569f7c3 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -626,7 +626,7 @@ u32 airoha_rmw(void __iomem *base, u32 offset, u32 mask, u32 val);
 #define airoha_qdma_clear(qdma, offset, val)			\
 	airoha_rmw((qdma)->regs, (offset), (val), 0)
 
-static inline bool airhoa_is_lan_gdm_port(struct airoha_gdm_port *port)
+static inline bool airoha_is_lan_gdm_port(struct airoha_gdm_port *port)
 {
 	/* GDM1 port on EN7581 SoC is connected to the lan dsa switch.
 	 * GDM{2,3,4} can be used as wan port connected to an external
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 2221bafaf7c9..9e07b4653af1 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -321,7 +321,7 @@ static int airoha_ppe_foe_entry_prepare(struct airoha_eth *eth,
 			/* For downlink traffic consume SRAM memory for hw
 			 * forwarding descriptors queue.
 			 */
-			if (airhoa_is_lan_gdm_port(port))
+			if (airoha_is_lan_gdm_port(port))
 				val |= AIROHA_FOE_IB2_FAST_PATH;
 			if (dsa_port >= 0)
 				val |= FIELD_PREP(AIROHA_FOE_IB2_NBQ,
-- 
2.43.0


