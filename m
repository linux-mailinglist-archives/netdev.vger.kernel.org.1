Return-Path: <netdev+bounces-269990-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mItmDL2BvWk4+gIAu9opvQ
	(envelope-from <netdev+bounces-269990-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:19:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A439C2DE7BD
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75CD3305466D
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 17:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949B03D16EE;
	Fri, 20 Mar 2026 17:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9Ss9s7D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703523CCFAF;
	Fri, 20 Mar 2026 17:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774026171; cv=none; b=R8RbJtX3Qsqary9xuTACyiut7iSdvGKDCjoMlrPAhJBVsOyWVGfpijsnA+JK+etoJJUKPEYNV8WzpwqlRLRPkRkZD4o1IBLhCCohfc4RLO4niAKa/Cd+5PHcqultVmhcIgxmNqmNHmXqhOdkgfdM7EVOoLFG5jF3D5qSQiwvunE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774026171; c=relaxed/simple;
	bh=qber7/y2QqBzw0f1xqmZcp2//J+ljVH5nJcRiHZcQvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NNo4sKjUZZexUUp/1RBqzssAla4HXlMx7neUjDwsLEcV7ChksBoK5sK2N6JRlAr2XzloctMwUjpGZ3+CSOT9yrY7eLnJ8MpJ6vsUGXezIokPU1lIm7d8OsmwQDcq/TH5cw3F8pzz99+FKQCexYJwCYCniddmzDAwYMMTqkRw6Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9Ss9s7D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB376C4CEF7;
	Fri, 20 Mar 2026 17:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774026171;
	bh=qber7/y2QqBzw0f1xqmZcp2//J+ljVH5nJcRiHZcQvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c9Ss9s7D7vyLINatgZ23WhvvnKTj2Y5Y4bI7p6IBpOFgZAoZ4ssdBSE7JoBDS7s42
	 wdFtVIW3KENkaLUtm3KuWP+hl/i1x1L2XagAWvE1QJ2efhis74AxQ/89IWjxfyIfNG
	 5pnndZM73aOkSCuucqN5+X2Dqw8sRwE8TW6FxTvWlhC4skzHX8JqolWiSnes4m6IxV
	 5L/sVe73G7g0hwenpMs0dfF9HTODe1C4DYP2k+Oof1VBl33IcO2wgxdmWg5Z+uOKx1
	 ra8Sj6vYdIPnRbk9nPT2fhOcCparDwqyt0gdPMHZalvMHdUyny9x47e6Evmjyksaly
	 W9lwfna+vInNQ==
From: Simon Horman <horms@kernel.org>
To: nb@tipi-net.de
Cc: Simon Horman <horms@kernel.org>,
	davem@davemloft.net,
	opendmb@gmail.com,
	john.fastabend@gmail.com,
	florian.fainelli@broadcom.com,
	daniel@iogearbox.net,
	arnd@arndb.de,
	bcm-kernel-feedback-list@broadcom.com,
	vikas.gupta@broadcom.com,
	bhargava.marreddy@broadcom.com,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	sdf@fomichev.me,
	ebiggers@google.com,
	hawk@kernel.org,
	andrew+netdev@lunn.ch,
	bpf@vger.kernel.org,
	pabeni@redhat.com,
	rajashekar.hudumula@broadcom.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/6] net: bcmgenet: add XDP_TX support
Date: Fri, 20 Mar 2026 17:02:33 +0000
Message-ID: <20260320170233.102959-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319115402.353509-5-nb@tipi-net.de>
References: <20260319115402.353509-5-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,gmail.com,broadcom.com,iogearbox.net,arndb.de,vger.kernel.org,google.com,fomichev.me,lunn.ch,redhat.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-269990-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.938];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: A439C2DE7BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: bcmgenet: add XDP_TX support

Implement XDP_TX using ring 16 (DESC_INDEX), the hardware default
descriptor ring, dedicated to XDP TX for isolation from SKB TX queues.
Ring 16 gets 32 BDs carved from ring 0's allocation. TX completion is
piggybacked on RX NAPI poll since ring 16's INTRL2_1 bit collides with
RX ring 0, similar to how bnxt, ice, and other XDP drivers handle TX
completion within the RX poll path.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index e8f90d6b16a2..54df1694f1cd 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -48,8 +48,10 @@
>
>  #define GENET_Q0_RX_BD_CNT	\
>  	(TOTAL_DESC - priv->hw_params->rx_queues * priv->hw_params->rx_bds_per_q)
> +#define GENET_Q16_TX_BD_CNT	64
> +#define GENET_Q0_TX_BD_CNT	\
> -	(TOTAL_DESC - priv->hw_params->tx_queues * priv->hw_params->tx_bds_per_q)
> +	(TOTAL_DESC - priv->hw_params->tx_queues * priv->hw_params->tx_bds_per_q \
> +	 - GENET_Q16_TX_BD_CNT)
>
>  #define RX_BUF_LENGTH		2048
>  #define SKB_ALIGNMENT		32

[ ... ]

> @@ -3022,14 +3158,18 @@ static int bcmgenet_rdma_disable(struct bcmgenet_priv *priv)
>   * with queue 1 being the highest priority queue.
>   *
>   * Queue 0 is the default Tx queue with
> - * GENET_Q0_TX_BD_CNT = 256 - 4 * 32 = 128 descriptors.
> + * GENET_Q0_TX_BD_CNT = 256 - 4 * 32 - 32 = 96 descriptors.
> + *
> + * Ring 16 (DESC_INDEX) is used for XDP TX with
> + * GENET_Q16_TX_BD_CNT = 32 descriptors.
> + *
>   * The transmit control block pool is then partitioned as follows:
> - * - Tx queue 0 uses tx_cbs[0..127]
> - * - Tx queue 1 uses tx_cbs[128..159]
> - * - Tx queue 2 uses tx_cbs[160..191]
> - * - Tx queue 3 uses tx_cbs[192..223]
> - * - Tx queue 4 uses tx_cbs[224..255]
> + * - Tx queue 0 uses tx_cbs[0..95]
> + * - Tx queue 1 uses tx_cbs[96..127]
> + * - Tx queue 2 uses tx_cbs[128..159]
> + * - Tx queue 3 uses tx_cbs[160..191]
> + * - Tx queue 4 uses tx_cbs[192..223]
> + * - Tx ring 16 uses tx_cbs[224..255]
>   */
>  static void bcmgenet_init_tx_queues(struct net_device *dev)
>  {

Does the GENET_Q16_TX_BD_CNT define match the comment?

The comment and the commit message both say "Ring 16 gets 32 BDs," but
the define at the top of the file says:

#define GENET_Q16_TX_BD_CNT	64

The comment math also says "256 - 4 * 32 - 32 = 96" which expects ring
16 to use 32 descriptors, and shows queue 0 getting 96 descriptors
(tx_cbs[0..95]).  But with the define set to 64, queue 0 would actually
get only 64 descriptors (tx_cbs[0..63]) instead of 96:

GENET_Q0_TX_BD_CNT = TOTAL_DESC (256)
                     - priv->hw_params->tx_queues (4) * 32
                     - GENET_Q16_TX_BD_CNT (64)
                   = 256 - 128 - 64
                   = 64

and ring 16 would use tx_cbs[192..255] (64 entries) instead of
tx_cbs[224..255] (32 entries).

All of the intermediate queue ranges in the comment would also be
shifted by 32 entries from what's documented.

Which is correct, the define or the documentation?

