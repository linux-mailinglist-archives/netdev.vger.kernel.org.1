Return-Path: <netdev+bounces-43569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BAC7D3EDE
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 20:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF2962812E8
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 18:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA8F21378;
	Mon, 23 Oct 2023 18:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qyma8/2v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9894721373;
	Mon, 23 Oct 2023 18:17:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C63C433CA;
	Mon, 23 Oct 2023 18:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698085045;
	bh=LkMCnKzZffyVlzmEOj0r1duJ0ojO8W81fA8XHgWkUQs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Qyma8/2vdZLBcJVZWoqqLGj+bZtGHZBznjpHZst2g366upwHBe0iLtN12N4ej5gYG
	 A9phGXLC80IyDjbkIfbo4kR+v8Zq4mT+vCBrtUeNDpDu3GwzMQaGEFJs3zHYp0nupo
	 8U2Lxj0OhjEx+36t6t4QME+MYnUkbkE48/8QJZ4B6USz2iUxZhB4wBPL0lIUtkCXMY
	 oI977aoyVLJEcJjwsbiVhMtINmdTsTj/nGSYzdk/3NiJKzJA5M4JgoqvJseiZ6968A
	 dqg+H1/h16QIrtTKSp2VfBZVAZ/wn5hE2GQSUwZ9++T9i0w/BHGp5E0HlhqVrnueRS
	 Ay0FyC9F7Zd7A==
From: Mat Martineau <martineau@kernel.org>
Date: Mon, 23 Oct 2023 11:17:05 -0700
Subject: [PATCH net-next v2 1/7] tools: ynl: add uns-admin-perm to
 genetlink legacy
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-send-net-next-20231023-1-v2-1-16b1f701f900@kernel.org>
References: <20231023-send-net-next-20231023-1-v2-0-16b1f701f900@kernel.org>
In-Reply-To: <20231023-send-net-next-20231023-1-v2-0-16b1f701f900@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Matthieu Baerts <matttbe@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Simon Horman <horms@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Davide Caratti <dcaratti@redhat.com>
X-Mailer: b4 0.12.4

From: Davide Caratti <dcaratti@redhat.com>

this flag maps to GENL_UNS_ADMIN_PERM and will be used by future specs.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 Documentation/netlink/genetlink-legacy.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 923de0ff1a9e..05aa81dd6aba 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -337,7 +337,7 @@ properties:
               description: Command flags.
               type: array
               items:
-                enum: [ admin-perm ]
+                enum: [ admin-perm, uns-admin-perm ]
             dont-validate:
               description: Kernel attribute validation flags.
               type: array

-- 
2.41.0


