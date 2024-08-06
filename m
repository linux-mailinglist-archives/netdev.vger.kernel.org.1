Return-Path: <netdev+bounces-116009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADFB948C77
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 11:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B9D51C21DA5
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 09:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842851BDAB1;
	Tue,  6 Aug 2024 09:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFXa+M1D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598A7F4FA;
	Tue,  6 Aug 2024 09:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722938219; cv=none; b=CKuHg9EHe9hijyiHBEJLzaFtq6d6vOqiHsDMMSjs4ifXA0OSHG63MP1oMzZBgSc+1EXpU65PEsDXwPAuf//4JOqfH8fmd/4OWV+WMsQ/flJ7kuqrvgBSmzTuf9jr5FrmSCd7mMek5rFi36EjaC0exFWaiDZILjzsoXpL09wpqgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722938219; c=relaxed/simple;
	bh=Y7qmUm2fyhlr2MjYWvtsU58bqvlx201bjXy0X8uU6Ok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=L7jlD1W+QvYfngEQ4MGvUfffmxGwMNtN/cATjnL457q7uRumuVHKE9OQ52GM6lH86c5lde496XHMmZ5RwR5VgnMVjYUgyhuKl/6KqGFRFjEcJ97XafE+SKR3Nl2cgAOr8zDLOxpHpGx+FJl2pTfetYTXUIcdNXlq4V7lL+xjl44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFXa+M1D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD07C4AF09;
	Tue,  6 Aug 2024 09:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722938218;
	bh=Y7qmUm2fyhlr2MjYWvtsU58bqvlx201bjXy0X8uU6Ok=;
	h=From:Date:Subject:To:Cc:From;
	b=lFXa+M1D3Tk4hxWfAQYDmrijNrDC9T4zCexcKVpVkQ0/+uJOEGsvC0YtdhG4V42ce
	 FRiH8quGRsQqye6MADCSSPUwym6MMKkawuPwtPJquW9sseQKSBtSPyy3FgL1XM3V/U
	 /2E4iqDaZSj0VxFuCETsd+uSUfRN1JPEN/AOkjAM1upA0NtNNuY4wAshTnSdbIK910
	 09ZTIYnfNl0G9GT4c/5uXmDHshDysQVx9ah7PVdHWmUAjqLfUkQ2cZTWhdjwjD9NAG
	 gCU9eGievH7JfELVN87r0noyjPbazVdF5zQKCLkvQrw0UOm8b8OHYafSdmYvaTM6pv
	 duUrHOAXqPbbA==
From: Simon Horman <horms@kernel.org>
Date: Tue, 06 Aug 2024 10:56:52 +0100
Subject: [PATCH net-next] bonding: Pass string literal as format argument
 of alloc_ordered_workqueue()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-bonding-fmt-v1-1-e75027e45775@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGPzsWYC/x2MywqAIBAAfyX23ILag+pXokPmVntoDZUIon9PO
 s7AzAORAlOEoXgg0MWRvWTQZQHLPstGyC4zGGVq1akWrRfHsuF6JLRVVq63XWM05OIMtPL930Y
 QSih0J5je9wMGX+H5ZwAAAA==
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 netdev@vger.kernel.org, llvm@lists.linux.dev
X-Mailer: b4 0.14.0

Recently I noticed that both gcc-14 and clang-18 report that passing
a non-string literal as the format argument of alloc_ordered_workqueue
is potentially insecure.

F.e. clang-18 says:

.../bond_main.c:6384:37: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
 6384 |         bond->wq = alloc_ordered_workqueue(bond_dev->name, WQ_MEM_RECLAIM);
      |                                            ^~~~~~~~~~~~~~
.../workqueue.h:524:18: note: expanded from macro 'alloc_ordered_workqueue'
  524 |         alloc_workqueue(fmt, WQ_UNBOUND | __WQ_ORDERED | (flags), 1, ##args)
      |                         ^~~
.../bond_main.c:6384:37: note: treat the string as an argument to avoid this
 6384 |         bond->wq = alloc_ordered_workqueue(bond_dev->name, WQ_MEM_RECLAIM);
      |                                            ^
      |                                            "%s",
..../workqueue.h:524:18: note: expanded from macro 'alloc_ordered_workqueue'
  524 |         alloc_workqueue(fmt, WQ_UNBOUND | __WQ_ORDERED | (flags), 1, ##args)
      |                         ^

Perhaps it is always the case where the contents of bond_dev->name is
safe to pass as the format argument. That is, in my understanding, it
never contains any format escape sequences.

But, it seems better to be safe than sorry. And, as a bonus, compiler
output becomes less verbose by addressing this issue as suggested by
clang-18.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/bonding/bond_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 1cd92c12e782..f9633a6f8571 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -6338,7 +6338,8 @@ static int bond_init(struct net_device *bond_dev)
 
 	netdev_dbg(bond_dev, "Begin bond_init\n");
 
-	bond->wq = alloc_ordered_workqueue(bond_dev->name, WQ_MEM_RECLAIM);
+	bond->wq = alloc_ordered_workqueue("%s", WQ_MEM_RECLAIM,
+					   bond_dev->name);
 	if (!bond->wq)
 		return -ENOMEM;
 


