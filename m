Return-Path: <netdev+bounces-296732-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qScVBmkzJ2r9tAIAu9opvQ
	(envelope-from <netdev+bounces-296732-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 23:26:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A40865AA9C
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 23:26:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SDk+vO2x;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296732-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296732-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66D6430166E7
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 21:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45723A6B8E;
	Mon,  8 Jun 2026 21:24:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20E83A1692
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 21:24:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780953876; cv=none; b=u3eePd2H9MRBP9MQ+oE/2fDxF1LV7Y9VwYWZuZVKF5wl5Sn4iH8Zy/vgQCjAablrxWx3XYed0Bsk086KktA8LQOJg04mwhzylVqYwJmiBR+z6fBH200XuaBEB7BSh5KVBG5j49K4kvchtRm8dQT+efvqMAM5y+ZOpyIJPIz3PZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780953876; c=relaxed/simple;
	bh=hzqHs/N7bvU5y5Bt6hG/uOeUkAoZGusVvmv3UUUILiY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YnlYAxGZQkYFwz1IYOAo/iuM10pUHD1izLCGtu4Mb0hyU8eOH7RrtoAALwWOYs4r8qNqM50363yNludeuZh+1rVpvae3yr12b/3QRTvQ0tdXMENdLpTRFmrHK8FNBU70+TbywBgqBHlJUAD01PEVYwrmuftnQKf7hmaS0SqERu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDk+vO2x; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09FD91F00893;
	Mon,  8 Jun 2026 21:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780953875;
	bh=5iNM2oNSuXbhf+0XmfrlArQGwY2yx5spc/F/HyXY+oI=;
	h=From:Date:Subject:To:Cc;
	b=SDk+vO2xgUwXGGWtyiI+J91tlK6Gzzltz/c9sj+I6bv3lcZQVVVPnb3XuxDNq7Qtg
	 JYPJp3m7Wt1N9zqxLSxO5stkcQd7rk8nPM/oqfdoVwsqsxJaKeauAh1t+ScTc/kGqQ
	 YqCkokyogvSC78opG/3KD4BmEVRfrBxqS/csgipFL8XpJIALVfQFYuJZw54Vvc1lIf
	 dn4/t6YDyo1E/GnyRonoM7U3CktcpVFtS5ykf/jmfP18ZceIZFE3Z5UT4gFNCybMoJ
	 zKZNLgdpj9yK7EQd+N07Mcs8OMGOBwGeyrDeIqUjw7AQ2RFgVeWw0TYh09LwMmr/0h
	 5IJvDkncJtklA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 08 Jun 2026 23:24:15 +0200
Subject: [PATCH net-next] net: airoha: move get_sport() callback at the
 beginning of airoha_enable_gdm2_loopback()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-airoha_enable_gdm2_loopback-minor-change-v1-1-1787a0f42b31@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NQQqDMBAAvyJ7biAmNJR+pZSwmlWX6kY2IoL49
 4bS4xxm5oRCylTg2ZygtHPhLBXaWwP9hDKS4VQZnHXBBvswyJonjCTYzRTHtLg457x22H/MwpL
 V/L0hoUfv7y3aADW3Kg18/FYvENqM0LHB+7q+8TWxZoQAAAA=
X-Change-ID: 20260608-airoha_enable_gdm2_loopback-minor-change-fda3a3351a06
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296732-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6A40865AA9C

Move the get_sport() callback invocation at the beginning of
airoha_enable_gdm2_loopback() routine in order to avoid leaving the
hardware in a partially configured state if get_sport() fails.
Previously, get_sport() was called after GDM2 forwarding, loopback,
channel, length, VIP and IFC registers had already been programmed.
A failure at that point would return an error leaving GDM2 with
loopback enabled but WAN port, PPE CPU port and flow control mappings
not configured.
Performing the get_sport() lookup before any register write guarantees
the routine either completes the full configuration sequence or exits
with no side effects on the hardware.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 5a8e84fa9918..cbc0f4079df0 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1905,6 +1905,10 @@ static int airoha_enable_gdm2_loopback(struct airoha_gdm_dev *dev)
 	u32 val, pse_port, chan;
 	int i, src_port;
 
+	src_port = eth->soc->ops.get_sport(port, dev->nbq);
+	if (src_port < 0)
+		return src_port;
+
 	airoha_set_gdm_port_fwd_cfg(eth, REG_GDM_FWD_CFG(AIROHA_GDM2_IDX),
 				    FE_PSE_PORT_DROP);
 	airoha_fe_clear(eth, REG_GDM_FWD_CFG(AIROHA_GDM2_IDX),
@@ -1934,10 +1938,6 @@ static int airoha_enable_gdm2_loopback(struct airoha_gdm_dev *dev)
 	airoha_fe_clear(eth, REG_FE_VIP_PORT_EN, BIT(AIROHA_GDM2_IDX));
 	airoha_fe_clear(eth, REG_FE_IFC_PORT_EN, BIT(AIROHA_GDM2_IDX));
 
-	src_port = eth->soc->ops.get_sport(port, dev->nbq);
-	if (src_port < 0)
-		return src_port;
-
 	airoha_fe_rmw(eth, REG_FE_WAN_PORT,
 		      WAN1_EN_MASK | WAN1_MASK | WAN0_MASK,
 		      FIELD_PREP(WAN0_MASK, src_port));

---
base-commit: 903db046d5579bef0ea699eae4b279dd6455fc9f
change-id: 20260608-airoha_enable_gdm2_loopback-minor-change-fda3a3351a06

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


