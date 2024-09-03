Return-Path: <netdev+bounces-124632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4600896A43F
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 18:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB87B1F22700
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A742B18BBB1;
	Tue,  3 Sep 2024 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qb9wKrSd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA2918858F;
	Tue,  3 Sep 2024 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725380829; cv=none; b=eLKvc+eECJb3oVId9uY82/7OBRPqMRRHpePdPZfV0gqcXDccrSnmCOGoTjjeYoErFYXyXlfnPGRzqFDZMFvSWYngFrvGHFIJ07sL3ni3zegbxn5lRcggK1YpzczTOI2H7c3ROTf9WYdUn6vISf1yYdfCykyCE86i1NUj8Ga/VgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725380829; c=relaxed/simple;
	bh=kBsMuv/tx+UJkJBmQ+EnOLAKa+/GmXarSFqeGUoMqWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QeEJPCxOFqZ6yXaLGLq5yZqto51uJU14TLa3LI2psg5/nfcMU+bZIGhTTQdo9DghFmgoEPKnSw36ABRqxQ8mN6NwVyA5muOABwZXcTPoR8pBHMqwjk8H5CcMJBX2DHPwAykyJGNjgUdwUi09oAgAhvPksPmftml2vvwIbZYArms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qb9wKrSd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64261C4CEC6;
	Tue,  3 Sep 2024 16:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725380829;
	bh=kBsMuv/tx+UJkJBmQ+EnOLAKa+/GmXarSFqeGUoMqWY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qb9wKrSd+HrLqh8SX2KzZkunSLZcQ6SH0BFTe/D9aEcqqQ+APSFnxiqnIeP2PtBCI
	 ou5xvtb457245SbaF/3fQYN9f3BvA1QhkKNIADCPBSsr9NGeJYQ3wKfDgcK2OzHbdh
	 LesyM/h+v53tmM+1ThnanNyM7GK0NWa2SbOYISmYDLdPthRKxQkRFtfraEfOLoOwEv
	 L8LVVqAw/0jFxXK2HDFE+B/0It2Zf3fRaj7deNw5L+dyzHA4YN3E6fA2YzPA8093if
	 A+jLxjhLxWup0M+Uc4fKKl2eudzytLY0HaUlx7B1KhwHEYy35n+Ubbkr2/WosS4gUc
	 eMLKdwJVN1urg==
From: Simon Horman <horms@kernel.org>
Date: Tue, 03 Sep 2024 17:26:53 +0100
Subject: [PATCH net-next 1/2] octeontx2-af: Pass string literal as format
 argument of alloc_workqueue()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-octeontx2-sparse-v1-1-f190309ecb0a@kernel.org>
References: <20240903-octeontx2-sparse-v1-0-f190309ecb0a@kernel.org>
In-Reply-To: <20240903-octeontx2-sparse-v1-0-f190309ecb0a@kernel.org>
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

Compile tested only.

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


