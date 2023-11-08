Return-Path: <netdev+bounces-46553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B587F7E4EC2
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 03:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AED431C20991
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 02:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034597EA;
	Wed,  8 Nov 2023 02:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loCsbwYr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19177EF
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 02:03:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD8AC433C8;
	Wed,  8 Nov 2023 02:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699408990;
	bh=c99wm4dPDUFemaq2Gp261qCIR5FoFvsO0qnRsF3YknE=;
	h=From:To:Cc:Subject:Date:From;
	b=loCsbwYrl/osRPnUP0xjQ+Rte1ol43R56rp23sb0hhgtSRksiyP4aUWZuoeS8y2aD
	 DyEjYhmgtRjLBHkqGGkC/QP6qRGRd+YIvqatxuxWRfetPJgzlhkgmQ1UEgbB1jrbIm
	 j6jcQZ5WQ/GpSLdAhXAHbJnjek6ueI58tf59FyX29IQuKUda7eKQZO5F43dgD51rnL
	 Jfj5MtEHBcJ/irTdH67mMkXiC9KxjkNQDvh1RMuQ0hsInE7yEcWCHyGXUcziuwx2fV
	 UUWGp4U9rlOBoYWSDPoUkpIZD1uMVZ86WF3jMHiVPJCtQnVH44Q+fN2aEgVoUD8H3s
	 59ji1ezgqHsbQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	dhowells@redhat.com
Subject: [PATCH net] net: kcm: fill in MODULE_DESCRIPTION()
Date: Tue,  7 Nov 2023 18:03:05 -0800
Message-ID: <20231108020305.537293-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: dhowells@redhat.com

I've updated the cc_maintainers test as promised at netconf.
Let's see if it works...
---
 net/kcm/kcmsock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index dd1d8ffd5f59..65d1f6755f98 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1946,4 +1946,5 @@ module_init(kcm_init);
 module_exit(kcm_exit);
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("KCM (Kernel Connection Multiplexor) sockets");
 MODULE_ALIAS_NETPROTO(PF_KCM);
-- 
2.41.0


