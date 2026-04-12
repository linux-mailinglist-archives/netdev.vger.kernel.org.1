Return-Path: <netdev+bounces-277756-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGlHF2Ns22k/BwkAu9opvQ
	(envelope-from <netdev+bounces-277756-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 11:56:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EF43E35B2
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 11:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33E61300FF91
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 09:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779CC36A01E;
	Sun, 12 Apr 2026 09:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="re+ASIDo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5532F304BA3
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 09:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775987796; cv=none; b=h9t5rbXjBBhA0dDFPyzKBPYLhS0/O706S+qROPCrNd3Kv5ACXQSD7X5rS1FmwP3wpxu6HV1gK9YDmyIJetE4hwtv3uTeogxnD/lr8fqokP2uIHerf7MGdt0CsQhgKkaJ8w4ZrdtI1+DZKVihpn2Ka1JcGILHWV9WDahuH1DPU5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775987796; c=relaxed/simple;
	bh=bWTAU7CtOZ3is69U6C/L35u5+9IkLvK6b+Gt8sgHq14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZppIiurM/S8JPtVNHVuoILucZyKhLkuYG6s7gP4gtHmUHnLK3085cKBII/vnmOR9bjDgWo2tufoeQijjCyYBtI7PnxRD1xZrOdzgLIkjwvY1Y5iLCd2vbNtsXMe+rS6wRUF4eycxNNqy31+atrQRZJ/9unXPvf+GsxQbmAlVJ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=re+ASIDo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E81FC19424;
	Sun, 12 Apr 2026 09:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775987796;
	bh=bWTAU7CtOZ3is69U6C/L35u5+9IkLvK6b+Gt8sgHq14=;
	h=From:Date:Subject:To:Cc:From;
	b=re+ASIDoyvLcewdruxi3zdzfMhuhe06Y4T2is62zvRj1ZVH706WVGyOBTdaPqO3zr
	 Cb1oh8voTefZCIHL7eYKII+R1xERpT+ZaZhlU1LZZOxwVAeinbNbk6HQwuasK+FNeU
	 6oZtugDtdUwltwLBim44z7H9eYCOGuxCLMV5K8jNlhF4PsLAwM/RV8/9mdPdFHTsub
	 eG8x+1Vnxz8/Znl6H+PhptGdJy5NNO2Oh4Jt+kN0oV2uyEvxCn5HaHn4fAvLeVjQmF
	 QdMj9ubzAxjQSPEYa1AKYP9XyXjAC2RZSxVvV7yZLtkPxqjP9lCl8VN6VdP2k864m8
	 xZLnKUYzFoLdA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 12 Apr 2026 11:56:25 +0200
Subject: [PATCH net-next] net: airoha: Remove PCE_MC_EN_MASK bit in
 REG_FE_PCE_CFG configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260412-airoha_fe_init_remove_mc_en_bit-v1-1-7b6a5a25a74d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3NywqDMBBG4VeRWTegobWXVyllSMc/dRZOShJEE
 N+9octvc85OBVlR6NHtlLFq0WQNw6kjmYN94HRqJt/7sT8P3gXNaQ4cwWpaOWNJK3gRhvFbqwu
 3+3SNIpcoI7XKNyPq9j88yVCdYav0Oo4fH3pjxHsAAAA=
X-Change-ID: 20260412-airoha_fe_init_remove_mc_en_bit-a89d7fcc5fc6
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.3
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
	TAGGED_FROM(0.00)[bounces-277756-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C9EF43E35B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PCE_MC_EN_MASK bit in REG_FE_PCE_CFG configuration performed in
airoha_fe_init() is used to duplicate multicast packets and send a copy
to the CPU when the traffic is offloaded. This is necessary just if
it is requested by the user. Disable multicast packets duplication by
default.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 8e4b043af4bc..9b5b677a7071 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -458,9 +458,8 @@ static int airoha_fe_init(struct airoha_eth *eth)
 		      FIELD_PREP(PSE_IQ_RES2_P5_MASK, 0x40) |
 		      FIELD_PREP(PSE_IQ_RES2_P4_MASK, 0x34));
 
-	/* enable FE copy engine for MC/KA/DPI */
-	airoha_fe_wr(eth, REG_FE_PCE_CFG,
-		     PCE_DPI_EN_MASK | PCE_KA_EN_MASK | PCE_MC_EN_MASK);
+	/* enable FE copy engine for KA/DPI */
+	airoha_fe_wr(eth, REG_FE_PCE_CFG, PCE_DPI_EN_MASK | PCE_KA_EN_MASK);
 	/* set vip queue selection to ring 1 */
 	airoha_fe_rmw(eth, REG_CDM_FWD_CFG(1), CDM_VIP_QSEL_MASK,
 		      FIELD_PREP(CDM_VIP_QSEL_MASK, 0x4));

---
base-commit: 3f3a2aefbc661b837c8e344f944982d61c2ae037
change-id: 20260412-airoha_fe_init_remove_mc_en_bit-a89d7fcc5fc6

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


