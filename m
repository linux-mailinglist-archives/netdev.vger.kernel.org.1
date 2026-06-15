Return-Path: <netdev+bounces-299404-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wvpCBsbgL2pkIQUAu9opvQ
	(envelope-from <netdev+bounces-299404-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 13:23:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6871E685B2C
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 13:23:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="GVEy0/Tb";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299404-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299404-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B5F6302DA34
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 11:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FF83E44E1;
	Mon, 15 Jun 2026 11:22:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D0B340D90;
	Mon, 15 Jun 2026 11:22:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781522534; cv=none; b=iTqwsCXF0t566DCel7ulKCUq8Q/mFD9cz6iaC3lvDFIX5CtzD4+G64O5QmDzrRqcO+mHriTndPhp+pD/RpExvupTkg4BFvNblGDg66ktzUCwo8JbdA1rQ1XZX88bumgWz5H84I9+sevQ5WL6ss1/loOly0zRMWRhOU7RZdshRao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781522534; c=relaxed/simple;
	bh=/MuDaOiHF9DYQ0To4fpXzkTT9w/BiYVGRh6hDqbgQMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1wN6NOb+sXX2VJm8PDPVGfEAD6q/DKRm9H4jWIc+fn8y1XmvmLn6tH8k8ybzLIcMEJY4S9nivXFsdTqk+i1vFaB7LP7388cB8PlKU4VXLUQjvQvSs/NcNP9HV6aKZI6jn//Y2vSvvJkqtievPQp0jzypD/FJizTHr6D4GOz9nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVEy0/Tb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434421F000E9;
	Mon, 15 Jun 2026 11:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781522532;
	bh=dWu3x3+fKrurpYN/VpyZ05LCbhYa2x74DLFqWmaIIE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GVEy0/Tb2dOviS+hlhbHFbd9rTD0S6QqlTRG1HpCLE5XSNN/VAX4FAkcYc2ugYp/y
	 gjkvEU5/TBn8sWML4BrWzWHPILxx4fj/OvOqeHXBUnnw3T+W0wMdcXQXOLcCG3/17N
	 75ktiJZOc6eZkP9XeNEUxhLjXY7/DnswX/8mvGQx2rFafJiHRqxN6DCv5MTNePE00r
	 aX3aMWTAFMzHqLGQaBhIe86q9Up8lnoIF4cCtcLVgMp0sz0C5CpcfPsbXY46gNEdJj
	 bhL2UVcwU64WpWkVBY2FEp3YlndZbIHlBTUfly5IEN4GTEGGE70o4EXWI8jKbENySq
	 GGclnvpXppB6A==
Date: Mon, 15 Jun 2026 12:22:08 +0100
From: Simon Horman <horms@kernel.org>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: pch_gbe: handle TX skb allocation failure
Message-ID: <20260615112208.GG712698@horms.kernel.org>
References: <20260613080043.873027-1-ruoyuw560@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613080043.873027-1-ruoyuw560@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-299404-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:ruoyuw560@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,horms.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6871E685B2C

On Sat, Jun 13, 2026 at 04:00:43PM +0800, Ruoyu Wang wrote:
> pch_gbe_alloc_tx_buffers() allocates an skb for each TX descriptor and
> then passes the returned pointer to skb_reserve(). If netdev_alloc_skb()
> fails, skb_reserve() dereferences NULL.
> 
> Make pch_gbe_alloc_tx_buffers() return an error when an skb allocation
> fails. On failure while bringing the device up, clean any TX buffers that
> were already allocated and release the RX buffer pool through a shared
> cleanup helper before unwinding the IRQ setup.
> 
> Fixes: 77555ee72282 ("net: Add Gigabit Ethernet driver of Topcliff PCH")
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>

...

> @@ -1887,7 +1902,13 @@ int pch_gbe_up(struct pch_gbe_adapter *adapter)
>  			   "Error: can't bring device up - alloc rx buffers pool failed\n");
>  		goto freeirq;
>  	}
> -	pch_gbe_alloc_tx_buffers(adapter, tx_ring);
> +	err = pch_gbe_alloc_tx_buffers(adapter, tx_ring);
> +	if (err) {
> +		netdev_err(netdev,
> +			   "Error: can't bring device up - alloc tx buffers failed\n");
> +		pch_gbe_clean_tx_ring(adapter, tx_ring);

I think that if pch_gbe_alloc_tx_buffers() fails then
it should handle cleaning up the ring buffer.

IOW, assuming it is safe to call pch_gbe_clean_tx_ring() like this,
I think that call belongs in error handling in pch_gbe_alloc_tx_buffers().

> +		goto freebuf;
> +	}
>  	pch_gbe_alloc_rx_buffers(adapter, rx_ring, rx_ring->count);
>  	adapter->tx_queue_len = netdev->tx_queue_len;
>  	pch_gbe_enable_dma_rx(&adapter->hw);

...

