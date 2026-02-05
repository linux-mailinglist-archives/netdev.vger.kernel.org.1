Return-Path: <netdev+bounces-257008-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JrUH7ZBhGng1wMAu9opvQ
	(envelope-from <netdev+bounces-257008-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:07:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCEFEF461
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E3F430125F1
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 07:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E65B35581F;
	Thu,  5 Feb 2026 07:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="an596wB0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f68.google.com (mail-oo1-f68.google.com [209.85.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF6933469C
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 07:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770275240; cv=none; b=hDl8Elf4iog1eHXbiW+XpGQ72pr5moz8FOFEHwxGunBWmfW0RTD7Os1JXB/ezTJlDeD0yAGsT8myDhxmTeFOGFjS05e9PMlaaqqFu3jl3wsBVWU0qKLAWLN7ljl78wQGLbYVL4aei7wfnO4fssrq4tQLtr8YLB95Xm0//hW7TjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770275240; c=relaxed/simple;
	bh=54UTACEIjljOknDSR1Mgr8Jy/qUh0kuCz7srLk5rgkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E8KAb3xhzmQ2zAunoD2wH9OZ2Fb0w4c3dFX7npxuLJ5/il3lrIPle64Ks31hu0LiqlovfBHh/zX3TEP7quTfjBMflrkVVx11lGOIxu/BXAyUtRq0YgSQOezaV9hDzz+OkYeyojrHGbBabY7t84ulXtPjtzdZhZhF/mil6a/kehc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=an596wB0; arc=none smtp.client-ip=209.85.161.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f68.google.com with SMTP id 006d021491bc7-66a12c77a2cso356174eaf.3
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 23:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770275239; x=1770880039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ldSsh8AqrwVd7W7U3ShnZ3QwgoeeXWHBddwGz0cGoaY=;
        b=an596wB0CHSw3PvGAfrlpg9R9nkrPLBue72APzED1n3K2moytYvPLumMZCReofxjaQ
         a+9cxALjQ23GbdBGh3n9JD2PxN7OeW9IE5D/AKN5mYDEAhPRnXy35c0YB8bfH03xCDuS
         WVuU2npKioACU0rZ/qB07tnkGiWqeIEQPUFlAY8seWehZ8hHTv1YQFxkiebed+Ypi+gB
         HhbAJWeJNv25vP0dqHK1WsUPIx0SdUfylGnDuoe5LMuRN1NbF8rkQNitiKcAOAFq79FD
         Mwtm5CXPScwhOLrq7x/jrs9qQCZyGw4VhWoXajv6rqNqq/LXMqKJjrgQjuu1BX3X0T0Q
         Z7WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770275239; x=1770880039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldSsh8AqrwVd7W7U3ShnZ3QwgoeeXWHBddwGz0cGoaY=;
        b=hkzI1IfEEZnoNXJXHAXfx3NLOj7973HrW50bV4BvnyQ7UXWrxHN2LdnCtNA6c7vwbe
         j1uSn6QneTvmsgksfo+tKXk+U/4Ea7NeEq+cntBOFgoCThu2ViDfoGlmzAtrUtXqftA0
         2OJJ2XdlftneE0OWYZTcRG5IHMTiRR3EBpU1Imzl6SG0bsrioNc4gwp5Dw8nvX73XU5t
         EkSS3au5g5QTOJygRYcR6QYOggR/9H50c5HIerHDPt6abdg8+qn5OsGCeP0qYmJHw9sr
         /KeDAgj29j1nfqo9eL7L+SYbYcG/2xKFz7vmm9x32w7tM4/GJKzsosz4LFauYhXW10Ey
         DZWA==
X-Gm-Message-State: AOJu0YzvfnCGiD5bDntxCAcblpXOjnVazHvPgtrWPfJO6JzQkrLGZNI4
	zJj89CIfuOLrYPx2Gc/lV66etP4YJGpDpbGPto5eSUd1/wGHEVN2zbnoThzr6G0D
X-Gm-Gg: AZuq6aI6zcVPcwFVHEiI8OjgUahv69AUC1YLVOiQ01oS5d+b4NRGKTX6EqyL1wU5lsj
	wD8z7XcenwDvuLH+K/RB+9ndIxIj4evhhzLF9q89wtzKo2TFJW2sIieEARtEtNzHiclFoPMzDFK
	Xt6luZidye5jQ0l9ZY8E8faH6l1P2V96da16eUFaQ5BskR+oQdOcgaBA4QzLJGG00OsgysP9Lxu
	IkTuBKxm44Qm/jGYYta266cmaOdwzG28CHgBvAwG/dbgAKIsyjH5BKFaee4oLlvMf03BxkVUkXp
	5RaXCx1k1AGfP69Il9DpK875uMNUHAfJh9cKyr4g0U793wVVpgBNInqww2do+9KDt1ypf2/kdrD
	ScpeW4xHmopbZidooaCQ3PrQ5V82uutYdlYBBxkySOMw5HQtM/zvaJkj/YTYgiyUdc1AzVRfYbB
	Cj0nFBd1ob4svi/puuFJaB9UDknWmINizIA0Z04jkhWkrQvny74GbvMJ9DLYclnimN419+2ltsn
	NGi6RDf7qnAXNzRpJ7nMkKDN6g5cVs9GD5BzXjkn4yG9Un07azinB3aspADkMfGzVswayBRnGgp
	n29g
X-Received: by 2002:a05:6820:4987:b0:662:f9f7:153a with SMTP id 006d021491bc7-66a202aa633mr2217140eaf.1.1770275239054;
        Wed, 04 Feb 2026 23:07:19 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-66a354bdd76sm2660002eaf.11.2026.02.04.23.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 23:07:18 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] net: arcnet: com20020-pci: use module_pci_driver
Date: Wed,  4 Feb 2026 23:06:31 -0800
Message-ID: <20260205070632.37516-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,pengutronix.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257008-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EDCEFEF461
X-Rspamd-Action: no action

The only thing this driver's init/exit functions do is call
pci_register/unregister_driver, and in the case of the init function,
print an unnecessary message. Replace them with module_pci_driver to
simplify the code.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/arcnet/com20020-pci.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/net/arcnet/com20020-pci.c b/drivers/net/arcnet/com20020-pci.c
index 0472bcdff130..19e411b2e3a7 100644
--- a/drivers/net/arcnet/com20020-pci.c
+++ b/drivers/net/arcnet/com20020-pci.c
@@ -618,17 +618,4 @@ static struct pci_driver com20020pci_driver = {
 	.remove		= com20020pci_remove,
 };
 
-static int __init com20020pci_init(void)
-{
-	if (BUGLVL(D_NORMAL))
-		pr_info("%s\n", "COM20020 PCI support");
-	return pci_register_driver(&com20020pci_driver);
-}
-
-static void __exit com20020pci_cleanup(void)
-{
-	pci_unregister_driver(&com20020pci_driver);
-}
-
-module_init(com20020pci_init)
-module_exit(com20020pci_cleanup)
+module_pci_driver(com20020pci_driver);
-- 
2.43.0


