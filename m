Return-Path: <netdev+bounces-271837-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONB8NLXCxGku3QQAu9opvQ
	(envelope-from <netdev+bounces-271837-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 06:23:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED7F32F596
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 06:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90D183055DD6
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 05:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1326359A79;
	Thu, 26 Mar 2026 05:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+SH05WW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DD5344DB5;
	Thu, 26 Mar 2026 05:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774502339; cv=none; b=dhauZm4ynsYQPxXKkAzRB8PJou11A0RYdx5PMb83RnQJaQnmJOyGhGYwZY+a9roTwCqiFFEEM1hywNAi9V+jGzVwQ7YKPb8HmFSMqRVf2l0ZIjNCEPyP2Tethg7ggJNlbxXszzraMfL1cGx920fj2R4ob5PW1bTGLMWYhrgXshI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774502339; c=relaxed/simple;
	bh=GaJWaVTbn/UL3B4IZ3JOup4VGmfvjwuuWoZ7Ej05S78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lT4LaAbok1SMdqVjBsj3BqbeaCuG8KNWeGUZDJcRa7zdVaE3fu8b5E9Yil39VQPy7J1PDKZG5bzRnRFIHhk2oeeObkryjmsNZDlOHbx8dcqoMKiUC0NGfPzUEZIXpoYTi79SZHyzbmYPhXCc20gw4UZjIlVgaS2F3XovkBDQ0KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+SH05WW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D623C2BCB1;
	Thu, 26 Mar 2026 05:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774502339;
	bh=GaJWaVTbn/UL3B4IZ3JOup4VGmfvjwuuWoZ7Ej05S78=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=A+SH05WWMZAWbAjWDLduJrTACdXoQTHUfU3Ur+ZJwDbqx3NfS+v2fT7pVW1iBU8p4
	 TcCxG1EW+U9FRRRqbT0Nq4AyuL8h956XIN/KkpJQl0OllErcCJGfinDupgazCvHST2
	 Pyonj5p4LLj6767qCNTAV11MdjVA4fxEU/PyZgUxCuYrJa7Gyo2rgGFHFCqb0VOqpz
	 1EehLuAt+XGpFNTH2splid+x3qsJTvjoybV7LErRyVse114TOkOso/e+s73gHpv16s
	 vPsLcdfO/evYW68mOywnqdW66xXz8KFUj50i4mrd7vXUrtoPmU7t6fwZVSgVauYFJZ
	 DFKMviVGpd2HQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300D5109E54B;
	Thu, 26 Mar 2026 05:18:59 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Date: Wed, 25 Mar 2026 22:19:00 -0700
Subject: [PATCH net-next v2 2/6] enic: add V2 SR-IOV VF device ID
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-enic-sriov-v2-prep-v2-2-f72cf716ebfa@cisco.com>
References: <20260325-enic-sriov-v2-prep-v2-0-f72cf716ebfa@cisco.com>
In-Reply-To: <20260325-enic-sriov-v2-prep-v2-0-f72cf716ebfa@cisco.com>
To: Satish Kharat <satishkh@cisco.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774502338; l=1690;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=1chUHjnI8ZuULFMfvuOuwWNT2kAEAJEGnPmXwEaCezM=;
 b=LCqCZMsAv5YdqO+10oiZx4mUxfjzGgAdI+3ydSKmeNTVJ1MYaZQqN1qJs1nh94NLXJRG8FbLv
 ytm1oWn9e3CBKsRILsXjjA915aFc8jXbI3uYNGo6zGbQyMrJyIaOWgZ
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Endpoint-Received: by B4 Relay for satishkh@cisco.com/default with
 auth_id=639
X-Original-From: Satish Kharat <satishkh@cisco.com>
Reply-To: satishkh@cisco.com
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271837-lists,netdev=lfdr.de,satishkh.cisco.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[satishkh@cisco.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cisco.com:email,cisco.com:replyto,cisco.com:mid]
X-Rspamd-Queue-Id: 7ED7F32F596
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Satish Kharat <satishkh@cisco.com>

Register the V2 VF PCI device ID (0x02b7) so the driver binds to V2
virtual functions created via sriov_configure. Update enic_is_sriov_vf()
to recognize V2 VFs alongside the existing V1 type.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index e839081f9ee4..e16dfbcd2c22 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -66,12 +66,14 @@
 #define PCI_DEVICE_ID_CISCO_VIC_ENET         0x0043  /* ethernet vnic */
 #define PCI_DEVICE_ID_CISCO_VIC_ENET_DYN     0x0044  /* enet dynamic vnic */
 #define PCI_DEVICE_ID_CISCO_VIC_ENET_VF      0x0071  /* enet SRIOV VF */
+#define PCI_DEVICE_ID_CISCO_VIC_ENET_VF_V2   0x02b7  /* enet SRIOV V2 VF */
 
 /* Supported devices */
 static const struct pci_device_id enic_id_table[] = {
 	{ PCI_VDEVICE(CISCO, PCI_DEVICE_ID_CISCO_VIC_ENET) },
 	{ PCI_VDEVICE(CISCO, PCI_DEVICE_ID_CISCO_VIC_ENET_DYN) },
 	{ PCI_VDEVICE(CISCO, PCI_DEVICE_ID_CISCO_VIC_ENET_VF) },
+	{ PCI_VDEVICE(CISCO, PCI_DEVICE_ID_CISCO_VIC_ENET_VF_V2) },
 	{ 0, }	/* end of table */
 };
 
@@ -307,7 +309,8 @@ int enic_sriov_enabled(struct enic *enic)
 
 static int enic_is_sriov_vf(struct enic *enic)
 {
-	return enic->pdev->device == PCI_DEVICE_ID_CISCO_VIC_ENET_VF;
+	return enic->pdev->device == PCI_DEVICE_ID_CISCO_VIC_ENET_VF ||
+	       enic->pdev->device == PCI_DEVICE_ID_CISCO_VIC_ENET_VF_V2;
 }
 
 int enic_is_valid_vf(struct enic *enic, int vf)

-- 
2.43.0



