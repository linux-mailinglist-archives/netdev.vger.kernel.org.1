Return-Path: <netdev+bounces-300842-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y8SrBmXjNmrAFwcAu9opvQ
	(envelope-from <netdev+bounces-300842-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 21:00:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B666A9888
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 21:00:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NdkBgXQO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300842-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300842-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6B7E3016ED3
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 19:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4736232ED32;
	Sat, 20 Jun 2026 19:00:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030D04A32;
	Sat, 20 Jun 2026 19:00:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781982050; cv=none; b=YnaSJw08/z7xOj+z/GImvIfdt5Jv7wagrQ5gbbqKqrzAHDudyCrHX9NwVlSL6EDNknU+wXIM/IWp2v4Kd/iOzj5SHRKthMqNV/BjLyRrBxT1J1rZYeUe350tMdP6gJxYESe6//aWxGoXINF8ZHUv7ELt24kSWtwLqgFlsAqLatk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781982050; c=relaxed/simple;
	bh=GGe715cEZALGIOrNHQ+tNVfJ4PFoerJuXgo6LRfj4V0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bUHCbzEZwJDnX5OqJw9QuVJQgPMHQX7A0uG01SsvdSptzCzGfG3q5P6OFienl6m9AluUWcjHlxTe5khNhs0r39WJvk1Y4jG/q0Hvlhnn2GRHWiVRn7F5R43QealR7rpJIDihJgOPevaT9buL8IGdJnL10LdxoLQtaSFTFxXWzH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdkBgXQO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E6E1F000E9;
	Sat, 20 Jun 2026 19:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781982048;
	bh=8Ks9C+Ww3HFk+V5AGhFCwK28yuYhD4ZwkpSUFVnK3kw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NdkBgXQOP6YwLiLbVEGOZ3d6WW+p4L/IXMc5uukqqcA2ucaLNPfoBIM1x+9iw0Kvj
	 nJ9AsNkL8TdhUJGJ/kkuZzKE6ALA1r3MBipjP6950cAkAInj17Apu1wEyHY/bBD7s4
	 5LTrBwNN3GtxLpPY35bc3lsj5lw5ZqVH094OFk65I69QVm/JB1tEQHkYCN6PxYMD8z
	 WS73aUfw1SBg2z8M9PdJhwZgAgdePZ84TfEx2/XRvalblwQJxkvxahZfK4TvI/N7Y6
	 RjEhmk/ECg/Fja2KPyGsvlop+yPnyo6OCjaYq1XCGTnPiVkq667oymNxYRc+b2nQva
	 zwQS55DDjFKTQ==
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
Subject: Re: [PATCH v4] net: mvneta_bm: add suspend/resume support to prevent crash after resume
Date: Sat, 20 Jun 2026 20:00:36 +0100
Message-ID: <20260620190036.997651-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618143516.1131805-1-yun.zhou@windriver.com>
References: <20260618143516.1131805-1-yun.zhou@windriver.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-300842-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 58B666A9888

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net: mvneta_bm: add suspend/resume support to prevent crash after resume

This patch adds suspend/resume callbacks to mvneta_bm so the BM hardware
state is drained at suspend and reinitialised at resume, and adds a
device_link from mvneta to mvneta_bm so PM ordering between the two is
guaranteed. A few questions on the new paths below.

> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index 0c061fb0ed07..488f2663ad2c 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -5678,6 +5678,24 @@ static int mvneta_probe(struct platform_device *pdev)
>  					 "use SW buffer management\n");
>  				mvneta_bm_put(pp->bm_priv);
>  				pp->bm_priv = NULL;
> +			} else if (!device_link_add(&pdev->dev,
> +						    &pp->bm_priv->pdev->dev,
> +						    DL_FLAG_AUTOREMOVE_CONSUMER)) {

[Medium]
Can the existing mvneta_bm_port_init() failure path leave priv->bm_pools[i]
in a state that the new suspend handler will then double-free?

mvneta_bm_pool_use() sets new_pool->type to LONG/SHORT before calling
mvneta_bm_pool_create(). If mvneta_bm_pool_create() fails after the
dma_alloc_coherent (for example at the alignment check or
mvebu_mbus_get_dram_win_info()), it does this:

  drivers/net/ethernet/marvell/mvneta_bm.c:mvneta_bm_pool_create() {
      ...
      dma_free_coherent(&pdev->dev, sizeof(u32) * size,
                        bm_pool->virt_addr, bm_pool->phys_addr);
      return -ENOMEM;
  }

It does not zero virt_addr, and the existing probe error path here only
calls mvneta_bm_put() and sets pp->bm_priv = NULL, without invoking
mvneta_bm_pool_destroy() on the partially-initialised pool:

  if (err < 0) {
      dev_info(&pdev->dev,
               "use SW buffer management\n");
      mvneta_bm_put(pp->bm_priv);
      pp->bm_priv = NULL;
  } else if (!device_link_add(...)) {

So priv->bm_pools[i] can be left with type != FREE and a freed-but-
non-NULL virt_addr. When mvneta_bm_suspend() later runs, it skips only
on type == MVNETA_BM_FREE and unconditionally calls
dma_free_coherent(bm_pool->virt_addr, ...) on the stale pointer.

Should the suspend loop mirror mvneta_bm_pool_destroy() and guard with
"if (bm_pool->virt_addr)" before calling dma_free_coherent(), and
NULL-check after?

> +				/*
> +				 * Link guarantees BM resumes before mvneta.
> +				 * Without it, BM may not be ready when
> +				 * mvneta_bm_port_init() runs on resume,
> +				 * causing stale buffer addresses and a crash.
> +				 * Fall back to SW management to be safe.
> +				 */
> +				dev_warn(&pdev->dev,
> +					 "failed to link to BM, use SW buffer management\n");
> +				mvneta_bm_pool_destroy(pp->bm_priv,
> +						       pp->pool_long, 1 << pp->id);
> +				mvneta_bm_pool_destroy(pp->bm_priv,
> +						       pp->pool_short, 1 << pp->id);
> +				mvneta_bm_put(pp->bm_priv);
> +				pp->bm_priv = NULL;
>  			}
>  		}
>  		/* Set RX packet offset correction for platforms, whose
> diff --git a/drivers/net/ethernet/marvell/mvneta_bm.c b/drivers/net/ethernet/marvell/mvneta_bm.c
> index 6bb380494919..85162a43eaf6 100644
> --- a/drivers/net/ethernet/marvell/mvneta_bm.c
> +++ b/drivers/net/ethernet/marvell/mvneta_bm.c
> @@ -477,6 +477,63 @@ static void mvneta_bm_remove(struct platform_device *pdev)
>  	clk_disable_unprepare(priv->clk);
>  }
>  
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
> +		if (bm_pool->hwbm_pool.buf_num)
> +			dev_warn(&priv->pdev->dev,
> +				 "pool %d: %d buffers not freed\n",
> +				 bm_pool->id, bm_pool->hwbm_pool.buf_num);
> +
> +		size_bytes = sizeof(u32) * bm_pool->hwbm_pool.size;
> +		dma_free_coherent(&priv->pdev->dev, size_bytes,
> +				  bm_pool->virt_addr, bm_pool->phys_addr);
> +		bm_pool->virt_addr = NULL;
> +		bm_pool->type = MVNETA_BM_FREE;
> +	}
> +
> +	mvneta_bm_write(priv, MVNETA_BM_COMMAND_REG, MVNETA_BM_STOP_MASK);
> +	clk_disable_unprepare(priv->clk);
> +	return 0;
> +}

[Medium]
Why does this loop not call mvneta_bm_pool_disable() (or otherwise clear
MVNETA_BM_POOL_ENABLE_MASK in BASE_REG) per pool the way
mvneta_bm_pool_destroy() does?

mvneta_bm_pool_destroy() clears the per-pool enable bit before the
dma_free_coherent of the BPPE region. The new suspend ordering is
instead drain via BPPI -> dma_free_coherent(BPPE) -> next pool -> a
single global MVNETA_BM_STOP_MASK write at the end.

mvneta_bm_bufs_free() also clears MVNETA_BM_EMPTY_LIMIT_MASK on exit,
which re-enables auto-refill:

  drivers/net/ethernet/marvell/mvneta_bm.c:mvneta_bm_bufs_free() {
      ...
      mvneta_bm_config_clear(priv, MVNETA_BM_EMPTY_LIMIT_MASK);
      ...
  }

Between dma_free_coherent() for one pool's BPPE and the eventual global
STOP, BM hardware still has BASE_REG pointing at the freed phys_addr
with ENABLE_MASK set. Would matching mvneta_bm_remove()'s
"mvneta_bm_pool_destroy() per pool, then global STOP" ordering be safer
here?

[Low]
Resetting bm_pool->type to MVNETA_BM_FREE causes mvneta_bm_pool_use()
to re-enter its initialisation branch on every resume cycle, which
includes:

  mutex_init(&hwbm_pool->buf_lock);

on a struct mutex that was already initialised at first use. Repeated
mutex_init() on a previously-initialised mutex discards lockdep history
for that lock.

Could suspend either call mutex_destroy() on buf_lock to pair the
re-init, or leave bm_pool->type unchanged and only clear the dynamic
state (virt_addr, buf_num) so mvneta_bm_pool_use() does not re-enter
the init branch?

> +
> +static int mvneta_bm_resume(struct device *dev)
> +{
> +	struct mvneta_bm *priv = dev_get_drvdata(dev);
> +	int i, err;
> +
> +	err = clk_prepare_enable(priv->clk);
> +	if (err)
> +		return err;
> +
> +	/* Reinitialize BM hardware; pools are refilled by mvneta_resume() */
> +	mvneta_bm_default_set(priv);
> +
> +	/* Restore pool registers lost during clock gating */
> +	for (i = 0; i < MVNETA_BM_POOLS_NUM; i++) {
> +		mvneta_bm_write(priv, MVNETA_BM_POOL_READ_PTR_REG(i), 0);
> +		mvneta_bm_write(priv, MVNETA_BM_POOL_WRITE_PTR_REG(i), 0);
> +		mvneta_bm_write(priv, MVNETA_BM_POOL_SIZE_REG(i),
> +				priv->bm_pools[i].hwbm_pool.size);
> +	}
> +
> +	mvneta_bm_write(priv, MVNETA_BM_COMMAND_REG, MVNETA_BM_START_MASK);
> +	return 0;
> +}

[Medium]
The comment says "Restore pool registers lost during clock gating", but
the loop only restores SIZE_REG, READ_PTR_REG and WRITE_PTR_REG, and
does not touch MVNETA_BM_POOL_BASE_REG (which carries the BPPE physical
address and the per-pool MVNETA_BM_POOL_ENABLE_MASK).

Combined with mvneta_bm_suspend() not clearing the per-pool ENABLE_MASK
before clk_disable_unprepare(), MVNETA_BM_START_MASK is being written
here with each BASE_REG in an unspecified state.

If the IP retains BASE_REG content across clock gating, BM would be
started with stale BPPE phys_addrs (now freed memory) and ENABLE_MASK
set, until mvneta_resume() drives mvneta_bm_pool_create() to overwrite
BASE_REG.

Could resume explicitly clear each MVNETA_BM_POOL_BASE_REG (or at least
its ENABLE_MASK) before writing START_MASK, or could suspend clear the
per-pool ENABLE_MASK before disabling the clock?

