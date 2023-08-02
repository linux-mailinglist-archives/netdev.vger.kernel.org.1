Return-Path: <netdev+bounces-23759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF68176D6DE
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 20:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 799D2281B8A
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 18:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596CFFC07;
	Wed,  2 Aug 2023 18:28:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F339F101F2
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 18:28:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA0EC433C8;
	Wed,  2 Aug 2023 18:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691000927;
	bh=p8u7Z3mpL59awGuJFbyHMJhPBe2rS8NNyq5W9aJ93bU=;
	h=From:To:Cc:Subject:Date:From;
	b=imWvcxfrls0hotBvjeStd2r/Tsn8ULaa9O6vLxTGF2XNJCm1OID/JGTRxWMvK9MkX
	 lx7I5igI95W4xYxNEqcogfxRBhuS05DvoB7vCab7tCmVhdm9LmkRcfbbzzDgvx0Maw
	 JTONJXfo7I4Pc5SSResC0YCBWt/V0br4E1B3blQ2T2i5ZtEZP+rStMpO1D653DLKCK
	 hmDnywaSaWb2yaUL4MCpxkAkZFZtQ3fdYHdul06Jg3IS+wGRDtE/jeXAN7fEIXOsRa
	 iKxd+74vKO3qNu8Zu8XeAKyhOMvy+V+m+7Wx2RwbVBJSnd1/A42w2zK1WssSFUDFZ7
	 bmIQz4BnKxujg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Maxim Krasnyansky <maxk@qti.qualcomm.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>
Subject: [PATCH net] MAINTAINERS: update TUN/TAP maintainers
Date: Wed,  2 Aug 2023 11:28:43 -0700
Message-ID: <20230802182843.4193099-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Willem and Jason have agreed to take over the maintainer
duties for TUN/TAP, thank you!

There's an existing entry for TUN/TAP which only covers
the user mode Linux implementation.
Since we haven't heard from Maxim on the list for almost
a decade, extend that entry and take it over, rather than
adding a new one.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: Maxim Krasnyansky <maxk@qti.qualcomm.com>
CC: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: Jason Wang <jasowang@redhat.com>
---
 MAINTAINERS | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 20f6174d9747..39b3c6e66c2e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21673,11 +21673,14 @@ S:	Orphan
 F:	drivers/net/ethernet/dec/tulip/
 
 TUN/TAP driver
-M:	Maxim Krasnyansky <maxk@qti.qualcomm.com>
+M:	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
+M:	Jason Wang <jasowang@redhat.com>
 S:	Maintained
 W:	http://vtun.sourceforge.net/tun
 F:	Documentation/networking/tuntap.rst
 F:	arch/um/os-Linux/drivers/
+F:	drivers/net/tap.c
+F:	drivers/net/tun.c
 
 TURBOCHANNEL SUBSYSTEM
 M:	"Maciej W. Rozycki" <macro@orcam.me.uk>
-- 
2.41.0


