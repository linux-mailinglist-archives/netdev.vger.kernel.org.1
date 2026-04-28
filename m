Return-Path: <netdev+bounces-281786-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDCBFbyO8Gl4UwEAu9opvQ
	(envelope-from <netdev+bounces-281786-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:41:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4D5482CCC
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5220302E7DA
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 10:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA023F0A85;
	Tue, 28 Apr 2026 10:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7FKjram";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YUPMIjNw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1793EF0B3
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 10:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777372848; cv=none; b=bzGjNZrSgxlRS9mwceVYyK1FATQVDTB8onA3b1FEjiRfvxjXY3p55wcT8EiT/Fdgwy2E4RJq+3InWWJK3grqCeSLwQ2OXWGZp5Ql5RZOvi94/DjfWCZDXJNUQd47SlxT6qcTlPeKX8DtjbGOLBBlL1xh9Ilm3vh3D95u/dAsd8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777372848; c=relaxed/simple;
	bh=OFBgm8XUDkEL5Bv4Gk0Ry/UqQdSKBfFUMEYOVspYCzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SQO/xzMsZfpQNYee1BMbr/RBCGXnP8rGO/xRp1w1tBe1dbMMp87Yl9AQ9bjQ/viuBHOUDbX7gK6ag0ttJ0Q9vPBnC3E385X6ONtPvVBjygTV1vZ+KFB4DxoSrtO4Gcnb71enRmT0e4RUfwMrc+OwxZo9Bp3ZOFsjVKMS4CDqTLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L7FKjram; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YUPMIjNw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777372845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7gA47fGzFrwfbeRQhPiDfBesIkKjWe3OMqniZMXkZ4A=;
	b=L7FKjramA3TEn7UZwClLnVgL66TDxVGAK7AqUYQCLIt5eLxwSUN6Oz2zH9fFj+DvHPKHDz
	BsUFAkIaR/BPc51fuF3sUWHy4ElJ+L+ljMD5XVz6Fg/NQofLo5Z7DNLYNIxezrvOp0pHIe
	MagducDfb38dlg0cWdaJPXqG5CGBuxQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-WDY2se68OPuDDtoeE4DX_Q-1; Tue, 28 Apr 2026 06:40:44 -0400
X-MC-Unique: WDY2se68OPuDDtoeE4DX_Q-1
X-Mimecast-MFC-AGG-ID: WDY2se68OPuDDtoeE4DX_Q_1777372843
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8acdd800537so207164356d6.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 03:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777372843; x=1777977643; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7gA47fGzFrwfbeRQhPiDfBesIkKjWe3OMqniZMXkZ4A=;
        b=YUPMIjNwsdqRSl8x72jxxFrkIteqZr1IhkLvPneYZTtYo8wHcfwYtHXXgB7BiIo65a
         r3YJVNzqXiP5ff0cLaU5+aXSM5bdn+zq+Yi9Vht9QymjNFDj4uunY52/crys2C6L4Ha4
         f0ExYbn4LZsEsqE/8wQQj2MgtO0ymn2UjUm6VV+CdGAqg1By97G7a+WjRxDdi1GEhLKw
         paoPYiMZBJIUxjKDRNnLIZNGCelRx+vUvfrCh1NwSvJfgRk581lZg6QauftT1fNHunK/
         jc8CFw7t1VehuhMUs1MDahv4wdD+AMX1wFH1YIC2rtlI5cy/f7dJhLlUlcn1vx8oot+x
         GyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777372843; x=1777977643;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7gA47fGzFrwfbeRQhPiDfBesIkKjWe3OMqniZMXkZ4A=;
        b=GXxtqUTFt5z4F3DGbGlvCidMc26GLR0IabYBFhKoXigkNtAC9no89ByyZSN6M39jwM
         pZmGY+BAuhAUl183kwil/djM84VzXsZO0QHQwHw8v6pUo6DGOTem7v4koztwMsveC0j8
         OrEZRaccwDCPV7sYXzkYkIKRzyiro+cxCj4Jbkhpq3pw4895RZAVK8GKd7R2shmwxwy7
         mTVUEF5Gfr/7anQxVgA+CYxdogBVq183Oz6ELxKtPhG5BzNgnbtW2mO5XeTrmvNpld/5
         NbLFbCtXnKmZRX0gVxOIa+7YGsOgjYM4Fb9w/7uoIYCjhDyk6rG5awdHudfbGIkZuEKo
         zx1w==
X-Forwarded-Encrypted: i=1; AFNElJ+s6pf5uPNhqAkLzUAnKI7XHJH5OqQWJR7smENmMDnr2rWRp3L/s6vG5/IiD4bqyCHjJYm0Rrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YymEGUn5os/n4C1l2lBDLnZvKJgBB1L/lH183HyPLxRtCt/U5PX
	4yks72REDGNk8LAmPx9IIJUyNSZuW0OP38Wa7AzzCUrtq6DKY6NNnOXLkXC8LBab28Kl0JIvtpf
	VtDty9Eb4JT5m/0gXCIF8NiMPey7WvUQu+2gWiVR/0f4mJySDVBfaGZR22Q==
X-Gm-Gg: AeBDievQR4VlgEBaG74UXNkKPdxzxdd+lFQ1RDJmqLfGJu+LzCA7hLBtIP/Nrp0ZRZ1
	/JukHm2nJYALBeF88UtCTjtvRxHLaDXmC60jde0ye42P03v/alATQOOPpG0t7I1UQ1veTzO+Dpb
	T2wiz4SemY+DTaV34QzbsV3AiSSon1DZgC9nUb797lAcmAceh18yfREZQbitmUf6uwZP+eaxTj2
	wN8e8zMQHNocDFBC9EtzLhIyd+kD+MnFtU4EbkHUHn+lMP+s4IAwdFIUuaA+IXFD1f0ccbOvbJI
	wOd2SKt/6OkzsqoMJEpTJRHcFcqQlBkCUc/xeiEU50dUPy3e/lrXzWdSuioYnsGIBUy8X+WS9zV
	LqLKWw27KbskRPxUxTOxQwQZAERFcdBsUkVY+gwP0nPNBxpgkYPfhthQsDMzRkkeiXQ==
X-Received: by 2002:a05:6214:2404:b0:8ac:b677:c3fc with SMTP id 6a1803df08f44-8b3e31dd1f2mr40510616d6.51.1777372843287;
        Tue, 28 Apr 2026 03:40:43 -0700 (PDT)
X-Received: by 2002:a05:6214:2404:b0:8ac:b677:c3fc with SMTP id 6a1803df08f44-8b3e31dd1f2mr40510006d6.51.1777372842607;
        Tue, 28 Apr 2026 03:40:42 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.114])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b3e2811b1fsm17395116d6.10.2026.04.28.03.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 03:40:42 -0700 (PDT)
