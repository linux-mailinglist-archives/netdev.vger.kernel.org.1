Return-Path: <netdev+bounces-273023-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id smTyHNOhyWlD0QUAu9opvQ
	(envelope-from <netdev+bounces-273023-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 00:04:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C9A3543E3
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 00:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2AF43001828
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 22:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072782DC767;
	Sun, 29 Mar 2026 22:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAfRSMz0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85842D978C
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 22:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774821838; cv=none; b=YWiE7zC3VEN7F0OYxqj2NBuMyPMa1+JdiWM0diWQbs0PD0GHzPpAUeru2GOQ7yuiv33seQYMAw3nRiIu0Wn9TIuR5wSirE9C5jNp/l8xya8oVOWUVx3OCqeYw+6NfNOCzYaCHnSnW8E2zg9ybdBXsweCKSSfw9qItmfXd84+kr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774821838; c=relaxed/simple;
	bh=6yn7EwahshMP7t8gqyl8uwicrBe/9zbJ4Uog9xwOHv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BtAW7GAEgrGh4RYXqo3chtWnbJi0IKI6Ymd2s7V6c9j8sfhTjw/PQ28AtN3fO6DCiUL099V7yPbR+W/DWypVemTKZsIJP9Pe7EOcUPq1IkWXIA2VgnWgE2htu1bLb9nFR3btIBxQ2ldi+655MJ5JwCIKdyWlTUMAJ+O7GF7R/9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAfRSMz0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39119C116C6;
	Sun, 29 Mar 2026 22:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774821838;
	bh=6yn7EwahshMP7t8gqyl8uwicrBe/9zbJ4Uog9xwOHv0=;
	h=From:Date:Subject:To:Cc:From;
	b=ZAfRSMz0wkc+I1P/TrrvJfqM2Aq9vVJMq62NhtG6qrQkyvL4HCmwEhUVoKFd4lI5h
	 4GpnaiCeG0k8vEEUsxIwlbGcG5hyylgYGnt25APxWcuNFL+eqn+sOTIrXsqXaoZQPQ
	 ftrR0nITFRxSUx6C3YjIinCn2R0klplk16HU37jieJnotbKuOh3VeDyKUEO3S6tU14
	 CNtN4q7iKFjYiPNd6Iy/qjkBtnc85evSC6Xjhxud7m8wRlQsz5x16bVfi6bQoYe+jd
	 6Nbb8I/SnUEaw9ZXXb6NJQnZFWyqgUdWlPsWTkds/2aw+FYhjxU6suBjY5DVqgJBEX
	 qgp0PteYCkiMQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 30 Mar 2026 00:03:49 +0200
Subject: [PATCH net-next] net: airoha: Fix typo in airoha_set_gdm2_loopback
 routine name
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-airoha_set_gdm2_loopback-fix-typo-v1-1-a1320ff6b6cc@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NQQrDIBAAvxL23AU1NdB+pRSxZpMsbV1RKSkhf
 4/kOAzMbFAoMxW4dxtk+nFhiQ30pYOw+DgT8tgYjDKD6s0NPWdZvCtU3Tx+jfuIpJcPb5x4xfp
 PgoGs7rWy18kO0DopU3Pn4wGRKkZaKzz3/QCPiBUufQAAAA==
X-Change-ID: 20260329-airoha_set_gdm2_loopback-fix-typo-ce5131054f56
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273023-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D6C9A3543E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Rename airhoha_set_gdm2_loopback() in airoha_set_gdm2_loopback()

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 82e53c60f561f6314fbf201ba8bc8711e40edc68..2beba017e791d20f142e754edafcd402d8cc496f 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1709,7 +1709,7 @@ static int airoha_dev_set_macaddr(struct net_device *dev, void *p)
 	return 0;
 }
 
-static int airhoha_set_gdm2_loopback(struct airoha_gdm_port *port)
+static int airoha_set_gdm2_loopback(struct airoha_gdm_port *port)
 {
 	struct airoha_eth *eth = port->qdma->eth;
 	u32 val, pse_port, chan, nbq;
@@ -1785,7 +1785,7 @@ static int airoha_dev_init(struct net_device *dev)
 		if (!eth->ports[1]) {
 			int err;
 
-			err = airhoha_set_gdm2_loopback(port);
+			err = airoha_set_gdm2_loopback(port);
 			if (err)
 				return err;
 		}

---
base-commit: cf0d9080c6f795bc6be08babbffa29b62c06e9b0
change-id: 20260329-airoha_set_gdm2_loopback-fix-typo-ce5131054f56

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


