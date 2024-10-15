Return-Path: <netdev+bounces-135456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B5499E00D
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 09:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D6F3283372
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 07:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC42E1C3314;
	Tue, 15 Oct 2024 07:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSCE9mic"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82FC1B85CC
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 07:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979110; cv=none; b=Io58jqMaZzpjuXvVJCSDNfv1o6MsVxF5UI6dzrYMQixoC37R8vDbd0m0XAyBRVlHxDVMipuwWSKO1oV3QDwe74ZY7KzYiGbOG6uiBlKoA+zIY9IpVURXoMfvXV0m3eIODz3KKjIo9ZJwZ2Qmho0eUVQprrCRUz3j9+E1uKp3GmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979110; c=relaxed/simple;
	bh=rvW2wHCfM1t7JqZTRgngSugH0a6MrEwATljOLSw10Dg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GUjus+xn0t4rr2Cw9bs3NszbSUPScjst7u1Tmkdms2Zh6VANQZMXM6ELHkfBlG/FASbQjFc7dyQYNNtw8KVdVmDcFQ/KcZctXyZWuX35xt9lD3B5l2vJq6CYC/COkoof3YXx6WO5+jFdIKpW4SKXlP0VlTixj8tuw3MtHgBLks4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSCE9mic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF396C4CEC7;
	Tue, 15 Oct 2024 07:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728979110;
	bh=rvW2wHCfM1t7JqZTRgngSugH0a6MrEwATljOLSw10Dg=;
	h=From:Date:Subject:To:Cc:From;
	b=lSCE9mic9AaeJuK5pOaJwQwSfeqTB65pEIcACMfZsZXJPl91NWQ97Nv8e8ULAk0jy
	 MiHpa0H/7O7ItH5LXOGzBFs2KXkBPWR0HogEdHID3g0y893US0490Dv4Ap8V//zr6f
	 /c5t+FLAGbW+F3KorjZ6Vq/oJvqYkpfHGX9xbabmZ+3dSS5GXPkccTyqkuAPirR4P6
	 BwWTFo+w/Y8+h/W3Azp8WCDA4ztygcb0+TtSLXOMs1+jD2kh/Cw701b9qvYISzi2IY
	 /fmHqD4QNKT4iekXzTAP7Ii2fd/rFAJKUb6/5YtsbUYPZJfKxs5d91oIzNk2OJWJyV
	 BS4RlL69+lZIg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 15 Oct 2024 09:58:09 +0200
Subject: [PATCH net-next] net: airoha: Fix typo in REG_CDM2_FWD_CFG
 configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-airoha-eth-cdm2-fixes-v1-1-9dc6993286c3@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJAgDmcC/x3LPQqAMAxA4atIZgNp7GC9ijiUNtoM/tCKCOLdL
 Y4fj/dAkaxSYGgeyHJp0X2rMG0DIfltEdRYDUxsDRmLXvOePMqZMMSVcdZbCjqOjlxHPZOF+h5
 Z/lDXcXrfD4Wme5lnAAAA
X-Change-ID: 20241014-airoha-eth-cdm2-fixes-92d909308204
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Mark Lee <Mark-MC.Lee@mediatek.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: lorenzo@kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 ChihWei Cheng <chihwei.cheng@airoha.com>
X-Mailer: b4 0.14.2

Fix typo in airoha_fe_init routine configuring CDM2_OAM_QSEL_MASK field
of REG_CDM2_FWD_CFG register.
This bug is not introducing any user visible problem since Frame Engine
CDM2 port is used just by the second QDMA block and we currently enable
just QDMA1 block connected to the MT7530 dsa switch via CDM1 port.

Introduced by commit 23020f049327 ("net: airoha: Introduce ethernet
support for EN7581 SoC")

Reported-by: ChihWei Cheng <chihwei.cheng@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index e037f725f6d3505a8b91815ae26322f5d1b8590c..45665a5b14f5c646d23aaf4830e55a118e9f1a8a 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -1371,7 +1371,8 @@ static int airoha_fe_init(struct airoha_eth *eth)
 	airoha_fe_set(eth, REG_GDM_MISC_CFG,
 		      GDM2_RDM_ACK_WAIT_PREF_MASK |
 		      GDM2_CHN_VLD_MODE_MASK);
-	airoha_fe_rmw(eth, REG_CDM2_FWD_CFG, CDM2_OAM_QSEL_MASK, 15);
+	airoha_fe_rmw(eth, REG_CDM2_FWD_CFG, CDM2_OAM_QSEL_MASK,
+		      FIELD_PREP(CDM2_OAM_QSEL_MASK, 15));
 
 	/* init fragment and assemble Force Port */
 	/* NPU Core-3, NPU Bridge Channel-3 */

---
base-commit: 60b4d49b9621db4b000c9065dd6457c9a0eda80b
change-id: 20241014-airoha-eth-cdm2-fixes-92d909308204

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


