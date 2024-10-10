Return-Path: <netdev+bounces-134413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A471B99944E
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 23:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B28AB20F4D
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 21:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9441D1CDFD4;
	Thu, 10 Oct 2024 21:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYnj+Wpx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2CA1BE87D
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 21:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728595140; cv=none; b=QGizuKc01SRF1AGAO7KU5FGlATxEkn9Xt5J2kSajrRK5TjGzQnNZwt8KpckprTXF2r1gmwVz2PPurWIjUEUz5EDf5g7UgJQ8RlPK0sMM1uyEFSgdEImmv3Z0WM0CMRUxIyEkj55+11tanLYaQbuKU0GKd47Se4sVrCszMEf6Rpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728595140; c=relaxed/simple;
	bh=3t+sNo/LkUllUHc9tQlZHvya/TgctltY/lR97+r+mbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aDtlU6DXVkNkO1WqzOQWuibdPuKVq6T94FfSpXb3rdd7TGtVtkOK66u2pGWkbTB2kPXu7xYFL7CQwllUGKUHOzXlebEr4MviX9eeIrUcidCQxU2OPNm73cbftKLMRptQzw+YzXLvtnH5A56Pvbzfg5VUv8dslLqz4k/I8JIL54I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYnj+Wpx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CEAC4CEC5;
	Thu, 10 Oct 2024 21:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728595140;
	bh=3t+sNo/LkUllUHc9tQlZHvya/TgctltY/lR97+r+mbw=;
	h=From:To:Cc:Subject:Date:From;
	b=DYnj+WpxqrypiAMLCR4CQISuMBRPwS1Wih6ZGNxbCUPYtnbskhAQ30wE+hdwNsRiQ
	 pBlYuEjQZ+YptJSWOsiO/mTlQZJ+kot8fPGHwtzqfQE0BeFyX9bjg0S/qJ5ags+abv
	 acbYaeRNbMZMCvRt0kzOaEANuQnr57O25tgp4FK7SmMhPRbgPDvrj+zgtzC9j8+o//
	 FZNHXuL7stXY115B3eKg+cte599xxjT2SG7QpFoJTmi74sbaX+xHjveYbvMK3nN6CV
	 cerRJKnZERZEZUMWENiaJXKD9J0hLkkyd7ujtFlxCnkvDVmV+Bki6523MynxOfxrU3
	 Pw+YkAmqYxC7A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] selftests: drv-net: add missing trailing backslash
Date: Thu, 10 Oct 2024 14:18:57 -0700
Message-ID: <20241010211857.2193076-1-kuba@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit b3ea416419c8 ("testing: net-drv: add basic shaper test")
removed the trailing backslash from the last entry. We have
a terminating comment here to avoid having to modify the last
line when adding at the end.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 25aec5c081df..0fec8f9801ad 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -9,7 +9,7 @@ TEST_PROGS := \
 	ping.py \
 	queues.py \
 	stats.py \
-	shaper.py
+	shaper.py \
 # end of TEST_PROGS
 
 include ../../lib.mk
-- 
2.46.2


