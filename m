Return-Path: <netdev+bounces-287779-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SE1XMdErBWqJTAIAu9opvQ
	(envelope-from <netdev+bounces-287779-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 03:56:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA0C53CE3C
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 03:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E2E213012873
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 01:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD9731E83E;
	Thu, 14 May 2026 01:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljRMEIK+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169E11C8604;
	Thu, 14 May 2026 01:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778723787; cv=none; b=gELkq4K3crxvxfM9TbbkSZNjETF1GPOQTuLfdCDecQ88J8M3eIZImc+wT9shjhMTUa/6q5EwsJg4fOCTSa5UZyh9EHl64Ga6t+W9YJjIPSz85+3cAUQmgvSsoynq9MbmmZIr+qaiA8Ahy0UcF0XVA4ypU0vj3JbmxlY0g5Wi2mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778723787; c=relaxed/simple;
	bh=HrLduyXI9zCeP3Bd3VdjKvX9x9cVhWtg4uXkRIeD0x4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XDsA+wrq6ri0S2Oe6cxvEALOr/eClDiR1g613Av7CpUNd7GdklY2M1FEZIrXezjJRtD3A+ytzTErg5Obvt39XWCmQtLEwJ3t2l3dkQVGN1qiOIeRnHXoTMI/pOsGq5wyvuftUyBaKnJLycf5w8kbPFoJuceTcgJjx1ee/EGz13s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljRMEIK+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C20C19425;
	Thu, 14 May 2026 01:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778723787;
	bh=HrLduyXI9zCeP3Bd3VdjKvX9x9cVhWtg4uXkRIeD0x4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ljRMEIK+JRdImhbwoQMD9X3z4IDprlGW8c6sKeOIns6dyY05lKnsgAgbNNw3D8vvk
	 qznmWk0XYksZtZTfz5FSNWzmQ4kb2A63Hp5RMOh4E0LtpXRb6F0Yyvla4b60yAaRhB
	 JKHwhKSLHAxnqFsDhvLQ8mhr9cyjEH+cva4Gn21D0AlZqhtQZ3SUCxBCg7eh3W2a9c
	 DX9uzYpjI9rCr4rMWLGM+Q6B2tbn21xTKOw/OLModXaI8+qAHbn2Fv5z1E1s+oRTPZ
	 f7HHXw8KbJvGCmuNnVM3yzKAzEoR8f92yP+QRRlo/G6UO4H2HN2EocheCnNl4Vocwq
	 OsXCwpU3SyCqQ==
Date: Wed, 13 May 2026 18:56:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Russell King <linux@armlinux.org.uk>, Frank Wunderlich
 <frank-w@public-files.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Mason Chang
 <mason-cw.chang@mediatek.com>, Daniel Golle <daniel@makrotopia.org>
Subject: Re: [net-next v8 2/3] net: ethernet: mtk_eth_soc: Add RSS support
Message-ID: <20260513185625.48e69837@kernel.org>
In-Reply-To: <20260509190938.169290-3-linux@fw-web.de>
References: <20260509190938.169290-1-linux@fw-web.de>
	<20260509190938.169290-3-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CBA0C53CE3C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287779-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,collabora.com,armlinux.org.uk,public-files.de,vger.kernel.org,lists.infradead.org,mediatek.com,makrotopia.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sat,  9 May 2026 21:09:31 +0200 Frank Wunderlich wrote:
> From: Mason Chang <mason-cw.chang@mediatek.com>
> 
> Add support for Receive Side Scaling.
> 
> We can adjust SMP affinity with the following command:
> echo [CPU bitmap num] > /proc/irq/[virtual IRQ ID]/smp_affinity,
> with interrupts evenly assigned to 4 CPUs, we were able to measure
> an RX throughput of 7.3Gbps using iperf3 on the MT7988. Further
> optimizations will be carried out in the future.

Would be great to split this up a little more for ease of review.

> +static int mtk_rss_init(struct mtk_eth *eth)
> +{
> +	const struct mtk_soc_data *soc = eth->soc;
> +	const struct mtk_reg_map *reg_map = eth->soc->reg_map;
> +	struct mtk_rss_params *rss_params = &eth->rss_params;

reverse xmas tree should be followed, please fix everywhere in this
submission 

> +	u32 val;
> +	int i;
> +
> +	netdev_rss_key_fill(rss_params->hash_key, MTK_RSS_HASH_KEYSIZE);
> +
> +	for (i = 0; i < MTK_RSS_MAX_INDIRECTION_TABLE; i++)
> +		rss_params->indirection_table[i] = ethtool_rxfh_indir_default(i, eth->soc->rss_num);
> +
> +	if (soc->rx.desc_size == sizeof(struct mtk_rx_dma)) {
> +		/* Set RSS rings to PSE modes */
> +		for (i = 1; i <= MTK_HW_LRO_RING_NUM(eth); i++) {
> +			val = mtk_r32(eth, MTK_LRO_CTRL_DW2_CFG(reg_map, i));
> +			val |= MTK_RING_PSE_MODE;
> +			mtk_w32(eth, val, MTK_LRO_CTRL_DW2_CFG(reg_map, i));
> +		}
> +
> +		/* Enable non-lro multiple rx */
> +		val = mtk_r32(eth, reg_map->pdma.lro_ctrl_dw0);
> +		val |= MTK_NON_LRO_MULTI_EN;
> +		mtk_w32(eth, val, reg_map->pdma.lro_ctrl_dw0);
> +
> +		/* Enable RSS dly int supoort */
> +		val |= MTK_LRO_DLY_INT_EN;
> +		mtk_w32(eth, val, reg_map->pdma.lro_ctrl_dw0);
> +	}
> +
> +	/* Hash Type */
> +	val = mtk_r32(eth, reg_map->pdma.rss_glo_cfg);
> +	val |= MTK_RSS_IPV4_STATIC_HASH;
> +	val |= MTK_RSS_IPV6_STATIC_HASH;
> +	mtk_w32(eth, val, reg_map->pdma.rss_glo_cfg);
> +
> +	/* Hash Key */
> +	for (i = 0; i < MTK_RSS_HASH_KEYSIZE / sizeof(u32); i++)
> +		mtk_w32(eth, rss_params->hash_key[i], MTK_RSS_HASH_KEY_DW(reg_map, i));
> +
> +	/* Select the size of indirection table */
> +	for (i = 0; i < MTK_RSS_MAX_INDIRECTION_TABLE / 16; i++)
> +		mtk_w32(eth, mtk_rss_indr_table(rss_params, i),
> +			MTK_RSS_INDR_TABLE_DW(reg_map, i));
> +
> +	/* Pause */
> +	val |= MTK_RSS_CFG_REQ;
> +	mtk_w32(eth, val, reg_map->pdma.rss_glo_cfg);
> +
> +	/* Enable RSS */
> +	val |= MTK_RSS_EN;
> +	mtk_w32(eth, val, reg_map->pdma.rss_glo_cfg);
> +
> +	/* Release pause */
> +	val &= ~(MTK_RSS_CFG_REQ);
> +	mtk_w32(eth, val, reg_map->pdma.rss_glo_cfg);
> +
> +	/* Set perRSS GRP INT */
> +	mtk_m32(eth, MTK_RX_DONE_INT(eth, MTK_RSS_RING(1)),
> +		MTK_RX_DONE_INT(eth, MTK_RSS_RING(1)), reg_map->pdma.int_grp);
> +	mtk_m32(eth, MTK_RX_DONE_INT(eth, MTK_RSS_RING(2)),
> +		MTK_RX_DONE_INT(eth, MTK_RSS_RING(2)), reg_map->pdma.int_grp + 0x4);
> +	mtk_m32(eth, MTK_RX_DONE_INT(eth, MTK_RSS_RING(3)),
> +		MTK_RX_DONE_INT(eth, MTK_RSS_RING(3)), reg_map->pdma.int_grp3);
> +
> +	return 0;
> +}

> +/* struct mtk_rss_params -	This is the structure holding parameters
> + *				for the RSS ring
> + * @hash_key			The element is used to record the
> + *				secret key for the RSS ring
> + * indirection_table		The element is used to record the
> + *				indirection table for the RSS ring
> + */

Quite odd looking comment. Having the right side aligned like that
makes it header to correlate where doc for fields start.
And there's @ missing for indirection_table.

