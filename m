Return-Path: <netdev+bounces-203065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57352AF072F
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 02:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A56761C07137
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 00:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E4C4A1A;
	Wed,  2 Jul 2025 00:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/sPawYF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3084409
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 00:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751415303; cv=none; b=nQZmSyMj/xd289lQQKi1YwmLz+jXVmZGJZGUlV0WwXwb1ktojd7tCIrH7AsAGeAPOynrCvUFs0BCIHdLwNPg1NaoEzcY2cQ1qwQljowNMlhfIlbiNknP1IBGxqj0Op8KLPnNiGQPYACxnZA0/VbDR5aYbdc5rO4+bg19wP+lXMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751415303; c=relaxed/simple;
	bh=qfjfZXXEyQq5i/w5uOheLBLYgXYXwBVz93vJccUk2u0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K5z2DVaRlD766h7nAes65mIHY3LEbZfz6KYDtLbAr2qVeHC1WMzzeAHhS/xHQo+oUizSAZKEbyooaWoIkf/DPJgkW+Vej/Fc6FnRQbKpxWvpDnCtBZVP5aL7CpTtqzbgGOzuIK/TgUIqGlYjFod7GiwGg/wWXPWtXoDkWXtgH9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/sPawYF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594CFC4CEEB;
	Wed,  2 Jul 2025 00:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751415302;
	bh=qfjfZXXEyQq5i/w5uOheLBLYgXYXwBVz93vJccUk2u0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U/sPawYF8+uFQ13C9Ns75c7k1wzYl/EkZGphQAqTMTpHv7m1P2o5CiHbk+ch8q4EG
	 6qnbRiNLkDnYOQ2fbZ2BC+px3FvX0DNGr9v7dtQD3tihmDxRdZVWlTg0ehQS8KkjBy
	 FmW5Vd6K1B8zPZTCVwOB4dSEfQ48ZD5A/ES8IITF92CK0l3UE2FsVCypKHa99k18Mg
	 fx9KPZTpdfhEV/oKsagltnNXmrhCWdL4Vxqgv3QLn51nnapRVEVHjCiVh7cOoRLN5Q
	 GkXri/D8Yx7c+kY5Isb5XyVjn1Pi5QiCB7pQxsDv202gV4Rbckbs+W5MG16FyrYqYA
	 jjTrBsumRdl0w==
Date: Tue, 1 Jul 2025 17:15:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Simon Horman <horms@kernel.org>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>, kernel test
 robot <lkp@intel.com>
Subject: Re: [PATCH net] bnxt_en: eliminate the compile warning in
 bnxt_request_irq due to CONFIG_RFS_ACCEL
Message-ID: <20250701171501.32e77315@kernel.org>
In-Reply-To: <CAL+tcoDUoPe05ZGhsoZX24MkaRZx=bRws+kY=MuEVQdy=3mM1A@mail.gmail.com>
References: <20250629003616.23688-1-kerneljasonxing@gmail.com>
	<20250630110953.GD41770@horms.kernel.org>
	<CAL+tcoDUoPe05ZGhsoZX24MkaRZx=bRws+kY=MuEVQdy=3mM1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Jun 2025 19:47:47 +0800 Jason Xing wrote:
> > Not for net, but it would be nice to factor the #ifdefs out of this
> > function entirely.  E.g. by using a helper to perform that part of the
> > initialisation.  
> 
> Got it. I will cook a patch after this patch is landed on the net-next branch.

Maybe we can fix it right already. The compiler should not complain if
it sees the read:

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index f621a5bab1ea..6bbe875132b0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11616,11 +11616,9 @@ static void bnxt_free_irq(struct bnxt *bp)
 
 static int bnxt_request_irq(struct bnxt *bp)
 {
+       struct cpu_rmap *rmap = NULL;
        int i, j, rc = 0;
        unsigned long flags = 0;
-#ifdef CONFIG_RFS_ACCEL
-       struct cpu_rmap *rmap;
-#endif
 
        rc = bnxt_setup_int_mode(bp);
        if (rc) {
@@ -11641,15 +11639,15 @@ static int bnxt_request_irq(struct bnxt *bp)
                int map_idx = bnxt_cp_num_to_irq_num(bp, i);
                struct bnxt_irq *irq = &bp->irq_tbl[map_idx];
 
-#ifdef CONFIG_RFS_ACCEL
-               if (rmap && bp->bnapi[i]->rx_ring) {
+               if (IS_ENABLED(CONFIG_RFS_ACCEL) &&
+                   rmap && bp->bnapi[i]->rx_ring) {
                        rc = irq_cpu_rmap_add(rmap, irq->vector);
                        if (rc)
                                netdev_warn(bp->dev, "failed adding irq rmap for ring %d\n",
                                            j);
                        j++;
                }
-#endif
+
                rc = request_irq(irq->vector, irq->handler, flags, irq->name,
                                 bp->bnapi[i]);
                if (rc)
-- 
pw-bot: cr

