Return-Path: <netdev+bounces-45641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D48B17DEC0C
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 05:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 019481C20DFF
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 04:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6630A1C20;
	Thu,  2 Nov 2023 04:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rtq/xDx4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FD715B8
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 04:57:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BDAAC433C7;
	Thu,  2 Nov 2023 04:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698901047;
	bh=ds1tt3urv+p3SIgfZpQse0fPUdFnzyrZpZxLkfHj18o=;
	h=From:To:Cc:Subject:Date:From;
	b=Rtq/xDx4704jfQX06SQZI4TElkWJLrn+Yi9XTEjzyNEIqeZ7AGwhIK6YP1VxHq8dE
	 qgvq0z/PLVhsDIczMY7IzM44F2M6wPYa8EsQBrEa/vgWRd+WLYpFyHsSPsQV97JpIm
	 iEgDXLHyIQgyIdNfG1IAu2T6kg++SczoXdxGY9twy2P6jGRbCuBR0PAaojSC/b2dQp
	 uFO/a5TW93BqF8ZdnDzGRaYb/OIA8x3aVZ/b78KOQGAVFPTgBdiHlCTS34psrt+LTu
	 ylYB3dQdDd1DfXFx6DROYtCfjYXZ4BI8pCFU/SMJJLTXxNo+AvrDjsrBwcCrTmvbcr
	 Yc6K6EGdunUpA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net] netlink: fill in missing MODULE_DESCRIPTION()
Date: Wed,  1 Nov 2023 21:57:24 -0700
Message-ID: <20231102045724.2516647-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if a module is built without
a MODULE_DESCRIPTION(). Fill it in for sock_diag.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/netlink/diag.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netlink/diag.c b/net/netlink/diag.c
index 9c4f231be275..1eeff9422856 100644
--- a/net/netlink/diag.c
+++ b/net/netlink/diag.c
@@ -257,5 +257,6 @@ static void __exit netlink_diag_exit(void)
 
 module_init(netlink_diag_init);
 module_exit(netlink_diag_exit);
+MODULE_DESCRIPTION("Netlink-based socket monitoring/diagnostic interface (sock_diag)");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_NETLINK, NETLINK_SOCK_DIAG, 16 /* AF_NETLINK */);
-- 
2.41.0


