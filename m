Return-Path: <netdev+bounces-262118-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGs2NqDdomli7QQAu9opvQ
	(envelope-from <netdev+bounces-262118-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 13:20:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 837B31C2EC6
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 13:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB1003034C40
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 12:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7B142E01C;
	Sat, 28 Feb 2026 12:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJCVLLOv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB557364944
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 12:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772281245; cv=none; b=CJJiY41PdOFRnQDQE4yqiYe2ciI2ocWWkg0vVUdgppFOTTGAUaFEe5bWRyBnFa/YjVt5mlLGpua6gGDY1+SvFaLh2qwijQk41T7GKB6GVc5ioMA3xh9IBRxljkeUWZyjNRDLYAHRFv103ZRe7+sggg6VZX1nzuzfSF5G7PFLXyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772281245; c=relaxed/simple;
	bh=XIWu8pVNZqGo5T8Mi5TvCmyxj2UX5isJ1r649II4YGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OptR0N5DmH8len3cxwDFpT+oWOMQGMHOpl6PlKXLk1CAh1UBkk1T/SfnUTyu1aHASaLNOuVxu1i3yllcsrAP5LYIr90zJPKAsIgVqHJU8Sqq1IBVeFjvB4cg7lXIw6jyKbQzBHy6CiefU511NkdicoIL+bSwH4vkRQA0KSFCZ8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJCVLLOv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC11DC19424;
	Sat, 28 Feb 2026 12:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772281245;
	bh=XIWu8pVNZqGo5T8Mi5TvCmyxj2UX5isJ1r649II4YGc=;
	h=From:Date:Subject:To:Cc:From;
	b=YJCVLLOvaG0vBS+h9Gw34jdd164fJQJj0T56BnTYHo0raVj4p0biZQZ/ynQFMHQI9
	 nDejSKePPOoPW+U5HIJPfJ76XyB9cbe22p4S8tD1sG7iV+lxRVNqwGKyYbd7mC+IA+
	 TJx8zZyvlVD1CyjzX3Q2xUqeJBwd39wVIMzRpUX25DS2QiU72aCYC+HnWejjWxhc1m
	 wblqClO3nIsmYBkzPexh7g9+HuAmFtMCLcJ1fr2iiPJsIR+RrRrA3vWwmSCaC3C1bz
	 4XKVct9K4GfOdRN6/KdlQh+B9lUfoY+deaX6UQeNjCvSS6tlr0isPqlYqj/ztezeNN
	 6+7tNTPicIeTw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 28 Feb 2026 13:20:33 +0100
Subject: [PATCH net-next] net: airoha: Fix GDM2 loopback configuration for
 USB serdes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260228-airoha-fix-loopback-for-usb-serdes-v1-1-a94be0f897da@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NywqDQAwAf0VybmA31O3jV0oPUWMNLUYSLAXx3
 116HBhmNghxlYB7s4HLV0NtrpBPDfQTzy9BHSoDJSqJ6IqsbhPjqD/8mC0d928czXGNDmtrkEA
 ql8Qpn0u+tVBDi0vV/5PHc98PW9URsnQAAAA=
X-Change-ID: 20260228-airoha-fix-loopback-for-usb-serdes-2670a0146195
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262118-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 837B31C2EC6
X-Rspamd-Action: no action

Flow Control source port mapping for USB serdes needs to be configured
according to the GDM port nbd parameter. This is a preliminary patch
since nbd parameter is specific for the given port serdes and needs to
be read from the DTS (in the current codebase is assigned statically).

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c  | 10 ++++++----
 drivers/net/ethernet/airoha/airoha_regs.h |  5 +----
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 3779f93b47bc13ae21d4ae088dece4712dc214e5..37fc2b33d3af8a190a74efc69ed54f163afa6412 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1729,10 +1729,12 @@ static int airhoha_set_gdm2_loopback(struct airoha_gdm_port *port)
 		      SP_CPORT_MASK(val),
 		      FE_PSE_PORT_CDM2 << __ffs(SP_CPORT_MASK(val)));
 
-	if (port->id != AIROHA_GDM3_IDX && airoha_is_7581(eth))
-		airoha_fe_rmw(eth, REG_SRC_PORT_FC_MAP6,
-			      FC_ID_OF_SRC_PORT24_MASK,
-			      FIELD_PREP(FC_ID_OF_SRC_PORT24_MASK, 2));
+	if (port->id == AIROHA_GDM4_IDX && airoha_is_7581(eth)) {
+		u32 mask = FC_ID_OF_SRC_PORT_MASK(nbq);
+
+		airoha_fe_rmw(eth, REG_SRC_PORT_FC_MAP6, mask,
+			      AIROHA_GDM2_IDX << __ffs(mask));
+	}
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethernet/airoha/airoha_regs.h
index ed4e3407f4a0e8b6a630ea1213ef155604479b66..29878b954c77c79ae45e63357840a10c23c517f2 100644
--- a/drivers/net/ethernet/airoha/airoha_regs.h
+++ b/drivers/net/ethernet/airoha/airoha_regs.h
@@ -376,10 +376,7 @@
 #define SP_CPORT_MASK(_n)		GENMASK(3 + ((_n) << 2), ((_n) << 2))
 
 #define REG_SRC_PORT_FC_MAP6		0x2298
-#define FC_ID_OF_SRC_PORT27_MASK	GENMASK(28, 24)
-#define FC_ID_OF_SRC_PORT26_MASK	GENMASK(20, 16)
-#define FC_ID_OF_SRC_PORT25_MASK	GENMASK(12, 8)
-#define FC_ID_OF_SRC_PORT24_MASK	GENMASK(4, 0)
+#define FC_ID_OF_SRC_PORT_MASK(_n)	GENMASK(4 + ((_n) << 3), ((_n) << 3))
 
 #define REG_CDM5_RX_OQ1_DROP_CNT	0x29d4
 

---
base-commit: 621e3634dfab890e8d97e082588b3d6d6d688d91
change-id: 20260228-airoha-fix-loopback-for-usb-serdes-2670a0146195

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


