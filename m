Return-Path: <netdev+bounces-77344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9579871531
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 06:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F3251F226B5
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 05:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50A45D738;
	Tue,  5 Mar 2024 05:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOiJJHQp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9160E5A0E1
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 05:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709615617; cv=none; b=NZDYZXJrvvU4OEgVbWdhD+ktNpJP2Ktd62ORUP2QPfTarBf0aWTmMwHTOA7RTQLTXVueJEdwasz5D/QHfAX5uNLYsWZeV7ksZQEtFRwG7YvkNRk5esXxQx/cYjeCaZiDiRWal0DB3E+RH7XAyN4KrjFWvGOqc9/spkvNe4kUxKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709615617; c=relaxed/simple;
	bh=NBBWU1nSC/pxyRcC+A0Y/j8V8klT0MQGokbDi2j5C7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfxTlI+D7zk97LyO/bPGL6BR8fDLnUeCVGJXe3TikzaAkUJD6dwz9X9qJRNXk7Q41UCjoOJc8YoU3pU+6YOYh/HdjEDKifh1+VkrCg5ybe7qX+M8aiR93nr5LgndhnwcUv7cdcPyR7uOhKLnh2RP876anfpNVfq/v+ECb4TSRL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOiJJHQp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0716C433B2;
	Tue,  5 Mar 2024 05:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709615617;
	bh=NBBWU1nSC/pxyRcC+A0Y/j8V8klT0MQGokbDi2j5C7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BOiJJHQpknqoI2yicNvR/4k5D9lio7x3Qta5VAz6yrsM6cvuleeXoHqJPDLHFa9Wi
	 W1KgzeV2fN97PAW7WotGZ/JGUJbzknTw5I34Dq3i/0XMk8vZgOKJWoYtnSM8TUdTjg
	 ZZ4GA/TkT4sUNGmM3widdRfmQhS7ayncIqbdAWwysE8D5+I3MJ8ZssUrGauVHAXURO
	 5a0YUtO8vKMwnjhzf1HeddLhimJsr5JL1EH9HwnuAHBmMndcL2aEDHcM06jUecAbPu
	 LXgQ3Pbg20nuufngnVZbTWt2jf1C//rrv4Vb7lS0j5hfz/LnycBJfyDKr555g27TS3
	 AkFLgjttijWuw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 3/3] tools: ynl: remove __pycache__ during clean
Date: Mon,  4 Mar 2024 21:13:28 -0800
Message-ID: <20240305051328.806892-4-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240305051328.806892-1-kuba@kernel.org>
References: <20240305051328.806892-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Build process uses python to generate the user space code.
Remove __pycache__ on make clean.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/net/ynl/lib/Makefile b/tools/net/ynl/lib/Makefile
index 1507833d05c5..dfff3ecd1cba 100644
--- a/tools/net/ynl/lib/Makefile
+++ b/tools/net/ynl/lib/Makefile
@@ -17,6 +17,7 @@ ynl.a: $(OBJS)
 	ar rcs $@ $(OBJS)
 clean:
 	rm -f *.o *.d *~
+	rm -rf __pycache__
 
 distclean: clean
 	rm -f *.a
-- 
2.44.0


