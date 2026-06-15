Return-Path: <netdev+bounces-299547-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 87KaO+cxMGoFPwUAu9opvQ
	(envelope-from <netdev+bounces-299547-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 19:10:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE0D688B3E
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 19:09:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Xbeu7cOJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299547-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299547-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D306130987D1
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 16:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F45240FDBE;
	Mon, 15 Jun 2026 16:58:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E0E40F8F6;
	Mon, 15 Jun 2026 16:58:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542724; cv=none; b=D0t/4QlGkPub2VxnnXdAY9zZxTxziayWBhNOj+iP0ZitLy1iNI1YY2U42E7ibF4Zf8O4G+TMXrhGSaL5vr4ln9DliixseCuz0tt746vwR6VZQ3dHIwdj3NiaDB/3qttgDD6Onx8+rtWdHl40SUtwPPa8Qo4V2em7Y3pBe93jZic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542724; c=relaxed/simple;
	bh=Ngc0fbnXuJYFmVmOuNAA5Y9B2C5ldaEgWbf6FJU7ppA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ciQHVNbE0lZR8hWTEn1bWLBy4emTS57E8Ya2MVhnoAts+OZQ01DaO32NLU1gIwXJzmACTNoGqGDyg6EiEn6YWCpybAgWV4X7WM4fVOJCbLfK1jMzaoduNAVJ8tp0QBjJmpsUEXVy3ai+aQEOehJGDCtPztMzssEGsFDRqaKBsto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xbeu7cOJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0F31F000E9;
	Mon, 15 Jun 2026 16:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781542722;
	bh=YsN1CadyLAyGEhCApEUWtqZDEHhXWdkwP/+0L+D042s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xbeu7cOJDEW0E3Px8mPyM19tUXuPEpxT3agJG6yWpwZxbE+wJGL8Sth3ecFvyhscH
	 TTjy7huaXU550bkGnMYhHMHITaiFs3rsE3Kq8y63m33nxxMIEphXqsYZAO0zjuH4dn
	 5I9DIWFv5aZSWJRdloGe9XWaEXlOvhgVZbZNl9f1O456uLf4MOfLQqKx8MpKpxzeew
	 3cX3zaBGWEfdbsZM7m+UONlJEnUJrTAERDuDQPc7D2pVfMORCBa/dAWlrRcsBNt2Un
	 Sn68/kzAz0wqx3rCNNdYOduRPxYyi0RbcgZfb25CMo6zkPBPiGV7X5KQlzZ+ivaP8Z
	 kIgTP0YZDCL9Q==
From: Simon Horman <horms@kernel.org>
To: yun.zhou@windriver.com
Cc: Simon Horman <horms@kernel.org>,
	marcin.s.wojtas@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: mvneta_bm: add suspend/resume support to prevent crash after resume
Date: Mon, 15 Jun 2026 17:58:25 +0100
Message-ID: <20260615165825.784194-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260614103835.2708515-1-yun.zhou@windriver.com>
References: <20260614103835.2708515-1-yun.zhou@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-299547-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:yun.zhou@windriver.com,m:horms@kernel.org,m:marcin.s.wojtas@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marcinswojtas@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6EE0D688B3E

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net: mvneta_bm: add suspend/resume support to prevent crash after resume

This commit adds suspend and resume callbacks to the mvneta_bm driver
to handle hardware Buffer Manager state correctly across power cycles.
It drains and frees buffers on suspend, then reinitializes the BM hardware
defaults on resume.

> diff --git a/drivers/net/ethernet/marvell/mvneta_bm.c b/drivers/net/ethernet/marvell/mvneta_bm.c
> index 6bb3804949190..ff2fe4020a456 100644
> --- a/drivers/net/ethernet/marvell/mvneta_bm.c
> +++ b/drivers/net/ethernet/marvell/mvneta_bm.c

[ ... ]

> @@ -477,6 +477,52 @@ static void mvneta_bm_remove(struct platform_device *pdev)
>  	clk_disable_unprepare(priv->clk);
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int mvneta_bm_suspend(struct device *dev)
> +{
> +	struct mvneta_bm *priv = dev_get_drvdata(dev);
> +	int i;
> +
> +	/* Drain buffers and free pool resources while BM is still clocked */
> +	for (i = 0; i < MVNETA_BM_POOLS_NUM; i++) {
> +		struct mvneta_bm_pool *bm_pool = &priv->bm_pools[i];
> +		int size_bytes;
> +
> +		if (bm_pool->type == MVNETA_BM_FREE)
> +			continue;
> +
> +		mvneta_bm_bufs_free(priv, bm_pool, bm_pool->port_map);
> +
> +		size_bytes = sizeof(u32) * bm_pool->hwbm_pool.size;
> +		dma_free_coherent(&priv->pdev->dev, size_bytes,
> +				  bm_pool->virt_addr, bm_pool->phys_addr);

[Severity: Critical]
Can this dma_free_coherent() call cause a panic or double-free if pool
creation failed during initialization?

If mvneta_bm_pool_create() fails in mvneta_bm_pool_use(), the pool type is
left as non-FREE. For example, if the failure is due to an alignment issue
in mvneta_bm_pool_create():

    if (!IS_ALIGNED((u32)bm_pool->virt_addr, MVNETA_BM_POOL_PTR_ALIGN)) {
            dma_free_coherent(&pdev->dev, size_bytes, bm_pool->virt_addr,
                              bm_pool->phys_addr);
            ...
            return -ENOMEM;
    }

This frees virt_addr but leaves the dangling pointer in bm_pool->virt_addr.
Since the type is no longer MVNETA_BM_FREE, the suspend loop will not
skip it, leading to a second dma_free_coherent() call on the same pointer.

If the allocation itself failed, virt_addr is NULL, which could also lead
to a panic here.

> +		bm_pool->virt_addr = NULL;
> +		bm_pool->type = MVNETA_BM_FREE;

[Severity: Medium]
Does setting the pool type to MVNETA_BM_FREE cause lockdep tracking issues
on resume?

When the device resumes, mvneta_resume() will call mvneta_bm_pool_use()
to recreate the pool. Because the type was reset to MVNETA_BM_FREE here,
mvneta_bm_pool_use() will execute its initialization block:

    if (new_pool->type == MVNETA_BM_FREE) {
        ...
        mutex_init(&hwbm_pool->buf_lock);
    }

Calling mutex_init() on the existing statically-allocated lock structure
wipes its wait list and lockdep state. Is there a way to avoid
re-initializing locks that are already set up?

> +	}
> +
> +	mvneta_bm_write(priv, MVNETA_BM_COMMAND_REG, MVNETA_BM_STOP_MASK);
> +	clk_disable_unprepare(priv->clk);
> +	return 0;
> +}
> +
> +static int mvneta_bm_resume(struct device *dev)
> +{
> +	struct mvneta_bm *priv = dev_get_drvdata(dev);
> +	int err;
> +
> +	err = clk_prepare_enable(priv->clk);
> +	if (err)
> +		return err;
> +
> +	/* Reinitialize BM hardware; pools are refilled by mvneta_resume() */
> +	mvneta_bm_default_set(priv);
> +	mvneta_bm_write(priv, MVNETA_BM_COMMAND_REG, MVNETA_BM_START_MASK);

[Severity: Critical]
Is the hardware pool state completely restored during resume?

The commit message notes that mvneta_bm_resume() and mvneta_resume()
perform full initialization identical to probe. However, mvneta_resume()
recreates the pool via mvneta_bm_pool_create(), which only restores the
base address and target attributes:

    mvneta_bm_write(priv, MVNETA_BM_POOL_BASE_REG(bm_pool->id),
                    bm_pool->phys_addr);
    mvneta_bm_pool_target_set(priv, bm_pool->id, target_id,  attr);
    mvneta_bm_pool_enable(priv, bm_pool->id);

It appears the pool capacity (MVNETA_BM_POOL_SIZE_REG) and the read/write
pointers (MVNETA_BM_POOL_READ_PTR_REG and MVNETA_BM_POOL_WRITE_PTR_REG)
are missing, as they are normally configured in mvneta_bm_pools_init()
which isn't called during resume.

Since the BM loses its register state during suspend, won't the hardware
operate with uninitialized or zero capacity after resume? Could this lead
to incorrectly wrapped pointers or dropped buffers when refilling the pool?

> +	return 0;
> +}
> +#endif

