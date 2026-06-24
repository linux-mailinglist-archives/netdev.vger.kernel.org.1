Return-Path: <netdev+bounces-301599-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fyJ7O8qoO2rLawgAu9opvQ
	(envelope-from <netdev+bounces-301599-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 11:52:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4566BD146
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 11:52:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=CNLqCW3Y;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301599-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301599-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3A9A302BA7A
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 09:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BD33093D8;
	Wed, 24 Jun 2026 09:50:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C686C29C35A
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 09:50:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782294621; cv=none; b=h95DYuc1Xhluji7mPStxejoD3p4Kl3pGaSRmmaS/aClPNwX6xQ7TAu+txjO4Gn2f0QQvPvywU20a3U2MsJkCjKCGe9BtktLkHgsGvP86+7N1sZqEfn2eBO9/CZUHuRmR1K4BMYRAb1iKM3l+gBvcgl8QmHpJ7xPuh98y/fEnA0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782294621; c=relaxed/simple;
	bh=Vvkj3Ughk+hMHUrpeU/GVopYpq2nlETEd22PiBnblUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=marzj/hs+XGbbJA2UF7pwefINrqOTVGEqqnW7HKocrWcf1Ql7fe7rJfiTeMyeyvyyv/tLoCjCtQMRFGqgF4dAMWyEehq6PINK80FsQlSyOgFwZP+H7jz7NfEpOfFkncgk9FvYDztgsiM9ON+I0Rt9nqVxxg0Suh9YErjW11QwKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=CNLqCW3Y; arc=none smtp.client-ip=54.254.200.92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782294601;
	bh=mfa07/MaIE5WmrY9+3eGbVXo//chxAHT0+BWkPS4fjQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=CNLqCW3YenuQvNASkttW+so8+NdOixDLWtHXeZ/yPs2JHxG8xFnwWBYkz7D3O4wAY
	 v2sXeMbqhmBtb/BXq2oCJbaoQPdvrJyDvic7OD0vBtgtpJrE9vKQXFDSDXbCSWqQqv
	 era6pAq3RENbttsr+/FSQWiLQ20n10fHqJNlHyy8=
X-QQ-mid: esmtpsz11t1782294585t9c63e569
X-QQ-Originating-IP: wejr8AycJP6pw1WAnol82MBvWzKZRD0GfvxHSj6AIUM=
Received: from localhost.localdomain ( [124.126.19.250])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 24 Jun 2026 17:49:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11565894403568613459
EX-QQ-RecipientCnt: 12
From: ZhaoJinming <zhaojinming@uniontech.com>
To: andrew@lunn.ch
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	madalin.bucur@nxp.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sean.anderson@linux.dev,
	zhaojinming@uniontech.com
Subject: [PATCH v3] net: fman: fix use-after-free on IRQF_SHARED handler after probe failure
Date: Wed, 24 Jun 2026 17:49:22 +0800
Message-Id: <20260624094922.2971930-2-zhaojinming@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260624094922.2971930-1-zhaojinming@uniontech.com>
References: <f0a6fd09-2fab-4bb4-85ae-82f8d383452c@lunn.ch>
 <20260624094922.2971930-1-zhaojinming@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: OfaQ+Y0DiXSPm11j5KdOKqfjluUlGP/SZYkpzxA7fUAaioRTPNTI8dN+
	kYwqUvSJiG5MRVPAX56AzX3AzPgxCSZVJhEPYvctgq7/9u3M+fFVMCandyo4P/z9zihPd0V
	FoChGzDk0o5IshblnDxiiveVLNdSSND3vWDy1eFuCIdsc/BH1wGwMJHZ9fZnC/VMAhf3Iup
	Hdcb1lWqQgdbji+bUNHXkv9dmE8zeg632GR2NeOGRDNDZrH2dC5ph2PeSd1VXEQOLaySjbP
	uPtBWqxVUFhqe/U0R703m1BrCBVOPtLA6eohJUNoOcPvGy2cCBEGCpTcuOvPs3eWUJRiQbf
	D/2QUDm5QlxsOi6mcauLxZCFCtVgA8OynQUVWepWgObLeJ16v8xKHAPPtjKcz08L2yz6iVM
	OpUew+cTrVRqBfSxU+ndUl7tRW0ACb3goJ48ortx+0EWaDOZ3n49XkekMof88lGT5sF2eYq
	MVaZIEPeUzpXk80QefIJuj5pvCFQoEHnL+5MNcQunCXEU7G3ycXAFBUvDZnwPxU47tbN8x8
	T8KB/lUqSE3/FJJ5hjtgoswXKwu6Ac0XgGbGL9XzkljD1tyyguidTmtoqgUWZUI8veKQyzq
	/n1NpCBT1IhC9vwQx8Fu49OY1plNwovMwM4XYHu0uzcYjT07K9Sx8rk1vI6J0GQh39yIxlM
	kiE3USQUJsZI/SwZSRwi77fItsjJSFgakZyRMSpjFF0XufI/ViXhK9QygqTAY49WWUeoMwI
	j4ciW2Y/Lq7oqnz6QzBMRYLTjPJRgaQR4dep2GLqunvsEaFKD41y4P9Fcv0Yr7lrOwgyn6d
	sfwEhEYbhzGzJ2HVrB1rkyq3ZLEBDCE6g9+dCWHwLMfpuS330LRyHWUm6Nj6QS0NHcYi28D
	NDmnc7NXD9hiozdjW4/htxFSzibZwdCF2IZB+PUGpTnQOVfUXxoRBxg6rj1ALaKq/jHxD4Q
	XFsLvDSopEDTFS9kuVqaQjv++RCCT80oi/xWzeKngFG/mioJrGLl5wwxeslMjhDnrZKO5RT
	qpeH3xJ+1UaX5wFidfmWXYVTz2mCenFoarAOhS/me9wB6n0mbfYp+Wt0kzln8rjeiNJZ5qM
	Q==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301599-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:madalin.bucur@nxp.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:sean.anderson@linux.dev,m:zhaojinming@uniontech.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[zhaojinming@uniontech.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaojinming@uniontech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,uniontech.com:dkim,uniontech.com:email,uniontech.com:mid,uniontech.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B4566BD146

In read_dts_node(), the fman structure is allocated with kzalloc_obj()
and then passed as dev_id to devm_request_irq() when registering
shared interrupt handlers:

    devm_request_irq(&of_dev->dev, irq, fman_irq, IRQF_SHARED, fman, fman);
    devm_request_irq(&of_dev->dev, err_irq, fman_err_irq, IRQF_SHARED,
                       fman-err, fman);

On error paths after IRQ registration (err_irq request failure,
ioremap failure, of_platform_populate failure), the error handling
jumps to the fman_free label which calls kfree(fman) and returns
ERR_PTR(err) from read_dts_node().

fman_probe() then returns the error to the driver core, which invokes
device_unbind_cleanup() -> devres_release_all() to clean up devres
resources in LIFO order. Since fman was allocated with kzalloc_obj()
(not devm), it was already freed at this point. However, the devm IRQ
handlers are still registered and will only be released by the
subsequent devres_release_all() call:

    kfree(fman)              <- fman freed, dev_id points to freed memory
    fman_probe() returns error
    devres_release_all():
      - free ioremap
      - devm_free_irq(err_irq)    <- handler still registered
      - devm_free_irq(main_irq)   <- handler still registered

During the window between kfree(fman) and devm_free_irq(main_irq),
the still-registered IRQF_SHARED handler may fire on behalf of another
device sharing the same IRQ line. The handler will dereference the
already-freed fman pointer:

    static irqreturn_t fman_irq(int irq, void *handle)
    {
        struct fman *fman = (struct fman *)handle;
        if (!is_init_done(fman->cfg))    <- accesses freed memory
            return IRQ_NONE;

The same problem exists in fman_config(). When fman_config() fails
at the err_fm_state error path, it calls kfree(fman) and returns
-EINVAL. fman_probe() returns this error without any cleanup, and
the driver core releases the IRQ handlers after fman has already
been freed.

Fix by explicitly calling devm_free_irq() before kfree(fman) on
all post-IRQ-registration error paths. devm_free_irq() removes the
IRQ from both the interrupt subsystem and the devres list, so
devres_release_all() will not attempt to free it again. This ensures
the IRQ handlers are fully unregistered before fman is freed,
eliminating the UAF window.

Store the main IRQ number in struct fman_dts_params so that
fman_config() can also access it for cleanup.

Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
---
 drivers/net/ethernet/freescale/fman/fman.c | 17 ++++++++++++++---
 drivers/net/ethernet/freescale/fman/fman.h |  1 +
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
index 013273a2de32..ba2338da0cea 100644
--- a/drivers/net/ethernet/freescale/fman/fman.c
+++ b/drivers/net/ethernet/freescale/fman/fman.c
@@ -1794,6 +1794,9 @@ static int fman_config(struct fman *fman)
 err_fm_drv:
 	kfree(fman->state);
 err_fm_state:
+	if (fman->dts_params.err_irq != 0)
+		devm_free_irq(fman->dev, fman->dts_params.err_irq, fman);
+	devm_free_irq(fman->dev, fman->dts_params.irq, fman);
 	kfree(fman);
 	return -EINVAL;
 }
@@ -2716,6 +2719,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 	if (err < 0)
 		goto fman_node_put;
 	irq = err;
+	fman->dts_params.irq = irq;
 
 	/* Get the FM error interrupt */
 	err = platform_get_irq(of_dev, 1);
@@ -2786,7 +2790,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 		if (err < 0) {
 			dev_err(&of_dev->dev, "%s: irq %d allocation failed (error = %d)\n",
 				__func__, fman->dts_params.err_irq, err);
-			goto fman_free;
+			goto free_main_irq;
 		}
 	}
 
@@ -2794,7 +2798,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 	if (IS_ERR(base_addr)) {
 		err = PTR_ERR(base_addr);
 		dev_err(&of_dev->dev, "%s: devm_ioremap() failed\n", __func__);
-		goto fman_free;
+		goto free_irqs;
 	}
 
 	fman->dts_params.base_addr = base_addr;
@@ -2806,7 +2810,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 	if (err) {
 		dev_err(&of_dev->dev, "%s: of_platform_populate() failed\n",
 			__func__);
-		goto fman_free;
+		goto free_irqs;
 	}
 
 #ifdef CONFIG_DPAA_ERRATUM_A050385
@@ -2816,6 +2820,13 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 
 	return fman;
 
+free_irqs:
+	if (fman->dts_params.err_irq != 0)
+		devm_free_irq(&of_dev->dev, fman->dts_params.err_irq, fman);
+free_main_irq:
+	devm_free_irq(&of_dev->dev, irq, fman);
+	goto fman_free;
+
 fman_node_put:
 	of_node_put(fm_node);
 fman_free:
diff --git a/drivers/net/ethernet/freescale/fman/fman.h b/drivers/net/ethernet/freescale/fman/fman.h
index 74eb62eba0d7..d05f857c1c16 100644
--- a/drivers/net/ethernet/freescale/fman/fman.h
+++ b/drivers/net/ethernet/freescale/fman/fman.h
@@ -286,6 +286,7 @@ struct fman_dts_params {
 	struct resource *res;                   /* FMan memory resource */
 	u8 id;                                  /* FMan ID */
 
+	int irq;                                /* FMan main IRQ */
 	int err_irq;                            /* FMan Error IRQ */
 
 	u16 clk_freq;                           /* FMan clock freq (In Mhz) */
-- 
2.20.1


