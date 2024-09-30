Return-Path: <netdev+bounces-130302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8726C98A034
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 488CA283A61
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 11:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBBC18E351;
	Mon, 30 Sep 2024 11:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="SYzrieHm"
X-Original-To: netdev@vger.kernel.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6919118E042;
	Mon, 30 Sep 2024 11:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695302; cv=none; b=SwNJfkVKUqDayv3GVbUIVKGa2DPmHozEfwgGaNjeMMzWrqXa8vLOdekBnqEykCD/6fcapKp5KCjZNuBCURXhusI2L7amqweV8h0kJDoUzd5kWnaxNkInzaVE9xqExUwRge1ao/mMPTp0tkJq2rQ4iHlUO/SizKPuSx9oNioICao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695302; c=relaxed/simple;
	bh=eSjouLfxGmVji7JdCEAg4WXxt7IxGP+mS6Kae6CCgYg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h4/zJHfYIGZmMbGcqjPmj1/DH/cow4PRpLlbkY7p1BlDsj/rtBJuiqIcLG6libDwObU3TAGwgftDPEuzNhsLyQqMUR0BGrSIId3IUl7l9pJV2SHsoizlGT8t1vtEv8YcvF1cFPH5nOWejcu+ngEvGCANJ2+qR5kSXuDyMWmZ/Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=SYzrieHm; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G3ifI7N9pFjRhbukFRN+v1CH5AuIXashGVsJlh26LjU=;
  b=SYzrieHmLrf4vwgmOWeFYWi2RcwXiujn0mPzUijlk/ON5rNN+p3ko4N6
   ixRZQDEUpGJcafndhDtL73zWP5afI3Qe4Nc7szNsatl5hTl2oFKiY7juB
   jnnAIGUy7bS8W+3iCA5PIkXSC6u/5aKJmkkt+52OCQfKh/xuW6P89OwCk
   w=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,165,1725314400"; 
   d="scan'208";a="185956871"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 13:21:26 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Michael Chan <michael.chan@broadcom.com>
Cc: kernel-janitors@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/35] bnxt_en: Reorganize kerneldoc parameter names
Date: Mon, 30 Sep 2024 13:20:49 +0200
Message-Id: <20240930112121.95324-4-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240930112121.95324-1-Julia.Lawall@inria.fr>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorganize kerneldoc parameter names to match the parameter
order in the function header.

Problems identified using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
index d2fd2d04ed47..3ba7a51a8afa 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
@@ -171,8 +171,8 @@ void hwrm_req_alloc_flags(struct bnxt *bp, void *req, gfp_t gfp)
  *	such as hwrm_req_send(), should thus use req and not new_req (in fact,
  *	calls to HWRM API functions will fail if non-managed request objects
  *	are passed).
- * @len: The length of new_req.
  * @new_req: The pre-built request to copy or reference.
+ * @len: The length of new_req.
  *
  * Replaces the request data in req with that of new_req. This is useful in
  * scenarios where a request object has already been constructed by a third


