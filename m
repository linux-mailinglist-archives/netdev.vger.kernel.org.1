Return-Path: <netdev+bounces-243127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEC8C99BCD
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 02:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0A2C3A4D8E
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 01:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE951CDFD5;
	Tue,  2 Dec 2025 01:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="L2RL8h/0"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525AC147C9B
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 01:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764638817; cv=none; b=gb3M+HfvyvCD9HsDD+etMt/98hfcd0L+r77Z/ayRJIEh5LSMe6knWaw8pQtINfryFQ5xgsW2d76wtcMyhgejSSm5AscEsfRRApyePaTsXclqL236b4vllpCXkGKeP4iKSIRvhj1n8UjdxH9vmrSiT+/hei/ZJ0GB9cOKs1N4pDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764638817; c=relaxed/simple;
	bh=jtZSYvYvxHMQ42/AgIoOO5SoV9XaVZjPWtOcpJAia2E=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=aWl0hgegWLM9niHFYQrS9B1aWV5qhJyUsDi9aAwZKB8REbIaNQTy+RSmKHcoHbTgsSEDmZSCOMDGQPXiMwmim7inMboJqV1nmwtL5RDXwjdDlovnDMWjhh8/VhBB0EW6PG+0IYEC0KccF4qfum3DMq5vuHyfpKBpivN/3LxO7nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=L2RL8h/0; arc=none smtp.client-ip=203.205.221.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1764638812; bh=CaYtSrdTuY3LdNTkqnJne197fCiBenWiXbiINPfbnG0=;
	h=From:To:Cc:Subject:Date;
	b=L2RL8h/05ordF0lbp4JtfCJ3T68yJkG73bXzxH8s85dsnAE1JNcafMte68HSeDUzB
	 w0QPGGqZ1gsS1wpvieMslgoP0kIM51dY77oHPERYeKuvoRXh+q/tP/oGT81nk2c2mN
	 iE2eDkwfap+xXaD8LnRykf0iJcBJQR0vRoLUpDFA=
Received: from localhost ([58.246.87.66])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 66917EC1; Tue, 02 Dec 2025 09:25:41 +0800
X-QQ-mid: xmsmtpt1764638741tk6h6a860
Message-ID: <tencent_A2BE4EE4983E2DD19E67E0D5CC6564D1D309@qq.com>
X-QQ-XMAILINFO: MCBrDuJrLGvm96QTQNCSgt319yUPHNDEBL/hOoPTn9fw3IHsad4deE7X/dXCDq
	 rMPe/We7COAK9awPn+nMofPiTvd5ovxyZGYoImBFw/uzZPqMbzDAqXKt0crK1ux6UsLLRt8kPhtm
	 CEJaNt6D5+uu8R3EcPb6ak//tiNaw+4VwREa0jpKiT01sIFRhIL+CZKZsePnn5LoeAm0lK40w4Ff
	 XTV6EP/Lqzt5kJeNjLj9zl2S0xGA+l+mRFg6kXo1PwVm/bYZJuEfEDYXhBK5YXaiSo7HYwkvXjfN
	 sQk5LHimThmfUwnqm8N5IvPkdoUHet5nm3PNXTBi8HCNm2T48y/92lyV2lzMJeVCD/r4ANk2SXoE
	 xtazQaCuMrCjj1Yho77mSnZKZh1O/FTqW7ogGZK6VJVRPG/YzL2v1US5TIOAkcHxDH9kUJ9wFqTF
	 qjV5tAEtpwjEp4Wrh87e2mWLTcXkVechEIvmpbnfOPxFpWUShO2Jt0zTEi7y2gXZjLW2WJbb+OuO
	 SUxo7AEF25rYaotyNjsS3ouh9MUAgj7sZ7dT16FVkEKHqcj0n3b3QMrsVftxC5tAv+GQt5Hn2FIR
	 Br6Av3r0rYyG2Q3z5Hk43McSy27deBWAdhUd0Ur2owEuOnJ3aH9MempwI69CH2IGYtwBVjwcfoyr
	 jzIkYahOCn4EmqE+J5Gn936g07QsDsX0o7+zNrxSEb4XwHM63DHjk/Eqygaehl3QQN/Dp+/ddGPo
	 VIf2V+yKxXiEr94Dn+0kj5aCh95K8/VNeUN8xMeNF/6TQTRrbf8KZpRxBuUFnFDMZLTjgiSyy7u2
	 ttd+KHu3O1a6PJ3N7f0XvXTzWpjqzgVoe7jX1M9GbMa/oElFFGo5z0wnzGGsdnxR0DuwMftixUNM
	 /NfXcesW+FYhcNVlhRdPetDqlr3dEZRWxxWxDvbAiZwLphpwcC19DX96SHMubuz7KbfBt5R1TQBh
	 hnP5y8h4oUkLcZnEGueqxUVVCbyczZ
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: 2694439648@qq.com
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	hailong.fan@siengine.com
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	inux-kernel@vger.kernel.org
Subject: [PATCH v1] net: stmmac: Modify the judgment condition of "tx_avail" from 1 to 2
Date: Tue,  2 Dec 2025 09:25:39 +0800
X-OQ-MSGID: <84d25646b6651dd52fcecd9036a877b0069b806e.1764638311.git.hailong.fan@siengine.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "hailong.fan" <hailong.fan@siengine.com>

    Under certain conditions, a WARN_ON will be triggered
    if avail equals 1.

    For example, when a VLAN packet is to send,
    stmmac_vlan_insert consumes one unit of space,
    and the data itself consumes another.
    actually requiring 2 units of space in total.

    ---
    V0-V1:
       1. Stop their queues earlier

Signed-off-by: hailong.fan <hailong.fan@siengine.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7b90ecd3a..738a0c94d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4529,7 +4529,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 		}
 	}
 
-	if (unlikely(stmmac_tx_avail(priv, queue) < nfrags + 1)) {
+	if (unlikely(stmmac_tx_avail(priv, queue) < nfrags + 2)) {
 		if (!netif_tx_queue_stopped(netdev_get_tx_queue(dev, queue))) {
 			netif_tx_stop_queue(netdev_get_tx_queue(priv->dev,
 								queue));
@@ -4675,7 +4675,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 		print_pkt(skb->data, skb->len);
 	}
 
-	if (unlikely(stmmac_tx_avail(priv, queue) <= (MAX_SKB_FRAGS + 1))) {
+	if (unlikely(stmmac_tx_avail(priv, queue) <= (MAX_SKB_FRAGS + 2))) {
 		netif_dbg(priv, hw, priv->dev, "%s: stop transmitted packets\n",
 			  __func__);
 		netif_tx_stop_queue(netdev_get_tx_queue(priv->dev, queue));
-- 
2.34.1


