Return-Path: <netdev+bounces-125239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C5B96C66F
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 20:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F00061F212CE
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 18:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D1E1E200B;
	Wed,  4 Sep 2024 18:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HaxJVqG8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693901E200C;
	Wed,  4 Sep 2024 18:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725474595; cv=none; b=XrwwYcFOxUZdUDdr/HN2I+fYG3KDp49GbWtUOGWc0xKQ7tv021tZuJqp7YOPTTkAI7uaFvRS5PEKVSZVxes7tw4S2qlKQVWLiBexMtODG7C/Z4w3l2ooP2J+eo9pg+PO7g959W+JRkY3l0P9+No1FNMiKiS040+cphqbfUjBMpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725474595; c=relaxed/simple;
	bh=bERZoF0M+63KeFaUXp9NwV1F2XDKaNJ7yJpQnxAF+X0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fb2JVBq5I+sSkQB/QZWNwddJ20/gtoLu4pXNeP+GNhz/mu5J3dRGUqFemxzV9pQMF76XpwDdG+nAbE7MkCj80MCQXlf7JRZg7f80QttHpsK/b42fXDe/UtT+s9BrVum+Y7Jq9AOa3Up6qldHtRmvExZVH28ca9KHGbrMDiuMlsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HaxJVqG8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E86FC4CEC5;
	Wed,  4 Sep 2024 18:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725474595;
	bh=bERZoF0M+63KeFaUXp9NwV1F2XDKaNJ7yJpQnxAF+X0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HaxJVqG8zkBzJ20W/2nvcBRfIE3120L/2rWxvB9nK1qUc8S9KBmCjBGIZYCkizgyj
	 8CHGGjeu3Ui+lm5vR6SlkW7bXuVFOFN7FFWyxcOxEdimzcLXx9lzYtNwTFgAuyIEAy
	 jg2STvMupUPXCNcwmHkRHDJ1miQMa4M7mqeqZJ3hhKAbesSfhEL/8kpkc03Xtxh11c
	 6Jnd2OU+KS3TQyb4slQihYrHEP7zoqrrq0ek7vgrwpXK5QQ2PeV4qbEgzGKFFHF1qn
	 7/cxN9NBP8lVjcNj7OflyeTrXo4bIf/Z/8NZo1r4jZNS7mCbXH6SRRs/vS2DFKpIKY
	 g4GpFrsTdHmzg==
From: Simon Horman <horms@kernel.org>
Date: Wed, 04 Sep 2024 19:29:36 +0100
Subject: [PATCH net-next v2 1/2] octeontx2-af: Pass string literal as
 format argument of alloc_workqueue()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-octeontx2-sparse-v2-1-14f2305fe4b2@kernel.org>
References: <20240904-octeontx2-sparse-v2-0-14f2305fe4b2@kernel.org>
In-Reply-To: <20240904-octeontx2-sparse-v2-0-14f2305fe4b2@kernel.org>
To: Sunil Goutham <sgoutham@marvell.com>, 
 Linu Cherian <lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>, 
 Jerin Jacob <jerinj@marvell.com>, Hariprasad Kelam <hkelam@marvell.com>, 
 Subbaraya Sundeep <sbhatta@marvell.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 netdev@vger.kernel.org, llvm@lists.linux.dev
X-Mailer: b4 0.14.0

Recently I noticed that both gcc-14 and clang-18 report that passing
a non-string literal as the format argument of alloc_workqueue()
is potentially insecure.

E.g. clang-18 says:

.../rvu.c:2493:32: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
 2493 |         mw->mbox_wq = alloc_workqueue(name,
      |                                       ^~~~
.../rvu.c:2493:32: note: treat the string as an argument to avoid this
 2493 |         mw->mbox_wq = alloc_workqueue(name,
      |                                       ^
      |                                       "%s",

It is always the case where the contents of name is safe to pass as the
format argument. That is, in my understanding, it never contains any
format escape sequences.

But, it seems better to be safe than sorry. And, as a bonus, compiler
output becomes less verbose by addressing this issue as suggested by
clang-18.

Compile tested only by author.

Tested-by: Geetha sowjanya <gakula@marvell.com>
Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index ac7ee3f3598c..1a97fb9032fa 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -2479,9 +2479,9 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 		goto free_regions;
 	}
 
-	mw->mbox_wq = alloc_workqueue(name,
+	mw->mbox_wq = alloc_workqueue("%s",
 				      WQ_UNBOUND | WQ_HIGHPRI | WQ_MEM_RECLAIM,
-				      num);
+				      num, name);
 	if (!mw->mbox_wq) {
 		err = -ENOMEM;
 		goto unmap_regions;

-- 
2.45.2


