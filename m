Return-Path: <netdev+bounces-266948-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BKXNOV/smkcNAAAu9opvQ
	(envelope-from <netdev+bounces-266948-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 09:57:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2318B26F460
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 09:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94D253024512
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 08:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D38538AC93;
	Thu, 12 Mar 2026 08:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="aeYFHgEt"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF1F38AC84;
	Thu, 12 Mar 2026 08:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773305663; cv=none; b=VqjOCefkfkd357irls5/U+pvjR86jcTx0JBXCG6s+fXtmlTQypdwOtN5v2d7C8dCt2Jl0rI1ihyo3DBibPPKMkdXcuId7FHqDIy5XSjqU+vOguYVXBGfZPUOoeKGH77/G06WbDvbEUMfAtc09k1NMngXogfV5eh7ETO+VGmhXnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773305663; c=relaxed/simple;
	bh=GlrPT++KQGjeiawQcqTnhhlsX455IV6grrneho6bqhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDSDHKmSGZ8AuXUC4GOSBSa9BRVp1Zs4RjpJ9BhApunMaTVFgGOumnyBlP+D/qnIypgIO5izsi1003D188jzyrXvKEllfruwaDj8qCUFQuj453NXfG/BCPofwDkFStahLgiDXut7/V3BZL/jyiGPkdBXBX0S8Gql/wsAEcVahHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=aeYFHgEt; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IX9QCS5b6Xn8/dE+/kiOOEMjyLxuCn5DnqDHXAakk1Q=; b=aeYFHgEtYTI5faN/d/LqgD2Dp6
	odc7r897g1zvAU6wvFcuBnivPiYJbIxNehFn3ZKXukEe2Lxlm/YIfB6y71RBd1b1jq/1tcm2ntQmR
	jikwtnBlvs5XmwbNZx+7HZiA62AWry4n2J4zruKOj7swfs9a6L8E1Z0jirq8Gdfwg7PQ3rCw2Rar/
	JGdtsGje6JyAXnBsa2hGg8O8vtb6pesAjYqqcwwsQqYlKNp1QYkcRCTzKay133DvUxElIUtY/we0Q
	FkVmm8WLGj37z1lgPHsrU5chrBFb7nygXNfFR4R3dx3U24Lq9sucIwaAV0lQlE/B3QaJMP/YRmZjX
	hgjfxbpA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51292)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w0bo1-000000007QA-0LuK;
	Thu, 12 Mar 2026 08:54:09 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w0bnx-0000000076N-39Oq;
	Thu, 12 Mar 2026 08:54:05 +0000
Date: Thu, 12 Mar 2026 08:54:05 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next 02/15] net: stmmac: helpers for filling
 tx_q->tx_skbuff_dma
Message-ID: <abJ_Le1xOP6roesb@shell.armlinux.org.uk>
References: <abE7LWj04-JNxgS2@shell.armlinux.org.uk>
 <E1w0GEg-0000000CiSj-2CVA@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1w0GEg-0000000CiSj-2CVA@rmk-PC.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266948-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.861];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:url]
X-Rspamd-Queue-Id: 2318B26F460
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 09:52:14AM +0000, Russell King (Oracle) wrote:
> +static void stmmac_set_tx_dma_entry(struct stmmac_tx_queue *tx_q,
> +				    unsigned int entry,
> +				    enum stmmac_txbuf_type type,
> +				    dma_addr_t addr, size_t len,
> +				    bool map_as_page)
> +{
...
> +	tx_q->tx_skbuff_dma[entry].buf_type = type;
...
> +}
> +
> +static void stmmac_set_tx_skb_dma_entry(struct stmmac_tx_queue *tx_q,
> +					unsigned int entry, dma_addr_t addr,
> +					size_t len, bool map_as_page)
> +{
> +	stmmac_set_tx_dma_entry(tx_q, entry, STMMAC_TXBUF_T_SKB, addr, len,
> +				map_as_page);
> +}

...

> @@ -4471,10 +4495,8 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
>  	 * this DMA buffer right after the DMA engine completely finishes the
>  	 * full buffer transmission.
>  	 */
> -	tx_q->tx_skbuff_dma[tx_q->cur_tx].buf = des;
> -	tx_q->tx_skbuff_dma[tx_q->cur_tx].len = skb_headlen(skb);
> -	tx_q->tx_skbuff_dma[tx_q->cur_tx].map_as_page = false;
> -	tx_q->tx_skbuff_dma[tx_q->cur_tx].buf_type = STMMAC_TXBUF_T_SKB;
> +	stmmac_set_tx_skb_dma_entry(tx_q, tx_q->cur_tx, des, skb_headlen(skb),
> +				    false);

when nfrags is zero, tx_q->tx_skbuff_dma[tx_q->cur_tx].buf_type is set
here.

>  
>  	/* Prepare fragments */
>  	for (i = 0; i < nfrags; i++) {
> @@ -4489,17 +4511,14 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
>  		stmmac_tso_allocator(priv, des, skb_frag_size(frag),
>  				     (i == nfrags - 1), queue);
>  
> -		tx_q->tx_skbuff_dma[tx_q->cur_tx].buf = des;
> -		tx_q->tx_skbuff_dma[tx_q->cur_tx].len = skb_frag_size(frag);
> -		tx_q->tx_skbuff_dma[tx_q->cur_tx].map_as_page = true;
> -		tx_q->tx_skbuff_dma[tx_q->cur_tx].buf_type = STMMAC_TXBUF_T_SKB;
> +		stmmac_set_tx_skb_dma_entry(tx_q, tx_q->cur_tx, des,
> +					    skb_frag_size(frag), true);
>  	}

... and tx_q->cur_tx is not incremented because the loop is not
executed.

>  
> -	tx_q->tx_skbuff_dma[tx_q->cur_tx].last_segment = true;
> +	stmmac_set_tx_dma_last_segment(tx_q, tx_q->cur_tx);
>  
>  	/* Only the last descriptor gets to point to the skb. */
>  	tx_q->tx_skbuff[tx_q->cur_tx] = skb;
> -	tx_q->tx_skbuff_dma[tx_q->cur_tx].buf_type = STMMAC_TXBUF_T_SKB;

Thus this assignment of tx_q->tx_skbuff_dma[tx_q->cur_tx].buf_type is
redundant. As the loop doesn't execute any code in the nfrags=0 case,
there is no call to stmmac_tso_allocator(), and thus tx_q->cur_tx will
be the same as when the previous stmmac_set_tx_skb_dma_entry() was
called.

Therefore, the AI review is incorrect.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

