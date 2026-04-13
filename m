Return-Path: <netdev+bounces-278229-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPPEEYZ13WngeQkAu9opvQ
	(envelope-from <netdev+bounces-278229-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 01:00:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC583F421F
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 01:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F6C03085A04
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 22:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437E739D6DA;
	Mon, 13 Apr 2026 22:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arl2BT6y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2218739B94F
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 22:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776121032; cv=none; b=BRKNd/6HA2l3prAAuKhrM11phIlYKs5wUpAv3BPc063+uzngSO8Lq6weDLM6JHZ6d065lvSQaz+N1pNWVk8OfBvkMQwjSH8blb+1weT2C0rCNdrughM99MAQSohW3sNl4idR75Lx6XnqZsVZtr9SnwxHxYdvoz0oEIzB2jOYIAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776121032; c=relaxed/simple;
	bh=5lT5VGCSztp5RHHAfbUGBi5lH094ZC7FcPVmm6uwpds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MVXzx+/RR1hJJQnocRD2KUBWOSgRXS4/g/nxYBB9ZXd7BFkjdA9v3f6eLIf7Pu6/9VgPnhTSyw9sCDp29nTZJGX/BGJx8AXFwCpqs/QyLuoeDTpoD0UL/tkEVEhmE0GNjjMqnUlitFHpEy18DSB4nJx3b6mR/Z3QsPvo0ADWm+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arl2BT6y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A729C2BCAF;
	Mon, 13 Apr 2026 22:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776121031;
	bh=5lT5VGCSztp5RHHAfbUGBi5lH094ZC7FcPVmm6uwpds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=arl2BT6yZiJTpZwPUCeVbRRMKP+NidZwRNmQ2AlGT48QeXXkxN0Yw5MeJOwzMShK3
	 l7AZfMBEOlioQTR0cDcv4I/JVBrGdjiwLxx66vH8rPoDFuMWXXha8EbQRFnBvoYqHi
	 DsNPogFzWDwW/9yQj5keuIFnU4nP8uNtNJYV0L5aNbcoaopcjx0V6jfr+q2acfHV2k
	 XnvFqYHgRbYobHy2UG6MoxPkSk2ElXQzVpQOCIi+HdYAlYauMvHRALxeqaeNKgI+IM
	 O4RJz08yayli3h8Tymk7BI7/qMu5hR6PTR7BhAJvHdwPLBqhXp5/nGmSMmYv/IWqZ5
	 vJ7abtUUykARA==
From: Jakub Kicinski <kuba@kernel.org>
To: lorenzo@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: airoha: Add missing bits in airoha_qdma_cleanup_tx_queue()
Date: Mon, 13 Apr 2026 15:57:09 -0700
Message-ID: <20260413225709.3648413-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410-airoha_qdma_cleanup_tx_queue-fix-net-v1-1-b7171c8f1e78@kernel.org>
References: <20260410-airoha_qdma_cleanup_tx_queue-fix-net-v1-1-b7171c8f1e78@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278229-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9FC583F421F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: airoha: Add missing bits in airoha_qdma_cleanup_tx_queue()

This commit resets DMA TX descriptors in airoha_qdma_cleanup_tx_queue
and synchronizes TX_DMA_IDX to TX_CPU_IDX to notify the hardware that
the ring is empty.

> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index 9285a68f435fe..963ab7b8d166b 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -1044,13 +1044,17 @@ static int airoha_qdma_init_tx(struct airoha_qdma *qdma)
[ ... ]
>  	spin_lock_bh(&q->lock);
>  	for (i = 0; i < q->ndesc; i++) {
> -		struct airoha_queue_entry *e = &q->entry[i];
> +		struct airoha_qdma_desc *desc = &q->desc[i];
>  
> +		e = &q->entry[i];

Can this result in a NULL pointer dereference?

If airoha_qdma_init_tx_queue() sets q->ndesc before allocating q->entry and
q->desc, and devm_kzalloc() fails, the error path jumps to
airoha_hw_cleanup().

Because q->ndesc > 0, this cleanup loop would execute and dereference
q->entry[i] and q->desc[i], which may not have been allocated.

[ ... ]
> +		/* Reset DMA descriptor */
> +		WRITE_ONCE(desc->ctrl, 0);
> +		WRITE_ONCE(desc->addr, 0);
> +		WRITE_ONCE(desc->data, 0);
> +		WRITE_ONCE(desc->msg0, 0);
> +		WRITE_ONCE(desc->msg1, 0);
> +		WRITE_ONCE(desc->msg2, 0);

Is it safe to modify these DMA descriptors and reset the ring indices below
without waiting for the hardware DMA engine to become idle?

In airoha_dev_stop(), the driver clears GLOBAL_CFG_TX_DMA_EN_MASK to request
the hardware DMA engine to stop, but it does not appear to poll
GLOBAL_CFG_TX_DMA_BUSY_MASK to ensure it has actually stopped.

Modifying the DMA descriptors and internal ring indices while the hardware
is still actively processing in-flight descriptors could potentially lead
to corrupted DMA fetches or IOMMU faults.

>  		q->queued--;
>  	}
> +
> +	e = list_first_entry(&q->tx_list, struct airoha_queue_entry,
> +			     list);
> +	index = e - q->entry;
> +	/* Set TX_DMA_IDX to TX_CPU_IDX to notify the hw the QDMA TX ring is
> +	 * empty.
> +	 */
> +	airoha_qdma_rmw(qdma, REG_TX_CPU_IDX(qid), TX_RING_CPU_IDX_MASK,
> +			FIELD_PREP(TX_RING_CPU_IDX_MASK, index));
> +	airoha_qdma_rmw(qdma, REG_TX_DMA_IDX(qid), TX_RING_DMA_IDX_MASK,
> +			FIELD_PREP(TX_RING_DMA_IDX_MASK, index));

Could list_first_entry() be called on an empty list here?

If q->tx_list is empty (for example, if allocation failed in
airoha_qdma_init_tx_queue or if no entries had a valid dma_addr), calling
list_first_entry() returns an invalid pointer.

The subsequent pointer arithmetic would produce a garbage index value,
which is then written to the REG_TX_CPU_IDX and REG_TX_DMA_IDX registers.
-- 
pw-bot: cr