Message-ID: <1db7e764-1485-422b-8b68-b45b18f492b2@redhat.com>
Date: Tue, 28 Apr 2026 12:40:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v6] net: stmmac: Prevent NULL deref when RX memory
 exhausted
To: Sam Edwards <cfsworks@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Baruch Siach <baruch@tkos.co.il>,
 Serge Semin <fancer.lancer@gmail.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Russell King <linux@armlinux.org.uk>
References: <20260422044503.5349-1-CFSworks@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260422044503.5349-1-CFSworks@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CC4D5482CCC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281786-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,renesas.com,nxp.com,tkos.co.il,st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On 4/22/26 6:45 AM, Sam Edwards wrote:
> The CPU receives frames from the MAC through conventional DMA: the CPU
> allocates buffers for the MAC, then the MAC fills them and returns
> ownership to the CPU. For each hardware RX queue, the CPU and MAC
> coordinate through a shared ring array of DMA descriptors: one
> descriptor per DMA buffer. Each descriptor includes the buffer's
> physical address and a status flag ("OWN") indicating which side owns
> the buffer: OWN=0 for CPU, OWN=1 for MAC. The CPU is only allowed to set
> the flag and the MAC is only allowed to clear it, and both must move
> through the ring in sequence: thus the ring is used for both
> "submissions" and "completions."
> 
> In the stmmac driver, stmmac_rx() bookmarks its position in the ring
> with the `cur_rx` index. The main receive loop in that function checks
> for rx_descs[cur_rx].own=0, gives the corresponding buffer to the
> network stack (NULLing the pointer), and increments `cur_rx` modulo the
> ring size. After the loop exits, stmmac_rx_refill(), which bookmarks its
> position with `dirty_rx`, allocates fresh buffers and rearms the
> descriptors (setting OWN=1). If it fails any allocation, it simply stops
> early (leaving OWN=0) and will retry where it left off when next called.
> 
> This means descriptors have a three-stage lifecycle (terms my own):
> - `empty` (OWN=1, buffer valid)
> - `full` (OWN=0, buffer valid and populated)
> - `dirty` (OWN=0, buffer NULL)
> 
> But because stmmac_rx() only checks OWN, it confuses `full`/`dirty`. In
> the past (see 'Fixes:'), there was a bug where the loop could cycle
> `cur_rx` all the way back to the first descriptor it dirtied, resulting
> in a NULL dereference when mistaken for `full`. The aforementioned
> commit resolved that *specific* failure by capping the loop's iteration
> limit at `dma_rx_size - 1`, but this is only a partial fix: if the
> previous stmmac_rx_refill() didn't complete, then there are leftover
> `dirty` descriptors that the loop might encounter without needing to
> cycle fully around. The current code therefore panics (see 'Closes:')
> when stmmac_rx_refill() is memory-starved long enough for `cur_rx` to
> catch up to `dirty_rx`.
> 
> Fix this by explicitly checking, before advancing `cur_rx`, if the next
> entry is dirty; exit the loop if so. This prevents processing of the
> final, used descriptor until stmmac_rx_refill() succeeds, but
> fully prevents the `cur_rx == dirty_rx` ambiguity as the previous bugfix
> intended: so remove the clamp as well. Since stmmac_rx_zc() is a
> copy-paste-and-tweak of stmmac_rx() and the code structure is identical,
> any fix to stmmac_rx() will also need a corresponding fix for
> stmmac_rx_zc(). Therefore, apply the same check there.
> 
> In stmmac_rx() (not stmmac_rx_zc()), a related bug remains: after the
> MAC sets OWN=0 on the final descriptor, it will be unable to send any
> further DMA-complete IRQs until it's given more `empty` descriptors.
> Currently, the driver simply *hopes* that the next stmmac_rx_refill()
> succeeds, risking an indefinite stall of the receive process if not. But
> this is not a regression, so it can be addressed in a future change.
> 
> Fixes: b6cb4541853c7 ("net: stmmac: avoid rx queue overrun")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221010
> Cc: stable@vger.kernel.org
> Suggested-by: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> ---
> 
> This is v6 of [1], which was itself split out of [2]. This patch prevents a
> NULL dereference in the stmmac receive path, and (at Russell's suggestion) in
> the zero-copy path as well.
> 
> The approach is different from the previous version and checks the dirty_rx
> index in the loop proper, copied directly from Russell's suggestion [3]. Parts
> of the commit message also use his phrasing. For these reasons he is credited
> with `Suggested-by`.
> 
> The commit message now acknowledges the pipeline stall that can occur in case
> of failure of the next stmmac_rx_refill() after the MAC consumes the final
> descriptor. I still intend to fix that bug when I can find the time to finish
> investigating and implement the timer as requested by Jakub, however I'm
> sending this patch now to resolve the outright _panic_ and simplify review.
> The stmmac_rx_zc() path is not affected by this stall.
> 
> [1] https://lore.kernel.org/netdev/20260415023947.7627-1-CFSworks@gmail.com/
> [2] https://lore.kernel.org/netdev/20260401041929.12392-1-CFSworks@gmail.com/
> [3] https://lore.kernel.org/netdev/ad-LAB08-_rpmMzK@shell.armlinux.org.uk/
> 
> ---
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index ca68248dbc78..3591755ea30b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5549,9 +5549,12 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
>  			break;
>  
>  		/* Prefetch the next RX descriptor */
> -		rx_q->cur_rx = STMMAC_NEXT_ENTRY(rx_q->cur_rx,
> -						priv->dma_conf.dma_rx_size);
> -		next_entry = rx_q->cur_rx;
> +		next_entry = STMMAC_NEXT_ENTRY(rx_q->cur_rx,
> +					       priv->dma_conf.dma_rx_size);
> +		if (unlikely(next_entry == rx_q->dirty_rx))
> +			break;

Sashiko notes that breaking the loop of DMA descriptors owned by the CPU
may cause double accounting for the ingress stats by stmmac_rx_status().

AFAICS that is not a regression, as the existing later XDP check already
does the same, so I think that problem should be addressed separately.

/P


