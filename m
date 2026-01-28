Return-Path: <netdev+bounces-254071-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAgQAf9zeWkHxQEAu9opvQ
	(envelope-from <netdev+bounces-254071-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:27:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0F99C3B0
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7670303353C
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 02:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E975829B781;
	Wed, 28 Jan 2026 02:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iL0l/Alk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C614F299931;
	Wed, 28 Jan 2026 02:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769567160; cv=none; b=IOKHeSYXy5t6Lr8O7jfHhiOfrZ7SSiUCkZnrcLZtVZcwemTdmI28fIJvwQw+DLqOZhUe5cFu4vokkVz4B1faGBn4jsm5vCGNMQpLUqO0OPqASFGMiR3//2UNDxI/zD/aORFk0ISzmRdh9kipuOWHn8/IizX+5w8Btm9Rqp3N2z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769567160; c=relaxed/simple;
	bh=Q+EuPQIrMDkumGQDIIroCkKxLufMqB23kQAquVtEFq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gzdJvj4dxm4Vf1ApDSEsnlqy0e12jEu6qJ5OyvaotSrbSwg/UcKCjVu0YhMFPqrAoAb5wxCOwh3uMu6gBgnGVEGVBtZ8xstCJnjZD65QHmFZmgyYVaM+7gTwY76XeOmDeam2ZnbAwZ8w2yNNY571B3PfSgpy8WJ95P1/ierpJJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iL0l/Alk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD74C116C6;
	Wed, 28 Jan 2026 02:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769567160;
	bh=Q+EuPQIrMDkumGQDIIroCkKxLufMqB23kQAquVtEFq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iL0l/Alk/1GYjL6VN8j/jYe67HWVmXuY+ofgPTdFrcTTNYACh63kDrZrJNOvxBAQl
	 5ZLab1ljSqWSkCnVzyfTFYlqxsofkU/A10PuuZBt3ZRlJn5/CQSrbco1NaamcbyOIf
	 z9gZ9bP1nqmvwLm+WgPXasmlom75eBuBmrd5LAuMoOOsFIij3guuA3GFIJKiZZlRwJ
	 xE91JTbm0GzFhu85dyr3Ok+58lUXhW8HuIAwTF8Ex/tMWB8QcoRH3bHGDSINYKW7WZ
	 CxlXADypXwdv1vosUR2zL7wrfFcAY66XTSVpfGxrtklZ81b5sY0R/Rhofc1hrpgrmd
	 6D0heWtJHO4Cw==
From: Jakub Kicinski <kuba@kernel.org>
To: lukasz.majewski@mailbox.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	festevam@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	horms@kernel.org,
	shawnguo@kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	wahrenst@gmx.net,
	pabeni@redhat.com,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	richardcochran@gmail.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	robh@kernel.org,
	krzk+dt@kernel.org,
	andrew@lunn.ch
Subject: Re: [net-next,v20,4/7] net: mtip: Add net_device_ops functions to the L2 switch driver
Date: Tue, 27 Jan 2026 18:25:58 -0800
Message-ID: <20260128022558.4151582-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126103400.1683125-5-lukasz.majewski@mailbox.org>
References: <20260126103400.1683125-5-lukasz.majewski@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254071-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lists.infradead.org,pengutronix.de,lists.linux.dev,vger.kernel.org,gmx.net,redhat.com,davemloft.net,google.com,lunn.ch];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 9F0F99C3B0
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: mtip: Add net_device_ops functions to the L2 switch driver

This patch adds the net_device_ops callback implementations for the MTIP
L2 switch driver including transmit, timeout handling, multicast setup,
MAC address configuration, and port parent ID retrieval.

> diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> index 9c21a3d29c1c..a6424ee1a9d9 100644
> --- a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> +++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c

[ ... ]

> +static netdev_tx_t mtip_start_xmit_port(struct sk_buff *skb,
> +					struct net_device *dev, int port)
> +{

[ ... ]

> +	/* Push the data cache so the CPM does not get stale memory
> +	 * data.
> +	 */
> +	bdp->cbd_bufaddr = dma_map_single(&fep->pdev->dev, bufaddr,
> +					  MTIP_SWITCH_TX_FRSIZE,
> +					  DMA_TO_DEVICE);

The dma_map_single() call here creates a DMA mapping, but mtip_switch_tx()
at this point in the series is an empty stub that never calls
dma_unmap_single(). Is the intention for this to be resolved by a later
patch in the series? Looking ahead, a4c3fa1c66c9 ("net: mtip: Add
mtip_switch_{rx|tx} functions to the L2 switch driver") does add the full
TX completion handler with the dma_unmap_single() call. However, this
commit on its own could cause DMA resource exhaustion if used standalone
(e.g., during bisection).

Would it make sense to merge these two patches together, or at minimum
have a note in the commit message explaining the dependency?

[ ... ]

